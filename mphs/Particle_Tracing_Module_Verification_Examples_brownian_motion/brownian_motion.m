function out = model
%
% brownian_motion.m
%
% Model exported on May 26 2025, 21:31 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/Particle_Tracing_Module/Verification_Examples');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 2);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.physics.create('tds', 'DilutedSpecies', 'geom1', {'c'});

model.study.create('std1');
model.study('std1').create('time', 'Transient');
model.study('std1').feature('time').setSolveFor('/physics/tds', true);

model.param.set('router', '0.0005');
model.param.descr('router', 'Outer radius');
model.param.set('rinner', '0.00025');
model.param.descr('rinner', 'Inner radius');
model.param.set('rp', '1E-7[m]');
model.param.descr('rp', 'Particle radius');
model.param.set('T', '300[K]');
model.param.descr('T', 'Temperature');
model.param.set('eta', '2E-5[Pa*s]');
model.param.descr('eta', 'Fluid viscosity');
model.param.set('D', 'k_B_const*T/(6*pi*eta*rp)');
model.param.descr('D', 'Diffusivity');
model.param.set('ds', '1');
model.param.descr('ds', 'Input to random number generator');

model.geom('geom1').create('c1', 'Circle');
model.geom('geom1').feature('c1').set('r', 'router');
model.geom('geom1').run('c1');
model.geom('geom1').create('c2', 'Circle');
model.geom('geom1').feature('c2').set('r', 'rinner');
model.geom('geom1').run('c2');
model.geom('geom1').create('pt1', 'Point');
model.geom('geom1').runPre('fin');

model.variable.create('var1');
model.variable('var1').model('comp1');

model.geom('geom1').run;

model.variable('var1').set('smooth', '2E-7');
model.variable('var1').descr('smooth', 'Smoothing distance');
model.variable('var1').set('xd', 'x[1/m]');
model.variable('var1').descr('xd', 'x-coordinate');
model.variable('var1').set('yd', 'y[1/m]');
model.variable('var1').descr('yd', 'y-coordinate');
model.variable('var1').set('c0', '1');
model.variable('var1').descr('c0', 'Peak initial concentration');
model.variable('var1').set('c_init', '2*c0*(1-flc2hs(xd^2+yd^2-smooth^2,5e-11))');
model.variable('var1').descr('c_init', 'Initial concentration');

model.cpl.create('intop1', 'Integration', 'geom1');
model.cpl('intop1').set('axisym', true);
model.cpl('intop1').selection.set([1]);
model.cpl.create('intop2', 'Integration', 'geom1');
model.cpl('intop2').set('axisym', true);
model.cpl('intop2').selection.set([2]);

model.physics('tds').prop('TransportMechanism').set('Convection', false);
model.physics('tds').create('conc1', 'Concentration', 1);
model.physics('tds').feature('conc1').selection.set([1 2 5 8]);
model.physics('tds').feature('conc1').setIndex('species', true, 0);
model.physics('tds').feature('cdm1').set('D_c', {'D' '0' '0' '0' 'D' '0' '0' '0' 'D'});
model.physics('tds').feature('init1').setIndex('initc', 'c_init', 0);

model.mesh('mesh1').autoMeshSize(2);
model.mesh('mesh1').create('size1', 'Size');
model.mesh('mesh1').feature('size1').selection.geom('geom1', 0);
model.mesh('mesh1').feature('size1').selection.set([5]);
model.mesh('mesh1').feature('size1').set('custom', true);
model.mesh('mesh1').feature('size1').set('hmaxactive', true);
model.mesh('mesh1').feature('size1').set('hmax', '6.7E-5*0.01');
model.mesh('mesh1').create('ftri1', 'FreeTri');
model.mesh('mesh1').run;

model.study('std1').feature('time').set('tlist', '0 100');
model.study('std1').feature('time').set('usertol', true);
model.study('std1').feature('time').set('rtol', '1E-4');

model.sol.create('sol1');

model.mesh('mesh1').stat.selection.geom(2);
model.mesh('mesh1').stat.selection.set([1 2]);

model.sol('sol1').study('std1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'time');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').set('control', 'time');
model.sol('sol1').create('t1', 'Time');
model.sol('sol1').feature('t1').set('tlist', '0 100');
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
model.sol('sol1').feature('t1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('t1').feature('fc1').set('jtech', 'once');
model.sol('sol1').feature('t1').feature('fc1').set('damp', 0.9);
model.sol('sol1').feature('t1').feature('fc1').set('maxiter', 8);
model.sol('sol1').feature('t1').feature('fc1').set('stabacc', 'aacc');
model.sol('sol1').feature('t1').feature('fc1').set('aaccdim', 5);
model.sol('sol1').feature('t1').feature('fc1').set('aaccmix', 0.9);
model.sol('sol1').feature('t1').feature('fc1').set('aaccdelay', 1);
model.sol('sol1').feature('t1').create('d1', 'Direct');
model.sol('sol1').feature('t1').feature('d1').set('linsolver', 'pardiso');
model.sol('sol1').feature('t1').feature('d1').set('pivotperturb', 1.0E-13);
model.sol('sol1').feature('t1').feature('d1').label('Direct, concentrations (tds)');
model.sol('sol1').feature('t1').create('i1', 'Iterative');
model.sol('sol1').feature('t1').feature('i1').set('linsolver', 'gmres');
model.sol('sol1').feature('t1').feature('i1').set('prefuntype', 'left');
model.sol('sol1').feature('t1').feature('i1').set('itrestart', 50);
model.sol('sol1').feature('t1').feature('i1').set('rhob', 400);
model.sol('sol1').feature('t1').feature('i1').set('maxlinit', 50);
model.sol('sol1').feature('t1').feature('i1').set('nlinnormuse', 'on');
model.sol('sol1').feature('t1').feature('i1').label('AMG, concentrations (tds)');
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
model.sol('sol1').feature('t1').feature('fc1').set('jtech', 'once');
model.sol('sol1').feature('t1').feature('fc1').set('damp', 0.9);
model.sol('sol1').feature('t1').feature('fc1').set('maxiter', 8);
model.sol('sol1').feature('t1').feature('fc1').set('stabacc', 'aacc');
model.sol('sol1').feature('t1').feature('fc1').set('aaccdim', 5);
model.sol('sol1').feature('t1').feature('fc1').set('aaccmix', 0.9);
model.sol('sol1').feature('t1').feature('fc1').set('aaccdelay', 1);
model.sol('sol1').feature('t1').feature.remove('fcDef');
model.sol('sol1').attach('std1');
model.sol('sol1').runAll;

model.result.create('pg1', 'PlotGroup2D');
model.result('pg1').set('data', 'dset1');
model.result('pg1').setIndex('looplevel', 2, 0);
model.result('pg1').label('Concentration (tds)');
model.result('pg1').set('titletype', 'custom');
model.result('pg1').set('prefixintitle', '');
model.result('pg1').set('expressionintitle', false);
model.result('pg1').set('typeintitle', true);
model.result('pg1').create('surf1', 'Surface');
model.result('pg1').feature('surf1').set('expr', {'c'});
model.result('pg1').create('str1', 'Streamline');
model.result('pg1').feature('str1').set('expr', {'tds.tflux_cx' 'tds.tflux_cy'});
model.result('pg1').feature('str1').set('posmethod', 'uniform');
model.result('pg1').feature('str1').set('recover', 'pprint');
model.result('pg1').feature('str1').set('pointtype', 'arrow');
model.result('pg1').feature('str1').set('arrowlength', 'logarithmic');
model.result('pg1').feature('str1').set('color', 'gray');
model.result('pg1').run;
model.result.numerical.create('gev1', 'EvalGlobal');
model.result.numerical('gev1').setIndex('looplevelinput', 'last', 0);
model.result.numerical('gev1').setIndex('expr', 'intop1(c)/(intop1(c)+intop2(c))', 0);
model.result.table.create('tbl1', 'Table');
model.result.table('tbl1').comments('Global Evaluation 1');
model.result.numerical('gev1').set('table', 'tbl1');
model.result.numerical('gev1').setResult;

model.physics.create('fpt', 'FluidParticleTracing', 'geom1');
model.physics('fpt').model('comp1');

model.study('std1').feature('time').setSolveFor('/physics/fpt', false);
model.study.create('std2');
model.study('std2').create('time', 'Transient');
model.study('std2').feature('time').setSolveFor('/physics/tds', false);
model.study('std2').feature('time').setSolveFor('/physics/fpt', true);

model.physics('fpt').prop('WallAccuracyOrder').setIndex('WallAccuracyOrder', 1, 0);
model.physics('fpt').prop('RandomNumberArgs').setIndex('RandomNumberArgs', 'UserDefined', 0);
model.physics('fpt').feature('pp1').set('dp', '2*rp');
model.physics('fpt').feature('pp1').set('rhop_mat', 'userdef');
model.physics('fpt').create('df1', 'DragForce', 2);
model.physics('fpt').feature('df1').selection.all;
model.physics('fpt').feature('df1').set('mu_mat', 'userdef');
model.physics('fpt').feature('df1').set('mu', 'eta');
model.physics('fpt').create('bf1', 'BrownianForce', 2);
model.physics('fpt').feature('bf1').selection.all;
model.physics('fpt').feature('bf1').set('minput_temperature', 'T');
model.physics('fpt').feature('bf1').set('mu_mat', 'userdef');
model.physics('fpt').feature('bf1').set('mu', 'eta');
model.physics('fpt').feature('bf1').set('i', 'ds');
model.physics('fpt').create('relg1', 'ReleaseGrid', -1);
model.physics('fpt').feature('relg1').set('InitialVelocity', 'ConstantSpeedSpherical');
model.physics('fpt').feature('relg1').set('Us', 0);
model.physics('fpt').feature('relg1').setIndex('Nvel', 5000, 0);
model.physics('fpt').create('pcnt1', 'ParticleCounter', 2);
model.physics('fpt').feature('pcnt1').selection.set([1]);
model.physics('fpt').feature('pcnt1').set('ReleaseFeature', 'relg1');

model.study('std2').feature('time').set('tlist', '0 100');
model.study('std2').feature('time').set('usertol', true);
model.study('std2').feature('time').set('rtol', '1E-2');

model.sol.create('sol2');
model.sol('sol2').study('std2');
model.sol('sol2').create('st1', 'StudyStep');
model.sol('sol2').feature('st1').set('study', 'std2');
model.sol('sol2').feature('st1').set('studystep', 'time');
model.sol('sol2').create('v1', 'Variables');
model.sol('sol2').feature('v1').set('control', 'time');
model.sol('sol2').create('t1', 'Time');
model.sol('sol2').feature('t1').set('tlist', '0 100');
model.sol('sol2').feature('t1').set('plot', 'off');
model.sol('sol2').feature('t1').set('plotgroup', 'pg1');
model.sol('sol2').feature('t1').set('plotfreq', 'tout');
model.sol('sol2').feature('t1').set('probesel', 'all');
model.sol('sol2').feature('t1').set('probes', {});
model.sol('sol2').feature('t1').set('probefreq', 'tsteps');
model.sol('sol2').feature('t1').set('rtol', 1.0E-5);
model.sol('sol2').feature('t1').set('ewtrescale', false);
model.sol('sol2').feature('t1').set('atolglobalvaluemethod', 'factor');
model.sol('sol2').feature('t1').set('reacf', true);
model.sol('sol2').feature('t1').set('storeudot', true);
model.sol('sol2').feature('t1').set('tstepsgenalpha', 'strict');
model.sol('sol2').feature('t1').set('endtimeinterpolation', true);
model.sol('sol2').feature('t1').set('timemethod', 'genalpha');
model.sol('sol2').feature('t1').set('estrat', 'exclude');
model.sol('sol2').feature('t1').set('control', 'time');
model.sol('sol2').feature('t1').create('fc1', 'FullyCoupled');
model.sol('sol2').feature('t1').feature('fc1').set('ntolfact', 0.1);
model.sol('sol2').feature('t1').create('i1', 'Iterative');
model.sol('sol2').feature('t1').feature('i1').set('linsolver', 'gmres');
model.sol('sol2').feature('t1').feature('i1').create('ja1', 'Jacobi');
model.sol('sol2').feature('t1').feature('fc1').set('linsolver', 'i1');
model.sol('sol2').feature('t1').feature('fc1').set('ntolfact', 0.1);
model.sol('sol2').feature('t1').feature.remove('fcDef');
model.sol('sol2').attach('std2');
model.sol('sol2').runAll;

model.result.dataset.create('part1', 'Particle');
model.result.dataset('part1').set('solution', 'sol2');
model.result.dataset('part1').set('posdof', {'comp1.qx' 'comp1.qy'});
model.result.dataset('part1').set('geom', 'geom1');
model.result.dataset('part1').set('pgeom', 'pgeom_fpt');
model.result.dataset('part1').set('pgeomspec', 'fromphysics');
model.result.dataset('part1').set('physicsinterface', 'fpt');
model.result.create('pg2', 'PlotGroup2D');
model.result('pg2').set('data', 'part1');
model.result('pg2').setIndex('looplevel', 2, 0);
model.result('pg2').label('Particle Trajectories (fpt)');
model.result('pg2').create('traj1', 'ParticleTrajectories');
model.result('pg2').feature('traj1').set('pointtype', 'point');
model.result('pg2').feature('traj1').set('linetype', 'none');
model.result('pg2').feature('traj1').create('col1', 'Color');
model.result('pg2').feature('traj1').feature('col1').set('expr', 'fpt.V');
model.result('pg2').run;
model.result.numerical.create('gev2', 'EvalGlobal');
model.result.numerical('gev2').set('data', 'dset2');
model.result.numerical('gev2').setIndex('looplevelinput', 'last', 0);
model.result.numerical('gev2').set('expr', {'fpt.pcnt1.alpha'});
model.result.numerical('gev2').set('descr', {'Transmission probability'});
model.result.numerical('gev2').set('unit', {'1'});
model.result.table.create('tbl2', 'Table');
model.result.table('tbl2').comments('Global Evaluation 2');
model.result.numerical('gev2').set('table', 'tbl2');
model.result.numerical('gev2').setResult;

model.study.create('std3');
model.study('std3').create('time', 'Transient');
model.study('std3').feature('time').setSolveFor('/physics/tds', false);
model.study('std3').feature('time').setSolveFor('/physics/fpt', true);
model.study('std3').feature('time').set('tlist', '0 100');
model.study('std3').feature('time').set('usertol', true);
model.study('std3').feature('time').set('rtol', '1E-2');
model.study('std3').create('param', 'Parametric');
model.study('std3').feature('param').setIndex('pname', 'router', 0);
model.study('std3').feature('param').setIndex('plistarr', '', 0);
model.study('std3').feature('param').setIndex('punit', '', 0);
model.study('std3').feature('param').setIndex('pname', 'router', 0);
model.study('std3').feature('param').setIndex('plistarr', '', 0);
model.study('std3').feature('param').setIndex('punit', '', 0);
model.study('std3').feature('param').setIndex('pname', 'ds', 0);
model.study('std3').feature('param').setIndex('plistarr', '2 3 4 5', 0);

model.sol.create('sol3');
model.sol('sol3').study('std3');
model.sol('sol3').create('st1', 'StudyStep');
model.sol('sol3').feature('st1').set('study', 'std3');
model.sol('sol3').feature('st1').set('studystep', 'time');
model.sol('sol3').create('v1', 'Variables');
model.sol('sol3').feature('v1').set('control', 'time');
model.sol('sol3').create('t1', 'Time');
model.sol('sol3').feature('t1').set('tlist', '0 100');
model.sol('sol3').feature('t1').set('plot', 'off');
model.sol('sol3').feature('t1').set('plotgroup', 'pg1');
model.sol('sol3').feature('t1').set('plotfreq', 'tout');
model.sol('sol3').feature('t1').set('probesel', 'all');
model.sol('sol3').feature('t1').set('probes', {});
model.sol('sol3').feature('t1').set('probefreq', 'tsteps');
model.sol('sol3').feature('t1').set('rtol', 1.0E-5);
model.sol('sol3').feature('t1').set('ewtrescale', false);
model.sol('sol3').feature('t1').set('atolglobalvaluemethod', 'factor');
model.sol('sol3').feature('t1').set('reacf', true);
model.sol('sol3').feature('t1').set('storeudot', true);
model.sol('sol3').feature('t1').set('tstepsgenalpha', 'strict');
model.sol('sol3').feature('t1').set('endtimeinterpolation', true);
model.sol('sol3').feature('t1').set('timemethod', 'genalpha');
model.sol('sol3').feature('t1').set('estrat', 'exclude');
model.sol('sol3').feature('t1').set('control', 'time');
model.sol('sol3').feature('t1').create('fc1', 'FullyCoupled');
model.sol('sol3').feature('t1').feature('fc1').set('ntolfact', 0.1);
model.sol('sol3').feature('t1').create('i1', 'Iterative');
model.sol('sol3').feature('t1').feature('i1').set('linsolver', 'gmres');
model.sol('sol3').feature('t1').feature('i1').create('ja1', 'Jacobi');
model.sol('sol3').feature('t1').feature('fc1').set('linsolver', 'i1');
model.sol('sol3').feature('t1').feature('fc1').set('ntolfact', 0.1);
model.sol('sol3').feature('t1').feature.remove('fcDef');
model.sol('sol3').attach('std3');

model.batch.create('p1', 'Parametric');
model.batch('p1').study('std3');
model.batch('p1').create('so1', 'Solutionseq');
model.batch('p1').feature('so1').set('seq', 'sol3');
model.batch('p1').feature('so1').set('store', 'on');
model.batch('p1').feature('so1').set('clear', 'on');
model.batch('p1').feature('so1').set('psol', 'none');
model.batch('p1').set('pname', {'ds'});
model.batch('p1').set('plistarr', {'2 3 4 5'});
model.batch('p1').set('sweeptype', 'sparse');
model.batch('p1').set('probesel', 'all');
model.batch('p1').set('probes', {});
model.batch('p1').set('plot', 'off');
model.batch('p1').set('err', 'on');
model.batch('p1').attach('std3');
model.batch('p1').set('control', 'param');

model.sol.create('sol4');
model.sol('sol4').study('std3');
model.sol('sol4').label('Parametric Solutions 1');

model.batch('p1').feature('so1').set('psol', 'sol4');
model.batch('p1').run('compute');

model.result.dataset.create('part2', 'Particle');
model.result.dataset('part2').set('solution', 'sol4');
model.result.dataset('part2').set('posdof', {'comp1.qx' 'comp1.qy'});
model.result.dataset('part2').set('geom', 'geom1');
model.result.dataset('part2').set('pgeom', 'pgeom_fpt');
model.result.dataset('part2').set('pgeomspec', 'fromphysics');
model.result.dataset('part2').set('physicsinterface', 'fpt');
model.result.create('pg3', 'PlotGroup2D');
model.result('pg3').set('data', 'part2');
model.result('pg3').setIndex('looplevel', 2, 0);
model.result('pg3').setIndex('looplevel', 4, 1);
model.result('pg3').label('Particle Trajectories (fpt) 1');
model.result('pg3').create('traj1', 'ParticleTrajectories');
model.result('pg3').feature('traj1').set('pointtype', 'point');
model.result('pg3').feature('traj1').set('linetype', 'none');
model.result('pg3').feature('traj1').create('col1', 'Color');
model.result('pg3').feature('traj1').feature('col1').set('expr', 'fpt.V');
model.result('pg3').run;
model.result.numerical.create('gev3', 'EvalGlobal');
model.result.numerical('gev3').set('data', 'dset4');
model.result.numerical('gev3').setIndex('looplevelinput', 'last', 0);
model.result.numerical('gev3').set('tablecols', 'level1');
model.result.numerical('gev3').set('expr', {'fpt.pcnt1.alpha'});
model.result.numerical('gev3').set('descr', {'Transmission probability'});
model.result.numerical('gev3').set('unit', {'1'});
model.result.table.create('tbl3', 'Table');
model.result.table('tbl3').comments('Global Evaluation 3');
model.result.numerical('gev3').set('table', 'tbl3');
model.result.numerical('gev3').setResult;
model.result('pg3').run;
model.result('pg3').setIndex('looplevel', 1, 1);
model.result('pg3').run;
model.result('pg3').setIndex('looplevel', 2, 1);
model.result('pg3').run;
model.result('pg3').setIndex('looplevel', 3, 1);
model.result('pg3').run;
model.result('pg3').setIndex('looplevel', 4, 1);
model.result('pg3').run;

model.title('Brownian Motion');

model.description('This tutorial shows how to simulate particle motion due to a Brownian force. The results are compared to the solution from a pure diffusion equation and show good agreement. Finally, a Monte Carlo simulation is performed which solves the model several times using a different set of random numbers each time.');

model.mesh.clearMeshes;

model.sol('sol1').clearSolutionData;
model.sol('sol2').clearSolutionData;
model.sol('sol3').clearSolutionData;
model.sol('sol4').clearSolutionData;
model.sol('sol5').clearSolutionData;
model.sol('sol6').clearSolutionData;
model.sol('sol7').clearSolutionData;
model.sol('sol8').clearSolutionData;

model.label('brownian_motion.mph');

model.modelNode.label('Components');

out = model;
