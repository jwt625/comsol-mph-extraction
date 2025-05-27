function out = model
%
% absorptive_muffler_geom_sequence.m
%
% Model exported on May 26 2025, 21:25 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/Acoustics_Module/Automotive');

% To import content from file, use:
% model.param.loadFile('FILENAME');
model.param.set('L', '600[mm]', 'Muffler length');
model.param.set('H', '150[mm]', 'Muffler height');
model.param.set('W', '300[mm]', 'Muffler width');
model.param.set('L_io', '150[mm]', 'Inlet and outlet length');
model.param.set('R_io', '40[mm]', 'Inlet and outlet radius');
model.param.set('D', '15[mm]', 'Liner thickness');
model.param.set('d_center', '60[mm]', 'Distance of the inlet and outlet to the center of the muffler');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 3);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.geom('geom1').lengthUnit('mm');
model.geom('geom1').create('wp1', 'WorkPlane');
model.geom('geom1').feature('wp1').set('unite', true);
model.geom('geom1').feature('wp1').set('quickplane', 'yz');
model.geom('geom1').feature('wp1').geom.create('r1', 'Rectangle');
model.geom('geom1').feature('wp1').geom.feature('r1').set('size', {'W' 'H'});
model.geom('geom1').feature('wp1').geom.feature('r1').set('base', 'center');
model.geom('geom1').feature('wp1').geom.run('r1');
model.geom('geom1').feature('wp1').geom.create('fil1', 'Fillet');
model.geom('geom1').feature('wp1').geom.feature('fil1').selection('pointinsketch').set('r1', [1 2 3 4]);
model.geom('geom1').feature('wp1').geom.feature('fil1').set('radius', 'H/2');
model.geom('geom1').feature('wp1').geom.run('fil1');
model.geom('geom1').feature('wp1').geom.create('r2', 'Rectangle');
model.geom('geom1').feature('wp1').geom.feature('r2').set('size', {'W-2*D' 'H-2*D'});
model.geom('geom1').feature('wp1').geom.feature('r2').set('base', 'center');
model.geom('geom1').feature('wp1').geom.run('r2');
model.geom('geom1').feature('wp1').geom.create('fil2', 'Fillet');
model.geom('geom1').feature('wp1').geom.feature('fil2').selection('pointinsketch').set('r2', [1 2 3 4]);
model.geom('geom1').feature('wp1').geom.feature('fil2').set('radius', '(H-2*D)/2');
model.geom('geom1').feature('wp1').geom.run('fil2');
model.geom('geom1').run('wp1');
model.geom('geom1').feature.create('ext1', 'Extrude');
model.geom('geom1').feature('ext1').set('workplane', 'wp1');
model.geom('geom1').feature('ext1').selection('input').set({'wp1'});
model.geom('geom1').feature('ext1').setIndex('distance', 'L', 0);
model.geom('geom1').run('ext1');
model.geom('geom1').create('cyl1', 'Cylinder');
model.geom('geom1').feature('cyl1').set('r', 'R_io');
model.geom('geom1').feature('cyl1').set('h', 'L_io');
model.geom('geom1').feature('cyl1').set('pos', {'-L_io' 'd_center' '0'});
model.geom('geom1').feature('cyl1').set('axistype', 'cartesian');
model.geom('geom1').feature('cyl1').set('ax3', [1 0 0]);
model.geom('geom1').run('cyl1');
model.geom('geom1').create('cyl2', 'Cylinder');
model.geom('geom1').feature('cyl2').set('r', 'R_io');
model.geom('geom1').feature('cyl2').set('h', 'L_io');
model.geom('geom1').feature('cyl2').set('pos', {'L' '-d_center' '0'});
model.geom('geom1').feature('cyl2').set('axistype', 'cartesian');
model.geom('geom1').feature('cyl2').set('ax3', [1 0 0]);
model.geom('geom1').runPre('fin');

model.title([]);

model.description('');

model.label('absorptive_muffler_geom_sequence.mph');

model.modelNode.label('Components');

out = model;
