function out = model
%
% wheel_rim_repair.m
%
% Model exported on May 26 2025, 21:27 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/Design_Module/Tutorial_Examples');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 3);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.geom('geom1').geomRep('cadps');
model.geom('geom1').create('imp1', 'Import');
model.geom('geom1').feature('imp1').set('filename', 'wheel_rim.x_b');
model.geom('geom1').feature('imp1').importData;
model.geom('geom1').run;

model.mesh('mesh1').create('ftri1', 'FreeTri');
model.mesh('mesh1').feature('ftri1').selection.all;
model.mesh('mesh1').run;

model.view('view1').set('rendermesh', false);

model.component('comp1').measure.selection.geom(1);
model.component('comp1').measure.selection.set([1384]);
model.component('comp1').measure.selection.geom(1);
model.component('comp1').measure.selection.set([1813]);

model.geom('geom1').create('rep1', 'Repair');
model.geom('geom1').feature('rep1').selection('input').set({'imp1'});
model.geom('geom1').feature('rep1').set('repairtol', '3.2e-4');
model.geom('geom1').runPre('fin');

model.mesh('mesh1').run;

model.geom('geom1').create('rep2', 'Repair');
model.geom('geom1').feature('rep2').selection('input').set({'rep1'});
model.geom('geom1').feature('rep2').set('repairtol', '9e-4');
model.geom('geom1').runPre('fin');

model.mesh('mesh1').feature.clear;
model.mesh('mesh1').automatic(false);

model.geom('geom1').run;

model.mesh('mesh1').run;

model.view('view1').set('rendermesh', true);

model.mesh('mesh1').feature('ftet1').create('size1', 'Size');
model.mesh('mesh1').feature('ftet1').feature('size1').selection.geom('geom1', 2);
model.mesh('mesh1').feature('ftet1').feature('size1').selection.set([225]);
model.mesh('mesh1').feature('ftet1').feature('size1').set('custom', true);
model.mesh('mesh1').feature('ftet1').feature('size1').set('hminactive', true);
model.mesh('mesh1').feature('ftet1').feature('size1').set('hmin', '2[mm]');
model.mesh('mesh1').run;

model.title('Removing Small Geometric Entities with Repair');

model.description('The geometry in this tutorial contains small details, such as short edges, small faces and slivers, that are removed using the Repair operation. The tutorial also shows how to use the warnings returned after generating a mesh for locating and measuring the size of small details to determine a suitable tolerance for the Repair operation.');

model.mesh.clearMeshes;

model.label('wheel_rim_repair.mph');

model.modelNode.label('Components');

out = model;
