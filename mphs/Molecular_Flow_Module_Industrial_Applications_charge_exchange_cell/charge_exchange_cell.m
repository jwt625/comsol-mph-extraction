function out = model
%
% charge_exchange_cell.m
%
% Model exported on May 26 2025, 21:30 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/Molecular_Flow_Module/Industrial_Applications');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 3);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.physics.create('fmf', 'FreeMolecularFlow', 'geom1', {'G'});
model.physics.create('es', 'Electrostatics', 'geom1');
model.physics('es').model('comp1');
model.physics.create('cpt', 'ChargedParticleTracing', 'geom1');
model.physics('cpt').model('comp1');

% To import content from file, use:
% model.param.loadFile('FILENAME');
model.param.set('M_gas', '40[g/mol]', 'Molar mass: neutral gas (Ar)');
model.param.set('M_p', '1[g/mol]', 'Molar mass: particles (H+)');
model.param.set('E_p', '1[keV]', 'Energy: particles (H+)');
model.param.set('N0', '1000', 'Number of particles');
model.param.set('E1', '2.16[eV]', 'Energy loss collision 1');
model.param.set('E2', '13.6[eV]', 'Energy loss collision 2');
model.param.set('E3', '15.6[eV]', 'Energy loss collision 3');

model.func.create('int1', 'Interpolation');
model.func('int1').model('comp1');
model.func('int1').label('Ar+H+=>H+Ar+');
model.func('int1').set('source', 'file');
model.func('int1').set('filename', 'charge_exchange_cell_Qex1.txt');
model.func('int1').importData;
model.func('int1').set('funcname', 'Qex1');
model.func('int1').setIndex('argunit', 'eV', 0);
model.func('int1').setIndex('fununit', 'm^2', 0);
model.func.create('int2', 'Interpolation');
model.func('int2').model('comp1');
model.func('int2').label('H+Ar=>Ar+H+');
model.func('int2').set('source', 'file');
model.func('int2').set('filename', 'charge_exchange_cell_Qex2.txt');
model.func('int2').importData;
model.func('int2').set('funcname', 'Qex2');
model.func('int2').setIndex('argunit', 'eV', 0);
model.func('int2').setIndex('fununit', 'm^2', 0);
model.func.create('int3', 'Interpolation');
model.func('int3').model('comp1');
model.func('int3').label('H+Ar=>H+Ar+');
model.func('int3').set('source', 'file');
model.func('int3').set('filename', 'charge_exchange_cell_Qex3.txt');
model.func('int3').importData;
model.func('int3').set('funcname', 'Qex3');
model.func('int3').setIndex('argunit', 'eV', 0);
model.func('int3').setIndex('fununit', 'm^2', 0);

model.geom('geom1').insertFile('charge_exchange_cell_geom_sequence.mph', 'geom1');
model.geom('geom1').run('fin');

model.view('view1').set('renderwireframe', true);

model.physics('fmf').feature('fmfp1').setIndex('Mn_G', 'M_gas', 0);
model.physics('fmf').create('wall2', 'Wall', 2);
model.physics('fmf').feature('wall2').set('BCType', 'OutgassingWall');
model.physics('fmf').feature('wall2').set('BoundaryCondition', 'NumberOfSCCM');
model.physics('fmf').feature('wall2').setIndex('sccmmfr', 0.05, 0);
model.physics('fmf').feature('wall2').set('StandardFlowRateDefinedBy', 'StandardP');
model.physics('fmf').feature('wall2').selection.set([35 36 69 71]);
model.physics('fmf').create('pmp1', 'VacuumPump', 2);
model.physics('fmf').feature('pmp1').selection.set([6]);
model.physics('fmf').feature('pmp1').set('SpecifyPump', 'PumpSpeed');
model.physics('fmf').feature('pmp1').setIndex('pspeed', '63[l/s]', 0);
model.physics('fmf').create('ndr1', 'NumberDensityReconDomain', 3);
model.physics('fmf').feature('ndr1').selection.set([1]);
model.physics('es').create('pot1', 'ElectricPotential', 2);
model.physics('es').feature('pot1').set('V0', '200[V]');
model.physics('es').feature('pot1').selection.set([41 42 43 44 46 90]);
model.physics('es').create('gnd1', 'Ground', 2);
model.physics('es').feature('gnd1').selection.set([1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40 45 48 49 50 51 52 53 54 55 56 57 58 59 60 61 62 63 64 65 66 67 68 69 70 71 72 73 74 75 76 77 78 79 80 81 82 83 84 85 86 87 88 89]);

model.material.create('mat1', 'Common', 'comp1');
model.material('mat1').propertyGroup('def').set('relpermittivity', {'1'});

model.physics('cpt').prop('MaximumSecondary').setIndex('MaximumSecondary', 500, 0);
model.physics('cpt').feature('pp1').label('H+');
model.physics('cpt').feature('pp1').set('mp', 'M_p/N_A_const');
model.physics('cpt').feature('pp1').set('Z', 1);
model.physics('cpt').create('pp2', 'ParticlePropertiesOther', -1);
model.physics('cpt').feature('pp2').set('mp', 'M_p/N_A_const');
model.physics('cpt').feature('pp2').set('Z', 0);
model.physics('cpt').feature('pp2').label('H');
model.physics('cpt').create('pp3', 'ParticlePropertiesOther', -1);
model.physics('cpt').feature('pp3').label('Ar+');
model.physics('cpt').feature('pp3').set('mp', 'M_gas/N_A_const');
model.physics('cpt').feature('pp3').set('Z', 1);
model.physics('cpt').create('pbeam1', 'ParticleBeam', 2);
model.physics('cpt').feature('pbeam1').selection.set([47]);
model.physics('cpt').feature('pbeam1').setIndex('N', 'N0', 0);
model.physics('cpt').feature('pbeam1').set('e1rms', '0.1[um]');
model.physics('cpt').feature('pbeam1').set('El', '1[keV]');
model.physics('cpt').create('ef1', 'ElectricForce', 3);
model.physics('cpt').feature('ef1').selection.set([1]);
model.physics('cpt').feature('ef1').set('E_src', 'root.comp1.es.Ex');
model.physics('cpt').create('col1', 'Collisions', 3);
model.physics('cpt').feature('col1').label('Ar+H+=>H+Ar+');
model.physics('cpt').feature('col1').selection.set([1]);
model.physics('cpt').feature('col1').set('Nd', 'fmf.n_G');
model.physics('cpt').feature('col1').set('ParticlesToAffect', 'SingleSpecies');
model.physics('cpt').feature('col1').create('ncex1', 'NonResonantChargeExchange', 3);
model.physics('cpt').feature('col1').feature('ncex1').set('xsec', 'Qex1(cpt.Ep)');
model.physics('cpt').feature('col1').feature('ncex1').set('dE', 'E1');
model.physics('cpt').feature('col1').feature('ncex1').set('SpeciesToRelease', 'IonAndNeutral');
model.physics('cpt').feature('col1').feature('ncex1').set('ReleasedIonProperties', 'pp3');
model.physics('cpt').feature('col1').feature('ncex1').set('ReleasedNeutralProperties', 'pp2');
model.physics('cpt').feature('col1').feature('ncex1').set('CountCollisions', true);
model.physics('cpt').feature.duplicate('col2', 'col1');
model.physics('cpt').feature('col2').label('H+Ar=>Ar+H+');
model.physics('cpt').feature('col2').set('AffectedParticleProperties', 'pp2');
model.physics('cpt').feature('col2').feature('ncex1').set('xsec', 'Qex2(cpt.Ep)');
model.physics('cpt').feature('col2').feature('ncex1').set('dE', 'E2');
model.physics('cpt').feature('col2').feature('ncex1').set('SpeciesToRelease', 'Ion');
model.physics('cpt').feature('col2').feature('ncex1').set('ReleasedIonProperties', 'pp1');
model.physics('cpt').feature.duplicate('col3', 'col2');
model.physics('cpt').feature('col3').label('H+Ar=>H+Ar+');
model.physics('cpt').feature('col3').feature('ncex1').set('xsec', 'Qex3(cpt.Ep)');
model.physics('cpt').feature('col3').feature('ncex1').set('dE', 'E3');
model.physics('cpt').feature('col3').feature('ncex1').set('ReleasedIonProperties', 'pp3');

model.variable.create('var1');
model.variable('var1').model('comp1');
model.variable('var1').set('Nc1', 'cpt.sum(cpt.col1.ncex1.Nc)');
model.variable('var1').descr('Nc1', 'Number of collisions, type 1');
model.variable('var1').set('Nc2', 'cpt.sum(cpt.col2.ncex1.Nc)');
model.variable('var1').descr('Nc2', 'Number of collisions, type 2');
model.variable('var1').set('Nc3', 'cpt.sum(cpt.col3.ncex1.Nc)');
model.variable('var1').descr('Nc3', 'Number of collisions, type 3');
model.variable('var1').set('Nctot', 'Nc1+Nc2+Nc3');
model.variable('var1').descr('Nctot', 'Total number of collisions');

model.selection.create('box1', 'Box');
model.selection('box1').model('comp1');
model.selection('box1').set('xmin', 0);
model.selection('box1').set('entitydim', 2);
model.selection('box1').set('condition', 'allvertices');

model.mesh('mesh1').automatic(false);
model.mesh('mesh1').feature('size').set('hauto', 4);
model.mesh('mesh1').feature('ftet1').create('size1', 'Size');
model.mesh('mesh1').feature('ftet1').feature('size1').selection.geom('geom1', 1);
model.mesh('mesh1').feature('ftet1').feature('size1').selection.set([33 34 43 44 46 47 48 49 71 72 74 75 98 99 101 103 114 117 126 128 140 142 145 146]);
model.mesh('mesh1').feature('ftet1').feature('size1').set('hauto', 3);
model.mesh('mesh1').run;

model.study.create('std1');
model.study('std1').create('stat', 'Stationary');
model.study('std1').feature('stat').setSolveFor('/physics/fmf', true);
model.study('std1').feature('stat').setSolveFor('/physics/es', true);
model.study('std1').feature('stat').setSolveFor('/physics/cpt', false);

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
model.sol('sol1').feature('s1').feature('se1').feature('ss1').set('segvar', {'comp1_V'});
model.sol('sol1').feature('s1').create('i1', 'Iterative');
model.sol('sol1').feature('s1').feature('i1').set('linsolver', 'cg');
model.sol('sol1').feature('s1').feature('i1').create('mg1', 'Multigrid');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').set('prefun', 'amg');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').set('coarseningmethod', 'classic');
model.sol('sol1').feature('s1').feature('se1').feature('ss1').set('linsolver', 'i1');
model.sol('sol1').feature('s1').feature('se1').feature('ss1').label('Electrostatics');
model.sol('sol1').feature('s1').feature('se1').create('ss2', 'SegregatedStep');
model.sol('sol1').feature('s1').feature('se1').feature('ss2').set('segvar', {'comp1_G'});
model.sol('sol1').feature('s1').create('i2', 'Iterative');
model.sol('sol1').feature('s1').feature('i2').set('linsolver', 'gmres');
model.sol('sol1').feature('s1').feature('i2').create('mg1', 'Multigrid');
model.sol('sol1').feature('s1').feature('i2').feature('mg1').set('prefun', 'gmg');
model.sol('sol1').feature('s1').feature('i2').feature('mg1').set('mcasegen', 'any');
model.sol('sol1').feature('s1').feature('i2').feature('mg1').feature('pr').create('sl1', 'SORLine');
model.sol('sol1').feature('s1').feature('i2').feature('mg1').feature('pr').feature('sl1').set('iter', 2);
model.sol('sol1').feature('s1').feature('i2').feature('mg1').feature('pr').feature('sl1').set('linerelax', 0.2);
model.sol('sol1').feature('s1').feature('i2').feature('mg1').feature('pr').feature('sl1').set('seconditer', 1);
model.sol('sol1').feature('s1').feature('i2').feature('mg1').feature('pr').feature('sl1').set('relax', 0.4);
model.sol('sol1').feature('s1').feature('i2').feature('mg1').feature('po').create('sl1', 'SORLine');
model.sol('sol1').feature('s1').feature('i2').feature('mg1').feature('po').feature('sl1').set('iter', 2);
model.sol('sol1').feature('s1').feature('i2').feature('mg1').feature('po').feature('sl1').set('linerelax', 0.2);
model.sol('sol1').feature('s1').feature('i2').feature('mg1').feature('po').feature('sl1').set('seconditer', 2);
model.sol('sol1').feature('s1').feature('i2').feature('mg1').feature('po').feature('sl1').set('relax', 0.4);
model.sol('sol1').feature('s1').feature('i2').feature('mg1').feature('cs').create('d1', 'Direct');
model.sol('sol1').feature('s1').feature('i2').feature('mg1').feature('cs').feature('d1').set('linsolver', 'pardiso');
model.sol('sol1').feature('s1').feature('i2').feature('mg1').feature('cs').feature('d1').set('pivotperturb', 1.0E-13);
model.sol('sol1').feature('s1').feature('se1').feature('ss2').set('linsolver', 'i2');
model.sol('sol1').feature('s1').feature('se1').create('ss3', 'SegregatedStep');
model.sol('sol1').feature('s1').feature('se1').feature('ss3').set('segvar', {'comp1_fmf_p_G'});
model.sol('sol1').feature('s1').feature('se1').feature('ss3').set('linsolver', 'i2');
model.sol('sol1').feature('s1').feature('se1').create('ss4', 'SegregatedStep');
model.sol('sol1').feature('s1').feature('se1').feature('ss4').set('segvar', {'comp1_fmf_N_G' 'comp1_fmf_ndr1_Nr_G'});
model.sol('sol1').feature('s1').feature('se1').feature('ss4').set('linsolver', 'i2');
model.sol('sol1').feature('s1').feature.remove('fcDef');
model.sol('sol1').attach('std1');
model.sol('sol1').feature('s1').feature('i2').feature('mg1').set('scale', 1);

model.study('std1').setGenPlots(false);

model.sol('sol1').runAll;

model.result.dataset.duplicate('dset2', 'dset1');
model.result.dataset('dset2').label('Study 1/Solution 1 Box Selection');
model.result.dataset('dset2').selection.geom('geom1', 2);
model.result.dataset('dset2').selection.named('box1');
model.result.dataset.create('cln1', 'CutLine3D');
model.result.dataset('cln1').setIndex('genpoints', -100, 0, 1);
model.result.dataset('cln1').setIndex('genpoints', 100, 1, 1);
model.result.dataset('cln1').setIndex('genpoints', 0, 1, 0);
model.result.create('pg1', 'PlotGroup3D');
model.result('pg1').run;
model.result('pg1').label('Electric Potential');
model.result('pg1').create('slc1', 'Slice');
model.result('pg1').feature('slc1').set('quickxnumber', 1);
model.result('pg1').feature('slc1').set('expr', 'V');
model.result('pg1').feature('slc1').set('colortable', 'AuroraAustralis');
model.result('pg1').run;
model.result.create('pg2', 'PlotGroup3D');
model.result('pg2').run;
model.result('pg2').label('Pressure');
model.result('pg2').set('data', 'dset2');
model.result('pg2').create('surf1', 'Surface');
model.result('pg2').feature('surf1').set('expr', 'fmf.ptot');
model.result('pg2').feature('surf1').set('colortable', 'AuroraAustralis');
model.result('pg2').run;
model.result.create('pg3', 'PlotGroup1D');
model.result('pg3').run;
model.result('pg3').label('Gas Number Density');
model.result('pg3').set('data', 'cln1');
model.result('pg3').create('lngr1', 'LineGraph');
model.result('pg3').feature('lngr1').set('markerpos', 'datapoints');
model.result('pg3').feature('lngr1').set('linewidth', 'preference');
model.result('pg3').feature('lngr1').set('expr', 'fmf.ntot');
model.result('pg3').run;

model.study.create('std2');
model.study('std2').create('time', 'Transient');
model.study('std2').feature('time').setSolveFor('/physics/fmf', false);
model.study('std2').feature('time').setSolveFor('/physics/es', false);
model.study('std2').feature('time').setSolveFor('/physics/cpt', true);
model.study('std2').feature('time').set('tunit', [native2unicode(hex2dec({'00' 'b5'}), 'unicode') 's']);
model.study('std2').feature('time').set('tlist', 'range(0,0.01,0.5)');
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
model.sol('sol2').feature('t1').set('tlist', 'range(0,0.01,0.5)');
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
model.sol('sol2').feature('t1').set('maxstepconstraintgenalpha', 'const');
model.sol('sol2').feature('t1').set('maxstepgenalpha', '10[ns]');
model.sol('sol2').runAll;

model.result.dataset.create('part1', 'Particle');
model.result.dataset('part1').set('solution', 'sol2');
model.result.dataset('part1').set('posdof', {'comp1.qx' 'comp1.qy' 'comp1.qz'});
model.result.dataset('part1').set('geom', 'geom1');
model.result.dataset('part1').set('pgeom', 'pgeom_cpt');
model.result.dataset('part1').set('pgeomspec', 'fromphysics');
model.result.dataset('part1').set('physicsinterface', 'cpt');
model.result.create('pg4', 'PlotGroup3D');
model.result('pg4').set('data', 'part1');
model.result('pg4').setIndex('looplevel', 51, 0);
model.result('pg4').label('Particle Trajectories (cpt)');
model.result('pg4').create('traj1', 'ParticleTrajectories');
model.result('pg4').feature('traj1').set('pointtype', 'point');
model.result('pg4').feature('traj1').set('linetype', 'none');
model.result('pg4').feature('traj1').create('col1', 'Color');
model.result('pg4').feature('traj1').feature('col1').set('expr', 'cpt.V');
model.result.create('pg5', 'PlotGroup3D');
model.result('pg5').set('data', 'part1');
model.result('pg5').setIndex('looplevel', 51, 0);
model.result('pg5').label('Average Beam Position (cpt)');
model.result('pg5').create('pttraj1', 'PointTrajectories');
model.result('pg5').feature('pttraj1').set('plotdata', 'global');
model.result('pg5').feature('pttraj1').set('globalexpr', {'cpt.qavx' 'cpt.qavy' 'cpt.qavz'});
model.result('pg5').feature('pttraj1').create('col1', 'Color');
model.result('pg5').feature('pttraj1').feature('col1').set('expr', 'cpt.e1hrms');
model.result('pg4').run;
model.result('pg4').run;
model.result('pg4').feature('traj1').set('linetype', 'line');
model.result('pg4').run;
model.result('pg4').feature('traj1').feature('col1').set('expr', 'cpt.Z');
model.result('pg4').feature('traj1').feature('col1').set('colortable', 'RainbowLight');
model.result('pg4').run;
model.result.dataset.duplicate('part2', 'part1');
model.result.dataset('part2').selection.geom('geom1', 2);
model.result.dataset('part2').selection.set([8]);
model.result.numerical.create('gev1', 'EvalGlobal');
model.result.numerical('gev1').label('Efficiency');
model.result.numerical('gev1').set('data', 'part2');
model.result.numerical('gev1').setIndex('looplevelinput', 'last', 0);
model.result.numerical('gev1').setIndex('expr', 'cpt.Nsel/N0*100', 0);
model.result.numerical.duplicate('gev2', 'gev1');
model.result.numerical('gev2').label('Nc1/Nctot');
model.result.numerical('gev2').setIndex('expr', 'Nc1/Nctot*100', 0);
model.result.numerical.duplicate('gev3', 'gev2');
model.result.numerical('gev3').label('Nc2/Nctot');
model.result.numerical('gev3').setIndex('expr', 'Nc2/Nctot*100', 0);
model.result.numerical.duplicate('gev4', 'gev3');
model.result.numerical('gev4').label('Nc3/Nctot');
model.result.numerical('gev4').setIndex('expr', 'Nc3/Nctot*100', 0);
model.result.table.create('tbl1', 'Table');
model.result.table('tbl1').comments('Efficiency');
model.result.numerical('gev1').set('table', 'tbl1');
model.result.numerical('gev1').setResult;
model.result.table.create('tbl2', 'Table');
model.result.table('tbl2').comments('Nc1/Nctot');
model.result.numerical('gev2').set('table', 'tbl2');
model.result.numerical('gev2').setResult;
model.result.table.create('tbl3', 'Table');
model.result.table('tbl3').comments('Nc2/Nctot');
model.result.numerical('gev3').set('table', 'tbl3');
model.result.numerical('gev3').setResult;
model.result.table.create('tbl4', 'Table');
model.result.table('tbl4').comments('Nc3/Nctot');
model.result.numerical('gev4').set('table', 'tbl4');
model.result.numerical('gev4').setResult;

model.title('Neutralization of a Proton Beam Through a Charge Exchange Cell');

model.description(['Gas cells have several applications in scientific instruments design. A gas cell is used to define a high pressure region within an instrument''s main vacuum system. In this example, a high-pressure region 100' native2unicode(hex2dec({'00' 'a0'}), 'unicode') 'mm long with an operating pressure of 1e-3 Torr is placed within a main vacuum system with an operating pressure of 1e-5 Torr. The gas cell is used to neutralize a proton beam via charge exchange reactions with the buffer gas, creating a beam of energetic neutral atoms. In mass spectrometry typical applications are the removal of mass spectral interferences in Inductively Coupled Plasma Mass Spectrometry (ICPMS) or as a collision cell promoting ion molecule reactions or fragmentation in tandem mass spectrometry (MS-MS).']);

model.mesh.clearMeshes;

model.sol('sol1').clearSolutionData;
model.sol('sol2').clearSolutionData;

model.label('charge_exchange_cell.mph');

model.modelNode.label('Components');

out = model;
