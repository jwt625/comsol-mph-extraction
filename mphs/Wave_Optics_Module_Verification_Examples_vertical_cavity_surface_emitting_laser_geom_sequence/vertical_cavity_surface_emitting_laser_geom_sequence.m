function out = model
%
% vertical_cavity_surface_emitting_laser_geom_sequence.m
%
% Model exported on May 26 2025, 21:34 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/Wave_Optics_Module/Verification_Examples');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 2);
model.geom('geom1').model('comp1');
model.geom('geom1').axisymmetric(true);

model.mesh.create('mesh1', 'geom1');

model.param.label('Geometry Parameters');

% To import content from file, use:
% model.param.loadFile('FILENAME');
model.param.set('t_GaAs_DBR', '69.49[nm]', 'Thickness, GaAs DBR layer');
model.param.set('t_AlGaAs_DBR', '79.63[nm]', 'Thickness, AlGaAs DBR layer');
model.param.set('t_GaAs_cavity', '136.49[nm]', 'Thickness, GaAs cavity layer');
model.param.set('t_QW', '5[nm]', 'Thickness, quantum well');
model.param.set('t_AlGaAs_oxide_window_bottom_layer', 'if(pos_oxide==1,63.71[nm],if(pos_oxide==2,47.78[nm],if(pos_oxide==3,31.85[nm],if(pos_oxide==4,15.93[nm],0[nm]))))', 'Thickness, AlGaAs, oxide window, bottom layer');
model.param.set('t_oxide', '15.93[nm]', 'Thickness, AlOx');
model.param.set('t_AlGaAs_oxide_window_second_layer', '63.71[nm]-t_AlGaAs_oxide_window_bottom_layer', 'Thickness, AlGaAs, oxide window, second layer');
model.param.set('d_oxide', '8[um]', 'Diameter, clear oxide window');
model.param.set('t_GaAs_substrate', '1[um]', 'Thickness, GaAs, substrate');
model.param.set('d_outer', '12[um]', 'Diameter, outer');
model.param.set('N_bottom_DBR', '29', 'Number of pairs, bottom DBR');
model.param.set('N_top_DBR', '24', 'Number of pairs, top DBR');
model.param.set('t_DBR_pair', 't_AlGaAs_DBR+t_GaAs_DBR', 'Thickness, DBR pair');
model.param.set('t_bottom_DBR', 'N_bottom_DBR*t_DBR_pair+t_AlGaAs_DBR', 'Thickness, bottom DBR');
model.param.set('t_cavity', '2*t_GaAs_cavity+t_QW', 'Thickness, cavity');
model.param.set('t_oxide_window', 't_AlGaAs_oxide_window_bottom_layer+t_oxide+t_AlGaAs_oxide_window_second_layer+t_GaAs_DBR', 'Thickness, oxide window');
model.param.set('t_top_DBR', 'N_top_DBR*t_DBR_pair', 'Thickness, top DBR');
model.param.set('pos_oxide', '3', 'Oxide position');

model.geom.create('part1', 'Part', 2);
model.geom('part1').label('DBR Pair');

% To import content from file, use:
% model.geom('part1').inputParam.loadFile('FILENAME');
model.geom('part1').inputParam.set('d1', '69.49[nm]', 'Thickness, bottom layer');
model.geom('part1').inputParam.set('d2', '79.53[nm]', 'Thickness, top layer');
model.geom('part1').inputParam.set('w', '5[um]', 'Width');
model.geom('part1').inputParam.set('pos_x', '0[um]', 'Horizontal position');
model.geom('part1').inputParam.set('pos_y', '0[um]', 'Vertical position');
model.geom('part1').create('r1', 'Rectangle');
model.geom('part1').feature('r1').label('Bottom Layer');
model.geom('part1').feature('r1').set('size', {'w' 'd1'});
model.geom('part1').feature('r1').set('pos', {'pos_x' 'pos_y'});
model.geom('part1').feature('r1').set('selresult', true);
model.geom('part1').feature('r1').set('color', '8');
model.geom('part1').feature.duplicate('r2', 'r1');
model.geom('part1').feature('r2').label('Top Layer');
model.geom('part1').feature('r2').set('size', {'w' 'd2'});
model.geom('part1').feature('r2').set('pos', {'pos_x' 'pos_y+d1'});
model.geom('part1').feature('r2').set('color', '18');
model.geom('part1').run('r2');
model.geom('geom1').create('pi1', 'PartInstance');
model.geom('geom1').feature('pi1').set('selkeepnoncontr', false);
model.geom('geom1').feature('pi1').set('part', 'part1');
model.geom('geom1').feature('pi1').setEntry('inputexpr', 'd1', 't_AlGaAs_DBR');
model.geom('geom1').feature('pi1').setEntry('inputexpr', 'd2', 't_GaAs_DBR');
model.geom('geom1').feature('pi1').setEntry('inputexpr', 'w', 'd_outer/2');
model.geom('geom1').selection.create('csel1', 'CumulativeSelection');
model.geom('geom1').selection('csel1').label('AlGaAs Layers');
model.geom('geom1').feature('pi1').setEntry('selcontributetodom', 'pi1_r1.dom', 'csel1');
model.geom('geom1').selection.create('csel2', 'CumulativeSelection');
model.geom('geom1').selection('csel2').label('GaAs Layers');
model.geom('geom1').feature('pi1').setEntry('selcontributetodom', 'pi1_r2.dom', 'csel2');
model.geom('geom1').run('pi1');
model.geom('geom1').create('arr1', 'Array');
model.geom('geom1').feature('arr1').label('Bottom DBR');
model.geom('geom1').feature('arr1').selection('input').set({'pi1'});
model.geom('geom1').feature('arr1').set('type', 'linear');
model.geom('geom1').feature('arr1').set('linearsize', 'N_bottom_DBR');
model.geom('geom1').feature('arr1').set('displ', {'0' 't_DBR_pair'});
model.geom('geom1').runPre('fin');
model.geom('geom1').create('r1', 'Rectangle');
model.geom('geom1').feature('r1').label('Top Layer in Bottom DBR');
model.geom('geom1').feature('r1').set('size', {'d_outer/2' 't_AlGaAs_DBR'});
model.geom('geom1').feature('r1').set('pos', {'0' 'N_bottom_DBR*t_DBR_pair'});
model.geom('geom1').feature('r1').set('contributeto', 'csel1');
model.geom('geom1').runPre('fin');
model.geom('geom1').feature.duplicate('r2', 'r1');
model.geom('geom1').feature('r2').label('Bottom GaAs Layer in Lambda Cavity');
model.geom('geom1').feature('r2').set('size', {'d_outer/2' 't_GaAs_cavity'});
model.geom('geom1').feature('r2').set('pos', {'0' 't_bottom_DBR'});
model.geom('geom1').feature('r2').set('contributeto', 'csel2');
model.geom('geom1').runPre('fin');
model.geom('geom1').feature.duplicate('r3', 'r2');
model.geom('geom1').feature('r3').label('QW Gain Domain in Lambda Cavity');
model.geom('geom1').feature('r3').setIndex('size', 'd_oxide/2', 0);
model.geom('geom1').feature('r3').set('size', {'d_oxide/2' 't_QW'});
model.geom('geom1').feature('r3').set('pos', {'0' 't_bottom_DBR+t_GaAs_cavity'});
model.geom('geom1').selection.create('csel3', 'CumulativeSelection');
model.geom('geom1').selection('csel3').label('QW Gain Domain');
model.geom('geom1').feature('r3').set('contributeto', 'csel3');
model.geom('geom1').runPre('fin');
model.geom('geom1').feature.duplicate('r4', 'r3');
model.geom('geom1').feature('r4').label('QW Loss Domain in Lambda Cavity');
model.geom('geom1').feature('r4').set('size', {'(d_outer-d_oxide)/2' 't_QW'});
model.geom('geom1').feature('r4').setIndex('pos', 'd_oxide/2', 0);
model.geom('geom1').selection.create('csel4', 'CumulativeSelection');
model.geom('geom1').selection('csel4').label('QW Loss Domain');
model.geom('geom1').feature('r4').set('contributeto', 'csel4');
model.geom('geom1').runPre('fin');
model.geom('geom1').feature.duplicate('r5', 'r2');
model.geom('geom1').feature('r5').label('Top GaAs Layer in Lambda Cavity');
model.geom('geom1').feature('r5').set('pos', {'0' 't_bottom_DBR+t_GaAs_cavity+t_QW'});
model.geom('geom1').runPre('fin');
model.geom('geom1').create('if1', 'If');
model.geom('geom1').feature.createAfter('endif1', 'EndIf', 'if1');
model.geom('geom1').feature('if1').label('If Bottom AlGaAs Layer in Oxide Window is Finite');
model.geom('geom1').feature('if1').set('condition', 't_AlGaAs_oxide_window_bottom_layer>0');
model.geom('geom1').feature.duplicate('r6', 'r1');
model.geom('geom1').feature('r6').label('Bottom AlGaAs Layer in Oxide Window');
model.geom('geom1').feature('r6').set('size', {'d_outer/2' 't_AlGaAs_oxide_window_bottom_layer'});
model.geom('geom1').feature('r6').set('pos', {'0' 't_bottom_DBR+t_cavity'});
model.geom('geom1').feature('endif1').label('End If Bottom AlGaAs Layer in Oxide Window is Finite');
model.geom('geom1').runPre('fin');
model.geom('geom1').feature.duplicate('r7', 'r6');
model.geom('geom1').feature('r7').label('AlAs Domain in Oxide Window');
model.geom('geom1').feature('r7').setIndex('size', 'd_oxide/2', 0);
model.geom('geom1').feature('r7').set('size', {'d_oxide/2' 't_oxide'});
model.geom('geom1').feature('r7').set('pos', {'0' 't_bottom_DBR+t_cavity+t_AlGaAs_oxide_window_bottom_layer'});
model.geom('geom1').selection.create('csel5', 'CumulativeSelection');
model.geom('geom1').selection('csel5').label('AlAs Domain');
model.geom('geom1').feature('r7').set('contributeto', 'csel5');
model.geom('geom1').runPre('fin');
model.geom('geom1').feature.duplicate('r8', 'r7');
model.geom('geom1').feature('r8').label('AlOx Domain in Oxide Window');
model.geom('geom1').feature('r8').set('size', {'(d_outer-d_oxide)/2' 't_oxide'});
model.geom('geom1').feature('r8').setIndex('pos', 'd_oxide/2', 0);
model.geom('geom1').selection.create('csel6', 'CumulativeSelection');
model.geom('geom1').selection('csel6').label('AlOx Domain');
model.geom('geom1').feature('r8').set('contributeto', 'csel6');
model.geom('geom1').runPre('fin');
model.geom('geom1').feature.duplicate('if2', 'if1');
model.geom('geom1').feature.duplicate('r9', 'r6');
model.geom('geom1').feature.duplicate('endif2', 'endif1');
model.geom('geom1').feature('if2').label('If Second AlGaAs Layer in Oxide Window is Finite');
model.geom('geom1').feature('if2').set('condition', 't_AlGaAs_oxide_window_second_layer>0');
model.geom('geom1').feature('r9').label('Second AlGaAs Layer in Oxide Window');
model.geom('geom1').feature('r9').set('size', {'d_outer/2' 't_AlGaAs_oxide_window_second_layer'});
model.geom('geom1').feature('r9').set('pos', {'0' 't_bottom_DBR+t_cavity+t_AlGaAs_oxide_window_bottom_layer+t_oxide'});
model.geom('geom1').feature('endif2').label('End If Second AlGaAs Layer in Oxide Window is Finite');
model.geom('geom1').runPre('fin');
model.geom('geom1').feature.duplicate('r10', 'r2');
model.geom('geom1').feature('r10').label('Top GaAs Layer in Oxide Window');
model.geom('geom1').feature('r10').set('size', {'d_outer/2' 't_GaAs_DBR'});
model.geom('geom1').feature('r10').set('pos', {'0' 't_bottom_DBR+t_cavity+t_AlGaAs_oxide_window_bottom_layer+t_oxide+t_AlGaAs_oxide_window_second_layer'});
model.geom('geom1').runPre('fin');
model.geom('geom1').feature.duplicate('pi2', 'pi1');
model.geom('geom1').feature('pi1').set('selcontributetoobj', {});
model.geom('geom1').feature('pi1').set('selkeepobj', {});
model.geom('geom1').feature('pi1').set('selcontributetopnt', {});
model.geom('geom1').feature('pi1').set('selkeeppnt', {});
model.geom('geom1').feature('pi1').set('selshowpnt', {});
model.geom('geom1').feature('pi1').set('selcontributetobnd', {});
model.geom('geom1').feature('pi1').set('selkeepbnd', {});
model.geom('geom1').feature('pi1').set('selshowbnd', {});
model.geom('geom1').feature('pi1').set('selcontributetodom', {'csel1' 'csel2'});
model.geom('geom1').feature('pi1').set('selkeepdom', {'off' 'off'});
model.geom('geom1').feature('pi1').set('selshowdom', {'on' 'on'});
model.geom('geom1').feature('pi2').setEntry('inputexpr', 'pos_y', 't_bottom_DBR+t_cavity+t_oxide_window');
model.geom('geom1').run('pi2');
model.geom('geom1').create('arr2', 'Array');
model.geom('geom1').feature('arr2').label('Top DBR');
model.geom('geom1').feature('arr2').selection('input').set({'pi2'});
model.geom('geom1').feature('arr2').set('type', 'linear');
model.geom('geom1').feature('arr2').set('linearsize', 'N_top_DBR');
model.geom('geom1').feature('arr2').set('displ', {'0' 't_DBR_pair'});
model.geom('geom1').runPre('fin');

model.title([]);

model.description('');

model.label('vertical_cavity_surface_emitting_laser_geom_sequence.mph');

model.modelNode.label('Components');

out = model;
