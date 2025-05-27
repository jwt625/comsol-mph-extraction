function out = model
%
% modular_mixer_geom.m
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

model.param.set('H', '0.0805[m]');
model.param.descr('H', 'Vessel height');
model.param.set('T', 'H');
model.param.descr('T', 'Vessel diameter');
model.param.set('C', '1/3*H');
model.param.descr('C', 'Clearance');
model.param.set('B', '4');
model.param.descr('B', 'Number of baffles');
model.param.set('bw', 'T/10');
model.param.descr('bw', 'Baffle width');
model.param.set('Da', '1/3*T');
model.param.descr('Da', 'Impeller diameter');
model.param.set('shaft_diameter', '1/10*Da');
model.param.descr('shaft_diameter', 'Shaft diameter');
model.param.set('blade_length', 'Da/4');
model.param.descr('blade_length', 'Blade length for Rushton turbine');
model.param.set('blade_width', 'Da/5');
model.param.descr('blade_width', 'Width of impeller blade');

model.geom.load({'part1'}, 'Mixer_Module/Impellers,_Radial/rushton_impeller.mph', {'part1'});
model.geom('geom1').create('pi1', 'PartInstance');
model.geom('geom1').feature('pi1').set('selkeepnoncontr', false);
model.geom('geom1').feature('pi1').set('part', 'part1');
model.geom('geom1').feature('pi1').setEntry('inputexpr', 'd_hu', 'shaft_diameter+Da/20');
model.geom('geom1').feature('pi1').setEntry('inputexpr', 'l_ib', 'blade_length');
model.geom('geom1').feature('pi1').setEntry('inputexpr', 'w_ib', 'blade_width');
model.geom('geom1').feature('pi1').setEntry('inputexpr', 'd_id', 'Da-2*(blade_length*3/4)');
model.geom('geom1').feature('pi1').setEntry('inputexpr', 'd_im', 'Da');
model.geom('geom1').feature('pi1').setEntry('inputexpr', 'hp_im', '-blade_width/2');
model.geom('geom1').feature('pi1').setEntry('inputexpr', 'd_is', 'shaft_diameter');
model.geom('geom1').selection.create('csel1', 'CumulativeSelection');
model.geom('geom1').selection('csel1').label('Impeller Domains');
model.geom('geom1').feature('pi1').setEntry('selkeepobj', 'pi1_csel4', false);
model.geom('geom1').feature('pi1').setEntry('selcontributetoobj', 'pi1_csel4', 'csel1');
model.geom('geom1').feature('pi1').setEntry('selkeepobj', 'pi1_csel6', false);
model.geom('geom1').feature('pi1').setEntry('selcontributetoobj', 'pi1_csel6', 'none');
model.geom('geom1').selection.create('csel2', 'CumulativeSelection');
model.geom('geom1').selection('csel2').label('Rotating Interior Wall');
model.geom('geom1').selection.create('csel3', 'CumulativeSelection');
model.geom('geom1').selection('csel3').label('Rotating Wall');
model.geom('geom1').feature('pi1').setEntry('selkeepbnd', 'pi1_csel1.bnd', false);
model.geom('geom1').feature('pi1').setEntry('selcontributetobnd', 'pi1_csel1.bnd', 'csel2');
model.geom('geom1').feature('pi1').setEntry('selkeepbnd', 'pi1_csel2.bnd', false);
model.geom('geom1').feature('pi1').setEntry('selcontributetobnd', 'pi1_csel2.bnd', 'csel2');
model.geom('geom1').feature('pi1').setEntry('selkeepbnd', 'pi1_csel3.bnd', false);
model.geom('geom1').feature('pi1').setEntry('selcontributetobnd', 'pi1_csel3.bnd', 'csel3');
model.geom('geom1').feature('pi1').setEntry('selkeepbnd', 'pi1_csel10.bnd', false);
model.geom('geom1').feature('pi1').setEntry('selcontributetobnd', 'pi1_csel10.bnd', 'none');
model.geom('geom1').feature('pi1').setEntry('selkeepbnd', 'pi1_csel7.bnd', false);
model.geom('geom1').feature('pi1').setEntry('selcontributetobnd', 'pi1_csel7.bnd', 'none');
model.geom('geom1').feature('pi1').setEntry('selkeepbnd', 'pi1_csel8.bnd', false);
model.geom('geom1').feature('pi1').setEntry('selcontributetobnd', 'pi1_csel8.bnd', 'none');
model.geom('geom1').feature('pi1').setEntry('selkeepbnd', 'pi1_csel9.bnd', false);
model.geom('geom1').feature('pi1').setEntry('selcontributetobnd', 'pi1_csel9.bnd', 'none');
model.geom('geom1').selection.create('csel4', 'CumulativeSelection');
model.geom('geom1').selection('csel4').label('Remove Edges');
model.geom('geom1').feature('pi1').setEntry('selkeepedg', 'pi1_sel1', false);
model.geom('geom1').feature('pi1').setEntry('selcontributetoedg', 'pi1_sel1', 'csel4');
model.geom('geom1').feature('pi1').set('selkeepnoncontr', true);
model.geom.load({'part2'}, 'Mixer_Module/Shafts/impeller_shaft.mph', {'part1'});
model.geom('geom1').run('pi1');
model.geom('geom1').create('pi2', 'PartInstance');
model.geom('geom1').feature('pi2').set('selkeepnoncontr', false);
model.geom('geom1').feature('pi2').set('part', 'part2');
model.geom('geom1').feature('pi2').setEntry('inputexpr', 'hp_im', '-blade_width/2');
model.geom('geom1').feature('pi2').setEntry('inputexpr', 'd_is', 'shaft_diameter');
model.geom('geom1').feature('pi2').setEntry('inputexpr', 'l_is', 'H-C+blade_width');
model.geom('geom1').feature('pi2').setEntry('selkeepobj', 'pi2_csel1', false);
model.geom('geom1').feature('pi2').setEntry('selcontributetoobj', 'pi2_csel1', 'csel1');
model.geom('geom1').feature('pi2').setEntry('selkeepbnd', 'pi2_cylsel1', false);
model.geom('geom1').feature('pi2').setEntry('selcontributetobnd', 'pi2_cylsel1', 'none');
model.geom('geom1').feature('pi2').setEntry('selkeepbnd', 'pi2_csel1.bnd', false);
model.geom('geom1').feature('pi2').setEntry('selcontributetobnd', 'pi2_csel1.bnd', 'csel3');
model.geom('geom1').feature('pi2').setEntry('selkeepedg', 'pi2_sel1', false);
model.geom('geom1').feature('pi2').setEntry('selcontributetoedg', 'pi2_sel1', 'csel4');
model.geom('geom1').feature('pi2').setEntry('selkeepedg', 'pi2_csel1.edg', false);
model.geom('geom1').feature('pi2').setEntry('selcontributetoedg', 'pi2_csel1.edg', 'none');
model.geom('geom1').feature('pi2').set('selkeepnoncontr', true);
model.geom('geom1').run('pi2');
model.geom('geom1').create('uni1', 'Union');
model.geom('geom1').feature('uni1').selection('input').set({'pi1' 'pi2'});
model.geom('geom1').feature('uni1').set('repairtoltype', 'relative');
model.geom.load({'part3'}, 'Mixer_Module/Tanks/flat_bottom_tank.mph', {'part1'});
model.geom('geom1').run('uni1');
model.geom('geom1').create('pi3', 'PartInstance');
model.geom('geom1').feature('pi3').set('selkeepnoncontr', false);
model.geom('geom1').feature('pi3').set('part', 'part3');
model.geom('geom1').feature('pi3').set('rot', 90);
model.geom('geom1').feature('pi3').setEntry('inputexpr', 'n_ba', 'B');
model.geom('geom1').feature('pi3').setEntry('inputexpr', 'w_ba', 'bw');
model.geom('geom1').feature('pi3').setEntry('inputexpr', 'd_im', 'Da');
model.geom('geom1').feature('pi3').setEntry('inputexpr', 'd_ta', 'T');
model.geom('geom1').feature('pi3').setEntry('inputexpr', 'h_ta', 'H');
model.geom('geom1').feature('pi3').setEntry('inputexpr', 'hp_ta', '-C');
model.geom('geom1').feature('pi3').setEntry('inputexpr', 'rf_ta', 0);
model.geom('geom1').selection.create('csel5', 'CumulativeSelection');
model.geom('geom1').selection('csel5').label('Symmetry');
model.geom('geom1').selection.create('csel6', 'CumulativeSelection');
model.geom('geom1').selection('csel6').label('Interior Wall');
model.geom('geom1').selection.create('csel7', 'CumulativeSelection');
model.geom('geom1').selection('csel7').label('View suppression');
model.geom('geom1').feature('pi3').setEntry('selkeepbnd', 'pi3_unisel2', false);
model.geom('geom1').feature('pi3').setEntry('selcontributetobnd', 'pi3_unisel2', 'none');
model.geom('geom1').feature('pi3').setEntry('selkeepbnd', 'pi3_csel1.bnd', false);
model.geom('geom1').feature('pi3').setEntry('selcontributetobnd', 'pi3_csel1.bnd', 'csel5');
model.geom('geom1').feature('pi3').setEntry('selkeepbnd', 'pi3_csel2.bnd', false);
model.geom('geom1').feature('pi3').setEntry('selcontributetobnd', 'pi3_csel2.bnd', 'none');
model.geom('geom1').feature('pi3').setEntry('selkeepbnd', 'pi3_csel4.bnd', false);
model.geom('geom1').feature('pi3').setEntry('selcontributetobnd', 'pi3_csel4.bnd', 'csel6');
model.geom('geom1').feature('pi3').setEntry('selkeepbnd', 'pi3_csel5.bnd', false);
model.geom('geom1').feature('pi3').setEntry('selcontributetobnd', 'pi3_csel5.bnd', 'none');
model.geom('geom1').feature('pi3').setEntry('selkeepbnd', 'pi3_csel7.bnd', false);
model.geom('geom1').feature('pi3').setEntry('selcontributetobnd', 'pi3_csel7.bnd', 'csel7');
model.geom('geom1').feature('pi3').set('selkeepnoncontr', true);
model.geom('geom1').run('pi3');
model.geom('geom1').create('dif1', 'Difference');
model.geom('geom1').feature('dif1').label('Fluid Domain');
model.geom('geom1').feature('dif1').selection('input').named('pi3_csel5');
model.geom('geom1').feature('dif1').selection('input2').named('csel1');
model.geom('geom1').feature('dif1').set('repairtoltype', 'relative');
model.geom('geom1').feature('dif1').set('selresult', true);
model.geom('geom1').feature('dif1').set('selresultshow', 'all');
model.geom('geom1').run('dif1');
model.geom('geom1').create('sel1', 'ExplicitSelection');
model.geom('geom1').feature('sel1').label('Flat Pressure Point');
model.geom('geom1').feature('sel1').selection('selection').init(0);
model.geom('geom1').feature('sel1').selection('selection').set('dif1', 34);
model.geom('geom1').selection.create('csel8', 'CumulativeSelection');
model.geom('geom1').selection('csel8').label('Pressure Point Constraint');
model.geom('geom1').feature('sel1').set('contributeto', 'csel8');
model.geom('geom1').run('sel1');
model.geom('geom1').create('sel2', 'ExplicitSelection');
model.geom('geom1').feature('sel2').label('Edges to Remove');
model.geom('geom1').feature('sel2').selection('selection').init(1);
model.geom('geom1').feature('sel2').selection('selection').set('dif1', [9 61 78 79]);

model.view('view1').set('renderwireframe', false);

model.geom('geom1').feature('sel2').set('contributeto', 'csel4');
model.geom('geom1').run('sel2');
model.geom('geom1').create('sel3', 'ExplicitSelection');
model.geom('geom1').feature('sel3').selection('selection').set('dif1', 2);
model.geom('geom1').feature('sel3').label('Rotating Fluid Domain');
model.geom('geom1').run('fin');
model.geom('geom1').create('ige1', 'IgnoreEdges');
model.geom('geom1').feature('ige1').selection('input').named('csel4');
model.geom('geom1').feature('ige1').set('ignorevtx', false);
model.geom('geom1').run('ige1');

model.title(['Laminar Modular Mixer ' native2unicode(hex2dec({'20' '14'}), 'unicode') ' Template File']);

model.description('This example is a template MPH-file used by the laminar case of the Modular Mixer models. The geometry is a combination of a Rushton impeller and a flat bottom tank. The geometry subsequences to build the impeller and vessel are imported from the Part Libraries.');

model.label('modular_mixer_geom.mph');

model.modelNode.label('Components');

out = model;
