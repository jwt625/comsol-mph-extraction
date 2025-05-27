function out = model
%
% zero_gap_aec_geom_sequence.m
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
model.param.set('H_gde', '2[mm]', 'Gas diffusion electrode height');
model.param.set('H_sep', '0.5[mm]', 'Diaphragm thickness');
model.param.set('H_ch', '5[mm]', 'Channel height');
model.param.set('W_ch', '12[mm]', 'Channel maximum width');
model.param.set('W_rib', '8[mm]', 'Rib width (and channel minimum width)');
model.param.set('W_ribch', 'W_rib+W_ch', 'Channel-to-channel distance');
model.param.set('H_cell', '2*H_gde+H_ch+H_sep', 'Cell height');
model.param.set('H_bpp', '0.25[mm]', 'Bipolar plate thickness');
model.param.set('L_cell', '10[cm]', 'Cell length');
model.param.set('W_dev', '(W_ch/2-W_rib/2)/((H_ch-H_bpp)/H_bpp-1)', 'Geometry help parameter');
model.param.set('L_inl', 'W_ch/2', 'Inlet region length');
model.param.set('L_outl', 'W_ch/2', 'Outlet region length');

model.geom('geom1').create('wp1', 'WorkPlane');
model.geom('geom1').feature('wp1').set('unite', true);
model.geom('geom1').feature('wp1').set('quickplane', 'yz');
model.geom('geom1').feature('wp1').geom.create('pol1', 'Polygon');
model.geom('geom1').feature('wp1').geom.feature('pol1').set('source', 'table');
model.geom('geom1').feature('wp1').geom.feature('pol1').setIndex('table', 0, 0, 0);
model.geom('geom1').feature('wp1').geom.feature('pol1').setIndex('table', 0, 0, 1);
model.geom('geom1').feature('wp1').geom.feature('pol1').setIndex('table', 'W_rib/2', 1, 0);
model.geom('geom1').feature('wp1').geom.feature('pol1').setIndex('table', 0, 1, 1);
model.geom('geom1').feature('wp1').geom.feature('pol1').setIndex('table', 'W_ribch/2-W_rib/2+W_dev', 2, 0);
model.geom('geom1').feature('wp1').geom.feature('pol1').setIndex('table', 'H_ch-H_bpp', 2, 1);
model.geom('geom1').feature('wp1').geom.feature('pol1').setIndex('table', 'W_ribch/2', 3, 0);
model.geom('geom1').feature('wp1').geom.feature('pol1').setIndex('table', 'H_ch-H_bpp', 3, 1);
model.geom('geom1').feature('wp1').geom.feature('pol1').setIndex('table', 'W_ribch/2', 4, 0);
model.geom('geom1').feature('wp1').geom.feature('pol1').setIndex('table', 'H_ch', 4, 1);
model.geom('geom1').feature('wp1').geom.feature('pol1').setIndex('table', 'W_ribch/2-W_rib/2', 5, 0);
model.geom('geom1').feature('wp1').geom.feature('pol1').setIndex('table', 'H_ch', 5, 1);
model.geom('geom1').feature('wp1').geom.feature('pol1').setIndex('table', 'W_rib/2-W_dev', 6, 0);
model.geom('geom1').feature('wp1').geom.feature('pol1').setIndex('table', 'H_bpp', 6, 1);
model.geom('geom1').feature('wp1').geom.feature('pol1').setIndex('table', 0, 7, 0);
model.geom('geom1').feature('wp1').geom.feature('pol1').setIndex('table', 'H_bpp', 7, 1);
model.geom('geom1').feature('wp1').geom.run('pol1');
model.geom('geom1').feature('wp1').geom.create('mov1', 'Move');
model.geom('geom1').feature('wp1').geom.feature('mov1').selection('input').set({'pol1'});
model.geom('geom1').feature('wp1').geom.feature('mov1').set('disply', 'H_sep/2+H_gde');
model.geom('geom1').feature('wp1').geom.run('mov1');
model.geom('geom1').feature('wp1').geom.create('r1', 'Rectangle');
model.geom('geom1').feature('wp1').geom.feature('r1').set('size', {'W_ribch/2' 'H_cell+H_sep/2'});
model.geom('geom1').feature('wp1').geom.feature('r1').setIndex('layer', 'H_sep/2', 0);
model.geom('geom1').feature('wp1').geom.feature('r1').setIndex('layer', 'H_gde', 1);
model.geom('geom1').feature('wp1').geom.feature('r1').setIndex('layer', 'H_ch', 2);
model.geom('geom1').feature('wp1').geom.feature('r1').setIndex('layer', 'H_gde', 3);
model.geom('geom1').feature('wp1').geom.run('r1');
model.geom('geom1').feature('wp1').geom.create('mir1', 'Mirror');
model.geom('geom1').feature('wp1').geom.feature('mir1').selection('input').set({'mov1' 'r1'});
model.geom('geom1').feature('wp1').geom.feature('mir1').set('pos', {'0' 'H_cell'});
model.geom('geom1').feature('wp1').geom.feature('mir1').set('axis', [0 1]);
model.geom('geom1').feature('wp1').geom.feature('mir1').set('keep', true);
model.geom('geom1').feature('wp1').geom.run('mir1');
model.geom('geom1').feature('wp1').geom.create('ls1', 'LineSegment');
model.geom('geom1').feature('wp1').geom.feature('ls1').set('specify1', 'coord');
model.geom('geom1').feature('wp1').geom.feature('ls1').set('coord1', {'W_rib/2' '0'});
model.geom('geom1').feature('wp1').geom.feature('ls1').selection('vertex2').set('mov1', 4);
model.geom('geom1').feature('wp1').geom.run('ls1');
model.geom('geom1').feature('wp1').geom.create('ls2', 'LineSegment');
model.geom('geom1').feature('wp1').geom.feature('ls2').selection('vertex2').set('mov1', 5);
model.geom('geom1').feature('wp1').geom.feature('ls2').set('specify1', 'coord');
model.geom('geom1').feature('wp1').geom.feature('ls2').set('coord1', {'W_ribch/2-W_rib/2' '0'});
model.geom('geom1').feature('wp1').geom.feature('ls2').setIndex('coord1', 'H_sep/2+H_gde+H_ch+H_gde+H_sep', 1);
model.geom('geom1').feature('wp1').geom.run('ls2');
model.geom('geom1').feature('wp1').geom.feature.duplicate('mir2', 'mir1');
model.geom('geom1').feature('wp1').geom.feature('mir2').selection('input').init;
model.geom('geom1').feature('wp1').geom.feature('mir2').selection('input').set({'ls1' 'ls2'});
model.geom('geom1').feature('wp1').geom.run('mir2');
model.geom('geom1').run('wp1');
model.geom('geom1').feature.create('ext1', 'Extrude');
model.geom('geom1').feature('ext1').setIndex('distance', 'L_cell', 0);
model.geom('geom1').run('ext1');
model.geom('geom1').feature.create('ext2', 'Extrude');
model.geom('geom1').feature('ext2').set('extrudefrom', 'faces');
model.geom('geom1').feature('ext2').selection('inputface').set('ext1', [48 10 43 22]);
model.geom('geom1').feature('ext2').setIndex('distance', 'L_inl', 0);
model.geom('geom1').run('ext2');
model.geom('geom1').feature.create('ext3', 'Extrude');
model.geom('geom1').feature('ext3').set('extrudefrom', 'faces');
model.geom('geom1').feature('ext3').selection('inputface').set('ext2', [105 113 101 111]);
model.geom('geom1').feature('ext3').setIndex('distance', 'L_outl', 0);
model.geom('geom1').run('ext3');
model.geom('geom1').run('fin');
model.geom('geom1').create('sel1', 'ExplicitSelection');
model.geom('geom1').feature('sel1').label('Separators');
model.geom('geom1').feature('sel1').selection('selection').set('fin', [5 10 15 16 21 23]);
model.geom('geom1').run('sel1');
model.geom('geom1').create('sel2', 'ExplicitSelection');
model.geom('geom1').feature('sel2').label('Oxygen Channels');
model.geom('geom1').feature('sel2').selection('selection').set('fin', [2 3 12 18 26 27]);
model.geom('geom1').run('sel2');
model.geom('geom1').create('sel3', 'ExplicitSelection');
model.geom('geom1').feature('sel3').label('Oxygen GDEs');
model.geom('geom1').feature('sel3').selection('selection').set('fin', [6 11 17 24]);
model.geom('geom1').run('sel3');
model.geom('geom1').create('sel4', 'ExplicitSelection');
model.geom('geom1').feature('sel4').label('Hydrogen Channels');
model.geom('geom1').feature('sel4').selection('selection').set('fin', [9 14 19 22]);
model.geom('geom1').feature('sel4').selection('selection').clear('fin');
model.geom('geom1').feature('sel4').selection('selection').set('fin', [1 4 8 20 25 28]);
model.geom('geom1').run('sel4');
model.geom('geom1').create('sel5', 'ExplicitSelection');
model.geom('geom1').feature('sel5').label('Hydrogen GDEs');
model.geom('geom1').feature('sel5').selection('selection').set('fin', [9 14 19 22]);
model.geom('geom1').run('sel5');
model.geom('geom1').create('sel6', 'ExplicitSelection');
model.geom('geom1').feature('sel6').label('Bipolar Plates');
model.geom('geom1').feature('sel6').selection('selection').set('fin', [7 13]);
model.geom('geom1').run('sel6');
model.geom('geom1').create('sel7', 'ExplicitSelection');
model.geom('geom1').feature('sel7').label('Hydrogen Inlets');
model.geom('geom1').feature('sel7').selection('selection').init(2);
model.geom('geom1').feature('sel7').selection('selection').set('fin', [1 14]);
model.geom('geom1').run('sel7');
model.geom('geom1').create('sel8', 'ExplicitSelection');
model.geom('geom1').feature('sel8').label('Oxygen Inlets');
model.geom('geom1').feature('sel8').selection('selection').init(2);
model.geom('geom1').feature('sel8').selection('selection').set('fin', [5 11]);
model.geom('geom1').run('sel8');
model.geom('geom1').create('sel9', 'ExplicitSelection');
model.geom('geom1').feature('sel9').label('Hydrogen Outlets');
model.geom('geom1').feature('sel9').selection('selection').init(2);
model.geom('geom1').feature('sel9').selection('selection').set('fin', [134 137]);
model.geom('geom1').run('sel9');
model.geom('geom1').create('sel10', 'ExplicitSelection');
model.geom('geom1').feature('sel10').label('Oxygen Outlets');
model.geom('geom1').feature('sel10').selection('selection').init(2);
model.geom('geom1').feature('sel10').selection('selection').set('fin', [135 136]);
model.geom('geom1').run('sel10');
model.geom('geom1').create('unisel1', 'UnionSelection');
model.geom('geom1').feature('unisel1').label('Channels');
model.geom('geom1').feature('unisel1').set('input', {'sel2' 'sel4'});
model.geom('geom1').run('unisel1');
model.geom('geom1').create('unisel2', 'UnionSelection');
model.geom('geom1').feature('unisel2').label('GDEs');
model.geom('geom1').feature('unisel2').set('input', {'sel3' 'sel5'});
model.geom('geom1').run('unisel2');
model.geom('geom1').create('unisel3', 'UnionSelection');
model.geom('geom1').feature('unisel3').label('Channels and GDEs');
model.geom('geom1').feature('unisel3').set('input', {'unisel1' 'unisel2'});
model.geom('geom1').run('unisel3');
model.geom('geom1').create('unisel4', 'UnionSelection');
model.geom('geom1').feature('unisel4').label('Inlets');
model.geom('geom1').feature('unisel4').set('entitydim', 2);
model.geom('geom1').feature('unisel4').set('input', {'sel7' 'sel8'});
model.geom('geom1').run('unisel4');
model.geom('geom1').create('unisel5', 'UnionSelection');
model.geom('geom1').feature('unisel5').label('Outlets');
model.geom('geom1').feature('unisel5').set('entitydim', 2);
model.geom('geom1').feature('unisel5').set('input', {'sel9' 'sel10'});
model.geom('geom1').run('unisel5');
model.geom('geom1').create('unisel6', 'UnionSelection');
model.geom('geom1').feature('unisel6').label('Electrolyte Domains');
model.geom('geom1').feature('unisel6').set('input', {'sel1' 'unisel1' 'unisel2'});
model.geom('geom1').run('unisel6');
model.geom('geom1').create('sel11', 'ExplicitSelection');
model.geom('geom1').feature('sel11').label('Triangular Mesh Boundaries');
model.geom('geom1').feature('sel11').selection('selection').init(2);
model.geom('geom1').feature('sel11').selection('selection').set('fin', [30 42 63 68]);
model.geom('geom1').run('sel11');
model.geom('geom1').create('sel12', 'ExplicitSelection');
model.geom('geom1').feature('sel12').label('Mapped Mesh Boundaries');
model.geom('geom1').feature('sel12').selection('selection').init(2);
model.geom('geom1').feature('sel12').selection('selection').set('fin', [21 24 33 36 39 48 51 57 60 66 71 75 78 81]);
model.geom('geom1').run('sel12');
model.geom('geom1').create('mcf1', 'MeshControlFaces');
model.geom('geom1').feature('mcf1').selection('input').set('fin', [58 61 67 72 76 79 82]);
model.geom('geom1').run('mcf1');

model.title([]);

model.description('');

model.label('zero_gap_aec_geom_sequence.mph');

model.modelNode.label('Components');

out = model;
