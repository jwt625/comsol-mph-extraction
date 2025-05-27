function out = model
%
% surface_mount_package_geom_sequence.m
%
% Model exported on May 26 2025, 21:29 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/Heat_Transfer_Module/Power_Electronics_and_Electronic_Cooling');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 3);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.geom('geom1').lengthUnit('mm');
model.geom('geom1').create('blk1', 'Block');
model.geom('geom1').feature('blk1').label('PC Board');
model.geom('geom1').feature('blk1').set('size', [20 10 1]);
model.geom('geom1').feature('blk1').set('pos', [-10 -5 -1.9]);
model.geom('geom1').feature('blk1').set('selresult', true);
model.geom('geom1').run('blk1');
model.geom('geom1').create('blk2', 'Block');
model.geom('geom1').feature('blk2').set('size', [9.9 3.9 0.2]);
model.geom('geom1').feature('blk2').set('base', 'center');
model.geom('geom1').run('blk2');
model.geom('geom1').create('hex1', 'Hexahedron');
model.geom('geom1').feature('hex1').setIndex('p', -4.95, 0, 0);
model.geom('geom1').feature('hex1').setIndex('p', 4.95, 0, 1);
model.geom('geom1').feature('hex1').setIndex('p', 4.95, 0, 2);
model.geom('geom1').feature('hex1').setIndex('p', -4.95, 0, 3);
model.geom('geom1').feature('hex1').setIndex('p', -4.95, 0, 4);
model.geom('geom1').feature('hex1').setIndex('p', 4.95, 0, 5);
model.geom('geom1').feature('hex1').setIndex('p', 4.95, 0, 6);
model.geom('geom1').feature('hex1').setIndex('p', -4.95, 0, 7);
model.geom('geom1').feature('hex1').setIndex('p', -1.95, 1, 0);
model.geom('geom1').feature('hex1').setIndex('p', -1.95, 1, 1);
model.geom('geom1').feature('hex1').setIndex('p', 1.95, 1, 2);
model.geom('geom1').feature('hex1').setIndex('p', 1.95, 1, 3);
model.geom('geom1').feature('hex1').setIndex('p', -1.713419348, 1, 4);
model.geom('geom1').feature('hex1').setIndex('p', -1.713419348, 1, 5);
model.geom('geom1').feature('hex1').setIndex('p', 1.713419348, 1, 6);
model.geom('geom1').feature('hex1').setIndex('p', 1.713419348, 1, 7);
model.geom('geom1').feature('hex1').setIndex('p', 0.1, 2, 0);
model.geom('geom1').feature('hex1').setIndex('p', 0.1, 2, 1);
model.geom('geom1').feature('hex1').setIndex('p', 0.1, 2, 2);
model.geom('geom1').feature('hex1').setIndex('p', 0.1, 2, 3);
model.geom('geom1').feature('hex1').setIndex('p', 0.75, 2, 4);
model.geom('geom1').feature('hex1').setIndex('p', 0.75, 2, 5);
model.geom('geom1').feature('hex1').setIndex('p', 0.75, 2, 6);
model.geom('geom1').feature('hex1').setIndex('p', 0.75, 2, 7);
model.geom('geom1').feature('hex1').setIndex('p', -1.72, 1, 4);
model.geom('geom1').feature('hex1').setIndex('p', -1.72, 1, 5);
model.geom('geom1').feature('hex1').setIndex('p', 1.72, 1, 6);
model.geom('geom1').feature('hex1').setIndex('p', 1.72, 1, 7);
model.geom('geom1').run('hex1');
model.geom('geom1').create('mir1', 'Mirror');
model.geom('geom1').feature('mir1').selection('input').set({'hex1'});
model.geom('geom1').feature('mir1').set('keep', true);
model.geom('geom1').run('mir1');
model.geom('geom1').create('uni1', 'Union');
model.geom('geom1').feature('uni1').label('Chip Package');
model.geom('geom1').feature('uni1').selection('input').set({'blk2' 'hex1' 'mir1'});
model.geom('geom1').feature('uni1').set('intbnd', false);
model.geom('geom1').feature('uni1').set('selresult', true);
model.geom('geom1').run('uni1');
model.geom('geom1').create('blk3', 'Block');
model.geom('geom1').feature('blk3').set('size', [0.4 0.26 0.2]);
model.geom('geom1').feature('blk3').set('pos', [-4.645 -2.21 0]);
model.geom('geom1').feature('blk3').setIndex('pos', -0.1, 2);
model.geom('geom1').run('blk3');
model.geom('geom1').feature.create('rev1', 'Revolve');
model.geom('geom1').feature('rev1').set('angtype', 'full');
model.geom('geom1').feature('rev1').selection('inputface').set('blk3', 3);
model.geom('geom1').feature('rev1').set('angtype', 'specang');
model.geom('geom1').feature('rev1').set('angle2', 90);
model.geom('geom1').feature('rev1').set('axistype', '3d');
model.geom('geom1').feature('rev1').set('pos3', [0 -2.211 -0.24]);
model.geom('geom1').feature('rev1').set('axis3', [1 0 0]);
model.geom('geom1').run('rev1');
model.geom('geom1').feature.create('ext1', 'Extrude');
model.geom('geom1').feature('ext1').selection('inputface').set('rev1', 2);
model.geom('geom1').feature('ext1').setIndex('distance', 0.322, 0);
model.geom('geom1').run('ext1');
model.geom('geom1').feature.create('rev2', 'Revolve');
model.geom('geom1').feature('rev2').set('angtype', 'full');
model.geom('geom1').feature('rev2').selection('inputface').set('ext1', 3);
model.geom('geom1').feature('rev2').set('angtype', 'specang');
model.geom('geom1').feature('rev2').set('angle2', -90);
model.geom('geom1').feature('rev2').set('axistype', '3d');
model.geom('geom1').feature('rev2').set('pos3', [0 -2.69 -0.561]);
model.geom('geom1').feature('rev2').set('axis3', [1 0 0]);
model.geom('geom1').run('rev2');
model.geom('geom1').feature.create('ext2', 'Extrude');
model.geom('geom1').feature('ext2').selection('inputface').set('rev2', 2);
model.geom('geom1').feature('ext2').setIndex('distance', 0.16, 0);
model.geom('geom1').run('ext2');
model.geom('geom1').create('uni2', 'Union');
model.geom('geom1').feature('uni2').selection('input').set({'ext2'});
model.geom('geom1').feature('uni2').set('intbnd', false);
model.geom('geom1').run('uni2');
model.geom('geom1').create('arr1', 'Array');
model.geom('geom1').feature('arr1').selection('input').set({'uni2'});
model.geom('geom1').feature('arr1').set('fullsize', [8 1 1]);
model.geom('geom1').feature('arr1').set('displ', [1.27 0 0]);
model.geom('geom1').selection.create('csel1', 'CumulativeSelection');
model.geom('geom1').selection('csel1').label('Pins');
model.geom('geom1').feature('arr1').set('contributeto', 'csel1');
model.geom('geom1').run('arr1');
model.geom('geom1').create('mir2', 'Mirror');
model.geom('geom1').feature('mir2').set('keep', true);
model.geom('geom1').feature('mir2').selection('input').named('csel1');
model.geom('geom1').feature('mir2').set('contributeto', 'csel1');
model.geom('geom1').feature('mir2').set('axis', [0 1 0]);
model.geom('geom1').run('mir2');
model.geom('geom1').create('wp1', 'WorkPlane');
model.geom('geom1').feature('wp1').set('unite', true);
model.geom('geom1').feature('wp1').set('quickz', -0.9);
model.geom('geom1').feature('wp1').geom.create('r1', 'Rectangle');
model.geom('geom1').feature('wp1').geom.feature('r1').set('size', [6 4]);
model.geom('geom1').feature('wp1').geom.feature('r1').set('pos', [-10 -5]);
model.geom('geom1').feature('wp1').geom.feature('r1').setIndex('layername', 'Layer 1', 0);
model.geom('geom1').feature('wp1').geom.feature('r1').setIndex('layer', 2, 0);
model.geom('geom1').feature('wp1').geom.feature('r1').set('layerbottom', false);
model.geom('geom1').feature('wp1').geom.feature('r1').set('layerleft', true);
model.geom('geom1').run('wp1');
model.geom('geom1').create('wp2', 'WorkPlane');
model.geom('geom1').feature('wp2').set('unite', true);
model.geom('geom1').feature('wp2').label('Interconnect');
model.geom('geom1').feature('wp2').set('selresult', true);
model.geom('geom1').feature('wp2').geom.create('r1', 'Rectangle');
model.geom('geom1').feature('wp2').geom.feature('r1').set('size', [4.145 2.15]);
model.geom('geom1').feature('wp2').geom.feature('r1').set('pos', [-4.645 -1.95]);
model.geom('geom1').feature('wp2').geom.run('r1');
model.geom('geom1').feature('wp2').geom.create('r2', 'Rectangle');
model.geom('geom1').feature('wp2').geom.feature('r2').set('size', [3.745 1.75]);
model.geom('geom1').feature('wp2').geom.feature('r2').set('pos', [-4.245 -1.95]);
model.geom('geom1').feature('wp2').geom.run('r2');
model.geom('geom1').feature('wp2').geom.create('dif1', 'Difference');
model.geom('geom1').feature('wp2').geom.feature('dif1').selection('input').set({'r1'});
model.geom('geom1').feature('wp2').geom.feature('dif1').selection('input2').set({'r2'});
model.geom('geom1').run('wp2');
model.geom('geom1').create('blk4', 'Block');
model.geom('geom1').feature('blk4').label('Chip');
model.geom('geom1').feature('blk4').set('size', [1 1 0.1]);
model.geom('geom1').feature('blk4').set('selresult', true);
model.geom('geom1').feature('blk4').set('base', 'center');
model.geom('geom1').run('fin');
model.geom('geom1').create('sel1', 'ExplicitSelection');
model.geom('geom1').feature('sel1').label('Geometry');
model.geom('geom1').feature('sel1').selection('selection').init;
model.geom('geom1').feature('sel1').selection('selection').set({'fin'});
model.geom('geom1').run('sel1');
model.geom('geom1').create('adjsel1', 'AdjacentSelection');
model.geom('geom1').feature('adjsel1').label('Exterior Boundaries');
model.geom('geom1').feature('adjsel1').set('input', {'sel1'});
model.geom('geom1').run('adjsel1');
model.geom('geom1').create('sel2', 'ExplicitSelection');
model.geom('geom1').feature('sel2').selection('selection').init(2);
model.geom('geom1').feature('sel2').selection('selection').set('fin', [7 37]);
model.geom('geom1').feature('sel2').label('Copper Layers');

model.title([]);

model.description('');

model.label('surface_mount_package_geom_sequence.mph');

model.modelNode.label('Components');

out = model;
