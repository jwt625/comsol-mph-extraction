function out = model
%
% soec_thermodynamics_geom_sequence.m
%
% Model exported on May 26 2025, 21:28 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/Fuel_Cell_and_Electrolyzer_Module/Electrolyzers');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 3);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.param.label('Geometry Parameters');

% To import content from file, use:
% model.param.loadFile('FILENAME');
model.param.set('W_ch', '0.5[mm]', 'Channel width');
model.param.set('W_rib', 'W_ch*3', 'Rib width');
model.param.set('L_ch', '10[mm]', 'Channel length');
model.param.set('N_ch', '3', 'Number of channels');
model.param.set('H_gde', '0.1[mm]', 'Gas diffusion electrode thickness');
model.param.set('H_ch', 'W_ch', 'Channel height');
model.param.set('H_el', 'H_gde', 'Electrolyte layer thickness');
model.param.set('D_cell', 'N_ch*(W_ch+W_rib)', 'Cell depth (in y-direction)');
model.param.set('W_cell', 'L_ch+2*W_ch+W_rib', 'Cell width (in x-direction)');
model.param.set('H_cell', 'H_gde*2+H_el+H_ch', 'Cell thickness (in z-direction)');

model.geom('geom1').create('blk1', 'Block');
model.geom('geom1').feature('blk1').label('Anode');
model.geom('geom1').feature('blk1').set('size', {'W_cell' 'D_cell' '1'});
model.geom('geom1').feature('blk1').setIndex('size', 'H_gde', 2);
model.geom('geom1').feature('blk1').set('selresult', true);
model.geom('geom1').feature.duplicate('blk2', 'blk1');
model.geom('geom1').feature('blk2').label('Electrolyte');
model.geom('geom1').feature('blk2').set('pos', {'0' '0' 'H_gde'});
model.geom('geom1').feature.duplicate('blk3', 'blk2');
model.geom('geom1').feature('blk3').label('Cathode');
model.geom('geom1').feature('blk3').set('pos', {'0' '0' 'H_gde+H_el'});
model.geom('geom1').run('blk3');
model.geom('geom1').create('wp1', 'WorkPlane');
model.geom('geom1').feature('wp1').set('unite', true);
model.geom('geom1').feature('wp1').set('quickz', 'H_cell-H_ch');
model.geom('geom1').feature('wp1').geom.create('r1', 'Rectangle');
model.geom('geom1').feature('wp1').geom.feature('r1').set('size', {'W_ch' 'N_ch*(W_ch+W_rib)'});
model.geom('geom1').feature('wp1').geom.feature('r1').set('pos', {'W_rib/2' 'W_rib/2'});
model.geom('geom1').feature('wp1').geom.feature.duplicate('r2', 'r1');
model.geom('geom1').feature('wp1').geom.feature('r2').set('pos', {'W_rib/2+L_ch+W_ch' 'W_rib/2'});
model.geom('geom1').feature('wp1').geom.feature('r2').setIndex('pos', '-W_rib/2', 1);
model.geom('geom1').feature('wp1').geom.run('r2');
model.geom('geom1').feature('wp1').geom.create('r3', 'Rectangle');
model.geom('geom1').feature('wp1').geom.feature('r3').set('size', {'L_ch' 'W_ch'});
model.geom('geom1').feature('wp1').geom.feature('r3').set('pos', {'W_rib/2+W_ch' '0'});
model.geom('geom1').feature('wp1').geom.feature('r3').setIndex('pos', 'W_rib/2', 1);
model.geom('geom1').feature('wp1').geom.run('r3');
model.geom('geom1').feature('wp1').geom.create('arr1', 'Array');
model.geom('geom1').feature('wp1').geom.feature('arr1').selection('input').set({'r3'});
model.geom('geom1').feature('wp1').geom.feature('arr1').set('fullsize', {'1' 'N_ch'});
model.geom('geom1').feature('wp1').geom.feature('arr1').set('displ', {'0' 'W_ch+W_rib'});
model.geom('geom1').feature('wp1').geom.run('arr1');
model.geom('geom1').run('wp1');
model.geom('geom1').feature.create('ext1', 'Extrude');
model.geom('geom1').feature('ext1').label('Channel Domains');
model.geom('geom1').feature('ext1').setIndex('distance', 'H_ch', 0);
model.geom('geom1').feature('ext1').set('selresult', true);
model.geom('geom1').run('fin');
model.geom('geom1').create('sel1', 'ExplicitSelection');
model.geom('geom1').feature('sel1').label('Inlet');
model.geom('geom1').feature('sel1').selection('selection').init(2);
model.geom('geom1').feature('sel1').selection('selection').set('fin', 19);
model.geom('geom1').run('sel1');
model.geom('geom1').create('sel2', 'ExplicitSelection');
model.geom('geom1').feature('sel2').label('Outlet');
model.geom('geom1').feature('sel2').selection('selection').init(2);
model.geom('geom1').feature('sel2').selection('selection').set('fin', 42);
model.geom('geom1').run('sel2');
model.geom('geom1').create('sel3', 'ExplicitSelection');
model.geom('geom1').feature('sel3').label('Cathode Current Collector');
model.geom('geom1').feature('sel3').selection('selection').init(2);
model.geom('geom1').feature('sel3').selection('selection').set('fin', [10 26 33 40]);
model.geom('geom1').run('sel3');
model.geom('geom1').create('sel4', 'ExplicitSelection');
model.geom('geom1').feature('sel4').label('Anode Current Collector');
model.geom('geom1').feature('sel4').selection('selection').init(2);
model.geom('geom1').feature('sel4').selection('selection').set('fin', 3);
model.geom('geom1').run('sel4');
model.geom('geom1').create('adjsel1', 'AdjacentSelection');
model.geom('geom1').feature('adjsel1').set('input', {'ext1'});
model.geom('geom1').feature('adjsel1').label('Channel Domain Boundaries');
model.geom('geom1').run('adjsel1');
model.geom('geom1').create('difsel1', 'DifferenceSelection');
model.geom('geom1').feature('difsel1').label('Boundary Layer Boundaries');
model.geom('geom1').feature('difsel1').set('entitydim', 2);
model.geom('geom1').feature('difsel1').set('add', {'adjsel1'});
model.geom('geom1').feature('difsel1').set('subtract', {'sel1' 'sel2'});

model.title([]);

model.description('');

model.label('soec_thermodynamics_geom_sequence.mph');

model.modelNode.label('Components');

out = model;
