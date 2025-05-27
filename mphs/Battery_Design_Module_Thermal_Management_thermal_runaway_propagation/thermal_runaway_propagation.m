function out = model
%
% thermal_runaway_propagation.m
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
model.physics.create('ht', 'HeatTransfer', 'geom1');
model.physics('ht').model('comp1');

model.study.create('std1');
model.study('std1').create('time', 'Transient');
model.study('std1').feature('time').setSolveFor('/physics/bp', true);
model.study('std1').feature('time').setSolveFor('/physics/ht', true);

model.geom('geom1').insertFile('thermal_runaway_propagation_geom_sequence.mph', 'geom1');
model.geom('geom1').run('adjsel1');

model.view('view1').set('transparency', true);
model.view('view1').set('showgrid', false);
model.view('view1').set('showaxisorientation', false);
model.view('view1').set('showgrid', true);
model.view('view1').set('showaxisorientation', true);

model.param.label('Geometry Parameters');
model.param.create('par2');
model.param('par2').label('Physics Parameters');

% To import content from file, use:
% model.param('par2').loadFile('FILENAME');
model.param('par2').set('Q_cell', '2.5[A*h]', 'Cell capacity');
model.param('par2').set('n_batt', 'nx_batt*ny_batt', 'Number of battery cells in pack');
model.param('par2').set('I_1C_pack', 'Q_cell*ny_batt/1[h]', 'Total 1C pack current (when applied at terminals)');
model.param('par2').set('SOC_0', '0.25', 'Initial state of charge');
model.param('par2').set('C_rate', '2', 'C rate');
model.param('par2').set('T_ext', '30[degC]', 'External temperature');
model.param('par2').set('h_conv', '10[W/m^2/K]', 'Convective cooling heat transfer coefficient');
model.param('par2').set('kT_batt_il', '30[W/m/K]', 'Battery in-layer thermal conductivity');
model.param('par2').set('kT_batt_tl', '1[W/m/K]', 'Battery through-layer thermal conductivity');
model.param('par2').set('rho_batt', '2000[kg/m^3]', 'Battery average density');
model.param('par2').set('Cp_batt', '1400[J/(kg*K)]', 'Battery average heat capacity');
model.param('par2').set('J0', '0.85', 'Dimensionless charge exchange current density');
model.param('par2').set('tau', '1000[s]', 'Diffusion time constant');
model.param('par2').set('eta_1C', '4.5[mV]', 'Ohmic overpotential at 1C');
model.param('par2').set('T_trigger', '80[degC]', 'Trigger temperature for thermal event');
model.param('par2').set('t_start', '1[min]', 'Start time for first cell thermal runaway');
model.param('par2').set('t_peak', '1[s]', 'Peak time during cell thermal runaway');
model.param('par2').set('t_tr', '6[s]', 'Cell thermal runaway time');
model.param('par2').set('W_tr', '32[kJ]', 'Total heat release during cell thermal runaway');
model.param('par2').set('Qh_peak', '2*W_tr/t_tr', 'Peak heat source during cell thermal runaway');
model.param('par2').set('E_max_cell', '4.2[V]', 'Maximum cell voltage during charge');
model.param('par2').set('E_max_pack', 'nx_batt*E_max_cell', 'Maximum pack voltage during charge');

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
model.material('mat2').label('Acrylic plastic');
model.material('mat2').set('family', 'custom');
model.material('mat2').set('customspecular', [0.9803921568627451 0.9803921568627451 0.9803921568627451]);
model.material('mat2').set('customdiffuse', [0.39215686274509803 0.7843137254901961 0.39215686274509803]);
model.material('mat2').set('customambient', [0.39215686274509803 0.7843137254901961 0.39215686274509803]);
model.material('mat2').set('noise', true);
model.material('mat2').set('lighting', 'phong');
model.material('mat2').set('shininess', 1000);
model.material('mat2').propertyGroup('def').set('thermalexpansioncoefficient', {'7.0e-5[1/K]' '0' '0' '0' '7.0e-5[1/K]' '0' '0' '0' '7.0e-5[1/K]'});
model.material('mat2').propertyGroup('def').set('heatcapacity', '1470[J/(kg*K)]');
model.material('mat2').propertyGroup('def').set('density', '1190[kg/m^3]');
model.material('mat2').propertyGroup('def').set('thermalconductivity', {'0.18[W/(m*K)]' '0' '0' '0' '0.18[W/(m*K)]' '0' '0' '0' '0.18[W/(m*K)]'});
model.material('mat2').propertyGroup('Enu').set('E', '3.2[GPa]');
model.material('mat2').propertyGroup('Enu').set('nu', '0.35');
model.material.create('mat3', 'Common', 'comp1');
model.material('mat3').propertyGroup.create('Enu', 'Young''s modulus and Poisson''s ratio');
model.material('mat3').label('Steel AISI 4340');
model.material('mat3').set('family', 'steel');
model.material('mat3').propertyGroup('def').set('relpermeability', {'1' '0' '0' '0' '1' '0' '0' '0' '1'});
model.material('mat3').propertyGroup('def').set('electricconductivity', {'4.032e6[S/m]' '0' '0' '0' '4.032e6[S/m]' '0' '0' '0' '4.032e6[S/m]'});
model.material('mat3').propertyGroup('def').set('thermalexpansioncoefficient', {'12.3e-6[1/K]' '0' '0' '0' '12.3e-6[1/K]' '0' '0' '0' '12.3e-6[1/K]'});
model.material('mat3').propertyGroup('def').set('heatcapacity', '475[J/(kg*K)]');
model.material('mat3').propertyGroup('def').set('relpermittivity', {'1' '0' '0' '0' '1' '0' '0' '0' '1'});
model.material('mat3').propertyGroup('def').set('density', '7850[kg/m^3]');
model.material('mat3').propertyGroup('def').set('thermalconductivity', {'44.5[W/(m*K)]' '0' '0' '0' '44.5[W/(m*K)]' '0' '0' '0' '44.5[W/(m*K)]'});
model.material('mat3').propertyGroup('Enu').set('E', '205[GPa]');
model.material('mat3').propertyGroup('Enu').set('nu', '0.28');
model.material('mat1').selection.named('geom1_comsel1');
model.material('mat2').selection.named('geom1_pi3_csel1_dom');
model.material('mat3').selection.named('geom1_pi2_boxsel1');

model.physics('bp').selection.named('geom1_unisel1');
model.physics('bp').feature('batt').selection.named('geom1_csel1_dom');
model.physics('bp').feature('batt').set('Q_cell0', 'Q_cell');
model.physics('bp').feature('batt').set('SOC_pack0', 'SOC_0');
model.physics('bp').feature('batt').feature('cep1').set('SOC_Eocv', []);
model.physics('bp').feature('batt').feature('cep1').set('Eocv', []);
model.physics('bp').feature('batt').feature('cep1').set('SOC_Eocv', {'0.000' '0.010' '0.020' '0.030' '0.040' '0.050' '0.060' '0.070' '0.080' '0.090'  ...
'0.100' '0.110' '0.120' '0.130' '0.140' '0.150' '0.160' '0.170' '0.180' '0.190'  ...
'0.200' '0.210' '0.220' '0.230' '0.240' '0.250' '0.260' '0.270' '0.280' '0.290'  ...
'0.300' '0.310' '0.320' '0.330' '0.340' '0.350' '0.360' '0.370' '0.380' '0.390'  ...
'0.400' '0.410' '0.420' '0.430' '0.440' '0.450' '0.460' '0.470' '0.480' '0.490'  ...
'0.500' '0.510' '0.520' '0.530' '0.540' '0.550' '0.560' '0.570' '0.580' '0.590'  ...
'0.600' '0.610' '0.620' '0.630' '0.640' '0.650' '0.660' '0.670' '0.680' '0.690'  ...
'0.700' '0.710' '0.720' '0.730' '0.740' '0.750' '0.760' '0.770' '0.780' '0.790'  ...
'0.800' '0.810' '0.820' '0.830' '0.840' '0.850' '0.860' '0.870' '0.880' '0.890'  ...
'0.900' '0.910' '0.920' '0.930' '0.940' '0.950' '0.960' '0.970' '0.980' '0.990'  ...
'1.000'});
model.physics('bp').feature('batt').feature('cep1').set('Eocv', {'1.310' '2.261' '2.833' '3.184' '3.393' '3.511' '3.587' '3.626' '3.656' '3.685'  ...
'3.699' '3.711' '3.723' '3.735' '3.747' '3.759' '3.767' '3.775' '3.783' '3.791'  ...
'3.800' '3.808' '3.816' '3.824' '3.832' '3.840' '3.845' '3.850' '3.854' '3.859'  ...
'3.864' '3.868' '3.873' '3.878' '3.882' '3.887' '3.891' '3.896' '3.900' '3.905'  ...
'3.910' '3.916' '3.921' '3.928' '3.934' '3.941' '3.947' '3.953' '3.959' '3.965'  ...
'3.970' '3.975' '3.979' '3.983' '3.986' '3.989' '3.992' '3.995' '3.997' '4.000'  ...
'4.002' '4.004' '4.007' '4.009' '4.011' '4.014' '4.017' '4.020' '4.023' '4.026'  ...
'4.029' '4.032' '4.035' '4.035' '4.036' '4.037' '4.037' '4.038' '4.039' '4.039'  ...
'4.040' '4.041' '4.041' '4.042' '4.042' '4.043' '4.043' '4.045' '4.049' '4.052'  ...
'4.055' '4.058' '4.061' '4.064' '4.069' '4.079' '4.092' '4.111' '4.134' '4.167'  ...
'4.204'});
model.physics('bp').feature('batt').feature('vl1').set('eta_ir1C', 'eta_1C');
model.physics('bp').feature('batt').feature('vl1').set('J0', 'J0');
model.physics('bp').feature('batt').feature('vl1').set('IncludeConcentrationOverpotential', true);
model.physics('bp').feature('batt').feature('vl1').set('tau', 'tau');
model.physics('bp').feature('batt').create('te1', 'ThermalEvent', 3);
model.physics('bp').feature('batt').feature('te1').selection.set([24 25 26]);
model.physics('bp').feature('batt').feature('te1').set('EventConditionType', 'ExplicitTime');
model.physics('bp').feature('batt').feature('te1').set('t_exp', 't_start');
model.physics('bp').feature('batt').feature('te1').setIndex('t_te_tab', 't_peak', 1, 0);
model.physics('bp').feature('batt').feature('te1').setIndex('Qh_te_tab', 'Qh_peak', 1, 0);
model.physics('bp').feature('batt').feature('te1').setIndex('t_te_tab', 0, 2, 0);
model.physics('bp').feature('batt').feature('te1').setIndex('Qh_te_tab', 0, 2, 0);
model.physics('bp').feature('batt').feature('te1').setIndex('Qh_te_tab', 0, 2, 0);
model.physics('bp').feature('batt').feature('te1').setIndex('t_te_tab', 0, 2, 0);
model.physics('bp').feature('batt').feature('te1').setIndex('Qh_te_tab', 0, 2, 0);
model.physics('bp').feature('batt').feature('te1').setIndex('t_te_tab', 't_tr', 2, 0);
model.physics('bp').feature('batt').feature('te1').set('AddOhmicOverPotentialAfterEvent', true);

model.selection.create('sel1', 'Explicit');
model.selection('sel1').model('comp1');
model.selection('sel1').geom(3);
model.selection('sel1').label('Malfunctioning Cell');
model.selection('sel1').set([24 25 26]);

model.physics('bp').feature('batt').feature('te1').selection.named('sel1');

model.selection.create('dif1', 'Difference');
model.selection('dif1').model('comp1');
model.selection('dif1').label('Nonmalfunctioning Cells');
model.selection('dif1').set('add', {'geom1_csel1_dom'});
model.selection('dif1').set('subtract', {'sel1'});

model.physics('bp').feature('batt').feature.duplicate('te2', 'te1');
model.physics('bp').feature('batt').feature('te2').selection.named('dif1');
model.physics('bp').feature('batt').feature('te2').set('EventConditionType', 'maxT');
model.physics('bp').feature('batt').feature('te2').set('maxT_te', 'T_trigger');
model.physics('bp').feature('ccnd').selection.named('geom1_pi2_boxsel1');
model.physics('bp').feature('ccnd').create('egnd1', 'ElectricGround', 2);
model.physics('bp').feature('ccnd').feature('egnd1').selection.named('geom1_pi2_boxsel4');
model.physics('bp').feature('ccnd').create('cdc1', 'ChargeDischargeCycling', 2);
model.physics('bp').feature('ccnd').feature('cdc1').selection.named('geom1_pi2_boxsel5');
model.physics('bp').feature('ccnd').feature('cdc1').set('Ich', 'C_rate*I_1C_pack');
model.physics('bp').feature('ccnd').feature('cdc1').set('Vmax', 'E_max_pack');
model.physics('bp').feature('ccnd').feature('cdc1').set('item.OCCH', true);
model.physics('bp').feature('ccnd').feature('cdc1').set('trech', '1[h]');
model.physics('bp').feature('ccnd').feature('cdc1').set('StartWith', 'Charge_first');
model.physics('bp').feature('nc').selection.named('geom1_unisel2');
model.physics('bp').feature('pc').selection.named('geom1_unisel3');
model.physics('ht').create('bl1', 'BatteryLayers', 3);
model.physics('ht').feature('bl1').selection.named('geom1_csel1_dom');
model.physics('ht').feature('bl1').set('LayerConfiguration', 'SpirallyWound');
model.physics('ht').feature('bl1').set('ThroughLayerConductivity', 'kT_batt_tl');
model.physics('ht').feature('bl1').set('InLayerConductivity', 'kT_batt_il');
model.physics('ht').feature('bl1').set('Density', 'rho_batt');
model.physics('ht').feature('bl1').set('HeatCapacity', 'Cp_batt');
model.physics('ht').feature('init1').set('Tinit', 'T_ext');
model.physics('ht').create('hf1', 'HeatFluxBoundary', 2);
model.physics('ht').feature('hf1').selection.all;
model.physics('ht').feature('hf1').set('HeatFluxType', 'ConvectiveHeatFlux');
model.physics('ht').feature('hf1').set('h', 'h_conv');
model.physics('ht').feature('hf1').set('Text', 'T_ext');

model.multiphysics.create('ech1', 'ElectrochemicalHeating', 'geom1', 3);

model.mesh('mesh1').create('ftri1', 'FreeTri');
model.mesh('mesh1').feature('ftri1').selection.named('geom1_boxsel2');
model.mesh('mesh1').feature('ftri1').create('size1', 'Size');
model.mesh('mesh1').feature('ftri1').feature('size1').set('custom', true);
model.mesh('mesh1').feature('ftri1').feature('size1').set('hminactive', true);
model.mesh('mesh1').feature('ftri1').feature('size1').set('hmin', 'gap/2');
model.mesh('mesh1').feature('ftri1').feature('size1').set('hnarrowactive', true);
model.mesh('mesh1').feature('ftri1').feature('size1').set('hnarrow', 1.5);
model.mesh('mesh1').feature('size').set('hauto', 6);
model.mesh('mesh1').run;
model.mesh('mesh1').create('cpf1', 'CopyFace');
model.mesh('mesh1').feature('cpf1').selection('source').geom(2);
model.mesh('mesh1').feature('cpf1').selection('destination').geom(2);
model.mesh('mesh1').feature('cpf1').selection('source').named('geom1_boxsel2');
model.mesh('mesh1').feature('cpf1').selection('destination').named('geom1_boxsel3');
model.mesh('mesh1').run('cpf1');
model.mesh('mesh1').create('swe1', 'Sweep');
model.mesh('mesh1').feature('swe1').selection.geom('geom1', 3);
model.mesh('mesh1').feature('swe1').selection.named('geom1_boxsel1');
model.mesh('mesh1').run('swe1');
model.mesh('mesh1').create('ftet1', 'FreeTet');
model.mesh('mesh1').run;

model.probe.create('var1', 'GlobalVariable');
model.probe('var1').model('comp1');
model.probe('var1').set('expr', 'bp.ccnd.cdc1.phis0');
model.probe('var1').set('descr', 'Cell potential');
model.probe('var1').set('descractive', true);
model.probe('var1').set('descr', 'Pack voltage');

model.result.table.create('tbl1', 'Table');

model.probe('var1').set('table', 'tbl1');
model.probe('var1').set('window', 'window1');
model.probe('var1').set('windowtitle', 'Probe Plot 1');
model.probe.create('dom1', 'Domain');
model.probe('dom1').model('comp1');
model.probe('dom1').set('intsurface', true);
model.probe('dom1').set('intvolume', true);
model.probe('dom1').set('type', 'maximum');
model.probe('dom1').selection.named('geom1_csel1_dom');
model.probe('dom1').set('expr', 'T');
model.probe('dom1').set('descr', 'Temperature');
model.probe('dom1').set('unit', 'degC');
model.probe('dom1').set('descractive', true);
model.probe('dom1').set('descr', 'Maximum temperature in batteries');

model.result.table.create('tbl2', 'Table');

model.probe('dom1').set('table', 'tbl2');
model.probe('dom1').set('window', 'window1');
model.probe.duplicate('dom2', 'dom1');
model.probe('dom2').set('type', 'average');
model.probe('dom2').set('descr', 'Average temperature in batteries');

model.study('std1').feature('time').set('tunit', 'min');
model.study('std1').feature('time').set('tlist', 'range(0,5,20)');

model.sol.create('sol1');
model.sol('sol1').study('std1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'time');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').feature('comp1_bp_vl1_SOC_8').set('scalemethod', 'manual');
model.sol('sol1').feature('v1').feature('comp1_bp_vl1_SOC_7').set('scalemethod', 'manual');
model.sol('sol1').feature('v1').feature('comp1_bp_vl1_SOC_9').set('scalemethod', 'manual');
model.sol('sol1').feature('v1').feature('comp1_bp_vl1_SOC_4').set('scalemethod', 'manual');
model.sol('sol1').feature('v1').feature('comp1_bp_vl1_SOC_12').set('scalemethod', 'manual');
model.sol('sol1').feature('v1').feature('comp1_bp_vl1_SOC_3').set('scalemethod', 'manual');
model.sol('sol1').feature('v1').feature('comp1_bp_vl1_SOC_13').set('scalemethod', 'manual');
model.sol('sol1').feature('v1').feature('comp1_bp_vl1_SOC_6').set('scalemethod', 'manual');
model.sol('sol1').feature('v1').feature('comp1_bp_vl1_SOC_14').set('scalemethod', 'manual');
model.sol('sol1').feature('v1').feature('comp1_bp_vl1_SOC_5').set('scalemethod', 'manual');
model.sol('sol1').feature('v1').feature('comp1_bp_vl1_SOC_15').set('scalemethod', 'manual');
model.sol('sol1').feature('v1').feature('comp1_bp_vl1_SOC_16').set('scalemethod', 'manual');
model.sol('sol1').feature('v1').feature('comp1_bp_vl1_SOC_17').set('scalemethod', 'manual');
model.sol('sol1').feature('v1').feature('comp1_bp_vl1_SOC_2').set('scalemethod', 'manual');
model.sol('sol1').feature('v1').feature('comp1_bp_vl1_SOC_18').set('scalemethod', 'manual');
model.sol('sol1').feature('v1').feature('comp1_bp_vl1_SOC_1').set('scalemethod', 'manual');
model.sol('sol1').feature('v1').feature('comp1_bp_vl1_SOC_19').set('scalemethod', 'manual');
model.sol('sol1').feature('v1').feature('comp1_bp_vl1_SOC_20').set('scalemethod', 'manual');
model.sol('sol1').feature('v1').feature('comp1_bp_vl1_SOC_10').set('scalemethod', 'manual');
model.sol('sol1').feature('v1').feature('comp1_bp_vl1_SOC_11').set('scalemethod', 'manual');
model.sol('sol1').feature('v1').feature('comp1_bp_vl1_SOC_8').set('scaleval', '1');
model.sol('sol1').feature('v1').feature('comp1_bp_vl1_SOC_7').set('scaleval', '1');
model.sol('sol1').feature('v1').feature('comp1_bp_vl1_SOC_9').set('scaleval', '1');
model.sol('sol1').feature('v1').feature('comp1_bp_vl1_SOC_4').set('scaleval', '1');
model.sol('sol1').feature('v1').feature('comp1_bp_vl1_SOC_12').set('scaleval', '1');
model.sol('sol1').feature('v1').feature('comp1_bp_vl1_SOC_3').set('scaleval', '1');
model.sol('sol1').feature('v1').feature('comp1_bp_vl1_SOC_13').set('scaleval', '1');
model.sol('sol1').feature('v1').feature('comp1_bp_vl1_SOC_6').set('scaleval', '1');
model.sol('sol1').feature('v1').feature('comp1_bp_vl1_SOC_14').set('scaleval', '1');
model.sol('sol1').feature('v1').feature('comp1_bp_vl1_SOC_5').set('scaleval', '1');
model.sol('sol1').feature('v1').feature('comp1_bp_vl1_SOC_15').set('scaleval', '1');
model.sol('sol1').feature('v1').feature('comp1_bp_vl1_SOC_16').set('scaleval', '1');
model.sol('sol1').feature('v1').feature('comp1_bp_vl1_SOC_17').set('scaleval', '1');
model.sol('sol1').feature('v1').feature('comp1_bp_vl1_SOC_2').set('scaleval', '1');
model.sol('sol1').feature('v1').feature('comp1_bp_vl1_SOC_18').set('scaleval', '1');
model.sol('sol1').feature('v1').feature('comp1_bp_vl1_SOC_1').set('scaleval', '1');
model.sol('sol1').feature('v1').feature('comp1_bp_vl1_SOC_19').set('scaleval', '1');
model.sol('sol1').feature('v1').feature('comp1_bp_vl1_SOC_20').set('scaleval', '1');
model.sol('sol1').feature('v1').feature('comp1_bp_vl1_SOC_10').set('scaleval', '1');
model.sol('sol1').feature('v1').feature('comp1_bp_vl1_SOC_11').set('scaleval', '1');
model.sol('sol1').feature('v1').set('control', 'time');
model.sol('sol1').create('t1', 'Time');
model.sol('sol1').feature('t1').set('tlist', 'range(0,5,20)');
model.sol('sol1').feature('t1').set('plot', 'off');
model.sol('sol1').feature('t1').set('plotgroup', 'Default');
model.sol('sol1').feature('t1').set('plotfreq', 'tout');
model.sol('sol1').feature('t1').set('probesel', 'all');
model.sol('sol1').feature('t1').set('probes', {'var1' 'dom1' 'dom2'});
model.sol('sol1').feature('t1').set('probefreq', 'tsteps');
model.sol('sol1').feature('t1').set('atolglobalvaluemethod', 'factor');
model.sol('sol1').feature('t1').set('atolmethod', {'comp1_bp_phis_lm' 'global' 'comp1_bp_vl1_SOC_1' 'global' 'comp1_bp_vl1_SOC_10' 'global' 'comp1_bp_vl1_SOC_11' 'global' 'comp1_bp_vl1_SOC_12' 'global'  ...
'comp1_bp_vl1_SOC_13' 'global' 'comp1_bp_vl1_SOC_14' 'global' 'comp1_bp_vl1_SOC_15' 'global' 'comp1_bp_vl1_SOC_16' 'global' 'comp1_bp_vl1_SOC_17' 'global'  ...
'comp1_bp_vl1_SOC_18' 'global' 'comp1_bp_vl1_SOC_19' 'global' 'comp1_bp_vl1_SOC_2' 'global' 'comp1_bp_vl1_SOC_20' 'global' 'comp1_bp_vl1_SOC_3' 'global'  ...
'comp1_bp_vl1_SOC_4' 'global' 'comp1_bp_vl1_SOC_5' 'global' 'comp1_bp_vl1_SOC_6' 'global' 'comp1_bp_vl1_SOC_7' 'global' 'comp1_bp_vl1_SOC_8' 'global'  ...
'comp1_bp_vl1_SOC_9' 'global' 'comp1_phis' 'global' 'comp1_T' 'global' 'comp1_bp_I_app' 'global' 'comp1_bp_phis_neg' 'global'  ...
'comp1_bp_phis_pos' 'global' 'comp1_bp_te1_t_te' 'global' 'comp1_bp_te2_t_te' 'global' 'comp1_bp_te2_ind' 'global' 'comp1_bp_ccnd_cdc1_CC_CH' 'global'  ...
'comp1_bp_ccnd_cdc1_CC_DCH' 'global' 'comp1_bp_ccnd_cdc1_cycle_counter' 'global' 'comp1_bp_ccnd_cdc1_phis0' 'global' 'comp1_bp_ccnd_cdc1_end_cc_dch' 'global' 'comp1_bp_ccnd_cdc1_end_cc_ch' 'global'  ...
'comp1_bp_ccnd_cdc1_t_dch_start' 'global' 'comp1_bp_ccnd_cdc1_t_ch_start' 'global' 'comp1_bp_ccnd_cdc1_OC_CH' 'global' 'comp1_bp_ccnd_cdc1_end_oc_ch' 'global' 'comp1_bp_ccnd_cdc1_t_rest_start' 'global'});
model.sol('sol1').feature('t1').set('atol', {'comp1_bp_phis_lm' '1e-3' 'comp1_bp_vl1_SOC_1' '1e-3' 'comp1_bp_vl1_SOC_10' '1e-3' 'comp1_bp_vl1_SOC_11' '1e-3' 'comp1_bp_vl1_SOC_12' '1e-3'  ...
'comp1_bp_vl1_SOC_13' '1e-3' 'comp1_bp_vl1_SOC_14' '1e-3' 'comp1_bp_vl1_SOC_15' '1e-3' 'comp1_bp_vl1_SOC_16' '1e-3' 'comp1_bp_vl1_SOC_17' '1e-3'  ...
'comp1_bp_vl1_SOC_18' '1e-3' 'comp1_bp_vl1_SOC_19' '1e-3' 'comp1_bp_vl1_SOC_2' '1e-3' 'comp1_bp_vl1_SOC_20' '1e-3' 'comp1_bp_vl1_SOC_3' '1e-3'  ...
'comp1_bp_vl1_SOC_4' '1e-3' 'comp1_bp_vl1_SOC_5' '1e-3' 'comp1_bp_vl1_SOC_6' '1e-3' 'comp1_bp_vl1_SOC_7' '1e-3' 'comp1_bp_vl1_SOC_8' '1e-3'  ...
'comp1_bp_vl1_SOC_9' '1e-3' 'comp1_phis' '1e-3' 'comp1_T' '1e-3' 'comp1_bp_I_app' '1e-3' 'comp1_bp_phis_neg' '1e-3'  ...
'comp1_bp_phis_pos' '1e-3' 'comp1_bp_te1_t_te' '1e-3' 'comp1_bp_te2_t_te' '1e-3' 'comp1_bp_te2_ind' '1e-3' 'comp1_bp_ccnd_cdc1_CC_CH' '1e-3'  ...
'comp1_bp_ccnd_cdc1_CC_DCH' '1e-3' 'comp1_bp_ccnd_cdc1_cycle_counter' '1e-3' 'comp1_bp_ccnd_cdc1_phis0' '1e-3' 'comp1_bp_ccnd_cdc1_end_cc_dch' '1e-3' 'comp1_bp_ccnd_cdc1_end_cc_ch' '1e-3'  ...
'comp1_bp_ccnd_cdc1_t_dch_start' '1e-3' 'comp1_bp_ccnd_cdc1_t_ch_start' '1e-3' 'comp1_bp_ccnd_cdc1_OC_CH' '1e-3' 'comp1_bp_ccnd_cdc1_end_oc_ch' '1e-3' 'comp1_bp_ccnd_cdc1_t_rest_start' '1e-3'});
model.sol('sol1').feature('t1').set('atolvaluemethod', {'comp1_bp_phis_lm' 'factor' 'comp1_bp_vl1_SOC_1' 'factor' 'comp1_bp_vl1_SOC_10' 'factor' 'comp1_bp_vl1_SOC_11' 'factor' 'comp1_bp_vl1_SOC_12' 'factor'  ...
'comp1_bp_vl1_SOC_13' 'factor' 'comp1_bp_vl1_SOC_14' 'factor' 'comp1_bp_vl1_SOC_15' 'factor' 'comp1_bp_vl1_SOC_16' 'factor' 'comp1_bp_vl1_SOC_17' 'factor'  ...
'comp1_bp_vl1_SOC_18' 'factor' 'comp1_bp_vl1_SOC_19' 'factor' 'comp1_bp_vl1_SOC_2' 'factor' 'comp1_bp_vl1_SOC_20' 'factor' 'comp1_bp_vl1_SOC_3' 'factor'  ...
'comp1_bp_vl1_SOC_4' 'factor' 'comp1_bp_vl1_SOC_5' 'factor' 'comp1_bp_vl1_SOC_6' 'factor' 'comp1_bp_vl1_SOC_7' 'factor' 'comp1_bp_vl1_SOC_8' 'factor'  ...
'comp1_bp_vl1_SOC_9' 'factor' 'comp1_phis' 'factor' 'comp1_T' 'factor' 'comp1_bp_I_app' 'factor' 'comp1_bp_phis_neg' 'factor'  ...
'comp1_bp_phis_pos' 'factor' 'comp1_bp_te1_t_te' 'factor' 'comp1_bp_te2_t_te' 'factor' 'comp1_bp_te2_ind' 'factor' 'comp1_bp_ccnd_cdc1_CC_CH' 'factor'  ...
'comp1_bp_ccnd_cdc1_CC_DCH' 'factor' 'comp1_bp_ccnd_cdc1_cycle_counter' 'factor' 'comp1_bp_ccnd_cdc1_phis0' 'factor' 'comp1_bp_ccnd_cdc1_end_cc_dch' 'factor' 'comp1_bp_ccnd_cdc1_end_cc_ch' 'factor'  ...
'comp1_bp_ccnd_cdc1_t_dch_start' 'factor' 'comp1_bp_ccnd_cdc1_t_ch_start' 'factor' 'comp1_bp_ccnd_cdc1_OC_CH' 'factor' 'comp1_bp_ccnd_cdc1_end_oc_ch' 'factor' 'comp1_bp_ccnd_cdc1_t_rest_start' 'factor'});
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
model.sol('sol1').feature('t1').feature('se1').feature('ss1').set('segvar', {'comp1_bp_vl1_SOC_1' 'comp1_bp_vl1_SOC_2' 'comp1_bp_vl1_SOC_3' 'comp1_bp_vl1_SOC_4' 'comp1_bp_vl1_SOC_5' 'comp1_bp_vl1_SOC_6' 'comp1_bp_vl1_SOC_7' 'comp1_bp_vl1_SOC_8' 'comp1_bp_vl1_SOC_9' 'comp1_bp_vl1_SOC_10'  ...
'comp1_bp_vl1_SOC_11' 'comp1_bp_vl1_SOC_12' 'comp1_bp_vl1_SOC_13' 'comp1_bp_vl1_SOC_14' 'comp1_bp_vl1_SOC_15' 'comp1_bp_vl1_SOC_16' 'comp1_bp_vl1_SOC_17' 'comp1_bp_vl1_SOC_18' 'comp1_bp_vl1_SOC_19' 'comp1_bp_vl1_SOC_20'  ...
'comp1_phis' 'comp1_bp_phis_lm' 'comp1_bp_I_app' 'comp1_bp_phis_neg' 'comp1_bp_phis_pos' 'comp1_bp_te1_t_te' 'comp1_bp_te2_t_te' 'comp1_bp_te2_ind' 'comp1_bp_ccnd_cdc1_CC_CH' 'comp1_bp_ccnd_cdc1_CC_DCH'  ...
'comp1_bp_ccnd_cdc1_cycle_counter' 'comp1_bp_ccnd_cdc1_phis0' 'comp1_bp_ccnd_cdc1_end_cc_dch' 'comp1_bp_ccnd_cdc1_end_cc_ch' 'comp1_bp_ccnd_cdc1_t_dch_start' 'comp1_bp_ccnd_cdc1_t_ch_start' 'comp1_bp_ccnd_cdc1_OC_CH' 'comp1_bp_ccnd_cdc1_end_oc_ch' 'comp1_bp_ccnd_cdc1_t_rest_start'});
model.sol('sol1').feature('t1').feature('se1').feature('ss1').set('linsolver', 'dDef');
model.sol('sol1').feature('t1').feature('se1').feature('ss1').label('Battery Pack');
model.sol('sol1').feature('t1').feature('se1').create('ss2', 'SegregatedStep');
model.sol('sol1').feature('t1').feature('se1').feature('ss2').set('segvar', {'comp1_T'});
model.sol('sol1').feature('t1').feature('se1').feature('ss2').set('subdamp', 0.8);
model.sol('sol1').feature('t1').feature('se1').feature('ss2').set('subjtech', 'once');
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
model.sol('sol1').feature('t1').feature('se1').feature('ss2').set('linsolver', 'i1');
model.sol('sol1').feature('t1').feature('se1').feature('ss2').label('Temperature');
model.sol('sol1').feature('t1').feature('se1').set('segstabacc', 'segaacc');
model.sol('sol1').feature('t1').feature('se1').set('segaaccdim', 5);
model.sol('sol1').feature('t1').feature('se1').set('segaaccdelay', 0);
model.sol('sol1').feature('t1').feature('se1').set('segaaccmix', 0.9);
model.sol('sol1').feature('t1').feature('se1').create('ll1', 'LowerLimit');
model.sol('sol1').feature('t1').feature('se1').feature('ll1').set('lowerlimit', 'comp1.T 0 ');
model.sol('sol1').feature('t1').create('d1', 'Direct');
model.sol('sol1').feature('t1').feature('d1').set('linsolver', 'pardiso');
model.sol('sol1').feature('t1').feature('d1').set('pivotperturb', 1.0E-13);
model.sol('sol1').feature('t1').feature('d1').label('Direct, heat transfer variables (ht)');
model.sol('sol1').feature('t1').feature.remove('fcDef');
model.sol('sol1').attach('std1');
model.sol('sol1').feature('t1').set('initialstepbdf', '0.1[s]');
model.sol('sol1').feature('t1').set('storeudot', false);

model.probe('var1').genResult('none');
model.probe('dom1').genResult('none');
model.probe('dom2').genResult('none');

model.sol('sol1').runAll;

model.result.create('pg2', 'PlotGroup1D');
model.result('pg2').set('data', 'dset1');
model.result('pg2').create('glob1', 'Global');
model.result('pg2').feature('glob1').set('unit', {'' '' ''});
model.result('pg2').feature('glob1').set('expr', {'bp.E_cell_max' 'bp.E_cell_avg' 'bp.E_cell_min'});
model.result('pg2').feature('glob1').set('descr', {'Cell voltage' 'Cell voltage' 'Cell voltage'});
model.result('pg2').label('Cell Voltage (bp)');
model.result('pg2').feature('glob1').set('legendmethod', 'manual');
model.result('pg2').feature('glob1').setIndex('legends', 'E<sub>max</sub>', 0);
model.result('pg2').feature('glob1').setIndex('legends', 'E<sub>avg</sub>', 1);
model.result('pg2').feature('glob1').setIndex('legends', 'E<sub>min</sub>', 2);
model.result('pg2').create('glob2', 'Global');
model.result('pg2').feature('glob2').set('unit', {'' '' ''});
model.result('pg2').feature('glob2').set('expr', {'bp.I_app_max' 'bp.I_app_avg' 'bp.I_app_min'});
model.result('pg2').feature('glob2').set('descr', {'Applied cell current' 'Applied cell current' 'Applied cell current'});
model.result('pg2').feature('glob2').set('linestyle', 'dashed');
model.result('pg2').feature('glob2').set('linecolor', 'cyclereset');
model.result('pg2').feature('glob2').set('legendmethod', 'manual');
model.result('pg2').feature('glob2').setIndex('legends', 'I<sub>max</sub>', 0);
model.result('pg2').feature('glob2').setIndex('legends', 'I<sub>avg</sub>', 1);
model.result('pg2').feature('glob2').setIndex('legends', 'I<sub>min</sub>', 2);
model.result('pg2').set('twoyaxes', true);
model.result('pg2').setIndex('plotonsecyaxis', true, 1, 1);
model.result('pg2').set('titletype', 'none');
model.result.create('pg3', 'PlotGroup1D');
model.result('pg3').set('data', 'dset1');
model.result('pg3').create('glob1', 'Global');
model.result('pg3').feature('glob1').set('unit', {'' '' ''});
model.result('pg3').feature('glob1').set('expr', {'bp.SOC_max' 'bp.SOC_avg' 'bp.SOC_min'});
model.result('pg3').feature('glob1').set('descr', {'State of charge' 'State of charge' 'State of charge'});
model.result('pg3').label('State of Charge (bp)');
model.result('pg3').feature('glob1').set('legendmethod', 'manual');
model.result('pg3').feature('glob1').setIndex('legends', 'SOC<sub>max</sub>', 0);
model.result('pg3').feature('glob1').setIndex('legends', 'SOC<sub>avg</sub>', 1);
model.result('pg3').feature('glob1').setIndex('legends', 'SOC<sub>min</sub>', 2);
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
model.result.create('pg4', 'PlotGroup3D');
model.result('pg4').set('data', 'dset1');
model.result('pg4').setIndex('looplevel', 45, 0);
model.result('pg4').label('Electric Potential (bp)');
model.result('pg4').create('surf1', 'Surface');
model.result('pg4').feature('surf1').set('expr', {'phis'});
model.result.create('pg5', 'PlotGroup3D');
model.result('pg5').label('Temperature (ht)');
model.result('pg5').set('data', 'dset1');
model.result('pg5').setIndex('looplevel', 45, 0);
model.result('pg5').set('defaultPlotID', 'ht/HT_PhysicsInterfaces/icom8/pdef1/pcond3/pcond3/pg1');
model.result('pg5').feature.create('vol1', 'Volume');
model.result('pg5').feature('vol1').set('showsolutionparams', 'on');
model.result('pg5').feature('vol1').set('solutionparams', 'parent');
model.result('pg5').feature('vol1').set('expr', 'T');
model.result('pg5').feature('vol1').set('colortable', 'HeatCameraLight');
model.result('pg5').feature('vol1').set('smooth', 'internal');
model.result('pg5').feature('vol1').set('showsolutionparams', 'on');
model.result('pg5').feature('vol1').set('data', 'parent');
model.result('pg2').run;
model.result('pg5').run;
model.result('pg5').set('edges', false);
model.result('pg5').run;
model.result('pg5').feature.remove('vol1');
model.result('pg5').run;
model.result('pg5').create('surf1', 'Surface');
model.result('pg5').feature('surf1').set('expr', 'T');
model.result('pg5').feature('surf1').set('unit', 'degC');
model.result('pg5').feature('surf1').set('colortable', 'HeatCameraLight');
model.result('pg5').feature('surf1').create('sel1', 'Selection');
model.result('pg5').feature('surf1').feature('sel1').selection.named('geom1_adjsel1');
model.result('pg5').run;
model.result('pg5').run;
model.result('pg5').set('titletype', 'manual');
model.result('pg5').set('paramindicator', 'Time=eval(round(t)) s');

model.view('view1').set('transparency', false);

model.result('pg5').run;
model.result('pg5').set('looplevel', [6]);
model.result('pg5').run;
model.result('pg5').set('looplevel', [8]);
model.result('pg5').run;
model.result('pg5').set('looplevel', [12]);
model.result('pg5').run;
model.result('pg5').set('looplevel', [16]);
model.result('pg5').run;
model.result('pg5').set('looplevel', [20]);
model.result('pg5').run;
model.result('pg5').set('looplevel', [24]);
model.result('pg5').run;
model.result('pg1').set('window', 'window1');
model.result('pg1').run;
model.result('pg1').label('Pack Voltage and Max Temperature Probes');
model.result('pg1').set('twoyaxes', true);
model.result('pg1').setIndex('plotonsecyaxis', true, 1, 1);
model.result('pg1').set('yseclabelactive', true);
model.result('pg1').set('yseclabel', 'Temperature in batteries (degC)');
model.result('pg1').set('legendpos', 'middleright');
model.result('pg1').set('window', 'window1');
model.result('pg1').run;
model.result('pg1').feature('tblp1').set('legendmethod', 'manual');
model.result('pg1').feature('tblp1').setIndex('legends', 'E<sub>pack</sub>', 0);
model.result('pg1').set('window', 'window1');
model.result('pg1').run;
model.result('pg1').feature('tblp2').set('legendmethod', 'manual');
model.result('pg1').feature('tblp2').setIndex('legends', 'T<sub>max</sub>', 0);
model.result('pg1').feature('tblp2').setIndex('legends', 'T<sub>avg</sub>', 1);
model.result('pg1').set('window', 'window1');
model.result('pg1').run;
model.result.export.create('anim1', 'Animation');
model.result.export('anim1').set('target', 'player');
model.result.export('anim1').set('fontsize', '9');
model.result.export('anim1').set('colortheme', 'globaltheme');
model.result.export('anim1').set('customcolor', [1 1 1]);
model.result.export('anim1').set('background', 'color');
model.result.export('anim1').set('gltfincludelines', 'on');
model.result.export('anim1').set('title1d', 'on');
model.result.export('anim1').set('legend1d', 'on');
model.result.export('anim1').set('logo1d', 'on');
model.result.export('anim1').set('options1d', 'on');
model.result.export('anim1').set('title2d', 'on');
model.result.export('anim1').set('legend2d', 'on');
model.result.export('anim1').set('logo2d', 'on');
model.result.export('anim1').set('options2d', 'off');
model.result.export('anim1').set('title3d', 'on');
model.result.export('anim1').set('legend3d', 'on');
model.result.export('anim1').set('logo3d', 'on');
model.result.export('anim1').set('options3d', 'off');
model.result.export('anim1').set('axisorientation', 'on');
model.result.export('anim1').set('grid', 'on');
model.result.export('anim1').set('axes1d', 'on');
model.result.export('anim1').set('axes2d', 'on');
model.result.export('anim1').set('showgrid', 'on');
model.result.export('anim1').set('plotgroup', 'pg5');
model.result.export('anim1').set('looplevelinput', 'interp');
model.result.export('anim1').set('interp', 'range(0,0.25,20)');
model.result.export('anim1').set('framesel', 'all');
model.result.export('anim1').run;

model.func.create('int1', 'Interpolation');
model.func('int1').set('funcname', 'Q_tr');
model.func('int1').setIndex('table', 0, 0, 0);
model.func('int1').setIndex('table', 0, 0, 1);
model.func('int1').setIndex('table', 't_peak', 1, 0);
model.func('int1').setIndex('table', 'Qh_peak/1000', 1, 1);
model.func('int1').setIndex('table', 't_tr', 2, 0);
model.func('int1').setIndex('table', 0, 2, 1);
model.func('int1').setIndex('fununit', 'kW', 0);
model.func('int1').setIndex('argunit', 's', 0);
model.func.remove('int1');

model.title('Thermal Runaway Propagation in a Battery Pack');

model.description(['Due to abuse, such as internal or external short circuits or excessive heating, an individual battery cell may go into thermal runaway, during which the battery cell generates a significant amount of heat. If enough heat is transferred between adjacent cells during a thermal runaway event, neighboring cells will also go into thermal runaway.' newline  newline 'A thermal runaway propagating through the whole pack constitutes a severe safety hazard. When designing a battery pack, measures need to be taken in order to mitigate runaway propagation.' newline  newline 'This tutorial simulates the heat transfer and resulting thermal runaway propagation in a pack consisting of 20' native2unicode(hex2dec({'00' 'a0'}), 'unicode') 'cylindrical cells using event-based heat sources.']);

model.mesh.clearMeshes;

model.sol('sol1').clearSolutionData;

model.label('thermal_runaway_propagation.mph');

model.modelNode.label('Components');

out = model;
