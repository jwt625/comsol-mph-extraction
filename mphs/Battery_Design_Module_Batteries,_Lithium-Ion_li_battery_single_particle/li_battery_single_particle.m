function out = model
%
% li_battery_single_particle.m
%
% Model exported on May 26 2025, 21:26 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/Battery_Design_Module/Batteries,_Lithium-Ion');

model.modelNode.create('comp1', true);

model.physics.create('spb', 'SingleParticleBattery');
model.physics('spb').model('comp1');

model.study.create('std1');
model.study('std1').create('cdi', 'CurrentDistributionInitialization');
model.study('std1').feature('cdi').set('solnum', 'auto');
model.study('std1').feature('cdi').set('notsolnum', 'auto');
model.study('std1').feature('cdi').set('outputmap', {});
model.study('std1').feature('cdi').setSolveFor('/physics/spb', true);
model.study('std1').create('time', 'Transient');
model.study('std1').feature('time').set('initialtime', '0');
model.study('std1').feature('time').set('solnum', 'auto');
model.study('std1').feature('time').set('notsolnum', 'auto');
model.study('std1').feature('time').set('outputmap', {});
model.study('std1').feature('time').setSolveFor('/physics/spb', true);

% To import content from file, use:
% model.param.loadFile('FILENAME');
model.param.set('a', '1', 'Multiplicative factor for the parametric study');
model.param.set('i_1C', '17.5[A/m^2]', '1C discharge current');
model.param.set('Acell', '24e-4[m^2]', 'Cell cross section area');
model.param.set('Iapplied', '-i_1C*a*Acell', 'Applied current');
model.param.set('Lneg', '100e-6[m]', 'Length of negative electrode');
model.param.set('Lpos', '174e-6[m]', 'Length of positive electrode');
model.param.set('Lsep', '52e-6[m]', 'Separator thickness');
model.param.set('epspos', 'Lpos/(Lneg+Lpos+Lsep)', 'Positive electrode fractional volume in battery');
model.param.set('epsneg', 'Lneg/(Lneg+Lpos+Lsep)', 'Negative electrode fractional volume in battery');
model.param.set('epssep', 'Lsep/(Lneg+Lpos+Lsep)', 'Separator fractional volume in battery');
model.param.set('Vcell', '(Lneg+Lpos+Lsep)*Acell', 'Cell volume');
model.param.set('opsocpos0', '0', 'Positive electrode operational state of charge');
model.param.set('opsocneg0', '1', 'Negative electrode operational state of charge');
model.param.set('Rsol', '6.0e-3[ohm*m^2]', 'Solution phase resistance in the cell');
model.param.set('cl', '2000[mol/m^3]', 'Electrolyte salt concentration');
model.param.set('epsspos', '0.297', 'Solid phase volume fraction in positive electrode');
model.param.set('epssneg', '0.471', 'Solid phase volume fraction in negative electrode');
model.param.set('rppos', '8e-6[m]', 'Particle radius positive electrode');
model.param.set('rpneg', '12.5e-6[m]', 'Particle radius negative electrode');
model.param.set('socmaxpos', '0.76', 'Maximum positive electrode state of charge');
model.param.set('socmaxneg', '0.5635', 'Maximum negative electrode state of charge');
model.param.set('socminpos', '0.1706', 'Minimum positive electrode state of charge');
model.param.set('Dsneg', '3.9e-14[m^2/s]', 'Solid phase Li-diffusivity negative electrode');
model.param.set('Dspos', '1e-13[m^2/s]', 'Solid phase Li-diffusivity positive electrode');
model.param.set('csmaxneg', '26390[mol/m^3]', 'Max solid phase concentration negative electrode');
model.param.set('kneg', '8.7106E-10[m/s]', 'Rate constant negative electrode');
model.param.set('kpos', '9.6422E-10[m/s]', 'Rate constant positive electrode');
model.param.set('clref', '2000[mol/m^3]', 'Reference electrolyte salt concentration');
model.param.set('T', '298[K]', 'Temperature');
model.param.set('Vmin', '3.45[V]', 'Minimum voltage for charge discharge cycling study');
model.param.set('Vmax', '4.418[V]', 'Maximum voltage for charge discharge cycling study');
model.param.set('trestdch', '300[s]', 'Resting time discharge for charge discharge cycling study');
model.param.set('trestch', '3700[s]', 'Resting time charge for charge discharge cycling study');

model.func.create('int1', 'Interpolation');
model.func('int1').set('funcname', 'Eeq_neg');
model.func('int1').set('table', {'0.0500' '0.9761';  ...
'0.1000' '0.8179';  ...
'0.1500' '0.6817';  ...
'0.2000' '0.5644';  ...
'0.2500' '0.4635';  ...
'0.3000' '0.3767';  ...
'0.3500' '0.3019';  ...
'0.4000' '0.2376';  ...
'0.4500' '0.1822';  ...
'0.5000' '0.1345';  ...
'0.5500' '0.0935';  ...
'0.600' '0.0582';  ...
'0.6500' '0.0278';  ...
'0.7000' '0.0016'});
model.func('int1').set('interp', 'cubicspline');
model.func('int1').set('extrap', 'interior');
model.func('int1').setIndex('fununit', 'V', 0);

model.material.create('mat1', 'Common', '');
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

model.variable.create('var1');
model.variable('var1').model('comp1');

% To import content from file, use:
% model.variable('var1').loadFile('FILENAME');
model.variable('var1').set('Eeqneg', 'Eeq_neg(spb.soc_surface_neg1)');

model.physics('spb').prop('BatterySettings').set('I_app', 'Iapplied');
model.physics('spb').prop('BatterySettings').set('eps_pos', 'epspos');
model.physics('spb').prop('BatterySettings').set('eps_neg', 'epsneg');
model.physics('spb').prop('InitialChargeDistribution').set('InitialState', 'ElectrodeSOCs');
model.physics('spb').prop('InitialChargeDistribution').set('opsoc_pos0', 'opsocpos0');
model.physics('spb').prop('InitialChargeDistribution').set('opsoc_neg0', 'opsocneg0');
model.physics('spb').prop('Vcell').set('V_cell', 'Vcell');
model.physics('spb').feature('elecsep1').set('cl', 'cl');
model.physics('spb').feature('elecsep1').set('SolutionResistance', 'UserDefined');
model.physics('spb').feature('elecsep1').set('R_sol', 'Rsol');
model.physics('spb').feature('elecsep1').set('L_sep', 'Lsep');
model.physics('spb').feature('elecsep1').set('eps_sep', 'epssep');
model.physics('spb').feature('pos1').set('epss', 'epsspos');
model.physics('spb').feature('pos1').set('ParticleMaterial', 'mat1');
model.physics('spb').feature('pos1').set('Ds_mat', 'userdef');
model.physics('spb').feature('pos1').set('Ds', 'Dspos');
model.physics('spb').feature('pos1').set('rp', 'rppos');
model.physics('spb').feature('pos1').set('socmin_mat', 'userdef');
model.physics('spb').feature('pos1').set('socmin', 'socminpos');
model.physics('spb').feature('pos1').set('socmax_mat', 'userdef');
model.physics('spb').feature('pos1').set('socmax', 'socmaxpos');
model.physics('spb').feature('pos1').set('minput_temperature', 'T');
model.physics('spb').feature('pos1').feature('per1').set('minput_temperature', 'T');
model.physics('spb').feature('pos1').feature('per1').set('MaterialOption', 'mat1');
model.physics('spb').feature('pos1').feature('per1').set('i0refType', 'FromRateConstant');
model.physics('spb').feature('pos1').feature('per1').set('k', 'kpos');
model.physics('spb').feature('pos1').feature('per1').set('cl_ref', 'clref');
model.physics('spb').feature('neg1').set('epss', 'epssneg');
model.physics('spb').feature('neg1').set('cEeqref_mat', 'userdef');
model.physics('spb').feature('neg1').set('cEeqref', 'csmaxneg');
model.physics('spb').feature('neg1').set('Ds_mat', 'userdef');
model.physics('spb').feature('neg1').set('Ds', 'Dsneg');
model.physics('spb').feature('neg1').set('rp', 'rpneg');
model.physics('spb').feature('neg1').set('socmin_mat', 'userdef');
model.physics('spb').feature('neg1').set('socmax_mat', 'userdef');
model.physics('spb').feature('neg1').set('socmax', 'socmaxneg');
model.physics('spb').feature('neg1').feature('per1').set('minput_temperature', 'T');
model.physics('spb').feature('neg1').feature('per1').set('Eeq_mat', 'userdef');
model.physics('spb').feature('neg1').feature('per1').set('Eeq', 'Eeqneg');
model.physics('spb').feature('neg1').feature('per1').set('i0refType', 'FromRateConstant');
model.physics('spb').feature('neg1').feature('per1').set('k', 'kneg');
model.physics('spb').feature('neg1').feature('per1').set('cl_ref', 'clref');
model.physics('spb').feature('neg1').feature('per1').set('dEeqdT_mat', 'userdef');

model.study('std1').feature('time').set('tlist', '0 40000');
model.study('std1').feature('time').set('usertol', true);
model.study('std1').feature('time').set('rtol', 0.001);
model.study('std1').feature('time').set('useparam', true);
model.study('std1').feature('time').setIndex('pname', 'a', 0);
model.study('std1').feature('time').setIndex('plistarr', '', 0);
model.study('std1').feature('time').setIndex('punit', '', 0);
model.study('std1').feature('time').setIndex('pname', 'a', 0);
model.study('std1').feature('time').setIndex('plistarr', '', 0);
model.study('std1').feature('time').setIndex('punit', '', 0);
model.study('std1').feature('time').setIndex('plistarr', '0.1 1 2', 0);

model.sol.create('sol1');
model.sol('sol1').study('std1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'cdi');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').feature('comp1_spb_pos1_cs').set('scalemethod', 'manual');
model.sol('sol1').feature('v1').feature('comp1_spb_pos1_Ect').set('scalemethod', 'manual');
model.sol('sol1').feature('v1').feature('comp1_spb_neg1_cs').set('scalemethod', 'manual');
model.sol('sol1').feature('v1').feature('comp1_spb_neg1_Ect').set('scalemethod', 'manual');
model.sol('sol1').feature('v1').feature('comp1_spb_pos1_cs').set('scaleval', '10000');
model.sol('sol1').feature('v1').feature('comp1_spb_pos1_Ect').set('scaleval', '1');
model.sol('sol1').feature('v1').feature('comp1_spb_neg1_cs').set('scaleval', '10000');
model.sol('sol1').feature('v1').feature('comp1_spb_neg1_Ect').set('scaleval', '1');
model.sol('sol1').feature('v1').set('control', 'cdi');
model.sol('sol1').create('s1', 'Stationary');
model.sol('sol1').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('s1').feature('fc1').set('dtech', 'auto');
model.sol('sol1').feature('s1').feature('fc1').set('initstep', 1);
model.sol('sol1').feature('s1').feature('fc1').set('minstep', 1.0E-6);
model.sol('sol1').feature('s1').feature('fc1').set('maxiter', 25);
model.sol('sol1').feature('s1').create('d1', 'Direct');
model.sol('sol1').feature('s1').feature('d1').set('rhob', 1);
model.sol('sol1').feature('s1').feature('fc1').set('linsolver', 'd1');
model.sol('sol1').feature('s1').feature('fc1').set('dtech', 'auto');
model.sol('sol1').feature('s1').feature('fc1').set('initstep', 1);
model.sol('sol1').feature('s1').feature('fc1').set('minstep', 1.0E-6);
model.sol('sol1').feature('s1').feature('fc1').set('maxiter', 25);
model.sol('sol1').feature('s1').feature.remove('fcDef');
model.sol('sol1').create('su1', 'StoreSolution');
model.sol('sol1').create('st2', 'StudyStep');
model.sol('sol1').feature('st2').set('study', 'std1');
model.sol('sol1').feature('st2').set('studystep', 'time');
model.sol('sol1').create('v2', 'Variables');
model.sol('sol1').feature('v2').feature('comp1_spb_pos1_cs').set('scalemethod', 'manual');
model.sol('sol1').feature('v2').feature('comp1_spb_pos1_Ect').set('scalemethod', 'manual');
model.sol('sol1').feature('v2').feature('comp1_spb_neg1_cs').set('scalemethod', 'manual');
model.sol('sol1').feature('v2').feature('comp1_spb_neg1_Ect').set('scalemethod', 'manual');
model.sol('sol1').feature('v2').feature('comp1_spb_pos1_cs').set('scaleval', '10000');
model.sol('sol1').feature('v2').feature('comp1_spb_pos1_Ect').set('scaleval', '1');
model.sol('sol1').feature('v2').feature('comp1_spb_neg1_cs').set('scaleval', '10000');
model.sol('sol1').feature('v2').feature('comp1_spb_neg1_Ect').set('scaleval', '1');
model.sol('sol1').feature('v2').set('initmethod', 'sol');
model.sol('sol1').feature('v2').set('initsol', 'sol1');
model.sol('sol1').feature('v2').set('initsoluse', 'sol2');
model.sol('sol1').feature('v2').set('notsolmethod', 'sol');
model.sol('sol1').feature('v2').set('notsol', 'sol1');
model.sol('sol1').feature('v2').set('notsoluse', 'sol2');
model.sol('sol1').feature('v2').set('control', 'time');
model.sol('sol1').create('t1', 'Time');
model.sol('sol1').feature('t1').set('tlist', '0 40000');
model.sol('sol1').feature('t1').set('plot', 'off');
model.sol('sol1').feature('t1').set('plotgroup', 'Default');
model.sol('sol1').feature('t1').set('plotfreq', 'tout');
model.sol('sol1').feature('t1').set('probesel', 'all');
model.sol('sol1').feature('t1').set('probes', {});
model.sol('sol1').feature('t1').set('probefreq', 'tsteps');
model.sol('sol1').feature('t1').set('atolglobalvaluemethod', 'factor');
model.sol('sol1').feature('t1').set('eventout', true);
model.sol('sol1').feature('t1').set('reacf', true);
model.sol('sol1').feature('t1').set('storeudot', true);
model.sol('sol1').feature('t1').set('endtimeinterpolation', true);
model.sol('sol1').feature('t1').set('initialstepbdfactive', true);
model.sol('sol1').feature('t1').set('initialstepbdf', '(1)[s]');
model.sol('sol1').feature('t1').create('tp1', 'TimeParametric');
model.sol('sol1').feature('t1').feature.remove('tpDef');
model.sol('sol1').feature('t1').feature('tp1').set('control', 'time');
model.sol('sol1').feature('t1').set('control', 'time');
model.sol('sol1').feature('t1').feature('aDef').set('cachepattern', true);
model.sol('sol1').feature('t1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('t1').feature('fc1').set('dtech', 'auto');
model.sol('sol1').feature('t1').feature('fc1').set('initstep', 1);
model.sol('sol1').feature('t1').feature('fc1').set('minstep', 1.0E-4);
model.sol('sol1').feature('t1').feature('fc1').set('maxiter', 5);
model.sol('sol1').feature('t1').create('d1', 'Direct');
model.sol('sol1').feature('t1').feature('fc1').set('linsolver', 'd1');
model.sol('sol1').feature('t1').feature('fc1').set('dtech', 'auto');
model.sol('sol1').feature('t1').feature('fc1').set('initstep', 1);
model.sol('sol1').feature('t1').feature('fc1').set('minstep', 1.0E-4);
model.sol('sol1').feature('t1').feature('fc1').set('maxiter', 5);
model.sol('sol1').feature('t1').feature.remove('fcDef');
model.sol('sol1').attach('std1');
model.sol('sol1').feature('t1').set('tout', 'tsteps');
model.sol('sol1').feature('t1').create('st1', 'StopCondition');
model.sol('sol1').feature('t1').feature('st1').setIndex('stopcondarr', '', 0);
model.sol('sol1').feature('t1').feature('st1').setIndex('stopcondterminateon', 'true', 0);
model.sol('sol1').feature('t1').feature('st1').setIndex('stopcondActive', true, 0);
model.sol('sol1').feature('t1').feature('st1').setIndex('stopconddesc', 'Stop expression 1', 0);
model.sol('sol1').feature('t1').feature('st1').setIndex('stopcondarr', '', 0);
model.sol('sol1').feature('t1').feature('st1').setIndex('stopcondterminateon', 'true', 0);
model.sol('sol1').feature('t1').feature('st1').setIndex('stopcondActive', true, 0);
model.sol('sol1').feature('t1').feature('st1').setIndex('stopconddesc', 'Stop expression 1', 0);
model.sol('sol1').feature('t1').feature('st1').setIndex('stopcondarr', 'comp1.spb.E_cell<2.0', 0);
model.sol('sol1').feature('t1').feature('st1').set('storestopcondsol', 'stepbefore');
model.sol('sol1').feature('t1').feature('st1').set('stopcondwarn', false);
model.sol('sol1').runAll;

model.result.create('pg1', 'PlotGroup1D');
model.result('pg1').label('Cell Potential (spb)');
model.result('pg1').set('showlooplevelinput', {'off' 'off' 'off'});
model.result('pg1').set('data', 'dset1');
model.result('pg1').set('defaultPlotID', 'BFCMeshStudyResultDefaultsComponents/icom17/pdef1/pg1');
model.result('pg1').feature.create('glob1', 'Global');
model.result('pg1').feature('glob1').label('Global');
model.result('pg1').feature('glob1').set('showsolutionparams', 'on');
model.result('pg1').feature('glob1').set('expr', {'spb.E_cell'});
model.result('pg1').feature('glob1').set('hasmultilevel', 'off');
model.result('pg1').feature('glob1').set('xdatasolnumtype', 'inner');
model.result('pg1').feature('glob1').set('showunitcombo', 'off');
model.result('pg1').feature('glob1').set('showsolutionparams', 'on');
model.result('pg1').feature('glob1').set('hasmultilevel', 'off');
model.result('pg1').feature('glob1').set('xdatasolnumtype', 'inner');
model.result('pg1').feature('glob1').set('showunitcombo', 'off');
model.result('pg1').feature('glob1').set('showsolutionparams', 'on');
model.result('pg1').feature('glob1').set('hasmultilevel', 'off');
model.result('pg1').feature('glob1').set('xdatasolnumtype', 'inner');
model.result('pg1').feature('glob1').set('showunitcombo', 'off');
model.result('pg1').feature('glob1').set('showsolutionparams', 'on');
model.result('pg1').feature('glob1').set('hasmultilevel', 'off');
model.result('pg1').feature('glob1').set('xdatasolnumtype', 'inner');
model.result('pg1').feature('glob1').set('showunitcombo', 'off');
model.result('pg1').feature('glob1').set('showsolutionparams', 'on');
model.result('pg1').feature('glob1').set('hasmultilevel', 'off');
model.result('pg1').feature('glob1').set('xdatasolnumtype', 'inner');
model.result('pg1').feature('glob1').set('showunitcombo', 'off');
model.result('pg1').feature('glob1').set('data', 'parent');
model.result.create('pg2', 'PlotGroup1D');
model.result('pg2').label('Cell Current (spb)');
model.result('pg2').set('showlooplevelinput', {'off' 'off' 'off'});
model.result('pg2').set('data', 'dset1');
model.result('pg2').set('defaultPlotID', 'BFCMeshStudyResultDefaultsComponents/icom17/pdef1/pg2');
model.result('pg2').feature.create('glob1', 'Global');
model.result('pg2').feature('glob1').label('Global');
model.result('pg2').feature('glob1').set('showsolutionparams', 'on');
model.result('pg2').feature('glob1').set('expr', {'spb.I_cell'});
model.result('pg2').feature('glob1').set('hasmultilevel', 'off');
model.result('pg2').feature('glob1').set('xdatasolnumtype', 'inner');
model.result('pg2').feature('glob1').set('showunitcombo', 'off');
model.result('pg2').feature('glob1').set('showsolutionparams', 'on');
model.result('pg2').feature('glob1').set('hasmultilevel', 'off');
model.result('pg2').feature('glob1').set('xdatasolnumtype', 'inner');
model.result('pg2').feature('glob1').set('showunitcombo', 'off');
model.result('pg2').feature('glob1').set('showsolutionparams', 'on');
model.result('pg2').feature('glob1').set('hasmultilevel', 'off');
model.result('pg2').feature('glob1').set('xdatasolnumtype', 'inner');
model.result('pg2').feature('glob1').set('showunitcombo', 'off');
model.result('pg2').feature('glob1').set('showsolutionparams', 'on');
model.result('pg2').feature('glob1').set('hasmultilevel', 'off');
model.result('pg2').feature('glob1').set('xdatasolnumtype', 'inner');
model.result('pg2').feature('glob1').set('showunitcombo', 'off');
model.result('pg2').feature('glob1').set('showsolutionparams', 'on');
model.result('pg2').feature('glob1').set('hasmultilevel', 'off');
model.result('pg2').feature('glob1').set('xdatasolnumtype', 'inner');
model.result('pg2').feature('glob1').set('showunitcombo', 'off');
model.result('pg2').feature('glob1').set('data', 'parent');
model.result.create('pg3', 'PlotGroup1D');
model.result('pg3').label('Positive Electrode Operational State of Charge, Particle Surface (spb)');
model.result('pg3').set('showlooplevelinput', {'off' 'off' 'off'});
model.result('pg3').set('data', 'dset1');
model.result('pg3').set('defaultPlotID', 'BFCMeshStudyResultDefaultsComponents/icom17/pdef1/pg3');
model.result('pg3').feature.create('glob1', 'Global');
model.result('pg3').feature('glob1').label('Global');
model.result('pg3').feature('glob1').set('showsolutionparams', 'on');
model.result('pg3').feature('glob1').set('expr', {'spb.opsoc_pos_surface'});
model.result('pg3').feature('glob1').set('hasmultilevel', 'off');
model.result('pg3').feature('glob1').set('xdatasolnumtype', 'inner');
model.result('pg3').feature('glob1').set('showunitcombo', 'off');
model.result('pg3').feature('glob1').set('showsolutionparams', 'on');
model.result('pg3').feature('glob1').set('hasmultilevel', 'off');
model.result('pg3').feature('glob1').set('xdatasolnumtype', 'inner');
model.result('pg3').feature('glob1').set('showunitcombo', 'off');
model.result('pg3').feature('glob1').set('showsolutionparams', 'on');
model.result('pg3').feature('glob1').set('hasmultilevel', 'off');
model.result('pg3').feature('glob1').set('xdatasolnumtype', 'inner');
model.result('pg3').feature('glob1').set('showunitcombo', 'off');
model.result('pg3').feature('glob1').set('showsolutionparams', 'on');
model.result('pg3').feature('glob1').set('hasmultilevel', 'off');
model.result('pg3').feature('glob1').set('xdatasolnumtype', 'inner');
model.result('pg3').feature('glob1').set('showunitcombo', 'off');
model.result('pg3').feature('glob1').set('showsolutionparams', 'on');
model.result('pg3').feature('glob1').set('hasmultilevel', 'off');
model.result('pg3').feature('glob1').set('xdatasolnumtype', 'inner');
model.result('pg3').feature('glob1').set('showunitcombo', 'off');
model.result('pg3').feature('glob1').set('data', 'parent');
model.result.create('pg4', 'PlotGroup1D');
model.result('pg4').label('Negative Electrode Operational State of Charge, Particle Surface (spb)');
model.result('pg4').set('showlooplevelinput', {'off' 'off' 'off'});
model.result('pg4').set('data', 'dset1');
model.result('pg4').set('defaultPlotID', 'BFCMeshStudyResultDefaultsComponents/icom17/pdef1/pg4');
model.result('pg4').feature.create('glob1', 'Global');
model.result('pg4').feature('glob1').label('Global');
model.result('pg4').feature('glob1').set('showsolutionparams', 'on');
model.result('pg4').feature('glob1').set('expr', {'spb.opsoc_neg_surface'});
model.result('pg4').feature('glob1').set('hasmultilevel', 'off');
model.result('pg4').feature('glob1').set('xdatasolnumtype', 'inner');
model.result('pg4').feature('glob1').set('showunitcombo', 'off');
model.result('pg4').feature('glob1').set('showsolutionparams', 'on');
model.result('pg4').feature('glob1').set('hasmultilevel', 'off');
model.result('pg4').feature('glob1').set('xdatasolnumtype', 'inner');
model.result('pg4').feature('glob1').set('showunitcombo', 'off');
model.result('pg4').feature('glob1').set('showsolutionparams', 'on');
model.result('pg4').feature('glob1').set('hasmultilevel', 'off');
model.result('pg4').feature('glob1').set('xdatasolnumtype', 'inner');
model.result('pg4').feature('glob1').set('showunitcombo', 'off');
model.result('pg4').feature('glob1').set('showsolutionparams', 'on');
model.result('pg4').feature('glob1').set('hasmultilevel', 'off');
model.result('pg4').feature('glob1').set('xdatasolnumtype', 'inner');
model.result('pg4').feature('glob1').set('showunitcombo', 'off');
model.result('pg4').feature('glob1').set('showsolutionparams', 'on');
model.result('pg4').feature('glob1').set('hasmultilevel', 'off');
model.result('pg4').feature('glob1').set('xdatasolnumtype', 'inner');
model.result('pg4').feature('glob1').set('showunitcombo', 'off');
model.result('pg4').feature('glob1').set('data', 'parent');
model.result.create('pg5', 'PlotGroup1D');
model.result('pg5').label('Total Power Dissipation Density (spb)');
model.result('pg5').set('showlooplevelinput', {'off' 'off' 'off'});
model.result('pg5').set('data', 'dset1');
model.result('pg5').set('defaultPlotID', 'BFCMeshStudyResultDefaultsComponents/icom17/pdef1/pcond1/pg1');
model.result('pg5').feature.create('glob1', 'Global');
model.result('pg5').feature('glob1').label('Global');
model.result('pg5').feature('glob1').set('showsolutionparams', 'on');
model.result('pg5').feature('glob1').set('expr', {'spb.Qh'});
model.result('pg5').feature('glob1').set('hasmultilevel', 'off');
model.result('pg5').feature('glob1').set('xdatasolnumtype', 'inner');
model.result('pg5').feature('glob1').set('showunitcombo', 'off');
model.result('pg5').feature('glob1').set('showsolutionparams', 'on');
model.result('pg5').feature('glob1').set('hasmultilevel', 'off');
model.result('pg5').feature('glob1').set('xdatasolnumtype', 'inner');
model.result('pg5').feature('glob1').set('showunitcombo', 'off');
model.result('pg5').feature('glob1').set('showsolutionparams', 'on');
model.result('pg5').feature('glob1').set('hasmultilevel', 'off');
model.result('pg5').feature('glob1').set('xdatasolnumtype', 'inner');
model.result('pg5').feature('glob1').set('showunitcombo', 'off');
model.result('pg5').feature('glob1').set('showsolutionparams', 'on');
model.result('pg5').feature('glob1').set('hasmultilevel', 'off');
model.result('pg5').feature('glob1').set('xdatasolnumtype', 'inner');
model.result('pg5').feature('glob1').set('showunitcombo', 'off');
model.result('pg5').feature('glob1').set('showsolutionparams', 'on');
model.result('pg5').feature('glob1').set('hasmultilevel', 'off');
model.result('pg5').feature('glob1').set('xdatasolnumtype', 'inner');
model.result('pg5').feature('glob1').set('showunitcombo', 'off');
model.result('pg5').feature('glob1').set('data', 'parent');
model.result('pg1').run;
model.result('pg1').run;
model.result('pg1').set('titletype', 'manual');
model.result('pg1').set('title', 'Discharge profiles');
model.result('pg1').set('xlabelactive', true);
model.result('pg1').set('xlabel', 'Capacity (Ah/m<sup>2</sup>)');
model.result('pg1').set('ylabelactive', true);
model.result('pg1').set('legendpos', 'lowerleft');
model.result('pg1').run;
model.result('pg1').feature('glob1').set('xdata', 'expr');
model.result('pg1').feature('glob1').set('xdataexpr', '(t[s]/1[h])*i_1C*a');
model.result('pg1').feature('glob1').set('linestyle', 'dashdot');
model.result('pg1').feature('glob1').set('legendmethod', 'evaluated');
model.result('pg1').feature('glob1').set('legendpattern', 'Single particle model, eval(a) C');
model.result('pg1').run;
model.result.table.create('tbl1', 'Table');
model.result.table('tbl1').importData('li_battery_single_particle_01C_comparison.txt');
model.result.table.create('tbl2', 'Table');
model.result.table('tbl2').importData('li_battery_single_particle_1C_comparison.txt');
model.result.table.create('tbl3', 'Table');
model.result.table('tbl3').importData('li_battery_single_particle_2C_comparison.txt');
model.result('pg1').run;
model.result('pg1').create('tblp1', 'Table');
model.result('pg1').feature('tblp1').set('markerpos', 'datapoints');
model.result('pg1').feature('tblp1').set('linewidth', 'preference');
model.result('pg1').feature('tblp1').set('linecolor', 'cyclereset');
model.result('pg1').feature('tblp1').set('linemarker', 'cycle');
model.result('pg1').feature('tblp1').set('markerpos', 'interp');
model.result('pg1').feature('tblp1').set('legend', true);
model.result('pg1').feature('tblp1').set('legendmethod', 'manual');
model.result('pg1').feature('tblp1').setIndex('legends', '1D model, 0.1 C', 0);
model.result('pg1').feature.duplicate('tblp2', 'tblp1');
model.result('pg1').run;
model.result('pg1').feature('tblp2').set('table', 'tbl2');
model.result('pg1').feature('tblp2').set('linecolor', 'cycle');
model.result('pg1').feature('tblp2').setIndex('legends', '1D model, 1 C', 0);
model.result('pg1').feature.duplicate('tblp3', 'tblp2');
model.result('pg1').run;
model.result('pg1').feature('tblp3').set('table', 'tbl3');
model.result('pg1').feature('tblp3').setIndex('legends', '1D model, 2 C', 0);
model.result('pg1').run;

model.physics('spb').prop('BatterySettings').set('OperationMode', 'ChargeDischargeCycling');
model.physics('spb').prop('BatterySettings').set('Idch', 'Iapplied');
model.physics('spb').prop('BatterySettings').set('Vmin', 'Vmin');
model.physics('spb').prop('BatterySettings').set('item.OCDCH', true);
model.physics('spb').prop('BatterySettings').set('tredch', 'trestdch');
model.physics('spb').prop('BatterySettings').set('Ich', '-Iapplied');
model.physics('spb').prop('BatterySettings').set('Vmax', 'Vmax');
model.physics('spb').prop('BatterySettings').set('item.OCCH', true);
model.physics('spb').prop('BatterySettings').set('trech', 'trestch');

model.study.create('std2');
model.study('std2').create('cdi', 'CurrentDistributionInitialization');
model.study('std2').feature('cdi').set('solnum', 'auto');
model.study('std2').feature('cdi').set('notsolnum', 'auto');
model.study('std2').feature('cdi').set('outputmap', {});
model.study('std2').feature('cdi').setSolveFor('/physics/spb', true);
model.study('std2').create('time', 'Transient');
model.study('std2').feature('time').set('plotgroup', 'Default');
model.study('std2').feature('time').set('initialtime', '0');
model.study('std2').feature('time').set('solnum', 'auto');
model.study('std2').feature('time').set('notsolnum', 'auto');
model.study('std2').feature('time').set('outputmap', {});
model.study('std2').feature('time').setSolveFor('/physics/spb', true);
model.study('std2').feature('time').set('tlist', 'range(0,10,8000)');
model.study('std2').setGenPlots(false);

model.sol.create('sol3');
model.sol('sol3').study('std2');
model.sol('sol3').create('st1', 'StudyStep');
model.sol('sol3').feature('st1').set('study', 'std2');
model.sol('sol3').feature('st1').set('studystep', 'cdi');
model.sol('sol3').create('v1', 'Variables');
model.sol('sol3').feature('v1').feature('comp1_spb_pos1_cs').set('scalemethod', 'manual');
model.sol('sol3').feature('v1').feature('comp1_spb_pos1_Ect').set('scalemethod', 'manual');
model.sol('sol3').feature('v1').feature('comp1_spb_neg1_cs').set('scalemethod', 'manual');
model.sol('sol3').feature('v1').feature('comp1_spb_neg1_Ect').set('scalemethod', 'manual');
model.sol('sol3').feature('v1').feature('comp1_spb_pos1_cs').set('scaleval', '10000');
model.sol('sol3').feature('v1').feature('comp1_spb_pos1_Ect').set('scaleval', '1');
model.sol('sol3').feature('v1').feature('comp1_spb_neg1_cs').set('scaleval', '10000');
model.sol('sol3').feature('v1').feature('comp1_spb_neg1_Ect').set('scaleval', '1');
model.sol('sol3').feature('v1').set('control', 'cdi');
model.sol('sol3').create('s1', 'Stationary');
model.sol('sol3').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol3').feature('s1').feature('fc1').set('dtech', 'auto');
model.sol('sol3').feature('s1').feature('fc1').set('initstep', 1);
model.sol('sol3').feature('s1').feature('fc1').set('minstep', 1.0E-6);
model.sol('sol3').feature('s1').feature('fc1').set('maxiter', 25);
model.sol('sol3').feature('s1').create('d1', 'Direct');
model.sol('sol3').feature('s1').feature('d1').set('rhob', 1);
model.sol('sol3').feature('s1').feature('fc1').set('linsolver', 'd1');
model.sol('sol3').feature('s1').feature('fc1').set('dtech', 'auto');
model.sol('sol3').feature('s1').feature('fc1').set('initstep', 1);
model.sol('sol3').feature('s1').feature('fc1').set('minstep', 1.0E-6);
model.sol('sol3').feature('s1').feature('fc1').set('maxiter', 25);
model.sol('sol3').feature('s1').feature.remove('fcDef');
model.sol('sol3').create('su1', 'StoreSolution');
model.sol('sol3').create('st2', 'StudyStep');
model.sol('sol3').feature('st2').set('study', 'std2');
model.sol('sol3').feature('st2').set('studystep', 'time');
model.sol('sol3').create('v2', 'Variables');
model.sol('sol3').feature('v2').feature('comp1_spb_pos1_cs').set('scalemethod', 'manual');
model.sol('sol3').feature('v2').feature('comp1_spb_pos1_Ect').set('scalemethod', 'manual');
model.sol('sol3').feature('v2').feature('comp1_spb_neg1_cs').set('scalemethod', 'manual');
model.sol('sol3').feature('v2').feature('comp1_spb_neg1_Ect').set('scalemethod', 'manual');
model.sol('sol3').feature('v2').feature('comp1_spb_pos1_cs').set('scaleval', '10000');
model.sol('sol3').feature('v2').feature('comp1_spb_pos1_Ect').set('scaleval', '1');
model.sol('sol3').feature('v2').feature('comp1_spb_neg1_cs').set('scaleval', '10000');
model.sol('sol3').feature('v2').feature('comp1_spb_neg1_Ect').set('scaleval', '1');
model.sol('sol3').feature('v2').set('initmethod', 'sol');
model.sol('sol3').feature('v2').set('initsol', 'sol3');
model.sol('sol3').feature('v2').set('initsoluse', 'sol4');
model.sol('sol3').feature('v2').set('notsolmethod', 'sol');
model.sol('sol3').feature('v2').set('notsol', 'sol3');
model.sol('sol3').feature('v2').set('notsoluse', 'sol4');
model.sol('sol3').feature('v2').set('control', 'time');
model.sol('sol3').create('t1', 'Time');
model.sol('sol3').feature('t1').set('tlist', 'range(0,10,8000)');
model.sol('sol3').feature('t1').set('plot', 'off');
model.sol('sol3').feature('t1').set('plotgroup', 'Default');
model.sol('sol3').feature('t1').set('plotfreq', 'tout');
model.sol('sol3').feature('t1').set('probesel', 'all');
model.sol('sol3').feature('t1').set('probes', {});
model.sol('sol3').feature('t1').set('probefreq', 'tsteps');
model.sol('sol3').feature('t1').set('atolglobalvaluemethod', 'factor');
model.sol('sol3').feature('t1').set('eventout', true);
model.sol('sol3').feature('t1').set('reacf', true);
model.sol('sol3').feature('t1').set('storeudot', true);
model.sol('sol3').feature('t1').set('endtimeinterpolation', true);
model.sol('sol3').feature('t1').set('initialstepbdfactive', true);
model.sol('sol3').feature('t1').set('initialstepbdf', '(1)[s]');
model.sol('sol3').feature('t1').set('control', 'time');
model.sol('sol3').feature('t1').feature('aDef').set('cachepattern', true);
model.sol('sol3').feature('t1').create('fc1', 'FullyCoupled');
model.sol('sol3').feature('t1').feature('fc1').set('dtech', 'auto');
model.sol('sol3').feature('t1').feature('fc1').set('initstep', 1);
model.sol('sol3').feature('t1').feature('fc1').set('minstep', 1.0E-4);
model.sol('sol3').feature('t1').feature('fc1').set('maxiter', 5);
model.sol('sol3').feature('t1').create('d1', 'Direct');
model.sol('sol3').feature('t1').feature('fc1').set('linsolver', 'd1');
model.sol('sol3').feature('t1').feature('fc1').set('dtech', 'auto');
model.sol('sol3').feature('t1').feature('fc1').set('initstep', 1);
model.sol('sol3').feature('t1').feature('fc1').set('minstep', 1.0E-4);
model.sol('sol3').feature('t1').feature('fc1').set('maxiter', 5);
model.sol('sol3').feature('t1').feature.remove('fcDef');
model.sol('sol3').attach('std2');
model.sol('sol3').runAll;

model.result.create('pg6', 'PlotGroup1D');
model.result('pg6').run;
model.result('pg6').label('Charge Discharge Cycling Potential');
model.result('pg6').set('titletype', 'label');
model.result('pg6').set('xlabelactive', true);
model.result('pg6').set('xlabel', 'Time (s)');
model.result('pg6').set('ylabelactive', true);
model.result('pg6').set('ylabel', 'Cell potential (V)');
model.result('pg6').set('legendpos', 'lowerright');
model.result('pg6').set('data', 'dset3');
model.result('pg6').create('glob1', 'Global');
model.result('pg6').feature('glob1').set('markerpos', 'datapoints');
model.result('pg6').feature('glob1').set('linewidth', 'preference');
model.result('pg6').feature('glob1').set('expr', {'spb.E_cell'});
model.result('pg6').feature('glob1').set('descr', {'Cell potential'});
model.result('pg6').feature('glob1').set('unit', {'V'});
model.result('pg6').feature('glob1').set('legendmethod', 'manual');
model.result('pg6').feature('glob1').setIndex('legends', 'Single particle model', 0);
model.result('pg2').run;
model.result('pg2').run;
model.result('pg3').run;
model.result('pg3').run;
model.result('pg4').run;
model.result('pg4').run;
model.result('pg5').run;
model.result('pg5').run;
model.result.table.create('tbl4', 'Table');
model.result.table('tbl4').importData('li_battery_single_particle_CDC_comparison.txt');
model.result('pg6').run;
model.result('pg6').create('tblp1', 'Table');
model.result('pg6').feature('tblp1').set('markerpos', 'datapoints');
model.result('pg6').feature('tblp1').set('linewidth', 'preference');
model.result('pg6').feature('tblp1').set('table', 'tbl4');
model.result('pg6').feature('tblp1').set('linemarker', 'circle');
model.result('pg6').feature('tblp1').set('markerpos', 'interp');
model.result('pg6').feature('tblp1').set('legend', true);
model.result('pg6').feature('tblp1').set('legendmethod', 'manual');
model.result('pg6').feature('tblp1').setIndex('legends', '1D model', 0);
model.result('pg6').run;

model.title('Single Particle Model of a Lithium-Ion Battery');

model.description(['This example demonstrates the Single Particle Battery interface for studying the discharge of a lithium-ion battery. The model is isothermal and is set in 0D. The single particle formulation is typically valid for low-medium current scenarios.' newline  newline 'The results for different discharge currents are compared against a more extended 1D formulation of a lithium ion-battery (li_battery_1d).']);

model.mesh.clearMeshes;

model.sol('sol1').clearSolutionData;
model.sol('sol2').clearSolutionData;
model.sol('sol3').clearSolutionData;
model.sol('sol4').clearSolutionData;

model.label('li_battery_single_particle.mph');

model.modelNode.label('Components');

out = model;
