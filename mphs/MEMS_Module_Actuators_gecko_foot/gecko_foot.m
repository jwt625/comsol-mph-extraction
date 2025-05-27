function out = model
%
% gecko_foot.m
%
% Model exported on May 26 2025, 21:30 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/MEMS_Module/Actuators');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 3);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.physics.create('solid', 'SolidMechanics', 'geom1');
model.physics('solid').model('comp1');

model.study.create('std1');
model.study('std1').create('stat', 'Stationary');
model.study('std1').feature('stat').setSolveFor('/physics/solid', true);

model.param.set('Fc', '0.4[uN]');
model.param.descr('Fc', 'Contact force');
model.param.set('Ff', '0.2[uN]');
model.param.descr('Ff', 'Friction force');
model.param.set('theta', 'pi/3');
model.param.descr('theta', 'Contact angle');
model.param.set('Dm', '75[um]');
model.param.descr('Dm', 'Microhair length');
model.param.set('Hm', '4.33[um]');
model.param.descr('Hm', 'Microhair width');
model.param.set('Wm', '4.53[um]');
model.param.descr('Wm', 'Microhair height');
model.param.set('Dn', '3[um]');
model.param.descr('Dn', 'Nanohair length');
model.param.set('Hn', '0.17[um]');
model.param.descr('Hn', 'Nanohair width');
model.param.set('Wn', '0.18[um]');
model.param.descr('Wn', 'Nanohair height');
model.param.set('Area', 'Wn*Hn');
model.param.descr('Area', 'Cross-sectional area of the spatulas');

model.geom('geom1').lengthUnit([native2unicode(hex2dec({'00' 'b5'}), 'unicode') 'm']);
model.geom('geom1').create('blk1', 'Block');
model.geom('geom1').feature('blk1').set('size', {'Wn' 'Dn' 'Hn'});
model.geom('geom1').feature('blk1').set('pos', {'0' '-Dn' '0'});
model.geom('geom1').feature('blk1').label('Nanohair');
model.geom('geom1').run('blk1');
model.geom('geom1').create('sel1', 'ExplicitSelection');
model.geom('geom1').feature('sel1').selection('selection').init(2);
model.geom('geom1').feature('sel1').selection('selection').set('blk1', 3);
model.geom('geom1').feature('sel1').label('Nanohair ends');
model.geom('geom1').run('sel1');
model.geom('geom1').create('sel2', 'ExplicitSelection');

model.view('view1').set('renderwireframe', true);

model.geom('geom1').feature('sel2').selection('selection').init(2);
model.geom('geom1').feature('sel2').selection('selection').set('blk1', 6);

model.view('view1').set('renderwireframe', false);

model.geom('geom1').run('sel2');
model.geom('geom1').feature('sel2').label('Nanohair roots');
model.geom('geom1').create('arr1', 'Array');
model.geom('geom1').feature('arr1').selection('input').set({'blk1'});
model.geom('geom1').feature('arr1').set('fullsize', [13 1 13]);
model.geom('geom1').feature('arr1').set('displ', {'(Wm-Wn)/12' '0' '0'});
model.geom('geom1').feature('arr1').setIndex('displ', '(Hm-Hn)/12', 2);
model.geom('geom1').run('arr1');
model.geom('geom1').create('blk2', 'Block');
model.geom('geom1').feature('blk2').set('size', {'Wm' 'Dm' 'Hm'});
model.geom('geom1').run('blk2');
model.geom('geom1').feature('blk2').label('Microhair');
model.geom('geom1').create('sel3', 'ExplicitSelection');
model.geom('geom1').feature('sel3').selection('selection').init(2);
model.geom('geom1').feature('sel3').selection('selection').set('blk2', 3);
model.geom('geom1').run('sel3');
model.geom('geom1').feature('sel3').label('Microhair end');
model.geom('geom1').feature('fin').set('action', 'assembly');
model.geom('geom1').feature('fin').set('createpairs', false);
model.geom('geom1').run('fin');

model.pair.create('p1', 'Identity', 'geom1');
model.pair('p1').source.named('geom1_sel3');
model.pair('p1').destination.named('geom1_sel2');

model.coordSystem.create('sys2', 'geom1', 'Rotated');
model.coordSystem('sys2').set('angle', {'0' 'pi/2-theta' '0'});

model.material.create('mat1', 'Common', 'comp1');
model.material('mat1').propertyGroup.create('Enu', 'Young''s_modulus_and_Poisson''s_ratio');
model.material('mat1').propertyGroup('Enu').set('E', {'2e9'});
model.material('mat1').propertyGroup('Enu').set('nu', {'0.4'});
model.material('mat1').propertyGroup('def').set('density', {'1200'});

model.cpl.create('maxop1', 'Maximum', 'geom1');
model.cpl('maxop1').selection.all;

model.variable.create('var1');
model.variable('var1').model('comp1');
model.variable('var1').set('max_v_Mises', 'maxop1(solid.mises)');
model.variable('var1').descr('max_v_Mises', 'Maximum von Mises stress');
model.variable('var1').set('max_disp', 'maxop1(solid.disp)');
model.variable('var1').descr('max_disp', 'Maximum displacement magnitude');
model.variable('var1').set('max_ep1', 'maxop1(solid.ep1)');
model.variable('var1').descr('max_ep1', 'Maximum first principal strain');

model.physics('solid').create('fix1', 'Fixed', 2);
model.physics('solid').feature('fix1').selection.set([83]);
model.physics('solid').create('bndl1', 'BoundaryLoad', 2);
model.physics('solid').feature('bndl1').selection.named('geom1_sel1');
model.physics('solid').feature('bndl1').set('coordinateSystem', 'sys2');
model.physics('solid').feature('bndl1').set('FperArea', {'0' '-Fc/Area' 'Ff/Area'});
model.physics('solid').create('cont1', 'Continuity', 2);
model.physics('solid').feature('cont1').set('pairs', {'p1'});

model.mesh('mesh1').create('map1', 'Map');
model.mesh('mesh1').feature('map1').selection.named('geom1_sel1');
model.mesh('mesh1').feature('map1').create('size1', 'Size');
model.mesh('mesh1').feature('map1').feature('size1').set('custom', true);
model.mesh('mesh1').feature('map1').feature('size1').set('hmaxactive', true);
model.mesh('mesh1').feature('map1').feature('size1').set('hmax', 0.1);
model.mesh('mesh1').run('map1');
model.mesh('mesh1').create('swe1', 'Sweep');
model.mesh('mesh1').feature('swe1').selection.geom('geom1', 3);
model.mesh('mesh1').feature('swe1').selection.all;
model.mesh('mesh1').feature('swe1').selection.set([1 2 3 4 5 6 7 8 9 10 11 12 13 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40 41 42 43 44 45 46 47 48 49 50 51 52 53 54 55 56 57 58 59 60 61 62 63 64 65 66 67 68 69 70 71 72 73 74 75 76 77 78 79 80 81 82 83 84 85 86 87 88 89 90 91 92 93 94 95 96 97 98 99 100 101 102 103 104 105 106 107 108 109 110 111 112 113 114 115 116 117 118 119 120 121 122 123 124 125 126 127 128 129 130 131 132 133 134 135 136 137 138 139 140 141 142 143 144 145 146 147 148 149 150 151 152 153 154 155 156 157 158 159 160 161 162 163 164 165 166 167 168 169 170]);
model.mesh('mesh1').feature('swe1').create('dis1', 'Distribution');
model.mesh('mesh1').run('swe1');
model.mesh('mesh1').create('map2', 'Map');
model.mesh('mesh1').feature('map2').selection.set([83]);
model.mesh('mesh1').feature('map2').create('dis1', 'Distribution');
model.mesh('mesh1').feature('map2').feature('dis1').selection.set([162 163 164 168]);
model.mesh('mesh1').run('map2');
model.mesh('mesh1').create('swe2', 'Sweep');
model.mesh('mesh1').feature('swe2').create('dis1', 'Distribution');
model.mesh('mesh1').run('swe2');

model.sol.create('sol1');
model.sol('sol1').study('std1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'stat');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').set('control', 'stat');
model.sol('sol1').create('s1', 'Stationary');
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
model.result('pg1').feature('vol1').feature('def').set('scaleactive', true);
model.result('pg1').feature('vol1').feature('def').set('scale', 1);
model.result('pg1').run;
model.result.numerical.create('gev1', 'EvalGlobal');
model.result.numerical('gev1').set('expr', {'max_v_Mises'});
model.result.numerical('gev1').set('descr', {'Maximum von Mises stress'});
model.result.numerical('gev1').set('unit', {'N/m^2'});
model.result.table.create('tbl1', 'Table');
model.result.table('tbl1').comments('Global Evaluation 1');
model.result.numerical('gev1').set('table', 'tbl1');
model.result.numerical('gev1').setResult;
model.result.numerical.create('gev2', 'EvalGlobal');
model.result.numerical('gev2').set('expr', {'max_disp'});
model.result.numerical('gev2').set('descr', {'Maximum displacement magnitude'});
model.result.numerical('gev2').set('unit', {[native2unicode(hex2dec({'00' 'b5'}), 'unicode') 'm']});
model.result.numerical('gev2').set('table', 'tbl1');
model.result.numerical('gev2').appendResult;
model.result.numerical.create('gev3', 'EvalGlobal');
model.result.numerical('gev3').set('expr', {'max_ep1'});
model.result.numerical('gev3').set('descr', {'Maximum first principal strain'});
model.result.numerical('gev3').set('unit', {'1'});
model.result.numerical('gev3').set('table', 'tbl1');
model.result.numerical('gev3').appendResult;

model.study('std1').feature('stat').set('geometricNonlinearity', true);

model.sol('sol1').study('std1');
model.sol('sol1').feature.remove('s1');
model.sol('sol1').feature.remove('v1');
model.sol('sol1').feature.remove('st1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'stat');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').set('control', 'stat');
model.sol('sol1').create('s1', 'Stationary');
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
model.sol('sol1').feature('s1').feature('i1').set('prefuntype', 'right');
model.sol('sol1').feature('s1').feature('i1').set('rhob', 40);
model.sol('sol1').feature('s1').feature('i1').set('nlinnormuse', true);
model.sol('sol1').feature('s1').feature('i1').label('Suggested Iterative Solver (solid)');
model.sol('sol1').feature('s1').feature('i1').create('mg1', 'Multigrid');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').set('prefun', 'gmg');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('pr').create('so1', 'SOR');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('pr').feature('so1').set('iter', 1);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('po').create('so1', 'SOR');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('po').feature('so1').set('iter', 1);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('cs').create('mg1', 'Multigrid');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('cs').feature('mg1').set('prefun', 'saamg');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('cs').feature('mg1').set('usesmooth', false);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('cs').feature('mg1').set('iter', 2);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('cs').feature('mg1').set('mglevels', 2);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('cs').feature('mg1').set('maxcoarsedof', 10000);
model.sol('sol1').feature('s1').feature('fc1').set('linsolver', 'd1');
model.sol('sol1').feature('s1').feature('fc1').set('termonres', 'auto');
model.sol('sol1').feature('s1').feature('fc1').set('reserrfact', 1000);
model.sol('sol1').feature('s1').feature.remove('fcDef');
model.sol('sol1').attach('std1');
model.sol('sol1').runAll;

model.result('pg1').run;
model.result.table.create('tbl2', 'Table');
model.result.table('tbl2').comments('Global Evaluation 1');
model.result.numerical('gev1').set('table', 'tbl2');
model.result.numerical('gev1').setResult;
model.result.numerical('gev2').set('table', 'tbl2');
model.result.numerical('gev2').appendResult;
model.result.numerical('gev3').set('table', 'tbl2');
model.result.numerical('gev3').appendResult;
model.result('pg1').run;

model.title('Gecko Foot');

model.description('This model contains the nano/micro hierarchy of synthetic gecko foot hair, where cantilever beams on different scales describe the hairs. The analysis shows the stresses and deflection of the gecko foot caused by contact and friction forces.');

model.mesh.clearMeshes;

model.sol('sol1').clearSolutionData;

model.label('gecko_foot.mph');

model.modelNode.label('Components');

out = model;
