function out = model
%
% coil_shape_optimization_geom_sequence.m
%
% Model exported on May 26 2025, 21:31 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/Optimization_Module/Shape_Optimization');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 2);
model.geom('geom1').model('comp1');
model.geom('geom1').axisymmetric(true);

model.mesh.create('mesh1', 'geom1');

model.param.set('R1', '45[cm]');
model.param.descr('R1', 'Domain radius');
model.param.set('infR', '10[cm]');
model.param.descr('infR', 'Infinite domain radius');
model.param.set('coilWidth', '1[cm]');
model.param.descr('coilWidth', 'Coil width');
model.param.set('coilHeight', '2[cm]');
model.param.descr('coilHeight', 'Coil height');
model.param.set('R2', '6[cm]');
model.param.descr('R2', 'Coil inner radius');
model.param.set('nCoil', '3');
model.param.descr('nCoil', 'Number of coils');
model.param.set('coilSpace', '1.5[cm]');
model.param.descr('coilSpace', 'Coil spacing');
model.param.set('objHeight', '33[cm]');
model.param.descr('objHeight', 'Objective domain height');
model.param.set('objR', '2[cm]');
model.param.descr('objR', 'Objective domain radius');
model.param.set('objOuter', '6.5[cm]');
model.param.descr('objOuter', 'Outer objective domain');
model.param.set('objSpace', '1.5[cm]');
model.param.descr('objSpace', 'Objective domain spacing');
model.param.set('deformR', '13[cm]');
model.param.descr('deformR', 'Deforming domain width');
model.param.set('deformHeight', '40[cm]');
model.param.descr('deformHeight', 'Deforming domain height');
model.param.set('tTube', '2[mm]');
model.param.descr('tTube', 'Tube thickness');
model.param.set('objInner', 'objHeight-2*objSpace-2*objOuter');
model.param.descr('objInner', 'Inner objective domain');

model.geom('geom1').create('c1', 'Circle');
model.geom('geom1').feature('c1').set('r', 'R');
model.geom('geom1').feature('c1').set('angle', 180);
model.geom('geom1').feature('c1').set('r', 'R1');
model.geom('geom1').feature('c1').set('rot', -90);
model.geom('geom1').feature('c1').setIndex('layername', 'Layer 1', 0);
model.geom('geom1').feature('c1').setIndex('layer', 'infR', 0);
model.geom('geom1').run('c1');
model.geom('geom1').create('r1', 'Rectangle');
model.geom('geom1').feature('r1').set('size', {'coilWidth' 'coilHeight'});
model.geom('geom1').feature('r1').set('pos', {'R2' '-coilSpace*(nCoil+0.5)-(nCoil+1)*coilHeight'});
model.geom('geom1').feature('r1').set('selresult', true);
model.geom('geom1').feature.duplicate('r2', 'r1');
model.geom('geom1').feature('r2').set('size', {'coilWidth-2*tTube' 'coilHeight'});
model.geom('geom1').feature('r2').setIndex('size', 'coilHeight-2*tTube', 1);
model.geom('geom1').feature('r2').setIndex('pos', 'R2+tTube', 0);
model.geom('geom1').feature('r2').set('pos', {'R2+tTube' '-coilSpace*(nCoil+0.5)-(nCoil+1)*coilHeight+tTube'});
model.geom('geom1').run('r2');
model.geom('geom1').create('dif1', 'Difference');
model.geom('geom1').feature('dif1').selection('input').named('r1');
model.geom('geom1').feature('dif1').selection('input2').named('r2');
model.geom('geom1').feature('dif1').set('selresult', true);
model.geom('geom1').run('dif1');
model.geom('geom1').create('disksel1', 'DiskSelection');
model.geom('geom1').feature('disksel1').set('entitydim', 0);
model.geom('geom1').feature('disksel1').label('Lower left point');
model.geom('geom1').feature('disksel1').set('r', 'coilWidth/100');
model.geom('geom1').feature('disksel1').set('posx', 'R2');
model.geom('geom1').feature('disksel1').set('posy', '-coilSpace*(nCoil+0.5)-(nCoil+1)*coilHeight');
model.geom('geom1').run('disksel1');
model.geom('geom1').create('copy1', 'Copy');
model.geom('geom1').feature('copy1').selection('input').named('dif1');
model.geom('geom1').feature('copy1').set('disply', 'coilSpace+coilHeight');
model.geom('geom1').feature('copy1').set('selresult', true);
model.geom('geom1').feature.duplicate('copy2', 'copy1');
model.geom('geom1').feature('copy2').label('Inner Coils');
model.geom('geom1').runPre('copy2');
model.geom('geom1').feature('copy2').selection('input').named('copy1');
model.geom('geom1').run('copy2');
model.geom('geom1').create('arr1', 'Array');
model.geom('geom1').feature('arr1').selection('input').named('copy2');
model.geom('geom1').feature('arr1').set('fullsize', {'1' 'nCoil-1'});
model.geom('geom1').feature('arr1').set('displ', {'0' 'coilHeight+coilSpace'});
model.geom('geom1').run('arr1');
model.geom('geom1').create('unisel1', 'UnionSelection');
model.geom('geom1').feature('unisel1').label('Objects to Mirror');
model.geom('geom1').feature('unisel1').set('entitydim', -1);
model.geom('geom1').feature('unisel1').set('input', {'dif1' 'copy1' 'copy2'});
model.geom('geom1').run('unisel1');
model.geom('geom1').create('mir1', 'Mirror');
model.geom('geom1').feature('mir1').selection('input').named('unisel1');
model.geom('geom1').feature('mir1').set('keep', true);
model.geom('geom1').feature('mir1').set('axis', [0 1]);
model.geom('geom1').run('mir1');
model.geom('geom1').create('r3', 'Rectangle');
model.geom('geom1').feature('r3').label('Outer Objective Domain');
model.geom('geom1').feature('r3').set('size', {'objR' 'objOuter'});
model.geom('geom1').feature('r3').set('pos', {'0' '-objHeight/2'});
model.geom('geom1').feature('r3').set('selresult', true);
model.geom('geom1').run('r3');
model.geom('geom1').create('boxsel1', 'BoxSelection');
model.geom('geom1').feature('boxsel1').label('Outer Axis');
model.geom('geom1').feature('boxsel1').set('entitydim', 1);
model.geom('geom1').feature('boxsel1').set('xmax', 'objR*0.1');
model.geom('geom1').feature('boxsel1').set('ymin', '-objHeight/2-objOuter*0.01');
model.geom('geom1').feature('boxsel1').set('ymax', '-objHeight/2+objOuter*1.01');
model.geom('geom1').feature('boxsel1').set('condition', 'inside');
model.geom('geom1').feature.duplicate('mir2', 'mir1');
model.geom('geom1').runPre('mir2');
model.geom('geom1').feature('mir2').selection('input').named('r3');
model.geom('geom1').create('r4', 'Rectangle');
model.geom('geom1').feature('r4').set('size', {'objR' 'objInner'});
model.geom('geom1').feature('r4').set('base', 'center');
model.geom('geom1').feature('r4').set('pos', {'objR/2' '0'});
model.geom('geom1').feature('r4').set('selresult', true);
model.geom('geom1').run('r4');
model.geom('geom1').create('r5', 'Rectangle');
model.geom('geom1').feature('r5').set('size', {'deformR' 'deformHeight'});
model.geom('geom1').feature('r5').set('pos', {'0' '-deformHeight/2'});
model.geom('geom1').feature('r5').set('selresult', true);
model.geom('geom1').run('fin');
model.geom('geom1').create('difsel1', 'DifferenceSelection');
model.geom('geom1').feature('difsel1').label('Deforming Domain');
model.geom('geom1').feature('difsel1').set('add', {'r5'});
model.geom('geom1').feature('difsel1').set('subtract', {'r1' 'r3' 'r4'});
model.geom('geom1').run('difsel1');
model.geom('geom1').create('disksel2', 'DiskSelection');
model.geom('geom1').feature('disksel2').set('entitydim', 1);
model.geom('geom1').feature('disksel2').label('Infinite Domain Boundaries');
model.geom('geom1').feature('disksel2').set('r', 'R1*0.99');
model.geom('geom1').feature('disksel2').set('rin', 'R1*0.98');
model.geom('geom1').run('disksel2');
model.geom('geom1').create('adjsel1', 'AdjacentSelection');
model.geom('geom1').feature('adjsel1').label('Infinite Domains');
model.geom('geom1').feature('adjsel1').set('entitydim', 1);
model.geom('geom1').feature('adjsel1').set('outputdim', 2);
model.geom('geom1').feature('adjsel1').set('input', {'disksel2'});
model.geom('geom1').run('adjsel1');
model.geom('geom1').create('boxsel2', 'BoxSelection');
model.geom('geom1').feature('boxsel2').label('Coil Cavities');
model.geom('geom1').feature('boxsel2').set('xmin', 'R2+tTube*0.5');
model.geom('geom1').feature('boxsel2').set('xmax', 'R2+coilWidth-0.5*tTube');
model.geom('geom1').feature('boxsel2').set('condition', 'inside');
model.geom('geom1').run('boxsel2');
model.geom('geom1').create('difsel2', 'DifferenceSelection');
model.geom('geom1').feature('difsel2').label('Outer Coils');
model.geom('geom1').feature('difsel2').set('add', {'dif1'});
model.geom('geom1').feature('difsel2').set('subtract', {'copy1'});
model.geom('geom1').feature.duplicate('difsel3', 'difsel2');
model.geom('geom1').feature('difsel3').label('Outer Coils 2');
model.geom('geom1').runPre('difsel3');
model.geom('geom1').feature('difsel3').set('subtract', {'copy2' 'difsel2'});
model.geom('geom1').create('boxsel3', 'BoxSelection');
model.geom('geom1').feature('boxsel3').label('Inner Axis');
model.geom('geom1').feature('boxsel3').set('entitydim', 1);
model.geom('geom1').feature('boxsel3').set('xmax', 'objR*0.1');
model.geom('geom1').feature('boxsel3').set('ymin', '-objInner/1.99');
model.geom('geom1').feature('boxsel3').set('ymax', 'objInner/1.99');
model.geom('geom1').feature('boxsel3').set('condition', 'inside');
model.geom('geom1').feature.duplicate('boxsel4', 'boxsel3');
model.geom('geom1').feature('boxsel4').label('Whole Axis');
model.geom('geom1').feature('boxsel4').set('ymin', '-objHeight/1.99');
model.geom('geom1').feature('boxsel4').set('ymax', 'objHeight/1.99');
model.geom('geom1').run('boxsel4');

model.title([]);

model.description('');

model.label('coil_shape_optimization_geom_sequence.mph');

model.modelNode.label('Components');

out = model;
