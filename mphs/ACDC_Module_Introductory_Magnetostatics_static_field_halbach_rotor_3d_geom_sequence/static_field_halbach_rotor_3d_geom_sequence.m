function out = model
%
% static_field_halbach_rotor_3d_geom_sequence.m
%
% Model exported on May 26 2025, 21:25 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/ACDC_Module/Introductory_Magnetostatics');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 3);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.param.set('Ro', '50[mm]');
model.param.descr('Ro', 'Outer radius of the rotor');
model.param.set('Ri', '30[mm]');
model.param.descr('Ri', 'Inner radius of the rotor');
model.param.set('L', '30[mm]');
model.param.descr('L', 'Length of the rotor');
model.param.set('alpha', '11.25[deg]');
model.param.descr('alpha', 'Angle of rotation');

model.geom('geom1').lengthUnit('mm');
model.geom('geom1').create('wp1', 'WorkPlane');
model.geom('geom1').feature('wp1').set('unite', true);
model.geom('geom1').feature('wp1').set('quickz', '-L/2');
model.geom('geom1').feature('wp1').geom.create('c1', 'Circle');
model.geom('geom1').feature('wp1').geom.feature('c1').set('r', 'Ro');
model.geom('geom1').feature('wp1').geom.feature('c1').set('angle', 'alpha');
model.geom('geom1').feature('wp1').geom.run('c1');
model.geom('geom1').feature('wp1').geom.feature.duplicate('c2', 'c1');
model.geom('geom1').feature('wp1').geom.feature('c2').set('r', 'Ri');
model.geom('geom1').feature('wp1').geom.run('c2');
model.geom('geom1').feature('wp1').geom.create('dif1', 'Difference');
model.geom('geom1').feature('wp1').geom.feature('dif1').selection('input').set({'c1'});
model.geom('geom1').feature('wp1').geom.feature('dif1').selection('input2').set({'c2'});
model.geom('geom1').feature('wp1').geom.run('dif1');
model.geom('geom1').feature('wp1').geom.create('rot1', 'Rotate');
model.geom('geom1').feature('wp1').geom.feature('rot1').selection('input').set({'dif1'});
model.geom('geom1').feature('wp1').geom.feature('rot1').set('rot', 'range(0,alpha,3*alpha)');
model.geom('geom1').feature('wp1').geom.run('rot1');
model.geom('geom1').feature('wp1').geom.create('uni1', 'Union');
model.geom('geom1').feature('wp1').geom.feature('uni1').selection('input').set({'rot1(2)' 'rot1(3)'});
model.geom('geom1').feature('wp1').geom.feature('uni1').set('intbnd', false);
model.geom('geom1').feature('wp1').geom.run('uni1');
model.geom('geom1').run('wp1');
model.geom('geom1').feature.create('ext1', 'Extrude');
model.geom('geom1').feature('ext1').set('workplane', 'wp1');
model.geom('geom1').feature('ext1').selection('input').set({'wp1'});
model.geom('geom1').feature('ext1').setIndex('distance', 'L', 0);
model.geom('geom1').run('ext1');
model.geom('geom1').create('wp2', 'WorkPlane');
model.geom('geom1').feature('wp2').set('unite', true);
model.geom('geom1').feature('wp2').set('quickz', -40);
model.geom('geom1').feature('wp2').geom.create('c1', 'Circle');
model.geom('geom1').feature('wp2').geom.feature('c1').set('r', 80);
model.geom('geom1').feature('wp2').geom.feature('c1').set('angle', 45);
model.geom('geom1').feature('wp2').geom.run('c1');
model.geom('geom1').run('wp2');
model.geom('geom1').feature.create('ext2', 'Extrude');
model.geom('geom1').feature('ext2').set('workplane', 'wp2');
model.geom('geom1').feature('ext2').selection('input').set({'wp2'});
model.geom('geom1').feature('ext2').setIndex('distance', 80, 0);
model.geom('geom1').run('ext2');
model.geom('geom1').create('wp3', 'WorkPlane');
model.geom('geom1').feature('wp3').set('unite', true);
model.geom('geom1').feature('wp3').geom.create('c1', 'Circle');
model.geom('geom1').feature('wp3').geom.feature('c1').set('type', 'curve');
model.geom('geom1').feature('wp3').geom.feature('c1').set('r', 55);
model.geom('geom1').feature('wp3').geom.feature('c1').set('angle', 45);
model.geom('geom1').feature('wp3').geom.run('c1');
model.geom('geom1').feature('wp3').geom.feature.duplicate('c2', 'c1');
model.geom('geom1').feature('wp3').geom.feature('c2').set('r', 25);
model.geom('geom1').feature('wp3').geom.run('c2');
model.geom('geom1').feature('wp3').geom.create('del1', 'Delete');
model.geom('geom1').feature('wp3').geom.feature('del1').selection('input').set('c1', [2 3]);
model.geom('geom1').feature('wp3').geom.feature('del1').selection('input').set('c2', [2 3]);
model.geom('geom1').run('fin');

model.view('view1').set('renderwireframe', true);

model.title([]);

model.description('');

model.label('static_field_halbach_rotor_3d_geom_sequence.mph');

model.modelNode.label('Components');

out = model;
