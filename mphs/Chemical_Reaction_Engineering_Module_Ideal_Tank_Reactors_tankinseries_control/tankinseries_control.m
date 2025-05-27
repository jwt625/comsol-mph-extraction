function out = model
%
% tankinseries_control.m
%
% Model exported on May 26 2025, 21:27 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/Chemical_Reaction_Engineering_Module/Ideal_Tank_Reactors');

model.modelNode.create('comp1', true);

model.physics.create('re', 'ReactionEng');
model.physics('re').model('comp1');

model.study.create('std1');
model.study('std1').create('time', 'Transient');
model.study('std1').feature('time').setSolveFor('/physics/re', true);

% To import content from file, use:
% model.param.loadFile('FILENAME');
model.param.set('Vr_tank', '1[m^3]', 'Tank volume');
model.param.set('kf_reaction', '0.5[1/min]', 'Reaction rate constant');
model.param.set('tau', 'Vr_tank/v_tanks', 'Residence time in a tank');
model.param.set('v_tanks', '8[l/s]', 'Volumetric flow in inlets and outlets of tanks');
model.param.set('Mn_A', '0.025[kg/mol]', 'Molar mass, A');
model.param.set('Mn_B', '0.025[kg/mol]', 'Molar mass, B');
model.param.set('Mn_solv', '0.018[kg/mol]', 'Molar mass, solvent');
model.param.set('rho_spec', '1000[kg/m^3]', 'Density, reacting species');
model.param.set('rho_solv', '1000[kg/m^3]', 'Density, solvent');
model.param.set('cinit_A_tank1', '400[mol/m^3]', 'Initial concentration tank 1, A');
model.param.set('cinit_A_tank2', '200[mol/m^3]', 'Initial concentration tank 2, A');
model.param.set('cinit_A_tank3', '100[mol/m^3]', 'Initial concentration tank 3, A');
model.param.set('cinlet_A', '1800[mol/m^3]', 'Inlet concentration, A');
model.param.set('c_solv', 'rho_solv/Mn_solv', 'Concentration, solvent');
model.param.set('Kc', '30', 'Controller gain');
model.param.set('tau1', '5[min]', 'Reset time');
model.param.set('cset_A', '100[mol/m^3]', 'Set level concentration, A');
model.param.set('cdisturb_A', '200[mol/m^3]', 'Disturbance concentration, A');

model.physics('re').tag('tank1');
model.physics('tank1').prop('reactor').set('reactor', 'cstrvol');
model.physics('tank1').prop('mixture').set('mixture', 'liquid');
model.physics('tank1').prop('reactor').set('Vr', 'Vr_tank');
model.physics('tank1').create('rch1', 'ReactionChem', -1);
model.physics('tank1').feature('rch1').set('formula', 'A=>B');
model.physics('tank1').feature('rch1').set('kf', 'kf_reaction');
model.physics('tank1').feature('A').set('M', 'Mn_A');
model.physics('tank1').feature('A').set('rho', 'rho_spec');
model.physics('tank1').feature('B').set('M', 'Mn_B');
model.physics('tank1').feature('B').set('rho', 'rho_spec');
model.physics('tank1').create('spec1', 'SpeciesChem', -1);
model.physics('tank1').feature('spec1').set('specName', 'H2O');
model.physics('tank1').feature('H2O').set('sType', 'solvent');
model.physics('tank1').feature('H2O').set('M', 'Mn_solv');
model.physics('tank1').feature('H2O').set('rho', 'rho_solv');
model.physics('tank1').feature('inits1').setIndex('initialValue', 'cinit_A_tank1', 0, 0);
model.physics('tank1').feature('inits1').setIndex('initialValue', 'c_solv', 2, 0);
model.physics('tank1').create('feed1', 'FeedStream', -1);
model.physics('tank1').feature('feed1').set('vf', 'v_tanks');
model.physics('tank1').feature('feed1').setIndex('FeedSpeciesConcentration', 'cinlet_A', 0, 0);
model.physics('tank1').feature('feed1').setIndex('FeedSpeciesConcentration', 'c_solv', 2, 0);
model.physics.copy('tank2', 'tank1', 'comp1');
model.physics('tank2').feature('inits1').setIndex('initialValue', 'cinit_A_tank2', 0, 0);
model.physics('tank2').feature('feed1').setIndex('FeedSpeciesConcentration', 'tank1.c_A', 0, 0);
model.physics('tank2').feature('feed1').setIndex('FeedSpeciesConcentration', 'tank1.c_B', 1, 0);
model.physics.copy('tank3', 'tank2', 'comp1');
model.physics('tank3').feature('inits1').setIndex('initialValue', 'cinit_A_tank3', 0, 0);
model.physics('tank3').feature('feed1').setIndex('FeedSpeciesConcentration', 'tank2.c_A', 0, 0);
model.physics('tank3').feature('feed1').setIndex('FeedSpeciesConcentration', 'tank2.c_B', 1, 0);
model.physics('tank3').feature('feed1').setIndex('FeedSpeciesConcentration', 'c_solv', 2, 0);

model.study('std1').feature('time').set('tlist', 'range(0,1,600)');

model.sol.create('sol1');
model.sol('sol1').study('std1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'time');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').set('control', 'time');
model.sol('sol1').create('t1', 'Time');
model.sol('sol1').feature('t1').set('tlist', 'range(0,1,600)');
model.sol('sol1').feature('t1').set('plot', 'off');
model.sol('sol1').feature('t1').set('plotgroup', 'Default');
model.sol('sol1').feature('t1').set('plotfreq', 'tout');
model.sol('sol1').feature('t1').set('probesel', 'all');
model.sol('sol1').feature('t1').set('probes', {});
model.sol('sol1').feature('t1').set('probefreq', 'tsteps');
model.sol('sol1').feature('t1').set('tout', 'tsteps');
model.sol('sol1').feature('t1').set('rtol', 1.0E-5);
model.sol('sol1').feature('t1').set('atolglobalvaluemethod', 'factor');
model.sol('sol1').feature('t1').set('reacf', true);
model.sol('sol1').feature('t1').set('storeudot', true);
model.sol('sol1').feature('t1').set('endtimeinterpolation', true);
model.sol('sol1').feature('t1').set('consistent', 'off');
model.sol('sol1').feature('t1').set('control', 'time');
model.sol('sol1').feature('t1').create('seDef', 'Segregated');
model.sol('sol1').feature('t1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('t1').feature('fc1').set('dtech', 'auto');
model.sol('sol1').feature('t1').feature('fc1').set('linsolver', 'dDef');
model.sol('sol1').feature('t1').feature('fc1').set('dtech', 'auto');
model.sol('sol1').feature('t1').feature.remove('fcDef');
model.sol('sol1').feature('t1').feature.remove('seDef');
model.sol('sol1').attach('std1');
model.sol('sol1').runAll;

model.result.create('pg1', 'PlotGroup1D');
model.result('pg1').set('data', 'dset1');
model.result('pg1').create('glob1', 'Global');
model.result('pg1').feature('glob1').set('expr', {'tank1.c_A' 'tank1.c_B'});
model.result('pg1').feature('glob1').set('descr', {'Concentration' 'Concentration'});
model.result('pg1').feature('glob1').set('unit', {'' ''});
model.result('pg1').feature('glob1').set('expr', {'tank1.c_A' 'tank1.c_B'});
model.result('pg1').feature('glob1').set('descr', {'Concentration' 'Concentration'});
model.result('pg1').label('Concentration (tank1)');
model.result('pg1').feature('glob1').set('xdatasolnumtype', 'level1');
model.result.create('pg2', 'PlotGroup1D');
model.result('pg2').set('data', 'dset1');
model.result('pg2').create('glob1', 'Global');
model.result('pg2').feature('glob1').set('expr', {'tank2.c_A' 'tank2.c_B'});
model.result('pg2').feature('glob1').set('descr', {'Concentration' 'Concentration'});
model.result('pg2').feature('glob1').set('unit', {'' ''});
model.result('pg2').feature('glob1').set('expr', {'tank2.c_A' 'tank2.c_B'});
model.result('pg2').feature('glob1').set('descr', {'Concentration' 'Concentration'});
model.result('pg2').label('Concentration (tank2)');
model.result('pg2').feature('glob1').set('xdatasolnumtype', 'level1');
model.result.create('pg3', 'PlotGroup1D');
model.result('pg3').set('data', 'dset1');
model.result('pg3').create('glob1', 'Global');
model.result('pg3').feature('glob1').set('expr', {'tank3.c_A' 'tank3.c_B'});
model.result('pg3').feature('glob1').set('descr', {'Concentration' 'Concentration'});
model.result('pg3').feature('glob1').set('unit', {'' ''});
model.result('pg3').feature('glob1').set('expr', {'tank3.c_A' 'tank3.c_B'});
model.result('pg3').feature('glob1').set('descr', {'Concentration' 'Concentration'});
model.result('pg3').label('Concentration (tank3)');
model.result('pg3').feature('glob1').set('xdatasolnumtype', 'level1');
model.result('pg1').run;

model.sol('sol1').copySolution('sol2');
model.sol('sol2').label('Open Loop');
model.sol('sol1').label('Close Loop');

model.result.create('pg4', 'PlotGroup1D');
model.result('pg4').run;
model.result('pg4').label('Open Loop');
model.result('pg4').set('data', 'dset2');
model.result('pg4').set('titletype', 'none');
model.result('pg4').set('ylabelactive', true);
model.result('pg4').set('ylabel', 'Concentration A (mol/m<sup>3</sup>)');
model.result('pg4').set('legendlayout', 'outside');
model.result('pg4').create('glob1', 'Global');
model.result('pg4').feature('glob1').set('markerpos', 'datapoints');
model.result('pg4').feature('glob1').set('linewidth', 'preference');
model.result('pg4').feature('glob1').set('expr', {'tank1.c_A'});
model.result('pg4').feature('glob1').set('descr', {'Concentration'});
model.result('pg4').feature('glob1').set('unit', {'mol/m^3'});
model.result('pg4').feature('glob1').set('expr', {'tank1.c_A' 'tank2.c_A'});
model.result('pg4').feature('glob1').set('descr', {'Concentration' 'Concentration'});
model.result('pg4').feature('glob1').set('expr', {'tank1.c_A' 'tank2.c_A' 'tank3.c_A'});
model.result('pg4').feature('glob1').set('descr', {'Concentration' 'Concentration' 'Concentration'});
model.result('pg4').feature('glob1').set('xdata', 'expr');
model.result('pg4').feature('glob1').set('xdataexpr', 't');
model.result('pg4').feature('glob1').set('xdataunit', 'min');
model.result('pg4').feature('glob1').set('linewidth', 2);
model.result('pg4').feature('glob1').set('legendmethod', 'manual');
model.result('pg4').feature('glob1').setIndex('legends', 'Tank 1', 0);
model.result('pg4').feature('glob1').setIndex('legends', 'Tank 2', 1);
model.result('pg4').feature('glob1').setIndex('legends', 'Tank 3', 2);
model.result('pg4').run;

model.physics.create('ge', 'GlobalEquations');
model.physics('ge').model('comp1');

model.study('std1').feature('time').setSolveFor('/physics/ge', true);

model.physics('ge').prop('EquationForm').set('form', 'Automatic');
model.physics('ge').feature('ge1').setIndex('name', 'E_int', 0, 0);
model.physics('ge').feature('ge1').setIndex('equation', 'E_intt-E', 0, 0);
model.physics('ge').feature('ge1').set('CustomDependentVariableUnit', '1');
model.physics('ge').feature('ge1').set('DependentVariableQuantity', 'none');
model.physics('ge').feature('ge1').setIndex('CustomDependentVariableUnit', 'mol/m^3*s', 0, 0);
model.physics('ge').feature('ge1').set('SourceTermQuantity', 'concentration');

model.variable.create('var1');
model.variable('var1').model('comp1');
model.variable('var1').set('E', 'cset_A-tank3.c_A');
model.variable('var1').descr('E', 'Measured error');
model.variable('var1').set('cM_A', '800+Kc*(E+E_int/tau1)');
model.variable('var1').descr('cM_A', 'Manipulated concentration');
model.variable('var1').set('cinlet_A', 'max((cM_A+cdisturb_A),0)');
model.variable('var1').descr('cinlet_A', 'Inlet concentration');

model.sol('sol1').study('std1');
model.sol('sol1').feature.remove('t1');
model.sol('sol1').feature.remove('v1');
model.sol('sol1').feature.remove('st1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'time');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').set('control', 'time');
model.sol('sol1').create('t1', 'Time');
model.sol('sol1').feature('t1').set('tlist', 'range(0,1,600)');
model.sol('sol1').feature('t1').set('plot', 'off');
model.sol('sol1').feature('t1').set('plotgroup', 'pg1');
model.sol('sol1').feature('t1').set('plotfreq', 'tout');
model.sol('sol1').feature('t1').set('probesel', 'all');
model.sol('sol1').feature('t1').set('probes', {});
model.sol('sol1').feature('t1').set('probefreq', 'tsteps');
model.sol('sol1').feature('t1').set('tout', 'tsteps');
model.sol('sol1').feature('t1').set('rtol', 1.0E-5);
model.sol('sol1').feature('t1').set('atolglobalvaluemethod', 'factor');
model.sol('sol1').feature('t1').set('reacf', true);
model.sol('sol1').feature('t1').set('storeudot', true);
model.sol('sol1').feature('t1').set('endtimeinterpolation', true);
model.sol('sol1').feature('t1').set('consistent', 'bweuler');
model.sol('sol1').feature('t1').set('control', 'time');
model.sol('sol1').feature('t1').create('seDef', 'Segregated');
model.sol('sol1').feature('t1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('t1').feature('fc1').set('dtech', 'auto');
model.sol('sol1').feature('t1').feature('fc1').set('linsolver', 'dDef');
model.sol('sol1').feature('t1').feature('fc1').set('dtech', 'auto');
model.sol('sol1').feature('t1').feature.remove('fcDef');
model.sol('sol1').feature('t1').feature.remove('seDef');
model.sol('sol1').attach('std1');
model.sol('sol1').runAll;

model.result('pg1').run;
model.result('pg4').run;
model.result.duplicate('pg5', 'pg4');
model.result('pg5').run;
model.result('pg5').label('Closed Loop');
model.result('pg5').set('data', 'dset1');
model.result('pg5').run;
model.result('pg5').feature('glob1').set('expr', {'tank1.c_A' 'tank2.c_A' 'tank3.c_A' 'cinlet_A'});
model.result('pg5').feature('glob1').set('descr', {'Concentration' 'Concentration' 'Concentration' 'Inlet concentration'});
model.result('pg5').feature('glob1').setIndex('legends', 'At inlet to tank 1', 3);
model.result('pg5').run;

model.title('Tank Series with Feedback Control');

model.description('This example shows how to set up and solve a tank-in-series model using the Reaction Engineering interface. It uses a feedback control loop to adjust the first tank''s inlet concentration to keep the last reactor''s outlet concentration close to a set level.');

model.label('tankinseries_control.mph');

model.modelNode.label('Components');

out = model;
