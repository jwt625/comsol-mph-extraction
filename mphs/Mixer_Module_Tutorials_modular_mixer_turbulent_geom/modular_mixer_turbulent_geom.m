function out = model
%
% modular_mixer_turbulent_geom.m
%
% Model exported on May 26 2025, 21:30 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/Mixer_Module/Tutorials');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 3);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.param.set('H', '0.5[m]');
model.param.descr('H', 'Vessel height');
model.param.set('T', 'H');
model.param.descr('T', 'Vessel diameter');
model.param.set('alpha', '45[deg]');
model.param.descr('alpha', 'Pitch angle');
model.param.set('N_blades', '4');
model.param.descr('N_blades', 'Number of blades for pitched blade impeller');
model.param.set('B', '4');
model.param.descr('B', 'Number of baffles');
model.param.set('Da', '1/2*T');
model.param.descr('Da', 'Impeller diameter');
model.param.set('blade_width', 'Da/5');
model.param.descr('blade_width', 'Width of impeller blade');
model.param.set('bw', 'T/12');
model.param.descr('bw', 'Baffle width');
model.param.set('C', '1/4*H');
model.param.descr('C', 'Clearance');
model.param.set('shaft_diameter', '1/10*Da');
model.param.descr('shaft_diameter', 'Shaft diameter');

model.geom.load({'part1'}, 'Mixer_Module/Impellers,_Axial/pitched_blade_impeller.mph', {'part1'});
model.geom('geom1').create('pi1', 'PartInstance');
model.geom('geom1').feature('pi1').set('selkeepnoncontr', false);
model.geom('geom1').feature('pi1').set('part', 'part1');
model.geom('geom1').feature('pi1').setEntry('inputexpr', 'd_hu', 'blade_width*abs(cos(alpha))*1.1');
model.geom('geom1').feature('pi1').setEntry('inputexpr', 'ap_ib', 'alpha');
model.geom('geom1').feature('pi1').setEntry('inputexpr', 'd_a_ib', 'blade_width*cos(alpha)*0.95');
model.geom('geom1').feature('pi1').setEntry('inputexpr', 'lr_cl_ib', '0.3[1]');
model.geom('geom1').feature('pi1').setEntry('inputexpr', 'lr_cu_ib', '0.3[1]');
model.geom('geom1').feature('pi1').setEntry('inputexpr', 'n_ib', 'N_blades');
model.geom('geom1').feature('pi1').setEntry('inputexpr', 'rf_ib', '0[m]');
model.geom('geom1').feature('pi1').setEntry('inputexpr', 'w_ib', 'blade_width');
model.geom('geom1').feature('pi1').setEntry('inputexpr', 'w_a_ib', '0[m]');
model.geom('geom1').feature('pi1').setEntry('inputexpr', 'w_o_ib', 'blade_width');
model.geom('geom1').feature('pi1').setEntry('inputexpr', 'w_cil_ib', 'blade_width*0.25');
model.geom('geom1').feature('pi1').setEntry('inputexpr', 'w_ciu_ib', 'blade_width*0.25');
model.geom('geom1').feature('pi1').setEntry('inputexpr', 'w_col_ib', '0[m]');
model.geom('geom1').feature('pi1').setEntry('inputexpr', 'd_im', 'Da');
model.geom('geom1').feature('pi1').setEntry('inputexpr', 'hp_im', '-blade_width*sin(alpha)/2');
model.geom('geom1').feature('pi1').setEntry('inputexpr', 'd_is', 'shaft_diameter');
model.geom('geom1').feature('pi1').setEntry('inputexpr', 'pa_cs_im', 1);
model.geom('geom1').feature('pi1').setEntry('inputexpr', 'd_cs_im', 'Da*1.2');
model.geom('geom1').selection.create('csel1', 'CumulativeSelection');
model.geom('geom1').selection('csel1').label('Impeller Domains');
model.geom('geom1').selection.create('csel2', 'CumulativeSelection');
model.geom('geom1').selection('csel2').label('Control Domain');
model.geom('geom1').feature('pi1').setEntry('selkeepobj', 'pi1_csel3', false);
model.geom('geom1').feature('pi1').setEntry('selcontributetoobj', 'pi1_csel3', 'csel1');
model.geom('geom1').feature('pi1').setEntry('selkeepobj', 'pi1_csel8', false);
model.geom('geom1').feature('pi1').setEntry('selcontributetoobj', 'pi1_csel8', 'csel2');
model.geom('geom1').selection.create('csel3', 'CumulativeSelection');
model.geom('geom1').selection('csel3').label('Rotating Interior Wall');
model.geom('geom1').selection.create('csel4', 'CumulativeSelection');
model.geom('geom1').selection('csel4').label('Rotating Wall');
model.geom('geom1').selection.create('csel5', 'CumulativeSelection');
model.geom('geom1').selection('csel5').label('View Suppression');
model.geom('geom1').selection.create('csel6', 'CumulativeSelection');
model.geom('geom1').selection('csel6').label('Mesh');
model.geom('geom1').feature('pi1').setEntry('selkeepbnd', 'pi1_csel1.bnd', false);
model.geom('geom1').feature('pi1').setEntry('selcontributetobnd', 'pi1_csel1.bnd', 'csel3');
model.geom('geom1').feature('pi1').setEntry('selkeepbnd', 'pi1_csel2.bnd', false);
model.geom('geom1').feature('pi1').setEntry('selcontributetobnd', 'pi1_csel2.bnd', 'csel4');
model.geom('geom1').feature('pi1').setEntry('selkeepbnd', 'pi1_csel12.bnd', false);
model.geom('geom1').feature('pi1').setEntry('selcontributetobnd', 'pi1_csel12.bnd', 'csel6');
model.geom('geom1').feature('pi1').setEntry('selkeepbnd', 'pi1_csel13.bnd', false);
model.geom('geom1').feature('pi1').setEntry('selcontributetobnd', 'pi1_csel13.bnd', 'csel6');
model.geom('geom1').feature('pi1').setEntry('selkeepbnd', 'pi1_csel14.bnd', false);
model.geom('geom1').feature('pi1').setEntry('selcontributetobnd', 'pi1_csel14.bnd', 'csel6');
model.geom('geom1').feature('pi1').setEntry('selkeepbnd', 'pi1_csel15.bnd', false);
model.geom('geom1').feature('pi1').setEntry('selcontributetobnd', 'pi1_csel15.bnd', 'csel5');
model.geom('geom1').selection.create('csel7', 'CumulativeSelection');
model.geom('geom1').selection('csel7').label('Remove Edges');
model.geom('geom1').feature('pi1').setEntry('selkeepedg', 'pi1_sel1', false);
model.geom('geom1').feature('pi1').setEntry('selcontributetoedg', 'pi1_sel1', 'csel7');
model.geom('geom1').feature('pi1').set('selkeepnoncontr', true);
model.geom.load({'part2'}, 'Mixer_Module/Shafts/impeller_shaft.mph', {'part1'});
model.geom('geom1').run('pi1');
model.geom('geom1').create('pi2', 'PartInstance');
model.geom('geom1').feature('pi2').set('selkeepnoncontr', false);
model.geom('geom1').feature('pi2').set('part', 'part2');
model.geom('geom1').feature('pi2').setEntry('inputexpr', 'hp_im', '-blade_width*sin(alpha)/2');
model.geom('geom1').feature('pi2').setEntry('inputexpr', 'd_is', 'shaft_diameter');
model.geom('geom1').feature('pi2').setEntry('inputexpr', 'l_is', 'H-C');
model.geom('geom1').feature('pi2').setEntry('selkeepobj', 'pi2_csel1', false);
model.geom('geom1').feature('pi2').setEntry('selcontributetoobj', 'pi2_csel1', 'csel1');
model.geom('geom1').feature('pi2').setEntry('selkeepbnd', 'pi2_cylsel1', false);
model.geom('geom1').feature('pi2').setEntry('selcontributetobnd', 'pi2_cylsel1', 'none');
model.geom('geom1').feature('pi2').setEntry('selkeepbnd', 'pi2_csel1.bnd', false);
model.geom('geom1').feature('pi2').setEntry('selcontributetobnd', 'pi2_csel1.bnd', 'csel4');
model.geom('geom1').feature('pi2').setEntry('selkeepedg', 'pi2_sel1', false);
model.geom('geom1').feature('pi2').setEntry('selcontributetoedg', 'pi2_sel1', 'csel7');
model.geom('geom1').feature('pi2').setEntry('selkeepedg', 'pi2_csel1.edg', false);
model.geom('geom1').feature('pi2').setEntry('selcontributetoedg', 'pi2_csel1.edg', 'none');
model.geom('geom1').feature('pi2').set('selkeepnoncontr', true);
model.geom.load({'part3'}, 'Mixer_Module/Tanks/dished_bottom_tank.mph', {'part1'});
model.geom('geom1').run('pi2');
model.geom('geom1').create('pi3', 'PartInstance');
model.geom('geom1').feature('pi3').set('selkeepnoncontr', false);
model.geom('geom1').feature('pi3').set('part', 'part3');
model.geom('geom1').feature('pi3').setEntry('inputexpr', 'n_ba', 'B');
model.geom('geom1').feature('pi3').setEntry('inputexpr', 'w_ba', 'bw');
model.geom('geom1').feature('pi3').setEntry('inputexpr', 'd_im', 'Da');
model.geom('geom1').feature('pi3').setEntry('inputexpr', 'd_ta', 'T');
model.geom('geom1').feature('pi3').setEntry('inputexpr', 'h_ta', 'H');
model.geom('geom1').feature('pi3').setEntry('inputexpr', 'hp_ta', '-C');
model.geom('geom1').feature('pi3').setEntry('inputexpr', 'rm_b_ta', 'T/10');
model.geom('geom1').feature('pi3').setEntry('inputexpr', 'bo_rd_ta', 'T*2');
model.geom('geom1').selection.create('csel8', 'CumulativeSelection');
model.geom('geom1').selection('csel8').label('Interior Wall');
model.geom('geom1').selection.create('csel9', 'CumulativeSelection');
model.geom('geom1').selection('csel9').label('Symmetry');
model.geom('geom1').feature('pi3').setEntry('selkeepobj', 'pi3_csel7', false);
model.geom('geom1').feature('pi3').setEntry('selcontributetoobj', 'pi3_csel7', 'none');
model.geom('geom1').feature('pi3').setEntry('selkeepobj', 'pi3_csel1', false);
model.geom('geom1').feature('pi3').setEntry('selcontributetoobj', 'pi3_csel1', 'csel2');
model.geom('geom1').feature('pi3').setEntry('selkeepbnd', 'pi3_sel5', false);
model.geom('geom1').feature('pi3').setEntry('selcontributetobnd', 'pi3_sel5', 'csel5');
model.geom('geom1').feature('pi3').setEntry('selkeepbnd', 'pi3_unisel2', false);
model.geom('geom1').feature('pi3').setEntry('selcontributetobnd', 'pi3_unisel2', 'none');
model.geom('geom1').feature('pi3').setEntry('selkeepbnd', 'pi3_csel7.bnd', false);
model.geom('geom1').feature('pi3').setEntry('selcontributetobnd', 'pi3_csel7.bnd', 'csel8');
model.geom('geom1').feature('pi3').setEntry('selkeepbnd', 'pi3_csel1.bnd', false);
model.geom('geom1').feature('pi3').setEntry('selcontributetobnd', 'pi3_csel1.bnd', 'none');
model.geom('geom1').feature('pi3').setEntry('selkeepbnd', 'pi3_csel2.bnd', false);
model.geom('geom1').feature('pi3').setEntry('selcontributetobnd', 'pi3_csel2.bnd', 'csel9');
model.geom('geom1').feature('pi3').setEntry('selkeepbnd', 'pi3_csel3.bnd', false);
model.geom('geom1').feature('pi3').setEntry('selcontributetobnd', 'pi3_csel3.bnd', 'none');
model.geom('geom1').feature('pi3').set('selkeepnoncontr', true);
model.geom('geom1').run('pi3');
model.geom('geom1').create('dif1', 'Difference');
model.geom('geom1').feature('dif1').label('Rotating Fluid Domain');
model.geom('geom1').feature('dif1').selection('input').named('csel2');
model.geom('geom1').feature('dif1').selection('input2').named('csel1');
model.geom('geom1').feature('dif1').set('repairtoltype', 'relative');
model.geom('geom1').feature('dif1').set('selresult', true);
model.geom('geom1').feature('dif1').set('selresultshow', 'all');
model.geom('geom1').run('dif1');
model.geom('geom1').create('blk1', 'Block');
model.geom('geom1').feature('blk1').set('pos', [0.2 -0.2 -0.5]);
model.geom('geom1').feature('blk1').set('rot', 45);
model.geom('geom1').feature.duplicate('blk2', 'blk1');
model.geom('geom1').feature('blk2').set('pos', [-0.2 -0.2 -0.5]);
model.geom('geom1').run('blk2');
model.geom('geom1').create('dif2', 'Difference');
model.geom('geom1').feature('dif2').selection('input').set({'dif1'});
model.geom('geom1').feature('dif2').selection('input2').set({'blk1' 'blk2'});
model.geom('geom1').run('dif2');
model.geom('geom1').create('sel1', 'ExplicitSelection');
model.geom('geom1').feature('sel1').label('Flat Pressure Point');
model.geom('geom1').feature('sel1').selection('selection').init(0);
model.geom('geom1').feature('sel1').selection('selection').set('dif2', 19);
model.geom('geom1').selection.create('csel10', 'CumulativeSelection');
model.geom('geom1').selection('csel10').label('Pressure Point Constraint');
model.geom('geom1').feature('sel1').set('contributeto', 'csel10');
model.geom('geom1').run('fin');
model.geom('geom1').create('ige1', 'IgnoreEdges');
model.geom('geom1').feature('ige1').selection('input').named('csel7');
model.geom('geom1').run('ige1');
model.geom('geom1').create('mcf1', 'MeshControlFaces');
model.geom('geom1').feature('mcf1').selection('input').named('csel6');
model.geom('geom1').run('mcf1');

model.title(['Turbulent Modular Mixer ' native2unicode(hex2dec({'20' '14'}), 'unicode') ' Template File']);

model.description('This example is a template MPH-file used by the turbulent cases (k-epsilon and k-omega turbulence models) of the Modular Mixer models. The geometry is a combination of a pitched blade impeller and a dished bottom tank. The geometry subsequences to build the impeller and vessel are imported from the Part Libraries.');

model.label('modular_mixer_turbulent_geom.mph');

model.modelNode.label('Components');

out = model;
