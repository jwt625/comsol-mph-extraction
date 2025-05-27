function out = model
%
% sma_stent_geom_sequence.m
%
% Model exported on May 26 2025, 21:31 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/Nonlinear_Structural_Materials_Module/Shape_Memory_Alloys');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 3);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.param.set('Ro', '3[mm]');
model.param.descr('Ro', 'Outer radius');
model.param.set('wr', '0.2[mm]');
model.param.descr('wr', 'Width');
model.param.set('Ri', 'Ro-wr');
model.param.descr('Ri', 'Inner radius');
model.param.set('hs', '2.4[mm]');
model.param.descr('hs', 'Height');
model.param.set('th', '0.12[mm]');
model.param.descr('th', 'Thickness');
model.param.set('Ns', '18');
model.param.descr('Ns', 'Number of sectors');
model.param.set('alpha', '2*pi/Ns/2[rad]');
model.param.descr('alpha', 'Sector angle');
model.param.set('radius', '0.12[mm]');
model.param.descr('radius', 'Bent radius');

model.geom('geom1').lengthUnit('mm');
model.geom('geom1').create('wp1', 'WorkPlane');
model.geom('geom1').feature('wp1').set('unite', true);
model.geom('geom1').feature('wp1').set('quickplane', 'yz');
model.geom('geom1').feature('wp1').geom.create('c1', 'Circle');
model.geom('geom1').feature('wp1').geom.feature('c1').set('type', 'curve');
model.geom('geom1').feature('wp1').geom.feature('c1').set('r', 'radius-th/2');
model.geom('geom1').feature('wp1').geom.feature('c1').set('angle', 180);
model.geom('geom1').feature('wp1').geom.feature('c1').set('pos', {'-Ri*sin(alpha/2)' '0'});
model.geom('geom1').feature('wp1').geom.feature('c1').setIndex('pos', 'hs/2-radius', 1);
model.geom('geom1').feature('wp1').geom.feature('c1').set('rot', 270);
model.geom('geom1').feature('wp1').geom.feature('c1').set('selresult', true);
model.geom('geom1').feature('wp1').geom.feature('c1').set('selresultshow', false);
model.geom('geom1').feature('wp1').geom.selection.create('csel1', 'CumulativeSelection');
model.geom('geom1').feature('wp1').geom.selection('csel1').label('union1');
model.geom('geom1').feature('wp1').geom.feature('c1').set('contributeto', 'csel1');
model.geom('geom1').feature('wp1').geom.run('c1');
model.geom('geom1').feature('wp1').geom.create('c2', 'Circle');
model.geom('geom1').feature('wp1').geom.feature('c2').set('type', 'curve');
model.geom('geom1').feature('wp1').geom.feature('c2').set('r', 'radius+th/2');
model.geom('geom1').feature('wp1').geom.feature('c2').set('angle', 180);
model.geom('geom1').feature('wp1').geom.feature('c2').set('pos', {'Ri*sin(alpha/2)' '0'});
model.geom('geom1').feature('wp1').geom.feature('c2').setIndex('pos', '-(hs/2-radius)', 1);
model.geom('geom1').feature('wp1').geom.feature('c2').set('rot', 90);
model.geom('geom1').feature('wp1').geom.feature('c2').set('selresult', true);
model.geom('geom1').feature('wp1').geom.feature('c2').set('selresultshow', false);
model.geom('geom1').feature('wp1').geom.feature('c2').set('contributeto', 'csel1');
model.geom('geom1').feature('wp1').geom.run('c2');
model.geom('geom1').feature('wp1').geom.create('tan1', 'Tangent');
model.geom('geom1').feature('wp1').geom.feature('tan1').selection('edge').named('c1');
model.geom('geom1').feature('wp1').geom.feature('tan1').selection('edge2').named('c2');
model.geom('geom1').feature('wp1').geom.feature('tan1').set('contributeto', 'csel1');
model.geom('geom1').feature('wp1').geom.run('tan1');
model.geom('geom1').feature('wp1').geom.create('uni1', 'Union');
model.geom('geom1').feature('wp1').geom.feature('uni1').selection('input').named('csel1');
model.geom('geom1').feature('wp1').geom.feature.duplicate('c3', 'c1');
model.geom('geom1').feature('wp1').geom.feature.duplicate('c4', 'c2');
model.geom('geom1').feature('wp1').geom.feature.duplicate('tan2', 'tan1');
model.geom('geom1').feature('wp1').geom.feature.duplicate('uni2', 'uni1');
model.geom('geom1').feature('wp1').geom.feature('c3').set('r', 'radius+th/2');
model.geom('geom1').feature('wp1').geom.selection.create('csel2', 'CumulativeSelection');
model.geom('geom1').feature('wp1').geom.selection('csel2').label('union2');
model.geom('geom1').feature('wp1').geom.feature('c3').set('contributeto', 'csel2');
model.geom('geom1').feature('wp1').geom.feature('c4').set('r', 'radius-th/2');
model.geom('geom1').feature('wp1').geom.feature('c4').set('contributeto', 'csel2');
model.geom('geom1').feature('wp1').geom.run('c4');
model.geom('geom1').feature('wp1').geom.feature('tan2').selection('edge').named('c3');
model.geom('geom1').feature('wp1').geom.feature('tan2').selection('edge2').named('c4');
model.geom('geom1').feature('wp1').geom.feature('tan2').set('contributeto', 'csel2');
model.geom('geom1').feature('wp1').geom.run('tan2');
model.geom('geom1').feature('wp1').geom.feature('uni2').selection('input').named('csel2');
model.geom('geom1').feature('wp1').geom.run('uni2');
model.geom('geom1').feature('wp1').geom.create('ls1', 'LineSegment');
model.geom('geom1').feature('wp1').geom.feature('ls1').selection('vertex1').set('uni1', 4);
model.geom('geom1').feature('wp1').geom.feature('ls1').selection('vertex2').set('uni2', 4);
model.geom('geom1').feature('wp1').geom.run('ls1');
model.geom('geom1').feature('wp1').geom.create('ls2', 'LineSegment');
model.geom('geom1').feature('wp1').geom.feature('ls2').selection('vertex1').set('uni1', 7);
model.geom('geom1').feature('wp1').geom.feature('ls2').selection('vertex2').set('uni2', 7);
model.geom('geom1').feature('wp1').geom.run('ls2');
model.geom('geom1').feature('wp1').geom.run('ls2');
model.geom('geom1').feature('wp1').geom.create('r1', 'Rectangle');
model.geom('geom1').feature('wp1').geom.feature('r1').set('type', 'curve');
model.geom('geom1').feature('wp1').geom.feature('r1').set('size', {'0.2' 'th'});
model.geom('geom1').feature('wp1').geom.feature('r1').set('base', 'center');
model.geom('geom1').feature('wp1').geom.feature('r1').set('pos', {'-(Ri*sin(alpha/2)+0.1)' '0'});
model.geom('geom1').feature('wp1').geom.feature('r1').setIndex('pos', 'hs/2', 1);
model.geom('geom1').feature('wp1').geom.feature.duplicate('r2', 'r1');
model.geom('geom1').feature('wp1').geom.feature('r2').set('pos', {'Ri*sin(alpha/2)+0.1' 'hs/2'});
model.geom('geom1').feature('wp1').geom.feature('r2').setIndex('pos', '-hs/2', 1);
model.geom('geom1').feature('wp1').geom.run('r2');
model.geom('geom1').feature('wp1').geom.create('boxsel1', 'BoxSelection');
model.geom('geom1').feature('wp1').geom.feature('boxsel1').set('entitydim', 1);
model.geom('geom1').feature('wp1').geom.feature('boxsel1').set('xmax', '-Ri*sin(alpha/2)+0.001');
model.geom('geom1').feature('wp1').geom.feature('boxsel1').set('ymax', 'hs/2-th');
model.geom('geom1').feature('wp1').geom.selection.create('csel3', 'CumulativeSelection');
model.geom('geom1').feature('wp1').geom.selection('csel3').label('Delete');
model.geom('geom1').feature('wp1').geom.feature('boxsel1').set('contributeto', 'csel3');
model.geom('geom1').feature('wp1').geom.run('boxsel1');
model.geom('geom1').feature('wp1').geom.create('boxsel2', 'BoxSelection');
model.geom('geom1').feature('wp1').geom.feature('boxsel2').set('entitydim', 1);
model.geom('geom1').feature('wp1').geom.feature('boxsel2').set('xmin', 'Ri*sin(alpha/2)-0.001');
model.geom('geom1').feature('wp1').geom.feature('boxsel2').set('ymin', '-(hs/2-th)');
model.geom('geom1').feature('wp1').geom.feature('boxsel2').set('contributeto', 'csel3');
model.geom('geom1').feature('wp1').geom.run('boxsel2');
model.geom('geom1').feature('wp1').geom.create('disksel1', 'DiskSelection');
model.geom('geom1').feature('wp1').geom.feature('disksel1').set('entitydim', 1);
model.geom('geom1').feature('wp1').geom.feature('disksel1').set('inputent', 'selections');
model.geom('geom1').feature('wp1').geom.feature('disksel1').set('input', {'c1' 'c3'});
model.geom('geom1').feature('wp1').geom.feature('disksel1').set('posx', '-Ri*sin(alpha/2)');
model.geom('geom1').feature('wp1').geom.feature('disksel1').set('posy', 'hs/2-radius');
model.geom('geom1').feature('wp1').geom.feature('disksel1').set('r', 'radius+th');
model.geom('geom1').feature('wp1').geom.feature('disksel1').set('rin', '1e-2');
model.geom('geom1').feature('wp1').geom.feature('disksel1').set('angle1', -15);
model.geom('geom1').feature('wp1').geom.feature('disksel1').set('angle2', 15);
model.geom('geom1').feature('wp1').geom.feature('disksel1').set('condition', 'inside');
model.geom('geom1').feature('wp1').geom.feature('disksel1').set('selkeep', false);
model.geom('geom1').feature('wp1').geom.feature('disksel1').set('contributeto', 'csel3');
model.geom('geom1').feature('wp1').geom.feature.duplicate('disksel2', 'disksel1');
model.geom('geom1').feature('wp1').geom.runPre('disksel2');
model.geom('geom1').feature('wp1').geom.feature('disksel2').set('input', {'c2' 'c4'});
model.geom('geom1').feature('wp1').geom.feature('disksel2').set('posx', 'Ri*sin(alpha/2)');
model.geom('geom1').feature('wp1').geom.feature('disksel2').set('posy', '-(hs/2-radius)');
model.geom('geom1').feature('wp1').geom.feature('disksel2').set('angle1', 165);
model.geom('geom1').feature('wp1').geom.feature('disksel2').set('angle2', 195);
model.geom('geom1').feature('wp1').geom.run('disksel2');
model.geom('geom1').feature('wp1').geom.create('boxsel3', 'BoxSelection');
model.geom('geom1').feature('wp1').geom.feature('boxsel3').set('entitydim', 1);
model.geom('geom1').feature('wp1').geom.feature('boxsel3').set('xmin', '-Ri*sin(alpha/2)-0.01');
model.geom('geom1').feature('wp1').geom.feature('boxsel3').set('xmax', '-Ri*sin(alpha/2)+0.01');
model.geom('geom1').feature('wp1').geom.feature('boxsel3').set('condition', 'inside');
model.geom('geom1').feature('wp1').geom.feature('boxsel3').set('contributeto', 'csel3');
model.geom('geom1').feature('wp1').geom.feature('boxsel3').set('selkeep', false);
model.geom('geom1').feature('wp1').geom.feature.duplicate('boxsel4', 'boxsel3');
model.geom('geom1').feature('wp1').geom.feature('boxsel4').set('xmin', 'Ri*sin(alpha/2)-0.01');
model.geom('geom1').feature('wp1').geom.feature('boxsel4').set('xmax', 'Ri*sin(alpha/2)+0.01');
model.geom('geom1').feature('wp1').geom.run('boxsel4');
model.geom('geom1').feature('wp1').geom.create('del1', 'Delete');
model.geom('geom1').feature('wp1').geom.feature('del1').selection('input').named('csel3');
model.geom('geom1').feature('wp1').geom.run('del1');
model.geom('geom1').feature('wp1').geom.create('csol1', 'ConvertToSolid');
model.geom('geom1').feature('wp1').geom.feature('csol1').selection('input').set({'del1' 'ls1' 'ls2'});
model.geom('geom1').feature('wp1').geom.run('csol1');
model.geom('geom1').run('wp1');
model.geom('geom1').feature.create('ext1', 'Extrude');
model.geom('geom1').feature('ext1').setIndex('distance', 'Ro*1.1', 0);
model.geom('geom1').run('ext1');
model.geom('geom1').create('rot1', 'Rotate');
model.geom('geom1').feature('rot1').selection('input').set({'ext1'});
model.geom('geom1').feature('rot1').set('rot', 'alpha/2');
model.geom('geom1').run('rot1');
model.geom('geom1').create('wp2', 'WorkPlane');
model.geom('geom1').feature('wp2').set('unite', true);
model.geom('geom1').feature('wp2').set('quickplane', 'xz');
model.geom('geom1').feature('wp2').geom.create('r1', 'Rectangle');
model.geom('geom1').feature('wp2').geom.feature('r1').set('size', {'wr' 'hs*1.1'});
model.geom('geom1').feature('wp2').geom.feature('r1').set('base', 'center');
model.geom('geom1').feature('wp2').geom.feature('r1').set('pos', {'(Ri+Ro)/2' '0'});
model.geom('geom1').feature('wp2').geom.run('r1');
model.geom('geom1').run('wp2');
model.geom('geom1').feature.create('rev1', 'Revolve');
model.geom('geom1').feature('rev1').set('angtype', 'specang');
model.geom('geom1').feature('rev1').set('angle2', 'alpha');
model.geom('geom1').run('rev1');
model.geom('geom1').create('int1', 'Intersection');
model.geom('geom1').feature('int1').selection('input').set({'rev1' 'rot1'});
model.geom('geom1').run('fin');
model.geom('geom1').create('ige1', 'IgnoreEdges');
model.geom('geom1').feature('ige1').selection('input').set('fin', [4 7 19 21]);

model.view('view1').set('renderwireframe', false);

model.geom('geom1').run('ige1');

model.title([]);

model.description('');

model.label('sma_stent_geom_sequence.mph');

model.modelNode.label('Components');

out = model;
