function out = model
%
% ion_range_benchmark.m
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

% To import content from file, use:
% model.param.loadFile('FILENAME');
model.param.set('E0', '1e4[MeV]', 'Proton initial energy');
model.param.set('LE0', 'log10(E0/1[MeV])', 'Log10 of the initial energy in MeV');
model.param.set('mp', 'mp_const', 'Proton mass');
model.param.set('Zp', '1', 'Proton charge number');
model.param.set('rhoSi', '1.33[g/cm^3]', 'Silicon mass density');
model.param.set('Ltmax', '0.0003*LE0^6+0.0007*LE0^5-0.0163*LE0^4-0.013*LE0^3+0.2294*LE0^2+0.8055*LE0-11.304', 'Log10 of the simulation time');
model.param.set('LL', '0.0035*LE0^5-0.0161*LE0^4-0.0725*LE0^3+0.2558*LE0^2+1.5964*LE0-4.3234', 'Log10 of the box size');
model.param.set('tmax', '10^Ltmax[s]', 'Simulation time');
model.param.set('L', '10^LL[m]', 'Box size');
model.param.set('tsize', 'tmax/1e3', 'Maximum time step size');

model.func.create('int1', 'Interpolation');
model.func('int1').model('comp1');
model.func('int1').set('source', 'file');
model.func('int1').set('filename', 'ion_range_benchmark_ranges.txt');
model.func('int1').set('nargs', 1);
model.func('int1').importData;
model.func('int1').setIndex('funcs', 'CSDA', 0, 0);
model.func('int1').setIndex('argunit', 'MeV', 0);
model.func('int1').setIndex('fununit', 'g/cm^2', 0);
model.func.create('int2', 'Interpolation');
model.func('int2').model('comp1');
model.func('int2').set('source', 'file');
model.func('int2').set('filename', 'ion_range_benchmark_ranges.txt');
model.func('int2').set('nargs', 1);
model.func('int2').setIndex('funcs', 'Proj', 0, 0);
model.func('int2').setIndex('funcs', 2, 0, 1);
model.func('int2').importData;
model.func('int2').setIndex('argunit', 'MeV', 0);
model.func('int2').setIndex('fununit', 'g/cm^2', 0);

model.geom('geom1').create('blk1', 'Block');
model.geom('geom1').feature('blk1').set('size', {'L' 'L' 'L'});
model.geom('geom1').feature('blk1').set('base', 'center');
model.geom('geom1').runPre('fin');
model.geom('geom1').run;

model.physics('cpt').prop('RelativisticCorrection').setIndex('RelativisticCorrection', 1, 0);
model.physics('cpt').create('pmi1', 'ParticleMatterInteractions', 3);
model.physics('cpt').feature('pmi1').selection.all;
model.physics('cpt').feature('pmi1').create('il1', 'IonizationLoss', 3);
model.physics('cpt').feature('pmi1').create('ns1', 'NuclearStopping', 3);
model.physics('cpt').feature('pp1').set('ParticleSpecies', 'Proton');
model.physics('cpt').create('relg1', 'ReleaseGrid', -1);
model.physics('cpt').feature('relg1').setIndex('x0', '-L/4', 0);
model.physics('cpt').feature('relg1').setIndex('x0', 'range(-L/1e3,(L/1e3-(-L/1e3))/1000,L/1e3)', 1);
model.physics('cpt').feature('relg1').set('InitialVelocity', 'KineticEnergyAndDirection');
model.physics('cpt').feature('relg1').set('Ep0', 'E0');
model.physics('cpt').create('aux1', 'AuxiliaryField', -1);
model.physics('cpt').feature('aux1').set('R', 1);
model.physics('cpt').feature('aux1').set('Integrate', 'AlongParticleTrajectory');
model.physics('cpt').feature('aux1').set('DependentVariableQuantity', 'length');

model.material.create('mat1', 'Common', 'comp1');
model.material('mat1').propertyGroup('def').set('density', {'rhoSi'});

model.study('std1').create('param', 'Parametric');
model.study('std1').feature('param').setIndex('pname', 'E0', 0);
model.study('std1').feature('param').setIndex('plistarr', '', 0);
model.study('std1').feature('param').setIndex('punit', 'J', 0);
model.study('std1').feature('param').setIndex('pname', 'E0', 0);
model.study('std1').feature('param').setIndex('plistarr', '', 0);
model.study('std1').feature('param').setIndex('punit', 'J', 0);
model.study('std1').feature('param').setIndex('punit', 'MeV', 0);
model.study('std1').feature('param').setIndex('plistarr', '10^{range(-3,1,2)}', 0);
model.study('std1').feature('time').set('tlist', 'range(0,1/20,1)*tmax');

model.sol.create('sol1');
model.sol('sol1').study('std1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'time');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').set('control', 'time');
model.sol('sol1').create('t1', 'Time');
model.sol('sol1').feature('t1').set('tlist', 'range(0,1/20,1)*tmax');
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
model.batch('p1').set('pname', {'E0'});
model.batch('p1').set('plistarr', {'10^{range(-3,1,2)}'});
model.batch('p1').set('sweeptype', 'sparse');
model.batch('p1').set('probesel', 'all');
model.batch('p1').set('probes', {});
model.batch('p1').set('plot', 'off');
model.batch('p1').set('err', 'on');
model.batch('p1').attach('std1');
model.batch('p1').set('control', 'param');

model.sol('sol1').feature('t1').set('tstepsgenalpha', 'manual');
model.sol('sol1').feature('t1').set('timestepgenalpha', 'tmax/1e3');
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
model.result('pg1').setIndex('looplevel', 21, 0);
model.result('pg1').setIndex('looplevel', 6, 1);
model.result('pg1').label('Particle Trajectories (cpt)');
model.result('pg1').create('traj1', 'ParticleTrajectories');
model.result('pg1').feature('traj1').set('pointtype', 'point');
model.result('pg1').feature('traj1').set('linetype', 'none');
model.result('pg1').feature('traj1').create('col1', 'Color');
model.result('pg1').feature('traj1').feature('col1').set('expr', 'cpt.V');
model.result('pg1').run;
model.result('pg1').set('edges', false);
model.result('pg1').set('looplevel', [21 3]);
model.result('pg1').run;
model.result('pg1').feature('traj1').set('linetype', 'line');
model.result('pg1').run;
model.result('pg1').feature('traj1').feature('col1').set('colortable', 'Cividis');
model.result('pg1').run;
model.result.create('pg2', 'PlotGroup1D');
model.result('pg2').run;
model.result('pg2').label('Stopping Distance');
model.result('pg2').set('data', 'part1');
model.result('pg2').setIndex('looplevelinput', 'last', 0);
model.result('pg2').set('legendpos', 'upperleft');
model.result('pg2').create('ptp1', 'Particle1D');
model.result('pg2').feature('ptp1').set('markerpos', 'datapoints');
model.result('pg2').feature('ptp1').set('linewidth', 'preference');
model.result('pg2').feature('ptp1').set('expr', 'cpt.ave(rp)');
model.result('pg2').feature('ptp1').set('xdatasolnumtype', 'outer');
model.result('pg2').feature('ptp1').set('xdata', 'expr');
model.result('pg2').feature('ptp1').set('xdataexpr', 'E0');
model.result('pg2').feature('ptp1').set('xdataunit', 'MeV');
model.result('pg2').feature('ptp1').set('linestyle', 'none');
model.result('pg2').feature('ptp1').set('linecolor', 'red');
model.result('pg2').feature('ptp1').set('linewidth', 2);
model.result('pg2').feature('ptp1').set('linemarker', 'star');
model.result('pg2').run;
model.result('pg2').create('glob1', 'Global');
model.result('pg2').feature('glob1').set('markerpos', 'datapoints');
model.result('pg2').feature('glob1').set('linewidth', 'preference');
model.result('pg2').feature('glob1').setIndex('expr', 'CSDA(E0)/rhoSi', 0);
model.result('pg2').feature('glob1').setIndex('descr', 'CSDA', 0);
model.result('pg2').feature('glob1').setIndex('expr', 'Proj(E0)/rhoSi', 1);
model.result('pg2').feature('glob1').setIndex('descr', 'Projected', 1);
model.result('pg2').feature('glob1').set('xdatasolnumtype', 'outer');
model.result('pg2').feature('glob1').set('xdata', 'expr');
model.result('pg2').feature('glob1').set('xdataexpr', 'E0');
model.result('pg2').feature('glob1').set('xdataunit', 'MeV');
model.result('pg2').feature('glob1').set('linestyle', 'none');
model.result('pg2').feature('glob1').set('linecolor', 'black');
model.result('pg2').feature('glob1').set('linemarker', 'cycle');
model.result('pg2').set('ylog', true);
model.result('pg2').set('xlog', true);
model.result('pg2').run;

model.title('Ion Range Benchmark');

model.description(['The Ion Range Benchmark model simulates the passage of energetic protons through silicon with both ionization losses and nuclear scattering. The initial energy of the protons is varied using a parametric sweep from 1' native2unicode(hex2dec({'00' 'a0'}), 'unicode') 'keV to 100' native2unicode(hex2dec({'00' 'a0'}), 'unicode') 'MeV.' newline  newline 'The average path length of the protons is compared to published values of the ion range under the continuous slowing down approximation (CSDA) as well as the projected range in the initial direction of motion. Simulated and experimental data agree well.']);

model.mesh.clearMeshes;

model.sol('sol1').clearSolutionData;
model.sol('sol2').clearSolutionData;
model.sol('sol3').clearSolutionData;
model.sol('sol4').clearSolutionData;
model.sol('sol5').clearSolutionData;
model.sol('sol6').clearSolutionData;
model.sol('sol7').clearSolutionData;
model.sol('sol8').clearSolutionData;

model.label('ion_range_benchmark.mph');

model.modelNode.label('Components');

out = model;
