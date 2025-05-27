function out = model
%
% pacemaker_electrode_geom_sequence.m
%
% Model exported on May 26 2025, 21:26 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/COMSOL_Multiphysics/Electromagnetics');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 3);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.geom('geom1').create('wp1', 'WorkPlane');
model.geom('geom1').feature('wp1').set('unite', true);
model.geom('geom1').feature('wp1').set('quickplane', 'yz');
model.geom('geom1').feature('wp1').geom.create('r1', 'Rectangle');
model.geom('geom1').feature('wp1').geom.feature('r1').set('size', {'2.1[mm]' '20[mm]'});
model.geom('geom1').feature('wp1').geom.run('r1');
model.geom('geom1').feature('wp1').geom.create('r2', 'Rectangle');
model.geom('geom1').feature('wp1').geom.feature('r2').set('size', {'0.5[mm]' '3[mm]'});
model.geom('geom1').feature('wp1').geom.feature('r2').set('pos', {'1.6[mm]' '12[mm]'});
model.geom('geom1').feature('wp1').geom.run('r2');
model.geom('geom1').feature('wp1').geom.create('dif1', 'Difference');
model.geom('geom1').feature('wp1').geom.feature('dif1').selection('input').set({'r1'});
model.geom('geom1').feature('wp1').geom.feature('dif1').selection('input2').set({'r2'});
model.geom('geom1').feature('wp1').geom.run('dif1');
model.geom('geom1').feature('wp1').geom.create('fil1', 'Fillet');
model.geom('geom1').feature('wp1').geom.feature('fil1').set('radius', '0.5[mm]');
model.geom('geom1').feature('wp1').geom.feature('fil1').selection('point').set('dif1', [5 6 7]);
model.geom('geom1').run('wp1');
model.geom('geom1').feature.create('rev1', 'Revolve');
model.geom('geom1').feature('rev1').set('workplane', 'wp1');
model.geom('geom1').feature('rev1').selection('input').set({'wp1'});
model.geom('geom1').feature('rev1').set('angtype', 'full');
model.geom('geom1').feature('rev1').set('origfaces', false);
model.geom('geom1').selection.create('csel1', 'CumulativeSelection');
model.geom('geom1').selection('csel1').label('Electrode');
model.geom('geom1').feature('rev1').set('contributeto', 'csel1');
model.geom('geom1').run('rev1');
model.geom('geom1').create('sph1', 'Sphere');
model.geom('geom1').feature('sph1').label('Spherical Electrode');
model.geom('geom1').feature('sph1').set('r', '1[mm]');
model.geom('geom1').feature('sph1').set('contributeto', 'csel1');
model.geom('geom1').feature('sph1').set('selresult', true);
model.geom('geom1').feature('sph1').set('selresultshow', 'all');
model.geom('geom1').run('sph1');
model.geom('geom1').create('wp2', 'WorkPlane');
model.geom('geom1').feature('wp2').set('unite', true);
model.geom('geom1').feature('wp2').set('quickplane', 'yz');
model.geom('geom1').feature('wp2').geom.create('r1', 'Rectangle');
model.geom('geom1').feature('wp2').geom.feature('r1').set('size', {'0.5[mm]' '5[mm]'});
model.geom('geom1').feature('wp2').geom.feature('r1').set('pos', {'0.8[mm]' '2[mm]'});
model.geom('geom1').feature('wp2').geom.run('r1');
model.geom('geom1').feature('wp2').geom.create('cha1', 'Chamfer');
model.geom('geom1').feature('wp2').geom.feature('cha1').selection('pointinsketch').set('r1', 3);
model.geom('geom1').feature('wp2').geom.feature('cha1').set('dist', '0.3[mm]');
model.geom('geom1').run('wp2');
model.geom('geom1').feature.create('rev2', 'Revolve');
model.geom('geom1').feature('rev2').set('workplane', 'wp2');
model.geom('geom1').feature('rev2').selection('input').set({'wp2'});
model.geom('geom1').feature('rev2').set('angtype', 'full');
model.geom('geom1').feature('rev2').set('origfaces', false);
model.geom('geom1').feature('rev2').set('pos', {'0.8[mm]' '0'});
model.geom('geom1').run('rev2');

model.view('view1').set('renderwireframe', true);

model.geom('geom1').create('rot1', 'Rotate');
model.geom('geom1').feature('rot1').selection('input').set({'rev2'});
model.geom('geom1').feature('rot1').set('rot', -60);
model.geom('geom1').feature('rot1').set('pos', {'0' '0.8[mm]' '2[mm]'});
model.geom('geom1').feature('rot1').set('axistype', 'x');
model.geom('geom1').run('rot1');
model.geom('geom1').create('rot2', 'Rotate');
model.geom('geom1').feature('rot2').selection('input').set({'rot1'});
model.geom('geom1').feature('rot2').set('rot', 'range(90,360/4,360)');
model.geom('geom1').feature('rot2').set('contributeto', 'csel1');
model.geom('geom1').run('fin');

model.title([]);

model.description('');

model.label('pacemaker_electrode_geom_sequence.mph');

model.modelNode.label('Components');

out = model;
