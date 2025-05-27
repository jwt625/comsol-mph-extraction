function out = model
%
% ecore_transformer_geom_sequence.m
%
% Model exported on May 26 2025, 21:24 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/ACDC_Module/Devices,_Inductive');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 3);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.geom('geom1').lengthUnit('mm');
model.geom('geom1').create('wp1', 'WorkPlane');
model.geom('geom1').feature('wp1').set('unite', true);
model.geom('geom1').feature('wp1').set('quickplane', 'xz');
model.geom('geom1').feature('wp1').set('quicky', 10);
model.geom('geom1').feature('wp1').geom.create('r1', 'Rectangle');
model.geom('geom1').feature('wp1').geom.feature('r1').set('size', [80 70]);
model.geom('geom1').feature('wp1').geom.feature('r1').set('base', 'center');
model.geom('geom1').feature('wp1').geom.run('r1');
model.geom('geom1').feature('wp1').geom.create('r2', 'Rectangle');
model.geom('geom1').feature('wp1').geom.feature('r2').set('size', [60 50]);
model.geom('geom1').feature('wp1').geom.feature('r2').set('base', 'center');
model.geom('geom1').feature('wp1').geom.run('r2');
model.geom('geom1').feature('wp1').geom.create('r3', 'Rectangle');
model.geom('geom1').feature('wp1').geom.feature('r3').set('size', [20 50]);
model.geom('geom1').feature('wp1').geom.feature('r3').set('base', 'center');
model.geom('geom1').feature('wp1').geom.run('r3');
model.geom('geom1').feature('wp1').geom.create('co1', 'Compose');
model.geom('geom1').feature('wp1').geom.feature('co1').selection('input').set({'r1' 'r2' 'r3'});
model.geom('geom1').feature('wp1').geom.feature('co1').set('formula', 'r1-r2+r3');
model.geom('geom1').feature('wp1').geom.feature('co1').set('intbnd', false);
model.geom('geom1').feature('wp1').geom.run('co1');
model.geom('geom1').run('wp1');
model.geom('geom1').feature.create('ext1', 'Extrude');
model.geom('geom1').run('ext1');
model.geom('geom1').feature('ext1').setIndex('distance', 20, 0);
model.geom('geom1').run('ext1');
model.geom('geom1').create('wp2', 'WorkPlane');
model.geom('geom1').feature('wp2').set('unite', true);
model.geom('geom1').feature('wp2').set('quickz', -23);
model.geom('geom1').feature('wp2').geom.create('c1', 'Circle');
model.geom('geom1').feature('wp2').geom.feature('c1').set('type', 'curve');
model.geom('geom1').feature('wp2').geom.feature('c1').set('r', 24);
model.geom('geom1').feature('wp2').geom.feature('c1').setIndex('layer', 4, 0);
model.geom('geom1').feature('wp2').geom.feature('c1').setIndex('layer', 4, 1);
model.geom('geom1').feature('wp2').geom.run('c1');
model.geom('geom1').run('wp2');
model.geom('geom1').feature.create('ext2', 'Extrude');
model.geom('geom1').run('ext2');
model.geom('geom1').feature('ext2').setIndex('distance', 46, 0);
model.geom('geom1').run('ext2');
model.geom('geom1').create('blk1', 'Block');
model.geom('geom1').feature('blk1').set('size', [150 130 150]);
model.geom('geom1').feature('blk1').set('base', 'center');
model.geom('geom1').run('fin');

model.title([]);

model.description('');

model.label('ecore_transformer_geom_sequence.mph');

model.modelNode.label('Components');

out = model;
