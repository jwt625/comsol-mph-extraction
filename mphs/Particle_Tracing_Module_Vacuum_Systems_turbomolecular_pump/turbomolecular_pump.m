function out = model
%
% turbomolecular_pump.m
%
% Model exported on May 26 2025, 21:31 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/Particle_Tracing_Module/Vacuum_Systems');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 3);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.physics.create('pt', 'MathParticle', 'geom1');
model.physics('pt').model('comp1');

model.study.create('std1');
model.study('std1').create('time', 'Transient');
model.study('std1').feature('time').setSolveFor('/physics/pt', true);

model.geom('geom1').insertFile('turbomolecular_pump_geom_sequence.mph', 'geom1');
model.geom('geom1').run('fin');

model.modelNode('comp1').sorder('linear');

model.param.label('Geometry Parameters');
model.param.create('par2');
model.param('par2').label('Physics Parameters');

% To import content from file, use:
% model.param('par2').loadFile('FILENAME');
model.param('par2').set('T0', '300[K]', 'Temperature');
model.param('par2').set('M', '39.948[g/mol]', 'Argon molar mass');
model.param('par2').set('m', 'M/N_A_const', 'Argon mass');
model.param('par2').set('vmp', 'sqrt(2*k_B_const*T0/m)', 'Most probable velocity (Maxwellian distribution)');
model.param('par2').set('C', '0.5', 'Blade velocity ratio at rms radius');
model.param('par2').set('vb', 'C*vmp', 'Blade velocity at rms radius');
model.param('par2').set('omega', 'vb/rrms[rad]', 'Stage angular velocity');

model.variable.create('var1');
model.variable('var1').model('comp1');
model.variable('var1').set('M12', 'pt.pcnt1.alpha');
model.variable('var1').descr('M12', 'Transmission probability, forward');
model.variable('var1').set('M21', 'pt.pcnt2.alpha');
model.variable('var1').descr('M21', 'Transmission probability, backward');
model.variable('var1').set('Kmax', 'M12/M21');
model.variable('var1').descr('Kmax', 'Maximum Compression Ratio');
model.variable('var1').set('Wmax', 'M12-M21');
model.variable('var1').descr('Wmax', 'Maximum Speed Factor');

model.physics('pt').prop('MaximumSecondary').setIndex('MaximumSecondary', 0, 0);
model.physics('pt').feature('pp1').set('mp', 'm');
model.physics('pt').create('rf1', 'RotatingFrame', 3);
model.physics('pt').feature('rf1').set('normOmega', 'omega');
model.physics('pt').create('inl1', 'Inlet', 2);
model.physics('pt').feature('inl1').selection.named('geom1_sel1');
model.physics('pt').feature('inl1').set('InitialPosition', 'Density');
model.physics('pt').feature('inl1').setIndex('N', 10000, 0);
model.physics('pt').feature('inl1').set('InitialVelocity', 'Thermal');
model.physics('pt').feature('inl1').set('T', 'T0');
model.physics('pt').feature('inl1').set('SubtractMovingFrameVelocity', true);
model.physics('pt').create('inl2', 'Inlet', 2);
model.physics('pt').feature('inl2').selection.named('geom1_sel2');
model.physics('pt').feature('inl2').set('InitialPosition', 'Density');
model.physics('pt').feature('inl2').setIndex('N', 10000, 0);
model.physics('pt').feature('inl2').set('InitialVelocity', 'Thermal');
model.physics('pt').feature('inl2').set('T', 'T0');
model.physics('pt').feature('inl2').set('SubtractMovingFrameVelocity', true);
model.physics('pt').create('pcnt1', 'ParticleCounter', 2);
model.physics('pt').feature('pcnt1').label('Particle Counter (Inlet 1 Transmission)');
model.physics('pt').feature('pcnt1').selection.named('geom1_sel2');
model.physics('pt').feature('pcnt1').set('ReleaseFeature', 'inl1');
model.physics('pt').create('pcnt2', 'ParticleCounter', 2);
model.physics('pt').feature('pcnt2').label('Particle Counter (Inlet 2 Transmission)');
model.physics('pt').feature('pcnt2').selection.named('geom1_sel1');
model.physics('pt').feature('pcnt2').set('ReleaseFeature', 'inl2');
model.physics('pt').create('tre1', 'ThermalReEmission', 2);
model.physics('pt').feature('tre1').label('Root and Blade Surfaces');
model.physics('pt').feature('tre1').selection.named('geom1_unisel1');
model.physics('pt').feature('tre1').set('T', 'T0');
model.physics('pt').create('tre2', 'ThermalReEmission', 2);
model.physics('pt').feature('tre2').label('Tip Wall');
model.physics('pt').feature('tre2').selection.named('geom1_sel4');
model.physics('pt').feature('tre2').set('T', 'T0');
model.physics('pt').feature('tre2').set('SubtractMovingFrameVelocityReflected', true);

model.mesh('mesh1').autoMeshSize(2);
model.mesh('mesh1').run;

model.study('std1').create('param', 'Parametric');
model.study('std1').feature('param').setIndex('pname', 'alpha', 0);
model.study('std1').feature('param').setIndex('plistarr', '', 0);
model.study('std1').feature('param').setIndex('punit', 'rad', 0);
model.study('std1').feature('param').setIndex('pname', 'alpha', 0);
model.study('std1').feature('param').setIndex('plistarr', '', 0);
model.study('std1').feature('param').setIndex('punit', 'rad', 0);
model.study('std1').feature('param').setIndex('pname', 'C', 0);
model.study('std1').feature('param').setIndex('plistarr', 'range(0,0.5,4)', 0);
model.study('std1').feature('param').setIndex('punit', '', 0);
model.study('std1').feature('time').set('tunit', 'ms');
model.study('std1').feature('time').set('tlist', 'range(0,0.01,0.5)');

model.sol.create('sol1');
model.sol('sol1').study('std1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'time');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').set('control', 'time');
model.sol('sol1').create('t1', 'Time');
model.sol('sol1').feature('t1').set('tlist', 'range(0,0.01,0.5)');
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
model.batch('p1').set('pname', {'C'});
model.batch('p1').set('plistarr', {'range(0,0.5,4)'});
model.batch('p1').set('sweeptype', 'sparse');
model.batch('p1').set('probesel', 'all');
model.batch('p1').set('probes', {});
model.batch('p1').set('plot', 'off');
model.batch('p1').set('err', 'on');
model.batch('p1').attach('std1');
model.batch('p1').set('control', 'param');

model.sol.create('sol2');
model.sol('sol2').study('std1');
model.sol('sol2').label('Parametric Solutions 1');

model.batch('p1').feature('so1').set('psol', 'sol2');
model.batch('p1').run('compute');

model.result.dataset.create('part1', 'Particle');
model.result.dataset('part1').set('solution', 'sol2');
model.result.dataset('part1').set('posdof', {'comp1.qx' 'comp1.qy' 'comp1.qz'});
model.result.dataset('part1').set('geom', 'geom1');
model.result.dataset('part1').set('pgeom', 'pgeom_pt');
model.result.dataset('part1').set('pgeomspec', 'fromphysics');
model.result.dataset('part1').set('physicsinterface', 'pt');
model.result.create('pg1', 'PlotGroup3D');
model.result('pg1').set('data', 'part1');
model.result('pg1').setIndex('looplevel', 51, 0);
model.result('pg1').setIndex('looplevel', 9, 1);
model.result('pg1').label('Particle Trajectories (pt)');
model.result('pg1').create('traj1', 'ParticleTrajectories');
model.result('pg1').feature('traj1').set('pointtype', 'point');
model.result('pg1').feature('traj1').set('linetype', 'none');
model.result('pg1').feature('traj1').create('col1', 'Color');
model.result('pg1').feature('traj1').feature('col1').set('expr', 'pt.V');
model.result.create('pg2', 'PlotGroup3D');
model.result('pg2').set('data', 'dset2');
model.result('pg2').setIndex('looplevel', 51, 0);
model.result('pg2').setIndex('looplevel', 9, 1);
model.result('pg2').label('Frame Velocity (pt)');
model.result('pg2').create('arwv1', 'ArrowVolume');
model.result('pg2').feature('arwv1').set('expr', {'pt.rf1.vfx' 'pt.rf1.vfy' 'pt.rf1.vfz'});
model.result('pg2').feature('arwv1').create('col1', 'Color');
model.result('pg2').feature('arwv1').feature('col1').set('expr', 'pt.rf1.Vf');
model.result('pg1').run;
model.result('pg1').run;
model.result('pg1').feature('traj1').feature('col1').set('expr', 'pt.prf');
model.result('pg1').feature('traj1').feature('col1').set('descr', 'Particle release feature');
model.result('pg1').feature('traj1').feature('col1').set('colortable', 'TrafficLight');
model.result('pg1').run;
model.result('pg1').set('showlegends', false);
model.result('pg1').run;
model.result('pg1').setIndex('looplevel', 1, 1);
model.result('pg1').run;
model.result('pg1').setIndex('looplevel', 3, 1);
model.result('pg1').run;
model.result('pg1').setIndex('looplevel', 5, 1);
model.result('pg1').run;
model.result('pg1').setIndex('looplevel', 7, 1);
model.result('pg1').run;
model.result('pg1').setIndex('looplevel', 9, 1);
model.result('pg1').run;
model.result.create('pg3', 'PlotGroup1D');
model.result('pg3').run;
model.result('pg3').label('M12');
model.result('pg3').set('data', 'dset2');
model.result('pg3').setIndex('looplevelinput', 'last', 0);
model.result('pg3').set('showlegends', false);
model.result('pg3').create('glob1', 'Global');
model.result('pg3').feature('glob1').set('markerpos', 'datapoints');
model.result('pg3').feature('glob1').set('linewidth', 'preference');
model.result('pg3').feature('glob1').setIndex('expr', 'M12', 0);
model.result('pg3').feature('glob1').setIndex('descr', 'Fraction of particles transmitted from the inlet to the outlet', 0);
model.result('pg3').feature('glob1').set('xdatasolnumtype', 'level2');
model.result('pg3').feature('glob1').set('linecolor', 'black');
model.result('pg3').feature('glob1').set('linemarker', 'circle');
model.result('pg3').run;
model.result('pg3').run;
model.result.duplicate('pg4', 'pg3');
model.result('pg4').run;
model.result('pg4').label('M21');
model.result('pg4').run;
model.result('pg4').feature('glob1').setIndex('expr', 'M21', 0);
model.result('pg4').feature('glob1').setIndex('descr', 'Fraction of particles transmitted from the outlet to the inlet', 0);
model.result('pg4').run;
model.result('pg4').run;
model.result.duplicate('pg5', 'pg4');
model.result('pg5').run;
model.result('pg5').label('Kmax');
model.result('pg5').run;
model.result('pg5').feature('glob1').setIndex('expr', 'Kmax', 0);
model.result('pg5').feature('glob1').setIndex('descr', 'Maximum Compression Ratio', 0);
model.result('pg5').run;
model.result('pg5').set('ylog', true);
model.result('pg5').run;
model.result.duplicate('pg6', 'pg5');
model.result('pg6').run;
model.result('pg6').label('Wmax');
model.result('pg6').run;
model.result('pg6').feature('glob1').setIndex('expr', 'Wmax', 0);
model.result('pg6').run;
model.result('pg6').set('ylog', false);

model.title('Turbomolecular Pump');

model.description(['The Free Molecular Flow interface, available in the Molecular Flow Module, is an efficient tool for modeling extremely rarefied gases when the gas molecules move much faster than any geometric entities in the domain. For turbomolecular pumps, in which the blades move at speeds comparable to the thermal speed of the gas molecules, a Monte Carlo approach is needed.' newline  newline 'In this example, the trajectories of gas molecules are computed in the empty space between two rotating blades of a turbomolecular pump. The model uses the Rotating Frame feature to exert centrifugal and Coriolis forces to the particles, allowing the trajectories to be computed in a noninertial frame of reference that moves with the rotating blades. The effect of the blade velocity on the compression factor is shown using a parametric sweep.']);

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

model.label('turbomolecular_pump.mph');

model.modelNode.label('Components');

out = model;
