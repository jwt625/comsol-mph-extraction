function out = model
%
% rfid_geom_sequence.m
%
% Model exported on May 26 2025, 21:25 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/ACDC_Module/Introductory_Magnetostatics');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 3);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.geom('geom1').create('wp1', 'WorkPlane');
model.geom('geom1').feature('wp1').set('unite', true);
model.geom('geom1').feature('wp1').set('quickplane', 'zx');
model.geom('geom1').feature('wp1').set('unite', false);
model.geom('geom1').feature('wp1').geom.create('pol1', 'Polygon');
model.geom('geom1').feature('wp1').geom.feature('pol1').set('source', 'table');
model.geom('geom1').feature('wp1').geom.feature('pol1').set('type', 'closed');
model.geom('geom1').feature('wp1').geom.feature('pol1').set('source', 'vectors');
model.geom('geom1').feature('wp1').geom.feature('pol1').set('x', '0.8875 0.8875 0.8875 0.9125 0.9125 0.9125 0.9125 0.89 0.89 0.89 0.89 0.91 0.91 0.91 0.91 0.8925 0.8925 0.8925 0.8925 0.9075 0.9075 0.9075 0.9075 0.895 0.895 0.895 0.895 0.8875');
model.geom('geom1').feature('wp1').geom.feature('pol1').set('y', '0 0.01 0.01 0.01 0.01 -0.01 -0.01 -0.01 -0.01 0.0075 0.0075 0.0075 0.0075 -0.0075 -0.0075 -0.0075 -0.0075 0.005 0.005 0.005 0.005 -0.005 -0.005 -0.005 -0.005 0 0 0');
model.geom('geom1').feature('wp1').geom.run('pol1');
model.geom('geom1').feature('wp1').geom.create('r1', 'Rectangle');
model.geom('geom1').feature('wp1').geom.feature('r1').set('type', 'curve');
model.geom('geom1').feature('wp1').geom.feature('r1').set('size', [1.8 0.8]);
model.geom('geom1').feature('wp1').geom.feature('r1').set('pos', [0 -0.4]);
model.geom('geom1').feature('wp1').geom.run('r1');
model.geom('geom1').feature('wp1').geom.create('fil1', 'Fillet');
model.geom('geom1').feature('wp1').geom.feature('fil1').selection('pointinsketch').set('r1', [1 2 3 4]);
model.geom('geom1').feature('wp1').geom.feature('fil1').set('radius', 0.2);
model.geom('geom1').feature('wp1').geom.run('fil1');
model.geom('geom1').run('wp1');
model.geom('geom1').create('mov1', 'Move');
model.geom('geom1').feature('mov1').selection('input').set({'wp1.fil1'});
model.geom('geom1').feature('mov1').set('disply', -0.4);
model.geom('geom1').run('mov1');
model.geom('geom1').create('mir1', 'Mirror');
model.geom('geom1').feature('mir1').selection('input').set({'mov1'});
model.geom('geom1').feature('mir1').set('keep', true);
model.geom('geom1').feature('mir1').set('axis', [0 1 0]);
model.geom('geom1').run('mir1');
model.geom('geom1').create('sph1', 'Sphere');
model.geom('geom1').feature('sph1').set('r', 3);
model.geom('geom1').feature('sph1').set('pos', [0 0 0.9]);
model.geom('geom1').run('fin');

model.view('view1').set('renderwireframe', true);

model.title([]);

model.description('');

model.label('rfid_geom_sequence.mph');

model.modelNode.label('Components');

out = model;
