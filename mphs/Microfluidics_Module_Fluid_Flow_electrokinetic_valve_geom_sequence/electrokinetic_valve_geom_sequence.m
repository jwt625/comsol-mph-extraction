function out = model
%
% electrokinetic_valve_geom_sequence.m
%
% Model exported on May 26 2025, 21:30 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/Microfluidics_Module/Fluid_Flow');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 3);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.geom('geom1').lengthUnit([native2unicode(hex2dec({'00' 'b5'}), 'unicode') 'm']);
model.geom('geom1').create('wp1', 'WorkPlane');
model.geom('geom1').feature('wp1').set('unite', true);
model.geom('geom1').feature('wp1').set('quickz', 120);
model.geom('geom1').feature('wp1').geom.create('sq1', 'Square');
model.geom('geom1').feature('wp1').geom.feature('sq1').set('size', 20);
model.geom('geom1').feature('wp1').geom.feature('sq1').set('selresult', true);
model.geom('geom1').feature('wp1').geom.run('sq1');
model.geom('geom1').feature('wp1').geom.create('fil1', 'Fillet');
model.geom('geom1').feature('wp1').geom.feature('fil1').selection('point').named('sq1');
model.geom('geom1').feature('wp1').geom.feature('fil1').set('radius', 4);
model.geom('geom1').run('wp1');
model.geom('geom1').feature.create('ext1', 'Extrude');
model.geom('geom1').feature('ext1').set('workplane', 'wp1');
model.geom('geom1').feature('ext1').selection('input').set({'wp1'});
model.geom('geom1').feature('ext1').setIndex('distance', 320, 0);
model.geom('geom1').feature('ext1').set('reverse', true);
model.geom('geom1').run('ext1');
model.geom('geom1').create('wp2', 'WorkPlane');
model.geom('geom1').feature('wp2').set('unite', true);
model.geom('geom1').feature('wp2').set('quickz', -100);
model.geom('geom1').feature('wp2').set('quickplane', 'yz');
model.geom('geom1').feature('wp2').set('quickx', -100);
model.geom('geom1').feature('wp2').geom.create('sq1', 'Square');
model.geom('geom1').feature('wp2').geom.feature('sq1').set('size', 20);
model.geom('geom1').feature('wp2').geom.feature('sq1').set('selresult', true);
model.geom('geom1').feature('wp2').geom.run('sq1');
model.geom('geom1').feature('wp2').geom.create('fil1', 'Fillet');
model.geom('geom1').feature('wp2').geom.feature('fil1').selection('point').named('sq1');
model.geom('geom1').feature('wp2').geom.feature('fil1').set('radius', 4);
model.geom('geom1').run('wp2');
model.geom('geom1').feature.create('ext2', 'Extrude');
model.geom('geom1').feature('ext2').set('workplane', 'wp2');
model.geom('geom1').feature('ext2').selection('input').set({'wp2'});
model.geom('geom1').feature('ext2').setIndex('distance', 340, 0);
model.geom('geom1').run('ext2');
model.geom('geom1').create('wp3', 'WorkPlane');
model.geom('geom1').feature('wp3').set('unite', true);
model.geom('geom1').feature('wp3').set('quickplane', 'yz');
model.geom('geom1').feature('wp3').set('quickx', -4);
model.geom('geom1').feature('wp3').geom.create('sq1', 'Square');
model.geom('geom1').feature('wp3').geom.feature('sq1').set('size', 4);
model.geom('geom1').feature('wp3').geom.run('sq1');
model.geom('geom1').feature('wp3').geom.create('c1', 'Circle');
model.geom('geom1').feature('wp3').geom.feature('c1').set('r', 4);
model.geom('geom1').feature('wp3').geom.feature('c1').set('pos', [4 4]);
model.geom('geom1').feature('wp3').geom.run('c1');
model.geom('geom1').feature('wp3').geom.create('int1', 'Intersection');
model.geom('geom1').feature('wp3').geom.feature('int1').selection('input').set({'c1' 'sq1'});
model.geom('geom1').feature('wp3').geom.run('int1');
model.geom('geom1').feature('wp3').geom.create('mir1', 'Mirror');
model.geom('geom1').feature('wp3').geom.feature('mir1').selection('input').set({'int1'});
model.geom('geom1').feature('wp3').geom.feature('mir1').set('pos', [10 0]);
model.geom('geom1').feature('wp3').geom.feature('mir1').set('keep', true);
model.geom('geom1').feature('wp3').geom.run('mir1');
model.geom('geom1').feature('wp3').geom.create('r1', 'Rectangle');
model.geom('geom1').feature('wp3').geom.feature('r1').set('size', [12 4]);
model.geom('geom1').feature('wp3').geom.feature('r1').set('pos', [4 0]);
model.geom('geom1').feature('wp3').geom.run('r1');
model.geom('geom1').feature('wp3').geom.create('r2', 'Rectangle');
model.geom('geom1').feature('wp3').geom.feature('r2').set('size', [20 6]);
model.geom('geom1').feature('wp3').geom.feature('r2').set('pos', [0 4]);
model.geom('geom1').feature('wp3').geom.run('r2');
model.geom('geom1').feature('wp3').geom.create('uni1', 'Union');
model.geom('geom1').feature('wp3').geom.feature('uni1').selection('input').set({'int1' 'mir1' 'r1' 'r2'});
model.geom('geom1').feature('wp3').geom.feature('uni1').set('intbnd', false);
model.geom('geom1').run('wp3');
model.geom('geom1').feature.create('rev1', 'Revolve');
model.geom('geom1').feature('rev1').set('workplane', 'wp3');
model.geom('geom1').feature('rev1').selection('input').set({'wp3'});
model.geom('geom1').feature('rev1').set('angtype', 'specang');
model.geom('geom1').feature('rev1').set('angle2', 90);
model.geom('geom1').feature('rev1').set('axistype', '3d');
model.geom('geom1').feature('rev1').set('pos3', [-4 0 -4]);
model.geom('geom1').run('rev1');
model.geom('geom1').create('mir1', 'Mirror');
model.geom('geom1').feature('mir1').selection('input').set({'rev1'});
model.geom('geom1').feature('mir1').set('pos', [10 0 0]);
model.geom('geom1').feature('mir1').set('keep', true);
model.geom('geom1').feature('mir1').set('axis', [1 0 0]);
model.geom('geom1').run('mir1');
model.geom('geom1').create('mir2', 'Mirror');
model.geom('geom1').feature('mir2').selection('input').set({'mir1' 'rev1'});
model.geom('geom1').feature('mir2').set('keep', true);
model.geom('geom1').feature('mir2').set('pos', [0 0 10]);
model.geom('geom1').run('mir2');
model.geom('geom1').create('uni1', 'Union');
model.geom('geom1').feature('uni1').selection('input').set({'ext1' 'ext2' 'mir1' 'mir2' 'rev1'});
model.geom('geom1').feature('uni1').set('intbnd', false);
model.geom('geom1').run('fin');
model.geom('geom1').create('cmf1', 'CompositeFaces');
model.geom('geom1').feature('cmf1').selection('input').set('fin', [10 12 13 14 16 35 36 37 38 39 48 49 52 53 56 57 61 63 64 65 66]);

model.view('view1').set('renderwireframe', true);

model.geom('geom1').feature('cmf1').selection('input').set('fin', [10 12 13 14 16 21 22 23 24 25 35 36 37 38 39 42 43 44 45 46 48 49 50 51 52 53 54 55 56 57 58 59 61 63 64 65 66 70 72 73 74 75]);
model.geom('geom1').run('cmf1');
model.geom('geom1').create('boxsel1', 'BoxSelection');
model.geom('geom1').feature('boxsel1').label('Sample inlet');
model.geom('geom1').feature('boxsel1').set('entitydim', 2);
model.geom('geom1').feature('boxsel1').set('xmax', -80);
model.geom('geom1').feature('boxsel1').set('condition', 'inside');
model.geom('geom1').run('boxsel1');
model.geom('geom1').create('boxsel2', 'BoxSelection');
model.geom('geom1').feature('boxsel2').label('Upper buffer inlet');
model.geom('geom1').feature('boxsel2').set('entitydim', 2);
model.geom('geom1').feature('boxsel2').set('zmin', 80);
model.geom('geom1').feature('boxsel2').set('condition', 'inside');
model.geom('geom1').run('boxsel2');
model.geom('geom1').create('boxsel3', 'BoxSelection');
model.geom('geom1').feature('boxsel3').label('Lower buffer inlet');
model.geom('geom1').feature('boxsel3').set('zmax', -110);
model.geom('geom1').feature('boxsel3').set('entitydim', 2);
model.geom('geom1').feature('boxsel3').set('condition', 'inside');
model.geom('geom1').run('boxsel3');
model.geom('geom1').create('boxsel4', 'BoxSelection');
model.geom('geom1').feature('boxsel4').label('Outlet');
model.geom('geom1').feature('boxsel4').set('xmin', 200);
model.geom('geom1').feature('boxsel4').set('entitydim', 2);
model.geom('geom1').feature('boxsel4').set('condition', 'inside');
model.geom('geom1').run('boxsel4');
model.geom('geom1').create('unisel1', 'UnionSelection');
model.geom('geom1').feature('unisel1').label('Buffer inlets');
model.geom('geom1').feature('unisel1').set('entitydim', 2);
model.geom('geom1').feature('unisel1').set('input', {'boxsel2' 'boxsel3'});
model.geom('geom1').run('unisel1');
model.geom('geom1').create('unisel2', 'UnionSelection');
model.geom('geom1').feature('unisel2').set('entitydim', 2);
model.geom('geom1').feature('unisel2').label('Fluid inlets');
model.geom('geom1').feature('unisel2').set('input', {'boxsel1' 'unisel1'});
model.geom('geom1').run('unisel2');
model.geom('geom1').create('unisel3', 'UnionSelection');
model.geom('geom1').feature('unisel3').label('Migration at inlets and outlets - Injection stage');
model.geom('geom1').feature('unisel3').set('entitydim', 2);
model.geom('geom1').feature('unisel3').set('input', {'boxsel4' 'unisel2'});
model.geom('geom1').run('unisel3');
model.geom('geom1').create('boxsel5', 'BoxSelection');
model.geom('geom1').feature('boxsel5').set('entitydim', 2);
model.geom('geom1').feature('boxsel5').set('groupcontang', true);
model.geom('geom1').feature('boxsel5').set('xmin', -5);
model.geom('geom1').feature('boxsel5').set('xmax', 25);
model.geom('geom1').feature('boxsel5').set('ymin', -5);
model.geom('geom1').feature('boxsel5').set('ymax', 25);
model.geom('geom1').feature('boxsel5').set('zmin', -25);
model.geom('geom1').feature('boxsel5').set('zmax', 25);
model.geom('geom1').feature('boxsel5').label('Exterior Walls');

model.title([]);

model.description('');

model.label('electrokinetic_valve_geom_sequence.mph');

model.modelNode.label('Components');

out = model;
