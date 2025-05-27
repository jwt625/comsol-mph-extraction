function out = model
%
% tortuous_reactor_geom_sequence.m
%
% Model exported on May 26 2025, 21:27 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/Chemical_Reaction_Engineering_Module/Reactors_with_Mass_Transfer');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 3);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.geom('geom1').lengthUnit([native2unicode(hex2dec({'00' 'b5'}), 'unicode') 'm']);
model.geom('geom1').create('blk1', 'Block');
model.geom('geom1').feature('blk1').set('size', [10 80 5]);
model.geom('geom1').feature('blk1').set('pos', [30 -40 0]);
model.geom('geom1').selection.create('csel1', 'CumulativeSelection');
model.geom('geom1').selection('csel1').label('Channel');
model.geom('geom1').feature('blk1').set('contributeto', 'csel1');
model.geom('geom1').run('blk1');
model.geom('geom1').create('arr1', 'Array');
model.geom('geom1').feature('arr1').selection('input').named('csel1');
model.geom('geom1').feature('arr1').set('contributeto', 'csel1');
model.geom('geom1').feature('arr1').set('fullsize', [5 1 1]);
model.geom('geom1').feature('arr1').set('displ', [30 0 0]);
model.geom('geom1').run('arr1');
model.geom('geom1').create('cyl1', 'Cylinder');
model.geom('geom1').feature('cyl1').set('r', 20);
model.geom('geom1').feature('cyl1').set('h', 5);
model.geom('geom1').feature('cyl1').set('pos', [50 -40 0]);
model.geom('geom1').feature('cyl1').setIndex('layername', 'Layer 1', 0);
model.geom('geom1').feature('cyl1').setIndex('layer', 10, 0);
model.geom('geom1').feature('cyl1').set('contributeto', 'csel1');
model.geom('geom1').feature.duplicate('cyl2', 'cyl1');
model.geom('geom1').feature('cyl2').set('pos', [20 40 0]);
model.geom('geom1').run('cyl2');
model.geom('geom1').create('arr2', 'Array');
model.geom('geom1').feature('arr2').selection('input').set({'cyl1' 'cyl2'});
model.geom('geom1').feature('arr2').set('contributeto', 'csel1');
model.geom('geom1').feature('arr2').set('fullsize', [3 1 1]);
model.geom('geom1').feature('arr2').set('displ', [60 0 0]);
model.geom('geom1').run('arr2');
model.geom('geom1').create('blk2', 'Block');
model.geom('geom1').feature('blk2').set('size', [30 30 5]);
model.geom('geom1').feature('blk2').set('pos', [-10 -30 0]);
model.geom('geom1').selection.create('csel2', 'CumulativeSelection');
model.geom('geom1').selection('csel2').label('Adapter Sections');
model.geom('geom1').feature('blk2').set('contributeto', 'csel2');
model.geom('geom1').run('blk2');
model.geom('geom1').create('wp1', 'WorkPlane');
model.geom('geom1').feature('wp1').set('unite', true);
model.geom('geom1').feature('wp1').set('contributeto', 'csel2');
model.geom('geom1').feature('wp1').set('quickz', 5);
model.geom('geom1').feature('wp1').geom.create('c1', 'Circle');
model.geom('geom1').feature('wp1').geom.feature('c1').set('r', 5);
model.geom('geom1').feature('wp1').geom.feature('c1').set('pos', [4.6 -15.4]);
model.geom('geom1').run('wp1');
model.geom('geom1').create('rot1', 'Rotate');
model.geom('geom1').feature('rot1').selection('input').named('csel2');
model.geom('geom1').feature('rot1').set('keep', true);
model.geom('geom1').feature('rot1').set('rot', 180);
model.geom('geom1').feature('rot1').set('pos', [95 0 0]);
model.geom('geom1').feature('rot1').set('contributeto', 'csel2');
model.geom('geom1').run('rot1');
model.geom('geom1').create('blk3', 'Block');
model.geom('geom1').feature('blk3').set('size', [10 40 5]);
model.geom('geom1').feature('blk3').set('contributeto', 'csel1');
model.geom('geom1').feature.duplicate('blk4', 'blk3');
model.geom('geom1').feature('blk4').set('pos', [180 -40 0]);
model.geom('geom1').run('blk4');
model.geom('geom1').feature.create('del1', 'Delete');
model.geom('geom1').feature('del1').selection('input').init;
model.geom('geom1').feature('del1').selection('input').init(3);
model.geom('geom1').feature('del1').selection('input').set({'arr2(1,1,1,1)' 'arr2(1,1,1,2)' 'arr2(2,1,1,1)' 'arr2(2,1,1,2)' 'arr2(3,1,1,1)' 'arr2(3,1,1,2)'}, [2 3 5; 1 3 4; 2 3 5; 1 3 4; 2 3 5; 1 3 4]);
model.geom('geom1').run('fin');
model.geom('geom1').create('sel1', 'ExplicitSelection');
model.geom('geom1').feature('sel1').label('Inlet');
model.geom('geom1').feature('sel1').selection('selection').init(2);
model.geom('geom1').feature('sel1').selection('selection').set('fin', 6);
model.geom('geom1').run('sel1');
model.geom('geom1').create('sel2', 'ExplicitSelection');
model.geom('geom1').feature('sel2').label('Outlet');
model.geom('geom1').feature('sel2').selection('selection').init(2);
model.geom('geom1').feature('sel2').selection('selection').set('fin', 109);
model.geom('geom1').run('sel2');
model.geom('geom1').create('boxsel1', 'BoxSelection');
model.geom('geom1').feature('boxsel1').set('entitydim', 2);
model.geom('geom1').feature('boxsel1').set('inputent', 'selections');
model.geom('geom1').feature('boxsel1').set('input', {'csel1'});
model.geom('geom1').feature('boxsel1').set('xmin', 20);
model.geom('geom1').feature('boxsel1').set('xmax', 170);
model.geom('geom1').feature('boxsel1').set('ymin', -41);
model.geom('geom1').feature('boxsel1').set('ymax', 41);
model.geom('geom1').feature('boxsel1').set('zmax', 0.01);
model.geom('geom1').feature('boxsel1').set('condition', 'inside');
model.geom('geom1').feature('boxsel1').label('Catalytic Surfaces');
model.geom('geom1').run('boxsel1');
model.geom('geom1').create('adjsel1', 'AdjacentSelection');
model.geom('geom1').feature('adjsel1').set('input', {'csel1' 'csel2'});
model.geom('geom1').feature('adjsel1').label('Adjacent Selection - Walls');
model.geom('geom1').run('adjsel1');
model.geom('geom1').create('difsel1', 'DifferenceSelection');
model.geom('geom1').feature('difsel1').label('Exterior Walls');
model.geom('geom1').feature('difsel1').set('entitydim', 2);
model.geom('geom1').feature('difsel1').set('add', {'adjsel1'});
model.geom('geom1').feature('difsel1').set('subtract', {'sel1' 'sel2'});

model.title([]);

model.description('');

model.label('tortuous_reactor_geom_sequence.mph');

model.modelNode.label('Components');

out = model;
