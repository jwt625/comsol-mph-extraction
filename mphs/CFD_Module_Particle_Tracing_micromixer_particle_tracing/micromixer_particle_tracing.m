function out = model
%
% micromixer_particle_tracing.m
%
% Model exported on May 26 2025, 21:26 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/CFD_Module/Particle_Tracing');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 2);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.physics.create('spf', 'LaminarFlow', 'geom1');
model.physics('spf').model('comp1');
model.physics.create('fpt', 'FluidParticleTracing', 'geom1');
model.physics('fpt').model('comp1');

model.common.create('rot1', 'RotatingDomain', 'comp1');
model.common('rot1').set('rotationType', 'rotationalVelocity');
model.common('rot1').set('rotationalVelocityExpression', 'generalRevolutionsPerTime');
model.common('rot1').selection.all;

model.study.create('std1');
model.study('std1').create('time', 'Transient');
model.study('std1').feature('time').setSolveFor('/physics/spf', true);
model.study('std1').feature('time').setSolveFor('/physics/fpt', true);

model.geom('geom1').lengthUnit('mm');
model.geom('geom1').create('c1', 'Circle');
model.geom('geom1').feature('c1').set('r', 3);
model.geom('geom1').runPre('fin');
model.geom('geom1').create('c2', 'Circle');
model.geom('geom1').feature('c2').set('r', 2.75);
model.geom('geom1').runPre('fin');
model.geom('geom1').create('dif1', 'Difference');
model.geom('geom1').feature('dif1').selection('input').set({'c1'});
model.geom('geom1').feature('dif1').selection('input2').set({'c2'});
model.geom('geom1').feature('dif1').set('keepsubtract', true);
model.geom('geom1').runPre('fin');
model.geom('geom1').create('r1', 'Rectangle');
model.geom('geom1').feature('r1').set('size', [0.2 5.25]);
model.geom('geom1').feature('r1').set('base', 'center');
model.geom('geom1').runPre('fin');
model.geom('geom1').create('r2', 'Rectangle');
model.geom('geom1').feature('r2').set('size', [5.25 0.2]);
model.geom('geom1').feature('r2').set('base', 'center');
model.geom('geom1').runPre('fin');
model.geom('geom1').create('r3', 'Rectangle');
model.geom('geom1').feature('r3').set('size', [1 0.5]);
model.geom('geom1').feature('r3').set('pos', [-3.4 0]);
model.geom('geom1').feature('r3').set('base', 'center');
model.geom('geom1').runPre('fin');
model.geom('geom1').create('rot1', 'Rotate');
model.geom('geom1').feature('rot1').selection('input').set({'r3'});
model.geom('geom1').feature('rot1').set('rot', '90 180 270');
model.geom('geom1').feature('rot1').set('keep', true);
model.geom('geom1').runPre('fin');
model.geom('geom1').create('uni1', 'Union');
model.geom('geom1').feature('uni1').selection('input').set({'dif1' 'r3' 'rot1'});
model.geom('geom1').feature('uni1').set('intbnd', false);
model.geom('geom1').runPre('fin');
model.geom('geom1').create('dif2', 'Difference');
model.geom('geom1').feature('dif2').selection('input').set({'c2'});
model.geom('geom1').feature('dif2').selection('input2').set({'r1' 'r2'});
model.geom('geom1').runPre('fin');
model.geom('geom1').feature('fin').set('action', 'assembly');
model.geom('geom1').run('fin');

model.selection.create('sel1', 'Explicit');
model.selection('sel1').model('comp1');
model.selection('sel1').label('Pair boundaries');
model.selection('sel1').geom(1);
model.selection('sel1').set([15 16 17 18 33 34 35 36]);

model.func.create('rm1', 'Ramp');
model.func('rm1').model('comp1');
model.func('rm1').set('slope', 100);
model.func('rm1').set('cutoffactive', true);
model.func('rm1').set('smoothzonecutoffactive', true);
model.func('rm1').set('smoothzonecutoff', 0.001);

model.variable.create('var1');
model.variable('var1').model('comp1');
model.variable('var1').set('uin', '0.02[m/s]*rm1(t[1/s])');
model.variable('var1').descr('uin', 'Inlet velocity');

model.material.create('mat1', 'Common', 'comp1');
model.material('mat1').propertyGroup('def').set('density', {'1E3'});
model.material('mat1').propertyGroup('def').set('dynamicviscosity', {'1E-3'});

model.common('rot1').selection.set([2]);
model.common('rot1').set('revolutionsPerTime', 1);

model.physics('spf').create('inl1', 'InletBoundary', 1);
model.physics('spf').feature('inl1').selection.set([1 5 12]);
model.physics('spf').feature('inl1').set('U0in', 'uin');
model.physics('spf').create('out1', 'OutletBoundary', 1);
model.physics('spf').feature('out1').selection.set([7]);
model.physics('fpt').feature('wall1').set('WallCondition', 'Bounce');
model.physics('fpt').create('df1', 'DragForce', 2);
model.physics('fpt').feature('df1').selection.all;
model.physics('fpt').feature('df1').set('u_src', 'root.comp1.u');
model.physics('fpt').feature('df1').set('mu_mat', 'root.comp1.spf.mu');
model.physics('fpt').feature('df1').set('IncludeVirtualMassAndPressureGradientForces', true);
model.physics('fpt').create('inl1', 'Inlet', 1);
model.physics('fpt').feature('inl1').selection.set([1]);
model.physics('fpt').feature('inl1').set('InitialPosition', 'UniformDistribution');
model.physics('fpt').feature('inl1').setIndex('N', 50, 0);
model.physics('fpt').feature('inl1').set('u_src', 'root.comp1.u');
model.physics('fpt').feature('inl1').setIndex('rt', 'range(0,0.05,1)', 0);
model.physics('fpt').feature.duplicate('inl2', 'inl1');
model.physics('fpt').feature('inl2').selection.set([5]);
model.physics('fpt').feature.duplicate('inl3', 'inl2');
model.physics('fpt').feature('inl3').selection.set([12]);
model.physics('fpt').create('out1', 'Outlet', 1);
model.physics('fpt').feature('out1').selection.set([7]);
model.physics('fpt').feature('pp1').set('rhop_mat', 'userdef');
model.physics('fpt').feature('pp1').set('dp', '10[um]');

model.mesh('mesh1').create('edg1', 'Edge');
model.mesh('mesh1').feature('edg1').selection.all;
model.mesh('mesh1').feature('edg1').create('size1', 'Size');
model.mesh('mesh1').feature('edg1').feature('size1').set('hauto', 2);
model.mesh('mesh1').create('ftri1', 'FreeTri');
model.mesh('mesh1').feature('size').set('hauto', 3);
model.mesh('mesh1').run;

model.study('std1').feature('time').set('tlist', 'range(0,0.02,2)');
model.study('std1').feature('time').set('usertol', true);

model.sol.create('sol1');

model.mesh('mesh1').stat.selection.geom(2);
model.mesh('mesh1').stat.selection.set([1 2]);

model.sol('sol1').study('std1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'time');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').feature('comp1_ode1').set('scalemethod', 'manual');
model.sol('sol1').feature('v1').feature('comp1_ode1').set('scaleval', '1');
model.sol('sol1').feature('v1').set('control', 'time');
model.sol('sol1').create('t1', 'Time');
model.sol('sol1').feature('t1').set('tlist', 'range(0,0.02,2)');
model.sol('sol1').feature('t1').set('plot', 'off');
model.sol('sol1').feature('t1').set('plotgroup', 'Default');
model.sol('sol1').feature('t1').set('plotfreq', 'tout');
model.sol('sol1').feature('t1').set('probesel', 'all');
model.sol('sol1').feature('t1').set('probes', {});
model.sol('sol1').feature('t1').set('probefreq', 'tsteps');
model.sol('sol1').feature('t1').set('rtol', 1.0E-5);
model.sol('sol1').feature('t1').set('atolglobalmethod', 'scaled');
model.sol('sol1').feature('t1').set('atolglobalfactor', 0.05);
model.sol('sol1').feature('t1').set('atolglobalvaluemethod', 'factor');
model.sol('sol1').feature('t1').set('atolmethod', {'comp1_p' 'scaled' 'comp1_qfpt' 'global' 'comp1_u' 'global' 'comp1_ode1' 'global'});
model.sol('sol1').feature('t1').set('atolvaluemethod', {'comp1_p' 'factor' 'comp1_qfpt' 'factor' 'comp1_u' 'factor' 'comp1_ode1' 'factor'});
model.sol('sol1').feature('t1').set('atolfactor', {'comp1_p' '1' 'comp1_qfpt' '0.1' 'comp1_u' '0.1' 'comp1_ode1' '0.1'});
model.sol('sol1').feature('t1').set('reacf', true);
model.sol('sol1').feature('t1').set('storeudot', true);
model.sol('sol1').feature('t1').set('tstepsgenalpha', 'strict');
model.sol('sol1').feature('t1').set('endtimeinterpolation', true);
model.sol('sol1').feature('t1').set('timemethod', 'genalpha');
model.sol('sol1').feature('t1').set('estrat', 'exclude');
model.sol('sol1').feature('t1').set('rhoinf', 0.5);
model.sol('sol1').feature('t1').set('predictor', 'constant');
model.sol('sol1').feature('t1').set('maxorder', 2);
model.sol('sol1').feature('t1').set('stabcntrl', true);
model.sol('sol1').feature('t1').set('bwinitstepfrac', '0.01');
model.sol('sol1').feature('t1').set('control', 'time');
model.sol('sol1').feature('t1').feature('aDef').set('cachepattern', true);
model.sol('sol1').feature('t1').create('seDef', 'Segregated');
model.sol('sol1').feature('t1').create('se1', 'Segregated');
model.sol('sol1').feature('t1').feature('se1').feature.remove('ssDef');
model.sol('sol1').feature('t1').feature('se1').create('ss1', 'SegregatedStep');
model.sol('sol1').feature('t1').feature('se1').feature('ss1').set('segvar', {'comp1_qfpt'});
model.sol('sol1').feature('t1').feature('se1').feature('ss1').set('subdamp', 0.8);
model.sol('sol1').feature('t1').feature('se1').feature('ss1').set('subjtech', 'once');
model.sol('sol1').feature('t1').create('d1', 'Direct');
model.sol('sol1').feature('t1').feature('d1').label('Direct (Merged)');
model.sol('sol1').feature('t1').feature('se1').feature('ss1').set('linsolver', 'd1');
model.sol('sol1').feature('t1').feature('se1').feature('ss1').label('Particle Tracing for Fluid Flow');
model.sol('sol1').feature('t1').feature('se1').create('ss2', 'SegregatedStep');
model.sol('sol1').feature('t1').feature('se1').feature('ss2').set('segvar', {'comp1_ode1'});
model.sol('sol1').feature('t1').feature('se1').feature('ss2').set('subdamp', 1);
model.sol('sol1').feature('t1').feature('se1').feature('ss2').set('subntolfact', 0.1);
model.sol('sol1').feature('t1').feature('se1').feature('ss2').set('subjtech', 'onevery');
model.sol('sol1').feature('t1').feature('se1').feature('ss2').set('subtermconst', 'iter');
model.sol('sol1').feature('t1').feature('se1').feature('ss2').set('subiter', 1);
model.sol('sol1').feature('t1').create('d2', 'Direct');
model.sol('sol1').feature('t1').feature('d2').set('linsolver', 'pardiso');
model.sol('sol1').feature('t1').feature('d2').set('pivotperturb', 1.0E-13);
model.sol('sol1').feature('t1').feature('d2').label('Direct, angular displacement (spf)');
model.sol('sol1').feature('t1').feature('se1').feature('ss2').set('linsolver', 'd2');
model.sol('sol1').feature('t1').feature('se1').feature('ss2').label('Angular Displacement');
model.sol('sol1').feature('t1').feature('se1').create('ss3', 'SegregatedStep');
model.sol('sol1').feature('t1').feature('se1').feature('ss3').set('segvar', {'comp1_u' 'comp1_p'});
model.sol('sol1').feature('t1').feature('se1').feature('ss3').set('subdamp', 0.8);
model.sol('sol1').feature('t1').feature('se1').feature('ss3').set('subjtech', 'once');
model.sol('sol1').feature('t1').create('d3', 'Direct');
model.sol('sol1').feature('t1').feature('d3').set('linsolver', 'pardiso');
model.sol('sol1').feature('t1').feature('d3').set('pivotperturb', 1.0E-13);
model.sol('sol1').feature('t1').feature('d3').label('Direct, fluid flow variables (spf)');
model.sol('sol1').feature('t1').feature('se1').feature('ss3').set('linsolver', 'd3');
model.sol('sol1').feature('t1').feature('se1').feature('ss3').label('Velocity u, Pressure p');
model.sol('sol1').feature('t1').feature('se1').set('ntolfact', 0.5);
model.sol('sol1').feature('t1').feature('se1').set('maxsegiter', 10);
model.sol('sol1').feature('t1').feature('se1').set('segstabacc', 'segaacc');
model.sol('sol1').feature('t1').feature('se1').set('segaaccdim', 5);
model.sol('sol1').feature('t1').feature('se1').set('segaaccdelay', 0);
model.sol('sol1').feature('t1').feature('se1').set('segaaccmix', 0.9);
model.sol('sol1').feature('t1').create('i1', 'Iterative');
model.sol('sol1').feature('t1').feature('i1').set('linsolver', 'gmres');
model.sol('sol1').feature('t1').feature('i1').set('prefuntype', 'left');
model.sol('sol1').feature('t1').feature('i1').set('itrestart', 50);
model.sol('sol1').feature('t1').feature('i1').set('rhob', 20);
model.sol('sol1').feature('t1').feature('i1').set('maxlinit', 100);
model.sol('sol1').feature('t1').feature('i1').set('nlinnormuse', 'on');
model.sol('sol1').feature('t1').feature('i1').label('AMG, fluid flow variables (spf)');
model.sol('sol1').feature('t1').feature('i1').create('mg1', 'Multigrid');
model.sol('sol1').feature('t1').feature('i1').feature('mg1').set('prefun', 'saamg');
model.sol('sol1').feature('t1').feature('i1').feature('mg1').set('mgcycle', 'v');
model.sol('sol1').feature('t1').feature('i1').feature('mg1').set('maxcoarsedof', 80000);
model.sol('sol1').feature('t1').feature('i1').feature('mg1').set('strconn', 0.02);
model.sol('sol1').feature('t1').feature('i1').feature('mg1').set('nullspace', 'constant');
model.sol('sol1').feature('t1').feature('i1').feature('mg1').set('usesmooth', false);
model.sol('sol1').feature('t1').feature('i1').feature('mg1').set('saamgcompwise', true);
model.sol('sol1').feature('t1').feature('i1').feature('mg1').set('loweramg', true);
model.sol('sol1').feature('t1').feature('i1').feature('mg1').set('compactaggregation', false);
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('pr').create('sc1', 'SCGS');
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('pr').feature('sc1').set('linesweeptype', 'ssor');
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('pr').feature('sc1').set('iter', 0);
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('pr').feature('sc1').set('scgsrelax', 0.7);
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('pr').feature('sc1').set('scgsmethod', 'lines');
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('pr').feature('sc1').set('scgsvertexrelax', 0.7);
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('pr').feature('sc1').set('relax', 0.5);
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('pr').feature('sc1').set('scgssolv', 'stored');
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('pr').feature('sc1').set('approxscgs', true);
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('pr').feature('sc1').set('scgsdirectmaxsize', 1000);
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('po').create('sc1', 'SCGS');
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('po').feature('sc1').set('linesweeptype', 'ssor');
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('po').feature('sc1').set('iter', 1);
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('po').feature('sc1').set('scgsrelax', 0.7);
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('po').feature('sc1').set('scgsmethod', 'lines');
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('po').feature('sc1').set('scgsvertexrelax', 0.7);
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('po').feature('sc1').set('relax', 0.5);
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('po').feature('sc1').set('scgssolv', 'stored');
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('po').feature('sc1').set('approxscgs', true);
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('po').feature('sc1').set('scgsdirectmaxsize', 1000);
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('cs').create('d1', 'Direct');
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('cs').feature('d1').set('linsolver', 'pardiso');
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('cs').feature('d1').set('pivotperturb', 1.0E-13);
model.sol('sol1').feature('t1').feature.remove('fcDef');
model.sol('sol1').feature('t1').feature.remove('seDef');
model.sol('sol1').attach('std1');
model.sol('sol1').runAll;

model.result.dataset('dset1').set('geom', 'geom1');
model.result.create('pg1', 'PlotGroup2D');
model.result('pg1').label('Velocity (spf)');
model.result('pg1').set('frametype', 'spatial');
model.result('pg1').set('data', 'dset1');
model.result('pg1').setIndex('looplevel', 101, 0);
model.result('pg1').set('defaultPlotID', 'ResultDefaults_SinglePhaseFlow/icom1/pdef1/pcond1/pg1');
model.result('pg1').feature.create('surf1', 'Surface');
model.result('pg1').feature('surf1').label('Surface');
model.result('pg1').feature('surf1').set('showsolutionparams', 'on');
model.result('pg1').feature('surf1').set('smooth', 'internal');
model.result('pg1').feature('surf1').set('showsolutionparams', 'on');
model.result('pg1').feature('surf1').set('data', 'parent');
model.result.create('pg2', 'PlotGroup2D');
model.result('pg2').label('Pressure (spf)');
model.result('pg2').set('frametype', 'spatial');
model.result('pg2').set('data', 'dset1');
model.result('pg2').setIndex('looplevel', 101, 0);
model.result('pg2').set('defaultPlotID', 'ResultDefaults_SinglePhaseFlow/icom1/pdef1/pcond1/pg2');
model.result('pg2').feature.create('con1', 'Contour');
model.result('pg2').feature('con1').label('Contour');
model.result('pg2').feature('con1').set('showsolutionparams', 'on');
model.result('pg2').feature('con1').set('expr', 'p');
model.result('pg2').feature('con1').set('number', 40);
model.result('pg2').feature('con1').set('levelrounding', false);
model.result('pg2').feature('con1').set('smooth', 'internal');
model.result('pg2').feature('con1').set('showsolutionparams', 'on');
model.result('pg2').feature('con1').set('data', 'parent');
model.result.dataset.create('part1', 'Particle');
model.result.dataset('part1').set('solution', 'sol1');
model.result.dataset('part1').set('posdof', {'comp1.qx' 'comp1.qy'});
model.result.dataset('part1').set('geom', 'geom1');
model.result.dataset('part1').set('pgeom', 'pgeom_fpt');
model.result.dataset('part1').set('pgeomspec', 'fromphysics');
model.result.dataset('part1').set('physicsinterface', 'fpt');
model.result.create('pg3', 'PlotGroup2D');
model.result('pg3').set('data', 'part1');
model.result('pg3').setIndex('looplevel', 101, 0);
model.result('pg3').label('Particle Trajectories (fpt)');
model.result('pg3').create('traj1', 'ParticleTrajectories');
model.result('pg3').feature('traj1').set('pointtype', 'point');
model.result('pg3').feature('traj1').set('linetype', 'none');
model.result('pg3').feature('traj1').create('col1', 'Color');
model.result('pg3').feature('traj1').feature('col1').set('expr', 'fpt.V');
model.result('pg1').run;
model.result('pg3').run;
model.result('pg3').run;
model.result('pg3').run;
model.result('pg3').feature('traj1').feature('col1').set('expr', 'fpt.prf');
model.result('pg3').feature('traj1').feature('col1').set('descr', 'Particle release feature');
model.result('pg3').run;

model.view('view1').hideEntities.create('hide1');
model.view('view1').hideEntities('hide1').geom('geom1', 1);
model.view('view1').hideEntities('hide1').named('sel1');

model.result('pg3').run;
model.result('pg3').setIndex('looplevel', 11, 0);
model.result('pg3').run;
model.result('pg3').setIndex('looplevel', 21, 0);
model.result('pg3').run;
model.result('pg3').setIndex('looplevel', 31, 0);
model.result('pg3').run;
model.result('pg3').setIndex('looplevel', 41, 0);
model.result('pg3').run;
model.result('pg3').setIndex('looplevel', 51, 0);
model.result('pg3').run;
model.result('pg3').setIndex('looplevel', 101, 0);
model.result('pg3').run;

model.title('Particle Tracing in a Micromixer');

model.description('This example simulates the mixing of particles in a rotating micromixer. The mixer contains 3 distinct inlets and an outlet. The Rotating Machinery interface is used to model the fluid flow and the Particle Tracing for Fluid Flow interface is used to compute the particle trajectories.');

model.mesh.clearMeshes;

model.sol('sol1').clearSolutionData;

model.label('micromixer_particle_tracing.mph');

model.modelNode.label('Components');

out = model;
