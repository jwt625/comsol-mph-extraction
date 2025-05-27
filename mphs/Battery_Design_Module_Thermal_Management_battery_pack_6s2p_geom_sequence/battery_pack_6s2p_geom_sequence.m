function out = model
%
% battery_pack_6s2p_geom_sequence.m
%
% Model exported on May 26 2025, 21:26 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/Battery_Design_Module/Thermal_Management');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 3);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.param.label('Geometry Parameters');

% To import content from file, use:
% model.param.loadFile('FILENAME');
model.param.set('d_batt', '21[mm]', 'Battery diameter');
model.param.set('r_batt', 'd_batt/2', 'Battery radius');
model.param.set('h_batt', '70[mm]', 'Battery height');
model.param.set('h_term', '1[mm]', 'Terminal thickness');
model.param.set('r_term', '3[mm]', 'Terminal radius');
model.param.set('d_sc', '2[mm]', 'Serial connector depth');
model.param.set('h_sc', '1[mm]', 'Serial connector height');
model.param.set('h_pc', '0.5[mm]', 'Parallel connector height');
model.param.set('w_pc', '1[mm]', 'Parallel connector width');

model.geom('geom1').create('cyl1', 'Cylinder');
model.geom('geom1').feature('cyl1').set('r', 'r_batt');
model.geom('geom1').feature('cyl1').set('h', 'h_batt');
model.geom('geom1').feature.duplicate('cyl2', 'cyl1');
model.geom('geom1').feature('cyl2').set('r', 'r_term');
model.geom('geom1').feature('cyl2').set('h', 'h_term');
model.geom('geom1').feature('cyl2').set('pos', {'0' '0' '-h_term'});
model.geom('geom1').run('cyl2');
model.geom('geom1').create('arr1', 'Array');
model.geom('geom1').feature('arr1').selection('input').set({'cyl2'});
model.geom('geom1').feature('arr1').set('fullsize', [1 1 2]);
model.geom('geom1').feature('arr1').set('displ', {'0' '0' 'h_batt+h_term'});
model.geom('geom1').feature.duplicate('arr2', 'arr1');
model.geom('geom1').runPre('arr2');
model.geom('geom1').feature('arr2').selection('input').set({'arr1' 'cyl1'});
model.geom('geom1').feature('arr2').set('fullsize', [3 1 2]);
model.geom('geom1').feature('arr2').setIndex('displ', 'd_batt', 0);
model.geom('geom1').feature('arr2').set('displ', {'d_batt' '0' '0'});
model.geom('geom1').run('arr2');
model.geom('geom1').create('blk1', 'Block');
model.geom('geom1').feature('blk1').set('size', {'d_batt+d_sc' '1' '1'});
model.geom('geom1').feature('blk1').setIndex('size', 'd_sc', 1);
model.geom('geom1').feature('blk1').setIndex('size', 'h_sc', 2);
model.geom('geom1').feature('blk1').set('pos', {'-d_sc/2' '-d_sc/2' '0'});
model.geom('geom1').feature('blk1').setIndex('pos', '-h_sc-h_term', 2);
model.geom('geom1').run('blk1');
model.geom('geom1').create('blk2', 'Block');
model.geom('geom1').feature('blk2').set('size', {'(d_batt+d_sc)/2' '1' '1'});
model.geom('geom1').feature('blk2').setIndex('size', 'd_sc', 1);
model.geom('geom1').feature('blk2').setIndex('size', 'h_sc', 2);
model.geom('geom1').feature('blk2').set('pos', {'-d_sc/2+(d_batt)*2' '0' '0'});
model.geom('geom1').feature('blk2').setIndex('pos', '-d_sc/2', 1);
model.geom('geom1').feature('blk2').setIndex('pos', '-h_term-h_sc', 2);
model.geom('geom1').feature.duplicate('blk3', 'blk2');
model.geom('geom1').feature('blk3').set('size', {'(d_batt)/2+d_sc' 'd_sc' 'h_sc'});
model.geom('geom1').feature('blk3').setIndex('pos', '-d_sc/2-d_batt/2', 0);
model.geom('geom1').feature('blk3').setIndex('pos', 'h_batt+h_term', 2);
model.geom('geom1').feature.duplicate('blk4', 'blk3');
model.geom('geom1').feature('blk4').set('size', {'w_pc' 'd_batt/2+w_pc/2' 'h_sc'});
model.geom('geom1').feature('blk4').setIndex('size', 'h_pc', 2);
model.geom('geom1').feature('blk4').setIndex('pos', '-w_pc/2', 0);
model.geom('geom1').feature('blk4').setIndex('pos', '-w_pc/2', 1);
model.geom('geom1').feature('blk4').setIndex('pos', '-h_term-h_sc-h_pc', 2);
model.geom('geom1').run('blk4');
model.geom('geom1').create('mov1', 'Move');

model.view('view1').set('transparency', true);

model.geom('geom1').feature('mov1').selection('input').set({'blk1'});
model.geom('geom1').feature('mov1').set('keep', true);
model.geom('geom1').feature('mov1').set('displx', 'd_batt');
model.geom('geom1').feature('mov1').set('displz', 'h_batt+h_term*2+h_sc');
model.geom('geom1').run('mov1');
model.geom('geom1').create('arr3', 'Array');
model.geom('geom1').feature('arr3').selection('input').set({'blk4'});
model.geom('geom1').feature('arr3').set('fullsize', [3 1 2]);
model.geom('geom1').feature('arr3').set('displ', {'d_batt' '0' 'h_batt+2*(h_term+h_sc)+h_pc'});
model.geom('geom1').run('arr3');
model.geom('geom1').run('mov1');
model.geom('geom1').runPre('fin');
model.geom('geom1').create('wp1', 'WorkPlane');
model.geom('geom1').feature('wp1').set('unite', true);
model.geom('geom1').feature('wp1').set('quickz', '-(h_term+h_sc+h_pc)');
model.geom('geom1').feature('wp1').geom.create('c1', 'Circle');
model.geom('geom1').feature('wp1').geom.feature('c1').set('r', 'r_batt');
model.geom('geom1').feature('wp1').geom.feature('c1').set('angle', 90);
model.geom('geom1').feature('wp1').geom.feature('c1').set('rot', 180);
model.geom('geom1').feature('wp1').geom.run('c1');
model.geom('geom1').feature('wp1').geom.create('sq1', 'Square');
model.geom('geom1').feature('wp1').geom.feature('sq1').set('size', 'r_batt');
model.geom('geom1').feature('wp1').geom.feature('sq1').set('pos', {'-r_batt' '-r_batt'});
model.geom('geom1').feature('wp1').geom.run('sq1');
model.geom('geom1').feature('wp1').geom.create('dif1', 'Difference');
model.geom('geom1').feature('wp1').geom.feature('dif1').selection('input').set({'sq1'});
model.geom('geom1').feature('wp1').geom.feature('dif1').selection('input2').set({'c1'});
model.geom('geom1').feature('wp1').geom.run('dif1');
model.geom('geom1').feature('wp1').geom.create('r1', 'Rectangle');
model.geom('geom1').feature('wp1').geom.feature('r1').set('size', {'3*(d_batt)' 'd_batt'});
model.geom('geom1').feature('wp1').geom.run('r1');
model.geom('geom1').feature('wp1').geom.feature('r1').set('pos', {'-r_batt' '-r_batt'});
model.geom('geom1').feature('wp1').geom.run('r1');
model.geom('geom1').feature('wp1').geom.create('dif2', 'Difference');
model.geom('geom1').feature('wp1').geom.feature('dif2').selection('input').set({'r1'});
model.geom('geom1').feature('wp1').geom.feature('dif2').selection('input2').set({'dif1'});
model.geom('geom1').feature('wp1').geom.run('dif2');
model.geom('geom1').run('wp1');
model.geom('geom1').feature.create('ext1', 'Extrude');
model.geom('geom1').feature('ext1').setIndex('distance', 'h_term+h_sc+h_pc', 0);
model.geom('geom1').feature('ext1').setIndex('distance', 'h_batt+h_term+h_sc+h_pc', 1);
model.geom('geom1').feature('ext1').set('displ', {'0' '0'; '0' '0'});
model.geom('geom1').feature('ext1').set('scale', {'1' '1'; '1' '1'});
model.geom('geom1').feature('ext1').set('twist', {'0' '0'});
model.geom('geom1').feature('ext1').setIndex('distance', 'h_batt+2*(h_term+h_sc+h_pc)', 2);
model.geom('geom1').feature('ext1').set('displ', {'0' '0'; '0' '0'; '0' '0'});
model.geom('geom1').feature('ext1').set('scale', {'1' '1'; '1' '1'; '1' '1'});
model.geom('geom1').feature('ext1').set('twist', {'0' '0' '0'});
model.geom('geom1').run('ext1');
model.geom('geom1').run('fin');
model.geom('geom1').create('sel1', 'ExplicitSelection');
model.geom('geom1').feature('sel1').selection('selection').set('fin', 4);
model.geom('geom1').feature('sel1').label('Battery 1');
model.geom('geom1').run('sel1');
model.geom('geom1').create('sel2', 'ExplicitSelection');
model.geom('geom1').feature('sel2').selection('selection').set('fin', 14);
model.geom('geom1').feature('sel2').label('Battery 2');
model.geom('geom1').run('sel2');
model.geom('geom1').create('sel3', 'ExplicitSelection');
model.geom('geom1').feature('sel3').selection('selection').set('fin', 22);
model.geom('geom1').feature('sel3').label('Battery 3');
model.geom('geom1').run('sel3');
model.geom('geom1').create('sel4', 'ExplicitSelection');
model.geom('geom1').feature('sel4').selection('selection').set('fin', [2 3 5 12 13 20 21 28 29]);
model.geom('geom1').feature('sel4').label('Air Domain');
model.geom('geom1').run('sel4');
model.geom('geom1').create('comsel1', 'ComplementSelection');
model.geom('geom1').feature('comsel1').set('input', {'sel1' 'sel2' 'sel3' 'sel4'});
model.geom('geom1').feature('comsel1').label('Conductors');
model.geom('geom1').run('comsel1');
model.geom('geom1').create('unisel1', 'UnionSelection');
model.geom('geom1').feature('unisel1').set('input', {'sel1' 'sel2' 'sel3'});
model.geom('geom1').feature('unisel1').label('Batteries');
model.geom('geom1').run('unisel1');
model.geom('geom1').create('unisel2', 'UnionSelection');
model.geom('geom1').feature('unisel2').set('input', {'comsel1' 'unisel1'});
model.geom('geom1').feature('unisel2').label('Batteries and Conductors');
model.geom('geom1').run('unisel2');
model.geom('geom1').create('sel5', 'ExplicitSelection');
model.geom('geom1').feature('sel5').selection('selection').init(2);
model.geom('geom1').feature('sel5').label('Heat Flux Boundaries');
model.geom('geom1').feature('sel5').selection('selection').set('fin', [2 3 4 5 6 7 8 9 10 14 15 22 44 49 54 56 58 92 97 103 138 143 148]);

model.view('view1').set('renderwireframe', true);

model.geom('geom1').run('sel5');
model.geom('geom1').create('boxsel1', 'BoxSelection');
model.geom('geom1').feature('boxsel1').label('Mesh Sweep Domains');
model.geom('geom1').feature('boxsel1').set('zmin', '-h_pc/2');
model.geom('geom1').feature('boxsel1').set('zmax', 'h_batt+h_pc/2');
model.geom('geom1').feature('boxsel1').set('condition', 'inside');

model.title([]);

model.description('');

model.label('battery_pack_6s2p_geom_sequence.mph');

model.modelNode.label('Components');

out = model;
