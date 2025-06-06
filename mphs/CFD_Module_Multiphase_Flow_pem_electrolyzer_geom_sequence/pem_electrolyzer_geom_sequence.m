function out = model
%
% pem_electrolyzer_geom_sequence.m
%
% Model exported on May 26 2025, 21:26 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/CFD_Module/Multiphase_Flow');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 3);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

% To import content from file, use:
% model.param.loadFile('FILENAME');
model.param.set('N_ch', '23', 'Number of electrode channels');
model.param.set('L_ch', '118*h_a', 'Electrode channel lengths');
model.param.set('ang_inout', '22.5[deg]', 'Rotation angle, inlet/outlet');
model.param.set('h_a', '0.889[mm]', 'Channel height');
model.param.set('L_inout', '2[cm]', 'Inlet/outlet channel length');
model.param.set('R_in', '1.27[cm]/2', 'Radius of inlet tube');
model.param.set('w_ch', '2.07[mm]', 'Channel width');

model.geom('geom1').create('wp1', 'WorkPlane');
model.geom('geom1').feature('wp1').set('unite', true);
model.geom('geom1').feature('wp1').geom.create('c1', 'Circle');
model.geom('geom1').feature('wp1').geom.feature('c1').set('r', 'R_in');
model.geom('geom1').feature('wp1').geom.run('c1');
model.geom('geom1').feature('wp1').geom.create('r1', 'Rectangle');
model.geom('geom1').feature('wp1').geom.feature('r1').set('size', {'L_inout*3/4' '1'});
model.geom('geom1').feature('wp1').geom.feature('r1').setIndex('size', 'w_ch', 1);
model.geom('geom1').feature('wp1').geom.feature('r1').set('pos', {'0' '-w_ch*2.5'});
model.geom('geom1').feature('wp1').geom.run('r1');
model.geom('geom1').feature('wp1').geom.create('r2', 'Rectangle');
model.geom('geom1').feature('wp1').geom.feature('r2').set('size', {'L_inout*1/4' '1'});
model.geom('geom1').feature('wp1').geom.feature('r2').setIndex('size', 'w_ch', 1);
model.geom('geom1').feature('wp1').geom.feature('r2').set('pos', {'L_inout*3/4' '0'});
model.geom('geom1').feature('wp1').geom.feature('r2').setIndex('pos', '-w_ch*2.5', 1);
model.geom('geom1').feature('wp1').geom.run('r2');
model.geom('geom1').feature('wp1').geom.create('arr1', 'Array');
model.geom('geom1').feature('wp1').geom.feature('arr1').selection('input').set({'r1' 'r2'});
model.geom('geom1').feature('wp1').geom.feature('arr1').set('fullsize', [1 3]);
model.geom('geom1').feature('wp1').geom.feature('arr1').set('displ', {'0' '2*w_ch'});
model.geom('geom1').feature('wp1').geom.run('arr1');
model.geom('geom1').feature('wp1').geom.create('pol1', 'Polygon');
model.geom('geom1').feature('wp1').geom.feature('pol1').set('source', 'table');
model.geom('geom1').feature('wp1').geom.feature('pol1').setIndex('table', 'L_inout*3/4', 0, 0);
model.geom('geom1').feature('wp1').geom.feature('pol1').setIndex('table', '2*w_ch*1.25', 0, 1);
model.geom('geom1').feature('wp1').geom.feature('pol1').setIndex('table', 'L_inout*3/4', 1, 0);
model.geom('geom1').feature('wp1').geom.feature('pol1').setIndex('table', '-2*w_ch*1.25', 1, 1);
model.geom('geom1').feature('wp1').geom.feature('pol1').setIndex('table', 'L_inout*3/4-5*w_ch*tan(ang_inout/2)', 2, 0);
model.geom('geom1').feature('wp1').geom.feature('pol1').setIndex('table', '-2*w_ch*1.25', 2, 1);
model.geom('geom1').feature('wp1').geom.run('pol1');
model.geom('geom1').feature('wp1').geom.create('dif1', 'Difference');
model.geom('geom1').feature('wp1').geom.feature('dif1').selection('input').set({'arr1(1,3,1)'});
model.geom('geom1').feature('wp1').geom.feature('dif1').selection('input').init;
model.geom('geom1').feature('wp1').geom.feature('dif1').selection('input').set({'arr1(1,1,1)' 'arr1(1,2,1)' 'arr1(1,3,1)'});
model.geom('geom1').feature('wp1').geom.feature('dif1').selection('input2').set({'c1' 'pol1'});
model.geom('geom1').feature('wp1').geom.run('dif1');
model.geom('geom1').feature('wp1').geom.create('pol2', 'Polygon');
model.geom('geom1').feature('wp1').geom.feature('pol2').set('source', 'table');
model.geom('geom1').feature('wp1').geom.feature('pol2').setIndex('table', 'L_inout*3/4', 0, 0);
model.geom('geom1').feature('wp1').geom.feature('pol2').setIndex('table', '2*w_ch*1.25', 0, 1);
model.geom('geom1').feature('wp1').geom.feature('pol2').setIndex('table', 'L_inout*3/4', 1, 0);
model.geom('geom1').feature('wp1').geom.feature('pol2').setIndex('table', '-2*w_ch*1.25', 1, 1);
model.geom('geom1').feature('wp1').geom.feature('pol2').setIndex('table', 'L_inout*3/4+5*w_ch*tan(ang_inout/2)', 2, 0);
model.geom('geom1').feature('wp1').geom.feature('pol2').setIndex('table', '-2*w_ch*1.25', 2, 1);
model.geom('geom1').feature('wp1').geom.run('pol2');
model.geom('geom1').feature('wp1').geom.create('dif2', 'Difference');
model.geom('geom1').feature('wp1').geom.feature('dif2').selection('input').set({'arr1(1,1,2)' 'arr1(1,2,2)' 'arr1(1,3,2)'});
model.geom('geom1').feature('wp1').geom.feature('dif2').selection('input2').set({'pol2'});
model.geom('geom1').feature('wp1').geom.run('dif2');
model.geom('geom1').feature('wp1').geom.create('rot1', 'Rotate');
model.geom('geom1').feature('wp1').geom.feature('rot1').selection('input').set({'dif1'});
model.geom('geom1').feature('wp1').geom.feature('rot1').set('rot', 'ang_inout');
model.geom('geom1').feature('wp1').geom.feature('rot1').set('pos', {'L_inout*3/4' '0'});
model.geom('geom1').feature('wp1').geom.feature('rot1').setIndex('pos', '2*w_ch*1.25', 1);
model.geom('geom1').feature('wp1').geom.run('rot1');
model.geom('geom1').feature('wp1').geom.create('uni1', 'Union');
model.geom('geom1').feature('wp1').geom.feature('uni1').selection('input').set({'dif2' 'rot1'});
model.geom('geom1').feature('wp1').geom.run('uni1');
model.geom('geom1').feature('wp1').geom.create('mov1', 'Move');
model.geom('geom1').feature('wp1').geom.feature('mov1').selection('input').set({'uni1'});
model.geom('geom1').feature('wp1').geom.feature('mov1').set('displx', '-L_inout-w_ch*0.5');
model.geom('geom1').feature('wp1').geom.feature('mov1').set('disply', '-w_ch*2.5');
model.geom('geom1').feature('wp1').geom.run('mov1');
model.geom('geom1').feature('wp1').geom.create('r3', 'Rectangle');
model.geom('geom1').feature('wp1').geom.feature('r3').set('size', {'w_ch' 'L_ch+10*w_ch'});
model.geom('geom1').feature('wp1').geom.feature('r3').set('pos', {'-w_ch/2' '-5*w_ch'});
model.geom('geom1').feature('wp1').geom.run('r3');
model.geom('geom1').feature('wp1').geom.create('arr2', 'Array');
model.geom('geom1').feature('wp1').geom.feature('arr2').selection('input').set({'r3'});
model.geom('geom1').feature('wp1').geom.feature('arr2').set('fullsize', {'N_ch' '1'});
model.geom('geom1').feature('wp1').geom.feature('arr2').set('displ', {'w_ch*2' '0'});
model.geom('geom1').feature('wp1').geom.run('arr2');
model.geom('geom1').feature('wp1').geom.create('r4', 'Rectangle');
model.geom('geom1').feature('wp1').geom.feature('r4').set('size', {'(N_ch-0.5)*(2*w_ch)' '1'});
model.geom('geom1').feature('wp1').geom.feature('r4').setIndex('size', 'w_ch', 1);
model.geom('geom1').feature('wp1').geom.feature('r4').set('pos', {'-w_ch/2' '-w_ch*5'});
model.geom('geom1').feature('wp1').geom.run('r4');
model.geom('geom1').feature('wp1').geom.create('arr3', 'Array');
model.geom('geom1').feature('wp1').geom.feature('arr3').selection('input').set({'r4'});
model.geom('geom1').feature('wp1').geom.feature('arr3').set('fullsize', [1 3]);
model.geom('geom1').feature('wp1').geom.feature('arr3').set('displ', {'0' 'w_ch*2'});
model.geom('geom1').feature('wp1').geom.run('arr3');
model.geom('geom1').feature('wp1').geom.create('copy1', 'Copy');
model.geom('geom1').feature('wp1').geom.feature('copy1').selection('input').set({'arr3'});
model.geom('geom1').feature('wp1').geom.feature('copy1').set('disply', 'L_ch+5*w_ch');
model.geom('geom1').feature('wp1').geom.run('copy1');
model.geom('geom1').feature('wp1').geom.create('rot2', 'Rotate');
model.geom('geom1').feature('wp1').geom.feature('rot2').selection('input').set({'mov1'});
model.geom('geom1').feature('wp1').geom.feature('rot2').set('rot', 180);
model.geom('geom1').feature('wp1').geom.feature('rot2').set('pos', {'(N_ch-1)*w_ch' '0'});
model.geom('geom1').feature('wp1').geom.feature('rot2').setIndex('pos', 'L_ch/2', 1);
model.geom('geom1').feature('wp1').geom.feature('rot2').set('keep', true);
model.geom('geom1').feature('wp1').geom.run('rot2');
model.geom('geom1').feature('wp1').geom.create('uni2', 'Union');
model.geom('geom1').feature('wp1').geom.feature('uni2').selection('input').set({'arr2' 'arr3' 'copy1' 'mov1' 'rot2'});
model.geom('geom1').feature('wp1').geom.run('uni2');
model.geom('geom1').feature('wp1').geom.create('boxsel1', 'BoxSelection');
model.geom('geom1').feature('wp1').geom.feature('boxsel1').label('Fillet Selection 1');
model.geom('geom1').feature('wp1').geom.feature('boxsel1').set('entitydim', 0);
model.geom('geom1').feature('wp1').geom.feature('boxsel1').set('xmax', 0);
model.geom('geom1').feature('wp1').geom.feature('boxsel1').set('ymin', 'L_ch+w_ch*4.5');
model.geom('geom1').feature('wp1').geom.run('boxsel1');
model.geom('geom1').feature('wp1').geom.create('boxsel2', 'BoxSelection');
model.geom('geom1').feature('wp1').geom.feature('boxsel2').label('Fillet Selection 2');
model.geom('geom1').feature('wp1').geom.feature('boxsel2').set('entitydim', 0);
model.geom('geom1').feature('wp1').geom.feature('boxsel2').set('xmin', '2*w_ch*(N_ch-1)');
model.geom('geom1').feature('wp1').geom.feature('boxsel2').set('ymax', '-w_ch*4.5');
model.geom('geom1').feature('wp1').geom.run('boxsel2');
model.geom('geom1').feature('wp1').geom.create('fil1', 'Fillet');
model.geom('geom1').feature('wp1').geom.feature('fil1').selection('point').named('boxsel1');
model.geom('geom1').feature('wp1').geom.feature('fil1').set('radius', 'w_ch/2');
model.geom('geom1').feature('wp1').geom.run('fil1');
model.geom('geom1').feature('wp1').geom.feature.duplicate('fil2', 'fil1');
model.geom('geom1').feature('wp1').geom.feature('fil2').selection('point').named('boxsel2');
model.geom('geom1').feature('wp1').geom.run('fil2');
model.geom('geom1').run('wp1');
model.geom('geom1').feature.create('ext1', 'Extrude');
model.geom('geom1').feature('ext1').setIndex('distance', 'h_a', 0);
model.geom('geom1').run('ext1');
model.geom('geom1').create('cyl1', 'Cylinder');
model.geom('geom1').feature('cyl1').set('r', 'R_in');
model.geom('geom1').feature('cyl1').set('h', '3*h_a');
model.geom('geom1').run('cyl1');
model.geom('geom1').create('rot1', 'Rotate');
model.geom('geom1').feature('rot1').selection('input').set({'cyl1'});
model.geom('geom1').feature('rot1').set('rot', 'ang_inout');
model.geom('geom1').feature('rot1').set('pos', {'L_inout*3/4' '0' '0'});
model.geom('geom1').feature('rot1').setIndex('pos', '2*w_ch*1.25', 1);
model.geom('geom1').run('rot1');
model.geom('geom1').create('mov1', 'Move');
model.geom('geom1').feature('mov1').selection('input').set({'rot1'});
model.geom('geom1').feature('mov1').set('displx', '-L_inout-w_ch*0.5');
model.geom('geom1').feature('mov1').set('disply', '-w_ch*2.5');
model.geom('geom1').run('mov1');
model.geom('geom1').create('rot2', 'Rotate');
model.geom('geom1').feature('rot2').selection('input').set({'mov1'});
model.geom('geom1').feature('rot2').set('keep', true);
model.geom('geom1').feature('rot2').set('rot', 180);
model.geom('geom1').feature('rot2').set('pos', {'(N_ch-1)*w_ch' '0' '0'});
model.geom('geom1').feature('rot2').setIndex('pos', 'L_ch/2', 1);
model.geom('geom1').run('rot2');
model.geom('geom1').run('fin');
model.geom('geom1').create('boxsel1', 'BoxSelection');
model.geom('geom1').feature('boxsel1').label('Inlet Manifold');
model.geom('geom1').feature('boxsel1').set('xmin', '-L_inout');
model.geom('geom1').feature('boxsel1').set('ymax', 'w_ch/2');
model.geom('geom1').feature('boxsel1').set('condition', 'inside');
model.geom('geom1').run('boxsel1');
model.geom('geom1').create('boxsel2', 'BoxSelection');
model.geom('geom1').feature('boxsel2').label('Outlet Manifold');
model.geom('geom1').feature('boxsel2').set('xmax', 'N_ch*w_ch*2+L_inout-w_ch');
model.geom('geom1').feature('boxsel2').set('ymin', 'L_ch-w_ch/2');
model.geom('geom1').feature('boxsel2').set('condition', 'inside');
model.geom('geom1').run('boxsel2');
model.geom('geom1').create('boxsel3', 'BoxSelection');
model.geom('geom1').feature('boxsel3').label('Channels Above Electrode Surface');
model.geom('geom1').feature('boxsel3').set('ymin', '-w_ch/2');
model.geom('geom1').feature('boxsel3').set('ymax', 'L_ch+w_ch/2');
model.geom('geom1').feature('boxsel3').set('condition', 'inside');
model.geom('geom1').run('boxsel3');
model.geom('geom1').create('boxsel4', 'BoxSelection');
model.geom('geom1').feature('boxsel4').label('Electrode Surface');
model.geom('geom1').feature('boxsel4').set('entitydim', 2);
model.geom('geom1').feature('boxsel4').set('ymin', '-w_ch/2');
model.geom('geom1').feature('boxsel4').set('ymax', 'L_ch+w_ch/2');
model.geom('geom1').feature('boxsel4').set('zmax', 'h_a/2');
model.geom('geom1').feature('boxsel4').set('condition', 'inside');
model.geom('geom1').run('boxsel4');
model.geom('geom1').create('boxsel5', 'BoxSelection');
model.geom('geom1').feature('boxsel5').label('Inlet');
model.geom('geom1').feature('boxsel5').set('entitydim', 2);
model.geom('geom1').feature('boxsel5').set('xmax', 0);
model.geom('geom1').feature('boxsel5').set('zmin', 'h_a*2');
model.geom('geom1').feature('boxsel5').set('condition', 'inside');
model.geom('geom1').run('boxsel5');
model.geom('geom1').create('boxsel6', 'BoxSelection');
model.geom('geom1').feature('boxsel6').set('entitydim', 2);
model.geom('geom1').feature('boxsel6').label('Outlet');
model.geom('geom1').feature('boxsel6').set('xmin', 'N_ch*w_ch*2');
model.geom('geom1').feature('boxsel6').set('zmin', 'h_a*2');
model.geom('geom1').feature('boxsel6').set('condition', 'inside');
model.geom('geom1').run('boxsel6');
model.geom('geom1').create('adjsel1', 'AdjacentSelection');
model.geom('geom1').feature('adjsel1').label('Exterior Boundaries to Electrode Channels');
model.geom('geom1').feature('adjsel1').set('input', {'boxsel3'});
model.geom('geom1').run('adjsel1');
model.geom('geom1').create('adjsel2', 'AdjacentSelection');
model.geom('geom1').feature('adjsel2').label('Exterior Boundaries to Inlet Manifold');
model.geom('geom1').feature('adjsel2').set('input', {'boxsel1'});
model.geom('geom1').run('adjsel2');
model.geom('geom1').create('intsel1', 'IntersectionSelection');
model.geom('geom1').feature('intsel1').label('Inlets to Electrode Channels');
model.geom('geom1').feature('intsel1').set('entitydim', 2);
model.geom('geom1').feature('intsel1').set('input', {'adjsel1' 'adjsel2'});
model.geom('geom1').run('intsel1');
model.geom('geom1').create('unisel1', 'UnionSelection');
model.geom('geom1').feature('unisel1').label('Manifolds');
model.geom('geom1').feature('unisel1').set('input', {'boxsel1' 'boxsel2'});
model.geom('geom1').run('unisel1');
model.geom('geom1').create('adjsel3', 'AdjacentSelection');
model.geom('geom1').feature('adjsel3').label('Exterior Boundaries to Manifolds');
model.geom('geom1').feature('adjsel3').set('input', {'unisel1'});
model.geom('geom1').run('adjsel3');
model.geom('geom1').create('intsel2', 'IntersectionSelection');
model.geom('geom1').feature('intsel2').label('Inlets and Outlets to Electrode Channels');
model.geom('geom1').feature('intsel2').set('entitydim', 2);
model.geom('geom1').feature('intsel2').set('input', {'adjsel1' 'adjsel3'});
model.geom('geom1').run('intsel2');
model.geom('geom1').create('unisel2', 'UnionSelection');
model.geom('geom1').feature('unisel2').label('Electrode Channels and Manifolds');
model.geom('geom1').feature('unisel2').set('input', {'boxsel1' 'boxsel2' 'boxsel3'});
model.geom('geom1').run('unisel2');
model.geom('geom1').create('adjsel4', 'AdjacentSelection');
model.geom('geom1').feature('adjsel4').label('Exterior Boundaries to Outlet Manifold');
model.geom('geom1').feature('adjsel4').set('input', {'boxsel2'});
model.geom('geom1').run('adjsel4');
model.geom('geom1').create('intsel3', 'IntersectionSelection');
model.geom('geom1').feature('intsel3').label('Outlets from Electrode Channels');
model.geom('geom1').feature('intsel3').set('entitydim', 2);
model.geom('geom1').feature('intsel3').set('input', {'adjsel1' 'adjsel4'});

model.title([]);

model.description('');

model.label('pem_electrolyzer_geom_sequence.mph');

model.modelNode.label('Components');

out = model;
