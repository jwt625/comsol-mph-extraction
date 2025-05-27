function out = model
%
% li_ion_battery_impedance.m
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

model.study.create('std1');
model.study('std1').create('frlin', 'Frequencylinearized');
model.study('std1').feature('frlin').set('solnum', 'auto');
model.study('std1').feature('frlin').set('notsolnum', 'auto');
model.study('std1').feature('frlin').set('outputmap', {});
model.study('std1').feature('frlin').set('ngenAUX', '1');
model.study('std1').feature('frlin').set('goalngenAUX', '1');
model.study('std1').feature('frlin').set('ngenAUX', '1');
model.study('std1').feature('frlin').set('goalngenAUX', '1');
model.study('std1').feature('frlin').setSolveFor('/physics/liion', true);

% To import content from file, use:
% model.param.loadFile('FILENAME');
model.param.set('L_neg', '115[um]', 'Thickness negative electrode');
model.param.set('L_pos', '35[um]', 'Thickness positive electrode');
model.param.set('L_sep', '50[um]', 'Thickness separator');
model.param.set('sigmas_neg', '100[S/m]', 'Electrical conductivity, negative electrode');
model.param.set('sigmas_pos', '91[S/m]', 'Electrical conductivity, positive electrode');
model.param.set('epscs_pos', '0.11', 'Electronic conductor volume fraction positive electrode');
model.param.set('epsl_pos', '0.29', 'Electrolyte volume fraction positive electrode');
model.param.set('epss_pos', '0.31', 'Active material volume fraction positive electrode');
model.param.set('brugl_pos', '2.928', 'Bruggeman coefficient for tortuosity in positive electrode');
model.param.set('epscs_neg', '0.0423', 'Electronic conductor volume fraction negative electrode');
model.param.set('epsl_neg', '1-epss_neg-epscs_neg-0.048', 'Electrolyte volume fraction negative electrode');
model.param.set('epss_neg', '0.25', 'Active material volume fraction negative electrode');
model.param.set('brugl_neg', '3.50', 'Bruggeman coefficient for tortuosity in negative electrode');
model.param.set('epsl_sep', '0.37', 'Electrolyte volume fraction separator');
model.param.set('brugl_sep', '3.15', 'Bruggeman coefficient for tortuosity in separator');
model.param.set('cl_init', '1200[mol/m^3]', 'Initial electrolyte salt concentration');
model.param.set('soc0_neg', '0.326[1]', 'Initial state of charge negative electrode equal to 1.55V vs Li+/Li(s)');
model.param.set('soc0_pos', '0.588[1]', 'Initial state of charge positive electrode equal to 3.85V vs Li+/Li(s)');
model.param.set('rp_neg', '5e-7[m]', 'Active material particle radius negative electrode');
model.param.set('rp_pos', '2.4911e-7[m]', 'Active material particle radius positive electrode');
model.param.set('as_pos', '1.9248e6', 'Specific surface area positive electrode material');
model.param.set('i0_pos', '5', 'Exchange current density positive electrode');
model.param.set('Rfilm_pos', '1e-2', 'Film resistance positive electrode');
model.param.set('cdl_pos', '1', 'Double layer capacitance positive electrode material');
model.param.set('cdlvol_cs_pos', '5e5', 'Volumetric capacitance of electronic conductor in positive electrode');
model.param.set('Rfilm_neg', '1e-5', 'Film resistance negative electrode');
model.param.set('i0ref_neg', '1.08e3[A/m^2]', 'Reference exchange current density negative electrode');
model.param.set('cdl_neg', 'cdl_pos', 'Double layer capacitance positive electrode material');
model.param.set('R_curr', '1.1e-4[m^2/S]', 'Current collector resistance at each current collector');
model.param.set('A_cell', '32[cm^2]', 'Current collector area');
model.param.set('E_pert', '0.01[V]', 'Amplitude Amplitude in potential perturbation');
model.param.set('pe_on_i0pos', 'on', 'Parameter to control parameter estimation of i0_pos');
model.param.set('pe_on_rflim', 'on', 'Parameter to control parameter estimation of rfimlpos');
model.param.set('pe_on_cdlpos', 'on', 'Parameter to control parameter estimation of cdlpos');
model.param.set('pe_on_cdlvolpos', 'on', 'Parameter to control parameter estimation of cdlvolpos');
model.param.set('on', '1');
model.param.set('off', '0');
model.param.set('opt_tol', '1e-4', 'Optimality tolerance');
model.param.set('D_pos', '1.5e-15[m^2/s]', 'Diffusivity');
model.param.set('pe_on_D_pos', 'on', 'Parameter to control parameter estimation of D_pos');

model.variable.create('var1');
model.variable('var1').model('comp1');

model.geom('geom1').run;

% To import content from file, use:
% model.variable('var1').loadFile('FILENAME');
model.variable('var1').set('Z_ground', '-lindev(phis)/lindev(liion.nIs)+linpoint(R_curr)', 'Impedance vs ground');
model.variable('var1').set('Z_ref_NCA', '-(lindev(phis)-lindev(RE_phi))/lindev(liion.nIs)+linpoint(R_curr)', 'Impedance (NCA) positive electrode vs reference');
model.variable('var1').set('Z_ref_LTO', 'Z_ground-Z_ref_NCA+linpoint(R_curr)', 'Impedance (LTO) negative electrode vs reference');
model.variable('var1').set('E_cell_init', 'mat3.elpot.Eeq_int1(soc0_pos*mat3.elpot.cEeqref/mat3.elpot.cEeqref)-mat1.elpot.Eeq_int1(soc0_neg*mat1.elpot.cEeqref/mat1.elpot.cEeqref)', 'Initial cell voltage');

model.geom('geom1').create('i1', 'Interval');
model.geom('geom1').feature('i1').setIndex('coord', 'L_neg', 1);
model.geom('geom1').run('i1');
model.geom('geom1').create('i2', 'Interval');
model.geom('geom1').feature('i2').setIndex('coord', 'L_neg', 0);
model.geom('geom1').feature('i2').setIndex('coord', 'L_neg+L_sep', 1);
model.geom('geom1').run('i2');
model.geom('geom1').create('i3', 'Interval');
model.geom('geom1').feature('i3').setIndex('coord', 'L_neg+L_sep', 0);
model.geom('geom1').feature('i3').setIndex('coord', 'L_neg+L_sep+L_pos', 1);
model.geom('geom1').run('i3');

model.material.create('mat1', 'Common', 'comp1');
model.material('mat1').propertyGroup.create('ElectrodePotential', 'Equilibrium potential');
model.material('mat1').propertyGroup('ElectrodePotential').func.create('int1', 'Interpolation');
model.material('mat1').propertyGroup.create('OperationalSOC', 'Operational electrode state of charge');
model.material('mat1').propertyGroup.create('ic', 'Intercalation strain');
model.material('mat1').propertyGroup.create('EquilibriumConcentration', 'Equilibrium concentration');
model.material('mat1').label('LTO, Li4Ti5O12 (Negative, Li-ion Battery)');
model.material('mat1').comments([ newline ]);
model.material('mat1').propertyGroup('def').set('diffusion', {'6.8e-15[m^2/s]' '0' '0' '0' '6.8e-15[m^2/s]' '0' '0' '0' '6.8e-15[m^2/s]'});
model.material('mat1').propertyGroup('def').set('INFO_PREFIX:diffusion', 'P. Albertus, J. Couts, and V. Srinivasan, "II. A combined model for determining capacity usage and plug-in hybrid electric vehicles", J. Power Sources, vol. 183, p. 771, 2008');
model.material('mat1').propertyGroup('def').set('electricconductivity', {'100[S/m]' '0' '0' '0' '100[S/m]' '0' '0' '0' '100[S/m]'});
model.material('mat1').propertyGroup('def').set('density', '3400[kg/m^3]');
model.material('mat1').propertyGroup('def').set('INFO_PREFIX:density', 'N. Nitta, F. Wu, J. Tae Lee, and G. Yushin, Materials Today, Volume 18, Number 5, June 2015');
model.material('mat1').propertyGroup('def').set('csmax', '22852[mol/m^3]');
model.material('mat1').propertyGroup('def').descr('csmax', '');
model.material('mat1').propertyGroup('ElectrodePotential').func('int1').set('funcname', 'Eeq_int1');
model.material('mat1').propertyGroup('ElectrodePotential').func('int1').set('table', {'0' '2.228201418';  ...
'0.01' '1.834270406';  ...
'0.02' '1.769694648';  ...
'0.03' '1.718942051';  ...
'0.04' '1.665890342';  ...
'0.05' '1.62099317';  ...
'0.06' '1.590316013';  ...
'0.07' '1.572303079';  ...
'0.08' '1.562627805';  ...
'0.09' '1.557650415';  ...
'0.1' '1.555118153';  ...
'0.11' '1.553809207';  ...
'0.12' '1.553100548';  ...
'0.13' '1.55268369';  ...
'0.14' '1.552408035';  ...
'0.15' '1.552200555';  ...
'0.16' '1.552025958';  ...
'0.17' '1.551867213';  ...
'0.18' '1.551716108';  ...
'0.19' '1.551568684';  ...
'0.2' '1.551423034';  ...
'0.21' '1.551278239';  ...
'0.22' '1.551133856';  ...
'0.23' '1.550989672';  ...
'0.24' '1.550845583';  ...
'0.25' '1.55070154';  ...
'0.26' '1.550557519';  ...
'0.27' '1.550413509';  ...
'0.28' '1.550269504';  ...
'0.29' '1.550125502';  ...
'0.3' '1.549981501';  ...
'0.31' '1.5498375';  ...
'0.32' '1.5496935';  ...
'0.33' '1.5495495';  ...
'0.34' '1.5494055';  ...
'0.35' '1.5492615';  ...
'0.36' '1.5491175';  ...
'0.37' '1.5489735';  ...
'0.38' '1.5488295';  ...
'0.39' '1.5486855';  ...
'0.4' '1.5485415';  ...
'0.41' '1.5483975';  ...
'0.42' '1.5482535';  ...
'0.43' '1.5481095';  ...
'0.44' '1.5479655';  ...
'0.45' '1.5478215';  ...
'0.46' '1.5476775';  ...
'0.47' '1.5475335';  ...
'0.48' '1.5473895';  ...
'0.49' '1.5472455';  ...
'0.5' '1.5471015';  ...
'0.51' '1.5469575';  ...
'0.52' '1.5468135';  ...
'0.53' '1.5466695';  ...
'0.54' '1.5465255';  ...
'0.55' '1.5463815';  ...
'0.56' '1.5462375';  ...
'0.57' '1.5460935';  ...
'0.58' '1.5459495';  ...
'0.59' '1.5458055';  ...
'0.6' '1.5456615';  ...
'0.61' '1.5455175';  ...
'0.62' '1.5453735';  ...
'0.63' '1.5452295';  ...
'0.64' '1.5450855';  ...
'0.65' '1.5449415';  ...
'0.66' '1.5447975';  ...
'0.67' '1.5446535';  ...
'0.68' '1.5445095';  ...
'0.69' '1.5443655';  ...
'0.7' '1.5442215';  ...
'0.71' '1.5440775';  ...
'0.72' '1.5439335';  ...
'0.73' '1.5437895';  ...
'0.74' '1.543645501';  ...
'0.75' '1.543501502';  ...
'0.76' '1.543357511';  ...
'0.77' '1.543213545';  ...
'0.78' '1.543069643';  ...
'0.79' '1.54290683';  ...
'0.8' '1.540448721';  ...
'0.81' '1.539545288';  ...
'0.82' '1.539411818';  ...
'0.83' '1.539247179';  ...
'0.84' '1.538618467';  ...
'0.85' '1.534813267';  ...
'0.86' '1.520453134';  ...
'0.87' '1.504450253';  ...
'0.88' '1.493585271';  ...
'0.89' '1.472914822';  ...
'0.9' '1.447481846';  ...
'0.91' '1.421065131';  ...
'0.92' '1.394494058';  ...
'0.93' '1.367903211';  ...
'0.94' '1.341310809';  ...
'0.95' '1.314718596';  ...
'0.96' '1.288126526';  ...
'0.97' '1.261534507';  ...
'0.98' '1.234942502';  ...
'0.99' '1.2083505';  ...
'1' '1.1817585'});
model.material('mat1').propertyGroup('ElectrodePotential').func('int1').set('interp', 'piecewisecubic');
model.material('mat1').propertyGroup('ElectrodePotential').func('int1').set('extrap', 'linear');
model.material('mat1').propertyGroup('ElectrodePotential').func('int1').set('fununit', {'V'});
model.material('mat1').propertyGroup('ElectrodePotential').func('int1').set('argunit', {''});
model.material('mat1').propertyGroup('ElectrodePotential').func('int1').set('defineinv', true);
model.material('mat1').propertyGroup('ElectrodePotential').func('int1').set('funcinvname', 'Eeq_inv');
model.material('mat1').propertyGroup('ElectrodePotential').set('Eeq', 'Eeq_int1(soc)+dEeqdT*(T-298[K])');
model.material('mat1').propertyGroup('ElectrodePotential').set('INFO_PREFIX:Eeq', 'P. Albertus, J. Couts, and V. Srinivasan, "II. A combined model for determining capacity usage and plug-in hybrid electric vehicles", J. Power Sources, vol. 183, p. 771, 2008');
model.material('mat1').propertyGroup('ElectrodePotential').set('dEeqdT', '-1[J/mol/K]/F_const');
model.material('mat1').propertyGroup('ElectrodePotential').set('INFO_PREFIX:dEeqdT', 'V Viswanathan, D Choi, D Wang, W Xu, S Towne, R Williford, JG Zhang, J Liu and Z Yang "Effect of entropy change on lithium intercalation in cathodes and anodes on Li-ion battery thermal management", Journal of Power Sources 195 (2010) 3720-3729');
model.material('mat1').propertyGroup('ElectrodePotential').set('cEeqref', 'def.csmax');
model.material('mat1').propertyGroup('ElectrodePotential').set('INFO_PREFIX:cEeqref', 'P. Albertus, J. Couts, and V. Srinivasan, "II. A combined model for determining capacity usage and plug-in hybrid electric vehicles", J. Power Sources, vol. 183, p. 771, 2008');
model.material('mat1').propertyGroup('ElectrodePotential').set('soc', 'c/cEeqref');
model.material('mat1').propertyGroup('ElectrodePotential').descr('soc', '');
model.material('mat1').propertyGroup('ElectrodePotential').addInput('concentration');
model.material('mat1').propertyGroup('ElectrodePotential').addInput('temperature');
model.material('mat1').propertyGroup('OperationalSOC').set('socmax', 'elpot.Eeq_inv(E_min)');
model.material('mat1').propertyGroup('OperationalSOC').set('socmin', 'elpot.Eeq_inv(E_max)');
model.material('mat1').propertyGroup('OperationalSOC').set('E_max', '1.8[V]');
model.material('mat1').propertyGroup('OperationalSOC').set('E_min', '1.2[V]');
model.material('mat1').propertyGroup('ic').set('dvol', '0');
model.material('mat1').propertyGroup('ic').set('INFO_PREFIX:dvol', ['R. Koerver and others, ' native2unicode(hex2dec({'20' '1c'}), 'unicode') 'Chemo-mechanical expansion of lithium electrode materials ' native2unicode(hex2dec({'20' '14'}), 'unicode') ' on the route to mechanically optimized all-solid-state batteries,' native2unicode(hex2dec({'20' '1d'}), 'unicode') ' Energy Environ. Sci., vol. 11, pp. 2142' native2unicode(hex2dec({'20' '13'}), 'unicode') '2158, 201']);
model.material('mat1').propertyGroup('EquilibriumConcentration').set('csEq', 'def.csmax*elpot.Eeq_inv(V)');
model.material('mat1').propertyGroup('EquilibriumConcentration').addInput('electricpotential');

model.geom('geom1').run;

model.material.create('mat2', 'Common', 'comp1');
model.material('mat2').propertyGroup('def').func.create('int1', 'Interpolation');
model.material('mat2').propertyGroup.create('ElectrolyteConductivity', 'Electrolyte conductivity');
model.material('mat2').propertyGroup('ElectrolyteConductivity').func.create('int1', 'Interpolation');
model.material('mat2').propertyGroup.create('SpeciesProperties', 'Species properties');
model.material('mat2').propertyGroup('SpeciesProperties').func.create('int1', 'Interpolation');
model.material('mat2').propertyGroup('SpeciesProperties').func.create('int2', 'Interpolation');
model.material('mat2').propertyGroup.create('ElectrolyteSaltConcentration', 'Electrolyte salt concentration');
model.material('mat2').label('LiPF6 in 3:7 EC:EMC (Liquid, Li-ion Battery)');
model.material('mat2').propertyGroup('def').func('int1').set('funcname', 'DL_int1');
model.material('mat2').propertyGroup('def').func('int1').set('table', {'200' '3.9e-10/(1-200*59e-6)';  ...
'500' '4.12e-10/(1-500*59e-6)';  ...
'800' '4e-10/(1-800*59e-6)';  ...
'1000' '3.8e-10/(1-1000*59e-6)';  ...
'1200' '3.50e-10/(1-1200*59e-6)';  ...
'1600' '2.68e-10/(1-1600*59e-6)';  ...
'2000' '1.9e-10/(1-2000*59e-6)'});
model.material('mat2').propertyGroup('def').func('int1').set('interp', 'piecewisecubic');
model.material('mat2').propertyGroup('def').func('int1').set('fununit', {'m^2/s'});
model.material('mat2').propertyGroup('def').func('int1').set('argunit', {''});
model.material('mat2').propertyGroup('def').set('diffusion', {'DL_int1(c/1[mol/m^3])*exp(16500/8.314*(1/(T_ref/1[K])-1/(T2/1[K])))' '0' '0' '0' 'DL_int1(c/1[mol/m^3])*exp(16500/8.314*(1/(T_ref/1[K])-1/(T2/1[K])))' '0' '0' '0' 'DL_int1(c/1[mol/m^3])*exp(16500/8.314*(1/(T_ref/1[K])-1/(T2/1[K])))'});
model.material('mat2').propertyGroup('def').set('INFO_PREFIX:diffusion', 'T. G. Zavalis, M. Behm, and G. Lindbergh, "Investigations of Short-Circuit Scenarios in a Lithium-Ion Battery Cell," J. Electrochem. Soc., vol. 159, p. A848, 2012.');
model.material('mat2').propertyGroup('def').set('T_ref', '298[K]');
model.material('mat2').propertyGroup('def').descr('T_ref', '');
model.material('mat2').propertyGroup('def').set('T2', 'min(393.15,max(T,223.15))');
model.material('mat2').propertyGroup('def').descr('T2', '');
model.material('mat2').propertyGroup('def').addInput('concentration');
model.material('mat2').propertyGroup('def').addInput('temperature');
model.material('mat2').propertyGroup('ElectrolyteConductivity').func('int1').set('funcname', 'sigmal_int1');
model.material('mat2').propertyGroup('ElectrolyteConductivity').func('int1').set('table', {'0' '1e-6';  ...
'200' '0.455';  ...
'500' '0.783';  ...
'800' '0.935';  ...
'1000' '0.95';  ...
'1200' '0.927';  ...
'1600' '0.78';  ...
'2000' '0.60';  ...
'2200' '0.515'});
model.material('mat2').propertyGroup('ElectrolyteConductivity').func('int1').set('interp', 'piecewisecubic');
model.material('mat2').propertyGroup('ElectrolyteConductivity').func('int1').set('fununit', {'S/m'});
model.material('mat2').propertyGroup('ElectrolyteConductivity').func('int1').set('argunit', {''});
model.material('mat2').propertyGroup('ElectrolyteConductivity').set('sigmal', {'sigmal_int1(c/1[mol/m^3])*exp(4000/8.314*(1/(T_ref2/1[K])-1/(T3/1[K])))' '0' '0' '0' 'sigmal_int1(c/1[mol/m^3])*exp(4000/8.314*(1/(T_ref2/1[K])-1/(T3/1[K])))' '0' '0' '0' 'sigmal_int1(c/1[mol/m^3])*exp(4000/8.314*(1/(T_ref2/1[K])-1/(T3/1[K])))'});
model.material('mat2').propertyGroup('ElectrolyteConductivity').set('INFO_PREFIX:sigmal', 'T. G. Zavalis, M. Behm, and G. Lindbergh, "Investigations of Short-Circuit Scenarios in a Lithium-Ion Battery Cell," J. Electrochem. Soc., vol. 159, p. A848, 2012.');
model.material('mat2').propertyGroup('ElectrolyteConductivity').set('T_ref2', '298[K]');
model.material('mat2').propertyGroup('ElectrolyteConductivity').descr('T_ref2', '');
model.material('mat2').propertyGroup('ElectrolyteConductivity').set('T3', 'min(393.15,max(T,223.15))');
model.material('mat2').propertyGroup('ElectrolyteConductivity').descr('T3', '');
model.material('mat2').propertyGroup('ElectrolyteConductivity').addInput('concentration');
model.material('mat2').propertyGroup('ElectrolyteConductivity').addInput('temperature');
model.material('mat2').propertyGroup('SpeciesProperties').func('int1').set('funcname', 'transpNm_int1');
model.material('mat2').propertyGroup('SpeciesProperties').func('int1').set('table', {'200' '0.37';  ...
'500' '0.322';  ...
'800' '0.27';  ...
'1000' '0.251';  ...
'1200' '0.248';  ...
'1600' '0.236';  ...
'2000' '0.11'});
model.material('mat2').propertyGroup('SpeciesProperties').func('int1').set('interp', 'piecewisecubic');
model.material('mat2').propertyGroup('SpeciesProperties').func('int1').set('fununit', {''});
model.material('mat2').propertyGroup('SpeciesProperties').func('int1').set('argunit', {''});
model.material('mat2').propertyGroup('SpeciesProperties').func('int2').set('funcname', 'actdep_int1');
model.material('mat2').propertyGroup('SpeciesProperties').func('int2').set('table', {'200' '0';  ...
'500' '0.29';  ...
'800' '0.695';  ...
'1000' '1';  ...
'1200' '1.32';  ...
'1600' '2.07';  ...
'2000' '2.50'});
model.material('mat2').propertyGroup('SpeciesProperties').func('int2').set('interp', 'piecewisecubic');
model.material('mat2').propertyGroup('SpeciesProperties').func('int2').set('fununit', {''});
model.material('mat2').propertyGroup('SpeciesProperties').func('int2').set('argunit', {''});
model.material('mat2').propertyGroup('SpeciesProperties').set('transpNum', 'transpNm_int1(c/1[mol/m^3])');
model.material('mat2').propertyGroup('SpeciesProperties').set('INFO_PREFIX:transpNum', ['A. Nyman, M. Behm, and G. Lindbergh, ' native2unicode(hex2dec({'20' '1c'}), 'unicode') 'Electrochemical characterisation and modelling of the mass transport phenomena in LiPF6-EC-EMC,' native2unicode(hex2dec({'20' '1d'}), 'unicode') ' Electrochim. Acta, vol. 53, p. 6356, 2008.']);
model.material('mat2').propertyGroup('SpeciesProperties').set('fcl', 'actdep_int1(c/1[mol/m^3])*exp(-1000/8.314*(1/(T_ref3/1[K])-1/(T4/1[K])))');
model.material('mat2').propertyGroup('SpeciesProperties').set('INFO_PREFIX:fcl', 'T. G. Zavalis, M. Behm, and G. Lindbergh, "Investigations of Short-Circuit Scenarios in a Lithium-Ion Battery Cell," J. Electrochem. Soc., vol. 159, p. A848, 2012.');
model.material('mat2').propertyGroup('SpeciesProperties').set('T4', 'min(393.15,max(T,223.15))');
model.material('mat2').propertyGroup('SpeciesProperties').descr('T4', '');
model.material('mat2').propertyGroup('SpeciesProperties').set('T_ref3', '298[K]');
model.material('mat2').propertyGroup('SpeciesProperties').descr('T_ref3', '');
model.material('mat2').propertyGroup('SpeciesProperties').addInput('concentration');
model.material('mat2').propertyGroup('SpeciesProperties').addInput('temperature');
model.material('mat2').propertyGroup('ElectrolyteSaltConcentration').identifier('cElsalt');
model.material('mat2').propertyGroup('ElectrolyteSaltConcentration').set('cElsalt', '1200[mol/m^3]');
model.material.create('mat3', 'Common', 'comp1');
model.material('mat3').propertyGroup.create('ElectrodePotential', 'Equilibrium potential');
model.material('mat3').propertyGroup('ElectrodePotential').func.create('int1', 'Interpolation');
model.material('mat3').propertyGroup('ElectrodePotential').func.create('int2', 'Interpolation');
model.material('mat3').propertyGroup.create('OperationalSOC', 'Operational electrode state of charge');
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
model.material('mat1').selection.set([1]);
model.material('mat2').selection.set([2]);
model.material('mat3').selection.set([3]);

model.probe.create('pdom1', 'DomainPoint');
model.probe('pdom1').model('comp1');
model.probe('pdom1').label('Reference Electrode (RE) Probe');
model.probe('pdom1').setIndex('coords1', 'L_neg+L_sep/2', 0);
model.probe('pdom1').feature('ppb1').set('probename', 'RE_phi');

model.cpl.create('intop1', 'Integration', 'geom1');
model.cpl('intop1').set('axisym', true);
model.cpl('intop1').selection.geom('geom1', 0);
model.cpl('intop1').selection.set([4]);

model.physics('liion').feature('sep1').set('ElectrolyteMaterial', 'mat2');
model.physics('liion').feature('sep1').set('epsl', 'epsl_sep');
model.physics('liion').feature('sep1').set('IonicCorrModel', 'userdef');
model.physics('liion').feature('sep1').set('fl', 'epsl_sep^brugl_sep');
model.physics('liion').feature('sep1').set('DiffusionCorrModel', 'userdef');
model.physics('liion').feature('sep1').set('fDl', 'epsl_sep^brugl_sep');
model.physics('liion').create('pce1', 'PorousElectrode', 1);
model.physics('liion').feature('pce1').selection.set([1]);
model.physics('liion').feature('pce1').set('ElectrolyteMaterial', 'mat2');
model.physics('liion').feature('pce1').set('sigma', {'sigmas_neg' '0' '0' '0' 'sigmas_neg' '0' '0' '0' 'sigmas_neg'});
model.physics('liion').feature('pce1').set('FilmResistanceType', 'SurfaceResistance');
model.physics('liion').feature('pce1').set('Rfilm', 'Rfilm_neg');
model.physics('liion').feature('pce1').set('epss', 'epss_neg');
model.physics('liion').feature('pce1').set('epsl', 'epsl_neg');
model.physics('liion').feature('pce1').set('IonicCorrModel', 'userdef');
model.physics('liion').feature('pce1').set('fl', 'epsl_neg^brugl_neg');
model.physics('liion').feature('pce1').set('DiffusionCorrModel', 'userdef');
model.physics('liion').feature('pce1').set('fDl', 'epsl_neg^brugl_neg');
model.physics('liion').feature('pce1').feature('pin1').set('ParticleMaterial', 'mat1');
model.physics('liion').feature('pce1').feature('pin1').set('csinit', 'mat1.elpot.cEeqref*soc0_neg');
model.physics('liion').feature('pce1').feature('pin1').set('rp', 'rp_neg');
model.physics('liion').feature('pce1').feature('per1').set('MaterialOption', 'mat1');
model.physics('liion').feature('pce1').feature('per1').set('i0_ref', 'i0ref_neg');
model.physics('liion').feature('pce1').create('pdl1', 'PorousMatrixDoubleLayerCapacitance', 1);
model.physics('liion').feature('pce1').feature('pdl1').set('Cdl', 'cdl_neg');
model.physics('liion').create('pce2', 'PorousElectrode', 1);
model.physics('liion').feature('pce2').selection.set([3]);
model.physics('liion').feature('pce2').set('ElectrolyteMaterial', 'mat2');
model.physics('liion').feature('pce2').set('sigma', {'sigmas_pos' '0' '0' '0' 'sigmas_pos' '0' '0' '0' 'sigmas_pos'});
model.physics('liion').feature('pce2').set('FilmResistanceType', 'SurfaceResistance');
model.physics('liion').feature('pce2').set('Rfilm', 'Rfilm_pos');
model.physics('liion').feature('pce2').set('epss', 'epss_pos');
model.physics('liion').feature('pce2').set('epsl', 'epsl_pos');
model.physics('liion').feature('pce2').set('IonicCorrModel', 'userdef');
model.physics('liion').feature('pce2').set('fl', 'epsl_pos^brugl_pos');
model.physics('liion').feature('pce2').set('DiffusionCorrModel', 'userdef');
model.physics('liion').feature('pce2').set('fDl', 'epsl_pos^brugl_pos');
model.physics('liion').feature('pce2').feature('pin1').set('ParticleMaterial', 'mat3');
model.physics('liion').feature('pce2').feature('pin1').set('csinit', 'mat3.elpot.cEeqref*soc0_pos');
model.physics('liion').feature('pce2').feature('pin1').set('rp', 'rp_pos');
model.physics('liion').feature('pce2').feature('per1').set('MaterialOption', 'mat3');
model.physics('liion').feature('pce2').feature('per1').set('ElectrodeKinetics', 'ButlerVolmer');
model.physics('liion').feature('pce2').feature('per1').set('i0', 'i0_pos');
model.physics('liion').feature('pce2').feature('per1').set('ActiveSpecificSurfaceAreaType', 'userdef');
model.physics('liion').feature('pce2').feature('per1').set('Av', 'as_pos');
model.physics('liion').feature('pce2').create('pdl1', 'PorousMatrixDoubleLayerCapacitance', 1);
model.physics('liion').feature('pce2').feature('pdl1').set('Cdl', 'cdl_pos');
model.physics('liion').feature('pce2').feature('pdl1').set('ActiveSpecificSurfaceAreaType', 'userdef');
model.physics('liion').feature('pce2').feature('pdl1').set('av_dl', 'as_pos');
model.physics('liion').feature('init1').set('phil', '-mat1.elpot.Eeq_int1(soc0_neg)');
model.physics('liion').feature('init1').set('cl', 'cl_init');
model.physics('liion').create('init2', 'init', 1);
model.physics('liion').feature('init2').selection.set([3]);
model.physics('liion').feature('init2').set('phil', '-mat1.elpot.Eeq_int1(soc0_neg)');
model.physics('liion').feature('init2').set('cl', 'cl_init');
model.physics('liion').feature('init2').set('phis', 'mat3.elpot.Eeq_int1(soc0_pos)-mat1.elpot.Eeq_int1(soc0_neg)');
model.physics('liion').create('egnd1', 'ElectricGround', 0);
model.physics('liion').feature('egnd1').selection.set([1]);
model.physics('liion').create('pot1', 'ElectricPotential', 0);
model.physics('liion').feature('pot1').selection.set([4]);
model.physics('liion').feature('pot1').set('phisbnd', 'E_cell_init');
model.physics('liion').feature('pot1').create('hp1', 'HarmonicPerturbation', 0);
model.physics('liion').feature('pot1').feature('hp1').set('deltaphis', 'E_pert');
model.physics('liion').create('addm1', 'IntercalatingMaterial', 1);
model.physics('liion').feature('addm1').selection.set([3]);
model.physics('liion').feature('addm1').set('IntercalationOption', 'NonIntercalatingParticles');
model.physics('liion').feature('addm1').feature('per1').active(false);
model.physics('liion').feature('addm1').create('pdl1', 'PorousMatrixDoubleLayerCapacitance', 1);
model.physics('liion').feature('addm1').feature('pdl1').set('Cdl', '1[F/m^2]');
model.physics('liion').feature('addm1').feature('pdl1').set('ActiveSpecificSurfaceAreaType', 'userdef');
model.physics('liion').feature('addm1').feature('pdl1').set('av_dl', 'cdlvol_cs_pos/1[F/m^2]');

model.mesh('mesh1').automatic(false);
model.mesh('mesh1').feature('size').set('custom', true);
model.mesh('mesh1').feature('size').set('hmax', '1e-5');
model.mesh('mesh1').feature('size1').selection.set([2 3]);
model.mesh('mesh1').feature('size1').set('custom', true);
model.mesh('mesh1').feature('size1').set('hmaxactive', true);
model.mesh('mesh1').feature('size1').set('hmax', '1e-6');
model.mesh('mesh1').feature('size2').selection.set([2 3 4]);
model.mesh('mesh1').feature('size2').set('custom', true);
model.mesh('mesh1').feature('size2').set('hmaxactive', true);
model.mesh('mesh1').feature('size2').set('hmax', '5E-7');

model.study('std1').setGenConv(false);
model.study('std1').feature('frlin').set('plist', '10^{range(-2,0.2,3)}');

model.sol.create('sol1');
model.sol('sol1').study('std1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'frlin');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').set('control', 'frlin');
model.sol('sol1').create('s1', 'Stationary');
model.sol('sol1').feature('s1').set('stol', 1.0E-4);
model.sol('sol1').feature('s1').create('p1', 'Parametric');
model.sol('sol1').feature('s1').feature.remove('pDef');
model.sol('sol1').feature('s1').feature('p1').set('pname', {'freq'});
model.sol('sol1').feature('s1').feature('p1').set('plistarr', {'10^{range(-2,0.2,3)}'});
model.sol('sol1').feature('s1').feature('p1').set('punit', {'Hz'});
model.sol('sol1').feature('s1').feature('p1').set('pcontinuationmode', 'no');
model.sol('sol1').feature('s1').feature('p1').set('preusesol', 'no');
model.sol('sol1').feature('s1').feature('p1').set('pdistrib', 'off');
model.sol('sol1').feature('s1').feature('p1').set('plot', 'off');
model.sol('sol1').feature('s1').feature('p1').set('plotgroup', 'Default');
model.sol('sol1').feature('s1').feature('p1').set('probesel', 'all');
model.sol('sol1').feature('s1').feature('p1').set('probes', {'pdom1'});
model.sol('sol1').feature('s1').feature('p1').set('control', 'frlin');
model.sol('sol1').feature('s1').set('nonlin', 'linper');
model.sol('sol1').feature('s1').set('storelinpoint', true);
model.sol('sol1').feature('s1').set('linpsolnum', 'all');
model.sol('sol1').feature('s1').set('control', 'frlin');
model.sol('sol1').feature('s1').feature('aDef').set('cachepattern', true);
model.sol('sol1').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('s1').feature('fc1').set('dtech', 'auto');
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
model.sol('sol1').feature('s1').feature.remove('fcDef');
model.sol('sol1').attach('std1');

model.probe('pdom1').genResult('none');

model.sol('sol1').runAll;

model.result.create('pg2', 'PlotGroup1D');
model.result('pg2').set('data', 'dset1');
model.result('pg2').create('nyq1', 'Nyquist');
model.result('pg2').feature('nyq1').set('unit', {''});
model.result('pg2').feature('nyq1').set('expr', {'conj(liion.Zvsgrnd_pot1) '});
model.result('pg2').feature('nyq1').set('descr', {''});
model.result('pg2').label('Impedance with Respect to Ground, Nyquist (liion)');
model.result('pg2').feature('nyq1').setIndex('descr', 'Impedance with Respect to Ground', 0);
model.result('pg2').feature('nyq1').set('differential', 'off');
model.result('pg2').feature('nyq1').set('autodescr', 'off');
model.result('pg2').set('preserveaspect', 'on');
model.result('pg2').set('xlabelactive', true);
model.result('pg2').set('xlabel', 'real(Z) (\Omega m<sup>2</sup>)');
model.result('pg2').set('ylabelactive', true);
model.result('pg2').set('ylabel', '-imag(Z) (\Omega m<sup>2</sup>)');
model.result.create('pg3', 'PlotGroup1D');
model.result('pg3').set('data', 'dset1');
model.result('pg3').create('glob1', 'Global');
model.result('pg3').feature('glob1').set('unit', {''});
model.result('pg3').feature('glob1').set('expr', {'real(conj(liion.Zvsgrnd_pot1)) '});
model.result('pg3').feature('glob1').set('descr', {''});
model.result('pg3').label('Impedance with Respect to Ground, Real Part (liion)');
model.result('pg3').feature('glob1').setIndex('descr', 'Impedance with Respect to Ground, Real Part', 0);
model.result('pg3').feature('glob1').set('differential', 'off');
model.result('pg3').feature('glob1').set('xdata', 'expr');
model.result('pg3').feature('glob1').set('xdataexpr', 'freq');
model.result('pg3').feature('glob1').set('autodescr', 'off');
model.result('pg3').feature('glob1').set('xdatasolnumtype', 'level1');
model.result('pg3').set('xlog', 'on');
model.result('pg3').set('ylabelactive', true);
model.result('pg3').set('ylabel', 'real(Z) (\Omega m<sup>2</sup>)');
model.result.create('pg4', 'PlotGroup1D');
model.result('pg4').set('data', 'dset1');
model.result('pg4').create('glob1', 'Global');
model.result('pg4').feature('glob1').set('unit', {''});
model.result('pg4').feature('glob1').set('expr', {'imag(conj(liion.Zvsgrnd_pot1)) '});
model.result('pg4').feature('glob1').set('descr', {''});
model.result('pg4').label('Impedance with Respect to Ground, Imaginary Part (liion)');
model.result('pg4').feature('glob1').setIndex('descr', 'Impedance with Respect to Ground, Imaginary Part', 0);
model.result('pg4').feature('glob1').set('differential', 'off');
model.result('pg4').feature('glob1').set('xdata', 'expr');
model.result('pg4').feature('glob1').set('xdataexpr', 'freq');
model.result('pg4').feature('glob1').set('autodescr', 'off');
model.result('pg4').feature('glob1').set('xdatasolnumtype', 'level1');
model.result('pg4').set('xlog', 'on');
model.result('pg4').set('ylabelactive', true);
model.result('pg4').set('ylabel', '-imag(Z) (\Omega m<sup>2</sup>)');
model.result('pg2').run;
model.result.table.create('tbl2', 'Table');
model.result.table('tbl2').label('Experimental Impedance Table');
model.result.table('tbl2').importData('li_ion_battery_impedance_experimental_data.txt');

model.study('std1').create('lsqo', 'LSQOptimization');
model.study('std1').feature('lsqo').set('source', 'resultTable');
model.study('std1').feature('lsqo').set('resultTable', 'tbl2');
model.study('std1').feature('lsqo').setEntry('columnType', 'col1', 'freq');
model.study('std1').feature('lsqo').setEntry('modelExpression', 'col2', 'comp1.intop1(real(Z_ref_NCA))');
model.study('std1').feature('lsqo').setEntry('variableName', 'col2', 'Real_impedance');
model.study('std1').feature('lsqo').setEntry('scaleMethod', 'col2', 'manual');
model.study('std1').feature('lsqo').setEntry('scaleValue', 'col2', '1e-3');
model.study('std1').feature('lsqo').setEntry('modelExpression', 'col3', 'comp1.intop1(-imag(Z_ref_NCA))');
model.study('std1').feature('lsqo').setEntry('variableName', 'col3', 'Imaginary_impedance');
model.study('std1').feature('lsqo').setEntry('scaleMethod', 'col3', 'manual');
model.study('std1').feature('lsqo').setEntry('scaleValue', 'col3', '1e-3');
model.study('std1').feature('lsqo').setEntry('modelExpression', 'col4', 'comp1.intop1(abs(Z_ref_NCA))');
model.study('std1').feature('lsqo').setEntry('variableName', 'col4', 'Impedance_amplitude');
model.study('std1').feature('lsqo').setEntry('scaleMethod', 'col4', 'manual');
model.study('std1').feature('lsqo').setEntry('scaleValue', 'col4', '1e-3');
model.study('std1').feature('lsqo').setIndex('pname', 'L_neg', 0);
model.study('std1').feature('lsqo').setIndex('initval', '115[um]', 0);
model.study('std1').feature('lsqo').setIndex('scale', 1, 0);
model.study('std1').feature('lsqo').setIndex('lbound', '', 0);
model.study('std1').feature('lsqo').setIndex('ubound', '', 0);
model.study('std1').feature('lsqo').setIndex('pname', 'L_neg', 0);
model.study('std1').feature('lsqo').setIndex('initval', '115[um]', 0);
model.study('std1').feature('lsqo').setIndex('scale', 1, 0);
model.study('std1').feature('lsqo').setIndex('lbound', '', 0);
model.study('std1').feature('lsqo').setIndex('ubound', '', 0);
model.study('std1').feature('lsqo').setIndex('pname', 'L_pos', 1);
model.study('std1').feature('lsqo').setIndex('initval', '35[um]', 1);
model.study('std1').feature('lsqo').setIndex('scale', 1, 1);
model.study('std1').feature('lsqo').setIndex('lbound', '', 1);
model.study('std1').feature('lsqo').setIndex('ubound', '', 1);
model.study('std1').feature('lsqo').setIndex('pname', 'L_pos', 1);
model.study('std1').feature('lsqo').setIndex('initval', '35[um]', 1);
model.study('std1').feature('lsqo').setIndex('scale', 1, 1);
model.study('std1').feature('lsqo').setIndex('lbound', '', 1);
model.study('std1').feature('lsqo').setIndex('ubound', '', 1);
model.study('std1').feature('lsqo').setIndex('pname', 'L_sep', 2);
model.study('std1').feature('lsqo').setIndex('initval', '50[um]', 2);
model.study('std1').feature('lsqo').setIndex('scale', 1, 2);
model.study('std1').feature('lsqo').setIndex('lbound', '', 2);
model.study('std1').feature('lsqo').setIndex('ubound', '', 2);
model.study('std1').feature('lsqo').setIndex('pname', 'L_sep', 2);
model.study('std1').feature('lsqo').setIndex('initval', '50[um]', 2);
model.study('std1').feature('lsqo').setIndex('scale', 1, 2);
model.study('std1').feature('lsqo').setIndex('lbound', '', 2);
model.study('std1').feature('lsqo').setIndex('ubound', '', 2);
model.study('std1').feature('lsqo').setIndex('pname', 'sigmas_neg', 3);
model.study('std1').feature('lsqo').setIndex('initval', '100[S/m]', 3);
model.study('std1').feature('lsqo').setIndex('scale', 1, 3);
model.study('std1').feature('lsqo').setIndex('lbound', '', 3);
model.study('std1').feature('lsqo').setIndex('ubound', '', 3);
model.study('std1').feature('lsqo').setIndex('pname', 'sigmas_neg', 3);
model.study('std1').feature('lsqo').setIndex('initval', '100[S/m]', 3);
model.study('std1').feature('lsqo').setIndex('scale', 1, 3);
model.study('std1').feature('lsqo').setIndex('lbound', '', 3);
model.study('std1').feature('lsqo').setIndex('ubound', '', 3);
model.study('std1').feature('lsqo').setIndex('pname', 'i0_pos', 0);
model.study('std1').feature('lsqo').setIndex('initval', '1[A/m^2]', 0);
model.study('std1').feature('lsqo').setIndex('lbound', 1, 0);
model.study('std1').feature('lsqo').setIndex('ubound', 6, 0);
model.study('std1').feature('lsqo').setIndex('pname', 'Rfilm_pos', 1);
model.study('std1').feature('lsqo').setIndex('initval', '2.848e-3[m^2/S]', 1);
model.study('std1').feature('lsqo').setIndex('scale', '1e-4', 1);
model.study('std1').feature('lsqo').setIndex('lbound', '1e-6', 1);
model.study('std1').feature('lsqo').setIndex('ubound', '5e-3', 1);
model.study('std1').feature('lsqo').setIndex('pname', 'cdl_pos', 2);
model.study('std1').feature('lsqo').setIndex('initval', '0.2393[F/m^2]', 2);
model.study('std1').feature('lsqo').setIndex('lbound', '0.10', 2);
model.study('std1').feature('lsqo').setIndex('ubound', '0.90', 2);
model.study('std1').feature('lsqo').setIndex('pname', 'cdlvol_cs_pos', 3);
model.study('std1').feature('lsqo').setIndex('initval', '2.577e5[F/m^3]', 3);
model.study('std1').feature('lsqo').setIndex('scale', '1e5', 3);
model.study('std1').feature('lsqo').setIndex('lbound', '1e5', 3);
model.study('std1').feature('lsqo').setIndex('ubound', '1e6', 3);
model.study('std1').feature('lsqo').set('optsolver', 'ipopt');
model.study('std1').feature('lsqo').set('lsqdatamethod', 'lsq');

model.sol('sol1').study('std1');
model.sol('sol1').feature.remove('s1');
model.sol('sol1').feature.remove('v1');
model.sol('sol1').feature.remove('st1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'frlin');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').set('control', 'frlin');
model.sol('sol1').create('o1', 'Optimization');
model.sol('sol1').feature('o1').set('control', 'lsqo');
model.sol('sol1').feature('o1').create('s1', 'StationaryAttrib');
model.sol('sol1').feature('o1').feature('s1').set('stol', 1.0E-4);
model.sol('sol1').feature('o1').feature('s1').create('p1', 'Parametric');
model.sol('sol1').feature('o1').feature('s1').feature.remove('pDef');
model.sol('sol1').feature('o1').feature('s1').feature('p1').set('control', 'frlin');
model.sol('sol1').feature('o1').feature('s1').set('control', 'frlin');
model.sol('sol1').feature('o1').feature('s1').set('nonlin', 'linper');
model.sol('sol1').feature('o1').feature('s1').set('storelinpoint', true);
model.sol('sol1').feature('o1').feature('s1').set('linpsolnum', 'all');
model.sol('sol1').feature('o1').feature('s1').set('control', 'frlin');
model.sol('sol1').feature('o1').feature('s1').create('p2', 'Parametric');
model.sol('sol1').feature('o1').feature('s1').feature('p2').set('control', 'frlin');
model.sol('sol1').feature('o1').feature('s1').set('control', 'frlin');
model.sol('sol1').feature('o1').feature('s1').feature('p2').set('plistarrlsq', {'0.01, 0.028, 0.046, 0.064, 0.082, 0.1, 0.28, 0.46, 0.64, 0.82, 1.0, 2.8, 4.6, 6.4, 8.2, 10.0, 28.0, 46.0, 64.0, 82.0, 100.0, 280.0, 460.0, 640.0, 820.0, 1000.0'});
model.sol('sol1').feature('o1').feature('s1').feature('p2').set('lsqparamsout', ['      freq' newline '    0.0100' newline '    0.0280' newline '    0.0460' newline '    0.0640' newline '    0.0820' newline '     0.100' newline '     0.280' newline '     0.460' newline '     0.640' newline '     0.820' newline '      1.00' newline '      2.80' newline '      4.60' newline '      6.40' newline '      8.20' newline '      10.0' newline '      28.0' newline '      46.0' newline '      64.0' newline '      82.0' newline '       100' newline '       280' newline '       460' newline '       640' newline '       820' newline '  1.00e+03' newline ]);
model.sol('sol1').feature('o1').feature('s1').feature('p2').set('pnamelsq', {'freq'});
model.sol('sol1').feature('v1').set('cname', {});
model.sol('sol1').feature('v1').set('clist', {});
model.sol('sol1').feature('v1').set('clistctrl', {});
model.sol('sol1').feature('v1').set('cname', {'freq'});
model.sol('sol1').feature('v1').set('clist', {'0.01, 0.028, 0.046, 0.064, 0.082, 0.1, 0.28, 0.46, 0.64, 0.82, 1.0, 2.8, 4.6, 6.4, 8.2, 10.0, 28.0, 46.0, 64.0, 82.0, 100.0, 280.0, 460.0, 640.0, 820.0, 1000.0'});
model.sol('sol1').feature('v1').set('clistctrl', {'p2lsq'});
model.sol('sol1').feature('o1').feature('s1').feature('p1').active(false);
model.sol('sol1').feature('o1').feature('s1').set('control', 'frlin');
model.sol('sol1').feature('o1').feature('s1').feature('aDef').set('cachepattern', true);
model.sol('sol1').feature('o1').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('o1').feature('s1').feature('fc1').set('dtech', 'auto');
model.sol('sol1').feature('o1').feature('s1').create('d1', 'Direct');
model.sol('sol1').feature('o1').feature('s1').feature('d1').set('linsolver', 'pardiso');
model.sol('sol1').feature('o1').feature('s1').feature('d1').label('Direct (liion)');
model.sol('sol1').feature('o1').feature('s1').create('i1', 'Iterative');
model.sol('sol1').feature('o1').feature('s1').feature('i1').set('maxlinit', 1000);
model.sol('sol1').feature('o1').feature('s1').feature('i1').set('nlinnormuse', 'on');
model.sol('sol1').feature('o1').feature('s1').feature('i1').label('Algebraic Multigrid (liion)');
model.sol('sol1').feature('o1').feature('s1').feature('i1').create('mg1', 'Multigrid');
model.sol('sol1').feature('o1').feature('s1').feature('i1').feature('mg1').set('prefun', 'saamg');
model.sol('sol1').feature('o1').feature('s1').feature('i1').feature('mg1').set('maxcoarsedof', 50000);
model.sol('sol1').feature('o1').feature('s1').feature('i1').feature('mg1').set('saamgcompwise', true);
model.sol('sol1').feature('o1').feature('s1').feature('i1').feature('mg1').set('compactaggregation', true);
model.sol('sol1').feature('o1').feature('s1').feature('i1').feature('mg1').feature('pr').create('sl1', 'SORLine');
model.sol('sol1').feature('o1').feature('s1').feature('i1').feature('mg1').feature('po').create('sl1', 'SORLine');
model.sol('sol1').feature('o1').feature('s1').feature('i1').feature('mg1').feature('cs').create('d1', 'Direct');
model.sol('sol1').feature('o1').feature('s1').feature('i1').feature('mg1').feature('cs').feature('d1').set('linsolver', 'pardiso');
model.sol('sol1').feature('o1').feature('s1').create('i2', 'Iterative');
model.sol('sol1').feature('o1').feature('s1').feature('i2').set('maxlinit', 1000);
model.sol('sol1').feature('o1').feature('s1').feature('i2').set('nlinnormuse', 'on');
model.sol('sol1').feature('o1').feature('s1').feature('i2').label('Geometric Multigrid (liion)');
model.sol('sol1').feature('o1').feature('s1').feature('i2').create('mg1', 'Multigrid');
model.sol('sol1').feature('o1').feature('s1').feature('i2').feature('mg1').feature('pr').create('sl1', 'SORLine');
model.sol('sol1').feature('o1').feature('s1').feature('i2').feature('mg1').feature('po').create('sl1', 'SORLine');
model.sol('sol1').feature('o1').feature('s1').feature('i2').feature('mg1').feature('cs').create('d1', 'Direct');
model.sol('sol1').feature('o1').feature('s1').feature('i2').feature('mg1').feature('cs').feature('d1').set('linsolver', 'pardiso');
model.sol('sol1').feature('o1').feature('s1').feature('fc1').set('linsolver', 'd1');
model.sol('sol1').feature('o1').feature('s1').feature('fc1').set('dtech', 'auto');
model.sol('sol1').feature('o1').feature('s1').feature.remove('fcDef');
model.sol('sol1').attach('std1');
model.sol('sol1').feature('o1').set('gradientipopt', 'numeric');
model.sol('sol1').feature('o1').set('diffint', '5e-4');
model.sol('sol1').feature('o1').feature('s1').feature('aDef').set('nullfun', 'flnullorth');

model.probe('pdom1').genResult('none');

model.sol('sol1').runAll;

model.result('pg2').run;

model.study('std1').feature('lsqo').set('probewindow', '');

model.result.numerical.create('gev1', 'EvalGlobal');
model.result.numerical('gev1').set('evalmethod', 'lintotal');
model.result.numerical.create('gev2', 'EvalGlobal');
model.result.numerical('gev2').setIndex('looplevelinput', 'last', 0);
model.result.numerical('gev2').setIndex('expr', 'i0_pos', 0);
model.result.numerical('gev2').set('evalmethod', 'lintotalavg');
model.result.numerical.duplicate('gev3', 'gev2');
model.result.numerical('gev3').setIndex('expr', 'Rfilm_pos', 0);
model.result.numerical.duplicate('gev4', 'gev3');
model.result.numerical('gev4').setIndex('expr', 'cdl_pos', 0);
model.result.numerical('gev4').setIndex('descr', 'Double layer capacitance positive electrode', 0);
model.result.numerical.duplicate('gev5', 'gev4');
model.result.numerical('gev5').setIndex('expr', 'cdlvol_cs_pos', 0);
model.result.numerical('gev5').setIndex('descr', 'Volumetric capacitance positive electrode', 0);
model.result.numerical.duplicate('gev6', 'gev5');
model.result.numerical('gev6').setIndex('expr', 'D_pos', 0);
model.result.numerical('gev6').setIndex('descr', 'Control parameter D_pos', 0);
model.result.table.create('tbl4', 'Table');
model.result.table('tbl4').comments('Global Evaluation 1');
model.result.numerical('gev1').set('table', 'tbl4');
model.result.table('tbl4').label('Objective Function Value');
model.result.table.create('tbl5', 'Table');
model.result.table('tbl5').comments('Global Evaluation 2');
model.result.numerical('gev2').set('table', 'tbl5');
model.result.numerical('gev2').setResult;
model.result.table('tbl5').label('User-Set and Computed Parameter Values');
model.result.numerical('gev3').set('table', 'tbl5');
model.result.numerical('gev3').appendResult;
model.result.numerical('gev4').set('table', 'tbl5');
model.result.numerical('gev4').appendResult;
model.result.numerical('gev5').set('table', 'tbl5');
model.result.numerical('gev5').appendResult;
model.result.numerical('gev6').set('table', 'tbl5');
model.result.numerical('gev6').appendResult;
model.result.table.duplicate('tbl6', 'tbl2');
model.result.table('tbl6').label('Default Impedance Table');
model.result.create('pg5', 'PlotGroup1D');
model.result('pg5').run;
model.result('pg5').label('Nyquist Plot, Optimized');
model.result('pg5').set('xlabelactive', true);
model.result('pg5').set('xlabel', ['Real Impedance [' 'ohm' 'm<sup>2</sup>]']);
model.result('pg5').set('ylabelactive', true);
model.result('pg5').set('ylabel', ['Imaginary Impedance [' 'ohm' 'm<sup>2</sup>]']);
model.result('pg5').create('tblp1', 'Table');
model.result('pg5').feature('tblp1').set('markerpos', 'datapoints');
model.result('pg5').feature('tblp1').set('linewidth', 'preference');
model.result('pg5').feature('tblp1').set('table', 'tbl2');
model.result('pg5').feature('tblp1').set('xaxisdata', 2);
model.result('pg5').feature('tblp1').set('plotcolumninput', 'manual');
model.result('pg5').feature('tblp1').set('plotcolumns', [3]);
model.result('pg5').feature('tblp1').set('linestyle', 'none');
model.result('pg5').feature('tblp1').set('linecolor', 'red');
model.result('pg5').feature('tblp1').set('linemarker', 'circle');
model.result('pg5').run;
model.result('pg5').create('ptgr1', 'PointGraph');
model.result('pg5').feature('ptgr1').set('markerpos', 'datapoints');
model.result('pg5').feature('ptgr1').set('linewidth', 'preference');
model.result('pg5').feature('ptgr1').selection.set([4]);
model.result('pg5').feature('ptgr1').set('expr', '-imag(Z_ref_NCA)');
model.result('pg5').feature('ptgr1').set('evalmethod', 'linpoint');
model.result('pg5').feature('ptgr1').set('xdata', 'expr');
model.result('pg5').feature('ptgr1').set('xdataexpr', 'real(Z_ref_NCA)');
model.result('pg5').feature('ptgr1').set('xdataevalmethod', 'linpoint');
model.result('pg5').feature('ptgr1').set('linecolor', 'blue');
model.result('pg5').run;
model.result.create('pg6', 'PlotGroup1D');
model.result('pg6').run;
model.result('pg6').label('Nyquist Plot, Experimental');
model.result('pg6').set('xlabelactive', true);
model.result('pg6').set('xlabel', ['Real Impedance [' 'ohm' 'm<sup>2</sup>]']);
model.result('pg6').set('ylabelactive', true);
model.result('pg6').set('ylabel', ['Imaginary Impedance [' 'ohm' 'm<sup>2</sup>]']);
model.result('pg6').create('tblp1', 'Table');
model.result('pg6').feature('tblp1').set('markerpos', 'datapoints');
model.result('pg6').feature('tblp1').set('linewidth', 'preference');
model.result('pg6').feature('tblp1').set('table', 'tbl2');
model.result('pg6').feature('tblp1').set('xaxisdata', 2);
model.result('pg6').feature('tblp1').set('plotcolumninput', 'manual');
model.result('pg6').feature('tblp1').set('plotcolumns', [3]);
model.result('pg6').feature('tblp1').set('linestyle', 'none');
model.result('pg6').feature('tblp1').set('linecolor', 'red');
model.result('pg6').feature('tblp1').set('linemarker', 'circle');
model.result('pg6').run;
model.result.create('pg7', 'PlotGroup1D');
model.result('pg7').run;
model.result('pg7').label('Bode Plot, NCA vs. Reference');
model.result('pg7').set('titletype', 'none');
model.result('pg7').set('xlabelactive', true);
model.result('pg7').set('xlabel', 'Frequency (Hz)');
model.result('pg7').set('ylabelactive', true);
model.result('pg7').set('ylabel', ['Impedance [' 'ohm' 'm<sup>2</sup>]']);
model.result('pg7').set('xlog', true);
model.result('pg7').set('ylog', true);
model.result('pg7').create('ptgr1', 'PointGraph');
model.result('pg7').feature('ptgr1').set('markerpos', 'datapoints');
model.result('pg7').feature('ptgr1').set('linewidth', 'preference');
model.result('pg7').feature('ptgr1').selection.set([4]);
model.result('pg7').feature('ptgr1').set('expr', 'Z_ref_NCA');
model.result('pg7').feature('ptgr1').set('evalmethod', 'linpoint');
model.result('pg7').feature('ptgr1').set('xdata', 'expr');
model.result('pg7').feature('ptgr1').set('xdataexpr', 'freq');
model.result('pg7').run;
model.result('pg7').create('tblp1', 'Table');
model.result('pg7').feature('tblp1').set('markerpos', 'datapoints');
model.result('pg7').feature('tblp1').set('linewidth', 'preference');
model.result('pg7').feature('tblp1').set('table', 'tbl2');
model.result('pg7').feature('tblp1').set('xaxisdata', 1);
model.result('pg7').feature('tblp1').set('plotcolumninput', 'manual');
model.result('pg7').feature('tblp1').set('plotcolumns', [4]);
model.result('pg7').feature('tblp1').set('linestyle', 'none');
model.result('pg7').feature('tblp1').set('linecolor', 'red');
model.result('pg7').feature('tblp1').set('linemarker', 'circle');
model.result('pg7').run;
model.result.create('pg8', 'PlotGroup1D');
model.result('pg8').run;
model.result('pg8').label('Bode Plot, NCA vs. Reference, Experimental');
model.result('pg8').set('titletype', 'none');
model.result('pg8').set('xlabelactive', true);
model.result('pg8').set('xlabel', 'Frequency (Hz)');
model.result('pg8').set('ylabelactive', true);
model.result('pg8').set('ylabel', ['Impedance [' 'ohm' 'm<sup>2</sup>]']);
model.result('pg8').set('xlog', true);
model.result('pg8').set('ylog', true);
model.result('pg8').create('tblp1', 'Table');
model.result('pg8').feature('tblp1').set('markerpos', 'datapoints');
model.result('pg8').feature('tblp1').set('linewidth', 'preference');
model.result('pg8').feature('tblp1').set('table', 'tbl2');
model.result('pg8').feature('tblp1').set('xaxisdata', 1);
model.result('pg8').feature('tblp1').set('plotcolumninput', 'manual');
model.result('pg8').feature('tblp1').set('plotcolumns', [4]);
model.result('pg8').feature('tblp1').set('linestyle', 'none');
model.result('pg8').feature('tblp1').set('linecolor', 'red');
model.result('pg8').feature('tblp1').set('linemarker', 'circle');
model.result('pg8').run;

model.title([]);

model.description('');

model.label('li_ion_battery_impedance_embedded.mph');

model.result('pg8').run;

model.setExpectedComputationTime('52 seconds');

model.result.report.create('rpt1', 'Report');
model.result.report('rpt1').set('format', 'docx');
model.result.report('rpt1').set('filename', 'user:///Li-Ion_Battery_Impedance.docx');
model.result.report('rpt1').set('imagesize', 'large');
model.result.report('rpt1').feature.create('tp1', 'TitlePage');
model.result.report('rpt1').feature('tp1').set('title', 'Lithium Ion Battery Impedance and Parameter Estimation');
model.result.report('rpt1').feature('tp1').set('titleimage', 'none');
model.result.report('rpt1').feature('tp1').set('reportdate', 'custom');
model.result.report('rpt1').feature('tp1').set('date', 'Date Here');
model.result.report('rpt1').feature('tp1').set('includecompany', false);
model.result.report('rpt1').feature('tp1').set('includeversion', false);
model.result.report('rpt1').feature('tp1').set('summary', ['This application of a lithium-ion battery describes the impedance in a LTO/NCA cell with a reference electrode. The application incorporates an Optimization interface with global least-squares objective to fit the simulations to experimental measurements.' newline  newline 'The application requires the Batteries & Fuel Cells Module and the Optimization Module.']);
model.result.report('rpt1').feature.create('toc1', 'TableOfContents');
model.result.report('rpt1').feature.create('sec1', 'Section');
model.result.report('rpt1').feature('sec1').label('Software Information');
model.result.report('rpt1').feature('sec1').feature.create('root1', 'Model');
model.result.report('rpt1').feature('sec1').feature('root1').label('Software Properties from Root');
model.result.report('rpt1').feature('sec1').feature('root1').set('includepath', false);
model.result.report('rpt1').feature('sec1').feature.create('std1', 'Study');
model.result.report('rpt1').feature('sec1').feature('std1').setIndex('children', false, 0, 1);
model.result.report('rpt1').feature('sec1').feature('std1').setIndex('children', false, 1, 1);
model.result.report('rpt1').feature.create('sec2', 'Section');
model.result.report('rpt1').feature('sec2').label('Input Data');
model.result.report('rpt1').feature('sec2').feature.create('param1', 'Parameter');
model.result.report('rpt1').feature('sec2').feature.create('mtbl1', 'Table');
model.result.report('rpt1').feature('sec2').feature('mtbl1').set('noderef', 'tbl2');
model.result.report('rpt1').feature.create('sec3', 'Section');
model.result.report('rpt1').feature('sec3').label('Results');
model.result.report('rpt1').feature('sec3').feature.create('pg1', 'PlotGroup');
model.result.report('rpt1').feature('sec3').feature('pg1').label('Nyquist Plot with Computed Parameters');
model.result.report('rpt1').feature('sec3').feature('pg1').set('noderef', 'pg5');
model.result.report('rpt1').feature('sec3').feature.duplicate('pg2', 'pg1');
model.result.report('rpt1').feature('sec3').feature('pg2').label('Bode Plot with Computed Parameters');
model.result.report('rpt1').feature('sec3').feature('pg2').set('noderef', 'pg7');
model.result.report('rpt1').feature('sec3').feature.create('mtbl1', 'Table');
model.result.report('rpt1').feature('sec3').feature('mtbl1').label('User-Set and Computed Parameter Values');
model.result.report('rpt1').feature('sec3').feature('mtbl1').set('noderef', 'tbl5');
model.result.report('rpt1').feature('sec2').feature('param1').label('Parameters, Embedded Model');
model.result.report('rpt1').feature('sec2').feature('mtbl1').label('Experimental Data');

model.title('Lithium-Ion Battery Impedance');

model.description(['The goal with this app is to explain experimental electrochemical impedance spectroscopy (EIS) measurements and to show how you can use a simulation app, along with measurements, to estimate the properties of lithium-ion batteries.' newline  newline 'The app takes measurements from an EIS experiment and uses them as inputs. It then simulates these measurements and runs a parameter estimation based on the experimental data.' newline  newline 'The control parameters are: the exchange current density, the resistivity of the solid electrolyte interface on the particles, the double-layer capacitance of NCA, the double-layer capacitance of the carbon support in the positive electrode, and the diffusivity of the lithium ion in the positive electrode. Fitting is done to the measured impedance of the positive electrode at frequencies ranging from 10' native2unicode(hex2dec({'00' 'a0'}), 'unicode') 'mHz to 1' native2unicode(hex2dec({'00' 'a0'}), 'unicode') 'kHz.']);

model.mesh.clearMeshes;

model.sol('sol1').clearSolutionData;

model.label('li_ion_battery_impedance.mph');

model.modelNode.label('Components');

out = model;
