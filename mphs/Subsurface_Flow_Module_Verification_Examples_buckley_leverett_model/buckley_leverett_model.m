function out = model
%
% buckley_leverett_model.m
%
% Model exported on May 26 2025, 21:34 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/Subsurface_Flow_Module/Verification_Examples');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 1);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.physics.create('phtr', 'PhaseTransportPorousMedia', 'geom1', {'s1' 's2'});
model.physics.create('dl', 'PorousMediaFlowDarcy', 'geom1');
model.physics('dl').model('comp1');

model.multiphysics.create('mfpm1', 'MultiphaseFlowInPorousMedia', 'geom1', 1);
model.multiphysics('mfpm1').set('multiphaseflow_physics', 'phtr');
model.multiphysics('mfpm1').set('darcyc_physics', 'dl');
model.multiphysics('mfpm1').selection.all;

model.study.create('std1');
model.study('std1').create('time', 'Transient');
model.study('std1').feature('time').setSolveFor('/physics/phtr', true);
model.study('std1').feature('time').setSolveFor('/physics/dl', true);
model.study('std1').feature('time').setSolveFor('/multiphysics/mfpm1', true);

model.geom('geom1').create('i1', 'Interval');
model.geom('geom1').runPre('fin');

model.func.create('pw1', 'Piecewise');
model.func('pw1').model('comp1');
model.func('pw1').setIndex('pieces', 0.7071, 0, 0);
model.func('pw1').setIndex('pieces', 1, 0, 1);
model.func('pw1').setIndex('pieces', 'd(x^2/(x^2+(1-x)^2),x)', 0, 2);

model.geom('geom1').run;

model.physics('phtr').feature('pptp1').set('rhoint_s1_mat', 'userdef');
model.physics('phtr').feature('pptp1').set('mu_s1_mat', 'userdef');
model.physics('phtr').feature('pptp1').set('rhoint_s2_mat', 'userdef');
model.physics('phtr').feature('pptp1').set('mu_s2_mat', 'userdef');
model.physics('phtr').create('sa1', 'VolumeFraction', 0);
model.physics('phtr').feature('sa1').selection.set([1]);
model.physics('phtr').feature('sa1').setIndex('phases', true, 1);
model.physics('phtr').feature('sa1').setIndex('s0', 1, 1);
model.physics('phtr').create('of1', 'Outflow', 0);
model.physics('phtr').feature('of1').selection.set([2]);
model.physics('dl').feature('porous1').feature('pm1').set('epsilon_mat', 'userdef');
model.physics('dl').feature('porous1').feature('pm1').set('epsilon', 0.5);
model.physics('dl').feature('porous1').feature('pm1').set('kappa_mat', 'userdef');
model.physics('dl').feature('porous1').feature('pm1').set('kappa', {'1e-9[m^2]' '0' '0' '0' '1e-9[m^2]' '0' '0' '0' '1e-9[m^2]'});
model.physics('dl').create('inl1', 'Inlet', 0);
model.physics('dl').feature('inl1').selection.set([1]);
model.physics('dl').feature('inl1').set('U0in', 0.001);
model.physics('dl').create('pr1', 'Pressure', 0);
model.physics('dl').feature('pr1').selection.set([2]);

model.mesh('mesh1').create('edg1', 'Edge');
model.mesh('mesh1').feature('edg1').create('dis1', 'Distribution');
model.mesh('mesh1').feature('edg1').feature('dis1').set('numelem', 400);

model.study('std1').feature('time').set('tlist', 'range(0,20,300)');

model.sol.create('sol1');

model.mesh('mesh1').stat.selection.geom(1);
model.mesh('mesh1').stat.selection.set([1]);
model.mesh('mesh1').stat.selection.geom(1);
model.mesh('mesh1').stat.selection.set([1]);

model.sol('sol1').study('std1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'time');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').feature('comp1_s2').set('scalemethod', 'manual');
model.sol('sol1').feature('v1').feature('comp1_s2').set('scaleval', '1');
model.sol('sol1').feature('v1').set('control', 'time');
model.sol('sol1').create('t1', 'Time');
model.sol('sol1').feature('t1').set('tlist', 'range(0,20,300)');
model.sol('sol1').feature('t1').set('plot', 'off');
model.sol('sol1').feature('t1').set('plotgroup', 'Default');
model.sol('sol1').feature('t1').set('plotfreq', 'tout');
model.sol('sol1').feature('t1').set('probesel', 'all');
model.sol('sol1').feature('t1').set('probes', {});
model.sol('sol1').feature('t1').set('probefreq', 'tsteps');
model.sol('sol1').feature('t1').set('rtol', 0.005);
model.sol('sol1').feature('t1').set('atolglobalvaluemethod', 'factor');
model.sol('sol1').feature('t1').set('reacf', true);
model.sol('sol1').feature('t1').set('storeudot', true);
model.sol('sol1').feature('t1').set('endtimeinterpolation', true);
model.sol('sol1').feature('t1').set('maxorder', 2);
model.sol('sol1').feature('t1').set('stabcntrl', true);
model.sol('sol1').feature('t1').set('control', 'time');
model.sol('sol1').feature('t1').feature('aDef').set('cachepattern', true);
model.sol('sol1').feature('t1').create('seDef', 'Segregated');
model.sol('sol1').feature('t1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('t1').feature('fc1').set('jtech', 'onevery');
model.sol('sol1').feature('t1').feature('fc1').set('damp', 0.8);
model.sol('sol1').feature('t1').feature('fc1').set('maxiter', 10);
model.sol('sol1').feature('t1').feature('fc1').set('stabacc', 'aacc');
model.sol('sol1').feature('t1').feature('fc1').set('aaccdim', 5);
model.sol('sol1').feature('t1').feature('fc1').set('aaccmix', 0.9);
model.sol('sol1').feature('t1').feature('fc1').set('aaccdelay', 1);
model.sol('sol1').feature('t1').create('d1', 'Direct');
model.sol('sol1').feature('t1').feature('d1').set('linsolver', 'pardiso');
model.sol('sol1').feature('t1').feature('d1').set('pivotperturb', 1.0E-13);
model.sol('sol1').feature('t1').feature('d1').label('Direct, multiphase flow in porous media (mfpm1) (Merged)');
model.sol('sol1').feature('t1').create('i1', 'Iterative');
model.sol('sol1').feature('t1').feature('i1').set('linsolver', 'gmres');
model.sol('sol1').feature('t1').feature('i1').set('prefuntype', 'left');
model.sol('sol1').feature('t1').feature('i1').set('itrestart', 50);
model.sol('sol1').feature('t1').feature('i1').set('rhob', 400);
model.sol('sol1').feature('t1').feature('i1').set('maxlinit', 50);
model.sol('sol1').feature('t1').feature('i1').set('nlinnormuse', 'on');
model.sol('sol1').feature('t1').feature('i1').label('AMG, multiphase flow in porous media (mfpm1)');
model.sol('sol1').feature('t1').feature('i1').create('mg1', 'Multigrid');
model.sol('sol1').feature('t1').feature('i1').feature('mg1').set('prefun', 'saamg');
model.sol('sol1').feature('t1').feature('i1').feature('mg1').set('mgcycle', 'v');
model.sol('sol1').feature('t1').feature('i1').feature('mg1').set('maxcoarsedof', 50000);
model.sol('sol1').feature('t1').feature('i1').feature('mg1').set('strconn', 0.01);
model.sol('sol1').feature('t1').feature('i1').feature('mg1').set('nullspace', 'constant');
model.sol('sol1').feature('t1').feature('i1').feature('mg1').set('usesmooth', false);
model.sol('sol1').feature('t1').feature('i1').feature('mg1').set('saamgcompwise', false);
model.sol('sol1').feature('t1').feature('i1').feature('mg1').set('loweramg', true);
model.sol('sol1').feature('t1').feature('i1').feature('mg1').set('compactaggregation', false);
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('pr').create('sl1', 'SORLine');
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('pr').feature('sl1').set('linesweeptype', 'ssor');
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('pr').feature('sl1').set('iter', 1);
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('pr').feature('sl1').set('linerelax', 0.7);
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('pr').feature('sl1').set('linealgorithm', 'mesh');
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('pr').feature('sl1').set('linemethod', 'coupled');
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('pr').feature('sl1').set('seconditer', 1);
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('pr').feature('sl1').set('relax', 0.5);
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('po').create('sl1', 'SORLine');
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('po').feature('sl1').set('linesweeptype', 'ssor');
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('po').feature('sl1').set('iter', 1);
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('po').feature('sl1').set('linerelax', 0.7);
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('po').feature('sl1').set('linealgorithm', 'mesh');
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('po').feature('sl1').set('linemethod', 'coupled');
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('po').feature('sl1').set('seconditer', 1);
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('po').feature('sl1').set('relax', 0.5);
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('cs').create('d1', 'Direct');
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('cs').feature('d1').set('linsolver', 'pardiso');
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('cs').feature('d1').set('pivotperturb', 1.0E-13);
model.sol('sol1').feature('t1').feature('fc1').set('linsolver', 'd1');
model.sol('sol1').feature('t1').feature('fc1').set('jtech', 'onevery');
model.sol('sol1').feature('t1').feature('fc1').set('damp', 0.8);
model.sol('sol1').feature('t1').feature('fc1').set('maxiter', 10);
model.sol('sol1').feature('t1').feature('fc1').set('stabacc', 'aacc');
model.sol('sol1').feature('t1').feature('fc1').set('aaccdim', 5);
model.sol('sol1').feature('t1').feature('fc1').set('aaccmix', 0.9);
model.sol('sol1').feature('t1').feature('fc1').set('aaccdelay', 1);
model.sol('sol1').feature('t1').feature.remove('fcDef');
model.sol('sol1').feature('t1').feature.remove('seDef');
model.sol('sol1').attach('std1');
model.sol('sol1').feature('t1').set('tstepsbdf', 'strict');
model.sol('sol1').feature('t1').set('estrat', 'exclude');
model.sol('sol1').runAll;

model.result.create('pg1', 'PlotGroup1D');
model.result('pg1').label('Volume Fraction (phtr)');
model.result('pg1').set('showlooplevelinput', {'off' 'off' 'off'});
model.result('pg1').set('data', 'dset1');
model.result('pg1').set('defaultPlotID', 'ResultDefaults_Phtr/icom2/pdef1/pcond3/pg1');
model.result('pg1').feature.create('lngr1', 'LineGraph');
model.result('pg1').feature('lngr1').label('Line Graph');
model.result('pg1').feature('lngr1').set('showsolutionparams', 'on');
model.result('pg1').feature('lngr1').set('expr', 's2');
model.result('pg1').feature('lngr1').set('smooth', 'internal');
model.result('pg1').feature('lngr1').set('showsolutionparams', 'on');
model.result('pg1').feature('lngr1').set('data', 'parent');
model.result('pg1').feature('lngr1').selection.geom('geom1', 1);
model.result('pg1').feature('lngr1').selection.set([1]);
model.result.create('pg2', 'PlotGroup1D');
model.result('pg2').label('Pressure (dl)');
model.result('pg2').set('showlooplevelinput', {'off' 'off' 'off'});
model.result('pg2').set('titletype', 'custom');
model.result('pg2').set('typeintitle', false);
model.result('pg2').set('data', 'dset1');
model.result('pg2').set('defaultPlotID', 'PhysicsInterfaces_PorousMediaFlow/icom6/pdef1/pcond3/pg1');
model.result('pg2').feature.create('lngr1', 'LineGraph');
model.result('pg2').feature('lngr1').label('Line Graph');
model.result('pg2').feature('lngr1').set('showsolutionparams', 'on');
model.result('pg2').feature('lngr1').set('expr', 'p');
model.result('pg2').feature('lngr1').set('smooth', 'internal');
model.result('pg2').feature('lngr1').set('showsolutionparams', 'on');
model.result('pg2').feature('lngr1').set('data', 'parent');
model.result('pg2').feature('lngr1').selection.geom('geom1', 1);
model.result('pg2').feature('lngr1').selection.set([1]);
model.result('pg1').run;
model.result('pg1').set('titletype', 'manual');
model.result('pg1').set('title', 'Volume fraction of phase 2 (1)');
model.result('pg1').create('lngr2', 'LineGraph');
model.result('pg1').feature('lngr2').set('markerpos', 'datapoints');
model.result('pg1').feature('lngr2').set('linewidth', 'preference');
model.result('pg1').feature('lngr2').selection.set([1]);
model.result('pg1').feature('lngr2').set('expr', 'x');
model.result('pg1').feature('lngr2').set('xdata', 'expr');
model.result('pg1').feature('lngr2').set('xdataexpr', 'pw1(x)*(0.001*t)/0.5');
model.result('pg1').feature('lngr2').set('linestyle', 'dotted');
model.result('pg1').feature('lngr2').set('linecolor', 'cyclereset');
model.result('pg1').run;

model.title(['Two-Phase Flow in a Porous Medium: Buckley' native2unicode(hex2dec({'20' '13'}), 'unicode') 'Leverett Model']);

model.description(['This example models two-phase flow in a porous medium. In this 1D case the flow can be described by the Buckley' native2unicode(hex2dec({'20' '13'}), 'unicode') 'Leverett equation, which allows for an analytical solution and serves in this example as a benchmark.']);

model.label('buckley_leverett_model.mph');

model.modelNode.label('Components');

out = model;
