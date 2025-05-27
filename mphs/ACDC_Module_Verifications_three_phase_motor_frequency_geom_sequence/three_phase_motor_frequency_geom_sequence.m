function out = model
%
% three_phase_motor_frequency_geom_sequence.m
%
% Model exported on May 26 2025, 21:25 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/ACDC_Module/Verifications');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 2);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.param.set('r1', '2[cm]');
model.param.descr('r1', 'Outer radius of rotor steel');
model.param.set('r2', '3[cm]');
model.param.descr('r2', 'Outer radius of rotor aluminum');
model.param.set('r3', '3.2[cm]');
model.param.descr('r3', 'Inner radius of windings');
model.param.set('r4', '5.2[cm]');
model.param.descr('r4', 'Inner radius of stator steel');
model.param.set('r5', '5.7[cm]');
model.param.descr('r5', 'Outer radius of stator steel');
model.param.set('win_angle', '45[deg]');
model.param.descr('win_angle', 'Angular span of a winding');
model.param.set('airgap', 'r3-r2');
model.param.descr('airgap', 'Size of air gap');

model.geom('geom1').lengthUnit('cm');
model.geom('geom1').create('c1', 'Circle');
model.geom('geom1').feature('c1').set('r', 'r5');
model.geom('geom1').run('c1');
model.geom('geom1').create('c2', 'Circle');
model.geom('geom1').feature('c2').set('r', 'r4');
model.geom('geom1').run('c2');
model.geom('geom1').create('c3', 'Circle');
model.geom('geom1').feature('c3').set('r', 'r4');
model.geom('geom1').feature('c3').set('angle', 'win_angle');
model.geom('geom1').run('c3');
model.geom('geom1').create('c4', 'Circle');
model.geom('geom1').feature('c4').set('r', 'r3');
model.geom('geom1').feature('c4').set('angle', 'win_angle');
model.geom('geom1').run('c4');
model.geom('geom1').create('dif1', 'Difference');
model.geom('geom1').feature('dif1').selection('input').set({'c3'});
model.geom('geom1').feature('dif1').selection('input2').set({'c4'});
model.geom('geom1').run('dif1');
model.geom('geom1').create('rot1', 'Rotate');
model.geom('geom1').feature('rot1').selection('input').set({'dif1'});
model.geom('geom1').feature('rot1').set('rot', 'range(0,60,300)');
model.geom('geom1').run('rot1');
model.geom('geom1').create('c5', 'Circle');
model.geom('geom1').feature('c5').set('r', 'r3');
model.geom('geom1').run('c5');
model.geom('geom1').create('c6', 'Circle');
model.geom('geom1').feature('c6').set('r', 'r2+airgap/2');
model.geom('geom1').run('c6');
model.geom('geom1').create('c7', 'Circle');
model.geom('geom1').feature('c7').set('r', 'r5*1.2');
model.geom('geom1').run('c7');
model.geom('geom1').create('c8', 'Circle');
model.geom('geom1').feature('c8').set('r', 'r5');
model.geom('geom1').run('c8');
model.geom('geom1').create('ls1', 'LineSegment');
model.geom('geom1').feature('ls1').set('specify1', 'coord');
model.geom('geom1').feature('ls1').set('specify2', 'coord');
model.geom('geom1').feature('ls1').set('coord1', {'-r5*1.2' '0'});
model.geom('geom1').feature('ls1').set('coord2', {'r5*1.2' '0'});
model.geom('geom1').runPre('fin');
model.geom('geom1').create('co1', 'Compose');
model.geom('geom1').feature('co1').selection('input').set({'c7' 'c8' 'ls1'});
model.geom('geom1').feature('co1').set('formula', 'c7+ls1-c8');
model.geom('geom1').run('co1');
model.geom('geom1').create('c9', 'Circle');
model.geom('geom1').feature('c9').set('r', 'r2+airgap/2');
model.geom('geom1').run('c9');
model.geom('geom1').create('c10', 'Circle');
model.geom('geom1').feature('c10').set('r', 'r2');
model.geom('geom1').run('c10');
model.geom('geom1').create('c11', 'Circle');
model.geom('geom1').feature('c11').set('r', 'r1');
model.geom('geom1').run('fin');

model.title([]);

model.description('');

model.label('three_phase_motor_frequency_geom_sequence.mph');

model.modelNode.label('Components');

out = model;
