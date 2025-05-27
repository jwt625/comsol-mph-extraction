function out = model
%
% monolith_thermal_stress.m
%
% Model exported on May 26 2025, 21:27 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/Chemical_Reaction_Engineering_Module/Reactors_with_Porous_Catalysts');

model.modelNode.create('comp1', true);

model.physics.create('re', 'ReactionEng');
model.physics('re').model('comp1');

model.study.create('std1');
model.study('std1').create('spf', 'StationaryPlugflow');
model.study('std1').feature('spf').set('solnum', 'auto');
model.study('std1').feature('spf').set('notsolnum', 'auto');
model.study('std1').feature('spf').setSolveFor('/physics/re', true);

% To import content from file, use:
% model.param.loadFile('FILENAME');
model.param.set('T_in', '523[K]', 'Inlet temperature');
model.param.set('T_amb', '350[K]', 'Ambient temperature');
model.param.set('rad', '2[mm]', 'Channel radius');
model.param.set('L', '0.36[m]', 'Channel length');
model.param.set('A', 'pi*rad^2', 'Channel cross section area');
model.param.set('v_av', '0.3[m/s]', 'Average gas velocity');
model.param.set('vrate', 'v_av*A', 'Volumetric flow rate');
model.param.set('UA', '200[W/(K*m^3)]', 'Volumetric heat transfer coefficient');
model.param.set('F_NO_in', '1.55e-7[mol/s]', 'Inlet molar flow NO');
model.param.set('F_NH3_in', 'F_NO_in*X0', 'Inlet molar flow NH3');
model.param.set('X0', '1', 'Ratio NH3 to NO at inlet');
model.param.set('F_O2_in', '2.71e-6[mol/s]', 'Inlet molar flow O2');
model.param.set('F_N2_in', '6.86e-5[mol/s]', 'Inlet molar flow N2');
model.param.set('F_H2O_in', '7.34e-6[mol/s]', 'Inlet molar flow H2O');
model.param.set('a0', '2.68e-17[m^3/mol]', 'Concentration correction factor');
model.param.set('A1', '1e6[1/s]', 'Frequency factor for reaction 1');
model.param.set('A2', '6.8e7[1/s]', 'Frequency factor for reaction 2');
model.param.set('E0', '-243e3[J/mol]', 'Activation energy for correction');
model.param.set('E1', '60e3[J/mol]', 'Activation energy for reaction 1');
model.param.set('E2', '85e3[J/mol]', 'Activation energy  for reaction 2');

model.variable.create('var1');
model.variable('var1').model('comp1');
model.variable('var1').set('S', 're.r_1/re.r_2');
model.variable('var1').descr('S', 'Selectivity');
model.variable('var1').set('a', 'a0*exp(-E0/(R_const*re.T))');
model.variable('var1').descr('a', 'Concentration correction');

model.thermodynamics.feature.create('pp1', 'BuiltinPropertyPackage');
model.thermodynamics.feature('pp1').set('compoundlist', {'oxygen' '7782-44-7' 'O2' 'COMSOL';  ...
'water' '7732-18-5' 'H2O' 'COMSOL';  ...
'nitrogen oxide' '10102-43-9' 'NO' 'COMSOL';  ...
'nitrogen' '7727-37-9' 'N2' 'COMSOL';  ...
'ammonia' '7664-41-7' 'H3N' 'COMSOL'});
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

model.physics('re').create('rch1', 'ReactionChem', -1);
model.physics('re').feature('rch1').set('formula', '4NO+4NH3+O2=>4N2+6H2O');
model.physics('re').feature('rch1').set('ReactionExpression', 'UserDefined');
model.physics('re').feature('rch1').set('r', 're.kf_1*re.c_NO*a*re.c_NH3/(1+a*max(re.c_NH3,0[M]))');
model.physics('re').feature('rch1').set('bulkFwdOrder', 1);
model.physics('re').feature('rch1').set('useArrhenius', true);
model.physics('re').feature('rch1').set('Af', 'A1');
model.physics('re').feature('rch1').set('Ef', 'E1');
model.physics('re').create('rch2', 'ReactionChem', -1);
model.physics('re').feature('rch2').set('formula', '4 NH3 + 3 O2=>2 N2 + 6 H2O');
model.physics('re').feature('rch2').set('ReactionExpression', 'UserDefined');
model.physics('re').feature('rch2').set('r', 're.kf_2*re.c_NH3');
model.physics('re').feature('rch2').set('bulkFwdOrder', 1);
model.physics('re').feature('rch2').set('useArrhenius', true);
model.physics('re').feature('rch2').set('Af', 'A2');
model.physics('re').feature('rch2').set('Ef', 'E2');
model.physics('re').prop('reactor').set('reactor', 'plugflow');
model.physics('re').prop('mixture').set('Thermodynamics', true);
model.physics('re').prop('SpeciesMatching').setIndex('PackageSpecies', 'water', 0, 0);
model.physics('re').prop('SpeciesMatching').setIndex('PackageSpecies', 'nitrogen', 1, 0);
model.physics('re').prop('SpeciesMatching').setIndex('PackageSpecies', 'ammonia', 2, 0);
model.physics('re').prop('SpeciesMatching').setIndex('PackageSpecies', 'nitrogen oxide', 3, 0);
model.physics('re').prop('SpeciesMatching').setIndex('PackageSpecies', 'oxygen', 4, 0);
model.physics('re').prop('mixture').set('psource', 'idealGas');
model.physics('re').prop('energybalance').set('energybalance', 'exclude');
model.physics('re').prop('energybalance').set('T', '500[K]+250[K/m^3]*re.Vr');
model.physics('re').prop('reactor').set('vplug', 'vrate');
model.physics('re').feature('inits1').setIndex('F0', 'F_H2O_in', 0, 0);
model.physics('re').feature('inits1').setIndex('F0', 'F_N2_in', 1, 0);
model.physics('re').feature('inits1').setIndex('F0', 'F_NH3_in', 2, 0);
model.physics('re').feature('inits1').setIndex('F0', 'F_NO_in', 3, 0);
model.physics('re').feature('inits1').setIndex('F0', 'F_O2_in', 4, 0);
model.physics('re').feature('NO').set('cLock', true);
model.physics('re').feature('NH3').set('cLock', true);

model.study('std1').create('param', 'Parametric');
model.study('std1').feature('param').setIndex('pname', 'T_in', 0);
model.study('std1').feature('param').setIndex('plistarr', '', 0);
model.study('std1').feature('param').setIndex('punit', 'K', 0);
model.study('std1').feature('param').setIndex('pname', 'T_in', 0);
model.study('std1').feature('param').setIndex('plistarr', '', 0);
model.study('std1').feature('param').setIndex('punit', 'K', 0);
model.study('std1').feature('param').setIndex('pname', 'X0', 0);
model.study('std1').feature('param').setIndex('plistarr', 'range(1,0.2,2)', 0);

model.sol.create('sol1');
model.sol('sol1').study('std1');

model.study('std1').feature('spf').set('notlistsolnum', 1);
model.study('std1').feature('spf').set('notsolnum', 'auto');
model.study('std1').feature('spf').set('listsolnum', 1);
model.study('std1').feature('spf').set('solnum', 'auto');

model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'spf');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').set('control', 'spf');
model.sol('sol1').create('pf1', 'Plugflow');
model.sol('sol1').feature('pf1').set('tlist', 'range(0,0.1,1)');
model.sol('sol1').feature('pf1').set('plot', 'off');
model.sol('sol1').feature('pf1').set('plotgroup', 'Default');
model.sol('sol1').feature('pf1').set('plotfreq', 'tout');
model.sol('sol1').feature('pf1').set('probesel', 'all');
model.sol('sol1').feature('pf1').set('probes', {});
model.sol('sol1').feature('pf1').set('probefreq', 'tsteps');
model.sol('sol1').feature('pf1').set('tout', 'tsteps');
model.sol('sol1').feature('pf1').set('rtol', 1.0E-5);
model.sol('sol1').feature('pf1').set('atolglobalvaluemethod', 'factor');
model.sol('sol1').feature('pf1').set('reacf', true);
model.sol('sol1').feature('pf1').set('storeudot', true);
model.sol('sol1').feature('pf1').set('endtimeinterpolation', true);
model.sol('sol1').feature('pf1').set('consistent', 'off');
model.sol('sol1').feature('pf1').set('control', 'spf');
model.sol('sol1').feature('pf1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('pf1').feature('fc1').set('dtech', 'auto');
model.sol('sol1').feature('pf1').feature('fc1').set('linsolver', 'dDef');
model.sol('sol1').feature('pf1').feature('fc1').set('dtech', 'auto');
model.sol('sol1').feature('pf1').feature.remove('fcDef');
model.sol('sol1').attach('std1');

model.batch.create('p1', 'Parametric');
model.batch('p1').study('std1');
model.batch('p1').create('so1', 'Solutionseq');
model.batch('p1').feature('so1').set('seq', 'sol1');
model.batch('p1').feature('so1').set('store', 'on');
model.batch('p1').feature('so1').set('clear', 'on');
model.batch('p1').feature('so1').set('psol', 'none');
model.batch('p1').set('pname', {'X0'});
model.batch('p1').set('plistarr', {'range(1,0.2,2)'});
model.batch('p1').set('sweeptype', 'sparse');
model.batch('p1').set('probesel', 'all');
model.batch('p1').set('probes', {});
model.batch('p1').set('plot', 'off');
model.batch('p1').set('err', 'on');
model.batch('p1').attach('std1');
model.batch('p1').set('control', 'param');

model.study('std1').feature('spf').set('usertol', true);
model.study('std1').feature('spf').set('rtol', '1e-7');

model.sol('sol1').study('std1');

model.study('std1').feature('spf').set('notlistsolnum', 1);
model.study('std1').feature('spf').set('notsolnum', 'auto');
model.study('std1').feature('spf').set('listsolnum', 1);
model.study('std1').feature('spf').set('solnum', 'auto');

model.sol('sol1').feature.remove('pf1');
model.sol('sol1').feature.remove('v1');
model.sol('sol1').feature.remove('st1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'spf');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').set('control', 'spf');
model.sol('sol1').create('pf1', 'Plugflow');
model.sol('sol1').feature('pf1').set('tlist', 'range(0,0.1,1)');
model.sol('sol1').feature('pf1').set('plot', 'off');
model.sol('sol1').feature('pf1').set('plotgroup', 'Default');
model.sol('sol1').feature('pf1').set('plotfreq', 'tout');
model.sol('sol1').feature('pf1').set('probesel', 'all');
model.sol('sol1').feature('pf1').set('probes', {});
model.sol('sol1').feature('pf1').set('probefreq', 'tsteps');
model.sol('sol1').feature('pf1').set('tout', 'tsteps');
model.sol('sol1').feature('pf1').set('rtol', 1.0E-5);
model.sol('sol1').feature('pf1').set('atolglobalvaluemethod', 'factor');
model.sol('sol1').feature('pf1').set('reacf', true);
model.sol('sol1').feature('pf1').set('storeudot', true);
model.sol('sol1').feature('pf1').set('endtimeinterpolation', true);
model.sol('sol1').feature('pf1').set('consistent', 'off');
model.sol('sol1').feature('pf1').set('control', 'spf');
model.sol('sol1').feature('pf1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('pf1').feature('fc1').set('dtech', 'auto');
model.sol('sol1').feature('pf1').feature('fc1').set('linsolver', 'dDef');
model.sol('sol1').feature('pf1').feature('fc1').set('dtech', 'auto');
model.sol('sol1').feature('pf1').feature.remove('fcDef');
model.sol('sol1').attach('std1');

model.batch('p1').feature.remove('so1');
model.batch('p1').create('so1', 'Solutionseq');
model.batch('p1').feature('so1').set('seq', 'sol1');
model.batch('p1').feature('so1').set('store', 'on');
model.batch('p1').feature('so1').set('clear', 'on');
model.batch('p1').feature('so1').set('psol', 'none');
model.batch('p1').set('pname', {'X0'});
model.batch('p1').set('plistarr', {'range(1,0.2,2)'});
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

model.result.create('pg1', 'PlotGroup1D');
model.result('pg1').set('data', 'dset2');
model.result('pg1').create('glob1', 'Global');
model.result('pg1').feature('glob1').set('expr', {'re.F_O2' 're.F_N2' 're.F_H2O'});
model.result('pg1').feature('glob1').set('descr', {'Molar flow rate' 'Molar flow rate' 'Molar flow rate'});
model.result('pg1').feature('glob1').set('unit', {'' '' ''});
model.result('pg1').feature('glob1').set('expr', {'re.F_O2' 're.F_N2' 're.F_H2O'});
model.result('pg1').feature('glob1').set('descr', {'Molar flow rate' 'Molar flow rate' 'Molar flow rate'});
model.result('pg1').set('xlabel', 'Reactor volume (m<sup>3</sup>)');
model.result('pg1').label('Molar Flow Rate (re)');

model.batch('p1').run('compute');

model.result('pg1').feature('glob1').set('xdatasolnumtype', 'level1');
model.result('pg1').run;

model.sol('sol2').copySolution('sol9');
model.sol('sol9').label('Kinetics');

model.result('pg1').run;
model.result('pg1').label('Reaction rate');
model.result('pg1').set('data', 'dset3');
model.result('pg1').set('titletype', 'none');
model.result('pg1').set('xlabel', 'Temperature (K)');
model.result('pg1').set('legendpos', 'upperleft');
model.result('pg1').run;
model.result('pg1').feature('glob1').set('expr', {'re.r_1'});
model.result('pg1').feature('glob1').set('descr', {'Reaction rate'});
model.result('pg1').feature('glob1').set('unit', {'mol/(m^3*s)'});
model.result('pg1').feature('glob1').set('xdata', 'expr');
model.result('pg1').feature('glob1').set('xdataexpr', 're.T');
model.result('pg1').feature('glob1').set('linewidth', 2);
model.result('pg1').feature('glob1').set('autoexpr', false);
model.result('pg1').run;
model.result('pg1').run;
model.result.duplicate('pg2', 'pg1');
model.result('pg2').run;
model.result('pg2').label('Selectivity');
model.result('pg2').set('legendpos', 'upperright');
model.result('pg2').run;
model.result('pg2').feature('glob1').set('expr', {'S'});
model.result('pg2').feature('glob1').set('descr', {'Selectivity'});
model.result('pg2').feature('glob1').set('unit', {'1'});
model.result('pg2').run;

model.physics('re').prop('energybalance').set('energybalance', 'include');
model.physics('re').prop('energybalance').set('Qextplug', '(T_amb-re.T)*UA');
model.physics('re').feature('inits1').set('T0plug', 'T_in');
model.physics('re').feature('NO').set('cLock', false);
model.physics('re').feature('NH3').set('cLock', false);

model.study('std1').feature('spf').set('tlist', '0[m^3] L*A');

model.sol('sol1').study('std1');

model.study('std1').feature('spf').set('notlistsolnum', 1);
model.study('std1').feature('spf').set('notsolnum', 'auto');
model.study('std1').feature('spf').set('listsolnum', 1);
model.study('std1').feature('spf').set('solnum', 'auto');

model.sol('sol1').feature.remove('pf1');
model.sol('sol1').feature.remove('v1');
model.sol('sol1').feature.remove('st1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'spf');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').set('control', 'spf');
model.sol('sol1').create('pf1', 'Plugflow');
model.sol('sol1').feature('pf1').set('tlist', '0[m^3] L*A');
model.sol('sol1').feature('pf1').set('plot', 'off');
model.sol('sol1').feature('pf1').set('plotgroup', 'pg1');
model.sol('sol1').feature('pf1').set('plotfreq', 'tout');
model.sol('sol1').feature('pf1').set('probesel', 'all');
model.sol('sol1').feature('pf1').set('probes', {});
model.sol('sol1').feature('pf1').set('probefreq', 'tsteps');
model.sol('sol1').feature('pf1').set('tout', 'tsteps');
model.sol('sol1').feature('pf1').set('rtol', 1.0E-5);
model.sol('sol1').feature('pf1').set('atolglobalvaluemethod', 'factor');
model.sol('sol1').feature('pf1').set('reacf', true);
model.sol('sol1').feature('pf1').set('storeudot', true);
model.sol('sol1').feature('pf1').set('endtimeinterpolation', true);
model.sol('sol1').feature('pf1').set('consistent', 'off');
model.sol('sol1').feature('pf1').set('control', 'spf');
model.sol('sol1').feature('pf1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('pf1').feature('fc1').set('dtech', 'auto');
model.sol('sol1').feature('pf1').feature('fc1').set('linsolver', 'dDef');
model.sol('sol1').feature('pf1').feature('fc1').set('dtech', 'auto');
model.sol('sol1').feature('pf1').feature.remove('fcDef');
model.sol('sol1').attach('std1');

model.batch('p1').feature.remove('so1');
model.batch('p1').create('so1', 'Solutionseq');
model.batch('p1').feature('so1').set('seq', 'sol1');
model.batch('p1').feature('so1').set('store', 'on');
model.batch('p1').feature('so1').set('clear', 'on');
model.batch('p1').feature('so1').set('psol', 'sol2');
model.batch('p1').set('pname', {'X0'});
model.batch('p1').set('plistarr', {'range(1,0.2,2)'});
model.batch('p1').set('sweeptype', 'sparse');
model.batch('p1').set('probesel', 'all');
model.batch('p1').set('probes', {});
model.batch('p1').set('plot', 'off');
model.batch('p1').set('err', 'on');
model.batch('p1').attach('std1');
model.batch('p1').set('control', 'param');

model.result.create('pg3', 'PlotGroup1D');
model.result('pg3').set('data', 'dset2');
model.result('pg3').create('glob1', 'Global');
model.result('pg3').feature('glob1').set('expr', {'re.F_NO' 're.F_NH3' 're.F_O2' 're.F_N2' 're.F_H2O'});
model.result('pg3').feature('glob1').set('descr', {'Molar flow rate' 'Molar flow rate' 'Molar flow rate' 'Molar flow rate' 'Molar flow rate'});
model.result('pg3').feature('glob1').set('unit', {'' '' '' '' ''});
model.result('pg3').feature('glob1').set('expr', {'re.F_NO' 're.F_NH3' 're.F_O2' 're.F_N2' 're.F_H2O'});
model.result('pg3').feature('glob1').set('descr', {'Molar flow rate' 'Molar flow rate' 'Molar flow rate' 'Molar flow rate' 'Molar flow rate'});
model.result('pg3').set('xlabel', 'Reactor volume (m<sup>3</sup>)');
model.result('pg3').label('Molar Flow Rate (re)');
model.result.create('pg4', 'PlotGroup1D');
model.result('pg4').set('data', 'dset2');
model.result('pg4').create('glob1', 'Global');
model.result('pg4').feature('glob1').set('expr', {'re.F_NO' 're.F_NH3' 're.F_O2' 're.F_N2' 're.F_H2O'});
model.result('pg4').feature('glob1').set('descr', {'Molar flow rate' 'Molar flow rate' 'Molar flow rate' 'Molar flow rate' 'Molar flow rate'});
model.result('pg4').feature('glob1').set('unit', {''});
model.result('pg4').feature('glob1').set('expr', {'re.T'});
model.result('pg4').feature('glob1').set('descr', {'Temperature'});
model.result('pg4').set('xlabel', 'Reactor volume (m<sup>3</sup>)');
model.result('pg4').label('Temperature (re)');

model.batch('p1').run('compute');

model.result('pg3').feature('glob1').set('xdatasolnumtype', 'level1');
model.result('pg4').feature('glob1').set('xdatasolnumtype', 'level1');
model.result('pg3').run;

model.sol('sol2').copySolution('sol22');
model.sol('sol22').label('Nonisothermal');

model.result('pg3').run;
model.result('pg3').label('Molar flow rate NH3, Nonisothermal');
model.result('pg3').set('data', 'dset4');
model.result('pg3').set('titletype', 'none');
model.result('pg3').set('ylabelactive', true);
model.result('pg3').set('ylabel', 'Molar flow rate NH<sub>3</sub> (mol/s)');
model.result('pg3').run;
model.result('pg3').feature('glob1').set('expr', {'re.F_NH3'});
model.result('pg3').feature('glob1').set('descr', {'Molar flow rate'});
model.result('pg3').feature('glob1').set('unit', {'mol/s'});
model.result('pg3').feature('glob1').set('linewidth', 2);
model.result('pg3').feature('glob1').set('autoexpr', false);
model.result('pg3').run;

model.study('std1').feature('param').setIndex('plistarr', 'range(1.3,0.1,1.5)', 0);

model.sol('sol1').study('std1');

model.study('std1').feature('spf').set('notlistsolnum', 1);
model.study('std1').feature('spf').set('notsolnum', 'auto');
model.study('std1').feature('spf').set('listsolnum', 1);
model.study('std1').feature('spf').set('solnum', 'auto');

model.sol('sol1').feature.remove('pf1');
model.sol('sol1').feature.remove('v1');
model.sol('sol1').feature.remove('st1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'spf');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').set('control', 'spf');
model.sol('sol1').create('pf1', 'Plugflow');
model.sol('sol1').feature('pf1').set('tlist', '0[m^3] L*A');
model.sol('sol1').feature('pf1').set('plot', 'off');
model.sol('sol1').feature('pf1').set('plotgroup', 'pg1');
model.sol('sol1').feature('pf1').set('plotfreq', 'tout');
model.sol('sol1').feature('pf1').set('probesel', 'all');
model.sol('sol1').feature('pf1').set('probes', {});
model.sol('sol1').feature('pf1').set('probefreq', 'tsteps');
model.sol('sol1').feature('pf1').set('tout', 'tsteps');
model.sol('sol1').feature('pf1').set('rtol', 1.0E-5);
model.sol('sol1').feature('pf1').set('atolglobalvaluemethod', 'factor');
model.sol('sol1').feature('pf1').set('reacf', true);
model.sol('sol1').feature('pf1').set('storeudot', true);
model.sol('sol1').feature('pf1').set('endtimeinterpolation', true);
model.sol('sol1').feature('pf1').set('consistent', 'off');
model.sol('sol1').feature('pf1').set('control', 'spf');
model.sol('sol1').feature('pf1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('pf1').feature('fc1').set('dtech', 'auto');
model.sol('sol1').feature('pf1').feature('fc1').set('linsolver', 'dDef');
model.sol('sol1').feature('pf1').feature('fc1').set('dtech', 'auto');
model.sol('sol1').feature('pf1').feature.remove('fcDef');
model.sol('sol1').attach('std1');

model.batch('p1').feature.remove('so1');
model.batch('p1').create('so1', 'Solutionseq');
model.batch('p1').feature('so1').set('seq', 'sol1');
model.batch('p1').feature('so1').set('store', 'on');
model.batch('p1').feature('so1').set('clear', 'on');
model.batch('p1').feature('so1').set('psol', 'sol2');
model.batch('p1').set('pname', {'X0'});
model.batch('p1').set('plistarr', {'range(1.3,0.1,1.5)'});
model.batch('p1').set('sweeptype', 'sparse');
model.batch('p1').set('probesel', 'all');
model.batch('p1').set('probes', {});
model.batch('p1').set('plot', 'off');
model.batch('p1').set('err', 'on');
model.batch('p1').attach('std1');
model.batch('p1').set('control', 'param');
model.batch('p1').run('compute');

model.result('pg4').run;

model.sol('sol2').copySolution('sol32');
model.sol('sol32').label('Nonisothermal 2');

model.result('pg4').run;
model.result('pg4').label('Selectivity, Nonisothermal');
model.result('pg4').set('data', 'dset5');
model.result('pg4').set('titletype', 'none');
model.result('pg4').set('legendpos', 'middleright');
model.result('pg4').run;
model.result('pg4').feature('glob1').set('expr', {'S'});
model.result('pg4').feature('glob1').set('descr', {'Selectivity'});
model.result('pg4').feature('glob1').set('unit', {'1'});
model.result('pg4').feature('glob1').set('linewidth', 2);
model.result('pg4').feature('glob1').set('autoexpr', false);
model.result('pg4').run;
model.result('pg4').run;
model.result.duplicate('pg5', 'pg4');
model.result('pg5').run;
model.result('pg5').label('Temperature, Nonisothermal');
model.result('pg5').run;
model.result('pg5').feature('glob1').set('expr', {'re.T'});
model.result('pg5').feature('glob1').set('descr', {'Temperature'});
model.result('pg5').feature('glob1').set('unit', {'K'});
model.result('pg5').run;
model.result('pg5').feature('glob1').create('gmrk1', 'GraphMarker');
model.result('pg5').feature('glob1').feature('gmrk1').set('linewidth', 'preference');
model.result('pg5').run;
model.result('pg5').feature('glob1').feature('gmrk1').set('display', 'max');
model.result('pg5').feature('glob1').feature('gmrk1').set('precision', 3);
model.result('pg5').feature('glob1').feature('gmrk1').set('includeunit', true);
model.result('pg5').run;
model.result('pg5').feature.duplicate('glob2', 'glob1');
model.result('pg5').run;
model.result('pg5').feature('glob2').set('expr', {});
model.result('pg5').feature('glob2').set('descr', {});
model.result('pg5').feature('glob2').setIndex('expr', '(F_NO_in/vrate-re.c_NO)/(F_NO_in/vrate)', 0);
model.result('pg5').feature('glob2').setIndex('descr', 'Conversion', 0);
model.result('pg5').run;
model.result('pg5').feature('glob2').feature('gmrk1').set('includeunit', false);
model.result('pg5').feature('glob2').feature('gmrk1').set('anchorpoint', 'lowerright');
model.result('pg5').run;
model.result('pg5').setIndex('looplevelinput', 'manual', 1);
model.result('pg5').setIndex('looplevel', [1 3], 1);
model.result('pg5').set('twoyaxes', true);
model.result('pg5').setIndex('plotonsecyaxis', true, 1, 1);
model.result('pg5').run;
model.result('pg5').run;
model.result('pg5').feature('glob2').set('linecolor', 'cyclereset');
model.result('pg5').feature('glob2').set('linestyle', 'dashed');

model.title('Analysis of NOx Reaction Kinetics');

model.description('This example investigates the NO reduction in the exhaust system of a car, where the reactions take place as flue gases pass through the channels of a monolithic reactor. The study is focused on how temperature and compositions affect the reaction selectivity. The model is set up using the plug flow reactor in the Reaction Engineering interface.');

model.label('monolith_kinetics.mph');

model.result('pg5').run;

model.param.set('X0', '1.35');
model.param.set('por', '0.75');
model.param.descr('por', 'Gas phase volume fraction');
model.param.set('d_N2_in', '0.65[kg/m^3]');
model.param.descr('d_N2_in', 'Density of nitrogen at T_in');
model.param.set('A_in', '3359.9 [mm^2]');
model.param.descr('A_in', 'Inlet cross sectional area');
model.param.set('M0_in', 'v_av*por*A_in*d_N2_in');
model.param.descr('M0_in', 'Mass flow inlet');

model.physics('re').feature('N2').set('sType', 'solvent');
model.physics('re').create('sync1', 'ReactionToMph', -1);
model.physics('re').feature('sync1').set('massbalance', 'DilutedSpeciesInPorousMedia');
model.physics('re').feature('sync1').set('momentumbalance', 'PorousMediaFlowDarcy');
model.physics('re').feature('sync1').set('energybalance', 'PorousMediaHeatTransfer');
model.physics('re').prop('synchronize').set('synchronize', '1');

model.modelNode.create('comp2', true);

model.physics('re').feature('sync1').set('model', {'comp2'});

model.geom.create('geom1', 3);
model.geom('geom1').model('comp2');
model.geom('geom1').axisymmetric(false);
model.geom('geom1').label('Geometry 1(3D)');

model.physics('re').feature('sync1').set('genom', {'geom1'});

model.mesh.create('mesh1', 'geom1');

model.study.create('std2');

model.physics('re').feature('sync1').set('studyname', {'std2'});

model.study('std2').create('stat', 'Stationary');

model.physics.create('chem1', 'Chemistry', 'geom1');
model.physics('chem1').model('comp2');
model.physics('re').feature('sync1').set('Chemistry', {'chem1'});
model.physics.create('tds', 'DilutedSpeciesInPorousMedia', 'geom1');
model.physics('tds').model('comp2');
model.physics('chem1').prop('mixture').set('updatechem', '0');
model.physics('chem1').prop('mixture').set('mixture', 'gas');
model.physics('chem1').prop('Activity').set('useActivity', '0');
model.physics('chem1').prop('chemkin').set('chemkin', '0');
model.physics('chem1').prop('ChemistryCommonProperty').set('VolumetricConcentrationGlobalActivityStandardState', '1[mol/m^3]');
model.physics('chem1').prop('ChemistryCommonProperty').set('SurfaceSpeciesConcentrationType', 'SurfaceConcentration');
model.physics('chem1').prop('ChemistryCommonProperty').set('SurfaceGlobalActivityStandardState', '1[mol/m^2]');
model.physics('chem1').prop('ChemistryCommonProperty').set('SpeciesrateUserDefinedList', {'N2'});
model.physics('chem1').prop('ChemistryCommonProperty').set('AdditionalSourceFeature', '0');
model.physics('chem1').prop('ActiveSpecies').set('SumActiveSpecies', '5');
model.physics('chem1').prop('ActiveSpecies').set('NumActiveVolumeSpecies', '5');
model.physics('chem1').prop('ActiveSpecies').set('NumActiveSurfaceSpecies', '0');
model.physics('chem1').prop('ActiveSpecies').set('NumActiveSurfaceSpeciesVariable', '0');
model.physics('chem1').prop('ActiveSpecies').set('surface', '0');
model.physics('chem1').prop('solventIsSet').set('solventIsSet', '1');
model.physics('chem1').prop('solventIsSet').set('solventTag', 'N2');
model.physics('chem1').create('rch1', 'ReactionChem');
model.physics('chem1').feature('rch1').set('rSequenceNo', '1');
model.physics('chem1').feature('rch1').set('formula', '4NO+4NH3+O2=>4N2+6H2O');
model.physics('chem1').feature('rch1').set('updatechem', '0');
model.physics('chem1').feature('rch1').set('useArrhenius', '1');
model.physics('chem1').feature('rch1').set('ReactionExpression', 'UserDefined');
model.physics('chem1').feature('rch1').set('r', 'chem.kf_1*chem.c_NO*a*chem.c_NH3/(1+a*max(chem.c_NH3,0[M]))');
model.physics('chem1').feature('rch1').set('kf', '1');
model.physics('chem1').feature('rch1').set('Af', 'A1');
model.physics('chem1').feature('rch1').set('nf', '0');
model.physics('chem1').feature('rch1').set('Ef', 'E1');
model.physics('chem1').feature('rch1').set('bulkFwdOrder', '1');
model.physics('chem1').feature('rch1').set('surfFwdOrder', '0');
model.physics('chem1').feature('rch1').label('1: 4NO+4NH3+O2=>4N2+6H2O');
model.physics('chem1').feature('rch1').set('rClass', 'volumetric');
model.physics('chem1').create('rch2', 'ReactionChem');
model.physics('chem1').feature('rch2').set('rSequenceNo', '2');
model.physics('chem1').feature('rch2').set('formula', '4NH3+3O2=>2N2+6H2O');
model.physics('chem1').feature('rch2').set('updatechem', '0');
model.physics('chem1').feature('rch2').set('useArrhenius', '1');
model.physics('chem1').feature('rch2').set('ReactionExpression', 'UserDefined');
model.physics('chem1').feature('rch2').set('r', 'chem.kf_2*chem.c_NH3');
model.physics('chem1').feature('rch2').set('kf', '1');
model.physics('chem1').feature('rch2').set('Af', 'A2');
model.physics('chem1').feature('rch2').set('nf', '0');
model.physics('chem1').feature('rch2').set('Ef', 'E2');
model.physics('chem1').feature('rch2').set('bulkFwdOrder', '1');
model.physics('chem1').feature('rch2').set('surfFwdOrder', '0');
model.physics('chem1').feature('rch2').label('2: 4NH3+3O2=>2N2+6H2O');
model.physics('chem1').feature('rch2').set('rClass', 'volumetric');
model.physics('chem1').feature('NO').set('SpeciesSource', 'Reaction');
model.physics('chem1').feature('NO').set('sisDef', '1');
model.physics('chem1').feature('NO').set('specLabel', 'NO');
model.physics('chem1').feature('NO').set('speciesNameInput', 'NO');
model.physics('chem1').feature('NO').set('specName', 'NO');
model.physics('chem1').feature('NO').set('enableChemicalFormulaCheckbox', '1');
model.physics('chem1').feature('NO').set('chemicalFormula', 'NO');
model.physics('chem1').feature('NO').set('sType', 'volumetric');
model.physics('chem1').feature('NO').set('M', '30.00625[g/mol]');
model.physics('chem1').feature('NO').set('z', '0');
model.physics('chem1').feature('NO').set('sigma', '3.458[angstrom]');
model.physics('chem1').feature('NO').set('epsilonkb', '107.4[K]');
model.physics('chem1').feature('NO').set('mu', '0[C*m]');
model.physics('chem1').feature('NO').set('rho', '1000[kg/m^3]');
model.physics('chem1').feature('NO').set('k', '0.02[W/(m*K)]');
model.physics('chem1').feature('NO').set('ActivityCoefficient', '1');
model.physics('chem1').feature('NO').set('cLock', '0');
model.physics('chem1').feature('NO').set('Dependent', '0');
model.physics('chem1').feature('NO').set('dependent', '0');
model.physics('chem1').feature('NO').set('SpeciesrateSelection', 'Automatic');
model.physics('chem1').feature('NH3').set('SpeciesSource', 'Reaction');
model.physics('chem1').feature('NH3').set('sisDef', '1');
model.physics('chem1').feature('NH3').set('specLabel', 'NH3');
model.physics('chem1').feature('NH3').set('speciesNameInput', 'NH3');
model.physics('chem1').feature('NH3').set('specName', 'NH3');
model.physics('chem1').feature('NH3').set('enableChemicalFormulaCheckbox', '1');
model.physics('chem1').feature('NH3').set('chemicalFormula', 'NH3');
model.physics('chem1').feature('NH3').set('sType', 'volumetric');
model.physics('chem1').feature('NH3').set('M', '17.03079[g/mol]');
model.physics('chem1').feature('NH3').set('z', '0');
model.physics('chem1').feature('NH3').set('sigma', '3.458[angstrom]');
model.physics('chem1').feature('NH3').set('epsilonkb', '107.4[K]');
model.physics('chem1').feature('NH3').set('mu', '0[C*m]');
model.physics('chem1').feature('NH3').set('rho', '1000[kg/m^3]');
model.physics('chem1').feature('NH3').set('k', '0.02[W/(m*K)]');
model.physics('chem1').feature('NH3').set('ActivityCoefficient', '1');
model.physics('chem1').feature('NH3').set('cLock', '0');
model.physics('chem1').feature('NH3').set('Dependent', '0');
model.physics('chem1').feature('NH3').set('dependent', '0');
model.physics('chem1').feature('NH3').set('SpeciesrateSelection', 'Automatic');
model.physics('chem1').feature('O2').set('SpeciesSource', 'Reaction');
model.physics('chem1').feature('O2').set('sisDef', '1');
model.physics('chem1').feature('O2').set('specLabel', 'O2');
model.physics('chem1').feature('O2').set('speciesNameInput', 'O2');
model.physics('chem1').feature('O2').set('specName', 'O2');
model.physics('chem1').feature('O2').set('enableChemicalFormulaCheckbox', '1');
model.physics('chem1').feature('O2').set('chemicalFormula', 'O2');
model.physics('chem1').feature('O2').set('sType', 'volumetric');
model.physics('chem1').feature('O2').set('M', '31.9988[g/mol]');
model.physics('chem1').feature('O2').set('z', '0');
model.physics('chem1').feature('O2').set('sigma', '3.458[angstrom]');
model.physics('chem1').feature('O2').set('epsilonkb', '107.4[K]');
model.physics('chem1').feature('O2').set('mu', '0[C*m]');
model.physics('chem1').feature('O2').set('rho', '1000[kg/m^3]');
model.physics('chem1').feature('O2').set('k', '0.02[W/(m*K)]');
model.physics('chem1').feature('O2').set('ActivityCoefficient', '1');
model.physics('chem1').feature('O2').set('cLock', '0');
model.physics('chem1').feature('O2').set('Dependent', '0');
model.physics('chem1').feature('O2').set('dependent', '0');
model.physics('chem1').feature('O2').set('SpeciesrateSelection', 'Automatic');
model.physics('chem1').feature('N2').set('SpeciesSource', 'Reaction');
model.physics('chem1').feature('N2').set('sisDef', '1');
model.physics('chem1').feature('N2').set('specLabel', 'N2');
model.physics('chem1').feature('N2').set('speciesNameInput', 'N2');
model.physics('chem1').feature('N2').set('specName', 'N2');
model.physics('chem1').feature('N2').set('enableChemicalFormulaCheckbox', '1');
model.physics('chem1').feature('N2').set('chemicalFormula', 'N2');
model.physics('chem1').feature('N2').set('sType', 'solvent');
model.physics('chem1').feature('N2').set('M', '28.0137[g/mol]');
model.physics('chem1').feature('N2').set('z', '0');
model.physics('chem1').feature('N2').set('sigma', '3.458[angstrom]');
model.physics('chem1').feature('N2').set('epsilonkb', '107.4[K]');
model.physics('chem1').feature('N2').set('mu', '0[C*m]');
model.physics('chem1').feature('N2').set('rho', '1000[kg/m^3]');
model.physics('chem1').feature('N2').set('k', '0.02[W/(m*K)]');
model.physics('chem1').feature('N2').set('ActivityCoefficient', '1');
model.physics('chem1').feature('N2').set('cLock', '1');
model.physics('chem1').feature('N2').set('Dependent', '0');
model.physics('chem1').feature('N2').set('dependent', '0');
model.physics('chem1').feature('N2').set('SpeciesrateSelection', 'Automatic');
model.physics('chem1').feature('H2O').set('SpeciesSource', 'Reaction');
model.physics('chem1').feature('H2O').set('sisDef', '1');
model.physics('chem1').feature('H2O').set('specLabel', 'H2O');
model.physics('chem1').feature('H2O').set('speciesNameInput', 'H2O');
model.physics('chem1').feature('H2O').set('specName', 'H2O');
model.physics('chem1').feature('H2O').set('enableChemicalFormulaCheckbox', '1');
model.physics('chem1').feature('H2O').set('chemicalFormula', 'H2O');
model.physics('chem1').feature('H2O').set('sType', 'volumetric');
model.physics('chem1').feature('H2O').set('M', '18.01536[g/mol]');
model.physics('chem1').feature('H2O').set('z', '0');
model.physics('chem1').feature('H2O').set('sigma', '3.458[angstrom]');
model.physics('chem1').feature('H2O').set('epsilonkb', '107.4[K]');
model.physics('chem1').feature('H2O').set('mu', '0[C*m]');
model.physics('chem1').feature('H2O').set('rho', '1000[kg/m^3]');
model.physics('chem1').feature('H2O').set('k', '0.02[W/(m*K)]');
model.physics('chem1').feature('H2O').set('ActivityCoefficient', '1');
model.physics('chem1').feature('H2O').set('cLock', '0');
model.physics('chem1').feature('H2O').set('Dependent', '0');
model.physics('chem1').feature('H2O').set('dependent', '0');
model.physics('chem1').feature('H2O').set('SpeciesrateSelection', 'Automatic');
model.physics('chem1').prop('simpropChem').set('rSequenceNo', '2');
model.physics('chem1').prop('simpropChem').set('sSequenceNo', '5');
model.physics('chem1').prop('mixture').set('hasPropertyPackage', '1');
model.physics('chem1').prop('mixture').set('PropertyPackage', 'pp1');
model.physics('chem1').prop('mixture').set('Thermodynamics', '1');
model.physics('chem1').prop('ChemistryModelInputParameter').set('PackageSpecies', {'water' 'nitrogen' 'ammonia' 'nitrogen oxide' 'oxygen'});
model.physics('chem1').prop('mixture').set('FullyCoupled', '1');
model.physics('chem1').prop('mixture').set('gasDensitySel', 'Thermodynamics');
model.physics('chem1').prop('mixture').set('liquidDensitySel', 'Thermodynamics');
model.physics('chem1').prop('calcTransport').set('heatCapacitySel', 'Thermodynamics');
model.physics('chem1').prop('calcTransport').set('thermalConductivitySel', 'Thermodynamics');
model.physics('chem1').prop('calcTransport').set('dynamicViscositySel', 'Thermodynamics');
model.physics('chem1').feature('NO').set('MolarMassSelection', 'Thermodynamics');
model.physics('chem1').feature('NO').set('liquidDensitySel', 'Thermodynamics');
model.physics('chem1').feature('NO').set('GasThermalConductivitySel', 'Thermodynamics');
model.physics('chem1').feature('NO').set('GasDiffusivitySel', 'Thermodynamics');
model.physics('chem1').feature('NO').set('LiquidDiffusivitySel', 'Thermodynamics');
model.physics('chem1').feature('NO').set('speciesEnthalpy', 'Thermodynamics');
model.physics('chem1').feature('NO').set('Thermodynamics', '1');
model.physics('chem1').feature('NH3').set('MolarMassSelection', 'Thermodynamics');
model.physics('chem1').feature('NH3').set('liquidDensitySel', 'Thermodynamics');
model.physics('chem1').feature('NH3').set('GasThermalConductivitySel', 'Thermodynamics');
model.physics('chem1').feature('NH3').set('GasDiffusivitySel', 'Thermodynamics');
model.physics('chem1').feature('NH3').set('LiquidDiffusivitySel', 'Thermodynamics');
model.physics('chem1').feature('NH3').set('speciesEnthalpy', 'Thermodynamics');
model.physics('chem1').feature('NH3').set('Thermodynamics', '1');
model.physics('chem1').feature('O2').set('MolarMassSelection', 'Thermodynamics');
model.physics('chem1').feature('O2').set('liquidDensitySel', 'Thermodynamics');
model.physics('chem1').feature('O2').set('GasThermalConductivitySel', 'Thermodynamics');
model.physics('chem1').feature('O2').set('GasDiffusivitySel', 'Thermodynamics');
model.physics('chem1').feature('O2').set('LiquidDiffusivitySel', 'Thermodynamics');
model.physics('chem1').feature('O2').set('speciesEnthalpy', 'Thermodynamics');
model.physics('chem1').feature('O2').set('Thermodynamics', '1');
model.physics('chem1').feature('N2').set('MolarMassSelection', 'Thermodynamics');
model.physics('chem1').feature('N2').set('liquidDensitySel', 'Thermodynamics');
model.physics('chem1').feature('N2').set('GasThermalConductivitySel', 'Thermodynamics');
model.physics('chem1').feature('N2').set('GasDiffusivitySel', 'Thermodynamics');
model.physics('chem1').feature('N2').set('LiquidDiffusivitySel', 'Thermodynamics');
model.physics('chem1').feature('N2').set('speciesEnthalpy', 'Thermodynamics');
model.physics('chem1').feature('N2').set('Thermodynamics', '1');
model.physics('chem1').feature('H2O').set('MolarMassSelection', 'Thermodynamics');
model.physics('chem1').feature('H2O').set('liquidDensitySel', 'Thermodynamics');
model.physics('chem1').feature('H2O').set('GasThermalConductivitySel', 'Thermodynamics');
model.physics('chem1').feature('H2O').set('GasDiffusivitySel', 'Thermodynamics');
model.physics('chem1').feature('H2O').set('LiquidDiffusivitySel', 'Thermodynamics');
model.physics('chem1').feature('H2O').set('speciesEnthalpy', 'Thermodynamics');
model.physics('chem1').feature('H2O').set('Thermodynamics', '1');
model.physics('chem1').prop('mixture').set('updatechem', '1');

model.thermodynamics.feature('pp1').set('physicsID', 'chem1');
model.thermodynamics.feature('pp1').set('FunctionList', {'M' 'sigma' 'epsilonkb' 'mu' 'M' 'sigma' 'epsilonkb' 'mu' 'M' 'sigma'  ...
'epsilonkb' 'mu' 'M' 'sigma' 'epsilonkb' 'mu' 'M' 'sigma' 'epsilonkb' 'mu'  ...
'rho' 'hF' 'h' 'sF' 'Cp' 'gamma' 'D' 'k' 'eta';  ...
'water' 'water' 'water' 'water' 'nitrogen' 'nitrogen' 'nitrogen' 'nitrogen' 'ammonia' 'ammonia'  ...
'ammonia' 'ammonia' 'nitrogen oxide' 'nitrogen oxide' 'nitrogen oxide' 'nitrogen oxide' 'oxygen' 'oxygen' 'oxygen' 'oxygen'  ...
'water:nitrogen:ammonia:nitrogen oxide:oxygen' 'water:nitrogen:ammonia:nitrogen oxide:oxygen' 'water:nitrogen:ammonia:nitrogen oxide:oxygen' 'water:nitrogen:ammonia:nitrogen oxide:oxygen' 'water:nitrogen:ammonia:nitrogen oxide:oxygen' 'water:nitrogen:ammonia:nitrogen oxide:oxygen' 'water:ammonia:nitrogen oxide:oxygen:nitrogen' 'water:nitrogen:ammonia:nitrogen oxide:oxygen' 'water:nitrogen:ammonia:nitrogen oxide:oxygen';  ...
'CONSTANT' 'CONSTANT' 'CONSTANT' 'CONSTANT' 'CONSTANT' 'CONSTANT' 'CONSTANT' 'CONSTANT' 'CONSTANT' 'CONSTANT'  ...
'CONSTANT' 'CONSTANT' 'CONSTANT' 'CONSTANT' 'CONSTANT' 'CONSTANT' 'CONSTANT' 'CONSTANT' 'CONSTANT' 'CONSTANT'  ...
'ONEPHASE' 'ONEPHASE' 'ONEPHASE' 'ONEPHASE' 'ONEPHASE' 'ONEPHASE' 'ONEPHASE' 'ONEPHASE' 'ONEPHASE';  ...
'mole' 'mole' 'mole' 'mole' 'mole' 'mole' 'mole' 'mole' 'mole' 'mole'  ...
'mole' 'mole' 'mole' 'mole' 'mole' 'mole' 'mole' 'mole' 'mole' 'mole'  ...
'mass' 'mole' 'mass' 'mole' 'mole' 'mole' 'mole' 'mole' 'mole';  ...
'mole' 'mole' 'mole' 'mole' 'mole' 'mole' 'mole' 'mole' 'mole' 'mole'  ...
'mole' 'mole' 'mole' 'mole' 'mole' 'mole' 'mole' 'mole' 'mole' 'mole'  ...
'mole' 'mole' 'mass' 'mole' 'mole' 'mole' 'mole' 'mole' 'mole'});
model.thermodynamics.feature('pp1').set('Create', '0');

model.physics('tds').field('concentration').component({'cH2O' 'cNH3' 'cNO' 'cO2'});
model.physics('tds').feature('init1').set('initc', {'F_H2O_in/vrate' 'F_NH3_in/vrate' 'F_NO_in/vrate' 'F_O2_in/vrate'});
model.physics('tds').feature.create('reac1', 'Reactions');
model.physics('tds').feature('reac1').selection.all;
model.physics('tds').feature('reac1').set('ReactingVolumeType', 'PoreVolume');
model.physics('tds').feature.create('in1', 'Inflow');
model.physics('tds').feature('in1').setIndex('c0', 'F_H2O_in/vrate', 0);
model.physics('tds').feature('in1').setIndex('c0', 'F_NH3_in/vrate', 1);
model.physics('tds').feature('in1').setIndex('c0', 'F_NO_in/vrate', 2);
model.physics('tds').feature('in1').setIndex('c0', 'F_O2_in/vrate', 3);
model.physics('tds').feature.create('out1', 'Outflow');
model.physics('chem1').prop('ChemistryModelInputParameter').set('MassTransfer', 'tds');
model.physics('chem1').prop('ChemistryModelInputParameter').set('ConcentrationInput', {'cH2O' 'UserDefined' 'cNH3' 'cNO' 'cO2'});
model.physics('chem1').prop('ChemistryModelInputParameter').set('ConcentrationValue', {'Solved for' 'F_N2_in/vrate' 'Solved for' 'Solved for' 'Solved for'});
model.physics('chem1').prop('ChemistryModelInputParameter').set('uselog', {'cH2O' 'F_N2_in/vrate' 'cNH3' 'cNO' 'cO2'});
model.physics('chem1').prop('ChemistryModelInputParameter').set('SolidConcentration', {});
model.physics('chem1').prop('ChemistryModelInputParameter').set('csurf', {});
model.physics('chem1').prop('ChemistryModelInputParameter').set('AqueousSpeciesConcentration', {});
model.physics('tds').feature('sp1').set('z', {'0' '0' '0' '0'});
model.physics('tds').feature('porous1').feature('fluid1').set('DiffusionCoefficientSource', 'chem');
model.physics('tds').feature('porous1').feature('fluid1').set('Dchem_cH2O_src', 'userdef');
model.physics('tds').feature('porous1').feature('fluid1').set('Dchem_cNH3_src', 'userdef');
model.physics('tds').feature('porous1').feature('fluid1').set('Dchem_cNO_src', 'userdef');
model.physics('tds').feature('porous1').feature('fluid1').set('Dchem_cO2_src', 'userdef');
model.physics('tds').feature('reac1').setIndex('R_cH2O_src', 'root.comp2.chem.R_H2O', 0);
model.physics('tds').feature('reac1').setIndex('R_cNH3_src', 'root.comp2.chem.R_NH3', 0);
model.physics('tds').feature('reac1').setIndex('R_cNO_src', 'root.comp2.chem.R_NO', 0);
model.physics('tds').feature('reac1').setIndex('R_cO2_src', 'root.comp2.chem.R_O2', 0);
model.physics.create('ht1', 'PorousMediaHeatTransfer', 'geom1');
model.physics('ht1').model('comp2');
model.physics('ht1').feature('porous1').set('PorousMediumType', 'LocalThermalEquilibrium');
model.physics('ht1').feature('porous1').feature('fluid1').setIndex('fluidType', 'gasLiquid', 0);
model.physics('ht1').feature('porous1').feature('fluid1').setIndex('gamma_mat', 'userdef', 0);
model.physics('ht1').feature.create('temp1', 'TemperatureBoundary');
model.physics('ht1').feature('temp1').set('T0', 'T_in');
model.physics('ht1').feature.create('ofl1', 'ConvectiveOutflow');
model.physics('ht1').feature('init1').set('Tinit', '298.15[K]');
model.physics('ht1').feature.create('hs1', 'HeatSource');
model.physics('ht1').feature('hs1').selection.all;
model.physics('ht1').feature('hs1').set('Q0_src', 'root.comp2.chem.Qtot');
model.physics.create('dl1', 'PorousMediaFlowDarcy', 'geom1');
model.physics('dl1').model('comp2');
model.physics('dl1').feature.create('inl1', 'Inlet');
model.physics('dl1').feature.create('out1', 'Outlet');
model.physics('re').feature('sync1').set('geomToUse', 'geom1');
model.physics('re').feature('sync1').set('massbalance', 'tds');
model.physics('tds').feature('porous1').feature('fluid1').set('u_src', 'root.comp2.dl.u');
model.physics('tds').feature('porous1').feature('fluid1').set('minput_temperature_src', 'root.comp2.T');
model.physics('tds').feature('porous1').feature('fluid1').set('minput_pressure_src', 'root.comp2.dl.pA');
model.physics('re').feature('sync1').set('energybalance', 'ht1');
model.physics('ht1').feature('porous1').feature('fluid1').set('gamma_not_IG_mat', 'root.comp2.chem.gamma');
model.physics('ht1').feature('porous1').feature('fluid1').set('rho_mat', 'root.comp2.chem.rho');
model.physics('ht1').feature('porous1').feature('fluid1').set('Cp_mat', 'root.comp2.chem.Cptot');
model.physics('ht1').feature('porous1').feature('fluid1').set('minput_pressure_src', 'root.comp2.dl.pA');
model.physics('ht1').feature('porous1').feature('fluid1').set('k_mat', 'root.comp2.chem.kxx');
model.physics('ht1').feature('porous1').feature('fluid1').set('u_src', 'root.comp2.dl.u');
model.physics('chem1').prop('TPFeatureInput').set('T_src', 'root.comp2.T');
model.physics('ht1').feature('porous1').feature('fluid1').set('molarmass_mat', 'root.comp2.chem.M_NO');
model.physics('ht1').feature('hs1').setIndex('Q0_src', 'userdef', 0);
model.physics('ht1').feature('hs1').set('Q0', '(1-comp2.ht.porous.pm.theta)*comp2.chem.Qtot');
model.physics('ht1').feature('porous1').feature('fluid1').set('fluidType', 'gasLiquid');
model.physics('ht1').feature('porous1').feature('fluid1').set('Cp_mat', 'root.comp2.chem.Cptot');
model.physics('re').feature('sync1').set('momentumbalance', 'dl1');
model.physics('dl1').feature('porous1').feature('fluid1').set('rho_mat', 'root.comp2.chem.rho');
model.physics('chem1').prop('TPFeatureInput').set('p_src', 'root.comp2.dl.pA');
model.physics('dl1').feature('porous1').feature('fluid1').set('mu_mat', 'root.comp2.chem.eta');
model.physics('re').feature('sync1').set('genom', {'geom1'});
model.physics('re').feature('sync1').set('studyname', {'std2'});
model.physics('chem1').prop('StudyStep').set('StudyStep', 'std2/stat');
model.physics('chem1').feature('dcont1').set('StudyStep', 'std2/stat');
model.physics('chem1').feature('rch1').set('StudyStep', 'std2/stat');
model.physics('chem1').feature('NO').set('StudyStep', 'std2/stat');
model.physics('chem1').feature('NH3').set('StudyStep', 'std2/stat');
model.physics('chem1').feature('O2').set('StudyStep', 'std2/stat');
model.physics('chem1').feature('N2').set('StudyStep', 'std2/stat');
model.physics('chem1').feature('H2O').set('StudyStep', 'std2/stat');
model.physics('chem1').feature('rch2').set('StudyStep', 'std2/stat');
model.physics('tds').prop('StudyStep').set('StudyStep', 'std2/stat');
model.physics('tds').feature('sp1').set('StudyStep', 'std2/stat');
model.physics('tds').feature('porous1').set('StudyStep', 'std2/stat');
model.physics('tds').feature('nflx1').set('StudyStep', 'std2/stat');
model.physics('tds').feature('init1').set('StudyStep', 'std2/stat');
model.physics('tds').feature('dcont1').set('StudyStep', 'std2/stat');
model.physics('tds').feature('reac1').set('StudyStep', 'std2/stat');
model.physics('tds').feature('in1').set('StudyStep', 'std2/stat');
model.physics('tds').feature('out1').set('StudyStep', 'std2/stat');
model.physics('ht1').prop('StudyStep').set('StudyStep', 'std2/stat');
model.physics('ht1').feature('porous1').set('StudyStep', 'std2/stat');
model.physics('ht1').feature('init1').set('StudyStep', 'std2/stat');
model.physics('ht1').feature('ins1').set('StudyStep', 'std2/stat');
model.physics('ht1').feature('idi1').set('StudyStep', 'std2/stat');
model.physics('ht1').feature('ltneb1').set('StudyStep', 'std2/stat');
model.physics('ht1').feature('os1').set('StudyStep', 'std2/stat');
model.physics('ht1').feature('cib1').set('StudyStep', 'std2/stat');
model.physics('ht1').feature('dcont1').set('StudyStep', 'std2/stat');
model.physics('ht1').feature('temp1').set('StudyStep', 'std2/stat');
model.physics('ht1').feature('ofl1').set('StudyStep', 'std2/stat');
model.physics('ht1').feature('hs1').set('StudyStep', 'std2/stat');
model.physics('dl1').prop('StudyStep').set('StudyStep', 'std2/stat');
model.physics('dl1').feature('porous1').set('StudyStep', 'std2/stat');
model.physics('dl1').feature('nf1').set('StudyStep', 'std2/stat');
model.physics('dl1').feature('gr1').set('StudyStep', 'std2/stat');
model.physics('dl1').feature('init1').set('StudyStep', 'std2/stat');
model.physics('dl1').feature('dcont1').set('StudyStep', 'std2/stat');
model.physics('dl1').feature('inl1').set('StudyStep', 'std2/stat');
model.physics('dl1').feature('out1').set('StudyStep', 'std2/stat');

model.study('std1').feature('param').setSolveFor('/physics/chem1', false);
model.study('std1').feature('spf').setSolveFor('/physics/chem1', false);
model.study('std1').feature('param').setSolveFor('/physics/tds', false);
model.study('std1').feature('spf').setSolveFor('/physics/tds', false);
model.study('std1').feature('param').setSolveFor('/physics/ht1', false);
model.study('std1').feature('spf').setSolveFor('/physics/ht1', false);
model.study('std1').feature('param').setSolveFor('/physics/dl1', false);
model.study('std1').feature('spf').setSolveFor('/physics/dl1', false);
model.study('std2').feature('stat').setSolveFor('/physics/re', false);

model.geom('geom1').run;

model.modelNode('comp2').label('3D Model');

model.variable.create('var2');
model.variable('var2').model('comp2');
model.variable('var2').set('S', 'chem.r_1/chem.r_2', 'Selectivity');
model.variable('var2').descr('S', 'Selectivity');
model.variable('var2').set('a', 'a0*exp(-E0/(R_const*chem.T))', 'Concentration correction');
model.variable('var2').descr('a', 'Concentration correction');

model.geom('geom1').insertFile('monolith_3d_geom_sequence.mph', 'geom1');
model.geom('geom1').run('unisel1');

model.thermodynamics.feature('pp1').feature.create('singlephase1', 'OnePhaseProperty');
model.thermodynamics.feature('pp1').feature('singlephase1').label('Density 2');
model.thermodynamics.feature('pp1').feature('singlephase1').set('funcname', 'Density_ammonia_nitrogen_nitrogen_oxide_oxygen_water_Gas11');
model.thermodynamics.feature('pp1').feature('singlephase1').set('property', 'Density');
model.thermodynamics.feature('pp1').feature('singlephase1').set('propertydescr', 'Density');
model.thermodynamics.feature('pp1').feature('singlephase1').set('unit', 'kg/m^3');
model.thermodynamics.feature('pp1').feature('singlephase1').set('prop_basis', 'mass');
model.thermodynamics.feature('pp1').feature('singlephase1').set('compounds', {'ammonia' 'nitrogen' 'nitrogen oxide' 'oxygen' 'water'});
model.thermodynamics.feature('pp1').feature('singlephase1').set('args', {'temperature' 'K' 'Temperature';  ...
'pressure' 'Pa' 'Pressure';  ...
'massfraction_ammonia' '1' 'Mass fraction ammonia';  ...
'massfraction_nitrogen' '1' 'Mass fraction nitrogen';  ...
'massfraction_nitrogen_oxide' '1' 'Mass fraction nitrogen oxide';  ...
'massfraction_oxygen' '1' 'Mass fraction oxygen';  ...
'massfraction_water' '1' 'Mass fraction water'});
model.thermodynamics.feature('pp1').feature('singlephase1').set('plotargs', {'temperature' '298.15' '373.15';  ...
'pressure' '101325' '101325';  ...
'massfraction_ammonia' '0.2' '0.2';  ...
'massfraction_nitrogen' '0.2' '0.2';  ...
'massfraction_nitrogen_oxide' '0.2' '0.2';  ...
'massfraction_oxygen' '0.2' '0.2';  ...
'massfraction_water' '0.2' '0.2'});
model.thermodynamics.feature('pp1').feature('singlephase1').set('derivatives', {'Density_ammonia_nitrogen_nitrogen_oxide_oxygen_water_Gas11_Dtemperature' 'Density_ammonia_nitrogen_nitrogen_oxide_oxygen_water_Gas11_Dpressure' 'Density_ammonia_nitrogen_nitrogen_oxide_oxygen_water_Gas11_Dmassfraction_ammonia' 'Density_ammonia_nitrogen_nitrogen_oxide_oxygen_water_Gas11_Dmassfraction_nitrogen' 'Density_ammonia_nitrogen_nitrogen_oxide_oxygen_water_Gas11_Dmassfraction_nitrogen_oxide' 'Density_ammonia_nitrogen_nitrogen_oxide_oxygen_water_Gas11_Dmassfraction_oxygen' 'Density_ammonia_nitrogen_nitrogen_oxide_oxygen_water_Gas11_Dmassfraction_water'});
model.thermodynamics.feature('pp1').feature('singlephase1').set('SecondDerivatives', {'Density_ammonia_nitrogen_nitrogen_oxide_oxygen_water_Gas11_Dtemperature_Dtemperature' 'Density_ammonia_nitrogen_nitrogen_oxide_oxygen_water_Gas11_Dtemperature_Dpressure' 'Density_ammonia_nitrogen_nitrogen_oxide_oxygen_water_Gas11_Dpressure_Dpressure'});
model.thermodynamics.feature('pp1').feature('singlephase1').set('SecondDerivativeIndices', {'0' '0' '0' '0' '1' '1' '1' '1' '2'});
model.thermodynamics.feature('pp1').feature('singlephase1').set('phase', 'Gas');
model.thermodynamics.feature('pp1').feature('singlephase1').set('comp_basis', 'mass');
model.thermodynamics.feature('pp1').feature('singlephase1').set('include_derivatives', 'yes');
model.thermodynamics.feature('pp1').feature.create('singlephase2', 'OnePhaseProperty');
model.thermodynamics.feature('pp1').feature('singlephase2').label('Heat capacity (Cp) 3');
model.thermodynamics.feature('pp1').feature('singlephase2').set('funcname', 'HeatCapacityCp_ammonia_nitrogen_nitrogen_oxide_oxygen_water_Gas12');
model.thermodynamics.feature('pp1').feature('singlephase2').set('property', 'HeatCapacityCp');
model.thermodynamics.feature('pp1').feature('singlephase2').set('propertydescr', 'Heat capacity (Cp)');
model.thermodynamics.feature('pp1').feature('singlephase2').set('unit', 'J/kg/K');
model.thermodynamics.feature('pp1').feature('singlephase2').set('prop_basis', 'mass');
model.thermodynamics.feature('pp1').feature('singlephase2').set('compounds', {'ammonia' 'nitrogen' 'nitrogen oxide' 'oxygen' 'water'});
model.thermodynamics.feature('pp1').feature('singlephase2').set('args', {'temperature' 'K' 'Temperature';  ...
'pressure' 'Pa' 'Pressure';  ...
'massfraction_ammonia' '1' 'Mass fraction ammonia';  ...
'massfraction_nitrogen' '1' 'Mass fraction nitrogen';  ...
'massfraction_nitrogen_oxide' '1' 'Mass fraction nitrogen oxide';  ...
'massfraction_oxygen' '1' 'Mass fraction oxygen';  ...
'massfraction_water' '1' 'Mass fraction water'});
model.thermodynamics.feature('pp1').feature('singlephase2').set('plotargs', {'temperature' '298.15' '373.15';  ...
'pressure' '101325' '101325';  ...
'massfraction_ammonia' '0.2' '0.2';  ...
'massfraction_nitrogen' '0.2' '0.2';  ...
'massfraction_nitrogen_oxide' '0.2' '0.2';  ...
'massfraction_oxygen' '0.2' '0.2';  ...
'massfraction_water' '0.2' '0.2'});
model.thermodynamics.feature('pp1').feature('singlephase2').set('derivatives', {'HeatCapacityCp_ammonia_nitrogen_nitrogen_oxide_oxygen_water_Gas12_Dtemperature' 'HeatCapacityCp_ammonia_nitrogen_nitrogen_oxide_oxygen_water_Gas12_Dpressure' 'HeatCapacityCp_ammonia_nitrogen_nitrogen_oxide_oxygen_water_Gas12_Dmassfraction_ammonia' 'HeatCapacityCp_ammonia_nitrogen_nitrogen_oxide_oxygen_water_Gas12_Dmassfraction_nitrogen' 'HeatCapacityCp_ammonia_nitrogen_nitrogen_oxide_oxygen_water_Gas12_Dmassfraction_nitrogen_oxide' 'HeatCapacityCp_ammonia_nitrogen_nitrogen_oxide_oxygen_water_Gas12_Dmassfraction_oxygen' 'HeatCapacityCp_ammonia_nitrogen_nitrogen_oxide_oxygen_water_Gas12_Dmassfraction_water'});
model.thermodynamics.feature('pp1').feature('singlephase2').set('SecondDerivatives', {});
model.thermodynamics.feature('pp1').feature('singlephase2').set('SecondDerivativeIndices', {});
model.thermodynamics.feature('pp1').feature('singlephase2').set('phase', 'Gas');
model.thermodynamics.feature('pp1').feature('singlephase2').set('comp_basis', 'mass');
model.thermodynamics.feature('pp1').feature('singlephase2').set('include_derivatives', 'yes');
model.thermodynamics.feature('pp1').feature.create('singlephase3', 'OnePhaseProperty');
model.thermodynamics.feature('pp1').feature('singlephase3').label('Heat capacity ratio (Cp/Cv) 2');
model.thermodynamics.feature('pp1').feature('singlephase3').set('funcname', 'HeatCapacityRatioCpCv_ammonia_nitrogen_nitrogen_oxide_oxygen_water_Gas13');
model.thermodynamics.feature('pp1').feature('singlephase3').set('property', 'HeatCapacityRatioCpCv');
model.thermodynamics.feature('pp1').feature('singlephase3').set('propertydescr', 'Heat capacity ratio (Cp/Cv)');
model.thermodynamics.feature('pp1').feature('singlephase3').set('unit', '1');
model.thermodynamics.feature('pp1').feature('singlephase3').set('prop_basis', 'mass');
model.thermodynamics.feature('pp1').feature('singlephase3').set('compounds', {'ammonia' 'nitrogen' 'nitrogen oxide' 'oxygen' 'water'});
model.thermodynamics.feature('pp1').feature('singlephase3').set('args', {'temperature' 'K' 'Temperature';  ...
'pressure' 'Pa' 'Pressure';  ...
'massfraction_ammonia' '1' 'Mass fraction ammonia';  ...
'massfraction_nitrogen' '1' 'Mass fraction nitrogen';  ...
'massfraction_nitrogen_oxide' '1' 'Mass fraction nitrogen oxide';  ...
'massfraction_oxygen' '1' 'Mass fraction oxygen';  ...
'massfraction_water' '1' 'Mass fraction water'});
model.thermodynamics.feature('pp1').feature('singlephase3').set('plotargs', {'temperature' '298.15' '373.15';  ...
'pressure' '101325' '101325';  ...
'massfraction_ammonia' '0.2' '0.2';  ...
'massfraction_nitrogen' '0.2' '0.2';  ...
'massfraction_nitrogen_oxide' '0.2' '0.2';  ...
'massfraction_oxygen' '0.2' '0.2';  ...
'massfraction_water' '0.2' '0.2'});
model.thermodynamics.feature('pp1').feature('singlephase3').set('derivatives', {'HeatCapacityRatioCpCv_ammonia_nitrogen_nitrogen_oxide_oxygen_water_Gas13_Dtemperature' 'HeatCapacityRatioCpCv_ammonia_nitrogen_nitrogen_oxide_oxygen_water_Gas13_Dpressure' 'HeatCapacityRatioCpCv_ammonia_nitrogen_nitrogen_oxide_oxygen_water_Gas13_Dmassfraction_ammonia' 'HeatCapacityRatioCpCv_ammonia_nitrogen_nitrogen_oxide_oxygen_water_Gas13_Dmassfraction_nitrogen' 'HeatCapacityRatioCpCv_ammonia_nitrogen_nitrogen_oxide_oxygen_water_Gas13_Dmassfraction_nitrogen_oxide' 'HeatCapacityRatioCpCv_ammonia_nitrogen_nitrogen_oxide_oxygen_water_Gas13_Dmassfraction_oxygen' 'HeatCapacityRatioCpCv_ammonia_nitrogen_nitrogen_oxide_oxygen_water_Gas13_Dmassfraction_water'});
model.thermodynamics.feature('pp1').feature('singlephase3').set('SecondDerivatives', {});
model.thermodynamics.feature('pp1').feature('singlephase3').set('SecondDerivativeIndices', {});
model.thermodynamics.feature('pp1').feature('singlephase3').set('phase', 'Gas');
model.thermodynamics.feature('pp1').feature('singlephase3').set('comp_basis', 'mass');
model.thermodynamics.feature('pp1').feature('singlephase3').set('include_derivatives', 'yes');
model.thermodynamics.feature('pp1').feature.create('singlephase4', 'OnePhaseProperty');
model.thermodynamics.feature('pp1').feature('singlephase4').label('Thermal conductivity 2');
model.thermodynamics.feature('pp1').feature('singlephase4').set('funcname', 'ThermalConductivity_ammonia_nitrogen_nitrogen_oxide_oxygen_water_Gas14');
model.thermodynamics.feature('pp1').feature('singlephase4').set('property', 'ThermalConductivity');
model.thermodynamics.feature('pp1').feature('singlephase4').set('propertydescr', 'Thermal conductivity');
model.thermodynamics.feature('pp1').feature('singlephase4').set('unit', 'W/m/K');
model.thermodynamics.feature('pp1').feature('singlephase4').set('prop_basis', 'mass');
model.thermodynamics.feature('pp1').feature('singlephase4').set('compounds', {'ammonia' 'nitrogen' 'nitrogen oxide' 'oxygen' 'water'});
model.thermodynamics.feature('pp1').feature('singlephase4').set('args', {'temperature' 'K' 'Temperature';  ...
'pressure' 'Pa' 'Pressure';  ...
'massfraction_ammonia' '1' 'Mass fraction ammonia';  ...
'massfraction_nitrogen' '1' 'Mass fraction nitrogen';  ...
'massfraction_nitrogen_oxide' '1' 'Mass fraction nitrogen oxide';  ...
'massfraction_oxygen' '1' 'Mass fraction oxygen';  ...
'massfraction_water' '1' 'Mass fraction water'});
model.thermodynamics.feature('pp1').feature('singlephase4').set('plotargs', {'temperature' '298.15' '373.15';  ...
'pressure' '101325' '101325';  ...
'massfraction_ammonia' '0.2' '0.2';  ...
'massfraction_nitrogen' '0.2' '0.2';  ...
'massfraction_nitrogen_oxide' '0.2' '0.2';  ...
'massfraction_oxygen' '0.2' '0.2';  ...
'massfraction_water' '0.2' '0.2'});
model.thermodynamics.feature('pp1').feature('singlephase4').set('derivatives', {'ThermalConductivity_ammonia_nitrogen_nitrogen_oxide_oxygen_water_Gas14_Dtemperature' 'ThermalConductivity_ammonia_nitrogen_nitrogen_oxide_oxygen_water_Gas14_Dpressure' 'ThermalConductivity_ammonia_nitrogen_nitrogen_oxide_oxygen_water_Gas14_Dmassfraction_ammonia' 'ThermalConductivity_ammonia_nitrogen_nitrogen_oxide_oxygen_water_Gas14_Dmassfraction_nitrogen' 'ThermalConductivity_ammonia_nitrogen_nitrogen_oxide_oxygen_water_Gas14_Dmassfraction_nitrogen_oxide' 'ThermalConductivity_ammonia_nitrogen_nitrogen_oxide_oxygen_water_Gas14_Dmassfraction_oxygen' 'ThermalConductivity_ammonia_nitrogen_nitrogen_oxide_oxygen_water_Gas14_Dmassfraction_water'});
model.thermodynamics.feature('pp1').feature('singlephase4').set('SecondDerivatives', {});
model.thermodynamics.feature('pp1').feature('singlephase4').set('SecondDerivativeIndices', {});
model.thermodynamics.feature('pp1').feature('singlephase4').set('phase', 'Gas');
model.thermodynamics.feature('pp1').feature('singlephase4').set('comp_basis', 'mass');
model.thermodynamics.feature('pp1').feature('singlephase4').set('include_derivatives', 'yes');
model.thermodynamics.feature('pp1').feature.create('singlephase5', 'OnePhaseProperty');
model.thermodynamics.feature('pp1').feature('singlephase5').label('Viscosity 2');
model.thermodynamics.feature('pp1').feature('singlephase5').set('funcname', 'Viscosity_ammonia_nitrogen_nitrogen_oxide_oxygen_water_Gas15');
model.thermodynamics.feature('pp1').feature('singlephase5').set('property', 'Viscosity');
model.thermodynamics.feature('pp1').feature('singlephase5').set('propertydescr', 'Viscosity');
model.thermodynamics.feature('pp1').feature('singlephase5').set('unit', 'Pa*s');
model.thermodynamics.feature('pp1').feature('singlephase5').set('prop_basis', 'mass');
model.thermodynamics.feature('pp1').feature('singlephase5').set('compounds', {'ammonia' 'nitrogen' 'nitrogen oxide' 'oxygen' 'water'});
model.thermodynamics.feature('pp1').feature('singlephase5').set('args', {'temperature' 'K' 'Temperature';  ...
'pressure' 'Pa' 'Pressure';  ...
'massfraction_ammonia' '1' 'Mass fraction ammonia';  ...
'massfraction_nitrogen' '1' 'Mass fraction nitrogen';  ...
'massfraction_nitrogen_oxide' '1' 'Mass fraction nitrogen oxide';  ...
'massfraction_oxygen' '1' 'Mass fraction oxygen';  ...
'massfraction_water' '1' 'Mass fraction water'});
model.thermodynamics.feature('pp1').feature('singlephase5').set('plotargs', {'temperature' '298.15' '373.15';  ...
'pressure' '101325' '101325';  ...
'massfraction_ammonia' '0.2' '0.2';  ...
'massfraction_nitrogen' '0.2' '0.2';  ...
'massfraction_nitrogen_oxide' '0.2' '0.2';  ...
'massfraction_oxygen' '0.2' '0.2';  ...
'massfraction_water' '0.2' '0.2'});
model.thermodynamics.feature('pp1').feature('singlephase5').set('derivatives', {'Viscosity_ammonia_nitrogen_nitrogen_oxide_oxygen_water_Gas15_Dtemperature' 'Viscosity_ammonia_nitrogen_nitrogen_oxide_oxygen_water_Gas15_Dpressure' 'Viscosity_ammonia_nitrogen_nitrogen_oxide_oxygen_water_Gas15_Dmassfraction_ammonia' 'Viscosity_ammonia_nitrogen_nitrogen_oxide_oxygen_water_Gas15_Dmassfraction_nitrogen' 'Viscosity_ammonia_nitrogen_nitrogen_oxide_oxygen_water_Gas15_Dmassfraction_nitrogen_oxide' 'Viscosity_ammonia_nitrogen_nitrogen_oxide_oxygen_water_Gas15_Dmassfraction_oxygen' 'Viscosity_ammonia_nitrogen_nitrogen_oxide_oxygen_water_Gas15_Dmassfraction_water'});
model.thermodynamics.feature('pp1').feature('singlephase5').set('SecondDerivatives', {});
model.thermodynamics.feature('pp1').feature('singlephase5').set('SecondDerivativeIndices', {});
model.thermodynamics.feature('pp1').feature('singlephase5').set('phase', 'Gas');
model.thermodynamics.feature('pp1').feature('singlephase5').set('comp_basis', 'mass');
model.thermodynamics.feature('pp1').feature('singlephase5').set('include_derivatives', 'yes');
model.thermodynamics.feature('pp1').feature.create('singlephase6', 'OnePhaseProperty');
model.thermodynamics.feature('pp1').feature('singlephase6').label('Diffusion coefficient at infinite dilution 5');
model.thermodynamics.feature('pp1').feature('singlephase6').set('IgnoreComposition', 'true');
model.thermodynamics.feature('pp1').feature('singlephase6').set('funcname', 'DiffusionCoeffient_ammonia_in_nitrogen_Vapor11');
model.thermodynamics.feature('pp1').feature('singlephase6').set('property', 'BinaryDiffusionCoeffientAtInfiniteDilution[ammonia,nitrogen]');
model.thermodynamics.feature('pp1').feature('singlephase6').set('propertydescr', 'Diffusion coefficient at infinite dilution [ammonia,nitrogen]');
model.thermodynamics.feature('pp1').feature('singlephase6').set('unit', 'm^2/s');
model.thermodynamics.feature('pp1').feature('singlephase6').set('prop_basis', 'mass');
model.thermodynamics.feature('pp1').feature('singlephase6').set('compounds', {'ammonia' 'nitrogen' 'nitrogen oxide' 'oxygen' 'water'});
model.thermodynamics.feature('pp1').feature('singlephase6').set('args', {'temperature' 'K' 'Temperature'; 'pressure' 'Pa' 'Pressure'});
model.thermodynamics.feature('pp1').feature('singlephase6').set('plotargs', {'temperature' '298.15' '373.15'; 'pressure' '101325' '101325'});
model.thermodynamics.feature('pp1').feature('singlephase6').set('derivatives', {'DiffusionCoeffient_ammonia_in_nitrogen_Vapor11_Dtemperature' 'DiffusionCoeffient_ammonia_in_nitrogen_Vapor11_Dpressure'});
model.thermodynamics.feature('pp1').feature('singlephase6').set('SecondDerivatives', {});
model.thermodynamics.feature('pp1').feature('singlephase6').set('SecondDerivativeIndices', {});
model.thermodynamics.feature('pp1').feature('singlephase6').set('phase', 'Gas');
model.thermodynamics.feature('pp1').feature('singlephase6').set('comp_basis', 'mass');
model.thermodynamics.feature('pp1').feature('singlephase6').set('include_derivatives', 'yes');
model.thermodynamics.feature('pp1').feature.create('singlephase7', 'OnePhaseProperty');
model.thermodynamics.feature('pp1').feature('singlephase7').label('Diffusion coefficient at infinite dilution 6');
model.thermodynamics.feature('pp1').feature('singlephase7').set('IgnoreComposition', 'true');
model.thermodynamics.feature('pp1').feature('singlephase7').set('funcname', 'DiffusionCoeffient_nitrogen_oxide_in_nitrogen_Vapor12');
model.thermodynamics.feature('pp1').feature('singlephase7').set('property', 'BinaryDiffusionCoeffientAtInfiniteDilution[nitrogen oxide,nitrogen]');
model.thermodynamics.feature('pp1').feature('singlephase7').set('propertydescr', 'Diffusion coefficient at infinite dilution [nitrogen oxide,nitrogen]');
model.thermodynamics.feature('pp1').feature('singlephase7').set('unit', 'm^2/s');
model.thermodynamics.feature('pp1').feature('singlephase7').set('prop_basis', 'mass');
model.thermodynamics.feature('pp1').feature('singlephase7').set('compounds', {'ammonia' 'nitrogen' 'nitrogen oxide' 'oxygen' 'water'});
model.thermodynamics.feature('pp1').feature('singlephase7').set('args', {'temperature' 'K' 'Temperature'; 'pressure' 'Pa' 'Pressure'});
model.thermodynamics.feature('pp1').feature('singlephase7').set('plotargs', {'temperature' '298.15' '373.15'; 'pressure' '101325' '101325'});
model.thermodynamics.feature('pp1').feature('singlephase7').set('derivatives', {'DiffusionCoeffient_nitrogen_oxide_in_nitrogen_Vapor12_Dtemperature' 'DiffusionCoeffient_nitrogen_oxide_in_nitrogen_Vapor12_Dpressure'});
model.thermodynamics.feature('pp1').feature('singlephase7').set('SecondDerivatives', {});
model.thermodynamics.feature('pp1').feature('singlephase7').set('SecondDerivativeIndices', {});
model.thermodynamics.feature('pp1').feature('singlephase7').set('phase', 'Gas');
model.thermodynamics.feature('pp1').feature('singlephase7').set('comp_basis', 'mass');
model.thermodynamics.feature('pp1').feature('singlephase7').set('include_derivatives', 'yes');
model.thermodynamics.feature('pp1').feature.create('singlephase8', 'OnePhaseProperty');
model.thermodynamics.feature('pp1').feature('singlephase8').label('Diffusion coefficient at infinite dilution 7');
model.thermodynamics.feature('pp1').feature('singlephase8').set('IgnoreComposition', 'true');
model.thermodynamics.feature('pp1').feature('singlephase8').set('funcname', 'DiffusionCoeffient_oxygen_in_nitrogen_Vapor13');
model.thermodynamics.feature('pp1').feature('singlephase8').set('property', 'BinaryDiffusionCoeffientAtInfiniteDilution[oxygen,nitrogen]');
model.thermodynamics.feature('pp1').feature('singlephase8').set('propertydescr', 'Diffusion coefficient at infinite dilution [oxygen,nitrogen]');
model.thermodynamics.feature('pp1').feature('singlephase8').set('unit', 'm^2/s');
model.thermodynamics.feature('pp1').feature('singlephase8').set('prop_basis', 'mass');
model.thermodynamics.feature('pp1').feature('singlephase8').set('compounds', {'ammonia' 'nitrogen' 'nitrogen oxide' 'oxygen' 'water'});
model.thermodynamics.feature('pp1').feature('singlephase8').set('args', {'temperature' 'K' 'Temperature'; 'pressure' 'Pa' 'Pressure'});
model.thermodynamics.feature('pp1').feature('singlephase8').set('plotargs', {'temperature' '298.15' '373.15'; 'pressure' '101325' '101325'});
model.thermodynamics.feature('pp1').feature('singlephase8').set('derivatives', {'DiffusionCoeffient_oxygen_in_nitrogen_Vapor13_Dtemperature' 'DiffusionCoeffient_oxygen_in_nitrogen_Vapor13_Dpressure'});
model.thermodynamics.feature('pp1').feature('singlephase8').set('SecondDerivatives', {});
model.thermodynamics.feature('pp1').feature('singlephase8').set('SecondDerivativeIndices', {});
model.thermodynamics.feature('pp1').feature('singlephase8').set('phase', 'Gas');
model.thermodynamics.feature('pp1').feature('singlephase8').set('comp_basis', 'mass');
model.thermodynamics.feature('pp1').feature('singlephase8').set('include_derivatives', 'yes');
model.thermodynamics.feature('pp1').feature.create('singlephase9', 'OnePhaseProperty');
model.thermodynamics.feature('pp1').feature('singlephase9').label('Diffusion coefficient at infinite dilution 8');
model.thermodynamics.feature('pp1').feature('singlephase9').set('IgnoreComposition', 'true');
model.thermodynamics.feature('pp1').feature('singlephase9').set('funcname', 'DiffusionCoeffient_water_in_nitrogen_Vapor14');
model.thermodynamics.feature('pp1').feature('singlephase9').set('property', 'BinaryDiffusionCoeffientAtInfiniteDilution[water,nitrogen]');
model.thermodynamics.feature('pp1').feature('singlephase9').set('propertydescr', 'Diffusion coefficient at infinite dilution [water,nitrogen]');
model.thermodynamics.feature('pp1').feature('singlephase9').set('unit', 'm^2/s');
model.thermodynamics.feature('pp1').feature('singlephase9').set('prop_basis', 'mass');
model.thermodynamics.feature('pp1').feature('singlephase9').set('compounds', {'ammonia' 'nitrogen' 'nitrogen oxide' 'oxygen' 'water'});
model.thermodynamics.feature('pp1').feature('singlephase9').set('args', {'temperature' 'K' 'Temperature'; 'pressure' 'Pa' 'Pressure'});
model.thermodynamics.feature('pp1').feature('singlephase9').set('plotargs', {'temperature' '298.15' '373.15'; 'pressure' '101325' '101325'});
model.thermodynamics.feature('pp1').feature('singlephase9').set('derivatives', {'DiffusionCoeffient_water_in_nitrogen_Vapor14_Dtemperature' 'DiffusionCoeffient_water_in_nitrogen_Vapor14_Dpressure'});
model.thermodynamics.feature('pp1').feature('singlephase9').set('SecondDerivatives', {});
model.thermodynamics.feature('pp1').feature('singlephase9').set('SecondDerivativeIndices', {});
model.thermodynamics.feature('pp1').feature('singlephase9').set('phase', 'Gas');
model.thermodynamics.feature('pp1').feature('singlephase9').set('comp_basis', 'mass');
model.thermodynamics.feature('pp1').feature('singlephase9').set('include_derivatives', 'yes');
model.thermodynamics.feature('pp1').feature('singlephase1').tag('mat_singlephase1');
model.thermodynamics.feature('pp1').feature('mat_singlephase1').set('funcname', 'Densitypp1');
model.thermodynamics.feature('pp1').feature('singlephase2').tag('mat_singlephase2');
model.thermodynamics.feature('pp1').feature('mat_singlephase2').set('funcname', 'HeatCapacityCppp1');
model.thermodynamics.feature('pp1').feature('singlephase3').tag('mat_singlephase3');
model.thermodynamics.feature('pp1').feature('mat_singlephase3').set('funcname', 'HeatCapacityRatioCpCvpp1');
model.thermodynamics.feature('pp1').feature('singlephase4').tag('mat_singlephase4');
model.thermodynamics.feature('pp1').feature('mat_singlephase4').set('funcname', 'ThermalConductivitypp1');
model.thermodynamics.feature('pp1').feature('singlephase5').tag('mat_singlephase5');
model.thermodynamics.feature('pp1').feature('mat_singlephase5').set('funcname', 'Viscositypp1');
model.thermodynamics.feature('pp1').feature('singlephase6').tag('mat_singlephase6');
model.thermodynamics.feature('pp1').feature('mat_singlephase6').set('funcname', 'DiffusionCoefficient_ammonia_nitrogen_pp1');
model.thermodynamics.feature('pp1').feature('singlephase7').tag('mat_singlephase7');
model.thermodynamics.feature('pp1').feature('mat_singlephase7').set('funcname', 'DiffusionCoefficient_nitrogen_oxide_nitrogen_pp1');
model.thermodynamics.feature('pp1').feature('singlephase8').tag('mat_singlephase8');
model.thermodynamics.feature('pp1').feature('mat_singlephase8').set('funcname', 'DiffusionCoefficient_oxygen_nitrogen_pp1');
model.thermodynamics.feature('pp1').feature('singlephase9').tag('mat_singlephase9');
model.thermodynamics.feature('pp1').feature('mat_singlephase9').set('funcname', 'DiffusionCoefficient_water_nitrogen_pp1');
model.thermodynamics.createMaterial('Global', 'pp1', 'Gas', {'ammonia' 'nitrogen' 'nitrogen oxide' 'oxygen' 'water'}, {'0' '1' '0' '0' '0'}, {'density' 'heatcapacitycp' 'heatcapacityratiocpcv' 'thermalconductivity' 'viscosity' 'binarydiffusioncoeffientatinfinitedilution'}, {'density' 'Densitypp1';  ...
'heatcapacitycp' 'HeatCapacityCppp1';  ...
'heatcapacityratiocpcv' 'HeatCapacityRatioCpCvpp1';  ...
'thermalconductivity' 'ThermalConductivitypp1';  ...
'viscosity' 'Viscositypp1';  ...
'binarydiffusioncoeffientatinfinitedilution[ammonia,nitrogen]' 'DiffusionCoefficient_ammonia_nitrogen_pp1';  ...
'binarydiffusioncoeffientatinfinitedilution[nitrogen oxide,nitrogen]' 'DiffusionCoefficient_nitrogen_oxide_nitrogen_pp1';  ...
'binarydiffusioncoeffientatinfinitedilution[oxygen,nitrogen]' 'DiffusionCoefficient_oxygen_nitrogen_pp1';  ...
'binarydiffusioncoeffientatinfinitedilution[water,nitrogen]' 'DiffusionCoefficient_water_nitrogen_pp1'}, 'Identical', {'0' '273' '673' '20' '101325' '201325' '15';  ...
'60' '273' '373' '20' '101325' '201325' '15';  ...
'68' '273' '373' '20' '101325' '201325' '15';  ...
'48' '273' '373' '20' '101325' '201325' '15';  ...
'52' '273' '373' '20' '101325' '201325' '15';  ...
'76' '273' '373' '20' '101325' '201325' '15'}, {'mass' 'mass'});

model.material('pp1mat1').label('Gas: Nitrogen');
model.material.create('mat1', 'Common', '');
model.material('mat1').propertyGroup('def').set('density', '');
model.material('mat1').propertyGroup('def').set('heatcapacity', '');
model.material('mat1').propertyGroup('def').set('thermalconductivity', '');
model.material('mat1').propertyGroup('def').set('density', {'2970[kg/m^3]'});
model.material('mat1').propertyGroup('def').set('heatcapacity', {'975[J/kg/K]'});
model.material('mat1').propertyGroup('def').set('thermalconductivity', {'35[W/m/K]'});
model.material('mat1').label('Solid: Monolith Material');
model.material.create('pmat1', 'PorousMedia', 'comp2');
model.material('pmat1').selection.named('geom1_sel2');
model.material('pmat1').feature.create('fluid1', 'Fluid', 'comp2');
model.material('pmat1').feature.create('solid1', 'Solid', 'comp2');
model.material('pmat1').feature('solid1').set('link', 'mat1');
model.material('pmat1').feature('solid1').set('vfrac', '1-por');
model.material.create('matlnk1', 'Link', 'comp2');
model.material('matlnk1').selection.named('geom1_sel1');
model.material('matlnk1').set('link', 'mat1');
model.material('matlnk1').label('Walls');

model.physics('tds').selection.named('geom1_sel2');
model.physics('tds').feature('porous1').feature('fluid1').set('DiffusionCoefficientSource', 'mat');
model.physics('tds').feature('porous1').feature('fluid1').set('DF_cH2O', {'pp1mat1.df4.D11' '0' '0' '0' '0' '0' '0' '0' '0'});
model.physics('tds').feature('porous1').feature('fluid1').set('DF_cNH3', {'pp1mat1.df1.D11' '0' '0' '0' '0' '0' '0' '0' '0'});
model.physics('tds').feature('porous1').feature('fluid1').set('DF_cNO', {'pp1mat1.df2.D11' '0' '0' '0' '0' '0' '0' '0' '0'});
model.physics('tds').feature('porous1').feature('fluid1').set('DF_cO2', {'pp1mat1.df3.D11' '0' '0' '0' '0' '0' '0' '0' '0'});
model.physics('tds').feature('porous1').feature('fluid1').set('FluidDiffusivityModelType', 'UserDefined');
model.physics('tds').feature('init1').setIndex('initc', 0, 0);
model.physics('tds').feature('init1').setIndex('initc', 0, 1);
model.physics('tds').feature('init1').setIndex('initc', 0, 2);
model.physics('tds').feature('init1').setIndex('initc', 0, 3);
model.physics('tds').feature('in1').selection.named('geom1_sel3');
model.physics('tds').feature('out1').selection.named('geom1_sel4');
model.physics('ht1').feature('porous1').feature('fluid1').set('k_mat', 'from_mat');
model.physics('ht1').feature('porous1').feature('fluid1').set('rho_mat', 'from_mat');
model.physics('ht1').feature('porous1').feature('fluid1').set('Cp_mat', 'from_mat');
model.physics('ht1').feature('porous1').feature('fluid1').set('gamma_not_IG_mat', 'from_mat');
model.physics('ht1').feature('porous1').feature('pm1').set('porousMatrixPropertiesType', 'solidPhaseProperties');
model.physics('ht1').feature('porous1').feature('pm1').set('k_sp_mat', 'userdef');
model.physics('ht1').feature('porous1').feature('pm1').set('k_sp', {'0.13[W/m/K]' '0' '0' '0' '0.25[W/m/K]' '0' '0' '0' '0.25[W/m/K]'});
model.physics('ht1').feature('init1').set('Tinit', 'T_in');
model.physics('ht1').feature('hs1').selection.named('geom1_sel2');
model.physics('ht1').feature('temp1').selection.named('geom1_sel6');
model.physics('ht1').feature('ofl1').selection.named('geom1_sel4');
model.physics('ht1').create('solid1', 'SolidHeatTransferModel', 3);
model.physics('ht1').feature('solid1').selection.named('geom1_sel1');
model.physics('ht1').create('hf1', 'HeatFluxBoundary', 2);
model.physics('ht1').feature('hf1').selection.named('geom1_sel8');
model.physics('ht1').feature('hf1').set('HeatFluxType', 'ConvectiveHeatFlux');
model.physics('ht1').feature('hf1').set('h', '10[W/(m^2*K)]');
model.physics('ht1').feature('hf1').set('Text', 'T_amb');
model.physics('ht1').create('hf2', 'HeatFluxBoundary', 2);
model.physics('ht1').feature('hf2').selection.named('geom1_sel7');
model.physics('ht1').feature('hf2').set('HeatFluxType', 'ConvectiveHeatFlux');
model.physics('ht1').feature('hf2').set('h', 1);
model.physics('ht1').feature('hf2').set('Text', 'T_amb');
model.physics('ht1').create('sym1', 'Symmetry', 2);
model.physics('ht1').feature('sym1').selection.named('geom1_sel5');
model.physics('ht1').create('ifl1', 'Inflow', 2);
model.physics('ht1').feature('ifl1').set('Tustr', 'T_in');
model.physics('ht1').feature('ifl1').selection.named('geom1_sel3');
model.physics('dl1').selection.named('geom1_sel2');
model.physics('dl1').feature('porous1').feature('pm1').set('kappa_mat', 'userdef');
model.physics('dl1').feature('porous1').feature('pm1').set('kappa', {'3.3e-7[m^2]' '0' '0' '0' '0' '0' '0' '0' '0'});
model.physics('dl1').feature('inl1').selection.named('geom1_sel3');
model.physics('dl1').feature('inl1').set('BoundaryCondition', 'MassFlow');
model.physics('dl1').feature('inl1').set('M0', 'M0_in');
model.physics('dl1').feature('out1').selection.named('geom1_sel4');
model.physics('dl1').feature('out1').set('BoundaryCondition', 'Pressure');

model.mesh('mesh1').create('ftri1', 'FreeTri');
model.mesh('mesh1').feature('ftri1').selection.named('geom1_unisel1');
model.mesh('mesh1').feature('ftri1').create('size1', 'Size');
model.mesh('mesh1').feature('ftri1').feature('size1').selection.named('geom1_sel6');
model.mesh('mesh1').feature('ftri1').feature('size1').set('custom', true);
model.mesh('mesh1').feature('ftri1').feature('size1').set('hmaxactive', true);
model.mesh('mesh1').feature('ftri1').feature('size1').set('hmax', 2.2);
model.mesh('mesh1').feature('ftri1').feature('size1').set('hnarrowactive', true);
model.mesh('mesh1').feature('ftri1').feature('size1').set('hnarrow', 0.85);
model.mesh('mesh1').run;
model.mesh('mesh1').feature('ftri1').create('size2', 'Size');
model.mesh('mesh1').feature('ftri1').feature('size2').selection.geom('geom1', 1);
model.mesh('mesh1').feature('ftri1').feature('size2').selection.set([5 17]);
model.mesh('mesh1').feature('ftri1').feature('size2').set('custom', true);
model.mesh('mesh1').feature('ftri1').feature('size2').set('hmaxactive', true);
model.mesh('mesh1').feature('ftri1').feature('size2').set('hmax', 5);
model.mesh('mesh1').run;
model.mesh('mesh1').create('swe1', 'Sweep');
model.mesh('mesh1').feature('swe1').create('dis1', 'Distribution');
model.mesh('mesh1').feature('swe1').feature('dis1').set('numelem', 50);
model.mesh('mesh1').run;

model.study('std2').setGenPlots(false);

model.sol.create('sol36');

model.mesh('mesh1').stat.selection.geom(3);
model.mesh('mesh1').stat.selection.set([2 3 4 5 6]);
model.mesh('mesh1').stat.selection.geom(3);
model.mesh('mesh1').stat.selection.set([2 3 4 5 6]);

model.sol('sol36').study('std2');

model.study('std2').feature('stat').set('notlistsolnum', 1);
model.study('std2').feature('stat').set('notsolnum', 'auto');
model.study('std2').feature('stat').set('listsolnum', 1);
model.study('std2').feature('stat').set('solnum', 'auto');

model.sol('sol36').create('st1', 'StudyStep');
model.sol('sol36').feature('st1').set('study', 'std2');
model.sol('sol36').feature('st1').set('studystep', 'stat');
model.sol('sol36').create('v1', 'Variables');
model.sol('sol36').feature('v1').set('control', 'stat');
model.sol('sol36').create('s1', 'Stationary');
model.sol('sol36').feature('s1').set('stol', 0.001);
model.sol('sol36').feature('s1').feature('aDef').set('cachepattern', true);
model.sol('sol36').feature('s1').create('se1', 'Segregated');
model.sol('sol36').feature('s1').feature('se1').feature.remove('ssDef');
model.sol('sol36').feature('s1').feature('se1').create('ss1', 'SegregatedStep');
model.sol('sol36').feature('s1').feature('se1').feature('ss1').set('segvar', {'comp2_p' 'comp2_dl_inl1_p0'});
model.sol('sol36').feature('s1').create('d1', 'Direct');
model.sol('sol36').feature('s1').feature('d1').set('linsolver', 'pardiso');
model.sol('sol36').feature('s1').feature('d1').set('pivotperturb', 1.0E-13);
model.sol('sol36').feature('s1').feature('d1').label('Direct, pressure (dl1)');
model.sol('sol36').feature('s1').feature('se1').feature('ss1').set('linsolver', 'd1');
model.sol('sol36').feature('s1').feature('se1').feature('ss1').label('Pressure p');
model.sol('sol36').feature('s1').feature('se1').create('ss2', 'SegregatedStep');
model.sol('sol36').feature('s1').feature('se1').feature('ss2').set('segvar', {'comp2_T'});
model.sol('sol36').feature('s1').feature('se1').feature('ss2').set('subdamp', 0.8);
model.sol('sol36').feature('s1').create('d2', 'Direct');
model.sol('sol36').feature('s1').feature('d2').set('linsolver', 'pardiso');
model.sol('sol36').feature('s1').feature('d2').set('pivotperturb', 1.0E-13);
model.sol('sol36').feature('s1').feature('d2').label('Direct, heat transfer variables (ht1)');
model.sol('sol36').feature('s1').feature('se1').feature('ss2').set('linsolver', 'd2');
model.sol('sol36').feature('s1').feature('se1').feature('ss2').label('Temperature');
model.sol('sol36').feature('s1').feature('se1').create('ss3', 'SegregatedStep');
model.sol('sol36').feature('s1').feature('se1').feature('ss3').set('segvar', {'comp2_cH2O' 'comp2_cNH3' 'comp2_cNO' 'comp2_cO2'});
model.sol('sol36').feature('s1').feature('se1').feature('ss3').set('subdamp', 0.35);
model.sol('sol36').feature('s1').feature('se1').feature('ss3').set('subtermconst', 'itertol');
model.sol('sol36').feature('s1').feature('se1').feature('ss3').set('subntolfact', 1);
model.sol('sol36').feature('s1').feature('se1').feature('ss3').set('subiter', 3);
model.sol('sol36').feature('s1').create('d3', 'Direct');
model.sol('sol36').feature('s1').feature('d3').set('linsolver', 'pardiso');
model.sol('sol36').feature('s1').feature('d3').set('pivotperturb', 1.0E-13);
model.sol('sol36').feature('s1').feature('d3').label('Direct, concentrations (tds)');
model.sol('sol36').feature('s1').feature('se1').feature('ss3').set('linsolver', 'd3');
model.sol('sol36').feature('s1').feature('se1').feature('ss3').label('Concentrations');
model.sol('sol36').feature('s1').feature('se1').create('ll1', 'LowerLimit');
model.sol('sol36').feature('s1').feature('se1').feature('ll1').set('lowerlimit', 'comp2.T 0 ');
model.sol('sol36').feature('s1').create('i1', 'Iterative');
model.sol('sol36').feature('s1').feature('i1').set('linsolver', 'gmres');
model.sol('sol36').feature('s1').feature('i1').set('prefuntype', 'left');
model.sol('sol36').feature('s1').feature('i1').set('itrestart', 50);
model.sol('sol36').feature('s1').feature('i1').set('rhob', 400);
model.sol('sol36').feature('s1').feature('i1').set('maxlinit', 1000);
model.sol('sol36').feature('s1').feature('i1').set('nlinnormuse', 'on');
model.sol('sol36').feature('s1').feature('i1').label('AMG, pressure (dl1)');
model.sol('sol36').feature('s1').feature('i1').create('mg1', 'Multigrid');
model.sol('sol36').feature('s1').feature('i1').feature('mg1').set('prefun', 'saamg');
model.sol('sol36').feature('s1').feature('i1').feature('mg1').set('mgcycle', 'v');
model.sol('sol36').feature('s1').feature('i1').feature('mg1').set('maxcoarsedof', 50000);
model.sol('sol36').feature('s1').feature('i1').feature('mg1').set('strconn', 0.01);
model.sol('sol36').feature('s1').feature('i1').feature('mg1').set('nullspace', 'constant');
model.sol('sol36').feature('s1').feature('i1').feature('mg1').set('usesmooth', false);
model.sol('sol36').feature('s1').feature('i1').feature('mg1').set('saamgcompwise', false);
model.sol('sol36').feature('s1').feature('i1').feature('mg1').set('loweramg', true);
model.sol('sol36').feature('s1').feature('i1').feature('mg1').set('compactaggregation', false);
model.sol('sol36').feature('s1').feature('i1').feature('mg1').feature('pr').create('sl1', 'SORLine');
model.sol('sol36').feature('s1').feature('i1').feature('mg1').feature('pr').feature('sl1').set('linesweeptype', 'ssor');
model.sol('sol36').feature('s1').feature('i1').feature('mg1').feature('pr').feature('sl1').set('iter', 1);
model.sol('sol36').feature('s1').feature('i1').feature('mg1').feature('pr').feature('sl1').set('linerelax', 0.7);
model.sol('sol36').feature('s1').feature('i1').feature('mg1').feature('pr').feature('sl1').set('linealgorithm', 'mesh');
model.sol('sol36').feature('s1').feature('i1').feature('mg1').feature('pr').feature('sl1').set('linemethod', 'coupled');
model.sol('sol36').feature('s1').feature('i1').feature('mg1').feature('pr').feature('sl1').set('seconditer', 1);
model.sol('sol36').feature('s1').feature('i1').feature('mg1').feature('pr').feature('sl1').set('relax', 0.5);
model.sol('sol36').feature('s1').feature('i1').feature('mg1').feature('po').create('sl1', 'SORLine');
model.sol('sol36').feature('s1').feature('i1').feature('mg1').feature('po').feature('sl1').set('linesweeptype', 'ssor');
model.sol('sol36').feature('s1').feature('i1').feature('mg1').feature('po').feature('sl1').set('iter', 1);
model.sol('sol36').feature('s1').feature('i1').feature('mg1').feature('po').feature('sl1').set('linerelax', 0.7);
model.sol('sol36').feature('s1').feature('i1').feature('mg1').feature('po').feature('sl1').set('linealgorithm', 'mesh');
model.sol('sol36').feature('s1').feature('i1').feature('mg1').feature('po').feature('sl1').set('linemethod', 'coupled');
model.sol('sol36').feature('s1').feature('i1').feature('mg1').feature('po').feature('sl1').set('seconditer', 1);
model.sol('sol36').feature('s1').feature('i1').feature('mg1').feature('po').feature('sl1').set('relax', 0.5);
model.sol('sol36').feature('s1').feature('i1').feature('mg1').feature('cs').create('d1', 'Direct');
model.sol('sol36').feature('s1').feature('i1').feature('mg1').feature('cs').feature('d1').set('linsolver', 'pardiso');
model.sol('sol36').feature('s1').feature('i1').feature('mg1').feature('cs').feature('d1').set('pivotperturb', 1.0E-13);
model.sol('sol36').feature('s1').create('i2', 'Iterative');
model.sol('sol36').feature('s1').feature('i2').set('linsolver', 'gmres');
model.sol('sol36').feature('s1').feature('i2').set('prefuntype', 'left');
model.sol('sol36').feature('s1').feature('i2').set('itrestart', 50);
model.sol('sol36').feature('s1').feature('i2').set('rhob', 20);
model.sol('sol36').feature('s1').feature('i2').set('maxlinit', 10000);
model.sol('sol36').feature('s1').feature('i2').set('nlinnormuse', 'on');
model.sol('sol36').feature('s1').feature('i2').label('AMG, heat transfer variables (ht1)');
model.sol('sol36').feature('s1').feature('i2').create('mg1', 'Multigrid');
model.sol('sol36').feature('s1').feature('i2').feature('mg1').set('prefun', 'saamg');
model.sol('sol36').feature('s1').feature('i2').feature('mg1').set('mgcycle', 'v');
model.sol('sol36').feature('s1').feature('i2').feature('mg1').set('maxcoarsedof', 50000);
model.sol('sol36').feature('s1').feature('i2').feature('mg1').set('strconn', 0.01);
model.sol('sol36').feature('s1').feature('i2').feature('mg1').set('nullspace', 'constant');
model.sol('sol36').feature('s1').feature('i2').feature('mg1').set('usesmooth', false);
model.sol('sol36').feature('s1').feature('i2').feature('mg1').set('saamgcompwise', true);
model.sol('sol36').feature('s1').feature('i2').feature('mg1').set('loweramg', true);
model.sol('sol36').feature('s1').feature('i2').feature('mg1').feature('pr').create('so1', 'SOR');
model.sol('sol36').feature('s1').feature('i2').feature('mg1').feature('pr').feature('so1').set('iter', 2);
model.sol('sol36').feature('s1').feature('i2').feature('mg1').feature('pr').feature('so1').set('relax', 0.9);
model.sol('sol36').feature('s1').feature('i2').feature('mg1').feature('po').create('so1', 'SOR');
model.sol('sol36').feature('s1').feature('i2').feature('mg1').feature('po').feature('so1').set('iter', 2);
model.sol('sol36').feature('s1').feature('i2').feature('mg1').feature('po').feature('so1').set('relax', 0.9);
model.sol('sol36').feature('s1').feature('i2').feature('mg1').feature('cs').create('d1', 'Direct');
model.sol('sol36').feature('s1').feature('i2').feature('mg1').feature('cs').feature('d1').set('linsolver', 'pardiso');
model.sol('sol36').feature('s1').feature('i2').feature('mg1').feature('cs').feature('d1').set('pivotperturb', 1.0E-13);
model.sol('sol36').feature('s1').create('i3', 'Iterative');
model.sol('sol36').feature('s1').feature('i3').set('linsolver', 'gmres');
model.sol('sol36').feature('s1').feature('i3').set('prefuntype', 'left');
model.sol('sol36').feature('s1').feature('i3').set('itrestart', 50);
model.sol('sol36').feature('s1').feature('i3').set('rhob', 400);
model.sol('sol36').feature('s1').feature('i3').set('maxlinit', 1000);
model.sol('sol36').feature('s1').feature('i3').set('nlinnormuse', 'on');
model.sol('sol36').feature('s1').feature('i3').label('AMG, concentrations (tds)');
model.sol('sol36').feature('s1').feature('i3').create('mg1', 'Multigrid');
model.sol('sol36').feature('s1').feature('i3').feature('mg1').set('prefun', 'saamg');
model.sol('sol36').feature('s1').feature('i3').feature('mg1').set('mgcycle', 'v');
model.sol('sol36').feature('s1').feature('i3').feature('mg1').set('maxcoarsedof', 50000);
model.sol('sol36').feature('s1').feature('i3').feature('mg1').set('strconn', 0.01);
model.sol('sol36').feature('s1').feature('i3').feature('mg1').set('nullspace', 'constant');
model.sol('sol36').feature('s1').feature('i3').feature('mg1').set('usesmooth', false);
model.sol('sol36').feature('s1').feature('i3').feature('mg1').set('saamgcompwise', true);
model.sol('sol36').feature('s1').feature('i3').feature('mg1').set('loweramg', true);
model.sol('sol36').feature('s1').feature('i3').feature('mg1').set('compactaggregation', false);
model.sol('sol36').feature('s1').feature('i3').feature('mg1').feature('pr').create('sl1', 'SORLine');
model.sol('sol36').feature('s1').feature('i3').feature('mg1').feature('pr').feature('sl1').set('linesweeptype', 'ssor');
model.sol('sol36').feature('s1').feature('i3').feature('mg1').feature('pr').feature('sl1').set('iter', 1);
model.sol('sol36').feature('s1').feature('i3').feature('mg1').feature('pr').feature('sl1').set('linerelax', 0.7);
model.sol('sol36').feature('s1').feature('i3').feature('mg1').feature('pr').feature('sl1').set('linealgorithm', 'mesh');
model.sol('sol36').feature('s1').feature('i3').feature('mg1').feature('pr').feature('sl1').set('linemethod', 'coupled');
model.sol('sol36').feature('s1').feature('i3').feature('mg1').feature('pr').feature('sl1').set('seconditer', 1);
model.sol('sol36').feature('s1').feature('i3').feature('mg1').feature('pr').feature('sl1').set('relax', 0.5);
model.sol('sol36').feature('s1').feature('i3').feature('mg1').feature('po').create('sl1', 'SORLine');
model.sol('sol36').feature('s1').feature('i3').feature('mg1').feature('po').feature('sl1').set('linesweeptype', 'ssor');
model.sol('sol36').feature('s1').feature('i3').feature('mg1').feature('po').feature('sl1').set('iter', 1);
model.sol('sol36').feature('s1').feature('i3').feature('mg1').feature('po').feature('sl1').set('linerelax', 0.7);
model.sol('sol36').feature('s1').feature('i3').feature('mg1').feature('po').feature('sl1').set('linealgorithm', 'mesh');
model.sol('sol36').feature('s1').feature('i3').feature('mg1').feature('po').feature('sl1').set('linemethod', 'coupled');
model.sol('sol36').feature('s1').feature('i3').feature('mg1').feature('po').feature('sl1').set('seconditer', 1);
model.sol('sol36').feature('s1').feature('i3').feature('mg1').feature('po').feature('sl1').set('relax', 0.5);
model.sol('sol36').feature('s1').feature('i3').feature('mg1').feature('cs').create('d1', 'Direct');
model.sol('sol36').feature('s1').feature('i3').feature('mg1').feature('cs').feature('d1').set('linsolver', 'pardiso');
model.sol('sol36').feature('s1').feature('i3').feature('mg1').feature('cs').feature('d1').set('pivotperturb', 1.0E-13);
model.sol('sol36').feature('s1').feature.remove('fcDef');
model.sol('sol36').attach('std2');
model.sol('sol36').runAll;

model.result.create('pg6', 'PlotGroup3D');
model.result('pg6').run;
model.result('pg6').label('Conversion 3D Model');
model.result('pg6').set('titletype', 'none');
model.result('pg6').set('legendpos', 'left');
model.result('pg6').create('iso1', 'Isosurface');
model.result('pg6').feature('iso1').set('expr', '(F_NO_in/vrate-cNO)/(F_NO_in/vrate)');
model.result('pg6').feature('iso1').set('number', 20);
model.result('pg6').run;
model.result.create('pg7', 'PlotGroup3D');
model.result('pg7').run;
model.result('pg7').label('Temperature 3D Model');
model.result('pg7').set('showlegendsunit', true);
model.result('pg7').set('legendpos', 'left');
model.result('pg7').create('slc1', 'Slice');
model.result('pg7').feature('slc1').set('expr', 'T');
model.result('pg7').feature('slc1').set('quickxnumber', 10);
model.result('pg7').feature('slc1').set('titletype', 'none');
model.result('pg7').run;
model.result.dataset.create('sec1', 'Sector3D');
model.result.dataset('sec1').label('Monolith');
model.result.dataset('sec1').setIndex('genpoints', 1, 1, 0);
model.result.dataset('sec1').setIndex('genpoints', 0, 1, 2);
model.result.dataset('sec1').set('sectors', 8);
model.result.dataset('sec1').set('include', 'manual');
model.result.dataset('sec1').set('trans', 'rotrefl');
model.result.dataset('sec1').set('reflaxis', [0 0 1]);
model.result.dataset('sec1').set('hasspacevars', true);
model.result.dataset.duplicate('sec2', 'sec1');
model.result.dataset('sec2').label('Temperature sector');
model.result.dataset('sec2').set('startsector', 2);
model.result.dataset('sec2').set('sectorsinclude', 1);
model.result.create('pg8', 'PlotGroup3D');
model.result('pg8').run;
model.result('pg8').label('Monolith view');
model.result('pg8').set('data', 'sec1');
model.result('pg8').set('edges', false);
model.result('pg8').set('showlegendsunit', true);
model.result('pg8').create('slc1', 'Slice');
model.result('pg8').feature('slc1').label('Selectivity');
model.result('pg8').feature('slc1').set('expr', 'S');
model.result('pg8').feature('slc1').set('descractive', true);
model.result('pg8').feature('slc1').set('quickxmethod', 'coord');
model.result('pg8').feature('slc1').set('quickx', 'range(0,(L-0)/4,L)');
model.result('pg8').run;
model.result('pg8').feature.duplicate('slc2', 'slc1');
model.result('pg8').run;
model.result('pg8').feature('slc2').label('Temperature');
model.result('pg8').feature('slc2').set('data', 'sec2');
model.result('pg8').feature('slc2').set('expr', 'T');
model.result('pg8').feature('slc2').set('descr', 'Temperature');
model.result('pg8').feature('slc2').set('colortable', 'HeatCameraLight');
model.result('pg8').run;
model.result('pg8').feature('slc1').set('smooth', 'none');
model.result('pg8').feature('slc1').create('filt1', 'Filter');
model.result('pg8').run;
model.result('pg8').feature('slc1').feature('filt1').set('expr', 'sec1number!=2');
model.result('pg8').run;
model.result.dataset.create('cpl1', 'CutPlane');
model.result.dataset('cpl1').set('data', 'sec1');
model.result.dataset('cpl1').set('quickplane', 'yx');
model.result.dataset('cpl1').set('quickz', 2);
model.result('pg8').run;
model.result('pg8').create('arws1', 'ArrowSurface');
model.result('pg8').feature('arws1').set('data', 'cpl1');
model.result('pg8').feature('arws1').set('expr', {'dl.u' 'dl.v' 'dl.w'});
model.result('pg8').feature('arws1').set('descr', 'Darcy''s velocity field');
model.result('pg8').feature('arws1').set('arrowtype', 'cone');
model.result('pg8').feature('arws1').set('scaleactive', true);
model.result('pg8').feature('arws1').set('scale', 80);
model.result('pg8').run;
model.result('pg8').run;
model.result('pg8').set('titletype', 'none');
model.result.numerical.create('av1', 'AvSurface');
model.result.numerical('av1').set('intvolume', true);
model.result.numerical('av1').selection.named('geom1_sel4');
model.result.numerical('av1').set('expr', {});
model.result.numerical('av1').set('descr', {});
model.result.numerical('av1').setIndex('expr', '(F_NO_in/vrate-chem.c_NO)/(F_NO_in/vrate)', 0);
model.result.numerical('av1').setIndex('unit', 1, 0);
model.result.numerical('av1').setIndex('descr', 'Conversion', 0);
model.result.table.create('tbl1', 'Table');
model.result.table('tbl1').comments('Surface Average 1');
model.result.numerical('av1').set('table', 'tbl1');
model.result.numerical('av1').setResult;
model.result.numerical.create('max1', 'MaxVolume');
model.result.numerical('max1').selection.all;
model.result.table.create('tbl2', 'Table');
model.result.table('tbl2').comments('Volume Maximum 1');
model.result.numerical('max1').set('table', 'tbl2');
model.result.numerical('max1').setResult;
model.result('pg8').run;

model.title('NOx Reduction in a Monolithic Reactor');

model.description('NO reduction occurs as flue gases pass through the channels of a monolithic reactor in the exhaust system of a car. This example investigates a full 3D model geometry of the reactor, and the model includes mass transport, heat transfer and fluid flow.');

model.label('monolith_3d.mph');

model.result('pg8').run;

model.physics.create('solid', 'SolidMechanics', 'geom1');
model.physics('solid').model('comp2');

model.study('std1').feature('spf').setSolveFor('/physics/solid', false);
model.study('std2').feature('stat').setSolveFor('/physics/solid', false);
model.study.create('std3');
model.study('std3').create('stat', 'Stationary');
model.study('std3').feature('stat').setSolveFor('/physics/re', true);
model.study('std3').feature('stat').setSolveFor('/physics/chem1', true);
model.study('std3').feature('stat').setSolveFor('/physics/tds', true);
model.study('std3').feature('stat').setSolveFor('/physics/ht1', true);
model.study('std3').feature('stat').setSolveFor('/physics/dl1', true);
model.study('std3').feature('stat').setSolveFor('/physics/solid', true);

model.physics('solid').create('lemm2', 'LinearElasticModel', 3);
model.physics('solid').feature('lemm2').selection.named('geom1_sel1');
model.physics('solid').feature('lemm2').set('E_mat', 'userdef');
model.physics('solid').feature('lemm2').set('E', '1.5e9');
model.physics('solid').feature('lemm2').set('nu_mat', 'userdef');
model.physics('solid').feature('lemm2').set('nu', 0.2);
model.physics('solid').feature('lemm2').create('te1', 'ThermalExpansion', 3);
model.physics('solid').feature('lemm2').feature('te1').set('alpha_mat', 'userdef');
model.physics('solid').feature('lemm2').feature('te1').set('alpha', {'2.7e-6' '0' '0' '0' '2.7e-6' '0' '0' '0' '2.7e-6'});
model.physics('solid').feature('lemm1').set('SolidModel', 'Orthotropic');
model.physics('solid').feature('lemm1').set('Evector_mat', 'userdef');
model.physics('solid').feature('lemm1').set('Evector', {'8.5e10' '4.7e10' '4.7e10'});
model.physics('solid').feature('lemm1').set('nuvector_mat', 'userdef');
model.physics('solid').feature('lemm1').set('nuvector', [0.19 0.021 0.021]);
model.physics('solid').feature('lemm1').set('Gvector_mat', 'userdef');
model.physics('solid').feature('lemm1').set('Gvector', {'3.5E10' '1.3e10' '3.5E10'});
model.physics('solid').feature('lemm1').create('te1', 'ThermalExpansion', 3);
model.physics('solid').feature('lemm1').feature('te1').set('alpha_mat', 'userdef');
model.physics('solid').feature('lemm1').feature('te1').set('alpha', {'4e-6' '0' '0' '0' '4e-6' '0' '0' '0' '4e-6'});
model.physics('solid').create('roll1', 'Roller', 2);
model.physics('solid').feature('roll1').selection.set([1 4 9 13 19 23]);
model.physics('solid').create('sym1', 'SymmetrySolid', 2);
model.physics('solid').feature('sym1').selection.named('geom1_sel5');

model.study('std3').setGenPlots(false);
model.study('std3').feature('stat').setEntry('activate', 'chem1', false);
model.study('std3').feature('stat').setEntry('activate', 'tds', false);
model.study('std3').feature('stat').setEntry('activate', 'ht1', false);
model.study('std3').feature('stat').setEntry('activate', 'dl1', false);
model.study('std3').feature('stat').set('usesol', true);
model.study('std3').feature('stat').set('notsolmethod', 'sol');
model.study('std3').feature('stat').set('notstudy', 'std2');

model.sol.create('sol37');
model.sol('sol37').study('std3');
model.sol('sol37').create('st1', 'StudyStep');
model.sol('sol37').feature('st1').set('study', 'std3');
model.sol('sol37').feature('st1').set('studystep', 'stat');
model.sol('sol37').create('v1', 'Variables');
model.sol('sol37').feature('v1').set('control', 'stat');
model.sol('sol37').create('s1', 'Stationary');
model.sol('sol37').feature('s1').feature('aDef').set('cachepattern', true);
model.sol('sol37').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol37').feature('s1').feature('fc1').set('termonres', 'auto');
model.sol('sol37').feature('s1').feature('fc1').set('reserrfact', 1000);
model.sol('sol37').feature('s1').create('d1', 'Direct');
model.sol('sol37').feature('s1').feature('d1').set('linsolver', 'pardiso');
model.sol('sol37').feature('s1').feature('d1').set('pivotperturb', 1.0E-9);
model.sol('sol37').feature('s1').feature('d1').label('Suggested Direct Solver (solid)');
model.sol('sol37').feature('s1').create('i1', 'Iterative');
model.sol('sol37').feature('s1').feature('i1').set('linsolver', 'gmres');
model.sol('sol37').feature('s1').feature('i1').set('rhob', 400);
model.sol('sol37').feature('s1').feature('i1').set('nlinnormuse', true);
model.sol('sol37').feature('s1').feature('i1').label('Suggested Iterative Solver (solid)');
model.sol('sol37').feature('s1').feature('i1').create('mg1', 'Multigrid');
model.sol('sol37').feature('s1').feature('i1').feature('mg1').set('prefun', 'gmg');
model.sol('sol37').feature('s1').feature('i1').feature('mg1').feature('pr').create('so1', 'SOR');
model.sol('sol37').feature('s1').feature('i1').feature('mg1').feature('pr').feature('so1').set('relax', 0.8);
model.sol('sol37').feature('s1').feature('i1').feature('mg1').feature('po').create('so1', 'SOR');
model.sol('sol37').feature('s1').feature('i1').feature('mg1').feature('po').feature('so1').set('relax', 0.8);
model.sol('sol37').feature('s1').feature('i1').feature('mg1').feature('cs').create('d1', 'Direct');
model.sol('sol37').feature('s1').feature('i1').feature('mg1').feature('cs').feature('d1').set('linsolver', 'pardiso');
model.sol('sol37').feature('s1').feature('i1').feature('mg1').feature('cs').feature('d1').set('pivotperturb', 1.0E-9);
model.sol('sol37').feature('s1').feature('fc1').set('linsolver', 'd1');
model.sol('sol37').feature('s1').feature('fc1').set('termonres', 'auto');
model.sol('sol37').feature('s1').feature('fc1').set('reserrfact', 1000);
model.sol('sol37').feature('s1').feature.remove('fcDef');
model.sol('sol37').attach('std3');
model.sol('sol37').runAll;

model.result.dataset.create('mir1', 'Mirror3D');
model.result.dataset('mir1').set('data', 'dset7');
model.result.dataset('mir1').set('planetype', 'general');
model.result.dataset('mir1').setIndex('genpoints', 0.1, 1, 0);
model.result.dataset('mir1').setIndex('genpoints', '3.575e-3', 2, 1);
model.result.dataset('mir1').setIndex('genpoints', '3.575e-3', 2, 2);
model.result.create('pg9', 'PlotGroup3D');
model.result('pg9').run;
model.result('pg9').label('Thermal Stress');
model.result('pg9').set('data', 'mir1');
model.result('pg9').set('titletype', 'none');
model.result('pg9').set('showlegendsunit', true);
model.result('pg9').create('slc1', 'Slice');
model.result('pg9').feature('slc1').set('expr', 'solid.sGpxx');
model.result('pg9').feature('slc1').set('descr', 'Stress tensor, xx-component');
model.result('pg9').feature('slc1').set('quickxnumber', 8);
model.result('pg9').feature('slc1').set('colortable', 'WaveLightClassic');
model.result('pg9').feature('slc1').set('colorscalemode', 'linearsymmetric');
model.result('pg9').run;
model.result('pg9').set('edges', false);
model.result('pg9').run;

model.title('Thermal Stresses in a Monolithic Reactor');

model.description('NO reduction occurs as flue gases pass through the channels of a monolithic reactor in the exhaust system of a car. Exothermic reactions in the reactor give rise to temperature gradients, and this example investigates the deformation of the reactor that occurs due to thermal stresses.');

model.mesh.clearMeshes;

model.sol('sol1').clearSolutionData;
model.sol('sol2').clearSolutionData;
model.sol('sol9').clearSolutionData;
model.sol('sol10').clearSolutionData;
model.sol('sol11').clearSolutionData;
model.sol('sol12').clearSolutionData;
model.sol('sol13').clearSolutionData;
model.sol('sol14').clearSolutionData;
model.sol('sol15').clearSolutionData;
model.sol('sol22').clearSolutionData;
model.sol('sol23').clearSolutionData;
model.sol('sol24').clearSolutionData;
model.sol('sol25').clearSolutionData;
model.sol('sol26').clearSolutionData;
model.sol('sol27').clearSolutionData;
model.sol('sol28').clearSolutionData;
model.sol('sol29').clearSolutionData;
model.sol('sol30').clearSolutionData;
model.sol('sol31').clearSolutionData;
model.sol('sol32').clearSolutionData;
model.sol('sol33').clearSolutionData;
model.sol('sol34').clearSolutionData;
model.sol('sol35').clearSolutionData;
model.sol('sol36').clearSolutionData;
model.sol('sol37').clearSolutionData;

model.label('monolith_thermal_stress.mph');

model.modelNode.label('Components');

out = model;
