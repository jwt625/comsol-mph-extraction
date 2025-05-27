function out = model
%
% contactor_shading_coil.m
%
% Model exported on May 26 2025, 21:24 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/ACDC_Module/Electromagnetics_and_Mechanics');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 2);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.physics.create('solid', 'SolidMechanics', 'geom1');
model.physics('solid').model('comp1');
model.physics.create('mf', 'InductionCurrents', 'geom1');
model.physics('mf').model('comp1');
model.physics('mf').create('als1', 'AmperesLawSolid');
model.physics('mf').feature('als1').selection.all;

model.multiphysics.create('mmcpl1', 'Magnetomechanics', 'geom1', 2);
model.multiphysics('mmcpl1').set('Solid_physics', 'solid');
model.multiphysics('mmcpl1').set('MagneticFields_physics', 'mf');
model.multiphysics('mmcpl1').selection.all;

model.common.create('free1', 'DeformingDomain', 'comp1');
model.common('free1').set('smoothingType', 'hyperelastic');
model.common('free1').selection.set([]);
model.common.create('sym1', 'Symmetry', 'comp1');
model.common('sym1').selection.set([]);

model.study.create('std1');
model.study('std1').create('time', 'Transient');
model.study('std1').feature('time').setSolveFor('/physics/solid', true);
model.study('std1').feature('time').setSolveFor('/physics/mf', true);
model.study('std1').feature('time').setSolveFor('/multiphysics/mmcpl1', true);

model.param.set('em_w', '100[mm]');
model.param.descr('em_w', 'Width, electromagnet');
model.param.set('em_h', '60[mm]');
model.param.descr('em_h', 'Height, electromagnet');
model.param.set('core_w', '20[mm]');
model.param.descr('core_w', 'Width, core');
model.param.set('pl_h', '30[mm]');
model.param.descr('pl_h', 'Height, plunger');
model.param.set('plunger_travel', '6[mm]');
model.param.descr('plunger_travel', 'Total stroke, plunger');
model.param.set('N', '500');
model.param.descr('N', 'Number of turns, primary coil');
model.param.set('d', '1.35[N*s/m]');
model.param.descr('d', 'Damping constant, return spring');
model.param.set('kr', '24.2[N/m]');
model.param.descr('kr', 'Spring constant, return spring');
model.param.set('l0', 'plunger_travel*0.1');
model.param.descr('l0', 'Undeformed length, contact spring');
model.param.set('op', 'plunger_travel*0.7');
model.param.descr('op', 'Opening, electrical contact');
model.param.set('dc', '2.7[mm]');
model.param.descr('dc', 'Diameter, shading coil');
model.param.set('kc', '255[N/m]');
model.param.descr('kc', 'Spring constant, contact spring');
model.param.set('c', '5[N*s/m]');
model.param.descr('c', 'Damping coefficient, contact spring');

model.geom('geom1').lengthUnit('mm');
model.geom('geom1').create('r1', 'Rectangle');
model.geom('geom1').feature('r1').set('size', {'em_w/2' 'em_h'});
model.geom('geom1').run('r1');
model.geom('geom1').create('r2', 'Rectangle');
model.geom('geom1').feature('r2').set('size', {'em_w/2' 'pl_h'});
model.geom('geom1').feature('r2').set('pos', {'0' 'em_h'});
model.geom('geom1').run('r2');
model.geom('geom1').create('r3', 'Rectangle');
model.geom('geom1').feature('r3').set('size', {'(em_w-2*core_w)/2' '1'});
model.geom('geom1').feature('r3').setIndex('size', 'em_h+pl_h -core_w', 1);
model.geom('geom1').feature('r3').set('pos', {'core_w/2' 'core_w/2'});
model.geom('geom1').run('r3');
model.geom('geom1').create('dif1', 'Difference');
model.geom('geom1').feature('dif1').selection('input').set({'r1' 'r2'});
model.geom('geom1').feature('dif1').selection('input2').set({'r3'});
model.geom('geom1').run('dif1');
model.geom('geom1').create('spl1', 'Split');
model.geom('geom1').feature('spl1').selection('input').set({'dif1'});
model.geom('geom1').run('spl1');
model.geom('geom1').create('r4', 'Rectangle');
model.geom('geom1').feature('r4').set('size', [20 44]);
model.geom('geom1').feature('r4').set('pos', [12 12]);
model.geom('geom1').run('r4');
model.geom('geom1').create('r5', 'Rectangle');
model.geom('geom1').feature('r5').set('size', [50 5]);
model.geom('geom1').feature('r5').set('pos', [0 90]);
model.geom('geom1').run('r5');
model.geom('geom1').create('r6', 'Rectangle');
model.geom('geom1').feature('r6').set('size', [10 20]);
model.geom('geom1').feature('r6').set('pos', [0 95]);
model.geom('geom1').run('r6');
model.geom('geom1').create('r7', 'Rectangle');
model.geom('geom1').feature('r7').set('size', [24 3]);
model.geom('geom1').feature('r7').set('pos', [0 115]);
model.geom('geom1').feature('r7').set('layerleft', true);
model.geom('geom1').feature('r7').set('layerbottom', false);
model.geom('geom1').feature('r7').setIndex('layername', 'Layer 1', 0);
model.geom('geom1').feature('r7').setIndex('layer', 10, 0);
model.geom('geom1').run('r7');
model.geom('geom1').create('r8', 'Rectangle');
model.geom('geom1').feature('r8').set('size', [6 1]);
model.geom('geom1').feature('r8').set('pos', [18 114]);
model.geom('geom1').run('r8');
model.geom('geom1').create('r9', 'Rectangle');
model.geom('geom1').feature('r9').set('size', [6 1]);
model.geom('geom1').feature('r9').set('pos', [18 113]);
model.geom('geom1').run('r9');
model.geom('geom1').create('r10', 'Rectangle');
model.geom('geom1').feature('r10').set('size', [40 3]);
model.geom('geom1').feature('r10').set('pos', [18 110]);
model.geom('geom1').run('r10');
model.geom('geom1').create('mov1', 'Move');
model.geom('geom1').feature('mov1').set('disply', 'l0');
model.geom('geom1').feature('mov1').selection('input').set({'r10' 'r7' 'r8' 'r9'});
model.geom('geom1').run('mov1');
model.geom('geom1').create('mov2', 'Move');
model.geom('geom1').feature('mov2').set('disply', 'plunger_travel');
model.geom('geom1').feature('mov2').selection('input').set({'mov1' 'r5' 'r6' 'spl1(2)'});
model.geom('geom1').run('mov2');
model.geom('geom1').create('mov3', 'Move');
model.geom('geom1').feature('mov3').set('disply', '-op');
model.geom('geom1').feature('mov3').selection('input').set({'mov2(1)' 'mov2(4)'});
model.geom('geom1').run('mov3');
model.geom('geom1').create('fil1', 'Fillet');
model.geom('geom1').feature('fil1').set('radius', 'core_w*0.1');
model.geom('geom1').feature('fil1').selection('point').set('mov2(7)', [3 5 7]);
model.geom('geom1').feature('fil1').selection('point').set('spl1(1)', [4 6 8]);
model.geom('geom1').run('fil1');
model.geom('geom1').create('fil2', 'Fillet');
model.geom('geom1').feature('fil2').set('radius', 1);
model.geom('geom1').feature('fil2').selection('point').set('mov2(3)', [1 2]);
model.geom('geom1').feature('fil2').selection('point').set('mov3(2)', [3 4]);
model.geom('geom1').run('fil2');
model.geom('geom1').create('r11', 'Rectangle');
model.geom('geom1').feature('r11').set('size', {'3*em_w/2' '3*em_w'});
model.geom('geom1').feature('r11').set('pos', {'0' '-em_w'});
model.geom('geom1').run('r11');
model.geom('geom1').create('r12', 'Rectangle');
model.geom('geom1').feature('r12').set('size', {'dc' '2'});
model.geom('geom1').feature('r12').set('base', 'center');
model.geom('geom1').feature('r12').set('pos', [44 59]);
model.geom('geom1').feature('r12').set('layerbottom', false);
model.geom('geom1').feature('r12').set('layerright', true);
model.geom('geom1').feature('r12').set('layerleft', true);
model.geom('geom1').feature('r12').setIndex('layername', 'Layer 1', 0);
model.geom('geom1').feature('r12').setIndex('layer', 0.8, 0);
model.geom('geom1').run('r12');
model.geom('geom1').create('del1', 'Delete');
model.geom('geom1').feature('del1').selection('input').set('r12', 5);
model.geom('geom1').run('del1');
model.geom('geom1').create('r13', 'Rectangle');
model.geom('geom1').feature('r13').set('size', [58 90]);
model.geom('geom1').feature('r13').set('pos', [0 50]);
model.geom('geom1').runPre('fin');

model.pair.create('p1', 'Contact', 'geom1');

model.geom('geom1').run;

model.pair('p1').source.set([44 78 80]);
model.pair('p1').destination.set([45 79 81]);
model.pair('p1').searchMethod('fast');
model.pair('p1').manualDist(true);
model.pair('p1').searchDist('6');
model.pair.create('p2', 'Contact', 'geom1');
model.pair('p2').source.set([8 55 59 61 64 66 76 82 84]);
model.pair('p2').destination.set([10 56 77 83 85]);
model.pair('p2').searchMethod('fast');
model.pair('p2').manualDist(true);
model.pair('p2').searchDist('6');

model.common('free1').selection.set([4]);
model.common('sym1').selection.set([7 15 19 72 74]);

model.material.create('mat1', 'Common', 'comp1');
model.material('mat1').propertyGroup.create('BHCurve', 'B-H Curve');
model.material('mat1').propertyGroup('BHCurve').func.create('BH', 'Interpolation');
model.material('mat1').propertyGroup.create('EffectiveBHCurve', 'Effective B-H Curve');
model.material('mat1').propertyGroup('EffectiveBHCurve').func.create('BHeff', 'Interpolation');
model.material('mat1').label('Soft Iron (Without Losses)');
model.material('mat1').set('family', 'iron');
model.material('mat1').propertyGroup('def').set('electricconductivity', {'0[S/m]' '0' '0' '0' '0[S/m]' '0' '0' '0' '0[S/m]'});
model.material('mat1').propertyGroup('def').set('relpermittivity', {'1' '0' '0' '0' '1' '0' '0' '0' '1'});
model.material('mat1').propertyGroup('BHCurve').label('B-H Curve');
model.material('mat1').propertyGroup('BHCurve').func('BH').label('Interpolation 1');
model.material('mat1').propertyGroup('BHCurve').func('BH').set('table', {'0' '0';  ...
'663.146' '1';  ...
'1067.5' '1.1';  ...
'1705.23' '1.2';  ...
'2463.11' '1.3';  ...
'3841.67' '1.4';  ...
'5425.74' '1.5';  ...
'7957.75' '1.6';  ...
'12298.3' '1.7';  ...
'20462.8' '1.8';  ...
'32169.6' '1.9';  ...
'61213.4' '2';  ...
'111408' '2.1';  ...
'188487.757' '2.2';  ...
'267930.364' '2.3';  ...
'347507.836' '2.4'});
model.material('mat1').propertyGroup('BHCurve').func('BH').set('extrap', 'linear');
model.material('mat1').propertyGroup('BHCurve').func('BH').set('fununit', {'T'});
model.material('mat1').propertyGroup('BHCurve').func('BH').set('argunit', {'A/m'});
model.material('mat1').propertyGroup('BHCurve').func('BH').set('defineinv', true);
model.material('mat1').propertyGroup('BHCurve').func('BH').set('defineprimfun', true);
model.material('mat1').propertyGroup('BHCurve').set('normB', 'BH(normHin)');
model.material('mat1').propertyGroup('BHCurve').set('normH', 'BH_inv(normBin)');
model.material('mat1').propertyGroup('BHCurve').set('Wpm', 'BH_prim(normHin)');
model.material('mat1').propertyGroup('BHCurve').descr('normHin', 'Magnetic field norm');
model.material('mat1').propertyGroup('BHCurve').descr('normBin', 'Magnetic flux density norm');
model.material('mat1').propertyGroup('BHCurve').addInput('magneticfield');
model.material('mat1').propertyGroup('BHCurve').addInput('magneticfluxdensity');
model.material('mat1').propertyGroup('EffectiveBHCurve').label('Effective B-H Curve');
model.material('mat1').propertyGroup('EffectiveBHCurve').func('BHeff').label('Interpolation 1');
model.material('mat1').propertyGroup('EffectiveBHCurve').func('BHeff').set('table', {'0' '0';  ...
'663.146' '1.000000051691021';  ...
'1067.5' '1.4936495124126294';  ...
'1705.23' '1.9415328461315795';  ...
'2463.11' '2.257765669366018';  ...
'3841.67' '2.609980642431287';  ...
'5425.74' '2.8664452090837504';  ...
'7957.75' '3.1441438097176118';  ...
'12298.3' '3.448538051654125';  ...
'20462.8' '3.7816711973679054';  ...
'32169.6' '4.058345590113038';  ...
'61213.4' '4.420646552950275';  ...
'111408' '4.721274089545955';  ...
'188487.757' '4.972148140718701';  ...
'267930.364' '5.145510860855953';  ...
'347507.836' '5.245510861426532'});
model.material('mat1').propertyGroup('EffectiveBHCurve').func('BHeff').set('extrap', 'linear');
model.material('mat1').propertyGroup('EffectiveBHCurve').func('BHeff').set('fununit', {'T'});
model.material('mat1').propertyGroup('EffectiveBHCurve').func('BHeff').set('argunit', {'A/m'});
model.material('mat1').propertyGroup('EffectiveBHCurve').func('BHeff').set('defineinv', true);
model.material('mat1').propertyGroup('EffectiveBHCurve').set('normBeff', 'BHeff(normHeffin)');
model.material('mat1').propertyGroup('EffectiveBHCurve').set('normHeff', 'BHeff_inv(normBeffin)');
model.material('mat1').propertyGroup('EffectiveBHCurve').descr('normHeffin', 'Effective magnetic field norm');
model.material('mat1').propertyGroup('EffectiveBHCurve').descr('normBeffin', 'Effective magnetic flux density norm');
model.material('mat1').propertyGroup('EffectiveBHCurve').addInput('magneticfield');
model.material('mat1').propertyGroup('EffectiveBHCurve').addInput('magneticfluxdensity');
model.material('mat1').selection.set([2 3 5 16]);
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
model.material('mat2').selection.set([8 10 13 14 15]);
model.material.create('mat3', 'Common', 'comp1');
model.material('mat3').propertyGroup.create('Enu', 'Young''s modulus and Poisson''s ratio');
model.material('mat3').label('Acrylic plastic');
model.material('mat3').set('family', 'custom');
model.material('mat3').set('customspecular', [0.9803921568627451 0.9803921568627451 0.9803921568627451]);
model.material('mat3').set('customdiffuse', [0.39215686274509803 0.7843137254901961 0.39215686274509803]);
model.material('mat3').set('customambient', [0.39215686274509803 0.7843137254901961 0.39215686274509803]);
model.material('mat3').set('noise', true);
model.material('mat3').set('lighting', 'phong');
model.material('mat3').set('shininess', 1000);
model.material('mat3').propertyGroup('def').set('thermalexpansioncoefficient', {'7.0e-5[1/K]' '0' '0' '0' '7.0e-5[1/K]' '0' '0' '0' '7.0e-5[1/K]'});
model.material('mat3').propertyGroup('def').set('heatcapacity', '1470[J/(kg*K)]');
model.material('mat3').propertyGroup('def').set('density', '1190[kg/m^3]');
model.material('mat3').propertyGroup('def').set('thermalconductivity', {'0.18[W/(m*K)]' '0' '0' '0' '0.18[W/(m*K)]' '0' '0' '0' '0.18[W/(m*K)]'});
model.material('mat3').propertyGroup('Enu').set('E', '3.2[GPa]');
model.material('mat3').propertyGroup('Enu').set('nu', '0.35');
model.material('mat3').selection.set([6 7]);
model.material.create('mat4', 'Common', 'comp1');
model.material('mat4').propertyGroup.create('Enu', 'Young''s modulus and Poisson''s ratio');
model.material('mat4').propertyGroup.create('Murnaghan', 'Murnaghan');
model.material('mat4').label('Aluminum');
model.material('mat4').set('family', 'aluminum');
model.material('mat4').propertyGroup('def').set('relpermeability', {'1' '0' '0' '0' '1' '0' '0' '0' '1'});
model.material('mat4').propertyGroup('def').set('heatcapacity', '900[J/(kg*K)]');
model.material('mat4').propertyGroup('def').set('thermalconductivity', {'238[W/(m*K)]' '0' '0' '0' '238[W/(m*K)]' '0' '0' '0' '238[W/(m*K)]'});
model.material('mat4').propertyGroup('def').set('electricconductivity', {'3.774e7[S/m]' '0' '0' '0' '3.774e7[S/m]' '0' '0' '0' '3.774e7[S/m]'});
model.material('mat4').propertyGroup('def').set('relpermittivity', {'1' '0' '0' '0' '1' '0' '0' '0' '1'});
model.material('mat4').propertyGroup('def').set('thermalexpansioncoefficient', {'23e-6[1/K]' '0' '0' '0' '23e-6[1/K]' '0' '0' '0' '23e-6[1/K]'});
model.material('mat4').propertyGroup('def').set('density', '2700[kg/m^3]');
model.material('mat4').propertyGroup('Enu').set('E', '70[GPa]');
model.material('mat4').propertyGroup('Enu').set('nu', '0.33');
model.material('mat4').propertyGroup('Murnaghan').set('l', '-250[GPa]');
model.material('mat4').propertyGroup('Murnaghan').set('m', '-330[GPa]');
model.material('mat4').propertyGroup('Murnaghan').set('n', '-350[GPa]');
model.material('mat4').selection.set([11 12 17 18]);

model.physics('solid').prop('d').set('d', '30[mm]');
model.physics('solid').selection.set([2 3 5 6 7 8 10 13 14 15 16 17 18]);
model.physics('solid').prop('AdvancedSettings').set('GroupPhysOdesAtt', false);
model.physics('solid').create('fix1', 'Fixed', 1);
model.physics('solid').feature('fix1').selection.set([4 41 73]);
model.physics('solid').create('spf1', 'SpringFoundation2', 2);
model.physics('solid').feature('spf1').selection.set([5]);
model.physics('solid').feature('spf1').set('SpringType', 'kTot');
model.physics('solid').feature('spf1').set('kTot', {'kr' '0' '0' '0' 'kr' '0' '0' '0' 'kr'});
model.physics('solid').feature('spf1').set('ViscousType', 'DampTot');
model.physics('solid').feature('spf1').set('DampTot', {'d' '0' '0' '0' 'd' '0' '0' '0' 'd'});
model.physics('solid').create('roll1', 'Roller', 1);
model.physics('solid').feature('roll1').selection.set([47 67 68 70 71]);
model.physics('solid').create('att1', 'Attachment', 1);
model.physics('solid').feature('att1').selection.set([18]);
model.physics('solid').create('att2', 'Attachment', 1);
model.physics('solid').feature('att2').selection.set([16]);
model.physics('solid').create('spd1', 'SpringDamper', -1);
model.physics('solid').feature('spd1').set('Source', 'att1');
model.physics('solid').feature('spd1').set('Destination', 'att2');
model.physics('solid').feature('spd1').set('k', 'kc');
model.physics('solid').feature('spd1').set('c', 'c');
model.physics('solid').create('sym1', 'SymmetrySolid', 1);
model.physics('solid').feature('sym1').selection.set([3 5 9 11 13 17]);
model.physics('solid').feature('dcnt1').set('destination_offset', '0.05[mm]');
model.physics('mf').feature('als1').selection.set([6 7 8 10 13 14 15]);
model.physics('mf').prop('d').set('d', '30[mm]');
model.physics('mf').create('als2', 'AmperesLawSolid', 2);
model.physics('mf').feature('als2').label(['Amp' native2unicode(hex2dec({'00' 'e8'}), 'unicode') 're''s Law 2, Iron']);
model.physics('mf').feature('als2').selection.set([2 3 5 16]);
model.physics('mf').feature('als2').set('ConstitutiveRelationBH', 'BHCurve');
model.physics('mf').create('coil1', 'Coil', 2);
model.physics('mf').feature('coil1').label('Coil 1, primary');
model.physics('mf').feature('coil1').selection.set([11 12]);
model.physics('mf').feature('coil1').setIndex('materialType', 'solid', 0);
model.physics('mf').feature('coil1').set('ConductorModel', 'Multi');
model.physics('mf').feature('coil1').set('CoilExcitation', 'Voltage');
model.physics('mf').feature('coil1').set('VCoil', '48[V]*sin(2*pi*50[Hz]*t)/2');
model.physics('mf').feature('coil1').set('N', 'N');
model.physics('mf').feature('coil1').set('AreaFrom', 'Diameter');
model.physics('mf').feature('coil1').set('coilWindDiameter', '1.5[mm]');
model.physics('mf').create('coil2', 'Coil', 2);
model.physics('mf').feature('coil2').label('Coil 2, shading');
model.physics('mf').feature('coil2').selection.set([17 18]);
model.physics('mf').feature('coil2').setIndex('materialType', 'solid', 0);
model.physics('mf').feature('coil2').set('ICoil', '0[A]');
model.physics('mf').create('mi2', 'MagneticInsulation', 1);
model.physics('mf').feature('mi2').selection.set([18 20 33 34 40 41 44 45 46 47 73 78 79 80 81]);
model.physics('mf').create('symp1', 'SymmetryPlane', 1);
model.physics('mf').feature('symp1').selection.set([1 3 5 7 9 11 13 15 17 19 21]);

model.multiphysics('mmcpl1').selection.set([2 3 5 16 17 18]);

model.material('mat3').propertyGroup('def').set('relpermeability', {'1'});
model.material('mat3').propertyGroup('def').set('electricconductivity', {'0'});
model.material('mat3').propertyGroup('def').set('relpermittivity', {'3.5'});
model.material('mat1').propertyGroup.create('Enu', 'Young''s_modulus_and_Poisson''s_ratio');
model.material('mat1').propertyGroup('Enu').set('E', {'204e9'});
model.material('mat1').propertyGroup('Enu').set('nu', {'0.39'});
model.material('mat1').propertyGroup('def').set('density', {'7840'});

model.probe.create('point1', 'Point');
model.probe('point1').model('comp1');
model.probe('point1').label('Air gap, electrical contact');
model.probe('point1').set('probename', 'gap_p1');
model.probe('point1').selection.set([30]);
model.probe('point1').set('expr', 'solid.gap_p1');
model.probe('point1').set('descractive', true);
model.probe('point1').set('descr', 'Electrical contact air gap');
model.probe('point1').set('window', 'window1');
model.probe('point1').set('windowtitle', 'Probe Plot 1');
model.probe.duplicate('point2', 'point1');
model.probe('point2').label('Air gap, central limb');
model.probe('point2').set('probename', 'gap_p2');
model.probe('point2').selection.set([4]);
model.probe('point2').set('expr', 'solid.gap_p2');
model.probe('point2').set('descr', 'Central limb air gap');
model.probe.create('var1', 'GlobalVariable');
model.probe('var1').model('comp1');
model.probe('var1').label('Contact force, electrical contact');
model.probe('var1').set('probename', 'T_toty_p1');
model.probe('var1').set('expr', 'solid.dcnt1.T_toty_p1*(solid.dcnt1.T_toty_p1<500[N])+500[N]*(solid.dcnt1.T_toty_p1>500[N])');
model.probe('var1').set('descractive', true);
model.probe('var1').set('descr', 'Contact force, electrical contact');
model.probe('var1').set('window', 'window2');
model.probe('var1').set('windowtitle', 'Probe Plot 2');
model.probe.duplicate('var2', 'var1');
model.probe('var2').label('Contact force, central limb');
model.probe('var2').set('probename', 'T_toty_p2');
model.probe('var2').set('descr', 'Contact force, central limb');
model.probe('var2').set('expr', 'solid.dcnt1.T_toty_p2*(solid.dcnt1.T_toty_p2<500[N])+500[N]*(solid.dcnt1.T_toty_p2>500[N])');

model.cpl.create('intop1', 'Integration', 'geom1');
model.cpl('intop1').set('axisym', true);
model.cpl('intop1').selection.set([18]);

model.probe.create('var3', 'GlobalVariable');
model.probe('var3').model('comp1');
model.probe('var3').set('probename', 'I_coil');
model.probe('var3').label('Total current, coil');
model.probe('var3').set('expr', 'mf.ICoil_1');
model.probe('var3').set('descr', 'Coil current');
model.probe('var3').set('window', 'window3');
model.probe('var3').set('windowtitle', 'Probe Plot 3');
model.probe.duplicate('var4', 'var3');
model.probe('var4').set('probename', 'I_shading_coil');
model.probe('var4').label('Total current, shading coil');
model.probe('var4').set('expr', 'intop1(abs(mf.Jz))');
model.probe('var4').set('descractive', true);
model.probe('var4').set('descr', 'Shading coil current (absolute value)');

model.study('std1').feature('time').set('tunit', 'ms');
model.study('std1').feature('time').set('tlist', 'range(0,0.2,20) range(20.5,0.5,40)');
model.study('std1').feature('time').set('autoremesh', true);

model.sol.create('sol1');

model.mesh('mesh1').stat.selection.geom(2);
model.mesh('mesh1').stat.selection.set([4]);

model.sol('sol1').study('std1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'time');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').feature('comp1_solid_att1_u').set('scalemethod', 'manual');
model.sol('sol1').feature('v1').feature('comp1_solid_att2_u').set('scalemethod', 'manual');
model.sol('sol1').feature('v1').feature('comp1_solid_att1_phi').set('scalemethod', 'manual');
model.sol('sol1').feature('v1').feature('comp1_solid_att2_phi').set('scalemethod', 'manual');
model.sol('sol1').feature('v1').feature('comp1_spatial_disp').set('scalemethod', 'manual');
model.sol('sol1').feature('v1').feature('comp1_u').set('scalemethod', 'manual');
model.sol('sol1').feature('v1').feature('comp1_solid_att1_u').set('resscalemethod', 'parent');
model.sol('sol1').feature('v1').feature('comp1_solid_att2_u').set('resscalemethod', 'parent');
model.sol('sol1').feature('v1').feature('comp1_solid_att1_phi').set('resscalemethod', 'parent');
model.sol('sol1').feature('v1').feature('comp1_solid_att2_phi').set('resscalemethod', 'parent');
model.sol('sol1').feature('v1').feature('comp1_solid_att1_u').set('scaleval', '1e-2*0.33541019662496846');
model.sol('sol1').feature('v1').feature('comp1_solid_att2_u').set('scaleval', '1e-2*0.33541019662496846');
model.sol('sol1').feature('v1').feature('comp1_solid_att1_phi').set('scaleval', '1e-1');
model.sol('sol1').feature('v1').feature('comp1_solid_att2_phi').set('scaleval', '1e-1');
model.sol('sol1').feature('v1').feature('comp1_spatial_disp').set('scaleval', '1e-2*0.33541019662496846');
model.sol('sol1').feature('v1').feature('comp1_u').set('scaleval', '1e-2*0.33541019662496846');
model.sol('sol1').feature('v1').set('control', 'time');
model.sol('sol1').create('t1', 'Time');
model.sol('sol1').feature('t1').set('tlist', 'range(0,0.2,20) range(20.5,0.5,40)');
model.sol('sol1').feature('t1').set('plot', 'off');
model.sol('sol1').feature('t1').set('plotgroup', 'Default');
model.sol('sol1').feature('t1').set('plotfreq', 'tout');
model.sol('sol1').feature('t1').set('probesel', 'all');
model.sol('sol1').feature('t1').set('probes', {'point1' 'point2' 'var1' 'var2' 'var3' 'var4'});
model.sol('sol1').feature('t1').set('probefreq', 'tsteps');
model.sol('sol1').feature('t1').set('tout', 'tstepsclosest');
model.sol('sol1').feature('t1').set('rtol', 0.001);
model.sol('sol1').feature('t1').set('atolglobalvaluemethod', 'factor');
model.sol('sol1').feature('t1').set('reacf', true);
model.sol('sol1').feature('t1').set('storeudot', true);
model.sol('sol1').feature('t1').set('tstepsbdf', 'strict');
model.sol('sol1').feature('t1').set('endtimeinterpolation', true);
model.sol('sol1').feature('t1').set('estrat', 'exclude');
model.sol('sol1').feature('t1').set('predictor', 'constant');
model.sol('sol1').feature('t1').set('control', 'time');
model.sol('sol1').feature('t1').feature('arDef').set('autoremeshgeom', 'geom1');
model.sol('sol1').feature('t1').feature('arDef').set('stopcondtype', 'distortion');
model.sol('sol1').feature('t1').feature('arDef').set('stopdistexpr', 'sqrt(comp1.spatial.I1isoMax)');
model.sol('sol1').feature('t1').feature('arDef').set('stopdistval', '2');
model.sol('sol1').feature('t1').feature('aDef').set('cachepattern', true);
model.sol('sol1').feature('t1').create('seDef', 'Segregated');
model.sol('sol1').feature('t1').create('se1', 'Segregated');
model.sol('sol1').feature('t1').feature('se1').feature.remove('ssDef');
model.sol('sol1').feature('t1').feature('se1').create('ss1', 'SegregatedStep');
model.sol('sol1').feature('t1').feature('se1').feature('ss1').set('segvar', {'comp1_A' 'comp1_mf_coil1_ICoil_ode' 'comp1_mf_coil2_VCoil_ode'});
model.sol('sol1').feature('t1').feature('se1').feature('ss1').set('subdtech', 'const');
model.sol('sol1').feature('t1').feature('se1').feature('ss1').set('subjtech', 'onevery');
model.sol('sol1').feature('t1').create('d1', 'Direct');
model.sol('sol1').feature('t1').feature('d1').set('linsolver', 'pardiso');
model.sol('sol1').feature('t1').feature('se1').feature('ss1').set('linsolver', 'd1');
model.sol('sol1').feature('t1').feature('se1').feature('ss1').label('Magnetic Potential');
model.sol('sol1').feature('t1').feature('se1').create('ss2', 'SegregatedStep');
model.sol('sol1').feature('t1').feature('se1').feature('ss2').set('segvar', {'comp1_u' 'comp1_solid_spd1_Wd' 'comp1_solid_att1_u' 'comp1_solid_att1_phi' 'comp1_solid_att2_u' 'comp1_solid_att2_phi'});
model.sol('sol1').feature('t1').feature('se1').feature('ss2').set('subdtech', 'const');
model.sol('sol1').feature('t1').feature('se1').feature('ss2').set('subjtech', 'onevery');
model.sol('sol1').feature('t1').feature('se1').feature('ss2').set('linsolver', 'dDef');
model.sol('sol1').feature('t1').feature('se1').feature('ss2').label('Displacement Field');
model.sol('sol1').feature('t1').feature('se1').create('ss3', 'SegregatedStep');
model.sol('sol1').feature('t1').feature('se1').feature('ss3').set('segvar', {'comp1_spatial_disp'});
model.sol('sol1').feature('t1').feature('se1').feature('ss3').set('subdtech', 'const');
model.sol('sol1').feature('t1').feature('se1').feature('ss3').set('subjtech', 'onevery');
model.sol('sol1').feature('t1').feature('se1').feature('ss3').set('linsolver', 'dDef');
model.sol('sol1').feature('t1').feature('se1').feature('ss3').label('Spatial Mesh Displacement');
model.sol('sol1').feature('t1').feature.remove('fcDef');
model.sol('sol1').feature('t1').feature.remove('seDef');
model.sol('sol1').attach('std1');
model.sol.create('sol2');
model.sol('sol2').label('Remeshed Solution 1');
model.sol('sol2').study('std1');
model.sol('sol1').feature('t1').feature('arDef').set('tadapsol', 'sol2');

model.probe('point1').genResult('none');
model.probe('point2').genResult('none');
model.probe('var1').genResult('none');
model.probe('var2').genResult('none');
model.probe('var3').genResult('none');
model.probe('var4').genResult('none');

model.result.create('pg4', 'PlotGroup2D');
model.result('pg4').set('data', 'dset2');
model.result('pg4').set('defaultPlotID', 'stress');
model.result('pg4').label('Stress (solid)');
model.result('pg4').set('frametype', 'spatial');
model.result('pg4').create('surf1', 'Surface');
model.result('pg4').feature('surf1').set('expr', {'solid.misesGp'});
model.result('pg4').feature('surf1').set('threshold', 'manual');
model.result('pg4').feature('surf1').set('thresholdvalue', 0.2);
model.result('pg4').feature('surf1').set('colortable', 'Rainbow');
model.result('pg4').feature('surf1').set('colortabletrans', 'none');
model.result('pg4').feature('surf1').set('colorscalemode', 'linear');
model.result('pg4').feature('surf1').set('resolution', 'normal');
model.result('pg4').feature('surf1').set('colortable', 'Prism');
model.result.create('pg5', 'PlotGroup2D');
model.result('pg5').label('Magnetic Flux Density Norm (mf)');
model.result('pg5').set('data', 'dset2');
model.result('pg5').set('frametype', 'spatial');
model.result('pg5').set('showlegendsmaxmin', true);
model.result('pg5').set('data', 'dset2');
model.result('pg5').set('defaultPlotID', 'InterfaceComponents/PlotDefaults/icom6/pdef1/pcond2/pcond2/pg1');
model.result('pg5').feature.create('surf1', 'Surface');
model.result('pg5').feature('surf1').set('showsolutionparams', 'on');
model.result('pg5').feature('surf1').set('solutionparams', 'parent');
model.result('pg5').feature('surf1').set('expr', 'mf.normB');
model.result('pg5').feature('surf1').set('colortable', 'Prism');
model.result('pg5').feature('surf1').set('colortabletrans', 'nonlinear');
model.result('pg5').feature('surf1').set('colorcalibration', -0.8);
model.result('pg5').feature('surf1').set('showsolutionparams', 'on');
model.result('pg5').feature('surf1').set('data', 'parent');
model.result('pg5').feature.create('str1', 'Streamline');
model.result('pg5').feature('str1').set('showsolutionparams', 'on');
model.result('pg5').feature('str1').set('solutionparams', 'parent');
model.result('pg5').feature('str1').set('expr', {'mf.Bx' 'mf.By'});
model.result('pg5').feature('str1').set('titletype', 'none');
model.result('pg5').feature('str1').set('posmethod', 'uniform');
model.result('pg5').feature('str1').set('udist', 0.03);
model.result('pg5').feature('str1').set('maxlen', 0.4);
model.result('pg5').feature('str1').set('maxtime', Inf);
model.result('pg5').feature('str1').set('inheritcolor', false);
model.result('pg5').feature('str1').set('showsolutionparams', 'on');
model.result('pg5').feature('str1').set('maxtime', Inf);
model.result('pg5').feature('str1').set('showsolutionparams', 'on');
model.result('pg5').feature('str1').set('maxtime', Inf);
model.result('pg5').feature('str1').set('showsolutionparams', 'on');
model.result('pg5').feature('str1').set('maxtime', Inf);
model.result('pg5').feature('str1').set('showsolutionparams', 'on');
model.result('pg5').feature('str1').set('maxtime', Inf);
model.result('pg5').feature('str1').set('data', 'parent');
model.result('pg5').feature('str1').selection.geom('geom1', 1);
model.result('pg5').feature('str1').selection.set([1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40 41 42 43 44 45 46 47 48 49 50 51 52 53 54 55 56 57 58 59 60 61 62 63 64 65 66 67 68 69 70 71 72 73 74 75 76 77 78 79 80 81 82 83 84 85]);
model.result('pg5').feature('str1').set('inheritplot', 'surf1');
model.result('pg5').feature('str1').feature.create('col1', 'Color');
model.result('pg5').feature('str1').feature('col1').set('expr', 'mf.normB');
model.result('pg5').feature('str1').feature('col1').set('colortable', 'PrismDark');
model.result('pg5').feature('str1').feature('col1').set('colorlegend', false);
model.result('pg5').feature('str1').feature('col1').set('colortabletrans', 'nonlinear');
model.result('pg5').feature('str1').feature('col1').set('colorcalibration', -0.8);
model.result('pg5').feature('str1').feature.create('filt1', 'Filter');
model.result('pg5').feature('str1').feature('filt1').set('expr', '!isScalingSystemDomain');
model.result('pg5').feature.create('con1', 'Contour');
model.result('pg5').feature('con1').set('showsolutionparams', 'on');
model.result('pg5').feature('con1').set('solutionparams', 'parent');
model.result('pg5').feature('con1').set('expr', 'mf.Az');
model.result('pg5').feature('con1').set('titletype', 'none');
model.result('pg5').feature('con1').set('number', 10);
model.result('pg5').feature('con1').set('levelrounding', false);
model.result('pg5').feature('con1').set('coloring', 'uniform');
model.result('pg5').feature('con1').set('colorlegend', false);
model.result('pg5').feature('con1').set('color', 'custom');
model.result('pg5').feature('con1').set('customcolor', [0.3764705955982208 0.3764705955982208 0.3764705955982208]);
model.result('pg5').feature('con1').set('resolution', 'fine');
model.result('pg5').feature('con1').set('inheritcolor', false);
model.result('pg5').feature('con1').set('showsolutionparams', 'on');
model.result('pg5').feature('con1').set('data', 'parent');
model.result('pg5').feature('con1').set('inheritplot', 'surf1');
model.result('pg5').feature('con1').feature.create('filt1', 'Filter');
model.result('pg5').feature('con1').feature('filt1').set('expr', '!isScalingSystemDomain');
model.result.create('pg6', 'PlotGroup2D');
model.result('pg6').set('data', 'dset2');
model.result('pg6').label('Moving Mesh');
model.result('pg6').create('mesh1', 'Mesh');
model.result('pg6').feature('mesh1').set('meshdomain', 'surface');
model.result('pg6').feature('mesh1').set('colortable', 'TrafficFlow');
model.result('pg6').feature('mesh1').set('colortabletrans', 'nonlinear');
model.result('pg6').feature('mesh1').set('nonlinearcolortablerev', true);
model.result('pg6').feature('mesh1').create('sel1', 'MeshSelection');
model.result('pg6').feature('mesh1').feature('sel1').selection.set([2 3 4 5 6 7 8 10 13 14 15 16 17 18]);
model.result('pg6').feature('mesh1').set('qualmeasure', 'custom');
model.result('pg6').feature('mesh1').set('qualexpr', 'comp1.spatial.relVol');
model.result('pg6').feature('mesh1').set('colorrangeunitinterval', false);
model.result('pg4').run;
model.result('pg1').set('window', 'window1');
model.result('pg1').run;
model.result.dataset.create('mir1', 'Mirror2D');
model.result.dataset('mir1').set('data', 'dset2');

model.view('view1').set('locked', true);
model.view('view1').axis.set('xmin', -90);
model.view('view1').axis.set('xmax', 90);
model.view('view1').axis.set('ymin', -20);
model.view('view1').axis.set('ymax', 160);

model.result('pg5').run;
model.result('pg5').set('data', 'mir1');
model.result('pg5').set('view', 'view1');

model.sol('sol1').feature('t1').set('initialstepbdfactive', true);
model.sol('sol1').feature('t1').set('initialstepbdf', 0.05);

model.study('std1').feature('time').set('plot', true);
model.study('std1').feature('time').set('plotgroup', 'pg5');

model.probe('point1').genResult('none');
model.probe('point2').genResult('none');
model.probe('var1').genResult('none');
model.probe('var2').genResult('none');
model.probe('var3').genResult('none');
model.probe('var4').genResult('none');

model.sol('sol1').runAll;

model.result('pg4').run;
model.result('pg1').set('window', 'window1');
model.result('pg1').run;
model.result('pg1').label('Air Gap');
model.result('pg1').set('window', 'window1');
model.result('pg1').run;
model.result('pg1').feature('tblp1').set('legendmethod', 'manual');
model.result('pg1').feature('tblp1').setIndex('legends', 'Air gap, electrical contact (mm)', 0);
model.result('pg1').feature('tblp1').setIndex('legends', 'Air gap, central limb (mm)', 1);
model.result('pg1').set('window', 'window1');
model.result('pg1').run;
model.result('pg2').set('window', 'window2');
model.result('pg2').set('windowtitle', 'Probe Plot 2');
model.result('pg2').run;
model.result('pg2').label('Contact Force');
model.result('pg3').set('window', 'window3');
model.result('pg3').set('windowtitle', 'Probe Plot 3');
model.result('pg3').run;
model.result('pg3').label('Coil Current');

model.physics('mf').create('fcal1', 'ForceCalculation', 2);
model.physics('mf').feature('fcal1').label('Force Calculation, for Postprocessing');
model.physics('mf').feature('fcal1').selection.set([5]);

model.probe('point1').genResult('none');
model.probe('point2').genResult('none');
model.probe('var1').genResult('none');
model.probe('var2').genResult('none');
model.probe('var3').genResult('none');
model.probe('var4').genResult('none');

model.sol('sol1').updateSolution;
model.sol('sol2').updateSolution;

model.result.create('pg7', 'PlotGroup1D');
model.result('pg7').run;
model.result('pg7').create('glob1', 'Global');
model.result('pg7').feature('glob1').set('markerpos', 'datapoints');
model.result('pg7').feature('glob1').set('linewidth', 'preference');
model.result('pg7').run;
model.result('pg7').label('Total Electromagnetic Force');
model.result('pg7').set('data', 'dset2');
model.result('pg7').set('showlegends', false);
model.result('pg7').run;
model.result('pg7').feature('glob1').setIndex('expr', '2*mf.Forcey_0', 0);
model.result('pg7').feature('glob1').setIndex('unit', 'N', 0);
model.result('pg7').feature('glob1').setIndex('descr', 'Total electromagnetic force, y-component', 0);
model.result('pg7').run;
model.result.create('pg8', 'PlotGroup1D');
model.result('pg8').run;
model.result('pg8').label('Contact Force, Electrical Contact');
model.result('pg8').set('data', 'dset2');
model.result('pg8').setIndex('looplevelinput', 'interp', 0);
model.result('pg8').setIndex('interp', 'range(15.55,0.5,40)', 0);
model.result('pg8').set('showlegends', false);
model.result('pg8').create('glob1', 'Global');
model.result('pg8').feature('glob1').set('markerpos', 'datapoints');
model.result('pg8').feature('glob1').set('linewidth', 'preference');
model.result('pg8').feature('glob1').set('expr', {'T_toty_p1'});
model.result('pg8').feature('glob1').set('descr', {'Contact force, electrical contact'});
model.result('pg8').feature('glob1').set('unit', {'N'});
model.result('pg8').run;

model.view.duplicate('view2', 'view1');
model.view('view2').axis.set('xmin', 30);
model.view('view2').axis.set('xmax', 60);
model.view('view2').axis.set('ymin', 45);
model.view('view2').axis.set('ymax', 75);

model.result('pg5').run;
model.result('pg5').set('looplevel', [143]);
model.result('pg5').run;
model.result('pg5').set('looplevel', [126]);
model.result('pg5').run;

model.title('AC Contactor with Shading Coil');

model.description(['An AC contactor is a particular type of magnetic switch device, which is activated by a primary coil fed by an alternating current. Unlike DC switches, such devices can suffer from a tendency to reopen when the AC current crosses zero. The addition of a shading coil that supports retarded induced currents with respect to those of the feeding coil makes it possible to always have a nonzero pulling force, thus providing a more stable closure.' newline  newline 'This example studies the closing dynamics of an AC contactor and the consequent establishing of a mechanical contact. The changing distance between the moving and stationary parts of the device has an influence on the distribution of the magnetic field. This effect is accounted for using a moving mesh in the surrounding air. The model is set up using the Magnetomechanics multiphysics interface.']);

model.mesh.clearMeshes;

model.sol('sol1').clearSolutionData;
model.sol('sol2').clearSolutionData;

model.label('contactor_shading_coil.mph');

model.modelNode.label('Components');

out = model;
