function out = model
%
% eeprom_geom_sequence.m
%
% Model exported on May 26 2025, 21:33 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/Semiconductor_Module/Transistors');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 2);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.geom('geom1').lengthUnit([native2unicode(hex2dec({'00' 'b5'}), 'unicode') 'm']);
model.geom('geom1').create('r1', 'Rectangle');
model.geom('geom1').feature('r1').set('size', [0.8 0.1]);
model.geom('geom1').feature('r1').set('pos', {'0' '50[nm]'});
model.geom('geom1').run('r1');
model.geom('geom1').create('r2', 'Rectangle');
model.geom('geom1').feature('r2').set('size', {'0.15' '42[nm]'});
model.geom('geom1').feature('r2').set('pos', {'0.62' '8[nm]'});
model.geom('geom1').run('r2');
model.geom('geom1').create('r3', 'Rectangle');
model.geom('geom1').feature('r3').set('size', {'0.15' '8[nm]'});
model.geom('geom1').feature('r3').set('pos', [0.62 0]);
model.geom('geom1').run('r3');
model.geom('geom1').create('uni1', 'Union');
model.geom('geom1').feature('uni1').selection('input').set({'r1' 'r2'});
model.geom('geom1').feature('uni1').set('intbnd', false);
model.geom('geom1').run('uni1');
model.geom('geom1').create('r4', 'Rectangle');
model.geom('geom1').feature('r4').set('size', [0.8 0.1]);
model.geom('geom1').feature('r4').set('pos', {'0' '165[nm]'});
model.geom('geom1').run('r4');
model.geom('geom1').create('r5', 'Rectangle');
model.geom('geom1').feature('r5').set('size', [1.8 0.6]);
model.geom('geom1').feature('r5').set('pos', [-0.5 -0.6]);
model.geom('geom1').run('r5');
model.geom('geom1').create('r6', 'Rectangle');
model.geom('geom1').feature('r6').set('size', [1.8 0.3]);
model.geom('geom1').feature('r6').set('pos', [-0.5 0]);
model.geom('geom1').run('r6');
model.geom('geom1').create('r7', 'Rectangle');
model.geom('geom1').feature('r7').set('size', [0.35 0.15]);
model.geom('geom1').feature('r7').set('pos', [-0.5 0.15]);
model.geom('geom1').run('r7');
model.geom('geom1').create('r8', 'Rectangle');
model.geom('geom1').feature('r8').set('size', [0.35 0.15]);
model.geom('geom1').feature('r8').set('pos', [0.95 0.15]);
model.geom('geom1').run('r8');
model.geom('geom1').create('dif1', 'Difference');
model.geom('geom1').feature('dif1').selection('input').set({'r6'});
model.geom('geom1').feature('dif1').selection('input2').set({'r7' 'r8'});
model.geom('geom1').run('dif1');
model.geom('geom1').create('fil1', 'Fillet');
model.geom('geom1').feature('fil1').selection('point').set('dif1', [3 4 5 6]);
model.geom('geom1').feature('fil1').set('radius', 0.075);
model.geom('geom1').run('fil1');
model.geom('geom1').create('r9', 'Rectangle');
model.geom('geom1').feature('r9').set('size', [0.55 0.2]);
model.geom('geom1').feature('r9').set('pos', [-0.5 -0.2]);
model.geom('geom1').run('r9');
model.geom('geom1').create('fil2', 'Fillet');
model.geom('geom1').feature('fil2').selection('point').set('r9', 2);
model.geom('geom1').feature('fil2').set('radius', 0.08);
model.geom('geom1').run('fil2');
model.geom('geom1').create('r10', 'Rectangle');
model.geom('geom1').feature('r10').set('size', [0.45 0.2]);
model.geom('geom1').feature('r10').set('pos', [0.85 -0.2]);
model.geom('geom1').run('r10');
model.geom('geom1').create('r11', 'Rectangle');
model.geom('geom1').feature('r11').set('size', [0.7 0.1]);
model.geom('geom1').feature('r11').set('pos', [0.6 -0.1]);
model.geom('geom1').run('r11');
model.geom('geom1').create('fil3', 'Fillet');
model.geom('geom1').feature('fil3').selection('point').set('r10', 1);
model.geom('geom1').feature('fil3').selection('point').set('r11', 1);
model.geom('geom1').feature('fil3').set('radius', 0.08);
model.geom('geom1').run('fil3');
model.geom('geom1').create('pt1', 'Point');
model.geom('geom1').feature('pt1').setIndex('p', -0.5, 0);
model.geom('geom1').feature('pt1').setIndex('p', -0.1, 1);
model.geom('geom1').runPre('fin');

model.title([]);

model.description('');

model.label('eeprom_geom_sequence.mph');

model.modelNode.label('Components');

out = model;
