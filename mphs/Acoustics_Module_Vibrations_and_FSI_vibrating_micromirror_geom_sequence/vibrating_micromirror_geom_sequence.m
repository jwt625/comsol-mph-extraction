function out = model
%
% vibrating_micromirror_geom_sequence.m
%
% Model exported on May 26 2025, 21:25 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/Acoustics_Module/Vibrations_and_FSI');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 3);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.geom('geom1').lengthUnit('mm');
model.geom('geom1').create('wp1', 'WorkPlane');
model.geom('geom1').feature('wp1').set('unite', true);
model.geom('geom1').feature('wp1').geom.create('r1', 'Rectangle');
model.geom('geom1').feature('wp1').geom.feature('r1').set('size', [0.5 0.5]);
model.geom('geom1').feature('wp1').geom.feature('r1').set('base', 'center');
model.geom('geom1').feature('wp1').geom.run('r1');
model.geom('geom1').feature('wp1').geom.create('r2', 'Rectangle');
model.geom('geom1').feature('wp1').geom.feature('r2').set('size', [0.1 0.05]);
model.geom('geom1').feature('wp1').geom.feature('r2').set('pos', [-0.05 0.25]);
model.geom('geom1').feature('wp1').geom.feature.duplicate('r3', 'r2');
model.geom('geom1').feature('wp1').geom.feature('r3').set('pos', [-0.05 -0.3]);
model.geom('geom1').feature('wp1').geom.run('r3');
model.geom('geom1').feature('wp1').geom.create('r4', 'Rectangle');
model.geom('geom1').feature('wp1').geom.feature('r4').set('size', [0.5 0.6]);
model.geom('geom1').feature('wp1').geom.feature('r4').set('base', 'center');
model.geom('geom1').feature('wp1').geom.run('r4');
model.geom('geom1').feature('wp1').geom.create('uni1', 'Union');
model.geom('geom1').feature('wp1').geom.feature('uni1').selection('input').set({'r1' 'r2' 'r3' 'r4'});
model.geom('geom1').feature('wp1').geom.run('uni1');
model.geom('geom1').feature('wp1').geom.create('del1', 'Delete');
model.geom('geom1').feature('wp1').geom.feature('del1').selection('input').set('uni1', [1 2 5 7 10 12 15 19 20 22]);
model.geom('geom1').feature('wp1').geom.run('del1');
model.geom('geom1').feature('wp1').geom.create('fil1', 'Fillet');
model.geom('geom1').feature('wp1').geom.feature('fil1').selection('point').set('del1', [4 5 8 9]);
model.geom('geom1').feature('wp1').geom.feature('fil1').set('radius', 0.01);
model.geom('geom1').feature('wp1').geom.run('fil1');
model.geom('geom1').run('wp1');
model.geom('geom1').create('sph1', 'Sphere');
model.geom('geom1').feature('sph1').set('r', 0.8);
model.geom('geom1').feature('sph1').setIndex('layername', 'Layer 1', 0);
model.geom('geom1').feature('sph1').setIndex('layer', 0.3, 0);
model.geom('geom1').run('sph1');
model.geom('geom1').create('uni1', 'Union');
model.geom('geom1').feature('uni1').selection('input').set({'sph1' 'wp1'});
model.geom('geom1').run('uni1');
model.geom('geom1').create('blk1', 'Block');
model.geom('geom1').feature('blk1').set('size', [2 2 2]);
model.geom('geom1').feature('blk1').set('base', 'center');
model.geom('geom1').feature('blk1').set('pos', [0 -1 0]);
model.geom('geom1').run('blk1');
model.geom('geom1').create('dif1', 'Difference');
model.geom('geom1').feature('dif1').selection('input').set({'uni1'});
model.geom('geom1').feature('dif1').selection('input2').set({'blk1'});
model.geom('geom1').runPre('fin');

model.title([]);

model.description('');

model.label('vibrating_micromirror_geom_sequence.mph');

model.modelNode.label('Components');

out = model;
