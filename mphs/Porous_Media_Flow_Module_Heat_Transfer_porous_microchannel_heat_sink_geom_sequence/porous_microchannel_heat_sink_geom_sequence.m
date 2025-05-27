function out = model
%
% porous_microchannel_heat_sink_geom_sequence.m
%
% Model exported on May 26 2025, 21:32 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/Porous_Media_Flow_Module/Heat_Transfer');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 3);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.param.set('width', '0.7[mm]');
model.param.descr('width', 'Total width');
model.param.set('height', '2.5[mm]');
model.param.descr('height', 'Total height');
model.param.set('length', '10.6[mm]');
model.param.descr('length', 'Total length');
model.param.set('th_porous', '0.1[mm]');
model.param.descr('th_porous', 'Porous structure thickness');
model.param.set('th_solid', '0.025[mm]');
model.param.descr('th_solid', 'Solid thickness');
model.param.set('width_channel', 'width-2*(th_porous+th_solid)');
model.param.descr('width_channel', 'Channel width');
model.param.set('height_channel', 'height-2*th_solid');
model.param.descr('height_channel', 'Channel height');

model.geom('geom1').lengthUnit('mm');
model.geom('geom1').create('wp1', 'WorkPlane');
model.geom('geom1').feature('wp1').set('unite', true);
model.geom('geom1').feature('wp1').set('quickplane', 'xz');
model.geom('geom1').feature('wp1').geom.create('r1', 'Rectangle');
model.geom('geom1').feature('wp1').geom.feature('r1').set('size', {'width/2' 'height'});
model.geom('geom1').feature('wp1').geom.feature('r1').set('layerright', true);
model.geom('geom1').feature('wp1').geom.feature('r1').set('layertop', true);
model.geom('geom1').feature('wp1').geom.feature('r1').setIndex('layername', 'Layer 1', 0);
model.geom('geom1').feature('wp1').geom.feature('r1').setIndex('layer', 'th_solid', 0);
model.geom('geom1').feature('wp1').geom.run('r1');
model.geom('geom1').feature('wp1').geom.create('r2', 'Rectangle');
model.geom('geom1').feature('wp1').geom.feature('r2').set('size', {'th_porous' 'height_channel'});
model.geom('geom1').feature('wp1').geom.feature('r2').set('pos', {'width_channel/2' '0'});
model.geom('geom1').feature('wp1').geom.feature('r2').setIndex('pos', 'th_solid', 1);
model.geom('geom1').run('wp1');
model.geom('geom1').feature.create('ext1', 'Extrude');
model.geom('geom1').feature('ext1').set('workplane', 'wp1');
model.geom('geom1').feature('ext1').selection('input').set({'wp1'});
model.geom('geom1').feature('ext1').setIndex('distance', 'length', 0);
model.geom('geom1').feature('ext1').set('reverse', true);
model.geom('geom1').run('ext1');
model.geom('geom1').run('fin');
model.geom('geom1').create('mcf1', 'MeshControlFaces');

model.view('view1').set('renderwireframe', true);

model.geom('geom1').feature('mcf1').selection('input').set('fin', [19 24 25 27]);
model.geom('geom1').run('mcf1');

model.view('view1').set('renderwireframe', false);

model.geom('geom1').create('sel1', 'ExplicitSelection');
model.geom('geom1').feature('sel1').selection('selection').set('mcf1', 1);
model.geom('geom1').feature('sel1').label('Solid');
model.geom('geom1').run('sel1');
model.geom('geom1').create('sel2', 'ExplicitSelection');
model.geom('geom1').feature('sel2').selection('selection').set('mcf1', 3);
model.geom('geom1').feature('sel2').label('Porous');
model.geom('geom1').run('sel2');
model.geom('geom1').create('comsel1', 'ComplementSelection');
model.geom('geom1').feature('comsel1').set('input', {'sel1' 'sel2'});
model.geom('geom1').run('comsel1');
model.geom('geom1').feature('comsel1').label('Fluid');
model.geom('geom1').create('unisel1', 'UnionSelection');
model.geom('geom1').feature('unisel1').set('input', {'sel2' 'comsel1'});
model.geom('geom1').feature('unisel1').label('Flow Domain');
model.geom('geom1').run('unisel1');
model.geom('geom1').create('adjsel1', 'AdjacentSelection');
model.geom('geom1').feature('adjsel1').set('input', {'unisel1'});
model.geom('geom1').feature('adjsel1').label('Flow Domain Boundaries');
model.geom('geom1').run('adjsel1');
model.geom('geom1').create('sel3', 'ExplicitSelection');
model.geom('geom1').feature('sel3').selection('selection').init(2);
model.geom('geom1').feature('sel3').set('groupcontang', true);
model.geom('geom1').feature('sel3').selection('selection').add('mcf1', [1 4 7 18]);
model.geom('geom1').feature('sel3').label('Symmetry');
model.geom('geom1').run('sel3');
model.geom('geom1').create('sel4', 'ExplicitSelection');
model.geom('geom1').feature('sel4').selection('selection').init(2);
model.geom('geom1').feature('sel4').selection('selection').set('mcf1', [5 13]);
model.geom('geom1').feature('sel4').label('Inlet');
model.geom('geom1').run('sel4');
model.geom('geom1').create('sel5', 'ExplicitSelection');
model.geom('geom1').feature('sel5').selection('selection').init(2);
model.geom('geom1').feature('sel5').selection('selection').set('mcf1', [11 16]);
model.geom('geom1').feature('sel5').label('Outlet');
model.geom('geom1').run('sel5');
model.geom('geom1').create('difsel1', 'DifferenceSelection');
model.geom('geom1').feature('difsel1').set('entitydim', 2);
model.geom('geom1').feature('difsel1').set('add', {'adjsel1'});
model.geom('geom1').feature('difsel1').set('subtract', {'sel3' 'sel4' 'sel5'});
model.geom('geom1').run('difsel1');
model.geom('geom1').feature('difsel1').label('Wall Boundaries');
model.geom('geom1').run('difsel1');
model.geom('geom1').create('adjsel2', 'AdjacentSelection');
model.geom('geom1').feature('adjsel2').set('input', {'sel1'});
model.geom('geom1').feature('adjsel2').label('Solid Boundaries');
model.geom('geom1').run('adjsel2');

model.title([]);

model.description('');

model.label('porous_microchannel_heat_sink_geom_sequence.mph');

model.modelNode.label('Components');

out = model;
