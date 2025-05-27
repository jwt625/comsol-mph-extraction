function out = model
%
% s_bend_benchmark.m
%
% Model exported on May 26 2025, 21:30 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/Molecular_Flow_Module/Benchmarks');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 2);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.physics.create('fmf', 'FreeMolecularFlow', 'geom1', {'G'});

model.study.create('std1');
model.study('std1').create('stat', 'Stationary');
model.study('std1').feature('stat').setSolveFor('/physics/fmf', true);

model.geom('geom1').lengthUnit('cm');
model.geom('geom1').create('r1', 'Rectangle');
model.geom('geom1').feature('r1').set('size', [2 1]);
model.geom('geom1').run('r1');
model.geom('geom1').create('c1', 'Circle');
model.geom('geom1').feature('c1').set('angle', 90);
model.geom('geom1').feature('c1').set('pos', [2 2]);
model.geom('geom1').feature('c1').set('rot', 270);
model.geom('geom1').run('c1');
model.geom('geom1').feature.duplicate('c2', 'c1');
model.geom('geom1').feature('c2').set('r', 2);
model.geom('geom1').run('c2');
model.geom('geom1').create('dif1', 'Difference');
model.geom('geom1').feature('dif1').selection('input').set({'c2'});
model.geom('geom1').feature('dif1').selection('input2').set({'c1'});
model.geom('geom1').run('dif1');
model.geom('geom1').create('c3', 'Circle');
model.geom('geom1').feature('c3').set('angle', 90);
model.geom('geom1').feature('c3').set('pos', [5 2]);
model.geom('geom1').feature('c3').set('rot', 90);
model.geom('geom1').run('c3');
model.geom('geom1').feature.duplicate('c4', 'c3');
model.geom('geom1').feature('c4').set('r', 2);
model.geom('geom1').run('c4');
model.geom('geom1').create('dif2', 'Difference');
model.geom('geom1').feature('dif2').selection('input').set({'c4'});
model.geom('geom1').feature('dif2').selection('input2').set({'c3'});
model.geom('geom1').runPre('fin');
model.geom('geom1').create('r2', 'Rectangle');
model.geom('geom1').feature('r2').set('size', [2 1]);
model.geom('geom1').feature('r2').set('pos', [5 3]);
model.geom('geom1').runPre('fin');
model.geom('geom1').create('uni1', 'Union');
model.geom('geom1').feature('uni1').selection('input').set({'dif1' 'dif2' 'r1' 'r2'});
model.geom('geom1').feature('uni1').set('intbnd', false);
model.geom('geom1').runPre('fin');

model.param.set('T0', '293.15[K]');
model.param.descr('T0', 'Temperature');
model.param.set('Mw', '0.028[kg/mol]');
model.param.descr('Mw', 'Molecular weight');
model.param.set('p_in', '1E-3[Pa]');
model.param.descr('p_in', 'Inlet pressure');

model.geom('geom1').run;

model.physics('fmf').feature('fmfp1').setIndex('Mn_G', 'Mw', 0);
model.physics('fmf').feature('st1').set('T', 'T0');
model.physics('fmf').create('res1', 'Reservoir', 1);
model.physics('fmf').feature('res1').selection.set([1]);
model.physics('fmf').feature('res1').setIndex('p0', 'p_in', 0);
model.physics('fmf').create('tv1', 'TotalVacuum', 1);
model.physics('fmf').feature('tv1').selection.set([6]);
model.physics('fmf').create('ndr1', 'NumberDensityReconDomain', 2);
model.physics('fmf').feature('ndr1').selection.set([1]);
model.physics('fmf').prop('Compute').set('ComputeP', false);
model.physics('fmf').prop('IntegrationProperty').set('IntegrationResolution', 512);

model.cpl.create('intop1', 'Integration', 'geom1');
model.cpl('intop1').set('axisym', true);
model.cpl('intop1').selection.geom('geom1', 1);
model.cpl('intop1').selection.set([1]);
model.cpl.create('intop2', 'Integration', 'geom1');
model.cpl('intop2').set('axisym', true);
model.cpl('intop2').selection.geom('geom1', 1);
model.cpl('intop2').selection.set([6]);

model.variable.create('var1');
model.variable('var1').model('comp1');
model.variable('var1').set('Jin', 'intop1(fmf.J_G)');
model.variable('var1').descr('Jin', 'Influx');
model.variable('var1').set('Jout', 'intop2(G)');
model.variable('var1').descr('Jout', 'Outflux');
model.variable('var1').set('alpha', 'Jout/Jin');
model.variable('var1').descr('alpha', 'Transmission probability');

model.mesh('mesh1').autoMeshSize(1);
model.mesh('mesh1').run;

model.sol.create('sol1');
model.sol('sol1').study('std1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'stat');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').set('control', 'stat');
model.sol('sol1').create('s1', 'Stationary');
model.sol('sol1').feature('s1').set('stol', 0.001);
model.sol('sol1').feature('s1').create('se1', 'Segregated');
model.sol('sol1').feature('s1').feature('se1').feature.remove('ssDef');
model.sol('sol1').feature('s1').feature('se1').create('ss1', 'SegregatedStep');
model.sol('sol1').feature('s1').feature('se1').feature('ss1').set('segvar', {'comp1_G'});
model.sol('sol1').feature('s1').create('d1', 'Direct');
model.sol('sol1').feature('s1').feature('d1').set('linsolver', 'pardiso');
model.sol('sol1').feature('s1').feature('d1').set('pivotperturb', 1.0E-13);
model.sol('sol1').feature('s1').feature('se1').feature('ss1').set('linsolver', 'd1');
model.sol('sol1').feature('s1').feature('se1').create('ss2', 'SegregatedStep');
model.sol('sol1').feature('s1').feature('se1').feature('ss2').set('segvar', {'comp1_fmf_N_G' 'comp1_fmf_ndr1_Nr_G'});
model.sol('sol1').feature('s1').feature('se1').feature('ss2').set('linsolver', 'd1');
model.sol('sol1').feature('s1').create('i1', 'Iterative');
model.sol('sol1').feature('s1').feature('i1').set('linsolver', 'gmres');
model.sol('sol1').feature('s1').feature.remove('fcDef');
model.sol('sol1').attach('std1');
model.sol('sol1').runAll;

model.result.create('pg1', 'PlotGroup2D');
model.result('pg1').label('Incident Molecular Flux (fmf)');
model.result('pg1').set('data', 'dset1');
model.result('pg1').set('defaultPlotID', 'FreeMolecularFlow/phys1/pdef1/pcond2/pg2');
model.result('pg1').feature.create('line1', 'Line');
model.result('pg1').feature('line1').label('Line');
model.result('pg1').feature('line1').set('showsolutionparams', 'on');
model.result('pg1').feature('line1').set('expr', 'fmf.Gtot');
model.result('pg1').feature('line1').set('linetype', 'tube');
model.result('pg1').feature('line1').set('resolution', 'norefine');
model.result('pg1').feature('line1').set('smooth', 'internal');
model.result('pg1').feature('line1').set('showsolutionparams', 'on');
model.result('pg1').feature('line1').set('data', 'parent');
model.result.create('pg2', 'PlotGroup2D');
model.result('pg2').label('Total Number Density (fmf)');
model.result('pg2').set('data', 'dset1');
model.result('pg2').set('defaultPlotID', 'FreeMolecularFlow/phys1/pdef1/pcond2/pcond1/pg1');
model.result('pg2').feature.create('line1', 'Line');
model.result('pg2').feature('line1').label('Line');
model.result('pg2').feature('line1').set('showsolutionparams', 'on');
model.result('pg2').feature('line1').set('expr', 'fmf.ntot');
model.result('pg2').feature('line1').set('linetype', 'tube');
model.result('pg2').feature('line1').set('resolution', 'norefine');
model.result('pg2').feature('line1').set('smooth', 'internal');
model.result('pg2').feature('line1').set('showsolutionparams', 'on');
model.result('pg2').feature('line1').set('data', 'parent');
model.result('pg1').run;
model.result.create('pg3', 'PlotGroup2D');
model.result('pg3').run;
model.result('pg3').label('Number Density (fmf)');
model.result('pg3').create('surf1', 'Surface');
model.result('pg3').feature('surf1').set('expr', 'fmf.n_G');
model.result('pg3').feature('surf1').set('descr', 'Number density');
model.result('pg3').run;
model.result.numerical.create('gev1', 'EvalGlobal');
model.result.numerical('gev1').set('expr', {'alpha'});
model.result.numerical('gev1').set('descr', {'Transmission probability'});
model.result.numerical('gev1').set('unit', {'1'});
model.result.table.create('tbl1', 'Table');
model.result.table('tbl1').comments('Global Evaluation 1');
model.result.numerical('gev1').set('table', 'tbl1');
model.result.numerical('gev1').setResult;

model.physics.create('pt', 'MathParticle', 'geom1');
model.physics('pt').model('comp1');

model.study('std1').feature('stat').setSolveFor('/physics/pt', false);
model.study.create('std2');
model.study('std2').create('time', 'Transient');
model.study('std2').feature('time').setSolveFor('/physics/fmf', false);
model.study('std2').feature('time').setSolveFor('/physics/pt', true);

model.physics('pt').prop('MaximumSecondary').setIndex('MaximumSecondary', 0, 0);

model.param.set('M', 'Mw/N_A_const');
model.param.descr('M', 'Particle Mass');
model.param.set('J_in', 'p_in*N_A_const/sqrt(2*R_const*T0*Mw*pi)');
model.param.descr('J_in', 'Emitted molecular flux');
model.param.set('L', '0.01[m]');
model.param.descr('L', 'Inlet length');
model.param.set('Np', '10000');
model.param.descr('Np', 'Number of particles');

model.physics('pt').create('tre1', 'ThermalReEmission', 1);
model.physics('pt').feature('tre1').selection.all;
model.physics('pt').feature('tre1').set('T', 'T0');
model.physics('pt').create('out1', 'Outlet', 1);
model.physics('pt').feature('out1').selection.set([6]);
model.physics('pt').create('inl1', 'Inlet', 1);
model.physics('pt').feature('inl1').selection.set([1]);
model.physics('pt').feature('inl1').set('InitialPosition', 'Density');
model.physics('pt').feature('inl1').setIndex('N', 'Np', 0);
model.physics('pt').feature('inl1').set('InitialVelocity', 'Thermal');
model.physics('pt').feature('inl1').set('T', 'T0');
model.physics('pt').create('wall2', 'Wall', 1);
model.physics('pt').feature('wall2').selection.set([1]);
model.physics('pt').feature('wall2').set('WallCondition', 'Disappear');
model.physics('pt').create('pcnt1', 'ParticleCounter', 1);
model.physics('pt').feature('pcnt1').selection.set([6]);
model.physics('pt').feature('pcnt1').set('ReleaseFeature', 'inl1');
model.physics('pt').feature('pp1').set('mp', 'M');
model.physics('pt').create('dacc1', 'DomainAccumulator', 2);
model.physics('pt').feature('dacc1').selection.set([1]);
model.physics('pt').feature('dacc1').set('AccumulateOver', 'ElementsAndTime');
model.physics('pt').feature('dacc1').set('AccumulatedVariableName', 'Nd');
model.physics('pt').feature('dacc1').set('DependentVariableQuantity', 'numberdensity');
model.physics('pt').feature('dacc1').set('R', 'J_in*L/Np');

model.study('std2').feature('time').set('tlist', 'range(0,2.0689655172413793e-4,0.006)');

model.sol.create('sol2');
model.sol('sol2').study('std2');
model.sol('sol2').create('st1', 'StudyStep');
model.sol('sol2').feature('st1').set('study', 'std2');
model.sol('sol2').feature('st1').set('studystep', 'time');
model.sol('sol2').create('v1', 'Variables');
model.sol('sol2').feature('v1').set('control', 'time');
model.sol('sol2').create('t1', 'Time');
model.sol('sol2').feature('t1').set('tlist', 'range(0,2.0689655172413793e-4,0.006)');
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
model.result.dataset('part1').set('posdof', {'comp1.qx' 'comp1.qy'});
model.result.dataset('part1').set('geom', 'geom1');
model.result.dataset('part1').set('pgeom', 'pgeom_pt');
model.result.dataset('part1').set('pgeomspec', 'fromphysics');
model.result.dataset('part1').set('physicsinterface', 'pt');
model.result.create('pg4', 'PlotGroup2D');
model.result('pg4').set('data', 'part1');
model.result('pg4').setIndex('looplevel', 30, 0);
model.result('pg4').label('Particle Trajectories (pt)');
model.result('pg4').create('traj1', 'ParticleTrajectories');
model.result('pg4').feature('traj1').set('pointtype', 'point');
model.result('pg4').feature('traj1').set('linetype', 'none');
model.result('pg4').feature('traj1').create('col1', 'Color');
model.result('pg4').feature('traj1').feature('col1').set('expr', 'pt.V');
model.result('pg4').run;
model.result('pg2').run;
model.result.numerical.create('gev2', 'EvalGlobal');
model.result.numerical('gev2').set('data', 'dset2');
model.result.numerical('gev2').setIndex('looplevelinput', 'last', 0);
model.result.numerical('gev2').set('expr', {'pt.pcnt1.alpha'});
model.result.numerical('gev2').set('descr', {'Transmission probability'});
model.result.numerical('gev2').set('unit', {'1'});
model.result.table.create('tbl2', 'Table');
model.result.table('tbl2').comments('Global Evaluation 2');
model.result.numerical('gev2').set('table', 'tbl2');
model.result.numerical('gev2').setResult;
model.result('pg3').run;
model.result.duplicate('pg5', 'pg3');
model.result('pg5').run;
model.result('pg5').label('Number Density Comparison');
model.result('pg5').set('titletype', 'none');
model.result('pg5').set('plotarrayenable', true);
model.result('pg5').set('arrayaxis', 'y');
model.result('pg5').set('relpadding', 0);
model.result('pg5').create('surf2', 'Surface');
model.result('pg5').feature('surf2').set('arraydim', '1');
model.result('pg5').feature('surf2').set('data', 'part1');
model.result('pg5').feature('surf2').set('expr', 'pt.Nd');
model.result('pg5').feature('surf2').set('resolution', 'norefine');
model.result('pg5').feature('surf2').set('inheritplot', 'surf1');
model.result('pg5').run;

model.title('Molecular Flow Through an S-Bend');

model.description(['This example computes the transmission probability through an s-bend geometry using both the angular coefficient method available in the Free Molecular Flow interface and a Monte Carlo method using the Mathematical Particle Tracing interface. The computed transmission probability by the two methods is in excellent agreement, less than 1% difference.' newline  newline 'This example requires the Particle Tracing Module.']);

model.mesh.clearMeshes;

model.sol('sol1').clearSolutionData;
model.sol('sol2').clearSolutionData;

model.label('s_bend_benchmark.mph');

model.modelNode.label('Components');

out = model;
