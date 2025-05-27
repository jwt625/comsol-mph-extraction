function out = model
%
% valve_boundary_layers_import.m
%
% Model exported on May 26 2025, 21:27 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/COMSOL_Multiphysics/Meshing_Tutorials');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 2);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.geom('geom1').run;

model.mesh('mesh1').create('imp1', 'Import');
model.mesh('mesh1').feature('imp1').set('filename', 'valve_mesh.mphbin');
model.mesh('mesh1').feature('imp1').importData;

model.view('view1').set('showgrid', true);

model.mesh('mesh1').create('ref1', 'Refine');
model.mesh('mesh1').feature('ref1').set('rmethod', 'longest');
model.mesh('mesh1').run('ref1');
model.mesh('mesh1').feature('ref1').set('rmethod', 'regular');
model.mesh('mesh1').run('ref1');
model.mesh('mesh1').create('bl1', 'BndLayer');
model.mesh('mesh1').feature('bl1').create('blp', 'BndLayerProp');
model.mesh('mesh1').feature('bl1').feature('blp').selection.named('imp1_Wall_Boundaries');
model.mesh('mesh1').feature('bl1').feature('blp').set('blnlayers', 6);
model.mesh('mesh1').feature('bl1').feature('blp').set('blstretch', 1.4);
model.mesh('mesh1').feature('bl1').feature('blp').set('inittype', 'blhtot');
model.mesh('mesh1').feature('bl1').feature('blp').set('blhtot', '1[mm]');
model.mesh('mesh1').run;
model.mesh('mesh1').feature('bl1').set('sharpcorners', 'none');
model.mesh('mesh1').run;

model.result.dataset.create('mesh1', 'Mesh');
model.result.dataset('mesh1').set('mesh', 'mesh1');
model.result.create('pg1', 'PlotGroup2D');
model.result('pg1').label('Mesh Plot 1');
model.result('pg1').set('data', 'mesh1');
model.result('pg1').set('inherithide', true);
model.result('pg1').set('showlegendsmaxmin', true);
model.result('pg1').create('mesh1', 'Mesh');
model.result('pg1').feature('mesh1').set('colortable', 'TrafficFlow');
model.result('pg1').feature('mesh1').set('colortabletrans', 'nonlinear');
model.result('pg1').feature('mesh1').set('nonlinearcolortablerev', true);
model.result('pg1').run;
model.result('pg1').feature('mesh1').set('qualmeasure', 'growth');
model.result('pg1').run;

model.mesh('mesh1').feature('bl1').set('smoothmaxdepth', 2);
model.mesh('mesh1').run;

model.result('pg1').run;
model.result('pg1').feature('mesh1').set('qualmeasure', 'skewness');
model.result('pg1').run;

model.title(['Boundary Layer Meshing ' native2unicode(hex2dec({'20' '14'}), 'unicode') ' Adding Boundary Layers to an Imported Mesh']);

model.description('This tutorial demonstrates how to add a boundary layer mesh to an imported mesh. You will learn how to refine an imported mesh, how to insert the boundary layer mesh, how to control the element growth rate from the boundary to the interior, and how to set up the distribution and thickness of the boundary layers.');

model.label('valve_boundary_layers_import.mph');

model.modelNode.label('Components');

out = model;
