function out = model
%
% hi_batch_reactor.m
%
% Model exported on May 26 2025, 21:27 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/Chemical_Reaction_Engineering_Module/Thermodynamics');

model.modelNode.create('comp1', true);

model.physics.create('re', 'ReactionEng');
model.physics('re').model('comp1');

model.study.create('std1');
model.study('std1').create('time', 'Transient');
model.study('std1').feature('time').setSolveFor('/physics/re', true);

% To import content from file, use:
% model.param.loadFile('FILENAME');
model.param.set('Tinit', '700[K]', 'Initial temperature');
model.param.set('V_reactor', '1[m^3]', 'Batch reactor volume');
model.param.set('cinit_H2', '5.8[mol/m^3]', 'Initial concentration hydrogen');
model.param.set('cinit_HI', '5.8[mol/m^3]', 'Initial concentration hydrogen iodine');
model.param.set('cinit_I2', '5.8[mol/m^3]', 'Initial concentration iodine');
model.param.set('Af_reaction', '8.87e7', 'Forward frequency factor');
model.param.set('Ef_reaction', '167e3[J/mol]', 'Forward activation energy');
model.param.set('Ar_reaction', '3e7', 'Reverse frequency factor');
model.param.set('Er_reaction', '184e3[J/mol]', 'Reverse activation energy');

model.physics('re').prop('reactor').set('Vr', 'V_reactor');
model.physics('re').prop('energybalance').set('T', 'Tinit');
model.physics('re').create('rch1', 'ReactionChem', -1);
model.physics('re').feature('rch1').set('formula', 'H2+I2<=>2HI');
model.physics('re').feature('rch1').set('useArrhenius', true);
model.physics('re').feature('rch1').set('Af', 'Af_reaction');
model.physics('re').feature('rch1').set('Ef', 'Ef_reaction');
model.physics('re').feature('rch1').set('Ar', 'Ar_reaction');
model.physics('re').feature('rch1').set('Er', 'Er_reaction');
model.physics('re').feature('inits1').setIndex('initialValue', 'cinit_H2', 0, 0);
model.physics('re').feature('inits1').setIndex('initialValue', 'cinit_HI', 1, 0);
model.physics('re').feature('inits1').setIndex('initialValue', 'cinit_I2', 2, 0);

model.variable.create('var1');
model.variable('var1').model('comp1');

% To import content from file, use:
% model.variable('var1').loadFile('FILENAME');
model.variable('var1').set('K_equi', 'comp1.re.c_HI^2/(comp1.re.c_I2*comp1.re.c_H2)', 'Equilibrium constant');
model.variable('var1').set('T_change', 'comp1.re.T-700[K]', 'Temperature change');

model.thermodynamics.feature.create('pp1', 'BuiltinPropertyPackage');
model.thermodynamics.feature('pp1').set('compoundlist', {'hydrogen iodide' '10034-85-2' 'HI' 'COMSOL';  ...
'hydrogen' '1333-74-0' 'H2' 'COMSOL';  ...
'iodine' '7553-56-2' 'I2' 'COMSOL'});
model.thermodynamics.feature('pp1').set('phase_list', {'Gas' 'Vapor'});
model.thermodynamics.feature('pp1').label('Gas System 1');
model.thermodynamics.feature('pp1').set('manager_id', 'COMSOL');
model.thermodynamics.feature('pp1').set('manager_version', '1.0');
model.thermodynamics.feature('pp1').set('packagename', 'pp1');
model.thermodynamics.feature('pp1').set('package_desc', 'Built-in property package');
model.thermodynamics.feature('pp1').set('managerindex', '0');
model.thermodynamics.feature('pp1').set('packageid', 'COMSOL1');
model.thermodynamics.feature('pp1').set('ThermodynamicModel', 'IdealGas');
model.thermodynamics.feature('pp1').set('LiquidPhaseModel', 'None');
model.thermodynamics.feature('pp1').set('LiquidCard', 'None');
model.thermodynamics.feature('pp1').set('EOSModel', 'IdealGas');
model.thermodynamics.feature('pp1').set('GasPhaseModel', 'IdealGas');
model.thermodynamics.feature('pp1').set('GasEOSCard', 'GasPhaseModel');
model.thermodynamics.feature('pp1').set('VapDiffusivity', 'Automatic');
model.thermodynamics.feature('pp1').set('VapThermalConductivity', 'KineticTheory');
model.thermodynamics.feature('pp1').set('VapViscosity', 'Brokaw');
model.thermodynamics.feature('pp1').storePersistenceData;
model.thermodynamics.feature('pp1').set('WarningState', false);
model.thermodynamics.feature('pp1').set('Warning', {''});

model.physics('re').prop('mixture').set('Thermodynamics', true);
model.physics('re').prop('SpeciesMatching').setIndex('PackageSpecies', 'hydrogen', 0, 0);
model.physics('re').prop('SpeciesMatching').setIndex('PackageSpecies', 'hydrogen iodide', 1, 0);
model.physics('re').prop('SpeciesMatching').setIndex('PackageSpecies', 'iodine', 2, 0);
model.physics('re').prop('energybalance').set('energybalance', 'exclude');

model.study('std1').feature('time').set('tlist', '0.5e5');

model.sol.create('sol1');
model.sol('sol1').study('std1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'time');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').set('control', 'time');
model.sol('sol1').create('t1', 'Time');
model.sol('sol1').feature('t1').set('tlist', '0.5e5');
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
model.sol('sol1').feature('t1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('t1').feature('fc1').set('dtech', 'auto');
model.sol('sol1').feature('t1').feature('fc1').set('linsolver', 'dDef');
model.sol('sol1').feature('t1').feature('fc1').set('dtech', 'auto');
model.sol('sol1').feature('t1').feature.remove('fcDef');
model.sol('sol1').attach('std1');
model.sol('sol1').runAll;

model.result.create('pg1', 'PlotGroup1D');
model.result('pg1').set('data', 'dset1');
model.result('pg1').create('glob1', 'Global');
model.result('pg1').feature('glob1').set('expr', {'re.c_H2' 're.c_I2' 're.c_HI'});
model.result('pg1').feature('glob1').set('descr', {'Concentration' 'Concentration' 'Concentration'});
model.result('pg1').feature('glob1').set('unit', {'' '' ''});
model.result('pg1').feature('glob1').set('expr', {'re.c_H2' 're.c_I2' 're.c_HI'});
model.result('pg1').feature('glob1').set('descr', {'Concentration' 'Concentration' 'Concentration'});
model.result('pg1').label('Concentration (re)');
model.result('pg1').feature('glob1').set('xdatasolnumtype', 'level1');
model.result('pg1').run;

model.sol('sol1').copySolution('sol2');
model.sol('sol2').label('Isothermal');

model.physics('re').prop('energybalance').set('energybalance', 'include');
model.physics('re').feature('inits1').set('T0', 'Tinit');

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
model.sol('sol1').feature('t1').set('tlist', '0.5e5');
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
model.sol('sol1').feature('t1').set('consistent', 'off');
model.sol('sol1').feature('t1').set('control', 'time');
model.sol('sol1').feature('t1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('t1').feature('fc1').set('dtech', 'auto');
model.sol('sol1').feature('t1').feature('fc1').set('linsolver', 'dDef');
model.sol('sol1').feature('t1').feature('fc1').set('dtech', 'auto');
model.sol('sol1').feature('t1').feature.remove('fcDef');
model.sol('sol1').attach('std1');
model.sol('sol1').runAll;

model.result('pg1').run;

model.sol('sol1').copySolution('sol3');
model.sol('sol3').label('Nonisothermal');

model.result('pg1').run;
model.result('pg1').set('legendpos', 'middleright');
model.result('pg1').run;
model.result('pg1').feature('glob1').set('data', 'dset2');
model.result('pg1').feature('glob1').set('titletype', 'none');
model.result('pg1').feature('glob1').set('legendmethod', 'manual');
model.result('pg1').feature('glob1').setIndex('legends', 'Isothermal c<sub>H<sub>2</sub></sub>', 0);
model.result('pg1').feature('glob1').setIndex('legends', 'Isothermal c<sub>I<sub>2</sub></sub>', 1);
model.result('pg1').feature('glob1').setIndex('legends', 'Isothermal c<sub>HI</sub>', 2);
model.result('pg1').feature('glob1').set('linewidth', 2);
model.result('pg1').feature.duplicate('glob2', 'glob1');
model.result('pg1').run;
model.result('pg1').feature('glob2').set('data', 'dset3');
model.result('pg1').feature('glob2').setIndex('legends', 'Nonisothermal c<sub>H<sub>2</sub></sub>', 0);
model.result('pg1').feature('glob2').setIndex('legends', 'Nonisothermal c<sub>I<sub>2</sub></sub>', 1);
model.result('pg1').feature('glob2').setIndex('legends', 'Nonisothermal c<sub>HI</sub>', 2);
model.result('pg1').run;
model.result.create('pg2', 'PlotGroup1D');
model.result('pg2').run;
model.result('pg2').label('Equilibrium constant');
model.result('pg2').set('data', 'dset2');
model.result('pg2').set('xlabelactive', true);
model.result('pg2').set('xlabel', 'Time (s)');
model.result('pg2').set('ylabelactive', true);
model.result('pg2').set('ylabel', 'Equilibrium constant (-)');
model.result('pg2').create('glob1', 'Global');
model.result('pg2').feature('glob1').set('markerpos', 'datapoints');
model.result('pg2').feature('glob1').set('linewidth', 'preference');
model.result('pg2').feature('glob1').set('expr', {'K_equi'});
model.result('pg2').feature('glob1').set('descr', {'Equilibrium constant'});
model.result('pg2').feature('glob1').set('unit', {'1'});
model.result('pg2').feature('glob1').set('titletype', 'none');
model.result('pg2').feature('glob1').set('legend', false);
model.result('pg2').feature('glob1').set('linewidth', 2);
model.result('pg2').run;
model.result.create('pg3', 'PlotGroup1D');
model.result('pg3').run;
model.result('pg3').label('Temperature change');
model.result('pg3').set('data', 'dset3');
model.result('pg3').set('xlabelactive', true);
model.result('pg3').set('xlabel', 'Time (s)');
model.result('pg3').set('ylabelactive', true);
model.result('pg3').set('ylabel', 'Temperature change (K)');
model.result('pg3').set('xlog', true);
model.result('pg3').create('glob1', 'Global');
model.result('pg3').feature('glob1').set('markerpos', 'datapoints');
model.result('pg3').feature('glob1').set('linewidth', 'preference');
model.result('pg3').feature('glob1').set('expr', {'T_change'});
model.result('pg3').feature('glob1').set('descr', {'Temperature change'});
model.result('pg3').feature('glob1').set('unit', {'K'});
model.result('pg3').feature('glob1').set('titletype', 'none');
model.result('pg3').feature('glob1').set('legend', false);
model.result('pg3').feature('glob1').set('linewidth', 2);
model.result('pg3').run;
model.result.create('pg4', 'PlotGroup1D');
model.result('pg4').run;
model.result('pg4').label('Heat of reaction');
model.result('pg4').set('legendpos', 'upperleft');
model.result('pg4').create('glob1', 'Global');
model.result('pg4').feature('glob1').set('markerpos', 'datapoints');
model.result('pg4').feature('glob1').set('linewidth', 'preference');
model.result('pg4').feature('glob1').set('expr', {});
model.result('pg4').feature('glob1').set('descr', {});
model.result('pg4').feature('glob1').set('expr', {'re.Qheat'});
model.result('pg4').feature('glob1').set('descr', {'Heat source of reactions'});
model.result('pg4').feature('glob1').set('linewidth', 2);
model.result('pg4').feature('glob1').set('legendmethod', 'manual');
model.result('pg4').feature('glob1').setIndex('legends', 'Isothermal reactor', 0);
model.result('pg4').feature('glob1').set('data', 'dset2');
model.result('pg4').feature('glob1').set('titletype', 'none');
model.result('pg4').feature.duplicate('glob2', 'glob1');
model.result('pg4').run;
model.result('pg4').feature('glob2').setIndex('legends', 'Nonisothermal reactor', 0);
model.result('pg4').feature('glob2').set('data', 'dset3');
model.result('pg4').run;
model.result('pg4').set('xlog', true);
model.result('pg4').run;

model.title('HI Batch Reactor');

model.description('A perfectly mixed batch reactor model is used to simulate a reacting mixture of hydrogen and iodine gas which is allowed to react and form HI. The reaction is studied and compared under isothermal and nonisothermal conditions.');

model.label('hi_batch_reactor.mph');

model.modelNode.label('Components');

out = model;
