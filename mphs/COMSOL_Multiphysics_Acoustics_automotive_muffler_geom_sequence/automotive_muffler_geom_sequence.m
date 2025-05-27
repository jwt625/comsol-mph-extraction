function out = model
%
% automotive_muffler_geom_sequence.m
%
% Model exported on May 26 2025, 21:26 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/COMSOL_Multiphysics/Acoustics');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 3);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.geom('geom1').create('cyl1', 'Cylinder');
model.geom('geom1').feature('cyl1').set('r', 0.03);
model.geom('geom1').feature('cyl1').set('h', 0.75);
model.geom('geom1').feature('cyl1').set('pos', [-0.1 0 0]);
model.geom('geom1').feature('cyl1').set('axistype', 'cartesian');
model.geom('geom1').feature('cyl1').set('ax3', [1 0 0]);
model.geom('geom1').run('cyl1');
model.geom('geom1').create('cyl2', 'Cylinder');
model.geom('geom1').feature('cyl2').set('r', 0.03);
model.geom('geom1').feature('cyl2').set('h', 0.75);
model.geom('geom1').feature('cyl2').set('pos', [0.25 -0.09 0]);
model.geom('geom1').feature('cyl2').set('axistype', 'cartesian');
model.geom('geom1').feature('cyl2').set('ax3', [1 0 0]);
model.geom('geom1').run('cyl2');
model.geom('geom1').create('wp1', 'WorkPlane');
model.geom('geom1').feature('wp1').set('unite', true);
model.geom('geom1').feature('wp1').set('quickplane', 'yz');
model.geom('geom1').feature('wp1').geom.create('e1', 'Ellipse');
model.geom('geom1').feature('wp1').geom.feature('e1').set('semiaxes', [0.15 0.07]);
model.geom('geom1').feature('wp1').geom.run('e1');
model.geom('geom1').run('wp1');
model.geom('geom1').feature.create('ext1', 'Extrude');
model.geom('geom1').feature('ext1').set('workplane', 'wp1');
model.geom('geom1').feature('ext1').selection('input').set({'wp1'});
model.geom('geom1').feature('ext1').setIndex('distance', 0.8, 0);
model.geom('geom1').run('ext1');
model.geom('geom1').create('wp2', 'WorkPlane');
model.geom('geom1').feature('wp2').set('unite', true);
model.geom('geom1').feature('wp2').set('quickplane', 'yz');
model.geom('geom1').feature('wp2').set('quickx', 0.25);
model.geom('geom1').feature('wp2').geom.create('e1', 'Ellipse');
model.geom('geom1').feature('wp2').geom.feature('e1').set('semiaxes', [0.15 0.07]);
model.geom('geom1').feature('wp2').geom.run('e1');
model.geom('geom1').feature('wp2').geom.create('c1', 'Circle');
model.geom('geom1').feature('wp2').geom.feature('c1').set('r', 0.03);
model.geom('geom1').feature('wp2').geom.feature('c1').set('pos', [0.09 0]);
model.geom('geom1').feature('wp2').geom.run('c1');
model.geom('geom1').run('wp2');
model.geom('geom1').create('wp3', 'WorkPlane');
model.geom('geom1').feature('wp3').set('unite', true);
model.geom('geom1').feature('wp3').set('quickplane', 'yz');
model.geom('geom1').feature('wp3').set('quickx', 0.65);
model.geom('geom1').feature('wp3').geom.create('e1', 'Ellipse');
model.geom('geom1').feature('wp3').geom.feature('e1').set('semiaxes', [0.15 0.07]);
model.geom('geom1').feature('wp3').geom.run('e1');
model.geom('geom1').feature('wp3').geom.create('c1', 'Circle');
model.geom('geom1').feature('wp3').geom.feature('c1').set('r', 0.03);
model.geom('geom1').feature('wp3').geom.feature('c1').set('pos', [0.09 0]);
model.geom('geom1').feature('wp3').geom.run('c1');
model.geom('geom1').run('fin');

model.title([]);

model.description('');

model.label('automotive_muffler_geom_sequence.mph');

model.modelNode.label('Components');

out = model;
