function out = model
%
% dielectrophoretic_separation_geom_sequence.m
%
% Model exported on May 26 2025, 21:31 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/Particle_Tracing_Module/Fluid_Flow');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 2);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.geom('geom1').lengthUnit([native2unicode(hex2dec({'00' 'b5'}), 'unicode') 'm']);
model.geom('geom1').create('r1', 'Rectangle');
model.geom('geom1').feature('r1').set('size', {'560/2' '40'});
model.geom('geom1').feature('r1').set('pos', [0 -20]);
model.geom('geom1').run('r1');
model.geom('geom1').create('r2', 'Rectangle');
model.geom('geom1').feature('r2').set('size', [40 200]);
model.geom('geom1').feature('r2').set('pos', [9 -9]);
model.geom('geom1').feature('r2').set('rot', 45);
model.geom('geom1').run('r2');
model.geom('geom1').create('mir1', 'Mirror');
model.geom('geom1').feature('mir1').selection('input').set({'r2'});
model.geom('geom1').feature('mir1').set('axis', [0 1]);
model.geom('geom1').feature('mir1').set('keep', true);
model.geom('geom1').run('mir1');
model.geom('geom1').create('mir2', 'Mirror');
model.geom('geom1').feature('mir2').selection('input').set({'mir1' 'r1' 'r2'});
model.geom('geom1').feature('mir2').set('keep', true);
model.geom('geom1').feature('mir2').set('pos', {'560/2' '0'});
model.geom('geom1').run('mir2');
model.geom('geom1').create('sq1', 'Square');
model.geom('geom1').feature('sq1').set('size', 40);
model.geom('geom1').feature('sq1').set('pos', [20 20]);
model.geom('geom1').run('sq1');
model.geom('geom1').create('arr1', 'Array');
model.geom('geom1').feature('arr1').selection('input').set({'sq1'});
model.geom('geom1').feature('arr1').set('fullsize', [7 1]);
model.geom('geom1').feature('arr1').set('displ', [80 0]);
model.geom('geom1').run('arr1');
model.geom('geom1').create('uni1', 'Union');
model.geom('geom1').feature('uni1').selection('input').set({'arr1' 'mir1' 'mir2' 'r1' 'r2'});
model.geom('geom1').feature('uni1').set('intbnd', false);
model.geom('geom1').run('uni1');
model.geom('geom1').create('fil1', 'Fillet');
model.geom('geom1').feature('fil1').selection('point').set('uni1', [5 6 8 9 11 13 15 17 19 22 24 26 28 30 32 34 35 37]);
model.geom('geom1').feature('fil1').set('radius', 5);
model.geom('geom1').runPre('fin');

model.title([]);

model.description('');

model.label('dielectrophoretic_separation_geom_sequence.mph');

model.modelNode.label('Components');

out = model;
