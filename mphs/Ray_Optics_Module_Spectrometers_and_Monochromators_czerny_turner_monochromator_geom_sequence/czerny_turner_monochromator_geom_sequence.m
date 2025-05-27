function out = model
%
% czerny_turner_monochromator_geom_sequence.m
%
% Model exported on May 26 2025, 21:32 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/Ray_Optics_Module/Spectrometers_and_Monochromators');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 2);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.geom('geom1').lengthUnit('mm');

model.param.set('theta_g', '28.76[deg]');
model.param.descr('theta_g', 'Grating''s angle');
model.param.set('theta_c', '11[deg]');
model.param.descr('theta_c', 'Collimating mirror''s angle');
model.param.set('theta_i', '77[deg]');
model.param.descr('theta_i', 'Imaging mirror''s angle');
model.param.set('theta_d', '6.76[deg]');
model.param.descr('theta_d', 'Detector''s angle');
model.param.set('Qix', '20[mm]');
model.param.descr('Qix', 'x-coordinate Qi');
model.param.set('Qiy', '34[mm]');
model.param.descr('Qiy', 'y-coordinate Qi');
model.param.set('Qcx', '40[mm]');
model.param.descr('Qcx', 'x-coordinate Qc');
model.param.set('Qcy', '40*tan(2*theta_c)');
model.param.descr('Qcy', 'y-coordinate Qc');
model.param.set('Qdx', '22.08[mm]');
model.param.descr('Qdx', 'x-coordinate Qd');
model.param.set('Qdy', '-24.12[mm]');
model.param.descr('Qdy', 'y-coordinate Qd');
model.param.set('Ri', '130[mm]');
model.param.descr('Ri', 'Imaging mirror''s radius of curvature');
model.param.set('Rc', '100[mm]');
model.param.descr('Rc', 'Collimating mirror''s radius of curvature');

model.geom('geom1').create('r1', 'Rectangle');
model.geom('geom1').feature('r1').set('size', [3 15]);
model.geom('geom1').feature('r1').set('base', 'center');
model.geom('geom1').feature('r1').set('pos', {'-1.5*cos(theta_g)' '0'});
model.geom('geom1').feature('r1').setIndex('pos', '-1.5*sin(theta_g)', 1);
model.geom('geom1').feature('r1').set('rot', 'theta_g');
model.geom('geom1').run('r1');
model.geom('geom1').create('r2', 'Rectangle');
model.geom('geom1').feature('r2').set('size', [3 15]);
model.geom('geom1').feature('r2').set('base', 'center');
model.geom('geom1').feature('r2').set('pos', {'Qcx' 'Qcy'});
model.geom('geom1').feature('r2').set('rot', 'theta_c');
model.geom('geom1').run('r2');
model.geom('geom1').create('c1', 'Circle');
model.geom('geom1').feature('c1').set('r', 'Rc');
model.geom('geom1').feature('c1').set('pos', {'Qcx-Rc*cos(theta_c)' '0'});
model.geom('geom1').feature('c1').setIndex('pos', 'Qcy-Rc*sin(theta_c)', 1);
model.geom('geom1').run('c1');
model.geom('geom1').create('dif1', 'Difference');
model.geom('geom1').feature('dif1').selection('input').set({'r2'});
model.geom('geom1').feature('dif1').selection('input2').set({'c1'});
model.geom('geom1').run('dif1');
model.geom('geom1').create('r3', 'Rectangle');
model.geom('geom1').feature('r3').set('size', [3 30]);
model.geom('geom1').feature('r3').set('base', 'center');
model.geom('geom1').feature('r3').set('pos', {'Qix' 'Qiy'});
model.geom('geom1').feature('r3').set('rot', 'theta_i');
model.geom('geom1').run('r3');
model.geom('geom1').create('c2', 'Circle');
model.geom('geom1').feature('c2').set('r', 'Ri');
model.geom('geom1').feature('c2').set('pos', {'Qix-Ri*cos(theta_i)' '0'});
model.geom('geom1').feature('c2').setIndex('pos', 'Qiy-Ri*sin(theta_i)', 1);
model.geom('geom1').run('c2');
model.geom('geom1').create('dif2', 'Difference');
model.geom('geom1').feature('dif2').selection('input').set({'r3'});
model.geom('geom1').feature('dif2').selection('input2').set({'c2'});
model.geom('geom1').run('dif2');
model.geom('geom1').create('r4', 'Rectangle');
model.geom('geom1').feature('r4').set('size', [30 3]);
model.geom('geom1').feature('r4').set('base', 'center');
model.geom('geom1').feature('r4').set('pos', {'Qdx+1.5*sin(theta_d)' '0'});
model.geom('geom1').feature('r4').setIndex('pos', 'Qdy-1.5*cos(theta_d)', 1);
model.geom('geom1').feature('r4').set('rot', 'theta_d');
model.geom('geom1').runPre('fin');

model.title([]);

model.description('');

model.label('czerny_turner_monochromator_geom_sequence.mph');

model.modelNode.label('Components');

out = model;
