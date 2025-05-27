function out = model
%
% laminar_mixer_particle.m
%
% Model exported on May 26 2025, 21:31 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/Particle_Tracing_Module/Fluid_Flow');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 3);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.physics.create('spf', 'LaminarFlow', 'geom1');
model.physics('spf').model('comp1');

model.study.create('std1');
model.study('std1').create('stat', 'Stationary');
model.study('std1').feature('stat').setSolveFor('/physics/spf', true);

model.geom('geom1').insertFile('laminar_mixer_particle_geom_sequence.mph', 'geom1');

model.param.set('u_av', '1[cm/s]');
model.param.descr('u_av', 'Mean velocity');

model.selection.create('sel1', 'Explicit');
model.selection('sel1').model('comp1');

model.geom('geom1').run;

model.selection('sel1').label('Outer Surfaces');
model.selection('sel1').geom(2);
model.selection('sel1').set('groupcontang', true);
model.selection('sel1').add([1 8 19 20 21 22 23 48 49 50 57 58]);
model.selection.create('sel2', 'Explicit');
model.selection('sel2').model('comp1');
model.selection('sel2').label('Blade Surfaces');
model.selection('sel2').geom(2);
model.selection('sel2').set([2 3 4 5 6 7 9 10 11 12 13 14 15 16 17 18 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40 41 42 43 44 45 46 47 51 52 53 54 55 56]);

model.material.create('mat1', 'Common', 'comp1');
model.material('mat1').propertyGroup('def').set('density', {'1000'});
model.material('mat1').propertyGroup('def').set('dynamicviscosity', {'1e-3'});

model.physics('spf').create('inl1', 'InletBoundary', 2);
model.physics('spf').feature('inl1').selection.set([23]);
model.physics('spf').feature('inl1').set('BoundaryCondition', 'FullyDevelopedFlow');
model.physics('spf').feature('inl1').set('Uavfdf', 'u_av');
model.physics('spf').create('out1', 'OutletBoundary', 2);
model.physics('spf').feature('out1').selection.set([20]);

model.mesh('mesh1').create('ftri1', 'FreeTri');

model.view('view1').set('renderwireframe', true);

model.mesh('mesh1').feature('ftri1').selection.set([5 16 17 18 53 54 55]);
model.mesh('mesh1').feature('ftri1').create('size1', 'Size');
model.mesh('mesh1').feature('ftri1').feature('size1').set('table', 'cfd');
model.mesh('mesh1').feature('ftri1').feature('size1').set('hauto', 1);
model.mesh('mesh1').feature('size').set('hauto', 1);
model.mesh('mesh1').feature('size').set('custom', true);
model.mesh('mesh1').feature('size').set('hcurve', 0.15);
model.mesh('mesh1').create('ftri2', 'FreeTri');
model.mesh('mesh1').feature('ftri2').selection.set([23]);
model.mesh('mesh1').feature('ftri2').create('size1', 'Size');
model.mesh('mesh1').feature('ftri2').feature('size1').set('table', 'cfd');
model.mesh('mesh1').feature('ftri2').feature('size1').set('hauto', 2);
model.mesh('mesh1').create('ftet1', 'FreeTet');
model.mesh('mesh1').run;

model.sol.create('sol1');

model.mesh('mesh1').stat.selection.geom(3);
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
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('pr').feature('sc1').set('scgsrelax', 0.7);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('pr').feature('sc1').set('scgsmethod', 'lines');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('pr').feature('sc1').set('scgsvertexrelax', 0.7);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('pr').feature('sc1').set('relax', 0.5);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('pr').feature('sc1').set('vankavarsactive', 'on');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('pr').feature('sc1').set('vankavars', {'comp1_spf_inl1_Pinlfdf'});
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('pr').feature('sc1').set('scgssolv', 'stored');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('pr').feature('sc1').set('approxscgs', true);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('pr').feature('sc1').set('scgsdirectmaxsize', 1000);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('po').create('sc1', 'SCGS');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('po').feature('sc1').set('linesweeptype', 'ssor');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('po').feature('sc1').set('iter', 1);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('po').feature('sc1').set('scgsrelax', 0.7);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('po').feature('sc1').set('scgsmethod', 'lines');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('po').feature('sc1').set('scgsvertexrelax', 0.7);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('po').feature('sc1').set('relax', 0.5);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('po').feature('sc1').set('vankavarsactive', 'on');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('po').feature('sc1').set('vankavars', {'comp1_spf_inl1_Pinlfdf'});
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('po').feature('sc1').set('scgssolv', 'stored');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('po').feature('sc1').set('approxscgs', true);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('po').feature('sc1').set('scgsdirectmaxsize', 1000);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('cs').create('d1', 'Direct');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('cs').feature('d1').set('linsolver', 'pardiso');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('cs').feature('d1').set('pivotperturb', 1.0E-13);
model.sol('sol1').feature('s1').create('d1', 'Direct');
model.sol('sol1').feature('s1').feature('d1').set('linsolver', 'pardiso');
model.sol('sol1').feature('s1').feature('d1').set('pivotperturb', 1.0E-13);
model.sol('sol1').feature('s1').feature('d1').label('Direct, fluid flow variables (spf)');
model.sol('sol1').feature('s1').feature('fc1').set('linsolver', 'i1');
model.sol('sol1').feature('s1').feature('fc1').set('dtech', 'auto');
model.sol('sol1').feature('s1').feature('fc1').set('initstep', 0.01);
model.sol('sol1').feature('s1').feature('fc1').set('minstep', 1.0E-4);
model.sol('sol1').feature('s1').feature('fc1').set('maxiter', 100);
model.sol('sol1').feature('s1').feature.remove('fcDef');
model.sol('sol1').attach('std1');
model.sol('sol1').runAll;

model.result.dataset('dset1').set('geom', 'geom1');
model.result.create('pg1', 'PlotGroup3D');
model.result('pg1').label('Velocity (spf)');
model.result('pg1').set('frametype', 'spatial');
model.result('pg1').set('data', 'dset1');
model.result('pg1').set('defaultPlotID', 'ResultDefaults_SinglePhaseFlow/icom1/pdef1/pcond2/pg1');
model.result('pg1').feature.create('slc1', 'Slice');
model.result('pg1').feature('slc1').label('Slice');
model.result('pg1').feature('slc1').set('showsolutionparams', 'on');
model.result('pg1').feature('slc1').set('smooth', 'internal');
model.result('pg1').feature('slc1').set('showsolutionparams', 'on');
model.result('pg1').feature('slc1').set('data', 'parent');
model.result.dataset.create('surf1', 'Surface');
model.result.dataset('surf1').label('Exterior Walls');
model.result.dataset('surf1').set('data', 'dset1');
model.result.dataset('surf1').selection.geom('geom1', 2);
model.result.dataset('surf1').selection.set([1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 21 22 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40 41 42 43 44 45 46 47 48 49 50 51 52 53 54 55 56 57 58]);
model.result.create('pg2', 'PlotGroup3D');
model.result('pg2').label('Pressure (spf)');
model.result('pg2').set('data', 'surf1');
model.result('pg2').set('frametype', 'spatial');
model.result('pg2').set('data', 'surf1');
model.result('pg2').set('defaultPlotID', 'ResultDefaults_SinglePhaseFlow/icom1/pdef1/pcond2/pcond2/pcond1/pg4');
model.result('pg2').feature.create('surf1', 'Surface');
model.result('pg2').feature('surf1').label('Surface');
model.result('pg2').feature('surf1').set('showsolutionparams', 'on');
model.result('pg2').feature('surf1').set('expr', 'p');
model.result('pg2').feature('surf1').set('colortable', 'Dipole');
model.result('pg2').feature('surf1').set('smooth', 'internal');
model.result('pg2').feature('surf1').set('showsolutionparams', 'on');
model.result('pg2').feature('surf1').set('data', 'parent');
model.result('pg2').feature('surf1').feature.create('tran1', 'Transparency');
model.result('pg1').run;

model.physics.create('fpt', 'FluidParticleTracing', 'geom1');
model.physics('fpt').model('comp1');

model.study('std1').feature('stat').setSolveFor('/physics/fpt', false);
model.study.create('std2');
model.study('std2').create('time', 'Transient');
model.study('std2').feature('time').setSolveFor('/physics/spf', false);
model.study('std2').feature('time').setSolveFor('/physics/fpt', true);

model.physics('fpt').prop('Formulation').setIndex('Formulation', 'NewtonianIgnoreInertialTerms', 0);
model.physics('fpt').create('df1', 'DragForce', 3);
model.physics('fpt').feature('df1').selection.all;
model.physics('fpt').feature('df1').set('u_src', 'root.comp1.u');
model.physics('fpt').feature('df1').set('mu_mat', 'root.comp1.spf.mu');
model.physics('fpt').feature('df1').set('IncludeVirtualMassAndPressureGradientForces', true);
model.physics('fpt').create('inl1', 'Inlet', 2);
model.physics('fpt').feature('inl1').selection.set([23]);
model.physics('fpt').feature('inl1').set('InitialPosition', 'Density');
model.physics('fpt').feature('inl1').setIndex('N', 3000, 0);
model.physics('fpt').feature('inl1').set('dpro', 'spf.U');
model.physics('fpt').create('pcnt1', 'ParticleCounter', 2);
model.physics('fpt').feature('pcnt1').selection.set([20]);
model.physics('fpt').feature('pcnt1').set('ReleaseFeature', 'inl1');
model.physics('fpt').feature('pp1').set('rhop_mat', 'userdef');
model.physics('fpt').feature('pp1').set('dp', '5E-7[m]');

model.study('std2').feature('time').set('tlist', 'range(0,0.2,5)');
model.study('std2').feature('time').set('usertol', true);
model.study('std2').feature('time').set('rtol', '1e-3');
model.study('std2').feature('time').set('usesol', true);
model.study('std2').feature('time').set('notsolmethod', 'sol');
model.study('std2').feature('time').set('notstudy', 'std1');

model.sol.create('sol2');

model.mesh('mesh1').stat.selection.geom(3);
model.mesh('mesh1').stat.selection.set([1]);

model.sol('sol2').study('std2');
model.sol('sol2').create('st1', 'StudyStep');
model.sol('sol2').feature('st1').set('study', 'std2');
model.sol('sol2').feature('st1').set('studystep', 'time');
model.sol('sol2').create('v1', 'Variables');
model.sol('sol2').feature('v1').set('control', 'time');
model.sol('sol2').create('t1', 'Time');
model.sol('sol2').feature('t1').set('tlist', 'range(0,0.2,5)');
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
model.result.dataset('part1').set('posdof', {'comp1.qx' 'comp1.qy' 'comp1.qz'});
model.result.dataset('part1').set('geom', 'geom1');
model.result.dataset('part1').set('pgeom', 'pgeom_fpt');
model.result.dataset('part1').set('pgeomspec', 'fromphysics');
model.result.dataset('part1').set('physicsinterface', 'fpt');
model.result.create('pg3', 'PlotGroup3D');
model.result('pg3').set('data', 'part1');
model.result('pg3').setIndex('looplevel', 26, 0);
model.result('pg3').label('Particle Trajectories (fpt)');
model.result('pg3').create('traj1', 'ParticleTrajectories');
model.result('pg3').feature('traj1').set('pointtype', 'point');
model.result('pg3').feature('traj1').set('linetype', 'none');
model.result('pg3').feature('traj1').create('col1', 'Color');
model.result('pg3').feature('traj1').feature('col1').set('expr', 'fpt.V');
model.result('pg3').run;
model.result('pg3').set('showlegends', false);
model.result('pg3').set('titletype', 'none');
model.result('pg3').create('surf1', 'Surface');
model.result('pg3').feature('surf1').set('expr', '1');
model.result('pg3').feature('surf1').set('coloring', 'uniform');
model.result('pg3').feature('surf1').set('color', 'black');
model.result('pg3').feature('surf1').create('sel1', 'Selection');
model.result('pg3').feature('surf1').feature('sel1').selection.named('sel2');
model.result('pg3').run;
model.result('pg3').create('surf2', 'Surface');
model.result('pg3').feature('surf2').set('expr', '1');
model.result('pg3').feature('surf2').set('coloring', 'uniform');
model.result('pg3').feature('surf2').set('color', 'gray');
model.result('pg3').feature('surf2').create('sel1', 'Selection');
model.result('pg3').feature('surf2').feature('sel1').selection.named('sel1');
model.result('pg3').run;
model.result('pg3').feature('surf2').create('tran1', 'Transparency');
model.result('pg3').run;
model.result('pg3').feature('surf2').feature('tran1').set('uniformblending', 1);
model.result('pg3').run;
model.result('pg3').feature('traj1').set('pointtype', 'comettail');
model.result('pg3').run;
model.result('pg3').feature('traj1').feature('col1').set('expr', 'at(0,qx<0)');
model.result('pg3').feature('traj1').feature('col1').set('colortable', 'RainbowLight');
model.result('pg3').run;
model.result('pg3').run;
model.result('pg3').setIndex('looplevel', 1, 0);
model.result('pg3').run;
model.result('pg3').setIndex('looplevel', 6, 0);
model.result('pg3').run;
model.result('pg3').setIndex('looplevel', 11, 0);
model.result('pg3').run;
model.result('pg3').setIndex('looplevel', 16, 0);
model.result('pg3').run;
model.result('pg3').setIndex('looplevel', 21, 0);
model.result('pg3').run;
model.result('pg3').setIndex('looplevel', 26, 0);
model.result('pg3').run;
model.result.duplicate('pg4', 'pg3');
model.result('pg4').run;
model.result('pg4').run;
model.result('pg4').feature('traj1').set('pointtype', 'none');
model.result('pg4').feature('traj1').set('linetype', 'line');
model.result('pg4').run;
model.result('pg4').feature('traj1').feature('col1').set('expr', 'at(0,qx)');
model.result('pg4').feature('traj1').feature('col1').set('colortable', 'Dipole');
model.result('pg4').run;
model.result.numerical.create('gev1', 'EvalGlobal');
model.result.numerical('gev1').set('data', 'dset2');
model.result.numerical('gev1').setIndex('looplevelinput', 'last', 0);
model.result.numerical('gev1').set('expr', {'fpt.pcnt1.alpha'});
model.result.numerical('gev1').set('descr', {'Transmission probability'});
model.result.numerical('gev1').set('unit', {'1'});
model.result.table.create('tbl1', 'Table');
model.result.table('tbl1').comments('Global Evaluation 1');
model.result.numerical('gev1').set('table', 'tbl1');
model.result.numerical('gev1').setResult;
model.result.dataset.create('cpl1', 'CutPlane');
model.result.dataset('cpl1').set('data', 'part1');
model.result.dataset('cpl1').set('quickplane', 'xz');
model.result.dataset('cpl1').set('quicky', 0.006);
model.result.dataset('cpl1').set('genparaactive', true);
model.result.dataset('cpl1').set('genparadist', '0.006 0.016 0.026 0.036 0.042');
model.result.create('pg5', 'PlotGroup3D');
model.result('pg5').run;
model.result('pg5').label(['Poincar' native2unicode(hex2dec({'00' 'e9'}), 'unicode') ' Maps']);
model.result('pg5').set('data', 'part1');
model.result('pg5').set('titletype', 'none');
model.result('pg5').create('poma1', 'PoincareMap');
model.result('pg5').feature('poma1').set('data', 'cpl1');
model.result('pg5').feature('poma1').set('sphereradiusscaleactive', true);
model.result('pg5').feature('poma1').set('sphereradiusscale', 0.4);
model.result('pg5').run;
model.result('pg5').feature('poma1').create('col1', 'Color');
model.result('pg5').run;
model.result('pg5').feature('poma1').feature('col1').set('expr', 'at(0,qx<0)');
model.result('pg5').feature('poma1').feature('col1').set('colortable', 'RainbowLight');
model.result('pg5').feature('poma1').feature('col1').set('colorlegend', false);
model.result('pg5').run;
model.result('pg5').create('surf1', 'Surface');
model.result('pg5').feature('surf1').set('data', 'cpl1');
model.result('pg5').feature('surf1').set('expr', '1');
model.result('pg5').feature('surf1').set('coloring', 'uniform');
model.result('pg5').feature('surf1').set('color', 'gray');
model.result('pg5').run;
model.result.create('pg6', 'PlotGroup2D');
model.result('pg6').run;
model.result('pg6').label('Phase Portrait');
model.result('pg6').set('edges', false);
model.result('pg6').set('data', 'part1');
model.result('pg6').create('phpo1', 'PhasePortrait');
model.result('pg6').feature('phpo1').set('xdata', 'manual');
model.result('pg6').feature('phpo1').set('xmanual', 'comp1.qx');
model.result('pg6').feature('phpo1').set('ydata', 'manual');
model.result('pg6').feature('phpo1').set('ymanual', 'comp1.qz');
model.result('pg6').feature('phpo1').create('col1', 'Color');
model.result('pg6').run;
model.result('pg6').feature('phpo1').feature('col1').set('colorlegend', false);
model.result('pg6').feature('phpo1').feature('col1').set('expr', 'at(0,qx<0)');
model.result('pg6').feature('phpo1').feature('col1').set('colortable', 'RainbowLight');
model.result('pg6').run;
model.result('pg6').run;
model.result('pg6').set('view', 'view2');
model.result('pg6').run;
model.result('pg6').setIndex('looplevel', 1, 0);
model.result('pg6').run;
model.result('pg6').setIndex('looplevel', 6, 0);
model.result('pg6').run;
model.result('pg6').setIndex('looplevel', 11, 0);
model.result('pg6').run;
model.result('pg6').setIndex('looplevel', 16, 0);
model.result('pg6').run;
model.result('pg6').setIndex('looplevel', 21, 0);
model.result('pg6').run;
model.result('pg6').setIndex('looplevel', 26, 0);
model.result('pg6').run;

model.title('Particle Trajectories in a Laminar Static Mixer');

model.description('This example computes the trajectories of quartz particles through a static mixing device. The inertia of the particles causes some of them to collide with the channel walls or the mixing blades, so that only a certain fraction of the particles reach the outlet. This fraction, the transmission probability, is computed during postprocessing.');

model.mesh.clearMeshes;

model.sol('sol1').clearSolutionData;
model.sol('sol2').clearSolutionData;

model.label('laminar_mixer_particle.mph');

model.modelNode.label('Components');

out = model;
