function out = model
%
% thermal_runaway_propagation_geom_sequence.m
%
% Model exported on May 26 2025, 21:26 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/Battery_Design_Module/Thermal_Management');

% To import content from file, use:
% model.param.loadFile('FILENAME');
model.param.set('d_batt', '21[mm]', 'Battery diameter');
model.param.set('h_batt', '70[mm]', 'Battery height');
model.param.set('d_term', '6[mm]', 'Terminal diameter');
model.param.set('h_term', '1[mm]', 'Terminal thickness');
model.param.set('w_sc', '3[mm]', 'Serial connector width');
model.param.set('h_sc', '1[mm]', 'Serial connector height');
model.param.set('h_pc', '0.5[mm]', 'Parallel connector height');
model.param.set('w_pc', '1[mm]', 'Parallel connector width');
model.param.set('h_holder', '10[mm]', 'Holder height');
model.param.set('gap', '2[mm]', 'Gap between battery cylinders');
model.param.set('nx_batt', '5', 'Number of batteries in x direction');
model.param.set('ny_batt', '4', 'Number of batteries in y direction');
model.param.set('n_batt', 'nx_batt*ny_batt', 'Number of batteries');
model.param.set('r_batt', 'd_batt/2', 'Battery radius');
model.param.set('r_term', 'd_term/2', 'Terminal radius');
model.param.set('x_disp', 'd_batt+gap', 'x displacement for serially connected batteries');
model.param.set('y_disp', 'x_disp*tan(60[deg])/2', 'y displacement for batteries connected in parallel');
model.param.set('x_offset', '(d_batt+gap)/2', 'x displacement for batteries connected in parallel');

model.geom.create('part1', 'Part', 3);
model.geom('part1').label('Part 1 - Battery Cylinders');
model.geom('part1').create('wp1', 'WorkPlane');
model.geom('part1').feature('wp1').set('unite', true);
model.geom('part1').feature('wp1').geom.create('c1', 'Circle');
model.geom('part1').feature('wp1').geom.feature('c1').set('r', 'r_batt');
model.geom('part1').feature('wp1').geom.run('c1');
model.geom('part1').feature('wp1').geom.create('if1', 'If');
model.geom('part1').feature('wp1').geom.feature.createAfter('endif1', 'EndIf', 'if1');
model.geom('part1').feature('wp1').geom.feature('if1').label('If (ny_batt>1)');
model.geom('part1').feature('wp1').geom.feature('if1').set('condition', 'ny_batt>1');
model.geom('part1').feature('wp1').geom.create('copy1', 'Copy');
model.geom('part1').feature('wp1').geom.feature('copy1').selection('input').set({'c1'});
model.geom('part1').feature('wp1').geom.feature('copy1').set('displx', 'x_offset');
model.geom('part1').feature('wp1').geom.feature('copy1').set('disply', 'y_disp');
model.geom('part1').feature('wp1').geom.run('copy1');
model.geom('part1').feature('wp1').geom.create('arr1', 'Array');
model.geom('part1').feature('wp1').geom.feature('arr1').selection('input').set({'copy1'});
model.geom('part1').feature('wp1').geom.feature('arr1').set('fullsize', {'1' 'floor(ny_batt/2)'});
model.geom('part1').feature('wp1').geom.feature('arr1').set('displ', {'0' 'y_disp*2'});
model.geom('part1').feature('wp1').geom.run('arr1');
model.geom('part1').feature('wp1').geom.run('endif1');
model.geom('part1').feature('wp1').geom.create('arr2', 'Array');
model.geom('part1').feature('wp1').geom.feature('arr2').selection('input').set({'c1'});
model.geom('part1').feature('wp1').geom.feature('arr2').set('fullsize', {'1' 'ceil(ny_batt/2)'});
model.geom('part1').feature('wp1').geom.feature('arr2').set('displ', {'0' '2*y_disp'});
model.geom('part1').feature('wp1').geom.run('arr2');
model.geom('part1').feature('wp1').geom.create('if2', 'If');
model.geom('part1').feature('wp1').geom.feature.createAfter('endif2', 'EndIf', 'if2');
model.geom('part1').feature('wp1').geom.feature('if2').label('If (nx_batt>1)');
model.geom('part1').feature('wp1').geom.feature('if2').set('condition', 'nx_batt>1');
model.geom('part1').feature('wp1').geom.create('copy2', 'Copy');
model.geom('part1').feature('wp1').geom.feature('copy2').selection('input').set({'arr1' 'arr2'});
model.geom('part1').feature('wp1').geom.feature('copy2').set('displx', 'x_disp');
model.geom('part1').feature('wp1').geom.run('copy2');
model.geom('part1').feature('wp1').geom.create('arr3', 'Array');
model.geom('part1').feature('wp1').geom.feature('arr3').selection('input').set({'copy2'});
model.geom('part1').feature('wp1').geom.feature('arr3').set('fullsize', {'floor(nx_batt/2)' '1'});
model.geom('part1').feature('wp1').geom.feature('arr3').set('displ', {'2*x_disp' '0'});
model.geom('part1').feature('wp1').geom.selection.create('csel1', 'CumulativeSelection');
model.geom('part1').feature('wp1').geom.selection('csel1').label('battery faces, up oriented');
model.geom('part1').feature('wp1').geom.feature('arr3').set('contributeto', 'csel1');
model.geom('part1').feature('wp1').geom.run('arr3');
model.geom('part1').feature('wp1').geom.run('endif2');
model.geom('part1').feature('wp1').geom.create('arr4', 'Array');
model.geom('part1').feature('wp1').geom.feature('arr4').selection('input').set({'arr1' 'arr2'});
model.geom('part1').feature('wp1').geom.feature('arr4').set('fullsize', {'ceil(nx_batt/2)' '1'});
model.geom('part1').feature('wp1').geom.feature('arr4').set('displ', {'2*x_disp' '0'});
model.geom('part1').feature('wp1').geom.selection.create('csel2', 'CumulativeSelection');
model.geom('part1').feature('wp1').geom.selection('csel2').label('battery faces, down oriented');
model.geom('part1').feature('wp1').geom.feature('arr4').set('contributeto', 'csel2');
model.geom('part1').feature('wp1').geom.run('arr4');
model.geom('part1').run('wp1');
model.geom('part1').feature.create('ext1', 'Extrude');
model.geom('part1').feature('ext1').set('workplane', 'wp1');
model.geom('part1').feature('ext1').selection('input').set({'wp1'});
model.geom('part1').feature('ext1').set('extrudefrom', 'faces');
model.geom('part1').feature('ext1').selection('inputface').named('wp1_csel2');
model.geom('part1').feature('ext1').set('inputhandling', 'keep');
model.geom('part1').feature('ext1').setIndex('distance', 'h_holder', 0);
model.geom('part1').feature('ext1').setIndex('distance', 'h_batt-h_holder', 1);
model.geom('part1').feature('ext1').set('displ', {'0' '0'; '0' '0'});
model.geom('part1').feature('ext1').set('scale', {'1' '1'; '1' '1'});
model.geom('part1').feature('ext1').set('twist', {'0' '0'});
model.geom('part1').feature('ext1').setIndex('distance', 'h_batt', 2);
model.geom('part1').feature('ext1').set('displ', {'0' '0'; '0' '0'; '0' '0'});
model.geom('part1').feature('ext1').set('scale', {'1' '1'; '1' '1'; '1' '1'});
model.geom('part1').feature('ext1').set('twist', {'0' '0' '0'});
model.geom('part1').selection.create('csel1', 'CumulativeSelection');
model.geom('part1').selection('csel1').label('batteries, down oriented');
model.geom('part1').feature('ext1').set('contributeto', 'csel1');
model.geom('part1').run('ext1');
model.geom('part1').feature.duplicate('ext2', 'ext1');
model.geom('part1').feature('ext2').selection('inputface').named('wp1_csel1');
model.geom('part1').selection.create('csel2', 'CumulativeSelection');
model.geom('part1').selection('csel2').label('batteries, up oriented');
model.geom('part1').feature('ext2').set('contributeto', 'csel2');
model.geom('part1').run('ext2');
model.geom.create('part2', 'Part', 3);
model.geom('part2').label('Part 2 - Conductors');
model.geom('part2').create('cyl1', 'Cylinder');
model.geom('part2').feature('cyl1').set('r', 'r_term');
model.geom('part2').feature('cyl1').set('h', 'h_term');
model.geom('part2').feature('cyl1').set('pos', {'0' '0' '-h_term'});
model.geom('part2').run('cyl1');
model.geom('part2').create('arr1', 'Array');
model.geom('part2').feature('arr1').selection('input').set({'cyl1'});
model.geom('part2').feature('arr1').set('fullsize', {'nx_batt' 'ceil(ny_batt/2)' '1'});
model.geom('part2').feature('arr1').setIndex('fullsize', 2, 2);
model.geom('part2').feature('arr1').set('displ', {'x_disp' '2*y_disp' '0'});
model.geom('part2').feature('arr1').setIndex('displ', 'h_batt+h_term', 2);
model.geom('part2').run('arr1');
model.geom('part2').create('cyl2', 'Cylinder');
model.geom('part2').feature('cyl2').set('r', 'r_term');
model.geom('part2').feature('cyl2').set('h', 'h_term');
model.geom('part2').feature('cyl2').set('pos', {'x_offset' 'y_disp' '0'});
model.geom('part2').feature('cyl2').setIndex('pos', '-h_term', 2);
model.geom('part2').run('cyl2');
model.geom('part2').create('arr2', 'Array');
model.geom('part2').feature('arr2').selection('input').set({'cyl2'});
model.geom('part2').feature('arr2').set('fullsize', {'nx_batt' 'floor(ny_batt/2)' '1'});
model.geom('part2').feature('arr2').setIndex('fullsize', 2, 2);
model.geom('part2').feature('arr2').set('displ', {'x_disp' 'y_disp*2' '0'});
model.geom('part2').feature('arr2').setIndex('displ', 'h_batt+h_term', 2);
model.geom('part2').run('arr2');
model.geom('part2').create('blk1', 'Block');
model.geom('part2').feature('blk1').set('size', {'x_disp' 'w_sc' 'h_sc'});
model.geom('part2').feature('blk1').set('pos', {'-x_disp+w_pc/2' '0' '0'});
model.geom('part2').feature('blk1').setIndex('pos', '-w_sc/2', 1);
model.geom('part2').feature('blk1').setIndex('pos', 'h_batt+h_term', 2);
model.geom('part2').run('blk1');
model.geom('part2').create('arr3', 'Array');
model.geom('part2').feature('arr3').selection('input').set({'blk1'});
model.geom('part2').feature('arr3').set('type', 'linear');
model.geom('part2').feature('arr3').set('linearsize', 'ceil(ny_batt/2)');
model.geom('part2').feature('arr3').set('displ', {'0' '2*y_disp' '0'});
model.geom('part2').run('arr3');
model.geom('part2').feature.duplicate('blk2', 'blk1');
model.geom('part2').feature('blk2').set('size', {'x_disp+x_offset' 'w_sc' 'h_sc'});
model.geom('part2').feature('blk2').setIndex('pos', '-w_sc/2+y_disp', 1);
model.geom('part2').run('blk2');
model.geom('part2').create('arr4', 'Array');
model.geom('part2').feature('arr4').selection('input').set({'blk2'});
model.geom('part2').feature('arr4').set('type', 'linear');
model.geom('part2').feature('arr4').set('linearsize', 'floor(ny_batt/2)');
model.geom('part2').feature('arr4').set('displ', {'0' '2*y_disp' '0'});
model.geom('part2').run('arr4');
model.geom('part2').create('if1', 'If');
model.geom('part2').feature.createAfter('endif1', 'EndIf', 'if1');
model.geom('part2').feature('if1').label('If is Even in nx');
model.geom('part2').feature('if1').set('condition', 'mod(nx_batt,2)==0');
model.geom('part2').run('if1');
model.geom('part2').create('blk3', 'Block');
model.geom('part2').feature('blk3').set('size', {'3*r_batt' 'w_sc' '1'});
model.geom('part2').feature('blk3').setIndex('size', 'h_sc', 2);
model.geom('part2').feature('blk3').set('pos', {'(nx_batt-1)*x_disp-w_pc/2' '0' '0'});
model.geom('part2').feature('blk3').setIndex('pos', '-w_sc/2', 1);
model.geom('part2').feature('blk3').setIndex('pos', 'h_batt+h_term', 2);
model.geom('part2').run('blk3');
model.geom('part2').feature('blk3').set('size', {'x_disp+x_offset' 'w_sc' 'h_sc'});
model.geom('part2').run('blk3');
model.geom('part2').create('arr5', 'Array');
model.geom('part2').feature('arr5').selection('input').set({'blk3'});
model.geom('part2').feature('arr5').set('type', 'linear');
model.geom('part2').feature('arr5').set('linearsize', 'ceil(ny_batt/2)');
model.geom('part2').feature('arr5').set('displ', {'0' '2*y_disp' '0'});
model.geom('part2').run('arr5');
model.geom('part2').feature.duplicate('blk4', 'blk3');
model.geom('part2').feature('blk4').set('size', {'x_disp' 'w_sc' 'h_sc'});
model.geom('part2').feature('blk4').setIndex('pos', '(nx_batt-1)*x_disp-w_pc/2+x_offset', 0);
model.geom('part2').feature('blk4').setIndex('pos', '-w_sc/2+y_disp', 1);
model.geom('part2').run('blk4');
model.geom('part2').create('arr6', 'Array');
model.geom('part2').feature('arr6').selection('input').set({'blk4'});
model.geom('part2').feature('arr6').set('type', 'linear');
model.geom('part2').feature('arr6').set('linearsize', 'floor(ny_batt/2)');
model.geom('part2').feature('arr6').set('displ', {'0' '2*y_disp' '0'});
model.geom('part2').run('arr6');
model.geom('part2').create('else1', 'Else');
model.geom('part2').run('else1');
model.geom('part2').create('blk5', 'Block');
model.geom('part2').feature('blk5').set('size', {'x_disp+x_offset' '1' '1'});
model.geom('part2').feature('blk5').setIndex('size', 'w_sc', 1);
model.geom('part2').feature('blk5').setIndex('size', 'h_sc', 2);
model.geom('part2').feature('blk5').set('pos', {'(nx_batt-1)*x_disp-w_pc/2' '0' '0'});
model.geom('part2').feature('blk5').setIndex('pos', '-w_sc/2', 1);
model.geom('part2').feature('blk5').setIndex('pos', '-h_term-h_sc', 2);
model.geom('part2').run('blk5');
model.geom('part2').create('arr7', 'Array');
model.geom('part2').feature('arr7').selection('input').set({'blk5'});
model.geom('part2').feature('arr7').set('type', 'linear');
model.geom('part2').feature('arr7').set('linearsize', 'ceil(ny_batt/2)');
model.geom('part2').feature('arr7').set('displ', {'0' '2*y_disp' '0'});
model.geom('part2').run('arr7');
model.geom('part2').create('blk6', 'Block');
model.geom('part2').feature('blk6').set('size', {'x_disp' 'w_sc' 'h_sc'});
model.geom('part2').feature('blk6').set('pos', {'(nx_batt-1)*x_disp-w_pc/2+x_offset' '0' '0'});
model.geom('part2').feature('blk6').setIndex('pos', '-w_sc/2+y_disp', 1);
model.geom('part2').feature('blk6').setIndex('pos', '-h_term-h_sc', 2);
model.geom('part2').run('blk6');
model.geom('part2').create('arr8', 'Array');
model.geom('part2').feature('arr8').selection('input').set({'blk6'});
model.geom('part2').feature('arr8').set('type', 'linear');
model.geom('part2').feature('arr8').set('linearsize', 'floor(ny_batt/2)');
model.geom('part2').feature('arr8').set('displ', {'0' '2*y_disp' '0'});
model.geom('part2').run('arr8');
model.geom('part2').run('endif1');
model.geom('part2').create('blk7', 'Block');
model.geom('part2').feature('blk7').set('size', {'x_disp' 'w_sc' 'h_sc'});
model.geom('part2').feature('blk7').set('pos', {'0' '-w_sc/2' '-h_sc-h_term'});
model.geom('part2').run('blk7');
model.geom('part2').create('arr9', 'Array');
model.geom('part2').feature('arr9').selection('input').set({'blk7'});
model.geom('part2').feature('arr9').set('fullsize', {'floor(nx_batt/2)' '1' '1'});
model.geom('part2').feature('arr9').setIndex('fullsize', 'ceil(ny_batt/2)', 1);
model.geom('part2').feature('arr9').set('displ', {'2*x_disp' '2*y_disp' '0'});
model.geom('part2').run('arr9');
model.geom('part2').create('if2', 'If');
model.geom('part2').feature.createAfter('endif2', 'EndIf', 'if2');
model.geom('part2').feature('if2').label('If (ny_batt>1) 2');
model.geom('part2').feature('if2').set('condition', 'ny_batt>1');
model.geom('part2').run('if2');
model.geom('part2').create('blk8', 'Block');
model.geom('part2').feature('blk8').set('size', {'x_disp' 'w_sc' 'h_sc'});
model.geom('part2').feature('blk8').set('pos', {'x_offset' '-w_sc/2+y_disp' '0'});
model.geom('part2').feature('blk8').setIndex('pos', '-h_sc-h_term', 2);
model.geom('part2').run('blk8');
model.geom('part2').create('arr10', 'Array');
model.geom('part2').feature('arr10').selection('input').set({'blk8'});
model.geom('part2').feature('arr10').set('fullsize', {'floor(nx_batt/2)' '1' '1'});
model.geom('part2').feature('arr10').setIndex('fullsize', 'floor(ny_batt/2)', 1);
model.geom('part2').feature('arr10').set('displ', {'2*x_disp' '2*y_disp' '0'});
model.geom('part2').run('arr10');
model.geom('part2').create('if3', 'If');
model.geom('part2').feature.createAfter('endif3', 'EndIf', 'if3');
model.geom('part2').feature('if3').label('If (nx_batt>2)');
model.geom('part2').feature('if3').set('condition', 'nx_batt>2');
model.geom('part2').run('if3');
model.geom('part2').create('blk9', 'Block');
model.geom('part2').feature('blk9').set('size', {'x_disp' 'w_sc' 'h_sc'});
model.geom('part2').feature('blk9').set('pos', {'x_disp' '-w_sc/2' '0'});
model.geom('part2').feature('blk9').setIndex('pos', 'h_batt+h_term', 2);
model.geom('part2').run('blk9');
model.geom('part2').create('arr11', 'Array');
model.geom('part2').feature('arr11').selection('input').set({'blk9'});
model.geom('part2').feature('arr11').set('fullsize', {'floor((nx_batt-1)/2)' '1' '1'});
model.geom('part2').feature('arr11').setIndex('fullsize', 'ceil(ny_batt/2)', 1);
model.geom('part2').feature('arr11').set('displ', {'2*x_disp' '2*y_disp' '0'});
model.geom('part2').run('arr11');
model.geom('part2').create('if4', 'If');
model.geom('part2').feature.createAfter('endif4', 'EndIf', 'if4');
model.geom('part2').feature('if4').label('If (ny_batt>1)');
model.geom('part2').feature('if4').set('condition', 'ny_batt>1');
model.geom('part2').run('if4');
model.geom('part2').create('blk10', 'Block');
model.geom('part2').feature('blk10').set('size', {'x_disp' 'w_sc' 'h_sc'});
model.geom('part2').feature('blk10').set('pos', {'x_disp+x_offset' 'y' '0'});
model.geom('part2').feature('blk10').setIndex('pos', 'y_disp-w_sc/2', 1);
model.geom('part2').feature('blk10').setIndex('pos', 'h_batt+h_term', 2);
model.geom('part2').run('blk10');
model.geom('part2').create('arr12', 'Array');
model.geom('part2').feature('arr12').selection('input').set({'blk10'});
model.geom('part2').feature('arr12').set('fullsize', {'floor((nx_batt-1)/2)' '1' '1'});
model.geom('part2').feature('arr12').setIndex('fullsize', 'floor((ny_batt)/2)', 1);
model.geom('part2').feature('arr12').set('displ', {'2*x_disp' '2*y_disp' '0'});
model.geom('part2').run('arr12');
model.geom('part2').run('endif2');
model.geom('part2').create('if5', 'If');
model.geom('part2').feature.createAfter('endif5', 'EndIf', 'if5');
model.geom('part2').feature('if5').label('If (ny_batt>1 && nx_batt>1)');
model.geom('part2').feature('if5').set('condition', 'ny_batt>1 && nx_batt>1');
model.geom('part2').create('wp1', 'WorkPlane');
model.geom('part2').feature('wp1').set('unite', true);
model.geom('part2').feature('wp1').set('quickz', '-h_term-h_sc');
model.geom('part2').feature('wp1').geom.create('pol1', 'Polygon');
model.geom('part2').feature('wp1').geom.feature('pol1').set('source', 'table');
model.geom('part2').feature('wp1').geom.feature('pol1').setIndex('table', 'x_disp/2-w_pc/2', 0, 0);
model.geom('part2').feature('wp1').geom.feature('pol1').setIndex('table', 0, 0, 1);
model.geom('part2').feature('wp1').geom.feature('pol1').setIndex('table', 'x_disp/2-w_pc/2+x_offset', 1, 0);
model.geom('part2').feature('wp1').geom.feature('pol1').setIndex('table', 'y_disp', 1, 1);
model.geom('part2').feature('wp1').geom.feature('pol1').setIndex('table', 'x_disp/2+w_pc/2+x_offset', 2, 0);
model.geom('part2').feature('wp1').geom.feature('pol1').setIndex('table', 'y_disp', 2, 1);
model.geom('part2').feature('wp1').geom.feature('pol1').setIndex('table', 'x_disp/2+w_pc/2', 3, 0);
model.geom('part2').feature('wp1').geom.feature('pol1').setIndex('table', 0, 3, 1);
model.geom('part2').feature('wp1').geom.run('pol1');
model.geom('part2').feature('wp1').geom.create('arr1', 'Array');
model.geom('part2').feature('wp1').geom.feature('arr1').selection('input').set({'pol1'});
model.geom('part2').feature('wp1').geom.feature('arr1').set('fullsize', {'ceil(nx_batt/2)' '1'});
model.geom('part2').feature('wp1').geom.feature('arr1').setIndex('fullsize', 'floor(ny_batt/2)', 1);
model.geom('part2').feature('wp1').geom.feature('arr1').set('displ', {'x_disp*2' 'y_disp*2'});
model.geom('part2').feature('wp1').geom.run('arr1');
model.geom('part2').feature('wp1').geom.create('if1', 'If');
model.geom('part2').feature('wp1').geom.feature.createAfter('endif1', 'EndIf', 'if1');
model.geom('part2').feature('wp1').geom.feature('if1').label('If (ny_batt>2)');
model.geom('part2').feature('wp1').geom.feature('if1').set('condition', 'ny_batt>2');
model.geom('part2').feature('wp1').geom.feature.duplicate('pol2', 'pol1');
model.geom('part2').feature('wp1').geom.feature('pol2').setIndex('table', '2*y_disp', 0, 1);
model.geom('part2').feature('wp1').geom.feature('pol2').setIndex('table', '2*y_disp', 3, 1);
model.geom('part2').feature('wp1').geom.run('pol2');
model.geom('part2').feature('wp1').geom.create('arr2', 'Array');
model.geom('part2').feature('wp1').geom.feature('arr2').selection('input').set({'pol2'});
model.geom('part2').feature('wp1').geom.feature('arr2').set('fullsize', {'ceil(nx_batt/2)' '1'});
model.geom('part2').feature('wp1').geom.feature('arr2').setIndex('fullsize', 'floor((ny_batt-1)/2)', 1);
model.geom('part2').feature('wp1').geom.feature('arr2').set('displ', {'x_disp*2' 'y_disp*2'});
model.geom('part2').feature('wp1').geom.run('arr2');
model.geom('part2').feature('wp1').geom.run('endif1');
model.geom('part2').run('wp1');
model.geom('part2').feature.create('ext1', 'Extrude');
model.geom('part2').feature('ext1').setIndex('distance', '-h_pc', 0);
model.geom('part2').run('ext1');
model.geom('part2').create('if6', 'If');
model.geom('part2').feature.createAfter('endif6', 'EndIf', 'if6');
model.geom('part2').feature('if6').label('If (ny_batt>1 && nx_batt>2)');
model.geom('part2').feature('if6').set('condition', 'ny_batt>1 && nx_batt>2');
model.geom('part2').run('if6');
model.geom('part2').create('wp2', 'WorkPlane');
model.geom('part2').feature('wp2').set('unite', true);
model.geom('part2').feature('wp2').set('quickz', 'h_term+h_sc+h_batt');
model.geom('part2').feature('wp2').geom.create('pol1', 'Polygon');
model.geom('part2').feature('wp2').geom.feature('pol1').set('source', 'table');
model.geom('part2').feature('wp2').geom.feature('pol1').setIndex('table', '-x_disp/2-w_pc/2', 0, 0);
model.geom('part2').feature('wp2').geom.feature('pol1').setIndex('table', 0, 0, 1);
model.geom('part2').feature('wp2').geom.feature('pol1').setIndex('table', '-x_disp/2-w_pc/2+x_disp/2', 1, 0);
model.geom('part2').feature('wp2').geom.feature('pol1').setIndex('table', 'y_disp', 1, 1);
model.geom('part2').feature('wp2').geom.feature('pol1').setIndex('table', '-x_disp/2+w_pc/2+x_disp/2', 2, 0);
model.geom('part2').feature('wp2').geom.feature('pol1').setIndex('table', 'y_disp', 2, 1);
model.geom('part2').feature('wp2').geom.feature('pol1').setIndex('table', '-x_disp/2+w_pc/2', 3, 0);
model.geom('part2').feature('wp2').geom.feature('pol1').setIndex('table', 0, 3, 1);
model.geom('part2').feature('wp2').geom.run('pol1');
model.geom('part2').feature('wp2').geom.create('arr1', 'Array');
model.geom('part2').feature('wp2').geom.feature('arr1').selection('input').set({'pol1'});
model.geom('part2').feature('wp2').geom.feature('arr1').set('fullsize', {'ceil((nx_batt)/2)' '1'});
model.geom('part2').feature('wp2').geom.feature('arr1').setIndex('fullsize', 'floor(ny_batt/2)', 1);
model.geom('part2').feature('wp2').geom.feature('arr1').set('displ', {'x_disp*2' 'y_disp*2'});
model.geom('part2').feature('wp2').geom.run('arr1');
model.geom('part2').feature('wp2').geom.feature.duplicate('pol2', 'pol1');
model.geom('part2').feature('wp2').geom.feature('pol2').setIndex('table', '2*y_disp', 0, 1);
model.geom('part2').feature('wp2').geom.feature('pol2').setIndex('table', '2*y_disp', 3, 1);
model.geom('part2').feature('wp2').geom.run('pol2');
model.geom('part2').feature('wp2').geom.create('arr2', 'Array');
model.geom('part2').feature('wp2').geom.feature('arr2').selection('input').set({'pol2'});
model.geom('part2').feature('wp2').geom.feature('arr2').set('fullsize', {'ceil((nx_batt)/2)' '1'});
model.geom('part2').feature('wp2').geom.feature('arr2').setIndex('fullsize', 'floor((ny_batt-1)/2)', 1);
model.geom('part2').feature('wp2').geom.feature('arr2').set('displ', {'x_disp*2' 'y_disp*2'});
model.geom('part2').feature('wp2').geom.run('arr2');
model.geom('part2').run('wp2');
model.geom('part2').feature.create('ext2', 'Extrude');
model.geom('part2').feature('ext2').setIndex('distance', 'h_pc', 0);
model.geom('part2').run('ext2');
model.geom('part2').run('endif5');
model.geom('part2').create('boxsel1', 'BoxSelection');
model.geom('part2').feature('boxsel1').label('All Conductors');
model.geom('part2').feature('boxsel1').set('condition', 'inside');
model.geom('part2').run('boxsel1');
model.geom('part2').feature.duplicate('boxsel2', 'boxsel1');
model.geom('part2').feature('boxsel2').label('Conductor Boundaries, Top Side');
model.geom('part2').feature('boxsel2').set('entitydim', 2);
model.geom('part2').feature('boxsel2').set('zmin', 'h_batt/2');
model.geom('part2').run('boxsel2');
model.geom('part2').feature.duplicate('boxsel3', 'boxsel2');
model.geom('part2').feature('boxsel3').label('Conductor Boundaries, Bottom Side');
model.geom('part2').feature('boxsel3').set('zmin', -Inf);
model.geom('part2').feature('boxsel3').set('zmax', 'h_batt/2');
model.geom('part2').run('boxsel3');
model.geom('part2').feature.duplicate('boxsel4', 'boxsel3');
model.geom('part2').feature('boxsel4').label('Conductor Boundaries, Negative Terminals');
model.geom('part2').feature('boxsel4').set('xmax', '-x_disp/2');
model.geom('part2').feature('boxsel4').set('zmax', Inf);
model.geom('part2').run('boxsel4');
model.geom('part2').feature.duplicate('boxsel5', 'boxsel4');
model.geom('part2').feature('boxsel5').label('Conductor Boundaries, Positive Terminals');
model.geom('part2').feature('boxsel5').set('xmin', 'x_disp*nx_batt');
model.geom('part2').feature('boxsel5').set('xmax', Inf);
model.geom('part2').run('boxsel5');
model.geom.create('part3', 'Part', 3);
model.geom('part3').label('Part 3 - Holders');
model.geom('part3').create('wp1', 'WorkPlane');
model.geom('part3').feature('wp1').set('unite', true);
model.geom('part3').feature('wp1').geom.create('c1', 'Circle');
model.geom('part3').feature('wp1').geom.feature('c1').set('r', 'r_batt+gap');
model.geom('part3').feature('wp1').geom.feature.duplicate('c2', 'c1');
model.geom('part3').feature('wp1').geom.feature('c2').set('r', 'r_batt');
model.geom('part3').feature('wp1').geom.run('c2');
model.geom('part3').feature('wp1').geom.create('dif1', 'Difference');
model.geom('part3').feature('wp1').geom.feature('dif1').selection('input').set({'c1'});
model.geom('part3').feature('wp1').geom.feature('dif1').selection('input2').set({'c2'});
model.geom('part3').feature('wp1').geom.run('dif1');
model.geom('part3').feature('wp1').geom.create('copy1', 'Copy');
model.geom('part3').feature('wp1').geom.feature('copy1').selection('input').set({'dif1'});
model.geom('part3').feature('wp1').geom.feature('copy1').set('displx', 'x_offset');
model.geom('part3').feature('wp1').geom.feature('copy1').set('disply', 'y_disp');
model.geom('part3').feature('wp1').geom.run('copy1');
model.geom('part3').feature('wp1').geom.create('arr1', 'Array');
model.geom('part3').feature('wp1').geom.feature('arr1').selection('input').set({'copy1'});
model.geom('part3').feature('wp1').geom.feature('arr1').set('fullsize', {'1' 'floor(ny_batt/2)'});
model.geom('part3').feature('wp1').geom.feature('arr1').set('displ', {'0' '2*y_disp'});
model.geom('part3').feature('wp1').geom.run('arr1');
model.geom('part3').feature('wp1').geom.create('arr2', 'Array');
model.geom('part3').feature('wp1').geom.feature('arr2').selection('input').set({'dif1'});
model.geom('part3').feature('wp1').geom.feature('arr2').set('fullsize', {'1' 'ceil(ny_batt/2)'});
model.geom('part3').feature('wp1').geom.feature('arr2').set('displ', {'0' '2*y_disp'});
model.geom('part3').feature('wp1').geom.run('arr2');
model.geom('part3').feature('wp1').geom.create('arr3', 'Array');
model.geom('part3').feature('wp1').geom.feature('arr3').selection('input').set({'arr1' 'arr2'});
model.geom('part3').feature('wp1').geom.feature('arr3').set('fullsize', {'nx_batt' '1'});
model.geom('part3').feature('wp1').geom.feature('arr3').set('displ', {'x_disp' '0'});
model.geom('part3').feature('wp1').geom.run('arr3');
model.geom('part3').feature('wp1').geom.create('uni1', 'Union');
model.geom('part3').feature('wp1').geom.feature('uni1').selection('input').set({'arr3'});
model.geom('part3').feature('wp1').geom.feature('uni1').set('intbnd', false);
model.geom('part3').feature('wp1').geom.run('uni1');
model.geom('part3').run('wp1');
model.geom('part3').feature.create('ext1', 'Extrude');
model.geom('part3').feature('ext1').setIndex('distance', 'h_holder', 0);
model.geom('part3').selection.create('csel1', 'CumulativeSelection');
model.geom('part3').selection('csel1').label('Holders');
model.geom('part3').feature('ext1').set('contributeto', 'csel1');
model.geom('part3').run('ext1');
model.geom('part3').create('copy1', 'Copy');
model.geom('part3').feature('copy1').selection('input').set({'ext1'});
model.geom('part3').feature('copy1').set('displz', 'h_batt-h_holder');
model.geom('part3').feature('copy1').set('contributeto', 'csel1');
model.geom('part3').run('copy1');
model.geom.create('part4', 'Part', 3);
model.geom('part4').label('Part 4 - Wrapping');
model.geom('part4').create('wp1', 'WorkPlane');
model.geom('part4').feature('wp1').set('unite', true);
model.geom('part4').feature('wp1').set('quickz', '-h_term-h_sc-h_pc');
model.geom('part4').feature('wp1').geom.create('ca1', 'CircularArc');
model.geom('part4').feature('wp1').geom.feature('ca1').set('r', 'r_batt+gap');
model.geom('part4').feature('wp1').geom.feature('ca1').set('angle1', 180);
model.geom('part4').feature('wp1').geom.feature('ca1').set('angle2', 270);
model.geom('part4').feature('wp1').geom.run('ca1');
model.geom('part4').feature('wp1').geom.create('if1', 'If');
model.geom('part4').feature('wp1').geom.feature.createAfter('endif1', 'EndIf', 'if1');
model.geom('part4').feature('wp1').geom.feature('if1').label('If Even in ny_batt');
model.geom('part4').feature('wp1').geom.feature('if1').set('condition', '(mod(ny_batt,2)==0)');
model.geom('part4').feature('wp1').geom.create('ca2', 'CircularArc');
model.geom('part4').feature('wp1').geom.feature('ca2').set('center', {'(nx_batt-1)*x_disp' '0'});
model.geom('part4').feature('wp1').geom.feature('ca2').set('r', 'r_batt+gap');
model.geom('part4').feature('wp1').geom.feature('ca2').set('angle1', 270);
model.geom('part4').feature('wp1').geom.feature('ca2').set('angle2', 330);
model.geom('part4').feature('wp1').geom.run('ca2');
model.geom('part4').feature('wp1').geom.create('ca3', 'CircularArc');
model.geom('part4').feature('wp1').geom.feature('ca3').set('center', {'x_disp*(nx_batt-1) + x_offset' '0'});
model.geom('part4').feature('wp1').geom.feature('ca3').setIndex('center', 'y_disp', 1);
model.geom('part4').feature('wp1').geom.feature('ca3').set('r', 'r_batt+gap');
model.geom('part4').feature('wp1').geom.feature('ca3').set('angle1', 330);
model.geom('part4').feature('wp1').geom.feature('ca3').set('angle2', 360);
model.geom('part4').feature('wp1').geom.run('ca3');
model.geom('part4').feature('wp1').geom.create('ls1', 'LineSegment');
model.geom('part4').feature('wp1').geom.feature('ls1').selection('vertex1').set('ca1', 2);
model.geom('part4').feature('wp1').geom.feature('ls1').selection('vertex2').set('ca2', 1);
model.geom('part4').feature('wp1').geom.run('ls1');
model.geom('part4').feature('wp1').geom.create('ls2', 'LineSegment');
model.geom('part4').feature('wp1').geom.feature('ls2').selection('vertex1').set('ca2', 2);
model.geom('part4').feature('wp1').geom.feature('ls2').selection('vertex2').set('ca3', 1);
model.geom('part4').feature('wp1').geom.run('ls2');
model.geom('part4').feature('wp1').geom.create('uni1', 'Union');
model.geom('part4').feature('wp1').geom.feature('uni1').selection('input').set({'ca1' 'ca2' 'ca3' 'ls1' 'ls2'});
model.geom('part4').feature('wp1').geom.run('uni1');
model.geom('part4').feature('wp1').geom.create('mir1', 'Mirror');
model.geom('part4').feature('wp1').geom.feature('mir1').selection('input').set({'uni1'});
model.geom('part4').feature('wp1').geom.feature('mir1').set('keep', true);
model.geom('part4').feature('wp1').geom.feature('mir1').set('pos', {'0' '(ny_batt-1)*y_disp/2'});
model.geom('part4').feature('wp1').geom.feature('mir1').set('axis', [0 1]);
model.geom('part4').feature('wp1').geom.run('mir1');
model.geom('part4').feature('wp1').geom.create('mir2', 'Mirror');
model.geom('part4').feature('wp1').geom.feature('mir2').selection('input').set({'mir1'});
model.geom('part4').feature('wp1').geom.feature('mir2').set('pos', {'(x_disp*(nx_batt -1)+x_offset)/2' '0'});
model.geom('part4').feature('wp1').geom.run('mir2');
model.geom('part4').feature('wp1').geom.create('ls3', 'LineSegment');
model.geom('part4').feature('wp1').geom.feature('ls3').selection('vertex1').set('uni1', 1);
model.geom('part4').feature('wp1').geom.feature('ls3').selection('vertex2').set('mir2', 6);
model.geom('part4').feature('wp1').geom.run('ls3');
model.geom('part4').feature('wp1').geom.create('ls4', 'LineSegment');
model.geom('part4').feature('wp1').geom.feature('ls4').selection('vertex1').set('uni1', 6);
model.geom('part4').feature('wp1').geom.feature('ls4').selection('vertex2').set('mir2', 1);
model.geom('part4').feature('wp1').geom.run('ls4');
model.geom('part4').feature('wp1').geom.create('csol1', 'ConvertToSolid');
model.geom('part4').feature('wp1').geom.feature('csol1').selection('input').set({'ls3' 'ls4' 'mir2' 'uni1'});
model.geom('part4').feature('wp1').geom.run('csol1');
model.geom('part4').feature('wp1').geom.create('else1', 'Else');

model.param.set('ny_batt', '5');

model.geom('part4').feature('wp1').geom.feature.duplicate('ca4', 'ca2');
model.geom('part4').feature('wp1').geom.feature.duplicate('ca5', 'ca3');
model.geom('part4').feature('wp1').geom.run('ca5');
model.geom('part4').feature('wp1').geom.create('ls5', 'LineSegment');
model.geom('part4').feature('wp1').geom.feature('ls5').selection('vertex1').set('ca1', 2);
model.geom('part4').feature('wp1').geom.feature('ls5').selection('vertex2').set('ca4', 1);
model.geom('part4').feature('wp1').geom.run('ls5');
model.geom('part4').feature('wp1').geom.create('ls6', 'LineSegment');
model.geom('part4').feature('wp1').geom.feature('ls6').selection('vertex1').set('ca4', 2);
model.geom('part4').feature('wp1').geom.feature('ls6').selection('vertex2').set('ca5', 1);
model.geom('part4').feature('wp1').geom.run('ls6');
model.geom('part4').feature('wp1').geom.create('uni2', 'Union');
model.geom('part4').feature('wp1').geom.feature('uni2').selection('input').set({'ca1' 'ca4' 'ca5' 'ls5' 'ls6'});
model.geom('part4').feature('wp1').geom.run('uni2');
model.geom('part4').feature('wp1').geom.create('mir3', 'Mirror');
model.geom('part4').feature('wp1').geom.feature('mir3').selection('input').set({'uni2'});
model.geom('part4').feature('wp1').geom.feature('mir3').set('pos', {'0' '(ny_batt-1)*y_disp/2'});
model.geom('part4').feature('wp1').geom.feature('mir3').set('axis', [0 1]);
model.geom('part4').feature('wp1').geom.run('mir3');
model.geom('part4').feature('wp1').geom.feature('mir3').set('keep', true);
model.geom('part4').feature('wp1').geom.run('mir3');
model.geom('part4').feature('wp1').geom.create('if2', 'If');
model.geom('part4').feature('wp1').geom.feature.createAfter('endif2', 'EndIf', 'if2');
model.geom('part4').feature('wp1').geom.feature('if2').label('If ny_batt>3');
model.geom('part4').feature('wp1').geom.feature('if2').set('condition', 'ny_batt>3');
model.geom('part4').feature('wp1').geom.run('if2');
model.geom('part4').feature('wp1').geom.create('ls7', 'LineSegment');
model.geom('part4').feature('wp1').geom.feature('ls7').selection('vertex1').set('mir3', 6);
model.geom('part4').feature('wp1').geom.feature('ls7').selection('vertex2').set('uni2', 6);
model.geom('part4').feature('wp1').geom.run('ls7');
model.geom('part4').feature('wp1').geom.run('endif2');
model.geom('part4').feature('wp1').geom.create('ls8', 'LineSegment');
model.geom('part4').feature('wp1').geom.feature('ls8').selection('vertex1').set('uni2', 1);
model.geom('part4').feature('wp1').geom.feature('ls8').selection('vertex2').set('mir3', 1);
model.geom('part4').feature('wp1').geom.run('ls8');
model.geom('part4').feature('wp1').geom.create('csol2', 'ConvertToSolid');
model.geom('part4').feature('wp1').geom.feature('csol2').selection('input').set({'ls7' 'ls8' 'mir3' 'uni2'});
model.geom('part4').feature('wp1').geom.run('csol2');
model.geom('part4').feature('wp1').geom.run('endif1');
model.geom('part4').run('wp1');
model.geom('part4').feature.create('ext1', 'Extrude');
model.geom('part4').feature('ext1').setIndex('distance', 'h_pc', 0);
model.geom('part4').feature('ext1').setIndex('distance', 'h_pc+h_sc', 1);
model.geom('part4').feature('ext1').set('displ', {'0' '0'; '0' '0'});
model.geom('part4').feature('ext1').set('scale', {'1' '1'; '1' '1'});
model.geom('part4').feature('ext1').set('twist', {'0' '0'});
model.geom('part4').feature('ext1').setIndex('distance', 'h_pc+h_sc+h_term', 2);
model.geom('part4').feature('ext1').set('displ', {'0' '0'; '0' '0'; '0' '0'});
model.geom('part4').feature('ext1').set('scale', {'1' '1'; '1' '1'; '1' '1'});
model.geom('part4').feature('ext1').set('twist', {'0' '0' '0'});
model.geom('part4').feature('ext1').setIndex('distance', 'h_pc+h_sc+h_term+h_holder', 3);
model.geom('part4').feature('ext1').set('displ', {'0' '0'; '0' '0'; '0' '0'; '0' '0'});
model.geom('part4').feature('ext1').set('scale', {'1' '1'; '1' '1'; '1' '1'; '1' '1'});
model.geom('part4').feature('ext1').set('twist', {'0' '0' '0' '0'});
model.geom('part4').feature('ext1').setIndex('distance', 'h_pc+h_sc+h_term+h_batt-h_holder', 4);
model.geom('part4').feature('ext1').set('displ', {'0' '0'; '0' '0'; '0' '0'; '0' '0'; '0' '0'});
model.geom('part4').feature('ext1').set('scale', {'1' '1'; '1' '1'; '1' '1'; '1' '1'; '1' '1'});
model.geom('part4').feature('ext1').set('twist', {'0' '0' '0' '0' '0'});
model.geom('part4').feature('ext1').setIndex('distance', 'h_pc+h_sc+h_term+h_batt', 5);
model.geom('part4').feature('ext1').set('displ', {'0' '0';  ...
'0' '0';  ...
'0' '0';  ...
'0' '0';  ...
'0' '0';  ...
'0' '0'});
model.geom('part4').feature('ext1').set('scale', {'1' '1';  ...
'1' '1';  ...
'1' '1';  ...
'1' '1';  ...
'1' '1';  ...
'1' '1'});
model.geom('part4').feature('ext1').set('twist', {'0' '0' '0' '0' '0' '0'});
model.geom('part4').feature('ext1').setIndex('distance', 'h_pc+h_sc+2*h_term+h_batt', 6);
model.geom('part4').feature('ext1').set('displ', {'0' '0';  ...
'0' '0';  ...
'0' '0';  ...
'0' '0';  ...
'0' '0';  ...
'0' '0';  ...
'0' '0'});
model.geom('part4').feature('ext1').set('scale', {'1' '1';  ...
'1' '1';  ...
'1' '1';  ...
'1' '1';  ...
'1' '1';  ...
'1' '1';  ...
'1' '1'});
model.geom('part4').feature('ext1').set('twist', {'0' '0' '0' '0' '0' '0' '0'});
model.geom('part4').feature('ext1').setIndex('distance', 'h_pc+2*h_sc+2*h_term+h_batt', 7);
model.geom('part4').feature('ext1').set('displ', {'0' '0';  ...
'0' '0';  ...
'0' '0';  ...
'0' '0';  ...
'0' '0';  ...
'0' '0';  ...
'0' '0';  ...
'0' '0'});
model.geom('part4').feature('ext1').set('scale', {'1' '1';  ...
'1' '1';  ...
'1' '1';  ...
'1' '1';  ...
'1' '1';  ...
'1' '1';  ...
'1' '1';  ...
'1' '1'});
model.geom('part4').feature('ext1').set('twist', {'0' '0' '0' '0' '0' '0' '0' '0'});
model.geom('part4').feature('ext1').setIndex('distance', '2*h_pc+2*h_sc+2*h_term+h_batt', 8);
model.geom('part4').feature('ext1').set('displ', {'0' '0';  ...
'0' '0';  ...
'0' '0';  ...
'0' '0';  ...
'0' '0';  ...
'0' '0';  ...
'0' '0';  ...
'0' '0';  ...
'0' '0'});
model.geom('part4').feature('ext1').set('scale', {'1' '1';  ...
'1' '1';  ...
'1' '1';  ...
'1' '1';  ...
'1' '1';  ...
'1' '1';  ...
'1' '1';  ...
'1' '1';  ...
'1' '1'});
model.geom('part4').feature('ext1').set('twist', {'0' '0' '0' '0' '0' '0' '0' '0' '0'});
model.geom('part4').run('ext1');
model.geom('part4').run('ext1');

model.param.set('ny_batt', '4');

model.geom('part4').run('ext1');
model.geom('part4').run('ext1');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 3);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.geom('geom1').create('pi1', 'PartInstance');
model.geom('geom1').feature('pi1').set('selkeepnoncontr', false);
model.geom('geom1').feature('pi1').set('part', 'part1');
model.geom('geom1').selection.create('csel1', 'CumulativeSelection');
model.geom('geom1').selection('csel1').label('Batteries');
model.geom('geom1').feature('pi1').setEntry('selcontributetodom', 'pi1_csel1.dom', 'csel1');
model.geom('geom1').feature('pi1').setEntry('selcontributetodom', 'pi1_csel2.dom', 'csel1');
model.geom('geom1').feature('pi1').setEntry('selkeepbnd', 'pi1_csel1.bnd', true);
model.geom('geom1').feature('pi1').setEntry('selshowbnd', 'pi1_csel1.bnd', false);
model.geom('geom1').feature('pi1').setEntry('selkeepbnd', 'pi1_csel2.bnd', true);
model.geom('geom1').feature('pi1').setEntry('selshowbnd', 'pi1_csel2.bnd', false);
model.geom('geom1').run('pi1');
model.geom('geom1').create('pi2', 'PartInstance');
model.geom('geom1').feature('pi2').set('selkeepnoncontr', false);
model.geom('geom1').feature('pi2').set('part', 'part2');
model.geom('geom1').feature('pi2').setEntry('selkeepdom', 'pi2_boxsel1', true);
model.geom('geom1').feature('pi2').setEntry('selkeepbnd', 'pi2_boxsel2', true);
model.geom('geom1').feature('pi2').setEntry('selshowbnd', 'pi2_boxsel2', false);
model.geom('geom1').feature('pi2').setEntry('selkeepbnd', 'pi2_boxsel3', true);
model.geom('geom1').feature('pi2').setEntry('selshowbnd', 'pi2_boxsel3', false);
model.geom('geom1').feature('pi2').setEntry('selkeepbnd', 'pi2_boxsel4', true);
model.geom('geom1').feature('pi2').setEntry('selkeepbnd', 'pi2_boxsel5', true);
model.geom('geom1').run('pi2');
model.geom('geom1').create('pi3', 'PartInstance');
model.geom('geom1').feature('pi3').set('selkeepnoncontr', false);
model.geom('geom1').feature('pi3').set('part', 'part3');
model.geom('geom1').feature('pi3').setEntry('selkeepdom', 'pi3_csel1.dom', true);
model.geom('geom1').run('pi3');
model.geom('geom1').create('pi4', 'PartInstance');
model.geom('geom1').feature('pi4').set('selkeepnoncontr', false);
model.geom('geom1').feature('pi4').set('part', 'part4');
model.geom('geom1').run('fin');
model.geom('geom1').create('unisel1', 'UnionSelection');
model.geom('geom1').feature('unisel1').label('Batteries and Conductors');
model.geom('geom1').feature('unisel1').set('input', {'csel1' 'pi2_boxsel1'});
model.geom('geom1').run('unisel1');
model.geom('geom1').create('comsel1', 'ComplementSelection');
model.geom('geom1').feature('comsel1').label('Air Compartment');
model.geom('geom1').feature('comsel1').set('input', {'pi3_csel1' 'unisel1'});
model.geom('geom1').run('comsel1');
model.geom('geom1').create('intsel1', 'IntersectionSelection');
model.geom('geom1').feature('intsel1').set('entitydim', 2);
model.geom('geom1').feature('intsel1').label('Negative Connectors, Down Oriented Batteries');
model.geom('geom1').feature('intsel1').set('input', {'pi1_csel1' 'pi2_boxsel2'});
model.geom('geom1').feature('intsel1').set('selshow', false);
model.geom('geom1').feature.duplicate('intsel2', 'intsel1');
model.geom('geom1').feature('intsel2').label('Positive Connectors, Down Oriented Batteries');
model.geom('geom1').run('intsel1');
model.geom('geom1').feature('intsel2').set('input', {'pi1_csel1' 'pi2_boxsel3'});
model.geom('geom1').run('intsel2');
model.geom('geom1').feature.duplicate('intsel3', 'intsel2');
model.geom('geom1').feature('intsel3').label('Negative Connectors, Up Oriented Batteries');
model.geom('geom1').feature('intsel3').set('input', {'pi1_csel2' 'pi2_boxsel3'});
model.geom('geom1').run('intsel3');
model.geom('geom1').feature.duplicate('intsel4', 'intsel3');
model.geom('geom1').feature('intsel4').label('Positive Connectors, Up Oriented Batteries');
model.geom('geom1').feature('intsel4').set('input', {'pi1_csel2' 'pi2_boxsel2'});
model.geom('geom1').run('intsel4');
model.geom('geom1').create('unisel2', 'UnionSelection');
model.geom('geom1').feature('unisel2').set('entitydim', 2);
model.geom('geom1').feature('unisel2').label('Negative Connectors');
model.geom('geom1').feature('unisel2').set('input', {'intsel1' 'intsel3'});
model.geom('geom1').run('unisel2');
model.geom('geom1').create('unisel3', 'UnionSelection');
model.geom('geom1').feature('unisel3').label('Positive Connectors');
model.geom('geom1').feature('unisel3').set('entitydim', 2);
model.geom('geom1').feature('unisel3').set('input', {'intsel2' 'intsel4'});
model.geom('geom1').run('unisel3');
model.geom('geom1').create('boxsel1', 'BoxSelection');
model.geom('geom1').feature('boxsel1').label('Mesh Sweep Domains');
model.geom('geom1').feature('boxsel1').set('zmin', '-h_sc/2');
model.geom('geom1').feature('boxsel1').set('zmax', 'h_batt+h_sc/2');
model.geom('geom1').feature('boxsel1').set('condition', 'inside');
model.geom('geom1').run('boxsel1');
model.geom('geom1').create('boxsel2', 'BoxSelection');
model.geom('geom1').feature('boxsel2').label('Mesh Copy Source Boundaries');
model.geom('geom1').feature('boxsel2').set('entitydim', 2);
model.geom('geom1').feature('boxsel2').set('zmin', '-h_sc/2');
model.geom('geom1').feature('boxsel2').set('zmax', 'h_sc/2');
model.geom('geom1').feature('boxsel2').set('condition', 'inside');
model.geom('geom1').run('boxsel2');
model.geom('geom1').feature.duplicate('boxsel3', 'boxsel2');
model.geom('geom1').feature('boxsel3').label('Mesh Copy Destination Boundaries');
model.geom('geom1').feature('boxsel3').set('zmin', '-h_sc/2+h_batt');
model.geom('geom1').feature('boxsel3').set('zmax', 'h_sc/2+h_batt');
model.geom('geom1').run('boxsel3');
model.geom('geom1').create('adjsel1', 'AdjacentSelection');
model.geom('geom1').feature('adjsel1').label('Non-Air External Boundaries');
model.geom('geom1').feature('adjsel1').set('input', {'pi2_boxsel1' 'pi3_csel1' 'unisel1'});

model.title([]);

model.description('');

model.label('thermal_runaway_propagation_geom_sequence.mph');

model.modelNode.label('Components');

out = model;
