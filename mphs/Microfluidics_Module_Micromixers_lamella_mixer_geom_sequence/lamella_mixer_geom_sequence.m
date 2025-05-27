function out = model
%
% lamella_mixer_geom_sequence.m
%
% Model exported on May 26 2025, 21:30 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/Microfluidics_Module/Micromixers');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 3);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.geom('geom1').lengthUnit([native2unicode(hex2dec({'00' 'b5'}), 'unicode') 'm']);
model.geom('geom1').create('blk1', 'Block');
model.geom('geom1').feature('blk1').set('size', [80 200 30]);
model.geom('geom1').feature('blk1').set('pos', [0 -200 0]);
model.geom('geom1').run('blk1');
model.geom('geom1').create('wp1', 'WorkPlane');
model.geom('geom1').feature('wp1').set('unite', true);
model.geom('geom1').feature('wp1').geom.create('c1', 'Circle');
model.geom('geom1').feature('wp1').geom.feature('c1').set('r', 320);
model.geom('geom1').feature('wp1').geom.feature('c1').set('angle', 90);
model.geom('geom1').feature('wp1').geom.feature('c1').set('pos', [320 0]);
model.geom('geom1').feature('wp1').geom.feature('c1').set('rot', 90);
model.geom('geom1').feature('wp1').geom.feature('c1').setIndex('layername', 'Layer 1', 0);
model.geom('geom1').feature('wp1').geom.feature('c1').setIndex('layer', 20, 0);
model.geom('geom1').feature('wp1').geom.feature('c1').setIndex('layername', 'Layer 2', 1);
model.geom('geom1').feature('wp1').geom.feature('c1').setIndex('layer', 10, 1);
model.geom('geom1').feature('wp1').geom.feature('c1').setIndex('layername', 'Layer 3', 2);
model.geom('geom1').feature('wp1').geom.feature('c1').setIndex('layer', 20, 2);
model.geom('geom1').feature('wp1').geom.feature('c1').setIndex('layername', 'Layer 4', 3);
model.geom('geom1').feature('wp1').geom.feature('c1').setIndex('layer', 10, 3);
model.geom('geom1').feature('wp1').geom.feature('c1').setIndex('layername', 'Layer 5', 4);
model.geom('geom1').feature('wp1').geom.feature('c1').setIndex('layer', 20, 4);
model.geom('geom1').feature('wp1').geom.run('c1');
model.geom('geom1').feature('wp1').geom.create('r1', 'Rectangle');
model.geom('geom1').feature('wp1').geom.feature('r1').set('size', [320 200]);
model.geom('geom1').feature('wp1').geom.run('r1');
model.geom('geom1').feature('wp1').geom.create('int1', 'Intersection');
model.geom('geom1').feature('wp1').geom.feature('int1').selection('input').set({'c1' 'r1'});
model.geom('geom1').feature('wp1').geom.run('int1');
model.geom('geom1').feature('wp1').geom.feature.create('del1', 'Delete');
model.geom('geom1').feature('wp1').geom.feature('del1').selection('input').init;
model.geom('geom1').feature('wp1').geom.feature('del1').selection('input').init(2);
model.geom('geom1').feature('wp1').geom.feature('del1').selection('input').set('int1', [2 4 6]);
model.geom('geom1').run('wp1');
model.geom('geom1').feature.create('ext1', 'Extrude');
model.geom('geom1').feature('ext1').set('workplane', 'wp1');
model.geom('geom1').feature('ext1').selection('input').set({'wp1'});
model.geom('geom1').feature('ext1').setIndex('distance', 10, 0);
model.geom('geom1').run('ext1');
model.geom('geom1').create('copy1', 'Copy');
model.geom('geom1').feature('copy1').selection('input').set({'ext1'});
model.geom('geom1').feature('copy1').set('displz', 20);
model.geom('geom1').run('copy1');
model.geom('geom1').create('mir1', 'Mirror');
model.geom('geom1').feature('mir1').selection('input').set({'copy1'});
model.geom('geom1').feature('mir1').set('pos', [40 0 0]);
model.geom('geom1').feature('mir1').set('axis', [1 0 0]);
model.geom('geom1').run('mir1');
model.geom('geom1').create('uni1', 'Union');
model.geom('geom1').feature('uni1').selection('input').set({'blk1' 'ext1' 'mir1'});
model.geom('geom1').feature('uni1').set('intbnd', false);
model.geom('geom1').run('fin');
model.geom('geom1').create('sel1', 'ExplicitSelection');
model.geom('geom1').feature('sel1').selection('selection').set('fin', 1);
model.geom('geom1').feature('sel1').label('Geometry');
model.geom('geom1').run('sel1');
model.geom('geom1').create('adjsel1', 'AdjacentSelection');
model.geom('geom1').feature('adjsel1').label('All Walls');
model.geom('geom1').feature('adjsel1').set('input', {'sel1'});
model.geom('geom1').run('adjsel1');
model.geom('geom1').create('sel2', 'ExplicitSelection');
model.geom('geom1').feature('sel2').label('Outlet');
model.geom('geom1').feature('sel2').selection('selection').init(2);
model.geom('geom1').feature('sel2').selection('selection').set('fin', 16);
model.geom('geom1').run('sel2');
model.geom('geom1').create('sel3', 'ExplicitSelection');
model.geom('geom1').feature('sel3').label('Concentration 1');
model.geom('geom1').feature('sel3').selection('selection').init(2);
model.geom('geom1').feature('sel3').selection('selection').set('fin', [1 6 11]);
model.geom('geom1').run('sel3');
model.geom('geom1').create('sel4', 'ExplicitSelection');
model.geom('geom1').feature('sel4').label('Concentration 2');
model.geom('geom1').feature('sel4').selection('selection').init(2);
model.geom('geom1').feature('sel4').selection('selection').set('fin', [32 35 36]);
model.geom('geom1').run('sel4');
model.geom('geom1').create('unisel1', 'UnionSelection');
model.geom('geom1').feature('unisel1').label('Inlet');
model.geom('geom1').feature('unisel1').set('entitydim', 2);
model.geom('geom1').feature('unisel1').set('input', {'sel3' 'sel4'});
model.geom('geom1').run('unisel1');
model.geom('geom1').create('sel5', 'ExplicitSelection');
model.geom('geom1').feature('sel5').label('Symmetry');
model.geom('geom1').feature('sel5').selection('selection').init(2);
model.geom('geom1').feature('sel5').set('groupcontang', true);
model.geom('geom1').feature('sel5').selection('selection').add('fin', [4 9 14 17 18 20 26 30]);
model.geom('geom1').run('sel5');
model.geom('geom1').create('difsel1', 'DifferenceSelection');
model.geom('geom1').feature('difsel1').label('Exterior Walls');
model.geom('geom1').feature('difsel1').set('entitydim', 2);
model.geom('geom1').feature('difsel1').set('add', {'adjsel1'});
model.geom('geom1').feature('difsel1').set('subtract', {'sel2' 'unisel1' 'sel5'});

model.title([]);

model.description('');

model.label('lamella_mixer_geom_sequence.mph');

model.modelNode.label('Components');

out = model;
