function out = model
%
% sensitive_high_resolution_ion_microprobe.m
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

model.geom('geom1').insertFile('sensitive_high_resolution_ion_microprobe_geom_sequence.mph', 'geom1');
model.geom('geom1').run('fin');

model.variable.create('var1');
model.variable('var1').model('comp1');

% To import content from file, use:
% model.variable('var1').loadFile('FILENAME');
model.variable('var1').set('r', 'sqrt((x-xc)^2+(y-yc)^2)', 'Radial distance from electric analyzer bend center');
model.variable('var1').set('xc', '-r0_analyzer', 'Electric analyzer bend center, x-coordinate');
model.variable('var1').set('yc', 'hsample+hentrance+h_analyzer_pre', 'Electric analyzer bend center, y-coordinate');
model.variable('var1').set('theta', 'atan2(y-yc,x-xc)', 'Electric analyzer bend angle');
model.variable('var1').set('Ex', 'E0*cos(theta)', 'Electric analyzer electric field, x-component');
model.variable('var1').set('Ey', 'E0*sin(theta)', 'Electric analyzer electric field, y-component');
model.variable('var1').set('Ez', '0[V/m]', 'Electric analyzer electric field, z-component');
model.variable('var1').set('Bx', '0[T]', 'Magnetic filter magnetic flux density, x-component');
model.variable('var1').set('By', '0[T]', 'Magnetic filter magnetic flux density, y-component');
model.variable('var1').set('Bz', 'B0', 'Magnetic filter magnetic flux density, z-component');

% To import content from file, use:
% model.param.loadFile('FILENAME');
model.param.set('Ei0', '50[eV]', 'Most probable initial energy');
model.param.set('E0', '-2*Ei0/(e_const*r0_analyzer)', 'Electric analyzer electric field norm');
model.param.set('V', 'sqrt(2*Ei0/(Mr*mp_const))', 'Velocity norm at the most probable initial energy');
model.param.set('B0', '-Mr*mp_const*V/e_const/r_magnet', 'Magnetic filter magnetic flux density norm');
model.param.set('Mr', '146', 'Atomic mass');

model.selection.create('sel1', 'Explicit');
model.selection('sel1').model('comp1');
model.selection('sel1').label('Electrostatic Analyzer');
model.selection('sel1').set([6]);
model.selection.create('sel2', 'Explicit');
model.selection('sel2').model('comp1');
model.selection('sel2').label('Magnetic Sector');
model.selection('sel2').set([3]);
model.selection.create('sel3', 'Explicit');
model.selection('sel3').model('comp1');
model.selection('sel3').label('Sample Chamber');
model.selection('sel3').set([8]);
model.selection.create('sel4', 'Explicit');
model.selection('sel4').model('comp1');
model.selection('sel4').label('Detector');
model.selection('sel4').set([1]);
model.selection.create('sel5', 'Explicit');
model.selection('sel5').model('comp1');
model.selection('sel5').label('Filters');
model.selection('sel5').geom(2);
model.selection('sel5').set([5 6 7 8 14 15 16 17 18 19 20 39 40 41 42 43 44 45 46 47 51 52 63 64 65 66 67 68 69 72 75 76 77 78 79 80 83 84 85 86 91 92 93 94]);
model.selection.create('sel6', 'Explicit');
model.selection('sel6').model('comp1');
model.selection('sel6').label('Apertures');
model.selection('sel6').geom(2);
model.selection('sel6').set([23 28 52 80]);

model.view('view1').set('renderwireframe', true);

model.physics('cpt').prop('ParticleReleaseSpecification').setIndex('ParticleReleaseSpecification', 'SpecifyCurrent', 0);
model.physics('cpt').prop('Formulation').setIndex('Formulation', 'NewtonianFirstOrder', 0);
model.physics('cpt').prop('StoreParticleStatusData').setIndex('StoreParticleStatusData', 1, 0);
model.physics('cpt').feature('pp1').set('mp', 'Mr*mp_const');
model.physics('cpt').feature('pp1').set('Z', 1);
model.physics('cpt').create('ef1', 'ElectricForce', 3);
model.physics('cpt').feature('ef1').selection.named('sel1');
model.physics('cpt').feature('ef1').set('E', {'Ex' 'Ey' 'Ez'});
model.physics('cpt').create('mf1', 'MagneticForce', 3);
model.physics('cpt').feature('mf1').selection.named('sel2');
model.physics('cpt').feature('mf1').set('B', {'Bx' 'By' 'Bz'});
model.physics('cpt').create('pbeam1', 'ParticleBeam', 2);
model.physics('cpt').feature('pbeam1').selection.set([74]);
model.physics('cpt').feature('pbeam1').setIndex('N', 5000, 0);
model.physics('cpt').feature('pbeam1').set('TransverseVelocityDistributionSpecification', 'SpecifyPhaseSpaceEllipseDimensions');
model.physics('cpt').feature('pbeam1').set('xm', '1[cm]');
model.physics('cpt').feature('pbeam1').set('xmp', 0.001);
model.physics('cpt').feature('pbeam1').set('El', 'Ei0');
model.physics('cpt').create('pcnt1', 'ParticleCounter', 2);
model.physics('cpt').feature('pcnt1').selection.set([11]);
model.physics('cpt').feature('pcnt1').set('ReleaseFeature', 'pbeam1');
model.physics('cpt').create('pcnt2', 'ParticleCounter', 2);
model.physics('cpt').feature('pcnt2').selection.set([65]);
model.physics('cpt').feature('pcnt2').set('ReleaseFeature', 'pbeam1');
model.physics('cpt').create('pcnt3', 'ParticleCounter', 2);
model.physics('cpt').feature('pcnt3').selection.set([68]);
model.physics('cpt').feature('pcnt3').set('ReleaseFeature', 'pbeam1');
model.physics('cpt').create('pcnt4', 'ParticleCounter', 2);
model.physics('cpt').feature('pcnt4').selection.set([51]);
model.physics('cpt').feature('pcnt4').set('ReleaseFeature', 'pbeam1');
model.physics('cpt').create('pcnt5', 'ParticleCounter', 2);
model.physics('cpt').feature('pcnt5').selection.set([8]);
model.physics('cpt').feature('pcnt5').set('ReleaseFeature', 'pbeam1');
model.physics('cpt').create('wall2', 'Wall', 2);
model.physics('cpt').feature('wall2').selection.named('sel6');
model.physics('cpt').feature('wall2').set('WallCondition', 'Pass');

model.mesh('mesh1').autoMeshSize(3);
model.mesh('mesh1').create('ftri1', 'FreeTri');
model.mesh('mesh1').feature('ftri1').selection.set([3 11 61 74]);
model.mesh('mesh1').feature('ftri1').create('size1', 'Size');
model.mesh('mesh1').feature('ftri1').feature('size1').set('hauto', 2);
model.mesh('mesh1').run('ftri1');
model.mesh('mesh1').feature.duplicate('ftri2', 'ftri1');
model.mesh('mesh1').feature('ftri2').selection.named('sel5');
model.mesh('mesh1').feature('ftri2').feature('size1').set('hauto', 1);
model.mesh('mesh1').run('ftri2');
model.mesh('mesh1').create('ftet1', 'FreeTet');
model.mesh('mesh1').run;

model.study('std1').feature('time').set('tunit', 'ms');
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
model.result.dataset('part1').set('posdof', {'comp1.qx' 'comp1.qy' 'comp1.qz'});
model.result.dataset('part1').set('geom', 'geom1');
model.result.dataset('part1').set('pgeom', 'pgeom_cpt');
model.result.dataset('part1').set('pgeomspec', 'fromphysics');
model.result.dataset('part1').set('physicsinterface', 'cpt');
model.result.create('pg1', 'PlotGroup3D');
model.result('pg1').set('data', 'part1');
model.result('pg1').setIndex('looplevel', 101, 0);
model.result('pg1').label('Particle Trajectories (cpt)');
model.result('pg1').create('traj1', 'ParticleTrajectories');
model.result('pg1').feature('traj1').set('pointtype', 'point');
model.result('pg1').feature('traj1').set('linetype', 'none');
model.result('pg1').feature('traj1').create('col1', 'Color');
model.result('pg1').feature('traj1').feature('col1').set('expr', 'cpt.V');
model.result.create('pg2', 'PlotGroup3D');
model.result('pg2').set('data', 'part1');
model.result('pg2').setIndex('looplevel', 101, 0);
model.result('pg2').label('Average Beam Position (cpt)');
model.result('pg2').create('pttraj1', 'PointTrajectories');
model.result('pg2').feature('pttraj1').set('plotdata', 'global');
model.result('pg2').feature('pttraj1').set('globalexpr', {'cpt.qavx' 'cpt.qavy' 'cpt.qavz'});
model.result('pg2').feature('pttraj1').create('col1', 'Color');
model.result('pg2').feature('pttraj1').feature('col1').set('expr', 'cpt.e1hrms');
model.result('pg1').run;
model.result('pg1').run;
model.result('pg1').feature('traj1').set('linetype', 'line');
model.result('pg1').feature('traj1').set('pointtype', 'none');
model.result('pg1').run;
model.result('pg1').run;
model.result('pg1').feature('traj1').feature('col1').set('expr', 'cpt.Ep');
model.result('pg1').feature('traj1').feature('col1').set('descr', 'Particle kinetic energy');
model.result('pg1').feature('traj1').feature('col1').set('unit', 'eV');
model.result('pg1').run;
model.result('pg2').run;
model.result('pg2').run;
model.result('pg2').feature('pttraj1').set('expr', {'cpt.pcnt1.qavtx' 'cpt.pcnt1.qavty' 'cpt.pcnt1.qavtz'});
model.result('pg2').run;
model.result('pg2').feature('pttraj1').feature('col1').active(false);
model.result('pg2').run;
model.result.numerical.create('gev1', 'EvalGlobal');
model.result.numerical('gev1').setIndex('looplevelinput', 'last', 0);
model.result.numerical('gev1').set('expr', {'cpt.pcnt1.alpha'});
model.result.numerical('gev1').set('descr', {'Transmission probability'});
model.result.numerical('gev1').set('unit', {'1'});
model.result.table.create('tbl1', 'Table');
model.result.table('tbl1').comments('Global Evaluation 1');
model.result.numerical('gev1').set('table', 'tbl1');
model.result.numerical('gev1').setResult;
model.result('pg1').run;

model.title('Sensitive High-Resolution Ion Microprobe');

model.description(['The Sensitive High-Resolution Ion Microprobe (SHRIMP) is used to transmit ions of a given initial energy and specified charge-to-mass ratio by subjecting an incoming beam to appropriately tuned electric and magnetic forces. The beam is first sent through a curved sector with a radial electric force, then through a second curved sector with a uniform magnetic flux density.' newline  newline 'This tutorial model utilizes the Particle Beam feature of the Charged Particle Tracing interface to examine the performance of the high-precision spectrometer, where only a fraction of the incoming beam is transmitted to the detector. The model calculates the transmission probability and visualizes the nominal trajectory of the transmitted beam.']);

model.mesh.clearMeshes;

model.sol('sol1').clearSolutionData;

model.label('sensitive_high_resolution_ion_microprobe.mph');

model.modelNode.label('Components');

out = model;
