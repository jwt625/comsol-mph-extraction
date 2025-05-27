function out = model
%
% standing_contact_fatigue.m
%
% Model exported on May 26 2025, 21:28 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/Fatigue_Module/Stress_Based');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 2);
model.geom('geom1').model('comp1');
model.geom('geom1').axisymmetric(true);

model.mesh.create('mesh1', 'geom1');

model.physics.create('solid', 'SolidMechanics', 'geom1');
model.physics('solid').model('comp1');

model.study.create('std1');
model.study('std1').create('stat', 'Stationary');
model.study('std1').feature('stat').setSolveFor('/physics/solid', true);

model.param.set('H', '5 [mm]');
model.param.descr('H', 'Model height');
model.param.set('dH', '0.5 [mm]');
model.param.descr('dH', 'Case depth');
model.param.set('dT', '0.1 [mm]');
model.param.descr('dT', 'Transition depth');
model.param.set('W', '5 [mm]');
model.param.descr('W', 'Model width');
model.param.set('dW', '0.7 [mm]');
model.param.descr('dW', 'Fine zone width');
model.param.set('P', '384 [N]');
model.param.descr('P', 'Max load');
model.param.set('E', '200 [GPa]');
model.param.descr('E', 'Young''s modulus');
model.param.set('nu', '0.30');
model.param.descr('nu', 'Poisson''s ratio');
model.param.set('rho', '7800 [kg/m^3]');
model.param.descr('rho', 'Density');
model.param.set('Es', 'E/(2*(1-nu^2))');
model.param.descr('Es', 'Hertzian contact stiffness');
model.param.set('ri', '7 [mm]');
model.param.descr('ri', 'Indenter radius');
model.param.set('sL', '0');
model.param.descr('sL', 'Load magnifier');

model.geom('geom1').lengthUnit('mm');
model.geom('geom1').create('r1', 'Rectangle');
model.geom('geom1').feature('r1').set('size', {'W' 'H-dH-dT'});
model.geom('geom1').run('r1');
model.geom('geom1').create('r2', 'Rectangle');
model.geom('geom1').feature('r2').set('size', {'dW' 'dT'});
model.geom('geom1').feature('r2').set('pos', {'0' 'H-dH-dT'});
model.geom('geom1').run('r2');
model.geom('geom1').create('r3', 'Rectangle');
model.geom('geom1').feature('r3').set('size', {'W-dW' 'dT'});
model.geom('geom1').feature('r3').set('pos', {'dW' 'H-dH-dT'});
model.geom('geom1').run('r3');
model.geom('geom1').create('r4', 'Rectangle');
model.geom('geom1').feature('r4').set('size', {'dW' 'dH'});
model.geom('geom1').feature('r4').set('pos', {'0' 'H-dH'});
model.geom('geom1').run('r4');
model.geom('geom1').create('r5', 'Rectangle');
model.geom('geom1').feature('r5').set('size', {'W-dW' 'dH'});
model.geom('geom1').feature('r5').set('pos', {'dW' 'H-dH'});
model.geom('geom1').run('fin');

model.cpl.create('intop1', 'Integration', 'geom1');
model.cpl('intop1').set('axisym', true);
model.cpl('intop1').selection.all;
model.cpl('intop1').set('frame', 'material');

model.physics('solid').feature('lemm1').set('E_mat', 'userdef');
model.physics('solid').feature('lemm1').set('E', 'E');
model.physics('solid').feature('lemm1').set('nu_mat', 'userdef');
model.physics('solid').feature('lemm1').set('nu', 'nu');
model.physics('solid').feature('lemm1').set('rho_mat', 'userdef');
model.physics('solid').feature('lemm1').set('rho', 'rho');
model.physics('solid').feature('lemm1').create('plsty1', 'Plasticity', 2);
model.physics('solid').feature('lemm1').feature('plsty1').selection.set([3 5]);
model.physics('solid').feature('lemm1').feature('plsty1').set('sigmags_mat', 'userdef');
model.physics('solid').feature('lemm1').feature('plsty1').set('sigmags', '570 [MPa]');
model.physics('solid').feature('lemm1').feature('plsty1').set('Et_mat', 'userdef');
model.physics('solid').feature('lemm1').feature('plsty1').set('Et', '69 [GPa]');
model.physics('solid').feature('lemm1').create('plsty2', 'Plasticity', 2);
model.physics('solid').feature('lemm1').feature('plsty1').label('Plasticity Case');
model.physics('solid').feature('lemm1').feature('plsty2').label('Plasticity Core');
model.physics('solid').feature('lemm1').feature('plsty2').selection.set([1]);
model.physics('solid').feature('lemm1').feature('plsty2').set('sigmags_mat', 'userdef');
model.physics('solid').feature('lemm1').feature('plsty2').set('sigmags', '515 [MPa]');
model.physics('solid').feature('lemm1').feature('plsty2').set('IsotropicHardeningModel', 'Ludwik');
model.physics('solid').feature('lemm1').feature('plsty2').set('k_lud_mat', 'userdef');
model.physics('solid').feature('lemm1').feature('plsty2').set('k_lud', '2.47 [GPa]');
model.physics('solid').feature('lemm1').feature('plsty2').set('n_lud_mat', 'userdef');
model.physics('solid').feature('lemm1').feature('plsty2').set('n_lud', 0.55);

model.func.create('int1', 'Interpolation');
model.func('int1').label('Transition function');
model.func('int1').setIndex('table', 'H-dH-dT', 0, 0);
model.func('int1').setIndex('table', 1, 0, 1);
model.func('int1').setIndex('table', 'H-dH', 1, 0);
model.func('int1').setIndex('table', 0, 1, 1);
model.func('int1').setIndex('argunit', 'm', 0);

model.variable.create('var1');
model.variable('var1').model('comp1');
model.variable('var1').set('s', 'int1(z)');
model.variable('var1').descr('s', 'Transition layer position');
model.variable('var1').set('nT', '1-0.45*s');
model.variable('var1').descr('nT', 'Hardening exponent transition layer');
model.variable('var1').set('kT', '10^(-1.62*s+11) [Pa]');
model.variable('var1').descr('kT', 'Strength coefficient transition layer');
model.variable('var1').set('s0T', '(570e6*(1-s)+515e6*s) [Pa]');
model.variable('var1').descr('s0T', 'Initial yield stress transition layer');

model.physics('solid').feature('lemm1').create('plsty3', 'Plasticity', 2);
model.physics('solid').feature('lemm1').feature('plsty3').label('Plasticity Transition');
model.physics('solid').feature('lemm1').feature('plsty3').selection.set([2 4]);
model.physics('solid').feature('lemm1').feature('plsty3').set('sigmags_mat', 'userdef');
model.physics('solid').feature('lemm1').feature('plsty3').set('sigmags', 's0T');
model.physics('solid').feature('lemm1').feature('plsty3').set('IsotropicHardeningModel', 'Ludwik');
model.physics('solid').feature('lemm1').feature('plsty3').set('k_lud_mat', 'userdef');
model.physics('solid').feature('lemm1').feature('plsty3').set('k_lud', 'kT');
model.physics('solid').feature('lemm1').feature('plsty3').set('n_lud_mat', 'userdef');
model.physics('solid').feature('lemm1').feature('plsty3').set('n_lud', 'nT');

model.func.create('int2', 'Interpolation');
model.func('int2').label('Residual stress');
model.func('int2').setIndex('table', 0, 0, 0);
model.func('int2').setIndex('table', -500, 0, 1);
model.func('int2').setIndex('table', 1, 1, 0);
model.func('int2').setIndex('table', 100, 1, 1);
model.func('int2').setIndex('fununit', 'MPa', 0);

model.physics('solid').feature('lemm1').create('iss1', 'InitialStressandStrain', 2);
model.physics('solid').feature('lemm1').feature('iss1').set('Sil', {'int2(s)' '0' '0' '0' 'int2(s)' '0' '0' '0' '0'});
model.physics('solid').create('roll1', 'Roller', 1);
model.physics('solid').feature('roll1').selection.set([2 13 14 15]);

model.func.create('an1', 'Analytic');
model.func('an1').label('Periodic load');
model.func('an1').set('expr', '0.5*(1-cos(x*2*pi))');

model.variable('var1').set('ai', '(3/4*P*an1(sL)*ri/Es)^(1/3)');
model.variable('var1').descr('ai', 'Indentation radius');
model.variable('var1').set('p0', '3*P*an1(sL)/(2*pi*ai*ai)');
model.variable('var1').descr('p0', 'Max pressure');

model.physics('solid').create('bndl1', 'BoundaryLoad', 1);
model.physics('solid').feature('bndl1').selection.set([7]);
model.physics('solid').feature('bndl1').set('LoadType', 'FollowerPressure');
model.physics('solid').feature('bndl1').set('FollowerPressure', 'if(r<ai,p0*sqrt(1-(r/ai)^2),0)');

model.mesh('mesh1').create('map1', 'Map');
model.mesh('mesh1').feature('map1').selection.geom('geom1', 2);
model.mesh('mesh1').feature('map1').selection.set([2 3]);
model.mesh('mesh1').feature('map1').create('dis1', 'Distribution');
model.mesh('mesh1').feature('map1').feature('dis1').selection.set([4 6 7]);
model.mesh('mesh1').feature('map1').feature('dis1').set('numelem', 70);
model.mesh('mesh1').feature('map1').create('dis2', 'Distribution');
model.mesh('mesh1').feature('map1').feature('dis2').selection.set([5 10]);
model.mesh('mesh1').feature('map1').feature('dis2').set('numelem', 50);
model.mesh('mesh1').feature('map1').create('dis3', 'Distribution');
model.mesh('mesh1').feature('map1').feature('dis3').selection.set([3 8]);
model.mesh('mesh1').feature('map1').feature('dis3').set('numelem', 10);
model.mesh('mesh1').create('ftri1', 'FreeTri');
model.mesh('mesh1').run;

model.study('std1').feature('stat').set('useparam', true);
model.study('std1').feature('stat').setIndex('pname', 'H', 0);
model.study('std1').feature('stat').setIndex('plistarr', '', 0);
model.study('std1').feature('stat').setIndex('punit', 'm', 0);
model.study('std1').feature('stat').setIndex('pname', 'H', 0);
model.study('std1').feature('stat').setIndex('plistarr', '', 0);
model.study('std1').feature('stat').setIndex('punit', 'm', 0);
model.study('std1').feature('stat').setIndex('pname', 'sL', 0);
model.study('std1').feature('stat').setIndex('plistarr', 'range(0.0,0.025,0.5) range(0.55,0.05,2)', 0);

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
model.sol('sol1').feature('s1').feature('fc1').set('linsolver', 'dDef');
model.sol('sol1').feature('s1').feature('fc1').set('termonres', 'auto');
model.sol('sol1').feature('s1').feature('fc1').set('reserrfact', 1000);
model.sol('sol1').feature('s1').feature.remove('fcDef');
model.sol('sol1').attach('std1');
model.sol('sol1').runAll;

model.result.create('pg1', 'PlotGroup2D');
model.result('pg1').set('data', 'dset1');
model.result('pg1').setIndex('looplevel', 51, 0);
model.result('pg1').set('defaultPlotID', 'stress');
model.result('pg1').label('Stress (solid)');
model.result('pg1').set('frametype', 'spatial');
model.result('pg1').create('surf1', 'Surface');
model.result('pg1').feature('surf1').set('expr', {'solid.misesGp'});
model.result('pg1').feature('surf1').set('threshold', 'manual');
model.result('pg1').feature('surf1').set('thresholdvalue', 0.2);
model.result('pg1').feature('surf1').set('colortable', 'Rainbow');
model.result('pg1').feature('surf1').set('colortabletrans', 'none');
model.result('pg1').feature('surf1').set('colorscalemode', 'linear');
model.result('pg1').feature('surf1').set('resolution', 'normal');
model.result('pg1').feature('surf1').set('colortable', 'Prism');
model.result('pg1').feature('surf1').create('def', 'Deform');
model.result('pg1').feature('surf1').feature('def').set('expr', {'u' 'w'});
model.result('pg1').feature('surf1').feature('def').set('descr', 'Displacement field');
model.result.dataset.create('dset1solidrev', 'Revolve2D');
model.result.dataset('dset1solidrev').set('data', 'dset1');
model.result.dataset('dset1solidrev').set('revangle', 225);
model.result.dataset('dset1solidrev').set('startangle', -90);
model.result.dataset('dset1solidrev').set('hasspacevars', true);
model.result.create('pg2', 'PlotGroup3D');
model.result('pg2').set('data', 'dset1solidrev');
model.result('pg2').setIndex('looplevel', 51, 0);
model.result('pg2').set('defaultPlotID', 'stress3D');
model.result('pg2').label('Stress, 3D (solid)');
model.result('pg2').set('frametype', 'spatial');
model.result('pg2').create('surf1', 'Surface');
model.result('pg2').feature('surf1').set('expr', {'solid.misesGp'});
model.result('pg2').feature('surf1').set('threshold', 'manual');
model.result('pg2').feature('surf1').set('thresholdvalue', 0.2);
model.result('pg2').feature('surf1').set('colortable', 'Rainbow');
model.result('pg2').feature('surf1').set('colortabletrans', 'none');
model.result('pg2').feature('surf1').set('colorscalemode', 'linear');
model.result('pg2').feature('surf1').set('colortable', 'Prism');
model.result('pg2').feature('surf1').create('def', 'Deform');
model.result.dataset('dset1solidrev').set('hasspacevars', true);
model.result('pg2').feature('surf1').feature('def').set('revcoordsys', 'cylindrical');
model.result('pg2').feature('surf1').feature('def').set('expr', {'u' 'v' 'w'});
model.result('pg2').feature('surf1').feature('def').set('descr', 'Displacement field');
model.result('pg2').feature('surf1').feature('def').set('descractive', true);
model.result('pg1').run;
model.result('pg1').run;
model.result('pg1').feature('surf1').set('unit', 'MPa');
model.result('pg1').run;
model.result('pg1').feature('surf1').feature('def').set('scaleactive', true);
model.result('pg1').feature('surf1').feature('def').set('scale', 1);
model.result('pg2').run;
model.result('pg2').run;
model.result('pg2').feature('surf1').set('unit', 'MPa');
model.result('pg2').run;
model.result('pg2').feature('surf1').feature('def').set('scaleactive', true);
model.result('pg2').feature('surf1').feature('def').set('scale', 10);
model.result('pg1').run;
model.result.duplicate('pg3', 'pg1');
model.result('pg3').run;
model.result('pg3').label('Plastically deformed volume');
model.result('pg3').run;
model.result('pg3').feature('surf1').set('expr', 'solid.epeGp');
model.result('pg3').feature('surf1').set('descr', 'Equivalent plastic strain');
model.result('pg3').feature('surf1').set('expr', 'solid.epeGp>0');
model.result('pg3').run;
model.result('pg3').feature('surf1').feature.remove('def');
model.result('pg3').run;
model.result('pg3').run;
model.result.duplicate('pg4', 'pg3');
model.result('pg4').run;
model.result('pg4').label('Plastic strain');
model.result('pg4').run;
model.result('pg4').feature('surf1').set('expr', 'solid.epeGp');
model.result.create('pg5', 'PlotGroup1D');
model.result('pg5').run;
model.result('pg5').label('Plastic Strain History');
model.result('pg5').create('glob1', 'Global');
model.result('pg5').feature('glob1').set('markerpos', 'datapoints');
model.result('pg5').feature('glob1').set('linewidth', 'preference');
model.result('pg5').feature('glob1').setIndex('expr', 'intop1(solid.epeGp)', 0);
model.result('pg5').feature('glob1').setIndex('unit', 'mm^3', 0);
model.result('pg5').feature('glob1').setIndex('descr', 'Integrated plastic strain', 0);
model.result('pg5').run;
model.result('pg1').run;
model.result.duplicate('pg6', 'pg1');
model.result('pg6').run;
model.result('pg6').label('Equivalent stress at peak load');
model.result('pg6').setIndex('looplevel', 41, 0);
model.result.duplicate('pg7', 'pg6');
model.result('pg7').run;
model.result('pg7').label('Shear stress at peak load');
model.result('pg7').run;
model.result('pg7').feature('surf1').set('expr', 'solid.sGprz');
model.result('pg7').feature('surf1').set('descr', 'Stress tensor, rz-component');
model.result('pg7').run;

model.physics.create('ftg', 'Fatigue', 'geom1');
model.physics('ftg').model('comp1');

model.study('std1').feature('stat').setSolveFor('/physics/ftg', false);

model.physics('ftg').create('stre1', 'StressBasedModel', 2);
model.physics('ftg').feature('stre1').selection.all;
model.physics('ftg').feature('stre1').set('fatigueHCFMultiaxModel', 'DangVan');
model.physics('ftg').feature('stre1').set('fatigueInputPhysics', 'solid');

model.material.create('mat1', 'Common', 'comp1');
model.material('mat1').selection.set([3 5]);
model.material('mat1').propertyGroup.create('fatigueStressDangVan', 'Dang_Van[Fatigue]');
model.material('mat1').propertyGroup('fatigueStressDangVan').set('a_DangVan', {'0.19'});
model.material('mat1').propertyGroup('fatigueStressDangVan').set('b_DangVan', {'282[MPa]'});
model.material.create('mat2', 'Common', 'comp1');
model.material('mat2').selection.set([1 2 4]);
model.material('mat2').propertyGroup.create('fatigueStressDangVan', 'Dang_Van[Fatigue]');
model.material('mat2').propertyGroup('fatigueStressDangVan').set('a_DangVan', {'0.23'});
model.material('mat2').propertyGroup('fatigueStressDangVan').set('b_DangVan', {'248[MPa]'});

model.study.create('std2');
model.study('std2').create('ftge', 'Fatigue');
model.study('std2').feature('ftge').set('solnum', 'auto');
model.study('std2').feature('ftge').set('usesol', 'off');
model.study('std2').feature('ftge').setSolveFor('/physics/solid', false);
model.study('std2').feature('ftge').setSolveFor('/physics/ftg', true);
model.study('std2').feature('ftge').set('usesol', true);
model.study('std2').feature('ftge').set('notsolmethod', 'sol');
model.study('std2').feature('ftge').set('notstudy', 'std1');
model.study('std2').feature('ftge').set('notsolnum', 'from_list');
model.study('std2').feature('ftge').set('notlistsolnum', [23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40 41 42 43]);

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

model.result.create('pg8', 'PlotGroup2D');
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
model.result.dataset.create('rev1', 'Revolve2D');
model.result.dataset('rev1').set('data', 'dset2');
model.result.dataset('rev1').set('revangle', 225);
model.result.dataset('rev1').set('startangle', -90);
model.result.dataset('rev1').set('hasspacevars', false);
model.result.create('pg9', 'PlotGroup3D');
model.result('pg9').set('data', 'rev1');
model.result('pg9').create('surf1', 'Surface');
model.result('pg9').feature('surf1').set('expr', {'ftg.fus'});
model.result('pg9').feature('surf1').set('colortable', 'Rainbow');
model.result('pg9').feature('surf1').set('colortabletrans', 'none');
model.result('pg9').feature('surf1').set('colorscalemode', 'linear');
model.result('pg9').feature('surf1').set('colortable', 'Traffic');
model.result('pg9').label('Fatigue Usage Factor, 3D (ftg)');
model.result('pg8').run;
model.result('pg1').run;
model.result('pg3').run;
model.result('pg4').run;
model.result('pg5').run;
model.result('pg6').run;
model.result('pg7').run;
model.result('pg8').run;

model.title('Standing Contact Fatigue');

model.description('Standing contact fatigue of a surface hardened material is evaluated. Through the process of induction hardening residual stress is introduced into material. Three distinct layers with different material properties are present. The Dang Van model is used to predict fatigue.');

model.mesh.clearMeshes;

model.sol('sol1').clearSolutionData;
model.sol('sol2').clearSolutionData;

model.label('standing_contact_fatigue.mph');

model.modelNode.label('Components');

out = model;
