function out = model
%
% membrane_hda.m
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
model.study('std1').create('spf', 'StationaryPlugflow');
model.study('std1').feature('spf').set('solnum', 'auto');
model.study('std1').feature('spf').set('notsolnum', 'auto');
model.study('std1').feature('spf').set('outputmap', {});
model.study('std1').feature('spf').setSolveFor('/physics/re', true);

model.thermodynamics.feature.create('pp1', 'BuiltinPropertyPackage');
model.thermodynamics.feature('pp1').set('compoundlist', {'hydrogen' '1333-74-0' 'H2' 'COMSOL';  ...
'methane' '74-82-8' 'CH4' 'COMSOL';  ...
'benzene' '71-43-2' 'C6H6' 'COMSOL';  ...
'toluene' '108-88-3' 'C7H8' 'COMSOL';  ...
'biphenyl' '92-52-4' 'C12H10' 'COMSOL'});
model.thermodynamics.feature('pp1').set('phase_list', {'Vapor' 'Vapor'; 'Liquid' 'Liquid'});
model.thermodynamics.feature('pp1').label('Vapor-Liquid System 1');
model.thermodynamics.feature('pp1').set('manager_id', 'COMSOL');
model.thermodynamics.feature('pp1').set('manager_version', '1.0');
model.thermodynamics.feature('pp1').set('packagename', 'pp1');
model.thermodynamics.feature('pp1').set('package_desc', 'Built-in property package');
model.thermodynamics.feature('pp1').set('managerindex', '0');
model.thermodynamics.feature('pp1').set('packageid', 'COMSOL1');
model.thermodynamics.feature('pp1').set('LiquidPhaseModel', 'SoaveRedlichKwong');
model.thermodynamics.feature('pp1').set('LiquidCard', 'LiquidPhaseModel');
model.thermodynamics.feature('pp1').set('EOSModel', 'SoaveRedlichKwong');
model.thermodynamics.feature('pp1').set('GasPhaseModel', 'SoaveRedlichKwong');
model.thermodynamics.feature('pp1').set('GasEOSCard', 'GasPhaseModel');
model.thermodynamics.feature('pp1').set('VapDiffusivity', 'Automatic');
model.thermodynamics.feature('pp1').set('VLSurfaceTension', 'Ideal');
model.thermodynamics.feature('pp1').set('VapThermalConductivity', 'KineticTheory');
model.thermodynamics.feature('pp1').set('VapViscosity', 'Brokaw');
model.thermodynamics.feature('pp1').set('LiqDiffusivity', 'WesselinghKrishna');
model.thermodynamics.feature('pp1').set('LiqDiffusivityAtInfDilution', 'Automatic');
model.thermodynamics.feature('pp1').set('LLSurfaceTension', 'None');
model.thermodynamics.feature('pp1').set('LiqThermalConductivity', 'Ideal');
model.thermodynamics.feature('pp1').set('LiqViscosity', 'LogarithmicMassMixing');
model.thermodynamics.feature('pp1').set('LiqVolume', 'SoaveRedlichKwong');
model.thermodynamics.feature('pp1').storePersistenceData;
model.thermodynamics.feature('pp1').set('WarningState', false);
model.thermodynamics.feature('pp1').set('Warning', {''});
model.thermodynamics.feature('pp1').feature.create('singlephase1', 'OnePhaseProperty');
model.thermodynamics.feature('pp1').feature('singlephase1').label('Enthalpy of formation 1');
model.thermodynamics.feature('pp1').feature('singlephase1').set('funcname', 'EnthalpyF_benzene_biphenyl_hydrogen_methane_toluene_Vapor11');
model.thermodynamics.feature('pp1').feature('singlephase1').set('property', 'EnthalpyF');
model.thermodynamics.feature('pp1').feature('singlephase1').set('propertydescr', 'Enthalpy of formation');
model.thermodynamics.feature('pp1').feature('singlephase1').set('unit', 'J/mol');
model.thermodynamics.feature('pp1').feature('singlephase1').set('prop_basis', 'mole');
model.thermodynamics.feature('pp1').feature('singlephase1').set('compounds', {'benzene' 'biphenyl' 'hydrogen' 'methane' 'toluene'});
model.thermodynamics.feature('pp1').feature('singlephase1').set('args', {'temperature' 'K' 'Temperature';  ...
'pressure' 'Pa' 'Pressure';  ...
'molefraction_benzene' '1' 'Mole fraction benzene';  ...
'molefraction_biphenyl' '1' 'Mole fraction biphenyl';  ...
'molefraction_hydrogen' '1' 'Mole fraction hydrogen';  ...
'molefraction_methane' '1' 'Mole fraction methane';  ...
'molefraction_toluene' '1' 'Mole fraction toluene'});
model.thermodynamics.feature('pp1').feature('singlephase1').set('plotargs', {'temperature' '298.15' '373.15';  ...
'pressure' '101325' '101325';  ...
'molefraction_benzene' '0.2' '0.2';  ...
'molefraction_biphenyl' '0.2' '0.2';  ...
'molefraction_hydrogen' '0.2' '0.2';  ...
'molefraction_methane' '0.2' '0.2';  ...
'molefraction_toluene' '0.2' '0.2'});
model.thermodynamics.feature('pp1').feature('singlephase1').set('derivatives', {'EnthalpyF_benzene_biphenyl_hydrogen_methane_toluene_Vapor11_Dtemperature' 'EnthalpyF_benzene_biphenyl_hydrogen_methane_toluene_Vapor11_Dpressure' 'EnthalpyF_benzene_biphenyl_hydrogen_methane_toluene_Vapor11_Dmolefraction_benzene' 'EnthalpyF_benzene_biphenyl_hydrogen_methane_toluene_Vapor11_Dmolefraction_biphenyl' 'EnthalpyF_benzene_biphenyl_hydrogen_methane_toluene_Vapor11_Dmolefraction_hydrogen' 'EnthalpyF_benzene_biphenyl_hydrogen_methane_toluene_Vapor11_Dmolefraction_methane' 'EnthalpyF_benzene_biphenyl_hydrogen_methane_toluene_Vapor11_Dmolefraction_toluene'});
model.thermodynamics.feature('pp1').feature('singlephase1').set('SecondDerivatives', {});
model.thermodynamics.feature('pp1').feature('singlephase1').set('SecondDerivativeIndices', {});
model.thermodynamics.feature('pp1').feature('singlephase1').set('phase', 'Vapor');
model.thermodynamics.feature('pp1').feature('singlephase1').set('comp_basis', 'mole');
model.thermodynamics.feature('pp1').feature('singlephase1').set('include_derivatives', 'yes');
model.thermodynamics.feature('pp1').set('WarningState', false);
model.thermodynamics.feature('pp1').set('Warning', {''});
model.thermodynamics.feature('pp1').feature('singlephase1').set('funcname', 'hF_mixture');

% To import content from file, use:
% model.param.loadFile('FILENAME');
model.param.set('T_inlet', '1200[K]', 'Inlet temperature');
model.param.set('p_shell', '2.5*101325[Pa]', 'Pressure, shell side');
model.param.set('p_reactor', '2*101325[Pa]', 'Pressure, reactor');
model.param.set('k', '8.0E-8[m^3/(N*s)]', 'Proportionality constant');
model.param.set('a', '100.5[1/m]', 'Area per volume');

model.variable.create('var1');
model.variable('var1').model('comp1');

% To import content from file, use:
% model.variable('var1').loadFile('FILENAME');
model.variable('var1').set('f_H2', 'k*a*(p_shell-p_reactor)*c_H2_shell', 'Membrane mass source');
model.variable('var1').set('Q_mem', 'f_H2*(hF_mixture(T_inlet,p_shell,0,0,1,0,0)-hF_mixture(re.T,p_reactor,0,0,1,0,0))', 'Membrane heat source');
model.variable('var1').set('y_C6H6', 're.F_C6H6/re.F0_C6H5CH3', 'Conversion, benzene');
model.variable('var1').set('c_H2_shell', 'p_shell/R_const/re.T', 'Hydrogen concentration, membrane side');

model.physics('re').prop('reactor').set('reactor', 'plugflow');
model.physics('re').prop('energybalance').set('energybalance', 'include');
model.physics('re').prop('energybalance').set('Qextplug', 'Q_mem');
model.physics('re').prop('mixture').set('p', 'p_reactor');
model.physics('re').create('rch1', 'ReactionChem', -1);
model.physics('re').feature('rch1').set('formula', 'C6H5CH3+H2=>C6H6+CH4');
model.physics('re').feature('rch1').set('useArrhenius', true);
model.physics('re').feature('rch1').set('Af', '5.67e9[1/s]');
model.physics('re').feature('rch1').set('Ef', '228.2e3');
model.physics('re').feature('rch1').set('ReactionExpression', 'UserDefined');
model.physics('re').feature('rch1').set('bulkFwdOrder', 1);
model.physics('re').feature('rch1').set('r', 're.kf_1*re.c_C6H5CH3*(re.c_H2/1[mol/m^3])^0.5');
model.physics('re').create('rch2', 'ReactionChem', -1);
model.physics('re').feature('rch2').set('formula', '2C6H6<=>C12H10+H2');
model.physics('re').feature('rch2').set('useArrhenius', true);
model.physics('re').feature('rch2').set('Af', '1e8');
model.physics('re').feature('rch2').set('Ef', '167.5e3');
model.physics('re').feature('rch2').set('Ar', '1e8');
model.physics('re').feature('rch2').set('Er', '149.8e3');
model.physics('re').create('add1', 'AdditionalSourceFeature', -1);
model.physics('re').feature('add1').setIndex('AddR', 'f_H2', 4, 0);
model.physics('re').feature('inits1').set('T0plug', 'T_inlet');
model.physics('re').feature('inits1').setIndex('VolumetricSpecies', 'C6H5CH3', 1, 0);
model.physics('re').feature('inits1').setIndex('F0', 10, 1, 0);
model.physics('re').feature('inits1').setIndex('VolumetricSpecies', 'H2', 4, 0);
model.physics('re').feature('inits1').setIndex('F0', 10, 4, 0);
model.physics('re').prop('mixture').set('Thermodynamics', true);
model.physics('re').prop('SpeciesMatching').setIndex('PackageSpecies', 'biphenyl', 0, 0);
model.physics('re').prop('SpeciesMatching').setIndex('PackageSpecies', 'toluene', 1, 0);
model.physics('re').prop('SpeciesMatching').setIndex('PackageSpecies', 'benzene', 2, 0);
model.physics('re').prop('SpeciesMatching').setIndex('PackageSpecies', 'methane', 3, 0);
model.physics('re').prop('SpeciesMatching').setIndex('PackageSpecies', 'hydrogen', 4, 0);

model.study('std1').label('Tubular reactor');
model.study('std1').feature('spf').set('useadvanceddisable', true);
model.study('std1').feature('spf').set('disabledphysics', {'re/add1'});
model.study('std1').setGenPlots(false);

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
model.sol('sol1').runAll;

model.result.create('pg1', 'PlotGroup1D');
model.result('pg1').run;
model.result('pg1').create('glob1', 'Global');
model.result('pg1').feature('glob1').set('markerpos', 'datapoints');
model.result('pg1').feature('glob1').set('linewidth', 'preference');
model.result('pg1').run;
model.result('pg1').create('glob2', 'Global');
model.result('pg1').feature('glob2').set('markerpos', 'datapoints');
model.result('pg1').feature('glob2').set('linewidth', 'preference');
model.result('pg1').run;
model.result('pg1').label('Concentration and Temperature profile, tubular reactor');
model.result('pg1').set('xlabelactive', true);
model.result('pg1').set('xlabel', 'Reactor volume (m<sup>3</sup>)');
model.result('pg1').set('ylabelactive', true);
model.result('pg1').set('ylabel', 'Concentration (mol/m<sup>3</sup>)');
model.result('pg1').set('twoyaxes', true);
model.result('pg1').setIndex('plotonsecyaxis', true, 1, 1);
model.result('pg1').set('yseclabelactive', true);
model.result('pg1').set('yseclabel', 'Temperature (K)');
model.result('pg1').run;
model.result('pg1').feature('glob1').label('Concentration');
model.result('pg1').feature('glob1').setIndex('expr', 're.c_C6H5CH3', 0);
model.result('pg1').feature('glob1').setIndex('unit', 'mol/m^3', 0);
model.result('pg1').feature('glob1').setIndex('descr', 'Concentration', 0);
model.result('pg1').feature('glob1').setIndex('expr', 're.c_H2', 1);
model.result('pg1').feature('glob1').setIndex('unit', 'mol/m^3', 1);
model.result('pg1').feature('glob1').setIndex('descr', 'Concentration', 1);
model.result('pg1').feature('glob1').setIndex('expr', 're.c_C6H6', 2);
model.result('pg1').feature('glob1').setIndex('unit', 'mol/m^3', 2);
model.result('pg1').feature('glob1').setIndex('descr', 'Concentration', 2);
model.result('pg1').feature('glob1').setIndex('expr', 're.c_CH4', 3);
model.result('pg1').feature('glob1').setIndex('unit', 'mol/m^3', 3);
model.result('pg1').feature('glob1').setIndex('descr', 'Concentration', 3);
model.result('pg1').feature('glob1').setIndex('expr', 're.c_C12H10', 4);
model.result('pg1').feature('glob1').setIndex('unit', 'mol/m^3', 4);
model.result('pg1').feature('glob1').setIndex('descr', 'Concentration', 4);
model.result('pg1').feature('glob1').set('legendmethod', 'manual');
model.result('pg1').feature('glob1').setIndex('legends', 'Toluene', 0);
model.result('pg1').feature('glob1').setIndex('legends', 'Hydrogen', 1);
model.result('pg1').feature('glob1').setIndex('legends', 'Benzene', 2);
model.result('pg1').feature('glob1').setIndex('legends', 'Methane', 3);
model.result('pg1').feature('glob1').setIndex('legends', 'Biphenyl', 4);
model.result('pg1').feature('glob1').set('linewidth', 2);
model.result('pg1').run;
model.result('pg1').feature('glob2').label('Temperature');
model.result('pg1').feature('glob2').set('expr', {});
model.result('pg1').feature('glob2').set('descr', {});
model.result('pg1').feature('glob2').setIndex('expr', 're.T', 0);
model.result('pg1').feature('glob2').setIndex('unit', 'K', 0);
model.result('pg1').feature('glob2').setIndex('descr', 'Temperature', 0);
model.result('pg1').feature('glob2').set('linewidth', 2);
model.result('pg1').feature('glob2').set('linemarker', 'point');
model.result('pg1').feature('glob2').set('markerpos', 'interp');
model.result('pg1').run;
model.result('pg1').run;
model.result('pg1').feature('glob2').set('autoplotlabel', true);
model.result('pg1').feature('glob2').set('autosolution', false);
model.result('pg1').feature('glob2').set('autoexpr', false);
model.result('pg1').run;
model.result('pg1').set('titletype', 'none');
model.result('pg1').set('axislimits', true);
model.result('pg1').set('ymax', 18);
model.result('pg1').set('ymaxsec', 1370);
model.result('pg1').set('legendpos', 'upperleft');
model.result('pg1').run;

model.study.create('std2');
model.study('std2').create('spf', 'StationaryPlugflow');
model.study('std2').feature('spf').set('plotgroup', 'Default');
model.study('std2').feature('spf').set('solnum', 'auto');
model.study('std2').feature('spf').set('notsolnum', 'auto');
model.study('std2').feature('spf').set('outputmap', {});
model.study('std2').feature('spf').setSolveFor('/physics/re', true);
model.study('std2').label('Membrane reactor');
model.study('std2').setGenPlots(false);

model.sol.create('sol2');
model.sol('sol2').study('std2');
model.sol('sol2').create('st1', 'StudyStep');
model.sol('sol2').feature('st1').set('study', 'std2');
model.sol('sol2').feature('st1').set('studystep', 'spf');
model.sol('sol2').create('v1', 'Variables');
model.sol('sol2').feature('v1').set('control', 'spf');
model.sol('sol2').create('pf1', 'Plugflow');
model.sol('sol2').feature('pf1').set('tlist', 'range(0,0.1,1)');
model.sol('sol2').feature('pf1').set('plot', 'off');
model.sol('sol2').feature('pf1').set('plotgroup', 'Default');
model.sol('sol2').feature('pf1').set('plotfreq', 'tout');
model.sol('sol2').feature('pf1').set('probesel', 'all');
model.sol('sol2').feature('pf1').set('probes', {});
model.sol('sol2').feature('pf1').set('probefreq', 'tsteps');
model.sol('sol2').feature('pf1').set('tout', 'tsteps');
model.sol('sol2').feature('pf1').set('rtol', 1.0E-5);
model.sol('sol2').feature('pf1').set('atolglobalvaluemethod', 'factor');
model.sol('sol2').feature('pf1').set('reacf', true);
model.sol('sol2').feature('pf1').set('storeudot', true);
model.sol('sol2').feature('pf1').set('endtimeinterpolation', true);
model.sol('sol2').feature('pf1').set('consistent', 'off');
model.sol('sol2').feature('pf1').set('control', 'spf');
model.sol('sol2').feature('pf1').create('fc1', 'FullyCoupled');
model.sol('sol2').feature('pf1').feature('fc1').set('dtech', 'auto');
model.sol('sol2').feature('pf1').feature('fc1').set('linsolver', 'dDef');
model.sol('sol2').feature('pf1').feature('fc1').set('dtech', 'auto');
model.sol('sol2').feature('pf1').feature.remove('fcDef');
model.sol('sol2').attach('std2');
model.sol('sol2').runAll;

model.result('pg1').run;
model.result.duplicate('pg2', 'pg1');
model.result('pg2').run;
model.result('pg2').label('Concentration and Temperature profile,  membrane reactor');
model.result('pg2').set('data', 'dset2');
model.result('pg2').run;

model.title('Hydrodealkylation in a Membrane Reactor');

model.description('The thermal hydrodealkylation process carried out in a membrane reactor is modeled in this example. This example uses the Thermodynamics feature to include built-in thermodynamic and physical property evaluations.');

model.label('membrane_hda.mph');

model.modelNode.label('Components');

out = model;
