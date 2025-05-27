function out = model
%
% internal_short_circuit.m
%
% Model exported on May 26 2025, 21:26 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/Battery_Design_Module/Batteries,_Lithium-Ion');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 2);
model.geom('geom1').model('comp1');
model.geom('geom1').axisymmetric(true);

model.mesh.create('mesh1', 'geom1');

model.physics.create('liion', 'LithiumIonBatteryMPH', 'geom1');
model.physics('liion').model('comp1');
model.physics.create('ht', 'HeatTransfer', 'geom1');
model.physics('ht').model('comp1');

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
model.study('std1').feature('cdi').setSolveFor('/physics/ht', true);
model.study('std1').create('time', 'Transient');
model.study('std1').feature('time').set('initialtime', '0');
model.study('std1').feature('time').set('solnum', 'auto');
model.study('std1').feature('time').set('notsolnum', 'auto');
model.study('std1').feature('time').set('outputmap', {});
model.study('std1').feature('time').setSolveFor('/physics/liion', true);
model.study('std1').feature('time').setSolveFor('/physics/ht', true);

% To import content from file, use:
% model.param.loadFile('FILENAME');
model.param.set('R_in', '5[um]', 'Inner radius of penetrating filament');
model.param.set('R_out', 'L_tot*5', 'Outer radius of battery cell');
model.param.set('L_sep', '30[um]', 'Separator thickness');
model.param.set('L_neg', '60[um]', 'Negative electrode thickness');
model.param.set('L_pos', '40[um]', 'Positive electrode thickness');
model.param.set('L_posCC', '6[um]', 'Positive current collector thickness');
model.param.set('L_negCC', '6[um]', 'Negative current collector thickness');
model.param.set('L_tot', 'L_negCC+L_neg+L_sep+L_pos+L_posCC', 'Cell total thickness');
model.param.set('t', '0', 'Dummy t variable for Initialization step');
model.param.set('t_ramp', '1e-3[s]', 'Ramp-up time for step function');
model.param.set('sigmas_neg', '100[S/m]', 'Electrical conductivity, negative electrode');
model.param.set('sigmas_pos', '100[S/m]', 'Electrical conductivity, positive electrode');
model.param.set('epss_neg', '0.62', 'Electrode phase volume fraction, negative electrode');
model.param.set('epss_pos', '0.48', 'Electrode phase volume fraction, positive electrode');
model.param.set('epsl_neg', '0.31', 'Electrolyte phase volume fraction, negative electrode');
model.param.set('epsl_pos', '0.29', 'Electrolyte phase volume fraction, positive electrode');
model.param.set('epsl_sep', '0.4', 'Porosity of separator');
model.param.set('rp_neg', '2e-6[m]', 'Particle radius, negative electrode');
model.param.set('rp_pos', '2e-6[m]', 'Particle radius, positive electrode');
model.param.set('i0ref_neg', '48.07[A/m^2]', 'Reference exchange current density negative electrode');
model.param.set('i0ref_pos', '74.75[A/m^2]', 'Reference exchange current density positive electrode');
model.param.set('T0', '293.15[K]', 'Initial and outer temperature');
model.param.set('E_cell', '4[V]', 'Cell potential');
model.param.set('Cp_pos', '1000[J/kg/K]', 'Heat capacity, positive electrode');
model.param.set('rho_pos', '2500[kg/m^3]', 'Density, positive electrode');
model.param.set('k_sep', '0.15[W/m/K]', 'Thermal conductivity, separator');
model.param.set('Cp_sep', '1046[J/kg/K]', 'Heat capacity, separator');
model.param.set('rho_sep', '940[kg/m^3]', 'Density, separator');

model.geom('geom1').create('r1', 'Rectangle');
model.geom('geom1').feature('r1').set('size', {'R_out' 'L_tot'});
model.geom('geom1').feature('r1').setIndex('layer', 'L_negCC', 0);
model.geom('geom1').feature('r1').setIndex('layer', 'L_neg', 1);
model.geom('geom1').feature('r1').setIndex('layer', 'L_sep', 2);
model.geom('geom1').feature('r1').setIndex('layer', 'L_pos', 3);
model.geom('geom1').run('r1');
model.geom('geom1').create('pol1', 'Polygon');
model.geom('geom1').feature('pol1').set('source', 'table');
model.geom('geom1').feature('pol1').set('type', 'open');
model.geom('geom1').feature('pol1').setIndex('table', 'R_in', 0, 0);
model.geom('geom1').feature('pol1').setIndex('table', 'L_negCC+L_neg', 0, 1);
model.geom('geom1').feature('pol1').setIndex('table', 'R_in', 1, 0);
model.geom('geom1').feature('pol1').setIndex('table', 'L_negCC+L_neg+L_sep', 1, 1);
model.geom('geom1').run('pol1');
model.geom('geom1').create('c1', 'Circle');
model.geom('geom1').feature('c1').set('r', 'R_in*2');
model.geom('geom1').feature('c1').set('angle', 90);
model.geom('geom1').feature('c1').set('pos', {'0' 'L_negCC+L_neg+L_sep'});
model.geom('geom1').feature.duplicate('c2', 'c1');
model.geom('geom1').feature('c2').set('pos', {'0' 'L_negCC+L_neg'});
model.geom('geom1').feature('c2').set('rot', 270);
model.geom('geom1').run('c2');
model.geom('geom1').run('c2');
model.geom('geom1').create('pol2', 'Polygon');
model.geom('geom1').feature('pol2').set('source', 'table');
model.geom('geom1').feature('pol2').set('type', 'open');
model.geom('geom1').feature('pol2').setIndex('table', 'R_in+L_sep', 0, 0);
model.geom('geom1').feature('pol2').setIndex('table', 0, 0, 1);
model.geom('geom1').feature('pol2').setIndex('table', 'R_in+L_sep', 1, 0);
model.geom('geom1').feature('pol2').setIndex('table', 'L_tot', 1, 1);
model.geom('geom1').run('pol2');

model.selection.create('sel1', 'Explicit');
model.selection('sel1').model('comp1');

model.geom('geom1').run;

model.selection('sel1').label('Negative CC');
model.selection('sel1').set([1 9]);
model.selection.create('sel2', 'Explicit');
model.selection('sel2').model('comp1');
model.selection('sel2').label('Negative Electrode');
model.selection('sel2').set([2 3 10]);
model.selection.create('sel3', 'Explicit');
model.selection('sel3').model('comp1');
model.selection('sel3').label('Separator');
model.selection('sel3').set([8 11]);
model.selection.create('sel4', 'Explicit');
model.selection('sel4').model('comp1');
model.selection('sel4').label('Positive Electrode');
model.selection('sel4').set([5 6 12]);
model.selection.create('sel5', 'Explicit');
model.selection('sel5').model('comp1');
model.selection('sel5').label('Positive CC');
model.selection('sel5').set([7 13]);
model.selection.create('sel6', 'Explicit');
model.selection('sel6').model('comp1');
model.selection('sel6').label('Penetrating Filament');
model.selection('sel6').set([4]);
model.selection.create('uni1', 'Union');
model.selection('uni1').model('comp1');
model.selection('uni1').label('Metal Conductor Domains');
model.selection('uni1').set('input', {'sel1' 'sel5' 'sel6'});
model.selection.create('sel7', 'Explicit');
model.selection('sel7').model('comp1');
model.selection('sel7').label('Negative Terminal');
model.selection('sel7').geom(1);
model.selection('sel7').set([30]);
model.selection.create('sel8', 'Explicit');
model.selection('sel8').model('comp1');
model.selection('sel8').label('Positive Terminal');
model.selection('sel8').geom(1);
model.selection('sel8').set([34]);
model.selection.create('uni2', 'Union');
model.selection('uni2').model('comp1');
model.selection('uni2').label('Terminals');
model.selection('uni2').set('entitydim', 1);
model.selection('uni2').set('input', {'sel7' 'sel8'});

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
model.material.create('mat4', 'Common', 'comp1');
model.material('mat4').propertyGroup('def').func.create('int1', 'Interpolation');
model.material('mat4').propertyGroup('def').func.create('int2', 'Interpolation');
model.material('mat4').propertyGroup.create('ElectrodePotential', 'Equilibrium potential');
model.material('mat4').propertyGroup('ElectrodePotential').func.create('int1', 'Interpolation');
model.material('mat4').propertyGroup('ElectrodePotential').func.create('int2', 'Interpolation');
model.material('mat4').propertyGroup.create('OperationalSOC', 'Operational electrode state of charge');
model.material('mat4').propertyGroup.create('ic', 'Intercalation strain');
model.material('mat4').propertyGroup('ic').func.create('int1', 'Interpolation');
model.material('mat4').propertyGroup.create('EquilibriumConcentration', 'Equilibrium concentration');
model.material('mat4').label('Graphite, LixC6 MCMB (Negative, Li-ion Battery)');
model.material('mat4').propertyGroup('def').func('int1').set('funcname', 'E_int');
model.material('mat4').propertyGroup('def').func('int1').set('table', {'0' '32.47'; '0.333' '28.56'; '0.5' '58.06'; '1' '108.67'});
model.material('mat4').propertyGroup('def').func('int1').set('fununit', {'GPa'});
model.material('mat4').propertyGroup('def').func('int1').set('argunit', {'1'});
model.material('mat4').propertyGroup('def').func('int2').set('funcname', 'nu_int');
model.material('mat4').propertyGroup('def').func('int2').set('table', {'0' '0.32'; '0.333' '0.39'; '0.5' '0.34'; '1' '0.24'});
model.material('mat4').propertyGroup('def').func('int2').set('fununit', {''});
model.material('mat4').propertyGroup('def').set('youngsmodulus', '');
model.material('mat4').propertyGroup('def').set('poissonsratio', '');
model.material('mat4').propertyGroup('def').set('youngsmodulus', 'E_int(c/csmax)');
model.material('mat4').propertyGroup('def').set('INFO_PREFIX:youngsmodulus', 'Yue Qi et al 2010 J. Electrochem. Soc. 157 A558');
model.material('mat4').propertyGroup('def').set('poissonsratio', 'nu_int(c/csmax)');
model.material('mat4').propertyGroup('def').set('INFO_PREFIX:poissonsratio', 'Yue Qi et al 2010 J. Electrochem. Soc. 157 A558');
model.material('mat4').propertyGroup('def').set('electricconductivity', {'100[S/m]' '0' '0' '0' '100[S/m]' '0' '0' '0' '100[S/m]'});
model.material('mat4').propertyGroup('def').set('INFO_PREFIX:electricconductivity', ['V. Srinivasan, and J. Newman, ' native2unicode(hex2dec({'20' '1c'}), 'unicode') 'Design and Optimization of a Natural Graphite/Iron Phosphate Lithium Ion Cell,' native2unicode(hex2dec({'20' '1d'}), 'unicode') ' J. Electrochem. Soc., vol. 151, p. 1530, 2004.']);
model.material('mat4').propertyGroup('def').set('diffusion', {'1.4523e-13*exp(68025.7/8.314*(1/(T_ref/1[K])-1/(T2/1[K])))[m^2/s]' '0' '0' '0' '1.4523e-13*exp(68025.7/8.314*(1/(T_ref/1[K])-1/(T2/1[K])))[m^2/s]' '0' '0' '0' '1.4523e-13*exp(68025.7/8.314*(1/(T_ref/1[K])-1/(T2/1[K])))[m^2/s]'});
model.material('mat4').propertyGroup('def').set('INFO_PREFIX:diffusion', ['K. Kumaresan, G. Sikha, and R. E. White, ' native2unicode(hex2dec({'20' '1c'}), 'unicode') 'Thermal Model for a Li-Ion Cell,' native2unicode(hex2dec({'20' '1d'}), 'unicode') ' J. Electrochem. Soc., vol. 155, p. A164, 2008.']);
model.material('mat4').propertyGroup('def').set('thermalconductivity', {'1[W/(m*K)]' '0' '0' '0' '1[W/(m*K)]' '0' '0' '0' '1[W/(m*K)]'});
model.material('mat4').propertyGroup('def').set('INFO_PREFIX:thermalconductivity', 'S. Chen, C. Wan, and Y. Wang, J. Power Sources, 140, 111 (2005).');
model.material('mat4').propertyGroup('def').set('heatcapacity', '750[J/(kg*K)]');
model.material('mat4').propertyGroup('def').set('INFO_PREFIX:heatcapacity', 'SI Chemical Data, John Wiley & Sons, 1994');
model.material('mat4').propertyGroup('def').set('density', '2300[kg/m^3]');
model.material('mat4').propertyGroup('def').set('INFO_PREFIX:density', 'SI Chemical Data, John Wiley & Sons, 1994');
model.material('mat4').propertyGroup('def').set('csmax', '31507[mol/m^3]');
model.material('mat4').propertyGroup('def').descr('csmax', '');
model.material('mat4').propertyGroup('def').set('T_ref', '318[K]');
model.material('mat4').propertyGroup('def').descr('T_ref', '');
model.material('mat4').propertyGroup('def').set('T2', 'min(393.15,max(T,223.15))');
model.material('mat4').propertyGroup('def').descr('T2', '');
model.material('mat4').propertyGroup('def').addInput('temperature');
model.material('mat4').propertyGroup('def').addInput('concentration');
model.material('mat4').propertyGroup('ElectrodePotential').func('int1').set('funcname', 'Eeq_int1');
model.material('mat4').propertyGroup('ElectrodePotential').func('int1').set('table', {'0' '2.781186612';  ...
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
model.material('mat4').propertyGroup('ElectrodePotential').func('int1').set('interp', 'piecewisecubic');
model.material('mat4').propertyGroup('ElectrodePotential').func('int1').set('extrap', 'linear');
model.material('mat4').propertyGroup('ElectrodePotential').func('int1').set('fununit', {'V'});
model.material('mat4').propertyGroup('ElectrodePotential').func('int1').set('argunit', {''});
model.material('mat4').propertyGroup('ElectrodePotential').func('int1').set('defineinv', true);
model.material('mat4').propertyGroup('ElectrodePotential').func('int1').set('funcinvname', 'Eeq_inv');
model.material('mat4').propertyGroup('ElectrodePotential').func('int2').set('funcname', 'dEeqdT_int1');
model.material('mat4').propertyGroup('ElectrodePotential').func('int2').set('table', {'0' '3.0e-4';  ...
'0.17' '0';  ...
'0.24' '-6e-5';  ...
'0.28' '-1.6e-4';  ...
'0.5' '-1.6e-4';  ...
'0.54' '-9e-5';  ...
'0.71' '-9e-5';  ...
'0.85' '-1.0e-4';  ...
'1.0' '-1.2e-4'});
model.material('mat4').propertyGroup('ElectrodePotential').func('int2').set('fununit', {'V/K'});
model.material('mat4').propertyGroup('ElectrodePotential').func('int2').set('argunit', {''});
model.material('mat4').propertyGroup('ElectrodePotential').set('Eeq', 'Eeq_int1(soc)+dEeqdT_int1(soc)*(T-298[K])');
model.material('mat4').propertyGroup('ElectrodePotential').set('INFO_PREFIX:Eeq', ['D. P Karthikeyan, G. Sikha, and R. E. White, ' native2unicode(hex2dec({'20' '1c'}), 'unicode') 'Thermodynamic model development for lithium intercalation electrodes,' native2unicode(hex2dec({'20' '1d'}), 'unicode') ' J. Power Sources, vol. 185, p. 1398, 2008.']);
model.material('mat4').propertyGroup('ElectrodePotential').set('dEeqdT', 'dEeqdT_int1(soc)');
model.material('mat4').propertyGroup('ElectrodePotential').set('INFO_PREFIX:dEeqdT', ['K. E. Thomas, and J. Newman, ' native2unicode(hex2dec({'20' '1c'}), 'unicode') 'Heats of mixing and of entropy in porous insertion electrodes,' native2unicode(hex2dec({'20' '1d'}), 'unicode') ' J. Power Sources., vol. 119-121, p. 844, 2003.']);
model.material('mat4').propertyGroup('ElectrodePotential').set('cEeqref', 'def.csmax');
model.material('mat4').propertyGroup('ElectrodePotential').set('soc', 'c/cEeqref');
model.material('mat4').propertyGroup('ElectrodePotential').descr('soc', '');
model.material('mat4').propertyGroup('ElectrodePotential').addInput('concentration');
model.material('mat4').propertyGroup('ElectrodePotential').addInput('temperature');
model.material('mat4').propertyGroup('OperationalSOC').set('socmax', 'elpot.Eeq_inv(E_min)');
model.material('mat4').propertyGroup('OperationalSOC').set('socmin', 'elpot.Eeq_inv(E_max)');
model.material('mat4').propertyGroup('OperationalSOC').set('E_max', '1[V]');
model.material('mat4').propertyGroup('OperationalSOC').set('E_min', '0.075[V]');
model.material('mat4').propertyGroup('ic').func('int1').set('funcname', 'dVOLdSOL');
model.material('mat4').propertyGroup('ic').func('int1').set('table', {'0' '0';  ...
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
model.material('mat4').propertyGroup('ic').func('int1').set('extrap', 'linear');
model.material('mat4').propertyGroup('ic').func('int1').set('fununit', {'%'});
model.material('mat4').propertyGroup('ic').func('int1').set('argunit', {'1'});
model.material('mat4').propertyGroup('ic').set('dvol', 'dVOLdSOL(c/def.csmax)');
model.material('mat4').propertyGroup('ic').set('INFO_PREFIX:dvol', ['S. Schweidler, L. de Biasi, A. Schiele, P. Hartmann, T. Brezesinski and J. Janek, "Volume Changes of Graphite Anodes Revisited: A Combined Operando X-Ray Diffraction and In Situ Pressure Analysis Study", J. Phys. Chem. C, 2018, 122, 8829' native2unicode(hex2dec({'20' '13'}), 'unicode') '8835']);
model.material('mat4').propertyGroup('ic').addInput('concentration');
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
model.material.create('mat6', 'Common', 'comp1');
model.material('mat6').propertyGroup.create('ElectrodePotential', 'Equilibrium potential');
model.material('mat6').label('Lithium Metal, Li (Negative, Li-ion Battery)');
model.material('mat6').propertyGroup('def').set('youngsmodulus', '');
model.material('mat6').propertyGroup('def').set('poissonsratio', '');
model.material('mat6').propertyGroup('def').set('density', '');
model.material('mat6').propertyGroup('def').set('thermalconductivity', '');
model.material('mat6').propertyGroup('def').set('electricconductivity', '');
model.material('mat6').propertyGroup('def').set('heatcapacity', '');
model.material('mat6').propertyGroup('def').set('youngsmodulus', '2[GPa]');
model.material('mat6').propertyGroup('def').set('INFO_PREFIX:youngsmodulus', 'Yue Qi et al 2010 J. Electrochem. Soc. 157 A558');
model.material('mat6').propertyGroup('def').set('poissonsratio', '0.34');
model.material('mat6').propertyGroup('def').set('INFO_PREFIX:poissonsratio', 'Yue Qi et al 2010 J. Electrochem. Soc. 157 A558');
model.material('mat6').propertyGroup('def').set('density', '0.534[g/cm^3]');
model.material('mat6').propertyGroup('def').set('INFO_PREFIX:density', 'https://en.wikipedia.org/wiki/Lithium');
model.material('mat6').propertyGroup('def').set('thermalconductivity', {'84.8[W/(m*K)]' '0' '0' '0' '84.8[W/(m*K)]' '0' '0' '0' '84.8[W/(m*K)]'});
model.material('mat6').propertyGroup('def').set('INFO_PREFIX:thermalconductivity', 'https://en.wikipedia.org/wiki/Lithium');
model.material('mat6').propertyGroup('def').set('electricconductivity', {['1/(92.8[n' 'ohm' '*m])'] '0' '0' '0' ['1/(92.8[n' 'ohm' '*m])'] '0' '0' '0' ['1/(92.8[n' 'ohm' '*m])']});
model.material('mat6').propertyGroup('def').set('INFO_PREFIX:electricconductivity', 'https://en.wikipedia.org/wiki/Lithium');
model.material('mat6').propertyGroup('def').set('heatcapacity', '3.58[kJ/kg/K]');
model.material('mat6').propertyGroup('def').set('INFO_PREFIX:heatcapacity', 'https://en.wikipedia.org/wiki/Lithium');
model.material('mat6').propertyGroup('ElectrodePotential').set('Eeq', '0[V]');
model.material('mat6').propertyGroup('ElectrodePotential').set('dEeqdT', '0[V/K]');
model.material('mat6').propertyGroup('ElectrodePotential').set('cEeqref', '0[M]');
model.material('mat6').propertyGroup('ElectrodePotential').addInput('concentration');
model.material('mat6').propertyGroup('ElectrodePotential').addInput('temperature');
model.material('mat1').selection.named('sel5');
model.material('mat2').selection.named('sel1');
model.material('mat3').selection.named('sel4');
model.material('mat4').selection.named('sel2');
model.material('mat5').selection.named('sel3');
model.material('mat6').selection.named('sel6');

model.physics('liion').feature('sep1').set('epsl', 'epsl_sep');
model.physics('liion').create('pce1', 'PorousElectrode', 2);
model.physics('liion').feature('pce1').label('Porous Electrode 1 (Negative)');
model.physics('liion').feature('pce1').selection.named('sel2');
model.physics('liion').feature('pce1').set('ElectrolyteMaterial', 'mat5');
model.physics('liion').feature('pce1').set('sigma', {'sigmas_neg' '0' '0' '0' 'sigmas_neg' '0' '0' '0' 'sigmas_neg'});
model.physics('liion').feature('pce1').set('epss', 'epss_neg');
model.physics('liion').feature('pce1').set('epsl', 'epsl_neg');
model.physics('liion').feature('pce1').feature('pin1').set('ParticleMaterial', 'mat4');
model.physics('liion').feature('pce1').feature('pin1').set('rp', 'rp_neg');
model.physics('liion').feature('pce1').feature('pin1').set('HeatMix', true);
model.physics('liion').feature('pce1').feature('per1').set('MaterialOption', 'mat4');
model.physics('liion').feature('pce1').feature('per1').set('i0_ref', 'i0ref_neg');
model.physics('liion').feature.duplicate('pce2', 'pce1');
model.physics('liion').feature('pce2').label('Porous Electrode 2 (Positive)');
model.physics('liion').feature('pce2').selection.named('sel4');
model.physics('liion').feature('pce2').set('sigma', {'sigmas_pos' '0' '0' '0' 'sigmas_pos' '0' '0' '0' 'sigmas_pos'});
model.physics('liion').feature('pce2').set('epss', 'epss_pos');
model.physics('liion').feature('pce2').set('epsl', 'epsl_pos');
model.physics('liion').feature('pce2').feature('pin1').set('ParticleMaterial', 'mat3');
model.physics('liion').feature('pce2').feature('pin1').set('rp', 'rp_pos');
model.physics('liion').feature('pce2').feature('per1').set('MaterialOption', 'mat3');
model.physics('liion').feature('pce2').feature('per1').set('i0_ref', 'i0ref_pos');
model.physics('liion').feature.duplicate('pce3', 'pce1');
model.physics('liion').feature('pce3').label('Porous Electrode 1 (Negative, Electrochemically Inactive)');
model.physics('liion').feature('pce3').selection.set([3]);
model.physics('liion').feature('pce3').set('IntercalationOption', 'NonIntercalatingParticles');
model.physics('liion').feature('pce3').feature('per1').set('Eeq_mat', 'userdef');
model.physics('liion').feature('pce3').feature('per1').set('Eeq', '0.1[V]');
model.physics('liion').feature('pce3').feature('per1').set('ilocmat_mat', 'userdef');
model.physics('liion').feature('pce3').feature('per1').set('dEeqdT_mat', 'userdef');
model.physics('liion').feature.duplicate('pce4', 'pce2');
model.physics('liion').feature('pce4').label('Porous Electrode 2 (Positive, Electrochemically Inactive)');
model.physics('liion').feature('pce4').selection.set([5]);
model.physics('liion').feature('pce4').set('IntercalationOption', 'NonIntercalatingParticles');
model.physics('liion').feature('pce4').feature('per1').set('Eeq_mat', 'userdef');
model.physics('liion').feature('pce4').feature('per1').set('Eeq', '0.1[V]+E_cell');
model.physics('liion').feature('pce4').feature('per1').set('ilocmat_mat', 'userdef');
model.physics('liion').feature('pce4').feature('per1').set('dEeqdT_mat', 'userdef');
model.physics('liion').create('cc1', 'CurrentConductor', 2);
model.physics('liion').feature('cc1').selection.named('uni1');
model.physics('liion').feature('cc1').label('Electrode 1 (CCs and Filament)');
model.physics('liion').create('egnd1', 'ElectricGround', 1);
model.physics('liion').feature('egnd1').selection.named('sel7');
model.physics('liion').create('pot1', 'ElectricPotential', 1);
model.physics('liion').feature('pot1').selection.named('sel8');
model.physics('liion').feature('pot1').set('phisbnd', 'E_cell');
model.physics('liion').prop('CellSettings').set('CellSOCandInitialChargeInventory', true);
model.physics('liion').feature('socicd1').set('InitialChargeType', 'CellVoltage');
model.physics('liion').feature('socicd1').set('Ecell_init', 'E_cell');
model.physics('liion').feature('socicd1').feature('neges1').selection.named('sel2');
model.physics('liion').feature('socicd1').feature('poses1').selection.named('sel4');
model.physics('ht').create('temp1', 'TemperatureBoundary', 1);
model.physics('ht').feature('temp1').selection.named('uni2');
model.physics('ht').feature('temp1').set('T0', 'T0');
model.physics('ht').feature('init1').set('Tinit', 'T0');

model.multiphysics.create('ech1', 'ElectrochemicalHeating', 'geom1', 2);

model.material('mat3').propertyGroup('def').set('density', {'rho_pos'});
model.material('mat3').propertyGroup('def').set('heatcapacity', {'Cp_pos'});
model.material('mat5').propertyGroup('def').set('thermalconductivity', {'k_sep'});
model.material('mat5').propertyGroup('def').set('density', {'rho_sep'});
model.material('mat5').propertyGroup('def').set('heatcapacity', {'Cp_sep'});

model.func.create('step1', 'Step');
model.func('step1').model('comp1');
model.func('step1').set('location', 0.5);
model.func('step1').set('smooth', 1);

model.material('mat6').propertyGroup('def').set('electricconductivity', {['max(step1(t/t_ramp),1e-8)/(92.8[n' 'ohm' '*m])']});

model.mesh('mesh1').create('ftri1', 'FreeTri');
model.mesh('mesh1').feature('ftri1').selection.geom('geom1', 2);
model.mesh('mesh1').feature('ftri1').selection.set([1 2 3 4 5 6]);
model.mesh('mesh1').feature('ftri1').create('dis1', 'Distribution');
model.mesh('mesh1').feature('ftri1').feature('dis1').selection.set([35 36]);
model.mesh('mesh1').feature('ftri1').feature('dis1').set('numelem', 10);
model.mesh('mesh1').create('map1', 'Map');
model.mesh('mesh1').feature('map1').set('smoothcontrol', false);
model.mesh('mesh1').feature('map1').create('dis1', 'Distribution');
model.mesh('mesh1').feature('map1').feature('dis1').selection.set([20 22 24 26 28 29]);
model.mesh('mesh1').feature('map1').feature('dis1').set('type', 'predefined');
model.mesh('mesh1').feature('map1').feature('dis1').set('elemcount', 20);
model.mesh('mesh1').feature('map1').feature('dis1').set('elemratio', 10);
model.mesh('mesh1').feature('map1').feature('dis1').set('reverse', true);
model.mesh('mesh1').run;

model.probe.create('dom1', 'Domain');
model.probe('dom1').model('comp1');
model.probe('dom1').set('intsurface', true);
model.probe('dom1').set('intvolume', true);
model.probe('dom1').label('Max temperature probe');
model.probe('dom1').set('type', 'maximum');
model.probe('dom1').set('expr', 'T');

model.cpl.create('maxop1', 'Maximum', 'geom1');
model.cpl('maxop1').selection.all;

model.study('std1').feature('time').set('tlist', '0 10^range(-3,0.5,-1)');
model.study('std1').create('param', 'Parametric');
model.study('std1').feature('param').setIndex('pname', 'R_in', 0);
model.study('std1').feature('param').setIndex('plistarr', '', 0);
model.study('std1').feature('param').setIndex('punit', 'm', 0);
model.study('std1').feature('param').setIndex('pname', 'R_in', 0);
model.study('std1').feature('param').setIndex('plistarr', '', 0);
model.study('std1').feature('param').setIndex('punit', 'm', 0);
model.study('std1').feature('param').setIndex('plistarr', '1 5', 0);
model.study('std1').feature('param').setIndex('punit', 'um', 0);
model.study('std1').setGenPlots(false);

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
model.sol('sol1').feature('t1').set('tlist', '0 10^range(-3,0.5,-1)');
model.sol('sol1').feature('t1').set('plot', 'off');
model.sol('sol1').feature('t1').set('plotgroup', 'Default');
model.sol('sol1').feature('t1').set('plotfreq', 'tout');
model.sol('sol1').feature('t1').set('probesel', 'all');
model.sol('sol1').feature('t1').set('probes', {'dom1'});
model.sol('sol1').feature('t1').set('probefreq', 'tsteps');
model.sol('sol1').feature('t1').set('rtol', 0.001);
model.sol('sol1').feature('t1').set('atolglobalvaluemethod', 'factor');
model.sol('sol1').feature('t1').set('atolmethod', {'comp1_cl' 'global' 'comp1_liion_pce1_cs' 'global' 'comp1_liion_pce2_cs' 'global' 'comp1_liion_Q_cell_init' 'global' 'comp1_phil' 'global'  ...
'comp1_phis' 'global' 'comp1_T' 'global'});
model.sol('sol1').feature('t1').set('atol', {'comp1_cl' '1e-3' 'comp1_liion_pce1_cs' '1e-3' 'comp1_liion_pce2_cs' '1e-3' 'comp1_liion_Q_cell_init' '1e-3' 'comp1_phil' '1e-3'  ...
'comp1_phis' '1e-3' 'comp1_T' '1e-3'});
model.sol('sol1').feature('t1').set('atolvaluemethod', {'comp1_cl' 'factor' 'comp1_liion_pce1_cs' 'factor' 'comp1_liion_pce2_cs' 'factor' 'comp1_liion_Q_cell_init' 'factor' 'comp1_phil' 'factor'  ...
'comp1_phis' 'factor' 'comp1_T' 'factor'});
model.sol('sol1').feature('t1').set('eventout', true);
model.sol('sol1').feature('t1').set('reacf', true);
model.sol('sol1').feature('t1').set('storeudot', true);
model.sol('sol1').feature('t1').set('endtimeinterpolation', true);
model.sol('sol1').feature('t1').set('estrat', 'exclude');
model.sol('sol1').feature('t1').set('maxorder', 2);
model.sol('sol1').feature('t1').set('initialstepbdfactive', true);
model.sol('sol1').feature('t1').set('initialstepbdf', '(1)[s]');
model.sol('sol1').feature('t1').set('control', 'time');
model.sol('sol1').feature('t1').feature('aDef').set('cachepattern', true);
model.sol('sol1').feature('t1').create('seDef', 'Segregated');
model.sol('sol1').feature('t1').create('se1', 'Segregated');
model.sol('sol1').feature('t1').feature('se1').feature.remove('ssDef');
model.sol('sol1').feature('t1').feature('se1').create('ss1', 'SegregatedStep');
model.sol('sol1').feature('t1').feature('se1').feature('ss1').set('segvar', {'comp1_T' 'comp1_phil' 'comp1_cl' 'comp1_phis'});
model.sol('sol1').feature('t1').feature('se1').feature('ss1').set('subdamp', 0.8);
model.sol('sol1').feature('t1').feature('se1').feature('ss1').set('subjtech', 'onevery');
model.sol('sol1').feature('t1').create('d1', 'Direct');
model.sol('sol1').feature('t1').feature('d1').set('linsolver', 'pardiso');
model.sol('sol1').feature('t1').feature('d1').set('pivotperturb', 1.0E-13);
model.sol('sol1').feature('t1').feature('d1').label('Direct, heat transfer variables (ht) (Merged)');
model.sol('sol1').feature('t1').feature('se1').feature('ss1').set('linsolver', 'd1');
model.sol('sol1').feature('t1').feature('se1').feature('ss1').label('Merged Variables');
model.sol('sol1').feature('t1').feature('se1').create('ss2', 'SegregatedStep');
model.sol('sol1').feature('t1').feature('se1').feature('ss2').set('segvar', {'comp1_liion_pce1_cs'});
model.sol('sol1').feature('t1').feature('se1').feature('ss2').set('linsolver', 'd1');
model.sol('sol1').feature('t1').feature('se1').feature('ss2').label('Insertion Particle Concentration Variables');
model.sol('sol1').feature('t1').feature('se1').create('ss3', 'SegregatedStep');
model.sol('sol1').feature('t1').feature('se1').feature('ss3').set('segvar', {'comp1_liion_pce2_cs'});
model.sol('sol1').feature('t1').feature('se1').feature('ss3').set('linsolver', 'd1');
model.sol('sol1').feature('t1').feature('se1').feature('ss3').label('Insertion Particle Concentration Variables (2)');
model.sol('sol1').feature('t1').feature('se1').set('segstabacc', 'segaacc');
model.sol('sol1').feature('t1').feature('se1').set('segaaccdim', 5);
model.sol('sol1').feature('t1').feature('se1').set('segaaccmix', 0.9);
model.sol('sol1').feature('t1').feature('se1').set('segaaccdelay', 0);
model.sol('sol1').feature('t1').feature('se1').create('ll1', 'LowerLimit');
model.sol('sol1').feature('t1').feature('se1').feature('ll1').set('lowerlimit', 'comp1.T 0 ');
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
model.sol('sol1').feature('t1').create('i3', 'Iterative');
model.sol('sol1').feature('t1').feature('i3').set('linsolver', 'gmres');
model.sol('sol1').feature('t1').feature('i3').set('prefuntype', 'left');
model.sol('sol1').feature('t1').feature('i3').set('itrestart', 50);
model.sol('sol1').feature('t1').feature('i3').set('rhob', 20);
model.sol('sol1').feature('t1').feature('i3').set('maxlinit', 10000);
model.sol('sol1').feature('t1').feature('i3').set('nlinnormuse', 'on');
model.sol('sol1').feature('t1').feature('i3').label('AMG, heat transfer variables (ht)');
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
model.sol('sol1').feature('t1').feature('i3').feature('mg1').feature('pr').create('so1', 'SOR');
model.sol('sol1').feature('t1').feature('i3').feature('mg1').feature('pr').feature('so1').set('iter', 2);
model.sol('sol1').feature('t1').feature('i3').feature('mg1').feature('pr').feature('so1').set('relax', 0.9);
model.sol('sol1').feature('t1').feature('i3').feature('mg1').feature('po').create('so1', 'SOR');
model.sol('sol1').feature('t1').feature('i3').feature('mg1').feature('po').feature('so1').set('iter', 2);
model.sol('sol1').feature('t1').feature('i3').feature('mg1').feature('po').feature('so1').set('relax', 0.9);
model.sol('sol1').feature('t1').feature('i3').feature('mg1').feature('cs').create('d1', 'Direct');
model.sol('sol1').feature('t1').feature('i3').feature('mg1').feature('cs').feature('d1').set('linsolver', 'pardiso');
model.sol('sol1').feature('t1').feature('i3').feature('mg1').feature('cs').feature('d1').set('pivotperturb', 1.0E-13);
model.sol('sol1').feature('t1').feature.remove('fcDef');
model.sol('sol1').feature('t1').feature.remove('seDef');
model.sol('sol1').attach('std1');

model.batch.create('p1', 'Parametric');
model.batch('p1').study('std1');
model.batch('p1').create('so1', 'Solutionseq');
model.batch('p1').feature('so1').set('seq', 'sol1');
model.batch('p1').feature('so1').set('store', 'on');
model.batch('p1').feature('so1').set('clear', 'on');
model.batch('p1').feature('so1').set('psol', 'none');
model.batch('p1').set('pname', {'R_in'});
model.batch('p1').set('plistarr', {'1 5'});
model.batch('p1').set('sweeptype', 'sparse');
model.batch('p1').set('probesel', 'all');
model.batch('p1').set('probes', {'dom1'});
model.batch('p1').set('plot', 'off');
model.batch('p1').set('err', 'on');
model.batch('p1').attach('std1');
model.batch('p1').set('control', 'param');

model.sol.create('sol3');
model.sol('sol3').study('std1');
model.sol('sol3').label('Parametric Solutions 1');

model.batch('p1').feature('so1').set('psol', 'sol3');

model.probe('dom1').genResult('none');

model.batch('p1').run('compute');

model.result.dataset.create('rev1', 'Revolve2D');
model.result.dataset('rev1').set('startangle', -90);
model.result.dataset('rev1').set('revangle', 225);
model.result.create('pg2', 'PlotGroup3D');
model.result('pg2').run;
model.result('pg2').label('Temperature (revolution plot)');
model.result('pg2').create('surf1', 'Surface');
model.result('pg2').feature('surf1').set('expr', 'T');
model.result('pg2').run;
model.result.create('pg3', 'PlotGroup1D');
model.result('pg3').run;
model.result('pg3').label('Temperature along separator');
model.result('pg3').set('data', 'dset3');
model.result('pg3').setIndex('looplevelinput', 'last', 0);
model.result('pg3').create('lngr1', 'LineGraph');
model.result('pg3').feature('lngr1').set('markerpos', 'datapoints');
model.result('pg3').feature('lngr1').set('linewidth', 'preference');
model.result('pg3').feature('lngr1').selection.set([9 16 18 26]);
model.result('pg3').feature('lngr1').set('expr', 'T');
model.result('pg3').feature('lngr1').set('xdata', 'expr');
model.result('pg3').feature('lngr1').set('xdataexpr', 'r');
model.result('pg3').run;
model.result.create('pg4', 'PlotGroup2D');
model.result('pg4').run;
model.result('pg4').label('Local soc');
model.result('pg4').create('surf1', 'Surface');
model.result('pg4').feature('surf1').set('expr', 'liion.socloc_surface');
model.result('pg4').feature('surf1').set('descr', 'Local electrode material state of charge, particle surface');
model.result('pg4').run;
model.result.create('pg5', 'PlotGroup1D');
model.result('pg5').run;
model.result('pg5').label('Max temperature vs. time');
model.result('pg5').set('data', 'dset3');
model.result('pg5').set('legendpos', 'lowerright');
model.result('pg5').create('glob1', 'Global');
model.result('pg5').feature('glob1').set('markerpos', 'datapoints');
model.result('pg5').feature('glob1').set('linewidth', 'preference');
model.result('pg5').feature('glob1').setIndex('expr', 'comp1.maxop1(T)', 0);
model.result('pg5').feature('glob1').setIndex('unit', 'degC', 0);
model.result('pg5').feature('glob1').setIndex('descr', 'Max battery temperature', 0);
model.result('pg5').feature('glob1').set('autodescr', false);
model.result('pg5').run;

model.title('Internal Short Circuit in a Lithium-Ion Battery');

model.description(['During an internal short circuit in a battery, the two electrode materials are internally interconnected electronically, giving rise to high local current densities. Internal short circuits may occur in a lithium-ion battery due to, for instance, lithium dendrite formation or a compressive shock. The high local current densities occurring during an internal short will result in a local temperature increase which may in turn result in thermal runaway of the cell.' newline  newline 'This example simulates the temperature rise due to an internal short circuit by dendrite formation. The model couples the electrochemical heat sources from the battery cell model, mainly due to Joule heating in the electrode phase, to heat transfer.']);

model.mesh.clearMeshes;

model.sol('sol1').clearSolutionData;
model.sol('sol2').clearSolutionData;
model.sol('sol3').clearSolutionData;
model.sol('sol4').clearSolutionData;
model.sol('sol5').clearSolutionData;

model.label('internal_short_circuit.mph');

model.modelNode.label('Components');

out = model;
