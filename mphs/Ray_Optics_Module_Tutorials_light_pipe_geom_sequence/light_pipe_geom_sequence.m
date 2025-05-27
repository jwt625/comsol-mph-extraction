function out = model
%
% light_pipe_geom_sequence.m
%
% Model exported on May 26 2025, 21:32 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/Ray_Optics_Module/Tutorials');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 3);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

% To import content from file, use:
% model.param.loadFile('FILENAME');
model.param.set('rpipe', '2[mm]', 'Light pipe radius');
model.param.set('L1', '20[mm]', 'Length of straight section 1');
model.param.set('rb1', '10[mm]', 'Radius of curvature, bend 1');
model.param.set('theta1', '30[deg]', 'Bend angle 1');
model.param.set('L2', '25[mm]', 'Length of straight section 2');
model.param.set('rb2', '20[mm]', 'Radius of curvature, bend 2');
model.param.set('theta2', '90[deg]', 'Bend angle 2');
model.param.set('L3', '10[mm]', 'Length of straight section 3');
model.param.set('x0', '0', 'LED location, x-component');
model.param.set('y0', '0', 'LED location, y-component');
model.param.set('z0', '0', 'LED location, z-component');
model.param.set('xc1', 'x0-rb1', 'Center of curvature of bend 1, x-component');
model.param.set('yc1', 'y0', 'Center of curvature of bend 1, y-component');
model.param.set('zc1', 'z0+L1', 'Center of curvature of bend 1, z-component');
model.param.set('xL2', 'xc1+rb1*cos(theta1)', 'Start of straight section 2, x-component');
model.param.set('yL2', 'yc1', 'Start of straight section 2, y-component');
model.param.set('zL2', 'zc1+rb1*sin(theta1)', 'Start of straight section 2, z-component');
model.param.set('xc2', 'xL2-L2*sin(theta1)+rb2*cos(theta1)', 'Center of curvature of bend 2, x-component');
model.param.set('yc2', 'yL2', 'Center of curvature of bend 2, y-component');
model.param.set('zc2', 'zL2+L2*cos(theta1)+rb2*sin(theta1)', 'Center of curvature of bend 2, z-component');
model.param.set('xL3', 'xc2-rb2*cos(theta2-theta1)', 'Start of straight section 3, x-component');
model.param.set('yL3', 'yc2', 'Start of straight section 3, y-component');
model.param.set('zL3', 'zc2+rb2*sin(theta2-theta1)', 'Start of straight section 3, z-component');

model.geom('geom1').lengthUnit('mm');
model.geom('geom1').create('cyl1', 'Cylinder');
model.geom('geom1').feature('cyl1').set('r', 'rpipe');
model.geom('geom1').feature('cyl1').set('h', 'L1');
model.geom('geom1').feature('cyl1').set('pos', {'x0' 'y0' 'z0'});
model.geom('geom1').run('cyl1');
model.geom('geom1').create('tor1', 'Torus');
model.geom('geom1').feature('tor1').set('rmaj', 'rb1');
model.geom('geom1').feature('tor1').set('rmin', 'rpipe');
model.geom('geom1').feature('tor1').set('angle', 'theta1');
model.geom('geom1').feature('tor1').set('pos', {'xc1' 'yc1' 'zc1'});
model.geom('geom1').feature('tor1').set('axistype', 'y');
model.geom('geom1').feature('tor1').set('rot', '270-theta1');
model.geom('geom1').run('tor1');
model.geom('geom1').create('cyl2', 'Cylinder');
model.geom('geom1').feature('cyl2').set('r', 'rpipe');
model.geom('geom1').feature('cyl2').set('h', 'L2');
model.geom('geom1').feature('cyl2').set('pos', {'xL2' 'yL2' 'zL2'});
model.geom('geom1').feature('cyl2').set('axistype', 'cartesian');
model.geom('geom1').feature('cyl2').set('ax3', {'-sin(theta1)' '0' '1'});
model.geom('geom1').feature('cyl2').setIndex('ax3', 'cos(theta1)', 2);
model.geom('geom1').run('cyl2');
model.geom('geom1').create('tor2', 'Torus');
model.geom('geom1').feature('tor2').set('rmaj', 'rb2');
model.geom('geom1').feature('tor2').set('rmin', 'rpipe');
model.geom('geom1').feature('tor2').set('angle', 'theta2');
model.geom('geom1').feature('tor2').set('pos', {'xc2' 'yc2' 'zc2'});
model.geom('geom1').feature('tor2').set('axistype', 'y');
model.geom('geom1').feature('tor2').set('rot', '90-theta1');
model.geom('geom1').run('tor2');
model.geom('geom1').create('cyl3', 'Cylinder');
model.geom('geom1').feature('cyl3').set('r', 'rpipe');
model.geom('geom1').feature('cyl3').set('h', 'L3');
model.geom('geom1').feature('cyl3').set('pos', {'xL3' 'yL3' 'zL3'});
model.geom('geom1').feature('cyl3').set('axistype', 'cartesian');
model.geom('geom1').feature('cyl3').set('ax3', {'sin(theta2-theta1)' '0' '1'});
model.geom('geom1').feature('cyl3').setIndex('ax3', 'cos(theta2-theta1)', 2);
model.geom('geom1').runPre('fin');
model.geom('geom1').create('uni1', 'Union');
model.geom('geom1').feature('uni1').selection('input').set({'cyl1' 'cyl2' 'cyl3' 'tor1' 'tor2'});
model.geom('geom1').feature('uni1').set('intbnd', false);
model.geom('geom1').run('fin');

model.title([]);

model.description('');

model.label('light_pipe_geom_sequence.mph');

model.modelNode.label('Components');

out = model;
