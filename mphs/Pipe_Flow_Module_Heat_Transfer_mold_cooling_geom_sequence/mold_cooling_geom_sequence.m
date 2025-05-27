function out = model
%
% mold_cooling_geom_sequence.m
%
% Model exported on May 26 2025, 21:31 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/Pipe_Flow_Module/Heat_Transfer');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 3);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.geom('geom1').create('blk1', 'Block');
model.geom('geom1').feature('blk1').set('size', [0.5 0.5 0.15]);
model.geom('geom1').feature('blk1').set('base', 'center');
model.geom('geom1').run('blk1');

model.view('view1').set('renderwireframe', true);

model.geom('geom1').create('wp1', 'WorkPlane');
model.geom('geom1').feature('wp1').set('unite', true);
model.geom('geom1').feature('wp1').set('quickz', '4e-2');
model.geom('geom1').feature('wp1').geom.create('ls1', 'LineSegment');
model.geom('geom1').feature('wp1').geom.feature('ls1').set('specify1', 'coord');
model.geom('geom1').feature('wp1').geom.feature('ls1').set('specify2', 'coord');
model.geom('geom1').feature('wp1').geom.feature('ls1').set('coord1', [-0.25 0.2]);
model.geom('geom1').feature('wp1').geom.feature('ls1').set('coord2', [0.11 0.2]);
model.geom('geom1').feature('wp1').geom.run('ls1');
model.geom('geom1').feature('wp1').geom.create('qb1', 'QuadraticBezier');
model.geom('geom1').feature('wp1').geom.feature('qb1').setIndex('p', 0.11, 0, 0);
model.geom('geom1').feature('wp1').geom.feature('qb1').setIndex('p', 0.2, 1, 0);
model.geom('geom1').feature('wp1').geom.feature('qb1').setIndex('p', 0.21, 0, 1);
model.geom('geom1').feature('wp1').geom.feature('qb1').setIndex('p', 0.2, 1, 1);
model.geom('geom1').feature('wp1').geom.feature('qb1').setIndex('p', 0.21, 0, 2);
model.geom('geom1').feature('wp1').geom.feature('qb1').setIndex('p', 0.15, 1, 2);
model.geom('geom1').feature('wp1').geom.run('qb1');
model.geom('geom1').feature('wp1').geom.create('qb2', 'QuadraticBezier');
model.geom('geom1').feature('wp1').geom.feature('qb2').setIndex('p', 0.21, 0, 0);
model.geom('geom1').feature('wp1').geom.feature('qb2').setIndex('p', 0.15, 1, 0);
model.geom('geom1').feature('wp1').geom.feature('qb2').setIndex('p', 0.21, 0, 1);
model.geom('geom1').feature('wp1').geom.feature('qb2').setIndex('p', 0.1, 1, 1);
model.geom('geom1').feature('wp1').geom.feature('qb2').setIndex('p', 0.11, 0, 2);
model.geom('geom1').feature('wp1').geom.feature('qb2').setIndex('p', 0.1, 1, 2);
model.geom('geom1').feature('wp1').geom.run('qb2');
model.geom('geom1').feature('wp1').geom.create('ls2', 'LineSegment');
model.geom('geom1').feature('wp1').geom.feature('ls2').set('specify1', 'coord');
model.geom('geom1').feature('wp1').geom.feature('ls2').set('specify2', 'coord');
model.geom('geom1').feature('wp1').geom.feature('ls2').set('coord1', [0.11 0.1]);
model.geom('geom1').feature('wp1').geom.feature('ls2').set('coord2', [-0.11 0.1]);
model.geom('geom1').feature('wp1').geom.run('ls2');
model.geom('geom1').feature('wp1').geom.create('qb3', 'QuadraticBezier');
model.geom('geom1').feature('wp1').geom.feature('qb3').setIndex('p', -0.11, 0, 0);
model.geom('geom1').feature('wp1').geom.feature('qb3').setIndex('p', 0.1, 1, 0);
model.geom('geom1').feature('wp1').geom.feature('qb3').setIndex('p', -0.21, 0, 1);
model.geom('geom1').feature('wp1').geom.feature('qb3').setIndex('p', 0.1, 1, 1);
model.geom('geom1').feature('wp1').geom.feature('qb3').setIndex('p', -0.21, 0, 2);
model.geom('geom1').feature('wp1').geom.feature('qb3').setIndex('p', 0.05, 1, 2);
model.geom('geom1').feature('wp1').geom.run('qb3');
model.geom('geom1').feature('wp1').geom.create('qb4', 'QuadraticBezier');
model.geom('geom1').feature('wp1').geom.feature('qb4').setIndex('p', -0.21, 0, 0);
model.geom('geom1').feature('wp1').geom.feature('qb4').setIndex('p', 0.05, 1, 0);
model.geom('geom1').feature('wp1').geom.feature('qb4').setIndex('p', -0.21, 0, 1);
model.geom('geom1').feature('wp1').geom.feature('qb4').setIndex('p', -0.1, 0, 2);
model.geom('geom1').feature('wp1').geom.run('qb4');
model.geom('geom1').feature('wp1').geom.create('ls3', 'LineSegment');
model.geom('geom1').feature('wp1').geom.feature('ls3').set('specify1', 'coord');
model.geom('geom1').feature('wp1').geom.feature('ls3').set('specify2', 'coord');
model.geom('geom1').feature('wp1').geom.feature('ls3').set('coord1', [-0.1 0]);
model.geom('geom1').feature('wp1').geom.feature('ls3').set('coord2', [0.11 0]);
model.geom('geom1').feature('wp1').geom.run('ls3');
model.geom('geom1').feature('wp1').geom.create('qb5', 'QuadraticBezier');
model.geom('geom1').feature('wp1').geom.feature('qb5').setIndex('p', 0.11, 0, 0);
model.geom('geom1').feature('wp1').geom.feature('qb5').setIndex('p', 0.21, 0, 1);
model.geom('geom1').feature('wp1').geom.feature('qb5').setIndex('p', 0.21, 0, 2);
model.geom('geom1').feature('wp1').geom.feature('qb5').setIndex('p', -0.05, 1, 2);
model.geom('geom1').feature('wp1').geom.run('qb5');
model.geom('geom1').feature('wp1').geom.create('qb6', 'QuadraticBezier');
model.geom('geom1').feature('wp1').geom.feature('qb6').setIndex('p', 0.21, 0, 0);
model.geom('geom1').feature('wp1').geom.feature('qb6').setIndex('p', -0.05, 1, 0);
model.geom('geom1').feature('wp1').geom.feature('qb6').setIndex('p', 0.21, 0, 1);
model.geom('geom1').feature('wp1').geom.feature('qb6').setIndex('p', -0.1, 1, 1);
model.geom('geom1').feature('wp1').geom.feature('qb6').setIndex('p', 0.11, 0, 2);
model.geom('geom1').feature('wp1').geom.feature('qb6').setIndex('p', -0.1, 1, 2);
model.geom('geom1').feature('wp1').geom.run('qb6');
model.geom('geom1').feature('wp1').geom.create('ls4', 'LineSegment');
model.geom('geom1').feature('wp1').geom.feature('ls4').set('specify1', 'coord');
model.geom('geom1').feature('wp1').geom.feature('ls4').set('specify2', 'coord');
model.geom('geom1').feature('wp1').geom.feature('ls4').set('coord1', [0.11 -0.1]);
model.geom('geom1').feature('wp1').geom.feature('ls4').set('coord2', [-0.1 -0.1]);
model.geom('geom1').feature('wp1').geom.run('ls4');
model.geom('geom1').feature('wp1').geom.create('qb7', 'QuadraticBezier');
model.geom('geom1').feature('wp1').geom.feature('qb7').setIndex('p', -0.1, 0, 0);
model.geom('geom1').feature('wp1').geom.feature('qb7').setIndex('p', -0.1, 1, 0);
model.geom('geom1').feature('wp1').geom.feature('qb7').setIndex('p', -0.21, 0, 1);
model.geom('geom1').feature('wp1').geom.feature('qb7').setIndex('p', -0.1, 1, 1);
model.geom('geom1').feature('wp1').geom.feature('qb7').setIndex('p', -0.21, 0, 2);
model.geom('geom1').feature('wp1').geom.feature('qb7').setIndex('p', -0.15, 1, 2);
model.geom('geom1').feature('wp1').geom.run('qb7');
model.geom('geom1').feature('wp1').geom.create('qb8', 'QuadraticBezier');
model.geom('geom1').feature('wp1').geom.feature('qb8').setIndex('p', -0.21, 0, 0);
model.geom('geom1').feature('wp1').geom.feature('qb8').setIndex('p', -0.15, 1, 0);
model.geom('geom1').feature('wp1').geom.feature('qb8').setIndex('p', -0.21, 0, 1);
model.geom('geom1').feature('wp1').geom.feature('qb8').setIndex('p', -0.2, 1, 1);
model.geom('geom1').feature('wp1').geom.feature('qb8').setIndex('p', -0.1, 0, 2);
model.geom('geom1').feature('wp1').geom.feature('qb8').setIndex('p', -0.2, 1, 2);
model.geom('geom1').feature('wp1').geom.run('qb8');
model.geom('geom1').feature('wp1').geom.create('ls5', 'LineSegment');
model.geom('geom1').feature('wp1').geom.feature('ls5').set('specify1', 'coord');
model.geom('geom1').feature('wp1').geom.feature('ls5').set('specify2', 'coord');
model.geom('geom1').feature('wp1').geom.feature('ls5').set('coord1', [-0.1 -0.2]);
model.geom('geom1').feature('wp1').geom.feature('ls5').set('coord2', [0.25 -0.2]);
model.geom('geom1').feature('wp1').geom.run('ls5');
model.geom('geom1').feature('wp1').geom.create('ccur1', 'ConvertToCurve');
model.geom('geom1').feature('wp1').geom.feature('ccur1').selection('input').set({'ls1' 'ls2' 'ls3' 'ls4' 'ls5' 'qb1' 'qb2' 'qb3' 'qb4' 'qb5'  ...
'qb6' 'qb7' 'qb8'});
model.geom('geom1').feature('wp1').geom.run('ccur1');
model.geom('geom1').run('wp1');
model.geom('geom1').create('copy1', 'Copy');
model.geom('geom1').feature('copy1').selection('input').set({'wp1'});
model.geom('geom1').feature('copy1').set('displz', '-8e-2');
model.geom('geom1').run('copy1');
model.geom('geom1').create('rot1', 'Rotate');
model.geom('geom1').feature('rot1').selection('input').set({'copy1'});
model.geom('geom1').feature('rot1').set('rot', 180);
model.geom('geom1').feature('rot1').set('pos', [0 0 -0.04]);
model.geom('geom1').feature('rot1').set('axistype', 'cartesian');
model.geom('geom1').feature('rot1').set('ax3', [1 0 0]);
model.geom('geom1').run('rot1');

model.title([]);

model.description('');

model.label('mold_cooling_geom_sequence.mph');

model.modelNode.label('Components');

out = model;
