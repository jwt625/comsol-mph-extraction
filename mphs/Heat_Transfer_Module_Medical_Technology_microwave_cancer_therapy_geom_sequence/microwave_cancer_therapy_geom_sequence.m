function out = model
%
% microwave_cancer_therapy_geom_sequence.m
%
% Model exported on May 26 2025, 21:29 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/Heat_Transfer_Module/Medical_Technology');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 2);
model.geom('geom1').model('comp1');
model.geom('geom1').axisymmetric(true);

model.mesh.create('mesh1', 'geom1');

model.geom('geom1').lengthUnit('mm');
model.geom('geom1').create('r1', 'Rectangle');
model.geom('geom1').feature('r1').set('size', [30 80]);
model.geom('geom1').run('r1');
model.geom('geom1').create('r2', 'Rectangle');
model.geom('geom1').feature('r2').set('size', [0.595 70]);
model.geom('geom1').feature('r2').set('pos', [0 10]);
model.geom('geom1').run('r2');
model.geom('geom1').create('r3', 'Rectangle');
model.geom('geom1').feature('r3').label('Dielectric');
model.geom('geom1').feature('r3').set('size', [0.335 69.9]);
model.geom('geom1').feature('r3').set('pos', [0.135 10.1]);
model.geom('geom1').feature('r3').set('selresult', true);
model.geom('geom1').run('r3');
model.geom('geom1').create('r4', 'Rectangle');
model.geom('geom1').feature('r4').set('size', [0.895 70]);
model.geom('geom1').feature('r4').set('pos', [0 10]);
model.geom('geom1').run('r4');
model.geom('geom1').create('r5', 'Rectangle');
model.geom('geom1').feature('r5').label('Air');
model.geom('geom1').feature('r5').set('size', [0.125 1]);
model.geom('geom1').feature('r5').set('pos', [0.47 15.5]);
model.geom('geom1').feature('r5').set('selresult', true);
model.geom('geom1').run('r5');
model.geom('geom1').create('pol1', 'Polygon');
model.geom('geom1').feature('pol1').set('source', 'vectors');
model.geom('geom1').feature('pol1').set('x', '0 0.895 0.895 0 0 0');
model.geom('geom1').feature('pol1').set('y', '10 10 10 9.5 9.5 10');
model.geom('geom1').run('pol1');
model.geom('geom1').create('uni1', 'Union');
model.geom('geom1').feature('uni1').label('Catheter');
model.geom('geom1').feature('uni1').selection('input').set({'pol1' 'r4'});
model.geom('geom1').feature('uni1').set('intbnd', false);
model.geom('geom1').feature('uni1').set('selresult', true);
model.geom('geom1').run('uni1');
model.geom('geom1').create('dif1', 'Difference');
model.geom('geom1').feature('dif1').selection('input').set({'r1' 'uni1'});
model.geom('geom1').feature('dif1').selection('input2').set({'r2'});

model.title([]);

model.description('');

model.label('microwave_cancer_therapy_geom_sequence.mph');

model.modelNode.label('Components');

out = model;
