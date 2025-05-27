function out = model
%
% lib_rate_capability_surrogate.m
%
% Model exported on May 26 2025, 21:25 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/Battery_Design_Module/Applications');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 1);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.physics.create('liion', 'LithiumIonBatteryMPH', 'geom1');
model.physics('liion').model('comp1');

model.study.create('std1');
model.study('std1').create('cdi', 'CurrentDistributionInitialization');
model.study('std1').feature('cdi').set('solnum', 'auto');
model.study('std1').feature('cdi').set('notsolnum', 'auto');
model.study('std1').feature('cdi').set('outputmap', {});
model.study('std1').feature('cdi').set('ngenAUX', '1');
model.study('std1').feature('cdi').set('goalngenAUX', '1');
model.study('std1').feature('cdi').set('ngenAUX', '1');
model.study('std1').feature('cdi').set('goalngenAUX', '1');
model.study('std1').feature('cdi').setSolveFor('/physics/liion', true);
model.study('std1').create('time', 'Transient');
model.study('std1').feature('time').set('initialtime', '0');
model.study('std1').feature('time').set('solnum', 'auto');
model.study('std1').feature('time').set('notsolnum', 'auto');
model.study('std1').feature('time').set('outputmap', {});
model.study('std1').feature('time').setSolveFor('/physics/liion', true);

model.param.label('Parameters for Li-ion battery model');

% To import content from file, use:
% model.param.loadFile('FILENAME');
model.param.set('epss_neg', '0.6', 'Active electrode volume fraction, negative');
model.param.set('epss_pos', '0.6', 'Active electrode volume fraction, positive');
model.param.set('epss_binder_neg', '0.1', 'Binder volume fraction, negative');
model.param.set('epss_binder_pos', '0.1', 'Binder volume fraction, positive');
model.param.set('epsl_neg', '1-epss_neg-epss_binder_neg', 'Electrolyte volume fraction, negative');
model.param.set('epsl_sep', '0.4', 'Separator volume fraction');
model.param.set('epsl_pos', '1-epss_pos-epss_binder_pos', 'Electrolyte volume fraction, positive');
model.param.set('sigmas_neg', '1[S/m]', 'Effective electrode conductivity, negative');
model.param.set('sigmas_pos', '1[S/m]', 'Effective electrode conductivity, positive');
model.param.set('rp_neg', '6[um]', 'Electrode particle radius, negative');
model.param.set('rp_pos', '5[um]', 'Electrode particle radius, positive');
model.param.set('cs_max_neg', '31507[mol/m^3]', 'Maximum concentration, negative');
model.param.set('cs_max_pos', '49000[mol/m^3]', 'Maximum concentration, positive');
model.param.set('i0_ref_neg', '10[A/m^2]', 'Exchange current density at 50% lithiation, negative');
model.param.set('i0_ref_pos', '10[A/m^2]', 'Exchange current density at 50% lithiation, positive');
model.param.set('L_sep', '20[um]', 'Separator thickness');
model.param.set('L_pos', '45[um]', 'Positive electrode thickness');
model.param.set('L_neg', '(1-0.1)*epss_pos*cs_max_pos*L_pos/(0.8*epss_neg*cs_max_neg)', 'Negative electrode thickness');
model.param.set('L_ccs', '10[um]', 'Thickness of current collectors');
model.param.set('V_cell', '90[%]*(10.5[mm])^2*pi*70[mm]', 'Active cell volume');
model.param.set('A_cell', 'V_cell/(L_neg+L_sep+L_pos+L_ccs/2)', 'Cell area');
model.param.set('soc_init', '0', 'Initial SOC');
model.param.set('T', '25[degC]', 'Temperature');

model.material.create('mat1', 'Common', 'comp1');
model.material('mat1').propertyGroup('def').func.create('int1', 'Interpolation');
model.material('mat1').propertyGroup.create('ElectrolyteConductivity', 'Electrolyte conductivity');
model.material('mat1').propertyGroup('ElectrolyteConductivity').func.create('int1', 'Interpolation');
model.material('mat1').propertyGroup.create('SpeciesProperties', 'Species properties');
model.material('mat1').propertyGroup('SpeciesProperties').func.create('int1', 'Interpolation');
model.material('mat1').propertyGroup('SpeciesProperties').func.create('int2', 'Interpolation');
model.material('mat1').propertyGroup.create('ElectrolyteSaltConcentration', 'Electrolyte salt concentration');
model.material('mat1').label('LiPF6 in 3:7 EC:EMC (Liquid, Li-ion Battery)');
model.material('mat1').propertyGroup('def').func('int1').set('funcname', 'DL_int1');
model.material('mat1').propertyGroup('def').func('int1').set('table', {'200' '3.9e-10/(1-200*59e-6)';  ...
'500' '4.12e-10/(1-500*59e-6)';  ...
'800' '4e-10/(1-800*59e-6)';  ...
'1000' '3.8e-10/(1-1000*59e-6)';  ...
'1200' '3.50e-10/(1-1200*59e-6)';  ...
'1600' '2.68e-10/(1-1600*59e-6)';  ...
'2000' '1.9e-10/(1-2000*59e-6)'});
model.material('mat1').propertyGroup('def').func('int1').set('interp', 'piecewisecubic');
model.material('mat1').propertyGroup('def').func('int1').set('fununit', {'m^2/s'});
model.material('mat1').propertyGroup('def').func('int1').set('argunit', {''});
model.material('mat1').propertyGroup('def').set('diffusion', {'DL_int1(c/1[mol/m^3])*exp(16500/8.314*(1/(T_ref/1[K])-1/(T2/1[K])))' '0' '0' '0' 'DL_int1(c/1[mol/m^3])*exp(16500/8.314*(1/(T_ref/1[K])-1/(T2/1[K])))' '0' '0' '0' 'DL_int1(c/1[mol/m^3])*exp(16500/8.314*(1/(T_ref/1[K])-1/(T2/1[K])))'});
model.material('mat1').propertyGroup('def').set('INFO_PREFIX:diffusion', 'T. G. Zavalis, M. Behm, and G. Lindbergh, "Investigations of Short-Circuit Scenarios in a Lithium-Ion Battery Cell," J. Electrochem. Soc., vol. 159, p. A848, 2012.');
model.material('mat1').propertyGroup('def').set('T_ref', '298[K]');
model.material('mat1').propertyGroup('def').descr('T_ref', '');
model.material('mat1').propertyGroup('def').set('T2', 'min(393.15,max(T,223.15))');
model.material('mat1').propertyGroup('def').descr('T2', '');
model.material('mat1').propertyGroup('def').addInput('concentration');
model.material('mat1').propertyGroup('def').addInput('temperature');
model.material('mat1').propertyGroup('ElectrolyteConductivity').func('int1').set('funcname', 'sigmal_int1');
model.material('mat1').propertyGroup('ElectrolyteConductivity').func('int1').set('table', {'0' '1e-6';  ...
'200' '0.455';  ...
'500' '0.783';  ...
'800' '0.935';  ...
'1000' '0.95';  ...
'1200' '0.927';  ...
'1600' '0.78';  ...
'2000' '0.60';  ...
'2200' '0.515'});
model.material('mat1').propertyGroup('ElectrolyteConductivity').func('int1').set('interp', 'piecewisecubic');
model.material('mat1').propertyGroup('ElectrolyteConductivity').func('int1').set('fununit', {'S/m'});
model.material('mat1').propertyGroup('ElectrolyteConductivity').func('int1').set('argunit', {''});
model.material('mat1').propertyGroup('ElectrolyteConductivity').set('sigmal', {'sigmal_int1(c/1[mol/m^3])*exp(4000/8.314*(1/(T_ref2/1[K])-1/(T3/1[K])))' '0' '0' '0' 'sigmal_int1(c/1[mol/m^3])*exp(4000/8.314*(1/(T_ref2/1[K])-1/(T3/1[K])))' '0' '0' '0' 'sigmal_int1(c/1[mol/m^3])*exp(4000/8.314*(1/(T_ref2/1[K])-1/(T3/1[K])))'});
model.material('mat1').propertyGroup('ElectrolyteConductivity').set('INFO_PREFIX:sigmal', 'T. G. Zavalis, M. Behm, and G. Lindbergh, "Investigations of Short-Circuit Scenarios in a Lithium-Ion Battery Cell," J. Electrochem. Soc., vol. 159, p. A848, 2012.');
model.material('mat1').propertyGroup('ElectrolyteConductivity').set('T_ref2', '298[K]');
model.material('mat1').propertyGroup('ElectrolyteConductivity').descr('T_ref2', '');
model.material('mat1').propertyGroup('ElectrolyteConductivity').set('T3', 'min(393.15,max(T,223.15))');
model.material('mat1').propertyGroup('ElectrolyteConductivity').descr('T3', '');
model.material('mat1').propertyGroup('ElectrolyteConductivity').addInput('concentration');
model.material('mat1').propertyGroup('ElectrolyteConductivity').addInput('temperature');
model.material('mat1').propertyGroup('SpeciesProperties').func('int1').set('funcname', 'transpNm_int1');
model.material('mat1').propertyGroup('SpeciesProperties').func('int1').set('table', {'200' '0.37';  ...
'500' '0.322';  ...
'800' '0.27';  ...
'1000' '0.251';  ...
'1200' '0.248';  ...
'1600' '0.236';  ...
'2000' '0.11'});
model.material('mat1').propertyGroup('SpeciesProperties').func('int1').set('interp', 'piecewisecubic');
model.material('mat1').propertyGroup('SpeciesProperties').func('int1').set('fununit', {''});
model.material('mat1').propertyGroup('SpeciesProperties').func('int1').set('argunit', {''});
model.material('mat1').propertyGroup('SpeciesProperties').func('int2').set('funcname', 'actdep_int1');
model.material('mat1').propertyGroup('SpeciesProperties').func('int2').set('table', {'200' '0';  ...
'500' '0.29';  ...
'800' '0.695';  ...
'1000' '1';  ...
'1200' '1.32';  ...
'1600' '2.07';  ...
'2000' '2.50'});
model.material('mat1').propertyGroup('SpeciesProperties').func('int2').set('interp', 'piecewisecubic');
model.material('mat1').propertyGroup('SpeciesProperties').func('int2').set('fununit', {''});
model.material('mat1').propertyGroup('SpeciesProperties').func('int2').set('argunit', {''});
model.material('mat1').propertyGroup('SpeciesProperties').set('transpNum', 'transpNm_int1(c/1[mol/m^3])');
model.material('mat1').propertyGroup('SpeciesProperties').set('INFO_PREFIX:transpNum', ['A. Nyman, M. Behm, and G. Lindbergh, ' native2unicode(hex2dec({'20' '1c'}), 'unicode') 'Electrochemical characterisation and modelling of the mass transport phenomena in LiPF6-EC-EMC,' native2unicode(hex2dec({'20' '1d'}), 'unicode') ' Electrochim. Acta, vol. 53, p. 6356, 2008.']);
model.material('mat1').propertyGroup('SpeciesProperties').set('fcl', 'actdep_int1(c/1[mol/m^3])*exp(-1000/8.314*(1/(T_ref3/1[K])-1/(T4/1[K])))');
model.material('mat1').propertyGroup('SpeciesProperties').set('INFO_PREFIX:fcl', 'T. G. Zavalis, M. Behm, and G. Lindbergh, "Investigations of Short-Circuit Scenarios in a Lithium-Ion Battery Cell," J. Electrochem. Soc., vol. 159, p. A848, 2012.');
model.material('mat1').propertyGroup('SpeciesProperties').set('T4', 'min(393.15,max(T,223.15))');
model.material('mat1').propertyGroup('SpeciesProperties').descr('T4', '');
model.material('mat1').propertyGroup('SpeciesProperties').set('T_ref3', '298[K]');
model.material('mat1').propertyGroup('SpeciesProperties').descr('T_ref3', '');
model.material('mat1').propertyGroup('SpeciesProperties').addInput('concentration');
model.material('mat1').propertyGroup('SpeciesProperties').addInput('temperature');
model.material('mat1').propertyGroup('ElectrolyteSaltConcentration').identifier('cElsalt');
model.material('mat1').propertyGroup('ElectrolyteSaltConcentration').set('cElsalt', '1200[mol/m^3]');

model.geom('geom1').run;

model.material.create('mat2', 'Common', 'comp1');
model.material('mat2').propertyGroup('def').func.create('int1', 'Interpolation');
model.material('mat2').propertyGroup('def').func.create('int2', 'Interpolation');
model.material('mat2').propertyGroup.create('ElectrodePotential', 'Equilibrium potential');
model.material('mat2').propertyGroup('ElectrodePotential').func.create('int1', 'Interpolation');
model.material('mat2').propertyGroup('ElectrodePotential').func.create('int2', 'Interpolation');
model.material('mat2').propertyGroup.create('OperationalSOC', 'Operational electrode state of charge');
model.material('mat2').propertyGroup.create('ic', 'Intercalation strain');
model.material('mat2').propertyGroup('ic').func.create('int1', 'Interpolation');
model.material('mat2').propertyGroup.create('EquilibriumConcentration', 'Equilibrium concentration');
model.material('mat2').label('Graphite, LixC6 MCMB (Negative, Li-ion Battery)');
model.material('mat2').propertyGroup('def').func('int1').set('funcname', 'E_int');
model.material('mat2').propertyGroup('def').func('int1').set('table', {'0' '32.47'; '0.333' '28.56'; '0.5' '58.06'; '1' '108.67'});
model.material('mat2').propertyGroup('def').func('int1').set('fununit', {'GPa'});
model.material('mat2').propertyGroup('def').func('int1').set('argunit', {'1'});
model.material('mat2').propertyGroup('def').func('int2').set('funcname', 'nu_int');
model.material('mat2').propertyGroup('def').func('int2').set('table', {'0' '0.32'; '0.333' '0.39'; '0.5' '0.34'; '1' '0.24'});
model.material('mat2').propertyGroup('def').func('int2').set('fununit', {''});
model.material('mat2').propertyGroup('def').set('youngsmodulus', '');
model.material('mat2').propertyGroup('def').set('poissonsratio', '');
model.material('mat2').propertyGroup('def').set('youngsmodulus', 'E_int(c/csmax)');
model.material('mat2').propertyGroup('def').set('INFO_PREFIX:youngsmodulus', 'Yue Qi et al 2010 J. Electrochem. Soc. 157 A558');
model.material('mat2').propertyGroup('def').set('poissonsratio', 'nu_int(c/csmax)');
model.material('mat2').propertyGroup('def').set('INFO_PREFIX:poissonsratio', 'Yue Qi et al 2010 J. Electrochem. Soc. 157 A558');
model.material('mat2').propertyGroup('def').set('electricconductivity', {'100[S/m]' '0' '0' '0' '100[S/m]' '0' '0' '0' '100[S/m]'});
model.material('mat2').propertyGroup('def').set('INFO_PREFIX:electricconductivity', ['V. Srinivasan, and J. Newman, ' native2unicode(hex2dec({'20' '1c'}), 'unicode') 'Design and Optimization of a Natural Graphite/Iron Phosphate Lithium Ion Cell,' native2unicode(hex2dec({'20' '1d'}), 'unicode') ' J. Electrochem. Soc., vol. 151, p. 1530, 2004.']);
model.material('mat2').propertyGroup('def').set('diffusion', {'1.4523e-13*exp(68025.7/8.314*(1/(T_ref/1[K])-1/(T2/1[K])))[m^2/s]' '0' '0' '0' '1.4523e-13*exp(68025.7/8.314*(1/(T_ref/1[K])-1/(T2/1[K])))[m^2/s]' '0' '0' '0' '1.4523e-13*exp(68025.7/8.314*(1/(T_ref/1[K])-1/(T2/1[K])))[m^2/s]'});
model.material('mat2').propertyGroup('def').set('INFO_PREFIX:diffusion', ['K. Kumaresan, G. Sikha, and R. E. White, ' native2unicode(hex2dec({'20' '1c'}), 'unicode') 'Thermal Model for a Li-Ion Cell,' native2unicode(hex2dec({'20' '1d'}), 'unicode') ' J. Electrochem. Soc., vol. 155, p. A164, 2008.']);
model.material('mat2').propertyGroup('def').set('thermalconductivity', {'1[W/(m*K)]' '0' '0' '0' '1[W/(m*K)]' '0' '0' '0' '1[W/(m*K)]'});
model.material('mat2').propertyGroup('def').set('INFO_PREFIX:thermalconductivity', 'S. Chen, C. Wan, and Y. Wang, J. Power Sources, 140, 111 (2005).');
model.material('mat2').propertyGroup('def').set('heatcapacity', '750[J/(kg*K)]');
model.material('mat2').propertyGroup('def').set('INFO_PREFIX:heatcapacity', 'SI Chemical Data, John Wiley & Sons, 1994');
model.material('mat2').propertyGroup('def').set('density', '2300[kg/m^3]');
model.material('mat2').propertyGroup('def').set('INFO_PREFIX:density', 'SI Chemical Data, John Wiley & Sons, 1994');
model.material('mat2').propertyGroup('def').set('csmax', '31507[mol/m^3]');
model.material('mat2').propertyGroup('def').descr('csmax', '');
model.material('mat2').propertyGroup('def').set('T_ref', '318[K]');
model.material('mat2').propertyGroup('def').descr('T_ref', '');
model.material('mat2').propertyGroup('def').set('T2', 'min(393.15,max(T,223.15))');
model.material('mat2').propertyGroup('def').descr('T2', '');
model.material('mat2').propertyGroup('def').addInput('temperature');
model.material('mat2').propertyGroup('def').addInput('concentration');
model.material('mat2').propertyGroup('ElectrodePotential').func('int1').set('funcname', 'Eeq_int1');
model.material('mat2').propertyGroup('ElectrodePotential').func('int1').set('table', {'0' '2.781186612';  ...
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
model.material('mat2').propertyGroup('ElectrodePotential').func('int1').set('interp', 'piecewisecubic');
model.material('mat2').propertyGroup('ElectrodePotential').func('int1').set('extrap', 'linear');
model.material('mat2').propertyGroup('ElectrodePotential').func('int1').set('fununit', {'V'});
model.material('mat2').propertyGroup('ElectrodePotential').func('int1').set('argunit', {''});
model.material('mat2').propertyGroup('ElectrodePotential').func('int1').set('defineinv', true);
model.material('mat2').propertyGroup('ElectrodePotential').func('int1').set('funcinvname', 'Eeq_inv');
model.material('mat2').propertyGroup('ElectrodePotential').func('int2').set('funcname', 'dEeqdT_int1');
model.material('mat2').propertyGroup('ElectrodePotential').func('int2').set('table', {'0' '3.0e-4';  ...
'0.17' '0';  ...
'0.24' '-6e-5';  ...
'0.28' '-1.6e-4';  ...
'0.5' '-1.6e-4';  ...
'0.54' '-9e-5';  ...
'0.71' '-9e-5';  ...
'0.85' '-1.0e-4';  ...
'1.0' '-1.2e-4'});
model.material('mat2').propertyGroup('ElectrodePotential').func('int2').set('fununit', {'V/K'});
model.material('mat2').propertyGroup('ElectrodePotential').func('int2').set('argunit', {''});
model.material('mat2').propertyGroup('ElectrodePotential').set('Eeq', 'Eeq_int1(soc)+dEeqdT_int1(soc)*(T-298[K])');
model.material('mat2').propertyGroup('ElectrodePotential').set('INFO_PREFIX:Eeq', ['D. P Karthikeyan, G. Sikha, and R. E. White, ' native2unicode(hex2dec({'20' '1c'}), 'unicode') 'Thermodynamic model development for lithium intercalation electrodes,' native2unicode(hex2dec({'20' '1d'}), 'unicode') ' J. Power Sources, vol. 185, p. 1398, 2008.']);
model.material('mat2').propertyGroup('ElectrodePotential').set('dEeqdT', 'dEeqdT_int1(soc)');
model.material('mat2').propertyGroup('ElectrodePotential').set('INFO_PREFIX:dEeqdT', ['K. E. Thomas, and J. Newman, ' native2unicode(hex2dec({'20' '1c'}), 'unicode') 'Heats of mixing and of entropy in porous insertion electrodes,' native2unicode(hex2dec({'20' '1d'}), 'unicode') ' J. Power Sources., vol. 119-121, p. 844, 2003.']);
model.material('mat2').propertyGroup('ElectrodePotential').set('cEeqref', 'def.csmax');
model.material('mat2').propertyGroup('ElectrodePotential').set('soc', 'c/cEeqref');
model.material('mat2').propertyGroup('ElectrodePotential').descr('soc', '');
model.material('mat2').propertyGroup('ElectrodePotential').addInput('concentration');
model.material('mat2').propertyGroup('ElectrodePotential').addInput('temperature');
model.material('mat2').propertyGroup('OperationalSOC').set('socmax', 'elpot.Eeq_inv(E_min)');
model.material('mat2').propertyGroup('OperationalSOC').set('socmin', 'elpot.Eeq_inv(E_max)');
model.material('mat2').propertyGroup('OperationalSOC').set('E_max', '1[V]');
model.material('mat2').propertyGroup('OperationalSOC').set('E_min', '0.075[V]');
model.material('mat2').propertyGroup('ic').func('int1').set('funcname', 'dVOLdSOL');
model.material('mat2').propertyGroup('ic').func('int1').set('table', {'0' '0';  ...
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
model.material('mat2').propertyGroup('ic').func('int1').set('extrap', 'linear');
model.material('mat2').propertyGroup('ic').func('int1').set('fununit', {'%'});
model.material('mat2').propertyGroup('ic').func('int1').set('argunit', {'1'});
model.material('mat2').propertyGroup('ic').set('dvol', 'dVOLdSOL(c/def.csmax)');
model.material('mat2').propertyGroup('ic').set('INFO_PREFIX:dvol', ['S. Schweidler, L. de Biasi, A. Schiele, P. Hartmann, T. Brezesinski and J. Janek, "Volume Changes of Graphite Anodes Revisited: A Combined Operando X-Ray Diffraction and In Situ Pressure Analysis Study", J. Phys. Chem. C, 2018, 122, 8829' native2unicode(hex2dec({'20' '13'}), 'unicode') '8835']);
model.material('mat2').propertyGroup('ic').addInput('concentration');
model.material('mat2').propertyGroup('EquilibriumConcentration').set('csEq', 'def.csmax*elpot.Eeq_inv(V)');
model.material('mat2').propertyGroup('EquilibriumConcentration').addInput('electricpotential');
model.material.create('mat3', 'Common', 'comp1');
model.material('mat3').propertyGroup.create('ElectrodePotential', 'Equilibrium potential');
model.material('mat3').propertyGroup('ElectrodePotential').func.create('int1', 'Interpolation');
model.material('mat3').propertyGroup.create('OperationalSOC', 'Operational electrode state of charge');
model.material('mat3').propertyGroup.create('ic', 'Intercalation strain');
model.material('mat3').propertyGroup('ic').func.create('int1', 'Interpolation');
model.material('mat3').propertyGroup.create('EquilibriumConcentration', 'Equilibrium concentration');
model.material('mat3').label('NMC 111, LiNi0.33Mn0.33Co0.33O2 (Positive, Li-ion Battery)');
model.material('mat3').propertyGroup('def').set('poissonsratio', '');
model.material('mat3').propertyGroup('def').set('youngsmodulus', '');
model.material('mat3').propertyGroup('def').set('thermalconductivity', '');
model.material('mat3').propertyGroup('def').set('thermalexpansioncoefficient', '');
model.material('mat3').propertyGroup('def').set('poissonsratio', '0.25');
model.material('mat3').propertyGroup('def').set('INFO_PREFIX:poissonsratio', ['Mechanical and physical properties of LiNi0.33Mn0.33Co0.33O2 (NMC),' newline 'E Chenga, K. Hong, N. Taylor, H. Choe,' newline 'J. Wolfenstinec, J. Sakamotoa,' newline 'Journal of the European Ceramic Society 37 (2017) 3213' native2unicode(hex2dec({'20' '13'}), 'unicode') '3217']);
model.material('mat3').propertyGroup('def').set('youngsmodulus', '78[GPa]');
model.material('mat3').propertyGroup('def').set('INFO_PREFIX:youngsmodulus', ['Mechanical and physical properties of LiNi0.33Mn0.33Co0.33O2 (NMC),' newline 'E Chenga, K. Hong, N. Taylor, H. Choe,' newline 'J. Wolfenstinec, J. Sakamotoa,' newline 'Journal of the European Ceramic Society 37 (2017) 3213' native2unicode(hex2dec({'20' '13'}), 'unicode') '3217']);
model.material('mat3').propertyGroup('def').set('thermalconductivity', {'3.6[W/(m*K)]' '0' '0' '0' '3.6[W/(m*K)]' '0' '0' '0' '3.6[W/(m*K)]'});
model.material('mat3').propertyGroup('def').set('INFO_PREFIX:thermalconductivity', ['Mechanical and physical properties of LiNi0.33Mn0.33Co0.33O2 (NMC),' newline 'E Chenga, K. Hong, N. Taylor, H. Choe,' newline 'J. Wolfenstinec, J. Sakamotoa,' newline 'Journal of the European Ceramic Society 37 (2017) 3213' native2unicode(hex2dec({'20' '13'}), 'unicode') '3217']);
model.material('mat3').propertyGroup('def').set('thermalexpansioncoefficient', {'1.2e-5[1/K]' '0' '0' '0' '1.2e-5[1/K]' '0' '0' '0' '1.2e-5[1/K]'});
model.material('mat3').propertyGroup('def').set('INFO_PREFIX:thermalexpansioncoefficient', ['Mechanical and physical properties of LiNi0.33Mn0.33Co0.33O2 (NMC),' newline 'E Chenga, K. Hong, N. Taylor, H. Choe,' newline 'J. Wolfenstinec, J. Sakamotoa,' newline 'Journal of the European Ceramic Society 37 (2017) 3213' native2unicode(hex2dec({'20' '13'}), 'unicode') '3217']);
model.material('mat3').propertyGroup('def').set('diffusion', {'1e-14[m^2/s]' '0' '0' '0' '1e-14[m^2/s]' '0' '0' '0' '1e-14[m^2/s]'});
model.material('mat3').propertyGroup('def').set('INFO_PREFIX:diffusion', 'Jing Ying Ko et al, J. Electrochem. Soc., 166, A2939');
model.material('mat3').propertyGroup('def').set('electricconductivity', {'100[S/m]' '0' '0' '0' '100[S/m]' '0' '0' '0' '100[S/m]'});
model.material('mat3').propertyGroup('def').set('csmax', '49000[mol/m^3]');
model.material('mat3').propertyGroup('def').descr('csmax', '');
model.material('mat3').propertyGroup('ElectrodePotential').func('int1').set('funcname', 'Eeq_int1');
model.material('mat3').propertyGroup('ElectrodePotential').func('int1').set('table', {'0' '4.44';  ...
'0.032' '4.34';  ...
'0.102' '4.23';  ...
'0.187' '4.13';  ...
'0.289' '4.025';  ...
'0.38' '3.945';  ...
'0.543' '3.835';  ...
'0.775' '3.71';  ...
'0.872' '3.62';  ...
'0.925' '3.51';  ...
'0.943' '3.42';  ...
'0.957' '3.30';  ...
'0.966' '3.165';  ...
'0.970' '3.02';  ...
'0.972' '2.90';  ...
'0.975' '2.688'});
model.material('mat3').propertyGroup('ElectrodePotential').func('int1').set('interp', 'piecewisecubic');
model.material('mat3').propertyGroup('ElectrodePotential').func('int1').set('extrap', 'linear');
model.material('mat3').propertyGroup('ElectrodePotential').func('int1').set('fununit', {'V'});
model.material('mat3').propertyGroup('ElectrodePotential').func('int1').set('argunit', {''});
model.material('mat3').propertyGroup('ElectrodePotential').func('int1').set('defineinv', true);
model.material('mat3').propertyGroup('ElectrodePotential').func('int1').set('funcinvname', 'Eeq_inv');
model.material('mat3').propertyGroup('ElectrodePotential').set('Eeq', 'Eeq_int1(soc)+dEeqdT*(T-298[K])');
model.material('mat3').propertyGroup('ElectrodePotential').set('INFO_PREFIX:Eeq', 'W. Zheng, M. Shui, J. Shu, S. Gao, D. Xu, L. Chen, L. Feng and Y. Ren, " GITT studies on oxide cathode LiNi1/3Co1/3Mn1/3O2 synthesized by citric acid assisted high-energy ball milling", Bull. Mater. Sci., vol. 36, p. A495, 2013');
model.material('mat3').propertyGroup('ElectrodePotential').set('dEeqdT', '-10[J/mol/K]/F_const');
model.material('mat3').propertyGroup('ElectrodePotential').set('INFO_PREFIX:dEeqdT', 'V Viswanathan, D Choi, D Wang, W Xu, S Towne, R Williford, JG Zhang, J Liu and Z Yang "Effect of entropy change on lithium intercalation in cathodes and anodes on Li-ion battery thermal management", Journal of Power Sources 195 (2010) 3720-3729');
model.material('mat3').propertyGroup('ElectrodePotential').set('cEeqref', 'def.csmax');
model.material('mat3').propertyGroup('ElectrodePotential').set('INFO_PREFIX:cEeqref', 'W. Zheng, M. Shui, J. Shu, S. Gao, D. Xu, L. Chen, L. Feng and Y. Ren, " GITT studies on oxide cathode LiNi1/3Co1/3Mn1/3O2 synthesized by citric acid assisted high-energy ball milling", Bull. Mater. Sci., vol. 36, p. A495, 2013');
model.material('mat3').propertyGroup('ElectrodePotential').set('soc', 'c/cEeqref');
model.material('mat3').propertyGroup('ElectrodePotential').descr('soc', '');
model.material('mat3').propertyGroup('ElectrodePotential').addInput('concentration');
model.material('mat3').propertyGroup('ElectrodePotential').addInput('temperature');
model.material('mat3').propertyGroup('OperationalSOC').set('socmax', 'elpot.Eeq_inv(E_min)');
model.material('mat3').propertyGroup('OperationalSOC').set('socmin', 'elpot.Eeq_inv(E_max)');
model.material('mat3').propertyGroup('OperationalSOC').set('E_max', '4.4[V]');
model.material('mat3').propertyGroup('OperationalSOC').set('E_min', '3.3[V]');
model.material('mat3').propertyGroup('ic').func('int1').set('funcname', 'dVOLdSOL');
model.material('mat3').propertyGroup('ic').func('int1').set('table', {'1' '0';  ...
'0.9260263416001121' '-0.010256410256411108';  ...
'0.8670351688384477' '-0.1948717948717955';  ...
'0.8113086731119519' '-0.27692307692307727';  ...
'0.7506669468964551' '-0.37948717948718036';  ...
'0.6949460557657279' '-0.502564102564103';  ...
'0.628563822334314' '-0.5846153846153856';  ...
'0.55562421185372' '-0.6666666666666674';  ...
'0.501531455793751' '-0.7076923076923083';  ...
'0.4441600112091916' '-0.7487179487179496';  ...
'0.3851716407454113' '-0.953846153846154';  ...
'0.3278338237354632' '-1.241025641025642';  ...
'0.2737943113352951' '-1.671794871794872';  ...
'0.24269440941572107' '-2.0205128205128213'});
model.material('mat3').propertyGroup('ic').func('int1').set('extrap', 'linear');
model.material('mat3').propertyGroup('ic').func('int1').set('fununit', {'%'});
model.material('mat3').propertyGroup('ic').func('int1').set('argunit', {'1'});
model.material('mat3').propertyGroup('ic').set('dvol', 'dVOLdSOL(c/elpot.cEeqref)');
model.material('mat3').propertyGroup('ic').set('INFO_PREFIX:dvol', ['R. Koerver and others, ' native2unicode(hex2dec({'20' '1c'}), 'unicode') 'Chemo-mechanical expansion of lithium electrode materials ' native2unicode(hex2dec({'20' '14'}), 'unicode') ' on the route to mechanically optimized all-solid-state batteries,' native2unicode(hex2dec({'20' '1d'}), 'unicode') ' Energy Environ. Sci., vol. 11, pp. 2142' native2unicode(hex2dec({'20' '13'}), 'unicode') '2158, 201']);
model.material('mat3').propertyGroup('ic').addInput('concentration');
model.material('mat3').propertyGroup('EquilibriumConcentration').set('csEq', 'def.csmax*elpot.Eeq_inv(V)');
model.material('mat3').propertyGroup('EquilibriumConcentration').addInput('electricpotential');

model.geom('geom1').create('i1', 'Interval');
model.geom('geom1').feature('i1').set('specify', 'len');
model.geom('geom1').feature('i1').setIndex('len', 'L_neg', 0);
model.geom('geom1').feature('i1').setIndex('len', 'L_sep', 1);
model.geom('geom1').feature('i1').setIndex('len', 'L_pos', 2);
model.geom('geom1').run('i1');
model.geom('geom1').run;

model.material('mat1').selection.set([2]);

model.selection.create('sel1', 'Explicit');
model.selection('sel1').model('comp1');
model.selection('sel1').geom(1);
model.selection('sel1').label('Separator');
model.selection('sel1').set([2]);

model.material('mat1').selection.named('sel1');
model.material('mat2').selection.set([1]);

model.selection.create('sel2', 'Explicit');
model.selection('sel2').model('comp1');
model.selection('sel2').geom(1);
model.selection('sel2').label('Negative Electrode');
model.selection('sel2').set([1]);

model.material('mat2').selection.named('sel2');
model.material('mat3').selection.set([3]);

model.selection.create('sel3', 'Explicit');
model.selection('sel3').model('comp1');
model.selection('sel3').geom(1);
model.selection('sel3').label('Positive Electrode');
model.selection('sel3').set([3]);

model.material('mat3').selection.named('sel3');

model.physics('liion').prop('Ac').set('Ac', 'A_cell');
model.physics('liion').prop('CellSettings').set('CellSOCandInitialChargeInventory', true);
model.physics('liion').feature('socicd1').set('SOC_init', 'soc_init');
model.physics('liion').feature('socicd1').feature('neges1').selection.named('sel2');
model.physics('liion').feature('socicd1').feature('poses1').selection.named('sel3');
model.physics('liion').feature('sep1').set('epsl', 'epsl_sep');
model.physics('liion').create('pce1', 'PorousElectrode', 1);
model.physics('liion').feature('pce1').label('Porous Electrode - Negative');
model.physics('liion').feature('pce1').selection.named('sel2');
model.physics('liion').feature('pce1').set('ElectrolyteMaterial', 'mat1');
model.physics('liion').feature('pce1').set('sigma', {'sigmas_neg' '0' '0' '0' 'sigmas_neg' '0' '0' '0' 'sigmas_neg'});
model.physics('liion').feature('pce1').set('epss', 'epss_neg');
model.physics('liion').feature('pce1').set('epsl', 'epsl_neg');
model.physics('liion').feature('pce1').set('ElectricCorrModel', 'NoCorr');
model.physics('liion').feature('pce1').feature('pin1').set('rp', 'rp_neg');
model.physics('liion').feature('pce1').feature('pin1').set('FastAssembly', true);
model.physics('liion').feature('pce1').feature('per1').set('i0_ref', 'i0_ref_neg');
model.physics('liion').feature.duplicate('pce2', 'pce1');
model.physics('liion').feature('pce2').label('Porous Electrode - Positive');
model.physics('liion').feature('pce2').selection.named('sel3');
model.physics('liion').feature('pce2').set('sigma', {'sigmas_pos' '0' '0' '0' 'sigmas_pos' '0' '0' '0' 'sigmas_pos'});
model.physics('liion').feature('pce2').set('epss', 'epss_pos');
model.physics('liion').feature('pce2').set('epsl', 'epsl_pos');
model.physics('liion').feature('pce2').feature('pin1').set('rp', 'rp_pos');
model.physics('liion').feature('pce2').feature('per1').set('i0_ref', 'i0_ref_pos');
model.physics('liion').create('egnd1', 'ElectricGround', 0);
model.physics('liion').feature('egnd1').selection.set([1]);

model.selection.create('sel4', 'Explicit');
model.selection('sel4').model('comp1');
model.selection('sel4').geom(0);
model.selection('sel4').label('Negative CC');
model.selection('sel4').set([1]);

model.physics('liion').feature('egnd1').selection.named('sel4');
model.physics('liion').create('ecd1', 'ElectrodeNormalCurrentDensity', 0);
model.physics('liion').feature('ecd1').selection.set([4]);

model.selection.create('sel5', 'Explicit');
model.selection('sel5').model('comp1');
model.selection('sel5').geom(0);
model.selection('sel5').label('Positive CC');
model.selection('sel5').set([4]);

model.physics('liion').feature('ecd1').selection.named('sel5');
model.physics('liion').feature('ecd1').set('nis', 'I_1C');

model.common('cminpt').set('modified', {'temperature' 'T'});

model.variable.create('var1');
model.variable('var1').model('comp1');
model.variable('var1').label('Variables for Li-ion battery model');

% To import content from file, use:
% model.variable('var1').loadFile('FILENAME');
model.variable('var1').set('sol_neg', 'liion.soc_average_pce1', 'Degree of lithiation, negative');
model.variable('var1').set('sol_pos', 'liion.soc_average_pce2', 'Degree of lithiation, positive');
model.variable('var1').set('soc_cell', 'liion.SOC_cell', 'Battery cell state of charge');
model.variable('var1').set('E_ocp_neg', 'mat2.elpot.Eeq_int1(sol_neg)', 'Open-circuit potential in negative electrode');
model.variable('var1').set('E_ocp_pos', 'mat3.elpot.Eeq_int1(sol_pos)', 'Open-circuit potential in positive electrode');
model.variable('var1').set('E_ocv_cell', 'E_ocp_pos-E_ocp_neg', 'Open-circuit cell voltage');
model.variable('var1').set('E_pol_tot', 'E_cell-E_ocv_cell', 'Total battery cell polarization');
model.variable('var1').set('I_1C', 'liion.I_1C_cell/A_cell', '1 h charge/discharge current density');

model.probe.create('point1', 'Point');
model.probe('point1').model('comp1');
model.probe('point1').set('probename', 'E_cell');
model.probe('point1').set('type', 'integral');
model.probe('point1').selection.named('sel5');
model.probe('point1').set('expr', 'phis');
model.probe('point1').set('descractive', true);
model.probe('point1').set('descr', 'Cell voltage');

model.result.table.create('tbl1', 'Table');

model.probe('point1').set('table', 'tbl1');

model.param.set('L_pos', '60[um]');
model.param.set('soc_init', '100[%]');
model.param.set('C_rate', '1');
model.param.descr('C_rate', 'Discharge rate');

model.variable('var1').set('I_app', '-C_rate*I_1C');
model.variable('var1').descr('I_app', 'Applied cell current density');
model.variable('var1').set('E_stop', '2.6[V]');
model.variable('var1').descr('E_stop', 'Stop (threshold) voltage');

model.geom('geom1').run;

model.physics('liion').feature('ecd1').set('nis', 'I_app');
model.physics.create('ge', 'GlobalEquations', 'geom1');
model.physics('ge').model('comp1');

model.study('std1').feature('cdi').setSolveFor('/physics/ge', true);
model.study('std1').feature('time').setSolveFor('/physics/ge', true);

model.physics('ge').prop('EquationForm').set('form', 'Automatic');
model.physics.create('ev', 'Events', 'geom1');
model.physics('ev').model('comp1');

model.study('std1').feature('cdi').setSolveFor('/physics/ev', true);
model.study('std1').feature('time').setSolveFor('/physics/ev', true);

model.physics('ge').label('Cumulative Energy');
model.physics('ge').feature('ge1').setIndex('name', 'W', 0, 0);
model.physics('ge').feature('ge1').setIndex('equation', 'd(W,t)-abs(I_app*E_cell)', 0, 0);
model.physics('ge').feature('ge1').set('CustomDependentVariableUnit', '1');
model.physics('ge').feature('ge1').set('DependentVariableQuantity', 'none');
model.physics('ge').feature('ge1').setIndex('CustomDependentVariableUnit', 'J/m^2', 0, 0);
model.physics('ge').feature('ge1').set('CustomSourceTermUnit', '1');
model.physics('ge').feature('ge1').set('SourceTermQuantity', 'none');
model.physics('ge').feature('ge1').setIndex('CustomSourceTermUnit', 'W/m^2', 0, 0);
model.physics('ev').create('is1', 'IndicatorStates', -1);
model.physics('ev').feature('is1').setIndex('indDim', 'STOP_DCH', 0, 0);
model.physics('ev').feature('is1').setIndex('g', 0, 0, 0);
model.physics('ev').feature('is1').setIndex('dimInit', 0, 0, 0);
model.physics('ev').feature('is1').setIndex('g', 'E_stop-E_cell', 0, 0);
model.physics('ev').create('impl1', 'ImplicitEvent', -1);
model.physics('ev').feature('impl1').set('condition', 'STOP_DCH>0');

model.param.create('par2');
model.param('par2').label('Parameters Set from App');

% To import content from file, use:
% model.param('par2').loadFile('FILENAME');
model.param('par2').set('L_pos_app_phys', 'L_pos', 'Positive electrode thickness, set from app');
model.param('par2').set('epss_neg_app_phys', 'epss_neg', 'Negative electrode active material volume fraction, set from app');
model.param('par2').set('epss_pos_app_phys', 'epss_pos', 'Positive electrode active material volume fraction, set from app');
model.param('par2').set('L_pos_app_init', '90[um]', 'Initial positive electrode thickness, used in app');
model.param('par2').set('epss_neg_app_init', '0.5', 'Initial negative electrode active material volume fraction, used in app');
model.param('par2').set('epss_pos_app_init', '0.5', 'Initial positive electrode active material volume fraction, used in app');
model.param.create('par3');
model.param('par3').label('Parameters for Plot Axis Limits');

% To import content from file, use:
% model.param('par3').loadFile('FILENAME');
model.param('par3').set('xmin', '10', 'x minimum, used for app graphics');
model.param('par3').set('xmax', '10000', 'x maximum, used for app graphics');
model.param('par3').set('ymin', '10', 'y minimum, used for app graphics');
model.param('par3').set('ymax', '1000', 'y maximum, used for app graphics');
model.param.set('Q_pos', 'F_const*(1-0.1)*epss_pos*cs_max_pos');
model.param.descr('Q_pos', 'Theoretical maximum capacity, positive electrode');
model.param.set('q_cell', 'Q_pos*L_pos*epss_pos');
model.param.descr('q_cell', 'Cell areal capacity');

model.variable.create('var2');
model.variable('var2').model('comp1');
model.variable('var2').label('Variables for Surrogate Model');

% To import content from file, use:
% model.variable('var2').loadFile('FILENAME');
model.variable('var2').set('P_vol_ave', 'W/t/(L_neg+L_sep+L_pos+L_ccs/2)', 'Average volumetric power');
model.variable('var2').set('E_vol', 'W/(L_neg+L_sep+L_pos+L_ccs/2)', 'Volumetric energy');

model.study('std1').label('Study 1: Data Generation');
model.study('std1').create('sm', 'SurrogateModelTraining');
model.study('std1').feature('sm').set('qoisolution', 'last');
model.study('std1').feature('sm').setIndex('qoiexpression', '', 0);
model.study('std1').feature('sm').setIndex('descr', '', 0);
model.study('std1').feature('sm').setIndex('qoisolutionindv', 'parent', 0);
model.study('std1').feature('sm').setIndex('qoiexpression', '', 0);
model.study('std1').feature('sm').setIndex('descr', '', 0);
model.study('std1').feature('sm').setIndex('qoisolutionindv', 'parent', 0);
model.study('std1').feature('sm').setIndex('qoiexpression', 'comp1.E_vol', 0);
model.study('std1').feature('sm').setIndex('descr', 'Volumetric energy', 0);
model.study('std1').feature('sm').setIndex('qoiexpression', '', 1);
model.study('std1').feature('sm').setIndex('descr', '', 1);
model.study('std1').feature('sm').setIndex('qoisolutionindv', 'parent', 1);
model.study('std1').feature('sm').setIndex('qoiexpression', '', 1);
model.study('std1').feature('sm').setIndex('descr', '', 1);
model.study('std1').feature('sm').setIndex('qoisolutionindv', 'parent', 1);
model.study('std1').feature('sm').setIndex('qoiexpression', 'comp1.P_vol_ave', 1);
model.study('std1').feature('sm').setIndex('descr', 'Average volumetric power', 1);
model.study('std1').feature('sm').setIndex('pname', 'A_cell', 0);
model.study('std1').feature('sm').setEntry('sourceType', 'col1', 'analytic');
model.study('std1').feature('sm').setIndex('paramDescription', 'm^2', 0);
model.study('std1').feature('sm').setIndex('pname', 'A_cell', 0);
model.study('std1').feature('sm').setEntry('sourceType', 'col1', 'analytic');
model.study('std1').feature('sm').setIndex('paramDescription', 'm^2', 0);
model.study('std1').feature('sm').setIndex('pname', 'C_rate', 0);
model.study('std1').feature('sm').setEntry('lboundselection', 'col1', '0.1');
model.study('std1').feature('sm').setEntry('uboundselection', 'col1', '10');
model.study('std1').feature('sm').setIndex('pname', 'A_cell', 1);
model.study('std1').feature('sm').setEntry('sourceType', 'col2', 'analytic');
model.study('std1').feature('sm').setIndex('paramDescription', 'm^2', 1);
model.study('std1').feature('sm').setIndex('pname', 'A_cell', 1);
model.study('std1').feature('sm').setEntry('sourceType', 'col2', 'analytic');
model.study('std1').feature('sm').setIndex('paramDescription', 'm^2', 1);
model.study('std1').feature('sm').setIndex('pname', 'L_pos', 1);
model.study('std1').feature('sm').setEntry('lboundselection', 'col2', '30');
model.study('std1').feature('sm').setEntry('uboundselection', 'col2', '150');
model.study('std1').feature('sm').setEntry('punitselection', 'col2', 'um');
model.study('std1').feature('sm').setIndex('pname', 'A_cell', 2);
model.study('std1').feature('sm').setEntry('sourceType', 'col3', 'analytic');
model.study('std1').feature('sm').setIndex('paramDescription', 'm^2', 2);
model.study('std1').feature('sm').setIndex('pname', 'A_cell', 2);
model.study('std1').feature('sm').setEntry('sourceType', 'col3', 'analytic');
model.study('std1').feature('sm').setIndex('paramDescription', 'm^2', 2);
model.study('std1').feature('sm').setIndex('pname', 'epss_neg', 2);
model.study('std1').feature('sm').setEntry('lboundselection', 'col3', '0.2');
model.study('std1').feature('sm').setEntry('uboundselection', 'col3', '0.8');
model.study('std1').feature('sm').setIndex('pname', 'A_cell', 3);
model.study('std1').feature('sm').setEntry('sourceType', 'col4', 'analytic');
model.study('std1').feature('sm').setIndex('paramDescription', 'm^2', 3);
model.study('std1').feature('sm').setIndex('pname', 'A_cell', 3);
model.study('std1').feature('sm').setEntry('sourceType', 'col4', 'analytic');
model.study('std1').feature('sm').setIndex('paramDescription', 'm^2', 3);
model.study('std1').feature('sm').setIndex('pname', 'epss_pos', 3);
model.study('std1').feature('sm').setEntry('lboundselection', 'col4', '0.2');
model.study('std1').feature('sm').setEntry('uboundselection', 'col4', '0.8');
model.study('std1').feature('sm').set('nsolvenonadp', 300);
model.study('std1').feature('sm').set('useseed', 'manual');
model.study('std1').feature('sm').set('errorhandling', 'later');

model.sol.create('sol1');
model.sol('sol1').study('std1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'cdi');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').feature('comp1_phil').set('scalemethod', 'manual');
model.sol('sol1').feature('v1').feature('comp1_phis').set('scalemethod', 'manual');
model.sol('sol1').feature('v1').feature('comp1_cl').set('scalemethod', 'manual');
model.sol('sol1').feature('v1').feature('comp1_phil').set('scaleval', '1');
model.sol('sol1').feature('v1').feature('comp1_phis').set('scaleval', '1');
model.sol('sol1').feature('v1').feature('comp1_cl').set('scaleval', '1000');
model.sol('sol1').feature('v1').set('control', 'cdi');
model.sol('sol1').create('s1', 'Stationary');
model.sol('sol1').feature('s1').set('stol', 1.0E-4);
model.sol('sol1').feature('s1').create('seDef', 'Segregated');
model.sol('sol1').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('s1').feature('fc1').set('dtech', 'auto');
model.sol('sol1').feature('s1').feature('fc1').set('maxiter', 50);
model.sol('sol1').feature('s1').feature('fc1').set('minstep', 1.0E-6);
model.sol('sol1').feature('s1').create('d1', 'Direct');
model.sol('sol1').feature('s1').feature('d1').label('Direct (Merged)');
model.sol('sol1').feature('s1').create('i1', 'Iterative');
model.sol('sol1').feature('s1').feature('i1').set('maxlinit', 1000);
model.sol('sol1').feature('s1').feature('i1').set('nlinnormuse', 'on');
model.sol('sol1').feature('s1').feature('i1').label('Algebraic Multigrid (liion)');
model.sol('sol1').feature('s1').feature('i1').create('mg1', 'Multigrid');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').set('prefun', 'saamg');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').set('maxcoarsedof', 50000);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').set('saamgcompwise', true);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').set('compactaggregation', true);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('pr').create('sl1', 'SORLine');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('po').create('sl1', 'SORLine');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('cs').create('d1', 'Direct');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('cs').feature('d1').set('linsolver', 'pardiso');
model.sol('sol1').feature('s1').create('i2', 'Iterative');
model.sol('sol1').feature('s1').feature('i2').set('maxlinit', 1000);
model.sol('sol1').feature('s1').feature('i2').set('nlinnormuse', 'on');
model.sol('sol1').feature('s1').feature('i2').label('Geometric Multigrid (liion)');
model.sol('sol1').feature('s1').feature('i2').create('mg1', 'Multigrid');
model.sol('sol1').feature('s1').feature('i2').feature('mg1').feature('pr').create('sl1', 'SORLine');
model.sol('sol1').feature('s1').feature('i2').feature('mg1').feature('po').create('sl1', 'SORLine');
model.sol('sol1').feature('s1').feature('i2').feature('mg1').feature('cs').create('d1', 'Direct');
model.sol('sol1').feature('s1').feature('i2').feature('mg1').feature('cs').feature('d1').set('linsolver', 'pardiso');
model.sol('sol1').feature('s1').feature('fc1').set('linsolver', 'd1');
model.sol('sol1').feature('s1').feature('fc1').set('dtech', 'auto');
model.sol('sol1').feature('s1').feature('fc1').set('maxiter', 50);
model.sol('sol1').feature('s1').feature('fc1').set('minstep', 1.0E-6);
model.sol('sol1').feature('s1').feature.remove('fcDef');
model.sol('sol1').feature('s1').feature.remove('seDef');
model.sol('sol1').create('su1', 'StoreSolution');
model.sol('sol1').create('st2', 'StudyStep');
model.sol('sol1').feature('st2').set('study', 'std1');
model.sol('sol1').feature('st2').set('studystep', 'time');
model.sol('sol1').create('v2', 'Variables');
model.sol('sol1').feature('v2').feature('comp1_phil').set('scalemethod', 'manual');
model.sol('sol1').feature('v2').feature('comp1_liion_pce1_csfast').set('scalemethod', 'manual');
model.sol('sol1').feature('v2').feature('comp1_liion_pce2_csfast').set('scalemethod', 'manual');
model.sol('sol1').feature('v2').feature('comp1_phis').set('scalemethod', 'manual');
model.sol('sol1').feature('v2').feature('comp1_cl').set('scalemethod', 'manual');
model.sol('sol1').feature('v2').feature('comp1_phil').set('scaleval', '1');
model.sol('sol1').feature('v2').feature('comp1_liion_pce1_csfast').set('scaleval', '10000');
model.sol('sol1').feature('v2').feature('comp1_liion_pce2_csfast').set('scaleval', '10000');
model.sol('sol1').feature('v2').feature('comp1_phis').set('scaleval', '1');
model.sol('sol1').feature('v2').feature('comp1_cl').set('scaleval', '1000');
model.sol('sol1').feature('v2').set('initmethod', 'sol');
model.sol('sol1').feature('v2').set('initsol', 'sol1');
model.sol('sol1').feature('v2').set('initsoluse', 'sol2');
model.sol('sol1').feature('v2').set('notsolmethod', 'sol');
model.sol('sol1').feature('v2').set('notsol', 'sol1');
model.sol('sol1').feature('v2').set('notsoluse', 'sol2');
model.sol('sol1').feature('v2').set('control', 'time');
model.sol('sol1').create('t1', 'Time');
model.sol('sol1').feature('t1').set('tlist', 'range(0,0.1,1)');
model.sol('sol1').feature('t1').set('plot', 'off');
model.sol('sol1').feature('t1').set('plotgroup', 'Default');
model.sol('sol1').feature('t1').set('plotfreq', 'tout');
model.sol('sol1').feature('t1').set('probesel', 'all');
model.sol('sol1').feature('t1').set('probes', {'point1'});
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

model.study('std1').feature('sm').set('computeaction', 'recompute');

model.batch.create('pd1', 'DesignofExperiments');
model.batch('pd1').study('std1');
model.batch('pd1').set('lhssettings', 'auto');
model.batch('pd1').create('so1', 'Solutionseq');
model.batch('pd1').feature('so1').set('seq', 'sol1');
model.batch('pd1').feature('so1').set('store', 'on');
model.batch('pd1').feature('so1').set('clear', 'on');
model.batch('pd1').feature('so1').set('psol', 'none');
model.batch('pd1').attach('std1');
model.batch('pd1').set('control', 'sm');

model.study('std1').feature('sm').set('computeaction', 'recompute');

model.sol('sol1').feature('t1').create('st1', 'StopCondition');
model.sol('sol1').feature('t1').feature('st1').set('eventstopName', {'comp1.ev.impl1.event'});
model.sol('sol1').feature('t1').feature('st1').set('eventstopActive', {'off'});
model.sol('sol1').feature('t1').feature('st1').setIndex('eventstopActive', true, 0);
model.sol('sol1').feature('t1').feature('st1').set('storestopcondsol', 'stepafter');
model.sol('sol1').feature('t1').feature('st1').set('stopcondwarn', false);

model.study('std1').feature('cdi').setEntry('activate', 'ge', false);
model.study('std1').setGenPlots(false);
model.study('std1').feature('time').set('tlist', '0 1000[h]');

model.batch('pd1').feature.remove('so1');
model.batch('pd1').create('so1', 'Solutionseq');
model.batch('pd1').feature('so1').set('seq', 'sol1');
model.batch('pd1').feature('so1').set('store', 'on');
model.batch('pd1').feature('so1').set('clear', 'on');
model.batch('pd1').feature('so1').set('psol', 'none');
model.batch('pd1').set('control', 'sm');

model.sol.create('sol3');
model.sol('sol3').study('std1');
model.sol('sol3').label('Parametric Solutions 1');

model.batch('pd1').feature('so1').set('psol', 'sol3');

model.probe('point1').genResult('none');

model.batch('pd1').run('compute');

model.func.create('dnn1', 'DNN');
model.func('dnn1').label('Deep Neural Network');
model.func('dnn1').set('source', 'resultTable');
model.func('dnn1').setEntry('columnType', 'col5', 'value');
model.func('dnn1').setEntry('args', 'col1', 'C_rate');
model.func('dnn1').setEntry('descr', 'col1', 'Discharge rate');
model.func('dnn1').setEntry('args', 'col2', 'L_pos');
model.func('dnn1').setEntry('unit', 'col2', 'm');
model.func('dnn1').setEntry('descr', 'col2', 'Positive electrode thickness');
model.func('dnn1').setEntry('args', 'col3', 'epss_neg');
model.func('dnn1').setEntry('descr', 'col3', 'Negative electrode active material volume fraction');
model.func('dnn1').setEntry('args', 'col4', 'epss_pos');
model.func('dnn1').setEntry('descr', 'col4', 'Positive electrode active material volume fraction');
model.func('dnn1').setEntry('funcs', 'col5', 'dnn_E_vol');
model.func('dnn1').setEntry('descr', 'col5', 'Volumetric energy');
model.func('dnn1').setEntry('unit', 'col5', 'J/m^3');
model.func('dnn1').setEntry('funcs', 'col6', 'dnn_P_vol_ave');
model.func('dnn1').setEntry('descr', 'col6', 'Average volumetric power');
model.func('dnn1').setEntry('unit', 'col6', 'W/m^3');
model.func('dnn1').setIndex('layertype', 'dense', 0);
model.func('dnn1').setIndex('outfeatures', 1, 0);
model.func('dnn1').setIndex('activation', 'tanh', 0);
model.func('dnn1').setIndex('layerDescription', '', 0);
model.func('dnn1').setIndex('layertype', 'dense', 0);
model.func('dnn1').setIndex('outfeatures', 1, 0);
model.func('dnn1').setIndex('activation', 'tanh', 0);
model.func('dnn1').setIndex('layerDescription', '', 0);
model.func('dnn1').setIndex('outfeatures', '10', 0);
model.func('dnn1').setIndex('layertype', 'dense', 1);
model.func('dnn1').setIndex('outfeatures', 1, 1);
model.func('dnn1').setIndex('activation', 'tanh', 1);
model.func('dnn1').setIndex('layerDescription', '', 1);
model.func('dnn1').setIndex('layertype', 'dense', 1);
model.func('dnn1').setIndex('outfeatures', 1, 1);
model.func('dnn1').setIndex('activation', 'tanh', 1);
model.func('dnn1').setIndex('layerDescription', '', 1);
model.func('dnn1').setIndex('outfeatures', '10', 1);
model.func('dnn1').setIndex('layertype', 'dense', 2);
model.func('dnn1').setIndex('outfeatures', 1, 2);
model.func('dnn1').setIndex('activation', 'tanh', 2);
model.func('dnn1').setIndex('layerDescription', '', 2);
model.func('dnn1').setIndex('layertype', 'dense', 2);
model.func('dnn1').setIndex('outfeatures', 1, 2);
model.func('dnn1').setIndex('activation', 'tanh', 2);
model.func('dnn1').setIndex('layerDescription', '', 2);
model.func('dnn1').setIndex('outfeatures', '10', 2);
model.func('dnn1').setIndex('layertype', 'dense', 3);
model.func('dnn1').setIndex('outfeatures', 1, 3);
model.func('dnn1').setIndex('activation', 'tanh', 3);
model.func('dnn1').setIndex('layerDescription', '', 3);
model.func('dnn1').setIndex('layertype', 'dense', 3);
model.func('dnn1').setIndex('outfeatures', 1, 3);
model.func('dnn1').setIndex('activation', 'tanh', 3);
model.func('dnn1').setIndex('layerDescription', '', 3);
model.func('dnn1').setIndex('outfeatures', '10', 3);
model.func('dnn1').setIndex('layertype', 'dense', 4);
model.func('dnn1').setIndex('outfeatures', 1, 4);
model.func('dnn1').setIndex('activation', 'tanh', 4);
model.func('dnn1').setIndex('layerDescription', '', 4);
model.func('dnn1').setIndex('layertype', 'dense', 4);
model.func('dnn1').setIndex('outfeatures', 1, 4);
model.func('dnn1').setIndex('activation', 'tanh', 4);
model.func('dnn1').setIndex('layerDescription', '', 4);
model.func('dnn1').setIndex('outfeatures', '2', 4);
model.func('dnn1').setIndex('activation', 'none', 4);
model.func('dnn1').set('epochs', 20000);
model.func('dnn1').setIndex('plotaxis', false, 1);
model.func('dnn1').setIndex('plotfixedvalue', 'L_pos_app_init', 1);
model.func('dnn1').setIndex('plotaxis', false, 2);
model.func('dnn1').setIndex('plotfixedvalue', 'epss_neg_app_init', 2);
model.func('dnn1').setIndex('plotfixedvalue', 'epss_neg_app_init', 3);
model.func('dnn1').run;
model.func('dnn1').set('lr', '1e-4');
model.func('dnn1').continueRun;

model.study.create('std2');
model.study('std2').create('cdi', 'CurrentDistributionInitialization');
model.study('std2').feature('cdi').set('solnum', 'auto');
model.study('std2').feature('cdi').set('notsolnum', 'auto');
model.study('std2').feature('cdi').set('outputmap', {});
model.study('std2').feature('cdi').set('ngenAUX', '1');
model.study('std2').feature('cdi').set('goalngenAUX', '1');
model.study('std2').feature('cdi').set('ngenAUX', '1');
model.study('std2').feature('cdi').set('goalngenAUX', '1');
model.study('std2').feature('cdi').setSolveFor('/physics/liion', true);
model.study('std2').feature('cdi').setSolveFor('/physics/ge', true);
model.study('std2').feature('cdi').setSolveFor('/physics/ev', true);
model.study('std2').create('time', 'Transient');
model.study('std2').feature('time').set('plotgroup', 'Default');
model.study('std2').feature('time').set('initialtime', '0');
model.study('std2').feature('time').set('solnum', 'auto');
model.study('std2').feature('time').set('notsolnum', 'auto');
model.study('std2').feature('time').set('outputmap', {});
model.study('std2').feature('time').setSolveFor('/physics/liion', true);
model.study('std2').feature('time').setSolveFor('/physics/ge', true);
model.study('std2').feature('time').setSolveFor('/physics/ev', true);

model.geom('geom1').run;

model.study('std2').label('Study 2: App Computation');
model.study('std2').create('param', 'Parametric');
model.study('std2').feature('param').setIndex('pname', 'A_cell', 0);
model.study('std2').feature('param').setIndex('plistarr', '', 0);
model.study('std2').feature('param').setIndex('punit', 'm^2', 0);
model.study('std2').feature('param').setIndex('pname', 'A_cell', 0);
model.study('std2').feature('param').setIndex('plistarr', '', 0);
model.study('std2').feature('param').setIndex('punit', 'm^2', 0);
model.study('std2').feature('param').setIndex('pname', 'L_pos', 0);
model.study('std2').feature('param').setIndex('plistarr', 'L_pos_app_phys', 0);
model.study('std2').feature('param').setIndex('pname', 'A_cell', 1);
model.study('std2').feature('param').setIndex('plistarr', '', 1);
model.study('std2').feature('param').setIndex('punit', 'm^2', 1);
model.study('std2').feature('param').setIndex('pname', 'A_cell', 1);
model.study('std2').feature('param').setIndex('plistarr', '', 1);
model.study('std2').feature('param').setIndex('punit', 'm^2', 1);
model.study('std2').feature('param').setIndex('pname', 'epss_neg', 1);
model.study('std2').feature('param').setIndex('plistarr', 'epss_neg_app_phys', 1);
model.study('std2').feature('param').setIndex('pname', 'A_cell', 2);
model.study('std2').feature('param').setIndex('plistarr', '', 2);
model.study('std2').feature('param').setIndex('punit', 'm^2', 2);
model.study('std2').feature('param').setIndex('pname', 'A_cell', 2);
model.study('std2').feature('param').setIndex('plistarr', '', 2);
model.study('std2').feature('param').setIndex('punit', 'm^2', 2);
model.study('std2').feature('param').setIndex('pname', 'epss_pos', 2);
model.study('std2').feature('param').setIndex('plistarr', 'epss_pos_app_phys', 2);
model.study('std2').feature('time').set('tlist', '0 1000[h]');
model.study('std2').feature('time').set('useparam', true);
model.study('std2').feature('time').setIndex('pname', 'A_cell', 0);
model.study('std2').feature('time').setIndex('plistarr', '', 0);
model.study('std2').feature('time').setIndex('punit', 'm^2', 0);
model.study('std2').feature('time').setIndex('pname', 'A_cell', 0);
model.study('std2').feature('time').setIndex('plistarr', '', 0);
model.study('std2').feature('time').setIndex('punit', 'm^2', 0);
model.study('std2').feature('time').setIndex('pname', 'C_rate', 0);
model.study('std2').feature('time').setIndex('plistarr', '0.1 0.5 1 2 5 10', 0);

model.sol.create('sol5');
model.sol('sol5').study('std2');
model.sol('sol5').create('st1', 'StudyStep');
model.sol('sol5').feature('st1').set('study', 'std2');
model.sol('sol5').feature('st1').set('studystep', 'cdi');
model.sol('sol5').create('v1', 'Variables');
model.sol('sol5').feature('v1').feature('comp1_phil').set('scalemethod', 'manual');
model.sol('sol5').feature('v1').feature('comp1_phis').set('scalemethod', 'manual');
model.sol('sol5').feature('v1').feature('comp1_cl').set('scalemethod', 'manual');
model.sol('sol5').feature('v1').feature('comp1_phil').set('scaleval', '1');
model.sol('sol5').feature('v1').feature('comp1_phis').set('scaleval', '1');
model.sol('sol5').feature('v1').feature('comp1_cl').set('scaleval', '1000');
model.sol('sol5').feature('v1').set('control', 'cdi');
model.sol('sol5').create('s1', 'Stationary');
model.sol('sol5').feature('s1').set('stol', 1.0E-4);
model.sol('sol5').feature('s1').create('seDef', 'Segregated');
model.sol('sol5').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol5').feature('s1').feature('fc1').set('dtech', 'auto');
model.sol('sol5').feature('s1').feature('fc1').set('maxiter', 50);
model.sol('sol5').feature('s1').feature('fc1').set('minstep', 1.0E-6);
model.sol('sol5').feature('s1').create('d1', 'Direct');
model.sol('sol5').feature('s1').feature('d1').label('Direct (Merged)');
model.sol('sol5').feature('s1').create('i1', 'Iterative');
model.sol('sol5').feature('s1').feature('i1').set('maxlinit', 1000);
model.sol('sol5').feature('s1').feature('i1').set('nlinnormuse', 'on');
model.sol('sol5').feature('s1').feature('i1').label('Algebraic Multigrid (liion)');
model.sol('sol5').feature('s1').feature('i1').create('mg1', 'Multigrid');
model.sol('sol5').feature('s1').feature('i1').feature('mg1').set('prefun', 'saamg');
model.sol('sol5').feature('s1').feature('i1').feature('mg1').set('maxcoarsedof', 50000);
model.sol('sol5').feature('s1').feature('i1').feature('mg1').set('saamgcompwise', true);
model.sol('sol5').feature('s1').feature('i1').feature('mg1').set('compactaggregation', true);
model.sol('sol5').feature('s1').feature('i1').feature('mg1').feature('pr').create('sl1', 'SORLine');
model.sol('sol5').feature('s1').feature('i1').feature('mg1').feature('po').create('sl1', 'SORLine');
model.sol('sol5').feature('s1').feature('i1').feature('mg1').feature('cs').create('d1', 'Direct');
model.sol('sol5').feature('s1').feature('i1').feature('mg1').feature('cs').feature('d1').set('linsolver', 'pardiso');
model.sol('sol5').feature('s1').create('i2', 'Iterative');
model.sol('sol5').feature('s1').feature('i2').set('maxlinit', 1000);
model.sol('sol5').feature('s1').feature('i2').set('nlinnormuse', 'on');
model.sol('sol5').feature('s1').feature('i2').label('Geometric Multigrid (liion)');
model.sol('sol5').feature('s1').feature('i2').create('mg1', 'Multigrid');
model.sol('sol5').feature('s1').feature('i2').feature('mg1').feature('pr').create('sl1', 'SORLine');
model.sol('sol5').feature('s1').feature('i2').feature('mg1').feature('po').create('sl1', 'SORLine');
model.sol('sol5').feature('s1').feature('i2').feature('mg1').feature('cs').create('d1', 'Direct');
model.sol('sol5').feature('s1').feature('i2').feature('mg1').feature('cs').feature('d1').set('linsolver', 'pardiso');
model.sol('sol5').feature('s1').feature('fc1').set('linsolver', 'd1');
model.sol('sol5').feature('s1').feature('fc1').set('dtech', 'auto');
model.sol('sol5').feature('s1').feature('fc1').set('maxiter', 50);
model.sol('sol5').feature('s1').feature('fc1').set('minstep', 1.0E-6);
model.sol('sol5').feature('s1').feature.remove('fcDef');
model.sol('sol5').feature('s1').feature.remove('seDef');
model.sol('sol5').create('su1', 'StoreSolution');
model.sol('sol5').create('st2', 'StudyStep');
model.sol('sol5').feature('st2').set('study', 'std2');
model.sol('sol5').feature('st2').set('studystep', 'time');
model.sol('sol5').create('v2', 'Variables');
model.sol('sol5').feature('v2').feature('comp1_phil').set('scalemethod', 'manual');
model.sol('sol5').feature('v2').feature('comp1_liion_pce1_csfast').set('scalemethod', 'manual');
model.sol('sol5').feature('v2').feature('comp1_liion_pce2_csfast').set('scalemethod', 'manual');
model.sol('sol5').feature('v2').feature('comp1_phis').set('scalemethod', 'manual');
model.sol('sol5').feature('v2').feature('comp1_cl').set('scalemethod', 'manual');
model.sol('sol5').feature('v2').feature('comp1_phil').set('scaleval', '1');
model.sol('sol5').feature('v2').feature('comp1_liion_pce1_csfast').set('scaleval', '10000');
model.sol('sol5').feature('v2').feature('comp1_liion_pce2_csfast').set('scaleval', '10000');
model.sol('sol5').feature('v2').feature('comp1_phis').set('scaleval', '1');
model.sol('sol5').feature('v2').feature('comp1_cl').set('scaleval', '1000');
model.sol('sol5').feature('v2').set('initmethod', 'sol');
model.sol('sol5').feature('v2').set('initsol', 'sol5');
model.sol('sol5').feature('v2').set('initsoluse', 'sol6');
model.sol('sol5').feature('v2').set('notsolmethod', 'sol');
model.sol('sol5').feature('v2').set('notsol', 'sol5');
model.sol('sol5').feature('v2').set('notsoluse', 'sol6');
model.sol('sol5').feature('v2').set('control', 'time');
model.sol('sol5').create('t1', 'Time');
model.sol('sol5').feature('t1').set('tlist', '0 1000[h]');
model.sol('sol5').feature('t1').set('plot', 'off');
model.sol('sol5').feature('t1').set('plotgroup', 'Default');
model.sol('sol5').feature('t1').set('plotfreq', 'tout');
model.sol('sol5').feature('t1').set('probesel', 'all');
model.sol('sol5').feature('t1').set('probes', {'point1'});
model.sol('sol5').feature('t1').set('probefreq', 'tsteps');
model.sol('sol5').feature('t1').set('rtol', 0.001);
model.sol('sol5').feature('t1').set('atolglobalvaluemethod', 'factor');
model.sol('sol5').feature('t1').set('eventout', true);
model.sol('sol5').feature('t1').set('reacf', true);
model.sol('sol5').feature('t1').set('storeudot', true);
model.sol('sol5').feature('t1').set('endtimeinterpolation', true);
model.sol('sol5').feature('t1').set('maxorder', 2);
model.sol('sol5').feature('t1').set('initialstepbdfactive', true);
model.sol('sol5').feature('t1').set('initialstepbdf', '(1)[s]');
model.sol('sol5').feature('t1').create('tp1', 'TimeParametric');
model.sol('sol5').feature('t1').feature.remove('tpDef');
model.sol('sol5').feature('t1').feature('tp1').set('control', 'time');
model.sol('sol5').feature('t1').set('control', 'time');
model.sol('sol5').feature('t1').feature('aDef').set('cachepattern', true);
model.sol('sol5').feature('t1').create('seDef', 'Segregated');
model.sol('sol5').feature('t1').create('fc1', 'FullyCoupled');
model.sol('sol5').feature('t1').feature('fc1').set('dtech', 'auto');
model.sol('sol5').feature('t1').create('d1', 'Direct');
model.sol('sol5').feature('t1').feature('d1').label('Direct (Merged)');
model.sol('sol5').feature('t1').create('i1', 'Iterative');
model.sol('sol5').feature('t1').feature('i1').set('maxlinit', 1000);
model.sol('sol5').feature('t1').feature('i1').set('nlinnormuse', 'on');
model.sol('sol5').feature('t1').feature('i1').label('Algebraic Multigrid (liion)');
model.sol('sol5').feature('t1').feature('i1').create('mg1', 'Multigrid');
model.sol('sol5').feature('t1').feature('i1').feature('mg1').set('prefun', 'saamg');
model.sol('sol5').feature('t1').feature('i1').feature('mg1').set('maxcoarsedof', 50000);
model.sol('sol5').feature('t1').feature('i1').feature('mg1').set('saamgcompwise', true);
model.sol('sol5').feature('t1').feature('i1').feature('mg1').set('compactaggregation', true);
model.sol('sol5').feature('t1').feature('i1').feature('mg1').feature('pr').create('sl1', 'SORLine');
model.sol('sol5').feature('t1').feature('i1').feature('mg1').feature('po').create('sl1', 'SORLine');
model.sol('sol5').feature('t1').feature('i1').feature('mg1').feature('cs').create('d1', 'Direct');
model.sol('sol5').feature('t1').feature('i1').feature('mg1').feature('cs').feature('d1').set('linsolver', 'pardiso');
model.sol('sol5').feature('t1').create('i2', 'Iterative');
model.sol('sol5').feature('t1').feature('i2').set('maxlinit', 1000);
model.sol('sol5').feature('t1').feature('i2').set('nlinnormuse', 'on');
model.sol('sol5').feature('t1').feature('i2').label('Geometric Multigrid (liion)');
model.sol('sol5').feature('t1').feature('i2').create('mg1', 'Multigrid');
model.sol('sol5').feature('t1').feature('i2').feature('mg1').feature('pr').create('sl1', 'SORLine');
model.sol('sol5').feature('t1').feature('i2').feature('mg1').feature('po').create('sl1', 'SORLine');
model.sol('sol5').feature('t1').feature('i2').feature('mg1').feature('cs').create('d1', 'Direct');
model.sol('sol5').feature('t1').feature('i2').feature('mg1').feature('cs').feature('d1').set('linsolver', 'pardiso');
model.sol('sol5').feature('t1').feature('fc1').set('linsolver', 'd1');
model.sol('sol5').feature('t1').feature('fc1').set('dtech', 'auto');
model.sol('sol5').feature('t1').feature.remove('fcDef');
model.sol('sol5').feature('t1').feature.remove('seDef');
model.sol('sol5').attach('std2');

model.batch.create('p1', 'Parametric');
model.batch('p1').study('std2');
model.batch('p1').create('so1', 'Solutionseq');
model.batch('p1').feature('so1').set('seq', 'sol5');
model.batch('p1').feature('so1').set('store', 'on');
model.batch('p1').feature('so1').set('clear', 'on');
model.batch('p1').feature('so1').set('psol', 'none');
model.batch('p1').set('pname', {'L_pos' 'epss_neg' 'epss_pos'});
model.batch('p1').set('plistarr', {'L_pos_app_phys' 'epss_neg_app_phys' 'epss_pos_app_phys'});
model.batch('p1').set('sweeptype', 'sparse');
model.batch('p1').set('probesel', 'all');
model.batch('p1').set('probes', {'point1'});
model.batch('p1').set('plot', 'off');
model.batch('p1').set('err', 'on');
model.batch('p1').attach('std2');
model.batch('p1').set('control', 'param');

model.sol('sol5').feature('t1').create('st1', 'StopCondition');
model.sol('sol5').feature('t1').feature('st1').set('eventstopName', {'comp1.ev.impl1.event'});
model.sol('sol5').feature('t1').feature('st1').set('eventstopActive', {'off'});
model.sol('sol5').feature('t1').feature('st1').setIndex('eventstopActive', true, 0);
model.sol('sol5').feature('t1').feature('st1').set('storestopcondsol', 'stepafter');
model.sol('sol5').feature('t1').feature('st1').set('stopcondwarn', false);

model.study('std2').feature('cdi').setEntry('activate', 'ge', false);
model.study('std2').setGenPlots(false);

model.sol.create('sol7');
model.sol('sol7').study('std2');
model.sol('sol7').label('Parametric Solutions 2');

model.batch('p1').feature('so1').set('psol', 'sol7');

model.probe('point1').genResult('none');

model.batch('p1').run('compute');

model.study.create('std3');
model.study('std3').create('cdi', 'CurrentDistributionInitialization');
model.study('std3').feature('cdi').set('solnum', 'auto');
model.study('std3').feature('cdi').set('notsolnum', 'auto');
model.study('std3').feature('cdi').set('outputmap', {});
model.study('std3').feature('cdi').set('ngenAUX', '1');
model.study('std3').feature('cdi').set('goalngenAUX', '1');
model.study('std3').feature('cdi').set('ngenAUX', '1');
model.study('std3').feature('cdi').set('goalngenAUX', '1');
model.study('std3').feature('cdi').setSolveFor('/physics/liion', true);
model.study('std3').feature('cdi').setSolveFor('/physics/ge', true);
model.study('std3').feature('cdi').setSolveFor('/physics/ev', true);
model.study('std3').create('time', 'Transient');
model.study('std3').feature('time').set('plotgroup', 'Default');
model.study('std3').feature('time').set('initialtime', '0');
model.study('std3').feature('time').set('solnum', 'auto');
model.study('std3').feature('time').set('notsolnum', 'auto');
model.study('std3').feature('time').set('outputmap', {});
model.study('std3').feature('time').setSolveFor('/physics/liion', true);
model.study('std3').feature('time').setSolveFor('/physics/ge', true);
model.study('std3').feature('time').setSolveFor('/physics/ev', true);
model.study('std3').label('Study 3: Surrogate Model Helper Study');
model.study('std3').create('param', 'Parametric');
model.study('std3').feature('param').setIndex('pname', 'A_cell', 0);
model.study('std3').feature('param').setIndex('plistarr', '', 0);
model.study('std3').feature('param').setIndex('punit', 'm^2', 0);
model.study('std3').feature('param').setIndex('pname', 'A_cell', 0);
model.study('std3').feature('param').setIndex('plistarr', '', 0);
model.study('std3').feature('param').setIndex('punit', 'm^2', 0);
model.study('std3').feature('param').setIndex('pname', 'L_pos', 0);
model.study('std3').feature('param').setIndex('plistarr', 'L_pos_app_phys', 0);
model.study('std3').feature('param').setIndex('pname', 'A_cell', 1);
model.study('std3').feature('param').setIndex('plistarr', '', 1);
model.study('std3').feature('param').setIndex('punit', 'm^2', 1);
model.study('std3').feature('param').setIndex('pname', 'A_cell', 1);
model.study('std3').feature('param').setIndex('plistarr', '', 1);
model.study('std3').feature('param').setIndex('punit', 'm^2', 1);
model.study('std3').feature('param').setIndex('pname', 'epss_neg', 1);
model.study('std3').feature('param').setIndex('plistarr', 'epss_neg_app_phys', 1);
model.study('std3').feature('param').setIndex('pname', 'A_cell', 2);
model.study('std3').feature('param').setIndex('plistarr', '', 2);
model.study('std3').feature('param').setIndex('punit', 'm^2', 2);
model.study('std3').feature('param').setIndex('pname', 'A_cell', 2);
model.study('std3').feature('param').setIndex('plistarr', '', 2);
model.study('std3').feature('param').setIndex('punit', 'm^2', 2);
model.study('std3').feature('param').setIndex('pname', 'epss_pos', 2);
model.study('std3').feature('param').setIndex('plistarr', 'epss_pos_app_phys', 2);
model.study('std3').feature('time').set('tlist', '0 10[s]');
model.study('std3').feature('time').set('useparam', true);
model.study('std3').feature('time').setIndex('pname', 'A_cell', 0);
model.study('std3').feature('time').setIndex('plistarr', '', 0);
model.study('std3').feature('time').setIndex('punit', 'm^2', 0);
model.study('std3').feature('time').setIndex('pname', 'A_cell', 0);
model.study('std3').feature('time').setIndex('plistarr', '', 0);
model.study('std3').feature('time').setIndex('punit', 'm^2', 0);
model.study('std3').feature('time').setIndex('pname', 'C_rate', 0);
model.study('std3').feature('time').setIndex('plistarr', '0.1 0.5 1 2 5 10', 0);

model.sol.create('sol9');
model.sol('sol9').study('std3');
model.sol('sol9').create('st1', 'StudyStep');
model.sol('sol9').feature('st1').set('study', 'std3');
model.sol('sol9').feature('st1').set('studystep', 'cdi');
model.sol('sol9').create('v1', 'Variables');
model.sol('sol9').feature('v1').feature('comp1_phil').set('scalemethod', 'manual');
model.sol('sol9').feature('v1').feature('comp1_phis').set('scalemethod', 'manual');
model.sol('sol9').feature('v1').feature('comp1_cl').set('scalemethod', 'manual');
model.sol('sol9').feature('v1').feature('comp1_phil').set('scaleval', '1');
model.sol('sol9').feature('v1').feature('comp1_phis').set('scaleval', '1');
model.sol('sol9').feature('v1').feature('comp1_cl').set('scaleval', '1000');
model.sol('sol9').feature('v1').set('control', 'cdi');
model.sol('sol9').create('s1', 'Stationary');
model.sol('sol9').feature('s1').set('stol', 1.0E-4);
model.sol('sol9').feature('s1').create('seDef', 'Segregated');
model.sol('sol9').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol9').feature('s1').feature('fc1').set('dtech', 'auto');
model.sol('sol9').feature('s1').feature('fc1').set('maxiter', 50);
model.sol('sol9').feature('s1').feature('fc1').set('minstep', 1.0E-6);
model.sol('sol9').feature('s1').create('d1', 'Direct');
model.sol('sol9').feature('s1').feature('d1').label('Direct (Merged)');
model.sol('sol9').feature('s1').create('i1', 'Iterative');
model.sol('sol9').feature('s1').feature('i1').set('maxlinit', 1000);
model.sol('sol9').feature('s1').feature('i1').set('nlinnormuse', 'on');
model.sol('sol9').feature('s1').feature('i1').label('Algebraic Multigrid (liion)');
model.sol('sol9').feature('s1').feature('i1').create('mg1', 'Multigrid');
model.sol('sol9').feature('s1').feature('i1').feature('mg1').set('prefun', 'saamg');
model.sol('sol9').feature('s1').feature('i1').feature('mg1').set('maxcoarsedof', 50000);
model.sol('sol9').feature('s1').feature('i1').feature('mg1').set('saamgcompwise', true);
model.sol('sol9').feature('s1').feature('i1').feature('mg1').set('compactaggregation', true);
model.sol('sol9').feature('s1').feature('i1').feature('mg1').feature('pr').create('sl1', 'SORLine');
model.sol('sol9').feature('s1').feature('i1').feature('mg1').feature('po').create('sl1', 'SORLine');
model.sol('sol9').feature('s1').feature('i1').feature('mg1').feature('cs').create('d1', 'Direct');
model.sol('sol9').feature('s1').feature('i1').feature('mg1').feature('cs').feature('d1').set('linsolver', 'pardiso');
model.sol('sol9').feature('s1').create('i2', 'Iterative');
model.sol('sol9').feature('s1').feature('i2').set('maxlinit', 1000);
model.sol('sol9').feature('s1').feature('i2').set('nlinnormuse', 'on');
model.sol('sol9').feature('s1').feature('i2').label('Geometric Multigrid (liion)');
model.sol('sol9').feature('s1').feature('i2').create('mg1', 'Multigrid');
model.sol('sol9').feature('s1').feature('i2').feature('mg1').feature('pr').create('sl1', 'SORLine');
model.sol('sol9').feature('s1').feature('i2').feature('mg1').feature('po').create('sl1', 'SORLine');
model.sol('sol9').feature('s1').feature('i2').feature('mg1').feature('cs').create('d1', 'Direct');
model.sol('sol9').feature('s1').feature('i2').feature('mg1').feature('cs').feature('d1').set('linsolver', 'pardiso');
model.sol('sol9').feature('s1').feature('fc1').set('linsolver', 'd1');
model.sol('sol9').feature('s1').feature('fc1').set('dtech', 'auto');
model.sol('sol9').feature('s1').feature('fc1').set('maxiter', 50);
model.sol('sol9').feature('s1').feature('fc1').set('minstep', 1.0E-6);
model.sol('sol9').feature('s1').feature.remove('fcDef');
model.sol('sol9').feature('s1').feature.remove('seDef');
model.sol('sol9').create('su1', 'StoreSolution');
model.sol('sol9').create('st2', 'StudyStep');
model.sol('sol9').feature('st2').set('study', 'std3');
model.sol('sol9').feature('st2').set('studystep', 'time');
model.sol('sol9').create('v2', 'Variables');
model.sol('sol9').feature('v2').feature('comp1_phil').set('scalemethod', 'manual');
model.sol('sol9').feature('v2').feature('comp1_liion_pce1_csfast').set('scalemethod', 'manual');
model.sol('sol9').feature('v2').feature('comp1_liion_pce2_csfast').set('scalemethod', 'manual');
model.sol('sol9').feature('v2').feature('comp1_phis').set('scalemethod', 'manual');
model.sol('sol9').feature('v2').feature('comp1_cl').set('scalemethod', 'manual');
model.sol('sol9').feature('v2').feature('comp1_phil').set('scaleval', '1');
model.sol('sol9').feature('v2').feature('comp1_liion_pce1_csfast').set('scaleval', '10000');
model.sol('sol9').feature('v2').feature('comp1_liion_pce2_csfast').set('scaleval', '10000');
model.sol('sol9').feature('v2').feature('comp1_phis').set('scaleval', '1');
model.sol('sol9').feature('v2').feature('comp1_cl').set('scaleval', '1000');
model.sol('sol9').feature('v2').set('initmethod', 'sol');
model.sol('sol9').feature('v2').set('initsol', 'sol9');
model.sol('sol9').feature('v2').set('initsoluse', 'sol10');
model.sol('sol9').feature('v2').set('notsolmethod', 'sol');
model.sol('sol9').feature('v2').set('notsol', 'sol9');
model.sol('sol9').feature('v2').set('notsoluse', 'sol10');
model.sol('sol9').feature('v2').set('control', 'time');
model.sol('sol9').create('t1', 'Time');
model.sol('sol9').feature('t1').set('tlist', '0 10[s]');
model.sol('sol9').feature('t1').set('plot', 'off');
model.sol('sol9').feature('t1').set('plotgroup', 'Default');
model.sol('sol9').feature('t1').set('plotfreq', 'tout');
model.sol('sol9').feature('t1').set('probesel', 'all');
model.sol('sol9').feature('t1').set('probes', {'point1'});
model.sol('sol9').feature('t1').set('probefreq', 'tsteps');
model.sol('sol9').feature('t1').set('rtol', 0.001);
model.sol('sol9').feature('t1').set('atolglobalvaluemethod', 'factor');
model.sol('sol9').feature('t1').set('eventout', true);
model.sol('sol9').feature('t1').set('reacf', true);
model.sol('sol9').feature('t1').set('storeudot', true);
model.sol('sol9').feature('t1').set('endtimeinterpolation', true);
model.sol('sol9').feature('t1').set('maxorder', 2);
model.sol('sol9').feature('t1').set('initialstepbdfactive', true);
model.sol('sol9').feature('t1').set('initialstepbdf', '(1)[s]');
model.sol('sol9').feature('t1').create('tp1', 'TimeParametric');
model.sol('sol9').feature('t1').feature.remove('tpDef');
model.sol('sol9').feature('t1').feature('tp1').set('control', 'time');
model.sol('sol9').feature('t1').set('control', 'time');
model.sol('sol9').feature('t1').feature('aDef').set('cachepattern', true);
model.sol('sol9').feature('t1').create('seDef', 'Segregated');
model.sol('sol9').feature('t1').create('fc1', 'FullyCoupled');
model.sol('sol9').feature('t1').feature('fc1').set('dtech', 'auto');
model.sol('sol9').feature('t1').create('d1', 'Direct');
model.sol('sol9').feature('t1').feature('d1').label('Direct (Merged)');
model.sol('sol9').feature('t1').create('i1', 'Iterative');
model.sol('sol9').feature('t1').feature('i1').set('maxlinit', 1000);
model.sol('sol9').feature('t1').feature('i1').set('nlinnormuse', 'on');
model.sol('sol9').feature('t1').feature('i1').label('Algebraic Multigrid (liion)');
model.sol('sol9').feature('t1').feature('i1').create('mg1', 'Multigrid');
model.sol('sol9').feature('t1').feature('i1').feature('mg1').set('prefun', 'saamg');
model.sol('sol9').feature('t1').feature('i1').feature('mg1').set('maxcoarsedof', 50000);
model.sol('sol9').feature('t1').feature('i1').feature('mg1').set('saamgcompwise', true);
model.sol('sol9').feature('t1').feature('i1').feature('mg1').set('compactaggregation', true);
model.sol('sol9').feature('t1').feature('i1').feature('mg1').feature('pr').create('sl1', 'SORLine');
model.sol('sol9').feature('t1').feature('i1').feature('mg1').feature('po').create('sl1', 'SORLine');
model.sol('sol9').feature('t1').feature('i1').feature('mg1').feature('cs').create('d1', 'Direct');
model.sol('sol9').feature('t1').feature('i1').feature('mg1').feature('cs').feature('d1').set('linsolver', 'pardiso');
model.sol('sol9').feature('t1').create('i2', 'Iterative');
model.sol('sol9').feature('t1').feature('i2').set('maxlinit', 1000);
model.sol('sol9').feature('t1').feature('i2').set('nlinnormuse', 'on');
model.sol('sol9').feature('t1').feature('i2').label('Geometric Multigrid (liion)');
model.sol('sol9').feature('t1').feature('i2').create('mg1', 'Multigrid');
model.sol('sol9').feature('t1').feature('i2').feature('mg1').feature('pr').create('sl1', 'SORLine');
model.sol('sol9').feature('t1').feature('i2').feature('mg1').feature('po').create('sl1', 'SORLine');
model.sol('sol9').feature('t1').feature('i2').feature('mg1').feature('cs').create('d1', 'Direct');
model.sol('sol9').feature('t1').feature('i2').feature('mg1').feature('cs').feature('d1').set('linsolver', 'pardiso');
model.sol('sol9').feature('t1').feature('fc1').set('linsolver', 'd1');
model.sol('sol9').feature('t1').feature('fc1').set('dtech', 'auto');
model.sol('sol9').feature('t1').feature.remove('fcDef');
model.sol('sol9').feature('t1').feature.remove('seDef');
model.sol('sol9').attach('std3');

model.batch.create('p2', 'Parametric');
model.batch('p2').study('std3');
model.batch('p2').create('so1', 'Solutionseq');
model.batch('p2').feature('so1').set('seq', 'sol9');
model.batch('p2').feature('so1').set('store', 'on');
model.batch('p2').feature('so1').set('clear', 'on');
model.batch('p2').feature('so1').set('psol', 'none');
model.batch('p2').set('pname', {'L_pos' 'epss_neg' 'epss_pos'});
model.batch('p2').set('plistarr', {'L_pos_app_phys' 'epss_neg_app_phys' 'epss_pos_app_phys'});
model.batch('p2').set('sweeptype', 'sparse');
model.batch('p2').set('probesel', 'all');
model.batch('p2').set('probes', {'point1'});
model.batch('p2').set('plot', 'off');
model.batch('p2').set('err', 'on');
model.batch('p2').attach('std3');
model.batch('p2').set('control', 'param');

model.sol('sol9').feature('t1').create('st1', 'StopCondition');
model.sol('sol9').feature('t1').feature('st1').set('eventstopName', {'comp1.ev.impl1.event'});
model.sol('sol9').feature('t1').feature('st1').set('eventstopActive', {'off'});
model.sol('sol9').feature('t1').feature('st1').setIndex('eventstopActive', true, 0);
model.sol('sol9').feature('t1').feature('st1').set('storestopcondsol', 'stepafter');
model.sol('sol9').feature('t1').feature('st1').set('stopcondwarn', false);

model.study('std3').feature('cdi').setEntry('activate', 'ge', false);
model.study('std3').setGenPlots(false);

model.sol.create('sol11');
model.sol('sol11').study('std3');
model.sol('sol11').label('Parametric Solutions 3');

model.batch('p2').feature('so1').set('psol', 'sol11');

model.probe('point1').genResult('none');

model.batch('p2').run('compute');

% To import content from file, use:
% model.result.param.loadFile('FILENAME');
model.result.param.set('L_pos_app', 'L_pos_app_init', 'Positive electrode thickness, used as input for surrogate model');
model.result.param.set('epss_neg_app', 'epss_neg_app_init', 'Negative electrode active material volume fraction, used as input for surrogate model');
model.result.param.set('epss_pos_app', 'epss_neg_app_init', 'Positive electrode active material volume fraction, used as input for surrogate model');
model.result.param.set('Q_pos_app', 'F_const*(1-0.1)*epss_pos_app*cs_max_pos', 'Host capacity, positive electrode');
model.result.param.set('q_pos_app', 'Q_pos_app*L_pos_app*epss_pos_app', 'Approximate actual electrode areal capacity, positive electrode');
model.result.param.set('q_cell_app', 'q_pos_app', 'Approximate cell areal capacity');
model.result.param.set('L_neg_app', '(1-0.1)*epss_pos_app*cs_max_pos*L_pos_app/(0.8*epss_neg_app*cs_max_neg)', 'Negative electrode thickness');
model.result.create('pg2', 'PlotGroup1D');
model.result('pg2').run;
model.result('pg2').label('Ragone Plots for NMC111/Graphite Li-ion Batteries');
model.result('pg2').set('titletype', 'label');
model.result('pg2').setIndex('looplevelinput', 'last', 0);
model.result('pg2').set('xlabelactive', true);
model.result('pg2').set('xlabel', 'Average Volumetric Power (W/dm<sup>3</sup>)');
model.result('pg2').set('ylabelactive', true);
model.result('pg2').set('ylabel', 'Volumetric Energy (Wh/dm<sup>3</sup>)');
model.result('pg2').set('axislimits', true);
model.result('pg2').set('xmin', 'xmin');
model.result('pg2').set('xmax', 'xmax');
model.result('pg2').set('ymin', 'ymin');
model.result('pg2').set('ymax', 'ymax');
model.result('pg2').set('xlog', true);
model.result('pg2').set('ylog', true);
model.result('pg2').set('legendpos', 'lowerleft');
model.result('pg2').set('legendmaxwidthinside', 0.9);
model.result.create('pg3', 'PlotGroup1D');
model.result('pg3').run;
model.result('pg2').run;
model.result('pg2').create('glob1', 'Global');
model.result('pg2').feature('glob1').set('markerpos', 'datapoints');
model.result('pg2').feature('glob1').set('linewidth', 'preference');
model.result('pg2').feature('glob1').label('Physics');
model.result('pg2').feature('glob1').set('data', 'dset5');
model.result('pg2').feature('glob1').setIndex('looplevelinput', 'last', 0);
model.result('pg2').feature('glob1').setIndex('expr', 'W/(L_neg+L_sep+L_pos+L_ccs/2)', 0);
model.result('pg2').feature('glob1').setIndex('unit', 'W*h/dm^3', 0);
model.result('pg2').feature('glob1').setIndex('descr', 'Volumetric Energy', 0);
model.result('pg2').feature('glob1').set('xdatasolnumtype', 'all');
model.result('pg2').feature('glob1').set('xdata', 'expr');
model.result('pg2').feature('glob1').set('xdataexpr', 'W/t/(L_neg+L_sep+L_pos+L_ccs/2)');
model.result('pg2').feature('glob1').set('xdataunit', 'W/dm^3');
model.result('pg2').feature('glob1').set('xdatadescractive', true);
model.result('pg2').feature('glob1').set('xdatadescr', 'Average Volumetric Power');
model.result('pg2').feature('glob1').set('linecolor', 'blue');
model.result('pg2').feature('glob1').set('autoplotlabel', true);
model.result('pg2').feature('glob1').set('autosolution', false);
model.result('pg2').feature('glob1').set('autodescr', false);
model.result('pg2').feature('glob1').set('legendsuffix', ', L<sub>pos</sub>=eval(L_pos, um) um, eps<sub>s,neg</sub>=eval(epss_neg), eps<sub>s,pos</sub>=eval(epss_pos)');
model.result('pg2').feature('glob1').active(false);
model.result('pg2').run;
model.result('pg2').create('glob2', 'Global');
model.result('pg2').feature('glob2').set('markerpos', 'datapoints');
model.result('pg2').feature('glob2').set('linewidth', 'preference');
model.result('pg2').feature('glob2').label('Preview, Surrogate Model');
model.result('pg2').feature('glob2').set('data', 'dset8');
model.result('pg2').feature('glob2').setIndex('looplevelinput', 'last', 0);
model.result('pg2').feature('glob2').setIndex('expr', 'dnn_E_vol(C_rate, L_pos_app, epss_neg_app, epss_pos_app)', 0);
model.result('pg2').feature('glob2').setIndex('unit', 'W*h/dm^3', 0);
model.result('pg2').feature('glob2').set('xdata', 'expr');
model.result('pg2').feature('glob2').set('xdatasolnumtype', 'all');
model.result('pg2').feature('glob2').set('xdataexpr', 'dnn_P_vol_ave(C_rate, L_pos_app, epss_neg_app, epss_pos_app)');
model.result('pg2').feature('glob2').set('xdataunit', 'W/dm^3');
model.result('pg2').feature('glob2').set('linestyle', 'dashed');
model.result('pg2').feature('glob2').set('linecolor', 'red');
model.result('pg2').feature('glob2').set('linemarker', 'star');
model.result('pg2').feature('glob2').set('autodescr', false);
model.result('pg2').feature('glob2').set('autosolution', false);
model.result('pg2').feature('glob2').set('autoplotlabel', true);
model.result('pg2').run;
model.result('pg2').run;
model.result('pg3').run;
model.result.remove('pg3');
model.result.evaluationGroup.create('eg1', 'EvaluationGroup');
model.result.evaluationGroup('eg1').label('Evaluation Group: Data for Improve Surrogate Model');
model.result.evaluationGroup('eg1').set('data', 'dset7');
model.result.evaluationGroup('eg1').setIndex('looplevelinput', 'last', 2);
model.result.evaluationGroup('eg1').setIndex('looplevelinput', 'last', 0);
model.result.evaluationGroup('eg1').create('gev1', 'EvalGlobal');
model.result.evaluationGroup('eg1').feature('gev1').setIndex('expr', 'P_vol_ave', 0);
model.result.evaluationGroup('eg1').feature('gev1').setIndex('expr', 'E_vol', 1);
model.result.report.create('rpt1', 'Report');
model.result.report('rpt1').set('format', 'docx');
model.result.report('rpt1').set('filename', 'user:///lib_rate_capability_surrogate.docx');
model.result.report('rpt1').set('imagesize', 'large');
model.result.report('rpt1').feature.create('tp1', 'TitlePage');
model.result.report('rpt1').feature('tp1').label('Rate capability of an NMC111/Graphite Li-ion Battery');
model.result.report('rpt1').feature('tp1').set('frontmatterlayout', 'headings');
model.result.report('rpt1').feature('tp1').set('includecompany', false);
model.result.report('rpt1').feature('tp1').set('includeversion', false);
model.result.report('rpt1').feature('tp1').set('summary', 'This app demonstrates the usage of a surrogate model function for predicting the rate capability of an NMC111/graphite battery cell. The rate capability is shown in a Ragone plot. The surrogate function, a Deep Neural Network, has been fitted to a subset of the possible input data values. Three input data values can be set: the thickness of the negative electrode, the active material volume fraction of the negative electrode, and the active material volume fraction of the positive electrode. The low computational cost of evaluating the surrogate function allows sliders to be used to interactively adjust the input values and predict the Ragone plot for any combination of input values. Once a promising combination of values has been identified, the actual physical Li-ion battery model can be computed for those input values, to verify the predictions of the surrogate models. In addition, the then computed physical data can be used to further improve the surrogate model.');
model.result.report('rpt1').feature.create('toc1', 'TableOfContents');
model.result.report('rpt1').feature.create('sec1', 'Section');
model.result.report('rpt1').feature('sec1').label('Software Information');
model.result.report('rpt1').feature('sec1').feature.create('root1', 'Model');
model.result.report('rpt1').feature('sec1').feature('root1').label('Software Properties from Root');
model.result.report('rpt1').feature('sec1').feature('root1').set('includepath', false);
model.result.report('rpt1').feature.create('sec2', 'Section');
model.result.report('rpt1').feature('sec2').label('Input Data');
model.result.report('rpt1').feature('sec2').feature.create('head1', 'Heading');
model.result.report('rpt1').feature('sec2').feature('head1').label('Input Parameters for Li-Ion Battery Physical Model');
model.result.report('rpt1').feature('sec2').feature('head1').set('text', 'Input Parameters for Li-Ion Battery Physical Model');
model.result.report('rpt1').feature('sec2').feature.create('param1', 'Parameter');
model.result.report('rpt1').feature('sec2').feature('param1').label('Parameters for Embedded Model');
model.result.report('rpt1').feature('sec2').feature.create('var1', 'Variables');
model.result.report('rpt1').feature('sec2').feature('var1').label('Variables for Physics-Based Model');
model.result.report('rpt1').feature('sec2').feature.duplicate('var2', 'var1');
model.result.report('rpt1').feature('sec2').feature('var2').label('Variables for Surrogate Model');
model.result.report('rpt1').feature('sec2').feature('var2').set('noderef', 'var2');
model.result.report('rpt1').feature('sec2').feature.create('head2', 'Heading');
model.result.report('rpt1').feature('sec2').feature('head2').set('text', 'Generation of Input Data for Fitting the Surrogate Model');
model.result.report('rpt1').feature('sec2').feature.create('txt1', 'Text');
model.result.report('rpt1').feature('sec2').feature('txt1').set('text', 'The first study in the model is used to generate training data for the surrogate model. The settings used, and the generated data, are shown in the current section.');
model.result.report('rpt1').feature('sec2').feature.create('std1', 'Study');
model.result.report('rpt1').feature('sec2').feature('std1').setIndex('children', false, 1, 1);
model.result.report('rpt1').feature('sec2').feature('std1').setIndex('children', false, 2, 1);
model.result.report('rpt1').feature('sec2').feature('std1').setIndex('children', true, 2, 1);
model.result.report('rpt1').feature('sec2').feature('std1').setIndex('children', true, 1, 1);
model.result.report('rpt1').feature('sec2').feature.create('mtbl1', 'Table');
model.result.report('rpt1').feature('sec2').feature('mtbl1').label('Data Used for Fitting Surrogate Models');
model.result.report('rpt1').feature.create('sec3', 'Section');
model.result.report('rpt1').feature('sec3').label('Surrogate Model');
model.result.report('rpt1').feature('sec3').feature.create('txt1', 'Text');
model.result.report('rpt1').feature('sec3').feature('txt1').set('text', 'The current section shows the options used to train the surrogate model. It also shows an example of the predicted volumetric energy versus the C-rate.');
model.result.report('rpt1').feature('sec3').feature.create('func1', 'Functions');
model.result.report('rpt1').feature.create('sec4', 'Section');
model.result.report('rpt1').feature('sec4').label('Results');
model.result.report('rpt1').feature('sec4').feature.create('pg1', 'PlotGroup');
model.result.report('rpt1').feature('sec4').feature('pg1').set('noderef', 'pg2');
model.result.report('rpt1').feature('sec4').feature('pg1').label('Ragone Plot');

model.title([]);

model.description('');

model.label('lib_rate_capability_surrogate_embedded.mph');

model.title('Surrogate Model Training of a Battery Rate Capability Model');

model.description(['This app demonstrates the usage of a surrogate model function for predicting the rate capability of an NMC/graphite battery cell. The rate capability is shown in a Ragone plot.' newline  newline 'The surrogate function, a Deep Neural Network, has been fitted to a subset of the possible input data values. Three input data values can be set: the thickness of the positive electrode, the active material volume fraction of the positive electrode, and the active material volume fraction of the negative electrode. The low computational cost of evaluating the surrogate function allows sliders to be used to interactively combine the input values and predict the Ragone plot.' newline  newline 'Once a promising combination of values has been identified, the actual physical Li-ion battery model can be computed for those input values, to verify the predictions of the surrogate model. In addition, the computed physical model data can be used to further improve the surrogate model.']);

model.label('lib_rate_capability_surrogate.mph');

model.modelNode.label('Components');

out = model;
