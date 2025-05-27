function out = model
%
% cycle_counting_benchmark.m
%
% Model exported on May 26 2025, 21:28 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/Fatigue_Module/Verification_Examples');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 2);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.physics.create('solid', 'SolidMechanics', 'geom1');
model.physics('solid').model('comp1');

model.study.create('std1');
model.study('std1').create('stat', 'Stationary');
model.study('std1').feature('stat').setSolveFor('/physics/solid', true);

model.geom('geom1').lengthUnit('mm');
model.geom('geom1').create('r1', 'Rectangle');
model.geom('geom1').feature('r1').set('size', [10 100]);
model.geom('geom1').run('r1');
model.geom('geom1').create('r2', 'Rectangle');
model.geom('geom1').feature('r2').set('size', {'10-6.25' '50-sqrt(12.5^2-8.75^2)'});
model.geom('geom1').feature('r2').set('pos', [6.25 0]);
model.geom('geom1').run('r2');
model.geom('geom1').create('c1', 'Circle');
model.geom('geom1').feature('c1').set('pos', {'6.25+12.5' '50-sqrt(12.5^2-8.75^2)'});
model.geom('geom1').feature('c1').set('r', 12.5);
model.geom('geom1').run('c1');
model.geom('geom1').create('dif1', 'Difference');
model.geom('geom1').feature('dif1').selection('input').set({'r1'});
model.geom('geom1').feature('dif1').selection('input2').set({'c1' 'r2'});
model.geom('geom1').runPre('fin');

model.func.create('int1', 'Interpolation');
model.func('int1').setIndex('table', 1, 0, 0);
model.func('int1').setIndex('table', -2, 0, 1);
model.func('int1').setIndex('table', 2, 1, 0);
model.func('int1').setIndex('table', 1, 1, 1);
model.func('int1').setIndex('table', 3, 2, 0);
model.func('int1').setIndex('table', -3, 2, 1);
model.func('int1').setIndex('table', 4, 3, 0);
model.func('int1').setIndex('table', 5, 3, 1);
model.func('int1').setIndex('table', 5, 4, 0);
model.func('int1').setIndex('table', -1, 4, 1);
model.func('int1').setIndex('table', 6, 5, 0);
model.func('int1').setIndex('table', 3, 5, 1);
model.func('int1').setIndex('table', 7, 6, 0);
model.func('int1').setIndex('table', -4, 6, 1);
model.func('int1').setIndex('table', 8, 7, 0);
model.func('int1').setIndex('table', 4, 7, 1);
model.func('int1').setIndex('table', 9, 8, 0);
model.func('int1').setIndex('table', -2, 8, 1);

model.geom('geom1').run;

model.physics('solid').prop('Type2D').set('Type2D', 'PlaneStress');
model.physics('solid').prop('d').set('d', 0.00625);
model.physics('solid').create('sym1', 'SymmetrySolid', 1);
model.physics('solid').feature('sym1').selection.set([1 2]);
model.physics('solid').create('bndl1', 'BoundaryLoad', 1);
model.physics('solid').feature('bndl1').selection.set([3]);
model.physics('solid').feature('bndl1').set('LoadType', 'TotalForce');
model.physics('solid').feature('bndl1').set('Ftot', {'0' 'F*int1(case)' '0'});

model.param.set('F', '10*6.25*12.5/2');
model.param.descr('F', 'Load unit');
model.param.set('case', '1');
model.param.descr('case', 'Load case');

model.material.create('mat1', 'Common', 'comp1');
model.material('mat1').propertyGroup.create('Enu', 'Young''s_modulus_and_Poisson''s_ratio');
model.material('mat1').propertyGroup('Enu').set('E', {'69e9'});
model.material('mat1').propertyGroup('Enu').set('nu', {'0.34'});
model.material('mat1').propertyGroup('def').set('density', {'2700'});

model.study('std1').feature('stat').set('useparam', true);
model.study('std1').feature('stat').setIndex('pname', 'F', 0);
model.study('std1').feature('stat').setIndex('plistarr', '', 0);
model.study('std1').feature('stat').setIndex('punit', '', 0);
model.study('std1').feature('stat').setIndex('pname', 'F', 0);
model.study('std1').feature('stat').setIndex('plistarr', '', 0);
model.study('std1').feature('stat').setIndex('punit', '', 0);
model.study('std1').feature('stat').setIndex('pname', 'case', 0);
model.study('std1').feature('stat').setIndex('plistarr', 'range(1,1,9)', 0);

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
model.sol('sol1').feature('s1').feature('fc1').set('linsolver', 'dDef');
model.sol('sol1').feature('s1').feature('fc1').set('termonres', 'auto');
model.sol('sol1').feature('s1').feature('fc1').set('reserrfact', 1000);
model.sol('sol1').feature('s1').feature.remove('fcDef');
model.sol('sol1').attach('std1');
model.sol('sol1').runAll;

model.result.create('pg1', 'PlotGroup2D');
model.result('pg1').set('data', 'dset1');
model.result('pg1').setIndex('looplevel', 9, 0);
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
model.result('pg1').run;
model.result.dataset.create('mir1', 'Mirror2D');
model.result.dataset('mir1').setIndex('genpoints', 100, 1, 1);
model.result.dataset.create('mir2', 'Mirror2D');
model.result.dataset('mir2').set('data', 'mir1');
model.result.dataset('mir2').setIndex('genpoints', -6.25, 0, 0);
model.result.dataset('mir2').setIndex('genpoints', 6.25, 1, 0);
model.result.dataset('mir2').setIndex('genpoints', 0, 1, 1);
model.result('pg1').run;
model.result('pg1').set('data', 'mir2');
model.result('pg1').setIndex('looplevel', 2, 0);
model.result('pg1').set('titletype', 'none');
model.result('pg1').set('showlegendsunit', true);
model.result('pg1').run;
model.result('pg1').feature('surf1').set('expr', 'solid.SGpYY');
model.result('pg1').feature('surf1').set('descr', ['Second Piola' native2unicode(hex2dec({'20' '13'}), 'unicode') 'Kirchhoff stress, YY-component']);
model.result('pg1').feature('surf1').set('unit', 'MPa');
model.result('pg1').run;
model.result.create('pg2', 'PlotGroup1D');
model.result('pg2').run;
model.result('pg2').label('Load Cycle Response');
model.result('pg2').create('ptgr1', 'PointGraph');
model.result('pg2').feature('ptgr1').set('markerpos', 'datapoints');
model.result('pg2').feature('ptgr1').set('linewidth', 'preference');
model.result('pg2').feature('ptgr1').selection.set([3]);
model.result('pg2').feature('ptgr1').set('expr', 'solid.SGpYY');
model.result('pg2').feature('ptgr1').set('descr', ['Second Piola' native2unicode(hex2dec({'20' '13'}), 'unicode') 'Kirchhoff stress, YY-component']);
model.result('pg2').feature('ptgr1').set('unit', 'MPa');
model.result('pg2').run;

model.func.create('an1', 'Analytic');
model.func('an1').set('args', 'R, N');
model.func('an1').set('expr', '(94e6*(R/-0.36)^1.15)*N^-0.119');

model.physics.create('ftg', 'Fatigue', 'geom1');
model.physics('ftg').model('comp1');

model.study('std1').feature('stat').setSolveFor('/physics/ftg', false);

model.physics('ftg').create('cdam1', 'CumulativeDamageModel2', 0);
model.physics('ftg').feature('cdam1').selection.set([3]);
model.physics('ftg').feature('cdam1').set('fatigueInputPhysics', 'solid');
model.physics('ftg').feature('cdam1').set('cDamDiscretizationMean', 5);
model.physics('ftg').feature('cdam1').set('cDamDiscretizationRange', 7);
model.physics('ftg').feature('cdam1').set('lifeCurve', 'an1');
model.physics('ftg').feature('cdam1').set('m', 100000);
model.physics('ftg').feature('cdam1').set('Ncut', '1e8');

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

model.result.create('pg3', 'PlotGroup1D');
model.result('pg3').set('data', 'dset2');
model.result('pg3').create('ptgr1', 'PointGraph');
model.result('pg3').feature('ptgr1').selection.all;
model.result('pg3').feature('ptgr1').set('expr', {'ftg.fus'});
model.result('pg3').feature('ptgr1').selection.set([3]);
model.result('pg3').label('Fatigue Usage Factor (ftg)');
model.result.create('pg4', 'PlotGroup2D');
model.result('pg4').set('data', 'none');
model.result('pg4').create('hist1', 'MatrixHistogram');
model.result('pg4').feature('hist1').set('data', 'dset2');
model.result('pg4').feature('hist1').set('expr', 'ftg.cdam1.csc');
model.result('pg4').label('Stress Cycle Distribution (ftg)');
model.result('pg4').feature('hist1').set('xdata', 'Mean stress');
model.result('pg4').feature('hist1').set('ydata', 'Stress amplitude');
model.result('pg4').feature('hist1').create('hght', 'HistogramHeight');
model.result('pg4').feature('hist1').feature('hght').label('Height expression (for 3D histogram)');
model.result.create('pg5', 'PlotGroup2D');
model.result('pg5').set('data', 'none');
model.result('pg5').create('hist1', 'MatrixHistogram');
model.result('pg5').feature('hist1').set('data', 'dset2');
model.result('pg5').feature('hist1').set('expr', 'ftg.cdam1.rus');
model.result('pg5').label('Fatigue Usage Distribution (ftg)');
model.result('pg5').feature('hist1').set('xdata', 'Mean stress');
model.result('pg5').feature('hist1').set('ydata', 'Stress amplitude');
model.result('pg5').feature('hist1').create('hght', 'HistogramHeight');
model.result('pg5').feature('hist1').feature('hght').label('Height expression (for 3D histogram)');
model.result('pg3').run;
model.result('pg4').run;
model.result('pg4').run;
model.result('pg4').feature('hist1').set('axisunit', 'MPa');
model.result('pg4').run;
model.result('pg5').run;
model.result('pg5').run;
model.result('pg5').feature('hist1').set('axisunit', 'MPa');
model.result('pg5').run;
model.result('pg4').run;

model.title(['Cycle Counting in Fatigue Analysis ' native2unicode(hex2dec({'20' '14'}), 'unicode') ' Benchmark']);

model.description(['A benchmark problem of the Rainflow Counting algorithm compares results between ASTM and the COMSOL Fatigue Module using a flat tensile test specimen. An extension is made for the cumulative damage calculation following the Palmgren' native2unicode(hex2dec({'20' '13'}), 'unicode') 'Miner model and results are compared with analytical expressions.']);

model.label('cycle_counting_benchmark.mph');

model.modelNode.label('Components');

out = model;
