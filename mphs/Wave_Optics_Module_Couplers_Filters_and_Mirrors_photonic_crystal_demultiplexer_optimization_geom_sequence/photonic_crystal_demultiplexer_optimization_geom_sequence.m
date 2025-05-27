function out = model
%
% photonic_crystal_demultiplexer_optimization_geom_sequence.m
%
% Model exported on May 26 2025, 21:34 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/Wave_Optics_Module/Couplers_Filters_and_Mirrors');

model.param.set('lambda2', '1.1[um]');
model.param.descr('lambda2', 'Second wavelength');
model.param.set('W', '4.25*lambda2');
model.param.descr('W', 'Design domain width');
model.param.set('rHole', '0.07*lambda2');
model.param.descr('rHole', 'Hole radius');
model.param.set('nCircles', '6');
model.param.descr('nCircles', 'Circles per channel');
model.param.set('dPeriod', 'W/nCircles/2');
model.param.descr('dPeriod', 'Periodicity');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 2);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.geom('geom1').create('pol1', 'Polygon');
model.geom('geom1').feature('pol1').set('source', 'table');
model.geom('geom1').feature('pol1').setIndex('table', '-W/2', 0, 0);
model.geom('geom1').feature('pol1').setIndex('table', 'sin(5/6*pi)*W/2*2/sqrt(3)', 0, 1);
model.geom('geom1').feature('pol1').setIndex('table', 0, 1, 0);
model.geom('geom1').feature('pol1').setIndex('table', 'W/2*2/sqrt(3)', 1, 1);
model.geom('geom1').feature('pol1').setIndex('table', 'W/2', 2, 0);
model.geom('geom1').feature('pol1').setIndex('table', 'sin(1/6*pi)*W/2*2/sqrt(3)', 2, 1);
model.geom('geom1').feature('pol1').setIndex('table', 'W/2', 3, 0);
model.geom('geom1').feature('pol1').setIndex('table', 'sin(-1/6*pi)*W/2*2/sqrt(3)', 3, 1);
model.geom('geom1').feature('pol1').setIndex('table', 0, 4, 0);
model.geom('geom1').feature('pol1').setIndex('table', '-W/2*2/sqrt(3)', 4, 1);
model.geom('geom1').feature('pol1').setIndex('table', '-W/2', 5, 0);
model.geom('geom1').feature('pol1').setIndex('table', 'sin(-5/6*pi)*W/2*2/sqrt(3)', 5, 1);
model.geom('geom1').feature('pol1').set('selresult', true);
model.geom('geom1').run('pol1');
model.geom('geom1').create('c1', 'Circle');
model.geom('geom1').feature('c1').set('r', 'rHole');
model.geom('geom1').feature('c1').set('pos', {'-W/2' '-2*dPeriod*sin(pi/3)*round(W/dPeriod/sin(pi/3)/3)'});
model.geom('geom1').feature('c1').set('selresult', true);
model.geom('geom1').run('c1');
model.geom('geom1').create('mov1', 'Move');
model.geom('geom1').feature('mov1').selection('input').named('c1');
model.geom('geom1').feature('mov1').set('keep', true);
model.geom('geom1').feature('mov1').set('displx', 'cos(pi/3)*dPeriod');
model.geom('geom1').feature('mov1').set('disply', 'sin(pi/3)*dPeriod');
model.geom('geom1').run('mov1');
model.geom('geom1').create('arr1', 'Array');
model.geom('geom1').feature('arr1').selection('input').named('c1');
model.geom('geom1').feature('arr1').set('fullsize', {'round(W/dPeriod)+1' '1'});
model.geom('geom1').feature('arr1').setIndex('fullsize', 'round(W/dPeriod)', 1);
model.geom('geom1').feature('arr1').set('displ', {'dPeriod' '2*sin(pi/3)*dPeriod'});
model.geom('geom1').run('arr1');
model.geom('geom1').create('boxsel1', 'BoxSelection');
model.geom('geom1').feature('boxsel1').label('All Objects');
model.geom('geom1').feature('boxsel1').set('entitydim', -1);
model.geom('geom1').run('boxsel1');
model.geom('geom1').create('boxsel2', 'BoxSelection');
model.geom('geom1').feature('boxsel2').label('Circles to Delete, Row 1');
model.geom('geom1').feature('boxsel2').set('xmax', '2*rHole');
model.geom('geom1').feature('boxsel2').set('ymin', '-rHole*1.01');
model.geom('geom1').feature('boxsel2').set('ymax', 'rHole*1.01');
model.geom('geom1').feature('boxsel2').set('condition', 'inside');
model.geom('geom1').run('boxsel2');
model.geom('geom1').create('rot1', 'Rotate');
model.geom('geom1').feature('rot1').selection('input').named('c1');
model.geom('geom1').feature('rot1').set('rot', 120);
model.geom('geom1').feature.duplicate('boxsel3', 'boxsel2');
model.geom('geom1').feature('boxsel3').label('Circles to Delete, Row 2');
model.geom('geom1').feature.duplicate('rot2', 'rot1');
model.geom('geom1').feature.duplicate('boxsel4', 'boxsel3');
model.geom('geom1').feature('boxsel4').label('Circles to Delete, Row 3');
model.geom('geom1').feature.duplicate('rot3', 'rot2');
model.geom('geom1').run('rot3');
model.geom('geom1').create('unisel1', 'UnionSelection');
model.geom('geom1').feature('unisel1').label('Circles to Delete, Rows');
model.geom('geom1').feature('unisel1').set('input', {'boxsel2' 'boxsel3' 'boxsel4'});
model.geom('geom1').run('unisel1');
model.geom('geom1').create('del1', 'Delete');
model.geom('geom1').feature('del1').selection('input').init(2);
model.geom('geom1').feature('del1').selection('input').named('unisel1');
model.geom('geom1').run('del1');
model.geom('geom1').create('uni1', 'Union');
model.geom('geom1').feature('uni1').selection('input').named('boxsel1');
model.geom('geom1').run('uni1');
model.geom('geom1').create('difsel1', 'DifferenceSelection');
model.geom('geom1').feature('difsel1').set('add', {'c1'});
model.geom('geom1').feature('difsel1').set('subtract', {'pol1'});
model.geom('geom1').run('difsel1');
model.geom('geom1').create('del2', 'Delete');
model.geom('geom1').feature('del2').selection('input').init(2);
model.geom('geom1').feature('del2').selection('input').named('difsel1');
model.geom('geom1').run('del2');
model.geom('geom1').create('ls1', 'LineSegment');
model.geom('geom1').feature('ls1').label('Input Port');
model.geom('geom1').feature('ls1').set('specify1', 'coord');
model.geom('geom1').feature('ls1').set('coord1', {'-W/2' '-dPeriod/2'});
model.geom('geom1').feature('ls1').set('specify2', 'coord');
model.geom('geom1').feature('ls1').set('coord2', {'-W/2' 'dPeriod/2'});
model.geom('geom1').feature('ls1').set('selresult', true);
model.geom('geom1').feature.duplicate('ls2', 'ls1');
model.geom('geom1').feature('ls2').label('Output Port 1');
model.geom('geom1').feature('ls2').set('coord1', {'W/4-dPeriod/2*cos(pi*5/6)' '-dPeriod/2'});
model.geom('geom1').feature('ls2').setIndex('coord1', '(W/2*2/sqrt(3)+sin(1/6*pi)*W/2*2/sqrt(3))/2-dPeriod/2*sin(pi*5/6)', 1);
model.geom('geom1').feature('ls2').set('coord2', {'W/4+dPeriod/2*cos(pi*5/6)' 'dPeriod/2'});
model.geom('geom1').feature('ls2').setIndex('coord2', '(W/2*2/sqrt(3)+sin(1/6*pi)*W/2*2/sqrt(3))/2+dPeriod/2*sin(pi*5/6)', 1);
model.geom('geom1').feature.duplicate('ls3', 'ls2');
model.geom('geom1').feature('ls3').label('Output Port 2');
model.geom('geom1').feature('ls3').setIndex('coord1', '(-W/2*2/sqrt(3)-sin(1/6*pi)*W/2*2/sqrt(3))/2-dPeriod/2*sin(-pi*5/6)', 1);
model.geom('geom1').feature('ls3').setIndex('coord2', '(-W/2*2/sqrt(3)-sin(1/6*pi)*W/2*2/sqrt(3))/2+dPeriod/2*sin(-pi*5/6)', 1);
model.geom('geom1').run('ls3');
model.geom('geom1').create('adjsel1', 'AdjacentSelection');
model.geom('geom1').feature('adjsel1').label('Circle Boundaries');
model.geom('geom1').feature('adjsel1').set('input', {'c1'});
model.geom('geom1').run('adjsel1');
model.geom('geom1').create('adjsel2', 'AdjacentSelection');
model.geom('geom1').feature('adjsel2').label('Polygon Boundaries');
model.geom('geom1').feature('adjsel2').set('input', {'pol1'});
model.geom('geom1').run('adjsel2');
model.geom('geom1').create('adjsel3', 'AdjacentSelection');
model.geom('geom1').feature('adjsel3').label('Domain Boundaries');
model.geom('geom1').feature('adjsel3').set('entitydim', 1);
model.geom('geom1').feature('adjsel3').set('input', {'adjsel2'});
model.geom('geom1').feature('adjsel3').set('outputdim', 2);
model.geom('geom1').run('adjsel3');
model.geom('geom1').create('comsel1', 'ComplementSelection');
model.geom('geom1').feature('comsel1').label('Moving Domains');
model.geom('geom1').feature('comsel1').set('input', {'adjsel3'});
model.geom('geom1').run('comsel1');
model.geom('geom1').create('disksel1', 'DiskSelection');
model.geom('geom1').feature('disksel1').label('Free Shape Domains');
model.geom('geom1').run('fin');

model.title([]);

model.description('');

model.label('photonic_crystal_demultiplexer_optimization_geom_sequence.mph');

model.modelNode.label('Components');

out = model;
