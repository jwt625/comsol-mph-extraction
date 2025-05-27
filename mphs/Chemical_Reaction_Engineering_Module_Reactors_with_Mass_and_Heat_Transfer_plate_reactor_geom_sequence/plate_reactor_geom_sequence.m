function out = model
%
% plate_reactor_geom_sequence.m
%
% Model exported on May 26 2025, 21:27 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/Chemical_Reaction_Engineering_Module/Reactors_with_Mass_and_Heat_Transfer');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 3);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.geom('geom1').lengthUnit('mm');
model.geom('geom1').create('blk1', 'Block');
model.geom('geom1').feature('blk1').set('size', [155 20 15]);
model.geom('geom1').run('blk1');
model.geom('geom1').create('blk2', 'Block');
model.geom('geom1').feature('blk2').set('size', [10 10 15]);
model.geom('geom1').feature('blk2').set('pos', [5 0 0]);
model.geom('geom1').run('blk2');
model.geom('geom1').create('cyl1', 'Cylinder');
model.geom('geom1').feature('cyl1').set('r', 5);
model.geom('geom1').feature('cyl1').set('h', 15);
model.geom('geom1').feature('cyl1').set('pos', [10 10 0]);
model.geom('geom1').run('cyl1');
model.geom('geom1').create('arr1', 'Array');
model.geom('geom1').feature('arr1').selection('input').set({'blk2' 'cyl1'});
model.geom('geom1').feature('arr1').set('fullsize', [5 1 1]);
model.geom('geom1').feature('arr1').set('displ', [30 0 0]);
model.geom('geom1').selection.create('csel1', 'CumulativeSelection');
model.geom('geom1').selection('csel1').label('Object to subtract');
model.geom('geom1').feature('arr1').set('contributeto', 'csel1');
model.geom('geom1').run('arr1');
model.geom('geom1').create('mir1', 'Mirror');
model.geom('geom1').feature('mir1').selection('input').named('csel1');
model.geom('geom1').feature('mir1').set('keep', true);
model.geom('geom1').feature('mir1').set('selresult', true);
model.geom('geom1').feature('mir1').set('pos', [0 10 0]);
model.geom('geom1').feature('mir1').set('axis', [0 1 0]);
model.geom('geom1').feature('mir1').set('contributeto', 'csel1');
model.geom('geom1').run('mir1');
model.geom('geom1').create('mov1', 'Move');
model.geom('geom1').feature('mov1').selection('input').named('mir1');
model.geom('geom1').feature('mov1').set('contributeto', 'csel1');
model.geom('geom1').feature('mov1').set('displx', 15);
model.geom('geom1').run('mov1');
model.geom('geom1').create('dif1', 'Difference');
model.geom('geom1').feature('dif1').selection('input').set({'blk1'});
model.geom('geom1').feature('dif1').selection('input2').named('csel1');
model.geom('geom1').run('dif1');
model.geom('geom1').create('pard1', 'PartitionDomains');
model.geom('geom1').feature('pard1').selection('domain').set('dif1', 1);
model.geom('geom1').feature('pard1').set('partitionwith', 'extendedfaces');
model.geom('geom1').feature('pard1').selection('extendedface').set('dif1', [6 54]);
model.geom('geom1').run('pard1');
model.geom('geom1').create('blk3', 'Block');
model.geom('geom1').feature('blk3').set('size', [5 20 3]);
model.geom('geom1').feature('blk3').set('pos', [150 0 15]);
model.geom('geom1').run('blk3');
model.geom('geom1').create('arr2', 'Array');
model.geom('geom1').feature('arr2').selection('input').set({'pard1'});
model.geom('geom1').feature('arr2').set('fullsize', [1 1 4]);
model.geom('geom1').feature('arr2').set('displ', [0 0 18]);
model.geom('geom1').run('arr2');
model.geom('geom1').create('mir2', 'Mirror');
model.geom('geom1').feature('mir2').selection('input').set({'arr2(1,1,2)' 'arr2(1,1,4)'});
model.geom('geom1').feature('mir2').set('pos', [77.5 0 0]);
model.geom('geom1').feature('mir2').set('axis', [1 0 0]);
model.geom('geom1').run('mir2');
model.geom('geom1').create('blk4', 'Block');
model.geom('geom1').feature('blk4').set('size', [5 20 3]);
model.geom('geom1').feature('blk4').set('pos', [150 0 51]);
model.geom('geom1').run('blk4');
model.geom('geom1').create('blk5', 'Block');
model.geom('geom1').feature('blk5').set('size', [5 20 3]);
model.geom('geom1').feature('blk5').set('pos', [0 0 33]);
model.geom('geom1').run('blk5');
model.geom('geom1').feature.create('ext1', 'Extrude');
model.geom('geom1').feature('ext1').selection('inputface').set('mir2(1)', 63);
model.geom('geom1').feature('ext1').selection('inputface').set('mir2(2)', 63);
model.geom('geom1').feature('ext1').setIndex('distance', 10, 0);
model.geom('geom1').run('ext1');
model.geom('geom1').feature.duplicate('ext2', 'ext1');
model.geom('geom1').feature('ext2').selection('inputface').set('arr2(1,1,1)', 2);
model.geom('geom1').run('ext2');
model.geom('geom1').run('fin');
model.geom('geom1').create('sel1', 'ExplicitSelection');
model.geom('geom1').feature('sel1').label('Inlet');
model.geom('geom1').feature('sel1').selection('selection').init(2);
model.geom('geom1').feature('sel1').selection('selection').set('fin', 35);
model.geom('geom1').feature('sel1').label('Inlet 1');
model.geom('geom1').run('sel1');
model.geom('geom1').create('sel2', 'ExplicitSelection');
model.geom('geom1').feature('sel2').label('Inlet 2');
model.geom('geom1').feature('sel2').selection('selection').init(2);
model.geom('geom1').feature('sel2').selection('selection').set('fin', 34);
model.geom('geom1').run('sel2');
model.geom('geom1').create('sel3', 'ExplicitSelection');
model.geom('geom1').feature('sel3').label('Outlet');
model.geom('geom1').feature('sel3').selection('selection').init(2);
model.geom('geom1').feature('sel3').selection('selection').set('fin', 2);
model.geom('geom1').run('sel3');
model.geom('geom1').create('boxsel1', 'BoxSelection');
model.geom('geom1').feature('boxsel1').label('Box Selection - Heat Exchanger 1');
model.geom('geom1').feature('boxsel1').set('zmin', 33.1);
model.geom('geom1').feature('boxsel1').set('condition', 'inside');
model.geom('geom1').run('boxsel1');
model.geom('geom1').create('boxsel2', 'BoxSelection');
model.geom('geom1').feature('boxsel2').label('Box Selection - Heat Exchanger 2');
model.geom('geom1').feature('boxsel2').set('zmax', 33);
model.geom('geom1').feature('boxsel2').set('condition', 'inside');
model.geom('geom1').feature.duplicate('boxsel3', 'boxsel2');
model.geom('geom1').feature('boxsel3').label('Box Selection - Heat Exchanger Connection');
model.geom('geom1').feature('boxsel3').set('entitydim', 2);
model.geom('geom1').feature('boxsel3').set('zmin', 34);
model.geom('geom1').feature('boxsel3').set('zmax', 35);
model.geom('geom1').run('boxsel3');
model.geom('geom1').feature('boxsel3').set('condition', 'intersects');
model.geom('geom1').run('boxsel3');
model.geom('geom1').create('adjsel1', 'AdjacentSelection');
model.geom('geom1').feature('adjsel1').label('Adjacent Selection - Heat Exchanger 1');
model.geom('geom1').feature('adjsel1').set('input', {'boxsel1'});
model.geom('geom1').run('adjsel1');
model.geom('geom1').create('adjsel2', 'AdjacentSelection');
model.geom('geom1').feature('adjsel2').label('Adjacent Selection - Heat Exchanger 2');
model.geom('geom1').feature('adjsel2').set('input', {'boxsel2'});
model.geom('geom1').run('adjsel2');
model.geom('geom1').create('difsel1', 'DifferenceSelection');
model.geom('geom1').feature('difsel1').label('Heat Exchanger 1');
model.geom('geom1').feature('difsel1').set('entitydim', 2);
model.geom('geom1').feature('difsel1').set('add', {'adjsel1'});
model.geom('geom1').feature('difsel1').set('subtract', {'sel1'});
model.geom('geom1').run('difsel1');
model.geom('geom1').create('difsel2', 'DifferenceSelection');
model.geom('geom1').feature('difsel2').label('Heat Exchanger 2');
model.geom('geom1').feature('difsel2').set('entitydim', 2);
model.geom('geom1').feature('difsel2').set('add', {'adjsel2'});
model.geom('geom1').feature('difsel2').set('subtract', {'sel2' 'sel3'});
model.geom('geom1').run('difsel2');
model.geom('geom1').create('unisel1', 'UnionSelection');
model.geom('geom1').feature('unisel1').label('Exterior Walls');
model.geom('geom1').feature('unisel1').set('entitydim', 2);
model.geom('geom1').feature('unisel1').set('input', {'boxsel3' 'difsel1' 'difsel2'});
model.geom('geom1').run('unisel1');
model.geom('geom1').create('adjsel3', 'AdjacentSelection');
model.geom('geom1').feature('adjsel3').set('input', {'boxsel1'});
model.geom('geom1').feature('adjsel3').set('interior', true);
model.geom('geom1').feature('adjsel3').set('exterior', false);
model.geom('geom1').feature('adjsel3').label('Interior boundaries Heat Exchanger 1');
model.geom('geom1').run('adjsel3');
model.geom('geom1').feature.duplicate('adjsel4', 'adjsel3');
model.geom('geom1').feature('adjsel4').label('Interior boundaries Heat Exchanger 2');
model.geom('geom1').feature('adjsel4').set('input', {'boxsel2'});
model.geom('geom1').run('adjsel4');
model.geom('geom1').create('unisel2', 'UnionSelection');
model.geom('geom1').feature('unisel2').set('entitydim', 2);
model.geom('geom1').feature('unisel2').label('All interior boundaries');
model.geom('geom1').feature('unisel2').set('input', {'adjsel3' 'adjsel4'});
model.geom('geom1').run('unisel2');
model.geom('geom1').create('mcf1', 'MeshControlFaces');
model.geom('geom1').feature('mcf1').selection('input').named('unisel2');
model.geom('geom1').run('mcf1');

model.title([]);

model.description('');

model.label('plate_reactor_geom_sequence.mph');

model.modelNode.label('Components');

out = model;
