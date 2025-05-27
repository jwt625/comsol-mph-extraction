function out = model
%
% general_parameter_estimation.m
%
% Model exported on May 26 2025, 21:31 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/Optimization_Module/Applications');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 1);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

% To import content from file, use:
% model.param.loadFile('FILENAME');
model.param.set('xparam', '0');
model.param.set('xmin', '2');
model.param.set('xmax', '14');
model.param.set('tol', '0.001');
model.param.set('conf', '0.95');
model.param.set('par1', '0');
model.param.set('par2', '0');
model.param.set('par3', '0');
model.param.set('par4', '0');
model.param.set('par5', '0');
model.param.set('par1min', '-Inf');
model.param.set('par2min', '-Inf');
model.param.set('par3min', '-Inf');
model.param.set('par4min', '-Inf');
model.param.set('par5min', '-Inf');
model.param.set('par1max', 'Inf');
model.param.set('par2max', 'Inf');
model.param.set('par3max', 'Inf');
model.param.set('par4max', 'Inf');
model.param.set('par5max', 'Inf');
model.param.set('par1scale', '1');
model.param.set('par2scale', '1');
model.param.set('par3scale', '1');
model.param.set('par4scale', '1');
model.param.set('par5scale', '1');

model.func.create('an1', 'Analytic');
model.func('an1').model('comp1');
model.func('an1').set('expr', 'par1*x+par2');

model.geom('geom1').create('i1', 'Interval');
model.geom('geom1').feature('i1').setIndex('coord', 'xmin', 0);
model.geom('geom1').feature('i1').setIndex('coord', 'xmax', 1);
model.geom('geom1').run;

model.mesh('mesh1').create('edg1', 'Edge');
model.mesh('mesh1').feature('size').set('hmax', '1e-3*(xmax-xmin)');
model.mesh('mesh1').run;

model.result.table.create('tbl1', 'Table');
model.result.table('tbl1').importData('general_parameter_estimation_embedded_data.txt');
model.result.table.create('tbl2', 'Table');

model.common.create('glso1', 'GlobalLeastSquaresObjective', 'comp1');
model.common('glso1').set('source', 'resultTable');
model.common('glso1').setEntry('columnType', 'col1', 'param');
model.common('glso1').setEntry('parameterName', 'col1', 'xparam');
model.common('glso1').setEntry('modelExpression', 'col2', 'par1*xparam+par2');
model.common('glso1').setEntry('scaleMethod', 'col2', 'manual');

model.study.create('std1');
model.study('std1').create('stat', 'Stationary');
model.study('std1').setGenPlots(false);
model.study('std1').create('opt', 'Optimization');
model.study('std1').feature('opt').set('optsolver', 'lm');
model.study('std1').feature('opt').set('opttolinner', 'tol');
model.study('std1').feature('opt').setIndex('pname', 'xparam', 0);
model.study('std1').feature('opt').setIndex('initval', 0, 0);
model.study('std1').feature('opt').setIndex('scale', 1, 0);
model.study('std1').feature('opt').setIndex('lbound', '', 0);
model.study('std1').feature('opt').setIndex('ubound', '', 0);
model.study('std1').feature('opt').setIndex('pname', 'xparam', 0);
model.study('std1').feature('opt').setIndex('initval', 0, 0);
model.study('std1').feature('opt').setIndex('scale', 1, 0);
model.study('std1').feature('opt').setIndex('lbound', '', 0);
model.study('std1').feature('opt').setIndex('ubound', '', 0);
model.study('std1').feature('opt').setIndex('pname', 'xmin', 1);
model.study('std1').feature('opt').setIndex('initval', 2, 1);
model.study('std1').feature('opt').setIndex('scale', 1, 1);
model.study('std1').feature('opt').setIndex('lbound', '', 1);
model.study('std1').feature('opt').setIndex('ubound', '', 1);
model.study('std1').feature('opt').setIndex('pname', 'xmin', 1);
model.study('std1').feature('opt').setIndex('initval', 2, 1);
model.study('std1').feature('opt').setIndex('scale', 1, 1);
model.study('std1').feature('opt').setIndex('lbound', '', 1);
model.study('std1').feature('opt').setIndex('ubound', '', 1);
model.study('std1').feature('opt').setIndex('pname', 'par1', 0);
model.study('std1').feature('opt').setIndex('pname', 'par2', 1);
model.study('std1').feature('opt').set('addconfint', true);
model.study('std1').feature('opt').set('conflevel', 'conf');
model.study('std1').feature('opt').set('confinttable', 'tbl2');
model.study('std1').feature('stat').set('useparam', true);
model.study('std1').feature('stat').set('plistarr', {'2.0000000000000000e+00 2.2448979591836733e+00 2.4897959183673470e+00 2.7346938775510203e+00 2.9795918367346940e+00 3.2244897959183674e+00 3.4693877551020407e+00 3.7142857142857144e+00 3.9591836734693877e+00 4.2040816326530610e+00 4.4489795918367350e+00 4.6938775510204085e+00 4.9387755102040810e+00 5.1836734693877550e+00 5.4285714285714290e+00 5.6734693877551020e+00 5.9183673469387750e+00 6.1632653061224490e+00 6.4081632653061230e+00 6.6530612244897960e+00 6.8979591836734695e+00 7.1428571428571420e+00 7.3877551020408160e+00 7.6326530612244900e+00 7.8775510204081630e+00 8.1224489795918370e+00 8.3673469387755100e+00 8.6122448979591830e+00 8.8571428571428580e+00 9.1020408163265300e+00 9.3469387755102030e+00 9.5918367346938780e+00 9.8367346938775500e+00 1.0081632653061224e+01 1.0326530612244898e+01 1.0571428571428571e+01 1.0816326530612246e+01 1.1061224489795919e+01 1.1306122448979592e+01 1.1551020408163264e+01 1.1795918367346939e+01 1.2040816326530614e+01 1.2285714285714285e+01 1.2530612244897960e+01 1.2775510204081632e+01 1.3020408163265307e+01 1.3265306122448980e+01 1.3510204081632653e+01 1.3755102040816325e+01 1.4000000000000000e+01'});
model.study('std1').feature('stat').set('pname', {'xparam'});

model.sol.create('sol1');
model.sol('sol1').study('std1');

model.study('std1').feature('opt').set('lsqmessage', {'Explicit_parameter_sweep_merged_with_parameter_variation_from_LSQ_objective'});

model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'stat');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').set('control', 'stat');
model.sol('sol1').create('o1', 'Optimization');
model.sol('sol1').feature('o1').set('control', 'opt');
model.sol('sol1').feature('o1').create('s1', 'StationaryAttrib');
model.sol('sol1').feature('o1').feature('s1').set('control', 'stat');
model.sol('sol1').feature('o1').feature('s1').create('p1', 'Parametric');
model.sol('sol1').feature('o1').feature('s1').feature.remove('pDef');
model.sol('sol1').feature('o1').feature('s1').feature('p1').set('pname', {'xparam'});
model.sol('sol1').feature('o1').feature('s1').feature('p1').set('plistarr', {'2.0000000000000000e+00 2.2448979591836733e+00 2.4897959183673470e+00 2.7346938775510203e+00 2.9795918367346940e+00 3.2244897959183674e+00 3.4693877551020407e+00 3.7142857142857144e+00 3.9591836734693877e+00 4.2040816326530610e+00 4.4489795918367350e+00 4.6938775510204085e+00 4.9387755102040810e+00 5.1836734693877550e+00 5.4285714285714290e+00 5.6734693877551020e+00 5.9183673469387750e+00 6.1632653061224490e+00 6.4081632653061230e+00 6.6530612244897960e+00 6.8979591836734695e+00 7.1428571428571420e+00 7.3877551020408160e+00 7.6326530612244900e+00 7.8775510204081630e+00 8.1224489795918370e+00 8.3673469387755100e+00 8.6122448979591830e+00 8.8571428571428580e+00 9.1020408163265300e+00 9.3469387755102030e+00 9.5918367346938780e+00 9.8367346938775500e+00 1.0081632653061224e+01 1.0326530612244898e+01 1.0571428571428571e+01 1.0816326530612246e+01 1.1061224489795919e+01 1.1306122448979592e+01 1.1551020408163264e+01 1.1795918367346939e+01 1.2040816326530614e+01 1.2285714285714285e+01 1.2530612244897960e+01 1.2775510204081632e+01 1.3020408163265307e+01 1.3265306122448980e+01 1.3510204081632653e+01 1.3755102040816325e+01 1.4000000000000000e+01'});
model.sol('sol1').feature('o1').feature('s1').feature('p1').set('punit', {''});
model.sol('sol1').feature('o1').feature('s1').feature('p1').set('sweeptype', 'sparse');
model.sol('sol1').feature('o1').feature('s1').feature('p1').set('plot', 'off');
model.sol('sol1').feature('o1').feature('s1').feature('p1').set('probesel', 'none');
model.sol('sol1').feature('o1').feature('s1').feature('p1').set('control', 'stat');
model.sol('sol1').feature('o1').feature('s1').set('control', 'stat');
model.sol('sol1').feature('o1').feature('s1').create('p2', 'Parametric');
model.sol('sol1').feature('o1').feature('s1').feature('p2').set('control', 'stat');
model.sol('sol1').feature('o1').feature('s1').set('control', 'stat');
model.sol('sol1').feature('o1').feature('s1').feature('p2').set('plistarrlsq', {'2.0, 2.2448979591836733, 2.489795918367347, 2.7346938775510203, 2.979591836734694, 3.2244897959183674, 3.4693877551020407, 3.7142857142857144, 3.9591836734693877, 4.204081632653061, 4.448979591836735, 4.6938775510204085, 4.938775510204081, 5.183673469387755, 5.428571428571429, 5.673469387755102, 5.918367346938775, 6.163265306122449, 6.408163265306123, 6.653061224489796, 6.8979591836734695, 7.142857142857142, 7.387755102040816, 7.63265306122449, 7.877551020408163, 8.122448979591837, 8.36734693877551, 8.612244897959183, 8.857142857142858, 9.10204081632653, 9.346938775510203, 9.591836734693878, 9.83673469387755, 10.081632653061224, 10.326530612244898, 10.571428571428571, 10.816326530612246, 11.061224489795919, 11.306122448979592, 11.551020408163264, 11.795918367346939, 12.040816326530614, 12.285714285714285, 12.53061224489796, 12.775510204081632, 13.020408163265307, 13.26530612244898, 13.510204081632653, 13.755102040816325, 14.0'});
model.sol('sol1').feature('o1').feature('s1').feature('p2').set('lsqparamsout', ['    xparam' newline '      2.00' newline '      2.24' newline '      2.49' newline '      2.73' newline '      2.98' newline '      3.22' newline '      3.47' newline '      3.71' newline '      3.96' newline '      4.20' newline '      4.45' newline '      4.69' newline '      4.94' newline '      5.18' newline '      5.43' newline '      5.67' newline '      5.92' newline '      6.16' newline '      6.41' newline '      6.65' newline '      6.90' newline '      7.14' newline '      7.39' newline '      7.63' newline '      7.88' newline '      8.12' newline '      8.37' newline '      8.61' newline '      8.86' newline '      9.10' newline '      9.35' newline '      9.59' newline '      9.84' newline '      10.1' newline '      10.3' newline '      10.6' newline '      10.8' newline '      11.1' newline '      11.3' newline '      11.6' newline '      11.8' newline '      12.0' newline '      12.3' newline '      12.5' newline '      12.8' newline '      13.0' newline '      13.3' newline '      13.5' newline '      13.8' newline '      14.0' newline ]);
model.sol('sol1').feature('o1').feature('s1').feature('p2').set('pnamelsq', {'xparam'});
model.sol('sol1').feature('o1').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('o1').feature('s1').feature.remove('fcDef');
model.sol('sol1').attach('std1');
model.sol('sol1').runAll;

model.study('std1').feature('opt').set('probewindow', '');

model.result.dataset.create('mesh1', 'Mesh');
model.result.create('pg1', 'PlotGroup1D');
model.result('pg1').run;
model.result('pg1').set('titletype', 'none');
model.result('pg1').set('legendpos', 'upperleft');
model.result('pg1').create('tblp1', 'Table');
model.result('pg1').feature('tblp1').set('markerpos', 'datapoints');
model.result('pg1').feature('tblp1').set('linewidth', 'preference');
model.result('pg1').feature('tblp1').set('linestyle', 'none');
model.result('pg1').feature('tblp1').set('linecolor', 'red');
model.result('pg1').feature('tblp1').set('linemarker', 'square');
model.result('pg1').feature('tblp1').set('legend', true);
model.result('pg1').feature('tblp1').set('legendmethod', 'manual');
model.result('pg1').feature('tblp1').setIndex('legends', 'Data', 0);
model.result('pg1').run;
model.result('pg1').run;
model.result('pg1').create('lngr1', 'LineGraph');
model.result('pg1').feature('lngr1').set('markerpos', 'datapoints');
model.result('pg1').feature('lngr1').set('linewidth', 'preference');
model.result('pg1').feature('lngr1').set('data', 'mesh1');
model.result('pg1').feature('lngr1').selection.all;
model.result('pg1').feature('lngr1').set('expr', 'par1*x+par2');
model.result('pg1').feature('lngr1').set('xdata', 'expr');
model.result('pg1').feature('lngr1').set('xdataexpr', 'x');
model.result('pg1').feature('lngr1').set('linestyle', 'dashed');
model.result('pg1').feature('lngr1').set('linecolor', 'black');
model.result('pg1').feature('lngr1').set('legend', true);
model.result('pg1').feature('lngr1').set('legendmethod', 'manual');
model.result('pg1').feature('lngr1').setIndex('legends', 'Initial Model', 0);
model.result('pg1').feature.duplicate('lngr2', 'lngr1');
model.result('pg1').run;
model.result('pg1').feature('lngr2').set('expr', '0.39883*x+2.9880');
model.result('pg1').feature('lngr2').set('linestyle', 'solid');
model.result('pg1').feature('lngr2').set('linecolor', 'blue');
model.result('pg1').feature('lngr2').setIndex('legends', 'Optimized Model', 0);
model.result('pg1').feature('lngr2').active(false);

model.study('std1').feature('opt').set('optsolver', 'bobyqa');

model.sol('sol1').study('std1');
model.sol('sol1').feature.remove('o1');
model.sol('sol1').feature.remove('v1');
model.sol('sol1').feature.remove('st1');

model.study('std1').feature('opt').set('lsqmessage', {'Explicit_parameter_sweep_merged_with_parameter_variation_from_LSQ_objective'});

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
model.sol('sol1').feature('s1').feature('p1').set('plistarrlsq', {'2.0, 2.2448979591836733, 2.489795918367347, 2.7346938775510203, 2.979591836734694, 3.2244897959183674, 3.4693877551020407, 3.7142857142857144, 3.9591836734693877, 4.204081632653061, 4.448979591836735, 4.6938775510204085, 4.938775510204081, 5.183673469387755, 5.428571428571429, 5.673469387755102, 5.918367346938775, 6.163265306122449, 6.408163265306123, 6.653061224489796, 6.8979591836734695, 7.142857142857142, 7.387755102040816, 7.63265306122449, 7.877551020408163, 8.122448979591837, 8.36734693877551, 8.612244897959183, 8.857142857142858, 9.10204081632653, 9.346938775510203, 9.591836734693878, 9.83673469387755, 10.081632653061224, 10.326530612244898, 10.571428571428571, 10.816326530612246, 11.061224489795919, 11.306122448979592, 11.551020408163264, 11.795918367346939, 12.040816326530614, 12.285714285714285, 12.53061224489796, 12.775510204081632, 13.020408163265307, 13.26530612244898, 13.510204081632653, 13.755102040816325, 14.0'});
model.sol('sol1').feature('s1').feature('p1').set('lsqparamsout', ['    xparam' newline '      2.00' newline '      2.24' newline '      2.49' newline '      2.73' newline '      2.98' newline '      3.22' newline '      3.47' newline '      3.71' newline '      3.96' newline '      4.20' newline '      4.45' newline '      4.69' newline '      4.94' newline '      5.18' newline '      5.43' newline '      5.67' newline '      5.92' newline '      6.16' newline '      6.41' newline '      6.65' newline '      6.90' newline '      7.14' newline '      7.39' newline '      7.63' newline '      7.88' newline '      8.12' newline '      8.37' newline '      8.61' newline '      8.86' newline '      9.10' newline '      9.35' newline '      9.59' newline '      9.84' newline '      10.1' newline '      10.3' newline '      10.6' newline '      10.8' newline '      11.1' newline '      11.3' newline '      11.6' newline '      11.8' newline '      12.0' newline '      12.3' newline '      12.5' newline '      12.8' newline '      13.0' newline '      13.3' newline '      13.5' newline '      13.8' newline '      14.0' newline ]);
model.sol('sol1').feature('s1').feature('p1').set('pnamelsq', {'xparam'});
model.sol('sol1').attach('std1');

model.batch.create('o1', 'Optimization');
model.batch('o1').study('std1');
model.batch('p1').study('std1');
model.batch('o1').attach('std1');
model.batch('p1').create('so1', 'Solutionseq');
model.batch('p1').feature('so1').set('seq', 'sol1');
model.batch('p1').feature('so1').set('store', 'on');
model.batch('p1').feature('so1').set('clear', 'on');
model.batch('p1').feature('so1').set('psol', 'none');
model.batch('p1').attach('std1');
model.batch('p1').set('optimization', 'o1');
model.batch('p1').set('err', 'on');
model.batch('p1').set('control', 'opt');
model.batch('o1').set('parametricjobs', {'p1'});

model.sol.create('sol2');
model.sol('sol2').study('std1');
model.sol('sol2').label('Parametric Solutions 1');

model.batch('p1').feature('so1').set('psol', 'sol2');
model.batch('o1').run('compute');

model.result('pg1').run;

model.study('std1').feature('opt').set('probewindow', '');

model.result('pg1').run;
model.result('pg1').feature('lngr2').active(true);
model.result('pg1').run;
model.result('pg1').feature('lngr1').active(false);
model.result('pg1').run;
model.result('pg1').feature('lngr2').active(false);
model.result('pg1').run;
model.result('pg1').feature('lngr1').active(true);
model.result.table.remove('tbl3');

model.title([]);

model.description('');

model.label('general_parameter_estimation_embedded.mph');

model.sol('sol1').copySolution('sol4');

model.study('std1').feature('opt').set('optsolver', 'lm');

model.sol('sol4').study('std1');

model.study('std1').feature('opt').set('lsqmessage', {'Explicit_parameter_sweep_merged_with_parameter_variation_from_LSQ_objective'});

model.sol('sol4').create('st1', 'StudyStep');
model.sol('sol4').feature('st1').set('study', 'std1');
model.sol('sol4').feature('st1').set('studystep', 'stat');
model.sol('sol4').create('v1', 'Variables');
model.sol('sol4').feature('v1').set('control', 'stat');
model.sol('sol4').create('o1', 'Optimization');
model.sol('sol4').feature('o1').set('control', 'opt');
model.sol('sol4').feature('o1').create('s1', 'StationaryAttrib');
model.sol('sol4').feature('o1').feature('s1').set('control', 'stat');
model.sol('sol4').feature('o1').feature('s1').create('p1', 'Parametric');
model.sol('sol4').feature('o1').feature('s1').feature.remove('pDef');
model.sol('sol4').feature('o1').feature('s1').feature('p1').set('pname', {'xparam'});
model.sol('sol4').feature('o1').feature('s1').feature('p1').set('plistarr', {'2.0000000000000000e+00 2.2448979591836733e+00 2.4897959183673470e+00 2.7346938775510203e+00 2.9795918367346940e+00 3.2244897959183674e+00 3.4693877551020407e+00 3.7142857142857144e+00 3.9591836734693877e+00 4.2040816326530610e+00 4.4489795918367350e+00 4.6938775510204085e+00 4.9387755102040810e+00 5.1836734693877550e+00 5.4285714285714290e+00 5.6734693877551020e+00 5.9183673469387750e+00 6.1632653061224490e+00 6.4081632653061230e+00 6.6530612244897960e+00 6.8979591836734695e+00 7.1428571428571420e+00 7.3877551020408160e+00 7.6326530612244900e+00 7.8775510204081630e+00 8.1224489795918370e+00 8.3673469387755100e+00 8.6122448979591830e+00 8.8571428571428580e+00 9.1020408163265300e+00 9.3469387755102030e+00 9.5918367346938780e+00 9.8367346938775500e+00 1.0081632653061224e+01 1.0326530612244898e+01 1.0571428571428571e+01 1.0816326530612246e+01 1.1061224489795919e+01 1.1306122448979592e+01 1.1551020408163264e+01 1.1795918367346939e+01 1.2040816326530614e+01 1.2285714285714285e+01 1.2530612244897960e+01 1.2775510204081632e+01 1.3020408163265307e+01 1.3265306122448980e+01 1.3510204081632653e+01 1.3755102040816325e+01 1.4000000000000000e+01'});
model.sol('sol4').feature('o1').feature('s1').feature('p1').set('punit', {''});
model.sol('sol4').feature('o1').feature('s1').feature('p1').set('sweeptype', 'sparse');
model.sol('sol4').feature('o1').feature('s1').feature('p1').set('plot', 'off');
model.sol('sol4').feature('o1').feature('s1').feature('p1').set('probesel', 'none');
model.sol('sol4').feature('o1').feature('s1').feature('p1').set('control', 'stat');
model.sol('sol4').feature('o1').feature('s1').set('control', 'stat');
model.sol('sol4').feature('o1').feature('s1').create('p2', 'Parametric');
model.sol('sol4').feature('o1').feature('s1').feature('p2').set('control', 'stat');
model.sol('sol4').feature('o1').feature('s1').set('control', 'stat');
model.sol('sol4').feature('o1').feature('s1').feature('p2').set('plistarrlsq', {'2.0, 2.2448979591836733, 2.489795918367347, 2.7346938775510203, 2.979591836734694, 3.2244897959183674, 3.4693877551020407, 3.7142857142857144, 3.9591836734693877, 4.204081632653061, 4.448979591836735, 4.6938775510204085, 4.938775510204081, 5.183673469387755, 5.428571428571429, 5.673469387755102, 5.918367346938775, 6.163265306122449, 6.408163265306123, 6.653061224489796, 6.8979591836734695, 7.142857142857142, 7.387755102040816, 7.63265306122449, 7.877551020408163, 8.122448979591837, 8.36734693877551, 8.612244897959183, 8.857142857142858, 9.10204081632653, 9.346938775510203, 9.591836734693878, 9.83673469387755, 10.081632653061224, 10.326530612244898, 10.571428571428571, 10.816326530612246, 11.061224489795919, 11.306122448979592, 11.551020408163264, 11.795918367346939, 12.040816326530614, 12.285714285714285, 12.53061224489796, 12.775510204081632, 13.020408163265307, 13.26530612244898, 13.510204081632653, 13.755102040816325, 14.0'});
model.sol('sol4').feature('o1').feature('s1').feature('p2').set('lsqparamsout', ['    xparam' newline '      2.00' newline '      2.24' newline '      2.49' newline '      2.73' newline '      2.98' newline '      3.22' newline '      3.47' newline '      3.71' newline '      3.96' newline '      4.20' newline '      4.45' newline '      4.69' newline '      4.94' newline '      5.18' newline '      5.43' newline '      5.67' newline '      5.92' newline '      6.16' newline '      6.41' newline '      6.65' newline '      6.90' newline '      7.14' newline '      7.39' newline '      7.63' newline '      7.88' newline '      8.12' newline '      8.37' newline '      8.61' newline '      8.86' newline '      9.10' newline '      9.35' newline '      9.59' newline '      9.84' newline '      10.1' newline '      10.3' newline '      10.6' newline '      10.8' newline '      11.1' newline '      11.3' newline '      11.6' newline '      11.8' newline '      12.0' newline '      12.3' newline '      12.5' newline '      12.8' newline '      13.0' newline '      13.3' newline '      13.5' newline '      13.8' newline '      14.0' newline ]);
model.sol('sol4').feature('o1').feature('s1').feature('p2').set('pnamelsq', {'xparam'});
model.sol('sol4').feature('o1').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol4').feature('o1').feature('s1').feature.remove('fcDef');

model.result.report.create('rpt1', 'Report');
model.result.report('rpt1').set('format', 'docx');
model.result.report('rpt1').set('filename', 'user:///general_data_fitting.docx');
model.result.report('rpt1').set('pagebreaklevel', '2');
model.result.report('rpt1').set('enumlevel', 'none');
model.result.report('rpt1').set('imagesize', 'large');
model.result.report('rpt1').feature.create('tp1', 'TitlePage');
model.result.report('rpt1').feature('tp1').set('title', 'General Parameter Estimation');
model.result.report('rpt1').feature('tp1').set('titleimage', 'none');
model.result.report('rpt1').feature('tp1').set('frontmatterlayout', 'headings');
model.result.report('rpt1').feature.create('sec1', 'Section');
model.result.report('rpt1').feature('sec1').label('Software Information');
model.result.report('rpt1').feature('sec1').feature.create('root1', 'Model');
model.result.report('rpt1').feature('sec1').feature('root1').label('About the Software');
model.result.report('rpt1').feature('sec1').feature('root1').set('includeusedproducts', false);
model.result.report('rpt1').feature('sec1').feature('root1').set('includename', false);
model.result.report('rpt1').feature.create('sec2', 'Section');
model.result.report('rpt1').feature('sec2').label('Solver');
model.result.report('rpt1').feature('sec2').feature.create('txt1', 'Text');
model.result.report('rpt1').feature('sec2').feature('txt1').set('text', ['Solver type: Levenberg-Marquardt' newline 'Tolerance: 0.001' newline 'Maximum number of model evaluations: 1000' newline 'Confidence: 0.95' newline 'Minimize: Sum' newline 'Function:  par1*x+par2' newline  newline 'Initial values for parameters, scale (lower, upper bounds)' newline '0, 1 (,)' newline '0, 1 (,)']);
model.result.report('rpt1').feature.create('sec3', 'Section');
model.result.report('rpt1').feature('sec3').label('Results');
model.result.report('rpt1').feature('sec3').feature.create('mtbl1', 'Table');
model.result.report('rpt1').feature('sec3').feature('mtbl1').set('noderef', 'tbl2');
model.result.report('rpt1').feature('sec3').feature.create('pg1', 'PlotGroup');

model.title('General Parameter Estimation');

model.description(['This app demonstrates the following:' newline  newline  native2unicode(hex2dec({'20' '22'}), 'unicode') ' Importing measured data from a text file or use built-in functionality for data generation' newline  native2unicode(hex2dec({'20' '22'}), 'unicode') ' Automatically change solver options based on the input' newline  native2unicode(hex2dec({'20' '22'}), 'unicode') ' Dynamically update the equation display' newline  newline 'The app can be used to estimate parameters in models without any physics. Data can be imported from a file or the built-in functionality for data generation can be utilized.' newline  newline 'The models include linear, quadratic, sigmoid, sloped Gaussian, and a custom model with up to five parameters.' newline  newline 'The Levenberg' native2unicode(hex2dec({'20' '13'}), 'unicode') 'Marquardt solver computes confidence intervals for the estimated parameters, while the other solvers (MMA, SNOPT, IPOPT, and BOBYQA) allow for specification of parameter bounds. MMA and BOBYQA allow for minimization of the maximum square instead of the sum.']);

model.mesh.clearMeshes;

model.sol('sol1').clearSolutionData;
model.sol('sol2').clearSolutionData;
model.sol('sol3').clearSolutionData;
model.sol('sol4').clearSolutionData;

model.label('general_parameter_estimation.mph');

model.modelNode.label('Components');

out = model;
