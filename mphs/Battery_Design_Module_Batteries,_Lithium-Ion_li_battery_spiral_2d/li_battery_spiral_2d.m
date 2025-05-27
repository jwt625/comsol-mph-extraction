function out = model
%
% li_battery_spiral_2d.m
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

% To import content from file, use:
% model.param.loadFile('FILENAME');
model.param.set('rp_neg', '12.5e-6[m]', 'Particle radius, negative');
model.param.set('rp_pos', '8e-6[m]', 'Particle radius, positive');
model.param.set('T_ext', '300[K]', 'External temperature');
model.param.set('sigmas_neg', '100[S/m]', 'Electrical conductivity, negative electrode');
model.param.set('sigmas_pos', '3.8[S/m]', 'Electrical conductivity, positive electrode');
model.param.set('epss_pos', '1-epsl_pos-0.259', 'Solid phase volume fraction, positive');
model.param.set('epsl_pos', '0.444', 'Electrolyte phase volume fraction, positive');
model.param.set('cl_0', '1000[mol/m^3]', 'Initial electrolyte salt concentration');
model.param.set('epss_neg', '1-epsl_neg-0.172', 'Solid phase volume fraction, negative');
model.param.set('epsl_neg', '0.357', 'Electrolyte phase volume fraction, negative');
model.param.set('cs0_neg', '20700[mol/m^3]', 'Initial negative state of charge');
model.param.set('cs0_pos', '4000[mol/m^3]', 'Initial positive state of charge');
model.param.set('i0ref_neg', '0.96[A/m^2]', 'Reference exchange current density, negative');
model.param.set('i0ref_pos', '0.70[A/m^2]', 'Reference exchange current density, positive');
model.param.set('aA_pos', '0.5', 'Reaction rate coefficient, positive');
model.param.set('aC_pos', '0.5', 'Reaction rate coefficient, positive');
model.param.set('aA_neg', '0.5', 'Reaction rate coefficient, negative');
model.param.set('aC_neg', '0.5', 'Reaction rate coefficient, negative');
model.param.set('r0', '0.00176[m]', 'Spiral starting radius');
model.param.set('a1', '60e-6[m]', 'Positive porous electrode 1 thickness');
model.param.set('a2', '20e-6[m]', 'Positive current collector thickness');
model.param.set('a3', '60e-6[m]', 'Positive porous electrode 2 thickness');
model.param.set('a4', '30e-6[m]', 'Separator 1 thickness');
model.param.set('a5', '60e-6[m]', 'Negative porous electrode 1 thickness');
model.param.set('a6', '14e-6[m]', 'Negative current collector thickness');
model.param.set('a7', '60e-6[m]', 'Negative porous electrode 2 thickness');
model.param.set('a8', '30e-6[m]', 'Separator 2 thickness');
model.param.set('D_tot', 'a1+a2+a3+a4+a5+a6+a7+a8', 'Total unit cell thickness');
model.param.set('laps', '3', 'Number of revolved laps in spiral');
model.param.set('w_tot', '2*pi*laps', 'Total revolved angel');
model.param.set('i_app_1C', '-3.3e4[A/m^2]', 'Applied current density at battery terminal at 1C');

model.func.create('an1', 'Analytic');
model.func('an1').set('funcname', 'spiralX');
model.func('an1').set('expr', '-(s/(2*pi)*D_tot+R)*sin(s)');
model.func('an1').set('args', 's, R');
model.func('an1').setIndex('argunit', 1, 0);
model.func('an1').setIndex('argunit', 'm', 1);
model.func('an1').set('fununit', 'm');
model.func.duplicate('an2', 'an1');
model.func('an2').set('funcname', 'spiralY');
model.func('an2').set('expr', '-(s/(2*pi)*D_tot+R)*cos(s)');

model.geom('geom1').create('pc1', 'ParametricCurve');
model.geom('geom1').feature('pc1').set('parmax', 'w_tot+2*pi');
model.geom('geom1').feature('pc1').set('coord', {'spiralX(s,r0)' ''});
model.geom('geom1').feature('pc1').setIndex('coord', 'spiralY(s,r0)', 1);
model.geom('geom1').run('pc1');
model.geom('geom1').feature.duplicate('pc2', 'pc1');
model.geom('geom1').feature('pc2').setIndex('coord', 'spiralX(s,r0+a1)', 0);
model.geom('geom1').feature('pc2').setIndex('coord', 'spiralY(s,r0+a1)', 1);
model.geom('geom1').run('pc2');
model.geom('geom1').feature.duplicate('pc3', 'pc2');
model.geom('geom1').feature('pc3').setIndex('coord', 'spiralX(s,r0+a1+a2)', 0);
model.geom('geom1').feature('pc3').setIndex('coord', 'spiralY(s,r0+a1+a2)', 1);
model.geom('geom1').run('pc3');
model.geom('geom1').feature.duplicate('pc4', 'pc3');
model.geom('geom1').feature('pc4').setIndex('coord', 'spiralX(s,r0+a1+a2+a3)', 0);
model.geom('geom1').feature('pc4').setIndex('coord', 'spiralY(s,r0+a1+a2+a3)', 1);
model.geom('geom1').run('pc4');
model.geom('geom1').feature.duplicate('pc5', 'pc4');
model.geom('geom1').feature('pc5').setIndex('coord', 'spiralX(s,r0+a1+a2+a3+a4)', 0);
model.geom('geom1').feature('pc5').setIndex('coord', 'spiralY(s,r0+a1+a2+a3+a4)', 1);
model.geom('geom1').run('pc5');
model.geom('geom1').feature.duplicate('pc6', 'pc5');
model.geom('geom1').feature('pc6').setIndex('coord', 'spiralX(s,r0+a1+a2+a3+a4+a5)', 0);
model.geom('geom1').feature('pc6').setIndex('coord', 'spiralY(s,r0+a1+a2+a3+a4+a5)', 1);
model.geom('geom1').run('pc6');
model.geom('geom1').feature.duplicate('pc7', 'pc6');
model.geom('geom1').feature('pc7').setIndex('coord', 'spiralX(s,r0+a1+a2+a3+a4+a5+a6)', 0);
model.geom('geom1').feature('pc7').setIndex('coord', 'spiralY(s,r0+a1+a2+a3+a4+a5+a6)', 1);
model.geom('geom1').run('pc7');
model.geom('geom1').feature.duplicate('pc8', 'pc7');
model.geom('geom1').feature('pc8').setIndex('coord', 'spiralX(s,r0+a1+a2+a3+a4+a5+a6+a7)', 0);
model.geom('geom1').feature('pc8').setIndex('coord', 'spiralY(s,r0+a1+a2+a3+a4+a5+a6+a7)', 1);
model.geom('geom1').run('pc8');
model.geom('geom1').create('pc9', 'ParametricCurve');
model.geom('geom1').feature('pc9').set('parmax', 'D_tot*(laps+1)');
model.geom('geom1').feature('pc9').set('coord', {'0' '-(s+r0)'});
model.geom('geom1').run('pc9');
model.geom('geom1').create('csol1', 'ConvertToSolid');
model.geom('geom1').feature('csol1').selection('input').set({'pc1' 'pc2' 'pc3' 'pc4' 'pc5' 'pc6' 'pc7' 'pc8' 'pc9'});
model.geom('geom1').run('csol1');
model.geom('geom1').create('c1', 'Circle');
model.geom('geom1').feature('c1').set('r', 'D_tot*(laps+1.25)+r0');
model.geom('geom1').feature('c1').set('pos', {'D_tot/4' '-D_tot/4'});
model.geom('geom1').runPre('fin');

model.selection.create('sel1', 'Explicit');
model.selection('sel1').model('comp1');

model.geom('geom1').run;

model.selection('sel1').label('Positive current collector');
model.selection('sel1').set([8 16 24]);
model.selection.create('sel2', 'Explicit');
model.selection('sel2').model('comp1');
model.selection('sel2').label('Negative current collector');
model.selection('sel2').set([4 12 20]);
model.selection.create('sel3', 'Explicit');
model.selection('sel3').model('comp1');
model.selection('sel3').label('Positive porous electrode');
model.selection('sel3').set([7 9 15 17 23 25]);
model.selection.create('sel4', 'Explicit');
model.selection('sel4').model('comp1');
model.selection('sel4').label('Negative porous electrode');
model.selection('sel4').set([3 5 11 13 19 21]);
model.selection.create('sel5', 'Explicit');
model.selection('sel5').model('comp1');
model.selection('sel5').label('Electrolyte');
model.selection('sel5').set([2 6 10 14 18 22]);
model.selection.create('sel6', 'Explicit');
model.selection('sel6').model('comp1');
model.selection('sel6').label('Negative terminal');
model.selection('sel6').geom(1);
model.selection('sel6').set([9]);
model.selection.create('sel7', 'Explicit');
model.selection('sel7').model('comp1');
model.selection('sel7').label('Positive terminal');
model.selection('sel7').geom(1);
model.selection('sel7').set([60]);
model.selection.create('sel8', 'Explicit');
model.selection('sel8').model('comp1');
model.selection('sel8').label('Electrolyte outside');
model.selection('sel8').set([1 26]);
model.selection.create('uni1', 'Union');
model.selection('uni1').model('comp1');
model.selection('uni1').label('Spiral battery');
model.selection('uni1').set('input', {'sel1' 'sel2' 'sel3' 'sel4' 'sel5'});
model.selection.create('uni2', 'Union');
model.selection('uni2').model('comp1');
model.selection('uni2').label('Positive + Electrolyte + Negative');
model.selection('uni2').set('input', {'sel3' 'sel4' 'sel5' 'sel8'});

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
model.material('mat1').selection.named('sel1');
model.material('mat2').selection.named('sel2');
model.material.create('mat3', 'Common', 'comp1');
model.material('mat3').propertyGroup.create('ElectrolyteConductivity', 'Electrolyte conductivity');
model.material('mat3').propertyGroup('ElectrolyteConductivity').func.create('int1', 'Interpolation');
model.material('mat3').propertyGroup.create('SpeciesProperties', 'Species properties');
model.material('mat3').propertyGroup.create('ElectrolyteSaltConcentration', 'Electrolyte salt concentration');
model.material('mat3').label('LiPF6 in 1:2 EC:DMC and p(VdF-HFP) (Polymer, Li-ion Battery)');
model.material('mat3').comments([ newline ]);
model.material('mat3').propertyGroup('def').set('diffusion', {'7.5e-11[m^2/s]' '0' '0' '0' '7.5e-11[m^2/s]' '0' '0' '0' '7.5e-11[m^2/s]'});
model.material('mat3').propertyGroup('def').set('INFO_PREFIX:diffusion', ['M. Doyle, J. Newman, A.S. Gozdz, C.N. Schmutz, and J.M. Tarascon, ' native2unicode(hex2dec({'20' '1c'}), 'unicode') 'Comparison of Modeling Predictions with Experimental Data from Plastic Lithium Ion Cells,' native2unicode(hex2dec({'20' '1d'}), 'unicode') ' J. Electrochem. Soc., vol. 143, p. 1890, 1996.' newline ]);
model.material('mat3').propertyGroup('ElectrolyteConductivity').func('int1').set('funcname', 'sigmal_int1');
model.material('mat3').propertyGroup('ElectrolyteConductivity').func('int1').set('table', {'0' '0.0108';  ...
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
model.material('mat3').propertyGroup('ElectrolyteConductivity').func('int1').set('fununit', {''});
model.material('mat3').propertyGroup('ElectrolyteConductivity').func('int1').set('argunit', {''});
model.material('mat3').propertyGroup('ElectrolyteConductivity').set('sigmal', {'sigmal_int1(c/c_ref)' '0' '0' '0' 'sigmal_int1(c/c_ref)' '0' '0' '0' 'sigmal_int1(c/c_ref)'});
model.material('mat3').propertyGroup('ElectrolyteConductivity').set('INFO_PREFIX:sigmal', ['M. Doyle, J. Newman, A.S. Gozdz, C.N. Schmutz, and J.M. Tarascon, ' native2unicode(hex2dec({'20' '1c'}), 'unicode') 'Comparison of Modeling Predictions with Experimental Data from Plastic Lithium Ion Cells,' native2unicode(hex2dec({'20' '1d'}), 'unicode') ' J. Electrochem. Soc., vol. 143, p. 1890, 1996.' newline ]);
model.material('mat3').propertyGroup('ElectrolyteConductivity').set('c_ref', '1000[mol/m^3]');
model.material('mat3').propertyGroup('ElectrolyteConductivity').descr('c_ref', '');
model.material('mat3').propertyGroup('ElectrolyteConductivity').addInput('concentration');
model.material('mat3').propertyGroup('SpeciesProperties').set('transpNum', '0.363');
model.material('mat3').propertyGroup('SpeciesProperties').set('INFO_PREFIX:transpNum', ['M. Doyle, J. Newman, A.S. Gozdz, C.N. Schmutz, and J.M. Tarascon, ' native2unicode(hex2dec({'20' '1c'}), 'unicode') 'Comparison of Modeling Predictions with Experimental Data from Plastic Lithium Ion Cells,' native2unicode(hex2dec({'20' '1d'}), 'unicode') ' J. Electrochem. Soc., vol. 143, p. 1890, 1996.' newline ]);
model.material('mat3').propertyGroup('SpeciesProperties').set('fcl', '0');
model.material('mat3').propertyGroup('SpeciesProperties').set('INFO_PREFIX:fcl', ['M. Doyle, J. Newman, A.S. Gozdz, C.N. Schmutz, and J.M. Tarascon, ' native2unicode(hex2dec({'20' '1c'}), 'unicode') 'Comparison of Modeling Predictions with Experimental Data from Plastic Lithium Ion Cells,' native2unicode(hex2dec({'20' '1d'}), 'unicode') ' J. Electrochem. Soc., vol. 143, p. 1890, 1996.' newline ]);
model.material('mat3').propertyGroup('ElectrolyteSaltConcentration').identifier('cElsalt');
model.material('mat3').propertyGroup('ElectrolyteSaltConcentration').set('cElsalt', '1000[mol/m^3]');
model.material('mat3').propertyGroup('ElectrolyteSaltConcentration').set('INFO_PREFIX:cElsalt', ['M. Doyle, J. Newman, A.S. Gozdz, C.N. Schmutz, and J.M. Tarascon, ' native2unicode(hex2dec({'20' '1c'}), 'unicode') 'Comparison of Modeling Predictions with Experimental Data from Plastic Lithium Ion Cells,' native2unicode(hex2dec({'20' '1d'}), 'unicode') ' J. Electrochem. Soc., vol. 143, p. 1890, 1996.' newline ]);
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
model.material('mat5').propertyGroup.create('ElectrodePotential', 'Equilibrium potential');
model.material('mat5').propertyGroup('ElectrodePotential').func.create('int1', 'Interpolation');
model.material('mat5').propertyGroup('ElectrodePotential').func.create('int2', 'Interpolation');
model.material('mat5').propertyGroup.create('OperationalSOC', 'Operational electrode state of charge');
model.material('mat5').propertyGroup.create('EquilibriumConcentration', 'Equilibrium concentration');
model.material('mat5').label('LMO, LiMn2O4 Spinel (Positive, Li-ion Battery)');
model.material('mat5').propertyGroup('def').set('youngsmodulus', '');
model.material('mat5').propertyGroup('def').set('poissonsratio', '');
model.material('mat5').propertyGroup('def').set('youngsmodulus', '194[GPa]');
model.material('mat5').propertyGroup('def').set('INFO_PREFIX:youngsmodulus', 'Yue Qi et al 2014 J. Electrochem. Soc. 161 F3010');
model.material('mat5').propertyGroup('def').set('poissonsratio', '0.26');
model.material('mat5').propertyGroup('def').set('INFO_PREFIX:poissonsratio', 'Yue Qi et al 2014 J. Electrochem. Soc. 161 F3010');
model.material('mat5').propertyGroup('def').set('electricconductivity', {'3.8[S/m]' '0' '0' '0' '3.8[S/m]' '0' '0' '0' '3.8[S/m]'});
model.material('mat5').propertyGroup('def').set('INFO_PREFIX:electricconductivity', 'V. Srinivasan and C.Y. Wang, "Analysis of Electrochemical and Thermal Behavior of Li-Ion Cells," J. Electrochem. Soc., vol. 150, p. A98, 2003');
model.material('mat5').propertyGroup('def').set('diffusion', {'1e-14*exp(20000/8.314*(1/(T_ref/1[K])-1/(T2/1[K])))[m^2/s]' '0' '0' '0' '1e-14*exp(20000/8.314*(1/(T_ref/1[K])-1/(T2/1[K])))[m^2/s]' '0' '0' '0' '1e-14*exp(20000/8.314*(1/(T_ref/1[K])-1/(T2/1[K])))[m^2/s]'});
model.material('mat5').propertyGroup('def').set('INFO_PREFIX:diffusion', 'V. Srinivasan and C.Y. Wang, "Analysis of Electrochemical and Thermal Behavior of Li-Ion Cells," J. Electrochem. Soc., vol. 150, p. A98, 2003');
model.material('mat5').propertyGroup('def').set('density', '4140[kg/m^3]');
model.material('mat5').propertyGroup('def').set('INFO_PREFIX:density', 'N. Nitta, F. Wu, J. Tae Lee, and G. Yushin, Materials Today, Volume 18, Number 5, June 2015');
model.material('mat5').propertyGroup('def').set('T_ref', '298[K]');
model.material('mat5').propertyGroup('def').descr('T_ref', '');
model.material('mat5').propertyGroup('def').set('T2', 'min(393.15,max(T,223.15))');
model.material('mat5').propertyGroup('def').descr('T2', '');
model.material('mat5').propertyGroup('def').set('csmax', '22860[mol/m^3]');
model.material('mat5').propertyGroup('def').descr('csmax', '');
model.material('mat5').propertyGroup('def').addInput('temperature');
model.material('mat5').propertyGroup('ElectrodePotential').func('int1').set('funcname', 'Eeq_int1');
model.material('mat5').propertyGroup('ElectrodePotential').func('int1').set('table', {'0.1750' '4.2763';  ...
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
model.material('mat5').propertyGroup('ElectrodePotential').func('int1').set('interp', 'piecewisecubic');
model.material('mat5').propertyGroup('ElectrodePotential').func('int1').set('extrap', 'linear');
model.material('mat5').propertyGroup('ElectrodePotential').func('int1').set('fununit', {'V'});
model.material('mat5').propertyGroup('ElectrodePotential').func('int1').set('argunit', {''});
model.material('mat5').propertyGroup('ElectrodePotential').func('int1').set('defineinv', true);
model.material('mat5').propertyGroup('ElectrodePotential').func('int1').set('funcinvname', 'Eeq_inv');
model.material('mat5').propertyGroup('ElectrodePotential').func('int2').set('funcname', 'dEeqdT_int1');
model.material('mat5').propertyGroup('ElectrodePotential').func('int2').set('table', {'0.15' '0.15e-3';  ...
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
model.material('mat5').propertyGroup('ElectrodePotential').func('int2').set('interp', 'piecewisecubic');
model.material('mat5').propertyGroup('ElectrodePotential').func('int2').set('fununit', {'V/K'});
model.material('mat5').propertyGroup('ElectrodePotential').func('int2').set('argunit', {''});
model.material('mat5').propertyGroup('ElectrodePotential').set('Eeq', 'Eeq_int1(soc)+dEeqdT_int1(soc)*(T-298[K])');
model.material('mat5').propertyGroup('ElectrodePotential').set('INFO_PREFIX:Eeq', 'V. Srinivasan and C.Y. Wang, "Analysis of Electrochemical and Thermal Behavior of Li-Ion Cells," J. Electrochem. Soc., vol. 150, p. A98, 2003');
model.material('mat5').propertyGroup('ElectrodePotential').set('dEeqdT', 'dEeqdT_int1(soc)');
model.material('mat5').propertyGroup('ElectrodePotential').set('INFO_PREFIX:dEeqdT', 'V. Srinivasan and C.Y. Wang, "Analysis of Electrochemical and Thermal Behavior of Li-Ion Cells," J. Electrochem. Soc., vol. 150, p. A98, 2003');
model.material('mat5').propertyGroup('ElectrodePotential').set('cEeqref', 'def.csmax');
model.material('mat5').propertyGroup('ElectrodePotential').set('INFO_PREFIX:cEeqref', 'V. Srinivasan and C.Y. Wang, "Analysis of Electrochemical and Thermal Behavior of Li-Ion Cells," J. Electrochem. Soc., vol. 150, p. A98, 2003');
model.material('mat5').propertyGroup('ElectrodePotential').set('soc', 'c/cEeqref');
model.material('mat5').propertyGroup('ElectrodePotential').descr('soc', '');
model.material('mat5').propertyGroup('ElectrodePotential').addInput('concentration');
model.material('mat5').propertyGroup('ElectrodePotential').addInput('temperature');
model.material('mat5').propertyGroup('OperationalSOC').set('socmax', 'elpot.Eeq_inv(E_min)');
model.material('mat5').propertyGroup('OperationalSOC').set('socmin', 'elpot.Eeq_inv(E_max)');
model.material('mat5').propertyGroup('OperationalSOC').set('E_max', '4.2[V]');
model.material('mat5').propertyGroup('OperationalSOC').set('E_min', '3.9[V]');
model.material('mat5').propertyGroup('EquilibriumConcentration').set('csEq', 'def.csmax*elpot.Eeq_inv(V)');
model.material('mat5').propertyGroup('EquilibriumConcentration').addInput('electricpotential');
model.material('mat3').selection.named('uni2');

model.physics('liion').feature('sep1').set('epsl', 1);
model.physics('liion').create('pce1', 'PorousElectrode', 2);
model.physics('liion').feature('pce1').selection.named('sel4');
model.physics('liion').feature('pce1').set('sigma', {'sigmas_neg' '0' '0' '0' 'sigmas_neg' '0' '0' '0' 'sigmas_neg'});
model.physics('liion').feature('pce1').set('epss', 'epss_neg');
model.physics('liion').feature('pce1').set('epsl', 'epsl_neg');
model.physics('liion').feature('pce1').feature('pin1').set('ParticleMaterial', 'mat4');
model.physics('liion').feature('pce1').feature('pin1').set('csinit', 'cs0_neg');
model.physics('liion').feature('pce1').feature('pin1').set('rp', 'rp_neg');
model.physics('liion').feature('pce1').feature('pin1').set('Nel', 3);
model.physics('liion').feature('pce1').feature('per1').set('MaterialOption', 'mat4');
model.physics('liion').feature('pce1').feature('per1').set('i0_ref', 'i0ref_neg');
model.physics('liion').feature('pce1').feature('per1').set('alphaa', 'aA_neg');
model.physics('liion').feature('pce1').feature('per1').set('alphac', 'aC_neg');
model.physics('liion').create('pce2', 'PorousElectrode', 2);
model.physics('liion').feature('pce2').selection.named('sel3');
model.physics('liion').feature('pce2').set('sigma', {'sigmas_pos' '0' '0' '0' 'sigmas_pos' '0' '0' '0' 'sigmas_pos'});
model.physics('liion').feature('pce2').set('epss', 'epss_pos');
model.physics('liion').feature('pce2').set('epsl', 'epsl_pos');
model.physics('liion').feature('pce2').feature('pin1').set('ParticleMaterial', 'mat5');
model.physics('liion').feature('pce2').feature('pin1').set('csinit', 'cs0_pos');
model.physics('liion').feature('pce2').feature('pin1').set('rp', 'rp_pos');
model.physics('liion').feature('pce2').feature('pin1').set('Nel', 5);
model.physics('liion').feature('pce2').feature('per1').set('MaterialOption', 'mat5');
model.physics('liion').feature('pce2').feature('per1').set('i0_ref', 'i0ref_pos');
model.physics('liion').feature('pce2').feature('per1').set('alphaa', 'aA_pos');
model.physics('liion').feature('pce2').feature('per1').set('alphac', 'aC_pos');
model.physics('liion').create('cc1', 'CurrentConductor', 2);
model.physics('liion').feature('cc1').selection.named('sel2');
model.physics('liion').create('cc2', 'CurrentConductor', 2);
model.physics('liion').feature('cc2').selection.named('sel1');
model.physics('liion').create('egnd1', 'ElectricGround', 1);
model.physics('liion').feature('egnd1').selection.named('sel6');
model.physics('liion').create('ecd1', 'ElectrodeNormalCurrentDensity', 1);
model.physics('liion').feature('ecd1').label('Electrode Current Density - 1C Discharge');
model.physics('liion').feature('ecd1').selection.named('sel7');
model.physics('liion').feature('ecd1').set('nis', 'i_app_1C');
model.physics('liion').feature.duplicate('ecd2', 'ecd1');
model.physics('liion').feature('ecd2').label('Electrode Current Density - 10C Discharge');
model.physics('liion').feature('ecd2').set('nis', '10*i_app_1C');
model.physics('liion').prop('ShapeProperty').set('order_electricpotentialionicphase', 1);
model.physics('liion').prop('ShapeProperty').set('order_concentration', 1);
model.physics('liion').prop('ShapeProperty').set('order_electricpotential', 1);

model.mesh('mesh1').create('edg1', 'Edge');
model.mesh('mesh1').feature('edg1').selection.set([9 17]);
model.mesh('mesh1').feature('edg1').create('dis1', 'Distribution');
model.mesh('mesh1').feature('edg1').feature('dis1').set('numelem', 1);
model.mesh('mesh1').create('edg2', 'Edge');
model.mesh('mesh1').feature('edg2').selection.set([5 13]);
model.mesh('mesh1').feature('edg2').create('dis1', 'Distribution');
model.mesh('mesh1').feature('edg2').feature('dis1').set('numelem', 4);
model.mesh('mesh1').create('edg3', 'Edge');
model.mesh('mesh1').feature('edg3').selection.set([11 19]);
model.mesh('mesh1').feature('edg3').create('dis1', 'Distribution');
model.mesh('mesh1').feature('edg3').feature('dis1').set('numelem', 10);
model.mesh('mesh1').create('edg4', 'Edge');
model.mesh('mesh1').feature('edg4').selection.set([7 15]);
model.mesh('mesh1').feature('edg4').create('dis1', 'Distribution');
model.mesh('mesh1').feature('edg4').feature('dis1').set('numelem', 6);
model.mesh('mesh1').create('edg5', 'Edge');
model.mesh('mesh1').feature('edg5').selection.set([6 8 10 12 14 16 18 20 22 24 26 28 30 32 34 36 38 40 42 44 46 48 50 52 54]);
model.mesh('mesh1').feature('edg5').create('dis1', 'Distribution');
model.mesh('mesh1').feature('edg5').feature('dis1').set('type', 'explicit');
model.mesh('mesh1').feature('edg5').feature('dis1').set('explicit', '0 5e-5 10^range(-4,0.25,-2) range(2e-2,1e-2,0.98) (1-10^range(-2,-0.25,-4)) 0.99995 1');
model.mesh('mesh1').create('map1', 'Map');
model.mesh('mesh1').feature('map1').selection.geom('geom1', 2);
model.mesh('mesh1').feature('map1').selection.named('uni1');
model.mesh('mesh1').create('ftri1', 'FreeTri');
model.mesh('mesh1').run;

model.probe.create('bnd1', 'Boundary');
model.probe('bnd1').model('comp1');
model.probe('bnd1').set('intsurface', true);
model.probe('bnd1').label('Cell Voltage Probe - Study 1');
model.probe('bnd1').selection.named('sel7');
model.probe('bnd1').set('expr', 'phis');
model.probe('bnd1').set('descr', 'Electric potential');

model.study('std1').feature('time').set('tlist', 'range(0,300,1800)');
model.study('std1').feature('time').set('useadvanceddisable', true);
model.study('std1').feature('time').set('disabledphysics', {'liion/ecd2'});
model.study('std1').label('Study 1 - 1 C Discharge');

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
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('pr').create('sc1', 'SCGS');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('pr').feature('sc1').set('linesweeptype', 'ssor');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('pr').feature('sc1').set('iter', 1);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('pr').feature('sc1').set('scgsmethod', 'lines');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('po').create('sc1', 'SCGS');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('po').feature('sc1').set('linesweeptype', 'ssor');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('po').feature('sc1').set('iter', 1);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('po').feature('sc1').set('scgsmethod', 'lines');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('cs').create('d1', 'Direct');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('cs').feature('d1').set('linsolver', 'pardiso');
model.sol('sol1').feature('s1').create('i2', 'Iterative');
model.sol('sol1').feature('s1').feature('i2').set('maxlinit', 1000);
model.sol('sol1').feature('s1').feature('i2').set('nlinnormuse', 'on');
model.sol('sol1').feature('s1').feature('i2').label('Geometric Multigrid (liion)');
model.sol('sol1').feature('s1').feature('i2').create('mg1', 'Multigrid');
model.sol('sol1').feature('s1').feature('i2').feature('mg1').feature('pr').create('sc1', 'SCGS');
model.sol('sol1').feature('s1').feature('i2').feature('mg1').feature('pr').feature('sc1').set('linesweeptype', 'ssor');
model.sol('sol1').feature('s1').feature('i2').feature('mg1').feature('pr').feature('sc1').set('iter', 1);
model.sol('sol1').feature('s1').feature('i2').feature('mg1').feature('pr').feature('sc1').set('scgsmethod', 'lines');
model.sol('sol1').feature('s1').feature('i2').feature('mg1').feature('po').create('sc1', 'SCGS');
model.sol('sol1').feature('s1').feature('i2').feature('mg1').feature('po').feature('sc1').set('linesweeptype', 'ssor');
model.sol('sol1').feature('s1').feature('i2').feature('mg1').feature('po').feature('sc1').set('iter', 1);
model.sol('sol1').feature('s1').feature('i2').feature('mg1').feature('po').feature('sc1').set('scgsmethod', 'lines');
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
model.sol('sol1').feature('t1').set('tlist', 'range(0,300,1800)');
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
model.sol('sol1').feature('t1').set('initialstepbdfactive', true);
model.sol('sol1').feature('t1').set('initialstepbdf', '(1)[s]');
model.sol('sol1').feature('t1').set('control', 'time');
model.sol('sol1').feature('t1').feature('aDef').set('cachepattern', true);
model.sol('sol1').feature('t1').create('se1', 'Segregated');
model.sol('sol1').feature('t1').feature('se1').feature.remove('ssDef');
model.sol('sol1').feature('t1').feature('se1').create('ss1', 'SegregatedStep');
model.sol('sol1').feature('t1').feature('se1').feature('ss1').set('segvar', {'comp1_phil' 'comp1_cl' 'comp1_phis'});
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
model.sol('sol1').feature('t1').feature('se1').create('ss3', 'SegregatedStep');
model.sol('sol1').feature('t1').feature('se1').feature('ss3').set('segvar', {'comp1_liion_pce2_cs'});
model.sol('sol1').feature('t1').feature('se1').feature('ss3').set('linsolver', 'd1');
model.sol('sol1').feature('t1').feature('se1').feature('ss3').label('Insertion Particle Concentration Variables (2)');
model.sol('sol1').feature('t1').create('i1', 'Iterative');
model.sol('sol1').feature('t1').feature('i1').set('maxlinit', 1000);
model.sol('sol1').feature('t1').feature('i1').set('nlinnormuse', 'on');
model.sol('sol1').feature('t1').feature('i1').label('Algebraic Multigrid (liion)');
model.sol('sol1').feature('t1').feature('i1').create('mg1', 'Multigrid');
model.sol('sol1').feature('t1').feature('i1').feature('mg1').set('prefun', 'saamg');
model.sol('sol1').feature('t1').feature('i1').feature('mg1').set('maxcoarsedof', 50000);
model.sol('sol1').feature('t1').feature('i1').feature('mg1').set('saamgcompwise', true);
model.sol('sol1').feature('t1').feature('i1').feature('mg1').set('compactaggregation', true);
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('pr').create('sc1', 'SCGS');
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('pr').feature('sc1').set('linesweeptype', 'ssor');
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('pr').feature('sc1').set('iter', 1);
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('pr').feature('sc1').set('scgsmethod', 'lines');
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('po').create('sc1', 'SCGS');
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('po').feature('sc1').set('linesweeptype', 'ssor');
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('po').feature('sc1').set('iter', 1);
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('po').feature('sc1').set('scgsmethod', 'lines');
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('cs').create('d1', 'Direct');
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('cs').feature('d1').set('linsolver', 'pardiso');
model.sol('sol1').feature('t1').create('i2', 'Iterative');
model.sol('sol1').feature('t1').feature('i2').set('maxlinit', 1000);
model.sol('sol1').feature('t1').feature('i2').set('nlinnormuse', 'on');
model.sol('sol1').feature('t1').feature('i2').label('Geometric Multigrid (liion)');
model.sol('sol1').feature('t1').feature('i2').create('mg1', 'Multigrid');
model.sol('sol1').feature('t1').feature('i2').feature('mg1').feature('pr').create('sc1', 'SCGS');
model.sol('sol1').feature('t1').feature('i2').feature('mg1').feature('pr').feature('sc1').set('linesweeptype', 'ssor');
model.sol('sol1').feature('t1').feature('i2').feature('mg1').feature('pr').feature('sc1').set('iter', 1);
model.sol('sol1').feature('t1').feature('i2').feature('mg1').feature('pr').feature('sc1').set('scgsmethod', 'lines');
model.sol('sol1').feature('t1').feature('i2').feature('mg1').feature('po').create('sc1', 'SCGS');
model.sol('sol1').feature('t1').feature('i2').feature('mg1').feature('po').feature('sc1').set('linesweeptype', 'ssor');
model.sol('sol1').feature('t1').feature('i2').feature('mg1').feature('po').feature('sc1').set('iter', 1);
model.sol('sol1').feature('t1').feature('i2').feature('mg1').feature('po').feature('sc1').set('scgsmethod', 'lines');
model.sol('sol1').feature('t1').feature('i2').feature('mg1').feature('cs').create('d1', 'Direct');
model.sol('sol1').feature('t1').feature('i2').feature('mg1').feature('cs').feature('d1').set('linsolver', 'pardiso');
model.sol('sol1').feature('t1').feature.remove('fcDef');
model.sol('sol1').attach('std1');

model.probe('bnd1').genResult('none');

model.sol('sol1').runAll;

model.result.create('pg2', 'PlotGroup1D');
model.result('pg2').set('data', 'dset1');
model.result('pg2').create('glob1', 'Global');
model.result('pg2').feature('glob1').set('unit', {'' ''});
model.result('pg2').feature('glob1').set('expr', {'liion.soc_average_pce1' 'liion.soc_average_pce2'});
model.result('pg2').feature('glob1').set('descr', {'Average SOC, Porous Electrode 1' 'Average SOC, Porous Electrode 2'});
model.result('pg2').label('Average Electrode State of Charge (liion)');
model.result('pg2').feature('glob1').set('xdatasolnumtype', 'level1');
model.result.create('pg3', 'PlotGroup2D');
model.result('pg3').set('data', 'dset1');
model.result('pg3').setIndex('looplevel', 7, 0);
model.result('pg3').label('Electrolyte Potential (liion)');
model.result('pg3').create('surf1', 'Surface');
model.result('pg3').feature('surf1').set('expr', {'phil'});
model.result('pg3').create('arws1', 'ArrowSurface');
model.result('pg3').feature('arws1').set('expr', {'liion.Ilx' 'liion.Ily'});
model.result('pg3').feature('arws1').set('arrowbase', 'center');
model.result('pg3').feature('arws1').set('color', 'gray');
model.result.create('pg4', 'PlotGroup2D');
model.result('pg4').set('data', 'dset1');
model.result('pg4').setIndex('looplevel', 7, 0);
model.result('pg4').label('Electrolyte Current Density (liion)');
model.result('pg4').create('arws1', 'ArrowSurface');
model.result('pg4').feature('arws1').set('expr', {'liion.Ilx' 'liion.Ily'});
model.result('pg4').feature('arws1').set('arrowbase', 'center');
model.result('pg4').feature('arws1').set('color', 'gray');
model.result('pg4').feature('arws1').create('col1', 'Color');
model.result('pg4').feature('arws1').feature('col1').set('expr', 'root.comp1.liion.IlMag');
model.result.create('pg5', 'PlotGroup2D');
model.result('pg5').set('data', 'dset1');
model.result('pg5').setIndex('looplevel', 7, 0);
model.result('pg5').label('Electrode Potential with Respect to Ground (liion)');
model.result('pg5').create('surf1', 'Surface');
model.result('pg5').feature('surf1').set('expr', {'phis'});
model.result('pg5').create('arws1', 'ArrowSurface');
model.result('pg5').feature('arws1').set('expr', {'liion.Isx' 'liion.Isy'});
model.result('pg5').feature('arws1').set('arrowbase', 'center');
model.result('pg5').feature('arws1').set('color', 'gray');
model.result.create('pg6', 'PlotGroup2D');
model.result('pg6').set('data', 'dset1');
model.result('pg6').setIndex('looplevel', 7, 0);
model.result('pg6').label('Electrode Current Density (liion)');
model.result('pg6').create('arws1', 'ArrowSurface');
model.result('pg6').feature('arws1').set('expr', {'liion.Isx' 'liion.Isy'});
model.result('pg6').feature('arws1').set('arrowbase', 'center');
model.result('pg6').feature('arws1').set('color', 'gray');
model.result('pg6').feature('arws1').create('col1', 'Color');
model.result('pg6').feature('arws1').feature('col1').set('expr', 'root.comp1.liion.IsMag');
model.result.create('pg7', 'PlotGroup2D');
model.result('pg7').set('data', 'dset1');
model.result('pg7').setIndex('looplevel', 7, 0);
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
model.result('pg2').run;
model.result('pg7').run;
model.result('pg7').set('titletype', 'label');
model.result('pg7').run;
model.result('pg7').feature('surf1').create('hght1', 'Height');
model.result('pg7').run;
model.result('pg7').run;
model.result('pg3').run;
model.result('pg3').set('titletype', 'label');
model.result('pg3').run;
model.result('pg3').feature('surf1').create('hght1', 'Height');
model.result('pg3').run;
model.result('pg3').run;
model.result('pg1').set('window', 'window1');
model.result('pg1').run;
model.result('pg1').label('Cell Voltage - Study 1');
model.result('pg1').set('window', 'window1');
model.result('pg1').run;
model.result.dataset.create('dset4', 'Solution');
model.result.dataset('dset4').selection.geom('geom1', 2);
model.result.dataset('dset4').selection.named('sel4');
model.result.dataset.create('dset5', 'Solution');
model.result.dataset('dset5').selection.geom('geom1', 2);
model.result.dataset('dset5').selection.named('sel3');
model.result.create('pg8', 'PlotGroup2D');
model.result('pg8').run;
model.result('pg8').label('Relative Li Concentration at Surface of Negative Electrode Particles');
model.result('pg8').set('titletype', 'label');
model.result('pg8').set('data', 'dset4');
model.result('pg8').create('surf1', 'Surface');
model.result('pg8').feature('surf1').set('expr', 'liion.socloc_surface');
model.result('pg8').feature('surf1').set('descr', 'Local electrode material state of charge, particle surface');
model.result('pg8').feature('surf1').create('hght1', 'Height');
model.result('pg8').run;
model.result('pg8').run;
model.result.create('pg9', 'PlotGroup2D');
model.result('pg9').run;
model.result('pg9').label('Relative Li Concentration at Surface of Positive Electrode Particles');
model.result('pg9').set('data', 'dset5');
model.result('pg9').set('titletype', 'label');
model.result('pg9').create('surf1', 'Surface');
model.result('pg9').feature('surf1').set('expr', 'liion.socloc_surface');
model.result('pg9').feature('surf1').set('descr', 'Local electrode material state of charge, particle surface');
model.result('pg9').feature('surf1').create('hght1', 'Height');
model.result('pg9').run;
model.result('pg9').run;

model.probe.duplicate('bnd2', 'bnd1');
model.probe('bnd2').label('Cell Voltage Probe - Study 2');
model.probe('bnd2').set('table', 'new');
model.probe('bnd2').set('window', 'new');

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
model.study('std2').feature('time').set('tlist', 'range(0,30,90) 105');
model.study('std2').feature('time').set('probesel', 'manual');
model.study('std2').feature('time').set('probes', {'bnd2'});
model.study('std2').feature('time').set('useadvanceddisable', true);
model.study('std2').feature('time').set('disabledphysics', {'liion/ecd1'});
model.study('std2').label('Study 2 - 10 C Discharge');
model.study('std2').setGenPlots(false);

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
model.sol('sol3').feature('s1').feature('i1').feature('mg1').feature('pr').create('sc1', 'SCGS');
model.sol('sol3').feature('s1').feature('i1').feature('mg1').feature('pr').feature('sc1').set('linesweeptype', 'ssor');
model.sol('sol3').feature('s1').feature('i1').feature('mg1').feature('pr').feature('sc1').set('iter', 1);
model.sol('sol3').feature('s1').feature('i1').feature('mg1').feature('pr').feature('sc1').set('scgsmethod', 'lines');
model.sol('sol3').feature('s1').feature('i1').feature('mg1').feature('po').create('sc1', 'SCGS');
model.sol('sol3').feature('s1').feature('i1').feature('mg1').feature('po').feature('sc1').set('linesweeptype', 'ssor');
model.sol('sol3').feature('s1').feature('i1').feature('mg1').feature('po').feature('sc1').set('iter', 1);
model.sol('sol3').feature('s1').feature('i1').feature('mg1').feature('po').feature('sc1').set('scgsmethod', 'lines');
model.sol('sol3').feature('s1').feature('i1').feature('mg1').feature('cs').create('d1', 'Direct');
model.sol('sol3').feature('s1').feature('i1').feature('mg1').feature('cs').feature('d1').set('linsolver', 'pardiso');
model.sol('sol3').feature('s1').create('i2', 'Iterative');
model.sol('sol3').feature('s1').feature('i2').set('maxlinit', 1000);
model.sol('sol3').feature('s1').feature('i2').set('nlinnormuse', 'on');
model.sol('sol3').feature('s1').feature('i2').label('Geometric Multigrid (liion)');
model.sol('sol3').feature('s1').feature('i2').create('mg1', 'Multigrid');
model.sol('sol3').feature('s1').feature('i2').feature('mg1').feature('pr').create('sc1', 'SCGS');
model.sol('sol3').feature('s1').feature('i2').feature('mg1').feature('pr').feature('sc1').set('linesweeptype', 'ssor');
model.sol('sol3').feature('s1').feature('i2').feature('mg1').feature('pr').feature('sc1').set('iter', 1);
model.sol('sol3').feature('s1').feature('i2').feature('mg1').feature('pr').feature('sc1').set('scgsmethod', 'lines');
model.sol('sol3').feature('s1').feature('i2').feature('mg1').feature('po').create('sc1', 'SCGS');
model.sol('sol3').feature('s1').feature('i2').feature('mg1').feature('po').feature('sc1').set('linesweeptype', 'ssor');
model.sol('sol3').feature('s1').feature('i2').feature('mg1').feature('po').feature('sc1').set('iter', 1);
model.sol('sol3').feature('s1').feature('i2').feature('mg1').feature('po').feature('sc1').set('scgsmethod', 'lines');
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
model.sol('sol3').feature('t1').set('tlist', 'range(0,30,90) 105');
model.sol('sol3').feature('t1').set('plot', 'off');
model.sol('sol3').feature('t1').set('plotgroup', 'Default');
model.sol('sol3').feature('t1').set('plotfreq', 'tout');
model.sol('sol3').feature('t1').set('probesel', 'manual');
model.sol('sol3').feature('t1').set('probes', {'bnd2'});
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
model.sol('sol3').feature('t1').create('se1', 'Segregated');
model.sol('sol3').feature('t1').feature('se1').feature.remove('ssDef');
model.sol('sol3').feature('t1').feature('se1').create('ss1', 'SegregatedStep');
model.sol('sol3').feature('t1').feature('se1').feature('ss1').set('segvar', {'comp1_phil' 'comp1_cl' 'comp1_phis'});
model.sol('sol3').feature('t1').feature('se1').feature('ss1').set('subjtech', 'onevery');
model.sol('sol3').feature('t1').create('d1', 'Direct');
model.sol('sol3').feature('t1').feature('d1').set('linsolver', 'pardiso');
model.sol('sol3').feature('t1').feature('d1').label('Direct (liion)');
model.sol('sol3').feature('t1').feature('se1').feature('ss1').set('linsolver', 'd1');
model.sol('sol3').feature('t1').feature('se1').feature('ss1').label('Battery Current Distribution');
model.sol('sol3').feature('t1').feature('se1').create('ss2', 'SegregatedStep');
model.sol('sol3').feature('t1').feature('se1').feature('ss2').set('segvar', {'comp1_liion_pce1_cs'});
model.sol('sol3').feature('t1').feature('se1').feature('ss2').set('linsolver', 'd1');
model.sol('sol3').feature('t1').feature('se1').feature('ss2').label('Insertion Particle Concentration Variables');
model.sol('sol3').feature('t1').feature('se1').create('ss3', 'SegregatedStep');
model.sol('sol3').feature('t1').feature('se1').feature('ss3').set('segvar', {'comp1_liion_pce2_cs'});
model.sol('sol3').feature('t1').feature('se1').feature('ss3').set('linsolver', 'd1');
model.sol('sol3').feature('t1').feature('se1').feature('ss3').label('Insertion Particle Concentration Variables (2)');
model.sol('sol3').feature('t1').create('i1', 'Iterative');
model.sol('sol3').feature('t1').feature('i1').set('maxlinit', 1000);
model.sol('sol3').feature('t1').feature('i1').set('nlinnormuse', 'on');
model.sol('sol3').feature('t1').feature('i1').label('Algebraic Multigrid (liion)');
model.sol('sol3').feature('t1').feature('i1').create('mg1', 'Multigrid');
model.sol('sol3').feature('t1').feature('i1').feature('mg1').set('prefun', 'saamg');
model.sol('sol3').feature('t1').feature('i1').feature('mg1').set('maxcoarsedof', 50000);
model.sol('sol3').feature('t1').feature('i1').feature('mg1').set('saamgcompwise', true);
model.sol('sol3').feature('t1').feature('i1').feature('mg1').set('compactaggregation', true);
model.sol('sol3').feature('t1').feature('i1').feature('mg1').feature('pr').create('sc1', 'SCGS');
model.sol('sol3').feature('t1').feature('i1').feature('mg1').feature('pr').feature('sc1').set('linesweeptype', 'ssor');
model.sol('sol3').feature('t1').feature('i1').feature('mg1').feature('pr').feature('sc1').set('iter', 1);
model.sol('sol3').feature('t1').feature('i1').feature('mg1').feature('pr').feature('sc1').set('scgsmethod', 'lines');
model.sol('sol3').feature('t1').feature('i1').feature('mg1').feature('po').create('sc1', 'SCGS');
model.sol('sol3').feature('t1').feature('i1').feature('mg1').feature('po').feature('sc1').set('linesweeptype', 'ssor');
model.sol('sol3').feature('t1').feature('i1').feature('mg1').feature('po').feature('sc1').set('iter', 1);
model.sol('sol3').feature('t1').feature('i1').feature('mg1').feature('po').feature('sc1').set('scgsmethod', 'lines');
model.sol('sol3').feature('t1').feature('i1').feature('mg1').feature('cs').create('d1', 'Direct');
model.sol('sol3').feature('t1').feature('i1').feature('mg1').feature('cs').feature('d1').set('linsolver', 'pardiso');
model.sol('sol3').feature('t1').create('i2', 'Iterative');
model.sol('sol3').feature('t1').feature('i2').set('maxlinit', 1000);
model.sol('sol3').feature('t1').feature('i2').set('nlinnormuse', 'on');
model.sol('sol3').feature('t1').feature('i2').label('Geometric Multigrid (liion)');
model.sol('sol3').feature('t1').feature('i2').create('mg1', 'Multigrid');
model.sol('sol3').feature('t1').feature('i2').feature('mg1').feature('pr').create('sc1', 'SCGS');
model.sol('sol3').feature('t1').feature('i2').feature('mg1').feature('pr').feature('sc1').set('linesweeptype', 'ssor');
model.sol('sol3').feature('t1').feature('i2').feature('mg1').feature('pr').feature('sc1').set('iter', 1);
model.sol('sol3').feature('t1').feature('i2').feature('mg1').feature('pr').feature('sc1').set('scgsmethod', 'lines');
model.sol('sol3').feature('t1').feature('i2').feature('mg1').feature('po').create('sc1', 'SCGS');
model.sol('sol3').feature('t1').feature('i2').feature('mg1').feature('po').feature('sc1').set('linesweeptype', 'ssor');
model.sol('sol3').feature('t1').feature('i2').feature('mg1').feature('po').feature('sc1').set('iter', 1);
model.sol('sol3').feature('t1').feature('i2').feature('mg1').feature('po').feature('sc1').set('scgsmethod', 'lines');
model.sol('sol3').feature('t1').feature('i2').feature('mg1').feature('cs').create('d1', 'Direct');
model.sol('sol3').feature('t1').feature('i2').feature('mg1').feature('cs').feature('d1').set('linsolver', 'pardiso');
model.sol('sol3').feature('t1').feature.remove('fcDef');
model.sol('sol3').attach('std2');

model.probe('bnd2').genResult('none');

model.sol('sol3').runAll;

model.result('pg3').run;
model.result('pg3').set('data', 'dset6');
model.result('pg3').run;
model.result('pg10').set('window', 'window2');
model.result('pg10').set('windowtitle', 'Probe Plot 2');
model.result('pg10').run;
model.result('pg10').label('Cell Voltage - Study 2');
model.result('pg7').run;
model.result('pg7').set('data', 'dset6');
model.result('pg7').run;
model.result.dataset('dset4').set('solution', 'sol3');
model.result.dataset('dset5').set('solution', 'sol3');
model.result('pg8').run;
model.result('pg8').run;
model.result('pg8').run;
model.result('pg9').run;
model.result('pg9').run;

model.probe.duplicate('bnd3', 'bnd2');
model.probe('bnd3').label('Cell Voltage Probe - Study 3');
model.probe('bnd3').set('table', 'new');
model.probe('bnd3').set('window', 'new');

model.study.create('std3');
model.study('std3').create('time', 'Transient');
model.study('std3').feature('time').setSolveFor('/physics/liion', true);
model.study('std3').feature('time').set('tlist', '0 10^range(-1,1,4)');
model.study('std3').feature('time').set('probesel', 'manual');
model.study('std3').feature('time').set('probes', {'bnd3'});
model.study('std3').feature('time').set('useadvanceddisable', true);
model.study('std3').feature('time').set('disabledphysics', {'liion/ecd1' 'liion/ecd2'});
model.study('std3').feature('time').set('useinitsol', true);
model.study('std3').feature('time').set('initmethod', 'sol');
model.study('std3').feature('time').set('initstudy', 'std1');
model.study('std3').label('Study 3 - Relaxation after 1C Discharge');
model.study('std3').setGenPlots(false);

model.sol.create('sol5');
model.sol('sol5').study('std3');
model.sol('sol5').create('st1', 'StudyStep');
model.sol('sol5').feature('st1').set('study', 'std3');
model.sol('sol5').feature('st1').set('studystep', 'time');
model.sol('sol5').create('v1', 'Variables');
model.sol('sol5').feature('v1').feature('comp1_phil').set('scalemethod', 'manual');
model.sol('sol5').feature('v1').feature('comp1_liion_pce2_cs').set('scalemethod', 'manual');
model.sol('sol5').feature('v1').feature('comp1_liion_pce1_cs').set('scalemethod', 'manual');
model.sol('sol5').feature('v1').feature('comp1_phis').set('scalemethod', 'manual');
model.sol('sol5').feature('v1').feature('comp1_cl').set('scalemethod', 'manual');
model.sol('sol5').feature('v1').feature('comp1_phil').set('scaleval', '1');
model.sol('sol5').feature('v1').feature('comp1_liion_pce2_cs').set('scaleval', '10000');
model.sol('sol5').feature('v1').feature('comp1_liion_pce1_cs').set('scaleval', '10000');
model.sol('sol5').feature('v1').feature('comp1_phis').set('scaleval', '1');
model.sol('sol5').feature('v1').feature('comp1_cl').set('scaleval', '1000');
model.sol('sol5').feature('v1').set('control', 'time');
model.sol('sol5').create('t1', 'Time');
model.sol('sol5').feature('t1').set('tlist', '0 10^range(-1,1,4)');
model.sol('sol5').feature('t1').set('plot', 'off');
model.sol('sol5').feature('t1').set('plotgroup', 'pg1');
model.sol('sol5').feature('t1').set('plotfreq', 'tout');
model.sol('sol5').feature('t1').set('probesel', 'manual');
model.sol('sol5').feature('t1').set('probes', {'bnd3'});
model.sol('sol5').feature('t1').set('probefreq', 'tsteps');
model.sol('sol5').feature('t1').set('rtol', 0.001);
model.sol('sol5').feature('t1').set('atolglobalvaluemethod', 'factor');
model.sol('sol5').feature('t1').set('eventout', true);
model.sol('sol5').feature('t1').set('reacf', true);
model.sol('sol5').feature('t1').set('storeudot', true);
model.sol('sol5').feature('t1').set('endtimeinterpolation', true);
model.sol('sol5').feature('t1').set('maxorder', 2);
model.sol('sol5').feature('t1').set('initialstepbdfactive', true);
model.sol('sol5').feature('t1').set('initialstepbdf', '(1)[s]');
model.sol('sol5').feature('t1').set('control', 'time');
model.sol('sol5').feature('t1').feature('aDef').set('cachepattern', true);
model.sol('sol5').feature('t1').create('se1', 'Segregated');
model.sol('sol5').feature('t1').feature('se1').feature.remove('ssDef');
model.sol('sol5').feature('t1').feature('se1').create('ss1', 'SegregatedStep');
model.sol('sol5').feature('t1').feature('se1').feature('ss1').set('segvar', {'comp1_phil' 'comp1_cl' 'comp1_phis'});
model.sol('sol5').feature('t1').feature('se1').feature('ss1').set('subjtech', 'onevery');
model.sol('sol5').feature('t1').create('d1', 'Direct');
model.sol('sol5').feature('t1').feature('d1').set('linsolver', 'pardiso');
model.sol('sol5').feature('t1').feature('d1').label('Direct (liion)');
model.sol('sol5').feature('t1').feature('se1').feature('ss1').set('linsolver', 'd1');
model.sol('sol5').feature('t1').feature('se1').feature('ss1').label('Battery Current Distribution');
model.sol('sol5').feature('t1').feature('se1').create('ss2', 'SegregatedStep');
model.sol('sol5').feature('t1').feature('se1').feature('ss2').set('segvar', {'comp1_liion_pce1_cs'});
model.sol('sol5').feature('t1').feature('se1').feature('ss2').set('linsolver', 'd1');
model.sol('sol5').feature('t1').feature('se1').feature('ss2').label('Insertion Particle Concentration Variables');
model.sol('sol5').feature('t1').feature('se1').create('ss3', 'SegregatedStep');
model.sol('sol5').feature('t1').feature('se1').feature('ss3').set('segvar', {'comp1_liion_pce2_cs'});
model.sol('sol5').feature('t1').feature('se1').feature('ss3').set('linsolver', 'd1');
model.sol('sol5').feature('t1').feature('se1').feature('ss3').label('Insertion Particle Concentration Variables (2)');
model.sol('sol5').feature('t1').create('i1', 'Iterative');
model.sol('sol5').feature('t1').feature('i1').set('maxlinit', 1000);
model.sol('sol5').feature('t1').feature('i1').set('nlinnormuse', 'on');
model.sol('sol5').feature('t1').feature('i1').label('Algebraic Multigrid (liion)');
model.sol('sol5').feature('t1').feature('i1').create('mg1', 'Multigrid');
model.sol('sol5').feature('t1').feature('i1').feature('mg1').set('prefun', 'saamg');
model.sol('sol5').feature('t1').feature('i1').feature('mg1').set('maxcoarsedof', 50000);
model.sol('sol5').feature('t1').feature('i1').feature('mg1').set('saamgcompwise', true);
model.sol('sol5').feature('t1').feature('i1').feature('mg1').set('compactaggregation', true);
model.sol('sol5').feature('t1').feature('i1').feature('mg1').feature('pr').create('sc1', 'SCGS');
model.sol('sol5').feature('t1').feature('i1').feature('mg1').feature('pr').feature('sc1').set('linesweeptype', 'ssor');
model.sol('sol5').feature('t1').feature('i1').feature('mg1').feature('pr').feature('sc1').set('iter', 1);
model.sol('sol5').feature('t1').feature('i1').feature('mg1').feature('pr').feature('sc1').set('scgsmethod', 'lines');
model.sol('sol5').feature('t1').feature('i1').feature('mg1').feature('po').create('sc1', 'SCGS');
model.sol('sol5').feature('t1').feature('i1').feature('mg1').feature('po').feature('sc1').set('linesweeptype', 'ssor');
model.sol('sol5').feature('t1').feature('i1').feature('mg1').feature('po').feature('sc1').set('iter', 1);
model.sol('sol5').feature('t1').feature('i1').feature('mg1').feature('po').feature('sc1').set('scgsmethod', 'lines');
model.sol('sol5').feature('t1').feature('i1').feature('mg1').feature('cs').create('d1', 'Direct');
model.sol('sol5').feature('t1').feature('i1').feature('mg1').feature('cs').feature('d1').set('linsolver', 'pardiso');
model.sol('sol5').feature('t1').create('i2', 'Iterative');
model.sol('sol5').feature('t1').feature('i2').set('maxlinit', 1000);
model.sol('sol5').feature('t1').feature('i2').set('nlinnormuse', 'on');
model.sol('sol5').feature('t1').feature('i2').label('Geometric Multigrid (liion)');
model.sol('sol5').feature('t1').feature('i2').create('mg1', 'Multigrid');
model.sol('sol5').feature('t1').feature('i2').feature('mg1').feature('pr').create('sc1', 'SCGS');
model.sol('sol5').feature('t1').feature('i2').feature('mg1').feature('pr').feature('sc1').set('linesweeptype', 'ssor');
model.sol('sol5').feature('t1').feature('i2').feature('mg1').feature('pr').feature('sc1').set('iter', 1);
model.sol('sol5').feature('t1').feature('i2').feature('mg1').feature('pr').feature('sc1').set('scgsmethod', 'lines');
model.sol('sol5').feature('t1').feature('i2').feature('mg1').feature('po').create('sc1', 'SCGS');
model.sol('sol5').feature('t1').feature('i2').feature('mg1').feature('po').feature('sc1').set('linesweeptype', 'ssor');
model.sol('sol5').feature('t1').feature('i2').feature('mg1').feature('po').feature('sc1').set('iter', 1);
model.sol('sol5').feature('t1').feature('i2').feature('mg1').feature('po').feature('sc1').set('scgsmethod', 'lines');
model.sol('sol5').feature('t1').feature('i2').feature('mg1').feature('cs').create('d1', 'Direct');
model.sol('sol5').feature('t1').feature('i2').feature('mg1').feature('cs').feature('d1').set('linsolver', 'pardiso');
model.sol('sol5').feature('t1').feature.remove('fcDef');
model.sol('sol5').attach('std3');

model.probe('bnd3').genResult('none');

model.sol('sol5').runAll;

model.result.dataset('dset4').set('solution', 'sol5');
model.result.dataset('dset5').set('solution', 'sol5');
model.result('pg3').run;
model.result('pg3').set('data', 'dset8');
model.result('pg3').setIndex('looplevel', 7, 0);
model.result('pg3').run;
model.result('pg11').set('window', 'window3');
model.result('pg11').set('windowtitle', 'Probe Plot 3');
model.result('pg11').run;
model.result('pg11').label('Cell Voltage - Study 3');
model.result('pg11').set('legendpos', 'lowerright');
model.result('pg11').set('window', 'window3');
model.result('pg11').set('windowtitle', 'Probe Plot 3');
model.result('pg11').run;
model.result('pg7').run;
model.result('pg7').set('data', 'dset8');
model.result('pg7').setIndex('looplevel', 7, 0);
model.result('pg7').run;
model.result('pg8').run;
model.result('pg8').setIndex('looplevel', 7, 0);
model.result('pg8').run;
model.result('pg8').run;
model.result('pg9').run;
model.result('pg9').setIndex('looplevel', 7, 0);
model.result('pg9').run;

model.study('std1').feature('time').set('probesel', 'manual');
model.study('std1').feature('time').set('probes', {'bnd1'});
model.study('std2').feature('time').set('probes', {'bnd2'});

model.result('pg1').set('window', 'window1');
model.result('pg1').run;
model.result.move('pg1', 8);

model.title('Edge Effects in a Spirally Wound Lithium-Ion Battery');

model.description('This two-dimensional model investigates geometrical edge effects in a spirally wound ("jelly roll") lithium ion battery. The model is isothermal.');

model.mesh.clearMeshes;

model.sol('sol1').clearSolutionData;
model.sol('sol2').clearSolutionData;
model.sol('sol3').clearSolutionData;
model.sol('sol4').clearSolutionData;
model.sol('sol5').clearSolutionData;

model.label('li_battery_spiral_2d.mph');

model.modelNode.label('Components');

out = model;
