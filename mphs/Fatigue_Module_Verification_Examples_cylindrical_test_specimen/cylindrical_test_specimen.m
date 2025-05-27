function out = model
%
% cylindrical_test_specimen.m
%
% Model exported on May 26 2025, 21:28 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/Fatigue_Module/Verification_Examples');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 3);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.physics.create('solid', 'SolidMechanics', 'geom1');
model.physics('solid').model('comp1');

model.study.create('std1');
model.study('std1').create('stat', 'Stationary');
model.study('std1').feature('stat').setSolveFor('/physics/solid', true);

model.geom('geom1').lengthUnit('mm');

model.param.set('Moment', '22.672 [N*m]');
model.param.descr('Moment', 'Twisting moment');
model.param.set('Force', '15708 [N]');
model.param.descr('Force', 'Normal force');

model.geom('geom1').create('wp1', 'WorkPlane');
model.geom('geom1').feature('wp1').set('unite', true);
model.geom('geom1').feature('wp1').geom.create('pol1', 'Polygon');
model.geom('geom1').feature('wp1').geom.feature('pol1').set('source', 'table');
model.geom('geom1').feature('wp1').geom.feature('pol1').set('type', 'open');
model.geom('geom1').feature('wp1').geom.feature('pol1').set('source', 'vectors');
model.geom('geom1').feature('wp1').geom.feature('pol1').set('x', '5 5 0  0 10 10 6.01');
model.geom('geom1').feature('wp1').geom.feature('pol1').set('y', '20 0 0 50 50 30 30');
model.geom('geom1').feature('wp1').geom.run('pol1');
model.geom('geom1').feature('wp1').geom.create('qb1', 'QuadraticBezier');
model.geom('geom1').feature('wp1').geom.feature('qb1').setIndex('p', 6.01, 0, 0);
model.geom('geom1').feature('wp1').geom.feature('qb1').setIndex('p', 5.25, 0, 1);
model.geom('geom1').feature('wp1').geom.feature('qb1').setIndex('p', 5, 0, 2);
model.geom('geom1').feature('wp1').geom.feature('qb1').setIndex('p', 30, 1, 0);
model.geom('geom1').feature('wp1').geom.feature('qb1').setIndex('p', 25, 1, 1);
model.geom('geom1').feature('wp1').geom.feature('qb1').setIndex('p', 20, 1, 2);
model.geom('geom1').feature('wp1').geom.run('qb1');
model.geom('geom1').feature('wp1').geom.create('csol1', 'ConvertToSolid');
model.geom('geom1').feature('wp1').geom.feature('csol1').selection('input').set({'pol1' 'qb1'});
model.geom('geom1').feature('wp1').geom.run('csol1');
model.geom('geom1').feature('wp1').geom.create('fil1', 'Fillet');
model.geom('geom1').feature('wp1').geom.feature('fil1').selection('point').set('csol1', 5);
model.geom('geom1').feature('wp1').geom.feature('fil1').set('radius', 4);
model.geom('geom1').feature('wp1').geom.run('fil1');
model.geom('geom1').feature('wp1').geom.create('mir1', 'Mirror');
model.geom('geom1').feature('wp1').geom.feature('mir1').selection('input').set({'fil1'});
model.geom('geom1').feature('wp1').geom.feature('mir1').set('axis', [0 1]);
model.geom('geom1').feature('wp1').geom.feature('mir1').set('keep', true);
model.geom('geom1').feature('wp1').geom.run('mir1');
model.geom('geom1').feature('wp1').geom.create('uni1', 'Union');
model.geom('geom1').feature('wp1').geom.feature('uni1').selection('input').set({'fil1' 'mir1'});
model.geom('geom1').feature('wp1').geom.feature('uni1').set('intbnd', false);
model.geom('geom1').feature('wp1').geom.run('uni1');
model.geom('geom1').run('wp1');
model.geom('geom1').feature.create('rev1', 'Revolve');
model.geom('geom1').feature('rev1').set('workplane', 'wp1');
model.geom('geom1').feature('rev1').selection('input').set({'wp1'});
model.geom('geom1').feature('rev1').set('angtype', 'full');
model.geom('geom1').feature('rev1').set('origfaces', false);
model.geom('geom1').runPre('fin');
model.geom('geom1').run;

model.material.create('mat1', 'Common', 'comp1');
model.material('mat1').propertyGroup.create('Enu', 'Young''s_modulus_and_Poisson''s_ratio');
model.material('mat1').propertyGroup('Enu').set('E', {'210e9'});
model.material('mat1').propertyGroup('Enu').set('nu', {'0.3'});
model.material('mat1').propertyGroup('def').set('density', {'7800'});

model.physics('solid').create('fix1', 'Fixed', 2);
model.physics('solid').feature('fix1').selection.set([3 4 25 27]);
model.physics('solid').create('rig1', 'RigidConnector', 2);
model.physics('solid').feature('rig1').selection.set([11 12 47 48]);
model.physics('solid').feature('rig1').create('rf1', 'RigidBodyForce', -1);
model.physics('solid').feature('rig1').feature('rf1').set('Ft', {'0' 'Force' '0'});

model.group.create('lg1', 'LoadGroup');

model.physics('solid').feature('rig1').feature('rf1').set('loadGroup', 'lg1');
model.physics('solid').feature('rig1').create('rm1', 'RigidBodyMoment', -1);
model.physics('solid').feature('rig1').feature('rm1').set('Mt', {'0' 'Moment' '0'});

model.group.create('lg2', 'LoadGroup');

model.physics('solid').feature('rig1').feature('rm1').set('loadGroup', 'lg2');

model.group('lg1').label('Load Group: Force');
model.group('lg1').paramName('lgF');
model.group('lg2').label('Load Group: Moment');
model.group('lg2').paramName('lgM');

model.study('std1').feature('stat').set('useloadcase', true);
model.study('std1').feature('stat').setIndex('loadcase', 'Load case 1', 0);
model.study('std1').feature('stat').setIndex('loadgroup', false, 0, 0);
model.study('std1').feature('stat').setIndex('loadgroupweight', '1.0', 0, 0);
model.study('std1').feature('stat').setIndex('loadgroup', false, 0, 1);
model.study('std1').feature('stat').setIndex('loadgroupweight', '1.0', 0, 1);
model.study('std1').feature('stat').setIndex('loadcase', 'Load case 1', 0);
model.study('std1').feature('stat').setIndex('loadgroup', false, 0, 0);
model.study('std1').feature('stat').setIndex('loadgroupweight', '1.0', 0, 0);
model.study('std1').feature('stat').setIndex('loadgroup', false, 0, 1);
model.study('std1').feature('stat').setIndex('loadgroupweight', '1.0', 0, 1);
model.study('std1').feature('stat').setIndex('loadcase', 'Load case 2', 1);
model.study('std1').feature('stat').setIndex('loadgroup', false, 1, 0);
model.study('std1').feature('stat').setIndex('loadgroupweight', '1.0', 1, 0);
model.study('std1').feature('stat').setIndex('loadgroup', false, 1, 1);
model.study('std1').feature('stat').setIndex('loadgroupweight', '1.0', 1, 1);
model.study('std1').feature('stat').setIndex('loadcase', 'Load case 2', 1);
model.study('std1').feature('stat').setIndex('loadgroup', false, 1, 0);
model.study('std1').feature('stat').setIndex('loadgroupweight', '1.0', 1, 0);
model.study('std1').feature('stat').setIndex('loadgroup', false, 1, 1);
model.study('std1').feature('stat').setIndex('loadgroupweight', '1.0', 1, 1);
model.study('std1').feature('stat').setIndex('loadcase', 'Load case 3', 2);
model.study('std1').feature('stat').setIndex('loadgroup', false, 2, 0);
model.study('std1').feature('stat').setIndex('loadgroupweight', '1.0', 2, 0);
model.study('std1').feature('stat').setIndex('loadgroup', false, 2, 1);
model.study('std1').feature('stat').setIndex('loadgroupweight', '1.0', 2, 1);
model.study('std1').feature('stat').setIndex('loadcase', 'Load case 3', 2);
model.study('std1').feature('stat').setIndex('loadgroup', false, 2, 0);
model.study('std1').feature('stat').setIndex('loadgroupweight', '1.0', 2, 0);
model.study('std1').feature('stat').setIndex('loadgroup', false, 2, 1);
model.study('std1').feature('stat').setIndex('loadgroupweight', '1.0', 2, 1);
model.study('std1').feature('stat').setIndex('loadcase', 'Load case 4', 3);
model.study('std1').feature('stat').setIndex('loadgroup', false, 3, 0);
model.study('std1').feature('stat').setIndex('loadgroupweight', '1.0', 3, 0);
model.study('std1').feature('stat').setIndex('loadgroup', false, 3, 1);
model.study('std1').feature('stat').setIndex('loadgroupweight', '1.0', 3, 1);
model.study('std1').feature('stat').setIndex('loadcase', 'Load case 4', 3);
model.study('std1').feature('stat').setIndex('loadgroup', false, 3, 0);
model.study('std1').feature('stat').setIndex('loadgroupweight', '1.0', 3, 0);
model.study('std1').feature('stat').setIndex('loadgroup', false, 3, 1);
model.study('std1').feature('stat').setIndex('loadgroupweight', '1.0', 3, 1);
model.study('std1').feature('stat').setIndex('loadgroup', true, 0, 0);
model.study('std1').feature('stat').setIndex('loadgroup', true, 0, 1);
model.study('std1').feature('stat').setIndex('loadgroup', true, 1, 0);
model.study('std1').feature('stat').setIndex('loadgroup', true, 1, 1);
model.study('std1').feature('stat').setIndex('loadgroupweight', '-1.0', 1, 1);
model.study('std1').feature('stat').setIndex('loadgroup', true, 2, 0);
model.study('std1').feature('stat').setIndex('loadgroupweight', '-1.0', 2, 0);
model.study('std1').feature('stat').setIndex('loadgroup', true, 2, 1);
model.study('std1').feature('stat').setIndex('loadgroupweight', '-1.0', 2, 1);
model.study('std1').feature('stat').setIndex('loadgroup', true, 3, 0);
model.study('std1').feature('stat').setIndex('loadgroupweight', '-1.0', 3, 0);
model.study('std1').feature('stat').setIndex('loadgroup', true, 3, 1);

model.sol.create('sol1');
model.sol('sol1').study('std1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'stat');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').feature('comp1_solid_rig_disp').set('scalemethod', 'manual');
model.sol('sol1').feature('v1').feature('comp1_solid_rig_rot').set('scalemethod', 'manual');
model.sol('sol1').feature('v1').feature('comp1_u').set('scalemethod', 'manual');
model.sol('sol1').feature('v1').feature('comp1_solid_rig_disp').set('resscalemethod', 'parent');
model.sol('sol1').feature('v1').feature('comp1_solid_rig_rot').set('resscalemethod', 'parent');
model.sol('sol1').feature('v1').feature('comp1_solid_rig_disp').set('scaleval', '0.0010392304845413265');
model.sol('sol1').feature('v1').feature('comp1_solid_rig_rot').set('scaleval', '0.01');
model.sol('sol1').feature('v1').feature('comp1_u').set('scaleval', '1e-2*0.10392304845413265');
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
model.sol('sol1').feature('s1').create('d1', 'Direct');
model.sol('sol1').feature('s1').feature('d1').set('linsolver', 'pardiso');
model.sol('sol1').feature('s1').feature('d1').set('pivotperturb', 1.0E-9);
model.sol('sol1').feature('s1').feature('d1').label('Suggested Direct Solver (solid)');
model.sol('sol1').feature('s1').create('i1', 'Iterative');
model.sol('sol1').feature('s1').feature('i1').set('linsolver', 'gmres');
model.sol('sol1').feature('s1').feature('i1').set('rhob', 400);
model.sol('sol1').feature('s1').feature('i1').set('nlinnormuse', true);
model.sol('sol1').feature('s1').feature('i1').label('Suggested Iterative Solver (solid)');
model.sol('sol1').feature('s1').feature('i1').create('mg1', 'Multigrid');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').set('prefun', 'gmg');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('pr').create('so1', 'SOR');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('pr').feature('so1').set('relax', 0.8);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('po').create('so1', 'SOR');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('po').feature('so1').set('relax', 0.8);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('cs').create('d1', 'Direct');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('cs').feature('d1').set('linsolver', 'pardiso');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('cs').feature('d1').set('pivotperturb', 1.0E-9);
model.sol('sol1').feature('s1').feature('fc1').set('linsolver', 'd1');
model.sol('sol1').feature('s1').feature('fc1').set('termonres', 'auto');
model.sol('sol1').feature('s1').feature('fc1').set('reserrfact', 1000);
model.sol('sol1').feature('s1').feature.remove('fcDef');
model.sol('sol1').attach('std1');
model.sol('sol1').runAll;

model.result.create('pg1', 'PlotGroup3D');
model.result('pg1').set('data', 'dset1');
model.result('pg1').setIndex('looplevel', 4, 0);
model.result('pg1').set('defaultPlotID', 'stress');
model.result('pg1').label('Stress (solid)');
model.result('pg1').set('frametype', 'spatial');
model.result('pg1').create('vol1', 'Volume');
model.result('pg1').feature('vol1').set('expr', {'solid.misesGp'});
model.result('pg1').feature('vol1').set('threshold', 'manual');
model.result('pg1').feature('vol1').set('thresholdvalue', 0.2);
model.result('pg1').feature('vol1').set('colortable', 'Rainbow');
model.result('pg1').feature('vol1').set('colortabletrans', 'none');
model.result('pg1').feature('vol1').set('colorscalemode', 'linear');
model.result('pg1').feature('vol1').set('resolution', 'custom');
model.result('pg1').feature('vol1').set('refine', 2);
model.result('pg1').feature('vol1').set('colortable', 'Prism');
model.result('pg1').feature('vol1').create('def', 'Deform');
model.result('pg1').feature('vol1').feature('def').set('expr', {'u' 'v' 'w'});
model.result('pg1').feature('vol1').feature('def').set('descr', 'Displacement field');
model.result('pg1').run;
model.result.create('pg2', 'PlotGroup1D');
model.result('pg2').run;
model.result('pg2').label('Stresses');
model.result('pg2').create('ptgr1', 'PointGraph');
model.result('pg2').feature('ptgr1').set('markerpos', 'datapoints');
model.result('pg2').feature('ptgr1').set('linewidth', 'preference');
model.result('pg2').feature('ptgr1').selection.set([20]);
model.result('pg2').feature('ptgr1').set('expr', 'solid.SGpYY');
model.result('pg2').feature('ptgr1').set('descr', ['Second Piola' native2unicode(hex2dec({'20' '13'}), 'unicode') 'Kirchhoff stress, YY-component']);
model.result('pg2').feature('ptgr1').set('unit', 'MPa');
model.result('pg2').feature('ptgr1').set('legend', true);
model.result('pg2').feature('ptgr1').set('legendmethod', 'manual');
model.result('pg2').feature('ptgr1').setIndex('legends', 'normal stress', 0);
model.result('pg2').feature.duplicate('ptgr2', 'ptgr1');
model.result('pg2').run;
model.result('pg2').feature('ptgr2').set('expr', 'solid.SGpXY');
model.result('pg2').feature('ptgr2').setIndex('legends', 'shear stress', 0);
model.result('pg2').feature.duplicate('ptgr3', 'ptgr2');
model.result('pg2').run;
model.result('pg2').feature('ptgr3').set('expr', 'solid.misesGp');
model.result('pg2').feature('ptgr3').setIndex('legends', 'von Mises', 0);
model.result('pg2').run;
model.result('pg2').set('titletype', 'none');
model.result('pg2').set('ylabelactive', true);
model.result('pg2').set('ylabel', 'Stress (MPa)');
model.result('pg2').run;

model.physics.create('ftg', 'Fatigue', 'geom1');
model.physics('ftg').model('comp1');

model.study('std1').feature('stat').setSolveFor('/physics/ftg', false);

model.physics('ftg').label('Fatigue Findley');
model.physics('ftg').create('stre1', 'StressBasedModel', 2);
model.physics('ftg').feature('stre1').selection.all;
model.physics('ftg').feature('stre1').set('fatigueInputPhysics', 'solid');
model.physics.create('ftg2', 'Fatigue', 'geom1');
model.physics('ftg2').model('comp1');

model.study('std1').feature('stat').setSolveFor('/physics/ftg2', false);

model.physics('ftg2').label('Fatigue Matake');
model.physics('ftg2').create('stre1', 'StressBasedModel', 2);
model.physics('ftg2').feature('stre1').selection.all;
model.physics('ftg2').feature('stre1').set('fatigueHCFMultiaxModel', 'Matake');
model.physics('ftg2').feature('stre1').set('fatigueInputPhysics', 'solid');
model.physics.create('ftg3', 'Fatigue', 'geom1');
model.physics('ftg3').model('comp1');

model.study('std1').feature('stat').setSolveFor('/physics/ftg3', false);

model.physics('ftg3').label('Fatigue Normal Stress');
model.physics('ftg3').create('stre1', 'StressBasedModel', 2);
model.physics('ftg3').feature('stre1').selection.all;
model.physics('ftg3').feature('stre1').set('fatigueHCFMultiaxModel', 'NormalStress');
model.physics('ftg3').feature('stre1').set('fatigueInputPhysics', 'solid');

model.material.create('mat2', 'Common', 'comp1');
model.material('mat2').selection.geom('geom1', 2);
model.material('mat2').selection.all;
model.material('mat2').propertyGroup.create('fatigueStressFindley', 'Findley[Fatigue]');
model.material('mat2').propertyGroup('fatigueStressFindley').set('k_Findley', {'0.20'});
model.material('mat2').propertyGroup('fatigueStressFindley').set('f_Findley', {'213[MPa]'});
model.material('mat2').propertyGroup.create('fatigueStressMatake', 'Matake[Fatigue]');
model.material('mat2').propertyGroup('fatigueStressMatake').set('k_Matake', {'0.27'});
model.material('mat2').propertyGroup('fatigueStressMatake').set('f_Matake', {'223[MPa]'});
model.material('mat2').propertyGroup.create('fatigueStressNormalStress', 'Normal_stress[Fatigue]');
model.material('mat2').propertyGroup('fatigueStressNormalStress').set('f_NormalStress', {'576[MPa]'});

model.study.create('std2');
model.study('std2').create('ftge', 'Fatigue');
model.study('std2').feature('ftge').set('solnum', 'auto');
model.study('std2').feature('ftge').set('usesol', 'off');
model.study('std2').feature('ftge').setSolveFor('/physics/solid', false);
model.study('std2').feature('ftge').setSolveFor('/physics/ftg', true);
model.study('std2').feature('ftge').setSolveFor('/physics/ftg2', true);
model.study('std2').feature('ftge').setSolveFor('/physics/ftg3', true);
model.study('std2').feature('ftge').set('usesol', true);
model.study('std2').feature('ftge').set('notsolmethod', 'sol');
model.study('std2').feature('ftge').set('notstudy', 'std1');

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

model.result.create('pg3', 'PlotGroup3D');
model.result('pg3').set('data', 'dset2');
model.result('pg3').create('surf1', 'Surface');
model.result('pg3').feature('surf1').set('expr', {'ftg.fus'});
model.result('pg3').feature('surf1').set('colortable', 'Rainbow');
model.result('pg3').feature('surf1').set('colortabletrans', 'none');
model.result('pg3').feature('surf1').set('colorscalemode', 'linear');
model.result('pg3').feature('surf1').set('colortable', 'Traffic');
model.result('pg3').label('Fatigue Usage Factor (ftg)');
model.result('pg3').feature('surf1').create('mrkr1', 'Marker');
model.result('pg3').feature('surf1').feature('mrkr1').set('precision', 3);
model.result('pg3').feature('surf1').feature('mrkr1').set('display', 'max');
model.result.create('pg4', 'PlotGroup3D');
model.result('pg4').set('data', 'dset2');
model.result('pg4').create('surf1', 'Surface');
model.result('pg4').feature('surf1').set('expr', {'ftg2.fus'});
model.result('pg4').feature('surf1').set('colortable', 'Rainbow');
model.result('pg4').feature('surf1').set('colortabletrans', 'none');
model.result('pg4').feature('surf1').set('colorscalemode', 'linear');
model.result('pg4').feature('surf1').set('colortable', 'Traffic');
model.result('pg4').label('Fatigue Usage Factor (ftg2)');
model.result('pg4').feature('surf1').create('mrkr1', 'Marker');
model.result('pg4').feature('surf1').feature('mrkr1').set('precision', 3);
model.result('pg4').feature('surf1').feature('mrkr1').set('display', 'max');
model.result.create('pg5', 'PlotGroup3D');
model.result('pg5').set('data', 'dset2');
model.result('pg5').create('surf1', 'Surface');
model.result('pg5').feature('surf1').set('expr', {'ftg3.fus'});
model.result('pg5').feature('surf1').set('colortable', 'Rainbow');
model.result('pg5').feature('surf1').set('colortabletrans', 'none');
model.result('pg5').feature('surf1').set('colorscalemode', 'linear');
model.result('pg5').feature('surf1').set('colortable', 'Traffic');
model.result('pg5').label('Fatigue Usage Factor (ftg3)');
model.result('pg5').feature('surf1').create('mrkr1', 'Marker');
model.result('pg5').feature('surf1').feature('mrkr1').set('precision', 3);
model.result('pg5').feature('surf1').feature('mrkr1').set('display', 'max');
model.result('pg3').run;
model.result('pg3').label('Fatigue Usage Factor (Findley)');
model.result('pg4').run;
model.result('pg4').label('Fatigue Usage Factor (Matake)');
model.result('pg5').run;
model.result('pg5').label('Fatigue Usage Factor (Normal Stress)');

model.title('High-Cycle Fatigue Analysis of a Cylindrical Test Specimen');

model.description(['A cylindrical test specimen is subjected to a scenario with normal and shear load. Three stress based models ' native2unicode(hex2dec({'20' '14'}), 'unicode') ' Findley, Matake, and Normal stress ' native2unicode(hex2dec({'20' '14'}), 'unicode') ' are compared to analytical values and to each other. The nonsmooth behavior of the Matake model is captured and discussed.']);

model.mesh.clearMeshes;

model.sol('sol1').clearSolutionData;
model.sol('sol2').clearSolutionData;

model.label('cylindrical_test_specimen.mph');

model.modelNode.label('Components');

out = model;
