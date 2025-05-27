function out = model
%
% passive_pem_geom_sequence.m
%
% Model exported on May 26 2025, 21:28 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/Fuel_Cell_and_Electrolyzer_Module/Thermal_Management');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 3);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.param.set('L', '10[cm]');
model.param.descr('L', 'Cell length');
model.param.set('D', '2[cm]');
model.param.descr('D', 'Cell width');
model.param.set('H_film', '0.035[mm]');
model.param.descr('H_film', 'Cu film thickness');
model.param.set('H_GDL', '0.3[mm]');
model.param.descr('H_GDL', 'GDL thickness');
model.param.set('H_membrane', '0.02[mm]');
model.param.descr('H_membrane', 'Membrane thickness');
model.param.set('H_plate', '0.5[mm]');
model.param.descr('H_plate', 'Steel plate thickness');
model.param.set('r_film', '2[mm]');
model.param.descr('r_film', 'Hole radius in Cu film');
model.param.set('r_plate', '4[mm]');
model.param.descr('r_plate', 'Hole radius in steel plate');

model.geom('geom1').create('blk1', 'Block');
model.geom('geom1').feature('blk1').set('size', {'L' 'D' 'H_film'});
model.geom('geom1').run('blk1');
model.geom('geom1').create('cyl1', 'Cylinder');
model.geom('geom1').feature('cyl1').set('r', 'r_film');
model.geom('geom1').feature('cyl1').set('h', 'H_film');
model.geom('geom1').feature('cyl1').set('pos', {'1[cm]' '1[cm]' '0'});
model.geom('geom1').run('cyl1');
model.geom('geom1').create('arr1', 'Array');
model.geom('geom1').feature('arr1').selection('input').set({'cyl1'});
model.geom('geom1').feature('arr1').set('fullsize', [5 1 1]);
model.geom('geom1').feature('arr1').set('displ', {'2e-2' '0' '0'});
model.geom('geom1').run('arr1');
model.geom('geom1').create('dif1', 'Difference');
model.geom('geom1').feature('dif1').selection('input').set({'blk1'});
model.geom('geom1').feature('dif1').selection('input2').set({'arr1'});
model.geom('geom1').run('dif1');
model.geom('geom1').create('blk2', 'Block');
model.geom('geom1').feature('blk2').set('size', {'L' 'D' 'H_GDL'});
model.geom('geom1').feature('blk2').set('pos', {'0' '0' 'H_film'});
model.geom('geom1').run('blk2');
model.geom('geom1').create('blk3', 'Block');
model.geom('geom1').feature('blk3').set('size', {'L' 'D' 'H_membrane'});
model.geom('geom1').feature('blk3').set('pos', {'0' '0' 'H_film+H_GDL'});
model.geom('geom1').run('blk3');
model.geom('geom1').create('blk4', 'Block');
model.geom('geom1').feature('blk4').set('size', {'L' 'D' 'H_GDL'});
model.geom('geom1').feature('blk4').set('pos', {'0' '0' 'H_film+H_GDL+H_membrane'});
model.geom('geom1').run('blk4');
model.geom('geom1').create('blk5', 'Block');
model.geom('geom1').feature('blk5').set('size', {'L' 'D' 'H_plate'});
model.geom('geom1').feature('blk5').set('pos', {'0' '0' 'H_film+H_GDL+H_membrane+H_GDL'});
model.geom('geom1').run('blk5');
model.geom('geom1').create('cyl2', 'Cylinder');
model.geom('geom1').feature('cyl2').set('r', 'r_plate');
model.geom('geom1').feature('cyl2').set('h', 'H_plate');
model.geom('geom1').feature('cyl2').set('pos', {'5e-3' '5e-3' 'H_film+H_GDL+H_membrane+H_GDL'});
model.geom('geom1').run('cyl2');
model.geom('geom1').create('arr2', 'Array');
model.geom('geom1').feature('arr2').selection('input').set({'cyl2'});
model.geom('geom1').feature('arr2').set('fullsize', [10 2 1]);
model.geom('geom1').feature('arr2').set('displ', {'1e-2' '1e-2' '0'});
model.geom('geom1').run('arr2');
model.geom('geom1').create('dif2', 'Difference');
model.geom('geom1').feature('dif2').selection('input').set({'blk2' 'blk3' 'blk4' 'blk5'});
model.geom('geom1').feature('dif2').selection('input2').set({'arr2'});
model.geom('geom1').run('dif2');
model.geom('geom1').feature('fin').set('action', 'assembly');
model.geom('geom1').run('fin');

model.title([]);

model.description('');

model.label('passive_pem_geom_sequence.mph');

model.modelNode.label('Components');

out = model;
