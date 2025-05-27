function out = model
%
% heat_conduction_in_slab.m
%
% Model exported on May 26 2025, 21:29 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/Heat_Transfer_Module/Tutorials,_Conduction');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 1);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.physics.create('ht', 'HeatTransfer', 'geom1');
model.physics('ht').model('comp1');

model.study.create('std1');
model.study('std1').create('time', 'Transient');
model.study('std1').feature('time').setSolveFor('/physics/ht', true);

model.modelNode('comp1').baseSystem('none');

model.geom('geom1').create('i1', 'Interval');
model.geom('geom1').feature('i1').setIndex('coord', -1, 0);
model.geom('geom1').runPre('fin');

model.func.create('step1', 'Step');
model.func('step1').model('comp1');
model.func('step1').set('location', '1e-6');
model.func('step1').set('from', 1);
model.func('step1').set('to', 0);
model.func('step1').set('smooth', '2e-6');

model.cpl.create('intop1', 'Integration', 'geom1');

model.geom('geom1').run;

model.cpl('intop1').set('axisym', true);
model.cpl('intop1').selection.all;

model.physics('ht').feature('solid1').set('k_mat', 'userdef');
model.physics('ht').feature('solid1').set('k', [1 0 0 0 1 0 0 0 1]);
model.physics('ht').feature('solid1').set('rho_mat', 'userdef');
model.physics('ht').feature('solid1').set('rho', 1);
model.physics('ht').feature('solid1').set('Cp_mat', 'userdef');
model.physics('ht').feature('solid1').set('Cp', 1);
model.physics('ht').feature('init1').set('Tinit', 1);
model.physics('ht').create('temp1', 'TemperatureBoundary', 0);
model.physics('ht').feature('temp1').selection.set([1 2]);
model.physics('ht').feature('temp1').set('T0', 'step1(t)');

model.mesh('mesh1').automatic(false);
model.mesh('mesh1').feature('size').set('hauto', 3);
model.mesh('mesh1').feature('edg1').create('size1', 'Size');
model.mesh('mesh1').feature('edg1').feature('size1').selection.geom('geom1', 0);
model.mesh('mesh1').feature('edg1').feature('size1').selection.all;
model.mesh('mesh1').feature('edg1').feature('size1').set('custom', true);
model.mesh('mesh1').feature('edg1').feature('size1').set('hmaxactive', true);
model.mesh('mesh1').feature('edg1').feature('size1').set('hmax', '1e-4');
model.mesh('mesh1').run;

model.study('std1').feature('time').set('tlist', 'range(0,0.01,1)');

model.sol.create('sol1');
model.sol('sol1').study('std1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'time');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').set('control', 'time');
model.sol('sol1').create('t1', 'Time');
model.sol('sol1').feature('t1').set('tlist', 'range(0,0.01,1)');
model.sol('sol1').feature('t1').set('plot', 'off');
model.sol('sol1').feature('t1').set('plotgroup', 'Default');
model.sol('sol1').feature('t1').set('plotfreq', 'tout');
model.sol('sol1').feature('t1').set('probesel', 'all');
model.sol('sol1').feature('t1').set('probes', {});
model.sol('sol1').feature('t1').set('probefreq', 'tsteps');
model.sol('sol1').feature('t1').set('atolglobalvaluemethod', 'factor');
model.sol('sol1').feature('t1').set('atolmethod', {'comp1_T' 'global'});
model.sol('sol1').feature('t1').set('atol', {'comp1_T' '1e-3'});
model.sol('sol1').feature('t1').set('atolvaluemethod', {'comp1_T' 'factor'});
model.sol('sol1').feature('t1').set('reacf', true);
model.sol('sol1').feature('t1').set('storeudot', true);
model.sol('sol1').feature('t1').set('endtimeinterpolation', true);
model.sol('sol1').feature('t1').set('estrat', 'exclude');
model.sol('sol1').feature('t1').set('maxorder', 2);
model.sol('sol1').feature('t1').set('control', 'time');
model.sol('sol1').feature('t1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('t1').feature('fc1').set('jtech', 'once');
model.sol('sol1').feature('t1').feature('fc1').set('damp', 0.9);
model.sol('sol1').feature('t1').feature('fc1').set('stabacc', 'aacc');
model.sol('sol1').feature('t1').feature('fc1').set('aaccdim', 5);
model.sol('sol1').feature('t1').feature('fc1').set('aaccmix', 0.9);
model.sol('sol1').feature('t1').feature('fc1').set('aaccdelay', 1);
model.sol('sol1').feature('t1').create('d1', 'Direct');
model.sol('sol1').feature('t1').feature('d1').set('linsolver', 'pardiso');
model.sol('sol1').feature('t1').feature('d1').set('pivotperturb', 1.0E-13);
model.sol('sol1').feature('t1').feature('d1').label('Direct, heat transfer variables (ht)');
model.sol('sol1').feature('t1').create('i1', 'Iterative');
model.sol('sol1').feature('t1').feature('i1').set('linsolver', 'gmres');
model.sol('sol1').feature('t1').feature('i1').set('prefuntype', 'left');
model.sol('sol1').feature('t1').feature('i1').set('itrestart', 50);
model.sol('sol1').feature('t1').feature('i1').set('rhob', 20);
model.sol('sol1').feature('t1').feature('i1').set('maxlinit', 10000);
model.sol('sol1').feature('t1').feature('i1').set('nlinnormuse', 'on');
model.sol('sol1').feature('t1').feature('i1').label('AMG, heat transfer variables (ht)');
model.sol('sol1').feature('t1').feature('i1').create('mg1', 'Multigrid');
model.sol('sol1').feature('t1').feature('i1').feature('mg1').set('prefun', 'saamg');
model.sol('sol1').feature('t1').feature('i1').feature('mg1').set('mgcycle', 'v');
model.sol('sol1').feature('t1').feature('i1').feature('mg1').set('maxcoarsedof', 50000);
model.sol('sol1').feature('t1').feature('i1').feature('mg1').set('strconn', 0.01);
model.sol('sol1').feature('t1').feature('i1').feature('mg1').set('nullspace', 'constant');
model.sol('sol1').feature('t1').feature('i1').feature('mg1').set('usesmooth', false);
model.sol('sol1').feature('t1').feature('i1').feature('mg1').set('saamgcompwise', true);
model.sol('sol1').feature('t1').feature('i1').feature('mg1').set('loweramg', true);
model.sol('sol1').feature('t1').feature('i1').feature('mg1').set('compactaggregation', false);
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('pr').create('so1', 'SOR');
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('pr').feature('so1').set('iter', 2);
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('pr').feature('so1').set('relax', 0.9);
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('po').create('so1', 'SOR');
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('po').feature('so1').set('iter', 2);
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('po').feature('so1').set('relax', 0.9);
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('cs').create('d1', 'Direct');
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('cs').feature('d1').set('linsolver', 'pardiso');
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('cs').feature('d1').set('pivotperturb', 1.0E-13);
model.sol('sol1').feature('t1').feature('fc1').set('linsolver', 'd1');
model.sol('sol1').feature('t1').feature('fc1').set('jtech', 'once');
model.sol('sol1').feature('t1').feature('fc1').set('damp', 0.9);
model.sol('sol1').feature('t1').feature('fc1').set('stabacc', 'aacc');
model.sol('sol1').feature('t1').feature('fc1').set('aaccdim', 5);
model.sol('sol1').feature('t1').feature('fc1').set('aaccmix', 0.9);
model.sol('sol1').feature('t1').feature('fc1').set('aaccdelay', 1);
model.sol('sol1').feature('t1').feature.remove('fcDef');
model.sol('sol1').attach('std1');
model.sol('sol1').feature('t1').set('initialstepbdfactive', true);
model.sol('sol1').feature('t1').set('initialstepbdf', '2e-7');
model.sol('sol1').feature('t1').set('maxstepconstraintbdf', 'const');
model.sol('sol1').feature('t1').set('maxstepbdf', '1e-3');
model.sol('sol1').runAll;

model.result.create('pg1', 'PlotGroup1D');
model.result('pg1').label('Temperature (ht)');
model.result('pg1').set('showlooplevelinput', {'off' 'off' 'off'});
model.result('pg1').set('data', 'dset1');
model.result('pg1').set('defaultPlotID', 'ht/HT_PhysicsInterfaces/icom8/pdef1/pcond1/pg1');
model.result('pg1').feature.create('lngr1', 'LineGraph');
model.result('pg1').feature('lngr1').set('xdata', 'expr');
model.result('pg1').feature('lngr1').set('xdataexpr', 'x');
model.result('pg1').feature('lngr1').set('data', 'parent');
model.result('pg1').feature('lngr1').selection.geom('geom1', 1);
model.result('pg1').feature('lngr1').selection.set([1]);
model.result('pg1').run;
model.result('pg1').setIndex('looplevelinput', 'manual', 0);
model.result('pg1').setIndex('looplevel', [2 5 11 21 41 61], 0);
model.result('pg1').run;
model.result('pg1').run;
model.result('pg1').feature('lngr1').set('linemarker', 'cycle');
model.result('pg1').feature('lngr1').set('legend', true);
model.result('pg1').feature('lngr1').set('legendmethod', 'manual');
model.result('pg1').feature('lngr1').setIndex('legends', '\tau=0.01', 0);
model.result('pg1').feature('lngr1').setIndex('legends', '\tau=0.04', 1);
model.result('pg1').feature('lngr1').setIndex('legends', '\tau=0.1', 2);
model.result('pg1').feature('lngr1').setIndex('legends', '\tau=0.2', 3);
model.result('pg1').feature('lngr1').setIndex('legends', '\tau=0.4', 4);
model.result('pg1').feature('lngr1').setIndex('legends', '\tau=0.6', 5);
model.result('pg1').run;
model.result.create('pg2', 'PlotGroup1D');
model.result('pg2').run;
model.result('pg2').label('Relative L2 Error');
model.result('pg2').create('lngr1', 'LineGraph');
model.result('pg2').feature('lngr1').set('markerpos', 'datapoints');
model.result('pg2').feature('lngr1').set('linewidth', 'preference');
model.result('pg2').feature('lngr1').selection.all;
model.result('pg2').feature('lngr1').set('expr', 'sqrt(intop1((T-2*sum((-1)^n/((n+0.5)*pi)*exp(-(n+0.5)^2*pi^2*t)*cos((n+0.5)*pi*x),n,0,1000))^2))/sqrt(intop1(T^2))');
model.result('pg2').feature('lngr1').set('descractive', true);
model.result('pg2').feature('lngr1').set('descr', 'L2 error from analytical solution');
model.result('pg2').feature('lngr1').set('xdata', 'expr');
model.result('pg2').feature('lngr1').set('xdataexpr', 't');
model.result('pg2').feature('lngr1').set('linecolor', 'fromtheme');
model.result('pg2').run;
model.result('pg2').run;
model.result('pg2').set('axislimits', true);
model.result('pg2').set('xmin', '1e-3');
model.result('pg2').set('xmax', 1);
model.result('pg2').set('ymin', 0);
model.result('pg2').set('ymax', '5e-4');
model.result('pg2').run;

model.title('Heat Conduction in a Finite Slab');

model.description('This example computes the temperature distribution along a slab after a sudden decrease of temperature at the slab boundaries.');

model.label('heat_conduction_in_slab.mph');

model.modelNode.label('Components');

out = model;
