function out = model
%
% viscoelastic_damper_geom_sequence.m
%
% Model exported on May 26 2025, 21:33 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/Structural_Mechanics_Module/Dynamics_and_Vibration');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 3);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.geom('geom1').lengthUnit('mm');
model.geom('geom1').create('wp1', 'WorkPlane');
model.geom('geom1').feature('wp1').set('unite', true);
model.geom('geom1').feature('wp1').set('quickplane', 'yz');
model.geom('geom1').feature('wp1').set('quickx', -5);
model.geom('geom1').feature('wp1').geom.create('pol1', 'Polygon');
model.geom('geom1').feature('wp1').geom.feature('pol1').set('source', 'table');
model.geom('geom1').feature('wp1').geom.feature('pol1').setIndex('table', 27.7, 0, 0);
model.geom('geom1').feature('wp1').geom.feature('pol1').setIndex('table', 44.45, 0, 1);
model.geom('geom1').feature('wp1').geom.feature('pol1').setIndex('table', 27.7, 1, 0);
model.geom('geom1').feature('wp1').geom.feature('pol1').setIndex('table', -44.45, 1, 1);
model.geom('geom1').feature('wp1').geom.feature('pol1').setIndex('table', 117.7, 2, 0);
model.geom('geom1').feature('wp1').geom.feature('pol1').setIndex('table', -44.45, 2, 1);
model.geom('geom1').feature('wp1').geom.feature('pol1').setIndex('table', 117.7, 3, 0);
model.geom('geom1').feature('wp1').geom.feature('pol1').setIndex('table', 124.45, 3, 1);
model.geom('geom1').feature('wp1').geom.feature('pol1').setIndex('table', 57.7, 4, 0);
model.geom('geom1').feature('wp1').geom.feature('pol1').setIndex('table', 124.45, 4, 1);
model.geom('geom1').feature('wp1').geom.feature('pol1').setIndex('table', 57.7, 5, 0);
model.geom('geom1').feature('wp1').geom.feature('pol1').setIndex('table', 44.45, 5, 1);
model.geom('geom1').feature('wp1').geom.run('pol1');
model.geom('geom1').feature('wp1').geom.create('fil1', 'Fillet');
model.geom('geom1').feature('wp1').geom.feature('fil1').selection('pointinsketch').set('pol1', [3 6]);
model.geom('geom1').feature('wp1').geom.feature('fil1').set('radius', 12);
model.geom('geom1').feature('wp1').geom.run('fil1');
model.geom('geom1').feature('wp1').geom.create('c1', 'Circle');
model.geom('geom1').feature('wp1').geom.feature('c1').set('r', 8);
model.geom('geom1').feature('wp1').geom.feature('c1').set('pos', [87.7 102.45]);
model.geom('geom1').feature('wp1').geom.run('c1');
model.geom('geom1').feature('wp1').geom.create('dif1', 'Difference');
model.geom('geom1').feature('wp1').geom.feature('dif1').selection('input').set({'fil1'});
model.geom('geom1').feature('wp1').geom.feature('dif1').selection('input2').set({'c1'});
model.geom('geom1').run('wp1');
model.geom('geom1').feature.create('ext1', 'Extrude');
model.geom('geom1').feature('ext1').set('workplane', 'wp1');
model.geom('geom1').feature('ext1').selection('input').set({'wp1'});
model.geom('geom1').feature('ext1').setIndex('distance', 10, 0);
model.geom('geom1').run('ext1');
model.geom('geom1').create('wp2', 'WorkPlane');
model.geom('geom1').feature('wp2').set('unite', true);
model.geom('geom1').feature('wp2').set('planetype', 'faceparallel');
model.geom('geom1').feature('wp2').selection('face').set('ext1', 2);
model.geom('geom1').feature('wp2').geom.create('r1', 'Rectangle');
model.geom('geom1').feature('wp2').geom.feature('r1').set('size', [88.9 63.5]);
model.geom('geom1').feature('wp2').geom.feature('r1').set('base', 'center');
model.geom('geom1').run('wp2');
model.geom('geom1').feature.create('ext2', 'Extrude');
model.geom('geom1').feature('ext2').set('workplane', 'wp2');
model.geom('geom1').feature('ext2').selection('input').set({'wp2'});
model.geom('geom1').feature('ext2').setIndex('distance', 10, 0);
model.geom('geom1').feature('ext2').setIndex('distance', 22.7, 1);
model.geom('geom1').feature('ext2').set('displ', {'0' '0'; '0' '0'});
model.geom('geom1').feature('ext2').set('scale', {'1' '1'; '1' '1'});
model.geom('geom1').feature('ext2').set('twist', {'0' '0'});
model.geom('geom1').run('ext2');
model.geom('geom1').create('wp3', 'WorkPlane');
model.geom('geom1').feature('wp3').set('unite', true);
model.geom('geom1').feature('wp3').set('planetype', 'faceparallel');
model.geom('geom1').feature('wp3').selection('face').set('ext2', 2);
model.geom('geom1').feature('wp3').geom.create('r1', 'Rectangle');
model.geom('geom1').feature('wp3').geom.feature('r1').set('size', [198.9 63.5]);
model.geom('geom1').feature('wp3').geom.feature('r1').set('pos', [-154.45 -31.75]);
model.geom('geom1').feature('wp3').geom.run('r1');
model.geom('geom1').feature('wp3').geom.create('c1', 'Circle');
model.geom('geom1').feature('wp3').geom.feature('c1').set('r', 8);
model.geom('geom1').feature('wp3').geom.feature('c1').set('pos', [-107.45 0]);
model.geom('geom1').feature('wp3').geom.feature.duplicate('c2', 'c1');
model.geom('geom1').feature('wp3').geom.feature('c2').set('pos', [-132.45 0]);
model.geom('geom1').feature('wp3').geom.run('c2');
model.geom('geom1').feature('wp3').geom.create('dif1', 'Difference');
model.geom('geom1').feature('wp3').geom.feature('dif1').selection('input').set({'r1'});
model.geom('geom1').feature('wp3').geom.feature('dif1').selection('input2').set({'c1' 'c2'});
model.geom('geom1').run('wp3');
model.geom('geom1').feature.create('ext3', 'Extrude');
model.geom('geom1').feature('ext3').set('workplane', 'wp3');
model.geom('geom1').feature('ext3').selection('input').set({'wp3'});
model.geom('geom1').feature('ext3').setIndex('distance', 10, 0);
model.geom('geom1').run('ext3');
model.geom('geom1').create('mir1', 'Mirror');
model.geom('geom1').feature('mir1').selection('input').set({'ext1' 'ext2'});
model.geom('geom1').feature('mir1').set('axis', [0 -1 0]);
model.geom('geom1').feature('mir1').set('keep', true);
model.geom('geom1').runPre('fin');
model.geom('geom1').create('wp4', 'WorkPlane');
model.geom('geom1').feature('wp4').set('unite', true);
model.geom('geom1').feature('wp4').set('planetype', 'faceparallel');
model.geom('geom1').feature('wp4').selection('face').set('ext1', 3);
model.geom('geom1').run('wp4');
model.geom('geom1').create('pard1', 'PartitionDomains');
model.geom('geom1').feature('pard1').selection('domain').set('ext3', 1);
model.geom('geom1').run('pard1');
model.geom('geom1').nodeGroup.create('grp1');
model.geom('geom1').nodeGroup('grp1').label('Selections');
model.geom('geom1').create('sel1', 'ExplicitSelection');
model.geom('geom1').nodeGroup('grp1').add('sel1');
model.geom('geom1').feature('sel1').label('Left Hole');
model.geom('geom1').feature('sel1').selection('selection').init(2);
model.geom('geom1').feature('sel1').set('groupcontang', true);
model.geom('geom1').feature('sel1').selection('selection').add('mir1(1)', [8 9 10 11]);
model.geom('geom1').run('sel1');
model.geom('geom1').create('sel2', 'ExplicitSelection');
model.geom('geom1').feature('sel2').label('Right Hole');
model.geom('geom1').feature('sel2').selection('selection').init(2);
model.geom('geom1').feature('sel2').set('groupcontang', true);
model.geom('geom1').feature('sel2').selection('selection').add('ext1', [8 9 10 11]);
model.geom('geom1').run('sel2');
model.geom('geom1').create('sel3', 'ExplicitSelection');
model.geom('geom1').feature('sel3').label('Bottom Holes');
model.geom('geom1').feature('sel3').selection('selection').init(2);
model.geom('geom1').feature('sel3').set('groupcontang', true);
model.geom('geom1').feature('sel3').selection('selection').add('pard1', [10 11 12 13 14 15 16 17]);

model.title([]);

model.description('');

model.label('viscoelastic_damper_geom_sequence.mph');

model.modelNode.label('Components');

out = model;
