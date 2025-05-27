function out = model
%
% thermal_bridge_3d_iron_bar.m
%
% Model exported on May 26 2025, 21:28 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/Heat_Transfer_Module/Buildings_and_Constructions');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 3);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.physics.create('ht', 'HeatTransfer', 'geom1');
model.physics('ht').model('comp1');

model.study.create('std1');
model.study('std1').create('stat', 'Stationary');
model.study('std1').feature('stat').setSolveFor('/physics/ht', true);

model.param.set('w1', '1[m]');
model.param.descr('w1', 'Insulation layer width');
model.param.set('d1', '0.2[m]');
model.param.descr('d1', 'Insulation layer depth');
model.param.set('h1', '1[m]');
model.param.descr('h1', 'Insulation layer height');
model.param.set('w2', '0.1[m]');
model.param.descr('w2', 'Iron bar width');
model.param.set('d2', '0.6[m]');
model.param.descr('d2', 'Iron bar depth');
model.param.set('h2', '50[mm]');
model.param.descr('h2', 'Iron bar height');

model.geom('geom1').create('blk1', 'Block');
model.geom('geom1').feature('blk1').set('size', {'w1' 'd1' 'h1'});
model.geom('geom1').run('blk1');
model.geom('geom1').create('blk2', 'Block');
model.geom('geom1').feature('blk2').set('size', {'w2' 'd2' 'h2'});
model.geom('geom1').feature('blk2').set('pos', {'w1/2-w2/2' '0' 'h1/2-h2/2'});
model.geom('geom1').run('blk2');

model.view('view1').set('renderwireframe', true);

model.geom('geom1').run('fin');
model.geom('geom1').create('igf1', 'IgnoreFaces');
model.geom('geom1').feature('igf1').selection('input').set('fin', 11);
model.geom('geom1').run('igf1');

model.selection.create('box1', 'Box');
model.selection('box1').model('comp1');
model.selection('box1').label('Internal');
model.selection('box1').set('entitydim', 2);
model.selection('box1').set('ymin', 0.1);
model.selection('box1').set('condition', 'inside');
model.selection.create('box2', 'Box');
model.selection('box2').model('comp1');
model.selection('box2').label('External');
model.selection('box2').set('entitydim', 2);
model.selection('box2').set('ymax', 0.1);
model.selection('box2').set('condition', 'inside');

model.view('view1').set('renderwireframe', false);

model.material.create('mat1', 'Common', 'comp1');
model.material('mat1').label('Insulation');
model.material('mat1').selection.set([1]);
model.material('mat1').propertyGroup('def').set('thermalconductivity', {'0.1'});
model.material('mat1').propertyGroup('def').set('density', {'500'});
model.material('mat1').propertyGroup('def').set('heatcapacity', {'1700'});
model.material.create('mat2', 'Common', 'comp1');
model.material('mat2').label('Iron');
model.material('mat2').selection.set([2]);
model.material('mat2').propertyGroup('def').set('thermalconductivity', {'50'});
model.material('mat2').propertyGroup('def').set('density', {'7800'});
model.material('mat2').propertyGroup('def').set('heatcapacity', {'460'});

model.physics('ht').create('hf1', 'HeatFluxBoundary', 2);
model.physics('ht').feature('hf1').selection.named('box1');
model.physics('ht').feature('hf1').set('HeatFluxType', 'ConvectiveHeatFlux');
model.physics('ht').feature('hf1').set('h', '1/0.10');
model.physics('ht').feature('hf1').set('Text', '1[degC]');
model.physics('ht').create('hf2', 'HeatFluxBoundary', 2);
model.physics('ht').feature('hf2').selection.named('box2');
model.physics('ht').feature('hf2').set('HeatFluxType', 'ConvectiveHeatFlux');
model.physics('ht').feature('hf2').set('h', '1/0.10');
model.physics('ht').feature('hf2').set('Text', '0[degC]');

model.mesh('mesh1').create('ftet1', 'FreeTet');
model.mesh('mesh1').feature('ftet1').feature.create('size1', 'Size');
model.mesh('mesh1').feature('ftet1').feature('size1').set('hauto', 1);
model.mesh('mesh1').feature('ftet1').feature('size1').selection.geom('geom1', 3);
model.mesh('mesh1').feature('ftet1').feature('size1').selection.set([2]);
model.mesh('mesh1').run;

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

model.result.create('pg1', 'PlotGroup3D');
model.result('pg1').label('Temperature (ht)');
model.result('pg1').set('data', 'dset1');
model.result('pg1').set('defaultPlotID', 'ht/HT_PhysicsInterfaces/icom8/pdef1/pcond3/pcond3/pg1');
model.result('pg1').feature.create('vol1', 'Volume');
model.result('pg1').feature('vol1').set('showsolutionparams', 'on');
model.result('pg1').feature('vol1').set('solutionparams', 'parent');
model.result('pg1').feature('vol1').set('colortable', 'HeatCameraLight');
model.result('pg1').feature('vol1').set('smooth', 'internal');
model.result('pg1').feature('vol1').set('showsolutionparams', 'on');
model.result('pg1').feature('vol1').set('data', 'parent');
model.result('pg1').run;
model.result('pg1').run;
model.result('pg1').feature('vol1').set('unit', 'degC');
model.result.numerical.create('max1', 'MaxSurface');
model.result.numerical('max1').selection.named('box2');
model.result.numerical('max1').setIndex('unit', 'degC', 0);
model.result.table.create('tbl1', 'Table');
model.result.table('tbl1').comments('Surface Maximum 1');
model.result.numerical('max1').set('table', 'tbl1');
model.result.numerical('max1').setResult;
model.result.numerical.create('int1', 'IntSurface');
model.result.numerical('int1').set('intvolume', true);
model.result.numerical('int1').selection.named('box2');
model.result.numerical('int1').set('expr', {'ht.q0'});
model.result.numerical('int1').set('descr', {'Inward heat flux'});
model.result.numerical('int1').set('unit', {'W'});
model.result.table.create('tbl2', 'Table');
model.result.table('tbl2').comments('Surface Integration 1');
model.result.numerical('int1').set('table', 'tbl2');
model.result.numerical('int1').setResult;
model.result('pg1').run;

model.title(['Thermal Bridges in Building Construction ' native2unicode(hex2dec({'20' '14'}), 'unicode') ' 3D Iron Bar Through Insulation Layer']);

model.description(['This example studies the heat conduction in a thermal bridge made up of an iron bar and an insulation layer that separates a hot internal side from a cold external side. This example corresponds to Case' native2unicode(hex2dec({'00' 'a0'}), 'unicode') '4 in the European standard EN ISO 10211:2017 for thermal bridges in building constructions.']);

model.mesh.clearMeshes;

model.sol('sol1').clearSolutionData;

model.label('thermal_bridge_3d_iron_bar.mph');

model.modelNode.label('Components');

out = model;
