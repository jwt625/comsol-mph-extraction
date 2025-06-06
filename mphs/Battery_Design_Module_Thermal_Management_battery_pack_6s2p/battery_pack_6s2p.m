function out = model
%
% battery_pack_6s2p.m
%
% Model exported on May 26 2025, 21:26 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/Battery_Design_Module/Thermal_Management');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 3);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.physics.create('bp', 'BatteryPack', 'geom1');
model.physics('bp').model('comp1');
model.physics.create('ht', 'HeatTransferInFluids', 'geom1');
model.physics('ht').model('comp1');

model.study.create('std1');
model.study('std1').create('time', 'Transient');
model.study('std1').feature('time').setSolveFor('/physics/bp', true);
model.study('std1').feature('time').setSolveFor('/physics/ht', true);

model.func.create('an1', 'Analytic');
model.func('an1').model('comp1');
model.func('an1').set('funcname', 'Arrh');
model.func('an1').set('expr', 'exp(Ea/R_const*(1/Temp-1/T0))');
model.func('an1').set('args', 'Ea, Temp');
model.func('an1').setIndex('argunit', 'J/mol', 0);
model.func('an1').setIndex('argunit', 'K', 1);
model.func('an1').set('fununit', '1');
model.func.create('int1', 'Interpolation');
model.func('int1').model('comp1');
model.func('int1').label('E_OCP');
model.func('int1').set('source', 'file');
model.func('int1').set('filename', 'battery_pack_6s2p_E_OCP_data.txt');
model.func('int1').setIndex('argunit', 1, 0);
model.func('int1').setIndex('fununit', 'V', 0);
model.func.create('int2', 'Interpolation');
model.func('int2').model('comp1');
model.func('int2').label('dEdT');
model.func('int2').set('source', 'file');
model.func('int2').set('filename', 'battery_pack_6s2p_dEdT_data.txt');
model.func('int2').setIndex('argunit', 1, 0);
model.func('int2').setIndex('fununit', 'V/K', 0);

model.geom('geom1').insertFile('battery_pack_6s2p_geom_sequence.mph', 'geom1');
model.geom('geom1').run('boxsel1');

model.view('view1').set('transparency', true);

model.param.label('Geometry Parameters');
model.param.create('par2');
model.param('par2').label('Battery Parameters');

% To import content from file, use:
% model.param('par2').loadFile('FILENAME');
model.param('par2').set('C_rate', '4', 'C rate');
model.param('par2').set('Q_cell', '4[A*h]', 'Battery cell capacity');
model.param('par2').set('I_1C', 'Q_cell/1[h]', '1C current');
model.param('par2').set('kT_batt_il', '30[W/m/K]', 'In-layer thermal conductivity');
model.param('par2').set('kT_batt_tl', '1[W/m/K]', 'Through-layer thermal conductivity');
model.param('par2').set('Ea_eta1C', '24[kJ/mol]', 'Activation energy');
model.param('par2').set('Ea_J0', '-59[kJ/mol]', 'Activation energy');
model.param('par2').set('Ea_Tau', '24[kJ/mol]', 'Activation energy');
model.param('par2').set('T0', '20[degC]', 'Reference temperature');
model.param('par2').set('J0_0', '0.85', 'J0 at reference temperature');
model.param('par2').set('tau_0', '1000[s]', 'tau at reference temperature');
model.param('par2').set('eta_1C', '4.5[mV]', 'eta_1C at reference temperature');
model.param('par2').set('rho_batt', '2000[kg/m^3]', 'Battery density');
model.param('par2').set('Cp_batt', '1400[J/(kg*K)]', 'Battery heat capacity');
model.param('par2').set('ht', '30[W/m^2/K]', 'Heat transfer coefficient');
model.param('par2').set('T_init', '20[degC]', 'Initial/external temperature');

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
model.material.create('mat2', 'Common', 'comp1');
model.material('mat2').propertyGroup.create('Enu', 'Young''s modulus and Poisson''s ratio');
model.material('mat2').propertyGroup.create('Murnaghan', 'Murnaghan');
model.material('mat2').label('Aluminum');
model.material('mat2').set('family', 'aluminum');
model.material('mat2').propertyGroup('def').set('relpermeability', {'1' '0' '0' '0' '1' '0' '0' '0' '1'});
model.material('mat2').propertyGroup('def').set('heatcapacity', '900[J/(kg*K)]');
model.material('mat2').propertyGroup('def').set('thermalconductivity', {'238[W/(m*K)]' '0' '0' '0' '238[W/(m*K)]' '0' '0' '0' '238[W/(m*K)]'});
model.material('mat2').propertyGroup('def').set('electricconductivity', {'3.774e7[S/m]' '0' '0' '0' '3.774e7[S/m]' '0' '0' '0' '3.774e7[S/m]'});
model.material('mat2').propertyGroup('def').set('relpermittivity', {'1' '0' '0' '0' '1' '0' '0' '0' '1'});
model.material('mat2').propertyGroup('def').set('thermalexpansioncoefficient', {'23e-6[1/K]' '0' '0' '0' '23e-6[1/K]' '0' '0' '0' '23e-6[1/K]'});
model.material('mat2').propertyGroup('def').set('density', '2700[kg/m^3]');
model.material('mat2').propertyGroup('Enu').set('E', '70[GPa]');
model.material('mat2').propertyGroup('Enu').set('nu', '0.33');
model.material('mat2').propertyGroup('Murnaghan').set('l', '-250[GPa]');
model.material('mat2').propertyGroup('Murnaghan').set('m', '-330[GPa]');
model.material('mat2').propertyGroup('Murnaghan').set('n', '-350[GPa]');
model.material('mat1').selection.named('geom1_sel4');
model.material('mat2').selection.named('geom1_comsel1');

model.physics('bp').selection.named('geom1_unisel2');
model.physics('bp').feature('batt').selection.named('geom1_unisel1');
model.physics('bp').feature('batt').set('Q_cell0', 'Q_cell');
model.physics('bp').feature('batt').set('SOC_pack0', 1);
model.physics('bp').feature('batt').feature('cep1').set('OpenCircuitVoltageInput', 'fromdef');
model.physics('bp').feature('batt').feature('cep1').set('Eocvdef', 'int1');
model.physics('bp').feature('batt').feature('cep1').set('dEocvdTdef', 'int2');
model.physics('bp').feature('batt').feature('vl1').set('eta_ir1C', 'eta_1C*Arrh(Ea_eta1C, bp.T_cell)');
model.physics('bp').feature('batt').feature('vl1').set('J0', 'J0_0*Arrh(Ea_J0,bp.T_cell)');
model.physics('bp').feature('batt').feature('vl1').set('IncludeConcentrationOverpotential', true);
model.physics('bp').feature('batt').feature('vl1').set('tau', 'tau_0*Arrh(Ea_Tau,bp.T_cell)');
model.physics('bp').feature('ccnd').selection.named('geom1_comsel1');
model.physics('bp').feature('ccnd').create('egnd1', 'ElectricGround', 2);
model.physics('bp').feature('ccnd').feature('egnd1').selection.set([1]);
model.physics('bp').feature('ccnd').create('ec1', 'ElectrodeCurrent', 2);
model.physics('bp').feature('ccnd').feature('ec1').selection.set([167]);
model.physics('bp').feature('ccnd').feature('ec1').set('Its', '-I_1C*C_rate');
model.physics('bp').feature('nc').selection.set([34 79 128]);
model.physics('bp').feature('pc').selection.set([31 82 125]);
model.physics('ht').feature('init1').set('Tinit', 'T_init');
model.physics('ht').create('hf1', 'HeatFluxBoundary', 2);
model.physics('ht').feature('hf1').selection.named('geom1_sel5');
model.physics('ht').feature('hf1').set('HeatFluxType', 'ConvectiveHeatFlux');
model.physics('ht').feature('hf1').set('h', 'ht');
model.physics('ht').feature('hf1').set('Text', 'T_init');
model.physics('ht').create('bl1', 'BatteryLayers', 3);
model.physics('ht').feature('bl1').selection.named('geom1_unisel1');
model.physics('ht').feature('bl1').set('LayerConfiguration', 'SpirallyWound');
model.physics('ht').feature('bl1').set('ThroughLayerConductivity', 'kT_batt_tl');
model.physics('ht').feature('bl1').set('InLayerConductivity', 'kT_batt_il');
model.physics('ht').feature('bl1').set('Density', 'rho_batt');
model.physics('ht').feature('bl1').set('HeatCapacity', 'Cp_batt');
model.physics('ht').create('solid1', 'SolidHeatTransferModel', 3);
model.physics('ht').feature('solid1').selection.named('geom1_comsel1');

model.multiphysics.create('ech1', 'ElectrochemicalHeating', 'geom1', 3);

model.mesh('mesh1').create('swe1', 'Sweep');
model.mesh('mesh1').feature('swe1').selection.geom('geom1', 3);
model.mesh('mesh1').feature('swe1').selection.named('geom1_boxsel1');
model.mesh('mesh1').feature('swe1').set('facemethod', 'tri');
model.mesh('mesh1').create('ftet1', 'FreeTet');
model.mesh('mesh1').run;

model.probe.create('var1', 'GlobalVariable');
model.probe('var1').model('comp1');
model.probe('var1').set('probename', 'Temp1');
model.probe('var1').label('Temperature Cell 1');
model.probe('var1').set('expr', 'bp.T_cell_1');
model.probe('var1').set('unit', 'degC');
model.probe('var1').set('descractive', true);
model.probe('var1').set('descr', 'Cell 1');

model.result.table.create('tbl1', 'Table');

model.probe('var1').set('table', 'tbl1');
model.probe('var1').set('window', 'window1');
model.probe('var1').set('windowtitle', 'Probe Plot 1');
model.probe.duplicate('var2', 'var1');
model.probe('var2').label('Temperature Cell 2');
model.probe('var2').set('probename', 'Temp2');
model.probe('var2').set('expr', 'bp.T_cell_2');
model.probe('var2').set('descr', 'Cell 2');
model.probe.duplicate('var3', 'var2');
model.probe('var3').label('Temperature Cell 3');
model.probe('var3').set('probename', 'Temp3');
model.probe('var3').set('expr', 'bp.T_cell_3');
model.probe('var3').set('descr', 'Cell 3');
model.probe.duplicate('var4', 'var3');
model.probe('var4').label('Cell Potential 1');
model.probe('var4').set('probename', 'Ecell1');
model.probe('var4').set('expr', 'bp.E_cell_1');
model.probe('var4').set('descr', 'Cell 1');

model.result.table.create('tbl2', 'Table');

model.probe('var4').set('table', 'tbl2');
model.probe('var4').set('window', 'window2');
model.probe('var4').set('windowtitle', 'Probe Plot 2');
model.probe.duplicate('var5', 'var4');
model.probe('var5').label('Cell Potential 2');
model.probe('var5').set('probename', 'Ecell2');
model.probe('var5').set('expr', 'bp.E_cell_2');
model.probe('var5').set('descr', 'Cell 2');
model.probe.duplicate('var6', 'var5');
model.probe('var6').label('Cell Potential 3');
model.probe('var6').set('probename', 'Ecell3');
model.probe('var6').set('expr', 'bp.E_cell_3');
model.probe('var6').set('descr', 'Cell 3');

model.study('std1').feature('time').set('tunit', 'h');
model.study('std1').feature('time').set('tlist', '0 0.8/C_rate');

model.sol.create('sol1');
model.sol('sol1').study('std1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'time');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').feature('comp1_bp_vl1_SOC_3').set('scalemethod', 'manual');
model.sol('sol1').feature('v1').feature('comp1_bp_vl1_SOC_2').set('scalemethod', 'manual');
model.sol('sol1').feature('v1').feature('comp1_bp_vl1_SOC_1').set('scalemethod', 'manual');
model.sol('sol1').feature('v1').feature('comp1_bp_vl1_SOC_3').set('scaleval', '1');
model.sol('sol1').feature('v1').feature('comp1_bp_vl1_SOC_2').set('scaleval', '1');
model.sol('sol1').feature('v1').feature('comp1_bp_vl1_SOC_1').set('scaleval', '1');
model.sol('sol1').feature('v1').set('control', 'time');
model.sol('sol1').create('t1', 'Time');
model.sol('sol1').feature('t1').set('tlist', '0 0.8/C_rate');
model.sol('sol1').feature('t1').set('plot', 'off');
model.sol('sol1').feature('t1').set('plotgroup', 'Default');
model.sol('sol1').feature('t1').set('plotfreq', 'tout');
model.sol('sol1').feature('t1').set('probesel', 'all');
model.sol('sol1').feature('t1').set('probes', {'var1' 'var2' 'var3' 'var4' 'var5' 'var6'});
model.sol('sol1').feature('t1').set('probefreq', 'tsteps');
model.sol('sol1').feature('t1').set('atolglobalvaluemethod', 'factor');
model.sol('sol1').feature('t1').set('atolmethod', {'comp1_bp_vl1_SOC_1' 'global' 'comp1_bp_vl1_SOC_2' 'global' 'comp1_bp_vl1_SOC_3' 'global' 'comp1_phis' 'global' 'comp1_T' 'global'  ...
'comp1_bp_I_app' 'global' 'comp1_bp_phis_neg' 'global' 'comp1_bp_phis_pos' 'global' 'comp1_bp_ccnd_ec1_phis0' 'global'});
model.sol('sol1').feature('t1').set('atol', {'comp1_bp_vl1_SOC_1' '1e-3' 'comp1_bp_vl1_SOC_2' '1e-3' 'comp1_bp_vl1_SOC_3' '1e-3' 'comp1_phis' '1e-3' 'comp1_T' '1e-3'  ...
'comp1_bp_I_app' '1e-3' 'comp1_bp_phis_neg' '1e-3' 'comp1_bp_phis_pos' '1e-3' 'comp1_bp_ccnd_ec1_phis0' '1e-3'});
model.sol('sol1').feature('t1').set('atolvaluemethod', {'comp1_bp_vl1_SOC_1' 'factor' 'comp1_bp_vl1_SOC_2' 'factor' 'comp1_bp_vl1_SOC_3' 'factor' 'comp1_phis' 'factor' 'comp1_T' 'factor'  ...
'comp1_bp_I_app' 'factor' 'comp1_bp_phis_neg' 'factor' 'comp1_bp_phis_pos' 'factor' 'comp1_bp_ccnd_ec1_phis0' 'factor'});
model.sol('sol1').feature('t1').set('eventout', true);
model.sol('sol1').feature('t1').set('reacf', true);
model.sol('sol1').feature('t1').set('storeudot', true);
model.sol('sol1').feature('t1').set('endtimeinterpolation', true);
model.sol('sol1').feature('t1').set('estrat', 'exclude');
model.sol('sol1').feature('t1').set('maxorder', 2);
model.sol('sol1').feature('t1').set('initialstepbdfactive', true);
model.sol('sol1').feature('t1').set('initialstepbdf', '(1)[s]');
model.sol('sol1').feature('t1').set('control', 'time');
model.sol('sol1').feature('t1').feature('aDef').set('cachepattern', true);
model.sol('sol1').feature('t1').create('se1', 'Segregated');
model.sol('sol1').feature('t1').feature('se1').feature.remove('ssDef');
model.sol('sol1').feature('t1').feature('se1').create('ss1', 'SegregatedStep');
model.sol('sol1').feature('t1').feature('se1').feature('ss1').set('segvar', {'comp1_bp_vl1_SOC_1' 'comp1_bp_vl1_SOC_2' 'comp1_bp_vl1_SOC_3' 'comp1_phis' 'comp1_bp_I_app' 'comp1_bp_phis_neg' 'comp1_bp_phis_pos' 'comp1_bp_ccnd_ec1_phis0'});
model.sol('sol1').feature('t1').feature('se1').feature('ss1').set('linsolver', 'dDef');
model.sol('sol1').feature('t1').feature('se1').feature('ss1').label('Battery Pack');
model.sol('sol1').feature('t1').feature('se1').create('ss2', 'SegregatedStep');
model.sol('sol1').feature('t1').feature('se1').feature('ss2').set('segvar', {'comp1_T'});
model.sol('sol1').feature('t1').feature('se1').feature('ss2').set('subdamp', 0.8);
model.sol('sol1').feature('t1').feature('se1').feature('ss2').set('subjtech', 'once');
model.sol('sol1').feature('t1').create('d1', 'Direct');
model.sol('sol1').feature('t1').feature('d1').set('linsolver', 'pardiso');
model.sol('sol1').feature('t1').feature('d1').set('pivotperturb', 1.0E-13);
model.sol('sol1').feature('t1').feature('d1').label('Direct, heat transfer variables (ht)');
model.sol('sol1').feature('t1').feature('se1').feature('ss2').set('linsolver', 'd1');
model.sol('sol1').feature('t1').feature('se1').feature('ss2').label('Temperature');
model.sol('sol1').feature('t1').feature('se1').set('segstabacc', 'segaacc');
model.sol('sol1').feature('t1').feature('se1').set('segaaccdim', 5);
model.sol('sol1').feature('t1').feature('se1').set('segaaccdelay', 0);
model.sol('sol1').feature('t1').feature('se1').set('segaaccmix', 0.9);
model.sol('sol1').feature('t1').feature('se1').create('ll1', 'LowerLimit');
model.sol('sol1').feature('t1').feature('se1').feature('ll1').set('lowerlimit', 'comp1.T 0 ');
model.sol('sol1').feature('t1').create('i1', 'Iterative');
model.sol('sol1').feature('t1').feature('i1').set('linsolver', 'gmres');
model.sol('sol1').feature('t1').feature('i1').set('prefuntype', 'left');
model.sol('sol1').feature('t1').feature('i1').set('itrestart', 50);
model.sol('sol1').feature('t1').feature('i1').set('rhob', 20);
model.sol('sol1').feature('t1').feature('i1').set('maxlinit', 10000);
model.sol('sol1').feature('t1').feature('i1').set('nlinnormuse', 'on');
model.sol('sol1').feature('t1').feature('i1').label('AMG, heat transfer variables (ht)');
model.sol('sol1').feature('t1').feature('i1').create('mg1', 'Multigrid');
model.sol('sol1').feature('t1').feature('i1').feature('mg1').set('prefun', 'saamg');
model.sol('sol1').feature('t1').feature('i1').feature('mg1').set('mgcycle', 'v');
model.sol('sol1').feature('t1').feature('i1').feature('mg1').set('maxcoarsedof', 50000);
model.sol('sol1').feature('t1').feature('i1').feature('mg1').set('strconn', 0.01);
model.sol('sol1').feature('t1').feature('i1').feature('mg1').set('nullspace', 'constant');
model.sol('sol1').feature('t1').feature('i1').feature('mg1').set('usesmooth', false);
model.sol('sol1').feature('t1').feature('i1').feature('mg1').set('saamgcompwise', true);
model.sol('sol1').feature('t1').feature('i1').feature('mg1').set('loweramg', true);
model.sol('sol1').feature('t1').feature('i1').feature('mg1').set('compactaggregation', false);
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('pr').create('so1', 'SOR');
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('pr').feature('so1').set('iter', 2);
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('pr').feature('so1').set('relax', 0.9);
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('po').create('so1', 'SOR');
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('po').feature('so1').set('iter', 2);
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('po').feature('so1').set('relax', 0.9);
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('cs').create('d1', 'Direct');
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('cs').feature('d1').set('linsolver', 'pardiso');
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('cs').feature('d1').set('pivotperturb', 1.0E-13);
model.sol('sol1').feature('t1').feature.remove('fcDef');
model.sol('sol1').attach('std1');

model.probe('var1').genResult('none');
model.probe('var2').genResult('none');
model.probe('var3').genResult('none');
model.probe('var4').genResult('none');
model.probe('var5').genResult('none');
model.probe('var6').genResult('none');

model.sol('sol1').runAll;

model.result.create('pg3', 'PlotGroup1D');
model.result('pg3').set('data', 'dset1');
model.result('pg3').create('glob1', 'Global');
model.result('pg3').feature('glob1').set('unit', {'' '' ''});
model.result('pg3').feature('glob1').set('expr', {'bp.E_cell_max' 'bp.E_cell_avg' 'bp.E_cell_min'});
model.result('pg3').feature('glob1').set('descr', {'Cell voltage' 'Cell voltage' 'Cell voltage'});
model.result('pg3').label('Cell Voltage (bp)');
model.result('pg3').feature('glob1').set('legendmethod', 'manual');
model.result('pg3').feature('glob1').setIndex('legends', 'E<sub>max</sub>', 0);
model.result('pg3').feature('glob1').setIndex('legends', 'E<sub>avg</sub>', 1);
model.result('pg3').feature('glob1').setIndex('legends', 'E<sub>min</sub>', 2);
model.result('pg3').create('glob2', 'Global');
model.result('pg3').feature('glob2').set('unit', {'' '' ''});
model.result('pg3').feature('glob2').set('expr', {'bp.I_app_max' 'bp.I_app_avg' 'bp.I_app_min'});
model.result('pg3').feature('glob2').set('descr', {'Applied cell current' 'Applied cell current' 'Applied cell current'});
model.result('pg3').feature('glob2').set('linestyle', 'dashed');
model.result('pg3').feature('glob2').set('linecolor', 'cyclereset');
model.result('pg3').feature('glob2').set('legendmethod', 'manual');
model.result('pg3').feature('glob2').setIndex('legends', 'I<sub>max</sub>', 0);
model.result('pg3').feature('glob2').setIndex('legends', 'I<sub>avg</sub>', 1);
model.result('pg3').feature('glob2').setIndex('legends', 'I<sub>min</sub>', 2);
model.result('pg3').set('twoyaxes', true);
model.result('pg3').setIndex('plotonsecyaxis', true, 1, 1);
model.result('pg3').set('titletype', 'none');
model.result.create('pg4', 'PlotGroup1D');
model.result('pg4').set('data', 'dset1');
model.result('pg4').create('glob1', 'Global');
model.result('pg4').feature('glob1').set('unit', {'' '' ''});
model.result('pg4').feature('glob1').set('expr', {'bp.SOC_max' 'bp.SOC_avg' 'bp.SOC_min'});
model.result('pg4').feature('glob1').set('descr', {'State of charge' 'State of charge' 'State of charge'});
model.result('pg4').label('State of Charge (bp)');
model.result('pg4').feature('glob1').set('legendmethod', 'manual');
model.result('pg4').feature('glob1').setIndex('legends', 'SOC<sub>max</sub>', 0);
model.result('pg4').feature('glob1').setIndex('legends', 'SOC<sub>avg</sub>', 1);
model.result('pg4').feature('glob1').setIndex('legends', 'SOC<sub>min</sub>', 2);
model.result('pg4').create('glob2', 'Global');
model.result('pg4').feature('glob2').set('unit', {'' '' ''});
model.result('pg4').feature('glob2').set('expr', {'bp.I_app_max' 'bp.I_app_avg' 'bp.I_app_min'});
model.result('pg4').feature('glob2').set('descr', {'Applied cell current' 'Applied cell current' 'Applied cell current'});
model.result('pg4').feature('glob2').set('linestyle', 'dashed');
model.result('pg4').feature('glob2').set('linecolor', 'cyclereset');
model.result('pg4').feature('glob2').set('legendmethod', 'manual');
model.result('pg4').feature('glob2').setIndex('legends', 'I<sub>max</sub>', 0);
model.result('pg4').feature('glob2').setIndex('legends', 'I<sub>avg</sub>', 1);
model.result('pg4').feature('glob2').setIndex('legends', 'I<sub>min</sub>', 2);
model.result('pg4').set('twoyaxes', true);
model.result('pg4').setIndex('plotonsecyaxis', true, 1, 1);
model.result('pg4').set('titletype', 'none');
model.result.create('pg5', 'PlotGroup3D');
model.result('pg5').set('data', 'dset1');
model.result('pg5').setIndex('looplevel', 2, 0);
model.result('pg5').label('Electric Potential (bp)');
model.result('pg5').create('surf1', 'Surface');
model.result('pg5').feature('surf1').set('expr', {'phis'});
model.result.create('pg6', 'PlotGroup3D');
model.result('pg6').label('Temperature (ht)');
model.result('pg6').set('data', 'dset1');
model.result('pg6').setIndex('looplevel', 2, 0);
model.result('pg6').set('defaultPlotID', 'ht/HT_PhysicsInterfaces/icom8/pdef1/pcond3/pcond3/pg1');
model.result('pg6').feature.create('vol1', 'Volume');
model.result('pg6').feature('vol1').set('showsolutionparams', 'on');
model.result('pg6').feature('vol1').set('solutionparams', 'parent');
model.result('pg6').feature('vol1').set('expr', 'T');
model.result('pg6').feature('vol1').set('colortable', 'HeatCameraLight');
model.result('pg6').feature('vol1').set('smooth', 'internal');
model.result('pg6').feature('vol1').set('showsolutionparams', 'on');
model.result('pg6').feature('vol1').set('data', 'parent');
model.result('pg3').run;
model.result.dataset.create('dset3', 'Solution');
model.result.dataset('dset3').selection.geom('geom1', 3);
model.result.dataset('dset3').selection.named('geom1_unisel2');
model.result.dataset.create('mir1', 'Mirror3D');
model.result.dataset('mir1').set('data', 'dset3');
model.result.dataset('mir1').set('quickx', '2.5*(d_batt)');
model.result.dataset.duplicate('mir2', 'mir1');
model.result.dataset('mir2').set('data', 'mir1');
model.result.dataset('mir2').set('quickplane', 'zx');
model.result.dataset('mir2').set('quicky', 'd_batt/2');
model.result('pg1').set('window', 'window1');
model.result('pg1').run;
model.result('pg1').label('Cell Temperatures vs. Time');
model.result('pg1').set('xlabelactive', true);
model.result('pg1').set('ylabelactive', true);
model.result('pg1').set('ylabel', 'Cell Temperature (degC)');
model.result('pg1').set('legendpos', 'lowerright');
model.result('pg1').set('window', 'window1');
model.result('pg1').run;
model.result('pg2').set('window', 'window2');
model.result('pg2').set('windowtitle', 'Probe Plot 2');
model.result('pg2').run;
model.result('pg2').label('Cell Potential vs. Time');
model.result('pg2').set('xlabelactive', true);
model.result('pg2').set('ylabelactive', true);
model.result('pg2').set('ylabel', 'Cell Potential (V)');
model.result('pg2').set('window', 'window2');
model.result('pg2').set('windowtitle', 'Probe Plot 2');
model.result('pg2').run;
model.result.create('pg7', 'PlotGroup3D');
model.result('pg7').run;
model.result('pg7').set('data', 'mir2');
model.result('pg7').label('Temperature');
model.result('pg7').create('surf1', 'Surface');
model.result('pg7').feature('surf1').set('expr', 'T');
model.result('pg7').feature('surf1').set('descr', 'Temperature');
model.result('pg7').feature('surf1').set('unit', 'degC');
model.result('pg7').feature('surf1').set('colortable', 'HeatCameraLight');
model.result('pg7').run;
model.result('pg1').set('window', 'window1');
model.result('pg1').run;
model.result.remove('pg1');
model.result.remove('pg2');
model.result.remove('pg4');
model.result.remove('pg5');
model.result('pg3').run;
model.result.move('pg3', 1);
model.result.move('pg3', 2);

model.title('Thermal Distribution in a Pack of Cylindrical Batteries');

model.description(['This example demonstrates how to model the temperature distribution in a battery pack during a 4C discharge.' newline  newline 'The pack is constructed by first coupling two cylindrical batteries in parallel. Six parallel-connected pairs are then connected in series to create the full pack. (This is also called a 6s2p configuration.)' newline  newline 'The symmetry of the problem is used twice so that only the temperature distribution for three batteries needs to be solved for.' newline  newline 'The Battery Pack interface is used to generate the appropriate heat sources, which are then coupled to one Heat Transfer interface in a 3D geometry.']);

model.mesh.clearMeshes;

model.sol('sol1').clearSolutionData;

model.label('battery_pack_6s2p.mph');

model.modelNode.label('Components');

out = model;
