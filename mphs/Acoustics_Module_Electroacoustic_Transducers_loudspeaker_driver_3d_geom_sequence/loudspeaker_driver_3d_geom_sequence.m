function out = model
%
% loudspeaker_driver_3d_geom_sequence.m
%
% Model exported on May 26 2025, 21:25 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/Acoustics_Module/Electroacoustic_Transducers');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 3);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.geom('geom1').lengthUnit('mm');
model.geom('geom1').geomRep('cadps');
model.geom('geom1').create('wp1', 'WorkPlane');
model.geom('geom1').feature('wp1').set('unite', true);
model.geom('geom1').feature('wp1').set('quickplane', 'xz');
model.geom('geom1').feature('wp1').geom.create('imp1', 'Import');
model.geom('geom1').feature('wp1').geom.feature('imp1').set('filename', 'loudspeaker_driver_2d.mphtxt');
model.geom('geom1').feature('wp1').geom.feature('imp1').importData;
model.geom('geom1').feature('wp1').geom.run('imp1');
model.geom('geom1').feature('wp1').geom.create('pol1', 'Polygon');
model.geom('geom1').feature('wp1').geom.feature('pol1').set('source', 'table');
model.geom('geom1').feature('wp1').geom.feature('pol1').set('table', [22.5 -52; 45 -52; 52.5 -48.5; 58 -48.5; 61 -45; 68 -45; 80 -2; 89 -2; 89 3.5; 88 3.5; 88 -1; 79.5 -1; 67.5 -44.5; 60.5 -44.5; 57.5 -48; 52.5 -48; 45 -51.5; 22.5 -51.5; 22.5 -52]);
model.geom('geom1').feature('wp1').geom.run('pol1');
model.geom('geom1').feature('wp1').geom.create('fil1', 'Fillet');
model.geom('geom1').feature('wp1').geom.feature('fil1').selection('pointinsketch').set('pol1', [6 7 8 11 12 13]);
model.geom('geom1').feature('wp1').geom.feature('fil1').set('radius', 0.5);
model.geom('geom1').feature('wp1').geom.run('fil1');
model.geom('geom1').feature('wp1').geom.create('fil2', 'Fillet');
model.geom('geom1').feature('wp1').geom.feature('fil2').selection('pointinsketch').set('fil1', [5 6]);
model.geom('geom1').feature('wp1').geom.feature('fil2').set('radius', 2);
model.geom('geom1').feature('wp1').geom.run('fil2');
model.geom('geom1').feature('wp1').geom.create('fil3', 'Fillet');
model.geom('geom1').feature('wp1').geom.feature('fil3').selection('pointinsketch').set('fil2', [9 10]);
model.geom('geom1').feature('wp1').geom.feature('fil3').set('radius', 1);
model.geom('geom1').feature('wp1').geom.run('fil3');
model.geom('geom1').feature('wp1').geom.create('pare1', 'PartitionEdges');
model.geom('geom1').feature('wp1').geom.feature('pare1').selection('edge').set('fil3', 13);
model.geom('geom1').feature('wp1').geom.feature('pare1').setIndex('param', 0.2, 0);
model.geom('geom1').feature('wp1').geom.feature('pare1').setIndex('param', 0.5, 1);
model.geom('geom1').feature('wp1').geom.feature('pare1').setIndex('param', 0.8, 2);
model.geom('geom1').feature('wp1').geom.run('pare1');
model.geom('geom1').feature('wp1').geom.create('ls1', 'LineSegment');
model.geom('geom1').feature('wp1').geom.feature('ls1').selection('vertex1').set('pare1', 25);
model.geom('geom1').feature('wp1').geom.feature('ls1').selection('vertex2').set('pare1', 23);
model.geom('geom1').feature('wp1').geom.run('ls1');
model.geom('geom1').feature('wp1').geom.create('ls2', 'LineSegment');
model.geom('geom1').feature('wp1').geom.feature('ls2').selection('vertex1').set('pare1', 13);
model.geom('geom1').feature('wp1').geom.feature('ls2').selection('vertex2').set('pare1', 14);
model.geom('geom1').run('wp1');
model.geom('geom1').feature.create('rev1', 'Revolve');
model.geom('geom1').feature('rev1').set('angtype', 'specang');
model.geom('geom1').feature('rev1').set('angle2', 90);
model.geom('geom1').run('rev1');
model.geom('geom1').create('del1', 'Delete');
model.geom('geom1').feature('del1').selection('input').init(3);
model.geom('geom1').feature('del1').selection('input').set('rev1', [1 5]);
model.geom('geom1').run('del1');
model.geom('geom1').create('cap1', 'CapFaces');
model.geom('geom1').feature('cap1').selection('input').set('del1', [217 218 220 222 224 227 362 363 364 365 366 368]);
model.geom('geom1').run('cap1');
model.geom('geom1').create('pare1', 'PartitionEdges');
model.geom('geom1').feature('pare1').selection('edge').set('cap1', [199 201 207]);
model.geom('geom1').feature('pare1').setIndex('param', 0.1, 0);
model.geom('geom1').feature('pare1').setIndex('param', 0.3, 1);
model.geom('geom1').feature('pare1').setIndex('param', 0.7, 2);
model.geom('geom1').feature('pare1').setIndex('param', 0.9, 3);
model.geom('geom1').run('pare1');
model.geom('geom1').create('ls1', 'LineSegment');

model.view('view1').set('renderwireframe', true);

model.geom('geom1').feature('ls1').selection('vertex1').set('pare1', 199);
model.geom('geom1').feature('ls1').selection('vertex2').set('pare1', 201);
model.geom('geom1').run('ls1');
model.geom('geom1').create('ls2', 'LineSegment');
model.geom('geom1').feature('ls2').selection('vertex1').set('pare1', 188);
model.geom('geom1').feature('ls2').selection('vertex2').set('pare1', 198);
model.geom('geom1').run('ls2');
model.geom('geom1').create('ls3', 'LineSegment');
model.geom('geom1').feature('ls3').selection('vertex1').set('pare1', 111);
model.geom('geom1').feature('ls3').selection('vertex2').set('pare1', 112);
model.geom('geom1').run('ls3');
model.geom('geom1').create('ls4', 'LineSegment');
model.geom('geom1').feature('ls4').selection('vertex1').set('pare1', 154);
model.geom('geom1').feature('ls4').selection('vertex2').set('pare1', 158);
model.geom('geom1').run('ls4');
model.geom('geom1').create('uni1', 'Union');
model.geom('geom1').feature('uni1').selection('input').set({'ls1' 'ls2' 'ls3' 'ls4' 'pare1'});
model.geom('geom1').run('uni1');
model.geom('geom1').create('extract1', 'Extract');
model.geom('geom1').feature('extract1').selection('input').set('uni1', [141 171 196 197]);
model.geom('geom1').run('extract1');
model.geom('geom1').create('thi1', 'Thicken');
model.geom('geom1').feature('thi1').selection('input').set({'extract1'});
model.geom('geom1').feature('thi1').set('offset', 'asymmetric');
model.geom('geom1').feature('thi1').set('downthick', 2);
model.geom('geom1').run('thi1');
model.geom('geom1').create('fil1', 'Fillet3D');
model.geom('geom1').feature('fil1').selection('edge').set('thi1', [9 14 20 26 27 37 39 44]);
model.geom('geom1').feature('fil1').set('radius', 1);
model.geom('geom1').run('fil1');
model.geom('geom1').create('cyl1', 'Cylinder');
model.geom('geom1').feature('cyl1').set('r', 1.5);
model.geom('geom1').feature('cyl1').set('h', 3);
model.geom('geom1').feature('cyl1').set('pos', [0 18 -48]);
model.geom('geom1').feature('cyl1').set('axistype', 'y');
model.geom('geom1').run('cyl1');
model.geom('geom1').create('int1', 'Intersection');
model.geom('geom1').feature('int1').selection('input').set({'cyl1' 'uni1'});
model.geom('geom1').feature('int1').set('keep', true);
model.geom('geom1').run('int1');
model.geom('geom1').create('del2', 'Delete');
model.geom('geom1').feature('del2').selection('input').init(3);
model.geom('geom1').feature('del2').selection('input').set('cyl1', 1);
model.geom('geom1').run('fin');
model.geom('geom1').create('cmd1', 'CompositeDomains');
model.geom('geom1').feature('cmd1').selection('input').set('fin', [1 7 20 21 23 31 37]);
model.geom('geom1').run('cmd1');
model.geom('geom1').create('cmf1', 'CompositeFaces');
model.geom('geom1').feature('cmf1').selection('input').set('cmd1', [145 146 155 186 212 214 216 218 224 231 234 235]);
model.geom('geom1').run('cmf1');
model.geom('geom1').create('cmf2', 'CompositeFaces');
model.geom('geom1').feature('cmf2').selection('input').set('cmf1', [149 181 184 217 219 227]);
model.geom('geom1').run('cmf2');
model.geom('geom1').create('cmd2', 'CompositeDomains');
model.geom('geom1').feature('cmd2').selection('input').set('cmf2', [30 32 33]);

model.title([]);

model.description('');

model.label('loudspeaker_driver_3d_geom_sequence.mph');

model.modelNode.label('Components');

out = model;
