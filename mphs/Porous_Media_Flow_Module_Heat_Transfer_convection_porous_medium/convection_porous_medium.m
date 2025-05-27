function out = model
%
% convection_porous_medium.m
%
% Model exported on May 26 2025, 21:32 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/Porous_Media_Flow_Module/Heat_Transfer');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 2);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.physics.create('br', 'PorousMediaFlowBrinkman', 'geom1');
model.physics('br').model('comp1');
model.physics('br').prop('AdvancedSettingProperty').set('UsePseudoTime', '1');
model.physics('br').prop('PhysicalModelProperty').set('Compressibility', 'WeaklyCompressible');
model.physics.create('ht', 'PorousMediaHeatTransfer', 'geom1');
model.physics('ht').model('comp1');
model.physics('ht').prop('PhysicalModelProperty').set('dz', '1[m]');
model.physics('ht').prop('ShapeProperty').set('order_temperature', '1');

model.multiphysics.create('nitf1', 'NonIsothermalFlow', 'geom1', 2);
model.multiphysics('nitf1').set('Fluid_physics', 'br');
model.multiphysics('nitf1').set('Heat_physics', 'ht');

model.material.create('pmat1', 'PorousMedia', 'comp1');
model.material('pmat1').feature.create('fluid', 'Fluid', 'comp1');
model.material('pmat1').feature.create('solid', 'Solid', 'comp1');
model.material('pmat1').selection.all;

model.study.create('std1');
model.study('std1').create('stat', 'Stationary');
model.study('std1').feature('stat').setSolveFor('/physics/br', true);
model.study('std1').feature('stat').setSolveFor('/physics/ht', true);
model.study('std1').feature('stat').setSolveFor('/multiphysics/nitf1', true);

% To import content from file, use:
% model.param.loadFile('FILENAME');
model.param.set('rho0', '1000[kg/m^3]', 'Fluid density');
model.param.set('mu0', '0.001[Pa*s]', 'Fluid viscosity');
model.param.set('alphap', '1e-6[1/K]', 'Fluid volumetric thermal expansion');
model.param.set('k0', '6[W/(m*K)]', 'Fluid thermal conductivity');
model.param.set('gamma', '1', 'Fluid ratio of specific heat');
model.param.set('Cp0', '4200[J/(kg*K)]', 'Fluid heat capacity at constant pressure');
model.param.set('epsilon', '0.4', 'Porosity');
model.param.set('kappa', '1e-3[m^2]', 'Permeability');
model.param.set('p0', '1[atm]', 'Reference pressure');
model.param.set('Tc', '20[degC]', 'Reference temperature');
model.param.set('Th', '42[degC]', 'High temperature');
model.param.set('L', '0.1[m]', 'Length scale');
model.param.set('Pr', 'mu0*Cp0/k0', 'Prandtl number');
model.param.set('Ra', 'Cp0*rho0^2*g_const*alphap*(Th-Tc)*L^3/(k0*mu0)', 'Rayleigh number');

model.geom('geom1').create('sq1', 'Square');
model.geom('geom1').feature('sq1').set('size', 'L');
model.geom('geom1').run('sq1');
model.geom('geom1').create('pt1', 'Point');
model.geom('geom1').feature('pt1').setIndex('p', 'L', 0);
model.geom('geom1').feature('pt1').setIndex('p', 'L/10', 1);
model.geom('geom1').runPre('fin');
model.geom('geom1').run;

model.material('pmat1').propertyGroup('def').set('hydraulicpermeability', {'kappa'});
model.material('pmat1').feature('fluid').propertyGroup('def').set('density', {'rho0'});
model.material('pmat1').feature('fluid').propertyGroup('def').set('thermalconductivity', {'k0'});
model.material('pmat1').feature('fluid').propertyGroup('def').set('heatcapacity', {'Cp0'});
model.material('pmat1').feature('fluid').propertyGroup('def').set('dynamicviscosity', {'mu0'});
model.material('pmat1').feature('solid').set('vfrac', '1-epsilon');
model.material('pmat1').feature('solid').propertyGroup('def').set('density', {'0'});
model.material('pmat1').feature('solid').propertyGroup('def').set('heatcapacity', {'0'});
model.material('pmat1').feature('solid').propertyGroup('def').set('thermalconductivity', {'0'});

model.physics('br').prop('PhysicalModelProperty').set('Compressibility', 'Incompressible');
model.physics('br').prop('PhysicalModelProperty').set('IncludeGravity', true);
model.physics('br').prop('AdvancedSettingProperty').set('PseudoTimeSetting', 'Off');
model.physics('br').create('prpc1', 'PressurePointConstraint', 0);
model.physics('br').feature('prpc1').selection.set([4]);
model.physics('ht').prop('ShapeProperty').set('order_temperature', 2);
model.physics('ht').feature('init1').set('Tinit', 'Tc');
model.physics('ht').create('temp1', 'TemperatureBoundary', 1);
model.physics('ht').feature('temp1').selection.set([2]);
model.physics('ht').feature('temp1').set('T0', 'Th');
model.physics('ht').create('temp2', 'TemperatureBoundary', 1);
model.physics('ht').feature('temp2').selection.set([3 5]);
model.physics('ht').feature('temp2').set('T0', 'Tc');
model.physics('ht').create('temp3', 'TemperatureBoundary', 1);
model.physics('ht').feature('temp3').selection.set([1]);
model.physics('ht').feature('temp3').set('T0', 'Th-(Th-Tc)*s');
model.physics('ht').create('temp4', 'TemperatureBoundary', 1);
model.physics('ht').feature('temp4').selection.set([4]);
model.physics('ht').feature('temp4').set('T0', 'Tc-(Tc-Th)*s');

model.multiphysics('nitf1').set('BoussinesqApproximation', true);
model.multiphysics('nitf1').set('SpecifyDensity', 'CustomLinearizedDensity');
model.multiphysics('nitf1').set('rhoref', 'rho0');
model.multiphysics('nitf1').set('alphap', 'alphap');

model.mesh('mesh1').autoMeshSize(3);

model.study('std1').feature('stat').set('useparam', true);
model.study('std1').feature('stat').setIndex('pname', 'rho0', 0);
model.study('std1').feature('stat').setIndex('plistarr', '', 0);
model.study('std1').feature('stat').setIndex('punit', 'kg/m^3', 0);
model.study('std1').feature('stat').setIndex('pname', 'rho0', 0);
model.study('std1').feature('stat').setIndex('plistarr', '', 0);
model.study('std1').feature('stat').setIndex('punit', 'kg/m^3', 0);
model.study('std1').feature('stat').setIndex('pname', 'alphap', 0);
model.study('std1').feature('stat').setIndex('plistarr', '10^{range(-12,1,-6)}', 0);

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
model.sol('sol1').feature('s1').feature('fc1').set('initstep', 0.01);
model.sol('sol1').feature('s1').feature('fc1').set('minstep', 1.0E-4);
model.sol('sol1').feature('s1').feature('fc1').set('maxiter', 100);
model.sol('sol1').feature('s1').create('d1', 'Direct');
model.sol('sol1').feature('s1').feature('d1').set('linsolver', 'pardiso');
model.sol('sol1').feature('s1').feature('d1').set('pivotperturb', 1.0E-13);
model.sol('sol1').feature('s1').feature('d1').label('Direct, nonisothermal flow (nitf1) (Merged)');
model.sol('sol1').feature('s1').create('i1', 'Iterative');
model.sol('sol1').feature('s1').feature('i1').set('linsolver', 'gmres');
model.sol('sol1').feature('s1').feature('i1').set('prefuntype', 'left');
model.sol('sol1').feature('s1').feature('i1').set('itrestart', 50);
model.sol('sol1').feature('s1').feature('i1').set('rhob', 20);
model.sol('sol1').feature('s1').feature('i1').set('maxlinit', 1000);
model.sol('sol1').feature('s1').feature('i1').set('nlinnormuse', 'on');
model.sol('sol1').feature('s1').feature('i1').label('AMG, nonisothermal flow (nitf1)');
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
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('po').feature('sc1').set('scgssolv', 'stored');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('po').feature('sc1').set('approxscgs', true);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('po').feature('sc1').set('scgsdirectmaxsize', 1000);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('cs').create('d1', 'Direct');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('cs').feature('d1').set('linsolver', 'pardiso');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('cs').feature('d1').set('pivotperturb', 1.0E-13);
model.sol('sol1').feature('s1').feature('fc1').set('linsolver', 'd1');
model.sol('sol1').feature('s1').feature('fc1').set('dtech', 'auto');
model.sol('sol1').feature('s1').feature('fc1').set('initstep', 0.01);
model.sol('sol1').feature('s1').feature('fc1').set('minstep', 1.0E-4);
model.sol('sol1').feature('s1').feature('fc1').set('maxiter', 100);
model.sol('sol1').feature('s1').feature.remove('fcDef');
model.sol('sol1').feature('s1').feature.remove('seDef');
model.sol('sol1').attach('std1');
model.sol('sol1').runAll;

model.result.dataset('dset1').set('geom', 'geom1');
model.result.create('pg1', 'PlotGroup2D');
model.result('pg1').label('Velocity (br)');
model.result('pg1').set('frametype', 'spatial');
model.result('pg1').set('data', 'dset1');
model.result('pg1').setIndex('looplevel', 7, 0);
model.result('pg1').set('defaultPlotID', 'ResultDefaults_SinglePhaseFlow/icom1/pdef1/pcond1/pg1');
model.result('pg1').feature.create('surf1', 'Surface');
model.result('pg1').feature('surf1').label('Surface');
model.result('pg1').feature('surf1').set('showsolutionparams', 'on');
model.result('pg1').feature('surf1').set('smooth', 'internal');
model.result('pg1').feature('surf1').set('showsolutionparams', 'on');
model.result('pg1').feature('surf1').set('data', 'parent');
model.result.create('pg2', 'PlotGroup2D');
model.result('pg2').label('Pressure (br)');
model.result('pg2').set('frametype', 'spatial');
model.result('pg2').set('data', 'dset1');
model.result('pg2').setIndex('looplevel', 7, 0);
model.result('pg2').set('defaultPlotID', 'ResultDefaults_SinglePhaseFlow/icom1/pdef1/pcond1/pg2');
model.result('pg2').feature.create('con1', 'Contour');
model.result('pg2').feature('con1').label('Contour');
model.result('pg2').feature('con1').set('showsolutionparams', 'on');
model.result('pg2').feature('con1').set('expr', 'p');
model.result('pg2').feature('con1').set('number', 40);
model.result('pg2').feature('con1').set('levelrounding', false);
model.result('pg2').feature('con1').set('smooth', 'internal');
model.result('pg2').feature('con1').set('showsolutionparams', 'on');
model.result('pg2').feature('con1').set('data', 'parent');
model.result.create('pg3', 'PlotGroup2D');
model.result('pg3').label('Temperature (ht)');
model.result('pg3').set('data', 'dset1');
model.result('pg3').setIndex('looplevel', 7, 0);
model.result('pg3').set('defaultPlotID', 'ht/HT_PhysicsInterfaces/icom8/pdef1/pcond2/pcond4/pg2');
model.result('pg3').feature.create('surf1', 'Surface');
model.result('pg3').feature('surf1').set('showsolutionparams', 'on');
model.result('pg3').feature('surf1').set('solutionparams', 'parent');
model.result('pg3').feature('surf1').set('expr', 'T');
model.result('pg3').feature('surf1').set('colortable', 'HeatCameraLight');
model.result('pg3').feature('surf1').set('showsolutionparams', 'on');
model.result('pg3').feature('surf1').set('data', 'parent');
model.result.create('pg4', 'PlotGroup2D');
model.result('pg4').label('Temperature and Fluid Flow (nitf1)');
model.result('pg4').set('showlegendsunit', true);
model.result('pg4').set('data', 'dset1');
model.result('pg4').setIndex('looplevel', 7, 0);
model.result('pg4').set('defaultPlotID', 'MultiphysicsNonIsothermalFlow/cfcom1/pdef1/pcond4/pcond4/pcond1/pg3');
model.result('pg4').feature.create('surf1', 'Surface');
model.result('pg4').feature('surf1').label('Fluid Temperature');
model.result('pg4').feature('surf1').set('showsolutionparams', 'on');
model.result('pg4').feature('surf1').set('solutionparams', 'parent');
model.result('pg4').feature('surf1').set('expr', 'nitf1.T');
model.result('pg4').feature('surf1').set('colortable', 'HeatCameraLight');
model.result('pg4').feature('surf1').set('smooth', 'internal');
model.result('pg4').feature('surf1').set('showsolutionparams', 'on');
model.result('pg4').feature('surf1').set('data', 'parent');
model.result('pg4').feature('surf1').feature.create('sel1', 'Selection');
model.result('pg4').feature('surf1').feature('sel1').selection.geom('geom1', 2);
model.result('pg4').feature('surf1').feature('sel1').selection.set([1]);
model.result('pg4').feature.create('arws1', 'ArrowSurface');
model.result('pg4').feature('arws1').label('Fluid Flow');
model.result('pg4').feature('arws1').set('showsolutionparams', 'on');
model.result('pg4').feature('arws1').set('solutionparams', 'parent');
model.result('pg4').feature('arws1').set('expr', {'nitf1.ux' 'nitf1.uy'});
model.result('pg4').feature('arws1').set('xnumber', 30);
model.result('pg4').feature('arws1').set('ynumber', 30);
model.result('pg4').feature('arws1').set('arrowtype', 'cone');
model.result('pg4').feature('arws1').set('arrowlength', 'logarithmic');
model.result('pg4').feature('arws1').set('showsolutionparams', 'on');
model.result('pg4').feature('arws1').set('data', 'parent');
model.result('pg4').feature('arws1').feature.create('col1', 'Color');
model.result('pg4').feature('arws1').feature('col1').set('showcolordata', 'off');
model.result('pg4').feature('arws1').feature.create('filt1', 'Filter');
model.result('pg4').feature('arws1').feature('filt1').set('expr', 'br.U>nitf1.Uave');
model.result('pg1').run;
model.result('pg1').run;
model.result('pg1').feature('surf1').set('resolution', 'finer');
model.result('pg1').run;
model.result('pg1').run;
model.result('pg1').create('arws1', 'ArrowSurface');
model.result('pg1').run;
model.result('pg2').run;
model.result('pg3').run;
model.result('pg3').run;
model.result('pg4').run;

model.title('Free Convection in a Porous Medium');

model.description('This example demonstrates the modeling of convection and conduction in porous media. Here fluid movement is driven entirely by buoyant rise due to density variations with temperature. The results are compared with a published study.');

model.label('convection_porous_medium.mph');

model.modelNode.label('Components');

out = model;
