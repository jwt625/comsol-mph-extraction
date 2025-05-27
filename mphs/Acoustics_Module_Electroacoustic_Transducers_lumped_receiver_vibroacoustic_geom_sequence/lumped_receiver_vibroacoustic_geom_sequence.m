function out = model
%
% lumped_receiver_vibroacoustic_geom_sequence.m
%
% Model exported on May 26 2025, 21:25 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/Acoustics_Module/Electroacoustic_Transducers');

% To import content from file, use:
% model.param.loadFile('FILENAME');
model.param.set('Ltube', '9.00[mm]', 'Silicone tube length');
model.param.set('Ttube', '0.5[mm]', 'Silicone tube thickness');
model.param.set('d_2cc', '18.00[mm]', 'Coupler diameter');
model.param.set('L_2cc', '7.00[mm]', 'Coupler length');
model.param.set('SToffset', '0.5[mm]', 'Silicone tube spout offset');
model.param.set('CToffset', '1.5[mm]', 'Silicone tube coupler offset');
model.param.set('LtubeC', '2.5[mm]', 'Coupler tube adapter length');
model.param.set('Lx', '7.870000e-03[m]', 'Receiver box length (local x)');
model.param.set('Ly', '4.090000e-03[m]', 'Receiver box width (local y)');
model.param.set('Lz', '2.790000e-03[m]', 'Receiver box height (local z)');
model.param.set('TL', '1.600000e-03[m]', 'Receiver tube length from box face (local x)');
model.param.set('Td', '1.00e-03[m]', 'Receiver tube inner diameter');
model.param.set('Th', '3.250000e-04[m]', 'Receiver tube axis position with reference to box center (local z)');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 3);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.geom('geom1').create('blk1', 'Block');
model.geom('geom1').feature('blk1').set('size', {'Lx' 'Ly' 'Lz'});
model.geom('geom1').feature('blk1').set('base', 'center');
model.geom('geom1').run('blk1');
model.geom('geom1').create('cyl1', 'Cylinder');
model.geom('geom1').feature('cyl1').set('r', 'Td/2');
model.geom('geom1').feature('cyl1').set('h', 'TL');
model.geom('geom1').feature('cyl1').set('pos', {'Lx/2' '0' 'Th'});
model.geom('geom1').feature('cyl1').set('axistype', 'x');
model.geom('geom1').run('cyl1');
model.geom('geom1').create('cyl2', 'Cylinder');
model.geom('geom1').feature('cyl2').set('r', 'Td/2+Ttube');
model.geom('geom1').feature('cyl2').set('h', 'Ltube');
model.geom('geom1').feature('cyl2').set('pos', {'Lx/2+SToffset' '0' '0'});
model.geom('geom1').feature('cyl2').setIndex('pos', 'Th', 2);
model.geom('geom1').feature('cyl2').set('axistype', 'x');
model.geom('geom1').feature('cyl2').setIndex('layername', 'Layer 1', 0);
model.geom('geom1').feature('cyl2').setIndex('layer', 'Ttube', 0);
model.geom('geom1').run('cyl2');
model.geom('geom1').create('cyl3', 'Cylinder');
model.geom('geom1').feature('cyl3').set('r', 'Td/2');
model.geom('geom1').feature('cyl3').set('h', 'LtubeC');
model.geom('geom1').feature('cyl3').set('pos', {'Lx/2+SToffset+Ltube-(LtubeC-CToffset)' '0' '0'});
model.geom('geom1').feature('cyl3').setIndex('pos', 'Th', 2);
model.geom('geom1').feature('cyl3').set('axistype', 'x');
model.geom('geom1').run('cyl3');
model.geom('geom1').create('cyl4', 'Cylinder');
model.geom('geom1').feature('cyl4').set('r', 'd_2cc/2');
model.geom('geom1').feature('cyl4').set('h', 'L_2cc');
model.geom('geom1').feature('cyl4').set('pos', {'Lx/2+SToffset+Ltube+CToffset' '0' '0'});
model.geom('geom1').feature('cyl4').setIndex('pos', 'Th', 2);
model.geom('geom1').feature('cyl4').set('axistype', 'x');
model.geom('geom1').run('cyl4');
model.geom('geom1').create('wp1', 'WorkPlane');
model.geom('geom1').feature('wp1').set('unite', true);
model.geom('geom1').feature('wp1').set('planetype', 'faceparallel');

model.view('view1').set('renderwireframe', true);

model.geom('geom1').feature('wp1').selection('face').set('cyl1', 4);
model.geom('geom1').run('wp1');
model.geom('geom1').create('wp2', 'WorkPlane');
model.geom('geom1').feature('wp2').set('unite', true);
model.geom('geom1').feature('wp2').set('planetype', 'faceparallel');
model.geom('geom1').feature('wp2').selection('face').set('cyl3', 3);
model.geom('geom1').run('wp2');
model.geom('geom1').create('par1', 'Partition');
model.geom('geom1').feature('par1').selection('input').set({'cyl2'});
model.geom('geom1').feature('par1').set('partitionwith', 'workplane');
model.geom('geom1').feature('par1').set('workplane', 'wp1');
model.geom('geom1').run('par1');
model.geom('geom1').create('par2', 'Partition');
model.geom('geom1').feature('par2').selection('input').set({'par1'});
model.geom('geom1').feature('par2').set('partitionwith', 'workplane');
model.geom('geom1').run('par2');
model.geom('geom1').create('mov1', 'Move');
model.geom('geom1').feature('mov1').selection('input').set({'blk1' 'cyl1' 'cyl3' 'cyl4' 'par2'});
model.geom('geom1').feature('mov1').set('displx', '1[mm]');
model.geom('geom1').feature('mov1').set('disply', '1[mm]');
model.geom('geom1').run('mov1');
model.geom('geom1').create('rot1', 'Rotate');
model.geom('geom1').feature('rot1').selection('input').set({'mov1'});
model.geom('geom1').feature('rot1').set('rot', 30);
model.geom('geom1').feature('rot1').set('pos', {'1[mm]' '1[mm]' '0'});
model.geom('geom1').feature('rot1').set('axistype', 'y');
model.geom('geom1').runPre('fin');
model.geom('geom1').run('fin');

model.title([]);

model.description('');

model.label('lumped_receiver_vibroacoustic_geom_sequence.mph');

model.modelNode.label('Components');

out = model;
