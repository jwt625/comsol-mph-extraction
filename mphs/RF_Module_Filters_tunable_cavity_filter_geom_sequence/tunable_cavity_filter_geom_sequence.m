function out = model
%
% tunable_cavity_filter_geom_sequence.m
%
% Model exported on May 26 2025, 21:32 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/RF_Module/Filters');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 3);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

% To import content from file, use:
% model.param.loadFile('FILENAME');
model.param.set('thickness', '60[mil]', 'Substrate thickness');
model.param.set('l_slot', '40[mm]', 'Slot length');
model.param.set('w_slot', '1.5[mm]', 'Slot width');
model.param.set('x_slot', '32[mm]', 'Slot location');
model.param.set('l_feed', '10[mm]', 'Feed line length');
model.param.set('gap_post', '150[um]', 'Gap between piezo actuator and metallic post');

model.geom('geom1').lengthUnit('mm');
model.geom('geom1').create('blk1', 'Block');
model.geom('geom1').feature('blk1').label('Cavity');
model.geom('geom1').feature('blk1').set('size', [100 50 50]);
model.geom('geom1').feature('blk1').set('base', 'center');
model.geom('geom1').run('blk1');
model.geom('geom1').create('blk2', 'Block');
model.geom('geom1').feature('blk2').label('Substrate');
model.geom('geom1').feature('blk2').set('size', {'25' '50' 'thickness'});
model.geom('geom1').feature('blk2').set('base', 'center');
model.geom('geom1').feature('blk2').set('pos', {'-37.5' '0' '25+thickness/2'});
model.geom('geom1').run('blk2');
model.geom('geom1').create('blk3', 'Block');
model.geom('geom1').feature('blk3').label('Air block');
model.geom('geom1').feature('blk3').set('size', [25 50 10]);
model.geom('geom1').feature('blk3').set('base', 'center');
model.geom('geom1').feature('blk3').set('pos', [-37.5 0 30]);
model.geom('geom1').run('blk3');

model.view('view1').set('renderwireframe', true);

model.geom('geom1').create('blk4', 'Block');
model.geom('geom1').feature('blk4').label('Feed_line');
model.geom('geom1').feature('blk4').set('size', {'l_feed+w_slot' '1' '1'});
model.geom('geom1').feature('blk4').setIndex('size', 3.2, 1);
model.geom('geom1').feature('blk4').setIndex('size', 'thickness', 2);
model.geom('geom1').feature('blk4').set('base', 'center');
model.geom('geom1').feature('blk4').set('pos', {'-x_slot-l_feed/2' '0' '0'});
model.geom('geom1').feature('blk4').setIndex('pos', '25+thickness/2', 2);
model.geom('geom1').run('blk4');
model.geom('geom1').create('wp1', 'WorkPlane');
model.geom('geom1').feature('wp1').set('unite', true);
model.geom('geom1').feature('wp1').set('quickz', 25);
model.geom('geom1').feature('wp1').geom.create('r1', 'Rectangle');
model.geom('geom1').feature('wp1').geom.feature('r1').set('size', {'w_slot' 'l_slot'});
model.geom('geom1').feature('wp1').geom.feature('r1').set('base', 'center');
model.geom('geom1').feature('wp1').geom.feature('r1').set('pos', {'-x_slot' '0'});
model.geom('geom1').feature('wp1').geom.run('r1');
model.geom('geom1').run('wp1');
model.geom('geom1').create('mir1', 'Mirror');
model.geom('geom1').feature('mir1').selection('input').set({'blk2' 'blk3' 'blk4' 'wp1'});
model.geom('geom1').feature('mir1').set('keep', true);
model.geom('geom1').feature('mir1').set('axis', [1 0 0]);
model.geom('geom1').runPre('fin');
model.geom('geom1').create('blk5', 'Block');
model.geom('geom1').feature('blk5').label('Post');
model.geom('geom1').feature('blk5').set('size', {'15' '15' '50-gap_post'});
model.geom('geom1').feature('blk5').set('pos', [-7.5 -7.5 -25]);
model.geom('geom1').run('blk5');
model.geom('geom1').create('cyl1', 'Cylinder');
model.geom('geom1').feature('cyl1').label('Piezo actuator');
model.geom('geom1').feature('cyl1').set('r', 21);
model.geom('geom1').feature('cyl1').set('h', 0.5);
model.geom('geom1').feature('cyl1').set('pos', [0 0 25]);
model.geom('geom1').run('cyl1');
model.geom('geom1').create('dif1', 'Difference');
model.geom('geom1').feature('dif1').selection('input').set({'blk1'});
model.geom('geom1').feature('dif1').selection('input2').set({'blk5'});
model.geom('geom1').runPre('fin');

model.title([]);

model.description('');

model.label('tunable_cavity_filter_geom_sequence.mph');

model.modelNode.label('Components');

out = model;
