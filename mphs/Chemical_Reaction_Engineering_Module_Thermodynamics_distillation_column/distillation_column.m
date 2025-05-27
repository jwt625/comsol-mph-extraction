function out = model
%
% distillation_column.m
%
% Model exported on May 26 2025, 21:27 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/Chemical_Reaction_Engineering_Module/Thermodynamics');

model.modelNode.create('comp1', true);

model.physics.create('re', 'ReactionEng');
model.physics('re').model('comp1');
model.physics('re').create('spec1', 'SpeciesChem', -1);
model.physics('re').feature('spec1').set('specName', 'E');
model.physics('re').create('spec1', 'SpeciesChem', -1);
model.physics('re').feature('spec1').set('specName', 'W');

model.thermodynamics.feature.create('pp1', 'BuiltinPropertyPackage');
model.thermodynamics.feature('pp1').set('compoundlist', {'ethanol' '64-17-5' 'C2H6O' 'COMSOL'; 'water' '7732-18-5' 'H2O' 'COMSOL'});
model.thermodynamics.feature('pp1').set('phase_list', {'Vapor' 'Vapor'; 'Liquid' 'Liquid'});
model.thermodynamics.feature('pp1').label('Vapor-Liquid System 1');
model.thermodynamics.feature('pp1').set('manager_id', 'COMSOL');
model.thermodynamics.feature('pp1').set('manager_version', '1.0');
model.thermodynamics.feature('pp1').set('packagename', 'pp1');
model.thermodynamics.feature('pp1').set('package_desc', 'Built-in property package');
model.thermodynamics.feature('pp1').set('managerindex', '0');
model.thermodynamics.feature('pp1').set('packageid', 'COMSOL1');
model.thermodynamics.feature('pp1').set('ThermodynamicModel', 'NRTL');
model.thermodynamics.feature('pp1').set('EOS', 'SoaveRedlichKwong');
model.thermodynamics.feature('pp1').set('LiquidPhaseModel', 'NRTL');
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

model.physics('re').prop('mixture').set('Thermodynamics', true);
model.physics('re').prop('SpeciesMatching').setIndex('PackageSpecies', 'ethanol', 0, 0);
model.physics('re').prop('SpeciesMatching').setIndex('PackageSpecies', 'water', 1, 0);

model.thermodynamics.feature('pp1').feature.create('flashcalc1', 'FlashCalculationProperty');
model.thermodynamics.feature('pp1').feature.remove('flashcalc1');
model.thermodynamics.feature('pp1').feature.create('flashcalc1', 'FlashCalculationProperty');
model.thermodynamics.feature('pp1').feature('flashcalc1').set('funcname', 'flashcalc1');
model.thermodynamics.feature('pp1').feature('flashcalc1').set('property', 'FlashCalculationProperty');
model.thermodynamics.feature('pp1').feature('flashcalc1').set('propertydescr', 'Equilibrium calculation');
model.thermodynamics.feature('pp1').feature('flashcalc1').set('dvars', {'0' '0' '0' '0'});
model.thermodynamics.feature('pp1').feature('flashcalc1').set('compounds', {'ethanol' 'water'});
model.thermodynamics.feature('pp1').feature('flashcalc1').set('functions', {'Flash1_1_PhaseExist_Vapor' '1' 'Presence of Vapor phase';  ...
'Flash1_1_PhaseExist_Liquid' '1' 'Presence of Liquid phase';  ...
'Flash1_1_Temperature' 'K' 'Temperature';  ...
'Flash1_1_PhaseAmount_Vapor' 'mol' 'Amount in Vapor phase';  ...
'Flash1_1_PhaseAmount_Liquid' 'mol' 'Amount in Liquid phase';  ...
'Flash1_1_PhaseComposition_Vapor_ethanol' 'mol/mol' 'Fraction of ethanol in Vapor phase';  ...
'Flash1_1_PhaseComposition_Vapor_water' 'mol/mol' 'Fraction of water in Vapor phase';  ...
'Flash1_1_PhaseComposition_Liquid_ethanol' 'mol/mol' 'Fraction of ethanol in Liquid phase';  ...
'Flash1_1_PhaseComposition_Liquid_water' 'mol/mol' 'Fraction of water in Liquid phase'});
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
'ethanol' 'mol' 'Amount ethanol';  ...
'water' 'mol' 'Amount water'});
model.thermodynamics.feature('pp1').feature('flashcalc1').set('plotargs', {'pressure' '101325' '101325';  ...
'phasefraction' '0.5' '0.5';  ...
'ethanol' '1' '1';  ...
'water' '1' '1'});
model.thermodynamics.feature('pp1').feature('flashcalc1').set('derivatives', '');
model.thermodynamics.feature('pp1').feature('flashcalc1').set('SecondDerivatives', '');
model.thermodynamics.feature('pp1').feature('flashcalc1').set('SecondDerivativeIndices', '');
model.thermodynamics.feature('pp1').feature('flashcalc1').set('plotfunction', 'Flash1_1_PhaseExist_Vapor');
model.thermodynamics.feature('pp1').set('WarningState', false);
model.thermodynamics.feature('pp1').set('Warning', {''});

model.func.create('an1', 'Analytic');
model.func('an1').set('funcname', 'x_y');
model.func('an1').set('expr', 'Flash1_1_PhaseComposition_Vapor_ethanol(p,n,x1,x2)');
model.func('an1').set('args', 'p,n,x1,x2');
model.func('an1').setIndex('argunit', 'Pa', 0);
model.func('an1').setIndex('argunit', 1, 1);
model.func('an1').setIndex('argunit', 'mol/mol', 2);
model.func('an1').setIndex('argunit', 'mol/mol', 3);
model.func('an1').set('fununit', 'mol/mol');

% To import content from file, use:
% model.param.loadFile('FILENAME');
model.param.set('T', '298.15[K]', 'Temperature parameter');
model.param.set('P', '101325[Pa]', 'Pressure parameter');
model.param.set('n', '1', 'Vapor phase fraction');
model.param.set('x1', '1', 'Mole fraction species 1');
model.param.set('x2', '1-x1', 'Mole fraction species 2');
model.param.set('F', '2500[mol/h]', 'Feed rate');
model.param.set('xf', '0.5', 'Feed mole fraction, more volatile species');
model.param.set('xd', '0.85', 'Distillate mole fraction, more volatile species');
model.param.set('xb', '0.05', 'Bottoms mole fraction, more volatile species');
model.param.set('Vr', '2.5*F', 'Vapor rate rectifying');
model.param.set('Vs', 'Vr', 'Vapor rate stripping');
model.param.set('B', 'F*(xf-xd)/(xb-xd)', 'Bottoms rate');
model.param.set('D', 'F-B', 'Distillate rate');
model.param.set('Lr', 'Vr-D', 'Liquid rate rectifying');
model.param.set('Ls', 'Lr+F', 'Liquid rate stripping');
model.param.set('RR', 'Lr/D', 'Reflux ratio');
model.param.set('Kya', '75[mol/m^3/s]', 'Mass transfer coefficient');
model.param.set('R', '0.12[m]', 'Column radius');
model.param.set('A', 'pi*(R)^2', 'Column cross-sectional area');
model.param.set('H', '12[m]', 'Total column height');
model.param.set('Hs', '1.2[m]', 'Height of stripping section');
model.param.set('Hr', 'H-Hs', 'Height of rectifying section');
model.param.set('uV', 'Vr*0.022414[m^3/mol]/A', 'Vapor velocity');
model.param.set('uLr', 'Lr*0.022414[m^3/mol]/A', 'Liquid velocity rectifying');
model.param.set('uLs', 'Ls*0.022414[m^3/mol]/A', 'Liquid velocity stripping');

model.study.create('std1');
model.study('std1').create('stat', 'Stationary');
model.study('std1').feature('stat').setSolveFor('/physics/re', false);
model.study('std1').feature('stat').set('useparam', true);
model.study('std1').feature('stat').setIndex('pname', 'T', 0);
model.study('std1').feature('stat').setIndex('plistarr', '', 0);
model.study('std1').feature('stat').setIndex('punit', 'K', 0);
model.study('std1').feature('stat').setIndex('pname', 'T', 0);
model.study('std1').feature('stat').setIndex('plistarr', '', 0);
model.study('std1').feature('stat').setIndex('punit', 'K', 0);
model.study('std1').feature('stat').setIndex('pname', 'n', 0);
model.study('std1').feature('stat').setIndex('pname', 'T', 1);
model.study('std1').feature('stat').setIndex('plistarr', '', 1);
model.study('std1').feature('stat').setIndex('punit', 'K', 1);
model.study('std1').feature('stat').setIndex('pname', 'T', 1);
model.study('std1').feature('stat').setIndex('plistarr', '', 1);
model.study('std1').feature('stat').setIndex('punit', 'K', 1);
model.study('std1').feature('stat').setIndex('plistarr', '0 1', 0);
model.study('std1').feature('stat').setIndex('pname', 'x1', 1);
model.study('std1').feature('stat').setIndex('plistarr', 'range(0,0.01,1)', 1);
model.study('std1').feature('stat').set('sweeptype', 'filled');

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
model.result('pg1').create('glob1', 'Global');
model.result('pg1').feature('glob1').set('markerpos', 'datapoints');
model.result('pg1').feature('glob1').set('linewidth', 'preference');
model.result('pg1').feature('glob1').set('expr', {});
model.result('pg1').feature('glob1').set('descr', {});
model.result('pg1').feature('glob1').setIndex('expr', 'x_y(P,n,x1,x2)', 0);
model.result('pg1').feature('glob1').setIndex('unit', 1, 0);
model.result('pg1').feature('glob1').setIndex('descr', '', 0);
model.result('pg1').feature('glob1').set('legend', false);
model.result('pg1').run;
model.result('pg1').feature('glob1').set('linewidth', 2);
model.result('pg1').run;
model.result('pg1').label('Equilibrium Curve');
model.result('pg1').set('xlabelactive', true);
model.result('pg1').set('ylabelactive', true);
model.result('pg1').set('ylabel', 'y1');
model.result('pg1').set('titletype', 'none');
model.result('pg1').set('legendpos', 'middleright');

model.study('std1').label('Equilibrium Curve Parameterization');

model.physics('re').create('sync1', 'ReactionToMph', -1);
model.physics('re').feature('sync1').set('geomToUse', '1D');
model.physics('re').feature('sync1').set('massbalance', 'ConcentratedSpecies');
model.physics('re').prop('synchronize').set('synchronize', '1');

model.modelNode.create('comp2', true);

model.physics('re').feature('sync1').set('model', {'comp2'});

model.geom.create('geom1', 1);
model.geom('geom1').model('comp2');
model.geom('geom1').axisymmetric(false);
model.geom('geom1').label('Geometry 1(1D)');

model.physics('re').feature('sync1').set('genom', {'geom1'});

model.mesh.create('mesh1', 'geom1');

model.study.create('std2');

model.physics('re').feature('sync1').set('studyname', {'std2'});

model.study('std2').create('stat', 'Stationary');

model.physics.create('chem1', 'Chemistry', 'geom1');
model.physics('chem1').model('comp2');
model.physics('re').feature('sync1').set('Chemistry', {'chem1'});
model.physics.create('tcs', 'ConcentratedSpecies', 'geom1');
model.physics('tcs').model('comp2');
model.physics('tcs').prop('AdvancedSettings').set('UsePseudoTime', true);
model.physics('chem1').prop('mixture').set('updatechem', '0');
model.physics('chem1').prop('mixture').set('mixture', 'gas');
model.physics('chem1').prop('Activity').set('useActivity', '0');
model.physics('chem1').prop('chemkin').set('chemkin', '0');
model.physics('chem1').prop('ChemistryCommonProperty').set('VolumetricConcentrationGlobalActivityStandardState', '1[mol/m^3]');
model.physics('chem1').prop('ChemistryCommonProperty').set('SurfaceSpeciesConcentrationType', 'SurfaceConcentration');
model.physics('chem1').prop('ChemistryCommonProperty').set('SurfaceGlobalActivityStandardState', '1[mol/m^2]');
model.physics('chem1').prop('ChemistryCommonProperty').set('SpeciesrateUserDefinedList', {});
model.physics('chem1').prop('ChemistryCommonProperty').set('AdditionalSourceFeature', '0');
model.physics('chem1').prop('ActiveSpecies').set('SumActiveSpecies', '2');
model.physics('chem1').prop('ActiveSpecies').set('NumActiveVolumeSpecies', '2');
model.physics('chem1').prop('ActiveSpecies').set('NumActiveSurfaceSpecies', '0');
model.physics('chem1').prop('ActiveSpecies').set('NumActiveSurfaceSpeciesVariable', '0');
model.physics('chem1').prop('ActiveSpecies').set('surface', '0');
model.physics('chem1').prop('solventIsSet').set('solventIsSet', '0');
model.physics('chem1').create('E', 'SpeciesChem');
model.physics('chem1').feature('E').set('SpeciesSource', 'FreeSpecies');
model.physics('chem1').feature('E').set('sisDef', '1');
model.physics('chem1').feature('E').set('specLabel', 'E');
model.physics('chem1').feature('E').set('speciesNameInput', 'E');
model.physics('chem1').feature('E').set('specName', 'E');
model.physics('chem1').feature('E').set('enableChemicalFormulaCheckbox', '0');
model.physics('chem1').feature('E').set('chemicalFormula', '');
model.physics('chem1').feature('E').label('Species: E');
model.physics('chem1').feature('E').active(true);
model.physics('chem1').feature('E').set('sType', 'volumetric');
model.physics('chem1').feature('E').set('M', '0.0[kg/mol]');
model.physics('chem1').feature('E').set('z', '0');
model.physics('chem1').feature('E').set('sigma', '3.458[angstrom]');
model.physics('chem1').feature('E').set('epsilonkb', '107.4[K]');
model.physics('chem1').feature('E').set('mu', '0[C*m]');
model.physics('chem1').feature('E').set('rho', '1000[kg/m^3]');
model.physics('chem1').feature('E').set('k', '0.02[W/(m*K)]');
model.physics('chem1').feature('E').set('ActivityCoefficient', '1');
model.physics('chem1').feature('E').set('cLock', '0');
model.physics('chem1').feature('E').set('Dependent', '0');
model.physics('chem1').feature('E').set('dependent', '0');
model.physics('chem1').feature('E').set('SpeciesrateSelection', 'Automatic');
model.physics('chem1').feature('E').set('AdditionalSource', '1');
model.physics('chem1').feature('E').set('AddR', '0');
model.physics('chem1').create('W', 'SpeciesChem');
model.physics('chem1').feature('W').set('SpeciesSource', 'FreeSpecies');
model.physics('chem1').feature('W').set('sisDef', '1');
model.physics('chem1').feature('W').set('specLabel', 'W');
model.physics('chem1').feature('W').set('speciesNameInput', 'W');
model.physics('chem1').feature('W').set('specName', 'W');
model.physics('chem1').feature('W').set('enableChemicalFormulaCheckbox', '1');
model.physics('chem1').feature('W').set('chemicalFormula', 'W');
model.physics('chem1').feature('W').label('Species: W');
model.physics('chem1').feature('W').active(true);
model.physics('chem1').feature('W').set('sType', 'volumetric');
model.physics('chem1').feature('W').set('M', '183.84[g/mol]');
model.physics('chem1').feature('W').set('z', '0');
model.physics('chem1').feature('W').set('sigma', '3.458[angstrom]');
model.physics('chem1').feature('W').set('epsilonkb', '107.4[K]');
model.physics('chem1').feature('W').set('mu', '0[C*m]');
model.physics('chem1').feature('W').set('rho', '1000[kg/m^3]');
model.physics('chem1').feature('W').set('k', '0.02[W/(m*K)]');
model.physics('chem1').feature('W').set('ActivityCoefficient', '1');
model.physics('chem1').feature('W').set('cLock', '0');
model.physics('chem1').feature('W').set('Dependent', '0');
model.physics('chem1').feature('W').set('dependent', '0');
model.physics('chem1').feature('W').set('SpeciesrateSelection', 'Automatic');
model.physics('chem1').feature('W').set('AdditionalSource', '1');
model.physics('chem1').feature('W').set('AddR', '0');
model.physics('chem1').prop('simpropChem').set('rSequenceNo', '0');
model.physics('chem1').prop('simpropChem').set('sSequenceNo', '2');
model.physics('chem1').prop('mixture').set('hasPropertyPackage', '1');
model.physics('chem1').prop('mixture').set('PropertyPackage', 'pp1');
model.physics('chem1').prop('mixture').set('Thermodynamics', '1');
model.physics('chem1').prop('ChemistryModelInputParameter').set('PackageSpecies', {'ethanol' 'water'});
model.physics('chem1').prop('mixture').set('FullyCoupled', '1');
model.physics('chem1').prop('mixture').set('gasDensitySel', 'Thermodynamics');
model.physics('chem1').prop('mixture').set('liquidDensitySel', 'Thermodynamics');
model.physics('chem1').prop('calcTransport').set('heatCapacitySel', 'Thermodynamics');
model.physics('chem1').prop('calcTransport').set('thermalConductivitySel', 'Thermodynamics');
model.physics('chem1').prop('calcTransport').set('dynamicViscositySel', 'Thermodynamics');
model.physics('chem1').feature('E').set('MolarMassSelection', 'Thermodynamics');
model.physics('chem1').feature('E').set('liquidDensitySel', 'Thermodynamics');
model.physics('chem1').feature('E').set('GasThermalConductivitySel', 'Thermodynamics');
model.physics('chem1').feature('E').set('GasDiffusivitySel', 'Thermodynamics');
model.physics('chem1').feature('E').set('LiquidDiffusivitySel', 'Thermodynamics');
model.physics('chem1').feature('E').set('speciesEnthalpy', 'Thermodynamics');
model.physics('chem1').feature('E').set('Thermodynamics', '1');
model.physics('chem1').feature('W').set('MolarMassSelection', 'Thermodynamics');
model.physics('chem1').feature('W').set('liquidDensitySel', 'Thermodynamics');
model.physics('chem1').feature('W').set('GasThermalConductivitySel', 'Thermodynamics');
model.physics('chem1').feature('W').set('GasDiffusivitySel', 'Thermodynamics');
model.physics('chem1').feature('W').set('LiquidDiffusivitySel', 'Thermodynamics');
model.physics('chem1').feature('W').set('speciesEnthalpy', 'Thermodynamics');
model.physics('chem1').feature('W').set('Thermodynamics', '1');
model.physics('chem1').prop('mixture').set('updatechem', '1');

model.thermodynamics.feature('pp1').set('physicsID', 'chem1');
model.thermodynamics.feature('pp1').set('FunctionList', {'M' 'sigma' 'epsilonkb' 'mu' 'M' 'sigma' 'epsilonkb' 'mu' 'rho' 'hF'  ...
'h' 'sF' 'Cp' 'gamma' 'D' 'k' 'eta';  ...
'ethanol' 'ethanol' 'ethanol' 'ethanol' 'water' 'water' 'water' 'water' 'ethanol:water' 'ethanol:water'  ...
'ethanol:water' 'ethanol:water' 'ethanol:water' 'ethanol:water' 'ethanol:water:none' 'ethanol:water' 'ethanol:water';  ...
'CONSTANT' 'CONSTANT' 'CONSTANT' 'CONSTANT' 'CONSTANT' 'CONSTANT' 'CONSTANT' 'CONSTANT' 'ONEPHASE' 'ONEPHASE'  ...
'ONEPHASE' 'ONEPHASE' 'ONEPHASE' 'ONEPHASE' 'ONEPHASE' 'ONEPHASE' 'ONEPHASE';  ...
'mole' 'mole' 'mole' 'mole' 'mole' 'mole' 'mole' 'mole' 'mass' 'mole'  ...
'mass' 'mole' 'mole' 'mole' 'mole' 'mole' 'mole';  ...
'mole' 'mole' 'mole' 'mole' 'mole' 'mole' 'mole' 'mole' 'mole' 'mole'  ...
'mass' 'mole' 'mole' 'mole' 'mole' 'mole' 'mole'});
model.thermodynamics.feature('pp1').set('Create', '0');

model.physics('tcs').field('massfraction').component({'wE' 'wW'});
model.physics('tcs').feature('init1').set('w0', {'0.5' '0.5'});
model.physics('tcs').feature.create('reac1', 'ReactionSources');
model.physics('tcs').feature('reac1').selection.all;
model.physics('tcs').feature('reac1').set('MassTransferToOtherPhases', true);
model.physics('tcs').feature('reac1').set('ReactingVolumeType', 'TotalVolume');
model.physics('chem1').prop('mixture').set('ConcentrationType', 'MassFraction');
model.physics('chem1').prop('calcTransport').set('calcTransport', '1');
model.physics('tcs').feature('cdm1').set('rho_src', 'root.comp2.chem.rho_chem');
model.physics('chem1').prop('ChemistryModelInputParameter').set('MassTransfer', 'tcs');
model.physics('chem1').prop('ChemistryModelInputParameter').set('ConcentrationInput', {'wE' 'wW'});
model.physics('chem1').prop('ChemistryModelInputParameter').set('ConcentrationValue', {'Solved for' 'Solved for'});
model.physics('chem1').prop('ChemistryModelInputParameter').set('uselog', {'1' '1'});
model.physics('chem1').prop('ChemistryModelInputParameter').set('SolidConcentration', {});
model.physics('chem1').prop('ChemistryModelInputParameter').set('csurf', {});
model.physics('chem1').prop('ChemistryModelInputParameter').set('AqueousSpeciesConcentration', {});
model.physics('tcs').feature('sp1').set('M_wE_src', 'root.comp2.chem.M_E');
model.physics('tcs').feature('sp1').set('M_wW_src', 'root.comp2.chem.M_W');
model.physics('tcs').feature('sp1').set('z', {'0' '0'});
model.physics('tcs').feature('cdm1').set('Dik', {'1' 'comp2.chem.D_E_W' 'comp2.chem.D_E_W' '1'});
model.physics('tcs').feature('cdm1').setIndex('DiffusivityFrom', 'comp2.chem.D_E_W', 0, 0);
model.physics('tcs').feature('reac1').setIndex('R_wE_src', 'root.comp2.chem.Rw_E', 0);
model.physics('tcs').feature('reac1').setIndex('R_wW_src', 'root.comp2.chem.Rw_W', 0);
model.physics('re').feature('sync1').set('geomToUse', 'geom1');
model.physics('re').feature('sync1').set('massbalance', 'tcs');
model.physics('re').feature('sync1').set('genom', {'geom1'});
model.physics('re').feature('sync1').set('studyname', {'std2'});
model.physics('chem1').prop('StudyStep').set('StudyStep', 'std2/stat');
model.physics('chem1').feature('dcont1').set('StudyStep', 'std2/stat');
model.physics('chem1').feature('E').set('StudyStep', 'std2/stat');
model.physics('chem1').feature('W').set('StudyStep', 'std2/stat');
model.physics('tcs').prop('StudyStep').set('StudyStep', 'std2/stat');
model.physics('tcs').feature('sp1').set('StudyStep', 'std2/stat');
model.physics('tcs').feature('cdm1').set('StudyStep', 'std2/stat');
model.physics('tcs').feature('init1').set('StudyStep', 'std2/stat');
model.physics('tcs').feature('nflx1').set('StudyStep', 'std2/stat');
model.physics('tcs').feature('dcont1').set('StudyStep', 'std2/stat');
model.physics('tcs').feature('reac1').set('StudyStep', 'std2/stat');

model.study('std1').feature('stat').setSolveFor('/physics/chem1', false);
model.study('std1').feature('stat').setSolveFor('/physics/tcs', false);
model.study('std2').feature('stat').setSolveFor('/physics/re', false);

model.geom('geom1').run;
model.geom('geom1').create('i1', 'Interval');
model.geom('geom1').feature('i1').setIndex('coord', 'Hs', 1);
model.geom('geom1').run('i1');
model.geom('geom1').feature.duplicate('i2', 'i1');
model.geom('geom1').feature('i2').setIndex('coord', 'Hs', 0);
model.geom('geom1').feature('i2').setIndex('coord', 'H', 1);
model.geom('geom1').runPre('fin');
model.geom('geom1').run;

model.physics('tcs').prop('SpeciesProperties').set('FromMassConstraint', 2);
model.physics.create('tcs2', 'ConcentratedSpecies', 'geom1', {'wEl' 'wWl'});

model.study('std1').feature('stat').setSolveFor('/physics/tcs2', true);
model.study('std2').feature('stat').setSolveFor('/physics/tcs2', true);

model.physics('tcs2').prop('SpeciesProperties').set('FromMassConstraint', 2);

model.variable.create('var1');
model.variable('var1').model('comp2');

% To import content from file, use:
% model.variable('var1').loadFile('FILENAME');
model.variable('var1').set('ym1', 'tcs.x_wE', 'Vapor mole fraction, more volatile species');
model.variable('var1').set('xm1', 'tcs2.x_wEl', 'Liquid mole fraction, more volatile species');
model.variable('var1').set('xm2', '1-xm1', 'Liquid mole fraction, less volatile species');
model.variable('var1').set('ye1', 'x_y(101325,0,xm1,xm2)', 'Equilibrium mole fraction, more volatile species in vapor for given liquid condition');
model.variable('var1').set('wf', 'xf*tcs.M_wE/(xf*tcs.M_wE+(1-xf)*tcs.M_wW)', 'Feed mass fraction, more volatile species');
model.variable('var1').set('wb', 'xb*tcs.M_wE/(xb*tcs.M_wE+(1-xb)*tcs.M_wW)', 'Bottoms mass fraction, more volatile species');
model.variable('var1').set('wd', 'xd*tcs.M_wE/(xd*tcs.M_wE+(1-xd)*tcs.M_wW)', 'Distillate mass fraction, more volatile species');

model.common('cminpt').set('modified', {'temperature' 'T'; 'pressure' 'P'});

model.physics('tcs').feature('cdm1').set('rho_src', 'IdealGas');
model.physics('tcs').feature('cdm1').set('u', {'uV' '0' '0'});
model.physics('tcs').feature('init1').setIndex('w0', 'wf', 0);
model.physics('tcs').feature('reac1').setIndex('R_wE_src', 'userdef', 0);
model.physics('tcs').feature('reac1').setIndex('R_wE', '-tcs.M_wE*Kya*(ym1-ye1)', 0);
model.physics('tcs').feature('reac1').setIndex('R_wW_src', 'userdef', 0);
model.physics('tcs').feature('reac1').setIndex('R_wW', 'tcs.M_wW*Kya*(ym1-ye1)', 0);
model.physics('tcs').create('mf1', 'MassFraction', 0);
model.physics('tcs').feature('mf1').selection.set([1]);
model.physics('tcs').feature('mf1').setIndex('species', true, 0);
model.physics('tcs').feature('mf1').setIndex('wbnd', 'wb', 0);
model.physics('tcs').create('out1', 'Outflow', 0);
model.physics('tcs').feature('out1').selection.set([3]);
model.physics('tcs2').feature('sp1').setIndex('M_wWl_src', 'root.comp2.chem.M_W', 0);
model.physics('tcs2').feature('sp1').setIndex('M_wEl_src', 'root.comp2.chem.M_E', 0);
model.physics('tcs2').feature('cdm1').set('u', {'-uLr' '0' '0'});
model.physics('tcs2').feature('cdm1').setIndex('DF', '1e-20', 0, 0);
model.physics('tcs2').feature('init1').setIndex('w0', 'wf', 0);
model.physics('tcs2').feature.duplicate('cdm2', 'cdm1');
model.physics('tcs2').feature('cdm2').selection.set([1]);
model.physics('tcs2').feature('cdm2').set('u', {'-uLs' '0' '0'});
model.physics('tcs2').create('mf1', 'MassFraction', 0);
model.physics('tcs2').feature('mf1').selection.set([3]);
model.physics('tcs2').feature('mf1').setIndex('species', true, 0);
model.physics('tcs2').feature('mf1').setIndex('wbnd', 'wd', 0);
model.physics('tcs2').create('mf2', 'MassFraction', 0);
model.physics('tcs2').feature('mf2').selection.set([2]);
model.physics('tcs2').feature('mf2').setIndex('species', true, 0);
model.physics('tcs2').feature('mf2').setIndex('wbnd', 'wf', 0);
model.physics('tcs2').create('out1', 'Outflow', 0);
model.physics('tcs2').feature('out1').selection.set([1]);
model.physics('tcs2').create('reac1', 'ReactionSources', 1);
model.physics('tcs2').feature('reac1').set('MassTransferToOtherPhases', true);
model.physics('tcs2').feature('reac1').setIndex('R_wEl', 'tcs.M_wE*Kya*(ym1-ye1)', 0);
model.physics('tcs2').feature('reac1').setIndex('R_wWl', '-tcs.M_wW*Kya*(ym1-ye1)', 0);
model.physics('tcs2').feature('reac1').selection.set([1 2]);

model.mesh('mesh1').automatic(false);
model.mesh('mesh1').feature('edg1').create('size1', 'Size');
model.mesh('mesh1').feature('edg1').feature('size1').selection.geom('geom1', 0);
model.mesh('mesh1').feature('edg1').feature('size1').selection.set([1 2 3]);
model.mesh('mesh1').feature('edg1').feature('size1').set('table', 'cfd');
model.mesh('mesh1').feature('edg1').feature('size1').set('hauto', 1);
model.mesh('mesh1').run('edg1');

model.study('std2').label('Column Design');
model.study('std2').setGenPlots(false);
model.study('std2').create('param', 'Parametric');
model.study('std2').feature('param').setIndex('pname', 'T', 0);
model.study('std2').feature('param').setIndex('plistarr', '', 0);
model.study('std2').feature('param').setIndex('punit', 'K', 0);
model.study('std2').feature('param').setIndex('pname', 'T', 0);
model.study('std2').feature('param').setIndex('plistarr', '', 0);
model.study('std2').feature('param').setIndex('punit', 'K', 0);
model.study('std2').feature('param').setIndex('pname', 'Hs', 0);
model.study('std2').feature('param').setIndex('plistarr', '1.2 1.3 1.4', 0);

model.sol.create('sol2');

model.mesh('mesh1').stat.selection.geom(1);
model.mesh('mesh1').stat.selection.set([1 2]);
model.mesh('mesh1').stat.selection.geom(1);
model.mesh('mesh1').stat.selection.set([1 2]);

model.sol('sol2').study('std2');
model.sol('sol2').create('st1', 'StudyStep');
model.sol('sol2').feature('st1').set('study', 'std2');
model.sol('sol2').feature('st1').set('studystep', 'stat');
model.sol('sol2').create('v1', 'Variables');
model.sol('sol2').feature('v1').set('control', 'stat');
model.sol('sol2').create('s1', 'Stationary');
model.sol('sol2').feature('s1').set('stol', 0.001);
model.sol('sol2').feature('s1').feature('aDef').set('cachepattern', true);
model.sol('sol2').feature('s1').create('seDef', 'Segregated');
model.sol('sol2').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol2').feature('s1').feature('fc1').set('dtech', 'const');
model.sol('sol2').feature('s1').feature('fc1').set('damp', 0.6);
model.sol('sol2').feature('s1').feature('fc1').set('maxiter', 150);
model.sol('sol2').feature('s1').feature('fc1').set('stabacc', 'cflcmp');
model.sol('sol2').feature('s1').feature('fc1').set('initcfl', 5);
model.sol('sol2').feature('s1').feature('fc1').set('kppid', 0.65);
model.sol('sol2').feature('s1').feature('fc1').set('kdpid', 0.05);
model.sol('sol2').feature('s1').feature('fc1').set('kipid', 0.05);
model.sol('sol2').feature('s1').feature('fc1').set('cfltol', 0.1);
model.sol('sol2').feature('s1').feature('fc1').set('initstep', 0.01);
model.sol('sol2').feature('s1').feature('fc1').set('minstep', 1.0E-6);
model.sol('sol2').feature('s1').create('d1', 'Direct');
model.sol('sol2').feature('s1').feature('d1').set('linsolver', 'pardiso');
model.sol('sol2').feature('s1').feature('d1').set('pivotperturb', 1.0E-13);
model.sol('sol2').feature('s1').feature('d1').label('Direct, mass fractions (tcs) (Merged)');
model.sol('sol2').feature('s1').create('i1', 'Iterative');
model.sol('sol2').feature('s1').feature('i1').set('linsolver', 'gmres');
model.sol('sol2').feature('s1').feature('i1').set('prefuntype', 'left');
model.sol('sol2').feature('s1').feature('i1').set('itrestart', 50);
model.sol('sol2').feature('s1').feature('i1').set('rhob', 400);
model.sol('sol2').feature('s1').feature('i1').set('maxlinit', 1000);
model.sol('sol2').feature('s1').feature('i1').set('nlinnormuse', 'on');
model.sol('sol2').feature('s1').feature('i1').label('AMG, mass fractions (tcs)');
model.sol('sol2').feature('s1').feature('i1').create('mg1', 'Multigrid');
model.sol('sol2').feature('s1').feature('i1').feature('mg1').set('prefun', 'saamg');
model.sol('sol2').feature('s1').feature('i1').feature('mg1').set('mgcycle', 'v');
model.sol('sol2').feature('s1').feature('i1').feature('mg1').set('maxcoarsedof', 50000);
model.sol('sol2').feature('s1').feature('i1').feature('mg1').set('strconn', 0.01);
model.sol('sol2').feature('s1').feature('i1').feature('mg1').set('nullspace', 'constant');
model.sol('sol2').feature('s1').feature('i1').feature('mg1').set('usesmooth', false);
model.sol('sol2').feature('s1').feature('i1').feature('mg1').set('saamgcompwise', true);
model.sol('sol2').feature('s1').feature('i1').feature('mg1').set('loweramg', true);
model.sol('sol2').feature('s1').feature('i1').feature('mg1').set('compactaggregation', false);
model.sol('sol2').feature('s1').feature('i1').feature('mg1').feature('pr').create('sl1', 'SORLine');
model.sol('sol2').feature('s1').feature('i1').feature('mg1').feature('pr').feature('sl1').set('linesweeptype', 'ssor');
model.sol('sol2').feature('s1').feature('i1').feature('mg1').feature('pr').feature('sl1').set('iter', 1);
model.sol('sol2').feature('s1').feature('i1').feature('mg1').feature('pr').feature('sl1').set('linerelax', 0.7);
model.sol('sol2').feature('s1').feature('i1').feature('mg1').feature('pr').feature('sl1').set('linealgorithm', 'mesh');
model.sol('sol2').feature('s1').feature('i1').feature('mg1').feature('pr').feature('sl1').set('linemethod', 'coupled');
model.sol('sol2').feature('s1').feature('i1').feature('mg1').feature('pr').feature('sl1').set('seconditer', 1);
model.sol('sol2').feature('s1').feature('i1').feature('mg1').feature('pr').feature('sl1').set('relax', 0.5);
model.sol('sol2').feature('s1').feature('i1').feature('mg1').feature('po').create('sl1', 'SORLine');
model.sol('sol2').feature('s1').feature('i1').feature('mg1').feature('po').feature('sl1').set('linesweeptype', 'ssor');
model.sol('sol2').feature('s1').feature('i1').feature('mg1').feature('po').feature('sl1').set('iter', 1);
model.sol('sol2').feature('s1').feature('i1').feature('mg1').feature('po').feature('sl1').set('linerelax', 0.7);
model.sol('sol2').feature('s1').feature('i1').feature('mg1').feature('po').feature('sl1').set('linealgorithm', 'mesh');
model.sol('sol2').feature('s1').feature('i1').feature('mg1').feature('po').feature('sl1').set('linemethod', 'coupled');
model.sol('sol2').feature('s1').feature('i1').feature('mg1').feature('po').feature('sl1').set('seconditer', 1);
model.sol('sol2').feature('s1').feature('i1').feature('mg1').feature('po').feature('sl1').set('relax', 0.5);
model.sol('sol2').feature('s1').feature('i1').feature('mg1').feature('cs').create('d1', 'Direct');
model.sol('sol2').feature('s1').feature('i1').feature('mg1').feature('cs').feature('d1').set('linsolver', 'pardiso');
model.sol('sol2').feature('s1').feature('i1').feature('mg1').feature('cs').feature('d1').set('pivotperturb', 1.0E-13);
model.sol('sol2').feature('s1').feature('fc1').set('linsolver', 'd1');
model.sol('sol2').feature('s1').feature('fc1').set('dtech', 'const');
model.sol('sol2').feature('s1').feature('fc1').set('damp', 0.6);
model.sol('sol2').feature('s1').feature('fc1').set('maxiter', 150);
model.sol('sol2').feature('s1').feature('fc1').set('stabacc', 'cflcmp');
model.sol('sol2').feature('s1').feature('fc1').set('initcfl', 5);
model.sol('sol2').feature('s1').feature('fc1').set('kppid', 0.65);
model.sol('sol2').feature('s1').feature('fc1').set('kdpid', 0.05);
model.sol('sol2').feature('s1').feature('fc1').set('kipid', 0.05);
model.sol('sol2').feature('s1').feature('fc1').set('cfltol', 0.1);
model.sol('sol2').feature('s1').feature('fc1').set('initstep', 0.01);
model.sol('sol2').feature('s1').feature('fc1').set('minstep', 1.0E-6);
model.sol('sol2').feature('s1').feature.remove('fcDef');
model.sol('sol2').feature('s1').feature.remove('seDef');
model.sol('sol2').attach('std2');

model.batch.create('p1', 'Parametric');
model.batch('p1').study('std2');
model.batch('p1').create('so1', 'Solutionseq');
model.batch('p1').feature('so1').set('seq', 'sol2');
model.batch('p1').feature('so1').set('store', 'on');
model.batch('p1').feature('so1').set('clear', 'on');
model.batch('p1').feature('so1').set('psol', 'none');
model.batch('p1').set('pname', {'Hs'});
model.batch('p1').set('plistarr', {'1.2 1.3 1.4'});
model.batch('p1').set('sweeptype', 'sparse');
model.batch('p1').set('probesel', 'all');
model.batch('p1').set('probes', {});
model.batch('p1').set('plot', 'off');
model.batch('p1').set('err', 'on');
model.batch('p1').attach('std2');
model.batch('p1').set('control', 'param');

model.sol.create('sol3');
model.sol('sol3').study('std2');
model.sol('sol3').label('Parametric Solutions 1');

model.batch('p1').feature('so1').set('psol', 'sol3');
model.batch('p1').run('compute');

model.result.create('pg2', 'PlotGroup1D');
model.result('pg2').run;
model.result('pg2').set('data', 'dset3');
model.result('pg2').setIndex('looplevelinput', 'manual', 0);
model.result('pg2').setIndex('looplevel', [2], 0);
model.result('pg2').create('lngr1', 'LineGraph');
model.result('pg2').feature('lngr1').set('markerpos', 'datapoints');
model.result('pg2').feature('lngr1').set('linewidth', 'preference');
model.result('pg2').feature('lngr1').selection.all;
model.result('pg2').feature('lngr1').set('expr', 'ym1');
model.result('pg2').feature('lngr1').set('linewidth', 2);
model.result('pg2').feature('lngr1').set('legend', true);
model.result('pg2').feature('lngr1').set('legendmethod', 'manual');
model.result('pg2').feature('lngr1').setIndex('legends', 'Vapor phase', 0);
model.result('pg2').feature.duplicate('lngr2', 'lngr1');
model.result('pg2').run;
model.result('pg2').feature('lngr2').set('expr', 'xm1');
model.result('pg2').feature('lngr2').setIndex('legends', 'Liquid phase', 0);
model.result('pg2').run;
model.result('pg2').run;
model.result('pg2').label('Mole Fractions');
model.result('pg2').set('titletype', 'manual');
model.result('pg2').set('title', 'Ethanol mole fraction');
model.result('pg2').set('xlabelactive', true);
model.result('pg2').set('xlabel', 'Column Height (m)');
model.result('pg2').set('ylabelactive', true);
model.result('pg2').set('ylabel', 'x1, y1');
model.result('pg2').set('legendpos', 'middleright');
model.result('pg2').run;
model.result.create('pg3', 'PlotGroup1D');
model.result('pg3').run;
model.result('pg3').set('data', 'dset3');
model.result('pg3').setIndex('looplevelinput', 'manual', 0);
model.result('pg3').setIndex('looplevel', [2], 0);
model.result('pg3').create('lngr1', 'LineGraph');
model.result('pg3').feature('lngr1').set('markerpos', 'datapoints');
model.result('pg3').feature('lngr1').set('linewidth', 'preference');
model.result('pg3').feature('lngr1').selection.all;
model.result('pg3').feature('lngr1').set('expr', 'ym1');
model.result('pg3').feature('lngr1').set('xdata', 'expr');
model.result('pg3').feature('lngr1').set('xdataexpr', 'xm1');
model.result('pg3').feature('lngr1').set('linecolor', 'black');
model.result('pg3').feature('lngr1').set('linewidth', 2);
model.result('pg3').feature('lngr1').set('legend', true);
model.result('pg3').feature('lngr1').set('legendmethod', 'manual');
model.result('pg3').feature('lngr1').setIndex('legends', 'Column operation', 0);
model.result('pg3').run;
model.result('pg3').run;
model.result('pg3').create('glob1', 'Global');
model.result('pg3').feature('glob1').set('markerpos', 'datapoints');
model.result('pg3').feature('glob1').set('linewidth', 'preference');
model.result('pg3').feature('glob1').set('expr', {});
model.result('pg3').feature('glob1').set('descr', {});
model.result('pg3').feature('glob1').setIndex('expr', 'x_y(P,n,x1,x2)', 0);
model.result('pg3').feature('glob1').setIndex('unit', 1, 0);
model.result('pg3').feature('glob1').setIndex('descr', '', 0);
model.result('pg3').feature('glob1').set('data', 'dset1');
model.result('pg3').run;
model.result('pg3').feature('glob1').set('linewidth', 2);
model.result('pg3').feature('glob1').set('legend', false);
model.result('pg3').feature.move('glob1', 0);
model.result('pg3').run;
model.result('pg3').run;
model.result('pg3').label('Operating Lines');
model.result('pg3').set('xlabelactive', true);
model.result('pg3').set('xlabel', 'x1');
model.result('pg3').set('ylabelactive', true);
model.result('pg3').set('ylabel', 'y1');
model.result('pg3').set('titletype', 'none');
model.result('pg3').set('legendpos', 'middleright');
model.result('pg3').run;

model.geom('geom1').run;

model.study('std1').feature('stat').setEntry('activate', 'chem1', false);
model.study('std1').feature('stat').setEntry('activate', 'tcs', false);
model.study('std1').feature('stat').setEntry('activate', 'tcs2', false);

model.result('pg3').run;

model.title('Dimensioning a Distillation Column for Separation of Water and Ethanol');

model.description('This example shows how to make a simple model for a binary distillation process by combining functionality in the Thermodynamics node, available when licensed to the Chemical Reaction Engineering Module, and the Transport of Concentrated Species interface. In this model the separation of a nonideal mixture of ethanol and water is studied. The required equilibrium relationship is generated using the Equilibrium Calculation functionality available when using the Thermodynamics node. The model is used to find the optimal design of the column in terms of the length of the stripping and rectifying sections to meet a set of specified distillate and bottoms compositions.');

model.label('distillation_column.mph');

model.modelNode.label('Components');

out = model;
