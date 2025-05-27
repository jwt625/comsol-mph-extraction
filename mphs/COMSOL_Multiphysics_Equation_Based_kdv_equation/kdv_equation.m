function out = model
%
% kdv_equation.m
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

model.physics.create('g', 'GeneralFormPDE', 'geom1', {'u1' 'u2'});
model.physics('g').prop('EquationForm').set('form', 'Automatic');

model.study.create('std1');
model.study('std1').create('time', 'Transient');
model.study('std1').feature('time').setSolveFor('/physics/g', true);

model.baseSystem('none');

model.geom('geom1').create('i1', 'Interval');
model.geom('geom1').feature('i1').setIndex('coord', -8, 0);
model.geom('geom1').feature('i1').setIndex('coord', 8, 1);
model.geom('geom1').run;

model.physics('g').create('pc1', 'PeriodicCondition', 0);
model.physics('g').feature('pc1').selection.all;
model.physics('g').feature('gfeq1').setIndex('Ga', 'u2', 0);
model.physics('g').feature('gfeq1').setIndex('Ga', 'u1x', 1);
model.physics('g').feature('gfeq1').setIndex('f', '6*u1*u1x', 0);
model.physics('g').feature('gfeq1').setIndex('f', 'u2', 1);
model.physics('g').feature('gfeq1').setIndex('da', 0, 3);
model.physics('g').feature('init1').set('u1', '-6*sech(x)^2');
model.physics('g').feature('init1').set('u2', '-24*sech(x)^2*tanh(x)^2+12*sech(x)^2*(1-tanh(x)^2)');

model.mesh('mesh1').create('edg1', 'Edge');
model.mesh('mesh1').feature('size').set('custom', true);
model.mesh('mesh1').feature('size').set('hmax', 0.1);
model.mesh('mesh1').run;

model.study('std1').feature('time').set('tlist', 'range(0,0.0025,2)');
model.study('std1').feature('time').set('usertol', true);
model.study('std1').feature('time').set('rtol', '3e-6');

model.sol.create('sol1');
model.sol('sol1').study('std1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'time');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').set('control', 'time');
model.sol('sol1').create('t1', 'Time');
model.sol('sol1').feature('t1').set('tlist', 'range(0,0.0025,2)');
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
model.sol('sol1').feature('t1').set('timemethod', 'genalpha');
model.sol('sol1').feature('t1').set('atolglobalvaluemethod', 'manual');
model.sol('sol1').feature('t1').set('atolglobal', '3e-7');
model.sol('sol1').feature('t1').set('rhoinf', 0.98);
model.sol('sol1').feature('t1').feature('fc1').set('ntolfact', 0.1);
model.sol('sol1').runAll;

model.result.create('pg1', 'PlotGroup1D');
model.result('pg1').set('data', 'dset1');
model.result('pg1').create('lngr1', 'LineGraph');
model.result('pg1').feature('lngr1').set('xdata', 'expr');
model.result('pg1').feature('lngr1').set('xdataexpr', 'x');
model.result('pg1').feature('lngr1').selection.geom('geom1', 1);
model.result('pg1').feature('lngr1').selection.set([1]);
model.result('pg1').feature('lngr1').set('expr', 'u1');
model.result('pg1').label('General Form PDE');
model.result('pg1').run;
model.result('pg1').setIndex('looplevelinput', 'manual', 0);
model.result('pg1').setIndex('looplevel', [11], 0);
model.result('pg1').run;
model.result('pg1').feature('lngr1').set('expr', '-u1');
model.result('pg1').run;
model.result.dataset.create('par1', 'Parametric1D');
model.result.create('pg2', 'PlotGroup2D');
model.result('pg2').run;
model.result('pg2').create('surf1', 'Surface');
model.result('pg2').feature('surf1').set('expr', '-u1');
model.result('pg2').feature('surf1').create('hght1', 'Height');
model.result('pg2').run;

model.title('The KdV Equation and Solitons');

model.description(['This example solves the Korteweg' native2unicode(hex2dec({'20' '13'}), 'unicode') 'de Vries (KdV) equation with a two-soliton solution as initial value. The solitons propagate with different speeds, and the faster soliton merges with and separates from the slower soliton several times.']);

model.mesh.clearMeshes;

model.sol('sol1').clearSolutionData;

model.label('kdv_equation.mph');

model.modelNode.label('Components');

out = model;
