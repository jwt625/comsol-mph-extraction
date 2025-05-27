function out = model
%
% petzval_lens_geometric_modulation_transfer_function.m
%
% Model exported on May 26 2025, 21:32 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/Ray_Optics_Module/Lenses_Cameras_and_Telescopes');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 3);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.physics.create('gop', 'GeometricalOptics', 'geom1');
model.physics('gop').model('comp1');

model.study.create('std1');
model.study('std1').create('rtrac', 'RayTracing');
model.study('std1').feature('rtrac').setSolveFor('/physics/gop', true);

model.param.label('Parameters 1: Lens Prescription');
model.param.create('par2');
model.param('par2').label('Parameters 2: General');

% To import content from file, use:
% model.param('par2').loadFile('FILENAME');
model.param('par2').set('theta_x1', '0.0[deg]', 'Field angle 1, x-component');
model.param('par2').set('theta_y1', '0.0[deg]', 'Field angle 1, y-component');
model.param('par2').set('theta_x2', '0.0[deg]', 'Field angle 2, x-component');
model.param('par2').set('theta_y2', '6.0[deg]', 'Field angle 2, y-component');
model.param('par2').set('theta_x3', '0.0[deg]', 'Field angle 3, x-component');
model.param('par2').set('theta_y3', '9.0[deg]', 'Field angle 3, y-component');
model.param('par2').set('N_ring', '12', 'Number of hexapolar rings');
model.param('par2').set('P_nom', '41.5[mm]', 'Nominal entrance pupil diameter');
model.param('par2').set('vx1', 'tan(theta_x1)', 'Ray direction vector 1, x-component');
model.param('par2').set('vy1', 'tan(theta_y1)', 'Ray direction vector 1, y-component');
model.param('par2').set('vx2', 'tan(theta_x2)', 'Ray direction vector 2, x-component');
model.param('par2').set('vy2', 'tan(theta_y2)', 'Ray direction vector 2, y-component');
model.param('par2').set('vx3', 'tan(theta_x3)', 'Ray direction vector 3, x-component');
model.param('par2').set('vy3', 'tan(theta_y3)', 'Ray direction vector 3, y-component');
model.param('par2').set('vz', '1', 'Ray direction vector, z-component');
model.param('par2').set('z_stop', 'Tc_1+T_1+Tc_2+T_2', 'Stop z-coordinate');
model.param('par2').set('z_image', 'Tc_1+T_1+Tc_2+T_2+Tc_3+T_3+Tc_4+T_4+Tc_5+T_5+Tc_6+T_6', 'Image plane nominal z-coordinate');
model.param('par2').set('P1_fac', '-1.142', 'Pupil shift constant 1');
model.param('par2').set('P2_fac', '-0.080', 'Pupil shift constant 2');
model.param('par2').set('P_fac1', 'P1_fac+P2_fac*sin(sqrt(theta_x1^2+theta_y1^2))', 'Pupil shift factor, field 1');
model.param('par2').set('P_fac2', 'P1_fac+P2_fac*sin(sqrt(theta_x2^2+theta_y2^2))', 'Pupil shift factor, field 2');
model.param('par2').set('P_fac3', 'P1_fac+P2_fac*sin(sqrt(theta_x3^2+theta_y3^2))', 'Pupil shift factor, field 3');
model.param('par2').set('dx1', '(dz+P_fac1*z_stop)*tan(theta_x1)', 'Pupil center, field 1, x-coordinate');
model.param('par2').set('dy1', '(dz+P_fac1*z_stop)*tan(theta_y1)', 'Pupil center, field 1, y-coordinate');
model.param('par2').set('dx2', '(dz+P_fac2*z_stop)*tan(theta_x2)', 'Pupil center, field 2, x-coordinate');
model.param('par2').set('dy2', '(dz+P_fac2*z_stop)*tan(theta_y2)', 'Pupil center, field 2, y-coordinate');
model.param('par2').set('dx3', '(dz+P_fac3*z_stop)*tan(theta_x3)', 'Pupil center, field 3, x-coordinate');
model.param('par2').set('dy3', '(dz+P_fac3*z_stop)*tan(theta_y3)', 'Pupil center, field 3, y-coordinate');
model.param('par2').set('dz', '-5[mm]', 'Pupil center, z-component');

model.geom('geom1').lengthUnit('mm');
model.geom('geom1').label('Petzval Lens');
model.geom('geom1').insertFile('petzval_lens_geom_sequence.mph', 'geom1');
model.geom('geom1').run('fin');

model.view('view1').camera.set('projection', 'orthographic');

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

model.physics('gop').prop('WavelengthDistribution').setIndex('WavelengthDistribution', 'PolychromaticWavelength', 0);
model.physics('gop').prop('MaximumSecondary').setIndex('MaximumSecondary', 0, 0);
model.physics('gop').prop('ExteriorUnmeshedProperties').setIndex('DispersionModel', 'AirEdlen1953', 0);
model.physics('gop').feature('mp1').set('RefractiveIndexDomains', 'GetDispersionModelFromMaterial');
model.physics('gop').feature('matd1').set('ReleaseReflectedRays', 'Never');
model.physics('gop').create('relg1', 'ReleaseGrid', -1);
model.physics('gop').feature('relg1').set('GridType', 'Hexapolar');
model.physics('gop').feature('relg1').set('qcc', {'dx1' 'dy1' 'dz'});
model.physics('gop').feature('relg1').set('rcc', {'nix' 'niy' 'niz'});
model.physics('gop').feature('relg1').set('Rc', 'P_nom/2');
model.physics('gop').feature('relg1').setIndex('Ncr', 'N_ring', 0);
model.physics('gop').feature('relg1').set('L0', {'vx1' 'vy1' 'vz'});
model.physics('gop').feature('relg1').set('LDistributionFunction', 'ListOfValues');
model.physics('gop').feature('relg1').setIndex('lambda0vals', '475[nm] 550[nm] 625[nm]', 0);
model.physics('gop').feature.duplicate('relg2', 'relg1');
model.physics('gop').feature('relg2').set('qcc', {'dx2' 'dy2' 'dz'});
model.physics('gop').feature('relg2').set('L0', {'vx2' 'vy2' 'vz'});
model.physics('gop').feature.duplicate('relg3', 'relg2');
model.physics('gop').feature('relg3').set('qcc', {'dx3' 'dy3' 'dz'});
model.physics('gop').feature('relg3').set('L0', {'vx3' 'vy3' 'vz'});
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

model.mesh('mesh1').autoMeshSize(4);
model.mesh('mesh1').run;

model.study('std1').feature('rtrac').set('timestepspec', 'specifylength');
model.study('std1').feature('rtrac').set('lunit', 'mm');
model.study('std1').feature('rtrac').set('llist', '0 200');

model.sol.create('sol1');
model.sol('sol1').study('std1');

model.study('std1').feature('rtrac').set('notlistsolnum', 1);
model.study('std1').feature('rtrac').set('notsolnum', 'auto');
model.study('std1').feature('rtrac').set('listsolnum', 1);
model.study('std1').feature('rtrac').set('solnum', 'auto');

model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'rtrac');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').set('control', 'rtrac');
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

model.sol('sol1').runAll;

model.result('pg1').set('data', 'ray1');
model.result('pg1').run;
model.result('pg1').label('Ray Diagram 1');
model.result('pg1').set('showlegendsunit', true);
model.result('pg1').set('legendpos', 'bottom');
model.result('pg1').run;
model.result('pg1').feature('rtrj1').feature('col1').set('expr', 'at(''last'',gop.rrel)');
model.result('pg1').feature('rtrj1').feature('col1').set('unit', [native2unicode(hex2dec({'00' 'b5'}), 'unicode') 'm']);
model.result('pg1').run;
model.result('pg1').feature('rtrj1').feature('filt1').set('type', 'logical');
model.result('pg1').feature('rtrj1').feature('filt1').set('logicalexpr', 'at(0,abs(gop.deltaqx))<1[mm]');
model.result.dataset.create('cpl1', 'CutPlane');
model.result('pg1').run;
model.result('pg1').create('surf1', 'Surface');
model.result('pg1').feature('surf1').set('data', 'cpl1');
model.result('pg1').feature('surf1').set('expr', 'gop.nrefd');
model.result('pg1').feature('surf1').set('descr', 'Refractive index, d-line');
model.result('pg1').feature('surf1').set('colortable', 'GrayScale');
model.result('pg1').run;
model.result('pg1').create('line1', 'Line');
model.result('pg1').feature('line1').set('data', 'cpl1');
model.result('pg1').feature('line1').setIndex('looplevel', 1, 0);
model.result('pg1').feature('line1').set('coloring', 'uniform');
model.result('pg1').feature('line1').set('color', 'black');
model.result('pg1').run;
model.result.create('pg2', 'PlotGroup3D');
model.result('pg2').run;
model.result('pg2').label('Ray Diagram 2');
model.result('pg2').set('data', 'ray1');
model.result('pg2').set('view', 'new');
model.result('pg2').set('showlegendsunit', true);
model.result('pg2').create('rtrj1', 'RayTrajectories');
model.result('pg2').feature('rtrj1').create('col1', 'Color');
model.result('pg2').run;
model.result('pg2').feature('rtrj1').feature('col1').set('expr', 'at(''last'',gop.rrel)');
model.result('pg2').feature('rtrj1').feature('col1').set('unit', [native2unicode(hex2dec({'00' 'b5'}), 'unicode') 'm']);
model.result('pg2').run;
model.result('pg2').create('surf1', 'Surface');
model.result('pg2').feature('surf1').set('data', 'dset1');
model.result('pg2').feature('surf1').set('coloring', 'uniform');
model.result('pg2').feature('surf1').set('color', 'gray');
model.result('pg2').feature('surf1').create('sel1', 'Selection');
model.result('pg2').feature('surf1').feature('sel1').selection.named('geom1_csel5_bnd');
model.result('pg2').run;
model.result('pg2').feature('surf1').create('tran1', 'Transparency');
model.result('pg2').run;
model.result('pg2').run;

model.view('view5').camera.set('projection', 'orthographic');

model.result.create('pg3', 'PlotGroup2D');
model.result('pg3').run;
model.result('pg3').label('Spot Diagram');
model.result('pg3').set('showlegendsunit', true);
model.result('pg3').create('spot1', 'SpotDiagram');
model.result('pg3').feature('spot1').create('col1', 'Color');
model.result('pg3').run;
model.result('pg3').feature('spot1').feature('col1').set('expr', 'gop.lambda0');
model.result('pg3').feature('spot1').feature('col1').set('unit', 'nm');
model.result('pg3').feature('spot1').feature('col1').set('rangecoloractive', true);
model.result('pg3').feature('spot1').feature('col1').set('rangecolormin', 450);
model.result('pg3').feature('spot1').feature('col1').set('rangecolormax', 650);
model.result('pg3').run;

model.title('Petzval Lens');

model.description(['This tutorial shows how to set up a multi-element objective lens. The chosen lens is a Petzval lens with field flattener described in ''Fundamental Optical Design'', by M. Kidger, 2001, p.' native2unicode(hex2dec({'00' 'a0'}), 'unicode') '192. The tutorial demonstrates how to include a geometric sequence using the ''Spherical Lens 3D'' part found in the Ray Optics Module Part Library. Also demonstrated are the use of clear apertures, as well as edge and aperture obstructions. Finally, the results of a grid-based ray trace at several different wavelengths and field angles are shown graphically.']);

model.label('petzval_lens.mph');

model.result('pg3').run;

model.param('par2').set('N_ring', '30');

% Started method call computeMTF

model.physics('gop').feature('relg1').active(true);
model.physics('gop').feature('relg2').active(false);
model.physics('gop').feature('relg3').active(false);

model.nodeGroup.create('mtfgrp', 'GlobalDefinitions');
model.nodeGroup('mtfgrp').label('MTF Tables');
model.nodeGroup.create('numgrp', 'Results');
model.nodeGroup('numgrp').set('type', 'numerical');
model.nodeGroup('numgrp').label('MTF Evaluations');
model.nodeGroup.create('mtfgrp1', 'GlobalDefinitions');
model.nodeGroup('mtfgrp1').label('MTF: Release from Grid 1');
model.nodeGroup.create('datagrp', 'Results');
model.nodeGroup('datagrp').set('type', 'dataset');
model.nodeGroup('datagrp').label('MTF Data');

model.physics('gop').prop('WavelengthDistribution').setIndex('WavelengthDistribution', 'Monochromatic', 0);
model.physics('gop').feature('op1').set('lambda0', '550[nm]');

model.study('std1').run;

model.result.numerical.create('gevMTF', 'EvalGlobal');
model.result.numerical('gevMTF').label('gevMTF');

model.nodeGroup('numgrp').add('numerical', 'gevMTF');

model.result.numerical('gevMTF').set('data', 'ray1');
model.result.numerical('gevMTF').set('innerinput', 'last');
model.result.numerical('gevMTF').set('expr', {});
model.result.numerical('gevMTF').set('descr', {});
model.result.numerical('gevMTF').setIndex('expr', 'gop.relg1.rmaxall', 0);

model.func.create('Lcosx1', 'Analytic');
model.func('Lcosx1').label('Lcosx1');

model.nodeGroup('mtfgrp1').add('func', 'Lcosx1');

model.func('Lcosx1').set('funcname', 'Lcosx1');
model.func('Lcosx1').set('expr', 'LSFx1(x)*cos(2*pi*nu*x/1e3)');
model.func('Lcosx1').set('args', 'x, nu');
model.func('Lcosx1').setIndex('plotargs', -6.371340201874388, 0, 1);
model.func('Lcosx1').setIndex('plotargs', 6.371340201874388, 0, 2);
model.func('Lcosx1').setIndex('plotargs', 0, 1, 1);
model.func('Lcosx1').setIndex('plotargs', '125', 1, 2);
model.func.create('Lsinx1', 'Analytic');
model.func('Lsinx1').label('Lsinx1');

model.nodeGroup('mtfgrp1').add('func', 'Lsinx1');

model.func('Lsinx1').set('funcname', 'Lsinx1');
model.func('Lsinx1').set('expr', 'LSFx1(x)*sin(2*pi*nu*x/1e3)');
model.func('Lsinx1').set('args', 'x, nu');
model.func('Lsinx1').setIndex('plotargs', -6.371340201874388, 0, 1);
model.func('Lsinx1').setIndex('plotargs', 6.371340201874388, 0, 2);
model.func('Lsinx1').setIndex('plotargs', 0, 1, 1);
model.func('Lsinx1').setIndex('plotargs', '125', 1, 2);

model.result.numerical.create('gevLSFx1', 'EvalGlobal');
model.result.numerical('gevLSFx1').label('gevLSFx1');

model.nodeGroup('numgrp').add('numerical', 'gevLSFx1');

model.result.numerical('gevLSFx1').set('data', 'ray1');
model.result.numerical('gevLSFx1').set('innerinput', 'last');
model.result.numerical('gevLSFx1').set('expr', {});
model.result.numerical('gevLSFx1').set('descr', {});
model.result.numerical('gevLSFx1').setIndex('expr', 'gop.sum((1e6*(qx-gop.relg1.qavex)>-6.516143388280624)&&(1e6*(qx-gop.relg1.qavex)<=-6.2265370154681525)&&gop.prf==1)', 0);
model.result.numerical('gevLSFx1').setIndex('expr', 'gop.sum((1e6*(qx-gop.relg1.qavex)>-6.226537015468152)&&(1e6*(qx-gop.relg1.qavex)<=-5.93693064265568)&&gop.prf==1)', 1);
model.result.numerical('gevLSFx1').setIndex('expr', 'gop.sum((1e6*(qx-gop.relg1.qavex)>-5.93693064265568)&&(1e6*(qx-gop.relg1.qavex)<=-5.6473242698432085)&&gop.prf==1)', 2);
model.result.numerical('gevLSFx1').setIndex('expr', 'gop.sum((1e6*(qx-gop.relg1.qavex)>-5.647324269843208)&&(1e6*(qx-gop.relg1.qavex)<=-5.357717897030736)&&gop.prf==1)', 3);
model.result.numerical('gevLSFx1').setIndex('expr', 'gop.sum((1e6*(qx-gop.relg1.qavex)>-5.357717897030735)&&(1e6*(qx-gop.relg1.qavex)<=-5.0681115242182635)&&gop.prf==1)', 4);
model.result.numerical('gevLSFx1').setIndex('expr', 'gop.sum((1e6*(qx-gop.relg1.qavex)>-5.0681115242182635)&&(1e6*(qx-gop.relg1.qavex)<=-4.778505151405792)&&gop.prf==1)', 5);
model.result.numerical('gevLSFx1').setIndex('expr', 'gop.sum((1e6*(qx-gop.relg1.qavex)>-4.778505151405791)&&(1e6*(qx-gop.relg1.qavex)<=-4.488898778593319)&&gop.prf==1)', 6);
model.result.numerical('gevLSFx1').setIndex('expr', 'gop.sum((1e6*(qx-gop.relg1.qavex)>-4.4888987785933185)&&(1e6*(qx-gop.relg1.qavex)<=-4.199292405780847)&&gop.prf==1)', 7);
model.result.numerical('gevLSFx1').setIndex('expr', 'gop.sum((1e6*(qx-gop.relg1.qavex)>-4.199292405780847)&&(1e6*(qx-gop.relg1.qavex)<=-3.909686032968375)&&gop.prf==1)', 8);
model.result.numerical('gevLSFx1').setIndex('expr', 'gop.sum((1e6*(qx-gop.relg1.qavex)>-3.909686032968375)&&(1e6*(qx-gop.relg1.qavex)<=-3.6200796601559024)&&gop.prf==1)', 9);
model.result.numerical('gevLSFx1').setIndex('expr', 'gop.sum((1e6*(qx-gop.relg1.qavex)>-3.6200796601559024)&&(1e6*(qx-gop.relg1.qavex)<=-3.33047328734343)&&gop.prf==1)', 10);
model.result.numerical('gevLSFx1').setIndex('expr', 'gop.sum((1e6*(qx-gop.relg1.qavex)>-3.3304732873434304)&&(1e6*(qx-gop.relg1.qavex)<=-3.040866914530958)&&gop.prf==1)', 11);
model.result.numerical('gevLSFx1').setIndex('expr', 'gop.sum((1e6*(qx-gop.relg1.qavex)>-3.0408669145309584)&&(1e6*(qx-gop.relg1.qavex)<=-2.751260541718486)&&gop.prf==1)', 12);
model.result.numerical('gevLSFx1').setIndex('expr', 'gop.sum((1e6*(qx-gop.relg1.qavex)>-2.751260541718486)&&(1e6*(qx-gop.relg1.qavex)<=-2.4616541689060134)&&gop.prf==1)', 13);
model.result.numerical('gevLSFx1').setIndex('expr', 'gop.sum((1e6*(qx-gop.relg1.qavex)>-2.4616541689060134)&&(1e6*(qx-gop.relg1.qavex)<=-2.172047796093541)&&gop.prf==1)', 14);
model.result.numerical('gevLSFx1').setIndex('expr', 'gop.sum((1e6*(qx-gop.relg1.qavex)>-2.172047796093542)&&(1e6*(qx-gop.relg1.qavex)<=-1.8824414232810696)&&gop.prf==1)', 15);
model.result.numerical('gevLSFx1').setIndex('expr', 'gop.sum((1e6*(qx-gop.relg1.qavex)>-1.8824414232810691)&&(1e6*(qx-gop.relg1.qavex)<=-1.592835050468597)&&gop.prf==1)', 16);
model.result.numerical('gevLSFx1').setIndex('expr', 'gop.sum((1e6*(qx-gop.relg1.qavex)>-1.5928350504685966)&&(1e6*(qx-gop.relg1.qavex)<=-1.3032286776561246)&&gop.prf==1)', 17);
model.result.numerical('gevLSFx1').setIndex('expr', 'gop.sum((1e6*(qx-gop.relg1.qavex)>-1.303228677656125)&&(1e6*(qx-gop.relg1.qavex)<=-1.013622304843653)&&gop.prf==1)', 18);
model.result.numerical('gevLSFx1').setIndex('expr', 'gop.sum((1e6*(qx-gop.relg1.qavex)>-1.0136223048436526)&&(1e6*(qx-gop.relg1.qavex)<=-0.7240159320311804)&&gop.prf==1)', 19);
model.result.numerical('gevLSFx1').setIndex('expr', 'gop.sum((1e6*(qx-gop.relg1.qavex)>-0.7240159320311802)&&(1e6*(qx-gop.relg1.qavex)<=-0.43440955921870794)&&gop.prf==1)', 20);
model.result.numerical('gevLSFx1').setIndex('expr', 'gop.sum((1e6*(qx-gop.relg1.qavex)>-0.4344095592187086)&&(1e6*(qx-gop.relg1.qavex)<=-0.14480318640623638)&&gop.prf==1)', 21);
model.result.numerical('gevLSFx1').setIndex('expr', 'gop.sum((1e6*(qx-gop.relg1.qavex)>-0.1448031864062361)&&(1e6*(qx-gop.relg1.qavex)<=0.1448031864062361)&&gop.prf==1)', 22);
model.result.numerical('gevLSFx1').setIndex('expr', 'gop.sum((1e6*(qx-gop.relg1.qavex)>0.14480318640623638)&&(1e6*(qx-gop.relg1.qavex)<=0.4344095592187086)&&gop.prf==1)', 23);
model.result.numerical('gevLSFx1').setIndex('expr', 'gop.sum((1e6*(qx-gop.relg1.qavex)>0.43440955921870794)&&(1e6*(qx-gop.relg1.qavex)<=0.7240159320311802)&&gop.prf==1)', 24);
model.result.numerical('gevLSFx1').setIndex('expr', 'gop.sum((1e6*(qx-gop.relg1.qavex)>0.7240159320311804)&&(1e6*(qx-gop.relg1.qavex)<=1.0136223048436526)&&gop.prf==1)', 25);
model.result.numerical('gevLSFx1').setIndex('expr', 'gop.sum((1e6*(qx-gop.relg1.qavex)>1.013622304843653)&&(1e6*(qx-gop.relg1.qavex)<=1.303228677656125)&&gop.prf==1)', 26);
model.result.numerical('gevLSFx1').setIndex('expr', 'gop.sum((1e6*(qx-gop.relg1.qavex)>1.3032286776561255)&&(1e6*(qx-gop.relg1.qavex)<=1.5928350504685975)&&gop.prf==1)', 27);
model.result.numerical('gevLSFx1').setIndex('expr', 'gop.sum((1e6*(qx-gop.relg1.qavex)>1.592835050468598)&&(1e6*(qx-gop.relg1.qavex)<=1.88244142328107)&&gop.prf==1)', 28);
model.result.numerical('gevLSFx1').setIndex('expr', 'gop.sum((1e6*(qx-gop.relg1.qavex)>1.8824414232810696)&&(1e6*(qx-gop.relg1.qavex)<=2.172047796093542)&&gop.prf==1)', 29);
model.result.numerical('gevLSFx1').setIndex('expr', 'gop.sum((1e6*(qx-gop.relg1.qavex)>2.172047796093541)&&(1e6*(qx-gop.relg1.qavex)<=2.4616541689060134)&&gop.prf==1)', 30);
model.result.numerical('gevLSFx1').setIndex('expr', 'gop.sum((1e6*(qx-gop.relg1.qavex)>2.4616541689060143)&&(1e6*(qx-gop.relg1.qavex)<=2.7512605417184868)&&gop.prf==1)', 31);
model.result.numerical('gevLSFx1').setIndex('expr', 'gop.sum((1e6*(qx-gop.relg1.qavex)>2.751260541718486)&&(1e6*(qx-gop.relg1.qavex)<=3.0408669145309584)&&gop.prf==1)', 32);
model.result.numerical('gevLSFx1').setIndex('expr', 'gop.sum((1e6*(qx-gop.relg1.qavex)>3.0408669145309575)&&(1e6*(qx-gop.relg1.qavex)<=3.33047328734343)&&gop.prf==1)', 33);
model.result.numerical('gevLSFx1').setIndex('expr', 'gop.sum((1e6*(qx-gop.relg1.qavex)>3.330473287343431)&&(1e6*(qx-gop.relg1.qavex)<=3.6200796601559033)&&gop.prf==1)', 34);
model.result.numerical('gevLSFx1').setIndex('expr', 'gop.sum((1e6*(qx-gop.relg1.qavex)>3.6200796601559024)&&(1e6*(qx-gop.relg1.qavex)<=3.909686032968375)&&gop.prf==1)', 35);
model.result.numerical('gevLSFx1').setIndex('expr', 'gop.sum((1e6*(qx-gop.relg1.qavex)>3.909686032968374)&&(1e6*(qx-gop.relg1.qavex)<=4.199292405780846)&&gop.prf==1)', 36);
model.result.numerical('gevLSFx1').setIndex('expr', 'gop.sum((1e6*(qx-gop.relg1.qavex)>4.199292405780848)&&(1e6*(qx-gop.relg1.qavex)<=4.488898778593319)&&gop.prf==1)', 37);
model.result.numerical('gevLSFx1').setIndex('expr', 'gop.sum((1e6*(qx-gop.relg1.qavex)>4.488898778593319)&&(1e6*(qx-gop.relg1.qavex)<=4.778505151405791)&&gop.prf==1)', 38);
model.result.numerical('gevLSFx1').setIndex('expr', 'gop.sum((1e6*(qx-gop.relg1.qavex)>4.778505151405791)&&(1e6*(qx-gop.relg1.qavex)<=5.068111524218263)&&gop.prf==1)', 39);
model.result.numerical('gevLSFx1').setIndex('expr', 'gop.sum((1e6*(qx-gop.relg1.qavex)>5.068111524218264)&&(1e6*(qx-gop.relg1.qavex)<=5.357717897030736)&&gop.prf==1)', 40);
model.result.numerical('gevLSFx1').setIndex('expr', 'gop.sum((1e6*(qx-gop.relg1.qavex)>5.357717897030736)&&(1e6*(qx-gop.relg1.qavex)<=5.647324269843208)&&gop.prf==1)', 41);
model.result.numerical('gevLSFx1').setIndex('expr', 'gop.sum((1e6*(qx-gop.relg1.qavex)>5.647324269843208)&&(1e6*(qx-gop.relg1.qavex)<=5.936930642655679)&&gop.prf==1)', 42);
model.result.numerical('gevLSFx1').setIndex('expr', 'gop.sum((1e6*(qx-gop.relg1.qavex)>5.936930642655681)&&(1e6*(qx-gop.relg1.qavex)<=6.2265370154681525)&&gop.prf==1)', 43);
model.result.numerical('gevLSFx1').setIndex('expr', 'gop.sum((1e6*(qx-gop.relg1.qavex)>6.2265370154681525)&&(1e6*(qx-gop.relg1.qavex)<=6.516143388280624)&&gop.prf==1)', 44);

model.func.create('LSFx1', 'Interpolation');
model.func('LSFx1').label('LSFx1');

model.nodeGroup('mtfgrp1').add('func', 'LSFx1');

model.func('LSFx1').set('funcname', 'LSFx1');
model.func('LSFx1').set('interp', 'piecewisecubic');
model.func('LSFx1').set('extrap', 'const');
model.func('LSFx1').set('defineprimfun', true);
model.func('LSFx1').set('table', {});
model.func('LSFx1').setIndex('table', -6.371340201874388, 0, 0);
model.func('LSFx1').setIndex('table', 0, 0, 1);
model.func('LSFx1').setIndex('table', -6.081733829061916, 1, 0);
model.func('LSFx1').setIndex('table', 0.08860759493670886, 1, 1);
model.func('LSFx1').setIndex('table', -5.792127456249444, 2, 0);
model.func('LSFx1').setIndex('table', 0.189873417721519, 2, 1);
model.func('LSFx1').setIndex('table', -5.502521083436972, 3, 0);
model.func('LSFx1').setIndex('table', 0.12658227848101267, 3, 1);
model.func('LSFx1').setIndex('table', -5.212914710624499, 4, 0);
model.func('LSFx1').setIndex('table', 0.16455696202531644, 4, 1);
model.func('LSFx1').setIndex('table', -4.923308337812028, 5, 0);
model.func('LSFx1').setIndex('table', 0.14767932489451477, 5, 1);
model.func('LSFx1').setIndex('table', -4.633701964999555, 6, 0);
model.func('LSFx1').setIndex('table', 0.14345991561181434, 6, 1);
model.func('LSFx1').setIndex('table', -4.344095592187083, 7, 0);
model.func('LSFx1').setIndex('table', 0.13924050632911392, 7, 1);
model.func('LSFx1').setIndex('table', -4.054489219374611, 8, 0);
model.func('LSFx1').setIndex('table', 0.1518987341772152, 8, 1);
model.func('LSFx1').setIndex('table', -3.7648828465621387, 9, 0);
model.func('LSFx1').setIndex('table', 0.10970464135021098, 9, 1);
model.func('LSFx1').setIndex('table', -3.475276473749666, 10, 0);
model.func('LSFx1').setIndex('table', 0.189873417721519, 10, 1);
model.func('LSFx1').setIndex('table', -3.185670100937194, 11, 0);
model.func('LSFx1').setIndex('table', 0.12658227848101267, 11, 1);
model.func('LSFx1').setIndex('table', -2.896063728124722, 12, 0);
model.func('LSFx1').setIndex('table', 0.19831223628691982, 12, 1);
model.func('LSFx1').setIndex('table', -2.6064573553122496, 13, 0);
model.func('LSFx1').setIndex('table', 0.14767932489451477, 13, 1);
model.func('LSFx1').setIndex('table', -2.316850982499777, 14, 0);
model.func('LSFx1').setIndex('table', 0.20253164556962025, 14, 1);
model.func('LSFx1').setIndex('table', -2.0272446096873056, 15, 0);
model.func('LSFx1').setIndex('table', 0.2109704641350211, 15, 1);
model.func('LSFx1').setIndex('table', -1.737638236874833, 16, 0);
model.func('LSFx1').setIndex('table', 0.4219409282700422, 16, 1);
model.func('LSFx1').setIndex('table', -1.4480318640623606, 17, 0);
model.func('LSFx1').setIndex('table', 0.4050632911392405, 17, 1);
model.func('LSFx1').setIndex('table', -1.158425491249889, 18, 0);
model.func('LSFx1').setIndex('table', 0.46835443037974683, 18, 1);
model.func('LSFx1').setIndex('table', -0.8688191184374165, 19, 0);
model.func('LSFx1').setIndex('table', 0.540084388185654, 19, 1);
model.func('LSFx1').setIndex('table', -0.5792127456249441, 20, 0);
model.func('LSFx1').setIndex('table', 0.5611814345991561, 20, 1);
model.func('LSFx1').setIndex('table', -0.2896063728124725, 21, 0);
model.func('LSFx1').setIndex('table', 0.6540084388185654, 21, 1);
model.func('LSFx1').setIndex('table', 0, 22, 0);
model.func('LSFx1').setIndex('table', 1, 22, 1);
model.func('LSFx1').setIndex('table', 0.2896063728124725, 23, 0);
model.func('LSFx1').setIndex('table', 0.6540084388185654, 23, 1);
model.func('LSFx1').setIndex('table', 0.5792127456249441, 24, 0);
model.func('LSFx1').setIndex('table', 0.5611814345991561, 24, 1);
model.func('LSFx1').setIndex('table', 0.8688191184374165, 25, 0);
model.func('LSFx1').setIndex('table', 0.540084388185654, 25, 1);
model.func('LSFx1').setIndex('table', 1.158425491249889, 26, 0);
model.func('LSFx1').setIndex('table', 0.46835443037974683, 26, 1);
model.func('LSFx1').setIndex('table', 1.4480318640623615, 27, 0);
model.func('LSFx1').setIndex('table', 0.4050632911392405, 27, 1);
model.func('LSFx1').setIndex('table', 1.737638236874834, 28, 0);
model.func('LSFx1').setIndex('table', 0.4219409282700422, 28, 1);
model.func('LSFx1').setIndex('table', 2.0272446096873056, 29, 0);
model.func('LSFx1').setIndex('table', 0.2109704641350211, 29, 1);
model.func('LSFx1').setIndex('table', 2.316850982499777, 30, 0);
model.func('LSFx1').setIndex('table', 0.20253164556962025, 30, 1);
model.func('LSFx1').setIndex('table', 2.6064573553122505, 31, 0);
model.func('LSFx1').setIndex('table', 0.14767932489451477, 31, 1);
model.func('LSFx1').setIndex('table', 2.896063728124722, 32, 0);
model.func('LSFx1').setIndex('table', 0.19831223628691982, 32, 1);
model.func('LSFx1').setIndex('table', 3.1856701009371937, 33, 0);
model.func('LSFx1').setIndex('table', 0.12658227848101267, 33, 1);
model.func('LSFx1').setIndex('table', 3.475276473749667, 34, 0);
model.func('LSFx1').setIndex('table', 0.189873417721519, 34, 1);
model.func('LSFx1').setIndex('table', 3.7648828465621387, 35, 0);
model.func('LSFx1').setIndex('table', 0.10970464135021098, 35, 1);
model.func('LSFx1').setIndex('table', 4.05448921937461, 36, 0);
model.func('LSFx1').setIndex('table', 0.1518987341772152, 36, 1);
model.func('LSFx1').setIndex('table', 4.344095592187084, 37, 0);
model.func('LSFx1').setIndex('table', 0.13924050632911392, 37, 1);
model.func('LSFx1').setIndex('table', 4.633701964999555, 38, 0);
model.func('LSFx1').setIndex('table', 0.14345991561181434, 38, 1);
model.func('LSFx1').setIndex('table', 4.923308337812027, 39, 0);
model.func('LSFx1').setIndex('table', 0.14345991561181434, 39, 1);
model.func('LSFx1').setIndex('table', 5.2129147106245, 40, 0);
model.func('LSFx1').setIndex('table', 0.16877637130801687, 40, 1);
model.func('LSFx1').setIndex('table', 5.502521083436972, 41, 0);
model.func('LSFx1').setIndex('table', 0.12658227848101267, 41, 1);
model.func('LSFx1').setIndex('table', 5.792127456249443, 42, 0);
model.func('LSFx1').setIndex('table', 0.18565400843881857, 42, 1);
model.func('LSFx1').setIndex('table', 6.081733829061917, 43, 0);
model.func('LSFx1').setIndex('table', 0.09282700421940929, 43, 1);
model.func('LSFx1').setIndex('table', 6.371340201874388, 44, 0);
model.func('LSFx1').setIndex('table', 0, 44, 1);

model.result.dataset.create('lsfx1', 'Grid1D');
model.result.dataset('lsfx1').label('LSFx1');

model.nodeGroup('datagrp').add('dataset', 'lsfx1');

model.result.dataset('lsfx1').set('source', 'function');
model.result.dataset('lsfx1').set('function', 'LSFx1');
model.result.dataset('lsfx1').set('parmin1', '-6.371340201874388');
model.result.dataset('lsfx1').set('parmax1', '6.371340201874388');
model.result.dataset('lsfx1').set('par1', 'x_out');

model.func.create('Lcosy1', 'Analytic');
model.func('Lcosy1').label('Lcosy1');

model.nodeGroup('mtfgrp1').add('func', 'Lcosy1');

model.func('Lcosy1').set('funcname', 'Lcosy1');
model.func('Lcosy1').set('expr', 'LSFy1(y)*cos(2*pi*nu*y/1e3)');
model.func('Lcosy1').set('args', 'y, nu');
model.func('Lcosy1').setIndex('plotargs', -6.371340201874388, 0, 1);
model.func('Lcosy1').setIndex('plotargs', 6.371340201874388, 0, 2);
model.func('Lcosy1').setIndex('plotargs', 0, 1, 1);
model.func('Lcosy1').setIndex('plotargs', '125', 1, 2);
model.func.create('Lsiny1', 'Analytic');
model.func('Lsiny1').label('Lsiny1');

model.nodeGroup('mtfgrp1').add('func', 'Lsiny1');

model.func('Lsiny1').set('funcname', 'Lsiny1');
model.func('Lsiny1').set('expr', 'LSFy1(y)*sin(2*pi*nu*y/1e3)');
model.func('Lsiny1').set('args', 'y, nu');
model.func('Lsiny1').setIndex('plotargs', -6.371340201874388, 0, 1);
model.func('Lsiny1').setIndex('plotargs', 6.371340201874388, 0, 2);
model.func('Lsiny1').setIndex('plotargs', 0, 1, 1);
model.func('Lsiny1').setIndex('plotargs', '125', 1, 2);

model.result.numerical.create('gevLSFy1', 'EvalGlobal');
model.result.numerical('gevLSFy1').label('gevLSFy1');

model.nodeGroup('numgrp').add('numerical', 'gevLSFy1');

model.result.numerical('gevLSFy1').set('data', 'ray1');
model.result.numerical('gevLSFy1').set('innerinput', 'last');
model.result.numerical('gevLSFy1').set('expr', {});
model.result.numerical('gevLSFy1').set('descr', {});
model.result.numerical('gevLSFy1').setIndex('expr', 'gop.sum((1e6*(qy-gop.relg1.qavey)>-6.516143388280624)&&(1e6*(qy-gop.relg1.qavey)<=-6.2265370154681525)&&gop.prf==1)', 0);
model.result.numerical('gevLSFy1').setIndex('expr', 'gop.sum((1e6*(qy-gop.relg1.qavey)>-6.226537015468152)&&(1e6*(qy-gop.relg1.qavey)<=-5.93693064265568)&&gop.prf==1)', 1);
model.result.numerical('gevLSFy1').setIndex('expr', 'gop.sum((1e6*(qy-gop.relg1.qavey)>-5.93693064265568)&&(1e6*(qy-gop.relg1.qavey)<=-5.6473242698432085)&&gop.prf==1)', 2);
model.result.numerical('gevLSFy1').setIndex('expr', 'gop.sum((1e6*(qy-gop.relg1.qavey)>-5.647324269843208)&&(1e6*(qy-gop.relg1.qavey)<=-5.357717897030736)&&gop.prf==1)', 3);
model.result.numerical('gevLSFy1').setIndex('expr', 'gop.sum((1e6*(qy-gop.relg1.qavey)>-5.357717897030735)&&(1e6*(qy-gop.relg1.qavey)<=-5.0681115242182635)&&gop.prf==1)', 4);
model.result.numerical('gevLSFy1').setIndex('expr', 'gop.sum((1e6*(qy-gop.relg1.qavey)>-5.0681115242182635)&&(1e6*(qy-gop.relg1.qavey)<=-4.778505151405792)&&gop.prf==1)', 5);
model.result.numerical('gevLSFy1').setIndex('expr', 'gop.sum((1e6*(qy-gop.relg1.qavey)>-4.778505151405791)&&(1e6*(qy-gop.relg1.qavey)<=-4.488898778593319)&&gop.prf==1)', 6);
model.result.numerical('gevLSFy1').setIndex('expr', 'gop.sum((1e6*(qy-gop.relg1.qavey)>-4.4888987785933185)&&(1e6*(qy-gop.relg1.qavey)<=-4.199292405780847)&&gop.prf==1)', 7);
model.result.numerical('gevLSFy1').setIndex('expr', 'gop.sum((1e6*(qy-gop.relg1.qavey)>-4.199292405780847)&&(1e6*(qy-gop.relg1.qavey)<=-3.909686032968375)&&gop.prf==1)', 8);
model.result.numerical('gevLSFy1').setIndex('expr', 'gop.sum((1e6*(qy-gop.relg1.qavey)>-3.909686032968375)&&(1e6*(qy-gop.relg1.qavey)<=-3.6200796601559024)&&gop.prf==1)', 9);
model.result.numerical('gevLSFy1').setIndex('expr', 'gop.sum((1e6*(qy-gop.relg1.qavey)>-3.6200796601559024)&&(1e6*(qy-gop.relg1.qavey)<=-3.33047328734343)&&gop.prf==1)', 10);
model.result.numerical('gevLSFy1').setIndex('expr', 'gop.sum((1e6*(qy-gop.relg1.qavey)>-3.3304732873434304)&&(1e6*(qy-gop.relg1.qavey)<=-3.040866914530958)&&gop.prf==1)', 11);
model.result.numerical('gevLSFy1').setIndex('expr', 'gop.sum((1e6*(qy-gop.relg1.qavey)>-3.0408669145309584)&&(1e6*(qy-gop.relg1.qavey)<=-2.751260541718486)&&gop.prf==1)', 12);
model.result.numerical('gevLSFy1').setIndex('expr', 'gop.sum((1e6*(qy-gop.relg1.qavey)>-2.751260541718486)&&(1e6*(qy-gop.relg1.qavey)<=-2.4616541689060134)&&gop.prf==1)', 13);
model.result.numerical('gevLSFy1').setIndex('expr', 'gop.sum((1e6*(qy-gop.relg1.qavey)>-2.4616541689060134)&&(1e6*(qy-gop.relg1.qavey)<=-2.172047796093541)&&gop.prf==1)', 14);
model.result.numerical('gevLSFy1').setIndex('expr', 'gop.sum((1e6*(qy-gop.relg1.qavey)>-2.172047796093542)&&(1e6*(qy-gop.relg1.qavey)<=-1.8824414232810696)&&gop.prf==1)', 15);
model.result.numerical('gevLSFy1').setIndex('expr', 'gop.sum((1e6*(qy-gop.relg1.qavey)>-1.8824414232810691)&&(1e6*(qy-gop.relg1.qavey)<=-1.592835050468597)&&gop.prf==1)', 16);
model.result.numerical('gevLSFy1').setIndex('expr', 'gop.sum((1e6*(qy-gop.relg1.qavey)>-1.5928350504685966)&&(1e6*(qy-gop.relg1.qavey)<=-1.3032286776561246)&&gop.prf==1)', 17);
model.result.numerical('gevLSFy1').setIndex('expr', 'gop.sum((1e6*(qy-gop.relg1.qavey)>-1.303228677656125)&&(1e6*(qy-gop.relg1.qavey)<=-1.013622304843653)&&gop.prf==1)', 18);
model.result.numerical('gevLSFy1').setIndex('expr', 'gop.sum((1e6*(qy-gop.relg1.qavey)>-1.0136223048436526)&&(1e6*(qy-gop.relg1.qavey)<=-0.7240159320311804)&&gop.prf==1)', 19);
model.result.numerical('gevLSFy1').setIndex('expr', 'gop.sum((1e6*(qy-gop.relg1.qavey)>-0.7240159320311802)&&(1e6*(qy-gop.relg1.qavey)<=-0.43440955921870794)&&gop.prf==1)', 20);
model.result.numerical('gevLSFy1').setIndex('expr', 'gop.sum((1e6*(qy-gop.relg1.qavey)>-0.4344095592187086)&&(1e6*(qy-gop.relg1.qavey)<=-0.14480318640623638)&&gop.prf==1)', 21);
model.result.numerical('gevLSFy1').setIndex('expr', 'gop.sum((1e6*(qy-gop.relg1.qavey)>-0.1448031864062361)&&(1e6*(qy-gop.relg1.qavey)<=0.1448031864062361)&&gop.prf==1)', 22);
model.result.numerical('gevLSFy1').setIndex('expr', 'gop.sum((1e6*(qy-gop.relg1.qavey)>0.14480318640623638)&&(1e6*(qy-gop.relg1.qavey)<=0.4344095592187086)&&gop.prf==1)', 23);
model.result.numerical('gevLSFy1').setIndex('expr', 'gop.sum((1e6*(qy-gop.relg1.qavey)>0.43440955921870794)&&(1e6*(qy-gop.relg1.qavey)<=0.7240159320311802)&&gop.prf==1)', 24);
model.result.numerical('gevLSFy1').setIndex('expr', 'gop.sum((1e6*(qy-gop.relg1.qavey)>0.7240159320311804)&&(1e6*(qy-gop.relg1.qavey)<=1.0136223048436526)&&gop.prf==1)', 25);
model.result.numerical('gevLSFy1').setIndex('expr', 'gop.sum((1e6*(qy-gop.relg1.qavey)>1.013622304843653)&&(1e6*(qy-gop.relg1.qavey)<=1.303228677656125)&&gop.prf==1)', 26);
model.result.numerical('gevLSFy1').setIndex('expr', 'gop.sum((1e6*(qy-gop.relg1.qavey)>1.3032286776561255)&&(1e6*(qy-gop.relg1.qavey)<=1.5928350504685975)&&gop.prf==1)', 27);
model.result.numerical('gevLSFy1').setIndex('expr', 'gop.sum((1e6*(qy-gop.relg1.qavey)>1.592835050468598)&&(1e6*(qy-gop.relg1.qavey)<=1.88244142328107)&&gop.prf==1)', 28);
model.result.numerical('gevLSFy1').setIndex('expr', 'gop.sum((1e6*(qy-gop.relg1.qavey)>1.8824414232810696)&&(1e6*(qy-gop.relg1.qavey)<=2.172047796093542)&&gop.prf==1)', 29);
model.result.numerical('gevLSFy1').setIndex('expr', 'gop.sum((1e6*(qy-gop.relg1.qavey)>2.172047796093541)&&(1e6*(qy-gop.relg1.qavey)<=2.4616541689060134)&&gop.prf==1)', 30);
model.result.numerical('gevLSFy1').setIndex('expr', 'gop.sum((1e6*(qy-gop.relg1.qavey)>2.4616541689060143)&&(1e6*(qy-gop.relg1.qavey)<=2.7512605417184868)&&gop.prf==1)', 31);
model.result.numerical('gevLSFy1').setIndex('expr', 'gop.sum((1e6*(qy-gop.relg1.qavey)>2.751260541718486)&&(1e6*(qy-gop.relg1.qavey)<=3.0408669145309584)&&gop.prf==1)', 32);
model.result.numerical('gevLSFy1').setIndex('expr', 'gop.sum((1e6*(qy-gop.relg1.qavey)>3.0408669145309575)&&(1e6*(qy-gop.relg1.qavey)<=3.33047328734343)&&gop.prf==1)', 33);
model.result.numerical('gevLSFy1').setIndex('expr', 'gop.sum((1e6*(qy-gop.relg1.qavey)>3.330473287343431)&&(1e6*(qy-gop.relg1.qavey)<=3.6200796601559033)&&gop.prf==1)', 34);
model.result.numerical('gevLSFy1').setIndex('expr', 'gop.sum((1e6*(qy-gop.relg1.qavey)>3.6200796601559024)&&(1e6*(qy-gop.relg1.qavey)<=3.909686032968375)&&gop.prf==1)', 35);
model.result.numerical('gevLSFy1').setIndex('expr', 'gop.sum((1e6*(qy-gop.relg1.qavey)>3.909686032968374)&&(1e6*(qy-gop.relg1.qavey)<=4.199292405780846)&&gop.prf==1)', 36);
model.result.numerical('gevLSFy1').setIndex('expr', 'gop.sum((1e6*(qy-gop.relg1.qavey)>4.199292405780848)&&(1e6*(qy-gop.relg1.qavey)<=4.488898778593319)&&gop.prf==1)', 37);
model.result.numerical('gevLSFy1').setIndex('expr', 'gop.sum((1e6*(qy-gop.relg1.qavey)>4.488898778593319)&&(1e6*(qy-gop.relg1.qavey)<=4.778505151405791)&&gop.prf==1)', 38);
model.result.numerical('gevLSFy1').setIndex('expr', 'gop.sum((1e6*(qy-gop.relg1.qavey)>4.778505151405791)&&(1e6*(qy-gop.relg1.qavey)<=5.068111524218263)&&gop.prf==1)', 39);
model.result.numerical('gevLSFy1').setIndex('expr', 'gop.sum((1e6*(qy-gop.relg1.qavey)>5.068111524218264)&&(1e6*(qy-gop.relg1.qavey)<=5.357717897030736)&&gop.prf==1)', 40);
model.result.numerical('gevLSFy1').setIndex('expr', 'gop.sum((1e6*(qy-gop.relg1.qavey)>5.357717897030736)&&(1e6*(qy-gop.relg1.qavey)<=5.647324269843208)&&gop.prf==1)', 41);
model.result.numerical('gevLSFy1').setIndex('expr', 'gop.sum((1e6*(qy-gop.relg1.qavey)>5.647324269843208)&&(1e6*(qy-gop.relg1.qavey)<=5.936930642655679)&&gop.prf==1)', 42);
model.result.numerical('gevLSFy1').setIndex('expr', 'gop.sum((1e6*(qy-gop.relg1.qavey)>5.936930642655681)&&(1e6*(qy-gop.relg1.qavey)<=6.2265370154681525)&&gop.prf==1)', 43);
model.result.numerical('gevLSFy1').setIndex('expr', 'gop.sum((1e6*(qy-gop.relg1.qavey)>6.2265370154681525)&&(1e6*(qy-gop.relg1.qavey)<=6.516143388280624)&&gop.prf==1)', 44);

model.func.create('LSFy1', 'Interpolation');
model.func('LSFy1').label('LSFy1');

model.nodeGroup('mtfgrp1').add('func', 'LSFy1');

model.func('LSFy1').set('funcname', 'LSFy1');
model.func('LSFy1').set('interp', 'piecewisecubic');
model.func('LSFy1').set('extrap', 'const');
model.func('LSFy1').set('defineprimfun', true);
model.func('LSFy1').set('table', {});
model.func('LSFy1').setIndex('table', -6.371340201874388, 0, 0);
model.func('LSFy1').setIndex('table', 0, 0, 1);
model.func('LSFy1').setIndex('table', -6.081733829061916, 1, 0);
model.func('LSFy1').setIndex('table', 0.09012875536480687, 1, 1);
model.func('LSFy1').setIndex('table', -5.792127456249444, 2, 0);
model.func('LSFy1').setIndex('table', 0.19742489270386265, 2, 1);
model.func('LSFy1').setIndex('table', -5.502521083436972, 3, 0);
model.func('LSFy1').setIndex('table', 0.13304721030042918, 3, 1);
model.func('LSFy1').setIndex('table', -5.212914710624499, 4, 0);
model.func('LSFy1').setIndex('table', 0.15879828326180256, 4, 1);
model.func('LSFy1').setIndex('table', -4.923308337812028, 5, 0);
model.func('LSFy1').setIndex('table', 0.13733905579399142, 5, 1);
model.func('LSFy1').setIndex('table', -4.633701964999555, 6, 0);
model.func('LSFy1').setIndex('table', 0.15021459227467812, 6, 1);
model.func('LSFy1').setIndex('table', -4.344095592187083, 7, 0);
model.func('LSFy1').setIndex('table', 0.13733905579399142, 7, 1);
model.func('LSFy1').setIndex('table', -4.054489219374611, 8, 0);
model.func('LSFy1').setIndex('table', 0.1630901287553648, 8, 1);
model.func('LSFy1').setIndex('table', -3.7648828465621387, 9, 0);
model.func('LSFy1').setIndex('table', 0.12017167381974249, 9, 1);
model.func('LSFy1').setIndex('table', -3.475276473749666, 10, 0);
model.func('LSFy1').setIndex('table', 0.1888412017167382, 10, 1);
model.func('LSFy1').setIndex('table', -3.185670100937194, 11, 0);
model.func('LSFy1').setIndex('table', 0.12017167381974249, 11, 1);
model.func('LSFy1').setIndex('table', -2.896063728124722, 12, 0);
model.func('LSFy1').setIndex('table', 0.2017167381974249, 12, 1);
model.func('LSFy1').setIndex('table', -2.6064573553122496, 13, 0);
model.func('LSFy1').setIndex('table', 0.1630901287553648, 13, 1);
model.func('LSFy1').setIndex('table', -2.316850982499777, 14, 0);
model.func('LSFy1').setIndex('table', 0.19313304721030042, 14, 1);
model.func('LSFy1').setIndex('table', -2.0272446096873056, 15, 0);
model.func('LSFy1').setIndex('table', 0.22317596566523606, 15, 1);
model.func('LSFy1').setIndex('table', -1.737638236874833, 16, 0);
model.func('LSFy1').setIndex('table', 0.4034334763948498, 16, 1);
model.func('LSFy1').setIndex('table', -1.4480318640623606, 17, 0);
model.func('LSFy1').setIndex('table', 0.44635193133047213, 17, 1);
model.func('LSFy1').setIndex('table', -1.158425491249889, 18, 0);
model.func('LSFy1').setIndex('table', 0.4721030042918455, 18, 1);
model.func('LSFy1').setIndex('table', -0.8688191184374165, 19, 0);
model.func('LSFy1').setIndex('table', 0.5321888412017167, 19, 1);
model.func('LSFy1').setIndex('table', -0.5792127456249441, 20, 0);
model.func('LSFy1').setIndex('table', 0.6051502145922747, 20, 1);
model.func('LSFy1').setIndex('table', -0.2896063728124725, 21, 0);
model.func('LSFy1').setIndex('table', 0.6523605150214592, 21, 1);
model.func('LSFy1').setIndex('table', 0, 22, 0);
model.func('LSFy1').setIndex('table', 1, 22, 1);
model.func('LSFy1').setIndex('table', 0.2896063728124725, 23, 0);
model.func('LSFy1').setIndex('table', 0.6523605150214592, 23, 1);
model.func('LSFy1').setIndex('table', 0.5792127456249441, 24, 0);
model.func('LSFy1').setIndex('table', 0.6051502145922747, 24, 1);
model.func('LSFy1').setIndex('table', 0.8688191184374165, 25, 0);
model.func('LSFy1').setIndex('table', 0.5364806866952789, 25, 1);
model.func('LSFy1').setIndex('table', 1.158425491249889, 26, 0);
model.func('LSFy1').setIndex('table', 0.4678111587982833, 26, 1);
model.func('LSFy1').setIndex('table', 1.4480318640623615, 27, 0);
model.func('LSFy1').setIndex('table', 0.44635193133047213, 27, 1);
model.func('LSFy1').setIndex('table', 1.737638236874834, 28, 0);
model.func('LSFy1').setIndex('table', 0.4034334763948498, 28, 1);
model.func('LSFy1').setIndex('table', 2.0272446096873056, 29, 0);
model.func('LSFy1').setIndex('table', 0.21888412017167383, 29, 1);
model.func('LSFy1').setIndex('table', 2.316850982499777, 30, 0);
model.func('LSFy1').setIndex('table', 0.19742489270386265, 30, 1);
model.func('LSFy1').setIndex('table', 2.6064573553122505, 31, 0);
model.func('LSFy1').setIndex('table', 0.1630901287553648, 31, 1);
model.func('LSFy1').setIndex('table', 2.896063728124722, 32, 0);
model.func('LSFy1').setIndex('table', 0.2017167381974249, 32, 1);
model.func('LSFy1').setIndex('table', 3.1856701009371937, 33, 0);
model.func('LSFy1').setIndex('table', 0.12017167381974249, 33, 1);
model.func('LSFy1').setIndex('table', 3.475276473749667, 34, 0);
model.func('LSFy1').setIndex('table', 0.1888412017167382, 34, 1);
model.func('LSFy1').setIndex('table', 3.7648828465621387, 35, 0);
model.func('LSFy1').setIndex('table', 0.12017167381974249, 35, 1);
model.func('LSFy1').setIndex('table', 4.05448921937461, 36, 0);
model.func('LSFy1').setIndex('table', 0.1630901287553648, 36, 1);
model.func('LSFy1').setIndex('table', 4.344095592187084, 37, 0);
model.func('LSFy1').setIndex('table', 0.14163090128755365, 37, 1);
model.func('LSFy1').setIndex('table', 4.633701964999555, 38, 0);
model.func('LSFy1').setIndex('table', 0.1459227467811159, 38, 1);
model.func('LSFy1').setIndex('table', 4.923308337812027, 39, 0);
model.func('LSFy1').setIndex('table', 0.13733905579399142, 39, 1);
model.func('LSFy1').setIndex('table', 5.2129147106245, 40, 0);
model.func('LSFy1').setIndex('table', 0.15879828326180256, 40, 1);
model.func('LSFy1').setIndex('table', 5.502521083436972, 41, 0);
model.func('LSFy1').setIndex('table', 0.13304721030042918, 41, 1);
model.func('LSFy1').setIndex('table', 5.792127456249443, 42, 0);
model.func('LSFy1').setIndex('table', 0.19742489270386265, 42, 1);
model.func('LSFy1').setIndex('table', 6.081733829061917, 43, 0);
model.func('LSFy1').setIndex('table', 0.09012875536480687, 43, 1);
model.func('LSFy1').setIndex('table', 6.371340201874388, 44, 0);
model.func('LSFy1').setIndex('table', 0, 44, 1);

model.result.dataset.create('lsfy1', 'Grid1D');
model.result.dataset('lsfy1').label('LSFy1');

model.nodeGroup('datagrp').add('dataset', 'lsfy1');

model.result.dataset('lsfy1').set('source', 'function');
model.result.dataset('lsfy1').set('function', 'LSFy1');
model.result.dataset('lsfy1').set('parmin1', '-6.371340201874388');
model.result.dataset('lsfy1').set('parmax1', '6.371340201874388');
model.result.dataset('lsfy1').set('par1', 'y_out');
model.result.create('pg4', 'PlotGroup1D');
model.result('pg4').label('LSF Plot');
model.result('pg4').set('data', 'none');
model.result('pg4').set('titletype', 'none');
model.result('pg4').set('legendpos', 'upperright');
model.result('pg4').create('lsfx1', 'LineGraph');
model.result('pg4').feature('lsfx1').label('LSFx1');
model.result('pg4').feature('lsfx1').set('xdata', 'expr');
model.result('pg4').feature('lsfx1').set('expr', 'LSFx1(x_out)/LSFx1_prim(1e6)');
model.result('pg4').feature('lsfx1').set('xdataexpr', 'x_out');
model.result('pg4').feature('lsfx1').set('xdatadescractive', true);
model.result('pg4').feature('lsfx1').set('xdatadescr', 'Distance relative to centroid (um)');
model.result('pg4').feature('lsfx1').set('data', 'lsfx1');
model.result('pg4').feature('lsfx1').set('legend', true);
model.result('pg4').feature('lsfx1').set('autodescr', true);
model.result('pg4').feature('lsfx1').set('autosolution', false);
model.result('pg4').feature('lsfx1').set('descractive', true);
model.result('pg4').feature('lsfx1').set('descr', 'Release from Grid 1: x');
model.result('pg4').feature('lsfx1').set('smooth', 'none');
model.result('pg4').feature('lsfx1').set('resolution', 'norefine');
model.result('pg4').create('lsfy1', 'LineGraph');
model.result('pg4').feature('lsfy1').label('LSFy1');
model.result('pg4').feature('lsfy1').set('xdata', 'expr');
model.result('pg4').feature('lsfy1').set('expr', 'LSFy1(y_out)/LSFy1_prim(1e6)');
model.result('pg4').feature('lsfy1').set('xdataexpr', 'y_out');
model.result('pg4').feature('lsfy1').set('xdatadescractive', true);
model.result('pg4').feature('lsfy1').set('xdatadescr', 'Distance relative to centroid (um)');
model.result('pg4').feature('lsfy1').set('data', 'lsfy1');
model.result('pg4').feature('lsfy1').set('legend', true);
model.result('pg4').feature('lsfy1').set('autodescr', true);
model.result('pg4').feature('lsfy1').set('autosolution', false);
model.result('pg4').feature('lsfy1').set('descractive', true);
model.result('pg4').feature('lsfy1').set('descr', 'Release from Grid 1: y');
model.result('pg4').feature('lsfy1').set('smooth', 'none');
model.result('pg4').feature('lsfy1').set('resolution', 'norefine');
model.result.numerical('gevMTF').set('expr', {});
model.result.numerical('gevMTF').set('descr', {});
model.result.numerical('gevMTF').setIndex('expr', 'integrate(Lcosx1(x,nu_local),x,-6.371340201874388, 6.371340201874388)/integrate(LSFx1(x),x,-6.371340201874388, 6.371340201874388)', 0);
model.result.numerical('gevMTF').setIndex('descr', 'Lx1', 0);
model.result.numerical('gevMTF').setIndex('expr', 'integrate(Lsinx1(x,nu_local),x,-6.371340201874388, 6.371340201874388)/integrate(LSFx1(x),x,-6.371340201874388, 6.371340201874388)', 1);
model.result.numerical('gevMTF').setIndex('descr', 'Lx1', 1);
model.result.numerical('gevMTF').setIndex('expr', 'integrate(Lcosy1(y,nu_local),y,-6.371340201874388, 6.371340201874388)/integrate(LSFy1(y),y,-6.371340201874388, 6.371340201874388)', 2);
model.result.numerical('gevMTF').setIndex('descr', 'Ly1', 2);
model.result.numerical('gevMTF').setIndex('expr', 'integrate(Lsiny1(y,nu_local),y,-6.371340201874388, 6.371340201874388)/integrate(LSFy1(y),y,-6.371340201874388, 6.371340201874388)', 3);
model.result.numerical('gevMTF').setIndex('descr', 'Ly1', 3);

model.sol('sol1').updateSolution;

model.result.param.set('nu_local', '125.0');

model.func.create('MTFx1', 'Interpolation');
model.func('MTFx1').label('MTFx1');

model.nodeGroup('mtfgrp').add('func', 'MTFx1');

model.func('MTFx1').set('funcname', 'MTFx1');
model.func('MTFx1').set('interp', 'cubicspline');
model.func('MTFx1').set('extrap', 'const');
model.func('MTFx1').set('table', {});
model.func('MTFx1').setIndex('table', 0, 0, 0);
model.func('MTFx1').setIndex('table', 1, 0, 1);
model.func('MTFx1').setIndex('table', 6.25, 1, 0);
model.func('MTFx1').setIndex('table', 0.9943619504470059, 1, 1);
model.func('MTFx1').setIndex('table', 12.5, 2, 0);
model.func('MTFx1').setIndex('table', 0.977633891445058, 2, 1);
model.func('MTFx1').setIndex('table', 18.75, 3, 0);
model.func('MTFx1').setIndex('table', 0.9503716193185557, 3, 1);
model.func('MTFx1').setIndex('table', 25, 4, 0);
model.func('MTFx1').setIndex('table', 0.913455595250299, 4, 1);
model.func('MTFx1').setIndex('table', 31.25, 5, 0);
model.func('MTFx1').setIndex('table', 0.8680877107794098, 5, 1);
model.func('MTFx1').setIndex('table', 37.5, 6, 0);
model.func('MTFx1').setIndex('table', 0.8157180166874362, 6, 1);
model.func('MTFx1').setIndex('table', 43.75, 7, 0);
model.func('MTFx1').setIndex('table', 0.7580141314402794, 7, 1);
model.func('MTFx1').setIndex('table', 50, 8, 0);
model.func('MTFx1').setIndex('table', 0.696549701622559, 8, 1);
model.func('MTFx1').setIndex('table', 56.25, 9, 0);
model.func('MTFx1').setIndex('table', 0.6336956822883011, 9, 1);
model.func('MTFx1').setIndex('table', 62.5, 10, 0);
model.func('MTFx1').setIndex('table', 0.5707467515569632, 10, 1);
model.func('MTFx1').setIndex('table', 68.75, 11, 0);
model.func('MTFx1').setIndex('table', 0.5096199063814643, 11, 1);
model.func('MTFx1').setIndex('table', 75, 12, 0);
model.func('MTFx1').setIndex('table', 0.4518894314360533, 12, 1);
model.func('MTFx1').setIndex('table', 81.25, 13, 0);
model.func('MTFx1').setIndex('table', 0.3989069544319241, 13, 1);
model.func('MTFx1').setIndex('table', 87.5, 14, 0);
model.func('MTFx1').setIndex('table', 0.35181674311317473, 14, 1);
model.func('MTFx1').setIndex('table', 93.75, 15, 0);
model.func('MTFx1').setIndex('table', 0.31142545190467374, 15, 1);
model.func('MTFx1').setIndex('table', 100, 16, 0);
model.func('MTFx1').setIndex('table', 0.2782519450094826, 16, 1);
model.func('MTFx1').setIndex('table', 106.25, 17, 0);
model.func('MTFx1').setIndex('table', 0.2524355667716304, 17, 1);
model.func('MTFx1').setIndex('table', 112.5, 18, 0);
model.func('MTFx1').setIndex('table', 0.23396405380213903, 18, 1);
model.func('MTFx1').setIndex('table', 118.75, 19, 0);
model.func('MTFx1').setIndex('table', 0.2222995091232063, 19, 1);
model.func('MTFx1').setIndex('table', 125, 20, 0);
model.func('MTFx1').setIndex('table', 0.21679687182288762, 20, 1);

model.result.dataset.create('mtfx1', 'Grid1D');
model.result.dataset('mtfx1').label('MTFx1');

model.nodeGroup('datagrp').add('dataset', 'mtfx1');

model.result.dataset('mtfx1').set('source', 'function');
model.result.dataset('mtfx1').set('function', 'MTFx1');
model.result.dataset('mtfx1').set('parmin1', '0');
model.result.dataset('mtfx1').set('parmax1', '125');
model.result.dataset('mtfx1').set('par1', 'nu_out');

model.func.create('MTFy1', 'Interpolation');
model.func('MTFy1').label('MTFy1');

model.nodeGroup('mtfgrp').add('func', 'MTFy1');

model.func('MTFy1').set('funcname', 'MTFy1');
model.func('MTFy1').set('interp', 'cubicspline');
model.func('MTFy1').set('extrap', 'const');
model.func('MTFy1').set('table', {});
model.func('MTFy1').setIndex('table', 0, 0, 0);
model.func('MTFy1').setIndex('table', 1, 0, 1);
model.func('MTFy1').setIndex('table', 6.25, 1, 0);
model.func('MTFy1').setIndex('table', 0.9943806394300655, 1, 1);
model.func('MTFy1').setIndex('table', 12.5, 2, 0);
model.func('MTFy1').setIndex('table', 0.9777078652766472, 2, 1);
model.func('MTFy1').setIndex('table', 18.75, 3, 0);
model.func('MTFy1').setIndex('table', 0.9505298968288397, 3, 1);
model.func('MTFy1').setIndex('table', 25, 4, 0);
model.func('MTFy1').setIndex('table', 0.9137351060835769, 4, 1);
model.func('MTFy1').setIndex('table', 31.25, 5, 0);
model.func('MTFy1').setIndex('table', 0.868527523924572, 5, 1);
model.func('MTFy1').setIndex('table', 37.5, 6, 0);
model.func('MTFy1').setIndex('table', 0.8163180086034554, 6, 1);
model.func('MTFy1').setIndex('table', 43.75, 7, 0);
model.func('MTFy1').setIndex('table', 0.7587858659475779, 7, 1);
model.func('MTFy1').setIndex('table', 50, 8, 0);
model.func('MTFy1').setIndex('table', 0.697490925917012, 8, 1);
model.func('MTFy1').setIndex('table', 56.25, 9, 0);
model.func('MTFy1').setIndex('table', 0.6348253718924777, 9, 1);
model.func('MTFy1').setIndex('table', 62.5, 10, 0);
model.func('MTFy1').setIndex('table', 0.5720468241176135, 10, 1);
model.func('MTFy1').setIndex('table', 68.75, 11, 0);
model.func('MTFy1').setIndex('table', 0.511062314502113, 11, 1);
model.func('MTFy1').setIndex('table', 75, 12, 0);
model.func('MTFy1').setIndex('table', 0.4534512990555772, 12, 1);
model.func('MTFy1').setIndex('table', 81.25, 13, 0);
model.func('MTFy1').setIndex('table', 0.4005689191114057, 13, 1);
model.func('MTFy1').setIndex('table', 87.5, 14, 0);
model.func('MTFy1').setIndex('table', 0.3535341812919897, 14, 1);
model.func('MTFy1').setIndex('table', 93.75, 15, 0);
model.func('MTFy1').setIndex('table', 0.3131448642827982, 15, 1);
model.func('MTFy1').setIndex('table', 100, 16, 0);
model.func('MTFy1').setIndex('table', 0.27996203153883503, 16, 1);
model.func('MTFy1').setIndex('table', 106.25, 17, 0);
model.func('MTFy1').setIndex('table', 0.25411275605010486, 17, 1);
model.func('MTFy1').setIndex('table', 112.5, 18, 0);
model.func('MTFy1').setIndex('table', 0.23548819904278884, 18, 1);
model.func('MTFy1').setIndex('table', 118.75, 19, 0);
model.func('MTFy1').setIndex('table', 0.2236636563497336, 19, 1);
model.func('MTFy1').setIndex('table', 125, 20, 0);
model.func('MTFy1').setIndex('table', 0.21797986649484716, 20, 1);

model.result.dataset.create('mtfy1', 'Grid1D');
model.result.dataset('mtfy1').label('MTFy1');

model.nodeGroup('datagrp').add('dataset', 'mtfy1');

model.result.dataset('mtfy1').set('source', 'function');
model.result.dataset('mtfy1').set('function', 'MTFy1');
model.result.dataset('mtfy1').set('parmin1', '0');
model.result.dataset('mtfy1').set('parmax1', '125');
model.result.dataset('mtfy1').set('par1', 'nu_out');
model.result.create('pg5', 'PlotGroup1D');
model.result('pg5').label('MTF Plot');
model.result('pg5').set('data', 'none');
model.result('pg5').set('titletype', 'none');
model.result('pg5').set('legendpos', 'upperright');
model.result('pg5').set('axislimits', true);
model.result('pg5').set('xmin', -2.5);
model.result('pg5').set('xmax', 127.5);
model.result('pg5').set('ymin', 0);
model.result('pg5').set('ymax', 1.05);
model.result('pg5').set('yminsec', 0);
model.result('pg5').set('ymaxsec', 1.05);
model.result('pg5').create('mtfx1', 'LineGraph');
model.result('pg5').feature('mtfx1').label('MTFx1');
model.result('pg5').feature('mtfx1').set('xdata', 'expr');
model.result('pg5').feature('mtfx1').set('expr', 'MTFx1(nu_out) ');
model.result('pg5').feature('mtfx1').set('xdataexpr', 'nu_out');
model.result('pg5').feature('mtfx1').set('xdatadescractive', true);
model.result('pg5').feature('mtfx1').set('xdatadescr', 'Frequency (1/mm)');
model.result('pg5').feature('mtfx1').set('data', 'mtfx1');
model.result('pg5').feature('mtfx1').set('legend', true);
model.result('pg5').feature('mtfx1').set('autodescr', true);
model.result('pg5').feature('mtfx1').set('autosolution', false);
model.result('pg5').feature('mtfx1').set('descractive', true);
model.result('pg5').feature('mtfx1').set('descr', 'Release from Grid 1: x');
model.result('pg5').feature('mtfx1').set('smooth', 'none');
model.result('pg5').feature('mtfx1').set('resolution', 'norefine');
model.result('pg5').create('mtfy1', 'LineGraph');
model.result('pg5').feature('mtfy1').label('MTFy1');
model.result('pg5').feature('mtfy1').set('xdata', 'expr');
model.result('pg5').feature('mtfy1').set('expr', 'MTFy1(nu_out) ');
model.result('pg5').feature('mtfy1').set('xdataexpr', 'nu_out');
model.result('pg5').feature('mtfy1').set('xdatadescractive', true);
model.result('pg5').feature('mtfy1').set('xdatadescr', 'Frequency (1/mm)');
model.result('pg5').feature('mtfy1').set('data', 'mtfy1');
model.result('pg5').feature('mtfy1').set('legend', true);
model.result('pg5').feature('mtfy1').set('autodescr', true);
model.result('pg5').feature('mtfy1').set('autosolution', false);
model.result('pg5').feature('mtfy1').set('descractive', true);
model.result('pg5').feature('mtfy1').set('descr', 'Release from Grid 1: y');
model.result('pg5').feature('mtfy1').set('smooth', 'none');
model.result('pg5').feature('mtfy1').set('resolution', 'norefine');

% Finished method call computeMTF

model.result('pg1').run;
model.result('pg1').run;
model.result('pg3').run;
model.result('pg3').run;
model.result('pg4').run;
model.result('pg4').run;
model.result('pg5').run;
model.result('pg5').run;

model.physics('gop').feature('relg2').active(true);
model.physics('gop').feature('relg3').active(true);

% Started method call computeMTF

model.physics('gop').feature('relg1').active(true);
model.physics('gop').feature('relg2').active(true);
model.physics('gop').feature('relg3').active(true);

model.nodeGroup.create('mtfgrp2', 'GlobalDefinitions');
model.nodeGroup('mtfgrp2').label('MTF: Release from Grid 2');
model.nodeGroup.create('mtfgrp3', 'GlobalDefinitions');
model.nodeGroup('mtfgrp3').label('MTF: Release from Grid 3');

model.study('std1').run;

model.result.numerical('gevMTF').set('data', 'ray1');
model.result.numerical('gevMTF').set('innerinput', 'last');
model.result.numerical('gevMTF').set('expr', {});
model.result.numerical('gevMTF').set('descr', {});
model.result.numerical('gevMTF').setIndex('expr', 'gop.relg1.rmaxall', 0);
model.result.numerical('gevMTF').setIndex('expr', 'gop.relg2.rmaxall', 1);
model.result.numerical('gevMTF').setIndex('expr', 'gop.relg3.rmaxall', 2);

model.func('Lcosx1').set('funcname', 'Lcosx1');
model.func('Lcosx1').set('expr', 'LSFx1(x)*cos(2*pi*nu*x/1e3)');
model.func('Lcosx1').set('args', 'x, nu');
model.func('Lcosx1').setIndex('plotargs', -6.660946574690962, 0, 1);
model.func('Lcosx1').setIndex('plotargs', 6.660946574690962, 0, 2);
model.func('Lcosx1').setIndex('plotargs', 0, 1, 1);
model.func('Lcosx1').setIndex('plotargs', '125', 1, 2);
model.func('Lsinx1').set('funcname', 'Lsinx1');
model.func('Lsinx1').set('expr', 'LSFx1(x)*sin(2*pi*nu*x/1e3)');
model.func('Lsinx1').set('args', 'x, nu');
model.func('Lsinx1').setIndex('plotargs', -6.660946574690962, 0, 1);
model.func('Lsinx1').setIndex('plotargs', 6.660946574690962, 0, 2);
model.func('Lsinx1').setIndex('plotargs', 0, 1, 1);
model.func('Lsinx1').setIndex('plotargs', '125', 1, 2);

model.result.numerical('gevLSFx1').set('data', 'ray1');
model.result.numerical('gevLSFx1').set('innerinput', 'last');
model.result.numerical('gevLSFx1').set('expr', {});
model.result.numerical('gevLSFx1').set('descr', {});
model.result.numerical('gevLSFx1').setIndex('expr', 'gop.sum((1e6*(qx-gop.relg1.qavex)>-6.805749761097288)&&(1e6*(qx-gop.relg1.qavex)<=-6.516143388284637)&&gop.prf==1)', 0);
model.result.numerical('gevLSFx1').setIndex('expr', 'gop.sum((1e6*(qx-gop.relg1.qavex)>-6.516143388284637)&&(1e6*(qx-gop.relg1.qavex)<=-6.226537015471986)&&gop.prf==1)', 1);
model.result.numerical('gevLSFx1').setIndex('expr', 'gop.sum((1e6*(qx-gop.relg1.qavex)>-6.226537015471987)&&(1e6*(qx-gop.relg1.qavex)<=-5.936930642659336)&&gop.prf==1)', 2);
model.result.numerical('gevLSFx1').setIndex('expr', 'gop.sum((1e6*(qx-gop.relg1.qavex)>-5.936930642659337)&&(1e6*(qx-gop.relg1.qavex)<=-5.647324269846686)&&gop.prf==1)', 3);
model.result.numerical('gevLSFx1').setIndex('expr', 'gop.sum((1e6*(qx-gop.relg1.qavex)>-5.647324269846686)&&(1e6*(qx-gop.relg1.qavex)<=-5.357717897034035)&&gop.prf==1)', 4);
model.result.numerical('gevLSFx1').setIndex('expr', 'gop.sum((1e6*(qx-gop.relg1.qavex)>-5.357717897034035)&&(1e6*(qx-gop.relg1.qavex)<=-5.068111524221384)&&gop.prf==1)', 5);
model.result.numerical('gevLSFx1').setIndex('expr', 'gop.sum((1e6*(qx-gop.relg1.qavex)>-5.068111524221385)&&(1e6*(qx-gop.relg1.qavex)<=-4.7785051514087336)&&gop.prf==1)', 6);
model.result.numerical('gevLSFx1').setIndex('expr', 'gop.sum((1e6*(qx-gop.relg1.qavex)>-4.778505151408734)&&(1e6*(qx-gop.relg1.qavex)<=-4.488898778596083)&&gop.prf==1)', 7);
model.result.numerical('gevLSFx1').setIndex('expr', 'gop.sum((1e6*(qx-gop.relg1.qavex)>-4.488898778596083)&&(1e6*(qx-gop.relg1.qavex)<=-4.199292405783432)&&gop.prf==1)', 8);
model.result.numerical('gevLSFx1').setIndex('expr', 'gop.sum((1e6*(qx-gop.relg1.qavex)>-4.199292405783432)&&(1e6*(qx-gop.relg1.qavex)<=-3.9096860329707814)&&gop.prf==1)', 9);
model.result.numerical('gevLSFx1').setIndex('expr', 'gop.sum((1e6*(qx-gop.relg1.qavex)>-3.9096860329707823)&&(1e6*(qx-gop.relg1.qavex)<=-3.6200796601581313)&&gop.prf==1)', 10);
model.result.numerical('gevLSFx1').setIndex('expr', 'gop.sum((1e6*(qx-gop.relg1.qavex)>-3.6200796601581313)&&(1e6*(qx-gop.relg1.qavex)<=-3.330473287345481)&&gop.prf==1)', 11);
model.result.numerical('gevLSFx1').setIndex('expr', 'gop.sum((1e6*(qx-gop.relg1.qavex)>-3.330473287345481)&&(1e6*(qx-gop.relg1.qavex)<=-3.04086691453283)&&gop.prf==1)', 12);
model.result.numerical('gevLSFx1').setIndex('expr', 'gop.sum((1e6*(qx-gop.relg1.qavex)>-3.04086691453283)&&(1e6*(qx-gop.relg1.qavex)<=-2.75126054172018)&&gop.prf==1)', 13);
model.result.numerical('gevLSFx1').setIndex('expr', 'gop.sum((1e6*(qx-gop.relg1.qavex)>-2.75126054172018)&&(1e6*(qx-gop.relg1.qavex)<=-2.461654168907529)&&gop.prf==1)', 14);
model.result.numerical('gevLSFx1').setIndex('expr', 'gop.sum((1e6*(qx-gop.relg1.qavex)>-2.46165416890753)&&(1e6*(qx-gop.relg1.qavex)<=-2.172047796094879)&&gop.prf==1)', 15);
model.result.numerical('gevLSFx1').setIndex('expr', 'gop.sum((1e6*(qx-gop.relg1.qavex)>-2.172047796094879)&&(1e6*(qx-gop.relg1.qavex)<=-1.8824414232822282)&&gop.prf==1)', 16);
model.result.numerical('gevLSFx1').setIndex('expr', 'gop.sum((1e6*(qx-gop.relg1.qavex)>-1.8824414232822277)&&(1e6*(qx-gop.relg1.qavex)<=-1.5928350504695772)&&gop.prf==1)', 17);
model.result.numerical('gevLSFx1').setIndex('expr', 'gop.sum((1e6*(qx-gop.relg1.qavex)>-1.5928350504695776)&&(1e6*(qx-gop.relg1.qavex)<=-1.303228677656927)&&gop.prf==1)', 18);
model.result.numerical('gevLSFx1').setIndex('expr', 'gop.sum((1e6*(qx-gop.relg1.qavex)>-1.3032286776569275)&&(1e6*(qx-gop.relg1.qavex)<=-1.013622304844277)&&gop.prf==1)', 19);
model.result.numerical('gevLSFx1').setIndex('expr', 'gop.sum((1e6*(qx-gop.relg1.qavex)>-1.0136223048442765)&&(1e6*(qx-gop.relg1.qavex)<=-0.724015932031626)&&gop.prf==1)', 20);
model.result.numerical('gevLSFx1').setIndex('expr', 'gop.sum((1e6*(qx-gop.relg1.qavex)>-0.7240159320316255)&&(1e6*(qx-gop.relg1.qavex)<=-0.43440955921897495)&&gop.prf==1)', 21);
model.result.numerical('gevLSFx1').setIndex('expr', 'gop.sum((1e6*(qx-gop.relg1.qavex)>-0.4344095592189754)&&(1e6*(qx-gop.relg1.qavex)<=-0.14480318640632484)&&gop.prf==1)', 22);
model.result.numerical('gevLSFx1').setIndex('expr', 'gop.sum((1e6*(qx-gop.relg1.qavex)>-0.14480318640632528)&&(1e6*(qx-gop.relg1.qavex)<=0.14480318640632528)&&gop.prf==1)', 23);
model.result.numerical('gevLSFx1').setIndex('expr', 'gop.sum((1e6*(qx-gop.relg1.qavex)>0.14480318640632572)&&(1e6*(qx-gop.relg1.qavex)<=0.4344095592189763)&&gop.prf==1)', 24);
model.result.numerical('gevLSFx1').setIndex('expr', 'gop.sum((1e6*(qx-gop.relg1.qavex)>0.4344095592189767)&&(1e6*(qx-gop.relg1.qavex)<=0.7240159320316273)&&gop.prf==1)', 25);
model.result.numerical('gevLSFx1').setIndex('expr', 'gop.sum((1e6*(qx-gop.relg1.qavex)>0.7240159320316268)&&(1e6*(qx-gop.relg1.qavex)<=1.0136223048442774)&&gop.prf==1)', 26);
model.result.numerical('gevLSFx1').setIndex('expr', 'gop.sum((1e6*(qx-gop.relg1.qavex)>1.013622304844277)&&(1e6*(qx-gop.relg1.qavex)<=1.3032286776569275)&&gop.prf==1)', 27);
model.result.numerical('gevLSFx1').setIndex('expr', 'gop.sum((1e6*(qx-gop.relg1.qavex)>1.303228677656928)&&(1e6*(qx-gop.relg1.qavex)<=1.5928350504695785)&&gop.prf==1)', 28);
model.result.numerical('gevLSFx1').setIndex('expr', 'gop.sum((1e6*(qx-gop.relg1.qavex)>1.592835050469579)&&(1e6*(qx-gop.relg1.qavex)<=1.8824414232822295)&&gop.prf==1)', 29);
model.result.numerical('gevLSFx1').setIndex('expr', 'gop.sum((1e6*(qx-gop.relg1.qavex)>1.8824414232822282)&&(1e6*(qx-gop.relg1.qavex)<=2.172047796094879)&&gop.prf==1)', 30);
model.result.numerical('gevLSFx1').setIndex('expr', 'gop.sum((1e6*(qx-gop.relg1.qavex)>2.172047796094879)&&(1e6*(qx-gop.relg1.qavex)<=2.46165416890753)&&gop.prf==1)', 31);
model.result.numerical('gevLSFx1').setIndex('expr', 'gop.sum((1e6*(qx-gop.relg1.qavex)>2.46165416890753)&&(1e6*(qx-gop.relg1.qavex)<=2.751260541720181)&&gop.prf==1)', 32);
model.result.numerical('gevLSFx1').setIndex('expr', 'gop.sum((1e6*(qx-gop.relg1.qavex)>2.751260541720181)&&(1e6*(qx-gop.relg1.qavex)<=3.040866914532832)&&gop.prf==1)', 33);
model.result.numerical('gevLSFx1').setIndex('expr', 'gop.sum((1e6*(qx-gop.relg1.qavex)>3.040866914532832)&&(1e6*(qx-gop.relg1.qavex)<=3.330473287345483)&&gop.prf==1)', 34);
model.result.numerical('gevLSFx1').setIndex('expr', 'gop.sum((1e6*(qx-gop.relg1.qavex)>3.330473287345481)&&(1e6*(qx-gop.relg1.qavex)<=3.620079660158132)&&gop.prf==1)', 35);
model.result.numerical('gevLSFx1').setIndex('expr', 'gop.sum((1e6*(qx-gop.relg1.qavex)>3.620079660158132)&&(1e6*(qx-gop.relg1.qavex)<=3.909686032970783)&&gop.prf==1)', 36);
model.result.numerical('gevLSFx1').setIndex('expr', 'gop.sum((1e6*(qx-gop.relg1.qavex)>3.909686032970783)&&(1e6*(qx-gop.relg1.qavex)<=4.199292405783434)&&gop.prf==1)', 37);
model.result.numerical('gevLSFx1').setIndex('expr', 'gop.sum((1e6*(qx-gop.relg1.qavex)>4.199292405783432)&&(1e6*(qx-gop.relg1.qavex)<=4.488898778596083)&&gop.prf==1)', 38);
model.result.numerical('gevLSFx1').setIndex('expr', 'gop.sum((1e6*(qx-gop.relg1.qavex)>4.488898778596083)&&(1e6*(qx-gop.relg1.qavex)<=4.778505151408734)&&gop.prf==1)', 39);
model.result.numerical('gevLSFx1').setIndex('expr', 'gop.sum((1e6*(qx-gop.relg1.qavex)>4.778505151408734)&&(1e6*(qx-gop.relg1.qavex)<=5.0681115242213854)&&gop.prf==1)', 40);
model.result.numerical('gevLSFx1').setIndex('expr', 'gop.sum((1e6*(qx-gop.relg1.qavex)>5.0681115242213854)&&(1e6*(qx-gop.relg1.qavex)<=5.3577178970340364)&&gop.prf==1)', 41);
model.result.numerical('gevLSFx1').setIndex('expr', 'gop.sum((1e6*(qx-gop.relg1.qavex)>5.3577178970340364)&&(1e6*(qx-gop.relg1.qavex)<=5.6473242698466875)&&gop.prf==1)', 42);
model.result.numerical('gevLSFx1').setIndex('expr', 'gop.sum((1e6*(qx-gop.relg1.qavex)>5.647324269846686)&&(1e6*(qx-gop.relg1.qavex)<=5.936930642659337)&&gop.prf==1)', 43);
model.result.numerical('gevLSFx1').setIndex('expr', 'gop.sum((1e6*(qx-gop.relg1.qavex)>5.936930642659337)&&(1e6*(qx-gop.relg1.qavex)<=6.226537015471988)&&gop.prf==1)', 44);
model.result.numerical('gevLSFx1').setIndex('expr', 'gop.sum((1e6*(qx-gop.relg1.qavex)>6.226537015471988)&&(1e6*(qx-gop.relg1.qavex)<=6.516143388284639)&&gop.prf==1)', 45);
model.result.numerical('gevLSFx1').setIndex('expr', 'gop.sum((1e6*(qx-gop.relg1.qavex)>6.516143388284637)&&(1e6*(qx-gop.relg1.qavex)<=6.805749761097288)&&gop.prf==1)', 46);

model.func('LSFx1').set('table', {});
model.func('LSFx1').setIndex('table', -6.660946574690962, 0, 0);
model.func('LSFx1').setIndex('table', 0, 0, 1);
model.func('LSFx1').setIndex('table', -6.371340201878311, 1, 0);
model.func('LSFx1').setIndex('table', 0, 1, 1);
model.func('LSFx1').setIndex('table', -6.081733829065661, 2, 0);
model.func('LSFx1').setIndex('table', 0.08860759493670886, 2, 1);
model.func('LSFx1').setIndex('table', -5.792127456253011, 3, 0);
model.func('LSFx1').setIndex('table', 0.189873417721519, 3, 1);
model.func('LSFx1').setIndex('table', -5.50252108344036, 4, 0);
model.func('LSFx1').setIndex('table', 0.12658227848101267, 4, 1);
model.func('LSFx1').setIndex('table', -5.212914710627709, 5, 0);
model.func('LSFx1').setIndex('table', 0.16455696202531644, 5, 1);
model.func('LSFx1').setIndex('table', -4.923308337815059, 6, 0);
model.func('LSFx1').setIndex('table', 0.14767932489451477, 6, 1);
model.func('LSFx1').setIndex('table', -4.633701965002409, 7, 0);
model.func('LSFx1').setIndex('table', 0.14345991561181434, 7, 1);
model.func('LSFx1').setIndex('table', -4.344095592189758, 8, 0);
model.func('LSFx1').setIndex('table', 0.13924050632911392, 8, 1);
model.func('LSFx1').setIndex('table', -4.054489219377107, 9, 0);
model.func('LSFx1').setIndex('table', 0.1518987341772152, 9, 1);
model.func('LSFx1').setIndex('table', -3.764882846564457, 10, 0);
model.func('LSFx1').setIndex('table', 0.10970464135021098, 10, 1);
model.func('LSFx1').setIndex('table', -3.4752764737518063, 11, 0);
model.func('LSFx1').setIndex('table', 0.189873417721519, 11, 1);
model.func('LSFx1').setIndex('table', -3.1856701009391557, 12, 0);
model.func('LSFx1').setIndex('table', 0.12658227848101267, 12, 1);
model.func('LSFx1').setIndex('table', -2.896063728126505, 13, 0);
model.func('LSFx1').setIndex('table', 0.19831223628691982, 13, 1);
model.func('LSFx1').setIndex('table', -2.6064573553138546, 14, 0);
model.func('LSFx1').setIndex('table', 0.14767932489451477, 14, 1);
model.func('LSFx1').setIndex('table', -2.3168509825012045, 15, 0);
model.func('LSFx1').setIndex('table', 0.20253164556962025, 15, 1);
model.func('LSFx1').setIndex('table', -2.0272446096885535, 16, 0);
model.func('LSFx1').setIndex('table', 0.2109704641350211, 16, 1);
model.func('LSFx1').setIndex('table', -1.7376382368759025, 17, 0);
model.func('LSFx1').setIndex('table', 0.4219409282700422, 17, 1);
model.func('LSFx1').setIndex('table', -1.4480318640632523, 18, 0);
model.func('LSFx1').setIndex('table', 0.4050632911392405, 18, 1);
model.func('LSFx1').setIndex('table', -1.1584254912506022, 19, 0);
model.func('LSFx1').setIndex('table', 0.46835443037974683, 19, 1);
model.func('LSFx1').setIndex('table', -0.8688191184379512, 20, 0);
model.func('LSFx1').setIndex('table', 0.540084388185654, 20, 1);
model.func('LSFx1').setIndex('table', -0.5792127456253002, 21, 0);
model.func('LSFx1').setIndex('table', 0.5611814345991561, 21, 1);
model.func('LSFx1').setIndex('table', -0.2896063728126501, 22, 0);
model.func('LSFx1').setIndex('table', 0.6540084388185654, 22, 1);
model.func('LSFx1').setIndex('table', 0, 23, 0);
model.func('LSFx1').setIndex('table', 1, 23, 1);
model.func('LSFx1').setIndex('table', 0.289606372812651, 24, 0);
model.func('LSFx1').setIndex('table', 0.6540084388185654, 24, 1);
model.func('LSFx1').setIndex('table', 0.579212745625302, 25, 0);
model.func('LSFx1').setIndex('table', 0.5611814345991561, 25, 1);
model.func('LSFx1').setIndex('table', 0.8688191184379521, 26, 0);
model.func('LSFx1').setIndex('table', 0.540084388185654, 26, 1);
model.func('LSFx1').setIndex('table', 1.1584254912506022, 27, 0);
model.func('LSFx1').setIndex('table', 0.46835443037974683, 27, 1);
model.func('LSFx1').setIndex('table', 1.4480318640632532, 28, 0);
model.func('LSFx1').setIndex('table', 0.4050632911392405, 28, 1);
model.func('LSFx1').setIndex('table', 1.7376382368759042, 29, 0);
model.func('LSFx1').setIndex('table', 0.4219409282700422, 29, 1);
model.func('LSFx1').setIndex('table', 2.0272446096885535, 30, 0);
model.func('LSFx1').setIndex('table', 0.2109704641350211, 30, 1);
model.func('LSFx1').setIndex('table', 2.3168509825012045, 31, 0);
model.func('LSFx1').setIndex('table', 0.20253164556962025, 31, 1);
model.func('LSFx1').setIndex('table', 2.6064573553138555, 32, 0);
model.func('LSFx1').setIndex('table', 0.14767932489451477, 32, 1);
model.func('LSFx1').setIndex('table', 2.8960637281265065, 33, 0);
model.func('LSFx1').setIndex('table', 0.19831223628691982, 33, 1);
model.func('LSFx1').setIndex('table', 3.1856701009391575, 34, 0);
model.func('LSFx1').setIndex('table', 0.12658227848101267, 34, 1);
model.func('LSFx1').setIndex('table', 3.4752764737518067, 35, 0);
model.func('LSFx1').setIndex('table', 0.189873417721519, 35, 1);
model.func('LSFx1').setIndex('table', 3.7648828465644577, 36, 0);
model.func('LSFx1').setIndex('table', 0.10970464135021098, 36, 1);
model.func('LSFx1').setIndex('table', 4.054489219377109, 37, 0);
model.func('LSFx1').setIndex('table', 0.1518987341772152, 37, 1);
model.func('LSFx1').setIndex('table', 4.344095592189758, 38, 0);
model.func('LSFx1').setIndex('table', 0.13924050632911392, 38, 1);
model.func('LSFx1').setIndex('table', 4.633701965002409, 39, 0);
model.func('LSFx1').setIndex('table', 0.14345991561181434, 39, 1);
model.func('LSFx1').setIndex('table', 4.92330833781506, 40, 0);
model.func('LSFx1').setIndex('table', 0.14345991561181434, 40, 1);
model.func('LSFx1').setIndex('table', 5.212914710627711, 41, 0);
model.func('LSFx1').setIndex('table', 0.16877637130801687, 41, 1);
model.func('LSFx1').setIndex('table', 5.502521083440362, 42, 0);
model.func('LSFx1').setIndex('table', 0.12658227848101267, 42, 1);
model.func('LSFx1').setIndex('table', 5.792127456253011, 43, 0);
model.func('LSFx1').setIndex('table', 0.18565400843881857, 43, 1);
model.func('LSFx1').setIndex('table', 6.081733829065662, 44, 0);
model.func('LSFx1').setIndex('table', 0.09282700421940929, 44, 1);
model.func('LSFx1').setIndex('table', 6.371340201878313, 45, 0);
model.func('LSFx1').setIndex('table', 0, 45, 1);
model.func('LSFx1').setIndex('table', 6.660946574690962, 46, 0);
model.func('LSFx1').setIndex('table', 0, 46, 1);

model.result.dataset('lsfx1').set('source', 'function');
model.result.dataset('lsfx1').set('function', 'LSFx1');
model.result.dataset('lsfx1').set('parmin1', '-6.660946574690962');
model.result.dataset('lsfx1').set('parmax1', '6.660946574690962');
model.result.dataset('lsfx1').set('par1', 'x_out');

model.func('Lcosy1').set('funcname', 'Lcosy1');
model.func('Lcosy1').set('expr', 'LSFy1(y)*cos(2*pi*nu*y/1e3)');
model.func('Lcosy1').set('args', 'y, nu');
model.func('Lcosy1').setIndex('plotargs', -6.660946574690962, 0, 1);
model.func('Lcosy1').setIndex('plotargs', 6.660946574690962, 0, 2);
model.func('Lcosy1').setIndex('plotargs', 0, 1, 1);
model.func('Lcosy1').setIndex('plotargs', '125', 1, 2);
model.func('Lsiny1').set('funcname', 'Lsiny1');
model.func('Lsiny1').set('expr', 'LSFy1(y)*sin(2*pi*nu*y/1e3)');
model.func('Lsiny1').set('args', 'y, nu');
model.func('Lsiny1').setIndex('plotargs', -6.660946574690962, 0, 1);
model.func('Lsiny1').setIndex('plotargs', 6.660946574690962, 0, 2);
model.func('Lsiny1').setIndex('plotargs', 0, 1, 1);
model.func('Lsiny1').setIndex('plotargs', '125', 1, 2);

model.result.numerical('gevLSFy1').set('data', 'ray1');
model.result.numerical('gevLSFy1').set('innerinput', 'last');
model.result.numerical('gevLSFy1').set('expr', {});
model.result.numerical('gevLSFy1').set('descr', {});
model.result.numerical('gevLSFy1').setIndex('expr', 'gop.sum((1e6*(qy-gop.relg1.qavey)>-6.805749761097288)&&(1e6*(qy-gop.relg1.qavey)<=-6.516143388284637)&&gop.prf==1)', 0);
model.result.numerical('gevLSFy1').setIndex('expr', 'gop.sum((1e6*(qy-gop.relg1.qavey)>-6.516143388284637)&&(1e6*(qy-gop.relg1.qavey)<=-6.226537015471986)&&gop.prf==1)', 1);
model.result.numerical('gevLSFy1').setIndex('expr', 'gop.sum((1e6*(qy-gop.relg1.qavey)>-6.226537015471987)&&(1e6*(qy-gop.relg1.qavey)<=-5.936930642659336)&&gop.prf==1)', 2);
model.result.numerical('gevLSFy1').setIndex('expr', 'gop.sum((1e6*(qy-gop.relg1.qavey)>-5.936930642659337)&&(1e6*(qy-gop.relg1.qavey)<=-5.647324269846686)&&gop.prf==1)', 3);
model.result.numerical('gevLSFy1').setIndex('expr', 'gop.sum((1e6*(qy-gop.relg1.qavey)>-5.647324269846686)&&(1e6*(qy-gop.relg1.qavey)<=-5.357717897034035)&&gop.prf==1)', 4);
model.result.numerical('gevLSFy1').setIndex('expr', 'gop.sum((1e6*(qy-gop.relg1.qavey)>-5.357717897034035)&&(1e6*(qy-gop.relg1.qavey)<=-5.068111524221384)&&gop.prf==1)', 5);
model.result.numerical('gevLSFy1').setIndex('expr', 'gop.sum((1e6*(qy-gop.relg1.qavey)>-5.068111524221385)&&(1e6*(qy-gop.relg1.qavey)<=-4.7785051514087336)&&gop.prf==1)', 6);
model.result.numerical('gevLSFy1').setIndex('expr', 'gop.sum((1e6*(qy-gop.relg1.qavey)>-4.778505151408734)&&(1e6*(qy-gop.relg1.qavey)<=-4.488898778596083)&&gop.prf==1)', 7);
model.result.numerical('gevLSFy1').setIndex('expr', 'gop.sum((1e6*(qy-gop.relg1.qavey)>-4.488898778596083)&&(1e6*(qy-gop.relg1.qavey)<=-4.199292405783432)&&gop.prf==1)', 8);
model.result.numerical('gevLSFy1').setIndex('expr', 'gop.sum((1e6*(qy-gop.relg1.qavey)>-4.199292405783432)&&(1e6*(qy-gop.relg1.qavey)<=-3.9096860329707814)&&gop.prf==1)', 9);
model.result.numerical('gevLSFy1').setIndex('expr', 'gop.sum((1e6*(qy-gop.relg1.qavey)>-3.9096860329707823)&&(1e6*(qy-gop.relg1.qavey)<=-3.6200796601581313)&&gop.prf==1)', 10);
model.result.numerical('gevLSFy1').setIndex('expr', 'gop.sum((1e6*(qy-gop.relg1.qavey)>-3.6200796601581313)&&(1e6*(qy-gop.relg1.qavey)<=-3.330473287345481)&&gop.prf==1)', 11);
model.result.numerical('gevLSFy1').setIndex('expr', 'gop.sum((1e6*(qy-gop.relg1.qavey)>-3.330473287345481)&&(1e6*(qy-gop.relg1.qavey)<=-3.04086691453283)&&gop.prf==1)', 12);
model.result.numerical('gevLSFy1').setIndex('expr', 'gop.sum((1e6*(qy-gop.relg1.qavey)>-3.04086691453283)&&(1e6*(qy-gop.relg1.qavey)<=-2.75126054172018)&&gop.prf==1)', 13);
model.result.numerical('gevLSFy1').setIndex('expr', 'gop.sum((1e6*(qy-gop.relg1.qavey)>-2.75126054172018)&&(1e6*(qy-gop.relg1.qavey)<=-2.461654168907529)&&gop.prf==1)', 14);
model.result.numerical('gevLSFy1').setIndex('expr', 'gop.sum((1e6*(qy-gop.relg1.qavey)>-2.46165416890753)&&(1e6*(qy-gop.relg1.qavey)<=-2.172047796094879)&&gop.prf==1)', 15);
model.result.numerical('gevLSFy1').setIndex('expr', 'gop.sum((1e6*(qy-gop.relg1.qavey)>-2.172047796094879)&&(1e6*(qy-gop.relg1.qavey)<=-1.8824414232822282)&&gop.prf==1)', 16);
model.result.numerical('gevLSFy1').setIndex('expr', 'gop.sum((1e6*(qy-gop.relg1.qavey)>-1.8824414232822277)&&(1e6*(qy-gop.relg1.qavey)<=-1.5928350504695772)&&gop.prf==1)', 17);
model.result.numerical('gevLSFy1').setIndex('expr', 'gop.sum((1e6*(qy-gop.relg1.qavey)>-1.5928350504695776)&&(1e6*(qy-gop.relg1.qavey)<=-1.303228677656927)&&gop.prf==1)', 18);
model.result.numerical('gevLSFy1').setIndex('expr', 'gop.sum((1e6*(qy-gop.relg1.qavey)>-1.3032286776569275)&&(1e6*(qy-gop.relg1.qavey)<=-1.013622304844277)&&gop.prf==1)', 19);
model.result.numerical('gevLSFy1').setIndex('expr', 'gop.sum((1e6*(qy-gop.relg1.qavey)>-1.0136223048442765)&&(1e6*(qy-gop.relg1.qavey)<=-0.724015932031626)&&gop.prf==1)', 20);
model.result.numerical('gevLSFy1').setIndex('expr', 'gop.sum((1e6*(qy-gop.relg1.qavey)>-0.7240159320316255)&&(1e6*(qy-gop.relg1.qavey)<=-0.43440955921897495)&&gop.prf==1)', 21);
model.result.numerical('gevLSFy1').setIndex('expr', 'gop.sum((1e6*(qy-gop.relg1.qavey)>-0.4344095592189754)&&(1e6*(qy-gop.relg1.qavey)<=-0.14480318640632484)&&gop.prf==1)', 22);
model.result.numerical('gevLSFy1').setIndex('expr', 'gop.sum((1e6*(qy-gop.relg1.qavey)>-0.14480318640632528)&&(1e6*(qy-gop.relg1.qavey)<=0.14480318640632528)&&gop.prf==1)', 23);
model.result.numerical('gevLSFy1').setIndex('expr', 'gop.sum((1e6*(qy-gop.relg1.qavey)>0.14480318640632572)&&(1e6*(qy-gop.relg1.qavey)<=0.4344095592189763)&&gop.prf==1)', 24);
model.result.numerical('gevLSFy1').setIndex('expr', 'gop.sum((1e6*(qy-gop.relg1.qavey)>0.4344095592189767)&&(1e6*(qy-gop.relg1.qavey)<=0.7240159320316273)&&gop.prf==1)', 25);
model.result.numerical('gevLSFy1').setIndex('expr', 'gop.sum((1e6*(qy-gop.relg1.qavey)>0.7240159320316268)&&(1e6*(qy-gop.relg1.qavey)<=1.0136223048442774)&&gop.prf==1)', 26);
model.result.numerical('gevLSFy1').setIndex('expr', 'gop.sum((1e6*(qy-gop.relg1.qavey)>1.013622304844277)&&(1e6*(qy-gop.relg1.qavey)<=1.3032286776569275)&&gop.prf==1)', 27);
model.result.numerical('gevLSFy1').setIndex('expr', 'gop.sum((1e6*(qy-gop.relg1.qavey)>1.303228677656928)&&(1e6*(qy-gop.relg1.qavey)<=1.5928350504695785)&&gop.prf==1)', 28);
model.result.numerical('gevLSFy1').setIndex('expr', 'gop.sum((1e6*(qy-gop.relg1.qavey)>1.592835050469579)&&(1e6*(qy-gop.relg1.qavey)<=1.8824414232822295)&&gop.prf==1)', 29);
model.result.numerical('gevLSFy1').setIndex('expr', 'gop.sum((1e6*(qy-gop.relg1.qavey)>1.8824414232822282)&&(1e6*(qy-gop.relg1.qavey)<=2.172047796094879)&&gop.prf==1)', 30);
model.result.numerical('gevLSFy1').setIndex('expr', 'gop.sum((1e6*(qy-gop.relg1.qavey)>2.172047796094879)&&(1e6*(qy-gop.relg1.qavey)<=2.46165416890753)&&gop.prf==1)', 31);
model.result.numerical('gevLSFy1').setIndex('expr', 'gop.sum((1e6*(qy-gop.relg1.qavey)>2.46165416890753)&&(1e6*(qy-gop.relg1.qavey)<=2.751260541720181)&&gop.prf==1)', 32);
model.result.numerical('gevLSFy1').setIndex('expr', 'gop.sum((1e6*(qy-gop.relg1.qavey)>2.751260541720181)&&(1e6*(qy-gop.relg1.qavey)<=3.040866914532832)&&gop.prf==1)', 33);
model.result.numerical('gevLSFy1').setIndex('expr', 'gop.sum((1e6*(qy-gop.relg1.qavey)>3.040866914532832)&&(1e6*(qy-gop.relg1.qavey)<=3.330473287345483)&&gop.prf==1)', 34);
model.result.numerical('gevLSFy1').setIndex('expr', 'gop.sum((1e6*(qy-gop.relg1.qavey)>3.330473287345481)&&(1e6*(qy-gop.relg1.qavey)<=3.620079660158132)&&gop.prf==1)', 35);
model.result.numerical('gevLSFy1').setIndex('expr', 'gop.sum((1e6*(qy-gop.relg1.qavey)>3.620079660158132)&&(1e6*(qy-gop.relg1.qavey)<=3.909686032970783)&&gop.prf==1)', 36);
model.result.numerical('gevLSFy1').setIndex('expr', 'gop.sum((1e6*(qy-gop.relg1.qavey)>3.909686032970783)&&(1e6*(qy-gop.relg1.qavey)<=4.199292405783434)&&gop.prf==1)', 37);
model.result.numerical('gevLSFy1').setIndex('expr', 'gop.sum((1e6*(qy-gop.relg1.qavey)>4.199292405783432)&&(1e6*(qy-gop.relg1.qavey)<=4.488898778596083)&&gop.prf==1)', 38);
model.result.numerical('gevLSFy1').setIndex('expr', 'gop.sum((1e6*(qy-gop.relg1.qavey)>4.488898778596083)&&(1e6*(qy-gop.relg1.qavey)<=4.778505151408734)&&gop.prf==1)', 39);
model.result.numerical('gevLSFy1').setIndex('expr', 'gop.sum((1e6*(qy-gop.relg1.qavey)>4.778505151408734)&&(1e6*(qy-gop.relg1.qavey)<=5.0681115242213854)&&gop.prf==1)', 40);
model.result.numerical('gevLSFy1').setIndex('expr', 'gop.sum((1e6*(qy-gop.relg1.qavey)>5.0681115242213854)&&(1e6*(qy-gop.relg1.qavey)<=5.3577178970340364)&&gop.prf==1)', 41);
model.result.numerical('gevLSFy1').setIndex('expr', 'gop.sum((1e6*(qy-gop.relg1.qavey)>5.3577178970340364)&&(1e6*(qy-gop.relg1.qavey)<=5.6473242698466875)&&gop.prf==1)', 42);
model.result.numerical('gevLSFy1').setIndex('expr', 'gop.sum((1e6*(qy-gop.relg1.qavey)>5.647324269846686)&&(1e6*(qy-gop.relg1.qavey)<=5.936930642659337)&&gop.prf==1)', 43);
model.result.numerical('gevLSFy1').setIndex('expr', 'gop.sum((1e6*(qy-gop.relg1.qavey)>5.936930642659337)&&(1e6*(qy-gop.relg1.qavey)<=6.226537015471988)&&gop.prf==1)', 44);
model.result.numerical('gevLSFy1').setIndex('expr', 'gop.sum((1e6*(qy-gop.relg1.qavey)>6.226537015471988)&&(1e6*(qy-gop.relg1.qavey)<=6.516143388284639)&&gop.prf==1)', 45);
model.result.numerical('gevLSFy1').setIndex('expr', 'gop.sum((1e6*(qy-gop.relg1.qavey)>6.516143388284637)&&(1e6*(qy-gop.relg1.qavey)<=6.805749761097288)&&gop.prf==1)', 46);

model.func('LSFy1').set('table', {});
model.func('LSFy1').setIndex('table', -6.660946574690962, 0, 0);
model.func('LSFy1').setIndex('table', 0, 0, 1);
model.func('LSFy1').setIndex('table', -6.371340201878311, 1, 0);
model.func('LSFy1').setIndex('table', 0, 1, 1);
model.func('LSFy1').setIndex('table', -6.081733829065661, 2, 0);
model.func('LSFy1').setIndex('table', 0.09012875536480687, 2, 1);
model.func('LSFy1').setIndex('table', -5.792127456253011, 3, 0);
model.func('LSFy1').setIndex('table', 0.19742489270386265, 3, 1);
model.func('LSFy1').setIndex('table', -5.50252108344036, 4, 0);
model.func('LSFy1').setIndex('table', 0.13304721030042918, 4, 1);
model.func('LSFy1').setIndex('table', -5.212914710627709, 5, 0);
model.func('LSFy1').setIndex('table', 0.15879828326180256, 5, 1);
model.func('LSFy1').setIndex('table', -4.923308337815059, 6, 0);
model.func('LSFy1').setIndex('table', 0.13733905579399142, 6, 1);
model.func('LSFy1').setIndex('table', -4.633701965002409, 7, 0);
model.func('LSFy1').setIndex('table', 0.15021459227467812, 7, 1);
model.func('LSFy1').setIndex('table', -4.344095592189758, 8, 0);
model.func('LSFy1').setIndex('table', 0.13733905579399142, 8, 1);
model.func('LSFy1').setIndex('table', -4.054489219377107, 9, 0);
model.func('LSFy1').setIndex('table', 0.1630901287553648, 9, 1);
model.func('LSFy1').setIndex('table', -3.764882846564457, 10, 0);
model.func('LSFy1').setIndex('table', 0.12017167381974249, 10, 1);
model.func('LSFy1').setIndex('table', -3.4752764737518063, 11, 0);
model.func('LSFy1').setIndex('table', 0.1888412017167382, 11, 1);
model.func('LSFy1').setIndex('table', -3.1856701009391557, 12, 0);
model.func('LSFy1').setIndex('table', 0.12017167381974249, 12, 1);
model.func('LSFy1').setIndex('table', -2.896063728126505, 13, 0);
model.func('LSFy1').setIndex('table', 0.2017167381974249, 13, 1);
model.func('LSFy1').setIndex('table', -2.6064573553138546, 14, 0);
model.func('LSFy1').setIndex('table', 0.1630901287553648, 14, 1);
model.func('LSFy1').setIndex('table', -2.3168509825012045, 15, 0);
model.func('LSFy1').setIndex('table', 0.19313304721030042, 15, 1);
model.func('LSFy1').setIndex('table', -2.0272446096885535, 16, 0);
model.func('LSFy1').setIndex('table', 0.22317596566523606, 16, 1);
model.func('LSFy1').setIndex('table', -1.7376382368759025, 17, 0);
model.func('LSFy1').setIndex('table', 0.4034334763948498, 17, 1);
model.func('LSFy1').setIndex('table', -1.4480318640632523, 18, 0);
model.func('LSFy1').setIndex('table', 0.44635193133047213, 18, 1);
model.func('LSFy1').setIndex('table', -1.1584254912506022, 19, 0);
model.func('LSFy1').setIndex('table', 0.4721030042918455, 19, 1);
model.func('LSFy1').setIndex('table', -0.8688191184379512, 20, 0);
model.func('LSFy1').setIndex('table', 0.5321888412017167, 20, 1);
model.func('LSFy1').setIndex('table', -0.5792127456253002, 21, 0);
model.func('LSFy1').setIndex('table', 0.6051502145922747, 21, 1);
model.func('LSFy1').setIndex('table', -0.2896063728126501, 22, 0);
model.func('LSFy1').setIndex('table', 0.6523605150214592, 22, 1);
model.func('LSFy1').setIndex('table', 0, 23, 0);
model.func('LSFy1').setIndex('table', 1, 23, 1);
model.func('LSFy1').setIndex('table', 0.289606372812651, 24, 0);
model.func('LSFy1').setIndex('table', 0.6523605150214592, 24, 1);
model.func('LSFy1').setIndex('table', 0.579212745625302, 25, 0);
model.func('LSFy1').setIndex('table', 0.6051502145922747, 25, 1);
model.func('LSFy1').setIndex('table', 0.8688191184379521, 26, 0);
model.func('LSFy1').setIndex('table', 0.5364806866952789, 26, 1);
model.func('LSFy1').setIndex('table', 1.1584254912506022, 27, 0);
model.func('LSFy1').setIndex('table', 0.4678111587982833, 27, 1);
model.func('LSFy1').setIndex('table', 1.4480318640632532, 28, 0);
model.func('LSFy1').setIndex('table', 0.44635193133047213, 28, 1);
model.func('LSFy1').setIndex('table', 1.7376382368759042, 29, 0);
model.func('LSFy1').setIndex('table', 0.4034334763948498, 29, 1);
model.func('LSFy1').setIndex('table', 2.0272446096885535, 30, 0);
model.func('LSFy1').setIndex('table', 0.21888412017167383, 30, 1);
model.func('LSFy1').setIndex('table', 2.3168509825012045, 31, 0);
model.func('LSFy1').setIndex('table', 0.19742489270386265, 31, 1);
model.func('LSFy1').setIndex('table', 2.6064573553138555, 32, 0);
model.func('LSFy1').setIndex('table', 0.1630901287553648, 32, 1);
model.func('LSFy1').setIndex('table', 2.8960637281265065, 33, 0);
model.func('LSFy1').setIndex('table', 0.2017167381974249, 33, 1);
model.func('LSFy1').setIndex('table', 3.1856701009391575, 34, 0);
model.func('LSFy1').setIndex('table', 0.12017167381974249, 34, 1);
model.func('LSFy1').setIndex('table', 3.4752764737518067, 35, 0);
model.func('LSFy1').setIndex('table', 0.1888412017167382, 35, 1);
model.func('LSFy1').setIndex('table', 3.7648828465644577, 36, 0);
model.func('LSFy1').setIndex('table', 0.12017167381974249, 36, 1);
model.func('LSFy1').setIndex('table', 4.054489219377109, 37, 0);
model.func('LSFy1').setIndex('table', 0.1630901287553648, 37, 1);
model.func('LSFy1').setIndex('table', 4.344095592189758, 38, 0);
model.func('LSFy1').setIndex('table', 0.14163090128755365, 38, 1);
model.func('LSFy1').setIndex('table', 4.633701965002409, 39, 0);
model.func('LSFy1').setIndex('table', 0.1459227467811159, 39, 1);
model.func('LSFy1').setIndex('table', 4.92330833781506, 40, 0);
model.func('LSFy1').setIndex('table', 0.13733905579399142, 40, 1);
model.func('LSFy1').setIndex('table', 5.212914710627711, 41, 0);
model.func('LSFy1').setIndex('table', 0.15879828326180256, 41, 1);
model.func('LSFy1').setIndex('table', 5.502521083440362, 42, 0);
model.func('LSFy1').setIndex('table', 0.13304721030042918, 42, 1);
model.func('LSFy1').setIndex('table', 5.792127456253011, 43, 0);
model.func('LSFy1').setIndex('table', 0.19742489270386265, 43, 1);
model.func('LSFy1').setIndex('table', 6.081733829065662, 44, 0);
model.func('LSFy1').setIndex('table', 0.09012875536480687, 44, 1);
model.func('LSFy1').setIndex('table', 6.371340201878313, 45, 0);
model.func('LSFy1').setIndex('table', 0, 45, 1);
model.func('LSFy1').setIndex('table', 6.660946574690962, 46, 0);
model.func('LSFy1').setIndex('table', 0, 46, 1);

model.result.dataset('lsfy1').set('source', 'function');
model.result.dataset('lsfy1').set('function', 'LSFy1');
model.result.dataset('lsfy1').set('parmin1', '-6.660946574690962');
model.result.dataset('lsfy1').set('parmax1', '6.660946574690962');
model.result.dataset('lsfy1').set('par1', 'y_out');

model.func.create('Lcosx2', 'Analytic');
model.func('Lcosx2').label('Lcosx2');

model.nodeGroup('mtfgrp2').add('func', 'Lcosx2');

model.func('Lcosx2').set('funcname', 'Lcosx2');
model.func('Lcosx2').set('expr', 'LSFx2(x)*cos(2*pi*nu*x/1e3)');
model.func('Lcosx2').set('args', 'x, nu');
model.func('Lcosx2').setIndex('plotargs', -9.347872925314553, 0, 1);
model.func('Lcosx2').setIndex('plotargs', 9.347872925314553, 0, 2);
model.func('Lcosx2').setIndex('plotargs', 0, 1, 1);
model.func('Lcosx2').setIndex('plotargs', '125', 1, 2);
model.func.create('Lsinx2', 'Analytic');
model.func('Lsinx2').label('Lsinx2');

model.nodeGroup('mtfgrp2').add('func', 'Lsinx2');

model.func('Lsinx2').set('funcname', 'Lsinx2');
model.func('Lsinx2').set('expr', 'LSFx2(x)*sin(2*pi*nu*x/1e3)');
model.func('Lsinx2').set('args', 'x, nu');
model.func('Lsinx2').setIndex('plotargs', -9.347872925314553, 0, 1);
model.func('Lsinx2').setIndex('plotargs', 9.347872925314553, 0, 2);
model.func('Lsinx2').setIndex('plotargs', 0, 1, 1);
model.func('Lsinx2').setIndex('plotargs', '125', 1, 2);

model.result.numerical.create('gevLSFx2', 'EvalGlobal');
model.result.numerical('gevLSFx2').label('gevLSFx2');

model.nodeGroup('numgrp').add('numerical', 'gevLSFx2');

model.result.numerical('gevLSFx2').set('data', 'ray1');
model.result.numerical('gevLSFx2').set('innerinput', 'last');
model.result.numerical('gevLSFx2').set('expr', {});
model.result.numerical('gevLSFx2').set('descr', {});
model.result.numerical('gevLSFx2').setIndex('expr', 'gop.sum((1e6*(qx-gop.relg2.qavex)>-9.551087554125738)&&(1e6*(qx-gop.relg2.qavex)<=-9.144658296503367)&&gop.prf==2)', 0);
model.result.numerical('gevLSFx2').setIndex('expr', 'gop.sum((1e6*(qx-gop.relg2.qavex)>-9.144658296503366)&&(1e6*(qx-gop.relg2.qavex)<=-8.738229038880995)&&gop.prf==2)', 1);
model.result.numerical('gevLSFx2').setIndex('expr', 'gop.sum((1e6*(qx-gop.relg2.qavex)>-8.738229038880995)&&(1e6*(qx-gop.relg2.qavex)<=-8.331799781258624)&&gop.prf==2)', 2);
model.result.numerical('gevLSFx2').setIndex('expr', 'gop.sum((1e6*(qx-gop.relg2.qavex)>-8.331799781258622)&&(1e6*(qx-gop.relg2.qavex)<=-7.925370523636251)&&gop.prf==2)', 3);
model.result.numerical('gevLSFx2').setIndex('expr', 'gop.sum((1e6*(qx-gop.relg2.qavex)>-7.925370523636252)&&(1e6*(qx-gop.relg2.qavex)<=-7.518941266013879)&&gop.prf==2)', 4);
model.result.numerical('gevLSFx2').setIndex('expr', 'gop.sum((1e6*(qx-gop.relg2.qavex)>-7.51894126601388)&&(1e6*(qx-gop.relg2.qavex)<=-7.112512008391508)&&gop.prf==2)', 5);
model.result.numerical('gevLSFx2').setIndex('expr', 'gop.sum((1e6*(qx-gop.relg2.qavex)>-7.112512008391508)&&(1e6*(qx-gop.relg2.qavex)<=-6.706082750769135)&&gop.prf==2)', 6);
model.result.numerical('gevLSFx2').setIndex('expr', 'gop.sum((1e6*(qx-gop.relg2.qavex)>-6.706082750769136)&&(1e6*(qx-gop.relg2.qavex)<=-6.299653493146764)&&gop.prf==2)', 7);
model.result.numerical('gevLSFx2').setIndex('expr', 'gop.sum((1e6*(qx-gop.relg2.qavex)>-6.2996534931467645)&&(1e6*(qx-gop.relg2.qavex)<=-5.893224235524392)&&gop.prf==2)', 8);
model.result.numerical('gevLSFx2').setIndex('expr', 'gop.sum((1e6*(qx-gop.relg2.qavex)>-5.893224235524392)&&(1e6*(qx-gop.relg2.qavex)<=-5.4867949779020195)&&gop.prf==2)', 9);
model.result.numerical('gevLSFx2').setIndex('expr', 'gop.sum((1e6*(qx-gop.relg2.qavex)>-5.48679497790202)&&(1e6*(qx-gop.relg2.qavex)<=-5.080365720279648)&&gop.prf==2)', 10);
model.result.numerical('gevLSFx2').setIndex('expr', 'gop.sum((1e6*(qx-gop.relg2.qavex)>-5.080365720279649)&&(1e6*(qx-gop.relg2.qavex)<=-4.673936462657276)&&gop.prf==2)', 11);
model.result.numerical('gevLSFx2').setIndex('expr', 'gop.sum((1e6*(qx-gop.relg2.qavex)>-4.673936462657276)&&(1e6*(qx-gop.relg2.qavex)<=-4.267507205034904)&&gop.prf==2)', 12);
model.result.numerical('gevLSFx2').setIndex('expr', 'gop.sum((1e6*(qx-gop.relg2.qavex)>-4.267507205034905)&&(1e6*(qx-gop.relg2.qavex)<=-3.8610779474125327)&&gop.prf==2)', 13);
model.result.numerical('gevLSFx2').setIndex('expr', 'gop.sum((1e6*(qx-gop.relg2.qavex)>-3.8610779474125327)&&(1e6*(qx-gop.relg2.qavex)<=-3.454648689790161)&&gop.prf==2)', 14);
model.result.numerical('gevLSFx2').setIndex('expr', 'gop.sum((1e6*(qx-gop.relg2.qavex)>-3.4546486897901603)&&(1e6*(qx-gop.relg2.qavex)<=-3.0482194321677887)&&gop.prf==2)', 15);
model.result.numerical('gevLSFx2').setIndex('expr', 'gop.sum((1e6*(qx-gop.relg2.qavex)>-3.0482194321677887)&&(1e6*(qx-gop.relg2.qavex)<=-2.641790174545417)&&gop.prf==2)', 16);
model.result.numerical('gevLSFx2').setIndex('expr', 'gop.sum((1e6*(qx-gop.relg2.qavex)>-2.641790174545417)&&(1e6*(qx-gop.relg2.qavex)<=-2.2353609169230455)&&gop.prf==2)', 17);
model.result.numerical('gevLSFx2').setIndex('expr', 'gop.sum((1e6*(qx-gop.relg2.qavex)>-2.2353609169230446)&&(1e6*(qx-gop.relg2.qavex)<=-1.8289316593006728)&&gop.prf==2)', 18);
model.result.numerical('gevLSFx2').setIndex('expr', 'gop.sum((1e6*(qx-gop.relg2.qavex)>-1.8289316593006733)&&(1e6*(qx-gop.relg2.qavex)<=-1.4225024016783012)&&gop.prf==2)', 19);
model.result.numerical('gevLSFx2').setIndex('expr', 'gop.sum((1e6*(qx-gop.relg2.qavex)>-1.4225024016783017)&&(1e6*(qx-gop.relg2.qavex)<=-1.0160731440559296)&&gop.prf==2)', 20);
model.result.numerical('gevLSFx2').setIndex('expr', 'gop.sum((1e6*(qx-gop.relg2.qavex)>-1.0160731440559292)&&(1e6*(qx-gop.relg2.qavex)<=-0.6096438864335573)&&gop.prf==2)', 21);
model.result.numerical('gevLSFx2').setIndex('expr', 'gop.sum((1e6*(qx-gop.relg2.qavex)>-0.6096438864335584)&&(1e6*(qx-gop.relg2.qavex)<=-0.20321462881118654)&&gop.prf==2)', 22);
model.result.numerical('gevLSFx2').setIndex('expr', 'gop.sum((1e6*(qx-gop.relg2.qavex)>-0.20321462881118593)&&(1e6*(qx-gop.relg2.qavex)<=0.20321462881118593)&&gop.prf==2)', 23);
model.result.numerical('gevLSFx2').setIndex('expr', 'gop.sum((1e6*(qx-gop.relg2.qavex)>0.20321462881118654)&&(1e6*(qx-gop.relg2.qavex)<=0.6096438864335584)&&gop.prf==2)', 24);
model.result.numerical('gevLSFx2').setIndex('expr', 'gop.sum((1e6*(qx-gop.relg2.qavex)>0.6096438864335573)&&(1e6*(qx-gop.relg2.qavex)<=1.0160731440559292)&&gop.prf==2)', 25);
model.result.numerical('gevLSFx2').setIndex('expr', 'gop.sum((1e6*(qx-gop.relg2.qavex)>1.0160731440559296)&&(1e6*(qx-gop.relg2.qavex)<=1.4225024016783017)&&gop.prf==2)', 26);
model.result.numerical('gevLSFx2').setIndex('expr', 'gop.sum((1e6*(qx-gop.relg2.qavex)>1.422502401678302)&&(1e6*(qx-gop.relg2.qavex)<=1.8289316593006741)&&gop.prf==2)', 27);
model.result.numerical('gevLSFx2').setIndex('expr', 'gop.sum((1e6*(qx-gop.relg2.qavex)>1.8289316593006728)&&(1e6*(qx-gop.relg2.qavex)<=2.2353609169230446)&&gop.prf==2)', 28);
model.result.numerical('gevLSFx2').setIndex('expr', 'gop.sum((1e6*(qx-gop.relg2.qavex)>2.2353609169230455)&&(1e6*(qx-gop.relg2.qavex)<=2.641790174545417)&&gop.prf==2)', 29);
model.result.numerical('gevLSFx2').setIndex('expr', 'gop.sum((1e6*(qx-gop.relg2.qavex)>2.641790174545418)&&(1e6*(qx-gop.relg2.qavex)<=3.0482194321677896)&&gop.prf==2)', 30);
model.result.numerical('gevLSFx2').setIndex('expr', 'gop.sum((1e6*(qx-gop.relg2.qavex)>3.0482194321677887)&&(1e6*(qx-gop.relg2.qavex)<=3.4546486897901603)&&gop.prf==2)', 31);
model.result.numerical('gevLSFx2').setIndex('expr', 'gop.sum((1e6*(qx-gop.relg2.qavex)>3.454648689790161)&&(1e6*(qx-gop.relg2.qavex)<=3.8610779474125327)&&gop.prf==2)', 32);
model.result.numerical('gevLSFx2').setIndex('expr', 'gop.sum((1e6*(qx-gop.relg2.qavex)>3.8610779474125336)&&(1e6*(qx-gop.relg2.qavex)<=4.267507205034906)&&gop.prf==2)', 33);
model.result.numerical('gevLSFx2').setIndex('expr', 'gop.sum((1e6*(qx-gop.relg2.qavex)>4.267507205034904)&&(1e6*(qx-gop.relg2.qavex)<=4.673936462657276)&&gop.prf==2)', 34);
model.result.numerical('gevLSFx2').setIndex('expr', 'gop.sum((1e6*(qx-gop.relg2.qavex)>4.673936462657276)&&(1e6*(qx-gop.relg2.qavex)<=5.080365720279649)&&gop.prf==2)', 35);
model.result.numerical('gevLSFx2').setIndex('expr', 'gop.sum((1e6*(qx-gop.relg2.qavex)>5.080365720279649)&&(1e6*(qx-gop.relg2.qavex)<=5.486794977902021)&&gop.prf==2)', 36);
model.result.numerical('gevLSFx2').setIndex('expr', 'gop.sum((1e6*(qx-gop.relg2.qavex)>5.4867949779020195)&&(1e6*(qx-gop.relg2.qavex)<=5.893224235524392)&&gop.prf==2)', 37);
model.result.numerical('gevLSFx2').setIndex('expr', 'gop.sum((1e6*(qx-gop.relg2.qavex)>5.893224235524392)&&(1e6*(qx-gop.relg2.qavex)<=6.2996534931467645)&&gop.prf==2)', 38);
model.result.numerical('gevLSFx2').setIndex('expr', 'gop.sum((1e6*(qx-gop.relg2.qavex)>6.2996534931467645)&&(1e6*(qx-gop.relg2.qavex)<=6.706082750769137)&&gop.prf==2)', 39);
model.result.numerical('gevLSFx2').setIndex('expr', 'gop.sum((1e6*(qx-gop.relg2.qavex)>6.706082750769135)&&(1e6*(qx-gop.relg2.qavex)<=7.112512008391508)&&gop.prf==2)', 40);
model.result.numerical('gevLSFx2').setIndex('expr', 'gop.sum((1e6*(qx-gop.relg2.qavex)>7.112512008391506)&&(1e6*(qx-gop.relg2.qavex)<=7.518941266013878)&&gop.prf==2)', 41);
model.result.numerical('gevLSFx2').setIndex('expr', 'gop.sum((1e6*(qx-gop.relg2.qavex)>7.51894126601388)&&(1e6*(qx-gop.relg2.qavex)<=7.925370523636253)&&gop.prf==2)', 42);
model.result.numerical('gevLSFx2').setIndex('expr', 'gop.sum((1e6*(qx-gop.relg2.qavex)>7.925370523636251)&&(1e6*(qx-gop.relg2.qavex)<=8.331799781258622)&&gop.prf==2)', 43);
model.result.numerical('gevLSFx2').setIndex('expr', 'gop.sum((1e6*(qx-gop.relg2.qavex)>8.331799781258622)&&(1e6*(qx-gop.relg2.qavex)<=8.738229038880993)&&gop.prf==2)', 44);
model.result.numerical('gevLSFx2').setIndex('expr', 'gop.sum((1e6*(qx-gop.relg2.qavex)>8.738229038880997)&&(1e6*(qx-gop.relg2.qavex)<=9.144658296503367)&&gop.prf==2)', 45);
model.result.numerical('gevLSFx2').setIndex('expr', 'gop.sum((1e6*(qx-gop.relg2.qavex)>9.144658296503367)&&(1e6*(qx-gop.relg2.qavex)<=9.551087554125738)&&gop.prf==2)', 46);

model.func.create('LSFx2', 'Interpolation');
model.func('LSFx2').label('LSFx2');

model.nodeGroup('mtfgrp2').add('func', 'LSFx2');

model.func('LSFx2').set('funcname', 'LSFx2');
model.func('LSFx2').set('interp', 'piecewisecubic');
model.func('LSFx2').set('extrap', 'const');
model.func('LSFx2').set('defineprimfun', true);
model.func('LSFx2').set('table', {});
model.func('LSFx2').setIndex('table', -9.347872925314553, 0, 0);
model.func('LSFx2').setIndex('table', 0, 0, 1);
model.func('LSFx2').setIndex('table', -8.94144366769218, 1, 0);
model.func('LSFx2').setIndex('table', 0, 1, 1);
model.func('LSFx2').setIndex('table', -8.53501441006981, 2, 0);
model.func('LSFx2').setIndex('table', 0, 2, 1);
model.func('LSFx2').setIndex('table', -8.128585152447437, 3, 0);
model.func('LSFx2').setIndex('table', 0, 3, 1);
model.func('LSFx2').setIndex('table', -7.7221558948250655, 4, 0);
model.func('LSFx2').setIndex('table', 0, 4, 1);
model.func('LSFx2').setIndex('table', -7.315726637202694, 5, 0);
model.func('LSFx2').setIndex('table', 0, 5, 1);
model.func('LSFx2').setIndex('table', -6.909297379580321, 6, 0);
model.func('LSFx2').setIndex('table', 0, 6, 1);
model.func('LSFx2').setIndex('table', -6.50286812195795, 7, 0);
model.func('LSFx2').setIndex('table', 0, 7, 1);
model.func('LSFx2').setIndex('table', -6.096438864335578, 8, 0);
model.func('LSFx2').setIndex('table', 0, 8, 1);
model.func('LSFx2').setIndex('table', -5.690009606713206, 9, 0);
model.func('LSFx2').setIndex('table', 0, 9, 1);
model.func('LSFx2').setIndex('table', -5.283580349090834, 10, 0);
model.func('LSFx2').setIndex('table', 0, 10, 1);
model.func('LSFx2').setIndex('table', -4.877151091468463, 11, 0);
model.func('LSFx2').setIndex('table', 0.039603960396039604, 11, 1);
model.func('LSFx2').setIndex('table', -4.47072183384609, 12, 0);
model.func('LSFx2').setIndex('table', 0.056105610561056105, 12, 1);
model.func('LSFx2').setIndex('table', -4.0642925762237185, 13, 0);
model.func('LSFx2').setIndex('table', 0.0594059405940594, 13, 1);
model.func('LSFx2').setIndex('table', -3.657863318601347, 14, 0);
model.func('LSFx2').setIndex('table', 0.06105610561056106, 14, 1);
model.func('LSFx2').setIndex('table', -3.2514340609789745, 15, 0);
model.func('LSFx2').setIndex('table', 0.054455445544554455, 15, 1);
model.func('LSFx2').setIndex('table', -2.845004803356603, 16, 0);
model.func('LSFx2').setIndex('table', 0.0627062706270627, 16, 1);
model.func('LSFx2').setIndex('table', -2.4385755457342313, 17, 0);
model.func('LSFx2').setIndex('table', 0.0594059405940594, 17, 1);
model.func('LSFx2').setIndex('table', -2.032146288111859, 18, 0);
model.func('LSFx2').setIndex('table', 0.08085808580858085, 18, 1);
model.func('LSFx2').setIndex('table', -1.6257170304894872, 19, 0);
model.func('LSFx2').setIndex('table', 0.09075907590759076, 19, 1);
model.func('LSFx2').setIndex('table', -1.2192877728671156, 20, 0);
model.func('LSFx2').setIndex('table', 0.09900990099009901, 20, 1);
model.func('LSFx2').setIndex('table', -0.8128585152447432, 21, 0);
model.func('LSFx2').setIndex('table', 0.18316831683168316, 21, 1);
model.func('LSFx2').setIndex('table', -0.4064292576223725, 22, 0);
model.func('LSFx2').setIndex('table', 0.5016501650165016, 22, 1);
model.func('LSFx2').setIndex('table', 0, 23, 0);
model.func('LSFx2').setIndex('table', 1, 23, 1);
model.func('LSFx2').setIndex('table', 0.4064292576223725, 24, 0);
model.func('LSFx2').setIndex('table', 0.5016501650165016, 24, 1);
model.func('LSFx2').setIndex('table', 0.8128585152447432, 25, 0);
model.func('LSFx2').setIndex('table', 0.18316831683168316, 25, 1);
model.func('LSFx2').setIndex('table', 1.2192877728671156, 26, 0);
model.func('LSFx2').setIndex('table', 0.09900990099009901, 26, 1);
model.func('LSFx2').setIndex('table', 1.6257170304894881, 27, 0);
model.func('LSFx2').setIndex('table', 0.09075907590759076, 27, 1);
model.func('LSFx2').setIndex('table', 2.032146288111859, 28, 0);
model.func('LSFx2').setIndex('table', 0.08085808580858085, 28, 1);
model.func('LSFx2').setIndex('table', 2.4385755457342313, 29, 0);
model.func('LSFx2').setIndex('table', 0.0594059405940594, 29, 1);
model.func('LSFx2').setIndex('table', 2.8450048033566038, 30, 0);
model.func('LSFx2').setIndex('table', 0.0627062706270627, 30, 1);
model.func('LSFx2').setIndex('table', 3.2514340609789745, 31, 0);
model.func('LSFx2').setIndex('table', 0.054455445544554455, 31, 1);
model.func('LSFx2').setIndex('table', 3.657863318601347, 32, 0);
model.func('LSFx2').setIndex('table', 0.06105610561056106, 32, 1);
model.func('LSFx2').setIndex('table', 4.064292576223719, 33, 0);
model.func('LSFx2').setIndex('table', 0.06105610561056106, 33, 1);
model.func('LSFx2').setIndex('table', 4.47072183384609, 34, 0);
model.func('LSFx2').setIndex('table', 0.054455445544554455, 34, 1);
model.func('LSFx2').setIndex('table', 4.877151091468463, 35, 0);
model.func('LSFx2').setIndex('table', 0.039603960396039604, 35, 1);
model.func('LSFx2').setIndex('table', 5.283580349090835, 36, 0);
model.func('LSFx2').setIndex('table', 0, 36, 1);
model.func('LSFx2').setIndex('table', 5.690009606713206, 37, 0);
model.func('LSFx2').setIndex('table', 0, 37, 1);
model.func('LSFx2').setIndex('table', 6.096438864335578, 38, 0);
model.func('LSFx2').setIndex('table', 0, 38, 1);
model.func('LSFx2').setIndex('table', 6.502868121957951, 39, 0);
model.func('LSFx2').setIndex('table', 0, 39, 1);
model.func('LSFx2').setIndex('table', 6.909297379580321, 40, 0);
model.func('LSFx2').setIndex('table', 0, 40, 1);
model.func('LSFx2').setIndex('table', 7.315726637202692, 41, 0);
model.func('LSFx2').setIndex('table', 0, 41, 1);
model.func('LSFx2').setIndex('table', 7.722155894825066, 42, 0);
model.func('LSFx2').setIndex('table', 0, 42, 1);
model.func('LSFx2').setIndex('table', 8.128585152447437, 43, 0);
model.func('LSFx2').setIndex('table', 0, 43, 1);
model.func('LSFx2').setIndex('table', 8.535014410069808, 44, 0);
model.func('LSFx2').setIndex('table', 0, 44, 1);
model.func('LSFx2').setIndex('table', 8.941443667692182, 45, 0);
model.func('LSFx2').setIndex('table', 0, 45, 1);
model.func('LSFx2').setIndex('table', 9.347872925314553, 46, 0);
model.func('LSFx2').setIndex('table', 0, 46, 1);

model.result.dataset.create('lsfx2', 'Grid1D');
model.result.dataset('lsfx2').label('LSFx2');

model.nodeGroup('datagrp').add('dataset', 'lsfx2');

model.result.dataset('lsfx2').set('source', 'function');
model.result.dataset('lsfx2').set('function', 'LSFx2');
model.result.dataset('lsfx2').set('parmin1', '-9.347872925314553');
model.result.dataset('lsfx2').set('parmax1', '9.347872925314553');
model.result.dataset('lsfx2').set('par1', 'x_out');

model.func.create('Lcosy2', 'Analytic');
model.func('Lcosy2').label('Lcosy2');

model.nodeGroup('mtfgrp2').add('func', 'Lcosy2');

model.func('Lcosy2').set('funcname', 'Lcosy2');
model.func('Lcosy2').set('expr', 'LSFy2(y)*cos(2*pi*nu*y/1e3)');
model.func('Lcosy2').set('args', 'y, nu');
model.func('Lcosy2').setIndex('plotargs', -9.347872925314553, 0, 1);
model.func('Lcosy2').setIndex('plotargs', 9.347872925314553, 0, 2);
model.func('Lcosy2').setIndex('plotargs', 0, 1, 1);
model.func('Lcosy2').setIndex('plotargs', '125', 1, 2);
model.func.create('Lsiny2', 'Analytic');
model.func('Lsiny2').label('Lsiny2');

model.nodeGroup('mtfgrp2').add('func', 'Lsiny2');

model.func('Lsiny2').set('funcname', 'Lsiny2');
model.func('Lsiny2').set('expr', 'LSFy2(y)*sin(2*pi*nu*y/1e3)');
model.func('Lsiny2').set('args', 'y, nu');
model.func('Lsiny2').setIndex('plotargs', -9.347872925314553, 0, 1);
model.func('Lsiny2').setIndex('plotargs', 9.347872925314553, 0, 2);
model.func('Lsiny2').setIndex('plotargs', 0, 1, 1);
model.func('Lsiny2').setIndex('plotargs', '125', 1, 2);

model.result.numerical.create('gevLSFy2', 'EvalGlobal');
model.result.numerical('gevLSFy2').label('gevLSFy2');

model.nodeGroup('numgrp').add('numerical', 'gevLSFy2');

model.result.numerical('gevLSFy2').set('data', 'ray1');
model.result.numerical('gevLSFy2').set('innerinput', 'last');
model.result.numerical('gevLSFy2').set('expr', {});
model.result.numerical('gevLSFy2').set('descr', {});
model.result.numerical('gevLSFy2').setIndex('expr', 'gop.sum((1e6*(qy-gop.relg2.qavey)>-9.551087554125738)&&(1e6*(qy-gop.relg2.qavey)<=-9.144658296503367)&&gop.prf==2)', 0);
model.result.numerical('gevLSFy2').setIndex('expr', 'gop.sum((1e6*(qy-gop.relg2.qavey)>-9.144658296503366)&&(1e6*(qy-gop.relg2.qavey)<=-8.738229038880995)&&gop.prf==2)', 1);
model.result.numerical('gevLSFy2').setIndex('expr', 'gop.sum((1e6*(qy-gop.relg2.qavey)>-8.738229038880995)&&(1e6*(qy-gop.relg2.qavey)<=-8.331799781258624)&&gop.prf==2)', 2);
model.result.numerical('gevLSFy2').setIndex('expr', 'gop.sum((1e6*(qy-gop.relg2.qavey)>-8.331799781258622)&&(1e6*(qy-gop.relg2.qavey)<=-7.925370523636251)&&gop.prf==2)', 3);
model.result.numerical('gevLSFy2').setIndex('expr', 'gop.sum((1e6*(qy-gop.relg2.qavey)>-7.925370523636252)&&(1e6*(qy-gop.relg2.qavey)<=-7.518941266013879)&&gop.prf==2)', 4);
model.result.numerical('gevLSFy2').setIndex('expr', 'gop.sum((1e6*(qy-gop.relg2.qavey)>-7.51894126601388)&&(1e6*(qy-gop.relg2.qavey)<=-7.112512008391508)&&gop.prf==2)', 5);
model.result.numerical('gevLSFy2').setIndex('expr', 'gop.sum((1e6*(qy-gop.relg2.qavey)>-7.112512008391508)&&(1e6*(qy-gop.relg2.qavey)<=-6.706082750769135)&&gop.prf==2)', 6);
model.result.numerical('gevLSFy2').setIndex('expr', 'gop.sum((1e6*(qy-gop.relg2.qavey)>-6.706082750769136)&&(1e6*(qy-gop.relg2.qavey)<=-6.299653493146764)&&gop.prf==2)', 7);
model.result.numerical('gevLSFy2').setIndex('expr', 'gop.sum((1e6*(qy-gop.relg2.qavey)>-6.2996534931467645)&&(1e6*(qy-gop.relg2.qavey)<=-5.893224235524392)&&gop.prf==2)', 8);
model.result.numerical('gevLSFy2').setIndex('expr', 'gop.sum((1e6*(qy-gop.relg2.qavey)>-5.893224235524392)&&(1e6*(qy-gop.relg2.qavey)<=-5.4867949779020195)&&gop.prf==2)', 9);
model.result.numerical('gevLSFy2').setIndex('expr', 'gop.sum((1e6*(qy-gop.relg2.qavey)>-5.48679497790202)&&(1e6*(qy-gop.relg2.qavey)<=-5.080365720279648)&&gop.prf==2)', 10);
model.result.numerical('gevLSFy2').setIndex('expr', 'gop.sum((1e6*(qy-gop.relg2.qavey)>-5.080365720279649)&&(1e6*(qy-gop.relg2.qavey)<=-4.673936462657276)&&gop.prf==2)', 11);
model.result.numerical('gevLSFy2').setIndex('expr', 'gop.sum((1e6*(qy-gop.relg2.qavey)>-4.673936462657276)&&(1e6*(qy-gop.relg2.qavey)<=-4.267507205034904)&&gop.prf==2)', 12);
model.result.numerical('gevLSFy2').setIndex('expr', 'gop.sum((1e6*(qy-gop.relg2.qavey)>-4.267507205034905)&&(1e6*(qy-gop.relg2.qavey)<=-3.8610779474125327)&&gop.prf==2)', 13);
model.result.numerical('gevLSFy2').setIndex('expr', 'gop.sum((1e6*(qy-gop.relg2.qavey)>-3.8610779474125327)&&(1e6*(qy-gop.relg2.qavey)<=-3.454648689790161)&&gop.prf==2)', 14);
model.result.numerical('gevLSFy2').setIndex('expr', 'gop.sum((1e6*(qy-gop.relg2.qavey)>-3.4546486897901603)&&(1e6*(qy-gop.relg2.qavey)<=-3.0482194321677887)&&gop.prf==2)', 15);
model.result.numerical('gevLSFy2').setIndex('expr', 'gop.sum((1e6*(qy-gop.relg2.qavey)>-3.0482194321677887)&&(1e6*(qy-gop.relg2.qavey)<=-2.641790174545417)&&gop.prf==2)', 16);
model.result.numerical('gevLSFy2').setIndex('expr', 'gop.sum((1e6*(qy-gop.relg2.qavey)>-2.641790174545417)&&(1e6*(qy-gop.relg2.qavey)<=-2.2353609169230455)&&gop.prf==2)', 17);
model.result.numerical('gevLSFy2').setIndex('expr', 'gop.sum((1e6*(qy-gop.relg2.qavey)>-2.2353609169230446)&&(1e6*(qy-gop.relg2.qavey)<=-1.8289316593006728)&&gop.prf==2)', 18);
model.result.numerical('gevLSFy2').setIndex('expr', 'gop.sum((1e6*(qy-gop.relg2.qavey)>-1.8289316593006733)&&(1e6*(qy-gop.relg2.qavey)<=-1.4225024016783012)&&gop.prf==2)', 19);
model.result.numerical('gevLSFy2').setIndex('expr', 'gop.sum((1e6*(qy-gop.relg2.qavey)>-1.4225024016783017)&&(1e6*(qy-gop.relg2.qavey)<=-1.0160731440559296)&&gop.prf==2)', 20);
model.result.numerical('gevLSFy2').setIndex('expr', 'gop.sum((1e6*(qy-gop.relg2.qavey)>-1.0160731440559292)&&(1e6*(qy-gop.relg2.qavey)<=-0.6096438864335573)&&gop.prf==2)', 21);
model.result.numerical('gevLSFy2').setIndex('expr', 'gop.sum((1e6*(qy-gop.relg2.qavey)>-0.6096438864335584)&&(1e6*(qy-gop.relg2.qavey)<=-0.20321462881118654)&&gop.prf==2)', 22);
model.result.numerical('gevLSFy2').setIndex('expr', 'gop.sum((1e6*(qy-gop.relg2.qavey)>-0.20321462881118593)&&(1e6*(qy-gop.relg2.qavey)<=0.20321462881118593)&&gop.prf==2)', 23);
model.result.numerical('gevLSFy2').setIndex('expr', 'gop.sum((1e6*(qy-gop.relg2.qavey)>0.20321462881118654)&&(1e6*(qy-gop.relg2.qavey)<=0.6096438864335584)&&gop.prf==2)', 24);
model.result.numerical('gevLSFy2').setIndex('expr', 'gop.sum((1e6*(qy-gop.relg2.qavey)>0.6096438864335573)&&(1e6*(qy-gop.relg2.qavey)<=1.0160731440559292)&&gop.prf==2)', 25);
model.result.numerical('gevLSFy2').setIndex('expr', 'gop.sum((1e6*(qy-gop.relg2.qavey)>1.0160731440559296)&&(1e6*(qy-gop.relg2.qavey)<=1.4225024016783017)&&gop.prf==2)', 26);
model.result.numerical('gevLSFy2').setIndex('expr', 'gop.sum((1e6*(qy-gop.relg2.qavey)>1.422502401678302)&&(1e6*(qy-gop.relg2.qavey)<=1.8289316593006741)&&gop.prf==2)', 27);
model.result.numerical('gevLSFy2').setIndex('expr', 'gop.sum((1e6*(qy-gop.relg2.qavey)>1.8289316593006728)&&(1e6*(qy-gop.relg2.qavey)<=2.2353609169230446)&&gop.prf==2)', 28);
model.result.numerical('gevLSFy2').setIndex('expr', 'gop.sum((1e6*(qy-gop.relg2.qavey)>2.2353609169230455)&&(1e6*(qy-gop.relg2.qavey)<=2.641790174545417)&&gop.prf==2)', 29);
model.result.numerical('gevLSFy2').setIndex('expr', 'gop.sum((1e6*(qy-gop.relg2.qavey)>2.641790174545418)&&(1e6*(qy-gop.relg2.qavey)<=3.0482194321677896)&&gop.prf==2)', 30);
model.result.numerical('gevLSFy2').setIndex('expr', 'gop.sum((1e6*(qy-gop.relg2.qavey)>3.0482194321677887)&&(1e6*(qy-gop.relg2.qavey)<=3.4546486897901603)&&gop.prf==2)', 31);
model.result.numerical('gevLSFy2').setIndex('expr', 'gop.sum((1e6*(qy-gop.relg2.qavey)>3.454648689790161)&&(1e6*(qy-gop.relg2.qavey)<=3.8610779474125327)&&gop.prf==2)', 32);
model.result.numerical('gevLSFy2').setIndex('expr', 'gop.sum((1e6*(qy-gop.relg2.qavey)>3.8610779474125336)&&(1e6*(qy-gop.relg2.qavey)<=4.267507205034906)&&gop.prf==2)', 33);
model.result.numerical('gevLSFy2').setIndex('expr', 'gop.sum((1e6*(qy-gop.relg2.qavey)>4.267507205034904)&&(1e6*(qy-gop.relg2.qavey)<=4.673936462657276)&&gop.prf==2)', 34);
model.result.numerical('gevLSFy2').setIndex('expr', 'gop.sum((1e6*(qy-gop.relg2.qavey)>4.673936462657276)&&(1e6*(qy-gop.relg2.qavey)<=5.080365720279649)&&gop.prf==2)', 35);
model.result.numerical('gevLSFy2').setIndex('expr', 'gop.sum((1e6*(qy-gop.relg2.qavey)>5.080365720279649)&&(1e6*(qy-gop.relg2.qavey)<=5.486794977902021)&&gop.prf==2)', 36);
model.result.numerical('gevLSFy2').setIndex('expr', 'gop.sum((1e6*(qy-gop.relg2.qavey)>5.4867949779020195)&&(1e6*(qy-gop.relg2.qavey)<=5.893224235524392)&&gop.prf==2)', 37);
model.result.numerical('gevLSFy2').setIndex('expr', 'gop.sum((1e6*(qy-gop.relg2.qavey)>5.893224235524392)&&(1e6*(qy-gop.relg2.qavey)<=6.2996534931467645)&&gop.prf==2)', 38);
model.result.numerical('gevLSFy2').setIndex('expr', 'gop.sum((1e6*(qy-gop.relg2.qavey)>6.2996534931467645)&&(1e6*(qy-gop.relg2.qavey)<=6.706082750769137)&&gop.prf==2)', 39);
model.result.numerical('gevLSFy2').setIndex('expr', 'gop.sum((1e6*(qy-gop.relg2.qavey)>6.706082750769135)&&(1e6*(qy-gop.relg2.qavey)<=7.112512008391508)&&gop.prf==2)', 40);
model.result.numerical('gevLSFy2').setIndex('expr', 'gop.sum((1e6*(qy-gop.relg2.qavey)>7.112512008391506)&&(1e6*(qy-gop.relg2.qavey)<=7.518941266013878)&&gop.prf==2)', 41);
model.result.numerical('gevLSFy2').setIndex('expr', 'gop.sum((1e6*(qy-gop.relg2.qavey)>7.51894126601388)&&(1e6*(qy-gop.relg2.qavey)<=7.925370523636253)&&gop.prf==2)', 42);
model.result.numerical('gevLSFy2').setIndex('expr', 'gop.sum((1e6*(qy-gop.relg2.qavey)>7.925370523636251)&&(1e6*(qy-gop.relg2.qavey)<=8.331799781258622)&&gop.prf==2)', 43);
model.result.numerical('gevLSFy2').setIndex('expr', 'gop.sum((1e6*(qy-gop.relg2.qavey)>8.331799781258622)&&(1e6*(qy-gop.relg2.qavey)<=8.738229038880993)&&gop.prf==2)', 44);
model.result.numerical('gevLSFy2').setIndex('expr', 'gop.sum((1e6*(qy-gop.relg2.qavey)>8.738229038880997)&&(1e6*(qy-gop.relg2.qavey)<=9.144658296503367)&&gop.prf==2)', 45);
model.result.numerical('gevLSFy2').setIndex('expr', 'gop.sum((1e6*(qy-gop.relg2.qavey)>9.144658296503367)&&(1e6*(qy-gop.relg2.qavey)<=9.551087554125738)&&gop.prf==2)', 46);

model.func.create('LSFy2', 'Interpolation');
model.func('LSFy2').label('LSFy2');

model.nodeGroup('mtfgrp2').add('func', 'LSFy2');

model.func('LSFy2').set('funcname', 'LSFy2');
model.func('LSFy2').set('interp', 'piecewisecubic');
model.func('LSFy2').set('extrap', 'const');
model.func('LSFy2').set('defineprimfun', true);
model.func('LSFy2').set('table', {});
model.func('LSFy2').setIndex('table', -9.347872925314553, 0, 0);
model.func('LSFy2').setIndex('table', 0, 0, 1);
model.func('LSFy2').setIndex('table', -8.94144366769218, 1, 0);
model.func('LSFy2').setIndex('table', 0, 1, 1);
model.func('LSFy2').setIndex('table', -8.53501441006981, 2, 0);
model.func('LSFy2').setIndex('table', 0, 2, 1);
model.func('LSFy2').setIndex('table', -8.128585152447437, 3, 0);
model.func('LSFy2').setIndex('table', 0, 3, 1);
model.func('LSFy2').setIndex('table', -7.7221558948250655, 4, 0);
model.func('LSFy2').setIndex('table', 0, 4, 1);
model.func('LSFy2').setIndex('table', -7.315726637202694, 5, 0);
model.func('LSFy2').setIndex('table', 0, 5, 1);
model.func('LSFy2').setIndex('table', -6.909297379580321, 6, 0);
model.func('LSFy2').setIndex('table', 0, 6, 1);
model.func('LSFy2').setIndex('table', -6.50286812195795, 7, 0);
model.func('LSFy2').setIndex('table', 0, 7, 1);
model.func('LSFy2').setIndex('table', -6.096438864335578, 8, 0);
model.func('LSFy2').setIndex('table', 0, 8, 1);
model.func('LSFy2').setIndex('table', -5.690009606713206, 9, 0);
model.func('LSFy2').setIndex('table', 0, 9, 1);
model.func('LSFy2').setIndex('table', -5.283580349090834, 10, 0);
model.func('LSFy2').setIndex('table', 0.37962962962962965, 10, 1);
model.func('LSFy2').setIndex('table', -4.877151091468463, 11, 0);
model.func('LSFy2').setIndex('table', 1, 11, 1);
model.func('LSFy2').setIndex('table', -4.47072183384609, 12, 0);
model.func('LSFy2').setIndex('table', 0.7731481481481481, 12, 1);
model.func('LSFy2').setIndex('table', -4.0642925762237185, 13, 0);
model.func('LSFy2').setIndex('table', 0.6574074074074074, 13, 1);
model.func('LSFy2').setIndex('table', -3.657863318601347, 14, 0);
model.func('LSFy2').setIndex('table', 0.49537037037037035, 14, 1);
model.func('LSFy2').setIndex('table', -3.2514340609789745, 15, 0);
model.func('LSFy2').setIndex('table', 0.4212962962962963, 15, 1);
model.func('LSFy2').setIndex('table', -2.845004803356603, 16, 0);
model.func('LSFy2').setIndex('table', 0.39351851851851855, 16, 1);
model.func('LSFy2').setIndex('table', -2.4385755457342313, 17, 0);
model.func('LSFy2').setIndex('table', 0.30092592592592593, 17, 1);
model.func('LSFy2').setIndex('table', -2.032146288111859, 18, 0);
model.func('LSFy2').setIndex('table', 0.3472222222222222, 18, 1);
model.func('LSFy2').setIndex('table', -1.6257170304894872, 19, 0);
model.func('LSFy2').setIndex('table', 0.27314814814814814, 19, 1);
model.func('LSFy2').setIndex('table', -1.2192877728671156, 20, 0);
model.func('LSFy2').setIndex('table', 0.26851851851851855, 20, 1);
model.func('LSFy2').setIndex('table', -0.8128585152447432, 21, 0);
model.func('LSFy2').setIndex('table', 0.19907407407407407, 21, 1);
model.func('LSFy2').setIndex('table', -0.4064292576223725, 22, 0);
model.func('LSFy2').setIndex('table', 0.2222222222222222, 22, 1);
model.func('LSFy2').setIndex('table', 0, 23, 0);
model.func('LSFy2').setIndex('table', 0.19444444444444445, 23, 1);
model.func('LSFy2').setIndex('table', 0.4064292576223725, 24, 0);
model.func('LSFy2').setIndex('table', 0.25462962962962965, 24, 1);
model.func('LSFy2').setIndex('table', 0.8128585152447432, 25, 0);
model.func('LSFy2').setIndex('table', 0.16203703703703703, 25, 1);
model.func('LSFy2').setIndex('table', 1.2192877728671156, 26, 0);
model.func('LSFy2').setIndex('table', 0.2037037037037037, 26, 1);
model.func('LSFy2').setIndex('table', 1.6257170304894881, 27, 0);
model.func('LSFy2').setIndex('table', 0.21296296296296297, 27, 1);
model.func('LSFy2').setIndex('table', 2.032146288111859, 28, 0);
model.func('LSFy2').setIndex('table', 0.18518518518518517, 28, 1);
model.func('LSFy2').setIndex('table', 2.4385755457342313, 29, 0);
model.func('LSFy2').setIndex('table', 0.19907407407407407, 29, 1);
model.func('LSFy2').setIndex('table', 2.8450048033566038, 30, 0);
model.func('LSFy2').setIndex('table', 0.18518518518518517, 30, 1);
model.func('LSFy2').setIndex('table', 3.2514340609789745, 31, 0);
model.func('LSFy2').setIndex('table', 0.24537037037037038, 31, 1);
model.func('LSFy2').setIndex('table', 3.657863318601347, 32, 0);
model.func('LSFy2').setIndex('table', 0.20833333333333334, 32, 1);
model.func('LSFy2').setIndex('table', 4.064292576223719, 33, 0);
model.func('LSFy2').setIndex('table', 0.24074074074074073, 33, 1);
model.func('LSFy2').setIndex('table', 4.47072183384609, 34, 0);
model.func('LSFy2').setIndex('table', 0.23148148148148148, 34, 1);
model.func('LSFy2').setIndex('table', 4.877151091468463, 35, 0);
model.func('LSFy2').setIndex('table', 0.2222222222222222, 35, 1);
model.func('LSFy2').setIndex('table', 5.283580349090835, 36, 0);
model.func('LSFy2').setIndex('table', 0.20833333333333334, 36, 1);
model.func('LSFy2').setIndex('table', 5.690009606713206, 37, 0);
model.func('LSFy2').setIndex('table', 0.24074074074074073, 37, 1);
model.func('LSFy2').setIndex('table', 6.096438864335578, 38, 0);
model.func('LSFy2').setIndex('table', 0.19444444444444445, 38, 1);
model.func('LSFy2').setIndex('table', 6.502868121957951, 39, 0);
model.func('LSFy2').setIndex('table', 0.25, 39, 1);
model.func('LSFy2').setIndex('table', 6.909297379580321, 40, 0);
model.func('LSFy2').setIndex('table', 0.23148148148148148, 40, 1);
model.func('LSFy2').setIndex('table', 7.315726637202692, 41, 0);
model.func('LSFy2').setIndex('table', 0.24537037037037038, 41, 1);
model.func('LSFy2').setIndex('table', 7.722155894825066, 42, 0);
model.func('LSFy2').setIndex('table', 0.16666666666666666, 42, 1);
model.func('LSFy2').setIndex('table', 8.128585152447437, 43, 0);
model.func('LSFy2').setIndex('table', 0.23148148148148148, 43, 1);
model.func('LSFy2').setIndex('table', 8.535014410069808, 44, 0);
model.func('LSFy2').setIndex('table', 0.125, 44, 1);
model.func('LSFy2').setIndex('table', 8.941443667692182, 45, 0);
model.func('LSFy2').setIndex('table', 0, 45, 1);
model.func('LSFy2').setIndex('table', 9.347872925314553, 46, 0);
model.func('LSFy2').setIndex('table', 0, 46, 1);

model.result.dataset.create('lsfy2', 'Grid1D');
model.result.dataset('lsfy2').label('LSFy2');

model.nodeGroup('datagrp').add('dataset', 'lsfy2');

model.result.dataset('lsfy2').set('source', 'function');
model.result.dataset('lsfy2').set('function', 'LSFy2');
model.result.dataset('lsfy2').set('parmin1', '-9.347872925314553');
model.result.dataset('lsfy2').set('parmax1', '9.347872925314553');
model.result.dataset('lsfy2').set('par1', 'y_out');

model.func.create('Lcosx3', 'Analytic');
model.func('Lcosx3').label('Lcosx3');

model.nodeGroup('mtfgrp3').add('func', 'Lcosx3');

model.func('Lcosx3').set('funcname', 'Lcosx3');
model.func('Lcosx3').set('expr', 'LSFx3(x)*cos(2*pi*nu*x/1e3)');
model.func('Lcosx3').set('args', 'x, nu');
model.func('Lcosx3').setIndex('plotargs', -7.40391855382296, 0, 1);
model.func('Lcosx3').setIndex('plotargs', 7.40391855382296, 0, 2);
model.func('Lcosx3').setIndex('plotargs', 0, 1, 1);
model.func('Lcosx3').setIndex('plotargs', '125', 1, 2);
model.func.create('Lsinx3', 'Analytic');
model.func('Lsinx3').label('Lsinx3');

model.nodeGroup('mtfgrp3').add('func', 'Lsinx3');

model.func('Lsinx3').set('funcname', 'Lsinx3');
model.func('Lsinx3').set('expr', 'LSFx3(x)*sin(2*pi*nu*x/1e3)');
model.func('Lsinx3').set('args', 'x, nu');
model.func('Lsinx3').setIndex('plotargs', -7.40391855382296, 0, 1);
model.func('Lsinx3').setIndex('plotargs', 7.40391855382296, 0, 2);
model.func('Lsinx3').setIndex('plotargs', 0, 1, 1);
model.func('Lsinx3').setIndex('plotargs', '125', 1, 2);

model.result.numerical.create('gevLSFx3', 'EvalGlobal');
model.result.numerical('gevLSFx3').label('gevLSFx3');

model.nodeGroup('numgrp').add('numerical', 'gevLSFx3');

model.result.numerical('gevLSFx3').set('data', 'ray1');
model.result.numerical('gevLSFx3').set('innerinput', 'last');
model.result.numerical('gevLSFx3').set('expr', {});
model.result.numerical('gevLSFx3').set('descr', {});
model.result.numerical('gevLSFx3').setIndex('expr', 'gop.sum((1e6*(qx-gop.relg3.qavex)>-7.572189430046209)&&(1e6*(qx-gop.relg3.qavex)<=-7.235647677599711)&&gop.prf==3)', 0);
model.result.numerical('gevLSFx3').setIndex('expr', 'gop.sum((1e6*(qx-gop.relg3.qavex)>-7.235647677599711)&&(1e6*(qx-gop.relg3.qavex)<=-6.899105925153212)&&gop.prf==3)', 1);
model.result.numerical('gevLSFx3').setIndex('expr', 'gop.sum((1e6*(qx-gop.relg3.qavex)>-6.899105925153212)&&(1e6*(qx-gop.relg3.qavex)<=-6.562564172706714)&&gop.prf==3)', 2);
model.result.numerical('gevLSFx3').setIndex('expr', 'gop.sum((1e6*(qx-gop.relg3.qavex)>-6.562564172706715)&&(1e6*(qx-gop.relg3.qavex)<=-6.226022420260216)&&gop.prf==3)', 3);
model.result.numerical('gevLSFx3').setIndex('expr', 'gop.sum((1e6*(qx-gop.relg3.qavex)>-6.226022420260216)&&(1e6*(qx-gop.relg3.qavex)<=-5.889480667813718)&&gop.prf==3)', 4);
model.result.numerical('gevLSFx3').setIndex('expr', 'gop.sum((1e6*(qx-gop.relg3.qavex)>-5.889480667813718)&&(1e6*(qx-gop.relg3.qavex)<=-5.5529389153672195)&&gop.prf==3)', 5);
model.result.numerical('gevLSFx3').setIndex('expr', 'gop.sum((1e6*(qx-gop.relg3.qavex)>-5.55293891536722)&&(1e6*(qx-gop.relg3.qavex)<=-5.216397162920722)&&gop.prf==3)', 6);
model.result.numerical('gevLSFx3').setIndex('expr', 'gop.sum((1e6*(qx-gop.relg3.qavex)>-5.216397162920722)&&(1e6*(qx-gop.relg3.qavex)<=-4.8798554104742236)&&gop.prf==3)', 7);
model.result.numerical('gevLSFx3').setIndex('expr', 'gop.sum((1e6*(qx-gop.relg3.qavex)>-4.8798554104742236)&&(1e6*(qx-gop.relg3.qavex)<=-4.543313658027725)&&gop.prf==3)', 8);
model.result.numerical('gevLSFx3').setIndex('expr', 'gop.sum((1e6*(qx-gop.relg3.qavex)>-4.543313658027725)&&(1e6*(qx-gop.relg3.qavex)<=-4.206771905581227)&&gop.prf==3)', 9);
model.result.numerical('gevLSFx3').setIndex('expr', 'gop.sum((1e6*(qx-gop.relg3.qavex)>-4.206771905581227)&&(1e6*(qx-gop.relg3.qavex)<=-3.8702301531347283)&&gop.prf==3)', 10);
model.result.numerical('gevLSFx3').setIndex('expr', 'gop.sum((1e6*(qx-gop.relg3.qavex)>-3.870230153134729)&&(1e6*(qx-gop.relg3.qavex)<=-3.5336884006882308)&&gop.prf==3)', 11);
model.result.numerical('gevLSFx3').setIndex('expr', 'gop.sum((1e6*(qx-gop.relg3.qavex)>-3.5336884006882308)&&(1e6*(qx-gop.relg3.qavex)<=-3.1971466482417323)&&gop.prf==3)', 12);
model.result.numerical('gevLSFx3').setIndex('expr', 'gop.sum((1e6*(qx-gop.relg3.qavex)>-3.1971466482417323)&&(1e6*(qx-gop.relg3.qavex)<=-2.860604895795234)&&gop.prf==3)', 13);
model.result.numerical('gevLSFx3').setIndex('expr', 'gop.sum((1e6*(qx-gop.relg3.qavex)>-2.860604895795235)&&(1e6*(qx-gop.relg3.qavex)<=-2.5240631433487364)&&gop.prf==3)', 14);
model.result.numerical('gevLSFx3').setIndex('expr', 'gop.sum((1e6*(qx-gop.relg3.qavex)>-2.5240631433487364)&&(1e6*(qx-gop.relg3.qavex)<=-2.187521390902238)&&gop.prf==3)', 15);
model.result.numerical('gevLSFx3').setIndex('expr', 'gop.sum((1e6*(qx-gop.relg3.qavex)>-2.187521390902238)&&(1e6*(qx-gop.relg3.qavex)<=-1.8509796384557395)&&gop.prf==3)', 16);
model.result.numerical('gevLSFx3').setIndex('expr', 'gop.sum((1e6*(qx-gop.relg3.qavex)>-1.8509796384557395)&&(1e6*(qx-gop.relg3.qavex)<=-1.5144378860092411)&&gop.prf==3)', 17);
model.result.numerical('gevLSFx3').setIndex('expr', 'gop.sum((1e6*(qx-gop.relg3.qavex)>-1.5144378860092411)&&(1e6*(qx-gop.relg3.qavex)<=-1.1778961335627427)&&gop.prf==3)', 18);
model.result.numerical('gevLSFx3').setIndex('expr', 'gop.sum((1e6*(qx-gop.relg3.qavex)>-1.1778961335627436)&&(1e6*(qx-gop.relg3.qavex)<=-0.8413543811162453)&&gop.prf==3)', 19);
model.result.numerical('gevLSFx3').setIndex('expr', 'gop.sum((1e6*(qx-gop.relg3.qavex)>-0.841354381116245)&&(1e6*(qx-gop.relg3.qavex)<=-0.5048126286697469)&&gop.prf==3)', 20);
model.result.numerical('gevLSFx3').setIndex('expr', 'gop.sum((1e6*(qx-gop.relg3.qavex)>-0.5048126286697466)&&(1e6*(qx-gop.relg3.qavex)<=-0.16827087622324843)&&gop.prf==3)', 21);
model.result.numerical('gevLSFx3').setIndex('expr', 'gop.sum((1e6*(qx-gop.relg3.qavex)>-0.1682708762232491)&&(1e6*(qx-gop.relg3.qavex)<=0.1682708762232491)&&gop.prf==3)', 22);
model.result.numerical('gevLSFx3').setIndex('expr', 'gop.sum((1e6*(qx-gop.relg3.qavex)>0.16827087622324932)&&(1e6*(qx-gop.relg3.qavex)<=0.5048126286697475)&&gop.prf==3)', 23);
model.result.numerical('gevLSFx3').setIndex('expr', 'gop.sum((1e6*(qx-gop.relg3.qavex)>0.5048126286697477)&&(1e6*(qx-gop.relg3.qavex)<=0.8413543811162459)&&gop.prf==3)', 24);
model.result.numerical('gevLSFx3').setIndex('expr', 'gop.sum((1e6*(qx-gop.relg3.qavex)>0.8413543811162462)&&(1e6*(qx-gop.relg3.qavex)<=1.1778961335627445)&&gop.prf==3)', 25);
model.result.numerical('gevLSFx3').setIndex('expr', 'gop.sum((1e6*(qx-gop.relg3.qavex)>1.1778961335627445)&&(1e6*(qx-gop.relg3.qavex)<=1.514437886009243)&&gop.prf==3)', 26);
model.result.numerical('gevLSFx3').setIndex('expr', 'gop.sum((1e6*(qx-gop.relg3.qavex)>1.514437886009243)&&(1e6*(qx-gop.relg3.qavex)<=1.8509796384557413)&&gop.prf==3)', 27);
model.result.numerical('gevLSFx3').setIndex('expr', 'gop.sum((1e6*(qx-gop.relg3.qavex)>1.8509796384557395)&&(1e6*(qx-gop.relg3.qavex)<=2.187521390902238)&&gop.prf==3)', 28);
model.result.numerical('gevLSFx3').setIndex('expr', 'gop.sum((1e6*(qx-gop.relg3.qavex)>2.187521390902238)&&(1e6*(qx-gop.relg3.qavex)<=2.5240631433487364)&&gop.prf==3)', 29);
model.result.numerical('gevLSFx3').setIndex('expr', 'gop.sum((1e6*(qx-gop.relg3.qavex)>2.5240631433487364)&&(1e6*(qx-gop.relg3.qavex)<=2.860604895795235)&&gop.prf==3)', 30);
model.result.numerical('gevLSFx3').setIndex('expr', 'gop.sum((1e6*(qx-gop.relg3.qavex)>2.860604895795235)&&(1e6*(qx-gop.relg3.qavex)<=3.1971466482417332)&&gop.prf==3)', 31);
model.result.numerical('gevLSFx3').setIndex('expr', 'gop.sum((1e6*(qx-gop.relg3.qavex)>3.1971466482417332)&&(1e6*(qx-gop.relg3.qavex)<=3.5336884006882316)&&gop.prf==3)', 32);
model.result.numerical('gevLSFx3').setIndex('expr', 'gop.sum((1e6*(qx-gop.relg3.qavex)>3.5336884006882316)&&(1e6*(qx-gop.relg3.qavex)<=3.87023015313473)&&gop.prf==3)', 33);
model.result.numerical('gevLSFx3').setIndex('expr', 'gop.sum((1e6*(qx-gop.relg3.qavex)>3.87023015313473)&&(1e6*(qx-gop.relg3.qavex)<=4.2067719055812285)&&gop.prf==3)', 34);
model.result.numerical('gevLSFx3').setIndex('expr', 'gop.sum((1e6*(qx-gop.relg3.qavex)>4.2067719055812285)&&(1e6*(qx-gop.relg3.qavex)<=4.543313658027727)&&gop.prf==3)', 35);
model.result.numerical('gevLSFx3').setIndex('expr', 'gop.sum((1e6*(qx-gop.relg3.qavex)>4.543313658027727)&&(1e6*(qx-gop.relg3.qavex)<=4.879855410474225)&&gop.prf==3)', 36);
model.result.numerical('gevLSFx3').setIndex('expr', 'gop.sum((1e6*(qx-gop.relg3.qavex)>4.8798554104742236)&&(1e6*(qx-gop.relg3.qavex)<=5.216397162920722)&&gop.prf==3)', 37);
model.result.numerical('gevLSFx3').setIndex('expr', 'gop.sum((1e6*(qx-gop.relg3.qavex)>5.216397162920722)&&(1e6*(qx-gop.relg3.qavex)<=5.55293891536722)&&gop.prf==3)', 38);
model.result.numerical('gevLSFx3').setIndex('expr', 'gop.sum((1e6*(qx-gop.relg3.qavex)>5.55293891536722)&&(1e6*(qx-gop.relg3.qavex)<=5.889480667813719)&&gop.prf==3)', 39);
model.result.numerical('gevLSFx3').setIndex('expr', 'gop.sum((1e6*(qx-gop.relg3.qavex)>5.889480667813719)&&(1e6*(qx-gop.relg3.qavex)<=6.226022420260217)&&gop.prf==3)', 40);
model.result.numerical('gevLSFx3').setIndex('expr', 'gop.sum((1e6*(qx-gop.relg3.qavex)>6.226022420260217)&&(1e6*(qx-gop.relg3.qavex)<=6.562564172706716)&&gop.prf==3)', 41);
model.result.numerical('gevLSFx3').setIndex('expr', 'gop.sum((1e6*(qx-gop.relg3.qavex)>6.562564172706716)&&(1e6*(qx-gop.relg3.qavex)<=6.899105925153214)&&gop.prf==3)', 42);
model.result.numerical('gevLSFx3').setIndex('expr', 'gop.sum((1e6*(qx-gop.relg3.qavex)>6.899105925153214)&&(1e6*(qx-gop.relg3.qavex)<=7.2356476775997125)&&gop.prf==3)', 43);
model.result.numerical('gevLSFx3').setIndex('expr', 'gop.sum((1e6*(qx-gop.relg3.qavex)>7.235647677599711)&&(1e6*(qx-gop.relg3.qavex)<=7.572189430046209)&&gop.prf==3)', 44);

model.func.create('LSFx3', 'Interpolation');
model.func('LSFx3').label('LSFx3');

model.nodeGroup('mtfgrp3').add('func', 'LSFx3');

model.func('LSFx3').set('funcname', 'LSFx3');
model.func('LSFx3').set('interp', 'piecewisecubic');
model.func('LSFx3').set('extrap', 'const');
model.func('LSFx3').set('defineprimfun', true);
model.func('LSFx3').set('table', {});
model.func('LSFx3').setIndex('table', -7.40391855382296, 0, 0);
model.func('LSFx3').setIndex('table', 0, 0, 1);
model.func('LSFx3').setIndex('table', -7.0673768013764615, 1, 0);
model.func('LSFx3').setIndex('table', 0, 1, 1);
model.func('LSFx3').setIndex('table', -6.730835048929963, 2, 0);
model.func('LSFx3').setIndex('table', 0, 2, 1);
model.func('LSFx3').setIndex('table', -6.394293296483466, 3, 0);
model.func('LSFx3').setIndex('table', 0, 3, 1);
model.func('LSFx3').setIndex('table', -6.057751544036967, 4, 0);
model.func('LSFx3').setIndex('table', 0.003424657534246575, 4, 1);
model.func('LSFx3').setIndex('table', -5.721209791590469, 5, 0);
model.func('LSFx3').setIndex('table', 0.00684931506849315, 5, 1);
model.func('LSFx3').setIndex('table', -5.384668039143971, 6, 0);
model.func('LSFx3').setIndex('table', 0, 6, 1);
model.func('LSFx3').setIndex('table', -5.048126286697473, 7, 0);
model.func('LSFx3').setIndex('table', 0, 7, 1);
model.func('LSFx3').setIndex('table', -4.711584534250974, 8, 0);
model.func('LSFx3').setIndex('table', 0.010273972602739725, 8, 1);
model.func('LSFx3').setIndex('table', -4.375042781804476, 9, 0);
model.func('LSFx3').setIndex('table', 0.0136986301369863, 9, 1);
model.func('LSFx3').setIndex('table', -4.0385010293579775, 10, 0);
model.func('LSFx3').setIndex('table', 0.0273972602739726, 10, 1);
model.func('LSFx3').setIndex('table', -3.70195927691148, 11, 0);
model.func('LSFx3').setIndex('table', 0.03767123287671233, 11, 1);
model.func('LSFx3').setIndex('table', -3.3654175244649815, 12, 0);
model.func('LSFx3').setIndex('table', 0.04452054794520548, 12, 1);
model.func('LSFx3').setIndex('table', -3.028875772018483, 13, 0);
model.func('LSFx3').setIndex('table', 0.04794520547945205, 13, 1);
model.func('LSFx3').setIndex('table', -2.6923340195719856, 14, 0);
model.func('LSFx3').setIndex('table', 0.10616438356164383, 14, 1);
model.func('LSFx3').setIndex('table', -2.355792267125487, 15, 0);
model.func('LSFx3').setIndex('table', 0.08561643835616438, 15, 1);
model.func('LSFx3').setIndex('table', -2.0192505146789888, 16, 0);
model.func('LSFx3').setIndex('table', 0.10616438356164383, 16, 1);
model.func('LSFx3').setIndex('table', -1.6827087622324903, 17, 0);
model.func('LSFx3').setIndex('table', 0.13013698630136986, 17, 1);
model.func('LSFx3').setIndex('table', -1.346167009785992, 18, 0);
model.func('LSFx3').setIndex('table', 0.2842465753424658, 18, 1);
model.func('LSFx3').setIndex('table', -1.0096252573394944, 19, 0);
model.func('LSFx3').setIndex('table', 0.3253424657534247, 19, 1);
model.func('LSFx3').setIndex('table', -0.673083504892996, 20, 0);
model.func('LSFx3').setIndex('table', 0.410958904109589, 20, 1);
model.func('LSFx3').setIndex('table', -0.33654175244649753, 21, 0);
model.func('LSFx3').setIndex('table', 0.547945205479452, 21, 1);
model.func('LSFx3').setIndex('table', 0, 22, 0);
model.func('LSFx3').setIndex('table', 1, 22, 1);
model.func('LSFx3').setIndex('table', 0.3365417524464984, 23, 0);
model.func('LSFx3').setIndex('table', 0.547945205479452, 23, 1);
model.func('LSFx3').setIndex('table', 0.6730835048929968, 24, 0);
model.func('LSFx3').setIndex('table', 0.410958904109589, 24, 1);
model.func('LSFx3').setIndex('table', 1.0096252573394953, 25, 0);
model.func('LSFx3').setIndex('table', 0.3287671232876712, 25, 1);
model.func('LSFx3').setIndex('table', 1.3461670097859937, 26, 0);
model.func('LSFx3').setIndex('table', 0.2808219178082192, 26, 1);
model.func('LSFx3').setIndex('table', 1.682708762232492, 27, 0);
model.func('LSFx3').setIndex('table', 0.13013698630136986, 27, 1);
model.func('LSFx3').setIndex('table', 2.0192505146789888, 28, 0);
model.func('LSFx3').setIndex('table', 0.10616438356164383, 28, 1);
model.func('LSFx3').setIndex('table', 2.355792267125487, 29, 0);
model.func('LSFx3').setIndex('table', 0.08561643835616438, 29, 1);
model.func('LSFx3').setIndex('table', 2.6923340195719856, 30, 0);
model.func('LSFx3').setIndex('table', 0.10616438356164383, 30, 1);
model.func('LSFx3').setIndex('table', 3.028875772018484, 31, 0);
model.func('LSFx3').setIndex('table', 0.04794520547945205, 31, 1);
model.func('LSFx3').setIndex('table', 3.3654175244649824, 32, 0);
model.func('LSFx3').setIndex('table', 0.04452054794520548, 32, 1);
model.func('LSFx3').setIndex('table', 3.701959276911481, 33, 0);
model.func('LSFx3').setIndex('table', 0.03767123287671233, 33, 1);
model.func('LSFx3').setIndex('table', 4.038501029357979, 34, 0);
model.func('LSFx3').setIndex('table', 0.0273972602739726, 34, 1);
model.func('LSFx3').setIndex('table', 4.375042781804478, 35, 0);
model.func('LSFx3').setIndex('table', 0.0136986301369863, 35, 1);
model.func('LSFx3').setIndex('table', 4.711584534250976, 36, 0);
model.func('LSFx3').setIndex('table', 0.010273972602739725, 36, 1);
model.func('LSFx3').setIndex('table', 5.048126286697473, 37, 0);
model.func('LSFx3').setIndex('table', 0, 37, 1);
model.func('LSFx3').setIndex('table', 5.384668039143971, 38, 0);
model.func('LSFx3').setIndex('table', 0, 38, 1);
model.func('LSFx3').setIndex('table', 5.72120979159047, 39, 0);
model.func('LSFx3').setIndex('table', 0.00684931506849315, 39, 1);
model.func('LSFx3').setIndex('table', 6.057751544036968, 40, 0);
model.func('LSFx3').setIndex('table', 0.003424657534246575, 40, 1);
model.func('LSFx3').setIndex('table', 6.3942932964834664, 41, 0);
model.func('LSFx3').setIndex('table', 0, 41, 1);
model.func('LSFx3').setIndex('table', 6.730835048929965, 42, 0);
model.func('LSFx3').setIndex('table', 0, 42, 1);
model.func('LSFx3').setIndex('table', 7.067376801376463, 43, 0);
model.func('LSFx3').setIndex('table', 0, 43, 1);
model.func('LSFx3').setIndex('table', 7.40391855382296, 44, 0);
model.func('LSFx3').setIndex('table', 0, 44, 1);

model.result.dataset.create('lsfx3', 'Grid1D');
model.result.dataset('lsfx3').label('LSFx3');

model.nodeGroup('datagrp').add('dataset', 'lsfx3');

model.result.dataset('lsfx3').set('source', 'function');
model.result.dataset('lsfx3').set('function', 'LSFx3');
model.result.dataset('lsfx3').set('parmin1', '-7.40391855382296');
model.result.dataset('lsfx3').set('parmax1', '7.40391855382296');
model.result.dataset('lsfx3').set('par1', 'x_out');

model.func.create('Lcosy3', 'Analytic');
model.func('Lcosy3').label('Lcosy3');

model.nodeGroup('mtfgrp3').add('func', 'Lcosy3');

model.func('Lcosy3').set('funcname', 'Lcosy3');
model.func('Lcosy3').set('expr', 'LSFy3(y)*cos(2*pi*nu*y/1e3)');
model.func('Lcosy3').set('args', 'y, nu');
model.func('Lcosy3').setIndex('plotargs', -7.40391855382296, 0, 1);
model.func('Lcosy3').setIndex('plotargs', 7.40391855382296, 0, 2);
model.func('Lcosy3').setIndex('plotargs', 0, 1, 1);
model.func('Lcosy3').setIndex('plotargs', '125', 1, 2);
model.func.create('Lsiny3', 'Analytic');
model.func('Lsiny3').label('Lsiny3');

model.nodeGroup('mtfgrp3').add('func', 'Lsiny3');

model.func('Lsiny3').set('funcname', 'Lsiny3');
model.func('Lsiny3').set('expr', 'LSFy3(y)*sin(2*pi*nu*y/1e3)');
model.func('Lsiny3').set('args', 'y, nu');
model.func('Lsiny3').setIndex('plotargs', -7.40391855382296, 0, 1);
model.func('Lsiny3').setIndex('plotargs', 7.40391855382296, 0, 2);
model.func('Lsiny3').setIndex('plotargs', 0, 1, 1);
model.func('Lsiny3').setIndex('plotargs', '125', 1, 2);

model.result.numerical.create('gevLSFy3', 'EvalGlobal');
model.result.numerical('gevLSFy3').label('gevLSFy3');

model.nodeGroup('numgrp').add('numerical', 'gevLSFy3');

model.result.numerical('gevLSFy3').set('data', 'ray1');
model.result.numerical('gevLSFy3').set('innerinput', 'last');
model.result.numerical('gevLSFy3').set('expr', {});
model.result.numerical('gevLSFy3').set('descr', {});
model.result.numerical('gevLSFy3').setIndex('expr', 'gop.sum((1e6*(qy-gop.relg3.qavey)>-7.572189430046209)&&(1e6*(qy-gop.relg3.qavey)<=-7.235647677599711)&&gop.prf==3)', 0);
model.result.numerical('gevLSFy3').setIndex('expr', 'gop.sum((1e6*(qy-gop.relg3.qavey)>-7.235647677599711)&&(1e6*(qy-gop.relg3.qavey)<=-6.899105925153212)&&gop.prf==3)', 1);
model.result.numerical('gevLSFy3').setIndex('expr', 'gop.sum((1e6*(qy-gop.relg3.qavey)>-6.899105925153212)&&(1e6*(qy-gop.relg3.qavey)<=-6.562564172706714)&&gop.prf==3)', 2);
model.result.numerical('gevLSFy3').setIndex('expr', 'gop.sum((1e6*(qy-gop.relg3.qavey)>-6.562564172706715)&&(1e6*(qy-gop.relg3.qavey)<=-6.226022420260216)&&gop.prf==3)', 3);
model.result.numerical('gevLSFy3').setIndex('expr', 'gop.sum((1e6*(qy-gop.relg3.qavey)>-6.226022420260216)&&(1e6*(qy-gop.relg3.qavey)<=-5.889480667813718)&&gop.prf==3)', 4);
model.result.numerical('gevLSFy3').setIndex('expr', 'gop.sum((1e6*(qy-gop.relg3.qavey)>-5.889480667813718)&&(1e6*(qy-gop.relg3.qavey)<=-5.5529389153672195)&&gop.prf==3)', 5);
model.result.numerical('gevLSFy3').setIndex('expr', 'gop.sum((1e6*(qy-gop.relg3.qavey)>-5.55293891536722)&&(1e6*(qy-gop.relg3.qavey)<=-5.216397162920722)&&gop.prf==3)', 6);
model.result.numerical('gevLSFy3').setIndex('expr', 'gop.sum((1e6*(qy-gop.relg3.qavey)>-5.216397162920722)&&(1e6*(qy-gop.relg3.qavey)<=-4.8798554104742236)&&gop.prf==3)', 7);
model.result.numerical('gevLSFy3').setIndex('expr', 'gop.sum((1e6*(qy-gop.relg3.qavey)>-4.8798554104742236)&&(1e6*(qy-gop.relg3.qavey)<=-4.543313658027725)&&gop.prf==3)', 8);
model.result.numerical('gevLSFy3').setIndex('expr', 'gop.sum((1e6*(qy-gop.relg3.qavey)>-4.543313658027725)&&(1e6*(qy-gop.relg3.qavey)<=-4.206771905581227)&&gop.prf==3)', 9);
model.result.numerical('gevLSFy3').setIndex('expr', 'gop.sum((1e6*(qy-gop.relg3.qavey)>-4.206771905581227)&&(1e6*(qy-gop.relg3.qavey)<=-3.8702301531347283)&&gop.prf==3)', 10);
model.result.numerical('gevLSFy3').setIndex('expr', 'gop.sum((1e6*(qy-gop.relg3.qavey)>-3.870230153134729)&&(1e6*(qy-gop.relg3.qavey)<=-3.5336884006882308)&&gop.prf==3)', 11);
model.result.numerical('gevLSFy3').setIndex('expr', 'gop.sum((1e6*(qy-gop.relg3.qavey)>-3.5336884006882308)&&(1e6*(qy-gop.relg3.qavey)<=-3.1971466482417323)&&gop.prf==3)', 12);
model.result.numerical('gevLSFy3').setIndex('expr', 'gop.sum((1e6*(qy-gop.relg3.qavey)>-3.1971466482417323)&&(1e6*(qy-gop.relg3.qavey)<=-2.860604895795234)&&gop.prf==3)', 13);
model.result.numerical('gevLSFy3').setIndex('expr', 'gop.sum((1e6*(qy-gop.relg3.qavey)>-2.860604895795235)&&(1e6*(qy-gop.relg3.qavey)<=-2.5240631433487364)&&gop.prf==3)', 14);
model.result.numerical('gevLSFy3').setIndex('expr', 'gop.sum((1e6*(qy-gop.relg3.qavey)>-2.5240631433487364)&&(1e6*(qy-gop.relg3.qavey)<=-2.187521390902238)&&gop.prf==3)', 15);
model.result.numerical('gevLSFy3').setIndex('expr', 'gop.sum((1e6*(qy-gop.relg3.qavey)>-2.187521390902238)&&(1e6*(qy-gop.relg3.qavey)<=-1.8509796384557395)&&gop.prf==3)', 16);
model.result.numerical('gevLSFy3').setIndex('expr', 'gop.sum((1e6*(qy-gop.relg3.qavey)>-1.8509796384557395)&&(1e6*(qy-gop.relg3.qavey)<=-1.5144378860092411)&&gop.prf==3)', 17);
model.result.numerical('gevLSFy3').setIndex('expr', 'gop.sum((1e6*(qy-gop.relg3.qavey)>-1.5144378860092411)&&(1e6*(qy-gop.relg3.qavey)<=-1.1778961335627427)&&gop.prf==3)', 18);
model.result.numerical('gevLSFy3').setIndex('expr', 'gop.sum((1e6*(qy-gop.relg3.qavey)>-1.1778961335627436)&&(1e6*(qy-gop.relg3.qavey)<=-0.8413543811162453)&&gop.prf==3)', 19);
model.result.numerical('gevLSFy3').setIndex('expr', 'gop.sum((1e6*(qy-gop.relg3.qavey)>-0.841354381116245)&&(1e6*(qy-gop.relg3.qavey)<=-0.5048126286697469)&&gop.prf==3)', 20);
model.result.numerical('gevLSFy3').setIndex('expr', 'gop.sum((1e6*(qy-gop.relg3.qavey)>-0.5048126286697466)&&(1e6*(qy-gop.relg3.qavey)<=-0.16827087622324843)&&gop.prf==3)', 21);
model.result.numerical('gevLSFy3').setIndex('expr', 'gop.sum((1e6*(qy-gop.relg3.qavey)>-0.1682708762232491)&&(1e6*(qy-gop.relg3.qavey)<=0.1682708762232491)&&gop.prf==3)', 22);
model.result.numerical('gevLSFy3').setIndex('expr', 'gop.sum((1e6*(qy-gop.relg3.qavey)>0.16827087622324932)&&(1e6*(qy-gop.relg3.qavey)<=0.5048126286697475)&&gop.prf==3)', 23);
model.result.numerical('gevLSFy3').setIndex('expr', 'gop.sum((1e6*(qy-gop.relg3.qavey)>0.5048126286697477)&&(1e6*(qy-gop.relg3.qavey)<=0.8413543811162459)&&gop.prf==3)', 24);
model.result.numerical('gevLSFy3').setIndex('expr', 'gop.sum((1e6*(qy-gop.relg3.qavey)>0.8413543811162462)&&(1e6*(qy-gop.relg3.qavey)<=1.1778961335627445)&&gop.prf==3)', 25);
model.result.numerical('gevLSFy3').setIndex('expr', 'gop.sum((1e6*(qy-gop.relg3.qavey)>1.1778961335627445)&&(1e6*(qy-gop.relg3.qavey)<=1.514437886009243)&&gop.prf==3)', 26);
model.result.numerical('gevLSFy3').setIndex('expr', 'gop.sum((1e6*(qy-gop.relg3.qavey)>1.514437886009243)&&(1e6*(qy-gop.relg3.qavey)<=1.8509796384557413)&&gop.prf==3)', 27);
model.result.numerical('gevLSFy3').setIndex('expr', 'gop.sum((1e6*(qy-gop.relg3.qavey)>1.8509796384557395)&&(1e6*(qy-gop.relg3.qavey)<=2.187521390902238)&&gop.prf==3)', 28);
model.result.numerical('gevLSFy3').setIndex('expr', 'gop.sum((1e6*(qy-gop.relg3.qavey)>2.187521390902238)&&(1e6*(qy-gop.relg3.qavey)<=2.5240631433487364)&&gop.prf==3)', 29);
model.result.numerical('gevLSFy3').setIndex('expr', 'gop.sum((1e6*(qy-gop.relg3.qavey)>2.5240631433487364)&&(1e6*(qy-gop.relg3.qavey)<=2.860604895795235)&&gop.prf==3)', 30);
model.result.numerical('gevLSFy3').setIndex('expr', 'gop.sum((1e6*(qy-gop.relg3.qavey)>2.860604895795235)&&(1e6*(qy-gop.relg3.qavey)<=3.1971466482417332)&&gop.prf==3)', 31);
model.result.numerical('gevLSFy3').setIndex('expr', 'gop.sum((1e6*(qy-gop.relg3.qavey)>3.1971466482417332)&&(1e6*(qy-gop.relg3.qavey)<=3.5336884006882316)&&gop.prf==3)', 32);
model.result.numerical('gevLSFy3').setIndex('expr', 'gop.sum((1e6*(qy-gop.relg3.qavey)>3.5336884006882316)&&(1e6*(qy-gop.relg3.qavey)<=3.87023015313473)&&gop.prf==3)', 33);
model.result.numerical('gevLSFy3').setIndex('expr', 'gop.sum((1e6*(qy-gop.relg3.qavey)>3.87023015313473)&&(1e6*(qy-gop.relg3.qavey)<=4.2067719055812285)&&gop.prf==3)', 34);
model.result.numerical('gevLSFy3').setIndex('expr', 'gop.sum((1e6*(qy-gop.relg3.qavey)>4.2067719055812285)&&(1e6*(qy-gop.relg3.qavey)<=4.543313658027727)&&gop.prf==3)', 35);
model.result.numerical('gevLSFy3').setIndex('expr', 'gop.sum((1e6*(qy-gop.relg3.qavey)>4.543313658027727)&&(1e6*(qy-gop.relg3.qavey)<=4.879855410474225)&&gop.prf==3)', 36);
model.result.numerical('gevLSFy3').setIndex('expr', 'gop.sum((1e6*(qy-gop.relg3.qavey)>4.8798554104742236)&&(1e6*(qy-gop.relg3.qavey)<=5.216397162920722)&&gop.prf==3)', 37);
model.result.numerical('gevLSFy3').setIndex('expr', 'gop.sum((1e6*(qy-gop.relg3.qavey)>5.216397162920722)&&(1e6*(qy-gop.relg3.qavey)<=5.55293891536722)&&gop.prf==3)', 38);
model.result.numerical('gevLSFy3').setIndex('expr', 'gop.sum((1e6*(qy-gop.relg3.qavey)>5.55293891536722)&&(1e6*(qy-gop.relg3.qavey)<=5.889480667813719)&&gop.prf==3)', 39);
model.result.numerical('gevLSFy3').setIndex('expr', 'gop.sum((1e6*(qy-gop.relg3.qavey)>5.889480667813719)&&(1e6*(qy-gop.relg3.qavey)<=6.226022420260217)&&gop.prf==3)', 40);
model.result.numerical('gevLSFy3').setIndex('expr', 'gop.sum((1e6*(qy-gop.relg3.qavey)>6.226022420260217)&&(1e6*(qy-gop.relg3.qavey)<=6.562564172706716)&&gop.prf==3)', 41);
model.result.numerical('gevLSFy3').setIndex('expr', 'gop.sum((1e6*(qy-gop.relg3.qavey)>6.562564172706716)&&(1e6*(qy-gop.relg3.qavey)<=6.899105925153214)&&gop.prf==3)', 42);
model.result.numerical('gevLSFy3').setIndex('expr', 'gop.sum((1e6*(qy-gop.relg3.qavey)>6.899105925153214)&&(1e6*(qy-gop.relg3.qavey)<=7.2356476775997125)&&gop.prf==3)', 43);
model.result.numerical('gevLSFy3').setIndex('expr', 'gop.sum((1e6*(qy-gop.relg3.qavey)>7.235647677599711)&&(1e6*(qy-gop.relg3.qavey)<=7.572189430046209)&&gop.prf==3)', 44);

model.func.create('LSFy3', 'Interpolation');
model.func('LSFy3').label('LSFy3');

model.nodeGroup('mtfgrp3').add('func', 'LSFy3');

model.func('LSFy3').set('funcname', 'LSFy3');
model.func('LSFy3').set('interp', 'piecewisecubic');
model.func('LSFy3').set('extrap', 'const');
model.func('LSFy3').set('defineprimfun', true);
model.func('LSFy3').set('table', {});
model.func('LSFy3').setIndex('table', -7.40391855382296, 0, 0);
model.func('LSFy3').setIndex('table', 0, 0, 1);
model.func('LSFy3').setIndex('table', -7.0673768013764615, 1, 0);
model.func('LSFy3').setIndex('table', 0, 1, 1);
model.func('LSFy3').setIndex('table', -6.730835048929963, 2, 0);
model.func('LSFy3').setIndex('table', 0, 2, 1);
model.func('LSFy3').setIndex('table', -6.394293296483466, 3, 0);
model.func('LSFy3').setIndex('table', 0, 3, 1);
model.func('LSFy3').setIndex('table', -6.057751544036967, 4, 0);
model.func('LSFy3').setIndex('table', 0, 4, 1);
model.func('LSFy3').setIndex('table', -5.721209791590469, 5, 0);
model.func('LSFy3').setIndex('table', 0.07777777777777778, 5, 1);
model.func('LSFy3').setIndex('table', -5.384668039143971, 6, 0);
model.func('LSFy3').setIndex('table', 0.43333333333333335, 6, 1);
model.func('LSFy3').setIndex('table', -5.048126286697473, 7, 0);
model.func('LSFy3').setIndex('table', 0.4111111111111111, 7, 1);
model.func('LSFy3').setIndex('table', -4.711584534250974, 8, 0);
model.func('LSFy3').setIndex('table', 0.4111111111111111, 8, 1);
model.func('LSFy3').setIndex('table', -4.375042781804476, 9, 0);
model.func('LSFy3').setIndex('table', 0.4, 9, 1);
model.func('LSFy3').setIndex('table', -4.0385010293579775, 10, 0);
model.func('LSFy3').setIndex('table', 0.4111111111111111, 10, 1);
model.func('LSFy3').setIndex('table', -3.70195927691148, 11, 0);
model.func('LSFy3').setIndex('table', 0.4222222222222222, 11, 1);
model.func('LSFy3').setIndex('table', -3.3654175244649815, 12, 0);
model.func('LSFy3').setIndex('table', 0.4777777777777778, 12, 1);
model.func('LSFy3').setIndex('table', -3.028875772018483, 13, 0);
model.func('LSFy3').setIndex('table', 0.4444444444444444, 13, 1);
model.func('LSFy3').setIndex('table', -2.6923340195719856, 14, 0);
model.func('LSFy3').setIndex('table', 0.6333333333333333, 14, 1);
model.func('LSFy3').setIndex('table', -2.355792267125487, 15, 0);
model.func('LSFy3').setIndex('table', 0.5333333333333333, 15, 1);
model.func('LSFy3').setIndex('table', -2.0192505146789888, 16, 0);
model.func('LSFy3').setIndex('table', 0.6, 16, 1);
model.func('LSFy3').setIndex('table', -1.6827087622324903, 17, 0);
model.func('LSFy3').setIndex('table', 0.6666666666666666, 17, 1);
model.func('LSFy3').setIndex('table', -1.346167009785992, 18, 0);
model.func('LSFy3').setIndex('table', 0.8888888888888888, 18, 1);
model.func('LSFy3').setIndex('table', -1.0096252573394944, 19, 0);
model.func('LSFy3').setIndex('table', 1, 19, 1);
model.func('LSFy3').setIndex('table', -0.673083504892996, 20, 0);
model.func('LSFy3').setIndex('table', 0.6666666666666666, 20, 1);
model.func('LSFy3').setIndex('table', -0.33654175244649753, 21, 0);
model.func('LSFy3').setIndex('table', 0.8555555555555555, 21, 1);
model.func('LSFy3').setIndex('table', 0, 22, 0);
model.func('LSFy3').setIndex('table', 0.5, 22, 1);
model.func('LSFy3').setIndex('table', 0.3365417524464984, 23, 0);
model.func('LSFy3').setIndex('table', 0.6222222222222222, 23, 1);
model.func('LSFy3').setIndex('table', 0.6730835048929968, 24, 0);
model.func('LSFy3').setIndex('table', 0.4666666666666667, 24, 1);
model.func('LSFy3').setIndex('table', 1.0096252573394953, 25, 0);
model.func('LSFy3').setIndex('table', 0.6, 25, 1);
model.func('LSFy3').setIndex('table', 1.3461670097859937, 26, 0);
model.func('LSFy3').setIndex('table', 0.43333333333333335, 26, 1);
model.func('LSFy3').setIndex('table', 1.682708762232492, 27, 0);
model.func('LSFy3').setIndex('table', 0.6333333333333333, 27, 1);
model.func('LSFy3').setIndex('table', 2.0192505146789888, 28, 0);
model.func('LSFy3').setIndex('table', 0.4, 28, 1);
model.func('LSFy3').setIndex('table', 2.355792267125487, 29, 0);
model.func('LSFy3').setIndex('table', 0.43333333333333335, 29, 1);
model.func('LSFy3').setIndex('table', 2.6923340195719856, 30, 0);
model.func('LSFy3').setIndex('table', 0.4444444444444444, 30, 1);
model.func('LSFy3').setIndex('table', 3.028875772018484, 31, 0);
model.func('LSFy3').setIndex('table', 0.43333333333333335, 31, 1);
model.func('LSFy3').setIndex('table', 3.3654175244649824, 32, 0);
model.func('LSFy3').setIndex('table', 0.32222222222222224, 32, 1);
model.func('LSFy3').setIndex('table', 3.701959276911481, 33, 0);
model.func('LSFy3').setIndex('table', 0.3888888888888889, 33, 1);
model.func('LSFy3').setIndex('table', 4.038501029357979, 34, 0);
model.func('LSFy3').setIndex('table', 0.26666666666666666, 34, 1);
model.func('LSFy3').setIndex('table', 4.375042781804478, 35, 0);
model.func('LSFy3').setIndex('table', 0.25555555555555554, 35, 1);
model.func('LSFy3').setIndex('table', 4.711584534250976, 36, 0);
model.func('LSFy3').setIndex('table', 0.24444444444444444, 36, 1);
model.func('LSFy3').setIndex('table', 5.048126286697473, 37, 0);
model.func('LSFy3').setIndex('table', 0.26666666666666666, 37, 1);
model.func('LSFy3').setIndex('table', 5.384668039143971, 38, 0);
model.func('LSFy3').setIndex('table', 0.26666666666666666, 38, 1);
model.func('LSFy3').setIndex('table', 5.72120979159047, 39, 0);
model.func('LSFy3').setIndex('table', 0.2111111111111111, 39, 1);
model.func('LSFy3').setIndex('table', 6.057751544036968, 40, 0);
model.func('LSFy3').setIndex('table', 0.34444444444444444, 40, 1);
model.func('LSFy3').setIndex('table', 6.3942932964834664, 41, 0);
model.func('LSFy3').setIndex('table', 0.17777777777777778, 41, 1);
model.func('LSFy3').setIndex('table', 6.730835048929965, 42, 0);
model.func('LSFy3').setIndex('table', 0.25555555555555554, 42, 1);
model.func('LSFy3').setIndex('table', 7.067376801376463, 43, 0);
model.func('LSFy3').setIndex('table', 0.14444444444444443, 43, 1);
model.func('LSFy3').setIndex('table', 7.40391855382296, 44, 0);
model.func('LSFy3').setIndex('table', 0, 44, 1);

model.result.dataset.create('lsfy3', 'Grid1D');
model.result.dataset('lsfy3').label('LSFy3');

model.nodeGroup('datagrp').add('dataset', 'lsfy3');

model.result.dataset('lsfy3').set('source', 'function');
model.result.dataset('lsfy3').set('function', 'LSFy3');
model.result.dataset('lsfy3').set('parmin1', '-7.40391855382296');
model.result.dataset('lsfy3').set('parmax1', '7.40391855382296');
model.result.dataset('lsfy3').set('par1', 'y_out');
model.result('pg4').create('lsfx2', 'LineGraph');
model.result('pg4').feature('lsfx2').label('LSFx2');
model.result('pg4').feature('lsfx2').set('xdata', 'expr');
model.result('pg4').feature('lsfx2').set('expr', 'LSFx2(x_out)/LSFx2_prim(1e6)');
model.result('pg4').feature('lsfx2').set('xdataexpr', 'x_out');
model.result('pg4').feature('lsfx2').set('xdatadescractive', true);
model.result('pg4').feature('lsfx2').set('xdatadescr', 'Distance relative to centroid (um)');
model.result('pg4').feature('lsfx2').set('data', 'lsfx2');
model.result('pg4').feature('lsfx2').set('legend', true);
model.result('pg4').feature('lsfx2').set('autodescr', true);
model.result('pg4').feature('lsfx2').set('autosolution', false);
model.result('pg4').feature('lsfx2').set('descractive', true);
model.result('pg4').feature('lsfx2').set('descr', 'Release from Grid 2: x');
model.result('pg4').feature('lsfx2').set('smooth', 'none');
model.result('pg4').feature('lsfx2').set('resolution', 'norefine');
model.result('pg4').create('lsfy2', 'LineGraph');
model.result('pg4').feature('lsfy2').label('LSFy2');
model.result('pg4').feature('lsfy2').set('xdata', 'expr');
model.result('pg4').feature('lsfy2').set('expr', 'LSFy2(y_out)/LSFy2_prim(1e6)');
model.result('pg4').feature('lsfy2').set('xdataexpr', 'y_out');
model.result('pg4').feature('lsfy2').set('xdatadescractive', true);
model.result('pg4').feature('lsfy2').set('xdatadescr', 'Distance relative to centroid (um)');
model.result('pg4').feature('lsfy2').set('data', 'lsfy2');
model.result('pg4').feature('lsfy2').set('legend', true);
model.result('pg4').feature('lsfy2').set('autodescr', true);
model.result('pg4').feature('lsfy2').set('autosolution', false);
model.result('pg4').feature('lsfy2').set('descractive', true);
model.result('pg4').feature('lsfy2').set('descr', 'Release from Grid 2: y');
model.result('pg4').feature('lsfy2').set('smooth', 'none');
model.result('pg4').feature('lsfy2').set('resolution', 'norefine');
model.result('pg4').create('lsfx3', 'LineGraph');
model.result('pg4').feature('lsfx3').label('LSFx3');
model.result('pg4').feature('lsfx3').set('xdata', 'expr');
model.result('pg4').feature('lsfx3').set('expr', 'LSFx3(x_out)/LSFx3_prim(1e6)');
model.result('pg4').feature('lsfx3').set('xdataexpr', 'x_out');
model.result('pg4').feature('lsfx3').set('xdatadescractive', true);
model.result('pg4').feature('lsfx3').set('xdatadescr', 'Distance relative to centroid (um)');
model.result('pg4').feature('lsfx3').set('data', 'lsfx3');
model.result('pg4').feature('lsfx3').set('legend', true);
model.result('pg4').feature('lsfx3').set('autodescr', true);
model.result('pg4').feature('lsfx3').set('autosolution', false);
model.result('pg4').feature('lsfx3').set('descractive', true);
model.result('pg4').feature('lsfx3').set('descr', 'Release from Grid 3: x');
model.result('pg4').feature('lsfx3').set('smooth', 'none');
model.result('pg4').feature('lsfx3').set('resolution', 'norefine');
model.result('pg4').create('lsfy3', 'LineGraph');
model.result('pg4').feature('lsfy3').label('LSFy3');
model.result('pg4').feature('lsfy3').set('xdata', 'expr');
model.result('pg4').feature('lsfy3').set('expr', 'LSFy3(y_out)/LSFy3_prim(1e6)');
model.result('pg4').feature('lsfy3').set('xdataexpr', 'y_out');
model.result('pg4').feature('lsfy3').set('xdatadescractive', true);
model.result('pg4').feature('lsfy3').set('xdatadescr', 'Distance relative to centroid (um)');
model.result('pg4').feature('lsfy3').set('data', 'lsfy3');
model.result('pg4').feature('lsfy3').set('legend', true);
model.result('pg4').feature('lsfy3').set('autodescr', true);
model.result('pg4').feature('lsfy3').set('autosolution', false);
model.result('pg4').feature('lsfy3').set('descractive', true);
model.result('pg4').feature('lsfy3').set('descr', 'Release from Grid 3: y');
model.result('pg4').feature('lsfy3').set('smooth', 'none');
model.result('pg4').feature('lsfy3').set('resolution', 'norefine');
model.result.numerical('gevMTF').set('expr', {});
model.result.numerical('gevMTF').set('descr', {});
model.result.numerical('gevMTF').setIndex('expr', 'integrate(Lcosx1(x,nu_local),x,-6.660946574690962, 6.660946574690962)/integrate(LSFx1(x),x,-6.660946574690962, 6.660946574690962)', 0);
model.result.numerical('gevMTF').setIndex('descr', 'Lx1', 0);
model.result.numerical('gevMTF').setIndex('expr', 'integrate(Lsinx1(x,nu_local),x,-6.660946574690962, 6.660946574690962)/integrate(LSFx1(x),x,-6.660946574690962, 6.660946574690962)', 1);
model.result.numerical('gevMTF').setIndex('descr', 'Lx1', 1);
model.result.numerical('gevMTF').setIndex('expr', 'integrate(Lcosy1(y,nu_local),y,-6.660946574690962, 6.660946574690962)/integrate(LSFy1(y),y,-6.660946574690962, 6.660946574690962)', 2);
model.result.numerical('gevMTF').setIndex('descr', 'Ly1', 2);
model.result.numerical('gevMTF').setIndex('expr', 'integrate(Lsiny1(y,nu_local),y,-6.660946574690962, 6.660946574690962)/integrate(LSFy1(y),y,-6.660946574690962, 6.660946574690962)', 3);
model.result.numerical('gevMTF').setIndex('descr', 'Ly1', 3);
model.result.numerical('gevMTF').setIndex('expr', 'integrate(Lcosx2(x,nu_local),x,-9.347872925314553, 9.347872925314553)/integrate(LSFx2(x),x,-9.347872925314553, 9.347872925314553)', 4);
model.result.numerical('gevMTF').setIndex('descr', 'Lx2', 4);
model.result.numerical('gevMTF').setIndex('expr', 'integrate(Lsinx2(x,nu_local),x,-9.347872925314553, 9.347872925314553)/integrate(LSFx2(x),x,-9.347872925314553, 9.347872925314553)', 5);
model.result.numerical('gevMTF').setIndex('descr', 'Lx2', 5);
model.result.numerical('gevMTF').setIndex('expr', 'integrate(Lcosy2(y,nu_local),y,-9.347872925314553, 9.347872925314553)/integrate(LSFy2(y),y,-9.347872925314553, 9.347872925314553)', 6);
model.result.numerical('gevMTF').setIndex('descr', 'Ly2', 6);
model.result.numerical('gevMTF').setIndex('expr', 'integrate(Lsiny2(y,nu_local),y,-9.347872925314553, 9.347872925314553)/integrate(LSFy2(y),y,-9.347872925314553, 9.347872925314553)', 7);
model.result.numerical('gevMTF').setIndex('descr', 'Ly2', 7);
model.result.numerical('gevMTF').setIndex('expr', 'integrate(Lcosx3(x,nu_local),x,-7.40391855382296, 7.40391855382296)/integrate(LSFx3(x),x,-7.40391855382296, 7.40391855382296)', 8);
model.result.numerical('gevMTF').setIndex('descr', 'Lx3', 8);
model.result.numerical('gevMTF').setIndex('expr', 'integrate(Lsinx3(x,nu_local),x,-7.40391855382296, 7.40391855382296)/integrate(LSFx3(x),x,-7.40391855382296, 7.40391855382296)', 9);
model.result.numerical('gevMTF').setIndex('descr', 'Lx3', 9);
model.result.numerical('gevMTF').setIndex('expr', 'integrate(Lcosy3(y,nu_local),y,-7.40391855382296, 7.40391855382296)/integrate(LSFy3(y),y,-7.40391855382296, 7.40391855382296)', 10);
model.result.numerical('gevMTF').setIndex('descr', 'Ly3', 10);
model.result.numerical('gevMTF').setIndex('expr', 'integrate(Lsiny3(y,nu_local),y,-7.40391855382296, 7.40391855382296)/integrate(LSFy3(y),y,-7.40391855382296, 7.40391855382296)', 11);
model.result.numerical('gevMTF').setIndex('descr', 'Ly3', 11);

model.sol('sol1').updateSolution;

model.result.param.set('nu_local', '125.0');

model.func('MTFx1').set('funcname', 'MTFx1');
model.func('MTFx1').set('interp', 'cubicspline');
model.func('MTFx1').set('extrap', 'const');
model.func('MTFx1').set('table', {});
model.func('MTFx1').setIndex('table', 0, 0, 0);
model.func('MTFx1').setIndex('table', 1, 0, 1);
model.func('MTFx1').setIndex('table', 6.25, 1, 0);
model.func('MTFx1').setIndex('table', 0.994392083707481, 1, 1);
model.func('MTFx1').setIndex('table', 12.5, 2, 0);
model.func('MTFx1').setIndex('table', 0.9777535822494318, 2, 1);
model.func('MTFx1').setIndex('table', 18.75, 3, 0);
model.func('MTFx1').setIndex('table', 0.9506250046938168, 3, 1);
model.func('MTFx1').setIndex('table', 25, 4, 0);
model.func('MTFx1').setIndex('table', 0.9138974974373387, 4, 1);
model.func('MTFx1').setIndex('table', 31.25, 5, 0);
model.func('MTFx1').setIndex('table', 0.8687308010113493, 5, 1);
model.func('MTFx1').setIndex('table', 37.5, 6, 0);
model.func('MTFx1').setIndex('table', 0.8160976660093576, 6, 1);
model.func('MTFx1').setIndex('table', 43.75, 7, 0);
model.func('MTFx1').setIndex('table', 0.759128106906084, 7, 1);
model.func('MTFx1').setIndex('table', 50, 8, 0);
model.func('MTFx1').setIndex('table', 0.6980536832369101, 8, 1);
model.func('MTFx1').setIndex('table', 56.25, 9, 0);
model.func('MTFx1').setIndex('table', 0.6352051366927048, 9, 1);
model.func('MTFx1').setIndex('table', 62.5, 10, 0);
model.func('MTFx1').setIndex('table', 0.5724093330520087, 10, 1);
model.func('MTFx1').setIndex('table', 68.75, 11, 0);
model.func('MTFx1').setIndex('table', 0.5113413928761066, 11, 1);
model.func('MTFx1').setIndex('table', 75, 12, 0);
model.func('MTFx1').setIndex('table', 0.45366593720710646, 12, 1);
model.func('MTFx1').setIndex('table', 81.25, 13, 0);
model.func('MTFx1').setIndex('table', 0.40062982364146527, 13, 1);
model.func('MTFx1').setIndex('table', 87.5, 14, 0);
model.func('MTFx1').setIndex('table', 0.3534297171607277, 14, 1);
model.func('MTFx1').setIndex('table', 93.75, 15, 0);
model.func('MTFx1').setIndex('table', 0.31286356024587947, 15, 1);
model.func('MTFx1').setIndex('table', 100, 16, 0);
model.func('MTFx1').setIndex('table', 0.27946023630175626, 16, 1);
model.func('MTFx1').setIndex('table', 106.25, 17, 0);
model.func('MTFx1').setIndex('table', 0.25341199211648363, 17, 1);
model.func('MTFx1').setIndex('table', 112.5, 18, 0);
model.func('MTFx1').setIndex('table', 0.2346079054111798, 18, 1);
model.func('MTFx1').setIndex('table', 118.75, 19, 0);
model.func('MTFx1').setIndex('table', 0.2226278420283895, 19, 1);
model.func('MTFx1').setIndex('table', 125, 20, 0);
model.func('MTFx1').setIndex('table', 0.21681724803331812, 20, 1);

model.result.dataset('mtfx1').set('source', 'function');
model.result.dataset('mtfx1').set('function', 'MTFx1');
model.result.dataset('mtfx1').set('parmin1', '0');
model.result.dataset('mtfx1').set('parmax1', '125');
model.result.dataset('mtfx1').set('par1', 'nu_out');

model.func('MTFy1').set('funcname', 'MTFy1');
model.func('MTFy1').set('interp', 'cubicspline');
model.func('MTFy1').set('extrap', 'const');
model.func('MTFy1').set('table', {});
model.func('MTFy1').setIndex('table', 0, 0, 0);
model.func('MTFy1').setIndex('table', 1, 0, 1);
model.func('MTFy1').setIndex('table', 6.25, 1, 0);
model.func('MTFy1').setIndex('table', 0.9943980509744816, 1, 1);
model.func('MTFy1').setIndex('table', 12.5, 2, 0);
model.func('MTFy1').setIndex('table', 0.9777760236870637, 2, 1);
model.func('MTFy1').setIndex('table', 18.75, 3, 0);
model.func('MTFy1').setIndex('table', 0.9506777735576744, 3, 1);
model.func('MTFy1').setIndex('table', 25, 4, 0);
model.func('MTFy1').setIndex('table', 0.9139847246031091, 4, 1);
model.func('MTFy1').setIndex('table', 31.25, 5, 0);
model.func('MTFy1').setIndex('table', 0.8706080031041045, 5, 1);
model.func('MTFy1').setIndex('table', 37.5, 6, 0);
model.func('MTFy1').setIndex('table', 0.8185291328313142, 6, 1);
model.func('MTFy1').setIndex('table', 43.75, 7, 0);
model.func('MTFy1').setIndex('table', 0.7610762640937319, 7, 1);
model.func('MTFy1').setIndex('table', 50, 8, 0);
model.func('MTFy1').setIndex('table', 0.700058963951899, 8, 1);
model.func('MTFy1').setIndex('table', 56.25, 9, 0);
model.func('MTFy1').setIndex('table', 0.6373081724188084, 9, 1);
model.func('MTFy1').setIndex('table', 62.5, 10, 0);
model.func('MTFy1').setIndex('table', 0.5745599171353707, 10, 1);
model.func('MTFy1').setIndex('table', 68.75, 11, 0);
model.func('MTFy1').setIndex('table', 0.5135353680686051, 11, 1);
model.func('MTFy1').setIndex('table', 75, 12, 0);
model.func('MTFy1').setIndex('table', 0.45585682608945444, 12, 1);
model.func('MTFy1').setIndex('table', 81.25, 13, 0);
model.func('MTFy1').setIndex('table', 0.40284486067615366, 13, 1);
model.func('MTFy1').setIndex('table', 87.5, 14, 0);
model.func('MTFy1').setIndex('table', 0.35562743486868503, 14, 1);
model.func('MTFy1').setIndex('table', 93.75, 15, 0);
model.func('MTFy1').setIndex('table', 0.3150257263392287, 15, 1);
model.func('MTFy1').setIndex('table', 100, 16, 0);
model.func('MTFy1').setIndex('table', 0.28155542256664096, 16, 1);
model.func('MTFy1').setIndex('table', 106.25, 17, 0);
model.func('MTFy1').setIndex('table', 0.25541483478804605, 17, 1);
model.func('MTFy1').setIndex('table', 112.5, 18, 0);
model.func('MTFy1').setIndex('table', 0.2364869426154811, 18, 1);
model.func('MTFy1').setIndex('table', 118.75, 19, 0);
model.func('MTFy1').setIndex('table', 0.22436144044739956, 19, 1);
model.func('MTFy1').setIndex('table', 125, 20, 0);
model.func('MTFy1').setIndex('table', 0.21837731823860412, 20, 1);

model.result.dataset('mtfy1').set('source', 'function');
model.result.dataset('mtfy1').set('function', 'MTFy1');
model.result.dataset('mtfy1').set('parmin1', '0');
model.result.dataset('mtfy1').set('parmax1', '125');
model.result.dataset('mtfy1').set('par1', 'nu_out');

model.func.create('MTFx2', 'Interpolation');
model.func('MTFx2').label('MTFx2');

model.nodeGroup('mtfgrp').add('func', 'MTFx2');

model.func('MTFx2').set('funcname', 'MTFx2');
model.func('MTFx2').set('interp', 'cubicspline');
model.func('MTFx2').set('extrap', 'const');
model.func('MTFx2').set('table', {});
model.func('MTFx2').setIndex('table', 0, 0, 0);
model.func('MTFx2').setIndex('table', 1, 0, 1);
model.func('MTFx2').setIndex('table', 6.25, 1, 0);
model.func('MTFx2').setIndex('table', 0.9974029428434175, 1, 1);
model.func('MTFx2').setIndex('table', 12.5, 2, 0);
model.func('MTFx2').setIndex('table', 0.9896674507914701, 2, 1);
model.func('MTFx2').setIndex('table', 18.75, 3, 0);
model.func('MTFx2').setIndex('table', 0.9769590585205682, 3, 1);
model.func('MTFx2').setIndex('table', 25, 4, 0);
model.func('MTFx2').setIndex('table', 0.9595486899997383, 4, 1);
model.func('MTFx2').setIndex('table', 31.25, 5, 0);
model.func('MTFx2').setIndex('table', 0.937805363018846, 5, 1);
model.func('MTFx2').setIndex('table', 37.5, 6, 0);
model.func('MTFx2').setIndex('table', 0.9121889093703069, 6, 1);
model.func('MTFx2').setIndex('table', 43.75, 7, 0);
model.func('MTFx2').setIndex('table', 0.8832307181489015, 7, 1);
model.func('MTFx2').setIndex('table', 50, 8, 0);
model.func('MTFx2').setIndex('table', 0.8515180435435465, 8, 1);
model.func('MTFx2').setIndex('table', 56.25, 9, 0);
model.func('MTFx2').setIndex('table', 0.817692555119649, 9, 1);
model.func('MTFx2').setIndex('table', 62.5, 10, 0);
model.func('MTFx2').setIndex('table', 0.7825031545689004, 10, 1);
model.func('MTFx2').setIndex('table', 68.75, 11, 0);
model.func('MTFx2').setIndex('table', 0.7464831996029689, 11, 1);
model.func('MTFx2').setIndex('table', 75, 12, 0);
model.func('MTFx2').setIndex('table', 0.7103486060891906, 12, 1);
model.func('MTFx2').setIndex('table', 81.25, 13, 0);
model.func('MTFx2').setIndex('table', 0.6748408585163824, 13, 1);
model.func('MTFx2').setIndex('table', 87.5, 14, 0);
model.func('MTFx2').setIndex('table', 0.6405393470905837, 14, 1);
model.func('MTFx2').setIndex('table', 93.75, 15, 0);
model.func('MTFx2').setIndex('table', 0.6079756220511933, 15, 1);
model.func('MTFx2').setIndex('table', 100, 16, 0);
model.func('MTFx2').setIndex('table', 0.5776588967436559, 16, 1);
model.func('MTFx2').setIndex('table', 106.25, 17, 0);
model.func('MTFx2').setIndex('table', 0.5500057634130786, 17, 1);
model.func('MTFx2').setIndex('table', 112.5, 18, 0);
model.func('MTFx2').setIndex('table', 0.5253492475216576, 18, 1);
model.func('MTFx2').setIndex('table', 118.75, 19, 0);
model.func('MTFx2').setIndex('table', 0.5039172703650954, 19, 1);
model.func('MTFx2').setIndex('table', 125, 20, 0);
model.func('MTFx2').setIndex('table', 0.4858802171015056, 20, 1);

model.result.dataset.create('mtfx2', 'Grid1D');
model.result.dataset('mtfx2').label('MTFx2');

model.nodeGroup('datagrp').add('dataset', 'mtfx2');

model.result.dataset('mtfx2').set('source', 'function');
model.result.dataset('mtfx2').set('function', 'MTFx2');
model.result.dataset('mtfx2').set('parmin1', '0');
model.result.dataset('mtfx2').set('parmax1', '125');
model.result.dataset('mtfx2').set('par1', 'nu_out');

model.func.create('MTFy2', 'Interpolation');
model.func('MTFy2').label('MTFy2');

model.nodeGroup('mtfgrp').add('func', 'MTFy2');

model.func('MTFy2').set('funcname', 'MTFy2');
model.func('MTFy2').set('interp', 'cubicspline');
model.func('MTFy2').set('extrap', 'const');
model.func('MTFy2').set('table', {});
model.func('MTFy2').setIndex('table', 0, 0, 0);
model.func('MTFy2').setIndex('table', 1, 0, 1);
model.func('MTFy2').setIndex('table', 6.25, 1, 0);
model.func('MTFy2').setIndex('table', 0.9856907608541663, 1, 1);
model.func('MTFy2').setIndex('table', 12.5, 2, 0);
model.func('MTFy2').setIndex('table', 0.9435090239327825, 2, 1);
model.func('MTFy2').setIndex('table', 18.75, 3, 0);
model.func('MTFy2').setIndex('table', 0.8756529271217918, 3, 1);
model.func('MTFy2').setIndex('table', 25, 4, 0);
model.func('MTFy2').setIndex('table', 0.7857797451863104, 4, 1);
model.func('MTFy2').setIndex('table', 31.25, 5, 0);
model.func('MTFy2').setIndex('table', 0.678822023451373, 5, 1);
model.func('MTFy2').setIndex('table', 37.5, 6, 0);
model.func('MTFy2').setIndex('table', 0.5610864582907731, 6, 1);
model.func('MTFy2').setIndex('table', 43.75, 7, 0);
model.func('MTFy2').setIndex('table', 0.44083338098653707, 7, 1);
model.func('MTFy2').setIndex('table', 50, 8, 0);
model.func('MTFy2').setIndex('table', 0.32941724085406754, 8, 1);
model.func('MTFy2').setIndex('table', 56.25, 9, 0);
model.func('MTFy2').setIndex('table', 0.24550956955025338, 9, 1);
model.func('MTFy2').setIndex('table', 62.5, 10, 0);
model.func('MTFy2').setIndex('table', 0.2154024477942064, 10, 1);
model.func('MTFy2').setIndex('table', 68.75, 11, 0);
model.func('MTFy2').setIndex('table', 0.2425043570456568, 11, 1);
model.func('MTFy2').setIndex('table', 75, 12, 0);
model.func('MTFy2').setIndex('table', 0.2943091743437402, 12, 1);
model.func('MTFy2').setIndex('table', 81.25, 13, 0);
model.func('MTFy2').setIndex('table', 0.3441782038444013, 13, 1);
model.func('MTFy2').setIndex('table', 87.5, 14, 0);
model.func('MTFy2').setIndex('table', 0.3802791985010263, 14, 1);
model.func('MTFy2').setIndex('table', 93.75, 15, 0);
model.func('MTFy2').setIndex('table', 0.39823300925505994, 15, 1);
model.func('MTFy2').setIndex('table', 100, 16, 0);
model.func('MTFy2').setIndex('table', 0.39729989190025006, 16, 1);
model.func('MTFy2').setIndex('table', 106.25, 17, 0);
model.func('MTFy2').setIndex('table', 0.37899162977835893, 17, 1);
model.func('MTFy2').setIndex('table', 112.5, 18, 0);
model.func('MTFy2').setIndex('table', 0.34653105944061535, 18, 1);
model.func('MTFy2').setIndex('table', 118.75, 19, 0);
model.func('MTFy2').setIndex('table', 0.30470396981110126, 19, 1);
model.func('MTFy2').setIndex('table', 125, 20, 0);
model.func('MTFy2').setIndex('table', 0.25994169966682595, 20, 1);

model.result.dataset.create('mtfy2', 'Grid1D');
model.result.dataset('mtfy2').label('MTFy2');

model.nodeGroup('datagrp').add('dataset', 'mtfy2');

model.result.dataset('mtfy2').set('source', 'function');
model.result.dataset('mtfy2').set('function', 'MTFy2');
model.result.dataset('mtfy2').set('parmin1', '0');
model.result.dataset('mtfy2').set('parmax1', '125');
model.result.dataset('mtfy2').set('par1', 'nu_out');

model.func.create('MTFx3', 'Interpolation');
model.func('MTFx3').label('MTFx3');

model.nodeGroup('mtfgrp').add('func', 'MTFx3');

model.func('MTFx3').set('funcname', 'MTFx3');
model.func('MTFx3').set('interp', 'cubicspline');
model.func('MTFx3').set('extrap', 'const');
model.func('MTFx3').set('table', {});
model.func('MTFx3').setIndex('table', 0, 0, 0);
model.func('MTFx3').setIndex('table', 1, 0, 1);
model.func('MTFx3').setIndex('table', 6.25, 1, 0);
model.func('MTFx3').setIndex('table', 0.9983091506426673, 1, 1);
model.func('MTFx3').setIndex('table', 12.5, 2, 0);
model.func('MTFx3').setIndex('table', 0.99326246707553, 2, 1);
model.func('MTFx3').setIndex('table', 18.75, 3, 0);
model.func('MTFx3').setIndex('table', 0.9849368621529083, 3, 1);
model.func('MTFx3').setIndex('table', 25, 4, 0);
model.func('MTFx3').setIndex('table', 0.9734573192389726, 4, 1);
model.func('MTFx3').setIndex('table', 31.25, 5, 0);
model.func('MTFx3').setIndex('table', 0.9589894018246194, 5, 1);
model.func('MTFx3').setIndex('table', 37.5, 6, 0);
model.func('MTFx3').setIndex('table', 0.9417646762708283, 6, 1);
model.func('MTFx3').setIndex('table', 43.75, 7, 0);
model.func('MTFx3').setIndex('table', 0.9219882425312624, 7, 1);
model.func('MTFx3').setIndex('table', 50, 8, 0);
model.func('MTFx3').setIndex('table', 0.8999864550689026, 8, 1);
model.func('MTFx3').setIndex('table', 56.25, 9, 0);
model.func('MTFx3').setIndex('table', 0.8761118345117178, 9, 1);
model.func('MTFx3').setIndex('table', 62.5, 10, 0);
model.func('MTFx3').setIndex('table', 0.8505351363030591, 10, 1);
model.func('MTFx3').setIndex('table', 68.75, 11, 0);
model.func('MTFx3').setIndex('table', 0.8236968313158419, 11, 1);
model.func('MTFx3').setIndex('table', 75, 12, 0);
model.func('MTFx3').setIndex('table', 0.7958856196749882, 12, 1);
model.func('MTFx3').setIndex('table', 81.25, 13, 0);
model.func('MTFx3').setIndex('table', 0.7674186443239142, 13, 1);
model.func('MTFx3').setIndex('table', 87.5, 14, 0);
model.func('MTFx3').setIndex('table', 0.7386159944636653, 14, 1);
model.func('MTFx3').setIndex('table', 93.75, 15, 0);
model.func('MTFx3').setIndex('table', 0.7097596190066418, 15, 1);
model.func('MTFx3').setIndex('table', 100, 16, 0);
model.func('MTFx3').setIndex('table', 0.6811140700412716, 16, 1);
model.func('MTFx3').setIndex('table', 106.25, 17, 0);
model.func('MTFx3').setIndex('table', 0.6529247869379591, 17, 1);
model.func('MTFx3').setIndex('table', 112.5, 18, 0);
model.func('MTFx3').setIndex('table', 0.6253951789370717, 18, 1);
model.func('MTFx3').setIndex('table', 118.75, 19, 0);
model.func('MTFx3').setIndex('table', 0.5987001594452375, 19, 1);
model.func('MTFx3').setIndex('table', 125, 20, 0);
model.func('MTFx3').setIndex('table', 0.5730115002064169, 20, 1);

model.result.dataset.create('mtfx3', 'Grid1D');
model.result.dataset('mtfx3').label('MTFx3');

model.nodeGroup('datagrp').add('dataset', 'mtfx3');

model.result.dataset('mtfx3').set('source', 'function');
model.result.dataset('mtfx3').set('function', 'MTFx3');
model.result.dataset('mtfx3').set('parmin1', '0');
model.result.dataset('mtfx3').set('parmax1', '125');
model.result.dataset('mtfx3').set('par1', 'nu_out');

model.func.create('MTFy3', 'Interpolation');
model.func('MTFy3').label('MTFy3');

model.nodeGroup('mtfgrp').add('func', 'MTFy3');

model.func('MTFy3').set('funcname', 'MTFy3');
model.func('MTFy3').set('interp', 'cubicspline');
model.func('MTFy3').set('extrap', 'const');
model.func('MTFy3').set('table', {});
model.func('MTFy3').setIndex('table', 0, 0, 0);
model.func('MTFy3').setIndex('table', 1, 0, 1);
model.func('MTFy3').setIndex('table', 6.25, 1, 0);
model.func('MTFy3').setIndex('table', 0.9921347716796165, 1, 1);
model.func('MTFy3').setIndex('table', 12.5, 2, 0);
model.func('MTFy3').setIndex('table', 0.9688245515945453, 2, 1);
model.func('MTFy3').setIndex('table', 18.75, 3, 0);
model.func('MTFy3').setIndex('table', 0.9305087844910673, 3, 1);
model.func('MTFy3').setIndex('table', 25, 4, 0);
model.func('MTFy3').setIndex('table', 0.8797729319082408, 4, 1);
model.func('MTFy3').setIndex('table', 31.25, 5, 0);
model.func('MTFy3').setIndex('table', 0.8172393689748884, 5, 1);
model.func('MTFy3').setIndex('table', 37.5, 6, 0);
model.func('MTFy3').setIndex('table', 0.7453437663703265, 6, 1);
model.func('MTFy3').setIndex('table', 43.75, 7, 0);
model.func('MTFy3').setIndex('table', 0.6672902990340912, 7, 1);
model.func('MTFy3').setIndex('table', 50, 8, 0);
model.func('MTFy3').setIndex('table', 0.5852144114149821, 8, 1);
model.func('MTFy3').setIndex('table', 56.25, 9, 0);
model.func('MTFy3').setIndex('table', 0.5022025775865957, 9, 1);
model.func('MTFy3').setIndex('table', 62.5, 10, 0);
model.func('MTFy3').setIndex('table', 0.4213489262770553, 10, 1);
model.func('MTFy3').setIndex('table', 68.75, 11, 0);
model.func('MTFy3').setIndex('table', 0.3456367025358385, 11, 1);
model.func('MTFy3').setIndex('table', 75, 12, 0);
model.func('MTFy3').setIndex('table', 0.27813209154191304, 12, 1);
model.func('MTFy3').setIndex('table', 81.25, 13, 0);
model.func('MTFy3').setIndex('table', 0.2218792886813129, 13, 1);
model.func('MTFy3').setIndex('table', 87.5, 14, 0);
model.func('MTFy3').setIndex('table', 0.17963281526243777, 14, 1);
model.func('MTFy3').setIndex('table', 93.75, 15, 0);
model.func('MTFy3').setIndex('table', 0.15261939194822197, 15, 1);
model.func('MTFy3').setIndex('table', 100, 16, 0);
model.func('MTFy3').setIndex('table', 0.13889290780653354, 16, 1);
model.func('MTFy3').setIndex('table', 106.25, 17, 0);
model.func('MTFy3').setIndex('table', 0.13319043110768852, 17, 1);
model.func('MTFy3').setIndex('table', 112.5, 18, 0);
model.func('MTFy3').setIndex('table', 0.1296979729967804, 18, 1);
model.func('MTFy3').setIndex('table', 118.75, 19, 0);
model.func('MTFy3').setIndex('table', 0.12444218711535036, 19, 1);
model.func('MTFy3').setIndex('table', 125, 20, 0);
model.func('MTFy3').setIndex('table', 0.11560502113864336, 20, 1);

model.result.dataset.create('mtfy3', 'Grid1D');
model.result.dataset('mtfy3').label('MTFy3');

model.nodeGroup('datagrp').add('dataset', 'mtfy3');

model.result.dataset('mtfy3').set('source', 'function');
model.result.dataset('mtfy3').set('function', 'MTFy3');
model.result.dataset('mtfy3').set('parmin1', '0');
model.result.dataset('mtfy3').set('parmax1', '125');
model.result.dataset('mtfy3').set('par1', 'nu_out');
model.result('pg5').set('axislimits', true);
model.result('pg5').set('xmin', -2.5);
model.result('pg5').set('xmax', 127.5);
model.result('pg5').set('ymin', 0);
model.result('pg5').set('ymax', 1.05);
model.result('pg5').set('yminsec', 0);
model.result('pg5').set('ymaxsec', 1.05);
model.result('pg5').create('mtfx2', 'LineGraph');
model.result('pg5').feature('mtfx2').label('MTFx2');
model.result('pg5').feature('mtfx2').set('xdata', 'expr');
model.result('pg5').feature('mtfx2').set('expr', 'MTFx2(nu_out) ');
model.result('pg5').feature('mtfx2').set('xdataexpr', 'nu_out');
model.result('pg5').feature('mtfx2').set('xdatadescractive', true);
model.result('pg5').feature('mtfx2').set('xdatadescr', 'Frequency (1/mm)');
model.result('pg5').feature('mtfx2').set('data', 'mtfx2');
model.result('pg5').feature('mtfx2').set('legend', true);
model.result('pg5').feature('mtfx2').set('autodescr', true);
model.result('pg5').feature('mtfx2').set('autosolution', false);
model.result('pg5').feature('mtfx2').set('descractive', true);
model.result('pg5').feature('mtfx2').set('descr', 'Release from Grid 2: x');
model.result('pg5').feature('mtfx2').set('smooth', 'none');
model.result('pg5').feature('mtfx2').set('resolution', 'norefine');
model.result('pg5').create('mtfy2', 'LineGraph');
model.result('pg5').feature('mtfy2').label('MTFy2');
model.result('pg5').feature('mtfy2').set('xdata', 'expr');
model.result('pg5').feature('mtfy2').set('expr', 'MTFy2(nu_out) ');
model.result('pg5').feature('mtfy2').set('xdataexpr', 'nu_out');
model.result('pg5').feature('mtfy2').set('xdatadescractive', true);
model.result('pg5').feature('mtfy2').set('xdatadescr', 'Frequency (1/mm)');
model.result('pg5').feature('mtfy2').set('data', 'mtfy2');
model.result('pg5').feature('mtfy2').set('legend', true);
model.result('pg5').feature('mtfy2').set('autodescr', true);
model.result('pg5').feature('mtfy2').set('autosolution', false);
model.result('pg5').feature('mtfy2').set('descractive', true);
model.result('pg5').feature('mtfy2').set('descr', 'Release from Grid 2: y');
model.result('pg5').feature('mtfy2').set('smooth', 'none');
model.result('pg5').feature('mtfy2').set('resolution', 'norefine');
model.result('pg5').create('mtfx3', 'LineGraph');
model.result('pg5').feature('mtfx3').label('MTFx3');
model.result('pg5').feature('mtfx3').set('xdata', 'expr');
model.result('pg5').feature('mtfx3').set('expr', 'MTFx3(nu_out) ');
model.result('pg5').feature('mtfx3').set('xdataexpr', 'nu_out');
model.result('pg5').feature('mtfx3').set('xdatadescractive', true);
model.result('pg5').feature('mtfx3').set('xdatadescr', 'Frequency (1/mm)');
model.result('pg5').feature('mtfx3').set('data', 'mtfx3');
model.result('pg5').feature('mtfx3').set('legend', true);
model.result('pg5').feature('mtfx3').set('autodescr', true);
model.result('pg5').feature('mtfx3').set('autosolution', false);
model.result('pg5').feature('mtfx3').set('descractive', true);
model.result('pg5').feature('mtfx3').set('descr', 'Release from Grid 3: x');
model.result('pg5').feature('mtfx3').set('smooth', 'none');
model.result('pg5').feature('mtfx3').set('resolution', 'norefine');
model.result('pg5').create('mtfy3', 'LineGraph');
model.result('pg5').feature('mtfy3').label('MTFy3');
model.result('pg5').feature('mtfy3').set('xdata', 'expr');
model.result('pg5').feature('mtfy3').set('expr', 'MTFy3(nu_out) ');
model.result('pg5').feature('mtfy3').set('xdataexpr', 'nu_out');
model.result('pg5').feature('mtfy3').set('xdatadescractive', true);
model.result('pg5').feature('mtfy3').set('xdatadescr', 'Frequency (1/mm)');
model.result('pg5').feature('mtfy3').set('data', 'mtfy3');
model.result('pg5').feature('mtfy3').set('legend', true);
model.result('pg5').feature('mtfy3').set('autodescr', true);
model.result('pg5').feature('mtfy3').set('autosolution', false);
model.result('pg5').feature('mtfy3').set('descractive', true);
model.result('pg5').feature('mtfy3').set('descr', 'Release from Grid 3: y');
model.result('pg5').feature('mtfy3').set('smooth', 'none');
model.result('pg5').feature('mtfy3').set('resolution', 'norefine');

% Finished method call computeMTF

model.result('pg3').run;
model.result('pg3').run;
model.result('pg4').run;
model.result('pg4').run;
model.result('pg5').run;
model.result('pg5').run;

model.title('Petzval Lens Geometric Modulation Transfer Function');

model.description('This model and tutorial demonstrates the use of an Application Method to compute and plot the geometric Modulation Transfer Function (MTF) for the Petzval Lens.');

model.mesh.clearMeshes;

model.sol('sol1').clearSolutionData;

model.label('petzval_lens_geometric_modulation_transfer_function.mph');

model.modelNode.label('Components');

out = model;
