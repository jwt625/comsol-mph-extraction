function out = model
%
% protein_adsorption_geom_sequence.m
%
% Model exported on May 26 2025, 21:27 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/Chemical_Reaction_Engineering_Module/Mixing_and_Separation');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 3);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.geom('geom1').lengthUnit('mm');
model.geom('geom1').create('cyl1', 'Cylinder');
model.geom('geom1').feature('cyl1').set('r', 4.25);
model.geom('geom1').feature('cyl1').set('h', 2.15);
model.geom('geom1').run('cyl1');
model.geom('geom1').create('blk1', 'Block');
model.geom('geom1').feature('blk1').set('size', [4.25 4.25 2.15]);
model.geom('geom1').run('blk1');
model.geom('geom1').create('int1', 'Intersection');
model.geom('geom1').feature('int1').selection('input').set({'blk1' 'cyl1'});
model.geom('geom1').run('int1');
model.geom('geom1').create('sph1', 'Sphere');
model.geom('geom1').feature('sph1').set('r', 0.5);
model.geom('geom1').feature('sph1').set('pos', [0.45 0.45 0.45]);
model.geom('geom1').run('sph1');
model.geom('geom1').create('arr1', 'Array');
model.geom('geom1').feature('arr1').selection('input').set({'sph1'});
model.geom('geom1').feature('arr1').set('fullsize', [4 4 2]);
model.geom('geom1').feature('arr1').set('displ', [0.95 0.95 0.95]);
model.geom('geom1').feature('arr1').set('selresult', true);
model.geom('geom1').feature('arr1').set('selresultshow', 'bnd');
model.geom('geom1').run('arr1');
model.geom('geom1').feature.create('del1', 'Delete');
model.geom('geom1').feature('del1').selection('input').init;

model.view('view1').set('renderwireframe', true);

model.geom('geom1').feature('del1').selection('input').set({'arr1(3,4,1)' 'arr1(3,4,2)' 'arr1(4,3,1)' 'arr1(4,3,2)' 'arr1(4,4,1)' 'arr1(4,4,2)'});
model.geom('geom1').run('del1');
model.geom('geom1').create('dif1', 'Difference');
model.geom('geom1').feature('dif1').selection('input').set({'int1'});
model.geom('geom1').feature('dif1').selection('input2').named('arr1');
model.geom('geom1').run('fin');
model.geom('geom1').create('sel1', 'ExplicitSelection');
model.geom('geom1').feature('sel1').selection('selection').init(2);
model.geom('geom1').feature('sel1').selection('selection').set('fin', 37);
model.geom('geom1').feature('sel1').label('Column wall');
model.geom('geom1').run('sel1');
model.geom('geom1').create('sel2', 'ExplicitSelection');
model.geom('geom1').feature('sel2').label('Inlet');
model.geom('geom1').feature('sel2').selection('selection').init(2);
model.geom('geom1').feature('sel2').selection('selection').set('fin', 4);
model.geom('geom1').run('sel2');
model.geom('geom1').create('sel3', 'ExplicitSelection');
model.geom('geom1').feature('sel3').label('Outlet column section');
model.geom('geom1').feature('sel3').selection('selection').init(2);
model.geom('geom1').feature('sel3').selection('selection').set('fin', 3);
model.geom('geom1').run('sel3');
model.geom('geom1').create('sel4', 'ExplicitSelection');
model.geom('geom1').feature('sel4').label('Symmetry');
model.geom('geom1').feature('sel4').selection('selection').init(2);
model.geom('geom1').feature('sel4').selection('selection').set('fin', [1 2]);

model.title([]);

model.description('');

model.label('protein_adsorption_geom_sequence.mph');

model.modelNode.label('Components');

out = model;
