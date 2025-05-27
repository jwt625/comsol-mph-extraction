function out = model
%
% nicd_battery_1d.m
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

model.param.label('General');

% To import content from file, use:
% model.param.loadFile('FILENAME');
model.param.set('T', '298.15[K]', 'Temperature');
model.param.set('Q_max', '74.16[C/cm^2]', 'Total battery capacity');
model.param.set('l_pos', '0.036[cm]', 'Thickness, positive electrode');
model.param.set('l_sep', '0.025[cm]', 'Thickness, separator');
model.param.set('l_neg', '0.040[cm]', 'Thickness, negative electrode');
model.param.set('y_positive_active', '1.4*10^-4[cm]', 'Active layer thickness, positive electrode');
model.param.set('y_positive_substrate', '1.5*10^-4[cm]', 'Substrate thickness, positive electrode');
model.param.set('y_positive_total', 'y_positive_active+y_positive_substrate', 'Total thickness, positive electrode');
model.param.set('cl_init', '7.1*10^-3[mol/cm^3]', 'Initial electrolyte concentration');
model.param.set('I1C', 'Q_max/3600[s]', '1C current density');
model.param.set('sigma_electrode', '100[S/cm]', 'Effective conductivity of solid material in Cd (negative) and Ni (positive) electrodes');
model.param.set('D_O2', '10^-3[cm^2/s]', 'Effective diffusion coefficient, O2 (gas and liquid phase)');
model.param.set('c_O2_init', '10^-20[mol/cm^3]', 'Initial concentration of O2 (both charge and discharge)');
model.param.set('P_O2_ref', '1[atm]', 'Oxygen reference pressure');
model.param.set('epsilon_2', '0.68', 'Porosity of the separator');
model.param.set('gamma_2', '1.5', 'Tortuosity factor, separator');
model.param.set('i_app', 'C_rate*I1C', 'Charge/discharge current');
model.param.set('t_charge_limit', '1.2[h]/C_rate', 'Cutoff time for charge/discharge');
model.param.create('par2');
model.param('par2').label('Cd Electrode');

% To import content from file, use:
% model.param('par2').loadFile('FILENAME');
model.param('par2').set('rho_Cd', '8.64[g/cm^3]', 'Density of Cd');
model.param('par2').set('rho_CdO2H2', '4.79[g/cm^3]', 'Density of Cd(OH)2');
model.param('par2').set('M_Cd', '112.4[g/mol]', 'Molar mass, Cd');
model.param('par2').set('a_Cd', '4000[cm^2/cm^3]', 'Specific active surface area, Cd (negative) electrode');
model.param('par2').set('M_CdO2H2', '146.4[g/mol]', 'Molar mass, Cd(OH)2');
model.param('par2').set('L_neg', '2.3[g/cm^3]', 'Loading of Cd(OH)2 in negative electrode');
model.param('par2').set('epsilon0_N', '0.80', 'Porosity of the Cd substrate in the negative electrode');
model.param('par2').set('epsilon_3_max', 'epsilon0_N*(1-L_neg/rho_Cd*M_Cd/M_CdO2H2)', 'Porosity of the negative electrode, fully charged');
model.param('par2').set('epsilon_3_min', 'epsilon0_N*(1-L_neg/rho_CdO2H2)', 'Porosity of the negative electrode, fully discharged');
model.param.create('par3');
model.param('par3').label('Ni Electrode');

% To import content from file, use:
% model.param('par3').loadFile('FILENAME');
model.param('par3').set('a_Ni', '3864[cm^2/cm^3]', 'Specific active surface area, Ni (positive) electrode');
model.param('par3').set('M_NiO2H2', '92.71[g/mol]', 'Molar mass, Ni(OH)2');
model.param('par3').set('epsilon0_P', '0.85', 'Porosity of the Ni substrate in the positive electrode');
model.param('par3').set('rho_NiO2H2', '4.83[g/cm^3]', 'Density of Ni(OH)2');
model.param('par3').set('c_H_max', 'rho_NiO2H2/M_NiO2H2', 'Maximum proton concentration');
model.param('par3').set('c_H_ref', '0.5*c_H_max', 'Reference proton concentration in the active material');
model.param('par3').set('D_H', '4.6*10^-11[cm^2/s]', 'Diffusivity of H in positive electrode');
model.param('par3').set('epss', 'Q_max/(F_const*c_H_max*l_pos)', 'Ni electrode solid volume fraction');
model.param.create('par4');
model.param('par4').label('Electrode Reactions');

% To import content from file, use:
% model.param('par4').loadFile('FILENAME');
model.param('par4').set('E_ref_pos', '0.427[V]-R_const*T/F_const*log(c_H_ref/(c_H_max-c_H_ref))', 'Reference electrode potential, positive electrode reaction');
model.param('par4').set('E_ref_OER', '0.401[V]-E_RE+R_const*T/(4*F_const)*log(P_O2_ref/1[atm])', 'Reference electrode potential, ORR/OER');
model.param('par4').set('E_ref_neg', '-0.808[V]-E_RE', 'Reference electrode potential, negative electrode reaction');
model.param('par4').set('E_RE', '0.0983[V]', 'Reference electrode (Hg/HgO) potential');
model.param('par4').set('alpha_a_1', '0.5', 'Anodic transfer coefficient, NiOOH <=> Ni(OH)2 reaction');
model.param('par4').set('alpha_a_2', '1.5', 'Anodic transfer coefficient, OER/ORR, positive electrode');
model.param('par4').set('alpha_a_3', '1', 'Anodic transfer coefficient, Cd <=> Cd(OH)2 reaction');
model.param('par4').set('alpha_a_4', 'alpha_a_2', 'Anodic transfer coefficient, OER/ORR, negative electrode');
model.param('par4').set('i0_1_ref', '6.1*10^-5[A/cm^2]', 'Exchange current density, NiOOH <=> Ni(OH)2 reaction');
model.param('par4').set('i0_2_ref', '1*10^-11[A/cm^2]', 'Exchange current density, OER/ORR, positive electrode');
model.param('par4').set('i0_3_ref', 'i0_1_ref', 'Exchange current density, Cd <=> Cd(OH)2 reaction');
model.param('par4').set('c_ref', '7.1*10^-3[mol/cm^3]', 'Reference concentration of the binary electrolyte');
model.param('par4').set('c_O2_ref', '10^-7[mol/cm^3]', 'Solubility of oxygen in 35 wt% KOH solution w. 1 atm pressure of O2 in gas phase.');
model.param.create('par5');
model.param('par5').label('Charge/Discharge Cases');
model.param('par5').set('c_H_init', 'c_H_max/500');
model.param('par5').descr('c_H_init', 'Initial H concentration in positive electrode');
model.param('par5').set('epsilon_3_init', 'epsilon_3_max');
model.param('par5').descr('epsilon_3_init', 'Initial porosity of the negative electrode');
model.param('par5').set('sign', '-1');
model.param('par5').descr('sign', 'Sign of applied current, 1 for charge, -1 for discharge');
model.param('par5').paramCase.create('case1');
model.param('par5').paramCase('case1').label('Discharge');
model.param('par5').paramCase.create('case2');
model.param('par5').paramCase('case2').label('Charge');
model.param('par5').paramCase('case2').set('c_H_init', 'c_H_max');
model.param('par5').paramCase('case2').set('epsilon_3_init', 'epsilon_3_min+0.05');
model.param('par5').paramCase('case2').set('sign', '1');
model.param.create('par6');
model.param('par6').label('C-rate Cases');
model.param('par6').set('C_rate', '1');
model.param('par6').descr('C_rate', 'Charge/discharge rate');
model.param('par6').paramCase.create('case1');
model.param('par6').paramCase('case1').set('C_rate', '1/10');
model.param('par6').paramCase.create('case2');
model.param('par6').paramCase('case2').set('C_rate', '1/2.1');
model.param('par6').paramCase.create('case3');
model.param('par6').paramCase('case3').set('C_rate', '1/0.7');

model.modelNode.create('xdim1', 'ExtraDim');

model.geom.create('geom2', 1);
model.geom('geom2').model('comp1');
model.geom('geom2').axisymmetric(true);
model.geom('geom2').model('xdim1');

model.mesh.create('mesh2', 'geom2');

model.extraDim.create('pa1', 'PointsToAttach');
model.extraDim('pa1').model('xdim1');

model.modelNode('xdim1').label('Extra Dimension: Positive Electrode');
model.modelNode('xdim1').spatialCoord({'rxd' 'phi1' 'z1'});

model.geom('geom2').create('i1', 'Interval');
model.geom('geom2').feature('i1').set('specify', 'len');
model.geom('geom2').feature('i1').set('left', 'y_positive_substrate');
model.geom('geom2').feature('i1').setIndex('len', 'y_positive_active', 0);
model.geom('geom2').run('i1');

model.extraDim.create('xdintop1', 'Integration');
model.extraDim('xdintop1').model('xdim1');

model.geom('geom2').run;

model.extraDim('xdintop1').label('Extra Dimension Surface Integral');
model.extraDim('xdintop1').set('opname', 'xdsurfop');
model.extraDim('xdintop1').selection.geom('geom2', 0);
model.extraDim('xdintop1').selection.set([2]);
model.extraDim('xdintop1').set('axisym', false);
model.extraDim.create('xdintop2', 'Integration');
model.extraDim('xdintop2').model('xdim1');
model.extraDim('xdintop2').label('Extra Dimension Domain Integral');
model.extraDim('xdintop2').set('opname', 'xdintopDomain');
model.extraDim('xdintop2').selection.set([1]);
model.extraDim('xdintop2').set('axisym', false);

model.mesh('mesh2').automatic(false);
model.mesh('mesh2').create('dis1', 'Distribution');
model.mesh('mesh2').feature.move('dis1', 1);
model.mesh('mesh2').feature('dis1').selection.set([1]);
model.mesh('mesh2').feature('dis1').set('type', 'predefined');
model.mesh('mesh2').feature('dis1').set('elemcount', 31);
model.mesh('mesh2').feature('dis1').set('elemratio', 0.1);
model.mesh('mesh2').run;

model.geom('geom1').create('i1', 'Interval');
model.geom('geom1').feature('i1').set('specify', 'len');
model.geom('geom1').feature('i1').setIndex('len', 'l_neg', 0);
model.geom('geom1').feature('i1').setIndex('len', 'l_sep', 1);
model.geom('geom1').feature('i1').setIndex('len', 'l_pos', 2);
model.geom('geom1').runPre('fin');

model.extraDim.create('ad1', 'AttachDimensions');
model.extraDim('ad1').model('comp1');

model.geom('geom1').run;

model.extraDim('ad1').selection.geom('geom1', 1);
model.extraDim('ad1').selection.geom('geom1', 1);
model.extraDim('ad1').selection.set([3]);
model.extraDim('ad1').set('extradim', {'xdim1'});

model.variable.create('var1');
model.variable('var1').model('comp1');
model.variable('var1').label('Negative Electrode');
model.variable('var1').selection.geom('geom1', 1);
model.variable('var1').selection.set([1]);
model.variable('var1').set('theta_N', '(batbe.epsl-epsilon_3_min)/(epsilon_3_max-epsilon_3_min)');
model.variable('var1').descr('theta_N', 'SOC, negative electrode');
model.variable.create('var2');
model.variable('var2').model('comp1');
model.variable('var2').label('Positive Electrode (Intraparticle)');
model.variable('var2').selection.geom('geom1', 1);
model.variable('var2').selection.set([3]);
model.variable('var2').selection.extraDim('ad1');
model.variable('var2').set('theta_P', 'cH[mol/m^3]/c_H_max');
model.variable('var2').descr('theta_P', 'SOC, positive electrode');
model.variable('var2').set('particle_diffusive_flux', '-D_H*d(cH[mol/m^3],rxd)');
model.variable('var2').descr('particle_diffusive_flux', 'Fickian diffusive flux in positive electrode');
model.variable.create('var3');
model.variable('var3').model('comp1');
model.variable('var3').label('Positive Electrode (Particle Surface)');
model.variable('var3').selection.geom('geom1', 1);
model.variable('var3').selection.set([3]);
model.variable('var3').set('cH_surf', 'xdim1.xdsurfop(cH)[mol/m^3]');
model.variable('var3').descr('cH_surf', 'Particle surface H concentration, positive electrode');
model.variable('var3').set('cH_average', 'xdim1.xdintopDomain(rxd*cH[mol/m^3])/xdim1.xdintopDomain(rxd)');
model.variable('var3').descr('cH_average', 'Average H concentration, positive electrode');
model.variable('var3').set('soc_average', 'cH_average/c_H_max');
model.variable('var3').descr('soc_average', 'Average SOC, positive electrode');

model.cpl.create('intop1', 'Integration', 'geom1');
model.cpl('intop1').set('axisym', true);
model.cpl('intop1').label('Integration Operator for Positive Electrode Current Collector');
model.cpl('intop1').set('opname', 'intop_posCC');
model.cpl('intop1').selection.geom('geom1', 0);
model.cpl('intop1').selection.set([4]);
model.cpl.create('aveop1', 'Average', 'geom1');
model.cpl('aveop1').set('axisym', true);
model.cpl('aveop1').label('Positive Electrode Average Operator');
model.cpl('aveop1').set('opname', 'ave_pos');
model.cpl('aveop1').selection.set([3]);
model.cpl.create('aveop2', 'Average', 'geom1');
model.cpl('aveop2').set('axisym', true);
model.cpl('aveop2').label('Negative Electrode Average Operator');
model.cpl('aveop2').set('opname', 'ave_neg');
model.cpl('aveop2').selection.set([1]);

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

model.physics('batbe').feature('sep1').set('epsl', 'epsilon_2');
model.physics('batbe').feature('init1').set('cl', 'cl_init');
model.physics('batbe').create('pce1', 'PorousElectrode', 1);
model.physics('batbe').feature('pce1').label('Porous Electrode: Ni (Positive)');
model.physics('batbe').feature('pce1').selection.set([3]);
model.physics('batbe').feature('pce1').set('sigma', {'sigma_electrode' '0' '0' '0' 'sigma_electrode' '0' '0' '0' 'sigma_electrode'});
model.physics('batbe').feature('pce1').set('IntercalationOption', 'NonIntercalatingParticles');
model.physics('batbe').feature('pce1').set('epss', 'epss');
model.physics('batbe').feature('pce1').set('epsl', 'epsilon0_P-epss');
model.physics('batbe').feature('pce1').set('ElectricCorrModel', 'NoCorr');
model.physics('batbe').feature('pce1').feature('per1').label('Porous Electrode Reaction: NiOOH + H2O + e- <=> Ni(OH)2 + OH-');
model.physics('batbe').feature('pce1').feature('per1').set('Eeq_mat', 'NernstEquation');
model.physics('batbe').feature('pce1').feature('per1').set('Eeq_ref', 'E_ref_pos');
model.physics('batbe').feature('pce1').feature('per1').set('CRNernst', '(cl/c_ref)*(cH_surf/c_H_ref)');
model.physics('batbe').feature('pce1').feature('per1').set('CONernst', '(c_H_max-cH_surf)/(c_H_max-c_H_ref)');
model.physics('batbe').feature('pce1').feature('per1').set('ElectrodeKinetics', 'ButlerVolmer');
model.physics('batbe').feature('pce1').feature('per1').set('i0Type', 'FromNernstEquation');
model.physics('batbe').feature('pce1').feature('per1').set('i0_ref', 'i0_1_ref');
model.physics('batbe').feature('pce1').feature('per1').set('alphaa', 'alpha_a_1');
model.physics('batbe').feature('pce1').feature('per1').set('ActiveSpecificSurfaceAreaType', 'userdef');
model.physics('batbe').feature('pce1').feature('per1').set('Av', 'a_Ni');
model.physics('batbe').feature('pce1').feature('per1').set('dEeqdT_mat', 'userdef');
model.physics('batbe').feature('pce1').create('per2', 'PorousElectrodeReaction', 1);
model.physics('batbe').feature('pce1').feature('per2').label('Porous Electrode Reaction: 1/2 O2 + H2O + 2e- <=> 2 OH-');
model.physics('batbe').feature('pce1').feature('per2').set('Eeq_mat', 'NernstEquation');
model.physics('batbe').feature('pce1').feature('per2').set('Eeq_ref', 'E_ref_OER');
model.physics('batbe').feature('pce1').feature('per2').set('CONernst', 'c_O2/c_O2_ref');
model.physics('batbe').feature('pce1').feature('per2').set('ElectrodeKinetics', 'ButlerVolmer');
model.physics('batbe').feature('pce1').feature('per2').set('i0Type', 'FromNernstEquation');
model.physics('batbe').feature('pce1').feature('per2').set('i0_ref', 'i0_2_ref*max(cl/c_ref,1e-20)^2');
model.physics('batbe').feature('pce1').feature('per2').set('alphaa', 'alpha_a_2');
model.physics('batbe').feature('pce1').feature('per2').set('ActiveSpecificSurfaceAreaType', 'userdef');
model.physics('batbe').feature('pce1').feature('per2').set('Av', 'a_Ni');
model.physics('batbe').feature('pce1').feature('per2').set('nm', 4);
model.physics('batbe').feature('pce1').feature('per2').set('dEeqdT_mat', 'userdef');
model.physics('batbe').create('weak1', 'WeakContribution', 1);
model.physics('batbe').feature('weak1').label('H+ Diffusion Inside Positive Electrode');
model.physics('batbe').feature('weak1').selection.set([3]);
model.physics('batbe').feature('weak1').selection.extraDim('ad1');
model.physics('batbe').feature('weak1').selection.extraDimSel('geom2').set([1]);
model.physics('batbe').feature('weak1').set('weakExpression', '2*pi*rxd*(particle_diffusive_flux*test(cHrxd)-cHt*test(cH))');
model.physics('batbe').feature('weak1').create('aux1', 'AuxiliaryField', 1);
model.physics('batbe').feature('weak1').feature('aux1').label('Intraparticle H+ Concentration');
model.physics('batbe').feature('weak1').feature('aux1').selection.extraDim('ad1');
model.physics('batbe').feature('weak1').feature('aux1').selection.extraDimSel('geom2').set([1]);
model.physics('batbe').feature('weak1').feature('aux1').set('fieldVariableName', 'cH');
model.physics('batbe').feature('weak1').feature('aux1').set('initialValue', 'c_H_init');
model.physics('batbe').create('weak2', 'WeakContribution', 1);
model.physics('batbe').feature('weak2').label('Boundary Condition for Concentration at Particle Outer Surface');
model.physics('batbe').feature('weak2').selection.set([3]);
model.physics('batbe').feature('weak2').selection.extraDim('ad1');
model.physics('batbe').feature('weak2').selection.extraDimSel('geom2').geom('geom2', 0);
model.physics('batbe').feature('weak2').selection.extraDimSel('geom2').set([2]);
model.physics('batbe').feature('weak2').set('weakExpression', '-2*batbe.pce1.per1.iloc*test(cH)*pi*rxd/(1[m]*F_const)');

model.nodeGroup.create('grp1', 'Physics', 'batbe');
model.nodeGroup('grp1').placeAfter('pce1');
model.nodeGroup('grp1').add('weak1');
model.nodeGroup('grp1').add('weak2');
model.nodeGroup('grp1').label('Intraparticle Diffusion of H+');

model.physics('batbe').create('pce2', 'PorousElectrode', 1);
model.physics('batbe').feature('pce2').label('Porous Electrode: Cd (Negative)');
model.physics('batbe').feature('pce2').selection.set([1]);
model.physics('batbe').feature('pce2').set('sigma', {'sigma_electrode' '0' '0' '0' 'sigma_electrode' '0' '0' '0' 'sigma_electrode'});
model.physics('batbe').feature('pce2').set('IntercalationOption', 'NonIntercalatingParticles');
model.physics('batbe').feature('pce2').set('epss', '1-epsilon_3_init');
model.physics('batbe').feature('pce2').set('epsl', 'epsilon_3_init');
model.physics('batbe').feature('pce2').set('ElectricCorrModel', 'NoCorr');
model.physics('batbe').feature('pce2').setIndex('Species', 's1', 0, 0);
model.physics('batbe').feature('pce2').setIndex('rhos', 8960, 0, 0);
model.physics('batbe').feature('pce2').setIndex('Ms', 0.06355, 0, 0);
model.physics('batbe').feature('pce2').setIndex('Species', 's1', 0, 0);
model.physics('batbe').feature('pce2').setIndex('rhos', 8960, 0, 0);
model.physics('batbe').feature('pce2').setIndex('Ms', 0.06355, 0, 0);
model.physics('batbe').feature('pce2').setIndex('Species', 'Cd', 0, 0);
model.physics('batbe').feature('pce2').setIndex('rhos', 'rho_Cd', 0, 0);
model.physics('batbe').feature('pce2').setIndex('Ms', 'M_Cd', 0, 0);
model.physics('batbe').feature('pce2').setIndex('Species', 's1', 1, 0);
model.physics('batbe').feature('pce2').setIndex('rhos', 8960, 1, 0);
model.physics('batbe').feature('pce2').setIndex('Ms', 0.06355, 1, 0);
model.physics('batbe').feature('pce2').setIndex('rhos', 8960, 1, 0);
model.physics('batbe').feature('pce2').setIndex('Ms', 0.06355, 1, 0);
model.physics('batbe').feature('pce2').setIndex('Species', 's1', 1, 0);
model.physics('batbe').feature('pce2').setIndex('rhos', 8960, 1, 0);
model.physics('batbe').feature('pce2').setIndex('Ms', 0.06355, 1, 0);
model.physics('batbe').feature('pce2').setIndex('Species', 'CdO2H2', 1, 0);
model.physics('batbe').feature('pce2').setIndex('rhos', 'rho_CdO2H2', 1, 0);
model.physics('batbe').feature('pce2').setIndex('Ms', 'M_CdO2H2', 1, 0);
model.physics('batbe').feature('pce2').feature('per1').label('Porous Electrode Reaction: Cd + 2 OH- <=> Cd(OH)2 + 2e-');
model.physics('batbe').feature('pce2').feature('per1').set('Eeq_mat', 'NernstEquation');
model.physics('batbe').feature('pce2').feature('per1').set('Eeq_ref', 'E_ref_neg');
model.physics('batbe').feature('pce2').feature('per1').set('CRNernst', '(cl/c_ref)^2');
model.physics('batbe').feature('pce2').feature('per1').set('ElectrodeKinetics', 'ButlerVolmer');
model.physics('batbe').feature('pce2').feature('per1').set('i0Type', 'FromNernstEquation');
model.physics('batbe').feature('pce2').feature('per1').set('i0_ref', 'theta_N*i0_3_ref');
model.physics('batbe').feature('pce2').feature('per1').set('alphaa', 'alpha_a_3');
model.physics('batbe').feature('pce2').feature('per1').set('ActiveSpecificSurfaceAreaType', 'userdef');
model.physics('batbe').feature('pce2').feature('per1').set('Av', 'a_Cd');
model.physics('batbe').feature('pce2').feature('per1').set('nm', 2);
model.physics('batbe').feature('pce2').feature('per1').setIndex('Vib', 1, 0, 0);
model.physics('batbe').feature('pce2').feature('per1').setIndex('Vib', -1, 1, 0);
model.physics('batbe').feature('pce2').feature('per1').set('dEeqdT_mat', 'userdef');
model.physics('batbe').create('bei1', 'InternalElectrodeSurface', 0);
model.physics('batbe').feature('bei1').label('Oxygen Recombination at Cd Electrode');
model.physics('batbe').feature('bei1').selection.set([2]);
model.physics('batbe').feature('bei1').feature('er1').label('Electrode Reaction: 1/2 O2 + H2O + 2e- <=> 2 OH-');
model.physics('batbe').feature('bei1').feature('er1').set('Eeq_mat', 'userdef');
model.physics('batbe').feature('bei1').feature('er1').set('ilocmat_mat', 'userdef');
model.physics('batbe').feature('bei1').feature('er1').set('ilocmat', 'tds.tflux_c_O2x*4*F_const');
model.physics('batbe').feature('bei1').feature('er1').set('dEeqdT_mat', 'userdef');
model.physics('batbe').create('egnd1', 'ElectricGround', 0);
model.physics('batbe').feature('egnd1').selection.set([1]);
model.physics('batbe').create('ec1', 'ElectrodeCurrent', 0);
model.physics('batbe').feature('ec1').selection.set([4]);
model.physics('batbe').feature('ec1').set('ElectronicCurrentType', 'AverageCurrentDensity');
model.physics('batbe').feature('ec1').set('Ias', 'sign*i_app');
model.physics.create('tds', 'DilutedSpecies', 'geom1', {'c'});

model.study('std1').feature('cdi').setSolveFor('/physics/tds', true);
model.study('std1').feature('time').setSolveFor('/physics/tds', true);

model.physics('tds').prop('TransportMechanism').set('Convection', false);
model.physics('tds').prop('TransportMechanism').set('MassTransferInPorousMedia', true);
model.physics('tds').field('concentration').component(1, 'c_O2');
model.physics('tds').selection.set([2 3]);
model.physics('tds').feature('cdm1').set('D_c_O2', {'D_O2' '0' '0' '0' 'D_O2' '0' '0' '0' 'D_O2'});
model.physics('tds').feature('init1').setIndex('initc', 'c_O2_init', 0);
model.physics('tds').create('pec1', 'PorousElectrodeCoupling', 1);
model.physics('tds').feature('pec1').label('Porous Electrode Coupling: Positive Electrode');
model.physics('tds').feature('pec1').selection.set([3]);
model.physics('tds').feature('pec1').feature('rc1').set('iv_src', 'root.comp1.batbe.pce1.per2.iv');
model.physics('tds').feature('pec1').feature('rc1').set('nm', 4);
model.physics('tds').feature('pec1').feature('rc1').setIndex('Vi', -1, 0);
model.physics('tds').create('conc1', 'Concentration', 0);
model.physics('tds').feature('conc1').label('Oxygen Recombination at Cd Electrode');
model.physics('tds').feature('conc1').selection.set([2]);
model.physics('tds').feature('conc1').setIndex('species', true, 0);
model.physics('tds').create('init2', 'init', 1);
model.physics('tds').feature('init2').selection.set([2]);
model.physics('tds').feature('init2').setIndex('initc', 'c_O2_init*((x-l_neg)/l_sep)', 0);

model.study('std1').label('Discharge and Charge');
model.study('std1').create('param', 'Parametric');
model.study('std1').feature('param').set('sweeptype', 'switch');
model.study('std1').feature('param').setIndex('switchname', 'default', 0);
model.study('std1').feature('param').setIndex('switchcase', 'all', 0);
model.study('std1').feature('param').setIndex('switchlistarr', '', 0);
model.study('std1').feature('param').setIndex('switchname', 'default', 0);
model.study('std1').feature('param').setIndex('switchcase', 'all', 0);
model.study('std1').feature('param').setIndex('switchlistarr', '', 0);
model.study('std1').feature('param').setIndex('switchname', 'par5', 0);
model.study('std1').feature('param').setIndex('switchname', 'default', 1);
model.study('std1').feature('param').setIndex('switchcase', 'all', 1);
model.study('std1').feature('param').setIndex('switchlistarr', '', 1);
model.study('std1').feature('param').setIndex('switchname', 'default', 1);
model.study('std1').feature('param').setIndex('switchcase', 'all', 1);
model.study('std1').feature('param').setIndex('switchlistarr', '', 1);
model.study('std1').feature('param').setIndex('switchname', 'par6', 1);
model.study('std1').feature('cdi').label('Current Distribution Initialization: Primary');
model.study('std1').create('cdi2', 'CurrentDistributionInitialization');
model.study('std1').feature.move('cdi2', 2);
model.study('std1').feature('cdi2').label('Current Distribution Initialization: Secondary');
model.study('std1').feature('cdi2').set('initType', 'secondary');
model.study('std1').feature('time').set('tunit', 'h');
model.study('std1').feature('time').set('tlist', 'range(0,t_charge_limit/100,t_charge_limit)');

model.sol.create('sol1');

model.mesh('mesh1').stat.selection.geom(1);
model.mesh('mesh1').stat.selection.set([2 3]);

model.sol('sol1').study('std1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'cdi');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').feature('comp1_phil').set('scalemethod', 'manual');
model.sol('sol1').feature('v1').feature('comp1_phis').set('scalemethod', 'manual');
model.sol('sol1').feature('v1').feature('comp1_batbe_ec1_phis0').set('scalemethod', 'manual');
model.sol('sol1').feature('v1').feature('comp1_cl').set('scalemethod', 'manual');
model.sol('sol1').feature('v1').feature('comp1_phil').set('scaleval', '1');
model.sol('sol1').feature('v1').feature('comp1_phis').set('scaleval', '1');
model.sol('sol1').feature('v1').feature('comp1_batbe_ec1_phis0').set('scaleval', '1');
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
model.sol('sol1').feature('st2').set('studystep', 'cdi2');
model.sol('sol1').create('v2', 'Variables');
model.sol('sol1').feature('v2').feature('comp1_phil').set('scalemethod', 'manual');
model.sol('sol1').feature('v2').feature('comp1_phis').set('scalemethod', 'manual');
model.sol('sol1').feature('v2').feature('comp1_batbe_ec1_phis0').set('scalemethod', 'manual');
model.sol('sol1').feature('v2').feature('comp1_cl').set('scalemethod', 'manual');
model.sol('sol1').feature('v2').feature('comp1_phil').set('scaleval', '1');
model.sol('sol1').feature('v2').feature('comp1_phis').set('scaleval', '1');
model.sol('sol1').feature('v2').feature('comp1_batbe_ec1_phis0').set('scaleval', '1');
model.sol('sol1').feature('v2').feature('comp1_cl').set('scaleval', '1000');
model.sol('sol1').feature('v2').set('initmethod', 'sol');
model.sol('sol1').feature('v2').set('initsol', 'sol1');
model.sol('sol1').feature('v2').set('initsoluse', 'sol2');
model.sol('sol1').feature('v2').set('notsolmethod', 'sol');
model.sol('sol1').feature('v2').set('notsol', 'sol1');
model.sol('sol1').feature('v2').set('control', 'cdi2');
model.sol('sol1').create('s2', 'Stationary');
model.sol('sol1').feature('s2').set('stol', 1.0E-4);
model.sol('sol1').feature('s2').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('s2').feature('fc1').set('dtech', 'auto');
model.sol('sol1').feature('s2').feature('fc1').set('maxiter', 50);
model.sol('sol1').feature('s2').feature('fc1').set('minstep', 1.0E-6);
model.sol('sol1').feature('s2').create('d1', 'Direct');
model.sol('sol1').feature('s2').feature('d1').set('linsolver', 'pardiso');
model.sol('sol1').feature('s2').feature('d1').label('Direct (batbe)');
model.sol('sol1').feature('s2').create('i1', 'Iterative');
model.sol('sol1').feature('s2').feature('i1').set('maxlinit', 1000);
model.sol('sol1').feature('s2').feature('i1').set('nlinnormuse', 'on');
model.sol('sol1').feature('s2').feature('i1').label('Algebraic Multigrid (batbe)');
model.sol('sol1').feature('s2').feature('i1').create('mg1', 'Multigrid');
model.sol('sol1').feature('s2').feature('i1').feature('mg1').set('prefun', 'saamg');
model.sol('sol1').feature('s2').feature('i1').feature('mg1').set('maxcoarsedof', 50000);
model.sol('sol1').feature('s2').feature('i1').feature('mg1').set('saamgcompwise', true);
model.sol('sol1').feature('s2').feature('i1').feature('mg1').set('compactaggregation', true);
model.sol('sol1').feature('s2').feature('i1').feature('mg1').feature('pr').create('sl1', 'SORLine');
model.sol('sol1').feature('s2').feature('i1').feature('mg1').feature('po').create('sl1', 'SORLine');
model.sol('sol1').feature('s2').feature('i1').feature('mg1').feature('cs').create('d1', 'Direct');
model.sol('sol1').feature('s2').feature('i1').feature('mg1').feature('cs').feature('d1').set('linsolver', 'pardiso');
model.sol('sol1').feature('s2').create('i2', 'Iterative');
model.sol('sol1').feature('s2').feature('i2').set('maxlinit', 1000);
model.sol('sol1').feature('s2').feature('i2').set('nlinnormuse', 'on');
model.sol('sol1').feature('s2').feature('i2').label('Geometric Multigrid (batbe)');
model.sol('sol1').feature('s2').feature('i2').create('mg1', 'Multigrid');
model.sol('sol1').feature('s2').feature('i2').feature('mg1').feature('pr').create('sl1', 'SORLine');
model.sol('sol1').feature('s2').feature('i2').feature('mg1').feature('po').create('sl1', 'SORLine');
model.sol('sol1').feature('s2').feature('i2').feature('mg1').feature('cs').create('d1', 'Direct');
model.sol('sol1').feature('s2').feature('i2').feature('mg1').feature('cs').feature('d1').set('linsolver', 'pardiso');
model.sol('sol1').feature('s2').feature('fc1').set('linsolver', 'd1');
model.sol('sol1').feature('s2').feature('fc1').set('dtech', 'auto');
model.sol('sol1').feature('s2').feature('fc1').set('maxiter', 50);
model.sol('sol1').feature('s2').feature('fc1').set('minstep', 1.0E-6);
model.sol('sol1').feature('s2').feature.remove('fcDef');
model.sol('sol1').create('su2', 'StoreSolution');
model.sol('sol1').create('st3', 'StudyStep');
model.sol('sol1').feature('st3').set('study', 'std1');
model.sol('sol1').feature('st3').set('studystep', 'time');
model.sol('sol1').create('v3', 'Variables');
model.sol('sol1').feature('v3').feature('comp1_phil').set('scalemethod', 'manual');
model.sol('sol1').feature('v3').feature('comp1_phis').set('scalemethod', 'manual');
model.sol('sol1').feature('v3').feature('comp1_batbe_ec1_phis0').set('scalemethod', 'manual');
model.sol('sol1').feature('v3').feature('comp1_cl').set('scalemethod', 'manual');
model.sol('sol1').feature('v3').feature('comp1_phil').set('scaleval', '1');
model.sol('sol1').feature('v3').feature('comp1_phis').set('scaleval', '1');
model.sol('sol1').feature('v3').feature('comp1_batbe_ec1_phis0').set('scaleval', '1');
model.sol('sol1').feature('v3').feature('comp1_cl').set('scaleval', '1000');
model.sol('sol1').feature('v3').set('initmethod', 'sol');
model.sol('sol1').feature('v3').set('initsol', 'sol1');
model.sol('sol1').feature('v3').set('initsoluse', 'sol3');
model.sol('sol1').feature('v3').set('notsolmethod', 'sol');
model.sol('sol1').feature('v3').set('notsol', 'sol1');
model.sol('sol1').feature('v3').set('notsoluse', 'sol3');
model.sol('sol1').feature('v3').set('control', 'time');
model.sol('sol1').create('t1', 'Time');
model.sol('sol1').feature('t1').set('tlist', 'range(0,t_charge_limit/100,t_charge_limit)');
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
model.sol('sol1').feature('t1').set('stabcntrl', true);
model.sol('sol1').feature('t1').set('initialstepbdfactive', true);
model.sol('sol1').feature('t1').set('initialstepbdf', '(1)[s]');
model.sol('sol1').feature('t1').set('control', 'time');
model.sol('sol1').feature('t1').feature('aDef').set('cachepattern', true);
model.sol('sol1').feature('t1').create('seDef', 'Segregated');
model.sol('sol1').feature('t1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('t1').feature('fc1').set('dtech', 'auto');
model.sol('sol1').feature('t1').feature('fc1').set('stabacc', 'aacc');
model.sol('sol1').feature('t1').feature('fc1').set('aaccdim', 5);
model.sol('sol1').feature('t1').feature('fc1').set('aaccdelay', 0);
model.sol('sol1').feature('t1').feature('fc1').set('aaccmix', 0.9);
model.sol('sol1').feature('t1').feature('fc1').set('maxiter', 8);
model.sol('sol1').feature('t1').feature('fc1').set('damp', 0.9);
model.sol('sol1').feature('t1').feature('fc1').set('jtech', 'once');
model.sol('sol1').feature('t1').create('d1', 'Direct');
model.sol('sol1').feature('t1').feature('d1').set('linsolver', 'pardiso');
model.sol('sol1').feature('t1').feature('d1').set('pivotperturb', 1.0E-13);
model.sol('sol1').feature('t1').feature('d1').label('Direct (batbe) (Merged)');
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
model.sol('sol1').feature('t1').create('i3', 'Iterative');
model.sol('sol1').feature('t1').feature('i3').set('linsolver', 'gmres');
model.sol('sol1').feature('t1').feature('i3').set('prefuntype', 'left');
model.sol('sol1').feature('t1').feature('i3').set('itrestart', 50);
model.sol('sol1').feature('t1').feature('i3').set('rhob', 400);
model.sol('sol1').feature('t1').feature('i3').set('maxlinit', 50);
model.sol('sol1').feature('t1').feature('i3').set('nlinnormuse', 'on');
model.sol('sol1').feature('t1').feature('i3').label('AMG, concentrations (tds)');
model.sol('sol1').feature('t1').feature('i3').create('mg1', 'Multigrid');
model.sol('sol1').feature('t1').feature('i3').feature('mg1').set('prefun', 'saamg');
model.sol('sol1').feature('t1').feature('i3').feature('mg1').set('mgcycle', 'v');
model.sol('sol1').feature('t1').feature('i3').feature('mg1').set('maxcoarsedof', 50000);
model.sol('sol1').feature('t1').feature('i3').feature('mg1').set('strconn', 0.01);
model.sol('sol1').feature('t1').feature('i3').feature('mg1').set('nullspace', 'constant');
model.sol('sol1').feature('t1').feature('i3').feature('mg1').set('usesmooth', false);
model.sol('sol1').feature('t1').feature('i3').feature('mg1').set('saamgcompwise', true);
model.sol('sol1').feature('t1').feature('i3').feature('mg1').set('loweramg', true);
model.sol('sol1').feature('t1').feature('i3').feature('mg1').set('compactaggregation', false);
model.sol('sol1').feature('t1').feature('i3').feature('mg1').feature('pr').create('sl1', 'SORLine');
model.sol('sol1').feature('t1').feature('i3').feature('mg1').feature('pr').feature('sl1').set('linesweeptype', 'ssor');
model.sol('sol1').feature('t1').feature('i3').feature('mg1').feature('pr').feature('sl1').set('iter', 1);
model.sol('sol1').feature('t1').feature('i3').feature('mg1').feature('pr').feature('sl1').set('linerelax', 0.7);
model.sol('sol1').feature('t1').feature('i3').feature('mg1').feature('pr').feature('sl1').set('linealgorithm', 'mesh');
model.sol('sol1').feature('t1').feature('i3').feature('mg1').feature('pr').feature('sl1').set('linemethod', 'coupled');
model.sol('sol1').feature('t1').feature('i3').feature('mg1').feature('pr').feature('sl1').set('seconditer', 1);
model.sol('sol1').feature('t1').feature('i3').feature('mg1').feature('pr').feature('sl1').set('relax', 0.5);
model.sol('sol1').feature('t1').feature('i3').feature('mg1').feature('po').create('sl1', 'SORLine');
model.sol('sol1').feature('t1').feature('i3').feature('mg1').feature('po').feature('sl1').set('linesweeptype', 'ssor');
model.sol('sol1').feature('t1').feature('i3').feature('mg1').feature('po').feature('sl1').set('iter', 1);
model.sol('sol1').feature('t1').feature('i3').feature('mg1').feature('po').feature('sl1').set('linerelax', 0.7);
model.sol('sol1').feature('t1').feature('i3').feature('mg1').feature('po').feature('sl1').set('linealgorithm', 'mesh');
model.sol('sol1').feature('t1').feature('i3').feature('mg1').feature('po').feature('sl1').set('linemethod', 'coupled');
model.sol('sol1').feature('t1').feature('i3').feature('mg1').feature('po').feature('sl1').set('seconditer', 1);
model.sol('sol1').feature('t1').feature('i3').feature('mg1').feature('po').feature('sl1').set('relax', 0.5);
model.sol('sol1').feature('t1').feature('i3').feature('mg1').feature('cs').create('d1', 'Direct');
model.sol('sol1').feature('t1').feature('i3').feature('mg1').feature('cs').feature('d1').set('linsolver', 'pardiso');
model.sol('sol1').feature('t1').feature('i3').feature('mg1').feature('cs').feature('d1').set('pivotperturb', 1.0E-13);
model.sol('sol1').feature('t1').feature('fc1').set('linsolver', 'd1');
model.sol('sol1').feature('t1').feature('fc1').set('dtech', 'auto');
model.sol('sol1').feature('t1').feature('fc1').set('stabacc', 'aacc');
model.sol('sol1').feature('t1').feature('fc1').set('aaccdim', 5);
model.sol('sol1').feature('t1').feature('fc1').set('aaccdelay', 0);
model.sol('sol1').feature('t1').feature('fc1').set('aaccmix', 0.9);
model.sol('sol1').feature('t1').feature('fc1').set('maxiter', 8);
model.sol('sol1').feature('t1').feature('fc1').set('damp', 0.9);
model.sol('sol1').feature('t1').feature('fc1').set('jtech', 'once');
model.sol('sol1').feature('t1').feature.remove('fcDef');
model.sol('sol1').feature('t1').feature.remove('seDef');
model.sol('sol1').feature('v2').set('notsolnum', 'auto');
model.sol('sol1').feature('v2').set('notsolvertype', 'solnum');
model.sol('sol1').attach('std1');

model.batch.create('p1', 'Parametric');
model.batch('p1').study('std1');
model.batch('p1').create('so1', 'Solutionseq');
model.batch('p1').feature('so1').set('seq', 'sol1');
model.batch('p1').feature('so1').set('store', 'on');
model.batch('p1').feature('so1').set('clear', 'on');
model.batch('p1').feature('so1').set('psol', 'none');
model.batch('p1').set('pname', {});
model.batch('p1').set('plistarr', {});
model.batch('p1').set('sweeptype', 'switch');
model.batch('p1').set('probesel', 'all');
model.batch('p1').set('probes', {});
model.batch('p1').set('plot', 'off');
model.batch('p1').set('err', 'on');
model.batch('p1').attach('std1');
model.batch('p1').set('control', 'param');

model.sol('sol1').feature('v3').feature('comp1_c_O2').set('scalemethod', 'manual');
model.sol('sol1').feature('v3').feature('comp1_c_O2').set('scaleval', 'c_O2_ref');
model.sol('sol1').feature('v3').feature('comp1_cH').set('scalemethod', 'manual');
model.sol('sol1').feature('v3').feature('comp1_cH').set('scaleval', 'c_H_ref');
model.sol('sol1').feature('t1').create('st1', 'StopCondition');
model.sol('sol1').feature('t1').feature('st1').setIndex('stopcondarr', '', 0);
model.sol('sol1').feature('t1').feature('st1').setIndex('stopcondterminateon', 'true', 0);
model.sol('sol1').feature('t1').feature('st1').setIndex('stopcondActive', true, 0);
model.sol('sol1').feature('t1').feature('st1').setIndex('stopconddesc', 'Stop expression 1', 0);
model.sol('sol1').feature('t1').feature('st1').setIndex('stopcondarr', '', 0);
model.sol('sol1').feature('t1').feature('st1').setIndex('stopcondterminateon', 'true', 0);
model.sol('sol1').feature('t1').feature('st1').setIndex('stopcondActive', true, 0);
model.sol('sol1').feature('t1').feature('st1').setIndex('stopconddesc', 'Stop expression 1', 0);
model.sol('sol1').feature('t1').feature('st1').setIndex('stopcondarr', 'comp1.intop_posCC(comp1.phis)<0.8', 0);
model.sol('sol1').feature('t1').feature('st1').setIndex('stopcondarr', '', 1);
model.sol('sol1').feature('t1').feature('st1').setIndex('stopcondterminateon', 'true', 1);
model.sol('sol1').feature('t1').feature('st1').setIndex('stopcondActive', true, 1);
model.sol('sol1').feature('t1').feature('st1').setIndex('stopconddesc', 'Stop expression 2', 1);
model.sol('sol1').feature('t1').feature('st1').setIndex('stopcondarr', '', 1);
model.sol('sol1').feature('t1').feature('st1').setIndex('stopcondterminateon', 'true', 1);
model.sol('sol1').feature('t1').feature('st1').setIndex('stopcondActive', true, 1);
model.sol('sol1').feature('t1').feature('st1').setIndex('stopconddesc', 'Stop expression 2', 1);
model.sol('sol1').feature('t1').feature('st1').setIndex('stopcondarr', 'comp1.intop_posCC(comp1.phis)>1.6', 1);
model.sol('sol1').feature('t1').feature('st1').set('storestopcondsol', 'stepafter');
model.sol.create('sol4');
model.sol('sol4').study('std1');
model.sol('sol4').label('Parametric Solutions 1');

model.batch('p1').feature('so1').set('psol', 'sol4');
model.batch('p1').run('compute');

model.result.create('pg1', 'PlotGroup1D');
model.result('pg1').set('data', 'dset4');
model.result('pg1').create('glob1', 'Global');
model.result('pg1').feature('glob1').set('unit', {''});
model.result('pg1').feature('glob1').set('expr', {'batbe.phis0_ec1'});
model.result('pg1').feature('glob1').set('descr', {'Electric potential on boundary'});
model.result('pg1').label('Boundary Electrode Potential with Respect to Ground (batbe)');
model.result('pg1').feature('glob1').set('xdatasolnumtype', 'inner');
model.result.create('pg2', 'PlotGroup1D');
model.result('pg2').set('data', 'dset4');
model.result('pg2').label('Electrolyte Potential (batbe)');
model.result('pg2').create('lngr1', 'LineGraph');
model.result('pg2').feature('lngr1').set('xdata', 'expr');
model.result('pg2').feature('lngr1').set('xdataexpr', 'x');
model.result('pg2').feature('lngr1').selection.geom('geom1', 1);
model.result('pg2').feature('lngr1').selection.set([1 2 3]);
model.result('pg2').feature('lngr1').set('expr', {'phil'});
model.result.create('pg3', 'PlotGroup1D');
model.result('pg3').set('data', 'dset4');
model.result('pg3').label('Electrode Potential with Respect to Ground (batbe)');
model.result('pg3').create('lngr1', 'LineGraph');
model.result('pg3').feature('lngr1').set('xdata', 'expr');
model.result('pg3').feature('lngr1').set('xdataexpr', 'x');
model.result('pg3').feature('lngr1').selection.geom('geom1', 1);
model.result('pg3').feature('lngr1').selection.set([1 2 3]);
model.result('pg3').feature('lngr1').set('expr', {'phis'});
model.result.create('pg4', 'PlotGroup1D');
model.result('pg4').set('data', 'dset4');
model.result('pg4').create('lngr1', 'LineGraph');
model.result('pg4').feature('lngr1').set('xdata', 'expr');
model.result('pg4').feature('lngr1').set('xdataexpr', 'x');
model.result('pg4').feature('lngr1').selection.geom('geom1', 1);
model.result('pg4').feature('lngr1').selection.set([1 2 3]);
model.result('pg4').feature('lngr1').set('expr', {'cl'});
model.result('pg4').label('Electrolyte Salt Concentration (batbe)');
model.result.create('pg5', 'PlotGroup1D');
model.result('pg5').set('data', 'dset4');
model.result('pg5').label('Concentration (tds)');
model.result('pg5').set('titletype', 'custom');
model.result('pg5').set('prefixintitle', '');
model.result('pg5').set('expressionintitle', false);
model.result('pg5').set('typeintitle', false);
model.result('pg5').create('lngr1', 'LineGraph');
model.result('pg5').feature('lngr1').set('xdata', 'expr');
model.result('pg5').feature('lngr1').set('xdataexpr', 'x');
model.result('pg5').feature('lngr1').selection.geom('geom1', 1);
model.result('pg5').feature('lngr1').selection.set([2 3]);
model.result('pg5').feature('lngr1').set('expr', {'c_O2'});
model.result('pg1').run;
model.result('pg1').label('Discharge: Boundary Electrode Potential with Respect to Ground (batbe)');
model.result('pg1').set('outerinput', 'manual');
model.result('pg1').set('outersolnum', [1 2 3]);
model.result('pg1').run;
model.result('pg1').run;
model.result('pg1').feature('glob1').set('xdata', 'expr');
model.result('pg1').feature('glob1').set('xdataexpr', 't');
model.result('pg1').feature('glob1').set('xdataunit', 'h');
model.result('pg1').feature('glob1').set('legendmethod', 'evaluated');
model.result('pg1').feature('glob1').set('legendpattern', 'C/eval(1/C_rate)');
model.result('pg1').run;
model.result('pg1').set('titletype', 'manual');
model.result('pg1').set('title', 'Discharge');
model.result('pg1').set('legendpos', 'lowerright');
model.result('pg1').run;
model.result.duplicate('pg6', 'pg1');
model.result('pg6').run;
model.result('pg6').label('Charge: Boundary Electrode Potential with Respect to Ground (batbe)');
model.result('pg6').set('outersolnum', [4 5 6]);
model.result('pg6').set('title', 'Charge');
model.result('pg6').run;
model.result.create('pg7', 'PlotGroup1D');
model.result('pg7').run;
model.result('pg7').label('Charge: Average Positive Electrode Hydration Level');
model.result('pg7').set('data', 'dset4');
model.result('pg7').set('outerinput', 'manual');
model.result('pg7').set('outersolnum', [4 5 6]);
model.result('pg7').set('titletype', 'manual');
model.result('pg7').set('title', 'Average Positive Electrode Hydration Level');
model.result('pg7').create('glob1', 'Global');
model.result('pg7').feature('glob1').set('markerpos', 'datapoints');
model.result('pg7').feature('glob1').set('linewidth', 'preference');
model.result('pg7').feature('glob1').setIndex('expr', 'comp1.ave_pos(cH_average/c_H_max)', 0);
model.result('pg7').feature('glob1').setIndex('descr', 'Average Hydration Level', 0);
model.result('pg7').feature('glob1').set('xdata', 'expr');
model.result('pg7').feature('glob1').set('xdataexpr', 't*C_rate/1[h]');
model.result('pg7').feature('glob1').set('legendmethod', 'evaluated');
model.result('pg7').feature('glob1').set('legendpattern', 'C/eval(1/C_rate)');
model.result('pg7').run;
model.result.create('pg8', 'PlotGroup1D');
model.result('pg8').run;
model.result('pg8').label('Charge: Average Negative Electrode Volume Fraction');
model.result('pg8').set('data', 'dset4');
model.result('pg8').set('outerinput', 'manual');
model.result('pg8').set('outersolnum', [4 5 6]);
model.result('pg8').run;
model.result('pg8').set('titletype', 'manual');
model.result('pg8').set('title', 'Average Negative Electrode Volume Fraction');
model.result('pg8').create('glob1', 'Global');
model.result('pg8').feature('glob1').set('markerpos', 'datapoints');
model.result('pg8').feature('glob1').set('linewidth', 'preference');
model.result('pg8').feature('glob1').setIndex('expr', 'comp1.ave_neg(batbe.epss)', 0);
model.result('pg8').feature('glob1').setIndex('descr', 'Average volume fraction', 0);
model.result('pg8').feature('glob1').set('xdata', 'expr');
model.result('pg8').feature('glob1').set('xdataexpr', 't*C_rate/1[h]');
model.result('pg8').feature('glob1').set('legendmethod', 'evaluated');
model.result('pg8').feature('glob1').set('legendpattern', 'C/eval(1/C_rate)');
model.result('pg8').run;
model.result('pg1').run;

model.title(['1D Isothermal Nickel' native2unicode(hex2dec({'20' '13'}), 'unicode') 'Cadmium Battery']);

model.description(['This example uses the Battery with Binary Electrolyte interface for studying the charge and discharge of a nickel' native2unicode(hex2dec({'20' '13'}), 'unicode') 'cadmium battery. The geometry is in one dimension, plus a cylindrically symmetric 1D geometry for proton diffusion in the positive electrode. The model is isothermal. Oxygen evolution/reduction at the positive electrode, mass transport of oxygen in the cell, and oxygen evolution/reduction at the negative electrode are additional processes also included in the model.']);

model.mesh.clearMeshes;

model.sol('sol1').clearSolutionData;
model.sol('sol2').clearSolutionData;
model.sol('sol3').clearSolutionData;
model.sol('sol4').clearSolutionData;
model.sol('sol5').clearSolutionData;
model.sol('sol6').clearSolutionData;
model.sol('sol7').clearSolutionData;
model.sol('sol8').clearSolutionData;
model.sol('sol9').clearSolutionData;
model.sol('sol10').clearSolutionData;

model.label('nicd_battery_1d.mph');

model.modelNode.label('Components');

out = model;
