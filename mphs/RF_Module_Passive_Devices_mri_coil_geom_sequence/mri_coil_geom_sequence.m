function out = model
%
% mri_coil_geom_sequence.m
%
% Model exported on May 26 2025, 21:32 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/RF_Module/Passive_Devices');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 3);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

% To import content from file, use:
% model.param.loadFile('FILENAME');
model.param.set('f0', '63.87[MHz]', 'Larmor frequency');
model.param.set('lda0', 'c_const/f0', 'Wavelength corresponding to Larmor frequency');
model.param.set('c_value', '28.5[pF]', 'Capacitance used on the rungs');
model.param.set('r_coil', '0.24[m]', 'Radius of the coil');
model.param.set('h_coil', '0.3[m]', 'Height of the coil');
model.param.set('l_element', '0.01[m]', 'Length of the capacitive elements');
model.param.set('r_coil_1', '0.24[m]');
model.param.set('l_element_1', '0.01[m]');
model.param.set('h_coil_1', '0.3[m]');
model.param.rename('r_coil_1', 't_ring');
model.param.set('t_ring', '0.015[m]');

model.geom('geom1').create('cyl1', 'Cylinder');
model.geom('geom1').feature('cyl1').set('r', 'r_coil');
model.geom('geom1').feature('cyl1').set('h', 'h_coil');
model.geom('geom1').feature('cyl1').set('pos', {'0' '0' '-h_coil/2'});
model.geom('geom1').feature('cyl1').setIndex('layername', 'Layer 1', 0);
model.geom('geom1').feature('cyl1').setIndex('layer', 't_ring', 0);
model.geom('geom1').feature('cyl1').set('layerside', false);
model.geom('geom1').feature('cyl1').set('layerbottom', true);
model.geom('geom1').feature('cyl1').set('layertop', true);
model.geom('geom1').run('cyl1');
model.geom('geom1').create('wp1', 'WorkPlane');
model.geom('geom1').feature('wp1').set('unite', true);
model.geom('geom1').feature('wp1').set('quickz', '-h_coil/2+t_ring');
model.geom('geom1').feature('wp1').geom.create('c1', 'Circle');
model.geom('geom1').feature('wp1').geom.feature('c1').set('r', 'r_coil');
model.geom('geom1').feature('wp1').geom.feature('c1').set('angle', 6);
model.geom('geom1').feature('wp1').geom.feature('c1').set('rot', -22.5);
model.geom('geom1').feature('wp1').geom.run('c1');
model.geom('geom1').feature('wp1').geom.create('ccur1', 'ConvertToCurve');
model.geom('geom1').feature('wp1').geom.feature('ccur1').selection('input').set({'c1'});
model.geom('geom1').feature('wp1').geom.run('ccur1');
model.geom('geom1').feature('wp1').geom.feature.create('del1', 'Delete');
model.geom('geom1').feature('wp1').geom.feature('del1').selection('input').init;
model.geom('geom1').feature('wp1').geom.feature('del1').selection('input').init(1);
model.geom('geom1').feature('wp1').geom.feature('del1').selection('input').set('ccur1', [2 3]);
model.geom('geom1').run('wp1');
model.geom('geom1').feature.create('ext1', 'Extrude');
model.geom('geom1').feature('ext1').set('inputhandling', 'keep');
model.geom('geom1').feature('ext1').setIndex('distance', 'h_coil-2*t_ring', 0);
model.geom('geom1').run('ext1');
model.geom('geom1').feature.create('ext2', 'Extrude');
model.geom('geom1').feature('ext2').setIndex('distance', 'l_element', 0);
model.geom('geom1').run('ext2');
model.geom('geom1').create('mov1', 'Move');
model.geom('geom1').feature('mov1').selection('input').set({'ext2'});
model.geom('geom1').feature('mov1').set('displz', '0 (h_coil-2*t_ring)/2-l_element/2 (h_coil-2*t_ring)-l_element');
model.geom('geom1').run('mov1');
model.geom('geom1').create('rot1', 'Rotate');
model.geom('geom1').feature('rot1').selection('input').set({'ext1' 'mov1'});
model.geom('geom1').feature('rot1').set('rot', '0 45 90 135 180 225 270 315');
model.geom('geom1').run('fin');
model.geom('geom1').run('rot1');
model.geom('geom1').create('csur1', 'ConvertToSurface');
model.geom('geom1').feature('csur1').selection('input').set({'cyl1' 'rot1'});
model.geom('geom1').run('csur1');
model.geom('geom1').feature.create('del1', 'Delete');
model.geom('geom1').feature('del1').selection('input').init;
model.geom('geom1').feature('del1').selection('input').init(2);

model.view('view1').set('renderwireframe', true);

model.geom('geom1').feature('del1').selection('input').set('csur1', [3 4 5 6 9 10 21 22 33 34 36 39 51 52 63 64]);
model.geom('geom1').run('del1');
model.geom('geom1').create('cyl2', 'Cylinder');
model.geom('geom1').feature('cyl2').set('r', 0.15);
model.geom('geom1').feature('cyl2').set('h', 'h_coil');
model.geom('geom1').feature('cyl2').set('pos', {'0' '0' '-h_coil/2'});
model.geom('geom1').feature('cyl2').setIndex('layername', 'Layer 1', 0);
model.geom('geom1').feature('cyl2').setIndex('layer', 'h_coil/2', 0);
model.geom('geom1').feature('cyl2').set('layerside', false);
model.geom('geom1').feature('cyl2').set('layertop', true);
model.geom('geom1').run('cyl2');
model.geom('geom1').create('cyl3', 'Cylinder');
model.geom('geom1').feature('cyl3').set('r', 'r_coil+0.1');
model.geom('geom1').feature('cyl3').set('h', 'h_coil+0.1');
model.geom('geom1').feature('cyl3').set('pos', {'0' '0' '-(h_coil+0.1)/2'});
model.geom('geom1').run('cyl3');
model.geom('geom1').create('sph1', 'Sphere');
model.geom('geom1').feature('sph1').set('r', 0.5);
model.geom('geom1').run('fin');

model.title([]);

model.description('');

model.label('mri_coil_geom_sequence.mph');

model.modelNode.label('Components');

out = model;
