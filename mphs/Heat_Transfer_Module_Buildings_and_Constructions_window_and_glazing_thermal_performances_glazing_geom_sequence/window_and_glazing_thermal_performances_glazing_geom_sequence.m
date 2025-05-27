function out = model
%
% window_and_glazing_thermal_performances_glazing_geom_sequence.m
%
% Model exported on May 26 2025, 21:28 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/Heat_Transfer_Module/Buildings_and_Constructions');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 2);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.geom('geom1').lengthUnit('mm');
model.geom('geom1').create('r1', 'Rectangle');
model.geom('geom1').feature('r1').set('size', [84 83]);
model.geom('geom1').feature('r1').set('pos', [26 0]);
model.geom('geom1').run('r1');
model.geom('geom1').create('r2', 'Rectangle');
model.geom('geom1').feature('r2').set('size', [26 66]);
model.geom('geom1').run('r2');
model.geom('geom1').create('pare1', 'PartitionEdges');
model.geom('geom1').feature('pare1').selection('edge').set('r2', 3);
model.geom('geom1').feature('pare1').setIndex('param', '9/26', 0);
model.geom('geom1').run('pare1');
model.geom('geom1').create('r3', 'Rectangle');
model.geom('geom1').feature('r3').set('size', [16 3]);
model.geom('geom1').feature('r3').set('pos', [26 66]);
model.geom('geom1').selection.create('csel1', 'CumulativeSelection');
model.geom('geom1').selection('csel1').label('EPDM');
model.geom('geom1').feature('r3').set('contributeto', 'csel1');
model.geom('geom1').run('r3');
model.geom('geom1').create('r4', 'Rectangle');
model.geom('geom1').feature('r4').label('Unventilated Cavity 1');
model.geom('geom1').feature('r4').set('size', [6 54]);
model.geom('geom1').feature('r4').set('pos', [42 15]);
model.geom('geom1').feature('r4').set('selresult', true);
model.geom('geom1').run('r4');
model.geom('geom1').create('r5', 'Rectangle');
model.geom('geom1').feature('r5').set('size', [15 3]);
model.geom('geom1').feature('r5').set('pos', [48 15]);
model.geom('geom1').feature('r5').set('contributeto', 'csel1');
model.geom('geom1').run('r5');
model.geom('geom1').create('r6', 'Rectangle');
model.geom('geom1').feature('r6').label('Slightly Ventilated Cavity');
model.geom('geom1').feature('r6').set('size', [5 18]);
model.geom('geom1').feature('r6').set('pos', [63 0]);
model.geom('geom1').feature('r6').set('selresult', true);
model.geom('geom1').run('r6');
model.geom('geom1').create('r7', 'Rectangle');
model.geom('geom1').feature('r7').set('size', [15 3]);
model.geom('geom1').feature('r7').set('pos', [95 46]);
model.geom('geom1').feature('r7').set('contributeto', 'csel1');
model.geom('geom1').run('r7');
model.geom('geom1').create('r8', 'Rectangle');
model.geom('geom1').feature('r8').label('Unventilated Cavity 2');
model.geom('geom1').feature('r8').set('size', [5 34]);
model.geom('geom1').feature('r8').set('pos', [90 15]);
model.geom('geom1').feature('r8').set('selresult', true);
model.geom('geom1').run('r8');
model.geom('geom1').create('r9', 'Rectangle');
model.geom('geom1').feature('r9').set('size', [15 3]);
model.geom('geom1').feature('r9').set('pos', [95 15]);
model.geom('geom1').feature('r9').set('contributeto', 'csel1');
model.geom('geom1').run('r9');
model.geom('geom1').create('r10', 'Rectangle');
model.geom('geom1').feature('r10').set('size', [205 28]);
model.geom('geom1').feature('r10').set('pos', [95 18]);
model.geom('geom1').feature('r10').setIndex('layername', 'Layer 1', 0);
model.geom('geom1').feature('r10').setIndex('layer', 4, 0);
model.geom('geom1').feature('r10').set('layertop', true);
model.geom('geom1').run('r10');
model.geom('geom1').create('pare2', 'PartitionEdges');
model.geom('geom1').feature('pare2').selection('edge').set('r10', 7);
model.geom('geom1').feature('pare2').setIndex('param', '45/205', 0);
model.geom('geom1').run('pare2');
model.geom('geom1').create('r11', 'Rectangle');
model.geom('geom1').feature('r11').set('size', [10 20]);
model.geom('geom1').feature('r11').set('pos', [98 22]);
model.geom('geom1').run('r11');
model.geom('geom1').create('r12', 'Rectangle');
model.geom('geom1').feature('r12').label('Silica Gel');
model.geom('geom1').feature('r12').set('selresult', true);
model.geom('geom1').feature('r12').set('size', [9 19]);
model.geom('geom1').feature('r12').set('pos', [98.5 22.5]);
model.geom('geom1').run('r12');
model.geom('geom1').create('r13', 'Rectangle');
model.geom('geom1').feature('r13').label('Polyamide');
model.geom('geom1').feature('r13').set('size', [0.5 18]);
model.geom('geom1').feature('r13').set('pos', [98 23]);
model.geom('geom1').feature('r13').set('selresult', true);
model.geom('geom1').run('fin');
model.geom('geom1').create('ige1', 'IgnoreEdges');
model.geom('geom1').feature('ige1').selection('input').set('fin', [5 58 60 62]);
model.geom('geom1').run('ige1');
model.geom('geom1').create('adjsel1', 'AdjacentSelection');
model.geom('geom1').feature('adjsel1').label('Unventilated Cavity 1, Boundaries');
model.geom('geom1').feature('adjsel1').set('input', {'r4'});
model.geom('geom1').run('adjsel1');
model.geom('geom1').create('adjsel2', 'AdjacentSelection');
model.geom('geom1').feature('adjsel2').label('Unventilated Cavity 2, Boundaries');
model.geom('geom1').feature('adjsel2').set('input', {'r8'});
model.geom('geom1').run('adjsel2');
model.geom('geom1').create('sel1', 'ExplicitSelection');
model.geom('geom1').feature('sel1').label('Slightly Ventilated Cavity, Boundaries');
model.geom('geom1').feature('sel1').selection('selection').init(1);
model.geom('geom1').feature('sel1').selection('selection').set('ige1', [18 20 21 22]);
model.geom('geom1').run('sel1');
model.geom('geom1').create('sel2', 'ExplicitSelection');
model.geom('geom1').feature('sel2').label('Interior Side (Corner Area)');
model.geom('geom1').feature('sel2').selection('selection').init(1);
model.geom('geom1').feature('sel2').selection('selection').set('ige1', [4 5 7 57 58 59]);
model.geom('geom1').run('sel2');
model.geom('geom1').create('sel3', 'ExplicitSelection');
model.geom('geom1').feature('sel3').label('Interior Side (Flat Area)');
model.geom('geom1').feature('sel3').selection('selection').init(1);
model.geom('geom1').feature('sel3').selection('selection').set('ige1', [3 9 60]);
model.geom('geom1').run('sel3');
model.geom('geom1').create('unisel1', 'UnionSelection');
model.geom('geom1').feature('unisel1').label('Interior Side');
model.geom('geom1').feature('unisel1').set('entitydim', 1);
model.geom('geom1').feature('unisel1').set('input', {'sel2' 'sel3'});
model.geom('geom1').run('unisel1');
model.geom('geom1').create('sel4', 'ExplicitSelection');
model.geom('geom1').feature('sel4').label('Exterior Side');
model.geom('geom1').feature('sel4').selection('selection').init(1);
model.geom('geom1').feature('sel4').selection('selection').set('ige1', [2 19 23 54 55 56]);
model.geom('geom1').run('sel4');
model.geom('geom1').create('sel5', 'ExplicitSelection');
model.geom('geom1').feature('sel5').label('Glass');
model.geom('geom1').feature('sel5').selection('selection').set('ige1', [9 11]);
model.geom('geom1').run('sel5');
model.geom('geom1').create('sel6', 'ExplicitSelection');
model.geom('geom1').feature('sel6').label('Filling Gas');
model.geom('geom1').feature('sel6').selection('selection').set('ige1', 16);
model.geom('geom1').run('sel6');
model.geom('geom1').create('sel7', 'ExplicitSelection');
model.geom('geom1').feature('sel7').label('Aluminum');
model.geom('geom1').feature('sel7').selection('selection').set('ige1', 13);
model.geom('geom1').run('sel7');
model.geom('geom1').create('sel8', 'ExplicitSelection');
model.geom('geom1').feature('sel8').label('Polysulfide');
model.geom('geom1').feature('sel8').selection('selection').set('ige1', 10);

model.title([]);

model.description('');

model.label('window_and_glazing_thermal_performances_glazing_geom_sequence.mph');

model.modelNode.label('Components');

out = model;
