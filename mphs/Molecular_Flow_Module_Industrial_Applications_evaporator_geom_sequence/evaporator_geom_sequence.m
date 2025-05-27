function out = model
%
% evaporator_geom_sequence.m
%
% Model exported on May 26 2025, 21:30 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/Molecular_Flow_Module/Industrial_Applications');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 3);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.geom('geom1').lengthUnit('mm');
model.geom('geom1').create('cyl1', 'Cylinder');
model.geom('geom1').feature('cyl1').set('r', 254);
model.geom('geom1').feature('cyl1').set('h', 381);
model.geom('geom1').feature('cyl1').set('pos', [0 25.4 -50.8]);
model.geom('geom1').run('cyl1');
model.geom('geom1').create('sph1', 'Sphere');
model.geom('geom1').feature('sph1').set('r', 254);
model.geom('geom1').feature('sph1').set('pos', [0 25.4 330.2]);
model.geom('geom1').run('sph1');
model.geom('geom1').create('uni1', 'Union');
model.geom('geom1').feature('uni1').selection('input').set({'cyl1' 'sph1'});
model.geom('geom1').feature('uni1').set('intbnd', false);
model.geom('geom1').run('uni1');
model.geom('geom1').create('cyl2', 'Cylinder');
model.geom('geom1').feature('cyl2').set('r', 82.55);
model.geom('geom1').feature('cyl2').set('h', 12.7);
model.geom('geom1').feature('cyl2').set('pos', [0 0 279.4]);
model.geom('geom1').run('cyl2');
model.geom('geom1').create('cyl3', 'Cylinder');
model.geom('geom1').feature('cyl3').set('r', 19.05);
model.geom('geom1').feature('cyl3').set('h', 50.8);
model.geom('geom1').feature('cyl3').set('pos', [-79 -34.8 -50.8]);
model.geom('geom1').run('cyl3');
model.geom('geom1').create('rot1', 'Rotate');
model.geom('geom1').feature('rot1').set('keep', true);

model.view('view1').set('renderwireframe', true);

model.geom('geom1').feature('rot1').selection('input').set({'cyl3'});
model.geom('geom1').feature('rot1').set('rot', 'range(0,30,60)');
model.geom('geom1').feature('rot1').set('pos', [0 102.03 0]);
model.geom('geom1').run('rot1');
model.geom('geom1').create('blk1', 'Block');
model.geom('geom1').feature('blk1').set('size', [2.54 63.5 76.2]);
model.geom('geom1').feature('blk1').set('pos', [-34.5 -27.2 -50.8]);
model.geom('geom1').feature('blk1').set('rot', -15);
model.geom('geom1').selection.create('csel1', 'CumulativeSelection');
model.geom('geom1').selection('csel1').label('Shield');
model.geom('geom1').feature('blk1').set('contributeto', 'csel1');
model.geom('geom1').run('blk1');
model.geom('geom1').create('mir1', 'Mirror');
model.geom('geom1').feature('mir1').selection('input').named('csel1');
model.geom('geom1').feature('mir1').set('contributeto', 'csel1');
model.geom('geom1').feature('mir1').set('keep', true);
model.geom('geom1').feature('mir1').set('axis', [1 0 0]);
model.geom('geom1').run('mir1');
model.geom('geom1').create('blk2', 'Block');
model.geom('geom1').feature('blk2').set('size', [12.7 85 1.27]);
model.geom('geom1').feature('blk2').set('pos', [-6.35 -40 -1.27]);
model.geom('geom1').run('blk2');
model.geom('geom1').create('sph2', 'Sphere');
model.geom('geom1').feature('sph2').set('r', 6.35);
model.geom('geom1').feature('sph2').set('pos', [0 0 2.54]);
model.geom('geom1').run('sph2');
model.geom('geom1').create('copy1', 'Copy');
model.geom('geom1').feature('copy1').selection('input').set({'sph2'});
model.geom('geom1').feature('copy1').set('displz', 1.27);
model.geom('geom1').run('copy1');
model.geom('geom1').create('blk3', 'Block');
model.geom('geom1').feature('blk3').set('size', [120 34.35 1.27]);
model.geom('geom1').feature('blk3').set('pos', [-60 55.2 -1.27]);
model.geom('geom1').run('blk3');
model.geom('geom1').create('cyl4', 'Cylinder');
model.geom('geom1').feature('cyl4').set('r', 101.6);
model.geom('geom1').feature('cyl4').set('h', 1.27);
model.geom('geom1').feature('cyl4').set('pos', [0 137.2 -1.27]);
model.geom('geom1').run('cyl4');
model.geom('geom1').create('uni2', 'Union');
model.geom('geom1').feature('uni2').selection('input').set({'blk3' 'cyl4'});
model.geom('geom1').run('uni2');
model.geom('geom1').feature.create('del1', 'Delete');
model.geom('geom1').feature('del1').selection('input').init;
model.geom('geom1').feature('del1').selection('input').init(3);
model.geom('geom1').feature('del1').selection('input').set('uni2', [1 2 5]);
model.geom('geom1').run('del1');
model.geom('geom1').create('uni3', 'Union');
model.geom('geom1').feature('uni3').selection('input').set({'blk2' 'del1'});
model.geom('geom1').feature('uni3').set('intbnd', false);
model.geom('geom1').run('uni3');
model.geom('geom1').create('uni4', 'Union');
model.geom('geom1').feature('uni4').selection('input').set({'copy1' 'sph2' 'uni3'});
model.geom('geom1').run('uni4');
model.geom('geom1').feature.create('del2', 'Delete');
model.geom('geom1').feature('del2').selection('input').init;
model.geom('geom1').feature('del2').selection('input').init(3);
model.geom('geom1').feature('del2').selection('input').set('uni4', [2 3 4 7]);
model.geom('geom1').run('del2');
model.geom('geom1').create('uni5', 'Union');
model.geom('geom1').feature('uni5').selection('input').set({'del2'});
model.geom('geom1').feature('uni5').set('intbnd', false);
model.geom('geom1').run('uni5');
model.geom('geom1').create('wp1', 'WorkPlane');
model.geom('geom1').feature('wp1').set('unite', true);
model.geom('geom1').feature('wp1').set('quickz', -1.27);
model.geom('geom1').feature('wp1').geom.create('pol1', 'Polygon');
model.geom('geom1').feature('wp1').geom.feature('pol1').set('source', 'vectors');
model.geom('geom1').feature('wp1').geom.feature('pol1').set('x', '-19.05 0 0 19.05 19.05 6.35 6.35 0 0 -6.35 -6.35 -19.05');
model.geom('geom1').feature('wp1').geom.feature('pol1').set('y', '63.5 82.55 82.55 63.5 63.5 45.55 45.55 44.45 44.45 45.54 45.54 63.5');
model.geom('geom1').run('wp1');
model.geom('geom1').feature.create('ext1', 'Extrude');
model.geom('geom1').feature('ext1').set('workplane', 'wp1');
model.geom('geom1').feature('ext1').selection('input').set({'wp1'});
model.geom('geom1').feature('ext1').setIndex('distance', 49.53, 0);
model.geom('geom1').feature('ext1').set('reverse', true);
model.geom('geom1').run('ext1');
model.geom('geom1').create('wp2', 'WorkPlane');
model.geom('geom1').feature('wp2').set('unite', true);
model.geom('geom1').feature('wp2').set('quickz', -50.8);
model.geom('geom1').feature('wp2').geom.create('c1', 'Circle');
model.geom('geom1').feature('wp2').geom.feature('c1').set('r', 63.5);
model.geom('geom1').feature('wp2').geom.feature('c1').set('pos', [0 203.2]);
model.geom('geom1').run('wp2');
model.geom('geom1').create('wp3', 'WorkPlane');
model.geom('geom1').feature('wp3').set('unite', true);
model.geom('geom1').feature('wp3').set('quickz', 279.4);
model.geom('geom1').feature('wp3').geom.create('c1', 'Circle');
model.geom('geom1').feature('wp3').geom.feature('c1').set('r', 101.6);
model.geom('geom1').feature('wp3').geom.feature('c1').set('angle', 90);
model.geom('geom1').feature('wp3').geom.feature('c1').set('pos', [-38.1 38.1]);
model.geom('geom1').feature('wp3').geom.feature('c1').set('rot', -90);
model.geom('geom1').run('wp3');
model.geom('geom1').create('dif1', 'Difference');
model.geom('geom1').feature('dif1').selection('input').set({'uni1'});
model.geom('geom1').feature('dif1').selection('input2').set({'blk1' 'cyl2' 'cyl3' 'ext1' 'mir1' 'rot1' 'uni5' 'wp2' 'wp3'});
model.geom('geom1').run('fin');
model.geom('geom1').create('cmf1', 'CompositeFaces');
model.geom('geom1').feature('cmf1').selection('input').set('fin', [34 36]);
model.geom('geom1').run('cmf1');
model.geom('geom1').create('cmf2', 'CompositeFaces');
model.geom('geom1').feature('cmf2').selection('input').set('cmf1', 1);
model.geom('geom1').feature('cmf2').selection('input').clear('cmf1');
model.geom('geom1').feature('cmf2').selection('input').set('cmf1', [18 19 22 23 39 40 60]);
model.geom('geom1').run('cmf2');
model.geom('geom1').create('cmf3', 'CompositeFaces');
model.geom('geom1').feature('cmf3').selection('input').set('cmf2', 1);
model.geom('geom1').feature('cmf3').selection('input').clear('cmf2');
model.geom('geom1').feature('cmf3').selection('input').set('cmf2', [36 38]);
model.geom('geom1').run('cmf3');
model.geom('geom1').create('clf1', 'CollapseFaces');
model.geom('geom1').feature('clf1').selection('input').set('cmf3', [17 64]);
model.geom('geom1').run('clf1');
model.geom('geom1').create('ballsel1', 'BallSelection');
model.geom('geom1').feature('ballsel1').set('entitydim', 2);
model.geom('geom1').feature('ballsel1').set('r', 10);
model.geom('geom1').feature('ballsel1').label('Boat');
model.geom('geom1').run('ballsel1');
model.geom('geom1').create('sel1', 'ExplicitSelection');
model.geom('geom1').feature('sel1').label('Geometry');
model.geom('geom1').feature('sel1').selection('selection').init;
model.geom('geom1').feature('sel1').selection('selection').set({'clf1'});
model.geom('geom1').run('sel1');
model.geom('geom1').create('adjsel1', 'AdjacentSelection');
model.geom('geom1').feature('adjsel1').label('All Boundaries');
model.geom('geom1').feature('adjsel1').set('input', {'sel1'});
model.geom('geom1').feature('adjsel1').set('interior', true);
model.geom('geom1').run('adjsel1');
model.geom('geom1').create('unisel1', 'UnionSelection');
model.geom('geom1').feature('unisel1').set('entitydim', 2);
model.geom('geom1').feature('unisel1').label('Boat and Shields');
model.geom('geom1').feature('unisel1').set('input', {'csel1' 'ballsel1'});
model.geom('geom1').run('unisel1');
model.geom('geom1').create('sel2', 'ExplicitSelection');
model.geom('geom1').feature('sel2').label('Front Quadrant');
model.geom('geom1').feature('sel2').selection('selection').init(2);
model.geom('geom1').feature('sel2').selection('selection').set('clf1', [1 4]);
model.geom('geom1').run('sel2');
model.geom('geom1').create('sel3', 'ExplicitSelection');
model.geom('geom1').feature('sel3').label('Sample Mount Back');
model.geom('geom1').feature('sel3').selection('selection').init(2);
model.geom('geom1').feature('sel3').set('groupcontang', true);
model.geom('geom1').feature('sel3').selection('selection').add('clf1', [9 10 12 44 52]);
model.geom('geom1').run('sel3');
model.geom('geom1').create('difsel1', 'DifferenceSelection');
model.geom('geom1').feature('difsel1').label('Deposition Surfaces');
model.geom('geom1').feature('difsel1').set('entitydim', 2);
model.geom('geom1').feature('difsel1').set('add', {'adjsel1'});
model.geom('geom1').feature('difsel1').set('subtract', {'unisel1' 'sel2' 'sel3'});
model.geom('geom1').run('difsel1');
model.geom('geom1').create('sel4', 'ExplicitSelection');
model.geom('geom1').feature('sel4').label('Meshing 1');
model.geom('geom1').feature('sel4').selection('selection').init(2);
model.geom('geom1').feature('sel4').set('groupcontang', true);
model.geom('geom1').feature('sel4').selection('selection').add('clf1', [1 2 4 5 25 42 43 49 53 59]);
model.geom('geom1').run('sel4');
model.geom('geom1').create('sel5', 'ExplicitSelection');
model.geom('geom1').feature('sel5').label('Meshing 2');
model.geom('geom1').feature('sel5').selection('selection').init(2);
model.geom('geom1').feature('sel5').selection('selection').set('clf1', 21);

model.title([]);

model.description('');

model.label('evaporator_geom_sequence.mph');

model.modelNode.label('Components');

out = model;
