function out = model
%
% phase_envelope.m
%
% Model exported on May 26 2025, 21:29 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/Liquid_and_Gas_Properties_Module/Tutorials');

model.param.set('P', '1[atm]');
model.param.descr('P', 'Pressure');
model.param.set('xCh', '.5');
model.param.descr('xCh', 'Mole fraction of chloroform');

model.thermodynamics.feature.create('pp1', 'BuiltinPropertyPackage');
model.thermodynamics.feature('pp1').set('compoundlist', {'chloroform' '67-66-3' 'CHCl3' 'COMSOL'; 'methanol' '67-56-1' 'CH4O' 'COMSOL'});
model.thermodynamics.feature('pp1').set('phase_list', {'Vapor' 'Vapor'; 'Liquid' 'Liquid'});
model.thermodynamics.feature('pp1').label('Vapor-Liquid System 1');
model.thermodynamics.feature('pp1').set('manager_id', 'COMSOL');
model.thermodynamics.feature('pp1').set('manager_version', '1.0');
model.thermodynamics.feature('pp1').set('packagename', 'pp1');
model.thermodynamics.feature('pp1').set('package_desc', 'Built-in property package');
model.thermodynamics.feature('pp1').set('managerindex', '0');
model.thermodynamics.feature('pp1').set('packageid', 'COMSOL1');
model.thermodynamics.feature('pp1').set('ThermodynamicModel', 'UNIFAC');
model.thermodynamics.feature('pp1').set('EOS', 'SoaveRedlichKwong');
model.thermodynamics.feature('pp1').set('LiquidPhaseModel', 'UNIFAC');
model.thermodynamics.feature('pp1').set('LiquidCard', 'LiquidPhaseModel');
model.thermodynamics.feature('pp1').set('EOSModel', 'SoaveRedlichKwong');
model.thermodynamics.feature('pp1').set('GasPhaseModel', 'SoaveRedlichKwong');
model.thermodynamics.feature('pp1').set('GasEOSCard', 'GasPhaseModel');
model.thermodynamics.feature('pp1').set('EOS', 'SoaveRedlichKwong');
model.thermodynamics.feature('pp1').set('VapDiffusivity', 'Automatic');
model.thermodynamics.feature('pp1').set('VLSurfaceTension', 'Ideal');
model.thermodynamics.feature('pp1').set('VapThermalConductivity', 'KineticTheory');
model.thermodynamics.feature('pp1').set('VapViscosity', 'Brokaw');
model.thermodynamics.feature('pp1').set('LiqDiffusivity', 'WesselinghKrishna');
model.thermodynamics.feature('pp1').set('LiqDiffusivityAtInfDilution', 'Automatic');
model.thermodynamics.feature('pp1').set('LLSurfaceTension', 'None');
model.thermodynamics.feature('pp1').set('LiqThermalConductivity', 'Ideal');
model.thermodynamics.feature('pp1').set('LiqViscosity', 'LogarithmicMassMixing');
model.thermodynamics.feature('pp1').set('LiqVolume', 'EOS');
model.thermodynamics.feature('pp1').set('PoyntingFactor', 'off');
model.thermodynamics.feature('pp1').set('UseSaturatedVaporFugacity', 'off');
model.thermodynamics.feature('pp1').set('property', {'Automatic' 'Ideal' 'KineticTheory' 'Brokaw' 'WesselinghKrishna' 'Automatic' 'None' 'Ideal' 'LogarithmicMassMixing' 'EOS'  ...
'off' 'off'});
model.thermodynamics.feature('pp1').storePersistenceData;
model.thermodynamics.feature('pp1').set('WarningState', false);
model.thermodynamics.feature('pp1').set('Warning', {''});
model.thermodynamics.feature('pp1').feature.create('flashcalc1', 'FlashCalculationProperty');
model.thermodynamics.feature('pp1').feature.remove('flashcalc1');
model.thermodynamics.feature('pp1').feature.create('flashcalc1', 'FlashCalculationProperty');
model.thermodynamics.feature('pp1').feature('flashcalc1').set('funcname', 'flashcalc1');
model.thermodynamics.feature('pp1').feature('flashcalc1').set('property', 'FlashCalculationProperty');
model.thermodynamics.feature('pp1').feature('flashcalc1').set('propertydescr', 'Equilibrium calculation');
model.thermodynamics.feature('pp1').feature('flashcalc1').set('dvars', {'0' '0' '0' '0'});
model.thermodynamics.feature('pp1').feature('flashcalc1').set('compounds', {'chloroform' 'methanol'});
model.thermodynamics.feature('pp1').feature('flashcalc1').set('functions', {'Flash1_1_PhaseExist_Vapor' '1' 'Presence of Vapor phase';  ...
'Flash1_1_PhaseExist_Liquid' '1' 'Presence of Liquid phase';  ...
'Flash1_1_Temperature' 'K' 'Temperature';  ...
'Flash1_1_PhaseAmount_Vapor' 'mol' 'Amount in Vapor phase';  ...
'Flash1_1_PhaseAmount_Liquid' 'mol' 'Amount in Liquid phase';  ...
'Flash1_1_PhaseComposition_Vapor_chloroform' 'mol/mol' 'Fraction of chloroform in Vapor phase';  ...
'Flash1_1_PhaseComposition_Vapor_methanol' 'mol/mol' 'Fraction of methanol in Vapor phase';  ...
'Flash1_1_PhaseComposition_Liquid_chloroform' 'mol/mol' 'Fraction of chloroform in Liquid phase';  ...
'Flash1_1_PhaseComposition_Liquid_methanol' 'mol/mol' 'Fraction of methanol in Liquid phase'});
model.thermodynamics.feature('pp1').feature('flashcalc1').set('cond1', {'pressure'});
model.thermodynamics.feature('pp1').feature('flashcalc1').set('cond2', {'phasefraction' 'mole' 'Vapor'});
model.thermodynamics.feature('pp1').feature('flashcalc1').set('prop_basis', 'mole');
model.thermodynamics.feature('pp1').feature('flashcalc1').set('inphase', 'Flash1_1_PhaseExist');
model.thermodynamics.feature('pp1').feature('flashcalc1').set('temperature', 'Flash1_1_Temperature');
model.thermodynamics.feature('pp1').feature('flashcalc1').set('pressure', 'Flash1_1_Pressure');
model.thermodynamics.feature('pp1').feature('flashcalc1').set('amounts', 'Flash1_1_PhaseAmount');
model.thermodynamics.feature('pp1').feature('flashcalc1').set('composition', 'Flash1_1_PhaseComposition');
model.thermodynamics.feature('pp1').feature('flashcalc1').set('soltype', 'undefined');
model.thermodynamics.feature('pp1').feature('flashcalc1').set('unit', '1');
model.thermodynamics.feature('pp1').feature('flashcalc1').set('phases', {'Vapor' 'Liquid'});
model.thermodynamics.feature('pp1').feature('flashcalc1').set('args', {'pressure' 'Pa' 'Pressure';  ...
'phasefraction' 'mol/mol' 'Vapor Mole fraction';  ...
'chloroform' 'mol' 'Amount chloroform';  ...
'methanol' 'mol' 'Amount methanol'});
model.thermodynamics.feature('pp1').feature('flashcalc1').set('plotargs', {'pressure' '101325' '101325';  ...
'phasefraction' '0.5' '0.5';  ...
'chloroform' '1' '1';  ...
'methanol' '1' '1'});
model.thermodynamics.feature('pp1').feature('flashcalc1').set('derivatives', '');
model.thermodynamics.feature('pp1').feature('flashcalc1').set('SecondDerivatives', '');
model.thermodynamics.feature('pp1').feature('flashcalc1').set('SecondDerivativeIndices', '');
model.thermodynamics.feature('pp1').feature('flashcalc1').set('plotfunction', 'Flash1_1_PhaseExist_Vapor');
model.thermodynamics.feature('pp1').set('WarningState', false);
model.thermodynamics.feature('pp1').set('Warning', {''});

model.variable.create('var1');
model.variable('var1').set('xM', '1-xCh');
model.variable('var1').descr('xM', 'Mole fraction of methanol');
model.variable('var1').set('T_DewPoint', 'Flash1_1_Temperature(P,1,xCh,xM)');
model.variable('var1').descr('T_DewPoint', 'Dew Point');
model.variable('var1').set('T_BubblePoint', 'Flash1_1_Temperature(P,0,xCh,xM)');
model.variable('var1').descr('T_BubblePoint', 'Bubble Point');

model.study.create('std1');
model.study('std1').create('stat', 'Stationary');
model.study('std1').label('Study 1 - Dew Point and Boiling Point Curves');
model.study('std1').feature('stat').set('useparam', true);
model.study('std1').feature('stat').set('sweeptype', 'filled');
model.study('std1').feature('stat').setIndex('pname', 'P', 0);
model.study('std1').feature('stat').setIndex('plistarr', '', 0);
model.study('std1').feature('stat').setIndex('punit', 'Pa', 0);
model.study('std1').feature('stat').setIndex('pname', 'P', 0);
model.study('std1').feature('stat').setIndex('plistarr', '', 0);
model.study('std1').feature('stat').setIndex('punit', 'Pa', 0);
model.study('std1').feature('stat').setIndex('pname', 'xCh', 0);
model.study('std1').feature('stat').setIndex('plistarr', 'range(0,0.01,1)', 0);
model.study('std1').feature('stat').setIndex('punit', '', 0);

model.sol.create('sol1');
model.sol('sol1').study('std1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'stat');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').set('control', 'stat');
model.sol('sol1').create('s1', 'Stationary');
model.sol('sol1').feature('s1').create('p1', 'Parametric');
model.sol('sol1').feature('s1').feature.remove('pDef');
model.sol('sol1').feature('s1').feature('p1').set('control', 'stat');
model.sol('sol1').feature('s1').set('control', 'stat');
model.sol('sol1').attach('std1');
model.sol('sol1').runAll;

model.result.create('pg1', 'PlotGroup1D');
model.result('pg1').run;
model.result('pg1').label('T-x Diagram');
model.result('pg1').set('xlabelactive', true);
model.result('pg1').set('xlabel', 'Molefraction chloroform');
model.result('pg1').set('ylabelactive', true);
model.result('pg1').set('ylabel', 'Temperature / K');
model.result('pg1').create('glob1', 'Global');
model.result('pg1').feature('glob1').set('markerpos', 'datapoints');
model.result('pg1').feature('glob1').set('linewidth', 'preference');
model.result('pg1').feature('glob1').setIndex('expr', 'T_DewPoint', 0);
model.result('pg1').feature('glob1').setIndex('unit', 'K', 0);
model.result('pg1').feature('glob1').setIndex('descr', 'Dew Point', 0);
model.result('pg1').feature('glob1').setIndex('expr', 'T_BubblePoint', 1);
model.result('pg1').feature('glob1').setIndex('unit', 'K', 1);
model.result('pg1').feature('glob1').setIndex('descr', 'Bubble Point', 1);
model.result('pg1').feature('glob1').set('titletype', 'manual');
model.result('pg1').feature('glob1').set('title', 'Chloroform-Methanol Phase Envelope');
model.result('pg1').feature('glob1').set('linestyle', 'cycle');
model.result('pg1').feature('glob1').set('linewidth', 1);
model.result('pg1').run;
model.result('pg1').run;
model.result('pg1').create('ann1', 'Annotation');
model.result('pg1').feature('ann1').set('text', 'Azeotropic composition');
model.result('pg1').feature('ann1').set('posyexpr', 326.03);
model.result('pg1').feature('ann1').set('posxexpr', 0.66);
model.result('pg1').feature('ann1').set('anchorpoint', 'uppermiddle');
model.result('pg1').run;
model.result('pg1').run;
model.result('pg1').set('axislimits', true);
model.result('pg1').set('ymin', 324);
model.result('pg1').set('ymax', 339);
model.result('pg1').run;

model.param.set('n', '0');
model.param.descr('n', 'Vapor phase fraction');

model.variable('var1').set('T_iso', '0.5*(T_DewPoint+T_BubblePoint)');
model.variable('var1').descr('T_iso', 'Isothermal tie-line');

model.modelNode.create('comp1', true);

model.physics.create('ge', 'GlobalEquations');
model.physics('ge').model('comp1');

model.study('std1').feature('stat').setSolveFor('/physics/ge', false);

model.physics('ge').prop('EquationForm').set('form', 'Automatic');
model.physics('ge').feature('ge1').setIndex('name', 'xCh_at_n', 0, 0);
model.physics('ge').feature('ge1').setIndex('equation', 'T_iso-Flash1_1_Temperature(P, n, xCh_at_n[mol], (1-xCh_at_n)[mol])', 0, 0);
model.physics('ge').feature('ge1').setIndex('initialValueU', 'xCh', 0, 0);
model.physics('ge').feature('ge1').set('CustomSourceTermUnit', '1');
model.physics('ge').feature('ge1').set('SourceTermQuantity', 'temperature');
model.physics('ge').feature('ge1').label('xCh at T_iso for Phase n');

model.thermodynamics.feature('pp1').feature.create('singlephase1', 'OnePhaseProperty');
model.thermodynamics.feature('pp1').feature('singlephase1').label('Enthalpy 1');
model.thermodynamics.feature('pp1').feature('singlephase1').set('funcname', 'Enthalpy_chloroform_methanol_Vapor11');
model.thermodynamics.feature('pp1').feature('singlephase1').set('property', 'Enthalpy');
model.thermodynamics.feature('pp1').feature('singlephase1').set('propertydescr', 'Enthalpy');
model.thermodynamics.feature('pp1').feature('singlephase1').set('unit', 'J/mol');
model.thermodynamics.feature('pp1').feature('singlephase1').set('prop_basis', 'mole');
model.thermodynamics.feature('pp1').feature('singlephase1').set('compounds', {'chloroform' 'methanol'});
model.thermodynamics.feature('pp1').feature('singlephase1').set('args', {'temperature' 'K' 'Temperature';  ...
'pressure' 'Pa' 'Pressure';  ...
'molefraction_chloroform' '1' 'Mole fraction chloroform';  ...
'molefraction_methanol' '1' 'Mole fraction methanol'});
model.thermodynamics.feature('pp1').feature('singlephase1').set('plotargs', {'temperature' '298.15' '373.15';  ...
'pressure' '101325' '101325';  ...
'molefraction_chloroform' '0.5' '0.5';  ...
'molefraction_methanol' '0.5' '0.5'});
model.thermodynamics.feature('pp1').feature('singlephase1').set('derivatives', {'Enthalpy_chloroform_methanol_Vapor11_Dtemperature' 'Enthalpy_chloroform_methanol_Vapor11_Dpressure' 'Enthalpy_chloroform_methanol_Vapor11_Dmolefraction_chloroform' 'Enthalpy_chloroform_methanol_Vapor11_Dmolefraction_methanol'});
model.thermodynamics.feature('pp1').feature('singlephase1').set('SecondDerivatives', {});
model.thermodynamics.feature('pp1').feature('singlephase1').set('SecondDerivativeIndices', {});
model.thermodynamics.feature('pp1').feature('singlephase1').set('phase', 'Vapor');
model.thermodynamics.feature('pp1').feature('singlephase1').set('comp_basis', 'mole');
model.thermodynamics.feature('pp1').feature('singlephase1').set('include_derivatives', 'yes');
model.thermodynamics.feature('pp1').set('WarningState', false);
model.thermodynamics.feature('pp1').set('Warning', {''});
model.thermodynamics.feature('pp1').feature('singlephase1').set('funcname', 'hv');
model.thermodynamics.feature('pp1').feature.create('singlephase2', 'OnePhaseProperty');
model.thermodynamics.feature('pp1').feature('singlephase2').label('Enthalpy 2');
model.thermodynamics.feature('pp1').feature('singlephase2').set('funcname', 'Enthalpy_chloroform_methanol_Liquid12');
model.thermodynamics.feature('pp1').feature('singlephase2').set('property', 'Enthalpy');
model.thermodynamics.feature('pp1').feature('singlephase2').set('propertydescr', 'Enthalpy');
model.thermodynamics.feature('pp1').feature('singlephase2').set('unit', 'J/mol');
model.thermodynamics.feature('pp1').feature('singlephase2').set('prop_basis', 'mole');
model.thermodynamics.feature('pp1').feature('singlephase2').set('compounds', {'chloroform' 'methanol'});
model.thermodynamics.feature('pp1').feature('singlephase2').set('args', {'temperature' 'K' 'Temperature';  ...
'pressure' 'Pa' 'Pressure';  ...
'molefraction_chloroform' '1' 'Mole fraction chloroform';  ...
'molefraction_methanol' '1' 'Mole fraction methanol'});
model.thermodynamics.feature('pp1').feature('singlephase2').set('plotargs', {'temperature' '298.15' '373.15';  ...
'pressure' '101325' '101325';  ...
'molefraction_chloroform' '0.5' '0.5';  ...
'molefraction_methanol' '0.5' '0.5'});
model.thermodynamics.feature('pp1').feature('singlephase2').set('derivatives', {'Enthalpy_chloroform_methanol_Liquid12_Dtemperature' 'Enthalpy_chloroform_methanol_Liquid12_Dpressure' 'Enthalpy_chloroform_methanol_Liquid12_Dmolefraction_chloroform' 'Enthalpy_chloroform_methanol_Liquid12_Dmolefraction_methanol'});
model.thermodynamics.feature('pp1').feature('singlephase2').set('SecondDerivatives', {});
model.thermodynamics.feature('pp1').feature('singlephase2').set('SecondDerivativeIndices', {});
model.thermodynamics.feature('pp1').feature('singlephase2').set('phase', 'Liquid');
model.thermodynamics.feature('pp1').feature('singlephase2').set('comp_basis', 'mole');
model.thermodynamics.feature('pp1').feature('singlephase2').set('include_derivatives', 'yes');
model.thermodynamics.feature('pp1').set('WarningState', false);
model.thermodynamics.feature('pp1').set('Warning', {''});
model.thermodynamics.feature('pp1').feature('singlephase2').set('funcname', 'hl');

model.param.set('Tref', '273.15[K]');
model.param.descr('Tref', 'Reference temperature');

model.variable.create('var2');
model.variable('var2').model('comp1');
model.variable('var2').set('xM_at_n', '1-comp1.xCh_at_n');
model.variable('var2').descr('xM_at_n', '');
model.variable('var2').set('hVapor', 'hv(T_iso,P,comp1.xCh_at_n,xM_at_n)');
model.variable('var2').descr('hVapor', 'Enthalpy of Vapor');
model.variable('var2').set('hLiquid', 'hl(T_iso,P,comp1.xCh_at_n,xM_at_n)');
model.variable('var2').descr('hLiquid', 'Enthalpy of Liquid');
model.variable('var2').set('hMix', 'n*hVapor+(1-n)*hLiquid');
model.variable('var2').descr('hMix', 'Enthalpy of Vapor/Liquid mixture');

model.study.create('std2');
model.study('std2').create('stat', 'Stationary');
model.study('std2').feature('stat').setSolveFor('/physics/ge', true);
model.study('std2').feature('stat').set('useparam', true);
model.study('std2').feature('stat').setIndex('pname', 'P', 0);
model.study('std2').feature('stat').setIndex('plistarr', '', 0);
model.study('std2').feature('stat').setIndex('punit', 'Pa', 0);
model.study('std2').feature('stat').setIndex('pname', 'P', 0);
model.study('std2').feature('stat').setIndex('plistarr', '', 0);
model.study('std2').feature('stat').setIndex('punit', 'Pa', 0);
model.study('std2').feature('stat').setIndex('pname', 'xCh', 0);
model.study('std2').feature('stat').setIndex('plistarr', '1e-6 range(0.1,0.1,0.9) 1-1e-6', 0);
model.study('std2').feature('stat').setIndex('punit', '', 0);
model.study('std2').feature('stat').setIndex('pname', 'P', 1);
model.study('std2').feature('stat').setIndex('plistarr', '', 1);
model.study('std2').feature('stat').setIndex('punit', 'Pa', 1);
model.study('std2').feature('stat').setIndex('pname', 'P', 1);
model.study('std2').feature('stat').setIndex('plistarr', '', 1);
model.study('std2').feature('stat').setIndex('punit', 'Pa', 1);
model.study('std2').feature('stat').setIndex('pname', 'n', 1);
model.study('std2').feature('stat').setIndex('plistarr', 'range(0,.1,1)', 1);
model.study('std2').feature('stat').setIndex('punit', '', 1);
model.study('std2').feature('stat').set('sweeptype', 'filled');
model.study('std2').feature('stat').set('pcontinuationmode', 'manual');
model.study('std2').feature('stat').set('pcontinuation', 'xCh');

model.sol.create('sol2');
model.sol('sol2').study('std2');
model.sol('sol2').create('st1', 'StudyStep');
model.sol('sol2').feature('st1').set('study', 'std2');
model.sol('sol2').feature('st1').set('studystep', 'stat');
model.sol('sol2').create('v1', 'Variables');
model.sol('sol2').feature('v1').set('control', 'stat');
model.sol('sol2').create('s1', 'Stationary');
model.sol('sol2').feature('s1').create('p1', 'Parametric');
model.sol('sol2').feature('s1').feature.remove('pDef');
model.sol('sol2').feature('s1').feature('p1').set('control', 'stat');
model.sol('sol2').feature('s1').set('control', 'stat');
model.sol('sol2').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol2').feature('s1').feature('fc1').set('linsolver', 'dDef');
model.sol('sol2').feature('s1').feature.remove('fcDef');
model.sol('sol2').attach('std2');
model.sol('sol2').runAll;

model.result.numerical.create('gev1', 'EvalGlobal');
model.result.numerical('gev1').set('data', 'dset2');
model.result.numerical('gev1').set('expr', {'xCh_at_n'});
model.result.numerical('gev1').set('descr', {'State variable xCh_at_n'});

model.study('std2').label('Study 2 - Isotherm Curves');

model.result.setOnlyPlotWhenRequested(true);
model.result.create('pg2', 'PlotGroup1D');
model.result('pg2').create('glob1', 'Global');
model.result('pg2').feature('glob1').set('markerpos', 'datapoints');
model.result('pg2').feature('glob1').set('linewidth', 'preference');
model.result('pg2').label('H-x Diagram');
model.result('pg2').set('data', 'dset2');
model.result('pg2').set('legendpos', 'center');
model.result('pg2').feature('glob1').label('Dew Line');
model.result('pg2').feature('glob1').set('data', 'dset2');
model.result('pg2').feature('glob1').setIndex('looplevelinput', 'last', 1);
model.result('pg2').feature('glob1').setIndex('expr', 'hv(T_DewPoint,P,xCh,xM)', 0);
model.result('pg2').feature('glob1').setIndex('unit', 'kJ/mol', 0);
model.result('pg2').feature('glob1').setIndex('descr', '', 0);
model.result('pg2').feature('glob1').set('titletype', 'none');
model.result('pg2').feature('glob1').set('linestyle', 'dashed');
model.result('pg2').feature('glob1').set('linewidth', 2);
model.result('pg2').feature('glob1').set('autoplotlabel', true);
model.result('pg2').feature('glob1').set('autosolution', false);
model.result('pg2').feature('glob1').set('autodescr', false);
model.result('pg2').create('glob2', 'Global');
model.result('pg2').feature('glob2').set('markerpos', 'datapoints');
model.result('pg2').feature('glob2').set('linewidth', 'preference');
model.result('pg2').feature('glob2').label('Boiling Line');
model.result('pg2').feature('glob2').set('data', 'dset2');
model.result('pg2').feature('glob2').setIndex('looplevelinput', 'first', 1);
model.result('pg2').feature('glob2').setIndex('expr', 'hl(T_BubblePoint,P,xCh,1-xCh)', 0);
model.result('pg2').feature('glob2').setIndex('unit', 'kJ/mol', 0);
model.result('pg2').feature('glob2').setIndex('descr', '', 0);
model.result('pg2').feature('glob2').set('titletype', 'none');
model.result('pg2').feature('glob2').set('linestyle', 'dotted');
model.result('pg2').feature('glob2').set('linewidth', 2);
model.result('pg2').feature('glob2').set('autoplotlabel', true);
model.result('pg2').feature('glob2').set('autosolution', false);
model.result('pg2').feature('glob2').set('autodescr', false);
model.result('pg2').set('xlabelactive', true);
model.result('pg2').set('xlabel', 'Molefraction chloroform');
model.result('pg2').set('ylabelactive', true);
model.result('pg2').set('ylabel', 'Enthalpy / kJ \cdot mol<sup>-1</sup>');
model.result('pg2').create('glob3', 'Global');
model.result('pg2').feature('glob3').set('markerpos', 'datapoints');
model.result('pg2').feature('glob3').set('linewidth', 'preference');
model.result('pg2').feature('glob3').label('Isotherms');
model.result('pg2').feature('glob3').set('data', 'dset2');
model.result('pg2').feature('glob3').setIndex('expr', 'hMix', 0);
model.result('pg2').feature('glob3').setIndex('unit', 'kJ/mol', 0);
model.result('pg2').feature('glob3').setIndex('descr', '', 0);
model.result('pg2').feature('glob3').set('titletype', 'manual');
model.result('pg2').feature('glob3').set('title', 'H-x diagram with color coded temperature (K). Solid lines describe isothermal tie lines.');
model.result('pg2').feature('glob3').set('xdata', 'expr');
model.result('pg2').feature('glob3').set('xdatasolnumtype', 'level2');
model.result('pg2').feature('glob3').set('linewidth', 2);
model.result('pg2').feature('glob3').set('legend', false);
model.result('pg2').feature('glob1').create('col1', 'Color');
model.result('pg2').feature('glob1').feature('col1').set('expr', 'T_DewPoint');
model.result('pg2').feature('glob1').feature('col1').set('colortable', 'Viridis');
model.result('pg2').feature('glob1').feature('col1').set('colorlegend', false);
model.result('pg2').feature('glob2').feature.copy('col1', 'pg2/glob1/col1');
model.result('pg2').feature('glob2').feature('col1').set('expr', 'T_BubblePoint');
model.result('pg2').feature('glob3').feature.copy('col1', 'pg2/glob1/col1');
model.result('pg2').feature('glob3').feature('col1').set('expr', 'T_iso');
model.result('pg2').feature('glob3').feature('col1').set('colorlegend', true);
model.result('pg2').run;

model.title('Creating Phase Envelopes by Using Equilibrium Calculations');

model.description(['In this example, a phase envelope is constructed for a nonideal chloroform/methanol mixture. First a temperature' native2unicode(hex2dec({'20' '13'}), 'unicode') 'composition diagram is constructed, highlighting an azeotrope of the mixture. Additionally an enthalpy' native2unicode(hex2dec({'20' '13'}), 'unicode') 'composition diagram is generated, and isotherms are plotted. These kinds of diagrams are fundamental for understanding, for example, distillation or flash evaporation processes. This model shows how the Thermodynamics node can be used to create these familiar kinds of diagrams.']);

model.label('phase_envelope.mph');

model.modelNode.label('Components');

out = model;
