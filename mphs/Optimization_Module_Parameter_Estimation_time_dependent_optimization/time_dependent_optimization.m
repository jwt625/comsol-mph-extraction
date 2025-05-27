function out = model
%
% time_dependent_optimization.m
%
% Model exported on May 26 2025, 21:31 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/Optimization_Module/Parameter_Estimation');

model.modelNode.create('comp1', true);

model.physics.create('ge', 'GlobalEquations');
model.physics('ge').model('comp1');
model.physics('ge').prop('EquationForm').set('form', 'Automatic');

model.study.create('std1');
model.study('std1').create('time', 'Transient');
model.study('std1').feature('time').setSolveFor('/physics/ge', true);

model.param.set('a', '0.25');
model.param.descr('a', 'ODE constant 1');
model.param.set('b', '0.05');
model.param.descr('b', 'ODE constant 2');
model.param.set('c', '0.015');
model.param.descr('c', 'ODE constant 3');
model.param.set('u0', '0.25');
model.param.descr('u0', 'Initial value');
model.param.set('f', '1[Hz]');
model.param.descr('f', 'Frequency');
model.param.set('w', '2*pi*f');
model.param.descr('w', 'Angular frequency');

model.physics('ge').feature('ge1').setIndex('name', 'u', 0, 0);
model.physics('ge').feature('ge1').setIndex('equation', '((1/f)*ut-a*sin(w*t)^2+b*u+c*u^2)', 0, 0);
model.physics('ge').feature('ge1').setIndex('initialValueU', 'u0', 0, 0);

model.study('std1').feature('time').set('usertol', true);
model.study('std1').feature('time').set('rtol', '1e-5');
model.study('std1').feature('time').set('tlist', 'range(0,0.01,100)');

model.sol.create('sol1');
model.sol('sol1').study('std1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'time');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').set('control', 'time');
model.sol('sol1').create('t1', 'Time');
model.sol('sol1').feature('t1').set('tlist', 'range(0,0.01,100)');
model.sol('sol1').feature('t1').set('plot', 'off');
model.sol('sol1').feature('t1').set('plotgroup', 'Default');
model.sol('sol1').feature('t1').set('plotfreq', 'tout');
model.sol('sol1').feature('t1').set('probesel', 'all');
model.sol('sol1').feature('t1').set('probes', {});
model.sol('sol1').feature('t1').set('probefreq', 'tsteps');
model.sol('sol1').feature('t1').set('atolglobalvaluemethod', 'factor');
model.sol('sol1').feature('t1').set('endtimeinterpolation', true);
model.sol('sol1').feature('t1').set('control', 'time');
model.sol('sol1').feature('t1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('t1').feature('fc1').set('linsolver', 'dDef');
model.sol('sol1').feature('t1').feature.remove('fcDef');
model.sol('sol1').attach('std1');
model.sol('sol1').feature('t1').set('atolglobalvaluemethod', 'manual');
model.sol('sol1').feature('t1').set('atolglobal', '0.0001');
model.sol('sol1').runAll;

model.result.numerical.create('gev1', 'EvalGlobal');
model.result.numerical('gev1').set('data', 'dset1');
model.result.numerical('gev1').set('expr', {'u'});
model.result.numerical('gev1').set('descr', {'State variable u'});
model.result.create('pg1', 'PlotGroup1D');
model.result('pg1').set('data', 'dset1');
model.result('pg1').create('glob1', 'Global');
model.result('pg1').feature('glob1').set('expr', {'u'});
model.result('pg1').feature('glob1').set('descr', {'State variable u'});
model.result('pg1').run;
model.result('pg1').set('legendpos', 'lowerright');
model.result('pg1').run;
model.result.duplicate('pg2', 'pg1');
model.result('pg2').run;
model.result('pg2').set('axislimits', true);
model.result('pg2').set('xmin', 90);
model.result('pg2').set('ymin', 1.6);
model.result('pg2').set('ymax', 1.7);
model.result('pg2').run;

model.study.create('std2');
model.study('std2').create('time', 'Transient');
model.study('std2').feature('time').setSolveFor('/physics/ge', true);
model.study('std2').feature('time').set('tlist', 'range(0,0.002,1)');
model.study('std2').feature('time').set('usertol', true);
model.study('std2').feature('time').set('rtol', '1e-5');
model.study('std2').create('opt', 'Optimization');
model.study('std2').feature('opt').set('optsolver', 'ipopt');
model.study('std2').feature('opt').setIndex('optobj', '(comp1.u-u0)^2', 0);
model.study('std2').feature('opt').setIndex('descr', 'Squared error', 0);
model.study('std2').feature('opt').setIndex('pname', 'a', 0);
model.study('std2').feature('opt').setIndex('initval', 0.25, 0);
model.study('std2').feature('opt').setIndex('scale', 1, 0);
model.study('std2').feature('opt').setIndex('lbound', '', 0);
model.study('std2').feature('opt').setIndex('ubound', '', 0);
model.study('std2').feature('opt').setIndex('pname', 'a', 0);
model.study('std2').feature('opt').setIndex('initval', 0.25, 0);
model.study('std2').feature('opt').setIndex('scale', 1, 0);
model.study('std2').feature('opt').setIndex('lbound', '', 0);
model.study('std2').feature('opt').setIndex('ubound', '', 0);
model.study('std2').feature('opt').setIndex('pname', 'u0', 0);
model.study('std2').feature('opt').setIndex('initval', 0.25, 0);
model.study('std2').feature('opt').setIndex('lbound', 0, 0);
model.study('std2').feature('opt').setIndex('ubound', 5, 0);

model.sol.create('sol2');
model.sol('sol2').study('std2');
model.sol('sol2').create('st1', 'StudyStep');
model.sol('sol2').feature('st1').set('study', 'std2');
model.sol('sol2').feature('st1').set('studystep', 'time');
model.sol('sol2').create('v1', 'Variables');
model.sol('sol2').feature('v1').set('control', 'time');
model.sol('sol2').create('o1', 'Optimization');
model.sol('sol2').feature('o1').set('control', 'opt');
model.sol('sol2').feature('o1').create('t1', 'TimeAttrib');
model.sol('sol2').feature('o1').feature('t1').set('atolglobalvaluemethod', 'factor');
model.sol('sol2').feature('o1').feature('t1').set('endtimeinterpolation', true);
model.sol('sol2').feature('o1').feature('t1').set('control', 'time');
model.sol('sol2').feature('o1').feature('t1').create('fc1', 'FullyCoupled');
model.sol('sol2').feature('o1').feature('t1').feature('fc1').set('linsolver', 'dDef');
model.sol('sol2').feature('o1').feature('t1').feature.remove('fcDef');
model.sol('sol2').attach('std2');
model.sol('sol2').feature('o1').feature('t1').set('atolglobalvaluemethod', 'manual');
model.sol('sol2').feature('o1').feature('t1').set('atolglobal', '1e-5');
model.sol('sol2').runAll;

model.result.numerical.create('gev2', 'EvalGlobal');
model.result.numerical('gev2').set('data', 'dset2');
model.result.numerical('gev2').set('expr', {'u'});
model.result.numerical('gev2').set('descr', {'State variable u'});
model.result.create('pg3', 'PlotGroup1D');
model.result('pg3').set('data', 'dset2');
model.result('pg3').create('glob1', 'Global');
model.result('pg3').feature('glob1').set('expr', {'u'});
model.result('pg3').feature('glob1').set('descr', {'State variable u'});
model.result('pg3').run;

model.study('std2').feature('opt').set('probewindow', '');

model.title('Time-Dependent Optimization');

model.description('This tutorial demonstrates how to compute the periodic steady-state solution of a nonlinear problem using the time-dependent optimization solver. The model solves much faster using the time-dependent optimization solver because the solution does not have to be computed for a large number of periods.');

model.label('time_dependent_optimization.mph');

model.modelNode.label('Components');

out = model;
