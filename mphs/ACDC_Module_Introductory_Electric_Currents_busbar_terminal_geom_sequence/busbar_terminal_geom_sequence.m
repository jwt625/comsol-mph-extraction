function out = model
%
% busbar_terminal_geom_sequence.m
%
% Model exported on May 26 2025, 21:25 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/ACDC_Module/Introductory_Electric_Currents');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 3);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.param.set('L', '9[cm]');
model.param.descr('L', 'Length');
model.param.set('rad_1', '6[mm]');
model.param.descr('rad_1', 'Bolt radius');
model.param.set('tbb', '5[mm]');
model.param.descr('tbb', 'Thickness');
model.param.set('wbb', '5[cm]');
model.param.descr('wbb', 'Width');

model.geom('geom1').create('wp1', 'WorkPlane');
model.geom('geom1').feature('wp1').set('unite', true);
model.geom('geom1').feature('wp1').set('quickplane', 'xz');

model.view('view2').axis.set('xmin', '-1e-2');
model.view('view2').axis.set('xmax', 0.11);
model.view('view2').axis.set('ymin', '-1e-2');
model.view('view2').axis.set('ymax', 0.11);
model.view('view2').axis.set('manualgrid', true);
model.view('view2').axis.set('xspacing', '5e-3');
model.view('view2').axis.set('yspacing', '5e-3');

model.geom('geom1').feature('wp1').geom.create('r1', 'Rectangle');
model.geom('geom1').feature('wp1').geom.feature('r1').set('size', {'L+2*tbb' '0.1[m]'});
model.geom('geom1').feature('wp1').geom.run('r1');
model.geom('geom1').feature('wp1').geom.create('r2', 'Rectangle');
model.geom('geom1').feature('wp1').geom.feature('r2').set('size', {'L+tbb' '0.1[m]-tbb'});
model.geom('geom1').feature('wp1').geom.feature('r2').set('pos', {'0' 'tbb'});
model.geom('geom1').feature('wp1').geom.run('r2');
model.geom('geom1').feature('wp1').geom.create('dif1', 'Difference');
model.geom('geom1').feature('wp1').geom.feature('dif1').selection('input').set({'r1'});
model.geom('geom1').feature('wp1').geom.feature('dif1').selection('input2').set({'r2'});
model.geom('geom1').feature('wp1').geom.run('dif1');
model.geom('geom1').feature('wp1').geom.create('fil1', 'Fillet');
model.geom('geom1').feature('wp1').geom.feature('fil1').selection('point').set('dif1', 3);
model.geom('geom1').feature('wp1').geom.feature('fil1').set('radius', 'tbb');
model.geom('geom1').feature('wp1').geom.run('fil1');
model.geom('geom1').feature('wp1').geom.create('fil2', 'Fillet');
model.geom('geom1').feature('wp1').geom.feature('fil2').selection('point').set('fil1', 6);
model.geom('geom1').feature('wp1').geom.feature('fil2').set('radius', '2*tbb');
model.geom('geom1').feature('wp1').geom.run('fil2');
model.geom('geom1').run('wp1');
model.geom('geom1').feature.create('ext1', 'Extrude');
model.geom('geom1').feature('ext1').set('workplane', 'wp1');
model.geom('geom1').feature('ext1').selection('input').set({'wp1'});
model.geom('geom1').feature('ext1').setIndex('distance', 'wbb', 0);
model.geom('geom1').run('ext1');
model.geom('geom1').create('wp2', 'WorkPlane');
model.geom('geom1').feature('wp2').set('unite', true);
model.geom('geom1').feature('wp2').set('planetype', 'faceparallel');
model.geom('geom1').feature('wp2').selection('face').set('ext1', 8);
model.geom('geom1').feature('wp2').geom.create('c1', 'Circle');
model.geom('geom1').feature('wp2').geom.feature('c1').set('r', 'rad_1');
model.geom('geom1').feature('wp2').geom.run('c1');
model.geom('geom1').run('wp2');
model.geom('geom1').feature.create('ext2', 'Extrude');
model.geom('geom1').feature('ext2').set('workplane', 'wp2');
model.geom('geom1').feature('ext2').selection('input').set({'wp2'});
model.geom('geom1').run('ext2');
model.geom('geom1').feature('ext2').setIndex('distance', '-2*tbb', 0);
model.geom('geom1').run('ext2');
model.geom('geom1').create('wp3', 'WorkPlane');
model.geom('geom1').feature('wp3').set('unite', true);
model.geom('geom1').feature('wp3').set('planetype', 'faceparallel');
model.geom('geom1').feature('wp3').selection('face').set('ext1', 4);
model.geom('geom1').feature('wp3').geom.create('c1', 'Circle');
model.geom('geom1').feature('wp3').geom.feature('c1').set('r', 'rad_1');
model.geom('geom1').feature('wp3').geom.feature('c1').set('pos', {'-L/2+1.5[cm]' '0'});
model.geom('geom1').feature('wp3').geom.feature('c1').setIndex('pos', '-wbb/4', 1);
model.geom('geom1').feature('wp3').geom.run('c1');
model.geom('geom1').feature('wp3').geom.create('copy1', 'Copy');
model.geom('geom1').feature('wp3').geom.feature('copy1').selection('input').set({'c1'});
model.geom('geom1').feature('wp3').geom.feature('copy1').set('disply', 'wbb/2');
model.geom('geom1').feature('wp3').geom.run('copy1');
model.geom('geom1').run('wp3');
model.geom('geom1').feature.create('ext3', 'Extrude');
model.geom('geom1').feature('ext3').set('workplane', 'wp3');
model.geom('geom1').feature('ext3').selection('input').set({'wp3'});
model.geom('geom1').feature('ext3').setIndex('distance', '-2*tbb', 0);
model.geom('geom1').run('ext3');
model.geom('geom1').run('fin');

model.title([]);

model.description('');

model.label('busbar_terminal_geom_sequence.mph');

model.modelNode.label('Components');

out = model;
