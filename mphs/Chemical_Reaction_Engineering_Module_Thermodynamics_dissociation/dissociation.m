function out = model
%
% dissociation.m
%
% Model exported on May 26 2025, 21:27 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/Chemical_Reaction_Engineering_Module/Thermodynamics');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 2);
model.geom('geom1').model('comp1');
model.geom('geom1').axisymmetric(true);

model.mesh.create('mesh1', 'geom1');

model.physics.create('tcs', 'ConcentratedSpecies', 'geom1', {'wA' 'wB'});
model.physics.create('spf', 'LaminarFlow', 'geom1');
model.physics('spf').model('comp1');
model.physics.create('ht', 'HeatTransferInFluids', 'geom1');
model.physics('ht').model('comp1');

model.study.create('std1');
model.study('std1').create('stat', 'Stationary');
model.study('std1').feature('stat').setSolveFor('/physics/tcs', true);
model.study('std1').feature('stat').setSolveFor('/physics/spf', true);
model.study('std1').feature('stat').setSolveFor('/physics/ht', true);

% To import content from file, use:
% model.param.loadFile('FILENAME');
model.param.set('p_amb', '101325[Pa]', 'Reference pressure');
model.param.set('T_amb', '293[K]', 'Inlet temperature');
model.param.set('kf', '0.0254', '[1/s] Forward rate constant');
model.param.set('wN2O4_in', '0.99[1]', 'Mass fraction of N2O4 at inlet');
model.param.set('Tf', '500[K]', 'Temperature of heating fluid');
model.param.set('Ua', '50[W/m^2/K]', 'Heat transfer coefficient');
model.param.set('W0', '0.1[m]', 'Radius of reactor');
model.param.set('L0', '4[m]', 'Length of reactor');
model.param.set('v_in', '0.02[m/s]', 'Velocity at inlet');

model.thermodynamics.feature.create('spec1', 'UserDefinedSpecies');
model.thermodynamics.feature('spec1').set('Species', 'N2O4');
model.thermodynamics.feature('spec1').set('SpeciesState', 'GasLiquid');
model.thermodynamics.feature('spec1').set('CAS', '10544-72-6');
model.thermodynamics.feature('spec1').set('ChemicalFormula', 'N2O4');
model.thermodynamics.feature('spec1').set('StructureFormula', '');
model.thermodynamics.feature('spec1').set('IdealGas_HeatCapacityCp', {'151.4994' '22.8199439173' '0.248101835092' '-0.000129016784375' '-2.07976512868e-07' '223.9986';  ...
'223.9986' '17.3772455746' '0.320995572054' '-0.000454437286832' '2.7628321384e-07' '310.9977';  ...
'310.9977' '7.55672923384' '0.415727941528' '-0.000759045229188' '6.02767881686e-07' '325.4976';  ...
'325.4976' '23.1617866623' '0.271901466969' '-0.000317178762095' '1.50264322937e-07' '557.4951';  ...
'557.4951' '41.600968157' '0.172676299817' '-0.000139194835147' '4.38454940552e-08' '803.9924';  ...
'803.9924' '59.0032311688' '0.107741868801' '-5.84298540152e-05' '1.036052532e-08' '1499.985'});
model.thermodynamics.feature('spec1').set('Saturated_Liquid_Density', {'261.9' '23723.3913174' '-54.5872209623' '0.161934291432' '-0.000237308754858' '343.1466'});
model.thermodynamics.feature('spec1').set('Vapor_ThermalConductivity', {'380.0038' '29.7807267369' '-0.219234326434' '0.000540095868453' '-4.44593410339e-07' '400'});
model.thermodynamics.feature('spec1').set('VaporViscosity', {'300.003' '1.63115957629e-05' '-1.40930105836e-07' '6.48383663156e-10' '-6.82053838304e-13' '335.00235';  ...
'335.00235' '-9.55153890719e-06' '9.06784306719e-08' '-4.29802526723e-11' '5.86563034883e-15' '558.69014735';  ...
'558.69014735' '-1.14075878119e-05' '1.00644861511e-07' '-6.08191762446e-11' '1.65089321605e-14' '999.99'});
model.thermodynamics.feature('spec1').set('GasLiquidConstant', {'Absolute entropy' '304.32' 'J/mol/K';  ...
'Critical compressibility factor' '0.233' '1';  ...
'Critical pressure' '1.0031e+07' 'Pa';  ...
'Critical temperature' '431.15' 'K';  ...
'Critical volume' '8.249e-05' 'm^3/mol';  ...
'Dipole moment' '0' ['C' native2unicode(hex2dec({'00' 'b7'}), 'unicode') 'm'];  ...
'Heat of combustion (high heating value)' '0' 'J/mol';  ...
'Lennard-Jones diameter (potential characteristic length)' '0' 'm';  ...
'Lennard-Jones energy (potential energy minimum)' '0' 'K';  ...
'Liquid volume at normal boiling point' '0' 'm^3/mol';  ...
'Molecular mass' '92.011' 'g/mol';  ...
'Normal boiling point temperature' '294.3' 'K';  ...
'Standard enthalpy of formation' '9163' 'J/mol';  ...
'Standard molar enthalpy of formation (ion solution)' '0' 'J/mol';  ...
'Standard molar enthalpy of formation (Liquid)' '0' 'J/mol';  ...
'Standard molar enthalpy of formation (Solid)' '0' 'J/mol';  ...
'Standard molar enthalpy of formation (Vapor)' '0' 'J/mol';  ...
'Standard molar entropy (ion solution)' '0' 'J/mol/K';  ...
'Standard molar entropy (Liquid)' '0' 'J/mol/K';  ...
'Standard molar entropy (Solid)' '0' 'J/mol/K';  ...
'Standard molar entropy (Vapor)' '0' 'J/mol/K';  ...
'van der Waals area' '0' 'm^2/mol';  ...
'van der Waals volume' '0' 'm^3/mol'});
model.thermodynamics.feature('spec1').set('GasLiquidModelOptions', {'Acentric factor' '0.85327' '1';  ...
'Chao-Seader acentric factor' '0' '1';  ...
'Chao-Seader liquid volume' '0' 'm^3/mol';  ...
'Chao-Seader solubility parameter' '0' 'J^0.5/m^1.5';  ...
'COSTALD acentric factor' '0' '1';  ...
'COSTALD volume parameter' '0' 'm^3/mol';  ...
'Fuller diffusion volume' '13.1' '1';  ...
'Parachor' '8.8676e-06' 'kg^0.25*m^3/mol/s^0.5';  ...
'Peng-Robinson (Twu) parameter L' '0' '1';  ...
'Peng-Robinson (Twu) parameter M' '0' '1';  ...
'Peng-Robinson (Twu) parameter N' '0' '1';  ...
'Rackett parameter' '0' '1';  ...
'Solubility parameter' '0' 'J^0.5/m^1.5';  ...
'Stockmayer delta parameter' '0' '1';  ...
'UNIQUAC Q parameter' '0' '1';  ...
'UNIQUAC R parameter' '0' '1';  ...
'Wilke-Chang association parameter' '1' '1';  ...
'Wilson volume parameter' '0' 'm^3/mol'});
model.thermodynamics.feature.create('spec2', 'UserDefinedSpecies');
model.thermodynamics.feature('spec2').set('Species', 'NO2');
model.thermodynamics.feature('spec2').set('SpeciesState', 'GasLiquid');
model.thermodynamics.feature('spec2').set('CAS', '10102-44-0');
model.thermodynamics.feature('spec2').set('ChemicalFormula', 'NO2');
model.thermodynamics.feature('spec2').set('StructureFormula', '');
model.thermodynamics.feature('spec2').set('IdealGas_HeatCapacityCp', {'165.9993' '35.8254425805' '-0.0567293232053' '0.000356001767705' '-4.78004544541e-07' '223.9986';  ...
'223.9986' '32.4036320949' '-0.0109012177757' '0.00015141073262' '-1.73551696657e-07' '310.9977';  ...
'310.9977' '27.9650785955' '0.0319147274807' '1.37378647707e-05' '-2.59912614739e-08' '470.49';  ...
'470.49' '24.2998355133' '0.055285232749' '-3.5934194648e-05' '9.20001143717e-09' '963.4907'});
model.thermodynamics.feature('spec2').set('Saturated_Liquid_Density', {'261.9026' '47780.8048854' '-96.0025964011' '0.26232127372' '-0.000423346367284' '327.9932';  ...
'327.9932' '103808.217268' '-608.459065462' '1.82472094865' '-0.00201118383356' '373.7483';  ...
'373.7483' '350445.755442' '-2588.16737322' '7.121623457' '-0.00673531012243' '392.3892';  ...
'392.3892' '1568690.00637' '-11902.2176906' '30.8583886824' '-0.0268996140205' '407.6409';  ...
'407.6409' '2741379.02684' '-20532.5270178' '52.0297415255' '-0.0442117081071' '414.4194';  ...
'414.4194' '23901405.4952' '-173710.875824' '421.651310414' '-0.341512436861' '421.1979';  ...
'421.1979' '-24025981.4299' '167653.980875' '-388.81060475' '0.299881956897' '424.5872';  ...
'424.5872' '1171039730.24' '-8276305.55206' '19498.6460424' '-15.3132882369' '426.2818';  ...
'426.2818' '-3800925140.26' '26714385.1401' '-62584.8271252' '48.872322602' '427.9764';  ...
'427.9764' '17346687004.3' '-121524715.039' '283787.3097' '-220.90278402' '429.6711';  ...
'429.6711' '-22629305820.2' '157591051.588' '-365815.995308' '283.051135623' '431.3657'});
model.thermodynamics.feature('spec2').set('Vapor_ThermalConductivity', {'420.0042' '-15.8305048878' '0.111940151375' '-0.000264111354853' '2.08523312366e-07' '425.804058';  ...
'425.804058' '0.142692610769' '-0.000598918170081' '1.86430549483e-07' '1.62236779811e-09' '483.75782068';  ...
'483.75782068' '0.568403779574' '-0.00323894475326' '5.64376161541e-06' '-2.13800625176e-09' '530.260979312';  ...
'530.260979312' '4.28090087709' '-0.0242427367105' '4.52540531072e-05' '-2.70378782249e-08' '605.722503968';  ...
'605.722503968' '3.54280559853' '-0.0205871257316' '3.92189281862e-05' '-2.37167067416e-08' '651.762146706';  ...
'651.762146706' '-8.52192261186' '0.034945686068' '-4.59851789874e-05' '1.98595721224e-08' '744.87380587';  ...
'744.87380587' '-6.69104780557' '0.0275717867906' '-3.60856507461e-05' '1.54295025977e-08' '791.067898284'});
model.thermodynamics.feature('spec2').set('VaporViscosity', {'300.003' '0.000239189260846' '-2.40914442054e-06' '8.25332107135e-09' '-9.09949292819e-12' '307.0029';  ...
'307.0029' '-1.89810139051e-05' '1.13668309412e-07' '3.57676542572e-11' '-1.77152219467e-13' '335.0023';  ...
'335.0023' '-3.28500933225e-05' '2.37868167897e-07' '-3.34975646566e-10' '1.91744054602e-13' '488.9995';  ...
'488.9995' '-2.44211701796e-05' '1.86156930097e-07' '-2.29226585881e-10' '1.19658731621e-13' '579.9978';  ...
'579.9978' '-1.03829719748e-05' '1.13545284649e-07' '-1.04033618859e-10' '4.77084776588e-14' '684.9958';  ...
'684.9958' '1.95668473445e-06' '5.95026611349e-08' '-2.51387942283e-11' '9.31660010734e-15' '999.99'});
model.thermodynamics.feature('spec2').set('GasLiquidConstant', {'Absolute entropy' '239.92' 'J/mol/K';  ...
'Critical compressibility factor' '0.233' '1';  ...
'Critical pressure' '10132500' 'Pa';  ...
'Critical temperature' '431.15' 'K';  ...
'Critical volume' '8.249e-05' 'm^3/mol';  ...
'Dipole moment' '0' ['C' native2unicode(hex2dec({'00' 'b7'}), 'unicode') 'm'];  ...
'Heat of combustion (high heating value)' '0' 'J/mol';  ...
'Lennard-Jones diameter (potential characteristic length)' '0' 'm';  ...
'Lennard-Jones energy (potential energy minimum)' '0' 'K';  ...
'Liquid volume at normal boiling point' '0' 'm^3/mol';  ...
'Molecular mass' '46.0055' 'g/mol';  ...
'Normal boiling point temperature' '294.15' 'K';  ...
'Standard enthalpy of formation' '33180' 'J/mol';  ...
'Standard molar enthalpy of formation (ion solution)' '0' 'J/mol';  ...
'Standard molar enthalpy of formation (Liquid)' '0' 'J/mol';  ...
'Standard molar enthalpy of formation (Solid)' '0' 'J/mol';  ...
'Standard molar enthalpy of formation (Vapor)' '0' 'J/mol';  ...
'Standard molar entropy (ion solution)' '0' 'J/mol/K';  ...
'Standard molar entropy (Liquid)' '0' 'J/mol/K';  ...
'Standard molar entropy (Solid)' '0' 'J/mol/K';  ...
'Standard molar entropy (Vapor)' '0' 'J/mol/K';  ...
'van der Waals area' '222300' 'm^2/mol';  ...
'van der Waals volume' '1.391e-5' 'm^3/mol'});
model.thermodynamics.feature('spec2').set('GasLiquidModelOptions', {'Acentric factor' '0.851088' '1';  ...
'Chao-Seader acentric factor' '0' '1';  ...
'Chao-Seader liquid volume' '0' 'm^3/mol';  ...
'Chao-Seader solubility parameter' '0' 'J^0.5/m^1.5';  ...
'COSTALD acentric factor' '0' '1';  ...
'COSTALD volume parameter' '0' 'm^3/mol';  ...
'Fuller diffusion volume' '13.1' '1';  ...
'Parachor' '8.8676e-06' 'kg^0.25*m^3/mol/s^0.5';  ...
'Peng-Robinson (Twu) parameter L' '0' '1';  ...
'Peng-Robinson (Twu) parameter M' '0' '1';  ...
'Peng-Robinson (Twu) parameter N' '0' '1';  ...
'Rackett parameter' '0' '1';  ...
'Solubility parameter' '0' 'J^0.5/m^1.5';  ...
'Stockmayer delta parameter' '0' '1';  ...
'UNIQUAC Q parameter' '0' '1';  ...
'UNIQUAC R parameter' '0' '1';  ...
'Wilke-Chang association parameter' '1' '1';  ...
'Wilson volume parameter' '0' 'm^3/mol'});
model.thermodynamics.feature.create('pp1', 'BuiltinPropertyPackage');
model.thermodynamics.feature('pp1').set('compoundlist', {'N2O4' '10544-72-6' 'N2O4' 'UserDefined'; 'NO2' '10102-44-0' 'NO2' 'UserDefined'});
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
model.thermodynamics.feature('pp1').set('packagename', 'pp1');
model.thermodynamics.feature('pp1').label('Gas System 1');

model.geom('geom1').create('r1', 'Rectangle');
model.geom('geom1').feature('r1').set('size', {'W0' 'L0'});
model.geom('geom1').runPre('fin');

model.cpl.create('aveop1', 'Average', 'geom1');

model.geom('geom1').run;

model.cpl('aveop1').set('axisym', true);
model.cpl('aveop1').selection.geom('geom1', 1);
model.cpl('aveop1').selection.set([3]);

model.physics.create('chem', 'Chemistry', 'geom1');
model.physics('chem').model('comp1');

model.geom('geom1').run;

model.physics('chem').create('spec1', 'SpeciesChem', 2);
model.physics('chem').feature('spec1').set('specName', 'N2O4');
model.physics('chem').create('spec1', 'SpeciesChem', 2);
model.physics('chem').feature('spec1').set('specName', 'NO2');
model.physics('chem').prop('calcTransport').set('calcTransport', true);
model.physics('chem').prop('mixture').set('ConcentrationType', 'MassFraction');
model.physics('chem').prop('mixture').set('Thermodynamics', true);
model.physics('chem').prop('mixture').set('PropertyPackage', 'pp1');
model.physics('chem').prop('ChemistryModelInputParameter').setIndex('PackageSpecies', 'N2O4', 0);
model.physics('chem').prop('ChemistryModelInputParameter').setIndex('ConcentrationValue', '0.5', 0);
model.physics('chem').prop('ChemistryModelInputParameter').setIndex('PackageSpecies', 'NO2', 1);
model.physics('chem').prop('ChemistryModelInputParameter').setIndex('ConcentrationValue', '0.5', 1);
model.physics('chem').prop('mixture').set('mixture', 'gas');
model.physics('chem').create('rch1', 'ReactionChem', 2);
model.physics('chem').feature('rch1').set('formula', 'N2O4 <=> 2 NO2');
model.physics('chem').feature('rch1').set('setKeq0', true);
model.physics('chem').feature('rch1').set('kf', 'kf');
model.physics('chem').prop('ChemistryModelInputParameter').set('MassTransfer', 'tcs');
model.physics('chem').prop('ChemistryModelInputParameter').setIndex('ConcentrationInput', 'wA', 0, 0);
model.physics('chem').prop('ChemistryModelInputParameter').setIndex('ConcentrationInput', 'wB', 1, 0);
model.physics.move('chem', 0);

model.multiphysics.create('nirf1', 'NonIsothermalReactingFlow', 'geom1', 2);

model.physics('spf').prop('PhysicalModelProperty').set('Compressibility', 'CompressibleMALT03');
model.physics('spf').prop('PhysicalModelProperty').set('pref', 'p_amb');
model.physics('spf').create('inl1', 'InletBoundary', 1);
model.physics('spf').feature('inl1').selection.set([2]);
model.physics('spf').feature('inl1').set('BoundaryCondition', 'FullyDevelopedFlow');
model.physics('spf').feature('inl1').set('Uavfdf', 'v_in');
model.physics('spf').create('out1', 'OutletBoundary', 1);
model.physics('spf').feature('out1').selection.set([3]);
model.physics('spf').feature('out1').set('NormalFlow', true);
model.physics('tcs').prop('TransportMechanism').set('DiffusionModel', 'MaxwellStefan');
model.physics('tcs').prop('SpeciesProperties').set('FromMassConstraint', 2);
model.physics('tcs').feature('cdm1').setIndex('DiffusivityFrom', 'comp1.chem.D_N2O4_NO2', 0, 0);
model.physics('tcs').create('reac1', 'ReactionSources', 2);
model.physics('tcs').feature('reac1').selection.set([1]);
model.physics('tcs').feature('reac1').setIndex('R_wA_src', 'root.comp1.chem.Rw_N2O4', 0);
model.physics('tcs').create('in1', 'Inflow', 1);
model.physics('tcs').feature('in1').selection.set([2]);
model.physics('tcs').feature('in1').setIndex('wbnd', 'wN2O4_in', 0);
model.physics('tcs').create('out1', 'Outflow', 1);
model.physics('tcs').feature('out1').selection.set([3]);

model.mesh('mesh1').create('map1', 'Map');
model.mesh('mesh1').feature('map1').create('dis1', 'Distribution');
model.mesh('mesh1').feature('map1').feature('dis1').selection.set([1 4]);
model.mesh('mesh1').feature('map1').feature('dis1').set('type', 'predefined');
model.mesh('mesh1').feature('map1').feature('dis1').set('elemcount', 100);
model.mesh('mesh1').feature('map1').feature('dis1').set('elemratio', 50);
model.mesh('mesh1').feature('map1').create('dis2', 'Distribution');
model.mesh('mesh1').feature('map1').feature('dis2').selection.set([2 3]);
model.mesh('mesh1').feature('map1').feature('dis2').set('type', 'predefined');
model.mesh('mesh1').feature('map1').feature('dis2').set('elemcount', 10);
model.mesh('mesh1').feature('map1').feature('dis2').set('elemratio', 5);

model.multiphysics('nirf1').set('Heat_physics', 'none');
model.multiphysics('nirf1').set('temperature', 'Tf');

model.study('std1').label('Study - Isothermal Model');
model.study('std1').setGenPlots(false);
model.study('std1').feature('stat').setEntry('activate', 'ht', false);

model.sol.create('sol1');

model.mesh('mesh1').stat.selection.geom(2);
model.mesh('mesh1').stat.selection.set([1]);
model.mesh('mesh1').stat.selection.geom(2);
model.mesh('mesh1').stat.selection.set([1]);

model.sol('sol1').study('std1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'stat');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').set('control', 'stat');
model.sol('sol1').create('s1', 'Stationary');
model.sol('sol1').feature('s1').set('stol', 0.001);
model.sol('sol1').feature('s1').feature('aDef').set('cachepattern', true);
model.sol('sol1').feature('s1').create('seDef', 'Segregated');
model.sol('sol1').feature('s1').create('se1', 'Segregated');
model.sol('sol1').feature('s1').feature('se1').feature.remove('ssDef');
model.sol('sol1').feature('s1').feature('se1').create('ss1', 'SegregatedStep');
model.sol('sol1').feature('s1').feature('se1').feature('ss1').set('segvar', {'comp1_p' 'comp1_u' 'comp1_spf_inl1_Pinlfdf'});
model.sol('sol1').feature('s1').feature('se1').feature('ss1').set('subdamp', 0.5);
model.sol('sol1').feature('s1').create('d1', 'Direct');
model.sol('sol1').feature('s1').feature('d1').set('linsolver', 'pardiso');
model.sol('sol1').feature('s1').feature('d1').set('pivotperturb', 1.0E-13);
model.sol('sol1').feature('s1').feature('d1').label('Direct, fluid flow variables (spf)');
model.sol('sol1').feature('s1').feature('se1').feature('ss1').set('linsolver', 'd1');
model.sol('sol1').feature('s1').feature('se1').feature('ss1').label('Velocity u, Pressure p');
model.sol('sol1').feature('s1').feature('se1').create('ss2', 'SegregatedStep');
model.sol('sol1').feature('s1').feature('se1').feature('ss2').set('segvar', {'comp1_wA'});
model.sol('sol1').feature('s1').feature('se1').feature('ss2').set('subdamp', 0.35);
model.sol('sol1').feature('s1').feature('se1').feature('ss2').set('subntolfact', 1);
model.sol('sol1').feature('s1').feature('se1').feature('ss2').set('subiter', 3);
model.sol('sol1').feature('s1').feature('se1').feature('ss2').set('subtermconst', 'itertol');
model.sol('sol1').feature('s1').create('d2', 'Direct');
model.sol('sol1').feature('s1').feature('d2').set('linsolver', 'pardiso');
model.sol('sol1').feature('s1').feature('d2').set('pivotperturb', 1.0E-13);
model.sol('sol1').feature('s1').feature('d2').label('Direct, mass fractions (tcs)');
model.sol('sol1').feature('s1').feature('se1').feature('ss2').set('linsolver', 'd2');
model.sol('sol1').feature('s1').feature('se1').feature('ss2').label('Mass Fractions');
model.sol('sol1').feature('s1').feature('se1').set('segstabacc', 'segcflcmp');
model.sol('sol1').feature('s1').feature('se1').set('subinitcfl', 5);
model.sol('sol1').feature('s1').feature('se1').set('submincfl', 10000);
model.sol('sol1').feature('s1').feature('se1').set('subkppid', 0.65);
model.sol('sol1').feature('s1').feature('se1').set('subkdpid', 0.15);
model.sol('sol1').feature('s1').feature('se1').set('subkipid', 0.15);
model.sol('sol1').feature('s1').feature('se1').set('subcfltol', 0.1);
model.sol('sol1').feature('s1').feature('se1').set('segcflaa', true);
model.sol('sol1').feature('s1').feature('se1').set('segcflaacfl', 9000);
model.sol('sol1').feature('s1').feature('se1').set('segcflaafact', 1);
model.sol('sol1').feature('s1').feature('se1').set('maxsegiter', 200);
model.sol('sol1').feature('s1').create('i1', 'Iterative');
model.sol('sol1').feature('s1').feature('i1').set('linsolver', 'gmres');
model.sol('sol1').feature('s1').feature('i1').set('prefuntype', 'left');
model.sol('sol1').feature('s1').feature('i1').set('itrestart', 50);
model.sol('sol1').feature('s1').feature('i1').set('rhob', 20);
model.sol('sol1').feature('s1').feature('i1').set('maxlinit', 1000);
model.sol('sol1').feature('s1').feature('i1').set('nlinnormuse', 'on');
model.sol('sol1').feature('s1').feature('i1').label('AMG, fluid flow variables (spf)');
model.sol('sol1').feature('s1').feature('i1').create('mg1', 'Multigrid');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').set('prefun', 'saamg');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').set('mgcycle', 'v');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').set('maxcoarsedof', 80000);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').set('strconn', 0.02);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').set('nullspace', 'constant');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').set('usesmooth', false);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').set('saamgcompwise', true);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').set('loweramg', true);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').set('compactaggregation', false);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('pr').create('sc1', 'SCGS');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('pr').feature('sc1').set('linesweeptype', 'ssor');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('pr').feature('sc1').set('iter', 0);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('pr').feature('sc1').set('scgsrelax', 0.7);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('pr').feature('sc1').set('scgsmethod', 'lines');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('pr').feature('sc1').set('scgsvertexrelax', 0.7);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('pr').feature('sc1').set('relax', 0.5);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('pr').feature('sc1').set('vankavarsactive', 'on');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('pr').feature('sc1').set('vankavars', {'comp1_spf_inl1_Pinlfdf'});
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('pr').feature('sc1').set('scgssolv', 'stored');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('pr').feature('sc1').set('approxscgs', true);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('pr').feature('sc1').set('scgsdirectmaxsize', 1000);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('po').create('sc1', 'SCGS');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('po').feature('sc1').set('linesweeptype', 'ssor');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('po').feature('sc1').set('iter', 1);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('po').feature('sc1').set('scgsrelax', 0.7);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('po').feature('sc1').set('scgsmethod', 'lines');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('po').feature('sc1').set('scgsvertexrelax', 0.7);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('po').feature('sc1').set('relax', 0.5);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('po').feature('sc1').set('vankavarsactive', 'on');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('po').feature('sc1').set('vankavars', {'comp1_spf_inl1_Pinlfdf'});
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('po').feature('sc1').set('scgssolv', 'stored');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('po').feature('sc1').set('approxscgs', true);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('po').feature('sc1').set('scgsdirectmaxsize', 1000);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('cs').create('d1', 'Direct');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('cs').feature('d1').set('linsolver', 'pardiso');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('cs').feature('d1').set('pivotperturb', 1.0E-13);
model.sol('sol1').feature('s1').create('i2', 'Iterative');
model.sol('sol1').feature('s1').feature('i2').set('linsolver', 'gmres');
model.sol('sol1').feature('s1').feature('i2').set('prefuntype', 'left');
model.sol('sol1').feature('s1').feature('i2').set('itrestart', 50);
model.sol('sol1').feature('s1').feature('i2').set('rhob', 400);
model.sol('sol1').feature('s1').feature('i2').set('maxlinit', 1000);
model.sol('sol1').feature('s1').feature('i2').set('nlinnormuse', 'on');
model.sol('sol1').feature('s1').feature('i2').label('AMG, mass fractions (tcs)');
model.sol('sol1').feature('s1').feature('i2').create('mg1', 'Multigrid');
model.sol('sol1').feature('s1').feature('i2').feature('mg1').set('prefun', 'saamg');
model.sol('sol1').feature('s1').feature('i2').feature('mg1').set('mgcycle', 'v');
model.sol('sol1').feature('s1').feature('i2').feature('mg1').set('maxcoarsedof', 50000);
model.sol('sol1').feature('s1').feature('i2').feature('mg1').set('strconn', 0.01);
model.sol('sol1').feature('s1').feature('i2').feature('mg1').set('nullspace', 'constant');
model.sol('sol1').feature('s1').feature('i2').feature('mg1').set('usesmooth', false);
model.sol('sol1').feature('s1').feature('i2').feature('mg1').set('saamgcompwise', true);
model.sol('sol1').feature('s1').feature('i2').feature('mg1').set('loweramg', true);
model.sol('sol1').feature('s1').feature('i2').feature('mg1').set('compactaggregation', false);
model.sol('sol1').feature('s1').feature('i2').feature('mg1').feature('pr').create('sl1', 'SORLine');
model.sol('sol1').feature('s1').feature('i2').feature('mg1').feature('pr').feature('sl1').set('linesweeptype', 'ssor');
model.sol('sol1').feature('s1').feature('i2').feature('mg1').feature('pr').feature('sl1').set('iter', 1);
model.sol('sol1').feature('s1').feature('i2').feature('mg1').feature('pr').feature('sl1').set('linerelax', 0.7);
model.sol('sol1').feature('s1').feature('i2').feature('mg1').feature('pr').feature('sl1').set('linealgorithm', 'mesh');
model.sol('sol1').feature('s1').feature('i2').feature('mg1').feature('pr').feature('sl1').set('linemethod', 'coupled');
model.sol('sol1').feature('s1').feature('i2').feature('mg1').feature('pr').feature('sl1').set('seconditer', 1);
model.sol('sol1').feature('s1').feature('i2').feature('mg1').feature('pr').feature('sl1').set('relax', 0.5);
model.sol('sol1').feature('s1').feature('i2').feature('mg1').feature('po').create('sl1', 'SORLine');
model.sol('sol1').feature('s1').feature('i2').feature('mg1').feature('po').feature('sl1').set('linesweeptype', 'ssor');
model.sol('sol1').feature('s1').feature('i2').feature('mg1').feature('po').feature('sl1').set('iter', 1);
model.sol('sol1').feature('s1').feature('i2').feature('mg1').feature('po').feature('sl1').set('linerelax', 0.7);
model.sol('sol1').feature('s1').feature('i2').feature('mg1').feature('po').feature('sl1').set('linealgorithm', 'mesh');
model.sol('sol1').feature('s1').feature('i2').feature('mg1').feature('po').feature('sl1').set('linemethod', 'coupled');
model.sol('sol1').feature('s1').feature('i2').feature('mg1').feature('po').feature('sl1').set('seconditer', 1);
model.sol('sol1').feature('s1').feature('i2').feature('mg1').feature('po').feature('sl1').set('relax', 0.5);
model.sol('sol1').feature('s1').feature('i2').feature('mg1').feature('cs').create('d1', 'Direct');
model.sol('sol1').feature('s1').feature('i2').feature('mg1').feature('cs').feature('d1').set('linsolver', 'pardiso');
model.sol('sol1').feature('s1').feature('i2').feature('mg1').feature('cs').feature('d1').set('pivotperturb', 1.0E-13);
model.sol('sol1').feature('s1').feature.remove('fcDef');
model.sol('sol1').feature('s1').feature.remove('seDef');
model.sol('sol1').attach('std1');
model.sol('sol1').runAll;

model.result.numerical.create('gev1', 'EvalGlobal');
model.result.numerical('gev1').setIndex('expr', 'aveop1(w*spf.rho*wB)/aveop1(w*spf.rho)', 0);
model.result.table.create('tbl1', 'Table');
model.result.table('tbl1').comments('Global Evaluation 1');
model.result.numerical('gev1').set('table', 'tbl1');
model.result.numerical('gev1').setResult;
model.result.dataset.create('rev1', 'Revolve2D');
model.result.create('pg1', 'PlotGroup3D');
model.result('pg1').run;
model.result('pg1').label('Velocity, isothermal');
model.result('pg1').set('titletype', 'manual');
model.result('pg1').set('title', 'Velocity Magnitude');
model.result('pg1').set('showlegendsunit', true);
model.result('pg1').create('slc1', 'Slice');
model.result('pg1').feature('slc1').set('expr', 'spf.U');
model.result('pg1').feature('slc1').set('descr', 'Velocity magnitude');
model.result('pg1').feature('slc1').set('quickplane', 'xy');
model.result('pg1').feature('slc1').set('quickznumber', 10);
model.result('pg1').feature('slc1').set('colorlegend', false);
model.result('pg1').feature.duplicate('slc2', 'slc1');
model.result('pg1').run;
model.result('pg1').feature('slc2').set('quickplane', 'yz');
model.result('pg1').feature('slc2').set('quickxnumber', 1);
model.result('pg1').feature('slc2').set('colorlegend', true);
model.result('pg1').feature('slc2').set('titletype', 'none');
model.result('pg1').run;

model.view('view2').set('locked', true);
model.view('view2').camera.set('zoomanglefull', 35.964);
model.view('view2').camera.setIndex('position', -1.952, 0);
model.view('view2').camera.setIndex('position', 2.106, 1);
model.view('view2').camera.setIndex('position', -1.9356, 2);
model.view('view2').camera.set('target', [6.4827 -6.9964 2]);
model.view('view2').camera.setIndex('target', '15.0', 2);
model.view('view2').camera.setIndex('up', -0.915089, 0);
model.view('view2').camera.setIndex('up', '-0.1450', 1);
model.view('view2').camera.setIndex('up', 0.37624, 2);
model.view('view2').camera.setIndex('viewoffset', -0.1631674, 0);
model.view('view2').camera.set('viewoffset', [-0.1631674 0.081147]);

model.result('pg1').run;
model.result.duplicate('pg2', 'pg1');
model.result('pg2').run;
model.result('pg2').label('Mass fraction, B, isothermal');
model.result('pg2').set('title', 'Mass Fraction');
model.result('pg2').run;
model.result('pg2').feature('slc1').set('expr', 'wB');
model.result('pg2').feature('slc1').set('descr', 'Mass fraction');
model.result('pg2').run;
model.result('pg2').feature('slc2').set('expr', 'wB');
model.result('pg2').feature('slc2').set('descr', 'Mass fraction');
model.result('pg2').run;

model.study.create('std2');
model.study('std2').create('stat', 'Stationary');
model.study('std2').feature('stat').setSolveFor('/physics/chem', true);
model.study('std2').feature('stat').setSolveFor('/physics/tcs', true);
model.study('std2').feature('stat').setSolveFor('/physics/spf', true);
model.study('std2').feature('stat').setSolveFor('/physics/ht', true);
model.study('std2').feature('stat').setSolveFor('/multiphysics/nirf1', true);
model.study('std2').label('Study - Nonisothermal Model');

model.physics('ht').create('ofl1', 'ConvectiveOutflow', 1);
model.physics('ht').feature('ofl1').selection.set([3]);
model.physics('ht').create('temp1', 'TemperatureBoundary', 1);
model.physics('ht').feature('temp1').selection.set([2]);
model.physics('ht').feature('temp1').set('T0', 'T_amb');
model.physics('ht').create('hf1', 'HeatFluxBoundary', 1);
model.physics('ht').feature('hf1').selection.set([4]);
model.physics('ht').feature('hf1').set('q0_input', 'Ua*(Tf-T)');

model.multiphysics('nirf1').set('Heat_physics', 'ht');

model.study('std2').setGenPlots(false);

model.sol.create('sol2');

model.mesh('mesh1').stat.selection.geom(2);
model.mesh('mesh1').stat.selection.set([1]);
model.mesh('mesh1').stat.selection.geom(2);
model.mesh('mesh1').stat.selection.set([1]);

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
model.sol('sol2').feature('s1').create('se1', 'Segregated');
model.sol('sol2').feature('s1').feature('se1').feature.remove('ssDef');
model.sol('sol2').feature('s1').feature('se1').create('ss1', 'SegregatedStep');
model.sol('sol2').feature('s1').feature('se1').feature('ss1').set('segvar', {'comp1_p' 'comp1_u' 'comp1_spf_inl1_Pinlfdf'});
model.sol('sol2').feature('s1').feature('se1').feature('ss1').set('subdamp', 0.5);
model.sol('sol2').feature('s1').create('d1', 'Direct');
model.sol('sol2').feature('s1').feature('d1').set('linsolver', 'pardiso');
model.sol('sol2').feature('s1').feature('d1').set('pivotperturb', 1.0E-13);
model.sol('sol2').feature('s1').feature('d1').label('Direct, fluid flow variables (spf)');
model.sol('sol2').feature('s1').feature('se1').feature('ss1').set('linsolver', 'd1');
model.sol('sol2').feature('s1').feature('se1').feature('ss1').label('Velocity u, Pressure p');
model.sol('sol2').feature('s1').feature('se1').create('ss2', 'SegregatedStep');
model.sol('sol2').feature('s1').feature('se1').feature('ss2').set('segvar', {'comp1_wA'});
model.sol('sol2').feature('s1').feature('se1').feature('ss2').set('subdamp', 0.35);
model.sol('sol2').feature('s1').feature('se1').feature('ss2').set('subntolfact', 1);
model.sol('sol2').feature('s1').feature('se1').feature('ss2').set('subiter', 3);
model.sol('sol2').feature('s1').feature('se1').feature('ss2').set('subtermconst', 'itertol');
model.sol('sol2').feature('s1').create('d2', 'Direct');
model.sol('sol2').feature('s1').feature('d2').set('linsolver', 'pardiso');
model.sol('sol2').feature('s1').feature('d2').set('pivotperturb', 1.0E-13);
model.sol('sol2').feature('s1').feature('d2').label('Direct, mass fractions (tcs)');
model.sol('sol2').feature('s1').feature('se1').feature('ss2').set('linsolver', 'd2');
model.sol('sol2').feature('s1').feature('se1').feature('ss2').label('Mass Fractions');
model.sol('sol2').feature('s1').feature('se1').create('ss3', 'SegregatedStep');
model.sol('sol2').feature('s1').feature('se1').feature('ss3').set('segvar', {'comp1_T'});
model.sol('sol2').feature('s1').feature('se1').feature('ss3').set('subdamp', 0.5);
model.sol('sol2').feature('s1').create('d3', 'Direct');
model.sol('sol2').feature('s1').feature('d3').set('linsolver', 'pardiso');
model.sol('sol2').feature('s1').feature('d3').set('pivotperturb', 1.0E-13);
model.sol('sol2').feature('s1').feature('d3').label('Direct, heat transfer variables (ht)');
model.sol('sol2').feature('s1').feature('se1').feature('ss3').set('linsolver', 'd3');
model.sol('sol2').feature('s1').feature('se1').feature('ss3').label('Temperature');
model.sol('sol2').feature('s1').feature('se1').set('segstabacc', 'segcflcmp');
model.sol('sol2').feature('s1').feature('se1').set('subinitcfl', 5);
model.sol('sol2').feature('s1').feature('se1').set('submincfl', 10000);
model.sol('sol2').feature('s1').feature('se1').set('subkppid', 0.65);
model.sol('sol2').feature('s1').feature('se1').set('subkdpid', 0.15);
model.sol('sol2').feature('s1').feature('se1').set('subkipid', 0.15);
model.sol('sol2').feature('s1').feature('se1').set('subcfltol', 0.1);
model.sol('sol2').feature('s1').feature('se1').set('segcflaa', true);
model.sol('sol2').feature('s1').feature('se1').set('segcflaacfl', 9000);
model.sol('sol2').feature('s1').feature('se1').set('segcflaafact', 1);
model.sol('sol2').feature('s1').feature('se1').set('maxsegiter', 200);
model.sol('sol2').feature('s1').feature('se1').create('ll1', 'LowerLimit');
model.sol('sol2').feature('s1').feature('se1').feature('ll1').set('lowerlimit', 'comp1.T 0 ');
model.sol('sol2').feature('s1').create('i1', 'Iterative');
model.sol('sol2').feature('s1').feature('i1').set('linsolver', 'gmres');
model.sol('sol2').feature('s1').feature('i1').set('prefuntype', 'left');
model.sol('sol2').feature('s1').feature('i1').set('itrestart', 50);
model.sol('sol2').feature('s1').feature('i1').set('rhob', 20);
model.sol('sol2').feature('s1').feature('i1').set('maxlinit', 1000);
model.sol('sol2').feature('s1').feature('i1').set('nlinnormuse', 'on');
model.sol('sol2').feature('s1').feature('i1').label('AMG, fluid flow variables (spf)');
model.sol('sol2').feature('s1').feature('i1').create('mg1', 'Multigrid');
model.sol('sol2').feature('s1').feature('i1').feature('mg1').set('prefun', 'saamg');
model.sol('sol2').feature('s1').feature('i1').feature('mg1').set('mgcycle', 'v');
model.sol('sol2').feature('s1').feature('i1').feature('mg1').set('maxcoarsedof', 80000);
model.sol('sol2').feature('s1').feature('i1').feature('mg1').set('strconn', 0.02);
model.sol('sol2').feature('s1').feature('i1').feature('mg1').set('nullspace', 'constant');
model.sol('sol2').feature('s1').feature('i1').feature('mg1').set('usesmooth', false);
model.sol('sol2').feature('s1').feature('i1').feature('mg1').set('saamgcompwise', true);
model.sol('sol2').feature('s1').feature('i1').feature('mg1').set('loweramg', true);
model.sol('sol2').feature('s1').feature('i1').feature('mg1').set('compactaggregation', false);
model.sol('sol2').feature('s1').feature('i1').feature('mg1').feature('pr').create('sc1', 'SCGS');
model.sol('sol2').feature('s1').feature('i1').feature('mg1').feature('pr').feature('sc1').set('linesweeptype', 'ssor');
model.sol('sol2').feature('s1').feature('i1').feature('mg1').feature('pr').feature('sc1').set('iter', 0);
model.sol('sol2').feature('s1').feature('i1').feature('mg1').feature('pr').feature('sc1').set('scgsrelax', 0.7);
model.sol('sol2').feature('s1').feature('i1').feature('mg1').feature('pr').feature('sc1').set('scgsmethod', 'lines');
model.sol('sol2').feature('s1').feature('i1').feature('mg1').feature('pr').feature('sc1').set('scgsvertexrelax', 0.7);
model.sol('sol2').feature('s1').feature('i1').feature('mg1').feature('pr').feature('sc1').set('relax', 0.5);
model.sol('sol2').feature('s1').feature('i1').feature('mg1').feature('pr').feature('sc1').set('vankavarsactive', 'on');
model.sol('sol2').feature('s1').feature('i1').feature('mg1').feature('pr').feature('sc1').set('vankavars', {'comp1_spf_inl1_Pinlfdf'});
model.sol('sol2').feature('s1').feature('i1').feature('mg1').feature('pr').feature('sc1').set('scgssolv', 'stored');
model.sol('sol2').feature('s1').feature('i1').feature('mg1').feature('pr').feature('sc1').set('approxscgs', true);
model.sol('sol2').feature('s1').feature('i1').feature('mg1').feature('pr').feature('sc1').set('scgsdirectmaxsize', 1000);
model.sol('sol2').feature('s1').feature('i1').feature('mg1').feature('po').create('sc1', 'SCGS');
model.sol('sol2').feature('s1').feature('i1').feature('mg1').feature('po').feature('sc1').set('linesweeptype', 'ssor');
model.sol('sol2').feature('s1').feature('i1').feature('mg1').feature('po').feature('sc1').set('iter', 1);
model.sol('sol2').feature('s1').feature('i1').feature('mg1').feature('po').feature('sc1').set('scgsrelax', 0.7);
model.sol('sol2').feature('s1').feature('i1').feature('mg1').feature('po').feature('sc1').set('scgsmethod', 'lines');
model.sol('sol2').feature('s1').feature('i1').feature('mg1').feature('po').feature('sc1').set('scgsvertexrelax', 0.7);
model.sol('sol2').feature('s1').feature('i1').feature('mg1').feature('po').feature('sc1').set('relax', 0.5);
model.sol('sol2').feature('s1').feature('i1').feature('mg1').feature('po').feature('sc1').set('vankavarsactive', 'on');
model.sol('sol2').feature('s1').feature('i1').feature('mg1').feature('po').feature('sc1').set('vankavars', {'comp1_spf_inl1_Pinlfdf'});
model.sol('sol2').feature('s1').feature('i1').feature('mg1').feature('po').feature('sc1').set('scgssolv', 'stored');
model.sol('sol2').feature('s1').feature('i1').feature('mg1').feature('po').feature('sc1').set('approxscgs', true);
model.sol('sol2').feature('s1').feature('i1').feature('mg1').feature('po').feature('sc1').set('scgsdirectmaxsize', 1000);
model.sol('sol2').feature('s1').feature('i1').feature('mg1').feature('cs').create('d1', 'Direct');
model.sol('sol2').feature('s1').feature('i1').feature('mg1').feature('cs').feature('d1').set('linsolver', 'pardiso');
model.sol('sol2').feature('s1').feature('i1').feature('mg1').feature('cs').feature('d1').set('pivotperturb', 1.0E-13);
model.sol('sol2').feature('s1').create('i2', 'Iterative');
model.sol('sol2').feature('s1').feature('i2').set('linsolver', 'gmres');
model.sol('sol2').feature('s1').feature('i2').set('prefuntype', 'left');
model.sol('sol2').feature('s1').feature('i2').set('itrestart', 50);
model.sol('sol2').feature('s1').feature('i2').set('rhob', 400);
model.sol('sol2').feature('s1').feature('i2').set('maxlinit', 1000);
model.sol('sol2').feature('s1').feature('i2').set('nlinnormuse', 'on');
model.sol('sol2').feature('s1').feature('i2').label('AMG, mass fractions (tcs)');
model.sol('sol2').feature('s1').feature('i2').create('mg1', 'Multigrid');
model.sol('sol2').feature('s1').feature('i2').feature('mg1').set('prefun', 'saamg');
model.sol('sol2').feature('s1').feature('i2').feature('mg1').set('mgcycle', 'v');
model.sol('sol2').feature('s1').feature('i2').feature('mg1').set('maxcoarsedof', 50000);
model.sol('sol2').feature('s1').feature('i2').feature('mg1').set('strconn', 0.01);
model.sol('sol2').feature('s1').feature('i2').feature('mg1').set('nullspace', 'constant');
model.sol('sol2').feature('s1').feature('i2').feature('mg1').set('usesmooth', false);
model.sol('sol2').feature('s1').feature('i2').feature('mg1').set('saamgcompwise', true);
model.sol('sol2').feature('s1').feature('i2').feature('mg1').set('loweramg', true);
model.sol('sol2').feature('s1').feature('i2').feature('mg1').set('compactaggregation', false);
model.sol('sol2').feature('s1').feature('i2').feature('mg1').feature('pr').create('sl1', 'SORLine');
model.sol('sol2').feature('s1').feature('i2').feature('mg1').feature('pr').feature('sl1').set('linesweeptype', 'ssor');
model.sol('sol2').feature('s1').feature('i2').feature('mg1').feature('pr').feature('sl1').set('iter', 1);
model.sol('sol2').feature('s1').feature('i2').feature('mg1').feature('pr').feature('sl1').set('linerelax', 0.7);
model.sol('sol2').feature('s1').feature('i2').feature('mg1').feature('pr').feature('sl1').set('linealgorithm', 'mesh');
model.sol('sol2').feature('s1').feature('i2').feature('mg1').feature('pr').feature('sl1').set('linemethod', 'coupled');
model.sol('sol2').feature('s1').feature('i2').feature('mg1').feature('pr').feature('sl1').set('seconditer', 1);
model.sol('sol2').feature('s1').feature('i2').feature('mg1').feature('pr').feature('sl1').set('relax', 0.5);
model.sol('sol2').feature('s1').feature('i2').feature('mg1').feature('po').create('sl1', 'SORLine');
model.sol('sol2').feature('s1').feature('i2').feature('mg1').feature('po').feature('sl1').set('linesweeptype', 'ssor');
model.sol('sol2').feature('s1').feature('i2').feature('mg1').feature('po').feature('sl1').set('iter', 1);
model.sol('sol2').feature('s1').feature('i2').feature('mg1').feature('po').feature('sl1').set('linerelax', 0.7);
model.sol('sol2').feature('s1').feature('i2').feature('mg1').feature('po').feature('sl1').set('linealgorithm', 'mesh');
model.sol('sol2').feature('s1').feature('i2').feature('mg1').feature('po').feature('sl1').set('linemethod', 'coupled');
model.sol('sol2').feature('s1').feature('i2').feature('mg1').feature('po').feature('sl1').set('seconditer', 1);
model.sol('sol2').feature('s1').feature('i2').feature('mg1').feature('po').feature('sl1').set('relax', 0.5);
model.sol('sol2').feature('s1').feature('i2').feature('mg1').feature('cs').create('d1', 'Direct');
model.sol('sol2').feature('s1').feature('i2').feature('mg1').feature('cs').feature('d1').set('linsolver', 'pardiso');
model.sol('sol2').feature('s1').feature('i2').feature('mg1').feature('cs').feature('d1').set('pivotperturb', 1.0E-13);
model.sol('sol2').feature('s1').create('i3', 'Iterative');
model.sol('sol2').feature('s1').feature('i3').set('linsolver', 'gmres');
model.sol('sol2').feature('s1').feature('i3').set('prefuntype', 'left');
model.sol('sol2').feature('s1').feature('i3').set('itrestart', 50);
model.sol('sol2').feature('s1').feature('i3').set('rhob', 20);
model.sol('sol2').feature('s1').feature('i3').set('maxlinit', 10000);
model.sol('sol2').feature('s1').feature('i3').set('nlinnormuse', 'on');
model.sol('sol2').feature('s1').feature('i3').label('AMG, heat transfer variables (ht)');
model.sol('sol2').feature('s1').feature('i3').create('mg1', 'Multigrid');
model.sol('sol2').feature('s1').feature('i3').feature('mg1').set('prefun', 'saamg');
model.sol('sol2').feature('s1').feature('i3').feature('mg1').set('mgcycle', 'v');
model.sol('sol2').feature('s1').feature('i3').feature('mg1').set('maxcoarsedof', 50000);
model.sol('sol2').feature('s1').feature('i3').feature('mg1').set('strconn', 0.01);
model.sol('sol2').feature('s1').feature('i3').feature('mg1').set('nullspace', 'constant');
model.sol('sol2').feature('s1').feature('i3').feature('mg1').set('usesmooth', false);
model.sol('sol2').feature('s1').feature('i3').feature('mg1').set('saamgcompwise', true);
model.sol('sol2').feature('s1').feature('i3').feature('mg1').set('loweramg', true);
model.sol('sol2').feature('s1').feature('i3').feature('mg1').set('compactaggregation', false);
model.sol('sol2').feature('s1').feature('i3').feature('mg1').feature('pr').create('so1', 'SOR');
model.sol('sol2').feature('s1').feature('i3').feature('mg1').feature('pr').feature('so1').set('iter', 2);
model.sol('sol2').feature('s1').feature('i3').feature('mg1').feature('pr').feature('so1').set('relax', 0.9);
model.sol('sol2').feature('s1').feature('i3').feature('mg1').feature('po').create('so1', 'SOR');
model.sol('sol2').feature('s1').feature('i3').feature('mg1').feature('po').feature('so1').set('iter', 2);
model.sol('sol2').feature('s1').feature('i3').feature('mg1').feature('po').feature('so1').set('relax', 0.9);
model.sol('sol2').feature('s1').feature('i3').feature('mg1').feature('cs').create('d1', 'Direct');
model.sol('sol2').feature('s1').feature('i3').feature('mg1').feature('cs').feature('d1').set('linsolver', 'pardiso');
model.sol('sol2').feature('s1').feature('i3').feature('mg1').feature('cs').feature('d1').set('pivotperturb', 1.0E-13);
model.sol('sol2').feature('s1').feature.remove('fcDef');
model.sol('sol2').feature('s1').feature.remove('seDef');
model.sol('sol2').attach('std2');
model.sol('sol2').runAll;

model.result.numerical.duplicate('gev2', 'gev1');
model.result.numerical('gev2').set('data', 'dset2');
model.result.numerical('gev2').set('table', 'tbl1');
model.result.numerical('gev2').appendResult;
model.result.dataset.create('rev2', 'Revolve2D');
model.result.dataset('rev2').set('data', 'dset2');
model.result('pg1').run;
model.result.duplicate('pg3', 'pg1');
model.result('pg3').run;
model.result('pg3').label('Velocity, nonisothermal');
model.result('pg3').set('data', 'rev2');
model.result('pg3').set('view', 'view2');
model.result('pg3').run;
model.result('pg3').run;
model.result('pg2').run;
model.result.duplicate('pg4', 'pg2');
model.result('pg4').run;
model.result('pg4').label('Mass fraction B, nonisothermal');
model.result('pg4').set('data', 'rev2');
model.result('pg4').run;
model.result('pg4').set('view', 'view2');
model.result.duplicate('pg5', 'pg4');
model.result('pg5').run;
model.result('pg5').label('Temperature');
model.result('pg5').set('title', 'Temperature');
model.result('pg5').run;
model.result('pg5').run;
model.result('pg5').feature('slc1').set('expr', 'T');
model.result('pg5').feature('slc1').set('descr', 'Temperature');
model.result('pg5').run;
model.result('pg5').feature('slc2').set('expr', 'T');
model.result('pg5').feature('slc2').set('descr', 'Temperature');
model.result('pg5').run;

model.title('Dissociation in a Tubular Reactor');

model.description('A tubular reactor is modeled in which a reversible dissociation reaction of a species, A <-> 2B, takes place. The example accounts for the number of molecules in the gas phase increasing along the reaction path, leading to a volume expansion of the gas mixture and acceleration of the gas. Both isothermal and nonisothermal reactor conditions are investigated.');

model.label('dissociation.mph');

model.modelNode.label('Components');

out = model;
