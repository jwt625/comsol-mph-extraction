function out = model
%
% monopile_geom_sequence.m
%
% Model exported on May 26 2025, 21:27 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/Corrosion_Module/Cathodic_Protection');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 3);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.geom('geom1').create('cone1', 'Cone');
model.geom('geom1').feature('cone1').set('specifytop', 'radius');
model.geom('geom1').feature('cone1').set('r', 2);
model.geom('geom1').feature('cone1').set('h', 80);
model.geom('geom1').feature('cone1').set('rtop', 1.6);
model.geom('geom1').feature('cone1').set('pos', [0 0 -80]);
model.geom('geom1').run('cone1');

model.view('view1').set('renderwireframe', true);

model.geom('geom1').create('cone2', 'Cone');
model.geom('geom1').feature('cone2').set('specifytop', 'radius');
model.geom('geom1').feature('cone2').set('r', 2);
model.geom('geom1').feature('cone2').set('h', 20);
model.geom('geom1').feature('cone2').set('rtop', 1.5);
model.geom('geom1').feature('cone2').set('pos', [0 0 -15]);
model.geom('geom1').run('cone2');
model.geom('geom1').create('wp1', 'WorkPlane');
model.geom('geom1').feature('wp1').set('unite', true);
model.geom('geom1').feature('wp1').set('quickplane', 'xz');
model.geom('geom1').feature('wp1').set('quicky', -0.4);
model.geom('geom1').feature('wp1').geom.create('qb1', 'QuadraticBezier');
model.geom('geom1').feature('wp1').geom.feature('qb1').setIndex('p', 1.1, 0, 0);
model.geom('geom1').feature('wp1').geom.feature('qb1').setIndex('p', 3.5, 1, 0);
model.geom('geom1').feature('wp1').geom.feature('qb1').setIndex('p', 3, 0, 1);
model.geom('geom1').feature('wp1').geom.feature('qb1').setIndex('p', 3.5, 1, 1);
model.geom('geom1').feature('wp1').geom.feature('qb1').setIndex('p', 3, 0, 2);
model.geom('geom1').feature('wp1').geom.feature('qb1').setIndex('p', 2, 1, 2);
model.geom('geom1').feature('wp1').geom.run('qb1');
model.geom('geom1').feature('wp1').geom.create('ls1', 'LineSegment');
model.geom('geom1').feature('wp1').geom.feature('ls1').set('specify1', 'coord');
model.geom('geom1').feature('wp1').geom.feature('ls1').set('specify2', 'coord');
model.geom('geom1').feature('wp1').geom.feature('ls1').set('coord1', [3 2]);
model.geom('geom1').feature('wp1').geom.feature('ls1').set('coord2', [3 -8]);
model.geom('geom1').feature('wp1').geom.run('ls1');
model.geom('geom1').run('wp1');
model.geom('geom1').create('wp2', 'WorkPlane');
model.geom('geom1').feature('wp2').set('unite', true);
model.geom('geom1').feature('wp2').set('quickz', -8);
model.geom('geom1').feature('wp2').geom.create('c1', 'Circle');
model.geom('geom1').feature('wp2').geom.feature('c1').set('r', 0.1);
model.geom('geom1').feature('wp2').geom.feature('c1').set('pos', [3 -0.4]);
model.geom('geom1').feature('wp2').geom.run('c1');
model.geom('geom1').run('wp2');
model.geom('geom1').create('swe1', 'Sweep');
model.geom('geom1').feature('swe1').set('includefinal', false);
model.geom('geom1').feature('swe1').set('crossfaces', true);
model.geom('geom1').feature('swe1').set('manualdir', false);
model.geom('geom1').feature('swe1').selection('enttosweep').set('wp2', 1);
model.geom('geom1').feature('swe1').selection('edge').set('wp1', [1 2]);
model.geom('geom1').feature('swe1').set('manualdir', true);
model.geom('geom1').feature('swe1').set('reversedir', true);
model.geom('geom1').feature('swe1').set('keep', false);
model.geom('geom1').run('swe1');
model.geom('geom1').create('copy1', 'Copy');
model.geom('geom1').feature('copy1').selection('input').set({'swe1'});
model.geom('geom1').feature('copy1').set('disply', 0.8);
model.geom('geom1').run('copy1');
model.geom('geom1').create('cyl1', 'Cylinder');
model.geom('geom1').feature('cyl1').set('r', 2.8);
model.geom('geom1').feature('cyl1').set('h', 0.1);
model.geom('geom1').feature('cyl1').set('pos', [0 0 2]);
model.geom('geom1').run('cyl1');
model.geom('geom1').create('blk1', 'Block');
model.geom('geom1').feature('blk1').set('size', [0.1 0.8 0.05]);
model.geom('geom1').feature('blk1').set('pos', [2.95 -0.4 -8]);
model.geom('geom1').run('blk1');
model.geom('geom1').create('arr1', 'Array');
model.geom('geom1').feature('arr1').selection('input').set({'blk1'});
model.geom('geom1').feature('arr1').set('fullsize', [1 1 50]);
model.geom('geom1').feature('arr1').set('displ', [0 0 0.18]);
model.geom('geom1').run('arr1');
model.geom('geom1').create('wp3', 'WorkPlane');
model.geom('geom1').feature('wp3').set('unite', true);
model.geom('geom1').feature('wp3').set('quickplane', 'yz');
model.geom('geom1').feature('wp3').set('quickx', 3);
model.geom('geom1').feature('wp3').geom.create('c1', 'Circle');
model.geom('geom1').feature('wp3').geom.feature('c1').set('r', 0.08);
model.geom('geom1').feature('wp3').geom.feature('c1').set('pos', [-0.4 -7.8]);
model.geom('geom1').feature('wp3').geom.run('c1');
model.geom('geom1').feature('wp3').geom.create('arr1', 'Array');
model.geom('geom1').feature('wp3').geom.feature('arr1').selection('input').set({'c1'});
model.geom('geom1').feature('wp3').geom.feature('arr1').set('fullsize', [2 4]);
model.geom('geom1').feature('wp3').geom.feature('arr1').set('displ', [0.8 2]);
model.geom('geom1').feature('wp3').geom.run('arr1');
model.geom('geom1').run('wp3');
model.geom('geom1').feature.create('ext1', 'Extrude');
model.geom('geom1').feature('ext1').setIndex('distance', 3, 0);
model.geom('geom1').feature('ext1').set('reverse', true);
model.geom('geom1').run('ext1');
model.geom('geom1').create('mov1', 'Move');
model.geom('geom1').feature('mov1').selection('input').set({'ext1'});
model.geom('geom1').feature('mov1').set('displz', 3);
model.geom('geom1').run('mov1');
model.geom('geom1').create('uni1', 'Union');
model.geom('geom1').feature('uni1').set('intbnd', false);
model.geom('geom1').feature('uni1').selection('input').set({'arr1' 'cone2' 'copy1' 'cyl1' 'mov1' 'swe1'});
model.geom('geom1').run('uni1');
model.geom('geom1').create('cyl2', 'Cylinder');
model.geom('geom1').feature('cyl2').set('r', 60);
model.geom('geom1').feature('cyl2').set('h', 100);
model.geom('geom1').feature('cyl2').set('pos', [0 0 -100]);
model.geom('geom1').feature('cyl2').setIndex('layername', 'Layer 1', 0);
model.geom('geom1').feature('cyl2').setIndex('layer', 60, 0);
model.geom('geom1').feature('cyl2').set('layerside', false);
model.geom('geom1').feature('cyl2').set('layerbottom', true);
model.geom('geom1').run('cyl2');
model.geom('geom1').create('blk2', 'Block');
model.geom('geom1').feature('blk2').set('size', [150 75 300]);
model.geom('geom1').feature('blk2').set('pos', [-75 -75 -150]);
model.geom('geom1').run('blk2');
model.geom('geom1').create('dif1', 'Difference');
model.geom('geom1').feature('dif1').selection('input').set({'cone1' 'cyl2' 'uni1'});
model.geom('geom1').feature('dif1').selection('input2').set({'blk2'});
model.geom('geom1').run('dif1');
model.geom('geom1').create('del1', 'Delete');
model.geom('geom1').feature('del1').selection('input').init(3);
model.geom('geom1').feature('del1').selection('input').set('dif1', [4 5 6 7]);

model.param.set('NanodeTp', '10');
model.param.descr('NanodeTp', 'Number of anodes around transition piece');
model.param.set('NanodeMp', '4');
model.param.descr('NanodeMp', 'Number of anodes around monopile');

model.geom('geom1').run('del1');
model.geom('geom1').create('pol1', 'Polygon');
model.geom('geom1').feature('pol1').set('source', 'table');
model.geom('geom1').feature('pol1').setIndex('table', -2.4, 0, 0);
model.geom('geom1').feature('pol1').setIndex('table', 0, 0, 1);
model.geom('geom1').feature('pol1').setIndex('table', -4, 0, 2);
model.geom('geom1').feature('pol1').setIndex('table', -2.3, 1, 0);
model.geom('geom1').feature('pol1').setIndex('table', 0, 1, 1);
model.geom('geom1').feature('pol1').setIndex('table', -2, 1, 2);
model.geom('geom1').selection.create('csel1', 'CumulativeSelection');
model.geom('geom1').selection('csel1').label('AnodeTp');
model.geom('geom1').feature('pol1').set('contributeto', 'csel1');
model.geom('geom1').run('pol1');
model.geom('geom1').create('rot1', 'Rotate');
model.geom('geom1').feature('rot1').selection('input').named('csel1');
model.geom('geom1').feature('rot1').set('rot', '-range(180/NanodeTp,360/NanodeTp,180-180/NanodeTp)');
model.geom('geom1').feature('rot1').set('contributeto', 'csel1');
model.geom('geom1').run('rot1');
model.geom('geom1').create('copy2', 'Copy');
model.geom('geom1').feature('copy2').selection('input').set({'rot1'});
model.geom('geom1').feature('copy2').set('displz', -8);
model.geom('geom1').feature('copy2').set('contributeto', 'csel1');
model.geom('geom1').run('copy2');
model.geom('geom1').create('pol2', 'Polygon');
model.geom('geom1').feature('pol2').set('source', 'vectors');
model.geom('geom1').feature('pol2').set('x', 2.5);
model.geom('geom1').feature('pol2').set('y', 0);
model.geom('geom1').feature('pol2').set('z', '-16 -18');
model.geom('geom1').selection.create('csel2', 'CumulativeSelection');
model.geom('geom1').selection('csel2').label('AnodeMp');
model.geom('geom1').feature('pol2').set('contributeto', 'csel2');
model.geom('geom1').run('pol2');
model.geom('geom1').create('arr2', 'Array');
model.geom('geom1').feature('arr2').selection('input').named('csel2');
model.geom('geom1').feature('arr2').set('fullsize', [1 1 4]);
model.geom('geom1').feature('arr2').set('displ', [0 0 -6]);
model.geom('geom1').run('arr2');
model.geom('geom1').create('rot2', 'Rotate');
model.geom('geom1').feature('rot2').selection('input').set({'arr2'});
model.geom('geom1').feature('rot2').set('rot', 'range(180/NanodeMp,360/NanodeMp,180-180/NanodeMp)');
model.geom('geom1').feature('rot2').set('contributeto', 'csel2');
model.geom('geom1').run('rot2');
model.geom('geom1').create('unisel1', 'UnionSelection');
model.geom('geom1').feature('unisel1').label('Anodes');
model.geom('geom1').feature('unisel1').set('entitydim', 1);
model.geom('geom1').feature('unisel1').set('input', {'csel1' 'csel2'});
model.geom('geom1').run('unisel1');
model.geom('geom1').create('rot3', 'Rotate');
model.geom('geom1').feature('rot3').selection('input').set({'copy2' 'del1' 'rot1' 'rot2'});
model.geom('geom1').feature('rot3').set('rot', 180);
model.geom('geom1').run('rot3');

model.title([]);

model.description('');

model.label('monopile_geom_sequence.mph');

model.modelNode.label('Components');

out = model;
