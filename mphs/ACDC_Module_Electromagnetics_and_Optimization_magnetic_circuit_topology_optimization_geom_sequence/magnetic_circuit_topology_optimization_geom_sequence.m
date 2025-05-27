function out = model
%
% magnetic_circuit_topology_optimization_geom_sequence.m
%
% Model exported on May 26 2025, 21:24 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/ACDC_Module/Electromagnetics_and_Optimization');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 2);
model.geom('geom1').model('comp1');
model.geom('geom1').axisymmetric(true);

model.mesh.create('mesh1', 'geom1');

model.geom('geom1').lengthUnit('mm');

% To import content from file, use:
% model.param.loadFile('FILENAME');
model.param.set('w_magnet', '26[mm]', 'Width of the magnet');
model.param.set('h_magnet', '20[mm]', 'Height of the magnet');
model.param.set('r_magnet', '25[mm]', 'Inner radius of the magnet');
model.param.set('z_magnet', '-80[mm]', 'z coordinate of the bottom of the magnet');
model.param.set('w_air', '80[mm]', 'Width of the air domain');
model.param.set('h_air', '100[mm]', 'Height of the air domain');
model.param.set('w_design', '45[mm]', 'Width of the iron');
model.param.set('h_design', '45[mm]', 'Height of the iron');
model.param.set('r_design', '6[mm]', 'Inner radius of the iron');
model.param.set('z_design', '-90[mm]', 'z coordinate of the bottom of the iron');
model.param.set('w_gap_i', '0.6[mm]', 'Width of the inner air gap around the coil');
model.param.set('w_gap_o', '0.2[mm]', 'Width of the outer air gap around the coil');
model.param.set('w_coil', '0.4[mm]', 'Width of the coil');
model.param.set('h_coil', '10[mm]', 'Height of the coil');
model.param.set('r_coil', '18.6[mm]', 'Center radius of the coil');
model.param.set('z_coil', '-56[mm]', 'z coordinate of the center of the coil');
model.param.set('z_offset', '7[mm]', 'Maximum offset of the voice coil');
model.param.set('n_points', '10', 'Number of points to compute the BL Curve');

model.geom('geom1').create('r1', 'Rectangle');
model.geom('geom1').feature('r1').label('Air');
model.geom('geom1').feature('r1').set('size', {'w_air' 'h_air'});
model.geom('geom1').feature('r1').set('pos', {'0' 'z_design+h_design/2-h_air/2'});
model.geom('geom1').run('r1');
model.geom('geom1').create('r2', 'Rectangle');
model.geom('geom1').feature('r2').label('Design Space with Magnet and Coil Gap');
model.geom('geom1').feature('r2').set('size', {'w_design' 'h_design'});
model.geom('geom1').feature('r2').set('pos', {'r_design' 'z_design'});
model.geom('geom1').run('r2');
model.geom('geom1').create('r3', 'Rectangle');
model.geom('geom1').feature('r3').label('Voice Coil Gap');
model.geom('geom1').feature('r3').set('size', {'w_coil+w_gap_i+w_gap_o' '1'});
model.geom('geom1').feature('r3').setIndex('size', 'h_coil+2*z_offset', 1);
model.geom('geom1').feature('r3').set('pos', {'r_coil-w_gap_i-w_coil/2' '0'});
model.geom('geom1').feature('r3').setIndex('pos', 'z_coil-h_coil/2-z_offset', 1);
model.geom('geom1').run('r3');
model.geom('geom1').create('dif1', 'Difference');
model.geom('geom1').feature('dif1').label('Design Space with Magnet');
model.geom('geom1').feature('dif1').selection('input').set({'r2'});
model.geom('geom1').feature('dif1').selection('input2').set({'r3'});
model.geom('geom1').feature('dif1').set('selresult', true);
model.geom('geom1').run('dif1');
model.geom('geom1').create('r4', 'Rectangle');
model.geom('geom1').feature('r4').label('Magnet');
model.geom('geom1').feature('r4').set('size', {'w_magnet' 'h_magnet'});
model.geom('geom1').feature('r4').set('pos', {'r_magnet' 'z_magnet'});
model.geom('geom1').feature('r4').set('selresult', true);
model.geom('geom1').run('r4');
model.geom('geom1').create('r5', 'Rectangle');
model.geom('geom1').feature('r5').label('Voice Coil Possible Locations');
model.geom('geom1').feature('r5').set('size', {'w_coil' 'h_coil+2*z_offset'});
model.geom('geom1').feature('r5').set('base', 'center');
model.geom('geom1').feature('r5').set('pos', {'r_coil' 'z_coil'});
model.geom('geom1').feature('r5').setIndex('layer', 'h_coil/2', 0);
model.geom('geom1').feature('r5').set('layertop', true);
model.geom('geom1').feature('r5').set('selresult', true);
model.geom('geom1').run('r5');
model.geom('geom1').create('ls1', 'LineSegment');
model.geom('geom1').feature('ls1').label('Voice Coil Center Possible Locations');
model.geom('geom1').feature('ls1').set('specify1', 'coord');
model.geom('geom1').feature('ls1').set('coord1', {'r_coil' 'z_coil-z_offset'});
model.geom('geom1').feature('ls1').set('specify2', 'coord');
model.geom('geom1').feature('ls1').set('coord2', {'r_coil' 'z_coil+z_offset'});
model.geom('geom1').feature('ls1').set('selresult', true);
model.geom('geom1').run('ls1');
model.geom('geom1').create('pt1', 'Point');
model.geom('geom1').feature('pt1').label('Lowest Voice Coil Center Point');
model.geom('geom1').feature('pt1').setIndex('p', 'r_coil', 0);
model.geom('geom1').feature('pt1').setIndex('p', 'z_coil-z_offset', 1);
model.geom('geom1').run('pt1');
model.geom('geom1').create('arr1', 'Array');
model.geom('geom1').feature('arr1').label('Voice Coil Center Measuring Points');
model.geom('geom1').feature('arr1').selection('input').set({'pt1'});
model.geom('geom1').feature('arr1').set('fullsize', {'1' 'n_points'});
model.geom('geom1').feature('arr1').set('displ', {'0' '2*z_offset/(n_points-1)'});
model.geom('geom1').feature('arr1').set('selresult', true);
model.geom('geom1').feature('arr1').set('selresultshow', 'pnt');
model.geom('geom1').run('arr1');
model.geom('geom1').create('pt2', 'Point');
model.geom('geom1').feature('pt2').label('Voice Coil Center at Resting Position');
model.geom('geom1').feature('pt2').setIndex('p', 'r_coil', 0);
model.geom('geom1').feature('pt2').setIndex('p', 'z_coil', 1);
model.geom('geom1').feature('pt2').set('selresult', true);
model.geom('geom1').run('pt2');
model.geom('geom1').run('fin');
model.geom('geom1').create('unisel1', 'UnionSelection');
model.geom('geom1').feature('unisel1').label('Mapped Domains');
model.geom('geom1').feature('unisel1').set('input', {'r4' 'r5'});
model.geom('geom1').run('unisel1');
model.geom('geom1').create('difsel1', 'DifferenceSelection');
model.geom('geom1').feature('difsel1').label('Design Space');
model.geom('geom1').feature('difsel1').set('add', {'dif1'});
model.geom('geom1').feature('difsel1').set('subtract', {'r4'});

model.title([]);

model.description('');

model.label('magnetic_circuit_topology_optimization_geom_sequence.mph');

model.modelNode.label('Components');

out = model;
