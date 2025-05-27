function out = model
%
% li_battery_solid_electrolyte.m
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
model.physics('liion').prop('ElectrolyteType').set('ElectrolyteType', 'SingleIonConductor');
model.physics('liion').feature('sep1').set('epsl', {'1'});

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
model.param.set('L_pos', '65[um]', 'Thickness of positive electrode');
model.param.set('L_neg', '85[um]', 'Thickness of negative electrode');
model.param.set('L_electrolyte', '45[um]', 'Thickness of electrolyte region');
model.param.set('epss_pos', '0.44', 'Solid phase volume fraction of positive electrode');
model.param.set('epss_neg', '0.42', 'Solid phase volume fraction of negative electrode');
model.param.set('rp', '5e-7[m]', 'Particle size in negative and positive electrodes');
model.param.set('sigmas_neg', '100[S/m]', 'Electrical conductivity of negative electrode');
model.param.set('sigmas_pos', '1.13[mS/cm]', 'Electrical conductivity of positive electrode');
model.param.set('sigmal', '0.02[S/m]', 'Electrolyte conductivity');
model.param.set('i0ref_neg', '3.04e-2[A/m^2]', 'Reference exchange current density negative electrode');
model.param.set('i0ref_pos', '5.43e-2[A/m^2]', 'Reference exchange current density positive electrode');
model.param.set('SOC_0', '1', 'Initial SOC');
model.param.set('C_rate', '1', 'C-rate parameter');

model.geom('geom1').create('i1', 'Interval');
model.geom('geom1').feature('i1').set('specify', 'len');
model.geom('geom1').feature('i1').setIndex('len', 'L_neg', 0);
model.geom('geom1').feature('i1').setIndex('len', 'L_electrolyte', 1);
model.geom('geom1').feature('i1').setIndex('len', 'L_pos', 2);
model.geom('geom1').run('i1');

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

model.geom('geom1').run;

model.material.create('mat2', 'Common', 'comp1');
model.material('mat2').propertyGroup.create('ElectrodePotential', 'Equilibrium potential');
model.material('mat2').propertyGroup('ElectrodePotential').func.create('int1', 'Interpolation');
model.material('mat2').propertyGroup('ElectrodePotential').func.create('int2', 'Interpolation');
model.material('mat2').propertyGroup.create('OperationalSOC', 'Operational electrode state of charge');
model.material('mat2').propertyGroup.create('ic', 'Intercalation strain');
model.material('mat2').propertyGroup('ic').func.create('int1', 'Interpolation');
model.material('mat2').propertyGroup.create('EquilibriumConcentration', 'Equilibrium concentration');
model.material('mat2').label('LCO, LiCoO2 (Positive, Li-ion Battery)');
model.material('mat2').comments([ newline ]);
model.material('mat2').propertyGroup('def').set('poissonsratio', '');
model.material('mat2').propertyGroup('def').set('youngsmodulus', '');
model.material('mat2').propertyGroup('def').set('thermalexpansioncoefficient', '');
model.material('mat2').propertyGroup('def').set('poissonsratio', '0.24');
model.material('mat2').propertyGroup('def').set('INFO_PREFIX:poissonsratio', ['E. Cheng, N. Taylor, J. Wolfenstine and J. Sakamoto, Elastic properties of lithium cobalt oxide (LiCoO2), Journal of Asian Ceramic Societies, 5:2,' newline '113-117, (2017), DOI: 10.1016/j.jascer.2017.03.001']);
model.material('mat2').propertyGroup('def').set('youngsmodulus', '191[GPa]');
model.material('mat2').propertyGroup('def').set('INFO_PREFIX:youngsmodulus', ['E. Cheng, N. Taylor, J. Wolfenstine and J. Sakamoto, Elastic properties of lithium cobalt oxide (LiCoO2), Journal of Asian Ceramic Societies, 5:2,' newline '113-117, (2017), DOI: 10.1016/j.jascer.2017.03.001']);
model.material('mat2').propertyGroup('def').set('thermalexpansioncoefficient', {'1.3e-5[1/K]' '0' '0' '0' '1.3e-5[1/K]' '0' '0' '0' '1.3e-5[1/K]'});
model.material('mat2').propertyGroup('def').set('INFO_PREFIX:thermalexpansioncoefficient', ['E. Cheng, N. Taylor, J. Wolfenstine and J. Sakamoto, Elastic properties of lithium cobalt oxide (LiCoO2), Journal of Asian Ceramic Societies, 5:2,' newline '113-117, (2017), DOI: 10.1016/j.jascer.2017.03.001']);
model.material('mat2').propertyGroup('def').set('electricconductivity', {'1.13[mS/cm]' '0' '0' '0' '1.13[mS/cm]' '0' '0' '0' '1.13[mS/cm]'});
model.material('mat2').propertyGroup('def').set('INFO_PREFIX:electricconductivity', 'M. Tang, P. Albertus, J. Harb, and J. Newman, "Two-Dimensional Modeling of Lithium Deposition during Cell Charging", J. Electrochemical Society, vol. 156, p. A390, 2009');
model.material('mat2').propertyGroup('def').set('diffusion', {'5e-13[m^2/s]' '0' '0' '0' '5e-13[m^2/s]' '0' '0' '0' '5e-13[m^2/s]'});
model.material('mat2').propertyGroup('def').set('INFO_PREFIX:diffusion', 'D. Stephenson, E. Hartman, J. Harb, D. Wheeler, "Modeling of Particle-Particle Interactions in Porous Cathodes for Lithium-Ion Batteries", J. Electrochemical Society, vol. 154, p. A1146, 2007');
model.material('mat2').propertyGroup('def').set('density', '5000[kg/m^3]');
model.material('mat2').propertyGroup('def').set('INFO_PREFIX:density', 'N. Nitta, F. Wu, J. Tae Lee, and G. Yushin, Materials Today, Volume 18, Number 5, June 2015');
model.material('mat2').propertyGroup('def').set('csmax', '56250[mol/m^3]');
model.material('mat2').propertyGroup('def').descr('csmax', '');
model.material('mat2').propertyGroup('ElectrodePotential').func('int1').set('funcname', 'Eeq_int1');
model.material('mat2').propertyGroup('ElectrodePotential').func('int1').set('table', {'0.43' '4.3';  ...
'0.44' '4.281';  ...
'0.48' '4.22';  ...
'0.52' '4.164';  ...
'0.53' '4.153';  ...
'0.54' '4.138';  ...
'0.55' '4.128';  ...
'0.56' '4.116';  ...
'0.57' '4.103';  ...
'0.58' '4.09';  ...
'0.59' '4.0796';  ...
'0.6' '4.068';  ...
'0.61' '4.057';  ...
'0.62' '4.0456';  ...
'0.63' '4.036';  ...
'0.64' '4.027';  ...
'0.65' '4.01789';  ...
'0.66' '4.00836937';  ...
'0.67' '3.9986331';  ...
'0.68' '3.989454406';  ...
'0.69' '3.980817079';  ...
'0.7' '3.972704909';  ...
'0.71' '3.965101686';  ...
'0.72' '3.9579912';  ...
'0.73' '3.951357242';  ...
'0.74' '3.945183603';  ...
'0.75' '3.939454073';  ...
'0.76' '3.934152442';  ...
'0.77' '3.9292625';  ...
'0.78' '3.924768038';  ...
'0.79' '3.920652847';  ...
'0.8' '3.916900717';  ...
'0.81' '3.913495438';  ...
'0.82' '3.9104208';  ...
'0.83' '3.907660594';  ...
'0.84' '3.905198611';  ...
'0.85' '3.903018641';  ...
'0.86' '3.901104473';  ...
'0.87' '3.899439898';  ...
'0.88' '3.898008701';  ...
'0.89' '3.896794651';  ...
'0.9' '3.895781427';  ...
'0.91' '3.894952278';  ...
'0.92' '3.894288329';  ...
'0.93' '3.89376025';  ...
'0.94' '3.89328727';  ...
'0.95' '3.892535492';  ...
'0.96' '3.889926117';  ...
'0.97' '3.877773567';  ...
'0.98' '3.818815742';  ...
'0.99' '3.541235608';  ...
'1' '2.422342044'});
model.material('mat2').propertyGroup('ElectrodePotential').func('int1').set('interp', 'piecewisecubic');
model.material('mat2').propertyGroup('ElectrodePotential').func('int1').set('extrap', 'linear');
model.material('mat2').propertyGroup('ElectrodePotential').func('int1').set('fununit', {'V'});
model.material('mat2').propertyGroup('ElectrodePotential').func('int1').set('argunit', {''});
model.material('mat2').propertyGroup('ElectrodePotential').func('int1').set('defineinv', true);
model.material('mat2').propertyGroup('ElectrodePotential').func('int1').set('funcinvname', 'Eeq_inv');
model.material('mat2').propertyGroup('ElectrodePotential').func('int2').set('funcname', 'dEeqdT_int1');
model.material('mat2').propertyGroup('ElectrodePotential').func('int2').set('table', {'0.545' '-0.33e-3';  ...
'0.55' '-0.33e-3';  ...
'0.56' '-0.562e-3';  ...
'0.575' '-0.51e-3';  ...
'0.63' '-0.09e-3';  ...
'0.65' '-0.2e-3';  ...
'0.663' '-0.22e-3';  ...
'0.685' '-0.25e-3';  ...
'0.7' '-0.274e-3';  ...
'0.72' '-0.29e-3';  ...
'0.744' '-0.303e-3';  ...
'0.748' '-0.324e-3';  ...
'0.77' '-0.357e-3';  ...
'0.791' '-0.39e-3';  ...
'0.82' '-0.44e-3';  ...
'0.846' '-0.518e-3';  ...
'0.87' '-0.561e-3';  ...
'0.885' '-0.58e-3';  ...
'0.92' '-0.59e-3';  ...
'0.945' '-0.60e-3';  ...
'0.968' '-0.61e-3';  ...
'0.99' '-0.64e-3'});
model.material('mat2').propertyGroup('ElectrodePotential').func('int2').set('interp', 'piecewisecubic');
model.material('mat2').propertyGroup('ElectrodePotential').func('int2').set('fununit', {'V/K'});
model.material('mat2').propertyGroup('ElectrodePotential').func('int2').set('argunit', {''});
model.material('mat2').propertyGroup('ElectrodePotential').set('Eeq', 'Eeq_int1(soc)+dEeqdT_int1(soc)*(T-298[K])');
model.material('mat2').propertyGroup('ElectrodePotential').set('INFO_PREFIX:Eeq', 'M. Tang, P. Albertus, J. Harb, and J. Newman, "Two-Dimensional Modeling of Lithium Deposition during Cell Charging", J. Electrochemical Society, vol. 156, p. A390, 2009');
model.material('mat2').propertyGroup('ElectrodePotential').set('dEeqdT', 'dEeqdT_int1(soc)');
model.material('mat2').propertyGroup('ElectrodePotential').set('INFO_PREFIX:dEeqdT', ['K. E. Thomas, and J. Newman, ' native2unicode(hex2dec({'20' '1c'}), 'unicode') 'Heats of mixing and of entropy in porous insertion electrodes,' native2unicode(hex2dec({'20' '1d'}), 'unicode') ' J. Power Sources., vol. 119-121, p. 844, 2003.']);
model.material('mat2').propertyGroup('ElectrodePotential').set('cEeqref', 'def.csmax');
model.material('mat2').propertyGroup('ElectrodePotential').set('INFO_PREFIX:cEeqref', 'M. Tang, P. Albertus, J. Harb, and J. Newman, "Two-Dimensional Modeling of Lithium Deposition during Cell Charging", J. Electrochemical Society, vol. 156, p. A390, 2009');
model.material('mat2').propertyGroup('ElectrodePotential').set('soc', 'c/cEeqref');
model.material('mat2').propertyGroup('ElectrodePotential').descr('soc', '');
model.material('mat2').propertyGroup('ElectrodePotential').addInput('concentration');
model.material('mat2').propertyGroup('ElectrodePotential').addInput('temperature');
model.material('mat2').propertyGroup('OperationalSOC').set('socmax', 'elpot.Eeq_inv(E_min)');
model.material('mat2').propertyGroup('OperationalSOC').set('socmin', 'elpot.Eeq_inv(E_max)');
model.material('mat2').propertyGroup('OperationalSOC').set('E_max', '4.2[V]');
model.material('mat2').propertyGroup('OperationalSOC').set('E_min', '3.8[V]');
model.material('mat2').propertyGroup('ic').func('int1').set('funcname', 'dVOLdSOL');
model.material('mat2').propertyGroup('ic').func('int1').set('table', {'1' '0';  ...
'0.9843643779741672' '0.014846235418874976';  ...
'0.9598912304554724' '0.15058324496288344';  ...
'0.9340584636301835' '0.26935312831389124';  ...
'0.9095853161114887' '0.4050901378578997';  ...
'0.8905506458191705' '0.5577942735949093';  ...
'0.8701563562202583' '0.6765641569459167';  ...
'0.8429639700883752' '0.795334040296924';  ...
'0.8212100611828688' '0.9480381760339334';  ...
'0.7940176750509857' '1.1177094379639443';  ...
'0.7749830047586675' '1.2704135737009536';  ...
'0.7545887151597552' '1.4400848356309641';  ...
'0.7314751869476546' '1.6097560975609748';  ...
'0.7070020394289598' '1.7794273594909853';  ...
'0.6838885112168592' '1.9321314952279947';  ...
'0.6621346023113528' '2.0509013785790025';  ...
'0.6403806934058464' '2.1357370095440076';  ...
'0.6145479265805573' '2.186638388123011';  ...
'0.5927940176750509' '2.186638388123011';  ...
'0.5710401087695445' '2.1187698833510065';  ...
'0.5506458191706322' '1.983032873806998';  ...
'0.5261726716519374' '1.7624602332979842';  ...
'0.5003399048266485' '1.2534464475079525';  ...
'0.4772263766145478' '0.6765641569459167';  ...
'0.46091094493541795' '-0.10392364793213194';  ...
'0.4296397008837525' '-1.0540827147401917'});
model.material('mat2').propertyGroup('ic').func('int1').set('extrap', 'linear');
model.material('mat2').propertyGroup('ic').func('int1').set('fununit', {'%'});
model.material('mat2').propertyGroup('ic').func('int1').set('argunit', {'1'});
model.material('mat2').propertyGroup('ic').set('dvol', 'dVOLdSOL(c/elpot.cEeqref)');
model.material('mat2').propertyGroup('ic').set('INFO_PREFIX:dvol', ['R. Koerver and others, ' native2unicode(hex2dec({'20' '1c'}), 'unicode') 'Chemo-mechanical expansion of lithium electrode materials ' native2unicode(hex2dec({'20' '14'}), 'unicode') ' on the route to mechanically optimized all-solid-state batteries,' native2unicode(hex2dec({'20' '1d'}), 'unicode') ' Energy Environ. Sci., vol. 11, pp. 2142' native2unicode(hex2dec({'20' '13'}), 'unicode') '2158, 201']);
model.material('mat2').propertyGroup('ic').addInput('concentration');
model.material('mat2').propertyGroup('EquilibriumConcentration').set('csEq', 'def.csmax*elpot.Eeq_inv(V)');
model.material('mat2').propertyGroup('EquilibriumConcentration').addInput('electricpotential');
model.material('mat1').selection.set([1]);
model.material('mat2').selection.set([3]);

model.variable.create('var1');
model.variable('var1').model('comp1');

% To import content from file, use:
% model.variable('var1').loadFile('FILENAME');
model.variable('var1').set('I_app', 'liion.I_1C_cell*C_rate', 'Applied Current');

model.cpl.create('intop1', 'Integration', 'geom1');
model.cpl('intop1').set('axisym', true);
model.cpl('intop1').set('opname', 'PositiveCC');
model.cpl('intop1').selection.geom('geom1', 0);
model.cpl('intop1').selection.set([4]);
model.cpl.duplicate('intop2', 'intop1');
model.cpl('intop2').set('opname', 'NegativeCC');
model.cpl('intop2').selection.set([1]);

model.physics('liion').feature('sep1').set('sigmal_mat', 'userdef');
model.physics('liion').feature('sep1').set('sigmal', {'sigmal' '0' '0' '0' 'sigmal' '0' '0' '0' 'sigmal'});
model.physics('liion').create('pce1', 'PorousElectrode', 1);
model.physics('liion').feature('pce1').selection.set([1]);
model.physics('liion').feature('pce1').set('sigmal_mat', 'userdef');
model.physics('liion').feature('pce1').set('sigmal', {'sigmal' '0' '0' '0' 'sigmal' '0' '0' '0' 'sigmal'});
model.physics('liion').feature('pce1').set('sigma', {'sigmas_neg' '0' '0' '0' 'sigmas_neg' '0' '0' '0' 'sigmas_neg'});
model.physics('liion').feature('pce1').set('epss', 'epss_neg');
model.physics('liion').feature('pce1').feature('pin1').set('rp', 'rp');
model.physics('liion').feature('pce1').feature('per1').set('i0_ref', 'i0ref_neg');
model.physics('liion').create('pce2', 'PorousElectrode', 1);
model.physics('liion').feature('pce2').selection.set([3]);
model.physics('liion').feature('pce2').set('sigmal_mat', 'userdef');
model.physics('liion').feature('pce2').set('sigmal', {'sigmal' '0' '0' '0' 'sigmal' '0' '0' '0' 'sigmal'});
model.physics('liion').feature('pce2').set('sigma', {'sigmas_pos' '0' '0' '0' 'sigmas_pos' '0' '0' '0' 'sigmas_pos'});
model.physics('liion').feature('pce2').set('epss', 'epss_pos');
model.physics('liion').feature('pce2').feature('pin1').set('rp', 'rp');
model.physics('liion').feature('pce2').feature('per1').set('i0_ref', 'i0ref_pos');
model.physics('liion').prop('CellSettings').set('CellSOCandInitialChargeInventory', true);
model.physics('liion').feature('socicd1').set('SOC_init', 'SOC_0');
model.physics('liion').feature('socicd1').set('AddFormationLoss', false);
model.physics('liion').feature('socicd1').feature('neges1').selection.set([1]);
model.physics('liion').feature('socicd1').feature('poses1').selection.set([3]);
model.physics('liion').create('egnd1', 'ElectricGround', 0);
model.physics('liion').feature('egnd1').selection.set([1]);
model.physics('liion').create('ec1', 'ElectrodeCurrent', 0);
model.physics('liion').feature('ec1').selection.set([4]);
model.physics('liion').feature('ec1').set('Its', '-I_app');
model.physics('liion').feature('ec1').set('phis0init', '4[V]');

model.study('std1').feature('time').set('tlist', '0 4000');
model.study('std1').feature('time').set('useparam', true);
model.study('std1').feature('time').set('sweeptype', 'filled');
model.study('std1').feature('time').setIndex('pname', 'L_pos', 0);
model.study('std1').feature('time').setIndex('plistarr', '', 0);
model.study('std1').feature('time').setIndex('punit', 'm', 0);
model.study('std1').feature('time').setIndex('pname', 'L_pos', 0);
model.study('std1').feature('time').setIndex('plistarr', '', 0);
model.study('std1').feature('time').setIndex('punit', 'm', 0);
model.study('std1').feature('time').setIndex('pname', 'C_rate', 0);
model.study('std1').feature('time').setIndex('plistarr', '1 2 4', 0);
model.study('std1').feature('time').setIndex('pname', 'L_pos', 1);
model.study('std1').feature('time').setIndex('plistarr', '', 1);
model.study('std1').feature('time').setIndex('punit', 'm', 1);
model.study('std1').feature('time').setIndex('pname', 'L_pos', 1);
model.study('std1').feature('time').setIndex('plistarr', '', 1);
model.study('std1').feature('time').setIndex('punit', 'm', 1);
model.study('std1').feature('time').setIndex('pname', 'sigmal', 1);
model.study('std1').feature('time').setIndex('plistarr', '0.02 0.05 0.5 1', 1);

model.sol.create('sol1');
model.sol('sol1').study('std1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'cdi');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').feature('comp1_phil').set('scalemethod', 'manual');
model.sol('sol1').feature('v1').feature('comp1_liion_ec1_phis0').set('scalemethod', 'manual');
model.sol('sol1').feature('v1').feature('comp1_phis').set('scalemethod', 'manual');
model.sol('sol1').feature('v1').feature('comp1_phil').set('scaleval', '1');
model.sol('sol1').feature('v1').feature('comp1_liion_ec1_phis0').set('scaleval', '1');
model.sol('sol1').feature('v1').feature('comp1_phis').set('scaleval', '1');
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
model.sol('sol1').create('su1', 'StoreSolution');
model.sol('sol1').create('st2', 'StudyStep');
model.sol('sol1').feature('st2').set('study', 'std1');
model.sol('sol1').feature('st2').set('studystep', 'time');
model.sol('sol1').create('v2', 'Variables');
model.sol('sol1').feature('v2').feature('comp1_phil').set('scalemethod', 'manual');
model.sol('sol1').feature('v2').feature('comp1_liion_ec1_phis0').set('scalemethod', 'manual');
model.sol('sol1').feature('v2').feature('comp1_liion_pce2_cs').set('scalemethod', 'manual');
model.sol('sol1').feature('v2').feature('comp1_liion_pce1_cs').set('scalemethod', 'manual');
model.sol('sol1').feature('v2').feature('comp1_phis').set('scalemethod', 'manual');
model.sol('sol1').feature('v2').feature('comp1_phil').set('scaleval', '1');
model.sol('sol1').feature('v2').feature('comp1_liion_ec1_phis0').set('scaleval', '1');
model.sol('sol1').feature('v2').feature('comp1_liion_pce2_cs').set('scaleval', '10000');
model.sol('sol1').feature('v2').feature('comp1_liion_pce1_cs').set('scaleval', '10000');
model.sol('sol1').feature('v2').feature('comp1_phis').set('scaleval', '1');
model.sol('sol1').feature('v2').set('initmethod', 'sol');
model.sol('sol1').feature('v2').set('initsol', 'sol1');
model.sol('sol1').feature('v2').set('initsoluse', 'sol2');
model.sol('sol1').feature('v2').set('notsolmethod', 'sol');
model.sol('sol1').feature('v2').set('notsol', 'sol1');
model.sol('sol1').feature('v2').set('notsoluse', 'sol2');
model.sol('sol1').feature('v2').set('control', 'time');
model.sol('sol1').create('t1', 'Time');
model.sol('sol1').feature('t1').set('tlist', '0 4000');
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
model.sol('sol1').feature('t1').create('tp1', 'TimeParametric');
model.sol('sol1').feature('t1').feature.remove('tpDef');
model.sol('sol1').feature('t1').feature('tp1').set('control', 'time');
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
model.sol('sol1').attach('std1');
model.sol('sol1').feature('t1').set('tout', 'tsteps');
model.sol('sol1').feature('t1').create('st1', 'StopCondition');
model.sol('sol1').feature('t1').feature('st1').setIndex('stopcondarr', '', 0);
model.sol('sol1').feature('t1').feature('st1').setIndex('stopcondterminateon', 'true', 0);
model.sol('sol1').feature('t1').feature('st1').setIndex('stopcondActive', true, 0);
model.sol('sol1').feature('t1').feature('st1').setIndex('stopconddesc', 'Stop expression 1', 0);
model.sol('sol1').feature('t1').feature('st1').setIndex('stopcondarr', '', 0);
model.sol('sol1').feature('t1').feature('st1').setIndex('stopcondterminateon', 'true', 0);
model.sol('sol1').feature('t1').feature('st1').setIndex('stopcondActive', true, 0);
model.sol('sol1').feature('t1').feature('st1').setIndex('stopconddesc', 'Stop expression 1', 0);
model.sol('sol1').feature('t1').feature('st1').setIndex('stopcondarr', 'comp1.PositiveCC(comp1.phis)<2.7', 0);
model.sol('sol1').feature('t1').feature('st1').set('storestopcondsol', 'stepbefore');
model.sol('sol1').feature('t1').feature('st1').set('stopcondwarn', false);

model.study('std1').setGenPlots(false);

model.sol('sol1').runAll;

model.result.create('pg1', 'PlotGroup1D');
model.result('pg1').run;
model.result('pg1').label('Cell Voltage: sigmal = 0.02 S/m');
model.result('pg1').setIndex('looplevelinput', 'first', 1);
model.result('pg1').create('ptgr1', 'PointGraph');
model.result('pg1').feature('ptgr1').set('markerpos', 'datapoints');
model.result('pg1').feature('ptgr1').set('linewidth', 'preference');
model.result('pg1').feature('ptgr1').selection.set([4]);
model.result('pg1').feature('ptgr1').set('expr', 'phis');
model.result('pg1').feature('ptgr1').set('descr', 'Electric potential');
model.result('pg1').feature('ptgr1').set('legend', true);
model.result('pg1').feature('ptgr1').set('legendmethod', 'evaluated');
model.result('pg1').feature('ptgr1').set('legendpattern', 'eval(C_rate) C');
model.result('pg1').run;
model.result('pg1').set('titletype', 'manual');
model.result('pg1').set('title', 'Cell Voltage Profiles at \sigma<sub>l</sub> = 0.02 S/m');
model.result('pg1').run;
model.result.duplicate('pg2', 'pg1');
model.result('pg2').run;
model.result('pg2').label('Cell Voltage: sigmal = 1 S/m');
model.result('pg2').setIndex('looplevelinput', 'last', 1);
model.result('pg2').set('title', 'Cell Voltage Profiles at \sigma<sub>l</sub> = 1 S/m');
model.result('pg2').run;
model.result.create('pg3', 'PlotGroup1D');
model.result('pg3').run;
model.result('pg3').label('Cell Voltage: 1 C');
model.result('pg3').setIndex('looplevelinput', 'first', 2);
model.result('pg3').create('ptgr1', 'PointGraph');
model.result('pg3').feature('ptgr1').set('markerpos', 'datapoints');
model.result('pg3').feature('ptgr1').set('linewidth', 'preference');
model.result('pg3').feature('ptgr1').selection.set([4]);
model.result('pg3').feature('ptgr1').set('expr', 'phis');
model.result('pg3').feature('ptgr1').set('descr', 'Electric potential');
model.result('pg3').feature('ptgr1').set('legend', true);
model.result('pg3').feature('ptgr1').set('legendmethod', 'evaluated');
model.result('pg3').feature('ptgr1').set('legendpattern', '\sigma<sub>l</sub> = eval(sigmal) S/m');
model.result('pg3').run;
model.result('pg3').set('titletype', 'manual');
model.result('pg3').set('title', 'Cell Voltage Profiles at 1 C');
model.result('pg3').run;
model.result.duplicate('pg4', 'pg3');
model.result('pg4').run;
model.result('pg4').label('Cell Voltage: 4 C');
model.result('pg4').setIndex('looplevelinput', 'last', 2);
model.result('pg4').set('title', 'Cell Voltage Profiles at 4 C');
model.result('pg4').run;
model.result.create('pg5', 'PlotGroup1D');
model.result('pg5').run;
model.result('pg5').label('Electrolyte Potential Drop: 1 C and sigmal = 0.02 S/m');
model.result('pg5').setIndex('looplevelinput', 'first', 2);
model.result('pg5').setIndex('looplevelinput', 'first', 1);
model.result('pg5').create('lngr1', 'LineGraph');
model.result('pg5').feature('lngr1').set('markerpos', 'datapoints');
model.result('pg5').feature('lngr1').set('linewidth', 'preference');
model.result('pg5').feature('lngr1').selection.all;
model.result('pg5').feature('lngr1').set('expr', 'phil-NegativeCC(phil)');
model.result('pg5').run;
model.result('pg5').set('titletype', 'manual');
model.result('pg5').set('title', 'Electrolyte Potential Drop at 1 C and \sigma<sub>l</sub> = 0.02 S/m');
model.result('pg5').set('xlabelactive', true);
model.result('pg5').set('xlabel', 'Length across cell (m)');
model.result('pg5').set('ylabelactive', true);
model.result('pg5').set('ylabel', 'Electrolyte potential drop (V)');
model.result('pg5').run;
model.result.duplicate('pg6', 'pg5');
model.result('pg6').run;
model.result('pg6').label('Electrolyte Potential Drop: 1 C and sigmal = 1 S/m');
model.result('pg6').setIndex('looplevelinput', 'last', 1);
model.result('pg6').set('title', 'Electrolyte Potential Drop at 1 C and \sigma<sub>l</sub> = 1 S/m');
model.result('pg6').run;

model.material.create('mat3', 'Common', 'comp1');
model.material('mat3').propertyGroup('def').func.create('int1', 'Interpolation');
model.material('mat3').propertyGroup.create('ElectrolyteConductivity', 'Electrolyte conductivity');
model.material('mat3').propertyGroup('ElectrolyteConductivity').func.create('int1', 'Interpolation');
model.material('mat3').propertyGroup.create('SpeciesProperties', 'Species properties');
model.material('mat3').propertyGroup('SpeciesProperties').func.create('int1', 'Interpolation');
model.material('mat3').propertyGroup('SpeciesProperties').func.create('int2', 'Interpolation');
model.material('mat3').propertyGroup.create('ElectrolyteSaltConcentration', 'Electrolyte salt concentration');
model.material('mat3').label('LiPF6 in 3:7 EC:EMC (Liquid, Li-ion Battery)');
model.material('mat3').propertyGroup('def').func('int1').set('funcname', 'DL_int1');
model.material('mat3').propertyGroup('def').func('int1').set('table', {'200' '3.9e-10/(1-200*59e-6)';  ...
'500' '4.12e-10/(1-500*59e-6)';  ...
'800' '4e-10/(1-800*59e-6)';  ...
'1000' '3.8e-10/(1-1000*59e-6)';  ...
'1200' '3.50e-10/(1-1200*59e-6)';  ...
'1600' '2.68e-10/(1-1600*59e-6)';  ...
'2000' '1.9e-10/(1-2000*59e-6)'});
model.material('mat3').propertyGroup('def').func('int1').set('interp', 'piecewisecubic');
model.material('mat3').propertyGroup('def').func('int1').set('fununit', {'m^2/s'});
model.material('mat3').propertyGroup('def').func('int1').set('argunit', {''});
model.material('mat3').propertyGroup('def').set('diffusion', {'DL_int1(c/1[mol/m^3])*exp(16500/8.314*(1/(T_ref/1[K])-1/(T2/1[K])))' '0' '0' '0' 'DL_int1(c/1[mol/m^3])*exp(16500/8.314*(1/(T_ref/1[K])-1/(T2/1[K])))' '0' '0' '0' 'DL_int1(c/1[mol/m^3])*exp(16500/8.314*(1/(T_ref/1[K])-1/(T2/1[K])))'});
model.material('mat3').propertyGroup('def').set('INFO_PREFIX:diffusion', 'T. G. Zavalis, M. Behm, and G. Lindbergh, "Investigations of Short-Circuit Scenarios in a Lithium-Ion Battery Cell," J. Electrochem. Soc., vol. 159, p. A848, 2012.');
model.material('mat3').propertyGroup('def').set('T_ref', '298[K]');
model.material('mat3').propertyGroup('def').descr('T_ref', '');
model.material('mat3').propertyGroup('def').set('T2', 'min(393.15,max(T,223.15))');
model.material('mat3').propertyGroup('def').descr('T2', '');
model.material('mat3').propertyGroup('def').addInput('concentration');
model.material('mat3').propertyGroup('def').addInput('temperature');
model.material('mat3').propertyGroup('ElectrolyteConductivity').func('int1').set('funcname', 'sigmal_int1');
model.material('mat3').propertyGroup('ElectrolyteConductivity').func('int1').set('table', {'0' '1e-6';  ...
'200' '0.455';  ...
'500' '0.783';  ...
'800' '0.935';  ...
'1000' '0.95';  ...
'1200' '0.927';  ...
'1600' '0.78';  ...
'2000' '0.60';  ...
'2200' '0.515'});
model.material('mat3').propertyGroup('ElectrolyteConductivity').func('int1').set('interp', 'piecewisecubic');
model.material('mat3').propertyGroup('ElectrolyteConductivity').func('int1').set('fununit', {'S/m'});
model.material('mat3').propertyGroup('ElectrolyteConductivity').func('int1').set('argunit', {''});
model.material('mat3').propertyGroup('ElectrolyteConductivity').set('sigmal', {'sigmal_int1(c/1[mol/m^3])*exp(4000/8.314*(1/(T_ref2/1[K])-1/(T3/1[K])))' '0' '0' '0' 'sigmal_int1(c/1[mol/m^3])*exp(4000/8.314*(1/(T_ref2/1[K])-1/(T3/1[K])))' '0' '0' '0' 'sigmal_int1(c/1[mol/m^3])*exp(4000/8.314*(1/(T_ref2/1[K])-1/(T3/1[K])))'});
model.material('mat3').propertyGroup('ElectrolyteConductivity').set('INFO_PREFIX:sigmal', 'T. G. Zavalis, M. Behm, and G. Lindbergh, "Investigations of Short-Circuit Scenarios in a Lithium-Ion Battery Cell," J. Electrochem. Soc., vol. 159, p. A848, 2012.');
model.material('mat3').propertyGroup('ElectrolyteConductivity').set('T_ref2', '298[K]');
model.material('mat3').propertyGroup('ElectrolyteConductivity').descr('T_ref2', '');
model.material('mat3').propertyGroup('ElectrolyteConductivity').set('T3', 'min(393.15,max(T,223.15))');
model.material('mat3').propertyGroup('ElectrolyteConductivity').descr('T3', '');
model.material('mat3').propertyGroup('ElectrolyteConductivity').addInput('concentration');
model.material('mat3').propertyGroup('ElectrolyteConductivity').addInput('temperature');
model.material('mat3').propertyGroup('SpeciesProperties').func('int1').set('funcname', 'transpNm_int1');
model.material('mat3').propertyGroup('SpeciesProperties').func('int1').set('table', {'200' '0.37';  ...
'500' '0.322';  ...
'800' '0.27';  ...
'1000' '0.251';  ...
'1200' '0.248';  ...
'1600' '0.236';  ...
'2000' '0.11'});
model.material('mat3').propertyGroup('SpeciesProperties').func('int1').set('interp', 'piecewisecubic');
model.material('mat3').propertyGroup('SpeciesProperties').func('int1').set('fununit', {''});
model.material('mat3').propertyGroup('SpeciesProperties').func('int1').set('argunit', {''});
model.material('mat3').propertyGroup('SpeciesProperties').func('int2').set('funcname', 'actdep_int1');
model.material('mat3').propertyGroup('SpeciesProperties').func('int2').set('table', {'200' '0';  ...
'500' '0.29';  ...
'800' '0.695';  ...
'1000' '1';  ...
'1200' '1.32';  ...
'1600' '2.07';  ...
'2000' '2.50'});
model.material('mat3').propertyGroup('SpeciesProperties').func('int2').set('interp', 'piecewisecubic');
model.material('mat3').propertyGroup('SpeciesProperties').func('int2').set('fununit', {''});
model.material('mat3').propertyGroup('SpeciesProperties').func('int2').set('argunit', {''});
model.material('mat3').propertyGroup('SpeciesProperties').set('transpNum', 'transpNm_int1(c/1[mol/m^3])');
model.material('mat3').propertyGroup('SpeciesProperties').set('INFO_PREFIX:transpNum', ['A. Nyman, M. Behm, and G. Lindbergh, ' native2unicode(hex2dec({'20' '1c'}), 'unicode') 'Electrochemical characterisation and modelling of the mass transport phenomena in LiPF6-EC-EMC,' native2unicode(hex2dec({'20' '1d'}), 'unicode') ' Electrochim. Acta, vol. 53, p. 6356, 2008.']);
model.material('mat3').propertyGroup('SpeciesProperties').set('fcl', 'actdep_int1(c/1[mol/m^3])*exp(-1000/8.314*(1/(T_ref3/1[K])-1/(T4/1[K])))');
model.material('mat3').propertyGroup('SpeciesProperties').set('INFO_PREFIX:fcl', 'T. G. Zavalis, M. Behm, and G. Lindbergh, "Investigations of Short-Circuit Scenarios in a Lithium-Ion Battery Cell," J. Electrochem. Soc., vol. 159, p. A848, 2012.');
model.material('mat3').propertyGroup('SpeciesProperties').set('T4', 'min(393.15,max(T,223.15))');
model.material('mat3').propertyGroup('SpeciesProperties').descr('T4', '');
model.material('mat3').propertyGroup('SpeciesProperties').set('T_ref3', '298[K]');
model.material('mat3').propertyGroup('SpeciesProperties').descr('T_ref3', '');
model.material('mat3').propertyGroup('SpeciesProperties').addInput('concentration');
model.material('mat3').propertyGroup('SpeciesProperties').addInput('temperature');
model.material('mat3').propertyGroup('ElectrolyteSaltConcentration').identifier('cElsalt');
model.material('mat3').propertyGroup('ElectrolyteSaltConcentration').set('cElsalt', '1200[mol/m^3]');
model.material('mat3').selection.set([2]);

model.physics('liion').prop('ElectrolyteType').set('ElectrolyteType', 'Binary11LiquidElectrolyte');
model.physics('liion').feature('sep1').set('sigmal_mat', 'from_mat');
model.physics('liion').feature('pce1').set('ElectrolyteMaterial', 'mat3');
model.physics('liion').feature('pce1').set('sigmal_mat', 'from_mat');
model.physics('liion').feature('pce2').set('ElectrolyteMaterial', 'mat3');
model.physics('liion').feature('pce2').set('sigmal_mat', 'from_mat');

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
model.study('std2').create('time', 'Transient');
model.study('std2').feature('time').set('plotgroup', 'Default');
model.study('std2').feature('time').set('initialtime', '0');
model.study('std2').feature('time').set('solnum', 'auto');
model.study('std2').feature('time').set('notsolnum', 'auto');
model.study('std2').feature('time').set('outputmap', {});
model.study('std2').feature('time').setSolveFor('/physics/liion', true);
model.study('std2').feature('time').set('tlist', '0 4000');
model.study('std2').feature('time').set('useparam', true);
model.study('std2').feature('time').setIndex('pname', 'L_pos', 0);
model.study('std2').feature('time').setIndex('plistarr', '', 0);
model.study('std2').feature('time').setIndex('punit', 'm', 0);
model.study('std2').feature('time').setIndex('pname', 'L_pos', 0);
model.study('std2').feature('time').setIndex('plistarr', '', 0);
model.study('std2').feature('time').setIndex('punit', 'm', 0);
model.study('std2').feature('time').setIndex('pname', 'C_rate', 0);
model.study('std2').feature('time').setIndex('plistarr', '1 2 4', 0);

model.sol.create('sol3');
model.sol('sol3').study('std2');
model.sol('sol3').create('st1', 'StudyStep');
model.sol('sol3').feature('st1').set('study', 'std2');
model.sol('sol3').feature('st1').set('studystep', 'cdi');
model.sol('sol3').create('v1', 'Variables');
model.sol('sol3').feature('v1').feature('comp1_phil').set('scalemethod', 'manual');
model.sol('sol3').feature('v1').feature('comp1_liion_ec1_phis0').set('scalemethod', 'manual');
model.sol('sol3').feature('v1').feature('comp1_phis').set('scalemethod', 'manual');
model.sol('sol3').feature('v1').feature('comp1_cl').set('scalemethod', 'manual');
model.sol('sol3').feature('v1').feature('comp1_phil').set('scaleval', '1');
model.sol('sol3').feature('v1').feature('comp1_liion_ec1_phis0').set('scaleval', '1');
model.sol('sol3').feature('v1').feature('comp1_phis').set('scaleval', '1');
model.sol('sol3').feature('v1').feature('comp1_cl').set('scaleval', '1000');
model.sol('sol3').feature('v1').set('control', 'cdi');
model.sol('sol3').create('s1', 'Stationary');
model.sol('sol3').feature('s1').set('stol', 1.0E-4);
model.sol('sol3').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol3').feature('s1').feature('fc1').set('dtech', 'auto');
model.sol('sol3').feature('s1').feature('fc1').set('maxiter', 50);
model.sol('sol3').feature('s1').feature('fc1').set('minstep', 1.0E-6);
model.sol('sol3').feature('s1').create('d1', 'Direct');
model.sol('sol3').feature('s1').feature('d1').set('linsolver', 'pardiso');
model.sol('sol3').feature('s1').feature('d1').label('Direct (liion)');
model.sol('sol3').feature('s1').create('i1', 'Iterative');
model.sol('sol3').feature('s1').feature('i1').set('maxlinit', 1000);
model.sol('sol3').feature('s1').feature('i1').set('nlinnormuse', 'on');
model.sol('sol3').feature('s1').feature('i1').label('Algebraic Multigrid (liion)');
model.sol('sol3').feature('s1').feature('i1').create('mg1', 'Multigrid');
model.sol('sol3').feature('s1').feature('i1').feature('mg1').set('prefun', 'saamg');
model.sol('sol3').feature('s1').feature('i1').feature('mg1').set('maxcoarsedof', 50000);
model.sol('sol3').feature('s1').feature('i1').feature('mg1').set('saamgcompwise', true);
model.sol('sol3').feature('s1').feature('i1').feature('mg1').set('compactaggregation', true);
model.sol('sol3').feature('s1').feature('i1').feature('mg1').feature('pr').create('sl1', 'SORLine');
model.sol('sol3').feature('s1').feature('i1').feature('mg1').feature('po').create('sl1', 'SORLine');
model.sol('sol3').feature('s1').feature('i1').feature('mg1').feature('cs').create('d1', 'Direct');
model.sol('sol3').feature('s1').feature('i1').feature('mg1').feature('cs').feature('d1').set('linsolver', 'pardiso');
model.sol('sol3').feature('s1').create('i2', 'Iterative');
model.sol('sol3').feature('s1').feature('i2').set('maxlinit', 1000);
model.sol('sol3').feature('s1').feature('i2').set('nlinnormuse', 'on');
model.sol('sol3').feature('s1').feature('i2').label('Geometric Multigrid (liion)');
model.sol('sol3').feature('s1').feature('i2').create('mg1', 'Multigrid');
model.sol('sol3').feature('s1').feature('i2').feature('mg1').feature('pr').create('sl1', 'SORLine');
model.sol('sol3').feature('s1').feature('i2').feature('mg1').feature('po').create('sl1', 'SORLine');
model.sol('sol3').feature('s1').feature('i2').feature('mg1').feature('cs').create('d1', 'Direct');
model.sol('sol3').feature('s1').feature('i2').feature('mg1').feature('cs').feature('d1').set('linsolver', 'pardiso');
model.sol('sol3').feature('s1').feature('fc1').set('linsolver', 'd1');
model.sol('sol3').feature('s1').feature('fc1').set('dtech', 'auto');
model.sol('sol3').feature('s1').feature('fc1').set('maxiter', 50);
model.sol('sol3').feature('s1').feature('fc1').set('minstep', 1.0E-6);
model.sol('sol3').feature('s1').feature.remove('fcDef');
model.sol('sol3').create('su1', 'StoreSolution');
model.sol('sol3').create('st2', 'StudyStep');
model.sol('sol3').feature('st2').set('study', 'std2');
model.sol('sol3').feature('st2').set('studystep', 'time');
model.sol('sol3').create('v2', 'Variables');
model.sol('sol3').feature('v2').feature('comp1_phil').set('scalemethod', 'manual');
model.sol('sol3').feature('v2').feature('comp1_liion_ec1_phis0').set('scalemethod', 'manual');
model.sol('sol3').feature('v2').feature('comp1_liion_pce2_cs').set('scalemethod', 'manual');
model.sol('sol3').feature('v2').feature('comp1_liion_pce1_cs').set('scalemethod', 'manual');
model.sol('sol3').feature('v2').feature('comp1_phis').set('scalemethod', 'manual');
model.sol('sol3').feature('v2').feature('comp1_cl').set('scalemethod', 'manual');
model.sol('sol3').feature('v2').feature('comp1_phil').set('scaleval', '1');
model.sol('sol3').feature('v2').feature('comp1_liion_ec1_phis0').set('scaleval', '1');
model.sol('sol3').feature('v2').feature('comp1_liion_pce2_cs').set('scaleval', '10000');
model.sol('sol3').feature('v2').feature('comp1_liion_pce1_cs').set('scaleval', '10000');
model.sol('sol3').feature('v2').feature('comp1_phis').set('scaleval', '1');
model.sol('sol3').feature('v2').feature('comp1_cl').set('scaleval', '1000');
model.sol('sol3').feature('v2').set('initmethod', 'sol');
model.sol('sol3').feature('v2').set('initsol', 'sol3');
model.sol('sol3').feature('v2').set('initsoluse', 'sol4');
model.sol('sol3').feature('v2').set('notsolmethod', 'sol');
model.sol('sol3').feature('v2').set('notsol', 'sol3');
model.sol('sol3').feature('v2').set('notsoluse', 'sol4');
model.sol('sol3').feature('v2').set('control', 'time');
model.sol('sol3').create('t1', 'Time');
model.sol('sol3').feature('t1').set('tlist', '0 4000');
model.sol('sol3').feature('t1').set('plot', 'off');
model.sol('sol3').feature('t1').set('plotgroup', 'Default');
model.sol('sol3').feature('t1').set('plotfreq', 'tout');
model.sol('sol3').feature('t1').set('probesel', 'all');
model.sol('sol3').feature('t1').set('probes', {});
model.sol('sol3').feature('t1').set('probefreq', 'tsteps');
model.sol('sol3').feature('t1').set('rtol', 0.001);
model.sol('sol3').feature('t1').set('atolglobalvaluemethod', 'factor');
model.sol('sol3').feature('t1').set('eventout', true);
model.sol('sol3').feature('t1').set('reacf', true);
model.sol('sol3').feature('t1').set('storeudot', true);
model.sol('sol3').feature('t1').set('endtimeinterpolation', true);
model.sol('sol3').feature('t1').set('maxorder', 2);
model.sol('sol3').feature('t1').set('initialstepbdfactive', true);
model.sol('sol3').feature('t1').set('initialstepbdf', '(1)[s]');
model.sol('sol3').feature('t1').create('tp1', 'TimeParametric');
model.sol('sol3').feature('t1').feature.remove('tpDef');
model.sol('sol3').feature('t1').feature('tp1').set('control', 'time');
model.sol('sol3').feature('t1').set('control', 'time');
model.sol('sol3').feature('t1').feature('aDef').set('cachepattern', true);
model.sol('sol3').feature('t1').create('fc1', 'FullyCoupled');
model.sol('sol3').feature('t1').feature('fc1').set('dtech', 'auto');
model.sol('sol3').feature('t1').create('d1', 'Direct');
model.sol('sol3').feature('t1').feature('d1').set('linsolver', 'pardiso');
model.sol('sol3').feature('t1').feature('d1').label('Direct (liion)');
model.sol('sol3').feature('t1').create('i1', 'Iterative');
model.sol('sol3').feature('t1').feature('i1').set('maxlinit', 1000);
model.sol('sol3').feature('t1').feature('i1').set('nlinnormuse', 'on');
model.sol('sol3').feature('t1').feature('i1').label('Algebraic Multigrid (liion)');
model.sol('sol3').feature('t1').feature('i1').create('mg1', 'Multigrid');
model.sol('sol3').feature('t1').feature('i1').feature('mg1').set('prefun', 'saamg');
model.sol('sol3').feature('t1').feature('i1').feature('mg1').set('maxcoarsedof', 50000);
model.sol('sol3').feature('t1').feature('i1').feature('mg1').set('saamgcompwise', true);
model.sol('sol3').feature('t1').feature('i1').feature('mg1').set('compactaggregation', true);
model.sol('sol3').feature('t1').feature('i1').feature('mg1').feature('pr').create('sl1', 'SORLine');
model.sol('sol3').feature('t1').feature('i1').feature('mg1').feature('po').create('sl1', 'SORLine');
model.sol('sol3').feature('t1').feature('i1').feature('mg1').feature('cs').create('d1', 'Direct');
model.sol('sol3').feature('t1').feature('i1').feature('mg1').feature('cs').feature('d1').set('linsolver', 'pardiso');
model.sol('sol3').feature('t1').create('i2', 'Iterative');
model.sol('sol3').feature('t1').feature('i2').set('maxlinit', 1000);
model.sol('sol3').feature('t1').feature('i2').set('nlinnormuse', 'on');
model.sol('sol3').feature('t1').feature('i2').label('Geometric Multigrid (liion)');
model.sol('sol3').feature('t1').feature('i2').create('mg1', 'Multigrid');
model.sol('sol3').feature('t1').feature('i2').feature('mg1').feature('pr').create('sl1', 'SORLine');
model.sol('sol3').feature('t1').feature('i2').feature('mg1').feature('po').create('sl1', 'SORLine');
model.sol('sol3').feature('t1').feature('i2').feature('mg1').feature('cs').create('d1', 'Direct');
model.sol('sol3').feature('t1').feature('i2').feature('mg1').feature('cs').feature('d1').set('linsolver', 'pardiso');
model.sol('sol3').feature('t1').feature('fc1').set('linsolver', 'd1');
model.sol('sol3').feature('t1').feature('fc1').set('dtech', 'auto');
model.sol('sol3').feature('t1').feature.remove('fcDef');
model.sol('sol3').attach('std2');
model.sol('sol3').feature('t1').set('tout', 'tsteps');
model.sol('sol3').feature('t1').create('st1', 'StopCondition');
model.sol('sol3').feature('t1').feature('st1').setIndex('stopcondarr', '', 0);
model.sol('sol3').feature('t1').feature('st1').setIndex('stopcondterminateon', 'true', 0);
model.sol('sol3').feature('t1').feature('st1').setIndex('stopcondActive', true, 0);
model.sol('sol3').feature('t1').feature('st1').setIndex('stopconddesc', 'Stop expression 1', 0);
model.sol('sol3').feature('t1').feature('st1').setIndex('stopcondarr', '', 0);
model.sol('sol3').feature('t1').feature('st1').setIndex('stopcondterminateon', 'true', 0);
model.sol('sol3').feature('t1').feature('st1').setIndex('stopcondActive', true, 0);
model.sol('sol3').feature('t1').feature('st1').setIndex('stopconddesc', 'Stop expression 1', 0);
model.sol('sol3').feature('t1').feature('st1').setIndex('stopcondarr', 'comp1.PositiveCC(comp1.phis)<2.7', 0);
model.sol('sol3').feature('t1').feature('st1').set('storestopcondsol', 'stepbefore');
model.sol('sol3').feature('t1').feature('st1').set('stopcondwarn', false);

model.study('std2').setGenPlots(false);

model.sol('sol3').runAll;

model.result.create('pg7', 'PlotGroup1D');
model.result('pg7').run;
model.result('pg7').label('Cell Voltage: Single-Ion vs. Binary');
model.result('pg7').set('data', 'none');
model.result('pg7').create('ptgr1', 'PointGraph');
model.result('pg7').feature('ptgr1').set('markerpos', 'datapoints');
model.result('pg7').feature('ptgr1').set('linewidth', 'preference');
model.result('pg7').feature('ptgr1').set('data', 'dset1');
model.result('pg7').feature('ptgr1').setIndex('looplevelinput', 'last', 1);
model.result('pg7').feature('ptgr1').selection.set([4]);
model.result('pg7').feature('ptgr1').set('expr', 'phis');
model.result('pg7').feature('ptgr1').set('descr', 'Electric potential');
model.result('pg7').feature('ptgr1').set('xdatasolnumtype', 'level1');
model.result('pg7').feature('ptgr1').set('legend', true);
model.result('pg7').feature('ptgr1').set('legendmethod', 'evaluated');
model.result('pg7').feature('ptgr1').set('legendpattern', 'eval(C_rate) C, single-ion');
model.result('pg7').feature.duplicate('ptgr2', 'ptgr1');
model.result('pg7').run;
model.result('pg7').feature('ptgr2').set('data', 'dset3');
model.result('pg7').feature('ptgr2').set('linestyle', 'dashed');
model.result('pg7').feature('ptgr2').set('linecolor', 'cyclereset');
model.result('pg7').feature('ptgr2').set('legendpattern', 'eval(C_rate) C, binary');
model.result('pg7').run;
model.result('pg7').set('titletype', 'manual');
model.result('pg7').set('title', 'Cell Voltage Profiles: Single-Ion vs. Binary');
model.result('pg7').run;

model.physics('liion').prop('ElectrolyteType').set('ElectrolyteType', 'SingleIonConductor');
model.physics('liion').feature('sep1').set('sigmal_mat', 'userdef');
model.physics('liion').feature('pce1').set('ElectrolyteMaterial', 'dommat');
model.physics('liion').feature('pce1').set('sigmal_mat', 'userdef');
model.physics('liion').feature('pce2').set('ElectrolyteMaterial', 'dommat');
model.physics('liion').feature('pce2').set('sigmal_mat', 'userdef');

model.material.remove('mat3');

model.study.remove('std2');

model.result('pg7').run;
model.result.remove('pg7');

model.title('Lithium-Ion Battery with Single-Ion Conducting Solid Electrolyte');

model.description('This example demonstrates the Lithium-Ion Battery, Single-Ion Conductor interface for studying the discharge of a lithium-ion battery with solid electrolyte. The behavior at various discharge currents and solid electrolyte conductivities is analyzed. The geometry is in one dimension and the model is isothermal.');

model.mesh.clearMeshes;

model.sol('sol1').clearSolutionData;
model.sol('sol2').clearSolutionData;

model.label('li_battery_solid_electrolyte.mph');

model.modelNode.label('Components');

out = model;
