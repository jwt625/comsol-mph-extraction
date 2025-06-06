function out = model
%
% hartmann_boundary_layer.m
%
% Model exported on May 26 2025, 21:24 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/ACDC_Module/Electromagnetics_and_Fluids');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 2);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.physics.create('mf', 'InductionCurrents', 'geom1');
model.physics('mf').model('comp1');
model.physics('mf').prop('d').set('d', '1[m]');
model.physics('mf').create('alf1', 'AmperesLawFluid');
model.physics('mf').feature('alf1').selection.all;
model.physics.create('spf', 'LaminarFlow', 'geom1');
model.physics('spf').model('comp1');

model.multiphysics.create('mhd1', 'Magnetohydrodynamics', 'geom1', 2);
model.multiphysics('mhd1').set('EMForce_physics', 'mf');
model.multiphysics('mhd1').set('FluidFlow_physics', 'spf');
model.multiphysics('mhd1').selection.all;

model.study.create('std1');
model.study('std1').create('stat', 'Stationary');
model.study('std1').feature('stat').setSolveFor('/physics/mf', true);
model.study('std1').feature('stat').setSolveFor('/physics/spf', true);
model.study('std1').feature('stat').setSolveFor('/multiphysics/mhd1', true);

model.param.set('Ha', '10');
model.param.descr('Ha', 'Hartmann number');
model.param.set('d', '1[cm]');
model.param.descr('d', 'Half-distance between plates');
model.param.set('dens', '1000[kg/m^3]');
model.param.descr('dens', 'Fluid density');
model.param.set('sigma0', '1e7[S/m]');
model.param.descr('sigma0', 'Fluid electrical conductivity');
model.param.set('visc', '1e-3[Pa*s]');
model.param.descr('visc', 'Fluid viscosity');
model.param.set('U0', '0.05[m/s]');
model.param.descr('U0', 'Average Inlet velocity');
model.param.set('H0', 'Ha/mu0_const/d/sqrt(sigma0/visc)');
model.param.descr('H0', 'Imposed magnetic field');
model.param.set('B0', 'mu0_const*H0');
model.param.descr('B0', 'Magnetic flux density');
model.param.set('Re', 'dens*U0*2*d/visc');
model.param.descr('Re', 'Reynolds number');
model.param.set('Exx', '-mu0_const*H0*U0');
model.param.descr('Exx', 'Induced electric field');
model.param.set('J0', 'sigma0*Exx');
model.param.descr('J0', 'Induced electric current density');

model.func.create('an1', 'Analytic');
model.func('an1').label('Velocity profile');
model.func('an1').set('funcname', 'an_U');
model.func('an1').set('expr', '(cosh(Ha)-cosh(Ha*Y))/(cosh(Ha)-1/Ha*sinh(Ha))');
model.func('an1').set('args', 'Ha, Y');
model.func('an1').setIndex('plotargs', 20, 0, 1);
model.func('an1').setIndex('plotargs', 20, 0, 2);
model.func('an1').setIndex('plotargs', -1, 1, 1);

model.geom('geom1').create('r1', 'Rectangle');
model.geom('geom1').feature('r1').set('size', {'80*d' '2*d'});
model.geom('geom1').feature('r1').set('pos', {'0' '-d'});
model.geom('geom1').run('fin');

model.material.create('mat1', 'Common', 'comp1');
model.material('mat1').label('Fluid');
model.material('mat1').propertyGroup('def').set('relpermeability', {'1'});
model.material('mat1').propertyGroup('def').set('electricconductivity', {'sigma0'});
model.material('mat1').propertyGroup('def').set('relpermittivity', {'1'});
model.material('mat1').propertyGroup('def').set('density', {'dens'});
model.material('mat1').propertyGroup('def').set('dynamicviscosity', {'visc'});

model.physics('spf').create('inl1', 'InletBoundary', 1);
model.physics('spf').feature('inl1').selection.set([1]);
model.physics('spf').feature('inl1').set('BoundaryCondition', 'FullyDevelopedFlow');
model.physics('spf').feature('inl1').set('multipleInlets', false);
model.physics('spf').feature('inl1').set('Uavfdf', 'U0');
model.physics('spf').create('out1', 'OutletBoundary', 1);
model.physics('spf').feature('out1').selection.set([4]);
model.physics('mf').prop('BackgroundField').set('SolveFor', 'ReducedField');
model.physics('mf').prop('BackgroundField').set('BackgroundFieldType', 'Bb');
model.physics('mf').prop('BackgroundField').set('Bb', {'0' 'B0' '0'});
model.physics('mf').create('exvp1', 'ExternalMagneticVectorPotential', 1);
model.physics('mf').feature('exvp1').selection.set([1 2 3 4]);

model.mesh('mesh1').create('map1', 'Map');
model.mesh('mesh1').feature('map1').create('dis1', 'Distribution');
model.mesh('mesh1').feature('map1').create('size1', 'Size');
model.mesh('mesh1').feature('map1').feature('dis1').selection.set([1 4]);
model.mesh('mesh1').feature('map1').feature('dis1').set('type', 'predefined');
model.mesh('mesh1').feature('map1').feature('dis1').set('elemcount', 50);
model.mesh('mesh1').feature('map1').feature('dis1').set('elemratio', 20);
model.mesh('mesh1').feature('map1').feature('dis1').set('symmetric', true);
model.mesh('mesh1').feature('map1').feature('size1').set('custom', true);
model.mesh('mesh1').feature('map1').feature('size1').set('hmaxactive', true);
model.mesh('mesh1').feature('map1').feature('size1').set('hmax', 'd');
model.mesh('mesh1').run('map1');

model.study('std1').feature('stat').set('useparam', true);
model.study('std1').feature('stat').setIndex('pname', 'Ha', 0);
model.study('std1').feature('stat').setIndex('plistarr', '', 0);
model.study('std1').feature('stat').setIndex('punit', '', 0);
model.study('std1').feature('stat').setIndex('pname', 'Ha', 0);
model.study('std1').feature('stat').setIndex('plistarr', '', 0);
model.study('std1').feature('stat').setIndex('punit', '', 0);
model.study('std1').feature('stat').setIndex('plistarr', '1 10 100', 0);

model.sol.create('sol1');

model.mesh('mesh1').stat.selection.geom(2);
model.mesh('mesh1').stat.selection.set([1]);

model.sol('sol1').study('std1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'stat');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').set('control', 'stat');
model.sol('sol1').create('s1', 'Stationary');
model.sol('sol1').feature('s1').create('p1', 'Parametric');
model.sol('sol1').feature('s1').feature.remove('pDef');
model.sol('sol1').feature('s1').feature('p1').set('control', 'stat');
model.sol('sol1').feature('s1').set('control', 'stat');
model.sol('sol1').feature('s1').feature('aDef').set('cachepattern', true);
model.sol('sol1').feature('s1').create('seDef', 'Segregated');
model.sol('sol1').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('s1').feature('fc1').set('dtech', 'auto');
model.sol('sol1').feature('s1').feature('fc1').set('maxiter', 100);
model.sol('sol1').feature('s1').feature('fc1').set('initstep', 0.01);
model.sol('sol1').feature('s1').feature('fc1').set('minstep', 1.0E-4);
model.sol('sol1').feature('s1').create('d1', 'Direct');
model.sol('sol1').feature('s1').feature('d1').label('Direct (Merged)');
model.sol('sol1').feature('s1').create('i1', 'Iterative');
model.sol('sol1').feature('s1').feature('i1').set('linsolver', 'gmres');
model.sol('sol1').feature('s1').feature('i1').set('prefuntype', 'left');
model.sol('sol1').feature('s1').feature('i1').set('itrestart', 50);
model.sol('sol1').feature('s1').feature('i1').set('rhob', 20);
model.sol('sol1').feature('s1').feature('i1').set('maxlinit', 1000);
model.sol('sol1').feature('s1').feature('i1').set('nlinnormuse', 'on');
model.sol('sol1').feature('s1').feature('i1').label('AMG, fluid flow variables (spf)');
model.sol('sol1').feature('s1').feature('i1').create('mg1', 'Multigrid');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').set('prefun', 'saamg');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').set('mgcycle', 'v');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').set('maxcoarsedof', 80000);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').set('strconn', 0.02);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').set('nullspace', 'constant');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').set('usesmooth', false);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').set('saamgcompwise', true);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').set('loweramg', true);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').set('compactaggregation', false);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('pr').create('sc1', 'SCGS');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('pr').feature('sc1').set('linesweeptype', 'ssor');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('pr').feature('sc1').set('iter', 0);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('pr').feature('sc1').set('scgsrelax', 0.7);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('pr').feature('sc1').set('scgsmethod', 'lines');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('pr').feature('sc1').set('scgsvertexrelax', 0.7);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('pr').feature('sc1').set('relax', 0.5);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('pr').feature('sc1').set('vankavarsactive', 'on');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('pr').feature('sc1').set('vankavars', {'comp1_spf_inl1_Pinlfdf'});
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('pr').feature('sc1').set('scgssolv', 'stored');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('pr').feature('sc1').set('approxscgs', true);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('pr').feature('sc1').set('scgsdirectmaxsize', 1000);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('po').create('sc1', 'SCGS');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('po').feature('sc1').set('linesweeptype', 'ssor');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('po').feature('sc1').set('iter', 1);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('po').feature('sc1').set('scgsrelax', 0.7);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('po').feature('sc1').set('scgsmethod', 'lines');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('po').feature('sc1').set('scgsvertexrelax', 0.7);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('po').feature('sc1').set('relax', 0.5);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('po').feature('sc1').set('vankavarsactive', 'on');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('po').feature('sc1').set('vankavars', {'comp1_spf_inl1_Pinlfdf'});
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('po').feature('sc1').set('scgssolv', 'stored');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('po').feature('sc1').set('approxscgs', true);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('po').feature('sc1').set('scgsdirectmaxsize', 1000);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('cs').create('d1', 'Direct');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('cs').feature('d1').set('linsolver', 'pardiso');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('cs').feature('d1').set('pivotperturb', 1.0E-13);
model.sol('sol1').feature('s1').feature('fc1').set('linsolver', 'd1');
model.sol('sol1').feature('s1').feature('fc1').set('dtech', 'auto');
model.sol('sol1').feature('s1').feature('fc1').set('maxiter', 100);
model.sol('sol1').feature('s1').feature('fc1').set('initstep', 0.01);
model.sol('sol1').feature('s1').feature('fc1').set('minstep', 1.0E-4);
model.sol('sol1').feature('s1').feature.remove('fcDef');
model.sol('sol1').feature('s1').feature.remove('seDef');
model.sol('sol1').attach('std1');
model.sol('sol1').runAll;

model.result.create('pg1', 'PlotGroup2D');
model.result('pg1').label('Magnetic Flux Density Norm (mf)');
model.result('pg1').set('frametype', 'spatial');
model.result('pg1').set('showlegendsmaxmin', true);
model.result('pg1').set('data', 'dset1');
model.result('pg1').setIndex('looplevel', 3, 0);
model.result('pg1').set('defaultPlotID', 'InterfaceComponents/PlotDefaults/icom6/pdef1/pcond2/pcond2/pg1');
model.result('pg1').feature.create('surf1', 'Surface');
model.result('pg1').feature('surf1').set('showsolutionparams', 'on');
model.result('pg1').feature('surf1').set('solutionparams', 'parent');
model.result('pg1').feature('surf1').set('colortable', 'Prism');
model.result('pg1').feature('surf1').set('colortabletrans', 'nonlinear');
model.result('pg1').feature('surf1').set('colorcalibration', -0.8);
model.result('pg1').feature('surf1').set('showsolutionparams', 'on');
model.result('pg1').feature('surf1').set('data', 'parent');
model.result('pg1').feature.create('str1', 'Streamline');
model.result('pg1').feature('str1').set('showsolutionparams', 'on');
model.result('pg1').feature('str1').set('solutionparams', 'parent');
model.result('pg1').feature('str1').set('titletype', 'none');
model.result('pg1').feature('str1').set('posmethod', 'uniform');
model.result('pg1').feature('str1').set('udist', 0.03);
model.result('pg1').feature('str1').set('maxlen', 0.4);
model.result('pg1').feature('str1').set('maxtime', Inf);
model.result('pg1').feature('str1').set('inheritcolor', false);
model.result('pg1').feature('str1').set('showsolutionparams', 'on');
model.result('pg1').feature('str1').set('maxtime', Inf);
model.result('pg1').feature('str1').set('showsolutionparams', 'on');
model.result('pg1').feature('str1').set('maxtime', Inf);
model.result('pg1').feature('str1').set('showsolutionparams', 'on');
model.result('pg1').feature('str1').set('maxtime', Inf);
model.result('pg1').feature('str1').set('showsolutionparams', 'on');
model.result('pg1').feature('str1').set('maxtime', Inf);
model.result('pg1').feature('str1').set('data', 'parent');
model.result('pg1').feature('str1').selection.geom('geom1', 1);
model.result('pg1').feature('str1').selection.set([1 2 3 4]);
model.result('pg1').feature('str1').set('inheritplot', 'surf1');
model.result('pg1').feature('str1').feature.create('col1', 'Color');
model.result('pg1').feature('str1').feature('col1').set('colortable', 'PrismDark');
model.result('pg1').feature('str1').feature('col1').set('colorlegend', false);
model.result('pg1').feature('str1').feature('col1').set('colortabletrans', 'nonlinear');
model.result('pg1').feature('str1').feature('col1').set('colorcalibration', -0.8);
model.result('pg1').feature('str1').feature.create('filt1', 'Filter');
model.result('pg1').feature('str1').feature('filt1').set('expr', '!isScalingSystemDomain');
model.result('pg1').feature.create('con1', 'Contour');
model.result('pg1').feature('con1').set('showsolutionparams', 'on');
model.result('pg1').feature('con1').set('solutionparams', 'parent');
model.result('pg1').feature('con1').set('expr', 'mf.Az');
model.result('pg1').feature('con1').set('titletype', 'none');
model.result('pg1').feature('con1').set('number', 10);
model.result('pg1').feature('con1').set('levelrounding', false);
model.result('pg1').feature('con1').set('coloring', 'uniform');
model.result('pg1').feature('con1').set('colorlegend', false);
model.result('pg1').feature('con1').set('color', 'custom');
model.result('pg1').feature('con1').set('customcolor', [0.3764705955982208 0.3764705955982208 0.3764705955982208]);
model.result('pg1').feature('con1').set('resolution', 'fine');
model.result('pg1').feature('con1').set('inheritcolor', false);
model.result('pg1').feature('con1').set('showsolutionparams', 'on');
model.result('pg1').feature('con1').set('data', 'parent');
model.result('pg1').feature('con1').set('inheritplot', 'surf1');
model.result('pg1').feature('con1').feature.create('filt1', 'Filter');
model.result('pg1').feature('con1').feature('filt1').set('expr', '!isScalingSystemDomain');
model.result.dataset('dset1').set('geom', 'geom1');
model.result.create('pg2', 'PlotGroup2D');
model.result('pg2').label('Velocity (spf)');
model.result('pg2').set('frametype', 'spatial');
model.result('pg2').set('data', 'dset1');
model.result('pg2').setIndex('looplevel', 3, 0);
model.result('pg2').set('defaultPlotID', 'ResultDefaults_SinglePhaseFlow/icom1/pdef1/pcond1/pg1');
model.result('pg2').feature.create('surf1', 'Surface');
model.result('pg2').feature('surf1').label('Surface');
model.result('pg2').feature('surf1').set('showsolutionparams', 'on');
model.result('pg2').feature('surf1').set('expr', 'spf.U');
model.result('pg2').feature('surf1').set('smooth', 'internal');
model.result('pg2').feature('surf1').set('showsolutionparams', 'on');
model.result('pg2').feature('surf1').set('data', 'parent');
model.result.create('pg3', 'PlotGroup2D');
model.result('pg3').label('Pressure (spf)');
model.result('pg3').set('frametype', 'spatial');
model.result('pg3').set('data', 'dset1');
model.result('pg3').setIndex('looplevel', 3, 0);
model.result('pg3').set('defaultPlotID', 'ResultDefaults_SinglePhaseFlow/icom1/pdef1/pcond1/pg2');
model.result('pg3').feature.create('con1', 'Contour');
model.result('pg3').feature('con1').label('Contour');
model.result('pg3').feature('con1').set('showsolutionparams', 'on');
model.result('pg3').feature('con1').set('expr', 'p');
model.result('pg3').feature('con1').set('number', 40);
model.result('pg3').feature('con1').set('levelrounding', false);
model.result('pg3').feature('con1').set('smooth', 'internal');
model.result('pg3').feature('con1').set('showsolutionparams', 'on');
model.result('pg3').feature('con1').set('data', 'parent');
model.result('pg1').run;
model.result('pg1').run;
model.result('pg1').feature('str1').set('udist', 0.015);
model.result('pg1').run;
model.result('pg2').run;
model.result('pg2').setIndex('looplevel', 1, 0);
model.result('pg2').run;
model.result('pg3').run;
model.result('pg3').run;
model.result('pg3').feature('con1').active(false);
model.result('pg3').run;
model.result('pg3').create('surf1', 'Surface');
model.result('pg3').feature('surf1').set('expr', 'p');
model.result('pg3').feature('surf1').set('descr', 'Pressure');
model.result('pg3').run;
model.result('pg3').run;
model.result('pg3').setIndex('looplevel', 1, 0);
model.result('pg3').run;
model.result('pg1').run;
model.result.dataset.create('cln1', 'CutLine2D');
model.result.dataset('cln1').label('Longitudinal section');
model.result.dataset('cln1').setIndex('genpoints', '80*d', 1, 0);
model.result.dataset.create('cln2', 'CutLine2D');
model.result.dataset('cln2').setIndex('genpoints', '70*d', 0, 0);
model.result.dataset('cln2').setIndex('genpoints', '-d', 0, 1);
model.result.dataset('cln2').setIndex('genpoints', '70*d', 1, 0);
model.result.dataset('cln2').setIndex('genpoints', 'd', 1, 1);
model.result.dataset('cln2').label('Cross section');
model.result.create('pg4', 'PlotGroup1D');
model.result('pg4').run;
model.result('pg4').label('Normalized velocity on the center line');
model.result('pg4').set('data', 'cln1');
model.result('pg4').set('xlabelactive', true);
model.result('pg4').set('xlabel', 'x/d');
model.result('pg4').set('ylabelactive', true);
model.result('pg4').set('ylabel', 'u/U0');
model.result('pg4').create('lngr1', 'LineGraph');
model.result('pg4').feature('lngr1').set('markerpos', 'datapoints');
model.result('pg4').feature('lngr1').set('linewidth', 'preference');
model.result('pg4').feature('lngr1').set('data', 'cln1');
model.result('pg4').feature('lngr1').set('expr', 'u/U0');
model.result('pg4').feature('lngr1').set('xdata', 'expr');
model.result('pg4').feature('lngr1').set('xdataexpr', 'x/d');
model.result('pg4').feature('lngr1').set('legend', true);
model.result('pg4').feature('lngr1').set('legendprefix', 'Ha = ');
model.result('pg4').feature('lngr1').set('titletype', 'none');
model.result.create('pg5', 'PlotGroup1D');
model.result('pg5').run;
model.result('pg5').label('Normalized velocity profiles');
model.result('pg5').set('data', 'cln2');
model.result('pg5').set('xlabelactive', true);
model.result('pg5').set('ylabelactive', true);
model.result('pg5').set('xlabel', 'y/d');
model.result('pg5').set('ylabel', 'u/U0');
model.result('pg5').set('legendpos', 'lowermiddle');
model.result('pg5').create('lngr1', 'LineGraph');
model.result('pg5').feature('lngr1').set('markerpos', 'datapoints');
model.result('pg5').feature('lngr1').set('linewidth', 'preference');
model.result('pg5').feature('lngr1').set('expr', 'u/U0');
model.result('pg5').feature('lngr1').set('xdata', 'expr');
model.result('pg5').feature('lngr1').set('xdataexpr', 'y/d');
model.result('pg5').feature('lngr1').set('legend', true);
model.result('pg5').feature('lngr1').set('legendprefix', 'Ha = ');
model.result('pg5').feature('lngr1').set('titletype', 'none');
model.result('pg5').run;
model.result('pg5').create('lngr2', 'LineGraph');
model.result('pg5').feature('lngr2').set('markerpos', 'datapoints');
model.result('pg5').feature('lngr2').set('linewidth', 'preference');
model.result('pg5').feature('lngr2').set('expr', 'an_U(Ha,y/d)');
model.result('pg5').feature('lngr2').set('xdata', 'expr');
model.result('pg5').feature('lngr2').set('xdataexpr', 'y/d');
model.result('pg5').feature('lngr2').set('legend', true);
model.result('pg5').feature('lngr2').set('legendprefix', 'Analytical Ha = ');
model.result('pg5').feature('lngr2').set('linestyle', 'none');
model.result('pg5').feature('lngr2').set('linecolor', 'black');
model.result('pg5').feature('lngr2').set('linemarker', 'cycle');
model.result('pg5').feature('lngr2').set('resolution', 'norefine');
model.result('pg5').feature('lngr2').set('smooth', 'none');
model.result('pg5').feature('lngr2').set('titletype', 'none');
model.result('pg5').run;
model.result.create('pg6', 'PlotGroup1D');
model.result('pg6').run;
model.result('pg6').label('Normalized velocity error');
model.result('pg6').set('data', 'cln2');
model.result('pg6').set('xlabelactive', true);
model.result('pg6').set('xlabel', 'y/d');
model.result('pg6').set('ylabelactive', true);
model.result('pg6').set('ylabel', 'err(u/U0)');
model.result('pg6').create('lngr1', 'LineGraph');
model.result('pg6').feature('lngr1').set('markerpos', 'datapoints');
model.result('pg6').feature('lngr1').set('linewidth', 'preference');
model.result('pg6').feature('lngr1').set('expr', 'abs(u/U0-an_U(Ha, y/d))');
model.result('pg6').feature('lngr1').set('xdata', 'expr');
model.result('pg6').feature('lngr1').set('xdataexpr', 'y/d');
model.result('pg6').feature('lngr1').set('linewidth', 2);
model.result('pg6').feature('lngr1').set('linemarker', 'asterisk');
model.result('pg6').feature('lngr1').set('legend', true);
model.result('pg6').feature('lngr1').set('legendprefix', 'Ha = ');
model.result('pg6').feature('lngr1').set('resolution', 'norefine');
model.result('pg6').feature('lngr1').set('smooth', 'none');
model.result('pg6').feature('lngr1').set('titletype', 'none');
model.result('pg6').run;

model.title('Hartmann Boundary Layer');

model.description('This introductory Magnetohydrodynamics model illustrates the effect of an external magnetic field on the laminary flow profile of a conducting fluid. The fluid velocity transverse to the magnetic field induces volumetric currents via the electromotive force, creating a Lorentz force on the fluid in the direction opposite the flow direction. The fluid velocity profile between two no-slip walls are compared to analytical values for different values of the Hartmann number.');

model.mesh.clearMeshes;

model.sol('sol1').clearSolutionData;

model.label('hartmann_boundary_layer.mph');

model.modelNode.label('Components');

out = model;
