function out = model
%
% li_battery_tutorial_2d.m
%
% Model exported on May 26 2025, 21:26 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/Battery_Design_Module/Batteries,_Lithium-Ion');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 2);
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

model.geom('geom1').insertFile('li_battery_tutorial_2d_geom_sequence.mph', 'geom1');
model.geom('geom1').run('fin');

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
model.material('mat2').propertyGroup.create('ElectrodePotential', 'Equilibrium potential');
model.material('mat2').propertyGroup('ElectrodePotential').func.create('int1', 'Interpolation');
model.material('mat2').propertyGroup('ElectrodePotential').func.create('int2', 'Interpolation');
model.material('mat2').propertyGroup.create('OperationalSOC', 'Operational electrode state of charge');
model.material('mat2').propertyGroup.create('EquilibriumConcentration', 'Equilibrium concentration');
model.material('mat2').label('LMO, LiMn2O4 Spinel (Positive, Li-ion Battery)');
model.material('mat2').propertyGroup('def').set('youngsmodulus', '');
model.material('mat2').propertyGroup('def').set('poissonsratio', '');
model.material('mat2').propertyGroup('def').set('youngsmodulus', '194[GPa]');
model.material('mat2').propertyGroup('def').set('INFO_PREFIX:youngsmodulus', 'Yue Qi et al 2014 J. Electrochem. Soc. 161 F3010');
model.material('mat2').propertyGroup('def').set('poissonsratio', '0.26');
model.material('mat2').propertyGroup('def').set('INFO_PREFIX:poissonsratio', 'Yue Qi et al 2014 J. Electrochem. Soc. 161 F3010');
model.material('mat2').propertyGroup('def').set('electricconductivity', {'3.8[S/m]' '0' '0' '0' '3.8[S/m]' '0' '0' '0' '3.8[S/m]'});
model.material('mat2').propertyGroup('def').set('INFO_PREFIX:electricconductivity', 'V. Srinivasan and C.Y. Wang, "Analysis of Electrochemical and Thermal Behavior of Li-Ion Cells," J. Electrochem. Soc., vol. 150, p. A98, 2003');
model.material('mat2').propertyGroup('def').set('diffusion', {'1e-14*exp(20000/8.314*(1/(T_ref/1[K])-1/(T2/1[K])))[m^2/s]' '0' '0' '0' '1e-14*exp(20000/8.314*(1/(T_ref/1[K])-1/(T2/1[K])))[m^2/s]' '0' '0' '0' '1e-14*exp(20000/8.314*(1/(T_ref/1[K])-1/(T2/1[K])))[m^2/s]'});
model.material('mat2').propertyGroup('def').set('INFO_PREFIX:diffusion', 'V. Srinivasan and C.Y. Wang, "Analysis of Electrochemical and Thermal Behavior of Li-Ion Cells," J. Electrochem. Soc., vol. 150, p. A98, 2003');
model.material('mat2').propertyGroup('def').set('density', '4140[kg/m^3]');
model.material('mat2').propertyGroup('def').set('INFO_PREFIX:density', 'N. Nitta, F. Wu, J. Tae Lee, and G. Yushin, Materials Today, Volume 18, Number 5, June 2015');
model.material('mat2').propertyGroup('def').set('T_ref', '298[K]');
model.material('mat2').propertyGroup('def').descr('T_ref', '');
model.material('mat2').propertyGroup('def').set('T2', 'min(393.15,max(T,223.15))');
model.material('mat2').propertyGroup('def').descr('T2', '');
model.material('mat2').propertyGroup('def').set('csmax', '22860[mol/m^3]');
model.material('mat2').propertyGroup('def').descr('csmax', '');
model.material('mat2').propertyGroup('def').addInput('temperature');
model.material('mat2').propertyGroup('ElectrodePotential').func('int1').set('funcname', 'Eeq_int1');
model.material('mat2').propertyGroup('ElectrodePotential').func('int1').set('table', {'0.1750' '4.2763';  ...
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
model.material('mat2').propertyGroup('ElectrodePotential').func('int1').set('interp', 'piecewisecubic');
model.material('mat2').propertyGroup('ElectrodePotential').func('int1').set('extrap', 'linear');
model.material('mat2').propertyGroup('ElectrodePotential').func('int1').set('fununit', {'V'});
model.material('mat2').propertyGroup('ElectrodePotential').func('int1').set('argunit', {''});
model.material('mat2').propertyGroup('ElectrodePotential').func('int1').set('defineinv', true);
model.material('mat2').propertyGroup('ElectrodePotential').func('int1').set('funcinvname', 'Eeq_inv');
model.material('mat2').propertyGroup('ElectrodePotential').func('int2').set('funcname', 'dEeqdT_int1');
model.material('mat2').propertyGroup('ElectrodePotential').func('int2').set('table', {'0.15' '0.15e-3';  ...
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
model.material('mat2').propertyGroup('ElectrodePotential').func('int2').set('interp', 'piecewisecubic');
model.material('mat2').propertyGroup('ElectrodePotential').func('int2').set('fununit', {'V/K'});
model.material('mat2').propertyGroup('ElectrodePotential').func('int2').set('argunit', {''});
model.material('mat2').propertyGroup('ElectrodePotential').set('Eeq', 'Eeq_int1(soc)+dEeqdT_int1(soc)*(T-298[K])');
model.material('mat2').propertyGroup('ElectrodePotential').set('INFO_PREFIX:Eeq', 'V. Srinivasan and C.Y. Wang, "Analysis of Electrochemical and Thermal Behavior of Li-Ion Cells," J. Electrochem. Soc., vol. 150, p. A98, 2003');
model.material('mat2').propertyGroup('ElectrodePotential').set('dEeqdT', 'dEeqdT_int1(soc)');
model.material('mat2').propertyGroup('ElectrodePotential').set('INFO_PREFIX:dEeqdT', 'V. Srinivasan and C.Y. Wang, "Analysis of Electrochemical and Thermal Behavior of Li-Ion Cells," J. Electrochem. Soc., vol. 150, p. A98, 2003');
model.material('mat2').propertyGroup('ElectrodePotential').set('cEeqref', 'def.csmax');
model.material('mat2').propertyGroup('ElectrodePotential').set('INFO_PREFIX:cEeqref', 'V. Srinivasan and C.Y. Wang, "Analysis of Electrochemical and Thermal Behavior of Li-Ion Cells," J. Electrochem. Soc., vol. 150, p. A98, 2003');
model.material('mat2').propertyGroup('ElectrodePotential').set('soc', 'c/cEeqref');
model.material('mat2').propertyGroup('ElectrodePotential').descr('soc', '');
model.material('mat2').propertyGroup('ElectrodePotential').addInput('concentration');
model.material('mat2').propertyGroup('ElectrodePotential').addInput('temperature');
model.material('mat2').propertyGroup('OperationalSOC').set('socmax', 'elpot.Eeq_inv(E_min)');
model.material('mat2').propertyGroup('OperationalSOC').set('socmin', 'elpot.Eeq_inv(E_max)');
model.material('mat2').propertyGroup('OperationalSOC').set('E_max', '4.2[V]');
model.material('mat2').propertyGroup('OperationalSOC').set('E_min', '3.9[V]');
model.material('mat2').propertyGroup('EquilibriumConcentration').set('csEq', 'def.csmax*elpot.Eeq_inv(V)');
model.material('mat2').propertyGroup('EquilibriumConcentration').addInput('electricpotential');
model.material('mat2').selection.set([1]);

model.physics('liion').create('pce1', 'PorousElectrode', 2);
model.physics('liion').feature('pce1').selection.set([1]);
model.physics('liion').feature('pce1').set('ElectrolyteMaterial', 'mat1');
model.physics('liion').feature('pce1').set('epsl', '1-0.4-0.15');
model.physics('liion').create('ec1', 'ElectrodeCurrent', 1);
model.physics('liion').feature('ec1').selection.set([10]);
model.physics('liion').feature('ec1').set('ElectronicCurrentType', 'AverageCurrentDensity');
model.physics('liion').feature('ec1').set('Ias', '-50[A/m^2]');
model.physics('liion').create('es1', 'ElectrodeSurface', 1);
model.physics('liion').feature('es1').selection.set([5 7 12]);
model.physics('liion').feature('es1').feature('er1').set('Eeq_mat', 'userdef');
model.physics('liion').feature('es1').feature('er1').set('dEeqdT_mat', 'userdef');

model.mesh('mesh1').run;

model.study('std1').feature('time').set('tlist', 'range(0,10,100) range(200,100,2700)');

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
model.sol('sol1').feature('v2').feature('comp1_liion_pce1_cs').set('scalemethod', 'manual');
model.sol('sol1').feature('v2').feature('comp1_phis').set('scalemethod', 'manual');
model.sol('sol1').feature('v2').feature('comp1_cl').set('scalemethod', 'manual');
model.sol('sol1').feature('v2').feature('comp1_phil').set('scaleval', '1');
model.sol('sol1').feature('v2').feature('comp1_liion_ec1_phis0').set('scaleval', '1');
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
model.sol('sol1').feature('t1').set('tlist', 'range(0,10,100) range(200,100,2700)');
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
model.sol('sol1').runAll;

model.result.create('pg1', 'PlotGroup1D');
model.result('pg1').set('data', 'dset1');
model.result('pg1').create('glob1', 'Global');
model.result('pg1').feature('glob1').set('unit', {''});
model.result('pg1').feature('glob1').set('expr', {'liion.phis0_ec1'});
model.result('pg1').feature('glob1').set('descr', {'Electric potential on boundary'});
model.result('pg1').label('Boundary Electrode Potential with Respect to Ground (liion)');
model.result('pg1').feature('glob1').set('xdatasolnumtype', 'level1');
model.result.create('pg2', 'PlotGroup1D');
model.result('pg2').set('data', 'dset1');
model.result('pg2').create('glob1', 'Global');
model.result('pg2').feature('glob1').set('unit', {''});
model.result('pg2').feature('glob1').set('expr', {'liion.soc_average_pce1'});
model.result('pg2').feature('glob1').set('descr', {'Average SOC, Porous Electrode 1'});
model.result('pg2').label('Average Electrode State of Charge (liion)');
model.result('pg2').feature('glob1').set('xdatasolnumtype', 'level1');
model.result.create('pg3', 'PlotGroup2D');
model.result('pg3').set('data', 'dset1');
model.result('pg3').setIndex('looplevel', 37, 0);
model.result('pg3').label('Electrolyte Potential (liion)');
model.result('pg3').create('surf1', 'Surface');
model.result('pg3').feature('surf1').set('expr', {'phil'});
model.result('pg3').create('arws1', 'ArrowSurface');
model.result('pg3').feature('arws1').set('expr', {'liion.Ilx' 'liion.Ily'});
model.result('pg3').feature('arws1').set('arrowbase', 'center');
model.result('pg3').feature('arws1').set('color', 'gray');
model.result.create('pg4', 'PlotGroup2D');
model.result('pg4').set('data', 'dset1');
model.result('pg4').setIndex('looplevel', 37, 0);
model.result('pg4').label('Electrolyte Current Density (liion)');
model.result('pg4').create('arws1', 'ArrowSurface');
model.result('pg4').feature('arws1').set('expr', {'liion.Ilx' 'liion.Ily'});
model.result('pg4').feature('arws1').set('arrowbase', 'center');
model.result('pg4').feature('arws1').set('color', 'gray');
model.result('pg4').feature('arws1').create('col1', 'Color');
model.result('pg4').feature('arws1').feature('col1').set('expr', 'root.comp1.liion.IlMag');
model.result('pg4').create('line1', 'Line');
model.result('pg4').feature('line1').set('expr', {'abs(liion.itot)'});
model.result('pg4').feature('line1').set('linetype', 'tube');
model.result('pg4').feature('line1').set('inherittubescale', false);
model.result('pg4').feature('line1').set('inheritplot', 'arws1');
model.result.create('pg5', 'PlotGroup2D');
model.result('pg5').set('data', 'dset1');
model.result('pg5').setIndex('looplevel', 37, 0);
model.result('pg5').label('Electrode Potential with Respect to Ground (liion)');
model.result('pg5').create('surf1', 'Surface');
model.result('pg5').feature('surf1').set('expr', {'phis'});
model.result('pg5').create('arws1', 'ArrowSurface');
model.result('pg5').feature('arws1').set('expr', {'liion.Isx' 'liion.Isy'});
model.result('pg5').feature('arws1').set('arrowbase', 'center');
model.result('pg5').feature('arws1').set('color', 'gray');
model.result('pg5').create('line1', 'Line');
model.result('pg5').feature('line1').set('expr', {'liion.phisext'});
model.result('pg5').feature('line1').set('linetype', 'tube');
model.result('pg5').feature('line1').set('inherittubescale', false);
model.result('pg5').feature('line1').set('inheritplot', 'surf1');
model.result.create('pg6', 'PlotGroup2D');
model.result('pg6').set('data', 'dset1');
model.result('pg6').setIndex('looplevel', 37, 0);
model.result('pg6').label('Electrode Current Density (liion)');
model.result('pg6').create('arws1', 'ArrowSurface');
model.result('pg6').feature('arws1').set('expr', {'liion.Isx' 'liion.Isy'});
model.result('pg6').feature('arws1').set('arrowbase', 'center');
model.result('pg6').feature('arws1').set('color', 'gray');
model.result('pg6').feature('arws1').create('col1', 'Color');
model.result('pg6').feature('arws1').feature('col1').set('expr', 'root.comp1.liion.IsMag');
model.result('pg6').create('line1', 'Line');
model.result('pg6').feature('line1').set('expr', {'abs(liion.itot)'});
model.result('pg6').feature('line1').set('linetype', 'tube');
model.result('pg6').feature('line1').set('inherittubescale', false);
model.result('pg6').feature('line1').set('inheritplot', 'arws1');
model.result.create('pg7', 'PlotGroup2D');
model.result('pg7').set('data', 'dset1');
model.result('pg7').setIndex('looplevel', 37, 0);
model.result('pg7').create('surf1', 'Surface');
model.result('pg7').feature('surf1').set('expr', {'cl'});
model.result('pg7').label('Electrolyte Salt Concentration (liion)');
model.result('pg7').create('arws1', 'ArrowSurface');
model.result('pg7').feature('arws1').set('expr', {'liion.Nposx' 'liion.Nposy'});
model.result('pg7').feature('arws1').set('color', 'red');
model.result('pg7').create('arws2', 'ArrowSurface');
model.result('pg7').feature('arws2').set('expr', {'liion.Nnegx' 'liion.Nnegy'});
model.result('pg7').feature('arws2').set('color', 'black');
model.result('pg7').feature('arws2').set('inheritplot', 'arws1');
model.result('pg7').feature('arws2').set('inheritcolor', 'off');
model.result('pg1').run;
model.result('pg1').label('Battery Voltage');
model.result('pg1').run;
model.result.create('pg8', 'PlotGroup2D');
model.result('pg8').run;
model.result('pg8').label('Lithium Concentration on Particle Surface');
model.result('pg8').create('surf1', 'Surface');
model.result('pg8').feature('surf1').set('expr', 'liion.cs_surface');
model.result('pg8').feature('surf1').set('descr', 'Insertion particle concentration, surface');
model.result('pg8').run;
model.result.dataset.create('dset3', 'Solution');
model.result.dataset('dset3').set('comp', 'liion_pce1_pin1_xdim');
model.result.create('pg9', 'PlotGroup1D');
model.result('pg9').run;
model.result('pg9').label('Lithium Concentration in Positive Electrode Particles');
model.result('pg9').set('data', 'none');
model.result('pg9').create('lngr1', 'LineGraph');
model.result('pg9').feature('lngr1').set('markerpos', 'datapoints');
model.result('pg9').feature('lngr1').set('linewidth', 'preference');
model.result('pg9').feature('lngr1').set('data', 'dset3');
model.result('pg9').feature('lngr1').setIndex('looplevelinput', 'last', 0);
model.result('pg9').feature('lngr1').selection.all;
model.result('pg9').feature('lngr1').set('expr', 'comp1.atxd2(5e-4,1e-4,liion.cs_pce1)');
model.result('pg9').feature('lngr1').set('legend', true);
model.result('pg9').feature('lngr1').set('legendmethod', 'manual');
model.result('pg9').feature('lngr1').setIndex('legends', 'x=0.5 mm, y=0.1 mm', 0);
model.result('pg9').feature.duplicate('lngr2', 'lngr1');
model.result('pg9').run;
model.result('pg9').feature('lngr2').set('expr', 'comp1.atxd2(5e-4,5.5e-4,liion.cs_pce1)');
model.result('pg9').feature('lngr2').setIndex('legends', 'x=0.5 mm, y=0.55 mm', 0);
model.result('pg9').run;
model.result('pg9').set('titletype', 'manual');
model.result('pg9').set('title', 'Lithium Concentration Positive Electrode Particles, t=2700 s');
model.result('pg9').set('xlabelactive', true);
model.result('pg9').set('xlabel', 'Normalized Particle Dimension');
model.result('pg9').set('ylabelactive', true);
model.result('pg9').set('ylabel', 'Lithium Concentration (mol/m<sup>3</sup>)');
model.result('pg9').set('legendpos', 'upperleft');
model.result('pg9').run;

model.title('2D Lithium-Ion Battery');

model.description('This is a 2D tutorial model of a lithium-ion battery. The cell geometry is not based on a real application; it is only meant to demonstrate a 2D model setup.');

model.label('li_battery_tutorial_2d.mph');

model.modelNode.label('Components');

out = model;
