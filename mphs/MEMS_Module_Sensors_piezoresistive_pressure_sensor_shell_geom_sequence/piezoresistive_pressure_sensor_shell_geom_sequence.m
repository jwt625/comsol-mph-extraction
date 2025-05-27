function out = model
%
% piezoresistive_pressure_sensor_shell_geom_sequence.m
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

model.geom('geom1').lengthUnit([native2unicode(hex2dec({'00' 'b5'}), 'unicode') 'm']);
model.geom('geom1').create('wp1', 'WorkPlane');
model.geom('geom1').feature('wp1').set('unite', true);
model.geom('geom1').feature('wp1').geom.create('sq1', 'Square');
model.geom('geom1').feature('wp1').geom.feature('sq1').set('size', 1200);
model.geom('geom1').feature('wp1').geom.feature('sq1').set('base', 'center');
model.geom('geom1').feature('wp1').geom.feature('sq1').set('pos', [0 478]);
model.geom('geom1').feature('wp1').geom.feature('sq1').setIndex('layer', 100, 0);
model.geom('geom1').feature('wp1').geom.feature('sq1').set('layerleft', true);
model.geom('geom1').feature('wp1').geom.feature('sq1').set('layerright', true);
model.geom('geom1').feature('wp1').geom.feature('sq1').set('layertop', true);
model.geom('geom1').feature('wp1').geom.run('sq1');
model.geom('geom1').feature('wp1').geom.create('sq2', 'Square');
model.geom('geom1').feature('wp1').geom.feature('sq2').set('size', 22.6);
model.geom('geom1').feature('wp1').geom.feature('sq2').set('base', 'center');
model.geom('geom1').feature('wp1').geom.run('sq2');
model.geom('geom1').feature('wp1').geom.create('r1', 'Rectangle');
model.geom('geom1').feature('wp1').geom.feature('r1').set('size', [52.5 10]);
model.geom('geom1').feature('wp1').geom.feature('r1').set('base', 'center');
model.geom('geom1').feature('wp1').geom.feature('r1').set('rot', 45);
model.geom('geom1').feature('wp1').geom.feature('r1').setIndex('layer', 6.25, 0);
model.geom('geom1').feature('wp1').geom.feature('r1').set('layerright', true);
model.geom('geom1').feature('wp1').geom.feature('r1').set('layerleft', true);
model.geom('geom1').feature('wp1').geom.feature('r1').set('layerbottom', false);
model.geom('geom1').feature('wp1').geom.feature.duplicate('r2', 'r1');
model.geom('geom1').feature('wp1').geom.feature('r2').set('size', [62.5 20]);
model.geom('geom1').feature('wp1').geom.feature('r2').set('rot', -45);
model.geom('geom1').feature('wp1').geom.feature('r2').setIndex('layer', 11.25, 0);
model.geom('geom1').feature('wp1').geom.run('r2');
model.geom('geom1').feature('wp1').geom.create('r3', 'Rectangle');
model.geom('geom1').feature('wp1').geom.feature('r3').set('size', [210 140]);
model.geom('geom1').feature('wp1').geom.feature('r3').set('base', 'center');
model.geom('geom1').feature('wp1').geom.feature('r3').set('pos', [0 -15]);
model.geom('geom1').feature('wp1').geom.run('r3');
model.geom('geom1').feature('wp1').geom.create('r4', 'Rectangle');
model.geom('geom1').feature('wp1').geom.feature('r4').set('size', [40 50]);
model.geom('geom1').feature('wp1').geom.feature('r4').set('pos', [-105 -35]);
model.geom('geom1').feature('wp1').geom.run('r4');
model.geom('geom1').feature('wp1').geom.create('r5', 'Rectangle');
model.geom('geom1').feature('wp1').geom.feature('r5').set('size', [90 40]);
model.geom('geom1').feature('wp1').geom.feature('r5').set('pos', [-105 15]);
model.geom('geom1').feature('wp1').geom.run('r5');
model.geom('geom1').feature('wp1').geom.create('r6', 'Rectangle');
model.geom('geom1').feature('wp1').geom.feature('r6').set('size', [90 40]);
model.geom('geom1').feature('wp1').geom.feature('r6').set('pos', [-105 -85]);
model.geom('geom1').feature('wp1').geom.run('r6');
model.geom('geom1').feature('wp1').geom.create('r7', 'Rectangle');
model.geom('geom1').feature('wp1').geom.feature('r7').set('size', [40 30]);
model.geom('geom1').feature('wp1').geom.feature('r7').set('pos', [-55 -45]);
model.geom('geom1').feature('wp1').geom.run('r7');
model.geom('geom1').feature('wp1').geom.create('mir1', 'Mirror');
model.geom('geom1').feature('wp1').geom.feature('mir1').selection('input').set({'r4' 'r5' 'r6' 'r7'});
model.geom('geom1').feature('wp1').geom.feature('mir1').set('keep', true);
model.geom('geom1').run('fin');
model.geom('geom1').create('cmf1', 'CompositeFaces');
model.geom('geom1').feature('cmf1').selection('input').set('fin', [19 20 26 27 28 29 30 31 32 33 34 35 38]);
model.geom('geom1').run('cmf1');
model.geom('geom1').create('cmf2', 'CompositeFaces');
model.geom('geom1').feature('cmf2').selection('input').set('cmf1', [11 14 15 16 17 18 25 27 32 33 34 35]);
model.geom('geom1').run('cmf2');
model.geom('geom1').create('ige1', 'IgnoreEdges');
model.geom('geom1').feature('ige1').selection('input').set('cmf2', [24 94]);
model.geom('geom1').feature('ige1').set('ignorevtx', false);
model.geom('geom1').run('ige1');
model.geom('geom1').create('cmf3', 'CompositeFaces');
model.geom('geom1').feature('cmf3').selection('input').set('ige1', [7 12 15 17 21 24 25 26]);
model.geom('geom1').run('cmf3');
model.geom('geom1').create('ige2', 'IgnoreEdges');
model.geom('geom1').feature('ige2').selection('input').set('cmf3', [4 6 8 12 84 87 88 89]);
model.geom('geom1').run('ige2');
model.geom('geom1').create('sel1', 'ExplicitSelection');
model.geom('geom1').feature('sel1').label('Piezoresistor');
model.geom('geom1').feature('sel1').selection('selection').init(2);
model.geom('geom1').feature('sel1').selection('selection').set('ige2', 9);
model.geom('geom1').run('sel1');
model.geom('geom1').create('sel2', 'ExplicitSelection');
model.geom('geom1').feature('sel2').label('Connections');
model.geom('geom1').feature('sel2').selection('selection').init(2);
model.geom('geom1').feature('sel2').selection('selection').set('ige2', [3 5 6 8 13 14 15 18]);
model.geom('geom1').run('sel2');
model.geom('geom1').create('boxsel1', 'BoxSelection');
model.geom('geom1').feature('boxsel1').label('Membrane');
model.geom('geom1').feature('boxsel1').set('entitydim', 2);
model.geom('geom1').feature('boxsel1').set('xmin', -501);
model.geom('geom1').feature('boxsel1').set('xmax', 501);
model.geom('geom1').feature('boxsel1').set('ymin', -30);
model.geom('geom1').feature('boxsel1').set('ymax', 1000);
model.geom('geom1').feature('boxsel1').set('condition', 'inside');
model.geom('geom1').run('boxsel1');
model.geom('geom1').create('unisel1', 'UnionSelection');
model.geom('geom1').feature('unisel1').label('Model Boundaries');
model.geom('geom1').feature('unisel1').set('entitydim', 2);
model.geom('geom1').feature('unisel1').set('input', {'sel2' 'boxsel1'});
model.geom('geom1').run('unisel1');
model.geom('geom1').create('unisel2', 'UnionSelection');
model.geom('geom1').feature('unisel2').label('Electric currents');
model.geom('geom1').feature('unisel2').set('entitydim', 2);
model.geom('geom1').feature('unisel2').set('input', {'sel1' 'sel2'});
model.geom('geom1').run('unisel2');
model.geom('geom1').create('adjsel1', 'AdjacentSelection');
model.geom('geom1').feature('adjsel1').label('Fixed Edges');
model.geom('geom1').feature('adjsel1').set('entitydim', 2);
model.geom('geom1').feature('adjsel1').set('input', {'boxsel1'});
model.geom('geom1').feature('adjsel1').set('outputdim', 1);
model.geom('geom1').run('adjsel1');
model.geom('geom1').create('difsel1', 'DifferenceSelection');
model.geom('geom1').feature('difsel1').label('Fixed Boundaries');
model.geom('geom1').feature('difsel1').set('entitydim', 2);
model.geom('geom1').feature('difsel1').set('add', {'unisel1'});
model.geom('geom1').feature('difsel1').set('subtract', {'boxsel1'});

model.title([]);

model.description('');

model.label('piezoresistive_pressure_sensor_shell_geom_sequence.mph');

model.modelNode.label('Components');

out = model;
