function out = model
%
% piezoresistive_pressure_sensor.m
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

model.physics.create('solid', 'SolidMechanics', 'geom1');
model.physics('solid').model('comp1');
model.physics.create('ecis', 'ElectricCurrentsShell', 'geom1');
model.physics('ecis').model('comp1');
model.physics('ecis').prop('DefaultDescription').set('DefaultDescription', 'Electric_currents_in_shells');
model.physics('ecis').prop('LayerSelection').set('lth_mat', 'userdef');
model.physics('ecis').create('pzrs1', 'PiezoresistiveShell');
model.physics('ecis').feature('pzrs1').selection.all;

model.multiphysics.create('pzrb1', 'PiezoresistiveEffectBoundary', 'geom1', 2);
model.multiphysics('pzrb1').set('Solid_physics', 'solid');
model.multiphysics('pzrb1').set('ElectricCurrents_physics', 'ecis');
model.multiphysics('pzrb1').selection.all;

model.study.create('std1');
model.study('std1').create('stat', 'Stationary');
model.study('std1').feature('stat').setSolveFor('/physics/solid', true);
model.study('std1').feature('stat').setSolveFor('/physics/ecis', true);
model.study('std1').feature('stat').setSolveFor('/multiphysics/pzrb1', true);

model.geom('geom1').lengthUnit([native2unicode(hex2dec({'00' 'b5'}), 'unicode') 'm']);
model.geom('geom1').insertFile('piezoresistive_pressure_sensor_geom_sequence.mph', 'geom1');
model.geom('geom1').run('unisel1');

model.selection.create('sel1', 'Explicit');
model.selection('sel1').model('comp1');
model.selection('sel1').label('Piezoresistor');
model.selection('sel1').geom(2);
model.selection('sel1').set([46]);
model.selection.create('sel2', 'Explicit');
model.selection('sel2').model('comp1');
model.selection('sel2').label('Connections');
model.selection('sel2').geom(2);
model.selection('sel2').set([14 22 26 39 46 73 77 81 104]);
model.selection.create('box1', 'Box');
model.selection('box1').model('comp1');
model.selection('box1').label('Membrane (Lower Surface)');
model.selection('box1').set('entitydim', 2);
model.selection('box1').set('xmin', -501);
model.selection('box1').set('xmax', 501);
model.selection('box1').set('ymin', -30);
model.selection('box1').set('ymax', 1000);
model.selection('box1').set('zmax', -1);
model.selection('box1').set('condition', 'inside');
model.selection.duplicate('box2', 'box1');
model.selection('box2').label('Membrane (Upper Surface)');
model.selection('box2').set('zmin', -1);
model.selection('box2').set('zmax', 'inf');
model.selection.create('box3', 'Box');
model.selection('box3').model('comp1');
model.selection('box3').label('Lower Surface');
model.selection('box3').set('entitydim', 2);
model.selection('box3').set('zmax', -1);
model.selection('box3').set('condition', 'inside');
model.selection.duplicate('box4', 'box3');
model.selection('box4').label('Upper Surface');
model.selection('box4').set('zmin', -1);
model.selection('box4').set('zmax', 'inf');
model.selection.create('dif1', 'Difference');
model.selection('dif1').model('comp1');
model.selection('dif1').label('Fixed');
model.selection('dif1').set('entitydim', 2);
model.selection('dif1').set('add', {'box3'});
model.selection('dif1').set('subtract', {'box1'});
model.selection.create('uni1', 'Union');
model.selection('uni1').model('comp1');
model.selection('uni1').label('Electric Currents');
model.selection('uni1').set('entitydim', 2);
model.selection('uni1').set('input', {'sel1' 'sel2'});

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
model.material('mat2').selection.geom('geom1', 2);
model.material('mat2').selection.named('uni1');

model.physics('solid').feature('lemm1').set('coordinateSystem', 'sys2');
model.physics('solid').feature('lemm1').set('SolidModel', 'Anisotropic');
model.physics('solid').feature('lemm1').set('AnisotropicOption', 'AnisotropicVo');
model.physics('solid').create('fix1', 'Fixed', 2);
model.physics('solid').feature('fix1').selection.named('dif1');
model.physics('solid').create('bndl1', 'BoundaryLoad', 2);
model.physics('solid').feature('bndl1').selection.named('box2');
model.physics('solid').feature('bndl1').set('LoadType', 'FollowerPressure');
model.physics('solid').feature('bndl1').set('FollowerPressure', '100[kPa]');
model.physics('ecis').selection.named('uni1');
model.physics('ecis').prop('LayerSelection').set('lth', '400[nm]');
model.physics('ecis').feature('csh1').set('minput_numberdensity', '1.45e20[1/cm^3]');
model.physics('ecis').feature('csh1').set('coordinateSystem', 'sys2');
model.physics('ecis').feature('pzrs1').selection.named('sel1');
model.physics('ecis').feature('pzrs1').set('minput_numberdensity', '1.32e19[1/cm^3]');
model.physics('ecis').feature('pzrs1').set('coordinateSystem', 'sys2');
model.physics('ecis').create('bgnd1', 'BoundaryGround', 1);
model.physics('ecis').feature('bgnd1').selection.set([195]);
model.physics('ecis').create('bterm1', 'BoundaryTerminal', 1);
model.physics('ecis').feature('bterm1').selection.set([30 35]);
model.physics('ecis').feature('bterm1').set('TerminalType', 'Voltage');
model.physics('ecis').feature('bterm1').set('V0', 3);
model.physics('ecis').create('bterm2', 'BoundaryTerminal', 1);
model.physics('ecis').feature('bterm2').selection.set([20]);
model.physics('ecis').create('bterm3', 'BoundaryTerminal', 1);
model.physics('ecis').feature('bterm3').selection.set([201 205]);

model.mesh('mesh1').automatic(false);
model.mesh('mesh1').feature('size').set('custom', true);
model.mesh('mesh1').feature('size').set('hmax', 60);
model.mesh('mesh1').feature('size').set('hmin', 0.5);
model.mesh('mesh1').create('size1', 'Size');
model.mesh('mesh1').feature('size1').selection.geom('geom1', 2);
model.mesh('mesh1').feature('size1').selection.named('sel1');
model.mesh('mesh1').feature('size1').set('custom', true);
model.mesh('mesh1').feature('size1').set('hmaxactive', true);
model.mesh('mesh1').feature('size1').set('hmax', 2);
model.mesh('mesh1').feature('size1').set('hminactive', true);
model.mesh('mesh1').feature('size1').set('hmin', 0.1);
model.mesh('mesh1').feature.duplicate('size2', 'size1');
model.mesh('mesh1').feature('size2').selection.named('sel2');
model.mesh('mesh1').feature('size2').set('hmax', 6);
model.mesh('mesh1').feature.duplicate('size3', 'size2');
model.mesh('mesh1').feature('size3').selection.geom('geom1', 1);
model.mesh('mesh1').feature('size3').selection.set([74 79 104 108 111 114 117 120 123 142 143 146]);
model.mesh('mesh1').feature('size3').set('hmax', 0.4);
model.mesh('mesh1').feature('ftet1').active(false);
model.mesh('mesh1').create('ftri1', 'FreeTri');
model.mesh('mesh1').feature('ftri1').selection.named('box4');
model.mesh('mesh1').create('swe1', 'Sweep');
model.mesh('mesh1').run;

model.sol.create('sol1');
model.sol('sol1').study('std1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'stat');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').set('control', 'stat');
model.sol('sol1').create('s1', 'Stationary');
model.sol('sol1').feature('s1').feature('aDef').set('cachepattern', true);
model.sol('sol1').feature('s1').create('seDef', 'Segregated');
model.sol('sol1').feature('s1').create('se1', 'Segregated');
model.sol('sol1').feature('s1').feature('se1').feature.remove('ssDef');
model.sol('sol1').feature('s1').feature('se1').create('ss1', 'SegregatedStep');
model.sol('sol1').feature('s1').feature('se1').feature('ss1').set('segvar', {'comp1_u'});
model.sol('sol1').feature('s1').feature('se1').feature('ss1').set('subdtech', 'auto');
model.sol('sol1').feature('s1').feature('se1').feature('ss1').set('subminstep', 0.5);
model.sol('sol1').feature('s1').feature('se1').feature('ss1').set('usesubminsteprecovery', 'on');
model.sol('sol1').feature('s1').feature('se1').feature('ss1').set('subtermauto', 'tol');
model.sol('sol1').feature('s1').feature('se1').feature('ss1').set('maxsubiter', 50);
model.sol('sol1').feature('s1').feature('se1').feature('ss1').set('subntolfact', 1);
model.sol('sol1').feature('s1').create('d1', 'Direct');
model.sol('sol1').feature('s1').feature('d1').set('linsolver', 'pardiso');
model.sol('sol1').feature('s1').feature('d1').set('pivotperturb', 1.0E-9);
model.sol('sol1').feature('s1').feature('d1').label('Suggested Direct Solver (pzrb1) (Merged)');
model.sol('sol1').feature('s1').feature('se1').feature('ss1').set('linsolver', 'd1');
model.sol('sol1').feature('s1').feature('se1').feature('ss1').label('Displacement Field');
model.sol('sol1').feature('s1').feature('se1').create('ss2', 'SegregatedStep');
model.sol('sol1').feature('s1').feature('se1').feature('ss2').set('segvar', {'comp1_ecis_Vc' 'comp1_ecis_bterm2_V0_ode' 'comp1_ecis_bterm3_V0_ode'});
model.sol('sol1').feature('s1').feature('se1').feature('ss2').set('subdtech', 'auto');
model.sol('sol1').feature('s1').feature('se1').feature('ss2').set('subminstep', 0.5);
model.sol('sol1').feature('s1').feature('se1').feature('ss2').set('usesubminsteprecovery', 'on');
model.sol('sol1').feature('s1').feature('se1').feature('ss2').set('subtermauto', 'tol');
model.sol('sol1').feature('s1').feature('se1').feature('ss2').set('maxsubiter', 50);
model.sol('sol1').feature('s1').feature('se1').feature('ss2').set('subntolfact', 1);
model.sol('sol1').feature('s1').feature('se1').feature('ss2').set('linsolver', 'd1');
model.sol('sol1').feature('s1').feature('se1').feature('ss2').label('Electric Potential');
model.sol('sol1').feature('s1').feature('se1').set('segterm', 'iter');
model.sol('sol1').feature('s1').feature('se1').set('segiter', 1);
model.sol('sol1').feature('s1').create('i1', 'Iterative');
model.sol('sol1').feature('s1').feature('i1').set('linsolver', 'gmres');
model.sol('sol1').feature('s1').feature('i1').set('rhob', 400);
model.sol('sol1').feature('s1').feature('i1').set('nlinnormuse', true);
model.sol('sol1').feature('s1').feature('i1').label('Suggested Iterative Solver (pzrb1)');
model.sol('sol1').feature('s1').feature('i1').create('mg1', 'Multigrid');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').set('prefun', 'gmg');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('pr').create('so1', 'SOR');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('pr').feature('so1').set('relax', 0.8);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('po').create('so1', 'SOR');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('po').feature('so1').set('relax', 0.8);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('cs').create('d1', 'Direct');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('cs').feature('d1').set('linsolver', 'pardiso');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('cs').feature('d1').set('pivotperturb', 1.0E-9);
model.sol('sol1').feature('s1').feature.remove('fcDef');
model.sol('sol1').feature('s1').feature.remove('seDef');
model.sol('sol1').attach('std1');
model.sol('sol1').runAll;

model.result.create('pg1', 'PlotGroup3D');
model.result('pg1').set('data', 'dset1');
model.result('pg1').set('defaultPlotID', 'stress');
model.result('pg1').label('Stress (solid)');
model.result('pg1').set('frametype', 'spatial');
model.result('pg1').create('vol1', 'Volume');
model.result('pg1').feature('vol1').set('expr', {'solid.misesGp'});
model.result('pg1').feature('vol1').set('threshold', 'manual');
model.result('pg1').feature('vol1').set('thresholdvalue', 0.2);
model.result('pg1').feature('vol1').set('colortable', 'Rainbow');
model.result('pg1').feature('vol1').set('colortabletrans', 'none');
model.result('pg1').feature('vol1').set('colorscalemode', 'linear');
model.result('pg1').feature('vol1').set('resolution', 'custom');
model.result('pg1').feature('vol1').set('refine', 2);
model.result('pg1').feature('vol1').set('colortable', 'Prism');
model.result('pg1').feature('vol1').create('def', 'Deform');
model.result('pg1').feature('vol1').feature('def').set('expr', {'u' 'v' 'w'});
model.result('pg1').feature('vol1').feature('def').set('descr', 'Displacement field');
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
model.result.create('pg3', 'PlotGroup3D');
model.result('pg3').run;
model.result('pg3').label('Displacement');
model.result('pg3').create('surf1', 'Surface');
model.result('pg3').feature('surf1').set('expr', 'solid.disp');
model.result('pg3').feature('surf1').set('descr', 'Displacement magnitude');
model.result('pg3').feature('surf1').create('def1', 'Deform');
model.result('pg3').run;
model.result('pg3').run;
model.result.create('pg4', 'PlotGroup3D');
model.result('pg4').run;
model.result('pg4').label('In-Plane Shear Stress (Local Coordinates)');
model.result('pg4').create('surf1', 'Surface');
model.result('pg4').feature('surf1').set('expr', 'solid.slGp12');
model.result('pg4').feature('surf1').set('descr', 'Stress tensor, local coordinate system, 12-component');
model.result('pg4').run;
model.result.create('pg5', 'PlotGroup1D');
model.result('pg5').run;
model.result('pg5').label('In-Plane Shear Stress (Local Coordinate System)');
model.result('pg5').create('lngr1', 'LineGraph');
model.result('pg5').feature('lngr1').set('markerpos', 'datapoints');
model.result('pg5').feature('lngr1').set('linewidth', 'preference');
model.result('pg5').feature('lngr1').selection.set([16 213]);
model.result('pg5').feature('lngr1').set('expr', 'solid.SlGp12');
model.result('pg5').feature('lngr1').set('descr', ['Second Piola' native2unicode(hex2dec({'20' '13'}), 'unicode') 'Kirchhoff stress, local coordinate system, 12-component']);
model.result('pg5').run;
model.result.dataset.duplicate('dset2', 'dset1');
model.result.dataset('dset2').selection.geom('geom1', 2);
model.result.dataset('dset2').selection.named('sel1');
model.result.dataset('dset2').selection.named('uni1');
model.result.create('pg6', 'PlotGroup3D');
model.result('pg6').run;
model.result('pg6').label('Current and Voltage');
model.result('pg6').set('data', 'dset2');
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

model.title('Piezoresistive Pressure Sensor');

model.description('A piezoresistive pressure sensor is simulated. This model shows how to set compute the stress induced potential difference produced by a four terminal piezoresistor when the membrane in which it is embedded is deformed by an applied pressure. The Piezoresistivity, Boundary Currents interface is used. The model is based on an analysis of an early MEMS pressure sensor: the Motorola MAP sensor (S.D. Senturia, Microsystem Design, Springer, 2000).');

model.mesh.clearMeshes;

model.sol('sol1').clearSolutionData;

model.label('piezoresistive_pressure_sensor.mph');

model.modelNode.label('Components');

out = model;
