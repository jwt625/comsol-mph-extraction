function out = model
%
% einzel_lens_geom_sequence.m
%
% Model exported on May 26 2025, 21:31 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/Particle_Tracing_Module/Charged_Particle_Tracing');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 3);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

% To import content from file, use:
% model.param.loadFile('FILENAME');
model.param.set('L_vac', '120[cm]', 'Width of vacuum chamber');
model.param.set('R_vac', '10[cm]', 'Height of vacuum chamber');
model.param.set('L_cyl', '6[cm]', 'Length of cylinders in lens');
model.param.set('T_cyl', '0.25[cm]', 'Thickness of cylinders in lens');
model.param.set('R_cyl_fil', 'T_cyl/2', 'Radius of fillet for cylinders in lens');
model.param.set('R_cyl', '2[cm]', 'Radius of cylinders');
model.param.set('d_lens', '40[cm]', 'Downstream distance of start of lens');
model.param.set('cyl_sep', '2[cm]', 'Separation of cylinders');
model.param.set('initial_beam_radius', '1[cm]', 'Radius of beam at inlet to vacuum chamber');

model.geom('geom1').create('wp1', 'WorkPlane');
model.geom('geom1').feature('wp1').set('unite', true);
model.geom('geom1').feature('wp1').set('quickplane', 'zx');
model.geom('geom1').feature('wp1').geom.create('r1', 'Rectangle');
model.geom('geom1').feature('wp1').geom.feature('r1').set('size', {'T_cyl' 'L_cyl'});
model.geom('geom1').feature('wp1').geom.feature('r1').set('pos', {'R_cyl' 'd_lens'});
model.geom('geom1').feature('wp1').geom.run('r1');
model.geom('geom1').feature('wp1').geom.create('fil1', 'Fillet');
model.geom('geom1').feature('wp1').geom.feature('fil1').selection('pointinsketch').set('r1', [1 2 3 4]);
model.geom('geom1').feature('wp1').geom.feature('fil1').set('radius', 'R_cyl_fil');
model.geom('geom1').feature('wp1').geom.run('fil1');
model.geom('geom1').feature('wp1').geom.create('arr1', 'Array');
model.geom('geom1').feature('wp1').geom.feature('arr1').selection('input').set({'fil1'});
model.geom('geom1').feature('wp1').geom.feature('arr1').set('fullsize', [1 3]);
model.geom('geom1').feature('wp1').geom.feature('arr1').set('displ', {'0' 'L_cyl + cyl_sep'});
model.geom('geom1').feature('wp1').geom.run('arr1');
model.geom('geom1').feature('wp1').geom.create('r2', 'Rectangle');
model.geom('geom1').feature('wp1').geom.feature('r2').set('size', {'R_vac' 'L_vac'});
model.geom('geom1').feature('wp1').geom.run('r2');
model.geom('geom1').feature('wp1').geom.create('pt1', 'Point');
model.geom('geom1').feature('wp1').geom.feature('pt1').setIndex('p', 'initial_beam_radius', 0);
model.geom('geom1').run('wp1');
model.geom('geom1').feature.create('rev1', 'Revolve');
model.geom('geom1').feature('rev1').set('angtype', 'full');
model.geom('geom1').runPre('fin');

model.title([]);

model.description('');

model.label('einzel_lens_geom_sequence.mph');

model.modelNode.label('Components');

out = model;
