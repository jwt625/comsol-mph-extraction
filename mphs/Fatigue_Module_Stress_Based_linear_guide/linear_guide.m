function out = model
%
% linear_guide.m
%
% Model exported on May 26 2025, 21:28 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/Fatigue_Module/Stress_Based');

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
model.geom('geom1').create('imp1', 'Import');
model.geom('geom1').feature('imp1').set('filename', 'linear_guide_geometry.mphbin');
model.geom('geom1').feature('imp1').importData;

model.selection.create('sel1', 'Explicit');
model.selection('sel1').model('comp1');

model.geom('geom1').run;

model.selection('sel1').label('Contact Volume');

model.view('view1').set('renderwireframe', true);

model.selection('sel1').set([3 4 5 6]);
model.selection.create('sel2', 'Explicit');
model.selection('sel2').model('comp1');
model.selection('sel2').label('Contact Area');
model.selection('sel2').geom(2);
model.selection('sel2').set([30 32 39 41]);
model.selection.create('sel3', 'Explicit');
model.selection('sel3').model('comp1');
model.selection('sel3').label('Contact Depth Line');
model.selection('sel3').geom(1);
model.selection('sel3').set([59]);

model.view('view1').set('renderwireframe', false);

% To import content from file, use:
% model.param.loadFile('FILENAME');
model.param.set('L', '400 [um]', 'Raceway length');
model.param.set('R1', '2 [mm]', 'Groove radius');
model.param.set('a', '161 [um]', 'Semi-major axis');
model.param.set('b', '36 [um]', 'Semi-minor axis');
model.param.set('pMax', '1.14 [GPa]', 'Maximum contact pressure');
model.param.set('gC', '45 [deg]', 'Contact angle');
model.param.set('ga', 'a/R1 [rad]', 'Semi-major angle');
model.param.set('sTot', 'L-2*b', 'Total travel length');
model.param.set('nStep', '50', 'Number of steps');
model.param.set('ds', 'sTot/nStep', 'Travel increment');
model.param.set('s0', '-sTot/2', 'Starting position of the contact');
model.param.set('n', '0', 'Analysis step');
model.param.set('alpha', 'L/(2*(nStep/2)^3)', 'Load step function constant');

model.variable.create('var1');
model.variable('var1').model('comp1');

% To import content from file, use:
% model.variable('var1').loadFile('FILENAME');
model.variable('var1').set('g', 'atan2((0.014-z),(0.0075-y))', 'Raceway angular position');
model.variable('var1').set('dg', 'g-gC', 'Major contact center angular distance');
model.variable('var1').set('db', 'x-xC', 'Minor contact center distance');
model.variable('var1').set('xC', 'cPos(n)', 'Contact center along the raceway');
model.variable('var1').set('b1', 'db/b', 'Minor axis contact ratio');
model.variable('var1').set('g1', 'dg/ga', 'Major axis contact ratio');
model.variable('var1').set('rC', '(g1)^2+(b1)^2', 'Contact identifier');
model.variable('var1').set('pMag', 'if(rC<1,sqrt(1-rC),0)', 'Load magnification');

model.func.create('an1', 'Analytic');
model.func('an1').model('comp1');
model.func('an1').set('funcname', 'cPos');
model.func('an1').set('expr', 'alpha*(x-nStep/2)^3');
model.func('an1').set('fununit', 'm');

model.material.create('mat1', 'Common', 'comp1');
model.material('mat1').propertyGroup.create('Enu', 'Young''s_modulus_and_Poisson''s_ratio');
model.material('mat1').propertyGroup('Enu').set('E', {'200e9'});
model.material('mat1').propertyGroup('Enu').set('nu', {'0.3'});
model.material('mat1').propertyGroup('def').set('density', {'7800'});

model.physics('solid').create('bndl1', 'BoundaryLoad', 2);
model.physics('solid').feature('bndl1').selection.named('sel2');
model.physics('solid').feature('bndl1').set('LoadType', 'FollowerPressure');
model.physics('solid').feature('bndl1').set('FollowerPressure', 'pMax*pMag');
model.physics('solid').create('fix1', 'Fixed', 2);
model.physics('solid').feature('fix1').selection.set([6]);
model.physics('solid').create('roll1', 'Roller', 2);
model.physics('solid').feature('roll1').selection.set([1 2 13 48 49]);

model.mesh('mesh1').create('ftri1', 'FreeTri');
model.mesh('mesh1').feature('ftri1').selection.named('sel2');
model.mesh('mesh1').feature('ftri1').create('size1', 'Size');
model.mesh('mesh1').feature('ftri1').feature('size1').set('hauto', 1);
model.mesh('mesh1').feature('ftri1').feature('size1').set('custom', true);
model.mesh('mesh1').feature('ftri1').feature('size1').set('hmaxactive', true);
model.mesh('mesh1').feature('ftri1').feature('size1').set('hmax', 0.01);
model.mesh('mesh1').create('ftet1', 'FreeTet');
model.mesh('mesh1').feature('ftet1').selection.geom('geom1', 3);
model.mesh('mesh1').feature('ftet1').selection.named('sel1');
model.mesh('mesh1').feature('ftet1').create('size1', 'Size');
model.mesh('mesh1').feature('ftet1').feature('size1').set('hauto', 2);
model.mesh('mesh1').feature('ftet1').create('dis1', 'Distribution');
model.mesh('mesh1').feature('ftet1').feature('dis1').selection.named('sel3');
model.mesh('mesh1').feature('ftet1').feature('dis1').set('type', 'predefined');
model.mesh('mesh1').feature('ftet1').feature('dis1').set('elemcount', 25);
model.mesh('mesh1').feature('ftet1').feature('dis1').set('elemratio', 2);
model.mesh('mesh1').feature('ftet1').feature('dis1').set('reverse', true);
model.mesh('mesh1').create('ftet2', 'FreeTet');
model.mesh('mesh1').feature('ftet2').create('size1', 'Size');
model.mesh('mesh1').feature('ftet2').feature('size1').set('custom', true);
model.mesh('mesh1').feature('ftet2').feature('size1').set('hminactive', true);
model.mesh('mesh1').feature('ftet2').feature('size1').set('hmin', 0.1);
model.mesh('mesh1').run;

model.study('std1').feature('stat').set('useparam', true);
model.study('std1').feature('stat').setIndex('pname', 'L', 0);
model.study('std1').feature('stat').setIndex('plistarr', '', 0);
model.study('std1').feature('stat').setIndex('punit', 'm', 0);
model.study('std1').feature('stat').setIndex('pname', 'L', 0);
model.study('std1').feature('stat').setIndex('plistarr', '', 0);
model.study('std1').feature('stat').setIndex('punit', 'm', 0);
model.study('std1').feature('stat').setIndex('pname', 'n', 0);
model.study('std1').feature('stat').setIndex('plistarr', 'range(0,1,nStep)', 0);

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
model.sol('sol1').feature('s1').feature('i1').active(true);
model.sol('sol1').runAll;

model.result.create('pg1', 'PlotGroup3D');
model.result('pg1').set('data', 'dset1');
model.result('pg1').setIndex('looplevel', 51, 0);
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
model.result.dataset.create('mir1', 'Mirror3D');
model.result.dataset('mir1').label('Study1/Mirror 3D');
model.result.dataset('mir1').set('quickplane', 'xz');
model.result('pg1').run;
model.result('pg1').label('Surface: Equivalent Stress');
model.result('pg1').set('data', 'mir1');
model.result('pg1').setIndex('looplevel', 26, 0);
model.result('pg1').set('view', 'new');
model.result('pg1').run;
model.result('pg1').run;
model.result('pg1').feature('vol1').set('unit', 'MPa');
model.result('pg1').run;
model.result('pg1').feature('vol1').feature('def').set('scaleactive', true);
model.result('pg1').feature('vol1').feature('def').set('scale', 1);

model.view('view2').set('transparency', false);

model.result('pg1').run;
model.result.duplicate('pg2', 'pg1');
model.result('pg2').run;
model.result('pg2').label('Surface: Contact Stress');
model.result('pg2').set('view', 'new');
model.result('pg2').run;
model.result('pg2').run;
model.result('pg2').feature('vol1').set('expr', 'solid.sp3Gp');
model.result('pg2').feature('vol1').set('descr', 'Third principal stress');
model.result('pg2').feature('vol1').set('colortabletrans', 'reverse');
model.result.dataset.create('cpl1', 'CutPlane');
model.result.dataset('cpl1').label('Study1/Cut Plane: Through Thickness');
model.result.create('pg3', 'PlotGroup2D');
model.result('pg3').run;
model.result('pg3').label('Subsurface: Equivalent Stress');
model.result('pg3').setIndex('looplevel', 26, 0);
model.result('pg3').set('view', 'new');
model.result('pg3').run;
model.result('pg3').create('surf1', 'Surface');
model.result('pg3').feature('surf1').set('expr', 'solid.misesGp');
model.result('pg3').feature('surf1').set('descr', 'von Mises stress');
model.result('pg3').feature('surf1').set('unit', 'MPa');
model.result.create('pg4', 'PlotGroup1D');
model.result('pg4').run;
model.result('pg4').label('Through Thickness: Equivalent Stress');
model.result('pg4').create('lngr1', 'LineGraph');
model.result('pg4').feature('lngr1').set('markerpos', 'datapoints');
model.result('pg4').feature('lngr1').set('linewidth', 'preference');
model.result('pg4').feature('lngr1').selection.named('sel3');
model.result('pg4').feature('lngr1').set('expr', 'solid.misesGp');
model.result('pg4').feature('lngr1').set('descr', 'von Mises stress');
model.result('pg4').feature('lngr1').set('unit', 'MPa');
model.result('pg4').feature('lngr1').set('xdata', 'reversedarc');
model.result('pg4').run;
model.result('pg4').set('xlabelactive', true);
model.result('pg4').set('xlabel', 'Depth (mm)');
model.result.duplicate('pg5', 'pg4');
model.result('pg5').run;
model.result('pg5').label('Through Thickness: Shear Stress');
model.result('pg5').run;
model.result('pg5').feature('lngr1').set('expr', 'solid.sGpxy');
model.result('pg5').feature('lngr1').set('descr', 'Stress tensor, xy-component');
model.result.dataset.create('cpt1', 'CutPoint3D');
model.result.dataset('cpt1').label('Cut Point 3D: Max Mises');
model.result.dataset('cpt1').set('pointx', 0);
model.result.dataset('cpt1').set('pointy', '7.5-2.0235*cos(45[deg])');
model.result.dataset('cpt1').set('pointz', '14-2.0235*sin(45[deg])');
model.result.dataset.duplicate('cpt2', 'cpt1');
model.result.dataset('cpt2').label('Cut Point 3D: Max Shear');
model.result.dataset('cpt2').set('pointy', '7.5-2.0166*cos(45[deg])');
model.result.dataset('cpt2').set('pointz', '14-2.0166*sin(45[deg])');
model.result.create('pg6', 'PlotGroup1D');
model.result('pg6').run;
model.result('pg6').label('Point of Max Mises: Stress Components');
model.result('pg6').set('data', 'cpt1');
model.result('pg6').create('ptgr1', 'PointGraph');
model.result('pg6').feature('ptgr1').set('markerpos', 'datapoints');
model.result('pg6').feature('ptgr1').set('linewidth', 'preference');
model.result('pg6').feature('ptgr1').set('expr', 'solid.misesGp');
model.result('pg6').feature('ptgr1').set('descr', 'von Mises stress');
model.result('pg6').feature('ptgr1').set('unit', 'MPa');
model.result('pg6').feature('ptgr1').set('xdata', 'expr');
model.result('pg6').feature('ptgr1').set('xdataexpr', 'cPos(n)');
model.result('pg6').feature('ptgr1').set('legend', true);
model.result('pg6').feature('ptgr1').set('legendmethod', 'manual');
model.result('pg6').feature('ptgr1').setIndex('legends', 'Mises', 0);
model.result('pg6').feature.duplicate('ptgr2', 'ptgr1');
model.result('pg6').run;
model.result('pg6').feature('ptgr2').set('expr', 'solid.sGpxx');
model.result('pg6').feature('ptgr2').set('descr', 'Stress tensor, xx-component');
model.result('pg6').feature('ptgr2').setIndex('legends', 'sx', 0);
model.result('pg6').feature.duplicate('ptgr3', 'ptgr2');
model.result('pg6').run;
model.result('pg6').feature('ptgr3').set('expr', 'solid.sGpyy');
model.result('pg6').feature('ptgr3').set('descr', 'Stress tensor, yy-component');
model.result('pg6').feature('ptgr3').setIndex('legends', 'sy & sz', 0);
model.result('pg6').feature.duplicate('ptgr4', 'ptgr3');
model.result('pg6').run;
model.result('pg6').feature('ptgr4').set('expr', 'solid.sGpxy');
model.result('pg6').feature('ptgr4').set('descr', 'Stress tensor, xy-component');
model.result('pg6').feature('ptgr4').setIndex('legends', 'sxy & sxz', 0);
model.result('pg6').feature.duplicate('ptgr5', 'ptgr4');
model.result('pg6').run;
model.result('pg6').feature('ptgr5').set('expr', 'solid.sGpyz');
model.result('pg6').feature('ptgr5').set('descr', 'Stress tensor, yz-component');
model.result('pg6').feature('ptgr5').setIndex('legends', 'syz', 0);
model.result('pg6').run;
model.result('pg6').run;
model.result('pg6').set('titletype', 'none');
model.result('pg6').set('xlabelactive', true);
model.result('pg6').set('xlabel', 'Load location (mm)');
model.result('pg6').set('ylabelactive', true);
model.result('pg6').set('ylabel', 'Stress (MPa)');
model.result('pg6').run;
model.result.duplicate('pg7', 'pg6');
model.result('pg7').run;
model.result('pg7').label('Point of Max Shear: Stress Components');
model.result('pg7').set('data', 'cpt2');
model.result('pg7').run;

model.physics.create('ftg', 'Fatigue', 'geom1');
model.physics('ftg').model('comp1');

model.study('std1').feature('stat').setSolveFor('/physics/ftg', false);

model.physics('ftg').create('stre1', 'StressBasedModel', 3);
model.physics('ftg').feature('stre1').selection.named('sel1');
model.physics('ftg').feature('stre1').set('fatigueHCFMultiaxModel', 'DangVan');
model.physics('ftg').feature('stre1').set('fatigueInputPhysics', 'solid');

model.material('mat1').propertyGroup.create('fatigueStressDangVan', 'Dang_Van[Fatigue]');
model.material('mat1').propertyGroup('fatigueStressDangVan').set('a_DangVan', {'0.23'});
model.material('mat1').propertyGroup('fatigueStressDangVan').set('b_DangVan', {'248[MPa]'});

model.study.create('std2');
model.study('std2').create('ftge', 'Fatigue');
model.study('std2').feature('ftge').set('solnum', 'auto');
model.study('std2').feature('ftge').set('usesol', 'off');
model.study('std2').feature('ftge').setSolveFor('/physics/solid', false);
model.study('std2').feature('ftge').setSolveFor('/physics/ftg', true);
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

model.result.create('pg8', 'PlotGroup3D');
model.result('pg8').set('data', 'dset2');
model.result('pg8').create('surf1', 'Surface');
model.result('pg8').feature('surf1').set('expr', {'ftg.fus'});
model.result('pg8').feature('surf1').set('colortable', 'Rainbow');
model.result('pg8').feature('surf1').set('colortabletrans', 'none');
model.result('pg8').feature('surf1').set('colorscalemode', 'linear');
model.result('pg8').feature('surf1').set('colortable', 'Traffic');
model.result('pg8').label('Fatigue Usage Factor (ftg)');
model.result('pg8').feature('surf1').create('mrkr1', 'Marker');
model.result('pg8').feature('surf1').feature('mrkr1').set('precision', 3);
model.result('pg8').feature('surf1').feature('mrkr1').set('display', 'max');
model.result('pg8').run;
model.result.dataset.duplicate('mir2', 'mir1');
model.result.dataset('mir2').set('data', 'dset2');
model.result.dataset('mir2').label('Study2/Mirror 3D');
model.result('pg8').run;
model.result('pg8').set('data', 'mir2');
model.result.dataset.duplicate('cpl2', 'cpl1');
model.result.dataset('cpl2').set('data', 'dset2');
model.result.dataset('cpl2').label('Study2/Cut Plane: Through Thickness');
model.result.create('pg9', 'PlotGroup2D');
model.result('pg9').run;
model.result('pg9').label('Subsurface: Fatigue Usage Factor');
model.result('pg9').set('data', 'cpl2');
model.result('pg9').set('view', 'view5');
model.result('pg9').create('surf1', 'Surface');
model.result('pg9').feature('surf1').set('expr', 'ftg.fus');
model.result('pg9').feature('surf1').set('descr', 'Fatigue usage factor');
model.result('pg9').run;
model.result('pg2').run;

model.title('Rolling Contact Fatigue in a Linear Guide');

model.description('A linear guide has been loaded above the manufacturer specification limit. A concern arises whether the contact loads will introduce fatigue spalling. In an analysis of the rolling contact fatigue motion of the mostly loaded rolling element is simulated and fatigue is evaluated using the Dang Van model.');

model.mesh.clearMeshes;

model.sol('sol1').clearSolutionData;
model.sol('sol2').clearSolutionData;

model.label('linear_guide.mph');

model.modelNode.label('Components');

out = model;
