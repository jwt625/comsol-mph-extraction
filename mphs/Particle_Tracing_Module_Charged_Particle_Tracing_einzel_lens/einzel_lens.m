function out = model
%
% einzel_lens.m
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

model.physics.create('es', 'Electrostatics', 'geom1');
model.physics('es').model('comp1');

model.study.create('std1');
model.study('std1').create('stat', 'Stationary');
model.study('std1').feature('stat').setSolveFor('/physics/es', true);

% To import content from file, use:
% model.param.loadFile('FILENAME');
model.param.set('V0', '-10[kV]', 'Voltage on inner cylinder');
model.param.set('E0', '20[keV]', 'Kinetic energy of particles');
model.param.set('vx0', 'sqrt(2*E0/me_const)', 'Initial velocity, x-component');
model.param.set('T', 'L_vac/vx0', 'Time for particles to reach end with no force');

model.geom('geom1').insertFile('einzel_lens_geom_sequence.mph', 'geom1');
model.geom('geom1').run('fin');

model.view('view1').set('renderwireframe', true);

model.selection.create('sel1', 'Explicit');
model.selection('sel1').model('comp1');
model.selection('sel1').label('Ground Boundaries');
model.selection('sel1').set([2 4]);
model.selection('sel1').geom('geom1', 3, 2, {'exterior'});
model.selection('sel1').set([2 4]);
model.selection.create('sel2', 'Explicit');
model.selection('sel2').model('comp1');
model.selection('sel2').label('Electrode Boundaries');
model.selection('sel2').set([3]);
model.selection('sel2').geom('geom1', 3, 2, {'exterior'});
model.selection('sel2').set([3]);
model.selection.create('uni1', 'Union');
model.selection('uni1').model('comp1');
model.selection('uni1').label('All Cylinder Surfaces');
model.selection('uni1').set('entitydim', 2);
model.selection('uni1').set('input', {'sel1' 'sel2'});

model.physics('es').selection.set([1]);
model.physics('es').feature('ccn1').set('epsilonr_mat', 'userdef');
model.physics('es').create('gnd1', 'Ground', 2);
model.physics('es').feature('gnd1').label('Grounded Vacuum Chamber Walls');
model.physics('es').feature('gnd1').selection.set([3 4 8 13]);
model.physics('es').create('gnd2', 'Ground', 2);
model.physics('es').feature('gnd2').label('Grounded Cylinders');
model.physics('es').feature('gnd2').selection.named('sel1');
model.physics('es').create('pot1', 'ElectricPotential', 2);
model.physics('es').feature('pot1').selection.named('sel2');
model.physics('es').feature('pot1').set('V0', 'V0');

model.mesh('mesh1').create('size1', 'Size');
model.mesh('mesh1').feature('size1').selection.geom('geom1', 2);
model.mesh('mesh1').feature('size1').selection.named('uni1');
model.mesh('mesh1').feature('size1').set('hauto', 4);
model.mesh('mesh1').create('ftet1', 'FreeTet');
model.mesh('mesh1').feature('ftet1').selection.geom('geom1', 3);
model.mesh('mesh1').feature('ftet1').selection.set([1]);
model.mesh('mesh1').run;

model.study('std1').setGenPlots(false);

model.sol.create('sol1');
model.sol('sol1').study('std1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'stat');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').set('control', 'stat');
model.sol('sol1').create('s1', 'Stationary');
model.sol('sol1').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('s1').create('i1', 'Iterative');
model.sol('sol1').feature('s1').feature('i1').set('linsolver', 'cg');
model.sol('sol1').feature('s1').feature('i1').create('mg1', 'Multigrid');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').set('prefun', 'amg');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').set('coarseningmethod', 'classic');
model.sol('sol1').feature('s1').feature('fc1').set('linsolver', 'i1');
model.sol('sol1').feature('s1').feature.remove('fcDef');
model.sol('sol1').attach('std1');
model.sol('sol1').runAll;

model.result.dataset.create('cpl1', 'CutPlane');
model.result.dataset('cpl1').label('Cut Plane: y=0');
model.result.dataset('cpl1').set('quickplane', 'xz');
model.result.create('pg1', 'PlotGroup3D');
model.result('pg1').run;
model.result('pg1').label('Equipotential Surfaces');
model.result('pg1').set('edges', false);
model.result('pg1').create('con1', 'Contour');
model.result('pg1').feature('con1').set('data', 'cpl1');
model.result('pg1').feature('con1').set('coloring', 'uniform');
model.result('pg1').feature('con1').set('color', 'black');
model.result('pg1').feature('con1').set('colorlegend', false);
model.result('pg1').run;
model.result('pg1').create('iso1', 'Isosurface');
model.result('pg1').feature('iso1').set('number', 20);
model.result('pg1').feature('iso1').set('colortable', 'Viridis');
model.result('pg1').feature('iso1').create('filt1', 'Filter');
model.result('pg1').run;
model.result('pg1').feature('iso1').feature('filt1').set('expr', 'y>0');
model.result('pg1').run;
model.result('pg1').create('surf1', 'Surface');
model.result('pg1').feature('surf1').set('expr', '1');
model.result('pg1').feature('surf1').set('coloring', 'uniform');
model.result('pg1').feature('surf1').set('color', 'gray');
model.result('pg1').feature('surf1').create('sel1', 'Selection');
model.result('pg1').feature('surf1').feature('sel1').selection.named('uni1');
model.result('pg1').run;
model.result.create('pg2', 'PlotGroup2D');
model.result('pg2').run;
model.result('pg2').label('Fringe Field');
model.result('pg2').create('surf1', 'Surface');
model.result('pg2').feature('surf1').set('colortable', 'Viridis');
model.result('pg2').run;
model.result('pg2').create('con1', 'Contour');
model.result('pg2').feature('con1').set('coloring', 'uniform');
model.result('pg2').feature('con1').set('color', 'black');
model.result('pg2').feature('con1').set('colorlegend', false);
model.result('pg2').run;
model.result('pg2').create('arws1', 'ArrowSurface');
model.result('pg2').feature('arws1').set('planecoordsys', 'cartesian');
model.result('pg2').feature('arws1').set('expr', {'es.Ex' 'es.Ey' 'es.Ez'});
model.result('pg2').feature('arws1').set('descr', 'Electric field');
model.result('pg2').feature('arws1').set('arrowxmethod', 'coord');
model.result('pg2').feature('arws1').set('xcoord', 'range(0.42,0.005,0.6)');
model.result('pg2').feature('arws1').set('arrowymethod', 'coord');
model.result('pg2').feature('arws1').set('ycoord', 'range(-0.095,0.005,0.095)');
model.result('pg2').feature('arws1').set('color', 'white');

model.view('view3').axis.set('xmin', 0.35);
model.view('view3').axis.set('xmax', 0.67);
model.view('view3').axis.set('ymin', -0.1);
model.view('view3').axis.set('ymax', 0.1);

model.result('pg2').run;
model.result('pg2').run;

model.physics.create('cpt', 'ChargedParticleTracing', 'geom1');
model.physics('cpt').model('comp1');

model.study('std1').feature('stat').setSolveFor('/physics/cpt', false);

model.physics('cpt').selection.set([1]);
model.physics('cpt').prop('RelativisticCorrection').setIndex('RelativisticCorrection', 1, 0);
model.physics('cpt').create('ef1', 'ElectricForce', 3);
model.physics('cpt').feature('ef1').selection.all;
model.physics('cpt').feature('ef1').set('E_src', 'root.comp1.es.Ex');
model.physics('cpt').feature('ef1').set('UsePPR', true);
model.physics('cpt').create('pbeam1', 'ParticleBeam', 2);
model.physics('cpt').feature('pbeam1').selection.set([5 6 9 10]);
model.physics('cpt').feature('pbeam1').set('e1rms', '5[um]');
model.physics('cpt').feature('pbeam1').set('El', 'E0');

model.study.create('std2');
model.study('std2').create('time', 'Transient');
model.study('std2').feature('time').setSolveFor('/physics/es', false);
model.study('std2').feature('time').setSolveFor('/physics/cpt', true);
model.study('std2').feature('time').set('tlist', 'range(0,T/20,T*1.05)');
model.study('std2').feature('time').set('usesol', true);
model.study('std2').feature('time').set('notsolmethod', 'sol');
model.study('std2').feature('time').set('notstudy', 'std1');

model.sol.create('sol2');
model.sol('sol2').study('std2');
model.sol('sol2').create('st1', 'StudyStep');
model.sol('sol2').feature('st1').set('study', 'std2');
model.sol('sol2').feature('st1').set('studystep', 'time');
model.sol('sol2').create('v1', 'Variables');
model.sol('sol2').feature('v1').set('control', 'time');
model.sol('sol2').create('t1', 'Time');
model.sol('sol2').feature('t1').set('tlist', 'range(0,T/20,T*1.05)');
model.sol('sol2').feature('t1').set('plot', 'off');
model.sol('sol2').feature('t1').set('plotgroup', 'pg1');
model.sol('sol2').feature('t1').set('plotfreq', 'tout');
model.sol('sol2').feature('t1').set('probesel', 'all');
model.sol('sol2').feature('t1').set('probes', {});
model.sol('sol2').feature('t1').set('probefreq', 'tsteps');
model.sol('sol2').feature('t1').set('rtol', 1.0E-7);
model.sol('sol2').feature('t1').set('atolglobalvaluemethod', 'factor');
model.sol('sol2').feature('t1').set('reacf', true);
model.sol('sol2').feature('t1').set('storeudot', true);
model.sol('sol2').feature('t1').set('tstepsgenalpha', 'strict');
model.sol('sol2').feature('t1').set('endtimeinterpolation', true);
model.sol('sol2').feature('t1').set('timemethod', 'genalpha');
model.sol('sol2').feature('t1').set('estrat', 'exclude');
model.sol('sol2').feature('t1').set('initialstepgenalphaactive', true);
model.sol('sol2').feature('t1').set('initialstepgenalpha', '(1.0E-13)[s]');
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
model.result.dataset('part1').set('pgeom', 'pgeom_cpt');
model.result.dataset('part1').set('pgeomspec', 'fromphysics');
model.result.dataset('part1').set('physicsinterface', 'cpt');
model.result.create('pg3', 'PlotGroup3D');
model.result('pg3').set('data', 'part1');
model.result('pg3').setIndex('looplevel', 22, 0);
model.result('pg3').label('Particle Trajectories (cpt)');
model.result('pg3').create('traj1', 'ParticleTrajectories');
model.result('pg3').feature('traj1').set('pointtype', 'point');
model.result('pg3').feature('traj1').set('linetype', 'none');
model.result('pg3').feature('traj1').create('col1', 'Color');
model.result('pg3').feature('traj1').feature('col1').set('expr', 'cpt.V');
model.result.create('pg4', 'PlotGroup3D');
model.result('pg4').set('data', 'part1');
model.result('pg4').setIndex('looplevel', 22, 0);
model.result('pg4').label('Average Beam Position (cpt)');
model.result('pg4').create('pttraj1', 'PointTrajectories');
model.result('pg4').feature('pttraj1').set('plotdata', 'global');
model.result('pg4').feature('pttraj1').set('globalexpr', {'cpt.qavx' 'cpt.qavy' 'cpt.qavz'});
model.result('pg4').feature('pttraj1').create('col1', 'Color');
model.result('pg4').feature('pttraj1').feature('col1').set('expr', 'cpt.e1hrms');
model.result('pg3').run;
model.result('pg3').run;
model.result('pg3').feature('traj1').set('linetype', 'line');
model.result('pg3').feature('traj1').set('pointtype', 'none');
model.result('pg3').run;
model.result('pg3').feature('traj1').feature('col1').set('expr', 'cpt.Ep/E0');
model.result('pg3').feature('traj1').feature('col1').set('colortable', 'Prism');
model.result('pg3').run;
model.result('pg4').run;
model.result('pg4').run;
model.result('pg4').feature('pttraj1').set('linetype', 'tube');
model.result('pg4').run;
model.result('pg4').feature('pttraj1').feature('col1').set('colortable', 'Prism');
model.result('pg4').run;

model.title('Einzel Lens');

model.description(['An Einzel lens is an electrostatic device used for focusing charged particle beams. It may be found in cathode ray tubes, ion beam and electron beam experiments, and ion propulsion systems.' newline  newline 'This particular model consists of three axially aligned cylinders. The outer cylinders are grounded, while the cylinder in the middle is held at a fixed voltage. The 3D electrostatic field is computed with the Electrostatics interface and the particle trajectories are computed using the Charged Particle Tracing interface.']);

model.mesh.clearMeshes;

model.sol('sol1').clearSolutionData;
model.sol('sol2').clearSolutionData;

model.label('einzel_lens.mph');

model.modelNode.label('Components');

out = model;
