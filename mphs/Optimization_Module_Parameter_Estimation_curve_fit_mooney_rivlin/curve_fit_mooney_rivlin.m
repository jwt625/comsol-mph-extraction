function out = model
%
% curve_fit_mooney_rivlin.m
%
% Model exported on May 26 2025, 21:31 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/Optimization_Module/Parameter_Estimation');

model.modelNode.create('comp1', true);

model.param.set('lambda', '1');
model.param.descr('lambda', 'Stretch');
model.param.set('C10', '1[MPa]');
model.param.descr('C10', 'Mooney-Rivlin parameter');
model.param.set('C01', '1[MPa]');
model.param.descr('C01', 'Mooney-Rivlin parameter');

model.variable.create('var1');
model.variable('var1').set('P', '2*(C10+C01/lambda)*(lambda-1/lambda^2)');
model.variable('var1').descr('P', 'Engineering stress');

model.study.create('std1');
model.study('std1').create('stat', 'Stationary');
model.study('std1').create('lsqo', 'LSQOptimization');
model.study('std1').feature('lsqo').set('filename', 'curve_fit_mooney_rivlin.csv');
model.study('std1').feature('lsqo').setEntry('columnType', 'col1', 'param');
model.study('std1').feature('lsqo').setEntry('parameterName', 'col1', 'lambda');
model.study('std1').feature('lsqo').setEntry('parameterUnit', 'col1', '1');
model.study('std1').feature('lsqo').setEntry('modelExpression', 'col2', 'P');
model.study('std1').feature('lsqo').setEntry('variableName', 'col2', 'engStress');
model.study('std1').feature('lsqo').setEntry('unit', 'col2', 'Pa');
model.study('std1').feature('lsqo').setIndex('pname', 'lambda', 0);
model.study('std1').feature('lsqo').setIndex('initval', 1, 0);
model.study('std1').feature('lsqo').setIndex('scale', 1, 0);
model.study('std1').feature('lsqo').setIndex('lbound', '', 0);
model.study('std1').feature('lsqo').setIndex('ubound', '', 0);
model.study('std1').feature('lsqo').setIndex('pname', 'lambda', 0);
model.study('std1').feature('lsqo').setIndex('initval', 1, 0);
model.study('std1').feature('lsqo').setIndex('scale', 1, 0);
model.study('std1').feature('lsqo').setIndex('lbound', '', 0);
model.study('std1').feature('lsqo').setIndex('ubound', '', 0);
model.study('std1').feature('lsqo').setIndex('pname', 'C10', 1);
model.study('std1').feature('lsqo').setIndex('initval', '1[MPa]', 1);
model.study('std1').feature('lsqo').setIndex('scale', 1, 1);
model.study('std1').feature('lsqo').setIndex('lbound', '', 1);
model.study('std1').feature('lsqo').setIndex('ubound', '', 1);
model.study('std1').feature('lsqo').setIndex('pname', 'C10', 1);
model.study('std1').feature('lsqo').setIndex('initval', '1[MPa]', 1);
model.study('std1').feature('lsqo').setIndex('scale', 1, 1);
model.study('std1').feature('lsqo').setIndex('lbound', '', 1);
model.study('std1').feature('lsqo').setIndex('ubound', '', 1);
model.study('std1').feature('lsqo').setIndex('pname', 'C01', 0);
model.study('std1').feature('lsqo').setIndex('initval', '1[MPa]', 0);
model.study('std1').feature('lsqo').setIndex('scale', '1[MPa]', 0);
model.study('std1').feature('lsqo').setIndex('pname', 'C10', 1);
model.study('std1').feature('lsqo').setIndex('initval', '1[MPa]', 1);
model.study('std1').feature('lsqo').setIndex('scale', '1[MPa]', 1);
model.study('std1').feature('lsqo').set('optsolver', 'lm');
model.study('std1').feature('lsqo').set('lsqdatamethod', 'lsq');

model.sol.create('sol1');
model.sol('sol1').study('std1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'stat');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').set('control', 'stat');
model.sol('sol1').create('o1', 'Optimization');
model.sol('sol1').feature('o1').set('control', 'lsqo');
model.sol('sol1').feature('o1').create('s1', 'StationaryAttrib');
model.sol('sol1').feature('o1').feature('s1').set('control', 'stat');
model.sol('sol1').feature('o1').feature('s1').create('p1', 'Parametric');
model.sol('sol1').feature('o1').feature('s1').feature.remove('pDef');
model.sol('sol1').feature('o1').feature('s1').feature('p1').set('control', 'stat');
model.sol('sol1').feature('o1').feature('s1').set('control', 'stat');
model.sol('sol1').feature('o1').feature('s1').feature('p1').set('plistarrlsq', {'1.0, 1.075, 1.103, 1.15, 1.174, 1.2004, 1.25, 1.305, 1.351, 1.37'});
model.sol('sol1').feature('o1').feature('s1').feature('p1').set('lsqparamsout', ['    lambda' newline '      1.00' newline '      1.08' newline '      1.10' newline '      1.15' newline '      1.17' newline '      1.20' newline '      1.25' newline '      1.31' newline '      1.35' newline '      1.37' newline ]);
model.sol('sol1').feature('o1').feature('s1').feature('p1').set('pnamelsq', {'lambda'});
model.sol('sol1').feature('v1').set('cname', {});
model.sol('sol1').feature('v1').set('clist', {});
model.sol('sol1').feature('v1').set('clistctrl', {});
model.sol('sol1').feature('v1').set('cname', {'lambda'});
model.sol('sol1').feature('v1').set('clist', {'1.0, 1.075, 1.103, 1.15, 1.174, 1.2004, 1.25, 1.305, 1.351, 1.37'});
model.sol('sol1').feature('v1').set('clistctrl', {'p1lsq'});
model.sol('sol1').feature('o1').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('o1').feature('s1').feature.remove('fcDef');
model.sol('sol1').attach('std1');
model.sol('sol1').runAll;

model.study('std1').feature('lsqo').set('probewindow', '');

model.result.create('pg1', 'PlotGroup1D');
model.result('pg1').run;
model.result('pg1').create('glob1', 'Global');
model.result('pg1').feature('glob1').set('markerpos', 'datapoints');
model.result('pg1').feature('glob1').set('linewidth', 'preference');
model.result('pg1').feature('glob1').set('expr', {'P'});
model.result('pg1').feature('glob1').set('descr', {'Engineering stress'});
model.result('pg1').feature('glob1').set('unit', {'Pa'});
model.result('pg1').feature('glob1').setIndex('expr', 'P*lambda', 1);
model.result('pg1').feature('glob1').setIndex('unit', 'Pa', 1);
model.result('pg1').feature('glob1').setIndex('descr', 'True (Cauchy) stress', 1);
model.result('pg1').feature('glob1').setIndex('expr', 'P/lambda', 2);
model.result('pg1').feature('glob1').setIndex('unit', 'Pa', 2);
model.result('pg1').feature('glob1').setIndex('descr', '2nd Piola-Kirchhoff stress', 2);
model.result('pg1').run;
model.result('pg1').create('glob2', 'Global');
model.result('pg1').feature('glob2').set('markerpos', 'datapoints');
model.result('pg1').feature('glob2').set('linewidth', 'preference');
model.result('pg1').feature('glob2').set('expr', {'opt.glsobj.engStress.data'});
model.result('pg1').feature('glob2').set('descr', {'Least-squares experimental value'});
model.result('pg1').feature('glob2').set('linestyle', 'none');
model.result('pg1').feature('glob2').set('linemarker', 'circle');
model.result('pg1').run;
model.result('pg1').run;
model.result('pg1').set('titletype', 'none');
model.result('pg1').set('xlabelactive', true);
model.result('pg1').set('xlabel', 'Stretch');
model.result('pg1').set('ylabelactive', true);
model.result('pg1').set('ylabel', 'Stress');
model.result('pg1').set('legendpos', 'upperleft');
model.result.evaluationGroup.create('eg1', 'EvaluationGroup');
model.result('pg1').run;
model.result.evaluationGroup('eg1').create('gev1', 'EvalGlobal');
model.result.evaluationGroup('eg1').setIndex('looplevelinput', 'last', 0);
model.result.evaluationGroup('eg1').feature('gev1').set('expr', {'C10'});
model.result.evaluationGroup('eg1').feature('gev1').set('descr', {'Mooney-Rivlin parameter'});
model.result.evaluationGroup('eg1').feature('gev1').set('expr', {'C10' 'C01'});
model.result.evaluationGroup('eg1').feature('gev1').set('descr', {'Mooney-Rivlin parameter' 'Mooney-Rivlin parameter'});
model.result.evaluationGroup('eg1').run;
model.result('pg1').run;

model.title(['Mooney' native2unicode(hex2dec({'20' '13'}), 'unicode') 'Rivlin Curve Fit']);

model.description('This example shows how to use the Optimization Module to fit a material model curve to experimental data.');

model.label('curve_fit_mooney_rivlin.mph');

model.modelNode.label('Components');

out = model;
