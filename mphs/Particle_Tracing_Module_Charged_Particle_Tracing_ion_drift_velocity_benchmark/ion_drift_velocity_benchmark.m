function out = model
%
% ion_drift_velocity_benchmark.m
%
% Model exported on May 26 2025, 21:31 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/Particle_Tracing_Module/Charged_Particle_Tracing');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 3);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.physics.create('cpt', 'ChargedParticleTracing', 'geom1');
model.physics('cpt').model('comp1');

model.study.create('std1');
model.study('std1').create('time', 'Transient');
model.study('std1').feature('time').setSolveFor('/physics/cpt', true);

model.param.set('mAr', '0.04[kg/mol]/N_A_const');
model.param.descr('mAr', 'Ar+ ion mass');
model.param.set('ND', '3.2956e22[1/m^3]');
model.param.descr('ND', 'Background gas number density');
model.param.set('EoverN', '500');
model.param.descr('EoverN', 'Reduced electric field in Townsend');
model.param.set('Ez', '1e-21[V*m^2]*EoverN*ND');
model.param.descr('Ez', 'Electric field magnitude');
model.param.set('T0', '300[K]');
model.param.descr('T0', 'Gas temperature');
model.param.set('maxCol', '1e5');
model.param.descr('maxCol', 'Maximum number of collisions for termination');

model.func.create('int1', 'Interpolation');
model.func('int1').model('comp1');
model.func('int1').set('source', 'file');
model.func('int1').set('filename', 'ion_drift_velocity_benchmark_velocity.txt');
model.func('int1').importData;
model.func('int1').setIndex('fununit', 'm/s', 0);
model.func('int1').set('funcname', 'Vdrift');
model.func.create('int2', 'Interpolation');
model.func('int2').model('comp1');
model.func('int2').set('source', 'file');
model.func('int2').set('filename', 'ion_drift_velocity_benchmark_temperature.txt');
model.func('int2').importData;
model.func('int2').setIndex('fununit', 'eV', 0);
model.func('int2').set('funcname', 'ionTemp');
model.func.create('an1', 'Analytic');
model.func('an1').model('comp1');
model.func('an1').set('funcname', 'Qm');
model.func('an1').set('expr', '1.15e-18*x^(-0.1)*(1+0.015/x)^0.6');
model.func('an1').setIndex('argunit', 'eV', 0);
model.func('an1').set('fununit', 'm^2');
model.func.create('an2', 'Analytic');
model.func('an2').model('comp1');
model.func('an2').set('funcname', 'Qi');
model.func('an2').set('expr', '2e-19/(x^(0.5)*(1+x))+3e-19*x/(1+x/3)^(2.3)');
model.func('an2').setIndex('argunit', 'eV', 0);
model.func('an2').set('fununit', 'm^2');

model.geom('geom1').create('cyl1', 'Cylinder');
model.geom('geom1').feature('cyl1').set('r', 2);
model.geom('geom1').feature('cyl1').set('h', 3);
model.geom('geom1').runPre('fin');
model.geom('geom1').run;

model.physics('cpt').feature('pp1').set('mp', 'mAr');
model.physics('cpt').feature('pp1').set('Z', 1);
model.physics('cpt').feature('wall1').set('WallCondition', 'Bounce');
model.physics('cpt').create('relg1', 'ReleaseGrid', -1);
model.physics('cpt').feature('relg1').setIndex('x0', 1, 2);
model.physics('cpt').feature('relg1').set('InitialVelocity', 'Maxwellian');
model.physics('cpt').feature('relg1').setIndex('M', 30, 0);
model.physics('cpt').feature('relg1').set('T0', 'T0');
model.physics('cpt').create('ef1', 'ElectricForce', 3);
model.physics('cpt').feature('ef1').selection.all;
model.physics('cpt').feature('ef1').set('E', {'0' '0' 'Ez'});
model.physics('cpt').create('col1', 'Collisions', 3);
model.physics('cpt').feature('col1').selection.all;
model.physics('cpt').feature('col1').set('Nd', 'ND');
model.physics('cpt').feature('col1').set('T', 'T0');
model.physics('cpt').feature('col1').set('CollisionDetection', 'NullCollisionMethodColdGasApproximation');
model.physics('cpt').feature('col1').set('CountAllCollisions', true);
model.physics('cpt').feature('col1').create('ela1', 'Elastic', 3);
model.physics('cpt').feature('col1').feature('ela1').set('xsec', 'Qi(cpt.Ep)');
model.physics('cpt').feature('col1').feature('ela1').set('CountCollisions', true);
model.physics('cpt').feature('col1').create('cex1', 'ResonantChargeExchange', 3);
model.physics('cpt').feature('col1').feature('cex1').set('xsec', '(Qm(cpt.Ep)-Qi(cpt.Ep))/2');
model.physics('cpt').feature('col1').feature('cex1').set('CountCollisions', true);

model.mesh('mesh1').run;

model.study('std1').create('param', 'Parametric');
model.study('std1').feature('param').setIndex('pname', 'mAr', 0);
model.study('std1').feature('param').setIndex('plistarr', '', 0);
model.study('std1').feature('param').setIndex('punit', 'kg', 0);
model.study('std1').feature('param').setIndex('pname', 'mAr', 0);
model.study('std1').feature('param').setIndex('plistarr', '', 0);
model.study('std1').feature('param').setIndex('punit', 'kg', 0);
model.study('std1').feature('param').setIndex('pname', 'EoverN', 0);
model.study('std1').feature('param').setIndex('plistarr', '5e2, 1e3, 2e3, 3e3, 5e3, 1e4, 2e4, 3e4, 5e4, 1e5', 0);
model.study('std1').feature('time').set('tlist', '0,5.0e-8*sqrt(maxCol/EoverN)');

model.sol.create('sol1');
model.sol('sol1').study('std1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'time');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').set('control', 'time');
model.sol('sol1').create('t1', 'Time');
model.sol('sol1').feature('t1').set('tlist', '0,5.0e-8*sqrt(maxCol/EoverN)');
model.sol('sol1').feature('t1').set('plot', 'off');
model.sol('sol1').feature('t1').set('plotgroup', 'Default');
model.sol('sol1').feature('t1').set('plotfreq', 'tout');
model.sol('sol1').feature('t1').set('probesel', 'all');
model.sol('sol1').feature('t1').set('probes', {});
model.sol('sol1').feature('t1').set('probefreq', 'tsteps');
model.sol('sol1').feature('t1').set('rtol', 1.0E-5);
model.sol('sol1').feature('t1').set('atolglobalvaluemethod', 'factor');
model.sol('sol1').feature('t1').set('reacf', true);
model.sol('sol1').feature('t1').set('storeudot', true);
model.sol('sol1').feature('t1').set('tstepsgenalpha', 'strict');
model.sol('sol1').feature('t1').set('endtimeinterpolation', true);
model.sol('sol1').feature('t1').set('timemethod', 'genalpha');
model.sol('sol1').feature('t1').set('estrat', 'exclude');
model.sol('sol1').feature('t1').set('control', 'time');
model.sol('sol1').feature('t1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('t1').feature('fc1').set('ntolfact', 0.1);
model.sol('sol1').feature('t1').create('i1', 'Iterative');
model.sol('sol1').feature('t1').feature('i1').set('linsolver', 'gmres');
model.sol('sol1').feature('t1').feature('i1').create('ja1', 'Jacobi');
model.sol('sol1').feature('t1').feature('fc1').set('linsolver', 'i1');
model.sol('sol1').feature('t1').feature('fc1').set('ntolfact', 0.1);
model.sol('sol1').feature('t1').feature.remove('fcDef');
model.sol('sol1').attach('std1');

model.batch.create('p1', 'Parametric');
model.batch('p1').study('std1');
model.batch('p1').create('so1', 'Solutionseq');
model.batch('p1').feature('so1').set('seq', 'sol1');
model.batch('p1').feature('so1').set('store', 'on');
model.batch('p1').feature('so1').set('clear', 'on');
model.batch('p1').feature('so1').set('psol', 'none');
model.batch('p1').set('pname', {'EoverN'});
model.batch('p1').set('plistarr', {'5e2, 1e3, 2e3, 3e3, 5e3, 1e4, 2e4, 3e4, 5e4, 1e5'});
model.batch('p1').set('sweeptype', 'sparse');
model.batch('p1').set('probesel', 'all');
model.batch('p1').set('probes', {});
model.batch('p1').set('plot', 'off');
model.batch('p1').set('err', 'on');
model.batch('p1').attach('std1');
model.batch('p1').set('control', 'param');

model.sol('sol1').feature('t1').set('tstepsgenalpha', 'manual');
model.sol('sol1').feature('t1').set('timestepgenalpha', '2.5e-9*sqrt(maxCol/EoverN)');
model.sol('sol1').feature('t1').set('rhoinf', 1);
model.sol('sol1').feature('t1').create('st1', 'StopCondition');
model.sol('sol1').feature('t1').feature('st1').setIndex('stopcondarr', '', 0);
model.sol('sol1').feature('t1').feature('st1').setIndex('stopcondterminateon', 'true', 0);
model.sol('sol1').feature('t1').feature('st1').setIndex('stopcondActive', true, 0);
model.sol('sol1').feature('t1').feature('st1').setIndex('stopconddesc', 'Stop expression 1', 0);
model.sol('sol1').feature('t1').feature('st1').setIndex('stopcondarr', '', 0);
model.sol('sol1').feature('t1').feature('st1').setIndex('stopcondterminateon', 'true', 0);
model.sol('sol1').feature('t1').feature('st1').setIndex('stopcondActive', true, 0);
model.sol('sol1').feature('t1').feature('st1').setIndex('stopconddesc', 'Stop expression 1', 0);
model.sol('sol1').feature('t1').feature('st1').setIndex('stopcondarr', 'comp1.cpt.sum(comp1.cpt.col1.cex1.Nc)>maxCol', 0);
model.sol('sol1').feature('t1').feature('st1').set('storestopcondsol', 'stepbefore_stepafter');
model.sol.create('sol2');
model.sol('sol2').study('std1');
model.sol('sol2').label('Parametric Solutions 1');

model.batch('p1').feature('so1').set('psol', 'sol2');
model.batch('p1').run('compute');

model.result.dataset.create('part1', 'Particle');
model.result.dataset('part1').set('solution', 'sol2');
model.result.dataset('part1').set('posdof', {'comp1.qx' 'comp1.qy' 'comp1.qz'});
model.result.dataset('part1').set('geom', 'geom1');
model.result.dataset('part1').set('pgeom', 'pgeom_cpt');
model.result.dataset('part1').set('pgeomspec', 'fromphysics');
model.result.dataset('part1').set('physicsinterface', 'cpt');
model.result.create('pg1', 'PlotGroup3D');
model.result('pg1').set('data', 'part1');
model.result('pg1').setIndex('looplevel', 3, 0);
model.result('pg1').setIndex('looplevel', 10, 1);
model.result('pg1').label('Particle Trajectories (cpt)');
model.result('pg1').create('traj1', 'ParticleTrajectories');
model.result('pg1').feature('traj1').set('pointtype', 'point');
model.result('pg1').feature('traj1').set('linetype', 'none');
model.result('pg1').feature('traj1').create('col1', 'Color');
model.result('pg1').feature('traj1').feature('col1').set('expr', 'cpt.V');
model.result('pg1').run;
model.result.create('pg2', 'PlotGroup1D');
model.result('pg2').run;
model.result('pg2').label('Drift Velocity');
model.result('pg2').set('data', 'dset2');
model.result('pg2').setIndex('looplevelinput', 'last', 0);
model.result('pg2').set('legendpos', 'lowerright');
model.result('pg2').create('glob1', 'Global');
model.result('pg2').feature('glob1').set('markerpos', 'datapoints');
model.result('pg2').feature('glob1').set('linewidth', 'preference');
model.result('pg2').feature('glob1').setIndex('expr', 'cpt.ave(cpt.vz)', 0);
model.result('pg2').feature('glob1').setIndex('descr', '', 0);
model.result('pg2').feature('glob1').setIndex('expr', 'Vdrift(EoverN)', 1);
model.result('pg2').feature('glob1').setIndex('descr', '', 1);
model.result('pg2').feature('glob1').set('xdatasolnumtype', 'outer');
model.result('pg2').feature('glob1').set('xdata', 'expr');
model.result('pg2').feature('glob1').set('xdataexpr', 'EoverN');
model.result('pg2').feature('glob1').set('legendmethod', 'manual');
model.result('pg2').feature('glob1').setIndex('legends', 'COMSOL', 0);
model.result('pg2').feature('glob1').setIndex('legends', 'Reference', 1);
model.result('pg2').run;
model.result('pg2').set('ylabelactive', true);
model.result('pg2').set('ylabel', 'Drift velocity (m/s)');
model.result('pg2').set('titletype', 'manual');
model.result('pg2').set('title', 'Drift velocity comparison');
model.result('pg2').run;
model.result.duplicate('pg3', 'pg2');
model.result('pg3').run;
model.result('pg3').label('Ion Temperature');
model.result('pg3').run;
model.result('pg3').feature('glob1').setIndex('expr', 'cpt.ave(2*cpt.Ep)', 0);
model.result('pg3').feature('glob1').setIndex('unit', 'eV', 0);
model.result('pg3').feature('glob1').setIndex('expr', 'ionTemp(EoverN)', 1);
model.result('pg3').feature('glob1').setIndex('unit', 'eV', 1);
model.result('pg3').run;
model.result('pg3').set('ylabel', 'Ion temperature (eV)');
model.result('pg3').set('title', 'Ion temperature comparison');
model.result('pg3').run;

model.title('Ion Drift Velocity Benchmark');

model.description('The drift velocity of Ar+ is calculated using a Monte Carlo simulation in which the elastic collisions and charge exchange reactions of argon ions with a neutral buffer gas are explicitly modeled. The example uses energy-dependent collision cross-section data from experiment. The average ion velocity values are consistent with experimental data over a wide range of reduced electric field magnitudes.');

model.mesh.clearMeshes;

model.sol('sol1').clearSolutionData;
model.sol('sol2').clearSolutionData;
model.sol('sol3').clearSolutionData;
model.sol('sol4').clearSolutionData;
model.sol('sol5').clearSolutionData;
model.sol('sol6').clearSolutionData;
model.sol('sol7').clearSolutionData;
model.sol('sol8').clearSolutionData;
model.sol('sol9').clearSolutionData;
model.sol('sol10').clearSolutionData;
model.sol('sol11').clearSolutionData;
model.sol('sol12').clearSolutionData;

model.label('ion_drift_velocity_benchmark.mph');

model.modelNode.label('Components');

out = model;
