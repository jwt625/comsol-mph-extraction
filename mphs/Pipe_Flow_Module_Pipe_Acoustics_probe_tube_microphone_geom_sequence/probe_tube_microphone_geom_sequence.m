function out = model
%
% probe_tube_microphone_geom_sequence.m
%
% Model exported on May 26 2025, 21:31 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/Pipe_Flow_Module/Pipe_Acoustics');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 3);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.param.set('L', '20[mm]');
model.param.descr('L', 'Probe tube length');
model.param.set('R', '5[mm]');
model.param.descr('R', 'Microphone casing radius');
model.param.set('H', '5[mm]');
model.param.descr('H', 'Probe tube volume height');
model.param.set('dr', '1[mm]');
model.param.descr('dr', 'Pipe inner radius');
model.param.set('dw', '0.3[mm]');
model.param.descr('dw', 'Pipe wall thickness');

model.geom('geom1').create('cone1', 'Cone');
model.geom('geom1').feature('cone1').set('specifytop', 'radius');
model.geom('geom1').feature('cone1').set('r', 'R');
model.geom('geom1').feature('cone1').set('h', 'H');
model.geom('geom1').feature('cone1').set('rtop', 'dr+dw');
model.geom('geom1').run('cone1');
model.geom('geom1').create('cyl1', 'Cylinder');
model.geom('geom1').feature('cyl1').set('r', 'R');
model.geom('geom1').feature('cyl1').set('h', 'H');
model.geom('geom1').feature('cyl1').set('pos', {'0' '0' '-H'});
model.geom('geom1').run('cyl1');
model.geom('geom1').create('pol1', 'Polygon');
model.geom('geom1').feature('pol1').set('source', 'vectors');
model.geom('geom1').feature('pol1').set('x', '0 0');
model.geom('geom1').feature('pol1').set('y', '0 0');
model.geom('geom1').feature('pol1').set('z', 'H H+L');
model.geom('geom1').run('pol1');
model.geom('geom1').create('cyl2', 'Cylinder');
model.geom('geom1').feature('cyl2').set('r', '10[mm]');
model.geom('geom1').feature('cyl2').set('h', '35[mm]');
model.geom('geom1').feature('cyl2').set('pos', {'0' '0' '-H'});
model.geom('geom1').run('cyl2');
model.geom('geom1').create('wp1', 'WorkPlane');
model.geom('geom1').feature('wp1').set('unite', true);
model.geom('geom1').feature('wp1').set('planetype', 'faceparallel');
model.geom('geom1').feature('wp1').selection('face').set('cone1', 4);
model.geom('geom1').feature('wp1').geom.create('c1', 'Circle');
model.geom('geom1').feature('wp1').geom.feature('c1').set('r', 'dr');
model.geom('geom1').run('fin');

model.title([]);

model.description('');

model.label('probe_tube_microphone_geom_sequence.mph');

model.modelNode.label('Components');

out = model;
