function out = model
%
% double_gauss_lens.m
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
model.param('par2').set('lambda', '550[nm]', 'Nominal vacuum wavelength');
model.param('par2').set('theta_x', '0[deg]', 'Nominal x field angle');
model.param('par2').set('theta_y', '0[deg]', 'Nominal y field angle');
model.param('par2').set('N_ring', '18', 'Number of hexapolar rings');
model.param('par2').set('P_nom', '58.941[mm]', 'Nominal entrance pupil diameter');
model.param('par2').set('vx', 'tan(theta_x)', 'Ray direction vector, x-component');
model.param('par2').set('vy', 'tan(theta_y)', 'Ray direction vector, y-component');
model.param('par2').set('vz', '1', 'Ray direction vector, z-component');
model.param('par2').set('z_stop', 'Tc_1+T_1+Tc_2+T_2+Tc_3+T_3', 'Stop z-coordinate');
model.param('par2').set('z_image', 'Tc_1+T_1+Tc_2+T_2+Tc_3+T_3+Tc_4+T_4+Tc_5+T_5+Tc_6+T_6+Tc_7+T_7', 'Image plane z-coordinate');
model.param('par2').set('P_fac1', '-1.15', 'Pupil shift constant 1');
model.param('par2').set('P_fac2', '-0.60', 'Pupil shift constant 2');
model.param('par2').set('P_fac', 'P_fac1+P_fac2*sin(sqrt(theta_x^2+theta_y^2))', 'Pupil shift factor');
model.param('par2').set('dx', '(dz+P_fac*z_stop)*tan(theta_x)', 'Pupil center, x-coordinate');
model.param('par2').set('dy', '(dz+P_fac*z_stop)*tan(theta_y)', 'Pupil center, y-coordinate');
model.param('par2').set('dz', '-1[mm]', 'Pupil center, z-component');

model.geom('geom1').label('Double Gauss Lens');
model.geom('geom1').insertFile('double_gauss_lens_geom_sequence.mph', 'geom1');
model.geom('geom1').run('fin');

model.view('view1').camera.set('projection', 'orthographic');

model.material.create('mat1', 'Common', 'comp1');
model.material('mat1').propertyGroup('def').func.create('int1', 'Interpolation');
model.material('mat1').propertyGroup.create('DispersionModelSellmeierStandard', 'Sellmeier');
model.material('mat1').propertyGroup.create('ThermoOpticDispersionModelSchott', 'Schott thermo-optic');
model.material('mat1').propertyGroup.create('Enu', 'Young''s modulus and Poisson''s ratio');
model.material('mat1').propertyGroup.create('InternalTransmittance10', ['Internal transmittance, 10' native2unicode(hex2dec({'00' 'a0'}), 'unicode') 'mm sample thickness']);
model.material('mat1').propertyGroup('InternalTransmittance10').func.create('int1', 'Interpolation');
model.material('mat1').label('Ohara S-LAM 3 Glass');
model.material('mat1').propertyGroup('def').func('int1').set('funcname', 'Cp');
model.material('mat1').propertyGroup('def').func('int1').set('table', {'20' '0.452';  ...
'30' '0.465';  ...
'40' '0.477';  ...
'50' '0.49';  ...
'60' '0.5';  ...
'70' '0.51';  ...
'80' '0.522';  ...
'90' '0.532';  ...
'100' '0.542';  ...
'110' '0.552';  ...
'120' '0.562';  ...
'130' '0.572';  ...
'140' '0.58';  ...
'150' '0.588';  ...
'160' '0.594';  ...
'170' '0.598';  ...
'180' '0.604';  ...
'190' '0.608';  ...
'200' '0.612';  ...
'210' '0.615';  ...
'220' '0.62';  ...
'230' '0.623';  ...
'240' '0.627';  ...
'250' '0.631';  ...
'260' '0.635';  ...
'270' '0.639';  ...
'280' '0.642';  ...
'290' '0.646';  ...
'300' '0.648'});
model.material('mat1').propertyGroup('def').func('int1').set('fununit', {'J/(g*K)'});
model.material('mat1').propertyGroup('def').func('int1').set('argunit', {'degC'});
model.material('mat1').propertyGroup('def').set('heatcapacity', 'Cp(T)');
model.material('mat1').propertyGroup('def').set('density', '4.25[g/cm^3]');
model.material('mat1').propertyGroup('def').set('thermalconductivity', {'0.655[W/(m*K)]' '0' '0' '0' '0.655[W/(m*K)]' '0' '0' '0' '0.655[W/(m*K)]'});
model.material('mat1').propertyGroup('def').set('thermalexpansioncoefficient', {'80.0E-7[1/K]' '0' '0' '0' '80.0E-7[1/K]' '0' '0' '0' '80.0E-7[1/K]'});
model.material('mat1').propertyGroup('def').addInput('temperature');
model.material('mat1').propertyGroup('DispersionModelSellmeierStandard').set('ODsma', {'1.64258713E+00' '2.39634610E-01' '1.22483026E+00' '8.68246020E-03' '3.51226242E-02' '1.16604369E+02'});
model.material('mat1').propertyGroup('DispersionModelSellmeierStandard').set('Trefsma', '25[degC]');
model.material('mat1').propertyGroup('DispersionModelSellmeierStandard').set('Prefsma', '1[atm]');
model.material('mat1').propertyGroup('DispersionModelSellmeierStandard').addInput('frequency');
model.material('mat1').propertyGroup('ThermoOpticDispersionModelSchott').set('TOsco', {'-4.66E-6' '9.34E-9' '-3.89E-11' '4.57E-7' '5.81E-10' '0.266'});
model.material('mat1').propertyGroup('ThermoOpticDispersionModelSchott').set('Trefsco', '25[degC]');
model.material('mat1').propertyGroup('Enu').set('E', '868.0E8[Pa]');
model.material('mat1').propertyGroup('Enu').set('nu', '0.294');
model.material('mat1').propertyGroup('InternalTransmittance10').func('int1').set('funcname', 'taui10');
model.material('mat1').propertyGroup('InternalTransmittance10').func('int1').set('table', {'340' '0.1';  ...
'350' '0.41';  ...
'360' '0.69';  ...
'370' '0.83';  ...
'380' '0.916';  ...
'390' '0.951';  ...
'400' '0.968';  ...
'420' '0.982';  ...
'440' '0.987';  ...
'460' '0.99';  ...
'480' '0.993';  ...
'500' '0.995';  ...
'550' '0.997';  ...
'600' '0.996';  ...
'650' '0.996';  ...
'700' '0.997';  ...
'800' '0.999';  ...
'900' '0.997';  ...
'1000' '0.997';  ...
'1200' '0.996';  ...
'1400' '0.994';  ...
'1600' '0.992';  ...
'1800' '0.983';  ...
'2000' '0.966';  ...
'2200' '0.92';  ...
'2400' '0.77'});
model.material('mat1').propertyGroup('InternalTransmittance10').func('int1').set('extrap', 'none');
model.material('mat1').propertyGroup('InternalTransmittance10').func('int1').set('fununit', {'1'});
model.material('mat1').propertyGroup('InternalTransmittance10').func('int1').set('argunit', {'nm'});
model.material('mat1').propertyGroup('InternalTransmittance10').set('taui10', 'taui10(c_const/freq)');
model.material('mat1').propertyGroup('InternalTransmittance10').addInput('frequency');
model.material.create('mat2', 'Common', 'comp1');
model.material('mat2').propertyGroup.create('DispersionModelSellmeierStandard', 'Sellmeier');
model.material('mat2').propertyGroup.create('ThermoOpticDispersionModelSchott', 'Schott thermo-optic');
model.material('mat2').propertyGroup.create('Enu', 'Young''s modulus and Poisson''s ratio');
model.material('mat2').propertyGroup.create('InternalTransmittance10', ['Internal transmittance, 10' native2unicode(hex2dec({'00' 'a0'}), 'unicode') 'mm sample thickness']);
model.material('mat2').propertyGroup('InternalTransmittance10').func.create('int1', 'Interpolation');
model.material('mat2').label('Ohara S-BAH11 Glass');
model.material('mat2').propertyGroup('def').set('density', '3.59[g/cm^3]');
model.material('mat2').propertyGroup('def').set('thermalconductivity', {'0.858[W/(m*K)]' '0' '0' '0' '0.858[W/(m*K)]' '0' '0' '0' '0.858[W/(m*K)]'});
model.material('mat2').propertyGroup('def').set('thermalexpansioncoefficient', {'69.0E-7[1/K]' '0' '0' '0' '69.0E-7[1/K]' '0' '0' '0' '69.0E-7[1/K]'});
model.material('mat2').propertyGroup('DispersionModelSellmeierStandard').set('ODsma', {'1.57138860E+00' '1.47869313E-01' '1.28092846E+00' '9.10807936E-03' '4.02401684E-02' '1.30399367E+02'});
model.material('mat2').propertyGroup('DispersionModelSellmeierStandard').set('Trefsma', '25[degC]');
model.material('mat2').propertyGroup('DispersionModelSellmeierStandard').set('Prefsma', '1[atm]');
model.material('mat2').propertyGroup('DispersionModelSellmeierStandard').addInput('frequency');
model.material('mat2').propertyGroup('ThermoOpticDispersionModelSchott').set('TOsco', {'2.98E-6' '1.09E-8' '-3.44E-11' '5.52E-7' '7.15E-10' '0.244'});
model.material('mat2').propertyGroup('ThermoOpticDispersionModelSchott').set('Trefsco', '25[degC]');
model.material('mat2').propertyGroup('Enu').set('E', '929.0E8[Pa]');
model.material('mat2').propertyGroup('Enu').set('nu', '0.274');
model.material('mat2').propertyGroup('InternalTransmittance10').func('int1').set('funcname', 'taui10');
model.material('mat2').propertyGroup('InternalTransmittance10').func('int1').set('table', {'340' '0.04';  ...
'350' '0.27';  ...
'360' '0.56';  ...
'370' '0.75';  ...
'380' '0.86';  ...
'390' '0.922';  ...
'400' '0.952';  ...
'420' '0.975';  ...
'440' '0.982';  ...
'460' '0.987';  ...
'480' '0.991';  ...
'500' '0.994';  ...
'550' '0.997';  ...
'600' '0.995';  ...
'650' '0.995';  ...
'700' '0.996';  ...
'800' '0.997';  ...
'900' '0.997';  ...
'1000' '0.997';  ...
'1200' '0.998';  ...
'1400' '0.994';  ...
'1600' '0.995';  ...
'1800' '0.988';  ...
'2000' '0.976';  ...
'2200' '0.936';  ...
'2400' '0.84'});
model.material('mat2').propertyGroup('InternalTransmittance10').func('int1').set('extrap', 'none');
model.material('mat2').propertyGroup('InternalTransmittance10').func('int1').set('fununit', {'1'});
model.material('mat2').propertyGroup('InternalTransmittance10').func('int1').set('argunit', {'nm'});
model.material('mat2').propertyGroup('InternalTransmittance10').set('taui10', 'taui10(c_const/freq)');
model.material('mat2').propertyGroup('InternalTransmittance10').addInput('frequency');
model.material.create('mat3', 'Common', 'comp1');
model.material('mat3').propertyGroup.create('DispersionModelSellmeierStandard', 'Sellmeier');
model.material('mat3').propertyGroup.create('ThermoOpticDispersionModelSchott', 'Schott thermo-optic');
model.material('mat3').propertyGroup.create('Enu', 'Young''s modulus and Poisson''s ratio');
model.material('mat3').propertyGroup.create('InternalTransmittance10', ['Internal transmittance, 10' native2unicode(hex2dec({'00' 'a0'}), 'unicode') 'mm sample thickness']);
model.material('mat3').propertyGroup('InternalTransmittance10').func.create('int1', 'Interpolation');
model.material('mat3').propertyGroup.create('InternalTransmittance25', ['Internal transmittance, 25' native2unicode(hex2dec({'00' 'a0'}), 'unicode') 'mm sample thickness']);
model.material('mat3').propertyGroup('InternalTransmittance25').func.create('int1', 'Interpolation');
model.material('mat3').label('Schott N-SF5 Glass');
model.material('mat3').propertyGroup('def').set('density', '2.86[g/cm^3]');
model.material('mat3').propertyGroup('def').set('heatcapacity', '0.77[J/(g*K)]');
model.material('mat3').propertyGroup('def').set('thermalconductivity', {'1.0[W/(m*K)]' '0' '0' '0' '1.0[W/(m*K)]' '0' '0' '0' '1.0[W/(m*K)]'});
model.material('mat3').propertyGroup('def').set('thermalexpansioncoefficient', {'7.94E-6[1/K]' '0' '0' '0' '7.94E-6[1/K]' '0' '0' '0' '7.94E-6[1/K]'});
model.material('mat3').propertyGroup('DispersionModelSellmeierStandard').set('ODsma', {'1.52481889E+00' '1.87085527E-01' '1.42729015E+00' '1.12547560E-02' '5.88995392E-02' '1.29141675E+02'});
model.material('mat3').propertyGroup('DispersionModelSellmeierStandard').set('Trefsma', '22[degC]');
model.material('mat3').propertyGroup('DispersionModelSellmeierStandard').set('Prefsma', '1[atm]');
model.material('mat3').propertyGroup('DispersionModelSellmeierStandard').addInput('frequency');
model.material('mat3').propertyGroup('ThermoOpticDispersionModelSchott').set('TOsco', {'-2.51E-7' '1.07E-8' '-2.4E-11' '7.85E-7' '1.15E-9' '0.278'});
model.material('mat3').propertyGroup('ThermoOpticDispersionModelSchott').set('Trefsco', '20[degC]');
model.material('mat3').propertyGroup('Enu').set('E', '87.0[GPa]');
model.material('mat3').propertyGroup('Enu').set('nu', '0.237');
model.material('mat3').propertyGroup('InternalTransmittance10').func('int1').set('funcname', 'taui10');
model.material('mat3').propertyGroup('InternalTransmittance10').func('int1').set('table', {'2500' '0.758';  ...
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
model.material('mat3').propertyGroup('InternalTransmittance10').func('int1').set('extrap', 'none');
model.material('mat3').propertyGroup('InternalTransmittance10').func('int1').set('fununit', {'1'});
model.material('mat3').propertyGroup('InternalTransmittance10').func('int1').set('argunit', {'nm'});
model.material('mat3').propertyGroup('InternalTransmittance10').set('taui10', 'taui10(c_const/freq)');
model.material('mat3').propertyGroup('InternalTransmittance10').addInput('frequency');
model.material('mat3').propertyGroup('InternalTransmittance25').func('int1').set('funcname', 'taui25');
model.material('mat3').propertyGroup('InternalTransmittance25').func('int1').set('table', {'2500' '0.5';  ...
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
model.material('mat3').propertyGroup('InternalTransmittance25').func('int1').set('extrap', 'none');
model.material('mat3').propertyGroup('InternalTransmittance25').func('int1').set('fununit', {'1'});
model.material('mat3').propertyGroup('InternalTransmittance25').func('int1').set('argunit', {'nm'});
model.material('mat3').propertyGroup('InternalTransmittance25').set('taui25', 'taui25(c_const/freq)');
model.material('mat3').propertyGroup('InternalTransmittance25').addInput('frequency');
model.material('mat1').selection.named('geom1_csel1_dom');
model.material('mat2').selection.named('geom1_csel2_dom');
model.material('mat3').selection.named('geom1_csel3_dom');

model.physics('gop').prop('MaximumSecondary').setIndex('MaximumSecondary', 0, 0);
model.physics('gop').prop('ExteriorUnmeshedProperties').setIndex('DispersionModel', 'AirEdlen1953', 0);
model.physics('gop').prop('ComputeOpticalPathLength').setIndex('ComputeOpticalPathLength', 1, 0);
model.physics('gop').feature('mp1').set('RefractiveIndexDomains', 'GetDispersionModelFromMaterial');
model.physics('gop').feature('matd1').set('ReleaseReflectedRays', 'Never');
model.physics('gop').feature('op1').set('lambda0', 'lambda');
model.physics('gop').create('relg1', 'ReleaseGrid', -1);
model.physics('gop').feature('relg1').set('GridType', 'Hexapolar');
model.physics('gop').feature('relg1').set('qcc', {'dx' 'dy' 'dz'});
model.physics('gop').feature('relg1').set('rcc', {'nix' 'niy' 'niz'});
model.physics('gop').feature('relg1').set('Rc', 'P_nom/2');
model.physics('gop').feature('relg1').setIndex('Ncr', 'N_ring', 0);
model.physics('gop').feature('relg1').set('L0', {'vx' 'vy' 'vz'});
model.physics('gop').create('wall1', 'Wall', 2);
model.physics('gop').feature('wall1').label('Obstructions');
model.physics('gop').feature('wall1').selection.named('geom1_csel6_bnd');
model.physics('gop').feature('wall1').set('WallCondition', 'Disappear');
model.physics('gop').create('wall2', 'Wall', 2);
model.physics('gop').feature('wall2').label('Stop');
model.physics('gop').feature('wall2').selection.named('geom1_csel7_bnd');
model.physics('gop').feature('wall2').set('WallCondition', 'Disappear');
model.physics('gop').create('wall3', 'Wall', 2);
model.physics('gop').feature('wall3').label('Image');
model.physics('gop').feature('wall3').selection.named('geom1_csel8_bnd');

model.mesh('mesh1').run;

model.study('std1').feature('rtrac').set('timestepspec', 'specifylength');
model.study('std1').feature('rtrac').set('lunit', 'mm');
model.study('std1').feature('rtrac').set('llist', '0 200');

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
model.result.dataset.create('cpl1', 'CutPlane');
model.result('pg1').run;
model.result('pg1').label('Ray Diagram 1');
model.result('pg1').set('showlegendsunit', true);
model.result('pg1').set('legendpos', 'bottom');
model.result('pg1').run;
model.result('pg1').feature('rtrj1').feature('filt1').set('type', 'logical');
model.result('pg1').feature('rtrj1').feature('filt1').set('logicalexpr', 'at(0,abs(gop.deltaqx) < 0.1[mm])');
model.result('pg1').run;
model.result('pg1').create('surf1', 'Surface');
model.result('pg1').feature('surf1').set('data', 'cpl1');
model.result('pg1').feature('surf1').set('coloring', 'uniform');
model.result('pg1').feature('surf1').set('color', 'gray');
model.result('pg1').run;
model.result('pg1').create('line1', 'Line');
model.result('pg1').feature('line1').set('data', 'cpl1');
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
model.result('pg2').feature('rtrj1').feature('col1').set('colortable', 'Viridis');
model.result('pg2').run;
model.result('pg2').create('surf1', 'Surface');
model.result('pg2').feature('surf1').set('expr', 'gop.nrefd');
model.result('pg2').feature('surf1').set('descr', 'Refractive index, d-line');
model.result('pg2').feature('surf1').set('colortable', 'GrayScale');
model.result('pg2').feature('surf1').create('sel1', 'Selection');
model.result('pg2').feature('surf1').feature('sel1').selection.named('geom1_csel4_bnd');
model.result('pg2').run;
model.result('pg2').feature('surf1').create('tran1', 'Transparency');
model.result('pg2').run;
model.result('pg2').run;

model.view('view4').camera.set('projection', 'orthographic');

model.result.create('pg3', 'PlotGroup2D');
model.result('pg3').run;
model.result('pg3').label('Spot Diagram');
model.result('pg3').set('showlegendsunit', true);
model.result('pg3').set('legendpos', 'bottom');
model.result('pg3').create('spot1', 'SpotDiagram');
model.result('pg3').feature('spot1').set('spotcoordsactive', true);
model.result('pg3').feature('spot1').set('spotcoordssystem', 'global');
model.result('pg3').feature('spot1').set('spotcoordsprecision', 6);
model.result('pg3').feature('spot1').create('col1', 'Color');
model.result('pg3').run;
model.result('pg3').feature('spot1').feature('col1').set('expr', 'at(0,gop.rrel)');
model.result('pg3').feature('spot1').feature('col1').set('colortable', 'Viridis');
model.result('pg3').run;
model.result('pg3').feature.duplicate('spot2', 'spot1');
model.result('pg3').run;
model.result('pg3').feature('spot2').set('normal', 'userdefined');
model.result.dataset.create('ip1', 'IntersectionPoint3D');
model.result('pg3').feature('spot2').set('data', 'ip1');
model.result.dataset('ip1').set('data', 'ray1');
model.result.dataset('ip1').set('genmethod', 'pointnormal');
model.result.dataset('ip1').setIndex('genpnpoint', '2.733167193362546E-6[mm]', 0);
model.result.dataset('ip1').setIndex('genpnpoint', '-1.978177442781443E-6[mm]', 1);
model.result.dataset('ip1').setIndex('genpnpoint', '136.92789335630286[mm]', 2);
model.result.dataset('ip1').set('genpnvec', [0 0 1]);
model.result('pg3').feature('spot2').run;
model.result.dataset('ip1').set('genmethod', 'pointnormal');
model.result.dataset('ip1').setIndex('genpnpoint', '2.728834209628889E-6[mm]', 0);
model.result.dataset('ip1').setIndex('genpnpoint', '-1.9770080313078858E-6[mm]', 1);
model.result.dataset('ip1').setIndex('genpnpoint', '136.9278930914476[mm]', 2);
model.result.dataset('ip1').set('genpnvec', [0 0 1]);
model.result('pg3').set('ispendingzoom', true);
model.result('pg3').feature('spot2').run;
model.result('pg3').feature('spot2').set('posexpr', {'0.25' '0'});
model.result('pg3').feature('spot2').set('inheritplot', 'spot1');
model.result('pg3').run;
model.result.create('pg4', 'PlotGroup2D');
model.result('pg4').run;
model.result('pg4').label('Optical Aberration Diagram');
model.result('pg4').set('showlegendsmaxmin', true);
model.result('pg4').set('legendpos', 'bottom');
model.result('pg4').create('oab1', 'OpticalAberration');
model.result('pg4').feature('oab1').set('normal', 'userdefined');
model.result.dataset.create('ip2', 'IntersectionPoint3D');
model.result('pg4').feature('oab1').set('data', 'ip2');
model.result.dataset('ip2').set('data', 'ray1');
model.result.dataset('ip2').set('type', 'hemisphere');
model.result.dataset('ip2').setIndex('center', '2.733167193362546E-6[mm]', 0);
model.result.dataset('ip2').setIndex('axis', '-0.0', 0);
model.result.dataset('ip2').setIndex('center', '-1.978177442781443E-6[mm]', 1);
model.result.dataset('ip2').setIndex('axis', '-0.0', 1);
model.result.dataset('ip2').setIndex('center', '136.92789335630286[mm]', 2);
model.result.dataset('ip2').setIndex('axis', '-1.0', 2);
model.result.dataset('ip2').set('radius', '50[mm]');
model.result('pg4').feature('oab1').run;
model.result('pg4').feature('oab1').set('colortable', 'Dipole');
model.result('pg4').feature('oab1').set('colorscalemode', 'linearsymmetric');
model.result('pg4').feature.duplicate('oab2', 'oab1');
model.result('pg4').run;
model.result('pg4').feature('oab2').set('terms', 'selectindividual');
model.result('pg4').feature('oab2').set('z00', true);
model.result('pg4').feature('oab2').set('z1m1', true);
model.result('pg4').feature('oab2').set('z11', true);
model.result('pg4').feature('oab2').set('z2m2', true);
model.result('pg4').feature('oab2').set('z20', true);
model.result('pg4').feature('oab2').set('z22', true);
model.result('pg4').feature('oab2').set('z3m3', true);
model.result('pg4').feature('oab2').set('z3m1', true);
model.result('pg4').feature('oab2').set('z31', true);
model.result('pg4').feature('oab2').set('z33', true);
model.result('pg4').feature('oab2').set('z4m4', true);
model.result('pg4').feature('oab2').set('z4m2', true);
model.result('pg4').feature('oab2').set('z40', true);
model.result('pg4').feature('oab2').set('z42', true);
model.result('pg4').feature('oab2').set('z44', true);
model.result('pg4').feature('oab2').set('z5m5', true);
model.result('pg4').feature('oab2').set('z5m3', true);
model.result('pg4').feature('oab2').set('z5m1', true);
model.result('pg4').feature('oab2').set('z51', true);
model.result('pg4').feature('oab2').set('z53', true);
model.result('pg4').feature('oab2').set('z55', true);
model.result('pg4').feature('oab2').set('z00', false);
model.result('pg4').feature('oab2').set('z20', false);
model.result('pg4').feature('oab2').set('posexpr', {'2.5' '0'});
model.result('pg4').feature('oab2').set('inheritplot', 'oab1');
model.result('pg4').run;

model.title('Double Gauss Lens');

model.description(['This tutorial shows how to set up a multi-element objective lens. The chosen lens is the Double Gauss described in ''Modern Lens Design (2nd edition)'', by W. Smith, 2005, pg 323.' newline  newline 'The tutorial demonstrates how to create a geometry sequence using the ''Spherical Lens 3D'' and ''Circular Planar Annulus'' parts found in the Ray Optics Module Part Library.' newline  newline 'A ray trace is performed at a single wavelength and field angle. Ray Diagrams are shown together with a Spot Diagram, and an Optical Aberration Diagram.']);

model.mesh.clearMeshes;

model.sol('sol1').clearSolutionData;

model.label('double_gauss_lens.mph');

model.modelNode.label('Components');

out = model;
