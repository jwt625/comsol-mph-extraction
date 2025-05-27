function out = model
%
% stl_vertebra_mesh_import.m
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

model.geom('geom1').lengthUnit('mm');
model.geom('geom1').run;

model.mesh('mesh1').create('imp1', 'Import');
model.mesh('mesh1').feature('imp1').set('filename', 'c2_vertebra.stl');
model.mesh('mesh1').feature('imp1').set('createdom', true);
model.mesh('mesh1').feature('imp1').set('facepartition', 'minimal');
model.mesh('mesh1').feature('imp1').importData;

model.view('view1').set('rendermesh', true);

model.mesh('mesh1').feature('imp1').set('stltoltype', 'absolute');
model.mesh('mesh1').feature('imp1').set('stltolabs', '1e-4[mm]');
model.mesh('mesh1').feature('imp1').setIndex('outsel_bnd', 'Vertebra boundary', 0);
model.mesh('mesh1').feature('imp1').importData;
model.mesh('mesh1').feature('imp1').create('tr1', 'Transform');
model.mesh('mesh1').feature('imp1').feature('tr1').set('displ', {'-10[mm]' '-90[mm]' '0'});
model.mesh('mesh1').feature('imp1').feature('tr1').setIndex('displ', '-10[mm]', 2);
model.mesh('mesh1').run('imp1');
model.mesh('mesh1').create('fill1', 'FillHoles');
model.mesh('mesh1').feature('fill1').set('createdom', true);
model.mesh('mesh1').feature('fill1').selection.named('imp1_COMSOL_mesh_mesh1');
model.mesh('mesh1').run('fill1');
model.mesh('mesh1').measure.selection.geom(1);
model.mesh('mesh1').measure.selection.set([1]);
model.mesh('mesh1').feature('fill1').set('fillholestol', 'manual');
model.mesh('mesh1').feature('fill1').set('perimeter', '2.3[mm]');
model.mesh('mesh1').run('fill1');

model.geom('geom1').create('blk1', 'Block');

model.mesh('mesh1').create('imp2', 'Import');
model.mesh('mesh1').feature('imp2').set('source', 'geom');
model.mesh('mesh1').feature('imp2').set('geom', 'geom1');

model.geom('geom1').feature('blk1').set('size', {'30[mm]' '20[mm]' '1'});
model.geom('geom1').feature('blk1').setIndex('size', '25[mm]', 2);
model.geom('geom1').feature('blk1').set('base', 'center');
model.geom('geom1').run('blk1');

model.mesh('mesh1').run('imp2');

model.view('view1').set('transparency', true);

model.mesh('mesh1').stat.setQualityMeasure('skewness');
model.mesh('mesh1').stat.selection.geom('geom1', 2);
model.mesh('mesh1').stat.selection.all;
model.mesh('mesh1').create('pln1', 'IntersectPlane');
model.mesh('mesh1').feature('pln1').set('quickplane', 'yz');
model.mesh('mesh1').feature('pln1').set('toltype', 'absolute');
model.mesh('mesh1').feature('pln1').set('selbelow', true);
model.mesh('mesh1').run('pln1');
model.mesh('mesh1').create('dele1', 'DeleteEntities');
model.mesh('mesh1').feature('dele1').selection.named('pln1_dombelow');
model.mesh('mesh1').run('dele1');

model.view('view1').set('transparency', false);
model.view('view1').hideMesh.create('hide1');
model.view('view1').hideMesh('hide1').mesh('mesh1');
model.view('view1').hideMesh('hide1').geom(2);
model.view('view1').hideMesh('hide1').add([4]);
model.view('view1').hideMesh('hide1').add([6]);
model.view('view1').hideMesh('hide1').add([8]);

model.mesh('mesh1').create('remf1', 'RemeshFaces');
model.mesh('mesh1').feature('remf1').selection.all;
model.mesh('mesh1').feature('remf1').feature('size').set('custom', true);
model.mesh('mesh1').feature('remf1').feature('size').set('hmin', 0.1);
model.mesh('mesh1').run('remf1');
model.mesh('mesh1').create('ftet1', 'FreeTet');
model.mesh('mesh1').run('ftet1');
model.mesh('mesh1').stat.selection.geom(3);
model.mesh('mesh1').stat.selection.set([1 2]);
model.mesh('mesh1').stat.setQualityMeasure('skewness');

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
model.result('pg1').feature('mesh1').set('elemcolor', 'white');
model.result('pg1').feature('mesh1').set('filteractive', true);
model.result('pg1').feature('mesh1').set('logfilterexpr', 'x>1[mm]');
model.result('pg1').run;
model.result('pg1').feature('mesh1').create('sel1', 'MeshSelection');

model.mesh('mesh1').run;

model.result('pg1').feature('mesh1').feature('sel1').selection.set([2]);
model.result('pg1').run;
model.result('pg1').run;
model.result('pg1').feature.duplicate('mesh2', 'mesh1');
model.result('pg1').run;
model.result('pg1').run;
model.result('pg1').feature('mesh2').feature('sel1').selection.set([1]);
model.result('pg1').run;
model.result('pg1').feature('mesh2').set('elemcolor', 'cyan');
model.result('pg1').feature('mesh2').set('logfilterexpr', 'y>1[mm]');
model.result('pg1').feature('mesh2').set('elemscale', 0.8);
model.result('pg1').run;
model.result('pg1').run;
model.result('pg1').set('edges', false);
model.result('pg1').run;
model.result.dataset('mesh1').set('sorder', 'quadratic');
model.result('pg1').run;
model.result('pg1').feature('mesh1').set('nodepoints', 'geom');
model.result('pg1').run;
model.result('pg1').run;
model.result('pg1').set('edges', true);
model.result('pg1').run;
model.result('pg1').run;
model.result('pg1').feature('mesh1').set('nodepoints', 'none');

model.title(['STL Import 2 ' native2unicode(hex2dec({'20' '14'}), 'unicode') ' Remeshing an Imported Mesh']);

model.description('This tutorial demonstrates how to combine two imported surface meshes and create a simulation mesh without generating a geometry from the mesh. The instructions detail how to repair holes in an imported STL mesh of a vertebra, how to import another mesh for simulation both on the inside and the outside of the imported vertebra, how to intersect and connect the meshes, remesh the surface mesh, create domains, and generate a tetrahedral mesh for simulation.');

model.label('stl_vertebra_mesh_import.mph');

model.modelNode.label('Components');

out = model;
