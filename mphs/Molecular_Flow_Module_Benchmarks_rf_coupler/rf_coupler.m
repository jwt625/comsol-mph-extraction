function out = model
%
% rf_coupler.m
%
% Model exported on May 26 2025, 21:30 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/Molecular_Flow_Module/Benchmarks');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 3);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.physics.create('fmf', 'FreeMolecularFlow', 'geom1', {'G'});

model.study.create('std1');
model.study('std1').create('stat', 'Stationary');
model.study('std1').feature('stat').setSolveFor('/physics/fmf', true);

model.param.set('T0', '293.15[K]');
model.param.descr('T0', 'Temperature');
model.param.set('Mw', '0.028[kg/mol]');
model.param.descr('Mw', 'Molecular weight');
model.param.set('p0', '1E-4[Pa]');
model.param.descr('p0', 'Inlet pressure');
model.param.set('frac', '0.7');
model.param.descr('frac', 'Fraction of molecules pumped');

model.geom('geom1').lengthUnit('cm');
model.geom('geom1').create('wp1', 'WorkPlane');
model.geom('geom1').feature('wp1').set('unite', true);
model.geom('geom1').feature('wp1').set('quickplane', 'yx');
model.geom('geom1').feature('wp1').geom.create('r1', 'Rectangle');
model.geom('geom1').feature('wp1').geom.feature('r1').set('size', [2 8]);
model.geom('geom1').feature('wp1').geom.feature('r1').set('pos', [1 0]);
model.geom('geom1').feature('wp1').geom.run('r1');
model.geom('geom1').feature('wp1').geom.create('pol1', 'Polygon');
model.geom('geom1').feature('wp1').geom.feature('pol1').set('source', 'vectors');
model.geom('geom1').feature('wp1').geom.feature('pol1').set('x', '1 3 3 7 7 3 3 1');
model.geom('geom1').feature('wp1').geom.feature('pol1').set('y', '8 35 35 35 35 8 8 8');
model.geom('geom1').feature('wp1').geom.run('pol1');
model.geom('geom1').feature('wp1').geom.create('r2', 'Rectangle');
model.geom('geom1').feature('wp1').geom.feature('r2').set('size', [4 15]);
model.geom('geom1').feature('wp1').geom.feature('r2').set('pos', [3 35]);
model.geom('geom1').feature('wp1').geom.run('r2');
model.geom('geom1').feature('wp1').geom.create('uni1', 'Union');
model.geom('geom1').feature('wp1').geom.feature('uni1').selection('input').set({'pol1' 'r1' 'r2'});
model.geom('geom1').feature('wp1').geom.feature('uni1').set('intbnd', false);
model.geom('geom1').feature('wp1').geom.run('uni1');
model.geom('geom1').run('wp1');
model.geom('geom1').feature.create('rev1', 'Revolve');
model.geom('geom1').feature('rev1').set('angtype', 'specang');
model.geom('geom1').feature('rev1').set('angle1', -90);
model.geom('geom1').feature('rev1').set('angle2', 90);
model.geom('geom1').runPre('fin');
model.geom('geom1').create('cyl1', 'Cylinder');
model.geom('geom1').feature('cyl1').set('r', 4);
model.geom('geom1').feature('cyl1').set('h', 10);
model.geom('geom1').feature('cyl1').set('pos', [42 5 0]);
model.geom('geom1').feature('cyl1').set('axistype', 'y');
model.geom('geom1').runPre('fin');
model.geom('geom1').create('uni1', 'Union');
model.geom('geom1').feature('uni1').selection('input').set({'cyl1' 'rev1'});
model.geom('geom1').feature('uni1').set('intbnd', false);
model.geom('geom1').runPre('fin');
model.geom('geom1').run('fin');
model.geom('geom1').create('ige1', 'IgnoreEdges');
model.geom('geom1').feature('ige1').selection('input').set('fin', 11);
model.geom('geom1').run;

model.physics('fmf').feature('fmfp1').setIndex('Mn_G', 'Mw', 0);
model.physics('fmf').feature('st1').set('T', 'T0');
model.physics('fmf').create('res1', 'Reservoir', 2);
model.physics('fmf').feature('res1').selection.set([1]);
model.physics('fmf').feature('res1').setIndex('p0', 'p0', 0);
model.physics('fmf').create('pmp1', 'VacuumPump', 2);

model.view('view1').set('renderwireframe', true);

model.physics('fmf').feature('pmp1').selection.set([18]);
model.physics('fmf').feature('pmp1').setIndex('frac', 'frac', 0);
model.physics('fmf').create('msym1', 'Symmetry', -1);
model.physics('fmf').feature('msym1').selection('FirstReflectionPlane').set([2 5]);

model.cpl.create('intop1', 'Integration', 'geom1');
model.cpl('intop1').set('axisym', true);
model.cpl('intop1').selection.geom('geom1', 2);
model.cpl('intop1').selection.set([1]);
model.cpl.create('intop2', 'Integration', 'geom1');
model.cpl('intop2').set('axisym', true);
model.cpl('intop2').selection.geom('geom1', 2);
model.cpl('intop2').selection.set([18]);

model.variable.create('var1');
model.variable('var1').model('comp1');
model.variable('var1').label('Molecular Flow Variables');
model.variable('var1').set('Jin', 'intop1(fmf.J_G)');
model.variable('var1').descr('Jin', 'Influx');
model.variable('var1').set('Jout', 'intop2(G-fmf.J_G)');
model.variable('var1').descr('Jout', 'Outflux, pump 1');
model.variable('var1').set('alpha', 'Jout/Jin');
model.variable('var1').descr('alpha', 'Transmission probability');

model.mesh('mesh1').autoMeshSize(3);
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
model.sol('sol1').feature('s1').create('i1', 'Iterative');
model.sol('sol1').feature('s1').feature('i1').set('linsolver', 'gmres');
model.sol('sol1').feature('s1').feature('i1').create('mg1', 'Multigrid');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').set('prefun', 'gmg');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').set('mcasegen', 'any');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('pr').create('sl1', 'SORLine');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('pr').feature('sl1').set('iter', 2);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('pr').feature('sl1').set('linerelax', 0.2);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('pr').feature('sl1').set('seconditer', 1);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('pr').feature('sl1').set('relax', 0.4);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('po').create('sl1', 'SORLine');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('po').feature('sl1').set('iter', 2);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('po').feature('sl1').set('linerelax', 0.2);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('po').feature('sl1').set('seconditer', 2);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('po').feature('sl1').set('relax', 0.4);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('cs').create('d1', 'Direct');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('cs').feature('d1').set('linsolver', 'pardiso');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('cs').feature('d1').set('pivotperturb', 1.0E-13);
model.sol('sol1').feature('s1').feature('se1').feature('ss1').set('linsolver', 'i1');
model.sol('sol1').feature('s1').feature('se1').create('ss2', 'SegregatedStep');
model.sol('sol1').feature('s1').feature('se1').feature('ss2').set('segvar', {'comp1_fmf_p_G'});
model.sol('sol1').feature('s1').feature('se1').feature('ss2').set('linsolver', 'i1');
model.sol('sol1').feature('s1').feature('se1').create('ss3', 'SegregatedStep');
model.sol('sol1').feature('s1').feature('se1').feature('ss3').set('segvar', {'comp1_fmf_N_G'});
model.sol('sol1').feature('s1').feature('se1').feature('ss3').set('linsolver', 'i1');
model.sol('sol1').feature('s1').feature.remove('fcDef');
model.sol('sol1').attach('std1');
model.sol('sol1').runAll;

model.result.create('pg1', 'PlotGroup3D');
model.result('pg1').label('Incident Molecular Flux (fmf)');
model.result('pg1').set('data', 'dset1');
model.result('pg1').set('defaultPlotID', 'FreeMolecularFlow/phys1/pdef1/pcond1/pg1');
model.result('pg1').feature.create('surf1', 'Surface');
model.result('pg1').feature('surf1').label('Surface');
model.result('pg1').feature('surf1').set('showsolutionparams', 'on');
model.result('pg1').feature('surf1').set('expr', 'fmf.Gtot');
model.result('pg1').feature('surf1').set('resolution', 'norefine');
model.result('pg1').feature('surf1').set('smooth', 'internal');
model.result('pg1').feature('surf1').set('showsolutionparams', 'on');
model.result('pg1').feature('surf1').set('data', 'parent');
model.result.create('pg2', 'PlotGroup3D');
model.result('pg2').label('Total Number Density (fmf)');
model.result('pg2').set('data', 'dset1');
model.result('pg2').set('defaultPlotID', 'FreeMolecularFlow/phys1/pdef1/pcond1/pcond1/pg1');
model.result('pg2').feature.create('surf1', 'Surface');
model.result('pg2').feature('surf1').label('Surface');
model.result('pg2').feature('surf1').set('showsolutionparams', 'on');
model.result('pg2').feature('surf1').set('expr', 'fmf.ntot');
model.result('pg2').feature('surf1').set('resolution', 'norefine');
model.result('pg2').feature('surf1').set('smooth', 'internal');
model.result('pg2').feature('surf1').set('showsolutionparams', 'on');
model.result('pg2').feature('surf1').set('data', 'parent');
model.result.create('pg3', 'PlotGroup3D');
model.result('pg3').label('Total Pressure (fmf)');
model.result('pg3').set('data', 'dset1');
model.result('pg3').set('defaultPlotID', 'FreeMolecularFlow/phys1/pdef1/pcond1/pcond2/pg1');
model.result('pg3').feature.create('surf1', 'Surface');
model.result('pg3').feature('surf1').label('Surface');
model.result('pg3').feature('surf1').set('showsolutionparams', 'on');
model.result('pg3').feature('surf1').set('expr', 'fmf.ptot');
model.result('pg3').feature('surf1').set('resolution', 'norefine');
model.result('pg3').feature('surf1').set('smooth', 'internal');
model.result('pg3').feature('surf1').set('showsolutionparams', 'on');
model.result('pg3').feature('surf1').set('data', 'parent');
model.result('pg1').run;
model.result.dataset.create('mir1', 'Mirror3D');
model.result.dataset('mir1').set('quickplane', 'zx');
model.result('pg1').run;
model.result('pg1').set('data', 'mir1');
model.result('pg1').run;
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
model.param.descr('M', 'Particle mass');

model.physics('pt').feature('pp1').set('mp', 'M');
model.physics('pt').create('inl1', 'Inlet', 2);
model.physics('pt').feature('inl1').selection.set([1]);
model.physics('pt').feature('inl1').set('InitialPosition', 'ProjectedPlaneGrid');
model.physics('pt').feature('inl1').setIndex('N', 10000, 0);
model.physics('pt').feature('inl1').set('InitialVelocity', 'Thermal');
model.physics('pt').feature('inl1').set('T', 'T0');
model.physics('pt').create('tre1', 'ThermalReEmission', 2);
model.physics('pt').feature('tre1').selection.all;
model.physics('pt').feature('tre1').set('T', 'T0');
model.physics('pt').create('tre2', 'ThermalReEmission', 2);
model.physics('pt').feature('tre2').selection.set([18]);
model.physics('pt').feature('tre2').set('T', 'T0');
model.physics('pt').feature('tre2').set('gammaf', 'frac');
model.physics('pt').create('pcnt1', 'ParticleCounter', 2);
model.physics('pt').feature('pcnt1').selection.set([18]);
model.physics('pt').feature('pcnt1').set('ReleaseFeature', 'inl1');
model.physics('pt').create('wall2', 'Wall', 2);
model.physics('pt').feature('wall2').selection.set([1]);
model.physics('pt').feature('wall2').set('WallCondition', 'Disappear');
model.physics('pt').create('wall3', 'Wall', 2);
model.physics('pt').feature('wall3').selection.set([2 5]);
model.physics('pt').feature('wall3').set('WallCondition', 'Bounce');

model.mesh.create('mesh2', 'geom1');
model.mesh('mesh2').autoMeshSize(1);
model.mesh('mesh2').run;

model.study('std2').feature('time').set('tlist', 'range(0,0.03/49,0.03)');
model.study('std2').feature('time').setEntry('mesh', 'geom1', 'mesh2');

model.sol.create('sol2');
model.sol('sol2').study('std2');
model.sol('sol2').create('st1', 'StudyStep');
model.sol('sol2').feature('st1').set('study', 'std2');
model.sol('sol2').feature('st1').set('studystep', 'time');
model.sol('sol2').create('v1', 'Variables');
model.sol('sol2').feature('v1').set('control', 'time');
model.sol('sol2').create('t1', 'Time');
model.sol('sol2').feature('t1').set('tlist', 'range(0,0.03/49,0.03)');
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
model.sol('sol2').feature('t1').set('initialstepgenalphaactive', true);
model.sol('sol2').feature('t1').set('initialstepgenalpha', '1e-8');
model.sol('sol2').feature('t1').set('maxstepconstraintgenalpha', 'const');
model.sol('sol2').feature('t1').set('maxstepgenalpha', '1e-4');
model.sol('sol2').runAll;

model.result.dataset.create('part1', 'Particle');
model.result.dataset('part1').set('solution', 'sol2');
model.result.dataset('part1').set('posdof', {'comp1.qx' 'comp1.qy' 'comp1.qz'});
model.result.dataset('part1').set('geom', 'geom1');
model.result.dataset('part1').set('pgeom', 'pgeom_pt');
model.result.dataset('part1').set('pgeomspec', 'fromphysics');
model.result.dataset('part1').set('physicsinterface', 'pt');
model.result.create('pg4', 'PlotGroup3D');
model.result('pg4').set('data', 'part1');
model.result('pg4').setIndex('looplevel', 50, 0);
model.result('pg4').label('Particle Trajectories (pt)');
model.result('pg4').create('traj1', 'ParticleTrajectories');
model.result('pg4').feature('traj1').set('pointtype', 'point');
model.result('pg4').feature('traj1').set('linetype', 'none');
model.result('pg4').feature('traj1').create('col1', 'Color');
model.result('pg4').feature('traj1').feature('col1').set('expr', 'pt.V');
model.result('pg4').run;
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
model.result('pg4').run;

model.title('Molecular Flow Through an RF Coupler');

model.description(['This example computes the transmission probability through an RF coupler using both the angular coefficient method available in the Free Molecular Flow interface and a Monte Carlo method using the Mathematical Particle Tracing interface. The computed transmission probability by the two methods is in excellent agreement, less than 1% difference.' newline  newline 'This example requires the Particle Tracing Module.']);

model.mesh.clearMeshes;

model.sol('sol1').clearSolutionData;
model.sol('sol2').clearSolutionData;

model.label('rf_coupler.mph');

model.modelNode.label('Components');

out = model;
