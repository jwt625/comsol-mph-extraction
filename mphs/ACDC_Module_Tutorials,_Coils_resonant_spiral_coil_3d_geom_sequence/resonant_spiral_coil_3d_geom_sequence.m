function out = model
%
% resonant_spiral_coil_3d_geom_sequence.m
%
% Model exported on May 26 2025, 21:25 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/ACDC_Module/Tutorials,_Coils');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 3);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.geom('geom1').lengthUnit('mm');
model.geom('geom1').create('wp1', 'WorkPlane');
model.geom('geom1').feature('wp1').set('unite', true);
model.geom('geom1').feature('wp1').geom.create('pc1', 'ParametricCurve');
model.geom('geom1').feature('wp1').geom.feature('pc1').set('parmax', '2*pi');
model.geom('geom1').feature('wp1').geom.feature('pc1').set('coord', {'(5+s/(2*pi))*cos(s)' ''});
model.geom('geom1').feature('wp1').geom.feature('pc1').setIndex('coord', '(5+s/(2*pi))*sin(s)', 1);
model.geom('geom1').feature('wp1').geom.run('pc1');
model.geom('geom1').feature('wp1').geom.create('pc2', 'ParametricCurve');
model.geom('geom1').feature('wp1').geom.feature('pc2').set('parmax', '4*2*pi');
model.geom('geom1').feature('wp1').geom.feature('pc2').set('coord', {'(6+s/(2*pi))*cos(s)' ''});
model.geom('geom1').feature('wp1').geom.feature('pc2').setIndex('coord', '(6+s/(2*pi))*sin(s)', 1);
model.geom('geom1').feature('wp1').geom.run('pc2');
model.geom('geom1').feature('wp1').geom.create('pc3', 'ParametricCurve');
model.geom('geom1').feature('wp1').geom.feature('pc3').set('parmax', '2*pi');
model.geom('geom1').feature('wp1').geom.feature('pc3').set('coord', {'(10+s/(2*pi))*cos(s)' ''});
model.geom('geom1').feature('wp1').geom.feature('pc3').setIndex('coord', '(10+s/(2*pi))*sin(s)', 1);
model.geom('geom1').feature('wp1').geom.run('pc3');
model.geom('geom1').feature('wp1').geom.create('pol1', 'Polygon');
model.geom('geom1').feature('wp1').geom.feature('pol1').set('source', 'table');
model.geom('geom1').feature('wp1').geom.feature('pol1').setIndex('table', 5, 0, 0);
model.geom('geom1').feature('wp1').geom.feature('pol1').setIndex('table', 0, 0, 1);
model.geom('geom1').feature('wp1').geom.feature('pol1').setIndex('table', 6, 1, 0);
model.geom('geom1').feature('wp1').geom.feature('pol1').setIndex('table', 0, 1, 1);
model.geom('geom1').feature('wp1').geom.run('pol1');
model.geom('geom1').feature('wp1').geom.create('pol2', 'Polygon');
model.geom('geom1').feature('wp1').geom.feature('pol2').set('source', 'table');
model.geom('geom1').feature('wp1').geom.feature('pol2').setIndex('table', 10, 0, 0);
model.geom('geom1').feature('wp1').geom.feature('pol2').setIndex('table', 0, 0, 1);
model.geom('geom1').feature('wp1').geom.feature('pol2').setIndex('table', 11, 1, 0);
model.geom('geom1').feature('wp1').geom.feature('pol2').setIndex('table', 0, 1, 1);
model.geom('geom1').feature('wp1').geom.run('pol2');
model.geom('geom1').feature('wp1').geom.create('uni1', 'Union');
model.geom('geom1').feature('wp1').geom.feature('uni1').selection('input').set({'pc1' 'pc2' 'pc3' 'pol1' 'pol2'});
model.geom('geom1').feature('wp1').geom.run('uni1');
model.geom('geom1').feature('wp1').geom.create('csol1', 'ConvertToSolid');
model.geom('geom1').feature('wp1').geom.feature('csol1').selection('input').set({'uni1'});
model.geom('geom1').feature('wp1').geom.run('csol1');
model.geom('geom1').feature('wp1').geom.create('spl1', 'Split');
model.geom('geom1').feature('wp1').geom.feature('spl1').selection('input').set({'csol1'});
model.geom('geom1').feature('wp1').geom.run('spl1');
model.geom('geom1').feature('wp1').geom.create('del1', 'Delete');
model.geom('geom1').feature('wp1').geom.feature('del1').selection('input').init(2);
model.geom('geom1').feature('wp1').geom.feature('del1').selection('input').set('spl1(2)', 1);
model.geom('geom1').feature('wp1').geom.run('del1');
model.geom('geom1').run('wp1');
model.geom('geom1').feature.create('ext1', 'Extrude');
model.geom('geom1').feature('ext1').set('workplane', 'wp1');
model.geom('geom1').feature('ext1').selection('input').set({'wp1'});
model.geom('geom1').run('ext1');
model.geom('geom1').create('wp2', 'WorkPlane');
model.geom('geom1').feature('wp2').set('unite', true);
model.geom('geom1').feature('wp2').geom.create('r1', 'Rectangle');
model.geom('geom1').feature('wp2').geom.feature('r1').set('size', [50 50]);
model.geom('geom1').feature('wp2').geom.feature('r1').set('base', 'center');
model.geom('geom1').feature('wp2').geom.run('r1');
model.geom('geom1').feature('wp2').geom.create('c1', 'Circle');
model.geom('geom1').feature('wp2').geom.feature('c1').set('r', 0.3);
model.geom('geom1').feature('wp2').geom.feature('c1').set('pos', [5.45 0.45]);
model.geom('geom1').feature('wp2').geom.run('c1');
model.geom('geom1').feature('wp2').geom.create('c2', 'Circle');
model.geom('geom1').feature('wp2').geom.feature('c2').set('r', 0.3);
model.geom('geom1').feature('wp2').geom.feature('c2').set('pos', [10.45 -0.45]);
model.geom('geom1').feature('wp2').geom.run('c2');
model.geom('geom1').run('wp2');
model.geom('geom1').feature.create('ext2', 'Extrude');
model.geom('geom1').feature('ext2').set('reverse', true);
model.geom('geom1').run('ext2');
model.geom('geom1').create('wp3', 'WorkPlane');
model.geom('geom1').feature('wp3').set('unite', true);
model.geom('geom1').feature('wp3').set('quickz', -1);
model.geom('geom1').feature('wp3').geom.create('r1', 'Rectangle');
model.geom('geom1').feature('wp3').geom.feature('r1').set('size', [0.6 25.45]);
model.geom('geom1').feature('wp3').geom.feature('r1').set('pos', [10.15 -0.45]);
model.geom('geom1').feature('wp3').geom.run('r1');
model.geom('geom1').feature('wp3').geom.create('r2', 'Rectangle');
model.geom('geom1').feature('wp3').geom.feature('r2').set('size', [0.6 25.45]);
model.geom('geom1').feature('wp3').geom.feature('r2').set('pos', [5.15 -25]);
model.geom('geom1').feature('wp3').geom.run('r2');
model.geom('geom1').feature('wp3').geom.create('c1', 'Circle');
model.geom('geom1').feature('wp3').geom.feature('c1').set('r', 0.3);
model.geom('geom1').feature('wp3').geom.feature('c1').set('pos', [5.45 0.45]);
model.geom('geom1').feature('wp3').geom.run('c1');
model.geom('geom1').feature('wp3').geom.create('c2', 'Circle');
model.geom('geom1').feature('wp3').geom.feature('c2').set('r', 0.3);
model.geom('geom1').feature('wp3').geom.feature('c2').set('pos', [10.45 -0.45]);
model.geom('geom1').feature('wp3').geom.run('c2');
model.geom('geom1').feature('wp3').geom.create('uni1', 'Union');
model.geom('geom1').feature('wp3').geom.feature('uni1').selection('input').set({'c2' 'r1'});
model.geom('geom1').feature('wp3').geom.feature('uni1').set('intbnd', false);
model.geom('geom1').feature('wp3').geom.run('uni1');
model.geom('geom1').feature('wp3').geom.create('uni2', 'Union');
model.geom('geom1').feature('wp3').geom.feature('uni2').selection('input').set({'c1' 'r2'});
model.geom('geom1').feature('wp3').geom.feature('uni2').set('intbnd', false);
model.geom('geom1').feature('wp3').geom.run('uni2');
model.geom('geom1').run('wp3');
model.geom('geom1').feature.create('ext3', 'Extrude');
model.geom('geom1').feature('ext3').setIndex('distance', -0.2, 0);
model.geom('geom1').run('ext3');
model.geom('geom1').create('blk1', 'Block');
model.geom('geom1').feature('blk1').set('size', [50 50 50]);
model.geom('geom1').feature('blk1').set('base', 'center');
model.geom('geom1').run('blk1');

model.view('view1').set('renderwireframe', true);

model.title([]);

model.description('');

model.label('resonant_spiral_coil_3d_geom_sequence.mph');

model.modelNode.label('Components');

out = model;
