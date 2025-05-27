function out = model
%
% li_battery_sigr_hysteresis.m
%
% Model exported on May 26 2025, 21:26 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/Battery_Design_Module/Batteries,_Lithium-Ion');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 1);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.physics.create('liion', 'LithiumIonBatteryMPH', 'geom1');
model.physics('liion').model('comp1');

model.study.create('std1');
model.study('std1').create('time', 'Transient');
model.study('std1').feature('time').setSolveFor('/physics/liion', true);

% To import content from file, use:
% model.param.loadFile('FILENAME');
model.param.set('L_sep', '25[um]', 'Separator thickness');
model.param.set('sigma_s', '10[S/m]', 'Electrode conductivity');
model.param.set('eps_binder_el', '0.1', 'Electrode binder volume fraction');
model.param.set('epss_el', '0.6', 'Electrode phase volume fraction (Gr+Si)');
model.param.set('epsl_el', '1-eps_binder_el-epss_el', 'Electrolyte phase volume fraction in porous electrode');
model.param.set('Si_f', '1[%]', 'Fraction of Si in electrode blend');
model.param.set('epss_Gr', 'epss_el*(1-Si_f)', 'Graphite volume fraction in electrode');
model.param.set('epss_Si', 'epss_el*Si_f', 'Silicon volume fraction in electrode');
model.param.set('rp_Gr', '5[um]', 'Graphite particle radius in electrode');
model.param.set('rp_Si', '1[um]', 'Silicon particle radius in electrode');
model.param.set('cs_Gr_max', '31507[mol/m^3]', 'Maximum lithium concentration in graphite');
model.param.set('E_max_el', '0.95[V]', 'Electrode potential defining 0% electrode SOC');
model.param.set('E_min_el', '0.075[V]', 'Electrode potential defining 100% electrode SOC');
model.param.set('x_Gr_max', 'comp1.mat1.elpot.Eeq_inv(E_min_el)', 'Graphite intercalation level at 100% SOC');
model.param.set('x_Gr_min', 'comp1.mat1.elpot.Eeq_inv(E_max_el)', 'Graphite intercalation level at 0% SOC');
model.param.set('x_Si_max', 'comp1.Eeq_Si_lower_inv(E_min_el)', 'Silicon intercalation level at 100% SOC');
model.param.set('x_Si_min', 'comp1.Eeq_Si_upper_inv(E_max_el)', 'Silicon intercalation level at 0% SOC');
model.param.set('cs_Si_max', '278000[mol/m^3]', 'Maximum lithium concentration in silicon');
model.param.set('Q_el', '20[Ah/m^2]', 'Electrode capacity');
model.param.set('L_el', 'Q_el/(epss_Gr*(x_Gr_max-x_Gr_min)*cs_Gr_max+epss_Si*(x_Si_max-x_Si_min)*cs_Si_max)/F_const', 'Electrode thickness');
model.param.set('x_Gr_init', 'x_Gr_min', 'Initial intercalation level in graphite');
model.param.set('x_Si_init', 'x_Si_min', 'Initial intercalation level in silicon');
model.param.set('S_init', '1', 'Memory variable initial value');
model.param.set('E_init_el', 'E_max_el', 'Initial electrode potential');
model.param.set('epsl_sep', '0.4', 'Electrolyte volume fraction in separator');
model.param.set('cs_Gr_init', 'x_Gr_init*cs_Gr_max', 'Initial lithium concentration level in graphite');
model.param.set('cs_Si_init', 'x_Si_init*cs_Si_max', 'Initial lithium concentration level in silicon');
model.param.set('i0_ref_Gr', '100[A/m^2]', 'Exchange current density for graphite intercalation (at 50% lithiation)');
model.param.set('i0_ref_Si', '100[A/m^2]', 'Exchange current density for graphite intercalation (at 50% lithiation)');
model.param.set('i0_ref_Li', '100[A/m^2]', 'Exchange current density for lithium metal oxidation');
model.param.set('K_S', '100', 'Memory variable rate constant');
model.param.set('C_rate', '1', 'Lithiation/delithiation rate');
model.param.set('i_1C', 'Q_el/1[h]', 'Current density corresponding to 1C');
model.param.set('E_switch', 'E_min_el', 'Lithiation-to-delithiation switching potential');
model.param.set('E_end', 'E_max_el', 'Simulation end potential');

model.geom('geom1').run;

model.material.create('mat1', 'Common', 'comp1');
model.material('mat1').propertyGroup('def').func.create('int1', 'Interpolation');
model.material('mat1').propertyGroup('def').func.create('int2', 'Interpolation');
model.material('mat1').propertyGroup.create('ElectrodePotential', 'Equilibrium potential');
model.material('mat1').propertyGroup('ElectrodePotential').func.create('int1', 'Interpolation');
model.material('mat1').propertyGroup('ElectrodePotential').func.create('int2', 'Interpolation');
model.material('mat1').propertyGroup.create('OperationalSOC', 'Operational electrode state of charge');
model.material('mat1').propertyGroup.create('ic', 'Intercalation strain');
model.material('mat1').propertyGroup('ic').func.create('int1', 'Interpolation');
model.material('mat1').propertyGroup.create('EquilibriumConcentration', 'Equilibrium concentration');
model.material('mat1').label('Graphite, LixC6 MCMB (Negative, Li-ion Battery)');
model.material('mat1').propertyGroup('def').func('int1').set('funcname', 'E_int');
model.material('mat1').propertyGroup('def').func('int1').set('table', {'0' '32.47'; '0.333' '28.56'; '0.5' '58.06'; '1' '108.67'});
model.material('mat1').propertyGroup('def').func('int1').set('fununit', {'GPa'});
model.material('mat1').propertyGroup('def').func('int1').set('argunit', {'1'});
model.material('mat1').propertyGroup('def').func('int2').set('funcname', 'nu_int');
model.material('mat1').propertyGroup('def').func('int2').set('table', {'0' '0.32'; '0.333' '0.39'; '0.5' '0.34'; '1' '0.24'});
model.material('mat1').propertyGroup('def').func('int2').set('fununit', {''});
model.material('mat1').propertyGroup('def').set('youngsmodulus', '');
model.material('mat1').propertyGroup('def').set('poissonsratio', '');
model.material('mat1').propertyGroup('def').set('youngsmodulus', 'E_int(c/csmax)');
model.material('mat1').propertyGroup('def').set('INFO_PREFIX:youngsmodulus', 'Yue Qi et al 2010 J. Electrochem. Soc. 157 A558');
model.material('mat1').propertyGroup('def').set('poissonsratio', 'nu_int(c/csmax)');
model.material('mat1').propertyGroup('def').set('INFO_PREFIX:poissonsratio', 'Yue Qi et al 2010 J. Electrochem. Soc. 157 A558');
model.material('mat1').propertyGroup('def').set('electricconductivity', {'100[S/m]' '0' '0' '0' '100[S/m]' '0' '0' '0' '100[S/m]'});
model.material('mat1').propertyGroup('def').set('INFO_PREFIX:electricconductivity', ['V. Srinivasan, and J. Newman, ' native2unicode(hex2dec({'20' '1c'}), 'unicode') 'Design and Optimization of a Natural Graphite/Iron Phosphate Lithium Ion Cell,' native2unicode(hex2dec({'20' '1d'}), 'unicode') ' J. Electrochem. Soc., vol. 151, p. 1530, 2004.']);
model.material('mat1').propertyGroup('def').set('diffusion', {'1.4523e-13*exp(68025.7/8.314*(1/(T_ref/1[K])-1/(T2/1[K])))[m^2/s]' '0' '0' '0' '1.4523e-13*exp(68025.7/8.314*(1/(T_ref/1[K])-1/(T2/1[K])))[m^2/s]' '0' '0' '0' '1.4523e-13*exp(68025.7/8.314*(1/(T_ref/1[K])-1/(T2/1[K])))[m^2/s]'});
model.material('mat1').propertyGroup('def').set('INFO_PREFIX:diffusion', ['K. Kumaresan, G. Sikha, and R. E. White, ' native2unicode(hex2dec({'20' '1c'}), 'unicode') 'Thermal Model for a Li-Ion Cell,' native2unicode(hex2dec({'20' '1d'}), 'unicode') ' J. Electrochem. Soc., vol. 155, p. A164, 2008.']);
model.material('mat1').propertyGroup('def').set('thermalconductivity', {'1[W/(m*K)]' '0' '0' '0' '1[W/(m*K)]' '0' '0' '0' '1[W/(m*K)]'});
model.material('mat1').propertyGroup('def').set('INFO_PREFIX:thermalconductivity', 'S. Chen, C. Wan, and Y. Wang, J. Power Sources, 140, 111 (2005).');
model.material('mat1').propertyGroup('def').set('heatcapacity', '750[J/(kg*K)]');
model.material('mat1').propertyGroup('def').set('INFO_PREFIX:heatcapacity', 'SI Chemical Data, John Wiley & Sons, 1994');
model.material('mat1').propertyGroup('def').set('density', '2300[kg/m^3]');
model.material('mat1').propertyGroup('def').set('INFO_PREFIX:density', 'SI Chemical Data, John Wiley & Sons, 1994');
model.material('mat1').propertyGroup('def').set('csmax', '31507[mol/m^3]');
model.material('mat1').propertyGroup('def').descr('csmax', '');
model.material('mat1').propertyGroup('def').set('T_ref', '318[K]');
model.material('mat1').propertyGroup('def').descr('T_ref', '');
model.material('mat1').propertyGroup('def').set('T2', 'min(393.15,max(T,223.15))');
model.material('mat1').propertyGroup('def').descr('T2', '');
model.material('mat1').propertyGroup('def').addInput('temperature');
model.material('mat1').propertyGroup('def').addInput('concentration');
model.material('mat1').propertyGroup('ElectrodePotential').func('int1').set('funcname', 'Eeq_int1');
model.material('mat1').propertyGroup('ElectrodePotential').func('int1').set('table', {'0' '2.781186612';  ...
'0.01' '1.520893224';  ...
'0.02' '0.893922607';  ...
'0.03' '0.581284406';  ...
'0.04' '0.42452844';  ...
'0.05' '0.344895805';  ...
'0.06' '0.303146342';  ...
'0.07' '0.279578072';  ...
'0.08' '0.264093089';  ...
'0.09' '0.251347845';  ...
'0.1' '0.238588379';  ...
'0.11' '0.224803164';  ...
'0.12' '0.210294358';  ...
'0.13' '0.196408586';  ...
'0.14' '0.184624188';  ...
'0.15' '0.175188157';  ...
'0.16' '0.167373311';  ...
'0.17' '0.160452107';  ...
'0.18' '0.154025412';  ...
'0.19' '0.147948522';  ...
'0.2' '0.142214997';  ...
'0.21' '0.13688271';  ...
'0.22' '0.132033114';  ...
'0.23' '0.127747573';  ...
'0.24' '0.124091616';  ...
'0.25' '0.121103387';  ...
'0.26' '0.11878567';  ...
'0.27' '0.117102317';  ...
'0.28' '0.115980205';  ...
'0.29' '0.115317054';  ...
'0.3' '0.114993965';  ...
'0.31' '0.114890105';  ...
'0.32' '0.114886278';  ...
'0.33' '0.114884619';  ...
'0.34' '0.114873068';  ...
'0.35' '0.114824904';  ...
'0.36' '0.114644725';  ...
'0.37' '0.114372614';  ...
'0.38' '0.114017954';  ...
'0.39' '0.11359371';  ...
'0.4' '0.11311133';  ...
'0.41' '0.112575849';  ...
'0.42' '0.111980245';  ...
'0.43' '0.111297682';  ...
'0.44' '0.110470149';  ...
'0.45' '0.109393081';  ...
'0.46' '0.107900592';  ...
'0.47' '0.10576964';  ...
'0.48' '0.102783317';  ...
'0.49' '0.09889031';  ...
'0.5' '0.094391564';  ...
'0.51' '0.089921069';  ...
'0.52' '0.086112415';  ...
'0.53' '0.083265315';  ...
'0.54' '0.081326247';  ...
'0.55' '0.080074892';  ...
'0.56' '0.07928329';  ...
'0.57' '0.078778765';  ...
'0.58' '0.078447703';  ...
'0.59' '0.078220432';  ...
'0.6' '0.078055641';  ...
'0.61' '0.077929111';  ...
'0.62' '0.077826563';  ...
'0.63' '0.077739397';  ...
'0.64' '0.077662227';  ...
'0.65' '0.077591472';  ...
'0.66' '0.077524557';  ...
'0.67' '0.077459463';  ...
'0.68' '0.077394455';  ...
'0.69' '0.077327934';  ...
'0.7' '0.077258337';  ...
'0.71' '0.077184077';  ...
'0.72' '0.077103499';  ...
'0.73' '0.077014851';  ...
'0.74' '0.076916258';  ...
'0.75' '0.07680571';  ...
'0.76' '0.07668104';  ...
'0.77' '0.07653992';  ...
'0.78' '0.076379839';  ...
'0.79' '0.076198086';  ...
'0.8' '0.075991699';  ...
'0.81' '0.075757371';  ...
'0.82' '0.075491288';  ...
'0.83' '0.075188813';  ...
'0.84' '0.07484398';  ...
'0.85' '0.074448647';  ...
'0.86' '0.07399118';  ...
'0.87' '0.073454466';  ...
'0.88' '0.072812991';  ...
'0.89' '0.072028722';  ...
'0.9' '0.071045433';  ...
'0.91' '0.069780996';  ...
'0.92' '0.068116222';  ...
'0.93' '0.065874599';  ...
'0.94' '0.062770873';  ...
'0.95' '0.058253898';  ...
'0.96' '0.051075794';  ...
'0.97' '0.038790069';  ...
'0.98' '0.020172191'});
model.material('mat1').propertyGroup('ElectrodePotential').func('int1').set('interp', 'piecewisecubic');
model.material('mat1').propertyGroup('ElectrodePotential').func('int1').set('extrap', 'linear');
model.material('mat1').propertyGroup('ElectrodePotential').func('int1').set('fununit', {'V'});
model.material('mat1').propertyGroup('ElectrodePotential').func('int1').set('argunit', {''});
model.material('mat1').propertyGroup('ElectrodePotential').func('int1').set('defineinv', true);
model.material('mat1').propertyGroup('ElectrodePotential').func('int1').set('funcinvname', 'Eeq_inv');
model.material('mat1').propertyGroup('ElectrodePotential').func('int2').set('funcname', 'dEeqdT_int1');
model.material('mat1').propertyGroup('ElectrodePotential').func('int2').set('table', {'0' '3.0e-4';  ...
'0.17' '0';  ...
'0.24' '-6e-5';  ...
'0.28' '-1.6e-4';  ...
'0.5' '-1.6e-4';  ...
'0.54' '-9e-5';  ...
'0.71' '-9e-5';  ...
'0.85' '-1.0e-4';  ...
'1.0' '-1.2e-4'});
model.material('mat1').propertyGroup('ElectrodePotential').func('int2').set('fununit', {'V/K'});
model.material('mat1').propertyGroup('ElectrodePotential').func('int2').set('argunit', {''});
model.material('mat1').propertyGroup('ElectrodePotential').set('Eeq', 'Eeq_int1(soc)+dEeqdT_int1(soc)*(T-298[K])');
model.material('mat1').propertyGroup('ElectrodePotential').set('INFO_PREFIX:Eeq', ['D. P Karthikeyan, G. Sikha, and R. E. White, ' native2unicode(hex2dec({'20' '1c'}), 'unicode') 'Thermodynamic model development for lithium intercalation electrodes,' native2unicode(hex2dec({'20' '1d'}), 'unicode') ' J. Power Sources, vol. 185, p. 1398, 2008.']);
model.material('mat1').propertyGroup('ElectrodePotential').set('dEeqdT', 'dEeqdT_int1(soc)');
model.material('mat1').propertyGroup('ElectrodePotential').set('INFO_PREFIX:dEeqdT', ['K. E. Thomas, and J. Newman, ' native2unicode(hex2dec({'20' '1c'}), 'unicode') 'Heats of mixing and of entropy in porous insertion electrodes,' native2unicode(hex2dec({'20' '1d'}), 'unicode') ' J. Power Sources., vol. 119-121, p. 844, 2003.']);
model.material('mat1').propertyGroup('ElectrodePotential').set('cEeqref', 'def.csmax');
model.material('mat1').propertyGroup('ElectrodePotential').set('soc', 'c/cEeqref');
model.material('mat1').propertyGroup('ElectrodePotential').descr('soc', '');
model.material('mat1').propertyGroup('ElectrodePotential').addInput('concentration');
model.material('mat1').propertyGroup('ElectrodePotential').addInput('temperature');
model.material('mat1').propertyGroup('OperationalSOC').set('socmax', 'elpot.Eeq_inv(E_min)');
model.material('mat1').propertyGroup('OperationalSOC').set('socmin', 'elpot.Eeq_inv(E_max)');
model.material('mat1').propertyGroup('OperationalSOC').set('E_max', '1[V]');
model.material('mat1').propertyGroup('OperationalSOC').set('E_min', '0.075[V]');
model.material('mat1').propertyGroup('ic').func('int1').set('funcname', 'dVOLdSOL');
model.material('mat1').propertyGroup('ic').func('int1').set('table', {'0' '0';  ...
'0.006802721088435382' '0.12500000000000178';  ...
'0.06316812439261421' '1.2736486486486491';  ...
'0.11175898931000966' '2.523648648648649';  ...
'0.17978620019436342' '3.5709459459459474';  ...
'0.2400388726919339' '4.449324324324325';  ...
'0.2905733722060252' '5.192567567567568';  ...
'0.3566569484936831' '5.66554054054054';  ...
'0.4188532555879494' '5.969594594594595';  ...
'0.48104956268221566' '6.10472972972973';  ...
'0.5432458697764819' '6.173648648648647';  ...
'0.58600583090379' '6.306081081081081';  ...
'0.6112730806608356' '7.726351351351352';  ...
'0.6443148688046647' '8.570945945945946';  ...
'0.694849368318756' '9.449324324324323';  ...
'0.7414965986394557' '10.29391891891892';  ...
'0.7764820213799805' '10.902027027027025';  ...
'0.8231292517006802' '11.543918918918918';  ...
'0.8542274052478133' '12.152027027027026';  ...
'0.8833819241982507' '12.827702702702702';  ...
'0.9183673469387755' '12.996621621621621';  ...
'0.9494655004859086' '13.16554054054054'});
model.material('mat1').propertyGroup('ic').func('int1').set('extrap', 'linear');
model.material('mat1').propertyGroup('ic').func('int1').set('fununit', {'%'});
model.material('mat1').propertyGroup('ic').func('int1').set('argunit', {'1'});
model.material('mat1').propertyGroup('ic').set('dvol', 'dVOLdSOL(c/def.csmax)');
model.material('mat1').propertyGroup('ic').set('INFO_PREFIX:dvol', ['S. Schweidler, L. de Biasi, A. Schiele, P. Hartmann, T. Brezesinski and J. Janek, "Volume Changes of Graphite Anodes Revisited: A Combined Operando X-Ray Diffraction and In Situ Pressure Analysis Study", J. Phys. Chem. C, 2018, 122, 8829' native2unicode(hex2dec({'20' '13'}), 'unicode') '8835']);
model.material('mat1').propertyGroup('ic').addInput('concentration');
model.material('mat1').propertyGroup('EquilibriumConcentration').set('csEq', 'def.csmax*elpot.Eeq_inv(V)');
model.material('mat1').propertyGroup('EquilibriumConcentration').addInput('electricpotential');
model.material.create('mat2', 'Common', 'comp1');
model.material('mat2').propertyGroup('def').func.create('int1', 'Interpolation');
model.material('mat2').propertyGroup.create('ElectrolyteConductivity', 'Electrolyte conductivity');
model.material('mat2').propertyGroup('ElectrolyteConductivity').func.create('int1', 'Interpolation');
model.material('mat2').propertyGroup.create('SpeciesProperties', 'Species properties');
model.material('mat2').propertyGroup('SpeciesProperties').func.create('int1', 'Interpolation');
model.material('mat2').propertyGroup('SpeciesProperties').func.create('int2', 'Interpolation');
model.material('mat2').propertyGroup.create('ElectrolyteSaltConcentration', 'Electrolyte salt concentration');
model.material('mat2').label('LiPF6 in 3:7 EC:EMC (Liquid, Li-ion Battery)');
model.material('mat2').propertyGroup('def').func('int1').set('funcname', 'DL_int1');
model.material('mat2').propertyGroup('def').func('int1').set('table', {'200' '3.9e-10/(1-200*59e-6)';  ...
'500' '4.12e-10/(1-500*59e-6)';  ...
'800' '4e-10/(1-800*59e-6)';  ...
'1000' '3.8e-10/(1-1000*59e-6)';  ...
'1200' '3.50e-10/(1-1200*59e-6)';  ...
'1600' '2.68e-10/(1-1600*59e-6)';  ...
'2000' '1.9e-10/(1-2000*59e-6)'});
model.material('mat2').propertyGroup('def').func('int1').set('interp', 'piecewisecubic');
model.material('mat2').propertyGroup('def').func('int1').set('fununit', {'m^2/s'});
model.material('mat2').propertyGroup('def').func('int1').set('argunit', {''});
model.material('mat2').propertyGroup('def').set('diffusion', {'DL_int1(c/1[mol/m^3])*exp(16500/8.314*(1/(T_ref/1[K])-1/(T2/1[K])))' '0' '0' '0' 'DL_int1(c/1[mol/m^3])*exp(16500/8.314*(1/(T_ref/1[K])-1/(T2/1[K])))' '0' '0' '0' 'DL_int1(c/1[mol/m^3])*exp(16500/8.314*(1/(T_ref/1[K])-1/(T2/1[K])))'});
model.material('mat2').propertyGroup('def').set('INFO_PREFIX:diffusion', 'T. G. Zavalis, M. Behm, and G. Lindbergh, "Investigations of Short-Circuit Scenarios in a Lithium-Ion Battery Cell," J. Electrochem. Soc., vol. 159, p. A848, 2012.');
model.material('mat2').propertyGroup('def').set('T_ref', '298[K]');
model.material('mat2').propertyGroup('def').descr('T_ref', '');
model.material('mat2').propertyGroup('def').set('T2', 'min(393.15,max(T,223.15))');
model.material('mat2').propertyGroup('def').descr('T2', '');
model.material('mat2').propertyGroup('def').addInput('concentration');
model.material('mat2').propertyGroup('def').addInput('temperature');
model.material('mat2').propertyGroup('ElectrolyteConductivity').func('int1').set('funcname', 'sigmal_int1');
model.material('mat2').propertyGroup('ElectrolyteConductivity').func('int1').set('table', {'0' '1e-6';  ...
'200' '0.455';  ...
'500' '0.783';  ...
'800' '0.935';  ...
'1000' '0.95';  ...
'1200' '0.927';  ...
'1600' '0.78';  ...
'2000' '0.60';  ...
'2200' '0.515'});
model.material('mat2').propertyGroup('ElectrolyteConductivity').func('int1').set('interp', 'piecewisecubic');
model.material('mat2').propertyGroup('ElectrolyteConductivity').func('int1').set('fununit', {'S/m'});
model.material('mat2').propertyGroup('ElectrolyteConductivity').func('int1').set('argunit', {''});
model.material('mat2').propertyGroup('ElectrolyteConductivity').set('sigmal', {'sigmal_int1(c/1[mol/m^3])*exp(4000/8.314*(1/(T_ref2/1[K])-1/(T3/1[K])))' '0' '0' '0' 'sigmal_int1(c/1[mol/m^3])*exp(4000/8.314*(1/(T_ref2/1[K])-1/(T3/1[K])))' '0' '0' '0' 'sigmal_int1(c/1[mol/m^3])*exp(4000/8.314*(1/(T_ref2/1[K])-1/(T3/1[K])))'});
model.material('mat2').propertyGroup('ElectrolyteConductivity').set('INFO_PREFIX:sigmal', 'T. G. Zavalis, M. Behm, and G. Lindbergh, "Investigations of Short-Circuit Scenarios in a Lithium-Ion Battery Cell," J. Electrochem. Soc., vol. 159, p. A848, 2012.');
model.material('mat2').propertyGroup('ElectrolyteConductivity').set('T_ref2', '298[K]');
model.material('mat2').propertyGroup('ElectrolyteConductivity').descr('T_ref2', '');
model.material('mat2').propertyGroup('ElectrolyteConductivity').set('T3', 'min(393.15,max(T,223.15))');
model.material('mat2').propertyGroup('ElectrolyteConductivity').descr('T3', '');
model.material('mat2').propertyGroup('ElectrolyteConductivity').addInput('concentration');
model.material('mat2').propertyGroup('ElectrolyteConductivity').addInput('temperature');
model.material('mat2').propertyGroup('SpeciesProperties').func('int1').set('funcname', 'transpNm_int1');
model.material('mat2').propertyGroup('SpeciesProperties').func('int1').set('table', {'200' '0.37';  ...
'500' '0.322';  ...
'800' '0.27';  ...
'1000' '0.251';  ...
'1200' '0.248';  ...
'1600' '0.236';  ...
'2000' '0.11'});
model.material('mat2').propertyGroup('SpeciesProperties').func('int1').set('interp', 'piecewisecubic');
model.material('mat2').propertyGroup('SpeciesProperties').func('int1').set('fununit', {''});
model.material('mat2').propertyGroup('SpeciesProperties').func('int1').set('argunit', {''});
model.material('mat2').propertyGroup('SpeciesProperties').func('int2').set('funcname', 'actdep_int1');
model.material('mat2').propertyGroup('SpeciesProperties').func('int2').set('table', {'200' '0';  ...
'500' '0.29';  ...
'800' '0.695';  ...
'1000' '1';  ...
'1200' '1.32';  ...
'1600' '2.07';  ...
'2000' '2.50'});
model.material('mat2').propertyGroup('SpeciesProperties').func('int2').set('interp', 'piecewisecubic');
model.material('mat2').propertyGroup('SpeciesProperties').func('int2').set('fununit', {''});
model.material('mat2').propertyGroup('SpeciesProperties').func('int2').set('argunit', {''});
model.material('mat2').propertyGroup('SpeciesProperties').set('transpNum', 'transpNm_int1(c/1[mol/m^3])');
model.material('mat2').propertyGroup('SpeciesProperties').set('INFO_PREFIX:transpNum', ['A. Nyman, M. Behm, and G. Lindbergh, ' native2unicode(hex2dec({'20' '1c'}), 'unicode') 'Electrochemical characterisation and modelling of the mass transport phenomena in LiPF6-EC-EMC,' native2unicode(hex2dec({'20' '1d'}), 'unicode') ' Electrochim. Acta, vol. 53, p. 6356, 2008.']);
model.material('mat2').propertyGroup('SpeciesProperties').set('fcl', 'actdep_int1(c/1[mol/m^3])*exp(-1000/8.314*(1/(T_ref3/1[K])-1/(T4/1[K])))');
model.material('mat2').propertyGroup('SpeciesProperties').set('INFO_PREFIX:fcl', 'T. G. Zavalis, M. Behm, and G. Lindbergh, "Investigations of Short-Circuit Scenarios in a Lithium-Ion Battery Cell," J. Electrochem. Soc., vol. 159, p. A848, 2012.');
model.material('mat2').propertyGroup('SpeciesProperties').set('T4', 'min(393.15,max(T,223.15))');
model.material('mat2').propertyGroup('SpeciesProperties').descr('T4', '');
model.material('mat2').propertyGroup('SpeciesProperties').set('T_ref3', '298[K]');
model.material('mat2').propertyGroup('SpeciesProperties').descr('T_ref3', '');
model.material('mat2').propertyGroup('SpeciesProperties').addInput('concentration');
model.material('mat2').propertyGroup('SpeciesProperties').addInput('temperature');
model.material('mat2').propertyGroup('ElectrolyteSaltConcentration').identifier('cElsalt');
model.material('mat2').propertyGroup('ElectrolyteSaltConcentration').set('cElsalt', '1200[mol/m^3]');
model.material.create('mat3', 'Common', 'comp1');
model.material('mat3').propertyGroup.create('ElectrodePotential', 'Equilibrium potential');
model.material('mat3').label('Lithium Metal, Li (Negative, Li-ion Battery)');
model.material('mat3').propertyGroup('def').set('youngsmodulus', '');
model.material('mat3').propertyGroup('def').set('poissonsratio', '');
model.material('mat3').propertyGroup('def').set('density', '');
model.material('mat3').propertyGroup('def').set('thermalconductivity', '');
model.material('mat3').propertyGroup('def').set('electricconductivity', '');
model.material('mat3').propertyGroup('def').set('heatcapacity', '');
model.material('mat3').propertyGroup('def').set('youngsmodulus', '2[GPa]');
model.material('mat3').propertyGroup('def').set('INFO_PREFIX:youngsmodulus', 'Yue Qi et al 2010 J. Electrochem. Soc. 157 A558');
model.material('mat3').propertyGroup('def').set('poissonsratio', '0.34');
model.material('mat3').propertyGroup('def').set('INFO_PREFIX:poissonsratio', 'Yue Qi et al 2010 J. Electrochem. Soc. 157 A558');
model.material('mat3').propertyGroup('def').set('density', '0.534[g/cm^3]');
model.material('mat3').propertyGroup('def').set('INFO_PREFIX:density', 'https://en.wikipedia.org/wiki/Lithium');
model.material('mat3').propertyGroup('def').set('thermalconductivity', {'84.8[W/(m*K)]' '0' '0' '0' '84.8[W/(m*K)]' '0' '0' '0' '84.8[W/(m*K)]'});
model.material('mat3').propertyGroup('def').set('INFO_PREFIX:thermalconductivity', 'https://en.wikipedia.org/wiki/Lithium');
model.material('mat3').propertyGroup('def').set('electricconductivity', {['1/(92.8[n' 'ohm' '*m])'] '0' '0' '0' ['1/(92.8[n' 'ohm' '*m])'] '0' '0' '0' ['1/(92.8[n' 'ohm' '*m])']});
model.material('mat3').propertyGroup('def').set('INFO_PREFIX:electricconductivity', 'https://en.wikipedia.org/wiki/Lithium');
model.material('mat3').propertyGroup('def').set('heatcapacity', '3.58[kJ/kg/K]');
model.material('mat3').propertyGroup('def').set('INFO_PREFIX:heatcapacity', 'https://en.wikipedia.org/wiki/Lithium');
model.material('mat3').propertyGroup('ElectrodePotential').set('Eeq', '0[V]');
model.material('mat3').propertyGroup('ElectrodePotential').set('dEeqdT', '0[V/K]');
model.material('mat3').propertyGroup('ElectrodePotential').set('cEeqref', '0[M]');
model.material('mat3').propertyGroup('ElectrodePotential').addInput('concentration');
model.material('mat3').propertyGroup('ElectrodePotential').addInput('temperature');

model.func.create('int1', 'Interpolation');
model.func('int1').model('comp1');
model.func('int1').label('Interpolation - Eeq Si Upper');
model.func('int1').set('funcname', 'Eeq_Si_upper');
model.func('int1').set('table', {'0.0004433324856174675' '0.9912126584246127';  ...
'0.008533291176652524' '0.9548868880914604';  ...
'0.02202783504119' '0.9068414899989796';  ...
'0.036424905504354815' '0.8587955631855859';  ...
'0.05352638343792315' '0.807233113579298';  ...
'0.07244137410335542' '0.7650427708782637';  ...
'0.09406500200649588' '0.7240224875578752';  ...
'0.11388992136333863' '0.6900331349396228';  ...
'0.13822430138783953' '0.6525262020866501';  ...
'0.16526837609187478' '0.6173609741577081';  ...
'0.19411856143499084' '0.5833663343303248';  ...
'0.22567949889946748' '0.5528850449703575';  ...
'0.25634108209079515' '0.5259192209614579';  ...
'0.293325638681645' '0.504807923623092';  ...
'0.3285061995170664' '0.484869329269937';  ...
'0.3681983359037982' '0.4637564457688318';  ...
'0.4060843616514492' '0.4414729741661676';  ...
'0.4403613384464171' '0.42036326299054094';  ...
'0.4746340854740803' '0.39456696964137405';  ...
'0.5098083016585446' '0.36759850202790934';  ...
'0.5576147178983133' '0.33710769569150645';  ...
'0.6009159032377283' '0.31482105176336384';  ...
'0.6406122693917647' '0.29839475043579844';  ...
'0.6848212685389379' '0.2819658055036678';  ...
'0.7263226878902291' '0.2655384467342762';  ...
'0.765114412561986' '0.24676938304085405';  ...
'0.8165245905453069' '0.20924658856048883';  ...
'0.8390518024889009' '0.16939742206257236';  ...
'0.8498345367902516' '0.11666702795929096';  ...
'0.8533864838843223' '0.05222440818946428'});
model.func('int1').set('extrap', 'linear');
model.func('int1').setIndex('fununit', 'V', 0);
model.func('int1').set('defineinv', true);
model.func('int1').set('funcinvname', 'Eeq_Si_upper_inv');
model.func.create('int2', 'Interpolation');
model.func('int2').model('comp1');
model.func('int2').label('Interpolation - Eeq Si Lower');
model.func('int2').set('funcname', 'Eeq_Si_lower');
model.func('int2').set('table', {'0.0004465048110959477' '0.9947275950547677';  ...
'0.005634314410235611' '0.7428206309015168';  ...
'0.018166057492054646' '0.627991965557005';  ...
'0.03343604618271433' '0.5471394348079184';  ...
'0.04602700600679829' '0.4979229198929659';  ...
'0.06132977539406893' '0.45339140098881403';  ...
'0.07843442565311574' '0.40534388801268095';  ...
'0.10816070154920517' '0.34205758087976';  ...
'0.13520689113689272' '0.3092356440375881';  ...
'0.185718772288891' '0.2763999604516758';  ...
'0.25067636622805745' '0.2494140450480795';  ...
'0.2921820153466533' '0.2376732684522278';  ...
'0.34000323577198815' '0.22358549972321473';  ...
'0.37880130509470183' '0.2118463092901025';  ...
'0.40496823180393765' '0.20480110312331334';  ...
'0.4455671245566015' '0.18837427307483479';  ...
'0.48526243326881174' '0.1707763262038845';  ...
'0.5258581536959971' '0.15083455952525116';  ...
'0.5655524049663813' '0.13206496711091587';  ...
'0.6061523551608713' '0.11680978260582242';  ...
'0.6512670532321504' '0.1038952455829335';  ...
'0.6981868045006839' '0.09097965111821849';  ...
'0.7442061440542426' '0.08040787646118652';  ...
'0.7911269527646024' '0.0686639275398565';  ...
'0.8344376550804529' '0.056922093502178917';  ...
'0.8524839572856949' '0.05222493691037733'});
model.func('int2').set('extrap', 'linear');
model.func('int2').setIndex('fununit', 'V', 0);
model.func('int2').set('defineinv', true);
model.func('int2').set('funcinvname', 'Eeq_Si_lower_inv');

model.geom('geom1').create('i1', 'Interval');
model.geom('geom1').feature('i1').set('specify', 'len');
model.geom('geom1').feature('i1').setIndex('len', 'L_el', 0);
model.geom('geom1').feature('i1').setIndex('len', 'L_sep', 1);
model.geom('geom1').runPre('fin');
model.geom('geom1').run;

model.material('mat1').selection.set([1]);
model.material('mat2').selection.set([2]);
model.material('mat3').selection.geom('geom1', 0);
model.material('mat3').selection.set([3]);

model.cpl.create('intop1', 'Integration', 'geom1');
model.cpl('intop1').set('axisym', true);
model.cpl('intop1').label('Integration - Reference');
model.cpl('intop1').set('opname', 'intop_ref');
model.cpl('intop1').selection.geom('geom1', 0);
model.cpl('intop1').selection.set([2]);
model.cpl.create('intop2', 'Integration', 'geom1');
model.cpl('intop2').set('axisym', true);
model.cpl('intop2').label('Integration - Current Collector');
model.cpl('intop2').set('opname', 'intop_cc');
model.cpl('intop2').selection.geom('geom1', 0);
model.cpl('intop2').selection.set([1]);

model.variable.create('var1');
model.variable('var1').model('comp1');
model.variable('var1').label('Variables - Electrode');
model.variable('var1').selection.geom('geom1', 1);
model.variable('var1').selection.set([1]);

% To import content from file, use:
% model.variable('var1').loadFile('FILENAME');
model.variable('var1').set('x_Si', 'liion.cs_surface_addm1/cs_Si_max', 'Intercalation level at surface of silicon particles');
model.variable('var1').set('U_avg', '(Eeq_Si_upper(x_Si)+Eeq_Si_lower(x_Si))/2', 'Average equilibrium potential');
model.variable('var1').set('U_offset', '(Eeq_Si_upper(x_Si)-Eeq_Si_lower(x_Si))/2', 'Offset between upper and lower equilibrium potentials');
model.variable('var1').set('Eeq_Si', 'U_avg+U_offset*S', 'Silicon equilibrium potential');
model.variable('var1').set('dx_Sidt', 'liion.iv_addm1_per1/(F_const*epss_Si*cs_Si_max)', 'Silicon intercalation rate');
model.variable('var1').set('dSdt', '-K_S*abs(dx_Sidt)*(S-sign(dx_Sidt))', 'Time derivative of memory variable');
model.variable.create('var2');
model.variable('var2').model('comp1');
model.variable('var2').label('Variables - Global');
model.variable('var2').set('i_app', 'i_1C*C_rate*CurrentDirection');
model.variable('var2').descr('i_app', 'Applied current density');
model.variable('var2').set('E_vs_ref', 'intop_cc(phis)-intop_ref(phil)');
model.variable('var2').descr('E_vs_ref', 'Electrode potential vs reference');
model.variable('var2').set('SOC', 'Cap/Q_el');
model.variable('var2').descr('SOC', 'Electrode SOC');

model.physics('liion').feature('sep1').set('epsl', 'epsl_sep');
model.physics('liion').create('pce1', 'PorousElectrode', 1);
model.physics('liion').feature('pce1').label('Porous Electrode 1 - Graphite');
model.physics('liion').feature('pce1').selection.set([1]);
model.physics('liion').feature('pce1').set('ElectrolyteMaterial', 'mat2');
model.physics('liion').feature('pce1').set('sigma', {'sigma_s' '0' '0' '0' 'sigma_s' '0' '0' '0' 'sigma_s'});
model.physics('liion').feature('pce1').set('epss', 'epss_Gr');
model.physics('liion').feature('pce1').set('epsl', 'epsl_el');
model.physics('liion').feature('pce1').feature('pin1').set('csinit', 'cs_Gr_init');
model.physics('liion').feature('pce1').feature('pin1').set('ParticleMaterial', 'mat1');
model.physics('liion').feature('pce1').feature('pin1').set('rp', 'rp_Gr');
model.physics('liion').feature('pce1').feature('pin1').set('socmin_mat', 'userdef');
model.physics('liion').feature('pce1').feature('pin1').set('socmax_mat', 'userdef');
model.physics('liion').feature('pce1').feature('per1').set('MaterialOption', 'mat1');
model.physics('liion').feature('pce1').feature('per1').set('i0_ref', 'i0_ref_Gr');
model.physics('liion').create('addm1', 'IntercalatingMaterial', 1);
model.physics('liion').feature('addm1').label('Additional Porous Electrode Material 1 - Silicon');
model.physics('liion').feature('addm1').selection.set([1]);
model.physics('liion').feature('addm1').set('epssadd', 'epss_Si');
model.physics('liion').feature('addm1').feature('pin1').set('csinit', 'cs_Si_init');
model.physics('liion').feature('addm1').feature('pin1').set('cEeqref_mat', 'userdef');
model.physics('liion').feature('addm1').feature('pin1').set('cEeqref', 'cs_Si_max');
model.physics('liion').feature('addm1').feature('pin1').set('ParticleConcentrationType', 'NoSpatialGradients');
model.physics('liion').feature('addm1').feature('pin1').set('rp', 'rp_Si');
model.physics('liion').feature('addm1').feature('pin1').set('socmin_mat', 'userdef');
model.physics('liion').feature('addm1').feature('pin1').set('socmax_mat', 'userdef');
model.physics('liion').feature('addm1').feature('per1').set('Eeq_mat', 'userdef');
model.physics('liion').feature('addm1').feature('per1').set('Eeq', 'Eeq_Si');
model.physics('liion').feature('addm1').feature('per1').set('i0_ref', 'i0_ref_Si');
model.physics('liion').create('es1', 'ElectrodeSurface', 0);
model.physics('liion').feature('es1').label('Electrode Surface 1 - Lithium Metal');
model.physics('liion').feature('es1').selection.set([3]);
model.physics('liion').create('ecd1', 'ElectrodeNormalCurrentDensity', 0);
model.physics('liion').feature('ecd1').selection.set([1]);
model.physics('liion').feature('ecd1').set('nis', 'i_app');
model.physics('liion').feature('init1').set('phis', 'E_init_el');
model.physics.create('c', 'CoefficientFormPDE', 'geom1', {'u'});

model.study('std1').feature('time').setSolveFor('/physics/c', true);

model.physics('c').prop('EquationForm').set('form', 'Automatic');
model.physics('c').label('Coefficient Form PDE - Memory Variable');
model.physics('c').selection.set([1]);
model.physics('c').field('dimensionless').field('S');
model.physics('c').field('dimensionless').component(1, 'S');
model.physics('c').feature('cfeq1').setIndex('c', 0, 0);
model.physics('c').feature('cfeq1').setIndex('f', 'dSdt', 0);
model.physics('c').feature('init1').set('S', 'S_init');
model.physics.create('ev', 'Events', 'geom1');
model.physics('ev').model('comp1');

model.study('std1').feature('time').setSolveFor('/physics/ev', true);

model.physics('ev').label('Events - Charge-Discharge Control');
model.physics('ev').create('ds1', 'DiscreteStates', -1);
model.physics('ev').feature('ds1').setIndex('dim', 'CurrentDirection', 0, 0);
model.physics('ev').feature('ds1').setIndex('dimInit', 0, 0, 0);
model.physics('ev').feature('ds1').setIndex('dimInit', -1, 0, 0);
model.physics('ev').feature('ds1').setIndex('dimDescr', 'Direction of current', 0, 0);
model.physics('ev').create('is1', 'IndicatorStates', -1);
model.physics('ev').feature('is1').setIndex('indDim', 'switch', 0, 0);
model.physics('ev').feature('is1').setIndex('g', 0, 0, 0);
model.physics('ev').feature('is1').setIndex('dimInit', 0, 0, 0);
model.physics('ev').feature('is1').setIndex('g', '-(E_vs_ref-E_switch)', 0, 0);
model.physics('ev').feature('is1').setIndex('indDim', 'end', 1, 0);
model.physics('ev').feature('is1').setIndex('g', 0, 1, 0);
model.physics('ev').feature('is1').setIndex('dimInit', 0, 1, 0);
model.physics('ev').feature('is1').setIndex('dimDescr', '', 1, 0);
model.physics('ev').feature('is1').setIndex('g', 'E_vs_ref-E_end', 1, 0);
model.physics('ev').create('impl1', 'ImplicitEvent', -1);
model.physics('ev').feature('impl1').set('condition', 'switch>0');
model.physics('ev').feature('impl1').setIndex('reInitName', 'CurrentDirection', 0, 0);
model.physics('ev').feature('impl1').setIndex('reInitValue', 0, 0, 0);
model.physics('ev').feature('impl1').setIndex('reInitValue', 1, 0, 0);
model.physics('ev').create('impl2', 'ImplicitEvent', -1);
model.physics('ev').feature('impl2').set('condition', 'end>0');
model.physics.create('ge', 'GlobalEquations', 'geom1');
model.physics('ge').model('comp1');

model.study('std1').feature('time').setSolveFor('/physics/ge', true);

model.physics('ge').prop('EquationForm').set('form', 'Automatic');
model.physics('ge').label('Global ODEs and DAEs - Charge Integration');
model.physics('ge').feature('ge1').setIndex('name', 'Cap', 0, 0);
model.physics('ge').feature('ge1').setIndex('equation', 'd(Cap,t)+i_app', 0, 0);
model.physics('ge').feature('ge1').setIndex('description', 'Cumulative charge', 0, 0);
model.physics('ge').feature('ge1').set('CustomDependentVariableUnit', '1');
model.physics('ge').feature('ge1').set('DependentVariableQuantity', 'none');
model.physics('ge').feature('ge1').setIndex('CustomDependentVariableUnit', 'C/m^2', 0, 0);
model.physics('ge').feature('ge1').set('CustomSourceTermUnit', '1');
model.physics('ge').feature('ge1').set('SourceTermQuantity', 'none');
model.physics('ge').feature('ge1').setIndex('CustomSourceTermUnit', 'A/m^2', 0, 0);
model.physics.create('ge2', 'GlobalEquations', 'geom1');
model.physics('ge2').model('comp1');

model.study('std1').feature('time').setSolveFor('/physics/ge2', true);

model.physics('ge2').prop('EquationForm').set('form', 'Automatic');
model.physics('ge2').label('Global ODEs and DAEs - Energy Integration');
model.physics('ge2').feature('ge1').setIndex('name', 'E_lith', 0, 0);
model.physics('ge2').feature('ge1').setIndex('equation', 'd(E_lith,t)-if(CurrentDirection==-1, i_app*(E_vs_ref-E_max_el),0)', 0, 0);
model.physics('ge2').feature('ge1').setIndex('description', 'Cumulative lithiation energy', 0, 0);
model.physics('ge2').feature('ge1').setIndex('name', 'E_delith', 1, 0);
model.physics('ge2').feature('ge1').setIndex('equation', '', 1, 0);
model.physics('ge2').feature('ge1').setIndex('initialValueU', 0, 1, 0);
model.physics('ge2').feature('ge1').setIndex('initialValueUt', 0, 1, 0);
model.physics('ge2').feature('ge1').setIndex('description', '', 1, 0);
model.physics('ge2').feature('ge1').setIndex('equation', 'd(E_delith,t)-if(CurrentDirection==1, -i_app*(E_vs_ref-E_max_el),0)', 1, 0);
model.physics('ge2').feature('ge1').setIndex('description', 'Cumulative delithiation energy', 1, 0);
model.physics('ge2').feature('ge1').set('CustomDependentVariableUnit', '1');
model.physics('ge2').feature('ge1').set('DependentVariableQuantity', 'none');
model.physics('ge2').feature('ge1').setIndex('CustomDependentVariableUnit', 'J/m^2', 0, 0);
model.physics('ge2').feature('ge1').set('CustomSourceTermUnit', '1');
model.physics('ge2').feature('ge1').set('SourceTermQuantity', 'none');
model.physics('ge2').feature('ge1').setIndex('CustomSourceTermUnit', 'W/m^2', 0, 0);

model.study('std1').create('param', 'Parametric');
model.study('std1').feature('param').setIndex('pname', 'L_sep', 0);
model.study('std1').feature('param').setIndex('plistarr', '', 0);
model.study('std1').feature('param').setIndex('punit', 'm', 0);
model.study('std1').feature('param').setIndex('pname', 'L_sep', 0);
model.study('std1').feature('param').setIndex('plistarr', '', 0);
model.study('std1').feature('param').setIndex('punit', 'm', 0);
model.study('std1').feature('param').setIndex('pname', 'C_rate', 0);
model.study('std1').feature('param').setIndex('plistarr', '0.1 1', 0);
model.study('std1').feature('param').setIndex('pname', 'L_sep', 1);
model.study('std1').feature('param').setIndex('plistarr', '', 1);
model.study('std1').feature('param').setIndex('punit', 'm', 1);
model.study('std1').feature('param').setIndex('pname', 'L_sep', 1);
model.study('std1').feature('param').setIndex('plistarr', '', 1);
model.study('std1').feature('param').setIndex('punit', 'm', 1);
model.study('std1').feature('param').setIndex('pname', 'Si_f', 1);
model.study('std1').feature('param').setIndex('plistarr', '0.1 1 4', 1);
model.study('std1').feature('param').setIndex('punit', '%', 1);
model.study('std1').feature('param').set('sweeptype', 'filled');
model.study('std1').feature('time').set('tunit', 'h');
model.study('std1').feature('time').set('tlist', 'range(0,0.01/C_rate,2.1/C_rate)');

model.sol.create('sol1');
model.sol('sol1').study('std1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'time');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').feature('comp1_phil').set('scalemethod', 'manual');
model.sol('sol1').feature('v1').feature('comp1_liion_pce1_cs').set('scalemethod', 'manual');
model.sol('sol1').feature('v1').feature('comp1_phis').set('scalemethod', 'manual');
model.sol('sol1').feature('v1').feature('comp1_liion_addm1_cs').set('scalemethod', 'manual');
model.sol('sol1').feature('v1').feature('comp1_cl').set('scalemethod', 'manual');
model.sol('sol1').feature('v1').feature('comp1_phil').set('scaleval', '1');
model.sol('sol1').feature('v1').feature('comp1_liion_pce1_cs').set('scaleval', '10000');
model.sol('sol1').feature('v1').feature('comp1_phis').set('scaleval', '1');
model.sol('sol1').feature('v1').feature('comp1_liion_addm1_cs').set('scaleval', '10000');
model.sol('sol1').feature('v1').feature('comp1_cl').set('scaleval', '1000');
model.sol('sol1').feature('v1').set('control', 'time');
model.sol('sol1').create('t1', 'Time');
model.sol('sol1').feature('t1').set('tlist', 'range(0,0.01/C_rate,2.1/C_rate)');
model.sol('sol1').feature('t1').set('plot', 'off');
model.sol('sol1').feature('t1').set('plotgroup', 'Default');
model.sol('sol1').feature('t1').set('plotfreq', 'tout');
model.sol('sol1').feature('t1').set('probesel', 'all');
model.sol('sol1').feature('t1').set('probes', {});
model.sol('sol1').feature('t1').set('probefreq', 'tsteps');
model.sol('sol1').feature('t1').set('rtol', 0.001);
model.sol('sol1').feature('t1').set('atolglobalvaluemethod', 'factor');
model.sol('sol1').feature('t1').set('eventout', true);
model.sol('sol1').feature('t1').set('reacf', true);
model.sol('sol1').feature('t1').set('storeudot', true);
model.sol('sol1').feature('t1').set('endtimeinterpolation', true);
model.sol('sol1').feature('t1').set('maxorder', 2);
model.sol('sol1').feature('t1').set('initialstepbdfactive', true);
model.sol('sol1').feature('t1').set('initialstepbdf', '(1)[s]');
model.sol('sol1').feature('t1').set('control', 'time');
model.sol('sol1').feature('t1').feature('aDef').set('cachepattern', true);
model.sol('sol1').feature('t1').create('seDef', 'Segregated');
model.sol('sol1').feature('t1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('t1').feature('fc1').set('dtech', 'auto');
model.sol('sol1').feature('t1').create('d1', 'Direct');
model.sol('sol1').feature('t1').feature('d1').label('Direct (Merged)');
model.sol('sol1').feature('t1').create('i1', 'Iterative');
model.sol('sol1').feature('t1').feature('i1').set('maxlinit', 1000);
model.sol('sol1').feature('t1').feature('i1').set('nlinnormuse', 'on');
model.sol('sol1').feature('t1').feature('i1').label('Algebraic Multigrid (liion)');
model.sol('sol1').feature('t1').feature('i1').create('mg1', 'Multigrid');
model.sol('sol1').feature('t1').feature('i1').feature('mg1').set('prefun', 'saamg');
model.sol('sol1').feature('t1').feature('i1').feature('mg1').set('maxcoarsedof', 50000);
model.sol('sol1').feature('t1').feature('i1').feature('mg1').set('saamgcompwise', true);
model.sol('sol1').feature('t1').feature('i1').feature('mg1').set('compactaggregation', true);
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('pr').create('sl1', 'SORLine');
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('po').create('sl1', 'SORLine');
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('cs').create('d1', 'Direct');
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('cs').feature('d1').set('linsolver', 'pardiso');
model.sol('sol1').feature('t1').create('i2', 'Iterative');
model.sol('sol1').feature('t1').feature('i2').set('maxlinit', 1000);
model.sol('sol1').feature('t1').feature('i2').set('nlinnormuse', 'on');
model.sol('sol1').feature('t1').feature('i2').label('Geometric Multigrid (liion)');
model.sol('sol1').feature('t1').feature('i2').create('mg1', 'Multigrid');
model.sol('sol1').feature('t1').feature('i2').feature('mg1').feature('pr').create('sl1', 'SORLine');
model.sol('sol1').feature('t1').feature('i2').feature('mg1').feature('po').create('sl1', 'SORLine');
model.sol('sol1').feature('t1').feature('i2').feature('mg1').feature('cs').create('d1', 'Direct');
model.sol('sol1').feature('t1').feature('i2').feature('mg1').feature('cs').feature('d1').set('linsolver', 'pardiso');
model.sol('sol1').feature('t1').feature('fc1').set('linsolver', 'd1');
model.sol('sol1').feature('t1').feature('fc1').set('dtech', 'auto');
model.sol('sol1').feature('t1').feature.remove('fcDef');
model.sol('sol1').feature('t1').feature.remove('seDef');
model.sol('sol1').attach('std1');

model.batch.create('p1', 'Parametric');
model.batch('p1').study('std1');
model.batch('p1').create('so1', 'Solutionseq');
model.batch('p1').feature('so1').set('seq', 'sol1');
model.batch('p1').feature('so1').set('store', 'on');
model.batch('p1').feature('so1').set('clear', 'on');
model.batch('p1').feature('so1').set('psol', 'none');
model.batch('p1').set('pname', {'C_rate' 'Si_f'});
model.batch('p1').set('plistarr', {'0.1 1' '0.1 1 4'});
model.batch('p1').set('sweeptype', 'filled');
model.batch('p1').set('probesel', 'all');
model.batch('p1').set('probes', {});
model.batch('p1').set('plot', 'off');
model.batch('p1').set('err', 'on');
model.batch('p1').attach('std1');
model.batch('p1').set('control', 'param');

model.sol('sol1').feature('t1').create('st1', 'StopCondition');
model.sol('sol1').feature('t1').feature('st1').set('eventstopName', {'comp1.ev.impl1.event' 'comp1.ev.impl2.event'});
model.sol('sol1').feature('t1').feature('st1').set('eventstopActive', {'off' 'off'});
model.sol('sol1').feature('t1').feature('st1').setIndex('eventstopActive', true, 1);
model.sol('sol1').feature('t1').feature('st1').set('storestopcondsol', 'stepbefore');
model.sol('sol1').feature('t1').feature('st1').set('stopcondwarn', false);
model.sol.create('sol2');
model.sol('sol2').study('std1');
model.sol('sol2').label('Parametric Solutions 1');

model.batch('p1').feature('so1').set('psol', 'sol2');
model.batch('p1').run('compute');

model.result.create('pg1', 'PlotGroup1D');
model.result('pg1').set('data', 'dset2');
model.result('pg1').create('ptgr1', 'PointGraph');
model.result('pg1').feature('ptgr1').selection.all;
model.result('pg1').feature('ptgr1').set('expr', {'phis'});
model.result('pg1').feature('ptgr1').selection.set([1]);
model.result('pg1').label('Boundary Electrode Potential with Respect to Ground (liion)');
model.result('pg1').feature('ptgr1').set('xdatasolnumtype', 'level1');
model.result.create('pg2', 'PlotGroup1D');
model.result('pg2').set('data', 'dset2');
model.result('pg2').create('glob1', 'Global');
model.result('pg2').feature('glob1').set('unit', {''});
model.result('pg2').feature('glob1').set('expr', {'liion.soc_average_pce1'});
model.result('pg2').feature('glob1').set('descr', {'Average SOC, Porous Electrode 1 - Graphite'});
model.result('pg2').label('Average Electrode State of Charge (liion)');
model.result('pg2').feature('glob1').set('xdatasolnumtype', 'level1');
model.result.create('pg3', 'PlotGroup1D');
model.result('pg3').set('data', 'dset2');
model.result('pg3').label('Electrolyte Potential (liion)');
model.result('pg3').create('lngr1', 'LineGraph');
model.result('pg3').feature('lngr1').set('xdata', 'expr');
model.result('pg3').feature('lngr1').set('xdataexpr', 'x');
model.result('pg3').feature('lngr1').selection.geom('geom1', 1);
model.result('pg3').feature('lngr1').selection.set([1 2]);
model.result('pg3').feature('lngr1').set('expr', {'phil'});
model.result.create('pg4', 'PlotGroup1D');
model.result('pg4').set('data', 'dset2');
model.result('pg4').label('Electrode Potential with Respect to Ground (liion)');
model.result('pg4').create('lngr1', 'LineGraph');
model.result('pg4').feature('lngr1').set('xdata', 'expr');
model.result('pg4').feature('lngr1').set('xdataexpr', 'x');
model.result('pg4').feature('lngr1').selection.geom('geom1', 1);
model.result('pg4').feature('lngr1').selection.set([1 2]);
model.result('pg4').feature('lngr1').set('expr', {'phis'});
model.result.create('pg5', 'PlotGroup1D');
model.result('pg5').set('data', 'dset2');
model.result('pg5').create('lngr1', 'LineGraph');
model.result('pg5').feature('lngr1').set('xdata', 'expr');
model.result('pg5').feature('lngr1').set('xdataexpr', 'x');
model.result('pg5').feature('lngr1').selection.geom('geom1', 1);
model.result('pg5').feature('lngr1').selection.set([1 2]);
model.result('pg5').feature('lngr1').set('expr', {'cl'});
model.result('pg5').label('Electrolyte Salt Concentration (liion)');
model.result.create('pg6', 'PlotGroup1D');
model.result('pg6').set('data', 'dset2');
model.result('pg6').create('lngr1', 'LineGraph');
model.result('pg6').feature('lngr1').set('xdata', 'expr');
model.result('pg6').feature('lngr1').set('xdataexpr', 'x');
model.result('pg6').feature('lngr1').selection.geom('geom1', 1);
model.result('pg6').feature('lngr1').selection.set([1]);
model.result('pg6').feature('lngr1').set('expr', 'S');
model.result('pg6').label('Coefficient Form PDE - Memory Variable');
model.result.numerical.create('gev1', 'EvalGlobal');
model.result.numerical('gev1').set('data', 'dset2');
model.result.numerical('gev1').set('expr', {'Cap'});
model.result.numerical('gev1').set('descr', {'Cumulative charge'});
model.result.create('pg7', 'PlotGroup1D');
model.result('pg7').set('data', 'dset2');
model.result('pg7').create('glob1', 'Global');
model.result('pg7').feature('glob1').set('expr', {'Cap'});
model.result('pg7').feature('glob1').set('descr', {'Cumulative charge'});
model.result.numerical.create('gev2', 'EvalGlobal');
model.result.numerical('gev2').set('data', 'dset2');
model.result.numerical('gev2').set('expr', {'E_lith' 'E_delith'});
model.result.numerical('gev2').set('descr', {'Cumulative lithiation energy' 'Cumulative delithiation energy'});
model.result.create('pg8', 'PlotGroup1D');
model.result('pg8').set('data', 'dset2');
model.result('pg8').create('glob1', 'Global');
model.result('pg8').feature('glob1').set('expr', {'E_lith' 'E_delith'});
model.result('pg8').feature('glob1').set('descr', {'Cumulative lithiation energy' 'Cumulative delithiation energy'});
model.result('pg1').run;
model.result('pg1').label('0.1 C Electrode Voltage vs SOC');
model.result('pg1').setIndex('looplevelinput', 'manual', 2);
model.result('pg1').setIndex('looplevel', [1], 2);
model.result('pg1').set('titletype', 'none');
model.result('pg1').set('ylabelactive', true);
model.result('pg1').set('ylabel', 'Potential vs Reference (V)');
model.result('pg1').run;
model.result('pg1').feature('ptgr1').set('expr', 'E_vs_ref');
model.result('pg1').feature('ptgr1').set('descr', 'Electrode potential vs reference');
model.result('pg1').feature('ptgr1').set('xdatasolnumtype', 'inner');
model.result('pg1').feature('ptgr1').set('xdata', 'expr');
model.result('pg1').feature('ptgr1').set('xdataexpr', 'SOC');
model.result('pg1').feature('ptgr1').set('xdatadescr', 'Electrode SOC');
model.result('pg1').feature('ptgr1').set('legend', true);
model.result('pg1').feature('ptgr1').set('autopoint', false);
model.result('pg1').feature('ptgr1').set('autosolution', false);
model.result('pg1').feature('ptgr1').set('legendprefix', 'eval(Si_f*100) % Si in Gr');
model.result('pg1').run;
model.result('pg1').run;
model.result.duplicate('pg9', 'pg1');
model.result('pg9').run;
model.result('pg9').label('1 C Electrode Voltage vs SOC');
model.result('pg9').setIndex('looplevel', [2], 2);
model.result('pg9').run;
model.result('pg2').run;
model.result('pg2').label('0.1 C Average Material Lithiation Levels');
model.result('pg2').setIndex('looplevelinput', 'manual', 2);
model.result('pg2').setIndex('looplevel', [1], 2);
model.result('pg2').setIndex('looplevelinput', 'manual', 1);
model.result('pg2').setIndex('looplevel', [3], 1);
model.result('pg2').set('titletype', 'none');
model.result('pg2').set('ylabelactive', true);
model.result('pg2').set('ylabel', 'Degree of lithiation (1)');
model.result('pg2').set('legendpos', 'upperleft');
model.result('pg2').run;
model.result('pg2').feature('glob1').set('expr', {'liion.soc_average_pce1' 'liion.soc_average_addm1'});
model.result('pg2').feature('glob1').set('descr', {'Average SOC, Porous Electrode 1 - Graphite' 'Average SOC, Additional Porous Electrode Material 1 - Silicon'});
model.result('pg2').feature('glob1').set('legendmethod', 'manual');
model.result('pg2').feature('glob1').setIndex('legends', 'Gr', 0);
model.result('pg2').feature('glob1').setIndex('legends', 'Si', 1);
model.result('pg2').run;
model.result('pg2').run;
model.result.duplicate('pg10', 'pg2');
model.result('pg10').run;
model.result('pg10').label('1 C Average Material Lithiation Levels');
model.result('pg10').setIndex('looplevel', [2], 2);
model.result('pg10').run;
model.result.create('pg11', 'PlotGroup1D');
model.result('pg11').run;
model.result('pg11').label('Hysteresis Memory Variable');
model.result('pg11').set('data', 'dset2');
model.result('pg11').setIndex('looplevelinput', 'manual', 2);
model.result('pg11').setIndex('looplevel', [2], 2);
model.result('pg11').setIndex('looplevelinput', 'manual', 1);
model.result('pg11').setIndex('looplevel', [3], 1);
model.result('pg11').set('titletype', 'none');
model.result('pg11').set('legendpos', 'uppermiddle');
model.result('pg11').create('ptgr1', 'PointGraph');
model.result('pg11').feature('ptgr1').set('markerpos', 'datapoints');
model.result('pg11').feature('ptgr1').set('linewidth', 'preference');
model.result('pg11').feature('ptgr1').selection.set([1 2]);
model.result('pg11').feature('ptgr1').set('expr', 'S');
model.result('pg11').feature('ptgr1').set('legend', true);
model.result('pg11').feature('ptgr1').set('legendmethod', 'manual');
model.result('pg11').feature('ptgr1').setIndex('legends', 'Current Collector-Electrode', 0);
model.result('pg11').feature('ptgr1').setIndex('legends', 'Separator-Electrode', 1);
model.result('pg11').run;
model.result.create('pg12', 'PlotGroup1D');
model.result('pg12').run;
model.result('pg12').label('Delithiation Energy Densities');
model.result('pg12').set('data', 'none');
model.result('pg12').set('titletype', 'none');
model.result('pg12').set('xlabelactive', true);
model.result('pg12').set('xlabel', 'Si Volume Fraction in Electrode Blend (%)');
model.result('pg12').set('ylabelactive', true);
model.result('pg12').set('ylabel', 'E<sub>delith</sub> (J/m<sup>3</sup>)');
model.result('pg12').set('legendpos', 'upperleft');
model.result('pg12').create('glob1', 'Global');
model.result('pg12').feature('glob1').set('markerpos', 'datapoints');
model.result('pg12').feature('glob1').set('linewidth', 'preference');
model.result('pg12').feature('glob1').set('data', 'dset2');
model.result('pg12').feature('glob1').setIndex('looplevelinput', 'manual', 2);
model.result('pg12').feature('glob1').setIndex('looplevel', [1], 2);
model.result('pg12').feature('glob1').setIndex('looplevelinput', 'last', 0);
model.result('pg12').feature('glob1').set('expr', {});
model.result('pg12').feature('glob1').set('descr', {});
model.result('pg12').feature('glob1').setIndex('expr', 'E_delith/L_el', 0);
model.result('pg12').feature('glob1').set('legendmethod', 'manual');
model.result('pg12').feature('glob1').setIndex('legends', '0.1C', 0);
model.result('pg12').feature('glob1').set('xdatasolnumtype', 'outer');
model.result('pg12').feature('glob1').set('xdata', 'expr');
model.result('pg12').feature('glob1').set('xdataexpr', 'Si_f');
model.result('pg12').feature('glob1').set('xdatadescr', 'Fraction of Si in electrode blend');
model.result('pg12').feature('glob1').set('xdataunit', '%');
model.result('pg12').feature.duplicate('glob2', 'glob1');
model.result('pg12').run;
model.result('pg12').feature('glob2').setIndex('looplevel', [2], 2);
model.result('pg12').feature('glob2').setIndex('legends', '1C', 0);
model.result('pg12').run;
model.result('pg12').run;
model.result.duplicate('pg13', 'pg12');
model.result('pg13').run;
model.result('pg13').label('Lithiation/Delithiation Energy Efficiencies');
model.result('pg13').set('ylabel', 'E<sub>delith</sub>/E<sub>lith</sub> (1)');
model.result('pg13').set('legendpos', 'upperright');
model.result('pg13').run;
model.result('pg13').feature('glob1').setIndex('expr', 'E_delith/E_lith', 0);
model.result('pg13').run;
model.result('pg13').feature('glob2').setIndex('expr', 'E_delith/E_lith', 0);
model.result('pg13').run;

model.func('int1').createPlot('pg14');

model.result('pg14').run;
model.result('pg14').label('Equilibrium Potentials vs Lithiation');
model.result('pg14').set('data', 'none');
model.result('pg14').set('titletype', 'none');
model.result('pg14').set('xlabelactive', true);
model.result('pg14').set('xlabel', 'Degree of lithiation (1)');
model.result('pg14').set('ylabel', 'Potential vs Li/Li<sup>+</sup> (V)');
model.result('pg14').set('axislimits', true);
model.result('pg14').set('xmin', 0);
model.result('pg14').set('xmax', 0.9);
model.result('pg14').set('ymin', 0);
model.result('pg14').set('ymax', 1);
model.result('pg14').run;
model.result('pg14').feature('plot1').set('data', 'int1_ds1');
model.result('pg14').feature('plot1').set('descractive', false);
model.result('pg14').feature('plot1').set('display', 'line');
model.result('pg14').feature('plot1').set('extrapolation', 'none');
model.result('pg14').feature('plot1').set('legend', true);
model.result('pg14').feature('plot1').set('legendmethod', 'manual');
model.result('pg14').feature('plot1').setIndex('legends', 'E<sub>eq, Si, upper</sup>', 0);

model.func('int2').createPlot('pg15');

model.result('pg15').run;
model.result('pg15').run;
model.result('pg14').feature.copy('plot2', 'pg15/plot1');
model.result('pg15').feature.remove('plot1');
model.result('pg14').feature('plot2').set('data', 'int2_ds1');
model.result('pg14').feature('plot2').set('descractive', false);
model.result('pg14').feature('plot2').set('display', 'line');
model.result('pg14').feature('plot2').set('extrapolation', 'none');
model.result('pg14').feature('plot2').set('legend', true);
model.result('pg14').feature('plot2').set('legendmethod', 'manual');
model.result('pg14').feature('plot2').setIndex('legends', 'E<sub>eq, Si, lower</sup>', 0);

model.geom('geom1').run;

model.material('mat1').propertyGroup('ElectrodePotential').func('int1').createPlot('pg16');

model.result('pg16').run;
model.result('pg16').run;
model.result('pg14').feature.copy('plot3', 'pg16/plot1');
model.result('pg16').feature.remove('plot1');
model.result('pg14').feature('plot3').set('data', 'int1_ds2');
model.result('pg14').feature('plot3').set('descractive', false);
model.result('pg14').feature('plot3').set('legend', true);
model.result('pg14').feature('plot3').set('legendmethod', 'manual');
model.result('pg14').feature('plot3').setIndex('legends', 'E<sub>eq, Gr</sup>', 0);
model.result('pg14').run;
model.result('pg3').run;
model.result.remove('pg3');
model.result.remove('pg4');
model.result.remove('pg5');
model.result.remove('pg6');
model.result.remove('pg7');
model.result.remove('pg8');
model.result.remove('pg15');
model.result.remove('pg16');
model.result('pg9').run;
model.result.move('pg9', 1);

model.title(['Silicon' native2unicode(hex2dec({'20' '13'}), 'unicode') 'Graphite-Blended Electrode with Thermodynamic Voltage Hysteresis']);

model.description('This example demonstrates how to add Si as an Additional Electrode Material in the Lithium-Ion Battery interface and how to define a memory variable for handling voltage hysteresis using an additional Coefficient Form PDE interface.');

model.mesh.clearMeshes;

model.sol('sol1').clearSolutionData;
model.sol('sol2').clearSolutionData;
model.sol('sol3').clearSolutionData;
model.sol('sol4').clearSolutionData;
model.sol('sol5').clearSolutionData;
model.sol('sol6').clearSolutionData;
model.sol('sol7').clearSolutionData;
model.sol('sol8').clearSolutionData;

model.label('li_battery_sigr_hysteresis.mph');

model.modelNode.label('Components');

out = model;
