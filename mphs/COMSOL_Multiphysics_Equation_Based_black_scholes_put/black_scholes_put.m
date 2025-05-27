function out = model
%
% black_scholes_put.m
%
% Model exported on May 26 2025, 21:26 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/COMSOL_Multiphysics/Equation_Based');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 1);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.physics.create('c', 'CoefficientFormPDE', 'geom1', {'u'});
model.physics('c').prop('EquationForm').set('form', 'Automatic');

model.study.create('std1');
model.study('std1').create('time', 'Transient');
model.study('std1').feature('time').setSolveFor('/physics/c', true);

model.baseSystem('none');

model.geom('geom1').create('i1', 'Interval');
model.geom('geom1').feature('i1').setIndex('coord', 80, 1);
model.geom('geom1').run('i1');

model.param.set('r', '0.12');
model.param.descr('r', 'Continuous compounding interest rate');
model.param.set('sigma', '0.3');
model.param.descr('sigma', 'Volatility');

model.geom('geom1').run;

model.physics('c').feature('cfeq1').setIndex('c', '1/2*sigma^2*x^2', 0);
model.physics('c').feature('cfeq1').setIndex('a', 'r', 0);
model.physics('c').feature('cfeq1').setIndex('f', 0, 0);
model.physics('c').feature('cfeq1').setIndex('da', -1, 0);
model.physics('c').feature('cfeq1').setIndex('be', '(-r+sigma^2)*x', 0);
model.physics('c').feature('init1').set('u', '(x<40)*(40-x)');
model.physics('c').create('flux1', 'FluxBoundary', 0);
model.physics('c').feature('flux1').selection.set([1]);
model.physics('c').create('dir1', 'DirichletBoundary', 0);
model.physics('c').feature('dir1').selection.set([2]);

model.mesh('mesh1').create('edg1', 'Edge');
model.mesh('mesh1').feature('size').set('custom', true);
model.mesh('mesh1').feature('size').set('hmax', 2);
model.mesh('mesh1').run;

model.study('std1').feature('time').set('tlist', 'range(12,-0.5,0)');

model.sol.create('sol1');
model.sol('sol1').study('std1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'time');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').set('control', 'time');
model.sol('sol1').create('t1', 'Time');
model.sol('sol1').feature('t1').set('tlist', 'range(12,-0.5,0)');
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
model.sol('sol1').runAll;

model.result.create('pg1', 'PlotGroup1D');
model.result('pg1').set('data', 'dset1');
model.result('pg1').create('lngr1', 'LineGraph');
model.result('pg1').feature('lngr1').set('xdata', 'expr');
model.result('pg1').feature('lngr1').set('xdataexpr', 'x');
model.result('pg1').feature('lngr1').selection.geom('geom1', 1);
model.result('pg1').feature('lngr1').selection.set([1]);
model.result('pg1').feature('lngr1').set('expr', 'u');
model.result('pg1').label('Coefficient Form PDE');
model.result('pg1').run;
model.result('pg1').run;
model.result('pg1').setIndex('looplevelinput', 'manual', 0);
model.result('pg1').setIndex('looplevel', [25], 0);
model.result('pg1').set('xlabelactive', true);
model.result('pg1').set('xlabel', 'x');
model.result('pg1').set('ylabelactive', true);
model.result('pg1').set('ylabel', 'u');
model.result('pg1').run;
model.result('pg1').feature('lngr1').set('xdataexpr', 'x');
model.result('pg1').feature('lngr1').set('xdatadescr', 'x-coordinate');
model.result('pg1').feature('lngr1').set('legend', true);
model.result('pg1').feature('lngr1').set('legendprefix', 'Time = ');
model.result('pg1').run;

model.title(['The Black' native2unicode(hex2dec({'20' '13'}), 'unicode') 'Scholes Equation']);

model.description(['The solution to the Black' native2unicode(hex2dec({'20' '13'}), 'unicode') 'Scholes equation for the value of a European put option. Black and Scholes developed an analytical expression for the solution.']);

model.label('black_scholes_put.mph');

model.modelNode.label('Components');

out = model;
