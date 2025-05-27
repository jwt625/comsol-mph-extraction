function out = model
%
% resistive_wafer.m
%
% Model exported on May 26 2025, 21:28 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/Electrodeposition_Module/Tutorials');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 3);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.physics.create('cd', 'SecondaryCurrentDistribution', 'geom1');
model.physics('cd').model('comp1');
model.physics.create('els', 'ElectrodeShell', 'geom1');
model.physics('els').model('comp1');
model.physics('els').field('electricpotential').field('phis_wafer');

model.study.create('std1');
model.study('std1').create('cdi', 'CurrentDistributionInitialization');
model.study('std1').feature('cdi').set('solnum', 'auto');
model.study('std1').feature('cdi').set('notsolnum', 'auto');
model.study('std1').feature('cdi').set('outputmap', {});
model.study('std1').feature('cdi').set('ngenAUX', '1');
model.study('std1').feature('cdi').set('goalngenAUX', '1');
model.study('std1').feature('cdi').set('ngenAUX', '1');
model.study('std1').feature('cdi').set('goalngenAUX', '1');
model.study('std1').feature('cdi').setSolveFor('/physics/cd', true);
model.study('std1').feature('cdi').setSolveFor('/physics/els', true);
model.study('std1').create('time', 'Transient');
model.study('std1').feature('time').set('initialtime', '0');
model.study('std1').feature('time').set('solnum', 'auto');
model.study('std1').feature('time').set('notsolnum', 'auto');
model.study('std1').feature('time').set('outputmap', {});
model.study('std1').feature('time').setSolveFor('/physics/cd', true);
model.study('std1').feature('time').setSolveFor('/physics/els', true);

model.geom('geom1').insertFile('resistive_wafer_geom_sequence.mph', 'geom1');

% To import content from file, use:
% model.param.loadFile('FILENAME');
model.param.set('sigma', '20[S/m]', 'Electrolyte conductivity');
model.param.set('i0_cathode', '0.1[A/m^2]', 'Exchange current density, cathode');
model.param.set('Eeq_cathode', '0.2[V]', 'Equilibrium potential, cathode');
model.param.set('T', '293.15[K]', 'Temperature');
model.param.set('alpha_a', '0.5', 'Anodic transfer coefficient, cathode');
model.param.set('alpha_c', '0.5', 'Cathodic transfer coefficient, cathode');
model.param.set('w', '5.6e7[S/m]', 'Conductivity, deposited layer');
model.param.set('rho', '8e6[g/m^3]', 'Metal deposit density');
model.param.set('M', '65[g/mol]', 'Molar weight, metal deposit');
model.param.set('s_init', '0.1e-6[m]', 'Initial metal layer thickness');
model.param.set('I_cell', '0.4[A]', 'Cell current');

model.selection.create('sel1', 'Explicit');
model.selection('sel1').model('comp1');

model.geom('geom1').run;

model.selection('sel1').geom(2);
model.selection('sel1').set([15 16 17]);
model.selection('sel1').label('Wafer surface');
model.selection.create('sel2', 'Explicit');
model.selection('sel2').model('comp1');
model.selection('sel2').geom(2);
model.selection('sel2').set([17]);
model.selection('sel2').label('Cathode');
model.selection.create('sel3', 'Explicit');
model.selection('sel3').model('comp1');
model.selection('sel3').geom(2);
model.selection('sel3').set([6]);
model.selection('sel3').label('Anode');

model.physics('cd').feature('ice1').set('sigmal_mat', 'userdef');
model.physics('cd').feature('ice1').set('sigmal', {'sigma' '0' '0' '0' 'sigma' '0' '0' '0' 'sigma'});
model.physics('cd').create('ic1', 'ElectrolyteCurrent', 2);
model.physics('cd').feature('ic1').selection.named('sel3');
model.physics('cd').feature('ic1').set('Itl', 'I_cell');
model.physics('cd').create('es1', 'ElectrodeSurface', 2);
model.physics('cd').feature('es1').selection.named('sel2');
model.physics('cd').feature('es1').set('phisext0', 'phis_wafer');
model.physics('cd').feature('es1').setIndex('Species', 's1', 0, 0);
model.physics('cd').feature('es1').setIndex('rhos', 8960, 0, 0);
model.physics('cd').feature('es1').setIndex('Ms', 0.06355, 0, 0);
model.physics('cd').feature('es1').setIndex('Species', 's1', 0, 0);
model.physics('cd').feature('es1').setIndex('rhos', 8960, 0, 0);
model.physics('cd').feature('es1').setIndex('Ms', 0.06355, 0, 0);
model.physics('cd').feature('es1').setIndex('rhos', 'rho', 0, 0);
model.physics('cd').feature('es1').setIndex('Ms', 'M', 0, 0);
model.physics('cd').feature('es1').feature('er1').set('nm', 2);
model.physics('cd').feature('es1').feature('er1').setIndex('Vib', 1, 0, 0);
model.physics('cd').feature('es1').feature('er1').set('Eeq', 'Eeq_cathode');
model.physics('cd').feature('es1').feature('er1').set('ElectrodeKinetics', 'ButlerVolmer');
model.physics('cd').feature('es1').feature('er1').set('i0', 'i0_cathode');
model.physics('cd').feature('es1').feature('er1').set('alphaa', 'alpha_a');
model.physics('cd').feature('es1').feature('er1').set('alphac', 'alpha_c');
model.physics('cd').feature('init1').set('phil', '-Eeq_cathode');
model.physics('els').selection.named('sel1');
model.physics('els').create('depe1', 'DepositingElectrode', 2);
model.physics('els').feature('depe1').selection.named('sel2');
model.physics('els').feature('depe1').set('s0', 's_init');
model.physics('els').feature('depe1').set('deltas_src', 'root.comp1.cd.sbtot');
model.physics('els').feature('depe1').set('sigma_mat', 'userdef');
model.physics('els').feature('depe1').set('sigma', {'w' '0' '0' '0' 'w' '0' '0' '0' 'w'});
model.physics('els').feature('depe1').set('in_src', 'root.comp1.cd.es1.er1.iloc');
model.physics('els').feature('ece1').set('s', 's_init');
model.physics('els').feature('ece1').set('sigma_mat', 'userdef');
model.physics('els').feature('ece1').set('sigma', {'w' '0' '0' '0' 'w' '0' '0' '0' 'w'});
model.physics('els').create('gnd1', 'Ground', 1);
model.physics('els').feature('gnd1').selection.set([34]);

model.common('cminpt').set('modified', {'temperature' 'T'});

model.mesh('mesh1').automatic(false);
model.mesh('mesh1').feature('size').set('hauto', 3);
model.mesh('mesh1').feature('ftet1').create('size1', 'Size');
model.mesh('mesh1').feature('ftet1').feature('size1').selection.geom('geom1', 2);
model.mesh('mesh1').feature('ftet1').feature('size1').selection.named('sel1');
model.mesh('mesh1').feature('ftet1').feature('size1').set('custom', true);
model.mesh('mesh1').feature('ftet1').feature('size1').set('hmaxactive', true);
model.mesh('mesh1').feature('ftet1').feature('size1').set('hmax', '2[mm]');
model.mesh('mesh1').run;

model.sol.create('sol1');
model.sol('sol1').study('std1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'cdi');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').feature('comp1_phil').set('scalemethod', 'manual');
model.sol('sol1').feature('v1').feature('comp1_cd_ic1_phil0').set('scalemethod', 'manual');
model.sol('sol1').feature('v1').feature('comp1_phil').set('scaleval', '1');
model.sol('sol1').feature('v1').feature('comp1_cd_ic1_phil0').set('scaleval', '1');
model.sol('sol1').feature('v1').set('control', 'cdi');
model.sol('sol1').create('s1', 'Stationary');
model.sol('sol1').feature('s1').set('stol', 1.0E-4);
model.sol('sol1').feature('s1').create('se1', 'Segregated');
model.sol('sol1').feature('s1').feature('se1').feature.remove('ssDef');
model.sol('sol1').feature('s1').feature('se1').create('ss1', 'SegregatedStep');
model.sol('sol1').feature('s1').feature('se1').feature('ss1').set('segvar', {'comp1_phil' 'comp1_cd_ic1_phil0'});
model.sol('sol1').feature('s1').feature('se1').feature('ss1').set('subjtech', 'onevery');
model.sol('sol1').feature('s1').create('d1', 'Direct');
model.sol('sol1').feature('s1').feature('d1').set('linsolver', 'pardiso');
model.sol('sol1').feature('s1').feature('d1').label('Direct (cd)');
model.sol('sol1').feature('s1').feature('se1').feature('ss1').set('linsolver', 'd1');
model.sol('sol1').feature('s1').feature('se1').feature('ss1').label('Current Distribution');
model.sol('sol1').feature('s1').feature('se1').create('ss2', 'SegregatedStep');
model.sol('sol1').feature('s1').feature('se1').feature('ss2').set('segvar', {'comp1_phis_wafer'});
model.sol('sol1').feature('s1').feature('se1').feature('ss2').set('linsolver', 'dDef');
model.sol('sol1').feature('s1').feature('se1').feature('ss2').label('Electrode, Shell');
model.sol('sol1').feature('s1').create('i1', 'Iterative');
model.sol('sol1').feature('s1').feature('i1').set('maxlinit', 1000);
model.sol('sol1').feature('s1').feature('i1').set('nlinnormuse', 'on');
model.sol('sol1').feature('s1').feature('i1').label('Algebraic Multigrid (cd)');
model.sol('sol1').feature('s1').feature('i1').create('mg1', 'Multigrid');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').set('prefun', 'saamg');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').set('maxcoarsedof', 50000);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').set('saamgcompwise', true);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').set('compactaggregation', true);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('pr').create('sc1', 'SCGS');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('pr').feature('sc1').set('linesweeptype', 'ssor');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('pr').feature('sc1').set('iter', 1);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('pr').feature('sc1').set('scgsmethod', 'lines');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('po').create('sc1', 'SCGS');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('po').feature('sc1').set('linesweeptype', 'ssor');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('po').feature('sc1').set('iter', 1);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('po').feature('sc1').set('scgsmethod', 'lines');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('cs').create('d1', 'Direct');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('cs').feature('d1').set('linsolver', 'pardiso');
model.sol('sol1').feature('s1').create('i2', 'Iterative');
model.sol('sol1').feature('s1').feature('i2').set('maxlinit', 1000);
model.sol('sol1').feature('s1').feature('i2').set('nlinnormuse', 'on');
model.sol('sol1').feature('s1').feature('i2').label('Geometric Multigrid (cd)');
model.sol('sol1').feature('s1').feature('i2').create('mg1', 'Multigrid');
model.sol('sol1').feature('s1').feature('i2').feature('mg1').feature('pr').create('sc1', 'SCGS');
model.sol('sol1').feature('s1').feature('i2').feature('mg1').feature('pr').feature('sc1').set('linesweeptype', 'ssor');
model.sol('sol1').feature('s1').feature('i2').feature('mg1').feature('pr').feature('sc1').set('iter', 1);
model.sol('sol1').feature('s1').feature('i2').feature('mg1').feature('pr').feature('sc1').set('scgsmethod', 'lines');
model.sol('sol1').feature('s1').feature('i2').feature('mg1').feature('po').create('sc1', 'SCGS');
model.sol('sol1').feature('s1').feature('i2').feature('mg1').feature('po').feature('sc1').set('linesweeptype', 'ssor');
model.sol('sol1').feature('s1').feature('i2').feature('mg1').feature('po').feature('sc1').set('iter', 1);
model.sol('sol1').feature('s1').feature('i2').feature('mg1').feature('po').feature('sc1').set('scgsmethod', 'lines');
model.sol('sol1').feature('s1').feature('i2').feature('mg1').feature('cs').create('d1', 'Direct');
model.sol('sol1').feature('s1').feature('i2').feature('mg1').feature('cs').feature('d1').set('linsolver', 'pardiso');
model.sol('sol1').feature('s1').feature.remove('fcDef');
model.sol('sol1').create('su1', 'StoreSolution');
model.sol('sol1').create('st2', 'StudyStep');
model.sol('sol1').feature('st2').set('study', 'std1');
model.sol('sol1').feature('st2').set('studystep', 'time');
model.sol('sol1').create('v2', 'Variables');
model.sol('sol1').feature('v2').feature('comp1_phil').set('scalemethod', 'manual');
model.sol('sol1').feature('v2').feature('comp1_cd_ic1_phil0').set('scalemethod', 'manual');
model.sol('sol1').feature('v2').feature('comp1_phil').set('scaleval', '1');
model.sol('sol1').feature('v2').feature('comp1_cd_ic1_phil0').set('scaleval', '1');
model.sol('sol1').feature('v2').set('initmethod', 'sol');
model.sol('sol1').feature('v2').set('initsol', 'sol1');
model.sol('sol1').feature('v2').set('initsoluse', 'sol2');
model.sol('sol1').feature('v2').set('notsolmethod', 'sol');
model.sol('sol1').feature('v2').set('notsol', 'sol1');
model.sol('sol1').feature('v2').set('notsoluse', 'sol2');
model.sol('sol1').feature('v2').set('control', 'time');
model.sol('sol1').create('t1', 'Time');
model.sol('sol1').feature('t1').set('tlist', 'range(0,0.1,1)');
model.sol('sol1').feature('t1').set('plot', 'off');
model.sol('sol1').feature('t1').set('plotgroup', 'Default');
model.sol('sol1').feature('t1').set('plotfreq', 'tout');
model.sol('sol1').feature('t1').set('probesel', 'all');
model.sol('sol1').feature('t1').set('probes', {});
model.sol('sol1').feature('t1').set('probefreq', 'tsteps');
model.sol('sol1').feature('t1').set('rtol', 0.001);
model.sol('sol1').feature('t1').set('atolglobalvaluemethod', 'factor');
model.sol('sol1').feature('t1').set('eventout', true);
model.sol('sol1').feature('t1').set('reacf', true);
model.sol('sol1').feature('t1').set('storeudot', true);
model.sol('sol1').feature('t1').set('endtimeinterpolation', true);
model.sol('sol1').feature('t1').set('maxorder', 2);
model.sol('sol1').feature('t1').set('control', 'time');
model.sol('sol1').feature('t1').create('se1', 'Segregated');
model.sol('sol1').feature('t1').feature('se1').feature.remove('ssDef');
model.sol('sol1').feature('t1').feature('se1').create('ss1', 'SegregatedStep');
model.sol('sol1').feature('t1').feature('se1').feature('ss1').set('segvar', {'comp1_phil' 'comp1_cd_es1_c' 'comp1_cd_ic1_phil0'});
model.sol('sol1').feature('t1').feature('se1').feature('ss1').set('subjtech', 'onevery');
model.sol('sol1').feature('t1').create('d1', 'Direct');
model.sol('sol1').feature('t1').feature('d1').set('linsolver', 'pardiso');
model.sol('sol1').feature('t1').feature('d1').label('Direct (cd)');
model.sol('sol1').feature('t1').feature('se1').feature('ss1').set('linsolver', 'd1');
model.sol('sol1').feature('t1').feature('se1').feature('ss1').label('Current Distribution');
model.sol('sol1').feature('t1').feature('se1').create('ss2', 'SegregatedStep');
model.sol('sol1').feature('t1').feature('se1').feature('ss2').set('segvar', {'comp1_phis_wafer'});
model.sol('sol1').feature('t1').feature('se1').feature('ss2').set('linsolver', 'dDef');
model.sol('sol1').feature('t1').feature('se1').feature('ss2').label('Electrode, Shell');
model.sol('sol1').feature('t1').create('i1', 'Iterative');
model.sol('sol1').feature('t1').feature('i1').set('maxlinit', 1000);
model.sol('sol1').feature('t1').feature('i1').set('nlinnormuse', 'on');
model.sol('sol1').feature('t1').feature('i1').label('Algebraic Multigrid (cd)');
model.sol('sol1').feature('t1').feature('i1').create('mg1', 'Multigrid');
model.sol('sol1').feature('t1').feature('i1').feature('mg1').set('prefun', 'saamg');
model.sol('sol1').feature('t1').feature('i1').feature('mg1').set('maxcoarsedof', 50000);
model.sol('sol1').feature('t1').feature('i1').feature('mg1').set('saamgcompwise', true);
model.sol('sol1').feature('t1').feature('i1').feature('mg1').set('compactaggregation', true);
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('pr').create('sc1', 'SCGS');
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('pr').feature('sc1').set('linesweeptype', 'ssor');
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('pr').feature('sc1').set('iter', 1);
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('pr').feature('sc1').set('scgsmethod', 'lines');
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('po').create('sc1', 'SCGS');
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('po').feature('sc1').set('linesweeptype', 'ssor');
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('po').feature('sc1').set('iter', 1);
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('po').feature('sc1').set('scgsmethod', 'lines');
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('cs').create('d1', 'Direct');
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('cs').feature('d1').set('linsolver', 'pardiso');
model.sol('sol1').feature('t1').create('i2', 'Iterative');
model.sol('sol1').feature('t1').feature('i2').set('maxlinit', 1000);
model.sol('sol1').feature('t1').feature('i2').set('nlinnormuse', 'on');
model.sol('sol1').feature('t1').feature('i2').label('Geometric Multigrid (cd)');
model.sol('sol1').feature('t1').feature('i2').create('mg1', 'Multigrid');
model.sol('sol1').feature('t1').feature('i2').feature('mg1').feature('pr').create('sc1', 'SCGS');
model.sol('sol1').feature('t1').feature('i2').feature('mg1').feature('pr').feature('sc1').set('linesweeptype', 'ssor');
model.sol('sol1').feature('t1').feature('i2').feature('mg1').feature('pr').feature('sc1').set('iter', 1);
model.sol('sol1').feature('t1').feature('i2').feature('mg1').feature('pr').feature('sc1').set('scgsmethod', 'lines');
model.sol('sol1').feature('t1').feature('i2').feature('mg1').feature('po').create('sc1', 'SCGS');
model.sol('sol1').feature('t1').feature('i2').feature('mg1').feature('po').feature('sc1').set('linesweeptype', 'ssor');
model.sol('sol1').feature('t1').feature('i2').feature('mg1').feature('po').feature('sc1').set('iter', 1);
model.sol('sol1').feature('t1').feature('i2').feature('mg1').feature('po').feature('sc1').set('scgsmethod', 'lines');
model.sol('sol1').feature('t1').feature('i2').feature('mg1').feature('cs').create('d1', 'Direct');
model.sol('sol1').feature('t1').feature('i2').feature('mg1').feature('cs').feature('d1').set('linsolver', 'pardiso');
model.sol('sol1').feature('t1').feature.remove('fcDef');
model.sol('sol1').attach('std1');

model.study('std1').feature('cdi').set('initType', 'secondary');
model.study('std1').feature('time').set('tlist', 'range(0,20,600)');

model.sol('sol1').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('t1').create('fc1', 'FullyCoupled');

model.study('std1').setGenPlots(false);

model.sol('sol1').runAll;

model.result.create('pg1', 'PlotGroup3D');
model.result('pg1').run;
model.result('pg1').create('slc1', 'Slice');
model.result('pg1').feature('slc1').set('quickxnumber', 1);
model.result('pg1').run;
model.result('pg1').run;
model.result('pg1').create('arwv1', 'ArrowVolume');
model.result('pg1').feature('arwv1').set('expr', {'cd.Ilx' 'cd.Ily' 'cd.Ilz'});
model.result('pg1').feature('arwv1').set('descr', 'Electrolyte current density vector');
model.result('pg1').feature('arwv1').set('titletype', 'none');
model.result('pg1').feature('arwv1').set('xnumber', 1);
model.result('pg1').feature('arwv1').set('ynumber', 13);
model.result('pg1').feature('arwv1').set('color', 'black');
model.result('pg1').run;
model.result('pg1').create('slc2', 'Slice');
model.result('pg1').feature('slc2').set('titletype', 'none');
model.result('pg1').feature('slc2').set('quickplane', 'xy');
model.result('pg1').feature('slc2').set('quickzmethod', 'coord');
model.result('pg1').feature('slc2').set('inheritplot', 'slc1');
model.result('pg1').run;
model.result.dataset.duplicate('dset3', 'dset1');
model.result.dataset('dset3').selection.geom('geom1', 2);
model.result.dataset('dset3').selection.named('sel1');
model.result.create('pg2', 'PlotGroup3D');
model.result('pg2').run;
model.result('pg2').set('edges', false);
model.result('pg2').create('surf1', 'Surface');
model.result('pg2').feature('surf1').set('expr', 'phis_wafer');
model.result('pg2').feature('surf1').set('descr', 'Electric potential');
model.result('pg2').run;
model.result('pg2').run;
model.result.duplicate('pg3', 'pg2');
model.result('pg3').run;
model.result('pg3').run;
model.result('pg3').feature('surf1').set('expr', 'cd.itot');
model.result('pg3').feature('surf1').set('descr', 'Total interface current density');
model.result('pg3').run;
model.result('pg3').run;
model.result.duplicate('pg4', 'pg3');
model.result('pg4').run;
model.result('pg4').run;
model.result('pg4').feature('surf1').set('expr', 'els.deltas');
model.result('pg4').feature('surf1').set('descr', 'Electrode thickness change');
model.result('pg4').run;
model.result('pg4').feature('surf1').create('def1', 'Deform');
model.result('pg4').run;
model.result('pg4').feature('surf1').feature('def1').set('expr', {'' '' 'els.deltas'});
model.result('pg4').feature('surf1').feature('def1').set('scaleactive', true);
model.result('pg4').feature('surf1').feature('def1').set('scale', 5000);
model.result('pg4').run;

model.sol('sol1').copySolution('sol3');

model.selection('sel2').set([15 17]);

model.sol('sol1').runAll;

model.result('pg1').run;
model.result.dataset.create('cln1', 'CutLine3D');
model.result.dataset('cln1').setIndex('genpoints', -30, 0, 1);
model.result.dataset('cln1').setIndex('genpoints', 30, 1, 1);
model.result.dataset('cln1').set('snapping', 'boundary');
model.result.dataset.duplicate('cln2', 'cln1');
model.result.dataset('cln2').set('data', 'dset4');
model.result.create('pg5', 'PlotGroup1D');
model.result('pg5').run;
model.result('pg5').set('data', 'cln1');
model.result('pg5').create('lngr1', 'LineGraph');
model.result('pg5').feature('lngr1').set('markerpos', 'datapoints');
model.result('pg5').feature('lngr1').set('linewidth', 'preference');
model.result('pg5').feature('lngr1').set('data', 'cln1');
model.result('pg5').feature('lngr1').setIndex('looplevelinput', 'manual', 0);
model.result('pg5').feature('lngr1').setIndex('looplevel', [31], 0);
model.result('pg5').feature('lngr1').set('expr', 'els.deltas');
model.result('pg5').feature('lngr1').set('legend', true);
model.result('pg5').feature('lngr1').set('legendmethod', 'manual');
model.result('pg5').feature('lngr1').setIndex('legends', 't = 600 s, with current thief', 0);
model.result('pg5').feature('lngr1').set('xdata', 'expr');
model.result('pg5').feature('lngr1').set('xdataexpr', 'y');
model.result('pg5').run;
model.result('pg5').feature.duplicate('lngr2', 'lngr1');
model.result('pg5').run;
model.result('pg5').feature('lngr2').set('data', 'cln2');
model.result('pg5').feature('lngr2').setIndex('looplevel', [24], 0);
model.result('pg5').feature('lngr2').set('titletype', 'none');
model.result('pg5').feature('lngr2').setIndex('legends', 't = 460 s, without current thief', 0);
model.result('pg5').run;
model.result('pg1').run;
model.result('pg1').run;
model.result('pg2').run;
model.result('pg2').run;
model.result('pg3').run;
model.result('pg3').run;
model.result('pg4').run;
model.result('pg4').run;
model.result('pg1').run;
model.result('pg1').label('Electrolyte Currents and Potential');
model.result('pg2').run;
model.result('pg2').label('Electric Potential in Metal Deposit');
model.result('pg3').run;
model.result('pg3').label('Electrode Current Density');
model.result('pg4').run;
model.result('pg4').label('Metal Thickness Change');
model.result('pg5').run;
model.result('pg5').label('Deposit Thickness Comparison');

model.title('Electrodeposition on a Resistive Patterned Wafer');

model.description('This example models time-dependent copper deposition on a resistive wafer in a cupplater reactor. As the deposited layer builds up, the resistive losses of the deposited layer decreases. The benefit of using a current thief for a more uniform deposit thickness is demonstrated.');

model.mesh.clearMeshes;

model.sol('sol1').clearSolutionData;
model.sol('sol2').clearSolutionData;
model.sol('sol3').clearSolutionData;

model.label('resistive_wafer.mph');

model.modelNode.label('Components');

out = model;
