function out = model
%
% wheel_rim_remove_details.m
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
model.geom('geom1').run('fin');
model.geom('geom1').create('rmd1', 'RemoveDetails');
model.geom('geom1').run('rmd1');

model.mesh('mesh1').run;

model.component('comp1').measure.selection.geom(1);
model.component('comp1').measure.selection.set([39]);

model.geom('geom1').feature('rmd1').set('detailsizetype', 'absolute');
model.geom('geom1').feature('rmd1').set('maxabssize', 8.5E-4);
model.geom('geom1').run('rmd1');

model.mesh('mesh1').run;

model.geom('geom1').feature('rmd1').set('automatic', 'off');
model.geom('geom1').runPre('rmd1/aclf1');
model.geom('geom1').run('rmd1/aclf1');
model.geom('geom1').run('rmd1/aige1');
model.geom('geom1').run('rmd1/aigv1');
model.geom('geom1').runPre('rmd1/acfr1');
model.geom('geom1').run('rmd1/acfr1');
model.geom('geom1').feature('rmd1').set('automatic', true);

model.mesh('mesh1').run;

model.title('Removing Small Geometric Entities with Remove Details');

model.description('Follow this tutorial to learn how to automatically remove small details from a geometry using the Remove Details operation. Remove Details sets up a sequence of virtual geometry operations that can be modified if needed, for example to prevent the removal of selected details.');

model.mesh.clearMeshes;

model.label('wheel_rim_remove_details.mph');

model.modelNode.label('Components');

out = model;
