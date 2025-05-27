function out = model
%
% three_body_problem.m
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

model.physics.create('pt', 'MathParticle', 'geom1');
model.physics('pt').model('comp1');

model.study.create('std1');
model.study('std1').create('time', 'Transient');
model.study('std1').feature('time').setSolveFor('/physics/pt', true);

% To import content from file, use:
% model.param.loadFile('FILENAME');
model.param.set('mass', '1.989e30[kg]', 'Star mass');
model.param.set('gravity', 'G_const', 'Gravitation constant');
model.param.set('au', '149597870700[m]', 'Astronomical unit');
model.param.set('distance', '30*au', 'Initial distance between stars');
model.param.set('tilt', '-14.06884013142[deg]', 'Tilt angle for figure-8 configuration');
model.param.set('x1', 'distance*cos(tilt)', 'Star 1 initial x-coordinate');
model.param.set('y1', 'distance*sin(tilt)', 'Star 1 initial y-coordinate');
model.param.set('x2', '-x1', 'Star 2 initial x-coordinate');
model.param.set('y2', '-y1', 'Star 2 initial y-coordinate');
model.param.set('x3', '0', 'Star 3 initial x-coordinate');
model.param.set('y3', '0', 'Star 3 initial y-coordinate');
model.param.set('u1', '-u3/2', 'Star 1 initial velocity, x-component');
model.param.set('v1', '-v3/2', 'Star 1 initial velocity, y-component');
model.param.set('u2', '-u3/2', 'Star 2 initial velocity, x-component');
model.param.set('v2', '-v3/2', 'Star 2 initial velocity, y-component');
model.param.set('u3', '-0.93240737*sqrt(mass*gravity/distance)', 'Star 3 initial velocity, x-component');
model.param.set('v3', '-0.86473146*sqrt(mass*gravity/distance)', 'Star 3 initial velocity, y-component');
model.param.set('T1', '6.32591398*sqrt(distance^3/(mass*gravity))', 'Orbital period, figure 8 configuration');
model.param.set('x4', 'distance*cos(0[deg])', 'Star 4 initial x-coordinate');
model.param.set('y4', 'distance*sin(0[deg])', 'Star 4 initial y-coordinate');
model.param.set('x5', 'distance*cos(120[deg])', 'Star 5 initial x-coordinate');
model.param.set('y5', 'distance*sin(120[deg])', 'Star 5 initial y-coordinate');
model.param.set('x6', 'distance*cos(240[deg])', 'Star 6 initial x-coordinate');
model.param.set('y6', 'distance*sin(240[deg])', 'Star 6 initial y-coordinate');
model.param.set('V_Lagrange', 'sqrt(gravity*mass/distance)/(3^0.25)', 'Initial speed, Lagrange configuration');
model.param.set('u4', '-V_Lagrange*sin(0[deg])', 'Star 4 initial velocity, x-component');
model.param.set('v4', 'V_Lagrange*cos(0[deg])', 'Star 4 initial velocity, y-component');
model.param.set('u5', '-V_Lagrange*sin(120[deg])', 'Star 5 initial velocity, x-component');
model.param.set('v5', 'V_Lagrange*cos(120[deg])', 'Star 5 initial velocity, y-component');
model.param.set('u6', '-V_Lagrange*sin(240[deg])', 'Star 6 initial velocity, x-component');
model.param.set('v6', 'V_Lagrange*cos(240[deg])', 'Star 6 initial velocity, y-component');
model.param.set('T2', '2*pi*distance/V_Lagrange', 'Orbital period, Lagrange configuration');

model.variable.create('var1');
model.variable('var1').model('comp1');

model.geom('geom1').run;

model.variable('var1').set('KE', 'pt.Epsum');
model.variable('var1').descr('KE', 'Kinetic energy');
model.variable('var1').set('arg1', 'pt.pidx>dest(pt.pidx)');
model.variable('var1').descr('arg1', 'Argument 1');
model.variable('var1').set('arg2', '-gravity*pt.mp*dest(pt.mp)/pt.r');
model.variable('var1').descr('arg2', 'Argument 2');
model.variable('var1').set('ifExpr', 'if(arg1,arg2,0)');
model.variable('var1').descr('ifExpr', 'Conditional expression');
model.variable('var1').set('PE', 'pt.sum(pt.sum(ifExpr))');
model.variable('var1').descr('PE', 'Potential energy');
model.variable('var1').set('TE', 'KE+PE');
model.variable('var1').descr('TE', 'Total energy');
model.variable('var1').set('TE_err', '(TE-at(0,TE))/at(0,TE)');
model.variable('var1').descr('TE_err', 'Total energy, relative error');

model.geom('geom1').create('c1', 'Circle');
model.geom('geom1').feature('c1').set('r', '2*distance');
model.geom('geom1').runPre('fin');
model.geom('geom1').run;

model.physics('pt').prop('Formulation').setIndex('Formulation', 'NewtonianFirstOrder', 0);
model.physics('pt').feature('pp1').set('mp', 'mass');
model.physics('pt').create('ppi1', 'ParticleParticleInteraction', 2);
model.physics('pt').feature('ppi1').selection.all;
model.physics('pt').feature('ppi1').set('InteractionForce', 'UserDefined');
model.physics('pt').feature('ppi1').set('Fu', {'gravity*pt.mp*dest(pt.mp)*(qx-dest(qx))/pt.r^3' 'gravity*pt.mp*dest(pt.mp)*(qy-dest(qy))/pt.r^3' '0'});
model.physics('pt').create('relg1', 'ReleaseGrid', -1);
model.physics('pt').feature('relg1').setIndex('x0', 'x1', 0);
model.physics('pt').feature('relg1').setIndex('x0', 'y1', 1);
model.physics('pt').feature('relg1').set('v0', {'u1' 'v1' '0'});
model.physics('pt').create('relg2', 'ReleaseGrid', -1);
model.physics('pt').feature('relg2').setIndex('x0', 'x2', 0);
model.physics('pt').feature('relg2').setIndex('x0', 'y2', 1);
model.physics('pt').feature('relg2').set('v0', {'u2' 'v2' '0'});
model.physics('pt').create('relg3', 'ReleaseGrid', -1);
model.physics('pt').feature('relg3').setIndex('x0', 'x3', 0);
model.physics('pt').feature('relg3').setIndex('x0', 'y3', 1);
model.physics('pt').feature('relg3').set('v0', {'u3' 'v3' '0'});
model.physics('pt').create('relg4', 'ReleaseGrid', -1);
model.physics('pt').feature('relg4').setIndex('x0', 'x4', 0);
model.physics('pt').feature('relg4').setIndex('x0', 'y4', 1);
model.physics('pt').feature('relg4').set('v0', {'u4' 'v4' '0'});
model.physics('pt').create('relg5', 'ReleaseGrid', -1);
model.physics('pt').feature('relg5').setIndex('x0', 'x5', 0);
model.physics('pt').feature('relg5').setIndex('x0', 'y5', 1);
model.physics('pt').feature('relg5').set('v0', {'u5' 'v5' '0'});
model.physics('pt').create('relg6', 'ReleaseGrid', -1);
model.physics('pt').feature('relg6').setIndex('x0', 'x6', 0);
model.physics('pt').feature('relg6').setIndex('x0', 'y6', 1);
model.physics('pt').feature('relg6').set('v0', {'u6' 'v6' '0'});

model.study('std1').label('Study 1: Figure-Eight Configuration');
model.study('std1').feature('time').set('tlist', 'range(0,T1/100,10*T1)');
model.study('std1').feature('time').set('usertol', true);
model.study('std1').feature('time').set('rtol', '1E-10');
model.study('std1').feature('time').set('useadvanceddisable', true);
model.study('std1').feature('time').set('disabledphysics', {'pt/relg4' 'pt/relg5' 'pt/relg6'});

model.sol.create('sol1');
model.sol('sol1').study('std1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'time');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').set('control', 'time');
model.sol('sol1').create('t1', 'Time');
model.sol('sol1').feature('t1').set('tlist', 'range(0,T1/100,10*T1)');
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
model.sol('sol1').feature('t1').set('rkmethod', 'dopri5');
model.sol('sol1').feature('t1').set('tstepsdopri5', 'strict');
model.sol('sol1').feature('t1').set('endtimeinterpolation', true);
model.sol('sol1').feature('t1').set('timemethod', 'rk');
model.sol('sol1').feature('t1').set('estrat', 'exclude');
model.sol('sol1').feature('t1').set('control', 'time');
model.sol('sol1').feature('t1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('t1').feature('fc1').set('ntolfact', 0.1);
model.sol('sol1').feature('t1').create('d1', 'Direct');
model.sol('sol1').feature('t1').feature('d1').set('linsolver', 'pardiso');
model.sol('sol1').feature('t1').feature('fc1').set('linsolver', 'd1');
model.sol('sol1').feature('t1').feature('fc1').set('ntolfact', 0.1);
model.sol('sol1').feature('t1').feature.remove('fcDef');
model.sol('sol1').attach('std1');
model.sol('sol1').runAll;

model.result.dataset.create('part1', 'Particle');
model.result.dataset('part1').set('solution', 'sol1');
model.result.dataset('part1').set('posdof', {'comp1.qx' 'comp1.qy'});
model.result.dataset('part1').set('geom', 'geom1');
model.result.dataset('part1').set('pgeom', 'pgeom_pt');
model.result.dataset('part1').set('pgeomspec', 'fromphysics');
model.result.dataset('part1').set('physicsinterface', 'pt');
model.result.create('pg1', 'PlotGroup2D');
model.result('pg1').set('data', 'part1');
model.result('pg1').setIndex('looplevel', 1001, 0);
model.result('pg1').label('Particle Trajectories (pt)');
model.result('pg1').create('traj1', 'ParticleTrajectories');
model.result('pg1').feature('traj1').set('pointtype', 'point');
model.result('pg1').feature('traj1').set('linetype', 'none');
model.result('pg1').feature('traj1').create('col1', 'Color');
model.result('pg1').feature('traj1').feature('col1').set('expr', 'pt.V');
model.result('pg1').run;
model.result('pg1').label('Figure-Eight Configuration');
model.result('pg1').run;
model.result('pg1').feature('traj1').set('pointtype', 'comettail');
model.result('pg1').feature('traj1').set('linetype', 'line');
model.result('pg1').run;
model.result('pg1').feature('traj1').feature('col1').set('colortable', 'RainbowLight');
model.result('pg1').run;
model.result.export.create('anim1', 'Animation');
model.result.export('anim1').set('target', 'player');
model.result.export('anim1').set('plotgroup', 'pg1');
model.result.export('anim1').run;
model.result.export('anim1').set('maxframes', 300);
model.result.export('anim1').run;
model.result.create('pg2', 'PlotGroup1D');
model.result('pg2').run;
model.result('pg2').label('Check Energy Conservation');
model.result('pg2').create('glob1', 'Global');
model.result('pg2').feature('glob1').set('markerpos', 'datapoints');
model.result('pg2').feature('glob1').set('linewidth', 'preference');
model.result('pg2').feature('glob1').setIndex('expr', 'TE_err', 0);
model.result('pg2').run;

model.study.create('std2');
model.study('std2').create('time', 'Transient');
model.study('std2').feature('time').setSolveFor('/physics/pt', true);
model.study('std2').label('Study 2: Lagrange Configuration');
model.study('std2').feature('time').set('tlist', 'range(0,T2/100,10*T2)');
model.study('std2').feature('time').set('usertol', true);
model.study('std2').feature('time').set('rtol', '1E-10');
model.study('std2').feature('time').set('useadvanceddisable', true);
model.study('std2').feature('time').set('disabledphysics', {'pt/relg1' 'pt/relg2' 'pt/relg3'});

model.sol.create('sol2');
model.sol('sol2').study('std2');
model.sol('sol2').create('st1', 'StudyStep');
model.sol('sol2').feature('st1').set('study', 'std2');
model.sol('sol2').feature('st1').set('studystep', 'time');
model.sol('sol2').create('v1', 'Variables');
model.sol('sol2').feature('v1').set('control', 'time');
model.sol('sol2').create('t1', 'Time');
model.sol('sol2').feature('t1').set('tlist', 'range(0,T2/100,10*T2)');
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
model.sol('sol2').feature('t1').set('rkmethod', 'dopri5');
model.sol('sol2').feature('t1').set('tstepsdopri5', 'strict');
model.sol('sol2').feature('t1').set('endtimeinterpolation', true);
model.sol('sol2').feature('t1').set('timemethod', 'rk');
model.sol('sol2').feature('t1').set('estrat', 'exclude');
model.sol('sol2').feature('t1').set('control', 'time');
model.sol('sol2').feature('t1').create('fc1', 'FullyCoupled');
model.sol('sol2').feature('t1').feature('fc1').set('ntolfact', 0.1);
model.sol('sol2').feature('t1').create('d1', 'Direct');
model.sol('sol2').feature('t1').feature('d1').set('linsolver', 'pardiso');
model.sol('sol2').feature('t1').feature('fc1').set('linsolver', 'd1');
model.sol('sol2').feature('t1').feature('fc1').set('ntolfact', 0.1);
model.sol('sol2').feature('t1').feature.remove('fcDef');
model.sol('sol2').attach('std2');
model.sol('sol2').runAll;

model.result.dataset.create('part2', 'Particle');
model.result.dataset('part2').set('solution', 'sol2');
model.result.dataset('part2').set('posdof', {'comp1.qx' 'comp1.qy'});
model.result.dataset('part2').set('geom', 'geom1');
model.result.dataset('part2').set('pgeom', 'pgeom_pt');
model.result.dataset('part2').set('pgeomspec', 'fromphysics');
model.result.dataset('part2').set('physicsinterface', 'pt');
model.result.create('pg3', 'PlotGroup2D');
model.result('pg3').set('data', 'part2');
model.result('pg3').setIndex('looplevel', 1001, 0);
model.result('pg3').label('Particle Trajectories (pt)');
model.result('pg3').create('traj1', 'ParticleTrajectories');
model.result('pg3').feature('traj1').set('pointtype', 'point');
model.result('pg3').feature('traj1').set('linetype', 'none');
model.result('pg3').feature('traj1').create('col1', 'Color');
model.result('pg3').feature('traj1').feature('col1').set('expr', 'pt.V');
model.result('pg3').run;
model.result('pg3').label('Lagrange Configuration');
model.result('pg3').run;
model.result('pg3').feature('traj1').set('linetype', 'line');
model.result('pg3').feature('traj1').set('pointtype', 'comettail');
model.result('pg3').run;
model.result('pg3').feature('traj1').feature('col1').set('colortable', 'RainbowLight');
model.result('pg3').run;
model.result.export.create('anim2', 'Animation');
model.result.export('anim2').set('target', 'player');
model.result.export('anim2').set('plotgroup', 'pg3');
model.result.export('anim2').run;
model.result.export('anim2').set('maxframes', 300);
model.result.export('anim2').run;

model.title('Three-Body Problem');

model.description('The classical three-body problem involves the prediction of the trajectories of three point masses under mutual gravitational attraction. In general, the three-body problem has no closed-form analytic solution, but it can be solved numerically if the initial conditions are known. In this example, two periodic solutions to the three-body problem are simulated: the figure-eight configuration and the Lagrange configuration.');

model.mesh.clearMeshes;

model.sol('sol1').clearSolutionData;
model.sol('sol2').clearSolutionData;

model.label('three_body_problem.mph');

model.modelNode.label('Components');

out = model;
