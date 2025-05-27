function out = model
%
% airlift_loop_reactor_geom_sequence.m
%
% Model exported on May 26 2025, 21:26 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/CFD_Module/Verification_Examples');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 3);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.param.set('H', '1.75[m]');
model.param.descr('H', 'Reactor height');
model.param.set('W', '0.5[m]');
model.param.descr('W', 'Reactor width');
model.param.set('T', '0.08[m]');
model.param.descr('T', 'Reactor thickness');
model.param.set('d_b', '3e-3[m]');
model.param.descr('d_b', 'Bubble diameter');
model.param.set('R', '0.02[m]');
model.param.descr('R', 'Frit radius');
model.param.set('L', '0.16[m]');
model.param.descr('L', 'Width of riser and downcomer channels');
model.param.set('V_in', '0.015[m/s]');
model.param.descr('V_in', 'Inlet velocity');
model.param.set('Cw', '5e4[kg/(m^3*s)]');
model.param.descr('Cw', 'Slip-velocity proportionality constant');
model.param.set('rhog_in', '0.9727[kg/(m^3)]');
model.param.descr('rhog_in', 'Gas density at inlet');

model.geom('geom1').create('wp1', 'WorkPlane');
model.geom('geom1').feature('wp1').set('unite', true);
model.geom('geom1').feature('wp1').geom.create('pol1', 'Polygon');
model.geom('geom1').feature('wp1').geom.feature('pol1').set('source', 'table');
model.geom('geom1').feature('wp1').geom.feature('pol1').setIndex('table', 0, 0, 0);
model.geom('geom1').feature('wp1').geom.feature('pol1').setIndex('table', 0, 0, 1);
model.geom('geom1').feature('wp1').geom.feature('pol1').setIndex('table', 'L', 1, 0);
model.geom('geom1').feature('wp1').geom.feature('pol1').setIndex('table', 0, 1, 1);
model.geom('geom1').feature('wp1').geom.feature('pol1').setIndex('table', 'W', 2, 0);
model.geom('geom1').feature('wp1').geom.feature('pol1').setIndex('table', 'L', 2, 1);
model.geom('geom1').feature('wp1').geom.feature('pol1').setIndex('table', 'W', 3, 0);
model.geom('geom1').feature('wp1').geom.feature('pol1').setIndex('table', 'H', 3, 1);
model.geom('geom1').feature('wp1').geom.feature('pol1').setIndex('table', 0, 4, 0);
model.geom('geom1').feature('wp1').geom.feature('pol1').setIndex('table', 'H', 4, 1);
model.geom('geom1').feature('wp1').geom.run('pol1');
model.geom('geom1').feature('wp1').geom.create('pol2', 'Polygon');
model.geom('geom1').feature('wp1').geom.feature('pol2').set('source', 'table');
model.geom('geom1').feature('wp1').geom.feature('pol2').setIndex('table', 'L', 0, 0);
model.geom('geom1').feature('wp1').geom.feature('pol2').setIndex('table', 0.11, 0, 1);
model.geom('geom1').feature('wp1').geom.feature('pol2').setIndex('table', 0.34, 1, 0);
model.geom('geom1').feature('wp1').geom.feature('pol2').setIndex('table', 0.2, 1, 1);
model.geom('geom1').feature('wp1').geom.feature('pol2').setIndex('table', 0.34, 2, 0);
model.geom('geom1').feature('wp1').geom.feature('pol2').setIndex('table', 1.47, 2, 1);
model.geom('geom1').feature('wp1').geom.feature('pol2').setIndex('table', 'L', 3, 0);
model.geom('geom1').feature('wp1').geom.feature('pol2').setIndex('table', 1.56, 3, 1);
model.geom('geom1').feature('wp1').geom.run('pol2');
model.geom('geom1').feature('wp1').geom.create('dif1', 'Difference');
model.geom('geom1').feature('wp1').geom.feature('dif1').selection('input').set({'pol1'});
model.geom('geom1').feature('wp1').geom.feature('dif1').selection('input2').set({'pol2'});
model.geom('geom1').feature('wp1').geom.run('dif1');
model.geom('geom1').run('wp1');
model.geom('geom1').feature.create('ext1', 'Extrude');
model.geom('geom1').feature('ext1').set('workplane', 'wp1');
model.geom('geom1').feature('ext1').selection('input').set({'wp1'});
model.geom('geom1').feature('ext1').setIndex('distance', 'T', 0);
model.geom('geom1').runPre('fin');
model.geom('geom1').create('wp2', 'WorkPlane');
model.geom('geom1').feature('wp2').set('unite', true);
model.geom('geom1').feature('wp2').set('quickplane', 'zx');
model.geom('geom1').feature('wp2').geom.create('c1', 'Circle');
model.geom('geom1').feature('wp2').geom.feature('c1').set('r', 'R');
model.geom('geom1').feature('wp2').geom.feature('c1').set('pos', {'T/2' '0.11'});
model.geom('geom1').feature('wp2').geom.run('c1');
model.geom('geom1').feature('wp2').geom.create('c2', 'Circle');
model.geom('geom1').feature('wp2').geom.feature('c2').set('r', 'R');
model.geom('geom1').feature('wp2').geom.feature('c2').set('pos', {'T/2' 'T/2'});
model.geom('geom1').feature('wp2').geom.run('c2');
model.geom('geom1').run('wp2');
model.geom('geom1').create('uni1', 'Union');
model.geom('geom1').feature('uni1').selection('input').set({'ext1' 'wp2'});
model.geom('geom1').runPre('fin');
model.geom('geom1').create('blk1', 'Block');
model.geom('geom1').feature('blk1').set('size', [1 2 1]);
model.geom('geom1').feature('blk1').set('pos', {'0' '0' 'T/2'});
model.geom('geom1').runPre('fin');
model.geom('geom1').create('dif1', 'Difference');
model.geom('geom1').feature('dif1').selection('input').set({'uni1'});
model.geom('geom1').feature('dif1').selection('input2').set({'blk1'});
model.geom('geom1').run('fin');

model.view('view1').camera.setIndex('position', -6.09563, 0);
model.view('view1').camera.setIndex('position', -2.16395, 1);
model.view('view1').camera.setIndex('position', 6.48859, 2);
model.view('view1').camera.set('zoomanglefull', 16.99736);
model.view('view1').camera.setIndex('target', -5.43168, 0);
model.view('view1').camera.setIndex('target', -1.84599, 1);
model.view('view1').camera.setIndex('target', 5.81178, 2);
model.view('view1').camera.setIndex('up', -0.01858, 0);
model.view('view1').camera.setIndex('up', 0.91183, 1);
model.view('view1').camera.setIndex('up', 0.41016, 2);
model.view('view1').camera.setIndex('rotationpoint', 0.25, 0);
model.view('view1').camera.setIndex('rotationpoint', 0.875, 1);
model.view('view1').camera.set('rotationpoint', [0.25 0.875 0.02]);
model.view('view1').camera.setIndex('viewoffset', -0.00285, 0);
model.view('view1').camera.set('viewoffset', [-0.00285 0.00258]);

model.title([]);

model.description('');

model.label('airlift_loop_reactor_geom_sequence.mph');

model.modelNode.label('Components');

out = model;
