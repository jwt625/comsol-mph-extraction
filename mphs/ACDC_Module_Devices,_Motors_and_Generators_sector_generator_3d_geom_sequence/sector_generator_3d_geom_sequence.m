function out = model
%
% sector_generator_3d_geom_sequence.m
%
% Model exported on May 26 2025, 21:24 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/ACDC_Module/Devices,_Motors_and_Generators');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 3);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.param.label('Plane Parameters');
model.param.set('p1x', '(40[cm]-6[cm]-(10.5[cm]-1.75[cm]))*cos(22.5[deg])');
model.param.set('p1y', '(40[cm]-6[cm]-(10.5[cm]-1.75[cm]))*sin(22.5[deg])');
model.param.set('p2y', '9[cm]/2');
model.param.set('rad', 'p1y-p2y');

model.geom('geom1').create('wp1', 'WorkPlane');
model.geom('geom1').feature('wp1').set('unite', true);
model.geom.load({'part1'}, 'ACDC_Module\Rotating_Machinery_2D\Rotors\Internal\surface_mounted_magnet_internal_rotor_2d.mph', {'part1'});
model.geom('geom1').feature('wp1').geom.create('pi1', 'PartInstance');
model.geom('geom1').feature('wp1').geom.feature('pi1').set('selkeepnoncontr', false);
model.geom('geom1').feature('wp1').geom.feature('pi1').set('part', 'part1');
model.geom.load({'part2'}, 'ACDC_Module\Rotating_Machinery_2D\Stators\External\slotted_external_stator_2d.mph', {'part1'});
model.geom('geom1').feature('wp1').geom.run('pi1');
model.geom('geom1').feature('wp1').geom.create('pi2', 'PartInstance');
model.geom('geom1').feature('wp1').geom.feature('pi2').set('selkeepnoncontr', false);
model.geom('geom1').feature('wp1').geom.feature('pi2').set('part', 'part2');
model.geom('geom1').feature('wp1').geom.feature('pi1').setEntry('inputexpr', 'number_of_poles', 8);
model.geom('geom1').feature('wp1').geom.feature('pi1').setEntry('inputexpr', 'number_of_modeled_poles', 1);
model.geom('geom1').feature('wp1').geom.feature('pi1').setEntry('inputexpr', 'shaft_diam', '10[cm]');
model.geom('geom1').feature('wp1').geom.feature('pi1').setEntry('inputexpr', 'rotor_diam', '30[cm]+2*6.5[cm]');
model.geom('geom1').feature('wp1').geom.feature('pi1').setEntry('inputexpr', 'cont_diam', '0.45[m]');
model.geom('geom1').feature('wp1').geom.feature('pi1').setEntry('inputexpr', 'magnet_h', '6.5[cm]');
model.geom('geom1').feature('wp1').geom.feature('pi1').setEntry('inputexpr', 'magnet_w', '10 [cm]');
model.geom('geom1').feature('wp1').geom.feature('pi1').setEntry('inputexpr', 'magnet_fillet_size', '0.6[cm]');
model.geom('geom1').feature('wp1').geom.feature('pi1').setEntry('selkeepdom', 'pi1_shaft.dom', true);
model.geom('geom1').feature('wp1').geom.feature('pi1').setEntry('selkeepdom', 'pi1_rotor_iron.dom', true);
model.geom('geom1').feature('wp1').geom.feature('pi1').setEntry('selkeepdom', 'pi1_magnets_odd.dom', true);
model.geom('geom1').feature('wp1').geom.feature('pi1').setEntry('selkeepdom', 'pi1_magnets_even.dom', true);
model.geom('geom1').feature('wp1').geom.feature('pi1').setEntry('selkeepdom', 'pi1_rotor_magnets', true);
model.geom('geom1').feature('wp1').geom.feature('pi1').setEntry('selkeepdom', 'pi1_rotor_solid_domains.dom', true);
model.geom('geom1').feature('wp1').geom.feature('pi1').setEntry('selkeepdom', 'pi1_rotor_air.dom', true);
model.geom('geom1').feature('wp1').geom.feature('pi1').setEntry('selkeepdom', 'pi1_all.dom', true);
model.geom('geom1').feature('wp1').geom.feature('pi2').setEntry('inputexpr', 'number_of_slots', 8);
model.geom('geom1').feature('wp1').geom.feature('pi2').setEntry('inputexpr', 'number_of_modeled_slots', 2);
model.geom('geom1').feature('wp1').geom.feature('pi2').setEntry('inputexpr', 'backiron_th', '6 [cm]');
model.geom('geom1').feature('wp1').geom.feature('pi2').setEntry('inputexpr', 'stator_diam', '80 [cm]');
model.geom('geom1').feature('wp1').geom.feature('pi2').setEntry('inputexpr', 'external_air_size', '0[cm]');
model.geom('geom1').feature('wp1').geom.feature('pi2').setEntry('inputexpr', 'cont_diam', '45[cm]');
model.geom('geom1').feature('wp1').geom.feature('pi2').setEntry('inputexpr', 'shoe_h', '1.75[cm]');
model.geom('geom1').feature('wp1').geom.feature('pi2').setEntry('inputexpr', 'shoe_w', '11.5[cm]');
model.geom('geom1').feature('wp1').geom.feature('pi2').setEntry('inputexpr', 'tooth_h', '10.5[cm]');
model.geom('geom1').feature('wp1').geom.feature('pi2').setEntry('inputexpr', 'tooth_w', '9[cm]');
model.geom('geom1').feature('wp1').geom.feature('pi2').setEntry('inputexpr', 'shoe_fillet_size', '0.4[cm]');
model.geom('geom1').feature('wp1').geom.feature('pi2').setEntry('inputexpr', 'slot_outer_fillet_size', '0.4[cm]');
model.geom('geom1').feature('wp1').geom.feature('pi2').setEntry('inputexpr', 'slot_inner_fillet_size', '0.4[cm]');
model.geom('geom1').feature('wp1').geom.feature('pi2').setEntry('inputexpr', 'slot_winding_type', 2);
model.geom('geom1').feature('wp1').geom.feature('pi2').setEntry('selkeepdom', 'pi2_stator_iron.dom', true);
model.geom('geom1').feature('wp1').geom.feature('pi2').setEntry('selkeepdom', 'pi2_stator_slots', true);
model.geom('geom1').feature('wp1').geom.feature('pi2').setEntry('selkeepdom', 'pi2_stator_air.dom', true);
model.geom('geom1').feature('wp1').geom.feature('pi2').setEntry('selkeepdom', 'pi2_all.dom', true);
model.geom('geom1').feature('wp1').geom.run('pi2');
model.geom('geom1').feature('wp1').geom.create('rot1', 'Rotate');
model.geom('geom1').feature('wp1').geom.feature('rot1').selection('input').set({'pi2'});
model.geom('geom1').feature('wp1').geom.feature('rot1').set('rot', -22.5);
model.geom('geom1').feature('wp1').geom.run('rot1');
model.geom('geom1').feature('wp1').geom.create('c1', 'Circle');
model.geom('geom1').feature('wp1').geom.feature('c1').set('angle', 45);
model.geom('geom1').feature('wp1').geom.run('c1');
model.geom('geom1').feature('wp1').geom.create('int1', 'Intersection');
model.geom('geom1').feature('wp1').geom.feature('int1').selection('input').set({'c1' 'rot1'});
model.geom('geom1').feature('wp1').geom.run('int1');
model.geom('geom1').feature('wp1').geom.create('rot2', 'Rotate');
model.geom('geom1').feature('wp1').geom.feature('rot2').selection('input').set({'int1' 'pi1'});
model.geom('geom1').feature('wp1').geom.feature('rot2').set('rot', -22.5);
model.geom('geom1').feature('wp1').geom.run('rot2');
model.geom('geom1').run('wp1');
model.geom('geom1').feature.create('ext1', 'Extrude');
model.geom('geom1').feature('ext1').set('workplane', 'wp1');
model.geom('geom1').feature('ext1').selection('input').set({'wp1'});
model.geom('geom1').feature('ext1').setIndex('distance', '0.4[m]/2', 0);
model.geom('geom1').run('ext1');
model.geom('geom1').feature.create('rev1', 'Revolve');
model.geom('geom1').feature('rev1').set('workplane', 'wp1');
model.geom('geom1').feature('rev1').selection('input').set({});
model.geom('geom1').feature('rev1').set('angtype', 'full');
model.geom('geom1').feature('rev1').set('revolvefrom', 'faces');
model.geom('geom1').feature('rev1').selection('inputface').set('ext1', 45);
model.geom('geom1').feature('rev1').set('angtype', 'specang');
model.geom('geom1').feature('rev1').set('angle2', 90);
model.geom('geom1').feature('rev1').set('axistype', '3d');
model.geom('geom1').feature('rev1').set('axis3', [1 0 0]);
model.geom('geom1').feature('rev1').set('pos3', {'0' '4.5[cm]' '0.4[m]/2'});
model.geom('geom1').run('rev1');
model.geom('geom1').feature.duplicate('rev2', 'rev1');
model.geom('geom1').feature('rev2').selection('inputface').set('rev1', 41);
model.geom('geom1').feature('rev2').set('pos3', {'0' '-4.5[cm]' '0.4[m]/2'});
model.geom('geom1').feature('rev2').set('angle2', -90);
model.geom('geom1').run('rev2');
model.geom('geom1').feature.create('ext2', 'Extrude');
model.geom('geom1').feature('ext2').set('extrudefrom', 'faces');
model.geom('geom1').feature('ext2').selection('inputface').set('rev2', 47);
model.geom('geom1').feature('ext2').setIndex('distance', '9[cm]', 0);
model.geom('geom1').run('ext2');
model.geom('geom1').create('wp2', 'WorkPlane');
model.geom('geom1').feature('wp2').set('unite', true);
model.geom('geom1').feature('wp2').set('quickz', '0.4[m]/2');
model.geom('geom1').feature('wp2').geom.create('c1', 'Circle');
model.geom('geom1').feature('wp2').geom.feature('c1').set('r', 0.4);
model.geom('geom1').feature('wp2').geom.feature('c1').set('angle', 45);
model.geom('geom1').feature('wp2').geom.feature('c1').set('rot', -22.5);
model.geom('geom1').feature('wp2').geom.feature('c1').setIndex('layer', 0.175, 0);
model.geom('geom1').run('wp2');
model.geom('geom1').feature.create('ext3', 'Extrude');
model.geom('geom1').feature('ext3').set('workplane', 'wp2');
model.geom('geom1').feature('ext3').selection('input').set({'wp2'});
model.geom('geom1').feature('ext3').setIndex('distance', '0.10', 0);
model.geom('geom1').run('ext3');
model.geom('geom1').create('spl1', 'Split');
model.geom('geom1').feature('spl1').selection('input').set({'ext2' 'ext3'});
model.geom('geom1').run('spl1');
model.geom('geom1').create('uni1', 'Union');
model.geom('geom1').feature('uni1').selection('input').set({'spl1(1)' 'spl1(12)' 'spl1(2)' 'spl1(3)' 'spl1(4)'});
model.geom('geom1').run('uni1');
model.geom('geom1').create('uni2', 'Union');
model.geom('geom1').feature('uni2').selection('input').set({'spl1(10)' 'spl1(11)' 'spl1(13)' 'spl1(5)' 'spl1(6)' 'spl1(7)' 'spl1(8)' 'spl1(9)'});
model.geom('geom1').run('uni2');
model.geom('geom1').create('wp3', 'WorkPlane');
model.geom('geom1').feature('wp3').set('unite', true);
model.geom('geom1').feature('wp3').set('quickplane', 'zy');
model.geom('geom1').feature('wp3').set('quickx', 'p1x');
model.geom('geom1').feature('wp3').geom.create('r1', 'Rectangle');
model.geom('geom1').feature('wp3').geom.feature('r1').set('size', {'0.1' '2*p1y'});
model.geom('geom1').feature('wp3').geom.feature('r1').set('pos', {'0.2' '-p1y'});
model.geom('geom1').feature('wp3').geom.run('r1');
model.geom('geom1').feature('wp3').geom.create('c1', 'Circle');
model.geom('geom1').feature('wp3').geom.feature('c1').set('r', 'rad');
model.geom('geom1').feature('wp3').geom.feature('c1').set('pos', {'0.2' 'p2y'});
model.geom('geom1').feature('wp3').geom.run('c1');
model.geom('geom1').feature('wp3').geom.create('c2', 'Circle');
model.geom('geom1').feature('wp3').geom.feature('c2').set('r', 'rad');
model.geom('geom1').feature('wp3').geom.feature('c2').set('pos', {'0.2' '-p2y'});
model.geom('geom1').feature('wp3').geom.run('c2');
model.geom('geom1').feature('wp3').geom.create('r2', 'Rectangle');
model.geom('geom1').feature('wp3').geom.feature('r2').set('size', {'2*rad' '2*p2y'});
model.geom('geom1').feature('wp3').geom.feature('r2').set('pos', {'0.2-rad' '-p2y'});
model.geom('geom1').feature('wp3').geom.run('r2');
model.geom('geom1').feature('wp3').geom.create('dif1', 'Difference');
model.geom('geom1').feature('wp3').geom.feature('dif1').selection('input').set({'r1'});
model.geom('geom1').feature('wp3').geom.feature('dif1').selection('input2').set({'c1' 'c2' 'r2'});
model.geom('geom1').run('wp3');
model.geom('geom1').create('uni3', 'Union');
model.geom('geom1').feature('uni3').selection('input').set({'uni2' 'wp3'});
model.geom('geom1').run('uni3');
model.geom('geom1').create('wp4', 'WorkPlane');
model.geom('geom1').feature('wp4').set('unite', true);
model.geom('geom1').feature('wp4').set('quickplane', 'xz');
model.geom('geom1').feature('wp4').set('selresult', true);
model.geom('geom1').feature('wp4').geom.create('r1', 'Rectangle');
model.geom('geom1').feature('wp4').geom.feature('r1').set('size', [0.4 0.3]);
model.geom('geom1').run('wp4');
model.geom('geom1').create('par1', 'Partition');
model.geom('geom1').feature('par1').selection('input').set({'uni1' 'uni3'});
model.geom('geom1').feature('par1').selection('tool').set({'wp4'});
model.geom('geom1').feature('fin').set('action', 'assembly');
model.geom('geom1').run('fin');
model.geom('geom1').run('fin');

model.title([]);

model.description('');

model.label('sector_generator_3d_geom_sequence.mph');

model.modelNode.label('Components');

out = model;
