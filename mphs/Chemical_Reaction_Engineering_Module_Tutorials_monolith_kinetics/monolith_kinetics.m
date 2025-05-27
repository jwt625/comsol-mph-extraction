function out = model
%
% monolith_kinetics.m
%
% Model exported on May 26 2025, 21:27 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/Chemical_Reaction_Engineering_Module/Tutorials');

model.modelNode.create('comp1', true);

model.physics.create('re', 'ReactionEng');
model.physics('re').model('comp1');

model.study.create('std1');
model.study('std1').create('spf', 'StationaryPlugflow');
model.study('std1').feature('spf').set('solnum', 'auto');
model.study('std1').feature('spf').set('notsolnum', 'auto');
model.study('std1').feature('spf').set('outputmap', {});
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
model.physics('re').feature('rch2').set('formula', '4 NH3 + 3 O2 => 2 N2 + 6 H2O');
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
model.physics('re').feature('inits1').setIndex('VolumetricSpecies', 'H2O', 0, 0);
model.physics('re').feature('inits1').setIndex('F0', 'F_H2O_in', 0, 0);
model.physics('re').feature('inits1').setIndex('VolumetricSpecies', 'N2', 1, 0);
model.physics('re').feature('inits1').setIndex('F0', 'F_N2_in', 1, 0);
model.physics('re').feature('inits1').setIndex('VolumetricSpecies', 'NH3', 2, 0);
model.physics('re').feature('inits1').setIndex('F0', 'F_NH3_in', 2, 0);
model.physics('re').feature('inits1').setIndex('VolumetricSpecies', 'NO', 3, 0);
model.physics('re').feature('inits1').setIndex('F0', 'F_NO_in', 3, 0);
model.physics('re').feature('inits1').setIndex('VolumetricSpecies', 'O2', 4, 0);
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
model.batch('p1').run('compute');

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
model.batch('p1').run('compute');

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
model.result('pg3').feature('glob1').set('xdatasolnumtype', 'level1');
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
model.result('pg5').feature('glob2').setIndex('unit', 1, 0);
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

model.modelNode.label('Components');

out = model;
