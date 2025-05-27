function out = model
%
% laminar_mixer_particle_geom_sequence.m
%
% Model exported on May 26 2025, 21:31 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/Particle_Tracing_Module/Fluid_Flow');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 3);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.param.set('Ra', '3[mm]');
model.param.descr('Ra', 'Tube radius');

model.geom('geom1').label('Mixer Geometry Sequence');
model.geom('geom1').create('wp1', 'WorkPlane');
model.geom('geom1').feature('wp1').set('unite', true);
model.geom('geom1').feature('wp1').set('quickplane', 'xz');
model.geom('geom1').feature('wp1').geom.create('r1', 'Rectangle');
model.geom('geom1').feature('wp1').geom.feature('r1').set('size', {'2.4*Ra' 'Ra/8'});
model.geom('geom1').feature('wp1').geom.feature('r1').set('base', 'center');
model.geom('geom1').feature('wp1').geom.run('r1');
model.geom('geom1').run('wp1');
model.geom('geom1').feature.create('ext1', 'Extrude');
model.geom('geom1').feature('ext1').set('workplane', 'wp1');
model.geom('geom1').feature('ext1').selection('input').set({'wp1'});
model.geom('geom1').feature('ext1').setIndex('distance', 'Ra/2', 0);
model.geom('geom1').feature('ext1').setIndex('twist', 30, 0);
model.geom('geom1').run('ext1');
model.geom('geom1').create('copy1', 'Copy');
model.geom('geom1').feature('copy1').selection('input').set({'ext1'});
model.geom('geom1').feature('copy1').set('disply', '-Ra/2');
model.geom('geom1').run('copy1');
model.geom('geom1').create('rot1', 'Rotate');
model.geom('geom1').feature('rot1').selection('input').set({'copy1'});
model.geom('geom1').feature('rot1').set('axistype', 'y');
model.geom('geom1').feature('rot1').set('rot', 30);
model.geom('geom1').run('rot1');
model.geom('geom1').create('copy2', 'Copy');
model.geom('geom1').feature('copy2').selection('input').set({'ext1' 'rot1'});
model.geom('geom1').feature('copy2').set('disply', '-Ra');
model.geom('geom1').run('copy2');
model.geom('geom1').create('rot2', 'Rotate');
model.geom('geom1').feature('rot2').selection('input').set({'copy2'});
model.geom('geom1').feature('rot2').set('axistype', 'y');
model.geom('geom1').feature('rot2').set('rot', 60);
model.geom('geom1').run('rot2');
model.geom('geom1').create('copy3', 'Copy');
model.geom('geom1').feature('copy3').selection('input').set({'ext1' 'rot1'});
model.geom('geom1').feature('copy3').set('disply', '-2*Ra');
model.geom('geom1').run('copy3');
model.geom('geom1').create('rot3', 'Rotate');
model.geom('geom1').feature('rot3').set('axistype', 'y');
model.geom('geom1').feature('rot3').set('rot', 120);
model.geom('geom1').feature('rot3').selection('input').set({'copy3'});
model.geom('geom1').run('rot3');
model.geom('geom1').create('copy4', 'Copy');
model.geom('geom1').feature('copy4').selection('input').set({'ext1' 'rot1' 'rot2' 'rot3'});
model.geom('geom1').feature('copy4').set('disply', '-3*Ra');
model.geom('geom1').run('copy4');
model.geom('geom1').create('mir1', 'Mirror');
model.geom('geom1').feature('mir1').selection('input').set({'copy4'});
model.geom('geom1').feature('mir1').set('axis', [1 0 0]);
model.geom('geom1').run('mir1');
model.geom('geom1').create('rot4', 'Rotate');
model.geom('geom1').feature('rot4').selection('input').set({'mir1'});
model.geom('geom1').feature('rot4').set('axistype', 'y');
model.geom('geom1').feature('rot4').set('rot', 90);
model.geom('geom1').run('rot4');
model.geom('geom1').create('copy5', 'Copy');
model.geom('geom1').feature('copy5').selection('input').set({'ext1' 'rot1' 'rot2' 'rot3'});
model.geom('geom1').feature('copy5').set('disply', '-6*Ra');
model.geom('geom1').run('copy5');
model.geom('geom1').create('cyl1', 'Cylinder');
model.geom('geom1').feature('cyl1').set('r', 'Ra');
model.geom('geom1').feature('cyl1').set('h', '14*Ra');
model.geom('geom1').feature('cyl1').set('pos', {'0' '-12*Ra' '0'});
model.geom('geom1').feature('cyl1').set('axistype', 'y');
model.geom('geom1').feature('cyl1').set('rot', -15);
model.geom('geom1').run('cyl1');
model.geom('geom1').create('uni1', 'Union');
model.geom('geom1').feature('uni1').selection('input').set({'copy5' 'ext1' 'rot1' 'rot2' 'rot3' 'rot4'});
model.geom('geom1').run('uni1');
model.geom('geom1').create('dif1', 'Difference');
model.geom('geom1').feature('dif1').selection('input').set({'cyl1'});
model.geom('geom1').feature('dif1').selection('input2').set({'uni1'});
model.geom('geom1').run('dif1');

model.title([]);

model.description('');

model.label('laminar_mixer_particle_geom_sequence.mph');

model.modelNode.label('Components');

out = model;
