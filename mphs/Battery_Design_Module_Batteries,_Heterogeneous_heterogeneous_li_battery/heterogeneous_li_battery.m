function out = model
%
% heterogeneous_li_battery.m
%
% Model exported on May 26 2025, 21:26 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/Battery_Design_Module/Batteries,_Heterogeneous');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 3);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.physics.create('liion', 'LithiumIonBatteryMPH', 'geom1');
model.physics('liion').model('comp1');
model.physics.create('tds', 'DilutedSpecies', 'geom1', {'cs'});

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
model.study('std1').feature('cdi').setSolveFor('/physics/tds', true);
model.study('std1').create('time', 'Transient');
model.study('std1').feature('time').set('initialtime', '0');
model.study('std1').feature('time').set('solnum', 'auto');
model.study('std1').feature('time').set('notsolnum', 'auto');
model.study('std1').feature('time').set('outputmap', {});
model.study('std1').feature('time').setSolveFor('/physics/liion', true);
model.study('std1').feature('time').setSolveFor('/physics/tds', true);

model.geom('geom1').insertFile('heterogeneous_li_battery_geom_sequence.mph', 'geom1');
model.geom('geom1').run('sel8');

model.param.set('csmax_neg', '31507[mol/m^3]');
model.param.descr('csmax_neg', 'Maximum lithium concentration in graphite');
model.param.set('i0ref_neg', '0.96[A/m^2]');
model.param.descr('i0ref_neg', 'Reference exchange current density negative');
model.param.set('i0ref_pos', '1.72[A/m^2]');
model.param.descr('i0ref_pos', 'Reference exchange current density positive');
model.param.set('exp_max', '10[%]');
model.param.set('time_param', '1');
model.param.descr('time_param', 'Time parameter for parametric sweep');

model.variable.create('var1');
model.variable('var1').model('comp1');

% To import content from file, use:
% model.variable('var1').loadFile('FILENAME');
model.variable('var1').set('E_cell_init', 'mat3.elpot.Eeq_int1(mat3.OperationalSOC.socmax*mat3.elpot.cEeqref*0.5/mat3.elpot.cEeqref)-mat2.elpot.Eeq_int1(mat2.OperationalSOC.socmax*mat2.elpot.cEeqref*0.7*0.5/mat2.elpot.cEeqref)', 'Initial cell voltage');
model.variable('var1').set('phil_init', '-mat2.elpot.Eeq_int1(mat2.OperationalSOC.socmax*mat2.elpot.cEeqref*0.7*0.5/mat2.elpot.cEeqref)', 'Initial electrolyte potential');
model.variable('var1').set('csinit_pos', 'mat3.OperationalSOC.socmax*mat3.elpot.cEeqref*0.5', 'Initial lithium concentration positive electrode');
model.variable('var1').set('csinit_neg', 'mat2.OperationalSOC.socmax*mat2.elpot.cEeqref*0.7*0.5', 'Initial lithium concentration negative electrode');

model.material.create('mat1', 'Common', 'comp1');
model.material('mat1').propertyGroup.create('ElectrolyteConductivity', 'Electrolyte conductivity');
model.material('mat1').propertyGroup('ElectrolyteConductivity').func.create('int1', 'Interpolation');
model.material('mat1').propertyGroup.create('SpeciesProperties', 'Species properties');
model.material('mat1').propertyGroup.create('ElectrolyteSaltConcentration', 'Electrolyte salt concentration');
model.material('mat1').label('LiPF6 in 1:2 EC:DMC and p(VdF-HFP) (Polymer, Li-ion Battery)');
model.material('mat1').comments([ newline ]);
model.material('mat1').propertyGroup('def').set('diffusion', {'7.5e-11[m^2/s]' '0' '0' '0' '7.5e-11[m^2/s]' '0' '0' '0' '7.5e-11[m^2/s]'});
model.material('mat1').propertyGroup('def').set('INFO_PREFIX:diffusion', ['M. Doyle, J. Newman, A.S. Gozdz, C.N. Schmutz, and J.M. Tarascon, ' native2unicode(hex2dec({'20' '1c'}), 'unicode') 'Comparison of Modeling Predictions with Experimental Data from Plastic Lithium Ion Cells,' native2unicode(hex2dec({'20' '1d'}), 'unicode') ' J. Electrochem. Soc., vol. 143, p. 1890, 1996.' newline ]);
model.material('mat1').propertyGroup('ElectrolyteConductivity').func('int1').set('funcname', 'sigmal_int1');
model.material('mat1').propertyGroup('ElectrolyteConductivity').func('int1').set('table', {'0' '0.0108';  ...
'0.2000' '0.1259';  ...
'0.4000' '0.2055';  ...
'0.6000' '0.2553';  ...
'0.8000' '0.2810';  ...
'1.0000' '0.2873';  ...
'1.2000' '0.2788';  ...
'1.4000' '0.2595';  ...
'1.6000' '0.2331';  ...
'1.8000' '0.2027';  ...
'2.0000' '0.1710';  ...
'2.200' '0.1403';  ...
'2.4000' '0.1123';  ...
'2.6000' '0.0885';  ...
'2.8000' '0.0696';  ...
'3.0000' '0.0563'});
model.material('mat1').propertyGroup('ElectrolyteConductivity').func('int1').set('fununit', {''});
model.material('mat1').propertyGroup('ElectrolyteConductivity').func('int1').set('argunit', {''});
model.material('mat1').propertyGroup('ElectrolyteConductivity').set('sigmal', {'sigmal_int1(c/c_ref)' '0' '0' '0' 'sigmal_int1(c/c_ref)' '0' '0' '0' 'sigmal_int1(c/c_ref)'});
model.material('mat1').propertyGroup('ElectrolyteConductivity').set('INFO_PREFIX:sigmal', ['M. Doyle, J. Newman, A.S. Gozdz, C.N. Schmutz, and J.M. Tarascon, ' native2unicode(hex2dec({'20' '1c'}), 'unicode') 'Comparison of Modeling Predictions with Experimental Data from Plastic Lithium Ion Cells,' native2unicode(hex2dec({'20' '1d'}), 'unicode') ' J. Electrochem. Soc., vol. 143, p. 1890, 1996.' newline ]);
model.material('mat1').propertyGroup('ElectrolyteConductivity').set('c_ref', '1000[mol/m^3]');
model.material('mat1').propertyGroup('ElectrolyteConductivity').descr('c_ref', '');
model.material('mat1').propertyGroup('ElectrolyteConductivity').addInput('concentration');
model.material('mat1').propertyGroup('SpeciesProperties').set('transpNum', '0.363');
model.material('mat1').propertyGroup('SpeciesProperties').set('INFO_PREFIX:transpNum', ['M. Doyle, J. Newman, A.S. Gozdz, C.N. Schmutz, and J.M. Tarascon, ' native2unicode(hex2dec({'20' '1c'}), 'unicode') 'Comparison of Modeling Predictions with Experimental Data from Plastic Lithium Ion Cells,' native2unicode(hex2dec({'20' '1d'}), 'unicode') ' J. Electrochem. Soc., vol. 143, p. 1890, 1996.' newline ]);
model.material('mat1').propertyGroup('SpeciesProperties').set('fcl', '0');
model.material('mat1').propertyGroup('SpeciesProperties').set('INFO_PREFIX:fcl', ['M. Doyle, J. Newman, A.S. Gozdz, C.N. Schmutz, and J.M. Tarascon, ' native2unicode(hex2dec({'20' '1c'}), 'unicode') 'Comparison of Modeling Predictions with Experimental Data from Plastic Lithium Ion Cells,' native2unicode(hex2dec({'20' '1d'}), 'unicode') ' J. Electrochem. Soc., vol. 143, p. 1890, 1996.' newline ]);
model.material('mat1').propertyGroup('ElectrolyteSaltConcentration').identifier('cElsalt');
model.material('mat1').propertyGroup('ElectrolyteSaltConcentration').set('cElsalt', '1000[mol/m^3]');
model.material('mat1').propertyGroup('ElectrolyteSaltConcentration').set('INFO_PREFIX:cElsalt', ['M. Doyle, J. Newman, A.S. Gozdz, C.N. Schmutz, and J.M. Tarascon, ' native2unicode(hex2dec({'20' '1c'}), 'unicode') 'Comparison of Modeling Predictions with Experimental Data from Plastic Lithium Ion Cells,' native2unicode(hex2dec({'20' '1d'}), 'unicode') ' J. Electrochem. Soc., vol. 143, p. 1890, 1996.' newline ]);
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
model.material('mat3').propertyGroup.create('ic', 'Intercalation strain');
model.material('mat3').propertyGroup('ic').func.create('int1', 'Interpolation');
model.material('mat3').propertyGroup.create('EquilibriumConcentration', 'Equilibrium concentration');
model.material('mat3').label('LCO, LiCoO2 (Positive, Li-ion Battery)');
model.material('mat3').comments([ newline ]);
model.material('mat3').propertyGroup('def').set('poissonsratio', '');
model.material('mat3').propertyGroup('def').set('youngsmodulus', '');
model.material('mat3').propertyGroup('def').set('thermalexpansioncoefficient', '');
model.material('mat3').propertyGroup('def').set('poissonsratio', '0.24');
model.material('mat3').propertyGroup('def').set('INFO_PREFIX:poissonsratio', ['E. Cheng, N. Taylor, J. Wolfenstine and J. Sakamoto, Elastic properties of lithium cobalt oxide (LiCoO2), Journal of Asian Ceramic Societies, 5:2,' newline '113-117, (2017), DOI: 10.1016/j.jascer.2017.03.001']);
model.material('mat3').propertyGroup('def').set('youngsmodulus', '191[GPa]');
model.material('mat3').propertyGroup('def').set('INFO_PREFIX:youngsmodulus', ['E. Cheng, N. Taylor, J. Wolfenstine and J. Sakamoto, Elastic properties of lithium cobalt oxide (LiCoO2), Journal of Asian Ceramic Societies, 5:2,' newline '113-117, (2017), DOI: 10.1016/j.jascer.2017.03.001']);
model.material('mat3').propertyGroup('def').set('thermalexpansioncoefficient', {'1.3e-5[1/K]' '0' '0' '0' '1.3e-5[1/K]' '0' '0' '0' '1.3e-5[1/K]'});
model.material('mat3').propertyGroup('def').set('INFO_PREFIX:thermalexpansioncoefficient', ['E. Cheng, N. Taylor, J. Wolfenstine and J. Sakamoto, Elastic properties of lithium cobalt oxide (LiCoO2), Journal of Asian Ceramic Societies, 5:2,' newline '113-117, (2017), DOI: 10.1016/j.jascer.2017.03.001']);
model.material('mat3').propertyGroup('def').set('electricconductivity', {'1.13[mS/cm]' '0' '0' '0' '1.13[mS/cm]' '0' '0' '0' '1.13[mS/cm]'});
model.material('mat3').propertyGroup('def').set('INFO_PREFIX:electricconductivity', 'M. Tang, P. Albertus, J. Harb, and J. Newman, "Two-Dimensional Modeling of Lithium Deposition during Cell Charging", J. Electrochemical Society, vol. 156, p. A390, 2009');
model.material('mat3').propertyGroup('def').set('diffusion', {'5e-13[m^2/s]' '0' '0' '0' '5e-13[m^2/s]' '0' '0' '0' '5e-13[m^2/s]'});
model.material('mat3').propertyGroup('def').set('INFO_PREFIX:diffusion', 'D. Stephenson, E. Hartman, J. Harb, D. Wheeler, "Modeling of Particle-Particle Interactions in Porous Cathodes for Lithium-Ion Batteries", J. Electrochemical Society, vol. 154, p. A1146, 2007');
model.material('mat3').propertyGroup('def').set('density', '5000[kg/m^3]');
model.material('mat3').propertyGroup('def').set('INFO_PREFIX:density', 'N. Nitta, F. Wu, J. Tae Lee, and G. Yushin, Materials Today, Volume 18, Number 5, June 2015');
model.material('mat3').propertyGroup('def').set('csmax', '56250[mol/m^3]');
model.material('mat3').propertyGroup('def').descr('csmax', '');
model.material('mat3').propertyGroup('ElectrodePotential').func('int1').set('funcname', 'Eeq_int1');
model.material('mat3').propertyGroup('ElectrodePotential').func('int1').set('table', {'0.43' '4.3';  ...
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
model.material('mat3').propertyGroup('ElectrodePotential').func('int1').set('interp', 'piecewisecubic');
model.material('mat3').propertyGroup('ElectrodePotential').func('int1').set('extrap', 'linear');
model.material('mat3').propertyGroup('ElectrodePotential').func('int1').set('fununit', {'V'});
model.material('mat3').propertyGroup('ElectrodePotential').func('int1').set('argunit', {''});
model.material('mat3').propertyGroup('ElectrodePotential').func('int1').set('defineinv', true);
model.material('mat3').propertyGroup('ElectrodePotential').func('int1').set('funcinvname', 'Eeq_inv');
model.material('mat3').propertyGroup('ElectrodePotential').func('int2').set('funcname', 'dEeqdT_int1');
model.material('mat3').propertyGroup('ElectrodePotential').func('int2').set('table', {'0.545' '-0.33e-3';  ...
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
model.material('mat3').propertyGroup('ElectrodePotential').func('int2').set('interp', 'piecewisecubic');
model.material('mat3').propertyGroup('ElectrodePotential').func('int2').set('fununit', {'V/K'});
model.material('mat3').propertyGroup('ElectrodePotential').func('int2').set('argunit', {''});
model.material('mat3').propertyGroup('ElectrodePotential').set('Eeq', 'Eeq_int1(soc)+dEeqdT_int1(soc)*(T-298[K])');
model.material('mat3').propertyGroup('ElectrodePotential').set('INFO_PREFIX:Eeq', 'M. Tang, P. Albertus, J. Harb, and J. Newman, "Two-Dimensional Modeling of Lithium Deposition during Cell Charging", J. Electrochemical Society, vol. 156, p. A390, 2009');
model.material('mat3').propertyGroup('ElectrodePotential').set('dEeqdT', 'dEeqdT_int1(soc)');
model.material('mat3').propertyGroup('ElectrodePotential').set('INFO_PREFIX:dEeqdT', ['K. E. Thomas, and J. Newman, ' native2unicode(hex2dec({'20' '1c'}), 'unicode') 'Heats of mixing and of entropy in porous insertion electrodes,' native2unicode(hex2dec({'20' '1d'}), 'unicode') ' J. Power Sources., vol. 119-121, p. 844, 2003.']);
model.material('mat3').propertyGroup('ElectrodePotential').set('cEeqref', 'def.csmax');
model.material('mat3').propertyGroup('ElectrodePotential').set('INFO_PREFIX:cEeqref', 'M. Tang, P. Albertus, J. Harb, and J. Newman, "Two-Dimensional Modeling of Lithium Deposition during Cell Charging", J. Electrochemical Society, vol. 156, p. A390, 2009');
model.material('mat3').propertyGroup('ElectrodePotential').set('soc', 'c/cEeqref');
model.material('mat3').propertyGroup('ElectrodePotential').descr('soc', '');
model.material('mat3').propertyGroup('ElectrodePotential').addInput('concentration');
model.material('mat3').propertyGroup('ElectrodePotential').addInput('temperature');
model.material('mat3').propertyGroup('OperationalSOC').set('socmax', 'elpot.Eeq_inv(E_min)');
model.material('mat3').propertyGroup('OperationalSOC').set('socmin', 'elpot.Eeq_inv(E_max)');
model.material('mat3').propertyGroup('OperationalSOC').set('E_max', '4.2[V]');
model.material('mat3').propertyGroup('OperationalSOC').set('E_min', '3.8[V]');
model.material('mat3').propertyGroup('ic').func('int1').set('funcname', 'dVOLdSOL');
model.material('mat3').propertyGroup('ic').func('int1').set('table', {'1' '0';  ...
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
model.material('mat3').propertyGroup('ic').func('int1').set('extrap', 'linear');
model.material('mat3').propertyGroup('ic').func('int1').set('fununit', {'%'});
model.material('mat3').propertyGroup('ic').func('int1').set('argunit', {'1'});
model.material('mat3').propertyGroup('ic').set('dvol', 'dVOLdSOL(c/elpot.cEeqref)');
model.material('mat3').propertyGroup('ic').set('INFO_PREFIX:dvol', ['R. Koerver and others, ' native2unicode(hex2dec({'20' '1c'}), 'unicode') 'Chemo-mechanical expansion of lithium electrode materials ' native2unicode(hex2dec({'20' '14'}), 'unicode') ' on the route to mechanically optimized all-solid-state batteries,' native2unicode(hex2dec({'20' '1d'}), 'unicode') ' Energy Environ. Sci., vol. 11, pp. 2142' native2unicode(hex2dec({'20' '13'}), 'unicode') '2158, 201']);
model.material('mat3').propertyGroup('ic').addInput('concentration');
model.material('mat3').propertyGroup('EquilibriumConcentration').set('csEq', 'def.csmax*elpot.Eeq_inv(V)');
model.material('mat3').propertyGroup('EquilibriumConcentration').addInput('electricpotential');
model.material('mat1').selection.named('geom1_sel1');
model.material('mat2').selection.named('geom1_sel2');
model.material('mat3').selection.named('geom1_sel3');

model.physics('liion').feature('sep1').set('ElectrolyteMaterial', 'mat1');
model.physics('liion').feature('sep1').set('epsl', 1);
model.physics('liion').feature('init1').set('phil', 'phil_init');
model.physics('liion').feature('init1').label('Initial Values - Negative and Electrolyte');
model.physics('liion').create('init2', 'init', 3);
model.physics('liion').feature('init2').selection.named('geom1_sel3');
model.physics('liion').feature('init2').label('Initial Values - Positive');
model.physics('liion').feature('init2').set('phil', 'phil_init');
model.physics('liion').feature('init2').set('phis', 'E_cell_init');
model.physics('liion').create('cc1', 'CurrentConductor', 3);
model.physics('liion').feature('cc1').label('Electrode - Negative');
model.physics('liion').feature('cc1').selection.named('geom1_sel2');
model.physics('liion').feature.duplicate('cc2', 'cc1');
model.physics('liion').feature('cc2').selection.named('geom1_sel3');
model.physics('liion').feature('cc2').label('Electrode - Positive');
model.physics('liion').create('bei1', 'InternalElectrodeSurface', 2);
model.physics('liion').feature('bei1').selection.named('geom1_sel4');
model.physics('liion').feature('bei1').feature('er1').set('minput_concentration_src', 'root.comp1.cs');
model.physics('liion').feature('bei1').feature('er1').set('ElectrodeKinetics', 'LithiumInsertion');
model.physics('liion').feature('bei1').feature('er1').set('MaterialOption', 'mat2');
model.physics('liion').feature('bei1').feature('er1').set('i0_ref', 'i0ref_neg');
model.physics('liion').feature('bei1').create('dlc1', 'DoubleLayerCapacitance', 2);
model.physics('liion').feature('bei1').label('Internal Electrode Surface - Negative');
model.physics('liion').create('bei2', 'InternalElectrodeSurface', 2);
model.physics('liion').feature('bei2').label('Internal Electrode Surface - Positive');
model.physics('liion').feature('bei2').selection.named('geom1_sel5');
model.physics('liion').feature('bei2').feature('er1').set('minput_concentration_src', 'root.comp1.cs');
model.physics('liion').feature('bei2').feature('er1').set('ElectrodeKinetics', 'LithiumInsertion');
model.physics('liion').feature('bei2').feature('er1').set('MaterialOption', 'mat3');
model.physics('liion').feature('bei2').feature('er1').set('i0_ref', 'i0ref_pos');
model.physics('liion').feature('bei2').create('dlc1', 'DoubleLayerCapacitance', 2);
model.physics('liion').create('egnd1', 'ElectricGround', 2);
model.physics('liion').feature('egnd1').selection.named('geom1_sel6');
model.physics('liion').create('ec1', 'ElectrodeCurrent', 2);
model.physics('liion').feature('ec1').selection.named('geom1_sel7');
model.physics('liion').feature('ec1').set('Its', '-1e-9[A]');
model.physics('liion').feature('ec1').set('phis0init', 'E_cell_init');

model.probe.create('bnd1', 'Boundary');
model.probe('bnd1').model('comp1');
model.probe('bnd1').set('intsurface', true);
model.probe('bnd1').label('phis');
model.probe('bnd1').selection.set([210]);
model.probe('bnd1').set('expr', 'phis');

model.physics('tds').selection.set([2 3]);
model.physics('tds').prop('TransportMechanism').set('Convection', false);
model.physics('tds').prop('ShapeProperty').set('order_concentration', 2);
model.physics('tds').feature('cdm1').label('Transport Properties - Negative');
model.physics('tds').feature('cdm1').set('DiffusionMaterialList', 'mat2');
model.physics('tds').feature('cdm1').set('D_cs_mat', 'def');
model.physics('tds').feature('init1').label('Initial Values - Negative');
model.physics('tds').feature('init1').setIndex('initc', 'csinit_neg', 0);
model.physics('tds').create('cdm2', 'ConvectionDiffusionMigration', 3);
model.physics('tds').feature('cdm2').label('Transport Properties - Positive');
model.physics('tds').feature('cdm2').selection.named('geom1_sel3');
model.physics('tds').feature('cdm2').set('DiffusionMaterialList', 'mat3');
model.physics('tds').feature('cdm2').set('D_cs_mat', 'def');
model.physics('tds').create('init2', 'init', 3);
model.physics('tds').feature('init2').label('Initial Values - Positive');
model.physics('tds').feature('init2').selection.named('geom1_sel3');
model.physics('tds').feature('init2').setIndex('initc', 'csinit_pos', 0);
model.physics('tds').create('eeic1', 'ElectrodeElectrolyteInterfaceCoupling', 2);
model.physics('tds').feature('eeic1').selection.named('geom1_sel4');
model.physics('tds').feature('eeic1').feature('rc1').set('iloc_src', 'root.comp1.liion.bei1.er1.iloc');
model.physics('tds').feature('eeic1').feature('rc1').setIndex('Vib', 1, 0);
model.physics('tds').create('eeic2', 'ElectrodeElectrolyteInterfaceCoupling', 2);
model.physics('tds').feature('eeic2').selection.named('geom1_sel5');
model.physics('tds').feature('eeic2').feature('rc1').set('iloc_src', 'root.comp1.liion.bei2.er1.iloc');
model.physics('tds').feature('eeic2').feature('rc1').setIndex('Vib', 1, 0);

model.mesh('mesh1').autoMeshSize(6);
model.mesh('mesh1').create('ftet1', 'FreeTet');
model.mesh('mesh1').feature('ftet1').selection.geom('geom1', 3);
model.mesh('mesh1').feature('ftet1').selection.set([2 3]);
model.mesh('mesh1').feature('ftet1').create('size1', 'Size');
model.mesh('mesh1').feature('ftet1').feature('size1').selection.named('geom1_sel2');
model.mesh('mesh1').feature('ftet1').feature('size1').set('hauto', 4);
model.mesh('mesh1').feature('ftet1').create('size2', 'Size');
model.mesh('mesh1').feature('ftet1').feature('size2').selection.named('geom1_sel3');
model.mesh('mesh1').feature('ftet1').feature('size2').set('hauto', 4);
model.mesh('mesh1').create('ftet2', 'FreeTet');
model.mesh('mesh1').feature('ftet2').create('size1', 'Size');
model.mesh('mesh1').feature('ftet2').feature('size1').set('hauto', 3);
model.mesh('mesh1').run;

model.study('std1').label('Study 1 - Discharge');
model.study('std1').setGenPlots(false);

model.sol.create('sol1');

model.mesh('mesh1').stat.selection.geom(3);
model.mesh('mesh1').stat.selection.set([2 3]);

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
model.sol('sol1').feature('v2').feature('comp1_phis').set('scalemethod', 'manual');
model.sol('sol1').feature('v2').feature('comp1_cl').set('scalemethod', 'manual');
model.sol('sol1').feature('v2').feature('comp1_phil').set('scaleval', '1');
model.sol('sol1').feature('v2').feature('comp1_liion_ec1_phis0').set('scaleval', '1');
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
model.sol('sol1').feature('t1').set('probes', {'bnd1'});
model.sol('sol1').feature('t1').set('probefreq', 'tsteps');
model.sol('sol1').feature('t1').set('rtol', 0.001);
model.sol('sol1').feature('t1').set('atolglobalvaluemethod', 'factor');
model.sol('sol1').feature('t1').set('eventout', true);
model.sol('sol1').feature('t1').set('reacf', true);
model.sol('sol1').feature('t1').set('storeudot', true);
model.sol('sol1').feature('t1').set('endtimeinterpolation', true);
model.sol('sol1').feature('t1').set('maxorder', 2);
model.sol('sol1').feature('t1').set('stabcntrl', true);
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
model.sol('sol1').feature('t1').feature('se1').feature('ss2').set('segvar', {'comp1_cs'});
model.sol('sol1').feature('t1').feature('se1').feature('ss2').set('subdamp', 0.8);
model.sol('sol1').feature('t1').feature('se1').feature('ss2').set('subjtech', 'once');
model.sol('sol1').feature('t1').feature('se1').feature('ss2').set('subtermconst', 'iter');
model.sol('sol1').feature('t1').create('i1', 'Iterative');
model.sol('sol1').feature('t1').feature('i1').set('linsolver', 'gmres');
model.sol('sol1').feature('t1').feature('i1').set('prefuntype', 'left');
model.sol('sol1').feature('t1').feature('i1').set('itrestart', 50);
model.sol('sol1').feature('t1').feature('i1').set('rhob', 400);
model.sol('sol1').feature('t1').feature('i1').set('maxlinit', 50);
model.sol('sol1').feature('t1').feature('i1').set('nlinnormuse', 'on');
model.sol('sol1').feature('t1').feature('i1').label('AMG, concentrations (tds)');
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
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('pr').create('sl1', 'SORLine');
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('pr').feature('sl1').set('linesweeptype', 'ssor');
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('pr').feature('sl1').set('iter', 1);
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('pr').feature('sl1').set('linerelax', 0.7);
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('pr').feature('sl1').set('linealgorithm', 'mesh');
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('pr').feature('sl1').set('linemethod', 'coupled');
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('pr').feature('sl1').set('seconditer', 1);
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('pr').feature('sl1').set('relax', 0.5);
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('po').create('sl1', 'SORLine');
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('po').feature('sl1').set('linesweeptype', 'ssor');
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('po').feature('sl1').set('iter', 1);
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('po').feature('sl1').set('linerelax', 0.7);
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('po').feature('sl1').set('linealgorithm', 'mesh');
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('po').feature('sl1').set('linemethod', 'coupled');
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('po').feature('sl1').set('seconditer', 1);
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('po').feature('sl1').set('relax', 0.5);
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('cs').create('d1', 'Direct');
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('cs').feature('d1').set('linsolver', 'pardiso');
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('cs').feature('d1').set('pivotperturb', 1.0E-13);
model.sol('sol1').feature('t1').feature('se1').feature('ss2').set('linsolver', 'i1');
model.sol('sol1').feature('t1').feature('se1').feature('ss2').label('Concentration Cs');
model.sol('sol1').feature('t1').feature('se1').set('maxsegiter', 10);
model.sol('sol1').feature('t1').feature('se1').set('segstabacc', 'segaacc');
model.sol('sol1').feature('t1').feature('se1').set('segaaccdim', 5);
model.sol('sol1').feature('t1').feature('se1').set('segaaccdelay', 0);
model.sol('sol1').feature('t1').feature('se1').set('segaaccmix', 0.9);
model.sol('sol1').feature('t1').create('i2', 'Iterative');
model.sol('sol1').feature('t1').feature('i2').set('maxlinit', 1000);
model.sol('sol1').feature('t1').feature('i2').set('nlinnormuse', 'on');
model.sol('sol1').feature('t1').feature('i2').label('Algebraic Multigrid (liion)');
model.sol('sol1').feature('t1').feature('i2').create('mg1', 'Multigrid');
model.sol('sol1').feature('t1').feature('i2').feature('mg1').set('prefun', 'saamg');
model.sol('sol1').feature('t1').feature('i2').feature('mg1').set('maxcoarsedof', 50000);
model.sol('sol1').feature('t1').feature('i2').feature('mg1').set('saamgcompwise', true);
model.sol('sol1').feature('t1').feature('i2').feature('mg1').set('compactaggregation', true);
model.sol('sol1').feature('t1').feature('i2').feature('mg1').feature('pr').create('sl1', 'SORLine');
model.sol('sol1').feature('t1').feature('i2').feature('mg1').feature('po').create('sl1', 'SORLine');
model.sol('sol1').feature('t1').feature('i2').feature('mg1').feature('cs').create('d1', 'Direct');
model.sol('sol1').feature('t1').feature('i2').feature('mg1').feature('cs').feature('d1').set('linsolver', 'pardiso');
model.sol('sol1').feature('t1').create('i3', 'Iterative');
model.sol('sol1').feature('t1').feature('i3').set('maxlinit', 1000);
model.sol('sol1').feature('t1').feature('i3').set('nlinnormuse', 'on');
model.sol('sol1').feature('t1').feature('i3').label('Geometric Multigrid (liion)');
model.sol('sol1').feature('t1').feature('i3').create('mg1', 'Multigrid');
model.sol('sol1').feature('t1').feature('i3').feature('mg1').feature('pr').create('sl1', 'SORLine');
model.sol('sol1').feature('t1').feature('i3').feature('mg1').feature('po').create('sl1', 'SORLine');
model.sol('sol1').feature('t1').feature('i3').feature('mg1').feature('cs').create('d1', 'Direct');
model.sol('sol1').feature('t1').feature('i3').feature('mg1').feature('cs').feature('d1').set('linsolver', 'pardiso');
model.sol('sol1').feature('t1').create('d2', 'Direct');
model.sol('sol1').feature('t1').feature('d2').set('linsolver', 'pardiso');
model.sol('sol1').feature('t1').feature('d2').set('pivotperturb', 1.0E-13);
model.sol('sol1').feature('t1').feature('d2').label('Direct, concentrations (tds)');
model.sol('sol1').feature('t1').feature.remove('fcDef');
model.sol('sol1').attach('std1');

model.study('std1').feature('cdi').set('initType', 'secondary');
model.study('std1').feature('time').set('tlist', 'range(0,5,75)');
model.study('std1').feature('time').set('usertol', true);
model.study('std1').feature('time').set('rtol', '1e-4');

model.sol('sol1').feature('t1').set('consistent', false);
model.sol('sol1').feature('t1').create('fc1', 'FullyCoupled');

model.probe('bnd1').genResult('none');

model.sol('sol1').runAll;

model.result('pg1').set('window', 'window1');
model.result('pg1').run;
model.result('pg1').label('Cell Voltage');
model.result('pg1').set('ylabelactive', true);
model.result('pg1').set('ylabel', 'Cell Voltage');
model.result('pg1').set('window', 'window1');
model.result('pg1').run;
model.result.create('pg2', 'PlotGroup3D');
model.result('pg2').run;
model.result('pg2').label('Electrolyte Salt Concentration (liion)');
model.result('pg2').create('surf1', 'Surface');
model.result('pg2').feature('surf1').set('expr', 'cl');
model.result('pg2').run;
model.result.create('pg3', 'PlotGroup3D');
model.result('pg3').run;
model.result('pg3').label('Electrolyte Potential (liion)');
model.result('pg3').create('surf1', 'Surface');
model.result('pg3').run;
model.result.create('pg4', 'PlotGroup3D');
model.result('pg4').run;
model.result('pg4').label('Lithium Concentration Surface (tds)');
model.result('pg4').create('surf1', 'Surface');
model.result('pg4').feature('surf1').set('colortable', 'AuroraBorealis');
model.result('pg4').feature('surf1').label('Negative Electrode');
model.result('pg4').feature('surf1').set('expr', 'cs');
model.result('pg4').feature('surf1').create('sel1', 'Selection');
model.result('pg4').feature('surf1').feature('sel1').selection.named('geom1_sel4');
model.result('pg4').run;
model.result('pg4').run;
model.result('pg4').feature.duplicate('surf2', 'surf1');
model.result('pg4').run;
model.result('pg4').feature('surf2').set('colortable', 'ThermalDark');
model.result('pg4').feature('surf2').label('Positive Electrode');
model.result('pg4').run;
model.result('pg4').feature('surf2').feature('sel1').selection.named('geom1_sel5');
model.result('pg4').run;
model.result.create('pg5', 'PlotGroup3D');
model.result('pg5').run;
model.result('pg5').label('Current Distribution');
model.result('pg5').create('surf1', 'Surface');
model.result('pg5').feature('surf1').set('expr', 'abs(liion.iloc_er1)');
model.result('pg5').feature('surf1').label('Negative Electrode');
model.result('pg5').feature('surf1').create('sel1', 'Selection');
model.result('pg5').feature('surf1').feature('sel1').selection.named('geom1_sel4');
model.result('pg5').run;
model.result('pg5').run;
model.result('pg5').feature.duplicate('surf2', 'surf1');
model.result('pg5').run;
model.result('pg5').feature('surf2').label('Positive Electrode');
model.result('pg5').feature('surf2').set('inheritplot', 'surf1');
model.result('pg5').run;
model.result('pg5').feature('surf2').feature('sel1').selection.named('geom1_sel5');
model.result('pg5').run;
model.result('pg5').create('str1', 'Streamline');
model.result('pg5').feature('str1').selection.named('geom1_sel4');
model.result('pg5').feature('str1').set('linetype', 'ribbon');
model.result('pg5').feature('str1').set('widthexpr', 'liion.IlMag');
model.result('pg5').feature('str1').set('widthscaleactive', true);
model.result('pg5').feature('str1').set('widthscale', '4e-10');
model.result('pg5').feature('str1').set('recover', 'pprint');
model.result('pg5').feature('str1').create('col1', 'Color');
model.result('pg5').run;
model.result('pg5').feature('str1').feature('col1').set('colortable', 'ThermalDark');
model.result('pg5').feature('str1').feature('col1').set('colorlegend', false);
model.result('pg5').run;
model.result.create('pg6', 'PlotGroup3D');
model.result('pg6').run;
model.result('pg6').label('Lithium Concentration in Negative Electrode');
model.result('pg6').create('slc1', 'Slice');
model.result('pg6').feature('slc1').set('expr', 'cs');
model.result('pg6').feature('slc1').set('descr', 'Concentration');
model.result('pg6').feature('slc1').set('quickplane', 'xy');
model.result('pg6').feature('slc1').set('quickznumber', 2);
model.result('pg6').feature('slc1').set('colortable', 'AuroraBorealis');
model.result('pg6').feature('slc1').create('sel1', 'Selection');
model.result('pg6').feature('slc1').feature('sel1').selection.named('geom1_sel2');
model.result('pg6').run;
model.result('pg6').create('surf1', 'Surface');
model.result('pg6').feature('surf1').set('expr', 'cs');
model.result('pg6').feature('surf1').set('descr', 'Concentration');
model.result('pg6').feature('surf1').set('inheritplot', 'slc1');
model.result('pg6').feature('surf1').create('sel1', 'Selection');
model.result('pg6').feature('surf1').feature('sel1').selection.named('geom1_sel4');
model.result('pg6').run;

model.physics.create('solid', 'SolidMechanics', 'geom1');
model.physics('solid').model('comp1');

model.study('std1').feature('cdi').setSolveFor('/physics/solid', true);
model.study('std1').feature('time').setSolveFor('/physics/solid', true);

model.physics('solid').selection.named('geom1_sel2');
model.physics('solid').feature('lemm1').set('minput_concentration_src', 'root.comp1.cs');
model.physics('solid').feature('lemm1').create('ic1', 'IntercalationStrain', 3);
model.physics('solid').feature('lemm1').feature('ic1').set('minput_concentration_src', 'root.comp1.cs');
model.physics('solid').create('roll1', 'Roller', 2);
model.physics('solid').feature('roll1').selection.named('geom1_sel8');
model.physics('solid').create('disp1', 'Displacement2', 2);
model.physics('solid').feature('disp1').selection.named('geom1_sel6');
model.physics('solid').feature('disp1').setIndex('Direction', 'prescribed', 0);
model.physics('solid').feature('disp1').setIndex('Direction', 'prescribed', 1);
model.physics('solid').feature('disp1').setIndex('Direction', 'prescribed', 2);

model.study.create('std2');
model.study('std2').create('stat', 'Stationary');
model.study('std2').feature('stat').setSolveFor('/physics/liion', true);
model.study('std2').feature('stat').setSolveFor('/physics/tds', true);
model.study('std2').feature('stat').setSolveFor('/physics/solid', true);
model.study('std2').label('Study 2 - Expansion and Stress');
model.study('std2').create('param', 'Parametric');
model.study('std2').feature('param').setIndex('pname', 'Rp', 0);
model.study('std2').feature('param').setIndex('plistarr', '', 0);
model.study('std2').feature('param').setIndex('punit', 'm', 0);
model.study('std2').feature('param').setIndex('pname', 'Rp', 0);
model.study('std2').feature('param').setIndex('plistarr', '', 0);
model.study('std2').feature('param').setIndex('punit', 'm', 0);
model.study('std2').feature('param').setIndex('pname', 'time_param', 0);
model.study('std2').feature('param').setIndex('plistarr', '0 75', 0);
model.study('std2').feature('param').set('probesel', 'none');
model.study('std2').feature('stat').setEntry('activate', 'liion', false);
model.study('std2').feature('stat').setEntry('activate', 'tds', false);
model.study('std2').feature('stat').set('usesol', true);
model.study('std2').feature('stat').set('notsolmethod', 'sol');
model.study('std2').feature('stat').set('notstudy', 'std1');
model.study('std2').feature('stat').set('notsol', 'sol1');
model.study('std2').feature('stat').set('notsolnum', 'interp');
model.study('std2').feature('stat').set('nott', 'time_param');

model.sol.create('sol3');
model.sol('sol3').study('std2');
model.sol('sol3').create('st1', 'StudyStep');
model.sol('sol3').feature('st1').set('study', 'std2');
model.sol('sol3').feature('st1').set('studystep', 'stat');
model.sol('sol3').create('v1', 'Variables');
model.sol('sol3').feature('v1').set('control', 'stat');
model.sol('sol3').create('s1', 'Stationary');
model.sol('sol3').feature('s1').feature('aDef').set('cachepattern', true);
model.sol('sol3').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol3').feature('s1').feature('fc1').set('termonres', 'auto');
model.sol('sol3').feature('s1').feature('fc1').set('reserrfact', 1000);
model.sol('sol3').feature('s1').create('d1', 'Direct');
model.sol('sol3').feature('s1').feature('d1').set('linsolver', 'pardiso');
model.sol('sol3').feature('s1').feature('d1').set('pivotperturb', 1.0E-9);
model.sol('sol3').feature('s1').feature('d1').label('Suggested Direct Solver (solid)');
model.sol('sol3').feature('s1').create('i1', 'Iterative');
model.sol('sol3').feature('s1').feature('i1').set('linsolver', 'gmres');
model.sol('sol3').feature('s1').feature('i1').set('rhob', 400);
model.sol('sol3').feature('s1').feature('i1').set('nlinnormuse', true);
model.sol('sol3').feature('s1').feature('i1').label('Suggested Iterative Solver (solid)');
model.sol('sol3').feature('s1').feature('i1').create('mg1', 'Multigrid');
model.sol('sol3').feature('s1').feature('i1').feature('mg1').set('prefun', 'gmg');
model.sol('sol3').feature('s1').feature('i1').feature('mg1').feature('pr').create('so1', 'SOR');
model.sol('sol3').feature('s1').feature('i1').feature('mg1').feature('pr').feature('so1').set('relax', 0.8);
model.sol('sol3').feature('s1').feature('i1').feature('mg1').feature('po').create('so1', 'SOR');
model.sol('sol3').feature('s1').feature('i1').feature('mg1').feature('po').feature('so1').set('relax', 0.8);
model.sol('sol3').feature('s1').feature('i1').feature('mg1').feature('cs').create('d1', 'Direct');
model.sol('sol3').feature('s1').feature('i1').feature('mg1').feature('cs').feature('d1').set('linsolver', 'pardiso');
model.sol('sol3').feature('s1').feature('i1').feature('mg1').feature('cs').feature('d1').set('pivotperturb', 1.0E-9);
model.sol('sol3').feature('s1').feature('fc1').set('linsolver', 'd1');
model.sol('sol3').feature('s1').feature('fc1').set('termonres', 'auto');
model.sol('sol3').feature('s1').feature('fc1').set('reserrfact', 1000);
model.sol('sol3').feature('s1').feature.remove('fcDef');
model.sol('sol3').attach('std2');

model.batch.create('p1', 'Parametric');
model.batch('p1').study('std2');
model.batch('p1').create('so1', 'Solutionseq');
model.batch('p1').feature('so1').set('seq', 'sol3');
model.batch('p1').feature('so1').set('store', 'on');
model.batch('p1').feature('so1').set('clear', 'on');
model.batch('p1').feature('so1').set('psol', 'none');
model.batch('p1').set('pname', {'time_param'});
model.batch('p1').set('plistarr', {'0 75'});
model.batch('p1').set('sweeptype', 'sparse');
model.batch('p1').set('probesel', 'none');
model.batch('p1').set('probes', {'bnd1'});
model.batch('p1').set('plot', 'off');
model.batch('p1').set('err', 'on');
model.batch('p1').attach('std2');
model.batch('p1').set('control', 'param');

model.sol.create('sol4');
model.sol('sol4').study('std2');
model.sol('sol4').label('Parametric Solutions 1');

model.batch('p1').feature('so1').set('psol', 'sol4');
model.batch('p1').run('compute');

model.result.create('pg7', 'PlotGroup3D');
model.result('pg7').set('data', 'dset5');
model.result('pg7').setIndex('looplevel', 2, 0);
model.result('pg7').set('defaultPlotID', 'stress');
model.result('pg7').label('Stress (solid)');
model.result('pg7').set('frametype', 'spatial');
model.result('pg7').create('vol1', 'Volume');
model.result('pg7').feature('vol1').set('expr', {'solid.misesGp'});
model.result('pg7').feature('vol1').set('threshold', 'manual');
model.result('pg7').feature('vol1').set('thresholdvalue', 0.2);
model.result('pg7').feature('vol1').set('colortable', 'Rainbow');
model.result('pg7').feature('vol1').set('colortabletrans', 'none');
model.result('pg7').feature('vol1').set('colorscalemode', 'linear');
model.result('pg7').feature('vol1').set('resolution', 'custom');
model.result('pg7').feature('vol1').set('refine', 2);
model.result('pg7').feature('vol1').set('colortable', 'Prism');
model.result('pg7').feature('vol1').create('def', 'Deform');
model.result('pg7').feature('vol1').feature('def').set('expr', {'u' 'v' 'w'});
model.result('pg7').feature('vol1').feature('def').set('descr', 'Displacement field');
model.result('pg7').run;

model.study('std1').feature('time').setEntry('activate', 'solid', false);

model.result('pg7').run;
model.result('pg7').set('edges', false);
model.result('pg7').run;

model.title('Heterogeneous Lithium-Ion Battery');

model.description(['This model describes the behavior of a lithium-ion battery unit cell modeled using an idealized three-dimensional geometry. The geometry mimics the structural details in the porous electrodes. Such models are referred to as heterogeneous models.' newline  newline 'In contrast to the typical homogenized approach for describing porous electrodes, heterogeneous models describes the actual shapes of the pore electrolyte and electrode particles. The model uses a coupling to structural mechanics to calculate von' native2unicode(hex2dec({'00' 'a0'}), 'unicode') 'Mises stresses in the particles.']);

model.mesh.clearMeshes;

model.sol('sol1').clearSolutionData;
model.sol('sol2').clearSolutionData;
model.sol('sol3').clearSolutionData;
model.sol('sol4').clearSolutionData;
model.sol('sol5').clearSolutionData;
model.sol('sol6').clearSolutionData;

model.label('heterogeneous_li_battery.mph');

model.modelNode.label('Components');

out = model;
