function out = model
%
% electric_field_concentric_cylinders.m
%
% Model exported on May 26 2025, 21:25 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/ACDC_Module/Introductory_Electrostatics');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 1);
model.geom('geom1').model('comp1');
model.geom('geom1').axisymmetric(true);

model.mesh.create('mesh1', 'geom1');

model.physics.create('es', 'Electrostatics', 'geom1');
model.physics('es').model('comp1');

model.study.create('std1');
model.study('std1').create('stat', 'Stationary');
model.study('std1').feature('stat').setSolveFor('/physics/es', true);

model.param.set('ri', '0.1[m]');
model.param.descr('ri', 'Radius of inner cylinder');
model.param.set('ro', '1[m]');
model.param.descr('ro', 'Radius of outer cylinder');
model.param.set('V0', '100[V]');
model.param.descr('V0', 'Potential at inner cylinder');
model.param.set('q0', '1e-7[C/m]');
model.param.descr('q0', 'Charge at inner cylinder');

model.geom('geom1').create('i1', 'Interval');
model.geom('geom1').feature('i1').setIndex('coord', 'ri', 0);
model.geom('geom1').feature('i1').setIndex('coord', 'ro', 1);
model.geom('geom1').runPre('fin');
model.geom('geom1').run;

model.material.create('mat1', 'Common', 'comp1');
model.material('mat1').propertyGroup('def').set('relpermittivity', {'1'});

model.physics('es').create('gnd1', 'Ground', 0);
model.physics('es').feature('gnd1').selection.set([2]);
model.physics('es').create('pot1', 'ElectricPotential', 0);
model.physics('es').feature('pot1').selection.set([1]);
model.physics('es').feature('pot1').set('V0', 'V0');
model.physics.create('es2', 'Electrostatics', 'geom1');
model.physics('es2').model('comp1');

model.study('std1').feature('stat').setSolveFor('/physics/es2', true);

model.physics('es2').create('gnd1', 'Ground', 0);
model.physics('es2').feature('gnd1').selection.set([2]);
model.physics('es2').create('sfcd1', 'SurfaceChargeDensity', 0);
model.physics('es2').feature('sfcd1').selection.set([1]);
model.physics('es2').feature('sfcd1').set('rhoqs', 'q0/(2*pi*ri)');

model.sol.create('sol1');
model.sol('sol1').study('std1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'stat');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').set('control', 'stat');
model.sol('sol1').create('s1', 'Stationary');
model.sol('sol1').feature('s1').create('seDef', 'Segregated');
model.sol('sol1').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('s1').feature('fc1').set('linsolver', 'dDef');
model.sol('sol1').feature('s1').feature.remove('fcDef');
model.sol('sol1').feature('s1').feature.remove('seDef');
model.sol('sol1').attach('std1');
model.sol('sol1').runAll;

model.result.create('pg1', 'PlotGroup1D');
model.result('pg1').label('Electric Potential (es)');
model.result('pg1').set('data', 'dset1');
model.result('pg1').set('defaultPlotID', 'InterfaceComponents/PlotDefaults/icom2/pdef1/pcond2/pcond4/pg1');
model.result('pg1').feature.create('lngr1', 'LineGraph');
model.result('pg1').feature('lngr1').set('showsolutionparams', 'on');
model.result('pg1').feature('lngr1').set('solutionparams', 'parent');
model.result('pg1').feature('lngr1').set('xdata', 'expr');
model.result('pg1').feature('lngr1').set('xdataexpr', 'r');
model.result('pg1').feature('lngr1').set('showsolutionparams', 'on');
model.result('pg1').feature('lngr1').set('data', 'parent');
model.result('pg1').feature('lngr1').selection.geom('geom1', 1);
model.result('pg1').feature('lngr1').selection.set([1]);
model.result.create('pg2', 'PlotGroup1D');
model.result('pg2').label('Electric Potential (es2)');
model.result('pg2').set('data', 'dset1');
model.result('pg2').set('defaultPlotID', 'InterfaceComponents/PlotDefaults/icom2/pdef1/pcond2/pcond4/pg1');
model.result('pg2').feature.create('lngr1', 'LineGraph');
model.result('pg2').feature('lngr1').set('showsolutionparams', 'on');
model.result('pg2').feature('lngr1').set('solutionparams', 'parent');
model.result('pg2').feature('lngr1').set('expr', 'V2');
model.result('pg2').feature('lngr1').set('xdata', 'expr');
model.result('pg2').feature('lngr1').set('xdataexpr', 'r');
model.result('pg2').feature('lngr1').set('showsolutionparams', 'on');
model.result('pg2').feature('lngr1').set('data', 'parent');
model.result('pg2').feature('lngr1').selection.geom('geom1', 1);
model.result('pg2').feature('lngr1').selection.set([1]);
model.result('pg1').run;
model.result('pg1').label('Electric Potential Comparison, Potential');
model.result('pg1').set('ylabelactive', true);
model.result('pg1').set('titletype', 'label');
model.result('pg1').create('lngr2', 'LineGraph');
model.result('pg1').feature('lngr2').set('markerpos', 'datapoints');
model.result('pg1').feature('lngr2').set('linewidth', 'preference');
model.result('pg1').feature('lngr2').selection.set([1]);
model.result('pg1').feature('lngr2').set('expr', 'V0*log(r/ro)/log(ri/ro)');
model.result('pg1').feature('lngr2').set('xdata', 'expr');
model.result('pg1').feature('lngr2').set('xdataexpr', 'r');
model.result('pg1').feature('lngr2').set('legend', true);
model.result('pg1').feature('lngr2').set('legendmethod', 'manual');
model.result('pg1').feature('lngr2').setIndex('legends', 'Analytical solution', 0);
model.result('pg1').run;
model.result('pg1').feature('lngr1').set('legend', true);
model.result('pg1').feature('lngr1').set('autoexpr', true);
model.result('pg1').feature('lngr1').set('autosolution', false);
model.result('pg1').feature('lngr1').set('autodescr', true);
model.result('pg1').run;
model.result('pg2').run;
model.result('pg2').label('Electric Potential Comparison, Charge Density');
model.result('pg2').set('ylabelactive', true);
model.result('pg2').set('titletype', 'label');
model.result('pg2').create('lngr2', 'LineGraph');
model.result('pg2').feature('lngr2').set('markerpos', 'datapoints');
model.result('pg2').feature('lngr2').set('linewidth', 'preference');
model.result('pg2').feature('lngr2').selection.set([1]);
model.result('pg2').feature('lngr2').set('expr', '-q0*log(r/ro)/(2*pi*epsilon0_const)');
model.result('pg2').feature('lngr2').set('xdata', 'expr');
model.result('pg2').feature('lngr2').set('xdataexpr', 'r');
model.result('pg2').feature('lngr2').set('legend', true);
model.result('pg2').feature('lngr2').set('legendmethod', 'manual');
model.result('pg2').feature('lngr2').setIndex('legends', 'Analytical solution', 0);
model.result('pg2').run;
model.result('pg2').feature('lngr1').set('legend', true);
model.result('pg2').feature('lngr1').set('autoexpr', true);
model.result('pg2').feature('lngr1').set('autosolution', false);
model.result('pg2').feature('lngr1').set('autodescr', true);
model.result('pg2').run;
model.result.create('pg3', 'PlotGroup1D');
model.result('pg3').run;
model.result('pg3').label('Electric Field Comparison, Potential');
model.result('pg3').set('ylabelactive', true);
model.result('pg3').set('ylabel', 'Electric field (V/m)');
model.result('pg3').set('titletype', 'label');
model.result('pg3').create('lngr1', 'LineGraph');
model.result('pg3').feature('lngr1').set('markerpos', 'datapoints');
model.result('pg3').feature('lngr1').set('linewidth', 'preference');
model.result('pg3').feature('lngr1').selection.set([1]);
model.result('pg3').feature('lngr1').set('expr', 'es.Er');
model.result('pg3').feature('lngr1').set('xdata', 'expr');
model.result('pg3').feature('lngr1').set('xdataexpr', 'r');
model.result('pg3').feature('lngr1').set('legend', true);
model.result('pg3').feature('lngr1').set('autoexpr', true);
model.result('pg3').feature('lngr1').set('autosolution', false);
model.result('pg3').feature('lngr1').set('autodescr', true);
model.result('pg3').run;
model.result('pg3').create('lngr2', 'LineGraph');
model.result('pg3').feature('lngr2').set('markerpos', 'datapoints');
model.result('pg3').feature('lngr2').set('linewidth', 'preference');
model.result('pg3').feature('lngr2').selection.set([1]);
model.result('pg3').feature('lngr2').set('expr', '-V0/(r*log(ri/ro))');
model.result('pg3').feature('lngr2').set('xdata', 'expr');
model.result('pg3').feature('lngr2').set('xdataexpr', 'r');
model.result('pg3').feature('lngr2').set('legend', true);
model.result('pg3').feature('lngr2').set('legendmethod', 'manual');
model.result('pg3').feature('lngr2').setIndex('legends', 'Analytical solution', 0);
model.result('pg3').run;
model.result.create('pg4', 'PlotGroup1D');
model.result('pg4').run;
model.result('pg4').label('Electric Field Comparison, Charge Density');
model.result('pg4').set('ylabelactive', true);
model.result('pg4').set('ylabel', 'Electric field (V/m)');
model.result('pg4').set('titletype', 'label');
model.result('pg4').create('lngr1', 'LineGraph');
model.result('pg4').feature('lngr1').set('markerpos', 'datapoints');
model.result('pg4').feature('lngr1').set('linewidth', 'preference');
model.result('pg4').feature('lngr1').selection.set([1]);
model.result('pg4').feature('lngr1').set('expr', 'es2.Er');
model.result('pg4').feature('lngr1').set('xdata', 'expr');
model.result('pg4').feature('lngr1').set('xdataexpr', 'r');
model.result('pg4').feature('lngr1').set('legend', true);
model.result('pg4').feature('lngr1').set('autoexpr', true);
model.result('pg4').feature('lngr1').set('autosolution', false);
model.result('pg4').feature('lngr1').set('autodescr', true);
model.result('pg4').run;
model.result('pg4').create('lngr2', 'LineGraph');
model.result('pg4').feature('lngr2').set('markerpos', 'datapoints');
model.result('pg4').feature('lngr2').set('linewidth', 'preference');
model.result('pg4').feature('lngr2').selection.set([1]);
model.result('pg4').feature('lngr2').set('expr', 'q0/(2*pi*epsilon0_const*r)');
model.result('pg4').feature('lngr2').set('xdata', 'expr');
model.result('pg4').feature('lngr2').set('xdataexpr', 'r');
model.result('pg4').feature('lngr2').set('legend', true);
model.result('pg4').feature('lngr2').set('legendmethod', 'manual');
model.result('pg4').feature('lngr2').setIndex('legends', 'Analytical solution', 0);
model.result('pg4').run;

model.title('Electric Field Between Concentric Cylinders');

model.description('This introductory model treats the electrostatics problem of two concentric cylinders of infinite length, which is commonly found in textbooks. Since the problem can be solved analytically, the model can be used to compare theory with numerical simulation results. Two cases are considered: One with a fixed potential on each cylinder and the other with a surface charge density on one cylinder and a fixed potential on the other.');

model.mesh.clearMeshes;

model.sol('sol1').clearSolutionData;

model.label('electric_field_concentric_cylinders.mph');

model.modelNode.label('Components');

out = model;
