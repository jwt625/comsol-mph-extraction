function out = model
%
% beer_fermentation.m
%
% Model exported on May 26 2025, 21:27 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/Chemical_Reaction_Engineering_Module/Reactors_with_Mass_and_Heat_Transfer');

model.modelNode.create('comp1', true);

model.physics.create('re', 'ReactionEng');
model.physics('re').model('comp1');

model.study.create('std1');
model.study('std1').create('time', 'Transient');
model.study('std1').feature('time').setSolveFor('/physics/re', true);

% To import content from file, use:
% model.param.loadFile('FILENAME');
model.param.set('T0', '12[degC]', 'Initial temperature');
model.param.set('Tc', '12[degC]', 'Cooling media temperature');
model.param.set('qv', '8[W/(m^3*K)]', 'Cooling rate capacity');
model.param.set('EG', '22.6[kcal/mol]', 'Activation energy, glucose consumption');
model.param.set('EM', '11.3[kcal/mol]', 'Activation energy, maltose consumption');
model.param.set('EN', '7.16[kcal/mol]', 'Activation energy, maltotriose consumption');
model.param.set('EHG1', '-68.6[kcal/mol]', 'Activation energy, glucose inhibition mechanism 1');
model.param.set('EHM1', '-14.4[kcal/mol]', 'Activation energy, maltose inhibition mechanism 1');
model.param.set('EHN1', '-19.9[kcal/mol]', 'Activation energy, maltotriose inhibition mechanism 1');
model.param.set('EHG2', '10.2[kcal/mol]', 'Activation energy, glucose inhibition mechanism 2');
model.param.set('EHM2', '26.3[kcal/mol]', 'Activation energy, maltose inhibition mechanism 2');
model.param.set('AG', 'exp(35.77)[1/h]', 'Frequency factor, glucose consumption');
model.param.set('AM', 'exp(16.4)[1/h]', 'Frequency factor, maltose consumption');
model.param.set('AN', 'exp(10.59)[1/h]', 'Frequency factor, maltotriose consumption');
model.param.set('AHG1', 'exp(-121.3)[mol/m^3]', 'Frequency factor, glucose inhibition mechanism 1');
model.param.set('AHM1', 'exp(-19.5)[mol/m^3]', 'Frequency factor, maltose inhibition mechanism 1');
model.param.set('AHN1', 'exp(-26.78)[mol/m^3]', 'Frequency factor, maltotriose inhibition mechanism 1');
model.param.set('AHG2', 'exp(23.33)[mol/m^3]', 'Frequency factor, glucose inhibition mechanism 2');
model.param.set('AHM2', 'exp(55.61)[mol/m^3]', 'Frequency factor, maltose inhibition mechanism 2');
model.param.set('HG', '-91.2[kJ/mol]', 'Heat of fermentation, glucose');
model.param.set('HM', '-226.3[kJ/mol]', 'Heat of fermentation, maltose');
model.param.set('HN', '-361.3[kJ/mol]', 'Heat of fermentation, maltotriose');
model.param.set('KX', '365000[mol^2/m^6]', 'Empirical yeast growth inhibition constant');
model.param.set('YXG', '0.134', 'Yeast yield coefficient, glucose consumption');
model.param.set('YXM', '0.268', 'Yeast yield coefficient, maltose consumption');
model.param.set('YXN', '0.402', 'Yeast yield coefficient, maltotriose consumption');
model.param.set('YEG', '1.92', 'Ethanol yield coefficient, glucose consumption');
model.param.set('YEM', '3.84', 'Ethanol yield coefficient, maltose consumption');
model.param.set('YEN', '5.76', 'Ethanol yield coefficient, maltotriose consumption');
model.param.set('YCG', '1.97', 'CO2 yield coefficient, glucose consumption');
model.param.set('YCM', '3.94', 'CO2 yield coefficient, maltose consumption');
model.param.set('YCN', '5.91', 'CO2 yield coefficient, maltotriose consumption');
model.param.set('YEtAc', '0.000992', 'Ethyl acetate yield coefficient, sugar consumption');
model.param.set('YAcA', '0.01', 'Acetaldehyde yield coefficient, sugar consumption');
model.param.set('AAcA', 'exp(10.4)[m^3/(h*mol)]', 'Frequency factor, acetaldehyde uptake');
model.param.set('EAcA', '11.1[kcal/mol]', 'Activation energy, acetaldehyde uptake');
model.param.set('rhoH2O', '1000[kg/m^3]', 'Density, water');
model.param.set('rhoE', '800[kg/m^3]', 'Density, ethanol');
model.param.set('CpH2O', '75.42[J/(mol*K)]', 'Molar heat capacity, water');
model.param.set('MG', '0.180[kg/mol]', 'Molar mass, glucose');
model.param.set('MM', '0.342[kg/mol]', 'Molar mass, maltose');
model.param.set('MN', '0.504[kg/mol]', 'Molar mass, maltotriose');
model.param.set('MX', '2e5[kg/mol]', 'Molar mass, yeast');
model.param.set('Csat_CO2', '39[mol/m^3]', 'Maximum solubility concentration CO2 in water at 1 atm');
model.param.set('c0E', '0', 'Initial concentration, alcohol (ethanol)');
model.param.set('c0G', '70[mol/m^3]', 'Initial concentration, glucose');
model.param.set('c0M', '220[mol/m^3]', 'Initial concentration, maltose');
model.param.set('c0N', '40[mol/m^3]', 'Initial concentration, maltotriose');
model.param.set('c0CO2', '0[mol/m^3]', 'Initial concentration, carbon dioxide');
model.param.set('c0X', '30[mol/m^3]', 'Initial concentration, yeast');
model.param.set('hCO2', '0.07[h^-1]', 'Gas-liquid mass transfer coefficient, carbon dioxide');

model.variable.create('var1');
model.variable('var1').model('comp1');

% To import content from file, use:
% model.variable('var1').loadFile('FILENAME');
model.variable('var1').set('Temp', 're.T', 'Temperature in reactor');
model.variable('var1').set('c_G', 're.c_G', 'Glucose concentration');
model.variable('var1').set('c_M', 're.c_M', 'Maltose concentration');
model.variable('var1').set('c_N', 're.c_N', 'Maltotriose concentration');
model.variable('var1').set('kf1', 'kfG_max*c_G/(KG1+c_G)', 'Specific growth rate, glucose');
model.variable('var1').set('kf2', 'kfM_max*c_M/(KM1+c_M)*KG2/(KG2+c_G)', 'Specific growth rate, maltose');
model.variable('var1').set('kf3', 'kfN_max*c_N/(KN1+c_N)*KG2/(KG2+c_G)*KM2/(KM2+c_M)', 'Specific growth rate, maltotriose');
model.variable('var1').set('kfG_max', 'AG*exp(-EG/(R_const*Temp))', 'Maximum velocity, glucose consumption');
model.variable('var1').set('kfM_max', 'AM*exp(-EM/(R_const*Temp))', 'Maximum velocity, maltose consumption');
model.variable('var1').set('kfN_max', 'AN*exp(-EN/(R_const*Temp))', 'Maximum velocity, maltotriose consumption');
model.variable('var1').set('KG1', 'AHG1*exp(-EHG1/(R_const*Temp))', 'Michaelis constant, glucose inhibition reaction 1');
model.variable('var1').set('KG2', 'AHG2*exp(-EHG2/(R_const*Temp))', 'Michaelis constant, glucose inhibition reaction 2');
model.variable('var1').set('KM1', 'AHM1*exp(-EHM1/(R_const*Temp))', 'Michaelis constant, maltose inhibition reaction 1');
model.variable('var1').set('KN1', 'AHN1*exp(-EHN1/(R_const*Temp))', 'Michaelis constant, maltotriose inhibition reaction 1');
model.variable('var1').set('KM2', 'AHM2*exp(-EHM2/(R_const*Temp))', 'Michaelis constant, maltose inhibition reaction 2');
model.variable('var1').set('Evol', 're.c_E*re.M_E/rhoE*100', 'vol% alcohol');
model.variable('var1').set('kAcA', 'AAcA*exp(-EAcA/(R_const*Temp))', 'Rate constant, acetaldehyde uptake');

model.physics('re').prop('energybalance').set('energybalance', 'include');
model.physics('re').prop('energybalance').set('Qext', '-qv*(re.T-Tc)*re.Vr');
model.physics('re').prop('mixture').set('mixture', 'liquid');
model.physics('re').create('spec1', 'SpeciesChem', -1);
model.physics('re').feature('spec1').set('specName', 'X');
model.physics('re').feature('X').set('SpeciesrateSelection', 'UserDefined');
model.physics('re').feature('X').set('Speciesrate', '(YXG*kf1+YXM*kf2+YXN*kf3)*re.c_X*KX/(KX+(re.c_X-c0X)^2)');
model.physics('re').create('rch1', 'ReactionChem', -1);
model.physics('re').feature('rch1').set('formula', 'G=>E+CO2+EtAc+AcA');
model.physics('re').feature('rch1').set('ReactionExpression', 'UserDefined');
model.physics('re').feature('rch1').set('r', 'kf1*re.c_X');
model.physics('re').feature('rch1').set('ReactionEnthalpy', 'UserDefined');
model.physics('re').feature('rch1').set('H', 'HG');
model.physics('re').feature('E').set('enableChemicalFormulaCheckbox', true);
model.physics('re').feature('E').set('chemicalFormula', 'C2H5OH');
model.physics('re').feature('E').set('SpeciesrateSelection', 'UserDefined');
model.physics('re').feature('E').set('Speciesrate', '(YEG*kf1+YEM*kf2+YEN*kf3)*re.c_X');
model.physics('re').feature('CO2').set('SpeciesrateSelection', 'UserDefined');
model.physics('re').feature('CO2').set('Speciesrate', 'hCO2*(Csat_CO2-re.c_CO2)');
model.physics('re').feature('EtAc').set('enableChemicalFormulaCheckbox', true);
model.physics('re').feature('EtAc').set('chemicalFormula', 'C4H8O2');
model.physics('re').feature('EtAc').set('SpeciesrateSelection', 'UserDefined');
model.physics('re').feature('EtAc').set('Speciesrate', 'YEtAc*(kf1+kf2+kf3)*re.c_X');
model.physics('re').feature('AcA').set('enableChemicalFormulaCheckbox', true);
model.physics('re').feature('AcA').set('chemicalFormula', 'C2H4O');
model.physics('re').feature('AcA').set('SpeciesrateSelection', 'UserDefined');
model.physics('re').feature('AcA').set('Speciesrate', 'YAcA*(kf1+kf2+kf3)*re.c_X-kAcA*re.c_AcA*re.c_X');
model.physics('re').create('rch2', 'ReactionChem', -1);
model.physics('re').feature('rch2').set('formula', 'M=>E+CO2+EtAc+AcA');
model.physics('re').feature('rch2').set('ReactionExpression', 'UserDefined');
model.physics('re').feature('rch2').set('r', 'kf2*re.c_X');
model.physics('re').feature('rch2').set('ReactionEnthalpy', 'UserDefined');
model.physics('re').feature('rch2').set('H', 'HM');
model.physics('re').create('rch3', 'ReactionChem', -1);
model.physics('re').feature('rch3').set('formula', 'N=>E+CO2+EtAc+AcA');
model.physics('re').feature('rch3').set('ReactionExpression', 'UserDefined');
model.physics('re').feature('rch3').set('r', 'kf3*re.c_X');
model.physics('re').feature('rch3').set('ReactionEnthalpy', 'UserDefined');
model.physics('re').feature('rch3').set('H', 'HN');
model.physics('re').create('spec1', 'SpeciesChem', -1);
model.physics('re').feature('N').set('enableChemicalFormulaCheckbox', false);
model.physics('re').feature('spec1').set('specName', 'H2O');
model.physics('re').feature('H2O').set('sType', 'solvent');
model.physics('re').feature('H2O').set('speciesEnthalpy', 'UserDefined');
model.physics('re').feature('H2O').set('Cp', 'CpH2O');
model.physics('re').create('spec1', 'SpeciesChem', -1);
model.physics('re').feature('spec1').set('specName', 'CO2(g)');
model.physics('re').feature('CO2_gas').set('SpeciesrateSelection', 'UserDefined');
model.physics('re').feature('CO2_gas').set('Speciesrate', 'max((YXG*kf1+YXM*kf2+YXN*kf3)*re.c_X-hCO2*(Csat_CO2-re.c_CO2),eps)');
model.physics('re').feature('inits1').set('T0', 'T0');
model.physics('re').feature('inits1').setIndex('initialValue', 'c0E', 3, 0);
model.physics('re').feature('inits1').setIndex('initialValue', 'c0G', 5, 0);
model.physics('re').feature('inits1').setIndex('initialValue', 'rhoH2O/re.M_H2O', 6, 0);
model.physics('re').feature('inits1').setIndex('initialValue', 'c0M', 7, 0);
model.physics('re').feature('inits1').setIndex('initialValue', 'c0N', 8, 0);
model.physics('re').feature('inits1').setIndex('initialValue', 'c0X', 9, 0);

model.study('std1').feature('time').set('tunit', 'h');
model.study('std1').feature('time').set('tlist', 'range(0,1,400)');
model.study('std1').feature('time').set('usertol', true);
model.study('std1').feature('time').set('rtol', '1e-6');

model.sol.create('sol1');
model.sol('sol1').study('std1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'time');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').set('control', 'time');
model.sol('sol1').create('t1', 'Time');
model.sol('sol1').feature('t1').set('tlist', 'range(0,1,400)');
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
model.sol('sol1').feature('t1').set('atolglobalvaluemethod', 'manual');
model.sol('sol1').feature('t1').set('atolglobal', 1.0E-7);
model.sol('sol1').runAll;

model.result.create('pg1', 'PlotGroup1D');
model.result('pg1').set('data', 'dset1');
model.result('pg1').create('glob1', 'Global');
model.result('pg1').feature('glob1').set('expr', {'re.c_X' 're.c_G' 're.c_E' 're.c_CO2' 're.c_EtAc' 're.c_AcA' 're.c_M' 're.c_N' 're.c_CO2_gas'});
model.result('pg1').feature('glob1').set('descr', {'Concentration' 'Concentration' 'Concentration' 'Concentration' 'Concentration' 'Concentration' 'Concentration' 'Concentration' 'Concentration'});
model.result('pg1').feature('glob1').set('unit', {'' '' '' '' '' '' '' '' ''});
model.result('pg1').feature('glob1').set('expr', {'re.c_X' 're.c_G' 're.c_E' 're.c_CO2' 're.c_EtAc' 're.c_AcA' 're.c_M' 're.c_N' 're.c_CO2_gas'});
model.result('pg1').feature('glob1').set('descr', {'Concentration' 'Concentration' 'Concentration' 'Concentration' 'Concentration' 'Concentration' 'Concentration' 'Concentration' 'Concentration'});
model.result('pg1').label('Concentration (re)');
model.result('pg1').feature('glob1').set('xdatasolnumtype', 'level1');
model.result.create('pg2', 'PlotGroup1D');
model.result('pg2').set('data', 'dset1');
model.result('pg2').create('glob1', 'Global');
model.result('pg2').feature('glob1').set('expr', {'re.c_X' 're.c_G' 're.c_E' 're.c_CO2' 're.c_EtAc' 're.c_AcA' 're.c_M' 're.c_N' 're.c_CO2_gas'});
model.result('pg2').feature('glob1').set('descr', {'Concentration' 'Concentration' 'Concentration' 'Concentration' 'Concentration' 'Concentration' 'Concentration' 'Concentration' 'Concentration'});
model.result('pg2').feature('glob1').set('unit', {''});
model.result('pg2').feature('glob1').set('expr', {'re.T'});
model.result('pg2').feature('glob1').set('descr', {'Temperature'});
model.result('pg2').label('Temperature (re)');
model.result('pg2').feature('glob1').set('xdatasolnumtype', 'level1');
model.result('pg1').run;
model.result('pg1').label('Sugars');
model.result('pg1').run;
model.result('pg1').feature('glob1').set('expr', {'re.c_G'});
model.result('pg1').feature('glob1').set('descr', {'Concentration'});
model.result('pg1').feature('glob1').set('unit', {'mol/m^3'});
model.result('pg1').feature('glob1').set('expr', {'re.c_G' 're.c_M'});
model.result('pg1').feature('glob1').set('descr', {'Concentration' 'Concentration'});
model.result('pg1').feature('glob1').set('expr', {'re.c_G' 're.c_M' 're.c_N'});
model.result('pg1').feature('glob1').set('descr', {'Concentration' 'Concentration' 'Concentration'});
model.result('pg1').feature('glob1').set('titletype', 'manual');
model.result('pg1').feature('glob1').set('title', 'Sugar Concentrations');
model.result('pg1').feature('glob1').set('linewidth', 2);
model.result('pg1').feature('glob1').set('legendmethod', 'manual');
model.result('pg1').feature('glob1').setIndex('legends', 'Glucose', 0);
model.result('pg1').feature('glob1').setIndex('legends', 'Maltose', 1);
model.result('pg1').feature('glob1').setIndex('legends', 'Maltotriose', 2);
model.result('pg1').run;
model.result('pg1').run;
model.result.duplicate('pg3', 'pg1');
model.result('pg3').run;
model.result('pg3').label('Alcohol');
model.result('pg3').set('ylabelactive', true);
model.result('pg3').set('ylabel', 'vol% alcohol');
model.result('pg3').run;
model.result('pg3').feature('glob1').set('expr', {'Evol'});
model.result('pg3').feature('glob1').set('descr', {'vol% alcohol'});
model.result('pg3').feature('glob1').set('unit', {'1'});
model.result('pg3').feature('glob1').set('title', 'Alcohol Content');
model.result('pg3').feature('glob1').set('legend', false);
model.result('pg3').run;
model.result('pg3').run;
model.result.duplicate('pg4', 'pg3');
model.result('pg4').run;
model.result('pg4').label('Yeast');
model.result('pg4').set('ylabel', 'Concentration (mol/m<sup>3</sup>)');
model.result('pg4').run;
model.result('pg4').feature('glob1').set('expr', {'re.c_X'});
model.result('pg4').feature('glob1').set('descr', {'Concentration'});
model.result('pg4').feature('glob1').set('unit', {'mol/m^3'});
model.result('pg4').feature('glob1').set('title', 'Yeast Concentration');
model.result('pg4').run;
model.result('pg1').run;
model.result.duplicate('pg5', 'pg1');
model.result('pg5').run;
model.result('pg5').label('Flavors');
model.result('pg5').run;
model.result('pg5').feature('glob1').set('expr', {'re.c_EtAc'});
model.result('pg5').feature('glob1').set('descr', {'Concentration'});
model.result('pg5').feature('glob1').set('unit', {'mol/m^3'});
model.result('pg5').feature('glob1').set('expr', {'re.c_EtAc' 're.c_AcA'});
model.result('pg5').feature('glob1').set('descr', {'Concentration' 'Concentration'});
model.result('pg5').feature('glob1').set('title', 'Flavor Concentrations');
model.result('pg5').feature('glob1').setIndex('legends', 'Ester, desirable', 0);
model.result('pg5').feature('glob1').setIndex('legends', 'Aldehyde, undesirable', 1);
model.result('pg5').feature('glob1').setIndex('legends', '', 2);
model.result('pg5').run;
model.result('pg2').run;
model.result('pg2').set('ylabelactive', true);
model.result('pg2').set('ylabel', 'Temperature (<sup>o</sup>C)');
model.result('pg2').run;
model.result('pg2').feature('glob1').setIndex('expr', 're.T-273.15[K]', 0);
model.result('pg2').feature('glob1').set('titletype', 'manual');
model.result('pg2').feature('glob1').set('title', 'Temperature');
model.result('pg2').feature('glob1').set('linewidth', 2);
model.result('pg2').feature('glob1').set('legend', false);
model.result('pg2').run;

model.title('Fermentation in Beer Brewing');

model.description(['During the beer fermentation process, alcohol, carbon dioxide, and various flavors are formed when sugars are consumed by yeast.' newline  newline 'In this example, the fermentation process is modeled in a perfectly mixed tank, using the Reaction Engineering interface. ' newline  newline 'The model can be used to optimize the beer fermenting process, and improve the taste of your beer. It allows you to study the effect of for example initial sugar content, temperature, and yeast type on the fermentation process.']);

model.mesh.clearMeshes;

model.sol('sol1').clearSolutionData;

model.label('beer_fermentation.mph');

model.modelNode.label('Components');

out = model;
