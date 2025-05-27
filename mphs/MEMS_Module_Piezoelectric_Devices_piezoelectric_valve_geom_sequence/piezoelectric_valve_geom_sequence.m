function out = model
%
% piezoelectric_valve_geom_sequence.m
%
% Model exported on May 26 2025, 21:30 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/MEMS_Module/Piezoelectric_Devices');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 2);
model.geom('geom1').model('comp1');
model.geom('geom1').axisymmetric(true);

model.mesh.create('mesh1', 'geom1');

model.param.set('t0', '0.05[mm]');
model.param.descr('t0', 'Piezoelectric layer thickness');
model.param.set('ID', '7[mm]');
model.param.descr('ID', 'Disc actuator inner diameter');
model.param.set('OD', '50[mm]');
model.param.descr('OD', 'Disc actuator outer diameter');
model.param.set('n', '12');
model.param.descr('n', 'Number of layers in actuator');
model.param.set('ts', '0.2[mm]');
model.param.descr('ts', 'Thickness of seal');
model.param.set('w0', '0.5[mm]');
model.param.descr('w0', 'Through hole dimension');
model.param.set('w1', 'ID/2');
model.param.descr('w1', 'Clamp region dimension');
model.param.set('w2', 'ID/4');
model.param.descr('w2', 'Overall clamp dimension');
model.param.set('h0', '5*t0*n');
model.param.descr('h0', 'Base thickness');
model.param.set('deltaz', '16[um]');
model.param.descr('deltaz', 'Contact offset at 0[V]');

model.geom('geom1').create('r1', 'Rectangle');
model.geom('geom1').feature('r1').set('size', {'(OD-ID)/2' 't0'});
model.geom('geom1').feature('r1').set('pos', {'ID/2' 'ts'});
model.geom('geom1').feature('r1').set('layerleft', true);
model.geom('geom1').feature('r1').set('layerbottom', false);
model.geom('geom1').feature('r1').setIndex('layer', '0.5*w0', 0);
model.geom('geom1').feature('r1').setIndex('layer', '3*w0', 1);
model.geom('geom1').run('r1');
model.geom('geom1').create('arr1', 'Array');
model.geom('geom1').feature('arr1').set('fullsize', {'1' 'n'});
model.geom('geom1').feature('arr1').set('displ', {'0' 't0'});
model.geom('geom1').feature('arr1').selection('input').set({'r1'});
model.geom('geom1').run('arr1');
model.geom('geom1').create('r2', 'Rectangle');
model.geom('geom1').feature('r2').set('size', {'3*w0' 'ts'});
model.geom('geom1').feature('r2').set('pos', {'ID/2+0.5*w0' '0'});
model.geom('geom1').run('r2');
model.geom('geom1').create('fil1', 'Fillet');
model.geom('geom1').feature('fil1').selection('point').set('r2', [1 2]);
model.geom('geom1').feature('fil1').set('radius', 'ts/3');
model.geom('geom1').run('fil1');
model.geom('geom1').create('r3', 'Rectangle');
model.geom('geom1').feature('r3').set('size', {'2*w0' '2*w0+h0'});
model.geom('geom1').feature('r3').set('pos', {'ID/2-0.5*w0' '0'});
model.geom('geom1').feature('r3').setIndex('pos', '-2*w0-deltaz-h0', 1);
model.geom('geom1').run('r3');
model.geom('geom1').create('cha1', 'Chamfer');
model.geom('geom1').feature('cha1').selection('point').set('r3', 4);
model.geom('geom1').feature('cha1').set('dist', '1.8*w0');
model.geom('geom1').run('cha1');
model.geom('geom1').create('fil2', 'Fillet');
model.geom('geom1').feature('fil2').selection('point').set('cha1', [3 5]);
model.geom('geom1').feature('fil2').set('radius', '0.1*w0');
model.geom('geom1').run('fil2');
model.geom('geom1').create('pol1', 'Polygon');
model.geom('geom1').feature('pol1').set('source', 'table');
model.geom('geom1').feature('pol1').setIndex('table', 'ID/2+1.2*w0', 0, 0);
model.geom('geom1').feature('pol1').setIndex('table', 0, 0, 1);
model.geom('geom1').feature('pol1').setIndex('table', 'ID/2+1.6*w0', 1, 0);
model.geom('geom1').feature('pol1').setIndex('table', 0, 1, 1);
model.geom('geom1').run('pol1');
model.geom('geom1').create('mir1', 'Mirror');
model.geom('geom1').feature('mir1').selection('input').set({'fil2' 'pol1'});
model.geom('geom1').feature('mir1').set('keep', true);
model.geom('geom1').feature('mir1').set('pos', {'ID/2+2*w0' '0'});
model.geom('geom1').run('mir1');
model.geom('geom1').create('r4', 'Rectangle');
model.geom('geom1').feature('r4').set('size', {'ID/2+1.5*w0' '1'});
model.geom('geom1').feature('r4').setIndex('size', 'h0', 1);
model.geom('geom1').feature('r4').set('pos', {'0' '-2*w0-deltaz-h0'});
model.geom('geom1').run('r4');
model.geom('geom1').create('r5', 'Rectangle');
model.geom('geom1').feature('r5').set('size', {'OD/2+w1-ID/2-2.5*w0' '1'});
model.geom('geom1').feature('r5').setIndex('size', 'h0', 1);
model.geom('geom1').feature('r5').set('pos', {'ID/2+2.5*w0' '0'});
model.geom('geom1').feature('r5').setIndex('pos', '-2*w0-deltaz-h0', 1);
model.geom('geom1').run('r5');
model.geom('geom1').create('r6', 'Rectangle');
model.geom('geom1').feature('r6').set('size', {'w2+w1' 'h0+4*w0+n*t0+deltaz'});
model.geom('geom1').feature('r6').set('pos', {'OD/2-w2' '-2*w0-deltaz-h0'});
model.geom('geom1').run('r6');

model.title([]);

model.description('');

model.label('piezoelectric_valve_geom_sequence.mph');

model.modelNode.label('Components');

out = model;
