function out = model
%
% inertial_focusing.m
%
% Model exported on May 26 2025, 21:31 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/Particle_Tracing_Module/Fluid_Flow');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 2);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.physics.create('spf', 'LaminarFlow', 'geom1');
model.physics('spf').model('comp1');

model.study.create('std1');
model.study('std1').create('stat', 'Stationary');
model.study('std1').feature('stat').setSolveFor('/physics/spf', true);

% To import content from file, use:
% model.param.loadFile('FILENAME');
model.param.set('dp', '1.21[mm]', 'Particle diameter');
model.param.set('muf', '2.98[P]', 'Fluid dynamic viscosity');
model.param.set('Vav', '44.87[cm/s]', 'Average channel velocity');
model.param.set('d', '11.2[mm]', 'Channel width');
model.param.set('L', 'd*1000', 'Channel length');
model.param.set('rhof', '1.178[g/cm^3]', 'Fluid and particle density');

model.variable.create('var1');
model.variable('var1').model('comp1');

model.geom('geom1').run;

model.variable('var1').set('dn', 'abs(qy/d-0.5)');
model.variable('var1').descr('dn', 'Normalized distance from center');
model.variable('var1').set('dnave', 'fpt.ave(dn)');
model.variable('var1').descr('dnave', 'Normalized distance, average');
model.variable('var1').set('dnstd', 'sqrt(fpt.ave(dn^2)-fpt.ave(dn)^2)');
model.variable('var1').descr('dnstd', 'Normalized distance, standard deviation');

model.view('view1').axis.set('viewscaletype', 'automatic');

model.geom('geom1').lengthUnit('cm');
model.geom('geom1').create('r1', 'Rectangle');
model.geom('geom1').feature('r1').set('size', {'L' 'd'});
model.geom('geom1').runPre('fin');
model.geom('geom1').run;

model.material.create('mat1', 'Common', 'comp1');
model.material('mat1').propertyGroup('def').set('density', {'rhof'});
model.material('mat1').propertyGroup('def').set('dynamicviscosity', {'muf'});

model.physics('spf').prop('ShapeProperty').set('order_fluid', 2);
model.physics('spf').create('inl1', 'InletBoundary', 1);
model.physics('spf').feature('inl1').selection.set([1]);
model.physics('spf').feature('inl1').set('BoundaryCondition', 'FullyDevelopedFlow');
model.physics('spf').feature('inl1').set('Uavfdf', 'Vav');
model.physics('spf').create('out1', 'OutletBoundary', 1);
model.physics('spf').feature('out1').selection.set([4]);
model.physics('spf').create('prpc1', 'PressurePointConstraint', 0);
model.physics('spf').feature('prpc1').selection.set([3]);
model.physics.create('fpt', 'FluidParticleTracing', 'geom1');
model.physics('fpt').model('comp1');

model.study('std1').feature('stat').setSolveFor('/physics/fpt', false);

model.physics('fpt').feature('pp1').set('rhop_mat', 'userdef');
model.physics('fpt').feature('pp1').set('rhop', 'rhof');
model.physics('fpt').feature('pp1').set('dp', 'dp');
model.physics('fpt').create('inl1', 'Inlet', 1);
model.physics('fpt').feature('inl1').selection.set([1]);
model.physics('fpt').feature('inl1').set('InitialPosition', 'Density');
model.physics('fpt').feature('inl1').setIndex('N', 200, 0);
model.physics('fpt').feature('inl1').set('dpro', 'y>0.1*d&&y<0.9*d');
model.physics('fpt').feature('inl1').set('u_src', 'root.comp1.u');
model.physics('fpt').create('out1', 'Outlet', 1);
model.physics('fpt').feature('out1').selection.set([4]);
model.physics('fpt').create('lf1', 'LiftForce', 2);
model.physics('fpt').feature('lf1').selection.all;
model.physics('fpt').feature('lf1').set('LiftLaw', 'WallInduced');
model.physics('fpt').feature('lf1').set('u_src', 'root.comp1.u');
model.physics('fpt').feature('lf1').set('mu_mat', 'root.comp1.spf.mu');
model.physics('fpt').feature('lf1').selection('ParallelBoundary1').set([2]);
model.physics('fpt').feature('lf1').selection('ParallelBoundary2').set([3]);
model.physics('fpt').create('df1', 'DragForce', 2);
model.physics('fpt').feature('df1').selection.all;
model.physics('fpt').feature('df1').set('u_src', 'root.comp1.u');
model.physics('fpt').feature('df1').set('mu_mat', 'root.comp1.spf.mu');
model.physics('fpt').feature('df1').set('IncludeWallCorrections', true);

model.mesh('mesh1').create('map1', 'Map');
model.mesh('mesh1').feature('map1').create('dis1', 'Distribution');
model.mesh('mesh1').feature('map1').feature('dis1').selection.set([1 4]);
model.mesh('mesh1').feature('map1').feature('dis1').set('type', 'predefined');
model.mesh('mesh1').feature('map1').feature('dis1').set('elemcount', 20);
model.mesh('mesh1').feature('map1').feature('dis1').set('elemratio', 4);
model.mesh('mesh1').feature('map1').feature('dis1').set('symmetric', true);

model.study('std1').create('time', 'Transient');
model.study('std1').feature('time').setEntry('activate', 'spf', false);
model.study('std1').feature('time').set('tlist', 'range(0,0.2,30)');

model.sol.create('sol1');

model.mesh('mesh1').stat.selection.geom(2);
model.mesh('mesh1').stat.selection.set([1]);
model.mesh('mesh1').stat.selection.geom(2);
model.mesh('mesh1').stat.selection.set([1]);

model.sol('sol1').study('std1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'stat');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').set('control', 'stat');
model.sol('sol1').create('s1', 'Stationary');
model.sol('sol1').feature('s1').feature('aDef').set('cachepattern', true);
model.sol('sol1').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('s1').feature('fc1').set('dtech', 'auto');
model.sol('sol1').feature('s1').feature('fc1').set('initstep', 0.01);
model.sol('sol1').feature('s1').feature('fc1').set('minstep', 1.0E-4);
model.sol('sol1').feature('s1').feature('fc1').set('maxiter', 100);
model.sol('sol1').feature('s1').create('d1', 'Direct');
model.sol('sol1').feature('s1').feature('d1').set('linsolver', 'pardiso');
model.sol('sol1').feature('s1').feature('d1').set('pivotperturb', 1.0E-13);
model.sol('sol1').feature('s1').feature('d1').label('Direct, fluid flow variables (spf)');
model.sol('sol1').feature('s1').create('i1', 'Iterative');
model.sol('sol1').feature('s1').feature('i1').set('linsolver', 'gmres');
model.sol('sol1').feature('s1').feature('i1').set('prefuntype', 'left');
model.sol('sol1').feature('s1').feature('i1').set('itrestart', 50);
model.sol('sol1').feature('s1').feature('i1').set('rhob', 20);
model.sol('sol1').feature('s1').feature('i1').set('maxlinit', 1000);
model.sol('sol1').feature('s1').feature('i1').set('nlinnormuse', 'on');
model.sol('sol1').feature('s1').feature('i1').label('AMG, fluid flow variables (spf)');
model.sol('sol1').feature('s1').feature('i1').create('mg1', 'Multigrid');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').set('prefun', 'saamg');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').set('mgcycle', 'v');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').set('maxcoarsedof', 80000);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').set('strconn', 0.02);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').set('nullspace', 'constant');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').set('usesmooth', false);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').set('saamgcompwise', true);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').set('loweramg', true);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').set('compactaggregation', false);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('pr').create('sc1', 'SCGS');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('pr').feature('sc1').set('linesweeptype', 'ssor');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('pr').feature('sc1').set('iter', 0);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('pr').feature('sc1').set('scgsrelax', 0.4);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('pr').feature('sc1').set('scgsmethod', 'lines');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('pr').feature('sc1').set('scgsvertexrelax', 0.7);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('pr').feature('sc1').set('relax', 0.4);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('pr').feature('sc1').set('vankavarsactive', 'on');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('pr').feature('sc1').set('vankavars', {'comp1_spf_inl1_Pinlfdf'});
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('pr').feature('sc1').set('scgssolv', 'stored');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('pr').feature('sc1').set('approxscgs', true);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('pr').feature('sc1').set('scgsdirectmaxsize', 1000);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('po').create('sc1', 'SCGS');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('po').feature('sc1').set('linesweeptype', 'ssor');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('po').feature('sc1').set('iter', 1);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('po').feature('sc1').set('scgsrelax', 0.4);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('po').feature('sc1').set('scgsmethod', 'lines');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('po').feature('sc1').set('scgsvertexrelax', 0.7);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('po').feature('sc1').set('relax', 0.4);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('po').feature('sc1').set('vankavarsactive', 'on');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('po').feature('sc1').set('vankavars', {'comp1_spf_inl1_Pinlfdf'});
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('po').feature('sc1').set('scgssolv', 'stored');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('po').feature('sc1').set('approxscgs', true);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('po').feature('sc1').set('scgsdirectmaxsize', 1000);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('cs').create('d1', 'Direct');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('cs').feature('d1').set('linsolver', 'pardiso');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('cs').feature('d1').set('pivotperturb', 1.0E-13);
model.sol('sol1').feature('s1').feature('fc1').set('linsolver', 'd1');
model.sol('sol1').feature('s1').feature('fc1').set('dtech', 'auto');
model.sol('sol1').feature('s1').feature('fc1').set('initstep', 0.01);
model.sol('sol1').feature('s1').feature('fc1').set('minstep', 1.0E-4);
model.sol('sol1').feature('s1').feature('fc1').set('maxiter', 100);
model.sol('sol1').feature('s1').feature.remove('fcDef');
model.sol('sol1').create('su1', 'StoreSolution');
model.sol('sol1').create('st2', 'StudyStep');
model.sol('sol1').feature('st2').set('study', 'std1');
model.sol('sol1').feature('st2').set('studystep', 'time');
model.sol('sol1').create('v2', 'Variables');
model.sol('sol1').feature('v2').set('initmethod', 'sol');
model.sol('sol1').feature('v2').set('initsol', 'sol1');
model.sol('sol1').feature('v2').set('initsoluse', 'sol2');
model.sol('sol1').feature('v2').set('notsolmethod', 'sol');
model.sol('sol1').feature('v2').set('notsol', 'sol1');
model.sol('sol1').feature('v2').set('notsoluse', 'sol2');
model.sol('sol1').feature('v2').set('control', 'time');
model.sol('sol1').create('t1', 'Time');
model.sol('sol1').feature('t1').set('tlist', 'range(0,0.2,30)');
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

model.result.dataset('dset1').set('geom', 'geom1');
model.result.create('pg1', 'PlotGroup2D');
model.result('pg1').label('Velocity (spf)');
model.result('pg1').set('frametype', 'spatial');
model.result('pg1').set('data', 'dset1');
model.result('pg1').setIndex('looplevel', 151, 0);
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
model.result('pg2').setIndex('looplevel', 151, 0);
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
model.result('pg3').setIndex('looplevel', 151, 0);
model.result('pg3').label('Particle Trajectories (fpt)');
model.result('pg3').create('traj1', 'ParticleTrajectories');
model.result('pg3').feature('traj1').set('pointtype', 'point');
model.result('pg3').feature('traj1').set('linetype', 'none');
model.result('pg3').feature('traj1').create('col1', 'Color');
model.result('pg3').feature('traj1').feature('col1').set('expr', 'fpt.V');
model.result('pg1').run;
model.result('pg3').run;
model.result('pg3').run;
model.result('pg3').feature('traj1').set('linetype', 'line');
model.result('pg3').run;
model.result('pg3').feature('traj1').feature('col1').set('expr', 'fpt.vy');
model.result('pg3').feature('traj1').feature('col1').set('unit', 'mm/s');
model.result('pg3').feature('traj1').feature('col1').set('colortable', 'DipoleDark');
model.result('pg3').run;
model.result.create('pg4', 'PlotGroup1D');
model.result('pg4').run;
model.result('pg4').label('Mean');
model.result('pg4').set('data', 'part1');
model.result('pg4').set('titletype', 'none');
model.result('pg4').set('showlegends', false);
model.result('pg4').create('glob1', 'Global');
model.result('pg4').feature('glob1').set('markerpos', 'datapoints');
model.result('pg4').feature('glob1').set('linewidth', 'preference');
model.result('pg4').feature('glob1').setIndex('expr', 'dnave', 0);
model.result('pg4').feature('glob1').setIndex('descr', 'Normalized distance from center, average', 0);
model.result('pg4').run;
model.result.create('pg5', 'PlotGroup1D');
model.result('pg5').run;
model.result('pg5').label('Standard Deviation');
model.result('pg5').set('data', 'part1');
model.result('pg5').set('titletype', 'none');
model.result('pg5').set('showlegends', false);
model.result('pg5').create('glob1', 'Global');
model.result('pg5').feature('glob1').set('markerpos', 'datapoints');
model.result('pg5').feature('glob1').set('linewidth', 'preference');
model.result('pg5').feature('glob1').setIndex('expr', 'dnstd', 0);
model.result('pg5').feature('glob1').setIndex('descr', 'Normalized distance from center, standard deviation', 0);
model.result('pg5').run;
model.result('pg3').run;
model.result('pg3').run;

model.title('Inertial Focusing Between Two Parallel Walls');

model.description(['For more than 50' native2unicode(hex2dec({'00' 'a0'}), 'unicode') 'years, it has been known that neutrally buoyant particles in a flow channel tend to converge to specific locations in the channel cross section. For a cylindrical pipe, or two parallel planes carrying a Poiseuille flow, the equilibrium position is about 0.6' native2unicode(hex2dec({'00' 'a0'}), 'unicode') 'times the pipe radius, or a distance from parallel walls of about 0.2' native2unicode(hex2dec({'00' 'a0'}), 'unicode') 'times the channel width, respectively. This is called the Segre' native2unicode(hex2dec({'20' '13'}), 'unicode') 'Silberberg effect, while a ring of particles with a radius of 0.6' native2unicode(hex2dec({'00' 'a0'}), 'unicode') 'times the pipe radius is sometimes called the Segre' native2unicode(hex2dec({'20' '13'}), 'unicode') 'Silberberg annulus.' newline  newline 'In this benchmark model, we reproduce the case of a flow channel bounded by two parallel walls. Wall-dependent lift and drag forces are exerted on the neutrally buoyant particles as they are carried along the channel by a parabolic fluid velocity profile. As particles are carried through the channel, the inertial lift force causes them to reach equilibrium positions at distances from the center of 0.3 D, where D is the distance between the walls. These equilibrium positions are consistent with the Segre' native2unicode(hex2dec({'20' '13'}), 'unicode') 'Silberberg effect.']);

model.mesh.clearMeshes;

model.sol('sol1').clearSolutionData;
model.sol('sol2').clearSolutionData;

model.label('inertial_focusing.mph');

model.modelNode.label('Components');

out = model;
