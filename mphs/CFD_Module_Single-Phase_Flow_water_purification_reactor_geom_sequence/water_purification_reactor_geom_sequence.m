function out = model
%
% water_purification_reactor_geom_sequence.m
%
% Model exported on May 26 2025, 21:26 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/CFD_Module/Single-Phase_Flow');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 3);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.geom('geom1').create('blk1', 'Block');
model.geom('geom1').feature('blk1').set('size', [5 2 1]);
model.geom('geom1').run('blk1');
model.geom('geom1').create('cyl1', 'Cylinder');
model.geom('geom1').feature('cyl1').set('r', 0.2);
model.geom('geom1').feature('cyl1').set('h', 0.5);
model.geom('geom1').feature('cyl1').set('pos', [-0.5 0 0]);
model.geom('geom1').feature('cyl1').set('axistype', 'x');
model.geom('geom1').feature('cyl1').set('pos', [-0.5 1 0.5]);
model.geom('geom1').feature.duplicate('cyl2', 'cyl1');
model.geom('geom1').feature('cyl2').set('pos', [5 1 0.5]);
model.geom('geom1').run('cyl2');
model.geom('geom1').create('blk2', 'Block');
model.geom('geom1').feature('blk2').set('size', [0.1 1 1]);
model.geom('geom1').feature('blk2').set('pos', [0.95 1 0]);
model.geom('geom1').feature.duplicate('blk3', 'blk2');
model.geom('geom1').feature('blk3').set('pos', [2.95 1 0]);
model.geom('geom1').feature.duplicate('blk4', 'blk2');
model.geom('geom1').feature('blk4').set('pos', [1.95 0 0]);
model.geom('geom1').feature.duplicate('blk5', 'blk4');
model.geom('geom1').feature('blk5').set('pos', [3.95 0 0]);
model.geom('geom1').run('blk5');
model.geom('geom1').create('dif1', 'Difference');
model.geom('geom1').feature('dif1').selection('input').set({'blk1'});
model.geom('geom1').feature('dif1').selection('input2').set({'blk2' 'blk3' 'blk4' 'blk5'});
model.geom('geom1').run('dif1');
model.geom('geom1').create('uni1', 'Union');
model.geom('geom1').feature('uni1').selection('input').set({'cyl1' 'cyl2' 'dif1'});
model.geom('geom1').feature('uni1').set('intbnd', false);
model.geom('geom1').run('uni1');
model.geom('geom1').create('blk6', 'Block');
model.geom('geom1').feature('blk6').set('pos', [-0.5 0 0.5]);
model.geom('geom1').feature('blk6').set('size', [6 2 0.5]);
model.geom('geom1').run('blk6');
model.geom('geom1').create('dif2', 'Difference');
model.geom('geom1').feature('dif2').selection('input').set({'uni1'});
model.geom('geom1').feature('dif2').selection('input2').set({'blk6'});
model.geom('geom1').run('fin');

model.title([]);

model.description('');

model.label('water_purification_reactor_geom_sequence.mph');

model.modelNode.label('Components');

out = model;
