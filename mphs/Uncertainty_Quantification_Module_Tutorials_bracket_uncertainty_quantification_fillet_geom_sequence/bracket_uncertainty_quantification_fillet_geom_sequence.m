function out = model
%
% bracket_uncertainty_quantification_fillet_geom_sequence.m
%
% Model exported on May 26 2025, 21:34 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/Uncertainty_Quantification_Module/Tutorials');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 3);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.geom('geom1').geomRep('cadps');
model.geom('geom1').insertFile('bracket_uncertainty_quantification_geom_sequence.mph', 'geom1');
model.geom('geom1').run('fin');
model.geom('geom1').create('ige1', 'IgnoreEdges');

model.view('view1').set('transparency', true);

model.geom('geom1').feature('ige1').selection('input').set('fin', [28 35 37 41 120 124 125 128]);
model.geom('geom1').run('ige1');

model.param.set('fr1', '0.01[m]');
model.param.descr('fr1', 'Fillet radius');

model.geom('geom1').run('uni1');
model.geom('geom1').create('fil1', 'Fillet3D');
model.geom('geom1').feature('fil1').selection('edge').set('uni1', [27 30 32 33 68 71 72 77 119 121 122 123]);
model.geom('geom1').feature('fil1').set('radius', 'fr1');
model.geom('geom1').runPre('fin');
model.geom('geom1').run('ige1');

model.title([]);

model.description('');

model.label('bracket_uncertainty_quantification_fillet_geom_sequence.mph');

model.modelNode.label('Components');

out = model;
