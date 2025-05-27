function out = model
%
% li_battery_pack_3d.m
%
% Model exported on May 26 2025, 21:26 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/Battery_Design_Module/Thermal_Management');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 1);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.physics.create('liion', 'LithiumIonBatteryMPH', 'geom1');
model.physics('liion').model('comp1');

% To import content from file, use:
% model.param.loadFile('FILENAME');
model.param.set('rp_neg', '2.50e-6[m]', 'Particle radius negative electrode');
model.param.set('rp_pos', '1.70e-6[m]', 'Particle radius positive electrode');
model.param.set('sigmas_neg', '100[S/m]', 'Electrical conductivity, negative electrode');
model.param.set('sigmas_pos', '3.8[S/m]', 'Electrical conductivity, positive electrode');
model.param.set('epss_pos', '1-epsl_pos-0.170', 'Solid phase volume fraction positive electrode');
model.param.set('epsl_pos', '0.400', 'Electrolyte phase volume fraction positive electrode');
model.param.set('brugl_pos', '2.98', 'Bruggeman coefficient for tortuosity in positive electrode');
model.param.set('epss_neg', '1-epsl_neg-0.172', 'Solid phase volume fraction negative electrode');
model.param.set('epsl_neg', '0.444', 'Electrolyte phase volume fraction negative electrode');
model.param.set('epsl_sep', '0.370', 'Electrolyte phase volume fraction separator');
model.param.set('brugl_sep', '3.15', 'Bruggeman coefficient for tortuosity in separator');
model.param.set('i0ref_neg', '0.96[A/m^2]', 'Reference exchange current density negative electrode');
model.param.set('i0ref_pos', '17.44[A/m^2]', 'Reference exchange current density positive electrode');
model.param.set('cs0_neg', '2205', 'Initial state of charge negative electrode');
model.param.set('cs0_pos', '20925', 'Initial state of charge positive electrode');
model.param.set('cl_0', '1200[mol/m^3]', 'Initial electrolyte salt concentration');
model.param.set('a', '7.5', 'C-factor');
model.param.set('i_1C', '12[A/m^2]', '1C discharge current');
model.param.set('i_load', 'i_1C*a', 'Charge/discharge current');
model.param.set('L_neg', '55e-6[m]', 'Length of negative electrode');
model.param.set('L_sep', '30e-6[m]', 'Length of separator');
model.param.set('L_pos', '55e-6[m]', 'Length of positive electrode');
model.param.set('d_can', '0.25[mm]', 'Thickness of battery canister');
model.param.set('r_batt', '9[mm]', 'Battery radius');
model.param.set('h_batt', '65[mm]', 'Battery height');
model.param.set('r_mandrel', '2[mm]', 'Mandrel radius');
model.param.set('L_neg_cc', '7[um]', 'Negative current collector thickness');
model.param.set('L_pos_cc', '10[um]', 'Positive current collector thickness');
model.param.set('L_batt', 'L_neg+L_neg_cc+L_sep+L_pos+L_pos_cc', 'Cell thickness');
model.param.set('kT_pos', '1.58[W/(m*K)]', 'Positive electrode thermal conductivity');
model.param.set('kT_neg', '1.04[W/(m*K)]', 'Negative electrode thermal conductivity');
model.param.set('kT_pos_cc', '170[W/(m*K)]', 'Positive current collector thermal conductivity');
model.param.set('kT_neg_cc', '398[W/(m*K)]', 'Negative current collector thermal conductivity');
model.param.set('kT_sep', '0.344[W/(m*K)]', 'Separator thermal conductivity');
model.param.set('rho_pos', '2328.5[kg/m^3]', 'Positive electrode density');
model.param.set('rho_neg', '1347.33[kg/m^3]', 'Negative electrode density');
model.param.set('rho_pos_cc', '2770[kg/m^3]', 'Positive current collector density');
model.param.set('rho_neg_cc', '8933[kg/m^3]', 'Negative current collector density');
model.param.set('rho_sep', '1008.98[kg/m^3]', 'Separator density');
model.param.set('Cp_pos', '1269.21[J/(kg*K)]', 'Positive electrode heat capacity');
model.param.set('Cp_neg', '1437.4[J/(kg*K)]', 'Negative electrode heat capacity');
model.param.set('Cp_pos_cc', '875[J/(kg*K)]', 'Positive current collector heat capacity');
model.param.set('Cp_neg_cc', '385[J/(kg*K)]', 'Negative current collector heat capacity');
model.param.set('Cp_sep', '1978.16[J/(kg*K)]', 'Separator heat capacity');
model.param.set('kT_batt_ang', '(kT_pos*L_pos+kT_neg*L_neg+kT_pos_cc*L_pos_cc+kT_neg_cc*L_neg_cc+kT_sep*L_sep)/L_batt', 'Battery thermal conductivity, angular');
model.param.set('kT_batt_r', 'L_batt/(L_pos/kT_pos+L_neg/kT_neg+L_pos_cc/kT_pos_cc+L_neg_cc/kT_neg_cc+L_sep/kT_sep)', 'Battery thermal conductivity, radial');
model.param.set('rho_batt', '(rho_pos*L_pos+rho_neg*L_neg+rho_pos_cc*L_pos_cc+rho_neg_cc*L_neg_cc+rho_sep*L_sep)/L_batt', 'Battery density');
model.param.set('Cp_batt', '(Cp_pos*L_pos*rho_pos+Cp_neg*L_neg*rho_neg+Cp_pos_cc*L_pos_cc*rho_pos_cc+Cp_neg_cc*L_neg_cc*rho_neg_cc+Cp_sep*L_sep*rho_sep)/(L_batt*rho_batt)', 'Battery heat capacity');
model.param.set('cycle_time', '600[s]', 'Cycle time');
model.param.set('T_inlet', '298.15[K]', 'Inlet temperature');
model.param.set('T_init', 'T_inlet', 'Initial temperature');

model.geom('geom1').create('i1', 'Interval');
model.geom('geom1').feature('i1').set('specify', 'len');
model.geom('geom1').feature('i1').setIndex('len', 'L_neg', 0);
model.geom('geom1').feature('i1').setIndex('len', 'L_sep', 1);
model.geom('geom1').feature('i1').setIndex('len', 'L_pos', 2);
model.geom('geom1').runPre('fin');

model.selection.create('sel1', 'Explicit');
model.selection('sel1').model('comp1');

model.geom('geom1').run;

model.selection('sel1').set([1]);
model.selection('sel1').label('Negative Electrode');
model.selection.create('sel2', 'Explicit');
model.selection('sel2').model('comp1');
model.selection('sel2').set([3]);
model.selection('sel2').label('Positive Electrode');

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
model.material('mat3').propertyGroup('ElectrodePotential').func.create('int2', 'Interpolation');
model.material('mat3').propertyGroup.create('OperationalSOC', 'Operational electrode state of charge');
model.material('mat3').propertyGroup.create('EquilibriumConcentration', 'Equilibrium concentration');
model.material('mat3').label('LMO, LiMn2O4 Spinel (Positive, Li-ion Battery)');
model.material('mat3').propertyGroup('def').set('youngsmodulus', '');
model.material('mat3').propertyGroup('def').set('poissonsratio', '');
model.material('mat3').propertyGroup('def').set('youngsmodulus', '194[GPa]');
model.material('mat3').propertyGroup('def').set('INFO_PREFIX:youngsmodulus', 'Yue Qi et al 2014 J. Electrochem. Soc. 161 F3010');
model.material('mat3').propertyGroup('def').set('poissonsratio', '0.26');
model.material('mat3').propertyGroup('def').set('INFO_PREFIX:poissonsratio', 'Yue Qi et al 2014 J. Electrochem. Soc. 161 F3010');
model.material('mat3').propertyGroup('def').set('electricconductivity', {'3.8[S/m]' '0' '0' '0' '3.8[S/m]' '0' '0' '0' '3.8[S/m]'});
model.material('mat3').propertyGroup('def').set('INFO_PREFIX:electricconductivity', 'V. Srinivasan and C.Y. Wang, "Analysis of Electrochemical and Thermal Behavior of Li-Ion Cells," J. Electrochem. Soc., vol. 150, p. A98, 2003');
model.material('mat3').propertyGroup('def').set('diffusion', {'1e-14*exp(20000/8.314*(1/(T_ref/1[K])-1/(T2/1[K])))[m^2/s]' '0' '0' '0' '1e-14*exp(20000/8.314*(1/(T_ref/1[K])-1/(T2/1[K])))[m^2/s]' '0' '0' '0' '1e-14*exp(20000/8.314*(1/(T_ref/1[K])-1/(T2/1[K])))[m^2/s]'});
model.material('mat3').propertyGroup('def').set('INFO_PREFIX:diffusion', 'V. Srinivasan and C.Y. Wang, "Analysis of Electrochemical and Thermal Behavior of Li-Ion Cells," J. Electrochem. Soc., vol. 150, p. A98, 2003');
model.material('mat3').propertyGroup('def').set('density', '4140[kg/m^3]');
model.material('mat3').propertyGroup('def').set('INFO_PREFIX:density', 'N. Nitta, F. Wu, J. Tae Lee, and G. Yushin, Materials Today, Volume 18, Number 5, June 2015');
model.material('mat3').propertyGroup('def').set('T_ref', '298[K]');
model.material('mat3').propertyGroup('def').descr('T_ref', '');
model.material('mat3').propertyGroup('def').set('T2', 'min(393.15,max(T,223.15))');
model.material('mat3').propertyGroup('def').descr('T2', '');
model.material('mat3').propertyGroup('def').set('csmax', '22860[mol/m^3]');
model.material('mat3').propertyGroup('def').descr('csmax', '');
model.material('mat3').propertyGroup('def').addInput('temperature');
model.material('mat3').propertyGroup('ElectrodePotential').func('int1').set('funcname', 'Eeq_int1');
model.material('mat3').propertyGroup('ElectrodePotential').func('int1').set('table', {'0.1750' '4.2763';  ...
'0.1950' '4.1898';  ...
'0.2150' '4.1507';  ...
'0.2350' '4.133';  ...
'0.2550' '4.1248';  ...
'0.2750' '4.1209';  ...
'0.2950' '4.119';  ...
'0.3150' '4.1179';  ...
'0.3350' '4.1171';  ...
'0.3550' '4.1165';  ...
'0.3750' '4.116';  ...
'0.3950' '4.1153';  ...
'0.4150' '4.1145';  ...
'0.4350' '4.1135';  ...
'0.4550' '4.1121';  ...
'0.4750' '4.1099';  ...
'0.4950' '4.1066';  ...
'0.5150' '4.1014';  ...
'0.5350' '4.0934';  ...
'0.5550' '4.082';  ...
'0.5750' '4.067';  ...
'0.5950' '4.05';  ...
'0.6150' '4.0333';  ...
'0.6350' '4.0192';  ...
'0.6550' '4.0087';  ...
'0.6750' '4.0012';  ...
'0.6950' '3.996';  ...
'0.7150' '3.9923';  ...
'0.7350' '3.9893';  ...
'0.7550' '3.9867';  ...
'0.7750' '3.9841';  ...
'0.7950' '3.9813';  ...
'0.8150' '3.9783';  ...
'0.8350' '3.9747';  ...
'0.8550' '3.9705';  ...
'0.8750' '3.9652';  ...
'0.8950' '3.9585';  ...
'0.9150' '3.9493';  ...
'0.9350' '3.9361';  ...
'0.9550' '3.9144';  ...
'0.9750' '3.869';  ...
'0.9950' '3.5944';  ...
'' ''});
model.material('mat3').propertyGroup('ElectrodePotential').func('int1').set('interp', 'piecewisecubic');
model.material('mat3').propertyGroup('ElectrodePotential').func('int1').set('extrap', 'linear');
model.material('mat3').propertyGroup('ElectrodePotential').func('int1').set('fununit', {'V'});
model.material('mat3').propertyGroup('ElectrodePotential').func('int1').set('argunit', {''});
model.material('mat3').propertyGroup('ElectrodePotential').func('int1').set('defineinv', true);
model.material('mat3').propertyGroup('ElectrodePotential').func('int1').set('funcinvname', 'Eeq_inv');
model.material('mat3').propertyGroup('ElectrodePotential').func('int2').set('funcname', 'dEeqdT_int1');
model.material('mat3').propertyGroup('ElectrodePotential').func('int2').set('table', {'0.15' '0.15e-3';  ...
'0.18' '0.25e-3';  ...
'0.20' '0.21e-3';  ...
'0.209' '0.19e-3';  ...
'0.26' '0.175e-3';  ...
'0.28' '0.166e-3';  ...
'0.30' '0.155e-3';  ...
'0.35' '0.11e-3';  ...
'0.394' '0.095e-3';  ...
'0.41' '0.05e-3';  ...
'0.437' '0.02e-3';  ...
'0.445' '0';  ...
'0.46' '-0.048e-3';  ...
'0.48' '-0.15e-3';  ...
'0.50' '-0.255e-3';  ...
'0.515' '-0.3e-3';  ...
'0.545' '-0.3e-3';  ...
'0.553' '-0.22e-3';  ...
'0.58' '-0.145e-3';  ...
'0.592' '-0.10e-3';  ...
'0.60' '0';  ...
'0.62' '0.08e-3';  ...
'0.64' '0.12e-3';  ...
'0.70' '0.124e-3';  ...
'0.72' '0.10e-3';  ...
'0.73' '0.05e-3';  ...
'0.76' '0';  ...
'0.78' '-0.057e-3';  ...
'0.81' '-0.08e-3';  ...
'0.86' '-0.10e-3';  ...
'0.91' '-0.16e-3';  ...
'0.96' '-0.22e-3';  ...
'0.98' '-0.30e-3'});
model.material('mat3').propertyGroup('ElectrodePotential').func('int2').set('interp', 'piecewisecubic');
model.material('mat3').propertyGroup('ElectrodePotential').func('int2').set('fununit', {'V/K'});
model.material('mat3').propertyGroup('ElectrodePotential').func('int2').set('argunit', {''});
model.material('mat3').propertyGroup('ElectrodePotential').set('Eeq', 'Eeq_int1(soc)+dEeqdT_int1(soc)*(T-298[K])');
model.material('mat3').propertyGroup('ElectrodePotential').set('INFO_PREFIX:Eeq', 'V. Srinivasan and C.Y. Wang, "Analysis of Electrochemical and Thermal Behavior of Li-Ion Cells," J. Electrochem. Soc., vol. 150, p. A98, 2003');
model.material('mat3').propertyGroup('ElectrodePotential').set('dEeqdT', 'dEeqdT_int1(soc)');
model.material('mat3').propertyGroup('ElectrodePotential').set('INFO_PREFIX:dEeqdT', 'V. Srinivasan and C.Y. Wang, "Analysis of Electrochemical and Thermal Behavior of Li-Ion Cells," J. Electrochem. Soc., vol. 150, p. A98, 2003');
model.material('mat3').propertyGroup('ElectrodePotential').set('cEeqref', 'def.csmax');
model.material('mat3').propertyGroup('ElectrodePotential').set('INFO_PREFIX:cEeqref', 'V. Srinivasan and C.Y. Wang, "Analysis of Electrochemical and Thermal Behavior of Li-Ion Cells," J. Electrochem. Soc., vol. 150, p. A98, 2003');
model.material('mat3').propertyGroup('ElectrodePotential').set('soc', 'c/cEeqref');
model.material('mat3').propertyGroup('ElectrodePotential').descr('soc', '');
model.material('mat3').propertyGroup('ElectrodePotential').addInput('concentration');
model.material('mat3').propertyGroup('ElectrodePotential').addInput('temperature');
model.material('mat3').propertyGroup('OperationalSOC').set('socmax', 'elpot.Eeq_inv(E_min)');
model.material('mat3').propertyGroup('OperationalSOC').set('socmin', 'elpot.Eeq_inv(E_max)');
model.material('mat3').propertyGroup('OperationalSOC').set('E_max', '4.2[V]');
model.material('mat3').propertyGroup('OperationalSOC').set('E_min', '3.9[V]');
model.material('mat3').propertyGroup('EquilibriumConcentration').set('csEq', 'def.csmax*elpot.Eeq_inv(V)');
model.material('mat3').propertyGroup('EquilibriumConcentration').addInput('electricpotential');
model.material('mat1').selection.set([2]);
model.material('mat2').selection.set([1]);
model.material('mat3').selection.set([3]);

model.physics('liion').feature('sep1').set('epsl', 'epsl_sep');
model.physics('liion').feature('sep1').set('IonicCorrModel', 'userdef');
model.physics('liion').feature('sep1').set('fl', 'epsl_sep^brugl_sep');
model.physics('liion').feature('sep1').set('DiffusionCorrModel', 'userdef');
model.physics('liion').feature('sep1').set('fDl', 'epsl_sep^brugl_sep');
model.physics('liion').create('pce1', 'PorousElectrode', 1);
model.physics('liion').feature('pce1').set('ElectrolyteMaterial', 'mat1');
model.physics('liion').feature('pce1').selection.named('sel1');
model.physics('liion').feature('pce1').set('sigma', {'sigmas_neg' '0' '0' '0' 'sigmas_neg' '0' '0' '0' 'sigmas_neg'});
model.physics('liion').feature('pce1').set('epss', 'epss_neg');
model.physics('liion').feature('pce1').set('epsl', 'epsl_neg');
model.physics('liion').feature('pce1').feature('pin1').set('ParticleMaterial', 'mat2');
model.physics('liion').feature('pce1').feature('pin1').set('csinit', 'cs0_neg');
model.physics('liion').feature('pce1').feature('pin1').set('rp', 'rp_neg');
model.physics('liion').feature('pce1').feature('pin1').set('HeatMix', true);
model.physics('liion').feature('pce1').feature('per1').set('MaterialOption', 'mat2');
model.physics('liion').feature('pce1').feature('per1').set('i0_ref', 'i0ref_neg');
model.physics('liion').feature('pce1').create('pdl1', 'PorousMatrixDoubleLayerCapacitance', 1);
model.physics('liion').create('pce2', 'PorousElectrode', 1);
model.physics('liion').feature('pce2').selection.named('sel2');
model.physics('liion').feature('pce2').set('ElectrolyteMaterial', 'mat1');
model.physics('liion').feature('pce2').set('sigma', {'sigmas_pos' '0' '0' '0' 'sigmas_pos' '0' '0' '0' 'sigmas_pos'});
model.physics('liion').feature('pce2').set('epss', 'epss_pos');
model.physics('liion').feature('pce2').set('epsl', 'epsl_pos');
model.physics('liion').feature('pce2').set('IonicCorrModel', 'userdef');
model.physics('liion').feature('pce2').set('fl', 'epsl_pos^brugl_pos');
model.physics('liion').feature('pce2').set('DiffusionCorrModel', 'userdef');
model.physics('liion').feature('pce2').set('fDl', 'epsl_pos^brugl_pos');
model.physics('liion').feature('pce2').feature('pin1').set('ParticleMaterial', 'mat3');
model.physics('liion').feature('pce2').feature('pin1').set('csinit', 'cs0_pos');
model.physics('liion').feature('pce2').feature('pin1').set('rp', 'rp_pos');
model.physics('liion').feature('pce2').feature('pin1').set('HeatMix', true);
model.physics('liion').feature('pce2').feature('per1').set('MaterialOption', 'mat3');
model.physics('liion').feature('pce2').feature('per1').set('i0_ref', 'i0ref_pos');
model.physics('liion').feature('pce2').create('pdl1', 'PorousMatrixDoubleLayerCapacitance', 1);
model.physics('liion').create('egnd1', 'ElectricGround', 0);
model.physics('liion').feature('egnd1').selection.set([1]);
model.physics('liion').create('ecd1', 'ElectrodeNormalCurrentDensity', 0);
model.physics('liion').feature('ecd1').selection.set([4]);
model.physics('liion').feature('ecd1').set('nis', 'i_app');
model.physics('liion').create('init2', 'init', 1);
model.physics('liion').feature('init2').selection.named('sel2');
model.physics('liion').feature('init2').set('phil', '-mat2.elpot.Eeq_int1(cs0_neg/mat2.elpot.cEeqref)');
model.physics('liion').feature('init2').set('cl', 'cl_0');
model.physics('liion').feature('init2').set('phis', 'mat3.elpot.Eeq_int1(cs0_pos/mat3.elpot.cEeqref)-mat2.elpot.Eeq_int1(cs0_neg/mat2.elpot.cEeqref)');
model.physics('liion').feature('init1').set('phil', '-mat2.elpot.Eeq_int1(cs0_neg/mat2.elpot.cEeqref)');
model.physics('liion').feature('init1').set('cl', 'cl_0');

model.common.create('minpt1', 'CommonInputDef', 'comp1');
model.common('minpt1').selection.all;
model.common('minpt1').set('quantity', 'temperature');

model.func.create('wv1', 'Wave');
model.func('wv1').set('type', 'square');
model.func('wv1').set('period', 'cycle_time');

model.variable.create('var1');
model.variable('var1').model('comp1');
model.variable('var1').set('i_app', 'i_load*(wv1(t/1[s]))*(t<1500)');
model.variable('var1').descr('i_app', 'Applied current density');

model.probe.create('pdom1', 'DomainPoint');
model.probe('pdom1').model('comp1');
model.probe('pdom1').setIndex('coords1', 'L_neg+L_sep+L_neg', 0);
model.probe('pdom1').set('bndsnap1', true);
model.probe('pdom1').feature('ppb1').set('probename', 'CellVoltageProbe');
model.probe('pdom1').feature('ppb1').set('expr', 'phis');
model.probe('pdom1').feature('ppb1').set('descr', 'Electric potential');
model.probe('pdom1').feature('ppb1').set('window', 'window1');
model.probe('pdom1').feature('ppb1').set('windowtitle', 'Probe Plot 1');
model.probe.create('var1', 'GlobalVariable');
model.probe('var1').model('comp1');
model.probe('var1').set('probename', 'CellCurrentProbe');
model.probe('var1').set('expr', 'i_app/i_1C');
model.probe('var1').set('window', 'window1');

model.title('1D Lithium-Ion Battery for Thermal Models');

model.description('This is a template MPH-file containing the physics interface, geometry, and mesh of a lithium-ion battery. The template is used in the Thermal Modeling of a Cylindrical Lithium-Ion Battery in 3D and Liquid-Cooled Lithium-Ion Battery Pack models.');

model.label('li_battery_1d_for_thermal_models.mph');

model.modelNode.create('comp2', true);

model.geom.create('geom2', 3);
model.geom('geom2').model('comp2');

model.mesh.create('mesh2', 'geom2');

model.param.remove('rp_neg');
model.param.remove('rp_pos');
model.param.remove('sigmas_neg');
model.param.remove('sigmas_pos');
model.param.remove('epss_pos');
model.param.remove('epsl_pos');
model.param.remove('brugl_pos');
model.param.remove('epss_neg');
model.param.remove('epsl_neg');
model.param.remove('epsl_sep');
model.param.remove('brugl_sep');
model.param.remove('i0ref_neg');
model.param.remove('i0ref_pos');
model.param.remove('cs0_neg');
model.param.remove('cs0_pos');
model.param.remove('cl_0');
model.param.remove('a');
model.param.remove('i_1C');
model.param.remove('i_load');
model.param.remove('L_neg');
model.param.remove('L_sep');
model.param.remove('L_pos');
model.param.remove('d_can');
model.param.remove('r_batt');
model.param.remove('h_batt');
model.param.remove('r_mandrel');
model.param.remove('L_neg_cc');
model.param.remove('L_pos_cc');
model.param.remove('L_batt');
model.param.remove('kT_pos');
model.param.remove('kT_neg');
model.param.remove('kT_pos_cc');
model.param.remove('kT_neg_cc');
model.param.remove('kT_sep');
model.param.remove('rho_pos');
model.param.remove('rho_neg');
model.param.remove('rho_pos_cc');
model.param.remove('rho_neg_cc');
model.param.remove('rho_sep');
model.param.remove('Cp_pos');
model.param.remove('Cp_neg');
model.param.remove('Cp_pos_cc');
model.param.remove('Cp_neg_cc');
model.param.remove('Cp_sep');
model.param.remove('kT_batt_ang');
model.param.remove('kT_batt_r');
model.param.remove('rho_batt');
model.param.remove('Cp_batt');
model.param.remove('cycle_time');
model.param.remove('T_inlet');
model.param.remove('T_init');

% To import content from file, use:
% model.param.loadFile('FILENAME');
model.param.set('rp_neg', '2.50e-6[m]', 'Particle radius negative electrode');
model.param.set('rp_pos', '1.70e-6[m]', 'Particle radius positive electrode');
model.param.set('sigmas_neg', '100[S/m]', 'Electrical conductivity, negative electrode');
model.param.set('sigmas_pos', '3.8[S/m]', 'Electrical conductivity, positive electrode');
model.param.set('epss_pos', '1-epsl_pos-0.170', 'Solid phase volume fraction positive electrode');
model.param.set('epsl_pos', '0.400', 'Electrolyte phase volume fraction positive electrode');
model.param.set('brugl_pos', '2.98', 'Bruggeman coefficient for tortuosity in positive electrode');
model.param.set('epss_neg', '1-epsl_neg-0.172', 'Solid phase volume fraction negative electrode');
model.param.set('epsl_neg', '0.444', 'Electrolyte phase volume fraction negative electrode');
model.param.set('epsl_sep', '0.370', 'Electrolyte phase volume fraction separator');
model.param.set('brugl_sep', '3.15', 'Bruggeman coefficient for tortuosity in separator');
model.param.set('i0ref_neg', '0.96[A/m^2]', 'Reference exchange current density negative electrode');
model.param.set('i0ref_pos', '17.44[A/m^2]', 'Reference exchange current density positive electrode');
model.param.set('cs0_neg', '22055', 'Initial state of charge negative electrode');
model.param.set('cs0_pos', '4001', 'Initial state of charge positive electrode');
model.param.set('cl_0', '1200[mol/m^3]', 'Initial electrolyte salt concentration');
model.param.set('a', '7.5', 'C-factor');
model.param.set('i_1C', '12[A/m^2]', '1C discharge current');
model.param.set('i_load', 'i_1C*a', 'Charge/discharge current');
model.param.set('L_neg', '55e-6[m]', 'Length of negative electrode');
model.param.set('L_sep', '30e-6[m]', 'Length of separator');
model.param.set('L_pos', '55e-6[m]', 'Length of positive electrode');
model.param.set('d_can', '0.25[mm]', 'Thickness of battery canister');
model.param.set('r_batt', '9[mm]', 'Battery radius');
model.param.set('h_batt', '65[mm]', 'Battery height');
model.param.set('r_mandrel', '2[mm]', 'Mandrel radius');
model.param.set('L_neg_cc', '7[um]', 'Negative current collector thickness');
model.param.set('L_pos_cc', '10[um]', 'Positive current collector thickness');
model.param.set('L_batt', 'L_neg+L_neg_cc+L_sep+L_pos+L_pos_cc', 'Cell thickness');
model.param.set('kT_pos', '1.58[W/(m*K)]', 'Positive electrode thermal conductivity');
model.param.set('kT_neg', '1.04[W/(m*K)]', 'Negative electrode thermal conductivity');
model.param.set('kT_pos_cc', '170[W/(m*K)]', 'Positive current collector thermal conductivity');
model.param.set('kT_neg_cc', '398[W/(m*K)]', 'Negative current collector thermal conductivity');
model.param.set('kT_sep', '0.344[W/(m*K)]', 'Separator thermal conductivity');
model.param.set('rho_pos', '2328.5[kg/m^3]', 'Positive electrode density');
model.param.set('rho_neg', '1347.33[kg/m^3]', 'Negative electrode density');
model.param.set('rho_pos_cc', '2770[kg/m^3]', 'Positive current collector density');
model.param.set('rho_neg_cc', '8933[kg/m^3]', 'Negative current collector density');
model.param.set('rho_sep', '1008.98[kg/m^3]', 'Separator density');
model.param.set('Cp_pos', '1269.21[J/(kg*K)]', 'Positive electrode heat capacity');
model.param.set('Cp_neg', '1437.4[J/(kg*K)]', 'Negative electrode heat capacity');
model.param.set('Cp_pos_cc', '875[J/(kg*K)]', 'Positive current collector heat capacity');
model.param.set('Cp_neg_cc', '385[J/(kg*K)]', 'Negative current collector heat capacity');
model.param.set('Cp_sep', '1978.16[J/(kg*K)]', 'Separator heat capacity');
model.param.set('kT_batt_il', '(kT_pos*L_pos+kT_neg*L_neg+kT_pos_cc*L_pos_cc+kT_neg_cc*L_neg_cc+kT_sep*L_sep)/L_batt', 'In-layer battery thermal conductivity');
model.param.set('kT_batt_tl', 'L_batt/(L_pos/kT_pos+L_neg/kT_neg+L_pos_cc/kT_pos_cc+L_neg_cc/kT_neg_cc+L_sep/kT_sep)', 'Through-layer battery thermal conductivity');
model.param.set('rho_batt', '(rho_pos*L_pos+rho_neg*L_neg+rho_pos_cc*L_pos_cc+rho_neg_cc*L_neg_cc+rho_sep*L_sep)/L_batt', 'Battery density');
model.param.set('Cp_batt', '(Cp_pos*L_pos*rho_pos+Cp_neg*L_neg*rho_neg+Cp_pos_cc*L_pos_cc*rho_pos_cc+Cp_neg_cc*L_neg_cc*rho_neg_cc+Cp_sep*L_sep*rho_sep)/(L_batt*rho_batt)', 'Battery heat capacity');
model.param.set('cycle_time', '600[s]', 'Cycle time');
model.param.set('T_inlet', '310[K]', 'Inlet temperature');
model.param.set('T_init', 'T_inlet', 'Initial temperature');
model.param.set('N_fins_model', '3', 'Number of cooling fins in model');
model.param.set('N_fins_pack', '50', 'Total number of cooling fins in battery pack');
model.param.set('p_out', '1e5[Pa]', 'Outlet fluid pressure');
model.param.set('fin_flow', '0.5e-6[m^3/s]', 'Cooling flow per fin');

model.geom('geom2').insertFile('li_battery_pack_3d_geom_sequence.mph', 'geom1');
model.geom('geom2').run('difsel4');
model.geom('geom2').run('difsel4');

model.view('view4').set('transparency', false);

model.geom('geom2').runPre('fin');

model.variable.create('var2');
model.variable('var2').model('comp2');
model.variable('var2').set('Vol', '0.2*10*10[cm^3]');
model.variable('var2').descr('Vol', 'Battery volume');
model.variable('var2').set('Qh', 'comp1.aveop1(comp1.liion.Qh)*(L_neg+L_sep+L_pos)/L_batt');
model.variable('var2').descr('Qh', 'Heat source from battery model');

model.physics.create('spf', 'LaminarFlow', 'geom2');
model.physics('spf').model('comp2');
model.physics.create('ht', 'HeatTransferInSolidsAndFluids', 'geom2');
model.physics('ht').model('comp2');

model.study.create('std1');
model.study('std1').create('stat', 'Stationary');
model.study('std1').feature('stat').setSolveFor('/physics/liion', true);
model.study('std1').feature('stat').setSolveFor('/physics/spf', true);
model.study('std1').feature('stat').setSolveFor('/physics/ht', true);

model.func.create('step1', 'Step');

model.variable('var1').set('i_app', '-i_load*step1(t/1[s])');

model.common('minpt1').set('value', 'T_inlet');

model.cpl.create('aveop1', 'Average', 'geom1');
model.cpl('aveop1').set('axisym', true);
model.cpl('aveop1').selection.all;

model.material.create('mat4', 'Common', 'comp2');
model.material('mat4').propertyGroup('def').func.create('eta', 'Piecewise');
model.material('mat4').propertyGroup('def').func.create('Cp', 'Piecewise');
model.material('mat4').propertyGroup('def').func.create('rho', 'Piecewise');
model.material('mat4').propertyGroup('def').func.create('k', 'Piecewise');
model.material('mat4').propertyGroup('def').func.create('cs', 'Interpolation');
model.material('mat4').propertyGroup('def').func.create('an1', 'Analytic');
model.material('mat4').propertyGroup('def').func.create('an2', 'Analytic');
model.material('mat4').propertyGroup('def').func.create('an3', 'Analytic');
model.material('mat4').label('Water, liquid');
model.material('mat4').set('family', 'water');
model.material('mat4').propertyGroup('def').func('eta').set('arg', 'T');
model.material('mat4').propertyGroup('def').func('eta').set('pieces', {'273.15' '413.15' '1.3799566804-0.021224019151*T^1+1.3604562827E-4*T^2-4.6454090319E-7*T^3+8.9042735735E-10*T^4-9.0790692686E-13*T^5+3.8457331488E-16*T^6'; '413.15' '553.75' '0.00401235783-2.10746715E-5*T^1+3.85772275E-8*T^2-2.39730284E-11*T^3'});
model.material('mat4').propertyGroup('def').func('eta').set('argunit', 'K');
model.material('mat4').propertyGroup('def').func('eta').set('fununit', 'Pa*s');
model.material('mat4').propertyGroup('def').func('Cp').set('arg', 'T');
model.material('mat4').propertyGroup('def').func('Cp').set('pieces', {'273.15' '553.75' '12010.1471-80.4072879*T^1+0.309866854*T^2-5.38186884E-4*T^3+3.62536437E-7*T^4'});
model.material('mat4').propertyGroup('def').func('Cp').set('argunit', 'K');
model.material('mat4').propertyGroup('def').func('Cp').set('fununit', 'J/(kg*K)');
model.material('mat4').propertyGroup('def').func('rho').set('arg', 'T');
model.material('mat4').propertyGroup('def').func('rho').set('smooth', 'contd1');
model.material('mat4').propertyGroup('def').func('rho').set('pieces', {'273.15' '293.15' '0.000063092789034*T^3-0.060367639882855*T^2+18.9229382407066*T-950.704055329848'; '293.15' '373.15' '0.000010335053319*T^3-0.013395065634452*T^2+4.969288832655160*T+432.257114008512'});
model.material('mat4').propertyGroup('def').func('rho').set('argunit', 'K');
model.material('mat4').propertyGroup('def').func('rho').set('fununit', 'kg/m^3');
model.material('mat4').propertyGroup('def').func('k').set('arg', 'T');
model.material('mat4').propertyGroup('def').func('k').set('pieces', {'273.15' '553.75' '-0.869083936+0.00894880345*T^1-1.58366345E-5*T^2+7.97543259E-9*T^3'});
model.material('mat4').propertyGroup('def').func('k').set('argunit', 'K');
model.material('mat4').propertyGroup('def').func('k').set('fununit', 'W/(m*K)');
model.material('mat4').propertyGroup('def').func('cs').set('table', {'273' '1403';  ...
'278' '1427';  ...
'283' '1447';  ...
'293' '1481';  ...
'303' '1507';  ...
'313' '1526';  ...
'323' '1541';  ...
'333' '1552';  ...
'343' '1555';  ...
'353' '1555';  ...
'363' '1550';  ...
'373' '1543'});
model.material('mat4').propertyGroup('def').func('cs').set('interp', 'piecewisecubic');
model.material('mat4').propertyGroup('def').func('cs').set('fununit', {'m/s'});
model.material('mat4').propertyGroup('def').func('cs').set('argunit', {'K'});
model.material('mat4').propertyGroup('def').func('an1').set('funcname', 'alpha_p');
model.material('mat4').propertyGroup('def').func('an1').set('expr', '-1/rho(T)*d(rho(T),T)');
model.material('mat4').propertyGroup('def').func('an1').set('args', {'T'});
model.material('mat4').propertyGroup('def').func('an1').set('fununit', '1/K');
model.material('mat4').propertyGroup('def').func('an1').set('argunit', {'K'});
model.material('mat4').propertyGroup('def').func('an1').set('plotfixedvalue', {'273.15'});
model.material('mat4').propertyGroup('def').func('an1').set('plotargs', {'T' '273.15' '373.15'});
model.material('mat4').propertyGroup('def').func('an2').set('funcname', 'gamma_w');
model.material('mat4').propertyGroup('def').func('an2').set('expr', '1+(T/Cp(T))*(alpha_p(T)*cs(T))^2');
model.material('mat4').propertyGroup('def').func('an2').set('args', {'T'});
model.material('mat4').propertyGroup('def').func('an2').set('fununit', '1');
model.material('mat4').propertyGroup('def').func('an2').set('argunit', {'K'});
model.material('mat4').propertyGroup('def').func('an2').set('plotfixedvalue', {'273.15'});
model.material('mat4').propertyGroup('def').func('an2').set('plotargs', {'T' '273.15' '373.15'});
model.material('mat4').propertyGroup('def').func('an3').set('funcname', 'muB');
model.material('mat4').propertyGroup('def').func('an3').set('expr', '2.79*eta(T)');
model.material('mat4').propertyGroup('def').func('an3').set('args', {'T'});
model.material('mat4').propertyGroup('def').func('an3').set('fununit', 'Pa*s');
model.material('mat4').propertyGroup('def').func('an3').set('argunit', {'K'});
model.material('mat4').propertyGroup('def').func('an3').set('plotfixedvalue', {'273.15'});
model.material('mat4').propertyGroup('def').func('an3').set('plotargs', {'T' '273.15' '553.75'});
model.material('mat4').propertyGroup('def').set('thermalexpansioncoefficient', '');
model.material('mat4').propertyGroup('def').set('bulkviscosity', '');
model.material('mat4').propertyGroup('def').set('thermalexpansioncoefficient', {'alpha_p(T)' '0' '0' '0' 'alpha_p(T)' '0' '0' '0' 'alpha_p(T)'});
model.material('mat4').propertyGroup('def').set('bulkviscosity', 'muB(T)');
model.material('mat4').propertyGroup('def').set('dynamicviscosity', 'eta(T)');
model.material('mat4').propertyGroup('def').set('ratioofspecificheat', 'gamma_w(T)');
model.material('mat4').propertyGroup('def').set('electricconductivity', {'5.5e-6[S/m]' '0' '0' '0' '5.5e-6[S/m]' '0' '0' '0' '5.5e-6[S/m]'});
model.material('mat4').propertyGroup('def').set('heatcapacity', 'Cp(T)');
model.material('mat4').propertyGroup('def').set('density', 'rho(T)');
model.material('mat4').propertyGroup('def').set('thermalconductivity', {'k(T)' '0' '0' '0' 'k(T)' '0' '0' '0' 'k(T)'});
model.material('mat4').propertyGroup('def').set('soundspeed', 'cs(T)');
model.material('mat4').propertyGroup('def').addInput('temperature');
model.material.create('mat5', 'Common', 'comp2');
model.material('mat5').propertyGroup.create('Enu', 'Young''s modulus and Poisson''s ratio');
model.material('mat5').propertyGroup.create('Murnaghan', 'Murnaghan');
model.material('mat5').label('Aluminum');
model.material('mat5').set('family', 'aluminum');
model.material('mat5').propertyGroup('def').set('relpermeability', {'1' '0' '0' '0' '1' '0' '0' '0' '1'});
model.material('mat5').propertyGroup('def').set('heatcapacity', '900[J/(kg*K)]');
model.material('mat5').propertyGroup('def').set('thermalconductivity', {'238[W/(m*K)]' '0' '0' '0' '238[W/(m*K)]' '0' '0' '0' '238[W/(m*K)]'});
model.material('mat5').propertyGroup('def').set('electricconductivity', {'3.774e7[S/m]' '0' '0' '0' '3.774e7[S/m]' '0' '0' '0' '3.774e7[S/m]'});
model.material('mat5').propertyGroup('def').set('relpermittivity', {'1' '0' '0' '0' '1' '0' '0' '0' '1'});
model.material('mat5').propertyGroup('def').set('thermalexpansioncoefficient', {'23e-6[1/K]' '0' '0' '0' '23e-6[1/K]' '0' '0' '0' '23e-6[1/K]'});
model.material('mat5').propertyGroup('def').set('density', '2700[kg/m^3]');
model.material('mat5').propertyGroup('Enu').set('E', '70[GPa]');
model.material('mat5').propertyGroup('Enu').set('nu', '0.33');
model.material('mat5').propertyGroup('Murnaghan').set('l', '-250[GPa]');
model.material('mat5').propertyGroup('Murnaghan').set('m', '-330[GPa]');
model.material('mat5').propertyGroup('Murnaghan').set('n', '-350[GPa]');
model.material('mat4').selection.named('geom2_unisel1');
model.material('mat5').selection.named('geom2_difsel1');
model.material('mat5').propertyGroup('def').set('dynamicviscosity', {'0'});

model.physics('spf').selection.named('geom2_unisel1');
model.physics('spf').create('inl1', 'InletBoundary', 2);
model.physics('spf').feature('inl1').selection.named('geom2_sel1');
model.physics('spf').feature('inl1').set('BoundaryCondition', 'FullyDevelopedFlow');
model.physics('spf').feature('inl1').set('FullyDevelopedFlowOption', 'V0');
model.physics('spf').feature('inl1').set('V0fdf', 'N_fins_model*fin_flow');
model.physics('spf').create('inl2', 'InletBoundary', 2);
model.physics('spf').feature('inl2').selection.named('geom2_sel3');
model.physics('spf').feature('inl2').set('BoundaryCondition', 'FullyDevelopedFlow');
model.physics('spf').feature('inl2').set('FullyDevelopedFlowOption', 'V0');
model.physics('spf').feature('inl2').set('V0fdf', '(N_fins_pack-N_fins_model)*fin_flow');
model.physics('spf').create('out1', 'OutletBoundary', 2);
model.physics('spf').feature('out1').selection.named('geom2_sel2');
model.physics('spf').feature('out1').set('NormalFlow', true);
model.physics('spf').create('init2', 'init', 3);
model.physics('spf').feature('init2').selection.named('geom2_blk4_dom');
model.physics('spf').feature('init2').set('u_init', {'0' '(N_fins_pack-N_fins_model)*fin_flow/(8[mm]*16[mm])' '0'});
model.physics('ht').feature('init1').set('Tinit', 'T_init');
model.physics('ht').feature('fluid1').selection.named('geom2_unisel1');
model.physics('ht').create('bl1', 'BatteryLayers', 3);
model.physics('ht').feature('bl1').selection.named('geom2_arr1_dom');
model.physics('ht').feature('bl1').set('ThroughLayerDirection', 'y_axis');
model.physics('ht').feature('bl1').set('ThroughLayerConductivity', 'kT_batt_tl');
model.physics('ht').feature('bl1').set('InLayerConductivity', 'kT_batt_il');
model.physics('ht').feature('bl1').set('Density', 'rho_batt');
model.physics('ht').feature('bl1').set('HeatCapacity', 'Cp_batt');
model.physics('ht').create('hs1', 'HeatSource', 3);
model.physics('ht').feature('hs1').selection.named('geom2_arr2_dom');
model.physics('ht').feature('hs1').set('Q0', 'Qh');
model.physics('ht').create('temp1', 'TemperatureBoundary', 2);
model.physics('ht').feature('temp1').selection.named('geom2_sel1');
model.physics('ht').feature('temp1').set('T0', 'T_inlet');
model.physics('ht').create('ofl1', 'ConvectiveOutflow', 2);
model.physics('ht').feature('ofl1').selection.named('geom2_sel2');
model.physics('ht').create('hf1', 'HeatFluxBoundary', 2);
model.physics('ht').feature('hf1').selection.named('geom2_difsel2');
model.physics('ht').feature('hf1').set('HeatFluxType', 'ConvectiveHeatFlux');
model.physics('ht').feature('hf1').set('h', 1);
model.physics('ht').create('sym1', 'Symmetry', 2);
model.physics('ht').feature('sym1').selection.set([122]);

model.multiphysics.create('nitf1', 'NonIsothermalFlow', 'geom2', 3);

model.mesh('mesh2').create('size1', 'Size');
model.mesh('mesh2').feature('size').set('custom', true);
model.mesh('mesh2').feature('size').set('hmax', '0.009[m]');
model.mesh('mesh2').feature('size').set('hmin', '0.00025[m]');
model.mesh('mesh2').feature('size1').selection.geom('geom2', 3);
model.mesh('mesh2').feature('size1').selection.named('geom2_difsel3');
model.mesh('mesh2').feature('size1').set('custom', true);
model.mesh('mesh2').feature('size1').set('hnarrowactive', true);
model.mesh('mesh2').feature('size1').set('hnarrow', 0.2);
model.mesh('mesh2').feature.duplicate('size2', 'size1');
model.mesh('mesh2').feature('size2').selection.named('geom2_blk5_dom');
model.mesh('mesh2').feature('size2').set('hnarrow', 0.5);
model.mesh('mesh2').feature('size2').set('hnarrowactive', false);
model.mesh('mesh2').feature('size2').set('hmaxactive', true);
model.mesh('mesh2').feature('size2').set('hmax', 1.9);
model.mesh('mesh2').feature.duplicate('size3', 'size2');
model.mesh('mesh2').feature('size3').selection.named('geom2_blk4_dom');
model.mesh('mesh2').feature.duplicate('size4', 'size3');
model.mesh('mesh2').feature('size4').selection.geom('geom2', 1);
model.mesh('mesh2').feature('size4').selection.named('geom2_adjsel5');
model.mesh('mesh2').feature('size4').set('hmax', 0.25);
model.mesh('mesh2').create('ftet1', 'FreeTet');
model.mesh('mesh2').feature('ftet1').selection.geom('geom2', 3);
model.mesh('mesh2').feature('ftet1').selection.named('geom2_unisel1');
model.mesh('mesh2').create('bl1', 'BndLayer');
model.mesh('mesh2').feature('bl1').create('blp', 'BndLayerProp');
model.mesh('mesh2').feature('bl1').selection.geom(3);
model.mesh('mesh2').feature('bl1').selection.set([]);
model.mesh('mesh2').feature('bl1').selection.allGeom;
model.mesh('mesh2').feature('bl1').selection.geom('geom2', 3);
model.mesh('mesh2').feature('bl1').selection.named('geom2_difsel3');
model.mesh('mesh2').feature('bl1').feature('blp').selection.named('geom2_adjsel1');
model.mesh('mesh2').feature('bl1').feature('blp').set('blnlayers', 2);
model.mesh('mesh2').feature('bl1').feature('blp').set('inittype', 'blhmin');
model.mesh('mesh2').feature('bl1').feature('blp').set('blhmin', 0.075);
model.mesh('mesh2').create('ftet2', 'FreeTet');
model.mesh('mesh2').feature('ftet2').create('size1', 'Size');
model.mesh('mesh2').feature('ftet2').feature('size1').set('custom', true);
model.mesh('mesh2').feature('ftet2').feature('size1').set('hmaxactive', true);
model.mesh('mesh2').feature('ftet2').feature('size1').set('hmax', 6);
model.mesh('mesh2').run;

model.study('std1').feature('stat').setEntry('activate', 'liion', false);
model.study('std1').feature('stat').setEntry('activate', 'ht', false);
model.study('std1').feature('stat').set('probesel', 'none');
model.study('std1').setGenPlots(false);

model.sol.create('sol1');

model.mesh('mesh2').stat.selection.geom(3);
model.mesh('mesh2').stat.selection.set([4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 26]);

model.sol('sol1').study('std1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'stat');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').set('control', 'stat');
model.sol('sol1').create('s1', 'Stationary');
model.sol('sol1').feature('s1').feature('aDef').set('cachepattern', true);
model.sol('sol1').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('s1').feature('fc1').set('dtech', 'auto');
model.sol('sol1').feature('s1').feature('fc1').set('initstep', 0.01);
model.sol('sol1').feature('s1').feature('fc1').set('minstep', 1.0E-4);
model.sol('sol1').feature('s1').feature('fc1').set('maxiter', 100);
model.sol('sol1').feature('s1').create('d1', 'Direct');
model.sol('sol1').feature('s1').feature('d1').set('linsolver', 'pardiso');
model.sol('sol1').feature('s1').feature('d1').set('pivotperturb', 1.0E-13);
model.sol('sol1').feature('s1').feature('d1').label('Direct, fluid flow variables (spf)');
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
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('pr').feature('sc1').set('vankavars', {'comp2_spf_inl1_Pinlfdf' 'comp2_spf_inl2_Pinlfdf'});
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
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('po').feature('sc1').set('vankavars', {'comp2_spf_inl1_Pinlfdf' 'comp2_spf_inl2_Pinlfdf'});
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('po').feature('sc1').set('scgssolv', 'stored');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('po').feature('sc1').set('approxscgs', true);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('po').feature('sc1').set('scgsdirectmaxsize', 1000);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('cs').create('d1', 'Direct');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('cs').feature('d1').set('linsolver', 'pardiso');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('cs').feature('d1').set('pivotperturb', 1.0E-13);
model.sol('sol1').feature('s1').feature('fc1').set('linsolver', 'd1');
model.sol('sol1').feature('s1').feature('fc1').set('dtech', 'auto');
model.sol('sol1').feature('s1').feature('fc1').set('initstep', 0.01);
model.sol('sol1').feature('s1').feature('fc1').set('minstep', 1.0E-4);
model.sol('sol1').feature('s1').feature('fc1').set('maxiter', 100);
model.sol('sol1').feature('s1').feature.remove('fcDef');
model.sol('sol1').attach('std1');
model.sol('sol1').runAll;

model.study.create('std2');
model.study('std2').create('time', 'Transient');
model.study('std2').feature('time').setSolveFor('/physics/liion', true);
model.study('std2').feature('time').setSolveFor('/physics/spf', true);
model.study('std2').feature('time').setSolveFor('/physics/ht', true);
model.study('std2').feature('time').setSolveFor('/multiphysics/nitf1', true);
model.study('std2').feature('time').set('tlist', 'range(0,60,60)');
model.study('std2').feature('time').setEntry('activate', 'spf', false);
model.study('std2').feature('time').setEntry('activate', 'ht', false);
model.study('std2').feature('time').set('usesol', true);
model.study('std2').feature('time').set('notsolmethod', 'sol');
model.study('std2').feature('time').set('notstudy', 'std1');

model.sol.create('sol2');

model.mesh('mesh2').stat.selection.geom(3);
model.mesh('mesh2').stat.selection.set([4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 26]);

model.sol('sol2').study('std2');
model.sol('sol2').create('st1', 'StudyStep');
model.sol('sol2').feature('st1').set('study', 'std2');
model.sol('sol2').feature('st1').set('studystep', 'time');
model.sol('sol2').create('v1', 'Variables');
model.sol('sol2').feature('v1').feature('comp1_phil').set('scalemethod', 'manual');
model.sol('sol2').feature('v1').feature('comp1_liion_pce2_cs').set('scalemethod', 'manual');
model.sol('sol2').feature('v1').feature('comp1_liion_pce1_cs').set('scalemethod', 'manual');
model.sol('sol2').feature('v1').feature('comp1_phis').set('scalemethod', 'manual');
model.sol('sol2').feature('v1').feature('comp1_cl').set('scalemethod', 'manual');
model.sol('sol2').feature('v1').feature('comp1_phil').set('scaleval', '1');
model.sol('sol2').feature('v1').feature('comp1_liion_pce2_cs').set('scaleval', '10000');
model.sol('sol2').feature('v1').feature('comp1_liion_pce1_cs').set('scaleval', '10000');
model.sol('sol2').feature('v1').feature('comp1_phis').set('scaleval', '1');
model.sol('sol2').feature('v1').feature('comp1_cl').set('scaleval', '1000');
model.sol('sol2').feature('v1').set('control', 'time');
model.sol('sol2').create('t1', 'Time');
model.sol('sol2').feature('t1').set('tlist', 'range(0,60,60)');
model.sol('sol2').feature('t1').set('plot', 'off');
model.sol('sol2').feature('t1').set('plotgroup', 'Default');
model.sol('sol2').feature('t1').set('plotfreq', 'tout');
model.sol('sol2').feature('t1').set('probesel', 'all');
model.sol('sol2').feature('t1').set('probes', {'pdom1' 'var1'});
model.sol('sol2').feature('t1').set('probefreq', 'tsteps');
model.sol('sol2').feature('t1').set('rtol', 0.001);
model.sol('sol2').feature('t1').set('atolglobalvaluemethod', 'factor');
model.sol('sol2').feature('t1').set('eventout', true);
model.sol('sol2').feature('t1').set('reacf', true);
model.sol('sol2').feature('t1').set('storeudot', true);
model.sol('sol2').feature('t1').set('endtimeinterpolation', true);
model.sol('sol2').feature('t1').set('maxorder', 2);
model.sol('sol2').feature('t1').set('initialstepbdfactive', true);
model.sol('sol2').feature('t1').set('initialstepbdf', '(1)[s]');
model.sol('sol2').feature('t1').set('control', 'time');
model.sol('sol2').feature('t1').feature('aDef').set('cachepattern', true);
model.sol('sol2').feature('t1').create('fc1', 'FullyCoupled');
model.sol('sol2').feature('t1').feature('fc1').set('dtech', 'auto');
model.sol('sol2').feature('t1').create('d1', 'Direct');
model.sol('sol2').feature('t1').feature('d1').set('linsolver', 'pardiso');
model.sol('sol2').feature('t1').feature('d1').label('Direct (liion)');
model.sol('sol2').feature('t1').create('i1', 'Iterative');
model.sol('sol2').feature('t1').feature('i1').set('maxlinit', 1000);
model.sol('sol2').feature('t1').feature('i1').set('nlinnormuse', 'on');
model.sol('sol2').feature('t1').feature('i1').label('Algebraic Multigrid (liion)');
model.sol('sol2').feature('t1').feature('i1').create('mg1', 'Multigrid');
model.sol('sol2').feature('t1').feature('i1').feature('mg1').set('prefun', 'saamg');
model.sol('sol2').feature('t1').feature('i1').feature('mg1').set('maxcoarsedof', 50000);
model.sol('sol2').feature('t1').feature('i1').feature('mg1').set('saamgcompwise', true);
model.sol('sol2').feature('t1').feature('i1').feature('mg1').set('compactaggregation', true);
model.sol('sol2').feature('t1').feature('i1').feature('mg1').feature('pr').create('sl1', 'SORLine');
model.sol('sol2').feature('t1').feature('i1').feature('mg1').feature('po').create('sl1', 'SORLine');
model.sol('sol2').feature('t1').feature('i1').feature('mg1').feature('cs').create('d1', 'Direct');
model.sol('sol2').feature('t1').feature('i1').feature('mg1').feature('cs').feature('d1').set('linsolver', 'pardiso');
model.sol('sol2').feature('t1').create('i2', 'Iterative');
model.sol('sol2').feature('t1').feature('i2').set('maxlinit', 1000);
model.sol('sol2').feature('t1').feature('i2').set('nlinnormuse', 'on');
model.sol('sol2').feature('t1').feature('i2').label('Geometric Multigrid (liion)');
model.sol('sol2').feature('t1').feature('i2').create('mg1', 'Multigrid');
model.sol('sol2').feature('t1').feature('i2').feature('mg1').feature('pr').create('sl1', 'SORLine');
model.sol('sol2').feature('t1').feature('i2').feature('mg1').feature('po').create('sl1', 'SORLine');
model.sol('sol2').feature('t1').feature('i2').feature('mg1').feature('cs').create('d1', 'Direct');
model.sol('sol2').feature('t1').feature('i2').feature('mg1').feature('cs').feature('d1').set('linsolver', 'pardiso');
model.sol('sol2').feature('t1').feature('fc1').set('linsolver', 'd1');
model.sol('sol2').feature('t1').feature('fc1').set('dtech', 'auto');
model.sol('sol2').feature('t1').feature.remove('fcDef');
model.sol('sol2').attach('std2');
model.sol('sol2').feature('t1').feature('fc1').set('maxiter', 10);

model.study('std2').setGenPlots(false);

model.probe('pdom1').genResult('none');
model.probe('var1').genResult('none');

model.sol('sol2').runAll;

model.study.create('std3');
model.study('std3').create('stat', 'Stationary');
model.study('std3').feature('stat').setSolveFor('/physics/liion', true);
model.study('std3').feature('stat').setSolveFor('/physics/spf', true);
model.study('std3').feature('stat').setSolveFor('/physics/ht', true);
model.study('std3').feature('stat').setSolveFor('/multiphysics/nitf1', true);
model.study('std3').feature('stat').set('probesel', 'none');
model.study('std3').feature('stat').setEntry('activate', 'liion', false);
model.study('std3').feature('stat').setEntry('activate', 'spf', false);
model.study('std3').feature('stat').set('usesol', true);
model.study('std3').feature('stat').set('notsolmethod', 'sol');
model.study('std3').feature('stat').set('notstudy', 'std2');
model.study('std3').setGenPlots(false);

model.sol.create('sol3');

model.mesh('mesh2').stat.selection.geom(3);
model.mesh('mesh2').stat.selection.set([4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 26]);

model.sol('sol3').study('std3');
model.sol('sol3').create('st1', 'StudyStep');
model.sol('sol3').feature('st1').set('study', 'std3');
model.sol('sol3').feature('st1').set('studystep', 'stat');
model.sol('sol3').create('v1', 'Variables');
model.sol('sol3').feature('v1').set('control', 'stat');
model.sol('sol3').create('s1', 'Stationary');
model.sol('sol3').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol3').feature('s1').feature('fc1').set('dtech', 'auto');
model.sol('sol3').feature('s1').feature('fc1').set('initstep', 0.01);
model.sol('sol3').feature('s1').feature('fc1').set('minstep', 1.0E-4);
model.sol('sol3').feature('s1').feature('fc1').set('maxiter', 100);
model.sol('sol3').feature('s1').create('d1', 'Direct');
model.sol('sol3').feature('s1').feature('d1').set('linsolver', 'pardiso');
model.sol('sol3').feature('s1').feature('d1').set('pivotperturb', 1.0E-13);
model.sol('sol3').feature('s1').feature('d1').label('Direct, heat transfer variables (ht) (nitf1)');
model.sol('sol3').feature('s1').create('i1', 'Iterative');
model.sol('sol3').feature('s1').feature('i1').set('linsolver', 'gmres');
model.sol('sol3').feature('s1').feature('i1').set('prefuntype', 'left');
model.sol('sol3').feature('s1').feature('i1').set('itrestart', 50);
model.sol('sol3').feature('s1').feature('i1').set('rhob', 20);
model.sol('sol3').feature('s1').feature('i1').set('maxlinit', 10000);
model.sol('sol3').feature('s1').feature('i1').set('nlinnormuse', 'on');
model.sol('sol3').feature('s1').feature('i1').label('AMG, heat transfer variables (ht) (nitf1)');
model.sol('sol3').feature('s1').feature('i1').create('mg1', 'Multigrid');
model.sol('sol3').feature('s1').feature('i1').feature('mg1').set('prefun', 'saamg');
model.sol('sol3').feature('s1').feature('i1').feature('mg1').set('mgcycle', 'v');
model.sol('sol3').feature('s1').feature('i1').feature('mg1').set('maxcoarsedof', 50000);
model.sol('sol3').feature('s1').feature('i1').feature('mg1').set('strconn', 0.01);
model.sol('sol3').feature('s1').feature('i1').feature('mg1').set('nullspace', 'constant');
model.sol('sol3').feature('s1').feature('i1').feature('mg1').set('usesmooth', false);
model.sol('sol3').feature('s1').feature('i1').feature('mg1').set('saamgcompwise', true);
model.sol('sol3').feature('s1').feature('i1').feature('mg1').set('loweramg', true);
model.sol('sol3').feature('s1').feature('i1').feature('mg1').set('compactaggregation', false);
model.sol('sol3').feature('s1').feature('i1').feature('mg1').feature('pr').create('so1', 'SOR');
model.sol('sol3').feature('s1').feature('i1').feature('mg1').feature('pr').feature('so1').set('iter', 2);
model.sol('sol3').feature('s1').feature('i1').feature('mg1').feature('pr').feature('so1').set('relax', 0.9);
model.sol('sol3').feature('s1').feature('i1').feature('mg1').feature('po').create('so1', 'SOR');
model.sol('sol3').feature('s1').feature('i1').feature('mg1').feature('po').feature('so1').set('iter', 2);
model.sol('sol3').feature('s1').feature('i1').feature('mg1').feature('po').feature('so1').set('relax', 0.9);
model.sol('sol3').feature('s1').feature('i1').feature('mg1').feature('cs').create('d1', 'Direct');
model.sol('sol3').feature('s1').feature('i1').feature('mg1').feature('cs').feature('d1').set('linsolver', 'pardiso');
model.sol('sol3').feature('s1').feature('i1').feature('mg1').feature('cs').feature('d1').set('pivotperturb', 1.0E-13);
model.sol('sol3').feature('s1').feature('fc1').set('linsolver', 'd1');
model.sol('sol3').feature('s1').feature('fc1').set('dtech', 'auto');
model.sol('sol3').feature('s1').feature('fc1').set('initstep', 0.01);
model.sol('sol3').feature('s1').feature('fc1').set('minstep', 1.0E-4);
model.sol('sol3').feature('s1').feature('fc1').set('maxiter', 100);
model.sol('sol3').feature('s1').feature.remove('fcDef');
model.sol('sol3').attach('std3');
model.sol('sol3').runAll;

model.result.dataset.create('dset8', 'Solution');
model.result.dataset('dset8').set('solution', 'sol3');
model.result.dataset('dset8').set('comp', 'comp2');
model.result.dataset('dset8').selection.geom('geom2', 3);
model.result.dataset('dset8').selection.named('geom2_difsel3');
model.result.create('pg2', 'PlotGroup3D');
model.result('pg2').run;
model.result('pg2').set('data', 'dset8');
model.result('pg2').create('surf1', 'Surface');
model.result('pg2').feature('surf1').set('expr', 'p');
model.result('pg2').run;
model.result.create('pg3', 'PlotGroup3D');
model.result('pg3').run;
model.result('pg3').set('data', 'dset8');
model.result('pg3').create('surf1', 'Surface');
model.result('pg3').feature('surf1').set('expr', 'T');
model.result('pg3').feature('surf1').set('descr', 'Temperature');
model.result('pg3').feature('surf1').set('colortable', 'ThermalDark');
model.result('pg3').run;
model.result.dataset.create('dset9', 'Solution');
model.result.dataset('dset9').set('solution', 'sol3');
model.result.dataset('dset9').set('comp', 'comp2');
model.result.dataset('dset9').selection.geom('geom2', 3);
model.result.dataset('dset9').selection.named('geom2_difsel3');
model.result.dataset.create('cpl1', 'CutPlane');
model.result.dataset('cpl1').set('data', 'dset9');
model.result.dataset('cpl1').set('quickplane', 'xz');
model.result.dataset('cpl1').set('quicky', '3[mm]');
model.result.create('pg4', 'PlotGroup2D');
model.result('pg4').run;
model.result('pg4').create('surf1', 'Surface');
model.result('pg4').run;
model.result.dataset.create('dset10', 'Solution');
model.result.dataset('dset10').set('solution', 'sol3');
model.result.dataset('dset10').set('comp', 'comp2');
model.result.dataset('dset10').selection.geom('geom2', 3);
model.result.dataset('dset10').selection.named('geom2_arr2_dom');
model.result.create('pg5', 'PlotGroup3D');
model.result('pg5').run;
model.result('pg5').create('surf1', 'Surface');
model.result('pg5').feature('surf1').set('data', 'dset10');
model.result('pg5').feature('surf1').set('expr', 'T');
model.result('pg5').feature('surf1').set('descr', 'Temperature');
model.result('pg5').feature('surf1').set('colortable', 'ThermalDark');
model.result('pg5').run;
model.result.dataset.create('cpl2', 'CutPlane');
model.result.dataset('cpl2').set('data', 'dset10');
model.result.dataset('cpl2').set('quickplane', 'xz');
model.result.dataset('cpl2').set('quicky', '4[mm]');
model.result.create('pg6', 'PlotGroup2D');
model.result('pg6').run;
model.result('pg6').set('data', 'cpl2');
model.result('pg6').create('surf1', 'Surface');
model.result('pg6').feature('surf1').set('expr', 'T-T_inlet');
model.result('pg6').feature('surf1').set('rangecoloractive', true);
model.result('pg6').feature('surf1').set('rangecolormax', 3);
model.result('pg6').feature('surf1').set('colortable', 'ThermalDark');
model.result('pg6').feature('surf1').create('hght1', 'Height');
model.result('pg6').run;
model.result.dataset.create('cpl3', 'CutPlane');
model.result.dataset('cpl3').set('data', 'dset10');
model.result.dataset('cpl3').set('quickplane', 'xz');
model.result.dataset('cpl3').set('quicky', '6[mm]');
model.result('pg6').run;
model.result('pg6').create('surf2', 'Surface');
model.result('pg6').feature('surf2').set('data', 'cpl3');
model.result('pg6').feature('surf2').set('expr', 'T-T_inlet');
model.result('pg6').feature('surf2').set('rangecoloractive', true);
model.result('pg6').feature('surf2').set('rangecolormax', 3);
model.result('pg6').feature('surf2').set('colortable', 'ThermalDark');
model.result('pg6').feature('surf2').set('colorlegend', false);
model.result('pg6').feature('surf2').create('hght1', 'Height');
model.result('pg6').run;
model.result('pg6').run;

model.study('std1').label('Study 1 (Flow)');
model.study('std2').label('Study 2 (Battery)');
model.study('std3').label('Study 3 (Temperature)');

model.result('pg2').run;
model.result('pg2').label('Fluid pressure');
model.result('pg3').run;
model.result('pg3').label('Fluid temperature');
model.result('pg4').run;
model.result('pg4').label('Plate channel velocity');
model.result('pg5').run;
model.result('pg5').label('Temperature in batteries');
model.result('pg6').run;
model.result('pg6').label('Battery surface temperature');

model.geom('geom2').run('difsel4');

model.view('view4').set('transparency', false);

model.result('pg5').run;

model.title('Liquid-Cooled Lithium-Ion Battery Pack');

model.description('This example simulates the temperature profile in a liquid-cooled battery pack. The fluid flow and temperature model are in 3D whereas a 1D model of the batteries is used to calculate the heat source.');

model.mesh.clearMeshes;

model.sol('sol1').clearSolutionData;
model.sol('sol2').clearSolutionData;
model.sol('sol3').clearSolutionData;

model.label('li_battery_pack_3d.mph');

model.modelNode.label('Components');

out = model;
