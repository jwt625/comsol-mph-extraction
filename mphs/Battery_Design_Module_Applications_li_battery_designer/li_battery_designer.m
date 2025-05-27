function out = model
%
% li_battery_designer.m
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
model.physics.create('ev', 'Events', 'geom1');
model.physics('ev').model('comp1');
model.physics.create('ev2', 'Events', 'geom1');
model.physics('ev2').model('comp1');
model.physics.create('ge', 'GlobalEquations', 'geom1');
model.physics('ge').model('comp1');
model.physics('ge').prop('EquationForm').set('form', 'Automatic');
model.physics.create('ge2', 'GlobalEquations', 'geom1');
model.physics('ge2').model('comp1');
model.physics('ge2').prop('EquationForm').set('form', 'Automatic');

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
model.study('std1').feature('cdi').setSolveFor('/physics/ev', true);
model.study('std1').feature('cdi').setSolveFor('/physics/ev2', true);
model.study('std1').feature('cdi').setSolveFor('/physics/ge', true);
model.study('std1').feature('cdi').setSolveFor('/physics/ge2', true);
model.study('std1').create('time', 'Transient');
model.study('std1').feature('time').set('initialtime', '0');
model.study('std1').feature('time').set('solnum', 'auto');
model.study('std1').feature('time').set('notsolnum', 'auto');
model.study('std1').feature('time').set('outputmap', {});
model.study('std1').feature('time').setSolveFor('/physics/liion', true);
model.study('std1').feature('time').setSolveFor('/physics/ev', true);
model.study('std1').feature('time').setSolveFor('/physics/ev2', true);
model.study('std1').feature('time').setSolveFor('/physics/ge', true);
model.study('std1').feature('time').setSolveFor('/physics/ge2', true);

% To import content from file, use:
% model.param.loadFile('FILENAME');
model.param.set('cs_max_pos', '49000[mol/m^3]', 'Maximum positive host capacity');
model.param.set('socminpos', '0', 'Delithiation limit, positive electrode');
model.param.set('sigmas_neg', '100[S/m]', 'Electrical conductivity, negative electrode');
model.param.set('sigmas_pos', '100[S/m]', 'Electrical conductivity, positive electrode');
model.param.set('eps_s_pos', '0.6', 'Electrode volume fraction in positive electrode');
model.param.set('eps_binder_pos', '0.1*eps_s_pos', 'Binder (including conductive filler) volume fraction in negative electrode');
model.param.set('eps_l_pos', '1-eps_s_pos-eps_binder_pos', 'Electrolyte volume fraction in negative electrode');
model.param.set('L_pos', '70[um]', 'Positive electrode thickness');
model.param.set('r_pos', '2[um]', 'Radius of positive electrode particles');
model.param.set('Q_excess', '0.25', 'Negative electrode excess host capacity');
model.param.set('eps_s_neg', '0.6', 'Electrode volume fraction in negative electrode');
model.param.set('eps_l_neg', '1-eps_s_neg', 'Electrolyte volume fraction in positive electrode');
model.param.set('cs_max_neg', '31507[mol/m^3]', 'Maximum negative host capacity');
model.param.set('L_neg', 'Q_cell*Yhost_neg/(eps_s_neg*cs_max_neg*F_const)', 'Negative electrode thickness');
model.param.set('r_neg', '2[um]', 'Radius of negative electrode particles');
model.param.set('Li_loss', '0.05', 'Initial lithium inventory loss during formation cycling');
model.param.set('L_sep', '30[um]', 'Separator thickness');
model.param.set('eps_l_sep', '0.5', 'Electrolyte volume fraction in separator');
model.param.set('L_CC_pos', '5[um]', 'Positive current collector thickness');
model.param.set('L_CC_neg', '5[um]', 'Negative current collector thickness');
model.param.set('Vol_18650', '(18[mm]/2)^2*pi*65[mm]', 'Battery volume');
model.param.set('Jelly_vol', '0.95', 'Relative jelly roll volume in battery');
model.param.set('L_batt', 'L_CC_neg+L_CC_pos+L_neg+L_sep+L_neg', 'Battery cell thickness');
model.param.set('Q_cell', 'L_pos*cs_max_pos*eps_s_pos*F_const*socwindowpos', 'Cell capacity');
model.param.set('A_cell', 'Vol*Jelly_vol/L_batt', 'Battery cell area');
model.param.set('Q_batt', '(Q_cell*A_cell/3600[C])', 'Battery capacity');
model.param.set('I_1C', 'Q_cell/(3600[s])', '1C cell current density');
model.param.set('Q_batt_Ah', 'I_1C*A_cell[1/A]', 'Battery capacity (in Ah)');
model.param.set('SOC_upper', '0.75', 'Upper SOC limit during cycling');
model.param.set('SOC_lower', '0.25', 'Lower SOC limit during cycling');
model.param.set('SOC_window', 'SOC_upper-SOC_lower', 'SOC cycling window');
model.param.set('SpecifyTime', '1', 'Specify charging rate based on time (1=yes, 0= no)');
model.param.set('t_charge_set', '20[min]', 'Charge time');
model.param.set('t_discharge_set', '3[h]', 'Discharge time');
model.param.set('C_rate_charge_set', '1', 'Charging C rate');
model.param.set('C_rate_discharge_set', '1', 'Discharging C rate');
model.param.set('C_rate_charge', 'if(SpecifyTime, 3600[s]*SOC_window/t_charge_set, C_rate_charge_set)', 'Charging C rate');
model.param.set('C_rate_discharge', 'if(SpecifyTime, 3600[s]*SOC_window/t_discharge_set, C_rate_discharge_set)', 'Discharging C rate');
model.param.set('t_charge', 'if(SpecifyTime, (t_charge_set), 3600*SOC_window/C_rate_charge_set)', 'Charge time');
model.param.set('t_discharge', 'if(SpecifyTime, t_discharge_set, 3600*SOC_window/C_rate_discharge_set)', 'Discharge time');
model.param.set('cs_pos_init', 'cs_max_pos*(socminpos+(1-SOC_lower)*(socwindowpos))', 'Initial positive solid lithium concentration');
model.param.set('cs_neg_init', 'cs_max_neg*(socminneg+SOC_lower*(socwindowneg))', 'Initial negative solid lithium concentration');
model.param.set('i_app_charge', 'I_1C*C_rate_charge', 'Applied cell current density, charging');
model.param.set('i_app_discharge', '-I_1C*C_rate_discharge', 'Applied cell current density, discharging');
model.param.set('Q_cycle', 'Q_batt*SOC_window', 'Capacity thruput per cycle');
model.param.set('Max_cell_voltage', '4.5[V]', 'Maximum operational cell voltage');
model.param.set('Min_cell_voltage', '2.0[V]', 'Minimum operational cell voltage');
model.param.set('T0', '20[degC]', 'Ambient temperature');
model.param.set('A_batt_18650', '(18[mm]/2)^2*pi*2+18[mm]*pi*65[mm]', 'Battery area, exposed for cooling');
model.param.set('k_batt', '10[W/m^2/K]', 'Heat transfer coefficient');
model.param.set('Cp_batt', '1400[J/kg/K]', 'Battery average heat capacity');
model.param.set('rho_batt', '2000[kg/m^3]', 'Battery average density');
model.param.set('Vmax', '4.5[V]', 'Maximum voltage');
model.param.set('Vmin', '2.1[V]', 'Minimum voltage');
model.param.set('A_batt_21700', '(21[mm]/2)^2*pi*2+21[mm]*pi*70[mm]', 'Battery area, exposed for cooling');
model.param.set('d_batt', '18[mm]', 'Diameter of battery');
model.param.set('L_man', '65[mm]', 'Mandrel Length');
model.param.set('A_batt', 'if(batt_cylindrical, (d_batt/2)^2*pi*2+d_batt*pi*L_man, 2*(L_p_man*W_man))', 'Battery area, exposed for cooling');
model.param.set('Vol_21700', '(21[mm]/2)^2*pi*70[mm]', 'Battery volume');
model.param.set('Vol', 'if(batt_cylindrical,(d_batt/2)^2*pi*L_man,vol_prism)', 'Battery volume');
model.param.set('batt_cylindrical', '1', 'Spherical battery');
model.param.set('vol_prism', 'L_p_man*W_man*depth_man');
model.param.set('W_man', '50[mm]', 'Width of mandrel');
model.param.set('depth_man', '5[mm]', 'Depth of mandrel');
model.param.set('L_p_man', '65[mm]', 'Length of mandrel - prismatic');
model.param.set('Q_vol', 'cs_max_pos*(1-socminpos)*F_const', 'Volumetric capacity of positive electrode material');
model.param.set('Q_vol_Ah', 'Q_vol/3600[C]', 'Volumetric capacity of positive electrode material in Ah');
model.param.set('L_neg_um', 'L_neg*1e6');
model.param.set('t_tot', 't_charge+t_discharge', 'Total time for each cycle');
model.param.set('Yhost_neg', '(1+Q_excess)/(1-socminneg)', 'Amount of negative host material in relation to cell capacity');
model.param.set('socminneg', '0.025', 'Lithiation level in negative electrode at 100% cell SOC');
model.param.set('socwindowneg', '1/Yhost_neg', 'Lithiation level change in negative electrode between 0 and 100% cell SOC');
model.param.set('Yhost_pos', '(1+Yhost_neg*(Li_loss+socminneg))/(1-socminpos)', 'Amount of positive host material in relation to cell capacity');
model.param.set('socwindowpos', '1/Yhost_pos', 'Lithiation level change in positive electrode between 100 and 0% cell SOC');

model.geom('geom1').create('i1', 'Interval');
model.geom('geom1').feature('i1').set('specify', 'len');
model.geom('geom1').feature('i1').setIndex('len', 'L_neg', 0);
model.geom('geom1').feature('i1').setIndex('len', 'L_sep', 1);
model.geom('geom1').feature('i1').setIndex('len', 'L_pos', 2);
model.geom('geom1').run('i1');

model.material.create('mat1', 'Common', '');
model.material('mat1').propertyGroup.create('ElectrodePotential', 'Equilibrium potential');
model.material('mat1').propertyGroup('ElectrodePotential').func.create('int1', 'Interpolation');
model.material('mat1').propertyGroup.create('OperationalSOC', 'Operational electrode state of charge');
model.material('mat1').propertyGroup.create('ic', 'Intercalation strain');
model.material('mat1').propertyGroup('ic').func.create('int1', 'Interpolation');
model.material('mat1').propertyGroup.create('EquilibriumConcentration', 'Equilibrium concentration');
model.material('mat1').label('NMC 111, LiNi0.33Mn0.33Co0.33O2 (Positive, Li-ion Battery)');
model.material('mat1').propertyGroup('def').set('poissonsratio', '');
model.material('mat1').propertyGroup('def').set('youngsmodulus', '');
model.material('mat1').propertyGroup('def').set('thermalconductivity', '');
model.material('mat1').propertyGroup('def').set('thermalexpansioncoefficient', '');
model.material('mat1').propertyGroup('def').set('poissonsratio', '0.25');
model.material('mat1').propertyGroup('def').set('INFO_PREFIX:poissonsratio', ['Mechanical and physical properties of LiNi0.33Mn0.33Co0.33O2 (NMC),' newline 'E Chenga, K. Hong, N. Taylor, H. Choe,' newline 'J. Wolfenstinec, J. Sakamotoa,' newline 'Journal of the European Ceramic Society 37 (2017) 3213' native2unicode(hex2dec({'20' '13'}), 'unicode') '3217']);
model.material('mat1').propertyGroup('def').set('youngsmodulus', '78[GPa]');
model.material('mat1').propertyGroup('def').set('INFO_PREFIX:youngsmodulus', ['Mechanical and physical properties of LiNi0.33Mn0.33Co0.33O2 (NMC),' newline 'E Chenga, K. Hong, N. Taylor, H. Choe,' newline 'J. Wolfenstinec, J. Sakamotoa,' newline 'Journal of the European Ceramic Society 37 (2017) 3213' native2unicode(hex2dec({'20' '13'}), 'unicode') '3217']);
model.material('mat1').propertyGroup('def').set('thermalconductivity', {'3.6[W/(m*K)]' '0' '0' '0' '3.6[W/(m*K)]' '0' '0' '0' '3.6[W/(m*K)]'});
model.material('mat1').propertyGroup('def').set('INFO_PREFIX:thermalconductivity', ['Mechanical and physical properties of LiNi0.33Mn0.33Co0.33O2 (NMC),' newline 'E Chenga, K. Hong, N. Taylor, H. Choe,' newline 'J. Wolfenstinec, J. Sakamotoa,' newline 'Journal of the European Ceramic Society 37 (2017) 3213' native2unicode(hex2dec({'20' '13'}), 'unicode') '3217']);
model.material('mat1').propertyGroup('def').set('thermalexpansioncoefficient', {'1.2e-5[1/K]' '0' '0' '0' '1.2e-5[1/K]' '0' '0' '0' '1.2e-5[1/K]'});
model.material('mat1').propertyGroup('def').set('INFO_PREFIX:thermalexpansioncoefficient', ['Mechanical and physical properties of LiNi0.33Mn0.33Co0.33O2 (NMC),' newline 'E Chenga, K. Hong, N. Taylor, H. Choe,' newline 'J. Wolfenstinec, J. Sakamotoa,' newline 'Journal of the European Ceramic Society 37 (2017) 3213' native2unicode(hex2dec({'20' '13'}), 'unicode') '3217']);
model.material('mat1').propertyGroup('def').set('diffusion', {'1e-14[m^2/s]' '0' '0' '0' '1e-14[m^2/s]' '0' '0' '0' '1e-14[m^2/s]'});
model.material('mat1').propertyGroup('def').set('INFO_PREFIX:diffusion', 'Jing Ying Ko et al, J. Electrochem. Soc., 166, A2939');
model.material('mat1').propertyGroup('def').set('electricconductivity', {'100[S/m]' '0' '0' '0' '100[S/m]' '0' '0' '0' '100[S/m]'});
model.material('mat1').propertyGroup('def').set('csmax', '49000[mol/m^3]');
model.material('mat1').propertyGroup('def').descr('csmax', '');
model.material('mat1').propertyGroup('ElectrodePotential').func('int1').set('funcname', 'Eeq_int1');
model.material('mat1').propertyGroup('ElectrodePotential').func('int1').set('table', {'0' '4.44';  ...
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
model.material('mat1').propertyGroup('ElectrodePotential').func('int1').set('interp', 'piecewisecubic');
model.material('mat1').propertyGroup('ElectrodePotential').func('int1').set('extrap', 'linear');
model.material('mat1').propertyGroup('ElectrodePotential').func('int1').set('fununit', {'V'});
model.material('mat1').propertyGroup('ElectrodePotential').func('int1').set('argunit', {''});
model.material('mat1').propertyGroup('ElectrodePotential').func('int1').set('defineinv', true);
model.material('mat1').propertyGroup('ElectrodePotential').func('int1').set('funcinvname', 'Eeq_inv');
model.material('mat1').propertyGroup('ElectrodePotential').set('Eeq', 'Eeq_int1(soc)+dEeqdT*(T-298[K])');
model.material('mat1').propertyGroup('ElectrodePotential').set('INFO_PREFIX:Eeq', 'W. Zheng, M. Shui, J. Shu, S. Gao, D. Xu, L. Chen, L. Feng and Y. Ren, " GITT studies on oxide cathode LiNi1/3Co1/3Mn1/3O2 synthesized by citric acid assisted high-energy ball milling", Bull. Mater. Sci., vol. 36, p. A495, 2013');
model.material('mat1').propertyGroup('ElectrodePotential').set('dEeqdT', '-10[J/mol/K]/F_const');
model.material('mat1').propertyGroup('ElectrodePotential').set('INFO_PREFIX:dEeqdT', 'V Viswanathan, D Choi, D Wang, W Xu, S Towne, R Williford, JG Zhang, J Liu and Z Yang "Effect of entropy change on lithium intercalation in cathodes and anodes on Li-ion battery thermal management", Journal of Power Sources 195 (2010) 3720-3729');
model.material('mat1').propertyGroup('ElectrodePotential').set('cEeqref', 'def.csmax');
model.material('mat1').propertyGroup('ElectrodePotential').set('INFO_PREFIX:cEeqref', 'W. Zheng, M. Shui, J. Shu, S. Gao, D. Xu, L. Chen, L. Feng and Y. Ren, " GITT studies on oxide cathode LiNi1/3Co1/3Mn1/3O2 synthesized by citric acid assisted high-energy ball milling", Bull. Mater. Sci., vol. 36, p. A495, 2013');
model.material('mat1').propertyGroup('ElectrodePotential').set('soc', 'c/cEeqref');
model.material('mat1').propertyGroup('ElectrodePotential').descr('soc', '');
model.material('mat1').propertyGroup('ElectrodePotential').addInput('concentration');
model.material('mat1').propertyGroup('ElectrodePotential').addInput('temperature');
model.material('mat1').propertyGroup('OperationalSOC').set('socmax', 'elpot.Eeq_inv(E_min)');
model.material('mat1').propertyGroup('OperationalSOC').set('socmin', 'elpot.Eeq_inv(E_max)');
model.material('mat1').propertyGroup('OperationalSOC').set('E_max', '4.4[V]');
model.material('mat1').propertyGroup('OperationalSOC').set('E_min', '3.3[V]');
model.material('mat1').propertyGroup('ic').func('int1').set('funcname', 'dVOLdSOL');
model.material('mat1').propertyGroup('ic').func('int1').set('table', {'1' '0';  ...
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
model.material('mat1').propertyGroup('ic').func('int1').set('extrap', 'linear');
model.material('mat1').propertyGroup('ic').func('int1').set('fununit', {'%'});
model.material('mat1').propertyGroup('ic').func('int1').set('argunit', {'1'});
model.material('mat1').propertyGroup('ic').set('dvol', 'dVOLdSOL(c/elpot.cEeqref)');
model.material('mat1').propertyGroup('ic').set('INFO_PREFIX:dvol', ['R. Koerver and others, ' native2unicode(hex2dec({'20' '1c'}), 'unicode') 'Chemo-mechanical expansion of lithium electrode materials ' native2unicode(hex2dec({'20' '14'}), 'unicode') ' on the route to mechanically optimized all-solid-state batteries,' native2unicode(hex2dec({'20' '1d'}), 'unicode') ' Energy Environ. Sci., vol. 11, pp. 2142' native2unicode(hex2dec({'20' '13'}), 'unicode') '2158, 201']);
model.material('mat1').propertyGroup('ic').addInput('concentration');
model.material('mat1').propertyGroup('EquilibriumConcentration').set('csEq', 'def.csmax*elpot.Eeq_inv(V)');
model.material('mat1').propertyGroup('EquilibriumConcentration').addInput('electricpotential');
model.material.create('mat2', 'Common', '');
model.material('mat2').propertyGroup.create('ElectrodePotential', 'Equilibrium potential');
model.material('mat2').propertyGroup('ElectrodePotential').func.create('int1', 'Interpolation');
model.material('mat2').propertyGroup('ElectrodePotential').func.create('int2', 'Interpolation');
model.material('mat2').propertyGroup.create('OperationalSOC', 'Operational electrode state of charge');
model.material('mat2').propertyGroup.create('ic', 'Intercalation strain');
model.material('mat2').propertyGroup('ic').func.create('int1', 'Interpolation');
model.material('mat2').propertyGroup.create('EquilibriumConcentration', 'Equilibrium concentration');
model.material('mat2').label('NMC 811, LiNi0.8Mn0.1Co0.1O2 (Positive, Li-ion Battery)');
model.material('mat2').propertyGroup('def').set('electricconductivity', {'0.17[S/m]' '0' '0' '0' '0.17[S/m]' '0' '0' '0' '0.17[S/m]'});
model.material('mat2').propertyGroup('def').set('INFO_PREFIX:electricconductivity', ['Sturm, Rheinfeld, Zilberman, Spingler, Kosch, Frie and Jossen, "Modeling and simulation of inhomogeneities in a 18650 nickel-rich, silicon-graphite lithium-ion cell during fast charging", Journal of Power Sources 412 (2019) 204' native2unicode(hex2dec({'20' '13'}), 'unicode') '223']);
model.material('mat2').propertyGroup('def').set('diffusion', {'5e-13*exp(1200*(1/(T_ref/1[K])-1/(T2/1[K])))[m^2/s]' '0' '0' '0' '5e-13*exp(1200*(1/(T_ref/1[K])-1/(T2/1[K])))[m^2/s]' '0' '0' '0' '5e-13*exp(1200*(1/(T_ref/1[K])-1/(T2/1[K])))[m^2/s]'});
model.material('mat2').propertyGroup('def').set('INFO_PREFIX:diffusion', ['Sturm, Rheinfeld, Zilberman, Spingler, Kosch, Frie and Jossen, "Modeling and simulation of inhomogeneities in a 18650 nickel-rich, silicon-graphite lithium-ion cell during fast charging", Journal of Power Sources 412 (2019) 204' native2unicode(hex2dec({'20' '13'}), 'unicode') '223']);
model.material('mat2').propertyGroup('def').set('thermalconductivity', {'1.58[W/(m*K)]' '0' '0' '0' '1.58[W/(m*K)]' '0' '0' '0' '1.58[W/(m*K)]'});
model.material('mat2').propertyGroup('def').set('INFO_PREFIX:thermalconductivity', ['Sturm, Rheinfeld, Zilberman, Spingler, Kosch, Frie and Jossen, "Modeling and simulation of inhomogeneities in a 18650 nickel-rich, silicon-graphite lithium-ion cell during fast charging", Journal of Power Sources 412 (2019) 204' native2unicode(hex2dec({'20' '13'}), 'unicode') '223']);
model.material('mat2').propertyGroup('def').set('heatcapacity', '840.1[J/(kg*K)]');
model.material('mat2').propertyGroup('def').set('INFO_PREFIX:heatcapacity', ['Sturm, Rheinfeld, Zilberman, Spingler, Kosch, Frie and Jossen, "Modeling and simulation of inhomogeneities in a 18650 nickel-rich, silicon-graphite lithium-ion cell during fast charging", Journal of Power Sources 412 (2019) 204' native2unicode(hex2dec({'20' '13'}), 'unicode') '223']);
model.material('mat2').propertyGroup('def').set('density', '4.87[g/cm^3]');
model.material('mat2').propertyGroup('def').set('INFO_PREFIX:density', ['Sturm, Rheinfeld, Zilberman, Spingler, Kosch, Frie and Jossen, "Modeling and simulation of inhomogeneities in a 18650 nickel-rich, silicon-graphite lithium-ion cell during fast charging", Journal of Power Sources 412 (2019) 204' native2unicode(hex2dec({'20' '13'}), 'unicode') '223']);
model.material('mat2').propertyGroup('def').set('csmax', '50060[mol/m^3]');
model.material('mat2').propertyGroup('def').descr('csmax', '');
model.material('mat2').propertyGroup('def').set('T_ref', '298[K]');
model.material('mat2').propertyGroup('def').descr('T_ref', '');
model.material('mat2').propertyGroup('def').set('T2', 'min(393.15,max(T,223.15))');
model.material('mat2').propertyGroup('def').descr('T2', '');
model.material('mat2').propertyGroup('def').addInput('temperature');
model.material('mat2').propertyGroup('ElectrodePotential').func('int1').set('funcname', 'Eeq_int1');
model.material('mat2').propertyGroup('ElectrodePotential').func('int1').set('table', {'0.2228930343076256' '4.256817954840526';  ...
'0.23718770939025557' '4.2212385803217725';  ...
'0.2503742701253948' '4.198216215024365';  ...
'0.2635608308605341' '4.184354581468334';  ...
'0.2767473915956734' '4.175555457558853';  ...
'0.28993395233081265' '4.169287588472648';  ...
'0.3031205130659519' '4.163501863162304';  ...
'0.3163070738010912' '4.156631314356272';  ...
'0.3294936345362305' '4.145300935623516';  ...
'0.3426801952713697' '4.130836622347658';  ...
'0.355866756006509' '4.113841054248525';  ...
'0.3690533167416483' '4.09395262349422';  ...
'0.38223987747678756' '4.0746668724597415';  ...
'0.3954264382119268' '4.056104337089057';  ...
'0.4086129989470661' '4.037903409550268';  ...
'0.4217995596822054' '4.021944450569238';  ...
'0.43498612041734463' '4.007287279783036';  ...
'0.44817268115248393' '3.9945104697226936';  ...
'0.4613592418876232' '3.9798050845589046';  ...
'0.47454580262276247' '3.96497916345115';  ...
'0.4877323633579017' '3.9507559220632222';  ...
'0.500918924093041' '3.9348451774597786';  ...
'0.5141054848281803' '3.918090681248576';  ...
'0.5272920455633195' '3.901215649093408';  ...
'0.5404786062984588' '3.884581688826171';  ...
'0.5536651670335981' '3.8661396893994517';  ...
'0.5668517277687374' '3.850108408852042';  ...
'0.5800382885038766' '3.834920879912391';  ...
'0.593224849239016' '3.819612815028774';  ...
'0.6064114099741551' '3.806233325248605';  ...
'0.6195979707092945' '3.795023482459815';  ...
'0.6327845314444338' '3.7852600709986106';  ...
'0.6459710921795729' '3.77646094708913';  ...
'0.6591576529147123' '3.7660948559080984';  ...
'0.6723442136498515' '3.7569341241667216';  ...
'0.6855307743849908' '3.748376072145172';  ...
'0.6987173351201301' '3.7407823076753464';  ...
'0.7119038958552694' '3.7321037197098312';  ...
'0.7250904565904086' '3.724148347408109';  ...
'0.738277017325548' '3.7154697594425943';  ...
'0.7514635780606872' '3.7046215244857006';  ...
'0.7646501387958264' '3.69582240057622';  ...
'0.7778366995309657' '3.686541132890878';  ...
'0.791023260266105' '3.6770187933176044';  ...
'0.8042098210012443' '3.6672553818564';  ...
'0.8173963817363835' '3.6556839312357132';  ...
'0.8305829424715228' '3.643871408727096';  ...
'0.8437695032066621' '3.633505317546064';  ...
'0.8569560639418013' '3.6226570825891704';  ...
'0.8701426246769406' '3.6130142070719313';  ...
'0.8833291854120799' '3.603009723722796';  ...
'0.8965157461472192' '3.592643632541764';  ...
'0.9097023068823584' '3.585049868071939';  ...
'0.9228888676174977' '3.5790230708736646';  ...
'0.9351335311572699' '3.5724538619275457';  ...
'0.9505178520149323' '3.5661257248693574';  ...
'0.9624485498229155' '3.559857855783152';  ...
'0.9756351105580549' '3.5525051632012574';  ...
'0.9888216712931941' '3.541536392300398';  ...
'0.998240643246865' '3.488540755603573';  ...
'0.9994965061740211' '3.3640592684056174';  ...
'1' '3.0'});
model.material('mat2').propertyGroup('ElectrodePotential').func('int1').set('interp', 'piecewisecubic');
model.material('mat2').propertyGroup('ElectrodePotential').func('int1').set('extrap', 'linear');
model.material('mat2').propertyGroup('ElectrodePotential').func('int1').set('fununit', {'V'});
model.material('mat2').propertyGroup('ElectrodePotential').func('int1').set('argunit', {''});
model.material('mat2').propertyGroup('ElectrodePotential').func('int1').set('defineinv', true);
model.material('mat2').propertyGroup('ElectrodePotential').func('int1').set('funcinvname', 'Eeq_inv');
model.material('mat2').propertyGroup('ElectrodePotential').func('int2').set('funcname', 'dEeqdT_int1');
model.material('mat2').propertyGroup('ElectrodePotential').func('int2').set('table', {'0.220410330184718' '0.014014955374719168';  ...
'0.23880574126341392' '0.017971951837248937';  ...
'0.2546142976591682' '0.024888006339594898';  ...
'0.27162047196369177' '0.034054905194386115';  ...
'0.282638556724369' '0.036404922469418094';  ...
'0.3020399668464311' '0.026993759520293023';  ...
'0.3142556695158776' '0.020431501191878212';  ...
'0.33365707963793967' '0.011727335839959649';  ...
'0.35521420199578646' '0.0148088719318831';  ...
'0.3681484754104945' '0.017914441947786144';  ...
'0.3861127440420335' '0.021513559747933717';  ...
'0.40838843714514184' '0.01892213947907556';  ...
'0.4213227105598499' '0.01702025282904991';  ...
'0.43856840844612727' '0.013603757832495345';  ...
'0.46156267229449716' '0.005230230696620208';  ...
'0.47449694570920525' '-0.0006265898806357695';  ...
'0.49389835583126734' '-0.007070755018626973';  ...
'0.5161740489343756' '-0.004108523109428802';  ...
'0.5291083223490838' '-0.001082689664639258';  ...
'0.5463540202353612' '0.002312976397604097';  ...
'0.569348284083731' '0.004079283221664273';  ...
'0.582282557498439' '0.004952229246388926';  ...
'0.6009653968752395' '0.004819533211418328';  ...
'0.6239596607236095' '-0.006710676178650704';  ...
'0.6368939341383175' '-0.014536990062410493';  ...
'0.6541396320245949' '-0.02419065684384447';  ...
'0.6771338958729649' '-0.029277265326040275';  ...
'0.6900681692876729' '-0.031219020261622682';  ...
'0.7073138671739503' '-0.033690193909531485';  ...
'0.7303081310223203' '-0.03336889094642845';  ...
'0.7432424044370283' '-0.032113209380358915';  ...
'0.7619252438138289' '-0.03159295149409996';  ...
'0.7849195076621986' '-0.03042821280099617';  ...
'0.7971352103316451' '-0.02983057002436801';  ...
'0.8150994789631842' '-0.02874483754190857';  ...
'0.838093742811554' '-0.024193952462184226';  ...
'0.851028016226262' '-0.02144719701629197';  ...
'0.8689922848578011' '-0.01850371317212532';  ...
'0.8898308364703862' '-0.024913854049501444';  ...
'0.9027651098850944' '-0.030147134640649775';  ...
'0.922885090752418' '-0.038671237648857465';  ...
'0.9430050716197416' '-0.05040518062533475';  ...
'0.958813628015496' '-0.06017799045704739';  ...
'0.9758198023200195' '-0.07034189432587595';  ...
'0.983245033354389' '-0.07341413831343596'});
model.material('mat2').propertyGroup('ElectrodePotential').func('int2').set('fununit', {'mV/K'});
model.material('mat2').propertyGroup('ElectrodePotential').func('int2').set('argunit', {''});
model.material('mat2').propertyGroup('ElectrodePotential').set('Eeq', 'Eeq_int1(soc)+dEeqdT_int1(soc)*(T-298[K])');
model.material('mat2').propertyGroup('ElectrodePotential').set('INFO_PREFIX:Eeq', ['Sturm, Rheinfeld, Zilberman, Spingler, Kosch, Frie and Jossen, "Modeling and simulation of inhomogeneities in a 18650 nickel-rich, silicon-graphite lithium-ion cell during fast charging", Journal of Power Sources 412 (2019) 204' native2unicode(hex2dec({'20' '13'}), 'unicode') '223']);
model.material('mat2').propertyGroup('ElectrodePotential').set('dEeqdT', 'dEeqdT_int1(soc)');
model.material('mat2').propertyGroup('ElectrodePotential').set('INFO_PREFIX:dEeqdT', ['Sturm, Rheinfeld, Zilberman, Spingler, Kosch, Frie and Jossen, "Modeling and simulation of inhomogeneities in a 18650 nickel-rich, silicon-graphite lithium-ion cell during fast charging", Journal of Power Sources 412 (2019) 204' native2unicode(hex2dec({'20' '13'}), 'unicode') '223']);
model.material('mat2').propertyGroup('ElectrodePotential').set('cEeqref', 'def.csmax');
model.material('mat2').propertyGroup('ElectrodePotential').set('soc', 'c/cEeqref');
model.material('mat2').propertyGroup('ElectrodePotential').descr('soc', '');
model.material('mat2').propertyGroup('ElectrodePotential').addInput('concentration');
model.material('mat2').propertyGroup('ElectrodePotential').addInput('temperature');
model.material('mat2').propertyGroup('OperationalSOC').set('socmax', 'elpot.Eeq_inv(E_min)');
model.material('mat2').propertyGroup('OperationalSOC').set('socmin', 'elpot.Eeq_inv(E_max)');
model.material('mat2').propertyGroup('OperationalSOC').set('E_max', '4.25[V]');
model.material('mat2').propertyGroup('OperationalSOC').set('E_min', '3.5[V]');
model.material('mat2').propertyGroup('ic').func('int1').set('funcname', 'dVOLdSOL');
model.material('mat2').propertyGroup('ic').func('int1').set('table', {'1' '0';  ...
'0.8878314072059823' '-0.01908801696712681';  ...
'0.8558803535010198' '-0.09544008483563182';  ...
'0.8273283480625425' '-0.19724284199363806';  ...
'0.7919782460910945' '-0.2905620360551433';  ...
'0.7627464309993202' '-0.3584305408271482';  ...
'0.7321549966009517' '-0.42629904559915177';  ...
'0.7042828008157715' '-0.5026511134676568';  ...
'0.6709721278042148' '-0.5705196182396608';  ...
'0.6349422161794698' '-0.6383881230116648';  ...
'0.6084296397008837' '-0.7147401908801698';  ...
'0.5791978246091094' '-0.8335100742311776';  ...
'0.5506458191706322' '-0.9862142099681872';  ...
'0.5193745751189666' '-1.1049840933191946';  ...
'0.4894629503738953' '-1.2067868504772008';  ...
'0.45955132562882384' '-1.3425238600212097';  ...
'0.42556084296397' '-1.51219512195122';  ...
'0.39700883752549276' '-1.6818663838812302';  ...
'0.36573759347382717' '-1.8515376458112414';  ...
'0.3358259687287558' '-2.106044538706257';  ...
'0.3099932019034669' '-2.496288441145281';  ...
'0.27464309993201896' '-3.1240721102863205';  ...
'0.2447314751869476' '-3.921527041357371';  ...
'0.213460231135282' '-4.820784729586427';  ...
'0.18218898708361642' '-5.669141039236479';  ...
'0.15091774303195082' '-6.534464475079533'});
model.material('mat2').propertyGroup('ic').func('int1').set('extrap', 'linear');
model.material('mat2').propertyGroup('ic').func('int1').set('fununit', {'%'});
model.material('mat2').propertyGroup('ic').func('int1').set('argunit', {'1'});
model.material('mat2').propertyGroup('ic').set('dvol', 'dVOLdSOL(c/elpot.cEeqref)');
model.material('mat2').propertyGroup('ic').set('INFO_PREFIX:dvol', ['R. Koerver and others, ' native2unicode(hex2dec({'20' '1c'}), 'unicode') 'Chemo-mechanical expansion of lithium electrode materials ' native2unicode(hex2dec({'20' '14'}), 'unicode') ' on the route to mechanically optimized all-solid-state batteries,' native2unicode(hex2dec({'20' '1d'}), 'unicode') ' Energy Environ. Sci., vol. 11, pp. 2142' native2unicode(hex2dec({'20' '13'}), 'unicode') '2158, 201']);
model.material('mat2').propertyGroup('ic').addInput('concentration');
model.material('mat2').propertyGroup('EquilibriumConcentration').set('csEq', 'def.csmax*elpot.Eeq_inv(V)');
model.material('mat2').propertyGroup('EquilibriumConcentration').addInput('electricpotential');
model.material.create('mat3', 'Common', '');
model.material('mat3').propertyGroup.create('ElectrodePotential', 'Equilibrium potential');
model.material('mat3').propertyGroup('ElectrodePotential').func.create('int1', 'Interpolation');
model.material('mat3').propertyGroup('ElectrodePotential').func.create('int2', 'Interpolation');
model.material('mat3').propertyGroup.create('OperationalSOC', 'Operational electrode state of charge');
model.material('mat3').propertyGroup.create('ic', 'Intercalation strain');
model.material('mat3').propertyGroup.create('EquilibriumConcentration', 'Equilibrium concentration');
model.material('mat3').label('LFP, LiFePO4 (Positive, Li-ion Battery)');
model.material('mat3').propertyGroup('def').set('poissonsratio', '');
model.material('mat3').propertyGroup('def').set('youngsmodulus', '');
model.material('mat3').propertyGroup('def').set('poissonsratio', '0.3');
model.material('mat3').propertyGroup('def').set('INFO_PREFIX:poissonsratio', ['T. Maxisch and G. Ceder, Elastic properties of olivine LixFePO4 from first principles, Physical Review B 73, 174112, 2006' newline ]);
model.material('mat3').propertyGroup('def').set('youngsmodulus', '117.8[GPa]');
model.material('mat3').propertyGroup('def').set('INFO_PREFIX:youngsmodulus', 'T. Maxisch and G. Ceder, Elastic properties of olivine LixFePO4 from first principles, Physical Review B 73, 174112, 2006');
model.material('mat3').propertyGroup('def').set('diffusion', {'3.2e-13[m^2/s]' '0' '0' '0' '3.2e-13[m^2/s]' '0' '0' '0' '3.2e-13[m^2/s]'});
model.material('mat3').propertyGroup('def').set('INFO_PREFIX:diffusion', 'U. S. Kasavajjula, C. Wang, and P. E. Arce, "Discharge Model for LiFePO4 Accounting for the Solid Solution Range", J. Electrochemical Soc., vol. 155, p. A866, 2008');
model.material('mat3').propertyGroup('def').set('electricconductivity', {'91[S/m]' '0' '0' '0' '91[S/m]' '0' '0' '0' '91[S/m]'});
model.material('mat3').propertyGroup('def').set('INFO_PREFIX:electricconductivity', 'U. S. Kasavajjula, C. Wang, and P. E. Arce, "Discharge Model for LiFePO4 Accounting for the Solid Solution Range", J. Electrochemical Soc., vol. 155, p. A866, 2008');
model.material('mat3').propertyGroup('def').set('thermalconductivity', {'1[W/(m*K)]' '0' '0' '0' '1[W/(m*K)]' '0' '0' '0' '1[W/(m*K)]'});
model.material('mat3').propertyGroup('def').set('INFO_PREFIX:thermalconductivity', 'R. E. Gerver and J. P. Meyers, "Three-Dimensional Modeling of Electrochemical Performance and Heat Generation of Lithium-Ion Betteries in Tabbed Planar Configurations", J. Electrochemical Soc., vol. 158, p. A835, 2011');
model.material('mat3').propertyGroup('def').set('heatcapacity', '881[J/(kg*K)]');
model.material('mat3').propertyGroup('def').set('INFO_PREFIX:heatcapacity', 'R. E. Gerver and J. P. Meyers, "Three-Dimensional Modeling of Electrochemical Performance and Heat Generation of Lithium-Ion Betteries in Tabbed Planar Configurations", J. Electrochemical Soc., vol. 158, p. A835, 2011');
model.material('mat3').propertyGroup('def').set('density', '3600[kg/m^3]');
model.material('mat3').propertyGroup('def').set('INFO_PREFIX:density', 'N. Nitta, F. Wu, J. Tae Lee, and G. Yushin, Materials Today, Volume 18, Number 5, June 2015');
model.material('mat3').propertyGroup('def').set('csmax', '21190[mol/m^3]');
model.material('mat3').propertyGroup('def').descr('csmax', '');
model.material('mat3').propertyGroup('ElectrodePotential').func('int1').set('funcname', 'Eeq_int1');
model.material('mat3').propertyGroup('ElectrodePotential').func('int1').set('table', {'0.01' '3.538446291';  ...
'0.02' '3.430533';  ...
'0.03' '3.424694609';  ...
'0.04' '3.424504348';  ...
'0.05' '3.424500072';  ...
'0.06' '3.424500001';  ...
'0.07' '3.4245';  ...
'0.08' '3.4245';  ...
'0.09' '3.4245';  ...
'0.1' '3.4245';  ...
'0.11' '3.4245';  ...
'0.12' '3.4245';  ...
'0.13' '3.4245';  ...
'0.14' '3.4245';  ...
'0.15' '3.4245';  ...
'0.16' '3.4245';  ...
'0.17' '3.4245';  ...
'0.18' '3.4245';  ...
'0.19' '3.4245';  ...
'0.2' '3.4245';  ...
'0.21' '3.4245';  ...
'0.22' '3.4245';  ...
'0.23' '3.4245';  ...
'0.24' '3.4245';  ...
'0.25' '3.4245';  ...
'0.26' '3.4245';  ...
'0.27' '3.4245';  ...
'0.28' '3.4245';  ...
'0.29' '3.4245';  ...
'0.3' '3.4245';  ...
'0.31' '3.4245';  ...
'0.32' '3.4245';  ...
'0.33' '3.4245';  ...
'0.34' '3.4245';  ...
'0.35' '3.4245';  ...
'0.36' '3.4245';  ...
'0.37' '3.4245';  ...
'0.38' '3.4245';  ...
'0.39' '3.4245';  ...
'0.4' '3.4245';  ...
'0.41' '3.4245';  ...
'0.42' '3.4245';  ...
'0.43' '3.4245';  ...
'0.44' '3.4245';  ...
'0.45' '3.4245';  ...
'0.46' '3.4245';  ...
'0.47' '3.4245';  ...
'0.48' '3.4245';  ...
'0.49' '3.4245';  ...
'0.5' '3.4245';  ...
'0.51' '3.4245';  ...
'0.52' '3.4245';  ...
'0.53' '3.4245';  ...
'0.54' '3.4245';  ...
'0.55' '3.4245';  ...
'0.56' '3.4245';  ...
'0.57' '3.4245';  ...
'0.58' '3.4245';  ...
'0.59' '3.4245';  ...
'0.6' '3.4245';  ...
'0.61' '3.4245';  ...
'0.62' '3.4245';  ...
'0.63' '3.4245';  ...
'0.64' '3.4245';  ...
'0.65' '3.4245';  ...
'0.66' '3.4245';  ...
'0.67' '3.4245';  ...
'0.68' '3.4245';  ...
'0.69' '3.4245';  ...
'0.7' '3.4245';  ...
'0.71' '3.4245';  ...
'0.72' '3.4245';  ...
'0.73' '3.4245';  ...
'0.74' '3.4245';  ...
'0.75' '3.4245';  ...
'0.76' '3.4245';  ...
'0.77' '3.4245';  ...
'0.78' '3.4245';  ...
'0.79' '3.4245';  ...
'0.8' '3.424499996';  ...
'0.81' '3.424499875';  ...
'0.82' '3.424497592';  ...
'0.83' '3.424471778';  ...
'0.84' '3.424279811';  ...
'0.85' '3.423272375';  ...
'0.86' '3.419316956';  ...
'0.87' '3.407123221';  ...
'0.88' '3.376401149';  ...
'0.89' '3.311000755';  ...
'0.9' '3.190071347'});
model.material('mat3').propertyGroup('ElectrodePotential').func('int1').set('interp', 'piecewisecubic');
model.material('mat3').propertyGroup('ElectrodePotential').func('int1').set('extrap', 'linear');
model.material('mat3').propertyGroup('ElectrodePotential').func('int1').set('fununit', {'V'});
model.material('mat3').propertyGroup('ElectrodePotential').func('int1').set('argunit', {''});
model.material('mat3').propertyGroup('ElectrodePotential').func('int1').set('defineinv', true);
model.material('mat3').propertyGroup('ElectrodePotential').func('int1').set('funcinvname', 'Eeq_inv');
model.material('mat3').propertyGroup('ElectrodePotential').func('int2').set('funcname', 'dEeqdT_int1');
model.material('mat3').propertyGroup('ElectrodePotential').func('int2').set('table', {'0.01' '8.62369E-06';  ...
'0.02' '2.8778E-05';  ...
'0.03' '4.26811E-05';  ...
'0.04' '5.15442E-05';  ...
'0.05' '5.64049E-05';  ...
'0.06' '5.81456E-05';  ...
'0.07' '5.75106E-05';  ...
'0.08' '5.51215E-05';  ...
'0.09' '5.14917E-05';  ...
'0.1' '4.704E-05';  ...
'0.11' '4.2102E-05';  ...
'0.12' '3.69419E-05';  ...
'0.13' '3.17622E-05';  ...
'0.14' '2.6713E-05';  ...
'0.15' '2.19002E-05';  ...
'0.16' '1.73927E-05';  ...
'0.17' '1.32297E-05';  ...
'0.18' '9.42567E-06';  ...
'0.19' '5.97636E-06';  ...
'0.2' '2.86293E-06';  ...
'0.21' '5.60889E-08';  ...
'0.22' '-2.48057E-06';  ...
'0.23' '-4.78758E-06';  ...
'0.24' '-6.90723E-06';  ...
'0.25' '-8.88151E-06';  ...
'0.26' '-1.07505E-05';  ...
'0.27' '-1.25511E-05';  ...
'0.28' '-1.43163E-05';  ...
'0.29' '-1.60739E-05';  ...
'0.3' '-1.7847E-05';  ...
'0.31' '-1.9653E-05';  ...
'0.32' '-2.15043E-05';  ...
'0.33' '-2.3408E-05';  ...
'0.34' '-2.53663E-05';  ...
'0.35' '-2.73772E-05';  ...
'0.36' '-2.94348E-05';  ...
'0.37' '-3.153E-05';  ...
'0.38' '-3.36509E-05';  ...
'0.39' '-3.57841E-05';  ...
'0.4' '-3.79145E-05';  ...
'0.41' '-4.00267E-05';  ...
'0.42' '-4.21054E-05';  ...
'0.43' '-4.41359E-05';  ...
'0.44' '-4.61049E-05';  ...
'0.45' '-4.8001E-05';  ...
'0.46' '-4.98148E-05';  ...
'0.47' '-5.15398E-05';  ...
'0.48' '-5.31723E-05';  ...
'0.49' '-5.47118E-05';  ...
'0.5' '-5.6161E-05';  ...
'0.51' '-5.75258E-05';  ...
'0.52' '-5.88155E-05';  ...
'0.53' '-6.00423E-05';  ...
'0.54' '-6.12209E-05';  ...
'0.55' '-6.2369E-05';  ...
'0.56' '-6.35057E-05';  ...
'0.57' '-6.46519E-05';  ...
'0.58' '-6.58293E-05';  ...
'0.59' '-6.70598E-05';  ...
'0.6' '-6.83648E-05';  ...
'0.61' '-6.97648E-05';  ...
'0.62' '-7.12781E-05';  ...
'0.63' '-7.29204E-05';  ...
'0.64' '-7.47038E-05';  ...
'0.65' '-7.66365E-05';  ...
'0.66' '-7.87216E-05';  ...
'0.67' '-8.09567E-05';  ...
'0.68' '-8.33335E-05';  ...
'0.69' '-8.58371E-05';  ...
'0.7' '-8.84457E-05';  ...
'0.71' '-9.11307E-05';  ...
'0.72' '-9.38568E-05';  ...
'0.73' '-9.65818E-05';  ...
'0.74' '-9.92574E-05';  ...
'0.75' '-0.00010183';  ...
'0.76' '-0.000104242';  ...
'0.77' '-0.000106433';  ...
'0.78' '-0.000108342';  ...
'0.79' '-0.000109907';  ...
'0.8' '-0.000111074';  ...
'0.81' '-0.000111793';  ...
'0.82' '-0.000112027';  ...
'0.83' '-0.000111752';  ...
'0.84' '-0.000110967';  ...
'0.85' '-0.000109694';  ...
'0.86' '-0.000107991';  ...
'0.87' '-0.000105953';  ...
'0.88' '-0.000103722';  ...
'0.89' '-0.000101498';  ...
'0.9' '-9.95453E-05'});
model.material('mat3').propertyGroup('ElectrodePotential').func('int2').set('fununit', {'V/K'});
model.material('mat3').propertyGroup('ElectrodePotential').func('int2').set('argunit', {''});
model.material('mat3').propertyGroup('ElectrodePotential').set('Eeq', 'Eeq_int1(soc)+dEeqdT_int1(soc)*(T-298[K])');
model.material('mat3').propertyGroup('ElectrodePotential').set('INFO_PREFIX:Eeq', 'U. S. Kasavajjula, C. Wang, and P. E. Arce, "Discharge Model for LiFePO4 Accounting for the Solid Solution Range", J. Electrochemical Soc., vol. 155, p. A866, 2008');
model.material('mat3').propertyGroup('ElectrodePotential').set('dEeqdT', 'dEeqdT_int1(soc)');
model.material('mat3').propertyGroup('ElectrodePotential').set('INFO_PREFIX:dEeqdT', 'R. E. Gerver and J. P. Meyers, "Three-Dimensional Modeling of Electrochemical Performance and Heat Generation of Lithium-Ion Betteries in Tabbed Planar Configurations", J. Electrochemical Soc., vol. 158, p. A835, 2011');
model.material('mat3').propertyGroup('ElectrodePotential').set('cEeqref', 'def.csmax');
model.material('mat3').propertyGroup('ElectrodePotential').set('INFO_PREFIX:cEeqref', 'U. S. Kasavajjula, C. Wang, and P. E. Arce, "Discharge Model for LiFePO4 Accounting for the Solid Solution Range", J. Electrochemical Soc., vol. 155, p. A866, 2008');
model.material('mat3').propertyGroup('ElectrodePotential').set('soc', 'c/cEeqref');
model.material('mat3').propertyGroup('ElectrodePotential').descr('soc', '');
model.material('mat3').propertyGroup('ElectrodePotential').addInput('concentration');
model.material('mat3').propertyGroup('ElectrodePotential').addInput('temperature');
model.material('mat3').propertyGroup('OperationalSOC').set('socmax', 'elpot.Eeq_inv(E_min)');
model.material('mat3').propertyGroup('OperationalSOC').set('socmin', 'elpot.Eeq_inv(E_max)');
model.material('mat3').propertyGroup('OperationalSOC').set('E_max', '3.5[V]');
model.material('mat3').propertyGroup('OperationalSOC').set('E_min', '3.3[V]');
model.material('mat3').propertyGroup('ic').set('dvol', '11.62[cm^3/mol]*(c-elpot.cEeqref)');
model.material('mat3').propertyGroup('ic').set('INFO_PREFIX:dvol', ['R. Koerver and others, ' native2unicode(hex2dec({'20' '1c'}), 'unicode') 'Chemo-mechanical expansion of lithium electrode materials ' native2unicode(hex2dec({'20' '14'}), 'unicode') ' on the route to mechanically optimized all-solid-state batteries,' native2unicode(hex2dec({'20' '1d'}), 'unicode') ' Energy Environ. Sci., vol. 11, pp. 2142' native2unicode(hex2dec({'20' '13'}), 'unicode') '2158, 201']);
model.material('mat3').propertyGroup('ic').addInput('concentration');
model.material('mat3').propertyGroup('EquilibriumConcentration').set('csEq', 'def.csmax*elpot.Eeq_inv(V)');
model.material('mat3').propertyGroup('EquilibriumConcentration').addInput('electricpotential');
model.material.create('mat4', 'Common', '');
model.material('mat4').propertyGroup.create('ElectrodePotential', 'Equilibrium potential');
model.material('mat4').propertyGroup('ElectrodePotential').func.create('int1', 'Interpolation');
model.material('mat4').propertyGroup('ElectrodePotential').func.create('int2', 'Interpolation');
model.material('mat4').propertyGroup.create('OperationalSOC', 'Operational electrode state of charge');
model.material('mat4').propertyGroup.create('ic', 'Intercalation strain');
model.material('mat4').propertyGroup('ic').func.create('int1', 'Interpolation');
model.material('mat4').propertyGroup.create('EquilibriumConcentration', 'Equilibrium concentration');
model.material('mat4').label('NCA, LiNi0.8Co0.15Al0.05O2 (Positive, Li-ion Battery)');
model.material('mat4').propertyGroup('def').set('diffusion', {'1.5e-15[m^2/s]' '0' '0' '0' '1.5e-15[m^2/s]' '0' '0' '0' '1.5e-15[m^2/s]'});
model.material('mat4').propertyGroup('def').set('INFO_PREFIX:diffusion', 'S. Brown, N. Mellgren, M. Vynnycky, and G. Lindbergh, "Impedance as a Tool for Investigating Aging in Lithium-Ion Porous Electrodes. II. Positive Electrode Examination", J. Electrochemical Society, vol. 155, p. A320, 2008');
model.material('mat4').propertyGroup('def').set('electricconductivity', {'91[S/m]' '0' '0' '0' '91[S/m]' '0' '0' '0' '91[S/m]'});
model.material('mat4').propertyGroup('def').set('INFO_PREFIX:electricconductivity', 'S. Brown, N. Mellgren, M. Vynnycky, and G. Lindbergh, "Impedance as a Tool for Investigating Aging in Lithium-Ion Porous Electrodes. II. Positive Electrode Examination", J. Electrochemical Society, vol. 155, p. A320, 2008');
model.material('mat4').propertyGroup('def').set('density', '4740[kg/m^3]');
model.material('mat4').propertyGroup('def').set('INFO_PREFIX:density', 'N. Nitta, F. Wu, J. Tae Lee, and G. Yushin, Materials Today, Volume 18, Number 5, June 2015');
model.material('mat4').propertyGroup('def').set('csmax', '48000[mol/m^3]');
model.material('mat4').propertyGroup('def').descr('csmax', '');
model.material('mat4').propertyGroup('ElectrodePotential').func('int1').set('funcname', 'Eeq_int1');
model.material('mat4').propertyGroup('ElectrodePotential').func('int1').set('table', {'0.249' '4.2921';  ...
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
model.material('mat4').propertyGroup('ElectrodePotential').func('int1').set('interp', 'piecewisecubic');
model.material('mat4').propertyGroup('ElectrodePotential').func('int1').set('extrap', 'linear');
model.material('mat4').propertyGroup('ElectrodePotential').func('int1').set('fununit', {'V'});
model.material('mat4').propertyGroup('ElectrodePotential').func('int1').set('argunit', {''});
model.material('mat4').propertyGroup('ElectrodePotential').func('int1').set('defineinv', true);
model.material('mat4').propertyGroup('ElectrodePotential').func('int1').set('funcinvname', 'Eeq_inv');
model.material('mat4').propertyGroup('ElectrodePotential').func('int2').set('funcname', 'dEeqdT_int1');
model.material('mat4').propertyGroup('ElectrodePotential').func('int2').set('table', {'0.3' '0'; '0.45' '0'; '0.75' '-0.07e-3'; '0.85' '-0.08e-3'; '0.95' '-0.04e-3'});
model.material('mat4').propertyGroup('ElectrodePotential').func('int2').set('fununit', {'V/K'});
model.material('mat4').propertyGroup('ElectrodePotential').func('int2').set('argunit', {''});
model.material('mat4').propertyGroup('ElectrodePotential').set('Eeq', 'Eeq_int1(soc)+dEeqdT_int1(soc)*(T-298[K])');
model.material('mat4').propertyGroup('ElectrodePotential').set('INFO_PREFIX:Eeq', ['Asymmetry of Discharge/Charge Curves of Lithium-Ion Battery' newline 'Intercalation Electrodes, Florian Hall, Sabine Wussler, Hilmi Buqa, and Wolfgang G. Bessler, J. Phys. Chem. C 2016, 120, 23407-23414']);
model.material('mat4').propertyGroup('ElectrodePotential').set('dEeqdT', 'dEeqdT_int1(soc)');
model.material('mat4').propertyGroup('ElectrodePotential').set('INFO_PREFIX:dEeqdT', 'Determination of the Reversible and Irreversible Heats of a LiNi0.8Co0.15Al0.05O2 Natural Graphite Cell Using Electrochemical-Calorimetric Technique, Hui Yang and Jai Prakash, J. Electrochem. Soc. 2004 volume 151, issue 8, A1222-A1229');
model.material('mat4').propertyGroup('ElectrodePotential').set('cEeqref', 'def.csmax');
model.material('mat4').propertyGroup('ElectrodePotential').set('INFO_PREFIX:cEeqref', 'N. Nitta, F. Wu, J. Tae Lee, and G. Yushin, Materials Today, Volume 18, Number 5, June 2015');
model.material('mat4').propertyGroup('ElectrodePotential').set('soc', 'c/cEeqref');
model.material('mat4').propertyGroup('ElectrodePotential').descr('soc', '');
model.material('mat4').propertyGroup('ElectrodePotential').addInput('concentration');
model.material('mat4').propertyGroup('ElectrodePotential').addInput('temperature');
model.material('mat4').propertyGroup('OperationalSOC').set('socmax', 'elpot.Eeq_inv(E_min)');
model.material('mat4').propertyGroup('OperationalSOC').set('socmin', 'elpot.Eeq_inv(E_max)');
model.material('mat4').propertyGroup('OperationalSOC').set('E_max', '4.29[V]');
model.material('mat4').propertyGroup('OperationalSOC').set('E_min', '3.5[V]');
model.material('mat4').propertyGroup('ic').func('int1').set('funcname', 'dVOLdSOL');
model.material('mat4').propertyGroup('ic').func('int1').set('table', {'0.8878314072059823' '-0.03605514316012792';  ...
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
model.material('mat4').propertyGroup('ic').func('int1').set('extrap', 'linear');
model.material('mat4').propertyGroup('ic').func('int1').set('fununit', {'%'});
model.material('mat4').propertyGroup('ic').func('int1').set('argunit', {'1'});
model.material('mat4').propertyGroup('ic').set('dvol', 'dVOLdSOL(c/elpot.cEeqref)');
model.material('mat4').propertyGroup('ic').set('INFO_PREFIX:dvol', ['R. Koerver and others, ' native2unicode(hex2dec({'20' '1c'}), 'unicode') 'Chemo-mechanical expansion of lithium electrode materials ' native2unicode(hex2dec({'20' '14'}), 'unicode') ' on the route to mechanically optimized all-solid-state batteries,' native2unicode(hex2dec({'20' '1d'}), 'unicode') ' Energy Environ. Sci., vol. 11, pp. 2142' native2unicode(hex2dec({'20' '13'}), 'unicode') '2158, 201']);
model.material('mat4').propertyGroup('ic').addInput('concentration');
model.material('mat4').propertyGroup('EquilibriumConcentration').set('csEq', 'def.csmax*elpot.Eeq_inv(V)');
model.material('mat4').propertyGroup('EquilibriumConcentration').addInput('electricpotential');
model.material.create('mat5', 'Common', '');
model.material('mat5').propertyGroup.create('ElectrodePotential', 'Equilibrium potential');
model.material('mat5').propertyGroup('ElectrodePotential').func.create('int1', 'Interpolation');
model.material('mat5').propertyGroup('ElectrodePotential').func.create('int2', 'Interpolation');
model.material('mat5').propertyGroup.create('OperationalSOC', 'Operational electrode state of charge');
model.material('mat5').propertyGroup.create('ic', 'Intercalation strain');
model.material('mat5').propertyGroup('ic').func.create('int1', 'Interpolation');
model.material('mat5').propertyGroup.create('EquilibriumConcentration', 'Equilibrium concentration');
model.material('mat5').label('LCO, LiCoO2 (Positive, Li-ion Battery)');
model.material('mat5').comments([ newline ]);
model.material('mat5').propertyGroup('def').set('poissonsratio', '');
model.material('mat5').propertyGroup('def').set('youngsmodulus', '');
model.material('mat5').propertyGroup('def').set('thermalexpansioncoefficient', '');
model.material('mat5').propertyGroup('def').set('poissonsratio', '0.24');
model.material('mat5').propertyGroup('def').set('INFO_PREFIX:poissonsratio', ['E. Cheng, N. Taylor, J. Wolfenstine and J. Sakamoto, Elastic properties of lithium cobalt oxide (LiCoO2), Journal of Asian Ceramic Societies, 5:2,' newline '113-117, (2017), DOI: 10.1016/j.jascer.2017.03.001']);
model.material('mat5').propertyGroup('def').set('youngsmodulus', '191[GPa]');
model.material('mat5').propertyGroup('def').set('INFO_PREFIX:youngsmodulus', ['E. Cheng, N. Taylor, J. Wolfenstine and J. Sakamoto, Elastic properties of lithium cobalt oxide (LiCoO2), Journal of Asian Ceramic Societies, 5:2,' newline '113-117, (2017), DOI: 10.1016/j.jascer.2017.03.001']);
model.material('mat5').propertyGroup('def').set('thermalexpansioncoefficient', {'1.3e-5[1/K]' '0' '0' '0' '1.3e-5[1/K]' '0' '0' '0' '1.3e-5[1/K]'});
model.material('mat5').propertyGroup('def').set('INFO_PREFIX:thermalexpansioncoefficient', ['E. Cheng, N. Taylor, J. Wolfenstine and J. Sakamoto, Elastic properties of lithium cobalt oxide (LiCoO2), Journal of Asian Ceramic Societies, 5:2,' newline '113-117, (2017), DOI: 10.1016/j.jascer.2017.03.001']);
model.material('mat5').propertyGroup('def').set('electricconductivity', {'1.13[mS/cm]' '0' '0' '0' '1.13[mS/cm]' '0' '0' '0' '1.13[mS/cm]'});
model.material('mat5').propertyGroup('def').set('INFO_PREFIX:electricconductivity', 'M. Tang, P. Albertus, J. Harb, and J. Newman, "Two-Dimensional Modeling of Lithium Deposition during Cell Charging", J. Electrochemical Society, vol. 156, p. A390, 2009');
model.material('mat5').propertyGroup('def').set('diffusion', {'5e-13[m^2/s]' '0' '0' '0' '5e-13[m^2/s]' '0' '0' '0' '5e-13[m^2/s]'});
model.material('mat5').propertyGroup('def').set('INFO_PREFIX:diffusion', 'D. Stephenson, E. Hartman, J. Harb, D. Wheeler, "Modeling of Particle-Particle Interactions in Porous Cathodes for Lithium-Ion Batteries", J. Electrochemical Society, vol. 154, p. A1146, 2007');
model.material('mat5').propertyGroup('def').set('density', '5000[kg/m^3]');
model.material('mat5').propertyGroup('def').set('INFO_PREFIX:density', 'N. Nitta, F. Wu, J. Tae Lee, and G. Yushin, Materials Today, Volume 18, Number 5, June 2015');
model.material('mat5').propertyGroup('def').set('csmax', '56250[mol/m^3]');
model.material('mat5').propertyGroup('def').descr('csmax', '');
model.material('mat5').propertyGroup('ElectrodePotential').func('int1').set('funcname', 'Eeq_int1');
model.material('mat5').propertyGroup('ElectrodePotential').func('int1').set('table', {'0.43' '4.3';  ...
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
model.material('mat5').propertyGroup('ElectrodePotential').func('int1').set('interp', 'piecewisecubic');
model.material('mat5').propertyGroup('ElectrodePotential').func('int1').set('extrap', 'linear');
model.material('mat5').propertyGroup('ElectrodePotential').func('int1').set('fununit', {'V'});
model.material('mat5').propertyGroup('ElectrodePotential').func('int1').set('argunit', {''});
model.material('mat5').propertyGroup('ElectrodePotential').func('int1').set('defineinv', true);
model.material('mat5').propertyGroup('ElectrodePotential').func('int1').set('funcinvname', 'Eeq_inv');
model.material('mat5').propertyGroup('ElectrodePotential').func('int2').set('funcname', 'dEeqdT_int1');
model.material('mat5').propertyGroup('ElectrodePotential').func('int2').set('table', {'0.545' '-0.33e-3';  ...
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
model.material('mat5').propertyGroup('ElectrodePotential').func('int2').set('interp', 'piecewisecubic');
model.material('mat5').propertyGroup('ElectrodePotential').func('int2').set('fununit', {'V/K'});
model.material('mat5').propertyGroup('ElectrodePotential').func('int2').set('argunit', {''});
model.material('mat5').propertyGroup('ElectrodePotential').set('Eeq', 'Eeq_int1(soc)+dEeqdT_int1(soc)*(T-298[K])');
model.material('mat5').propertyGroup('ElectrodePotential').set('INFO_PREFIX:Eeq', 'M. Tang, P. Albertus, J. Harb, and J. Newman, "Two-Dimensional Modeling of Lithium Deposition during Cell Charging", J. Electrochemical Society, vol. 156, p. A390, 2009');
model.material('mat5').propertyGroup('ElectrodePotential').set('dEeqdT', 'dEeqdT_int1(soc)');
model.material('mat5').propertyGroup('ElectrodePotential').set('INFO_PREFIX:dEeqdT', ['K. E. Thomas, and J. Newman, ' native2unicode(hex2dec({'20' '1c'}), 'unicode') 'Heats of mixing and of entropy in porous insertion electrodes,' native2unicode(hex2dec({'20' '1d'}), 'unicode') ' J. Power Sources., vol. 119-121, p. 844, 2003.']);
model.material('mat5').propertyGroup('ElectrodePotential').set('cEeqref', 'def.csmax');
model.material('mat5').propertyGroup('ElectrodePotential').set('INFO_PREFIX:cEeqref', 'M. Tang, P. Albertus, J. Harb, and J. Newman, "Two-Dimensional Modeling of Lithium Deposition during Cell Charging", J. Electrochemical Society, vol. 156, p. A390, 2009');
model.material('mat5').propertyGroup('ElectrodePotential').set('soc', 'c/cEeqref');
model.material('mat5').propertyGroup('ElectrodePotential').descr('soc', '');
model.material('mat5').propertyGroup('ElectrodePotential').addInput('concentration');
model.material('mat5').propertyGroup('ElectrodePotential').addInput('temperature');
model.material('mat5').propertyGroup('OperationalSOC').set('socmax', 'elpot.Eeq_inv(E_min)');
model.material('mat5').propertyGroup('OperationalSOC').set('socmin', 'elpot.Eeq_inv(E_max)');
model.material('mat5').propertyGroup('OperationalSOC').set('E_max', '4.2[V]');
model.material('mat5').propertyGroup('OperationalSOC').set('E_min', '3.8[V]');
model.material('mat5').propertyGroup('ic').func('int1').set('funcname', 'dVOLdSOL');
model.material('mat5').propertyGroup('ic').func('int1').set('table', {'1' '0';  ...
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
model.material('mat5').propertyGroup('ic').func('int1').set('extrap', 'linear');
model.material('mat5').propertyGroup('ic').func('int1').set('fununit', {'%'});
model.material('mat5').propertyGroup('ic').func('int1').set('argunit', {'1'});
model.material('mat5').propertyGroup('ic').set('dvol', 'dVOLdSOL(c/elpot.cEeqref)');
model.material('mat5').propertyGroup('ic').set('INFO_PREFIX:dvol', ['R. Koerver and others, ' native2unicode(hex2dec({'20' '1c'}), 'unicode') 'Chemo-mechanical expansion of lithium electrode materials ' native2unicode(hex2dec({'20' '14'}), 'unicode') ' on the route to mechanically optimized all-solid-state batteries,' native2unicode(hex2dec({'20' '1d'}), 'unicode') ' Energy Environ. Sci., vol. 11, pp. 2142' native2unicode(hex2dec({'20' '13'}), 'unicode') '2158, 201']);
model.material('mat5').propertyGroup('ic').addInput('concentration');
model.material('mat5').propertyGroup('EquilibriumConcentration').set('csEq', 'def.csmax*elpot.Eeq_inv(V)');
model.material('mat5').propertyGroup('EquilibriumConcentration').addInput('electricpotential');
model.material.create('mat6', 'Common', '');
model.material('mat6').propertyGroup.create('ElectrodePotential', 'Equilibrium potential');
model.material('mat6').propertyGroup('ElectrodePotential').func.create('int1', 'Interpolation');
model.material('mat6').propertyGroup('ElectrodePotential').func.create('int2', 'Interpolation');
model.material('mat6').propertyGroup.create('OperationalSOC', 'Operational electrode state of charge');
model.material('mat6').propertyGroup.create('EquilibriumConcentration', 'Equilibrium concentration');
model.material('mat6').label('LMO, LiMn2O4 Spinel (Positive, Li-ion Battery)');
model.material('mat6').propertyGroup('def').set('youngsmodulus', '');
model.material('mat6').propertyGroup('def').set('poissonsratio', '');
model.material('mat6').propertyGroup('def').set('youngsmodulus', '194[GPa]');
model.material('mat6').propertyGroup('def').set('INFO_PREFIX:youngsmodulus', 'Yue Qi et al 2014 J. Electrochem. Soc. 161 F3010');
model.material('mat6').propertyGroup('def').set('poissonsratio', '0.26');
model.material('mat6').propertyGroup('def').set('INFO_PREFIX:poissonsratio', 'Yue Qi et al 2014 J. Electrochem. Soc. 161 F3010');
model.material('mat6').propertyGroup('def').set('electricconductivity', {'3.8[S/m]' '0' '0' '0' '3.8[S/m]' '0' '0' '0' '3.8[S/m]'});
model.material('mat6').propertyGroup('def').set('INFO_PREFIX:electricconductivity', 'V. Srinivasan and C.Y. Wang, "Analysis of Electrochemical and Thermal Behavior of Li-Ion Cells," J. Electrochem. Soc., vol. 150, p. A98, 2003');
model.material('mat6').propertyGroup('def').set('diffusion', {'1e-14*exp(20000/8.314*(1/(T_ref/1[K])-1/(T2/1[K])))[m^2/s]' '0' '0' '0' '1e-14*exp(20000/8.314*(1/(T_ref/1[K])-1/(T2/1[K])))[m^2/s]' '0' '0' '0' '1e-14*exp(20000/8.314*(1/(T_ref/1[K])-1/(T2/1[K])))[m^2/s]'});
model.material('mat6').propertyGroup('def').set('INFO_PREFIX:diffusion', 'V. Srinivasan and C.Y. Wang, "Analysis of Electrochemical and Thermal Behavior of Li-Ion Cells," J. Electrochem. Soc., vol. 150, p. A98, 2003');
model.material('mat6').propertyGroup('def').set('density', '4140[kg/m^3]');
model.material('mat6').propertyGroup('def').set('INFO_PREFIX:density', 'N. Nitta, F. Wu, J. Tae Lee, and G. Yushin, Materials Today, Volume 18, Number 5, June 2015');
model.material('mat6').propertyGroup('def').set('T_ref', '298[K]');
model.material('mat6').propertyGroup('def').descr('T_ref', '');
model.material('mat6').propertyGroup('def').set('T2', 'min(393.15,max(T,223.15))');
model.material('mat6').propertyGroup('def').descr('T2', '');
model.material('mat6').propertyGroup('def').set('csmax', '22860[mol/m^3]');
model.material('mat6').propertyGroup('def').descr('csmax', '');
model.material('mat6').propertyGroup('def').addInput('temperature');
model.material('mat6').propertyGroup('ElectrodePotential').func('int1').set('funcname', 'Eeq_int1');
model.material('mat6').propertyGroup('ElectrodePotential').func('int1').set('table', {'0.1750' '4.2763';  ...
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
model.material('mat6').propertyGroup('ElectrodePotential').func('int1').set('interp', 'piecewisecubic');
model.material('mat6').propertyGroup('ElectrodePotential').func('int1').set('extrap', 'linear');
model.material('mat6').propertyGroup('ElectrodePotential').func('int1').set('fununit', {'V'});
model.material('mat6').propertyGroup('ElectrodePotential').func('int1').set('argunit', {''});
model.material('mat6').propertyGroup('ElectrodePotential').func('int1').set('defineinv', true);
model.material('mat6').propertyGroup('ElectrodePotential').func('int1').set('funcinvname', 'Eeq_inv');
model.material('mat6').propertyGroup('ElectrodePotential').func('int2').set('funcname', 'dEeqdT_int1');
model.material('mat6').propertyGroup('ElectrodePotential').func('int2').set('table', {'0.15' '0.15e-3';  ...
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
model.material('mat6').propertyGroup('ElectrodePotential').func('int2').set('interp', 'piecewisecubic');
model.material('mat6').propertyGroup('ElectrodePotential').func('int2').set('fununit', {'V/K'});
model.material('mat6').propertyGroup('ElectrodePotential').func('int2').set('argunit', {''});
model.material('mat6').propertyGroup('ElectrodePotential').set('Eeq', 'Eeq_int1(soc)+dEeqdT_int1(soc)*(T-298[K])');
model.material('mat6').propertyGroup('ElectrodePotential').set('INFO_PREFIX:Eeq', 'V. Srinivasan and C.Y. Wang, "Analysis of Electrochemical and Thermal Behavior of Li-Ion Cells," J. Electrochem. Soc., vol. 150, p. A98, 2003');
model.material('mat6').propertyGroup('ElectrodePotential').set('dEeqdT', 'dEeqdT_int1(soc)');
model.material('mat6').propertyGroup('ElectrodePotential').set('INFO_PREFIX:dEeqdT', 'V. Srinivasan and C.Y. Wang, "Analysis of Electrochemical and Thermal Behavior of Li-Ion Cells," J. Electrochem. Soc., vol. 150, p. A98, 2003');
model.material('mat6').propertyGroup('ElectrodePotential').set('cEeqref', 'def.csmax');
model.material('mat6').propertyGroup('ElectrodePotential').set('INFO_PREFIX:cEeqref', 'V. Srinivasan and C.Y. Wang, "Analysis of Electrochemical and Thermal Behavior of Li-Ion Cells," J. Electrochem. Soc., vol. 150, p. A98, 2003');
model.material('mat6').propertyGroup('ElectrodePotential').set('soc', 'c/cEeqref');
model.material('mat6').propertyGroup('ElectrodePotential').descr('soc', '');
model.material('mat6').propertyGroup('ElectrodePotential').addInput('concentration');
model.material('mat6').propertyGroup('ElectrodePotential').addInput('temperature');
model.material('mat6').propertyGroup('OperationalSOC').set('socmax', 'elpot.Eeq_inv(E_min)');
model.material('mat6').propertyGroup('OperationalSOC').set('socmin', 'elpot.Eeq_inv(E_max)');
model.material('mat6').propertyGroup('OperationalSOC').set('E_max', '4.2[V]');
model.material('mat6').propertyGroup('OperationalSOC').set('E_min', '3.9[V]');
model.material('mat6').propertyGroup('EquilibriumConcentration').set('csEq', 'def.csmax*elpot.Eeq_inv(V)');
model.material('mat6').propertyGroup('EquilibriumConcentration').addInput('electricpotential');
model.material.create('mat7', 'Common', 'comp1');
model.material('mat7').propertyGroup('def').func.create('int1', 'Interpolation');
model.material('mat7').propertyGroup.create('ElectrolyteConductivity', 'Electrolyte conductivity');
model.material('mat7').propertyGroup('ElectrolyteConductivity').func.create('int1', 'Interpolation');
model.material('mat7').propertyGroup.create('SpeciesProperties', 'Species properties');
model.material('mat7').propertyGroup('SpeciesProperties').func.create('int1', 'Interpolation');
model.material('mat7').propertyGroup('SpeciesProperties').func.create('int2', 'Interpolation');
model.material('mat7').propertyGroup.create('ElectrolyteSaltConcentration', 'Electrolyte salt concentration');
model.material('mat7').label('LiPF6 in 3:7 EC:EMC (Liquid, Li-ion Battery)');
model.material('mat7').propertyGroup('def').func('int1').set('funcname', 'DL_int1');
model.material('mat7').propertyGroup('def').func('int1').set('table', {'200' '3.9e-10/(1-200*59e-6)';  ...
'500' '4.12e-10/(1-500*59e-6)';  ...
'800' '4e-10/(1-800*59e-6)';  ...
'1000' '3.8e-10/(1-1000*59e-6)';  ...
'1200' '3.50e-10/(1-1200*59e-6)';  ...
'1600' '2.68e-10/(1-1600*59e-6)';  ...
'2000' '1.9e-10/(1-2000*59e-6)'});
model.material('mat7').propertyGroup('def').func('int1').set('interp', 'piecewisecubic');
model.material('mat7').propertyGroup('def').func('int1').set('fununit', {'m^2/s'});
model.material('mat7').propertyGroup('def').func('int1').set('argunit', {''});
model.material('mat7').propertyGroup('def').set('diffusion', {'DL_int1(c/1[mol/m^3])*exp(16500/8.314*(1/(T_ref/1[K])-1/(T2/1[K])))' '0' '0' '0' 'DL_int1(c/1[mol/m^3])*exp(16500/8.314*(1/(T_ref/1[K])-1/(T2/1[K])))' '0' '0' '0' 'DL_int1(c/1[mol/m^3])*exp(16500/8.314*(1/(T_ref/1[K])-1/(T2/1[K])))'});
model.material('mat7').propertyGroup('def').set('INFO_PREFIX:diffusion', 'T. G. Zavalis, M. Behm, and G. Lindbergh, "Investigations of Short-Circuit Scenarios in a Lithium-Ion Battery Cell," J. Electrochem. Soc., vol. 159, p. A848, 2012.');
model.material('mat7').propertyGroup('def').set('T_ref', '298[K]');
model.material('mat7').propertyGroup('def').descr('T_ref', '');
model.material('mat7').propertyGroup('def').set('T2', 'min(393.15,max(T,223.15))');
model.material('mat7').propertyGroup('def').descr('T2', '');
model.material('mat7').propertyGroup('def').addInput('concentration');
model.material('mat7').propertyGroup('def').addInput('temperature');
model.material('mat7').propertyGroup('ElectrolyteConductivity').func('int1').set('funcname', 'sigmal_int1');
model.material('mat7').propertyGroup('ElectrolyteConductivity').func('int1').set('table', {'0' '1e-6';  ...
'200' '0.455';  ...
'500' '0.783';  ...
'800' '0.935';  ...
'1000' '0.95';  ...
'1200' '0.927';  ...
'1600' '0.78';  ...
'2000' '0.60';  ...
'2200' '0.515'});
model.material('mat7').propertyGroup('ElectrolyteConductivity').func('int1').set('interp', 'piecewisecubic');
model.material('mat7').propertyGroup('ElectrolyteConductivity').func('int1').set('fununit', {'S/m'});
model.material('mat7').propertyGroup('ElectrolyteConductivity').func('int1').set('argunit', {''});
model.material('mat7').propertyGroup('ElectrolyteConductivity').set('sigmal', {'sigmal_int1(c/1[mol/m^3])*exp(4000/8.314*(1/(T_ref2/1[K])-1/(T3/1[K])))' '0' '0' '0' 'sigmal_int1(c/1[mol/m^3])*exp(4000/8.314*(1/(T_ref2/1[K])-1/(T3/1[K])))' '0' '0' '0' 'sigmal_int1(c/1[mol/m^3])*exp(4000/8.314*(1/(T_ref2/1[K])-1/(T3/1[K])))'});
model.material('mat7').propertyGroup('ElectrolyteConductivity').set('INFO_PREFIX:sigmal', 'T. G. Zavalis, M. Behm, and G. Lindbergh, "Investigations of Short-Circuit Scenarios in a Lithium-Ion Battery Cell," J. Electrochem. Soc., vol. 159, p. A848, 2012.');
model.material('mat7').propertyGroup('ElectrolyteConductivity').set('T_ref2', '298[K]');
model.material('mat7').propertyGroup('ElectrolyteConductivity').descr('T_ref2', '');
model.material('mat7').propertyGroup('ElectrolyteConductivity').set('T3', 'min(393.15,max(T,223.15))');
model.material('mat7').propertyGroup('ElectrolyteConductivity').descr('T3', '');
model.material('mat7').propertyGroup('ElectrolyteConductivity').addInput('concentration');
model.material('mat7').propertyGroup('ElectrolyteConductivity').addInput('temperature');
model.material('mat7').propertyGroup('SpeciesProperties').func('int1').set('funcname', 'transpNm_int1');
model.material('mat7').propertyGroup('SpeciesProperties').func('int1').set('table', {'200' '0.37';  ...
'500' '0.322';  ...
'800' '0.27';  ...
'1000' '0.251';  ...
'1200' '0.248';  ...
'1600' '0.236';  ...
'2000' '0.11'});
model.material('mat7').propertyGroup('SpeciesProperties').func('int1').set('interp', 'piecewisecubic');
model.material('mat7').propertyGroup('SpeciesProperties').func('int1').set('fununit', {''});
model.material('mat7').propertyGroup('SpeciesProperties').func('int1').set('argunit', {''});
model.material('mat7').propertyGroup('SpeciesProperties').func('int2').set('funcname', 'actdep_int1');
model.material('mat7').propertyGroup('SpeciesProperties').func('int2').set('table', {'200' '0';  ...
'500' '0.29';  ...
'800' '0.695';  ...
'1000' '1';  ...
'1200' '1.32';  ...
'1600' '2.07';  ...
'2000' '2.50'});
model.material('mat7').propertyGroup('SpeciesProperties').func('int2').set('interp', 'piecewisecubic');
model.material('mat7').propertyGroup('SpeciesProperties').func('int2').set('fununit', {''});
model.material('mat7').propertyGroup('SpeciesProperties').func('int2').set('argunit', {''});
model.material('mat7').propertyGroup('SpeciesProperties').set('transpNum', 'transpNm_int1(c/1[mol/m^3])');
model.material('mat7').propertyGroup('SpeciesProperties').set('INFO_PREFIX:transpNum', ['A. Nyman, M. Behm, and G. Lindbergh, ' native2unicode(hex2dec({'20' '1c'}), 'unicode') 'Electrochemical characterisation and modelling of the mass transport phenomena in LiPF6-EC-EMC,' native2unicode(hex2dec({'20' '1d'}), 'unicode') ' Electrochim. Acta, vol. 53, p. 6356, 2008.']);
model.material('mat7').propertyGroup('SpeciesProperties').set('fcl', 'actdep_int1(c/1[mol/m^3])*exp(-1000/8.314*(1/(T_ref3/1[K])-1/(T4/1[K])))');
model.material('mat7').propertyGroup('SpeciesProperties').set('INFO_PREFIX:fcl', 'T. G. Zavalis, M. Behm, and G. Lindbergh, "Investigations of Short-Circuit Scenarios in a Lithium-Ion Battery Cell," J. Electrochem. Soc., vol. 159, p. A848, 2012.');
model.material('mat7').propertyGroup('SpeciesProperties').set('T4', 'min(393.15,max(T,223.15))');
model.material('mat7').propertyGroup('SpeciesProperties').descr('T4', '');
model.material('mat7').propertyGroup('SpeciesProperties').set('T_ref3', '298[K]');
model.material('mat7').propertyGroup('SpeciesProperties').descr('T_ref3', '');
model.material('mat7').propertyGroup('SpeciesProperties').addInput('concentration');
model.material('mat7').propertyGroup('SpeciesProperties').addInput('temperature');
model.material('mat7').propertyGroup('ElectrolyteSaltConcentration').identifier('cElsalt');
model.material('mat7').propertyGroup('ElectrolyteSaltConcentration').set('cElsalt', '1200[mol/m^3]');

model.geom('geom1').run;

model.material.create('mat8', 'Common', 'comp1');
model.material('mat8').propertyGroup('def').func.create('int1', 'Interpolation');
model.material('mat8').propertyGroup('def').func.create('int2', 'Interpolation');
model.material('mat8').propertyGroup.create('ElectrodePotential', 'Equilibrium potential');
model.material('mat8').propertyGroup('ElectrodePotential').func.create('int1', 'Interpolation');
model.material('mat8').propertyGroup('ElectrodePotential').func.create('int2', 'Interpolation');
model.material('mat8').propertyGroup.create('OperationalSOC', 'Operational electrode state of charge');
model.material('mat8').propertyGroup.create('ic', 'Intercalation strain');
model.material('mat8').propertyGroup('ic').func.create('int1', 'Interpolation');
model.material('mat8').propertyGroup.create('EquilibriumConcentration', 'Equilibrium concentration');
model.material('mat8').label('Graphite, LixC6 MCMB (Negative, Li-ion Battery)');
model.material('mat8').propertyGroup('def').func('int1').set('funcname', 'E_int');
model.material('mat8').propertyGroup('def').func('int1').set('table', {'0' '32.47'; '0.333' '28.56'; '0.5' '58.06'; '1' '108.67'});
model.material('mat8').propertyGroup('def').func('int1').set('fununit', {'GPa'});
model.material('mat8').propertyGroup('def').func('int1').set('argunit', {'1'});
model.material('mat8').propertyGroup('def').func('int2').set('funcname', 'nu_int');
model.material('mat8').propertyGroup('def').func('int2').set('table', {'0' '0.32'; '0.333' '0.39'; '0.5' '0.34'; '1' '0.24'});
model.material('mat8').propertyGroup('def').func('int2').set('fununit', {''});
model.material('mat8').propertyGroup('def').set('youngsmodulus', '');
model.material('mat8').propertyGroup('def').set('poissonsratio', '');
model.material('mat8').propertyGroup('def').set('youngsmodulus', 'E_int(c/csmax)');
model.material('mat8').propertyGroup('def').set('INFO_PREFIX:youngsmodulus', 'Yue Qi et al 2010 J. Electrochem. Soc. 157 A558');
model.material('mat8').propertyGroup('def').set('poissonsratio', 'nu_int(c/csmax)');
model.material('mat8').propertyGroup('def').set('INFO_PREFIX:poissonsratio', 'Yue Qi et al 2010 J. Electrochem. Soc. 157 A558');
model.material('mat8').propertyGroup('def').set('electricconductivity', {'100[S/m]' '0' '0' '0' '100[S/m]' '0' '0' '0' '100[S/m]'});
model.material('mat8').propertyGroup('def').set('INFO_PREFIX:electricconductivity', ['V. Srinivasan, and J. Newman, ' native2unicode(hex2dec({'20' '1c'}), 'unicode') 'Design and Optimization of a Natural Graphite/Iron Phosphate Lithium Ion Cell,' native2unicode(hex2dec({'20' '1d'}), 'unicode') ' J. Electrochem. Soc., vol. 151, p. 1530, 2004.']);
model.material('mat8').propertyGroup('def').set('diffusion', {'1.4523e-13*exp(68025.7/8.314*(1/(T_ref/1[K])-1/(T2/1[K])))[m^2/s]' '0' '0' '0' '1.4523e-13*exp(68025.7/8.314*(1/(T_ref/1[K])-1/(T2/1[K])))[m^2/s]' '0' '0' '0' '1.4523e-13*exp(68025.7/8.314*(1/(T_ref/1[K])-1/(T2/1[K])))[m^2/s]'});
model.material('mat8').propertyGroup('def').set('INFO_PREFIX:diffusion', ['K. Kumaresan, G. Sikha, and R. E. White, ' native2unicode(hex2dec({'20' '1c'}), 'unicode') 'Thermal Model for a Li-Ion Cell,' native2unicode(hex2dec({'20' '1d'}), 'unicode') ' J. Electrochem. Soc., vol. 155, p. A164, 2008.']);
model.material('mat8').propertyGroup('def').set('thermalconductivity', {'1[W/(m*K)]' '0' '0' '0' '1[W/(m*K)]' '0' '0' '0' '1[W/(m*K)]'});
model.material('mat8').propertyGroup('def').set('INFO_PREFIX:thermalconductivity', 'S. Chen, C. Wan, and Y. Wang, J. Power Sources, 140, 111 (2005).');
model.material('mat8').propertyGroup('def').set('heatcapacity', '750[J/(kg*K)]');
model.material('mat8').propertyGroup('def').set('INFO_PREFIX:heatcapacity', 'SI Chemical Data, John Wiley & Sons, 1994');
model.material('mat8').propertyGroup('def').set('density', '2300[kg/m^3]');
model.material('mat8').propertyGroup('def').set('INFO_PREFIX:density', 'SI Chemical Data, John Wiley & Sons, 1994');
model.material('mat8').propertyGroup('def').set('csmax', '31507[mol/m^3]');
model.material('mat8').propertyGroup('def').descr('csmax', '');
model.material('mat8').propertyGroup('def').set('T_ref', '318[K]');
model.material('mat8').propertyGroup('def').descr('T_ref', '');
model.material('mat8').propertyGroup('def').set('T2', 'min(393.15,max(T,223.15))');
model.material('mat8').propertyGroup('def').descr('T2', '');
model.material('mat8').propertyGroup('def').addInput('temperature');
model.material('mat8').propertyGroup('def').addInput('concentration');
model.material('mat8').propertyGroup('ElectrodePotential').func('int1').set('funcname', 'Eeq_int1');
model.material('mat8').propertyGroup('ElectrodePotential').func('int1').set('table', {'0' '2.781186612';  ...
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
model.material('mat8').propertyGroup('ElectrodePotential').func('int1').set('interp', 'piecewisecubic');
model.material('mat8').propertyGroup('ElectrodePotential').func('int1').set('extrap', 'linear');
model.material('mat8').propertyGroup('ElectrodePotential').func('int1').set('fununit', {'V'});
model.material('mat8').propertyGroup('ElectrodePotential').func('int1').set('argunit', {''});
model.material('mat8').propertyGroup('ElectrodePotential').func('int1').set('defineinv', true);
model.material('mat8').propertyGroup('ElectrodePotential').func('int1').set('funcinvname', 'Eeq_inv');
model.material('mat8').propertyGroup('ElectrodePotential').func('int2').set('funcname', 'dEeqdT_int1');
model.material('mat8').propertyGroup('ElectrodePotential').func('int2').set('table', {'0' '3.0e-4';  ...
'0.17' '0';  ...
'0.24' '-6e-5';  ...
'0.28' '-1.6e-4';  ...
'0.5' '-1.6e-4';  ...
'0.54' '-9e-5';  ...
'0.71' '-9e-5';  ...
'0.85' '-1.0e-4';  ...
'1.0' '-1.2e-4'});
model.material('mat8').propertyGroup('ElectrodePotential').func('int2').set('fununit', {'V/K'});
model.material('mat8').propertyGroup('ElectrodePotential').func('int2').set('argunit', {''});
model.material('mat8').propertyGroup('ElectrodePotential').set('Eeq', 'Eeq_int1(soc)+dEeqdT_int1(soc)*(T-298[K])');
model.material('mat8').propertyGroup('ElectrodePotential').set('INFO_PREFIX:Eeq', ['D. P Karthikeyan, G. Sikha, and R. E. White, ' native2unicode(hex2dec({'20' '1c'}), 'unicode') 'Thermodynamic model development for lithium intercalation electrodes,' native2unicode(hex2dec({'20' '1d'}), 'unicode') ' J. Power Sources, vol. 185, p. 1398, 2008.']);
model.material('mat8').propertyGroup('ElectrodePotential').set('dEeqdT', 'dEeqdT_int1(soc)');
model.material('mat8').propertyGroup('ElectrodePotential').set('INFO_PREFIX:dEeqdT', ['K. E. Thomas, and J. Newman, ' native2unicode(hex2dec({'20' '1c'}), 'unicode') 'Heats of mixing and of entropy in porous insertion electrodes,' native2unicode(hex2dec({'20' '1d'}), 'unicode') ' J. Power Sources., vol. 119-121, p. 844, 2003.']);
model.material('mat8').propertyGroup('ElectrodePotential').set('cEeqref', 'def.csmax');
model.material('mat8').propertyGroup('ElectrodePotential').set('soc', 'c/cEeqref');
model.material('mat8').propertyGroup('ElectrodePotential').descr('soc', '');
model.material('mat8').propertyGroup('ElectrodePotential').addInput('concentration');
model.material('mat8').propertyGroup('ElectrodePotential').addInput('temperature');
model.material('mat8').propertyGroup('OperationalSOC').set('socmax', 'elpot.Eeq_inv(E_min)');
model.material('mat8').propertyGroup('OperationalSOC').set('socmin', 'elpot.Eeq_inv(E_max)');
model.material('mat8').propertyGroup('OperationalSOC').set('E_max', '1[V]');
model.material('mat8').propertyGroup('OperationalSOC').set('E_min', '0.075[V]');
model.material('mat8').propertyGroup('ic').func('int1').set('funcname', 'dVOLdSOL');
model.material('mat8').propertyGroup('ic').func('int1').set('table', {'0' '0';  ...
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
model.material('mat8').propertyGroup('ic').func('int1').set('extrap', 'linear');
model.material('mat8').propertyGroup('ic').func('int1').set('fununit', {'%'});
model.material('mat8').propertyGroup('ic').func('int1').set('argunit', {'1'});
model.material('mat8').propertyGroup('ic').set('dvol', 'dVOLdSOL(c/def.csmax)');
model.material('mat8').propertyGroup('ic').set('INFO_PREFIX:dvol', ['S. Schweidler, L. de Biasi, A. Schiele, P. Hartmann, T. Brezesinski and J. Janek, "Volume Changes of Graphite Anodes Revisited: A Combined Operando X-Ray Diffraction and In Situ Pressure Analysis Study", J. Phys. Chem. C, 2018, 122, 8829' native2unicode(hex2dec({'20' '13'}), 'unicode') '8835']);
model.material('mat8').propertyGroup('ic').addInput('concentration');
model.material('mat8').propertyGroup('EquilibriumConcentration').set('csEq', 'def.csmax*elpot.Eeq_inv(V)');
model.material('mat8').propertyGroup('EquilibriumConcentration').addInput('electricpotential');

model.selection.create('sel1', 'Explicit');
model.selection('sel1').model('comp1');
model.selection('sel1').label('Negative electrode');
model.selection('sel1').set([1]);
model.selection.duplicate('sel2', 'sel1');
model.selection('sel2').label('Positive Electrode');
model.selection('sel2').set([3]);
model.selection.create('sel3', 'Explicit');
model.selection('sel3').model('comp1');
model.selection('sel3').set([2]);
model.selection('sel3').label('Separator');

model.func.create('an1', 'Analytic');
model.func('an1').model('comp1');
model.func('an1').set('funcname', 'SOC_vs_Time');
model.func('an1').set('expr', 'if(t<t_charge, SOC_lower+(SOC_upper-SOC_lower)*t/t_charge, SOC_upper-(SOC_upper-SOC_lower)*(t-t_charge)/t_discharge)');
model.func('an1').set('args', 't');
model.func('an1').setIndex('plotargs', 't_charge+t_discharge', 0, 2);
model.func.create('step1', 'Step');
model.func('step1').model('comp1');
model.func('step1').set('location', '0.0005');
model.func('step1').set('smooth', 0.001);

model.probe.create('var1', 'GlobalVariable');
model.probe('var1').model('comp1');
model.probe('var1').label('Cell voltage probe');
model.probe('var1').set('expr', 'Ecell');
model.probe('var1').set('descractive', true);
model.probe('var1').set('table', 'new');

model.cpl.create('intop1', 'Integration', 'geom1');
model.cpl('intop1').set('axisym', true);
model.cpl('intop1').set('opname', 'negative');
model.cpl('intop1').selection.named('sel1');
model.cpl.duplicate('intop2', 'intop1');
model.cpl('intop2').set('opname', 'positive');
model.cpl('intop2').selection.named('sel2');
model.cpl.duplicate('intop3', 'intop2');
model.cpl('intop3').set('opname', 'separator');
model.cpl('intop3').selection.named('sel3');
model.cpl('intop3').set('opname', 'pos_cc');
model.cpl('intop3').selection.geom('geom1', 0);
model.cpl('intop3').selection.set([4]);
model.cpl.duplicate('intop4', 'intop3');
model.cpl('intop4').set('opname', 'neg_cc');
model.cpl('intop4').selection.set([1]);
model.cpl.duplicate('intop5', 'intop4');
model.cpl('intop5').set('opname', 'neg_sep');
model.cpl('intop5').selection.set([2]);
model.cpl.duplicate('intop6', 'intop5');
model.cpl('intop6').set('opname', 'pos_sep');
model.cpl('intop6').selection.set([3]);
model.cpl.create('intop7', 'Integration', 'geom1');
model.cpl('intop7').set('axisym', true);
model.cpl('intop7').set('opname', 'int_all');
model.cpl('intop7').selection.all;
model.cpl.create('intop8', 'Integration', 'geom1');
model.cpl('intop8').set('axisym', true);
model.cpl('intop8').set('opname', 'separator');
model.cpl('intop8').selection.named('sel3');
model.cpl.create('minop1', 'Minimum', 'geom1');
model.cpl('minop1').set('opname', 'min_neg');
model.cpl('minop1').selection.named('sel1');
model.cpl.create('maxop1', 'Maximum', 'geom1');
model.cpl('maxop1').set('opname', 'max_pos');
model.cpl('maxop1').selection.named('sel2');

model.variable.create('var1');
model.variable('var1').model('comp1');

% To import content from file, use:
% model.variable('var1').loadFile('FILENAME');
model.variable('var1').set('Ecell', 'pos_cc(phis)', 'Battery cell voltage');
model.variable('var1').set('EOCPneg', 'mat8.elpot.Eeq_int1(liion.soc_average_pce1)', 'Open-circuit potential in negative electrode, coulombic');
model.variable('var1').set('EOCPpos', 'matlnk1.elpot.Eeq_int1(liion.soc_average_pce2)', 'Open-circuit potential in positive electrode, coulombic');
model.variable('var1').set('EOCVcell', 'EOCPpos-EOCPneg', 'Open-circuit cell voltage, coulombic');
model.variable('var1').set('Total_polarization', 'EOCVcell-Ecell', 'Total battery cell polarization');
model.variable('var1').set('P_avg_charge', 'W_electric_charge/t_charge', 'Average battery power during charge');
model.variable('var1').set('P_avg_discharge', 'W_electric_discharge/t_discharge', 'Average battery power during discharge');
model.variable('var1').label('Potential and power variables');
model.variable.create('var2');
model.variable('var2').model('comp1');

% To import content from file, use:
% model.variable('var2').loadFile('FILENAME');
model.variable('var2').set('Q_J_l', '-liion.Ilx*philx');
model.variable('var2').set('Q_J_s', '-liion.Isx*phisx');
model.variable('var2').set('Q_activ_pos', '(phis-phil-matlnk1.elpot.Eeq_int1(liion.cs_average/cs_max_pos))*liion.iv_per1+liion.Qirrevv_per2+liion.Qrevv_per1');
model.variable('var2').set('Q_activ_neg', '(phis-phil-mat8.elpot.Eeq_int1(liion.cs_average/cs_max_neg))*liion.iv_per1+liion.Qirrevv_per2+liion.Qrevv_per1');
model.variable('var2').set('Q_J_s_pos', 'positive(Q_J_s)*A_cell');
model.variable('var2').set('Q_J_s_neg', 'negative(Q_J_s)*A_cell');
model.variable('var2').set('Q_J_l_pos', 'positive(Q_J_l)*A_cell');
model.variable('var2').set('Q_J_l_neg', 'negative(Q_J_l)*A_cell');
model.variable('var2').set('Q_act_pos', 'positive(Q_activ_pos)*A_cell');
model.variable('var2').set('Q_act_neg', 'negative(Q_activ_neg)*A_cell');
model.variable('var2').set('Q_J_l_sep', 'separator(Q_J_l)*A_cell');
model.variable('var2').set('Q_tot', 'Q_J_s_pos+Q_J_s_neg+Q_act_pos+Q_act_neg+int_all(Q_J_l)*A_cell');
model.variable('var2').label('Heat sources variables');
model.variable.create('var3');
model.variable('var3').model('comp1');
model.variable('var3').label('Charge variables');

% To import content from file, use:
% model.variable('var3').loadFile('FILENAME');
model.variable('var3').set('i_app', 'i_app_charge');
model.variable('var3').set('CHARGE', '1');
model.variable('var3').set('DISCHARGE', '0');
model.variable.create('var4');
model.variable('var4').model('comp1');
model.variable('var4').label('Discharge variables');

% To import content from file, use:
% model.variable('var4').loadFile('FILENAME');
model.variable('var4').set('i_app', 'i_app_discharge');
model.variable('var4').set('CHARGE', '0');
model.variable('var4').set('DISCHARGE', '1');
model.variable.create('var5');
model.variable('var5').model('comp1');
model.variable('var5').label('Plot variables - positive');
model.variable('var5').selection.geom('geom1', 1);
model.variable('var5').selection.named('sel2');

% To import content from file, use:
% model.variable('var5').loadFile('FILENAME');
model.variable('var5').set('EvsCC', 'phis-pos_cc(phis)');
model.variable('var5').set('CapLoss', 'liion.c_pce2_Gas*F_const');
model.variable.create('var6');
model.variable('var6').model('comp1');
model.variable('var6').label('Plot variables - negative');
model.variable('var6').selection.geom('geom1', 1);
model.variable('var6').selection.named('sel1');

% To import content from file, use:
% model.variable('var6').loadFile('FILENAME');
model.variable('var6').set('EvsCC', 'phis-neg_cc(phis)');
model.variable('var6').set('CapLoss', 'liion.c_pce1_LiMetal*F_const');
model.variable.create('var7');
model.variable('var7').model('comp1');
model.variable('var7').label('TimeSimulation');
model.variable('var7').set('tsim', 't_charge+t_discharge');

model.material.create('matlnk1', 'Link', 'comp1');
model.material('matlnk1').selection.set([3]);
model.material('mat8').selection.named('sel1');

model.physics('liion').feature('sep1').set('minput_temperature_src', 'userdef');
model.physics('liion').feature('sep1').set('minput_temperature', 'T');
model.physics('liion').feature('sep1').set('epsl', 'eps_l_sep');
model.physics('liion').feature('init1').set('phil', '-mat8.elpot.Eeq_int1(cs_neg_init/cs_max_neg)');
model.physics('liion').create('pce1', 'PorousElectrode', 1);
model.physics('liion').feature('pce1').label('Porous Electrode - Negative');
model.physics('liion').feature('pce1').selection.named('sel1');
model.physics('liion').feature('pce1').setIndex('minput_temperature_src', 'userdef', 0);
model.physics('liion').feature('pce1').setIndex('minput_temperature', 'T', 0);
model.physics('liion').feature('pce1').set('ElectrolyteMaterial', 'mat7');
model.physics('liion').feature('pce1').set('sigma', {'sigmas_neg' '0' '0' '0' 'sigmas_neg' '0' '0' '0' 'sigmas_neg'});
model.physics('liion').feature('pce1').set('epss', 'eps_s_neg');
model.physics('liion').feature('pce1').set('epsl', 'eps_l_neg');
model.physics('liion').feature('pce1').set('AddVolumeChangeToElectrodeVolumeFraction', false);
model.physics('liion').feature('pce1').set('SubtractVolumeChangeFromElectrolyteVolumeFraction', false);
model.physics('liion').feature('pce1').setIndex('Species', 's1', 0, 0);
model.physics('liion').feature('pce1').setIndex('rhos', 8960, 0, 0);
model.physics('liion').feature('pce1').setIndex('Ms', 0.06355, 0, 0);
model.physics('liion').feature('pce1').setIndex('Species', 's1', 0, 0);
model.physics('liion').feature('pce1').setIndex('rhos', 8960, 0, 0);
model.physics('liion').feature('pce1').setIndex('Ms', 0.06355, 0, 0);
model.physics('liion').feature('pce1').setIndex('Species', 'LiMetal', 0, 0);
model.physics('liion').feature('pce1').feature('pin1').set('minput_temperature_src', 'userdef');
model.physics('liion').feature('pce1').feature('pin1').set('minput_temperature', 'T');
model.physics('liion').feature('pce1').feature('pin1').set('csinit', 'cs_neg_init');
model.physics('liion').feature('pce1').feature('pin1').set('rp', 'r_neg');
model.physics('liion').feature('pce1').feature('per1').set('minput_temperature_src', 'userdef');
model.physics('liion').feature('pce1').feature('per1').set('minput_temperature', 'T');
model.physics('liion').feature('pce1').feature('per1').set('i0refType', 'FromRateConstant');
model.physics('liion').feature('pce1').feature('per1').set('k', '6.3e-10[m/s]');
model.physics('liion').feature('pce1').create('per2', 'PorousElectrodeReaction', 1);
model.physics('liion').feature('pce1').feature('per2').set('minput_temperature_src', 'userdef');
model.physics('liion').feature('pce1').feature('per2').set('minput_temperature', 'T');
model.physics('liion').feature('pce1').feature('per2').set('Eeq_mat', 'userdef');
model.physics('liion').feature('pce1').feature('per2').set('ElectrodeKinetics', 'ButlerVolmer');
model.physics('liion').feature('pce1').feature('per2').set('i0', '1e2[A/m^2]*if(cl>1[mol/m^3],(cl/1000[mol/m^3])^0.5,cl[m^3/mol]/(1000^0.5))*step1(-liion.eta_per2[1/V])');
model.physics('liion').feature('pce1').feature('per2').set('VLiTheta', 0);
model.physics('liion').feature('pce1').feature('per2').setIndex('Vib', 1, 0, 0);
model.physics('liion').feature('pce1').feature('per2').set('dEeqdT_mat', 'userdef');
model.physics('liion').create('pce2', 'PorousElectrode', 1);
model.physics('liion').feature('pce2').label('Porous Electrode - Positive');
model.physics('liion').feature('pce2').selection.named('sel2');
model.physics('liion').feature('pce2').setIndex('minput_temperature_src', 'userdef', 0);
model.physics('liion').feature('pce2').setIndex('minput_temperature', 'T', 0);
model.physics('liion').feature('pce2').set('ElectrolyteMaterial', 'mat7');
model.physics('liion').feature('pce2').set('sigma', {'sigmas_pos' '0' '0' '0' 'sigmas_pos' '0' '0' '0' 'sigmas_pos'});
model.physics('liion').feature('pce2').set('epss', 'eps_s_pos');
model.physics('liion').feature('pce2').set('epsl', 'eps_l_pos');
model.physics('liion').feature('pce2').set('AddVolumeChangeToElectrodeVolumeFraction', false);
model.physics('liion').feature('pce2').set('SubtractVolumeChangeFromElectrolyteVolumeFraction', false);
model.physics('liion').feature('pce2').setIndex('Species', 's1', 0, 0);
model.physics('liion').feature('pce2').setIndex('rhos', 8960, 0, 0);
model.physics('liion').feature('pce2').setIndex('Ms', 0.06355, 0, 0);
model.physics('liion').feature('pce2').setIndex('Species', 's1', 0, 0);
model.physics('liion').feature('pce2').setIndex('rhos', 8960, 0, 0);
model.physics('liion').feature('pce2').setIndex('Ms', 0.06355, 0, 0);
model.physics('liion').feature('pce2').setIndex('Species', 'Gas', 0, 0);
model.physics('liion').feature('pce2').feature('pin1').set('csinit', 'cs_pos_init');
model.physics('liion').feature('pce2').feature('pin1').set('rp', 'r_pos');
model.physics('liion').feature('pce2').create('per2', 'PorousElectrodeReaction', 1);
model.physics('liion').feature('pce2').feature('per1').set('i0refType', 'FromRateConstant');
model.physics('liion').feature('pce2').feature('per1').set('k', '6.3e-10[m/s]');
model.physics('liion').feature('pce2').feature('per2').set('minput_temperature_src', 'userdef');
model.physics('liion').feature('pce2').feature('per2').set('minput_temperature', 'T');
model.physics('liion').feature('pce2').feature('per2').set('Eeq_mat', 'userdef');
model.physics('liion').feature('pce2').feature('per2').set('Eeq', '4.5[V]');
model.physics('liion').feature('pce2').feature('per2').set('ElectrodeKinetics', 'AnodicTafelEquation');
model.physics('liion').feature('pce2').feature('per2').set('i0', '1e-3[A/m^2]*if(cl>1[mol/m^3],(cl/1000[mol/m^3])^0.5,cl[m^3/mol]/(1000^0.5))');
model.physics('liion').feature('pce2').feature('per2').set('VLiPlus', 0);
model.physics('liion').feature('pce2').feature('per2').set('VLiTheta', 0);
model.physics('liion').feature('pce2').feature('per2').setIndex('Vib', -1, 0, 0);
model.physics('liion').feature('pce2').feature('per2').set('dEeqdT_mat', 'userdef');
model.physics('liion').create('egnd1', 'ElectricGround', 0);
model.physics('liion').feature('egnd1').selection.set([1]);
model.physics('liion').create('ecd1', 'ElectrodeNormalCurrentDensity', 0);
model.physics('liion').feature('ecd1').label('Electrode Current Density - Charge');
model.physics('liion').feature('ecd1').selection.set([4]);
model.physics('liion').feature('ecd1').set('nis', 'i_app_ch');
model.physics('liion').feature.duplicate('ecd2', 'ecd1');
model.physics('liion').feature('ecd2').label('Electrode Current Density - Discharge');
model.physics('liion').feature('ecd2').set('nis', 'i_app_dch');
model.physics('liion').create('init2', 'init', 1);
model.physics('liion').feature('init2').selection.set([3]);
model.physics('liion').feature('init2').set('phil', '-mat8.elpot.Eeq_int1(cs_neg_init/cs_max_neg)');
model.physics('liion').feature('init2').set('phis', 'matlnk1.elpot.Eeq_int1(cs_pos_init/cs_max_pos)-mat8.elpot.Eeq_int1(cs_neg_init/cs_max_neg)');
model.physics('liion').create('weak1', 'WeakContribution', 0);
model.physics('liion').feature('weak1').selection.set([4]);
model.physics('liion').feature('weak1').label('Weak Contribution - Charge');
model.physics('liion').feature('weak1').set('weakExpression', 'test(i_app_ch)*((CV_CH==0)*(i_app_ch-i_app_charge)/i_app_charge+(CV_CH==1)*(phis-Max_cell_voltage))');
model.physics('liion').feature('weak1').create('aux1', 'AuxiliaryField', 0);
model.physics('liion').feature('weak1').feature('aux1').set('fieldVariableName', 'i_app_ch');
model.physics('liion').feature('weak1').feature('aux1').set('initialValue', 'i_app_charge');
model.physics('liion').feature.duplicate('weak2', 'weak1');
model.physics('liion').feature('weak2').label('Weak Contribution - Discharge');
model.physics('liion').feature('weak2').set('weakExpression', 'test(i_app_dch)*((CV_DCH==0)*(i_app_dch-i_app_discharge)+(CV_DCH==1)*(phis-Min_cell_voltage))');
model.physics('liion').feature('weak2').feature('aux1').set('fieldVariableName', 'i_app_dch');
model.physics('liion').feature('weak2').feature('aux1').set('initialValue', 'i_app_discharge');
model.physics('ev').create('expl1', 'ExplicitEvent', -1);
model.physics('ev').feature('expl1').set('period', 't_charge');
model.physics('ev').feature('expl1').set('useConsistentInit', false);
model.physics('ev').create('ds1', 'DiscreteStates', -1);
model.physics('ev').feature('ds1').setIndex('dim', 'CV_CH', 0, 0);
model.physics('ev').feature('ds1').setIndex('dimInit', 0, 0, 0);
model.physics('ev').create('is1', 'IndicatorStates', -1);
model.physics('ev').feature('is1').setIndex('indDim', 'to_cv_ch', 0, 0);
model.physics('ev').feature('is1').setIndex('g', 0, 0, 0);
model.physics('ev').feature('is1').setIndex('dimInit', 0, 0, 0);
model.physics('ev').feature('is1').setIndex('g', 'comp1.pos_cc(comp1.phis-Max_cell_voltage)*(CV_CH==0)', 0, 0);
model.physics('ev').create('impl1', 'ImplicitEvent', -1);
model.physics('ev').feature('impl1').set('condition', 'to_cv_ch>0');
model.physics('ev').feature('impl1').setIndex('reInitName', 'CV_CH', 0, 0);
model.physics('ev').feature('impl1').setIndex('reInitValue', 0, 0, 0);
model.physics('ev').feature('impl1').setIndex('reInitValue', 1, 0, 0);
model.physics('ev').label('Events - Charge');
model.physics('ev2').label('Events - Discharge');
model.physics('ev2').create('expl1', 'ExplicitEvent', -1);
model.physics('ev2').feature('expl1').set('start', 't_charge');
model.physics('ev2').feature('expl1').set('period', 't_discharge');
model.physics('ev2').create('ds1', 'DiscreteStates', -1);
model.physics('ev2').feature('ds1').setIndex('dim', 'CV_DCH', 0, 0);
model.physics('ev2').feature('ds1').setIndex('dimInit', 0, 0, 0);
model.physics('ev2').create('is1', 'IndicatorStates', -1);
model.physics('ev2').feature('is1').setIndex('indDim', 'to_cv_dch', 0, 0);
model.physics('ev2').feature('is1').setIndex('g', 0, 0, 0);
model.physics('ev2').feature('is1').setIndex('dimInit', 0, 0, 0);
model.physics('ev2').feature('is1').setIndex('g', '-comp1.pos_cc(comp1.phis-Min_cell_voltage)*(CV_DCH==0)', 0, 0);
model.physics('ev2').create('impl1', 'ImplicitEvent', -1);
model.physics('ev2').feature('impl1').set('condition', 'to_cv_dch>0');
model.physics('ev2').feature('impl1').setIndex('reInitName', 'CV_DCH', 0, 0);
model.physics('ev2').feature('impl1').setIndex('reInitValue', 0, 0, 0);
model.physics('ev2').feature('impl1').setIndex('reInitValue', 1, 0, 0);
model.physics('ge').label('Global ODEs and DAEs - Energy calculations');
model.physics('ge').feature('ge1').setIndex('name', 'W_electric_charge', 0, 0);
model.physics('ge').feature('ge1').setIndex('equation', 'W_electric_charget-pos_cc(phis)*i_app*A_cell*CHARGE', 0, 0);
model.physics('ge').feature('ge1').setIndex('description', 'Electric energy required during charge', 0, 0);
model.physics('ge').feature('ge1').setIndex('name', 'W_heat', 1, 0);
model.physics('ge').feature('ge1').setIndex('equation', '', 1, 0);
model.physics('ge').feature('ge1').setIndex('initialValueU', 0, 1, 0);
model.physics('ge').feature('ge1').setIndex('initialValueUt', 0, 1, 0);
model.physics('ge').feature('ge1').setIndex('description', '', 1, 0);
model.physics('ge').feature('ge1').setIndex('equation', 'W_heatt-int_all(liion.Qh)*A_cell', 1, 0);
model.physics('ge').feature('ge1').setIndex('description', 'Dissipated heat', 1, 0);
model.physics('ge').feature('ge1').setIndex('name', 'W_electric_discharge', 2, 0);
model.physics('ge').feature('ge1').setIndex('equation', '', 2, 0);
model.physics('ge').feature('ge1').setIndex('initialValueU', 0, 2, 0);
model.physics('ge').feature('ge1').setIndex('initialValueUt', 0, 2, 0);
model.physics('ge').feature('ge1').setIndex('description', '', 2, 0);
model.physics('ge').feature('ge1').setIndex('equation', 'W_electric_discharget-pos_cc(phis)*i_app*A_cell*DISCHARGE', 2, 0);
model.physics('ge').feature('ge1').setIndex('description', 'Electric energy released during discharge', 2, 0);
model.physics('ge').feature('ge1').set('DependentVariableQuantity', 'energy');
model.physics('ge').feature('ge1').set('SourceTermQuantity', 'power');
model.physics('ge2').label('Global ODEs and DAEs - Temperature Calculation');
model.physics('ge2').feature('ge1').setIndex('name', 'T', 0, 0);
model.physics('ge2').feature('ge1').setIndex('equation', 'Tt*rho_batt*Cp_batt*Vol-Q_tot+A_batt*k_batt*(T-T0)', 0, 0);
model.physics('ge2').feature('ge1').setIndex('initialValueU', 'T0', 0, 0);
model.physics('ge2').feature('ge1').setIndex('description', 'Cell Temperature', 0, 0);
model.physics('ge2').feature('ge1').set('DependentVariableQuantity', 'temperature');
model.physics('ge2').feature('ge1').set('SourceTermQuantity', 'power');

model.mesh('mesh1').automatic(false);
model.mesh('mesh1').feature('size2').selection.set([3]);
model.mesh('mesh1').feature('size2').set('custom', true);
model.mesh('mesh1').feature('size2').set('hmaxactive', true);
model.mesh('mesh1').feature('size2').set('hmax', 'L_pos/50');
model.mesh('mesh1').feature.duplicate('size3', 'size2');
model.mesh('mesh1').feature('size3').selection.set([2]);
model.mesh('mesh1').feature('size3').set('hmax', 'L_neg/50');
model.mesh('mesh1').feature.move('size3', 3);
model.mesh('mesh1').run;

model.study('std1').create('cdi2', 'CurrentDistributionInitialization');
model.study('std1').create('time2', 'Transient');
model.study('std1').feature('cdi').label('Current Distribution Initialization - Charge');
model.study('std1').feature('cdi').set('initType', 'secondary');
model.study('std1').feature('cdi').setEntry('activate', 'ge', false);
model.study('std1').feature('cdi').setEntry('activate', 'ge2', false);
model.study('std1').feature('cdi').set('useadvanceddisable', true);
model.study('std1').feature('cdi').set('disabledvariables', {'var4'});
model.study('std1').feature('cdi').set('disabledphysics', {'liion/ecd2' 'liion/weak2' 'ev2'});
model.study('std1').feature('time').label('Time Dependent - Charge');
model.study('std1').feature('time').set('tlist', '0 t_charge/500 t_charge/100 range(t_charge/50,t_charge/50,t_charge)');
model.study('std1').feature('time').setEntry('activate', 'ev2', false);
model.study('std1').feature('time').set('useadvanceddisable', true);
model.study('std1').feature('time').set('disabledvariables', {'var4'});
model.study('std1').feature('time').set('disabledphysics', {'liion/ecd2' 'liion/weak2' 'ev2'});
model.study('std1').feature('cdi2').label('Current Distribution Initialization - Discharge');
model.study('std1').feature('cdi2').set('initType', 'secondary');
model.study('std1').feature('cdi2').setEntry('activate', 'ge', false);
model.study('std1').feature('cdi2').setEntry('activate', 'ge2', false);
model.study('std1').feature('cdi2').set('useadvanceddisable', true);
model.study('std1').feature('cdi2').set('disabledvariables', {'var3'});
model.study('std1').feature('cdi2').set('disabledphysics', {'liion/ecd1' 'liion/weak1' 'ev'});
model.study('std1').feature('time2').label('Time Dependent - Discharge');
model.study('std1').feature('time2').set('tlist', 't_charge t_charge+t_discharge/500 t_charge+t_discharge/100 range(t_charge+t_discharge/50,t_discharge/50,t_charge+t_discharge)');
model.study('std1').feature('time2').setEntry('activate', 'ev', false);
model.study('std1').feature('time2').set('useadvanceddisable', true);
model.study('std1').feature('time2').set('disabledvariables', {'var3'});
model.study('std1').feature('time2').set('disabledphysics', {'liion/ecd1' 'liion/weak1' 'ev'});
model.study('std1').create('cmbsol', 'CombineSolution');

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
model.sol('sol1').feature('v2').feature('comp1_liion_pce2_cs').set('scalemethod', 'manual');
model.sol('sol1').feature('v2').feature('comp1_liion_pce1_cs').set('scalemethod', 'manual');
model.sol('sol1').feature('v2').feature('comp1_phis').set('scalemethod', 'manual');
model.sol('sol1').feature('v2').feature('comp1_cl').set('scalemethod', 'manual');
model.sol('sol1').feature('v2').feature('comp1_phil').set('scaleval', '1');
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
model.sol('sol1').feature('t1').set('tlist', '0 t_charge/500 t_charge/100 range(t_charge/50,t_charge/50,t_charge)');
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
model.sol('sol1').create('su2', 'StoreSolution');
model.sol('sol1').create('st3', 'StudyStep');
model.sol('sol1').feature('st3').set('study', 'std1');
model.sol('sol1').feature('st3').set('studystep', 'cdi2');
model.sol('sol1').create('v3', 'Variables');
model.sol('sol1').feature('v3').feature('comp1_phil').set('scalemethod', 'manual');
model.sol('sol1').feature('v3').feature('comp1_phis').set('scalemethod', 'manual');
model.sol('sol1').feature('v3').feature('comp1_cl').set('scalemethod', 'manual');
model.sol('sol1').feature('v3').feature('comp1_phil').set('scaleval', '1');
model.sol('sol1').feature('v3').feature('comp1_phis').set('scaleval', '1');
model.sol('sol1').feature('v3').feature('comp1_cl').set('scaleval', '1000');
model.sol('sol1').feature('v3').set('initmethod', 'sol');
model.sol('sol1').feature('v3').set('initsol', 'sol1');
model.sol('sol1').feature('v3').set('initsoluse', 'sol3');
model.sol('sol1').feature('v3').set('notsolmethod', 'sol');
model.sol('sol1').feature('v3').set('notsol', 'sol1');
model.sol('sol1').feature('v3').set('control', 'cdi2');
model.sol('sol1').create('s2', 'Stationary');
model.sol('sol1').feature('s2').set('stol', 1.0E-4);
model.sol('sol1').feature('s2').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('s2').feature('fc1').set('dtech', 'auto');
model.sol('sol1').feature('s2').feature('fc1').set('maxiter', 50);
model.sol('sol1').feature('s2').feature('fc1').set('minstep', 1.0E-6);
model.sol('sol1').feature('s2').create('d1', 'Direct');
model.sol('sol1').feature('s2').feature('d1').set('linsolver', 'pardiso');
model.sol('sol1').feature('s2').feature('d1').label('Direct (liion)');
model.sol('sol1').feature('s2').create('i1', 'Iterative');
model.sol('sol1').feature('s2').feature('i1').set('maxlinit', 1000);
model.sol('sol1').feature('s2').feature('i1').set('nlinnormuse', 'on');
model.sol('sol1').feature('s2').feature('i1').label('Algebraic Multigrid (liion)');
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
model.sol('sol1').feature('s2').feature('i2').label('Geometric Multigrid (liion)');
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
model.sol('sol1').create('su3', 'StoreSolution');
model.sol('sol1').create('st4', 'StudyStep');
model.sol('sol1').feature('st4').set('study', 'std1');
model.sol('sol1').feature('st4').set('studystep', 'time2');
model.sol('sol1').create('v4', 'Variables');
model.sol('sol1').feature('v4').feature('comp1_phil').set('scalemethod', 'manual');
model.sol('sol1').feature('v4').feature('comp1_liion_pce2_cs').set('scalemethod', 'manual');
model.sol('sol1').feature('v4').feature('comp1_liion_pce1_cs').set('scalemethod', 'manual');
model.sol('sol1').feature('v4').feature('comp1_phis').set('scalemethod', 'manual');
model.sol('sol1').feature('v4').feature('comp1_cl').set('scalemethod', 'manual');
model.sol('sol1').feature('v4').feature('comp1_phil').set('scaleval', '1');
model.sol('sol1').feature('v4').feature('comp1_liion_pce2_cs').set('scaleval', '10000');
model.sol('sol1').feature('v4').feature('comp1_liion_pce1_cs').set('scaleval', '10000');
model.sol('sol1').feature('v4').feature('comp1_phis').set('scaleval', '1');
model.sol('sol1').feature('v4').feature('comp1_cl').set('scaleval', '1000');
model.sol('sol1').feature('v4').set('initmethod', 'sol');
model.sol('sol1').feature('v4').set('initsol', 'sol1');
model.sol('sol1').feature('v4').set('initsoluse', 'sol4');
model.sol('sol1').feature('v4').set('notsolmethod', 'sol');
model.sol('sol1').feature('v4').set('notsol', 'sol1');
model.sol('sol1').feature('v4').set('notsoluse', 'sol4');
model.sol('sol1').feature('v4').set('control', 'time2');
model.sol('sol1').create('t2', 'Time');
model.sol('sol1').feature('t2').set('tlist', 't_charge t_charge+t_discharge/500 t_charge+t_discharge/100 range(t_charge+t_discharge/50,t_discharge/50,t_charge+t_discharge)');
model.sol('sol1').feature('t2').set('plot', 'off');
model.sol('sol1').feature('t2').set('plotgroup', 'Default');
model.sol('sol1').feature('t2').set('plotfreq', 'tout');
model.sol('sol1').feature('t2').set('probesel', 'all');
model.sol('sol1').feature('t2').set('probes', {'var1'});
model.sol('sol1').feature('t2').set('probefreq', 'tsteps');
model.sol('sol1').feature('t2').set('rtol', 0.001);
model.sol('sol1').feature('t2').set('atolglobalvaluemethod', 'factor');
model.sol('sol1').feature('t2').set('eventout', true);
model.sol('sol1').feature('t2').set('reacf', true);
model.sol('sol1').feature('t2').set('storeudot', true);
model.sol('sol1').feature('t2').set('endtimeinterpolation', true);
model.sol('sol1').feature('t2').set('maxorder', 2);
model.sol('sol1').feature('t2').set('initialstepbdfactive', true);
model.sol('sol1').feature('t2').set('initialstepbdf', '(1)[s]');
model.sol('sol1').feature('t2').set('control', 'time2');
model.sol('sol1').feature('t2').feature('aDef').set('cachepattern', true);
model.sol('sol1').feature('t2').create('seDef', 'Segregated');
model.sol('sol1').feature('t2').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('t2').feature('fc1').set('dtech', 'auto');
model.sol('sol1').feature('t2').create('d1', 'Direct');
model.sol('sol1').feature('t2').feature('d1').label('Direct (Merged)');
model.sol('sol1').feature('t2').create('i1', 'Iterative');
model.sol('sol1').feature('t2').feature('i1').set('maxlinit', 1000);
model.sol('sol1').feature('t2').feature('i1').set('nlinnormuse', 'on');
model.sol('sol1').feature('t2').feature('i1').label('Algebraic Multigrid (liion)');
model.sol('sol1').feature('t2').feature('i1').create('mg1', 'Multigrid');
model.sol('sol1').feature('t2').feature('i1').feature('mg1').set('prefun', 'saamg');
model.sol('sol1').feature('t2').feature('i1').feature('mg1').set('maxcoarsedof', 50000);
model.sol('sol1').feature('t2').feature('i1').feature('mg1').set('saamgcompwise', true);
model.sol('sol1').feature('t2').feature('i1').feature('mg1').set('compactaggregation', true);
model.sol('sol1').feature('t2').feature('i1').feature('mg1').feature('pr').create('sl1', 'SORLine');
model.sol('sol1').feature('t2').feature('i1').feature('mg1').feature('po').create('sl1', 'SORLine');
model.sol('sol1').feature('t2').feature('i1').feature('mg1').feature('cs').create('d1', 'Direct');
model.sol('sol1').feature('t2').feature('i1').feature('mg1').feature('cs').feature('d1').set('linsolver', 'pardiso');
model.sol('sol1').feature('t2').create('i2', 'Iterative');
model.sol('sol1').feature('t2').feature('i2').set('maxlinit', 1000);
model.sol('sol1').feature('t2').feature('i2').set('nlinnormuse', 'on');
model.sol('sol1').feature('t2').feature('i2').label('Geometric Multigrid (liion)');
model.sol('sol1').feature('t2').feature('i2').create('mg1', 'Multigrid');
model.sol('sol1').feature('t2').feature('i2').feature('mg1').feature('pr').create('sl1', 'SORLine');
model.sol('sol1').feature('t2').feature('i2').feature('mg1').feature('po').create('sl1', 'SORLine');
model.sol('sol1').feature('t2').feature('i2').feature('mg1').feature('cs').create('d1', 'Direct');
model.sol('sol1').feature('t2').feature('i2').feature('mg1').feature('cs').feature('d1').set('linsolver', 'pardiso');
model.sol('sol1').feature('t2').feature('fc1').set('linsolver', 'd1');
model.sol('sol1').feature('t2').feature('fc1').set('dtech', 'auto');
model.sol('sol1').feature('t2').feature.remove('fcDef');
model.sol('sol1').feature('t2').feature.remove('seDef');
model.sol('sol1').create('su4', 'StoreSolution');
model.sol('sol1').create('cms1', 'CombineSolution');
model.sol('sol1').feature('cms1').set('control', 'cmbsol');
model.sol('sol1').feature('v3').set('notsolnum', 'auto');
model.sol('sol1').feature('v3').set('notsolvertype', 'solnum');
model.sol('sol1').attach('std1');

model.study('std1').feature('cmbsol').set('cssol1', 'sol3');
model.study('std1').feature('cmbsol').set('cssol2', 'sol5');
model.study('std1').setGenPlots(false);

model.sol('sol1').feature('s1').set('stol', '1e-6');
model.sol('sol1').feature('v3').set('control', 'user');
model.sol('sol1').feature('s2').set('stol', '1e-6');

model.probe('var1').genResult('none');

model.sol('sol1').runAll;

model.result.numerical.create('gev2', 'EvalGlobal');
model.result.numerical('gev2').set('expr', {});
model.result.numerical('gev2').set('descr', {});
model.result.numerical('gev2').setIndex('expr', 'W_electric_charge/1[W*h]', 0);
model.result.numerical('gev2').label('Global Evaluation - Energy and power, charge');
model.result.numerical.create('gev3', 'EvalGlobal');
model.result.numerical('gev3').label('Global Evaluation - Minimum potential in negative electrode');
model.result.numerical('gev3').set('expr', {});
model.result.numerical('gev3').set('descr', {});
model.result.numerical('gev3').setIndex('expr', 'min_neg(phis-phil)', 0);
model.result.numerical('gev3').setIndex('descr', 'Minimum potential vs. Li/Li+ in Negative Electrode', 0);
model.result.numerical('gev3').set('dataseries', 'minimum');
model.result.numerical.create('gev4', 'EvalGlobal');
model.result.numerical('gev4').label('Global Evaluation - Maximum potential in positive electrode');
model.result.numerical('gev4').set('expr', {});
model.result.numerical('gev4').set('descr', {});
model.result.numerical('gev4').setIndex('expr', 'max_pos(phis-phil)', 0);
model.result.numerical('gev4').setIndex('descr', 'Maximum potential vs. Li/Li+ in Positive Electrode', 0);
model.result.numerical('gev4').set('dataseries', 'maximum');
model.result.numerical.create('gev5', 'EvalGlobal');
model.result.numerical('gev5').label('Global Evaluation - Lithium inventory loss, plating');
model.result.numerical('gev5').set('expr', {});
model.result.numerical('gev5').set('descr', {});
model.result.numerical('gev5').setIndex('expr', 'negative(liion.c_pce1_LiMetal*A_cell*F_const/(3600*Q_cycle))', 0);
model.result.numerical('gev5').setIndex('descr', 'Charge lost to plating (relative to cycle throughput)', 0);
model.result.numerical.create('gev6', 'EvalGlobal');
model.result.numerical('gev6').label('Global Evaluation - Cell voltage');
model.result.numerical('gev6').set('expr', {});
model.result.numerical('gev6').set('descr', {});
model.result.numerical('gev6').setIndex('expr', 'Ecell', 0);
model.result.numerical('gev6').set('dataseries', 'average');
model.result.numerical.create('gev7', 'EvalGlobal');
model.result.numerical('gev7').label('Global Evaluation - Generated heat');
model.result.numerical('gev7').set('expr', {});
model.result.numerical('gev7').set('descr', {});
model.result.numerical('gev7').setIndex('expr', 'Q_tot/1[W*h]', 0);
model.result.numerical('gev7').set('dataseries', 'integral');
model.result.numerical.create('gev8', 'EvalGlobal');
model.result.numerical('gev8').label('Global Evaluation - Cycle efficiency');
model.result.numerical('gev8').set('expr', {});
model.result.numerical('gev8').set('descr', {});
model.result.numerical('gev8').setIndex('expr', 'W_electric_charge/W_electric_discharge', 0);
model.result.numerical('gev8').setIndex('descr', 'Cycle efficiency', 0);
model.result.numerical.create('gev9', 'EvalGlobal');
model.result.numerical('gev9').label('Global Evaluation - Average electric power during charge');
model.result.numerical('gev9').set('expr', {});
model.result.numerical('gev9').set('descr', {});
model.result.numerical('gev9').setIndex('expr', 'P_avg_charge', 0);
model.result.numerical('gev9').set('dataseries', 'average');
model.result.numerical.duplicate('gev10', 'gev9');
model.result.numerical('gev10').label('Global Evaluation - Average electric power during discharge');
model.result.numerical('gev10').setIndex('expr', 'P_avg_discharge', 0);
model.result.numerical.create('gev11', 'EvalGlobal');
model.result.numerical('gev11').label('Global Evaluation - Li inventory loss, gassing');
model.result.numerical('gev11').set('expr', {});
model.result.numerical('gev11').set('descr', {});
model.result.numerical('gev11').setIndex('expr', 'positive(liion.c_pce2_Gas*A_cell*F_const/(3600*Q_cycle))', 0);
model.result.numerical('gev11').setIndex('descr', 'Charge lost to gassing (relative to cycle throughput)', 0);
model.result.numerical.create('gev12', 'EvalGlobal');
model.result.numerical('gev12').label('Global Evaluation - Energy and power, discharge');
model.result.numerical('gev12').set('expr', {});
model.result.numerical('gev12').set('descr', {});
model.result.numerical('gev12').setIndex('expr', 'W_electric_discharge/1[W*h]', 0);
model.result.create('pg2', 'PlotGroup1D');
model.result('pg2').run;
model.result('pg2').label('Cell Potential and Load vs. Time');
model.result('pg2').set('titletype', 'label');
model.result('pg2').set('twoyaxes', true);
model.result('pg2').set('ylabelactive', true);
model.result('pg2').set('ylabel', 'Voltage(V)');
model.result('pg2').set('yseclabelactive', true);
model.result('pg2').set('yseclabel', 'C rate (1)');
model.result('pg2').create('ptgr1', 'PointGraph');
model.result('pg2').feature('ptgr1').set('markerpos', 'datapoints');
model.result('pg2').feature('ptgr1').set('linewidth', 'preference');
model.result('pg2').feature('ptgr1').selection.set([4]);
model.result('pg2').feature('ptgr1').set('expr', 'phis');
model.result('pg2').run;
model.result('pg2').create('glob1', 'Global');
model.result('pg2').feature('glob1').set('markerpos', 'datapoints');
model.result('pg2').feature('glob1').set('linewidth', 'preference');
model.result('pg2').feature('glob1').set('expr', {});
model.result('pg2').feature('glob1').set('descr', {});
model.result('pg2').feature('glob1').setIndex('expr', 'EOCVcell', 0);
model.result('pg2').run;
model.result('pg2').create('ptgr2', 'PointGraph');
model.result('pg2').feature('ptgr2').set('markerpos', 'datapoints');
model.result('pg2').feature('ptgr2').set('linewidth', 'preference');
model.result('pg2').feature('ptgr2').selection.set([4]);
model.result('pg2').feature('ptgr2').set('plotonsecyaxis', true);
model.result('pg2').feature('ptgr2').set('expr', '-liion.nIs/I_1C');
model.result('pg2').feature('ptgr2').set('descractive', true);
model.result('pg2').feature('ptgr2').set('descr', 'C rate');
model.result('pg2').run;
model.result('pg2').feature('ptgr2').set('legend', true);
model.result('pg2').feature('ptgr2').set('legendmethod', 'manual');
model.result('pg2').feature('ptgr2').setIndex('legends', 'C rate', 0);
model.result('pg2').run;
model.result('pg2').feature('ptgr1').set('legend', true);
model.result('pg2').feature('ptgr1').set('legendmethod', 'manual');
model.result('pg2').feature('ptgr1').setIndex('legends', 'Cell Voltage', 0);
model.result('pg2').run;
model.result('pg2').run;
model.result.create('pg3', 'PlotGroup1D');
model.result('pg3').run;
model.result('pg3').label('Positive Electrode Potentials vs. Time');
model.result('pg3').set('titletype', 'label');
model.result('pg3').set('xlabelactive', true);
model.result('pg3').set('ylabelactive', true);
model.result('pg3').set('xlabel', 'Time(s)');
model.result('pg3').set('ylabel', 'Potential vs. Li/Li<sup>+</sup>');
model.result('pg3').create('ptgr1', 'PointGraph');
model.result('pg3').feature('ptgr1').set('markerpos', 'datapoints');
model.result('pg3').feature('ptgr1').set('linewidth', 'preference');
model.result('pg3').feature('ptgr1').selection.set([3 4]);
model.result('pg3').feature('ptgr1').set('expr', 'phis-phil');
model.result('pg3').feature('ptgr1').set('legend', true);
model.result('pg3').feature('ptgr1').set('legendmethod', 'manual');
model.result('pg3').feature('ptgr1').setIndex('legends', 'Separator - Electrode', 0);
model.result('pg3').feature('ptgr1').setIndex('legends', 'Positive CC - Electrode', 1);
model.result('pg3').run;
model.result('pg3').create('glob1', 'Global');
model.result('pg3').feature('glob1').set('markerpos', 'datapoints');
model.result('pg3').feature('glob1').set('linewidth', 'preference');
model.result('pg3').feature('glob1').set('expr', {});
model.result('pg3').feature('glob1').set('descr', {});
model.result('pg3').feature('glob1').setIndex('expr', 'EOCPpos', 0);
model.result('pg3').feature('glob1').setIndex('unit', '', 0);
model.result('pg3').run;
model.result('pg3').run;
model.result.duplicate('pg4', 'pg3');
model.result('pg4').run;
model.result('pg4').label('Negative Electrode Potentials vs. Time');
model.result('pg4').run;
model.result('pg4').feature('ptgr1').selection.set([1 2]);
model.result('pg4').feature('ptgr1').setIndex('legends', 'Negative CC - Electrode', 0);
model.result('pg4').feature('ptgr1').setIndex('legends', 'Separator - Electrode', 1);
model.result('pg4').run;
model.result('pg4').feature('glob1').setIndex('expr', 'EOCPneg', 0);
model.result('pg4').feature('glob1').setIndex('descr', 'Corresponding OCV', 0);
model.result.create('pg5', 'PlotGroup1D');
model.result('pg5').run;
model.result('pg5').label('Temperature and Heat sources vs. Time');
model.result('pg5').set('titletype', 'label');
model.result('pg5').set('twoyaxes', true);
model.result('pg5').set('xlabelactive', true);
model.result('pg5').set('ylabelactive', true);
model.result('pg5').set('yseclabelactive', true);
model.result('pg5').set('xlabel', 'Time (s)');
model.result('pg5').set('ylabel', 'Temperature (<sup>\circ</sup>C)');
model.result('pg5').set('yseclabel', 'Generated Heat (W)');
model.result('pg5').create('glob1', 'Global');
model.result('pg5').feature('glob1').set('markerpos', 'datapoints');
model.result('pg5').feature('glob1').set('linewidth', 'preference');
model.result('pg5').feature('glob1').set('expr', {});
model.result('pg5').feature('glob1').set('descr', {});
model.result('pg5').feature('glob1').setIndex('expr', 'T', 0);
model.result('pg5').feature('glob1').setIndex('unit', 'degC', 0);
model.result('pg5').run;
model.result('pg5').create('glob2', 'Global');
model.result('pg5').feature('glob2').set('markerpos', 'datapoints');
model.result('pg5').feature('glob2').set('linewidth', 'preference');
model.result('pg5').feature('glob2').set('expr', {});
model.result('pg5').feature('glob2').set('descr', {});
model.result('pg5').feature('glob2').set('plotonsecyaxis', true);
model.result('pg5').feature('glob2').setIndex('expr', 'Q_tot', 0);
model.result('pg5').feature('glob2').setIndex('descr', 'Total', 0);
model.result('pg5').feature('glob2').setIndex('expr', 'Q_J_l_sep', 1);
model.result('pg5').feature('glob2').setIndex('descr', 'Joute heating, separator', 1);
model.result('pg5').feature('glob2').setIndex('expr', 'Q_J_s_pos+Q_J_l_pos', 2);
model.result('pg5').feature('glob2').setIndex('descr', 'Joute heating, positive', 2);
model.result('pg5').feature('glob2').setIndex('expr', 'Q_J_s_neg+Q_J_l_neg', 3);
model.result('pg5').feature('glob2').setIndex('descr', 'Joute heating, negative', 3);
model.result('pg5').feature('glob2').setIndex('expr', 'Q_act_pos', 4);
model.result('pg5').feature('glob2').setIndex('descr', 'Reaction heating, positive', 4);
model.result('pg5').feature('glob2').setIndex('expr', 'Q_act_neg', 5);
model.result('pg5').feature('glob2').setIndex('descr', 'Reaction heating, negative', 5);
model.result.create('pg6', 'PlotGroup1D');
model.result('pg6').run;
model.result('pg6').label('Parasitic Lithium Losses vs. Time');
model.result('pg6').set('titletype', 'label');
model.result('pg6').set('xlabelactive', true);
model.result('pg6').set('xlabel', 'Time (s)');
model.result('pg6').set('ylabelactive', true);
model.result('pg6').set('ylabel', 'Rate (A)');
model.result('pg6').set('ylog', true);
model.result('pg6').create('glob1', 'Global');
model.result('pg6').feature('glob1').set('markerpos', 'datapoints');
model.result('pg6').feature('glob1').set('linewidth', 'preference');
model.result('pg6').feature('glob1').set('expr', {});
model.result('pg6').feature('glob1').set('descr', {});
model.result('pg6').feature('glob1').setIndex('expr', 'positive(liion.iv_per2)*A_cell', 0);
model.result('pg6').feature('glob1').setIndex('descr', 'Gassing (Positive Electrode)', 0);
model.result('pg6').feature.duplicate('glob2', 'glob1');
model.result('pg6').run;
model.result('pg6').feature('glob2').setIndex('expr', '-negative(liion.iv_per2)*A_cell', 0);
model.result('pg6').feature('glob2').setIndex('descr', 'Plating (Negative Electrode)', 0);
model.result.create('pg7', 'PlotGroup1D');
model.result('pg7').run;
model.result('pg7').label('Electrolyte Potential Distribution');
model.result('pg7').set('titletype', 'label');
model.result('pg7').set('ylabelactive', true);
model.result('pg7').set('ylabel', 'Potential (V)');
model.result('pg7').create('lngr1', 'LineGraph');
model.result('pg7').feature('lngr1').set('markerpos', 'datapoints');
model.result('pg7').feature('lngr1').set('linewidth', 'preference');
model.result('pg7').feature('lngr1').selection.all;
model.result('pg7').feature('lngr1').set('expr', 'phil-neg_cc(phil)');
model.result('pg7').feature('lngr1').set('xdata', 'expr');
model.result('pg7').feature('lngr1').set('xdataexpr', 'x');
model.result('pg7').feature('lngr1').set('xdataunit', [native2unicode(hex2dec({'00' 'b5'}), 'unicode') 'm']);
model.result('pg7').feature('lngr1').set('legend', true);
model.result('pg7').feature('lngr1').set('legendmethod', 'manual');
model.result('pg7').feature('lngr1').setIndex('legends', 'Start of charge', 0);
model.result('pg7').feature('lngr1').set('data', 'dset2');
model.result('pg7').feature.duplicate('lngr2', 'lngr1');
model.result('pg7').run;
model.result('pg7').feature('lngr2').set('data', 'dset3');
model.result('pg7').feature('lngr2').setIndex('looplevelinput', 'last', 0);
model.result('pg7').feature('lngr2').setIndex('legends', 'End of charge', 0);
model.result('pg7').feature.duplicate('lngr3', 'lngr2');
model.result('pg7').run;
model.result('pg7').feature('lngr3').set('data', 'dset4');
model.result('pg7').feature('lngr3').setIndex('legends', 'Start of Discharge', 0);
model.result('pg7').feature.duplicate('lngr4', 'lngr3');
model.result('pg7').run;
model.result('pg7').feature('lngr4').set('data', 'dset5');
model.result('pg7').feature('lngr4').setIndex('looplevelinput', 'last', 0);
model.result('pg7').feature('lngr4').setIndex('legends', 'End of Discharge', 0);
model.result('pg7').run;
model.result.duplicate('pg8', 'pg7');
model.result('pg8').run;
model.result('pg8').label('Electrode Phase Potential Distribution');
model.result('pg8').run;
model.result('pg8').feature('lngr1').set('expr', 'EvsCC');
model.result('pg8').run;
model.result('pg8').feature('lngr2').set('expr', 'EvsCC');
model.result('pg8').run;
model.result('pg8').feature('lngr3').set('expr', 'EvsCC');
model.result('pg8').run;
model.result('pg8').feature('lngr4').set('expr', 'EvsCC');
model.result('pg8').run;
model.result.create('pg9', 'PlotGroup1D');
model.result('pg9').run;
model.result('pg9').label('Electrolyte Concentration Distribution');
model.result('pg9').set('data', 'none');
model.result('pg9').set('titletype', 'label');
model.result('pg9').create('lngr1', 'LineGraph');
model.result('pg9').feature('lngr1').set('markerpos', 'datapoints');
model.result('pg9').feature('lngr1').set('linewidth', 'preference');
model.result('pg9').feature('lngr1').set('data', 'dset2');
model.result('pg9').feature('lngr1').selection.all;
model.result('pg9').feature('lngr1').set('expr', 'cl');
model.result('pg9').feature('lngr1').set('xdata', 'expr');
model.result('pg9').feature('lngr1').set('xdataexpr', 'x');
model.result('pg9').feature('lngr1').set('xdataunit', [native2unicode(hex2dec({'00' 'b5'}), 'unicode') 'm']);
model.result('pg9').feature('lngr1').set('legend', true);
model.result('pg9').feature('lngr1').set('legendmethod', 'manual');
model.result('pg9').feature('lngr1').setIndex('legends', 'Start of charge', 0);
model.result('pg9').feature.duplicate('lngr2', 'lngr1');
model.result('pg9').run;
model.result('pg9').feature('lngr2').set('data', 'dset3');
model.result('pg9').feature('lngr2').setIndex('looplevelinput', 'last', 0);
model.result('pg9').feature('lngr2').setIndex('legends', 'End of charge - Start of discharge', 0);
model.result('pg9').feature.duplicate('lngr3', 'lngr2');
model.result('pg9').run;
model.result('pg9').feature('lngr3').set('data', 'dset5');
model.result('pg9').feature('lngr3').setIndex('legends', 'End of discharge', 0);
model.result.create('pg10', 'PlotGroup1D');
model.result('pg10').run;
model.result('pg10').label('Electrolyte Conductivity Distribution');
model.result('pg10').set('data', 'none');
model.result('pg10').set('titletype', 'label');
model.result('pg10').set('xlabelactive', true);
model.result('pg10').set('xlabel', ['x-coordinate (' native2unicode(hex2dec({'00' 'b5'}), 'unicode') 'm)']);
model.result('pg10').set('ylabelactive', true);
model.result('pg10').set('ylabel', 'Electrolyte conductivity (S/m)');
model.result('pg10').create('lngr1', 'LineGraph');
model.result('pg10').feature('lngr1').set('markerpos', 'datapoints');
model.result('pg10').feature('lngr1').set('linewidth', 'preference');
model.result('pg10').feature('lngr1').set('data', 'dset2');
model.result('pg10').feature('lngr1').selection.all;
model.result('pg10').feature('lngr1').set('expr', 'liion.sigmalxx');
model.result('pg10').feature('lngr1').set('xdata', 'expr');
model.result('pg10').feature('lngr1').set('xdataexpr', 'x');
model.result('pg10').feature('lngr1').set('xdataunit', [native2unicode(hex2dec({'00' 'b5'}), 'unicode') 'm']);
model.result('pg10').feature('lngr1').set('legend', true);
model.result('pg10').feature('lngr1').set('legendmethod', 'manual');
model.result('pg10').feature('lngr1').setIndex('legends', 'Start of charge', 0);
model.result('pg10').feature.duplicate('lngr2', 'lngr1');
model.result('pg10').run;
model.result('pg10').feature('lngr2').set('data', 'dset3');
model.result('pg10').feature('lngr2').setIndex('looplevelinput', 'last', 0);
model.result('pg10').feature('lngr2').setIndex('legends', 'End of charge - Start of discharge', 0);
model.result('pg10').feature.duplicate('lngr3', 'lngr2');
model.result('pg10').run;
model.result('pg10').feature('lngr3').set('data', 'dset5');
model.result('pg10').feature('lngr3').setIndex('legends', 'End of discharge', 0);
model.result.create('pg11', 'PlotGroup1D');
model.result('pg11').run;
model.result('pg11').label('Integrated Lithium Loss Distribution');
model.result('pg11').set('data', 'none');
model.result('pg11').set('titletype', 'label');
model.result('pg11').set('ylabelactive', true);
model.result('pg11').set('ylabel', 'Integrated Lithium Loss (mol/m<sup>3</sup>)');
model.result('pg11').create('lngr1', 'LineGraph');
model.result('pg11').feature('lngr1').set('markerpos', 'datapoints');
model.result('pg11').feature('lngr1').set('linewidth', 'preference');
model.result('pg11').feature('lngr1').set('data', 'dset2');
model.result('pg11').feature('lngr1').selection.all;
model.result('pg11').feature('lngr1').set('expr', 'CapLoss');
model.result('pg11').feature('lngr1').set('xdata', 'expr');
model.result('pg11').feature('lngr1').set('xdataexpr', 'x');
model.result('pg11').feature('lngr1').set('xdataunit', [native2unicode(hex2dec({'00' 'b5'}), 'unicode') 'm']);
model.result('pg11').feature('lngr1').set('legend', true);
model.result('pg11').feature('lngr1').set('legendmethod', 'manual');
model.result('pg11').feature('lngr1').setIndex('legends', 'Start of charge', 0);
model.result('pg11').feature.duplicate('lngr2', 'lngr1');
model.result('pg11').run;
model.result('pg11').feature('lngr2').set('data', 'dset3');
model.result('pg11').feature('lngr2').setIndex('looplevelinput', 'last', 0);
model.result('pg11').feature('lngr2').setIndex('legends', 'End charge - Start of discharge', 0);
model.result('pg11').feature.duplicate('lngr3', 'lngr2');
model.result('pg11').run;
model.result('pg11').feature('lngr3').set('data', 'dset5');
model.result('pg11').feature('lngr3').setIndex('legends', 'End of discharge', 0);
model.result.create('pg12', 'PlotGroup1D');
model.result('pg12').run;
model.result('pg12').label('Electrode SOC Distribution');
model.result('pg12').set('data', 'none');
model.result('pg12').set('titletype', 'label');
model.result('pg12').set('ylabelactive', true);
model.result('pg12').set('ylabel', 'Electrode state of charge (1)');
model.result('pg12').set('legendpos', 'upperleft');
model.result('pg12').create('lngr1', 'LineGraph');
model.result('pg12').feature('lngr1').set('markerpos', 'datapoints');
model.result('pg12').feature('lngr1').set('linewidth', 'preference');
model.result('pg12').feature('lngr1').set('data', 'dset2');
model.result('pg12').feature('lngr1').selection.all;
model.result('pg12').feature('lngr1').set('expr', 'liion.cs_surface/liion.csmax');
model.result('pg12').feature('lngr1').set('xdata', 'expr');
model.result('pg12').feature('lngr1').set('xdataexpr', 'x');
model.result('pg12').feature('lngr1').set('xdataunit', [native2unicode(hex2dec({'00' 'b5'}), 'unicode') 'm']);
model.result('pg12').feature('lngr1').set('legend', true);
model.result('pg12').feature('lngr1').set('legendmethod', 'manual');
model.result('pg12').feature('lngr1').setIndex('legends', 'Particle Surface, Start of charge', 0);
model.result('pg12').feature.duplicate('lngr2', 'lngr1');
model.result('pg12').run;
model.result('pg12').feature('lngr2').set('expr', 'liion.cs_average/liion.csmax');
model.result('pg12').feature('lngr2').setIndex('legends', 'Particle Average, Start of charge', 0);
model.result('pg12').feature.duplicate('lngr3', 'lngr2');
model.result('pg12').run;
model.result('pg12').feature('lngr3').set('data', 'dset3');
model.result('pg12').feature('lngr3').setIndex('looplevelinput', 'last', 0);
model.result('pg12').feature('lngr3').setIndex('legends', 'Particle Average, End of charge - Start of discharge', 0);
model.result('pg12').feature.duplicate('lngr4', 'lngr3');
model.result('pg12').run;
model.result('pg12').feature('lngr4').set('data', 'dset5');
model.result('pg12').feature('lngr4').setIndex('legends', 'Particle Average, End of discharge', 0);
model.result('pg12').feature.duplicate('lngr5', 'lngr4');
model.result('pg12').run;
model.result('pg12').feature('lngr5').set('data', 'dset3');
model.result('pg12').feature('lngr5').set('expr', 'liion.cs_surface/liion.csmax');
model.result('pg12').feature('lngr5').setIndex('legends', 'Particle Surface, End of charge - Start of discharge', 0);
model.result('pg12').feature.duplicate('lngr6', 'lngr5');
model.result('pg12').run;
model.result('pg12').feature('lngr6').set('data', 'dset5');
model.result('pg12').feature('lngr6').setIndex('legends', 'Particle Surface, End of discharge', 0);
model.result('pg12').run;
model.result.create('pg13', 'PlotGroup1D');
model.result('pg13').run;
model.result('pg13').label('Intercalation Reaction Current Source Distribution');
model.result('pg13').set('titletype', 'label');
model.result('pg13').set('ylabelactive', true);
model.result('pg13').set('ylabel', 'Current source (A/m<sup>3</sup>)');
model.result('pg13').set('legendpos', 'upperleft');
model.result('pg13').create('lngr1', 'LineGraph');
model.result('pg13').feature('lngr1').set('markerpos', 'datapoints');
model.result('pg13').feature('lngr1').set('linewidth', 'preference');
model.result('pg13').feature('lngr1').set('data', 'dset2');
model.result('pg13').feature('lngr1').selection.all;
model.result('pg13').feature('lngr1').set('expr', 'liion.iv_per1');
model.result('pg13').feature('lngr1').set('xdata', 'expr');
model.result('pg13').feature('lngr1').set('xdataexpr', 'x');
model.result('pg13').feature('lngr1').set('xdataunit', [native2unicode(hex2dec({'00' 'b5'}), 'unicode') 'm']);
model.result('pg13').feature('lngr1').set('legend', true);
model.result('pg13').feature('lngr1').set('legendmethod', 'manual');
model.result('pg13').feature('lngr1').setIndex('legends', 'Start of charge', 0);
model.result('pg13').feature.duplicate('lngr2', 'lngr1');
model.result('pg13').run;
model.result('pg13').feature('lngr2').set('data', 'dset3');
model.result('pg13').feature('lngr2').setIndex('looplevelinput', 'last', 0);
model.result('pg13').feature('lngr2').setIndex('legends', 'End of charge', 0);
model.result('pg13').feature.duplicate('lngr3', 'lngr2');
model.result('pg13').run;
model.result('pg13').feature('lngr3').set('data', 'dset4');
model.result('pg13').feature('lngr3').setIndex('legends', 'Start of discharge', 0);
model.result('pg13').feature.duplicate('lngr4', 'lngr3');
model.result('pg13').run;
model.result('pg13').feature('lngr4').set('data', 'dset5');
model.result('pg13').feature('lngr4').setIndex('looplevelinput', 'last', 0);
model.result('pg13').feature('lngr4').setIndex('legends', 'End of discharge', 0);
model.result('pg13').run;
model.result.dataset.create('grid1', 'Grid1D');
model.result.dataset('grid1').set('source', 'function');
model.result.dataset('grid1').set('function', 'an1');
model.result.dataset('grid1').set('par1', 't');
model.result.dataset('grid1').set('parmax1', 't_charge[1/s]+t_discharge[1/s]');
model.result.create('pg14', 'PlotGroup1D');
model.result('pg14').run;
model.result('pg14').label('SOC vs. Time');
model.result('pg14').set('data', 'none');
model.result('pg14').set('titletype', 'none');
model.result('pg14').set('xlabelactive', true);
model.result('pg14').set('xlabel', 'Time (s)');
model.result('pg14').set('ylabelactive', true);
model.result('pg14').set('ylabel', 'SOC (1)');
model.result('pg14').create('lngr1', 'LineGraph');
model.result('pg14').feature('lngr1').set('markerpos', 'datapoints');
model.result('pg14').feature('lngr1').set('linewidth', 'preference');
model.result('pg14').feature('lngr1').set('data', 'grid1');
model.result('pg14').feature('lngr1').set('expr', 'comp1.SOC_vs_Time(root.t)');
model.result('pg14').feature('lngr1').set('xdata', 'expr');
model.result('pg14').feature('lngr1').set('xdataexpr', 't');
model.result('pg14').run;

model.title([]);

model.description('');

model.label('li_battery_designer_embedded.mph');

model.result('pg14').run;

model.setExpectedComputationTime('49 seconds');

model.result.report.create('rpt1', 'Report');
model.result.report('rpt1').set('format', 'docx');
model.result.report('rpt1').set('filename', 'user:///Li-Ion_Battery_Impedance.docx');
model.result.report('rpt1').set('imagesize', 'large');
model.result.report('rpt1').feature.create('tp1', 'TitlePage');
model.result.report('rpt1').feature('tp1').set('title', '1D Lithium-Ion Battery Model for Determination of Optimal Battery Usage and Design');
model.result.report('rpt1').feature.create('toc1', 'TableOfContents');
model.result.report('rpt1').feature.create('sec1', 'Section');
model.result.report('rpt1').feature('sec1').label('Software Information');
model.result.report('rpt1').feature('sec1').feature.create('root1', 'Model');
model.result.report('rpt1').feature('sec1').feature('root1').label('Software Properties from Root');
model.result.report('rpt1').feature('sec1').feature('root1').set('includepath', false);
model.result.report('rpt1').feature('sec1').feature.create('std1', 'Study');
model.result.report('rpt1').feature('sec1').feature('std1').setIndex('children', false, 0, 1);
model.result.report('rpt1').feature('sec1').feature('std1').setIndex('children', false, 1, 1);
model.result.report('rpt1').feature('sec1').feature('std1').setIndex('children', false, 2, 1);
model.result.report('rpt1').feature('sec1').feature('std1').setIndex('children', false, 3, 1);
model.result.report('rpt1').feature('sec1').feature('std1').setIndex('children', false, 4, 1);
model.result.report('rpt1').feature.create('sec2', 'Section');
model.result.report('rpt1').feature('sec2').label('Input Data');
model.result.report('rpt1').feature('sec2').feature.create('param1', 'Parameter');
model.result.report('rpt1').feature('sec2').feature('param1').setIndex('children', false, 5, 1);
model.result.report('rpt1').feature('sec2').feature('param1').setIndex('children', false, 6, 1);
model.result.report('rpt1').feature('sec2').feature('param1').setIndex('children', false, 9, 1);
model.result.report('rpt1').feature('sec2').feature('param1').setIndex('children', false, 10, 1);
model.result.report('rpt1').feature('sec2').feature('param1').setIndex('children', false, 11, 1);
model.result.report('rpt1').feature('sec2').feature('param1').setIndex('children', false, 17, 1);
model.result.report('rpt1').feature('sec2').feature('param1').setIndex('children', false, 28, 1);
model.result.report('rpt1').feature('sec2').feature('param1').setIndex('children', false, 29, 1);
model.result.report('rpt1').feature('sec2').feature('param1').setIndex('children', false, 40, 1);
model.result.report('rpt1').feature('sec2').feature('param1').setIndex('children', false, 41, 1);
model.result.report('rpt1').feature('sec2').feature('param1').setIndex('children', false, 46, 1);
model.result.report('rpt1').feature('sec2').feature('param1').setIndex('children', false, 52, 1);
model.result.report('rpt1').feature('sec2').feature('param1').setIndex('children', false, 55, 1);
model.result.report('rpt1').feature('sec2').feature('param1').setIndex('children', false, 64, 1);
model.result.report('rpt1').feature.create('sec3', 'Section');
model.result.report('rpt1').feature('sec3').label('Results');
model.result.report('rpt1').feature('sec3').feature.create('pg1', 'PlotGroup');
model.result.report('rpt1').feature('sec3').feature('pg1').set('noderef', 'pg2');
model.result.report('rpt1').feature('sec3').feature('pg1').label('Battery Cell Voltage & Current');
model.result.report('rpt1').feature('sec3').feature.duplicate('pg2', 'pg1');
model.result.report('rpt1').feature('sec3').feature('pg2').label('Positive Electrode Potentials vs. Time');
model.result.report('rpt1').feature('sec3').feature('pg2').set('noderef', 'pg3');
model.result.report('rpt1').feature('sec3').feature.duplicate('pg3', 'pg2');
model.result.report('rpt1').feature('sec3').feature('pg3').label('Negative Electrode Potentials vs. Time ');
model.result.report('rpt1').feature('sec3').feature('pg3').set('noderef', 'pg4');
model.result.report('rpt1').feature('sec3').feature.duplicate('pg4', 'pg3');
model.result.report('rpt1').feature('sec3').feature('pg4').label('Temperature , Heat Source  vs. Time');
model.result.report('rpt1').feature('sec3').feature('pg4').set('noderef', 'pg5');
model.result.report('rpt1').feature('sec3').feature.duplicate('pg5', 'pg4');
model.result.report('rpt1').feature('sec3').feature('pg5').label('Parasitic Li Losses vs. Time ');
model.result.report('rpt1').feature('sec3').feature('pg5').set('noderef', 'pg6');
model.result.report('rpt1').feature('sec3').feature.duplicate('pg6', 'pg5');
model.result.report('rpt1').feature('sec3').feature('pg6').label('Electrolyte Potential Distribution');
model.result.report('rpt1').feature('sec3').feature('pg6').set('noderef', 'pg7');
model.result.report('rpt1').feature('sec3').feature.duplicate('pg7', 'pg6');
model.result.report('rpt1').feature('sec3').feature('pg7').label('Electrode Phase Potential Distribution');
model.result.report('rpt1').feature('sec3').feature('pg7').set('noderef', 'pg8');
model.result.report('rpt1').feature('sec3').feature.duplicate('pg8', 'pg7');
model.result.report('rpt1').feature('sec3').feature('pg8').label('Electrolyte Concentration Distribution ');
model.result.report('rpt1').feature('sec3').feature('pg8').set('noderef', 'pg9');
model.result.report('rpt1').feature('sec3').feature.duplicate('pg9', 'pg8');
model.result.report('rpt1').feature('sec3').feature('pg9').label('Electrolyte Conductivity Distribution');
model.result.report('rpt1').feature('sec3').feature('pg9').set('noderef', 'pg10');
model.result.report('rpt1').feature('sec3').feature.duplicate('pg10', 'pg9');
model.result.report('rpt1').feature('sec3').feature('pg10').label('Integrated Lithium Loss Distribution');
model.result.report('rpt1').feature('sec3').feature('pg10').set('noderef', 'pg11');
model.result.report('rpt1').feature('sec3').feature.duplicate('pg11', 'pg10');
model.result.report('rpt1').feature('sec3').feature('pg11').label('Electrode SOC Distribution');
model.result.report('rpt1').feature('sec3').feature('pg11').set('noderef', 'pg12');
model.result.report('rpt1').feature('sec3').feature.duplicate('pg12', 'pg11');
model.result.report('rpt1').feature('sec3').feature('pg12').label('Intercalation Reaction Current Distribution');
model.result.report('rpt1').feature('sec3').feature('pg12').set('noderef', 'pg13');

model.title('Lithium Battery Designer');

model.description(['This app can be used as a design tool to develop an optimized battery configuration for a specific application. The application computes the capacity, energy efficiency, heat generation, and capacity losses due to parasitic reactions of a battery for a specific load cycle.' newline  newline 'Various battery-design parameters consist of: geometrical dimensions of the battery canister, the thicknesses of the different components (separator, current collectors and electrodes), the positive electrode material, and the volume fractions of the different phases of the porous materials can be changed. The load cycle is a charge-discharge cycle using a constant current load, which may be different for the charge and discharge stages.' newline  newline 'The app also computes the battery temperature (assuming an uniform internal battery temperature), based on the generated heat and the thermal mass. Cooling is defined using an ambient temperature parameter and a heat transfer coefficient.']);

model.mesh.clearMeshes;

model.sol('sol1').clearSolutionData;
model.sol('sol2').clearSolutionData;
model.sol('sol3').clearSolutionData;
model.sol('sol4').clearSolutionData;
model.sol('sol5').clearSolutionData;

model.label('li_battery_designer.mph');

model.modelNode.label('Components');

out = model;
