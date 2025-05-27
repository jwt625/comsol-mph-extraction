function out = model
%
% pressure_reciprocity_calibration_coupler.m
%
% Model exported on May 26 2025, 21:25 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/Acoustics_Module/Tutorials,_Thermoviscous_Acoustics');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 2);
model.geom('geom1').model('comp1');
model.geom('geom1').axisymmetric(true);

model.mesh.create('mesh1', 'geom1');

model.physics.create('ta', 'ThermoacousticsSinglePhysics', 'geom1');
model.physics('ta').model('comp1');

model.study.create('std1');
model.study('std1').create('freq', 'Frequency');
model.study('std1').feature('freq').setSolveFor('/physics/ta', true);

model.param.label('Parameters - Physics');

% To import content from file, use:
% model.param.loadFile('FILENAME');
model.param.set('p0', '1[atm]', 'Ambient pressure');
model.param.set('T0', '25[degC]', 'Ambient temperature');
model.param.set('relH', '0.5', 'Relative humidity');
model.param.set('f0', '10[kHz]', 'Maximum frequency');
model.param.set('dvisc0', '0.22[mm]*sqrt(100[Hz]/100[Hz])', 'Boundary layer thickness at 100 Hz');
model.param.set('dvisc', '0.22[mm]*sqrt(100[Hz]/f0)', 'Boundary layer thickness at f0');
model.param.set('dn', '1[um]', 'Piston max displacement');
model.param.create('par2');
model.param('par2').label('Parameters - Geometry');

% To import content from file, use:
% model.param('par2').loadFile('FILENAME');
model.param('par2').set('a', '4.5[mm]', 'Coupler radius');
model.param('par2').set('L', '5[mm]', 'Coupler length');
model.param('par2').set('S', 'a^2*pi', 'Cross section area');
model.param('par2').set('A', '2*S+L*2*pi*a', 'Internal coupler surface area');
model.param('par2').set('V', 'S*L', 'Coupler volume');

model.geom('geom1').create('r1', 'Rectangle');
model.geom('geom1').feature('r1').set('size', {'a' 'L'});
model.geom('geom1').runPre('fin');
model.geom('geom1').run;

model.material.create('mat1', 'Common', 'comp1');
model.material('mat1').propertyGroup('def').func.create('eta', 'Piecewise');
model.material('mat1').propertyGroup('def').func.create('Cp', 'Piecewise');
model.material('mat1').propertyGroup('def').func.create('rho', 'Analytic');
model.material('mat1').propertyGroup('def').func.create('k', 'Piecewise');
model.material('mat1').propertyGroup('def').func.create('cs', 'Analytic');
model.material('mat1').propertyGroup('def').func.create('an1', 'Analytic');
model.material('mat1').propertyGroup('def').func.create('an2', 'Analytic');
model.material('mat1').propertyGroup.create('RefractiveIndex', 'Refractive index');
model.material('mat1').propertyGroup.create('NonlinearModel', 'Nonlinear model');
model.material('mat1').propertyGroup.create('idealGas', 'Ideal gas');
model.material('mat1').propertyGroup('idealGas').func.create('Cp', 'Piecewise');
model.material('mat1').label('Air');
model.material('mat1').set('family', 'air');
model.material('mat1').propertyGroup('def').func('eta').set('arg', 'T');
model.material('mat1').propertyGroup('def').func('eta').set('pieces', {'200.0' '1600.0' '-8.38278E-7+8.35717342E-8*T^1-7.69429583E-11*T^2+4.6437266E-14*T^3-1.06585607E-17*T^4'});
model.material('mat1').propertyGroup('def').func('eta').set('argunit', 'K');
model.material('mat1').propertyGroup('def').func('eta').set('fununit', 'Pa*s');
model.material('mat1').propertyGroup('def').func('Cp').set('arg', 'T');
model.material('mat1').propertyGroup('def').func('Cp').set('pieces', {'200.0' '1600.0' '1047.63657-0.372589265*T^1+9.45304214E-4*T^2-6.02409443E-7*T^3+1.2858961E-10*T^4'});
model.material('mat1').propertyGroup('def').func('Cp').set('argunit', 'K');
model.material('mat1').propertyGroup('def').func('Cp').set('fununit', 'J/(kg*K)');
model.material('mat1').propertyGroup('def').func('rho').set('expr', 'pA*0.02897/R_const[K*mol/J]/T');
model.material('mat1').propertyGroup('def').func('rho').set('args', {'pA' 'T'});
model.material('mat1').propertyGroup('def').func('rho').set('fununit', 'kg/m^3');
model.material('mat1').propertyGroup('def').func('rho').set('argunit', {'Pa' 'K'});
model.material('mat1').propertyGroup('def').func('rho').set('plotaxis', {'off' 'on'});
model.material('mat1').propertyGroup('def').func('rho').set('plotfixedvalue', {'101325' '273.15'});
model.material('mat1').propertyGroup('def').func('rho').set('plotargs', {'pA' '101325' '101325'; 'T' '273.15' '293.15'});
model.material('mat1').propertyGroup('def').func('k').set('arg', 'T');
model.material('mat1').propertyGroup('def').func('k').set('pieces', {'200.0' '1600.0' '-0.00227583562+1.15480022E-4*T^1-7.90252856E-8*T^2+4.11702505E-11*T^3-7.43864331E-15*T^4'});
model.material('mat1').propertyGroup('def').func('k').set('argunit', 'K');
model.material('mat1').propertyGroup('def').func('k').set('fununit', 'W/(m*K)');
model.material('mat1').propertyGroup('def').func('cs').set('expr', 'sqrt(1.4*R_const[K*mol/J]/0.02897*T)');
model.material('mat1').propertyGroup('def').func('cs').set('args', {'T'});
model.material('mat1').propertyGroup('def').func('cs').set('fununit', 'm/s');
model.material('mat1').propertyGroup('def').func('cs').set('argunit', {'K'});
model.material('mat1').propertyGroup('def').func('cs').set('plotfixedvalue', {'273.15'});
model.material('mat1').propertyGroup('def').func('cs').set('plotargs', {'T' '273.15' '373.15'});
model.material('mat1').propertyGroup('def').func('an1').set('funcname', 'alpha_p');
model.material('mat1').propertyGroup('def').func('an1').set('expr', '-1/rho(pA,T)*d(rho(pA,T),T)');
model.material('mat1').propertyGroup('def').func('an1').set('args', {'pA' 'T'});
model.material('mat1').propertyGroup('def').func('an1').set('fununit', '1/K');
model.material('mat1').propertyGroup('def').func('an1').set('argunit', {'Pa' 'K'});
model.material('mat1').propertyGroup('def').func('an1').set('plotaxis', {'off' 'on'});
model.material('mat1').propertyGroup('def').func('an1').set('plotfixedvalue', {'101325' '273.15'});
model.material('mat1').propertyGroup('def').func('an1').set('plotargs', {'pA' '101325' '101325'; 'T' '273.15' '373.15'});
model.material('mat1').propertyGroup('def').func('an2').set('funcname', 'muB');
model.material('mat1').propertyGroup('def').func('an2').set('expr', '0.6*eta(T)');
model.material('mat1').propertyGroup('def').func('an2').set('args', {'T'});
model.material('mat1').propertyGroup('def').func('an2').set('fununit', 'Pa*s');
model.material('mat1').propertyGroup('def').func('an2').set('argunit', {'K'});
model.material('mat1').propertyGroup('def').func('an2').set('plotfixedvalue', {'200'});
model.material('mat1').propertyGroup('def').func('an2').set('plotargs', {'T' '200' '1600'});
model.material('mat1').propertyGroup('def').set('thermalexpansioncoefficient', '');
model.material('mat1').propertyGroup('def').set('molarmass', '');
model.material('mat1').propertyGroup('def').set('bulkviscosity', '');
model.material('mat1').propertyGroup('def').set('thermalexpansioncoefficient', {'alpha_p(pA,T)' '0' '0' '0' 'alpha_p(pA,T)' '0' '0' '0' 'alpha_p(pA,T)'});
model.material('mat1').propertyGroup('def').set('molarmass', '0.02897[kg/mol]');
model.material('mat1').propertyGroup('def').set('bulkviscosity', 'muB(T)');
model.material('mat1').propertyGroup('def').set('relpermeability', {'1' '0' '0' '0' '1' '0' '0' '0' '1'});
model.material('mat1').propertyGroup('def').set('relpermittivity', {'1' '0' '0' '0' '1' '0' '0' '0' '1'});
model.material('mat1').propertyGroup('def').set('dynamicviscosity', 'eta(T)');
model.material('mat1').propertyGroup('def').set('ratioofspecificheat', '1.4');
model.material('mat1').propertyGroup('def').set('electricconductivity', {'0[S/m]' '0' '0' '0' '0[S/m]' '0' '0' '0' '0[S/m]'});
model.material('mat1').propertyGroup('def').set('heatcapacity', 'Cp(T)');
model.material('mat1').propertyGroup('def').set('density', 'rho(pA,T)');
model.material('mat1').propertyGroup('def').set('thermalconductivity', {'k(T)' '0' '0' '0' 'k(T)' '0' '0' '0' 'k(T)'});
model.material('mat1').propertyGroup('def').set('soundspeed', 'cs(T)');
model.material('mat1').propertyGroup('def').addInput('temperature');
model.material('mat1').propertyGroup('def').addInput('pressure');
model.material('mat1').propertyGroup('RefractiveIndex').set('n', {'1' '0' '0' '0' '1' '0' '0' '0' '1'});
model.material('mat1').propertyGroup('NonlinearModel').set('BA', 'def.gamma-1');
model.material('mat1').propertyGroup('idealGas').func('Cp').label('Piecewise 2');
model.material('mat1').propertyGroup('idealGas').func('Cp').set('arg', 'T');
model.material('mat1').propertyGroup('idealGas').func('Cp').set('pieces', {'200.0' '1600.0' '1047.63657-0.372589265*T^1+9.45304214E-4*T^2-6.02409443E-7*T^3+1.2858961E-10*T^4'});
model.material('mat1').propertyGroup('idealGas').func('Cp').set('argunit', 'K');
model.material('mat1').propertyGroup('idealGas').func('Cp').set('fununit', 'J/(kg*K)');
model.material('mat1').propertyGroup('idealGas').set('Rs', 'R_const/Mn');
model.material('mat1').propertyGroup('idealGas').set('heatcapacity', 'Cp(T)');
model.material('mat1').propertyGroup('idealGas').set('ratioofspecificheat', '1.4');
model.material('mat1').propertyGroup('idealGas').set('molarmass', '0.02897');
model.material('mat1').propertyGroup('idealGas').addInput('temperature');
model.material('mat1').propertyGroup('idealGas').addInput('pressure');
model.material('mat1').materialType('nonSolid');
model.material('mat1').label('Air (dry)');

model.thermodynamics.feature.create('pp1', 'BuiltinPropertyPackage');
model.thermodynamics.feature('pp1').set('compoundlist', {'nitrogen' '7727-37-9' 'N2' 'COMSOL';  ...
'oxygen' '7782-44-7' 'O2' 'COMSOL';  ...
'water' '7732-18-5' 'H2O' 'COMSOL';  ...
'argon' '7440-37-1' 'Ar' 'COMSOL';  ...
'carbon dioxide' '124-38-9' 'CO2' 'COMSOL';  ...
'neon' '7440-01-9' 'Ne' 'COMSOL';  ...
'helium' '7440-59-7' 'He' 'COMSOL'});
model.thermodynamics.feature('pp1').set('phase_list', {'Gas' 'Vapor'});
model.thermodynamics.feature('pp1').set('predefinedSystem', 'Moistair');
model.thermodynamics.feature('pp1').label('Moist Air 1');
model.thermodynamics.feature('pp1').set('manager_id', 'COMSOL');
model.thermodynamics.feature('pp1').set('manager_version', '1.0');
model.thermodynamics.feature('pp1').set('packagename', 'pp1');
model.thermodynamics.feature('pp1').set('package_desc', 'Predefined_systemMoistair');
model.thermodynamics.feature('pp1').set('managerindex', '0');
model.thermodynamics.feature('pp1').set('packageid', 'COMSOL1');
model.thermodynamics.feature('pp1').set('ThermodynamicModel', 'PengRobinson');
model.thermodynamics.feature('pp1').set('LiquidPhaseModel', 'None');
model.thermodynamics.feature('pp1').set('LiquidCard', 'None');
model.thermodynamics.feature('pp1').set('EOSModel', 'PengRobinson');
model.thermodynamics.feature('pp1').set('GasPhaseModel', 'PengRobinson');
model.thermodynamics.feature('pp1').set('GasEOSCard', 'GasPhaseModel');
model.thermodynamics.feature('pp1').set('VapDiffusivity', 'Automatic');
model.thermodynamics.feature('pp1').set('VapThermalConductivity', 'KineticTheory');
model.thermodynamics.feature('pp1').set('VapViscosity', 'Brokaw');
model.thermodynamics.feature('pp1').storePersistenceData;
model.thermodynamics.feature('pp1').set('WarningState', false);
model.thermodynamics.feature('pp1').set('Warning', {''});
model.thermodynamics.feature('pp1').feature.create('tdep1', 'TemperatureDependentProperty');
model.thermodynamics.feature('pp1').feature('tdep1').set('funcname', 'LnVaporPressure_water11');
model.thermodynamics.feature('pp1').feature('tdep1').set('property', 'LnVaporPressure');
model.thermodynamics.feature('pp1').feature('tdep1').set('propertydescr', 'Ln vapor pressure');
model.thermodynamics.feature('pp1').feature('tdep1').set('unit', '1');
model.thermodynamics.feature('pp1').feature('tdep1').set('prop_basis', 'mass');
model.thermodynamics.feature('pp1').feature('tdep1').set('compounds', {'water'});
model.thermodynamics.feature('pp1').feature('tdep1').comments('Refitted to IAPWS');
model.thermodynamics.feature('pp1').feature('tdep1').set('args', {'temperature' 'K' 'Temperature' '[273.15 ,647.10]'});
model.thermodynamics.feature('pp1').feature('tdep1').set('plotargs', {'temperature' '298.15' '373.15'});
model.thermodynamics.feature('pp1').feature('tdep1').set('derivatives', {'LnVaporPressure_water11_Dtemperature'});
model.thermodynamics.feature('pp1').feature('tdep1').set('SecondDerivatives', {});
model.thermodynamics.feature('pp1').feature('tdep1').set('SecondDerivativeIndices', {});
model.thermodynamics.feature('pp1').feature.create('singlephase1', 'OnePhaseProperty');
model.thermodynamics.feature('pp1').feature('singlephase1').set('funcname', 'Density_nitrogen_oxygen_water_argon_carbon_dioxide_neon_helium_Gas11');
model.thermodynamics.feature('pp1').feature('singlephase1').set('property', 'Density');
model.thermodynamics.feature('pp1').feature('singlephase1').set('propertydescr', 'Density');
model.thermodynamics.feature('pp1').feature('singlephase1').set('unit', 'kg/m^3');
model.thermodynamics.feature('pp1').feature('singlephase1').set('prop_basis', 'mass');
model.thermodynamics.feature('pp1').feature('singlephase1').set('compounds', {'nitrogen' 'oxygen' 'water' 'argon' 'carbon dioxide' 'neon' 'helium'});
model.thermodynamics.feature('pp1').feature('singlephase1').set('args', {'temperature' 'K' 'Temperature';  ...
'pressure' 'Pa' 'Pressure';  ...
'molefraction_nitrogen' '1' 'Mole fraction nitrogen';  ...
'molefraction_oxygen' '1' 'Mole fraction oxygen';  ...
'molefraction_water' '1' 'Mole fraction water';  ...
'molefraction_argon' '1' 'Mole fraction argon';  ...
'molefraction_carbon_dioxide' '1' 'Mole fraction carbon dioxide';  ...
'molefraction_neon' '1' 'Mole fraction neon';  ...
'molefraction_helium' '1' 'Mole fraction helium'});
model.thermodynamics.feature('pp1').feature('singlephase1').set('plotargs', {'temperature' '298.15' '373.15';  ...
'pressure' '101325' '101325';  ...
'molefraction_nitrogen' '0.14' '0.14';  ...
'molefraction_oxygen' '0.14' '0.14';  ...
'molefraction_water' '0.14' '0.14';  ...
'molefraction_argon' '0.14' '0.14';  ...
'molefraction_carbon_dioxide' '0.14' '0.14';  ...
'molefraction_neon' '0.14' '0.14';  ...
'molefraction_helium' '0.14' '0.14'});
model.thermodynamics.feature('pp1').feature('singlephase1').set('derivatives', {'Density_nitrogen_oxygen_water_argon_carbon_dioxide_neon_helium_Gas11_Dtemperature' 'Density_nitrogen_oxygen_water_argon_carbon_dioxide_neon_helium_Gas11_Dpressure' 'Density_nitrogen_oxygen_water_argon_carbon_dioxide_neon_helium_Gas11_Dmolefraction_nitrogen' 'Density_nitrogen_oxygen_water_argon_carbon_dioxide_neon_helium_Gas11_Dmolefraction_oxygen' 'Density_nitrogen_oxygen_water_argon_carbon_dioxide_neon_helium_Gas11_Dmolefraction_water' 'Density_nitrogen_oxygen_water_argon_carbon_dioxide_neon_helium_Gas11_Dmolefraction_argon' 'Density_nitrogen_oxygen_water_argon_carbon_dioxide_neon_helium_Gas11_Dmolefraction_carbon_dioxide' 'Density_nitrogen_oxygen_water_argon_carbon_dioxide_neon_helium_Gas11_Dmolefraction_neon' 'Density_nitrogen_oxygen_water_argon_carbon_dioxide_neon_helium_Gas11_Dmolefraction_helium'});
model.thermodynamics.feature('pp1').feature('singlephase1').set('SecondDerivatives', {'Density_nitrogen_oxygen_water_argon_carbon_dioxide_neon_helium_Gas11_Dtemperature_Dtemperature' 'Density_nitrogen_oxygen_water_argon_carbon_dioxide_neon_helium_Gas11_Dtemperature_Dpressure' 'Density_nitrogen_oxygen_water_argon_carbon_dioxide_neon_helium_Gas11_Dpressure_Dpressure'});
model.thermodynamics.feature('pp1').feature('singlephase1').set('SecondDerivativeIndices', {'0' '0' '0' '0' '1' '1' '1' '1' '2'});
model.thermodynamics.feature('pp1').feature('singlephase1').set('phase', 'Gas');
model.thermodynamics.feature('pp1').feature('singlephase1').set('comp_basis', 'mole');
model.thermodynamics.feature('pp1').feature('singlephase1').set('include_derivatives', 'yes');
model.thermodynamics.feature('pp1').feature.create('singlephase2', 'OnePhaseProperty');
model.thermodynamics.feature('pp1').feature('singlephase2').set('funcname', 'HeatCapacityCp_nitrogen_oxygen_water_argon_carbon_dioxide_neon_helium_Gas12');
model.thermodynamics.feature('pp1').feature('singlephase2').set('property', 'HeatCapacityCp');
model.thermodynamics.feature('pp1').feature('singlephase2').set('propertydescr', 'Heat capacity (Cp)');
model.thermodynamics.feature('pp1').feature('singlephase2').set('unit', 'J/kg/K');
model.thermodynamics.feature('pp1').feature('singlephase2').set('prop_basis', 'mass');
model.thermodynamics.feature('pp1').feature('singlephase2').set('compounds', {'nitrogen' 'oxygen' 'water' 'argon' 'carbon dioxide' 'neon' 'helium'});
model.thermodynamics.feature('pp1').feature('singlephase2').set('args', {'temperature' 'K' 'Temperature';  ...
'pressure' 'Pa' 'Pressure';  ...
'molefraction_nitrogen' '1' 'Mole fraction nitrogen';  ...
'molefraction_oxygen' '1' 'Mole fraction oxygen';  ...
'molefraction_water' '1' 'Mole fraction water';  ...
'molefraction_argon' '1' 'Mole fraction argon';  ...
'molefraction_carbon_dioxide' '1' 'Mole fraction carbon dioxide';  ...
'molefraction_neon' '1' 'Mole fraction neon';  ...
'molefraction_helium' '1' 'Mole fraction helium'});
model.thermodynamics.feature('pp1').feature('singlephase2').set('plotargs', {'temperature' '298.15' '373.15';  ...
'pressure' '101325' '101325';  ...
'molefraction_nitrogen' '0.14' '0.14';  ...
'molefraction_oxygen' '0.14' '0.14';  ...
'molefraction_water' '0.14' '0.14';  ...
'molefraction_argon' '0.14' '0.14';  ...
'molefraction_carbon_dioxide' '0.14' '0.14';  ...
'molefraction_neon' '0.14' '0.14';  ...
'molefraction_helium' '0.14' '0.14'});
model.thermodynamics.feature('pp1').feature('singlephase2').set('derivatives', {'HeatCapacityCp_nitrogen_oxygen_water_argon_carbon_dioxide_neon_helium_Gas12_Dtemperature' 'HeatCapacityCp_nitrogen_oxygen_water_argon_carbon_dioxide_neon_helium_Gas12_Dpressure' 'HeatCapacityCp_nitrogen_oxygen_water_argon_carbon_dioxide_neon_helium_Gas12_Dmolefraction_nitrogen' 'HeatCapacityCp_nitrogen_oxygen_water_argon_carbon_dioxide_neon_helium_Gas12_Dmolefraction_oxygen' 'HeatCapacityCp_nitrogen_oxygen_water_argon_carbon_dioxide_neon_helium_Gas12_Dmolefraction_water' 'HeatCapacityCp_nitrogen_oxygen_water_argon_carbon_dioxide_neon_helium_Gas12_Dmolefraction_argon' 'HeatCapacityCp_nitrogen_oxygen_water_argon_carbon_dioxide_neon_helium_Gas12_Dmolefraction_carbon_dioxide' 'HeatCapacityCp_nitrogen_oxygen_water_argon_carbon_dioxide_neon_helium_Gas12_Dmolefraction_neon' 'HeatCapacityCp_nitrogen_oxygen_water_argon_carbon_dioxide_neon_helium_Gas12_Dmolefraction_helium'});
model.thermodynamics.feature('pp1').feature('singlephase2').set('SecondDerivatives', {});
model.thermodynamics.feature('pp1').feature('singlephase2').set('SecondDerivativeIndices', {});
model.thermodynamics.feature('pp1').feature('singlephase2').set('phase', 'Gas');
model.thermodynamics.feature('pp1').feature('singlephase2').set('comp_basis', 'mole');
model.thermodynamics.feature('pp1').feature('singlephase2').set('include_derivatives', 'yes');
model.thermodynamics.feature('pp1').feature.create('singlephase3', 'OnePhaseProperty');
model.thermodynamics.feature('pp1').feature('singlephase3').set('funcname', 'HeatCapacityRatioCpCv_nitrogen_oxygen_water_argon_carbon_dioxide_neon_helium_Gas13');
model.thermodynamics.feature('pp1').feature('singlephase3').set('property', 'HeatCapacityRatioCpCv');
model.thermodynamics.feature('pp1').feature('singlephase3').set('propertydescr', 'Heat capacity ratio (Cp/Cv)');
model.thermodynamics.feature('pp1').feature('singlephase3').set('unit', '1');
model.thermodynamics.feature('pp1').feature('singlephase3').set('prop_basis', 'mass');
model.thermodynamics.feature('pp1').feature('singlephase3').set('compounds', {'nitrogen' 'oxygen' 'water' 'argon' 'carbon dioxide' 'neon' 'helium'});
model.thermodynamics.feature('pp1').feature('singlephase3').set('args', {'temperature' 'K' 'Temperature';  ...
'pressure' 'Pa' 'Pressure';  ...
'molefraction_nitrogen' '1' 'Mole fraction nitrogen';  ...
'molefraction_oxygen' '1' 'Mole fraction oxygen';  ...
'molefraction_water' '1' 'Mole fraction water';  ...
'molefraction_argon' '1' 'Mole fraction argon';  ...
'molefraction_carbon_dioxide' '1' 'Mole fraction carbon dioxide';  ...
'molefraction_neon' '1' 'Mole fraction neon';  ...
'molefraction_helium' '1' 'Mole fraction helium'});
model.thermodynamics.feature('pp1').feature('singlephase3').set('plotargs', {'temperature' '298.15' '373.15';  ...
'pressure' '101325' '101325';  ...
'molefraction_nitrogen' '0.14' '0.14';  ...
'molefraction_oxygen' '0.14' '0.14';  ...
'molefraction_water' '0.14' '0.14';  ...
'molefraction_argon' '0.14' '0.14';  ...
'molefraction_carbon_dioxide' '0.14' '0.14';  ...
'molefraction_neon' '0.14' '0.14';  ...
'molefraction_helium' '0.14' '0.14'});
model.thermodynamics.feature('pp1').feature('singlephase3').set('derivatives', {'HeatCapacityRatioCpCv_nitrogen_oxygen_water_argon_carbon_dioxide_neon_helium_Gas13_Dtemperature' 'HeatCapacityRatioCpCv_nitrogen_oxygen_water_argon_carbon_dioxide_neon_helium_Gas13_Dpressure' 'HeatCapacityRatioCpCv_nitrogen_oxygen_water_argon_carbon_dioxide_neon_helium_Gas13_Dmolefraction_nitrogen' 'HeatCapacityRatioCpCv_nitrogen_oxygen_water_argon_carbon_dioxide_neon_helium_Gas13_Dmolefraction_oxygen' 'HeatCapacityRatioCpCv_nitrogen_oxygen_water_argon_carbon_dioxide_neon_helium_Gas13_Dmolefraction_water' 'HeatCapacityRatioCpCv_nitrogen_oxygen_water_argon_carbon_dioxide_neon_helium_Gas13_Dmolefraction_argon' 'HeatCapacityRatioCpCv_nitrogen_oxygen_water_argon_carbon_dioxide_neon_helium_Gas13_Dmolefraction_carbon_dioxide' 'HeatCapacityRatioCpCv_nitrogen_oxygen_water_argon_carbon_dioxide_neon_helium_Gas13_Dmolefraction_neon' 'HeatCapacityRatioCpCv_nitrogen_oxygen_water_argon_carbon_dioxide_neon_helium_Gas13_Dmolefraction_helium'});
model.thermodynamics.feature('pp1').feature('singlephase3').set('SecondDerivatives', {});
model.thermodynamics.feature('pp1').feature('singlephase3').set('SecondDerivativeIndices', {});
model.thermodynamics.feature('pp1').feature('singlephase3').set('phase', 'Gas');
model.thermodynamics.feature('pp1').feature('singlephase3').set('comp_basis', 'mole');
model.thermodynamics.feature('pp1').feature('singlephase3').set('include_derivatives', 'yes');
model.thermodynamics.feature('pp1').feature.create('singlephase4', 'OnePhaseProperty');
model.thermodynamics.feature('pp1').feature('singlephase4').set('funcname', 'ThermalConductivity_nitrogen_oxygen_water_argon_carbon_dioxide_neon_helium_Gas14');
model.thermodynamics.feature('pp1').feature('singlephase4').set('property', 'ThermalConductivity');
model.thermodynamics.feature('pp1').feature('singlephase4').set('propertydescr', 'Thermal conductivity');
model.thermodynamics.feature('pp1').feature('singlephase4').set('unit', 'W/m/K');
model.thermodynamics.feature('pp1').feature('singlephase4').set('prop_basis', 'mass');
model.thermodynamics.feature('pp1').feature('singlephase4').set('compounds', {'nitrogen' 'oxygen' 'water' 'argon' 'carbon dioxide' 'neon' 'helium'});
model.thermodynamics.feature('pp1').feature('singlephase4').set('args', {'temperature' 'K' 'Temperature';  ...
'pressure' 'Pa' 'Pressure';  ...
'molefraction_nitrogen' '1' 'Mole fraction nitrogen';  ...
'molefraction_oxygen' '1' 'Mole fraction oxygen';  ...
'molefraction_water' '1' 'Mole fraction water';  ...
'molefraction_argon' '1' 'Mole fraction argon';  ...
'molefraction_carbon_dioxide' '1' 'Mole fraction carbon dioxide';  ...
'molefraction_neon' '1' 'Mole fraction neon';  ...
'molefraction_helium' '1' 'Mole fraction helium'});
model.thermodynamics.feature('pp1').feature('singlephase4').set('plotargs', {'temperature' '298.15' '373.15';  ...
'pressure' '101325' '101325';  ...
'molefraction_nitrogen' '0.14' '0.14';  ...
'molefraction_oxygen' '0.14' '0.14';  ...
'molefraction_water' '0.14' '0.14';  ...
'molefraction_argon' '0.14' '0.14';  ...
'molefraction_carbon_dioxide' '0.14' '0.14';  ...
'molefraction_neon' '0.14' '0.14';  ...
'molefraction_helium' '0.14' '0.14'});
model.thermodynamics.feature('pp1').feature('singlephase4').set('derivatives', {'ThermalConductivity_nitrogen_oxygen_water_argon_carbon_dioxide_neon_helium_Gas14_Dtemperature' 'ThermalConductivity_nitrogen_oxygen_water_argon_carbon_dioxide_neon_helium_Gas14_Dpressure' 'ThermalConductivity_nitrogen_oxygen_water_argon_carbon_dioxide_neon_helium_Gas14_Dmolefraction_nitrogen' 'ThermalConductivity_nitrogen_oxygen_water_argon_carbon_dioxide_neon_helium_Gas14_Dmolefraction_oxygen' 'ThermalConductivity_nitrogen_oxygen_water_argon_carbon_dioxide_neon_helium_Gas14_Dmolefraction_water' 'ThermalConductivity_nitrogen_oxygen_water_argon_carbon_dioxide_neon_helium_Gas14_Dmolefraction_argon' 'ThermalConductivity_nitrogen_oxygen_water_argon_carbon_dioxide_neon_helium_Gas14_Dmolefraction_carbon_dioxide' 'ThermalConductivity_nitrogen_oxygen_water_argon_carbon_dioxide_neon_helium_Gas14_Dmolefraction_neon' 'ThermalConductivity_nitrogen_oxygen_water_argon_carbon_dioxide_neon_helium_Gas14_Dmolefraction_helium'});
model.thermodynamics.feature('pp1').feature('singlephase4').set('SecondDerivatives', {});
model.thermodynamics.feature('pp1').feature('singlephase4').set('SecondDerivativeIndices', {});
model.thermodynamics.feature('pp1').feature('singlephase4').set('phase', 'Gas');
model.thermodynamics.feature('pp1').feature('singlephase4').set('comp_basis', 'mole');
model.thermodynamics.feature('pp1').feature('singlephase4').set('include_derivatives', 'yes');
model.thermodynamics.feature('pp1').feature.create('singlephase5', 'OnePhaseProperty');
model.thermodynamics.feature('pp1').feature('singlephase5').set('funcname', 'Viscosity_nitrogen_oxygen_water_argon_carbon_dioxide_neon_helium_Gas15');
model.thermodynamics.feature('pp1').feature('singlephase5').set('property', 'Viscosity');
model.thermodynamics.feature('pp1').feature('singlephase5').set('propertydescr', 'Viscosity');
model.thermodynamics.feature('pp1').feature('singlephase5').set('unit', 'Pa*s');
model.thermodynamics.feature('pp1').feature('singlephase5').set('prop_basis', 'mass');
model.thermodynamics.feature('pp1').feature('singlephase5').set('compounds', {'nitrogen' 'oxygen' 'water' 'argon' 'carbon dioxide' 'neon' 'helium'});
model.thermodynamics.feature('pp1').feature('singlephase5').set('args', {'temperature' 'K' 'Temperature';  ...
'pressure' 'Pa' 'Pressure';  ...
'molefraction_nitrogen' '1' 'Mole fraction nitrogen';  ...
'molefraction_oxygen' '1' 'Mole fraction oxygen';  ...
'molefraction_water' '1' 'Mole fraction water';  ...
'molefraction_argon' '1' 'Mole fraction argon';  ...
'molefraction_carbon_dioxide' '1' 'Mole fraction carbon dioxide';  ...
'molefraction_neon' '1' 'Mole fraction neon';  ...
'molefraction_helium' '1' 'Mole fraction helium'});
model.thermodynamics.feature('pp1').feature('singlephase5').set('plotargs', {'temperature' '298.15' '373.15';  ...
'pressure' '101325' '101325';  ...
'molefraction_nitrogen' '0.14' '0.14';  ...
'molefraction_oxygen' '0.14' '0.14';  ...
'molefraction_water' '0.14' '0.14';  ...
'molefraction_argon' '0.14' '0.14';  ...
'molefraction_carbon_dioxide' '0.14' '0.14';  ...
'molefraction_neon' '0.14' '0.14';  ...
'molefraction_helium' '0.14' '0.14'});
model.thermodynamics.feature('pp1').feature('singlephase5').set('derivatives', {'Viscosity_nitrogen_oxygen_water_argon_carbon_dioxide_neon_helium_Gas15_Dtemperature' 'Viscosity_nitrogen_oxygen_water_argon_carbon_dioxide_neon_helium_Gas15_Dpressure' 'Viscosity_nitrogen_oxygen_water_argon_carbon_dioxide_neon_helium_Gas15_Dmolefraction_nitrogen' 'Viscosity_nitrogen_oxygen_water_argon_carbon_dioxide_neon_helium_Gas15_Dmolefraction_oxygen' 'Viscosity_nitrogen_oxygen_water_argon_carbon_dioxide_neon_helium_Gas15_Dmolefraction_water' 'Viscosity_nitrogen_oxygen_water_argon_carbon_dioxide_neon_helium_Gas15_Dmolefraction_argon' 'Viscosity_nitrogen_oxygen_water_argon_carbon_dioxide_neon_helium_Gas15_Dmolefraction_carbon_dioxide' 'Viscosity_nitrogen_oxygen_water_argon_carbon_dioxide_neon_helium_Gas15_Dmolefraction_neon' 'Viscosity_nitrogen_oxygen_water_argon_carbon_dioxide_neon_helium_Gas15_Dmolefraction_helium'});
model.thermodynamics.feature('pp1').feature('singlephase5').set('SecondDerivatives', {});
model.thermodynamics.feature('pp1').feature('singlephase5').set('SecondDerivativeIndices', {});
model.thermodynamics.feature('pp1').feature('singlephase5').set('phase', 'Gas');
model.thermodynamics.feature('pp1').feature('singlephase5').set('comp_basis', 'mole');
model.thermodynamics.feature('pp1').feature('singlephase5').set('include_derivatives', 'yes');
model.thermodynamics.feature('pp1').feature('tdep1').tag('matpp1lnvaporpressure_water');
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
model.thermodynamics.createMaterial('comp1', 'pp1', 'Gas', {'nitrogen' 'oxygen' 'water' 'argon' 'carbon dioxide' 'neon' 'helium'}, {'0.14285714285714285' '0.14285714285714285' '0.14285714285714285' '0.14285714285714285' '0.14285714285714285' '0.14285714285714285' '0.14285714285714285'}, {}, {'density' 'Densitypp1'; 'heatcapacitycp' 'HeatCapacityCppp1'; 'heatcapacityratiocpcv' 'HeatCapacityRatioCpCvpp1'; 'thermalconductivity' 'ThermalConductivitypp1'; 'viscosity' 'Viscositypp1'}, 'Thermodynamics', {'0' '273' '373' '20' '101325' '201325' '15';  ...
'60' '273' '373' '20' '101325' '201325' '15';  ...
'68' '273' '373' '20' '101325' '201325' '15';  ...
'48' '273' '373' '20' '101325' '201325' '15';  ...
'52' '273' '373' '20' '101325' '201325' '15'}, {'mass' 'mole'});

model.material('pp1mat1').selection.set([1]);

model.variable.create('var1');
model.variable('var1').model('comp1');
model.variable('var1').label('Variables - Material Properties');

% To import content from file, use:
% model.variable('var1').loadFile('FILENAME');
model.variable('var1').set('omega', '2*pi*freq', 'Angular frequency');
model.variable('var1').set('mu', 'intop_pnt(ta.mu)', 'Dynamic viscosity');
model.variable('var1').set('gamma', 'intop_pnt(ta.gamma)', 'Ratio of specific heats');
model.variable('var1').set('Cp', 'intop_pnt(ta.Cp)', 'Heat capacity at constant pressure');
model.variable('var1').set('rho0', 'intop_pnt(ta.rho0)', 'Density');
model.variable('var1').set('kcond', 'intop_pnt(ta.kcond)', 'Thermal conductivity');
model.variable('var1').set('c', 'intop_pnt(ta.c)', 'Speed of sound');
model.variable('var1').set('betaT', 'intop_pnt(ta.betaT)', 'Isothermal compressibility');
model.variable.create('var2');
model.variable('var2').model('comp1');
model.variable('var2').label('Variables - Isothermal Limit (very low frequency)');

% To import content from file, use:
% model.variable('var2').loadFile('FILENAME');
model.variable('var2').set('dV', 'intop_s(dn)', 'Displaced volume (source)');
model.variable('var2').set('dpT', 'dV/betaT/V', 'Pressure in isothermal limit');
model.variable.create('var3');
model.variable('var3').model('comp1');
model.variable('var3').label('Variables - Transmission Line (high frequency)');

% To import content from file, use:
% model.variable('var3').loadFile('FILENAME');
model.variable('var3').set('k0', 'omega/c', 'Adiabatic wave number');
model.variable('var3').set('Z0', 'rho0*c', 'Adiabatic characteristic impedance');
model.variable('var3').set('kv', 'sqrt(-i*omega*rho0/mu)', 'Viscous wave number');
model.variable('var3').set('kth', 'sqrt(-i*omega*rho0*Cp/kcond)', 'Thermal wave number');
model.variable('var3').set('Yv', '-besselj(2,kv*a)/besselj(0,kv*a)', 'Mean value of the scalar thermal field');
model.variable('var3').set('Yth', '-besselj(2,kth*a)/besselj(0,kth*a)', 'Mean value of the scalar viscous field');
model.variable('var3').set('Zc', 'Z0/sqrt(Yv*(gamma-(gamma-1)*Yth))', 'Mode characteristic impedance');
model.variable('var3').set('kc_sq', 'k0^2*(gamma-(gamma-1)*Yth)/Yv', 'Square of mode wave number');
model.variable('var3').set('kc', 'sqrt(kc_sq)', 'Bulk wave number');
model.variable('var3').set('Y_tl', '(i*S*sin(kc*L)/Zc)', 'Transmission line admittance');
model.variable.create('var4');
model.variable('var4').model('comp1');
model.variable('var4').label('Variables - Vincent et al. (low frequency)');

% To import content from file, use:
% model.variable('var4').loadFile('FILENAME');
model.variable('var4').set('Rt', 'L/(2*a)', 'Ratio');
model.variable('var4').set('alpha_th', 'kcond/(rho0*Cp)', 'Thermal diffusivity');
model.variable('var4').set('Yr', '0[m^3/s/Pa]', 'Receiver acoustic admittance');
model.variable('var4').set('Yt', '0[m^3/s/Pa]', 'Transmitter acoustic admittance (source)');
model.variable('var4').set('Ep', 'sum(sum((8/pi^2)/((m+1/2)^2*lam_n(n)^2)*1/(1+(lam_n(n)^2*Rt^2+(m+1/2)^2*pi^2)*Xp^2/(1+2*Rt)^2),n,1,10),m,0,9)', 'Vincent et al. Eq 24');
model.variable('var4').set('Xp', 'A/V*(1-i)/sqrt(2)*sqrt(alpha_th/omega)', 'Vincent et al. Eq 26');
model.variable('var4').set('p_galf', 'dV/(betaT*V)*(1/(1+Yr/(i*omega*betaT*V)-(gamma-1)/gamma*Ep))', 'Vincent et al. Eq 27');
model.variable('var4').set('Ya', 'i*omega*V/(gamma*p0)*(gamma-(gamma-1)*Ep) + Yt + Yr', 'Vincent et al. Eq 30');

model.cpl.create('intop1', 'Integration', 'geom1');
model.cpl('intop1').set('axisym', true);
model.cpl('intop1').set('opname', 'intop_s');
model.cpl('intop1').selection.geom('geom1', 1);
model.cpl('intop1').selection.set([2]);
model.cpl.create('intop2', 'Integration', 'geom1');
model.cpl('intop2').set('axisym', true);
model.cpl('intop2').set('opname', 'intop_r');
model.cpl('intop2').selection.geom('geom1', 1);
model.cpl('intop2').selection.set([3]);
model.cpl.create('intop3', 'Integration', 'geom1');
model.cpl('intop3').set('axisym', true);
model.cpl('intop3').set('opname', 'intop_pnt');
model.cpl('intop3').selection.geom('geom1', 0);
model.cpl('intop3').selection.set([4]);
model.cpl('intop3').set('axisym', false);

model.func.create('int1', 'Interpolation');
model.func('int1').model('comp1');
model.func('int1').set('source', 'file');
model.func('int1').set('filename', 'pressure_reciprocity_calibration_coupler_bessel_zeros.txt');
model.func('int1').importData;
model.func('int1').set('funcname', 'lam_n');
model.func('int1').set('interp', 'neighbor');
model.func('int1').setIndex('argunit', 1, 0);
model.func('int1').setIndex('fununit', 1, 0);

model.physics('ta').feature('tam1').set('minput_relativehumidity', 'relH');
model.physics('ta').create('velt1', 'VelocityThermoacoustic', 1);
model.physics('ta').feature('velt1').selection.set([2]);
model.physics('ta').feature('velt1').setIndex('Direction', true, 0);
model.physics('ta').feature('velt1').setIndex('Direction', true, 2);
model.physics('ta').feature('velt1').setIndex('u0', 'ta.iomega*dn', 2);
model.physics('ta').feature('velt1').selection('excludedPoints').set([3]);
model.physics('ta').create('iso1', 'Isothermal', 1);
model.physics('ta').feature('iso1').selection.set([2]);

model.mesh('mesh1').create('ftri1', 'FreeTri');
model.mesh('mesh1').feature('size').set('custom', true);
model.mesh('mesh1').feature('size').set('hmax', 'a/10');
model.mesh('mesh1').feature('size').set('hmin', 'dvisc0');
model.mesh('mesh1').feature('ftri1').create('size1', 'Size');
model.mesh('mesh1').feature('ftri1').feature('size1').selection.geom('geom1', 1);
model.mesh('mesh1').feature('ftri1').feature('size1').selection.set([2 3 4]);
model.mesh('mesh1').feature('ftri1').feature('size1').set('custom', true);
model.mesh('mesh1').feature('ftri1').feature('size1').set('hmaxactive', true);
model.mesh('mesh1').feature('ftri1').feature('size1').set('hmax', 'dvisc0');
model.mesh('mesh1').create('bl1', 'BndLayer');
model.mesh('mesh1').feature('bl1').create('blp', 'BndLayerProp');
model.mesh('mesh1').feature('bl1').set('smoothtransition', false);
model.mesh('mesh1').feature('bl1').feature('blp').selection.set([4]);
model.mesh('mesh1').feature('bl1').feature('blp').set('inittype', 'blhmin');
model.mesh('mesh1').feature('bl1').feature('blp').set('blhmin', '0.2*dvisc');
model.mesh('mesh1').create('bl2', 'BndLayer');
model.mesh('mesh1').feature('bl2').create('blp', 'BndLayerProp');
model.mesh('mesh1').feature('bl2').set('smoothtransition', false);
model.mesh('mesh1').feature('bl2').feature('blp').selection.set([2 3]);
model.mesh('mesh1').feature('bl2').feature('blp').set('inittype', 'blhmin');
model.mesh('mesh1').feature('bl2').feature('blp').set('blhmin', '0.2*dvisc');
model.mesh('mesh1').create('bl3', 'BndLayer');
model.mesh('mesh1').feature('bl3').create('blp', 'BndLayerProp');
model.mesh('mesh1').feature('bl3').set('smoothtransition', false);
model.mesh('mesh1').feature('bl3').feature('blp').selection.set([4]);
model.mesh('mesh1').feature('bl3').feature('blp').set('blnlayers', 1);
model.mesh('mesh1').feature('bl3').feature('blp').set('inittype', 'blhmin');
model.mesh('mesh1').feature('bl3').feature('blp').set('blhmin', '2e-6');
model.mesh('mesh1').create('bl4', 'BndLayer');
model.mesh('mesh1').feature('bl4').create('blp', 'BndLayerProp');
model.mesh('mesh1').feature('bl4').set('smoothtransition', false);
model.mesh('mesh1').feature('bl4').feature('blp').selection.set([2 3]);
model.mesh('mesh1').feature('bl4').feature('blp').set('blnlayers', 1);
model.mesh('mesh1').feature('bl4').feature('blp').set('inittype', 'blhmin');
model.mesh('mesh1').feature('bl4').feature('blp').set('blhmin', '2e-6');
model.mesh('mesh1').run;

model.study('std1').feature('freq').set('plist', '{0.05, 0.063, 0.08, 0.1, 0.125, 0.16, 0.2, 0.25, 0.315, 0.4, 0.5, 0.63, 0.8, 1, 1.25, 1.6, 2, 2.5, 3.15, 4, 5, 6.3, 8, 10, 12.5, 16, 20, 25, 31.5, 40, 50, 63, 80, 100, 125, 160, 200, 250, 315, 400, 500, 630, 800, 1e3, 1.25e3, 1.6e3, 2e3, 2.5e3, 3.15e3, 4e3, 5e3, 6.3e3, 8e3, 1e4}');

model.sol.create('sol1');
model.sol('sol1').study('std1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'freq');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').set('control', 'freq');
model.sol('sol1').create('s1', 'Stationary');
model.sol('sol1').feature('s1').set('stol', 0.001);
model.sol('sol1').feature('s1').create('p1', 'Parametric');
model.sol('sol1').feature('s1').feature.remove('pDef');
model.sol('sol1').feature('s1').feature('p1').set('pname', {'freq'});
model.sol('sol1').feature('s1').feature('p1').set('plistarr', {'{0.05, 0.063, 0.08, 0.1, 0.125, 0.16, 0.2, 0.25, 0.315, 0.4, 0.5, 0.63, 0.8, 1, 1.25, 1.6, 2, 2.5, 3.15, 4, 5, 6.3, 8, 10, 12.5, 16, 20, 25, 31.5, 40, 50, 63, 80, 100, 125, 160, 200, 250, 315, 400, 500, 630, 800, 1e3, 1.25e3, 1.6e3, 2e3, 2.5e3, 3.15e3, 4e3, 5e3, 6.3e3, 8e3, 1e4}'});
model.sol('sol1').feature('s1').feature('p1').set('punit', {'Hz'});
model.sol('sol1').feature('s1').feature('p1').set('pcontinuationmode', 'no');
model.sol('sol1').feature('s1').feature('p1').set('preusesol', 'no');
model.sol('sol1').feature('s1').feature('p1').set('pdistrib', 'off');
model.sol('sol1').feature('s1').feature('p1').set('plot', 'off');
model.sol('sol1').feature('s1').feature('p1').set('plotgroup', 'Default');
model.sol('sol1').feature('s1').feature('p1').set('probesel', 'all');
model.sol('sol1').feature('s1').feature('p1').set('probes', {});
model.sol('sol1').feature('s1').feature('p1').set('control', 'freq');
model.sol('sol1').feature('s1').set('linpmethod', 'sol');
model.sol('sol1').feature('s1').set('linpsol', 'zero');
model.sol('sol1').feature('s1').set('control', 'freq');
model.sol('sol1').feature('s1').feature('aDef').set('complexfun', true);
model.sol('sol1').feature('s1').feature('aDef').set('cachepattern', true);
model.sol('sol1').feature('s1').feature('aDef').set('matherr', true);
model.sol('sol1').feature('s1').feature('aDef').set('blocksizeactive', false);
model.sol('sol1').feature('s1').feature('aDef').set('nullfun', 'auto');
model.sol('sol1').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('s1').create('d1', 'Direct');
model.sol('sol1').feature('s1').feature('d1').set('linsolver', 'pardiso');
model.sol('sol1').feature('s1').feature('d1').set('pivotperturb', 1.0E-13);
model.sol('sol1').feature('s1').feature('fc1').set('linsolver', 'd1');
model.sol('sol1').feature('s1').feature.remove('fcDef');
model.sol('sol1').attach('std1');
model.sol('sol1').runAll;

model.result.create('pg1', 'PlotGroup2D');
model.result('pg1').label('Acoustic Pressure (ta)');
model.result('pg1').set('dataisaxisym', 'off');
model.result('pg1').set('showlegendsunit', true);
model.result('pg1').set('data', 'dset1');
model.result('pg1').setIndex('looplevel', 54, 0);
model.result('pg1').set('defaultPlotID', 'thermoacoustics/ThermoacousticsPhysicsInterfaceComponents/icom5/pdef1/pcond2/pg2');
model.result('pg1').feature.create('surf1', 'Surface');
model.result('pg1').feature('surf1').label('Surface');
model.result('pg1').feature('surf1').set('showsolutionparams', 'on');
model.result('pg1').feature('surf1').set('colortable', 'Wave');
model.result('pg1').feature('surf1').set('colorscalemode', 'linearsymmetric');
model.result('pg1').feature('surf1').set('smooth', 'internal');
model.result('pg1').feature('surf1').set('showsolutionparams', 'on');
model.result('pg1').feature('surf1').set('data', 'parent');
model.result.create('pg2', 'PlotGroup2D');
model.result('pg2').label('Acoustic Velocity (ta)');
model.result('pg2').set('dataisaxisym', 'off');
model.result('pg2').set('showlegendsunit', true);
model.result('pg2').set('data', 'dset1');
model.result('pg2').setIndex('looplevel', 54, 0);
model.result('pg2').set('defaultPlotID', 'thermoacoustics/ThermoacousticsPhysicsInterfaceComponents/icom5/pdef1/pcond2/pg1');
model.result('pg2').feature.create('surf1', 'Surface');
model.result('pg2').feature('surf1').label('Surface');
model.result('pg2').feature('surf1').set('showsolutionparams', 'on');
model.result('pg2').feature('surf1').set('expr', 'ta.v_inst');
model.result('pg2').feature('surf1').set('smooth', 'internal');
model.result('pg2').feature('surf1').set('showsolutionparams', 'on');
model.result('pg2').feature('surf1').set('data', 'parent');
model.result.dataset.create('rev1', 'Revolve2D');
model.result.dataset('rev1').label('Revolution 2D');
model.result.dataset('rev1').set('data', 'none');
model.result.dataset('rev1').set('startangle', -90);
model.result.dataset('rev1').set('revangle', 225);
model.result.dataset('rev1').set('data', 'dset1');
model.result.dataset('rev1').selection.geom('geom1', 2);
model.result.dataset('rev1').selection.set([1]);
model.result.create('pg3', 'PlotGroup3D');
model.result('pg3').label('Temperature Variation (ta)');
model.result('pg3').set('showlegendsunit', true);
model.result('pg3').set('data', 'rev1');
model.result('pg3').setIndex('looplevel', 54, 0);
model.result('pg3').set('defaultPlotID', 'thermoacoustics/ThermoacousticsPhysicsInterfaceComponents/icom5/pdef1/pcond2/pcond2/pg1');
model.result('pg3').feature.create('surf1', 'Surface');
model.result('pg3').feature('surf1').label('Surface');
model.result('pg3').feature('surf1').set('showsolutionparams', 'on');
model.result('pg3').feature('surf1').set('expr', 'ta.T_t');
model.result('pg3').feature('surf1').set('colortable', 'ThermalWave');
model.result('pg3').feature('surf1').set('colorscalemode', 'linearsymmetric');
model.result('pg3').feature('surf1').set('smooth', 'internal');
model.result('pg3').feature('surf1').set('showsolutionparams', 'on');
model.result('pg3').feature('surf1').set('data', 'parent');
model.result('pg1').run;
model.result('pg2').run;
model.result('pg2').label('RMS Acoustic Velocity (ta)');
model.result('pg2').run;
model.result('pg2').feature('surf1').set('expr', 'ta.v_rms');
model.result('pg2').run;
model.result('pg2').run;
model.result('pg2').setIndex('looplevel', 4, 0);
model.result('pg2').run;
model.result('pg2').setIndex('looplevel', 14, 0);
model.result('pg2').run;
model.result('pg2').setIndex('looplevel', 24, 0);
model.result('pg2').run;
model.result('pg2').setIndex('looplevel', 34, 0);
model.result('pg2').run;
model.result('pg3').run;
model.result('pg3').setIndex('looplevel', 4, 0);
model.result('pg3').run;
model.result('pg3').setIndex('looplevel', 14, 0);
model.result('pg3').run;
model.result('pg3').setIndex('looplevel', 24, 0);
model.result('pg3').run;
model.result('pg3').setIndex('looplevel', 34, 0);
model.result('pg3').run;
model.result.create('pg4', 'PlotGroup1D');
model.result('pg4').run;
model.result('pg4').label('Pressure in Coupler: real(p)');
model.result('pg4').set('titletype', 'label');
model.result('pg4').set('xlabelactive', true);
model.result('pg4').set('xlabel', 'f (Hz)');
model.result('pg4').set('ylabelactive', true);
model.result('pg4').set('ylabel', 'Pressure (Pa)');
model.result('pg4').set('legendpos', 'upperleft');
model.result('pg4').create('ptgr1', 'PointGraph');
model.result('pg4').feature('ptgr1').set('markerpos', 'datapoints');
model.result('pg4').feature('ptgr1').set('linewidth', 'preference');
model.result('pg4').feature('ptgr1').selection.set([2]);
model.result('pg4').feature('ptgr1').set('expr', 'real(ta.p_t)');
model.result('pg4').feature('ptgr1').set('legend', true);
model.result('pg4').feature('ptgr1').set('legendmethod', 'manual');
model.result('pg4').feature('ptgr1').setIndex('legends', 'COMSOL model', 0);
model.result('pg4').run;
model.result('pg4').create('glob1', 'Global');
model.result('pg4').feature('glob1').set('markerpos', 'datapoints');
model.result('pg4').feature('glob1').set('linewidth', 'preference');
model.result('pg4').feature('glob1').setIndex('expr', 'real(dpT)', 0);
model.result('pg4').feature('glob1').setIndex('unit', 'Pa', 0);
model.result('pg4').feature('glob1').setIndex('descr', 'Isothermal limit (very low frequency)', 0);
model.result('pg4').feature('glob1').setIndex('expr', 'real(i*omega*dV/Y_tl)', 1);
model.result('pg4').feature('glob1').setIndex('unit', 'Pa', 1);
model.result('pg4').feature('glob1').setIndex('descr', 'Transmission line (high frequency)', 1);
model.result('pg4').feature('glob1').setIndex('expr', 'real(p_galf)', 2);
model.result('pg4').feature('glob1').setIndex('unit', 'Pa', 2);
model.result('pg4').feature('glob1').setIndex('descr', 'Vincent et al. (low frequency)', 2);
model.result('pg4').run;
model.result('pg4').set('xlog', true);
model.result('pg4').set('ylog', true);
model.result('pg4').run;
model.result.duplicate('pg5', 'pg4');
model.result('pg5').run;
model.result('pg5').label('Pressure in Coupler: imag(p)');
model.result('pg5').set('legendpos', 'upperright');
model.result('pg5').run;
model.result('pg5').feature('ptgr1').set('expr', 'imag(ta.p_t)');
model.result('pg5').run;
model.result('pg5').feature('glob1').setIndex('expr', 'imag(dpT)', 0);
model.result('pg5').feature('glob1').setIndex('unit', 'Pa', 0);
model.result('pg5').feature('glob1').setIndex('descr', 'Isothermal limit (very low frequency)', 0);
model.result('pg5').feature('glob1').setIndex('expr', 'imag(i*omega*dV/Y_tl)', 1);
model.result('pg5').feature('glob1').setIndex('unit', 'Pa', 1);
model.result('pg5').feature('glob1').setIndex('descr', 'Transmission line (high frequency)', 1);
model.result('pg5').feature('glob1').setIndex('expr', 'imag(p_galf)', 2);
model.result('pg5').feature('glob1').setIndex('unit', 'Pa', 2);
model.result('pg5').feature('glob1').setIndex('descr', 'Vincent et al. (low frequency)', 2);
model.result('pg5').run;
model.result('pg5').set('ylog', false);
model.result.create('pg6', 'PlotGroup1D');
model.result('pg6').run;
model.result('pg6').label('Acoustic Transfer Impedance: real(Z) and imag(Z)');
model.result('pg6').set('titletype', 'label');
model.result('pg6').set('xlabelactive', true);
model.result('pg6').set('xlabel', 'f (Hz)');
model.result('pg6').set('ylabelactive', true);
model.result('pg6').set('ylabel', 'Z<sub>a,12</sub> (kg/(m<sup>4</sup>s))');
model.result('pg6').set('xlog', true);
model.result('pg6').set('ylog', true);
model.result('pg6').set('legendpos', 'lowerleft');
model.result('pg6').create('glob1', 'Global');
model.result('pg6').feature('glob1').set('markerpos', 'datapoints');
model.result('pg6').feature('glob1').set('linewidth', 'preference');
model.result('pg6').feature('glob1').setIndex('expr', 'real((intop_s(ta.p_t)/S)/(ta.iomega*dn*S))', 0);
model.result('pg6').feature('glob1').setIndex('unit', 'kg/(m^4*s)', 0);
model.result('pg6').feature('glob1').setIndex('descr', 'real(Z), COMSOL model', 0);
model.result('pg6').feature('glob1').setIndex('expr', '-imag((intop_s(ta.p_t)/S)/(ta.iomega*dn*S))', 1);
model.result('pg6').feature('glob1').setIndex('unit', 'kg/(m^4*s)', 1);
model.result('pg6').feature('glob1').setIndex('descr', '-imag(Z), COMSOL model', 1);
model.result('pg6').feature('glob1').set('linewidth', 2);
model.result('pg6').run;
model.result('pg6').create('glob2', 'Global');
model.result('pg6').feature('glob2').set('markerpos', 'datapoints');
model.result('pg6').feature('glob2').set('linewidth', 'preference');
model.result('pg6').feature('glob2').setIndex('expr', 'real(1/Y_tl)', 0);
model.result('pg6').feature('glob2').setIndex('unit', 'kg/(m^4*s)', 0);
model.result('pg6').feature('glob2').setIndex('descr', 'real(Z), Transmission line', 0);
model.result('pg6').feature('glob2').setIndex('expr', '-imag(1/Y_tl)', 1);
model.result('pg6').feature('glob2').setIndex('unit', 'kg/(m^4*s)', 1);
model.result('pg6').feature('glob2').setIndex('descr', '-imag(Z), Transmission line', 1);
model.result('pg6').feature('glob2').set('linestyle', 'dashed');
model.result('pg6').feature('glob2').set('linecolor', 'cyclereset');
model.result('pg6').run;
model.result('pg6').create('glob3', 'Global');
model.result('pg6').feature('glob3').set('markerpos', 'datapoints');
model.result('pg6').feature('glob3').set('linewidth', 'preference');
model.result('pg6').feature('glob3').setIndex('expr', 'real(1/Ya)', 0);
model.result('pg6').feature('glob3').setIndex('unit', 'kg/(m^4*s)', 0);
model.result('pg6').feature('glob3').setIndex('descr', 'real(Z), Vincent et al.', 0);
model.result('pg6').feature('glob3').setIndex('expr', '-imag(1/Ya)', 1);
model.result('pg6').feature('glob3').setIndex('unit', 'kg/(m^4*s)', 1);
model.result('pg6').feature('glob3').setIndex('descr', '-imag(Z), Vincent et al.', 1);
model.result('pg6').feature('glob3').set('linestyle', 'none');
model.result('pg6').feature('glob3').set('linecolor', 'cyclereset');
model.result('pg6').feature('glob3').set('linemarker', 'point');
model.result('pg6').feature('glob3').set('markerpos', 'interp');
model.result('pg6').feature('glob3').set('markers', 25);
model.result('pg6').run;
model.result.dataset.create('grid1', 'Grid1D');
model.result.dataset('grid1').set('source', 'data');
model.result.dataset('grid1').set('par1', 'Tg');
model.result.dataset('grid1').set('parmin1', 273.15);
model.result.dataset('grid1').set('parmax1', 323.15);
model.result.create('pg7', 'PlotGroup1D');
model.result('pg7').run;
model.result('pg7').label('Density');
model.result('pg7').set('data', 'grid1');
model.result('pg7').setIndex('looplevelinput', 'first', 0);
model.result('pg7').set('titletype', 'label');
model.result('pg7').set('xlabelactive', true);
model.result('pg7').set('xlabel', 'Temperature (<sup>o</sup>C)');
model.result('pg7').set('ylabelactive', true);
model.result('pg7').set('ylabel', 'Density (kg/m<sup>3</sup>)');
model.result('pg7').create('lngr1', 'LineGraph');
model.result('pg7').feature('lngr1').set('markerpos', 'datapoints');
model.result('pg7').feature('lngr1').set('linewidth', 'preference');
model.result('pg7').feature('lngr1').set('expr', 'subst(pp1mat1.def.rho,minput.T,Tg[K/m],minput.pA,p0,minput.phi,0)');
model.result('pg7').feature('lngr1').set('legend', true);
model.result('pg7').feature('lngr1').set('legendmethod', 'manual');
model.result('pg7').feature('lngr1').setIndex('legends', 'relH = 0.0', 0);
model.result('pg7').run;
model.result('pg7').feature.duplicate('lngr2', 'lngr1');
model.result('pg7').run;
model.result('pg7').feature('lngr2').set('expr', 'subst(pp1mat1.def.rho,minput.T,Tg[K/m],minput.pA,p0,minput.phi,0.2)');
model.result('pg7').feature('lngr2').setIndex('legends', 'relH = 0.2', 0);
model.result('pg7').run;
model.result('pg7').feature.duplicate('lngr3', 'lngr2');
model.result('pg7').run;
model.result('pg7').feature('lngr3').set('expr', 'subst(pp1mat1.def.rho,minput.T,Tg[K/m],minput.pA,p0,minput.phi,0.4)');
model.result('pg7').feature('lngr3').setIndex('legends', 'relH = 0.4', 0);
model.result('pg7').run;
model.result('pg7').feature.duplicate('lngr4', 'lngr3');
model.result('pg7').run;
model.result('pg7').feature('lngr4').set('expr', 'subst(pp1mat1.def.rho,minput.T,Tg[K/m],minput.pA,p0,minput.phi,0.8)');
model.result('pg7').feature('lngr4').setIndex('legends', 'relH = 0.8', 0);
model.result('pg7').run;
model.result('pg7').run;
model.result.duplicate('pg8', 'pg7');
model.result('pg8').run;
model.result('pg8').label('Dynamic Viscosity');
model.result('pg8').set('ylabel', 'Dynamic Viscosity (Pa\cdot s)');
model.result('pg8').set('legendpos', 'upperleft');
model.result('pg8').run;
model.result('pg8').feature('lngr1').set('expr', 'subst(pp1mat1.def.mu,minput.T,Tg[K/m],minput.pA,p0,minput.phi,0)');
model.result('pg8').run;
model.result('pg8').feature('lngr2').set('expr', 'subst(pp1mat1.def.mu,minput.T,Tg[K/m],minput.pA,p0,minput.phi,0.2)');
model.result('pg8').run;
model.result('pg8').feature('lngr3').set('expr', 'subst(pp1mat1.def.mu,minput.T,Tg[K/m],minput.pA,p0,minput.phi,0.4)');
model.result('pg8').run;
model.result('pg8').feature('lngr4').set('expr', 'subst(pp1mat1.def.mu,minput.T,Tg[K/m],minput.pA,p0,minput.phi,0.8)');
model.result('pg8').run;
model.result('pg8').run;
model.result.duplicate('pg9', 'pg8');
model.result('pg9').run;
model.result('pg9').label('Thermal Conductivity');
model.result('pg9').set('ylabel', 'Thermal Conductivity (W/(m\cdot K))');
model.result('pg9').run;
model.result('pg9').feature('lngr1').set('expr', 'subst(pp1mat1.def.k_iso,minput.T,Tg[K/m],minput.pA,p0,minput.phi,0)');
model.result('pg9').run;
model.result('pg9').feature('lngr2').set('expr', 'subst(pp1mat1.def.k_iso,minput.T,Tg[K/m],minput.pA,p0,minput.phi,0.2)');
model.result('pg9').run;
model.result('pg9').feature('lngr3').set('expr', 'subst(pp1mat1.def.k_iso,minput.T,Tg[K/m],minput.pA,p0,minput.phi,0.4)');
model.result('pg9').run;
model.result('pg9').feature('lngr4').set('expr', 'subst(pp1mat1.def.k_iso,minput.T,Tg[K/m],minput.pA,p0,minput.phi,0.8)');
model.result('pg9').run;
model.result('pg9').run;
model.result.duplicate('pg10', 'pg9');
model.result('pg10').run;
model.result('pg10').label('Speed of Sound');
model.result('pg10').set('ylabel', 'Speed of Sound (m/s)');
model.result('pg10').run;
model.result('pg10').feature('lngr1').set('expr', 'subst(pp1mat1.def.c,minput.T,Tg[K/m],minput.pA,p0,minput.phi,0)');
model.result('pg10').run;
model.result('pg10').feature('lngr2').set('expr', 'subst(pp1mat1.def.c,minput.T,Tg[K/m],minput.pA,p0,minput.phi,0.2)');
model.result('pg10').run;
model.result('pg10').feature('lngr3').set('expr', 'subst(pp1mat1.def.c,minput.T,Tg[K/m],minput.pA,p0,minput.phi,0.4)');
model.result('pg10').run;
model.result('pg10').feature('lngr4').set('expr', 'subst(pp1mat1.def.c,minput.T,Tg[K/m],minput.pA,p0,minput.phi,0.8)');
model.result('pg10').run;
model.result('pg10').run;
model.result('pg7').run;

model.nodeGroup.create('grp1', 'Results');
model.nodeGroup('grp1').set('type', 'plotgroup');
model.nodeGroup('grp1').placeAfter('plotgroup', 'pg6');
model.nodeGroup('grp1').add('plotgroup', 'pg7');
model.nodeGroup('grp1').add('plotgroup', 'pg8');
model.nodeGroup('grp1').add('plotgroup', 'pg9');
model.nodeGroup('grp1').add('plotgroup', 'pg10');
model.nodeGroup('grp1').label('Material Properties');

model.result('pg2').run;

model.title('Pressure Reciprocity Calibration Coupler with Detailed Moist Air Material Properties');

model.description(['When high-fidelity measurement microphones are calibrated, a pressure reciprocity calibration method is used. During calibration, two microphones are connected at each end of a closed cylindrical cavity. For the calibration procedure, it is important to understand the acoustic field inside such a cavity, including all the thermoviscous acoustic effects, for example, the acoustic boundary layers at higher frequencies and the transition to isothermal behavior at the lower frequencies.' newline  newline 'This model sets up a simple calibration coupler model and discusses important considerations when performing a high precision absolute value simulation. The model results include the acoustic transfer impedance used for reciprocity calibration and the pressure in the coupler. The results are compared with analytical predictions.' newline  newline 'The model also includes precise material property estimation using the Thermodynamics functionality in COMSOL Multiphysics. This allows setting up a moist air material that depends on the ambient pressure, temperature, and relative humidity.']);

model.mesh.clearMeshes;

model.sol('sol1').clearSolutionData;

model.label('pressure_reciprocity_calibration_coupler.mph');

model.modelNode.label('Components');

out = model;
