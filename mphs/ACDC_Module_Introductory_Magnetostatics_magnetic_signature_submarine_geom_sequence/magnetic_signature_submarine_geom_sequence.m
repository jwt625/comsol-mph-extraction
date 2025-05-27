function out = model
%
% magnetic_signature_submarine_geom_sequence.m
%
% Model exported on May 26 2025, 21:25 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/ACDC_Module/Introductory_Magnetostatics');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 3);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

% To import content from file, use:
% model.param.loadFile('FILENAME');
model.param.set('tl', '32[m]', 'Total length');
model.param.set('r', '2.5[m]', 'Radius');
model.param.set('tr', '1[m]', 'Tail section radius');
model.param.set('tsl', '7[m]', 'Tail section length');
model.param.set('th', '1.5[m]', 'Turret height');
model.param.set('dw', '50[m]', 'Domain width');
model.param.set('dl', '100[m]', 'Domain length');
model.param.set('tas', '2.5[m]', 'Turret a-semiaxis');
model.param.set('tbs', '0.625[m]', 'Turret b-semiaxis');

model.geom('geom1').create('wp1', 'WorkPlane');
model.geom('geom1').feature('wp1').set('unite', true);
model.geom('geom1').feature('wp1').geom.create('ca1', 'CircularArc');
model.geom('geom1').feature('wp1').geom.feature('ca1').set('specify', 'endsangle1');
model.geom('geom1').feature('wp1').geom.feature('ca1').set('point1', {'-tl/2+r' 'r'});
model.geom('geom1').feature('wp1').geom.feature('ca1').set('point2', {'-tl/2' '0'});
model.geom('geom1').feature('wp1').geom.feature('ca1').set('angle1', 90);
model.geom('geom1').feature('wp1').geom.run('ca1');
model.geom('geom1').feature('wp1').geom.create('ls1', 'LineSegment');
model.geom('geom1').feature('wp1').geom.feature('ls1').set('specify1', 'coord');
model.geom('geom1').feature('wp1').geom.feature('ls1').set('specify2', 'coord');
model.geom('geom1').feature('wp1').geom.feature('ls1').set('coord1', {'-tl/2+r' '0'});
model.geom('geom1').feature('wp1').geom.feature('ls1').set('coord2', {'tl/2-tsl' '0'});
model.geom('geom1').feature('wp1').geom.feature('ls1').set('coord1', {'-tl/2+r' 'r'});
model.geom('geom1').feature('wp1').geom.feature('ls1').set('coord2', {'tl/2-tsl' 'r'});
model.geom('geom1').feature('wp1').geom.run('ls1');
model.geom('geom1').feature('wp1').geom.create('cb1', 'CubicBezier');
model.geom('geom1').feature('wp1').geom.feature('cb1').setIndex('p', 'tl/2-tsl', 0, 0);
model.geom('geom1').feature('wp1').geom.feature('cb1').setIndex('p', 'tl/2-(tsl*4/7)', 0, 1);
model.geom('geom1').feature('wp1').geom.feature('cb1').setIndex('p', 'tl/2-(tsl*4/7)', 0, 2);
model.geom('geom1').feature('wp1').geom.feature('cb1').setIndex('p', 'tl/2', 0, 3);
model.geom('geom1').feature('wp1').geom.feature('cb1').setIndex('p', 'r', 1, 0);
model.geom('geom1').feature('wp1').geom.feature('cb1').setIndex('p', 'r', 1, 1);
model.geom('geom1').feature('wp1').geom.feature('cb1').setIndex('p', 'tr', 1, 2);
model.geom('geom1').feature('wp1').geom.feature('cb1').setIndex('p', 'tr', 1, 3);
model.geom('geom1').feature('wp1').geom.run('cb1');
model.geom('geom1').feature('wp1').geom.create('ls2', 'LineSegment');
model.geom('geom1').feature('wp1').geom.feature('ls2').set('specify1', 'coord');
model.geom('geom1').feature('wp1').geom.feature('ls2').set('specify2', 'coord');
model.geom('geom1').feature('wp1').geom.feature('ls2').set('coord1', {'tl/2' '0'});
model.geom('geom1').feature('wp1').geom.feature('ls2').set('coord2', {'tl/2' '0'});
model.geom('geom1').feature('wp1').geom.feature('ls2').set('coord1', {'tl/2' 'tr'});
model.geom('geom1').feature('wp1').geom.run('ls2');
model.geom('geom1').feature('wp1').geom.create('ls3', 'LineSegment');
model.geom('geom1').feature('wp1').geom.feature('ls3').set('specify1', 'coord');
model.geom('geom1').feature('wp1').geom.feature('ls3').set('specify2', 'coord');
model.geom('geom1').feature('wp1').geom.feature('ls3').set('coord1', {'tl/2' '0'});
model.geom('geom1').feature('wp1').geom.feature('ls3').set('coord2', {'-tl/2' '0'});
model.geom('geom1').feature('wp1').geom.run('ls3');
model.geom('geom1').feature('wp1').geom.create('csol1', 'ConvertToSolid');
model.geom('geom1').feature('wp1').geom.feature('csol1').selection('input').set({'ca1' 'cb1' 'ls1' 'ls2' 'ls3'});
model.geom('geom1').feature('wp1').geom.run('csol1');
model.geom('geom1').run('wp1');
model.geom('geom1').feature.create('rev1', 'Revolve');
model.geom('geom1').feature('rev1').set('workplane', 'wp1');
model.geom('geom1').feature('rev1').selection('input').set({'wp1'});
model.geom('geom1').feature('rev1').set('angtype', 'full');
model.geom('geom1').feature('rev1').set('axis', [1 0]);
model.geom('geom1').run('rev1');
model.geom('geom1').create('wp2', 'WorkPlane');
model.geom('geom1').feature('wp2').set('unite', true);
model.geom('geom1').feature('wp2').geom.create('e1', 'Ellipse');
model.geom('geom1').feature('wp2').geom.feature('e1').set('semiaxes', {'tas' 'tbs'});
model.geom('geom1').run('wp2');
model.geom('geom1').feature.create('ext1', 'Extrude');
model.geom('geom1').feature('ext1').set('workplane', 'wp2');
model.geom('geom1').feature('ext1').selection('input').set({'wp2'});
model.geom('geom1').feature('ext1').setIndex('distance', 'r+th', 0);
model.geom('geom1').run('ext1');
model.geom('geom1').create('uni1', 'Union');
model.geom('geom1').feature('uni1').set('intbnd', false);
model.geom('geom1').feature('uni1').selection('input').set({'ext1' 'rev1'});
model.geom('geom1').run('uni1');
model.geom('geom1').feature('uni1').label('Submarine');
model.geom('geom1').create('blk1', 'Block');
model.geom('geom1').feature('blk1').set('size', {'dl' 'dw' 'dw'});
model.geom('geom1').feature('blk1').set('base', 'center');
model.geom('geom1').run('fin');

model.view('view1').set('renderwireframe', false);

model.title([]);

model.description('');

model.label('magnetic_signature_submarine_geom_sequence.mph');

model.modelNode.label('Components');

out = model;
