function out = model
%
% nimh_battery_1d.m
%
% Model exported on May 26 2025, 21:25 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/Battery_Design_Module/Batteries,_General');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 1);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.physics.create('batbe', 'BatteryBinaryElectrolyte', 'geom1');
model.physics('batbe').model('comp1');

model.study.create('std1');
model.study('std1').create('cdi', 'CurrentDistributionInitialization');
model.study('std1').feature('cdi').set('solnum', 'auto');
model.study('std1').feature('cdi').set('notsolnum', 'auto');
model.study('std1').feature('cdi').set('outputmap', {});
model.study('std1').feature('cdi').set('ngenAUX', '1');
model.study('std1').feature('cdi').set('goalngenAUX', '1');
model.study('std1').feature('cdi').set('ngenAUX', '1');
model.study('std1').feature('cdi').set('goalngenAUX', '1');
model.study('std1').feature('cdi').setSolveFor('/physics/batbe', true);
model.study('std1').create('time', 'Transient');
model.study('std1').feature('time').set('initialtime', '0');
model.study('std1').feature('time').set('solnum', 'auto');
model.study('std1').feature('time').set('notsolnum', 'auto');
model.study('std1').feature('time').set('outputmap', {});
model.study('std1').feature('time').setSolveFor('/physics/batbe', true);

% To import content from file, use:
% model.param.loadFile('FILENAME');
model.param.set('L_neg', '350[um]', 'Thickness, negative electrode');
model.param.set('L_sep', '250[um]', 'Thickness, separator');
model.param.set('L_pos', '843[um]', 'Thickness, positive electrode');
model.param.set('sigmas_neg', '1000[S/cm]', 'Electrical conductivity, negative electrode');
model.param.set('sigmas_pos', '25[S/cm]', 'Electrical conductivity, positive electrode');
model.param.set('eps_l_neg', '0.4', 'Electrolyte volume fraction, negative electrode');
model.param.set('eps_l_pos', '0.3', 'Electrolyte volume fraction, positive electrode');
model.param.set('alpha_a_neg', '0.25', 'Anodic transfer coefficient, negative electrode');
model.param.set('alpha_a_pos', '0.13', 'Anodic transfer coefficient, positive electrode');
model.param.set('alpha_c_neg', '0.54', 'Cathodic transfer coefficient, negative electrode');
model.param.set('alpha_c_pos', '0.074', 'Cathodic transfer coefficient, positive electrode');
model.param.set('r_neg', '1.5[um]', 'Electrode particle radius, negative electrode');
model.param.set('r_pos', '2.5e-6[m]', 'Electrode particle radius, positive electrode');
model.param.set('i0_ref_neg', '8[A/m^2]', 'Reference exchange current density, negative electrode');
model.param.set('i0_ref_pos', '1[A/m^2]', 'Reference exchange current density, positive electrode');
model.param.set('T', '298[K]', 'Operating temperature');
model.param.set('cl_init', '6.91[mol/dm^3]', 'Initial electrolyte concentration');
model.param.set('M_K', '39.1[g/mol]', 'Potassium molar mass');
model.param.set('M_OH', '17[g/mol]', 'Anion molar mass');
model.param.set('M_H2O', '18[g/mol]', 'Solvent molar mass');
model.param.set('C1', '43[mA/cm^2]', '1 h discharge current');
model.param.set('eps_s_neg', '0.5', 'Electrode volume fraction, negative electrode');
model.param.set('eps_s_pos', '0.5', 'Electrode volume fraction, positive electrode');
model.param.set('cl_ref', '6.91[mol/dm^3]', 'Electrolyte salt reference concentration');
model.param.set('c0_ref', '5e4[mol/m^3]', 'Solvent (water) reference concentration');

model.geom('geom1').create('i1', 'Interval');
model.geom('geom1').feature('i1').set('specify', 'len');
model.geom('geom1').feature('i1').setIndex('len', 'L_neg', 0);
model.geom('geom1').feature('i1').setIndex('len', 'L_sep', 1);
model.geom('geom1').feature('i1').setIndex('len', 'L_pos', 2);
model.geom('geom1').run('fin');

model.variable.create('var1');
model.variable('var1').model('comp1');

% To import content from file, use:
% model.variable('var1').loadFile('FILENAME');
model.variable('var1').set('cs_max_neg', 'mat2.elpot.cEeqref', 'Max intercalating concentration, negative electrode');
model.variable('var1').set('cs_max_pos', 'mat3.elpot.cEeqref', 'Max intercalating concentration, positive electrode');
model.variable('var1').set('cs_init_neg', '0.95*cs_max_neg', 'Initial state of charge concentration, negative electrode');
model.variable('var1').set('cs_init_pos', '0.01*cs_max_pos', 'Initial state of charge concentration, positive electrode');

model.cpl.create('intop1', 'Integration', 'geom1');
model.cpl('intop1').set('axisym', true);
model.cpl('intop1').selection.geom('geom1', 0);
model.cpl('intop1').selection.set([4]);
model.cpl('intop1').set('opname', 'PositiveCC');

model.material.create('mat1', 'Common', 'comp1');
model.material('mat1').propertyGroup('def').func.create('int1', 'Interpolation');
model.material('mat1').propertyGroup('def').func.create('int2', 'Interpolation');
model.material('mat1').propertyGroup('def').func.create('int3', 'Interpolation');
model.material('mat1').propertyGroup.create('ElectrolyteConductivity', 'Electrolyte conductivity');
model.material('mat1').propertyGroup.create('SpeciesProperties', 'Species properties');
model.material('mat1').label('KOH (Liquid)');
model.material('mat1').comments([ newline ]);
model.material('mat1').propertyGroup('def').func('int1').set('funcname', 'A_rho');
model.material('mat1').propertyGroup('def').func('int1').set('table', {'0' '-0.5031';  ...
'5' '-0.4821';  ...
'10' '-0.5026';  ...
'15' '-0.482';  ...
'20' '-0.4824';  ...
'25' '-0.4931';  ...
'30' '-0.4812';  ...
'35' '-0.4918';  ...
'40' '-0.4863';  ...
'45' '-0.4912';  ...
'50' '-0.4756';  ...
'55' '-0.4898';  ...
'60' '-0.4916';  ...
'65' '-0.4906';  ...
'70' '-0.4876';  ...
'80' '-0.4942';  ...
'90' '-0.5021';  ...
'100' '-0.501';  ...
'150' '-0.5206';  ...
'200' '-0.5538'});
model.material('mat1').propertyGroup('def').func('int1').set('fununit', {'1'});
model.material('mat1').propertyGroup('def').func('int1').set('argunit', {'1'});
model.material('mat1').propertyGroup('def').func('int2').set('funcname', 'B_rho');
model.material('mat1').propertyGroup('def').func('int2').set('table', {'0' '45.876';  ...
'5' '45.648';  ...
'10' '45.889';  ...
'15' '45.659';  ...
'20' '45.649';  ...
'25' '45.761';  ...
'30' '45.568';  ...
'35' '45.698';  ...
'40' '45.601';  ...
'45' '45.62';  ...
'50' '45.336';  ...
'55' '45.543';  ...
'60' '45.53';  ...
'65' '45.45';  ...
'70' '45.396';  ...
'80' '45.409';  ...
'90' '45.432';  ...
'100' '45.361';  ...
'150' '45.217';  ...
'200' '45.173'});
model.material('mat1').propertyGroup('def').func('int2').set('fununit', {'1'});
model.material('mat1').propertyGroup('def').func('int2').set('argunit', {'1'});
model.material('mat1').propertyGroup('def').func('int3').set('funcname', 'C_rho');
model.material('mat1').propertyGroup('def').func('int3').set('table', {'0' '1004.4';  ...
'5' '1003.8';  ...
'10' '1002.5';  ...
'15' '1002';  ...
'20' '1001';  ...
'25' '999.63';  ...
'30' '998.66';  ...
'35' '996.7';  ...
'40' '994.89';  ...
'45' '992.84';  ...
'50' '991.51';  ...
'55' '988.4';  ...
'60' '985.91';  ...
'65' '983.39';  ...
'70' '980.71';  ...
'80' '974.59';  ...
'90' '967.98';  ...
'100' '960.99';  ...
'150' '919.52';  ...
'200' '869.35'});
model.material('mat1').propertyGroup('def').func('int3').set('fununit', {'1'});
model.material('mat1').propertyGroup('def').func('int3').set('argunit', {'1'});
model.material('mat1').propertyGroup('def').set('diffusion', {'3.75e-9[m^2/s]' '0' '0' '0' '3.75e-9[m^2/s]' '0' '0' '0' '3.75e-9[m^2/s]'});
model.material('mat1').propertyGroup('def').set('INFO_PREFIX:diffusion', ['B. Paxton and J. Newman,  J. Electrochem. Soc., vol. 144, no. 11, (1997) 3818' native2unicode(hex2dec({'20' '13'}), 'unicode') '3831, ']);
model.material('mat1').propertyGroup('def').set('T_reg', 'min(max(T,0[degC]),200[degC])');
model.material('mat1').propertyGroup('def').descr('T_reg', '');
model.material('mat1').propertyGroup('def').set('M_reg', 'min(max(c,1e-6[M]),12[M])/1[M]');
model.material('mat1').propertyGroup('def').descr('M_reg', '');
model.material('mat1').propertyGroup('def').set('density', '(A_rho(T_degC)*M_reg^2+B_rho(T_degC)*M_reg+C_rho(T_degC))*1[kg/m^3]');
model.material('mat1').propertyGroup('def').set('INFO_PREFIX:density', ['R.J. Gilliama, J.W. Graydonb, D.W. Kirkb, S.J. Thorpea, Int. J. Hydrogen Energy 32 (2007) 359 ' native2unicode(hex2dec({'20' '13'}), 'unicode') ' 364']);
model.material('mat1').propertyGroup('def').set('T_degC', '(T_reg-0[degC])/1[K]');
model.material('mat1').propertyGroup('def').descr('T_degC', '');
model.material('mat1').propertyGroup('def').addInput('concentration');
model.material('mat1').propertyGroup('def').addInput('temperature');
model.material('mat1').propertyGroup('ElectrolyteConductivity').set('sigmal', {'(A*M+B*M^2+C*M*T_K+D*M/T_K+E*M^3+F*M^2*T_K^2)*1[S/cm]' '0' '0' '0' '(A*M+B*M^2+C*M*T_K+D*M/T_K+E*M^3+F*M^2*T_K^2)*1[S/cm]' '0' '0' '0' '(A*M+B*M^2+C*M*T_K+D*M/T_K+E*M^3+F*M^2*T_K^2)*1[S/cm]'});
model.material('mat1').propertyGroup('ElectrolyteConductivity').set('INFO_PREFIX:sigmal', ['R.J. Gilliama, J.W. Graydonb, D.W. Kirkb, S.J. Thorpea, Int. J. Hydrogen Energy 32 (2007) 359 ' native2unicode(hex2dec({'20' '13'}), 'unicode') ' 364']);
model.material('mat1').propertyGroup('ElectrolyteConductivity').set('T_K', 'def.T_reg/1[K]');
model.material('mat1').propertyGroup('ElectrolyteConductivity').descr('T_K', '');
model.material('mat1').propertyGroup('ElectrolyteConductivity').set('M', 'def.M_reg');
model.material('mat1').propertyGroup('ElectrolyteConductivity').descr('M', '');
model.material('mat1').propertyGroup('ElectrolyteConductivity').set('A', '-2.041');
model.material('mat1').propertyGroup('ElectrolyteConductivity').descr('A', '');
model.material('mat1').propertyGroup('ElectrolyteConductivity').set('B', '-0.0028');
model.material('mat1').propertyGroup('ElectrolyteConductivity').descr('B', '');
model.material('mat1').propertyGroup('ElectrolyteConductivity').set('C', '0.005332');
model.material('mat1').propertyGroup('ElectrolyteConductivity').descr('C', '');
model.material('mat1').propertyGroup('ElectrolyteConductivity').set('D', '207.2');
model.material('mat1').propertyGroup('ElectrolyteConductivity').descr('D', '');
model.material('mat1').propertyGroup('ElectrolyteConductivity').set('E', '0.001043');
model.material('mat1').propertyGroup('ElectrolyteConductivity').descr('E', '');
model.material('mat1').propertyGroup('ElectrolyteConductivity').set('F', '-0.0000003');
model.material('mat1').propertyGroup('ElectrolyteConductivity').descr('F', '');
model.material('mat1').propertyGroup('ElectrolyteConductivity').addInput('concentration');
model.material('mat1').propertyGroup('ElectrolyteConductivity').addInput('temperature');
model.material('mat1').propertyGroup('SpeciesProperties').set('transpNum', '0.22');
model.material('mat1').propertyGroup('SpeciesProperties').set('INFO_PREFIX:transpNum', ['B. Paxton and J. Newman,  J. Electrochem. Soc., vol. 144, no. 11, (1997) 3818' native2unicode(hex2dec({'20' '13'}), 'unicode') '3831, ']);
model.material('mat1').propertyGroup('SpeciesProperties').set('fcl', '2');
model.material('mat1').propertyGroup('SpeciesProperties').set('INFO_PREFIX:fcl', ['B. Paxton and J. Newman,  J. Electrochem. Soc., vol. 144, no. 11, (1997) 3818' native2unicode(hex2dec({'20' '13'}), 'unicode') '3831, ']);
model.material.create('mat2', 'Common', 'comp1');
model.material('mat2').propertyGroup.create('ElectrodePotential', 'Equilibrium potential');
model.material('mat2').propertyGroup('ElectrodePotential').func.create('int1', 'Interpolation');
model.material('mat2').propertyGroup.create('OperationalSOC', 'Operational electrode state of charge');
model.material('mat2').propertyGroup.create('EquilibriumConcentration', 'Equilibrium concentration');
model.material('mat2').label('HxLiN5 (Negative, NiMH Battery)');
model.material('mat2').comments([ newline ]);
model.material('mat2').propertyGroup('def').set('electricconductivity', {'1000[S/cm]' '0' '0' '0' '1000[S/cm]' '0' '0' '0' '1000[S/cm]'});
model.material('mat2').propertyGroup('def').set('diffusion', {'2e-12[m^2/s]' '0' '0' '0' '2e-12[m^2/s]' '0' '0' '0' '2e-12[m^2/s]'});
model.material('mat2').propertyGroup('def').set('INFO_PREFIX:diffusion', ['B. Paxton and J. Newman, ' native2unicode(hex2dec({'20' '1c'}), 'unicode') 'Modelling Nickel/Metal Hydride Batteries,' native2unicode(hex2dec({'20' '1d'}), 'unicode') ' J. Electrochem. Soc., vol. 144, p. 3818, 1997.']);
model.material('mat2').propertyGroup('def').set('density', '7490[kg/m^3]');
model.material('mat2').propertyGroup('def').set('INFO_PREFIX:density', ['W. B. Gu and C. Y. Wang, ' native2unicode(hex2dec({'20' '1c'}), 'unicode') 'Thermal-Electrochemical Modeling of Battery Systems,' native2unicode(hex2dec({'20' '1d'}), 'unicode') ' J. Electrochem. Soc., vol. 147, p. 2910, 2000.']);
model.material('mat2').propertyGroup('def').set('heatcapacity', '350[J/(kg*K)]');
model.material('mat2').propertyGroup('def').set('INFO_PREFIX:heatcapacity', ['W. B. Gu and C. Y. Wang, ' native2unicode(hex2dec({'20' '1c'}), 'unicode') 'Thermal-Electrochemical Modeling of Battery Systems,' native2unicode(hex2dec({'20' '1d'}), 'unicode') ' J. Electrochem. Soc., vol. 147, p. 2910, 2000.']);
model.material('mat2').propertyGroup('def').set('csmax', '0.1025e6[mol/m^3]');
model.material('mat2').propertyGroup('def').descr('csmax', '');
model.material('mat2').propertyGroup('ElectrodePotential').func('int1').set('funcname', 'Eeq_int1');
model.material('mat2').propertyGroup('ElectrodePotential').func('int1').set('table', {'0.0100' '-0.5104';  ...
'0.0200' '-0.6421';  ...
'0.0300' '-0.7304';  ...
'0.0400' '-0.7896';  ...
'0.0500' '-0.8293';  ...
'0.0600' '-0.8559';  ...
'0.0700' '-0.8737';  ...
'0.0800' '-0.8857';  ...
'0.0900' '-0.8937';  ...
'0.1000' '-0.8991';  ...
'0.1100' '-0.9027';  ...
'0.1200' '-0.9051';  ...
'0.1300' '-0.9067';  ...
'0.1400' '-0.9078';  ...
'0.1500' '-0.9085';  ...
'0.1600' '-0.9090';  ...
'0.1700' '-0.9093';  ...
'0.1800' '-0.9096';  ...
'0.1900' '-0.9097';  ...
'0.2000' '-0.9098';  ...
'0.2200' '-0.9099';  ...
'0.5000' '-0.9100';  ...
'0.7800' '-0.9101';  ...
'0.8000' '-0.9102';  ...
'0.8100' '-0.9103';  ...
'0.8200' '-0.9104';  ...
'0.8300' '-0.9107';  ...
'0.8400' '-0.9110';  ...
'0.8500' '-0.9115';  ...
'0.8600' '-0.9122';  ...
'0.8700' '-0.9133';  ...
'0.8800' '-0.9149';  ...
'0.8900' '-0.9173';  ...
'0.9000' '-0.9209';  ...
'0.9100' '-0.9263';  ...
'0.9200' '-0.9343';  ...
'0.9300' '-0.9463';  ...
'0.9400' '-0.9641';  ...
'0.9500' '-0.9907';  ...
'0.9600' '-1.0304';  ...
'0.9700' '-1.0896';  ...
'0.9800' '-1.1779';  ...
'0.9900' '-1.3096'});
model.material('mat2').propertyGroup('ElectrodePotential').func('int1').set('extrap', 'linear');
model.material('mat2').propertyGroup('ElectrodePotential').func('int1').set('fununit', {'V'});
model.material('mat2').propertyGroup('ElectrodePotential').func('int1').set('argunit', {'1'});
model.material('mat2').propertyGroup('ElectrodePotential').func('int1').set('defineinv', true);
model.material('mat2').propertyGroup('ElectrodePotential').func('int1').set('funcinvname', 'Eeq_inv');
model.material('mat2').propertyGroup('ElectrodePotential').set('Eeq', 'Eeq_int1(soc)');
model.material('mat2').propertyGroup('ElectrodePotential').set('INFO_PREFIX:Eeq', ['P. Albertus, J. Christensen, and J. Newman, ' native2unicode(hex2dec({'20' '1c'}), 'unicode') 'Modelling Side Reactions and Nonisothermal Effects in Nickel Metal-Hydride Batteries,' native2unicode(hex2dec({'20' '1d'}), 'unicode') ' J. Electrochem. Soc., vol. 155, p. A48, 2008.']);
model.material('mat2').propertyGroup('ElectrodePotential').set('dEeqdT', '-0.836e-3[V/K]');
model.material('mat2').propertyGroup('ElectrodePotential').set('INFO_PREFIX:dEeqdT', ['W. B. Gu and C. Y. Wang, ' native2unicode(hex2dec({'20' '1c'}), 'unicode') 'Thermal-Electrochemical Modeling of Battery Systems,' native2unicode(hex2dec({'20' '1d'}), 'unicode') ' J. Electrochem. Soc., vol. 147, p. 2910, 2000.']);
model.material('mat2').propertyGroup('ElectrodePotential').set('cEeqref', 'def.csmax');
model.material('mat2').propertyGroup('ElectrodePotential').set('INFO_PREFIX:cEeqref', ['P. Albertus, J. Christensen, and J. Newman, ' native2unicode(hex2dec({'20' '1c'}), 'unicode') 'Modelling Side Reactions and Nonisothermal Effects in Nickel Metal-Hydride Batteries,' native2unicode(hex2dec({'20' '1d'}), 'unicode') ' J. Electrochem. Soc., vol. 155, p. A48, 2008.']);
model.material('mat2').propertyGroup('ElectrodePotential').set('soc', 'c/cEeqref');
model.material('mat2').propertyGroup('ElectrodePotential').descr('soc', '');
model.material('mat2').propertyGroup('ElectrodePotential').addInput('concentration');
model.material('mat2').propertyGroup('OperationalSOC').set('socmax', 'elpot.Eeq_inv(E_min)');
model.material('mat2').propertyGroup('OperationalSOC').set('socmin', 'elpot.Eeq_inv(E_max)');
model.material('mat2').propertyGroup('OperationalSOC').set('E_max', '-0.6[V]');
model.material('mat2').propertyGroup('OperationalSOC').set('E_min', '-1.2[V]');
model.material('mat2').propertyGroup('EquilibriumConcentration').set('csEq', 'def.csmax*elpot.Eeq_inv(V)');
model.material('mat2').propertyGroup('EquilibriumConcentration').addInput('electricpotential');
model.material.create('mat3', 'Common', 'comp1');
model.material('mat3').propertyGroup.create('ElectrodePotential', 'Equilibrium potential');
model.material('mat3').propertyGroup('ElectrodePotential').func.create('int1', 'Interpolation');
model.material('mat3').propertyGroup.create('OperationalSOC', 'Operational electrode state of charge');
model.material('mat3').propertyGroup.create('EquilibriumConcentration', 'Equilibrium concentration');
model.material('mat3').label('NiOHO-Hx (Positive discharge, NiMH Battery)');
model.material('mat3').propertyGroup('def').set('electricconductivity', {'25[S/cm]' '0' '0' '0' '25[S/cm]' '0' '0' '0' '25[S/cm]'});
model.material('mat3').propertyGroup('def').set('diffusion', {'1e-12[m^2/s]' '0' '0' '0' '1e-12[m^2/s]' '0' '0' '0' '1e-12[m^2/s]'});
model.material('mat3').propertyGroup('def').set('INFO_PREFIX:diffusion', ['B. Paxton and J. Newman, ' native2unicode(hex2dec({'20' '1c'}), 'unicode') 'Modelling Nickel/Metal Hydride Batteries,' native2unicode(hex2dec({'20' '1d'}), 'unicode') ' J. Electrochem. Soc., vol. 144, p. 3818, 1997']);
model.material('mat3').propertyGroup('def').set('density', '3550[kg/m^3]');
model.material('mat3').propertyGroup('def').set('INFO_PREFIX:density', ['W. B. Gu and C. Y. Wang, ' native2unicode(hex2dec({'20' '1c'}), 'unicode') 'Thermal-Electrochemical Modeling of Battery Systems,' native2unicode(hex2dec({'20' '1d'}), 'unicode') ' J. Electrochem. Soc., vol. 147, p. 2910, 2000.']);
model.material('mat3').propertyGroup('def').set('heatcapacity', '880[J/(kg*K)]');
model.material('mat3').propertyGroup('def').set('INFO_PREFIX:heatcapacity', ['W. B. Gu and C. Y. Wang, ' native2unicode(hex2dec({'20' '1c'}), 'unicode') 'Thermal-Electrochemical Modeling of Battery Systems,' native2unicode(hex2dec({'20' '1d'}), 'unicode') ' J. Electrochem. Soc., vol. 147, p. 2910, 2000.']);
model.material('mat3').propertyGroup('def').set('csmax', '0.0383[mol/cm^3]');
model.material('mat3').propertyGroup('def').descr('csmax', '');
model.material('mat3').propertyGroup('ElectrodePotential').func('int1').set('funcname', 'Eeq_int1');
model.material('mat3').propertyGroup('ElectrodePotential').func('int1').set('table', {'0.0100' '0.1710';  ...
'0.0200' '0.2199';  ...
'0.0300' '0.2499';  ...
'0.0400' '0.2695';  ...
'0.0500' '0.2827';  ...
'0.0600' '0.2921';  ...
'0.0700' '0.2992';  ...
'0.0800' '0.3047';  ...
'0.0900' '0.3092';  ...
'0.1000' '0.3131';  ...
'0.1100' '0.3166';  ...
'0.1200' '0.3197';  ...
'0.1300' '0.3227';  ...
'0.1400' '0.3255';  ...
'0.1500' '0.3282';  ...
'0.1600' '0.3309';  ...
'0.1700' '0.3335';  ...
'0.1800' '0.3360';  ...
'0.1900' '0.3385';  ...
'0.2000' '0.3410';  ...
'0.2100' '0.3434';  ...
'0.2200' '0.3458';  ...
'0.2300' '0.3482';  ...
'0.2400' '0.3506';  ...
'0.2500' '0.3529';  ...
'0.2600' '0.3552';  ...
'0.2700' '0.3574';  ...
'0.2800' '0.3595';  ...
'0.2900' '0.3615';  ...
'0.3000' '0.3635';  ...
'0.3100' '0.3654';  ...
'0.3200' '0.3671';  ...
'0.3300' '0.3687';  ...
'0.3400' '0.3702';  ...
'0.3500' '0.3716';  ...
'0.3600' '0.3728';  ...
'0.3700' '0.3739';  ...
'0.3800' '0.3749';  ...
'0.3900' '0.3758';  ...
'0.4000' '0.3766';  ...
'0.4100' '0.3773';  ...
'0.4200' '0.3780';  ...
'0.4300' '0.3786';  ...
'0.4400' '0.3791';  ...
'0.4500' '0.3796';  ...
'0.4600' '0.3802';  ...
'0.4700' '0.3807';  ...
'0.4800' '0.3812';  ...
'0.4900' '0.3818';  ...
'0.5000' '0.3824';  ...
'0.5100' '0.3830';  ...
'0.5200' '0.3836';  ...
'0.5300' '0.3843';  ...
'0.5400' '0.3850';  ...
'0.5500' '0.3858';  ...
'0.5600' '0.3865';  ...
'0.5700' '0.3873';  ...
'0.5800' '0.3882';  ...
'0.5900' '0.3890';  ...
'0.6000' '0.3899';  ...
'0.6100' '0.3908';  ...
'0.6200' '0.3918';  ...
'0.6300' '0.3927';  ...
'0.6400' '0.3936';  ...
'0.6500' '0.3946';  ...
'0.6600' '0.3956';  ...
'0.6700' '0.3966';  ...
'0.6800' '0.3976';  ...
'0.6900' '0.3986';  ...
'0.7000' '0.3996';  ...
'0.7100' '0.4007';  ...
'0.7200' '0.4018';  ...
'0.7300' '0.4029';  ...
'0.7400' '0.4040';  ...
'0.7500' '0.4051';  ...
'0.7600' '0.4063';  ...
'0.7700' '0.4076';  ...
'0.7800' '0.4089';  ...
'0.7900' '0.4103';  ...
'0.8000' '0.4117';  ...
'0.8100' '0.4132';  ...
'0.8200' '0.4149';  ...
'0.8300' '0.4167';  ...
'0.8400' '0.4186';  ...
'0.8500' '0.4207';  ...
'0.8600' '0.4231';  ...
'0.8700' '0.4257';  ...
'0.8800' '0.4287';  ...
'0.8900' '0.4320';  ...
'0.9000' '0.4359';  ...
'0.9100' '0.4404';  ...
'0.9200' '0.4456';  ...
'0.9300' '0.4517';  ...
'0.9400' '0.4589';  ...
'0.9500' '0.4676';  ...
'0.9600' '0.4781';  ...
'0.9700' '0.4911';  ...
'0.9800' '0.5079';  ...
'0.9900' '0.5314'});
model.material('mat3').propertyGroup('ElectrodePotential').func('int1').set('extrap', 'linear');
model.material('mat3').propertyGroup('ElectrodePotential').func('int1').set('fununit', {'V'});
model.material('mat3').propertyGroup('ElectrodePotential').func('int1').set('argunit', {''});
model.material('mat3').propertyGroup('ElectrodePotential').func('int1').set('defineinv', true);
model.material('mat3').propertyGroup('ElectrodePotential').func('int1').set('funcinvname', 'Eeq_inv');
model.material('mat3').propertyGroup('ElectrodePotential').set('Eeq', 'Eeq_int1(1-soc)');
model.material('mat3').propertyGroup('ElectrodePotential').set('INFO_PREFIX:Eeq', ['P. Albertus, J. Christensen, and J. Newman, ' native2unicode(hex2dec({'20' '1c'}), 'unicode') 'Modelling Side Reactions and Nonisothermal Effects in Nickel Metal-Hydride Batteries,' native2unicode(hex2dec({'20' '1d'}), 'unicode') ' J. Electrochem. Soc., vol. 155, p. A48, 2008.']);
model.material('mat3').propertyGroup('ElectrodePotential').set('dEeqdT', '-1.35e-3[V/K]');
model.material('mat3').propertyGroup('ElectrodePotential').set('INFO_PREFIX:dEeqdT', ['W. B. Gu and C. Y. Wang, ' native2unicode(hex2dec({'20' '1c'}), 'unicode') 'Thermal-Electrochemical Modeling of Battery Systems,' native2unicode(hex2dec({'20' '1d'}), 'unicode') ' J. Electrochem. Soc., vol. 147, p. 2910, 2000.']);
model.material('mat3').propertyGroup('ElectrodePotential').set('cEeqref', 'def.csmax');
model.material('mat3').propertyGroup('ElectrodePotential').set('INFO_PREFIX:cEeqref', ['P. Albertus, J. Christensen, and J. Newman, ' native2unicode(hex2dec({'20' '1c'}), 'unicode') 'Modelling Side Reactions and Nonisothermal Effects in Nickel Metal-Hydride Batteries,' native2unicode(hex2dec({'20' '1d'}), 'unicode') ' J. Electrochem. Soc., vol. 155, p. A48, 2008.']);
model.material('mat3').propertyGroup('ElectrodePotential').set('soc', 'c/cEeqref');
model.material('mat3').propertyGroup('ElectrodePotential').descr('soc', '');
model.material('mat3').propertyGroup('ElectrodePotential').addInput('concentration');
model.material('mat3').propertyGroup('OperationalSOC').set('socmax', 'elpot.Eeq_inv(E_min)');
model.material('mat3').propertyGroup('OperationalSOC').set('socmin', 'elpot.Eeq_inv(E_max)');
model.material('mat3').propertyGroup('OperationalSOC').set('E_max', '0.53[V]');
model.material('mat3').propertyGroup('OperationalSOC').set('E_min', '0.18[V]');
model.material('mat3').propertyGroup('EquilibriumConcentration').set('csEq', 'def.csmax*elpot.Eeq_inv(V)');
model.material('mat3').propertyGroup('EquilibriumConcentration').addInput('electricpotential');

model.physics('batbe').prop('BatBeSpecies').set('ManMinus', 'M_OH');
model.physics('batbe').prop('BatBeSpecies').set('McatPlus', 'M_K');
model.physics('batbe').prop('BatBeSpecies').set('M0', 'M_H2O');
model.physics('batbe').feature('sep1').set('epsl', 1);
model.physics('batbe').create('pce1', 'PorousElectrode', 1);
model.physics('batbe').feature('pce1').selection.set([1]);
model.physics('batbe').feature('pce1').set('sigma', {'sigmas_neg' '0' '0' '0' 'sigmas_neg' '0' '0' '0' 'sigmas_neg'});
model.physics('batbe').feature('pce1').set('epss', 'eps_s_neg');
model.physics('batbe').feature('pce1').set('epsl', 'eps_l_neg');
model.physics('batbe').feature('pce1').feature('pin1').set('ParticleMaterial', 'mat2');
model.physics('batbe').feature('pce1').feature('pin1').set('csinit', 'cs_init_neg');
model.physics('batbe').feature('pce1').feature('pin1').set('rp', 'r_neg');
model.physics('batbe').feature('pce1').feature('per1').set('MaterialOption', 'mat2');
model.physics('batbe').feature('pce1').feature('per1').set('i0_ref', 'i0_ref_neg');
model.physics('batbe').feature('pce1').feature('per1').set('alphaa', 'alpha_a_neg');
model.physics('batbe').feature('pce1').feature('per1').set('alphac', 'alpha_c_neg');
model.physics('batbe').feature('pce1').feature('per1').set('cl_ref', 'cl_ref');
model.physics('batbe').feature('pce1').feature('per1').set('c0_ref', 'c0_ref');
model.physics('batbe').create('pce2', 'PorousElectrode', 1);
model.physics('batbe').feature('pce2').selection.set([3]);
model.physics('batbe').feature('pce2').set('sigma', {'sigmas_pos' '0' '0' '0' 'sigmas_pos' '0' '0' '0' 'sigmas_pos'});
model.physics('batbe').feature('pce2').set('epss', 'eps_s_pos');
model.physics('batbe').feature('pce2').set('epsl', 'eps_l_pos');
model.physics('batbe').feature('pce2').feature('pin1').set('ParticleMaterial', 'mat3');
model.physics('batbe').feature('pce2').feature('pin1').set('csinit', 'cs_init_pos');
model.physics('batbe').feature('pce2').feature('pin1').set('rp', 'r_pos');
model.physics('batbe').feature('pce2').feature('per1').set('MaterialOption', 'mat3');
model.physics('batbe').feature('pce2').feature('per1').set('i0_ref', 'i0_ref_pos');
model.physics('batbe').feature('pce2').feature('per1').set('alphaa', 'alpha_a_pos');
model.physics('batbe').feature('pce2').feature('per1').set('alphac', 'alpha_c_pos');
model.physics('batbe').feature('pce2').feature('per1').set('cl_ref', 'cl_ref');
model.physics('batbe').feature('pce2').feature('per1').set('c0_ref', 'c0_ref');
model.physics('batbe').create('egnd1', 'ElectricGround', 0);
model.physics('batbe').feature('egnd1').selection.set([1]);
model.physics('batbe').create('ecd1', 'ElectrodeNormalCurrentDensity', 0);
model.physics('batbe').feature('ecd1').selection.set([4]);
model.physics('batbe').feature('ecd1').set('nis', '-C1/10');
model.physics('batbe').feature('init1').set('cl', 'cl_init');

model.common('cminpt').set('modified', {'temperature' 'T'});

model.study('std1').feature('time').set('tlist', 'range(0,600,36000)');

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
model.sol('sol1').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('s1').feature('fc1').set('dtech', 'auto');
model.sol('sol1').feature('s1').feature('fc1').set('maxiter', 50);
model.sol('sol1').feature('s1').feature('fc1').set('minstep', 1.0E-6);
model.sol('sol1').feature('s1').create('d1', 'Direct');
model.sol('sol1').feature('s1').feature('d1').set('linsolver', 'pardiso');
model.sol('sol1').feature('s1').feature('d1').label('Direct (batbe)');
model.sol('sol1').feature('s1').create('i1', 'Iterative');
model.sol('sol1').feature('s1').feature('i1').set('maxlinit', 1000);
model.sol('sol1').feature('s1').feature('i1').set('nlinnormuse', 'on');
model.sol('sol1').feature('s1').feature('i1').label('Algebraic Multigrid (batbe)');
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
model.sol('sol1').feature('s1').feature('i2').label('Geometric Multigrid (batbe)');
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
model.sol('sol1').feature('v2').feature('comp1_batbe_pce1_cs').set('scalemethod', 'manual');
model.sol('sol1').feature('v2').feature('comp1_batbe_pce2_cs').set('scalemethod', 'manual');
model.sol('sol1').feature('v2').feature('comp1_phis').set('scalemethod', 'manual');
model.sol('sol1').feature('v2').feature('comp1_cl').set('scalemethod', 'manual');
model.sol('sol1').feature('v2').feature('comp1_phil').set('scaleval', '1');
model.sol('sol1').feature('v2').feature('comp1_batbe_pce1_cs').set('scaleval', '10000');
model.sol('sol1').feature('v2').feature('comp1_batbe_pce2_cs').set('scaleval', '10000');
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
model.sol('sol1').feature('t1').set('tlist', 'range(0,600,36000)');
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
model.sol('sol1').feature('t1').feature('d1').label('Direct (batbe)');
model.sol('sol1').feature('t1').create('i1', 'Iterative');
model.sol('sol1').feature('t1').feature('i1').set('maxlinit', 1000);
model.sol('sol1').feature('t1').feature('i1').set('nlinnormuse', 'on');
model.sol('sol1').feature('t1').feature('i1').label('Algebraic Multigrid (batbe)');
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
model.sol('sol1').feature('t1').feature('i2').label('Geometric Multigrid (batbe)');
model.sol('sol1').feature('t1').feature('i2').create('mg1', 'Multigrid');
model.sol('sol1').feature('t1').feature('i2').feature('mg1').feature('pr').create('sl1', 'SORLine');
model.sol('sol1').feature('t1').feature('i2').feature('mg1').feature('po').create('sl1', 'SORLine');
model.sol('sol1').feature('t1').feature('i2').feature('mg1').feature('cs').create('d1', 'Direct');
model.sol('sol1').feature('t1').feature('i2').feature('mg1').feature('cs').feature('d1').set('linsolver', 'pardiso');
model.sol('sol1').feature('t1').feature('fc1').set('linsolver', 'd1');
model.sol('sol1').feature('t1').feature('fc1').set('dtech', 'auto');
model.sol('sol1').feature('t1').feature.remove('fcDef');
model.sol('sol1').attach('std1');
model.sol('sol1').feature('t1').create('st1', 'StopCondition');
model.sol('sol1').feature('t1').feature('st1').setIndex('stopcondarr', '', 0);
model.sol('sol1').feature('t1').feature('st1').setIndex('stopcondterminateon', 'true', 0);
model.sol('sol1').feature('t1').feature('st1').setIndex('stopcondActive', true, 0);
model.sol('sol1').feature('t1').feature('st1').setIndex('stopconddesc', 'Stop expression 1', 0);
model.sol('sol1').feature('t1').feature('st1').setIndex('stopcondarr', '', 0);
model.sol('sol1').feature('t1').feature('st1').setIndex('stopcondterminateon', 'true', 0);
model.sol('sol1').feature('t1').feature('st1').setIndex('stopcondActive', true, 0);
model.sol('sol1').feature('t1').feature('st1').setIndex('stopconddesc', 'Stop expression 1', 0);
model.sol('sol1').feature('t1').feature('st1').setIndex('stopcondarr', 'comp1.PositiveCC(comp1.phis)<0.99', 0);
model.sol('sol1').feature('t1').feature('st1').set('storestopcondsol', 'stepbefore_stepafter');
model.sol('sol1').feature('t1').feature('st1').set('stopcondwarn', false);
model.sol('sol1').runAll;

model.result.create('pg1', 'PlotGroup1D');
model.result('pg1').set('data', 'dset1');
model.result('pg1').create('ptgr1', 'PointGraph');
model.result('pg1').feature('ptgr1').selection.all;
model.result('pg1').feature('ptgr1').set('expr', {'phis'});
model.result('pg1').feature('ptgr1').selection.set([4]);
model.result('pg1').label('Boundary Electrode Potential with Respect to Ground (batbe)');
model.result('pg1').feature('ptgr1').set('xdatasolnumtype', 'level1');
model.result.create('pg2', 'PlotGroup1D');
model.result('pg2').set('data', 'dset1');
model.result('pg2').create('glob1', 'Global');
model.result('pg2').feature('glob1').set('unit', {'' ''});
model.result('pg2').feature('glob1').set('expr', {'batbe.soc_average_pce1' 'batbe.soc_average_pce2'});
model.result('pg2').feature('glob1').set('descr', {'Average SOC, Porous Electrode 1' 'Average SOC, Porous Electrode 2'});
model.result('pg2').label('Average Electrode State of Charge (batbe)');
model.result('pg2').feature('glob1').set('xdatasolnumtype', 'level1');
model.result.create('pg3', 'PlotGroup1D');
model.result('pg3').set('data', 'dset1');
model.result('pg3').label('Electrolyte Potential (batbe)');
model.result('pg3').create('lngr1', 'LineGraph');
model.result('pg3').feature('lngr1').set('xdata', 'expr');
model.result('pg3').feature('lngr1').set('xdataexpr', 'x');
model.result('pg3').feature('lngr1').selection.geom('geom1', 1);
model.result('pg3').feature('lngr1').selection.set([1 2 3]);
model.result('pg3').feature('lngr1').set('expr', {'phil'});
model.result.create('pg4', 'PlotGroup1D');
model.result('pg4').set('data', 'dset1');
model.result('pg4').label('Electrode Potential with Respect to Ground (batbe)');
model.result('pg4').create('lngr1', 'LineGraph');
model.result('pg4').feature('lngr1').set('xdata', 'expr');
model.result('pg4').feature('lngr1').set('xdataexpr', 'x');
model.result('pg4').feature('lngr1').selection.geom('geom1', 1);
model.result('pg4').feature('lngr1').selection.set([1 2 3]);
model.result('pg4').feature('lngr1').set('expr', {'phis'});
model.result.create('pg5', 'PlotGroup1D');
model.result('pg5').set('data', 'dset1');
model.result('pg5').create('lngr1', 'LineGraph');
model.result('pg5').feature('lngr1').set('xdata', 'expr');
model.result('pg5').feature('lngr1').set('xdataexpr', 'x');
model.result('pg5').feature('lngr1').selection.geom('geom1', 1);
model.result('pg5').feature('lngr1').selection.set([1 2 3]);
model.result('pg5').feature('lngr1').set('expr', {'cl'});
model.result('pg5').label('Electrolyte Salt Concentration (batbe)');
model.result('pg1').run;
model.result('pg1').label('Cell voltage');
model.result('pg1').set('titletype', 'manual');
model.result('pg1').set('title', 'Cell voltages for different discharge rates');
model.result('pg1').set('xlabelactive', true);
model.result('pg1').set('xlabel', 'Utilization');
model.result('pg1').set('ylabelactive', true);
model.result('pg1').set('ylabel', 'Cell voltage (V)');
model.result('pg1').run;
model.result('pg1').feature('ptgr1').set('xdata', 'expr');
model.result('pg1').feature('ptgr1').set('xdataexpr', 't/36000');
model.result('pg1').feature('ptgr1').set('legend', true);
model.result('pg1').feature('ptgr1').set('legendmethod', 'manual');
model.result('pg1').feature('ptgr1').setIndex('legends', 'C/10', 0);

model.physics('batbe').feature('ecd1').set('nis', '-C1');

model.sol('sol1').copySolution('sol3');

model.study('std1').feature('time').set('tlist', 'range(0,60,3600)');

model.sol('sol1').runAll;

model.result('pg1').run;
model.result('pg1').run;
model.result('pg1').feature.duplicate('ptgr2', 'ptgr1');
model.result('pg1').run;
model.result('pg1').run;
model.result('pg1').feature('ptgr1').set('xdataexpr', 't/3600');
model.result('pg1').feature('ptgr1').setIndex('legends', '1C', 0);
model.result('pg1').run;
model.result('pg1').feature('ptgr2').set('data', 'dset3');
model.result('pg1').run;
model.result('pg2').run;
model.result('pg2').set('titletype', 'label');
model.result('pg2').run;
model.result.create('pg6', 'PlotGroup1D');
model.result('pg6').run;
model.result('pg6').setIndex('looplevelinput', 'manual', 0);
model.result('pg6').setIndex('looplevel', [11], 0);
model.result('pg6').set('titletype', 'manual');
model.result('pg6').set('title', 'Comparison of voltage losses at t=600 s');
model.result('pg6').set('xlabelactive', true);
model.result('pg6').set('xlabel', 'x (m)');
model.result('pg6').set('ylabelactive', true);
model.result('pg6').set('ylabel', 'Voltage (V)');
model.result('pg6').create('lngr1', 'LineGraph');
model.result('pg6').feature('lngr1').set('markerpos', 'datapoints');
model.result('pg6').feature('lngr1').set('linewidth', 'preference');
model.result('pg6').feature('lngr1').selection.all;
model.result('pg6').feature('lngr1').set('legend', true);
model.result('pg6').feature('lngr1').set('legendmethod', 'manual');
model.result('pg6').feature('lngr1').setIndex('legends', 'Electrolyte potential -0.91 V', 0);
model.result('pg6').feature('lngr1').set('expr', 'phil-0.91');
model.result('pg6').run;
model.result('pg6').create('lngr2', 'LineGraph');
model.result('pg6').feature('lngr2').set('markerpos', 'datapoints');
model.result('pg6').feature('lngr2').set('linewidth', 'preference');
model.result('pg6').feature('lngr2').selection.all;
model.result('pg6').feature('lngr2').set('expr', 'batbe.eta_per1');
model.result('pg6').feature('lngr2').set('legend', true);
model.result('pg6').feature('lngr2').set('legendmethod', 'manual');
model.result('pg6').feature('lngr2').setIndex('legends', 'Overpotential', 0);
model.result('pg6').run;
model.result('pg6').run;
model.result('pg6').label('Voltage losses');
model.result('pg5').run;
model.result('pg5').setIndex('looplevelinput', 'manual', 0);
model.result('pg5').setIndex('looplevel', [1 2 11 51], 0);
model.result('pg5').set('titletype', 'manual');
model.result('pg5').set('title', 'Electrolyte salt concentration profile at various times');
model.result('pg5').set('xlabelactive', true);
model.result('pg5').set('xlabel', 'x (m)');
model.result('pg5').run;
model.result('pg5').feature('lngr1').set('legend', true);
model.result('pg5').run;
model.result.create('pg7', 'PlotGroup1D');
model.result('pg7').run;
model.result('pg7').setIndex('looplevelinput', 'manual', 0);
model.result('pg7').setIndex('looplevel', [2 11 51], 0);
model.result('pg7').set('titletype', 'manual');
model.result('pg7').set('title', 'Electrochemical current source at various times');
model.result('pg7').set('xlabelactive', true);
model.result('pg7').set('xlabel', 'x (m)');
model.result('pg7').set('ylabelactive', true);
model.result('pg7').set('ylabel', 'Current source (A/m<sup>3</sup>)');
model.result('pg7').create('lngr1', 'LineGraph');
model.result('pg7').feature('lngr1').set('markerpos', 'datapoints');
model.result('pg7').feature('lngr1').set('linewidth', 'preference');
model.result('pg7').feature('lngr1').selection.all;
model.result('pg7').feature('lngr1').set('expr', 'batbe.iv_per1');
model.result('pg7').feature('lngr1').set('legend', true);
model.result('pg7').run;
model.result('pg7').run;
model.result('pg7').label('Current source');
model.result.create('pg8', 'PlotGroup1D');
model.result('pg8').run;
model.result('pg8').setIndex('looplevelinput', 'manual', 0);
model.result('pg8').setIndex('looplevel', [2 11 51], 0);
model.result('pg8').set('titletype', 'manual');
model.result('pg8').set('title', 'Intercalating species concentration in electrode particles, solid=surface, dashed=center');
model.result('pg8').set('xlabelactive', true);
model.result('pg8').set('xlabel', 'x (m)');
model.result('pg8').set('ylabelactive', true);
model.result('pg8').set('ylabel', 'Concentration (mol/m<sup>3</sup>)');
model.result('pg8').create('lngr1', 'LineGraph');
model.result('pg8').feature('lngr1').set('markerpos', 'datapoints');
model.result('pg8').feature('lngr1').set('linewidth', 'preference');
model.result('pg8').feature('lngr1').selection.all;
model.result('pg8').feature('lngr1').set('expr', 'batbe.cs_surface');
model.result('pg8').feature('lngr1').set('descr', 'Insertion particle concentration, surface');
model.result('pg8').feature('lngr1').set('legend', true);
model.result('pg8').run;
model.result('pg8').create('lngr2', 'LineGraph');
model.result('pg8').feature('lngr2').set('markerpos', 'datapoints');
model.result('pg8').feature('lngr2').set('linewidth', 'preference');
model.result('pg8').feature('lngr2').selection.all;
model.result('pg8').feature('lngr2').set('expr', 'batbe.cs_center');
model.result('pg8').feature('lngr2').set('descr', 'Insertion particle concentration, center');
model.result('pg8').feature('lngr2').set('linestyle', 'dashed');
model.result('pg8').run;
model.result('pg8').run;
model.result('pg8').label('Concentration in solid phase');
model.result('pg8').run;

model.title(['1D Isothermal Nickel' native2unicode(hex2dec({'20' '13'}), 'unicode') 'Metal Hydride Battery']);

model.description(['This example uses the Battery with Binary Electrolyte interface for studying the discharge of a nickel' native2unicode(hex2dec({'20' '13'}), 'unicode') 'metal hydride battery. The geometry is in one dimension and the model is isothermal.']);

model.mesh.clearMeshes;

model.sol('sol1').clearSolutionData;
model.sol('sol2').clearSolutionData;
model.sol('sol3').clearSolutionData;

model.label('nimh_battery_1d.mph');

model.modelNode.label('Components');

out = model;
