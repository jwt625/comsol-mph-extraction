function out = model
%
% small_concert_hall_geom_sequence.m
%
% Model exported on May 26 2025, 21:25 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/Acoustics_Module/Building_and_Room_Acoustics');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 3);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.geom('geom1').create('imp1', 'Import');
model.geom('geom1').feature('imp1').set('filename', 'small_concert_hall.mphbin');
model.geom('geom1').feature('imp1').importData;

model.view('view1').set('renderwireframe', true);

model.geom('geom1').create('del1', 'Delete');
model.geom('geom1').feature('del1').selection('input').set('imp1', 40);
model.geom('geom1').run('del1');
model.geom('geom1').feature.create('ext1', 'Extrude');
model.geom('geom1').feature('ext1').selection('inputface').set('del1', 39);
model.geom('geom1').feature('ext1').set('reverse', true);
model.geom('geom1').run('ext1');
model.geom('geom1').create('del2', 'Delete');
model.geom('geom1').feature('del2').selection('input').set('ext1', 41);
model.geom('geom1').run('del2');
model.geom('geom1').create('sel1', 'ExplicitSelection');
model.geom('geom1').feature('sel1').label('Windows');
model.geom('geom1').feature('sel1').selection('selection').init(2);
model.geom('geom1').feature('sel1').selection('selection').set('del2', [63 64 65]);
model.geom('geom1').run('sel1');
model.geom('geom1').create('sel2', 'ExplicitSelection');
model.geom('geom1').feature('sel2').label('Seats');
model.geom('geom1').feature('sel2').selection('selection').init(2);
model.geom('geom1').feature('sel2').selection('selection').set('del2', [39 40 41 42 59]);
model.geom('geom1').run('sel2');
model.geom('geom1').create('sel3', 'ExplicitSelection');
model.geom('geom1').feature('sel3').label('Diffusers');
model.geom('geom1').feature('sel3').selection('selection').init(2);
model.geom('geom1').feature('sel3').selection('selection').set('del2', [13 15 29 30 43 44 51 52]);
model.geom('geom1').run('sel3');
model.geom('geom1').create('sel4', 'ExplicitSelection');
model.geom('geom1').feature('sel4').label('Floor');
model.geom('geom1').feature('sel4').selection('selection').init(2);
model.geom('geom1').feature('sel4').selection('selection').set('del2', [3 8 12 14 18 21]);
model.geom('geom1').run('sel4');
model.geom('geom1').create('sel5', 'ExplicitSelection');
model.geom('geom1').feature('sel5').label('Entrance');
model.geom('geom1').feature('sel5').selection('selection').init(2);
model.geom('geom1').feature('sel5').selection('selection').set('del2', [16 19 20 23 31 32]);
model.geom('geom1').run('sel5');
model.geom('geom1').create('sel6', 'ExplicitSelection');
model.geom('geom1').feature('sel6').label('Walls');
model.geom('geom1').feature('sel6').selection('selection').init(2);
model.geom('geom1').feature('sel6').selection('selection').set('del2', [1 2 4 5 6 7 9 10 11 17 22 24 25 26 27 28 34 35 36 37 45 46 47 48 49 50 53 54 55 56 57 58 60 61 62]);
model.geom('geom1').run('sel6');
model.geom('geom1').create('sel7', 'ExplicitSelection');
model.geom('geom1').feature('sel7').label('Absorbers');
model.geom('geom1').feature('sel7').selection('selection').init(2);
model.geom('geom1').feature('sel7').selection('selection').set('del2', [33 38]);
model.geom('geom1').run('fin');

model.title([]);

model.description('');

model.label('small_concert_hall_geom_sequence.mph');

model.modelNode.label('Components');

out = model;
