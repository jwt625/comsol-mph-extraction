function out = model
%
% cylinder_with_hole_plastic.m
%
% Model exported on May 26 2025, 21:28 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/Fatigue_Module/Strain_Based');

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
model.geom('geom1').create('cyl1', 'Cylinder');
model.geom('geom1').feature('cyl1').set('r', 100);
model.geom('geom1').feature('cyl1').set('h', 100);
model.geom('geom1').feature.duplicate('cyl2', 'cyl1');
model.geom('geom1').feature('cyl2').set('r', 90);
model.geom('geom1').run('cyl2');
model.geom('geom1').create('dif1', 'Difference');
model.geom('geom1').feature('dif1').selection('input').set({'cyl1'});
model.geom('geom1').feature('dif1').selection('input2').set({'cyl2'});
model.geom('geom1').runPre('fin');
model.geom('geom1').create('cyl3', 'Cylinder');
model.geom('geom1').feature('cyl3').set('r', 10);
model.geom('geom1').feature('cyl3').set('h', 220);
model.geom('geom1').feature('cyl3').set('pos', [0 -110 50]);
model.geom('geom1').feature('cyl3').set('axistype', 'y');
model.geom('geom1').runPre('fin');
model.geom('geom1').create('dif2', 'Difference');
model.geom('geom1').feature('dif2').selection('input').set({'dif1'});
model.geom('geom1').feature('dif2').selection('input2').set({'cyl3'});
model.geom('geom1').runPre('fin');
model.geom('geom1').create('blk1', 'Block');
model.geom('geom1').feature('blk1').set('size', [100 100 50]);
model.geom('geom1').runPre('fin');
model.geom('geom1').create('int1', 'Intersection');
model.geom('geom1').feature('int1').selection('input').set({'blk1' 'dif2'});
model.geom('geom1').runPre('fin');
model.geom('geom1').create('cyl4', 'Cylinder');
model.geom('geom1').feature('cyl4').set('axistype', 'y');
model.geom('geom1').feature('cyl4').set('h', 40);
model.geom('geom1').feature('cyl4').set('r', 15);
model.geom('geom1').feature('cyl4').set('pos', [0 80 50]);
model.geom('geom1').runPre('fin');
model.geom('geom1').create('int2', 'Intersection');
model.geom('geom1').feature('int2').selection('input').set({'cyl4' 'int1'});
model.geom('geom1').feature('int2').set('keep', true);
model.geom('geom1').runPre('fin');
model.geom('geom1').create('del1', 'Delete');
model.geom('geom1').feature('del1').selection('input').init;
model.geom('geom1').feature('del1').selection('input').set({'cyl4'});
model.geom('geom1').run('fin');
model.geom('geom1').create('mcd1', 'MeshControlDomains');
model.geom('geom1').feature('mcd1').selection('input').set('fin', 2);
model.geom('geom1').run('mcd1');

model.physics('solid').create('sym1', 'SymmetrySolid', 2);
model.physics('solid').feature('sym1').selection.set([1 6 7]);

model.param.set('para', '0');
model.param.descr('para', 'Load cycle control');

model.physics('solid').create('bndl1', 'BoundaryLoad', 2);
model.physics('solid').feature('bndl1').selection.set([3]);
model.physics('solid').feature('bndl1').set('FperArea', {'0' '0' '-200[MPa]*sin(2*pi*para)'});
model.physics('solid').feature('lemm1').create('plsty1', 'Plasticity', 3);
model.physics('solid').feature('lemm1').feature('plsty1').set('IsotropicHardeningModel', 'PerfectlyPlastic');
model.physics('solid').feature('lemm1').feature('plsty1').set('KinematicHardeningModel', 'LinearKinematicHardening');

model.material.create('mat1', 'Common', 'comp1');
model.material('mat1').propertyGroup.create('Enu', 'Young''s_modulus_and_Poisson''s_ratio');
model.material('mat1').propertyGroup('Enu').set('E', {'210[GPa]'});
model.material('mat1').propertyGroup('Enu').set('nu', {'0.3'});
model.material('mat1').propertyGroup('def').set('density', {'0'});
model.material('mat1').propertyGroup.create('ElastoplasticModel', 'Elastoplastic_material_model');
model.material('mat1').propertyGroup('ElastoplasticModel').set('sigmags', {'380[MPa]'});
model.material('mat1').propertyGroup('ElastoplasticModel').set('Ek', {'75[GPa]'});

model.mesh('mesh1').run;
model.mesh('mesh1').clearMesh;
model.mesh('mesh1').automatic(false);
model.mesh('mesh1').create('map1', 'Map');
model.mesh('mesh1').feature('map1').selection.set([4]);
model.mesh('mesh1').feature('map1').create('dis1', 'Distribution');
model.mesh('mesh1').feature('map1').feature('dis1').selection.set([4]);
model.mesh('mesh1').feature('map1').feature('dis1').set('numelem', 6);
model.mesh('mesh1').feature('map1').create('dis2', 'Distribution');
model.mesh('mesh1').feature('map1').feature('dis2').selection.set([5]);
model.mesh('mesh1').feature('map1').feature('dis2').set('numelem', 15);
model.mesh('mesh1').create('swe1', 'Sweep');
model.mesh('mesh1').feature('swe1').selection.geom('geom1', 3);
model.mesh('mesh1').feature('swe1').selection.set([2]);
model.mesh('mesh1').feature('swe1').create('dis1', 'Distribution');
model.mesh('mesh1').feature('swe1').feature('dis1').set('numelem', 4);
model.mesh('mesh1').feature.move('ftet1', 2);
model.mesh('mesh1').feature.move('ftet1', 3);
model.mesh('mesh1').run;

model.study('std1').feature('stat').set('useparam', true);
model.study('std1').feature('stat').setIndex('pname', 'para', 0);
model.study('std1').feature('stat').setIndex('plistarr', '', 0);
model.study('std1').feature('stat').setIndex('punit', '', 0);
model.study('std1').feature('stat').setIndex('pname', 'para', 0);
model.study('std1').feature('stat').setIndex('plistarr', '', 0);
model.study('std1').feature('stat').setIndex('punit', '', 0);
model.study('std1').feature('stat').setIndex('plistarr', 'range(0,0.025,1)', 0);
model.study('std1').label('Study 1 (First Load Cycle)');

model.sol.create('sol1');
model.sol('sol1').study('std1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'stat');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').set('control', 'stat');
model.sol('sol1').create('s1', 'Stationary');
model.sol('sol1').feature('s1').create('p1', 'Parametric');
model.sol('sol1').feature('s1').feature.remove('pDef');
model.sol('sol1').feature('s1').feature('p1').set('porder', 'constant');
model.sol('sol1').feature('s1').feature('p1').set('control', 'stat');
model.sol('sol1').feature('s1').set('control', 'stat');
model.sol('sol1').feature('s1').feature('aDef').set('cachepattern', true);
model.sol('sol1').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('s1').feature('fc1').set('termonres', 'auto');
model.sol('sol1').feature('s1').feature('fc1').set('reserrfact', 1000);
model.sol('sol1').feature('s1').create('d1', 'Direct');
model.sol('sol1').feature('s1').feature('d1').set('linsolver', 'pardiso');
model.sol('sol1').feature('s1').feature('d1').set('pivotperturb', 1.0E-9);
model.sol('sol1').feature('s1').feature('d1').set('nliniterrefine', true);
model.sol('sol1').feature('s1').feature('d1').label('Suggested Direct Solver (solid)');
model.sol('sol1').feature('s1').create('i1', 'Iterative');
model.sol('sol1').feature('s1').feature('i1').set('linsolver', 'gmres');
model.sol('sol1').feature('s1').feature('i1').set('rhob', 40);
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
model.result('pg1').setIndex('looplevel', 41, 0);
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
model.result('pg1').run;
model.result('pg1').run;
model.result('pg1').feature('vol1').set('unit', 'MPa');
model.result('pg1').run;
model.result('pg1').feature('vol1').feature('def').set('scaleactive', true);
model.result('pg1').feature('vol1').feature('def').set('scale', 2000);
model.result('pg1').run;

model.view('view1').set('showgrid', false);

model.result('pg1').feature('vol1').feature('def').set('scaleactive', false);
model.result('pg1').run;
model.result('pg1').setIndex('looplevel', 11, 0);
model.result('pg1').run;
model.result.create('pg2', 'PlotGroup1D');
model.result('pg2').run;
model.result('pg2').label('Plastic Strain');
model.result('pg2').create('ptgr1', 'PointGraph');
model.result('pg2').feature('ptgr1').set('markerpos', 'datapoints');
model.result('pg2').feature('ptgr1').set('linewidth', 'preference');
model.result('pg2').feature('ptgr1').selection.set([6]);
model.result('pg2').feature('ptgr1').set('expr', 'solid.epeGp');
model.result('pg2').feature('ptgr1').set('descr', 'Equivalent plastic strain');
model.result('pg2').run;
model.result.create('pg3', 'PlotGroup1D');
model.result('pg3').run;
model.result('pg3').label('Stress vs. Strain');
model.result('pg3').create('ptgr1', 'PointGraph');
model.result('pg3').feature('ptgr1').set('markerpos', 'datapoints');
model.result('pg3').feature('ptgr1').set('linewidth', 'preference');
model.result('pg3').feature('ptgr1').selection.set([6]);
model.result('pg3').feature('ptgr1').set('expr', 'solid.sGpzz');
model.result('pg3').feature('ptgr1').set('descr', 'Stress tensor, zz-component');
model.result('pg3').feature('ptgr1').set('unit', 'MPa');
model.result('pg3').feature('ptgr1').set('xdataexpr', 'solid.eZZ');
model.result('pg3').feature('ptgr1').set('xdatadescr', 'Strain tensor, ZZ-component');
model.result('pg3').run;

model.study.create('std2');
model.study('std2').create('stat', 'Stationary');
model.study('std2').feature('stat').setSolveFor('/physics/solid', true);
model.study('std2').feature('stat').set('useparam', true);
model.study('std2').feature('stat').setIndex('pname', 'para', 0);
model.study('std2').feature('stat').setIndex('plistarr', '', 0);
model.study('std2').feature('stat').setIndex('punit', '', 0);
model.study('std2').feature('stat').setIndex('pname', 'para', 0);
model.study('std2').feature('stat').setIndex('plistarr', '', 0);
model.study('std2').feature('stat').setIndex('punit', '', 0);
model.study('std2').feature('stat').setIndex('plistarr', 'range(1,0.025,2)', 0);
model.study('std2').feature('stat').set('useinitsol', true);
model.study('std2').feature('stat').set('initmethod', 'sol');
model.study('std2').feature('stat').set('initstudy', 'std1');
model.study('std2').label('Study 2 (Steady State Load Cycle)');
model.study('std2').setGenPlots(false);

model.sol.create('sol2');
model.sol('sol2').study('std2');
model.sol('sol2').create('st1', 'StudyStep');
model.sol('sol2').feature('st1').set('study', 'std2');
model.sol('sol2').feature('st1').set('studystep', 'stat');
model.sol('sol2').create('v1', 'Variables');
model.sol('sol2').feature('v1').set('control', 'stat');
model.sol('sol2').create('s1', 'Stationary');
model.sol('sol2').feature('s1').create('p1', 'Parametric');
model.sol('sol2').feature('s1').feature.remove('pDef');
model.sol('sol2').feature('s1').feature('p1').set('porder', 'constant');
model.sol('sol2').feature('s1').feature('p1').set('control', 'stat');
model.sol('sol2').feature('s1').set('control', 'stat');
model.sol('sol2').feature('s1').feature('aDef').set('cachepattern', true);
model.sol('sol2').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol2').feature('s1').feature('fc1').set('termonres', 'auto');
model.sol('sol2').feature('s1').feature('fc1').set('reserrfact', 1000);
model.sol('sol2').feature('s1').create('d1', 'Direct');
model.sol('sol2').feature('s1').feature('d1').set('linsolver', 'pardiso');
model.sol('sol2').feature('s1').feature('d1').set('pivotperturb', 1.0E-9);
model.sol('sol2').feature('s1').feature('d1').set('nliniterrefine', true);
model.sol('sol2').feature('s1').feature('d1').label('Suggested Direct Solver (solid)');
model.sol('sol2').feature('s1').create('i1', 'Iterative');
model.sol('sol2').feature('s1').feature('i1').set('linsolver', 'gmres');
model.sol('sol2').feature('s1').feature('i1').set('rhob', 40);
model.sol('sol2').feature('s1').feature('i1').set('nlinnormuse', true);
model.sol('sol2').feature('s1').feature('i1').label('Suggested Iterative Solver (solid)');
model.sol('sol2').feature('s1').feature('i1').create('mg1', 'Multigrid');
model.sol('sol2').feature('s1').feature('i1').feature('mg1').set('prefun', 'gmg');
model.sol('sol2').feature('s1').feature('i1').feature('mg1').feature('pr').create('so1', 'SOR');
model.sol('sol2').feature('s1').feature('i1').feature('mg1').feature('pr').feature('so1').set('relax', 0.8);
model.sol('sol2').feature('s1').feature('i1').feature('mg1').feature('po').create('so1', 'SOR');
model.sol('sol2').feature('s1').feature('i1').feature('mg1').feature('po').feature('so1').set('relax', 0.8);
model.sol('sol2').feature('s1').feature('i1').feature('mg1').feature('cs').create('d1', 'Direct');
model.sol('sol2').feature('s1').feature('i1').feature('mg1').feature('cs').feature('d1').set('linsolver', 'pardiso');
model.sol('sol2').feature('s1').feature('i1').feature('mg1').feature('cs').feature('d1').set('pivotperturb', 1.0E-9);
model.sol('sol2').feature('s1').feature('fc1').set('linsolver', 'd1');
model.sol('sol2').feature('s1').feature('fc1').set('termonres', 'auto');
model.sol('sol2').feature('s1').feature('fc1').set('reserrfact', 1000);
model.sol('sol2').feature('s1').feature.remove('fcDef');
model.sol('sol2').attach('std2');
model.sol('sol2').runAll;

model.result('pg2').run;
model.result('pg2').feature.duplicate('ptgr2', 'ptgr1');
model.result('pg2').run;
model.result('pg2').feature('ptgr2').set('data', 'dset2');
model.result('pg2').feature('ptgr2').set('linestyle', 'dotted');
model.result('pg2').feature('ptgr2').set('linewidth', 4);
model.result('pg2').run;
model.result('pg3').run;
model.result('pg3').feature.duplicate('ptgr2', 'ptgr1');
model.result('pg3').run;
model.result('pg3').feature('ptgr2').set('data', 'dset2');
model.result('pg3').feature('ptgr2').set('linestyle', 'dotted');
model.result('pg3').feature('ptgr2').set('linewidth', 4);
model.result('pg3').run;

model.physics.create('ftg', 'Fatigue', 'geom1');
model.physics('ftg').model('comp1');

model.study('std1').feature('stat').setSolveFor('/physics/ftg', false);
model.study('std2').feature('stat').setSolveFor('/physics/ftg', false);

model.physics('ftg').create('stra1', 'StrainBasedModel', 2);
model.physics('ftg').feature('stra1').selection.all;
model.physics('ftg').feature('stra1').set('fatigueInputPhysics', 'solid');
model.physics('ftg').feature('stra1').set('Q', 16);

model.material.create('mat2', 'Common', 'comp1');
model.material('mat2').selection.geom('geom1', 2);
model.material('mat2').selection.all;
model.material('mat2').propertyGroup.create('fatigueStrainCoffinManson', 'Coffin-Manson[Fatigue]');
model.material('mat2').propertyGroup('fatigueStrainCoffinManson').set('epsilonf_CM', {'0.375'});
model.material('mat2').propertyGroup('fatigueStrainCoffinManson').set('c_CM', {'-0.60'});
model.material('mat2').propertyGroup.create('fatigueStressBasquin', 'Basquin[Fatigue]');
model.material('mat2').propertyGroup('fatigueStressBasquin').set('sigmaf_Basquin', {'1323[MPa]'});
model.material('mat2').propertyGroup('fatigueStressBasquin').set('b_Basquin', {'-0.097'});
model.material('mat2').propertyGroup('def').set('youngsmodulus', {'210[GPa]'});

model.study.create('std3');
model.study('std3').create('ftge', 'Fatigue');
model.study('std3').feature('ftge').set('solnum', 'auto');
model.study('std3').feature('ftge').set('usesol', 'off');
model.study('std3').feature('ftge').setSolveFor('/physics/solid', false);
model.study('std3').feature('ftge').setSolveFor('/physics/ftg', true);
model.study('std3').feature('ftge').set('usesol', true);
model.study('std3').feature('ftge').set('notsolmethod', 'sol');
model.study('std3').feature('ftge').set('notstudy', 'std2');
model.study('std3').label('Study 3 (Fatigue, SWT)');

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

model.result.create('pg4', 'PlotGroup3D');
model.result('pg4').set('data', 'dset3');
model.result('pg4').create('surf1', 'Surface');
model.result('pg4').feature('surf1').set('expr', {'ftg.ctf'});
model.result('pg4').feature('surf1').set('colortable', 'Rainbow');
model.result('pg4').feature('surf1').set('colortabletrans', 'none');
model.result('pg4').feature('surf1').set('colorscalemode', 'logarithmic');
model.result('pg4').feature('surf1').set('colortablerev', true);
model.result('pg4').feature('surf1').set('colortable', 'Traffic');
model.result('pg4').label('Cycles to Failure (ftg)');
model.result('pg4').feature('surf1').create('mrkr1', 'Marker');
model.result('pg4').feature('surf1').feature('mrkr1').set('precision', 3);
model.result('pg4').feature('surf1').feature('mrkr1').set('display', 'min');
model.result('pg4').run;
model.result('pg4').label('Fatigue Life');
model.result('pg4').set('titletype', 'manual');
model.result('pg4').set('title', 'Logarithm of lifetime in number of cycles');
model.result('pg4').run;
model.result('pg4').feature('surf1').feature('mrkr1').set('precision', 2);
model.result('pg4').run;
model.result('pg4').feature('surf1').feature('mrkr1').active(false);
model.result('pg4').feature('surf1').feature('mrkr1').active(true);
model.result('pg4').run;
model.result('pg4').run;

model.title('Elastoplastic Low-Cycle Fatigue Analysis of Cylinder with a Hole');

model.description('This example shows how to perform a Low Cycle Fatigue (LCF) analysis based on an elastoplastic analysis. The last of two load cycles is used for the fatigue analysis, in order to make sure that the state is representative for repeated loadings.');

model.mesh.clearMeshes;

model.sol('sol1').clearSolutionData;
model.sol('sol2').clearSolutionData;
model.sol('sol3').clearSolutionData;

model.label('cylinder_with_hole_plastic.mph');

model.modelNode.label('Components');

out = model;
