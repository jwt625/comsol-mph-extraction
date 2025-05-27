function out = model
%
% drug_delivery_mm_geom_sequence.m
%
% Model exported on May 26 2025, 21:30 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/Microfluidics_Module/Two-Phase_Flow');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 2);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.geom('geom1').lengthUnit('mm');
model.geom('geom1').create('r1', 'Rectangle');
model.geom('geom1').feature('r1').set('size', [0.05 1.5]);
model.geom('geom1').feature('r1').setIndex('layername', 'Layer 1', 0);
model.geom('geom1').feature('r1').setIndex('layer', 0.9, 0);
model.geom('geom1').feature('r1').setIndex('layername', 'Layer 2', 1);
model.geom('geom1').feature('r1').setIndex('layer', 0.5, 1);
model.geom('geom1').run('r1');
model.geom('geom1').create('e1', 'Ellipse');
model.geom('geom1').feature('e1').set('semiaxes', [0.09 0.12]);
model.geom('geom1').feature('e1').set('pos', [0 1.15]);
model.geom('geom1').feature('e1').set('type', 'curve');
model.geom('geom1').run('e1');
model.geom('geom1').create('par1', 'Partition');
model.geom('geom1').feature('par1').selection('input').set({'r1'});
model.geom('geom1').feature('par1').selection('tool').set({'e1'});
model.geom('geom1').run('fin');

model.title([]);

model.description('');

model.label('drug_delivery_mm_geom_sequence.mph');

model.modelNode.label('Components');

out = model;
