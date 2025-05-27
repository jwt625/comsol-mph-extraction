function out = model
%
% piezoresistive_pressure_sensor_shell.m
%
% Model exported on May 26 2025, 21:30 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/MEMS_Module/Sensors');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 3);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.physics.create('shell', 'Shell', 'geom1');
model.physics('shell').model('comp1');
model.physics.create('ecis', 'ElectricCurrentsShell', 'geom1');
model.physics('ecis').model('comp1');
model.physics('ecis').prop('DefaultDescription').set('DefaultDescription', 'Electric_currents_in_shells');
model.physics('ecis').prop('LayerSelection').set('lth_mat', 'userdef');
model.physics('ecis').create('pzrs1', 'PiezoresistiveShell');
model.physics('ecis').feature('pzrs1').selection.all;

model.multiphysics.create('pzrs1', 'PiezoresistiveEffectShell', 'geom1', 2);
model.multiphysics('pzrs1').set('Solid_physics', 'shell');
model.multiphysics('pzrs1').set('ElectricCurrents_physics', 'ecis');
model.multiphysics('pzrs1').selection.all;

model.study.create('std1');
model.study('std1').create('stat', 'Stationary');
model.study('std1').feature('stat').setSolveFor('/physics/shell', true);
model.study('std1').feature('stat').setSolveFor('/physics/ecis', true);
model.study('std1').feature('stat').setSolveFor('/multiphysics/pzrs1', true);

model.geom('geom1').lengthUnit([native2unicode(hex2dec({'00' 'b5'}), 'unicode') 'm']);
model.geom('geom1').insertFile('piezoresistive_pressure_sensor_shell_geom_sequence.mph', 'geom1');
model.geom('geom1').run('difsel1');

model.selection.create('sel1', 'Explicit');
model.selection('sel1').model('comp1');
model.selection('sel1').label('Piezoresistor');
model.selection('sel1').geom(2);
model.selection('sel1').set([9]);
model.selection.duplicate('sel2', 'sel1');
model.selection('sel2').label('Connections');
model.selection('sel2').set([3 5 6 8 13 14 15 18]);
model.selection.create('box1', 'Box');
model.selection('box1').model('comp1');
model.selection('box1').label('Membrane');
model.selection('box1').set('entitydim', 2);
model.selection('box1').set('xmin', -501);
model.selection('box1').set('xmax', 501);
model.selection('box1').set('ymin', -30);
model.selection('box1').set('ymax', 1000);
model.selection('box1').set('condition', 'inside');
model.selection.create('uni1', 'Union');
model.selection('uni1').model('comp1');
model.selection('uni1').label('Model boundaries');
model.selection('uni1').set('entitydim', 2);
model.selection('uni1').set('input', {'sel2' 'box1'});
model.selection.duplicate('uni2', 'uni1');
model.selection('uni2').label('Electric currents');
model.selection('uni2').set('input', {'sel2' 'sel1'});
model.selection.create('adj1', 'Adjacent');
model.selection('adj1').model('comp1');
model.selection('adj1').label('Fixed Edges');
model.selection('adj1').set('entitydim', 2);
model.selection('adj1').set('input', {'box1'});
model.selection('adj1').set('outputdim', 1);
model.selection.create('dif1', 'Difference');
model.selection('dif1').model('comp1');
model.selection('dif1').set('entitydim', 2);
model.selection('dif1').set('add', {'uni1'});
model.selection('dif1').set('subtract', {'box1'});
model.selection('dif1').label('Fixed Boundaries');

model.coordSystem.create('sys2', 'geom1', 'Rotated');
model.coordSystem('sys2').set('angle', {'-45[deg]' '0' '0'});

model.material.create('mat1', 'Common', 'comp1');
model.material('mat1').propertyGroup('def').func.create('an1', 'Analytic');
model.material('mat1').propertyGroup.create('Anisotropic', 'Anisotropic');
model.material('mat1').propertyGroup.create('AnisotropicVoGrp', 'Anisotropic, Voigt notation');
model.material('mat1').propertyGroup.create('PiezoresistanceForm', 'Piezoresistance form');
model.material('mat1').propertyGroup('PiezoresistanceForm').func.create('an1', 'Analytic');
model.material('mat1').propertyGroup.create('ElastoresistanceForm', 'Elastoresistance form');
model.material('mat1').propertyGroup('ElastoresistanceForm').func.create('an1', 'Analytic');
model.material('mat1').label('n-Silicon (single-crystal, lightly doped)');
model.material('mat1').comments(['C. S. Smith, ' native2unicode(hex2dec({'20' '1c'}), 'unicode') 'Piezoresistance Effect in Silicon and Germanium' native2unicode(hex2dec({'20' '1d'}), 'unicode') ', Physical Review, vol. 94, no. 1, pp. 42-49, 1957.' newline  newline 'C. Jacoboni, C. Canali, G. Ottaviani and A. Alberigi Quaranta, ' native2unicode(hex2dec({'20' '1c'}), 'unicode') 'A Review of some Charge Transport Properties of Silicon' native2unicode(hex2dec({'20' '1d'}), 'unicode') ', Solid-State Electronics, vol. 20, pp. 77-89, 1977.']);
model.material('mat1').propertyGroup('def').func('an1').set('funcname', 'sigma0');
model.material('mat1').propertyGroup('def').func('an1').set('expr', '(N*e_const*0.1400/sqrt(1+N/(N/350 +3e22)))');
model.material('mat1').propertyGroup('def').func('an1').set('args', {'N'});
model.material('mat1').propertyGroup('def').func('an1').set('argunit', {''});
model.material('mat1').propertyGroup('def').func('an1').set('plotaxis', {'off'});
model.material('mat1').propertyGroup('def').func('an1').set('plotfixedvalue', {''});
model.material('mat1').propertyGroup('def').func('an1').set('plotargs', {'N' '' ''});
model.material('mat1').propertyGroup('def').set('density', '2330[kg/m^3]');
model.material('mat1').propertyGroup('def').set('relpermittivity', {'4.5' '0' '0' '0' '4.5' '0' '0' '0' '4.5'});
model.material('mat1').propertyGroup('def').set('electricconductivity', {'sigma0(nd[m^3])' '0' '0' '0' 'sigma0(nd[m^3])' '0' '0' '0' 'sigma0(nd[m^3])'});
model.material('mat1').propertyGroup('def').addInput('numberdensity');
model.material('mat1').propertyGroup('Anisotropic').set('D', {'166[GPa]' '64[GPa]' '64[GPa]' '0[GPa]' '0[GPa]' '0[GPa]' '64[GPa]' '166[GPa]' '64[GPa]' '0[GPa]'  ...
'0[GPa]' '0[GPa]' '64[GPa]' '64[GPa]' '166[GPa]' '0[GPa]' '0[GPa]' '0[GPa]' '0[GPa]' '0[GPa]'  ...
'0[GPa]' '80[GPa]' '0[GPa]' '0[GPa]' '0[GPa]' '0[GPa]' '0[GPa]' '0[GPa]' '80[GPa]' '0[GPa]'  ...
'0[GPa]' '0[GPa]' '0[GPa]' '0[GPa]' '0[GPa]' '80[GPa]'});
model.material('mat1').propertyGroup('AnisotropicVoGrp').set('DVo', {'166[GPa]' '64[GPa]' '64[GPa]' '0[GPa]' '0[GPa]' '0[GPa]' '64[GPa]' '166[GPa]' '64[GPa]' '0[GPa]'  ...
'0[GPa]' '0[GPa]' '64[GPa]' '64[GPa]' '166[GPa]' '0[GPa]' '0[GPa]' '0[GPa]' '0[GPa]' '0[GPa]'  ...
'0[GPa]' '80[GPa]' '0[GPa]' '0[GPa]' '0[GPa]' '0[GPa]' '0[GPa]' '0[GPa]' '80[GPa]' '0[GPa]'  ...
'0[GPa]' '0[GPa]' '0[GPa]' '0[GPa]' '0[GPa]' '80[GPa]'});
model.material('mat1').propertyGroup('PiezoresistanceForm').func('an1').set('funcname', 'sigma0');
model.material('mat1').propertyGroup('PiezoresistanceForm').func('an1').set('expr', '(N*e_const*0.1400/sqrt(1+N/(N/350 +3e22)))');
model.material('mat1').propertyGroup('PiezoresistanceForm').func('an1').set('args', {'N'});
model.material('mat1').propertyGroup('PiezoresistanceForm').func('an1').set('argunit', {''});
model.material('mat1').propertyGroup('PiezoresistanceForm').func('an1').set('plotaxis', {'off'});
model.material('mat1').propertyGroup('PiezoresistanceForm').func('an1').set('plotfixedvalue', {''});
model.material('mat1').propertyGroup('PiezoresistanceForm').func('an1').set('plotargs', {'N' '' ''});
model.material('mat1').propertyGroup('PiezoresistanceForm').set('Pil', {'-102.2e-11[1/Pa]/sigma0(nd[m^3])[S/m]' '53.4e-11[1/Pa]/sigma0(nd[m^3])[S/m]' '53.4e-11[1/Pa]/sigma0(nd[m^3])[S/m]' '0' '0' '0' '53.4e-11[1/Pa]/sigma0(nd[m^3])[S/m]' '-102.2e-11[1/Pa]/sigma0(nd[m^3])[S/m]' '53.4e-11[1/Pa]/sigma0(nd[m^3])[S/m]' '0'  ...
'0' '0' '53.4e-11[1/Pa]/sigma0(nd[m^3])[S/m]' '53.4e-11[1/Pa]/sigma0(nd[m^3])[S/m]' '-102.2e-11[1/Pa]/sigma0(nd[m^3])[S/m]' '0' '0' '0' '0' '0'  ...
'0' '-13.6e-11[1/Pa]/sigma0(nd[m^3])[S/m]' '0' '0' '0' '0' '0' '0' '-13.6e-11[1/Pa]/sigma0(nd[m^3])[S/m]' '0'  ...
'0' '0' '0' '0' '0' '-13.6e-11[1/Pa]/sigma0(nd[m^3])[S/m]'});
model.material('mat1').propertyGroup('PiezoresistanceForm').addInput('numberdensity');
model.material('mat1').propertyGroup('ElastoresistanceForm').func('an1').set('funcname', 'sigma0');
model.material('mat1').propertyGroup('ElastoresistanceForm').func('an1').set('expr', '(N*e_const*0.1400/sqrt(1+N/(N/350 +3e22)))');
model.material('mat1').propertyGroup('ElastoresistanceForm').func('an1').set('args', {'N'});
model.material('mat1').propertyGroup('ElastoresistanceForm').func('an1').set('argunit', {''});
model.material('mat1').propertyGroup('ElastoresistanceForm').func('an1').set('plotaxis', {'off'});
model.material('mat1').propertyGroup('ElastoresistanceForm').func('an1').set('plotfixedvalue', {''});
model.material('mat1').propertyGroup('ElastoresistanceForm').func('an1').set('plotargs', {'N' '' ''});
model.material('mat1').propertyGroup('ElastoresistanceForm').set('ml', {'-101.4/sigma0(nd[m^3])[S/m]' '57.6/sigma0(nd[m^3])[S/m]' '57.6/sigma0(nd[m^3])[S/m]' '0' '0' '0' '57.6/sigma0(nd[m^3])[S/m]' '-101.4/sigma0(nd[m^3])[S/m]' '57.6/sigma0(nd[m^3])[S/m]' '0'  ...
'0' '0' '57.6/sigma0(nd[m^3])[S/m]' '57.6/sigma0(nd[m^3])[S/m]' '-101.4/sigma0(nd[m^3])[S/m]' '0' '0' '0' '0' '0'  ...
'0' '-10.8/sigma0(nd[m^3])[S/m]' '0' '0' '0' '0' '0' '0' '-10.8/sigma0(nd[m^3])[S/m]' '0'  ...
'0' '0' '0' '0' '0' '-10.8/sigma0(nd[m^3])[S/m]'});
model.material('mat1').propertyGroup('ElastoresistanceForm').addInput('numberdensity');
model.material.create('mat2', 'Common', 'comp1');
model.material('mat2').propertyGroup('def').func.create('an1', 'Analytic');
model.material('mat2').propertyGroup.create('Anisotropic', 'Anisotropic');
model.material('mat2').propertyGroup.create('AnisotropicVoGrp', 'Anisotropic, Voigt notation');
model.material('mat2').propertyGroup.create('PiezoresistanceForm', 'Piezoresistance form');
model.material('mat2').propertyGroup('PiezoresistanceForm').func.create('an1', 'Analytic');
model.material('mat2').propertyGroup.create('ElastoresistanceForm', 'Elastoresistance form');
model.material('mat2').propertyGroup('ElastoresistanceForm').func.create('an1', 'Analytic');
model.material('mat2').label('p-Silicon (single-crystal, lightly doped)');
model.material('mat2').comments(['C. S. Smith, ' native2unicode(hex2dec({'20' '1c'}), 'unicode') 'Piezoresistance Effect in Silicon and Germanium' native2unicode(hex2dec({'20' '1d'}), 'unicode') ', Physical Review, vol. 94, no. 1, pp. 42-49, 1957.' newline  newline 'C. Jacoboni, C. Canali, G. Ottaviani and A. Alberigi Quaranta, ' native2unicode(hex2dec({'20' '1c'}), 'unicode') 'A Review of some Charge Transport Properties of Silicon' native2unicode(hex2dec({'20' '1d'}), 'unicode') ', Solid-State Electronics, vol. 20, pp. 77-89, 1977.']);
model.material('mat2').propertyGroup('def').func('an1').set('funcname', 'sigma0');
model.material('mat2').propertyGroup('def').func('an1').set('expr', '(N*e_const*0.048/sqrt(1+N/(N/81 +4e22)))');
model.material('mat2').propertyGroup('def').func('an1').set('args', {'N'});
model.material('mat2').propertyGroup('def').func('an1').set('argunit', {''});
model.material('mat2').propertyGroup('def').func('an1').set('plotaxis', {'off'});
model.material('mat2').propertyGroup('def').func('an1').set('plotfixedvalue', {''});
model.material('mat2').propertyGroup('def').func('an1').set('plotargs', {'N' '' ''});
model.material('mat2').propertyGroup('def').set('density', '2330[kg/m^3]');
model.material('mat2').propertyGroup('def').set('relpermittivity', {'4.5' '0' '0' '0' '4.5' '0' '0' '0' '4.5'});
model.material('mat2').propertyGroup('def').set('electricconductivity', {'sigma0(nd[m^3])' '0' '0' '0' 'sigma0(nd[m^3])' '0' '0' '0' 'sigma0(nd[m^3])'});
model.material('mat2').propertyGroup('def').addInput('numberdensity');
model.material('mat2').propertyGroup('Anisotropic').set('D', {'166[GPa]' '64[GPa]' '64[GPa]' '0[GPa]' '0[GPa]' '0[GPa]' '64[GPa]' '166[GPa]' '64[GPa]' '0[GPa]'  ...
'0[GPa]' '0[GPa]' '64[GPa]' '64[GPa]' '166[GPa]' '0[GPa]' '0[GPa]' '0[GPa]' '0[GPa]' '0[GPa]'  ...
'0[GPa]' '80[GPa]' '0[GPa]' '0[GPa]' '0[GPa]' '0[GPa]' '0[GPa]' '0[GPa]' '80[GPa]' '0[GPa]'  ...
'0[GPa]' '0[GPa]' '0[GPa]' '0[GPa]' '0[GPa]' '80[GPa]'});
model.material('mat2').propertyGroup('AnisotropicVoGrp').set('DVo', {'166[GPa]' '64[GPa]' '64[GPa]' '0[GPa]' '0[GPa]' '0[GPa]' '64[GPa]' '166[GPa]' '64[GPa]' '0[GPa]'  ...
'0[GPa]' '0[GPa]' '64[GPa]' '64[GPa]' '166[GPa]' '0[GPa]' '0[GPa]' '0[GPa]' '0[GPa]' '0[GPa]'  ...
'0[GPa]' '80[GPa]' '0[GPa]' '0[GPa]' '0[GPa]' '0[GPa]' '0[GPa]' '0[GPa]' '80[GPa]' '0[GPa]'  ...
'0[GPa]' '0[GPa]' '0[GPa]' '0[GPa]' '0[GPa]' '80[GPa]'});
model.material('mat2').propertyGroup('PiezoresistanceForm').func('an1').set('funcname', 'sigma0');
model.material('mat2').propertyGroup('PiezoresistanceForm').func('an1').set('expr', '(N*e_const*0.048/sqrt(1+N/(N/81 +4e22)))');
model.material('mat2').propertyGroup('PiezoresistanceForm').func('an1').set('args', {'N'});
model.material('mat2').propertyGroup('PiezoresistanceForm').func('an1').set('argunit', {''});
model.material('mat2').propertyGroup('PiezoresistanceForm').func('an1').set('plotaxis', {'off'});
model.material('mat2').propertyGroup('PiezoresistanceForm').func('an1').set('plotfixedvalue', {''});
model.material('mat2').propertyGroup('PiezoresistanceForm').func('an1').set('plotargs', {'N' '' ''});
model.material('mat2').propertyGroup('PiezoresistanceForm').set('Pil', {'6.6e-11[1/Pa]/sigma0(nd[m^3])[S/m]' '-1.1e-11[1/Pa]/sigma0(nd[m^3])[S/m]' '-1.1e-11[1/Pa]/sigma0(nd[m^3])[S/m]' '0' '0' '0' '-1.1e-11[1/Pa]/sigma0(nd[m^3])[S/m]' '6.6e-11[1/Pa]/sigma0(nd[m^3])[S/m]' '-1.1e-11[1/Pa]/sigma0(nd[m^3])[S/m]' '0'  ...
'0' '0' '-1.1e-11[1/Pa]/sigma0(nd[m^3])[S/m]' '-1.1e-11[1/Pa]/sigma0(nd[m^3])[S/m]' '6.6e-11[1/Pa]/sigma0(nd[m^3])[S/m]' '0' '0' '0' '0' '0'  ...
'0' '138.1e-11[1/Pa]/sigma0(nd[m^3])[S/m]' '0' '0' '0' '0' '0' '0' '138.1e-11[1/Pa]/sigma0(nd[m^3])[S/m]' '0'  ...
'0' '0' '0' '0' '0' '138.1e-11[1/Pa]/sigma0(nd[m^3])[S/m]'});
model.material('mat2').propertyGroup('PiezoresistanceForm').addInput('numberdensity');
model.material('mat2').propertyGroup('ElastoresistanceForm').func('an1').set('funcname', 'sigma0');
model.material('mat2').propertyGroup('ElastoresistanceForm').func('an1').set('expr', '(N*e_const*0.048/sqrt(1+N/(N/81 +4e22)))');
model.material('mat2').propertyGroup('ElastoresistanceForm').func('an1').set('args', {'N'});
model.material('mat2').propertyGroup('ElastoresistanceForm').func('an1').set('argunit', {''});
model.material('mat2').propertyGroup('ElastoresistanceForm').func('an1').set('plotaxis', {'off'});
model.material('mat2').propertyGroup('ElastoresistanceForm').func('an1').set('plotfixedvalue', {''});
model.material('mat2').propertyGroup('ElastoresistanceForm').func('an1').set('plotargs', {'N' '' ''});
model.material('mat2').propertyGroup('ElastoresistanceForm').set('ml', {'9.6/sigma0(nd[m^3])[S/m]' '1.8/sigma0(nd[m^3])[S/m]' '1.8/sigma0(nd[m^3])[S/m]' '0' '0' '0' '1.8/sigma0(nd[m^3])[S/m]' '9.6/sigma0(nd[m^3])[S/m]' '1.8/sigma0(nd[m^3])[S/m]' '0'  ...
'0' '0' '1.8/sigma0(nd[m^3])[S/m]' '1.8/sigma0(nd[m^3])[S/m]' '9.6/sigma0(nd[m^3])[S/m]' '0' '0' '0' '0' '0'  ...
'0' '110.0/sigma0(nd[m^3])[S/m]' '0' '0' '0' '0' '0' '0' '110.0/sigma0(nd[m^3])[S/m]' '0'  ...
'0' '0' '0' '0' '0' '110.0/sigma0(nd[m^3])[S/m]'});
model.material('mat2').propertyGroup('ElastoresistanceForm').addInput('numberdensity');
model.material('mat2').selection.named('uni2');

model.physics('shell').selection.named('uni1');
model.physics('shell').feature('to1').set('d', '20[um]');
model.physics('shell').feature('emm1').set('SolidModel', 'Anisotropic');
model.physics('shell').feature('emm1').set('AnisotropicOption', 'AnisotropicVo');
model.physics('shell').feature('emm1').feature('shls1').set('coordinateSystem', 'sys2');
model.physics('shell').create('fix1', 'Fixed', 1);
model.physics('shell').feature('fix1').selection.named('adj1');
model.physics('shell').create('fix2', 'Fixed', 2);
model.physics('shell').feature('fix2').selection.named('dif1');
model.physics('shell').create('fl1', 'FaceLoad', 2);
model.physics('shell').feature('fl1').selection.named('box1');
model.physics('shell').feature('fl1').set('LoadTypeForce', 'FollowerLoad');
model.physics('shell').feature('fl1').set('FollowerPressure', '100[kPa]');
model.physics('ecis').selection.set([]);
model.physics('ecis').selection.named('uni2');
model.physics('ecis').prop('LayerSelection').set('lth', '0.4[um]');
model.physics('ecis').feature('csh1').set('minput_numberdensity', '1.45e20[1/cm^3]');
model.physics('ecis').feature('csh1').set('coordinateSystem', 'sys2');
model.physics('ecis').feature('pzrs1').selection.named('sel1');
model.physics('ecis').feature('pzrs1').set('minput_numberdensity', '1.32e19[1/cm^3]');
model.physics('ecis').feature('pzrs1').set('coordinateSystem', 'sys2');
model.physics('ecis').create('bgnd1', 'BoundaryGround', 1);
model.physics('ecis').feature('bgnd1').selection.set([70]);
model.physics('ecis').create('bterm1', 'BoundaryTerminal', 1);
model.physics('ecis').feature('bterm1').selection.set([11 13]);
model.physics('ecis').feature('bterm1').set('TerminalType', 'Voltage');
model.physics('ecis').feature('bterm1').set('V0', 3);
model.physics('ecis').create('bterm2', 'BoundaryTerminal', 1);
model.physics('ecis').feature('bterm2').selection.set([7]);
model.physics('ecis').create('bterm3', 'BoundaryTerminal', 1);
model.physics('ecis').feature('bterm3').selection.set([72 73]);

model.mesh('mesh1').automatic(false);
model.mesh('mesh1').feature('size').set('custom', true);
model.mesh('mesh1').feature('size').set('hmax', 60);
model.mesh('mesh1').feature('size').set('hmin', 0.5);
model.mesh('mesh1').feature.duplicate('size1', 'size');
model.mesh('mesh1').feature('size1').selection.geom('geom1', 2);
model.mesh('mesh1').feature('size1').selection.named('sel1');
model.mesh('mesh1').feature('size1').set('hmax', 2);
model.mesh('mesh1').feature('size1').set('hmin', 0.1);
model.mesh('mesh1').feature.duplicate('size2', 'size1');
model.mesh('mesh1').feature('size2').selection.named('sel2');
model.mesh('mesh1').feature('size2').set('hmax', 6);
model.mesh('mesh1').feature.duplicate('size3', 'size2');
model.mesh('mesh1').feature('size3').selection.geom('geom1', 1);
model.mesh('mesh1').feature('size3').selection.set([27 29 38 39 40 41 42 43 44 51 52 53]);
model.mesh('mesh1').feature('size3').set('hmax', 0.4);
model.mesh('mesh1').feature.move('ftri1', 2);
model.mesh('mesh1').feature.move('ftri1', 3);
model.mesh('mesh1').feature.move('ftri1', 4);

model.sol.create('sol1');
model.sol('sol1').study('std1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'stat');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').feature('comp1_ar').set('scalemethod', 'manual');
model.sol('sol1').feature('v1').feature('comp1_ar').set('resscalemethod', 'parent');
model.sol('sol1').feature('v1').feature('comp1_ar').set('scaleval', '0.01');
model.sol('sol1').feature('v1').set('control', 'stat');
model.sol('sol1').create('s1', 'Stationary');
model.sol('sol1').feature('s1').feature('aDef').set('cachepattern', true);
model.sol('sol1').feature('s1').create('seDef', 'Segregated');
model.sol('sol1').feature('s1').create('se1', 'Segregated');
model.sol('sol1').feature('s1').feature('se1').feature.remove('ssDef');
model.sol('sol1').feature('s1').feature('se1').create('ss1', 'SegregatedStep');
model.sol('sol1').feature('s1').feature('se1').feature('ss1').set('segvar', {'comp1_u' 'comp1_ar'});
model.sol('sol1').feature('s1').feature('se1').feature('ss1').set('subdtech', 'auto');
model.sol('sol1').feature('s1').feature('se1').feature('ss1').set('subminstep', 0.5);
model.sol('sol1').feature('s1').feature('se1').feature('ss1').set('usesubminsteprecovery', 'on');
model.sol('sol1').feature('s1').feature('se1').feature('ss1').set('subtermauto', 'tol');
model.sol('sol1').feature('s1').feature('se1').feature('ss1').set('maxsubiter', 50);
model.sol('sol1').feature('s1').feature('se1').feature('ss1').set('subntolfact', 1);
model.sol('sol1').feature('s1').feature('se1').feature('ss1').set('linsolver', 'dDef');
model.sol('sol1').feature('s1').feature('se1').feature('ss1').label('Displacement Field');
model.sol('sol1').feature('s1').feature('se1').create('ss2', 'SegregatedStep');
model.sol('sol1').feature('s1').feature('se1').feature('ss2').set('segvar', {'comp1_ecis_Vc' 'comp1_ecis_bterm2_V0_ode' 'comp1_ecis_bterm3_V0_ode'});
model.sol('sol1').feature('s1').feature('se1').feature('ss2').set('subdtech', 'auto');
model.sol('sol1').feature('s1').feature('se1').feature('ss2').set('subminstep', 0.5);
model.sol('sol1').feature('s1').feature('se1').feature('ss2').set('usesubminsteprecovery', 'on');
model.sol('sol1').feature('s1').feature('se1').feature('ss2').set('subtermauto', 'tol');
model.sol('sol1').feature('s1').feature('se1').feature('ss2').set('maxsubiter', 50);
model.sol('sol1').feature('s1').feature('se1').feature('ss2').set('subntolfact', 1);
model.sol('sol1').feature('s1').feature('se1').feature('ss2').set('linsolver', 'dDef');
model.sol('sol1').feature('s1').feature('se1').feature('ss2').label('Electric Potential');
model.sol('sol1').feature('s1').feature('se1').set('segterm', 'iter');
model.sol('sol1').feature('s1').feature('se1').set('segiter', 1);
model.sol('sol1').feature('s1').feature.remove('fcDef');
model.sol('sol1').feature('s1').feature.remove('seDef');
model.sol('sol1').attach('std1');
model.sol('sol1').runAll;

model.result.dataset.create('dset1shellshl', 'Shell');
model.result.dataset('dset1shellshl').set('data', 'dset1');
model.result.dataset('dset1shellshl').setIndex('topconst', '1', 3, 1);
model.result.dataset('dset1shellshl').setIndex('bottomconst', '-1', 3, 1);
model.result.dataset('dset1shellshl').setIndex('orientationexpr', 'shell.nlX', 0);
model.result.dataset('dset1shellshl').setIndex('displacementexpr', 'arx', 0);
model.result.dataset('dset1shellshl').setIndex('orientationexpr', 'shell.nlY', 1);
model.result.dataset('dset1shellshl').setIndex('displacementexpr', 'ary', 1);
model.result.dataset('dset1shellshl').setIndex('orientationexpr', 'shell.nlZ', 2);
model.result.dataset('dset1shellshl').setIndex('displacementexpr', 'arz', 2);
model.result.dataset('dset1shellshl').set('distanceexpr', 'shell.z_pos');
model.result.dataset('dset1shellshl').set('seplevels', false);
model.result.dataset('dset1shellshl').set('resolution', 2);
model.result.dataset('dset1shellshl').set('areascalefactor', 'shell.ASF');
model.result.dataset('dset1shellshl').set('linescalefactor', 'shell.LSF');
model.result.create('pg1', 'PlotGroup3D');
model.result('pg1').set('data', 'dset1shellshl');
model.result('pg1').set('defaultPlotID', 'stress');
model.result('pg1').label('Stress (shell)');
model.result('pg1').set('showlegends', true);
model.result('pg1').set('frametype', 'spatial');
model.result('pg1').create('surf1', 'Surface');
model.result('pg1').feature('surf1').set('expr', {'shell.misesGp'});
model.result('pg1').feature('surf1').set('threshold', 'manual');
model.result('pg1').feature('surf1').set('thresholdvalue', 0.2);
model.result('pg1').feature('surf1').set('colortable', 'Rainbow');
model.result('pg1').feature('surf1').set('colortabletrans', 'none');
model.result('pg1').feature('surf1').set('colorscalemode', 'linear');
model.result('pg1').feature('surf1').set('descr', 'von Mises stress');
model.result('pg1').feature('surf1').set('colortable', 'Prism');
model.result('pg1').feature('surf1').create('def', 'Deform');
model.result('pg1').feature('surf1').feature('def').set('expr', {'shell.u' 'shell.v' 'shell.w'});
model.result.create('pg2', 'PlotGroup3D');
model.result('pg2').label('Electric Potential (ecis)');
model.result('pg2').set('frametype', 'spatial');
model.result('pg2').set('showlegendsmaxmin', true);
model.result('pg2').set('data', 'dset1');
model.result('pg2').set('defaultPlotID', 'InterfaceComponents/PlotDefaults/icom2/pdef1/pcond4/pcond1/pcond2/pg1');
model.result('pg2').feature.create('surf1', 'Surface');
model.result('pg2').feature('surf1').set('showsolutionparams', 'on');
model.result('pg2').feature('surf1').set('solutionparams', 'parent');
model.result('pg2').feature('surf1').set('expr', 'V');
model.result('pg2').feature('surf1').set('colortable', 'Dipole');
model.result('pg2').feature('surf1').set('showsolutionparams', 'on');
model.result('pg2').feature('surf1').set('data', 'parent');
model.result('pg2').feature('surf1').feature.create('def1', 'Deform');
model.result('pg2').feature('surf1').feature('def1').set('expr', {'0.5*ecis.ds*ecis.nX' '0.5*ecis.ds*ecis.nY' '0.5*ecis.ds*ecis.nZ'});
model.result('pg2').feature('surf1').feature('def1').set('scaleactive', true);
model.result('pg2').feature.create('surf2', 'Surface');
model.result('pg2').feature('surf2').set('showsolutionparams', 'on');
model.result('pg2').feature('surf2').set('solutionparams', 'parent');
model.result('pg2').feature('surf2').set('expr', 'V');
model.result('pg2').feature('surf2').set('titletype', 'none');
model.result('pg2').feature('surf2').set('showsolutionparams', 'on');
model.result('pg2').feature('surf2').set('data', 'parent');
model.result('pg2').feature('surf2').set('inheritplot', 'surf1');
model.result('pg2').feature('surf2').feature.create('def1', 'Deform');
model.result('pg2').feature('surf2').feature('def1').set('expr', {'-0.5*ecis.ds*ecis.nX' '-0.5*ecis.ds*ecis.nY' '-0.5*ecis.ds*ecis.nZ'});
model.result('pg1').run;
model.result.dataset.duplicate('dset2', 'dset1');
model.result.dataset('dset2').selection.geom('geom1', 2);
model.result.dataset('dset2').selection.named('box1');
model.result.create('pg3', 'PlotGroup3D');
model.result('pg3').run;
model.result('pg3').label('Displacement');
model.result('pg3').set('data', 'dset2');
model.result('pg3').create('surf1', 'Surface');
model.result('pg3').feature('surf1').set('expr', 'shell.disp');
model.result('pg3').feature('surf1').set('descr', 'Displacement magnitude');
model.result('pg3').feature('surf1').create('def1', 'Deform');
model.result('pg3').run;
model.result('pg3').run;
model.result.create('pg4', 'PlotGroup3D');
model.result('pg4').run;
model.result('pg4').label('In-Plane Shear Stress (Local Coordinates)');
model.result('pg4').set('data', 'dset2');
model.result('pg4').create('surf1', 'Surface');
model.result('pg4').feature('surf1').set('expr', 'shell.SlGp12');
model.result('pg4').feature('surf1').set('descr', ['Second Piola' native2unicode(hex2dec({'20' '13'}), 'unicode') 'Kirchhoff stress, local coordinate system, 12-component']);
model.result('pg4').run;
model.result('pg4').create('mms1', 'MaxMinSurface');
model.result('pg4').feature('mms1').set('expr', 'shell.SlGp12');
model.result('pg4').feature('mms1').set('descr', ['Second Piola' native2unicode(hex2dec({'20' '13'}), 'unicode') 'Kirchhoff stress, local coordinate system, 12-component']);
model.result('pg4').run;
model.result.create('pg5', 'PlotGroup1D');
model.result('pg5').run;
model.result('pg5').label('In-Plane Shear Stress (Local Coordinate System)');
model.result('pg5').create('lngr1', 'LineGraph');
model.result('pg5').feature('lngr1').set('markerpos', 'datapoints');
model.result('pg5').feature('lngr1').set('linewidth', 'preference');
model.result('pg5').feature('lngr1').selection.set([6 76]);
model.result('pg5').feature('lngr1').set('expr', 'shell.SlGp12');
model.result('pg5').feature('lngr1').set('descr', ['Second Piola' native2unicode(hex2dec({'20' '13'}), 'unicode') 'Kirchhoff stress, local coordinate system, 12-component']);
model.result('pg5').run;
model.result.dataset.duplicate('dset3', 'dset2');
model.result.dataset('dset3').selection.named('sel1');
model.result.dataset('dset3').selection.named('uni2');
model.result.create('pg6', 'PlotGroup3D');
model.result('pg6').run;
model.result('pg6').label('Current and Voltage');
model.result('pg6').set('data', 'dset3');
model.result('pg6').create('con1', 'Contour');
model.result('pg6').feature('con1').set('expr', 'V');
model.result('pg6').feature('con1').set('number', 40);
model.result('pg6').feature('con1').set('colortable', 'ThermalDark');
model.result('pg6').feature('con1').set('colortabletrans', 'reverse');
model.result('pg6').run;
model.result('pg6').create('arws1', 'ArrowSurface');
model.result('pg6').feature('arws1').set('expr', {'ecis.JsX' 'ecis.JsY' 'ecis.JsZ'});
model.result('pg6').feature('arws1').set('descr', 'Surface current density (material and geometry frames)');
model.result('pg6').feature('arws1').set('descractive', true);
model.result('pg6').feature('arws1').set('descr', 'Surface current density');
model.result('pg6').feature('arws1').set('scaleactive', true);
model.result('pg6').feature('arws1').set('scale', 0.005);
model.result('pg6').feature('arws1').set('arrowcount', 3000);
model.result('pg6').feature('arws1').set('color', 'blue');
model.result('pg6').run;
model.result.numerical.create('gev1', 'EvalGlobal');
model.result.numerical('gev1').set('expr', {'ecis.I0_1'});
model.result.numerical('gev1').set('descr', {'Terminal current'});
model.result.numerical('gev1').set('unit', {'A'});
model.result.numerical('gev1').set('expr', {'ecis.I0_1' 'ecis.V0_2'});
model.result.numerical('gev1').set('descr', {'Terminal current' 'Terminal voltage'});
model.result.numerical('gev1').setIndex('unit', 'mA', 0);
model.result.numerical('gev1').setIndex('expr', 'ecis.V0_2-ecis.V0_3', 1);
model.result.numerical('gev1').setIndex('unit', 'mV', 1);
model.result.numerical('gev1').setIndex('descr', 'Device Output', 1);
model.result.table.create('tbl1', 'Table');
model.result.table('tbl1').comments('Global Evaluation 1');
model.result.numerical('gev1').set('table', 'tbl1');
model.result.numerical('gev1').setResult;
model.result('pg6').run;

model.title('Piezoresistive Pressure Sensor, Shell');

model.description(['A piezoresistive pressure sensor is simulated. This model shows how to set compute the stress induced potential difference produced by a four terminal piezoresistor when the membrane in which it is embedded is deformed by an applied pressure. The Piezoresistivity, Shell interface is used. The model is based on an analysis of an early MEMS pressure sensor: the Motorola MAP sensor (S.D. Senturia, Microsystem Design, Springer, 2000).' newline  newline 'The model requires the MEMS Module and the Structural Mechanics Module.']);

model.mesh.clearMeshes;

model.sol('sol1').clearSolutionData;

model.label('piezoresistive_pressure_sensor_shell.mph');

model.modelNode.label('Components');

out = model;
