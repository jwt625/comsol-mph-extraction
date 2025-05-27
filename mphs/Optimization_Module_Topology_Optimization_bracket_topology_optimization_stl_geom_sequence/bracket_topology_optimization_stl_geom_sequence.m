function out = model
%
% bracket_topology_optimization_stl_geom_sequence.m
%
% Model exported on May 26 2025, 21:31 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/Optimization_Module/Topology_Optimization');

% To import content from file, use:
% model.param.loadFile('FILENAME');
model.param.set('D1', '1.4[cm]', 'Constraint diameter');
model.param.set('D2', '5[cm]', 'Load diameter');
model.param.set('H', '10[cm]', 'Height');
model.param.set('W', '21.5[cm]', 'Width');
model.param.set('L', '35[cm]', 'Length');
model.param.set('thickness', '8[mm]', 'Thickness of bracket');
model.param.set('rfillet', '8[mm]', 'Fillet radius');
model.param.set('Y1', '2[cm]', 'Position of constraint hole');
model.param.set('X1', '4[cm]', 'Position of constraint hole');
model.param.set('DY1', '6[cm]', 'Distance between constraint holes');
model.param.set('YC', '-30[cm]', 'Load hole position');
model.param.set('L1', '10[cm]', 'Connection plate width');
model.param.set('rfillet2', '2[cm]', 'Constraint plate fillet radius');
model.param.set('W1', '7[cm]', 'Constraint plate width');
model.param.set('Da', '1[cm]', 'Fixed hole padding');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 3);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.geom('geom1').create('imp1', 'Import');
model.geom('geom1').feature('imp1').set('type', 'native');
model.geom('geom1').feature('imp1').set('filename', 'bracket.mphbin');
model.geom('geom1').feature('imp1').importData;
model.geom('geom1').create('cyl1', 'Cylinder');
model.geom('geom1').feature('cyl1').set('r', 'D2/2+Da/2');
model.geom('geom1').feature('cyl1').set('pos', {'-W/2' 'YC' '0'});
model.geom('geom1').feature('cyl1').set('axistype', 'x');
model.geom('geom1').feature('cyl1').set('selresult', true);
model.geom('geom1').run('cyl1');
model.geom('geom1').create('cyl2', 'Cylinder');
model.geom('geom1').feature('cyl2').set('r', 'D1/2+Da/2');
model.geom('geom1').feature('cyl2').set('pos', {'W/2-X1' '-Y1' '0'});
model.geom('geom1').feature('cyl2').set('selresult', true);
model.geom('geom1').run('cyl2');
model.geom('geom1').create('mov1', 'Move');
model.geom('geom1').feature('mov1').selection('input').named('cyl2');
model.geom('geom1').feature('mov1').set('disply', '-DY1');
model.geom('geom1').feature('mov1').set('keep', true);
model.geom('geom1').run('mov1');
model.geom('geom1').create('blk1', 'Block');
model.geom('geom1').feature('blk1').set('size', {'rfillet+thickness' '1' '1'});
model.geom('geom1').feature('blk1').setIndex('size', 'L1+rfillet', 1);
model.geom('geom1').feature('blk1').setIndex('size', 'rfillet+thickness', 2);
model.geom('geom1').feature('blk1').set('pos', {'W/2-rfillet-thickness' '0' '0'});
model.geom('geom1').feature('blk1').setIndex('pos', '-L1-rfillet', 1);
model.geom('geom1').feature('blk1').setIndex('pos', 'H/2-rfillet-thickness', 2);
model.geom('geom1').run('blk1');
model.geom('geom1').create('mir1', 'Mirror');
model.geom('geom1').feature('mir1').selection('input').set({'blk1'});
model.geom('geom1').feature('mir1').set('keep', true);
model.geom('geom1').run('mir1');
model.geom('geom1').create('mir2', 'Mirror');
model.geom('geom1').feature('mir2').selection('input').set({'blk1' 'cyl2' 'mir1' 'mov1'});
model.geom('geom1').feature('mir2').set('axis', [1 0 0]);
model.geom('geom1').feature('mir2').set('keep', true);
model.geom('geom1').run('mir2');
model.geom('geom1').create('blk2', 'Block');
model.geom('geom1').feature('blk2').set('pos', {'0' '-1' '-H/2'});
model.geom('geom1').run('blk2');
model.geom('geom1').create('par1', 'Partition');
model.geom('geom1').feature('par1').selection('input').set({'imp1'});
model.geom('geom1').feature('par1').selection('tool').set({'blk1' 'blk2' 'cyl1' 'cyl2' 'mir1' 'mir2' 'mov1'});
model.geom('geom1').feature('par1').set('selresult', true);
model.geom('geom1').run('par1');
model.geom('geom1').create('cylsel1', 'CylinderSelection');
model.geom('geom1').feature('cylsel1').label('Constraint 1');
model.geom('geom1').feature('cylsel1').set('entitydim', 2);
model.geom('geom1').feature('cylsel1').set('r', 'D1/2*1.01');
model.geom('geom1').feature('cylsel1').set('pos', {'W/2-X1' '-Y1' '0'});
model.geom('geom1').feature('cylsel1').set('condition', 'inside');
model.geom('geom1').feature.duplicate('cylsel2', 'cylsel1');
model.geom('geom1').feature('cylsel2').label('Constraint 2');
model.geom('geom1').feature('cylsel2').set('pos', {'W/2-X1' '-Y1-DY1' '0'});
model.geom('geom1').feature.duplicate('cylsel3', 'cylsel2');
model.geom('geom1').feature('cylsel3').label('Constraint 3');
model.geom('geom1').feature('cylsel3').set('pos', {'-W/2+X1' '-Y1-DY1' '0'});
model.geom('geom1').feature.duplicate('cylsel4', 'cylsel3');
model.geom('geom1').feature('cylsel4').label('Constraint 4');
model.geom('geom1').feature('cylsel4').set('pos', {'-W/2+X1' '-Y1' '0'});
model.geom('geom1').run('cylsel4');
model.geom('geom1').create('cylsel5', 'CylinderSelection');
model.geom('geom1').feature('cylsel5').label('Load 1a');
model.geom('geom1').feature('cylsel5').set('entitydim', 2);
model.geom('geom1').feature('cylsel5').set('r', 'D2/2*1.01');
model.geom('geom1').feature('cylsel5').set('bottom', 0);
model.geom('geom1').feature('cylsel5').set('angle1', 90);
model.geom('geom1').feature('cylsel5').set('angle2', 270);
model.geom('geom1').feature('cylsel5').set('pos', {'0' 'YC' '0'});
model.geom('geom1').feature('cylsel5').set('axistype', 'x');
model.geom('geom1').feature('cylsel5').set('condition', 'inside');
model.geom('geom1').feature.duplicate('cylsel6', 'cylsel5');
model.geom('geom1').feature('cylsel6').label('Load 1b');
model.geom('geom1').feature('cylsel6').set('angle1', -90);
model.geom('geom1').feature('cylsel6').set('angle2', 90);
model.geom('geom1').feature.duplicate('cylsel7', 'cylsel6');
model.geom('geom1').feature('cylsel7').label('Load 2a');
model.geom('geom1').feature('cylsel7').set('top', 0);
model.geom('geom1').feature('cylsel7').set('bottom', -Inf);
model.geom('geom1').feature.duplicate('cylsel8', 'cylsel7');
model.geom('geom1').feature('cylsel8').label('Load 2b');
model.geom('geom1').feature('cylsel8').set('angle1', 90);
model.geom('geom1').feature('cylsel8').set('angle2', 270);
model.geom('geom1').run('cylsel8');
model.geom('geom1').create('unisel1', 'UnionSelection');
model.geom('geom1').feature('unisel1').label('Load 1');
model.geom('geom1').feature('unisel1').set('entitydim', 2);
model.geom('geom1').feature('unisel1').set('input', {'cylsel5' 'cylsel7'});
model.geom('geom1').run('unisel1');
model.geom('geom1').create('unisel2', 'UnionSelection');
model.geom('geom1').feature('unisel2').label('Load 2');
model.geom('geom1').feature('unisel2').set('entitydim', 2);
model.geom('geom1').feature('unisel2').set('input', {'cylsel6' 'cylsel8'});
model.geom('geom1').run('unisel2');
model.geom('geom1').create('adjsel1', 'AdjacentSelection');
model.geom('geom1').feature('adjsel1').label('Domains Outside Design Space');
model.geom('geom1').feature('adjsel1').set('entitydim', 2);
model.geom('geom1').feature('adjsel1').set('outputdim', 3);
model.geom('geom1').feature('adjsel1').set('input', {'cylsel1' 'cylsel2' 'cylsel3' 'cylsel4'});
model.geom('geom1').run('adjsel1');
model.geom('geom1').create('difsel1', 'DifferenceSelection');
model.geom('geom1').feature('difsel1').label('Design Space Domains');
model.geom('geom1').feature('difsel1').set('add', {'par1'});
model.geom('geom1').feature('difsel1').set('subtract', {'cyl1' 'cyl2'});
model.geom('geom1').run('difsel1');
model.geom('geom1').create('cylsel9', 'CylinderSelection');
model.geom('geom1').feature('cylsel9').label('Material Boundaries');
model.geom('geom1').feature('cylsel9').set('entitydim', 2);
model.geom('geom1').feature('cylsel9').set('r', 'Da+D2/2*1.01');
model.geom('geom1').feature('cylsel9').set('pos', {'0' 'YC' '0'});
model.geom('geom1').feature('cylsel9').set('axistype', 'x');
model.geom('geom1').feature('cylsel9').set('condition', 'inside');
model.geom('geom1').run('cylsel9');
model.geom('geom1').create('boxsel1', 'BoxSelection');
model.geom('geom1').feature('boxsel1').label('Source Domain');
model.geom('geom1').feature('boxsel1').set('xmax', 'eps');
model.geom('geom1').feature('boxsel1').set('condition', 'inside');
model.geom('geom1').run('boxsel1');
model.geom('geom1').create('boxsel2', 'BoxSelection');
model.geom('geom1').feature('boxsel2').label('Destination Domain');
model.geom('geom1').feature('boxsel2').set('xmin', '-eps');
model.geom('geom1').feature('boxsel2').set('condition', 'inside');
model.geom('geom1').run('boxsel2');
model.geom('geom1').create('boxsel3', 'BoxSelection');
model.geom('geom1').feature('boxsel3').label('Free Tetrahedral Domains');
model.geom('geom1').feature('boxsel3').set('xmin', '-W/2+thickness+rfillet*0.4');
model.geom('geom1').feature('boxsel3').set('xmax', '-W/2+thickness+rfillet*0.6');
model.geom('geom1').run('boxsel3');
model.geom('geom1').create('difsel2', 'DifferenceSelection');
model.geom('geom1').feature('difsel2').label('Swept Domains');
model.geom('geom1').feature('difsel2').set('add', {'boxsel1'});
model.geom('geom1').feature('difsel2').set('subtract', {'boxsel3'});
model.geom('geom1').nodeGroup.create('grp1');
model.geom('geom1').nodeGroup('grp1').placeAfter('unisel2');
model.geom('geom1').nodeGroup('grp1').add('adjsel1');
model.geom('geom1').nodeGroup('grp1').add('difsel1');
model.geom('geom1').nodeGroup('grp1').add('cylsel9');
model.geom('geom1').nodeGroup('grp1').add('boxsel1');
model.geom('geom1').nodeGroup('grp1').add('boxsel2');
model.geom('geom1').nodeGroup('grp1').add('boxsel3');
model.geom('geom1').nodeGroup('grp1').add('difsel2');
model.geom('geom1').nodeGroup('grp1').label('Meshing');
model.geom('geom1').run('fin');
model.geom('geom1').create('boxsel4', 'BoxSelection');
model.geom('geom1').feature('boxsel4').label('Mirror Domain');
model.geom('geom1').feature('boxsel4').set('xmin', '0.001*W');
model.geom('geom1').feature('boxsel4').set('ymin', '-L/2');

model.title([]);

model.description('');

model.label('bracket_topology_optimization_stl_geom_sequence.mph');

model.modelNode.label('Components');

out = model;
