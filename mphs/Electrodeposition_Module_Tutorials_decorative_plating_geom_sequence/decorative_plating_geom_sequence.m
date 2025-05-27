function out = model
%
% decorative_plating_geom_sequence.m
%
% Model exported on May 26 2025, 21:28 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/Electrodeposition_Module/Tutorials');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 3);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.view('view1').set('renderwireframe', true);

model.geom('geom1').lengthUnit('mm');
model.geom('geom1').create('blk1', 'Block');
model.geom('geom1').feature('blk1').set('size', [100 28 7.25]);
model.geom('geom1').feature('blk1').set('pos', [-70 -10 -1.25]);
model.geom('geom1').feature('blk1').set('selresult', true);
model.geom('geom1').run('blk1');
model.geom('geom1').create('cyl1', 'Cylinder');
model.geom('geom1').feature('cyl1').set('r', 1.25);
model.geom('geom1').feature('cyl1').set('h', 10);
model.geom('geom1').feature('cyl1').set('pos', [-48 8 -1.25]);
model.geom('geom1').feature('cyl1').set('axistype', 'y');
model.geom('geom1').selection.create('csel1', 'CumulativeSelection');
model.geom('geom1').selection('csel1').label('Objects to subtract');
model.geom('geom1').feature('cyl1').set('contributeto', 'csel1');
model.geom('geom1').run('cyl1');
model.geom('geom1').create('wp1', 'WorkPlane');
model.geom('geom1').feature('wp1').set('unite', true);
model.geom('geom1').feature('wp1').set('quickplane', 'zx');
model.geom('geom1').feature('wp1').set('quicky', 8);
model.geom('geom1').feature('wp1').geom.create('r1', 'Rectangle');
model.geom('geom1').feature('wp1').geom.feature('r1').set('size', [2.5 10]);
model.geom('geom1').feature('wp1').geom.feature('r1').set('pos', [-1.25 -53]);
model.geom('geom1').feature('wp1').geom.run('r1');
model.geom('geom1').feature('wp1').geom.create('fil1', 'Fillet');
model.geom('geom1').feature('wp1').geom.feature('fil1').selection('pointinsketch').set('r1', [2 3]);
model.geom('geom1').feature('wp1').geom.feature('fil1').set('radius', 1);
model.geom('geom1').feature('wp1').geom.run('fil1');
model.geom('geom1').run('wp1');
model.geom('geom1').feature.create('rev1', 'Revolve');
model.geom('geom1').feature('rev1').set('workplane', 'wp1');
model.geom('geom1').feature('rev1').selection('input').set({'wp1'});
model.geom('geom1').feature('rev1').set('angtype', 'full');
model.geom('geom1').feature('rev1').set('origfaces', false);
model.geom('geom1').feature('rev1').set('angtype', 'specang');
model.geom('geom1').feature('rev1').set('angle2', 90);
model.geom('geom1').feature('rev1').set('axistype', '3d');
model.geom('geom1').feature('rev1').set('pos3', [-40 8 -1.25]);
model.geom('geom1').feature('rev1').set('axis3', [0 0 1]);
model.geom('geom1').feature('rev1').set('contributeto', 'csel1');
model.geom('geom1').run('rev1');
model.geom('geom1').feature.create('ext1', 'Extrude');
model.geom('geom1').feature('ext1').set('workplane', 'wp1');
model.geom('geom1').feature('ext1').selection('input').set({});
model.geom('geom1').feature('ext1').selection('input').named('csel1');
model.geom('geom1').feature('ext1').set('extrudefrom', 'faces');
model.geom('geom1').feature('ext1').selection('inputface').named('csel1');
model.geom('geom1').feature('ext1').selection('inputface').clear('cyl1');
model.geom('geom1').feature('ext1').selection('inputface').set('rev1', 8);
model.geom('geom1').feature('ext1').setIndex('distance', 20, 0);
model.geom('geom1').feature('ext1').set('contributeto', 'csel1');
model.geom('geom1').run('ext1');
model.geom('geom1').create('mir1', 'Mirror');
model.geom('geom1').feature('mir1').selection('input').named('csel1');
model.geom('geom1').feature('mir1').set('keep', true);
model.geom('geom1').feature('mir1').set('pos', [-20 0 0]);
model.geom('geom1').feature('mir1').set('axis', [1 0 0]);
model.geom('geom1').feature('mir1').set('contributeto', 'csel1');
model.geom('geom1').run('mir1');
model.geom('geom1').create('dif1', 'Difference');
model.geom('geom1').feature('dif1').selection('input').named('blk1');
model.geom('geom1').feature('dif1').selection('input2').named('csel1');
model.geom('geom1').run('dif1');
model.geom('geom1').create('boxsel1', 'BoxSelection');
model.geom('geom1').feature('boxsel1').label('Cathode');
model.geom('geom1').feature('boxsel1').set('entitydim', 2);
model.geom('geom1').feature('boxsel1').set('xmin', -55);
model.geom('geom1').feature('boxsel1').set('xmax', 15);
model.geom('geom1').feature('boxsel1').set('ymin', -8);
model.geom('geom1').feature('boxsel1').set('ymax', 15);
model.geom('geom1').feature('boxsel1').set('zmin', 0);
model.geom('geom1').feature('boxsel1').set('zmax', 4);

model.title([]);

model.description('');

model.label('decorative_plating_geom_sequence.mph');

model.modelNode.label('Components');

out = model;
