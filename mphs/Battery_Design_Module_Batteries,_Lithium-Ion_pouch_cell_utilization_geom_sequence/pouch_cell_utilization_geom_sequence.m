function out = model
%
% pouch_cell_utilization_geom_sequence.m
%
% Model exported on May 26 2025, 21:26 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/Battery_Design_Module/Batteries,_Lithium-Ion');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 3);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

% To import content from file, use:
% model.param.loadFile('FILENAME');
model.param.set('L_sep', '30[um]', 'Separator thickness');
model.param.set('L_pos', '60[um]', 'Positive electrode thickness');
model.param.set('L_neg', '60[um]', 'Negative electrode thickness');
model.param.set('L_pos_cc', '10[um]', 'Positive current collector thickness');
model.param.set('L_neg_cc', '10[um]', 'Negative current collector thickness');
model.param.set('W_cell', '10[cm]', 'Cell width');
model.param.set('H_cell', '20[cm]', 'Cell height');
model.param.set('H_tab', '1[cm]', 'Tab height');
model.param.set('W_tab', '5[cm]', 'Tab width');
model.param.set('L_cell', 'L_sep+L_pos+L_neg+L_neg_cc/2+L_pos_cc/2', 'Cell thickness');

model.geom('geom1').create('wp1', 'WorkPlane');
model.geom('geom1').feature('wp1').set('unite', true);
model.geom('geom1').feature('wp1').geom.create('r1', 'Rectangle');
model.geom('geom1').feature('wp1').geom.feature('r1').set('size', {'W_cell' 'H_cell'});
model.geom('geom1').run('wp1');
model.geom('geom1').feature.create('ext1', 'Extrude');
model.geom('geom1').feature('ext1').setIndex('distance', 'L_neg_cc/2', 0);
model.geom('geom1').feature('ext1').setIndex('distance', 'L_neg_cc/2+L_neg', 1);
model.geom('geom1').feature('ext1').set('displ', {'0' '0'; '0' '0'});
model.geom('geom1').feature('ext1').set('scale', {'1' '1'; '1' '1'});
model.geom('geom1').feature('ext1').set('twist', {'0' '0'});
model.geom('geom1').feature('ext1').setIndex('distance', 'L_neg_cc/2+L_neg+L_sep', 2);
model.geom('geom1').feature('ext1').set('displ', {'0' '0'; '0' '0'; '0' '0'});
model.geom('geom1').feature('ext1').set('scale', {'1' '1'; '1' '1'; '1' '1'});
model.geom('geom1').feature('ext1').set('twist', {'0' '0' '0'});
model.geom('geom1').feature('ext1').setIndex('distance', 'L_neg_cc/2+L_neg+L_sep+L_pos', 3);
model.geom('geom1').feature('ext1').set('displ', {'0' '0'; '0' '0'; '0' '0'; '0' '0'});
model.geom('geom1').feature('ext1').set('scale', {'1' '1'; '1' '1'; '1' '1'; '1' '1'});
model.geom('geom1').feature('ext1').set('twist', {'0' '0' '0' '0'});
model.geom('geom1').feature('ext1').setIndex('distance', 'L_neg_cc/2+L_neg+L_sep+L_pos+L_pos_cc/2', 4);
model.geom('geom1').feature('ext1').set('displ', {'0' '0'; '0' '0'; '0' '0'; '0' '0'; '0' '0'});
model.geom('geom1').feature('ext1').set('scale', {'1' '1'; '1' '1'; '1' '1'; '1' '1'; '1' '1'});
model.geom('geom1').feature('ext1').set('twist', {'0' '0' '0' '0' '0'});
model.geom('geom1').run('ext1');
model.geom('geom1').create('blk1', 'Block');
model.geom('geom1').feature('blk1').set('size', {'W_tab' 'H_tab' 'L_neg_cc/2'});
model.geom('geom1').feature('blk1').set('pos', {'0' 'H_cell' '0'});
model.geom('geom1').run('blk1');
model.geom('geom1').create('blk2', 'Block');
model.geom('geom1').feature('blk2').set('size', {'W_tab' 'H_tab' 'L_neg_cc/2'});
model.geom('geom1').feature('blk2').set('pos', {'0' '-H_tab' 'L_neg_cc/2+L_neg+L_sep+L_pos'});
model.geom('geom1').run('blk2');
model.geom('geom1').run('fin');

model.view('view1').camera.set('viewscaletype', 'manual');
model.view('view1').camera.set('zscale', 100);

model.geom('geom1').run('fin');
model.geom('geom1').create('sel1', 'ExplicitSelection');
model.geom('geom1').feature('sel1').label('Positive Tab');
model.geom('geom1').feature('sel1').selection('selection').set('fin', 1);
model.geom('geom1').run('sel1');
model.geom('geom1').create('sel2', 'ExplicitSelection');
model.geom('geom1').feature('sel2').label('Positive Current Collector');
model.geom('geom1').feature('sel2').selection('selection').set('fin', 6);
model.geom('geom1').run('sel2');
model.geom('geom1').create('sel3', 'ExplicitSelection');
model.geom('geom1').feature('sel3').label('Positive Electrode');
model.geom('geom1').feature('sel3').selection('selection').set('fin', 5);
model.geom('geom1').run('sel3');
model.geom('geom1').create('sel4', 'ExplicitSelection');
model.geom('geom1').feature('sel4').label('Negative Tab');
model.geom('geom1').feature('sel4').selection('selection').set('fin', 7);
model.geom('geom1').run('sel4');
model.geom('geom1').create('sel5', 'ExplicitSelection');
model.geom('geom1').feature('sel5').label('Negative Current Collector');
model.geom('geom1').feature('sel5').selection('selection').set('fin', 2);
model.geom('geom1').run('sel5');
model.geom('geom1').create('sel6', 'ExplicitSelection');
model.geom('geom1').feature('sel6').label('Negative Electrode');
model.geom('geom1').feature('sel6').selection('selection').set('fin', 3);
model.geom('geom1').run('sel6');
model.geom('geom1').create('sel7', 'ExplicitSelection');
model.geom('geom1').feature('sel7').label('Separator');
model.geom('geom1').feature('sel7').selection('selection').set('fin', 4);
model.geom('geom1').run('sel7');
model.geom('geom1').create('sel8', 'ExplicitSelection');
model.geom('geom1').feature('sel8').label('Negative Tab End');
model.geom('geom1').feature('sel8').selection('selection').init(2);
model.geom('geom1').feature('sel8').selection('selection').set('fin', 29);
model.geom('geom1').run('sel8');
model.geom('geom1').create('sel9', 'ExplicitSelection');
model.geom('geom1').feature('sel9').label('Positive Tab End');
model.geom('geom1').feature('sel9').selection('selection').init(2);
model.geom('geom1').feature('sel9').selection('selection').set('fin', 2);
model.geom('geom1').run('sel9');
model.geom('geom1').create('unisel1', 'UnionSelection');
model.geom('geom1').feature('unisel1').label('Negative Current Collector and Tab');
model.geom('geom1').feature('unisel1').set('input', {'sel4' 'sel5'});
model.geom('geom1').run('unisel1');
model.geom('geom1').create('unisel2', 'UnionSelection');
model.geom('geom1').feature('unisel2').label('Positive Current Collector and Tab');
model.geom('geom1').feature('unisel2').set('input', {'sel1' 'sel2'});
model.geom('geom1').run('unisel2');
model.geom('geom1').create('unisel3', 'UnionSelection');
model.geom('geom1').feature('unisel3').label('Metal Foil Domains');
model.geom('geom1').feature('unisel3').set('input', {'unisel1' 'unisel2'});

model.title([]);

model.description('');

model.label('pouch_cell_utilization_geom_sequence.mph');

model.modelNode.label('Components');

out = model;
