function out = model
%
% multiturn_coil_asymmetric_conductor_geom_sequence.m
%
% Model exported on May 26 2025, 21:25 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/ACDC_Module/Verifications');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 3);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.geom('geom1').lengthUnit('mm');
model.geom('geom1').create('blk1', 'Block');
model.geom('geom1').feature('blk1').set('size', [294 294 19]);
model.geom('geom1').run('blk1');
model.geom('geom1').create('blk2', 'Block');
model.geom('geom1').feature('blk2').set('size', [108 108 19]);
model.geom('geom1').feature('blk2').set('pos', [18 18 0]);
model.geom('geom1').run('blk2');
model.geom('geom1').create('dif1', 'Difference');
model.geom('geom1').feature('dif1').selection('input').set({'blk1'});
model.geom('geom1').feature('dif1').selection('input2').set({'blk2'});
model.geom('geom1').run('dif1');
model.geom('geom1').create('wp1', 'WorkPlane');
model.geom('geom1').feature('wp1').set('unite', true);
model.geom('geom1').feature('wp1').set('quickz', 49);
model.geom('geom1').feature('wp1').geom.create('sq1', 'Square');
model.geom('geom1').feature('wp1').geom.feature('sq1').set('size', 100);
model.geom('geom1').feature('wp1').geom.feature('sq1').set('pos', [94 0]);
model.geom('geom1').feature('wp1').geom.run('sq1');
model.geom('geom1').feature('wp1').geom.create('sq2', 'Square');
model.geom('geom1').feature('wp1').geom.feature('sq2').set('size', 75);
model.geom('geom1').feature('wp1').geom.feature('sq2').set('pos', [119 25]);
model.geom('geom1').feature('wp1').geom.run('sq2');
model.geom('geom1').feature('wp1').geom.create('dif1', 'Difference');
model.geom('geom1').feature('wp1').geom.feature('dif1').selection('input').set({'sq1'});
model.geom('geom1').feature('wp1').geom.feature('dif1').selection('input2').set({'sq2'});
model.geom('geom1').feature('wp1').geom.run('dif1');
model.geom('geom1').feature('wp1').geom.create('fil1', 'Fillet');
model.geom('geom1').feature('wp1').geom.feature('fil1').selection('point').set('dif1', 1);
model.geom('geom1').feature('wp1').geom.feature('fil1').set('radius', 50);
model.geom('geom1').feature('wp1').geom.run('fil1');
model.geom('geom1').feature('wp1').geom.create('fil2', 'Fillet');
model.geom('geom1').feature('wp1').geom.feature('fil2').selection('point').set('fil1', 3);
model.geom('geom1').feature('wp1').geom.feature('fil2').set('radius', 25);
model.geom('geom1').feature('wp1').geom.run('fil2');
model.geom('geom1').feature('wp1').geom.create('rot1', 'Rotate');
model.geom('geom1').feature('wp1').geom.feature('rot1').selection('input').set({'fil2'});
model.geom('geom1').feature('wp1').geom.feature('rot1').set('keep', true);
model.geom('geom1').feature('wp1').geom.feature('rot1').set('rot', '90 180 270');
model.geom('geom1').feature('wp1').geom.feature('rot1').set('pos', [194 100]);
model.geom('geom1').feature('wp1').geom.run('rot1');
model.geom('geom1').run('wp1');
model.geom('geom1').feature.create('ext1', 'Extrude');
model.geom('geom1').feature('ext1').set('workplane', 'wp1');
model.geom('geom1').feature('ext1').selection('input').set({'wp1'});
model.geom('geom1').feature('ext1').setIndex('distance', 100, 0);
model.geom('geom1').run('ext1');
model.geom('geom1').create('blk3', 'Block');
model.geom('geom1').feature('blk3').set('size', [700 700 500]);
model.geom('geom1').feature('blk3').set('pos', [-200 -200 -200]);
model.geom('geom1').run('fin');

model.view('view1').set('renderwireframe', true);

model.title([]);

model.description('');

model.label('multiturn_coil_asymmetric_conductor_geom_sequence.mph');

model.modelNode.label('Components');

out = model;
