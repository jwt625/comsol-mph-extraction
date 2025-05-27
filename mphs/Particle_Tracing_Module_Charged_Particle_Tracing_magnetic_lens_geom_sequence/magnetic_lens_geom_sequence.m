function out = model
%
% magnetic_lens_geom_sequence.m
%
% Model exported on May 26 2025, 21:31 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/Particle_Tracing_Module/Charged_Particle_Tracing');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 3);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.geom('geom1').lengthUnit('mm');
model.geom('geom1').create('cyl1', 'Cylinder');
model.geom('geom1').feature('cyl1').set('r', 10);
model.geom('geom1').feature('cyl1').set('h', 2.5);
model.geom('geom1').run('cyl1');
model.geom('geom1').create('cyl2', 'Cylinder');
model.geom('geom1').feature('cyl2').set('r', 6);
model.geom('geom1').feature('cyl2').set('h', 2.5);
model.geom('geom1').run('cyl2');
model.geom('geom1').feature.duplicate('cyl3', 'cyl1');
model.geom('geom1').feature('cyl3').set('pos', [0 0 -7.5]);
model.geom('geom1').run('cyl3');
model.geom('geom1').create('cyl4', 'Cylinder');
model.geom('geom1').feature('cyl4').set('r', 2);
model.geom('geom1').feature('cyl4').set('h', 2.5);
model.geom('geom1').feature('cyl4').set('pos', [0 0 -7.5]);
model.geom('geom1').feature.duplicate('cyl5', 'cyl1');
model.geom('geom1').feature('cyl5').set('pos', [0 0 -2.5]);
model.geom('geom1').run('cyl5');
model.geom('geom1').create('cyl6', 'Cylinder');
model.geom('geom1').feature('cyl6').set('r', 3);
model.geom('geom1').feature('cyl6').set('h', 2.5);
model.geom('geom1').feature('cyl6').set('pos', [0 0 -2.5]);
model.geom('geom1').feature.duplicate('cyl7', 'cyl1');
model.geom('geom1').feature('cyl7').set('pos', [0 0 2.5]);
model.geom('geom1').run('cyl7');
model.geom('geom1').create('cyl8', 'Cylinder');
model.geom('geom1').feature('cyl8').set('r', 3);
model.geom('geom1').feature('cyl8').set('h', 2.5);
model.geom('geom1').feature('cyl8').set('pos', [0 0 2.5]);
model.geom('geom1').run('cyl8');
model.geom('geom1').create('cyl9', 'Cylinder');
model.geom('geom1').feature('cyl9').set('r', 20);
model.geom('geom1').feature('cyl9').set('h', 50);
model.geom('geom1').feature('cyl9').set('pos', [0 0 -15]);
model.geom('geom1').run('cyl9');
model.geom('geom1').create('dif1', 'Difference');
model.geom('geom1').feature('dif1').selection('input').set({'cyl1' 'cyl3' 'cyl5' 'cyl7'});
model.geom('geom1').feature('dif1').selection('input2').set({'cyl2' 'cyl4' 'cyl6' 'cyl8'});
model.geom('geom1').run('dif1');
model.geom('geom1').create('wp1', 'WorkPlane');
model.geom('geom1').feature('wp1').set('unite', true);

model.view('view1').set('renderwireframe', true);

model.geom('geom1').feature('wp1').set('planetype', 'faceparallel');
model.geom('geom1').feature('wp1').selection('face').set('dif1', 3);
model.geom('geom1').feature('wp1').geom.create('c1', 'Circle');
model.geom('geom1').feature('wp1').geom.feature('c1').set('r', 2);
model.geom('geom1').feature('wp1').geom.run('c1');
model.geom('geom1').run('wp1');
model.geom('geom1').create('wp2', 'WorkPlane');
model.geom('geom1').feature('wp2').set('unite', true);
model.geom('geom1').feature('wp2').set('planetype', 'faceparallel');
model.geom('geom1').feature('wp2').selection('face').set('dif1', 13);
model.geom('geom1').feature('wp2').geom.create('c1', 'Circle');
model.geom('geom1').feature('wp2').geom.feature('c1').set('type', 'curve');
model.geom('geom1').feature('wp2').geom.feature('c1').set('r', 8);
model.geom('geom1').feature('wp2').geom.run('c1');

model.view('view1').set('renderwireframe', false);

model.title([]);

model.description('');

model.label('magnetic_lens_geom_sequence.mph');

model.modelNode.label('Components');

out = model;
