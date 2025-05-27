function out = model
%
% scordelis_lo_roof.m
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

model.geom('geom1').create('wp1', 'WorkPlane');
model.geom('geom1').feature('wp1').set('unite', true);
model.geom('geom1').feature('wp1').geom.create('pol1', 'Polygon');
model.geom('geom1').feature('wp1').geom.feature('pol1').set('source', 'table');
model.geom('geom1').feature('wp1').geom.feature('pol1').setIndex('table', 0, 0, 0);
model.geom('geom1').feature('wp1').geom.feature('pol1').setIndex('table', 25, 0, 1);
model.geom('geom1').feature('wp1').geom.feature('pol1').setIndex('table', 25, 1, 0);
model.geom('geom1').feature('wp1').geom.feature('pol1').setIndex('table', 25, 1, 1);
model.geom('geom1').feature('wp1').geom.run('pol1');
model.geom('geom1').run('wp1');
model.geom('geom1').feature.create('rev1', 'Revolve');
model.geom('geom1').feature('rev1').set('workplane', 'wp1');
model.geom('geom1').feature('rev1').selection('input').set({'wp1'});
model.geom('geom1').feature('rev1').set('angtype', 'specang');
model.geom('geom1').feature('rev1').set('angle1', 90);
model.geom('geom1').feature('rev1').set('angle2', '90+40');
model.geom('geom1').feature('rev1').set('axis', [1 0]);
model.geom('geom1').run('rev1');
model.geom('geom1').run('fin');

model.physics('shell').feature('to1').set('d', 0.25);
model.physics('shell').create('sym1', 'SymmetrySolid1', 1);
model.physics('shell').feature('sym1').selection.set([3 4]);
model.physics('shell').create('disp1', 'Displacement1', 1);
model.physics('shell').feature('disp1').selection.set([1]);
model.physics('shell').feature('disp1').setIndex('Direction', 'prescribed', 1);
model.physics('shell').feature('disp1').setIndex('Direction', 'prescribed', 2);
model.physics('shell').create('fl1', 'FaceLoad', 2);
model.physics('shell').feature('fl1').selection.set([1]);
model.physics('shell').feature('fl1').set('Ff', [0 0 -90]);

model.material.create('mat1', 'Common', 'comp1');
model.material('mat1').propertyGroup.create('Enu', 'Young''s_modulus_and_Poisson''s_ratio');
model.material('mat1').propertyGroup('Enu').set('E', {'4.32e8'});
model.material('mat1').propertyGroup('Enu').set('nu', {'0'});
model.material('mat1').propertyGroup('def').set('density', {'1'});

model.mesh('mesh1').create('ftri1', 'FreeTri');
model.mesh('mesh1').feature('ftri1').selection.all;
model.mesh('mesh1').run;

model.study('std1').label('Study 1: Tri Normal');

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
model.result('pg1').label('Vertical displacement');
model.result('pg1').run;
model.result('pg1').feature('surf1').set('expr', 'w');
model.result('pg1').feature('surf1').set('descr', 'Displacement field, Z-component');
model.result('pg1').feature('surf1').set('colortable', 'SpectrumLight');
model.result('pg1').feature('surf1').set('colortabletrans', 'reverse');
model.result('pg1').run;
model.result('pg1').run;
model.result.dataset('dset1').label('Tri Normal');

model.mesh('mesh1').label('Tri Normal');
model.mesh.create('mesh2', 'geom1');
model.mesh('mesh2').label('Quad Normal');
model.mesh('mesh2').create('map1', 'Map');
model.mesh('mesh2').feature('map1').selection.remaining;
model.mesh('mesh2').run;

model.study.create('std2');
model.study('std2').create('stat', 'Stationary');
model.study('std2').feature('stat').setSolveFor('/physics/shell', true);
model.study('std2').label('Study 2: Quad Normal');
model.study('std2').setGenPlots(false);

model.sol.create('sol2');
model.sol('sol2').study('std2');
model.sol('sol2').create('st1', 'StudyStep');
model.sol('sol2').feature('st1').set('study', 'std2');
model.sol('sol2').feature('st1').set('studystep', 'stat');
model.sol('sol2').create('v1', 'Variables');
model.sol('sol2').feature('v1').feature('comp1_ar').set('scalemethod', 'manual');
model.sol('sol2').feature('v1').feature('comp1_ar').set('resscalemethod', 'parent');
model.sol('sol2').feature('v1').feature('comp1_ar').set('scaleval', '0.01');
model.sol('sol2').feature('v1').set('control', 'stat');
model.sol('sol2').create('s1', 'Stationary');
model.sol('sol2').feature('s1').feature('aDef').set('cachepattern', true);
model.sol('sol2').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol2').feature('s1').feature('fc1').set('termonres', 'auto');
model.sol('sol2').feature('s1').feature('fc1').set('reserrfact', 1000);
model.sol('sol2').feature('s1').feature('fc1').set('linsolver', 'dDef');
model.sol('sol2').feature('s1').feature('fc1').set('termonres', 'auto');
model.sol('sol2').feature('s1').feature('fc1').set('reserrfact', 1000);
model.sol('sol2').feature('s1').feature.remove('fcDef');
model.sol('sol2').attach('std2');
model.sol('sol2').runAll;

model.result('pg1').run;
model.result('pg1').set('data', 'dset2');
model.result('pg1').run;
model.result.dataset('dset2').label('Quad Normal');

model.mesh.duplicate('mesh3', 'mesh2');
model.mesh('mesh3').label('Quad Extra fine');
model.mesh('mesh3').feature('size').set('hauto', 2);
model.mesh('mesh3').run;

model.study.create('std3');
model.study('std3').create('stat', 'Stationary');
model.study('std3').feature('stat').setSolveFor('/physics/shell', true);
model.study('std3').label('Study 3: Quad Extra fine');
model.study('std3').setGenPlots(false);

model.sol.create('sol3');
model.sol('sol3').study('std3');
model.sol('sol3').create('st1', 'StudyStep');
model.sol('sol3').feature('st1').set('study', 'std3');
model.sol('sol3').feature('st1').set('studystep', 'stat');
model.sol('sol3').create('v1', 'Variables');
model.sol('sol3').feature('v1').feature('comp1_ar').set('scalemethod', 'manual');
model.sol('sol3').feature('v1').feature('comp1_ar').set('resscalemethod', 'parent');
model.sol('sol3').feature('v1').feature('comp1_ar').set('scaleval', '0.01');
model.sol('sol3').feature('v1').set('control', 'stat');
model.sol('sol3').create('s1', 'Stationary');
model.sol('sol3').feature('s1').feature('aDef').set('cachepattern', true);
model.sol('sol3').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol3').feature('s1').feature('fc1').set('termonres', 'auto');
model.sol('sol3').feature('s1').feature('fc1').set('reserrfact', 1000);
model.sol('sol3').feature('s1').feature('fc1').set('linsolver', 'dDef');
model.sol('sol3').feature('s1').feature('fc1').set('termonres', 'auto');
model.sol('sol3').feature('s1').feature('fc1').set('reserrfact', 1000);
model.sol('sol3').feature('s1').feature.remove('fcDef');
model.sol('sol3').attach('std3');
model.sol('sol3').runAll;

model.result('pg1').run;
model.result('pg1').set('data', 'dset3');
model.result('pg1').run;
model.result.dataset('dset3').label('Quad Extra fine');

model.mesh.duplicate('mesh4', 'mesh1');
model.mesh('mesh4').label('Tri Extra Fine');
model.mesh('mesh4').feature('size').set('hauto', 2);
model.mesh('mesh4').run;

model.study.create('std4');
model.study('std4').create('stat', 'Stationary');
model.study('std4').feature('stat').setSolveFor('/physics/shell', true);
model.study('std4').label('Study 4: Tri Extra fine');
model.study('std4').setGenPlots(false);

model.sol.create('sol4');
model.sol('sol4').study('std4');
model.sol('sol4').create('st1', 'StudyStep');
model.sol('sol4').feature('st1').set('study', 'std4');
model.sol('sol4').feature('st1').set('studystep', 'stat');
model.sol('sol4').create('v1', 'Variables');
model.sol('sol4').feature('v1').feature('comp1_ar').set('scalemethod', 'manual');
model.sol('sol4').feature('v1').feature('comp1_ar').set('resscalemethod', 'parent');
model.sol('sol4').feature('v1').feature('comp1_ar').set('scaleval', '0.01');
model.sol('sol4').feature('v1').set('control', 'stat');
model.sol('sol4').create('s1', 'Stationary');
model.sol('sol4').feature('s1').feature('aDef').set('cachepattern', true);
model.sol('sol4').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol4').feature('s1').feature('fc1').set('termonres', 'auto');
model.sol('sol4').feature('s1').feature('fc1').set('reserrfact', 1000);
model.sol('sol4').feature('s1').feature('fc1').set('linsolver', 'dDef');
model.sol('sol4').feature('s1').feature('fc1').set('termonres', 'auto');
model.sol('sol4').feature('s1').feature('fc1').set('reserrfact', 1000);
model.sol('sol4').feature('s1').feature.remove('fcDef');
model.sol('sol4').attach('std4');
model.sol('sol4').runAll;

model.result('pg1').run;
model.result('pg1').set('data', 'dset4');
model.result('pg1').run;
model.result.dataset('dset4').label('Tri Extra fine');

model.mesh.duplicate('mesh5', 'mesh1');
model.mesh('mesh5').label('Tri Coarser');
model.mesh('mesh5').feature('size').set('hauto', 7);
model.mesh('mesh5').run;

model.study.create('std5');
model.study('std5').create('stat', 'Stationary');
model.study('std5').feature('stat').setSolveFor('/physics/shell', true);
model.study('std5').label('Study 5: Tri Coarser');
model.study('std5').setGenPlots(false);

model.sol.create('sol5');
model.sol('sol5').study('std5');
model.sol('sol5').create('st1', 'StudyStep');
model.sol('sol5').feature('st1').set('study', 'std5');
model.sol('sol5').feature('st1').set('studystep', 'stat');
model.sol('sol5').create('v1', 'Variables');
model.sol('sol5').feature('v1').feature('comp1_ar').set('scalemethod', 'manual');
model.sol('sol5').feature('v1').feature('comp1_ar').set('resscalemethod', 'parent');
model.sol('sol5').feature('v1').feature('comp1_ar').set('scaleval', '0.01');
model.sol('sol5').feature('v1').set('control', 'stat');
model.sol('sol5').create('s1', 'Stationary');
model.sol('sol5').feature('s1').feature('aDef').set('cachepattern', true);
model.sol('sol5').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol5').feature('s1').feature('fc1').set('termonres', 'auto');
model.sol('sol5').feature('s1').feature('fc1').set('reserrfact', 1000);
model.sol('sol5').feature('s1').feature('fc1').set('linsolver', 'dDef');
model.sol('sol5').feature('s1').feature('fc1').set('termonres', 'auto');
model.sol('sol5').feature('s1').feature('fc1').set('reserrfact', 1000);
model.sol('sol5').feature('s1').feature.remove('fcDef');
model.sol('sol5').attach('std5');
model.sol('sol5').runAll;

model.result('pg1').run;
model.result('pg1').set('data', 'dset5');
model.result('pg1').run;
model.result.dataset('dset5').label('Tri Coarser');

model.mesh.duplicate('mesh6', 'mesh2');
model.mesh('mesh6').label('Quad Coarser');
model.mesh('mesh6').feature('size').set('hauto', 7);

model.study.create('std6');
model.study('std6').create('stat', 'Stationary');
model.study('std6').feature('stat').setSolveFor('/physics/shell', true);
model.study('std6').label('Study 6: Quad Coarser');
model.study('std6').setGenPlots(false);

model.sol.create('sol6');
model.sol('sol6').study('std6');
model.sol('sol6').create('st1', 'StudyStep');
model.sol('sol6').feature('st1').set('study', 'std6');
model.sol('sol6').feature('st1').set('studystep', 'stat');
model.sol('sol6').create('v1', 'Variables');
model.sol('sol6').feature('v1').feature('comp1_ar').set('scalemethod', 'manual');
model.sol('sol6').feature('v1').feature('comp1_ar').set('resscalemethod', 'parent');
model.sol('sol6').feature('v1').feature('comp1_ar').set('scaleval', '0.01');
model.sol('sol6').feature('v1').set('control', 'stat');
model.sol('sol6').create('s1', 'Stationary');
model.sol('sol6').feature('s1').feature('aDef').set('cachepattern', true);
model.sol('sol6').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol6').feature('s1').feature('fc1').set('termonres', 'auto');
model.sol('sol6').feature('s1').feature('fc1').set('reserrfact', 1000);
model.sol('sol6').feature('s1').feature('fc1').set('linsolver', 'dDef');
model.sol('sol6').feature('s1').feature('fc1').set('termonres', 'auto');
model.sol('sol6').feature('s1').feature('fc1').set('reserrfact', 1000);
model.sol('sol6').feature('s1').feature.remove('fcDef');
model.sol('sol6').attach('std6');
model.sol('sol6').runAll;

model.result('pg1').run;
model.result('pg1').set('data', 'dset6');
model.result('pg1').run;
model.result.dataset('dset6').label('Quad Coarser');
model.result.numerical.create('pev1', 'EvalPoint');
model.result.numerical('pev1').selection.set([3]);
model.result.numerical('pev1').setIndex('expr', 'w', 0);
model.result.numerical('pev1').setIndex('unit', 'm', 0);
model.result.numerical('pev1').setIndex('descr', 'Midpoint displacement, Tri Normal', 0);
model.result.table.create('tbl1', 'Table');
model.result.table('tbl1').comments('Point Evaluation 1');
model.result.numerical('pev1').set('table', 'tbl1');
model.result.numerical('pev1').setResult;
model.result.numerical.duplicate('pev2', 'pev1');
model.result.numerical('pev2').set('data', 'dset2');
model.result.numerical('pev2').setIndex('descr', 'Midpoint displacement, Quad Normal', 0);
model.result.numerical('pev2').set('table', 'tbl1');
model.result.numerical('pev2').appendResult;
model.result.numerical.duplicate('pev3', 'pev2');
model.result.numerical('pev3').set('data', 'dset3');
model.result.numerical('pev3').setIndex('descr', 'Midpoint displacement, Quad Extra fine', 0);
model.result.numerical('pev3').set('table', 'tbl1');
model.result.numerical('pev3').appendResult;
model.result.numerical.duplicate('pev4', 'pev3');
model.result.numerical('pev4').set('data', 'dset4');
model.result.numerical('pev4').setIndex('descr', 'Midpoint displacement, Tri Extra fine', 0);
model.result.numerical('pev4').set('table', 'tbl1');
model.result.numerical('pev4').appendResult;
model.result.numerical.duplicate('pev5', 'pev4');
model.result.numerical('pev5').set('data', 'dset5');
model.result.numerical('pev5').setIndex('descr', 'Midpoint displacement, Tri Coarser', 0);
model.result.numerical('pev5').set('table', 'tbl1');
model.result.numerical('pev5').appendResult;
model.result.numerical.duplicate('pev6', 'pev5');
model.result.numerical('pev6').set('data', 'dset6');
model.result.numerical('pev6').setIndex('descr', 'Midpoint displacement, Quad Coarser', 0);
model.result.numerical('pev6').set('table', 'tbl1');
model.result.numerical('pev6').appendResult;
model.result('pg1').run;

model.title(['Scordelis' native2unicode(hex2dec({'20' '13'}), 'unicode') 'Lo Roof Shell Benchmark']);

model.description('This benchmark demonstrates how to build and solve a 3D shell model using the Structural Mechanics Module''s Shell interface and compares the result with an analytical solution.');

model.mesh.clearMeshes;

model.sol('sol1').clearSolutionData;
model.sol('sol2').clearSolutionData;
model.sol('sol3').clearSolutionData;
model.sol('sol4').clearSolutionData;
model.sol('sol5').clearSolutionData;
model.sol('sol6').clearSolutionData;

model.label('scordelis_lo_roof.mph');

model.modelNode.label('Components');

out = model;
