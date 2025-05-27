function out = model
%
% meshing_sequence_geom_sequence.m
%
% Model exported on May 26 2025, 21:27 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/COMSOL_Multiphysics/Meshing_Tutorials');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 3);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.geom('geom1').create('blk1', 'Block');
model.geom('geom1').feature('blk1').set('size', {'2[mm]' '2.5[mm]' '1'});
model.geom('geom1').feature('blk1').setIndex('size', '0.5[mm]', 2);
model.geom('geom1').feature('blk1').set('base', 'center');
model.geom('geom1').feature('blk1').set('pos', {'0' '0' '0.5[mm]/2+0.3[mm]'});
model.geom('geom1').run('blk1');
model.geom('geom1').create('blk2', 'Block');
model.geom('geom1').feature('blk2').set('size', {'4[mm]' '4[mm]' '1.23[mm]'});
model.geom('geom1').feature('blk2').set('base', 'center');
model.geom('geom1').feature('blk2').set('pos', {'0' '0' '-1.23[mm]/2'});
model.geom('geom1').feature('blk2').setIndex('layername', 'Layer 1', 0);
model.geom('geom1').feature('blk2').setIndex('layer', '0.07[mm]', 0);
model.geom('geom1').feature('blk2').set('layerbottom', false);
model.geom('geom1').feature('blk2').set('layertop', true);
model.geom('geom1').run('blk2');
model.geom('geom1').create('sph1', 'Sphere');
model.geom('geom1').feature('sph1').set('r', '0.4[mm]/2');
model.geom('geom1').feature('sph1').set('pos', {'2[mm]/2-0.25[mm]' '0' '0'});
model.geom('geom1').feature('sph1').setIndex('pos', '2.5[mm]/2-0.25[mm]', 1);
model.geom('geom1').feature('sph1').setIndex('pos', '0.15[mm]', 2);
model.geom('geom1').run('sph1');
model.geom('geom1').create('dif1', 'Difference');

model.view('view1').set('renderwireframe', true);

model.geom('geom1').feature('dif1').selection('input').set({'sph1'});
model.geom('geom1').feature('dif1').selection('input2').set({'blk1' 'blk2'});
model.geom('geom1').feature('dif1').set('keepsubtract', true);
model.geom('geom1').run('dif1');

model.view('view1').set('renderwireframe', false);

model.geom('geom1').create('arr1', 'Array');
model.geom('geom1').feature('arr1').selection('input').set({'dif1'});
model.geom('geom1').feature('arr1').set('fullsize', [4 5 1]);
model.geom('geom1').feature('arr1').set('displ', {'-(2[mm]-2*0.25[mm])/(4-1)' '0' '0'});
model.geom('geom1').feature('arr1').setIndex('displ', '-(2.5[mm]-2*0.25[mm])/(5-1)', 1);
model.geom('geom1').run('fin');

model.view('view1').set('transparency', true);

model.title([]);

model.description('');

model.label('meshing_sequence_geom_sequence.mph');

model.modelNode.label('Components');

out = model;
