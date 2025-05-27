function out = model
%
% composite_cylinder_buckling_material.m
%
% Model exported on May 26 2025, 21:27 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/Composite_Materials_Module/Buckling');

model.material.create('lmat1', 'LayerShell', '');
model.material.create('mat1', 'Common', '');
model.material('lmat1').setIndex('link', 'mat1', 0);

model.modelNode.create('comp1', true);

model.geom.create('geom1', 3);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.geom('geom1').create('blk1', 'Block');

model.physics.create('shell', 'Shell', 'geom1');
model.physics('shell').model('comp1');

model.geom('geom1').run;

model.material.create('llmat1', 'ShellLink', 'comp1');

model.physics('shell').feature('emm1').set('SolidModel', 'Orthotropic');
model.physics('shell').create('llem1', 'LayeredElastic', 2);
model.physics('shell').feature('llem1').selection.all;
model.physics('shell').feature('llem1').set('SolidModel', 'Orthotropic');

model.material('mat1').propertyGroup.create('Orthotropic', 'Orthotropic');
model.material('mat1').propertyGroup('Orthotropic').set('Evector', {'134e9' '9.2e9' '9.2e9'});
model.material('mat1').propertyGroup('Orthotropic').set('nuvector', {'0.28' '0.28' '0.28'});
model.material('mat1').propertyGroup('Orthotropic').set('Gvector', {'4.8e9' '4.8e9' '4.8e9'});
model.material('mat1').propertyGroup('def').set('density', {'1700'});
model.material('mat1').label('Material: Carbon-Epoxy');
model.material('lmat1').label('Layered Material: [0/0/45/-45]_s');
model.material('lmat1').setIndex('thickness', '0.125[mm]', 0);
model.material('lmat1').setIndex('layername', 'Layer 2', 1);
model.material('lmat1').setIndex('link', 'mat1', 1);
model.material('lmat1').setIndex('rotation', '0.0', 1);
model.material('lmat1').setIndex('thickness', '0.125[mm]', 1);
model.material('lmat1').setIndex('meshPoints', 2, 1);
model.material('lmat1').setIndex('tag', 'lmat1_2', 1);
model.material('lmat1').setIndex('layername', 'Layer 2', 1);
model.material('lmat1').setIndex('link', 'mat1', 1);
model.material('lmat1').setIndex('rotation', '0.0', 1);
model.material('lmat1').setIndex('thickness', '0.125[mm]', 1);
model.material('lmat1').setIndex('meshPoints', 2, 1);
model.material('lmat1').setIndex('tag', 'lmat1_2', 1);
model.material('lmat1').setIndex('layername', 'Layer 3', 2);
model.material('lmat1').setIndex('link', 'mat1', 2);
model.material('lmat1').setIndex('rotation', '0.0', 2);
model.material('lmat1').setIndex('thickness', '0.125[mm]', 2);
model.material('lmat1').setIndex('meshPoints', 2, 2);
model.material('lmat1').setIndex('tag', 'lmat1_3', 2);
model.material('lmat1').setIndex('layername', 'Layer 3', 2);
model.material('lmat1').setIndex('link', 'mat1', 2);
model.material('lmat1').setIndex('rotation', '0.0', 2);
model.material('lmat1').setIndex('thickness', '0.125[mm]', 2);
model.material('lmat1').setIndex('meshPoints', 2, 2);
model.material('lmat1').setIndex('tag', 'lmat1_3', 2);
model.material('lmat1').setIndex('layername', 'Layer 4', 3);
model.material('lmat1').setIndex('link', 'mat1', 3);
model.material('lmat1').setIndex('rotation', '0.0', 3);
model.material('lmat1').setIndex('thickness', '0.125[mm]', 3);
model.material('lmat1').setIndex('meshPoints', 2, 3);
model.material('lmat1').setIndex('tag', 'lmat1_4', 3);
model.material('lmat1').setIndex('layername', 'Layer 4', 3);
model.material('lmat1').setIndex('link', 'mat1', 3);
model.material('lmat1').setIndex('rotation', '0.0', 3);
model.material('lmat1').setIndex('thickness', '0.125[mm]', 3);
model.material('lmat1').setIndex('meshPoints', 2, 3);
model.material('lmat1').setIndex('tag', 'lmat1_4', 3);
model.material('lmat1').setIndex('layername', 'Layer 5', 4);
model.material('lmat1').setIndex('link', 'mat1', 4);
model.material('lmat1').setIndex('rotation', '0.0', 4);
model.material('lmat1').setIndex('thickness', '0.125[mm]', 4);
model.material('lmat1').setIndex('meshPoints', 2, 4);
model.material('lmat1').setIndex('tag', 'lmat1_5', 4);
model.material('lmat1').setIndex('layername', 'Layer 5', 4);
model.material('lmat1').setIndex('link', 'mat1', 4);
model.material('lmat1').setIndex('rotation', '0.0', 4);
model.material('lmat1').setIndex('thickness', '0.125[mm]', 4);
model.material('lmat1').setIndex('meshPoints', 2, 4);
model.material('lmat1').setIndex('tag', 'lmat1_5', 4);
model.material('lmat1').setIndex('layername', 'Layer 6', 5);
model.material('lmat1').setIndex('link', 'mat1', 5);
model.material('lmat1').setIndex('rotation', '0.0', 5);
model.material('lmat1').setIndex('thickness', '0.125[mm]', 5);
model.material('lmat1').setIndex('meshPoints', 2, 5);
model.material('lmat1').setIndex('tag', 'lmat1_6', 5);
model.material('lmat1').setIndex('layername', 'Layer 6', 5);
model.material('lmat1').setIndex('link', 'mat1', 5);
model.material('lmat1').setIndex('rotation', '0.0', 5);
model.material('lmat1').setIndex('thickness', '0.125[mm]', 5);
model.material('lmat1').setIndex('meshPoints', 2, 5);
model.material('lmat1').setIndex('tag', 'lmat1_6', 5);
model.material('lmat1').setIndex('layername', 'Layer 7', 6);
model.material('lmat1').setIndex('link', 'mat1', 6);
model.material('lmat1').setIndex('rotation', '0.0', 6);
model.material('lmat1').setIndex('thickness', '0.125[mm]', 6);
model.material('lmat1').setIndex('meshPoints', 2, 6);
model.material('lmat1').setIndex('tag', 'lmat1_7', 6);
model.material('lmat1').setIndex('layername', 'Layer 7', 6);
model.material('lmat1').setIndex('link', 'mat1', 6);
model.material('lmat1').setIndex('rotation', '0.0', 6);
model.material('lmat1').setIndex('thickness', '0.125[mm]', 6);
model.material('lmat1').setIndex('meshPoints', 2, 6);
model.material('lmat1').setIndex('tag', 'lmat1_7', 6);
model.material('lmat1').setIndex('layername', 'Layer 8', 7);
model.material('lmat1').setIndex('link', 'mat1', 7);
model.material('lmat1').setIndex('rotation', '0.0', 7);
model.material('lmat1').setIndex('thickness', '0.125[mm]', 7);
model.material('lmat1').setIndex('meshPoints', 2, 7);
model.material('lmat1').setIndex('tag', 'lmat1_8', 7);
model.material('lmat1').setIndex('layername', 'Layer 8', 7);
model.material('lmat1').setIndex('link', 'mat1', 7);
model.material('lmat1').setIndex('rotation', '0.0', 7);
model.material('lmat1').setIndex('thickness', '0.125[mm]', 7);
model.material('lmat1').setIndex('meshPoints', 2, 7);
model.material('lmat1').setIndex('tag', 'lmat1_8', 7);
model.material('lmat1').setIndex('rotation', '45.0', 2);
model.material('lmat1').setIndex('rotation', '-45.0', 3);
model.material('lmat1').setIndex('rotation', '-45.0', 4);
model.material('lmat1').setIndex('rotation', '45.0', 5);
model.material('lmat1').setIndex('rotation', 0, 0);
model.material('lmat1').setIndex('rotation', 0, 1);
model.material('lmat1').setIndex('rotation', 45, 2);
model.material('lmat1').setIndex('rotation', -45, 3);
model.material('lmat1').setIndex('rotation', -45, 4);
model.material('lmat1').setIndex('rotation', 45, 5);
model.material('lmat1').setIndex('rotation', 0, 6);
model.material('lmat1').setIndex('rotation', 0, 7);
model.material('lmat1').setIndex('meshPoints', 1, 0);
model.material('lmat1').setIndex('meshPoints', 1, 1);
model.material('lmat1').setIndex('meshPoints', 1, 2);
model.material('lmat1').setIndex('meshPoints', 1, 3);
model.material('lmat1').setIndex('meshPoints', 1, 4);
model.material('lmat1').setIndex('meshPoints', 1, 5);
model.material('lmat1').setIndex('meshPoints', 1, 6);
model.material('lmat1').setIndex('meshPoints', 1, 7);
model.material.move('mat1', 0);

model.modelNode.remove('comp1');

model.material('lmat1').set('widthRatio', 0.4);

model.label('composite_cylinder_buckling_material.mph');

model.material('lmat1').set('widthRatio', 0.6);

model.label('composite_cylinder_buckling_material.mph');

model.material('mat1').propertyGroup.remove('Orthotropic');
model.material('mat1').propertyGroup.create('TransverseIsotropic', 'Transversely_isotropic');
model.material('mat1').propertyGroup('TransverseIsotropic').set('Evect', {'134e9' '9.2e9'});
model.material('mat1').propertyGroup('TransverseIsotropic').set('nuvect', {'0.28' '0.28'});
model.material('mat1').propertyGroup('TransverseIsotropic').set('Gvect1', {'4.8e9'});

model.label('composite_cylinder_buckling_material.mph');

model.modelNode.label('Components');

out = model;
