function out = model
%
% steam_reformer_geometry.m
%
% Model exported on May 26 2025, 21:26 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/COMSOL_Multiphysics/Geometry_Tutorials');

model.param.set('L', '0.15[m]');
model.param.descr('L', 'Bed length');
model.param.set('jr', '33[mm]');
model.param.descr('jr', 'Jacket radius');
model.param.set('br', '30[mm]');
model.param.descr('br', 'Bed radius');
model.param.set('tr', '4[mm]');
model.param.descr('tr', 'Tube radius');
model.param.set('nt', '8');
model.param.descr('nt', 'Number of tubes, must be a multiple of four');
model.param.set('pt', '20[mm]');
model.param.descr('pt', 'Distance of tube center from origin');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 3);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.geom('geom1').create('wp1', 'WorkPlane');
model.geom('geom1').feature('wp1').set('unite', true);
model.geom('geom1').feature('wp1').set('quickplane', 'yz');
model.geom('geom1').feature('wp1').geom.create('c1', 'Circle');
model.geom('geom1').feature('wp1').geom.feature('c1').set('r', 'jr');
model.geom('geom1').feature('wp1').geom.feature('c1').set('angle', 90);
model.geom('geom1').feature('wp1').geom.feature('c1').setIndex('layername', 'Layer 1', 0);
model.geom('geom1').feature('wp1').geom.feature('c1').setIndex('layer', 'jr-br', 0);
model.geom('geom1').feature('wp1').geom.run('c1');
model.geom('geom1').feature('wp1').geom.create('c2', 'Circle');
model.geom('geom1').feature('wp1').geom.feature('c2').label('Tubes Outlet');
model.geom('geom1').feature('wp1').geom.feature('c2').set('r', 'tr');
model.geom('geom1').feature('wp1').geom.feature('c2').set('pos', {'0' 'pt'});
model.geom('geom1').feature('wp1').geom.feature('c2').set('selresult', true);
model.geom('geom1').feature('wp1').geom.feature('c2').set('selresultshow', 'all');
model.geom('geom1').feature('wp1').geom.run('c2');
model.geom('geom1').feature('wp1').geom.create('rot1', 'Rotate');
model.geom('geom1').feature('wp1').geom.feature('rot1').selection('input').named('c2');
model.geom('geom1').feature('wp1').geom.feature('rot1').set('rot', '-range(0,360/nt,360/4)');
model.geom('geom1').feature('wp1').geom.run('rot1');
model.geom('geom1').feature('wp1').geom.create('uni1', 'Union');
model.geom('geom1').feature('wp1').geom.feature('uni1').selection('input').named('c2');
model.geom('geom1').feature('wp1').geom.run('uni1');
model.geom('geom1').feature('wp1').geom.create('co1', 'Compose');
model.geom('geom1').feature('wp1').geom.feature('co1').selection('input').set({'c1' 'uni1'});
model.geom('geom1').feature('wp1').geom.feature('co1').set('formula', 'c1+c1*uni1');
model.geom('geom1').feature('wp1').geom.run('co1');

model.param.set('nt', '12');
model.param.descr('nt', 'Number of tubes, must be a multiple of four');

model.geom('geom1').feature('wp1').geom.run('co1');

model.param.set('nt', '8');
model.param.descr('nt', 'Number of tubes, must be a multiple of four');

model.geom('geom1').feature('wp1').geom.run('co1');
model.geom('geom1').feature('wp1').geom.create('adjsel1', 'AdjacentSelection');
model.geom('geom1').feature('wp1').geom.feature('adjsel1').label('Bed Inlet');
model.geom('geom1').feature('wp1').geom.feature('adjsel1').set('input', {'c2'});
model.geom('geom1').feature('wp1').geom.feature('adjsel1').set('outputdim', 2);
model.geom('geom1').feature('wp1').geom.run('adjsel1');
model.geom('geom1').feature('wp1').set('unite', false);
model.geom('geom1').feature('wp1').set('selplaneshow', true);
model.geom('geom1').run('wp1');
model.geom('geom1').feature.create('ext1', 'Extrude');
model.geom('geom1').feature('ext1').set('workplane', 'wp1');
model.geom('geom1').feature('ext1').selection('input').set({'wp1'});
model.geom('geom1').feature('ext1').label('Jacket');
model.geom('geom1').feature('ext1').set('extrudefrom', 'faces');
model.geom('geom1').feature('ext1').selection('inputface').set('wp1', 3);
model.geom('geom1').feature('ext1').set('inputhandling', 'keep');
model.geom('geom1').feature('ext1').setIndex('distance', 'L', 0);
model.geom('geom1').feature('ext1').set('selresult', true);
model.geom('geom1').feature('ext1').set('selresultshow', 'all');
model.geom('geom1').run('ext1');
model.geom('geom1').feature.create('ext2', 'Extrude');
model.geom('geom1').feature('ext2').label('Catalytic Bed');
model.geom('geom1').feature('ext2').set('extrudefrom', 'faces');
model.geom('geom1').feature('ext2').selection('inputface').named('wp1_adjsel1');
model.geom('geom1').feature('ext2').set('inputhandling', 'keep');
model.geom('geom1').feature('ext2').setIndex('distance', 'L', 0);
model.geom('geom1').feature('ext2').set('selresult', true);
model.geom('geom1').feature('ext2').set('selresultshow', 'all');
model.geom('geom1').run('ext2');
model.geom('geom1').feature.create('ext3', 'Extrude');
model.geom('geom1').feature('ext3').label('Heating Tubes');
model.geom('geom1').feature('ext3').set('extrudefrom', 'faces');
model.geom('geom1').feature('ext3').selection('inputface').named('wp1_c2');
model.geom('geom1').feature('ext3').set('inputhandling', 'keep');
model.geom('geom1').feature('ext3').setIndex('distance', 'L', 0);
model.geom('geom1').feature('ext3').set('selresult', true);
model.geom('geom1').feature('ext3').set('selresultshow', 'all');
model.geom('geom1').run('ext3');
model.geom('geom1').run('fin');

model.view('view1').set('renderwireframe', true);

model.geom('geom1').create('intsel1', 'IntersectionSelection');
model.geom('geom1').feature('intsel1').label('Bed/Jacket');
model.geom('geom1').feature('intsel1').set('entitydim', 2);
model.geom('geom1').feature('intsel1').set('input', {'ext1' 'ext2'});
model.geom('geom1').feature.createAfter('intsel2', 'IntersectionSelection', 'intsel1');
model.geom('geom1').feature('intsel2').set('entitydim', 2);
model.geom('geom1').feature('intsel2').label('Tubes/Bed');
model.geom('geom1').feature('intsel2').set('input', {'ext2.bnd' 'ext3.bnd'});
model.geom('geom1').run('intsel2');
model.geom('geom1').create('cylsel1', 'CylinderSelection');
model.geom('geom1').feature('cylsel1').set('entitydim', 2);
model.geom('geom1').feature('cylsel1').set('r', 'inf');
model.geom('geom1').feature('cylsel1').set('angle1', 180);
model.geom('geom1').feature('cylsel1').set('angle2', 90);
model.geom('geom1').feature('cylsel1').set('axistype', 'x');
model.geom('geom1').feature('cylsel1').set('condition', 'inside');
model.geom('geom1').feature('cylsel1').set('selshow', false);
model.geom('geom1').feature.createAfter('intsel3', 'IntersectionSelection', 'cylsel1');
model.geom('geom1').feature('intsel3').set('entitydim', 2);
model.geom('geom1').feature('intsel3').label('Jacket Symmetry');
model.geom('geom1').feature('intsel3').set('input', {'cylsel1' 'ext1.bnd'});
model.geom('geom1').run('intsel3');
model.geom('geom1').feature.createAfter('intsel4', 'IntersectionSelection', 'intsel3');
model.geom('geom1').feature('intsel4').set('entitydim', 2);
model.geom('geom1').feature('intsel4').label('Tubes Symmetry');
model.geom('geom1').feature('intsel4').set('input', {'cylsel1' 'ext3.bnd'});
model.geom('geom1').run('intsel4');
model.geom('geom1').feature.createAfter('intsel5', 'IntersectionSelection', 'intsel4');
model.geom('geom1').feature('intsel5').set('entitydim', 2);
model.geom('geom1').feature('intsel5').label('Bed Symmetry');
model.geom('geom1').feature('intsel5').set('input', {'ext2.bnd' 'cylsel1'});
model.geom('geom1').run('intsel5');
model.geom('geom1').create('difsel1', 'DifferenceSelection');
model.geom('geom1').feature('difsel1').label('Inlets and Outlets');
model.geom('geom1').feature('difsel1').set('entitydim', 2);
model.geom('geom1').feature('difsel1').set('add', {'ext2' 'ext3'});
model.geom('geom1').feature('difsel1').set('subtract', {'intsel1' 'intsel2' 'intsel4' 'intsel5'});
model.geom('geom1').run('difsel1');
model.geom('geom1').create('difsel2', 'DifferenceSelection');
model.geom('geom1').feature('difsel2').label('Tubes Inlet');
model.geom('geom1').feature('difsel2').set('entitydim', 2);
model.geom('geom1').feature('difsel2').set('add', {'difsel1'});
model.geom('geom1').feature('difsel2').set('subtract', {'wp1_c2' 'ext2'});
model.geom('geom1').run('difsel2');
model.geom('geom1').create('difsel3', 'DifferenceSelection');
model.geom('geom1').feature('difsel3').label('Bed Outlet');
model.geom('geom1').feature('difsel3').set('entitydim', 2);
model.geom('geom1').feature('difsel3').set('add', {'difsel1'});
model.geom('geom1').feature('difsel3').set('subtract', {'wp1_adjsel1' 'ext3'});
model.geom('geom1').run('difsel3');
model.geom('geom1').create('sel1', 'ExplicitSelection');
model.geom('geom1').feature('sel1').selection('selection').init(2);
model.geom('geom1').feature('sel1').selection('selection').set('fin', 12);
model.geom('geom1').feature('sel1').label('Jacket/Ambient');
model.geom('geom1').run('sel1');

model.title([]);

model.description('');

model.label('steam_reformer_geometry.mph');

model.modelNode.label('Components');

out = model;
