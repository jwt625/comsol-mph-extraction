function out = model
%
% piezoresistive_pressure_sensor_geom_sequence.m
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
model.geom('geom1').feature('wp1').geom.feature('r4').set('size', [40 90]);
model.geom('geom1').feature('wp1').geom.feature('r4').set('pos', [-105 -35]);
model.geom('geom1').feature('wp1').geom.run('r4');
model.geom('geom1').feature('wp1').geom.create('r5', 'Rectangle');
model.geom('geom1').feature('wp1').geom.feature('r5').set('size', [50 40]);
model.geom('geom1').feature('wp1').geom.feature('r5').set('pos', [-65 15]);
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
model.geom('geom1').run('wp1');
model.geom('geom1').feature.create('ext1', 'Extrude');
model.geom('geom1').feature('ext1').set('workplane', 'wp1');
model.geom('geom1').feature('ext1').selection('input').set({'wp1'});
model.geom('geom1').feature('ext1').setIndex('distance', 20, 0);
model.geom('geom1').feature('ext1').set('reverse', true);
model.geom('geom1').run('ext1');
model.geom('geom1').create('wp2', 'WorkPlane');
model.geom('geom1').feature('wp2').set('unite', true);
model.geom('geom1').feature('wp2').set('planetype', 'faceparallel');
model.geom('geom1').feature('wp2').selection('face').set('ext1', 50);
model.geom('geom1').run('fin');
model.geom('geom1').create('cmd1', 'CompositeDomains');
model.geom('geom1').feature('cmd1').selection('input').set('fin', [10 12 14 15 16 17 18 36 39 44 45 46 47 50]);
model.geom('geom1').run('cmd1');
model.geom('geom1').create('cmd2', 'CompositeDomains');
model.geom('geom1').feature('cmd2').selection('input').set('cmd1', [7 12 16 18 32 36 37 38]);
model.geom('geom1').run('cmd2');
model.geom('geom1').create('cmd3', 'CompositeDomains');
model.geom('geom1').feature('cmd3').selection('input').set('cmd2', [13 14 18 19 20 21 22 23 24 25 26 27 30]);
model.geom('geom1').run('cmd3');
model.geom('geom1').create('cmd4', 'CompositeDomains');
model.geom('geom1').feature('cmd4').selection('input').set('cmd3', [1 2 3 4 6 23 24 25]);
model.geom('geom1').run('cmd4');
model.geom('geom1').create('parf1', 'PartitionFaces');
model.geom('geom1').feature('parf1').selection('face').set('cmd4', [23 109]);
model.geom('geom1').feature('parf1').set('partitionwith', 'workplane');
model.geom('geom1').run('parf1');
model.geom('geom1').create('sel1', 'ExplicitSelection');
model.geom('geom1').feature('sel1').label('Piezoresistor');
model.geom('geom1').feature('sel1').selection('selection').init(2);
model.geom('geom1').feature('sel1').selection('selection').set('parf1', 46);
model.geom('geom1').run('sel1');
model.geom('geom1').create('sel2', 'ExplicitSelection');
model.geom('geom1').feature('sel2').label('Connections');
model.geom('geom1').feature('sel2').selection('selection').init(2);
model.geom('geom1').feature('sel2').selection('selection').set('parf1', [14 26 39 73 77 81]);
model.geom('geom1').run('sel2');
model.geom('geom1').create('boxsel1', 'BoxSelection');
model.geom('geom1').feature('boxsel1').label('Membrane (Lower Surface)');
model.geom('geom1').feature('boxsel1').set('entitydim', 2);
model.geom('geom1').feature('boxsel1').set('xmin', -501);
model.geom('geom1').feature('boxsel1').set('xmax', 501);
model.geom('geom1').feature('boxsel1').set('ymin', -30);
model.geom('geom1').feature('boxsel1').set('ymax', 1000);
model.geom('geom1').feature('boxsel1').set('zmax', -1);
model.geom('geom1').feature('boxsel1').set('condition', 'inside');
model.geom('geom1').feature.duplicate('boxsel2', 'boxsel1');
model.geom('geom1').feature('boxsel2').label('Membrane (Upper Surface)');
model.geom('geom1').feature('boxsel2').set('zmin', -1);
model.geom('geom1').feature('boxsel2').set('zmax', 'inf');
model.geom('geom1').run('boxsel2');
model.geom('geom1').create('sel3', 'ExplicitSelection');
model.geom('geom1').feature('sel3').label('Lower Surface');
model.geom('geom1').feature('sel3').selection('selection').init(2);
model.geom('geom1').feature('sel3').set('groupcontang', true);
model.geom('geom1').feature('sel3').selection('selection').add('parf1', [3 8 13 17 21 25 32 38 45 51 56 61 72 76 80 84 97 103]);
model.geom('geom1').run('sel3');
model.geom('geom1').create('sel4', 'ExplicitSelection');
model.geom('geom1').feature('sel4').label('Upper Surface');
model.geom('geom1').feature('sel4').selection('selection').init(2);
model.geom('geom1').feature('sel4').set('groupcontang', true);
model.geom('geom1').feature('sel4').selection('selection').add('parf1', [4 9 14 18 22 26 33 39 46 52 57 62 73 77 81 85 98 104]);
model.geom('geom1').run('sel4');
model.geom('geom1').create('difsel1', 'DifferenceSelection');
model.geom('geom1').feature('difsel1').label('Fixed');
model.geom('geom1').feature('difsel1').set('entitydim', 2);
model.geom('geom1').feature('difsel1').set('add', {'sel3'});
model.geom('geom1').feature('difsel1').set('subtract', {'boxsel1'});
model.geom('geom1').run('difsel1');
model.geom('geom1').create('unisel1', 'UnionSelection');
model.geom('geom1').feature('unisel1').label('Electric currents');
model.geom('geom1').feature('unisel1').set('entitydim', 2);
model.geom('geom1').feature('unisel1').set('input', {'sel1' 'sel2'});

model.title([]);

model.description('');

model.label('piezoresistive_pressure_sensor_geom_sequence.mph');

model.modelNode.label('Components');

out = model;
