function out = model
%
% capacitor_tunable_geom_sequence.m
%
% Model exported on May 26 2025, 21:24 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/ACDC_Module/Devices,_Capacitive');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 3);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.geom('geom1').lengthUnit([native2unicode(hex2dec({'00' 'b5'}), 'unicode') 'm']);
model.geom('geom1').create('blk1', 'Block');
model.geom('geom1').feature('blk1').set('size', [22 60 8]);
model.geom('geom1').feature('blk1').set('pos', [0 240 46]);
model.geom('geom1').run('blk1');
model.geom('geom1').create('blk2', 'Block');
model.geom('geom1').feature('blk2').set('size', [40 22 8]);
model.geom('geom1').feature('blk2').set('pos', [22 259 46]);
model.geom('geom1').run('blk2');
model.geom('geom1').create('blk3', 'Block');
model.geom('geom1').feature('blk3').set('size', [176 262 8]);
model.geom('geom1').feature('blk3').set('pos', [62 19 46]);
model.geom('geom1').run('blk3');
model.geom('geom1').create('blk4', 'Block');
model.geom('geom1').feature('blk4').set('size', [40 22 8]);
model.geom('geom1').feature('blk4').set('pos', [238 259 46]);
model.geom('geom1').run('blk4');
model.geom('geom1').create('blk5', 'Block');
model.geom('geom1').feature('blk5').set('size', [22 60 8]);
model.geom('geom1').feature('blk5').set('pos', [278 240 46]);
model.geom('geom1').run('blk5');
model.geom('geom1').create('blk6', 'Block');
model.geom('geom1').feature('blk6').set('size', [40 22 8]);
model.geom('geom1').feature('blk6').set('pos', [238 19 46]);
model.geom('geom1').run('blk6');
model.geom('geom1').create('blk7', 'Block');
model.geom('geom1').feature('blk7').set('size', [22 60 8]);
model.geom('geom1').feature('blk7').set('pos', [278 0 46]);
model.geom('geom1').run('blk7');
model.geom('geom1').create('blk8', 'Block');
model.geom('geom1').feature('blk8').set('size', [40 22 8]);
model.geom('geom1').feature('blk8').set('pos', [22 19 46]);
model.geom('geom1').run('blk8');
model.geom('geom1').create('blk9', 'Block');
model.geom('geom1').feature('blk9').set('size', [22 229 8]);
model.geom('geom1').feature('blk9').set('pos', [0 41 0]);
model.geom('geom1').run('blk9');
model.geom('geom1').create('blk10', 'Block');
model.geom('geom1').feature('blk10').set('size', [40 22 8]);
model.geom('geom1').feature('blk10').set('pos', [-40 139 0]);
model.geom('geom1').run('blk10');
model.geom('geom1').create('cyl1', 'Cylinder');
model.geom('geom1').feature('cyl1').set('r', 5.5);
model.geom('geom1').feature('cyl1').set('h', 38);
model.geom('geom1').feature('cyl1').set('pos', [11 250 8]);
model.geom('geom1').run('cyl1');
model.geom('geom1').create('uni1', 'Union');
model.geom('geom1').feature('uni1').selection('input').set({'blk1' 'blk10' 'blk2' 'blk3' 'blk4' 'blk5' 'blk6' 'blk7' 'blk8' 'blk9'  ...
'cyl1'});
model.geom('geom1').feature('uni1').set('intbnd', false);
model.geom('geom1').runPre('fin');
model.geom('geom1').create('blk11', 'Block');
model.geom('geom1').feature('blk11').set('size', [176 262 8]);
model.geom('geom1').feature('blk11').set('pos', [62 19 8]);
model.geom('geom1').run('blk11');
model.geom('geom1').create('blk12', 'Block');
model.geom('geom1').feature('blk12').set('size', [181 22 8]);
model.geom('geom1').feature('blk12').set('pos', [139 139 0]);
model.geom('geom1').run('blk12');
model.geom('geom1').create('uni2', 'Union');
model.geom('geom1').feature('uni2').selection('input').set({'blk11' 'blk12'});
model.geom('geom1').feature('uni2').set('intbnd', false);
model.geom('geom1').run('uni2');

model.title([]);

model.description('');

model.label('capacitor_tunable_geom_sequence.mph');

model.modelNode.label('Components');

out = model;
