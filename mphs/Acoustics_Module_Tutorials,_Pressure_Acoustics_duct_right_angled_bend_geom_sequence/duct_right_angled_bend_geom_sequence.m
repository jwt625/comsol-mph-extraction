function out = model
%
% duct_right_angled_bend_geom_sequence.m
%
% Model exported on May 26 2025, 21:25 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/Acoustics_Module/Tutorials,_Pressure_Acoustics');

model.param.set('L', '120[cm]');
model.param.descr('L', 'Waveguide length');
model.param.set('W', '30[cm]');
model.param.descr('W', 'Waveguide width');
model.param.set('H', '20[cm]');
model.param.descr('H', 'Waveguide height');
model.param.set('Rcurv', '8[cm]');
model.param.descr('Rcurv', 'Bend curvature radius');
model.param.set('Rcyl', '20[cm]');
model.param.descr('Rcyl', 'Cylinder radius (for dent)');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 3);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.geom('geom1').create('wp1', 'WorkPlane');
model.geom('geom1').feature('wp1').set('unite', true);
model.geom('geom1').feature('wp1').geom.create('r1', 'Rectangle');
model.geom('geom1').feature('wp1').geom.feature('r1').set('size', {'L' 'W'});
model.geom('geom1').feature('wp1').geom.run('r1');
model.geom('geom1').feature('wp1').geom.create('r2', 'Rectangle');
model.geom('geom1').feature('wp1').geom.feature('r2').set('size', {'W' 'L'});
model.geom('geom1').feature('wp1').geom.feature('r2').set('pos', {'L-W' '0'});
model.geom('geom1').feature('wp1').geom.run('r2');
model.geom('geom1').feature('wp1').geom.create('uni1', 'Union');
model.geom('geom1').feature('wp1').geom.feature('uni1').selection('input').set({'r1' 'r2'});
model.geom('geom1').feature('wp1').geom.feature('uni1').set('intbnd', false);
model.geom('geom1').feature('wp1').geom.run('uni1');
model.geom('geom1').feature('wp1').geom.create('fil1', 'Fillet');
model.geom('geom1').feature('wp1').geom.feature('fil1').selection('point').set('uni1', 4);
model.geom('geom1').feature('wp1').geom.feature('fil1').set('radius', 'Rcurv');
model.geom('geom1').feature('wp1').geom.run('fil1');
model.geom('geom1').feature('wp1').geom.create('fil2', 'Fillet');
model.geom('geom1').feature('wp1').geom.feature('fil2').selection('point').set('fil1', 7);
model.geom('geom1').feature('wp1').geom.feature('fil2').set('radius', '1.2*Rcurv');
model.geom('geom1').feature('wp1').geom.run('fil2');
model.geom('geom1').run('wp1');
model.geom('geom1').feature.create('ext1', 'Extrude');
model.geom('geom1').feature('ext1').set('workplane', 'wp1');
model.geom('geom1').feature('ext1').selection('input').set({'wp1'});
model.geom('geom1').feature('ext1').setIndex('distance', 'H', 0);
model.geom('geom1').run('ext1');
model.geom('geom1').create('cyl1', 'Cylinder');
model.geom('geom1').feature('cyl1').set('r', 'Rcyl');
model.geom('geom1').feature('cyl1').set('pos', {'L/2' 'L/2' 'H+0.8*Rcyl'});
model.geom('geom1').feature('cyl1').set('axistype', 'x');
model.geom('geom1').run('cyl1');
model.geom('geom1').create('dif1', 'Difference');
model.geom('geom1').feature('dif1').selection('input').set({'ext1'});
model.geom('geom1').feature('dif1').selection('input2').set({'cyl1'});
model.geom('geom1').runPre('fin');

model.title([]);

model.description('');

model.label('duct_right_angled_bend_geom_sequence.mph');

model.modelNode.label('Components');

out = model;
