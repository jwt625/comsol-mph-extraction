function out = model
%
% thermal_bridge_2d_composite_structure.m
%
% Model exported on May 26 2025, 21:28 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/Heat_Transfer_Module/Buildings_and_Constructions');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 2);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.physics.create('ht', 'HeatTransfer', 'geom1');
model.physics('ht').model('comp1');

model.study.create('std1');
model.study('std1').create('stat', 'Stationary');
model.study('std1').feature('stat').setSolveFor('/physics/ht', true);

model.param.set('W', '0.5[m]');
model.param.descr('W', 'Structure width');
model.param.set('w', '15[mm]');
model.param.descr('w', 'Short width for wood and aluminum domains');
model.param.set('h1', '6[mm]');
model.param.descr('h1', 'Concrete domain height');
model.param.set('h2', '5[mm]');
model.param.descr('h2', 'Wood domain height');
model.param.set('h3', '41.5[mm]');
model.param.descr('h3', 'Insulation domain height');
model.param.set('h4', 'h3-h2');
model.param.descr('h4', 'Aluminum domain height');
model.param.set('t4', '1.5[mm]');
model.param.descr('t4', 'Aluminum domain thickness');

model.geom('geom1').create('r1', 'Rectangle');
model.geom('geom1').feature('r1').set('size', {'W' 'h3+h1'});
model.geom('geom1').feature('r1').setIndex('layername', 'Layer 1', 0);
model.geom('geom1').feature('r1').setIndex('layer', 'h3', 0);
model.geom('geom1').run('r1');
model.geom('geom1').create('r2', 'Rectangle');
model.geom('geom1').feature('r2').set('size', {'W' 't4'});
model.geom('geom1').run('r2');
model.geom('geom1').create('r3', 'Rectangle');
model.geom('geom1').feature('r3').set('size', {'t4' 'h4'});
model.geom('geom1').run('r3');
model.geom('geom1').create('r4', 'Rectangle');
model.geom('geom1').feature('r4').set('size', {'w' 't4'});
model.geom('geom1').feature('r4').set('pos', {'0' 'h4-t4'});
model.geom('geom1').run('r4');
model.geom('geom1').create('uni1', 'Union');
model.geom('geom1').feature('uni1').set('intbnd', false);
model.geom('geom1').feature('uni1').selection('input').set({'r2' 'r3' 'r4'});
model.geom('geom1').run('uni1');
model.geom('geom1').create('r5', 'Rectangle');
model.geom('geom1').feature('r5').set('size', {'w' 'h2'});
model.geom('geom1').feature('r5').set('pos', {'0' 'h4'});
model.geom('geom1').runPre('fin');
model.geom('geom1').run;

model.material.create('mat1', 'Common', 'comp1');
model.material('mat1').label('Concrete');
model.material('mat1').selection.set([3]);
model.material('mat1').propertyGroup('def').set('thermalconductivity', {'1.15'});
model.material('mat1').propertyGroup('def').set('density', {'2300'});
model.material('mat1').propertyGroup('def').set('heatcapacity', {'880'});
model.material.create('mat2', 'Common', 'comp1');
model.material('mat2').label('Wood');
model.material('mat2').selection.set([2]);
model.material('mat2').propertyGroup('def').set('thermalconductivity', {'0.12'});
model.material('mat2').propertyGroup('def').set('density', {'500'});
model.material('mat2').propertyGroup('def').set('heatcapacity', {'2500'});
model.material.create('mat3', 'Common', 'comp1');
model.material('mat3').label('Insulation');
model.material('mat3').selection.set([4]);
model.material('mat3').propertyGroup('def').set('thermalconductivity', {'0.029'});
model.material('mat3').propertyGroup('def').set('density', {'150'});
model.material('mat3').propertyGroup('def').set('heatcapacity', {'1000'});
model.material.create('mat4', 'Common', 'comp1');
model.material('mat4').label('Aluminum');
model.material('mat4').selection.set([1]);
model.material('mat4').propertyGroup('def').set('thermalconductivity', {'230'});
model.material('mat4').propertyGroup('def').set('density', {'2700'});
model.material('mat4').propertyGroup('def').set('heatcapacity', {'900'});

model.physics('ht').create('hf1', 'HeatFluxBoundary', 1);
model.physics('ht').feature('hf1').selection.set([2 10]);
model.physics('ht').feature('hf1').set('HeatFluxType', 'ConvectiveHeatFlux');
model.physics('ht').feature('hf1').set('h', '1/0.11');
model.physics('ht').feature('hf1').set('Text', '20[degC]');
model.physics('ht').create('hf2', 'HeatFluxBoundary', 1);
model.physics('ht').feature('hf2').selection.set([9]);
model.physics('ht').feature('hf2').set('HeatFluxType', 'ConvectiveHeatFlux');
model.physics('ht').feature('hf2').set('h', '1/0.06');
model.physics('ht').feature('hf2').set('Text', '0[degC]');

model.sol.create('sol1');
model.sol('sol1').study('std1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'stat');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').set('control', 'stat');
model.sol('sol1').create('s1', 'Stationary');
model.sol('sol1').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('s1').feature('fc1').set('dtech', 'auto');
model.sol('sol1').feature('s1').feature('fc1').set('initstep', 0.01);
model.sol('sol1').feature('s1').feature('fc1').set('minstep', 1.0E-6);
model.sol('sol1').feature('s1').feature('fc1').set('maxiter', 50);
model.sol('sol1').feature('s1').feature('fc1').set('termonres', 'off');
model.sol('sol1').feature('s1').create('d1', 'Direct');
model.sol('sol1').feature('s1').feature('d1').set('linsolver', 'pardiso');
model.sol('sol1').feature('s1').feature('d1').set('pivotperturb', 1.0E-13);
model.sol('sol1').feature('s1').feature('d1').label('Direct, heat transfer variables (ht)');
model.sol('sol1').feature('s1').create('i1', 'Iterative');
model.sol('sol1').feature('s1').feature('i1').set('linsolver', 'gmres');
model.sol('sol1').feature('s1').feature('i1').set('prefuntype', 'left');
model.sol('sol1').feature('s1').feature('i1').set('itrestart', 50);
model.sol('sol1').feature('s1').feature('i1').set('rhob', 20);
model.sol('sol1').feature('s1').feature('i1').set('maxlinit', 10000);
model.sol('sol1').feature('s1').feature('i1').set('nlinnormuse', 'on');
model.sol('sol1').feature('s1').feature('i1').label('AMG, heat transfer variables (ht)');
model.sol('sol1').feature('s1').feature('i1').create('mg1', 'Multigrid');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').set('prefun', 'saamg');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').set('mgcycle', 'v');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').set('maxcoarsedof', 50000);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').set('strconn', 0.01);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').set('nullspace', 'constant');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').set('usesmooth', false);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').set('saamgcompwise', true);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').set('loweramg', true);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').set('compactaggregation', false);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('pr').create('so1', 'SOR');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('pr').feature('so1').set('iter', 2);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('pr').feature('so1').set('relax', 0.9);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('po').create('so1', 'SOR');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('po').feature('so1').set('iter', 2);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('po').feature('so1').set('relax', 0.9);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('cs').create('d1', 'Direct');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('cs').feature('d1').set('linsolver', 'pardiso');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('cs').feature('d1').set('pivotperturb', 1.0E-13);
model.sol('sol1').feature('s1').feature('fc1').set('linsolver', 'd1');
model.sol('sol1').feature('s1').feature('fc1').set('dtech', 'auto');
model.sol('sol1').feature('s1').feature('fc1').set('initstep', 0.01);
model.sol('sol1').feature('s1').feature('fc1').set('minstep', 1.0E-6);
model.sol('sol1').feature('s1').feature('fc1').set('maxiter', 50);
model.sol('sol1').feature('s1').feature('fc1').set('termonres', 'off');
model.sol('sol1').feature('s1').feature.remove('fcDef');
model.sol('sol1').attach('std1');
model.sol('sol1').runAll;

model.result.create('pg1', 'PlotGroup2D');
model.result('pg1').label('Temperature (ht)');
model.result('pg1').set('data', 'dset1');
model.result('pg1').set('defaultPlotID', 'ht/HT_PhysicsInterfaces/icom8/pdef1/pcond2/pcond4/pg2');
model.result('pg1').feature.create('surf1', 'Surface');
model.result('pg1').feature('surf1').set('showsolutionparams', 'on');
model.result('pg1').feature('surf1').set('solutionparams', 'parent');
model.result('pg1').feature('surf1').set('colortable', 'HeatCameraLight');
model.result('pg1').feature('surf1').set('showsolutionparams', 'on');
model.result('pg1').feature('surf1').set('data', 'parent');
model.result('pg1').run;
model.result.create('pg2', 'PlotGroup2D');
model.result('pg2').label('Isothermal Contours (ht)');
model.result('pg2').set('data', 'dset1');
model.result('pg2').set('defaultPlotID', 'ht/HT_PhysicsInterfaces/icom8/pdef1/pcond2/pcond4/pg1');
model.result('pg2').feature.create('con1', 'Contour');
model.result('pg2').feature('con1').set('solutionparams', 'parent');
model.result('pg2').feature('con1').set('colortable', 'HeatCameraLight');
model.result('pg2').feature('con1').set('smooth', 'internal');
model.result('pg2').feature('con1').set('showsolutionparams', 'on');
model.result('pg2').feature('con1').set('data', 'parent');
model.result('pg2').label('Isothermal Contours (ht)');
model.result('pg2').run;
model.result('pg1').run;
model.result('pg1').feature('surf1').set('unit', 'degC');
model.result('pg2').run;
model.result.numerical.create('int1', 'IntLine');
model.result.numerical('int1').set('intsurface', true);
model.result.numerical('int1').selection.set([2 10]);
model.result.numerical('int1').set('expr', {'ht.q0'});
model.result.numerical('int1').set('descr', {'Inward heat flux'});
model.result.numerical('int1').set('unit', {'W/m'});
model.result.table.create('tbl1', 'Table');
model.result.table('tbl1').comments('Line Integration 1');
model.result.numerical('int1').set('table', 'tbl1');
model.result.numerical('int1').setResult;
model.result.export.create('data1', 'Data');
model.result.export('data1').setIndex('expr', 'T', 0);
model.result.export('data1').setIndex('unit', 'degC', 0);
model.result.export('data1').setIndex('descr', 'Temperature', 0);
model.result.export('data1').set('filename', 'thermal_bridge_2d_composite_structure_result.txt');
model.result.export('data1').set('location', 'grid');
model.result.export('data1').set('gridx2', '0,w,W');
model.result.export('data1').set('gridy2', '0,h4,h4+h2,h4+h2+h1');
model.result('pg1').run;

model.title(['Thermal Bridges in Building Construction ' native2unicode(hex2dec({'20' '14'}), 'unicode') ' 2D Composite Structure']);

model.description(['This example studies heat transfer in a composite two-dimensional structure made of four materials with different thermal conductivities.The temperature distribution and the heat flux through the structure are compared with published data. This example corresponds to Case' native2unicode(hex2dec({'00' 'a0'}), 'unicode') '2 in the European standard EN ISO 10211:2017 for thermal bridges in building constructions.']);

model.mesh.clearMeshes;

model.sol('sol1').clearSolutionData;

model.label('thermal_bridge_2d_composite_structure.mph');

model.modelNode.label('Components');

out = model;
