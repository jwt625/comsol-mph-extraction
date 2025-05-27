function out = model
%
% split_recombine_mixer_geom_sequence.m
%
% Model exported on May 26 2025, 21:30 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/Microfluidics_Module/Micromixers');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 3);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.geom('geom1').lengthUnit('mm');
model.geom('geom1').create('blk1', 'Block');
model.geom('geom1').feature('blk1').set('size', [0.5 2 0.5]);
model.geom('geom1').feature.duplicate('blk2', 'blk1');
model.geom('geom1').feature('blk2').set('pos', [1 0 0]);
model.geom('geom1').feature.duplicate('blk3', 'blk2');
model.geom('geom1').feature('blk3').set('pos', [0.5 -1.5 0]);
model.geom('geom1').feature('blk3').setIndex('layername', 'Layer 1', 0);
model.geom('geom1').feature('blk3').setIndex('layer', 1, 0);
model.geom('geom1').feature('blk3').set('layerbottom', false);
model.geom('geom1').feature('blk3').set('layerfront', true);
model.geom('geom1').feature.duplicate('blk4', 'blk3');
model.geom('geom1').feature('blk4').set('size', [2 0.5 0.5]);
model.geom('geom1').feature('blk4').set('pos', [0.5 -1.5 0.5]);
model.geom('geom1').feature('blk4').set('layerfront', false);
model.geom('geom1').feature('blk4').set('layerleft', true);
model.geom('geom1').feature.duplicate('blk5', 'blk4');
model.geom('geom1').feature('blk5').set('size', [0.5 1.5 0.5]);
model.geom('geom1').feature('blk5').set('pos', [2 -3 0.5]);
model.geom('geom1').feature('blk5').set('layerleft', false);
model.geom('geom1').feature.duplicate('blk6', 'blk5');
model.geom('geom1').feature('blk6').set('pos', [1.5 -4 0.5]);
model.geom('geom1').feature.duplicate('blk7', 'blk6');
model.geom('geom1').feature('blk7').set('size', [0.5 2.5 0.5]);
model.geom('geom1').feature('blk7').set('pos', [2.5 -5 0.5]);
model.geom('geom1').feature.duplicate('blk8', 'blk7');
model.geom('geom1').feature('blk8').set('size', [2 0.5 0.5]);
model.geom('geom1').feature('blk8').set('pos', [0 -4 0]);
model.geom('geom1').feature.duplicate('blk9', 'blk8');
model.geom('geom1').feature('blk9').set('pos', [1 -5 0]);
model.geom('geom1').feature('blk9').set('layerleft', true);
model.geom('geom1').feature.duplicate('blk10', 'blk9');
model.geom('geom1').feature('blk10').set('size', [1.5 0.5 0.5]);
model.geom('geom1').feature('blk10').set('pos', [0 -5.5 0]);
model.geom('geom1').feature('blk10').set('layerleft', false);
model.geom('geom1').feature.duplicate('blk11', 'blk10');
model.geom('geom1').feature('blk11').set('size', [0.5 1 0.5]);
model.geom('geom1').feature('blk11').set('pos', [0 -5 0]);
model.geom('geom1').feature.duplicate('blk12', 'blk11');
model.geom('geom1').feature('blk12').set('pos', [0.5 -6.5 0]);
model.geom('geom1').feature('blk12').setIndex('layername', 'Layer 1', 0);
model.geom('geom1').feature('blk12').setIndex('layer', 0.5, 0);
model.geom('geom1').feature('blk12').set('layerfront', true);
model.geom('geom1').run('blk12');
model.geom('geom1').create('pard1', 'PartitionDomains');
model.geom('geom1').feature('pard1').selection('domain').set({'blk8' 'blk1' 'blk9' 'blk2' 'blk10' 'blk3' 'blk11' 'blk4' 'blk12' 'blk5'  ...
'blk6' 'blk7'}, [1 0; 1 0; 1 2; 1 0; 1 0; 1 2; 1 0; 1 2; 1 2; 1 0; 1 0; 1 0]);
model.geom('geom1').feature('pard1').set('partitionwith', 'extendedfaces');
model.geom('geom1').feature('pard1').selection('extendedface').set({'blk8' 'blk1' 'blk9' 'blk2' 'blk10' 'blk3' 'blk11' 'blk4' 'blk12' 'blk5'  ...
'blk6' 'blk7'}, [1 2 3 4 5 6 0 0 0 0 0; 1 2 3 4 5 6 0 0 0 0 0; 1 2 3 4 5 6 7 8 9 10 11; 1 2 3 4 5 6 0 0 0 0 0; 1 2 3 4 5 6 0 0 0 0 0; 1 2 3 4 5 6 7 8 9 10 11; 1 2 3 4 5 6 0 0 0 0 0; 1 2 3 4 5 6 7 8 9 10 11; 1 2 3 4 5 6 7 8 9 10 11; 1 2 3 4 5 6 0 0 0 0 0; 1 2 3 4 5 6 0 0 0 0 0; 1 2 3 4 5 6 0 0 0 0 0]);
model.geom('geom1').run('fin');
model.geom('geom1').create('sel1', 'ExplicitSelection');
model.geom('geom1').feature('sel1').selection('selection').init;
model.geom('geom1').feature('sel1').label('Geometry');
model.geom('geom1').feature('sel1').selection('selection').set({'fin'});
model.geom('geom1').run('sel1');
model.geom('geom1').create('sel2', 'ExplicitSelection');
model.geom('geom1').feature('sel2').label('Inflow');
model.geom('geom1').feature('sel2').selection('selection').init(2);
model.geom('geom1').feature('sel2').label('Inflow 1');
model.geom('geom1').feature('sel2').selection('selection').set('fin', 101);
model.geom('geom1').run('sel2');
model.geom('geom1').create('sel3', 'ExplicitSelection');
model.geom('geom1').feature('sel3').label('Inflow 2');
model.geom('geom1').feature('sel3').selection('selection').init(2);
model.geom('geom1').feature('sel3').selection('selection').set('fin', 26);
model.geom('geom1').run('sel3');
model.geom('geom1').create('sel4', 'ExplicitSelection');
model.geom('geom1').feature('sel4').label('Outlet');
model.geom('geom1').feature('sel4').selection('selection').init(2);
model.geom('geom1').feature('sel4').selection('selection').set('fin', 28);
model.geom('geom1').run('sel4');
model.geom('geom1').create('unisel1', 'UnionSelection');
model.geom('geom1').feature('unisel1').label('Inlet');
model.geom('geom1').feature('unisel1').set('entitydim', 2);
model.geom('geom1').feature('unisel1').set('input', {'sel2' 'sel3'});
model.geom('geom1').run('unisel1');
model.geom('geom1').create('sel5', 'ExplicitSelection');
model.geom('geom1').feature('sel5').label('A-A');
model.geom('geom1').feature('sel5').selection('selection').init(2);
model.geom('geom1').feature('sel5').selection('selection').set('fin', 60);
model.geom('geom1').run('sel5');
model.geom('geom1').create('sel6', 'ExplicitSelection');
model.geom('geom1').feature('sel6').label('B-B');
model.geom('geom1').feature('sel6').selection('selection').init(2);
model.geom('geom1').feature('sel6').selection('selection').set('fin', 125);
model.geom('geom1').run('sel6');
model.geom('geom1').create('sel7', 'ExplicitSelection');
model.geom('geom1').feature('sel7').label('C-C');
model.geom('geom1').feature('sel7').selection('selection').init(2);
model.geom('geom1').feature('sel7').selection('selection').set('fin', 132);
model.geom('geom1').run('sel7');
model.geom('geom1').create('sel8', 'ExplicitSelection');
model.geom('geom1').feature('sel8').label('D-D');
model.geom('geom1').feature('sel8').selection('selection').init(2);
model.geom('geom1').feature('sel8').selection('selection').set('fin', 32);
model.geom('geom1').run('sel8');
model.geom('geom1').create('adjsel1', 'AdjacentSelection');
model.geom('geom1').feature('adjsel1').label('Walls - exterior');
model.geom('geom1').feature('adjsel1').set('input', {'sel1'});
model.geom('geom1').run('adjsel1');
model.geom('geom1').create('adjsel2', 'AdjacentSelection');
model.geom('geom1').feature('adjsel2').label('Walls - interior');
model.geom('geom1').feature('adjsel2').set('input', {'sel1'});
model.geom('geom1').feature('adjsel2').set('exterior', false);
model.geom('geom1').feature('adjsel2').set('interior', true);
model.geom('geom1').run('adjsel2');
model.geom('geom1').create('difsel1', 'DifferenceSelection');
model.geom('geom1').feature('difsel1').label('Mesh Control');
model.geom('geom1').feature('difsel1').set('entitydim', 2);
model.geom('geom1').feature('difsel1').set('add', {'adjsel2'});
model.geom('geom1').feature('difsel1').set('subtract', {'sel5' 'sel6' 'sel7' 'sel8'});
model.geom('geom1').run('difsel1');
model.geom('geom1').create('mcf1', 'MeshControlFaces');
model.geom('geom1').feature('mcf1').selection('input').named('difsel1');
model.geom('geom1').run('mcf1');
model.geom('geom1').create('difsel2', 'DifferenceSelection');
model.geom('geom1').feature('difsel2').label('Exterior Walls');
model.geom('geom1').feature('difsel2').set('entitydim', 2);
model.geom('geom1').feature('difsel2').set('add', {'adjsel1'});
model.geom('geom1').feature('difsel2').set('subtract', {'sel4' 'unisel1'});

model.title([]);

model.description('');

model.label('split_recombine_mixer_geom_sequence.mph');

model.modelNode.label('Components');

out = model;
