function out = model
%
% wax_guard_acoustics_geom_sequence.m
%
% Model exported on May 26 2025, 21:25 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/Acoustics_Module/Tutorials,_Thermoviscous_Acoustics');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 3);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.geom('geom1').geomRep('cadps');
model.geom('geom1').create('imp1', 'Import');
model.geom('geom1').feature('imp1').set('filename', 'wax_guard_acoustics_cad_geometry.stp');
model.geom('geom1').feature('imp1').importData;
model.geom('geom1').feature('imp1').set('unit', 'source');
model.geom('geom1').run('imp1');
model.geom('geom1').create('uni1', 'Union');
model.geom('geom1').feature('uni1').selection('input').set({'imp1'});
model.geom('geom1').feature('uni1').set('repairtoltype', 'absolute');
model.geom('geom1').feature('uni1').set('absrepairtol', 1.0E-4);
model.geom('geom1').runPre('fin');
model.geom('geom1').create('cap1', 'CapFaces');
model.geom('geom1').feature('cap1').selection('input').set('uni1', [57 58]);

model.view('view1').set('renderwireframe', false);

model.geom('geom1').run('cap1');
model.geom('geom1').feature.create('ext1', 'Extrude');
model.geom('geom1').feature('ext1').selection('inputface').set('cap1', 38);

model.view('view1').set('renderwireframe', false);

model.geom('geom1').feature('ext1').set('specify', 'vertices');
model.geom('geom1').feature('ext1').selection('vertex').set('cap1', 200);
model.geom('geom1').run('ext1');
model.geom('geom1').create('del1', 'Delete');
model.geom('geom1').feature('del1').selection('input').init(3);
model.geom('geom1').feature('del1').selection('input').set('ext1', 1);
model.geom('geom1').run('del1');
model.geom('geom1').create('del2', 'Delete');
model.geom('geom1').feature('del2').selection('input').init(3);
model.geom('geom1').feature('del2').selection('input').set('del1', [1 3 4 5 6]);
model.geom('geom1').run('del2');
model.geom('geom1').feature.create('ext2', 'Extrude');
model.geom('geom1').feature('ext2').selection('inputface').set('del2', 3);
model.geom('geom1').feature('ext2').setIndex('distance', '1[mm]', 0);
model.geom('geom1').run('ext2');
model.geom('geom1').create('wp1', 'WorkPlane');
model.geom('geom1').feature('wp1').set('unite', true);
model.geom('geom1').feature('wp1').set('quickz', -0.75);
model.geom('geom1').run('wp1');
model.geom('geom1').create('pard1', 'PartitionDomains');
model.geom('geom1').feature('pard1').selection('domain').set('ext2', 2);
model.geom('geom1').run('pard1');
model.geom('geom1').run('fin');
model.geom('geom1').create('cmf1', 'CompositeFaces');
model.geom('geom1').feature('cmf1').selection('input').set('fin', [35 39 45 47 64 65 69 75]);

model.view('view1').set('renderwireframe', false);

model.geom('geom1').run('cmf1');
model.geom('geom1').create('ige1', 'IgnoreEdges');

model.view('view1').set('renderwireframe', true);

model.geom('geom1').feature('ige1').selection('input').set('cmf1', [40 45 110 112 123 128 185 187]);
model.geom('geom1').run('ige1');
model.geom('geom1').create('ige2', 'IgnoreEdges');
model.geom('geom1').feature('ige2').selection('input').set('ige1', [21 23 27 45 47 61 63 80 82 85 86 95 99 130 131 132 133 134 136 140 141 174 176 184 186]);
model.geom('geom1').run('ige2');

model.view('view1').set('renderwireframe', false);

model.title([]);

model.description('');

model.label('wax_guard_acoustics_geom_sequence.mph');

model.modelNode.label('Components');

out = model;
