function out = model
%
% capacitive_pressure_sensor_geom_sequence.m
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

model.geom('geom1').lengthUnit('mm');
model.geom('geom1').create('blk1', 'Block');
model.geom('geom1').feature('blk1').set('size', [1.2 1.2 1.51]);
model.geom('geom1').feature('blk1').set('pos', [0 0 -1.1]);
model.geom('geom1').feature('blk1').setIndex('layer', 0.7, 0);
model.geom('geom1').feature('blk1').setIndex('layer', 0.397, 1);
model.geom('geom1').feature('blk1').setIndex('layer', 0.003, 2);
model.geom('geom1').feature('blk1').setIndex('layer', 0.01, 3);
model.geom('geom1').run('blk1');
model.geom('geom1').create('blk2', 'Block');
model.geom('geom1').feature('blk2').set('size', [0.5 0.5 1.51]);
model.geom('geom1').feature('blk2').set('pos', [0 0 -1.1]);
model.geom('geom1').run('blk2');
model.geom('geom1').create('pard1', 'PartitionDomains');
model.geom('geom1').feature('pard1').selection('domain').set('blk1', [1 2 3 4]);
model.geom('geom1').feature('pard1').set('partitionwith', 'objects');
model.geom('geom1').feature('pard1').selection('object').set({'blk2'});
model.geom('geom1').run('pard1');
model.geom('geom1').create('hex1', 'Hexahedron');
model.geom('geom1').feature('hex1').setIndex('p', 0.5, 0, 1);
model.geom('geom1').feature('hex1').setIndex('p', 0.5, 0, 2);
model.geom('geom1').feature('hex1').setIndex('p', 0, 0, 3);
model.geom('geom1').feature('hex1').setIndex('p', 0.78322, 0, 5);
model.geom('geom1').feature('hex1').setIndex('p', 0.78322, 0, 6);
model.geom('geom1').feature('hex1').setIndex('p', 0, 0, 7);
model.geom('geom1').feature('hex1').setIndex('p', 0, 1, 1);
model.geom('geom1').feature('hex1').setIndex('p', 0.5, 1, 2);
model.geom('geom1').feature('hex1').setIndex('p', 0.5, 1, 3);
model.geom('geom1').feature('hex1').setIndex('p', 0, 1, 5);
model.geom('geom1').feature('hex1').setIndex('p', 0.78322, 1, 6);
model.geom('geom1').feature('hex1').setIndex('p', 0.78322, 1, 7);
model.geom('geom1').feature('hex1').setIndex('p', 0.01, 2, 0);
model.geom('geom1').feature('hex1').setIndex('p', 0.01, 2, 1);
model.geom('geom1').feature('hex1').setIndex('p', 0.01, 2, 2);
model.geom('geom1').feature('hex1').setIndex('p', 0.01, 2, 3);
model.geom('geom1').feature('hex1').setIndex('p', 0.41, 2, 4);
model.geom('geom1').feature('hex1').setIndex('p', 0.41, 2, 5);
model.geom('geom1').feature('hex1').setIndex('p', 0.41, 2, 6);
model.geom('geom1').feature('hex1').setIndex('p', 0.41, 2, 7);
model.geom('geom1').run('hex1');
model.geom('geom1').create('dif1', 'Difference');
model.geom('geom1').feature('dif1').selection('input').set({'pard1'});
model.geom('geom1').feature('dif1').selection('input2').set({'hex1'});
model.geom('geom1').run('dif1');
model.geom('geom1').create('cyl1', 'Cylinder');
model.geom('geom1').feature('cyl1').set('r', 3);
model.geom('geom1').feature('cyl1').set('h', 0.7);
model.geom('geom1').feature('cyl1').set('pos', [0 0 -1.1]);
model.geom('geom1').run('cyl1');
model.geom('geom1').create('pard2', 'PartitionDomains');
model.geom('geom1').feature('pard2').selection('domain').set('cyl1', 1);
model.geom('geom1').feature('pard2').set('partitionwith', 'extendedfaces');
model.geom('geom1').feature('pard2').selection('extendedface').set('dif1', [17 38]);
model.geom('geom1').run('pard2');
model.geom('geom1').feature.create('del1', 'Delete');
model.geom('geom1').feature('del1').selection('input').init(2);
model.geom('geom1').feature('del1').selection('input').init(3);
model.geom('geom1').feature('del1').selection('input').set('blk2', 1);
model.geom('geom1').feature('del1').selection('input').set('pard2', [1 2 3]);
model.geom('geom1').run('fin');
model.geom('geom1').create('sel1', 'ExplicitSelection');
model.geom('geom1').feature('sel1').label('YZ Symmetry Plane');
model.geom('geom1').feature('sel1').selection('selection').init(2);
model.geom('geom1').feature('sel1').set('groupcontang', true);
model.geom('geom1').feature('sel1').selection('selection').add('fin', [1 4 7 10 14 17 20 23 26 30]);
model.geom('geom1').run('sel1');
model.geom('geom1').create('sel2', 'ExplicitSelection');
model.geom('geom1').feature('sel2').label('XZ Symmetry Plane');
model.geom('geom1').feature('sel2').selection('selection').init(2);
model.geom('geom1').feature('sel2').set('groupcontang', true);
model.geom('geom1').feature('sel2').selection('selection').add('fin', [2 5 8 11 40 42 44 46 48 50]);
model.geom('geom1').run('sel2');
model.geom('geom1').create('boxsel1', 'BoxSelection');
model.geom('geom1').feature('boxsel1').label('Steel Base');
model.geom('geom1').feature('boxsel1').set('zmax', -0.1);
model.geom('geom1').feature('boxsel1').set('condition', 'inside');
model.geom('geom1').run('boxsel1');
model.geom('geom1').create('sel3', 'ExplicitSelection');
model.geom('geom1').feature('sel3').label('Cavity');
model.geom('geom1').feature('sel3').selection('selection').set('fin', 3);
model.geom('geom1').run('sel3');
model.geom('geom1').create('sel4', 'ExplicitSelection');
model.geom('geom1').feature('sel4').label('Geometry');
model.geom('geom1').feature('sel4').selection('selection').init;
model.geom('geom1').feature('sel4').selection('selection').set({'fin'});
model.geom('geom1').run('sel4');
model.geom('geom1').create('difsel1', 'DifferenceSelection');
model.geom('geom1').feature('difsel1').label('Linear Elastic');
model.geom('geom1').feature('difsel1').set('add', {'sel4'});
model.geom('geom1').feature('difsel1').set('subtract', {'sel3'});

model.title([]);

model.description('');

model.label('capacitive_pressure_sensor_geom_sequence.mph');

model.modelNode.label('Components');

out = model;
