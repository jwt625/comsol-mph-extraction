function out = model
%
% pouch_cell_utilization.m
%
% Model exported on May 26 2025, 21:26 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/Battery_Design_Module/Batteries,_Lithium-Ion');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 3);
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

model.geom('geom1').insertFile('pouch_cell_utilization_geom_sequence.mph', 'geom1');
model.geom('geom1').run('unisel3');

model.view('view1').camera.set('viewscaletype', 'manual');
model.view('view1').camera.set('zscale', 100);

model.param.label('Geometry Parameters');
model.param.create('par2');
model.param('par2').label('Physics Parameters');

% To import content from file, use:
% model.param('par2').loadFile('FILENAME');
model.param('par2').set('i0ref_pos', '0.70[A/m^2]', 'Reference exchange current density positive electrode');
model.param('par2').set('i0ref_neg', '0.96[A/m^2]', 'Reference exchange current density negative electrode');
model.param('par2').set('rp_pos', '2e-6[m]', 'Positive electrode particle radius');
model.param('par2').set('rp_neg', '5e-6[m]', 'Negative electrode particle radius');
model.param('par2').set('sigmas_neg', '100[S/m]', 'Electrical conductivity, negative electrode');
model.param('par2').set('sigmas_pos', '3.8[S/m]', 'Electrical conductivity, positive electrode');
model.param('par2').set('csmax_pos', '22860[mol/m^3]', 'Maximum host capacity, positive electrode');
model.param('par2').set('epss_pos', '0.5', 'Positive electrode volume fraction');
model.param('par2').set('csmax_neg', '31507[mol/m^3]', 'Maximum host capacity, negative electrode');
model.param('par2').set('epss_neg', 'csmax_pos*L_pos*epss_pos/(csmax_neg*L_neg)*1.25', 'Negative electrode volume fraction');
model.param('par2').set('SOC_start', '0.2', 'Initial cell state of charge');
model.param('par2').set('SOC_window', '0.7', 'State of charge window during simulation');
model.param('par2').set('C_rate', '1.0[1]', 'C-rate during simulation');
model.param('par2').set('sim_time', '1[h]*SOC_window/C_rate', 'Simulation time');

model.material.create('mat1', 'Common', 'comp1');
model.material('mat1').propertyGroup.create('Enu', 'Young''s modulus and Poisson''s ratio');
model.material('mat1').propertyGroup.create('Murnaghan', 'Murnaghan');
model.material('mat1').label('Aluminum');
model.material('mat1').set('family', 'aluminum');
model.material('mat1').propertyGroup('def').set('relpermeability', {'1' '0' '0' '0' '1' '0' '0' '0' '1'});
model.material('mat1').propertyGroup('def').set('heatcapacity', '900[J/(kg*K)]');
model.material('mat1').propertyGroup('def').set('thermalconductivity', {'238[W/(m*K)]' '0' '0' '0' '238[W/(m*K)]' '0' '0' '0' '238[W/(m*K)]'});
model.material('mat1').propertyGroup('def').set('electricconductivity', {'3.774e7[S/m]' '0' '0' '0' '3.774e7[S/m]' '0' '0' '0' '3.774e7[S/m]'});
model.material('mat1').propertyGroup('def').set('relpermittivity', {'1' '0' '0' '0' '1' '0' '0' '0' '1'});
model.material('mat1').propertyGroup('def').set('thermalexpansioncoefficient', {'23e-6[1/K]' '0' '0' '0' '23e-6[1/K]' '0' '0' '0' '23e-6[1/K]'});
model.material('mat1').propertyGroup('def').set('density', '2700[kg/m^3]');
model.material('mat1').propertyGroup('Enu').set('E', '70[GPa]');
model.material('mat1').propertyGroup('Enu').set('nu', '0.33');
model.material('mat1').propertyGroup('Murnaghan').set('l', '-250[GPa]');
model.material('mat1').propertyGroup('Murnaghan').set('m', '-330[GPa]');
model.material('mat1').propertyGroup('Murnaghan').set('n', '-350[GPa]');
model.material.create('mat2', 'Common', 'comp1');
model.material('mat2').propertyGroup.create('Enu', 'Young''s modulus and Poisson''s ratio');
model.material('mat2').propertyGroup.create('linzRes', 'Linearized resistivity');
model.material('mat2').label('Copper');
model.material('mat2').set('family', 'copper');
model.material('mat2').propertyGroup('def').set('relpermeability', {'1' '0' '0' '0' '1' '0' '0' '0' '1'});
model.material('mat2').propertyGroup('def').set('electricconductivity', {'5.998e7[S/m]' '0' '0' '0' '5.998e7[S/m]' '0' '0' '0' '5.998e7[S/m]'});
model.material('mat2').propertyGroup('def').set('thermalexpansioncoefficient', {'17e-6[1/K]' '0' '0' '0' '17e-6[1/K]' '0' '0' '0' '17e-6[1/K]'});
model.material('mat2').propertyGroup('def').set('heatcapacity', '385[J/(kg*K)]');
model.material('mat2').propertyGroup('def').set('relpermittivity', {'1' '0' '0' '0' '1' '0' '0' '0' '1'});
model.material('mat2').propertyGroup('def').set('density', '8960[kg/m^3]');
model.material('mat2').propertyGroup('def').set('thermalconductivity', {'400[W/(m*K)]' '0' '0' '0' '400[W/(m*K)]' '0' '0' '0' '400[W/(m*K)]'});
model.material('mat2').propertyGroup('Enu').set('E', '110[GPa]');
model.material('mat2').propertyGroup('Enu').set('nu', '0.35');
model.material('mat2').propertyGroup('linzRes').set('rho0', '1.72e-8[ohm*m]');
model.material('mat2').propertyGroup('linzRes').set('alpha', '0.0039[1/K]');
model.material('mat2').propertyGroup('linzRes').set('Tref', '298[K]');
model.material('mat2').propertyGroup('linzRes').addInput('temperature');
model.material.create('mat3', 'Common', 'comp1');
model.material('mat3').propertyGroup('def').func.create('int1', 'Interpolation');
model.material('mat3').propertyGroup('def').func.create('int2', 'Interpolation');
model.material('mat3').propertyGroup.create('ElectrodePotential', 'Equilibrium potential');
model.material('mat3').propertyGroup('ElectrodePotential').func.create('int1', 'Interpolation');
model.material('mat3').propertyGroup('ElectrodePotential').func.create('int2', 'Interpolation');
model.material('mat3').propertyGroup.create('OperationalSOC', 'Operational electrode state of charge');
model.material('mat3').propertyGroup.create('ic', 'Intercalation strain');
model.material('mat3').propertyGroup('ic').func.create('int1', 'Interpolation');
model.material('mat3').propertyGroup.create('EquilibriumConcentration', 'Equilibrium concentration');
model.material('mat3').label('Graphite, LixC6 MCMB (Negative, Li-ion Battery)');
model.material('mat3').propertyGroup('def').func('int1').set('funcname', 'E_int');
model.material('mat3').propertyGroup('def').func('int1').set('table', {'0' '32.47'; '0.333' '28.56'; '0.5' '58.06'; '1' '108.67'});
model.material('mat3').propertyGroup('def').func('int1').set('fununit', {'GPa'});
model.material('mat3').propertyGroup('def').func('int1').set('argunit', {'1'});
model.material('mat3').propertyGroup('def').func('int2').set('funcname', 'nu_int');
model.material('mat3').propertyGroup('def').func('int2').set('table', {'0' '0.32'; '0.333' '0.39'; '0.5' '0.34'; '1' '0.24'});
model.material('mat3').propertyGroup('def').func('int2').set('fununit', {''});
model.material('mat3').propertyGroup('def').set('youngsmodulus', '');
model.material('mat3').propertyGroup('def').set('poissonsratio', '');
model.material('mat3').propertyGroup('def').set('youngsmodulus', 'E_int(c/csmax)');
model.material('mat3').propertyGroup('def').set('INFO_PREFIX:youngsmodulus', 'Yue Qi et al 2010 J. Electrochem. Soc. 157 A558');
model.material('mat3').propertyGroup('def').set('poissonsratio', 'nu_int(c/csmax)');
model.material('mat3').propertyGroup('def').set('INFO_PREFIX:poissonsratio', 'Yue Qi et al 2010 J. Electrochem. Soc. 157 A558');
model.material('mat3').propertyGroup('def').set('electricconductivity', {'100[S/m]' '0' '0' '0' '100[S/m]' '0' '0' '0' '100[S/m]'});
model.material('mat3').propertyGroup('def').set('INFO_PREFIX:electricconductivity', ['V. Srinivasan, and J. Newman, ' native2unicode(hex2dec({'20' '1c'}), 'unicode') 'Design and Optimization of a Natural Graphite/Iron Phosphate Lithium Ion Cell,' native2unicode(hex2dec({'20' '1d'}), 'unicode') ' J. Electrochem. Soc., vol. 151, p. 1530, 2004.']);
model.material('mat3').propertyGroup('def').set('diffusion', {'1.4523e-13*exp(68025.7/8.314*(1/(T_ref/1[K])-1/(T2/1[K])))[m^2/s]' '0' '0' '0' '1.4523e-13*exp(68025.7/8.314*(1/(T_ref/1[K])-1/(T2/1[K])))[m^2/s]' '0' '0' '0' '1.4523e-13*exp(68025.7/8.314*(1/(T_ref/1[K])-1/(T2/1[K])))[m^2/s]'});
model.material('mat3').propertyGroup('def').set('INFO_PREFIX:diffusion', ['K. Kumaresan, G. Sikha, and R. E. White, ' native2unicode(hex2dec({'20' '1c'}), 'unicode') 'Thermal Model for a Li-Ion Cell,' native2unicode(hex2dec({'20' '1d'}), 'unicode') ' J. Electrochem. Soc., vol. 155, p. A164, 2008.']);
model.material('mat3').propertyGroup('def').set('thermalconductivity', {'1[W/(m*K)]' '0' '0' '0' '1[W/(m*K)]' '0' '0' '0' '1[W/(m*K)]'});
model.material('mat3').propertyGroup('def').set('INFO_PREFIX:thermalconductivity', 'S. Chen, C. Wan, and Y. Wang, J. Power Sources, 140, 111 (2005).');
model.material('mat3').propertyGroup('def').set('heatcapacity', '750[J/(kg*K)]');
model.material('mat3').propertyGroup('def').set('INFO_PREFIX:heatcapacity', 'SI Chemical Data, John Wiley & Sons, 1994');
model.material('mat3').propertyGroup('def').set('density', '2300[kg/m^3]');
model.material('mat3').propertyGroup('def').set('INFO_PREFIX:density', 'SI Chemical Data, John Wiley & Sons, 1994');
model.material('mat3').propertyGroup('def').set('csmax', '31507[mol/m^3]');
model.material('mat3').propertyGroup('def').descr('csmax', '');
model.material('mat3').propertyGroup('def').set('T_ref', '318[K]');
model.material('mat3').propertyGroup('def').descr('T_ref', '');
model.material('mat3').propertyGroup('def').set('T2', 'min(393.15,max(T,223.15))');
model.material('mat3').propertyGroup('def').descr('T2', '');
model.material('mat3').propertyGroup('def').addInput('temperature');
model.material('mat3').propertyGroup('def').addInput('concentration');
model.material('mat3').propertyGroup('ElectrodePotential').func('int1').set('funcname', 'Eeq_int1');
model.material('mat3').propertyGroup('ElectrodePotential').func('int1').set('table', {'0' '2.781186612';  ...
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
model.material('mat3').propertyGroup('ElectrodePotential').func('int1').set('interp', 'piecewisecubic');
model.material('mat3').propertyGroup('ElectrodePotential').func('int1').set('extrap', 'linear');
model.material('mat3').propertyGroup('ElectrodePotential').func('int1').set('fununit', {'V'});
model.material('mat3').propertyGroup('ElectrodePotential').func('int1').set('argunit', {''});
model.material('mat3').propertyGroup('ElectrodePotential').func('int1').set('defineinv', true);
model.material('mat3').propertyGroup('ElectrodePotential').func('int1').set('funcinvname', 'Eeq_inv');
model.material('mat3').propertyGroup('ElectrodePotential').func('int2').set('funcname', 'dEeqdT_int1');
model.material('mat3').propertyGroup('ElectrodePotential').func('int2').set('table', {'0' '3.0e-4';  ...
'0.17' '0';  ...
'0.24' '-6e-5';  ...
'0.28' '-1.6e-4';  ...
'0.5' '-1.6e-4';  ...
'0.54' '-9e-5';  ...
'0.71' '-9e-5';  ...
'0.85' '-1.0e-4';  ...
'1.0' '-1.2e-4'});
model.material('mat3').propertyGroup('ElectrodePotential').func('int2').set('fununit', {'V/K'});
model.material('mat3').propertyGroup('ElectrodePotential').func('int2').set('argunit', {''});
model.material('mat3').propertyGroup('ElectrodePotential').set('Eeq', 'Eeq_int1(soc)+dEeqdT_int1(soc)*(T-298[K])');
model.material('mat3').propertyGroup('ElectrodePotential').set('INFO_PREFIX:Eeq', ['D. P Karthikeyan, G. Sikha, and R. E. White, ' native2unicode(hex2dec({'20' '1c'}), 'unicode') 'Thermodynamic model development for lithium intercalation electrodes,' native2unicode(hex2dec({'20' '1d'}), 'unicode') ' J. Power Sources, vol. 185, p. 1398, 2008.']);
model.material('mat3').propertyGroup('ElectrodePotential').set('dEeqdT', 'dEeqdT_int1(soc)');
model.material('mat3').propertyGroup('ElectrodePotential').set('INFO_PREFIX:dEeqdT', ['K. E. Thomas, and J. Newman, ' native2unicode(hex2dec({'20' '1c'}), 'unicode') 'Heats of mixing and of entropy in porous insertion electrodes,' native2unicode(hex2dec({'20' '1d'}), 'unicode') ' J. Power Sources., vol. 119-121, p. 844, 2003.']);
model.material('mat3').propertyGroup('ElectrodePotential').set('cEeqref', 'def.csmax');
model.material('mat3').propertyGroup('ElectrodePotential').set('soc', 'c/cEeqref');
model.material('mat3').propertyGroup('ElectrodePotential').descr('soc', '');
model.material('mat3').propertyGroup('ElectrodePotential').addInput('concentration');
model.material('mat3').propertyGroup('ElectrodePotential').addInput('temperature');
model.material('mat3').propertyGroup('OperationalSOC').set('socmax', 'elpot.Eeq_inv(E_min)');
model.material('mat3').propertyGroup('OperationalSOC').set('socmin', 'elpot.Eeq_inv(E_max)');
model.material('mat3').propertyGroup('OperationalSOC').set('E_max', '1[V]');
model.material('mat3').propertyGroup('OperationalSOC').set('E_min', '0.075[V]');
model.material('mat3').propertyGroup('ic').func('int1').set('funcname', 'dVOLdSOL');
model.material('mat3').propertyGroup('ic').func('int1').set('table', {'0' '0';  ...
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
model.material('mat3').propertyGroup('ic').func('int1').set('extrap', 'linear');
model.material('mat3').propertyGroup('ic').func('int1').set('fununit', {'%'});
model.material('mat3').propertyGroup('ic').func('int1').set('argunit', {'1'});
model.material('mat3').propertyGroup('ic').set('dvol', 'dVOLdSOL(c/def.csmax)');
model.material('mat3').propertyGroup('ic').set('INFO_PREFIX:dvol', ['S. Schweidler, L. de Biasi, A. Schiele, P. Hartmann, T. Brezesinski and J. Janek, "Volume Changes of Graphite Anodes Revisited: A Combined Operando X-Ray Diffraction and In Situ Pressure Analysis Study", J. Phys. Chem. C, 2018, 122, 8829' native2unicode(hex2dec({'20' '13'}), 'unicode') '8835']);
model.material('mat3').propertyGroup('ic').addInput('concentration');
model.material('mat3').propertyGroup('EquilibriumConcentration').set('csEq', 'def.csmax*elpot.Eeq_inv(V)');
model.material('mat3').propertyGroup('EquilibriumConcentration').addInput('electricpotential');
model.material.create('mat4', 'Common', 'comp1');
model.material('mat4').propertyGroup.create('ElectrodePotential', 'Equilibrium potential');
model.material('mat4').propertyGroup('ElectrodePotential').func.create('int1', 'Interpolation');
model.material('mat4').propertyGroup('ElectrodePotential').func.create('int2', 'Interpolation');
model.material('mat4').propertyGroup.create('OperationalSOC', 'Operational electrode state of charge');
model.material('mat4').propertyGroup.create('EquilibriumConcentration', 'Equilibrium concentration');
model.material('mat4').label('LMO, LiMn2O4 Spinel (Positive, Li-ion Battery)');
model.material('mat4').propertyGroup('def').set('youngsmodulus', '');
model.material('mat4').propertyGroup('def').set('poissonsratio', '');
model.material('mat4').propertyGroup('def').set('youngsmodulus', '194[GPa]');
model.material('mat4').propertyGroup('def').set('INFO_PREFIX:youngsmodulus', 'Yue Qi et al 2014 J. Electrochem. Soc. 161 F3010');
model.material('mat4').propertyGroup('def').set('poissonsratio', '0.26');
model.material('mat4').propertyGroup('def').set('INFO_PREFIX:poissonsratio', 'Yue Qi et al 2014 J. Electrochem. Soc. 161 F3010');
model.material('mat4').propertyGroup('def').set('electricconductivity', {'3.8[S/m]' '0' '0' '0' '3.8[S/m]' '0' '0' '0' '3.8[S/m]'});
model.material('mat4').propertyGroup('def').set('INFO_PREFIX:electricconductivity', 'V. Srinivasan and C.Y. Wang, "Analysis of Electrochemical and Thermal Behavior of Li-Ion Cells," J. Electrochem. Soc., vol. 150, p. A98, 2003');
model.material('mat4').propertyGroup('def').set('diffusion', {'1e-14*exp(20000/8.314*(1/(T_ref/1[K])-1/(T2/1[K])))[m^2/s]' '0' '0' '0' '1e-14*exp(20000/8.314*(1/(T_ref/1[K])-1/(T2/1[K])))[m^2/s]' '0' '0' '0' '1e-14*exp(20000/8.314*(1/(T_ref/1[K])-1/(T2/1[K])))[m^2/s]'});
model.material('mat4').propertyGroup('def').set('INFO_PREFIX:diffusion', 'V. Srinivasan and C.Y. Wang, "Analysis of Electrochemical and Thermal Behavior of Li-Ion Cells," J. Electrochem. Soc., vol. 150, p. A98, 2003');
model.material('mat4').propertyGroup('def').set('density', '4140[kg/m^3]');
model.material('mat4').propertyGroup('def').set('INFO_PREFIX:density', 'N. Nitta, F. Wu, J. Tae Lee, and G. Yushin, Materials Today, Volume 18, Number 5, June 2015');
model.material('mat4').propertyGroup('def').set('T_ref', '298[K]');
model.material('mat4').propertyGroup('def').descr('T_ref', '');
model.material('mat4').propertyGroup('def').set('T2', 'min(393.15,max(T,223.15))');
model.material('mat4').propertyGroup('def').descr('T2', '');
model.material('mat4').propertyGroup('def').set('csmax', '22860[mol/m^3]');
model.material('mat4').propertyGroup('def').descr('csmax', '');
model.material('mat4').propertyGroup('def').addInput('temperature');
model.material('mat4').propertyGroup('ElectrodePotential').func('int1').set('funcname', 'Eeq_int1');
model.material('mat4').propertyGroup('ElectrodePotential').func('int1').set('table', {'0.1750' '4.2763';  ...
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
model.material('mat4').propertyGroup('ElectrodePotential').func('int1').set('interp', 'piecewisecubic');
model.material('mat4').propertyGroup('ElectrodePotential').func('int1').set('extrap', 'linear');
model.material('mat4').propertyGroup('ElectrodePotential').func('int1').set('fununit', {'V'});
model.material('mat4').propertyGroup('ElectrodePotential').func('int1').set('argunit', {''});
model.material('mat4').propertyGroup('ElectrodePotential').func('int1').set('defineinv', true);
model.material('mat4').propertyGroup('ElectrodePotential').func('int1').set('funcinvname', 'Eeq_inv');
model.material('mat4').propertyGroup('ElectrodePotential').func('int2').set('funcname', 'dEeqdT_int1');
model.material('mat4').propertyGroup('ElectrodePotential').func('int2').set('table', {'0.15' '0.15e-3';  ...
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
model.material('mat4').propertyGroup('ElectrodePotential').func('int2').set('interp', 'piecewisecubic');
model.material('mat4').propertyGroup('ElectrodePotential').func('int2').set('fununit', {'V/K'});
model.material('mat4').propertyGroup('ElectrodePotential').func('int2').set('argunit', {''});
model.material('mat4').propertyGroup('ElectrodePotential').set('Eeq', 'Eeq_int1(soc)+dEeqdT_int1(soc)*(T-298[K])');
model.material('mat4').propertyGroup('ElectrodePotential').set('INFO_PREFIX:Eeq', 'V. Srinivasan and C.Y. Wang, "Analysis of Electrochemical and Thermal Behavior of Li-Ion Cells," J. Electrochem. Soc., vol. 150, p. A98, 2003');
model.material('mat4').propertyGroup('ElectrodePotential').set('dEeqdT', 'dEeqdT_int1(soc)');
model.material('mat4').propertyGroup('ElectrodePotential').set('INFO_PREFIX:dEeqdT', 'V. Srinivasan and C.Y. Wang, "Analysis of Electrochemical and Thermal Behavior of Li-Ion Cells," J. Electrochem. Soc., vol. 150, p. A98, 2003');
model.material('mat4').propertyGroup('ElectrodePotential').set('cEeqref', 'def.csmax');
model.material('mat4').propertyGroup('ElectrodePotential').set('INFO_PREFIX:cEeqref', 'V. Srinivasan and C.Y. Wang, "Analysis of Electrochemical and Thermal Behavior of Li-Ion Cells," J. Electrochem. Soc., vol. 150, p. A98, 2003');
model.material('mat4').propertyGroup('ElectrodePotential').set('soc', 'c/cEeqref');
model.material('mat4').propertyGroup('ElectrodePotential').descr('soc', '');
model.material('mat4').propertyGroup('ElectrodePotential').addInput('concentration');
model.material('mat4').propertyGroup('ElectrodePotential').addInput('temperature');
model.material('mat4').propertyGroup('OperationalSOC').set('socmax', 'elpot.Eeq_inv(E_min)');
model.material('mat4').propertyGroup('OperationalSOC').set('socmin', 'elpot.Eeq_inv(E_max)');
model.material('mat4').propertyGroup('OperationalSOC').set('E_max', '4.2[V]');
model.material('mat4').propertyGroup('OperationalSOC').set('E_min', '3.9[V]');
model.material('mat4').propertyGroup('EquilibriumConcentration').set('csEq', 'def.csmax*elpot.Eeq_inv(V)');
model.material('mat4').propertyGroup('EquilibriumConcentration').addInput('electricpotential');
model.material.create('mat5', 'Common', 'comp1');
model.material('mat5').propertyGroup('def').func.create('int1', 'Interpolation');
model.material('mat5').propertyGroup.create('ElectrolyteConductivity', 'Electrolyte conductivity');
model.material('mat5').propertyGroup('ElectrolyteConductivity').func.create('int1', 'Interpolation');
model.material('mat5').propertyGroup.create('SpeciesProperties', 'Species properties');
model.material('mat5').propertyGroup('SpeciesProperties').func.create('int1', 'Interpolation');
model.material('mat5').propertyGroup('SpeciesProperties').func.create('int2', 'Interpolation');
model.material('mat5').propertyGroup.create('ElectrolyteSaltConcentration', 'Electrolyte salt concentration');
model.material('mat5').label('LiPF6 in 3:7 EC:EMC (Liquid, Li-ion Battery)');
model.material('mat5').propertyGroup('def').func('int1').set('funcname', 'DL_int1');
model.material('mat5').propertyGroup('def').func('int1').set('table', {'200' '3.9e-10/(1-200*59e-6)';  ...
'500' '4.12e-10/(1-500*59e-6)';  ...
'800' '4e-10/(1-800*59e-6)';  ...
'1000' '3.8e-10/(1-1000*59e-6)';  ...
'1200' '3.50e-10/(1-1200*59e-6)';  ...
'1600' '2.68e-10/(1-1600*59e-6)';  ...
'2000' '1.9e-10/(1-2000*59e-6)'});
model.material('mat5').propertyGroup('def').func('int1').set('interp', 'piecewisecubic');
model.material('mat5').propertyGroup('def').func('int1').set('fununit', {'m^2/s'});
model.material('mat5').propertyGroup('def').func('int1').set('argunit', {''});
model.material('mat5').propertyGroup('def').set('diffusion', {'DL_int1(c/1[mol/m^3])*exp(16500/8.314*(1/(T_ref/1[K])-1/(T2/1[K])))' '0' '0' '0' 'DL_int1(c/1[mol/m^3])*exp(16500/8.314*(1/(T_ref/1[K])-1/(T2/1[K])))' '0' '0' '0' 'DL_int1(c/1[mol/m^3])*exp(16500/8.314*(1/(T_ref/1[K])-1/(T2/1[K])))'});
model.material('mat5').propertyGroup('def').set('INFO_PREFIX:diffusion', 'T. G. Zavalis, M. Behm, and G. Lindbergh, "Investigations of Short-Circuit Scenarios in a Lithium-Ion Battery Cell," J. Electrochem. Soc., vol. 159, p. A848, 2012.');
model.material('mat5').propertyGroup('def').set('T_ref', '298[K]');
model.material('mat5').propertyGroup('def').descr('T_ref', '');
model.material('mat5').propertyGroup('def').set('T2', 'min(393.15,max(T,223.15))');
model.material('mat5').propertyGroup('def').descr('T2', '');
model.material('mat5').propertyGroup('def').addInput('concentration');
model.material('mat5').propertyGroup('def').addInput('temperature');
model.material('mat5').propertyGroup('ElectrolyteConductivity').func('int1').set('funcname', 'sigmal_int1');
model.material('mat5').propertyGroup('ElectrolyteConductivity').func('int1').set('table', {'0' '1e-6';  ...
'200' '0.455';  ...
'500' '0.783';  ...
'800' '0.935';  ...
'1000' '0.95';  ...
'1200' '0.927';  ...
'1600' '0.78';  ...
'2000' '0.60';  ...
'2200' '0.515'});
model.material('mat5').propertyGroup('ElectrolyteConductivity').func('int1').set('interp', 'piecewisecubic');
model.material('mat5').propertyGroup('ElectrolyteConductivity').func('int1').set('fununit', {'S/m'});
model.material('mat5').propertyGroup('ElectrolyteConductivity').func('int1').set('argunit', {''});
model.material('mat5').propertyGroup('ElectrolyteConductivity').set('sigmal', {'sigmal_int1(c/1[mol/m^3])*exp(4000/8.314*(1/(T_ref2/1[K])-1/(T3/1[K])))' '0' '0' '0' 'sigmal_int1(c/1[mol/m^3])*exp(4000/8.314*(1/(T_ref2/1[K])-1/(T3/1[K])))' '0' '0' '0' 'sigmal_int1(c/1[mol/m^3])*exp(4000/8.314*(1/(T_ref2/1[K])-1/(T3/1[K])))'});
model.material('mat5').propertyGroup('ElectrolyteConductivity').set('INFO_PREFIX:sigmal', 'T. G. Zavalis, M. Behm, and G. Lindbergh, "Investigations of Short-Circuit Scenarios in a Lithium-Ion Battery Cell," J. Electrochem. Soc., vol. 159, p. A848, 2012.');
model.material('mat5').propertyGroup('ElectrolyteConductivity').set('T_ref2', '298[K]');
model.material('mat5').propertyGroup('ElectrolyteConductivity').descr('T_ref2', '');
model.material('mat5').propertyGroup('ElectrolyteConductivity').set('T3', 'min(393.15,max(T,223.15))');
model.material('mat5').propertyGroup('ElectrolyteConductivity').descr('T3', '');
model.material('mat5').propertyGroup('ElectrolyteConductivity').addInput('concentration');
model.material('mat5').propertyGroup('ElectrolyteConductivity').addInput('temperature');
model.material('mat5').propertyGroup('SpeciesProperties').func('int1').set('funcname', 'transpNm_int1');
model.material('mat5').propertyGroup('SpeciesProperties').func('int1').set('table', {'200' '0.37';  ...
'500' '0.322';  ...
'800' '0.27';  ...
'1000' '0.251';  ...
'1200' '0.248';  ...
'1600' '0.236';  ...
'2000' '0.11'});
model.material('mat5').propertyGroup('SpeciesProperties').func('int1').set('interp', 'piecewisecubic');
model.material('mat5').propertyGroup('SpeciesProperties').func('int1').set('fununit', {''});
model.material('mat5').propertyGroup('SpeciesProperties').func('int1').set('argunit', {''});
model.material('mat5').propertyGroup('SpeciesProperties').func('int2').set('funcname', 'actdep_int1');
model.material('mat5').propertyGroup('SpeciesProperties').func('int2').set('table', {'200' '0';  ...
'500' '0.29';  ...
'800' '0.695';  ...
'1000' '1';  ...
'1200' '1.32';  ...
'1600' '2.07';  ...
'2000' '2.50'});
model.material('mat5').propertyGroup('SpeciesProperties').func('int2').set('interp', 'piecewisecubic');
model.material('mat5').propertyGroup('SpeciesProperties').func('int2').set('fununit', {''});
model.material('mat5').propertyGroup('SpeciesProperties').func('int2').set('argunit', {''});
model.material('mat5').propertyGroup('SpeciesProperties').set('transpNum', 'transpNm_int1(c/1[mol/m^3])');
model.material('mat5').propertyGroup('SpeciesProperties').set('INFO_PREFIX:transpNum', ['A. Nyman, M. Behm, and G. Lindbergh, ' native2unicode(hex2dec({'20' '1c'}), 'unicode') 'Electrochemical characterisation and modelling of the mass transport phenomena in LiPF6-EC-EMC,' native2unicode(hex2dec({'20' '1d'}), 'unicode') ' Electrochim. Acta, vol. 53, p. 6356, 2008.']);
model.material('mat5').propertyGroup('SpeciesProperties').set('fcl', 'actdep_int1(c/1[mol/m^3])*exp(-1000/8.314*(1/(T_ref3/1[K])-1/(T4/1[K])))');
model.material('mat5').propertyGroup('SpeciesProperties').set('INFO_PREFIX:fcl', 'T. G. Zavalis, M. Behm, and G. Lindbergh, "Investigations of Short-Circuit Scenarios in a Lithium-Ion Battery Cell," J. Electrochem. Soc., vol. 159, p. A848, 2012.');
model.material('mat5').propertyGroup('SpeciesProperties').set('T4', 'min(393.15,max(T,223.15))');
model.material('mat5').propertyGroup('SpeciesProperties').descr('T4', '');
model.material('mat5').propertyGroup('SpeciesProperties').set('T_ref3', '298[K]');
model.material('mat5').propertyGroup('SpeciesProperties').descr('T_ref3', '');
model.material('mat5').propertyGroup('SpeciesProperties').addInput('concentration');
model.material('mat5').propertyGroup('SpeciesProperties').addInput('temperature');
model.material('mat5').propertyGroup('ElectrolyteSaltConcentration').identifier('cElsalt');
model.material('mat5').propertyGroup('ElectrolyteSaltConcentration').set('cElsalt', '1200[mol/m^3]');
model.material('mat1').selection.named('geom1_unisel2');
model.material('mat2').selection.named('geom1_unisel1');
model.material('mat3').selection.named('geom1_sel6');
model.material('mat4').selection.named('geom1_sel3');
model.material('mat5').selection.named('geom1_sel7');

model.physics('liion').create('pce1', 'PorousElectrode', 3);
model.physics('liion').feature('pce1').label('Porous Electrode - Negative');
model.physics('liion').feature('pce1').selection.named('geom1_sel6');
model.physics('liion').feature('pce1').set('ElectrolyteMaterial', 'mat5');
model.physics('liion').feature('pce1').set('sigma', {'sigmas_neg' '0' '0' '0' 'sigmas_neg' '0' '0' '0' 'sigmas_neg'});
model.physics('liion').feature('pce1').set('epss', 'epss_neg');
model.physics('liion').feature('pce1').set('epsl', '1-epss_neg');
model.physics('liion').feature('pce1').feature('pin1').set('rp', 'rp_neg');
model.physics('liion').feature('pce1').feature('per1').set('i0_ref', 'i0ref_neg');
model.physics('liion').create('pce2', 'PorousElectrode', 3);
model.physics('liion').feature('pce2').label('Porous Electrode - Positive');
model.physics('liion').feature('pce2').selection.named('geom1_sel3');
model.physics('liion').feature('pce2').set('ElectrolyteMaterial', 'mat5');
model.physics('liion').feature('pce2').set('sigma', {'sigmas_pos' '0' '0' '0' 'sigmas_pos' '0' '0' '0' 'sigmas_pos'});
model.physics('liion').feature('pce2').set('epss', 'epss_pos');
model.physics('liion').feature('pce2').set('epsl', '1-epss_pos');
model.physics('liion').feature('pce2').feature('pin1').set('rp', 'rp_pos');
model.physics('liion').feature('pce2').feature('per1').set('i0_ref', 'i0ref_pos');
model.physics('liion').create('cc1', 'CurrentConductor', 3);
model.physics('liion').feature('cc1').selection.named('geom1_unisel3');
model.physics('liion').create('egnd1', 'ElectricGround', 2);
model.physics('liion').feature('egnd1').selection.named('geom1_sel8');
model.physics('liion').prop('CellSettings').set('CellSOCandInitialChargeInventory', true);
model.physics('liion').feature('socicd1').set('SOC_init', 'SOC_start');
model.physics('liion').feature('socicd1').feature('neges1').selection.named('geom1_sel6');
model.physics('liion').feature('socicd1').feature('poses1').selection.named('geom1_sel3');

model.variable.create('var1');
model.variable('var1').model('comp1');
model.variable('var1').set('I_app', 'liion.I_1C_cell*C_rate');
model.variable('var1').descr('I_app', 'Applied current');

model.physics('liion').create('ec1', 'ElectrodeCurrent', 2);
model.physics('liion').feature('ec1').selection.named('geom1_sel9');
model.physics('liion').feature('ec1').set('Its', 'I_app');

model.mesh('mesh1').create('map1', 'Map');
model.mesh('mesh1').feature('map1').selection.set([20]);
model.mesh('mesh1').create('swe1', 'Sweep');
model.mesh('mesh1').feature('swe1').create('dis1', 'Distribution');
model.mesh('mesh1').feature('swe1').feature('dis1').selection.named('geom1_sel6');
model.mesh('mesh1').feature('swe1').feature('dis1').set('type', 'predefined');
model.mesh('mesh1').feature('swe1').feature('dis1').set('elemcount', 15);
model.mesh('mesh1').feature('swe1').feature('dis1').set('elemratio', 3);
model.mesh('mesh1').feature('swe1').create('dis2', 'Distribution');
model.mesh('mesh1').feature('swe1').feature('dis2').selection.named('geom1_sel7');
model.mesh('mesh1').feature('swe1').feature('dis2').set('numelem', 4);
model.mesh('mesh1').feature('swe1').create('dis3', 'Distribution');
model.mesh('mesh1').feature('swe1').feature('dis3').selection.named('geom1_sel3');
model.mesh('mesh1').feature('swe1').feature('dis3').set('type', 'predefined');
model.mesh('mesh1').feature('swe1').feature('dis3').set('elemcount', 15);
model.mesh('mesh1').feature('swe1').feature('dis3').set('elemratio', 3);
model.mesh('mesh1').feature('swe1').feature('dis3').set('reverse', true);
model.mesh('mesh1').run;

model.probe.create('var1', 'GlobalVariable');
model.probe('var1').model('comp1');
model.probe('var1').label('Cell Voltage Probe');
model.probe('var1').set('expr', 'liion.phis0_ec1');
model.probe('var1').set('descr', 'Electric potential on boundary');
model.probe('var1').set('descractive', true);
model.probe('var1').set('descr', 'Cell Voltage');

model.study('std1').create('param', 'Parametric');
model.study('std1').feature('param').setIndex('pname', 'C_rate', 0);
model.study('std1').feature('param').setIndex('plistarr', '', 0);
model.study('std1').feature('param').setIndex('punit', 1, 0);
model.study('std1').feature('param').setIndex('pname', 'C_rate', 0);
model.study('std1').feature('param').setIndex('plistarr', '', 0);
model.study('std1').feature('param').setIndex('punit', 1, 0);
model.study('std1').feature('param').setIndex('plistarr', '1 4', 0);
model.study('std1').feature('time').set('tlist', 'range(0,sim_time/2,sim_time)');

model.sol.create('sol1');
model.sol('sol1').study('std1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'cdi');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').feature('comp1_phil').set('scalemethod', 'manual');
model.sol('sol1').feature('v1').feature('comp1_liion_ec1_phis0').set('scalemethod', 'manual');
model.sol('sol1').feature('v1').feature('comp1_phis').set('scalemethod', 'manual');
model.sol('sol1').feature('v1').feature('comp1_cl').set('scalemethod', 'manual');
model.sol('sol1').feature('v1').feature('comp1_phil').set('scaleval', '1');
model.sol('sol1').feature('v1').feature('comp1_liion_ec1_phis0').set('scaleval', '1');
model.sol('sol1').feature('v1').feature('comp1_phis').set('scaleval', '1');
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
model.sol('sol1').feature('v2').feature('comp1_cl').set('scalemethod', 'manual');
model.sol('sol1').feature('v2').feature('comp1_phil').set('scaleval', '1');
model.sol('sol1').feature('v2').feature('comp1_liion_ec1_phis0').set('scaleval', '1');
model.sol('sol1').feature('v2').feature('comp1_liion_pce2_cs').set('scaleval', '10000');
model.sol('sol1').feature('v2').feature('comp1_liion_pce1_cs').set('scaleval', '10000');
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
model.sol('sol1').feature('t1').set('tlist', 'range(0,sim_time/2,sim_time)');
model.sol('sol1').feature('t1').set('plot', 'off');
model.sol('sol1').feature('t1').set('plotgroup', 'Default');
model.sol('sol1').feature('t1').set('plotfreq', 'tout');
model.sol('sol1').feature('t1').set('probesel', 'all');
model.sol('sol1').feature('t1').set('probes', {'var1'});
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
model.sol('sol1').feature('t1').create('se1', 'Segregated');
model.sol('sol1').feature('t1').feature('se1').feature.remove('ssDef');
model.sol('sol1').feature('t1').feature('se1').create('ss1', 'SegregatedStep');
model.sol('sol1').feature('t1').feature('se1').feature('ss1').set('segvar', {'comp1_phil' 'comp1_cl' 'comp1_phis' 'comp1_liion_ec1_phis0'});
model.sol('sol1').feature('t1').feature('se1').feature('ss1').set('subjtech', 'onevery');
model.sol('sol1').feature('t1').create('d1', 'Direct');
model.sol('sol1').feature('t1').feature('d1').set('linsolver', 'pardiso');
model.sol('sol1').feature('t1').feature('d1').label('Direct (liion)');
model.sol('sol1').feature('t1').feature('se1').feature('ss1').set('linsolver', 'd1');
model.sol('sol1').feature('t1').feature('se1').feature('ss1').label('Battery Current Distribution');
model.sol('sol1').feature('t1').feature('se1').create('ss2', 'SegregatedStep');
model.sol('sol1').feature('t1').feature('se1').feature('ss2').set('segvar', {'comp1_liion_pce1_cs'});
model.sol('sol1').feature('t1').feature('se1').feature('ss2').set('linsolver', 'd1');
model.sol('sol1').feature('t1').feature('se1').feature('ss2').label('Insertion Particle Concentration Variables');
model.sol('sol1').feature('t1').feature('se1').create('ss3', 'SegregatedStep');
model.sol('sol1').feature('t1').feature('se1').feature('ss3').set('segvar', {'comp1_liion_pce2_cs'});
model.sol('sol1').feature('t1').feature('se1').feature('ss3').set('linsolver', 'd1');
model.sol('sol1').feature('t1').feature('se1').feature('ss3').label('Insertion Particle Concentration Variables (2)');
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
model.sol('sol1').feature('t1').feature.remove('fcDef');
model.sol('sol1').attach('std1');

model.batch.create('p1', 'Parametric');
model.batch('p1').study('std1');
model.batch('p1').create('so1', 'Solutionseq');
model.batch('p1').feature('so1').set('seq', 'sol1');
model.batch('p1').feature('so1').set('store', 'on');
model.batch('p1').feature('so1').set('clear', 'on');
model.batch('p1').feature('so1').set('psol', 'none');
model.batch('p1').set('pname', {'C_rate'});
model.batch('p1').set('plistarr', {'1 4'});
model.batch('p1').set('sweeptype', 'sparse');
model.batch('p1').set('probesel', 'all');
model.batch('p1').set('probes', {'var1'});
model.batch('p1').set('plot', 'off');
model.batch('p1').set('err', 'on');
model.batch('p1').attach('std1');
model.batch('p1').set('control', 'param');

model.sol.create('sol3');
model.sol('sol3').study('std1');
model.sol('sol3').label('Parametric Solutions 1');

model.batch('p1').feature('so1').set('psol', 'sol3');

model.probe('var1').genResult('none');

model.batch('p1').run('compute');

model.result.create('pg2', 'PlotGroup1D');
model.result('pg2').set('data', 'dset3');
model.result('pg2').create('glob1', 'Global');
model.result('pg2').feature('glob1').set('unit', {''});
model.result('pg2').feature('glob1').set('expr', {'liion.phis0_ec1'});
model.result('pg2').feature('glob1').set('descr', {'Electric potential on boundary'});
model.result('pg2').label('Boundary Electrode Potential with Respect to Ground (liion)');
model.result('pg2').feature('glob1').set('xdatasolnumtype', 'level1');
model.result.create('pg3', 'PlotGroup1D');
model.result('pg3').set('data', 'dset3');
model.result('pg3').create('glob1', 'Global');
model.result('pg3').feature('glob1').set('unit', {''});
model.result('pg3').feature('glob1').set('expr', {'liion.SOC_cell'});
model.result('pg3').feature('glob1').set('descr', {'Cell state of charge'});
model.result('pg3').feature('glob1').set('xdatasolnumtype', 'level1');
model.result('pg3').create('glob2', 'Global');
model.result('pg3').feature('glob2').set('unit', {'' ''});
model.result('pg3').feature('glob2').set('expr', {'liion.soc_average_pce1' 'liion.soc_average_pce2'});
model.result('pg3').feature('glob2').set('descr', {'Average SOC, Porous Electrode - Negative' 'Average SOC, Porous Electrode - Positive'});
model.result('pg3').feature('glob2').set('linestyle', 'dashed');
model.result('pg3').feature('glob2').set('xdatasolnumtype', 'level1');
model.result('pg3').label('Cell and Average Electrode Cell State of Charge (liion)');
model.result('pg3').set('ylabel', 'SOC (1)');
model.result('pg3').set('titletype', 'none');
model.result.create('pg4', 'PlotGroup3D');
model.result('pg4').set('data', 'dset3');
model.result('pg4').setIndex('looplevel', 3, 0);
model.result('pg4').setIndex('looplevel', 2, 1);
model.result('pg4').label('Electrolyte Potential (liion)');
model.result('pg4').create('mslc1', 'Multislice');
model.result('pg4').feature('mslc1').set('expr', {'phil'});
model.result('pg4').create('arwv1', 'ArrowVolume');
model.result('pg4').feature('arwv1').set('expr', {'liion.Ilx' 'liion.Ily' 'liion.Ilz'});
model.result('pg4').feature('arwv1').set('arrowbase', 'center');
model.result('pg4').feature('arwv1').set('color', 'gray');
model.result.create('pg5', 'PlotGroup3D');
model.result('pg5').set('data', 'dset3');
model.result('pg5').setIndex('looplevel', 3, 0);
model.result('pg5').setIndex('looplevel', 2, 1);
model.result('pg5').label('Electrolyte Current Density (liion)');
model.result('pg5').create('arwv1', 'ArrowVolume');
model.result('pg5').feature('arwv1').set('expr', {'liion.Ilx' 'liion.Ily' 'liion.Ilz'});
model.result('pg5').feature('arwv1').set('arrowbase', 'center');
model.result('pg5').feature('arwv1').set('color', 'gray');
model.result('pg5').feature('arwv1').create('col1', 'Color');
model.result('pg5').feature('arwv1').feature('col1').set('expr', 'root.comp1.liion.IlMag');
model.result.create('pg6', 'PlotGroup3D');
model.result('pg6').set('data', 'dset3');
model.result('pg6').setIndex('looplevel', 3, 0);
model.result('pg6').setIndex('looplevel', 2, 1);
model.result('pg6').label('Electrode Potential with Respect to Ground (liion)');
model.result('pg6').create('mslc1', 'Multislice');
model.result('pg6').feature('mslc1').set('expr', {'phis'});
model.result('pg6').create('arwv1', 'ArrowVolume');
model.result('pg6').feature('arwv1').set('expr', {'liion.Isx' 'liion.Isy' 'liion.Isz'});
model.result('pg6').feature('arwv1').set('arrowbase', 'center');
model.result('pg6').feature('arwv1').set('color', 'gray');
model.result.create('pg7', 'PlotGroup3D');
model.result('pg7').set('data', 'dset3');
model.result('pg7').setIndex('looplevel', 3, 0);
model.result('pg7').setIndex('looplevel', 2, 1);
model.result('pg7').label('Electrode Current Density (liion)');
model.result('pg7').create('arwv1', 'ArrowVolume');
model.result('pg7').feature('arwv1').set('expr', {'liion.Isx' 'liion.Isy' 'liion.Isz'});
model.result('pg7').feature('arwv1').set('arrowbase', 'center');
model.result('pg7').feature('arwv1').set('color', 'gray');
model.result('pg7').feature('arwv1').create('col1', 'Color');
model.result('pg7').feature('arwv1').feature('col1').set('expr', 'root.comp1.liion.IsMag');
model.result.create('pg8', 'PlotGroup3D');
model.result('pg8').set('data', 'dset3');
model.result('pg8').setIndex('looplevel', 3, 0);
model.result('pg8').setIndex('looplevel', 2, 1);
model.result('pg8').create('mslc1', 'Multislice');
model.result('pg8').feature('mslc1').set('expr', {'cl'});
model.result('pg8').label('Electrolyte Salt Concentration (liion)');
model.result('pg8').create('arwv1', 'ArrowVolume');
model.result('pg8').feature('arwv1').set('expr', {'liion.Nposx' 'liion.Nposy' 'liion.Nposz'});
model.result('pg8').feature('arwv1').set('color', 'red');
model.result('pg8').create('arwv2', 'ArrowVolume');
model.result('pg8').feature('arwv2').set('expr', {'liion.Nnegx' 'liion.Nnegy' 'liion.Nnegz'});
model.result('pg8').feature('arwv2').set('color', 'black');
model.result('pg8').feature('arwv2').set('inheritplot', 'arwv1');
model.result('pg8').feature('arwv2').set('inheritcolor', 'off');
model.result('pg2').run;
model.result('pg1').set('window', 'window1');
model.result('pg1').run;
model.result('pg1').label('Cell Voltage Probe Plot');
model.result('pg1').set('window', 'window1');
model.result('pg1').run;
model.result.create('pg9', 'PlotGroup3D');
model.result('pg9').run;
model.result('pg9').label('Potential in Negative Current Collector and Tab');
model.result('pg9').set('data', 'dset3');
model.result('pg9').set('looplevel', [1 2]);
model.result('pg9').set('showlegendsmaxmin', true);
model.result('pg9').set('legendactive', true);
model.result('pg9').set('legendprecision', 4);
model.result('pg9').create('vol1', 'Volume');
model.result('pg9').feature('vol1').set('expr', 'phis');
model.result('pg9').feature('vol1').create('sel1', 'Selection');
model.result('pg9').feature('vol1').feature('sel1').selection.named('geom1_unisel1');
model.result('pg9').run;
model.result('pg9').run;
model.result.duplicate('pg10', 'pg9');
model.result('pg10').run;
model.result('pg10').label('Potential in Positive Current Collector and Tab');
model.result('pg10').run;
model.result('pg10').feature('vol1').feature('sel1').selection.named('geom1_unisel2');
model.result('pg10').run;
model.result('pg10').run;
model.result.create('pg11', 'PlotGroup3D');
model.result('pg11').run;
model.result('pg11').label('Relative Current Density Across Separator');
model.result('pg11').set('data', 'dset3');
model.result('pg11').set('looplevel', [1 2]);
model.result('pg11').create('slc1', 'Slice');
model.result('pg11').feature('slc1').set('expr', 'liion.IlMag/(I_app/(H_cell*W_cell))');
model.result('pg11').feature('slc1').set('quickplane', 'xy');
model.result('pg11').feature('slc1').set('quickzmethod', 'coord');
model.result('pg11').feature('slc1').set('quickz', 'L_neg_cc/2+L_neg+L_sep/2');
model.result('pg11').run;
model.result('pg11').run;
model.result('pg11').set('looplevel', [3 2]);
model.result('pg11').run;

model.cpl.create('genproj1', 'GeneralProjection', 'geom1');
model.cpl('genproj1').label('General Projection - Negative');
model.cpl('genproj1').set('opname', 'genproj_neg');
model.cpl('genproj1').selection.named('geom1_sel6');
model.cpl.duplicate('genproj2', 'genproj1');
model.cpl('genproj2').label('General Projection - Positive');
model.cpl('genproj2').set('opname', 'genproj_pos');
model.cpl('genproj2').selection.named('geom1_sel3');

model.probe('var1').genResult('none');

model.sol('sol1').updateSolution;
model.sol('sol3').updateSolution;

model.result.create('pg12', 'PlotGroup3D');
model.result('pg12').run;
model.result('pg12').label('Utilization (Relative Capacity Throughput)');
model.result('pg12').set('data', 'dset3');
model.result('pg12').set('looplevel', [3 1]);
model.result('pg12').set('showlegendsmaxmin', true);
model.result('pg12').create('surf1', 'Surface');
model.result('pg12').feature('surf1').set('expr', 'genproj_pos(at(0,liion.cs_average)-liion.cs_average)*epss_pos*F_const*H_cell*W_cell/(I_app*t)');
model.result('pg12').feature('surf1').create('sel1', 'Selection');
model.result('pg12').feature('surf1').feature('sel1').selection.set([16]);
model.result('pg12').run;
model.result('pg12').run;
model.result('pg12').set('looplevel', [3 2]);
model.result('pg12').run;

model.title('Electrode Utilization in a Large Format Lithium-Ion Battery Pouch Cell');

model.description(['Large lithium-ion batteries are widely deployed in electric vehicles and for stationary energy storage applications. In the (stacked) pouch battery cell design, all current exits the cell on the cell collector tabs; and as the cell size and power increases, the voltage gradients in the highly conductive metal foil current collectors may come into play, resulting in a nonuniform current distribution and electrode utilization in the cell. A nonuniform utilization results in suboptimal use of the battery electrodes and may also result in nonuniform and accelerated electrode aging.' newline  newline 'This tutorial models the current distribution and electrode utilization in a large lithium-ion battery pouch cell and how it depends on the cell current. The model is in 3D.']);

model.mesh.clearMeshes;

model.sol('sol1').clearSolutionData;
model.sol('sol2').clearSolutionData;
model.sol('sol3').clearSolutionData;
model.sol('sol4').clearSolutionData;
model.sol('sol5').clearSolutionData;

model.label('pouch_cell_utilization.mph');

model.modelNode.label('Components');

out = model;
