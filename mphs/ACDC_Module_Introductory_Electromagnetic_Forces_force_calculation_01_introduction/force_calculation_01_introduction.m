function out = model
%
% force_calculation_01_introduction.m
%
% Model exported on May 26 2025, 21:25 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/ACDC_Module/Introductory_Electromagnetic_Forces');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 3);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

% To import content from file, use:
% model.param.loadFile('FILENAME');
model.param.set('Rl', '1[m]', 'Magnetized rod, length');
model.param.set('Rd', '1[m]', 'Magnetized rod, distance');
model.param.set('Ra', '-90[deg]', 'Magnetized rod, angle');
model.param.set('Rr', '0.05[m]', 'Magnetized rod, radius');
model.param.set('Rrf', '0.01[m]', 'Radius of the fillet applied to the rods poles');
model.param.set('Cs', '10[m]', 'Exterior cube size');

model.geom('geom1').label('Geometry 1 (Magnetic Force Verification)');

model.view('view1').set('showgrid', false);
model.view('view1').set('showaxisorientation', false);

model.geom('geom1').create('wp1', 'WorkPlane');
model.geom('geom1').feature('wp1').set('unite', true);
model.geom('geom1').feature('wp1').set('quickplane', 'xz');
model.geom('geom1').feature('wp1').geom.create('r1', 'Rectangle');
model.geom('geom1').feature('wp1').geom.feature('r1').set('size', {'Rr' 'Rl'});
model.geom('geom1').feature('wp1').geom.feature('r1').set('pos', {'0' '-Rl/2'});
model.geom('geom1').feature('wp1').geom.feature('r1').setIndex('layer', 'Rr', 0);
model.geom('geom1').feature('wp1').geom.feature('r1').set('layerbottom', false);
model.geom('geom1').feature('wp1').geom.feature('r1').set('layertop', true);
model.geom('geom1').feature('wp1').geom.run('r1');
model.geom('geom1').feature('wp1').geom.create('fil1', 'Fillet');
model.geom('geom1').feature('wp1').geom.feature('fil1').set('radius', 'Rrf');
model.geom('geom1').feature('wp1').geom.feature('fil1').selection('pointinsketch').set('r1', [4 6]);
model.geom('geom1').feature('wp1').geom.run('fil1');
model.geom('geom1').feature('wp1').geom.create('r2', 'Rectangle');
model.geom('geom1').feature('wp1').geom.feature('r2').set('size', {'5*Rr' 'Rl+10*Rr'});
model.geom('geom1').feature('wp1').geom.feature('r2').set('pos', {'0' '-(Rl+10*Rr)/2'});
model.geom('geom1').feature('wp1').geom.run('r2');
model.geom('geom1').feature('wp1').geom.create('fil2', 'Fillet');
model.geom('geom1').feature('wp1').geom.feature('fil2').set('radius', '5*Rr');
model.geom('geom1').feature('wp1').geom.feature('fil2').selection('pointinsketch').set('r2', [2 3]);
model.geom('geom1').feature('wp1').geom.run('fil2');
model.geom('geom1').run('wp1');
model.geom('geom1').feature.create('rev1', 'Revolve');
model.geom('geom1').feature('rev1').set('angtype', 'full');
model.geom('geom1').feature('rev1').set('origfaces', false);
model.geom('geom1').runPre('fin');

model.view('view1').set('renderwireframe', true);

model.geom('geom1').create('mov1', 'Move');
model.geom('geom1').feature('mov1').selection('input').set({'rev1'});
model.geom('geom1').feature('mov1').set('displx', 'Rd/2');
model.geom('geom1').runPre('fin');
model.geom('geom1').create('wp2', 'WorkPlane');
model.geom('geom1').feature('wp2').set('unite', true);
model.geom('geom1').feature('wp2').set('quickplane', 'yz');
model.geom('geom1').feature('wp2').geom.create('c1', 'Circle');
model.geom('geom1').feature('wp2').geom.feature('c1').set('r', '1.5*sqrt((Rl/2)^2+(Rd/2)^2)');
model.geom('geom1').feature('wp2').geom.feature('c1').set('angle', 180);
model.geom('geom1').feature('wp2').geom.feature('c1').set('rot', 90);
model.geom('geom1').feature('wp2').geom.run('c1');
model.geom('geom1').run('wp2');
model.geom('geom1').feature.create('rev2', 'Revolve');
model.geom('geom1').feature('rev2').set('angtype', 'specang');
model.geom('geom1').feature('rev2').set('angle2', 180);
model.geom('geom1').runPre('fin');

model.modelNode.create('comp2', true);

model.geom.create('geom2', 3);
model.geom('geom2').model('comp2');

model.mesh.create('mesh2', 'geom2');

model.geom('geom2').label('Geometry 2 (Magnetic Torque Verification)');

model.view('view4').set('showgrid', false);
model.view('view4').set('showaxisorientation', false);

model.geom('geom2').insertFile('force_calculation_01_introduction.mph', 'geom1');
model.geom('geom2').run('fin');

model.view('view4').set('renderwireframe', true);

model.geom('geom2').feature.remove('rev2');
model.geom('geom2').feature.remove('wp2');
model.geom('geom2').feature.remove('mov1');
model.geom('geom2').run('fin');
model.geom('geom2').run('rev1');
model.geom('geom2').create('rot1', 'Rotate');
model.geom('geom2').feature('rot1').selection('input').set({'rev1'});
model.geom('geom2').feature('rot1').set('rot', 'Ra');
model.geom('geom2').feature('rot1').set('axistype', 'y');
model.geom('geom2').runPre('fin');
model.geom('geom2').create('sph1', 'Sphere');
model.geom('geom2').feature('sph1').set('r', 'Rl');
model.geom('geom2').runPre('fin');
model.geom('geom2').create('blk1', 'Block');
model.geom('geom2').feature('blk1').set('type', 'surface');
model.geom('geom2').feature('blk1').set('size', {'Cs' 'Cs' 'Cs'});
model.geom('geom2').feature('blk1').set('base', 'center');
model.geom('geom2').runPre('fin');

model.view('view4').set('showgrid', true);
model.view('view4').set('showaxisorientation', true);
model.view('view1').set('showgrid', true);
model.view('view1').set('showaxisorientation', true);

model.title(['Force Calculation 1 ' native2unicode(hex2dec({'20' '14'}), 'unicode') ' Introduction']);

model.description(['This model serves as a basis for subsequent tutorials in this series (the Magnetic Force BEM FEM, and Magnetic Torque BEM FEM tutorials). It provides a general introduction, along with the geometries used in this series. Detailed modeling instructions for the geometries are included.' newline  newline 'Experienced users with little or no interest in geometry building, may choose to skip this part and continue with one of the aforementioned tutorials. When you are new to COMSOL however, or new to this series, it is worthwhile to take some time for this, as it will help you get familiar with the basics.']);

model.label('force_calculation_01_introduction.mph');

model.modelNode.label('Components');

out = model;
