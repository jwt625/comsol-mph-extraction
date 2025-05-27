function out = model
%
% wheel_rim_defeature.m
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
model.geom('geom1').defeaturing('SmallFaces').set('entsize', '1e-4');
model.geom('geom1').defeaturing('SmallFaces').find;
model.geom('geom1').defeaturing('SmallFaces').deleteAll('dsf1');
model.geom('geom1').defeaturing('SliverFaces').set('entsize', '4e-4');
model.geom('geom1').defeaturing('SliverFaces').find;
model.geom('geom1').defeaturing('SliverFaces').deleteAll('dsl1');
model.geom('geom1').defeaturing('ShortEdges').set('entsize', '4e-4');
model.geom('geom1').defeaturing('ShortEdges').find;
model.geom('geom1').defeaturing('ShortEdges').selection('input').init;
model.geom('geom1').defeaturing('ShortEdges').selection('input').set({'dsl1'});
model.geom('geom1').defeaturing('ShortEdges').set('entsize', '9e-4');
model.geom('geom1').defeaturing('ShortEdges').find;
model.geom('geom1').defeaturing('ShortEdges').find;
model.geom('geom1').defeaturing('ShortEdges').deleteAll('dse1');
model.geom('geom1').defeaturing('Fillets').set('entsize', '2[mm]');
model.geom('geom1').defeaturing('Fillets').find;
model.geom('geom1').defeaturing('Fillets').detail.clear('dse1');
model.geom('geom1').defeaturing('Fillets').detail.set('dse1', [240 241 257 263 274 275 279 287 316 333 335 339 352 359 360 367 368 373 379 401 427 436 464 465 466 473 479 489 493 507 515 516 521 528 530 553 588 592 610 615]);
model.geom('geom1').defeaturing('Fillets').delete('dfi1');

model.mesh('mesh1').run;

model.title('Removing Small Geometric Entities with the Defeaturing Tools');

model.description('This tutorial demonstrates an alternative workflow to remove small details from an imported CAD geometry. While the Repair operation removes all details that fall within a specified tolerance, the defeaturing tools used in this tutorial allow to select the entities that should be removed.');

model.mesh.clearMeshes;

model.label('wheel_rim_defeature.mph');

model.modelNode.label('Components');

out = model;
