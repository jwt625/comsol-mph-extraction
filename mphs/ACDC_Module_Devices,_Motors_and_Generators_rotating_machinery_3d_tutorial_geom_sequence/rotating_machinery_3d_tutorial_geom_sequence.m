function out = model
%
% rotating_machinery_3d_tutorial_geom_sequence.m
%
% Model exported on May 26 2025, 21:24 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/ACDC_Module/Devices,_Motors_and_Generators');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 3);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.param.set('R1', '1[cm]');
model.param.descr('R1', 'Geometry external radius');
model.param.set('R2', '6[mm]');
model.param.descr('R2', 'Positioning of sliding interface');
model.param.set('R3', '5[mm]');
model.param.descr('R3', 'Rotating object radius');
model.param.set('H1', '5[mm]');
model.param.descr('H1', 'Height of magnet and rotating disk');

model.geom('geom1').create('cyl1', 'Cylinder');
model.geom('geom1').feature('cyl1').set('r', 'R1');
model.geom('geom1').feature('cyl1').set('h', '3*H1');
model.geom('geom1').feature('cyl1').set('pos', {'0' '0' '-1.5*H1'});
model.geom('geom1').run('cyl1');

model.view('view1').set('renderwireframe', true);

model.geom('geom1').feature.duplicate('cyl2', 'cyl1');
model.geom('geom1').feature('cyl2').set('r', 'R2');
model.geom('geom1').run('cyl2');
model.geom('geom1').feature.duplicate('cyl3', 'cyl2');
model.geom('geom1').run('cyl3');
model.geom('geom1').create('dif1', 'Difference');
model.geom('geom1').feature('dif1').selection('input').set({'cyl1'});
model.geom('geom1').feature('dif1').selection('input2').set({'cyl3'});
model.geom('geom1').run('dif1');
model.geom('geom1').feature.duplicate('cyl4', 'cyl1');
model.geom('geom1').feature('cyl4').set('r', 'R3');
model.geom('geom1').feature('cyl4').set('h', 'H1');
model.geom('geom1').feature('cyl4').set('pos', {'0' '0' '-H1/2'});
model.geom('geom1').feature('cyl4').setIndex('layer', 'H1/2', 0);
model.geom('geom1').feature('cyl4').set('layerside', false);
model.geom('geom1').feature('cyl4').set('layerbottom', true);
model.geom('geom1').run('cyl4');
model.geom('geom1').create('uni1', 'Union');
model.geom('geom1').feature('uni1').selection('input').set({'cyl2' 'cyl4'});
model.geom('geom1').run('uni1');
model.geom('geom1').create('wp1', 'WorkPlane');
model.geom('geom1').feature('wp1').set('unite', true);
model.geom('geom1').feature('wp1').set('quickz', '-H1/2');
model.geom('geom1').feature('wp1').geom.create('r1', 'Rectangle');
model.geom('geom1').feature('wp1').geom.feature('r1').set('size', {'(R1-R2)/3' '(R1-R2)/6'});
model.geom('geom1').feature('wp1').geom.feature('r1').set('pos', {'-R1+(R1-R2)/2' '0'});
model.geom('geom1').feature('wp1').geom.feature('r1').setIndex('pos', '-(R1-R2)/12', 1);
model.geom('geom1').feature('wp1').geom.run('r1');
model.geom('geom1').run('wp1');
model.geom('geom1').feature.create('ext1', 'Extrude');
model.geom('geom1').feature('ext1').set('workplane', 'wp1');
model.geom('geom1').feature('ext1').selection('input').set({'wp1'});
model.geom('geom1').feature('ext1').setIndex('distance', 'H1', 0);
model.geom('geom1').run('ext1');
model.geom('geom1').create('uni2', 'Union');
model.geom('geom1').feature('uni2').selection('input').set({'dif1' 'ext1'});
model.geom('geom1').feature('fin').set('action', 'assembly');
model.geom('geom1').run('fin');

model.title([]);

model.description('');

model.label('rotating_machinery_3d_tutorial_geom_sequence.mph');

model.modelNode.label('Components');

out = model;
