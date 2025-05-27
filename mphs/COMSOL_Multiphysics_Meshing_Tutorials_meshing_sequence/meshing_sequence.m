function out = model
%
% meshing_sequence.m
%
% Model exported on May 26 2025, 21:27 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/COMSOL_Multiphysics/Meshing_Tutorials');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 3);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.geom('geom1').insertFile('meshing_sequence_geom_sequence.mph', 'geom1');
model.geom('geom1').run('fin');

model.mesh('mesh1').run;
model.mesh('mesh1').automatic(false);
model.mesh('mesh1').feature('ftet1').create('size1', 'Size');
model.mesh('mesh1').feature('ftet1').feature('size1').selection.geom('geom1', 3);
model.mesh('mesh1').feature('ftet1').feature('size1').selection.set([1 2 3]);
model.mesh('mesh1').feature('ftet1').feature('size1').set('hauto', 7);
model.mesh('mesh1').run;
model.mesh('mesh1').feature('ftet1').selection.geom('geom1', 3);
model.mesh('mesh1').feature('ftet1').selection.set([4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23]);
model.mesh('mesh1').feature('ftet1').feature('size1').active(false);
model.mesh('mesh1').run;
model.mesh('mesh1').create('ftri1', 'FreeTri');

model.view('view1').set('renderwireframe', true);

model.mesh('mesh1').feature('ftri1').selection.set([7 12]);

model.view('view1').set('renderwireframe', true);

model.mesh('mesh1').run;
model.mesh('mesh1').feature('ftri1').create('size1', 'Size');
model.mesh('mesh1').feature('ftri1').feature('size1').set('hauto', 7);
model.mesh('mesh1').run;
model.mesh('mesh1').feature('size').set('hauto', 7);
model.mesh('mesh1').feature('ftet1').feature('size1').active(true);
model.mesh('mesh1').feature('ftet1').feature('size1').selection.all;
model.mesh('mesh1').feature('ftet1').feature('size1').selection.set([4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23]);
model.mesh('mesh1').feature('ftet1').feature('size1').set('hauto', 5);
model.mesh('mesh1').feature('ftri1').feature.remove('size1');
model.mesh('mesh1').run;
model.mesh('mesh1').create('swe1', 'Sweep');
model.mesh('mesh1').run;
model.mesh('mesh1').feature('swe1').create('dis1', 'Distribution');
model.mesh('mesh1').feature('swe1').feature('dis1').set('numelem', 2);
model.mesh('mesh1').run;

model.title('Using Meshing Sequences');

model.description('This tutorial demonstrates how to use the meshing sequence to create a mesh consisting of different element types. You learn how to add, move, disable, and delete mesh operations, as well as how to control the mesh using size features in the meshing sequence.');

model.mesh.clearMeshes;

model.label('meshing_sequence.mph');

model.modelNode.label('Components');

out = model;
