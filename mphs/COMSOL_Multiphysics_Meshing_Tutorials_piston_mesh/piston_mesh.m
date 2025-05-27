function out = model
%
% piston_mesh.m
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

model.geom('geom1').create('imp1', 'Import');
model.geom('geom1').feature('imp1').set('filename', 'piston_quarter.mphbin');
model.geom('geom1').feature('imp1').importData;
model.geom('geom1').run;

model.mesh('mesh1').run;
model.mesh('mesh1').autoMeshSize(3);
model.mesh('mesh1').run;
model.mesh('mesh1').stat.setQualityMeasure('skewness');
model.mesh('mesh1').stat.selection.allGeom;
model.mesh('mesh1').autoMeshSize(5);
model.mesh('mesh1').run;
model.mesh('mesh1').automatic(false);
model.mesh('mesh1').feature('ftet1').create('size1', 'Size');
model.mesh('mesh1').feature('ftet1').feature('size1').selection.geom('geom1', 2);
model.mesh('mesh1').feature('ftet1').feature('size1').selection.set([39]);
model.mesh('mesh1').feature('ftet1').feature('size1').set('custom', true);
model.mesh('mesh1').feature('ftet1').feature('size1').set('hcurveactive', true);
model.mesh('mesh1').feature('ftet1').feature('size1').set('hcurve', 0.2);
model.mesh('mesh1').run;
model.mesh('mesh1').feature('ftet1').feature('size1').set('hminactive', true);
model.mesh('mesh1').feature('ftet1').feature('size1').set('hmin', '0.0002');
model.mesh('mesh1').run;
model.mesh('mesh1').feature('ftet1').feature('size1').set('hcurve', 0.45);
model.mesh('mesh1').run;
model.mesh('mesh1').feature('ftet1').feature('size1').selection.set([8 39]);
model.mesh('mesh1').feature('ftet1').feature('size1').set('hnarrowactive', true);
model.mesh('mesh1').feature('ftet1').feature('size1').set('hnarrow', 2);
model.mesh('mesh1').run;
model.mesh('mesh1').feature('ftet1').feature('size1').selection.all;
model.mesh('mesh1').run;
model.mesh('mesh1').stat.selection.allGeom;
model.mesh('mesh1').feature('size').set('custom', true);
model.mesh('mesh1').feature('size').set('hgrad', 1.8);
model.mesh('mesh1').run;
model.mesh('mesh1').stat.selection.allGeom;

model.result.dataset.create('mesh1', 'Mesh');
model.result.dataset('mesh1').set('mesh', 'mesh1');
model.result.create('pg1', 'PlotGroup3D');
model.result('pg1').label('Mesh Plot 1');
model.result('pg1').set('data', 'mesh1');
model.result('pg1').set('inherithide', true);
model.result('pg1').set('showlegendsmaxmin', true);
model.result('pg1').create('mesh1', 'Mesh');
model.result('pg1').feature('mesh1').set('colortable', 'TrafficFlow');
model.result('pg1').feature('mesh1').set('colortabletrans', 'nonlinear');
model.result('pg1').feature('mesh1').set('nonlinearcolortablerev', true);
model.result('pg1').feature('mesh1').set('meshdomain', 'volume');
model.result('pg1').run;
model.result('pg1').feature('mesh1').set('filteractive', true);
model.result('pg1').feature('mesh1').set('elemfilter', 'quality');
model.result('pg1').feature('mesh1').set('tetkeep', 0.005);
model.result('pg1').run;

model.title('Adjusting the Element Size for the Unstructured Mesh Generator');

model.description('This is a tutorial model that demonstrates how to use mesh parameters such as minimum element size, resolution of curvature, resolution of narrow regions, and maximum element growth rate.The instructions also detail how to access the mesh statistics and how to create a mesh plot.');

model.mesh.clearMeshes;

model.label('piston_mesh.mph');

model.modelNode.label('Components');

out = model;
