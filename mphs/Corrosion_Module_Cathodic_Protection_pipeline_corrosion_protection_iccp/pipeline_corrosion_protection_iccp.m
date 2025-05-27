function out = model
%
% pipeline_corrosion_protection_iccp.m
%
% Model exported on May 26 2025, 21:27 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/Corrosion_Module/Cathodic_Protection');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 3);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.physics.create('cp', 'CathodicProtection', 'geom1');
model.physics('cp').model('comp1');

model.study.create('std1');
model.study('std1').create('stat', 'Stationary');
model.study('std1').feature('stat').setSolveFor('/physics/cp', true);

% To import content from file, use:
% model.param.loadFile('FILENAME');
model.param.set('ranode', '0.2[m]/2', 'Anode radius');
model.param.set('rpipe1', '6.625[in]/2', 'Pipeline 1 radius');
model.param.set('rpipe2', '16[in]/2', 'Pipeline 2 radius');
model.param.set('rpipe3', '10.75[in]/2', 'Pipeline 3 radius');
model.param.set('lanode', '10[m]', 'Anode length');
model.param.set('lpipe', '68.442[km]', 'Pipeline length');
model.param.set('sigma_top', '0.02[S/m]', 'Electrolyte conductivity, top layer');
model.param.set('sigma_bottom', '0.005[S/m]', 'Electrolyte conductivity, bottom layer');
model.param.set('sigmas', '1/(1.74e-7[ohm*m])', 'Electrical conductivity, pipeline');
model.param.set('R_short', '1e-3[ohm]', 'Connection resistance');
model.param.set('E_control', '-0.7[V]', 'Control potential vs. CSE');

model.geom('geom1').create('blk1', 'Block');
model.geom('geom1').feature('blk1').set('size', {'120[km]' '60[km]' '1'});
model.geom('geom1').feature('blk1').setIndex('size', 100, 2);
model.geom('geom1').feature('blk1').set('pos', {'-25[km]' '-20[km]' '0'});
model.geom('geom1').feature('blk1').setIndex('pos', -100, 2);
model.geom('geom1').feature('blk1').setIndex('layer', 65, 0);
model.geom('geom1').run('blk1');
model.geom('geom1').create('wp1', 'WorkPlane');
model.geom('geom1').feature('wp1').set('unite', true);
model.geom('geom1').feature('wp1').label('Pipeline 1');
model.geom('geom1').feature('wp1').set('quickz', -20);
model.geom('geom1').feature('wp1').set('selresult', true);
model.geom('geom1').feature('wp1').set('selresultshow', 'edg');
model.geom('geom1').feature('wp1').geom.create('pol1', 'Polygon');
model.geom('geom1').feature('wp1').geom.feature('pol1').set('source', 'table');
model.geom('geom1').feature('wp1').geom.feature('pol1').set('type', 'open');
model.geom('geom1').feature('wp1').geom.feature('pol1').set('table', {'0' '0';  ...
'2[km]' '2.5[km]';  ...
'7[km]' '1.5[km]';  ...
'8.6[km]' '2.5[km]';  ...
'16[km]' '7[km]';  ...
'18[km]' '10[km]';  ...
'21[km]' '11.5[km]';  ...
'26[km]' '14[km]';  ...
'30[km]' '14.5[km]';  ...
'31[km]' '17[km]';  ...
'39[km]' '20.3[km]';  ...
'42[km]' '21.5[km]';  ...
'45[km]' '19.6[km]';  ...
'47[km]' '18[km]';  ...
'53[km]' '20.5[km]';  ...
'lpipe' '19.5[km]'});
model.geom('geom1').run('wp1');
model.geom('geom1').create('wp2', 'WorkPlane');
model.geom('geom1').feature('wp2').set('unite', true);
model.geom('geom1').feature('wp2').label('Pipeline 2');
model.geom('geom1').feature('wp2').set('quickz', -15);
model.geom('geom1').feature('wp2').set('selresult', true);
model.geom('geom1').feature('wp2').set('selresultshow', 'edg');
model.geom('geom1').feature('wp2').geom.create('pol1', 'Polygon');
model.geom('geom1').feature('wp2').geom.feature('pol1').set('source', 'table');
model.geom('geom1').feature('wp2').geom.feature('pol1').set('type', 'open');
model.geom('geom1').feature('wp2').geom.feature('pol1').set('table', {'0' '0+10[m]';  ...
'2[km]' '2.5[km]+10[m]';  ...
'7[km]' '1.5[km]+10[m]';  ...
'8.6[km]' '2.5[km]+10[m]';  ...
'16[km]' '7[km]+10[m]';  ...
'18[km]' '10[km]+10[m]';  ...
'21[km]' '11.5[km]+10[m]';  ...
'26[km]' '14[km]+10[m]';  ...
'30[km]' '14.5[km]+10[m]';  ...
'31[km]' '17[km]+10[m]';  ...
'39[km]' '20.3[km]+10[m]';  ...
'42[km]' '21.5[km]+10[m]';  ...
'45[km]' '19.6[km]+10[m]';  ...
'47[km]' '18[km]+10[m]';  ...
'53[km]' '20.5[km]+10[m]';  ...
'lpipe' '19.5[km]+10[m]'});
model.geom('geom1').run('wp2');
model.geom('geom1').create('wp3', 'WorkPlane');
model.geom('geom1').feature('wp3').set('unite', true);
model.geom('geom1').feature('wp3').label('Pipeline 3');
model.geom('geom1').feature('wp3').set('quickz', -15);
model.geom('geom1').feature('wp3').set('selresult', true);
model.geom('geom1').feature('wp3').set('selresultshow', 'edg');
model.geom('geom1').feature('wp3').geom.create('pol1', 'Polygon');
model.geom('geom1').feature('wp3').geom.feature('pol1').set('source', 'table');
model.geom('geom1').feature('wp3').geom.feature('pol1').set('type', 'open');
model.geom('geom1').feature('wp3').geom.feature('pol1').set('table', {'0' '0+20[m]';  ...
'2[km]' '2.5[km]+20[m]';  ...
'7[km]' '1.5[km]+20[m]';  ...
'8.6[km]' '2.5[km]+20[m]';  ...
'16[km]' '7[km]+20[m]';  ...
'18[km]' '10[km]+20[m]';  ...
'21[km]' '11.5[km]+20[m]';  ...
'26[km]' '14[km]+20[m]';  ...
'30[km]' '14.5[km]+20[m]';  ...
'31[km]' '17[km]+20[m]';  ...
'39[km]' '20.3[km]+20[m]';  ...
'42[km]' '21.5[km]+20[m]';  ...
'45[km]' '19.6[km]+20[m]';  ...
'47[km]' '18[km]+20[m]';  ...
'53[km]' '20.5[km]+20[m]';  ...
'lpipe' '19.5[km]+20[m]'});
model.geom('geom1').run('wp3');
model.geom('geom1').create('wp4', 'WorkPlane');
model.geom('geom1').feature('wp4').set('unite', true);
model.geom('geom1').feature('wp4').label('Anode Positions');
model.geom('geom1').feature('wp4').set('quickz', -10);
model.geom('geom1').feature('wp4').set('selresult', true);
model.geom('geom1').feature('wp4').set('selresultshow', false);
model.geom('geom1').feature('wp4').geom.create('pt1', 'Point');
model.geom('geom1').feature('wp4').geom.feature('pt1').setIndex('p', 100, 0);
model.geom('geom1').feature('wp4').geom.feature('pt1').setIndex('p', -200, 1);
model.geom('geom1').feature('wp4').geom.feature('pt1').set('selresult', true);
model.geom('geom1').feature('wp4').geom.feature('pt1').set('selresultshow', 'all');
model.geom('geom1').feature('wp4').geom.feature.duplicate('pt2', 'pt1');
model.geom('geom1').feature('wp4').geom.feature('pt2').setIndex('p', '2[km]', 0);
model.geom('geom1').feature('wp4').geom.feature('pt2').setIndex('p', '3[km]-200', 1);
model.geom('geom1').feature('wp4').geom.feature('pt2').set('selresult', false);
model.geom('geom1').feature('wp4').geom.feature.duplicate('pt3', 'pt2');
model.geom('geom1').feature('wp4').geom.feature('pt3').setIndex('p', '8.5[km]', 0);
model.geom('geom1').feature('wp4').geom.feature('pt3').setIndex('p', '2.8[km]+200', 1);
model.geom('geom1').feature('wp4').geom.feature.duplicate('pt4', 'pt3');
model.geom('geom1').feature('wp4').geom.feature('pt4').setIndex('p', '16[km]', 0);
model.geom('geom1').feature('wp4').geom.feature('pt4').setIndex('p', '7[km]-200', 1);
model.geom('geom1').feature('wp4').geom.feature.duplicate('pt5', 'pt4');
model.geom('geom1').feature('wp4').geom.feature('pt5').setIndex('p', '21[km]', 0);
model.geom('geom1').feature('wp4').geom.feature('pt5').setIndex('p', '11[km]+200', 1);
model.geom('geom1').feature('wp4').geom.feature.duplicate('pt6', 'pt5');
model.geom('geom1').feature('wp4').geom.feature('pt6').setIndex('p', '30[km]', 0);
model.geom('geom1').feature('wp4').geom.feature('pt6').setIndex('p', '14.75[km]-200', 1);
model.geom('geom1').feature('wp4').geom.feature.duplicate('pt7', 'pt6');
model.geom('geom1').feature('wp4').geom.feature('pt7').setIndex('p', '39[km]', 0);
model.geom('geom1').feature('wp4').geom.feature('pt7').setIndex('p', '20.5[km]+200', 1);
model.geom('geom1').feature('wp4').geom.feature.duplicate('pt8', 'pt7');
model.geom('geom1').feature('wp4').geom.feature('pt8').setIndex('p', '45[km]', 0);
model.geom('geom1').feature('wp4').geom.feature('pt8').setIndex('p', '20[km]-200', 1);
model.geom('geom1').feature('wp4').geom.feature.duplicate('pt9', 'pt8');
model.geom('geom1').feature('wp4').geom.feature('pt9').setIndex('p', '53[km]', 0);
model.geom('geom1').feature('wp4').geom.feature('pt9').setIndex('p', '20.5[km]+200', 1);
model.geom('geom1').feature('wp4').geom.run('pt9');
model.geom('geom1').run('wp4');
model.geom('geom1').create('copy1', 'Copy');
model.geom('geom1').feature('copy1').label('Pipeline 1 Contour for Meshing');
model.geom('geom1').feature('copy1').selection('input').named('wp1');
model.geom('geom1').feature('copy1').set('displz', 20);
model.geom('geom1').feature('copy1').set('selresult', true);
model.geom('geom1').feature('copy1').set('selresultshow', false);
model.geom('geom1').feature('copy1').set('propagatesel', false);
model.geom('geom1').run('copy1');
model.geom('geom1').create('copy2', 'Copy');
model.geom('geom1').feature('copy2').selection('input').named('wp2');
model.geom('geom1').feature('copy2').label('Pipeline 2 Contour for Meshing');
model.geom('geom1').feature('copy2').set('displz', 15);
model.geom('geom1').feature('copy2').set('selresult', true);
model.geom('geom1').feature('copy2').set('propagatesel', false);
model.geom('geom1').run('copy2');
model.geom('geom1').create('copy3', 'Copy');
model.geom('geom1').feature('copy3').selection('input').named('wp3');
model.geom('geom1').feature('copy3').label('Pipeline 3 Contour for Meshing');
model.geom('geom1').feature('copy3').set('displz', 15);
model.geom('geom1').feature('copy3').set('selresult', true);
model.geom('geom1').feature('copy3').set('selresultshow', false);
model.geom('geom1').feature('copy3').set('propagatesel', false);
model.geom('geom1').run('copy3');
model.geom('geom1').create('copy4', 'Copy');
model.geom('geom1').feature('copy4').label('Anode Positions for Meshing');
model.geom('geom1').feature('copy4').selection('input').named('wp4');
model.geom('geom1').feature('copy4').set('displz', 10);
model.geom('geom1').feature('copy4').set('selresult', true);
model.geom('geom1').feature('copy4').set('selresultshow', 'pnt');
model.geom('geom1').feature('copy4').set('propagatesel', false);
model.geom('geom1').run('copy4');
model.geom('geom1').create('rot1', 'Rotate');
model.geom('geom1').feature('rot1').selection('input').set({'blk1'});
model.geom('geom1').feature('rot1').set('rot', 15);
model.geom('geom1').feature('rot1').set('pos', {'30[km]' '10[km]' '0'});
model.geom('geom1').run('rot1');
model.geom('geom1').create('unisel1', 'UnionSelection');
model.geom('geom1').feature('unisel1').label('Pipeline contours for meshing');
model.geom('geom1').feature('unisel1').set('entitydim', 1);
model.geom('geom1').feature('unisel1').set('input', {'copy1' 'copy2' 'copy3'});
model.geom('geom1').run('fin');

model.selection.create('sel1', 'Explicit');
model.selection('sel1').model('comp1');
model.selection('sel1').label('Anode 1');
model.selection('sel1').geom(0);
model.selection('sel1').set([13]);
model.selection.duplicate('sel2', 'sel1');
model.selection('sel2').label('Anode 2');
model.selection('sel2').set([21]);
model.selection.duplicate('sel3', 'sel2');
model.selection('sel3').label('Anode 3');
model.selection('sel3').set([29]);
model.selection.duplicate('sel4', 'sel3');
model.selection('sel4').label('Anode 4');
model.selection('sel4').set([37]);
model.selection.duplicate('sel5', 'sel4');
model.selection('sel5').label('Anode 5');
model.selection('sel5').set([51]);
model.selection.duplicate('sel6', 'sel5');
model.selection('sel6').label('Anode 6');
model.selection('sel6').set([71]);
model.selection.duplicate('sel7', 'sel6');
model.selection('sel7').label('Anode 7');
model.selection('sel7').set([85]);
model.selection.duplicate('sel8', 'sel7');
model.selection('sel8').label('Anode 8');
model.selection('sel8').set([99]);
model.selection.duplicate('sel9', 'sel8');
model.selection('sel9').label('Anode 9');
model.selection('sel9').set([113]);
model.selection.create('uni1', 'Union');
model.selection('uni1').model('comp1');
model.selection('uni1').label('Pipelines');
model.selection('uni1').set('entitydim', 1);
model.selection('uni1').set('input', {'geom1_wp1_edg' 'geom1_wp2_edg' 'geom1_wp3_edg'});

model.physics('cp').prop('PhysicsVsMaterialsReferenceElectrodePotential').set('PhysicsVsMaterialsReferenceElectrodePotential', 'CSE');
model.physics('cp').prop('ShapeProperty').set('order_electricpotentialionicphase', 1);
model.physics('cp').feature('ice1').set('sigmal_mat', 'userdef');
model.physics('cp').feature('ice1').set('sigmal', {'sigma_top' '0' '0' '0' 'sigma_top' '0' '0' '0' 'sigma_top'});
model.physics('cp').create('ice2', 'Electrolyte', 3);
model.physics('cp').feature('ice2').selection.set([1]);
model.physics('cp').feature('ice2').set('sigmal_mat', 'userdef');
model.physics('cp').feature('ice2').set('sigmal', {'sigma_bottom' '0' '0' '0' 'sigma_bottom' '0' '0' '0' 'sigma_bottom'});
model.physics('cp').create('edge1', 'EdgeElectrode', 1);
model.physics('cp').feature('edge1').selection.named('geom1_wp1_edg');
model.physics('cp').feature('edge1').set('redge', 'rpipe1');
model.physics('cp').feature('edge1').feature('er1').set('Eeq_mat', 'from_mat');
model.physics('cp').feature('edge1').feature('er1').set('ilocmat_mat', 'from_mat');
model.physics('cp').feature('edge1').create('connp1', 'EdgeConnectionPoint', 0);
model.physics('cp').feature('edge1').feature('connp1').selection.set([7]);
model.physics('cp').feature('edge1').feature('connp1').set('DefineReferenceElectrode', true);
model.physics('cp').feature('edge1').feature.duplicate('connp2', 'connp1');
model.physics('cp').feature('edge1').feature('connp2').selection.set([15]);
model.physics('cp').feature('edge1').feature.duplicate('connp3', 'connp2');
model.physics('cp').feature('edge1').feature('connp3').selection.set([31]);
model.physics('cp').feature('edge1').feature.duplicate('connp4', 'connp3');
model.physics('cp').feature('edge1').feature('connp4').selection.set([39]);
model.physics('cp').feature('edge1').feature.duplicate('connp5', 'connp4');
model.physics('cp').feature('edge1').feature('connp5').selection.set([53]);
model.physics('cp').feature('edge1').feature.duplicate('connp6', 'connp5');
model.physics('cp').feature('edge1').feature('connp6').selection.set([65]);
model.physics('cp').feature('edge1').feature.duplicate('connp7', 'connp6');
model.physics('cp').feature('edge1').feature('connp7').selection.set([79]);
model.physics('cp').feature('edge1').feature.duplicate('connp8', 'connp7');
model.physics('cp').feature('edge1').feature('connp8').selection.set([93]);
model.physics('cp').feature('edge1').feature.duplicate('connp9', 'connp8');
model.physics('cp').feature('edge1').feature('connp9').selection.set([107]);
model.physics('cp').create('edge2', 'EdgeElectrode', 1);
model.physics('cp').feature('edge2').selection.named('geom1_wp2_edg');
model.physics('cp').feature('edge2').set('redge', 'rpipe2');
model.physics('cp').feature('edge2').feature('er1').set('Eeq_mat', 'from_mat');
model.physics('cp').feature('edge2').feature('er1').set('ilocmat_mat', 'from_mat');
model.physics('cp').feature('edge2').create('extshort1', 'EdgeExternalShort', 0);
model.physics('cp').feature('edge2').feature('extshort1').selection.set([9]);
model.physics('cp').feature('edge2').feature('extshort1').set('R', 'R_short');
model.physics('cp').feature('edge2').feature('extshort1').set('phisthere_src', 'root.comp1.cp.phisconnect_edge1_connp1');
model.physics('cp').feature('edge2').create('extshort2', 'EdgeExternalShort', 0);
model.physics('cp').feature('edge2').feature('extshort2').selection.set([17]);
model.physics('cp').feature('edge2').feature('extshort2').set('R', 'R_short');
model.physics('cp').feature('edge2').feature('extshort2').set('phisthere_src', 'root.comp1.cp.phisconnect_edge1_connp2');
model.physics('cp').feature('edge2').create('extshort3', 'EdgeExternalShort', 0);
model.physics('cp').feature('edge2').feature('extshort3').selection.set([33]);
model.physics('cp').feature('edge2').feature('extshort3').set('R', 'R_short');
model.physics('cp').feature('edge2').feature('extshort3').set('phisthere_src', 'root.comp1.cp.phisconnect_edge1_connp3');
model.physics('cp').feature('edge2').create('extshort4', 'EdgeExternalShort', 0);
model.physics('cp').feature('edge2').feature('extshort4').selection.set([41]);
model.physics('cp').feature('edge2').feature('extshort4').set('R', 'R_short');
model.physics('cp').feature('edge2').feature('extshort4').set('phisthere_src', 'root.comp1.cp.phisconnect_edge1_connp4');
model.physics('cp').feature('edge2').create('extshort5', 'EdgeExternalShort', 0);
model.physics('cp').feature('edge2').feature('extshort5').selection.set([55]);
model.physics('cp').feature('edge2').feature('extshort5').set('R', 'R_short');
model.physics('cp').feature('edge2').feature('extshort5').set('phisthere_src', 'root.comp1.cp.phisconnect_edge1_connp5');
model.physics('cp').feature('edge2').create('extshort6', 'EdgeExternalShort', 0);
model.physics('cp').feature('edge2').feature('extshort6').selection.set([67]);
model.physics('cp').feature('edge2').feature('extshort6').set('R', 'R_short');
model.physics('cp').feature('edge2').feature('extshort6').set('phisthere_src', 'root.comp1.cp.phisconnect_edge1_connp6');
model.physics('cp').feature('edge2').create('extshort7', 'EdgeExternalShort', 0);
model.physics('cp').feature('edge2').feature('extshort7').selection.set([81]);
model.physics('cp').feature('edge2').feature('extshort7').set('R', 'R_short');
model.physics('cp').feature('edge2').feature('extshort7').set('phisthere_src', 'root.comp1.cp.phisconnect_edge1_connp7');
model.physics('cp').feature('edge2').create('extshort8', 'EdgeExternalShort', 0);
model.physics('cp').feature('edge2').feature('extshort8').selection.set([95]);
model.physics('cp').feature('edge2').feature('extshort8').set('R', 'R_short');
model.physics('cp').feature('edge2').feature('extshort8').set('phisthere_src', 'root.comp1.cp.phisconnect_edge1_connp8');
model.physics('cp').feature('edge2').create('extshort9', 'EdgeExternalShort', 0);
model.physics('cp').feature('edge2').feature('extshort9').selection.set([109]);
model.physics('cp').feature('edge2').feature('extshort9').set('R', 'R_short');
model.physics('cp').feature('edge2').feature('extshort9').set('phisthere_src', 'root.comp1.cp.phisconnect_edge1_connp9');
model.physics('cp').feature.duplicate('edge3', 'edge2');
model.physics('cp').feature('edge3').selection.named('geom1_wp3_edg');
model.physics('cp').feature('edge3').set('redge', 'rpipe3');
model.physics('cp').feature('edge3').feature('extshort1').selection.set([11]);
model.physics('cp').feature('edge3').feature('extshort2').selection.set([19]);
model.physics('cp').feature('edge3').feature('extshort3').selection.set([35]);
model.physics('cp').feature('edge3').feature('extshort4').selection.set([43]);
model.physics('cp').feature('edge3').feature('extshort5').selection.set([57]);
model.physics('cp').feature('edge3').feature('extshort6').selection.set([69]);
model.physics('cp').feature('edge3').feature('extshort7').selection.set([83]);
model.physics('cp').feature('edge3').feature('extshort8').selection.set([97]);
model.physics('cp').feature('edge3').feature('extshort9').selection.set([111]);
model.physics('cp').feature('edge3').create('egnd1', 'EdgeElectricGround', 0);
model.physics('cp').feature('edge3').feature('egnd1').selection.set([119]);
model.physics('cp').create('imprcp1', 'ImpressedCurrentPoint', 0);
model.physics('cp').feature('imprcp1').selection.named('sel1');
model.physics('cp').feature('imprcp1').set('Eimpr', 'E_control');
model.physics('cp').feature('imprcp1').set('phissense_src', 'root.comp1.cp.phisconnect_edge1_connp1');
model.physics('cp').feature('imprcp1').set('phisref_src', 'root.comp1.cp.phisref_connp1');
model.physics('cp').feature.duplicate('imprcp2', 'imprcp1');
model.physics('cp').feature('imprcp2').selection.named('sel2');
model.physics('cp').feature('imprcp2').set('phissense_src', 'root.comp1.cp.phisconnect_edge1_connp2');
model.physics('cp').feature('imprcp2').set('phisref_src', 'root.comp1.cp.phisref_connp2');
model.physics('cp').feature.duplicate('imprcp3', 'imprcp2');
model.physics('cp').feature('imprcp3').selection.named('sel3');
model.physics('cp').feature('imprcp3').set('phissense_src', 'root.comp1.cp.phisconnect_edge1_connp3');
model.physics('cp').feature('imprcp3').set('phisref_src', 'root.comp1.cp.phisref_connp3');
model.physics('cp').feature.duplicate('imprcp4', 'imprcp3');
model.physics('cp').feature('imprcp4').selection.named('sel4');
model.physics('cp').feature('imprcp4').set('phissense_src', 'root.comp1.cp.phisconnect_edge1_connp4');
model.physics('cp').feature('imprcp4').set('phisref_src', 'root.comp1.cp.phisref_connp4');
model.physics('cp').feature.duplicate('imprcp5', 'imprcp4');
model.physics('cp').feature('imprcp5').selection.named('sel5');
model.physics('cp').feature('imprcp5').set('phissense_src', 'root.comp1.cp.phisconnect_edge1_connp5');
model.physics('cp').feature('imprcp5').set('phisref_src', 'root.comp1.cp.phisref_connp5');
model.physics('cp').feature.duplicate('imprcp6', 'imprcp5');
model.physics('cp').feature('imprcp6').selection.named('sel6');
model.physics('cp').feature('imprcp6').set('phissense_src', 'root.comp1.cp.phisconnect_edge1_connp6');
model.physics('cp').feature('imprcp6').set('phisref_src', 'root.comp1.cp.phisref_connp6');
model.physics('cp').feature.duplicate('imprcp7', 'imprcp6');
model.physics('cp').feature('imprcp7').selection.named('sel7');
model.physics('cp').feature('imprcp7').set('phissense_src', 'root.comp1.cp.phisconnect_edge1_connp7');
model.physics('cp').feature('imprcp7').set('phisref_src', 'root.comp1.cp.phisref_connp7');
model.physics('cp').feature.duplicate('imprcp8', 'imprcp7');
model.physics('cp').feature('imprcp8').selection.named('sel8');
model.physics('cp').feature('imprcp8').set('phissense_src', 'root.comp1.cp.phisconnect_edge1_connp8');
model.physics('cp').feature('imprcp8').set('phisref_src', 'root.comp1.cp.phisref_connp8');
model.physics('cp').feature.duplicate('imprcp9', 'imprcp8');
model.physics('cp').feature('imprcp9').selection.named('sel9');
model.physics('cp').feature('imprcp9').set('phissense_src', 'root.comp1.cp.phisconnect_edge1_connp9');
model.physics('cp').feature('imprcp9').set('phisref_src', 'root.comp1.cp.phisref_connp9');

model.material.create('mat1', 'Common', 'comp1');
model.material('mat1').propertyGroup.create('LocalCurrentDensity', 'Local current density');
model.material('mat1').propertyGroup('LocalCurrentDensity').func.create('int1', 'Interpolation');
model.material('mat1').propertyGroup.create('ElectrodePotential', 'Equilibrium potential');
model.material('mat1').label('Q235 steel in soil');
model.material('mat1').propertyGroup('LocalCurrentDensity').func('int1').set('funcname', 'iloc_exp');
model.material('mat1').propertyGroup('LocalCurrentDensity').func('int1').set('table', {'-0.425' '3e-3';  ...
'-0.56' '0';  ...
'-0.72' '-18e-3';  ...
'-0.95' '-66e-3';  ...
'-1.1' '-90e-3';  ...
'-1.14' '-105e-3';  ...
'-1.18' '-126e-3'});
model.material('mat1').propertyGroup('LocalCurrentDensity').func('int1').set('extrap', 'linear');
model.material('mat1').propertyGroup('LocalCurrentDensity').func('int1').set('fununit', {'A/m^2'});
model.material('mat1').propertyGroup('LocalCurrentDensity').func('int1').set('argunit', {'V'});
model.material('mat1').propertyGroup('LocalCurrentDensity').set('ilocmat', 'iloc_exp(E_vs_ref_exp)');
model.material('mat1').propertyGroup('LocalCurrentDensity').set('INFO_PREFIX:ilocmat', ['G. Cui, Z. Li, C. Yang and M. Wang, ' native2unicode(hex2dec({'20' '1c'}), 'unicode') 'The influence of DC stray current on pipeline corrosion' native2unicode(hex2dec({'20' '1d'}), 'unicode') ', Petroleum Science, vol. 13, p. 135, 2016.']);
model.material('mat1').propertyGroup('LocalCurrentDensity').set('E_vs_SHE', 'V');
model.material('mat1').propertyGroup('LocalCurrentDensity').descr('E_vs_SHE', 'Electrode potential vs. SHE');
model.material('mat1').propertyGroup('LocalCurrentDensity').set('E_ref_exp_vs_SHE', '0.314 [V]');
model.material('mat1').propertyGroup('LocalCurrentDensity').descr('E_ref_exp_vs_SHE', 'Reference electrode potential in experiment vs. SHE');
model.material('mat1').propertyGroup('LocalCurrentDensity').set('E_vs_ref_exp', 'E_vs_SHE-E_ref_exp_vs_SHE');
model.material('mat1').propertyGroup('LocalCurrentDensity').descr('E_vs_ref_exp', 'Electrode potential vs. experimental CSE reference electrode');
model.material('mat1').propertyGroup('LocalCurrentDensity').addInput('electricpotential');
model.material('mat1').propertyGroup('ElectrodePotential').set('Eeq', 'Eeq_vs_SHE');
model.material('mat1').propertyGroup('ElectrodePotential').set('INFO_PREFIX:Eeq', ['G. Cui, Z. Li, C. Yang and M. Wang, ' native2unicode(hex2dec({'20' '1c'}), 'unicode') 'The influence of DC stray current on pipeline corrosion' native2unicode(hex2dec({'20' '1d'}), 'unicode') ', Petroleum Science, vol. 13, p. 135, 2016.']);
model.material('mat1').propertyGroup('ElectrodePotential').set('dEeqdT', '0');
model.material('mat1').propertyGroup('ElectrodePotential').set('cEeqref', '0');
model.material('mat1').propertyGroup('ElectrodePotential').set('Eeq_vs_ref_exp', '-0.56 [V]');
model.material('mat1').propertyGroup('ElectrodePotential').descr('Eeq_vs_ref_exp', 'Equilibrium (open circuit) potential vs. CSE');
model.material('mat1').propertyGroup('ElectrodePotential').set('E_ref_exp_vs_SHE', '0.314 [V]');
model.material('mat1').propertyGroup('ElectrodePotential').descr('E_ref_exp_vs_SHE', 'Reference electrode potential in experiment vs. SHE');
model.material('mat1').propertyGroup('ElectrodePotential').set('Eeq_vs_SHE', 'Eeq_vs_ref_exp+E_ref_exp_vs_SHE');
model.material('mat1').propertyGroup('ElectrodePotential').descr('Eeq_vs_SHE', 'Equilibrium (open circuit) potential vs. SHE');
model.material('mat1').propertyGroup('ElectrodePotential').addInput('concentration');
model.material('mat1').selection.geom('geom1', 1);
model.material('mat1').selection.named('uni1');
model.material('mat1').propertyGroup('def').set('electricconductivity', {'sigmas'});

model.mesh('mesh1').create('ftri1', 'FreeTri');
model.mesh('mesh1').feature('ftri1').selection.set([7]);
model.mesh('mesh1').feature('ftri1').create('size1', 'Size');
model.mesh('mesh1').feature('ftri1').feature('size1').selection.geom('geom1', 0);
model.mesh('mesh1').feature('ftri1').feature('size1').selection.named('geom1_copy4_pnt');
model.mesh('mesh1').feature('ftri1').feature('size1').set('custom', true);
model.mesh('mesh1').feature('ftri1').feature('size1').set('hmaxactive', true);
model.mesh('mesh1').feature('ftri1').feature('size1').set('hmax', '1[m]');
model.mesh('mesh1').feature('ftri1').create('size2', 'Size');
model.mesh('mesh1').feature('ftri1').feature('size2').selection.geom('geom1', 1);
model.mesh('mesh1').feature('ftri1').feature('size2').selection.named('geom1_unisel1');
model.mesh('mesh1').feature('ftri1').feature('size2').set('custom', true);
model.mesh('mesh1').feature('ftri1').feature('size2').set('hmaxactive', true);
model.mesh('mesh1').feature('ftri1').feature('size2').set('hmax', 50);
model.mesh('mesh1').feature('ftri1').feature('size2').set('hminactive', true);
model.mesh('mesh1').feature('ftri1').feature('size2').set('hmin', 25);
model.mesh('mesh1').feature('ftri1').create('size3', 'Size');
model.mesh('mesh1').create('bl1', 'BndLayer');
model.mesh('mesh1').feature('bl1').create('blp', 'BndLayerProp');
model.mesh('mesh1').feature('bl1').selection.geom('geom1', 2);
model.mesh('mesh1').feature('bl1').selection.set([7]);
model.mesh('mesh1').feature('bl1').feature('blp').selection.named('geom1_unisel1');
model.mesh('mesh1').feature('bl1').feature('blp').set('blnlayers', 1);
model.mesh('mesh1').feature('bl1').feature('blp').set('inittype', 'blhmin');
model.mesh('mesh1').feature('bl1').feature('blp').set('blhmin', 1);
model.mesh('mesh1').create('swe1', 'Sweep');
model.mesh('mesh1').feature('swe1').selection.geom('geom1', 3);
model.mesh('mesh1').feature('swe1').selection.set([2]);
model.mesh('mesh1').feature('swe1').selection('sourceface').set([7]);
model.mesh('mesh1').feature('swe1').selection('targetface').set([6]);
model.mesh('mesh1').feature('swe1').create('dis1', 'Distribution');
model.mesh('mesh1').feature('swe1').feature('dis1').set('type', 'explicit');
model.mesh('mesh1').feature('swe1').feature('dis1').set('explicit', '0, 10/35, 15/35, 20/35,  1');
model.mesh('mesh1').create('swe2', 'Sweep');
model.mesh('mesh1').run;

model.sol.create('sol1');
model.sol('sol1').study('std1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'stat');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').feature('comp1_phil').set('scalemethod', 'manual');
model.sol('sol1').feature('v1').feature('comp1_cp_edge2_extshort4_phishere').set('scalemethod', 'manual');
model.sol('sol1').feature('v1').feature('comp1_cp_edge3_extshort7_phishere').set('scalemethod', 'manual');
model.sol('sol1').feature('v1').feature('comp1_cp_edge2_extshort7_phishere').set('scalemethod', 'manual');
model.sol('sol1').feature('v1').feature('comp1_cp_edge1_connp9_phisconnect').set('scalemethod', 'manual');
model.sol('sol1').feature('v1').feature('comp1_cp_edge3_extshort8_phishere').set('scalemethod', 'manual');
model.sol('sol1').feature('v1').feature('comp1_cp_edge2_extshort2_phishere').set('scalemethod', 'manual');
model.sol('sol1').feature('v1').feature('comp1_cp_edge3_extshort2_phishere').set('scalemethod', 'manual');
model.sol('sol1').feature('v1').feature('comp1_cp_edge2_extshort8_phishere').set('scalemethod', 'manual');
model.sol('sol1').feature('v1').feature('comp1_cp_edge1_connp7_phisconnect').set('scalemethod', 'manual');
model.sol('sol1').feature('v1').feature('comp1_cp_edge1_connp6_phisconnect').set('scalemethod', 'manual');
model.sol('sol1').feature('v1').feature('comp1_cp_edge1_connp8_phisconnect').set('scalemethod', 'manual');
model.sol('sol1').feature('v1').feature('comp1_cp_edge2_extshort5_phishere').set('scalemethod', 'manual');
model.sol('sol1').feature('v1').feature('comp1_cp_edge3_extshort5_phishere').set('scalemethod', 'manual');
model.sol('sol1').feature('v1').feature('comp1_cp_edge1_connp3_phisconnect').set('scalemethod', 'manual');
model.sol('sol1').feature('v1').feature('comp1_cp_edge3_extshort3_phishere').set('scalemethod', 'manual');
model.sol('sol1').feature('v1').feature('comp1_cp_edge3_extshort9_phishere').set('scalemethod', 'manual');
model.sol('sol1').feature('v1').feature('comp1_cp_edge1_connp4_phisconnect').set('scalemethod', 'manual');
model.sol('sol1').feature('v1').feature('comp1_cp_edge1_connp2_phisconnect').set('scalemethod', 'manual');
model.sol('sol1').feature('v1').feature('comp1_cp_edge1_connp5_phisconnect').set('scalemethod', 'manual');
model.sol('sol1').feature('v1').feature('comp1_cp_edge2_extshort6_phishere').set('scalemethod', 'manual');
model.sol('sol1').feature('v1').feature('comp1_cp_edge1_connp1_phisconnect').set('scalemethod', 'manual');
model.sol('sol1').feature('v1').feature('comp1_cp_edge3_extshort6_phishere').set('scalemethod', 'manual');
model.sol('sol1').feature('v1').feature('comp1_cp_edge2_extshort3_phishere').set('scalemethod', 'manual');
model.sol('sol1').feature('v1').feature('comp1_cp_edge3_extshort4_phishere').set('scalemethod', 'manual');
model.sol('sol1').feature('v1').feature('comp1_cp_edge2_extshort1_phishere').set('scalemethod', 'manual');
model.sol('sol1').feature('v1').feature('comp1_cp_edge2_extshort9_phishere').set('scalemethod', 'manual');
model.sol('sol1').feature('v1').feature('comp1_cp_edge3_extshort1_phishere').set('scalemethod', 'manual');
model.sol('sol1').feature('v1').feature('comp1_phil').set('scaleval', '1');
model.sol('sol1').feature('v1').feature('comp1_cp_edge2_extshort4_phishere').set('scaleval', '1');
model.sol('sol1').feature('v1').feature('comp1_cp_edge3_extshort7_phishere').set('scaleval', '1');
model.sol('sol1').feature('v1').feature('comp1_cp_edge2_extshort7_phishere').set('scaleval', '1');
model.sol('sol1').feature('v1').feature('comp1_cp_edge1_connp9_phisconnect').set('scaleval', '1');
model.sol('sol1').feature('v1').feature('comp1_cp_edge3_extshort8_phishere').set('scaleval', '1');
model.sol('sol1').feature('v1').feature('comp1_cp_edge2_extshort2_phishere').set('scaleval', '1');
model.sol('sol1').feature('v1').feature('comp1_cp_edge3_extshort2_phishere').set('scaleval', '1');
model.sol('sol1').feature('v1').feature('comp1_cp_edge2_extshort8_phishere').set('scaleval', '1');
model.sol('sol1').feature('v1').feature('comp1_cp_edge1_connp7_phisconnect').set('scaleval', '1');
model.sol('sol1').feature('v1').feature('comp1_cp_edge1_connp6_phisconnect').set('scaleval', '1');
model.sol('sol1').feature('v1').feature('comp1_cp_edge1_connp8_phisconnect').set('scaleval', '1');
model.sol('sol1').feature('v1').feature('comp1_cp_edge2_extshort5_phishere').set('scaleval', '1');
model.sol('sol1').feature('v1').feature('comp1_cp_edge3_extshort5_phishere').set('scaleval', '1');
model.sol('sol1').feature('v1').feature('comp1_cp_edge1_connp3_phisconnect').set('scaleval', '1');
model.sol('sol1').feature('v1').feature('comp1_cp_edge3_extshort3_phishere').set('scaleval', '1');
model.sol('sol1').feature('v1').feature('comp1_cp_edge3_extshort9_phishere').set('scaleval', '1');
model.sol('sol1').feature('v1').feature('comp1_cp_edge1_connp4_phisconnect').set('scaleval', '1');
model.sol('sol1').feature('v1').feature('comp1_cp_edge1_connp2_phisconnect').set('scaleval', '1');
model.sol('sol1').feature('v1').feature('comp1_cp_edge1_connp5_phisconnect').set('scaleval', '1');
model.sol('sol1').feature('v1').feature('comp1_cp_edge2_extshort6_phishere').set('scaleval', '1');
model.sol('sol1').feature('v1').feature('comp1_cp_edge1_connp1_phisconnect').set('scaleval', '1');
model.sol('sol1').feature('v1').feature('comp1_cp_edge3_extshort6_phishere').set('scaleval', '1');
model.sol('sol1').feature('v1').feature('comp1_cp_edge2_extshort3_phishere').set('scaleval', '1');
model.sol('sol1').feature('v1').feature('comp1_cp_edge3_extshort4_phishere').set('scaleval', '1');
model.sol('sol1').feature('v1').feature('comp1_cp_edge2_extshort1_phishere').set('scaleval', '1');
model.sol('sol1').feature('v1').feature('comp1_cp_edge2_extshort9_phishere').set('scaleval', '1');
model.sol('sol1').feature('v1').feature('comp1_cp_edge3_extshort1_phishere').set('scaleval', '1');
model.sol('sol1').feature('v1').set('control', 'stat');
model.sol('sol1').create('s1', 'Stationary');
model.sol('sol1').feature('s1').set('stol', 1.0E-4);
model.sol('sol1').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('s1').feature('fc1').set('dtech', 'auto');
model.sol('sol1').feature('s1').feature('fc1').set('maxiter', 50);
model.sol('sol1').feature('s1').feature('fc1').set('minstep', 1.0E-6);
model.sol('sol1').feature('s1').create('d1', 'Direct');
model.sol('sol1').feature('s1').feature('d1').set('linsolver', 'pardiso');
model.sol('sol1').feature('s1').feature('d1').label('Direct (cp)');
model.sol('sol1').feature('s1').create('i1', 'Iterative');
model.sol('sol1').feature('s1').feature('i1').set('maxlinit', 1000);
model.sol('sol1').feature('s1').feature('i1').set('nlinnormuse', 'on');
model.sol('sol1').feature('s1').feature('i1').label('Algebraic Multigrid (cp)');
model.sol('sol1').feature('s1').feature('i1').create('mg1', 'Multigrid');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').set('prefun', 'saamg');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').set('maxcoarsedof', 50000);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').set('saamgcompwise', false);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').set('compactaggregation', true);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('pr').create('sc1', 'SCGS');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('pr').feature('sc1').set('vankavars', {'comp1_cp_imprcp1_Itotimpr' 'comp1_cp_imprcp2_Itotimpr' 'comp1_cp_imprcp3_Itotimpr' 'comp1_cp_imprcp4_Itotimpr' 'comp1_cp_imprcp5_Itotimpr' 'comp1_cp_imprcp6_Itotimpr' 'comp1_cp_imprcp7_Itotimpr' 'comp1_cp_imprcp8_Itotimpr' 'comp1_cp_imprcp9_Itotimpr'});
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('pr').feature('sc1').set('vankavarsactive', 'on');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('pr').feature('sc1').set('linesweeptype', 'ssor');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('pr').feature('sc1').set('iter', 1);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('pr').feature('sc1').set('scgsmethod', 'lines');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('po').create('sc1', 'SCGS');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('po').feature('sc1').set('vankavars', {'comp1_cp_imprcp1_Itotimpr' 'comp1_cp_imprcp2_Itotimpr' 'comp1_cp_imprcp3_Itotimpr' 'comp1_cp_imprcp4_Itotimpr' 'comp1_cp_imprcp5_Itotimpr' 'comp1_cp_imprcp6_Itotimpr' 'comp1_cp_imprcp7_Itotimpr' 'comp1_cp_imprcp8_Itotimpr' 'comp1_cp_imprcp9_Itotimpr'});
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('po').feature('sc1').set('vankavarsactive', 'on');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('po').feature('sc1').set('linesweeptype', 'ssor');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('po').feature('sc1').set('iter', 1);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('po').feature('sc1').set('scgsmethod', 'lines');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('cs').create('d1', 'Direct');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('cs').feature('d1').set('linsolver', 'pardiso');
model.sol('sol1').feature('s1').create('i2', 'Iterative');
model.sol('sol1').feature('s1').feature('i2').set('maxlinit', 1000);
model.sol('sol1').feature('s1').feature('i2').set('nlinnormuse', 'on');
model.sol('sol1').feature('s1').feature('i2').label('Geometric Multigrid (cp)');
model.sol('sol1').feature('s1').feature('i2').create('mg1', 'Multigrid');
model.sol('sol1').feature('s1').feature('i2').feature('mg1').feature('pr').create('sc1', 'SCGS');
model.sol('sol1').feature('s1').feature('i2').feature('mg1').feature('pr').feature('sc1').set('vankavars', {'comp1_cp_imprcp1_Itotimpr' 'comp1_cp_imprcp2_Itotimpr' 'comp1_cp_imprcp3_Itotimpr' 'comp1_cp_imprcp4_Itotimpr' 'comp1_cp_imprcp5_Itotimpr' 'comp1_cp_imprcp6_Itotimpr' 'comp1_cp_imprcp7_Itotimpr' 'comp1_cp_imprcp8_Itotimpr' 'comp1_cp_imprcp9_Itotimpr'});
model.sol('sol1').feature('s1').feature('i2').feature('mg1').feature('pr').feature('sc1').set('vankavarsactive', 'on');
model.sol('sol1').feature('s1').feature('i2').feature('mg1').feature('pr').feature('sc1').set('linesweeptype', 'ssor');
model.sol('sol1').feature('s1').feature('i2').feature('mg1').feature('pr').feature('sc1').set('iter', 1);
model.sol('sol1').feature('s1').feature('i2').feature('mg1').feature('pr').feature('sc1').set('scgsmethod', 'lines');
model.sol('sol1').feature('s1').feature('i2').feature('mg1').feature('po').create('sc1', 'SCGS');
model.sol('sol1').feature('s1').feature('i2').feature('mg1').feature('po').feature('sc1').set('vankavars', {'comp1_cp_imprcp1_Itotimpr' 'comp1_cp_imprcp2_Itotimpr' 'comp1_cp_imprcp3_Itotimpr' 'comp1_cp_imprcp4_Itotimpr' 'comp1_cp_imprcp5_Itotimpr' 'comp1_cp_imprcp6_Itotimpr' 'comp1_cp_imprcp7_Itotimpr' 'comp1_cp_imprcp8_Itotimpr' 'comp1_cp_imprcp9_Itotimpr'});
model.sol('sol1').feature('s1').feature('i2').feature('mg1').feature('po').feature('sc1').set('vankavarsactive', 'on');
model.sol('sol1').feature('s1').feature('i2').feature('mg1').feature('po').feature('sc1').set('linesweeptype', 'ssor');
model.sol('sol1').feature('s1').feature('i2').feature('mg1').feature('po').feature('sc1').set('iter', 1);
model.sol('sol1').feature('s1').feature('i2').feature('mg1').feature('po').feature('sc1').set('scgsmethod', 'lines');
model.sol('sol1').feature('s1').feature('i2').feature('mg1').feature('cs').create('d1', 'Direct');
model.sol('sol1').feature('s1').feature('i2').feature('mg1').feature('cs').feature('d1').set('linsolver', 'pardiso');
model.sol('sol1').feature('s1').feature('fc1').set('linsolver', 'd1');
model.sol('sol1').feature('s1').feature('fc1').set('dtech', 'auto');
model.sol('sol1').feature('s1').feature('fc1').set('maxiter', 50);
model.sol('sol1').feature('s1').feature('fc1').set('minstep', 1.0E-6);
model.sol('sol1').feature('s1').feature.remove('fcDef');
model.sol('sol1').attach('std1');
model.sol('sol1').runAll;

model.result.create('pg1', 'PlotGroup3D');
model.result('pg1').set('data', 'dset1');
model.result('pg1').label('Electrolyte Potential (cp)');
model.result('pg1').create('mslc1', 'Multislice');
model.result('pg1').feature('mslc1').set('expr', {'phil'});
model.result('pg1').create('str1', 'Streamline');
model.result('pg1').feature('str1').set('expr', {'cp.Ilx' 'cp.Ily' 'cp.Ilz'});
model.result('pg1').feature('str1').set('posmethod', 'start');
model.result('pg1').feature('str1').set('pointtype', 'arrow');
model.result('pg1').feature('str1').set('arrowlength', 'logarithmic');
model.result('pg1').feature('str1').set('color', 'gray');
model.result.create('pg2', 'PlotGroup3D');
model.result('pg2').set('data', 'dset1');
model.result('pg2').label('Electrolyte Current Density (cp)');
model.result('pg2').create('str1', 'Streamline');
model.result('pg2').feature('str1').set('expr', {'cp.Ilx' 'cp.Ily' 'cp.Ilz'});
model.result('pg2').feature('str1').set('posmethod', 'start');
model.result('pg2').feature('str1').set('pointtype', 'arrow');
model.result('pg2').feature('str1').set('arrowlength', 'logarithmic');
model.result('pg2').feature('str1').set('color', 'gray');
model.result('pg2').feature('str1').create('col1', 'Color');
model.result('pg2').feature('str1').feature('col1').set('expr', 'root.comp1.cp.IlMag');
model.result.create('pg3', 'PlotGroup3D');
model.result('pg3').set('data', 'dset1');
model.result('pg3').label('Electrode Potential vs. Adjacent Reference (cp)');
model.result('pg3').create('str1', 'Streamline');
model.result('pg3').feature('str1').set('expr', {'cp.Ilx' 'cp.Ily' 'cp.Ilz'});
model.result('pg3').feature('str1').set('posmethod', 'start');
model.result('pg3').feature('str1').set('pointtype', 'arrow');
model.result('pg3').feature('str1').set('arrowlength', 'logarithmic');
model.result('pg3').feature('str1').set('color', 'gray');
model.result('pg3').create('line1', 'Line');
model.result('pg3').feature('line1').set('expr', {'cp.Evsref'});
model.result('pg3').feature('line1').set('linetype', 'tube');
model.result('pg3').feature('line1').set('radiusexpr', 'root.comp1.cp.redge');
model.result('pg3').feature('line1').set('tuberadiusscaleactive', 'on');
model.result('pg3').feature('line1').set('tuberadiusscale', '1');
model.result('pg1').run;
model.result('pg1').run;
model.result('pg1').run;
model.result('pg1').feature('str1').set('number', 100);
model.result('pg1').run;
model.result.create('pg4', 'PlotGroup1D');
model.result('pg4').run;
model.result('pg4').label('Electrode Potential vs. Adjacent Reference');
model.result('pg4').set('axislimits', true);
model.result('pg4').set('xmin', 0);
model.result('pg4').set('xmax', 75000);
model.result('pg4').set('ymin', -0.75);
model.result('pg4').set('ymax', -0.5);
model.result('pg4').create('lngr1', 'LineGraph');
model.result('pg4').feature('lngr1').set('markerpos', 'datapoints');
model.result('pg4').feature('lngr1').set('linewidth', 'preference');
model.result('pg4').feature('lngr1').selection.named('geom1_wp1_edg');
model.result('pg4').feature('lngr1').set('expr', 'cp.Evsref');
model.result('pg4').feature('lngr1').set('descr', 'Electrode potential vs. adjacent reference');
model.result('pg4').feature('lngr1').set('linestyle', 'cycle');
model.result('pg4').feature('lngr1').set('linewidth', 2);
model.result('pg4').feature('lngr1').set('legend', true);
model.result('pg4').feature('lngr1').set('legendmethod', 'manual');
model.result('pg4').feature('lngr1').setIndex('legends', 'Pipeline 1', 0);
model.result('pg4').feature.duplicate('lngr2', 'lngr1');
model.result('pg4').run;
model.result('pg4').feature('lngr2').selection.named('geom1_wp2_edg');
model.result('pg4').feature('lngr2').set('titletype', 'none');
model.result('pg4').feature('lngr2').setIndex('legends', 'Pipeline 2', 0);
model.result('pg4').feature.duplicate('lngr3', 'lngr2');
model.result('pg4').run;
model.result('pg4').feature('lngr3').selection.named('geom1_wp3_edg');
model.result('pg4').feature('lngr3').setIndex('legends', 'Pipeline 3', 0);
model.result('pg4').run;
model.result('pg4').run;
model.result.duplicate('pg5', 'pg4');
model.result('pg5').run;
model.result('pg5').label('Total Current Density');
model.result('pg5').set('ymin', -0.03);
model.result('pg5').set('ymax', 0.01);
model.result('pg5').run;
model.result('pg5').feature('lngr1').set('expr', 'cp.itot');
model.result('pg5').feature('lngr1').set('descr', 'Total interface current density');
model.result('pg5').run;
model.result('pg5').feature('lngr2').set('expr', 'cp.itot');
model.result('pg5').feature('lngr2').set('descr', 'Total interface current density');
model.result('pg5').run;
model.result('pg5').feature('lngr3').set('expr', 'cp.itot');
model.result('pg5').feature('lngr3').set('descr', 'Total interface current density');
model.result('pg5').run;
model.result('pg5').run;
model.result.numerical.create('gev1', 'EvalGlobal');
model.result.numerical('gev1').set('expr', {'comp1.cp.Itotimpr_imprcp1' 'comp1.cp.Itotimpr_imprcp2' 'comp1.cp.Itotimpr_imprcp3' 'comp1.cp.Itotimpr_imprcp4' 'comp1.cp.Itotimpr_imprcp5' 'comp1.cp.Itotimpr_imprcp6' 'comp1.cp.Itotimpr_imprcp7' 'comp1.cp.Itotimpr_imprcp8' 'comp1.cp.Itotimpr_imprcp9'});
model.result.table.create('tbl1', 'Table');
model.result.table('tbl1').comments('Global Evaluation 1');
model.result.numerical('gev1').set('table', 'tbl1');
model.result.numerical('gev1').setResult;
model.result.create('pg6', 'PlotGroup1D');
model.result('pg6').run;
model.result('pg6').label('Impressed Currents');
model.result('pg6').set('xlabelactive', true);
model.result('pg6').set('xlabel', 'Anode number');
model.result('pg6').set('ylabelactive', true);
model.result('pg6').set('ylabel', 'Current (A)');
model.result('pg6').create('tblp1', 'Table');
model.result('pg6').feature('tblp1').set('markerpos', 'datapoints');
model.result('pg6').feature('tblp1').set('linewidth', 'preference');
model.result('pg6').feature('tblp1').set('rowbased', true);
model.result('pg6').feature('tblp1').set('xaxisdata', 'rowindex');
model.result('pg6').feature('tblp1').set('plotcolumninput', 'manual');
model.result('pg6').feature('tblp1').set('plotcolumns', [1]);
model.result('pg6').feature('tblp1').set('linewidth', 2);
model.result('pg6').run;
model.result('pg2').run;
model.result.remove('pg2');
model.result.remove('pg3');
model.result('pg4').run;

model.title('Pipeline Corrosion Protection Using Impressed Current Cathodic Protection');

model.description(['In this example, three parallel pipelines are protected against corrosion by an impressed current cathodic protection (ICCP) system using nine separate anodes.' newline  newline 'The electrode potential and the total interface current density are evaluated along the pipelines to assess the performance of the corrosion protection system.']);

model.mesh.clearMeshes;

model.sol('sol1').clearSolutionData;

model.label('pipeline_corrosion_protection_iccp.mph');

model.modelNode.label('Components');

out = model;
