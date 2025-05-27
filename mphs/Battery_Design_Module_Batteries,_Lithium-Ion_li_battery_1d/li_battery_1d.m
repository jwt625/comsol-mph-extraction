function out = model
%
% li_battery_1d.m
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
model.param.set('i_1C', '17.5[A/m^2]', '1C discharge current');
model.param.set('Ds_neg', '3.9e-14[m^2/s]', 'Solid phase Li-diffusivity negative electrode');
model.param.set('Ds_pos', '1e-13[m^2/s]', 'Solid phase Li-diffusivity positive electrode');
model.param.set('rp_neg', '12.5e-6[m]', 'Particle radius negative electrode');
model.param.set('rp_pos', '8e-6[m]', 'Particle radius positive electrode');
model.param.set('T', '298[K]', 'Temperature');
model.param.set('epsl_pos', '0.63', 'Electrolyte phase volume fraction, positive electrode');
model.param.set('epss_pos', '1-epsl_pos-epss_filler_pos', 'Electrode phase volume fraction, positive electrode');
model.param.set('epss_filler_pos', '0.073', 'Conductive filler phase volume fraction, positive electrode');
model.param.set('cl_0', '2000[mol/m^3]', 'Initial electrolyte salt concentration');
model.param.set('epsl_neg', '0.503', 'Electrolyte phase volume fraction, negative electrode');
model.param.set('epss_filler_neg', '0.026', 'Conductive filler phase volume fraction, negative');
model.param.set('epss_neg', '1-epsl_neg-epss_filler_neg', 'Solid phase vol-fraction negative electrode');
model.param.set('csmax_neg', '26390[mol/m^3]', 'Max solid phase concentration, negative electrode');
model.param.set('csmax_pos', '22860[mol/m^3]', 'Max solid phase concentration, positive electrode');
model.param.set('cs0_neg', '14870[mol/m^3]', 'Initial concentration negative active electrode material');
model.param.set('cs0_pos', '3900[mol/m^3]', 'Initial concentration positive active electrode material');
model.param.set('Ks_neg', '100[S/m]', 'Solid phase conductivity negative electrode');
model.param.set('Ks_pos', '100[S/m]', 'Solid phase conductivity positive electrode');
model.param.set('i0_neg_ref', '0.11[mA/cm^2]', 'Exchange current density at reference conditions, negative electrode');
model.param.set('i0_pos_ref', '0.08[mA/cm^2]', 'Exchange current density at reference conditions, positive electrode');
model.param.set('cl_ref', '2000[mol/m^3]', 'Reference electrolyte salt concentration');
model.param.set('cs_neg_ref', '14870[mol/m^3]', 'Reference concentration negative active electrode material');
model.param.set('cs_pos_ref', '3900[mol/m^3]', 'Reference concentration negative active electrode material');
model.param.set('k_neg', 'i0_neg_ref/(F_const*(cs_neg_ref[m^3/mol])^0.5*((csmax_neg-cs_neg_ref)[m^3/mol])^0.5)[mol/m^3]', 'Rate constant, negative electrode');
model.param.set('k_pos', 'i0_pos_ref/(F_const*(cs_pos_ref[m^3/mol])^0.5*((csmax_pos-cs_pos_ref)[m^3/mol])^0.5)[mol/m^3]', 'Rate constant, positive electrode');
model.param.set('brugg', '3.3', 'Bruggeman coefficient');
model.param.set('t_disch_stop', '2000[s]', 'Discharge duration');
model.param.set('t_ocp', '300[s]', 'Open circuit duration');
model.param.set('t_charge_stop', '2000[s]', 'Charge duration');
model.param.set('L_neg', '100e-6[m]', 'Length of negative electrode');
model.param.set('L_sep', '52e-6[m]', 'Length of separator');
model.param.set('L_pos', '174e-6[m]', 'Length of positive electrode');

model.geom('geom1').create('i1', 'Interval');
model.geom('geom1').feature('i1').set('specify', 'len');
model.geom('geom1').feature('i1').setIndex('len', 'L_neg', 0);
model.geom('geom1').feature('i1').setIndex('len', 'L_sep', 1);
model.geom('geom1').feature('i1').setIndex('len', 'L_pos', 2);
model.geom('geom1').run('i1');

model.func.create('int1', 'Interpolation');
model.func('int1').set('source', 'file');
model.func('int1').set('filename', 'li_battery_1d_Eeq_neg.txt');
model.func('int1').importData;
model.func('int1').set('funcname', 'Eeq_neg');
model.func('int1').set('interp', 'cubicspline');
model.func('int1').set('extrap', 'interior');
model.func('int1').setIndex('fununit', 'V', 0);
model.func.create('pw1', 'Piecewise');
model.func('pw1').set('arg', 't');
model.func('pw1').set('smooth', 'contd2');
model.func('pw1').set('zonelengthtype', 'absolute');
model.func('pw1').set('smoothzone', 10);
model.func('pw1').set('pieces', {'0' 't_disch_stop' '1';  ...
't_disch_stop' 't_disch_stop+t_ocp' '0';  ...
't_disch_stop+t_ocp' 't_charge_stop+t_disch_stop+t_ocp' '-1';  ...
't_charge_stop+t_disch_stop+t_ocp' '8000' '    0'});
model.func('pw1').set('argunit', 's');
model.func('pw1').set('fununit', '1');

model.variable.create('var1');
model.variable('var1').model('comp1');

model.geom('geom1').run;

model.variable('var1').label('Variables (Positive Current Collector)');
model.variable('var1').selection.geom('geom1', 0);
model.variable('var1').selection.set([4]);
model.variable('var1').set('i_app', 'pw1(t)*i_1C');
model.variable('var1').descr('i_app', 'Applied battery cell current density');

model.material.create('mat1', 'Common', 'comp1');
model.material('mat1').propertyGroup.create('ElectrodePotential', 'Equilibrium potential');
model.material('mat1').propertyGroup('ElectrodePotential').func.create('int1', 'Interpolation');
model.material('mat1').propertyGroup('ElectrodePotential').func.create('int2', 'Interpolation');
model.material('mat1').propertyGroup.create('OperationalSOC', 'Operational electrode state of charge');
model.material('mat1').propertyGroup.create('EquilibriumConcentration', 'Equilibrium concentration');
model.material('mat1').label('LMO, LiMn2O4 Spinel (Positive, Li-ion Battery)');
model.material('mat1').propertyGroup('def').set('youngsmodulus', '');
model.material('mat1').propertyGroup('def').set('poissonsratio', '');
model.material('mat1').propertyGroup('def').set('youngsmodulus', '194[GPa]');
model.material('mat1').propertyGroup('def').set('INFO_PREFIX:youngsmodulus', 'Yue Qi et al 2014 J. Electrochem. Soc. 161 F3010');
model.material('mat1').propertyGroup('def').set('poissonsratio', '0.26');
model.material('mat1').propertyGroup('def').set('INFO_PREFIX:poissonsratio', 'Yue Qi et al 2014 J. Electrochem. Soc. 161 F3010');
model.material('mat1').propertyGroup('def').set('electricconductivity', {'3.8[S/m]' '0' '0' '0' '3.8[S/m]' '0' '0' '0' '3.8[S/m]'});
model.material('mat1').propertyGroup('def').set('INFO_PREFIX:electricconductivity', 'V. Srinivasan and C.Y. Wang, "Analysis of Electrochemical and Thermal Behavior of Li-Ion Cells," J. Electrochem. Soc., vol. 150, p. A98, 2003');
model.material('mat1').propertyGroup('def').set('diffusion', {'1e-14*exp(20000/8.314*(1/(T_ref/1[K])-1/(T2/1[K])))[m^2/s]' '0' '0' '0' '1e-14*exp(20000/8.314*(1/(T_ref/1[K])-1/(T2/1[K])))[m^2/s]' '0' '0' '0' '1e-14*exp(20000/8.314*(1/(T_ref/1[K])-1/(T2/1[K])))[m^2/s]'});
model.material('mat1').propertyGroup('def').set('INFO_PREFIX:diffusion', 'V. Srinivasan and C.Y. Wang, "Analysis of Electrochemical and Thermal Behavior of Li-Ion Cells," J. Electrochem. Soc., vol. 150, p. A98, 2003');
model.material('mat1').propertyGroup('def').set('density', '4140[kg/m^3]');
model.material('mat1').propertyGroup('def').set('INFO_PREFIX:density', 'N. Nitta, F. Wu, J. Tae Lee, and G. Yushin, Materials Today, Volume 18, Number 5, June 2015');
model.material('mat1').propertyGroup('def').set('T_ref', '298[K]');
model.material('mat1').propertyGroup('def').descr('T_ref', '');
model.material('mat1').propertyGroup('def').set('T2', 'min(393.15,max(T,223.15))');
model.material('mat1').propertyGroup('def').descr('T2', '');
model.material('mat1').propertyGroup('def').set('csmax', '22860[mol/m^3]');
model.material('mat1').propertyGroup('def').descr('csmax', '');
model.material('mat1').propertyGroup('def').addInput('temperature');
model.material('mat1').propertyGroup('ElectrodePotential').func('int1').set('funcname', 'Eeq_int1');
model.material('mat1').propertyGroup('ElectrodePotential').func('int1').set('table', {'0.1750' '4.2763';  ...
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
model.material('mat1').propertyGroup('ElectrodePotential').func('int1').set('interp', 'piecewisecubic');
model.material('mat1').propertyGroup('ElectrodePotential').func('int1').set('extrap', 'linear');
model.material('mat1').propertyGroup('ElectrodePotential').func('int1').set('fununit', {'V'});
model.material('mat1').propertyGroup('ElectrodePotential').func('int1').set('argunit', {''});
model.material('mat1').propertyGroup('ElectrodePotential').func('int1').set('defineinv', true);
model.material('mat1').propertyGroup('ElectrodePotential').func('int1').set('funcinvname', 'Eeq_inv');
model.material('mat1').propertyGroup('ElectrodePotential').func('int2').set('funcname', 'dEeqdT_int1');
model.material('mat1').propertyGroup('ElectrodePotential').func('int2').set('table', {'0.15' '0.15e-3';  ...
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
model.material('mat1').propertyGroup('ElectrodePotential').func('int2').set('interp', 'piecewisecubic');
model.material('mat1').propertyGroup('ElectrodePotential').func('int2').set('fununit', {'V/K'});
model.material('mat1').propertyGroup('ElectrodePotential').func('int2').set('argunit', {''});
model.material('mat1').propertyGroup('ElectrodePotential').set('Eeq', 'Eeq_int1(soc)+dEeqdT_int1(soc)*(T-298[K])');
model.material('mat1').propertyGroup('ElectrodePotential').set('INFO_PREFIX:Eeq', 'V. Srinivasan and C.Y. Wang, "Analysis of Electrochemical and Thermal Behavior of Li-Ion Cells," J. Electrochem. Soc., vol. 150, p. A98, 2003');
model.material('mat1').propertyGroup('ElectrodePotential').set('dEeqdT', 'dEeqdT_int1(soc)');
model.material('mat1').propertyGroup('ElectrodePotential').set('INFO_PREFIX:dEeqdT', 'V. Srinivasan and C.Y. Wang, "Analysis of Electrochemical and Thermal Behavior of Li-Ion Cells," J. Electrochem. Soc., vol. 150, p. A98, 2003');
model.material('mat1').propertyGroup('ElectrodePotential').set('cEeqref', 'def.csmax');
model.material('mat1').propertyGroup('ElectrodePotential').set('INFO_PREFIX:cEeqref', 'V. Srinivasan and C.Y. Wang, "Analysis of Electrochemical and Thermal Behavior of Li-Ion Cells," J. Electrochem. Soc., vol. 150, p. A98, 2003');
model.material('mat1').propertyGroup('ElectrodePotential').set('soc', 'c/cEeqref');
model.material('mat1').propertyGroup('ElectrodePotential').descr('soc', '');
model.material('mat1').propertyGroup('ElectrodePotential').addInput('concentration');
model.material('mat1').propertyGroup('ElectrodePotential').addInput('temperature');
model.material('mat1').propertyGroup('OperationalSOC').set('socmax', 'elpot.Eeq_inv(E_min)');
model.material('mat1').propertyGroup('OperationalSOC').set('socmin', 'elpot.Eeq_inv(E_max)');
model.material('mat1').propertyGroup('OperationalSOC').set('E_max', '4.2[V]');
model.material('mat1').propertyGroup('OperationalSOC').set('E_min', '3.9[V]');
model.material('mat1').propertyGroup('EquilibriumConcentration').set('csEq', 'def.csmax*elpot.Eeq_inv(V)');
model.material('mat1').propertyGroup('EquilibriumConcentration').addInput('electricpotential');
model.material('mat1').selection.set([3]);
model.material.create('mat2', 'Common', 'comp1');
model.material('mat2').propertyGroup.create('ElectrolyteConductivity', 'Electrolyte conductivity');
model.material('mat2').propertyGroup('ElectrolyteConductivity').func.create('int1', 'Interpolation');
model.material('mat2').propertyGroup.create('SpeciesProperties', 'Species properties');
model.material('mat2').propertyGroup.create('ElectrolyteSaltConcentration', 'Electrolyte salt concentration');
model.material('mat2').label('LiPF6 in 1:2 EC:DMC and p(VdF-HFP) (Polymer, Li-ion Battery)');
model.material('mat2').comments([ newline ]);
model.material('mat2').propertyGroup('def').set('diffusion', {'7.5e-11[m^2/s]' '0' '0' '0' '7.5e-11[m^2/s]' '0' '0' '0' '7.5e-11[m^2/s]'});
model.material('mat2').propertyGroup('def').set('INFO_PREFIX:diffusion', ['M. Doyle, J. Newman, A.S. Gozdz, C.N. Schmutz, and J.M. Tarascon, ' native2unicode(hex2dec({'20' '1c'}), 'unicode') 'Comparison of Modeling Predictions with Experimental Data from Plastic Lithium Ion Cells,' native2unicode(hex2dec({'20' '1d'}), 'unicode') ' J. Electrochem. Soc., vol. 143, p. 1890, 1996.' newline ]);
model.material('mat2').propertyGroup('ElectrolyteConductivity').func('int1').set('funcname', 'sigmal_int1');
model.material('mat2').propertyGroup('ElectrolyteConductivity').func('int1').set('table', {'0' '0.0108';  ...
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
model.material('mat2').propertyGroup('ElectrolyteConductivity').func('int1').set('fununit', {''});
model.material('mat2').propertyGroup('ElectrolyteConductivity').func('int1').set('argunit', {''});
model.material('mat2').propertyGroup('ElectrolyteConductivity').set('sigmal', {'sigmal_int1(c/c_ref)' '0' '0' '0' 'sigmal_int1(c/c_ref)' '0' '0' '0' 'sigmal_int1(c/c_ref)'});
model.material('mat2').propertyGroup('ElectrolyteConductivity').set('INFO_PREFIX:sigmal', ['M. Doyle, J. Newman, A.S. Gozdz, C.N. Schmutz, and J.M. Tarascon, ' native2unicode(hex2dec({'20' '1c'}), 'unicode') 'Comparison of Modeling Predictions with Experimental Data from Plastic Lithium Ion Cells,' native2unicode(hex2dec({'20' '1d'}), 'unicode') ' J. Electrochem. Soc., vol. 143, p. 1890, 1996.' newline ]);
model.material('mat2').propertyGroup('ElectrolyteConductivity').set('c_ref', '1000[mol/m^3]');
model.material('mat2').propertyGroup('ElectrolyteConductivity').descr('c_ref', '');
model.material('mat2').propertyGroup('ElectrolyteConductivity').addInput('concentration');
model.material('mat2').propertyGroup('SpeciesProperties').set('transpNum', '0.363');
model.material('mat2').propertyGroup('SpeciesProperties').set('INFO_PREFIX:transpNum', ['M. Doyle, J. Newman, A.S. Gozdz, C.N. Schmutz, and J.M. Tarascon, ' native2unicode(hex2dec({'20' '1c'}), 'unicode') 'Comparison of Modeling Predictions with Experimental Data from Plastic Lithium Ion Cells,' native2unicode(hex2dec({'20' '1d'}), 'unicode') ' J. Electrochem. Soc., vol. 143, p. 1890, 1996.' newline ]);
model.material('mat2').propertyGroup('SpeciesProperties').set('fcl', '0');
model.material('mat2').propertyGroup('SpeciesProperties').set('INFO_PREFIX:fcl', ['M. Doyle, J. Newman, A.S. Gozdz, C.N. Schmutz, and J.M. Tarascon, ' native2unicode(hex2dec({'20' '1c'}), 'unicode') 'Comparison of Modeling Predictions with Experimental Data from Plastic Lithium Ion Cells,' native2unicode(hex2dec({'20' '1d'}), 'unicode') ' J. Electrochem. Soc., vol. 143, p. 1890, 1996.' newline ]);
model.material('mat2').propertyGroup('ElectrolyteSaltConcentration').identifier('cElsalt');
model.material('mat2').propertyGroup('ElectrolyteSaltConcentration').set('cElsalt', '1000[mol/m^3]');
model.material('mat2').propertyGroup('ElectrolyteSaltConcentration').set('INFO_PREFIX:cElsalt', ['M. Doyle, J. Newman, A.S. Gozdz, C.N. Schmutz, and J.M. Tarascon, ' native2unicode(hex2dec({'20' '1c'}), 'unicode') 'Comparison of Modeling Predictions with Experimental Data from Plastic Lithium Ion Cells,' native2unicode(hex2dec({'20' '1d'}), 'unicode') ' J. Electrochem. Soc., vol. 143, p. 1890, 1996.' newline ]);
model.material('mat2').selection.set([1 2 3]);

model.physics('liion').feature('sep1').set('epsl', 1);
model.physics('liion').create('pce1', 'PorousElectrode', 1);
model.physics('liion').feature('pce1').selection.set([1]);
model.physics('liion').feature('pce1').set('sigma', {'Ks_neg' '0' '0' '0' 'Ks_neg' '0' '0' '0' 'Ks_neg'});
model.physics('liion').feature('pce1').set('epsl', 'epsl_neg');
model.physics('liion').feature('pce1').set('epss', 'epss_neg');
model.physics('liion').feature('pce1').set('IonicCorrModel', 'userdef');
model.physics('liion').feature('pce1').set('fl', 'epsl_neg^brugg');
model.physics('liion').feature('pce1').set('ElectricCorrModel', 'NoCorr');
model.physics('liion').feature('pce1').set('DiffusionCorrModel', 'userdef');
model.physics('liion').feature('pce1').set('fDl', 'epsl_neg^brugg');
model.physics('liion').feature('pce1').feature('pin1').set('csinit', 'cs0_neg');
model.physics('liion').feature('pce1').feature('pin1').set('cEeqref_mat', 'userdef');
model.physics('liion').feature('pce1').feature('pin1').set('cEeqref', 'csmax_neg');
model.physics('liion').feature('pce1').feature('pin1').set('Ds_mat', 'userdef');
model.physics('liion').feature('pce1').feature('pin1').set('Ds', 'Ds_neg');
model.physics('liion').feature('pce1').feature('pin1').set('rp', 'rp_neg');
model.physics('liion').feature('pce1').feature('pin1').set('socmin_mat', 'userdef');
model.physics('liion').feature('pce1').feature('pin1').set('socmax_mat', 'userdef');
model.physics('liion').feature('pce1').feature('per1').set('Eeq_mat', 'userdef');
model.physics('liion').feature('pce1').feature('per1').set('Eeq', 'Eeq_neg(liion.cs_surface/csmax_neg)');
model.physics('liion').feature('pce1').feature('per1').set('i0refType', 'FromRateConstant');
model.physics('liion').feature('pce1').feature('per1').set('k', 'k_neg');
model.physics('liion').feature('pce1').feature('per1').set('cl_ref', 'cl_ref');
model.physics('liion').feature('pce1').feature('per1').set('dEeqdT_mat', 'userdef');
model.physics('liion').create('pce2', 'PorousElectrode', 1);
model.physics('liion').feature('pce2').selection.set([3]);
model.physics('liion').feature('pce2').set('sigma', {'Ks_pos' '0' '0' '0' 'Ks_pos' '0' '0' '0' 'Ks_pos'});
model.physics('liion').feature('pce2').set('epsl', 'epsl_pos');
model.physics('liion').feature('pce2').set('epss', 'epss_pos');
model.physics('liion').feature('pce2').set('IonicCorrModel', 'userdef');
model.physics('liion').feature('pce2').set('fl', 'epsl_pos^brugg');
model.physics('liion').feature('pce2').set('ElectricCorrModel', 'NoCorr');
model.physics('liion').feature('pce2').set('DiffusionCorrModel', 'userdef');
model.physics('liion').feature('pce2').set('fDl', 'epsl_pos^brugg');
model.physics('liion').feature('pce2').feature('pin1').set('ParticleMaterial', 'mat1');
model.physics('liion').feature('pce2').feature('pin1').set('csinit', 'cs0_pos');
model.physics('liion').feature('pce2').feature('pin1').set('Ds_mat', 'userdef');
model.physics('liion').feature('pce2').feature('pin1').set('Ds', 'Ds_pos');
model.physics('liion').feature('pce2').feature('pin1').set('rp', 'rp_pos');
model.physics('liion').feature('pce2').feature('pin1').set('Nord', 2);
model.physics('liion').feature('pce2').feature('per1').set('MaterialOption', 'mat1');
model.physics('liion').feature('pce2').feature('per1').set('i0refType', 'FromRateConstant');
model.physics('liion').feature('pce2').feature('per1').set('k', 'k_pos');
model.physics('liion').feature('pce2').feature('per1').set('cl_ref', 'cl_ref');
model.physics('liion').create('egnd1', 'ElectricGround', 0);
model.physics('liion').feature('egnd1').selection.set([1]);
model.physics('liion').create('ecd1', 'ElectrodeNormalCurrentDensity', 0);
model.physics('liion').feature('ecd1').selection.set([4]);
model.physics('liion').feature('ecd1').set('nis', '-i_app');
model.physics('liion').feature('init1').set('cl', 'cl_0');

model.common('cminpt').set('modified', {'temperature' 'T'});

model.study('std1').feature('time').set('tlist', 'range(0,10,8000)');

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
model.sol('sol1').feature('t1').set('tlist', 'range(0,10,8000)');
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
model.sol('sol1').runAll;

model.result.create('pg1', 'PlotGroup1D');
model.result('pg1').set('data', 'dset1');
model.result('pg1').create('ptgr1', 'PointGraph');
model.result('pg1').feature('ptgr1').selection.all;
model.result('pg1').feature('ptgr1').set('expr', {'phis'});
model.result('pg1').feature('ptgr1').selection.set([4]);
model.result('pg1').label('Boundary Electrode Potential with Respect to Ground (liion)');
model.result('pg1').feature('ptgr1').set('xdatasolnumtype', 'level1');
model.result.create('pg2', 'PlotGroup1D');
model.result('pg2').set('data', 'dset1');
model.result('pg2').create('glob1', 'Global');
model.result('pg2').feature('glob1').set('unit', {'' ''});
model.result('pg2').feature('glob1').set('expr', {'liion.soc_average_pce1' 'liion.soc_average_pce2'});
model.result('pg2').feature('glob1').set('descr', {'Average SOC, Porous Electrode 1' 'Average SOC, Porous Electrode 2'});
model.result('pg2').label('Average Electrode State of Charge (liion)');
model.result('pg2').feature('glob1').set('xdatasolnumtype', 'level1');
model.result.create('pg3', 'PlotGroup1D');
model.result('pg3').set('data', 'dset1');
model.result('pg3').label('Electrolyte Potential (liion)');
model.result('pg3').create('lngr1', 'LineGraph');
model.result('pg3').feature('lngr1').set('xdata', 'expr');
model.result('pg3').feature('lngr1').set('xdataexpr', 'x');
model.result('pg3').feature('lngr1').selection.geom('geom1', 1);
model.result('pg3').feature('lngr1').selection.set([1 2 3]);
model.result('pg3').feature('lngr1').set('expr', {'phil'});
model.result.create('pg4', 'PlotGroup1D');
model.result('pg4').set('data', 'dset1');
model.result('pg4').label('Electrode Potential with Respect to Ground (liion)');
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
model.result('pg5').label('Electrolyte Salt Concentration (liion)');
model.result('pg1').run;
model.result('pg1').run;
model.result('pg1').set('titletype', 'none');
model.result('pg1').set('ylabelactive', true);
model.result('pg1').set('ylabel', 'Cell voltage (V)');
model.result('pg1').set('twoyaxes', true);
model.result('pg1').set('legendpos', 'lowerright');
model.result('pg1').run;
model.result('pg1').feature('ptgr1').set('legend', true);
model.result('pg1').feature('ptgr1').set('legendmethod', 'manual');
model.result('pg1').feature('ptgr1').setIndex('legends', 'Voltage', 0);
model.result('pg1').feature.duplicate('ptgr2', 'ptgr1');
model.result('pg1').run;
model.result('pg1').feature('ptgr2').set('expr', 'i_app');
model.result('pg1').feature('ptgr2').set('descr', 'Applied battery cell current density');
model.result('pg1').feature('ptgr2').set('plotonsecyaxis', true);
model.result('pg1').feature('ptgr2').setIndex('legends', 'Current', 0);
model.result('pg1').run;
model.result.create('pg6', 'PlotGroup1D');
model.result('pg6').run;
model.result('pg6').set('data', 'none');
model.result('pg6').create('lngr1', 'LineGraph');
model.result('pg6').feature('lngr1').set('markerpos', 'datapoints');
model.result('pg6').feature('lngr1').set('linewidth', 'preference');
model.result('pg6').feature('lngr1').set('data', 'dset1');
model.result('pg6').feature('lngr1').setIndex('looplevelinput', 'manual', 0);
model.result('pg6').feature('lngr1').setIndex('looplevel', [2], 0);
model.result('pg6').feature('lngr1').selection.all;
model.result('pg6').feature('lngr1').set('expr', 'phil+0.148');
model.result('pg6').feature('lngr1').set('legend', true);
model.result('pg6').feature('lngr1').set('legendmethod', 'manual');
model.result('pg6').feature('lngr1').setIndex('legends', 'phil+0.148', 0);
model.result('pg6').feature.duplicate('lngr2', 'lngr1');
model.result('pg6').run;
model.result('pg6').feature('lngr2').set('expr', 'liion.eta_per1');
model.result('pg6').feature('lngr2').setIndex('legends', 'eta', 0);
model.result('pg6').feature.duplicate('lngr3', 'lngr2');
model.result('pg6').run;
model.result('pg6').feature('lngr3').setIndex('looplevel', [200], 0);
model.result('pg6').feature('lngr3').set('expr', 'phil+0.558');
model.result('pg6').feature('lngr3').setIndex('legends', 'phil+0.558', 0);
model.result('pg6').run;
model.result('pg6').set('xlabelactive', true);
model.result('pg6').set('xlabel', 'x');
model.result('pg6').set('ylabelactive', true);
model.result('pg6').set('ylabel', 'Voltage (V)');
model.result('pg6').run;
model.result('pg5').run;
model.result('pg5').setIndex('looplevelinput', 'manual', 0);
model.result('pg5').setIndex('looplevel', [121 181 221 241 301], 0);
model.result('pg5').run;
model.result('pg5').feature('lngr1').set('legend', true);
model.result('pg5').run;
model.result('pg5').set('xlabelactive', true);
model.result('pg5').set('xlabel', 'x');
model.result('pg5').set('ylabelactive', true);
model.result('pg5').set('ylabel', 'Electrolyte concentration, cl');
model.result('pg5').run;
model.result.create('pg7', 'PlotGroup1D');
model.result('pg7').run;
model.result('pg7').setIndex('looplevelinput', 'manual', 0);
model.result('pg7').setIndex('looplevel', [2 121 181], 0);
model.result('pg7').set('titletype', 'manual');
model.result('pg7').set('title', 'Electrode particle lithium concentration, surface (solid) and center (dashed)');
model.result('pg7').set('xlabelactive', true);
model.result('pg7').set('xlabel', 'x');
model.result('pg7').set('ylabelactive', true);
model.result('pg7').set('ylabel', 'cs (mol//m<sup>3</sup>)');
model.result('pg7').create('lngr1', 'LineGraph');
model.result('pg7').feature('lngr1').set('markerpos', 'datapoints');
model.result('pg7').feature('lngr1').set('linewidth', 'preference');
model.result('pg7').feature('lngr1').selection.all;
model.result('pg7').feature('lngr1').set('expr', 'liion.cs_surface');
model.result('pg7').feature('lngr1').set('descr', 'Insertion particle concentration, surface');
model.result('pg7').feature('lngr1').set('legend', true);
model.result('pg7').run;
model.result('pg7').create('lngr2', 'LineGraph');
model.result('pg7').feature('lngr2').set('markerpos', 'datapoints');
model.result('pg7').feature('lngr2').set('linewidth', 'preference');
model.result('pg7').feature('lngr2').selection.all;
model.result('pg7').feature('lngr2').set('expr', 'liion.cs_center');
model.result('pg7').feature('lngr2').set('descr', 'Insertion particle concentration, center');
model.result('pg7').feature('lngr2').set('linestyle', 'dashed');
model.result('pg7').feature('lngr2').set('linecolor', 'cyclereset');
model.result('pg7').run;

model.param.set('C', '1');
model.param.descr('C', 'C-rate factor for the parametric study');

model.variable('var1').set('i_app_p', 'C*i_1C');
model.variable('var1').descr('i_app_p', 'Discharge current for the parametric study');

model.cpl.create('intop1', 'Integration', 'geom1');
model.cpl('intop1').set('axisym', true);
model.cpl('intop1').selection.geom('geom1', 0);
model.cpl('intop1').selection.set([4]);
model.cpl('intop1').set('opname', 'PositiveCC');

model.physics('liion').feature.duplicate('ecd2', 'ecd1');
model.physics('liion').feature('ecd2').label('Electrode Current Density 2 - Study 2');
model.physics('liion').feature('ecd2').set('nis', '-i_app_p');
model.physics('liion').feature('ecd1').label('Electrode Current Density 1 - Study 1');

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
model.study('std2').feature('time').set('tlist', '0 40000');
model.study('std2').feature('time').set('useadvanceddisable', true);
model.study('std2').feature('time').set('disabledphysics', {'liion/ecd1'});
model.study('std2').create('param', 'Parametric');
model.study('std2').feature('param').setIndex('pname', 'i_1C', 0);
model.study('std2').feature('param').setIndex('plistarr', '', 0);
model.study('std2').feature('param').setIndex('punit', 'A/m^2', 0);
model.study('std2').feature('param').setIndex('pname', 'i_1C', 0);
model.study('std2').feature('param').setIndex('plistarr', '', 0);
model.study('std2').feature('param').setIndex('punit', 'A/m^2', 0);
model.study('std2').feature('param').setIndex('pname', 'C', 0);
model.study('std2').feature('param').setIndex('plistarr', '0.1 1 2 4', 0);

model.sol.create('sol3');
model.sol('sol3').study('std2');
model.sol('sol3').create('st1', 'StudyStep');
model.sol('sol3').feature('st1').set('study', 'std2');
model.sol('sol3').feature('st1').set('studystep', 'cdi');
model.sol('sol3').create('v1', 'Variables');
model.sol('sol3').feature('v1').feature('comp1_phil').set('scalemethod', 'manual');
model.sol('sol3').feature('v1').feature('comp1_phis').set('scalemethod', 'manual');
model.sol('sol3').feature('v1').feature('comp1_cl').set('scalemethod', 'manual');
model.sol('sol3').feature('v1').feature('comp1_phil').set('scaleval', '1');
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
model.sol('sol3').feature('v2').feature('comp1_liion_pce2_cs').set('scalemethod', 'manual');
model.sol('sol3').feature('v2').feature('comp1_liion_pce1_cs').set('scalemethod', 'manual');
model.sol('sol3').feature('v2').feature('comp1_phis').set('scalemethod', 'manual');
model.sol('sol3').feature('v2').feature('comp1_cl').set('scalemethod', 'manual');
model.sol('sol3').feature('v2').feature('comp1_phil').set('scaleval', '1');
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
model.sol('sol3').feature('t1').set('tlist', '0 40000');
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

model.batch.create('p1', 'Parametric');
model.batch('p1').study('std2');
model.batch('p1').create('so1', 'Solutionseq');
model.batch('p1').feature('so1').set('seq', 'sol3');
model.batch('p1').feature('so1').set('store', 'on');
model.batch('p1').feature('so1').set('clear', 'on');
model.batch('p1').feature('so1').set('psol', 'none');
model.batch('p1').set('pname', {'C'});
model.batch('p1').set('plistarr', {'0.1 1 2 4'});
model.batch('p1').set('sweeptype', 'sparse');
model.batch('p1').set('probesel', 'all');
model.batch('p1').set('probes', {});
model.batch('p1').set('plot', 'off');
model.batch('p1').set('err', 'on');
model.batch('p1').attach('std2');
model.batch('p1').set('control', 'param');

model.sol('sol3').feature('t1').create('st1', 'StopCondition');
model.sol('sol3').feature('t1').feature('st1').setIndex('stopcondarr', '', 0);
model.sol('sol3').feature('t1').feature('st1').setIndex('stopcondterminateon', 'true', 0);
model.sol('sol3').feature('t1').feature('st1').setIndex('stopcondActive', true, 0);
model.sol('sol3').feature('t1').feature('st1').setIndex('stopconddesc', 'Stop expression 1', 0);
model.sol('sol3').feature('t1').feature('st1').setIndex('stopcondarr', '', 0);
model.sol('sol3').feature('t1').feature('st1').setIndex('stopcondterminateon', 'true', 0);
model.sol('sol3').feature('t1').feature('st1').setIndex('stopcondActive', true, 0);
model.sol('sol3').feature('t1').feature('st1').setIndex('stopconddesc', 'Stop expression 1', 0);
model.sol('sol3').feature('t1').feature('st1').setIndex('stopcondarr', 'comp1.PositiveCC(comp1.phis)<2.0', 0);
model.sol('sol3').feature('t1').feature('st1').set('storestopcondsol', 'stepbefore_stepafter');
model.sol('sol3').feature('t1').feature('st1').set('stopcondwarn', false);
model.sol('sol3').feature('t1').set('tout', 'tsteps');
model.sol('sol3').feature('t1').set('tstepsstore', 3);

model.study('std2').setGenPlots(false);

model.sol.create('sol5');
model.sol('sol5').study('std2');
model.sol('sol5').label('Parametric Solutions 1');

model.batch('p1').feature('so1').set('psol', 'sol5');
model.batch('p1').run('compute');

model.result.create('pg8', 'PlotGroup1D');
model.result('pg8').run;
model.result('pg8').set('data', 'dset5');
model.result('pg8').create('ptgr1', 'PointGraph');
model.result('pg8').feature('ptgr1').set('markerpos', 'datapoints');
model.result('pg8').feature('ptgr1').set('linewidth', 'preference');
model.result('pg8').feature('ptgr1').selection.set([4]);
model.result('pg8').feature('ptgr1').set('expr', 'phis');
model.result('pg8').feature('ptgr1').set('descr', 'Electric potential');
model.result('pg8').feature('ptgr1').set('xdata', 'expr');
model.result('pg8').feature('ptgr1').set('xdataexpr', '(t[s]/1[h])*i_app_p');
model.result('pg8').feature('ptgr1').set('legend', true);
model.result('pg8').feature('ptgr1').set('legendmethod', 'evaluated');
model.result('pg8').feature('ptgr1').set('legendpattern', 'eval(C) C');
model.result('pg8').run;
model.result('pg8').run;
model.result('pg8').set('titletype', 'manual');
model.result('pg8').set('title', 'Discharge curves');
model.result('pg8').set('xlabelactive', true);
model.result('pg8').set('xlabel', 'Capacity (Ah/m<sup>2</sup>)');
model.result('pg8').set('ylabelactive', true);
model.result('pg8').set('ylabel', 'Voltage (V)');
model.result('pg8').set('axislimits', true);
model.result('pg8').set('xmin', 0);
model.result('pg8').set('xmax', 19);
model.result('pg8').set('ymin', '2.0');
model.result('pg8').set('ymax', 4.4);
model.result('pg8').run;
model.result('pg1').run;
model.result('pg1').label('Load Cycle Voltage and Current');
model.result('pg6').run;
model.result('pg6').label('Voltage Losses Comparison');
model.result('pg7').run;
model.result('pg7').label('Solid Lithium Concentration');
model.result('pg8').run;
model.result('pg8').label('Discharge Curve Comparison');

model.study('std1').feature('time').set('useadvanceddisable', true);
model.study('std1').feature('time').set('disabledphysics', {'liion/ecd2'});

model.func('int1').createPlot('pg9');

model.result('pg9').run;
model.result('pg9').set('titletype', 'none');
model.result('pg9').set('xlabelactive', true);
model.result('pg9').set('xlabel', 'c<sub>s</sub>/c<sub>s, max</sub> (1)');
model.result('pg9').set('ylabel', 'E<sub>eq, neg</sub> (V)');
model.result('pg9').run;

model.material('mat1').propertyGroup('ElectrodePotential').func('int1').createPlot('pg10');

model.result('pg10').run;
model.result('pg10').set('titletype', 'none');
model.result('pg10').set('xlabelactive', true);
model.result('pg10').set('xlabel', 'c<sub>s</sub>/c<sub>s, max</sub> (1)');
model.result('pg10').set('ylabel', 'E<sub>eq, pos</sub> (V)');
model.result('pg10').run;

model.material('mat2').propertyGroup('ElectrolyteConductivity').func('int1').createPlot('pg11');

model.result('pg11').run;
model.result('pg11').set('titletype', 'none');
model.result('pg11').set('xlabelactive', true);
model.result('pg11').set('xlabel', 'c<sub>l</sub> (mol/m<sup>3</sup>)');
model.result('pg11').set('ylabel', '\sigma<sub>l</sub> (S/m)');
model.result('pg11').run;
model.result('pg9').run;
model.result.remove('pg9');
model.result.remove('pg10');
model.result.remove('pg11');
model.result.dataset.remove('int1_ds1');
model.result.dataset.remove('int1_ds2');
model.result.dataset.remove('int1_ds3');

model.title('1D Isothermal Lithium-Ion Battery');

model.description('This example demonstrates the Lithium-Ion Battery interface for studying the discharge and charge of a battery. The geometry is in one dimension and the model is isothermal.');

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

model.label('li_battery_1d.mph');

model.modelNode.label('Components');

out = model;
