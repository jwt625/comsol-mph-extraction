function out = model
%
% demultiplexer_shape_optimization_geom_sequence.m
%
% Model exported on May 26 2025, 21:25 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/Acoustics_Module/Optimization');

model.param.set('L', '20[cm]');
model.param.descr('L', 'Domain diameter');
model.param.set('L1', '0.05*L');
model.param.descr('L1', 'Port width');
model.param.set('Lperiod', '0.09*L');
model.param.descr('Lperiod', 'Hole period');
model.param.set('Rhole', '0.5*Lperiod');
model.param.descr('Rhole', 'Hole radius');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 2);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.geom('geom1').create('c1', 'Circle');
model.geom('geom1').feature('c1').set('r', 'L/2');
model.geom('geom1').run('c1');
model.geom('geom1').create('r1', 'Rectangle');
model.geom('geom1').feature('r1').set('size', {'3*L1' 'L1'});
model.geom('geom1').feature('r1').set('base', 'center');
model.geom('geom1').feature('r1').set('pos', {'-L/2-L1*1.45' '0'});
model.geom('geom1').feature('r1').set('selresult', true);
model.geom('geom1').run('r1');
model.geom('geom1').create('rot1', 'Rotate');
model.geom('geom1').feature('rot1').selection('input').named('r1');
model.geom('geom1').feature('rot1').set('keep', true);
model.geom('geom1').feature('rot1').set('rot', '120 -120');
model.geom('geom1').run('rot1');
model.geom('geom1').create('uni1', 'Union');
model.geom('geom1').feature('uni1').set('intbnd', false);
model.geom('geom1').feature('uni1').set('selresult', true);
model.geom('geom1').feature('uni1').selection('input').set({'c1' 'r1' 'rot1'});
model.geom('geom1').run('uni1');
model.geom('geom1').create('c2', 'Circle');
model.geom('geom1').feature('c2').set('r', 'Rhole');
model.geom('geom1').feature('c2').set('selresult', true);
model.geom('geom1').run('c2');
model.geom('geom1').create('mov1', 'Move');
model.geom('geom1').feature('mov1').selection('input').named('c2');
model.geom('geom1').feature('mov1').set('keep', true);
model.geom('geom1').feature('mov1').set('displx', '2*Lperiod*sin(pi/3)');
model.geom('geom1').feature('mov1').set('disply', '2*Lperiod*cos(pi/3)');
model.geom('geom1').run('mov1');
model.geom('geom1').create('arr1', 'Array');
model.geom('geom1').feature('arr1').selection('input').named('c2');
model.geom('geom1').feature('arr1').set('fullsize', {'round(0.5*L/Lperiod)' '1'});
model.geom('geom1').feature('arr1').setIndex('fullsize', 'round(0.5*L/Lperiod)', 1);
model.geom('geom1').feature('arr1').set('displ', {'4*Lperiod*sin(pi/3)' '0'});
model.geom('geom1').feature('arr1').setIndex('displ', '2*Lperiod', 1);
model.geom('geom1').run('arr1');
model.geom('geom1').create('mir1', 'Mirror');
model.geom('geom1').feature('mir1').selection('input').named('c2');
model.geom('geom1').feature('mir1').set('keep', true);
model.geom('geom1').run('mir1');
model.geom('geom1').create('mir2', 'Mirror');
model.geom('geom1').feature('mir2').selection('input').named('c2');
model.geom('geom1').feature('mir2').set('keep', true);
model.geom('geom1').feature('mir2').set('axis', [0 1]);
model.geom('geom1').run('mir2');
model.geom('geom1').create('disksel1', 'DiskSelection');
model.geom('geom1').feature('disksel1').set('inputent', 'selections');
model.geom('geom1').feature('disksel1').set('input', {'c2'});
model.geom('geom1').feature('disksel1').set('r', Inf);
model.geom('geom1').feature('disksel1').set('rin', 'L/2-Rhole');
model.geom('geom1').run('disksel1');
model.geom('geom1').create('del1', 'Delete');
model.geom('geom1').feature('del1').selection('input').init(2);
model.geom('geom1').feature('del1').selection('input').named('disksel1');
model.geom('geom1').run('del1');
model.geom('geom1').create('dif1', 'Difference');
model.geom('geom1').feature('dif1').selection('input').named('uni1');
model.geom('geom1').feature('dif1').selection('input2').named('c2');
model.geom('geom1').run('dif1');
model.geom('geom1').create('disksel2', 'DiskSelection');
model.geom('geom1').feature('disksel2').label('Ports');
model.geom('geom1').feature('disksel2').set('entitydim', 1);
model.geom('geom1').feature('disksel2').set('r', Inf);
model.geom('geom1').feature('disksel2').set('rin', 'L*0.51');
model.geom('geom1').feature('disksel2').set('condition', 'inside');
model.geom('geom1').feature.duplicate('disksel3', 'disksel2');
model.geom('geom1').feature('disksel3').label('Circles');
model.geom('geom1').feature('disksel3').set('rin', 0);
model.geom('geom1').feature('disksel3').set('r', 'L*0.49');
model.geom('geom1').run('disksel3');
model.geom('geom1').create('boxsel1', 'BoxSelection');
model.geom('geom1').feature('boxsel1').label('Port 1');
model.geom('geom1').feature('boxsel1').set('entitydim', 1);
model.geom('geom1').feature('boxsel1').set('inputent', 'selections');
model.geom('geom1').feature('boxsel1').set('input', {'disksel2'});
model.geom('geom1').feature('boxsel1').set('xmax', 0);
model.geom('geom1').run('boxsel1');
model.geom('geom1').create('boxsel2', 'BoxSelection');
model.geom('geom1').feature('boxsel2').label('Port 2');
model.geom('geom1').feature('boxsel2').set('entitydim', 1);
model.geom('geom1').feature('boxsel2').set('inputent', 'selections');
model.geom('geom1').feature('boxsel2').set('input', {'disksel2'});
model.geom('geom1').feature('boxsel2').set('ymin', 0);
model.geom('geom1').feature('boxsel2').set('condition', 'inside');
model.geom('geom1').run('boxsel2');
model.geom('geom1').create('boxsel3', 'BoxSelection');
model.geom('geom1').feature('boxsel3').label('Port 3');
model.geom('geom1').feature('boxsel3').set('entitydim', 1);
model.geom('geom1').feature('boxsel3').set('inputent', 'selections');
model.geom('geom1').feature('boxsel3').set('input', {'disksel2'});
model.geom('geom1').feature('boxsel3').set('ymax', 0);
model.geom('geom1').feature('boxsel3').set('condition', 'inside');
model.geom('geom1').run('fin');

model.title([]);

model.description('');

model.label('demultiplexer_shape_optimization_geom_sequence.mph');

model.modelNode.label('Components');

out = model;
