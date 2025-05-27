function out = model
%
% condensation_electronic_device_geom_sequence.m
%
% Model exported on May 26 2025, 21:29 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/Heat_Transfer_Module/Power_Electronics_and_Electronic_Cooling');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 2);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.geom('geom1').lengthUnit('mm');
model.geom('geom1').create('sq1', 'Square');
model.geom('geom1').feature('sq1').set('size', 50);
model.geom('geom1').run('sq1');
model.geom('geom1').create('sq2', 'Square');
model.geom('geom1').feature('sq2').set('size', 49);
model.geom('geom1').feature('sq2').set('pos', [0.5 0.5]);
model.geom('geom1').run('sq2');
model.geom('geom1').create('r1', 'Rectangle');
model.geom('geom1').feature('r1').label('Electronic Component');
model.geom('geom1').feature('r1').set('size', [14 4]);
model.geom('geom1').feature('r1').set('pos', [18 0.5]);
model.geom('geom1').feature('r1').set('selresult', true);
model.geom('geom1').run('r1');
model.geom('geom1').create('r2', 'Rectangle');
model.geom('geom1').feature('r2').set('size', [0.5 1]);
model.geom('geom1').feature('r2').set('pos', [0 41]);
model.geom('geom1').feature.duplicate('r3', 'r2');
model.geom('geom1').feature('r3').set('pos', [49.5 15]);
model.geom('geom1').run('r3');
model.geom('geom1').create('uni1', 'Union');
model.geom('geom1').feature('uni1').selection('input').set({'r2' 'r3' 'sq2'});
model.geom('geom1').feature('uni1').set('intbnd', false);
model.geom('geom1').run('fin');
model.geom('geom1').create('sel1', 'ExplicitSelection');
model.geom('geom1').feature('sel1').label('Moist Air');
model.geom('geom1').feature('sel1').selection('selection').set('fin', 2);

model.title([]);

model.description('');

model.label('condensation_electronic_device_geom_sequence.mph');

model.modelNode.label('Components');

out = model;
