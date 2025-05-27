function out = model
%
% solidly_mounted_resonator_2d_uncertainty_quantification.m
%
% Model exported on May 26 2025, 21:30 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/MEMS_Module/Piezoelectric_Devices');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 2);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.physics.create('solid', 'SolidMechanics', 'geom1');
model.physics('solid').model('comp1');
model.physics('solid').create('pzm1', 'PiezoelectricMaterialModel');
model.physics('solid').feature('pzm1').selection.all;
model.physics.create('es', 'Electrostatics', 'geom1');
model.physics('es').model('comp1');
model.physics('es').create('ccnp1', 'ChargeConservationPiezo');
model.physics('es').feature('ccnp1').selection.all;

model.multiphysics.create('pze1', 'PiezoelectricEffect', 'geom1', 2);
model.multiphysics('pze1').set('Solid_physics', 'solid');
model.multiphysics('pze1').set('Electrostatics_physics', 'es');

model.study.create('std1');
model.study('std1').create('eig', 'Eigenfrequency');
model.study('std1').feature('eig').set('shift', '1[Hz]');
model.study('std1').feature('eig').set('conrad', '1');
model.study('std1').feature('eig').set('linpsolnum', 'auto');
model.study('std1').feature('eig').set('solnum', 'auto');
model.study('std1').feature('eig').set('notsolnum', 'auto');
model.study('std1').feature('eig').set('outputmap', {});
model.study('std1').feature('eig').set('ngenAUX', '1');
model.study('std1').feature('eig').set('goalngenAUX', '1');
model.study('std1').feature('eig').set('ngenAUX', '1');
model.study('std1').feature('eig').set('goalngenAUX', '1');
model.study('std1').feature('eig').setSolveFor('/physics/solid', true);
model.study('std1').feature('eig').setSolveFor('/physics/es', true);
model.study('std1').feature('eig').setSolveFor('/multiphysics/pze1', true);

model.common.create('mpf1', 'ParticipationFactors', 'comp1');

model.geom('geom1').lengthUnit([native2unicode(hex2dec({'00' 'b5'}), 'unicode') 'm']);

model.view('view1').axis.set('viewscaletype', 'manual');
model.view('view1').axis.set('yscale', 35);

model.param.label('Parameters 1 - Geometry');
model.param.set('t_s', '500[um]/25');
model.param.descr('t_s', 'Substrate thickness (truncated)');
model.param.set('t_i', '200[nm]');
model.param.descr('t_i', 'Insulator thickness');
model.param.set('t_hil', '1.82[um]');
model.param.descr('t_hil', 'High impedance layer thickness');
model.param.set('t_lil', '1.65[um]');
model.param.descr('t_lil', 'Low impedance layer thickness');
model.param.set('t_pe', '3.35[um]');
model.param.descr('t_pe', 'Piezoelectric layer thickness');
model.param.set('t_e', '200[nm]');
model.param.descr('t_e', 'Electrode thickness');
model.param.set('w_ar', '200[um]');
model.param.descr('w_ar', 'Active area width');
model.param.set('w_pe', '800[um]');
model.param.descr('w_pe', 'Piezoelectric layer width');
model.param.set('w', '1000[um]');
model.param.descr('w', 'Device width');
model.param.create('par2');
model.param('par2').label('Parameters 2 - Material properties');
model.param('par2').set('rho_ZnO', '5680[kg/m^3]');
model.param('par2').descr('rho_ZnO', 'Density of ZnO');
model.param('par2').set('rho_Mo', '10200[kg/m^3]');
model.param('par2').descr('rho_Mo', 'Density of Mo');
model.param('par2').set('rho_SiO2', '2170[kg/m^3]');
model.param('par2').descr('rho_SiO2', 'Density of SiO2');
model.param('par2').set('rho_Al', '2700[kg/m^3]');
model.param('par2').descr('rho_Al', 'Density of Al');
model.param('par2').set('rho_Si', '2330[kg/m^3]');
model.param('par2').descr('rho_Si', 'Density of Si');
model.param('par2').set('v_ZnO', '6330[m/s]');
model.param('par2').descr('v_ZnO', 'Acoustic velocity of ZnO');
model.param('par2').set('v_Mo', '6280[m/s]');
model.param('par2').descr('v_Mo', 'Acoustic velocity_of Mo');
model.param('par2').set('v_SiO2', '5540[m/s]');
model.param('par2').descr('v_SiO2', 'Acoustic velocity of SiO2');
model.param('par2').set('v_Al', '6450[m/s]');
model.param('par2').descr('v_Al', 'Acoustic velocity of Al');
model.param('par2').set('v_Si', '8320[m/s]');
model.param('par2').descr('v_Si', 'Acoustic velocity of Si');
model.param('par2').set('E_Mo', 'rho_Mo*(v_Mo)^2');
model.param('par2').descr('E_Mo', 'Young''s modulus of Mo');
model.param('par2').set('E_SiO2', 'rho_SiO2*(v_SiO2)^2');
model.param('par2').descr('E_SiO2', 'Young''s modulus of SiO2');
model.param('par2').set('E_Al', 'rho_Al*(v_Al)^2');
model.param('par2').descr('E_Al', 'Young''s modulus of Al');
model.param('par2').set('E_Si', 'rho_Si*(v_Si)^2');
model.param('par2').descr('E_Si', 'Young''s modulus of Si');
model.param('par2').set('eta0', '1.5e-4');
model.param('par2').descr('eta0', 'Loss factor (guessed)');
model.param('par2').set('lambda_Si', 'v_Si/870[MHz]');
model.param('par2').descr('lambda_Si', 'Wavelength in Si');

model.geom('geom1').create('r1', 'Rectangle');
model.geom('geom1').feature('r1').label('Piezo - ZnO');
model.geom('geom1').feature('r1').set('size', {'w_pe' 't_pe'});
model.geom('geom1').feature('r1').set('pos', {'-w_pe/2' 't_e'});
model.geom('geom1').feature('r1').set('selresult', true);
model.geom('geom1').feature.duplicate('r2', 'r1');
model.geom('geom1').feature('r2').label('Top electrode - Al');
model.geom('geom1').feature('r2').set('size', {'w_ar' 't_e'});
model.geom('geom1').feature('r2').set('pos', {'-w_ar/2' 't_pe+t_e'});
model.geom('geom1').feature('r2').set('selresultshow', 'all');
model.geom('geom1').selection.create('csel1', 'CumulativeSelection');
model.geom('geom1').selection('csel1').label('Al');
model.geom('geom1').feature('r2').set('contributeto', 'csel1');
model.geom('geom1').feature.duplicate('r3', 'r2');
model.geom('geom1').feature('r3').label('Bottom electrode - Al');
model.geom('geom1').feature('r3').set('size', {'w_pe' 't_e'});
model.geom('geom1').feature('r3').set('pos', {'-w_pe/2' '0'});
model.geom('geom1').run('r3');
model.geom('geom1').create('r4', 'Rectangle');
model.geom('geom1').feature('r4').label('Low impedance - SiO2');
model.geom('geom1').feature('r4').set('size', {'w' 't_lil'});
model.geom('geom1').feature('r4').set('pos', {'-w/2' '-t_lil'});
model.geom('geom1').feature('r4').setIndex('layer', '(w-w_pe)/2', 0);
model.geom('geom1').feature('r4').set('layerleft', true);
model.geom('geom1').feature('r4').set('layerright', true);
model.geom('geom1').feature('r4').set('layerbottom', false);
model.geom('geom1').selection.create('csel2', 'CumulativeSelection');
model.geom('geom1').selection('csel2').label('SiO2');
model.geom('geom1').feature('r4').set('contributeto', 'csel2');
model.geom('geom1').run('r4');
model.geom('geom1').create('arr1', 'Array');
model.geom('geom1').feature('arr1').label('Array - SiO2');
model.geom('geom1').feature('arr1').selection('input').named('csel2');
model.geom('geom1').feature('arr1').set('fullsize', [1 3]);
model.geom('geom1').feature('arr1').set('displ', {'0' '-t_lil-t_hil'});
model.geom('geom1').feature.duplicate('r5', 'r4');
model.geom('geom1').feature('r5').label('High impedance - Mo');
model.geom('geom1').feature('r5').set('size', {'w' 't_hil'});
model.geom('geom1').feature('r5').set('pos', {'-w/2' '-t_lil-t_hil'});
model.geom('geom1').selection.create('csel3', 'CumulativeSelection');
model.geom('geom1').selection('csel3').label('Mo');
model.geom('geom1').feature('r5').set('contributeto', 'csel3');
model.geom('geom1').feature.duplicate('arr2', 'arr1');
model.geom('geom1').feature('arr2').label('Array - Mo');
model.geom('geom1').runPre('arr2');
model.geom('geom1').feature('arr2').selection('input').named('csel3');
model.geom('geom1').run('arr2');
model.geom('geom1').feature.duplicate('r6', 'r4');
model.geom('geom1').feature('r6').label('Insulator - SiO2');
model.geom('geom1').feature('r6').set('size', {'w' 't_i'});
model.geom('geom1').feature('r6').set('pos', {'-w/2' '-(t_lil*3)-(t_hil*3)-t_i'});
model.geom('geom1').feature.duplicate('r7', 'r6');
model.geom('geom1').feature('r7').label('Substrate - Si');
model.geom('geom1').feature('r7').set('size', {'w' 't_s'});
model.geom('geom1').feature('r7').set('pos', {'-w/2' '-(t_lil*3)-(t_hil*3)-t_i-t_s'});
model.geom('geom1').selection.create('csel4', 'CumulativeSelection');
model.geom('geom1').selection('csel4').label('Si');
model.geom('geom1').feature('r7').set('contributeto', 'csel4');
model.geom('geom1').feature.duplicate('r8', 'r7');
model.geom('geom1').feature('r8').label('Bottom PML - Si');
model.geom('geom1').feature('r8').set('size', {'w' 'lambda_Si'});
model.geom('geom1').feature('r8').set('pos', {'-w/2' '-(t_lil*3)-(t_hil*3)-t_i-t_s-lambda_Si'});
model.geom('geom1').run('fin');

model.selection.create('box1', 'Box');
model.selection('box1').model('comp1');
model.selection('box1').label('Not PML');
model.selection('box1').set('xmin', '-w_ar');
model.selection('box1').set('xmax', 'w_ar');
model.selection('box1').set('ymin', '-(t_hil*3)-(t_lil*3)-t_i-t_s/2');
model.selection.create('com1', 'Complement');
model.selection('com1').model('comp1');
model.selection('com1').label('PML');
model.selection('com1').set('input', {'box1'});
model.selection.create('box2', 'Box');
model.selection('box2').model('comp1');
model.selection('box2').label('Left fixed B.C.');
model.selection('box2').set('entitydim', 1);
model.selection('box2').set('xmax', '-(w+w_pe)/4');
model.selection('box2').set('condition', 'inside');
model.selection.duplicate('box3', 'box2');
model.selection('box3').label('Right fixed B.C.');
model.selection('box3').set('xmin', '(w+w_pe)/4');
model.selection('box3').set('xmax', Inf);
model.selection.create('sel1', 'Explicit');
model.selection('sel1').model('comp1');
model.selection('sel1').label('Bottom fixed B.C.');
model.selection('sel1').geom(1);
model.selection('sel1').set([2 21 49]);
model.selection.create('uni1', 'Union');
model.selection('uni1').model('comp1');
model.selection('uni1').label('Fixed B.C.');
model.selection('uni1').set('entitydim', 1);
model.selection('uni1').set('input', {'box2' 'box3' 'sel1'});

model.coordSystem.create('pml1', 'geom1', 'PML');
model.coordSystem('pml1').selection.named('com1');

model.physics('solid').prop('d').set('d', 'w_ar');
model.physics('solid').feature('lemm1').create('dmp1', 'Damping', 2);
model.physics('solid').feature('lemm1').feature('dmp1').set('DampingType', 'IsotropicLossFactor');
model.physics('solid').feature('pzm1').selection.named('geom1_r1_dom');
model.physics('solid').feature('pzm1').create('mdmp1', 'MechanicalDamping', 2);
model.physics('solid').create('fix1', 'Fixed', 1);
model.physics('solid').feature('fix1').selection.named('uni1');
model.physics('es').selection.named('geom1_r1_dom');
model.physics('es').prop('d').set('d', 'w_ar');
model.physics('es').create('gnd1', 'Ground', 1);
model.physics('es').feature('gnd1').selection.named('geom1_r3_bnd');
model.physics('es').create('term1', 'Terminal', 1);
model.physics('es').feature('term1').selection.named('geom1_r2_bnd');
model.physics('es').feature('term1').set('TerminalType', 'Voltage');

model.material.create('mat1', 'Common', 'comp1');
model.material('mat1').propertyGroup.create('StrainCharge', 'Strain-charge form');
model.material('mat1').propertyGroup.create('StressCharge', 'Stress-charge form');
model.material('mat1').label('Zinc Oxide');
model.material('mat1').set('family', 'custom');
model.material('mat1').set('customspecular', [0.7843137254901961 1 1]);
model.material('mat1').set('customdiffuse', [0.7843137254901961 0.7843137254901961 0.7843137254901961]);
model.material('mat1').set('noise', true);
model.material('mat1').set('fresnel', 0.9);
model.material('mat1').set('roughness', 0.1);
model.material('mat1').set('metallic', 0);
model.material('mat1').set('pearl', 0);
model.material('mat1').set('diffusewrap', 0);
model.material('mat1').set('clearcoat', 0);
model.material('mat1').set('reflectance', 0);
model.material('mat1').propertyGroup('def').set('relpermittivity', {'8.5446' '0' '0' '0' '8.5446' '0' '0' '0' '10.204'});
model.material('mat1').propertyGroup('def').set('density', '5680[kg/m^3]');
model.material('mat1').propertyGroup('StrainCharge').set('sE', {'7.86e-012[1/Pa]' '-3.43e-012[1/Pa]' '-2.21e-012[1/Pa]' '0[1/Pa]' '0[1/Pa]' '0[1/Pa]' '-3.43e-012[1/Pa]' '7.86e-012[1/Pa]' '-2.21e-012[1/Pa]' '0[1/Pa]'  ...
'0[1/Pa]' '0[1/Pa]' '-2.21e-012[1/Pa]' '-2.21e-012[1/Pa]' '6.94e-012[1/Pa]' '0[1/Pa]' '0[1/Pa]' '0[1/Pa]' '0[1/Pa]' '0[1/Pa]'  ...
'0[1/Pa]' '2.36e-011[1/Pa]' '0[1/Pa]' '0[1/Pa]' '0[1/Pa]' '0[1/Pa]' '0[1/Pa]' '0[1/Pa]' '2.36e-011[1/Pa]' '0[1/Pa]'  ...
'0[1/Pa]' '0[1/Pa]' '0[1/Pa]' '0[1/Pa]' '0[1/Pa]' '2.26e-011[1/Pa]'});
model.material('mat1').propertyGroup('StrainCharge').set('dET', {'0[C/N]' '0[C/N]' '-5.43e-012[C/N]' '0[C/N]' '0[C/N]' '-5.43e-012[C/N]' '0[C/N]' '0[C/N]' '1.167e-011[C/N]' '0[C/N]'  ...
'-1.134e-011[C/N]' '0[C/N]' '-1.134e-011[C/N]' '0[C/N]' '0[C/N]' '0[C/N]' '0[C/N]' '0[C/N]'});
model.material('mat1').propertyGroup('StrainCharge').set('epsilonrT', {'9.16' '0' '0' '0' '9.16' '0' '0' '0' '12.64'});
model.material('mat1').propertyGroup('StressCharge').set('cE', {'2.09714e+011[Pa]' '1.2114e+011[Pa]' '1.05359e+011[Pa]' '0[Pa]' '0[Pa]' '0[Pa]' '1.2114e+011[Pa]' '2.09714e+011[Pa]' '1.05359e+011[Pa]' '0[Pa]'  ...
'0[Pa]' '0[Pa]' '1.05359e+011[Pa]' '1.05359e+011[Pa]' '2.11194e+011[Pa]' '0[Pa]' '0[Pa]' '0[Pa]' '0[Pa]' '0[Pa]'  ...
'0[Pa]' '4.23729e+010[Pa]' '0[Pa]' '0[Pa]' '0[Pa]' '0[Pa]' '0[Pa]' '0[Pa]' '4.23729e+010[Pa]' '0[Pa]'  ...
'0[Pa]' '0[Pa]' '0[Pa]' '0[Pa]' '0[Pa]' '4.42478e+010[Pa]'});
model.material('mat1').propertyGroup('StressCharge').set('eES', {'0[C/m^2]' '0[C/m^2]' '-0.567005[C/m^2]' '0[C/m^2]' '0[C/m^2]' '-0.567005[C/m^2]' '0[C/m^2]' '0[C/m^2]' '1.32044[C/m^2]' '0[C/m^2]'  ...
'-0.480508[C/m^2]' '0[C/m^2]' '-0.480508[C/m^2]' '0[C/m^2]' '0[C/m^2]' '0[C/m^2]' '0[C/m^2]' '0[C/m^2]'});
model.material('mat1').propertyGroup('StressCharge').set('epsilonrS', {'8.5446' '0' '0' '0' '8.5446' '0' '0' '0' '10.204'});
model.material('mat1').set('family', 'custom');
model.material('mat1').set('lighting', 'cooktorrance');
model.material('mat1').set('fresnel', 0.9);
model.material('mat1').set('roughness', 0.1);
model.material('mat1').set('anisotropy', 0);
model.material('mat1').set('flipanisotropy', false);
model.material('mat1').set('metallic', 0);
model.material('mat1').set('pearl', 0);
model.material('mat1').set('diffusewrap', 0);
model.material('mat1').set('clearcoat', 0);
model.material('mat1').set('reflectance', 0);
model.material('mat1').set('ambient', 'custom');
model.material('mat1').set('customambient', [0.7843137254901961 0.7843137254901961 0.7843137254901961]);
model.material('mat1').set('diffuse', 'custom');
model.material('mat1').set('customdiffuse', [0.7843137254901961 0.7843137254901961 0.7843137254901961]);
model.material('mat1').set('specular', 'custom');
model.material('mat1').set('customspecular', [0.7843137254901961 1 1]);
model.material('mat1').set('noisecolor', 'custom');
model.material('mat1').set('customnoisecolor', [0 0 0]);
model.material('mat1').set('noisescale', 0);
model.material('mat1').set('noise', 'off');
model.material('mat1').set('noisefreq', 1);
model.material('mat1').set('normalnoisebrush', '0');
model.material('mat1').set('normalnoisetype', '0');
model.material('mat1').set('alpha', 1);
model.material('mat1').set('anisotropyaxis', [0 0 1]);
model.material('mat1').selection.named('geom1_r1_dom');
model.material('mat1').propertyGroup('def').set('density', {'rho_ZnO'});
model.material('mat1').propertyGroup('StressCharge').set('eta_cE', {'eta0'});
model.material.create('mat2', 'Common', 'comp1');
model.material('mat2').propertyGroup.create('Enu', 'Young''s modulus and Poisson''s ratio');
model.material('mat2').label('Al - Aluminum');
model.material('mat2').set('family', 'aluminum');
model.material('mat2').propertyGroup('def').set('electricconductivity', {'35.5e6[S/m]' '0' '0' '0' '35.5e6[S/m]' '0' '0' '0' '35.5e6[S/m]'});
model.material('mat2').propertyGroup('def').set('thermalexpansioncoefficient', {'23.1e-6[1/K]' '0' '0' '0' '23.1e-6[1/K]' '0' '0' '0' '23.1e-6[1/K]'});
model.material('mat2').propertyGroup('def').set('heatcapacity', '904[J/(kg*K)]');
model.material('mat2').propertyGroup('def').set('density', '2700[kg/m^3]');
model.material('mat2').propertyGroup('def').set('thermalconductivity', {'237[W/(m*K)]' '0' '0' '0' '237[W/(m*K)]' '0' '0' '0' '237[W/(m*K)]'});
model.material('mat2').propertyGroup('Enu').set('E', '70.0e9[Pa]');
model.material('mat2').propertyGroup('Enu').set('nu', '0.35');
model.material('mat2').set('family', 'aluminum');
model.material('mat2').selection.named('geom1_csel1_dom');
model.material('mat2').propertyGroup('def').set('lossfactor', {'eta0'});
model.material('mat2').propertyGroup('def').set('density', {'rho_Al'});
model.material('mat2').propertyGroup('Enu').set('E', {'E_Al'});
model.material.create('mat3', 'Common', 'comp1');
model.material('mat3').propertyGroup.create('Enu', 'Young''s modulus and Poisson''s ratio');
model.material('mat3').label('SiO2 - Silicon oxide');
model.material('mat3').propertyGroup('def').set('electricconductivity', {'0[S/m]' '0' '0' '0' '0[S/m]' '0' '0' '0' '0[S/m]'});
model.material('mat3').propertyGroup('def').set('thermalexpansioncoefficient', {'0.5e-6[1/K]' '0' '0' '0' '0.5e-6[1/K]' '0' '0' '0' '0.5e-6[1/K]'});
model.material('mat3').propertyGroup('def').set('heatcapacity', '730[J/(kg*K)]');
model.material('mat3').propertyGroup('def').set('relpermittivity', {'4.2' '0' '0' '0' '4.2' '0' '0' '0' '4.2'});
model.material('mat3').propertyGroup('def').set('density', '2200[kg/m^3]');
model.material('mat3').propertyGroup('def').set('thermalconductivity', {'1.4[W/(m*K)]' '0' '0' '0' '1.4[W/(m*K)]' '0' '0' '0' '1.4[W/(m*K)]'});
model.material('mat3').propertyGroup('Enu').set('E', '70e9[Pa]');
model.material('mat3').propertyGroup('Enu').set('nu', '0.17');
model.material('mat3').set('family', 'plastic');
model.material('mat3').selection.named('geom1_csel2_dom');
model.material('mat3').propertyGroup('def').set('lossfactor', {'eta0'});
model.material('mat3').propertyGroup('def').set('density', {'rho_SiO2'});
model.material('mat3').propertyGroup('Enu').set('E', {'E_SiO2'});
model.material.create('mat4', 'Common', 'comp1');
model.material('mat4').propertyGroup.create('Enu', 'Young''s modulus and Poisson''s ratio');
model.material('mat4').label('Si - Silicon (single-crystal, isotropic)');
model.material('mat4').set('family', 'custom');
model.material('mat4').set('customspecular', [0.7843137254901961 1 1]);
model.material('mat4').set('customdiffuse', [0.6666666666666666 0.6666666666666666 0.7058823529411765]);
model.material('mat4').set('customambient', [0.6666666666666666 0.6666666666666666 0.7058823529411765]);
model.material('mat4').set('noise', true);
model.material('mat4').set('fresnel', 0.7);
model.material('mat4').set('metallic', 0);
model.material('mat4').set('pearl', 0);
model.material('mat4').set('diffusewrap', 0);
model.material('mat4').set('clearcoat', 0);
model.material('mat4').set('reflectance', 0);
model.material('mat4').propertyGroup('def').set('thermalexpansioncoefficient', {'2.6e-6[1/K]' '0' '0' '0' '2.6e-6[1/K]' '0' '0' '0' '2.6e-6[1/K]'});
model.material('mat4').propertyGroup('def').set('heatcapacity', '700[J/(kg*K)]');
model.material('mat4').propertyGroup('def').set('relpermittivity', {'11.7' '0' '0' '0' '11.7' '0' '0' '0' '11.7'});
model.material('mat4').propertyGroup('def').set('density', '2329[kg/m^3]');
model.material('mat4').propertyGroup('def').set('thermalconductivity', {'130[W/(m*K)]' '0' '0' '0' '130[W/(m*K)]' '0' '0' '0' '130[W/(m*K)]'});
model.material('mat4').propertyGroup('Enu').set('E', '170e9[Pa]');
model.material('mat4').propertyGroup('Enu').set('nu', '0.28');
model.material('mat4').set('family', 'custom');
model.material('mat4').set('lighting', 'cooktorrance');
model.material('mat4').set('fresnel', 0.7);
model.material('mat4').set('roughness', 0.5);
model.material('mat4').set('anisotropy', 0);
model.material('mat4').set('flipanisotropy', false);
model.material('mat4').set('metallic', 0);
model.material('mat4').set('pearl', 0);
model.material('mat4').set('diffusewrap', 0);
model.material('mat4').set('clearcoat', 0);
model.material('mat4').set('reflectance', 0);
model.material('mat4').set('ambient', 'custom');
model.material('mat4').set('customambient', [0.6666666666666666 0.6666666666666666 0.7058823529411765]);
model.material('mat4').set('diffuse', 'custom');
model.material('mat4').set('customdiffuse', [0.6666666666666666 0.6666666666666666 0.7058823529411765]);
model.material('mat4').set('specular', 'custom');
model.material('mat4').set('customspecular', [0.7843137254901961 1 1]);
model.material('mat4').set('noisecolor', 'custom');
model.material('mat4').set('customnoisecolor', [0 0 0]);
model.material('mat4').set('noisescale', 0);
model.material('mat4').set('noise', 'off');
model.material('mat4').set('noisefreq', 1);
model.material('mat4').set('normalnoisebrush', '0');
model.material('mat4').set('normalnoisetype', '0');
model.material('mat4').set('alpha', 1);
model.material('mat4').set('anisotropyaxis', [0 0 1]);
model.material('mat4').selection.named('geom1_csel4_dom');
model.material('mat4').propertyGroup('def').set('lossfactor', {'eta0'});
model.material('mat4').propertyGroup('def').set('density', {'rho_Si'});
model.material('mat4').propertyGroup('Enu').set('E', {'E_Si'});
model.material.create('mat5', 'Common', 'comp1');
model.material('mat5').propertyGroup.create('Enu', 'Young''s modulus and Poisson''s ratio');
model.material('mat5').propertyGroup.create('Murnaghan', 'Murnaghan');
model.material('mat5').label('Molybdenum');
model.material('mat5').set('family', 'custom');
model.material('mat5').set('customspecular', [0.7843137254901961 1 1]);
model.material('mat5').set('customdiffuse', [0.7843137254901961 0.7843137254901961 0.7843137254901961]);
model.material('mat5').set('noise', true);
model.material('mat5').set('fresnel', 0.3);
model.material('mat5').set('roughness', 0.1);
model.material('mat5').set('metallic', 0);
model.material('mat5').set('pearl', 0);
model.material('mat5').set('diffusewrap', 0);
model.material('mat5').set('clearcoat', 0);
model.material('mat5').set('reflectance', 0);
model.material('mat5').propertyGroup('def').set('thermalexpansioncoefficient', {'4.8e-6[1/K]' '0' '0' '0' '4.8e-6[1/K]' '0' '0' '0' '4.8e-6[1/K]'});
model.material('mat5').propertyGroup('def').set('density', '10200[kg/m^3]');
model.material('mat5').propertyGroup('def').set('heatcapacity', '250[J/(kg*K)]');
model.material('mat5').propertyGroup('def').set('thermalconductivity', {'138[W/(m*K)]' '0' '0' '0' '138[W/(m*K)]' '0' '0' '0' '138[W/(m*K)]'});
model.material('mat5').propertyGroup('Enu').set('E', '312[GPa]');
model.material('mat5').propertyGroup('Enu').set('nu', '0.31');
model.material('mat5').propertyGroup('Murnaghan').set('l', '-300[GPa]');
model.material('mat5').propertyGroup('Murnaghan').set('m', '-850[GPa]');
model.material('mat5').propertyGroup('Murnaghan').set('n', '-910[GPa]');
model.material('mat5').set('family', 'custom');
model.material('mat5').set('lighting', 'cooktorrance');
model.material('mat5').set('fresnel', 0.3);
model.material('mat5').set('roughness', 0.1);
model.material('mat5').set('anisotropy', 0);
model.material('mat5').set('flipanisotropy', false);
model.material('mat5').set('metallic', 0);
model.material('mat5').set('pearl', 0);
model.material('mat5').set('diffusewrap', 0);
model.material('mat5').set('clearcoat', 0);
model.material('mat5').set('reflectance', 0);
model.material('mat5').set('ambient', 'custom');
model.material('mat5').set('customambient', [0.7843137254901961 0.7843137254901961 0.7843137254901961]);
model.material('mat5').set('diffuse', 'custom');
model.material('mat5').set('customdiffuse', [0.7843137254901961 0.7843137254901961 0.7843137254901961]);
model.material('mat5').set('specular', 'custom');
model.material('mat5').set('customspecular', [0.7843137254901961 1 1]);
model.material('mat5').set('noisecolor', 'custom');
model.material('mat5').set('customnoisecolor', [0 0 0]);
model.material('mat5').set('noisescale', 0);
model.material('mat5').set('noise', 'off');
model.material('mat5').set('noisefreq', 1);
model.material('mat5').set('normalnoisebrush', '0');
model.material('mat5').set('normalnoisetype', '0');
model.material('mat5').set('alpha', 1);
model.material('mat5').set('anisotropyaxis', [0 0 1]);
model.material('mat5').selection.named('geom1_csel3_dom');
model.material('mat5').propertyGroup('def').set('lossfactor', {'eta0'});
model.material('mat5').propertyGroup('def').set('density', {'rho_Mo'});
model.material('mat5').propertyGroup('Enu').set('E', {'E_Mo'});

model.mesh('mesh1').create('map1', 'Map');
model.mesh('mesh1').feature('map1').selection.geom('geom1', 2);
model.mesh('mesh1').feature('map1').selection.named('geom1_r2_dom');
model.mesh('mesh1').feature('map1').set('smoothcontrol', false);
model.mesh('mesh1').feature('map1').set('adjustedgdistr', true);
model.mesh('mesh1').feature('map1').create('dis1', 'Distribution');
model.mesh('mesh1').feature('map1').feature('dis1').selection.set([45]);
model.mesh('mesh1').feature('map1').feature('dis1').set('numelem', 16);
model.mesh('mesh1').feature('map1').create('dis2', 'Distribution');
model.mesh('mesh1').feature('map1').feature('dis2').selection.set([43]);
model.mesh('mesh1').feature('map1').feature('dis2').set('numelem', 1);
model.mesh('mesh1').create('edg1', 'Edge');
model.mesh('mesh1').feature('edg1').selection.set([42 47]);
model.mesh('mesh1').feature('edg1').set('smoothcontrol', false);
model.mesh('mesh1').feature('edg1').create('dis1', 'Distribution');
model.mesh('mesh1').feature('edg1').feature('dis1').selection.set([47]);
model.mesh('mesh1').feature('edg1').feature('dis1').set('type', 'predefined');
model.mesh('mesh1').feature('edg1').feature('dis1').set('elemcount', 16);
model.mesh('mesh1').feature('edg1').feature('dis1').set('elemratio', 2);
model.mesh('mesh1').feature('edg1').feature('dis1').set('growthrate', 'exponential');
model.mesh('mesh1').feature('edg1').feature.duplicate('dis2', 'dis1');
model.mesh('mesh1').feature('edg1').feature('dis2').selection.set([42]);
model.mesh('mesh1').feature('edg1').feature('dis2').set('reverse', true);
model.mesh('mesh1').create('cpe1', 'CopyEdge');
model.mesh('mesh1').feature('cpe1').selection('source').geom(1);
model.mesh('mesh1').feature('cpe1').selection('destination').geom(1);
model.mesh('mesh1').feature('cpe1').selection('source').set([42 44 47]);
model.mesh('mesh1').feature('cpe1').selection('destination').set([21 23 25 27 29 31 33 35 37 39 41]);
model.mesh('mesh1').create('map2', 'Map');
model.mesh('mesh1').feature('map2').set('smoothcontrol', false);
model.mesh('mesh1').feature('map2').set('adjustedgdistr', true);
model.mesh('mesh1').feature('map2').create('dis1', 'Distribution');
model.mesh('mesh1').feature('map2').feature('dis1').selection.set([40]);
model.mesh('mesh1').feature('map2').feature('dis1').set('numelem', 8);
model.mesh('mesh1').feature('map2').create('dis2', 'Distribution');
model.mesh('mesh1').feature('map2').feature('dis2').selection.set([5 38]);
model.mesh('mesh1').feature('map2').feature('dis2').set('numelem', 1);
model.mesh('mesh1').feature('map2').create('dis3', 'Distribution');
model.mesh('mesh1').feature('map2').feature('dis3').selection.set([7 9 11 13 15 17 19 67]);
model.mesh('mesh1').feature('map2').create('dis4', 'Distribution');
model.mesh('mesh1').feature('map2').feature('dis4').selection.set([3 22 50 70]);
model.mesh('mesh1').feature('map2').feature('dis4').set('type', 'predefined');
model.mesh('mesh1').feature('map2').feature('dis4').set('elemcount', 16);
model.mesh('mesh1').feature('map2').feature('dis4').set('elemratio', 2);
model.mesh('mesh1').feature('map2').feature('dis4').set('growthrate', 'exponential');
model.mesh('mesh1').feature('map2').feature('dis4').set('reverse', true);
model.mesh('mesh1').feature('map2').create('dis5', 'Distribution');
model.mesh('mesh1').feature('map2').feature('dis5').selection.set([1]);
model.mesh('mesh1').feature('map2').feature('dis5').set('numelem', 8);
model.mesh('mesh1').run;

model.study('std1').label('Study 1 - Modes');
model.study('std1').setGenPlots(false);
model.study('std1').feature('eig').set('neigsactive', true);
model.study('std1').feature('eig').set('neigs', 4);
model.study('std1').feature('eig').set('eigunit', 'MHz');
model.study('std1').feature('eig').set('shift', '870');
model.study('std1').feature('eig').set('eigwhich', 'lr');

model.sol.create('sol1');
model.sol('sol1').study('std1');

model.study('std1').feature('eig').set('notlistsolnum', 1);
model.study('std1').feature('eig').set('notsolnum', 'auto');
model.study('std1').feature('eig').set('listsolnum', 1);
model.study('std1').feature('eig').set('solnum', 'auto');
model.study('std1').feature('eig').set('linplistsolnum', {'1'});
model.study('std1').feature('eig').set('linpsolnum', 'auto');

model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'eig');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').set('control', 'eig');
model.sol('sol1').create('e1', 'Eigenvalue');
model.sol('sol1').feature('e1').set('eigvfunscale', 'maximum');
model.sol('sol1').feature('e1').set('eigvfunscaleparam', '1.0E-9');
model.sol('sol1').feature('e1').set('control', 'eig');
model.sol('sol1').feature('e1').feature('aDef').set('cachepattern', true);
model.sol('sol1').attach('std1');
model.sol('sol1').runAll;

model.result.create('pg1', 'PlotGroup2D');
model.result('pg1').run;
model.result('pg1').label('Mode Shape (solid)');
model.result('pg1').create('surf1', 'Surface');
model.result('pg1').feature('surf1').set('colortable', 'AuroraBorealis');
model.result('pg1').feature('surf1').create('def1', 'Deform');
model.result('pg1').run;
model.result('pg1').feature('surf1').feature('def1').set('scaleactive', true);
model.result('pg1').feature('surf1').feature('def1').set('scale', '2E12');
model.result('pg1').run;
model.result('pg1').run;

model.study.create('std2');
model.study('std2').create('freq', 'Frequency');
model.study('std2').feature('freq').setSolveFor('/physics/solid', true);
model.study('std2').feature('freq').setSolveFor('/physics/es', true);
model.study('std2').feature('freq').setSolveFor('/multiphysics/pze1', true);
model.study('std2').feature('freq').set('punit', 'MHz');
model.study('std2').feature('freq').set('plist', 'range(500,50,800) range(810,10,850) range(860,2,870) range(870.1,0.05,870.9) range(871,1,910) 920 930 940 range(950,50,1200)');
model.study('std2').label('Study 2 - Frequency Response');
model.study('std2').setGenPlots(false);

model.sol.create('sol2');
model.sol('sol2').study('std2');

model.study('std2').feature('freq').set('notlistsolnum', 1);
model.study('std2').feature('freq').set('notsolnum', 'auto');
model.study('std2').feature('freq').set('listsolnum', 1);
model.study('std2').feature('freq').set('solnum', 'auto');

model.sol('sol2').create('st1', 'StudyStep');
model.sol('sol2').feature('st1').set('study', 'std2');
model.sol('sol2').feature('st1').set('studystep', 'freq');
model.sol('sol2').create('v1', 'Variables');
model.sol('sol2').feature('v1').set('control', 'freq');
model.sol('sol2').create('s1', 'Stationary');
model.sol('sol2').feature('s1').create('p1', 'Parametric');
model.sol('sol2').feature('s1').feature.remove('pDef');
model.sol('sol2').feature('s1').feature('p1').set('pname', {'freq'});
model.sol('sol2').feature('s1').feature('p1').set('plistarr', {'range(500,50,800) range(810,10,850) range(860,2,870) range(870.1,0.05,870.9) range(871,1,910) 920 930 940 range(950,50,1200)'});
model.sol('sol2').feature('s1').feature('p1').set('punit', {'MHz'});
model.sol('sol2').feature('s1').feature('p1').set('pcontinuationmode', 'no');
model.sol('sol2').feature('s1').feature('p1').set('preusesol', 'no');
model.sol('sol2').feature('s1').feature('p1').set('pdistrib', 'off');
model.sol('sol2').feature('s1').feature('p1').set('plot', 'off');
model.sol('sol2').feature('s1').feature('p1').set('plotgroup', 'pg1');
model.sol('sol2').feature('s1').feature('p1').set('probesel', 'all');
model.sol('sol2').feature('s1').feature('p1').set('probes', {});
model.sol('sol2').feature('s1').feature('p1').set('control', 'freq');
model.sol('sol2').feature('s1').set('linpmethod', 'sol');
model.sol('sol2').feature('s1').set('linpsol', 'zero');
model.sol('sol2').feature('s1').set('control', 'freq');
model.sol('sol2').feature('s1').feature('aDef').set('cachepattern', true);
model.sol('sol2').feature('s1').create('seDef', 'Segregated');
model.sol('sol2').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol2').feature('s1').feature('fc1').set('linsolver', 'dDef');
model.sol('sol2').feature('s1').feature.remove('fcDef');
model.sol('sol2').feature('s1').feature.remove('seDef');
model.sol('sol2').attach('std2');
model.sol('sol2').runAll;

model.result.create('pg2', 'PlotGroup2D');
model.result('pg2').run;
model.result('pg2').label('Electric Potential (es)');
model.result('pg2').set('data', 'dset2');
model.result('pg2').create('surf1', 'Surface');
model.result('pg2').feature('surf1').set('expr', 'V');
model.result('pg2').feature('surf1').set('descractive', true);
model.result('pg2').feature('surf1').set('colortable', 'Dipole');
model.result('pg2').run;
model.result('pg2').setIndex('looplevel', 28, 0);
model.result('pg2').run;
model.result.create('pg3', 'PlotGroup1D');
model.result('pg3').run;
model.result('pg3').label('Log10|Z| - Fig.4');
model.result('pg3').set('data', 'dset2');
model.result('pg3').set('titletype', 'label');
model.result('pg3').set('showlegends', false);
model.result('pg3').create('glob1', 'Global');
model.result('pg3').feature('glob1').set('markerpos', 'datapoints');
model.result('pg3').feature('glob1').set('linewidth', 'preference');
model.result('pg3').feature('glob1').setIndex('expr', 'log10(abs(1/es.Y11)/1[ohm])', 0);
model.result('pg3').feature('glob1').setIndex('descr', 'log10|Z| (Ohms)', 0);
model.result('pg3').run;
model.result.create('pg4', 'PlotGroup2D');
model.result('pg4').run;
model.result('pg4').label('Displacement profile - Fig.5(a)');
model.result('pg4').set('data', 'dset2');
model.result('pg4').setIndex('looplevel', 28, 0);
model.result('pg4').set('titletype', 'label');
model.result('pg4').create('surf1', 'Surface');
model.result('pg4').feature('surf1').set('expr', 'sqrt(abs(u)^2+abs(v)^2)');
model.result('pg4').feature('surf1').set('rangecoloractive', true);
model.result('pg4').feature('surf1').set('rangecolormax', 0.02);
model.result('pg4').run;
model.result.dataset.create('cln1', 'CutLine2D');
model.result.dataset('cln1').set('data', 'dset2');
model.result.dataset('cln1').setIndex('genpoints', '4[um]', 0, 1);
model.result.dataset('cln1').setIndex('genpoints', '-20[um]', 1, 1);
model.result.create('pg5', 'PlotGroup1D');
model.result('pg5').run;
model.result('pg5').label('Y Displacement - Fig.5(b)');
model.result('pg5').set('data', 'cln1');
model.result('pg5').setIndex('looplevelinput', 'manual', 0);
model.result('pg5').setIndex('looplevel', [28], 0);
model.result('pg5').set('titletype', 'label');
model.result('pg5').set('axislimits', true);
model.result('pg5').set('xmin', -0.02);
model.result('pg5').set('xmax', 0.02);
model.result('pg5').set('ymin', -20.5);
model.result('pg5').set('ymax', 4.5);
model.result('pg5').create('lngr1', 'LineGraph');
model.result('pg5').feature('lngr1').set('markerpos', 'datapoints');
model.result('pg5').feature('lngr1').set('linewidth', 'preference');
model.result('pg5').feature('lngr1').set('expr', 'y');
model.result('pg5').feature('lngr1').set('xdata', 'expr');
model.result('pg5').feature('lngr1').set('xdataexpr', '-imag(v)');
model.result('pg5').feature('lngr1').set('xdatadescractive', true);
model.result('pg5').feature('lngr1').set('xdatadescr', 'Displacement, Y component');
model.result('pg5').feature('lngr1').set('linecolor', 'red');
model.result('pg5').feature('lngr1').set('linewidth', 2);
model.result('pg5').run;
model.result('pg5').create('lnsg1', 'LineSegments');
model.result('pg5').feature('lnsg1').set('markerpos', 'datapoints');
model.result('pg5').feature('lnsg1').set('linewidth', 'preference');
model.result('pg5').feature('lnsg1').setIndex('xexpr', -0.02, 0);
model.result('pg5').feature('lnsg1').setIndex('xexpr', 0.02, 1);
model.result('pg5').feature('lnsg1').setIndex('xexpr', 0.02, 2);
model.result('pg5').feature('lnsg1').setIndex('xexpr', -0.02, 3);
model.result('pg5').feature('lnsg1').setIndex('xexpr', -0.02, 4);
model.result('pg5').feature('lnsg1').setIndex('xexpr', 0.02, 5);
model.result('pg5').feature('lnsg1').setIndex('xexpr', 0.02, 6);
model.result('pg5').feature('lnsg1').setIndex('xexpr', -0.02, 7);
model.result('pg5').feature('lnsg1').setIndex('xexpr', -0.02, 8);
model.result('pg5').feature('lnsg1').setIndex('xexpr', 0.02, 9);
model.result('pg5').feature('lnsg1').setIndex('xexpr', 0.02, 10);
model.result('pg5').feature('lnsg1').setIndex('xexpr', -0.02, 11);
model.result('pg5').feature('lnsg1').setIndex('xexpr', -0.02, 12);
model.result('pg5').feature('lnsg1').setIndex('xexpr', 0.02, 13);
model.result('pg5').feature('lnsg1').setIndex('xexpr', 0.02, 14);
model.result('pg5').feature('lnsg1').setIndex('xexpr', -0.02, 15);
model.result('pg5').feature('lnsg1').setIndex('xexpr', -0.02, 16);
model.result('pg5').feature('lnsg1').setIndex('xexpr', 0.02, 17);
model.result('pg5').feature('lnsg1').setIndex('xexpr', 0.02, 18);
model.result('pg5').feature('lnsg1').setIndex('xexpr', -0.02, 19);
model.result('pg5').feature('lnsg1').setIndex('xexpr', -0.02, 20);
model.result('pg5').feature('lnsg1').setIndex('xexpr', 0.02, 21);
model.result('pg5').feature('lnsg1').setIndex('yexpr', '2*t_e+t_pe', 0);
model.result('pg5').feature('lnsg1').setIndex('yexpr', '2*t_e+t_pe', 1);
model.result('pg5').feature('lnsg1').setIndex('yexpr', 't_e+t_pe', 2);
model.result('pg5').feature('lnsg1').setIndex('yexpr', 't_e+t_pe', 3);
model.result('pg5').feature('lnsg1').setIndex('yexpr', 't_e', 4);
model.result('pg5').feature('lnsg1').setIndex('yexpr', 't_e', 5);
model.result('pg5').feature('lnsg1').setIndex('yexpr', 0, 6);
model.result('pg5').feature('lnsg1').setIndex('yexpr', 0, 7);
model.result('pg5').feature('lnsg1').setIndex('yexpr', '-t_lil', 8);
model.result('pg5').feature('lnsg1').setIndex('yexpr', '-t_lil', 9);
model.result('pg5').feature('lnsg1').setIndex('yexpr', '-t_lil-t_hil', 10);
model.result('pg5').feature('lnsg1').setIndex('yexpr', '-t_lil-t_hil', 11);
model.result('pg5').feature('lnsg1').setIndex('yexpr', '-2*t_lil-t_hil', 12);
model.result('pg5').feature('lnsg1').setIndex('yexpr', '-2*t_lil-t_hil', 13);
model.result('pg5').feature('lnsg1').setIndex('yexpr', '-2*t_lil-2*t_hil', 14);
model.result('pg5').feature('lnsg1').setIndex('yexpr', '-2*t_lil-2*t_hil', 15);
model.result('pg5').feature('lnsg1').setIndex('yexpr', '-3*t_lil-2*t_hil', 16);
model.result('pg5').feature('lnsg1').setIndex('yexpr', '-3*t_lil-2*t_hil', 17);
model.result('pg5').feature('lnsg1').setIndex('yexpr', '-3*t_lil-3*t_hil', 18);
model.result('pg5').feature('lnsg1').setIndex('yexpr', '-3*t_lil-3*t_hil', 19);
model.result('pg5').feature('lnsg1').setIndex('yexpr', '-3*t_lil-3*t_hil-t_i', 20);
model.result('pg5').feature('lnsg1').setIndex('yexpr', '-3*t_lil-3*t_hil-t_i', 21);
model.result('pg5').feature('lnsg1').set('linecolor', 'black');
model.result('pg5').run;
model.result('pg5').create('tlan1', 'TableAnnotation');
model.result('pg5').feature('tlan1').set('source', 'localtable');
model.result('pg5').feature('tlan1').setIndex('localtablematrix', -0.02, 0, 0);
model.result('pg5').feature('tlan1').setIndex('localtablematrix', 2, 0, 1);
model.result('pg5').feature('tlan1').setIndex('localtablematrix', 'ZnO', 0, 2);
model.result('pg5').feature('tlan1').setIndex('localtablematrix', -0.02, 1, 0);
model.result('pg5').feature('tlan1').setIndex('localtablematrix', -0.85, 1, 1);
model.result('pg5').feature('tlan1').setIndex('localtablematrix', 'SiO2', 1, 2);
model.result('pg5').feature('tlan1').setIndex('localtablematrix', -0.02, 2, 0);
model.result('pg5').feature('tlan1').setIndex('localtablematrix', -2.6, 2, 1);
model.result('pg5').feature('tlan1').setIndex('localtablematrix', 'Mo', 2, 2);
model.result('pg5').feature('tlan1').setIndex('localtablematrix', -0.02, 3, 0);
model.result('pg5').feature('tlan1').setIndex('localtablematrix', -4.3, 3, 1);
model.result('pg5').feature('tlan1').setIndex('localtablematrix', 'SiO2', 3, 2);
model.result('pg5').feature('tlan1').setIndex('localtablematrix', -0.02, 4, 0);
model.result('pg5').feature('tlan1').setIndex('localtablematrix', -6, 4, 1);
model.result('pg5').feature('tlan1').setIndex('localtablematrix', 'Mo', 4, 2);
model.result('pg5').feature('tlan1').setIndex('localtablematrix', -0.02, 5, 0);
model.result('pg5').feature('tlan1').setIndex('localtablematrix', -7.8, 5, 1);
model.result('pg5').feature('tlan1').setIndex('localtablematrix', 'SiO2', 5, 2);
model.result('pg5').feature('tlan1').setIndex('localtablematrix', -0.02, 6, 0);
model.result('pg5').feature('tlan1').setIndex('localtablematrix', -9.5, 6, 1);
model.result('pg5').feature('tlan1').setIndex('localtablematrix', 'Mo', 6, 2);
model.result('pg5').feature('tlan1').setIndex('localtablematrix', -0.02, 7, 0);
model.result('pg5').feature('tlan1').setIndex('localtablematrix', -14, 7, 1);
model.result('pg5').feature('tlan1').setIndex('localtablematrix', 'Substrate', 7, 2);
model.result('pg5').feature('tlan1').set('showpoint', false);
model.result('pg5').feature('tlan1').set('anchorpoint', 'middleleft');
model.result('pg5').run;

model.title('Solidly Mounted Resonator 2D');

model.description(['A solidly mounted resonator (SMR) is a piezoelectric MEMS resonator formed on top of an acoustic mirror stack deposited on a thick substrate. This tutorial shows how to simulate an SMR in 2D. In this example, the eigenmodes were computed and the frequency response from 500 to 1200' native2unicode(hex2dec({'00' 'a0'}), 'unicode') 'MHz was analyzed. The computed impedance curve and displacement profile agree reasonably well with the simulation results found in the literature.']);

model.label('solidly_mounted_resonator_2d.mph');

model.result('pg5').run;

model.cpl.create('intop1', 'Integration', 'geom1');
model.cpl('intop1').set('axisym', true);
model.cpl('intop1').selection.geom('geom1', 1);
model.cpl('intop1').selection.set([44]);

model.study('std1').feature('eig').set('neigs', 30);
model.study('std1').feature('eig').set('shift', '855');
model.study('std1').create('cmbsol', 'CombineSolution');
model.study('std1').feature('cmbsol').set('soloper', 'remsol');
model.study('std1').feature('cmbsol').set('excmethod', 'implicit');
model.study('std1').feature('cmbsol').set('remsolfromexprexc', 'abs(comp1.intop1(comp1.v))/comp1.intop1(abs(comp1.v))<0.99');

model.sol('sol1').study('std1');
model.sol('sol1').feature.remove('e1');
model.sol('sol1').feature.remove('v1');
model.sol('sol1').feature.remove('st1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'eig');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').set('control', 'eig');
model.sol('sol1').create('e1', 'Eigenvalue');
model.sol('sol1').feature('e1').set('eigvfunscale', 'maximum');
model.sol('sol1').feature('e1').set('eigvfunscaleparam', '1.0E-9');
model.sol('sol1').feature('e1').set('control', 'eig');
model.sol('sol1').feature('e1').feature('aDef').set('cachepattern', true);
model.sol('sol1').create('su1', 'StoreSolution');
model.sol('sol1').create('cms1', 'CombineSolution');
model.sol('sol1').feature('cms1').set('control', 'cmbsol');
model.sol('sol1').feature('cms1').set('solnum', 'all');
model.sol('sol1').feature('cms1').set('solvertype', 'solnum');
model.sol('sol1').attach('std1');
model.sol('sol1').runAll;

model.result('pg1').run;

model.study.create('std3');
model.study('std3').create('ref', 'StudyReference');
model.study('std3').feature('ref').set('studyref', 'std1');
model.study('std3').create('uq', 'UncertaintyQuantification');
model.study('std3').label('Study 3 - Screening');
model.study('std3').feature('uq').setIndex('qoiexpression', '', 0);
model.study('std3').feature('uq').setIndex('descr', '', 0);
model.study('std3').feature('uq').setIndex('qoisolutionindv', 'parent', 0);
model.study('std3').feature('uq').setIndex('failif', 'larger', 0);
model.study('std3').feature('uq').setIndex('threshold', '', 0);
model.study('std3').feature('uq').setIndex('qoiexpression', '', 0);
model.study('std3').feature('uq').setIndex('descr', '', 0);
model.study('std3').feature('uq').setIndex('qoisolutionindv', 'parent', 0);
model.study('std3').feature('uq').setIndex('failif', 'larger', 0);
model.study('std3').feature('uq').setIndex('threshold', '', 0);
model.study('std3').feature('uq').setIndex('qoiexpression', 'real(freq)', 0);
model.study('std3').feature('uq').setIndex('pname', 'E_Al', 0);
model.study('std3').feature('uq').setEntry('sourceType', 'col1', 'analytic');
model.study('std3').feature('uq').setIndex('paramDescription', 'Pa', 0);
model.study('std3').feature('uq').setIndex('pname', 'E_Al', 0);
model.study('std3').feature('uq').setEntry('sourceType', 'col1', 'analytic');
model.study('std3').feature('uq').setIndex('paramDescription', 'Pa', 0);
model.study('std3').feature('uq').setIndex('pname', 't_pe', 0);
model.study('std3').feature('uq').setEntry('distributionselection', 'col1', 'normal');
model.study('std3').feature('uq').setEntry('s1selection', 'col1', 't_pe');
model.study('std3').feature('uq').setEntry('s2selection', 'col1', '0.005*t_pe');
model.study('std3').feature('uq').setEntry('lcdfselection', 'col1', 'manual');
model.study('std3').feature('uq').setEntry('lboundselection', 'col1', 't_pe-2*0.005*t_pe');
model.study('std3').feature('uq').setEntry('ucdfselection', 'col1', 'manual');
model.study('std3').feature('uq').setEntry('uboundselection', 'col1', 't_pe+2*0.005*t_pe');
model.study('std3').feature('uq').setIndex('pname', 'E_Al', 1);
model.study('std3').feature('uq').setEntry('sourceType', 'col2', 'analytic');
model.study('std3').feature('uq').setIndex('paramDescription', 'Pa', 1);
model.study('std3').feature('uq').setIndex('pname', 'E_Al', 1);
model.study('std3').feature('uq').setEntry('sourceType', 'col2', 'analytic');
model.study('std3').feature('uq').setIndex('paramDescription', 'Pa', 1);
model.study('std3').feature('uq').setIndex('pname', 't_lil', 1);
model.study('std3').feature('uq').setEntry('distributionselection', 'col2', 'normal');
model.study('std3').feature('uq').setEntry('s1selection', 'col2', 't_lil');
model.study('std3').feature('uq').setEntry('s2selection', 'col2', '0.005*t_lil');
model.study('std3').feature('uq').setEntry('lcdfselection', 'col2', 'manual');
model.study('std3').feature('uq').setEntry('ucdfselection', 'col2', 'manual');
model.study('std3').feature('uq').setEntry('lboundselection', 'col2', 't_lil-2*0.005*t_lil');
model.study('std3').feature('uq').setEntry('uboundselection', 'col2', 't_lil+2*0.005*t_lil');
model.study('std3').feature('uq').setIndex('pname', 'E_Al', 2);
model.study('std3').feature('uq').setEntry('sourceType', 'col3', 'analytic');
model.study('std3').feature('uq').setIndex('paramDescription', 'Pa', 2);
model.study('std3').feature('uq').setIndex('pname', 'E_Al', 2);
model.study('std3').feature('uq').setEntry('sourceType', 'col3', 'analytic');
model.study('std3').feature('uq').setIndex('paramDescription', 'Pa', 2);
model.study('std3').feature('uq').setIndex('pname', 't_hil', 2);
model.study('std3').feature('uq').setEntry('distributionselection', 'col3', 'normal');
model.study('std3').feature('uq').setEntry('s1selection', 'col3', 't_hil');
model.study('std3').feature('uq').setEntry('s2selection', 'col3', '0.005*t_hil');
model.study('std3').feature('uq').setEntry('lcdfselection', 'col3', 'manual');
model.study('std3').feature('uq').setEntry('ucdfselection', 'col3', 'manual');
model.study('std3').feature('uq').setEntry('lboundselection', 'col3', 't_hil-2*0.005*t_hil');
model.study('std3').feature('uq').setEntry('uboundselection', 'col3', 't_hil+2*0.005*t_hil');
model.study('std3').feature('uq').setIndex('pname', 'E_Al', 3);
model.study('std3').feature('uq').setEntry('sourceType', 'col4', 'analytic');
model.study('std3').feature('uq').setIndex('paramDescription', 'Pa', 3);
model.study('std3').feature('uq').setIndex('pname', 'E_Al', 3);
model.study('std3').feature('uq').setEntry('sourceType', 'col4', 'analytic');
model.study('std3').feature('uq').setIndex('paramDescription', 'Pa', 3);
model.study('std3').feature('uq').setIndex('pname', 't_e', 3);
model.study('std3').feature('uq').setEntry('distributionselection', 'col4', 'normal');
model.study('std3').feature('uq').setEntry('s1selection', 'col4', 't_e');
model.study('std3').feature('uq').setEntry('s2selection', 'col4', '0.005*t_e');
model.study('std3').feature('uq').setEntry('lcdfselection', 'col4', 'manual');
model.study('std3').feature('uq').setEntry('ucdfselection', 'col4', 'manual');
model.study('std3').feature('uq').setEntry('lboundselection', 'col4', 't_e-2*0.005*t_e');
model.study('std3').feature('uq').setEntry('uboundselection', 'col4', 't_e+2*0.005*t_e');
model.study('std3').feature('uq').set('errorhandling', 'later');

model.sol.create('sol4');
model.sol('sol4').study('std3');
model.sol('sol1').study('std1');
model.sol('sol3').copySolution('sol5');

model.result.dataset('dset3').set('solution', 'none');

model.sol('sol1').feature.remove('cms1');
model.sol('sol1').feature.remove('su1');
model.sol('sol1').feature.remove('e1');
model.sol('sol1').feature.remove('v1');
model.sol('sol1').feature.remove('st1');
model.sol('sol5').copySolution('sol3');
model.sol.remove('sol5');
model.sol('sol3').label('Solution Store 1');

model.result.dataset.remove('dset6');

model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'eig');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').set('control', 'eig');
model.sol('sol1').create('e1', 'Eigenvalue');
model.sol('sol1').feature('e1').set('eigvfunscale', 'maximum');
model.sol('sol1').feature('e1').set('eigvfunscaleparam', '1.0E-9');
model.sol('sol1').feature('e1').set('control', 'eig');
model.sol('sol1').feature('e1').feature('aDef').set('cachepattern', true);
model.sol('sol1').create('su1', 'StoreSolution');
model.sol('sol1').feature('su1').set('sol', 'sol3');
model.sol('sol1').feature('su1').label('Solution Store 1');
model.sol('sol1').create('cms1', 'CombineSolution');
model.sol('sol1').feature('cms1').set('control', 'cmbsol');

model.result.dataset('dset3').set('solution', 'sol3');

model.sol('sol1').feature('cms1').set('solnum', 'all');
model.sol('sol1').feature('cms1').set('solvertype', 'solnum');
model.sol('sol1').attach('std1');
model.sol('sol4').create('copy1', 'CopySolution');
model.sol('sol4').feature('copy1').set('sol', 'sol1');
model.sol('sol4').attach('std3');
model.sol('sol1').study('std1');
model.sol('sol3').copySolution('sol5');

model.result.dataset('dset3').set('solution', 'none');

model.sol('sol1').feature.remove('cms1');
model.sol('sol1').feature.remove('su1');
model.sol('sol1').feature.remove('e1');
model.sol('sol1').feature.remove('v1');
model.sol('sol1').feature.remove('st1');
model.sol('sol5').copySolution('sol3');
model.sol.remove('sol5');
model.sol('sol3').label('Solution Store 1');

model.result.dataset.remove('dset6');

model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'eig');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').set('control', 'eig');
model.sol('sol1').create('e1', 'Eigenvalue');
model.sol('sol1').feature('e1').set('eigvfunscale', 'maximum');
model.sol('sol1').feature('e1').set('eigvfunscaleparam', '1.0E-9');
model.sol('sol1').feature('e1').set('control', 'eig');
model.sol('sol1').feature('e1').feature('aDef').set('cachepattern', true);
model.sol('sol1').create('su1', 'StoreSolution');
model.sol('sol1').feature('su1').set('sol', 'sol3');
model.sol('sol1').feature('su1').label('Solution Store 1');
model.sol('sol1').create('cms1', 'CombineSolution');
model.sol('sol1').feature('cms1').set('control', 'cmbsol');

model.result.dataset('dset3').set('solution', 'sol3');

model.sol('sol1').feature('cms1').set('solnum', 'all');
model.sol('sol1').feature('cms1').set('solvertype', 'solnum');
model.sol('sol1').attach('std1');

model.study('std3').feature('uq').set('computeaction', 'recompute');
model.study('std3').feature('uq').set('verifyaction', 'recompute');

model.batch.create('uq1', 'UncertaintyQuantification');
model.batch('uq1').study('std3');
model.batch('uq1').attach('std3');
model.batch('pd1').create('so1', 'Solutionseq');
model.batch('pd1').feature('so1').set('seq', 'sol1');
model.batch('pd1').feature('so1').set('store', 'on');
model.batch('pd1').feature('so1').set('clear', 'on');
model.batch('pd1').feature('so1').set('psol', 'none');
model.batch('pd1').create('so2', 'Solutionseq');
model.batch('pd1').feature('so2').set('seq', 'sol4');
model.batch('pd1').feature('so2').set('store', 'on');
model.batch('pd1').feature('so2').set('clear', 'on');
model.batch('pd1').feature('so2').set('psol', 'none');
model.batch('pd1').attach('std3');
model.batch('uq1').set('control', 'uq');
model.batch('pd1').set('control', 'uq');

model.study('std3').feature('uq').set('computeaction', 'recompute');
model.study('std3').feature('uq').set('verifyaction', 'recompute');

model.sol.create('sol5');
model.sol('sol5').study('std3');
model.sol('sol5').label('Parametric Solutions 1');

model.batch('pd1').feature('so2').set('psol', 'sol5');
model.batch('uq1').run('compute');

model.result('pg6').run;

model.study.create('std4');
model.study('std4').feature.copy('uq', 'std3/uq', '');
model.study('std4').feature.copy('ref', 'std3/ref', '');
model.study('std4').feature('uq').set('uqtype', 'screening');
model.study('std4').feature('uq').set('uqresultgrp', 'new');
model.study('std4').feature('uq').set('uqtype', 'sensitivityanalysis');
model.study('std4').feature('uq').set('uqresultgrp', 'new');
model.study('std4').feature('uq').set('uqtype', 'uncertaintypropagation');
model.study('std4').feature('uq').set('uqresultgrp', 'new');
model.study('std4').feature('uq').set('uqtype', 'reliabilityanalysis');
model.study('std4').feature('uq').set('uqresultgrp', 'new');
model.study('std4').feature('uq').set('uqtype', 'inverseuq');
model.study('std4').feature('uq').set('uqresultgrp', 'new');
model.study('std4').feature('uq').set('uqtype', 'sensitivityanalysis');
model.study('std4').feature('uq').set('computeaction', 'recompute');
model.study('std4').feature('uq').set('designtable', 'new');
model.study('std4').feature('uq').set('verifyaction', 'recompute');
model.study('std4').feature('uq').set('tablegraphgrp', 'new');
model.study('std4').label('Study 4 - Sensitivity Analysis');
model.study('std4').feature('uq').set('selected', {'2'});
model.study('std4').feature('uq').set('distributionselection', {'col1' 'normal' 'col2' 'normal' 'col3' 'normal'});
model.study('std4').feature('uq').set('s1selection', {'col1' 't_pe' 'col2' 't_lil' 'col3' 't_e'});
model.study('std4').feature('uq').set('s2selection', {'col1' '0.005*t_pe' 'col2' '0.005*t_lil' 'col3' '0.005*t_e'});
model.study('std4').feature('uq').set('lcdfselection', {'col1' 'manual' 'col2' 'manual' 'col3' 'manual'});
model.study('std4').feature('uq').set('lboundselection', {'col1' 't_pe-2*0.005*t_pe' 'col2' 't_lil-2*0.005*t_lil' 'col3' 't_e-2*0.005*t_e'});
model.study('std4').feature('uq').set('ucdfselection', {'col1' 'manual' 'col2' 'manual' 'col3' 'manual'});
model.study('std4').feature('uq').set('uboundselection', {'col1' 't_pe+2*0.005*t_pe' 'col2' 't_lil+2*0.005*t_lil' 'col3' 't_e+2*0.005*t_e'});
model.study('std4').feature('uq').set('punitselection', {'col1' 'm' 'col2' 'm' 'col3' 'm'});
model.study('std4').feature('uq').set('inputdatasource', {'col1' 'specified' 'col2' 'specified' 'col3' 'specified'});
model.study('std4').feature('uq').set('tablecolumnselection', {'col1' '' 'col2' '' 'col3' ''});
model.study('std4').feature('uq').set('plistarrselection', {'col1' '' 'col2' '' 'col3' ''});
model.study('std4').feature('uq').set('plistarrsizeselection', {'col1' '' 'col2' '' 'col3' ''});
model.study('std4').feature('uq').remove('sourceType', 2);
model.study('std4').feature('uq').remove('paramDescription', 2);
model.study('std4').feature('uq').remove('pname', [2]);

model.sol.create('sol7');
model.sol('sol7').study('std4');
model.sol('sol1').study('std1');
model.sol('sol3').copySolution('sol8');

model.result.dataset('dset3').set('solution', 'none');

model.sol('sol1').feature.remove('cms1');
model.sol('sol1').feature.remove('su1');
model.sol('sol1').feature.remove('e1');
model.sol('sol1').feature.remove('v1');
model.sol('sol1').feature.remove('st1');
model.sol('sol8').copySolution('sol3');
model.sol.remove('sol8');
model.sol('sol3').label('Solution Store 1');

model.result.dataset.remove('dset8');

model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'eig');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').set('control', 'eig');
model.sol('sol1').create('e1', 'Eigenvalue');
model.sol('sol1').feature('e1').set('eigvfunscale', 'maximum');
model.sol('sol1').feature('e1').set('eigvfunscaleparam', '1.0E-9');
model.sol('sol1').feature('e1').set('control', 'eig');
model.sol('sol1').feature('e1').feature('aDef').set('cachepattern', true);
model.sol('sol1').create('su1', 'StoreSolution');
model.sol('sol1').feature('su1').set('sol', 'sol3');
model.sol('sol1').feature('su1').label('Solution Store 1');
model.sol('sol1').create('cms1', 'CombineSolution');
model.sol('sol1').feature('cms1').set('control', 'cmbsol');

model.result.dataset('dset3').set('solution', 'sol3');

model.sol('sol1').feature('cms1').set('solnum', 'all');
model.sol('sol1').feature('cms1').set('solvertype', 'solnum');
model.sol('sol1').attach('std1');
model.sol('sol7').create('copy1', 'CopySolution');
model.sol('sol7').feature('copy1').set('sol', 'sol1');
model.sol('sol7').attach('std4');
model.sol('sol1').study('std1');
model.sol('sol3').copySolution('sol8');

model.result.dataset('dset3').set('solution', 'none');

model.sol('sol1').feature.remove('cms1');
model.sol('sol1').feature.remove('su1');
model.sol('sol1').feature.remove('e1');
model.sol('sol1').feature.remove('v1');
model.sol('sol1').feature.remove('st1');
model.sol('sol8').copySolution('sol3');
model.sol.remove('sol8');
model.sol('sol3').label('Solution Store 1');

model.result.dataset.remove('dset8');

model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'eig');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').set('control', 'eig');
model.sol('sol1').create('e1', 'Eigenvalue');
model.sol('sol1').feature('e1').set('eigvfunscale', 'maximum');
model.sol('sol1').feature('e1').set('eigvfunscaleparam', '1.0E-9');
model.sol('sol1').feature('e1').set('control', 'eig');
model.sol('sol1').feature('e1').feature('aDef').set('cachepattern', true);
model.sol('sol1').create('su1', 'StoreSolution');
model.sol('sol1').feature('su1').set('sol', 'sol3');
model.sol('sol1').feature('su1').label('Solution Store 1');
model.sol('sol1').create('cms1', 'CombineSolution');
model.sol('sol1').feature('cms1').set('control', 'cmbsol');

model.result.dataset('dset3').set('solution', 'sol3');

model.sol('sol1').feature('cms1').set('solnum', 'all');
model.sol('sol1').feature('cms1').set('solvertype', 'solnum');
model.sol('sol1').attach('std1');

model.study('std4').feature('uq').set('computeaction', 'recompute');
model.study('std4').feature('uq').set('verifyaction', 'recompute');

model.batch.create('uq2', 'UncertaintyQuantification');
model.batch('uq2').study('std4');
model.batch('uq2').attach('std4');
model.batch('pd2').create('so1', 'Solutionseq');
model.batch('pd2').feature('so1').set('seq', 'sol1');
model.batch('pd2').feature('so1').set('store', 'on');
model.batch('pd2').feature('so1').set('clear', 'on');
model.batch('pd2').feature('so1').set('psol', 'none');
model.batch('pd2').create('so2', 'Solutionseq');
model.batch('pd2').feature('so2').set('seq', 'sol7');
model.batch('pd2').feature('so2').set('store', 'on');
model.batch('pd2').feature('so2').set('clear', 'on');
model.batch('pd2').feature('so2').set('psol', 'none');
model.batch('pd2').attach('std4');
model.batch('uq2').set('control', 'uq');
model.batch('pd2').set('control', 'uq');

model.study('std4').feature('uq').set('computeaction', 'recompute');
model.study('std4').feature('uq').set('verifyaction', 'recompute');

model.sol.create('sol8');
model.sol('sol8').study('std4');
model.sol('sol8').label('Parametric Solutions 2');

model.batch('pd2').feature('so2').set('psol', 'sol8');
model.batch('uq2').run('compute');

model.result('pg7').run;

model.study.create('std5');
model.study('std5').feature.copy('uq', 'std4/uq', '');
model.study('std5').feature.copy('ref', 'std4/ref', '');
model.study('std5').feature('uq').set('uqtype', 'screening');
model.study('std5').feature('uq').set('uqresultgrp', 'new');
model.study('std5').feature('uq').set('uqtype', 'sensitivityanalysis');
model.study('std5').feature('uq').set('uqresultgrp', 'new');
model.study('std5').feature('uq').set('uqtype', 'uncertaintypropagation');
model.study('std5').feature('uq').set('uqresultgrp', 'new');
model.study('std5').feature('uq').set('uqtype', 'reliabilityanalysis');
model.study('std5').feature('uq').set('uqresultgrp', 'new');
model.study('std5').feature('uq').set('uqtype', 'inverseuq');
model.study('std5').feature('uq').set('uqresultgrp', 'new');
model.study('std5').feature('uq').set('uqtype', 'uncertaintypropagation');

model.func.create('gpm1', 'GaussianProcess');
model.func('gpm1').active(false);

model.study('std5').feature('uq').set('globalgpfunction', 'gpm1');

model.result.table.create('tbl8', 'Table');
model.result.table('tbl8').addRows([3.351636369717934E-6 1.6503485728934143E-6 2.0126316686528022E-7 8.69934513461777E8; 3.3306641098609407E-6 1.6627327678798516E-6 2.0060305889037571E-7 8.73276345034453E8; 3.3606016618469106E-6 1.6427041251469649E-6 2.0101256056114026E-7 8.688120388032137E8; 3.3378373111277173E-6 1.6589523626221244E-6 1.99834622545504E-7 8.722912956777637E8; 3.340499287026675E-6 1.6488155716117903E-6 1.987826874578544E-7 8.72801299156766E8; 3.354330187575892E-6 1.6647324619615637E-6 1.994708007083896E-7 8.685686523487864E8; 3.3467142208959724E-6 1.6420156638538379E-6 2.0175234540414562E-7 8.715147739705293E8; 3.3695185501810336E-6 1.6468847534800963E-6 1.9918232425690644E-7 8.670473491836149E8; 3.3632901132427974E-6 1.6359901913666403E-6 1.9923017253806183E-7 8.691765987163684E8; 3.3425621514578717E-6 1.6381771668282064E-6 1.9906624946616931E-7 8.73207626380628E8; 3.3278781351336986E-6 1.6409641658377469E-6 2.0044948764779644E-7 8.756813668725257E8; 3.350944106165254E-6 1.6570253392757538E-6 2.0058538403222916E-7 8.696594758916099E8; 3.3338104830825876E-6 1.6461324264419245E-6 1.997163360398743E-7 8.74192497815722E8; 3.3724511599030907E-6 1.650855004417973E-6 2.0070532414133465E-7 8.658390207532756E8; 3.364774867008596E-6 1.6563414709563474E-6 1.9825196045365357E-7 8.674059126169465E8; 3.3390461857785214E-6 1.6553497535346282E-6 2.015566008334717E-7 8.720009638991246E8; 3.3777284357278925E-6 1.6450206115323086E-6 2.000604046879065E-7 8.653905088574055E8; 3.3573093657358743E-6 1.6390054302599132E-6 2.0010889062348566E-7 8.699558145131307E8; 3.3734479564735982E-6 1.6578076867670101E-6 1.9992677790829177E-7 8.652278274338536E8; 3.359696045432886E-6 1.6529303918305411E-6 1.9950285650689974E-7 8.68454096230605E8; 3.344380513082959E-6 1.6513910199225657E-6 1.9986570926977843E-7 8.715880296361048E8; 3.3539689176463533E-6 1.6482831246093116E-6 1.9863159576469445E-7 8.701578580230817E8; 3.3493543207666656E-6 1.6452209879560905E-6 1.9959729493956454E-7 8.711471680585154E8; 3.3653651178220683E-6 1.6609950640027788E-6 2.0089649637219377E-7 8.66386959485462E8; 3.3474950756247107E-6 1.6548275786896476E-6 1.989226102346875E-7 8.708645339899684E8; 3.3242419182653175E-6 1.6520193717836707E-6 2.0016753695178735E-7 8.755579705877565E8; 3.345476777232826E-6 1.6441334396668884E-6 2.0038783702287505E-7 8.718617011259023E8; 3.3554532961999386E-6 1.649611568650628E-6 2.00243858744113E-7 8.694304651697404E8; 3.321005665817592E-6 1.6533857555942353E-6 1.9932741220089306E-7 8.762727759386092E8; 3.3350333471686894E-6 1.6475235207039397E-6 2.0115363947234712E-7 8.735410506045892E8]);

model.func('gpm1').set('source', 'resultTable');
model.func('gpm1').set('resultTable', 'tbl8');
model.func('gpm1').set('ignorenaninf', true);

model.study('std5').feature('uq').set('designtable', 'tbl8');

model.func('gpm1').set('covfunction', 'matern32');
model.func('gpm1').set('meanfunction', 'const');
model.func('gpm1').set('improvementfunction', 'entropy');
model.func('gpm1').set('lastinternalseed', 1014);
model.func('gpm1').set('gpadpoptmethod', 'direct');
model.func('gpm1').set('maxgpevals', 10000);
model.func('gpm1').set('maxgpiters', 500);
model.func('gpm1').set('adpevals', 10000);
model.func('gpm1').set('setupfromstudy', 'on');
model.func('gpm1').setEntry('distributionselection', 'col1', 'normal');
model.func('gpm1').setEntry('s1selection', 'col1', '3.35E-6');
model.func('gpm1').setEntry('s2selection', 'col1', '1.675E-8');
model.func('gpm1').setEntry('lboundselection', 'col1', '3.3165E-6');
model.func('gpm1').setEntry('uboundselection', 'col1', '3.3835000000000003E-6');
model.func('gpm1').setEntry('lcdfselection', 'col1', 'manual');
model.func('gpm1').setEntry('ucdfselection', 'col1', 'manual');
model.func('gpm1').setEntry('distributionselection', 'col2', 'normal');
model.func('gpm1').setEntry('s1selection', 'col2', '1.6499999999999999E-6');
model.func('gpm1').setEntry('s2selection', 'col2', '8.25E-9');
model.func('gpm1').setEntry('lboundselection', 'col2', '1.6335E-6');
model.func('gpm1').setEntry('uboundselection', 'col2', '1.6664999999999998E-6');
model.func('gpm1').setEntry('lcdfselection', 'col2', 'manual');
model.func('gpm1').setEntry('ucdfselection', 'col2', 'manual');
model.func('gpm1').setEntry('distributionselection', 'col3', 'normal');
model.func('gpm1').setEntry('s1selection', 'col3', '2.0000000000000002E-7');
model.func('gpm1').setEntry('s2selection', 'col3', '1.0E-9');
model.func('gpm1').setEntry('lboundselection', 'col3', '1.9800000000000003E-7');
model.func('gpm1').setEntry('uboundselection', 'col3', '2.02E-7');
model.func('gpm1').setEntry('lcdfselection', 'col3', 'manual');
model.func('gpm1').setEntry('ucdfselection', 'col3', 'manual');
model.func('gpm1').setEntry('args', 'col1', 't_pe');
model.func('gpm1').setEntry('unit', 'col1', 'm');
model.func('gpm1').setEntry('columnType', 'col2', 'arg');
model.func('gpm1').setEntry('args', 'col2', 't_lil');
model.func('gpm1').setEntry('unit', 'col2', 'm');
model.func('gpm1').setEntry('columnType', 'col3', 'arg');
model.func('gpm1').setEntry('args', 'col3', 't_e');
model.func('gpm1').setEntry('unit', 'col3', 'm');
model.func('gpm1').setEntry('funcs', 'col4', 'gpm1_1');

model.study('std5').feature('uq').set('computeaction', 'append');
model.study('std5').feature('uq').set('tablegraphgrp', 'new');
model.study('std5').label('Study 5 - Uncertainty Propagation');
model.study('std5').feature('uq').set('computeaction', 'analysis');

model.sol.create('sol10');
model.sol('sol10').study('std5');
model.sol('sol1').study('std1');
model.sol('sol3').copySolution('sol11');

model.result.dataset('dset3').set('solution', 'none');

model.sol('sol1').feature.remove('cms1');
model.sol('sol1').feature.remove('su1');
model.sol('sol1').feature.remove('e1');
model.sol('sol1').feature.remove('v1');
model.sol('sol1').feature.remove('st1');
model.sol('sol11').copySolution('sol3');
model.sol.remove('sol11');
model.sol('sol3').label('Solution Store 1');

model.result.dataset.remove('dset10');

model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'eig');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').set('control', 'eig');
model.sol('sol1').create('e1', 'Eigenvalue');
model.sol('sol1').feature('e1').set('eigvfunscale', 'maximum');
model.sol('sol1').feature('e1').set('eigvfunscaleparam', '1.0E-9');
model.sol('sol1').feature('e1').set('control', 'eig');
model.sol('sol1').feature('e1').feature('aDef').set('cachepattern', true);
model.sol('sol1').create('su1', 'StoreSolution');
model.sol('sol1').feature('su1').set('sol', 'sol3');
model.sol('sol1').feature('su1').label('Solution Store 1');
model.sol('sol1').create('cms1', 'CombineSolution');
model.sol('sol1').feature('cms1').set('control', 'cmbsol');

model.result.dataset('dset3').set('solution', 'sol3');

model.sol('sol1').feature('cms1').set('solnum', 'all');
model.sol('sol1').feature('cms1').set('solvertype', 'solnum');
model.sol('sol1').attach('std1');
model.sol('sol10').create('copy1', 'CopySolution');
model.sol('sol10').feature('copy1').set('sol', 'sol1');
model.sol('sol10').attach('std5');
model.sol('sol1').study('std1');
model.sol('sol3').copySolution('sol11');

model.result.dataset('dset3').set('solution', 'none');

model.sol('sol1').feature.remove('cms1');
model.sol('sol1').feature.remove('su1');
model.sol('sol1').feature.remove('e1');
model.sol('sol1').feature.remove('v1');
model.sol('sol1').feature.remove('st1');
model.sol('sol11').copySolution('sol3');
model.sol.remove('sol11');
model.sol('sol3').label('Solution Store 1');

model.result.dataset.remove('dset10');

model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'eig');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').set('control', 'eig');
model.sol('sol1').create('e1', 'Eigenvalue');
model.sol('sol1').feature('e1').set('eigvfunscale', 'maximum');
model.sol('sol1').feature('e1').set('eigvfunscaleparam', '1.0E-9');
model.sol('sol1').feature('e1').set('control', 'eig');
model.sol('sol1').feature('e1').feature('aDef').set('cachepattern', true);
model.sol('sol1').create('su1', 'StoreSolution');
model.sol('sol1').feature('su1').set('sol', 'sol3');
model.sol('sol1').feature('su1').label('Solution Store 1');
model.sol('sol1').create('cms1', 'CombineSolution');
model.sol('sol1').feature('cms1').set('control', 'cmbsol');

model.result.dataset('dset3').set('solution', 'sol3');

model.sol('sol1').feature('cms1').set('solnum', 'all');
model.sol('sol1').feature('cms1').set('solvertype', 'solnum');
model.sol('sol1').attach('std1');

model.study('std5').feature('uq').set('computeaction', 'recompute');
model.study('std5').feature('uq').set('verifyaction', 'recompute');

model.batch.create('uq3', 'UncertaintyQuantification');
model.batch('uq3').study('std5');
model.batch('uq3').attach('std5');
model.batch('pd3').create('so1', 'Solutionseq');
model.batch('pd3').feature('so1').set('seq', 'sol1');
model.batch('pd3').feature('so1').set('store', 'on');
model.batch('pd3').feature('so1').set('clear', 'on');
model.batch('pd3').feature('so1').set('psol', 'none');
model.batch('pd3').create('so2', 'Solutionseq');
model.batch('pd3').feature('so2').set('seq', 'sol10');
model.batch('pd3').feature('so2').set('store', 'on');
model.batch('pd3').feature('so2').set('clear', 'on');
model.batch('pd3').feature('so2').set('psol', 'none');
model.batch('pd3').attach('std5');
model.batch('uq3').set('control', 'uq');
model.batch('pd3').set('control', 'uq');

model.study('std5').feature('uq').set('computeaction', 'analysis');
model.study('std5').feature('uq').set('verifyaction', 'recompute');

model.sol.create('sol11');
model.sol('sol11').study('std5');
model.sol('sol11').label('Parametric Solutions 3');

model.batch('pd3').feature('so2').set('psol', 'sol11');
model.batch('uq3').run('compute');

model.result('pg8').run;
model.result('pg8').run;

model.study.create('std6');
model.study('std6').feature.copy('uq', 'std5/uq', '');
model.study('std6').feature.copy('ref', 'std5/ref', '');
model.study('std6').feature('uq').set('uqtype', 'screening');
model.study('std6').feature('uq').set('uqresultgrp', 'new');
model.study('std6').feature('uq').set('uqtype', 'sensitivityanalysis');
model.study('std6').feature('uq').set('uqresultgrp', 'new');
model.study('std6').feature('uq').set('uqtype', 'uncertaintypropagation');
model.study('std6').feature('uq').set('uqresultgrp', 'new');
model.study('std6').feature('uq').set('uqtype', 'reliabilityanalysis');
model.study('std6').feature('uq').set('uqresultgrp', 'new');
model.study('std6').feature('uq').set('uqtype', 'inverseuq');
model.study('std6').feature('uq').set('uqresultgrp', 'new');
model.study('std6').feature('uq').set('uqtype', 'reliabilityanalysis');

model.func.duplicate('gpm2', 'gpm1');

model.study('std6').feature('uq').set('globalgpfunction', 'gpm2');

model.result.table.create('tbl17', 'Table');
model.result.table('tbl17').addRows([3.351636369717934E-6 1.6503485728934143E-6 2.0126316686528022E-7 8.69934513461777E8; 3.3306641098609407E-6 1.6627327678798516E-6 2.0060305889037571E-7 8.73276345034453E8; 3.3606016618469106E-6 1.6427041251469649E-6 2.0101256056114026E-7 8.688120388032137E8; 3.3378373111277173E-6 1.6589523626221244E-6 1.99834622545504E-7 8.722912956777637E8; 3.340499287026675E-6 1.6488155716117903E-6 1.987826874578544E-7 8.72801299156766E8; 3.354330187575892E-6 1.6647324619615637E-6 1.994708007083896E-7 8.685686523487864E8; 3.3467142208959724E-6 1.6420156638538379E-6 2.0175234540414562E-7 8.715147739705293E8; 3.3695185501810336E-6 1.6468847534800963E-6 1.9918232425690644E-7 8.670473491836149E8; 3.3632901132427974E-6 1.6359901913666403E-6 1.9923017253806183E-7 8.691765987163684E8; 3.3425621514578717E-6 1.6381771668282064E-6 1.9906624946616931E-7 8.73207626380628E8; 3.3278781351336986E-6 1.6409641658377469E-6 2.0044948764779644E-7 8.756813668725257E8; 3.350944106165254E-6 1.6570253392757538E-6 2.0058538403222916E-7 8.696594758916099E8; 3.3338104830825876E-6 1.6461324264419245E-6 1.997163360398743E-7 8.74192497815722E8; 3.3724511599030907E-6 1.650855004417973E-6 2.0070532414133465E-7 8.658390207532756E8; 3.364774867008596E-6 1.6563414709563474E-6 1.9825196045365357E-7 8.674059126169465E8; 3.3390461857785214E-6 1.6553497535346282E-6 2.015566008334717E-7 8.720009638991246E8; 3.3777284357278925E-6 1.6450206115323086E-6 2.000604046879065E-7 8.653905088574055E8; 3.3573093657358743E-6 1.6390054302599132E-6 2.0010889062348566E-7 8.699558145131307E8; 3.3734479564735982E-6 1.6578076867670101E-6 1.9992677790829177E-7 8.652278274338536E8; 3.359696045432886E-6 1.6529303918305411E-6 1.9950285650689974E-7 8.68454096230605E8; 3.344380513082959E-6 1.6513910199225657E-6 1.9986570926977843E-7 8.715880296361048E8; 3.3539689176463533E-6 1.6482831246093116E-6 1.9863159576469445E-7 8.701578580230817E8; 3.3493543207666656E-6 1.6452209879560905E-6 1.9959729493956454E-7 8.711471680585154E8; 3.3653651178220683E-6 1.6609950640027788E-6 2.0089649637219377E-7 8.66386959485462E8; 3.3474950756247107E-6 1.6548275786896476E-6 1.989226102346875E-7 8.708645339899684E8; 3.3242419182653175E-6 1.6520193717836707E-6 2.0016753695178735E-7 8.755579705877565E8; 3.345476777232826E-6 1.6441334396668884E-6 2.0038783702287505E-7 8.718617011259023E8; 3.3554532961999386E-6 1.649611568650628E-6 2.00243858744113E-7 8.694304651697404E8; 3.321005665817592E-6 1.6533857555942353E-6 1.9932741220089306E-7 8.762727759386092E8; 3.3350333471686894E-6 1.6475235207039397E-6 2.0115363947234712E-7 8.735410506045892E8]);

model.func('gpm2').set('source', 'resultTable');
model.func('gpm2').set('resultTable', 'tbl17');
model.func('gpm2').set('ignorenaninf', true);

model.study('std6').feature('uq').set('designtable', 'tbl17');

model.func('gpm2').setEntry('funcs', 'col4', 'gpm2_1');

model.study('std6').feature('uq').set('computeaction', 'append');
model.study('std6').feature('uq').set('tablegraphgrp', 'new');
model.study('std6').label('Study 6 - Reliability Analysis');
model.study('std6').feature('uq').set('surrogatetol', 0.01);
model.study('std6').feature('uq').setIndex('failif', 'smaller', 0);
model.study('std6').feature('uq').setIndex('threshold', '8.65e8[Hz]', 0);

model.sol.create('sol12');
model.sol('sol12').study('std6');
model.sol('sol1').study('std1');
model.sol('sol3').copySolution('sol13');

model.result.dataset('dset3').set('solution', 'none');

model.sol('sol1').feature.remove('cms1');
model.sol('sol1').feature.remove('su1');
model.sol('sol1').feature.remove('e1');
model.sol('sol1').feature.remove('v1');
model.sol('sol1').feature.remove('st1');
model.sol('sol13').copySolution('sol3');
model.sol.remove('sol13');
model.sol('sol3').label('Solution Store 1');

model.result.dataset.remove('dset12');

model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'eig');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').set('control', 'eig');
model.sol('sol1').create('e1', 'Eigenvalue');
model.sol('sol1').feature('e1').set('eigvfunscale', 'maximum');
model.sol('sol1').feature('e1').set('eigvfunscaleparam', '1.0E-9');
model.sol('sol1').feature('e1').set('control', 'eig');
model.sol('sol1').feature('e1').feature('aDef').set('cachepattern', true);
model.sol('sol1').create('su1', 'StoreSolution');
model.sol('sol1').feature('su1').set('sol', 'sol3');
model.sol('sol1').feature('su1').label('Solution Store 1');
model.sol('sol1').create('cms1', 'CombineSolution');
model.sol('sol1').feature('cms1').set('control', 'cmbsol');

model.result.dataset('dset3').set('solution', 'sol3');

model.sol('sol1').feature('cms1').set('solnum', 'all');
model.sol('sol1').feature('cms1').set('solvertype', 'solnum');
model.sol('sol1').attach('std1');
model.sol('sol12').create('copy1', 'CopySolution');
model.sol('sol12').feature('copy1').set('sol', 'sol1');
model.sol('sol12').attach('std6');
model.sol('sol1').study('std1');
model.sol('sol3').copySolution('sol13');

model.result.dataset('dset3').set('solution', 'none');

model.sol('sol1').feature.remove('cms1');
model.sol('sol1').feature.remove('su1');
model.sol('sol1').feature.remove('e1');
model.sol('sol1').feature.remove('v1');
model.sol('sol1').feature.remove('st1');
model.sol('sol13').copySolution('sol3');
model.sol.remove('sol13');
model.sol('sol3').label('Solution Store 1');

model.result.dataset.remove('dset12');

model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'eig');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').set('control', 'eig');
model.sol('sol1').create('e1', 'Eigenvalue');
model.sol('sol1').feature('e1').set('eigvfunscale', 'maximum');
model.sol('sol1').feature('e1').set('eigvfunscaleparam', '1.0E-9');
model.sol('sol1').feature('e1').set('control', 'eig');
model.sol('sol1').feature('e1').feature('aDef').set('cachepattern', true);
model.sol('sol1').create('su1', 'StoreSolution');
model.sol('sol1').feature('su1').set('sol', 'sol3');
model.sol('sol1').feature('su1').label('Solution Store 1');
model.sol('sol1').create('cms1', 'CombineSolution');
model.sol('sol1').feature('cms1').set('control', 'cmbsol');

model.result.dataset('dset3').set('solution', 'sol3');

model.sol('sol1').feature('cms1').set('solnum', 'all');
model.sol('sol1').feature('cms1').set('solvertype', 'solnum');
model.sol('sol1').attach('std1');

model.study('std6').feature('uq').set('computeaction', 'recompute');
model.study('std6').feature('uq').set('verifyaction', 'recompute');

model.batch.create('uq4', 'UncertaintyQuantification');
model.batch('uq4').study('std6');
model.batch('uq4').attach('std6');
model.batch('pd4').create('so1', 'Solutionseq');
model.batch('pd4').feature('so1').set('seq', 'sol1');
model.batch('pd4').feature('so1').set('store', 'on');
model.batch('pd4').feature('so1').set('clear', 'on');
model.batch('pd4').feature('so1').set('psol', 'none');
model.batch('pd4').create('so2', 'Solutionseq');
model.batch('pd4').feature('so2').set('seq', 'sol12');
model.batch('pd4').feature('so2').set('store', 'on');
model.batch('pd4').feature('so2').set('clear', 'on');
model.batch('pd4').feature('so2').set('psol', 'none');
model.batch('pd4').attach('std6');
model.batch('uq4').set('control', 'uq');
model.batch('pd4').set('control', 'uq');

model.study('std6').feature('uq').set('computeaction', 'append');
model.study('std6').feature('uq').set('verifyaction', 'recompute');

model.sol.create('sol13');
model.sol('sol13').study('std6');
model.sol('sol13').label('Parametric Solutions 4');

model.batch('pd4').feature('so2').set('psol', 'sol13');
model.batch('uq4').run('compute');

model.result('pg7').run;

model.sol('sol12').study('std6');
model.sol('sol12').feature.remove('copy1');
model.sol('sol1').study('std1');
model.sol('sol3').copySolution('sol15');

model.result.dataset('dset3').set('solution', 'none');

model.sol('sol1').feature.remove('cms1');
model.sol('sol1').feature.remove('su1');
model.sol('sol1').feature.remove('e1');
model.sol('sol1').feature.remove('v1');
model.sol('sol1').feature.remove('st1');
model.sol('sol15').copySolution('sol3');
model.sol.remove('sol15');
model.sol('sol3').label('Solution Store 1');

model.result.dataset.remove('dset13');

model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'eig');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').set('control', 'eig');
model.sol('sol1').create('e1', 'Eigenvalue');
model.sol('sol1').feature('e1').set('eigvfunscale', 'maximum');
model.sol('sol1').feature('e1').set('eigvfunscaleparam', '1.0E-9');
model.sol('sol1').feature('e1').set('control', 'eig');
model.sol('sol1').feature('e1').feature('aDef').set('cachepattern', true);
model.sol('sol1').create('su1', 'StoreSolution');
model.sol('sol1').feature('su1').set('sol', 'sol3');
model.sol('sol1').feature('su1').label('Solution Store 1');
model.sol('sol1').create('cms1', 'CombineSolution');
model.sol('sol1').feature('cms1').set('control', 'cmbsol');

model.result.dataset('dset3').set('solution', 'sol3');

model.sol('sol1').feature('cms1').set('solnum', 'all');
model.sol('sol1').feature('cms1').set('solvertype', 'solnum');
model.sol('sol1').attach('std1');
model.sol('sol12').create('copy1', 'CopySolution');
model.sol('sol12').feature('copy1').set('sol', 'sol1');
model.sol('sol12').attach('std6');
model.sol('sol1').study('std1');
model.sol('sol3').copySolution('sol15');

model.result.dataset('dset3').set('solution', 'none');

model.sol('sol1').feature.remove('cms1');
model.sol('sol1').feature.remove('su1');
model.sol('sol1').feature.remove('e1');
model.sol('sol1').feature.remove('v1');
model.sol('sol1').feature.remove('st1');
model.sol('sol15').copySolution('sol3');
model.sol.remove('sol15');
model.sol('sol3').label('Solution Store 1');

model.result.dataset.remove('dset13');

model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'eig');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').set('control', 'eig');
model.sol('sol1').create('e1', 'Eigenvalue');
model.sol('sol1').feature('e1').set('eigvfunscale', 'maximum');
model.sol('sol1').feature('e1').set('eigvfunscaleparam', '1.0E-9');
model.sol('sol1').feature('e1').set('control', 'eig');
model.sol('sol1').feature('e1').feature('aDef').set('cachepattern', true);
model.sol('sol1').create('su1', 'StoreSolution');
model.sol('sol1').feature('su1').set('sol', 'sol3');
model.sol('sol1').feature('su1').label('Solution Store 1');
model.sol('sol1').create('cms1', 'CombineSolution');
model.sol('sol1').feature('cms1').set('control', 'cmbsol');

model.result.dataset('dset3').set('solution', 'sol3');

model.sol('sol1').feature('cms1').set('solnum', 'all');
model.sol('sol1').feature('cms1').set('solvertype', 'solnum');
model.sol('sol1').attach('std1');

model.batch('pd4').feature.remove('so1');
model.batch('pd4').feature.remove('so2');
model.batch('pd4').create('so1', 'Solutionseq');
model.batch('pd4').feature('so1').set('seq', 'sol1');
model.batch('pd4').feature('so1').set('store', 'on');
model.batch('pd4').feature('so1').set('clear', 'on');
model.batch('pd4').feature('so1').set('psol', 'none');
model.batch('pd4').create('so2', 'Solutionseq');
model.batch('pd4').feature('so2').set('seq', 'sol12');
model.batch('pd4').feature('so2').set('store', 'on');
model.batch('pd4').feature('so2').set('clear', 'on');
model.batch('pd4').feature('so2').set('psol', 'sol13');
model.batch('pd4').set('control', 'uq');
model.batch('uq4').run('postprocess');

model.result('pg9').run;

model.study.create('std7');
model.study('std7').feature.copy('uq', 'std4/uq', '');
model.study('std7').feature.copy('ref', 'std4/ref', '');
model.study('std7').feature('uq').set('uqtype', 'screening');
model.study('std7').feature('uq').set('uqresultgrp', 'new');
model.study('std7').feature('uq').set('uqtype', 'sensitivityanalysis');
model.study('std7').feature('uq').set('uqresultgrp', 'new');
model.study('std7').feature('uq').set('uqtype', 'uncertaintypropagation');
model.study('std7').feature('uq').set('uqresultgrp', 'new');
model.study('std7').feature('uq').set('uqtype', 'reliabilityanalysis');
model.study('std7').feature('uq').set('uqresultgrp', 'new');
model.study('std7').feature('uq').set('uqtype', 'inverseuq');
model.study('std7').feature('uq').set('uqresultgrp', 'new');
model.study('std7').feature('uq').set('uqtype', 'uncertaintypropagation');

model.func.create('gpm3', 'GaussianProcess');
model.func('gpm3').active(false);

model.study('std7').feature('uq').set('globalgpfunction', 'gpm3');

model.result.table.create('tbl25', 'Table');
model.result.table('tbl25').addRows([3.351636369717934E-6 1.6503485728934143E-6 2.0126316686528022E-7 8.69934513461777E8; 3.3306641098609407E-6 1.6627327678798516E-6 2.0060305889037571E-7 8.73276345034453E8; 3.3606016618469106E-6 1.6427041251469649E-6 2.0101256056114026E-7 8.688120388032137E8; 3.3378373111277173E-6 1.6589523626221244E-6 1.99834622545504E-7 8.722912956777637E8; 3.340499287026675E-6 1.6488155716117903E-6 1.987826874578544E-7 8.72801299156766E8; 3.354330187575892E-6 1.6647324619615637E-6 1.994708007083896E-7 8.685686523487864E8; 3.3467142208959724E-6 1.6420156638538379E-6 2.0175234540414562E-7 8.715147739705293E8; 3.3695185501810336E-6 1.6468847534800963E-6 1.9918232425690644E-7 8.670473491836149E8; 3.3632901132427974E-6 1.6359901913666403E-6 1.9923017253806183E-7 8.691765987163684E8; 3.3425621514578717E-6 1.6381771668282064E-6 1.9906624946616931E-7 8.73207626380628E8; 3.3278781351336986E-6 1.6409641658377469E-6 2.0044948764779644E-7 8.756813668725257E8; 3.350944106165254E-6 1.6570253392757538E-6 2.0058538403222916E-7 8.696594758916099E8; 3.3338104830825876E-6 1.6461324264419245E-6 1.997163360398743E-7 8.74192497815722E8; 3.3724511599030907E-6 1.650855004417973E-6 2.0070532414133465E-7 8.658390207532756E8; 3.364774867008596E-6 1.6563414709563474E-6 1.9825196045365357E-7 8.674059126169465E8; 3.3390461857785214E-6 1.6553497535346282E-6 2.015566008334717E-7 8.720009638991246E8; 3.3777284357278925E-6 1.6450206115323086E-6 2.000604046879065E-7 8.653905088574055E8; 3.3573093657358743E-6 1.6390054302599132E-6 2.0010889062348566E-7 8.699558145131307E8; 3.3734479564735982E-6 1.6578076867670101E-6 1.9992677790829177E-7 8.652278274338536E8; 3.359696045432886E-6 1.6529303918305411E-6 1.9950285650689974E-7 8.68454096230605E8; 3.344380513082959E-6 1.6513910199225657E-6 1.9986570926977843E-7 8.715880296361048E8; 3.3539689176463533E-6 1.6482831246093116E-6 1.9863159576469445E-7 8.701578580230817E8; 3.3493543207666656E-6 1.6452209879560905E-6 1.9959729493956454E-7 8.711471680585154E8; 3.3653651178220683E-6 1.6609950640027788E-6 2.0089649637219377E-7 8.66386959485462E8; 3.3474950756247107E-6 1.6548275786896476E-6 1.989226102346875E-7 8.708645339899684E8; 3.3242419182653175E-6 1.6520193717836707E-6 2.0016753695178735E-7 8.755579705877565E8; 3.345476777232826E-6 1.6441334396668884E-6 2.0038783702287505E-7 8.718617011259023E8; 3.3554532961999386E-6 1.649611568650628E-6 2.00243858744113E-7 8.694304651697404E8; 3.321005665817592E-6 1.6533857555942353E-6 1.9932741220089306E-7 8.762727759386092E8; 3.3350333471686894E-6 1.6475235207039397E-6 2.0115363947234712E-7 8.735410506045892E8]);

model.func('gpm3').set('source', 'resultTable');
model.func('gpm3').set('resultTable', 'tbl25');
model.func('gpm3').set('ignorenaninf', true);

model.study('std7').feature('uq').set('designtable', 'tbl25');

model.func('gpm3').set('covfunction', 'matern32');
model.func('gpm3').set('meanfunction', 'const');
model.func('gpm3').set('improvementfunction', 'entropy');
model.func('gpm3').set('lastinternalseed', 1014);
model.func('gpm3').set('gpadpoptmethod', 'direct');
model.func('gpm3').set('maxgpevals', 10000);
model.func('gpm3').set('maxgpiters', 500);
model.func('gpm3').set('adpevals', 10000);
model.func('gpm3').set('setupfromstudy', 'on');
model.func('gpm3').setEntry('distributionselection', 'col1', 'normal');
model.func('gpm3').setEntry('s1selection', 'col1', '3.35E-6');
model.func('gpm3').setEntry('s2selection', 'col1', '1.675E-8');
model.func('gpm3').setEntry('lboundselection', 'col1', '3.3165E-6');
model.func('gpm3').setEntry('uboundselection', 'col1', '3.3835000000000003E-6');
model.func('gpm3').setEntry('lcdfselection', 'col1', 'manual');
model.func('gpm3').setEntry('ucdfselection', 'col1', 'manual');
model.func('gpm3').setEntry('distributionselection', 'col2', 'normal');
model.func('gpm3').setEntry('s1selection', 'col2', '1.6499999999999999E-6');
model.func('gpm3').setEntry('s2selection', 'col2', '8.25E-9');
model.func('gpm3').setEntry('lboundselection', 'col2', '1.6335E-6');
model.func('gpm3').setEntry('uboundselection', 'col2', '1.6664999999999998E-6');
model.func('gpm3').setEntry('lcdfselection', 'col2', 'manual');
model.func('gpm3').setEntry('ucdfselection', 'col2', 'manual');
model.func('gpm3').setEntry('distributionselection', 'col3', 'normal');
model.func('gpm3').setEntry('s1selection', 'col3', '2.0000000000000002E-7');
model.func('gpm3').setEntry('s2selection', 'col3', '1.0E-9');
model.func('gpm3').setEntry('lboundselection', 'col3', '1.9800000000000003E-7');
model.func('gpm3').setEntry('uboundselection', 'col3', '2.02E-7');
model.func('gpm3').setEntry('lcdfselection', 'col3', 'manual');
model.func('gpm3').setEntry('ucdfselection', 'col3', 'manual');
model.func('gpm3').setEntry('args', 'col1', 't_pe');
model.func('gpm3').setEntry('unit', 'col1', 'm');
model.func('gpm3').setEntry('args', 'col2', 't_lil');
model.func('gpm3').setEntry('unit', 'col2', 'm');
model.func('gpm3').setEntry('args', 'col3', 't_e');
model.func('gpm3').setEntry('unit', 'col3', 'm');
model.func('gpm3').setEntry('funcs', 'col4', 'gpm3_1');

model.study('std7').feature('uq').set('computeaction', 'append');
model.study('std7').feature('uq').set('tablegraphgrp', 'new');
model.study('std7').label('Study 7 - Uncertainty Propagation, Correlated');
model.study('std7').feature('uq').set('surrogatetol', 0.005);
model.study('std7').feature('uq').setIndex('inputCorrelations', '', 0, 0);
model.study('std7').feature('uq').setIndex('inputCorrelations', '', 0, 1);
model.study('std7').feature('uq').setIndex('inputCorrelations', '0x0', 0, 2);
model.study('std7').feature('uq').setIndex('inputCorrelations', 'on', 0, 3);
model.study('std7').feature('uq').setIndex('inputCorrelations', '', 0, 0);
model.study('std7').feature('uq').setIndex('inputCorrelations', '', 0, 1);
model.study('std7').feature('uq').setIndex('inputCorrelations', '0x0', 0, 2);
model.study('std7').feature('uq').setIndex('inputCorrelations', 'on', 0, 3);
model.study('std7').feature('uq').setIndex('inputCorrelations', '{1,0.7,1,0.4,0.15,1}', 0, 1);

model.sol.create('sol15');
model.sol('sol15').study('std7');
model.sol('sol1').study('std1');
model.sol('sol3').copySolution('sol16');

model.result.dataset('dset3').set('solution', 'none');

model.sol('sol1').feature.remove('cms1');
model.sol('sol1').feature.remove('su1');
model.sol('sol1').feature.remove('e1');
model.sol('sol1').feature.remove('v1');
model.sol('sol1').feature.remove('st1');
model.sol('sol16').copySolution('sol3');
model.sol.remove('sol16');
model.sol('sol3').label('Solution Store 1');

model.result.dataset.remove('dset14');

model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'eig');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').set('control', 'eig');
model.sol('sol1').create('e1', 'Eigenvalue');
model.sol('sol1').feature('e1').set('eigvfunscale', 'maximum');
model.sol('sol1').feature('e1').set('eigvfunscaleparam', '1.0E-9');
model.sol('sol1').feature('e1').set('control', 'eig');
model.sol('sol1').feature('e1').feature('aDef').set('cachepattern', true);
model.sol('sol1').create('su1', 'StoreSolution');
model.sol('sol1').feature('su1').set('sol', 'sol3');
model.sol('sol1').feature('su1').label('Solution Store 1');
model.sol('sol1').create('cms1', 'CombineSolution');
model.sol('sol1').feature('cms1').set('control', 'cmbsol');

model.result.dataset('dset3').set('solution', 'sol3');

model.sol('sol1').feature('cms1').set('solnum', 'all');
model.sol('sol1').feature('cms1').set('solvertype', 'solnum');
model.sol('sol1').attach('std1');
model.sol('sol15').create('copy1', 'CopySolution');
model.sol('sol15').feature('copy1').set('sol', 'sol1');
model.sol('sol15').attach('std7');
model.sol('sol1').study('std1');
model.sol('sol3').copySolution('sol16');

model.result.dataset('dset3').set('solution', 'none');

model.sol('sol1').feature.remove('cms1');
model.sol('sol1').feature.remove('su1');
model.sol('sol1').feature.remove('e1');
model.sol('sol1').feature.remove('v1');
model.sol('sol1').feature.remove('st1');
model.sol('sol16').copySolution('sol3');
model.sol.remove('sol16');
model.sol('sol3').label('Solution Store 1');

model.result.dataset.remove('dset14');

model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'eig');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').set('control', 'eig');
model.sol('sol1').create('e1', 'Eigenvalue');
model.sol('sol1').feature('e1').set('eigvfunscale', 'maximum');
model.sol('sol1').feature('e1').set('eigvfunscaleparam', '1.0E-9');
model.sol('sol1').feature('e1').set('control', 'eig');
model.sol('sol1').feature('e1').feature('aDef').set('cachepattern', true);
model.sol('sol1').create('su1', 'StoreSolution');
model.sol('sol1').feature('su1').set('sol', 'sol3');
model.sol('sol1').feature('su1').label('Solution Store 1');
model.sol('sol1').create('cms1', 'CombineSolution');
model.sol('sol1').feature('cms1').set('control', 'cmbsol');

model.result.dataset('dset3').set('solution', 'sol3');

model.sol('sol1').feature('cms1').set('solnum', 'all');
model.sol('sol1').feature('cms1').set('solvertype', 'solnum');
model.sol('sol1').attach('std1');

model.study('std7').feature('uq').set('computeaction', 'recompute');
model.study('std7').feature('uq').set('verifyaction', 'recompute');

model.batch.create('uq5', 'UncertaintyQuantification');
model.batch('uq5').study('std7');
model.batch('uq5').attach('std7');
model.batch('pd5').create('so1', 'Solutionseq');
model.batch('pd5').feature('so1').set('seq', 'sol1');
model.batch('pd5').feature('so1').set('store', 'on');
model.batch('pd5').feature('so1').set('clear', 'on');
model.batch('pd5').feature('so1').set('psol', 'none');
model.batch('pd5').create('so2', 'Solutionseq');
model.batch('pd5').feature('so2').set('seq', 'sol15');
model.batch('pd5').feature('so2').set('store', 'on');
model.batch('pd5').feature('so2').set('clear', 'on');
model.batch('pd5').feature('so2').set('psol', 'none');
model.batch('pd5').attach('std7');
model.batch('uq5').set('control', 'uq');
model.batch('pd5').set('control', 'uq');

model.study('std7').feature('uq').set('computeaction', 'append');
model.study('std7').feature('uq').set('verifyaction', 'recompute');

model.sol.create('sol16');
model.sol('sol16').study('std7');
model.sol('sol16').label('Parametric Solutions 5');

model.batch('pd5').feature('so2').set('psol', 'sol16');
model.batch('uq5').run('compute');

model.result('pg10').run;

model.study.create('std8');
model.study('std8').feature.copy('uq', 'std7/uq', '');
model.study('std8').feature.copy('ref', 'std7/ref', '');
model.study('std8').feature('uq').set('uqtype', 'screening');
model.study('std8').feature('uq').set('uqresultgrp', 'new');
model.study('std8').feature('uq').set('uqtype', 'sensitivityanalysis');
model.study('std8').feature('uq').set('uqresultgrp', 'new');
model.study('std8').feature('uq').set('uqtype', 'uncertaintypropagation');
model.study('std8').feature('uq').set('uqresultgrp', 'new');
model.study('std8').feature('uq').set('uqtype', 'reliabilityanalysis');
model.study('std8').feature('uq').set('uqresultgrp', 'new');
model.study('std8').feature('uq').set('uqtype', 'inverseuq');
model.study('std8').feature('uq').set('uqresultgrp', 'new');
model.study('std8').feature('uq').set('uqtype', 'reliabilityanalysis');

model.func.duplicate('gpm4', 'gpm3');

model.study('std8').feature('uq').set('globalgpfunction', 'gpm4');

model.result.table.create('tbl34', 'Table');
model.result.table('tbl34').addRows([3.351636369717934E-6 1.6503485728934143E-6 2.0126316686528022E-7 8.69934513461777E8; 3.3306641098609407E-6 1.6627327678798516E-6 2.0060305889037571E-7 8.73276345034453E8; 3.3606016618469106E-6 1.6427041251469649E-6 2.0101256056114026E-7 8.688120388032137E8; 3.3378373111277173E-6 1.6589523626221244E-6 1.99834622545504E-7 8.722912956777637E8; 3.340499287026675E-6 1.6488155716117903E-6 1.987826874578544E-7 8.72801299156766E8; 3.354330187575892E-6 1.6647324619615637E-6 1.994708007083896E-7 8.685686523487864E8; 3.3467142208959724E-6 1.6420156638538379E-6 2.0175234540414562E-7 8.715147739705293E8; 3.3695185501810336E-6 1.6468847534800963E-6 1.9918232425690644E-7 8.670473491836149E8; 3.3632901132427974E-6 1.6359901913666403E-6 1.9923017253806183E-7 8.691765987163684E8; 3.3425621514578717E-6 1.6381771668282064E-6 1.9906624946616931E-7 8.73207626380628E8; 3.3278781351336986E-6 1.6409641658377469E-6 2.0044948764779644E-7 8.756813668725257E8; 3.350944106165254E-6 1.6570253392757538E-6 2.0058538403222916E-7 8.696594758916099E8; 3.3338104830825876E-6 1.6461324264419245E-6 1.997163360398743E-7 8.74192497815722E8; 3.3724511599030907E-6 1.650855004417973E-6 2.0070532414133465E-7 8.658390207532756E8; 3.364774867008596E-6 1.6563414709563474E-6 1.9825196045365357E-7 8.674059126169465E8; 3.3390461857785214E-6 1.6553497535346282E-6 2.015566008334717E-7 8.720009638991246E8; 3.3777284357278925E-6 1.6450206115323086E-6 2.000604046879065E-7 8.653905088574055E8; 3.3573093657358743E-6 1.6390054302599132E-6 2.0010889062348566E-7 8.699558145131307E8; 3.3734479564735982E-6 1.6578076867670101E-6 1.9992677790829177E-7 8.652278274338536E8; 3.359696045432886E-6 1.6529303918305411E-6 1.9950285650689974E-7 8.68454096230605E8; 3.344380513082959E-6 1.6513910199225657E-6 1.9986570926977843E-7 8.715880296361048E8; 3.3539689176463533E-6 1.6482831246093116E-6 1.9863159576469445E-7 8.701578580230817E8; 3.3493543207666656E-6 1.6452209879560905E-6 1.9959729493956454E-7 8.711471680585154E8; 3.3653651178220683E-6 1.6609950640027788E-6 2.0089649637219377E-7 8.66386959485462E8; 3.3474950756247107E-6 1.6548275786896476E-6 1.989226102346875E-7 8.708645339899684E8; 3.3242419182653175E-6 1.6520193717836707E-6 2.0016753695178735E-7 8.755579705877565E8; 3.345476777232826E-6 1.6441334396668884E-6 2.0038783702287505E-7 8.718617011259023E8; 3.3554532961999386E-6 1.649611568650628E-6 2.00243858744113E-7 8.694304651697404E8; 3.321005665817592E-6 1.6533857555942353E-6 1.9932741220089306E-7 8.762727759386092E8; 3.3350333471686894E-6 1.6475235207039397E-6 2.0115363947234712E-7 8.735410506045892E8; 3.3637620999457256E-6 1.6493233122462366E-6 1.9864071761287537E-7 8.681056998463454E8; 3.329604756861686E-6 1.6517486324507041E-6 1.9800293776982779E-7 8.749243197574663E8; 3.3702946315651597E-6 1.6549257317283633E-6 2.0143209350212644E-7 8.657940018522457E8; 3.348719257880377E-6 1.6523430559910667E-6 2.0020931472696499E-7 8.705666557400246E8; 3.356637447155081E-6 1.6601065223105915E-6 1.9926726403083122E-7 8.685256165122756E8; 3.3834872346728783E-6 1.6445693165752486E-6 1.9910049065435988E-7 8.644713006095847E8; 3.3577928858375028E-6 1.6617384643454898E-6 2.0091897957568137E-7 8.678340652710048E8; 3.3462761689991452E-6 1.6400377726732995E-6 2.0132126873970503E-7 8.718523728069172E8; 3.3532746081102536E-6 1.6541620321500494E-6 1.999614746642319E-7 8.695503084988711E8; 3.3169708782008283E-6 1.6415862291378788E-6 2.003651384494397E-7 8.778737407073616E8; 3.3367173644975828E-6 1.6499388175160071E-6 2.0048066046492484E-7 8.731344341326575E8; 3.3420210903106654E-6 1.635399854032596E-6 1.9988451021164525E-7 8.733836515714197E8; 3.3438115188546327E-6 1.647702360397217E-6 1.994333080237937E-7 8.720936802016187E8; 3.3613289609601414E-6 1.6584396458136637E-6 2.0065295492756663E-7 8.674492778337082E8; 3.335894559258435E-6 1.6464072242811313E-6 1.9972468683663567E-7 8.73745152824111E8; 3.383499164235241E-6 1.6664998730566986E-6 2.0199999963303606E-7 8.621266747832644E8; 3.316502507044117E-6 1.6335000055705566E-6 1.9800000555342093E-7 8.791263880123084E8; 3.319550712409418E-6 1.633500107971189E-6 2.019994529315177E-7 8.776921674227089E8; 3.3823592512516333E-6 1.6664999740151123E-6 1.980010557395384E-7 8.631323319663146E8; 3.382322774627985E-6 1.6394163681553863E-6 2.0199999991760824E-7 8.645529694668909E8; 3.3721071683135462E-6 1.6664967796701455E-6 2.0199904979577395E-7 8.643817807545304E8; 3.333626101785378E-6 1.6335104004153438E-6 1.9800181363394946E-7 8.756237093497488E8; 3.3833632135478642E-6 1.6664999862991428E-6 2.0039448269882433E-7 8.624665928164455E8; 3.3212858145939665E-6 1.642005609980578E-6 1.98000048142812E-7 8.774337417701944E8; 3.3218364897160476E-6 1.6335048596957034E-6 1.9918755817744814E-7 8.777923167008312E8; 3.350742724298045E-6 1.6664234420765726E-6 1.9800002637584775E-7 8.69441028560447E8; 3.375737497977903E-6 1.6664878728914775E-6 1.9849555957963872E-7 8.643486872732913E8; 3.3646034759333748E-6 1.6463948900376065E-6 2.019999446943919E-7 8.675135507687252E8; 3.331650735965697E-6 1.6335346170110332E-6 2.016868087549496E-7 8.75283032216815E8; 3.321080114761517E-6 1.6367439610696556E-6 2.0156575617166428E-7 8.771956768340117E8]);

model.func('gpm4').set('source', 'resultTable');
model.func('gpm4').set('resultTable', 'tbl34');
model.func('gpm4').set('ignorenaninf', true);

model.study('std8').feature('uq').set('designtable', 'tbl34');

model.func('gpm4').setEntry('funcs', 'col4', 'gpm4_1');

model.study('std8').feature('uq').set('computeaction', 'append');
model.study('std8').feature('uq').set('tablegraphgrp', 'new');
model.study('std8').label('Study 8 - Reliability Analysis, Correlated');
model.study('std8').feature('uq').setIndex('failif', 'smaller', 0);
model.study('std8').feature('uq').setIndex('threshold', '8.65e8[Hz]', 0);

model.sol.create('sol18');
model.sol('sol18').study('std8');
model.sol('sol1').study('std1');
model.sol('sol3').copySolution('sol19');

model.result.dataset('dset3').set('solution', 'none');

model.sol('sol1').feature.remove('cms1');
model.sol('sol1').feature.remove('su1');
model.sol('sol1').feature.remove('e1');
model.sol('sol1').feature.remove('v1');
model.sol('sol1').feature.remove('st1');
model.sol('sol19').copySolution('sol3');
model.sol.remove('sol19');
model.sol('sol3').label('Solution Store 1');

model.result.dataset.remove('dset16');

model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'eig');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').set('control', 'eig');
model.sol('sol1').create('e1', 'Eigenvalue');
model.sol('sol1').feature('e1').set('eigvfunscale', 'maximum');
model.sol('sol1').feature('e1').set('eigvfunscaleparam', '1.0E-9');
model.sol('sol1').feature('e1').set('control', 'eig');
model.sol('sol1').feature('e1').feature('aDef').set('cachepattern', true);
model.sol('sol1').create('su1', 'StoreSolution');
model.sol('sol1').feature('su1').set('sol', 'sol3');
model.sol('sol1').feature('su1').label('Solution Store 1');
model.sol('sol1').create('cms1', 'CombineSolution');
model.sol('sol1').feature('cms1').set('control', 'cmbsol');

model.result.dataset('dset3').set('solution', 'sol3');

model.sol('sol1').feature('cms1').set('solnum', 'all');
model.sol('sol1').feature('cms1').set('solvertype', 'solnum');
model.sol('sol1').attach('std1');
model.sol('sol18').create('copy1', 'CopySolution');
model.sol('sol18').feature('copy1').set('sol', 'sol1');
model.sol('sol18').attach('std8');
model.sol('sol1').study('std1');
model.sol('sol3').copySolution('sol19');

model.result.dataset('dset3').set('solution', 'none');

model.sol('sol1').feature.remove('cms1');
model.sol('sol1').feature.remove('su1');
model.sol('sol1').feature.remove('e1');
model.sol('sol1').feature.remove('v1');
model.sol('sol1').feature.remove('st1');
model.sol('sol19').copySolution('sol3');
model.sol.remove('sol19');
model.sol('sol3').label('Solution Store 1');

model.result.dataset.remove('dset16');

model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'eig');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').set('control', 'eig');
model.sol('sol1').create('e1', 'Eigenvalue');
model.sol('sol1').feature('e1').set('eigvfunscale', 'maximum');
model.sol('sol1').feature('e1').set('eigvfunscaleparam', '1.0E-9');
model.sol('sol1').feature('e1').set('control', 'eig');
model.sol('sol1').feature('e1').feature('aDef').set('cachepattern', true);
model.sol('sol1').create('su1', 'StoreSolution');
model.sol('sol1').feature('su1').set('sol', 'sol3');
model.sol('sol1').feature('su1').label('Solution Store 1');
model.sol('sol1').create('cms1', 'CombineSolution');
model.sol('sol1').feature('cms1').set('control', 'cmbsol');

model.result.dataset('dset3').set('solution', 'sol3');

model.sol('sol1').feature('cms1').set('solnum', 'all');
model.sol('sol1').feature('cms1').set('solvertype', 'solnum');
model.sol('sol1').attach('std1');

model.study('std8').feature('uq').set('computeaction', 'recompute');
model.study('std8').feature('uq').set('verifyaction', 'recompute');

model.batch.create('uq6', 'UncertaintyQuantification');
model.batch('uq6').study('std8');
model.batch('uq6').attach('std8');
model.batch('pd6').create('so1', 'Solutionseq');
model.batch('pd6').feature('so1').set('seq', 'sol1');
model.batch('pd6').feature('so1').set('store', 'on');
model.batch('pd6').feature('so1').set('clear', 'on');
model.batch('pd6').feature('so1').set('psol', 'none');
model.batch('pd6').create('so2', 'Solutionseq');
model.batch('pd6').feature('so2').set('seq', 'sol18');
model.batch('pd6').feature('so2').set('store', 'on');
model.batch('pd6').feature('so2').set('clear', 'on');
model.batch('pd6').feature('so2').set('psol', 'none');
model.batch('pd6').attach('std8');
model.batch('uq6').set('control', 'uq');
model.batch('pd6').set('control', 'uq');

model.study('std8').feature('uq').set('computeaction', 'append');
model.study('std8').feature('uq').set('verifyaction', 'recompute');

model.sol.create('sol19');
model.sol('sol19').study('std8');
model.sol('sol19').label('Parametric Solutions 6');

model.batch('pd6').feature('so2').set('psol', 'sol19');
model.batch('uq6').run('compute');

model.result('pg7').run;

model.sol('sol18').study('std8');
model.sol('sol18').feature.remove('copy1');
model.sol('sol1').study('std1');
model.sol('sol3').copySolution('sol21');

model.result.dataset('dset3').set('solution', 'none');

model.sol('sol1').feature.remove('cms1');
model.sol('sol1').feature.remove('su1');
model.sol('sol1').feature.remove('e1');
model.sol('sol1').feature.remove('v1');
model.sol('sol1').feature.remove('st1');
model.sol('sol21').copySolution('sol3');
model.sol.remove('sol21');
model.sol('sol3').label('Solution Store 1');

model.result.dataset.remove('dset17');

model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'eig');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').set('control', 'eig');
model.sol('sol1').create('e1', 'Eigenvalue');
model.sol('sol1').feature('e1').set('eigvfunscale', 'maximum');
model.sol('sol1').feature('e1').set('eigvfunscaleparam', '1.0E-9');
model.sol('sol1').feature('e1').set('control', 'eig');
model.sol('sol1').feature('e1').feature('aDef').set('cachepattern', true);
model.sol('sol1').create('su1', 'StoreSolution');
model.sol('sol1').feature('su1').set('sol', 'sol3');
model.sol('sol1').feature('su1').label('Solution Store 1');
model.sol('sol1').create('cms1', 'CombineSolution');
model.sol('sol1').feature('cms1').set('control', 'cmbsol');

model.result.dataset('dset3').set('solution', 'sol3');

model.sol('sol1').feature('cms1').set('solnum', 'all');
model.sol('sol1').feature('cms1').set('solvertype', 'solnum');
model.sol('sol1').attach('std1');
model.sol('sol18').create('copy1', 'CopySolution');
model.sol('sol18').feature('copy1').set('sol', 'sol1');
model.sol('sol18').attach('std8');
model.sol('sol1').study('std1');
model.sol('sol3').copySolution('sol21');

model.result.dataset('dset3').set('solution', 'none');

model.sol('sol1').feature.remove('cms1');
model.sol('sol1').feature.remove('su1');
model.sol('sol1').feature.remove('e1');
model.sol('sol1').feature.remove('v1');
model.sol('sol1').feature.remove('st1');
model.sol('sol21').copySolution('sol3');
model.sol.remove('sol21');
model.sol('sol3').label('Solution Store 1');

model.result.dataset.remove('dset17');

model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'eig');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').set('control', 'eig');
model.sol('sol1').create('e1', 'Eigenvalue');
model.sol('sol1').feature('e1').set('eigvfunscale', 'maximum');
model.sol('sol1').feature('e1').set('eigvfunscaleparam', '1.0E-9');
model.sol('sol1').feature('e1').set('control', 'eig');
model.sol('sol1').feature('e1').feature('aDef').set('cachepattern', true);
model.sol('sol1').create('su1', 'StoreSolution');
model.sol('sol1').feature('su1').set('sol', 'sol3');
model.sol('sol1').feature('su1').label('Solution Store 1');
model.sol('sol1').create('cms1', 'CombineSolution');
model.sol('sol1').feature('cms1').set('control', 'cmbsol');

model.result.dataset('dset3').set('solution', 'sol3');

model.sol('sol1').feature('cms1').set('solnum', 'all');
model.sol('sol1').feature('cms1').set('solvertype', 'solnum');
model.sol('sol1').attach('std1');

model.batch('pd6').feature.remove('so1');
model.batch('pd6').feature.remove('so2');
model.batch('pd6').create('so1', 'Solutionseq');
model.batch('pd6').feature('so1').set('seq', 'sol1');
model.batch('pd6').feature('so1').set('store', 'on');
model.batch('pd6').feature('so1').set('clear', 'on');
model.batch('pd6').feature('so1').set('psol', 'none');
model.batch('pd6').create('so2', 'Solutionseq');
model.batch('pd6').feature('so2').set('seq', 'sol18');
model.batch('pd6').feature('so2').set('store', 'on');
model.batch('pd6').feature('so2').set('clear', 'on');
model.batch('pd6').feature('so2').set('psol', 'sol19');
model.batch('pd6').set('control', 'uq');
model.batch('uq6').run('postprocess');

model.result('pg11').run;

model.title('Solidly Mounted Resonator 2D with Uncertainty Quantification');

model.description('A solidly mounted resonator (SMR) is a MEMS piezoelectric resonator made from multiple layers of materials. This tutorial shows how Uncertainty Quantification is used to study the effect of manufacturing variation on the resonance frequency of the SMR. The tutorial shows how Sensitivity Analysis, Uncertainty Propagation, and Reliability Analysis are used in conjunction with an Eigenfrequency study.');

model.mesh.clearMeshes;

model.sol('sol1').clearSolutionData;
model.sol('sol2').clearSolutionData;
model.sol('sol4').clearSolutionData;
model.sol('sol5').clearSolutionData;
model.sol('sol6').clearSolutionData;
model.sol('sol7').clearSolutionData;
model.sol('sol8').clearSolutionData;
model.sol('sol9').clearSolutionData;
model.sol('sol10').clearSolutionData;
model.sol('sol11').clearSolutionData;
model.sol('sol12').clearSolutionData;
model.sol('sol13').clearSolutionData;
model.sol('sol14').clearSolutionData;
model.sol('sol15').clearSolutionData;
model.sol('sol16').clearSolutionData;
model.sol('sol17').clearSolutionData;
model.sol('sol18').clearSolutionData;
model.sol('sol19').clearSolutionData;
model.sol('sol20').clearSolutionData;
model.sol('sol3').clearSolutionData;

model.label('solidly_mounted_resonator_2d_uncertainty_quantification.mph');

model.modelNode.label('Components');

out = model;
