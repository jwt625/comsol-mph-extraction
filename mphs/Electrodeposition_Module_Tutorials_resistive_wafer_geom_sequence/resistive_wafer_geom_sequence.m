function out = model
%
% resistive_wafer_geom_sequence.m
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

model.geom('geom1').lengthUnit('mm');
model.geom('geom1').create('cyl1', 'Cylinder');
model.geom('geom1').feature('cyl1').set('r', 60);
model.geom('geom1').feature('cyl1').set('h', 2);
model.geom('geom1').run('cyl1');
model.geom('geom1').create('cyl2', 'Cylinder');
model.geom('geom1').feature('cyl2').set('r', 48);
model.geom('geom1').feature('cyl2').set('h', 8.808);
model.geom('geom1').feature('cyl2').set('pos', [0 0 2]);
model.geom('geom1').run('cyl2');
model.geom('geom1').create('cone1', 'Cone');
model.geom('geom1').feature('cone1').set('specifytop', 'radius');
model.geom('geom1').feature('cone1').set('r', 48);
model.geom('geom1').feature('cone1').set('h', 9.192);
model.geom('geom1').feature('cone1').set('rtop', 92);
model.geom('geom1').feature('cone1').set('pos', [0 0 10.808]);
model.geom('geom1').run('cone1');
model.geom('geom1').create('cyl3', 'Cylinder');
model.geom('geom1').feature('cyl3').set('r', 92);
model.geom('geom1').feature('cyl3').set('h', 20);
model.geom('geom1').feature('cyl3').set('pos', [0 0 20]);
model.geom('geom1').run('cyl3');
model.geom('geom1').create('wp1', 'WorkPlane');
model.geom('geom1').feature('wp1').set('unite', true);
model.geom('geom1').feature('wp1').label('Wafer surface');
model.geom('geom1').feature('wp1').set('selresult', true);
model.geom('geom1').feature('wp1').geom.create('c1', 'Circle');
model.geom('geom1').feature('wp1').geom.feature('c1').set('r', 45);
model.geom('geom1').feature('wp1').geom.run('c1');
model.geom('geom1').feature('wp1').geom.create('r1', 'Rectangle');
model.geom('geom1').feature('wp1').geom.feature('r1').set('size', [7.844 1]);
model.geom('geom1').feature('wp1').geom.feature('r1').set('type', 'curve');
model.geom('geom1').feature('wp1').geom.feature('r1').set('pos', [0 45]);
model.geom('geom1').feature('wp1').geom.feature('r1').set('base', 'center');
model.geom('geom1').feature('wp1').geom.run('r1');
model.geom('geom1').feature('wp1').geom.create('pare1', 'PartitionEdges');
model.geom('geom1').feature('wp1').geom.feature('pare1').selection('edge').set('c1', [3 4]);
model.geom('geom1').feature('wp1').geom.feature('pare1').set('position', 'projection');
model.geom('geom1').feature('wp1').geom.feature('pare1').selection('vertexproj').set('r1', [3 4]);
model.geom('geom1').feature('wp1').geom.run('pare1');
model.geom('geom1').feature('wp1').geom.feature.create('del1', 'Delete');
model.geom('geom1').feature('wp1').geom.feature('del1').selection('input').init(0);
model.geom('geom1').feature('wp1').geom.feature('del1').selection('input').init;
model.geom('geom1').feature('wp1').geom.feature('del1').selection('input').set({'r1'});
model.geom('geom1').feature('wp1').geom.run('del1');
model.geom('geom1').feature('wp1').geom.create('c2', 'Circle');
model.geom('geom1').feature('wp1').geom.feature('c2').set('r', 41);
model.geom('geom1').feature('wp1').geom.run('c2');
model.geom('geom1').feature('wp1').geom.create('r2', 'Rectangle');
model.geom('geom1').feature('wp1').geom.feature('r2').set('size', [6.8 20.4]);
model.geom('geom1').feature('wp1').geom.feature('r2').set('pos', [-36.04 -10.2]);
model.geom('geom1').feature('wp1').geom.selection.create('csel1', 'CumulativeSelection');
model.geom('geom1').feature('wp1').geom.selection('csel1').label('Wafer');
model.geom('geom1').feature('wp1').geom.feature('r2').set('contributeto', 'csel1');
model.geom('geom1').feature('wp1').geom.run('r2');
model.geom('geom1').feature('wp1').geom.create('r3', 'Rectangle');
model.geom('geom1').feature('wp1').geom.feature('r3').set('size', [54.4 40.8]);
model.geom('geom1').feature('wp1').geom.feature('r3').set('pos', [-29.24 -17]);
model.geom('geom1').feature('wp1').geom.feature('r3').set('contributeto', 'csel1');
model.geom('geom1').feature('wp1').geom.run('r3');
model.geom('geom1').feature('wp1').geom.create('r4', 'Rectangle');
model.geom('geom1').feature('wp1').geom.feature('r4').set('size', [40.8 6.8]);
model.geom('geom1').feature('wp1').geom.feature('r4').set('pos', [-22.44 23.8]);
model.geom('geom1').feature('wp1').geom.feature('r4').set('contributeto', 'csel1');
model.geom('geom1').feature('wp1').geom.run('r4');
model.geom('geom1').feature('wp1').geom.create('r5', 'Rectangle');
model.geom('geom1').feature('wp1').geom.feature('r5').set('size', [6.8 34]);
model.geom('geom1').feature('wp1').geom.feature('r5').set('pos', [25.16 -17]);
model.geom('geom1').feature('wp1').geom.feature('r5').set('contributeto', 'csel1');
model.geom('geom1').feature('wp1').geom.run('r5');
model.geom('geom1').feature('wp1').geom.create('r6', 'Rectangle');
model.geom('geom1').feature('wp1').geom.feature('r6').set('size', [47.6 6.8]);
model.geom('geom1').feature('wp1').geom.feature('r6').set('pos', [-22.44 -23.8]);
model.geom('geom1').feature('wp1').geom.feature('r6').set('contributeto', 'csel1');
model.geom('geom1').feature('wp1').geom.run('r6');
model.geom('geom1').feature('wp1').geom.create('r7', 'Rectangle');
model.geom('geom1').feature('wp1').geom.feature('r7').set('size', [34 6.8]);
model.geom('geom1').feature('wp1').geom.feature('r7').set('pos', [-15.64 -30.6]);
model.geom('geom1').feature('wp1').geom.feature('r7').set('contributeto', 'csel1');
model.geom('geom1').feature('wp1').geom.run('r7');
model.geom('geom1').feature('wp1').geom.create('uni1', 'Union');
model.geom('geom1').feature('wp1').geom.feature('uni1').selection('input').named('csel1');
model.geom('geom1').feature('wp1').geom.feature('uni1').set('intbnd', false);
model.geom('geom1').run('fin');
model.geom('geom1').create('igv1', 'IgnoreVertices');
model.geom('geom1').feature('igv1').selection('input').set('fin', 31);
model.geom('geom1').run('igv1');
model.geom('geom1').create('sel1', 'ExplicitSelection');
model.geom('geom1').feature('sel1').label('Anode');
model.geom('geom1').feature('sel1').selection('selection').init(2);
model.geom('geom1').feature('sel1').selection('selection').set('igv1', 6);
model.geom('geom1').run('sel1');
model.geom('geom1').create('sel2', 'ExplicitSelection');
model.geom('geom1').feature('sel2').label('Cathode');
model.geom('geom1').feature('sel2').selection('selection').init(2);

model.view('view1').set('renderwireframe', true);

model.geom('geom1').feature('sel2').selection('selection').set('igv1', [15 17]);

model.title([]);

model.description('');

model.label('resistive_wafer_geom_sequence.mph');

model.modelNode.label('Components');

out = model;
