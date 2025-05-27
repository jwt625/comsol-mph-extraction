function out = model
%
% li_battery_thermal_2d_axi_geom_sequence.m
%
% Model exported on May 26 2025, 21:26 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/Battery_Design_Module/Thermal_Management');

% To import content from file, use:
% model.param.loadFile('FILENAME');
model.param.set('d_can', '0.25[mm]', 'Thickness of battery canister');
model.param.set('r_batt', '9[mm]', 'Battery radius');
model.param.set('h_batt', '65[mm]', 'Battery height');
model.param.set('r_mandrel', '2[mm]', 'Mandrel radius');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 2);
model.geom('geom1').model('comp1');
model.geom('geom1').axisymmetric(true);

model.mesh.create('mesh1', 'geom1');

model.geom('geom1').create('r1', 'Rectangle');
model.geom('geom1').feature('r1').set('size', {'r_batt' 'h_batt'});
model.geom('geom1').feature('r1').setIndex('layer', 'd_can', 0);
model.geom('geom1').feature('r1').setIndex('layer', 'h_batt-d_can*2', 1);
model.geom('geom1').run('r1');
model.geom('geom1').create('r2', 'Rectangle');
model.geom('geom1').feature('r2').set('size', {'r_batt-d_can' '1'});
model.geom('geom1').feature('r2').setIndex('size', 'h_batt', 1);
model.geom('geom1').feature('r2').setIndex('layer', 'r_mandrel', 0);
model.geom('geom1').feature('r2').set('layerleft', true);
model.geom('geom1').feature('r2').set('layerbottom', false);
model.geom('geom1').runPre('fin');
model.geom('geom1').run('fin');
model.geom('geom1').create('mce1', 'MeshControlEdges');
model.geom('geom1').feature('mce1').selection('input').set('fin', [8 12 15 18 19 20]);
model.geom('geom1').run('mce1');
model.geom('geom1').create('sel1', 'ExplicitSelection');
model.geom('geom1').feature('sel1').label('Battery Can');
model.geom('geom1').feature('sel1').selection('selection').set('mce1', 1);
model.geom('geom1').run('sel1');
model.geom('geom1').create('sel2', 'ExplicitSelection');
model.geom('geom1').feature('sel2').label('Active Battery Material');
model.geom('geom1').feature('sel2').selection('selection').set('mce1', 3);
model.geom('geom1').run('sel2');
model.geom('geom1').create('sel3', 'ExplicitSelection');
model.geom('geom1').feature('sel3').label('Mandrel');
model.geom('geom1').feature('sel3').selection('selection').set('mce1', 2);

model.title([]);

model.description('');

model.label('li_battery_thermal_2d_axi_geom_sequence.mph');

model.modelNode.label('Components');

out = model;
