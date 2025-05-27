function out = model
%
% argon_gec_icp_geom_sequence.m
%
% Model exported on May 26 2025, 21:31 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/Plasma_Module/Inductively_Coupled_Plasmas');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 2);
model.geom('geom1').model('comp1');
model.geom('geom1').axisymmetric(true);

model.mesh.create('mesh1', 'geom1');

model.geom('geom1').create('pol1', 'Polygon');
model.geom('geom1').feature('pol1').set('source', 'vectors');
model.geom('geom1').feature('pol1').set('x', '0.01 0.01 0.14 0.14 0.07 0.07 0 0 0.01');
model.geom('geom1').feature('pol1').set('y', '-0.015 -0.025 -0.025 0.08 0.08 0.05 0.05 -0.015 -0.015');
model.geom('geom1').runPre('fin');
model.geom('geom1').create('r1', 'Rectangle');
model.geom('geom1').feature('r1').set('size', [0.064 0.01]);
model.geom('geom1').feature('r1').set('pos', [0 0.04]);
model.geom('geom1').run('r1');
model.geom('geom1').create('r2', 'Rectangle');
model.geom('geom1').feature('r2').set('size', [0.06 0.03]);
model.geom('geom1').feature('r2').set('pos', [0 0.05]);
model.geom('geom1').run('r2');
model.geom('geom1').create('r3', 'Rectangle');
model.geom('geom1').feature('r3').set('size', [0.0825 0.0025]);
model.geom('geom1').feature('r3').set('pos', [0 -0.0025]);
model.geom('geom1').run('r3');
model.geom('geom1').create('r4', 'Rectangle');
model.geom('geom1').feature('r4').set('size', {'0.05' '0.015-0.0025'});
model.geom('geom1').feature('r4').set('pos', [0 -0.015]);
model.geom('geom1').run('r4');
model.geom('geom1').create('r5', 'Rectangle');
model.geom('geom1').feature('r5').set('size', [0.04 0.01]);
model.geom('geom1').feature('r5').set('pos', [0.01 -0.025]);
model.geom('geom1').run('r5');
model.geom('geom1').create('pol2', 'Polygon');
model.geom('geom1').feature('pol2').set('source', 'vectors');
model.geom('geom1').feature('pol2').set('x', '0.057 0.057 0.0825 0.0825 0.064 0.064 0.057');
model.geom('geom1').feature('pol2').set('y', '0.04 0.034 0.034 0.05 0.05 0.04 0.04');
model.geom('geom1').runPre('fin');
model.geom('geom1').create('r6', 'Rectangle');
model.geom('geom1').feature('r6').set('size', [0.003 0.003]);
model.geom('geom1').feature('r6').set('pos', [0.005 0.05]);
model.geom('geom1').run('r6');
model.geom('geom1').create('arr1', 'Array');
model.geom('geom1').feature('arr1').selection('input').set({'r6'});
model.geom('geom1').feature('arr1').set('fullsize', [5 1]);
model.geom('geom1').feature('arr1').set('displ', [0.012 0]);
model.geom('geom1').runPre('fin');

model.title([]);

model.description('');

model.label('argon_gec_icp_geom_sequence.mph');

model.modelNode.label('Components');

out = model;
