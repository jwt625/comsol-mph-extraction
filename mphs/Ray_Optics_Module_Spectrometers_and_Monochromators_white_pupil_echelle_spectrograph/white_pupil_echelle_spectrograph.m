function out = model
%
% white_pupil_echelle_spectrograph.m
%
% Model exported on May 26 2025, 21:32 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/Ray_Optics_Module/Spectrometers_and_Monochromators');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 3);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.physics.create('gop', 'GeometricalOptics', 'geom1');
model.physics('gop').model('comp1');

model.study.create('std1');
model.study('std1').create('rtrac', 'RayTracing');
model.study('std1').feature('rtrac').setSolveFor('/physics/gop', true);

model.param.label('Parameters 1: Geometry');
model.param.create('par2');
model.param('par2').label('Parameters 2: General');

% To import content from file, use:
% model.param('par2').loadFile('FILENAME');
model.param('par2').set('N_hex', '10', 'Number of hexapolar rings');
model.param('par2').set('xi', 'sin(theta_i)', 'Input optical axis, x-component');
model.param('par2').set('yi', '0', 'Input optical axis, y-component');
model.param('par2').set('zi', 'cos(theta_i)', 'Input optical axis, z-component');
model.param('par2').set('F', 'f_1/B', 'Input focal ratio');
model.param('par2').set('NA', '0.5/F', 'Input numerical aperture');
model.param('par2').set('T_ech', '31.6[mm^-1]', 'Echelle grating line frequency');
model.param('par2').set('sigma_ech', '1/T_ech', 'Echelle grating line spacing');
model.param('par2').set('mlam', '2*sigma_ech*cos(gamma_ech)*sin(theta_B)', 'Order number times wavelength constant');
model.param('par2').set('lam_min', '450[nm]', 'Nominal minimum wavelength');
model.param('par2').set('lam_max', '600[nm]', 'Nominal maximum wavelength');
model.param('par2').set('m_max', 'round(mlam/lam_min)', 'Maximum order number');
model.param('par2').set('m_min', 'round(mlam/lam_max)', 'Minimum order number');
model.param('par2').set('m_mid', '(m_max+m_min)/2-2', '                       Middle order number');

model.geom('geom1').label(['White Pupil ' native2unicode(hex2dec({'00' 'c9'}), 'unicode') 'chelle Spectrograph Geometry Sequence']);
model.geom('geom1').insertFile('white_pupil_echelle_spectrograph_geom_sequence.mph', 'geom1');
model.geom('geom1').runPre('fin');

model.view('view1').camera.set('projection', 'orthographic');

model.geom('geom1').run;

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
model.material.create('mat5', 'Common', 'comp1');
model.material('mat5').propertyGroup.create('Enu', 'Young''s modulus and Poisson''s ratio');
model.material('mat5').propertyGroup.create('RefractiveIndex', 'Refractive index');
model.material('mat5').label('Silica glass');
model.material('mat5').set('family', 'custom');
model.material('mat5').set('customambient', [1 1 1]);
model.material('mat5').set('noise', true);
model.material('mat5').set('fresnel', 0.99);
model.material('mat5').set('roughness', 0.02);
model.material('mat5').set('metallic', 0);
model.material('mat5').set('pearl', 0);
model.material('mat5').set('diffusewrap', 0);
model.material('mat5').set('clearcoat', 0);
model.material('mat5').set('reflectance', 0);
model.material('mat5').propertyGroup('def').set('relpermeability', {'1' '0' '0' '0' '1' '0' '0' '0' '1'});
model.material('mat5').propertyGroup('def').set('electricconductivity', {'1e-14[S/m]' '0' '0' '0' '1e-14[S/m]' '0' '0' '0' '1e-14[S/m]'});
model.material('mat5').propertyGroup('def').set('thermalexpansioncoefficient', {'0.55e-6[1/K]' '0' '0' '0' '0.55e-6[1/K]' '0' '0' '0' '0.55e-6[1/K]'});
model.material('mat5').propertyGroup('def').set('heatcapacity', '703[J/(kg*K)]');
model.material('mat5').propertyGroup('def').set('relpermittivity', {'3.75' '0' '0' '0' '3.75' '0' '0' '0' '3.75'});
model.material('mat5').propertyGroup('def').set('density', '2203[kg/m^3]');
model.material('mat5').propertyGroup('def').set('thermalconductivity', {'1.38[W/(m*K)]' '0' '0' '0' '1.38[W/(m*K)]' '0' '0' '0' '1.38[W/(m*K)]'});
model.material('mat5').propertyGroup('Enu').set('E', '73.1[GPa]');
model.material('mat5').propertyGroup('Enu').set('nu', '0.17');
model.material('mat5').propertyGroup('RefractiveIndex').set('n', {'1.45' '0' '0' '0' '1.45' '0' '0' '0' '1.45'});
model.material('mat1').selection.named('geom1_csel1_dom');
model.material('mat2').selection.named('geom1_csel2_dom');
model.material('mat3').selection.named('geom1_csel3_dom');
model.material('mat4').selection.named('geom1_csel4_dom');
model.material('mat5').selection.named('geom1_csel12_dom');

model.physics('gop').selection.named('geom1_unisel1');
model.physics('gop').prop('WavelengthDistribution').setIndex('WavelengthDistribution', 'PolychromaticWavelength', 0);
model.physics('gop').prop('MaximumSecondary').setIndex('MaximumSecondary', 0, 0);
model.physics('gop').prop('ExteriorUnmeshedProperties').setIndex('DispersionModel', 'AbsoluteVacuum', 0);
model.physics('gop').prop('ComputeOpticalPathLength').setIndex('ComputeOpticalPathLength', 1, 0);
model.physics('gop').prop('CountReflections').setIndex('CountReflections', 1, 0);
model.physics('gop').prop('StoreRayStatusData').setIndex('StoreRayStatusData', 1, 0);
model.physics('gop').feature('mp1').set('RefractiveIndexDomains', 'GetDispersionModelFromMaterial');
model.physics('gop').feature('matd1').set('ReleaseReflectedRays', 'Never');
model.physics('gop').create('rpt1', 'ReleaseFromPoint', 0);
model.physics('gop').feature('rpt1').label('Release From Entrance Slit: m_max');
model.physics('gop').feature('rpt1').selection.named('geom1_pt1_pnt');
model.physics('gop').feature('rpt1').set('RayDirectionVector', 'Conical');
model.physics('gop').feature('rpt1').set('ConicalDistribution', 'Hexapolar');
model.physics('gop').feature('rpt1').setIndex('Nctheta', 'N_hex', 0);
model.physics('gop').feature('rpt1').set('cax', {'xi' 'yi' 'zi'});
model.physics('gop').feature('rpt1').set('alphac', 'atan(NA)');
model.physics('gop').feature('rpt1').set('LDistributionFunction', 'ListOfValues');
model.physics('gop').feature('rpt1').setIndex('lambda0vals', 'mlam/(m_max+0.499) mlam/(m_max+0.25) mlam/m_max mlam/(m_max-0.25) mlam/(m_max-0.499)', 0);
model.physics('gop').feature.duplicate('rpt2', 'rpt1');
model.physics('gop').feature('rpt2').label('Release From Entrance Slit: m_mid');
model.physics('gop').feature('rpt2').setIndex('lambda0vals', 'mlam/(m_mid+0.499) mlam/(m_mid+0.25) mlam/m_mid mlam/(m_mid-0.25) mlam/(m_mid-0.499)', 0);
model.physics('gop').feature.duplicate('rpt3', 'rpt2');
model.physics('gop').feature('rpt3').label('Release From Entrance Slit: m_min');
model.physics('gop').feature('rpt3').setIndex('lambda0vals', 'mlam/(m_min+0.495) mlam/(m_min+0.25) mlam/m_min mlam/(m_min-0.25) mlam/(m_min-0.495)', 0);
model.physics('gop').create('mir1', 'Mirror', 2);
model.physics('gop').feature('mir1').label('Mirrors');
model.physics('gop').feature('mir1').selection.named('geom1_csel10_bnd');
model.physics('gop').create('wall1', 'Wall', 2);
model.physics('gop').feature('wall1').label('Obstructions (Gratings and Mirrors)');
model.physics('gop').feature('wall1').selection.named('geom1_csel11_bnd');
model.physics('gop').feature('wall1').set('WallCondition', 'Disappear');
model.physics('gop').create('wall2', 'Wall', 2);
model.physics('gop').feature('wall2').label('Obstructions (Camera)');
model.physics('gop').feature('wall2').selection.named('geom1_csel7_bnd');
model.physics('gop').feature('wall2').set('WallCondition', 'Disappear');
model.physics('gop').create('grat1', 'Grating', 2);
model.physics('gop').feature('grat1').label([native2unicode(hex2dec({'00' 'c9'}), 'unicode') 'chelle Grating']);
model.physics('gop').feature('grat1').selection.named('geom1_pi3_sel3');
model.physics('gop').feature('grat1').set('DirectionOfPeriodicity', 'ParallelToReferenceEdge');
model.physics('gop').feature('grat1').selection('ReferenceEdge').set([182]);
model.physics('gop').feature('grat1').set('UseRelativeOrderNumbers', true);
model.physics('gop').feature('grat1').set('RaysToRelease', 'Reflected');
model.physics('gop').feature('grat1').set('dg', 'sigma_ech');
model.physics('gop').feature('grat1').set('thetab', 'theta_B');
model.physics('gop').create('grat2', 'Grating', 2);
model.physics('gop').feature('grat2').label('Cross Dispersion Grating');
model.physics('gop').feature('grat2').selection.named('geom1_pi4_sel3');
model.physics('gop').feature('grat2').set('DirectionOfPeriodicity', 'ParallelToReferenceEdge');
model.physics('gop').feature('grat2').selection('ReferenceEdge').set([117]);
model.physics('gop').feature('grat2').set('RaysToRelease', 'Transmitted');
model.physics('gop').feature('grat2').set('dg', 'sigma_xdp');
model.physics('gop').feature('grat2').feature('dfo1').set('mg', 1);
model.physics('gop').create('wall3', 'Wall', 2);
model.physics('gop').feature('wall3').label('Detector');
model.physics('gop').feature('wall3').selection.named('geom1_pi12_sel1');

model.selection.create('uni1', 'Union');
model.selection('uni1').model('comp1');
model.selection('uni1').set('entitydim', 2);
model.selection('uni1').set('input', {'geom1_csel5_bnd' 'geom1_pi4_sel2' 'geom1_pi5_sel2'});
model.selection.create('uni2', 'Union');
model.selection('uni2').model('comp1');
model.selection('uni2').set('entitydim', 2);
model.selection('uni2').set('input', {'geom1_csel10_bnd' 'geom1_pi3_sel3'});

model.mesh('mesh1').autoMeshSize(1);
model.mesh('mesh1').run;

model.study('std1').feature('rtrac').set('timestepspec', 'specifylength');
model.study('std1').feature('rtrac').set('lunit', 'mm');
model.study('std1').feature('rtrac').set('llist', '0 5000');

model.sol.create('sol1');
model.sol('sol1').study('std1');
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
model.sol('sol1').attach('std1');
model.sol('sol1').runAll;

model.result.dataset.create('ray1', 'Ray');
model.result.dataset('ray1').set('solution', 'sol1');
model.result.dataset('ray1').set('posdof', {'comp1.qx' 'comp1.qy' 'comp1.qz'});
model.result.dataset('ray1').set('geom', 'geom1');
model.result.dataset('ray1').set('rgeom', 'pgeom_gop');
model.result.dataset('ray1').set('rgeomspec', 'fromphysics');
model.result.dataset('ray1').set('physicsinterface', 'gop');
model.result.create('pg1', 'PlotGroup3D');
model.result('pg1').set('data', 'ray1');
model.result('pg1').setIndex('looplevel', 2, 0);
model.result('pg1').label('Ray Trajectories (gop)');
model.result('pg1').create('rtrj1', 'RayTrajectories');
model.result('pg1').feature('rtrj1').set('linetype', 'line');
model.result('pg1').feature('rtrj1').create('col1', 'Color');
model.result('pg1').feature('rtrj1').feature('col1').set('expr', 'gop.L');
model.result('pg1').feature('rtrj1').create('filt1', 'RayTrajectoriesFilter');
model.result('pg1').run;
model.result('pg1').run;
model.result('pg1').label('Ray Diagram');
model.result('pg1').set('showlegendsunit', true);
model.result('pg1').set('showlegendsmaxmin', true);
model.result('pg1').set('legendpos', 'bottom');
model.result('pg1').set('legendactive', true);
model.result('pg1').set('legendprecision', 4);
model.result('pg1').run;
model.result('pg1').run;
model.result('pg1').feature('rtrj1').feature('col1').set('expr', 'gop.lambda0');
model.result('pg1').feature('rtrj1').feature('col1').set('unit', 'nm');
model.result('pg1').feature('rtrj1').feature('col1').set('colortable', 'Spectrum');
model.result('pg1').run;
model.result('pg1').feature('rtrj1').feature('filt1').set('type', 'logical');
model.result('pg1').feature('rtrj1').feature('filt1').set('logicalexpr', 'at(0,tan(gop.phic))>0.95*NA');
model.result('pg1').run;
model.result('pg1').create('surf1', 'Surface');
model.result('pg1').feature('surf1').set('coloring', 'uniform');
model.result('pg1').feature('surf1').set('color', 'gray');
model.result('pg1').feature('surf1').create('sel1', 'Selection');
model.result('pg1').feature('surf1').feature('sel1').selection.named('geom1_csel11_bnd');
model.result('pg1').run;
model.result('pg1').feature('surf1').create('tran1', 'Transparency');
model.result('pg1').run;
model.result('pg1').run;
model.result('pg1').feature.duplicate('surf2', 'surf1');
model.result('pg1').run;
model.result('pg1').feature('surf2').set('color', 'blue');
model.result('pg1').run;
model.result('pg1').feature('surf2').feature('sel1').selection.named('uni1');
model.result('pg1').run;
model.result('pg1').feature('surf2').feature('tran1').set('transparency', 0.8);
model.result('pg1').run;
model.result('pg1').feature.duplicate('surf3', 'surf2');
model.result('pg1').run;
model.result('pg1').feature('surf3').set('color', 'custom');
model.result('pg1').feature('surf3').set('customcolor', [0.7411764860153198 0.7882353067398071 0.8470588326454163]);
model.result('pg1').run;
model.result('pg1').feature('surf3').feature('sel1').selection.named('uni2');
model.result('pg1').run;
model.result('pg1').feature('surf3').feature('tran1').set('transparency', 0.2);
model.result('pg1').run;
model.result.create('pg2', 'PlotGroup2D');
model.result('pg2').run;
model.result('pg2').label([native2unicode(hex2dec({'00' 'c9'}), 'unicode') 'chelle Diagram']);
model.result('pg2').set('titletype', 'none');
model.result('pg2').set('showlegendsmaxmin', true);
model.result('pg2').set('showlegendsunit', true);
model.result('pg2').set('legendpos', 'bottom');
model.result('pg2').set('legendactive', true);
model.result('pg2').set('legendprecision', 4);
model.result('pg2').create('spot1', 'SpotDiagram');
model.result('pg2').feature('spot1').set('numberofreflectionsactive', true);
model.result('pg2').feature('spot1').set('numberofreflections', '4');
model.result('pg2').feature('spot1').set('transverse', 'userdefined');
model.result('pg2').feature('spot1').set('transverseexpr', [0 1 0]);
model.result('pg2').feature('spot1').set('arrangement', 'single');
model.result('pg2').feature('spot1').set('spotsizeactive', false);
model.result('pg2').feature('spot1').set('sphereradiusscaleactive', true);
model.result('pg2').feature('spot1').create('col1', 'Color');
model.result('pg2').run;
model.result('pg2').feature('spot1').feature('col1').set('expr', 'gop.lambda0');
model.result('pg2').run;
model.result.create('pg3', 'PlotGroup2D');
model.result('pg3').run;
model.result('pg3').label('Spot Diagram');
model.result('pg3').set('showlegendsmaxmin', true);
model.result('pg3').set('legendpos', 'bottom');
model.result('pg3').set('legendactive', true);
model.result('pg3').set('legendprecision', 4);
model.result('pg3').create('spot1', 'SpotDiagram');
model.result('pg3').feature('spot1').set('numberofreflectionsactive', true);
model.result('pg3').feature('spot1').set('numberofreflections', '4');
model.result('pg3').feature('spot1').set('arrangement', 'wavelength');
model.result('pg3').feature('spot1').set('layout', 'rectangular');
model.result('pg3').feature('spot1').set('columns', 5);
model.result('pg3').feature('spot1').set('tolerance', '0.1[nm]');
model.result('pg3').feature('spot1').set('origin', 'area');
model.result('pg3').feature('spot1').set('wavelengthactive', true);
model.result('pg3').feature('spot1').set('wavelengthprecision', 5);
model.result('pg3').feature('spot1').create('col1', 'Color');
model.result('pg3').run;
model.result('pg3').feature('spot1').feature('col1').set('expr', 'at(0,tan(gop.phic))');
model.result('pg3').run;

model.view('view15').set('showgrid', false);

model.title(['White Pupil ' native2unicode(hex2dec({'00' 'c9'}), 'unicode') 'chelle Spectrograph']);

model.description([native2unicode(hex2dec({'00' 'c9'}), 'unicode') 'chelle spectrographs are commonly used in astronomy for high-resolution analyses of stellar atmospheres and for precision Doppler velocimetry. This tutorial simulates a "white pupil" form of this instrument. It makes use of several parts from the Ray Optics Module Part Library and demonstrates the creation of a complex fully parameterized geometry. Two grating components are included, and the use of the Diffraction Order node is demonstrated. The ' native2unicode(hex2dec({'00' 'e9'}), 'unicode') 'chelle grating is used in high order while the cross dispersion grating is used in first order. The resulting ray, ' native2unicode(hex2dec({'00' 'e9'}), 'unicode') 'chelle, and spot diagrams are shown.']);

model.mesh.clearMeshes;

model.sol('sol1').clearSolutionData;

model.label('white_pupil_echelle_spectrograph.mph');

model.modelNode.label('Components');

out = model;
