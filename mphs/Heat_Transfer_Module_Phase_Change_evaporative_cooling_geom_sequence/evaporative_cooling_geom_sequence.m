function out = model
%
% evaporative_cooling_geom_sequence.m
%
% Model exported on May 26 2025, 21:29 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/Heat_Transfer_Module/Phase_Change');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 3);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.geom('geom1').lengthUnit('cm');
model.geom('geom1').create('cone1', 'Cone');
model.geom('geom1').feature('cone1').set('specifytop', 'radius');
model.geom('geom1').feature('cone1').set('r', 3.3);
model.geom('geom1').feature('cone1').set('h', 8);
model.geom('geom1').feature('cone1').set('rtop', 4);
model.geom('geom1').feature('cone1').set('pos', [68 0 0]);
model.geom('geom1').feature('cone1').setIndex('layername', 'Layer 1', 0);
model.geom('geom1').feature('cone1').setIndex('layer', 0.4, 0);
model.geom('geom1').feature('cone1').set('layerbottom', true);
model.geom('geom1').run('cone1');
model.geom('geom1').create('wp1', 'WorkPlane');
model.geom('geom1').feature('wp1').set('unite', true);
model.geom('geom1').feature('wp1').set('planetype', 'faceparallel');
model.geom('geom1').feature('wp1').selection('face').set('cone1', 8);
model.geom('geom1').feature('wp1').set('offset', 0.5);
model.geom('geom1').feature('wp1').set('reverse', true);
model.geom('geom1').run('wp1');
model.geom('geom1').create('pard1', 'PartitionDomains');
model.geom('geom1').feature('pard1').selection('domain').set('cone1', 3);
model.geom('geom1').run('pard1');
model.geom('geom1').create('del1', 'Delete');
model.geom('geom1').feature('del1').selection('input').init(3);
model.geom('geom1').feature('del1').selection('input').set('pard1', 3);
model.geom('geom1').run('del1');
model.geom('geom1').create('blk1', 'Block');
model.geom('geom1').feature('blk1').set('size', [85 9.5 18]);
model.geom('geom1').run('blk1');
model.geom('geom1').create('par1', 'Partition');
model.geom('geom1').feature('par1').selection('input').set({'blk1'});
model.geom('geom1').feature('par1').selection('tool').set({'del1'});
model.geom('geom1').run('fin');

model.view('view1').set('transparency', true);

model.title([]);

model.description('');

model.label('evaporative_cooling_geom_sequence.mph');

model.modelNode.label('Components');

out = model;
