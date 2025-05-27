function out = model
%
% permanent_magnet.m
%
% Model exported on May 26 2025, 21:25 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/ACDC_Module/Introductory_Magnetostatics');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 3);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.physics.create('mfnc', 'MagnetostaticsNoCurrents', 'geom1');
model.physics('mfnc').model('comp1');

model.study.create('std1');
model.study('std1').create('stat', 'Stationary');
model.study('std1').feature('stat').setSolveFor('/physics/mfnc', true);

model.geom('geom1').create('imp1', 'Import');
model.geom('geom1').feature('imp1').set('filename', 'permanent_magnet.mphbin');
model.geom('geom1').feature('imp1').importData;
model.geom('geom1').create('blk1', 'Block');
model.geom('geom1').feature('blk1').set('size', [0.25 0.1 0.1]);
model.geom('geom1').feature('blk1').set('pos', [-0.1 0 0]);
model.geom('geom1').run('blk1');
model.geom('geom1').create('co1', 'Compose');
model.geom('geom1').feature('co1').selection('input').set({'blk1' 'imp1'});
model.geom('geom1').feature('co1').set('formula', 'blk1+imp1*blk1');
model.geom('geom1').runPre('fin');
model.geom('geom1').run;

model.material.create('mat1', 'Common', 'comp1');
model.material('mat1').label('Iron');
model.material('mat1').selection.set([2 4]);
model.material('mat1').propertyGroup('def').set('relpermeability', {'4000'});
model.material.create('mat2', 'Common', 'comp1');
model.material('mat2').label('Air');
model.material('mat2').selection.set([1]);
model.material('mat2').propertyGroup('def').set('relpermeability', {'1'});
model.material.create('mat3', 'Common', 'comp1');
model.material('mat3').propertyGroup.create('RemanentFluxDensity', 'Remanent flux density');
model.material('mat3').label('N54 (Sintered NdFeB)');
model.material('mat3').set('family', 'chrome');
model.material('mat3').propertyGroup('def').set('electricconductivity', {'1/1.4[uohm*m]' '0' '0' '0' '1/1.4[uohm*m]' '0' '0' '0' '1/1.4[uohm*m]'});
model.material('mat3').propertyGroup('def').set('relpermittivity', {'1' '0' '0' '0' '1' '0' '0' '0' '1'});
model.material('mat3').propertyGroup('RemanentFluxDensity').set('murec', {'1.05' '0' '0' '0' '1.05' '0' '0' '0' '1.05'});
model.material('mat3').propertyGroup('RemanentFluxDensity').set('normBr', '1.47[T]');
model.material('mat3').selection.set([3]);

model.physics('mfnc').create('mag1', 'Magnet', 3);
model.physics('mfnc').feature('mag1').selection.set([3]);
model.physics('mfnc').feature('mag1').feature('north1').selection.set([17]);
model.physics('mfnc').feature('mag1').feature('south1').selection.set([12]);
model.physics('mfnc').create('symp1', 'SymmetryPlane', 2);
model.physics('mfnc').feature('symp1').selection.set([2 8 24]);
model.physics('mfnc').feature('symp1').set('Symmetry_type', 'Antisymmetry');
model.physics('mfnc').create('fcal1', 'ForceCalculation', 3);
model.physics('mfnc').feature('fcal1').selection.set([2]);
model.physics('mfnc').feature('fcal1').set('ForceName', 'rod');

model.mesh('mesh1').create('ftet1', 'FreeTet');
model.mesh('mesh1').feature('size').set('hauto', 4);
model.mesh('mesh1').feature('ftet1').create('size1', 'Size');
model.mesh('mesh1').feature('ftet1').feature('size1').selection.geom('geom1', 3);
model.mesh('mesh1').feature('ftet1').feature('size1').selection.set([2 3 4]);
model.mesh('mesh1').feature('ftet1').feature('size1').set('custom', true);
model.mesh('mesh1').feature('ftet1').feature('size1').set('hmaxactive', true);
model.mesh('mesh1').feature('ftet1').feature('size1').set('hmax', 0.0025);
model.mesh('mesh1').run;

model.study('std1').setGenPlots(false);

model.sol.create('sol1');
model.sol('sol1').study('std1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'stat');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').set('control', 'stat');
model.sol('sol1').create('s1', 'Stationary');
model.sol('sol1').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('s1').create('i1', 'Iterative');
model.sol('sol1').feature('s1').feature('i1').set('linsolver', 'gmres');
model.sol('sol1').feature('s1').feature('i1').set('nlinnormuse', true);
model.sol('sol1').feature('s1').feature('i1').set('prefuntype', 'right');
model.sol('sol1').feature('s1').feature('i1').create('mg1', 'Multigrid');
model.sol('sol1').feature('s1').feature('fc1').set('linsolver', 'i1');
model.sol('sol1').feature('s1').feature.remove('fcDef');
model.sol('sol1').attach('std1');
model.sol('sol1').runAll;

model.result.create('pg1', 'PlotGroup3D');
model.result('pg1').run;
model.result('pg1').create('slc1', 'Slice');
model.result('pg1').feature('slc1').set('expr', 'mfnc.normB');
model.result('pg1').feature('slc1').set('descr', 'Magnetic flux density norm');
model.result('pg1').feature('slc1').set('quickplane', 'xy');
model.result('pg1').feature('slc1').set('quickzmethod', 'coord');
model.result('pg1').feature('slc1').set('quickz', 0.005);
model.result('pg1').feature('slc1').set('colortable', 'GrayBody');
model.result('pg1').run;
model.result('pg1').run;
model.result('pg1').create('arwv1', 'ArrowVolume');
model.result('pg1').feature('arwv1').set('expr', {'mfnc.Bx' 'mfnc.By' 'mfnc.Bz'});
model.result('pg1').feature('arwv1').set('descr', 'Magnetic flux density');
model.result('pg1').feature('arwv1').set('xnumber', 100);
model.result('pg1').feature('arwv1').set('ynumber', 50);
model.result('pg1').feature('arwv1').set('arrowzmethod', 'coord');
model.result('pg1').feature('arwv1').set('zcoord', 0.0051);
model.result('pg1').run;
model.result.dataset.create('mir1', 'Mirror3D');
model.result.dataset('mir1').label('Symmetry Condition');
model.result.dataset('mir1').set('quickplane', 'xy');
model.result.dataset.create('mir2', 'Mirror3D');
model.result.dataset('mir2').label('Antisymmetry Condition');
model.result.dataset('mir2').set('data', 'mir1');
model.result.dataset('mir2').set('quickplane', 'zx');
model.result.dataset('mir2').set('vectortrans', 'antisymmetric');
model.result('pg1').run;
model.result('pg1').set('data', 'mir2');
model.result('pg1').run;
model.result('pg1').run;
model.result('pg1').feature('arwv1').set('expr', {'mfnc.Bx' 'mfnc.By' 'mfnc.Bz'});
model.result('pg1').feature('arwv1').set('descr', 'Magnetic flux density');
model.result('pg1').run;
model.result('pg1').run;
model.result.numerical.create('gev1', 'EvalGlobal');
model.result.numerical('gev1').set('expr', {'mfnc.Forcex_rod'});
model.result.numerical('gev1').set('descr', {'Electromagnetic force, x-component'});
model.result.numerical('gev1').set('unit', {'N'});
model.result.numerical('gev1').setIndex('expr', 'mfnc.Forcex_rod*4', 0);
model.result.numerical('gev1').setIndex('descr', 'Total force on the rod', 0);
model.result.table.create('tbl1', 'Table');
model.result.table('tbl1').comments('Global Evaluation 1');
model.result.numerical('gev1').set('table', 'tbl1');
model.result.numerical('gev1').setResult;

model.title('Permanent Magnet');

model.description('This example studies the magnetostatic force between an iron rod and a permanent magnet.');

model.mesh.clearMeshes;

model.sol('sol1').clearSolutionData;

model.label('permanent_magnet.mph');

model.modelNode.label('Components');

out = model;
