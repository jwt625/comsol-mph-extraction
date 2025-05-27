function out = model
%
% pm_motor_2d_campbell_diagram_geom_sequence.m
%
% Model exported on May 26 2025, 21:24 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/ACDC_Module/Devices,_Motors_and_Generators');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 2);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.geom('geom1').lengthUnit('mm');

model.param.set('Np', '10');
model.param.descr('Np', 'Number of poles');
model.param.set('Ns', '12');
model.param.descr('Ns', 'Number of slots');

model.geom.load({'part1'}, 'ACDC_Module\Rotating_Machinery_2D\Rotors\Internal\surface_mounted_magnet_internal_rotor_2d.mph', {'part1'});
model.geom('geom1').create('pi1', 'PartInstance');
model.geom('geom1').feature('pi1').set('selkeepnoncontr', false);
model.geom('geom1').feature('pi1').set('part', 'part1');
model.geom('geom1').feature('pi1').setEntry('inputexpr', 'number_of_poles', 'Np');
model.geom('geom1').feature('pi1').setEntry('inputexpr', 'number_of_modeled_poles', 'Np');
model.geom('geom1').feature('pi1').setEntry('selkeepdom', 'pi1_rotor_magnets', true);
model.geom('geom1').feature('pi1').setEntry('selkeepdom', 'pi1_all.dom', true);
model.geom('geom1').run('pi1');
model.geom.load({'part2'}, 'ACDC_Module\Rotating_Machinery_2D\Stators\External\slotted_external_stator_2d.mph', {'part1'});
model.geom('geom1').create('pi2', 'PartInstance');
model.geom('geom1').feature('pi2').set('selkeepnoncontr', false);
model.geom('geom1').feature('pi2').set('part', 'part2');
model.geom('geom1').feature('pi2').setEntry('inputexpr', 'number_of_slots', 'Ns');
model.geom('geom1').feature('pi2').setEntry('inputexpr', 'number_of_modeled_slots', 'Ns');
model.geom('geom1').feature('pi2').setEntry('inputexpr', 'external_air_size', '1.5[mm]');
model.geom('geom1').feature('pi2').setEntry('inputexpr', 'slot_outer_fillet_size', '0.4[mm]');
model.geom('geom1').feature('pi2').setEntry('inputexpr', 'slot_inner_fillet_size', '0.4[mm]');
model.geom('geom1').feature('pi2').setEntry('inputexpr', 'slot_winding_type', 2);
model.geom('geom1').feature('pi2').setEntry('selkeepdom', 'pi2_stator_iron.dom', true);
model.geom('geom1').feature('pi2').setEntry('selkeepdom', 'pi2_stator_slots', true);
model.geom('geom1').feature('pi2').setEntry('selkeepdom', 'pi2_all.dom', true);
model.geom('geom1').run('pi2');
model.geom('geom1').create('r1', 'Rectangle');
model.geom('geom1').feature('r1').set('size', [90 75]);
model.geom('geom1').feature('r1').set('base', 'center');
model.geom('geom1').feature('r1').set('pos', [0 7.5]);
model.geom('geom1').feature('r1').set('layertop', true);
model.geom('geom1').feature('r1').set('layerbottom', false);
model.geom('geom1').feature('r1').set('layerright', true);
model.geom('geom1').feature('r1').set('layerleft', true);
model.geom('geom1').feature('r1').setIndex('layer', 5, 0);
model.geom('geom1').run('r1');
model.geom('geom1').create('r2', 'Rectangle');
model.geom('geom1').feature('r2').set('size', [5 20]);
model.geom('geom1').feature('r2').set('base', 'center');
model.geom('geom1').feature('r2').set('pos', [15 -25]);
model.geom('geom1').feature('r2').set('rot', 20);
model.geom('geom1').run('r2');
model.geom('geom1').create('c1', 'Circle');
model.geom('geom1').feature('c1').set('r', '53/2');
model.geom('geom1').run('c1');
model.geom('geom1').create('dif1', 'Difference');
model.geom('geom1').feature('dif1').selection('input').set({'r2'});
model.geom('geom1').feature('dif1').selection('input2').set({'c1'});
model.geom('geom1').feature('dif1').set('keepsubtract', true);
model.geom('geom1').run('dif1');
model.geom('geom1').create('int1', 'Intersection');
model.geom('geom1').feature('int1').selection('input').set({'dif1' 'r1'});
model.geom('geom1').feature('int1').set('keep', true);
model.geom('geom1').run('int1');
model.geom('geom1').create('mir1', 'Mirror');
model.geom('geom1').feature('mir1').selection('input').set({'int1'});
model.geom('geom1').feature('mir1').set('keep', true);
model.geom('geom1').run('mir1');
model.geom('geom1').create('dif2', 'Difference');
model.geom('geom1').feature('dif2').selection('input').set({'r1'});
model.geom('geom1').feature('dif2').selection('input2').set({'c1'});
model.geom('geom1').run('dif2');
model.geom('geom1').create('del1', 'Delete');
model.geom('geom1').feature('del1').selection('input').init(2);
model.geom('geom1').feature('del1').selection('input').set('dif1', 1);
model.geom('geom1').run('del1');
model.geom('geom1').create('dif3', 'Difference');
model.geom('geom1').feature('dif3').selection('input').set({'dif2'});
model.geom('geom1').feature('dif3').selection('input2').set({'int1' 'mir1'});
model.geom('geom1').feature('dif3').set('keepsubtract', true);
model.geom('geom1').run('dif3');
model.geom('geom1').create('sel1', 'ExplicitSelection');
model.geom('geom1').feature('sel1').label('Acoustic domains');
model.geom('geom1').feature('sel1').selection('selection').set('dif3', [1 2 3 4 6 7]);
model.geom('geom1').run('sel1');
model.geom('geom1').create('sel2', 'ExplicitSelection');
model.geom('geom1').feature('sel2').label('Structural domains');
model.geom('geom1').feature('sel2').selection('selection').set('int1', 1);
model.geom('geom1').feature('sel2').selection('selection').set('mir1', 1);
model.geom('geom1').feature('sel2').selection('selection').set('pi2', [2 27]);
model.geom('geom1').run('sel2');
model.geom('geom1').create('unisel1', 'UnionSelection');
model.geom('geom1').feature('unisel1').label('Electromagnetic domains');
model.geom('geom1').feature('unisel1').set('input', {'pi1_all' 'pi2_all'});
model.geom('geom1').run('unisel1');
model.geom('geom1').create('uni1', 'Union');
model.geom('geom1').feature('uni1').label('Stationary domains');
model.geom('geom1').feature('uni1').selection('input').set({'dif3' 'int1' 'mir1' 'pi2'});
model.geom('geom1').feature('fin').set('action', 'assembly');
model.geom('geom1').run('fin');

model.title([]);

model.description('');

model.label('pm_motor_2d_campbell_diagram_geom_sequence.mph');

model.modelNode.label('Components');

out = model;
