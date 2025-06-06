function out = model
%
% stack_cooling_geom_sequence.m
%
% Model exported on May 26 2025, 21:28 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/Fuel_Cell_and_Electrolyzer_Module/Thermal_Management');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 3);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

% To import content from file, use:
% model.param.loadFile('FILENAME');
model.param.set('L_plate', '24[cm]', 'Active area length');
model.param.set('W_plate', '10[cm]', 'Active area width');
model.param.set('W_manifold', '0.9*W_plate', 'Manifold width');
model.param.set('L_manifold', '0.1*W_plate', 'Manifold length');
model.param.set('D_cc', '10[mm]', 'Current collector thickness');
model.param.set('D_bpp', '1[mm]', 'Bipolar plate thickness');
model.param.set('D_gdl', '200[um]', 'Gas diffusion layer thickness');
model.param.set('D_mem', '30[um]', 'Membrane thickness');
model.param.set('D_cell', 'D_bpp+2*D_gdl+D_mem', 'Unit cell thickness');
model.param.set('N_cells', '5', 'Number of cells');

model.geom('geom1').create('wp1', 'WorkPlane');
model.geom('geom1').feature('wp1').set('unite', true);
model.geom('geom1').feature('wp1').geom.create('r1', 'Rectangle');
model.geom('geom1').feature('wp1').geom.feature('r1').set('size', {'W_plate+L_manifold*2' '1'});
model.geom('geom1').feature('wp1').geom.feature('r1').setIndex('size', 'L_plate+L_manifold*2', 1);
model.geom('geom1').feature('wp1').geom.feature('r1').set('pos', {'-L_manifold' '0'});
model.geom('geom1').feature('wp1').geom.feature('r1').setIndex('pos', '-L_manifold', 1);
model.geom('geom1').feature('wp1').geom.run('r1');
model.geom('geom1').feature('wp1').geom.create('pt1', 'Point');
model.geom('geom1').feature('wp1').geom.feature('pt1').setIndex('p', '-L_manifold', 0);
model.geom('geom1').feature('wp1').geom.feature('pt1').setIndex('p', 'W_plate/2+W_manifold/2', 1);
model.geom('geom1').feature('wp1').geom.run('pt1');
model.geom('geom1').feature('wp1').geom.create('pt2', 'Point');
model.geom('geom1').feature('wp1').geom.feature('pt2').setIndex('p', '-L_manifold', 0);
model.geom('geom1').feature('wp1').geom.feature('pt2').setIndex('p', 'L_plate-(W_plate/2+W_manifold/2)', 1);
model.geom('geom1').feature('wp1').geom.run('pt2');
model.geom('geom1').run('wp1');
model.geom('geom1').feature.create('ext1', 'Extrude');
model.geom('geom1').feature('ext1').label('Current Feeder Plate');
model.geom('geom1').feature('ext1').set('inputhandling', 'remove');
model.geom('geom1').feature('ext1').setIndex('distance', 'D_cc', 0);
model.geom('geom1').feature('ext1').set('selresult', true);
model.geom('geom1').run('ext1');
model.geom('geom1').create('wp2', 'WorkPlane');
model.geom('geom1').feature('wp2').set('unite', true);
model.geom('geom1').feature('wp2').set('quickz', 'D_cc');
model.geom('geom1').feature('wp2').geom.create('r1', 'Rectangle');
model.geom('geom1').feature('wp2').geom.feature('r1').set('size', {'W_plate' 'L_plate'});
model.geom('geom1').feature('wp2').geom.run('r1');
model.geom('geom1').feature('wp2').geom.create('pol1', 'Polygon');
model.geom('geom1').feature('wp2').geom.feature('pol1').set('source', 'table');
model.geom('geom1').feature('wp2').geom.feature('pol1').setIndex('table', 0, 0, 0);
model.geom('geom1').feature('wp2').geom.feature('pol1').setIndex('table', 0, 0, 1);
model.geom('geom1').feature('wp2').geom.feature('pol1').setIndex('table', 'W_plate', 1, 0);
model.geom('geom1').feature('wp2').geom.feature('pol1').setIndex('table', 0, 1, 1);
model.geom('geom1').feature('wp2').geom.feature('pol1').setIndex('table', 'W_plate/2+W_manifold/2', 2, 0);
model.geom('geom1').feature('wp2').geom.feature('pol1').setIndex('table', '-L_manifold', 2, 1);
model.geom('geom1').feature('wp2').geom.feature('pol1').setIndex('table', 'W_plate/2-W_manifold/2', 3, 0);
model.geom('geom1').feature('wp2').geom.feature('pol1').setIndex('table', '-L_manifold', 3, 1);
model.geom('geom1').feature('wp2').geom.run('pol1');
model.geom('geom1').feature('wp2').geom.create('rot1', 'Rotate');
model.geom('geom1').feature('wp2').geom.feature('rot1').selection('input').set({'pol1'});
model.geom('geom1').feature('wp2').geom.feature('rot1').set('keep', true);
model.geom('geom1').feature('wp2').geom.feature('rot1').set('rot', 180);
model.geom('geom1').feature('wp2').geom.feature('rot1').set('pos', {'W_plate/2' 'L_plate/2'});
model.geom('geom1').feature('wp2').geom.run('rot1');
model.geom('geom1').run('wp2');
model.geom('geom1').feature.create('ext2', 'Extrude');
model.geom('geom1').feature('ext2').label('End Cooling Plate, Negative Side');
model.geom('geom1').feature('ext2').set('inputhandling', 'remove');
model.geom('geom1').feature('ext2').setIndex('distance', 'D_bpp/2', 0);
model.geom('geom1').feature('ext2').set('selresult', true);
model.geom('geom1').run('ext2');
model.geom('geom1').create('unisel1', 'UnionSelection');
model.geom('geom1').feature('unisel1').label('Negative End Domains');
model.geom('geom1').feature('unisel1').set('entitydim', -1);
model.geom('geom1').feature('unisel1').set('input', {'ext1' 'ext2'});
model.geom('geom1').run('unisel1');
model.geom('geom1').create('wp3', 'WorkPlane');
model.geom('geom1').feature('wp3').set('unite', true);
model.geom('geom1').feature('wp3').set('quickz', 'D_cc+D_bpp/2');
model.geom('geom1').feature('wp3').geom.create('r1', 'Rectangle');
model.geom('geom1').feature('wp3').geom.feature('r1').set('size', {'W_plate' 'L_plate'});
model.geom('geom1').feature('wp3').geom.run('r1');
model.geom('geom1').feature('wp3').geom.create('pol1', 'Polygon');
model.geom('geom1').feature('wp3').geom.feature('pol1').set('source', 'table');
model.geom('geom1').feature('wp3').geom.feature('pol1').setIndex('table', 0, 0, 0);
model.geom('geom1').feature('wp3').geom.feature('pol1').setIndex('table', 0, 0, 1);
model.geom('geom1').feature('wp3').geom.feature('pol1').setIndex('table', '-L_manifold', 1, 0);
model.geom('geom1').feature('wp3').geom.feature('pol1').setIndex('table', 'W_plate/2-W_manifold/2', 1, 1);
model.geom('geom1').feature('wp3').geom.feature('pol1').setIndex('table', '-L_manifold', 2, 0);
model.geom('geom1').feature('wp3').geom.feature('pol1').setIndex('table', 'W_plate/2+W_manifold/2', 2, 1);
model.geom('geom1').feature('wp3').geom.feature('pol1').setIndex('table', 0, 3, 0);
model.geom('geom1').feature('wp3').geom.feature('pol1').setIndex('table', 'W_plate', 3, 1);
model.geom('geom1').feature('wp3').geom.run('pol1');
model.geom('geom1').feature('wp3').geom.create('pol2', 'Polygon');
model.geom('geom1').feature('wp3').geom.feature('pol2').set('source', 'table');
model.geom('geom1').feature('wp3').geom.feature('pol2').setIndex('table', 0, 0, 0);
model.geom('geom1').feature('wp3').geom.feature('pol2').setIndex('table', 0, 0, 1);
model.geom('geom1').feature('wp3').geom.feature('pol2').setIndex('table', 'W_plate', 1, 0);
model.geom('geom1').feature('wp3').geom.feature('pol2').setIndex('table', 0, 1, 1);
model.geom('geom1').feature('wp3').geom.feature('pol2').setIndex('table', 'W_plate/2+W_manifold/2', 2, 0);
model.geom('geom1').feature('wp3').geom.feature('pol2').setIndex('table', '-L_manifold', 2, 1);
model.geom('geom1').feature('wp3').geom.feature('pol2').setIndex('table', 'W_plate/2-W_manifold/2', 3, 0);
model.geom('geom1').feature('wp3').geom.feature('pol2').setIndex('table', '-L_manifold', 3, 1);
model.geom('geom1').feature('wp3').geom.run('pol2');
model.geom('geom1').feature('wp3').geom.create('rot1', 'Rotate');
model.geom('geom1').feature('wp3').geom.feature('rot1').selection('input').set({'pol1' 'pol2'});
model.geom('geom1').feature('wp3').geom.feature('rot1').set('keep', true);
model.geom('geom1').feature('wp3').geom.feature('rot1').set('rot', 180);
model.geom('geom1').feature('wp3').geom.feature('rot1').set('pos', {'W_plate/2' 'L_plate/2'});
model.geom('geom1').feature('wp3').geom.run('rot1');
model.geom('geom1').feature('wp3').geom.create('ls1', 'LineSegment');
model.geom('geom1').feature('wp3').geom.feature('ls1').selection('vertex1').set('pol1', 4);
model.geom('geom1').feature('wp3').geom.feature('ls1').selection('vertex2').set('pol2', 4);
model.geom('geom1').feature('wp3').geom.run('ls1');
model.geom('geom1').feature('wp3').geom.create('ls2', 'LineSegment');
model.geom('geom1').feature('wp3').geom.feature('ls2').selection('vertex1').set('rot1(2)', 4);
model.geom('geom1').feature('wp3').geom.feature('ls2').selection('vertex2').set('rot1(1)', 4);
model.geom('geom1').feature('wp3').geom.run('ls2');
model.geom('geom1').run('wp3');
model.geom('geom1').feature.create('ext3', 'Extrude');
model.geom('geom1').feature('ext3').label('Hydrogen Gas Manifolds');
model.geom('geom1').feature('ext3').set('extrudefrom', 'faces');
model.geom('geom1').feature('ext3').selection('inputface').set('wp3', [1 7]);
model.geom('geom1').feature('ext3').set('inputhandling', 'keep');
model.geom('geom1').feature('ext3').setIndex('distance', 'D_bpp/2', 0);
model.geom('geom1').feature('ext3').set('selresult', true);
model.geom('geom1').run('ext3');
model.geom('geom1').feature.duplicate('ext4', 'ext3');
model.geom('geom1').feature('ext4').label('Cooling Manifolds, Hydrogen Side');
model.geom('geom1').feature('ext4').selection('inputface').clear('wp3');
model.geom('geom1').feature('ext4').selection('inputface').set('wp3', [5 3]);
model.geom('geom1').run('ext4');
model.geom('geom1').feature.duplicate('ext5', 'ext4');
model.geom('geom1').feature('ext5').label('Hydrogen Gas Channels, x-directed');
model.geom('geom1').feature('ext5').selection('inputface').clear('wp3');
model.geom('geom1').feature('ext5').selection('inputface').set('wp3', [2 6]);
model.geom('geom1').run('ext5');
model.geom('geom1').feature.duplicate('ext6', 'ext5');
model.geom('geom1').feature('ext6').label('Hydrogen Gas Channels, y-directed');
model.geom('geom1').feature('ext6').selection('inputface').clear('wp3');
model.geom('geom1').feature('ext6').selection('inputface').set('wp3', 4);
model.geom('geom1').run('ext6');
model.geom('geom1').create('del1', 'Delete');
model.geom('geom1').feature('del1').selection('input').init;
model.geom('geom1').feature('del1').selection('input').set({'wp3'});
model.geom('geom1').run('del1');
model.geom('geom1').feature.create('ext7', 'Extrude');
model.geom('geom1').feature('ext7').label('Hydrogen GDLs');
model.geom('geom1').feature('ext7').set('extrudefrom', 'faces');
model.geom('geom1').feature('ext7').selection('inputface').set('ext5', [4 9]);
model.geom('geom1').feature('ext7').selection('inputface').set('ext6', 4);
model.geom('geom1').feature('ext7').setIndex('distance', 'D_gdl', 0);
model.geom('geom1').feature('ext7').set('selresult', true);
model.geom('geom1').feature('ext7').set('inputhandling', 'keep');
model.geom('geom1').run('ext7');
model.geom('geom1').feature.create('ext8', 'Extrude');
model.geom('geom1').feature('ext8').label('Membrane, Hydrogen Side');
model.geom('geom1').feature('ext8').set('extrudefrom', 'faces');
model.geom('geom1').feature('ext8').selection('inputface').set('ext7(1)', [4 9]);
model.geom('geom1').feature('ext8').selection('inputface').set('ext7(2)', 4);
model.geom('geom1').feature('ext8').set('inputhandling', 'keep');
model.geom('geom1').feature('ext8').setIndex('distance', 'D_mem/2', 0);
model.geom('geom1').feature('ext8').set('selresult', true);
model.geom('geom1').run('ext8');
model.geom('geom1').create('unisel2', 'UnionSelection');
model.geom('geom1').feature('unisel2').label('Repetitive Unit, Hydrogen Side');
model.geom('geom1').feature('unisel2').set('entitydim', -1);
model.geom('geom1').feature('unisel2').set('input', {'ext3' 'ext4' 'ext5' 'ext6' 'ext7' 'ext8'});
model.geom('geom1').run('unisel2');
model.geom('geom1').create('wp4', 'WorkPlane');
model.geom('geom1').feature('wp4').set('unite', true);
model.geom('geom1').feature('wp4').set('quickz', 'D_cc+D_bpp/2+D_cell');
model.geom('geom1').feature('wp4').geom.create('r1', 'Rectangle');
model.geom('geom1').feature('wp4').geom.feature('r1').set('size', {'W_plate' 'L_plate'});
model.geom('geom1').feature('wp4').geom.run('r1');
model.geom('geom1').feature('wp4').geom.create('pol1', 'Polygon');
model.geom('geom1').feature('wp4').geom.feature('pol1').set('source', 'table');
model.geom('geom1').feature('wp4').geom.feature('pol1').setIndex('table', 'W_plate', 0, 0);
model.geom('geom1').feature('wp4').geom.feature('pol1').setIndex('table', 0, 0, 1);
model.geom('geom1').feature('wp4').geom.feature('pol1').setIndex('table', 'W_plate', 1, 0);
model.geom('geom1').feature('wp4').geom.feature('pol1').setIndex('table', 'W_plate', 1, 1);
model.geom('geom1').feature('wp4').geom.feature('pol1').setIndex('table', 'W_plate+L_manifold', 2, 0);
model.geom('geom1').feature('wp4').geom.feature('pol1').setIndex('table', 'W_plate/2+W_manifold/2', 2, 1);
model.geom('geom1').feature('wp4').geom.feature('pol1').setIndex('table', 'W_plate+L_manifold', 3, 0);
model.geom('geom1').feature('wp4').geom.feature('pol1').setIndex('table', 'W_plate/2-W_manifold/2', 3, 1);
model.geom('geom1').feature('wp4').geom.run('pol1');
model.geom('geom1').feature('wp4').geom.create('pol2', 'Polygon');
model.geom('geom1').feature('wp4').geom.feature('pol2').set('source', 'table');
model.geom('geom1').feature('wp4').geom.feature('pol2').setIndex('table', 0, 0, 0);
model.geom('geom1').feature('wp4').geom.feature('pol2').setIndex('table', 0, 0, 1);
model.geom('geom1').feature('wp4').geom.feature('pol2').setIndex('table', 'W_plate', 1, 0);
model.geom('geom1').feature('wp4').geom.feature('pol2').setIndex('table', 0, 1, 1);
model.geom('geom1').feature('wp4').geom.feature('pol2').setIndex('table', 'W_plate/2+W_manifold/2', 2, 0);
model.geom('geom1').feature('wp4').geom.feature('pol2').setIndex('table', '-L_manifold', 2, 1);
model.geom('geom1').feature('wp4').geom.feature('pol2').setIndex('table', 'W_plate/2-W_manifold/2', 3, 0);
model.geom('geom1').feature('wp4').geom.feature('pol2').setIndex('table', '-L_manifold', 3, 1);
model.geom('geom1').feature('wp4').geom.run('pol2');
model.geom('geom1').feature('wp4').geom.create('rot1', 'Rotate');
model.geom('geom1').feature('wp4').geom.feature('rot1').selection('input').set({'pol1' 'pol2'});
model.geom('geom1').feature('wp4').geom.feature('rot1').set('keep', true);
model.geom('geom1').feature('wp4').geom.feature('rot1').set('rot', 180);
model.geom('geom1').feature('wp4').geom.feature('rot1').set('pos', {'W_plate/2' 'L_plate/2'});
model.geom('geom1').feature('wp4').geom.run('rot1');
model.geom('geom1').feature('wp4').geom.create('ls1', 'LineSegment');
model.geom('geom1').feature('wp4').geom.feature('ls1').selection('vertex1').set('pol2', 1);
model.geom('geom1').feature('wp4').geom.feature('ls1').selection('vertex2').set('pol1', 2);
model.geom('geom1').feature('wp4').geom.run('ls1');
model.geom('geom1').feature('wp4').geom.create('ls2', 'LineSegment');
model.geom('geom1').feature('wp4').geom.feature('ls2').selection('vertex1').set('rot1(1)', 2);
model.geom('geom1').feature('wp4').geom.feature('ls2').selection('vertex2').set('rot1(2)', 1);
model.geom('geom1').run('wp4');
model.geom('geom1').feature.create('ext9', 'Extrude');
model.geom('geom1').feature('ext9').label('Oxygen Gas Manifolds');
model.geom('geom1').feature('ext9').set('extrudefrom', 'faces');
model.geom('geom1').feature('ext9').selection('inputface').set('wp4', [1 7]);
model.geom('geom1').feature('ext9').set('inputhandling', 'keep');
model.geom('geom1').feature('ext9').setIndex('distance', 'D_bpp/2', 0);
model.geom('geom1').feature('ext9').set('reverse', true);
model.geom('geom1').feature('ext9').set('selresult', true);
model.geom('geom1').run('ext9');
model.geom('geom1').feature.duplicate('ext10', 'ext9');
model.geom('geom1').feature('ext10').label('Cooling Manifolds, Oxygen Side');
model.geom('geom1').feature('ext10').selection('inputface').clear('wp4');
model.geom('geom1').feature('ext10').selection('inputface').set('wp4', [6 3]);
model.geom('geom1').run('ext10');
model.geom('geom1').feature.duplicate('ext11', 'ext10');
model.geom('geom1').feature('ext11').label('Oxygen Gas Channels, x-directed');
model.geom('geom1').feature('ext11').selection('inputface').clear('wp4');
model.geom('geom1').feature('ext11').selection('inputface').set('wp4', [4 5]);
model.geom('geom1').run('ext11');
model.geom('geom1').feature.duplicate('ext12', 'ext11');
model.geom('geom1').feature('ext12').label('Oxygen Gas Channels, y-directed');
model.geom('geom1').feature('ext12').selection('inputface').clear('wp4');
model.geom('geom1').feature('ext12').selection('inputface').set('wp4', 2);
model.geom('geom1').run('ext12');
model.geom('geom1').create('del2', 'Delete');
model.geom('geom1').feature('del2').selection('input').init;
model.geom('geom1').feature('del2').selection('input').set({'wp4'});
model.geom('geom1').run('del2');
model.geom('geom1').feature.create('ext13', 'Extrude');
model.geom('geom1').feature('ext13').label('Oxygen GDLs');
model.geom('geom1').feature('ext13').set('extrudefrom', 'faces');
model.geom('geom1').feature('ext13').selection('inputface').set('ext11', [3 7]);
model.geom('geom1').feature('ext13').set('inputhandling', 'keep');
model.geom('geom1').feature('ext13').setIndex('distance', 'D_gdl', 0);
model.geom('geom1').feature('ext13').set('selresult', true);
model.geom('geom1').feature('ext13').selection('inputface').set('ext11', [3 7]);
model.geom('geom1').feature('ext13').selection('inputface').set('ext12', 3);
model.geom('geom1').run('ext13');
model.geom('geom1').feature.create('ext14', 'Extrude');
model.geom('geom1').feature('ext14').label('Membrane, Oxygen Side');
model.geom('geom1').feature('ext14').set('extrudefrom', 'faces');
model.geom('geom1').feature('ext14').selection('inputface').set('ext13(1)', [3 7]);
model.geom('geom1').feature('ext14').selection('inputface').set('ext13(2)', 3);
model.geom('geom1').feature('ext14').set('inputhandling', 'keep');
model.geom('geom1').feature('ext14').setIndex('distance', 'D_mem/2', 0);
model.geom('geom1').feature('ext14').set('selresult', true);
model.geom('geom1').run('ext14');
model.geom('geom1').create('unisel3', 'UnionSelection');
model.geom('geom1').feature('unisel3').label('Repetitive Unit, Oxygen Side');
model.geom('geom1').feature('unisel3').set('entitydim', -1);
model.geom('geom1').feature('unisel3').set('input', {'ext9' 'ext10' 'ext11' 'ext12' 'ext13' 'ext14'});
model.geom('geom1').run('unisel3');
model.geom('geom1').create('arr1', 'Array');
model.geom('geom1').feature('arr1').selection('input').named('unisel2');
model.geom('geom1').feature('arr1').set('fullsize', {'1' '1' 'N_cells'});
model.geom('geom1').feature('arr1').set('displ', {'0' '0' 'D_cell'});
model.geom('geom1').run('arr1');
model.geom('geom1').feature.duplicate('arr2', 'arr1');
model.geom('geom1').feature('arr2').selection('input').named('unisel3');
model.geom('geom1').run('arr2');
model.geom('geom1').create('wp5', 'WorkPlane');
model.geom('geom1').feature('wp5').set('unite', true);
model.geom('geom1').feature('wp5').set('quickz', 'N_cells*D_cell+D_cc*2+D_bpp');
model.geom('geom1').feature('wp5').geom.create('r1', 'Rectangle');
model.geom('geom1').feature('wp5').geom.feature('r1').set('size', {'W_plate+L_manifold*2' '1'});
model.geom('geom1').feature('wp5').geom.feature('r1').setIndex('size', 'L_plate+L_manifold*2', 1);
model.geom('geom1').feature('wp5').geom.feature('r1').set('pos', {'-L_manifold' '0'});
model.geom('geom1').feature('wp5').geom.feature('r1').setIndex('pos', '-L_manifold', 1);
model.geom('geom1').feature('wp5').geom.run('r1');
model.geom('geom1').feature('wp5').geom.create('pt1', 'Point');
model.geom('geom1').feature('wp5').geom.feature('pt1').setIndex('p', '-L_manifold', 0);
model.geom('geom1').feature('wp5').geom.feature('pt1').setIndex('p', 'W_plate/2+W_manifold/2', 1);
model.geom('geom1').feature('wp5').geom.run('pt1');
model.geom('geom1').feature('wp5').geom.create('pt2', 'Point');
model.geom('geom1').feature('wp5').geom.feature('pt2').setIndex('p', '-L_manifold', 0);
model.geom('geom1').feature('wp5').geom.feature('pt2').setIndex('p', 'L_plate-(W_plate/2+W_manifold/2)', 1);
model.geom('geom1').feature('wp5').geom.run('pt2');
model.geom('geom1').run('wp5');
model.geom('geom1').feature.create('ext15', 'Extrude');
model.geom('geom1').feature('ext15').label('Current Collector');
model.geom('geom1').feature('ext15').set('inputhandling', 'remove');
model.geom('geom1').feature('ext15').setIndex('distance', 'D_cc', 0);
model.geom('geom1').feature('ext15').set('reverse', true);
model.geom('geom1').feature('ext15').set('selresult', true);
model.geom('geom1').run('ext15');
model.geom('geom1').create('wp6', 'WorkPlane');
model.geom('geom1').feature('wp6').set('unite', true);
model.geom('geom1').feature('wp6').set('quickz', 'N_cells*D_cell+D_cc+D_bpp');
model.geom('geom1').feature('wp6').geom.create('r1', 'Rectangle');
model.geom('geom1').feature('wp6').geom.feature('r1').set('size', {'W_plate' 'L_plate'});
model.geom('geom1').feature('wp6').geom.run('r1');
model.geom('geom1').feature('wp6').geom.create('pol1', 'Polygon');
model.geom('geom1').feature('wp6').geom.feature('pol1').set('source', 'table');
model.geom('geom1').feature('wp6').geom.feature('pol1').setIndex('table', 0, 0, 0);
model.geom('geom1').feature('wp6').geom.feature('pol1').setIndex('table', 0, 0, 1);
model.geom('geom1').feature('wp6').geom.feature('pol1').setIndex('table', 'W_plate', 1, 0);
model.geom('geom1').feature('wp6').geom.feature('pol1').setIndex('table', 0, 1, 1);
model.geom('geom1').feature('wp6').geom.feature('pol1').setIndex('table', 'W_plate/2+W_manifold/2', 2, 0);
model.geom('geom1').feature('wp6').geom.feature('pol1').setIndex('table', '-L_manifold', 2, 1);
model.geom('geom1').feature('wp6').geom.feature('pol1').setIndex('table', 'W_plate/2-W_manifold/2', 3, 0);
model.geom('geom1').feature('wp6').geom.feature('pol1').setIndex('table', '-L_manifold', 3, 1);
model.geom('geom1').feature('wp6').geom.run('pol1');
model.geom('geom1').feature('wp6').geom.create('rot1', 'Rotate');
model.geom('geom1').feature('wp6').geom.feature('rot1').selection('input').set({'pol1'});
model.geom('geom1').feature('wp6').geom.feature('rot1').set('keep', true);
model.geom('geom1').feature('wp6').geom.feature('rot1').set('rot', 180);
model.geom('geom1').feature('wp6').geom.feature('rot1').set('pos', {'W_plate/2' 'L_plate/2'});
model.geom('geom1').run('wp6');
model.geom('geom1').feature.create('ext16', 'Extrude');
model.geom('geom1').feature('ext16').label('End Cooling Plate, Positive Side');
model.geom('geom1').feature('ext16').set('inputhandling', 'remove');
model.geom('geom1').feature('ext16').setIndex('distance', 'D_bpp/2', 0);
model.geom('geom1').feature('ext16').set('reverse', true);
model.geom('geom1').feature('ext16').set('selresult', true);
model.geom('geom1').run('ext16');
model.geom('geom1').create('unisel4', 'UnionSelection');
model.geom('geom1').feature('unisel4').label('Positive End Domains');
model.geom('geom1').feature('unisel4').set('entitydim', -1);
model.geom('geom1').feature('unisel4').set('input', {'ext15' 'ext16'});
model.geom('geom1').run('unisel4');
model.geom('geom1').create('unisel5', 'UnionSelection');
model.geom('geom1').feature('unisel5').label('Hydrogen Side Domains');
model.geom('geom1').feature('unisel5').set('entitydim', -1);
model.geom('geom1').feature('unisel5').set('input', {'unisel1' 'unisel2'});
model.geom('geom1').run('unisel5');
model.geom('geom1').create('unisel6', 'UnionSelection');
model.geom('geom1').feature('unisel6').label('Oxygen Side Domains');
model.geom('geom1').feature('unisel6').set('entitydim', -1);
model.geom('geom1').feature('unisel6').set('input', {'unisel3' 'unisel4'});
model.geom('geom1').run('unisel6');
model.geom('geom1').create('uni1', 'Union');
model.geom('geom1').feature('uni1').selection('input').named('unisel5');
model.geom('geom1').run('uni1');
model.geom('geom1').create('uni2', 'Union');
model.geom('geom1').feature('uni2').selection('input').named('unisel6');
model.geom('geom1').run('uni2');
model.geom('geom1').feature('fin').set('action', 'assembly');
model.geom('geom1').run('fin');
model.geom('geom1').create('unisel7', 'UnionSelection');
model.geom('geom1').feature('unisel7').label('Membranes');
model.geom('geom1').feature('unisel7').set('input', {'ext8' 'ext14'});
model.geom('geom1').run('unisel7');
model.geom('geom1').create('unisel8', 'UnionSelection');
model.geom('geom1').feature('unisel8').label('Hydrogen Gas Channels and Manifolds');
model.geom('geom1').feature('unisel8').set('input', {'ext3' 'ext5' 'ext6'});
model.geom('geom1').run('unisel8');
model.geom('geom1').create('unisel9', 'UnionSelection');
model.geom('geom1').feature('unisel9').label('Oxygen Gas Channels and Manifolds');
model.geom('geom1').feature('unisel9').set('input', {'ext9' 'ext11' 'ext12'});
model.geom('geom1').run('unisel9');
model.geom('geom1').create('unisel10', 'UnionSelection');
model.geom('geom1').feature('unisel10').label('Cooling Channels and Manifolds');
model.geom('geom1').feature('unisel10').set('input', {'ext2' 'ext4' 'ext5' 'ext6' 'ext10' 'ext11' 'ext12' 'ext16'});
model.geom('geom1').run('unisel10');
model.geom('geom1').create('unisel11', 'UnionSelection');
model.geom('geom1').feature('unisel11').label('Current Collector and Feeder Plates');
model.geom('geom1').feature('unisel11').set('input', {'ext1' 'ext15'});
model.geom('geom1').run('unisel11');
model.geom('geom1').create('unisel12', 'UnionSelection');
model.geom('geom1').feature('unisel12').label('End Cooling Plates');
model.geom('geom1').feature('unisel12').set('input', {'ext2' 'ext16'});
model.geom('geom1').run('unisel12');
model.geom('geom1').create('unisel13', 'UnionSelection');
model.geom('geom1').feature('unisel13').label('Interior Cooling Manifolds');
model.geom('geom1').feature('unisel13').set('input', {'ext4' 'ext10'});
model.geom('geom1').run('unisel13');
model.geom('geom1').create('unisel14', 'UnionSelection');
model.geom('geom1').feature('unisel14').label('Non-Gas Cooling Channels and Manifolds');
model.geom('geom1').feature('unisel14').set('input', {'unisel12' 'unisel13'});
model.geom('geom1').run('unisel14');
model.geom('geom1').create('unisel15', 'UnionSelection');
model.geom('geom1').feature('unisel15').label('GDLs');
model.geom('geom1').feature('unisel15').set('input', {'ext7' 'ext13'});
model.geom('geom1').run('unisel15');
model.geom('geom1').create('unisel16', 'UnionSelection');
model.geom('geom1').feature('unisel16').label('Gas Manifolds');
model.geom('geom1').feature('unisel16').set('input', {'ext3' 'ext9'});
model.geom('geom1').run('unisel16');
model.geom('geom1').create('intsel1', 'IntersectionSelection');
model.geom('geom1').feature('intsel1').label('Hydrogen Gas Diffusion Electrodes');
model.geom('geom1').feature('intsel1').set('entitydim', 2);
model.geom('geom1').feature('intsel1').set('input', {'ext7' 'ext8'});
model.geom('geom1').run('intsel1');
model.geom('geom1').create('intsel2', 'IntersectionSelection');
model.geom('geom1').feature('intsel2').label('Oxygen Gas Diffusion Electrodes');
model.geom('geom1').feature('intsel2').set('entitydim', 2);
model.geom('geom1').feature('intsel2').set('input', {'ext13' 'ext14'});
model.geom('geom1').run('intsel2');
model.geom('geom1').create('boxsel1', 'BoxSelection');
model.geom('geom1').feature('boxsel1').label('Cooling Inlets');
model.geom('geom1').feature('boxsel1').set('entitydim', 2);
model.geom('geom1').feature('boxsel1').set('xmin', 0);
model.geom('geom1').feature('boxsel1').set('xmax', 'W_plate');
model.geom('geom1').feature('boxsel1').set('ymax', '-L_manifold/2');
model.geom('geom1').run('boxsel1');
model.geom('geom1').feature('boxsel1').set('condition', 'inside');
model.geom('geom1').feature.duplicate('boxsel2', 'boxsel1');
model.geom('geom1').feature('boxsel2').label('Cooling Outlets');
model.geom('geom1').feature('boxsel2').set('ymin', 'L_plate+L_manifold/2');
model.geom('geom1').feature('boxsel2').set('ymax', Inf);
model.geom('geom1').run('boxsel2');
model.geom('geom1').create('boxsel3', 'BoxSelection');
model.geom('geom1').feature('boxsel3').label('Hydrogen Inlets');
model.geom('geom1').feature('boxsel3').set('entitydim', 2);
model.geom('geom1').feature('boxsel3').set('xmax', '-L_manifold/2');
model.geom('geom1').feature('boxsel3').set('ymax', 'L_plate/2');
model.geom('geom1').feature('boxsel3').set('zmin', 'D_cc');
model.geom('geom1').feature('boxsel3').set('zmax', 'N_cells*D_cell+D_cc+D_bpp*2');
model.geom('geom1').feature('boxsel3').set('condition', 'inside');
model.geom('geom1').run('boxsel3');
model.geom('geom1').run('boxsel3');
model.geom('geom1').feature.duplicate('boxsel4', 'boxsel3');
model.geom('geom1').feature('boxsel4').label('Hydrogen Outlets');
model.geom('geom1').feature('boxsel4').set('xmin', 'W_plate+L_manifold/2');
model.geom('geom1').feature('boxsel4').set('xmax', Inf);
model.geom('geom1').feature('boxsel4').set('ymin', 'L_plate/2');
model.geom('geom1').feature('boxsel4').set('ymax', Inf);
model.geom('geom1').run('boxsel4');
model.geom('geom1').feature.duplicate('boxsel5', 'boxsel4');
model.geom('geom1').feature('boxsel5').label('Oxygen Inlets');
model.geom('geom1').feature('boxsel5').set('ymin', -Inf);
model.geom('geom1').feature('boxsel5').set('ymax', 'L_plate/2');
model.geom('geom1').run('boxsel5');
model.geom('geom1').feature.duplicate('boxsel6', 'boxsel5');
model.geom('geom1').feature('boxsel6').label('Oxygen Outlets');
model.geom('geom1').feature('boxsel6').set('xmin', -Inf);
model.geom('geom1').feature('boxsel6').set('xmax', '-L_manifold/2');
model.geom('geom1').feature('boxsel6').set('ymax', Inf);
model.geom('geom1').feature('boxsel6').set('ymin', 'L_plate/2');
model.geom('geom1').run('boxsel6');
model.geom('geom1').create('boxsel7', 'BoxSelection');
model.geom('geom1').feature('boxsel7').label('Current Feeder Tab');
model.geom('geom1').feature('boxsel7').set('entitydim', 2);
model.geom('geom1').feature('boxsel7').set('xmax', '-L_manifold/2');
model.geom('geom1').feature('boxsel7').set('ymin', 'L_plate/2-W_manifold');
model.geom('geom1').feature('boxsel7').set('ymax', 'L_plate/2+W_manifold');
model.geom('geom1').feature('boxsel7').set('zmax', 'D_cc+D_cell');
model.geom('geom1').feature('boxsel7').set('condition', 'inside');
model.geom('geom1').run('boxsel7');
model.geom('geom1').feature.duplicate('boxsel8', 'boxsel7');
model.geom('geom1').feature('boxsel8').label('Current Collector Tab');
model.geom('geom1').feature('boxsel8').set('zmin', '(N_cells-1)*D_cell+D_cc');
model.geom('geom1').feature('boxsel8').set('zmax', Inf);
model.geom('geom1').run('boxsel8');
model.geom('geom1').create('adjsel1', 'AdjacentSelection');
model.geom('geom1').feature('adjsel1').label('Membrane Boundaries');
model.geom('geom1').feature('adjsel1').set('input', {'unisel7'});
model.geom('geom1').run('adjsel1');

model.param.set('N_cells', '1');
model.param.descr('N_cells', 'Number of cells');

model.geom('geom1').run('adjsel1');

model.view.create('view8', 'geom1');
model.view('view8').model('comp1');
model.view('view8').hideObjects.create('hide1');
model.view('view8').hideObjects('hide1').init(3);
model.view('view8').hideObjects('hide1').named('unisel11');
model.view('view8').hideObjects.create('hide2');
model.view('view8').hideObjects('hide2').init(3);
model.view('view8').hideObjects('hide2').named('unisel12');
model.view('view8').camera.set('viewscaletype', 'manual');
model.view('view8').camera.set('zscale', 10);
model.view('view8').set('showgrid', true);

model.param.set('N_cells', '5');
model.param.descr('N_cells', 'Number of cells');

model.view.remove('view8');

model.geom('geom1').run('adjsel1');

model.title([]);

model.description('');

model.label('stack_cooling_geom_sequence.mph');

model.modelNode.label('Components');

out = model;
