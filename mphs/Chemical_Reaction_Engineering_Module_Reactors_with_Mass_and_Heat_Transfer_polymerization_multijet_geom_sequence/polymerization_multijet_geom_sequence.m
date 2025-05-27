function out = model
%
% polymerization_multijet_geom_sequence.m
%
% Model exported on May 26 2025, 21:27 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/Chemical_Reaction_Engineering_Module/Reactors_with_Mass_and_Heat_Transfer');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 3);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.geom('geom1').create('cyl1', 'Cylinder');
model.geom('geom1').feature('cyl1').set('r', 0.005);
model.geom('geom1').feature('cyl1').set('h', 0.06);
model.geom('geom1').feature('cyl1').set('pos', [0.01318 0 0.0205]);
model.geom('geom1').run('cyl1');
model.geom('geom1').create('rot1', 'Rotate');
model.geom('geom1').feature('rot1').selection('input').set({'cyl1'});
model.geom('geom1').feature('rot1').set('rot', -19.2);
model.geom('geom1').feature('rot1').set('pos', [0.01318 0 0.05]);
model.geom('geom1').feature('rot1').set('axistype', 'y');
model.geom('geom1').run('rot1');
model.geom('geom1').create('cyl2', 'Cylinder');
model.geom('geom1').feature('cyl2').set('r', 0.005);
model.geom('geom1').feature('cyl2').set('h', 0.03);
model.geom('geom1').feature('cyl2').set('pos', [-0.03 0 0.036]);
model.geom('geom1').feature('cyl2').set('axistype', 'x');
model.geom('geom1').run('cyl2');
model.geom('geom1').feature.create('ext1', 'Extrude');
model.geom('geom1').feature('ext1').selection('inputface').set('cyl2', 4);
model.geom('geom1').feature('ext1').setIndex('distance', 0.016, 0);
model.geom('geom1').feature('ext1').setIndex('scale', '.9', 0, 0);
model.geom('geom1').feature('ext1').setIndex('scale', '.9', 0, 1);
model.geom('geom1').run('ext1');
model.geom('geom1').create('uni1', 'Union');
model.geom('geom1').feature('uni1').selection('input').set({'ext1' 'rot1'});
model.geom('geom1').feature('uni1').set('intbnd', false);
model.geom('geom1').run('uni1');
model.geom('geom1').create('wp1', 'WorkPlane');
model.geom('geom1').feature('wp1').set('unite', true);
model.geom('geom1').feature('wp1').set('quickplane', 'zx');
model.geom('geom1').run('wp1');
model.geom('geom1').create('par1', 'Partition');
model.geom('geom1').feature('par1').selection('input').set({'uni1'});
model.geom('geom1').feature('par1').set('partitionwith', 'workplane');
model.geom('geom1').run('par1');
model.geom('geom1').feature.create('del1', 'Delete');
model.geom('geom1').feature('del1').selection('input').init(3);
model.geom('geom1').feature('del1').selection('input').set('par1', 2);
model.geom('geom1').run('del1');
model.geom('geom1').create('wp2', 'WorkPlane');
model.geom('geom1').feature('wp2').set('unite', true);
model.geom('geom1').feature('wp2').set('quickplane', 'yz');
model.geom('geom1').feature('wp2').geom.create('c1', 'Circle');
model.geom('geom1').feature('wp2').geom.feature('c1').set('r', 0.05);
model.geom('geom1').feature('wp2').geom.feature('c1').set('angle', 18);
model.geom('geom1').feature('wp2').geom.feature('c1').set('rot', 90);
model.geom('geom1').feature('wp2').geom.run('c1');
model.geom('geom1').run('wp2');
model.geom('geom1').feature.create('ext2', 'Extrude');
model.geom('geom1').feature('ext2').set('workplane', 'wp2');
model.geom('geom1').feature('ext2').selection('input').set({'wp2'});
model.geom('geom1').feature('ext2').setIndex('distance', '.1', 0);
model.geom('geom1').feature('ext2').setIndex('distance', '.3', 1);
model.geom('geom1').feature('ext2').set('displ', {'0' '0'; '0' '0'});
model.geom('geom1').feature('ext2').set('scale', {'1' '1'; '1' '1'});
model.geom('geom1').feature('ext2').set('twist', {'0' '0'});
model.geom('geom1').run('ext2');
model.geom('geom1').run('fin');

model.title([]);

model.description('');

model.label('polymerization_multijet_geom_sequence.mph');

model.modelNode.label('Components');

out = model;
