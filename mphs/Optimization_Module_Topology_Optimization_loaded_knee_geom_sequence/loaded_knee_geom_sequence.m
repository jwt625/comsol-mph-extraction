function out = model
%
% loaded_knee_geom_sequence.m
%
% Model exported on May 26 2025, 21:31 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/Optimization_Module/Topology_Optimization');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 2);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.param.set('a', '45[cm]');
model.param.descr('a', 'Total width');
model.param.set('b', '50[cm]');
model.param.descr('b', 'Total height');
model.param.set('c', '18[cm]');
model.param.descr('c', 'Segment width');
model.param.set('r', '5[cm]');
model.param.descr('r', 'Fillet radius');
model.param.set('L', '5[cm]');
model.param.descr('L', 'Loaded edge length');

model.geom('geom1').create('r1', 'Rectangle');
model.geom('geom1').feature('r1').set('size', {'a' 'b'});
model.geom('geom1').run('r1');
model.geom('geom1').create('r2', 'Rectangle');
model.geom('geom1').feature('r2').set('size', {'a-c' 'b-c'});
model.geom('geom1').feature('r2').set('pos', {'c' 'c'});
model.geom('geom1').run('r2');
model.geom('geom1').create('dif1', 'Difference');
model.geom('geom1').feature('dif1').selection('input').set({'r1'});
model.geom('geom1').feature('dif1').selection('input2').set({'r2'});
model.geom('geom1').run('dif1');
model.geom('geom1').create('fil1', 'Fillet');
model.geom('geom1').feature('fil1').selection('point').set('dif1', 3);
model.geom('geom1').feature('fil1').set('radius', 'r');
model.geom('geom1').run('fil1');
model.geom('geom1').create('pt1', 'Point');
model.geom('geom1').feature('pt1').setIndex('p', 'a-L', 0);
model.geom('geom1').feature('pt1').setIndex('p', 'c', 1);
model.geom('geom1').run('fin');

model.title([]);

model.description('');

model.label('loaded_knee_geom_sequence.mph');

model.modelNode.label('Components');

out = model;
