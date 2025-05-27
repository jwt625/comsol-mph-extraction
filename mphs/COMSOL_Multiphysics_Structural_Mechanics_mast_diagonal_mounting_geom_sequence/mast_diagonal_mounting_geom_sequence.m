function out = model
%
% mast_diagonal_mounting_geom_sequence.m
%
% Model exported on May 26 2025, 21:27 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/COMSOL_Multiphysics/Structural_Mechanics');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 3);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.param.set('h_t', '200[mm]');
model.param.descr('h_t', 'Tube height');
model.param.set('r_t', '50[mm]');
model.param.descr('r_t', 'Tube outer radius');
model.param.set('t_t', '10[mm]');
model.param.descr('t_t', 'Tube, wall thickness');
model.param.set('t_p', '10[mm]');
model.param.descr('t_p', 'Plate thickness');
model.param.set('r_p', '60[mm]');
model.param.descr('r_p', 'Plate radius');
model.param.set('r_ph', '5[mm]');
model.param.descr('r_ph', 'Plate hole radius');
model.param.set('o_p', '65[mm]');
model.param.descr('o_p', 'Plate hole offset');
model.param.set('t_m', '10[mm]');
model.param.descr('t_m', 'Mount thickness');
model.param.set('w_m', '55[mm]');
model.param.descr('w_m', 'Mount width');
model.param.set('r_mh', '12[mm]');
model.param.descr('r_mh', 'Mount hole radius');
model.param.set('o_mh', '70[mm]');
model.param.descr('o_mh', 'Mount hole offset from plate');
model.param.set('o_m', '22[mm]');
model.param.descr('o_m', 'Distance between mounts');

model.geom('geom1').lengthUnit('mm');
model.geom('geom1').create('cyl1', 'Cylinder');
model.geom('geom1').feature('cyl1').set('type', 'surface');
model.geom('geom1').feature('cyl1').set('r', 'r_t');
model.geom('geom1').feature('cyl1').set('h', 'h_t');
model.geom('geom1').feature('cyl1').setIndex('layername', 'Layer 1', 0);
model.geom('geom1').feature('cyl1').setIndex('layer', 't_t', 0);
model.geom('geom1').run('cyl1');
model.geom('geom1').create('cyl2', 'Cylinder');
model.geom('geom1').feature('cyl2').set('r', 'r_p');
model.geom('geom1').feature('cyl2').set('h', 't_p');
model.geom('geom1').feature('cyl2').set('pos', {'0' '0' 'h_t'});
model.geom('geom1').run('cyl2');
model.geom('geom1').create('sel1', 'ExplicitSelection');
model.geom('geom1').feature('sel1').selection('selection').set('cyl2', 1);
model.geom('geom1').feature('sel1').label('End plate');
model.geom('geom1').run('sel1');
model.geom('geom1').create('cyl3', 'Cylinder');
model.geom('geom1').feature('cyl3').set('r', 'r_ph');
model.geom('geom1').feature('cyl3').set('h', 'h_t+2*t_p');
model.geom('geom1').feature('cyl3').set('pos', {'0' 'o_p/2' '0'});
model.geom('geom1').run('cyl3');
model.geom('geom1').create('copy1', 'Copy');
model.geom('geom1').feature('copy1').selection('input').set({'cyl3'});
model.geom('geom1').feature('copy1').set('disply', '-o_p');
model.geom('geom1').run('copy1');
model.geom('geom1').create('dif1', 'Difference');
model.geom('geom1').feature('dif1').selection('input').set({'cyl2'});
model.geom('geom1').feature('dif1').selection('input2').set({'copy1' 'cyl3'});
model.geom('geom1').run('dif1');
model.geom('geom1').create('wp1', 'WorkPlane');
model.geom('geom1').feature('wp1').set('unite', true);
model.geom('geom1').feature('wp1').set('quickplane', 'yz');
model.geom('geom1').feature('wp1').geom.create('r1', 'Rectangle');
model.geom('geom1').feature('wp1').geom.feature('r1').set('size', {'w_m' 'o_mh'});
model.geom('geom1').feature('wp1').geom.feature('r1').set('pos', {'-w_m/2' '0'});
model.geom('geom1').feature('wp1').geom.run('r1');
model.geom('geom1').feature('wp1').geom.create('c1', 'Circle');
model.geom('geom1').feature('wp1').geom.feature('c1').set('r', 'w_m/2');
model.geom('geom1').feature('wp1').geom.feature('c1').set('pos', {'0' 'o_mh'});
model.geom('geom1').feature('wp1').geom.run('c1');
model.geom('geom1').feature('wp1').geom.create('uni1', 'Union');
model.geom('geom1').feature('wp1').geom.feature('uni1').selection('input').set({'c1' 'r1'});
model.geom('geom1').feature('wp1').geom.feature('uni1').set('intbnd', false);
model.geom('geom1').feature('wp1').geom.run('uni1');
model.geom('geom1').feature('wp1').geom.create('c2', 'Circle');
model.geom('geom1').feature('wp1').geom.feature('c2').set('r', 'r_mh');
model.geom('geom1').feature('wp1').geom.feature('c2').set('pos', {'0' 'o_mh'});
model.geom('geom1').feature('wp1').geom.run('c2');
model.geom('geom1').feature('wp1').geom.create('dif1', 'Difference');
model.geom('geom1').feature('wp1').geom.feature('dif1').selection('input').set({'uni1'});
model.geom('geom1').feature('wp1').geom.feature('dif1').selection('input2').set({'c2'});
model.geom('geom1').feature('wp1').geom.run('dif1');
model.geom('geom1').run('wp1');
model.geom('geom1').feature.create('ext1', 'Extrude');
model.geom('geom1').feature('ext1').set('workplane', 'wp1');
model.geom('geom1').feature('ext1').selection('input').set({'wp1'});
model.geom('geom1').feature('ext1').setIndex('distance', 't_m', 0);
model.geom('geom1').run('ext1');

model.view('view1').set('renderwireframe', true);

model.geom('geom1').create('sel2', 'ExplicitSelection');
model.geom('geom1').feature('sel2').selection('selection').set('ext1', 1);
model.geom('geom1').feature('sel2').label('Mount');
model.geom('geom1').run('sel2');
model.geom('geom1').create('mov1', 'Move');
model.geom('geom1').feature('mov1').selection('input').set({'ext1'});
model.geom('geom1').feature('mov1').set('displx', 'o_m/2');
model.geom('geom1').feature('mov1').set('displz', 'h_t+t_p');
model.geom('geom1').run('mov1');

model.view('view1').set('renderwireframe', false);

model.geom('geom1').create('copy2', 'Copy');
model.geom('geom1').feature('copy2').selection('input').set({'mov1'});
model.geom('geom1').feature('copy2').set('displx', '-(o_m+t_m)');
model.geom('geom1').run('copy2');
model.geom('geom1').run('fin');

model.title([]);

model.description('');

model.label('mast_diagonal_mounting_geom_sequence.mph');

model.modelNode.label('Components');

out = model;
