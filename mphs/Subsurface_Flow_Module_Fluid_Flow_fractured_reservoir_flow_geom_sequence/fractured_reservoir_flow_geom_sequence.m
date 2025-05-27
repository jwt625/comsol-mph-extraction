function out = model
%
% fractured_reservoir_flow_geom_sequence.m
%
% Model exported on May 26 2025, 21:34 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/Subsurface_Flow_Module/Fluid_Flow');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 3);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.func.create('int1', 'Interpolation');
model.func('int1').model('comp1');
model.func('int1').set('source', 'file');
model.func('int1').set('filename', 'fractured_reservoir_flow_geom_sequence_interpolation.txt');
model.func('int1').importData;

model.geom('geom1').create('ps1', 'ParametricSurface');
model.geom('geom1').feature('ps1').set('parmax1', 10);
model.geom('geom1').feature('ps1').set('parmax2', 10);
model.geom('geom1').feature('ps1').set('coord', {'100*s1' '100*s2' ''});
model.geom('geom1').feature('ps1').setIndex('coord', '25*int(s1,s2)', 2);
model.geom('geom1').feature('ps1').set('rtol', '1.0E-2');
model.geom('geom1').feature('ps1').set('maxknots', 200);
model.geom('geom1').feature('ps1').setIndex('coord', '25*int1(s1,s2)', 2);
model.geom('geom1').run('ps1');
model.geom('geom1').feature.duplicate('ps2', 'ps1');
model.geom('geom1').feature('ps2').setIndex('coord', '25*int1(s1+20,s2+20)', 2);
model.geom('geom1').feature('ps2').set('pos', [0 0 -250]);
model.geom('geom1').feature.duplicate('ps3', 'ps2');
model.geom('geom1').feature('ps3').setIndex('coord', '25*int1(s1+50,s2+30)', 2);
model.geom('geom1').feature('ps3').set('pos', [0 0 40]);
model.geom('geom1').run('ps3');
model.geom('geom1').create('blk1', 'Block');
model.geom('geom1').feature('blk1').set('size', [1000 1000 500]);
model.geom('geom1').feature('blk1').set('pos', [0 0 -300]);
model.geom('geom1').run('blk1');
model.geom('geom1').create('pard1', 'PartitionDomains');
model.geom('geom1').feature('pard1').selection('domain').set('blk1', 1);
model.geom('geom1').feature('pard1').set('partitionwith', 'faces');
model.geom('geom1').feature('pard1').selection('face').set('ps1', 1);
model.geom('geom1').feature('pard1').selection('face').set('ps2', 1);
model.geom('geom1').feature('pard1').selection('face').set('ps3', 1);
model.geom('geom1').run('pard1');
model.geom('geom1').create('del1', 'Delete');
model.geom('geom1').feature('del1').selection('input').init(3);
model.geom('geom1').feature('del1').selection('input').set('pard1', 4);
model.geom('geom1').run('del1');
model.geom('geom1').create('sel1', 'ExplicitSelection');
model.geom('geom1').feature('sel1').label('Top');
model.geom('geom1').feature('sel1').selection('selection').set('del1', 3);
model.geom('geom1').run('sel1');
model.geom('geom1').create('sel2', 'ExplicitSelection');
model.geom('geom1').feature('sel2').selection('selection').set('del1', 2);
model.geom('geom1').feature('sel2').label('Middle');
model.geom('geom1').run('sel2');
model.geom('geom1').create('sel3', 'ExplicitSelection');
model.geom('geom1').feature('sel3').label('Bottom');
model.geom('geom1').feature('sel3').selection('selection').set('del1', 1);
model.geom('geom1').run('fin');

model.title([]);

model.description('');

model.label('fractured_reservoir_flow_geom_sequence.mph');

model.modelNode.label('Components');

out = model;
