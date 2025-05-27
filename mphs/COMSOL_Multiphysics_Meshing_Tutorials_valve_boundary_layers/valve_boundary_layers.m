function out = model
%
% valve_boundary_layers.m
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

model.physics.create('spf', 'LaminarFlow', 'geom1');
model.physics('spf').model('comp1');

model.geom('geom1').insertFile('valve_geom_sequence.mph', 'geom1');
model.geom('geom1').run('fin');

model.view('view1').set('showgrid', true);

model.physics('spf').create('inl1', 'InletBoundary', 1);
model.physics('spf').feature('inl1').selection.set([1]);
model.physics('spf').feature('inl1').set('U0in', '0.5[m/s]');
model.physics('spf').create('out1', 'OutletBoundary', 1);
model.physics('spf').feature('out1').selection.set([8]);

model.mesh('mesh1').autoMeshSize(4);
model.mesh('mesh1').run;
model.mesh('mesh1').automatic(false);
model.mesh('mesh1').feature('bl1').feature('blp1').set('blnlayers', 6);
model.mesh('mesh1').run('bl1');

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

model.mesh('mesh1').feature('bl1').feature('blp1').set('blhminfact', 1.2);
model.mesh('mesh1').run('bl1');

model.result('pg1').run;

model.mesh('mesh1').feature('bl1').feature('blp1').set('blstretch', 1.3);
model.mesh('mesh1').run('bl1');
model.mesh('mesh1').feature('bl1').feature('blp1').set('inittype', 'blhmin');
model.mesh('mesh1').feature('bl1').feature('blp1').set('blhmin', '0.15[mm]');
model.mesh('mesh1').run('bl1');
model.mesh('mesh1').feature('bl1').feature('blp1').set('inittype', 'blhtot');
model.mesh('mesh1').feature('bl1').feature('blp1').set('blhtot', '2[mm]');
model.mesh('mesh1').run('bl1');
model.mesh('mesh1').feature('bl1').feature('blp1').selection.set([2 3 4 5 6 9 10 11 12]);
model.mesh('mesh1').feature('bl1').create('blp2', 'BndLayerProp');
model.mesh('mesh1').feature('bl1').feature('blp2').selection.set([7]);
model.mesh('mesh1').feature('bl1').feature('blp2').set('blnlayers', 10);
model.mesh('mesh1').run('bl1');
model.mesh('mesh1').feature('bl1').set('layerdec', 1);
model.mesh('mesh1').run('bl1');
model.mesh('mesh1').feature('bl1').set('trimminangle', 230);
model.mesh('mesh1').run('bl1');
model.mesh('mesh1').feature('cr1').set('minangle', 230);
model.mesh('mesh1').run;
model.mesh('mesh1').feature('bl1').set('trimmaxangle', 65);
model.mesh('mesh1').run('bl1');
model.mesh('mesh1').feature('bl1').set('sharpcorners', 'none');
model.mesh('mesh1').run('bl1');
model.mesh('mesh1').feature('bl1').set('sharpcorners', 'split');
model.mesh('mesh1').run('bl1');
model.mesh('mesh1').feature('bl1').set('splitdivangle', 60);
model.mesh('mesh1').run('bl1');

model.result('pg1').run;

model.mesh('mesh1').feature('cr1').set('usefilter', true);
model.mesh('mesh1').feature('cr1').selection('corner').set([3 10]);
model.mesh('mesh1').feature('cr1').set('filter', 'exclude');
model.mesh('mesh1').run;

model.result('pg1').run;

model.mesh('mesh1').feature('bl1').create('crp1', 'CornerProp');
model.mesh('mesh1').feature('bl1').feature('crp1').selection.set([4]);
model.mesh('mesh1').feature('bl1').feature('crp1').set('cornerhandling', 'split');
model.mesh('mesh1').run('bl1');
model.mesh('mesh1').feature('cr1').selection('corner').set([3 4 10]);
model.mesh('mesh1').run;

model.title(['Boundary Layer Meshing ' native2unicode(hex2dec({'20' '14'}), 'unicode') ' Exploring the Settings']);

model.description('Follow this tutorial to learn about how to set up a boundary layer mesh and modify the settings for an automatically created boundary layer mesh. For physics-controlled meshing a boundary layer mesh is automatically added for applications where sharp gradients are expected close to boundaries. You will discover how to control the number of layers, how to define the layer thicknesses, and how to create a boundary layer mesh with different properties for different boundaries. The tutorial also demonstrates the available methods for adding boundary layers around corners, and the setup of mesh plots for assessing the element quality.');

model.label('valve_boundary_layers.mph');

model.modelNode.label('Components');

out = model;
