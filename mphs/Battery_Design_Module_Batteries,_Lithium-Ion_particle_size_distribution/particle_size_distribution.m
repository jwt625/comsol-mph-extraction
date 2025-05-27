function out = model
%
% particle_size_distribution.m
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
model.param.set('L_pos', '75[um]', 'NMC electrode thickness');
model.param.set('sigmas_pos', '10[S/m]', 'Electrode conductivity');
model.param.set('epsl_sep', '0.4', 'Electrolyte phase volume fraction, separator');
model.param.set('epsl_pos', '0.4', 'Electrolyte phase volume fraction, positive electrode');
model.param.set('epss_pos', '0.5', 'Electrode phase volume fraction, positive electrode');
model.param.set('cs_init', '10000[mol/m^3]', 'Initial concentration of intercalated lithium, positive electrode');
model.param.set('Rp_min', '2[um]', 'Minimum particle radius in histogram');
model.param.set('Rp_max', '14[um]', 'Maximum particle radius in histogram');
model.param.set('i0_ref_v', '1e5[A/m^3]', 'Volumetric reference exchange current density at 50% lithiation');
model.param.set('Ds', '1e-14[m^2/s]', 'Lithium diffusivity in NMC');
model.param.set('T', '25[degC]', 'Temperature');
model.param.set('csmax', '49000[mol/m^3]', 'Maximum lithium concentration in NMC');
model.param.set('t_pulse', '30[min]', 'Pulse time');
model.param.set('t', '0[s]', 'Dummy time parameter');

model.func.create('int1', 'Interpolation');
model.func('int1').label('Interpolation - Particle Radius Histogram');
model.func('int1').set('funcname', 'f_hist');
model.func('int1').set('table', {'2.5' '5';  ...
'3.5' '28';  ...
'4.5' '34';  ...
'5.5' '19';  ...
'6.5' '14';  ...
'7.5' '11';  ...
'8.5' '3';  ...
'9.5' '1';  ...
'10.5' '2';  ...
'11.5' '1';  ...
'12.5' '0';  ...
'13.5' '1'});
model.func('int1').set('interp', 'neighbor');
model.func('int1').setIndex('fununit', 1, 0);
model.func('int1').setIndex('argunit', 'um', 0);
model.func('int1').createPlot('pg1');

model.result('pg1').run;
model.result('pg1').set('titletype', 'none');
model.result('pg1').set('xlabelactive', true);
model.result('pg1').set('xlabel', 'R<sub>p</sub> (um)');
model.result('pg1').set('ylabelactive', true);
model.result('pg1').set('ylabel', 'f<sub>hist</sub> (1)');
model.result('pg1').set('axislimits', true);
model.result('pg1').set('xmin', 2);
model.result('pg1').set('xmax', 14);
model.result('pg1').run;
model.result('pg1').feature('plot1').set('linewidth', 2);
model.result('pg1').run;
model.result.dataset.remove('int1_ds1');

model.common.create('state1', 'StateVariables', '');
model.common('state1').label('State Variables - Particle Measures From Histogram');
model.common('state1').setIndex('state', 'vol_particles', 0);
model.common('state1').setIndex('initialValue', '', 0);
model.common('state1').setIndex('updateExpression', '', 0);
model.common('state1').setIndex('description', '', 0);
model.common('state1').setIndex('initialValue', 'integrate(f_hist(Rp_arg)*4*pi*Rp_arg^3/3,Rp_arg,Rp_min,Rp_max)', 0);
model.common('state1').setIndex('description', 'Volume of all particles', 0);
model.common('state1').setIndex('state', 'area_particles', 1);
model.common('state1').setIndex('initialValue', '', 1);
model.common('state1').setIndex('updateExpression', '', 1);
model.common('state1').setIndex('description', '', 1);
model.common('state1').setIndex('initialValue', 'integrate(f_hist(Rp_arg)*4*pi*Rp_arg^2,Rp_arg,Rp_min,Rp_max)', 1);
model.common('state1').setIndex('description', 'Area of all particles', 1);
model.common('state1').setIndex('state', 'mass_averaged_Rp_squared', 2);
model.common('state1').setIndex('initialValue', '', 2);
model.common('state1').setIndex('updateExpression', '', 2);
model.common('state1').setIndex('description', '', 2);
model.common('state1').setIndex('initialValue', 'integrate(f_hist(Rp_arg)*Rp_arg^2*4*pi*Rp_arg^3/3,Rp_arg,Rp_min,Rp_max)/integrate(f_hist(Rp_arg)*4*pi*Rp_arg^3/3,Rp_arg,Rp_min,Rp_max)', 2);
model.common('state1').setIndex('description', 'Mass-averaged squared particle radius', 2);
model.common('state1').set('update', 'onlyInitialization');

model.func.create('step1', 'Step');
model.func('step1').set('from', 1);
model.func('step1').set('to', 0);

model.variable.create('var1');

% To import content from file, use:
% model.variable('var1').loadFile('FILENAME');
model.variable('var1').set('Rp_no_distr', 'sqrt(mass_averaged_Rp_squared)[m]', 'Particle radius deployed in non-distributed model');
model.variable('var1').set('Av_no_distr', 'epss_pos*(4*pi*Rp_no_distr^2)/(4*pi*Rp_no_distr^3/3)', 'Specific surface area in non-distributed model');
model.variable('var1').set('Av_distr', 'epss_pos*area_particles[m^2]/vol_particles[m^3]', 'Specific surface ara in distributed model');
model.variable('var1').set('i0_ref_no_distr', 'i0_ref_v/Av_no_distr', 'Reference exchange current density in non-distributed model');
model.variable('var1').set('i0_ref_distr', 'i0_ref_v/Av_distr', 'Reference exchange current density in distributed model');
model.variable('var1').set('i_app', '-10[A/m^2]*step1((t-t_pulse)/1[s])', 'Applied current density');

model.geom('geom1').create('i1', 'Interval');
model.geom('geom1').feature('i1').set('specify', 'len');
model.geom('geom1').feature('i1').setIndex('len', 'L_sep', 0);
model.geom('geom1').feature('i1').setIndex('len', 'L_pos', 1);
model.geom('geom1').run('fin');

model.material.create('mat1', 'Common', 'comp1');
model.material('mat1').propertyGroup.create('ElectrodePotential', 'Equilibrium potential');
model.material('mat1').label('Lithium Metal, Li (Negative, Li-ion Battery)');
model.material('mat1').propertyGroup('def').set('youngsmodulus', '');
model.material('mat1').propertyGroup('def').set('poissonsratio', '');
model.material('mat1').propertyGroup('def').set('density', '');
model.material('mat1').propertyGroup('def').set('thermalconductivity', '');
model.material('mat1').propertyGroup('def').set('electricconductivity', '');
model.material('mat1').propertyGroup('def').set('heatcapacity', '');
model.material('mat1').propertyGroup('def').set('youngsmodulus', '2[GPa]');
model.material('mat1').propertyGroup('def').set('INFO_PREFIX:youngsmodulus', 'Yue Qi et al 2010 J. Electrochem. Soc. 157 A558');
model.material('mat1').propertyGroup('def').set('poissonsratio', '0.34');
model.material('mat1').propertyGroup('def').set('INFO_PREFIX:poissonsratio', 'Yue Qi et al 2010 J. Electrochem. Soc. 157 A558');
model.material('mat1').propertyGroup('def').set('density', '0.534[g/cm^3]');
model.material('mat1').propertyGroup('def').set('INFO_PREFIX:density', 'https://en.wikipedia.org/wiki/Lithium');
model.material('mat1').propertyGroup('def').set('thermalconductivity', {'84.8[W/(m*K)]' '0' '0' '0' '84.8[W/(m*K)]' '0' '0' '0' '84.8[W/(m*K)]'});
model.material('mat1').propertyGroup('def').set('INFO_PREFIX:thermalconductivity', 'https://en.wikipedia.org/wiki/Lithium');
model.material('mat1').propertyGroup('def').set('electricconductivity', {['1/(92.8[n' 'ohm' '*m])'] '0' '0' '0' ['1/(92.8[n' 'ohm' '*m])'] '0' '0' '0' ['1/(92.8[n' 'ohm' '*m])']});
model.material('mat1').propertyGroup('def').set('INFO_PREFIX:electricconductivity', 'https://en.wikipedia.org/wiki/Lithium');
model.material('mat1').propertyGroup('def').set('heatcapacity', '3.58[kJ/kg/K]');
model.material('mat1').propertyGroup('def').set('INFO_PREFIX:heatcapacity', 'https://en.wikipedia.org/wiki/Lithium');
model.material('mat1').propertyGroup('ElectrodePotential').set('Eeq', '0[V]');
model.material('mat1').propertyGroup('ElectrodePotential').set('dEeqdT', '0[V/K]');
model.material('mat1').propertyGroup('ElectrodePotential').set('cEeqref', '0[M]');
model.material('mat1').propertyGroup('ElectrodePotential').addInput('concentration');
model.material('mat1').propertyGroup('ElectrodePotential').addInput('temperature');
model.material.create('mat2', 'Common', 'comp1');
model.material('mat2').propertyGroup.create('ElectrodePotential', 'Equilibrium potential');
model.material('mat2').propertyGroup('ElectrodePotential').func.create('int1', 'Interpolation');
model.material('mat2').propertyGroup.create('OperationalSOC', 'Operational electrode state of charge');
model.material('mat2').propertyGroup.create('ic', 'Intercalation strain');
model.material('mat2').propertyGroup('ic').func.create('int1', 'Interpolation');
model.material('mat2').propertyGroup.create('EquilibriumConcentration', 'Equilibrium concentration');
model.material('mat2').label('NMC 111, LiNi0.33Mn0.33Co0.33O2 (Positive, Li-ion Battery)');
model.material('mat2').propertyGroup('def').set('poissonsratio', '');
model.material('mat2').propertyGroup('def').set('youngsmodulus', '');
model.material('mat2').propertyGroup('def').set('thermalconductivity', '');
model.material('mat2').propertyGroup('def').set('thermalexpansioncoefficient', '');
model.material('mat2').propertyGroup('def').set('poissonsratio', '0.25');
model.material('mat2').propertyGroup('def').set('INFO_PREFIX:poissonsratio', ['Mechanical and physical properties of LiNi0.33Mn0.33Co0.33O2 (NMC),' newline 'E Chenga, K. Hong, N. Taylor, H. Choe,' newline 'J. Wolfenstinec, J. Sakamotoa,' newline 'Journal of the European Ceramic Society 37 (2017) 3213' native2unicode(hex2dec({'20' '13'}), 'unicode') '3217']);
model.material('mat2').propertyGroup('def').set('youngsmodulus', '78[GPa]');
model.material('mat2').propertyGroup('def').set('INFO_PREFIX:youngsmodulus', ['Mechanical and physical properties of LiNi0.33Mn0.33Co0.33O2 (NMC),' newline 'E Chenga, K. Hong, N. Taylor, H. Choe,' newline 'J. Wolfenstinec, J. Sakamotoa,' newline 'Journal of the European Ceramic Society 37 (2017) 3213' native2unicode(hex2dec({'20' '13'}), 'unicode') '3217']);
model.material('mat2').propertyGroup('def').set('thermalconductivity', {'3.6[W/(m*K)]' '0' '0' '0' '3.6[W/(m*K)]' '0' '0' '0' '3.6[W/(m*K)]'});
model.material('mat2').propertyGroup('def').set('INFO_PREFIX:thermalconductivity', ['Mechanical and physical properties of LiNi0.33Mn0.33Co0.33O2 (NMC),' newline 'E Chenga, K. Hong, N. Taylor, H. Choe,' newline 'J. Wolfenstinec, J. Sakamotoa,' newline 'Journal of the European Ceramic Society 37 (2017) 3213' native2unicode(hex2dec({'20' '13'}), 'unicode') '3217']);
model.material('mat2').propertyGroup('def').set('thermalexpansioncoefficient', {'1.2e-5[1/K]' '0' '0' '0' '1.2e-5[1/K]' '0' '0' '0' '1.2e-5[1/K]'});
model.material('mat2').propertyGroup('def').set('INFO_PREFIX:thermalexpansioncoefficient', ['Mechanical and physical properties of LiNi0.33Mn0.33Co0.33O2 (NMC),' newline 'E Chenga, K. Hong, N. Taylor, H. Choe,' newline 'J. Wolfenstinec, J. Sakamotoa,' newline 'Journal of the European Ceramic Society 37 (2017) 3213' native2unicode(hex2dec({'20' '13'}), 'unicode') '3217']);
model.material('mat2').propertyGroup('def').set('diffusion', {'1e-14[m^2/s]' '0' '0' '0' '1e-14[m^2/s]' '0' '0' '0' '1e-14[m^2/s]'});
model.material('mat2').propertyGroup('def').set('INFO_PREFIX:diffusion', 'Jing Ying Ko et al, J. Electrochem. Soc., 166, A2939');
model.material('mat2').propertyGroup('def').set('electricconductivity', {'100[S/m]' '0' '0' '0' '100[S/m]' '0' '0' '0' '100[S/m]'});
model.material('mat2').propertyGroup('def').set('csmax', '49000[mol/m^3]');
model.material('mat2').propertyGroup('def').descr('csmax', '');
model.material('mat2').propertyGroup('ElectrodePotential').func('int1').set('funcname', 'Eeq_int1');
model.material('mat2').propertyGroup('ElectrodePotential').func('int1').set('table', {'0' '4.44';  ...
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
model.material('mat2').propertyGroup('ElectrodePotential').func('int1').set('interp', 'piecewisecubic');
model.material('mat2').propertyGroup('ElectrodePotential').func('int1').set('extrap', 'linear');
model.material('mat2').propertyGroup('ElectrodePotential').func('int1').set('fununit', {'V'});
model.material('mat2').propertyGroup('ElectrodePotential').func('int1').set('argunit', {''});
model.material('mat2').propertyGroup('ElectrodePotential').func('int1').set('defineinv', true);
model.material('mat2').propertyGroup('ElectrodePotential').func('int1').set('funcinvname', 'Eeq_inv');
model.material('mat2').propertyGroup('ElectrodePotential').set('Eeq', 'Eeq_int1(soc)+dEeqdT*(T-298[K])');
model.material('mat2').propertyGroup('ElectrodePotential').set('INFO_PREFIX:Eeq', 'W. Zheng, M. Shui, J. Shu, S. Gao, D. Xu, L. Chen, L. Feng and Y. Ren, " GITT studies on oxide cathode LiNi1/3Co1/3Mn1/3O2 synthesized by citric acid assisted high-energy ball milling", Bull. Mater. Sci., vol. 36, p. A495, 2013');
model.material('mat2').propertyGroup('ElectrodePotential').set('dEeqdT', '-10[J/mol/K]/F_const');
model.material('mat2').propertyGroup('ElectrodePotential').set('INFO_PREFIX:dEeqdT', 'V Viswanathan, D Choi, D Wang, W Xu, S Towne, R Williford, JG Zhang, J Liu and Z Yang "Effect of entropy change on lithium intercalation in cathodes and anodes on Li-ion battery thermal management", Journal of Power Sources 195 (2010) 3720-3729');
model.material('mat2').propertyGroup('ElectrodePotential').set('cEeqref', 'def.csmax');
model.material('mat2').propertyGroup('ElectrodePotential').set('INFO_PREFIX:cEeqref', 'W. Zheng, M. Shui, J. Shu, S. Gao, D. Xu, L. Chen, L. Feng and Y. Ren, " GITT studies on oxide cathode LiNi1/3Co1/3Mn1/3O2 synthesized by citric acid assisted high-energy ball milling", Bull. Mater. Sci., vol. 36, p. A495, 2013');
model.material('mat2').propertyGroup('ElectrodePotential').set('soc', 'c/cEeqref');
model.material('mat2').propertyGroup('ElectrodePotential').descr('soc', '');
model.material('mat2').propertyGroup('ElectrodePotential').addInput('concentration');
model.material('mat2').propertyGroup('ElectrodePotential').addInput('temperature');
model.material('mat2').propertyGroup('OperationalSOC').set('socmax', 'elpot.Eeq_inv(E_min)');
model.material('mat2').propertyGroup('OperationalSOC').set('socmin', 'elpot.Eeq_inv(E_max)');
model.material('mat2').propertyGroup('OperationalSOC').set('E_max', '4.4[V]');
model.material('mat2').propertyGroup('OperationalSOC').set('E_min', '3.3[V]');
model.material('mat2').propertyGroup('ic').func('int1').set('funcname', 'dVOLdSOL');
model.material('mat2').propertyGroup('ic').func('int1').set('table', {'1' '0';  ...
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
model.material('mat2').propertyGroup('ic').func('int1').set('extrap', 'linear');
model.material('mat2').propertyGroup('ic').func('int1').set('fununit', {'%'});
model.material('mat2').propertyGroup('ic').func('int1').set('argunit', {'1'});
model.material('mat2').propertyGroup('ic').set('dvol', 'dVOLdSOL(c/elpot.cEeqref)');
model.material('mat2').propertyGroup('ic').set('INFO_PREFIX:dvol', ['R. Koerver and others, ' native2unicode(hex2dec({'20' '1c'}), 'unicode') 'Chemo-mechanical expansion of lithium electrode materials ' native2unicode(hex2dec({'20' '14'}), 'unicode') ' on the route to mechanically optimized all-solid-state batteries,' native2unicode(hex2dec({'20' '1d'}), 'unicode') ' Energy Environ. Sci., vol. 11, pp. 2142' native2unicode(hex2dec({'20' '13'}), 'unicode') '2158, 201']);
model.material('mat2').propertyGroup('ic').addInput('concentration');
model.material('mat2').propertyGroup('EquilibriumConcentration').set('csEq', 'def.csmax*elpot.Eeq_inv(V)');
model.material('mat2').propertyGroup('EquilibriumConcentration').addInput('electricpotential');
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
model.material('mat1').selection.geom('geom1', 0);
model.material('mat1').selection.set([1]);
model.material('mat2').selection.set([2]);
model.material('mat3').selection.set([1]);

model.physics('liion').feature('sep1').set('epsl', 'epsl_sep');
model.physics('liion').create('es1', 'ElectrodeSurface', 0);
model.physics('liion').feature('es1').label('Electrode Surface - Lithium Metal');
model.physics('liion').feature('es1').selection.set([1]);
model.physics('liion').create('pce1', 'PorousElectrode', 1);
model.physics('liion').feature('pce1').label('Porous Electrode - No Particle Size Distribution');
model.physics('liion').feature('pce1').selection.set([2]);
model.physics('liion').feature('pce1').set('ElectrolyteMaterial', 'mat3');
model.physics('liion').feature('pce1').set('sigma', {'sigmas_pos' '0' '0' '0' 'sigmas_pos' '0' '0' '0' 'sigmas_pos'});
model.physics('liion').feature('pce1').set('epss', 'epss_pos');
model.physics('liion').feature('pce1').set('epsl', 'epsl_pos');
model.physics('liion').feature('pce1').feature('pin1').set('csinit', 'cs_init');
model.physics('liion').feature('pce1').feature('pin1').set('rp', 'Rp_no_distr');
model.physics('liion').feature('pce1').feature('per1').set('i0_ref', 'i0_ref_no_distr');
model.physics('liion').feature('pce1').feature('per1').set('ActiveSpecificSurfaceAreaType', 'userdef');
model.physics('liion').feature('pce1').feature('per1').set('Av', 'Av_no_distr');
model.physics('liion').create('ecd1', 'ElectrodeNormalCurrentDensity', 0);
model.physics('liion').feature('ecd1').selection.set([3]);
model.physics('liion').feature('ecd1').set('nis', 'i_app');
model.physics('liion').feature('init1').set('phis', '4[V]');

model.study('std1').label('Study 1 - No Particle Size Distribution');
model.study('std1').setGenPlots(false);
model.study('std1').feature('time').set('tunit', 'h');
model.study('std1').feature('time').set('tlist', 'range(0,0.5,3)');

model.probe.create('point1', 'Point');
model.probe('point1').model('comp1');
model.probe('point1').set('probename', 'E_cell_no_distr');
model.probe('point1').selection.set([3]);
model.probe('point1').set('expr', 'phis');
model.probe('point1').set('descr', 'Electric potential');
model.probe('point1').set('descractive', true);
model.probe('point1').set('descr', 'Cell voltage');

model.result.table.create('tbl1', 'Table');

model.probe('point1').set('table', 'tbl1');
model.probe('point1').set('window', 'window2');
model.probe('point1').set('windowtitle', 'Probe Plot 2');
model.probe.create('point2', 'Point');
model.probe('point2').model('comp1');
model.probe('point2').set('probename', 'cs_surface_no_distr');
model.probe('point2').selection.set([2]);
model.probe('point2').set('expr', 'liion.cs_surface');
model.probe('point2').set('descr', 'Insertion particle concentration, surface');
model.probe('point2').set('descractive', true);
model.probe('point2').set('descr', 'Concentration, Surface');

model.result.table.create('tbl2', 'Table');

model.probe('point2').set('table', 'tbl2');
model.probe('point2').set('window', 'window2');
model.probe.duplicate('point3', 'point2');
model.probe('point3').set('probename', 'cs_center_no_distr');
model.probe('point3').set('expr', 'liion.cs_center');
model.probe('point3').set('descr', 'Concentration, Center');

model.sol.create('sol1');
model.sol('sol1').study('std1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'time');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').feature('comp1_phil').set('scalemethod', 'manual');
model.sol('sol1').feature('v1').feature('comp1_liion_pce1_cs').set('scalemethod', 'manual');
model.sol('sol1').feature('v1').feature('comp1_phis').set('scalemethod', 'manual');
model.sol('sol1').feature('v1').feature('comp1_cl').set('scalemethod', 'manual');
model.sol('sol1').feature('v1').feature('comp1_phil').set('scaleval', '1');
model.sol('sol1').feature('v1').feature('comp1_liion_pce1_cs').set('scaleval', '10000');
model.sol('sol1').feature('v1').feature('comp1_phis').set('scaleval', '1');
model.sol('sol1').feature('v1').feature('comp1_cl').set('scaleval', '1000');
model.sol('sol1').feature('v1').set('control', 'time');
model.sol('sol1').create('t1', 'Time');
model.sol('sol1').feature('t1').set('tlist', 'range(0,0.5,3)');
model.sol('sol1').feature('t1').set('plot', 'off');
model.sol('sol1').feature('t1').set('plotgroup', 'Default');
model.sol('sol1').feature('t1').set('plotfreq', 'tout');
model.sol('sol1').feature('t1').set('probesel', 'all');
model.sol('sol1').feature('t1').set('probes', {'point1' 'point2' 'point3'});
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

model.probe('point1').genResult('none');
model.probe('point2').genResult('none');
model.probe('point3').genResult('none');

model.sol('sol1').runAll;

model.result('pg1').set('window', 'window2');
model.result('pg1').set('windowtitle', 'Probe Plot 2');
model.result('pg1').run;
model.result('pg1').label('Probe Plot - Study 1');
model.result('pg1').set('titletype', 'none');
model.result('pg1').set('twoyaxes', true);
model.result('pg1').setIndex('plotonsecyaxis', true, 1, 1);
model.result('pg1').set('ylabelactive', true);
model.result('pg1').set('ylabel', 'Cell voltage (V)');
model.result('pg1').set('yseclabelactive', true);
model.result('pg1').set('yseclabel', 'Concentration (mol/m<sup>3</sup>)');
model.result('pg1').set('axislimits', true);
model.result('pg1').set('xmin', 0);
model.result('pg1').set('xmax', 3);
model.result('pg1').set('ymin', 3.94);
model.result('pg1').set('ymax', 4.07);
model.result('pg1').set('yminsec', 10000);
model.result('pg1').set('ymaxsec', 18000);
model.result('pg1').set('legendpos', 'lowerright');
model.result('pg1').set('window', 'window2');
model.result('pg1').set('windowtitle', 'Probe Plot 2');
model.result('pg1').run;
model.result('pg1').feature('tblp1').set('legendmethod', 'manual');
model.result('pg1').feature('tblp1').setIndex('legends', 'Cell voltage', 0);
model.result('pg1').set('window', 'window2');
model.result('pg1').set('windowtitle', 'Probe Plot 2');
model.result('pg1').run;
model.result('pg1').feature('tblp2').set('linestyle', 'dashed');
model.result('pg1').feature('tblp2').set('legendmethod', 'manual');
model.result('pg1').feature('tblp2').setIndex('legends', 'Concentration, Surface', 0);
model.result('pg1').feature('tblp2').setIndex('legends', 'Concentration, Center', 1);
model.result('pg1').set('window', 'window2');
model.result('pg1').set('windowtitle', 'Probe Plot 2');
model.result('pg1').run;

model.modelNode.create('xdim1', 'ExtraDim');

model.geom.create('geom2', 2);
model.geom('geom2').model('comp1');
model.geom('geom2').model('xdim1');

model.mesh.create('mesh2', 'geom2');

model.extraDim.create('pa1', 'PointsToAttach');
model.extraDim('pa1').model('xdim1');

model.modelNode('xdim1').spatialCoord({'xs' 'y1' 'z1'});
model.modelNode('xdim1').spatialCoord({'xs' 'ys' 'z1'});

model.geom('geom2').create('sq1', 'Square');
model.geom('geom2').run('fin');

model.mesh('mesh2').create('map1', 'Map');
model.mesh('mesh2').feature('map1').create('dis1', 'Distribution');
model.mesh('mesh2').feature('map1').feature('dis1').selection.set([1 4]);
model.mesh('mesh2').feature('map1').feature('dis1').set('numelem', 12);
model.mesh('mesh2').feature('map1').create('dis2', 'Distribution');
model.mesh('mesh2').feature('map1').feature('dis2').selection.set([2 3]);
model.mesh('mesh2').feature('map1').feature('dis2').set('type', 'predefined');
model.mesh('mesh2').feature('map1').feature('dis2').set('elemcount', 10);
model.mesh('mesh2').feature('map1').feature('dis2').set('elemratio', 10);
model.mesh('mesh2').run;

model.extraDim.create('xdintop2', 'Integration');
model.extraDim('xdintop2').model('xdim1');
model.extraDim('xdintop2').label('Integration over Extra Dimension - xdint_surf');
model.extraDim('xdintop2').set('opname', 'xdint_surf');
model.extraDim('xdintop2').selection.geom('geom2', 1);
model.extraDim('xdintop2').selection.set([4]);
model.extraDim.create('xdintop3', 'Integration');
model.extraDim('xdintop3').model('xdim1');
model.extraDim('xdintop3').label('Integration over Extra Dimension - xdint_surf_Rmax');
model.extraDim('xdintop3').set('opname', 'xdint_surf_Rmax');
model.extraDim('xdintop3').selection.geom('geom2', 0);
model.extraDim('xdintop3').selection.set([4]);
model.extraDim.create('xdintop4', 'Integration');
model.extraDim('xdintop4').model('xdim1');
model.extraDim('xdintop4').label('Integration over Extra Dimension - xdint_surf_Rmin');
model.extraDim('xdintop4').set('opname', 'xdint_surf_Rmin');
model.extraDim('xdintop4').selection.geom('geom2', 0);
model.extraDim('xdintop4').selection.set([3]);
model.extraDim.create('xdintop5', 'Integration');
model.extraDim('xdintop5').model('xdim1');
model.extraDim('xdintop5').label('Integration over Extra Dimension - xdint_center_Rmax');
model.extraDim('xdintop5').set('opname', 'xdint_center_Rmax');
model.extraDim('xdintop5').selection.geom('geom2', 0);
model.extraDim('xdintop5').selection.set([2]);
model.extraDim.create('xdintop6', 'Integration');
model.extraDim('xdintop6').model('xdim1');
model.extraDim('xdintop6').label('Integration over Extra Dimension - xdint_center_Rmin');
model.extraDim('xdintop6').set('opname', 'xdint_center_Rmin');
model.extraDim('xdintop6').selection.geom('geom2', 0);
model.extraDim('xdintop6').selection.set([1]);
model.extraDim.create('ad1', 'AttachDimensions');
model.extraDim('ad1').model('comp1');
model.extraDim('ad1').selection.geom('geom1', 1);
model.extraDim('ad1').selection.geom('geom1', 1);
model.extraDim('ad1').selection.set([2]);
model.extraDim('ad1').set('extradim', {'xdim1'});

model.variable.create('var2');
model.variable('var2').model('comp1');
model.variable('var2').label('Variables - Particle Domain in Extra Dimension');
model.variable('var2').selection.geom('geom1', 1);
model.variable('var2').selection.set([2]);
model.variable('var2').selection.extraDim('ad1');
model.variable('var2').set('Rp', 'Rp_min+(Rp_max-Rp_min)*ys[1/m]');
model.variable('var2').descr('Rp', 'Particle radius');
model.variable.create('var3');
model.variable('var3').model('comp1');
model.variable('var3').label('Variables - Particle Surface in Extra Dimension');
model.variable('var3').selection.geom('geom1', 1);
model.variable('var3').selection.set([2]);
model.variable('var3').selection.extraDim('ad1');
model.variable('var3').selection.extraDimSel('geom2').geom('geom2', 1);
model.variable('var3').selection.extraDimSel('geom2').set([4]);

% To import content from file, use:
% model.variable('var3').loadFile('FILENAME');
model.variable('var3').set('cs_surface', 'cs[mol/m^3]', 'Insertion particle concentration, surface');
model.variable('var3').set('i0', 'i0_ref_distr*(2*(csmax-cs_surface)/csmax)^0.5*(2*cs_surface/csmax)^0.5*(cl/1[M])^0.5', 'Exchange current density');
model.variable('var3').set('Eeq', 'mat2.elpot.Eeq_int1(cs_surface/csmax)', 'Equilibrium potential');
model.variable('var3').set('eta', 'phis-phil-Eeq', 'Overpotential');
model.variable('var3').set('iloc', 'i0*(exp(eta*0.5*F_const/(R_const*T))-exp(-eta*0.5*F_const/(R_const*T)))', 'Local current density on particle surface');
model.variable.create('var4');
model.variable('var4').model('comp1');
model.variable('var4').selection.geom('geom1', 1);
model.variable('var4').selection.set([2]);
model.variable('var4').label('Variables - Porous Electrode Domain');
model.variable('var4').set('iloc_distr', 'root.xdim1.xdint_surf(iloc*f_hist(Rp)*4*pi*Rp^2)*(Rp_max-Rp_min)[m^-2]/(area_particles[m^2])');
model.variable('var4').descr('iloc_distr', 'Particle-averaged local current density');

model.physics('liion').create('weak1', 'WeakContribution', 1);
model.physics('liion').feature('weak1').label('Weak Contribution - Domain Equation in Extra Dimension');
model.physics('liion').feature('weak1').selection.set([2]);
model.physics('liion').feature('weak1').selection.extraDim('ad1');
model.physics('liion').feature('weak1').selection.extraDimSel('geom2').all;
model.physics('liion').feature('weak1').set('weakExpression', 'xs^2*(-Rp^2*test(cs)*d(cs,TIME)-d(cs,xs)*Ds*test(d(cs,xs)[m^2]))');
model.physics('liion').feature('weak1').create('aux1', 'AuxiliaryField', 1);
model.physics('liion').feature('weak1').feature('aux1').label('Auxiliary Dependent Variable - cs');
model.physics('liion').feature('weak1').feature('aux1').selection.extraDim('ad1');
model.physics('liion').feature('weak1').feature('aux1').selection.extraDimSel('geom2').all;
model.physics('liion').feature('weak1').feature('aux1').set('fieldVariableName', 'cs');
model.physics('liion').feature('weak1').feature('aux1').set('initialValue', 'cs_init');
model.physics('liion').create('weak2', 'WeakContribution', 1);
model.physics('liion').feature('weak2').label('Weak Contribution - Boundary Condition in Extra Dimension');
model.physics('liion').feature('weak2').selection.set([2]);
model.physics('liion').feature('weak2').selection.extraDim('ad1');
model.physics('liion').feature('weak2').selection.extraDimSel('geom2').geom('geom2', 1);
model.physics('liion').feature('weak2').selection.extraDimSel('geom2').set([4]);
model.physics('liion').feature('weak2').set('weakExpression', 'xs^2*(-iloc/F_const)*test(cs)*Rp');
model.physics('liion').feature.duplicate('pce2', 'pce1');
model.physics('liion').feature('pce2').label('Porous Electrode - With Particle Size Distribution');
model.physics('liion').feature('pce2').set('IntercalationOption', 'NonIntercalatingParticles');
model.physics('liion').feature('pce2').feature('per1').set('ilocmat_mat', 'userdef');
model.physics('liion').feature('pce2').feature('per1').set('ilocmat', 'iloc_distr');
model.physics('liion').feature('pce2').feature('per1').set('Av', 'Av_distr');

model.probe.create('point4', 'Point');
model.probe('point4').model('comp1');
model.probe('point4').set('probename', 'E_cell_distr');
model.probe('point4').selection.set([3]);
model.probe('point4').set('expr', 'phis');
model.probe('point4').set('descr', 'Electric potential');
model.probe('point4').set('descractive', true);
model.probe('point4').set('descr', 'Cell voltage');

model.result.table.create('tbl3', 'Table');

model.probe('point4').set('table', 'tbl3');
model.probe('point4').set('window', 'window3');
model.probe('point4').set('windowtitle', 'Probe Plot 3');
model.probe.create('point5', 'Point');
model.probe('point5').model('comp1');
model.probe('point5').set('probename', 'cs_surface_Rmax');
model.probe('point5').selection.set([2]);
model.probe('point5').set('expr', 'root.xdim1.xdint_surf_Rmax(cs)');
model.probe('point5').set('descractive', true);
model.probe('point5').set('descr', 'Concentration, Surface, Largest Particles');

model.result.table.create('tbl4', 'Table');

model.probe('point5').set('table', 'tbl4');
model.probe('point5').set('window', 'window3');
model.probe.duplicate('point6', 'point5');
model.probe('point6').set('probename', 'cs_center_Rmax');
model.probe('point6').set('expr', 'root.xdim1.xdint_center_Rmax(cs)');
model.probe('point6').set('descr', 'Concentration, Center, Largest Particles');
model.probe.duplicate('point7', 'point6');
model.probe('point7').set('probename', 'cs_surface_Rmin');
model.probe('point7').set('expr', 'root.xdim1.xdint_surf_Rmin(cs)');
model.probe('point7').set('descr', 'Concentration, Surface, Smallest Particles');
model.probe.duplicate('point8', 'point7');
model.probe('point8').set('probename', 'cs_center_Rmin');
model.probe('point8').set('expr', 'root.xdim1.xdint_center_Rmin(cs)');
model.probe('point8').set('descr', 'Concentration, Center, Smallest Particles');

model.study.create('std2');
model.study('std2').create('time', 'Transient');
model.study('std2').feature('time').setSolveFor('/physics/liion', true);
model.study('std2').label('Study 2 - With Particle Size Distribution');
model.study('std2').feature('time').set('tunit', 'h');
model.study('std2').feature('time').set('tlist', 'range(0,0.5,3)');
model.study('std2').feature('time').set('probesel', 'manual');
model.study('std2').feature('time').set('probes', {'point4' 'point5' 'point6' 'point7' 'point8'});
model.study('std2').feature('time').set('useadvanceddisable', true);
model.study('std2').feature('time').set('disabledphysics', {'liion/pce1'});
model.study('std2').setGenPlots(false);

model.sol.create('sol2');
model.sol('sol2').study('std2');
model.sol('sol2').create('st1', 'StudyStep');
model.sol('sol2').feature('st1').set('study', 'std2');
model.sol('sol2').feature('st1').set('studystep', 'time');
model.sol('sol2').create('v1', 'Variables');
model.sol('sol2').feature('v1').feature('comp1_phil').set('scalemethod', 'manual');
model.sol('sol2').feature('v1').feature('comp1_phis').set('scalemethod', 'manual');
model.sol('sol2').feature('v1').feature('comp1_cl').set('scalemethod', 'manual');
model.sol('sol2').feature('v1').feature('comp1_phil').set('scaleval', '1');
model.sol('sol2').feature('v1').feature('comp1_phis').set('scaleval', '1');
model.sol('sol2').feature('v1').feature('comp1_cl').set('scaleval', '1000');
model.sol('sol2').feature('v1').set('control', 'time');
model.sol('sol2').create('t1', 'Time');
model.sol('sol2').feature('t1').set('tlist', 'range(0,0.5,3)');
model.sol('sol2').feature('t1').set('plot', 'off');
model.sol('sol2').feature('t1').set('plotgroup', 'pg1');
model.sol('sol2').feature('t1').set('plotfreq', 'tout');
model.sol('sol2').feature('t1').set('probesel', 'manual');
model.sol('sol2').feature('t1').set('probes', {'point4' 'point5' 'point6' 'point7' 'point8'});
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

model.probe('point4').genResult('none');
model.probe('point5').genResult('none');
model.probe('point6').genResult('none');
model.probe('point7').genResult('none');
model.probe('point8').genResult('none');

model.sol('sol2').runAll;

model.result('pg2').set('window', 'window3');
model.result('pg2').set('windowtitle', 'Probe Plot 3');
model.result('pg2').run;
model.result('pg2').label('Probe Plot - Study 2');
model.result('pg2').set('titletype', 'none');
model.result('pg2').set('twoyaxes', true);
model.result('pg2').setIndex('plotonsecyaxis', true, 1, 1);
model.result('pg2').set('ylabelactive', true);
model.result('pg2').set('ylabel', 'Cell voltage (V)');
model.result('pg2').set('yseclabelactive', true);
model.result('pg2').set('yseclabel', 'Concentration (mol/m<sup>3</sup>)');
model.result('pg2').set('axislimits', true);
model.result('pg2').set('xmin', 0);
model.result('pg2').set('xmax', 3);
model.result('pg2').set('ymin', 3.94);
model.result('pg2').set('ymax', 4.07);
model.result('pg2').set('yminsec', 10000);
model.result('pg2').set('ymaxsec', 18000);
model.result('pg2').set('legendpos', 'lowerright');
model.result('pg2').set('window', 'window3');
model.result('pg2').set('windowtitle', 'Probe Plot 3');
model.result('pg2').run;
model.result('pg2').feature('tblp1').set('legendmethod', 'manual');
model.result('pg2').feature('tblp1').setIndex('legends', 'Cell voltage', 0);
model.result('pg2').set('window', 'window3');
model.result('pg2').set('windowtitle', 'Probe Plot 3');
model.result('pg2').run;
model.result('pg2').feature('tblp2').set('linestyle', 'dashed');
model.result('pg2').feature('tblp2').set('legendmethod', 'manual');
model.result('pg2').feature('tblp2').setIndex('legends', 'Concentration, Surface, R<sub>p</sub>=R<sub>p,max</sub>', 0);
model.result('pg2').feature('tblp2').setIndex('legends', 'Concentration, Center, R<sub>p</sub>=R<sub>p,max</sub>', 1);
model.result('pg2').feature('tblp2').setIndex('legends', 'Concentration, Surface, R<sub>p</sub>=R<sub>p,min</sub>', 2);
model.result('pg2').feature('tblp2').setIndex('legends', 'Concentration, Center, R<sub>p</sub>=R<sub>p,min</sub>', 3);
model.result('pg2').set('window', 'window3');
model.result('pg2').set('windowtitle', 'Probe Plot 3');
model.result('pg2').run;
model.result.create('pg3', 'PlotGroup1D');
model.result('pg3').run;
model.result('pg3').label('Potential Comparison');
model.result('pg1').set('window', 'window2');
model.result('pg1').set('windowtitle', 'Probe Plot 2');
model.result('pg1').run;
model.result('pg3').run;
model.result('pg3').feature.copy('tblp1', 'pg1/tblp1');
model.result('pg3').run;
model.result('pg2').set('window', 'window3');
model.result('pg2').set('windowtitle', 'Probe Plot 3');
model.result('pg2').run;
model.result('pg3').run;
model.result('pg3').feature.copy('tblp2', 'pg2/tblp1');
model.result('pg3').run;
model.result('pg3').run;
model.result('pg3').feature('tblp1').setIndex('legends', 'No size distribution', 0);
model.result('pg3').run;
model.result('pg3').feature('tblp2').setIndex('legends', 'With size distribution', 0);
model.result('pg3').run;
model.result('pg3').create('glob1', 'Global');
model.result('pg3').feature('glob1').set('markerpos', 'datapoints');
model.result('pg3').feature('glob1').set('linewidth', 'preference');
model.result('pg3').feature('glob1').set('data', 'dset3');
model.result('pg3').feature('glob1').setIndex('looplevelinput', 'interp', 0);
model.result('pg3').feature('glob1').setIndex('interp', 'range(0,0.01,3)', 0);
model.result('pg3').feature('glob1').setIndex('expr', 'i_app', 0);
model.result('pg3').run;
model.result('pg3').set('titletype', 'none');
model.result('pg3').set('twoyaxes', true);
model.result('pg3').setIndex('plotonsecyaxis', true, 2, 1);
model.result('pg3').set('ylabelactive', true);
model.result('pg3').set('ylabel', 'Cell Voltage (V)');
model.result('pg3').set('yseclabelactive', true);
model.result('pg3').set('yseclabel', 'Current Density (A/m<sup>2</sup>)');
model.result('pg3').set('legendpos', 'lowerright');
model.result('pg3').run;
model.result.dataset.duplicate('dset4', 'dset3');
model.result.dataset('dset4').label('Study 2 - With Particle Size Distribution/Solution - xdim');
model.result.dataset('dset4').set('comp', 'xdim1');
model.result.create('pg4', 'PlotGroup2D');
model.result('pg4').run;
model.result('pg4').label('Concentration Distribution in Particles Adjacent to Separator');
model.result('pg4').setIndex('looplevel', 2, 0);
model.result('pg4').create('surf1', 'Surface');
model.result('pg4').feature('surf1').set('expr', 'comp1.atxd1(L_sep+L_pos/1000,cs)');
model.result('pg4').feature('surf1').set('descractive', true);
model.result('pg4').feature('surf1').set('descr', 'Concentration in extra dimension (mol/m<sup>3</sup>)');
model.result('pg4').run;
model.result('pg4').run;
model.result.duplicate('pg5', 'pg4');
model.result('pg5').run;
model.result('pg5').label('Concentration Distribution in Particles Adjacent to Current Collector');
model.result('pg5').run;
model.result('pg5').feature('surf1').set('expr', 'comp1.atxd1(L_sep+L_pos*0.999,cs)');
model.result('pg5').run;

model.study('std1').feature('time').set('probesel', 'manual');
model.study('std1').feature('time').set('probes', {'point1' 'point2' 'point3'});
model.study('std1').feature('time').set('useadvanceddisable', true);
model.study('std1').feature('time').set('disabledphysics', {'liion/weak1' 'liion/weak2' 'liion/pce2'});

model.title('Battery Electrode with a Particle Size Distribution');

model.description(['Battery electrodes featuring large heterogeneities in terms of particle sizes may sometimes not be adequately described by homogenized models using one single particle size only.' newline  newline 'As an alternative to adding multiple instances of the Additional Porous Electrode material node, this tutorial demonstrates how to instead deploy a user-defined Extra Dimension to define the solid phase diffusion of intercalated lithium for a range of particle sizes.' newline  newline 'A histogram is used as input in the model in order to define the distribution of particle sizes in the electrode.']);

model.mesh.clearMeshes;

model.sol('sol1').clearSolutionData;
model.sol('sol2').clearSolutionData;

model.label('particle_size_distribution.mph');

model.modelNode.label('Components');

out = model;
