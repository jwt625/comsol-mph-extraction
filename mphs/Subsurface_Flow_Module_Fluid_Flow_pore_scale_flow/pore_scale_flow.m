function out = model
%
% pore_scale_flow.m
%
% Model exported on May 26 2025, 21:34 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/Subsurface_Flow_Module/Fluid_Flow');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 2);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.physics.create('spf', 'CreepingFlow', 'geom1');
model.physics('spf').model('comp1');

model.study.create('std1');
model.study('std1').create('stat', 'Stationary');
model.study('std1').feature('stat').setSolveFor('/physics/spf', true);

model.geom('geom1').lengthUnit([native2unicode(hex2dec({'00' 'b5'}), 'unicode') 'm']);
model.geom('geom1').create('imp1', 'Import');
model.geom('geom1').feature('imp1').set('filename', 'pore_scale_flow.mphbin');
model.geom('geom1').feature('imp1').importData;

model.param.set('rho0', '1000[kg/m^3]');
model.param.descr('rho0', 'Fluid density');
model.param.set('eta0', '0.001[kg/(m*s)]');
model.param.descr('eta0', 'Dynamic viscosity');
model.param.set('p0', '0.715[Pa]');
model.param.descr('p0', 'Pressure drop');

model.geom('geom1').run;

model.material.create('mat1', 'Common', 'comp1');
model.material('mat1').propertyGroup('def').set('density', {'rho0'});
model.material('mat1').propertyGroup('def').set('dynamicviscosity', {'eta0'});

model.physics('spf').create('inl1', 'InletBoundary', 1);
model.physics('spf').feature('inl1').selection.set([2231 2232]);
model.physics('spf').feature('inl1').set('BoundaryCondition', 'Pressure');
model.physics('spf').feature('inl1').set('p0', 'p0');
model.physics('spf').create('out1', 'OutletBoundary', 1);
model.physics('spf').feature('out1').selection.set([1 4 7 10 13 16]);
model.physics('spf').create('sym1', 'Symmetry', 1);
model.physics('spf').feature('sym1').selection.set([31 59 247 342 517 601 720 825 878 1149 1300 1421 1488 1748 1756 1823 1912 2025]);

model.mesh('mesh1').run;

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
model.sol('sol1').feature('s1').feature('aDef').set('cachepattern', true);
model.sol('sol1').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('s1').feature('fc1').set('dtech', 'auto');
model.sol('sol1').feature('s1').feature('fc1').set('initstep', 0.01);
model.sol('sol1').feature('s1').feature('fc1').set('minstep', 1.0E-4);
model.sol('sol1').feature('s1').feature('fc1').set('maxiter', 100);
model.sol('sol1').feature('s1').create('d1', 'Direct');
model.sol('sol1').feature('s1').feature('d1').set('linsolver', 'pardiso');
model.sol('sol1').feature('s1').feature('d1').set('pivotperturb', 1.0E-13);
model.sol('sol1').feature('s1').feature('d1').label('Direct, fluid flow variables (spf)');
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
model.sol('sol1').attach('std1');
model.sol('sol1').runAll;

model.result.dataset('dset1').set('geom', 'geom1');
model.result.create('pg1', 'PlotGroup2D');
model.result('pg1').label('Velocity (spf)');
model.result('pg1').set('frametype', 'spatial');
model.result('pg1').set('data', 'dset1');
model.result('pg1').set('defaultPlotID', 'ResultDefaults_SinglePhaseFlow/icom1/pdef1/pcond1/pg1');
model.result('pg1').feature.create('surf1', 'Surface');
model.result('pg1').feature('surf1').label('Surface');
model.result('pg1').feature('surf1').set('showsolutionparams', 'on');
model.result('pg1').feature('surf1').set('smooth', 'internal');
model.result('pg1').feature('surf1').set('showsolutionparams', 'on');
model.result('pg1').feature('surf1').set('data', 'parent');
model.result.create('pg2', 'PlotGroup2D');
model.result('pg2').label('Pressure (spf)');
model.result('pg2').set('frametype', 'spatial');
model.result('pg2').set('data', 'dset1');
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
model.result('pg1').run;
model.result('pg1').create('str1', 'Streamline');
model.result('pg1').feature('str1').selection.set([2231 2232]);
model.result('pg1').feature('str1').set('pointtype', 'arrow');
model.result('pg1').feature('str1').set('color', 'white');
model.result('pg1').run;

model.modelNode.create('comp2', true);

model.geom.create('geom2', 2);
model.geom('geom2').model('comp2');

model.mesh.create('mesh2', 'geom2');

model.physics.create('br', 'PorousMediaFlowBrinkman', 'geom2');
model.physics('br').model('comp2');

model.study('std1').feature('stat').setSolveFor('/physics/br', false);

model.geom('geom2').run;

model.study.create('std2');
model.study('std2').create('stat', 'Stationary');
model.study('std2').feature('stat').setSolveFor('/physics/spf', false);
model.study('std2').feature('stat').setSolveFor('/physics/br', true);

% To import content from file, use:
% model.param.loadFile('FILENAME');
model.param.set('k0', '1000[mD]', 'Permeability scale');
model.param.set('L', '640[um]', 'Domain length');
model.param.set('H', '320[um]', 'Domain height');

model.geom('geom2').lengthUnit([native2unicode(hex2dec({'00' 'b5'}), 'unicode') 'm']);
model.geom('geom2').create('r1', 'Rectangle');
model.geom('geom2').feature('r1').set('size', {'L' 'H'});
model.geom('geom2').run('r1');

model.func.create('im1', 'Image');
model.func('im1').set('xmax', 'L');
model.func('im1').set('ymax', 'H');
model.func('im1').set('filename', 'pore_scale_flow_structure.png');
model.func('im1').importData;
model.func('im1').createPlot('pg3');

model.result('pg3').run;
model.result('pg3').label('SEM image');

model.view('view3').axis.set('viewscaletype', 'none');

model.geom('geom2').run;

model.material.create('mat2', 'Common', 'comp2');
model.material('mat2').propertyGroup('def').set('density', {'rho0'});
model.material('mat2').propertyGroup('def').set('dynamicviscosity', {'eta0'});
model.material('mat2').propertyGroup('def').set('porosity', {'1-0.99*im1(x,y)'});
model.material('mat2').propertyGroup('def').set('hydraulicpermeability', {'k0/(100*im1(x,y)+0.1)'});

model.physics('br').create('sym1', 'Symmetry', 1);
model.physics('br').feature('sym1').selection.set([2 3]);
model.physics('br').create('inl1', 'InletBoundary', 1);
model.physics('br').feature('inl1').set('BoundaryCondition', 'Pressure');
model.physics('br').feature('inl1').selection.set([4]);
model.physics('br').feature('inl1').set('p0', 'p0');
model.physics('br').create('out1', 'OutletBoundary', 1);
model.physics('br').feature('out1').selection.set([1]);

model.mesh('mesh2').autoMeshSize(2);
model.mesh('mesh2').run;

model.study('std2').feature('stat').set('errestandadap', 'adaption');
model.study('std2').feature('stat').set('meshadaptmethod', 'modify');
model.study('std2').feature('stat').set('adapgeom', 'geom2');

model.sol.create('sol2');

model.mesh('mesh1').stat.selection.geom(2);
model.mesh('mesh1').stat.selection.set([1]);
model.mesh('mesh2').stat.selection.geom(2);
model.mesh('mesh2').stat.selection.set([1]);

model.sol('sol2').study('std2');
model.sol('sol2').create('st1', 'StudyStep');
model.sol('sol2').feature('st1').set('study', 'std2');
model.sol('sol2').feature('st1').set('studystep', 'stat');
model.sol('sol2').create('v1', 'Variables');
model.sol('sol2').feature('v1').set('control', 'stat');
model.sol('sol2').create('s1', 'Stationary');
model.sol('sol2').feature('s1').feature('aDef').set('cachepattern', true);
model.sol('sol2').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol2').feature('s1').feature('fc1').set('dtech', 'auto');
model.sol('sol2').feature('s1').feature('fc1').set('initstep', 0.01);
model.sol('sol2').feature('s1').feature('fc1').set('minstep', 1.0E-4);
model.sol('sol2').feature('s1').feature('fc1').set('maxiter', 100);
model.sol('sol2').feature('s1').create('d1', 'Direct');
model.sol('sol2').feature('s1').feature('d1').set('linsolver', 'pardiso');
model.sol('sol2').feature('s1').feature('d1').set('pivotperturb', 1.0E-13);
model.sol('sol2').feature('s1').feature('d1').label('Direct, fluid flow variables (br)');
model.sol('sol2').feature('s1').create('i1', 'Iterative');
model.sol('sol2').feature('s1').feature('i1').set('linsolver', 'gmres');
model.sol('sol2').feature('s1').feature('i1').set('prefuntype', 'left');
model.sol('sol2').feature('s1').feature('i1').set('itrestart', 50);
model.sol('sol2').feature('s1').feature('i1').set('rhob', 20);
model.sol('sol2').feature('s1').feature('i1').set('maxlinit', 1000);
model.sol('sol2').feature('s1').feature('i1').set('nlinnormuse', 'on');
model.sol('sol2').feature('s1').feature('i1').label('AMG, fluid flow variables (br)');
model.sol('sol2').feature('s1').feature('i1').create('mg1', 'Multigrid');
model.sol('sol2').feature('s1').feature('i1').feature('mg1').set('prefun', 'saamg');
model.sol('sol2').feature('s1').feature('i1').feature('mg1').set('mgcycle', 'v');
model.sol('sol2').feature('s1').feature('i1').feature('mg1').set('maxcoarsedof', 80000);
model.sol('sol2').feature('s1').feature('i1').feature('mg1').set('strconn', 0.02);
model.sol('sol2').feature('s1').feature('i1').feature('mg1').set('nullspace', 'constant');
model.sol('sol2').feature('s1').feature('i1').feature('mg1').set('usesmooth', false);
model.sol('sol2').feature('s1').feature('i1').feature('mg1').set('saamgcompwise', true);
model.sol('sol2').feature('s1').feature('i1').feature('mg1').set('loweramg', true);
model.sol('sol2').feature('s1').feature('i1').feature('mg1').set('compactaggregation', false);
model.sol('sol2').feature('s1').feature('i1').feature('mg1').feature('pr').create('sc1', 'SCGS');
model.sol('sol2').feature('s1').feature('i1').feature('mg1').feature('pr').feature('sc1').set('linesweeptype', 'ssor');
model.sol('sol2').feature('s1').feature('i1').feature('mg1').feature('pr').feature('sc1').set('iter', 0);
model.sol('sol2').feature('s1').feature('i1').feature('mg1').feature('pr').feature('sc1').set('scgsrelax', 0.7);
model.sol('sol2').feature('s1').feature('i1').feature('mg1').feature('pr').feature('sc1').set('scgsmethod', 'lines');
model.sol('sol2').feature('s1').feature('i1').feature('mg1').feature('pr').feature('sc1').set('scgsvertexrelax', 0.7);
model.sol('sol2').feature('s1').feature('i1').feature('mg1').feature('pr').feature('sc1').set('relax', 0.5);
model.sol('sol2').feature('s1').feature('i1').feature('mg1').feature('pr').feature('sc1').set('scgssolv', 'stored');
model.sol('sol2').feature('s1').feature('i1').feature('mg1').feature('pr').feature('sc1').set('approxscgs', true);
model.sol('sol2').feature('s1').feature('i1').feature('mg1').feature('pr').feature('sc1').set('scgsdirectmaxsize', 1000);
model.sol('sol2').feature('s1').feature('i1').feature('mg1').feature('po').create('sc1', 'SCGS');
model.sol('sol2').feature('s1').feature('i1').feature('mg1').feature('po').feature('sc1').set('linesweeptype', 'ssor');
model.sol('sol2').feature('s1').feature('i1').feature('mg1').feature('po').feature('sc1').set('iter', 1);
model.sol('sol2').feature('s1').feature('i1').feature('mg1').feature('po').feature('sc1').set('scgsrelax', 0.7);
model.sol('sol2').feature('s1').feature('i1').feature('mg1').feature('po').feature('sc1').set('scgsmethod', 'lines');
model.sol('sol2').feature('s1').feature('i1').feature('mg1').feature('po').feature('sc1').set('scgsvertexrelax', 0.7);
model.sol('sol2').feature('s1').feature('i1').feature('mg1').feature('po').feature('sc1').set('relax', 0.5);
model.sol('sol2').feature('s1').feature('i1').feature('mg1').feature('po').feature('sc1').set('scgssolv', 'stored');
model.sol('sol2').feature('s1').feature('i1').feature('mg1').feature('po').feature('sc1').set('approxscgs', true);
model.sol('sol2').feature('s1').feature('i1').feature('mg1').feature('po').feature('sc1').set('scgsdirectmaxsize', 1000);
model.sol('sol2').feature('s1').feature('i1').feature('mg1').feature('cs').create('d1', 'Direct');
model.sol('sol2').feature('s1').feature('i1').feature('mg1').feature('cs').feature('d1').set('linsolver', 'pardiso');
model.sol('sol2').feature('s1').feature('i1').feature('mg1').feature('cs').feature('d1').set('pivotperturb', 1.0E-13);
model.sol('sol2').feature('s1').feature('fc1').set('linsolver', 'd1');
model.sol('sol2').feature('s1').feature('fc1').set('dtech', 'auto');
model.sol('sol2').feature('s1').feature('fc1').set('initstep', 0.01);
model.sol('sol2').feature('s1').feature('fc1').set('minstep', 1.0E-4);
model.sol('sol2').feature('s1').feature('fc1').set('maxiter', 100);
model.sol('sol2').feature('s1').feature.remove('fcDef');
model.sol('sol2').attach('std2');
model.sol('sol2').runAll;

model.result.dataset('dset5').set('geom', 'geom2');
model.result.create('pg4', 'PlotGroup2D');
model.result('pg4').label('Velocity (br)');
model.result('pg4').set('data', 'dset5');
model.result('pg4').setIndex('looplevel', 3, 0);
model.result('pg4').set('frametype', 'spatial');
model.result('pg4').set('data', 'dset5');
model.result('pg4').setIndex('looplevel', 3, 0);
model.result('pg4').set('defaultPlotID', 'ResultDefaults_SinglePhaseFlow/icom1/pdef1/pcond1/pg1');
model.result('pg4').feature.create('surf1', 'Surface');
model.result('pg4').feature('surf1').label('Surface');
model.result('pg4').feature('surf1').set('showsolutionparams', 'on');
model.result('pg4').feature('surf1').set('smooth', 'internal');
model.result('pg4').feature('surf1').set('showsolutionparams', 'on');
model.result('pg4').feature('surf1').set('data', 'parent');
model.result.create('pg5', 'PlotGroup2D');
model.result('pg5').label('Pressure (br)');
model.result('pg5').set('data', 'dset5');
model.result('pg5').setIndex('looplevel', 3, 0);
model.result('pg5').set('frametype', 'spatial');
model.result('pg5').set('data', 'dset5');
model.result('pg5').setIndex('looplevel', 3, 0);
model.result('pg5').set('defaultPlotID', 'ResultDefaults_SinglePhaseFlow/icom1/pdef1/pcond1/pg2');
model.result('pg5').feature.create('con1', 'Contour');
model.result('pg5').feature('con1').label('Contour');
model.result('pg5').feature('con1').set('showsolutionparams', 'on');
model.result('pg5').feature('con1').set('expr', 'p2');
model.result('pg5').feature('con1').set('number', 40);
model.result('pg5').feature('con1').set('levelrounding', false);
model.result('pg5').feature('con1').set('smooth', 'internal');
model.result('pg5').feature('con1').set('showsolutionparams', 'on');
model.result('pg5').feature('con1').set('data', 'parent');
model.result('pg4').run;
model.result('pg4').run;
model.result('pg4').feature('surf1').create('filt1', 'Filter');
model.result('pg4').run;
model.result('pg4').run;
model.result('pg4').feature('surf1').feature('filt1').set('expr', 'im1(x,y)<=0.5');
model.result('pg4').feature('surf1').feature('filt1').set('useder', true);
model.result('pg4').run;
model.result('pg4').run;
model.result('pg4').create('str1', 'Streamline');
model.result('pg4').feature('str1').selection.set([4]);
model.result('pg4').feature('str1').set('pointtype', 'arrow');
model.result('pg4').feature('str1').set('color', 'white');
model.result('pg4').run;

model.title('Pore-Scale Flow');

model.description(['In this innovative example, researchers zoom in flow in porous media by solving Navier' native2unicode(hex2dec({'20' '13'}), 'unicode') 'Stokes equations within individual pores. The model geometry (micrometer scale) comes from scanning electron microscope images of thinly sliced rock. How the variability in interstitial velocities upscale to continuum flows is of interest.']);

model.mesh.clearMeshes;

model.sol('sol1').clearSolutionData;
model.sol('sol2').clearSolutionData;
model.sol('sol3').clearSolutionData;
model.sol('sol4').clearSolutionData;
model.sol('sol5').clearSolutionData;
model.sol('sol6').clearSolutionData;

model.label('pore_scale_flow.mph');

model.modelNode.label('Components');

out = model;
