function out = model
%
% gas_phase_equilibrium_reaction.m
%
% Model exported on May 26 2025, 21:27 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/Chemical_Reaction_Engineering_Module/Applications');

model.modelNode.create('comp1', true);

model.physics.create('re', 'ReactionEng');
model.physics('re').model('comp1');

model.study.create('std1');
model.study('std1').create('time', 'Transient');
model.study('std1').feature('time').setSolveFor('/physics/re', true);

% To import content from file, use:
% model.param.loadFile('FILENAME');
model.param.set('p', '10[bar]', 'Pressure');
model.param.set('T', '450[K]', 'Temperature');
model.param.set('n0C2H4', '1', 'Initial moles ethylene');
model.param.set('n0H2O', '1', 'Initial moles water');
model.param.set('n0C2H5OH', '0', 'Initial moles ethanol');
model.param.set('n0N2', '0', 'Initial moles nitrogen');
model.param.set('p0', '1[bar]', 'Reference pressure');
model.param.set('R', '8.314[J/mol/K]', 'Gas constant');
model.param.set('T0', '298.15[K]', 'Reference temperature');
model.param.set('Hcon', '1', 'Condition on DH for calculating KT,0=DHconst, 1=FofT');
model.param.set('PHIcon', '2', 'Condition on PHI, 0=IG, 1=IS, 2=MF');
model.param.set('n0', 'n0C2H4+n0H2O+n0C2H5OH+n0N2', 'Initial total moles');
model.param.set('x0C2H4', 'n0C2H4/n0', 'Initial mole fraction C2H4');
model.param.set('x0H2O', 'n0H2O/n0', 'Initial mole fraction H2O');
model.param.set('x0C2H5OH', 'n0C2H5OH/n0', 'Initial mole fraction C2H5OH');
model.param.set('x0N2', 'n0N2/n0', 'Initial mole fraction N2');
model.param.set('a_q1', '0', 'Quiz answer q1');
model.param.set('a_q2', '0', 'Quiz answer q2');
model.param.set('a_q3', '0', 'Quiz answer q3');
model.param.set('a_q4', '0', 'Quiz answer q4');
model.param.set('a_q5', '0', 'Quiz answer q5');
model.param.set('a_q6', '0', 'Quiz answer q6');
model.param.set('a_q7', '0', 'Quiz answer q7');
model.param.set('a_q8', '0', 'Quiz answer q8');
model.param.set('pts_q1', 'if(a_q1==3,1,0)', 'Quiz points q1');
model.param.set('pts_q2', 'if(a_q2==2,1,0)', 'Quiz points q2');
model.param.set('pts_q3', 'if(a_q3==2,1,0)', 'Quiz points q3');
model.param.set('pts_q4', 'if(a_q4==2,1,0)', 'Quiz points q4');
model.param.set('pts_q5', 'if(a_q5==2,1,0)', 'Quiz points q5');
model.param.set('pts_q6', 'if(a_q6==3,1,0)', 'Quiz points q6');
model.param.set('pts_q7', 'if(a_q7==4,1,0)', 'Quiz points q7');
model.param.set('pts_q8', 'if(a_q8==1,1,0)', 'Quiz points q8');
model.param.set('pts_total', 'pts_q1+pts_q2+pts_q3+pts_q4+pts_q5+pts_q6+pts_q7+pts_q8', 'Total quiz points');
model.param.set('pts_max', '8', 'Maximum quiz points');

model.thermodynamics.feature.create('pp1', 'BuiltinPropertyPackage');
model.thermodynamics.feature('pp1').set('compoundlist', {'ethene' '74-85-1' 'C2H4' 'COMSOL';  ...
'ethanol' '64-17-5' 'C2H6O' 'COMSOL';  ...
'water' '7732-18-5' 'H2O' 'COMSOL';  ...
'nitrogen' '7727-37-9' 'N2' 'COMSOL'});
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
model.thermodynamics.feature('pp1').feature('singlephase1').set('funcname', 'EnthalpyF_ethanol_Vapor11');
model.thermodynamics.feature('pp1').feature('singlephase1').set('property', 'EnthalpyF');
model.thermodynamics.feature('pp1').feature('singlephase1').set('propertydescr', 'Enthalpy of formation');
model.thermodynamics.feature('pp1').feature('singlephase1').set('unit', 'J/mol');
model.thermodynamics.feature('pp1').feature('singlephase1').set('prop_basis', 'mole');
model.thermodynamics.feature('pp1').feature('singlephase1').set('compounds', {'ethanol'});
model.thermodynamics.feature('pp1').feature('singlephase1').set('args', {'temperature' 'K' 'Temperature'; 'pressure' 'Pa' 'Pressure'});
model.thermodynamics.feature('pp1').feature('singlephase1').set('plotargs', {'temperature' '298.15' '373.15'; 'pressure' '101325' '101325'});
model.thermodynamics.feature('pp1').feature('singlephase1').set('derivatives', {'EnthalpyF_ethanol_Vapor11_Dtemperature' 'EnthalpyF_ethanol_Vapor11_Dpressure'});
model.thermodynamics.feature('pp1').feature('singlephase1').set('SecondDerivatives', {});
model.thermodynamics.feature('pp1').feature('singlephase1').set('SecondDerivativeIndices', {});
model.thermodynamics.feature('pp1').feature('singlephase1').set('phase', 'Vapor');
model.thermodynamics.feature('pp1').feature('singlephase1').set('comp_basis', 'mole');
model.thermodynamics.feature('pp1').feature('singlephase1').set('include_derivatives', 'yes');
model.thermodynamics.feature('pp1').feature.create('singlephase2', 'OnePhaseProperty');
model.thermodynamics.feature('pp1').feature('singlephase2').label('Gibbs free energy of formation 1');
model.thermodynamics.feature('pp1').feature('singlephase2').set('funcname', 'GibbsEnergyF_ethanol_Vapor12');
model.thermodynamics.feature('pp1').feature('singlephase2').set('property', 'GibbsEnergyF');
model.thermodynamics.feature('pp1').feature('singlephase2').set('propertydescr', 'Gibbs free energy of formation');
model.thermodynamics.feature('pp1').feature('singlephase2').set('unit', 'J/mol');
model.thermodynamics.feature('pp1').feature('singlephase2').set('prop_basis', 'mole');
model.thermodynamics.feature('pp1').feature('singlephase2').set('compounds', {'ethanol'});
model.thermodynamics.feature('pp1').feature('singlephase2').set('args', {'temperature' 'K' 'Temperature'; 'pressure' 'Pa' 'Pressure'});
model.thermodynamics.feature('pp1').feature('singlephase2').set('plotargs', {'temperature' '298.15' '373.15'; 'pressure' '101325' '101325'});
model.thermodynamics.feature('pp1').feature('singlephase2').set('derivatives', {'GibbsEnergyF_ethanol_Vapor12_Dtemperature' 'GibbsEnergyF_ethanol_Vapor12_Dpressure'});
model.thermodynamics.feature('pp1').feature('singlephase2').set('SecondDerivatives', {});
model.thermodynamics.feature('pp1').feature('singlephase2').set('SecondDerivativeIndices', {});
model.thermodynamics.feature('pp1').feature('singlephase2').set('phase', 'Vapor');
model.thermodynamics.feature('pp1').feature('singlephase2').set('comp_basis', 'mole');
model.thermodynamics.feature('pp1').feature('singlephase2').set('include_derivatives', 'yes');
model.thermodynamics.feature('pp1').feature.create('singlephase3', 'OnePhaseProperty');
model.thermodynamics.feature('pp1').feature('singlephase3').label('Fugacity coefficient 1');
model.thermodynamics.feature('pp1').feature('singlephase3').set('funcname', 'FugacityCoefficient_ethanol_Vapor13');
model.thermodynamics.feature('pp1').feature('singlephase3').set('property', 'FugacityCoefficient');
model.thermodynamics.feature('pp1').feature('singlephase3').set('propertydescr', 'Fugacity coefficient');
model.thermodynamics.feature('pp1').feature('singlephase3').set('unit', '1');
model.thermodynamics.feature('pp1').feature('singlephase3').set('prop_basis', 'mole');
model.thermodynamics.feature('pp1').feature('singlephase3').set('compounds', {'ethanol'});
model.thermodynamics.feature('pp1').feature('singlephase3').set('args', {'temperature' 'K' 'Temperature'; 'pressure' 'Pa' 'Pressure'});
model.thermodynamics.feature('pp1').feature('singlephase3').set('plotargs', {'temperature' '298.15' '373.15'; 'pressure' '101325' '101325'});
model.thermodynamics.feature('pp1').feature('singlephase3').set('derivatives', {'FugacityCoefficient_ethanol_Vapor13_Dtemperature' 'FugacityCoefficient_ethanol_Vapor13_Dpressure'});
model.thermodynamics.feature('pp1').feature('singlephase3').set('SecondDerivatives', {});
model.thermodynamics.feature('pp1').feature('singlephase3').set('SecondDerivativeIndices', {});
model.thermodynamics.feature('pp1').feature('singlephase3').set('phase', 'Vapor');
model.thermodynamics.feature('pp1').feature('singlephase3').set('comp_basis', 'mole');
model.thermodynamics.feature('pp1').feature('singlephase3').set('include_derivatives', 'yes');
model.thermodynamics.feature('pp1').feature.create('singlephase4', 'OnePhaseProperty');
model.thermodynamics.feature('pp1').feature('singlephase4').label('Enthalpy of formation 2');
model.thermodynamics.feature('pp1').feature('singlephase4').set('funcname', 'EnthalpyF_ethene_Vapor14');
model.thermodynamics.feature('pp1').feature('singlephase4').set('property', 'EnthalpyF');
model.thermodynamics.feature('pp1').feature('singlephase4').set('propertydescr', 'Enthalpy of formation');
model.thermodynamics.feature('pp1').feature('singlephase4').set('unit', 'J/mol');
model.thermodynamics.feature('pp1').feature('singlephase4').set('prop_basis', 'mole');
model.thermodynamics.feature('pp1').feature('singlephase4').set('compounds', {'ethene'});
model.thermodynamics.feature('pp1').feature('singlephase4').set('args', {'temperature' 'K' 'Temperature'; 'pressure' 'Pa' 'Pressure'});
model.thermodynamics.feature('pp1').feature('singlephase4').set('plotargs', {'temperature' '298.15' '373.15'; 'pressure' '101325' '101325'});
model.thermodynamics.feature('pp1').feature('singlephase4').set('derivatives', {'EnthalpyF_ethene_Vapor14_Dtemperature' 'EnthalpyF_ethene_Vapor14_Dpressure'});
model.thermodynamics.feature('pp1').feature('singlephase4').set('SecondDerivatives', {});
model.thermodynamics.feature('pp1').feature('singlephase4').set('SecondDerivativeIndices', {});
model.thermodynamics.feature('pp1').feature('singlephase4').set('phase', 'Vapor');
model.thermodynamics.feature('pp1').feature('singlephase4').set('comp_basis', 'mole');
model.thermodynamics.feature('pp1').feature('singlephase4').set('include_derivatives', 'yes');
model.thermodynamics.feature('pp1').feature.create('singlephase5', 'OnePhaseProperty');
model.thermodynamics.feature('pp1').feature('singlephase5').label('Gibbs free energy of formation 2');
model.thermodynamics.feature('pp1').feature('singlephase5').set('funcname', 'GibbsEnergyF_ethene_Vapor15');
model.thermodynamics.feature('pp1').feature('singlephase5').set('property', 'GibbsEnergyF');
model.thermodynamics.feature('pp1').feature('singlephase5').set('propertydescr', 'Gibbs free energy of formation');
model.thermodynamics.feature('pp1').feature('singlephase5').set('unit', 'J/mol');
model.thermodynamics.feature('pp1').feature('singlephase5').set('prop_basis', 'mole');
model.thermodynamics.feature('pp1').feature('singlephase5').set('compounds', {'ethene'});
model.thermodynamics.feature('pp1').feature('singlephase5').set('args', {'temperature' 'K' 'Temperature'; 'pressure' 'Pa' 'Pressure'});
model.thermodynamics.feature('pp1').feature('singlephase5').set('plotargs', {'temperature' '298.15' '373.15'; 'pressure' '101325' '101325'});
model.thermodynamics.feature('pp1').feature('singlephase5').set('derivatives', {'GibbsEnergyF_ethene_Vapor15_Dtemperature' 'GibbsEnergyF_ethene_Vapor15_Dpressure'});
model.thermodynamics.feature('pp1').feature('singlephase5').set('SecondDerivatives', {});
model.thermodynamics.feature('pp1').feature('singlephase5').set('SecondDerivativeIndices', {});
model.thermodynamics.feature('pp1').feature('singlephase5').set('phase', 'Vapor');
model.thermodynamics.feature('pp1').feature('singlephase5').set('comp_basis', 'mole');
model.thermodynamics.feature('pp1').feature('singlephase5').set('include_derivatives', 'yes');
model.thermodynamics.feature('pp1').feature.create('singlephase6', 'OnePhaseProperty');
model.thermodynamics.feature('pp1').feature('singlephase6').label('Fugacity coefficient 2');
model.thermodynamics.feature('pp1').feature('singlephase6').set('funcname', 'FugacityCoefficient_ethene_Vapor16');
model.thermodynamics.feature('pp1').feature('singlephase6').set('property', 'FugacityCoefficient');
model.thermodynamics.feature('pp1').feature('singlephase6').set('propertydescr', 'Fugacity coefficient');
model.thermodynamics.feature('pp1').feature('singlephase6').set('unit', '1');
model.thermodynamics.feature('pp1').feature('singlephase6').set('prop_basis', 'mole');
model.thermodynamics.feature('pp1').feature('singlephase6').set('compounds', {'ethene'});
model.thermodynamics.feature('pp1').feature('singlephase6').set('args', {'temperature' 'K' 'Temperature'; 'pressure' 'Pa' 'Pressure'});
model.thermodynamics.feature('pp1').feature('singlephase6').set('plotargs', {'temperature' '298.15' '373.15'; 'pressure' '101325' '101325'});
model.thermodynamics.feature('pp1').feature('singlephase6').set('derivatives', {'FugacityCoefficient_ethene_Vapor16_Dtemperature' 'FugacityCoefficient_ethene_Vapor16_Dpressure'});
model.thermodynamics.feature('pp1').feature('singlephase6').set('SecondDerivatives', {});
model.thermodynamics.feature('pp1').feature('singlephase6').set('SecondDerivativeIndices', {});
model.thermodynamics.feature('pp1').feature('singlephase6').set('phase', 'Vapor');
model.thermodynamics.feature('pp1').feature('singlephase6').set('comp_basis', 'mole');
model.thermodynamics.feature('pp1').feature('singlephase6').set('include_derivatives', 'yes');
model.thermodynamics.feature('pp1').feature.create('singlephase7', 'OnePhaseProperty');
model.thermodynamics.feature('pp1').feature('singlephase7').label('Enthalpy of formation 3');
model.thermodynamics.feature('pp1').feature('singlephase7').set('funcname', 'EnthalpyF_nitrogen_Vapor17');
model.thermodynamics.feature('pp1').feature('singlephase7').set('property', 'EnthalpyF');
model.thermodynamics.feature('pp1').feature('singlephase7').set('propertydescr', 'Enthalpy of formation');
model.thermodynamics.feature('pp1').feature('singlephase7').set('unit', 'J/mol');
model.thermodynamics.feature('pp1').feature('singlephase7').set('prop_basis', 'mole');
model.thermodynamics.feature('pp1').feature('singlephase7').set('compounds', {'nitrogen'});
model.thermodynamics.feature('pp1').feature('singlephase7').set('args', {'temperature' 'K' 'Temperature'; 'pressure' 'Pa' 'Pressure'});
model.thermodynamics.feature('pp1').feature('singlephase7').set('plotargs', {'temperature' '298.15' '373.15'; 'pressure' '101325' '101325'});
model.thermodynamics.feature('pp1').feature('singlephase7').set('derivatives', {'EnthalpyF_nitrogen_Vapor17_Dtemperature' 'EnthalpyF_nitrogen_Vapor17_Dpressure'});
model.thermodynamics.feature('pp1').feature('singlephase7').set('SecondDerivatives', {});
model.thermodynamics.feature('pp1').feature('singlephase7').set('SecondDerivativeIndices', {});
model.thermodynamics.feature('pp1').feature('singlephase7').set('phase', 'Vapor');
model.thermodynamics.feature('pp1').feature('singlephase7').set('comp_basis', 'mole');
model.thermodynamics.feature('pp1').feature('singlephase7').set('include_derivatives', 'yes');
model.thermodynamics.feature('pp1').feature.create('singlephase8', 'OnePhaseProperty');
model.thermodynamics.feature('pp1').feature('singlephase8').label('Gibbs free energy of formation 3');
model.thermodynamics.feature('pp1').feature('singlephase8').set('funcname', 'GibbsEnergyF_nitrogen_Vapor18');
model.thermodynamics.feature('pp1').feature('singlephase8').set('property', 'GibbsEnergyF');
model.thermodynamics.feature('pp1').feature('singlephase8').set('propertydescr', 'Gibbs free energy of formation');
model.thermodynamics.feature('pp1').feature('singlephase8').set('unit', 'J/mol');
model.thermodynamics.feature('pp1').feature('singlephase8').set('prop_basis', 'mole');
model.thermodynamics.feature('pp1').feature('singlephase8').set('compounds', {'nitrogen'});
model.thermodynamics.feature('pp1').feature('singlephase8').set('args', {'temperature' 'K' 'Temperature'; 'pressure' 'Pa' 'Pressure'});
model.thermodynamics.feature('pp1').feature('singlephase8').set('plotargs', {'temperature' '298.15' '373.15'; 'pressure' '101325' '101325'});
model.thermodynamics.feature('pp1').feature('singlephase8').set('derivatives', {'GibbsEnergyF_nitrogen_Vapor18_Dtemperature' 'GibbsEnergyF_nitrogen_Vapor18_Dpressure'});
model.thermodynamics.feature('pp1').feature('singlephase8').set('SecondDerivatives', {});
model.thermodynamics.feature('pp1').feature('singlephase8').set('SecondDerivativeIndices', {});
model.thermodynamics.feature('pp1').feature('singlephase8').set('phase', 'Vapor');
model.thermodynamics.feature('pp1').feature('singlephase8').set('comp_basis', 'mole');
model.thermodynamics.feature('pp1').feature('singlephase8').set('include_derivatives', 'yes');
model.thermodynamics.feature('pp1').feature.create('singlephase9', 'OnePhaseProperty');
model.thermodynamics.feature('pp1').feature('singlephase9').label('Fugacity coefficient 3');
model.thermodynamics.feature('pp1').feature('singlephase9').set('funcname', 'FugacityCoefficient_nitrogen_Vapor19');
model.thermodynamics.feature('pp1').feature('singlephase9').set('property', 'FugacityCoefficient');
model.thermodynamics.feature('pp1').feature('singlephase9').set('propertydescr', 'Fugacity coefficient');
model.thermodynamics.feature('pp1').feature('singlephase9').set('unit', '1');
model.thermodynamics.feature('pp1').feature('singlephase9').set('prop_basis', 'mole');
model.thermodynamics.feature('pp1').feature('singlephase9').set('compounds', {'nitrogen'});
model.thermodynamics.feature('pp1').feature('singlephase9').set('args', {'temperature' 'K' 'Temperature'; 'pressure' 'Pa' 'Pressure'});
model.thermodynamics.feature('pp1').feature('singlephase9').set('plotargs', {'temperature' '298.15' '373.15'; 'pressure' '101325' '101325'});
model.thermodynamics.feature('pp1').feature('singlephase9').set('derivatives', {'FugacityCoefficient_nitrogen_Vapor19_Dtemperature' 'FugacityCoefficient_nitrogen_Vapor19_Dpressure'});
model.thermodynamics.feature('pp1').feature('singlephase9').set('SecondDerivatives', {});
model.thermodynamics.feature('pp1').feature('singlephase9').set('SecondDerivativeIndices', {});
model.thermodynamics.feature('pp1').feature('singlephase9').set('phase', 'Vapor');
model.thermodynamics.feature('pp1').feature('singlephase9').set('comp_basis', 'mole');
model.thermodynamics.feature('pp1').feature('singlephase9').set('include_derivatives', 'yes');
model.thermodynamics.feature('pp1').feature.create('singlephase10', 'OnePhaseProperty');
model.thermodynamics.feature('pp1').feature('singlephase10').label('Enthalpy of formation 4');
model.thermodynamics.feature('pp1').feature('singlephase10').set('funcname', 'EnthalpyF_water_Vapor110');
model.thermodynamics.feature('pp1').feature('singlephase10').set('property', 'EnthalpyF');
model.thermodynamics.feature('pp1').feature('singlephase10').set('propertydescr', 'Enthalpy of formation');
model.thermodynamics.feature('pp1').feature('singlephase10').set('unit', 'J/mol');
model.thermodynamics.feature('pp1').feature('singlephase10').set('prop_basis', 'mole');
model.thermodynamics.feature('pp1').feature('singlephase10').set('compounds', {'water'});
model.thermodynamics.feature('pp1').feature('singlephase10').set('args', {'temperature' 'K' 'Temperature'; 'pressure' 'Pa' 'Pressure'});
model.thermodynamics.feature('pp1').feature('singlephase10').set('plotargs', {'temperature' '298.15' '373.15'; 'pressure' '101325' '101325'});
model.thermodynamics.feature('pp1').feature('singlephase10').set('derivatives', {'EnthalpyF_water_Vapor110_Dtemperature' 'EnthalpyF_water_Vapor110_Dpressure'});
model.thermodynamics.feature('pp1').feature('singlephase10').set('SecondDerivatives', {});
model.thermodynamics.feature('pp1').feature('singlephase10').set('SecondDerivativeIndices', {});
model.thermodynamics.feature('pp1').feature('singlephase10').set('phase', 'Vapor');
model.thermodynamics.feature('pp1').feature('singlephase10').set('comp_basis', 'mole');
model.thermodynamics.feature('pp1').feature('singlephase10').set('include_derivatives', 'yes');
model.thermodynamics.feature('pp1').feature.create('singlephase11', 'OnePhaseProperty');
model.thermodynamics.feature('pp1').feature('singlephase11').label('Gibbs free energy of formation 4');
model.thermodynamics.feature('pp1').feature('singlephase11').set('funcname', 'GibbsEnergyF_water_Vapor111');
model.thermodynamics.feature('pp1').feature('singlephase11').set('property', 'GibbsEnergyF');
model.thermodynamics.feature('pp1').feature('singlephase11').set('propertydescr', 'Gibbs free energy of formation');
model.thermodynamics.feature('pp1').feature('singlephase11').set('unit', 'J/mol');
model.thermodynamics.feature('pp1').feature('singlephase11').set('prop_basis', 'mole');
model.thermodynamics.feature('pp1').feature('singlephase11').set('compounds', {'water'});
model.thermodynamics.feature('pp1').feature('singlephase11').set('args', {'temperature' 'K' 'Temperature'; 'pressure' 'Pa' 'Pressure'});
model.thermodynamics.feature('pp1').feature('singlephase11').set('plotargs', {'temperature' '298.15' '373.15'; 'pressure' '101325' '101325'});
model.thermodynamics.feature('pp1').feature('singlephase11').set('derivatives', {'GibbsEnergyF_water_Vapor111_Dtemperature' 'GibbsEnergyF_water_Vapor111_Dpressure'});
model.thermodynamics.feature('pp1').feature('singlephase11').set('SecondDerivatives', {});
model.thermodynamics.feature('pp1').feature('singlephase11').set('SecondDerivativeIndices', {});
model.thermodynamics.feature('pp1').feature('singlephase11').set('phase', 'Vapor');
model.thermodynamics.feature('pp1').feature('singlephase11').set('comp_basis', 'mole');
model.thermodynamics.feature('pp1').feature('singlephase11').set('include_derivatives', 'yes');
model.thermodynamics.feature('pp1').feature.create('singlephase12', 'OnePhaseProperty');
model.thermodynamics.feature('pp1').feature('singlephase12').label('Fugacity coefficient 4');
model.thermodynamics.feature('pp1').feature('singlephase12').set('funcname', 'FugacityCoefficient_water_Vapor112');
model.thermodynamics.feature('pp1').feature('singlephase12').set('property', 'FugacityCoefficient');
model.thermodynamics.feature('pp1').feature('singlephase12').set('propertydescr', 'Fugacity coefficient');
model.thermodynamics.feature('pp1').feature('singlephase12').set('unit', '1');
model.thermodynamics.feature('pp1').feature('singlephase12').set('prop_basis', 'mole');
model.thermodynamics.feature('pp1').feature('singlephase12').set('compounds', {'water'});
model.thermodynamics.feature('pp1').feature('singlephase12').set('args', {'temperature' 'K' 'Temperature'; 'pressure' 'Pa' 'Pressure'});
model.thermodynamics.feature('pp1').feature('singlephase12').set('plotargs', {'temperature' '298.15' '373.15'; 'pressure' '101325' '101325'});
model.thermodynamics.feature('pp1').feature('singlephase12').set('derivatives', {'FugacityCoefficient_water_Vapor112_Dtemperature' 'FugacityCoefficient_water_Vapor112_Dpressure'});
model.thermodynamics.feature('pp1').feature('singlephase12').set('SecondDerivatives', {});
model.thermodynamics.feature('pp1').feature('singlephase12').set('SecondDerivativeIndices', {});
model.thermodynamics.feature('pp1').feature('singlephase12').set('phase', 'Vapor');
model.thermodynamics.feature('pp1').feature('singlephase12').set('comp_basis', 'mole');
model.thermodynamics.feature('pp1').feature('singlephase12').set('include_derivatives', 'yes');
model.thermodynamics.feature('pp1').set('WarningState', false);
model.thermodynamics.feature('pp1').set('Warning', {''});
model.thermodynamics.feature('pp1').feature.create('singlephase13', 'OnePhaseProperty');
model.thermodynamics.feature('pp1').feature('singlephase13').label('Fugacity coefficient 5');
model.thermodynamics.feature('pp1').feature('singlephase13').set('funcname', 'FugacityCoefficient_ethanol_ethene_nitrogen_water_Vapor_Vapor113');
model.thermodynamics.feature('pp1').feature('singlephase13').set('property', 'FugacityCoefficient[ethanol]');
model.thermodynamics.feature('pp1').feature('singlephase13').set('propertydescr', 'Fugacity coefficient [ethanol]');
model.thermodynamics.feature('pp1').feature('singlephase13').set('unit', '1');
model.thermodynamics.feature('pp1').feature('singlephase13').set('prop_basis', 'mole');
model.thermodynamics.feature('pp1').feature('singlephase13').set('compounds', {'ethanol' 'ethene' 'nitrogen' 'water'});
model.thermodynamics.feature('pp1').feature('singlephase13').set('args', {'temperature' 'K' 'Temperature';  ...
'pressure' 'Pa' 'Pressure';  ...
'molefraction_ethanol' '1' 'Mole fraction ethanol';  ...
'molefraction_ethene' '1' 'Mole fraction ethene';  ...
'molefraction_nitrogen' '1' 'Mole fraction nitrogen';  ...
'molefraction_water' '1' 'Mole fraction water'});
model.thermodynamics.feature('pp1').feature('singlephase13').set('plotargs', {'temperature' '298.15' '373.15';  ...
'pressure' '101325' '101325';  ...
'molefraction_ethanol' '0.25' '0.25';  ...
'molefraction_ethene' '0.25' '0.25';  ...
'molefraction_nitrogen' '0.25' '0.25';  ...
'molefraction_water' '0.25' '0.25'});
model.thermodynamics.feature('pp1').feature('singlephase13').set('derivatives', {'FugacityCoefficient_ethanol_ethene_nitrogen_water_Vapor_Vapor113_Dtemperature' 'FugacityCoefficient_ethanol_ethene_nitrogen_water_Vapor_Vapor113_Dpressure' 'FugacityCoefficient_ethanol_ethene_nitrogen_water_Vapor_Vapor113_Dmolefraction_ethanol' 'FugacityCoefficient_ethanol_ethene_nitrogen_water_Vapor_Vapor113_Dmolefraction_ethene' 'FugacityCoefficient_ethanol_ethene_nitrogen_water_Vapor_Vapor113_Dmolefraction_nitrogen' 'FugacityCoefficient_ethanol_ethene_nitrogen_water_Vapor_Vapor113_Dmolefraction_water'});
model.thermodynamics.feature('pp1').feature('singlephase13').set('SecondDerivatives', {});
model.thermodynamics.feature('pp1').feature('singlephase13').set('SecondDerivativeIndices', {});
model.thermodynamics.feature('pp1').feature('singlephase13').set('phase', 'Vapor');
model.thermodynamics.feature('pp1').feature('singlephase13').set('comp_basis', 'mole');
model.thermodynamics.feature('pp1').feature('singlephase13').set('include_derivatives', 'yes');
model.thermodynamics.feature('pp1').feature.create('singlephase14', 'OnePhaseProperty');
model.thermodynamics.feature('pp1').feature('singlephase14').label('Fugacity coefficient 6');
model.thermodynamics.feature('pp1').feature('singlephase14').set('funcname', 'FugacityCoefficient_ethanol_ethene_nitrogen_water_Vapor_Vapor114');
model.thermodynamics.feature('pp1').feature('singlephase14').set('property', 'FugacityCoefficient[ethene]');
model.thermodynamics.feature('pp1').feature('singlephase14').set('propertydescr', 'Fugacity coefficient [ethene]');
model.thermodynamics.feature('pp1').feature('singlephase14').set('unit', '1');
model.thermodynamics.feature('pp1').feature('singlephase14').set('prop_basis', 'mole');
model.thermodynamics.feature('pp1').feature('singlephase14').set('compounds', {'ethanol' 'ethene' 'nitrogen' 'water'});
model.thermodynamics.feature('pp1').feature('singlephase14').set('args', {'temperature' 'K' 'Temperature';  ...
'pressure' 'Pa' 'Pressure';  ...
'molefraction_ethanol' '1' 'Mole fraction ethanol';  ...
'molefraction_ethene' '1' 'Mole fraction ethene';  ...
'molefraction_nitrogen' '1' 'Mole fraction nitrogen';  ...
'molefraction_water' '1' 'Mole fraction water'});
model.thermodynamics.feature('pp1').feature('singlephase14').set('plotargs', {'temperature' '298.15' '373.15';  ...
'pressure' '101325' '101325';  ...
'molefraction_ethanol' '0.25' '0.25';  ...
'molefraction_ethene' '0.25' '0.25';  ...
'molefraction_nitrogen' '0.25' '0.25';  ...
'molefraction_water' '0.25' '0.25'});
model.thermodynamics.feature('pp1').feature('singlephase14').set('derivatives', {'FugacityCoefficient_ethanol_ethene_nitrogen_water_Vapor_Vapor114_Dtemperature' 'FugacityCoefficient_ethanol_ethene_nitrogen_water_Vapor_Vapor114_Dpressure' 'FugacityCoefficient_ethanol_ethene_nitrogen_water_Vapor_Vapor114_Dmolefraction_ethanol' 'FugacityCoefficient_ethanol_ethene_nitrogen_water_Vapor_Vapor114_Dmolefraction_ethene' 'FugacityCoefficient_ethanol_ethene_nitrogen_water_Vapor_Vapor114_Dmolefraction_nitrogen' 'FugacityCoefficient_ethanol_ethene_nitrogen_water_Vapor_Vapor114_Dmolefraction_water'});
model.thermodynamics.feature('pp1').feature('singlephase14').set('SecondDerivatives', {});
model.thermodynamics.feature('pp1').feature('singlephase14').set('SecondDerivativeIndices', {});
model.thermodynamics.feature('pp1').feature('singlephase14').set('phase', 'Vapor');
model.thermodynamics.feature('pp1').feature('singlephase14').set('comp_basis', 'mole');
model.thermodynamics.feature('pp1').feature('singlephase14').set('include_derivatives', 'yes');
model.thermodynamics.feature('pp1').feature.create('singlephase15', 'OnePhaseProperty');
model.thermodynamics.feature('pp1').feature('singlephase15').label('Fugacity coefficient 7');
model.thermodynamics.feature('pp1').feature('singlephase15').set('funcname', 'FugacityCoefficient_ethanol_ethene_nitrogen_water_Vapor_Vapor115');
model.thermodynamics.feature('pp1').feature('singlephase15').set('property', 'FugacityCoefficient[nitrogen]');
model.thermodynamics.feature('pp1').feature('singlephase15').set('propertydescr', 'Fugacity coefficient [nitrogen]');
model.thermodynamics.feature('pp1').feature('singlephase15').set('unit', '1');
model.thermodynamics.feature('pp1').feature('singlephase15').set('prop_basis', 'mole');
model.thermodynamics.feature('pp1').feature('singlephase15').set('compounds', {'ethanol' 'ethene' 'nitrogen' 'water'});
model.thermodynamics.feature('pp1').feature('singlephase15').set('args', {'temperature' 'K' 'Temperature';  ...
'pressure' 'Pa' 'Pressure';  ...
'molefraction_ethanol' '1' 'Mole fraction ethanol';  ...
'molefraction_ethene' '1' 'Mole fraction ethene';  ...
'molefraction_nitrogen' '1' 'Mole fraction nitrogen';  ...
'molefraction_water' '1' 'Mole fraction water'});
model.thermodynamics.feature('pp1').feature('singlephase15').set('plotargs', {'temperature' '298.15' '373.15';  ...
'pressure' '101325' '101325';  ...
'molefraction_ethanol' '0.25' '0.25';  ...
'molefraction_ethene' '0.25' '0.25';  ...
'molefraction_nitrogen' '0.25' '0.25';  ...
'molefraction_water' '0.25' '0.25'});
model.thermodynamics.feature('pp1').feature('singlephase15').set('derivatives', {'FugacityCoefficient_ethanol_ethene_nitrogen_water_Vapor_Vapor115_Dtemperature' 'FugacityCoefficient_ethanol_ethene_nitrogen_water_Vapor_Vapor115_Dpressure' 'FugacityCoefficient_ethanol_ethene_nitrogen_water_Vapor_Vapor115_Dmolefraction_ethanol' 'FugacityCoefficient_ethanol_ethene_nitrogen_water_Vapor_Vapor115_Dmolefraction_ethene' 'FugacityCoefficient_ethanol_ethene_nitrogen_water_Vapor_Vapor115_Dmolefraction_nitrogen' 'FugacityCoefficient_ethanol_ethene_nitrogen_water_Vapor_Vapor115_Dmolefraction_water'});
model.thermodynamics.feature('pp1').feature('singlephase15').set('SecondDerivatives', {});
model.thermodynamics.feature('pp1').feature('singlephase15').set('SecondDerivativeIndices', {});
model.thermodynamics.feature('pp1').feature('singlephase15').set('phase', 'Vapor');
model.thermodynamics.feature('pp1').feature('singlephase15').set('comp_basis', 'mole');
model.thermodynamics.feature('pp1').feature('singlephase15').set('include_derivatives', 'yes');
model.thermodynamics.feature('pp1').feature.create('singlephase16', 'OnePhaseProperty');
model.thermodynamics.feature('pp1').feature('singlephase16').label('Fugacity coefficient 8');
model.thermodynamics.feature('pp1').feature('singlephase16').set('funcname', 'FugacityCoefficient_ethanol_ethene_nitrogen_water_Vapor_Vapor116');
model.thermodynamics.feature('pp1').feature('singlephase16').set('property', 'FugacityCoefficient[water]');
model.thermodynamics.feature('pp1').feature('singlephase16').set('propertydescr', 'Fugacity coefficient [water]');
model.thermodynamics.feature('pp1').feature('singlephase16').set('unit', '1');
model.thermodynamics.feature('pp1').feature('singlephase16').set('prop_basis', 'mole');
model.thermodynamics.feature('pp1').feature('singlephase16').set('compounds', {'ethanol' 'ethene' 'nitrogen' 'water'});
model.thermodynamics.feature('pp1').feature('singlephase16').set('args', {'temperature' 'K' 'Temperature';  ...
'pressure' 'Pa' 'Pressure';  ...
'molefraction_ethanol' '1' 'Mole fraction ethanol';  ...
'molefraction_ethene' '1' 'Mole fraction ethene';  ...
'molefraction_nitrogen' '1' 'Mole fraction nitrogen';  ...
'molefraction_water' '1' 'Mole fraction water'});
model.thermodynamics.feature('pp1').feature('singlephase16').set('plotargs', {'temperature' '298.15' '373.15';  ...
'pressure' '101325' '101325';  ...
'molefraction_ethanol' '0.25' '0.25';  ...
'molefraction_ethene' '0.25' '0.25';  ...
'molefraction_nitrogen' '0.25' '0.25';  ...
'molefraction_water' '0.25' '0.25'});
model.thermodynamics.feature('pp1').feature('singlephase16').set('derivatives', {'FugacityCoefficient_ethanol_ethene_nitrogen_water_Vapor_Vapor116_Dtemperature' 'FugacityCoefficient_ethanol_ethene_nitrogen_water_Vapor_Vapor116_Dpressure' 'FugacityCoefficient_ethanol_ethene_nitrogen_water_Vapor_Vapor116_Dmolefraction_ethanol' 'FugacityCoefficient_ethanol_ethene_nitrogen_water_Vapor_Vapor116_Dmolefraction_ethene' 'FugacityCoefficient_ethanol_ethene_nitrogen_water_Vapor_Vapor116_Dmolefraction_nitrogen' 'FugacityCoefficient_ethanol_ethene_nitrogen_water_Vapor_Vapor116_Dmolefraction_water'});
model.thermodynamics.feature('pp1').feature('singlephase16').set('SecondDerivatives', {});
model.thermodynamics.feature('pp1').feature('singlephase16').set('SecondDerivativeIndices', {});
model.thermodynamics.feature('pp1').feature('singlephase16').set('phase', 'Vapor');
model.thermodynamics.feature('pp1').feature('singlephase16').set('comp_basis', 'mole');
model.thermodynamics.feature('pp1').feature('singlephase16').set('include_derivatives', 'yes');
model.thermodynamics.feature('pp1').set('WarningState', false);
model.thermodynamics.feature('pp1').set('Warning', {''});
model.thermodynamics.feature('pp1').feature('singlephase3').set('funcname', 'FugacityCoefficientPure_C2H5OH');
model.thermodynamics.feature('pp1').feature('singlephase6').set('funcname', 'FugacityCoefficientPure_C2H4');
model.thermodynamics.feature('pp1').feature('singlephase9').set('funcname', 'FugacityCoefficientPure_N2');
model.thermodynamics.feature('pp1').feature('singlephase12').set('funcname', 'FugacityCoefficientPure_H2O');
model.thermodynamics.feature('pp1').feature('singlephase13').set('funcname', 'FugacityCoefficientMix_C2H5OH');
model.thermodynamics.feature('pp1').feature('singlephase14').set('funcname', 'FugacityCoefficientMix_C2H4');
model.thermodynamics.feature('pp1').feature('singlephase15').set('funcname', 'FugacityCoefficientMix_N2');
model.thermodynamics.feature('pp1').feature('singlephase16').set('funcname', 'FugacityCoefficientMix_H2O');
model.thermodynamics.feature('pp1').feature.create('flashcalc1', 'FlashCalculationProperty');
model.thermodynamics.feature('pp1').feature.remove('flashcalc1');
model.thermodynamics.feature('pp1').feature.create('flashcalc1', 'FlashCalculationProperty');
model.thermodynamics.feature('pp1').feature('flashcalc1').set('funcname', 'flashcalc1');
model.thermodynamics.feature('pp1').feature('flashcalc1').set('property', 'FlashCalculationProperty');
model.thermodynamics.feature('pp1').feature('flashcalc1').set('propertydescr', 'Equilibrium calculation');
model.thermodynamics.feature('pp1').feature('flashcalc1').set('dvars', {'0' '0' '0' '0' '0' '0'});
model.thermodynamics.feature('pp1').feature('flashcalc1').set('compounds', {'ethanol' 'ethene' 'nitrogen' 'water'});
model.thermodynamics.feature('pp1').feature('flashcalc1').set('functions', {'Flash1_1_PhaseExist_Vapor' '1' 'Presence of Vapor phase';  ...
'Flash1_1_PhaseExist_Liquid' '1' 'Presence of Liquid phase';  ...
'Flash1_1_PhaseAmount_Vapor' 'mol' 'Amount in Vapor phase';  ...
'Flash1_1_PhaseAmount_Liquid' 'mol' 'Amount in Liquid phase';  ...
'Flash1_1_PhaseComposition_Vapor_ethanol' 'mol/mol' 'Fraction of ethanol in Vapor phase';  ...
'Flash1_1_PhaseComposition_Vapor_ethene' 'mol/mol' 'Fraction of ethene in Vapor phase';  ...
'Flash1_1_PhaseComposition_Vapor_nitrogen' 'mol/mol' 'Fraction of nitrogen in Vapor phase';  ...
'Flash1_1_PhaseComposition_Vapor_water' 'mol/mol' 'Fraction of water in Vapor phase';  ...
'Flash1_1_PhaseComposition_Liquid_ethanol' 'mol/mol' 'Fraction of ethanol in Liquid phase';  ...
'Flash1_1_PhaseComposition_Liquid_ethene' 'mol/mol' 'Fraction of ethene in Liquid phase';  ...
'Flash1_1_PhaseComposition_Liquid_nitrogen' 'mol/mol' 'Fraction of nitrogen in Liquid phase';  ...
'Flash1_1_PhaseComposition_Liquid_water' 'mol/mol' 'Fraction of water in Liquid phase'});
model.thermodynamics.feature('pp1').feature('flashcalc1').set('cond1', {'temperature'});
model.thermodynamics.feature('pp1').feature('flashcalc1').set('cond2', {'pressure'});
model.thermodynamics.feature('pp1').feature('flashcalc1').set('prop_basis', 'mole');
model.thermodynamics.feature('pp1').feature('flashcalc1').set('inphase', 'Flash1_1_PhaseExist');
model.thermodynamics.feature('pp1').feature('flashcalc1').set('temperature', 'Flash1_1_Temperature');
model.thermodynamics.feature('pp1').feature('flashcalc1').set('pressure', 'Flash1_1_Pressure');
model.thermodynamics.feature('pp1').feature('flashcalc1').set('amounts', 'Flash1_1_PhaseAmount');
model.thermodynamics.feature('pp1').feature('flashcalc1').set('composition', 'Flash1_1_PhaseComposition');
model.thermodynamics.feature('pp1').feature('flashcalc1').set('soltype', 'undefined');
model.thermodynamics.feature('pp1').feature('flashcalc1').set('unit', '1');
model.thermodynamics.feature('pp1').feature('flashcalc1').set('phases', {'Vapor' 'Liquid'});
model.thermodynamics.feature('pp1').feature('flashcalc1').set('args', {'temperature' 'K' 'Temperature';  ...
'pressure' 'Pa' 'Pressure';  ...
'ethanol' 'mol' 'Amount ethanol';  ...
'ethene' 'mol' 'Amount ethene';  ...
'nitrogen' 'mol' 'Amount nitrogen';  ...
'water' 'mol' 'Amount water'});
model.thermodynamics.feature('pp1').feature('flashcalc1').set('plotargs', {'temperature' '298.15' '373.15';  ...
'pressure' '101325' '101325';  ...
'ethanol' '1' '1';  ...
'ethene' '1' '1';  ...
'nitrogen' '1' '1';  ...
'water' '1' '1'});
model.thermodynamics.feature('pp1').feature('flashcalc1').set('derivatives', '');
model.thermodynamics.feature('pp1').feature('flashcalc1').set('SecondDerivatives', '');
model.thermodynamics.feature('pp1').feature('flashcalc1').set('SecondDerivativeIndices', '');
model.thermodynamics.feature('pp1').feature('flashcalc1').set('plotfunction', 'Flash1_1_PhaseExist_Vapor');
model.thermodynamics.feature('pp1').set('WarningState', false);
model.thermodynamics.feature('pp1').set('Warning', {''});

model.variable.create('var1');
model.variable('var1').model('comp1');

% To import content from file, use:
% model.variable('var1').loadFile('FILENAME');
model.variable('var1').set('DGrxn', 'GibbsEnergyF_ethanol_Vapor12(T,p0)-GibbsEnergyF_water_Vapor111(T,p0)-GibbsEnergyF_ethene_Vapor15(T,p0)', 'Gibbs energy of reaction at T');
model.variable('var1').set('KTr', 'exp(-DGrxn/(R*T))', 'Equilibrium constant at T');
model.variable('var1').set('DHrT', 'EnthalpyF_ethanol_Vapor11(T,p0)-EnthalpyF_water_Vapor110(T,p0)-EnthalpyF_ethene_Vapor14(T,p0)', 'Heat of reaction at T');
model.variable('var1').set('DGrT0', 'GibbsEnergyF_ethanol_Vapor12(T0,p0)-GibbsEnergyF_water_Vapor111(T0,p0)-GibbsEnergyF_ethene_Vapor15(T0,p0)', 'Gibbs energy of reaction at T0');
model.variable('var1').set('DHrT0', 'EnthalpyF_ethanol_Vapor11(T0,p0)-EnthalpyF_water_Vapor110(T0,p0)-EnthalpyF_ethene_Vapor14(T0,p0)', 'Heat of reaction at T0');
model.variable('var1').set('KT0', 'exp(-DGrT0/(R*T0))', 'Equilibrium constant at T0');
model.variable('var1').set('KTa', 'KT0*exp(-DHrT0/R*(1/T-1/T0))', 'Approximate equilibrium constant at T');
model.variable('var1').set('PKT', 'if(Hcon<1,KTa*p/p0,KTr*p/p0)', 'P (bar) times KT');
model.variable('var1').set('KT', 'if(Hcon<1,KTa,KTr)', 'Equilibrium constant used');
model.variable('var1').set('DHrxn', 'if(Hcon<1,DHrT0,DHrT)', 'Heat of reaction used');
model.variable('var1').set('MPHI', 'FugacityCoefficientMix_C2H5OH(T,p,re.m_C2H4,re.m_H2O,re.m_C2H5OH,re.m_N2)/(FugacityCoefficientMix_C2H4(T,p,re.m_C2H4,re.m_H2O,re.m_C2H5OH,re.m_N2)*FugacityCoefficientMix_H2O(T,p,re.m_C2H4,re.m_H2O,re.m_C2H5OH,re.m_N2))', 'Mixture fugacity coefficient product');
model.variable('var1').set('ISPHI', 'FugacityCoefficientPure_C2H5OH(T,p)/(FugacityCoefficientPure_C2H4(T,p)*FugacityCoefficientPure_H2O(T,p))', 'Ideal solution fugacity coefficient product');
model.variable('var1').set('PHI', 'if(PHIcon>1,MPHI,if(PHIcon<1,1,ISPHI))', 'Fugacity coefficient product');

model.physics('re').create('rch1', 'ReactionChem', -1);
model.physics('re').feature('rch1').set('formula', 'C2H4+H2O<=>C2H5OH');
model.physics('re').feature('rch1').set('setKeq0', true);
model.physics('re').feature('rch1').set('Keq0', 'PKT/re.csum/PHI*1[mol/m^3]');
model.physics('re').create('spec1', 'SpeciesChem', -1);
model.physics('re').feature('spec1').set('specName', 'N2');
model.physics('re').feature('inits1').setIndex('initialValue', 'n0C2H4', 0, 0);
model.physics('re').feature('inits1').setIndex('initialValue', 'n0C2H5OH', 1, 0);
model.physics('re').feature('inits1').setIndex('initialValue', 'n0H2O', 2, 0);
model.physics('re').feature('inits1').setIndex('initialValue', 'n0N2', 3, 0);
model.physics('re').prop('reactor').set('reactor', 'batch');
model.physics('re').prop('mixture').set('Thermodynamics', true);
model.physics('re').prop('mixture').set('psource', 'UserDefined');
model.physics('re').prop('mixture').set('p', '1[bar]');
model.physics('re').prop('SpeciesMatching').setIndex('PackageSpecies', 'ethene', 0, 0);
model.physics('re').prop('SpeciesMatching').setIndex('PackageSpecies', 'ethanol', 1, 0);
model.physics('re').prop('SpeciesMatching').setIndex('PackageSpecies', 'water', 2, 0);
model.physics('re').prop('SpeciesMatching').setIndex('PackageSpecies', 'nitrogen', 3, 0);
model.physics('re').prop('energybalance').set('energybalance', 'exclude');
model.physics('re').prop('energybalance').set('T', 'T');

model.study('std1').label('Batch Reactor Study');
model.study('std1').feature('time').set('tlist', 'range(0,0.1,50)');

model.sol.create('sol1');
model.sol('sol1').study('std1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'time');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').set('control', 'time');
model.sol('sol1').create('t1', 'Time');
model.sol('sol1').feature('t1').set('tlist', 'range(0,0.1,50)');
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
model.sol('sol1').feature('t1').create('st1', 'StopCondition');
model.sol('sol1').feature('t1').feature('st1').setIndex('stopcondarr', '', 0);
model.sol('sol1').feature('t1').feature('st1').setIndex('stopcondterminateon', 'true', 0);
model.sol('sol1').feature('t1').feature('st1').setIndex('stopcondActive', true, 0);
model.sol('sol1').feature('t1').feature('st1').setIndex('stopconddesc', 'Stop expression 1', 0);
model.sol('sol1').feature('t1').feature('st1').setIndex('stopcondarr', '', 0);
model.sol('sol1').feature('t1').feature('st1').setIndex('stopcondterminateon', 'true', 0);
model.sol('sol1').feature('t1').feature('st1').setIndex('stopcondActive', true, 0);
model.sol('sol1').feature('t1').feature('st1').setIndex('stopconddesc', 'Stop expression 1', 0);
model.sol('sol1').feature('t1').feature('st1').setIndex('stopcondarr', 'if(t<0.1,t>50,(abs(d(comp1.re.c_C2H4,t))<0.0001))', 0);
model.sol('sol1').runAll;

model.result.create('pg1', 'PlotGroup1D');
model.result('pg1').set('data', 'dset1');
model.result('pg1').create('glob1', 'Global');
model.result('pg1').feature('glob1').set('expr', {'re.c_C2H4' 're.c_H2O' 're.c_C2H5OH' 're.c_N2'});
model.result('pg1').feature('glob1').set('descr', {'Concentration' 'Concentration' 'Concentration' 'Concentration'});
model.result('pg1').feature('glob1').set('unit', {'' '' '' ''});
model.result('pg1').feature('glob1').set('expr', {'re.c_C2H4' 're.c_H2O' 're.c_C2H5OH' 're.c_N2'});
model.result('pg1').feature('glob1').set('descr', {'Concentration' 'Concentration' 'Concentration' 'Concentration'});
model.result('pg1').label('Concentration (re)');
model.result('pg1').feature('glob1').set('xdatasolnumtype', 'level1');
model.result('pg1').run;
model.result.numerical.create('gev1', 'EvalGlobal');
model.result.numerical('gev1').label('Thermodynamic Quantities');
model.result.numerical('gev1').setIndex('looplevelinput', 'last', 0);
model.result.numerical('gev1').set('expr', {});
model.result.numerical('gev1').set('descr', {});
model.result.numerical('gev1').setIndex('expr', 'T', 0);
model.result.numerical('gev1').setIndex('unit', 'K', 0);
model.result.numerical('gev1').setIndex('descr', 'Temperature', 0);
model.result.numerical('gev1').setIndex('expr', 'comp1.DHrxn', 1);
model.result.numerical('gev1').setIndex('unit', 'J/mol', 1);
model.result.numerical('gev1').setIndex('descr', 'Heat of reaction at T', 1);
model.result.numerical('gev1').setIndex('expr', 'comp1.DGrxn', 2);
model.result.numerical('gev1').setIndex('unit', 'J/mol', 2);
model.result.numerical('gev1').setIndex('descr', 'Gibbs energy of reaction at T', 2);
model.result.numerical('gev1').setIndex('expr', 'comp1.KTr', 3);
model.result.numerical('gev1').setIndex('unit', '', 3);
model.result.numerical('gev1').setIndex('descr', 'Equilibrium constant at T', 3);
model.result.numerical('gev1').setIndex('expr', 'comp1.DHrT0', 4);
model.result.numerical('gev1').setIndex('unit', 'J/mol', 4);
model.result.numerical('gev1').setIndex('descr', 'Heat of reaction at T0', 4);
model.result.numerical('gev1').setIndex('expr', 'comp1.DGrT0', 5);
model.result.numerical('gev1').setIndex('unit', 'J/mol', 5);
model.result.numerical('gev1').setIndex('descr', 'Gibbs energy of reaction at T0', 5);
model.result.numerical('gev1').setIndex('expr', 'comp1.KT0', 6);
model.result.numerical('gev1').setIndex('unit', '', 6);
model.result.numerical('gev1').setIndex('descr', 'Equilibrium constant at T0', 6);
model.result.numerical('gev1').setIndex('expr', 'comp1.KTa', 7);
model.result.numerical('gev1').setIndex('unit', '', 7);
model.result.numerical('gev1').setIndex('descr', 'Approximate equilibrium constant at T', 7);
model.result.numerical('gev1').setIndex('expr', 'comp1.KT', 8);
model.result.numerical('gev1').setIndex('unit', '', 8);
model.result.numerical('gev1').setIndex('descr', 'Equilibrium Constant Used', 8);
model.result.numerical('gev1').setIndex('expr', 'comp1.PKT', 9);
model.result.numerical('gev1').setIndex('unit', 1, 9);
model.result.numerical('gev1').setIndex('descr', 'Pressure (bar) times KT', 9);
model.result.numerical.create('gev2', 'EvalGlobal');
model.result.numerical('gev2').label('Heat of Reaction Used');
model.result.numerical('gev2').setIndex('looplevelinput', 'last', 0);
model.result.numerical('gev2').set('expr', {});
model.result.numerical('gev2').set('descr', {});
model.result.numerical('gev2').setIndex('expr', 'comp1.DHrxn', 0);
model.result.numerical('gev2').setIndex('unit', 'J/mol', 0);
model.result.numerical('gev2').setIndex('descr', 'Heat of Reaction Used', 0);
model.result.numerical.create('gev3', 'EvalGlobal');
model.result.numerical('gev3').label('Gibbs Energy of Reaction Used');
model.result.numerical('gev3').setIndex('looplevelinput', 'last', 0);
model.result.numerical('gev3').set('expr', {});
model.result.numerical('gev3').set('descr', {});
model.result.numerical('gev3').setIndex('expr', '-(log(comp1.KT)*R*T)', 0);
model.result.numerical('gev3').setIndex('unit', '', 0);
model.result.numerical('gev3').setIndex('descr', '', 0);
model.result.numerical.create('gev4', 'EvalGlobal');
model.result.numerical('gev4').label('Equilibrium Constant Used');
model.result.numerical('gev4').setIndex('looplevelinput', 'last', 0);
model.result.numerical('gev4').set('expr', {});
model.result.numerical('gev4').set('descr', {});
model.result.numerical('gev4').setIndex('expr', 'comp1.KT', 0);
model.result.numerical('gev4').setIndex('unit', '', 0);
model.result.numerical('gev4').setIndex('descr', 'Equilibrium constant at T', 0);
model.result.numerical.create('gev5', 'EvalGlobal');
model.result.numerical('gev5').label('Moles Ethylene at Equilibrium');
model.result.numerical('gev5').setIndex('looplevelinput', 'last', 0);
model.result.numerical('gev5').set('expr', {});
model.result.numerical('gev5').set('descr', {});
model.result.numerical('gev5').setIndex('expr', 're.c_C2H4*1[m3]', 0);
model.result.numerical('gev5').setIndex('unit', '', 0);
model.result.numerical('gev5').setIndex('descr', '', 0);
model.result.numerical.create('gev6', 'EvalGlobal');
model.result.numerical('gev6').label('Moles Water at Equilibrium');
model.result.numerical('gev6').setIndex('looplevelinput', 'last', 0);
model.result.numerical('gev6').set('expr', {});
model.result.numerical('gev6').set('descr', {});
model.result.numerical('gev6').setIndex('expr', 're.c_H2O*1[m3]', 0);
model.result.numerical('gev6').setIndex('unit', '', 0);
model.result.numerical('gev6').setIndex('descr', '', 0);
model.result.numerical.create('gev7', 'EvalGlobal');
model.result.numerical('gev7').label('Moles Ethanol at Equilibrium');
model.result.numerical('gev7').setIndex('looplevelinput', 'last', 0);
model.result.numerical('gev7').set('expr', {});
model.result.numerical('gev7').set('descr', {});
model.result.numerical('gev7').setIndex('expr', 're.c_C2H5OH*1[m3]', 0);
model.result.numerical('gev7').setIndex('unit', '', 0);
model.result.numerical('gev7').setIndex('descr', '', 0);
model.result.numerical.create('gev8', 'EvalGlobal');
model.result.numerical('gev8').label('Moles Nitrogen at Equilibrium');
model.result.numerical('gev8').setIndex('looplevelinput', 'last', 0);
model.result.numerical('gev8').set('expr', {});
model.result.numerical('gev8').set('descr', {});
model.result.numerical('gev8').setIndex('expr', 're.c_N2*1[m3]', 0);
model.result.numerical('gev8').setIndex('unit', '', 0);
model.result.numerical('gev8').setIndex('descr', '', 0);
model.result.numerical.create('gev9', 'EvalGlobal');
model.result.numerical('gev9').label('Total Moles at Equilibrium');
model.result.numerical('gev9').setIndex('looplevelinput', 'last', 0);
model.result.numerical('gev9').set('expr', {});
model.result.numerical('gev9').set('descr', {});
model.result.numerical('gev9').setIndex('expr', 're.csum*1[m3]', 0);
model.result.numerical('gev9').setIndex('unit', '', 0);
model.result.numerical('gev9').setIndex('descr', '', 0);
model.result.numerical.create('gev10', 'EvalGlobal');
model.result.numerical('gev10').label('Mole Fraction Ethylene at Equilibrium');
model.result.numerical('gev10').setIndex('looplevelinput', 'last', 0);
model.result.numerical('gev10').set('expr', {});
model.result.numerical('gev10').set('descr', {});
model.result.numerical('gev10').setIndex('expr', 're.m_C2H4', 0);
model.result.numerical('gev10').setIndex('unit', 1, 0);
model.result.numerical('gev10').setIndex('descr', 'Molar fraction', 0);
model.result.numerical.create('gev11', 'EvalGlobal');
model.result.numerical('gev11').label('Mole Fraction Water at Equilibrium');
model.result.numerical('gev11').setIndex('looplevelinput', 'last', 0);
model.result.numerical('gev11').set('expr', {});
model.result.numerical('gev11').set('descr', {});
model.result.numerical('gev11').setIndex('expr', 're.m_H2O', 0);
model.result.numerical('gev11').setIndex('unit', 1, 0);
model.result.numerical('gev11').setIndex('descr', 'Molar fraction', 0);
model.result.numerical.create('gev12', 'EvalGlobal');
model.result.numerical('gev12').label('Mole Fraction Ethanol at Equilibrium');
model.result.numerical('gev12').setIndex('looplevelinput', 'last', 0);
model.result.numerical('gev12').set('expr', {});
model.result.numerical('gev12').set('descr', {});
model.result.numerical('gev12').setIndex('expr', 're.m_C2H5OH', 0);
model.result.numerical('gev12').setIndex('unit', 1, 0);
model.result.numerical('gev12').setIndex('descr', 'Molar fraction', 0);
model.result.numerical.create('gev13', 'EvalGlobal');
model.result.numerical('gev13').label('Mole Fraction Nitrogen at Equilibrium');
model.result.numerical('gev13').setIndex('looplevelinput', 'last', 0);
model.result.numerical('gev13').set('expr', {});
model.result.numerical('gev13').set('descr', {});
model.result.numerical('gev13').setIndex('expr', 're.m_N2', 0);
model.result.numerical('gev13').setIndex('unit', 1, 0);
model.result.numerical('gev13').setIndex('descr', 'Molar fraction', 0);
model.result.numerical.create('gev14', 'EvalGlobal');
model.result.numerical('gev14').label('Ethylene Fugacity Coefficient');
model.result.numerical('gev14').setIndex('looplevelinput', 'last', 0);
model.result.numerical('gev14').set('expr', {});
model.result.numerical('gev14').set('descr', {});
model.result.numerical('gev14').setIndex('expr', 'if(PHIcon>1,FugacityCoefficientMix_C2H4(T,p,re.m_C2H4,re.m_H2O,re.m_C2H5OH,re.m_N2),if(PHIcon<1,1,FugacityCoefficientPure_C2H4(T,p)))', 0);
model.result.numerical('gev14').setIndex('unit', 1, 0);
model.result.numerical('gev14').setIndex('descr', '', 0);
model.result.numerical.create('gev15', 'EvalGlobal');
model.result.numerical('gev15').label('Water Fugacity Coefficient');
model.result.numerical('gev15').setIndex('looplevelinput', 'last', 0);
model.result.numerical('gev15').set('expr', {});
model.result.numerical('gev15').set('descr', {});
model.result.numerical('gev15').setIndex('expr', 'if(PHIcon>1,FugacityCoefficientMix_H2O(T,p,re.m_C2H4,re.m_H2O,re.m_C2H5OH,re.m_N2),if(PHIcon<1,1,FugacityCoefficientPure_H2O(T,p)))', 0);
model.result.numerical('gev15').setIndex('unit', 1, 0);
model.result.numerical('gev15').setIndex('descr', '', 0);
model.result.numerical.create('gev16', 'EvalGlobal');
model.result.numerical('gev16').label('Ethanol Fugacity Coefficient');
model.result.numerical('gev16').setIndex('looplevelinput', 'last', 0);
model.result.numerical('gev16').set('expr', {});
model.result.numerical('gev16').set('descr', {});
model.result.numerical('gev16').setIndex('expr', 'if(PHIcon>1,FugacityCoefficientMix_C2H5OH(T,p,re.m_C2H4,re.m_H2O,re.m_C2H5OH,re.m_N2),if(PHIcon<1,1,FugacityCoefficientPure_C2H5OH(T,p)))', 0);
model.result.numerical('gev16').setIndex('unit', 1, 0);
model.result.numerical('gev16').setIndex('descr', '', 0);
model.result.numerical.create('gev17', 'EvalGlobal');
model.result.numerical('gev17').label('Ethylene Conversion');
model.result.numerical('gev17').setIndex('looplevelinput', 'last', 0);
model.result.numerical('gev17').set('expr', {});
model.result.numerical('gev17').set('descr', {});
model.result.numerical('gev17').setIndex('expr', 'if(n0C2H4<=re.c_C2H4,0,(n0C2H4-re.c_C2H4)/n0C2H4*100)', 0);
model.result.numerical('gev17').setIndex('unit', 'mol/m^3', 0);
model.result.numerical('gev17').setIndex('descr', '', 0);
model.result.numerical.create('gev18', 'EvalGlobal');
model.result.numerical('gev18').label('Condensation');
model.result.numerical('gev18').setIndex('looplevelinput', 'last', 0);
model.result.numerical('gev18').set('expr', {});
model.result.numerical('gev18').set('descr', {});
model.result.numerical('gev18').setIndex('expr', 'Flash1_1_PhaseExist_Liquid(T,p,re.c_C2H5OH,re.c_C2H4,re.c_N2,re.c_H2O)', 0);
model.result.numerical('gev18').setIndex('unit', '', 0);
model.result.numerical('gev18').setIndex('descr', 'Equilibrium Calculation 1', 0);
model.result('pg1').run;
model.result('pg1').label('Mole Concentration (re)');
model.result('pg1').set('titletype', 'none');
model.result('pg1').set('xlabelactive', true);
model.result('pg1').set('xlabel', 'Path to Equilibrium');
model.result('pg1').set('ylabelactive', true);
model.result('pg1').set('ylabel', 'Moles');
model.result('pg1').run;
model.result('pg1').feature('glob1').set('expr', {});
model.result('pg1').feature('glob1').set('descr', {});
model.result('pg1').feature('glob1').set('expr', {'re.c_C2H5OH'});
model.result('pg1').feature('glob1').set('descr', {'Concentration'});
model.result('pg1').feature('glob1').set('linecolor', 'custom');
model.result('pg1').feature('glob1').set('customlinecolor', [0.07058823853731155 0.2235294133424759 0.9529411792755127]);
model.result('pg1').feature('glob1').set('linewidth', 2);
model.result('pg1').feature('glob1').set('legendmethod', 'manual');
model.result('pg1').feature('glob1').remove('legends', 0);
model.result('pg1').feature('glob1').setIndex('legends', 'C2H5OH', 0);
model.result('pg1').run;
model.result('pg1').create('glob2', 'Global');
model.result('pg1').feature('glob2').set('markerpos', 'datapoints');
model.result('pg1').feature('glob2').set('linewidth', 'preference');
model.result('pg1').feature('glob2').set('expr', {'re.c_H2O'});
model.result('pg1').feature('glob2').set('descr', {'Concentration'});
model.result('pg1').feature('glob2').set('unit', {'mol/m^3'});
model.result('pg1').feature('glob2').set('linecolor', 'custom');
model.result('pg1').feature('glob2').set('customlinecolor', [0.1568627506494522 0.7254902124404907 0.24313725531101227]);
model.result('pg1').feature('glob2').set('linewidth', 2);
model.result('pg1').feature('glob2').set('legendmethod', 'manual');
model.result('pg1').feature('glob2').setIndex('legends', 'H2O', 0);
model.result('pg1').run;
model.result('pg1').create('glob3', 'Global');
model.result('pg1').feature('glob3').set('markerpos', 'datapoints');
model.result('pg1').feature('glob3').set('linewidth', 'preference');
model.result('pg1').feature('glob3').set('expr', {'re.c_C2H4'});
model.result('pg1').feature('glob3').set('descr', {'Concentration'});
model.result('pg1').feature('glob3').set('unit', {'mol/m^3'});
model.result('pg1').feature('glob3').set('linestyle', 'dashed');
model.result('pg1').feature('glob3').set('linecolor', 'custom');
model.result('pg1').feature('glob3').set('customlinecolor', [0.8235294222831726 0.019607843831181526 0.019607843831181526]);
model.result('pg1').feature('glob3').set('linewidth', 2);
model.result('pg1').feature('glob3').set('legendmethod', 'manual');
model.result('pg1').feature('glob3').setIndex('legends', 'C2H4', 0);
model.result('pg1').run;
model.result('pg1').create('glob4', 'Global');
model.result('pg1').feature('glob4').set('markerpos', 'datapoints');
model.result('pg1').feature('glob4').set('linewidth', 'preference');
model.result('pg1').feature('glob4').set('expr', {'re.c_N2'});
model.result('pg1').feature('glob4').set('descr', {'Concentration'});
model.result('pg1').feature('glob4').set('unit', {'mol/m^3'});
model.result('pg1').feature('glob4').set('linecolor', 'custom');
model.result('pg1').feature('glob4').set('customlinecolor', [0.019607843831181526 0.8235294222831726 0.8313725590705872]);
model.result('pg1').feature('glob4').set('linewidth', 2);
model.result('pg1').feature('glob4').set('legendmethod', 'manual');
model.result('pg1').feature('glob4').setIndex('legends', 'N2', 0);
model.result('pg1').run;
model.result('pg1').create('glob5', 'Global');
model.result('pg1').feature('glob5').set('markerpos', 'datapoints');
model.result('pg1').feature('glob5').set('linewidth', 'preference');
model.result('pg1').feature('glob5').set('expr', {'re.csum'});
model.result('pg1').feature('glob5').set('descr', {'Total concentration'});
model.result('pg1').feature('glob5').set('unit', {'mol/m^3'});
model.result('pg1').feature('glob5').set('linecolor', 'custom');
model.result('pg1').feature('glob5').set('customlinecolor', [0.7411764860153198 0.0117647061124444 0.7411764860153198]);
model.result('pg1').feature('glob5').set('linewidth', 2);
model.result('pg1').feature('glob5').set('legendmethod', 'manual');
model.result('pg1').feature('glob5').setIndex('legends', 'Total', 0);
model.result('pg1').run;
model.result('pg1').run;
model.result.duplicate('pg2', 'pg1');
model.result('pg2').run;
model.result('pg2').label('Mole Fraction');
model.result('pg2').set('ylabel', 'Mole Fraction');
model.result('pg2').set('legendpos', 'middleright');
model.result('pg2').run;
model.result('pg2').feature('glob1').setIndex('expr', 're.m_C2H5OH', 0);
model.result('pg2').feature('glob1').setIndex('unit', 1, 0);
model.result('pg2').feature('glob1').setIndex('descr', 'Molar fraction', 0);
model.result('pg2').run;
model.result('pg2').feature('glob2').setIndex('expr', 're.m_H2O', 0);
model.result('pg2').feature('glob2').setIndex('unit', 1, 0);
model.result('pg2').feature('glob2').setIndex('descr', 'Molar fraction', 0);
model.result('pg2').run;
model.result('pg2').feature('glob3').setIndex('expr', 're.m_C2H4', 0);
model.result('pg2').feature('glob3').setIndex('unit', 1, 0);
model.result('pg2').feature('glob3').setIndex('descr', 'Molar fraction', 0);
model.result('pg2').run;
model.result('pg2').feature('glob4').setIndex('expr', 're.m_N2', 0);
model.result('pg2').feature('glob4').setIndex('unit', 1, 0);
model.result('pg2').feature('glob4').setIndex('descr', 'Molar fraction', 0);
model.result('pg2').run;
model.result('pg2').feature.remove('glob5');
model.result('pg2').run;
model.result('pg2').run;
model.result('pg2').run;
model.result.duplicate('pg3', 'pg2');
model.result('pg3').run;
model.result('pg3').label('Mixture Fugacity Coefficients');
model.result('pg3').set('ylabel', 'Fugacity Coefficient');
model.result('pg3').run;
model.result('pg3').feature('glob1').setIndex('expr', 'FugacityCoefficientMix_C2H5OH(T,p,re.m_C2H4,re.m_H2O,re.m_C2H5OH,re.m_N2)', 0);
model.result('pg3').feature('glob1').setIndex('unit', 1, 0);
model.result('pg3').feature('glob1').setIndex('descr', '', 0);
model.result('pg3').run;
model.result('pg3').feature('glob2').setIndex('expr', 'FugacityCoefficientMix_H2O(T,p,re.m_C2H4,re.m_H2O,re.m_C2H5OH,re.m_N2)', 0);
model.result('pg3').feature('glob2').setIndex('unit', 1, 0);
model.result('pg3').feature('glob2').setIndex('descr', '', 0);
model.result('pg3').run;
model.result('pg3').feature('glob3').setIndex('expr', 'FugacityCoefficientMix_C2H4(T,p,re.m_C2H4,re.m_H2O,re.m_C2H5OH,re.m_N2)', 0);
model.result('pg3').feature('glob3').setIndex('unit', 1, 0);
model.result('pg3').feature('glob3').setIndex('descr', '', 0);
model.result('pg3').feature('glob3').set('linestyle', 'solid');
model.result('pg3').run;
model.result('pg3').feature('glob4').setIndex('expr', 'FugacityCoefficientMix_N2(T,p,re.m_C2H4,re.m_H2O,re.m_C2H5OH,re.m_N2)', 0);
model.result('pg3').feature('glob4').setIndex('unit', 1, 0);
model.result('pg3').feature('glob4').setIndex('descr', '', 0);
model.result('pg3').run;
model.result('pg3').run;
model.result.duplicate('pg4', 'pg3');
model.result('pg4').run;
model.result('pg4').label('Pure Fugacity Coefficients');
model.result('pg4').run;
model.result('pg4').feature('glob1').setIndex('expr', 'FugacityCoefficientPure_C2H5OH(T,p)', 0);
model.result('pg4').feature('glob1').setIndex('unit', 1, 0);
model.result('pg4').feature('glob1').setIndex('descr', '', 0);
model.result('pg4').run;
model.result('pg4').feature('glob2').setIndex('expr', 'FugacityCoefficientPure_H2O(T,p)', 0);
model.result('pg4').feature('glob2').setIndex('unit', 1, 0);
model.result('pg4').feature('glob2').setIndex('descr', '', 0);
model.result('pg4').run;
model.result('pg4').feature('glob3').setIndex('expr', 'FugacityCoefficientPure_C2H4(T,p)', 0);
model.result('pg4').feature('glob3').setIndex('unit', 1, 0);
model.result('pg4').feature('glob3').setIndex('descr', '', 0);
model.result('pg4').run;
model.result('pg4').feature('glob4').setIndex('expr', 'FugacityCoefficientPure_N2(T,p)', 0);
model.result('pg4').feature('glob4').setIndex('unit', 1, 0);
model.result('pg4').feature('glob4').setIndex('descr', '', 0);
model.result('pg4').run;
model.result('pg1').run;
model.result.duplicate('pg5', 'pg1');
model.result('pg5').run;
model.result('pg5').label('Total Moles');
model.result('pg5').set('ylabel', 'Total Moles');
model.result('pg5').run;
model.result('pg5').feature.remove('glob1');
model.result('pg5').run;
model.result('pg5').feature.remove('glob2');
model.result('pg5').run;
model.result('pg5').feature.remove('glob3');
model.result('pg5').run;
model.result('pg5').feature.remove('glob4');
model.result('pg5').run;
model.result('pg5').run;
model.result('pg5').run;
model.result('pg1').run;
model.result.duplicate('pg6', 'pg1');
model.result('pg6').run;
model.result('pg6').label('H Atom Balance');
model.result('pg6').set('ylabel', 'Moles H Atom');
model.result('pg6').run;
model.result('pg6').feature('glob1').setIndex('expr', 're.c_C2H5OH*6', 0);
model.result('pg6').feature('glob1').setIndex('unit', 'mol/m^3', 0);
model.result('pg6').feature('glob1').setIndex('descr', '', 0);
model.result('pg6').run;
model.result('pg6').feature('glob2').setIndex('expr', 're.c_H2O*2', 0);
model.result('pg6').feature('glob2').setIndex('unit', 'mol/m^3', 0);
model.result('pg6').feature('glob2').setIndex('descr', '', 0);
model.result('pg6').run;
model.result('pg6').feature('glob3').setIndex('expr', 're.c_C2H4*4', 0);
model.result('pg6').feature('glob3').setIndex('unit', 'mol/m^3', 0);
model.result('pg6').feature('glob3').setIndex('descr', '', 0);
model.result('pg6').feature('glob3').set('linestyle', 'solid');
model.result('pg6').run;
model.result('pg6').feature.remove('glob4');
model.result('pg6').run;
model.result('pg6').feature('glob5').setIndex('expr', 're.c_C2H4*4+re.c_H2O*2+re.c_C2H5OH*6', 0);
model.result('pg6').feature('glob5').setIndex('unit', 'mol/m^3', 0);
model.result('pg6').feature('glob5').setIndex('descr', '', 0);
model.result('pg6').run;
model.result('pg6').run;
model.result.duplicate('pg7', 'pg6');
model.result('pg7').run;
model.result('pg7').label('C Atom Balance');
model.result('pg7').set('ylabel', 'Moles C Atom');
model.result('pg7').run;
model.result('pg7').feature('glob1').remove('unit', 0);
model.result('pg7').feature('glob1').remove('descr', 0);
model.result('pg7').feature('glob1').remove('expr', [0]);
model.result('pg7').feature('glob1').setIndex('expr', 're.c_C2H5OH*2', 0);
model.result('pg7').feature('glob1').setIndex('unit', 'mol/m^3', 0);
model.result('pg7').feature('glob1').setIndex('descr', '', 0);
model.result('pg7').run;
model.result('pg7').feature.remove('glob2');
model.result('pg7').run;
model.result('pg7').feature('glob3').setIndex('expr', 're.c_C2H4*2', 0);
model.result('pg7').feature('glob3').setIndex('unit', 'mol/m^3', 0);
model.result('pg7').feature('glob3').setIndex('descr', '', 0);
model.result('pg7').run;
model.result('pg7').feature('glob5').setIndex('expr', 're.c_C2H4*2+re.c_C2H5OH*2', 0);
model.result('pg7').feature('glob5').setIndex('unit', 'mol/m^3', 0);
model.result('pg7').feature('glob5').setIndex('descr', '', 0);
model.result('pg7').run;
model.result('pg6').run;
model.result.duplicate('pg8', 'pg6');
model.result('pg8').run;
model.result('pg8').label('O Atom Balance');
model.result('pg8').set('ylabel', 'Moles O Atom');
model.result('pg8').run;
model.result('pg8').feature('glob1').setIndex('expr', 're.c_C2H5OH', 0);
model.result('pg8').feature('glob1').setIndex('unit', 'mol/m^3', 0);
model.result('pg8').feature('glob1').setIndex('descr', '', 0);
model.result('pg8').run;
model.result('pg8').feature('glob2').setIndex('expr', 're.c_H2O', 0);
model.result('pg8').feature('glob2').setIndex('unit', 'mol/m^3', 0);
model.result('pg8').feature('glob2').setIndex('descr', '', 0);
model.result('pg8').run;
model.result('pg8').feature.remove('glob3');
model.result('pg8').run;
model.result('pg8').feature('glob5').setIndex('expr', 're.c_H2O+re.c_C2H5OH', 0);
model.result('pg8').feature('glob5').setIndex('unit', 'mol/m^3', 0);
model.result('pg8').feature('glob5').setIndex('descr', '', 0);
model.result('pg8').run;

model.param.set('p', '20[bar]');

model.sol('sol1').runAll;

model.result('pg1').run;
model.result('pg2').run;
model.result('pg2').run;
model.result('pg6').run;
model.result('pg6').run;

model.param.set('p', '30[bar]');

model.sol('sol1').runAll;

model.result('pg1').run;
model.result('pg3').run;
model.result('pg3').run;

model.param.set('p', '10[bar]');

model.sol('sol1').runAll;

model.result('pg1').run;
model.result('pg3').run;
model.result('pg3').run;

model.title('Reaction Equilibrium - Gas Phase Conversion of Ethylene to Ethanol');

model.description(['This application calculates the equilibrium compositions in gas phase conversion of ethylene to ethanol. It allows you to study how the initial conditions and the operating conditions affect the ethanol production.' newline  newline 'The application is designed to be used as a teaching tool, both to provide an understanding for the dynamics of a chemical equilibrium, and to show how to compute quantitative results for the equilibrium composition.']);

model.label('gas_phase_equilibrium_reaction_embedded.mph');

model.result('pg3').run;

model.setExpectedComputationTime('2 seconds');

model.result.report.create('rpt1', 'Report');
model.result.report('rpt1').set('templatesource', 'brief');
model.result.report('rpt1').set('format', 'docx');
model.result.report('rpt1').set('filename', 'user:///chemical_equilibrium.docx');
model.result.report('rpt1').feature.create('tp1', 'TitlePage');
model.result.report('rpt1').feature('tp1').set('titleimage', 'pg2');
model.result.report('rpt1').feature('tp1').set('includeauthor', false);
model.result.report('rpt1').feature('tp1').set('summary', ['This application calculates the equilibrium compositions in gas phase conversion of ethylene to ethanol. It allows you to study how the initial conditions and the operating conditions affect the ethanol production.  ' newline  newline 'The application is designed to be used as a teaching tool, both to provide an understanding for the dynamics of a chemical equilibrium, and to show how to compute quantitative results for the equilibrium composition. ']);
model.result.report('rpt1').feature('tp1').set('includeacknowledgment', false);
model.result.report('rpt1').feature.create('sec1', 'Section');
model.result.report('rpt1').feature('sec1').label('Global Definitions');
model.result.report('rpt1').feature('sec1').feature.create('root1', 'Model');
model.result.report('rpt1').feature('sec1').feature.create('sec1', 'Section');
model.result.report('rpt1').feature('sec1').feature('sec1').label('Parameters');
model.result.report('rpt1').feature('sec1').feature('sec1').feature.create('param1', 'Parameter');
model.result.report('rpt1').feature('sec1').feature('sec1').feature('param1').setIndex('children', false, 6, 1);
model.result.report('rpt1').feature('sec1').feature('sec1').feature('param1').setIndex('children', false, 7, 1);
model.result.report('rpt1').feature('sec1').feature('sec1').feature('param1').setIndex('children', false, 8, 1);
model.result.report('rpt1').feature('sec1').feature('sec1').feature('param1').setIndex('children', false, 11, 1);
model.result.report('rpt1').feature('sec1').feature('sec1').feature('param1').setIndex('children', false, 12, 1);
model.result.report('rpt1').feature('sec1').feature('sec1').feature('param1').setIndex('children', false, 13, 1);
model.result.report('rpt1').feature('sec1').feature('sec1').feature('param1').setIndex('children', false, 14, 1);
model.result.report('rpt1').feature('sec1').feature('sec1').feature('param1').setIndex('children', false, 15, 1);
model.result.report('rpt1').feature('sec1').feature('sec1').feature('param1').setIndex('children', false, 16, 1);
model.result.report('rpt1').feature('sec1').feature('sec1').feature('param1').setIndex('children', false, 17, 1);
model.result.report('rpt1').feature('sec1').feature('sec1').feature('param1').setIndex('children', false, 18, 1);
model.result.report('rpt1').feature('sec1').feature('sec1').feature('param1').setIndex('children', false, 19, 1);
model.result.report('rpt1').feature('sec1').feature('sec1').feature('param1').setIndex('children', false, 20, 1);
model.result.report('rpt1').feature('sec1').feature('sec1').feature('param1').setIndex('children', false, 21, 1);
model.result.report('rpt1').feature('sec1').feature('sec1').feature('param1').setIndex('children', false, 22, 1);
model.result.report('rpt1').feature('sec1').feature('sec1').feature('param1').setIndex('children', false, 23, 1);
model.result.report('rpt1').feature('sec1').feature('sec1').feature('param1').setIndex('children', false, 24, 1);
model.result.report('rpt1').feature('sec1').feature('sec1').feature('param1').setIndex('children', false, 25, 1);
model.result.report('rpt1').feature('sec1').feature('sec1').feature('param1').setIndex('children', false, 26, 1);
model.result.report('rpt1').feature('sec1').feature('sec1').feature('param1').setIndex('children', false, 27, 1);
model.result.report('rpt1').feature('sec1').feature('sec1').feature('param1').setIndex('children', false, 28, 1);
model.result.report('rpt1').feature('sec1').feature('sec1').feature('param1').setIndex('children', false, 29, 1);
model.result.report('rpt1').feature('sec1').feature('sec1').feature('param1').setIndex('children', false, 30, 1);
model.result.report('rpt1').feature('sec1').feature('sec1').feature('param1').setIndex('children', false, 31, 1);
model.result.report('rpt1').feature('sec1').feature('sec1').feature('param1').setIndex('children', false, 32, 1);
model.result.report('rpt1').feature('sec1').feature('sec1').feature('param1').setIndex('children', false, 33, 1);
model.result.report('rpt1').feature.create('sec2', 'Section');
model.result.report('rpt1').feature('sec2').label('Batch Reactor Study');
model.result.report('rpt1').feature('sec2').feature.create('std1', 'Study');
model.result.report('rpt1').feature.create('sec3', 'Section');
model.result.report('rpt1').feature('sec3').label('Results');
model.result.report('rpt1').feature('sec3').feature.create('sec1', 'Section');
model.result.report('rpt1').feature('sec3').feature('sec1').label('Plot Groups');
model.result.report('rpt1').feature('sec3').feature('sec1').feature.create('sec1', 'Section');
model.result.report('rpt1').feature('sec3').feature('sec1').feature('sec1').label('Moles');
model.result.report('rpt1').feature('sec3').feature('sec1').feature('sec1').set('source', 'firstchild');
model.result.report('rpt1').feature('sec3').feature('sec1').feature('sec1').feature.create('pg1', 'PlotGroup');
model.result.report('rpt1').feature('sec3').feature('sec1').feature.create('sec2', 'Section');
model.result.report('rpt1').feature('sec3').feature('sec1').feature('sec2').label('Mole Fraction');
model.result.report('rpt1').feature('sec3').feature('sec1').feature('sec2').set('source', 'firstchild');
model.result.report('rpt1').feature('sec3').feature('sec1').feature('sec2').feature.create('pg1', 'PlotGroup');
model.result.report('rpt1').feature('sec3').feature('sec1').feature('sec2').feature('pg1').set('noderef', 'pg2');
model.result.report('rpt1').feature('sec3').feature('sec1').feature.create('sec3', 'Section');
model.result.report('rpt1').feature('sec3').feature('sec1').feature('sec3').label('Mixture Fugacity Coefficients');
model.result.report('rpt1').feature('sec3').feature('sec1').feature('sec3').set('source', 'firstchild');
model.result.report('rpt1').feature('sec3').feature('sec1').feature('sec3').feature.create('pg1', 'PlotGroup');
model.result.report('rpt1').feature('sec3').feature('sec1').feature('sec3').feature('pg1').set('noderef', 'pg3');
model.result.report('rpt1').feature('sec3').feature('sec1').feature.create('sec4', 'Section');
model.result.report('rpt1').feature('sec3').feature('sec1').feature('sec4').label('Total Moles');
model.result.report('rpt1').feature('sec3').feature('sec1').feature('sec4').set('source', 'firstchild');
model.result.report('rpt1').feature('sec3').feature('sec1').feature('sec4').feature.create('pg1', 'PlotGroup');
model.result.report('rpt1').feature('sec3').feature('sec1').feature('sec4').feature('pg1').set('noderef', 'pg5');
model.result.report('rpt1').feature('sec3').feature('sec1').feature.create('sec5', 'Section');
model.result.report('rpt1').feature('sec3').feature('sec1').feature('sec5').label('Pure Fugacity Coefficients');
model.result.report('rpt1').feature('sec3').feature('sec1').feature('sec5').set('source', 'firstchild');
model.result.report('rpt1').feature('sec3').feature('sec1').feature('sec5').feature.create('pg1', 'PlotGroup');
model.result.report('rpt1').feature('sec3').feature('sec1').feature('sec5').feature('pg1').set('noderef', 'pg4');
model.result.report('rpt1').feature('sec3').feature('sec1').feature.create('sec6', 'Section');
model.result.report('rpt1').feature('sec3').feature('sec1').feature('sec6').label('H Atom Balance');
model.result.report('rpt1').feature('sec3').feature('sec1').feature('sec6').set('source', 'firstchild');
model.result.report('rpt1').feature('sec3').feature('sec1').feature('sec6').feature.create('pg1', 'PlotGroup');
model.result.report('rpt1').feature('sec3').feature('sec1').feature('sec6').feature('pg1').set('noderef', 'pg6');
model.result.report('rpt1').feature('sec3').feature('sec1').feature.create('sec7', 'Section');
model.result.report('rpt1').feature('sec3').feature('sec1').feature('sec7').label('C Atom Balance');
model.result.report('rpt1').feature('sec3').feature('sec1').feature('sec7').set('source', 'firstchild');
model.result.report('rpt1').feature('sec3').feature('sec1').feature('sec7').feature.create('pg1', 'PlotGroup');
model.result.report('rpt1').feature('sec3').feature('sec1').feature('sec7').feature('pg1').set('noderef', 'pg7');
model.result.report('rpt1').feature('sec3').feature('sec1').feature.create('sec8', 'Section');
model.result.report('rpt1').feature('sec3').feature('sec1').feature('sec8').label('O Atom Balance');
model.result.report('rpt1').feature('sec3').feature('sec1').feature('sec8').set('source', 'firstchild');
model.result.report('rpt1').feature('sec3').feature('sec1').feature('sec8').feature.create('pg1', 'PlotGroup');
model.result.report('rpt1').feature('sec3').feature('sec1').feature('sec8').feature('pg1').set('noderef', 'pg8');

model.title('Reaction Equilibrium - Gas Phase Conversion of Ethylene to Ethanol');

model.description(['This app demonstrates the following:' newline  newline  native2unicode(hex2dec({'20' '22'}), 'unicode') ' How an app can be used as a teaching tool' newline  native2unicode(hex2dec({'20' '22'}), 'unicode') ' An eight-question multiple choice quiz where the answers can be sent to the grader by email' newline  newline 'This app calculates the equilibrium compositions in gas phase conversion of ethylene to ethanol. It allows you to study how the initial conditions and the operating conditions affect the ethanol production.' newline  newline 'The app is designed to teach you how to compute quantitative results for the equilibrium composition and provide an understanding for the dynamics of a chemical equilibrium.']);

model.mesh.clearMeshes;

model.sol('sol1').clearSolutionData;

model.label('gas_phase_equilibrium_reaction.mph');

model.modelNode.label('Components');

out = model;
