function out = model
%
% ion_cyclotron_motion.m
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

model.physics.create('pt', 'MathParticle', 'geom1');
model.physics('pt').model('comp1');

model.study.create('std1');
model.study('std1').create('time', 'Transient');
model.study('std1').feature('time').setSolveFor('/physics/pt', true);

model.geom('geom1').create('cyl1', 'Cylinder');
model.geom('geom1').feature('cyl1').set('r', '2e-3');
model.geom('geom1').feature('cyl1').set('h', '2e-3');
model.geom('geom1').run('fin');

model.param.set('mp', '0.04[kg/mol]/N_A_const');
model.param.descr('mp', 'Ion mass');
model.param.set('B', '2[T]');
model.param.descr('B', 'Magnetic flux density');
model.param.set('v0', '2E3[m/s]');
model.param.descr('v0', 'Particle velocity, perpendicular to the magnetic field');
model.param.set('rL', 'mp*v0/(e_const*B)');
model.param.descr('rL', 'Larmor radius');

model.variable.create('var1');
model.variable('var1').model('comp1');
model.variable('var1').set('Ax', '1[Wb/m]*y[1/m]');
model.variable('var1').descr('Ax', 'Magnetic vector potential, x-component');
model.variable('var1').set('Ay', '-1[Wb/m]*x[1/m]');
model.variable('var1').descr('Ay', 'Magnetic vector potential, y-component');
model.variable('var1').set('Az', '0[Wb/m]');
model.variable('var1').descr('Az', 'Magnetic vector potential, z-component');
model.variable('var1').set('Bx', 'd(Az,y)-d(Ay,z)');
model.variable('var1').descr('Bx', 'Magnetic flux density, x-component');
model.variable('var1').set('By', 'd(Ax,z)-d(Az,x)');
model.variable('var1').descr('By', 'Magnetic flux density, y-component');
model.variable('var1').set('Bz', 'd(Ay,x)-d(Ax,y)');
model.variable('var1').descr('Bz', 'Magnetic flux density, z-component');

model.physics('pt').create('relg1', 'ReleaseGrid', -1);
model.physics('pt').feature('relg1').set('v0', {'v0' '0' '1e2'});
model.physics('pt').prop('Formulation').setIndex('Formulation', 'Lagrangian', 0);
model.physics('pt').feature('pp1').set('mp', 'mp');
model.physics('pt').feature('pp1').set('L', 'pt.Ep+e_const*(pt.vx*Ax+pt.vy*Ay+pt.vz*Az)');

model.mesh('mesh1').autoMeshSize(8);
model.mesh('mesh1').run;

model.study('std1').feature('time').set('tlist', 'range(0,5.0e-8,2.0e-5)');
model.study('std1').feature('time').set('usertol', true);
model.study('std1').feature('time').set('rtol', 1.0E-6);
model.study('std1').label('Lagrangian Study');

model.sol.create('sol1');
model.sol('sol1').study('std1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'time');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').set('control', 'time');
model.sol('sol1').create('t1', 'Time');
model.sol('sol1').feature('t1').set('tlist', 'range(0,5.0e-8,2.0e-5)');
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
model.sol('sol1').runAll;

model.result.dataset.create('part1', 'Particle');
model.result.dataset('part1').set('solution', 'sol1');
model.result.dataset('part1').set('posdof', {'comp1.qx' 'comp1.qy' 'comp1.qz'});
model.result.dataset('part1').set('geom', 'geom1');
model.result.dataset('part1').set('pgeom', 'pgeom_pt');
model.result.dataset('part1').set('pgeomspec', 'fromphysics');
model.result.dataset('part1').set('physicsinterface', 'pt');
model.result.create('pg1', 'PlotGroup3D');
model.result('pg1').set('data', 'part1');
model.result('pg1').setIndex('looplevel', 401, 0);
model.result('pg1').label('Particle Trajectories (pt)');
model.result('pg1').create('traj1', 'ParticleTrajectories');
model.result('pg1').feature('traj1').set('pointtype', 'point');
model.result('pg1').feature('traj1').set('linetype', 'none');
model.result('pg1').feature('traj1').create('col1', 'Color');
model.result('pg1').feature('traj1').feature('col1').set('expr', 'pt.V');
model.result('pg1').run;
model.result('pg1').label('Lagrangian Results');
model.result('pg1').set('edges', false);
model.result('pg1').run;
model.result('pg1').feature('traj1').set('linetype', 'ribbon');
model.result('pg1').feature('traj1').set('widthscaleactive', true);
model.result('pg1').feature('traj1').set('widthscale', '4E-5');
model.result('pg1').feature('traj1').set('pointtype', 'none');
model.result('pg1').run;
model.result('pg1').feature('traj1').feature('col1').set('expr', 'qy/2');
model.result('pg1').feature('traj1').feature('col1').set('colortable', 'Inferno');
model.result('pg1').run;
model.result.numerical.create('par1', 'Particle');
model.result.numerical('par1').setIndex('looplevelinput', 'first', 0);
model.result.numerical('par1').set('expr', 'rL');
model.result.table.create('tbl1', 'Table');
model.result.table('tbl1').comments('Particle Evaluation 1');
model.result.numerical('par1').set('table', 'tbl1');
model.result.numerical('par1').setResult;
model.result.numerical.create('par2', 'Particle');
model.result.numerical('par2').setIndex('looplevelinput', 'first', 0);
model.result.numerical('par2').set('expr', 'timemax(0,2E-5,qy)/2');
model.result.numerical('par2').set('table', 'tbl1');
model.result.numerical('par2').appendResult;

model.physics('pt').prop('Formulation').setIndex('Formulation', 'Hamiltonian', 0);
model.physics('pt').feature('pp1').set('H', '((px-e_const*Ax)^2+(py-e_const*Ay)^2+(pz-e_const*Az)^2)/(2*pt.mp)');

model.study.create('std2');
model.study('std2').create('time', 'Transient');
model.study('std2').feature('time').setSolveFor('/physics/pt', true);
model.study('std2').feature('time').set('tlist', 'range(0,5.0e-8,2.0e-5)');
model.study('std2').feature('time').set('usertol', true);
model.study('std2').feature('time').set('rtol', 1.0E-6);
model.study('std2').label('Hamiltonian Study');

model.sol.create('sol2');
model.sol('sol2').study('std2');
model.sol('sol2').create('st1', 'StudyStep');
model.sol('sol2').feature('st1').set('study', 'std2');
model.sol('sol2').feature('st1').set('studystep', 'time');
model.sol('sol2').create('v1', 'Variables');
model.sol('sol2').feature('v1').set('control', 'time');
model.sol('sol2').create('t1', 'Time');
model.sol('sol2').feature('t1').set('tlist', 'range(0,5.0e-8,2.0e-5)');
model.sol('sol2').feature('t1').set('plot', 'off');
model.sol('sol2').feature('t1').set('plotgroup', 'pg1');
model.sol('sol2').feature('t1').set('plotfreq', 'tout');
model.sol('sol2').feature('t1').set('probesel', 'all');
model.sol('sol2').feature('t1').set('probes', {});
model.sol('sol2').feature('t1').set('probefreq', 'tsteps');
model.sol('sol2').feature('t1').set('rtol', 1.0E-5);
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
model.sol('sol2').feature('t1').feature('fc1').set('linsolver', 'dDef');
model.sol('sol2').feature('t1').feature('fc1').set('ntolfact', 0.1);
model.sol('sol2').feature('t1').feature.remove('fcDef');
model.sol('sol2').attach('std2');
model.sol('sol2').runAll;

model.result.dataset.create('part2', 'Particle');
model.result.dataset('part2').set('solution', 'sol2');
model.result.dataset('part2').set('posdof', {'comp1.qx' 'comp1.qy' 'comp1.qz'});
model.result.dataset('part2').set('geom', 'geom1');
model.result.dataset('part2').set('pgeom', 'pgeom_pt');
model.result.dataset('part2').set('pgeomspec', 'fromphysics');
model.result.dataset('part2').set('physicsinterface', 'pt');
model.result.create('pg2', 'PlotGroup3D');
model.result('pg2').set('data', 'part2');
model.result('pg2').setIndex('looplevel', 401, 0);
model.result('pg2').label('Particle Trajectories (pt)');
model.result('pg2').create('traj1', 'ParticleTrajectories');
model.result('pg2').feature('traj1').set('pointtype', 'point');
model.result('pg2').feature('traj1').set('linetype', 'none');
model.result('pg2').feature('traj1').create('col1', 'Color');
model.result('pg2').feature('traj1').feature('col1').set('expr', 'pt.V');
model.result('pg2').run;
model.result('pg2').label('Hamiltonian Results');
model.result('pg2').set('edges', false);
model.result('pg2').run;
model.result('pg2').feature('traj1').set('linetype', 'ribbon');
model.result('pg2').feature('traj1').set('widthscaleactive', true);
model.result('pg2').feature('traj1').set('widthscale', '4E-5');
model.result('pg2').feature('traj1').set('pointtype', 'none');
model.result('pg2').run;
model.result('pg2').feature('traj1').feature('col1').set('expr', 'qy/2');
model.result('pg2').feature('traj1').feature('col1').set('colortable', 'Inferno');
model.result('pg2').run;
model.result.numerical.create('par3', 'Particle');
model.result.numerical('par3').set('data', 'part2');
model.result.numerical('par3').setIndex('looplevelinput', 'first', 0);
model.result.numerical('par3').set('expr', 'timemax(0,2E-5,qy)/2');
model.result.numerical('par3').set('table', 'tbl1');
model.result.numerical('par3').appendResult;

model.physics('pt').prop('Formulation').setIndex('Formulation', 'Newtonian', 0);
model.physics('pt').create('for1', 'Force', 3);
model.physics('pt').feature('for1').selection.all;
model.physics('pt').feature('for1').set('F', {'e_const*(Bz*pt.vy-By*pt.vz)' 'e_const*(-Bz*pt.vx+Bx*pt.vz)' 'e_const*(By*pt.vx-Bx*pt.vy)'});

model.study.create('std3');
model.study('std3').create('time', 'Transient');
model.study('std3').feature('time').setSolveFor('/physics/pt', true);
model.study('std3').feature('time').set('tlist', 'range(0,5.0e-8,2.0e-5)');
model.study('std3').feature('time').set('usertol', true);
model.study('std3').feature('time').set('rtol', 1.0E-6);
model.study('std3').label('Newtonian Study');

model.sol.create('sol3');
model.sol('sol3').study('std3');
model.sol('sol3').create('st1', 'StudyStep');
model.sol('sol3').feature('st1').set('study', 'std3');
model.sol('sol3').feature('st1').set('studystep', 'time');
model.sol('sol3').create('v1', 'Variables');
model.sol('sol3').feature('v1').set('control', 'time');
model.sol('sol3').create('t1', 'Time');
model.sol('sol3').feature('t1').set('tlist', 'range(0,5.0e-8,2.0e-5)');
model.sol('sol3').feature('t1').set('plot', 'off');
model.sol('sol3').feature('t1').set('plotgroup', 'pg1');
model.sol('sol3').feature('t1').set('plotfreq', 'tout');
model.sol('sol3').feature('t1').set('probesel', 'all');
model.sol('sol3').feature('t1').set('probes', {});
model.sol('sol3').feature('t1').set('probefreq', 'tsteps');
model.sol('sol3').feature('t1').set('rtol', 1.0E-5);
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
model.sol('sol3').runAll;

model.result.dataset.create('part3', 'Particle');
model.result.dataset('part3').set('solution', 'sol3');
model.result.dataset('part3').set('posdof', {'comp1.qx' 'comp1.qy' 'comp1.qz'});
model.result.dataset('part3').set('geom', 'geom1');
model.result.dataset('part3').set('pgeom', 'pgeom_pt');
model.result.dataset('part3').set('pgeomspec', 'fromphysics');
model.result.dataset('part3').set('physicsinterface', 'pt');
model.result.create('pg3', 'PlotGroup3D');
model.result('pg3').set('data', 'part3');
model.result('pg3').setIndex('looplevel', 401, 0);
model.result('pg3').label('Particle Trajectories (pt)');
model.result('pg3').create('traj1', 'ParticleTrajectories');
model.result('pg3').feature('traj1').set('pointtype', 'point');
model.result('pg3').feature('traj1').set('linetype', 'none');
model.result('pg3').feature('traj1').create('col1', 'Color');
model.result('pg3').feature('traj1').feature('col1').set('expr', 'pt.V');
model.result('pg3').run;
model.result('pg3').label('Newtonian Results');
model.result('pg3').set('edges', false);
model.result('pg3').run;
model.result('pg3').feature('traj1').set('linetype', 'ribbon');
model.result('pg3').feature('traj1').set('widthscaleactive', true);
model.result('pg3').feature('traj1').set('widthscale', '4E-5');
model.result('pg3').feature('traj1').set('pointtype', 'none');
model.result('pg3').run;
model.result('pg3').feature('traj1').feature('col1').set('expr', 'qy/2');
model.result('pg3').feature('traj1').feature('col1').set('colortable', 'Inferno');
model.result('pg3').run;
model.result.numerical.create('par4', 'Particle');
model.result.numerical('par4').set('data', 'part3');
model.result.numerical('par4').setIndex('looplevelinput', 'first', 0);
model.result.numerical('par4').set('expr', 'timemax(0,2E-5,qy)/2');
model.result.numerical('par4').set('table', 'tbl1');
model.result.numerical('par4').appendResult;

model.physics('pt').prop('Formulation').setIndex('Formulation', 'NewtonianFirstOrder', 0);

model.study.create('std4');
model.study('std4').create('time', 'Transient');
model.study('std4').feature('time').setSolveFor('/physics/pt', true);
model.study('std4').feature('time').set('tlist', 'range(0,5.0e-8,2.0e-5)');
model.study('std4').feature('time').set('usertol', true);
model.study('std4').feature('time').set('rtol', 1.0E-6);
model.study('std4').label('Newtonian, First Order Study');

model.sol.create('sol4');
model.sol('sol4').study('std4');
model.sol('sol4').create('st1', 'StudyStep');
model.sol('sol4').feature('st1').set('study', 'std4');
model.sol('sol4').feature('st1').set('studystep', 'time');
model.sol('sol4').create('v1', 'Variables');
model.sol('sol4').feature('v1').set('control', 'time');
model.sol('sol4').create('t1', 'Time');
model.sol('sol4').feature('t1').set('tlist', 'range(0,5.0e-8,2.0e-5)');
model.sol('sol4').feature('t1').set('plot', 'off');
model.sol('sol4').feature('t1').set('plotgroup', 'pg1');
model.sol('sol4').feature('t1').set('plotfreq', 'tout');
model.sol('sol4').feature('t1').set('probesel', 'all');
model.sol('sol4').feature('t1').set('probes', {});
model.sol('sol4').feature('t1').set('probefreq', 'tsteps');
model.sol('sol4').feature('t1').set('rtol', 1.0E-5);
model.sol('sol4').feature('t1').set('atolglobalvaluemethod', 'factor');
model.sol('sol4').feature('t1').set('reacf', true);
model.sol('sol4').feature('t1').set('storeudot', true);
model.sol('sol4').feature('t1').set('rkmethod', 'dopri5');
model.sol('sol4').feature('t1').set('tstepsdopri5', 'strict');
model.sol('sol4').feature('t1').set('endtimeinterpolation', true);
model.sol('sol4').feature('t1').set('timemethod', 'rk');
model.sol('sol4').feature('t1').set('estrat', 'exclude');
model.sol('sol4').feature('t1').set('control', 'time');
model.sol('sol4').feature('t1').create('fc1', 'FullyCoupled');
model.sol('sol4').feature('t1').feature('fc1').set('ntolfact', 0.1);
model.sol('sol4').feature('t1').create('d1', 'Direct');
model.sol('sol4').feature('t1').feature('d1').set('linsolver', 'pardiso');
model.sol('sol4').feature('t1').feature('fc1').set('linsolver', 'd1');
model.sol('sol4').feature('t1').feature('fc1').set('ntolfact', 0.1);
model.sol('sol4').feature('t1').feature.remove('fcDef');
model.sol('sol4').attach('std4');
model.sol('sol4').runAll;

model.result.dataset.create('part4', 'Particle');
model.result.dataset('part4').set('solution', 'sol4');
model.result.dataset('part4').set('posdof', {'comp1.qx' 'comp1.qy' 'comp1.qz'});
model.result.dataset('part4').set('geom', 'geom1');
model.result.dataset('part4').set('pgeom', 'pgeom_pt');
model.result.dataset('part4').set('pgeomspec', 'fromphysics');
model.result.dataset('part4').set('physicsinterface', 'pt');
model.result.create('pg4', 'PlotGroup3D');
model.result('pg4').set('data', 'part4');
model.result('pg4').setIndex('looplevel', 401, 0);
model.result('pg4').label('Particle Trajectories (pt)');
model.result('pg4').create('traj1', 'ParticleTrajectories');
model.result('pg4').feature('traj1').set('pointtype', 'point');
model.result('pg4').feature('traj1').set('linetype', 'none');
model.result('pg4').feature('traj1').create('col1', 'Color');
model.result('pg4').feature('traj1').feature('col1').set('expr', 'pt.V');
model.result('pg4').run;
model.result('pg4').label('Newtonian, First Order Results');
model.result('pg4').set('edges', false);
model.result('pg4').run;
model.result('pg4').feature('traj1').set('linetype', 'ribbon');
model.result('pg4').feature('traj1').set('widthscaleactive', true);
model.result('pg4').feature('traj1').set('widthscale', '4E-5');
model.result('pg4').feature('traj1').set('pointtype', 'none');
model.result('pg4').run;
model.result('pg4').feature('traj1').feature('col1').set('expr', 'qy/2');
model.result('pg4').feature('traj1').feature('col1').set('colortable', 'Inferno');
model.result('pg4').run;
model.result.numerical.create('par5', 'Particle');
model.result.numerical('par5').set('data', 'part4');
model.result.numerical('par5').setIndex('looplevelinput', 'first', 0);
model.result.numerical('par5').set('expr', 'timemax(0,2E-5,qy)/2');
model.result.numerical('par5').set('table', 'tbl1');
model.result.numerical('par5').appendResult;
model.result('pg3').run;

model.title('Ion Cyclotron Motion');

model.description('This example uses the Newtonian (first- and second-order), Lagrangian, and Hamiltonian formulations to compute the trajectory of a charged particle in a uniform magnetic field. This benchmark computes the Larmor radius and compares it to the analytical solution. The same result is obtained for all formulations.');

model.mesh.clearMeshes;

model.sol('sol1').clearSolutionData;
model.sol('sol2').clearSolutionData;
model.sol('sol3').clearSolutionData;
model.sol('sol4').clearSolutionData;

model.label('ion_cyclotron_motion.mph');

model.modelNode.label('Components');

out = model;
