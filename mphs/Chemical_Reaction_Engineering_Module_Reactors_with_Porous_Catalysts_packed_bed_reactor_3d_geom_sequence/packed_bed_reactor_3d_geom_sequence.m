function out = model
%
% packed_bed_reactor_3d_geom_sequence.m
%
% Model exported on May 26 2025, 21:27 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/Chemical_Reaction_Engineering_Module/Reactors_with_Porous_Catalysts');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 3);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.geom('geom1').create('wp1', 'WorkPlane');
model.geom('geom1').feature('wp1').set('unite', true);
model.geom('geom1').feature('wp1').set('quickplane', 'yz');
model.geom('geom1').selection.create('csel1', 'CumulativeSelection');
model.geom('geom1').selection('csel1').label('Inlet');
model.geom('geom1').feature('wp1').set('contributeto', 'csel1');
model.geom('geom1').feature('wp1').geom.create('c1', 'Circle');
model.geom('geom1').feature('wp1').geom.feature('c1').set('r', 0.017);
model.geom('geom1').feature('wp1').geom.feature('c1').set('angle', 45);
model.geom('geom1').feature('wp1').geom.run('c1');
model.geom('geom1').feature('wp1').geom.feature.duplicate('c2', 'c1');
model.geom('geom1').feature('wp1').geom.feature('c2').set('angle', 180);
model.geom('geom1').feature('wp1').geom.feature('c2').set('pos', {'0.017*2+0.02' '0'});
model.geom('geom1').feature('wp1').geom.feature.duplicate('c3', 'c2');
model.geom('geom1').feature('wp1').geom.feature('c3').set('pos', {'0.017*4+0.02*2' '0'});
model.geom('geom1').feature('wp1').geom.feature.duplicate('c4', 'c3');
model.geom('geom1').feature('wp1').geom.feature('c4').set('pos', {'0.017*6+0.02*3' '0'});
model.geom('geom1').feature('wp1').geom.feature.duplicate('c5', 'c4');
model.geom('geom1').feature('wp1').geom.feature('c5').set('pos', {'0.017*2+0.02' '0'});
model.geom('geom1').feature('wp1').geom.feature('c5').set('rot', 180);
model.geom('geom1').feature('wp1').geom.feature.duplicate('c6', 'c5');
model.geom('geom1').feature('wp1').geom.feature('c6').set('pos', {'0.017*4+0.02*2' '0'});
model.geom('geom1').feature('wp1').geom.feature.duplicate('c7', 'c6');
model.geom('geom1').feature('wp1').geom.feature('c7').set('pos', {'0.017*6+0.02*3' '0'});
model.geom('geom1').feature('wp1').geom.run('c7');
model.geom('geom1').feature('wp1').geom.create('rot1', 'Rotate');
model.geom('geom1').feature('wp1').geom.feature('rot1').selection('input').set({'c5' 'c6' 'c7'});
model.geom('geom1').feature('wp1').geom.feature('rot1').set('rot', 45);
model.geom('geom1').feature('wp1').geom.run('rot1');
model.geom('geom1').feature('wp1').geom.feature.duplicate('c8', 'c7');
model.geom('geom1').feature('wp1').geom.feature('c8').set('angle', 360);
model.geom('geom1').feature('wp1').geom.feature('c8').set('pos', {'0.017*4+0.02*2' '0'});
model.geom('geom1').feature('wp1').geom.feature('c8').set('rot', 0);
model.geom('geom1').feature('wp1').geom.run('c8');
model.geom('geom1').feature('wp1').geom.feature.duplicate('c9', 'c8');
model.geom('geom1').feature('wp1').geom.feature('c9').set('pos', {'0.017*6+0.02*3' '0'});
model.geom('geom1').feature('wp1').geom.run('c9');
model.geom('geom1').feature('wp1').geom.create('rot2', 'Rotate');
model.geom('geom1').feature('wp1').geom.feature('rot2').selection('input').set({'c8' 'c9'});
model.geom('geom1').feature('wp1').geom.feature('rot2').set('rot', 22.5);
model.geom('geom1').feature('wp1').geom.run('rot2');
model.geom('geom1').run('wp1');
model.geom('geom1').create('wp2', 'WorkPlane');
model.geom('geom1').feature('wp2').set('unite', true);
model.geom('geom1').feature('wp2').set('quickplane', 'yz');
model.geom('geom1').selection.create('csel2', 'CumulativeSelection');
model.geom('geom1').selection('csel2').label('Bottom plate');
model.geom('geom1').feature('wp2').set('contributeto', 'csel2');
model.geom('geom1').feature('wp2').geom.create('c1', 'Circle');
model.geom('geom1').feature('wp2').geom.feature('c1').set('r', '.2');
model.geom('geom1').feature('wp2').geom.feature('c1').set('angle', 45);
model.geom('geom1').feature('wp2').geom.run('c1');
model.geom('geom1').run('wp2');
model.geom('geom1').feature.create('ext1', 'Extrude');
model.geom('geom1').run('ext1');
model.geom('geom1').run('fin');
model.geom('geom1').run('ext1');
model.geom('geom1').create('sel1', 'ExplicitSelection');
model.geom('geom1').feature('sel1').selection('selection').init(2);
model.geom('geom1').feature('sel1').selection('selection').set('ext1', [2 3]);
model.geom('geom1').feature('sel1').label('Symmetry planes');
model.geom('geom1').feature.duplicate('sel2', 'sel1');
model.geom('geom1').feature('sel2').label('Outlet');
model.geom('geom1').runPre('sel2');
model.geom('geom1').feature('sel2').selection('selection').clear('ext1');
model.geom('geom1').feature('sel2').selection('selection').set('ext1', 5);
model.geom('geom1').runPre('fin');

model.title([]);

model.description('');

model.label('packed_bed_reactor_3d_geom_sequence.mph');

model.modelNode.label('Components');

out = model;
