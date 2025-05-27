function out = model
%
% acoustics_pipe_system_geom_sequence.m
%
% Model exported on May 26 2025, 21:31 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/Pipe_Flow_Module/Pipe_Acoustics');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 3);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

% To import content from file, use:
% model.param.loadFile('FILENAME');
model.param.set('Di', '35[cm]', 'Inner pipe diameter');
model.param.set('Lj', '4[m]', 'Length of junction');
model.param.set('L1', '70[m]', 'Length of pipe 1');
model.param.set('L2', '15[m]', 'Length of pipe 2');
model.param.set('L3', '30[m]', 'Length of pipe 3');
model.param.set('L4', '25[m]', 'Length of pipe 4');
model.param.set('rbend', '5 [cm]', 'Inner radius of the bend');
model.param.label('Parameters geom sequence');

model.geom('geom1').create('ls1', 'LineSegment');
model.geom('geom1').feature('ls1').set('specify1', 'coord');
model.geom('geom1').feature('ls1').set('coord1', {'-Lj' '0' '0'});
model.geom('geom1').feature('ls1').set('specify2', 'coord');
model.geom('geom1').feature('ls1').set('coord2', {'-L1+Lj/2' '0' '0'});
model.geom('geom1').run('ls1');
model.geom('geom1').create('ls2', 'LineSegment');
model.geom('geom1').feature('ls2').set('specify1', 'coord');
model.geom('geom1').feature('ls2').set('coord1', {'-L1+Lj/2' '0' '0'});
model.geom('geom1').feature('ls2').set('specify2', 'coord');
model.geom('geom1').feature('ls2').set('coord2', {'-L1' '0' '0'});
model.geom('geom1').run('ls2');
model.geom('geom1').create('cyl1', 'Cylinder');
model.geom('geom1').feature('cyl1').set('r', 'Di/2');
model.geom('geom1').feature('cyl1').set('h', 'Lj');
model.geom('geom1').feature('cyl1').set('pos', {'-Lj' '0' '0'});
model.geom('geom1').feature('cyl1').set('axistype', 'x');
model.geom('geom1').run('cyl1');
model.geom('geom1').create('cyl2', 'Cylinder');
model.geom('geom1').feature('cyl2').set('r', 'Di/3');
model.geom('geom1').feature('cyl2').set('h', 'Lj/2');
model.geom('geom1').feature('cyl2').set('pos', {'-Lj/2' '-Lj/2' '0'});
model.geom('geom1').feature('cyl2').set('axistype', 'y');
model.geom('geom1').run('cyl2');
model.geom('geom1').create('uni1', 'Union');
model.geom('geom1').feature('uni1').selection('input').set({'cyl1' 'cyl2'});
model.geom('geom1').run('uni1');
model.geom('geom1').create('ls3', 'LineSegment');
model.geom('geom1').feature('ls3').set('specify1', 'coord');
model.geom('geom1').feature('ls3').set('coord1', {'-Lj/2' '-Lj/2' '0'});
model.geom('geom1').feature('ls3').set('specify2', 'coord');
model.geom('geom1').feature('ls3').set('coord2', {'-Lj/2' '-L2' '0'});
model.geom('geom1').run('ls3');
model.geom('geom1').create('ls4', 'LineSegment');
model.geom('geom1').feature('ls4').set('specify1', 'coord');
model.geom('geom1').feature('ls4').set('specify2', 'coord');
model.geom('geom1').feature('ls4').set('coord2', {'L3-Lj/2' '0' '0'});
model.geom('geom1').run('ls4');
model.geom('geom1').create('cyl3', 'Cylinder');
model.geom('geom1').feature('cyl3').set('r', 'Di/2');
model.geom('geom1').feature('cyl3').set('h', 'Lj/2-rbend-Di/2');
model.geom('geom1').feature('cyl3').set('pos', {'L3-Lj/2' '0' '0'});
model.geom('geom1').feature('cyl3').set('axistype', 'x');
model.geom('geom1').run('cyl3');
model.geom('geom1').feature.create('rev1', 'Revolve');
model.geom('geom1').feature('rev1').set('angtype', 'full');
model.geom('geom1').feature('rev1').selection('inputface').set('cyl3', 4);
model.geom('geom1').feature('rev1').set('angtype', 'specang');
model.geom('geom1').feature('rev1').set('angle2', 90);
model.geom('geom1').feature('rev1').set('pos', {'0' '-rbend-Di/2'});
model.geom('geom1').feature('rev1').set('axis', [1 0]);
model.geom('geom1').run('rev1');
model.geom('geom1').create('cyl4', 'Cylinder');
model.geom('geom1').feature('cyl4').set('r', 'Di/2');
model.geom('geom1').feature('cyl4').set('h', 'Lj/2-rbend-Di/2');
model.geom('geom1').feature('cyl4').set('pos', {'L3' '-Lj/2' '0'});
model.geom('geom1').feature('cyl4').set('axistype', 'y');
model.geom('geom1').run('cyl4');
model.geom('geom1').create('ls5', 'LineSegment');
model.geom('geom1').feature('ls5').set('specify1', 'coord');
model.geom('geom1').feature('ls5').set('coord1', {'L3' '-Lj/2' '0'});
model.geom('geom1').feature('ls5').set('specify2', 'coord');
model.geom('geom1').feature('ls5').set('coord2', {'L3' '-L4' '0'});
model.geom('geom1').run('ls5');
model.geom('geom1').run('fin');

model.title([]);

model.description('');

model.label('acoustics_pipe_system_geom_sequence.mph');

model.modelNode.label('Components');

out = model;
