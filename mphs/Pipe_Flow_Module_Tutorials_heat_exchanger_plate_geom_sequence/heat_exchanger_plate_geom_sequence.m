function out = model
%
% heat_exchanger_plate_geom_sequence.m
%
% Model exported on May 26 2025, 21:31 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/Pipe_Flow_Module/Tutorials');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 3);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.param.set('Lp', '190[mm]');
model.param.descr('Lp', 'Pipe length');

model.geom('geom1').lengthUnit('mm');
model.geom('geom1').create('wp1', 'WorkPlane');
model.geom('geom1').feature('wp1').set('unite', true);
model.geom('geom1').feature('wp1').set('quickz', 0.5);
model.geom('geom1').feature('wp1').geom.create('ls1', 'LineSegment');
model.geom('geom1').feature('wp1').geom.feature('ls1').set('specify1', 'coord');
model.geom('geom1').feature('wp1').geom.feature('ls1').set('specify2', 'coord');
model.geom('geom1').feature('wp1').geom.feature('ls1').set('coord1', [0 0.5]);
model.geom('geom1').feature('wp1').geom.feature('ls1').set('coord2', {'Lp' '0.5'});
model.geom('geom1').feature('wp1').geom.run('ls1');
model.geom('geom1').run('wp1');
model.geom('geom1').create('arr1', 'Array');
model.geom('geom1').feature('arr1').selection('input').set({'wp1'});
model.geom('geom1').feature('arr1').set('fullsize', [1 5 1]);
model.geom('geom1').feature('arr1').set('displ', [0 20 0]);
model.geom('geom1').feature('arr1').set('selresult', true);
model.geom('geom1').feature('arr1').set('selresultshow', 'edg');
model.geom('geom1').run('arr1');
model.geom('geom1').create('blk1', 'Block');
model.geom('geom1').feature('blk1').set('size', [2 1 1]);
model.geom('geom1').feature('blk1').set('pos', [-2 0 0]);
model.geom('geom1').run('blk1');
model.geom('geom1').feature.duplicate('blk2', 'blk1');
model.geom('geom1').feature('blk2').set('pos', {'Lp' '0' '0'});
model.geom('geom1').run('blk2');
model.geom('geom1').create('arr2', 'Array');
model.geom('geom1').feature('arr2').selection('input').set({'blk1' 'blk2'});
model.geom('geom1').feature('arr2').set('fullsize', [1 5 1]);
model.geom('geom1').feature('arr2').set('displ', [0 20 0]);
model.geom('geom1').run('arr2');
model.geom('geom1').feature.duplicate('blk3', 'blk2');
model.geom('geom1').feature('blk3').set('size', [2 85 1]);
model.geom('geom1').feature('blk3').set('pos', [-4 0 0]);
model.geom('geom1').run('blk3');
model.geom('geom1').feature.duplicate('blk4', 'blk3');
model.geom('geom1').feature('blk4').set('pos', {'Lp+2' '-4' '0'});
model.geom('geom1').run('blk4');
model.geom('geom1').run('fin');
model.geom('geom1').create('cmd1', 'CompositeDomains');
model.geom('geom1').feature('cmd1').selection('input').set('fin', [1 2 3 4 5 6 7 8 9 10 11 12]);
model.geom('geom1').run('cmd1');

model.title([]);

model.description('');

model.label('heat_exchanger_plate_geom_sequence.mph');

model.modelNode.label('Components');

out = model;
