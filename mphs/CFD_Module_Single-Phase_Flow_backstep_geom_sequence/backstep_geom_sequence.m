function out = model
%
% backstep_geom_sequence.m
%
% Model exported on May 26 2025, 21:26 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/CFD_Module/Single-Phase_Flow');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 3);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.param.set('l_in', '1.5[cm]');
model.param.descr('l_in', 'Inlet length');
model.param.set('l_out', '3[cm]');
model.param.descr('l_out', 'Outlet length');
model.param.set('r_in', '0.25[cm]');
model.param.descr('r_in', 'Inlet radius');
model.param.set('w_out', '1[cm]');
model.param.descr('w_out', 'Outlet width');

model.geom('geom1').create('cyl1', 'Cylinder');
model.geom('geom1').feature('cyl1').set('r', 'r_in');
model.geom('geom1').feature('cyl1').set('h', 'l_in');
model.geom('geom1').feature('cyl1').set('axistype', 'cartesian');
model.geom('geom1').feature('cyl1').set('ax3', [1 0 0]);
model.geom('geom1').run('cyl1');
model.geom('geom1').create('blk1', 'Block');
model.geom('geom1').feature('blk1').set('size', {'l_out' 'w_out' 'w_out'});
model.geom('geom1').feature('blk1').set('pos', {'l_in' '-w_out/2' '0'});
model.geom('geom1').feature('blk1').setIndex('pos', '-w_out/2', 2);
model.geom('geom1').run('blk1');
model.geom('geom1').create('uni1', 'Union');
model.geom('geom1').feature('uni1').selection('input').set({'blk1' 'cyl1'});
model.geom('geom1').feature('uni1').set('intbnd', false);
model.geom('geom1').run('uni1');
model.geom('geom1').create('wp1', 'WorkPlane');
model.geom('geom1').feature('wp1').set('unite', true);
model.geom('geom1').feature('wp1').set('quickplane', 'yz');
model.geom('geom1').feature('wp1').set('showintersection', false);
model.geom('geom1').feature('wp1').set('showcoincident', false);
model.geom('geom1').feature('wp1').geom.create('pol1', 'Polygon');
model.geom('geom1').feature('wp1').geom.feature('pol1').set('source', 'vectors');
model.geom('geom1').feature('wp1').geom.feature('pol1').set('x', '0 0 w_out/2');
model.geom('geom1').feature('wp1').geom.feature('pol1').set('y', '0  w_out/2  w_out/2');
model.geom('geom1').feature('wp1').geom.run('pol1');
model.geom('geom1').run('wp1');
model.geom('geom1').feature.create('ext1', 'Extrude');
model.geom('geom1').feature('ext1').set('workplane', 'wp1');
model.geom('geom1').feature('ext1').selection('input').set({'wp1'});
model.geom('geom1').feature('ext1').setIndex('distance', 'l_in+l_out', 0);
model.geom('geom1').run('ext1');
model.geom('geom1').create('int1', 'Intersection');
model.geom('geom1').feature('int1').selection('input').set({'ext1' 'uni1'});
model.geom('geom1').run('int1');
model.geom('geom1').run('fin');

model.title([]);

model.description('');

model.label('backstep_geom_sequence.mph');

model.modelNode.label('Components');

out = model;
