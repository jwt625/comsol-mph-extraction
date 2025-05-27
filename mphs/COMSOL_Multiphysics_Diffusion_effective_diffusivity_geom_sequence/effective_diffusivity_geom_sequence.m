function out = model
%
% effective_diffusivity_geom_sequence.m
%
% Model exported on May 26 2025, 21:26 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/COMSOL_Multiphysics/Diffusion');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 2);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.geom('geom1').create('sq1', 'Square');
model.geom('geom1').feature('sq1').set('size', '0.08[mm]');
model.geom('geom1').feature('sq1').set('pos', {'0.01[mm]' '0.01[mm]'});
model.geom('geom1').feature('sq1').set('selresult', true);
model.geom('geom1').feature('sq1').set('selresultshow', false);
model.geom('geom1').run('sq1');
model.geom('geom1').create('fil1', 'Fillet');
model.geom('geom1').feature('fil1').selection('point').named('sq1');
model.geom('geom1').feature('fil1').set('radius', '0.016[mm]');
model.geom('geom1').run('fil1');
model.geom('geom1').create('arr1', 'Array');
model.geom('geom1').feature('arr1').selection('input').set({'fil1'});
model.geom('geom1').feature('arr1').set('fullsize', [8 9]);
model.geom('geom1').feature('arr1').set('displ', {'0.1[mm]' '0.1[mm]'});
model.geom('geom1').run('arr1');
model.geom('geom1').create('mov1', 'Move');
model.geom('geom1').feature('mov1').set('disply', '-0.05[mm]');
model.geom('geom1').feature('mov1').selection('input').set({'arr1(2,1)' 'arr1(2,2)' 'arr1(2,3)' 'arr1(2,4)' 'arr1(2,5)' 'arr1(2,6)' 'arr1(2,7)' 'arr1(2,8)' 'arr1(2,9)' 'arr1(4,1)'  ...
'arr1(4,2)' 'arr1(4,3)' 'arr1(4,4)' 'arr1(4,5)' 'arr1(4,6)' 'arr1(4,7)' 'arr1(4,8)' 'arr1(4,9)' 'arr1(6,1)' 'arr1(6,2)'  ...
'arr1(6,3)' 'arr1(6,4)' 'arr1(6,5)' 'arr1(6,6)' 'arr1(6,7)' 'arr1(6,8)' 'arr1(6,9)' 'arr1(8,1)' 'arr1(8,2)' 'arr1(8,3)'  ...
'arr1(8,4)' 'arr1(8,5)' 'arr1(8,6)' 'arr1(8,7)' 'arr1(8,8)' 'arr1(8,9)'});
model.geom('geom1').run('mov1');
model.geom('geom1').create('r1', 'Rectangle');
model.geom('geom1').feature('r1').set('size', {'0.8[mm]' '0.8[mm]'});
model.geom('geom1').run('r1');
model.geom('geom1').create('dif1', 'Difference');
model.geom('geom1').feature('dif1').selection('input').set({'r1'});
model.geom('geom1').feature('dif1').selection('input2').named('sq1');
model.geom('geom1').run('dif1');
model.geom('geom1').run('fin');
model.geom('geom1').create('sel1', 'ExplicitSelection');
model.geom('geom1').feature('sel1').selection('selection').init(0);
model.geom('geom1').feature('sel1').label('Top-Right Vertex');
model.geom('geom1').feature('sel1').selection('selection').set('fin', 532);
model.geom('geom1').run('sel1');
model.geom('geom1').create('sel2', 'ExplicitSelection');
model.geom('geom1').feature('sel2').selection('selection').init(1);
model.geom('geom1').feature('sel2').label('Left Boundary');
model.geom('geom1').feature('sel2').selection('selection').set('fin', 1);
model.geom('geom1').run('sel2');
model.geom('geom1').create('sel3', 'ExplicitSelection');
model.geom('geom1').feature('sel3').selection('selection').init(1);
model.geom('geom1').feature('sel3').selection('selection').set('fin', 276);
model.geom('geom1').feature('sel3').label('Right Boundary');
model.geom('geom1').run('sel3');

model.title([]);

model.description('');

model.label('effective_diffusivity_geom_sequence.mph');

model.modelNode.label('Components');

out = model;
