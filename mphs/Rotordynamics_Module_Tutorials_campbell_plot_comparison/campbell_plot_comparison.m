function out = model
%
% campbell_plot_comparison.m
%
% Model exported on May 26 2025, 21:33 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/Rotordynamics_Module/Tutorials');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 3);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.physics.create('rotsld', 'SolidRotor', 'geom1');
model.physics('rotsld').model('comp1');
model.physics.create('srotf', 'SolidRotorFixedFrame', 'geom1');
model.physics('srotf').model('comp1');
model.physics.create('rotbm', 'BeamRotor', 'geom1');
model.physics('rotbm').model('comp1');

model.study.create('std1');
model.study('std1').create('stat', 'Stationary');
model.study('std1').feature('stat').set('solnum', 'auto');
model.study('std1').feature('stat').set('notsolnum', 'auto');
model.study('std1').feature('stat').set('outputmap', {});
model.study('std1').feature('stat').set('ngenAUX', '1');
model.study('std1').feature('stat').set('goalngenAUX', '1');
model.study('std1').feature('stat').set('ngenAUX', '1');
model.study('std1').feature('stat').set('goalngenAUX', '1');
model.study('std1').feature('stat').setSolveFor('/physics/rotsld', true);
model.study('std1').feature('stat').setSolveFor('/physics/srotf', true);
model.study('std1').feature('stat').setSolveFor('/physics/rotbm', true);
model.study('std1').create('eig', 'Eigenfrequency');
model.study('std1').feature('eig').set('chkeigregion', true);
model.study('std1').feature('eig').set('conrad', '1');
model.study('std1').feature('eig').set('conradynhm', '1');
model.study('std1').feature('eig').set('storefact', false);
model.study('std1').feature('eig').set('geometricNonlinearity', true);
model.study('std1').feature('eig').set('solnum', 'auto');
model.study('std1').feature('eig').set('notsolnum', 'auto');
model.study('std1').feature('eig').set('outputmap', {});
model.study('std1').feature('eig').set('ngenAUX', '1');
model.study('std1').feature('eig').set('goalngenAUX', '1');
model.study('std1').feature('eig').set('ngenAUX', '1');
model.study('std1').feature('eig').set('goalngenAUX', '1');
model.study('std1').feature('eig').setSolveFor('/physics/rotsld', true);
model.study('std1').feature('eig').setSolveFor('/physics/srotf', true);
model.study('std1').feature('eig').setSolveFor('/physics/rotbm', true);

% To import content from file, use:
% model.param.loadFile('FILENAME');
model.param.set('fr', '1000[rpm]', 'Angular speed of shaft');
model.param.set('kb', '1e8[N/m]', 'Bearing stiffness');
model.param.label('Parameters: General');
model.param.create('par2');

% To import content from file, use:
% model.param('par2').loadFile('FILENAME');
model.param('par2').set('x1', '0[m]', 'Position of station 1');
model.param('par2').set('x2', '0.01[m]', 'Position of station 2');
model.param('par2').set('x3', '0.015[m]', 'Position of station 3');
model.param('par2').set('x4', '0.025[m]', 'Position of station 4');
model.param('par2').set('x5', '0.0375[m]', 'Position of station 5');
model.param('par2').set('x6', '0.05[m]', 'Position of station 6');
model.param('par2').set('x7', '0.06[m]', 'Position of station 7');
model.param('par2').set('x8', '0.09[m]', 'Position of station 8');
model.param('par2').set('x9', '0.095[m]', 'Position of station 9');
model.param('par2').set('x10', '0.11[m]', 'Position of station 10');
model.param('par2').set('x11', '0.125[m]', 'Position of station 11');
model.param('par2').set('x12', '0.135[m]', 'Position of station 12');
model.param('par2').set('x13', '0.145[m]', 'Position of station 13');
model.param('par2').set('x14', '0.155[m]', 'Position of station 14');
model.param('par2').set('x15', '0.17[m]', 'Position of station 15');
model.param('par2').set('x16', '0.185[m]', 'Position of station 16');
model.param('par2').set('x17', '0.2[m]', 'Position of station 17');
model.param('par2').set('x18', '0.21[m]', 'Position of station 18');
model.param('par2').set('x19', '0.225[m]', 'Position of station 19');
model.param('par2').set('x20', '0.265[m]', 'Position of station 20');
model.param('par2').set('x21', '0.325[m]', 'Position of station 21');
model.param('par2').set('x22', '0.365[m]', 'Position of station 22');
model.param('par2').set('x23', '0.375[m]', 'Position of station 23');
model.param('par2').set('x24', '0.395[m]', 'Position of station 24');
model.param('par2').set('x25', '0.405[m]', 'Position of station 25');
model.param('par2').set('x26', '0.42[m]', 'Position of station 26');
model.param('par2').set('x27', '0.435[m]', 'Position of station 27');
model.param('par2').set('x28', '0.465[m]', 'Position of station 28');
model.param('par2').set('xTol', '1e-5[m]', 'Axial step tolerance');
model.param('par2').label('Parameters: Stations');
model.param.create('par3');

% To import content from file, use:
% model.param('par3').loadFile('FILENAME');
model.param('par3').set('d_1_2', '0.03[m]', 'Diameter between station 1 and 2');
model.param('par3').set('d_2_3', '0.04[m]', 'Diameter between station 2 and 3');
model.param('par3').set('d_3_4', '0.03[m]', 'Diameter between station 3 and 4');
model.param('par3').set('d_4_5', '0.05[m]', 'Diameter between station 4 and 5');
model.param('par3').set('d_5_6', '0.05[m]', 'Diameter between station 5 and 6');
model.param('par3').set('d_6_7', '0.08[m]', 'Diameter between station 6 and 7');
model.param('par3').set('d_7_8', '0.4[m]', 'Diameter between station 7 and 8');
model.param('par3').set('d_8_9', '0.2[m]', 'Diameter between station 8 and 9');
model.param('par3').set('d_9_10', '0.05[m]', 'Diameter between station 9 and 10');
model.param('par3').set('d_10_11', '0.05[m]', 'Diameter between station 10 and 11');
model.param('par3').set('d_11_12', '0.06[m]', 'Diameter between station 11 and 12');
model.param('par3').set('d_12_13', '0.07[m]', 'Diameter between station 12 and 13');
model.param('par3').set('d_13_14', '0.08[m]', 'Diameter between station 13 and 14');
model.param('par3').set('d_14_15', '0.05[m]', 'Diameter between station 14 and 15');
model.param('par3').set('d_15_16', '0.05[m]', 'Diameter between station 15 and 16');
model.param('par3').set('d_16_17', '0.06[m]', 'Diameter between station 16 and 17');
model.param('par3').set('d_17_18', '0.08[m]', 'Diameter between station 17 and 18');
model.param('par3').set('d_19_20', '0.1[m]', 'Diameter between station 19 and 20');
model.param('par3').set('d_20_21', '0.13[m]', 'Diameter between station 20 and 21');
model.param('par3').set('d_21_22', '0.1[m]', 'Diameter between station 21 and 22');
model.param('par3').set('d_23_24', '0.08[m]', 'Diameter between station 23 and 24');
model.param('par3').set('d_24_25', '0.06[m]', 'Diameter between station 24 and 25');
model.param('par3').set('d_25_26', '0.05[m]', 'Diameter between station 25 and 26');
model.param('par3').set('d_26_27', '0.05[m]', 'Diameter between station 26 and 27');
model.param('par3').set('d_27_28', '0.08[m]', 'Diameter between station 27 and 28');
model.param('par3').label('Parameters: Shaft diameters');

model.geom('geom1').create('wp1', 'WorkPlane');
model.geom('geom1').feature('wp1').set('unite', true);
model.geom('geom1').feature('wp1').geom.create('pol1', 'Polygon');
model.geom('geom1').feature('wp1').geom.feature('pol1').set('source', 'table');
model.geom('geom1').feature('wp1').geom.feature('pol1').set('table', {'x1' '0';  ...
'x1' 'd_1_2/2';  ...
'x2' 'd_1_2/2';  ...
'x2' 'd_2_3/2';  ...
'x3' 'd_2_3/2';  ...
'x3' 'd_3_4/2';  ...
'x4' 'd_3_4/2';  ...
'x4' 'd_4_5/2';  ...
'x5' 'd_4_5/2';  ...
'x6' 'd_5_6/2';  ...
'x6' 'd_6_7/2';  ...
'x7' 'd_6_7/2';  ...
'x7' 'd_7_8/2';  ...
'x8' 'd_7_8/2';  ...
'x8' 'd_8_9/2';  ...
'x9' 'd_8_9/2';  ...
'x9' 'd_9_10/2';  ...
'x10' 'd_9_10/2';  ...
'x11' 'd_10_11/2';  ...
'x11' 'd_11_12/2';  ...
'x12' 'd_11_12/2';  ...
'x12' 'd_12_13/2';  ...
'x13' 'd_12_13/2';  ...
'x13' 'd_13_14/2';  ...
'x14' 'd_13_14/2';  ...
'x14' 'd_14_15/2';  ...
'x15' 'd_14_15/2';  ...
'x16' 'd_15_16/2';  ...
'x16' 'd_16_17/2';  ...
'x17' 'd_16_17/2';  ...
'x17' 'd_17_18/2';  ...
'x18' 'd_17_18/2';  ...
'x19' 'd_19_20/2';  ...
'x20' 'd_19_20/2';  ...
'x20' 'd_20_21/2';  ...
'x21' 'd_20_21/2';  ...
'x21' 'd_21_22/2';  ...
'x22' 'd_21_22/2';  ...
'x23' 'd_23_24/2';  ...
'x24' 'd_23_24/2';  ...
'x24' 'd_24_25/2';  ...
'x25' 'd_24_25/2';  ...
'x25' 'd_25_26/2';  ...
'x26' 'd_25_26/2';  ...
'x27' 'd_26_27/2';  ...
'x27' 'd_27_28/2';  ...
'x28' 'd_27_28/2';  ...
'x28' '0';  ...
'x27' '0';  ...
'x26' '0';  ...
'x25' '0';  ...
'x24' '0';  ...
'x23' '0';  ...
'x22' '0';  ...
'x21' '0';  ...
'x20' '0';  ...
'x19' '0';  ...
'x18' '0';  ...
'x17' '0';  ...
'x16' '0';  ...
'x15' '0';  ...
'x14' '0';  ...
'x13' '0';  ...
'x12' '0';  ...
'x11' '0';  ...
'x10' '0';  ...
'x9' '0';  ...
'x8' '0';  ...
'x7' '0';  ...
'x6' '0';  ...
'x5' '0';  ...
'x4' '0';  ...
'x3' '0';  ...
'x2' '0'});
model.geom('geom1').run('wp1');
model.geom('geom1').feature.create('rev1', 'Revolve');
model.geom('geom1').feature('rev1').set('workplane', 'wp1');
model.geom('geom1').feature('rev1').selection('input').set({'wp1'});
model.geom('geom1').feature('rev1').set('angtype', 'full');
model.geom('geom1').feature('rev1').set('axis', [1 0]);
model.geom('geom1').runPre('fin');

model.selection.create('sel1', 'Explicit');
model.selection('sel1').model('comp1');

model.geom('geom1').run;

model.selection('sel1').geom(1);

model.view('view1').set('renderwireframe', true);

model.selection('sel1').set([10]);
model.selection('sel1').set('groupcontang', true);
model.selection('sel1').label('Beam Rotor');
model.selection.create('sel2', 'Explicit');
model.selection('sel2').model('comp1');
model.selection('sel2').geom(2);
model.selection('sel2').set([29]);
model.selection('sel2').set('groupcontang', true);
model.selection('sel2').label('Journal Bearing 1');
model.selection.duplicate('sel3', 'sel2');
model.selection('sel3').remove([28 29 31 33 34 35 36 37]);
model.selection('sel3').add([100 101 103 105 106 107 108 109]);
model.selection('sel3').label('Journal Bearing 2');
model.selection.duplicate('sel4', 'sel3');
model.selection('sel4').remove([100 101 103 105 106 107 108 109]);
model.selection('sel4').add([168 169 171 173 174 175 176 177]);
model.selection('sel4').label('Journal Bearing 3');

model.func.create('int1', 'Interpolation');
model.func('int1').model('comp1');
model.func('int1').set('table', {'x1' 'd_1_2';  ...
'x2-xTol' 'd_1_2';  ...
'x2' 'd_2_3';  ...
'x3-xTol' 'd_2_3';  ...
'x3' 'd_3_4';  ...
'x4-xTol' 'd_3_4';  ...
'x4' 'd_4_5';  ...
'x5-xTol' 'd_4_5';  ...
'x5' 'd_5_6';  ...
'x6-xTol' 'd_5_6';  ...
'x6' 'd_6_7';  ...
'x7-xTol' 'd_6_7';  ...
'x7' 'd_7_8';  ...
'x8-xTol' 'd_7_8';  ...
'x8' 'd_8_9';  ...
'x9-xTol' 'd_8_9';  ...
'x9' 'd_9_10';  ...
'x10-xTol' 'd_9_10';  ...
'x10' 'd_10_11';  ...
'x11-xTol' 'd_10_11';  ...
'x11' 'd_11_12';  ...
'x12-xTol' 'd_11_12';  ...
'x12' 'd_12_13';  ...
'x13-xTol' 'd_12_13';  ...
'x13' 'd_13_14';  ...
'x14-xTol' 'd_13_14';  ...
'x14' 'd_14_15';  ...
'x15-xTol' 'd_14_15';  ...
'x15' 'd_15_16';  ...
'x16-xTol' 'd_15_16';  ...
'x16' 'd_16_17';  ...
'x17-xTol' 'd_16_17';  ...
'x17' 'd_17_18';  ...
'x18' 'd_17_18';  ...
'x19' 'd_19_20';  ...
'x20-xTol' 'd_19_20';  ...
'x20' 'd_20_21';  ...
'x21-xTol' 'd_20_21';  ...
'x21' 'd_21_22';  ...
'x22' 'd_21_22';  ...
'x23' 'd_23_24';  ...
'x24-xTol' 'd_23_24';  ...
'x24' 'd_24_25';  ...
'x25-xTol' 'd_24_25';  ...
'x25' 'd_25_26';  ...
'x26-xTol' 'd_25_26';  ...
'x26' 'd_26_27';  ...
'x27-xTol' 'd_26_27';  ...
'x27' 'd_27_28';  ...
'x28' 'd_27_28'});
model.func('int1').label('Interpolation: rotor dia');
model.func('int1').set('funcname', 'dia');
model.func('int1').setIndex('fununit', 'm', 0);
model.func('int1').setIndex('argunit', 'm', 0);

model.material.create('mat1', 'Common', '');
model.material('mat1').propertyGroup.create('Enu', 'Young''s modulus and Poisson''s ratio');
model.material('mat1').propertyGroup('Enu').func.create('int1', 'Interpolation');
model.material('mat1').propertyGroup('Enu').func.create('int2', 'Interpolation');
model.material('mat1').propertyGroup.create('Murnaghan', 'Murnaghan');
model.material('mat1').propertyGroup.create('ElastoplasticModel', 'Elastoplastic material model');
model.material('mat1').propertyGroup('ElastoplasticModel').func.create('int1', 'Interpolation');
model.material('mat1').propertyGroup.create('Ludwik', 'Ludwik');
model.material('mat1').propertyGroup('Ludwik').func.create('int1', 'Interpolation');
model.material('mat1').propertyGroup.create('JohnsonCook', 'Johnson-Cook');
model.material('mat1').propertyGroup.create('Swift', 'Swift');
model.material('mat1').propertyGroup.create('Voce', 'Voce');
model.material('mat1').propertyGroup('Voce').func.create('int1', 'Interpolation');
model.material('mat1').propertyGroup.create('HockettSherby', 'Hockett-Sherby');
model.material('mat1').propertyGroup('HockettSherby').func.create('int1', 'Interpolation');
model.material('mat1').propertyGroup.create('ArmstrongFrederick', 'Armstrong-Frederick');
model.material('mat1').propertyGroup('ArmstrongFrederick').func.create('int1', 'Interpolation');
model.material('mat1').propertyGroup.create('Norton', 'Norton');
model.material('mat1').propertyGroup.create('Garofalo', 'Garofalo (hyperbolic sine)');
model.material('mat1').propertyGroup.create('ChabocheViscoplasticity', 'Chaboche viscoplasticity');
model.material('mat1').label('Structural steel');
model.material('mat1').set('family', 'custom');
model.material('mat1').set('customspecular', [0.7843137254901961 0.7843137254901961 0.7843137254901961]);
model.material('mat1').set('customdiffuse', [0.6666666666666666 0.6666666666666666 0.6666666666666666]);
model.material('mat1').set('customambient', [0.6666666666666666 0.6666666666666666 0.6666666666666666]);
model.material('mat1').set('noise', true);
model.material('mat1').set('fresnel', 0.9);
model.material('mat1').set('roughness', 0.3);
model.material('mat1').set('metallic', 0);
model.material('mat1').set('pearl', 0);
model.material('mat1').set('diffusewrap', 0);
model.material('mat1').set('clearcoat', 0);
model.material('mat1').set('reflectance', 0);
model.material('mat1').propertyGroup('def').set('lossfactor', '0.02');
model.material('mat1').propertyGroup('def').set('relpermeability', {'1' '0' '0' '0' '1' '0' '0' '0' '1'});
model.material('mat1').propertyGroup('def').set('heatcapacity', '475[J/(kg*K)]');
model.material('mat1').propertyGroup('def').set('thermalconductivity', {'44.5[W/(m*K)]' '0' '0' '0' '44.5[W/(m*K)]' '0' '0' '0' '44.5[W/(m*K)]'});
model.material('mat1').propertyGroup('def').set('electricconductivity', {'4.032e6[S/m]' '0' '0' '0' '4.032e6[S/m]' '0' '0' '0' '4.032e6[S/m]'});
model.material('mat1').propertyGroup('def').set('relpermittivity', {'1' '0' '0' '0' '1' '0' '0' '0' '1'});
model.material('mat1').propertyGroup('def').set('thermalexpansioncoefficient', {'12.3e-6[1/K]' '0' '0' '0' '12.3e-6[1/K]' '0' '0' '0' '12.3e-6[1/K]'});
model.material('mat1').propertyGroup('def').set('density', '7850[kg/m^3]');
model.material('mat1').propertyGroup('Enu').func('int1').set('funcname', 'E');
model.material('mat1').propertyGroup('Enu').func('int1').set('table', {'293.15' '200e9'; '793.15' '166.6e9'});
model.material('mat1').propertyGroup('Enu').func('int1').set('extrap', 'linear');
model.material('mat1').propertyGroup('Enu').func('int1').set('fununit', {'Pa'});
model.material('mat1').propertyGroup('Enu').func('int1').set('argunit', {'K'});
model.material('mat1').propertyGroup('Enu').func('int2').set('funcname', 'nu');
model.material('mat1').propertyGroup('Enu').func('int2').set('table', {'293.15' '0.30'; '793.15' '0.315'});
model.material('mat1').propertyGroup('Enu').func('int2').set('extrap', 'linear');
model.material('mat1').propertyGroup('Enu').func('int2').set('fununit', {'1'});
model.material('mat1').propertyGroup('Enu').func('int2').set('argunit', {'K'});
model.material('mat1').propertyGroup('Enu').set('E', 'E(T)');
model.material('mat1').propertyGroup('Enu').set('nu', 'nu(T)');
model.material('mat1').propertyGroup('Enu').addInput('temperature');
model.material('mat1').propertyGroup('Murnaghan').set('l', '-3.0e11[Pa]');
model.material('mat1').propertyGroup('Murnaghan').set('m', '-6.2e11[Pa]');
model.material('mat1').propertyGroup('Murnaghan').set('n', '-7.2e11[Pa]');
model.material('mat1').propertyGroup('ElastoplasticModel').func('int1').set('funcname', 'a');
model.material('mat1').propertyGroup('ElastoplasticModel').func('int1').set('table', {'600' '1'; '1100' '0.1'; '1643' '0'});
model.material('mat1').propertyGroup('ElastoplasticModel').func('int1').set('fununit', {'1'});
model.material('mat1').propertyGroup('ElastoplasticModel').func('int1').set('argunit', {'K'});
model.material('mat1').propertyGroup('ElastoplasticModel').set('sigmags', '350[MPa]*a(T)');
model.material('mat1').propertyGroup('ElastoplasticModel').set('Et', '1.045[GPa]*a(T)');
model.material('mat1').propertyGroup('ElastoplasticModel').set('Ek', '1.045[GPa]*a(T)');
model.material('mat1').propertyGroup('ElastoplasticModel').set('sigmagh', '1.050[GPa]*epe*a(T)');
model.material('mat1').propertyGroup('ElastoplasticModel').addInput('temperature');
model.material('mat1').propertyGroup('ElastoplasticModel').addInput('effectiveplasticstrain');
model.material('mat1').propertyGroup('Ludwik').func('int1').set('funcname', 'a');
model.material('mat1').propertyGroup('Ludwik').func('int1').set('table', {'600' '1'; '1100' '0.1'; '1643' '0'});
model.material('mat1').propertyGroup('Ludwik').func('int1').set('fununit', {'1'});
model.material('mat1').propertyGroup('Ludwik').func('int1').set('argunit', {'K'});
model.material('mat1').propertyGroup('Ludwik').set('k_lud', '560[MPa]*a(T)');
model.material('mat1').propertyGroup('Ludwik').set('n_lud', '0.61');
model.material('mat1').propertyGroup('Ludwik').addInput('temperature');
model.material('mat1').propertyGroup('JohnsonCook').set('k_jcook', '560[MPa]');
model.material('mat1').propertyGroup('JohnsonCook').set('n_jcook', '0.61');
model.material('mat1').propertyGroup('JohnsonCook').set('C_jcook', '0.12');
model.material('mat1').propertyGroup('JohnsonCook').set('epet0_jcook', '1[1/s]');
model.material('mat1').propertyGroup('JohnsonCook').set('m_jcook', '0.6');
model.material('mat1').propertyGroup('Swift').set('e0_swi', '0.021');
model.material('mat1').propertyGroup('Swift').set('n_swi', '0.2');
model.material('mat1').propertyGroup('Voce').func('int1').set('funcname', 'a');
model.material('mat1').propertyGroup('Voce').func('int1').set('table', {'600' '1'; '1100' '0.1'; '1643' '0'});
model.material('mat1').propertyGroup('Voce').func('int1').set('fununit', {'1'});
model.material('mat1').propertyGroup('Voce').func('int1').set('argunit', {'K'});
model.material('mat1').propertyGroup('Voce').set('sigma_voc', '249[MPa]*a(T)');
model.material('mat1').propertyGroup('Voce').set('beta_voc', '9.3');
model.material('mat1').propertyGroup('Voce').addInput('temperature');
model.material('mat1').propertyGroup('HockettSherby').func('int1').set('funcname', 'a');
model.material('mat1').propertyGroup('HockettSherby').func('int1').set('table', {'600' '1'; '1100' '0.1'; '1643' '0'});
model.material('mat1').propertyGroup('HockettSherby').func('int1').set('fununit', {'1'});
model.material('mat1').propertyGroup('HockettSherby').func('int1').set('argunit', {'K'});
model.material('mat1').propertyGroup('HockettSherby').set('sigma_hoc', '684[MPa]*a(T)');
model.material('mat1').propertyGroup('HockettSherby').set('m_hoc', '3.9');
model.material('mat1').propertyGroup('HockettSherby').set('n_hoc', '0.85');
model.material('mat1').propertyGroup('HockettSherby').addInput('temperature');
model.material('mat1').propertyGroup('ArmstrongFrederick').func('int1').set('funcname', 'a');
model.material('mat1').propertyGroup('ArmstrongFrederick').func('int1').set('table', {'600' '1'; '1100' '0.1'; '1643' '0'});
model.material('mat1').propertyGroup('ArmstrongFrederick').func('int1').set('fununit', {'1'});
model.material('mat1').propertyGroup('ArmstrongFrederick').func('int1').set('argunit', {'K'});
model.material('mat1').propertyGroup('ArmstrongFrederick').set('Ck', '2.070[GPa]*a(T)');
model.material('mat1').propertyGroup('ArmstrongFrederick').set('gammak', '8.0');
model.material('mat1').propertyGroup('ArmstrongFrederick').addInput('temperature');
model.material('mat1').propertyGroup('Norton').set('A_nor', '1.2e-15[1/s]');
model.material('mat1').propertyGroup('Norton').set('sigRef_nor', '1[MPa]');
model.material('mat1').propertyGroup('Norton').set('n_nor', '4.5');
model.material('mat1').propertyGroup('Garofalo').set('A_gar', '1e-6[1/s]');
model.material('mat1').propertyGroup('Garofalo').set('sigRef_gar', '100[MPa]');
model.material('mat1').propertyGroup('Garofalo').set('n_gar', '4.6');
model.material('mat1').propertyGroup('ChabocheViscoplasticity').set('A_cha', '1');
model.material('mat1').propertyGroup('ChabocheViscoplasticity').set('sigRef_cha', '490[MPa]');
model.material('mat1').propertyGroup('ChabocheViscoplasticity').set('n_cha', '9');
model.material.create('matlnk1', 'Link', 'comp1');
model.material('matlnk1').label('Material Link: Solid');
model.material.duplicate('matlnk2', 'matlnk1');
model.material('matlnk2').selection.geom('geom1', 1);
model.material('matlnk2').selection.named('sel1');
model.material('matlnk2').label('Material Link: Beam');

model.physics('rotsld').prop('RotorProperties').set('rpt', 'fr');
model.physics('rotsld').feature('raxi1').set('specifiedBy', 'Edge');
model.physics('rotsld').feature('raxi1').feature('axis1').selection.named('sel1');
model.physics('rotsld').feature('far1').selection.set([186 187 188 189]);
model.physics('rotsld').create('jrb1', 'JournalBearing', 2);
model.physics('rotsld').feature('jrb1').selection.named('sel2');
model.physics('rotsld').feature('jrb1').set('BearingModel', 'kTot');
model.physics('rotsld').feature('jrb1').set('k_u', {'kb' '0' '0' 'kb'});
model.physics('rotsld').feature('jrb1').set('k_th', [0 0 0 0]);
model.physics('rotsld').feature.duplicate('jrb2', 'jrb1');
model.physics('rotsld').feature('jrb2').selection.named('sel3');
model.physics('rotsld').feature('jrb2').set('k_th', [0 0 0 0]);
model.physics('rotsld').feature.duplicate('jrb3', 'jrb2');
model.physics('rotsld').feature('jrb3').selection.named('sel4');
model.physics('rotsld').feature('jrb3').set('k_th', [0 0 0 0]);
model.physics('srotf').prop('RotorProperties').set('rpt', 'fr');
model.physics('srotf').feature('raxi1').set('specifiedBy', 'Edge');
model.physics('srotf').feature('raxi1').feature('axis1').selection.named('sel1');
model.physics('srotf').feature('far1').selection.set([186 187 188 189]);
model.physics('srotf').feature.copy('jrb1', 'rotsld/jrb1');
model.physics('srotf').feature.copy('jrb2', 'rotsld/jrb2');
model.physics('srotf').feature.copy('jrb3', 'rotsld/jrb3');
model.physics('srotf').feature('jrb1').set('k_th', [0 0 0 0]);
model.physics('srotf').feature('jrb2').set('k_th', [0 0 0 0]);
model.physics('srotf').feature('jrb3').set('k_th', [0 0 0 0]);
model.physics('rotbm').selection.named('sel1');
model.physics('rotbm').prop('RotorProperties').set('rpt', 'fr');
model.physics('rotbm').feature('rcs1').set('do_circ', 'dia(x)');
model.physics('rotbm').create('jrb1', 'JournalBearing', 0);
model.physics('rotbm').feature('jrb1').selection.set([42]);
model.physics('rotbm').feature('jrb1').set('BearingModel', 'kTot');
model.physics('rotbm').feature('jrb1').set('k_u', {'kb' '0' '0' 'kb'});
model.physics('rotbm').feature.duplicate('jrb2', 'jrb1');
model.physics('rotbm').feature('jrb2').selection.set([117]);
model.physics('rotbm').feature.duplicate('jrb3', 'jrb2');
model.physics('rotbm').feature('jrb3').selection.set([196]);

model.mesh('mesh1').label('Mesh: Solid');
model.mesh('mesh1').create('swe1', 'Sweep');
model.mesh('mesh1').feature('swe1').create('dis1', 'Distribution');
model.mesh('mesh1').feature('swe1').feature('dis1').set('numelem', 30);
model.mesh('mesh1').run('swe1');
model.mesh.create('mesh2', 'geom1');
model.mesh('mesh2').contribute('physics/rotsld', false);
model.mesh('mesh2').contribute('physics/srotf', false);
model.mesh('mesh2').label('Mesh: Beam');
model.mesh('mesh2').create('edg1', 'Edge');
model.mesh('mesh2').feature('edg1').selection.named('sel1');
model.mesh('mesh2').run;

model.study('std1').label('Study: Solid Rotor');
model.study('std1').create('param', 'Parametric');
model.study('std1').feature('param').setIndex('pname', 'd_1_2', 0);
model.study('std1').feature('param').setIndex('plistarr', '', 0);
model.study('std1').feature('param').setIndex('punit', 'm', 0);
model.study('std1').feature('param').setIndex('pname', 'd_1_2', 0);
model.study('std1').feature('param').setIndex('plistarr', '', 0);
model.study('std1').feature('param').setIndex('punit', 'm', 0);
model.study('std1').feature('param').setIndex('pname', 'fr', 0);
model.study('std1').feature('param').setIndex('plistarr', 'range(0,2000,50000)', 0);
model.study('std1').feature('param').setIndex('punit', 'rpm', 0);
model.study('std1').feature('stat').set('useadvanceddisable', true);
model.study('std1').feature('stat').setSolveFor('/physics/srotf', false);
model.study('std1').feature('stat').setSolveFor('/physics/rotbm', false);
model.study('std1').feature('stat').set('disabledphysics', {'srotf' 'rotbm'});
model.study('std1').feature('stat').set('useadvanceddisable', false);
model.study('std1').feature('eig').set('neigsactive', true);
model.study('std1').feature('eig').set('neigs', 7);
model.study('std1').feature('eig').set('useadvanceddisable', true);
model.study('std1').feature('eig').setSolveFor('/physics/srotf', false);
model.study('std1').feature('eig').setSolveFor('/physics/rotbm', false);
model.study('std1').feature('eig').set('disabledphysics', {'srotf' 'rotbm'});
model.study('std1').feature('eig').set('useadvanceddisable', false);

model.sol.create('sol1');
model.sol('sol1').study('std1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'stat');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').feature('comp1_u').set('scalemethod', 'manual');
model.sol('sol1').feature('v1').feature('comp1_u').set('scaleval', '1e-2*0.7322738558763382');
model.sol('sol1').feature('v1').set('control', 'stat');
model.sol('sol1').create('s1', 'Stationary');
model.sol('sol1').feature('s1').set('stol', 0.001);
model.sol('sol1').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('s1').feature('fc1').set('linsolver', 'dDef');
model.sol('sol1').feature('s1').feature.remove('fcDef');
model.sol('sol1').create('su1', 'StoreSolution');
model.sol('sol1').create('st2', 'StudyStep');
model.sol('sol1').feature('st2').set('study', 'std1');
model.sol('sol1').feature('st2').set('studystep', 'eig');
model.sol('sol1').create('v2', 'Variables');
model.sol('sol1').feature('v2').feature('comp1_u').set('scalemethod', 'manual');
model.sol('sol1').feature('v2').feature('comp1_u').set('scaleval', '1e-2*0.7322738558763382');
model.sol('sol1').feature('v2').set('initmethod', 'sol');
model.sol('sol1').feature('v2').set('initsol', 'sol1');
model.sol('sol1').feature('v2').set('initsoluse', 'sol2');
model.sol('sol1').feature('v2').set('notsolmethod', 'sol');
model.sol('sol1').feature('v2').set('notsol', 'sol1');
model.sol('sol1').feature('v2').set('control', 'eig');
model.sol('sol1').create('e1', 'Eigenvalue');
model.sol('sol1').feature('e1').set('control', 'eig');
model.sol('sol1').feature('e1').set('linpmethod', 'sol');
model.sol('sol1').feature('e1').set('linpsol', 'sol1');
model.sol('sol1').feature('e1').set('linpsoluse', 'sol2');
model.sol('sol1').feature('e1').set('control', 'eig');
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
model.batch('p1').set('pname', {'fr'});
model.batch('p1').set('plistarr', {'range(0,2000,50000)'});
model.batch('p1').set('sweeptype', 'sparse');
model.batch('p1').set('probesel', 'all');
model.batch('p1').set('probes', {});
model.batch('p1').set('plot', 'off');
model.batch('p1').set('err', 'on');
model.batch('p1').attach('std1');
model.batch('p1').set('control', 'param');

model.sol.create('sol3');
model.sol('sol3').study('std1');
model.sol('sol3').label('Parametric Solutions 1');

model.batch('p1').feature('so1').set('psol', 'sol3');
model.batch('p1').run('compute');

model.result.dataset.create('cln1', 'CutLine3D');
model.result.dataset('cln1').label('Axis');
model.result.dataset('cln1').set('data', 'none');
model.result.dataset('cln1').set('genpoints', {'comp1.rotsld.raxi1.r1x' 'comp1.rotsld.raxi1.r1y' 'comp1.rotsld.raxi1.r1z'; 'comp1.rotsld.raxi1.r2x' 'comp1.rotsld.raxi1.r2y' 'comp1.rotsld.raxi1.r2z'});
model.result.dataset('cln1').set('bounded', false);
model.result.dataset('cln1').set('data', 'dset3');
model.result.create('pg1', 'PlotGroup3D');
model.result('pg1').label('Mode Shape (rotsld)');
model.result('pg1').set('data', 'dset3');
model.result('pg1').setIndex('looplevel', 1, 0);
model.result('pg1').setIndex('looplevel', 26, 1);
model.result('pg1').set('showlegends', 'off');
model.result('pg1').set('data', 'dset3');
model.result('pg1').setIndex('looplevel', 1, 0);
model.result('pg1').setIndex('looplevel', 26, 1);
model.result('pg1').set('defaultPlotID', 'modeShape');
model.result('pg1').feature.create('surf1', 'Surface');
model.result('pg1').feature('surf1').set('colortable', 'AuroraBorealis');
model.result('pg1').feature('surf1').set('smooth', 'internal');
model.result('pg1').feature('surf1').set('data', 'parent');
model.result('pg1').feature('surf1').feature.create('def1', 'Deform');
model.result('pg1').feature('surf1').feature('def1').label('Deformation');
model.result.create('pg2', 'PlotGroup3D');
model.result('pg2').label('Whirl (rotsld)');
model.result('pg2').set('data', 'cln1');
model.result('pg2').setIndex('looplevel', 1, 0);
model.result('pg2').setIndex('looplevel', 26, 1);
model.result('pg2').set('showlegends', 'off');
model.result('pg2').set('data', 'cln1');
model.result('pg2').setIndex('looplevel', 1, 0);
model.result('pg2').setIndex('looplevel', 26, 1);
model.result('pg2').set('defaultPlotID', 'whirl');
model.result('pg2').feature.create('wp1', 'Whirl');
model.result('pg2').feature('wp1').set('nrings', 10);
model.result('pg2').feature('wp1').set('colortable', 'TrafficLight');
model.result('pg2').feature('wp1').set('smooth', 'internal');
model.result('pg2').feature('wp1').set('data', 'parent');
model.result.evaluationGroup.create('std1EvgFrq', 'EvaluationGroup');
model.result.evaluationGroup('std1EvgFrq').set('defaultPlotID', 'eigenfrequenciesTable_rotsld');
model.result.evaluationGroup('std1EvgFrq').set('data', 'dset3');
model.result.evaluationGroup('std1EvgFrq').label('Eigenfrequencies (Study: Solid Rotor)');
model.result.evaluationGroup('std1EvgFrq').create('gev1', 'EvalGlobal');
model.result.evaluationGroup('std1EvgFrq').feature('gev1').setIndex('expr', '2*pi*freq', 0);
model.result.evaluationGroup('std1EvgFrq').feature('gev1').setIndex('unit', 'rad/s', 0);
model.result.evaluationGroup('std1EvgFrq').feature('gev1').setIndex('descr', 'Angular frequency', 0);
model.result.evaluationGroup('std1EvgFrq').feature('gev1').setIndex('expr', 'imag(freq)/abs(freq)', 1);
model.result.evaluationGroup('std1EvgFrq').feature('gev1').setIndex('unit', '1', 1);
model.result.evaluationGroup('std1EvgFrq').feature('gev1').setIndex('descr', 'Damping ratio', 1);
model.result.evaluationGroup('std1EvgFrq').feature('gev1').setIndex('expr', 'abs(freq)/imag(freq)/2', 2);
model.result.evaluationGroup('std1EvgFrq').feature('gev1').setIndex('unit', '1', 2);
model.result.evaluationGroup('std1EvgFrq').feature('gev1').setIndex('descr', 'Quality factor', 2);
model.result.evaluationGroup('std1EvgFrq').run;
model.result('pg1').run;
model.result('pg1').set('looplevel', [6 26]);
model.result('pg1').run;
model.result('pg2').run;
model.result('pg2').set('looplevel', [6 26]);
model.result('pg2').run;
model.result.create('pg3', 'PlotGroup1D');
model.result('pg3').set('data', 'dset3');
model.result('pg3').create('glob1', 'Global');
model.result('pg3').feature('glob1').set('unit', {''});
model.result('pg3').feature('glob1').set('expr', {'rotsld.omegaf'});
model.result('pg3').feature('glob1').set('descr', {'Forward angular frequency'});
model.result('pg3').feature('glob1').set('xdata', 'expr');
model.result('pg3').feature('glob1').set('xdataexpr', 'rotsld.Ovg');
model.result('pg3').feature('glob1').set('xdataunit', 'rad/s');
model.result('pg3').feature('glob1').label('Forward Whirl Mode');
model.result('pg3').feature('glob1').set('linestyle', 'dashed');
model.result('pg3').feature('glob1').set('linecolor', 'blue');
model.result('pg3').feature('glob1').set('linewidth', 3);
model.result('pg3').feature('glob1').set('legend', false);
model.result('pg3').feature('glob1').set('xdatasolnumtype', 'outer');
model.result('pg3').feature('glob1').create('gmrk1', 'GraphMarker');
model.result('pg3').feature('glob1').feature('gmrk1').set('displaymode', 'intersection');
model.result('pg3').feature('glob1').feature('gmrk1').set('intersectionline', 'identity');
model.result('pg3').feature('glob1').feature('gmrk1').set('precision', 4);
model.result('pg3').feature('glob1').feature('gmrk1').set('labelprefix', 'f: ');
model.result('pg3').feature('glob1').feature('gmrk1').set('pointradius', 4);
model.result('pg3').feature('glob1').feature('gmrk1').set('color', 'custom');
model.result('pg3').feature('glob1').feature('gmrk1').set('customcolor', [1 0.501960813999176 0.250980406999588]);
model.result('pg3').feature('glob1').feature('gmrk1').set('anchorpoint', 'lowermiddle');
model.result('pg3').set('defaultPlotID', 'campbellFixedFrame');
model.result('pg3').label('Campbell Plot, Fixed Frame (rotsld)');
model.result('pg3').create('glob2', 'Global');
model.result('pg3').feature('glob2').set('expr', {'rotsld.omegab'});
model.result('pg3').feature('glob2').set('xdata', 'expr');
model.result('pg3').feature('glob2').set('xdataexpr', 'rotsld.Ovg');
model.result('pg3').feature('glob2').set('xdataunit', 'rad/s');
model.result('pg3').feature('glob2').set('linestyle', 'dotted');
model.result('pg3').feature('glob2').set('linecolor', 'blue');
model.result('pg3').feature('glob2').set('linewidth', 3);
model.result('pg3').feature('glob2').set('legend', false);
model.result('pg3').feature('glob2').label('Backward Whirl Mode');
model.result('pg3').feature('glob2').set('xdatasolnumtype', 'outer');
model.result('pg3').feature('glob2').create('gmrk1', 'GraphMarker');
model.result('pg3').feature('glob2').feature('gmrk1').set('displaymode', 'intersection');
model.result('pg3').feature('glob2').feature('gmrk1').set('intersectionline', 'identity');
model.result('pg3').feature('glob2').feature('gmrk1').set('precision', 4);
model.result('pg3').feature('glob2').feature('gmrk1').set('labelprefix', 'b: ');
model.result('pg3').feature('glob2').feature('gmrk1').set('pointradius', 4);
model.result('pg3').feature('glob2').feature('gmrk1').set('color', 'custom');
model.result('pg3').feature('glob2').feature('gmrk1').set('customcolor', [0.7490196228027344 0.1411764770746231 0.3686274588108063]);
model.result('pg3').feature('glob2').feature('gmrk1').set('anchorpoint', 'uppermiddle');
model.result('pg3').create('glob3', 'Global');
model.result('pg3').feature('glob3').set('expr', {'rotsld.omegan'});
model.result('pg3').feature('glob3').set('xdata', 'expr');
model.result('pg3').feature('glob3').set('xdataexpr', 'rotsld.Ovg');
model.result('pg3').feature('glob3').set('xdataunit', 'rad/s');
model.result('pg3').feature('glob3').set('linecolor', 'blue');
model.result('pg3').feature('glob3').set('linewidth', 3);
model.result('pg3').feature('glob3').set('legend', false);
model.result('pg3').feature('glob3').label('Planar or Torsional Mode');
model.result('pg3').feature('glob3').set('xdatasolnumtype', 'outer');
model.result('pg3').feature('glob3').create('gmrk1', 'GraphMarker');
model.result('pg3').feature('glob3').feature('gmrk1').set('displaymode', 'intersection');
model.result('pg3').feature('glob3').feature('gmrk1').set('intersectionline', 'identity');
model.result('pg3').feature('glob3').feature('gmrk1').set('precision', 4);
model.result('pg3').feature('glob3').feature('gmrk1').set('labelprefix', 't,p: ');
model.result('pg3').feature('glob3').feature('gmrk1').set('pointradius', 4);
model.result('pg3').feature('glob3').feature('gmrk1').set('color', 'custom');
model.result('pg3').feature('glob3').feature('gmrk1').set('customcolor', [0.03529411926865578 0.4627451002597809 0.03529411926865578]);
model.result('pg3').feature('glob3').feature('gmrk1').set('anchorpoint', 'uppermiddle');
model.result('pg3').create('glob4', 'Global');
model.result('pg3').feature('glob4').set('expr', {'if(rotsld.Ovg<=1.4*rotsld.omega,rotsld.Ovg,NaN)'});
model.result('pg3').feature('glob4').set('data', 'dset3');
model.result('pg3').feature('glob4').set('xdata', 'expr');
model.result('pg3').feature('glob4').set('xdataexpr', 'rotsld.Ovg');
model.result('pg3').feature('glob4').set('xdataunit', 'rad/s');
model.result('pg3').feature('glob4').set('linecolor', 'red');
model.result('pg3').feature('glob4').set('linewidth', 3);
model.result('pg3').feature('glob4').label('omega=Omega');
model.result('pg3').feature('glob4').set('xdatasolnumtype', 'outer');
model.result('pg3').feature('glob4').set('solutionparams', 'manual');
model.result('pg3').feature('glob4').setIndex('looplevelinput', 'last', 0);
model.result('pg3').feature('glob4').set('legend', true);
model.result('pg3').feature('glob4').set('legendmethod', 'manual');
model.result('pg3').feature('glob4').setIndex('legends', '\omega=\Omega', 0);
model.result('pg3').set('ylabel', 'Angular frequency (rad/s)');
model.result('pg3').set('titletype', 'manual');
model.result('pg3').set('title', 'Campbell plot, fixed frame');
model.result('pg3').label('Campbell Plot, Fixed Frame (rotsld)');
model.result('pg3').run;
model.result('pg3').set('legendpos', 'upperleft');

model.study.create('std2');
model.study('std2').create('stat', 'Stationary');
model.study('std2').feature('stat').set('plotgroup', 'Default');
model.study('std2').feature('stat').set('solnum', 'auto');
model.study('std2').feature('stat').set('notsolnum', 'auto');
model.study('std2').feature('stat').set('outputmap', {});
model.study('std2').feature('stat').set('ngenAUX', '1');
model.study('std2').feature('stat').set('goalngenAUX', '1');
model.study('std2').feature('stat').set('ngenAUX', '1');
model.study('std2').feature('stat').set('goalngenAUX', '1');
model.study('std2').feature('stat').setSolveFor('/physics/rotsld', false);
model.study('std2').feature('stat').setSolveFor('/physics/srotf', true);
model.study('std2').feature('stat').setSolveFor('/physics/rotbm', false);
model.study('std2').create('eig', 'Eigenfrequency');
model.study('std2').feature('eig').set('plotgroup', 'Default');
model.study('std2').feature('eig').set('chkeigregion', true);
model.study('std2').feature('eig').set('conrad', '1');
model.study('std2').feature('eig').set('conradynhm', '1');
model.study('std2').feature('eig').set('storefact', false);
model.study('std2').feature('eig').set('geometricNonlinearity', true);
model.study('std2').feature('eig').set('solnum', 'auto');
model.study('std2').feature('eig').set('notsolnum', 'auto');
model.study('std2').feature('eig').set('outputmap', {});
model.study('std2').feature('eig').set('ngenAUX', '1');
model.study('std2').feature('eig').set('goalngenAUX', '1');
model.study('std2').feature('eig').set('ngenAUX', '1');
model.study('std2').feature('eig').set('goalngenAUX', '1');
model.study('std2').feature('eig').setSolveFor('/physics/rotsld', false);
model.study('std2').feature('eig').setSolveFor('/physics/srotf', true);
model.study('std2').feature('eig').setSolveFor('/physics/rotbm', false);
model.study.create('std3');
model.study('std3').create('eig', 'Eigenfrequency');
model.study('std3').feature('eig').setSolveFor('/physics/rotsld', false);
model.study('std3').feature('eig').setSolveFor('/physics/srotf', false);
model.study('std3').feature('eig').setSolveFor('/physics/rotbm', true);
model.study('std2').label('Study: SRFF');
model.study('std2').create('param', 'Parametric');
model.study('std2').feature('param').setIndex('pname', 'd_1_2', 0);
model.study('std2').feature('param').setIndex('plistarr', '', 0);
model.study('std2').feature('param').setIndex('punit', 'm', 0);
model.study('std2').feature('param').setIndex('pname', 'd_1_2', 0);
model.study('std2').feature('param').setIndex('plistarr', '', 0);
model.study('std2').feature('param').setIndex('punit', 'm', 0);
model.study('std2').feature('param').setIndex('pname', 'fr', 0);
model.study('std2').feature('param').setIndex('plistarr', 'range(0,2000,50000)', 0);
model.study('std2').feature('param').setIndex('punit', 'rpm', 0);
model.study('std2').feature('stat').set('useadvanceddisable', true);
model.study('std2').feature('stat').set('disabledphysics', {'rotsld' 'rotbm'});
model.study('std2').feature('stat').setEntry('mesh', 'geom1', 'mesh1');
model.study('std2').feature('stat').set('useadvanceddisable', false);
model.study('std2').feature('eig').set('useadvanceddisable', true);
model.study('std2').feature('eig').set('disabledphysics', {'rotsld' 'rotbm'});
model.study('std2').feature('eig').setEntry('mesh', 'geom1', 'mesh1');
model.study('std2').feature('eig').set('neigsactive', true);
model.study('std2').feature('eig').set('neigs', 9);

model.sol.create('sol30');
model.sol('sol30').study('std2');
model.sol('sol30').create('st1', 'StudyStep');
model.sol('sol30').feature('st1').set('study', 'std2');
model.sol('sol30').feature('st1').set('studystep', 'stat');
model.sol('sol30').create('v1', 'Variables');
model.sol('sol30').feature('v1').feature('comp1_u2').set('scalemethod', 'manual');
model.sol('sol30').feature('v1').feature('comp1_u2').set('scaleval', '1e-2*0.7322738558763382');
model.sol('sol30').feature('v1').set('control', 'stat');
model.sol('sol30').create('s1', 'Stationary');
model.sol('sol30').feature('s1').set('stol', 0.001);
model.sol('sol30').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol30').feature('s1').feature('fc1').set('linsolver', 'dDef');
model.sol('sol30').feature('s1').feature.remove('fcDef');
model.sol('sol30').create('su1', 'StoreSolution');
model.sol('sol30').create('st2', 'StudyStep');
model.sol('sol30').feature('st2').set('study', 'std2');
model.sol('sol30').feature('st2').set('studystep', 'eig');
model.sol('sol30').create('v2', 'Variables');
model.sol('sol30').feature('v2').feature('comp1_u2').set('scalemethod', 'manual');
model.sol('sol30').feature('v2').feature('comp1_u2').set('scaleval', '1e-2*0.7322738558763382');
model.sol('sol30').feature('v2').set('initmethod', 'sol');
model.sol('sol30').feature('v2').set('initsol', 'sol30');
model.sol('sol30').feature('v2').set('initsoluse', 'sol31');
model.sol('sol30').feature('v2').set('notsolmethod', 'sol');
model.sol('sol30').feature('v2').set('notsol', 'sol30');
model.sol('sol30').feature('v2').set('control', 'eig');
model.sol('sol30').create('e1', 'Eigenvalue');
model.sol('sol30').feature('e1').set('control', 'eig');
model.sol('sol30').feature('e1').set('linpmethod', 'sol');
model.sol('sol30').feature('e1').set('linpsol', 'sol30');
model.sol('sol30').feature('e1').set('linpsoluse', 'sol31');
model.sol('sol30').feature('e1').set('control', 'eig');
model.sol('sol30').feature('v2').set('notsolnum', 'auto');
model.sol('sol30').feature('v2').set('notsolvertype', 'solnum');
model.sol('sol30').attach('std2');

model.batch.create('p2', 'Parametric');
model.batch('p2').study('std2');
model.batch('p2').create('so1', 'Solutionseq');
model.batch('p2').feature('so1').set('seq', 'sol30');
model.batch('p2').feature('so1').set('store', 'on');
model.batch('p2').feature('so1').set('clear', 'on');
model.batch('p2').feature('so1').set('psol', 'none');
model.batch('p2').set('pname', {'fr'});
model.batch('p2').set('plistarr', {'range(0,2000,50000)'});
model.batch('p2').set('sweeptype', 'sparse');
model.batch('p2').set('probesel', 'all');
model.batch('p2').set('probes', {});
model.batch('p2').set('plot', 'off');
model.batch('p2').set('err', 'on');
model.batch('p2').attach('std2');
model.batch('p2').set('control', 'param');

model.sol.create('sol32');
model.sol('sol32').study('std2');
model.sol('sol32').label('Parametric Solutions 2');

model.batch('p2').feature('so1').set('psol', 'sol32');
model.batch('p2').run('compute');

model.result.dataset.create('cln2', 'CutLine3D');
model.result.dataset('cln2').label('Axis 1');
model.result.dataset('cln2').set('data', 'none');
model.result.dataset('cln2').set('genpoints', {'comp1.srotf.raxi1.r1x' 'comp1.srotf.raxi1.r1y' 'comp1.srotf.raxi1.r1z'; 'comp1.srotf.raxi1.r2x' 'comp1.srotf.raxi1.r2y' 'comp1.srotf.raxi1.r2z'});
model.result.dataset('cln2').set('bounded', false);
model.result.dataset('cln2').set('spacevars', {'cln1x'});
model.result.dataset('cln2').set('tangent', {'cln1tx' 'cln1ty' 'cln1tz'});
model.result.dataset('cln2').set('data', 'dset6');
model.result.create('pg4', 'PlotGroup3D');
model.result('pg4').label('Mode Shape (srotf)');
model.result('pg4').set('data', 'dset6');
model.result('pg4').setIndex('looplevel', 1, 0);
model.result('pg4').setIndex('looplevel', 26, 1);
model.result('pg4').set('showlegends', 'off');
model.result('pg4').set('data', 'dset6');
model.result('pg4').setIndex('looplevel', 1, 0);
model.result('pg4').setIndex('looplevel', 26, 1);
model.result('pg4').set('defaultPlotID', 'modeShape');
model.result('pg4').feature.create('surf1', 'Surface');
model.result('pg4').feature('surf1').set('expr', 'srotf.disp');
model.result('pg4').feature('surf1').set('colortable', 'AuroraBorealis');
model.result('pg4').feature('surf1').set('smooth', 'internal');
model.result('pg4').feature('surf1').set('data', 'parent');
model.result('pg4').feature('surf1').feature.create('def1', 'Deform');
model.result('pg4').feature('surf1').feature('def1').label('Deformation');
model.result.create('pg5', 'PlotGroup3D');
model.result('pg5').label('Whirl (srotf)');
model.result('pg5').set('data', 'cln2');
model.result('pg5').setIndex('looplevel', 1, 0);
model.result('pg5').setIndex('looplevel', 26, 1);
model.result('pg5').set('showlegends', 'off');
model.result('pg5').set('data', 'cln2');
model.result('pg5').setIndex('looplevel', 1, 0);
model.result('pg5').setIndex('looplevel', 26, 1);
model.result('pg5').set('defaultPlotID', 'whirl');
model.result('pg5').feature.create('wp1', 'Whirl');
model.result('pg5').feature('wp1').set('nrings', 10);
model.result('pg5').feature('wp1').set('colortable', 'TrafficLight');
model.result('pg5').feature('wp1').set('smooth', 'internal');
model.result('pg5').feature('wp1').set('data', 'parent');
model.result.evaluationGroup.create('std2EvgFrq', 'EvaluationGroup');
model.result.evaluationGroup('std2EvgFrq').set('defaultPlotID', 'eigenfrequenciesTable_srotf');
model.result.evaluationGroup('std2EvgFrq').set('data', 'dset6');
model.result.evaluationGroup('std2EvgFrq').label('Eigenfrequencies (Study: SRFF)');
model.result.evaluationGroup('std2EvgFrq').create('gev1', 'EvalGlobal');
model.result.evaluationGroup('std2EvgFrq').feature('gev1').setIndex('expr', '2*pi*freq', 0);
model.result.evaluationGroup('std2EvgFrq').feature('gev1').setIndex('unit', 'rad/s', 0);
model.result.evaluationGroup('std2EvgFrq').feature('gev1').setIndex('descr', 'Angular frequency', 0);
model.result.evaluationGroup('std2EvgFrq').feature('gev1').setIndex('expr', 'imag(freq)/abs(freq)', 1);
model.result.evaluationGroup('std2EvgFrq').feature('gev1').setIndex('unit', '1', 1);
model.result.evaluationGroup('std2EvgFrq').feature('gev1').setIndex('descr', 'Damping ratio', 1);
model.result.evaluationGroup('std2EvgFrq').feature('gev1').setIndex('expr', 'abs(freq)/imag(freq)/2', 2);
model.result.evaluationGroup('std2EvgFrq').feature('gev1').setIndex('unit', '1', 2);
model.result.evaluationGroup('std2EvgFrq').feature('gev1').setIndex('descr', 'Quality factor', 2);
model.result.evaluationGroup('std2EvgFrq').run;
model.result('pg4').run;
model.result('pg4').set('looplevel', [8 26]);
model.result('pg4').run;
model.result('pg5').run;
model.result('pg5').set('looplevel', [8 26]);
model.result('pg5').run;
model.result.create('pg6', 'PlotGroup1D');
model.result('pg6').set('data', 'dset6');
model.result('pg6').create('glob1', 'Global');
model.result('pg6').feature('glob1').set('unit', {''});
model.result('pg6').feature('glob1').set('expr', {'srotf.omega'});
model.result('pg6').feature('glob1').set('descr', {'Angular frequency'});
model.result('pg6').feature('glob1').set('xdata', 'expr');
model.result('pg6').feature('glob1').set('xdataexpr', 'srotf.Ovg');
model.result('pg6').feature('glob1').set('xdataunit', 'rad/s');
model.result('pg6').feature('glob1').label('Whirl Frequency');
model.result('pg6').feature('glob1').set('linestyle', 'dashed');
model.result('pg6').feature('glob1').set('linecolor', 'blue');
model.result('pg6').feature('glob1').set('linewidth', 3);
model.result('pg6').feature('glob1').set('legend', false);
model.result('pg6').feature('glob1').set('xdatasolnumtype', 'outer');
model.result('pg6').feature('glob1').create('gmrk1', 'GraphMarker');
model.result('pg6').feature('glob1').feature('gmrk1').set('displaymode', 'intersection');
model.result('pg6').feature('glob1').feature('gmrk1').set('intersectionline', 'identity');
model.result('pg6').feature('glob1').feature('gmrk1').set('precision', 4);
model.result('pg6').feature('glob1').feature('gmrk1').set('labelprefix', '');
model.result('pg6').feature('glob1').feature('gmrk1').set('pointradius', 4);
model.result('pg6').feature('glob1').feature('gmrk1').set('color', 'custom');
model.result('pg6').feature('glob1').feature('gmrk1').set('customcolor', [0 0.3333333432674408 0.5882353186607361]);
model.result('pg6').feature('glob1').feature('gmrk1').set('anchorpoint', 'uppermiddle');
model.result('pg6').feature('glob1').create('col1', 'Color');
model.result('pg6').feature('glob1').feature('col1').set('expr', {'srotf.i_whirl'});
model.result('pg6').feature('glob1').feature('col1').set('colortable', 'TrafficLight');
model.result('pg6').set('defaultPlotID', 'campbell');
model.result('pg6').label('Campbell Plot (srotf)');
model.result('pg6').create('glob2', 'Global');
model.result('pg6').feature('glob2').set('expr', {'if(srotf.Ovg<=1.4*srotf.omega,srotf.Ovg,NaN)'});
model.result('pg6').feature('glob2').set('data', 'dset6');
model.result('pg6').feature('glob2').set('xdata', 'expr');
model.result('pg6').feature('glob2').set('xdataexpr', 'srotf.Ovg');
model.result('pg6').feature('glob2').set('xdataunit', 'rad/s');
model.result('pg6').feature('glob2').set('linecolor', 'red');
model.result('pg6').feature('glob2').set('linewidth', 3);
model.result('pg6').feature('glob2').label('omega=Omega');
model.result('pg6').feature('glob2').set('xdatasolnumtype', 'outer');
model.result('pg6').feature('glob2').set('solutionparams', 'manual');
model.result('pg6').feature('glob2').setIndex('looplevelinput', 'last', 0);
model.result('pg6').feature('glob2').set('legend', true);
model.result('pg6').feature('glob2').set('legendmethod', 'manual');
model.result('pg6').feature('glob2').setIndex('legends', '\omega=\Omega', 0);
model.result('pg6').set('ylabel', 'Angular frequency (rad/s)');
model.result('pg6').set('titletype', 'manual');
model.result('pg6').set('title', 'Campbell plot');
model.result('pg6').label('Campbell Plot (srotf)');
model.result('pg6').run;

model.study('std3').label('Study: Beam Rotor');
model.study('std3').create('param', 'Parametric');
model.study('std3').feature('param').setIndex('pname', 'd_1_2', 0);
model.study('std3').feature('param').setIndex('plistarr', '', 0);
model.study('std3').feature('param').setIndex('punit', 'm', 0);
model.study('std3').feature('param').setIndex('pname', 'd_1_2', 0);
model.study('std3').feature('param').setIndex('plistarr', '', 0);
model.study('std3').feature('param').setIndex('punit', 'm', 0);
model.study('std3').feature('param').setIndex('pname', 'fr', 0);
model.study('std3').feature('param').setIndex('plistarr', 'range(0,2000,50000)', 0);
model.study('std3').feature('param').setIndex('punit', 'rpm', 0);
model.study('std3').feature('eig').set('useadvanceddisable', true);
model.study('std3').feature('eig').set('disabledphysics', {'rotsld' 'srotf'});
model.study('std3').feature('eig').set('useadvanceddisable', false);

model.sol.create('sol59');
model.sol('sol59').study('std3');
model.sol('sol59').create('st1', 'StudyStep');
model.sol('sol59').feature('st1').set('study', 'std3');
model.sol('sol59').feature('st1').set('studystep', 'eig');
model.sol('sol59').create('v1', 'Variables');
model.sol('sol59').feature('v1').feature('comp1_u3').set('scalemethod', 'manual');
model.sol('sol59').feature('v1').feature('comp1_u3').set('scaleval', '1e-2*0.7322738558763382');
model.sol('sol59').feature('v1').set('control', 'eig');
model.sol('sol59').create('e1', 'Eigenvalue');
model.sol('sol59').feature('e1').set('control', 'eig');
model.sol('sol59').attach('std3');

model.batch.create('p3', 'Parametric');
model.batch('p3').study('std3');
model.batch('p3').create('so1', 'Solutionseq');
model.batch('p3').feature('so1').set('seq', 'sol59');
model.batch('p3').feature('so1').set('store', 'on');
model.batch('p3').feature('so1').set('clear', 'on');
model.batch('p3').feature('so1').set('psol', 'none');
model.batch('p3').set('pname', {'fr'});
model.batch('p3').set('plistarr', {'range(0,2000,50000)'});
model.batch('p3').set('sweeptype', 'sparse');
model.batch('p3').set('probesel', 'all');
model.batch('p3').set('probes', {});
model.batch('p3').set('plot', 'off');
model.batch('p3').set('err', 'on');
model.batch('p3').attach('std3');
model.batch('p3').set('control', 'param');

model.sol.create('sol60');
model.sol('sol60').study('std3');
model.sol('sol60').label('Parametric Solutions 3');

model.batch('p3').feature('so1').set('psol', 'sol60');
model.batch('p3').run('compute');

model.result.create('pg7', 'PlotGroup3D');
model.result('pg7').set('data', 'dset8');
model.result('pg7').setIndex('looplevel', 1, 0);
model.result('pg7').setIndex('looplevel', 26, 1);
model.result('pg7').set('defaultPlotID', 'whirl');
model.result('pg7').label('Whirl (rotbm)');
model.result('pg7').create('wp1', 'Whirl');
model.result('pg7').feature('wp1').set('expr', {'u3' 'v3' 'w3'});
model.result('pg7').feature('wp1').set('descr', 'Displacement field');
model.result('pg7').feature('wp1').set('nplanes', '1');
model.result('pg7').feature('wp1').set('nrings', '10');
model.result('pg7').feature('wp1').set('colortable', 'TrafficLight');
model.result('pg7').feature('wp1').set('ringcolor', 'blue');
model.result('pg7').feature('wp1').selection.geom('geom1', 1);
model.result('pg7').feature('wp1').selection.set([10 24 41 58 70 84 101 118 135 147 161 178 195 212 224 238 255 267 276 290 307 319 328 342 359 371 385]);
model.result('pg7').feature('wp1').selection.inherit(false);
model.result.evaluationGroup.create('std3EvgFrq', 'EvaluationGroup');
model.result.evaluationGroup('std3EvgFrq').set('defaultPlotID', 'eigenfrequenciesTable_rotbm');
model.result.evaluationGroup('std3EvgFrq').set('data', 'dset8');
model.result.evaluationGroup('std3EvgFrq').label('Eigenfrequencies (Study: Beam Rotor)');
model.result.evaluationGroup('std3EvgFrq').create('gev1', 'EvalGlobal');
model.result.evaluationGroup('std3EvgFrq').feature('gev1').setIndex('expr', '2*pi*freq', 0);
model.result.evaluationGroup('std3EvgFrq').feature('gev1').setIndex('unit', 'rad/s', 0);
model.result.evaluationGroup('std3EvgFrq').feature('gev1').setIndex('descr', 'Angular frequency', 0);
model.result.evaluationGroup('std3EvgFrq').feature('gev1').setIndex('expr', 'imag(freq)/abs(freq)', 1);
model.result.evaluationGroup('std3EvgFrq').feature('gev1').setIndex('unit', '1', 1);
model.result.evaluationGroup('std3EvgFrq').feature('gev1').setIndex('descr', 'Damping ratio', 1);
model.result.evaluationGroup('std3EvgFrq').feature('gev1').setIndex('expr', 'abs(freq)/imag(freq)/2', 2);
model.result.evaluationGroup('std3EvgFrq').feature('gev1').setIndex('unit', '1', 2);
model.result.evaluationGroup('std3EvgFrq').feature('gev1').setIndex('descr', 'Quality factor', 2);
model.result.evaluationGroup('std3EvgFrq').run;
model.result('pg7').create('line1', 'Line');
model.result('pg7').feature('line1').set('expr', {'1'});
model.result('pg7').feature('line1').set('linetype', 'tube');
model.result('pg7').feature('line1').set('radiusexpr', {'rotbm.re '});
model.result('pg7').feature('line1').set('tuberadiusscaleactive', true);
model.result('pg7').feature('line1').set('tuberadiusscale', 1);
model.result('pg7').feature('line1').set('tubeendcaps', false);
model.result('pg7').feature('line1').set('coloring', 'uniform');
model.result('pg7').feature('line1').set('color', 'custom');
model.result('pg7').feature('line1').set('customcolor', [0.9803921580314636 0.7843137383460999 0.7058823704719543]);
model.result('pg7').feature('line1').set('threshold', 'manual');
model.result('pg7').feature('line1').set('thresholdvalue', 0.2);
model.result('pg7').feature('line1').set('titletype', 'none');
model.result('pg7').feature('line1').label('Rotor');
model.result('pg7').feature('line1').create('def', 'Deform');
model.result('pg7').feature('line1').feature('def').set('scaleactive', true);
model.result('pg7').feature('line1').feature('def').set('scale', '1');
model.result('pg7').feature('line1').feature('def').set('expr', {'-rotbm.De_max*rotbm.e30x ' '-rotbm.De_max*rotbm.e30y ' '-rotbm.De_max*rotbm.e30z '});
model.result('pg7').create('pttraj1', 'PointTrajectories');
model.result('pg7').feature('pttraj1').set('plotdata', 'points');
model.result('pg7').feature('pttraj1').selection.geom('geom1', 0);
model.result('pg7').feature('pttraj1').selection.set([42]);
model.result('pg7').feature('pttraj1').selection.inherit(false);
model.result('pg7').feature('pttraj1').set('linetype', 'none');
model.result('pg7').feature('pttraj1').set('pointtype', 'arrow');
model.result('pg7').feature('pttraj1').set('expr', {'X-1.0*rotbm.re*rotbm.jrb1.e3gx ' 'Y-1.0*rotbm.re*rotbm.jrb1.e3gy ' 'Z-1.0*rotbm.re*rotbm.jrb1.e3gz '});
model.result('pg7').feature('pttraj1').set('arrowexpr', {'rotbm.re*rotbm.jrb1.e3gx ' 'rotbm.re*rotbm.jrb1.e3gy ' 'rotbm.re*rotbm.jrb1.e3gz '});
model.result('pg7').feature('pttraj1').set('arrowtype', 'arrowhead');
model.result('pg7').feature('pttraj1').set('arrowbase', 'head');
model.result('pg7').feature('pttraj1').set('arrowscale', '10');
model.result('pg7').feature('pttraj1').set('arrowscaleactive', true);
model.result('pg7').feature('pttraj1').set('pointcolor', 'custom');
model.result('pg7').feature('pttraj1').set('custompointcolor', [0.5882353186607361 0.8627451062202454 0.5882353186607361]);
model.result('pg7').feature('pttraj1').set('titletype', 'none');
model.result('pg7').feature('pttraj1').label('Journal Bearing 1');
model.result('pg7').feature('pttraj1').create('def', 'Deform');
model.result('pg7').feature('pttraj1').feature('def').set('scaleactive', true);
model.result('pg7').feature('pttraj1').feature('def').set('scale', '1');
model.result('pg7').feature('pttraj1').feature('def').set('expr', {'-rotbm.De_max*rotbm.e30x ' '-rotbm.De_max*rotbm.e30y ' '-rotbm.De_max*rotbm.e30z '});
model.result('pg7').create('pttraj2', 'PointTrajectories');
model.result('pg7').feature('pttraj2').set('plotdata', 'points');
model.result('pg7').feature('pttraj2').selection.geom('geom1', 0);
model.result('pg7').feature('pttraj2').selection.set([117]);
model.result('pg7').feature('pttraj2').selection.inherit(false);
model.result('pg7').feature('pttraj2').set('linetype', 'none');
model.result('pg7').feature('pttraj2').set('pointtype', 'arrow');
model.result('pg7').feature('pttraj2').set('expr', {'X-1.0*rotbm.re*rotbm.jrb2.e3gx ' 'Y-1.0*rotbm.re*rotbm.jrb2.e3gy ' 'Z-1.0*rotbm.re*rotbm.jrb2.e3gz '});
model.result('pg7').feature('pttraj2').set('arrowexpr', {'rotbm.re*rotbm.jrb2.e3gx ' 'rotbm.re*rotbm.jrb2.e3gy ' 'rotbm.re*rotbm.jrb2.e3gz '});
model.result('pg7').feature('pttraj2').set('arrowtype', 'arrowhead');
model.result('pg7').feature('pttraj2').set('arrowbase', 'head');
model.result('pg7').feature('pttraj2').set('arrowscale', '10');
model.result('pg7').feature('pttraj2').set('arrowscaleactive', true);
model.result('pg7').feature('pttraj2').set('pointcolor', 'custom');
model.result('pg7').feature('pttraj2').set('custompointcolor', [0.5882353186607361 0.8627451062202454 0.5882353186607361]);
model.result('pg7').feature('pttraj2').set('titletype', 'none');
model.result('pg7').feature('pttraj2').label('Journal Bearing 2');
model.result('pg7').feature('pttraj2').create('def', 'Deform');
model.result('pg7').feature('pttraj2').feature('def').set('scaleactive', true);
model.result('pg7').feature('pttraj2').feature('def').set('scale', '1');
model.result('pg7').feature('pttraj2').feature('def').set('expr', {'-rotbm.De_max*rotbm.e30x ' '-rotbm.De_max*rotbm.e30y ' '-rotbm.De_max*rotbm.e30z '});
model.result('pg7').create('pttraj3', 'PointTrajectories');
model.result('pg7').feature('pttraj3').set('plotdata', 'points');
model.result('pg7').feature('pttraj3').selection.geom('geom1', 0);
model.result('pg7').feature('pttraj3').selection.set([196]);
model.result('pg7').feature('pttraj3').selection.inherit(false);
model.result('pg7').feature('pttraj3').set('linetype', 'none');
model.result('pg7').feature('pttraj3').set('pointtype', 'arrow');
model.result('pg7').feature('pttraj3').set('expr', {'X-1.0*rotbm.re*rotbm.jrb3.e3gx ' 'Y-1.0*rotbm.re*rotbm.jrb3.e3gy ' 'Z-1.0*rotbm.re*rotbm.jrb3.e3gz '});
model.result('pg7').feature('pttraj3').set('arrowexpr', {'rotbm.re*rotbm.jrb3.e3gx ' 'rotbm.re*rotbm.jrb3.e3gy ' 'rotbm.re*rotbm.jrb3.e3gz '});
model.result('pg7').feature('pttraj3').set('arrowtype', 'arrowhead');
model.result('pg7').feature('pttraj3').set('arrowbase', 'head');
model.result('pg7').feature('pttraj3').set('arrowscale', '10');
model.result('pg7').feature('pttraj3').set('arrowscaleactive', true);
model.result('pg7').feature('pttraj3').set('pointcolor', 'custom');
model.result('pg7').feature('pttraj3').set('custompointcolor', [0.5882353186607361 0.8627451062202454 0.5882353186607361]);
model.result('pg7').feature('pttraj3').set('titletype', 'none');
model.result('pg7').feature('pttraj3').label('Journal Bearing 3');
model.result('pg7').feature('pttraj3').create('def', 'Deform');
model.result('pg7').feature('pttraj3').feature('def').set('scaleactive', true);
model.result('pg7').feature('pttraj3').feature('def').set('scale', '1');
model.result('pg7').feature('pttraj3').feature('def').set('expr', {'-rotbm.De_max*rotbm.e30x ' '-rotbm.De_max*rotbm.e30y ' '-rotbm.De_max*rotbm.e30z '});
model.result('pg7').run;
model.result.create('pg8', 'PlotGroup1D');
model.result('pg8').set('data', 'dset8');
model.result('pg8').create('glob1', 'Global');
model.result('pg8').feature('glob1').set('unit', {''});
model.result('pg8').feature('glob1').set('expr', {'rotbm.omegaf'});
model.result('pg8').feature('glob1').set('descr', {'Forward angular frequency'});
model.result('pg8').feature('glob1').set('xdata', 'expr');
model.result('pg8').feature('glob1').set('xdataexpr', 'rotbm.Ovg');
model.result('pg8').feature('glob1').set('xdataunit', 'rad/s');
model.result('pg8').feature('glob1').label('Forward Whirl Mode');
model.result('pg8').feature('glob1').set('linestyle', 'dashed');
model.result('pg8').feature('glob1').set('linecolor', 'blue');
model.result('pg8').feature('glob1').set('linewidth', 3);
model.result('pg8').feature('glob1').set('legend', false);
model.result('pg8').feature('glob1').set('xdatasolnumtype', 'outer');
model.result('pg8').feature('glob1').create('gmrk1', 'GraphMarker');
model.result('pg8').feature('glob1').feature('gmrk1').set('displaymode', 'intersection');
model.result('pg8').feature('glob1').feature('gmrk1').set('intersectionline', 'identity');
model.result('pg8').feature('glob1').feature('gmrk1').set('precision', 4);
model.result('pg8').feature('glob1').feature('gmrk1').set('labelprefix', 'f: ');
model.result('pg8').feature('glob1').feature('gmrk1').set('pointradius', 4);
model.result('pg8').feature('glob1').feature('gmrk1').set('color', 'custom');
model.result('pg8').feature('glob1').feature('gmrk1').set('customcolor', [1 0.501960813999176 0.250980406999588]);
model.result('pg8').feature('glob1').feature('gmrk1').set('anchorpoint', 'lowermiddle');
model.result('pg8').set('defaultPlotID', 'campbell');
model.result('pg8').label('Campbell Plot (rotbm)');
model.result('pg8').create('glob2', 'Global');
model.result('pg8').feature('glob2').set('expr', {'rotbm.omegab'});
model.result('pg8').feature('glob2').set('xdata', 'expr');
model.result('pg8').feature('glob2').set('xdataexpr', 'rotbm.Ovg');
model.result('pg8').feature('glob2').set('xdataunit', 'rad/s');
model.result('pg8').feature('glob2').set('linestyle', 'dotted');
model.result('pg8').feature('glob2').set('linecolor', 'blue');
model.result('pg8').feature('glob2').set('linewidth', 3);
model.result('pg8').feature('glob2').set('legend', false);
model.result('pg8').feature('glob2').label('Backward Whirl Mode');
model.result('pg8').feature('glob2').set('xdatasolnumtype', 'outer');
model.result('pg8').feature('glob2').create('gmrk1', 'GraphMarker');
model.result('pg8').feature('glob2').feature('gmrk1').set('displaymode', 'intersection');
model.result('pg8').feature('glob2').feature('gmrk1').set('intersectionline', 'identity');
model.result('pg8').feature('glob2').feature('gmrk1').set('precision', 4);
model.result('pg8').feature('glob2').feature('gmrk1').set('labelprefix', 'b: ');
model.result('pg8').feature('glob2').feature('gmrk1').set('pointradius', 4);
model.result('pg8').feature('glob2').feature('gmrk1').set('color', 'custom');
model.result('pg8').feature('glob2').feature('gmrk1').set('customcolor', [0.7490196228027344 0.1411764770746231 0.3686274588108063]);
model.result('pg8').feature('glob2').feature('gmrk1').set('anchorpoint', 'uppermiddle');
model.result('pg8').create('glob3', 'Global');
model.result('pg8').feature('glob3').set('expr', {'rotbm.omegan'});
model.result('pg8').feature('glob3').set('xdata', 'expr');
model.result('pg8').feature('glob3').set('xdataexpr', 'rotbm.Ovg');
model.result('pg8').feature('glob3').set('xdataunit', 'rad/s');
model.result('pg8').feature('glob3').set('linecolor', 'blue');
model.result('pg8').feature('glob3').set('linewidth', 3);
model.result('pg8').feature('glob3').set('legend', false);
model.result('pg8').feature('glob3').label('Planar or Torsional Mode');
model.result('pg8').feature('glob3').set('xdatasolnumtype', 'outer');
model.result('pg8').feature('glob3').create('gmrk1', 'GraphMarker');
model.result('pg8').feature('glob3').feature('gmrk1').set('displaymode', 'intersection');
model.result('pg8').feature('glob3').feature('gmrk1').set('intersectionline', 'identity');
model.result('pg8').feature('glob3').feature('gmrk1').set('precision', 4);
model.result('pg8').feature('glob3').feature('gmrk1').set('labelprefix', 't,p: ');
model.result('pg8').feature('glob3').feature('gmrk1').set('pointradius', 4);
model.result('pg8').feature('glob3').feature('gmrk1').set('color', 'custom');
model.result('pg8').feature('glob3').feature('gmrk1').set('customcolor', [0.03529411926865578 0.4627451002597809 0.03529411926865578]);
model.result('pg8').feature('glob3').feature('gmrk1').set('anchorpoint', 'uppermiddle');
model.result('pg8').create('glob4', 'Global');
model.result('pg8').feature('glob4').set('expr', {'if(rotbm.Ovg<=1.4*rotbm.omega,rotbm.Ovg,NaN)'});
model.result('pg8').feature('glob4').set('data', 'dset8');
model.result('pg8').feature('glob4').set('xdata', 'expr');
model.result('pg8').feature('glob4').set('xdataexpr', 'rotbm.Ovg');
model.result('pg8').feature('glob4').set('xdataunit', 'rad/s');
model.result('pg8').feature('glob4').set('linecolor', 'red');
model.result('pg8').feature('glob4').set('linewidth', 3);
model.result('pg8').feature('glob4').label('omega=Omega');
model.result('pg8').feature('glob4').set('xdatasolnumtype', 'outer');
model.result('pg8').feature('glob4').set('solutionparams', 'manual');
model.result('pg8').feature('glob4').setIndex('looplevelinput', 'last', 0);
model.result('pg8').feature('glob4').set('legend', true);
model.result('pg8').feature('glob4').set('legendmethod', 'manual');
model.result('pg8').feature('glob4').setIndex('legends', '\omega=\Omega', 0);
model.result('pg8').set('ylabel', 'Angular frequency (rad/s)');
model.result('pg8').set('titletype', 'manual');
model.result('pg8').set('title', 'Campbell plot');
model.result('pg8').label('Campbell Plot (rotbm)');
model.result('pg8').run;
model.result('pg8').set('legendpos', 'upperleft');

model.title('Comparison of Campbell Plots Using Different Rotor Interfaces');

model.description('Different types of elements can be used for modeling a rotor, depending on the level of complexity and the type of the system being modeled. The modeling steps and representation of the results will vary with the type of idealization. In this tutorial model, an eigenfrequency analysis is performed on a stepped rotor, using three different physics interfaces for rotordynamics: Solid Rotor; Solid Rotor, Fixed Frame; and Beam Rotor. The resulting Campbell plots from these interfaces are compared with each other. The model also helps in understanding the different steps involved when using each interface.');

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
model.sol('sol21').clearSolutionData;
model.sol('sol22').clearSolutionData;
model.sol('sol23').clearSolutionData;
model.sol('sol24').clearSolutionData;
model.sol('sol25').clearSolutionData;
model.sol('sol26').clearSolutionData;
model.sol('sol27').clearSolutionData;
model.sol('sol28').clearSolutionData;
model.sol('sol29').clearSolutionData;
model.sol('sol30').clearSolutionData;
model.sol('sol31').clearSolutionData;
model.sol('sol32').clearSolutionData;
model.sol('sol33').clearSolutionData;
model.sol('sol34').clearSolutionData;
model.sol('sol35').clearSolutionData;
model.sol('sol36').clearSolutionData;
model.sol('sol37').clearSolutionData;
model.sol('sol38').clearSolutionData;
model.sol('sol39').clearSolutionData;
model.sol('sol40').clearSolutionData;
model.sol('sol41').clearSolutionData;
model.sol('sol42').clearSolutionData;
model.sol('sol43').clearSolutionData;
model.sol('sol44').clearSolutionData;
model.sol('sol45').clearSolutionData;
model.sol('sol46').clearSolutionData;
model.sol('sol47').clearSolutionData;
model.sol('sol48').clearSolutionData;
model.sol('sol49').clearSolutionData;
model.sol('sol50').clearSolutionData;
model.sol('sol51').clearSolutionData;
model.sol('sol52').clearSolutionData;
model.sol('sol53').clearSolutionData;
model.sol('sol54').clearSolutionData;
model.sol('sol55').clearSolutionData;
model.sol('sol56').clearSolutionData;
model.sol('sol57').clearSolutionData;
model.sol('sol58').clearSolutionData;
model.sol('sol59').clearSolutionData;
model.sol('sol60').clearSolutionData;
model.sol('sol61').clearSolutionData;
model.sol('sol62').clearSolutionData;
model.sol('sol63').clearSolutionData;
model.sol('sol64').clearSolutionData;
model.sol('sol65').clearSolutionData;
model.sol('sol66').clearSolutionData;
model.sol('sol67').clearSolutionData;
model.sol('sol68').clearSolutionData;
model.sol('sol69').clearSolutionData;
model.sol('sol70').clearSolutionData;
model.sol('sol71').clearSolutionData;
model.sol('sol72').clearSolutionData;
model.sol('sol73').clearSolutionData;
model.sol('sol74').clearSolutionData;
model.sol('sol75').clearSolutionData;
model.sol('sol76').clearSolutionData;
model.sol('sol77').clearSolutionData;
model.sol('sol78').clearSolutionData;
model.sol('sol79').clearSolutionData;
model.sol('sol80').clearSolutionData;
model.sol('sol81').clearSolutionData;
model.sol('sol82').clearSolutionData;
model.sol('sol83').clearSolutionData;
model.sol('sol84').clearSolutionData;
model.sol('sol85').clearSolutionData;
model.sol('sol86').clearSolutionData;

model.label('campbell_plot_comparison.mph');

model.modelNode.label('Components');

out = model;
