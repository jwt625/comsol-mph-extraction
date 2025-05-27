function out = model
%
% pinched_hemispherical_shell.m
%
% Model exported on May 26 2025, 21:34 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/Structural_Mechanics_Module/Verification_Examples');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 3);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.physics.create('shell', 'Shell', 'geom1');
model.physics('shell').model('comp1');

model.study.create('std1');
model.study('std1').create('stat', 'Stationary');
model.study('std1').feature('stat').setSolveFor('/physics/shell', true);

model.geom('geom1').create('sph1', 'Sphere');
model.geom('geom1').feature('sph1').set('r', 10);
model.geom('geom1').run('sph1');
model.geom('geom1').create('blk1', 'Block');
model.geom('geom1').feature('blk1').set('size', [10 10 10]);
model.geom('geom1').feature('blk1').set('pos', {'-5' '-5' '10*cos(18*pi/180)[m]'});
model.geom('geom1').run('blk1');
model.geom('geom1').create('dif1', 'Difference');
model.geom('geom1').feature('dif1').selection('input').set({'sph1'});
model.geom('geom1').feature('dif1').selection('input2').set({'blk1'});
model.geom('geom1').run('dif1');
model.geom('geom1').create('csur1', 'ConvertToSurface');
model.geom('geom1').feature('csur1').selection('input').set({'dif1'});
model.geom('geom1').run('csur1');
model.geom('geom1').create('del1', 'Delete');
model.geom('geom1').feature('del1').selection('input').set('csur1', [1 2 3 4 5 6 7 8]);
model.geom('geom1').run('del1');
model.geom('geom1').run;

model.material.create('mat1', 'Common', 'comp1');
model.material('mat1').label('Steel');
model.material('mat1').propertyGroup.create('Enu', 'Young''s_modulus_and_Poisson''s_ratio');
model.material('mat1').propertyGroup('Enu').set('E', {'68.25e6'});
model.material('mat1').propertyGroup('Enu').set('nu', {'0.3'});
model.material('mat1').propertyGroup('def').set('density', {'6850'});

model.physics('shell').feature('to1').set('d', 0.04);
model.physics('shell').create('sym1', 'SymmetrySolid1', 1);
model.physics('shell').feature('sym1').selection.set([1 4]);
model.physics('shell').create('disp1', 'Displacement0', 0);
model.physics('shell').feature('disp1').selection.set([4]);
model.physics('shell').feature('disp1').setIndex('Direction', 'prescribed', 2);
model.physics('shell').create('pl1', 'PointLoad', 0);
model.physics('shell').feature('pl1').label('Point Load, X');
model.physics('shell').feature('pl1').selection.set([4]);
model.physics('shell').feature('pl1').set('Fp', {'-100*para' '0' '0'});
model.physics('shell').create('pl2', 'PointLoad', 0);
model.physics('shell').feature('pl2').label('Point Load, Y');
model.physics('shell').feature('pl2').selection.set([2]);
model.physics('shell').feature('pl2').set('Fp', {'0' '100*para' '0'});

model.mesh('mesh1').create('map1', 'Map');
model.mesh('mesh1').feature('map1').selection.all;
model.mesh('mesh1').feature('map1').create('dis1', 'Distribution');
model.mesh('mesh1').feature('map1').feature('dis1').selection.set([1 4]);
model.mesh('mesh1').feature('map1').feature('dis1').set('type', 'predefined');
model.mesh('mesh1').feature('map1').feature('dis1').set('elemcount', 16);
model.mesh('mesh1').feature('map1').feature('dis1').set('elemratio', 3);
model.mesh('mesh1').feature('map1').feature('dis1').set('growthrate', 'exponential');
model.mesh('mesh1').feature('map1').create('dis2', 'Distribution');
model.mesh('mesh1').feature('map1').feature('dis2').selection.set([2 3]);
model.mesh('mesh1').feature('map1').feature('dis2').set('type', 'predefined');
model.mesh('mesh1').feature('map1').feature('dis2').set('elemcount', 16);
model.mesh('mesh1').feature('map1').feature('dis2').set('elemratio', 3);
model.mesh('mesh1').feature('map1').feature('dis2').set('symmetric', true);
model.mesh('mesh1').feature('map1').feature('dis2').set('growthrate', 'exponential');
model.mesh('mesh1').run;

model.param.set('para', '0');
model.param.descr('para', 'Solver parameter');

model.study('std1').feature('stat').set('geometricNonlinearity', true);
model.study('std1').feature('stat').set('useparam', true);
model.study('std1').feature('stat').setIndex('pname', 'para', 0);
model.study('std1').feature('stat').setIndex('plistarr', '', 0);
model.study('std1').feature('stat').setIndex('punit', '', 0);
model.study('std1').feature('stat').setIndex('pname', 'para', 0);
model.study('std1').feature('stat').setIndex('plistarr', '', 0);
model.study('std1').feature('stat').setIndex('punit', '', 0);
model.study('std1').feature('stat').setIndex('pname', 'para', 0);
model.study('std1').feature('stat').setIndex('plistarr', 'range(0,0.1,1)', 0);

model.sol.create('sol1');
model.sol('sol1').study('std1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'stat');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').feature('comp1_ar').set('scalemethod', 'manual');
model.sol('sol1').feature('v1').feature('comp1_ar').set('resscalemethod', 'parent');
model.sol('sol1').feature('v1').feature('comp1_ar').set('scaleval', '0.01');
model.sol('sol1').feature('v1').set('control', 'stat');
model.sol('sol1').create('s1', 'Stationary');
model.sol('sol1').feature('s1').create('p1', 'Parametric');
model.sol('sol1').feature('s1').feature.remove('pDef');
model.sol('sol1').feature('s1').feature('p1').set('control', 'stat');
model.sol('sol1').feature('s1').set('control', 'stat');
model.sol('sol1').feature('s1').feature('aDef').set('cachepattern', true);
model.sol('sol1').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('s1').feature('fc1').set('termonres', 'auto');
model.sol('sol1').feature('s1').feature('fc1').set('reserrfact', 1000);
model.sol('sol1').feature('s1').feature('fc1').set('linsolver', 'dDef');
model.sol('sol1').feature('s1').feature('fc1').set('termonres', 'auto');
model.sol('sol1').feature('s1').feature('fc1').set('reserrfact', 1000);
model.sol('sol1').feature('s1').feature.remove('fcDef');
model.sol('sol1').attach('std1');
model.sol('sol1').feature('s1').set('stol', '0.0001');
model.sol('sol1').feature('s1').feature('fc1').set('dtech', 'const');
model.sol('sol1').runAll;

model.result.dataset.create('dset1shellshl', 'Shell');
model.result.dataset('dset1shellshl').set('data', 'dset1');
model.result.dataset('dset1shellshl').setIndex('topconst', '1', 3, 1);
model.result.dataset('dset1shellshl').setIndex('bottomconst', '-1', 3, 1);
model.result.dataset('dset1shellshl').setIndex('orientationexpr', 'shell.nlX', 0);
model.result.dataset('dset1shellshl').setIndex('displacementexpr', 'arx', 0);
model.result.dataset('dset1shellshl').setIndex('orientationexpr', 'shell.nlY', 1);
model.result.dataset('dset1shellshl').setIndex('displacementexpr', 'ary', 1);
model.result.dataset('dset1shellshl').setIndex('orientationexpr', 'shell.nlZ', 2);
model.result.dataset('dset1shellshl').setIndex('displacementexpr', 'arz', 2);
model.result.dataset('dset1shellshl').set('distanceexpr', 'shell.z_pos');
model.result.dataset('dset1shellshl').set('seplevels', false);
model.result.dataset('dset1shellshl').set('resolution', 2);
model.result.dataset('dset1shellshl').set('areascalefactor', 'shell.ASF');
model.result.dataset('dset1shellshl').set('linescalefactor', 'shell.LSF');
model.result.create('pg1', 'PlotGroup3D');
model.result('pg1').set('data', 'dset1shellshl');
model.result('pg1').setIndex('looplevel', 11, 0);
model.result('pg1').set('defaultPlotID', 'stress');
model.result('pg1').label('Stress (shell)');
model.result('pg1').set('showlegends', true);
model.result('pg1').set('frametype', 'spatial');
model.result('pg1').create('surf1', 'Surface');
model.result('pg1').feature('surf1').set('expr', {'shell.misesGp'});
model.result('pg1').feature('surf1').set('threshold', 'manual');
model.result('pg1').feature('surf1').set('thresholdvalue', 0.2);
model.result('pg1').feature('surf1').set('colortable', 'Rainbow');
model.result('pg1').feature('surf1').set('colortabletrans', 'none');
model.result('pg1').feature('surf1').set('colorscalemode', 'linear');
model.result('pg1').feature('surf1').set('descr', 'von Mises stress');
model.result('pg1').feature('surf1').set('colortable', 'Prism');
model.result('pg1').feature('surf1').create('def', 'Deform');
model.result('pg1').feature('surf1').feature('def').set('expr', {'shell.u' 'shell.v' 'shell.w'});
model.result('pg1').feature('surf1').feature('def').set('scaleactive', true);
model.result('pg1').feature('surf1').feature('def').set('scale', '1');
model.result('pg1').run;
model.result('pg1').run;
model.result('pg1').feature('surf1').set('rangecoloractive', true);
model.result('pg1').feature('surf1').set('rangecolormax', '5e5');
model.result('pg1').run;
model.result.create('pg2', 'PlotGroup1D');
model.result('pg2').run;
model.result('pg2').create('ptgr1', 'PointGraph');
model.result('pg2').feature('ptgr1').set('markerpos', 'datapoints');
model.result('pg2').feature('ptgr1').set('linewidth', 'preference');
model.result('pg2').feature('ptgr1').selection.set([4]);
model.result('pg2').feature('ptgr1').set('expr', '-u');
model.result('pg2').feature('ptgr1').set('xdata', 'expr');
model.result('pg2').feature('ptgr1').set('xdataexpr', 'para*100[N]');
model.result('pg2').feature('ptgr1').set('linewidth', 3);
model.result('pg2').feature('ptgr1').set('legend', true);
model.result('pg2').feature('ptgr1').set('legendmethod', 'manual');
model.result('pg2').feature('ptgr1').setIndex('legends', '-u under x force', 0);
model.result('pg2').feature.duplicate('ptgr2', 'ptgr1');
model.result('pg2').run;
model.result('pg2').feature('ptgr2').selection.set([2]);
model.result('pg2').feature('ptgr2').set('expr', 'v');
model.result('pg2').feature('ptgr2').setIndex('legends', 'v under y force', 0);
model.result('pg2').run;
model.result('pg2').label('Displacement');
model.result('pg2').set('titletype', 'label');
model.result('pg2').set('xlabelactive', true);
model.result('pg2').set('xlabel', 'Force (N)');
model.result('pg2').set('ylabelactive', true);
model.result('pg2').set('ylabel', 'Displacement under force (m)');
model.result('pg2').set('legendpos', 'upperleft');
model.result('pg2').run;
model.result.evaluationGroup.create('eg1', 'EvaluationGroup');
model.result.evaluationGroup('eg1').setIndex('looplevelinput', 'last', 0);
model.result.evaluationGroup('eg1').set('transpose', true);
model.result.evaluationGroup('eg1').create('pev1', 'EvalPoint');
model.result.evaluationGroup('eg1').feature('pev1').selection.set([2 4]);
model.result.evaluationGroup('eg1').feature('pev1').setIndex('expr', 'u', 0);
model.result.evaluationGroup('eg1').feature('pev1').setIndex('unit', 'm', 0);
model.result.evaluationGroup('eg1').feature('pev1').setIndex('descr', 'Displacement field, X component', 0);
model.result.evaluationGroup('eg1').feature('pev1').setIndex('expr', 'v', 1);
model.result.evaluationGroup('eg1').feature('pev1').setIndex('unit', 'm', 1);
model.result.evaluationGroup('eg1').feature('pev1').setIndex('descr', 'Displacement field, Y component', 1);
model.result.evaluationGroup('eg1').run;
model.result('pg1').run;

model.title('Pinched Hemispherical Shell');

model.description('This benchmark studies the nonlinear deformation of a hemispherical shell.');

model.label('pinched_hemispherical_shell.mph');

model.modelNode.label('Components');

out = model;
