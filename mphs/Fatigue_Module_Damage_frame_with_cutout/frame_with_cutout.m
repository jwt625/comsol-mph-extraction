function out = model
%
% frame_with_cutout.m
%
% Model exported on May 26 2025, 21:28 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/Fatigue_Module/Damage');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 3);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.physics.create('shell', 'Shell', 'geom1');
model.physics('shell').model('comp1');

model.study.create('std1');
model.study('std1').create('stat', 'Stationary');
model.study('std1').feature('stat').setSolveFor('/physics/shell', true);

model.param.set('M', '1 [N*m]');
model.param.descr('M', 'Unit moment');
model.param.set('pt', '6 [mm]');
model.param.descr('pt', 'Frame thickness');
model.param.set('ch', '80 [mm]');
model.param.descr('ch', 'Hole height');
model.param.set('cw', '100 [mm]');
model.param.descr('cw', 'Hole width');
model.param.set('cr', '10 [mm]');
model.param.descr('cr', 'Hole radius');

model.geom('geom1').create('blk1', 'Block');
model.geom('geom1').feature('blk1').set('size', [1.1 0.154 0.154]);
model.geom('geom1').feature('blk1').set('base', 'center');
model.geom('geom1').run('blk1');
model.geom('geom1').create('wp1', 'WorkPlane');
model.geom('geom1').feature('wp1').set('unite', true);
model.geom('geom1').feature('wp1').set('planetype', 'faceparallel');
model.geom('geom1').feature('wp1').selection('face').set('blk1', 3);
model.geom('geom1').feature('wp1').geom.create('r1', 'Rectangle');
model.geom('geom1').feature('wp1').geom.feature('r1').set('base', 'center');
model.geom('geom1').feature('wp1').geom.feature('r1').set('size', {'ch' 'cw'});
model.geom('geom1').feature('wp1').geom.run('r1');
model.geom('geom1').feature('wp1').geom.create('fil1', 'Fillet');
model.geom('geom1').feature('wp1').geom.feature('fil1').selection('pointinsketch').set('r1', [1 2 3 4]);
model.geom('geom1').feature('wp1').geom.feature('fil1').set('radius', 'cr');
model.geom('geom1').run('wp1');
model.geom('geom1').create('pt1', 'Point');
model.geom('geom1').feature('pt1').setIndex('p', 0.3, 0);
model.geom('geom1').feature('pt1').setIndex('p', -0.077, 2);
model.geom('geom1').run('pt1');
model.geom('geom1').create('pt2', 'Point');
model.geom('geom1').feature('pt2').setIndex('p', 0.3, 0);
model.geom('geom1').feature('pt2').setIndex('p', 0.077, 1);
model.geom('geom1').runPre('fin');

model.coordSystem.create('sys2', 'geom1', 'VectorBase');

model.geom('geom1').run;

model.coordSystem('sys2').setIndex('base', 'cos(pi/4)', 0, 0);
model.coordSystem('sys2').setIndex('base', 'sin(pi/4)', 0, 1);
model.coordSystem('sys2').setIndex('base', '-sin(pi/4)', 1, 0);
model.coordSystem('sys2').setIndex('base', 'cos(pi/4)', 1, 1);
model.coordSystem('sys2').set('orthonormal', true);

model.view('view1').set('renderwireframe', true);

model.physics('shell').selection.set([2 3 4 5]);
model.physics('shell').feature('to1').set('d', 'pt');
model.physics('shell').create('emm2', 'Elastic', 2);
model.physics('shell').feature('emm2').selection.set([3]);
model.physics('shell').feature('emm2').feature('shls1').set('coordinateSystem', 'sys2');
model.physics('shell').create('disp1', 'Displacement1', 1);
model.physics('shell').feature('disp1').selection.set([1 2 4 6]);
model.physics('shell').feature('disp1').setIndex('Direction', 'prescribed', 0);
model.physics('shell').feature('disp1').setIndex('Direction', 'prescribed', 1);
model.physics('shell').feature('disp1').setIndex('Direction', 'prescribed', 2);
model.physics('shell').create('srig1', 'RigidConnectorShell', 1);
model.physics('shell').feature('srig1').selection.set([17 18 19 20]);
model.physics('shell').feature('srig1').create('rm1', 'RigidBodyMoment', -1);
model.physics('shell').feature('srig1').feature('rm1').set('Mt', {'M' '0' '0'});
model.physics('shell').feature('srig1').feature('rm1').label('Twisting Moment (x)');
model.physics('shell').feature('srig1').create('rm2', 'RigidBodyMoment', -1);
model.physics('shell').feature('srig1').feature('rm2').set('Mt', {'0' 'M' '0'});
model.physics('shell').feature('srig1').feature('rm2').label('Bending Moment (y)');
model.physics('shell').feature('srig1').create('rm3', 'RigidBodyMoment', -1);
model.physics('shell').feature('srig1').feature('rm3').set('Mt', {'0' '0' 'M'});
model.physics('shell').feature('srig1').feature('rm3').label('Bending Moment (z)');

model.group.create('lg1', 'LoadGroup');

model.physics('shell').feature('srig1').feature('rm1').set('loadGroup', 'lg1');

model.group.create('lg2', 'LoadGroup');

model.physics('shell').feature('srig1').feature('rm2').set('loadGroup', 'lg2');

model.group.create('lg3', 'LoadGroup');

model.physics('shell').feature('srig1').feature('rm3').set('loadGroup', 'lg3');

model.group('lg1').label('Load Group: Mx');
model.group('lg1').paramName('lgX');
model.group('lg2').label('Load Group: My');
model.group('lg2').paramName('lgY');
model.group('lg3').label('Load Group: Mz');
model.group('lg3').paramName('lgZ');

model.material.create('mat1', 'Common', 'comp1');
model.material('mat1').selection.set([2 3 4 5]);
model.material('mat1').propertyGroup.create('Enu', 'Young''s_modulus_and_Poisson''s_ratio');
model.material('mat1').propertyGroup('Enu').set('E', {'200e9'});
model.material('mat1').propertyGroup('Enu').set('nu', {'0.33'});
model.material('mat1').propertyGroup('def').set('density', {'7800'});

model.mesh('mesh1').autoMeshSize(1);
model.mesh('mesh1').run;

model.study('std1').feature('stat').set('useloadcase', true);
model.study('std1').feature('stat').setIndex('loadcase', 'Load case 1', 0);
model.study('std1').feature('stat').setIndex('loadgroup', false, 0, 0);
model.study('std1').feature('stat').setIndex('loadgroupweight', '1.0', 0, 0);
model.study('std1').feature('stat').setIndex('loadgroup', false, 0, 1);
model.study('std1').feature('stat').setIndex('loadgroupweight', '1.0', 0, 1);
model.study('std1').feature('stat').setIndex('loadgroup', false, 0, 2);
model.study('std1').feature('stat').setIndex('loadgroupweight', '1.0', 0, 2);
model.study('std1').feature('stat').setIndex('loadcase', 'Load case 1', 0);
model.study('std1').feature('stat').setIndex('loadgroup', false, 0, 0);
model.study('std1').feature('stat').setIndex('loadgroupweight', '1.0', 0, 0);
model.study('std1').feature('stat').setIndex('loadgroup', false, 0, 1);
model.study('std1').feature('stat').setIndex('loadgroupweight', '1.0', 0, 1);
model.study('std1').feature('stat').setIndex('loadgroup', false, 0, 2);
model.study('std1').feature('stat').setIndex('loadgroupweight', '1.0', 0, 2);
model.study('std1').feature('stat').setIndex('loadcase', 'Load case 2', 1);
model.study('std1').feature('stat').setIndex('loadgroup', false, 1, 0);
model.study('std1').feature('stat').setIndex('loadgroupweight', '1.0', 1, 0);
model.study('std1').feature('stat').setIndex('loadgroup', false, 1, 1);
model.study('std1').feature('stat').setIndex('loadgroupweight', '1.0', 1, 1);
model.study('std1').feature('stat').setIndex('loadgroup', false, 1, 2);
model.study('std1').feature('stat').setIndex('loadgroupweight', '1.0', 1, 2);
model.study('std1').feature('stat').setIndex('loadcase', 'Load case 2', 1);
model.study('std1').feature('stat').setIndex('loadgroup', false, 1, 0);
model.study('std1').feature('stat').setIndex('loadgroupweight', '1.0', 1, 0);
model.study('std1').feature('stat').setIndex('loadgroup', false, 1, 1);
model.study('std1').feature('stat').setIndex('loadgroupweight', '1.0', 1, 1);
model.study('std1').feature('stat').setIndex('loadgroup', false, 1, 2);
model.study('std1').feature('stat').setIndex('loadgroupweight', '1.0', 1, 2);
model.study('std1').feature('stat').setIndex('loadcase', 'Load case 3', 2);
model.study('std1').feature('stat').setIndex('loadgroup', false, 2, 0);
model.study('std1').feature('stat').setIndex('loadgroupweight', '1.0', 2, 0);
model.study('std1').feature('stat').setIndex('loadgroup', false, 2, 1);
model.study('std1').feature('stat').setIndex('loadgroupweight', '1.0', 2, 1);
model.study('std1').feature('stat').setIndex('loadgroup', false, 2, 2);
model.study('std1').feature('stat').setIndex('loadgroupweight', '1.0', 2, 2);
model.study('std1').feature('stat').setIndex('loadcase', 'Load case 3', 2);
model.study('std1').feature('stat').setIndex('loadgroup', false, 2, 0);
model.study('std1').feature('stat').setIndex('loadgroupweight', '1.0', 2, 0);
model.study('std1').feature('stat').setIndex('loadgroup', false, 2, 1);
model.study('std1').feature('stat').setIndex('loadgroupweight', '1.0', 2, 1);
model.study('std1').feature('stat').setIndex('loadgroup', false, 2, 2);
model.study('std1').feature('stat').setIndex('loadgroupweight', '1.0', 2, 2);
model.study('std1').feature('stat').setIndex('loadcase', 'Load case X', 0);
model.study('std1').feature('stat').setIndex('loadgroup', true, 0, 0);
model.study('std1').feature('stat').setIndex('loadcase', 'Load case Y', 1);
model.study('std1').feature('stat').setIndex('loadgroup', true, 1, 1);
model.study('std1').feature('stat').setIndex('loadcase', 'Load case Z', 2);
model.study('std1').feature('stat').setIndex('loadgroup', true, 2, 2);
model.study('std1').label('Study: Generalized Loads');

model.sol.create('sol1');
model.sol('sol1').study('std1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'stat');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').feature('comp1_shell_rig_disp').set('scalemethod', 'manual');
model.sol('sol1').feature('v1').feature('comp1_ar').set('scalemethod', 'manual');
model.sol('sol1').feature('v1').feature('comp1_shell_rig_rot').set('scalemethod', 'manual');
model.sol('sol1').feature('v1').feature('comp1_u').set('scalemethod', 'manual');
model.sol('sol1').feature('v1').feature('comp1_shell_rig_disp').set('resscalemethod', 'parent');
model.sol('sol1').feature('v1').feature('comp1_ar').set('resscalemethod', 'parent');
model.sol('sol1').feature('v1').feature('comp1_shell_rig_rot').set('resscalemethod', 'parent');
model.sol('sol1').feature('v1').feature('comp1_shell_rig_disp').set('scaleval', '0.011213527544889702');
model.sol('sol1').feature('v1').feature('comp1_ar').set('scaleval', '0.01');
model.sol('sol1').feature('v1').feature('comp1_shell_rig_rot').set('scaleval', '0.01');
model.sol('sol1').feature('v1').feature('comp1_u').set('scaleval', '1e-2*1.12135275448897');
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
model.result('pg1').setIndex('looplevel', 3, 0);
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
model.result('pg1').run;
model.result.numerical.create('pev1', 'EvalPoint');
model.result.numerical('pev1').selection.set([13]);
model.result.numerical('pev1').set('expr', {'shell.el11'});
model.result.numerical('pev1').set('descr', {'Strain tensor, local coordinate system, 11-component'});
model.result.numerical('pev1').set('unit', {'1'});
model.result.numerical('pev1').setIndex('descr', 'e1', 0);
model.result.numerical('pev1').setIndex('const', 1, 0, 1);
model.result.table.create('tbl1', 'Table');
model.result.table('tbl1').comments('Point Evaluation 1');
model.result.numerical('pev1').set('table', 'tbl1');
model.result.numerical('pev1').setResult;
model.result.numerical.duplicate('pev2', 'pev1');
model.result.numerical('pev2').set('expr', {'shell.el22'});
model.result.numerical('pev2').set('descr', {'Strain tensor, local coordinate system, 22-component'});
model.result.numerical('pev2').set('unit', {'1'});
model.result.numerical('pev2').setIndex('descr', 'e2', 0);
model.result.numerical('pev2').set('table', 'tbl1');
model.result.numerical('pev2').appendResult;
model.result.numerical.duplicate('pev3', 'pev1');
model.result.numerical('pev3').selection.set([14]);
model.result.numerical('pev3').setIndex('descr', 'e3', 0);
model.result.numerical('pev3').set('table', 'tbl1');
model.result.numerical('pev3').appendResult;

model.func.create('int1', 'Interpolation');
model.func('int1').set('source', 'file');
model.func('int1').set('filename', 'frame_with_cutout_sn_curve.txt');
model.func('int1').importData;
model.func.create('int2', 'Interpolation');
model.func('int2').set('source', 'file');
model.func('int2').set('filename', 'frame_with_cutout_load.txt');
model.func('int2').set('nargs', 1);
model.func('int2').importData;
model.func('int2').setIndex('funcs', 'fX', 0, 0);
model.func('int2').setIndex('funcs', 1, 0, 1);
model.func('int2').setIndex('funcs', 'fY', 1, 0);
model.func('int2').setIndex('funcs', 2, 1, 1);
model.func('int2').setIndex('funcs', 'fZ', 2, 0);
model.func('int2').setIndex('funcs', 3, 2, 1);

model.physics.create('ftg', 'Fatigue', 'geom1');
model.physics('ftg').model('comp1');

model.study('std1').feature('stat').setSolveFor('/physics/ftg', false);

model.physics('ftg').label('Fatigue Outside');
model.physics('ftg').create('cdam1', 'CumulativeDamageModel2', 1);
model.physics('ftg').feature('cdam1').selection.set([9 10 11 12 13 14 15 16]);
model.physics('ftg').feature('cdam1').set('fatigueInputPhysics', 'shell');
model.physics('ftg').feature('cdam1').set('throughThicknessLocation', 'topOfShell');
model.physics('ftg').feature('cdam1').set('cDamAnalysisType', 'cDamTypeGeneralized');
model.physics('ftg').feature('cdam1').set('cDamDiscretizationRange', 20);
model.physics('ftg').feature('cdam1').set('m', 10000);
model.physics('ftg').feature('cdam1').set('lifeCurve', 'int1');
model.physics('ftg').feature('cdam1').set('sf', 1000);
model.physics('ftg').feature('cdam1').setIndex('cDamGenLoadHistory', 0, 0, 0);
model.physics('ftg').feature('cdam1').setIndex('cDamGenLoadHistory', 0, 0, 0);
model.physics('ftg').feature('cdam1').setIndex('cDamGenLoadHistory', 0, 1, 0);
model.physics('ftg').feature('cdam1').setIndex('cDamGenLoadHistory', 0, 1, 0);
model.physics('ftg').feature('cdam1').setIndex('cDamGenLoadHistory', 0, 2, 0);
model.physics('ftg').feature('cdam1').setIndex('cDamGenLoadHistory', 0, 2, 0);
model.physics('ftg').feature('cdam1').setIndex('cDamGenLoadHistory', 'fX', 0, 0);
model.physics('ftg').feature('cdam1').setIndex('cDamGenLoadHistory', 'fY', 1, 0);
model.physics('ftg').feature('cdam1').setIndex('cDamGenLoadHistory', 'fZ', 2, 0);

model.study.create('std2');
model.study('std2').create('ftge', 'Fatigue');
model.study('std2').feature('ftge').set('solnum', 'auto');
model.study('std2').feature('ftge').set('usesol', 'off');
model.study('std2').feature('ftge').setSolveFor('/physics/shell', false);
model.study('std2').feature('ftge').setSolveFor('/physics/ftg', true);
model.study('std2').feature('ftge').set('usesol', true);
model.study('std2').feature('ftge').set('notsolmethod', 'sol');
model.study('std2').feature('ftge').set('notstudy', 'std1');
model.study('std2').label('Study: Fatigue Outside');

model.sol.create('sol2');
model.sol('sol2').study('std2');
model.sol('sol2').create('st1', 'StudyStep');
model.sol('sol2').feature('st1').set('study', 'std2');
model.sol('sol2').feature('st1').set('studystep', 'ftge');
model.sol('sol2').create('v1', 'Variables');
model.sol('sol2').feature('v1').set('control', 'ftge');
model.sol('sol2').create('s1', 'Stationary');
model.sol('sol2').attach('std2');
model.sol('sol2').runAll;

model.result.create('pg2', 'PlotGroup1D');
model.result('pg2').set('data', 'dset2');
model.result('pg2').create('lngr1', 'LineGraph');
model.result('pg2').feature('lngr1').set('expr', 'root.comp1.ftg.fus');
model.result('pg2').feature('lngr1').set('xdata', 'arc');
model.result('pg2').feature('lngr1').selection.geom('geom1', 1);
model.result('pg2').feature('lngr1').selection.set([9 10 11 12 13 14 15 16]);
model.result('pg2').feature('lngr1').selection.inherit(false);
model.result('pg2').label('Fatigue Usage Factor (ftg)');
model.result.create('pg3', 'PlotGroup2D');
model.result('pg3').set('data', 'none');
model.result('pg3').create('hist1', 'MatrixHistogram');
model.result('pg3').feature('hist1').set('data', 'dset2');
model.result('pg3').feature('hist1').set('expr', 'ftg.cdam1.csc');
model.result('pg3').label('Stress Cycle Distribution (ftg)');
model.result('pg3').feature('hist1').set('xdata', 'Mean stress');
model.result('pg3').feature('hist1').set('ydata', 'Stress amplitude');
model.result('pg3').feature('hist1').create('hght', 'HistogramHeight');
model.result('pg3').feature('hist1').feature('hght').label('Height expression (for 3D histogram)');
model.result.create('pg4', 'PlotGroup2D');
model.result('pg4').set('data', 'none');
model.result('pg4').create('hist1', 'MatrixHistogram');
model.result('pg4').feature('hist1').set('data', 'dset2');
model.result('pg4').feature('hist1').set('expr', 'ftg.cdam1.rus');
model.result('pg4').label('Fatigue Usage Distribution (ftg)');
model.result('pg4').feature('hist1').set('xdata', 'Mean stress');
model.result('pg4').feature('hist1').set('ydata', 'Stress amplitude');
model.result('pg4').feature('hist1').create('hght', 'HistogramHeight');
model.result('pg4').feature('hist1').feature('hght').label('Height expression (for 3D histogram)');
model.result('pg2').run;

model.nodeGroup.create('grp1', 'Results');
model.nodeGroup('grp1').set('type', 'plotgroup');
model.nodeGroup('grp1').placeAfter('plotgroup', 'pg1');
model.nodeGroup('grp1').add('plotgroup', 'pg2');
model.nodeGroup('grp1').add('plotgroup', 'pg3');
model.nodeGroup('grp1').add('plotgroup', 'pg4');
model.nodeGroup('grp1').label('Fatigue Outside');

model.result('pg2').run;
model.result('pg2').run;
model.result('pg2').feature('lngr1').set('xdata', 'expr');
model.result('pg2').feature('lngr1').set('xdataexpr', 'atan2(z-0.03,x-0.04)*(dom==15)+atan2(abs(z-0.03),x+0.04)*(dom==11)+atan2(z+0.03,x+0.04)*(dom==10)+atan2(z+0.03,x-0.04)*(dom==14)');
model.result('pg2').feature('lngr1').set('xdataunit', [native2unicode(hex2dec({'00' 'b0'}), 'unicode') ]);
model.result('pg2').feature('lngr1').set('xdatadescractive', true);
model.result('pg2').feature('lngr1').set('xdatadescr', 'Cutout angle');
model.result('pg2').run;
model.result('pg2').run;
model.result('pg2').label('Fatigue Usage Factor Outside (ftg)');
model.result('pg3').run;
model.result('pg3').label('Stress Cycle Distribution Outside (ftg)');
model.result('pg3').run;
model.result('pg3').feature('hist1').set('axisunit', 'MPa');
model.result('pg3').run;
model.result('pg4').run;
model.result('pg4').label('Fatigue Usage Distribution Outside (ftg)');
model.result('pg4').run;
model.result('pg4').feature('hist1').set('axisunit', 'MPa');
model.result('pg4').run;

model.physics.create('ftg2', 'Fatigue', 'geom1');
model.physics('ftg2').model('comp1');

model.study('std1').feature('stat').setSolveFor('/physics/ftg2', false);
model.study('std2').feature('ftge').setSolveFor('/physics/ftg2', false);

model.physics('ftg2').label('Fatigue Inside');
model.physics('ftg2').create('cdam1', 'CumulativeDamageModel2', 1);
model.physics('ftg2').feature('cdam1').selection.set([9 10 11 12 13 14 15 16]);
model.physics('ftg2').feature('cdam1').set('fatigueInputPhysics', 'shell');
model.physics('ftg2').feature('cdam1').set('throughThicknessLocation', 'bottomOfShell');
model.physics('ftg2').feature('cdam1').set('cDamAnalysisType', 'cDamTypeGeneralized');
model.physics('ftg2').feature('cdam1').set('cDamDiscretizationRange', 20);
model.physics('ftg2').feature('cdam1').set('m', 10000);
model.physics('ftg2').feature('cdam1').set('lifeCurve', 'int1');
model.physics('ftg2').feature('cdam1').set('sf', 1000);
model.physics('ftg2').feature('cdam1').setIndex('cDamGenLoadHistory', 0, 0, 0);
model.physics('ftg2').feature('cdam1').setIndex('cDamGenLoadHistory', 0, 0, 0);
model.physics('ftg2').feature('cdam1').setIndex('cDamGenLoadHistory', 0, 1, 0);
model.physics('ftg2').feature('cdam1').setIndex('cDamGenLoadHistory', 0, 1, 0);
model.physics('ftg2').feature('cdam1').setIndex('cDamGenLoadHistory', 0, 2, 0);
model.physics('ftg2').feature('cdam1').setIndex('cDamGenLoadHistory', 0, 2, 0);
model.physics('ftg2').feature('cdam1').setIndex('cDamGenLoadHistory', 'fX', 0, 0);
model.physics('ftg2').feature('cdam1').setIndex('cDamGenLoadHistory', 'fY', 1, 0);
model.physics('ftg2').feature('cdam1').setIndex('cDamGenLoadHistory', 'fZ', 2, 0);

model.study.create('std3');
model.study('std3').create('ftge', 'Fatigue');
model.study('std3').feature('ftge').set('solnum', 'auto');
model.study('std3').feature('ftge').set('usesol', 'off');
model.study('std3').feature('ftge').setSolveFor('/physics/shell', false);
model.study('std3').feature('ftge').setSolveFor('/physics/ftg', false);
model.study('std3').feature('ftge').setSolveFor('/physics/ftg2', true);
model.study('std3').feature('ftge').set('usesol', true);
model.study('std3').feature('ftge').set('notsolmethod', 'sol');
model.study('std3').feature('ftge').set('notstudy', 'std1');
model.study('std3').label('Study: Fatigue Inside');

model.sol.create('sol3');
model.sol('sol3').study('std3');
model.sol('sol3').create('st1', 'StudyStep');
model.sol('sol3').feature('st1').set('study', 'std3');
model.sol('sol3').feature('st1').set('studystep', 'ftge');
model.sol('sol3').create('v1', 'Variables');
model.sol('sol3').feature('v1').set('control', 'ftge');
model.sol('sol3').create('s1', 'Stationary');
model.sol('sol3').attach('std3');
model.sol('sol3').runAll;

model.result.create('pg5', 'PlotGroup1D');
model.result('pg5').set('data', 'dset3');
model.result('pg5').create('lngr1', 'LineGraph');
model.result('pg5').feature('lngr1').set('expr', 'root.comp1.ftg2.fus');
model.result('pg5').feature('lngr1').set('xdata', 'arc');
model.result('pg5').feature('lngr1').selection.geom('geom1', 1);
model.result('pg5').feature('lngr1').selection.set([9 10 11 12 13 14 15 16]);
model.result('pg5').feature('lngr1').selection.inherit(false);
model.result('pg5').label('Fatigue Usage Factor (ftg2)');
model.result.create('pg6', 'PlotGroup2D');
model.result('pg6').set('data', 'none');
model.result('pg6').create('hist1', 'MatrixHistogram');
model.result('pg6').feature('hist1').set('data', 'dset3');
model.result('pg6').feature('hist1').set('expr', 'ftg2.cdam1.csc');
model.result('pg6').label('Stress Cycle Distribution (ftg2)');
model.result('pg6').feature('hist1').set('xdata', 'Mean stress');
model.result('pg6').feature('hist1').set('ydata', 'Stress amplitude');
model.result('pg6').feature('hist1').create('hght', 'HistogramHeight');
model.result('pg6').feature('hist1').feature('hght').label('Height expression (for 3D histogram)');
model.result.create('pg7', 'PlotGroup2D');
model.result('pg7').set('data', 'none');
model.result('pg7').create('hist1', 'MatrixHistogram');
model.result('pg7').feature('hist1').set('data', 'dset3');
model.result('pg7').feature('hist1').set('expr', 'ftg2.cdam1.rus');
model.result('pg7').label('Fatigue Usage Distribution (ftg2)');
model.result('pg7').feature('hist1').set('xdata', 'Mean stress');
model.result('pg7').feature('hist1').set('ydata', 'Stress amplitude');
model.result('pg7').feature('hist1').create('hght', 'HistogramHeight');
model.result('pg7').feature('hist1').feature('hght').label('Height expression (for 3D histogram)');
model.result('pg5').run;

model.nodeGroup.create('grp2', 'Results');
model.nodeGroup('grp2').set('type', 'plotgroup');
model.nodeGroup('grp2').placeAfter('plotgroup', 'pg1');
model.nodeGroup.move('grp2', 1);
model.nodeGroup('grp2').add('plotgroup', 'pg5');
model.nodeGroup('grp2').add('plotgroup', 'pg6');
model.nodeGroup('grp2').add('plotgroup', 'pg7');
model.nodeGroup('grp2').label('Fatigue Inside');

model.result('pg5').run;
model.result('pg5').label('Fatigue Usage Factor Inside (ftg2)');
model.result('pg5').run;
model.result('pg5').feature('lngr1').set('xdata', 'expr');
model.result('pg5').feature('lngr1').set('xdataexpr', 'atan2(z-0.03,x-0.04)*(dom==15)+atan2(abs(z-0.03),x+0.04)*(dom==11)+atan2(z+0.03,x+0.04)*(dom==10)+atan2(z+0.03,x-0.04)*(dom==14)');
model.result('pg5').feature('lngr1').set('xdataunit', [native2unicode(hex2dec({'00' 'b0'}), 'unicode') ]);
model.result('pg5').feature('lngr1').set('xdatadescractive', true);
model.result('pg5').feature('lngr1').set('xdatadescr', 'Cutout angle');
model.result('pg5').run;
model.result('pg6').run;
model.result('pg6').label('Stress Cycle Distribution Inside (ftg2)');
model.result('pg6').run;
model.result('pg6').feature('hist1').set('axisunit', 'MPa');
model.result('pg6').run;
model.result('pg7').run;
model.result('pg7').label('Fatigue Usage Distribution Inside (ftg2)');
model.result('pg7').run;
model.result('pg7').feature('hist1').set('axisunit', 'MPa');
model.result('pg7').run;
model.result('pg5').run;

model.title('Fatigue Response of a Random Nonproportional Load');

model.description(['A thin-walled frame with a central cutout is subjected to a random load. Although the stresses are far below the yield level of the material, damage accumulates over the load history. The Rainflow counting algorithm is used to define the load scenario and Palmgren' native2unicode(hex2dec({'20' '13'}), 'unicode') 'Miner linear damage model quantifies the damage.']);

model.mesh.clearMeshes;

model.sol('sol1').clearSolutionData;
model.sol('sol2').clearSolutionData;
model.sol('sol3').clearSolutionData;

model.label('frame_with_cutout.mph');

model.modelNode.label('Components');

out = model;
