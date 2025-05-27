function out = model
%
% residual_stress_resonator_2d_geom_sequence.m
%
% Model exported on May 26 2025, 21:30 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/MEMS_Module/Actuators');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 2);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.physics.create('solid', 'SolidMechanics', 'geom1');
model.physics('solid').model('comp1');

model.geom('geom1').lengthUnit([native2unicode(hex2dec({'00' 'b5'}), 'unicode') 'm']);
model.geom('geom1').create('r1', 'Rectangle');
model.geom('geom1').feature('r1').set('size', [250 120]);
model.geom('geom1').run('r1');
model.geom('geom1').create('r2', 'Rectangle');
model.geom('geom1').feature('r2').set('size', [2 200]);
model.geom('geom1').feature('r2').set('pos', [100 120]);
model.geom('geom1').run('r2');
model.geom('geom1').create('arr1', 'Array');
model.geom('geom1').feature('arr1').selection('input').set({'r2'});
model.geom('geom1').feature('arr1').set('fullsize', [2 2]);
model.geom('geom1').feature('arr1').set('displ', [48 -320]);
model.geom('geom1').runPre('fin');

model.modelNode.create('comp2', true);

model.geom.create('geom2', 2);
model.geom('geom2').model('comp2');

model.mesh.create('mesh2', 'geom2');

model.geom('geom2').lengthUnit([native2unicode(hex2dec({'00' 'b5'}), 'unicode') 'm']);
model.geom('geom2').create('r1', 'Rectangle');
model.geom('geom2').feature('r1').set('size', [250 120]);
model.geom('geom2').run('r1');
model.geom('geom2').create('r2', 'Rectangle');
model.geom('geom2').feature('r2').set('size', [2 172]);
model.geom('geom2').feature('r2').set('pos', [100 120]);
model.geom('geom2').run('r2');
model.geom('geom2').create('r3', 'Rectangle');
model.geom('geom2').feature('r3').set('size', [12 2]);
model.geom('geom2').feature('r3').set('pos', [100 290]);
model.geom('geom2').run('r3');
model.geom('geom2').create('r4', 'Rectangle');
model.geom('geom2').feature('r4').set('size', [2 148]);
model.geom('geom2').feature('r4').set('pos', [110 144]);
model.geom('geom2').run('r4');
model.geom('geom2').create('mir1', 'Mirror');
model.geom('geom2').feature('mir1').selection('input').set({'r2' 'r3' 'r4'});
model.geom('geom2').feature('mir1').set('keep', true);
model.geom('geom2').feature('mir1').set('pos', [125 0]);
model.geom('geom2').run('mir1');
model.geom('geom2').create('mir2', 'Mirror');
model.geom('geom2').feature('mir2').selection('input').set({'mir1' 'r2' 'r3' 'r4'});
model.geom('geom2').feature('mir2').set('keep', true);
model.geom('geom2').feature('mir2').set('pos', [0 60]);
model.geom('geom2').feature('mir2').set('axis', [0 1]);
model.geom('geom2').runPre('fin');

model.title([]);

model.description('');

model.label('residual_stress_resonator_2d_geom_sequence.mph');

model.modelNode.label('Components');

out = model;
