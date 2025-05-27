function out = model
%
% kirsch_plate.m
%
% Model exported on May 26 2025, 21:34 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/Structural_Mechanics_Module/Verification_Examples');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 2);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.physics.create('solid', 'SolidMechanics', 'geom1');
model.physics('solid').model('comp1');

model.study.create('std1');
model.study('std1').create('stat', 'Stationary');
model.study('std1').feature('stat').setSolveFor('/physics/solid', true);

model.param.set('pw', '10[m]');
model.param.descr('pw', 'Physical width of infinite element domain');
model.param.set('deltaY', '0.1[m]');
model.param.descr('deltaY', 'Geometric thickness of infinite element layer');

model.geom('geom1').create('r1', 'Rectangle');
model.geom('geom1').feature('r1').set('size', {'1' '1+deltaY'});
model.geom('geom1').feature('r1').set('layerbottom', false);
model.geom('geom1').feature('r1').set('layertop', true);
model.geom('geom1').feature('r1').setIndex('layername', 'Layer 1', 0);
model.geom('geom1').feature('r1').setIndex('layer', 'deltaY', 0);
model.geom('geom1').run('r1');
model.geom('geom1').create('c1', 'Circle');
model.geom('geom1').feature('c1').set('r', 0.1);
model.geom('geom1').run('c1');
model.geom('geom1').create('dif1', 'Difference');
model.geom('geom1').feature('dif1').selection('input').set({'r1'});
model.geom('geom1').feature('dif1').selection('input2').set({'c1'});
model.geom('geom1').runPre('fin');

model.func.create('an1', 'Analytic');
model.func('an1').label('Analytic Stress');
model.func('an1').set('funcname', 'AnaStress');
model.func('an1').set('expr', '1000/2*(2+(0.1/y)^2+3*(0.1/y)^4)');
model.func('an1').set('args', 'y');
model.func('an1').setIndex('argunit', 'm', 0);
model.func('an1').set('fununit', 'N/m^2');
model.func.create('an2', 'Analytic');
model.func('an2').model('comp1');
model.func('an2').set('expr', '(pw-10*deltaY)*x^2+10*deltaY*x');
model.func('an2').setIndex('argunit', 'm', 0);
model.func('an2').set('fununit', 'm');

model.coordSystem.create('ie1', 'geom1', 'InfiniteElement');

model.geom('geom1').run;

model.coordSystem('ie1').selection.set([2]);
model.coordSystem('ie1').set('stretchingType', 'userDefined');
model.coordSystem('ie1').set('function', 'an2');

model.variable.create('var1');
model.variable('var1').model('comp1');
model.variable('var1').set('ym', 'if(dom==2,ie1.Ym,y)');
model.variable('var1').descr('ym', 'Physical y-coordinate');

model.physics('solid').selection.set([1]);
model.physics('solid').prop('Type2D').set('Type2D', 'PlaneStress');
model.physics('solid').prop('d').set('d', 0.1);
model.physics('solid').create('sym1', 'SymmetrySolid', 1);
model.physics('solid').feature('sym1').selection.set([1 5]);
model.physics('solid').create('bndl1', 'BoundaryLoad', 1);
model.physics('solid').feature('bndl1').selection.set([6]);
model.physics('solid').feature('bndl1').set('FperArea', {'1e3' '0' '0'});
model.physics.create('solid2', 'SolidMechanics', 'geom1');
model.physics('solid2').model('comp1');

model.study('std1').feature('stat').setSolveFor('/physics/solid2', true);

model.physics('solid2').prop('Type2D').set('Type2D', 'PlaneStress');
model.physics('solid2').prop('d').set('d', 0.1);
model.physics('solid2').create('sym1', 'SymmetrySolid', 1);
model.physics('solid2').feature('sym1').selection.set([1 2 5]);
model.physics('solid2').create('bndl1', 'BoundaryLoad', 1);
model.physics('solid2').feature('bndl1').selection.set([6 7]);
model.physics('solid2').feature('bndl1').set('FperArea', {'1e3' '0' '0'});

model.material.create('mat1', 'Common', 'comp1');
model.material('mat1').propertyGroup.create('Enu', 'Young''s_modulus_and_Poisson''s_ratio');
model.material('mat1').propertyGroup('Enu').set('E', {'2.1e11'});
model.material('mat1').propertyGroup('Enu').set('nu', {'0.3'});
model.material('mat1').propertyGroup('def').set('density', {'7800'});

model.mesh('mesh1').create('ftri1', 'FreeTri');
model.mesh('mesh1').feature('ftri1').selection.geom('geom1', 2);
model.mesh('mesh1').feature('ftri1').selection.set([1]);
model.mesh('mesh1').feature('ftri1').create('size1', 'Size');
model.mesh('mesh1').feature('ftri1').feature('size1').selection.geom('geom1', 0);
model.mesh('mesh1').feature('ftri1').feature('size1').selection.set([1]);
model.mesh('mesh1').feature('ftri1').feature('size1').set('custom', true);
model.mesh('mesh1').feature('ftri1').feature('size1').set('hmaxactive', true);
model.mesh('mesh1').feature('ftri1').feature('size1').set('hmax', 0.02);
model.mesh('mesh1').create('map1', 'Map');
model.mesh('mesh1').feature('map1').create('dis1', 'Distribution');
model.mesh('mesh1').feature('map1').feature('dis1').selection.set([2]);
model.mesh('mesh1').feature('map1').feature('dis1').set('numelem', 4);
model.mesh('mesh1').run;

model.sol.create('sol1');
model.sol('sol1').study('std1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'stat');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').set('control', 'stat');
model.sol('sol1').create('s1', 'Stationary');
model.sol('sol1').feature('s1').feature('aDef').set('cachepattern', true);
model.sol('sol1').feature('s1').create('seDef', 'Segregated');
model.sol('sol1').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('s1').feature('fc1').set('termonres', 'auto');
model.sol('sol1').feature('s1').feature('fc1').set('reserrfact', 1000);
model.sol('sol1').feature('s1').feature('fc1').set('linsolver', 'dDef');
model.sol('sol1').feature('s1').feature('fc1').set('termonres', 'auto');
model.sol('sol1').feature('s1').feature('fc1').set('reserrfact', 1000);
model.sol('sol1').feature('s1').feature.remove('fcDef');
model.sol('sol1').feature('s1').feature.remove('seDef');
model.sol('sol1').attach('std1');
model.sol('sol1').runAll;

model.result.create('pg1', 'PlotGroup2D');
model.result('pg1').set('data', 'dset1');
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
model.result('pg1').feature('surf1').feature('def').set('expr', {'u' 'v'});
model.result('pg1').feature('surf1').feature('def').set('descr', 'Displacement field');
model.result.create('pg2', 'PlotGroup2D');
model.result('pg2').set('data', 'dset1');
model.result('pg2').set('defaultPlotID', 'stress');
model.result('pg2').label('Stress (solid2)');
model.result('pg2').set('frametype', 'spatial');
model.result('pg2').create('surf1', 'Surface');
model.result('pg2').feature('surf1').set('expr', {'solid2.misesGp'});
model.result('pg2').feature('surf1').set('threshold', 'manual');
model.result('pg2').feature('surf1').set('thresholdvalue', 0.2);
model.result('pg2').feature('surf1').set('colortable', 'Rainbow');
model.result('pg2').feature('surf1').set('colortabletrans', 'none');
model.result('pg2').feature('surf1').set('colorscalemode', 'linear');
model.result('pg2').feature('surf1').set('resolution', 'normal');
model.result('pg2').feature('surf1').set('colortable', 'Prism');
model.result('pg2').feature('surf1').create('def', 'Deform');
model.result('pg2').feature('surf1').feature('def').set('expr', {'u2' 'v2'});
model.result('pg2').feature('surf1').feature('def').set('descr', 'Displacement field');
model.result('pg1').run;
model.result.numerical.create('pev1', 'EvalPoint');
model.result.numerical('pev1').label('Error Evaluation');
model.result.numerical('pev1').selection.set([1 2]);
model.result.numerical('pev1').setIndex('expr', '(solid.sx-AnaStress(y))/AnaStress(y)', 0);
model.result.numerical('pev1').setIndex('unit', '', 0);
model.result.numerical('pev1').setIndex('descr', 'Error in finite plate', 0);
model.result.numerical('pev1').setIndex('expr', '(solid2.sx-AnaStress(y))/AnaStress(y)', 1);
model.result.numerical('pev1').setIndex('unit', '', 1);
model.result.numerical('pev1').setIndex('descr', 'Error in infinite plate', 1);
model.result.table.create('tbl1', 'Table');
model.result.table('tbl1').comments('Error Evaluation');
model.result.numerical('pev1').set('table', 'tbl1');
model.result.numerical('pev1').setResult;
model.result('pg1').run;
model.result('pg1').run;
model.result('pg1').feature('surf1').set('expr', 'solid.sGpxx');
model.result('pg1').feature('surf1').set('descr', 'Stress tensor, xx-component');
model.result('pg1').feature('surf1').set('colortable', 'Rainbow');
model.result('pg1').run;
model.result('pg1').feature('surf1').feature.remove('def');
model.result('pg1').run;
model.result('pg1').run;
model.result('pg2').run;
model.result('pg2').feature('surf1').set('expr', 'solid2.sGpxx');
model.result('pg2').feature('surf1').set('descr', 'Stress tensor, xx-component');
model.result('pg2').feature('surf1').set('colortable', 'Rainbow');
model.result('pg2').run;
model.result('pg2').feature('surf1').feature.remove('def');
model.result('pg2').run;
model.result('pg2').run;
model.result.create('pg3', 'PlotGroup1D');
model.result('pg3').run;
model.result('pg3').label('Stress Profile');
model.result('pg3').create('lngr1', 'LineGraph');
model.result('pg3').feature('lngr1').set('markerpos', 'datapoints');
model.result('pg3').feature('lngr1').set('linewidth', 'preference');
model.result('pg3').feature('lngr1').selection.set([1 2]);
model.result('pg3').feature('lngr1').set('expr', 'AnaStress(ym)');
model.result('pg3').feature('lngr1').set('xdata', 'expr');
model.result('pg3').feature('lngr1').set('xdataexpr', 'ym');
model.result('pg3').run;
model.result('pg3').feature('lngr1').set('legendmethod', 'manual');
model.result('pg3').feature('lngr1').set('legend', true);
model.result('pg3').feature('lngr1').setIndex('legends', 'Analytical', 0);
model.result('pg3').feature('lngr1').set('linestyle', 'dashed');
model.result('pg3').run;
model.result('pg3').run;
model.result('pg3').create('lngr2', 'LineGraph');
model.result('pg3').feature('lngr2').set('markerpos', 'datapoints');
model.result('pg3').feature('lngr2').set('linewidth', 'preference');
model.result('pg3').feature('lngr2').selection.set([1]);
model.result('pg3').feature('lngr2').set('expr', 'solid.sGpxx');
model.result('pg3').feature('lngr2').set('descr', 'Stress tensor, xx-component');
model.result('pg3').feature('lngr2').set('xdata', 'expr');
model.result('pg3').feature('lngr2').set('xdataexpr', 'y');
model.result('pg3').feature('lngr2').set('legend', true);
model.result('pg3').feature('lngr2').set('legendmethod', 'manual');
model.result('pg3').feature('lngr2').setIndex('legends', 'Finite plate', 0);
model.result('pg3').run;
model.result('pg3').create('lngr3', 'LineGraph');
model.result('pg3').feature('lngr3').set('markerpos', 'datapoints');
model.result('pg3').feature('lngr3').set('linewidth', 'preference');
model.result('pg3').feature('lngr3').selection.set([1 2]);
model.result('pg3').feature('lngr3').set('expr', 'solid2.sGpxx');
model.result('pg3').feature('lngr3').set('descr', 'Stress tensor, xx-component');
model.result('pg3').feature('lngr3').set('xdata', 'expr');
model.result('pg3').feature('lngr3').set('xdataexpr', 'ym');
model.result('pg3').feature('lngr3').set('legend', true);
model.result('pg3').feature('lngr3').set('legendmethod', 'manual');
model.result('pg3').feature('lngr3').setIndex('legends', 'Infinite plate', 0);
model.result('pg3').run;
model.result('pg3').set('axislimits', true);
model.result('pg3').set('xmin', 0);
model.result('pg3').set('xmax', 1.5);
model.result('pg3').set('xlabelactive', true);
model.result('pg3').set('xlabel', 'Physical y-coordinate (m)');
model.result('pg3').set('ylabelactive', true);
model.result('pg3').set('ylabel', ['Stress (N/m' native2unicode(hex2dec({'00' 'b2'}), 'unicode') ')']);
model.result('pg3').run;

model.title('Kirsch Infinite Plate Problem');

model.description('This static benchmark computes the stress distribution in the vicinity of a small hole in an infinite plate and compares the result with the analytical solution.');

model.label('kirsch_plate.mph');

model.modelNode.label('Components');

out = model;
