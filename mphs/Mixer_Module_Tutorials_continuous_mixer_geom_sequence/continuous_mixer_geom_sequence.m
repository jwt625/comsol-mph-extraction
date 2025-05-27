function out = model
%
% continuous_mixer_geom_sequence.m
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

model.param.set('impellerTilt', '30');
model.param.descr('impellerTilt', 'Impeller shaft tilt angle');
model.param.set('r_in', '0.08[m]');
model.param.descr('r_in', 'Inlet radius');
model.param.set('Vol', '3.38[m^3]');
model.param.descr('Vol', 'Tank volume');

model.geom.load({'part1'}, 'Mixer_Module/Tanks/flat_bottom_tank.mph', {'part1'});
model.geom('geom1').create('pi1', 'PartInstance');
model.geom('geom1').feature('pi1').set('selkeepnoncontr', false);
model.geom('geom1').feature('pi1').set('part', 'part1');
model.geom('geom1').feature('pi1').setEntry('inputexpr', 'n_ba', '0[1]');
model.geom('geom1').feature('pi1').setEntry('inputexpr', 'w_ba', '0.15[m]');
model.geom('geom1').feature('pi1').setEntry('inputexpr', 'd_im', '1[m]');
model.geom('geom1').feature('pi1').setEntry('inputexpr', 'd_ta', '1.5[m]');
model.geom('geom1').feature('pi1').setEntry('inputexpr', 'h_ta', '2.0[m]');
model.geom('geom1').feature('pi1').setEntry('inputexpr', 'rm_b_ta', '0.3[m]');
model.geom('geom1').feature('pi1').setEntry('inputexpr', 'hp_ta', '0[m]');
model.geom('geom1').feature('pi1').setEntry('inputexpr', 'rf_ta', '0.05[m]');
model.geom('geom1').run('pi1');
model.geom('geom1').create('uni1', 'Union');
model.geom('geom1').feature('uni1').selection('input').set({'pi1'});
model.geom('geom1').feature('uni1').set('intbnd', false);
model.geom('geom1').run('uni1');
model.geom.load({'part2'}, 'Mixer_Module/Shafts/impeller_shaft.mph', {'part1'});
model.geom('geom1').create('pi2', 'PartInstance');
model.geom('geom1').feature('pi2').set('selkeepnoncontr', false);
model.geom('geom1').feature('pi2').set('part', 'part2');
model.geom('geom1').feature('pi2').setEntry('inputexpr', 'hp_im', '0.5[m]');
model.geom('geom1').feature('pi2').setEntry('inputexpr', 'l_is', '2[m]');
model.geom.load({'part3'}, 'Mixer_Module/Impellers,_Axial/pitched_blade_impeller_constant_pitch.mph', {'part1'});
model.geom('geom1').run('pi2');
model.geom('geom1').create('pi3', 'PartInstance');
model.geom('geom1').feature('pi3').set('selkeepnoncontr', false);
model.geom('geom1').feature('pi3').set('part', 'part3');
model.geom('geom1').feature('pi3').setEntry('inputexpr', 'n_ib', '5[1]');
model.geom('geom1').feature('pi3').setEntry('inputexpr', 'd_im', '0.8[m]');
model.geom('geom1').feature('pi3').setEntry('inputexpr', 'hp_im', '0.5[m]');
model.geom('geom1').feature('pi3').setEntry('inputexpr', 'pa_cs_im', 1);
model.geom('geom1').run('pi3');
model.geom('geom1').create('rot1', 'Rotate');
model.geom('geom1').feature('rot1').selection('input').set({'pi2' 'pi3'});
model.geom('geom1').feature('rot1').set('axistype', 'x');
model.geom('geom1').feature('rot1').set('rot', 'impellerTilt');
model.geom('geom1').feature('rot1').set('pos', [0 0 0.5]);
model.geom('geom1').run('rot1');
model.geom('geom1').create('mov1', 'Move');
model.geom('geom1').feature('mov1').selection('input').set({'rot1'});
model.geom('geom1').feature('mov1').set('disply', -0.175);
model.geom('geom1').run('mov1');
model.geom('geom1').create('dif1', 'Difference');
model.geom('geom1').feature('dif1').selection('input').set({'mov1(3)' 'uni1'});
model.geom('geom1').feature('dif1').selection('input2').set({'mov1(1)' 'mov1(2)'});
model.geom('geom1').run('dif1');
model.geom('geom1').create('cyl1', 'Cylinder');
model.geom('geom1').feature('cyl1').set('r', 'r_in');
model.geom('geom1').feature('cyl1').set('h', 'r_in*8');
model.geom('geom1').feature('cyl1').set('pos', [-0.9 0.3 1.5]);
model.geom('geom1').feature('cyl1').set('axistype', 'x');
model.geom('geom1').run('cyl1');
model.geom('geom1').create('wp1', 'WorkPlane');
model.geom('geom1').feature('wp1').set('unite', true);
model.geom('geom1').feature('wp1').set('quickplane', 'xz');
model.geom('geom1').feature('wp1').set('quicky', -0.35);
model.geom('geom1').feature('wp1').geom.create('r1', 'Rectangle');
model.geom('geom1').feature('wp1').geom.feature('r1').set('size', [0.2 0.2]);
model.geom('geom1').feature('wp1').geom.feature('r1').set('pos', [0.25 -0.25]);
model.geom('geom1').feature('wp1').geom.run('r1');
model.geom('geom1').feature('wp1').geom.create('r2', 'Rectangle');
model.geom('geom1').feature('wp1').geom.feature('r2').set('size', [0.25 0.2]);
model.geom('geom1').feature('wp1').geom.feature('r2').set('pos', [0.25 -0.25]);
model.geom('geom1').feature('wp1').geom.run('r2');
model.geom('geom1').feature('wp1').geom.create('fil1', 'Fillet');
model.geom('geom1').feature('wp1').geom.feature('fil1').selection('pointinsketch').set('r1', 3);
model.geom('geom1').feature('wp1').geom.feature('fil1').set('radius', 0.03);
model.geom('geom1').feature('wp1').geom.run('fil1');
model.geom('geom1').feature('wp1').geom.create('dif1', 'Difference');
model.geom('geom1').feature('wp1').geom.feature('dif1').selection('input').set({'r2'});
model.geom('geom1').feature('wp1').geom.feature('dif1').selection('input2').set({'fil1'});
model.geom('geom1').run('wp1');
model.geom('geom1').feature.create('rev1', 'Revolve');
model.geom('geom1').feature('rev1').set('angtype', 'full');
model.geom('geom1').feature('rev1').set('pos', [0.5 -0.25]);
model.geom('geom1').feature('rev1').set('origfaces', false);
model.geom('geom1').run('fin');
model.geom('geom1').create('ige1', 'IgnoreEdges');
model.geom('geom1').feature('ige1').selection('input').set('fin', [13 27 28 29 60 85 88 90 96 97 99 101 105 109 115 116 120 121 147 148 171 180 188 189 197 198]);
model.geom('geom1').run('ige1');
model.geom('geom1').create('igf1', 'IgnoreFaces');
model.geom('geom1').feature('igf1').selection('input').set('ige1', 51);
model.geom('geom1').run('igf1');

model.title([]);

model.description('');

model.label('continuous_mixer_geom_sequence.mph');

model.modelNode.label('Components');

out = model;
