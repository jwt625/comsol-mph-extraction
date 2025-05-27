function out = model
%
% parasol_geom_sequence.m
%
% Model exported on May 26 2025, 21:29 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/Heat_Transfer_Module/Thermal_Radiation');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 3);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.geom('geom1').create('blk1', 'Block');
model.geom('geom1').feature('blk1').set('size', [6 6 1]);
model.geom('geom1').feature('blk1').set('base', 'center');
model.geom('geom1').feature('blk1').set('pos', [0 0 -0.5]);
model.geom('geom1').run('blk1');
model.geom('geom1').create('blk2', 'Block');
model.geom('geom1').feature('blk2').set('size', [0.3 0.22 0.18]);
model.geom('geom1').feature('blk2').set('base', 'center');
model.geom('geom1').feature('blk2').set('pos', [0.5 0 0.09]);
model.geom('geom1').run('blk2');
model.geom('geom1').feature.duplicate('blk3', 'blk2');
model.geom('geom1').feature('blk3').set('size', [0.26 0.18 0.14]);
model.geom('geom1').run('blk3');

model.view('view1').set('renderwireframe', true);

model.geom('geom1').create('cyl1', 'Cylinder');
model.geom('geom1').feature('cyl1').set('r', 0.03);
model.geom('geom1').feature('cyl1').set('h', 0.125);
model.geom('geom1').feature('cyl1').set('pos', [0.42 0.04 0.02]);
model.geom('geom1').run('cyl1');
model.geom('geom1').create('arr1', 'Array');
model.geom('geom1').feature('arr1').selection('input').set({'cyl1'});
model.geom('geom1').feature('arr1').set('fullsize', [3 2 1]);
model.geom('geom1').feature('arr1').set('displ', [0.08 -0.08 0]);
model.geom('geom1').run('arr1');
model.geom('geom1').create('copy1', 'Copy');
model.geom('geom1').feature('copy1').selection('input').set({'arr1' 'blk2' 'blk3'});
model.geom('geom1').feature('copy1').set('displx', -1.5);
model.geom('geom1').run('copy1');
model.geom('geom1').create('cone1', 'Cone');
model.geom('geom1').feature('cone1').set('specifytop', 'radius');
model.geom('geom1').feature('cone1').set('h', 0.3);
model.geom('geom1').feature('cone1').set('specifytop', 'angle');
model.geom('geom1').feature('cone1').set('ang', 70);
model.geom('geom1').feature('cone1').set('pos', [0 0 1.5]);
model.geom('geom1').run('cone1');
model.geom('geom1').feature.duplicate('cone2', 'cone1');
model.geom('geom1').feature('cone2').set('pos', [0 0 1.4]);
model.geom('geom1').run('cone2');
model.geom('geom1').create('dif1', 'Difference');
model.geom('geom1').feature('dif1').selection('input').set({'cone1'});
model.geom('geom1').feature('dif1').selection('input2').set({'cone2'});
model.geom('geom1').run('dif1');
model.geom('geom1').create('cyl2', 'Cylinder');
model.geom('geom1').feature('cyl2').set('r', 0.05);
model.geom('geom1').feature('cyl2').set('h', 1.7);
model.geom('geom1').run('cyl2');
model.geom('geom1').run('fin');

model.title([]);

model.description('');

model.label('parasol_geom_sequence.mph');

model.modelNode.label('Components');

out = model;
