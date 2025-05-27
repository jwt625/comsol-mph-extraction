function out = model
%
% stl_vertebra_import.m
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
model.geom('geom1').feature('imp1').set('filename', 'c6_vertebra.stl');

model.modelNode.create('mcomp1', 'MeshComponent');

model.geom.create('mgeom1', 3);

model.mesh.create('mpart1', 'mgeom1');

model.geom('geom1').feature('imp1').set('mesh', 'mpart1');

model.mesh('mpart1').create('imp1', 'Import');
model.mesh('mpart1').feature('imp1').set('filename', 'c6_vertebra.stl');
model.mesh('mpart1').feature('imp1').set('createdom', true);

model.geom('geom1').feature('imp1').set('meshfilename', '');

model.mesh('mpart1').run;

model.geom('geom1').feature('imp1').importData;

model.view('view2').set('clippingactive', true);
model.view('view2').clip.create('problem', 'ClipSphere');
model.view('view2').clip('problem').set('position', [6.05144 68.7111 17.4195]);
model.view('view2').clip('problem').set('radius', 1.6446656708916028);
model.view('view2').clip('problem').set('radiusadjustment', 0.8223328354458014);
model.view('view2').clip('problem').set('translationamount', 0.5482218902972009);
model.view('view2').set('clippingactive', true);
model.view('view2').clip.remove('problem');

model.mesh('mpart1').run('imp1');
model.mesh('mpart1').create('join1', 'JoinEntities');
model.mesh('mpart1').feature('join1').selection.all;
model.mesh('mpart1').run('join1');

model.view('view2').set('transparency', false);

model.mesh('mpart1').create('dele1', 'DeleteEntities');
model.mesh('mpart1').feature('dele1').selection.set([2 3]);
model.mesh('mpart1').run('dele1');
model.mesh('mpart1').create('edg1', 'CreateEdges');
model.mesh('mpart1').feature('edg1').set('edgespec', 'meshedge');
model.mesh('mpart1').feature('edg1').setIndex('coordsel', '16.1123332977294921', 0, 0);
model.mesh('mpart1').feature('edg1').setIndex('coordsel', 68.89221191406251, 0, 1);
model.mesh('mpart1').feature('edg1').setIndex('coordsel', '16.724646568298341', 0, 2);
model.mesh('mpart1').feature('edg1').setIndex('coordsel', '16.075530052185061', 1, 0);
model.mesh('mpart1').feature('edg1').setIndex('coordsel', '68.893997192382811', 1, 1);
model.mesh('mpart1').feature('edg1').setIndex('coordsel', '16.8471155166625981', 1, 2);
model.mesh('mpart1').feature('edg1').setIndex('coordsel', '16.074869155883791', 2, 0);
model.mesh('mpart1').feature('edg1').setIndex('coordsel', '68.781200408935551', 2, 1);
model.mesh('mpart1').feature('edg1').setIndex('coordsel', '16.9049377441406251', 2, 2);
model.mesh('mpart1').feature('edg1').setIndex('coordsel', '16.1061334609985351', 3, 0);
model.mesh('mpart1').feature('edg1').setIndex('coordsel', '68.697525024414061', 3, 1);
model.mesh('mpart1').feature('edg1').setIndex('coordsel', '16.870072364807131', 3, 2);
model.mesh('mpart1').feature('edg1').setIndex('coordsel', '16.144799232482911', 4, 0);
model.mesh('mpart1').feature('edg1').setIndex('coordsel', '68.65648269653321', 4, 1);
model.mesh('mpart1').feature('edg1').setIndex('coordsel', '16.7927761077880861', 4, 2);
model.mesh('mpart1').feature('edg1').setIndex('coordsel', '16.1680898666381841', 5, 0);
model.mesh('mpart1').feature('edg1').setIndex('coordsel', '68.611873626708981', 5, 1);
model.mesh('mpart1').feature('edg1').setIndex('coordsel', '16.7496833801269531', 5, 2);
model.mesh('mpart1').feature('edg1').setIndex('coordsel', '16.1896190643310551', 6, 0);
model.mesh('mpart1').feature('edg1').setIndex('coordsel', '68.559329986572271', 6, 1);
model.mesh('mpart1').feature('edg1').setIndex('coordsel', '16.7106685638427731', 6, 2);
model.mesh('mpart1').feature('edg1').setIndex('coordsel', '16.1738138198852541', 7, 0);
model.mesh('mpart1').feature('edg1').setIndex('coordsel', '68.807704925537111', 7, 1);
model.mesh('mpart1').feature('edg1').setIndex('coordsel', '16.5540437698364261', 7, 2);
model.mesh('mpart1').feature('edg1').setIndex('coordsel', '16.2081689834594731', 8, 0);
model.mesh('mpart1').feature('edg1').setIndex('coordsel', '68.72592926025391', 8, 1);
model.mesh('mpart1').feature('edg1').setIndex('coordsel', '16.493195533752441', 8, 2);
model.mesh('mpart1').feature('edg1').setIndex('coordsel', '16.2138319015502931', 9, 0);
model.mesh('mpart1').feature('edg1').setIndex('coordsel', '68.644325256347661', 9, 1);
model.mesh('mpart1').feature('edg1').setIndex('coordsel', '16.5309858322143551', 9, 2);
model.mesh('mpart1').feature('edg1').setIndex('coordsel', '16.2107267379760741', 10, 0);
model.mesh('mpart1').feature('edg1').setIndex('coordsel', '68.598922729492191', 10, 1);
model.mesh('mpart1').feature('edg1').setIndex('coordsel', '16.5686893463134771', 10, 2);
model.mesh('mpart1').feature('edg1').setIndex('coordsel', '16.203117370605471', 11, 0);
model.mesh('mpart1').feature('edg1').setIndex('coordsel', '68.558650970458981', 11, 1);
model.mesh('mpart1').feature('edg1').setIndex('coordsel', '16.643013000488281', 11, 2);
model.mesh('mpart1').run('edg1');
model.mesh('mpart1').create('dele2', 'DeleteEntities');
model.mesh('mpart1').feature('dele2').selection.set([2]);
model.mesh('mpart1').run('dele2');
model.mesh('mpart1').create('fac1', 'CreateFaces');
model.mesh('mpart1').feature('fac1').set('createdom', true);
model.mesh('mpart1').feature('fac1').selection.add([1]);
model.mesh('mpart1').feature('fac1').set('createdom', false);
model.mesh('mpart1').run('fac1');
model.mesh('mpart1').create('join2', 'JoinEntities');
model.mesh('mpart1').feature('join2').selection.set([1 2]);
model.mesh('mpart1').run('join2');

model.modelNode('mcomp1').baseSystem([]);

model.geom('mgeom1').lengthUnit('mm');

model.mesh('mpart1').run;

model.geom('geom1').lengthUnit('mm');
model.geom('geom1').run('imp1');
model.geom('geom1').create('rot1', 'Rotate');
model.geom('geom1').feature('rot1').selection('input').set({'imp1'});
model.geom('geom1').feature('rot1').set('axistype', 'x');
model.geom('geom1').feature('rot1').set('rot', 90);
model.geom('geom1').run('rot1');
model.geom('geom1').create('rot2', 'Rotate');
model.geom('geom1').feature('rot2').selection('input').set({'rot1'});
model.geom('geom1').feature('rot2').set('rot', -90);
model.geom('geom1').run('rot2');
model.geom('geom1').create('blk1', 'Block');
model.geom('geom1').feature('blk1').set('size', {'23[mm]' '15[mm]' '1'});
model.geom('geom1').feature('blk1').setIndex('size', '15[mm]', 2);
model.geom('geom1').feature('blk1').set('pos', {'-22[mm]' '-11.1[mm]' '0'});
model.geom('geom1').feature('blk1').setIndex('pos', '60[mm]', 2);
model.geom('geom1').run('blk1');
model.geom('geom1').create('par1', 'Partition');
model.geom('geom1').feature('par1').selection('input').set({'blk1'});
model.geom('geom1').feature('par1').selection('tool').set({'rot2'});
model.geom('geom1').run('par1');

model.view('view1').set('transparency', true);

model.geom('geom1').run('fin');

model.mesh('mesh1').run;
model.mesh('mesh1').automatic(false);
model.mesh('mesh1').run('size');
model.mesh('mesh1').create('ftri1', 'FreeTri');
model.mesh('mesh1').feature('ftri1').selection.set([6]);
model.mesh('mesh1').feature('ftri1').create('size1', 'Size');
model.mesh('mesh1').feature('ftri1').feature('size1').set('custom', true);
model.mesh('mesh1').feature('ftri1').feature('size1').set('hmaxactive', true);
model.mesh('mesh1').feature('ftri1').feature('size1').set('hmax', '0.7[mm]');
model.mesh('mesh1').feature('ftri1').feature('size1').set('hminactive', true);
model.mesh('mesh1').feature('ftri1').feature('size1').set('hmin', '0.5[mm]');
model.mesh('mesh1').run;

model.view('view1').set('transparency', false);
model.view('view1').hideEntities.create('hide1');
model.view('view1').hideEntities('hide1').geom(2);
model.view('view1').hideEntities('hide1').add([4]);
model.view('view1').hideEntities('hide1').add([2]);
model.view('view1').hideEntities('hide1').add([1]);

model.modelNode.create('comp2', true);

model.geom.create('geom2', 3);
model.geom('geom2').model('comp2');
model.geom('geom2').lengthUnit('mm');

model.mesh.create('mesh2', 'geom2');

model.geom('geom2').create('imp1', 'Import');
model.geom('geom2').feature('imp1').set('mesh', 'mpart1');
model.geom('geom2').run('imp1');
model.geom('geom2').run;

model.mesh('mesh2').create('ftri1', 'FreeTri');
model.mesh('mesh2').feature('ftri1').selection.set([1]);
model.mesh('mesh2').run('ftri1');
model.mesh('mesh2').create('ref1', 'Refine');
model.mesh('mesh2').feature('ref1').set('rmethod', 'regular');
model.mesh('mesh2').feature('ref1').set('numrefine', 2);
model.mesh('mesh2').run('ref1');

model.result.dataset.create('mesh2', 'Mesh');
model.result.dataset('mesh2').set('mesh', 'mesh2');
model.result.create('pg1', 'PlotGroup3D');
model.result('pg1').label('Mesh Plot 1');
model.result('pg1').set('data', 'mesh2');
model.result('pg1').set('inherithide', true);
model.result('pg1').set('showlegendsmaxmin', true);
model.result('pg1').create('mesh2', 'Mesh');
model.result('pg1').feature('mesh2').set('colortable', 'TrafficFlow');
model.result('pg1').feature('mesh2').set('colortabletrans', 'nonlinear');
model.result('pg1').feature('mesh2').set('nonlinearcolortablerev', true);
model.result('pg1').run;
model.result('pg1').feature('mesh2').set('filteractive', true);
model.result('pg1').feature('mesh2').set('logfilterexpr', 'x>11[mm]');
model.result('pg1').run;
model.result.dataset('mesh2').set('sorder', 'quadratic');
model.result.dataset.duplicate('mesh3', 'mesh2');
model.result.dataset('mesh3').set('mesh', 'mpart1');
model.result('pg1').run;
model.result('pg1').feature.duplicate('mesh3', 'mesh2');
model.result('pg1').run;
model.result('pg1').feature('mesh3').set('data', 'mesh3');
model.result('pg1').feature('mesh3').set('elemcolor', 'gray');
model.result('pg1').run;

model.geom('geom2').feature('imp1').set('simplifytol', 0.02);
model.geom('geom2').runPre('fin');
model.geom('geom2').run;

model.mesh('mesh2').run;

model.result('pg1').run;

model.geom('geom2').feature('imp1').set('simplifytol', 0.001);
model.geom('geom2').runPre('fin');
model.geom('geom2').run;

model.mesh('mesh2').run;

model.result('pg1').run;

model.title(['STL Import 1 ' native2unicode(hex2dec({'20' '14'}), 'unicode') ' Generating a Geometry from an Imported Mesh']);

model.description('This tutorial demonstrates how to import and create a geometry from a surface mesh saved in the STL format. The instructions detail how to remove isolated faces from the imported STL mesh, how to use the geometry import parameters, and how to create volumes for simulation both on the inside and the outside of the imported geometric object.');

model.mesh('mesh1').clearMesh;
model.mesh('mpart1').clearMesh;
model.mesh('mesh2').clearMesh;

model.label('stl_vertebra_import.mph');

model.modelNode.label('Components');

out = model;
