function out = model
%
% shell_diffusion_geom_sequence.m
%
% Model exported on May 26 2025, 21:26 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/COMSOL_Multiphysics/Equation_Based');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 3);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.geom('geom1').create('wp1', 'WorkPlane');
model.geom('geom1').feature('wp1').set('unite', true);
model.geom('geom1').feature('wp1').set('quickplane', 'yz');
model.geom('geom1').feature('wp1').geom.create('pol1', 'Polygon');
model.geom('geom1').feature('wp1').geom.feature('pol1').set('source', 'table');
model.geom('geom1').feature('wp1').geom.feature('pol1').set('type', 'open');
model.geom('geom1').feature('wp1').geom.feature('pol1').set('source', 'vectors');
model.geom('geom1').feature('wp1').geom.feature('pol1').set('x', '0 0.15 0.15 0.15 0.15 0.05');
model.geom('geom1').feature('wp1').geom.feature('pol1').set('y', '0 0 0 1 1 1');
model.geom('geom1').feature('wp1').geom.run('pol1');
model.geom('geom1').feature('wp1').geom.create('fil1', 'Fillet');
model.geom('geom1').feature('wp1').geom.feature('fil1').selection('point').set('pol1', [3 4]);
model.geom('geom1').feature('wp1').geom.feature('fil1').set('radius', 0.05);
model.geom('geom1').feature('wp1').geom.run('fil1');
model.geom('geom1').run('wp1');
model.geom('geom1').feature.create('rev1', 'Revolve');
model.geom('geom1').feature('rev1').set('workplane', 'wp1');
model.geom('geom1').feature('rev1').selection('input').set({'wp1'});
model.geom('geom1').feature('rev1').set('angtype', 'full');
model.geom('geom1').run('rev1');
model.geom('geom1').create('wp2', 'WorkPlane');
model.geom('geom1').feature('wp2').set('unite', true);
model.geom('geom1').feature('wp2').set('quickplane', 'yz');
model.geom('geom1').feature('wp2').geom.create('c1', 'Circle');
model.geom('geom1').feature('wp2').geom.feature('c1').set('r', 0.05);
model.geom('geom1').feature('wp2').geom.feature('c1').set('pos', [0 0.2]);
model.geom('geom1').feature('wp2').geom.run('c1');
model.geom('geom1').run('wp2');
model.geom('geom1').feature.create('ext1', 'Extrude');
model.geom('geom1').feature('ext1').set('workplane', 'wp2');
model.geom('geom1').feature('ext1').selection('input').set({'wp2'});
model.geom('geom1').feature('ext1').setIndex('distance', 0.2, 0);
model.geom('geom1').run('ext1');
model.geom('geom1').create('par1', 'Partition');
model.geom('geom1').feature('par1').selection('input').set({'rev1'});
model.geom('geom1').feature('par1').selection('tool').set({'ext1'});
model.geom('geom1').run('par1');
model.geom('geom1').run('fin');
model.geom('geom1').create('ige1', 'IgnoreEdges');
model.geom('geom1').feature('ige1').selection('input').set('fin', 45);
model.geom('geom1').run('ige1');
model.geom('geom1').create('igf1', 'IgnoreFaces');
model.geom('geom1').feature('igf1').selection('input').set('ige1', 21);
model.geom('geom1').run('igf1');

model.view('view1').set('renderwireframe', true);

model.title([]);

model.description('');

model.label('shell_diffusion_geom_sequence.mph');

model.modelNode.label('Components');

out = model;
