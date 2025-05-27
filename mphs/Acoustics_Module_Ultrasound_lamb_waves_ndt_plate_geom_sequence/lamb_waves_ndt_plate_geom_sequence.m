function out = model
%
% lamb_waves_ndt_plate_geom_sequence.m
%
% Model exported on May 26 2025, 21:25 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/Acoustics_Module/Ultrasound');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 3);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

% To import content from file, use:
% model.param.loadFile('FILENAME');
model.param.set('D_plate', '5[mm]', 'Plate thickness');
model.param.set('W_plate', '15[mm]', 'Plate width');
model.param.set('L_plate', '50[cm]', 'Plate length');
model.param.set('H_wedge', '20[mm]', 'Wedge height');
model.param.set('W_wedge', '20[mm]', 'Wedge width');
model.param.set('L_wedge', '40[mm]', 'Wedge length');
model.param.set('L_slope', '16[mm]', 'Wedge slope length');
model.param.set('alpha', '70[deg]', 'Wedge angle');
model.param.set('R_source', '6.25[mm]', 'Excitation area radius');
model.param.label('Geometry Parameters');

model.geom('geom1').create('wp1', 'WorkPlane');
model.geom('geom1').feature('wp1').set('unite', true);
model.geom('geom1').feature('wp1').geom.create('r1', 'Rectangle');
model.geom('geom1').feature('wp1').geom.feature('r1').set('size', {'W_plate' 'D_plate'});
model.geom('geom1').feature('wp1').geom.feature('r1').set('base', 'center');
model.geom('geom1').run('wp1');
model.geom('geom1').feature.create('ext1', 'Extrude');
model.geom('geom1').feature('ext1').setIndex('distance', '0.1*L_plate', 0);
model.geom('geom1').feature('ext1').setIndex('distance', '1.1*L_plate', 1);
model.geom('geom1').feature('ext1').set('displ', {'0' '0'; '0' '0'});
model.geom('geom1').feature('ext1').set('scale', {'1' '1'; '1' '1'});
model.geom('geom1').feature('ext1').set('twist', {'0' '0'});
model.geom('geom1').feature('ext1').setIndex('distance', '1.2*L_plate', 2);
model.geom('geom1').feature('ext1').set('displ', {'0' '0'; '0' '0'; '0' '0'});
model.geom('geom1').feature('ext1').set('scale', {'1' '1'; '1' '1'; '1' '1'});
model.geom('geom1').feature('ext1').set('twist', {'0' '0' '0'});
model.geom('geom1').run('ext1');
model.geom('geom1').create('mov1', 'Move');
model.geom('geom1').feature('mov1').selection('input').set({'ext1'});
model.geom('geom1').feature('mov1').set('displx', 'W_plate/2');
model.geom('geom1').feature('mov1').set('disply', '-D_plate/2');
model.geom('geom1').feature('mov1').set('displz', '-L_plate/4');
model.geom('geom1').run('mov1');
model.geom('geom1').create('blk1', 'Block');
model.geom('geom1').feature('blk1').set('size', {'W_wedge' 'H_wedge' '1'});
model.geom('geom1').feature('blk1').setIndex('size', 'L_wedge', 2);
model.geom('geom1').feature('blk1').set('pos', {'(W_plate - W_wedge)/2' '0' '0'});
model.geom('geom1').run('blk1');
model.geom('geom1').create('wp2', 'WorkPlane');
model.geom('geom1').feature('wp2').set('unite', true);
model.geom('geom1').feature('wp2').set('planetype', 'normalvector');
model.geom('geom1').feature('wp2').set('normalvector', {'0' 'cos(alpha)' '1'});
model.geom('geom1').feature('wp2').setIndex('normalvector', '-sin(alpha)', 2);
model.geom('geom1').feature('wp2').set('normalcoord', {'0' 'H_wedge - L_slope*sin(alpha)' '0'});
model.geom('geom1').feature('wp2').geom.create('c1', 'Circle');
model.geom('geom1').feature('wp2').geom.feature('c1').set('r', 'R_source');
model.geom('geom1').feature('wp2').geom.feature('c1').set('pos', {'-L_slope*sin(alpha)/2' '0'});
model.geom('geom1').feature('wp2').geom.feature('c1').setIndex('pos', '-W_plate/2', 1);
model.geom('geom1').run('wp2');
model.geom('geom1').create('par1', 'Partition');
model.geom('geom1').feature('par1').selection('input').set({'blk1'});
model.geom('geom1').feature('par1').set('partitionwith', 'workplane');
model.geom('geom1').run('par1');
model.geom('geom1').create('del1', 'Delete');
model.geom('geom1').feature('del1').selection('input').init(3);
model.geom('geom1').feature('del1').selection('input').set('par1', 2);
model.geom('geom1').run('del1');
model.geom('geom1').create('ps1', 'ParametricSurface');
model.geom('geom1').feature('ps1').set('parmin1', 'W_plate/2');
model.geom('geom1').feature('ps1').set('parmax1', 'W_plate');
model.geom('geom1').feature('ps1').set('parmin2', '-D_plate');
model.geom('geom1').feature('ps1').set('parmax2', 0);
model.geom('geom1').feature('ps1').set('coord', {'s1' 's2' '0.3'});
model.geom('geom1').run('ps1');
model.geom('geom1').create('pt1', 'Point');
model.geom('geom1').feature('pt1').setIndex('p', 0.2, 2);
model.geom('geom1').run('pt1');
model.geom('geom1').create('pt2', 'Point');
model.geom('geom1').feature('pt2').setIndex('p', 0.4, 2);
model.geom('geom1').run('pt2');
model.geom('geom1').create('copy1', 'Copy');
model.geom('geom1').feature('copy1').selection('input').set({'pt1' 'pt2'});
model.geom('geom1').feature('copy1').set('displx', 'W_plate');
model.geom('geom1').run('copy1');
model.geom('geom1').create('uni1', 'Union');
model.geom('geom1').feature('uni1').selection('input').set({'copy1' 'mov1' 'ps1' 'pt1' 'pt2'});
model.geom('geom1').feature('fin').set('action', 'assembly');
model.geom('geom1').feature('fin').set('createpairs', false);
model.geom('geom1').feature('fin').set('imprint', true);
model.geom('geom1').run('fin');
model.geom('geom1').create('igf1', 'IgnoreFaces');
model.geom('geom1').feature('igf1').selection('input').set('fin', 31);
model.geom('geom1').run('igf1');

model.title([]);

model.description('');

model.label('lamb_waves_ndt_plate_geom_sequence.mph');

model.modelNode.label('Components');

out = model;
