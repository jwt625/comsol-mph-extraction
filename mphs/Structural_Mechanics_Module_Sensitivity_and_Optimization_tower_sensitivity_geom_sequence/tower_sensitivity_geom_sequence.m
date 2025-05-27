function out = model
%
% tower_sensitivity_geom_sequence.m
%
% Model exported on May 26 2025, 21:33 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/Structural_Mechanics_Module/Sensitivity_and_Optimization');

model.param.set('Lx', '1[m]');
model.param.descr('Lx', 'Unit cell width');
model.param.set('Ly', '1[m]');
model.param.descr('Ly', 'Unit cell depth');
model.param.set('Lz', '1[m]');
model.param.descr('Lz', 'Unit cell half height');
model.param.set('Nz', '5');
model.param.descr('Nz', 'Number of unit cells');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 3);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.geom('geom1').create('blk1', 'Block');
model.geom('geom1').feature('blk1').set('size', {'Lx' 'Ly' 'Lz'});
model.geom('geom1').run('blk1');
model.geom('geom1').create('ls1', 'LineSegment');
model.geom('geom1').feature('ls1').set('specify1', 'coord');
model.geom('geom1').feature('ls1').set('specify2', 'coord');
model.geom('geom1').feature('ls1').set('coord2', {'0' 'Ly' 'Lz'});
model.geom('geom1').feature.duplicate('ls2', 'ls1');
model.geom('geom1').feature('ls2').set('coord1', {'Lx' 'Ly' '0'});
model.geom('geom1').feature.duplicate('ls3', 'ls2');
model.geom('geom1').feature('ls3').set('coord2', {'Lx' '0' 'Lz'});
model.geom('geom1').feature.duplicate('ls4', 'ls3');
model.geom('geom1').feature('ls4').set('coord1', [0 0 0]);
model.geom('geom1').run('ls4');
model.geom('geom1').create('mir1', 'Mirror');
model.geom('geom1').feature('mir1').selection('input').set({'blk1' 'ls1' 'ls2' 'ls3' 'ls4'});
model.geom('geom1').feature('mir1').set('keep', true);
model.geom('geom1').feature('mir1').set('pos', {'0' '0' 'Lz'});
model.geom('geom1').run('mir1');
model.geom('geom1').create('ls5', 'LineSegment');
model.geom('geom1').feature('ls5').set('specify1', 'coord');
model.geom('geom1').feature('ls5').set('specify2', 'coord');
model.geom('geom1').feature('ls5').set('coord1', {'0' 'Ly' 'Lz'});
model.geom('geom1').feature('ls5').set('coord2', {'Lx' '0' 'Lz'});
model.geom('geom1').feature.duplicate('ls6', 'ls5');
model.geom('geom1').feature('ls6').set('coord1', {'0' '0' '2*Lz'});
model.geom('geom1').feature('ls6').set('coord2', {'Lx' 'Ly' '2*Lz'});
model.geom('geom1').run('ls6');
model.geom('geom1').create('arr1', 'Array');
model.geom('geom1').feature('arr1').selection('input').set({'blk1' 'ls1' 'ls2' 'ls3' 'ls4' 'ls5' 'ls6' 'mir1'});
model.geom('geom1').feature('arr1').set('fullsize', {'1' '1' 'Nz'});
model.geom('geom1').feature('arr1').set('displ', {'0' '0' '2*Lz'});
model.geom('geom1').run('arr1');
model.geom('geom1').create('ccur1', 'ConvertToCurve');
model.geom('geom1').feature('ccur1').selection('input').set({'arr1'});
model.geom('geom1').run('ccur1');
model.geom('geom1').create('boxsel1', 'BoxSelection');
model.geom('geom1').feature('boxsel1').label('Bottom Points');
model.geom('geom1').feature('boxsel1').set('entitydim', 0);
model.geom('geom1').feature('boxsel1').set('zmax', '0.001*Lz');
model.geom('geom1').run('boxsel1');
model.geom('geom1').create('boxsel2', 'BoxSelection');
model.geom('geom1').feature('boxsel2').label('Top Points');
model.geom('geom1').feature('boxsel2').set('entitydim', 0);
model.geom('geom1').feature('boxsel2').set('zmin', '2*Lz*Nz*0.9999');
model.geom('geom1').run('boxsel2');
model.geom('geom1').create('boxsel3', 'BoxSelection');
model.geom('geom1').feature('boxsel3').label('Nonvertical Bars (x)');
model.geom('geom1').feature('boxsel3').set('entitydim', 1);
model.geom('geom1').feature('boxsel3').set('ymin', 'Ly/2');
model.geom('geom1').feature('boxsel3').set('ymax', 'Ly/2');
model.geom('geom1').run('boxsel3');
model.geom('geom1').create('boxsel4', 'BoxSelection');
model.geom('geom1').feature('boxsel4').label('Nonvertical Bars (y)');
model.geom('geom1').feature('boxsel4').set('entitydim', 1);
model.geom('geom1').feature('boxsel4').set('xmin', 'Lx/2');
model.geom('geom1').feature('boxsel4').set('xmax', 'Lx/2');
model.geom('geom1').run('boxsel4');
model.geom('geom1').create('unisel1', 'UnionSelection');
model.geom('geom1').feature('unisel1').label('Nonvertical Bars');
model.geom('geom1').feature('unisel1').set('entitydim', 1);
model.geom('geom1').feature('unisel1').set('input', {'boxsel3' 'boxsel4'});
model.geom('geom1').run('unisel1');
model.geom('geom1').create('boxsel5', 'BoxSelection');
model.geom('geom1').feature('boxsel5').label('Truss Tower');
model.geom('geom1').feature('boxsel5').set('entitydim', 1);
model.geom('geom1').run('fin');

model.title([]);

model.description('');

model.label('tower_sensitivity_geom_sequence.mph');

model.modelNode.label('Components');

out = model;
