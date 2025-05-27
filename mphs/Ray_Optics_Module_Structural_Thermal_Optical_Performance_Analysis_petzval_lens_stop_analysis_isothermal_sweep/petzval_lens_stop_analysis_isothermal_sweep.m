function out = model
%
% petzval_lens_stop_analysis_isothermal_sweep.m
%
% Model exported on May 26 2025, 21:32 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/Ray_Optics_Module/Structural_Thermal_Optical_Performance_Analysis');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 3);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.physics.create('gop', 'GeometricalOptics', 'geom1');
model.physics('gop').model('comp1');
model.physics.create('solid', 'SolidMechanics', 'geom1');
model.physics('solid').model('comp1');

model.study.create('std1');

model.geom('geom1').label('Petzval Lens Stop Analysis Geometry Sequence');
model.geom('geom1').insertFile('petzval_lens_stop_analysis_geom_sequence.mph', 'geom1');
model.geom('geom1').run('fin');

model.view('view1').camera.set('projection', 'orthographic');
model.view('view1').hideObjects.create('hide1');
model.view('view1').hideObjects('hide1').init(2);
model.view('view1').hideObjects('hide1').add('fin', [19]);
model.view('view1').hideObjects('hide1').add('fin', [32]);
model.view('view1').hideObjects('hide1').add('fin', [37]);
model.view('view1').hideObjects('hide1').add('fin', [55]);
model.view('view1').hideObjects('hide1').add('fin', [60]);
model.view('view1').hideObjects('hide1').add('fin', [68]);
model.view('view1').hideObjects('hide1').add('fin', [73]);
model.view('view1').hideObjects('hide1').add('fin', [84]);
model.view('view1').hideObjects('hide1').add('fin', [90]);

model.param.label('Lens Prescription');
model.param.create('par2');
model.param('par2').label('Material Properties');

% To import content from file, use:
% model.param('par2').loadFile('FILENAME');
model.param('par2').set('E_N_BK7', '82[GPa]', 'Young''s modulus, Schott N-BK7');
model.param('par2').set('nu_N_BK7', '0.206', 'Poisson''s ratio, Schott N-BK7');
model.param('par2').set('rho_N_BK7', '2.51[g/cm^3]', 'Density, Schott N-BK7');
model.param('par2').set('alpha1_N_BK7', '7.1E-06[1/K]', 'CTE -30/70[degC], Schott N-BK7');
model.param('par2').set('alpha2_N_BK7', '8.3E-06[1/K]', 'CTE 20/300[degC], Schott N-BK7');
model.param('par2').set('Cp_N_BK7', '0.858[J/(g*K)]', 'Heat capacity, Schott N-BK7');
model.param('par2').set('k_N_BK7', '1.114[W/(m*K)]', 'Thermal conductivity, Schott N-BK7');
model.param('par2').set('E_S_BAH32', '90.4[GPa]', 'Young''s modulus, Ohara S-BAH32');
model.param('par2').set('nu_S_BAH32', '0.260', 'Poisson''s ratio, Ohara S-BAH32');
model.param('par2').set('rho_S_BAH32', '3.26[g/cm^3]', 'Density, Ohara S-BAH32');
model.param('par2').set('alpha1_S_BAH32', '6.9E-06[1/K]', 'CTE -30/70[degC], Ohara S-BAH32');
model.param('par2').set('alpha2_S_BAH32', '7.8E-06[1/K]', 'CTE 100/300[degC], Ohara S-BAH32');
model.param('par2').set('Cp_S_BAH32', '0.850[J/(g*K)]', 'Heat capacity, Ohara S-BAH32 [[GUESS]]');
model.param('par2').set('k_S_BAH32', '0.921[W/(m*K)]', 'Thermal conductivity, Ohara S-BAH32');
model.param('par2').set('E_N_SK2', '78[GPa]', 'Young''s modulus, Schott N-SK2');
model.param('par2').set('nu_N_SK2', '0.263', 'Poisson''s ratio, Schott N-SK2');
model.param('par2').set('rho_N_SK2', '3.55[g/cm^3]', 'Density, Schott N-SK2');
model.param('par2').set('alpha1_N_SK2', '6.0E-06[1/K]', 'CTE -30/70[degC], Schott N-SK2');
model.param('par2').set('alpha2_N_SK2', '7.1E-06[1/K]', 'CTE 20/300[degC], Schott N-SK2');
model.param('par2').set('Cp_N_SK2', '0.595[J/(g*K)]', 'Heat capacity, Schott N-SK2');
model.param('par2').set('k_N_SK2', '0.776[W/(m*K)]', 'Thermal conductivity, Schott N-SK2');
model.param('par2').set('E_N_SF5', '87[GPa]', 'Young''s modulus, Schott N-SF5');
model.param('par2').set('nu_N_SF5', '0.237', 'Poisson''s ratio, Schott N-SF5');
model.param('par2').set('rho_N_SF5', '2.86[g/cm^3]', 'Density, Schott N-SF5');
model.param('par2').set('alpha1_N_SF5', '7.94E-06[1/K]', 'CTE -30/70[degC], Schott N-SF5');
model.param('par2').set('alpha2_N_SF5', '9.21E-06[1/K]', 'CTE 20/300[degC], Schott N-SF5');
model.param('par2').set('Cp_N_SF5', '0.770[J/(g*K)]', 'Heat capacity, Schott N-SF5');
model.param('par2').set('k_N_SF5', '1.000[W/(m*K)]', 'Thermal conductivity, Schott N-SF5');
model.param('par2').set('E_RTV', '15[ksi]', 'Young''s modulus, RTV');
model.param('par2').set('nu_RTV', '0.485', 'Poisson''s ratio, RTV');
model.param('par2').set('rho_RTV', '1.25[g/cm^3]', 'Density, RTV');
model.param('par2').set('alpha_RTV', '200E-06[1/K]', 'CTE, RTV');
model.param('par2').set('Cp_RTV', '1.250[J/(g*K)]', 'Heat capacity, RTV');
model.param('par2').set('k_RTV', '0.250[W/(m*K)]', 'Thermal conductivity, RTV');
model.param.create('par3');
model.param('par3').label('General Properties');

% To import content from file, use:
% model.param('par3').loadFile('FILENAME');
model.param('par3').set('T0', '-25.0[degC]', 'Nominal camera temperature');
model.param('par3').set('theta_x1', '0.0[deg]', 'Field angle 1, x-component');
model.param('par3').set('theta_y1', '0.0[deg]', 'Field angle 1, y-component');
model.param('par3').set('theta_x2', '0.0[deg]', 'Field angle 2, x-component');
model.param('par3').set('theta_y2', '3.5[deg]', 'Field angle 2, y-component');
model.param('par3').set('theta_x3', '0.0[deg]', 'Field angle 3, x-component');
model.param('par3').set('theta_y3', '7.0[deg]', 'Field angle 3, y-component');
model.param('par3').set('N_ring', '15', 'Number of hexapolar rings');
model.param('par3').set('P_nom', '41.5[mm]', 'Nominal entrance pupil diameter');
model.param('par3').set('vx1', 'tan(theta_x1)', 'Ray direction vector, field 1, x-component');
model.param('par3').set('vy1', 'tan(theta_y1)', 'Ray direction vector, field 1, y-component');
model.param('par3').set('vx2', 'tan(theta_x2)', 'Ray direction vector, field 2, x-component');
model.param('par3').set('vy2', 'tan(theta_y2)', 'Ray direction vector, field 2, y-component');
model.param('par3').set('vx3', 'tan(theta_x3)', 'Ray direction vector, field 3, x-component');
model.param('par3').set('vy3', 'tan(theta_y3)', 'Ray direction vector, field 3, y-component');
model.param('par3').set('vz', '1', 'Ray direction vector, z-component');
model.param('par3').set('z_stop', 'Tc_1+T_1+Tc_2+T_2', 'Stop z-coordinate');
model.param('par3').set('z_image', 'Tc_1+T_1+Tc_2+T_2+Tc_3+T_3+Tc_4+T_4+Tc_5+T_5+Tc_6+T_6', 'Image plane z-coordinate');
model.param('par3').set('P_1', '-1.142', 'Pupil shift constant 1');
model.param('par3').set('P_2', '-0.080', 'Pupil shift constant 2');
model.param('par3').set('P_fac1', 'P_1+P_2*sin(sqrt(theta_x1^2+theta_y1^2))', 'Pupil shift factor, field 1');
model.param('par3').set('P_fac2', 'P_1+P_2*sin(sqrt(theta_x2^2+theta_y2^2))', 'Pupil shift factor, field 2');
model.param('par3').set('P_fac3', 'P_1+P_2*sin(sqrt(theta_x3^2+theta_y3^2))', 'Pupil shift factor, field 3');
model.param('par3').set('dx1', '(dz+P_fac1*z_stop)*tan(theta_x1)', 'Pupil center, field 1, x-coordinate');
model.param('par3').set('dy1', '(dz+P_fac1*z_stop)*tan(theta_y1)', 'Pupil center, field 1, y-coordinate');
model.param('par3').set('dx2', '(dz+P_fac2*z_stop)*tan(theta_x2)', 'Pupil center, field 2, x-coordinate');
model.param('par3').set('dy2', '(dz+P_fac2*z_stop)*tan(theta_y2)', 'Pupil center, field 2, y-coordinate');
model.param('par3').set('dx3', '(dz+P_fac3*z_stop)*tan(theta_x3)', 'Pupil center, field 3, x-coordinate');
model.param('par3').set('dy3', '(dz+P_fac3*z_stop)*tan(theta_y3)', 'Pupil center, field 3, y-coordinate');
model.param('par3').set('dz', '-30[mm]', 'Pupil center, z-coordinate');
model.param('par3').set('alpha_B', '23.4e-6[1/K]', 'Nominal CTE of barrel');
model.param('par3').set('alpha_S_1', 'alpha1_N_BK7', 'CTE of lens in contact with support 1');
model.param('par3').set('alpha_S_2', 'alpha1_N_SK2', 'CTE of lens in contact with support 2');
model.param('par3').set('alpha_S_3', 'alpha1_N_SF5', 'CTE of lens in contact with support 3');
model.param('par3').set('tS_1_i', 'd0_1/2*(1-nu_RTV)*(alpha_B-alpha_S_1)/(alpha_RTV-alpha_B-nu_RTV*(alpha_S_1-alpha_B))', 'Thickness of support 1');
model.param('par3').set('tS_2_i', 'd0_4/2*(1-nu_RTV)*(alpha_B-alpha_S_2)/(alpha_RTV-alpha_B-nu_RTV*(alpha_S_2-alpha_B))', 'Thickness of support 2');
model.param('par3').set('tS_3_i', 'd0_6/2*(1-nu_RTV)*(alpha_B-alpha_S_3)/(alpha_RTV-alpha_B-nu_RTV*(alpha_S_3-alpha_B))', 'Thickness of support 3');
model.param.set('tS_1', 'tS_1_i');
model.param.set('tS_2', 'tS_2_i');
model.param.set('tS_3', 'tS_3_i');

model.selection.create('uni1', 'Union');
model.selection('uni1').model('comp1');

model.geom('geom1').run;

model.selection('uni1').label('Lens Barrels and Detector');
model.selection('uni1').set('input', {'geom1_pi11_uni1_dom' 'geom1_pi12_uni1_dom' 'geom1_pi13_uni1_dom' 'geom1_uni1_dom'});
model.selection.create('uni2', 'Union');
model.selection('uni2').model('comp1');
model.selection('uni2').label('Lenses and Supports');
model.selection('uni2').set('input', {'geom1_csel10_dom' 'geom1_sel1'});

model.cpl.create('aveop1', 'Average', 'geom1');
model.cpl('aveop1').set('axisym', true);
model.cpl('aveop1').selection.geom('geom1', 0);
model.cpl('aveop1').selection.set([57]);
model.cpl.duplicate('aveop2', 'aveop1');
model.cpl('aveop2').selection.set([181]);
model.cpl.duplicate('aveop3', 'aveop2');
model.cpl('aveop3').selection.set([183]);

model.mesh('mesh1').create('ftri1', 'FreeTri');
model.mesh('mesh1').feature('ftri1').selection.named('geom1_csel6_bnd');
model.mesh('mesh1').feature('ftri1').create('size1', 'Size');
model.mesh('mesh1').feature('ftri1').feature('size1').set('hauto', 1);
model.mesh('mesh1').create('ftet1', 'FreeTet');
model.mesh('mesh1').feature('ftet1').create('size1', 'Size');
model.mesh('mesh1').feature('ftet1').feature('size1').selection.geom('geom1', 3);
model.mesh('mesh1').feature('ftet1').feature('size1').selection.set([21]);
model.mesh('mesh1').feature('ftet1').feature('size1').set('hauto', 3);
model.mesh('mesh1').feature('ftet1').create('size2', 'Size');
model.mesh('mesh1').feature('ftet1').feature('size2').selection.geom('geom1', 3);
model.mesh('mesh1').feature('ftet1').feature('size2').selection.named('geom1_csel10_dom');
model.mesh('mesh1').feature('ftet1').feature('size2').set('custom', true);
model.mesh('mesh1').feature('ftet1').feature('size2').set('hminactive', true);
model.mesh('mesh1').feature('ftet1').feature('size2').set('hmin', '2[mm]');
model.mesh('mesh1').feature('size').set('hauto', 6);
model.mesh('mesh1').run;

model.physics('gop').selection.named('geom1_sel1');
model.physics('gop').prop('WavelengthDistribution').setIndex('WavelengthDistribution', 'PolychromaticWavelength', 0);
model.physics('gop').prop('MaximumSecondary').setIndex('MaximumSecondary', 0, 0);
model.physics('gop').prop('ExteriorUnmeshedProperties').setIndex('DispersionModel', 'AirEdlen1953', 0);
model.physics('gop').prop('ExteriorUnmeshedProperties').setIndex('Text', 'T0', 0);
model.physics('gop').feature('mp1').set('RefractiveIndexDomains', 'GetDispersionModelFromMaterial');
model.physics('gop').feature('mp1').setIndex('minput_temperature_src', 'fromCommonDef', 0);

model.common('cminpt').set('modified', {'temperature' 'T0'});

model.physics('gop').feature('matd1').set('ReleaseReflectedRays', 'Never');
model.physics('gop').create('wall1', 'Wall', 2);
model.physics('gop').feature('wall1').label('Obstructions');
model.physics('gop').feature('wall1').selection.named('geom1_csel7_bnd');
model.physics('gop').feature('wall1').set('WallCondition', 'Disappear');
model.physics('gop').create('wall2', 'Wall', 2);
model.physics('gop').feature('wall2').label('Stop');
model.physics('gop').feature('wall2').selection.named('geom1_csel8_bnd');
model.physics('gop').feature('wall2').set('WallCondition', 'Disappear');
model.physics('gop').create('wall3', 'Wall', 2);
model.physics('gop').feature('wall3').label('Image');
model.physics('gop').feature('wall3').selection.named('geom1_csel9_bnd');
model.physics('gop').create('relg1', 'ReleaseGrid', -1);
model.physics('gop').feature('relg1').set('GridType', 'Hexapolar');
model.physics('gop').feature('relg1').set('qcc', {'dx1' 'dy1' 'dz'});
model.physics('gop').feature('relg1').set('rcc', {'nix' 'niy' 'niz'});
model.physics('gop').feature('relg1').set('Rc', '20.75[mm]');
model.physics('gop').feature('relg1').setIndex('Ncr', 15, 0);
model.physics('gop').feature('relg1').set('L0', {'vx1' 'vy1' 'vz'});
model.physics('gop').feature('relg1').set('LDistributionFunction', 'ListOfValues');
model.physics('gop').feature('relg1').setIndex('lambda0vals', '475[nm] 550[nm] 625[nm]', 0);
model.physics('gop').feature.duplicate('relg2', 'relg1');
model.physics('gop').feature('relg2').set('qcc', {'dx2' 'dy2' 'dz'});
model.physics('gop').feature('relg2').set('L0', {'vx2' 'vy2' 'vz'});
model.physics('gop').feature.duplicate('relg3', 'relg2');
model.physics('gop').feature('relg3').set('qcc', {'dx3' 'dy3' 'dz'});
model.physics('gop').feature('relg3').set('L0', {'vx3' 'vy3' 'vz'});
model.physics('solid').prop('ShapeProperty').set('order_displacement', '3s');
model.physics('solid').feature('lemm1').create('te1', 'ThermalExpansion', 3);
model.physics('solid').create('fix1', 'Fixed', 2);
model.physics('solid').feature('fix1').selection.named('geom1_pi14_sel1');

model.material.create('mat1', 'Common', 'comp1');
model.material('mat1').propertyGroup.create('DispersionModelSellmeierStandard', 'Sellmeier');
model.material('mat1').propertyGroup.create('ThermoOpticDispersionModelSchott', 'Schott thermo-optic');
model.material('mat1').propertyGroup.create('Enu', 'Young''s modulus and Poisson''s ratio');
model.material('mat1').propertyGroup.create('InternalTransmittance10', ['Internal transmittance, 10' native2unicode(hex2dec({'00' 'a0'}), 'unicode') 'mm sample thickness']);
model.material('mat1').propertyGroup('InternalTransmittance10').func.create('int1', 'Interpolation');
model.material('mat1').propertyGroup.create('InternalTransmittance25', ['Internal transmittance, 25' native2unicode(hex2dec({'00' 'a0'}), 'unicode') 'mm sample thickness']);
model.material('mat1').propertyGroup('InternalTransmittance25').func.create('int1', 'Interpolation');
model.material('mat1').label('Schott N-BK7 Glass');
model.material('mat1').propertyGroup('def').set('density', '2.51[g/cm^3]');
model.material('mat1').propertyGroup('def').set('heatcapacity', '0.858[J/(g*K)]');
model.material('mat1').propertyGroup('def').set('thermalconductivity', {'1.114[W/(m*K)]' '0' '0' '0' '1.114[W/(m*K)]' '0' '0' '0' '1.114[W/(m*K)]'});
model.material('mat1').propertyGroup('def').set('thermalexpansioncoefficient', {'7.1E-6[1/K]' '0' '0' '0' '7.1E-6[1/K]' '0' '0' '0' '7.1E-6[1/K]'});
model.material('mat1').propertyGroup('DispersionModelSellmeierStandard').set('ODsma', {'1.03961212E+00' '2.31792344E-01' '1.01046945E+00' '6.00069867E-03' '2.00179144E-02' '1.03560653E+02'});
model.material('mat1').propertyGroup('DispersionModelSellmeierStandard').set('Trefsma', '22[degC]');
model.material('mat1').propertyGroup('DispersionModelSellmeierStandard').set('Prefsma', '1[atm]');
model.material('mat1').propertyGroup('DispersionModelSellmeierStandard').addInput('frequency');
model.material('mat1').propertyGroup('ThermoOpticDispersionModelSchott').set('TOsco', {'1.86E-6' '1.31E-8' '-1.37E-11' '4.34E-7' '6.27E-10' '0.17'});
model.material('mat1').propertyGroup('ThermoOpticDispersionModelSchott').set('Trefsco', '20[degC]');
model.material('mat1').propertyGroup('Enu').set('E', '82.0[GPa]');
model.material('mat1').propertyGroup('Enu').set('nu', '0.206');
model.material('mat1').propertyGroup('InternalTransmittance10').func('int1').set('funcname', 'taui10');
model.material('mat1').propertyGroup('InternalTransmittance10').func('int1').set('table', {'2500' '0.665';  ...
'2325' '0.793';  ...
'1970' '0.933';  ...
'1530' '0.992';  ...
'1060' '0.999';  ...
'700' '0.998';  ...
'660' '0.998';  ...
'620' '0.998';  ...
'580' '0.998';  ...
'546' '0.998';  ...
'500' '0.998';  ...
'460' '0.997';  ...
'436' '0.997';  ...
'420' '0.997';  ...
'405' '0.997';  ...
'400' '0.997';  ...
'390' '0.996';  ...
'380' '0.993';  ...
'370' '0.991';  ...
'365' '0.988';  ...
'350' '0.967';  ...
'334' '0.905';  ...
'320' '0.77';  ...
'310' '0.574';  ...
'300' '0.292';  ...
'290' '0.063'});
model.material('mat1').propertyGroup('InternalTransmittance10').func('int1').set('extrap', 'none');
model.material('mat1').propertyGroup('InternalTransmittance10').func('int1').set('fununit', {'1'});
model.material('mat1').propertyGroup('InternalTransmittance10').func('int1').set('argunit', {'nm'});
model.material('mat1').propertyGroup('InternalTransmittance10').set('taui10', 'taui10(c_const/freq)');
model.material('mat1').propertyGroup('InternalTransmittance10').addInput('frequency');
model.material('mat1').propertyGroup('InternalTransmittance25').func('int1').set('funcname', 'taui25');
model.material('mat1').propertyGroup('InternalTransmittance25').func('int1').set('table', {'2500' '0.36';  ...
'2325' '0.56';  ...
'1970' '0.84';  ...
'1530' '0.98';  ...
'1060' '0.997';  ...
'700' '0.996';  ...
'660' '0.994';  ...
'620' '0.994';  ...
'580' '0.995';  ...
'546' '0.996';  ...
'500' '0.994';  ...
'460' '0.993';  ...
'436' '0.992';  ...
'420' '0.993';  ...
'405' '0.993';  ...
'400' '0.992';  ...
'390' '0.989';  ...
'380' '0.983';  ...
'370' '0.977';  ...
'365' '0.971';  ...
'350' '0.92';  ...
'334' '0.78';  ...
'320' '0.52';  ...
'310' '0.25';  ...
'300' '0.05'});
model.material('mat1').propertyGroup('InternalTransmittance25').func('int1').set('extrap', 'none');
model.material('mat1').propertyGroup('InternalTransmittance25').func('int1').set('fununit', {'1'});
model.material('mat1').propertyGroup('InternalTransmittance25').func('int1').set('argunit', {'nm'});
model.material('mat1').propertyGroup('InternalTransmittance25').set('taui25', 'taui25(c_const/freq)');
model.material('mat1').propertyGroup('InternalTransmittance25').addInput('frequency');
model.material('mat1').set('family', 'plastic');
model.material.create('mat2', 'Common', 'comp1');
model.material('mat2').propertyGroup.create('DispersionModelSellmeierStandard', 'Sellmeier');
model.material('mat2').propertyGroup.create('ThermoOpticDispersionModelSchott', 'Schott thermo-optic');
model.material('mat2').propertyGroup.create('Enu', 'Young''s modulus and Poisson''s ratio');
model.material('mat2').propertyGroup.create('InternalTransmittance10', ['Internal transmittance, 10' native2unicode(hex2dec({'00' 'a0'}), 'unicode') 'mm sample thickness']);
model.material('mat2').propertyGroup('InternalTransmittance10').func.create('int1', 'Interpolation');
model.material('mat2').propertyGroup.create('InternalTransmittance25', ['Internal transmittance, 25' native2unicode(hex2dec({'00' 'a0'}), 'unicode') 'mm sample thickness']);
model.material('mat2').propertyGroup('InternalTransmittance25').func.create('int1', 'Interpolation');
model.material('mat2').label('Schott N-KZFS5 Glass');
model.material('mat2').propertyGroup('def').set('density', '3.04[g/cm^3]');
model.material('mat2').propertyGroup('def').set('heatcapacity', '0.73[J/(g*K)]');
model.material('mat2').propertyGroup('def').set('thermalconductivity', {'0.95[W/(m*K)]' '0' '0' '0' '0.95[W/(m*K)]' '0' '0' '0' '0.95[W/(m*K)]'});
model.material('mat2').propertyGroup('def').set('thermalexpansioncoefficient', {'6.38E-6[1/K]' '0' '0' '0' '6.38E-6[1/K]' '0' '0' '0' '6.38E-6[1/K]'});
model.material('mat2').propertyGroup('DispersionModelSellmeierStandard').set('ODsma', {'1.47460789E+00' '1.93584488E-01' '1.26589974E+00' '9.86143816E-03' '4.45477583E-02' '1.06436258E+02'});
model.material('mat2').propertyGroup('DispersionModelSellmeierStandard').set('Trefsma', '22[degC]');
model.material('mat2').propertyGroup('DispersionModelSellmeierStandard').set('Prefsma', '1[atm]');
model.material('mat2').propertyGroup('DispersionModelSellmeierStandard').addInput('frequency');
model.material('mat2').propertyGroup('ThermoOpticDispersionModelSchott').set('TOsco', {'4.54E-6' '1.19E-8' '2.93E-12' '6.89E-7' '8.6E-10' '0.23'});
model.material('mat2').propertyGroup('ThermoOpticDispersionModelSchott').set('Trefsco', '20[degC]');
model.material('mat2').propertyGroup('Enu').set('E', '89.0[GPa]');
model.material('mat2').propertyGroup('Enu').set('nu', '0.243');
model.material('mat2').propertyGroup('InternalTransmittance10').func('int1').set('funcname', 'taui10');
model.material('mat2').propertyGroup('InternalTransmittance10').func('int1').set('table', {'2500' '0.657';  ...
'2325' '0.826';  ...
'1970' '0.963';  ...
'1530' '0.988';  ...
'1060' '0.999';  ...
'700' '0.998';  ...
'660' '0.997';  ...
'620' '0.997';  ...
'580' '0.997';  ...
'546' '0.997';  ...
'500' '0.994';  ...
'460' '0.99';  ...
'436' '0.986';  ...
'420' '0.983';  ...
'405' '0.978';  ...
'400' '0.976';  ...
'390' '0.967';  ...
'380' '0.95';  ...
'370' '0.928';  ...
'365' '0.91';  ...
'350' '0.793';  ...
'334' '0.372';  ...
'320' '0.017'});
model.material('mat2').propertyGroup('InternalTransmittance10').func('int1').set('extrap', 'none');
model.material('mat2').propertyGroup('InternalTransmittance10').func('int1').set('fununit', {'1'});
model.material('mat2').propertyGroup('InternalTransmittance10').func('int1').set('argunit', {'nm'});
model.material('mat2').propertyGroup('InternalTransmittance10').set('taui10', 'taui10(c_const/freq)');
model.material('mat2').propertyGroup('InternalTransmittance10').addInput('frequency');
model.material('mat2').propertyGroup('InternalTransmittance25').func('int1').set('funcname', 'taui25');
model.material('mat2').propertyGroup('InternalTransmittance25').func('int1').set('table', {'2500' '0.35';  ...
'2325' '0.62';  ...
'1970' '0.91';  ...
'1530' '0.97';  ...
'1060' '0.998';  ...
'700' '0.994';  ...
'660' '0.992';  ...
'620' '0.992';  ...
'580' '0.993';  ...
'546' '0.992';  ...
'500' '0.985';  ...
'460' '0.974';  ...
'436' '0.965';  ...
'420' '0.958';  ...
'405' '0.946';  ...
'400' '0.94';  ...
'390' '0.92';  ...
'380' '0.88';  ...
'370' '0.83';  ...
'365' '0.79';  ...
'350' '0.56';  ...
'334' '0.08'});
model.material('mat2').propertyGroup('InternalTransmittance25').func('int1').set('extrap', 'none');
model.material('mat2').propertyGroup('InternalTransmittance25').func('int1').set('fununit', {'1'});
model.material('mat2').propertyGroup('InternalTransmittance25').func('int1').set('argunit', {'nm'});
model.material('mat2').propertyGroup('InternalTransmittance25').set('taui25', 'taui25(c_const/freq)');
model.material('mat2').propertyGroup('InternalTransmittance25').addInput('frequency');
model.material('mat2').set('family', 'plastic');
model.material.create('mat3', 'Common', 'comp1');
model.material('mat3').propertyGroup.create('DispersionModelSellmeierStandard', 'Sellmeier');
model.material('mat3').propertyGroup.create('ThermoOpticDispersionModelSchott', 'Schott thermo-optic');
model.material('mat3').propertyGroup.create('Enu', 'Young''s modulus and Poisson''s ratio');
model.material('mat3').propertyGroup.create('InternalTransmittance10', ['Internal transmittance, 10' native2unicode(hex2dec({'00' 'a0'}), 'unicode') 'mm sample thickness']);
model.material('mat3').propertyGroup('InternalTransmittance10').func.create('int1', 'Interpolation');
model.material('mat3').propertyGroup.create('InternalTransmittance25', ['Internal transmittance, 25' native2unicode(hex2dec({'00' 'a0'}), 'unicode') 'mm sample thickness']);
model.material('mat3').propertyGroup('InternalTransmittance25').func.create('int1', 'Interpolation');
model.material('mat3').label('Schott N-SK2 Glass');
model.material('mat3').propertyGroup('def').set('density', '3.55[g/cm^3]');
model.material('mat3').propertyGroup('def').set('heatcapacity', '0.595[J/(g*K)]');
model.material('mat3').propertyGroup('def').set('thermalconductivity', {'0.776[W/(m*K)]' '0' '0' '0' '0.776[W/(m*K)]' '0' '0' '0' '0.776[W/(m*K)]'});
model.material('mat3').propertyGroup('def').set('thermalexpansioncoefficient', {'6.0E-6[1/K]' '0' '0' '0' '6.0E-6[1/K]' '0' '0' '0' '6.0E-6[1/K]'});
model.material('mat3').propertyGroup('DispersionModelSellmeierStandard').set('ODsma', {'1.28189012E+00' '2.57738258E-01' '9.68186040E-01' '7.27191640E-03' '2.42823527E-02' '1.10377773E+02'});
model.material('mat3').propertyGroup('DispersionModelSellmeierStandard').set('Trefsma', '22[degC]');
model.material('mat3').propertyGroup('DispersionModelSellmeierStandard').set('Prefsma', '1[atm]');
model.material('mat3').propertyGroup('DispersionModelSellmeierStandard').addInput('frequency');
model.material('mat3').propertyGroup('ThermoOpticDispersionModelSchott').set('TOsco', {'3.8E-6' '1.41E-8' '2.28E-11' '6.44E-7' '8.03E-11' '0.108'});
model.material('mat3').propertyGroup('ThermoOpticDispersionModelSchott').set('Trefsco', '20[degC]');
model.material('mat3').propertyGroup('Enu').set('E', '78.0[GPa]');
model.material('mat3').propertyGroup('Enu').set('nu', '0.263');
model.material('mat3').propertyGroup('InternalTransmittance10').func('int1').set('funcname', 'taui10');
model.material('mat3').propertyGroup('InternalTransmittance10').func('int1').set('table', {'2500' '0.815';  ...
'2325' '0.896';  ...
'1970' '0.971';  ...
'1530' '0.995';  ...
'1060' '0.998';  ...
'700' '0.998';  ...
'660' '0.998';  ...
'620' '0.998';  ...
'580' '0.998';  ...
'546' '0.998';  ...
'500' '0.996';  ...
'460' '0.993';  ...
'436' '0.993';  ...
'420' '0.994';  ...
'405' '0.994';  ...
'400' '0.994';  ...
'390' '0.992';  ...
'380' '0.988';  ...
'370' '0.976';  ...
'365' '0.967';  ...
'350' '0.905';  ...
'334' '0.752';  ...
'320' '0.504';  ...
'310' '0.276';  ...
'300' '0.102';  ...
'290' '0.02'});
model.material('mat3').propertyGroup('InternalTransmittance10').func('int1').set('extrap', 'none');
model.material('mat3').propertyGroup('InternalTransmittance10').func('int1').set('fununit', {'1'});
model.material('mat3').propertyGroup('InternalTransmittance10').func('int1').set('argunit', {'nm'});
model.material('mat3').propertyGroup('InternalTransmittance10').set('taui10', 'taui10(c_const/freq)');
model.material('mat3').propertyGroup('InternalTransmittance10').addInput('frequency');
model.material('mat3').propertyGroup('InternalTransmittance25').func('int1').set('funcname', 'taui25');
model.material('mat3').propertyGroup('InternalTransmittance25').func('int1').set('table', {'2500' '0.6';  ...
'2325' '0.76';  ...
'1970' '0.93';  ...
'1530' '0.988';  ...
'1060' '0.995';  ...
'700' '0.995';  ...
'660' '0.994';  ...
'620' '0.994';  ...
'580' '0.995';  ...
'546' '0.995';  ...
'500' '0.99';  ...
'460' '0.983';  ...
'436' '0.982';  ...
'420' '0.984';  ...
'405' '0.985';  ...
'400' '0.984';  ...
'390' '0.979';  ...
'380' '0.97';  ...
'370' '0.94';  ...
'365' '0.92';  ...
'350' '0.78';  ...
'334' '0.49';  ...
'320' '0.18';  ...
'310' '0.04'});
model.material('mat3').propertyGroup('InternalTransmittance25').func('int1').set('extrap', 'none');
model.material('mat3').propertyGroup('InternalTransmittance25').func('int1').set('fununit', {'1'});
model.material('mat3').propertyGroup('InternalTransmittance25').func('int1').set('argunit', {'nm'});
model.material('mat3').propertyGroup('InternalTransmittance25').set('taui25', 'taui25(c_const/freq)');
model.material('mat3').propertyGroup('InternalTransmittance25').addInput('frequency');
model.material('mat3').set('family', 'plastic');
model.material.create('mat4', 'Common', 'comp1');
model.material('mat4').propertyGroup.create('DispersionModelSellmeierStandard', 'Sellmeier');
model.material('mat4').propertyGroup.create('ThermoOpticDispersionModelSchott', 'Schott thermo-optic');
model.material('mat4').propertyGroup.create('Enu', 'Young''s modulus and Poisson''s ratio');
model.material('mat4').propertyGroup.create('InternalTransmittance10', ['Internal transmittance, 10' native2unicode(hex2dec({'00' 'a0'}), 'unicode') 'mm sample thickness']);
model.material('mat4').propertyGroup('InternalTransmittance10').func.create('int1', 'Interpolation');
model.material('mat4').propertyGroup.create('InternalTransmittance25', ['Internal transmittance, 25' native2unicode(hex2dec({'00' 'a0'}), 'unicode') 'mm sample thickness']);
model.material('mat4').propertyGroup('InternalTransmittance25').func.create('int1', 'Interpolation');
model.material('mat4').label('Schott N-SF5 Glass');
model.material('mat4').propertyGroup('def').set('density', '2.86[g/cm^3]');
model.material('mat4').propertyGroup('def').set('heatcapacity', '0.77[J/(g*K)]');
model.material('mat4').propertyGroup('def').set('thermalconductivity', {'1.0[W/(m*K)]' '0' '0' '0' '1.0[W/(m*K)]' '0' '0' '0' '1.0[W/(m*K)]'});
model.material('mat4').propertyGroup('def').set('thermalexpansioncoefficient', {'7.94E-6[1/K]' '0' '0' '0' '7.94E-6[1/K]' '0' '0' '0' '7.94E-6[1/K]'});
model.material('mat4').propertyGroup('DispersionModelSellmeierStandard').set('ODsma', {'1.52481889E+00' '1.87085527E-01' '1.42729015E+00' '1.12547560E-02' '5.88995392E-02' '1.29141675E+02'});
model.material('mat4').propertyGroup('DispersionModelSellmeierStandard').set('Trefsma', '22[degC]');
model.material('mat4').propertyGroup('DispersionModelSellmeierStandard').set('Prefsma', '1[atm]');
model.material('mat4').propertyGroup('DispersionModelSellmeierStandard').addInput('frequency');
model.material('mat4').propertyGroup('ThermoOpticDispersionModelSchott').set('TOsco', {'-2.51E-7' '1.07E-8' '-2.4E-11' '7.85E-7' '1.15E-9' '0.278'});
model.material('mat4').propertyGroup('ThermoOpticDispersionModelSchott').set('Trefsco', '20[degC]');
model.material('mat4').propertyGroup('Enu').set('E', '87.0[GPa]');
model.material('mat4').propertyGroup('Enu').set('nu', '0.237');
model.material('mat4').propertyGroup('InternalTransmittance10').func('int1').set('funcname', 'taui10');
model.material('mat4').propertyGroup('InternalTransmittance10').func('int1').set('table', {'2500' '0.758';  ...
'2325' '0.831';  ...
'1970' '0.95';  ...
'1530' '0.99';  ...
'1060' '0.998';  ...
'700' '0.996';  ...
'660' '0.995';  ...
'620' '0.995';  ...
'580' '0.996';  ...
'546' '0.995';  ...
'500' '0.99';  ...
'460' '0.982';  ...
'436' '0.973';  ...
'420' '0.963';  ...
'405' '0.928';  ...
'400' '0.905';  ...
'390' '0.826';  ...
'380' '0.642';  ...
'370' '0.276';  ...
'365' '0.116'});
model.material('mat4').propertyGroup('InternalTransmittance10').func('int1').set('extrap', 'none');
model.material('mat4').propertyGroup('InternalTransmittance10').func('int1').set('fununit', {'1'});
model.material('mat4').propertyGroup('InternalTransmittance10').func('int1').set('argunit', {'nm'});
model.material('mat4').propertyGroup('InternalTransmittance10').set('taui10', 'taui10(c_const/freq)');
model.material('mat4').propertyGroup('InternalTransmittance10').addInput('frequency');
model.material('mat4').propertyGroup('InternalTransmittance25').func('int1').set('funcname', 'taui25');
model.material('mat4').propertyGroup('InternalTransmittance25').func('int1').set('table', {'2500' '0.5';  ...
'2325' '0.63';  ...
'1970' '0.88';  ...
'1530' '0.975';  ...
'1060' '0.994';  ...
'700' '0.989';  ...
'660' '0.987';  ...
'620' '0.988';  ...
'580' '0.991';  ...
'546' '0.988';  ...
'500' '0.976';  ...
'460' '0.956';  ...
'436' '0.935';  ...
'420' '0.91';  ...
'405' '0.83';  ...
'400' '0.78';  ...
'390' '0.62';  ...
'380' '0.33';  ...
'370' '0.04'});
model.material('mat4').propertyGroup('InternalTransmittance25').func('int1').set('extrap', 'none');
model.material('mat4').propertyGroup('InternalTransmittance25').func('int1').set('fununit', {'1'});
model.material('mat4').propertyGroup('InternalTransmittance25').func('int1').set('argunit', {'nm'});
model.material('mat4').propertyGroup('InternalTransmittance25').set('taui25', 'taui25(c_const/freq)');
model.material('mat4').propertyGroup('InternalTransmittance25').addInput('frequency');
model.material('mat4').set('family', 'plastic');
model.material('mat1').selection.named('geom1_csel1_dom');
model.material('mat2').selection.named('geom1_csel2_dom');
model.material('mat3').selection.named('geom1_csel3_dom');
model.material('mat4').selection.named('geom1_csel4_dom');
model.material.create('mat5', 'Common', 'comp1');
model.material('mat5').propertyGroup.create('Enu', 'Young''s modulus and Poisson''s ratio');
model.material('mat5').label('Aluminum 6063-T83');
model.material('mat5').set('family', 'aluminum');
model.material('mat5').propertyGroup('def').set('relpermeability', {'1' '0' '0' '0' '1' '0' '0' '0' '1'});
model.material('mat5').propertyGroup('def').set('electricconductivity', {'3.030e7[S/m]' '0' '0' '0' '3.030e7[S/m]' '0' '0' '0' '3.030e7[S/m]'});
model.material('mat5').propertyGroup('def').set('thermalexpansioncoefficient', {'23.4e-6[1/K]' '0' '0' '0' '23.4e-6[1/K]' '0' '0' '0' '23.4e-6[1/K]'});
model.material('mat5').propertyGroup('def').set('heatcapacity', '900[J/(kg*K)]');
model.material('mat5').propertyGroup('def').set('relpermittivity', {'1' '0' '0' '0' '1' '0' '0' '0' '1'});
model.material('mat5').propertyGroup('def').set('density', '2700[kg/m^3]');
model.material('mat5').propertyGroup('def').set('thermalconductivity', {'201[W/(m*K)]' '0' '0' '0' '201[W/(m*K)]' '0' '0' '0' '201[W/(m*K)]'});
model.material('mat5').propertyGroup('Enu').set('E', '69[GPa]');
model.material('mat5').propertyGroup('Enu').set('nu', '0.33');
model.material('mat5').set('family', 'aluminum');
model.material('mat5').selection.named('uni1');
model.material.create('mat6', 'Common', 'comp1');
model.material('mat6').selection.named('geom1_csel10_dom');
model.material('mat6').label('RTV');
model.material('mat6').propertyGroup.create('Enu', 'Young''s_modulus_and_Poisson''s_ratio');
model.material('mat6').propertyGroup('Enu').set('E', {'E_RTV'});
model.material('mat6').propertyGroup('Enu').set('nu', {'nu_RTV'});
model.material('mat6').propertyGroup('def').set('density', {'rho_RTV'});
model.material('mat6').propertyGroup('def').set('thermalexpansioncoefficient', {'alpha_RTV'});

model.study('std1').create('stat', 'Stationary');
model.study('std1').feature('stat').setEntry('activate', 'solid', true);
model.study('std1').create('rtrac', 'RayTracing');
model.study('std1').feature('rtrac').set('timestepspec', 'specifylength');
model.study('std1').feature('rtrac').set('lunit', 'mm');
model.study('std1').feature('rtrac').set('llist', '0 215');
model.study('std1').feature('rtrac').set('geometricNonlinearity', true);
model.study('std1').feature('rtrac').setEntry('activate', 'gop', true);
model.study('std1').feature('rtrac').setEntry('activate', 'solid', false);
model.study('std1').feature('rtrac').set('useadvanceddisable', true);
model.study('std1').feature('rtrac').set('disabledphysics', {'gop/wall3'});

model.sol.create('sol1');
model.sol('sol1').study('std1');

model.study('std1').feature('stat').set('notlistsolnum', 1);
model.study('std1').feature('stat').set('notsolnum', 'auto');
model.study('std1').feature('stat').set('listsolnum', 1);
model.study('std1').feature('stat').set('solnum', 'auto');
model.study('std1').feature('rtrac').set('notlistsolnum', 1);
model.study('std1').feature('rtrac').set('notsolnum', 'auto');
model.study('std1').feature('rtrac').set('listsolnum', 1);
model.study('std1').feature('rtrac').set('solnum', 'auto');

model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'stat');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').set('control', 'stat');
model.sol('sol1').create('s1', 'Stationary');
model.sol('sol1').feature('s1').feature('aDef').set('cachepattern', true);
model.sol('sol1').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('s1').feature('fc1').set('termonres', 'auto');
model.sol('sol1').feature('s1').feature('fc1').set('reserrfact', 1000);
model.sol('sol1').feature('s1').create('d1', 'Direct');
model.sol('sol1').feature('s1').feature('d1').set('linsolver', 'pardiso');
model.sol('sol1').feature('s1').feature('d1').set('pivotperturb', 1.0E-9);
model.sol('sol1').feature('s1').feature('d1').label('Suggested Direct Solver (solid)');
model.sol('sol1').feature('s1').create('i1', 'Iterative');
model.sol('sol1').feature('s1').feature('i1').set('linsolver', 'gmres');
model.sol('sol1').feature('s1').feature('i1').set('rhob', 400);
model.sol('sol1').feature('s1').feature('i1').set('nlinnormuse', true);
model.sol('sol1').feature('s1').feature('i1').label('Suggested Iterative Solver (solid)');
model.sol('sol1').feature('s1').feature('i1').create('mg1', 'Multigrid');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').set('prefun', 'gmg');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('pr').create('so1', 'SOR');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('pr').feature('so1').set('relax', 0.8);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('po').create('so1', 'SOR');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('po').feature('so1').set('relax', 0.8);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('cs').create('d1', 'Direct');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('cs').feature('d1').set('linsolver', 'pardiso');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('cs').feature('d1').set('pivotperturb', 1.0E-9);
model.sol('sol1').feature('s1').feature('fc1').set('linsolver', 'd1');
model.sol('sol1').feature('s1').feature('fc1').set('termonres', 'auto');
model.sol('sol1').feature('s1').feature('fc1').set('reserrfact', 1000);
model.sol('sol1').feature('s1').feature.remove('fcDef');
model.sol('sol1').create('su1', 'StoreSolution');
model.sol('sol1').create('st2', 'StudyStep');
model.sol('sol1').feature('st2').set('study', 'std1');
model.sol('sol1').feature('st2').set('studystep', 'rtrac');
model.sol('sol1').create('v2', 'Variables');
model.sol('sol1').feature('v2').set('initmethod', 'sol');
model.sol('sol1').feature('v2').set('initsol', 'sol1');
model.sol('sol1').feature('v2').set('initsoluse', 'su1');
model.sol('sol1').feature('v2').set('notsolmethod', 'sol');
model.sol('sol1').feature('v2').set('notsol', 'sol1');
model.sol('sol1').feature('v2').set('notsoluse', 'su1');
model.sol('sol1').feature('v2').set('control', 'rtrac');
model.sol('sol1').create('t1', 'Time');
model.sol('sol1').feature('t1').set('tlist', 'range(0,0.01,1)');
model.sol('sol1').feature('t1').set('plot', 'off');
model.sol('sol1').feature('t1').set('plotgroup', 'Default');
model.sol('sol1').feature('t1').set('plotfreq', 'tout');
model.sol('sol1').feature('t1').set('probesel', 'all');
model.sol('sol1').feature('t1').set('probes', {});
model.sol('sol1').feature('t1').set('probefreq', 'tsteps');
model.sol('sol1').feature('t1').set('rtol', 1.0E-5);
model.sol('sol1').feature('t1').set('atolglobalvaluemethod', 'factor');
model.sol('sol1').feature('t1').set('tstepsgenalpha', 'strict');
model.sol('sol1').feature('t1').set('endtimeinterpolation', true);
model.sol('sol1').feature('t1').set('timemethod', 'genalpha');
model.sol('sol1').feature('t1').set('estrat', 'exclude');
model.sol('sol1').feature('t1').set('control', 'rtrac');
model.sol('sol1').feature('t1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('t1').feature('fc1').set('ntolfact', 0.1);
model.sol('sol1').feature('t1').create('i1', 'Iterative');
model.sol('sol1').feature('t1').feature('i1').set('linsolver', 'gmres');
model.sol('sol1').feature('t1').feature('i1').create('ja1', 'Jacobi');
model.sol('sol1').feature('t1').feature('fc1').set('linsolver', 'i1');
model.sol('sol1').feature('t1').feature('fc1').set('ntolfact', 0.1);
model.sol('sol1').feature('t1').feature.remove('fcDef');
model.sol('sol1').attach('std1');

model.result.dataset.create('ray1', 'Ray');
model.result.dataset('ray1').set('solution', 'sol1');
model.result.dataset('ray1').set('posdof', {'comp1.qx' 'comp1.qy' 'comp1.qz'});
model.result.dataset('ray1').set('geom', 'geom1');
model.result.dataset('ray1').set('rgeom', 'pgeom_gop');
model.result.dataset('ray1').set('rgeomspec', 'fromphysics');
model.result.dataset('ray1').set('physicsinterface', 'gop');
model.result.create('pg1', 'PlotGroup3D');
model.result('pg1').label('Ray Trajectories (gop)');
model.result('pg1').create('rtrj1', 'RayTrajectories');
model.result('pg1').feature('rtrj1').set('linetype', 'line');
model.result('pg1').feature('rtrj1').create('col1', 'Color');
model.result('pg1').feature('rtrj1').feature('col1').set('expr', 't');
model.result('pg1').feature('rtrj1').create('filt1', 'RayTrajectoriesFilter');
model.result.create('pg2', 'PlotGroup3D');
model.result('pg2').label('Stress (solid)');
model.result('pg2').set('frametype', 'spatial');
model.result('pg2').create('vol1', 'Volume');
model.result('pg2').feature('vol1').set('expr', {'solid.mises'});
model.result('pg2').feature('vol1').set('threshold', 'manual');
model.result('pg2').feature('vol1').set('thresholdvalue', 0.2);
model.result('pg2').feature('vol1').set('resolution', 'custom');
model.result('pg2').feature('vol1').set('refine', 2);
model.result('pg2').feature('vol1').set('colortable', 'Prism');
model.result('pg2').feature('vol1').create('def', 'Deform');
model.result('pg2').feature('vol1').feature('def').set('expr', {'u' 'v' 'w'});
model.result('pg2').feature('vol1').feature('def').set('descr', 'Displacement field');

model.sol('sol1').runAll;

model.result('pg1').set('data', 'ray1');
model.result('pg2').set('data', 'dset1');
model.result('pg1').run;
model.result('pg2').run;
model.result.dataset('dset1').selection.geom('geom1', 3);
model.result.dataset('dset1').selection.named('geom1_sel1');
model.result.dataset.create('ip1', 'IntersectionPoint3D');
model.result.dataset('ip1').set('genmethod', 'threepoint');
model.result.dataset('ip1').setIndex('genpoints', 'aveop1(x)', 0, 0);
model.result.dataset('ip1').setIndex('genpoints', 'aveop1(y)', 0, 1);
model.result.dataset('ip1').setIndex('genpoints', 'aveop1(z)', 0, 2);
model.result.dataset('ip1').setIndex('genpoints', 'aveop2(x)', 1, 0);
model.result.dataset('ip1').setIndex('genpoints', 'aveop2(y)', 1, 1);
model.result.dataset('ip1').setIndex('genpoints', 'aveop2(z)', 1, 2);
model.result.dataset('ip1').setIndex('genpoints', 'aveop3(x)', 2, 0);
model.result.dataset('ip1').setIndex('genpoints', 'aveop3(y)', 2, 1);
model.result.dataset('ip1').setIndex('genpoints', 'aveop3(z)', 2, 2);
model.result('pg1').run;
model.result.duplicate('pg3', 'pg1');
model.result('pg3').run;
model.result('pg3').label('Temperature');
model.result('pg3').set('titletype', 'none');
model.result('pg3').set('view', 'new');
model.result('pg3').set('showlegendsmaxmin', true);
model.result('pg3').set('showlegendsunit', true);
model.result('pg3').set('legendpos', 'bottom');
model.result('pg3').set('legendactive', true);
model.result('pg3').set('legendprecision', 4);
model.result('pg3').run;
model.result('pg3').feature('rtrj1').set('extrasteps', 'all');
model.result('pg3').run;
model.result('pg3').feature('rtrj1').feature('col1').set('expr', 'gop.prf');
model.result('pg3').feature('rtrj1').feature('col1').set('unit', 'um');
model.result('pg3').feature('rtrj1').feature('col1').set('colorlegend', false);
model.result('pg3').run;
model.result('pg3').feature('rtrj1').feature('filt1').set('type', 'logical');
model.result('pg3').feature('rtrj1').feature('filt1').set('logicalexpr', 'at(0,qx>0.1[mm])');
model.result('pg3').run;
model.result('pg3').create('surf1', 'Surface');
model.result('pg3').feature('surf1').set('expr', 'solid.T');
model.result('pg3').feature('surf1').set('unit', 'degC');
model.result('pg3').feature('surf1').set('rangecoloractive', true);
model.result('pg3').feature('surf1').set('rangecolormin', -27.5);
model.result('pg3').feature('surf1').set('rangecolormax', 52.5);
model.result('pg3').feature('surf1').set('colortable', 'WaveLight');
model.result('pg3').feature('surf1').create('sel1', 'Selection');
model.result('pg3').feature('surf1').feature('sel1').selection.named('geom1_comsel1');
model.result('pg3').run;
model.result('pg3').feature('surf1').create('filt1', 'Filter');
model.result('pg3').run;
model.result('pg3').feature('surf1').feature('filt1').set('expr', 'x>0.5[mm] || y<-0.5[mm]');
model.result('pg3').run;
model.result('pg3').feature.duplicate('surf2', 'surf1');
model.result('pg3').run;
model.result('pg3').feature('surf2').set('expr', '1');
model.result('pg3').feature('surf2').set('coloring', 'uniform');
model.result('pg3').feature('surf2').set('color', 'gray');
model.result('pg3').feature('surf2').create('tran1', 'Transparency');
model.result('pg3').run;
model.result('pg3').run;
model.result('pg3').feature('surf2').feature('sel1').selection.named('geom1_csel5_bnd');
model.result('pg3').run;
model.result('pg3').create('slc1', 'Slice');
model.result('pg3').feature('slc1').set('expr', 'solid.mises');
model.result('pg3').feature('slc1').set('unit', 'MPa');
model.result('pg3').feature('slc1').set('quickxnumber', 1);
model.result('pg3').feature('slc1').set('rangecoloractive', true);
model.result('pg3').feature('slc1').set('rangecolormax', 10);
model.result('pg3').feature('slc1').set('colortable', 'HeatCamera');
model.result('pg3').feature('slc1').set('colortabletrans', 'reverse');
model.result('pg3').feature('slc1').create('sel1', 'Selection');
model.result('pg3').feature('slc1').feature('sel1').selection.named('uni1');
model.result('pg3').run;
model.result('pg3').feature('slc1').create('filt1', 'Filter');
model.result('pg3').run;
model.result('pg3').feature('slc1').feature('filt1').set('expr', 'y>0');
model.result('pg3').run;
model.result('pg3').feature.duplicate('slc2', 'slc1');
model.result('pg3').run;
model.result('pg3').feature('slc2').set('quickplane', 'zx');
model.result('pg3').feature('slc2').set('quickynumber', 1);
model.result('pg3').feature('slc2').set('inheritplot', 'slc1');
model.result('pg3').run;
model.result('pg3').feature('slc2').feature('filt1').set('expr', 'x<0');
model.result('pg3').run;
model.result('pg3').feature.duplicate('slc3', 'slc1');
model.result('pg3').run;
model.result('pg3').run;
model.result('pg3').feature('slc3').feature('sel1').selection.named('uni2');
model.result('pg3').run;
model.result('pg3').feature('slc3').set('inheritplot', 'slc2');
model.result('pg3').feature('slc3').create('tran1', 'Transparency');
model.result('pg3').run;
model.result('pg3').feature('slc3').feature('tran1').set('transparency', 0.25);
model.result('pg3').run;
model.result('pg3').feature.duplicate('slc4', 'slc2');
model.result('pg3').run;
model.result('pg3').run;
model.result('pg3').feature('slc4').feature('sel1').selection.named('uni2');
model.result('pg3').run;
model.result('pg3').feature('slc4').create('tran1', 'Transparency');
model.result('pg3').run;
model.result('pg3').feature('slc4').feature('tran1').set('transparency', 0.25);
model.result('pg3').run;

model.view('view8').camera.set('projection', 'orthographic');
model.view('view8').set('showgrid', false);

model.result('pg3').run;
model.result.duplicate('pg4', 'pg3');
model.result('pg4').run;
model.result('pg4').label('Displacement');
model.result('pg4').run;
model.result('pg4').feature('surf1').set('expr', 'w');
model.result('pg4').feature('surf1').set('unit', 'um');
model.result('pg4').feature('surf1').set('rangecolormin', -125);
model.result('pg4').feature('surf1').set('rangecolormax', 125);
model.result('pg4').feature('surf1').set('colortable', 'TrafficLight');
model.result('pg4').feature('surf1').set('colortabletrans', 'reverse');
model.result('pg4').feature('surf1').create('def1', 'Deform');
model.result('pg4').run;
model.result('pg4').feature('surf1').feature('def1').set('scaleactive', true);
model.result('pg4').feature('surf1').feature('def1').set('scale', 25);
model.result('pg4').run;
model.result('pg4').feature('surf2').create('def1', 'Deform');
model.result('pg4').run;
model.result('pg4').feature('surf2').feature('def1').set('scaleactive', true);
model.result('pg4').feature('surf2').feature('def1').set('scale', 25);
model.result('pg4').run;
model.result('pg4').feature('slc1').set('colortable', 'AuroraAustralis');
model.result('pg4').feature('slc1').set('colortabletrans', 'none');
model.result('pg4').feature('slc1').create('def1', 'Deform');
model.result('pg4').run;
model.result('pg4').feature('slc1').feature('def1').set('scaleactive', true);
model.result('pg4').feature('slc1').feature('def1').set('scale', 25);
model.result('pg4').run;
model.result('pg4').feature('slc2').create('def1', 'Deform');
model.result('pg4').run;
model.result('pg4').run;
model.result('pg4').feature('slc3').create('def1', 'Deform');
model.result('pg4').run;
model.result('pg4').run;
model.result('pg4').feature('slc4').create('def1', 'Deform');
model.result('pg4').run;
model.result('pg4').run;
model.result.create('pg5', 'PlotGroup2D');
model.result('pg5').run;
model.result('pg5').label('Spot Diagram, Nominal');
model.result('pg5').set('data', 'none');
model.result('pg5').set('titletype', 'manual');
model.result('pg5').set('title', 'Spot Diagram: Nominal Focal Plane');
model.result('pg5').set('showlegendsmaxmin', true);
model.result('pg5').set('showlegendsunit', true);
model.result('pg5').create('spot1', 'SpotDiagram');
model.result('pg5').feature('spot1').set('data', 'ip1');
model.result('pg5').feature('spot1').set('layout', 'rectangular');
model.result('pg5').feature('spot1').set('columns', 1);
model.result('pg5').feature('spot1').set('origin', 'area');
model.result('pg5').feature('spot1').set('paddingvert', 1);
model.result('pg5').feature('spot1').set('spotcoordsactive', true);
model.result('pg5').feature('spot1').set('spotcoordssystem', 'global');
model.result('pg5').feature('spot1').set('spotcoordsprecision', 6);
model.result('pg5').feature('spot1').create('col1', 'Color');
model.result('pg5').run;
model.result('pg5').feature('spot1').feature('col1').set('expr', 'gop.lambda0');
model.result('pg5').feature('spot1').feature('col1').set('unit', 'nm');
model.result('pg5').feature('spot1').feature('col1').set('rangecoloractive', true);
model.result('pg5').feature('spot1').feature('col1').set('rangecolormin', 450);
model.result('pg5').feature('spot1').feature('col1').set('rangecolormax', 650);
model.result('pg5').run;
model.result('pg5').run;
model.result.duplicate('pg6', 'pg5');
model.result('pg6').run;
model.result('pg6').label('Spot Diagram, Best Focus');
model.result('pg6').set('title', 'Spot Diagram: Best Focus Plane');
model.result('pg6').set('view', 'new');
model.result('pg6').run;
model.result('pg6').feature('spot1').set('data', 'ray1');
model.result('pg6').feature('spot1').set('filterreleaseactive', true);
model.result('pg6').feature('spot1').set('normal', 'userdefined');
model.result('pg6').feature('spot1').set('transverse', 'userdefined');
model.result.dataset.create('ip2', 'IntersectionPoint3D');
model.result('pg6').feature('spot1').set('data', 'ip2');
model.result.dataset('ip2').set('data', 'ray1');
model.result.dataset('ip2').set('genmethod', 'threepoint');
model.result.dataset('ip2').setIndex('genpoints', '-3.7701780943414696E-5[mm]', 0, 0);
model.result.dataset('ip2').setIndex('genpoints', '1.1675142931909414E-5[mm]', 0, 1);
model.result.dataset('ip2').setIndex('genpoints', '162.80059933858007[mm]', 0, 2);
model.result.dataset('ip2').setIndex('genpoints', '-3.67017809434147E-5[mm]', 1, 0);
model.result.dataset('ip2').setIndex('genpoints', '1.1675142931909414E-5[mm]', 1, 1);
model.result.dataset('ip2').setIndex('genpoints', '162.80059933858007[mm]', 1, 2);
model.result.dataset('ip2').setIndex('genpoints', '-3.7701780943414696E-5[mm]', 2, 0);
model.result.dataset('ip2').setIndex('genpoints', '1.2675142931909414E-5[mm]', 2, 1);
model.result.dataset('ip2').setIndex('genpoints', '162.80059933858007[mm]', 2, 2);
model.result('pg6').feature('spot1').run;
model.result.dataset('ip2').set('genmethod', 'threepoint');
model.result.dataset('ip2').setIndex('genpoints', '-3.5915495796839196E-5[mm]', 0, 0);
model.result.dataset('ip2').setIndex('genpoints', '1.0351446988681672E-5[mm]', 0, 1);
model.result.dataset('ip2').setIndex('genpoints', '162.79245149991513[mm]', 0, 2);
model.result.dataset('ip2').setIndex('genpoints', '-3.49154957968392E-5[mm]', 1, 0);
model.result.dataset('ip2').setIndex('genpoints', '1.0351446988681672E-5[mm]', 1, 1);
model.result.dataset('ip2').setIndex('genpoints', '162.79245149991513[mm]', 1, 2);
model.result.dataset('ip2').setIndex('genpoints', '-3.5915495796839196E-5[mm]', 2, 0);
model.result.dataset('ip2').setIndex('genpoints', '1.1351446988681673E-5[mm]', 2, 1);
model.result.dataset('ip2').setIndex('genpoints', '162.79245149991513[mm]', 2, 2);
model.result('pg6').set('ispendingzoom', true);
model.result('pg6').feature('spot1').run;
model.result('pg6').feature('spot1').set('filterreleaseactive', false);
model.result('pg6').run;

model.title('Petzval Lens STOP Analysis');

model.description('This model demonstrates an integrated structural-thermal-optical performance (STOP) analysis of an optical system at a uniform temperature. The Petzval Lens tutorial is used as the basis for this model, together with a simple barrel geometry. The resulting displacement and stress fields within the optical system are shown together with nominal and best focus spot diagrams. This model is the basis for several extensions of this study.');

model.label('petzval_lens_stop_analysis.mph');

model.result('pg6').run;

model.study('std1').setGenPlots(false);
model.study('std1').setGenConv(false);
model.study('std1').create('param', 'Parametric');
model.study('std1').feature('param').setIndex('pname', 'alpha_B', 0);
model.study('std1').feature('param').setIndex('plistarr', '', 0);
model.study('std1').feature('param').setIndex('punit', '1/K', 0);
model.study('std1').feature('param').setIndex('pname', 'alpha_B', 0);
model.study('std1').feature('param').setIndex('plistarr', '', 0);
model.study('std1').feature('param').setIndex('punit', '1/K', 0);
model.study('std1').feature('param').setIndex('pname', 'T0', 0);
model.study('std1').feature('param').setIndex('plistarr', '-25 0 25 50', 0);
model.study('std1').feature('param').setIndex('punit', 'degC', 0);

model.sol('sol1').study('std1');
model.sol('sol2').copySolution('sol3');

model.study('std1').feature('rtrac').set('notlistsolnum', 1);
model.study('std1').feature('rtrac').set('notsolnum', 'auto');
model.study('std1').feature('rtrac').set('listsolnum', 1);
model.study('std1').feature('rtrac').set('solnum', 'auto');
model.study('std1').feature('rtrac').set('notlistsolnum', 1);
model.study('std1').feature('rtrac').set('notsolnum', 'auto');
model.study('std1').feature('rtrac').set('listsolnum', 1);
model.study('std1').feature('rtrac').set('solnum', 'auto');

model.result.dataset('dset2').set('solution', 'none');

model.sol('sol1').feature.remove('t1');
model.sol('sol1').feature.remove('v2');
model.sol('sol1').feature.remove('st2');
model.sol('sol1').feature.remove('su1');
model.sol('sol1').feature.remove('s1');
model.sol('sol1').feature.remove('v1');
model.sol('sol1').feature.remove('st1');
model.sol('sol3').copySolution('sol2');
model.sol.remove('sol3');
model.sol('sol2').label('Solution Store 1');

model.result.dataset.remove('dset4');

model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'stat');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').set('control', 'stat');
model.sol('sol1').create('s1', 'Stationary');
model.sol('sol1').feature('s1').feature('aDef').set('cachepattern', true);
model.sol('sol1').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('s1').feature('fc1').set('termonres', 'auto');
model.sol('sol1').feature('s1').feature('fc1').set('reserrfact', 1000);
model.sol('sol1').feature('s1').create('d1', 'Direct');
model.sol('sol1').feature('s1').feature('d1').set('linsolver', 'pardiso');
model.sol('sol1').feature('s1').feature('d1').set('pivotperturb', 1.0E-9);
model.sol('sol1').feature('s1').feature('d1').label('Suggested Direct Solver (solid)');
model.sol('sol1').feature('s1').create('i1', 'Iterative');
model.sol('sol1').feature('s1').feature('i1').set('linsolver', 'gmres');
model.sol('sol1').feature('s1').feature('i1').set('rhob', 400);
model.sol('sol1').feature('s1').feature('i1').set('nlinnormuse', true);
model.sol('sol1').feature('s1').feature('i1').label('Suggested Iterative Solver (solid)');
model.sol('sol1').feature('s1').feature('i1').create('mg1', 'Multigrid');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').set('prefun', 'gmg');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('pr').create('so1', 'SOR');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('pr').feature('so1').set('relax', 0.8);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('po').create('so1', 'SOR');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('po').feature('so1').set('relax', 0.8);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('cs').create('d1', 'Direct');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('cs').feature('d1').set('linsolver', 'pardiso');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('cs').feature('d1').set('pivotperturb', 1.0E-9);
model.sol('sol1').feature('s1').feature('fc1').set('linsolver', 'd1');
model.sol('sol1').feature('s1').feature('fc1').set('termonres', 'auto');
model.sol('sol1').feature('s1').feature('fc1').set('reserrfact', 1000);
model.sol('sol1').feature('s1').feature.remove('fcDef');
model.sol('sol1').create('su1', 'StoreSolution');
model.sol('sol1').feature('su1').set('sol', 'sol2');
model.sol('sol1').feature('su1').label('Solution Store 1');
model.sol('sol1').create('st2', 'StudyStep');
model.sol('sol1').feature('st2').set('study', 'std1');
model.sol('sol1').feature('st2').set('studystep', 'rtrac');

model.study('std1').feature('rtrac').set('notsoluse', 'sol2');
model.study('std1').feature('rtrac').set('initsoluse', 'sol2');

model.sol('sol1').create('v2', 'Variables');
model.sol('sol1').feature('v2').set('initmethod', 'sol');
model.sol('sol1').feature('v2').set('initsol', 'sol1');
model.sol('sol1').feature('v2').set('notsolmethod', 'sol');
model.sol('sol1').feature('v2').set('notsol', 'sol1');
model.sol('sol1').feature('v2').set('control', 'rtrac');
model.sol('sol1').create('t1', 'Time');
model.sol('sol1').feature('t1').set('tlist', 'range(0,0.01,1)');
model.sol('sol1').feature('t1').set('plot', 'off');
model.sol('sol1').feature('t1').set('plotgroup', 'pg1');
model.sol('sol1').feature('t1').set('plotfreq', 'tout');
model.sol('sol1').feature('t1').set('probesel', 'all');
model.sol('sol1').feature('t1').set('probes', {});
model.sol('sol1').feature('t1').set('probefreq', 'tsteps');
model.sol('sol1').feature('t1').set('rtol', 1.0E-5);
model.sol('sol1').feature('t1').set('atolglobalvaluemethod', 'factor');
model.sol('sol1').feature('t1').set('reacf', false);
model.sol('sol1').feature('t1').set('storeudot', false);
model.sol('sol1').feature('t1').set('tstepsgenalpha', 'strict');
model.sol('sol1').feature('t1').set('endtimeinterpolation', true);
model.sol('sol1').feature('t1').set('timemethod', 'genalpha');
model.sol('sol1').feature('t1').set('estrat', 'exclude');
model.sol('sol1').feature('t1').set('control', 'rtrac');
model.sol('sol1').feature('t1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('t1').feature('fc1').set('ntolfact', 0.1);
model.sol('sol1').feature('t1').create('i1', 'Iterative');
model.sol('sol1').feature('t1').feature('i1').set('linsolver', 'gmres');
model.sol('sol1').feature('t1').feature('i1').create('ja1', 'Jacobi');
model.sol('sol1').feature('t1').feature('fc1').set('linsolver', 'i1');
model.sol('sol1').feature('t1').feature('fc1').set('ntolfact', 0.1);
model.sol('sol1').feature('t1').feature.remove('fcDef');

model.result.dataset('dset2').set('solution', 'sol2');

model.sol('sol1').attach('std1');

model.batch.create('p1', 'Parametric');
model.batch('p1').study('std1');
model.batch('p1').create('so1', 'Solutionseq');
model.batch('p1').feature('so1').set('seq', 'sol1');
model.batch('p1').feature('so1').set('store', 'on');
model.batch('p1').feature('so1').set('clear', 'on');
model.batch('p1').feature('so1').set('psol', 'none');
model.batch('p1').set('pname', {'T0'});
model.batch('p1').set('plistarr', {'-25 0 25 50'});
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

model.result('pg1').run;
model.result.setOnlyPlotWhenRequested(true);
model.result.dataset('ray1').set('solution', 'sol3');
model.result('pg3').setIndex('looplevel', 1, 1);
model.result('pg3').run;
model.result('pg3').setIndex('looplevel', 2, 1);
model.result('pg3').run;
model.result('pg3').setIndex('looplevel', 3, 1);
model.result('pg3').run;
model.result('pg3').setIndex('looplevel', 4, 1);
model.result('pg3').run;
model.result('pg4').setIndex('looplevel', 1, 1);
model.result('pg4').run;
model.result('pg4').setIndex('looplevel', 2, 1);
model.result('pg4').run;
model.result('pg4').setIndex('looplevel', 3, 1);
model.result('pg4').run;
model.result('pg4').setIndex('looplevel', 4, 1);
model.result('pg4').run;
model.result.dataset('ip1').setIndex('looplevelinput', 'manual', 1);
model.result.dataset('ip1').setIndex('looplevel', [1], 1);
model.result.dataset.duplicate('ip3', 'ip1');
model.result.dataset('ip3').setIndex('looplevel', [2], 1);
model.result.dataset.duplicate('ip4', 'ip3');
model.result.dataset('ip4').setIndex('looplevel', [3], 1);
model.result.dataset.duplicate('ip5', 'ip4');
model.result.dataset('ip5').setIndex('looplevel', [4], 1);
model.result('pg5').feature('spot1').set('spotcoordsactive', false);
model.result('pg5').feature('spot1').set('spotsizeposition', 'above');
model.result('pg5').feature.duplicate('spot2', 'spot1');
model.result('pg5').feature('spot2').set('data', 'ip3');
model.result('pg5').feature('spot2').set('posexpr', {'0.1' '0'});
model.result('pg5').feature('spot2').set('inheritplot', 'spot1');
model.result('pg5').feature.duplicate('spot3', 'spot2');
model.result('pg5').feature('spot3').set('data', 'ip4');
model.result('pg5').feature('spot3').set('posexpr', {'0.2' '0'});
model.result('pg5').feature.duplicate('spot4', 'spot3');
model.result('pg5').feature('spot4').set('data', 'ip5');
model.result('pg5').feature('spot4').set('posexpr', {'0.3' '0'});
model.result('pg5').create('ann1', 'Annotation');
model.result('pg5').feature('ann1').set('data', 'ray1');
model.result('pg5').feature('ann1').setIndex('looplevel', 1, 1);
model.result('pg5').feature('ann1').set('text', '$T = eval(T0-0[degC])^\circ$C \\ $\Delta z = eval((aveop1(z)-z_image)/1[um])\,\textrm{\textmu}$m');
model.result('pg5').feature('ann1').set('level', 'global');
model.result('pg5').feature('ann1').set('posyexpr', -0.01);
model.result('pg5').feature('ann1').set('exprprecision', 3);
model.result('pg5').feature('ann1').set('latexmarkup', true);
model.result('pg5').feature('ann1').set('showpoint', false);
model.result('pg5').feature('ann1').set('anchorpoint', 'middleleft');
model.result('pg5').feature.duplicate('ann2', 'ann1');
model.result('pg5').feature('ann2').setIndex('looplevel', 2, 1);
model.result('pg5').feature('ann2').set('posxexpr', 0.1);
model.result('pg5').feature.duplicate('ann3', 'ann2');
model.result('pg5').feature('ann3').setIndex('looplevel', 3, 1);
model.result('pg5').feature('ann3').set('posxexpr', 0.2);
model.result('pg5').feature.duplicate('ann4', 'ann3');
model.result('pg5').feature('ann4').setIndex('looplevel', 4, 1);
model.result('pg5').feature('ann4').set('posxexpr', 0.3);
model.result('pg5').run;
model.result.dataset('ip2').setIndex('looplevelinput', 'manual', 1);
model.result.dataset('ip2').setIndex('looplevel', [1], 1);
model.result.dataset.duplicate('ip6', 'ip2');
model.result.dataset('ip6').setIndex('looplevel', [2], 1);
model.result.dataset.duplicate('ip7', 'ip6');
model.result.dataset('ip7').setIndex('looplevel', [3], 1);
model.result.dataset.duplicate('ip8', 'ip7');
model.result.dataset('ip8').setIndex('looplevel', [4], 1);
model.result('pg6').feature('spot1').set('paddingvert', 2);
model.result('pg6').feature('spot1').set('spotcoordsactive', false);
model.result('pg6').feature('spot1').set('spotsizeposition', 'above');
model.result('pg6').feature('spot1').set('filterreleaseactive', true);
model.result('pg6').run;
model.result.dataset('ip2').set('genmethod', 'threepoint');
model.result.dataset('ip2').setIndex('genpoints', '-3.590815414809366E-5[mm]', 0, 0);
model.result.dataset('ip2').setIndex('genpoints', '1.034596797317199E-5[mm]', 0, 1);
model.result.dataset('ip2').setIndex('genpoints', '162.79244558513767[mm]', 0, 2);
model.result.dataset('ip2').setIndex('genpoints', '-3.490815414809366E-5[mm]', 1, 0);
model.result.dataset('ip2').setIndex('genpoints', '1.034596797317199E-5[mm]', 1, 1);
model.result.dataset('ip2').setIndex('genpoints', '162.79244558513767[mm]', 1, 2);
model.result.dataset('ip2').setIndex('genpoints', '-3.590815414809366E-5[mm]', 2, 0);
model.result.dataset('ip2').setIndex('genpoints', '1.134596797317199E-5[mm]', 2, 1);
model.result.dataset('ip2').setIndex('genpoints', '162.79244558513767[mm]', 2, 2);
model.result('pg6').set('ispendingzoom', true);
model.result('pg6').feature('spot1').run;
model.result('pg6').feature('spot1').set('filterreleaseactive', false);
model.result('pg6').feature.duplicate('spot2', 'spot1');
model.result('pg6').feature('spot2').set('data', 'ip6');
model.result('pg6').feature('spot2').set('filterreleaseactive', true);
model.result('pg6').run;
model.result.dataset('ip6').set('genmethod', 'threepoint');
model.result.dataset('ip6').setIndex('genpoints', '-1.3459349405498742E-5[mm]', 0, 0);
model.result.dataset('ip6').setIndex('genpoints', '6.411183100467882E-6[mm]', 0, 1);
model.result.dataset('ip6').setIndex('genpoints', '162.7830400550561[mm]', 0, 2);
model.result.dataset('ip6').setIndex('genpoints', '-1.2459349405498741E-5[mm]', 1, 0);
model.result.dataset('ip6').setIndex('genpoints', '6.411183100467882E-6[mm]', 1, 1);
model.result.dataset('ip6').setIndex('genpoints', '162.7830400550561[mm]', 1, 2);
model.result.dataset('ip6').setIndex('genpoints', '-1.3459349405498742E-5[mm]', 2, 0);
model.result.dataset('ip6').setIndex('genpoints', '7.411183100467882E-6[mm]', 2, 1);
model.result.dataset('ip6').setIndex('genpoints', '162.7830400550561[mm]', 2, 2);
model.result('pg6').set('ispendingzoom', true);
model.result('pg6').feature('spot2').run;
model.result('pg6').feature('spot2').set('filterreleaseactive', false);
model.result('pg6').feature('spot2').set('posexpr', {'0.1' '0'});
model.result('pg6').feature('spot2').set('inheritplot', 'spot1');
model.result('pg6').feature.duplicate('spot3', 'spot2');
model.result('pg6').feature('spot3').set('data', 'ip7');
model.result('pg6').feature('spot3').set('filterreleaseactive', true);
model.result('pg6').run;
model.result.dataset('ip7').set('genmethod', 'threepoint');
model.result.dataset('ip7').setIndex('genpoints', '8.365226906811937E-6[mm]', 0, 0);
model.result.dataset('ip7').setIndex('genpoints', '2.4495235574439103E-6[mm]', 0, 1);
model.result.dataset('ip7').setIndex('genpoints', '162.77384962796663[mm]', 0, 2);
model.result.dataset('ip7').setIndex('genpoints', '9.365226906811938E-6[mm]', 1, 0);
model.result.dataset('ip7').setIndex('genpoints', '2.4495235574439103E-6[mm]', 1, 1);
model.result.dataset('ip7').setIndex('genpoints', '162.77384962796663[mm]', 1, 2);
model.result.dataset('ip7').setIndex('genpoints', '8.365226906811937E-6[mm]', 2, 0);
model.result.dataset('ip7').setIndex('genpoints', '3.44952355744391E-6[mm]', 2, 1);
model.result.dataset('ip7').setIndex('genpoints', '162.77384962796663[mm]', 2, 2);
model.result('pg6').set('ispendingzoom', true);
model.result('pg6').feature('spot3').run;
model.result('pg6').feature('spot3').set('filterreleaseactive', false);
model.result('pg6').feature('spot3').set('posexpr', {'0.2' '0'});
model.result('pg6').feature.duplicate('spot4', 'spot3');
model.result('pg6').feature('spot4').set('data', 'ip8');
model.result('pg6').feature('spot4').set('filterreleaseactive', true);
model.result('pg6').run;
model.result.dataset('ip8').set('genmethod', 'threepoint');
model.result.dataset('ip8').setIndex('genpoints', '3.067577614133191E-5[mm]', 0, 0);
model.result.dataset('ip8').setIndex('genpoints', '-1.6031568068771502E-6[mm]', 0, 1);
model.result.dataset('ip8').setIndex('genpoints', '162.7645046320648[mm]', 0, 2);
model.result.dataset('ip8').setIndex('genpoints', '3.1675776141331906E-5[mm]', 1, 0);
model.result.dataset('ip8').setIndex('genpoints', '-1.6031568068771502E-6[mm]', 1, 1);
model.result.dataset('ip8').setIndex('genpoints', '162.7645046320648[mm]', 1, 2);
model.result.dataset('ip8').setIndex('genpoints', '3.067577614133191E-5[mm]', 2, 0);
model.result.dataset('ip8').setIndex('genpoints', '-6.031568068771503E-7[mm]', 2, 1);
model.result.dataset('ip8').setIndex('genpoints', '162.7645046320648[mm]', 2, 2);
model.result('pg6').set('ispendingzoom', true);
model.result('pg6').feature('spot4').run;
model.result('pg6').feature('spot4').set('filterreleaseactive', false);
model.result('pg6').feature('spot4').set('posexpr', {'0.3' '0'});
model.result('pg6').create('ann1', 'Annotation');
model.result('pg6').feature('ann1').set('data', 'ray1');
model.result('pg6').feature('ann1').setIndex('looplevel', 1, 1);
model.result('pg6').feature('ann1').set('text', '$T = eval(T0-0[degC])^\circ$C \\ $\Delta z = eval((162.79248823021723[mm]-aveop1(z))/1[um])\,\textrm{\textmu}$m');
model.result('pg6').feature('ann1').set('level', 'global');
model.result('pg6').feature('ann1').set('exprprecision', 3);
model.result('pg6').feature('ann1').set('latexmarkup', true);
model.result('pg6').feature('ann1').set('showpoint', false);
model.result('pg6').feature.duplicate('ann2', 'ann1');
model.result('pg6').feature('ann2').set('text', '$T = eval(T0-0[degC])^\circ$C \\ $\Delta z = eval((162.78305987604173[mm]-aveop1(z))/1[um])\,\textrm{\textmu}$m');
model.result('pg6').feature('ann2').setIndex('looplevel', 2, 1);
model.result('pg6').feature('ann2').set('posxexpr', 0.1);
model.result('pg6').feature.duplicate('ann3', 'ann2');
model.result('pg6').feature('ann3').set('text', '$T = eval(T0-0[degC])^\circ$C \\ $\Delta z = eval((162.7738443879646[mm]-aveop1(z))/1[um])\,\textrm{\textmu}$m');
model.result('pg6').feature('ann3').setIndex('looplevel', 3, 1);
model.result('pg6').feature('ann3').set('posxexpr', 0.2);
model.result('pg6').feature.duplicate('ann4', 'ann3');
model.result('pg6').feature('ann4').set('text', '$T = eval(T0-0[degC])^\circ$C \\ $\Delta z = eval((162.76447789300707[mm]-aveop1(z))/1[um])\,\textrm{\textmu}$m');
model.result('pg6').feature('ann4').setIndex('looplevel', 4, 1);
model.result('pg6').feature('ann4').set('posxexpr', 0.3);
model.result('pg6').run;

model.title('Petzval Lens STOP Analysis Isothermal Sweep');

model.description('This model demonstrates an integrated structural-thermal-optical performance (STOP) analysis of an optical system. The Petzval Lens STOP analysis tutorial, in which the lens and barrel assembly are subjected to a single isothermal temperature, is used as the basis for this model. A parametric sweep over a range of uniform temperatures is performed and the location of the best focus image plane is determined.');

model.mesh.clearMeshes;

model.sol('sol1').clearSolutionData;
model.sol('sol2').clearSolutionData;
model.sol('sol3').clearSolutionData;
model.sol('sol4').clearSolutionData;
model.sol('sol5').clearSolutionData;
model.sol('sol6').clearSolutionData;
model.sol('sol7').clearSolutionData;

model.label('petzval_lens_stop_analysis_isothermal_sweep.mph');

model.modelNode.label('Components');

out = model;
