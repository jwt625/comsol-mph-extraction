function out = model
%
% capacity_fade.m
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

% To import content from file, use:
% model.param.loadFile('FILENAME');
model.param.set('rp_neg', '2.50e-6[m]', 'Particle radius negative electrode');
model.param.set('rp_pos', '0.25e-6[m]', 'Particle radius positive electrode');
model.param.set('sigmas_neg', '100[S/m]', 'Electrical conductivity, negative electrode');
model.param.set('sigmas_pos', '91[S/m]', 'Electrical conductivity, positive electrode');
model.param.set('epss_pos', '1-epsl_pos-0.170', 'Solid phase volume fraction positive electrode');
model.param.set('epsl_pos', '0.41', 'Electrolyte phase volume fraction positive electrode');
model.param.set('brugl_pos', '2.98', 'Bruggeman coefficient for tortuosity in positive electrode');
model.param.set('epss_neg', '1-epsl_neg-0.172', 'Solid phase volume fraction negative electrode');
model.param.set('epsl_neg', '0.444', 'Electrolyte phase volume fraction negative electrode');
model.param.set('epsl_sep', '0.370', 'Electrolyte phase volume fraction separator');
model.param.set('brugl_sep', '3.15', 'Bruggeman coefficient for tortuosity in separator');
model.param.set('i0ref_neg', '0.96[A/m^2]', 'Reference exchange current density negative electrode');
model.param.set('i0ref_pos', '36.61[A/m^2]', 'Reference exchange current density positive electrode');
model.param.set('cl_0', '1200[mol/m^3]', 'Initial electrolyte salt concentration');
model.param.set('L_neg', '55e-6[m]', 'Length of negative electrode');
model.param.set('L_sep', '30e-6[m]', 'Length of separator');
model.param.set('L_pos', '40e-6[m]', 'Length of positive electrode');
model.param.set('T', '45[degC]', 'Cell temperature');
model.param.set('E_cell_100SOC', '4.1[V]', 'Cell voltage at 100% SOC');
model.param.set('E_cell_0SOC', '2.5[V]', 'Cell voltage at 100% SOC');
model.param.set('E_max', 'E_cell_100SOC', 'Maximum cell voltage in cycling protocol');
model.param.set('E_min', 'E_cell_0SOC', 'Minimum cell voltage in cycling protocol');
model.param.set('kappa_film', '5e-6[S/m]', 'SEI layer conductivity');
model.param.set('M_sei', '0.16[kg/mol]', 'Molar mass of product of side reaction');
model.param.set('rho_sei', '1.6e3[kg/m^3]', 'Density of product of side reaction');
model.param.set('dfilm_0', '1[nm]', 'Initial SEI layer thickness');
model.param.set('alpha', '0.67', 'Aging parameter');
model.param.set('J', '8.4e-4', 'Aging parameter');
model.param.set('f', '2.0e2[1/s]', 'Aging parameter');
model.param.set('H', '6.7', 'Aging parameter');
model.param.set('csmax_neg', '31507[mol/m^3]', 'Maximum concentration, negative');
model.param.set('i1C_loc', 'csmax_neg*0.8*F_const*rp_neg/(3*1[h])', 'Aging parameter');
model.param.set('Av_neg', '3*0.384/rp_neg', 'Surface area');
model.param.set('t_factor', '250', 'Time acceleration factor');
model.param.set('no_cycles', '2000', 'Number of cycles');
model.param.set('t_cycling', '(no_cycles+1)*10000/t_factor', 'Approximative total cycling time');
model.param.set('A_cell', '1[m^2]', 'Cell cross-sectional area');

model.geom('geom1').create('i1', 'Interval');
model.geom('geom1').feature('i1').set('specify', 'len');
model.geom('geom1').feature('i1').setIndex('len', 'L_neg', 0);
model.geom('geom1').feature('i1').setIndex('len', 'L_sep', 1);
model.geom('geom1').feature('i1').setIndex('len', 'L_pos', 2);
model.geom('geom1').runPre('fin');
model.geom('geom1').run;

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
model.material('mat2').propertyGroup.create('OperationalSOC', 'Operational electrode state-of-charge');
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
model.material('mat3').propertyGroup.create('OperationalSOC', 'Operational electrode state-of-charge');
model.material('mat3').propertyGroup.create('ic', 'Intercalation strain');
model.material('mat3').propertyGroup('ic').func.create('int1', 'Interpolation');
model.material('mat3').propertyGroup.create('EquilibriumConcentration', 'Equilibrium concentration');
model.material('mat3').label('NCA, LiNi0.8Co0.15Al0.05O2 (Positive, Li-ion Battery)');
model.material('mat3').propertyGroup('def').set('diffusion', {'1.5e-15[m^2/s]' '0' '0' '0' '1.5e-15[m^2/s]' '0' '0' '0' '1.5e-15[m^2/s]'});
model.material('mat3').propertyGroup('def').set('INFO_PREFIX:diffusion', 'S. Brown, N. Mellgren, M. Vynnycky, and G. Lindbergh, "Impedance as a Tool for Investigating Aging in Lithium-Ion Porous Electrodes. II. Positive Electrode Examination", J. Electrochemical Society, vol. 155, p. A320, 2008');
model.material('mat3').propertyGroup('def').set('electricconductivity', {'91[S/m]' '0' '0' '0' '91[S/m]' '0' '0' '0' '91[S/m]'});
model.material('mat3').propertyGroup('def').set('INFO_PREFIX:electricconductivity', 'S. Brown, N. Mellgren, M. Vynnycky, and G. Lindbergh, "Impedance as a Tool for Investigating Aging in Lithium-Ion Porous Electrodes. II. Positive Electrode Examination", J. Electrochemical Society, vol. 155, p. A320, 2008');
model.material('mat3').propertyGroup('def').set('density', '4740[kg/m^3]');
model.material('mat3').propertyGroup('def').set('INFO_PREFIX:density', 'N. Nitta, F. Wu, J. Tae Lee, and G. Yushin, Materials Today, Volume 18, Number 5, June 2015');
model.material('mat3').propertyGroup('def').set('csmax', '48000[mol/m^3]');
model.material('mat3').propertyGroup('def').descr('csmax', '');
model.material('mat3').propertyGroup('ElectrodePotential').func('int1').set('funcname', 'Eeq_int1');
model.material('mat3').propertyGroup('ElectrodePotential').func('int1').set('table', {'0.249' '4.2921';  ...
'0.2677' '4.2502';  ...
'0.2852' '4.2173';  ...
'0.3054' '4.1901';  ...
'0.3261' '4.1662';  ...
'0.3432' '4.1424';  ...
'0.3598' '4.1175';  ...
'0.3769' '4.0914';  ...
'0.4041' '4.054';  ...
'0.4247' '4.0268';  ...
'0.4489' '4.0007';  ...
'0.4729' '3.9723';  ...
'0.4947' '3.9519';  ...
'0.5178' '3.9293';  ...
'0.5354' '3.9089';  ...
'0.5554' '3.885';  ...
'0.5782' '3.8612';  ...
'0.5998' '3.8363';  ...
'0.6255' '3.8125';  ...
'0.6617' '3.7819';  ...
'0.6985' '3.7547';  ...
'0.7332' '3.7343';  ...
'0.7689' '3.7117';  ...
'0.8066' '3.689';  ...
'0.8247' '3.6766';  ...
'0.8424' '3.6641';  ...
'0.8595' '3.6528';  ...
'0.8776' '3.6369';  ...
'0.8952' '3.6221';  ...
'0.9133' '3.6063';  ...
'0.9308' '3.587';  ...
'0.9465' '3.5678';  ...
'0.9621' '3.5451';  ...
'0.9762' '3.5178';  ...
'0.9878' '3.4827';  ...
'0.9944' '3.4452';  ...
'0.9984' '3.3192';  ...
'1.0000' '3.1989'});
model.material('mat3').propertyGroup('ElectrodePotential').func('int1').set('interp', 'piecewisecubic');
model.material('mat3').propertyGroup('ElectrodePotential').func('int1').set('extrap', 'linear');
model.material('mat3').propertyGroup('ElectrodePotential').func('int1').set('fununit', {'V'});
model.material('mat3').propertyGroup('ElectrodePotential').func('int1').set('argunit', {''});
model.material('mat3').propertyGroup('ElectrodePotential').func('int1').set('defineinv', true);
model.material('mat3').propertyGroup('ElectrodePotential').func('int1').set('funcinvname', 'Eeq_inv');
model.material('mat3').propertyGroup('ElectrodePotential').func('int2').set('funcname', 'dEeqdT_int1');
model.material('mat3').propertyGroup('ElectrodePotential').func('int2').set('table', {'0.3' '0'; '0.45' '0'; '0.75' '-0.07e-3'; '0.85' '-0.08e-3'; '0.95' '-0.04e-3'});
model.material('mat3').propertyGroup('ElectrodePotential').func('int2').set('fununit', {'V/K'});
model.material('mat3').propertyGroup('ElectrodePotential').func('int2').set('argunit', {''});
model.material('mat3').propertyGroup('ElectrodePotential').set('Eeq', 'Eeq_int1(soc)+dEeqdT_int1(soc)*(T-298[K])');
model.material('mat3').propertyGroup('ElectrodePotential').set('INFO_PREFIX:Eeq', ['Asymmetry of Discharge/Charge Curves of Lithium-Ion Battery' newline 'Intercalation Electrodes, Florian Hall, Sabine Wussler, Hilmi Buqa, and Wolfgang G. Bessler, J. Phys. Chem. C 2016, 120, 23407-23414']);
model.material('mat3').propertyGroup('ElectrodePotential').set('dEeqdT', 'dEeqdT_int1(soc)');
model.material('mat3').propertyGroup('ElectrodePotential').set('INFO_PREFIX:dEeqdT', 'Determination of the Reversible and Irreversible Heats of a LiNi0.8Co0.15Al0.05O2 Natural Graphite Cell Using Electrochemical-Calorimetric Technique, Hui Yang and Jai Prakash, J. Electrochem. Soc. 2004 volume 151, issue 8, A1222-A1229');
model.material('mat3').propertyGroup('ElectrodePotential').set('cEeqref', 'def.csmax');
model.material('mat3').propertyGroup('ElectrodePotential').set('INFO_PREFIX:cEeqref', 'N. Nitta, F. Wu, J. Tae Lee, and G. Yushin, Materials Today, Volume 18, Number 5, June 2015');
model.material('mat3').propertyGroup('ElectrodePotential').set('soc', 'c/cEeqref');
model.material('mat3').propertyGroup('ElectrodePotential').descr('soc', '');
model.material('mat3').propertyGroup('ElectrodePotential').addInput('concentration');
model.material('mat3').propertyGroup('ElectrodePotential').addInput('temperature');
model.material('mat3').propertyGroup('OperationalSOC').set('socmax', 'elpot.Eeq_inv(E_min)');
model.material('mat3').propertyGroup('OperationalSOC').set('socmin', 'elpot.Eeq_inv(E_max)');
model.material('mat3').propertyGroup('OperationalSOC').set('E_max', '4.29[V]');
model.material('mat3').propertyGroup('OperationalSOC').set('E_min', '3.5[V]');
model.material('mat3').propertyGroup('ic').func('int1').set('funcname', 'dVOLdSOL');
model.material('mat3').propertyGroup('ic').func('int1').set('table', {'0.8878314072059823' '-0.03605514316012792';  ...
'0.8579197824609109' '-0.10392364793213194';  ...
'0.8280081577158396' '-0.20572640509013818';  ...
'0.7980965329707681' '-0.324496288441146';  ...
'0.769544527532291' '-0.4093319194061511';  ...
'0.7396329027872195' '-0.5111346765641573';  ...
'0.7083616587355539' '-0.5450689289501596';  ...
'0.6798096532970768' '-0.5620360551431607';  ...
'0.6485384092454112' '-0.5959703075291629';  ...
'0.619986403806934' '-0.6299045599151651';  ...
'0.5900747790618626' '-0.6638388123011669';  ...
'0.5601631543167913' '-0.7317073170731714';  ...
'0.5288919102651257' '-0.7995758218451754';  ...
'0.49898028552005425' '-0.884411452810181';  ...
'0.4704282800815771' '-0.9692470837751861';  ...
'0.44187627464309986' '-1.0540827147401917';  ...
'0.4119646498980285' '-1.2067868504772008';  ...
'0.38341264445955126' '-1.3594909862142108';  ...
'0.34942216179469743' '-1.6309650053022278';  ...
'0.3235893949694084' '-1.9872746553552503';  ...
'0.29231815091774294' '-2.513255567338283';  ...
'0.2624065261726717' '-3.3107104984093327';  ...
'0.2324949014276002' '-4.057264050901379';  ...
'0.20394289598912296' '-4.820784729586427';  ...
'0.16859279401767502' '-5.720042417815483'});
model.material('mat3').propertyGroup('ic').func('int1').set('extrap', 'linear');
model.material('mat3').propertyGroup('ic').func('int1').set('fununit', {'%'});
model.material('mat3').propertyGroup('ic').func('int1').set('argunit', {'1'});
model.material('mat3').propertyGroup('ic').set('dvol', 'dVOLdSOL(c/elpot.cEeqref)');
model.material('mat3').propertyGroup('ic').set('INFO_PREFIX:dvol', ['R. Koerver and others, ' native2unicode(hex2dec({'20' '1c'}), 'unicode') 'Chemo-mechanical expansion of lithium electrode materials ' native2unicode(hex2dec({'20' '14'}), 'unicode') ' on the route to mechanically optimized all-solid-state batteries,' native2unicode(hex2dec({'20' '1d'}), 'unicode') ' Energy Environ. Sci., vol. 11, pp. 2142' native2unicode(hex2dec({'20' '13'}), 'unicode') '2158, 201']);
model.material('mat3').propertyGroup('ic').addInput('concentration');
model.material('mat3').propertyGroup('EquilibriumConcentration').set('csEq', 'def.csmax*elpot.Eeq_inv(V)');
model.material('mat3').propertyGroup('EquilibriumConcentration').addInput('electricpotential');

model.selection.create('sel1', 'Explicit');
model.selection('sel1').model('comp1');
model.selection('sel1').label('Negative Electrode');
model.selection('sel1').set([1]);
model.selection.create('sel2', 'Explicit');
model.selection('sel2').model('comp1');
model.selection('sel2').label('Separator');
model.selection('sel2').set([2]);
model.selection.create('sel3', 'Explicit');
model.selection('sel3').model('comp1');
model.selection('sel3').label('Positive Electrode');
model.selection('sel3').set([3]);

model.physics('liion').prop('Ac').set('Ac', 'A_cell');
model.physics('liion').prop('CellSettings').set('CellSOCandInitialChargeInventory', true);
model.physics('liion').feature('socicd1').set('CellVoltageInputType', 'userdef');
model.physics('liion').feature('socicd1').set('Ecell_0SOC', 'E_cell_0SOC');
model.physics('liion').feature('socicd1').set('Ecell_100SOC', 'E_cell_100SOC');
model.physics('liion').feature('socicd1').set('InitialChargeType', 'CellVoltage');
model.physics('liion').feature('socicd1').set('Ecell_init', 'E_min');
model.physics('liion').feature('socicd1').feature('neges1').selection.named('sel1');
model.physics('liion').feature('socicd1').feature('poses1').selection.named('sel3');
model.physics('liion').feature('sep1').set('epsl', 'epsl_sep');
model.physics('liion').feature('sep1').set('IonicCorrModel', 'userdef');
model.physics('liion').feature('sep1').set('fl', 'epsl_sep^brugl_sep');
model.physics('liion').feature('sep1').set('DiffusionCorrModel', 'userdef');
model.physics('liion').feature('sep1').set('fDl', 'epsl_sep^brugl_sep');
model.physics('liion').create('pce1', 'PorousElectrode', 1);
model.physics('liion').feature('pce1').selection.named('sel1');
model.physics('liion').feature('pce1').set('sigma', {'sigmas_neg' '0' '0' '0' 'sigmas_neg' '0' '0' '0' 'sigmas_neg'});
model.physics('liion').feature('pce1').set('epss', 'epss_neg');
model.physics('liion').feature('pce1').set('epsl', 'epsl_neg');
model.physics('liion').feature('pce1').feature('pin1').set('ParticleMaterial', 'mat2');
model.physics('liion').feature('pce1').feature('pin1').set('rp', 'rp_neg');
model.physics('liion').feature('pce1').feature('pin1').set('Nel', 5);
model.physics('liion').feature('pce1').feature('pin1').set('FastAssembly', true);
model.physics('liion').feature('pce1').feature('per1').set('MaterialOption', 'mat2');
model.physics('liion').feature('pce1').feature('per1').set('i0_ref', 'i0ref_neg');
model.physics('liion').create('pce2', 'PorousElectrode', 1);
model.physics('liion').feature('pce2').selection.named('sel3');
model.physics('liion').feature('pce2').set('sigma', {'sigmas_pos' '0' '0' '0' 'sigmas_pos' '0' '0' '0' 'sigmas_pos'});
model.physics('liion').feature('pce2').set('epss', 'epss_pos');
model.physics('liion').feature('pce2').set('epsl', 'epsl_pos');
model.physics('liion').feature('pce2').set('IonicCorrModel', 'userdef');
model.physics('liion').feature('pce2').set('fl', 'liion.epsl^brugl_pos');
model.physics('liion').feature('pce2').set('DiffusionCorrModel', 'userdef');
model.physics('liion').feature('pce2').set('fDl', 'liion.epsl^brugl_pos');
model.physics('liion').feature('pce2').feature('pin1').set('ParticleMaterial', 'mat3');
model.physics('liion').feature('pce2').feature('pin1').set('rp', 'rp_pos');
model.physics('liion').feature('pce2').feature('pin1').set('Nel', 3);
model.physics('liion').feature('pce2').feature('pin1').set('FastAssembly', true);
model.physics('liion').feature('pce2').feature('per1').set('MaterialOption', 'mat3');
model.physics('liion').feature('pce2').feature('per1').set('i0_ref', 'i0ref_pos');
model.physics('liion').create('egnd1', 'ElectricGround', 0);
model.physics('liion').feature('egnd1').selection.set([1]);

model.common('cminpt').set('modified', {'temperature' 'T'});

model.func.create('pw1', 'Piecewise');
model.func('pw1').model('comp1');
model.func('pw1').set('funcname', 'K');
model.func('pw1').set('smooth', 'cont');
model.func('pw1').set('pieces', {'0' '0.3' '2'; '0.3' '0.7' '0'; '0.7' '1' '1'});

model.variable.create('var1');
model.variable('var1').model('comp1');

% To import content from file, use:
% model.variable('var1').loadFile('FILENAME');
model.variable('var1').set('I_SEI', '-(1-H*(liion.iloc_per1<0)*liion.iloc_per1/i1C_loc*K(liion.cs_average/liion.csmax))*J*i1C_loc/(exp(alpha*eta_SEI*F_const/(R_const*T))+Q_SEI/Av_neg*f*J/i1C_loc)', 'Parasitic reaction current');
model.variable('var1').set('Q_SEI', 'liion.c_pce1_sei*F_const', 'Parasitic reaction capacity');
model.variable('var1').set('eta_SEI', 'liion.eta_per2', 'Overpotential for parasitic reaction');
model.variable('var1').set('cycle_no', 'comp1.liion.cdc1.cycle_counter*t_factor', 'Number of cycles');
model.variable('var1').set('dch_filter', 'comp1.liion.cdc1.CC_DCH', 'Discharge filter (for plotting)');
model.variable('var1').set('dch_start_filter', 'comp1.liion.cdc1.CC_DCH&& ((t-1)<comp1.liion.cdc1.t_dch_start)', 'Discharge onset filter (for plotting)');
model.variable('var1').set('ch_start_filter', 'comp1.liion.cdc1.CC_CH && ((t-1)<comp1.liion.cdc1.t_ch_start && cycle_no>0)', 'Charge onset filter (for plotting)');
model.variable('var1').set('first_cycle_filter', 'round(comp1.liion.cdc1.cycle_counter)==0', 'First cycle filter (for plotting)');
model.variable('var1').set('last_cycle_filter', 'round(comp1.liion.cdc1.cycle_counter*t_factor)==no_cycles', 'Last cycle filter (for plotting)');
model.variable('var1').set('I_cell', 'liion.cdc1.Icell', 'Cell current');
model.variable('var1').set('E_cell', 'liion.cdc1.phis0', 'Cell voltage');
model.variable('var1').set('i_1C', 'liion.I_1C_cell', '1C cell current');

model.study('std1').feature('time').set('tlist', 'range(0,180,(no_cycles+1)*t_cycling/t_factor)');

model.title('1D Lithium-Ion Battery Model for the Capacity Fade Tutorial');

model.description('This is a template MPH-file containing the physics, geometry, and mesh of a lithium-ion battery. The template is used in the capacity_fade tutorial model.');

model.label('capacity_fade_seed.mph');

model.physics('liion').create('cdc1', 'ChargeDischargeCycling', 0);
model.physics('liion').feature('cdc1').selection.set([4]);
model.physics('liion').feature('cdc1').set('Idch', '-i_1C');
model.physics('liion').feature('cdc1').set('Vmin', 'E_min');
model.physics('liion').feature('cdc1').set('Ich', 'i_1C');
model.physics('liion').feature('cdc1').set('Vmax', 'E_max');
model.physics('liion').feature('cdc1').set('item.CVCH', true);
model.physics('liion').feature('cdc1').set('iupper', 'i_1C/20');
model.physics('liion').feature('cdc1').set('StartWith', 'Charge_first');
model.physics('liion').feature('pce1').setIndex('Species', 's1', 0, 0);
model.physics('liion').feature('pce1').setIndex('rhos', 8960, 0, 0);
model.physics('liion').feature('pce1').setIndex('Ms', 0.06355, 0, 0);
model.physics('liion').feature('pce1').setIndex('Species', 's1', 0, 0);
model.physics('liion').feature('pce1').setIndex('rhos', 8960, 0, 0);
model.physics('liion').feature('pce1').setIndex('Ms', 0.06355, 0, 0);
model.physics('liion').feature('pce1').setIndex('Species', 'sei', 0, 0);
model.physics('liion').feature('pce1').setIndex('rhos', 'rho_sei', 0, 0);
model.physics('liion').feature('pce1').setIndex('Ms', 'M_sei', 0, 0);
model.physics('liion').feature('pce1').set('AddVolumeChangeToElectrodeVolumeFraction', false);
model.physics('liion').feature('pce1').set('FilmResistanceType', 'ThicknessAndConductivity');
model.physics('liion').feature('pce1').set('sf0', 'dfilm_0');
model.physics('liion').feature('pce1').set('dsf_src', 'root.comp1.liion.sbtot_pce1');
model.physics('liion').feature('pce1').set('sigmaf', 'kappa_film');
model.physics('liion').feature('pce1').create('per2', 'PorousElectrodeReaction', 1);
model.physics('liion').feature('pce1').feature('per2').set('Eeq_mat', 'userdef');
model.physics('liion').feature('pce1').feature('per2').set('ilocmat_mat', 'userdef');
model.physics('liion').feature('pce1').feature('per2').set('ilocmat', 'I_SEI*(cycle_no>0)');
model.physics('liion').feature('pce1').feature('per2').set('VLiTheta', '-(t_factor-1)');
model.physics('liion').feature('pce1').feature('per2').setIndex('Vib', 't_factor', 0, 0);
model.physics('liion').feature('pce1').feature('per2').set('dEeqdT_mat', 'userdef');

model.cpl.create('intop1', 'Integration', 'geom1');
model.cpl('intop1').set('axisym', true);
model.cpl('intop1').selection.named('sel1');

model.sol.create('sol1');
model.sol('sol1').study('std1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'cdi');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').feature('comp1_phil').set('scalemethod', 'manual');
model.sol('sol1').feature('v1').feature('comp1_phis').set('scalemethod', 'manual');
model.sol('sol1').feature('v1').feature('comp1_liion_cdc1_phis0').set('scalemethod', 'manual');
model.sol('sol1').feature('v1').feature('comp1_cl').set('scalemethod', 'manual');
model.sol('sol1').feature('v1').feature('comp1_phil').set('scaleval', '1');
model.sol('sol1').feature('v1').feature('comp1_phis').set('scaleval', '1');
model.sol('sol1').feature('v1').feature('comp1_liion_cdc1_phis0').set('scaleval', '1');
model.sol('sol1').feature('v1').feature('comp1_cl').set('scaleval', '1000');
model.sol('sol1').feature('v1').set('control', 'cdi');
model.sol('sol1').create('s1', 'Stationary');
model.sol('sol1').feature('s1').set('stol', 1.0E-4);
model.sol('sol1').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('s1').feature('fc1').set('dtech', 'auto');
model.sol('sol1').feature('s1').feature('fc1').set('maxiter', 50);
model.sol('sol1').feature('s1').feature('fc1').set('minstep', 1.0E-6);
model.sol('sol1').feature('s1').create('d1', 'Direct');
model.sol('sol1').feature('s1').feature('d1').set('linsolver', 'pardiso');
model.sol('sol1').feature('s1').feature('d1').label('Direct (liion)');
model.sol('sol1').feature('s1').create('i1', 'Iterative');
model.sol('sol1').feature('s1').feature('i1').set('maxlinit', 1000);
model.sol('sol1').feature('s1').feature('i1').set('nlinnormuse', 'on');
model.sol('sol1').feature('s1').feature('i1').label('Algebraic Multigrid (liion)');
model.sol('sol1').feature('s1').feature('i1').create('mg1', 'Multigrid');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').set('prefun', 'saamg');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').set('maxcoarsedof', 50000);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').set('saamgcompwise', false);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').set('compactaggregation', true);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('pr').create('va1', 'Vanka');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('pr').feature('va1').set('vankavars', {'comp1_liion_phis_lm'});
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('po').create('va1', 'Vanka');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('po').feature('va1').set('vankavars', {'comp1_liion_phis_lm'});
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('cs').create('d1', 'Direct');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('cs').feature('d1').set('linsolver', 'pardiso');
model.sol('sol1').feature('s1').create('i2', 'Iterative');
model.sol('sol1').feature('s1').feature('i2').set('maxlinit', 1000);
model.sol('sol1').feature('s1').feature('i2').set('nlinnormuse', 'on');
model.sol('sol1').feature('s1').feature('i2').label('Geometric Multigrid (liion)');
model.sol('sol1').feature('s1').feature('i2').create('mg1', 'Multigrid');
model.sol('sol1').feature('s1').feature('i2').feature('mg1').feature('pr').create('va1', 'Vanka');
model.sol('sol1').feature('s1').feature('i2').feature('mg1').feature('pr').feature('va1').set('vankavars', {'comp1_liion_phis_lm'});
model.sol('sol1').feature('s1').feature('i2').feature('mg1').feature('po').create('va1', 'Vanka');
model.sol('sol1').feature('s1').feature('i2').feature('mg1').feature('po').feature('va1').set('vankavars', {'comp1_liion_phis_lm'});
model.sol('sol1').feature('s1').feature('i2').feature('mg1').feature('cs').create('d1', 'Direct');
model.sol('sol1').feature('s1').feature('i2').feature('mg1').feature('cs').feature('d1').set('linsolver', 'pardiso');
model.sol('sol1').feature('s1').feature('fc1').set('linsolver', 'd1');
model.sol('sol1').feature('s1').feature('fc1').set('dtech', 'auto');
model.sol('sol1').feature('s1').feature('fc1').set('maxiter', 50);
model.sol('sol1').feature('s1').feature('fc1').set('minstep', 1.0E-6);
model.sol('sol1').feature('s1').feature.remove('fcDef');
model.sol('sol1').create('su1', 'StoreSolution');
model.sol('sol1').create('st2', 'StudyStep');
model.sol('sol1').feature('st2').set('study', 'std1');
model.sol('sol1').feature('st2').set('studystep', 'time');
model.sol('sol1').create('v2', 'Variables');
model.sol('sol1').feature('v2').feature('comp1_phil').set('scalemethod', 'manual');
model.sol('sol1').feature('v2').feature('comp1_liion_pce1_csfast').set('scalemethod', 'manual');
model.sol('sol1').feature('v2').feature('comp1_liion_pce2_csfast').set('scalemethod', 'manual');
model.sol('sol1').feature('v2').feature('comp1_phis').set('scalemethod', 'manual');
model.sol('sol1').feature('v2').feature('comp1_liion_cdc1_phis0').set('scalemethod', 'manual');
model.sol('sol1').feature('v2').feature('comp1_cl').set('scalemethod', 'manual');
model.sol('sol1').feature('v2').feature('comp1_phil').set('scaleval', '1');
model.sol('sol1').feature('v2').feature('comp1_liion_pce1_csfast').set('scaleval', '10000');
model.sol('sol1').feature('v2').feature('comp1_liion_pce2_csfast').set('scaleval', '10000');
model.sol('sol1').feature('v2').feature('comp1_phis').set('scaleval', '1');
model.sol('sol1').feature('v2').feature('comp1_liion_cdc1_phis0').set('scaleval', '1');
model.sol('sol1').feature('v2').feature('comp1_cl').set('scaleval', '1000');
model.sol('sol1').feature('v2').set('initmethod', 'sol');
model.sol('sol1').feature('v2').set('initsol', 'sol1');
model.sol('sol1').feature('v2').set('initsoluse', 'sol2');
model.sol('sol1').feature('v2').set('notsolmethod', 'sol');
model.sol('sol1').feature('v2').set('notsol', 'sol1');
model.sol('sol1').feature('v2').set('notsoluse', 'sol2');
model.sol('sol1').feature('v2').set('control', 'time');
model.sol('sol1').create('t1', 'Time');
model.sol('sol1').feature('t1').set('tlist', 'range(0,180,(no_cycles+1)*t_cycling/t_factor)');
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
model.sol('sol1').feature('t1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('t1').feature('fc1').set('dtech', 'auto');
model.sol('sol1').feature('t1').create('d1', 'Direct');
model.sol('sol1').feature('t1').feature('d1').set('linsolver', 'pardiso');
model.sol('sol1').feature('t1').feature('d1').label('Direct (liion)');
model.sol('sol1').feature('t1').create('i1', 'Iterative');
model.sol('sol1').feature('t1').feature('i1').set('maxlinit', 1000);
model.sol('sol1').feature('t1').feature('i1').set('nlinnormuse', 'on');
model.sol('sol1').feature('t1').feature('i1').label('Algebraic Multigrid (liion)');
model.sol('sol1').feature('t1').feature('i1').create('mg1', 'Multigrid');
model.sol('sol1').feature('t1').feature('i1').feature('mg1').set('prefun', 'saamg');
model.sol('sol1').feature('t1').feature('i1').feature('mg1').set('maxcoarsedof', 50000);
model.sol('sol1').feature('t1').feature('i1').feature('mg1').set('saamgcompwise', false);
model.sol('sol1').feature('t1').feature('i1').feature('mg1').set('compactaggregation', true);
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('pr').create('va1', 'Vanka');
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('pr').feature('va1').set('vankavars', {'comp1_liion_phis_lm'});
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('po').create('va1', 'Vanka');
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('po').feature('va1').set('vankavars', {'comp1_liion_phis_lm'});
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('cs').create('d1', 'Direct');
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('cs').feature('d1').set('linsolver', 'pardiso');
model.sol('sol1').feature('t1').create('i2', 'Iterative');
model.sol('sol1').feature('t1').feature('i2').set('maxlinit', 1000);
model.sol('sol1').feature('t1').feature('i2').set('nlinnormuse', 'on');
model.sol('sol1').feature('t1').feature('i2').label('Geometric Multigrid (liion)');
model.sol('sol1').feature('t1').feature('i2').create('mg1', 'Multigrid');
model.sol('sol1').feature('t1').feature('i2').feature('mg1').feature('pr').create('va1', 'Vanka');
model.sol('sol1').feature('t1').feature('i2').feature('mg1').feature('pr').feature('va1').set('vankavars', {'comp1_liion_phis_lm'});
model.sol('sol1').feature('t1').feature('i2').feature('mg1').feature('po').create('va1', 'Vanka');
model.sol('sol1').feature('t1').feature('i2').feature('mg1').feature('po').feature('va1').set('vankavars', {'comp1_liion_phis_lm'});
model.sol('sol1').feature('t1').feature('i2').feature('mg1').feature('cs').create('d1', 'Direct');
model.sol('sol1').feature('t1').feature('i2').feature('mg1').feature('cs').feature('d1').set('linsolver', 'pardiso');
model.sol('sol1').feature('t1').feature('fc1').set('linsolver', 'd1');
model.sol('sol1').feature('t1').feature('fc1').set('dtech', 'auto');
model.sol('sol1').feature('t1').feature.remove('fcDef');
model.sol('sol1').attach('std1');

model.study('std1').feature('cdi').set('useadvanceddisable', true);
model.study('std1').feature('cdi').set('disabledphysics', {'liion/pce1/per2'});

model.sol('sol1').feature('t1').create('st1', 'StopCondition');
model.sol('sol1').feature('t1').feature('st1').setIndex('stopcondarr', '', 0);
model.sol('sol1').feature('t1').feature('st1').setIndex('stopcondterminateon', 'true', 0);
model.sol('sol1').feature('t1').feature('st1').setIndex('stopcondActive', true, 0);
model.sol('sol1').feature('t1').feature('st1').setIndex('stopconddesc', 'Stop expression 1', 0);
model.sol('sol1').feature('t1').feature('st1').setIndex('stopcondarr', '', 0);
model.sol('sol1').feature('t1').feature('st1').setIndex('stopcondterminateon', 'true', 0);
model.sol('sol1').feature('t1').feature('st1').setIndex('stopcondActive', true, 0);
model.sol('sol1').feature('t1').feature('st1').setIndex('stopconddesc', 'Stop expression 1', 0);
model.sol('sol1').feature('t1').feature('st1').setIndex('stopcondarr', 'comp1.cycle_no>(no_cycles)', 0);
model.sol('sol1').feature('t1').feature('st1').set('storestopcondsol', 'stepbefore_stepafter');
model.sol('sol1').feature('t1').feature('st1').set('stopcondwarn', false);

model.study('std1').setGenPlots(false);

model.sol('sol1').runAll;

model.result.create('pg1', 'PlotGroup1D');
model.result('pg1').run;
model.result('pg1').label('Load cycle');
model.result('pg1').set('titletype', 'none');
model.result('pg1').set('twoyaxes', true);
model.result('pg1').create('glob1', 'Global');
model.result('pg1').feature('glob1').set('markerpos', 'datapoints');
model.result('pg1').feature('glob1').set('linewidth', 'preference');
model.result('pg1').feature('glob1').setIndex('expr', 'I_cell', 0);
model.result('pg1').feature('glob1').create('filt1', 'GlobalFilter');
model.result('pg1').run;
model.result('pg1').feature('glob1').feature('filt1').set('expr', 'first_cycle_filter');
model.result('pg1').run;
model.result('pg1').feature.duplicate('glob2', 'glob1');
model.result('pg1').run;
model.result('pg1').feature('glob2').set('plotonsecyaxis', true);
model.result('pg1').feature('glob2').setIndex('expr', 'E_cell', 0);
model.result('pg1').feature('glob2').setIndex('descr', 'Cell potential', 0);
model.result('pg1').run;
model.result('pg1').run;
model.result.create('pg2', 'PlotGroup1D');
model.result('pg2').run;
model.result('pg2').label('Discharge curve comparison');
model.result('pg2').set('titletype', 'manual');
model.result('pg2').set('title', 'Color Legend: Number of cycles');
model.result('pg2').set('ylabelactive', true);
model.result('pg2').set('ylabel', 'Cell potential (V)');
model.result('pg2').create('glob1', 'Global');
model.result('pg2').feature('glob1').set('markerpos', 'datapoints');
model.result('pg2').feature('glob1').set('linewidth', 'preference');
model.result('pg2').feature('glob1').setIndex('expr', 'E_cell', 0);
model.result('pg2').feature('glob1').setIndex('descr', 'Discharge voltage', 0);
model.result('pg2').feature('glob1').set('xdata', 'expr');
model.result('pg2').feature('glob1').set('xdataexpr', '(t-liion.cdc1.t_dch_start)');
model.result('pg2').feature('glob1').create('filt1', 'GlobalFilter');
model.result('pg2').run;
model.result('pg2').feature('glob1').feature('filt1').set('expr', 'dch_filter');
model.result('pg2').feature('glob1').feature('filt1').set('xdec', false);
model.result('pg2').run;
model.result('pg2').feature('glob1').create('col1', 'Color');
model.result('pg2').run;
model.result('pg2').feature('glob1').feature('col1').set('expr', 'cycle_no');
model.result('pg2').run;
model.result.create('pg3', 'PlotGroup1D');
model.result('pg3').run;
model.result('pg3').label('SEI layer potential drop at 1C');
model.result('pg3').set('titletype', 'label');
model.result('pg3').set('ylabelactive', true);
model.result('pg3').set('ylabel', 'Potential drop over SEI layer (V)');
model.result('pg3').create('ptgr1', 'PointGraph');
model.result('pg3').feature('ptgr1').set('markerpos', 'datapoints');
model.result('pg3').feature('ptgr1').set('linewidth', 'preference');
model.result('pg3').feature('ptgr1').selection.set([1]);
model.result('pg3').feature('ptgr1').set('expr', '-liion.deltaphi');
model.result('pg3').feature('ptgr1').set('xdata', 'expr');
model.result('pg3').feature('ptgr1').set('xdataexpr', 'cycle_no');
model.result('pg3').feature('ptgr1').set('xdatadescractive', true);
model.result('pg3').feature('ptgr1').set('xdatadescr', 'Cycle number');
model.result('pg3').feature('ptgr1').set('legend', true);
model.result('pg3').feature('ptgr1').set('legendmethod', 'manual');
model.result('pg3').feature('ptgr1').setIndex('legends', 'At negative electrode-current collector', 0);
model.result('pg3').feature('ptgr1').create('filt1', 'PointGraphFilter');
model.result('pg3').run;
model.result('pg3').feature('ptgr1').feature('filt1').set('expr', 'dch_start_filter');
model.result('pg3').run;
model.result('pg3').feature.duplicate('ptgr2', 'ptgr1');
model.result('pg3').run;
model.result('pg3').feature('ptgr2').selection.set([2]);
model.result('pg3').feature('ptgr2').setIndex('legends', 'At negative electrode-separator', 0);
model.result('pg3').run;
model.result('pg3').run;
model.result.duplicate('pg4', 'pg3');
model.result('pg4').run;
model.result('pg4').label('Electrolyte volume fraction');
model.result('pg4').set('ylabel', 'Electrolyte volume fraction (1)');
model.result('pg4').run;
model.result('pg4').feature('ptgr1').set('expr', 'liion.epsl');
model.result('pg4').run;
model.result('pg4').feature('ptgr2').set('expr', 'down(liion.epsl)');
model.result('pg4').run;
model.result.create('pg5', 'PlotGroup1D');
model.result('pg5').run;
model.result('pg5').label('Capacity vs. time');
model.result('pg5').set('titletype', 'none');
model.result('pg5').set('xlabelactive', true);
model.result('pg5').set('xlabel', 'Time (days) (d)');
model.result('pg5').set('ylabelactive', true);
model.result('pg5').set('ylabel', 'Relative capacity (1)');
model.result('pg5').create('glob1', 'Global');
model.result('pg5').feature('glob1').set('markerpos', 'datapoints');
model.result('pg5').feature('glob1').set('linewidth', 'preference');
model.result('pg5').feature('glob1').set('expr', {'liion.SOH_cell'});
model.result('pg5').feature('glob1').set('descr', {'Cell state of health'});
model.result('pg5').feature('glob1').set('unit', {'1'});
model.result('pg5').feature('glob1').set('xdata', 'expr');
model.result('pg5').feature('glob1').set('xdataexpr', 't*t_factor');
model.result('pg5').feature('glob1').set('xdatadescractive', true);
model.result('pg5').feature('glob1').set('xdataunit', 'd');
model.result('pg5').feature('glob1').set('xdatadescr', 'Time (days)');
model.result('pg5').feature('glob1').set('legendmethod', 'manual');
model.result('pg5').feature('glob1').setIndex('legends', 'Based on cyclable lithium', 0);
model.result('pg5').feature('glob1').create('filt1', 'GlobalFilter');
model.result('pg5').run;
model.result('pg5').feature('glob1').feature('filt1').set('expr', 'ch_start_filter');
model.result('pg5').run;
model.result('pg5').feature.duplicate('glob2', 'glob1');
model.result('pg5').run;
model.result('pg5').feature('glob2').setIndex('expr', '(t-liion.cdc1.t_dch_start)/3570[s]', 0);
model.result('pg5').feature('glob2').setIndex('legends', 'Nominal 1C discharge capacity', 0);
model.result('pg5').run;
model.result('pg5').run;
model.result.duplicate('pg6', 'pg5');
model.result('pg6').run;
model.result('pg6').label('Capacity vs. cycle number');
model.result('pg6').set('xlabel', 'Cycle number (1)');
model.result('pg6').run;
model.result('pg6').feature('glob1').set('xdataexpr', 'cycle_no');
model.result('pg6').run;
model.result('pg6').feature('glob2').set('xdataexpr', 'cycle_no');
model.result('pg6').run;
model.result.create('pg7', 'PlotGroup1D');
model.result('pg7').run;
model.result('pg7').label('Local state of charge at separator-electrode interface');
model.result('pg7').set('titletype', 'label');
model.result('pg7').set('ylabelactive', true);
model.result('pg7').set('ylabel', 'SOC (1)');
model.result('pg7').create('ptgr1', 'PointGraph');
model.result('pg7').feature('ptgr1').set('markerpos', 'datapoints');
model.result('pg7').feature('ptgr1').set('linewidth', 'preference');
model.result('pg7').feature('ptgr1').selection.set([2]);
model.result('pg7').feature('ptgr1').set('expr', 'liion.socloc_surface');
model.result('pg7').feature('ptgr1').set('xdata', 'expr');
model.result('pg7').feature('ptgr1').set('xdataexpr', 't-liion.cdc1.t_ch_start');
model.result('pg7').feature('ptgr1').set('legend', true);
model.result('pg7').feature('ptgr1').set('legendmethod', 'manual');
model.result('pg7').feature('ptgr1').setIndex('legends', 'Negative Electrode - First Cycle', 0);
model.result('pg7').feature('ptgr1').create('filt1', 'PointGraphFilter');
model.result('pg7').run;
model.result('pg7').feature('ptgr1').feature('filt1').set('expr', 'first_cycle_filter');
model.result('pg7').run;
model.result('pg7').feature.duplicate('ptgr2', 'ptgr1');
model.result('pg7').run;
model.result('pg7').feature('ptgr2').selection.set([3]);
model.result('pg7').feature('ptgr2').setIndex('legends', 'Positive Electrode - First Cycle', 0);
model.result('pg7').run;
model.result('pg7').feature.duplicate('ptgr3', 'ptgr1');
model.result('pg7').run;
model.result('pg7').feature('ptgr3').setIndex('legends', 'Negative Electrode - Last Cycle', 0);
model.result('pg7').run;
model.result('pg7').feature('ptgr3').feature('filt1').set('expr', 'last_cycle_filter');
model.result('pg7').run;
model.result('pg7').feature.duplicate('ptgr4', 'ptgr2');
model.result('pg7').run;
model.result('pg7').feature('ptgr4').setIndex('legends', 'Positive Electrode - Last Cycle', 0);
model.result('pg7').run;
model.result('pg7').feature('ptgr4').feature('filt1').set('expr', 'last_cycle_filter');
model.result('pg7').run;

model.study('std1').feature('time').set('plot', true);
model.study('std1').feature('time').set('plotgroup', 'pg2');

model.title('Capacity Fade of a Lithium-Ion Battery');

model.description(['This 1D model demonstrates how to simulate battery aging due to SEI (solid-electrolyte-interface) formation in the graphite electrode of a lithium-ion battery. The Charge-Discharge Cycling feature is used to switch between constant voltage and constant current operation, and between charge and discharge.' newline  newline 'Cyclable lithium is lost and the resistance of the SEI layer increases in the negative electrode due to a parasitic lithium/solvent SEI forming reduction reaction.']);

model.label('capacity_fade.mph');

model.modelNode.label('Components');

out = model;
