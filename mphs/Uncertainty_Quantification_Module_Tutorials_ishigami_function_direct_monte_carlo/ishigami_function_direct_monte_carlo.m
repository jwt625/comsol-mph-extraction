function out = model
%
% ishigami_function_direct_monte_carlo.m
%
% Model exported on May 26 2025, 21:34 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/Uncertainty_Quantification_Module/Tutorials');

model.study.create('std1');
model.study('std1').create('stat', 'Stationary');

model.param.set('X1', '1');
model.param.descr('X1', 'Random variable 1');
model.param.set('X2', '1');
model.param.descr('X2', 'Random variable 2');
model.param.set('X3', '1');
model.param.descr('X3', 'Random variable 3');
model.param.set('a', '7');
model.param.descr('a', 'Ishigami parameter 1');
model.param.set('b', '0.1');
model.param.descr('b', 'Ishigami parameter 2');
model.param.set('M', 'a/2');
model.param.descr('M', 'Mean');
model.param.set('V', '(a^2)/8+b*(pi^4)/5+b^2*(pi^8)/18+1/2');
model.param.descr('V', 'Variance');
model.param.set('STD', 'sqrt(V)');
model.param.descr('STD', 'Standard deviation');
model.param.set('par', '1');
model.param.descr('par', 'Sampling parameter');
model.param.set('imax', '8+(pi^4)/10');
model.param.descr('imax', 'Function max');
model.param.set('imin', '-1-(pi^4)/10');
model.param.descr('imin', 'Function min');

model.func.create('rn1', 'Random');
model.func('rn1').label('Random 1 (X1)');
model.func('rn1').set('uniformrange', '2*pi');
model.func('rn1').set('seedactive', true);
model.func.create('rn2', 'Random');
model.func('rn2').label('Random 2 (X2)');
model.func('rn2').set('uniformrange', '2*pi');
model.func('rn2').set('seedactive', true);
model.func.create('rn3', 'Random');
model.func('rn3').label('Random 3 (X3)');
model.func('rn3').set('uniformrange', '2*pi');
model.func('rn3').set('seedactive', true);
model.func.create('an1', 'Analytic');
model.func('an1').set('funcname', 'ishigami');
model.func('an1').set('expr', 'sin(x1)+a*(sin(x2))^2+b*x3^4*sin(x1)');
model.func('an1').set('args', 'x1,x2,x3');
model.func('an1').label('Ishigami Function');

model.study('std1').create('param', 'Parametric');
model.study('std1').feature('param').label('Parametric Sweep, Direct Monte Carlo');
model.study('std1').feature('param').setIndex('pname', 'X1', 0);
model.study('std1').feature('param').setIndex('plistarr', '', 0);
model.study('std1').feature('param').setIndex('punit', '', 0);
model.study('std1').feature('param').setIndex('pname', 'X1', 0);
model.study('std1').feature('param').setIndex('plistarr', '', 0);
model.study('std1').feature('param').setIndex('punit', '', 0);
model.study('std1').feature('param').setIndex('pname', 'par', 0);
model.study('std1').feature('param').setIndex('plistarr', 'range(1,1,10000)', 0);
model.study('std1').feature('param').setIndex('punit', '', 0);

model.sol.create('sol1');
model.sol('sol1').study('std1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'stat');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').set('control', 'stat');
model.sol('sol1').create('s1', 'Stationary');
model.sol('sol1').feature('s1').create('p1', 'Parametric');
model.sol('sol1').feature('s1').feature('p1').set('pname', {'par'});
model.sol('sol1').feature('s1').feature('p1').set('plistarr', {'range(1,1,10000)'});
model.sol('sol1').feature('s1').feature('p1').set('punit', {''});
model.sol('sol1').feature('s1').feature('p1').set('sweeptype', 'sparse');
model.sol('sol1').feature('s1').feature('p1').set('preusesol', 'no');
model.sol('sol1').feature('s1').feature('p1').set('pcontinuationmode', 'no');
model.sol('sol1').feature('s1').feature('p1').set('plot', 'off');
model.sol('sol1').feature('s1').feature('p1').set('plotgroup', 'Default');
model.sol('sol1').feature('s1').feature('p1').set('probesel', 'all');
model.sol('sol1').feature('s1').feature('p1').set('probes', {});
model.sol('sol1').feature('s1').feature('p1').set('control', 'param');
model.sol('sol1').feature('s1').set('control', 'stat');
model.sol('sol1').attach('std1');
model.sol('sol1').runAll;

model.result.evaluationGroup.create('eg1', 'EvaluationGroup');
model.result.evaluationGroup('eg1').create('gev1', 'EvalGlobal');
model.result.evaluationGroup('eg1').feature('gev1').setIndex('expr', 'ishigami(rn1(par),rn2(par),rn3(par))', 0);
model.result.evaluationGroup('eg1').feature('gev1').setIndex('unit', '', 0);
model.result.evaluationGroup('eg1').feature('gev1').setIndex('descr', 'Ishigami Function', 0);
model.result.evaluationGroup('eg1').run;
model.result.evaluationGroup('eg1').feature('gev1').label('Table, Direct Monte Carlo');
model.result.evaluationGroup.create('eg2', 'EvaluationGroup');
model.result.evaluationGroup('eg2').create('gev1', 'EvalGlobal');
model.result.evaluationGroup('eg2').feature('gev1').label('Mean, Direct Monte Carlo');
model.result.evaluationGroup('eg2').feature('gev1').setIndex('expr', 'ishigami(rn1(par),rn2(par),rn3(par))', 0);
model.result.evaluationGroup('eg2').feature('gev1').setIndex('unit', '', 0);
model.result.evaluationGroup('eg2').feature('gev1').setIndex('descr', 'Ishigami Function', 0);
model.result.evaluationGroup('eg2').feature('gev1').set('dataseries', 'average');
model.result.evaluationGroup('eg2').create('gev2', 'EvalGlobal');
model.result.evaluationGroup('eg2').feature('gev2').label('Standard Deviation, Direct Monte Carlo');
model.result.evaluationGroup('eg2').feature('gev2').setIndex('expr', 'ishigami(rn1(par),rn2(par),rn3(par))', 0);
model.result.evaluationGroup('eg2').feature('gev2').setIndex('unit', '', 0);
model.result.evaluationGroup('eg2').feature('gev2').setIndex('descr', 'Ishigami Function', 0);
model.result.evaluationGroup('eg2').feature('gev2').set('dataseries', 'stddev');
model.result.evaluationGroup('eg2').run;
model.result.dataset.create('kde1', 'KernelDensityEstimation');
model.result.dataset('kde1').set('source', 'evaluationgroup');
model.result.dataset('kde1').set('xaxisdata', 2);
model.result.create('pg1', 'PlotGroup1D');
model.result('pg1').run;
model.result('pg1').label('Histogram and KDE');
model.result('pg1').create('tlhs1', 'TableHistogram');
model.result('pg1').feature('tlhs1').set('markerpos', 'datapoints');
model.result('pg1').feature('tlhs1').set('linewidth', 'preference');
model.result('pg1').feature('tlhs1').set('source', 'evaluationgroup');
model.result('pg1').feature('tlhs1').set('xaxisdata', 2);
model.result('pg1').feature('tlhs1').set('number', 200);
model.result('pg1').feature('tlhs1').set('normalization', 'integralscaled');
model.result('pg1').run;
model.result('pg1').create('lngr1', 'LineGraph');
model.result('pg1').feature('lngr1').set('markerpos', 'datapoints');
model.result('pg1').feature('lngr1').set('linewidth', 'preference');
model.result('pg1').feature('lngr1').label('KDE');
model.result('pg1').feature('lngr1').set('expr', 'kde1val');
model.result('pg1').feature('lngr1').set('data', 'kde1');
model.result('pg1').run;

model.title('Direct Monte Carlo Simulation of the Ishigami Function');

model.description('This example demonstrates how to perform a direct Monte Carlo simulation of the Ishigami function. This random function of three variables is a well-known benchmark used to test global sensitivity analysis and uncertainty quantification algorithms. The mean, standard deviation, maximum, and minimum values of the Ishigami function can be calculated analytically for the input distributions used here.');

model.label('ishigami_function_direct_monte_carlo.mph');

model.modelNode.label('Components');

out = model;
