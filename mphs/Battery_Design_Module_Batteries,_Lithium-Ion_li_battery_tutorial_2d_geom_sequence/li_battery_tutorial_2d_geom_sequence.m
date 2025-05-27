function out = model
%
% li_battery_tutorial_2d_geom_sequence.m
%
% Model exported on May 26 2025, 21:26 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/Battery_Design_Module/Batteries,_Lithium-Ion');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 2);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.geom('geom1').lengthUnit('mm');
model.geom('geom1').create('r1', 'Rectangle');
model.geom('geom1').feature('r1').set('size', [1.3 0.65]);
model.geom('geom1').run('r1');
model.geom('geom1').create('r2', 'Rectangle');
model.geom('geom1').feature('r2').set('size', [1.15 0.35]);
model.geom('geom1').feature('r2').set('pos', [0 0.15]);
model.geom('geom1').run('r2');
model.geom('geom1').create('r3', 'Rectangle');
model.geom('geom1').feature('r3').set('size', [1.1 0.25]);
model.geom('geom1').feature('r3').set('pos', [0 0.2]);
model.geom('geom1').run('r3');
model.geom('geom1').create('dif1', 'Difference');
model.geom('geom1').feature('dif1').selection('input').set({'r1' 'r2'});
model.geom('geom1').feature('dif1').selection('input2').set({'r3'});
model.geom('geom1').run('dif1');
model.geom('geom1').create('pt1', 'Point');
model.geom('geom1').feature('pt1').setIndex('p', 1, 0);
model.geom('geom1').feature('pt1').setIndex('p', 0.65, 1);
model.geom('geom1').run('fin');

model.title([]);

model.description('');

model.label('li_battery_tutorial_2d_geom_sequence.mph');

model.modelNode.label('Components');

out = model;
