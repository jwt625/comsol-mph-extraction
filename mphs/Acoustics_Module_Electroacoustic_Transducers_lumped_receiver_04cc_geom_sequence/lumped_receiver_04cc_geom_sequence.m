function out = model
%
% lumped_receiver_04cc_geom_sequence.m
%
% Model exported on May 26 2025, 21:25 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/Acoustics_Module/Electroacoustic_Transducers');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 3);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.geom('geom1').create('cyl1', 'Cylinder');
model.geom('geom1').feature('cyl1').set('selresult', true);
model.geom('geom1').feature('cyl1').set('r', '0.5[mm]');
model.geom('geom1').feature('cyl1').set('h', '49[mm]');
model.geom('geom1').run('cyl1');
model.geom('geom1').create('cyl2', 'Cylinder');
model.geom('geom1').feature('cyl2').set('selresult', true);
model.geom('geom1').feature('cyl2').set('r', '4.72[mm]');
model.geom('geom1').feature('cyl2').set('h', '5.7[mm]');
model.geom('geom1').feature('cyl2').set('pos', {'0' '0' '49[mm]'});
model.geom('geom1').run('cyl2');
model.geom('geom1').create('cyl3', 'Cylinder');
model.geom('geom1').feature('cyl3').set('r', '3.175[mm]');
model.geom('geom1').feature('cyl3').set('h', '0.5[mm]');
model.geom('geom1').feature('cyl3').set('pos', {'0' '0' '54.2[mm]'});
model.geom('geom1').run('cyl3');
model.geom('geom1').create('dif1', 'Difference');
model.geom('geom1').feature('dif1').selection('input').set({'cyl2'});
model.geom('geom1').feature('dif1').selection('input2').set({'cyl3'});
model.geom('geom1').run('fin');
model.geom('geom1').create('sel1', 'ExplicitSelection');
model.geom('geom1').feature('sel1').label('Normal Acceleration');
model.geom('geom1').feature('sel1').selection('selection').init(2);
model.geom('geom1').feature('sel1').selection('selection').set('fin', 10);
model.geom('geom1').run('sel1');
model.geom('geom1').create('sel2', 'ExplicitSelection');
model.geom('geom1').feature('sel2').label('Impedance');
model.geom('geom1').feature('sel2').selection('selection').init(2);
model.geom('geom1').feature('sel2').selection('selection').set('fin', 7);
model.geom('geom1').run('sel2');

model.title([]);

model.description('');

model.label('lumped_receiver_04cc_geom_sequence.mph');

model.modelNode.label('Components');

out = model;
