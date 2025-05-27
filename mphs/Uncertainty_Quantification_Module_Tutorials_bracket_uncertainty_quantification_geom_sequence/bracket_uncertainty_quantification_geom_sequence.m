function out = model
%
% bracket_uncertainty_quantification_geom_sequence.m
%
% Model exported on May 26 2025, 21:34 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/Uncertainty_Quantification_Module/Tutorials');

% To import content from file, use:
% model.param.loadFile('FILENAME');
model.param.set('cd', 'lp/2+ts', 'Work-plane position');
model.param.set('hf', 'wp', 'Flange height');
model.param.set('da_r3', '(lp-wf)/2', 'Flange-hole x-position');
model.param.set('db_r3', 'hf/5', 'Flange-hole y-position');
model.param.set('r2', 'hm/2', 'Large side round');
model.param.set('ts', '0.008[m]', 'Material thickness');
model.param.set('lp', '0.19[m]', 'Cross-plate length');
model.param.set('ls', '0.35[m]', 'Side length');
model.param.set('hm', '0.1[m]', 'Side height');
model.param.set('wp', '0.1075[m]', 'Cross-plate width');
model.param.set('wf', '0.0625[m]', 'Flange width');
model.param.set('r3', '0.007[m]', 'Bolt-hole radius');
model.param.set('r1', '0.025[m]', 'Pin-hole radius');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 3);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.geom('geom1').create('wp1', 'WorkPlane');
model.geom('geom1').feature('wp1').set('unite', true);
model.geom('geom1').feature('wp1').set('quickplane', 'yz');
model.geom('geom1').feature('wp1').set('quickx', '-cd');
model.geom('geom1').feature('wp1').geom.create('r1', 'Rectangle');
model.geom('geom1').feature('wp1').geom.feature('r1').set('size', {'ls' 'hm'});
model.geom('geom1').feature('wp1').geom.feature('r1').set('pos', {'-ls' '-hm/2'});
model.geom('geom1').run('wp1');
model.geom('geom1').feature.create('ext1', 'Extrude');
model.geom('geom1').feature('ext1').setIndex('distance', 'ts', 0);
model.geom('geom1').runPre('fin');
model.geom('geom1').create('mir1', 'Mirror');
model.geom('geom1').feature('mir1').selection('input').set({'ext1'});
model.geom('geom1').feature('mir1').set('keep', true);
model.geom('geom1').feature('mir1').set('axis', [1 0 0]);
model.geom('geom1').run('mir1');
model.geom('geom1').create('wp2', 'WorkPlane');
model.geom('geom1').feature('wp2').set('unite', true);
model.geom('geom1').feature('wp2').set('quickz', '-hm/2');
model.geom('geom1').feature('wp2').geom.create('r1', 'Rectangle');
model.geom('geom1').feature('wp2').geom.feature('r1').set('size', {'lp' 'wp'});
model.geom('geom1').feature('wp2').geom.feature('r1').set('pos', {'-lp/2' '-wp'});
model.geom('geom1').feature('wp2').geom.run('r1');
model.geom('geom1').run('wp2');
model.geom('geom1').feature.create('ext2', 'Extrude');
model.geom('geom1').feature('ext2').setIndex('distance', 'ts', 0);
model.geom('geom1').run('ext2');
model.geom('geom1').create('wp3', 'WorkPlane');
model.geom('geom1').feature('wp3').set('unite', true);
model.geom('geom1').feature('wp3').set('quickz', 'hm/2');
model.geom('geom1').feature('wp3').geom.create('r1', 'Rectangle');
model.geom('geom1').feature('wp3').geom.feature('r1').set('size', {'wf' 'hf'});
model.geom('geom1').feature('wp3').geom.feature('r1').set('pos', {'-lp/2' '-hf'});
model.geom('geom1').feature('wp3').geom.run('r1');
model.geom('geom1').feature('wp3').geom.create('c1', 'Circle');
model.geom('geom1').feature('wp3').geom.feature('c1').set('r', 'r3');
model.geom('geom1').feature('wp3').geom.feature('c1').set('pos', {'-da_r3' '-db_r3'});
model.geom('geom1').feature('wp3').geom.run('c1');
model.geom('geom1').feature('wp3').geom.create('mir1', 'Mirror');
model.geom('geom1').feature('wp3').geom.feature('mir1').selection('input').set({'c1'});
model.geom('geom1').feature('wp3').geom.feature('mir1').set('keep', true);
model.geom('geom1').feature('wp3').geom.feature('mir1').set('pos', {'0' '-hf/2'});
model.geom('geom1').feature('wp3').geom.feature('mir1').set('axis', [0 1]);
model.geom('geom1').feature('wp3').geom.run('mir1');
model.geom('geom1').feature('wp3').geom.create('dif1', 'Difference');
model.geom('geom1').feature('wp3').geom.feature('dif1').selection('input').set({'r1'});
model.geom('geom1').feature('wp3').geom.feature('dif1').selection('input2').set({'c1' 'mir1'});
model.geom('geom1').feature('wp3').geom.run('dif1');
model.geom('geom1').run('wp3');
model.geom('geom1').feature.create('ext3', 'Extrude');
model.geom('geom1').feature('ext3').setIndex('distance', 'ts', 0);
model.geom('geom1').feature('ext3').set('reverse', true);
model.geom('geom1').run('ext3');
model.geom('geom1').create('mir2', 'Mirror');
model.geom('geom1').feature('mir2').selection('input').set({'ext3'});
model.geom('geom1').feature('mir2').set('keep', true);
model.geom('geom1').feature('mir2').set('axis', [1 0 0]);
model.geom('geom1').run('mir2');
model.geom('geom1').create('cyl1', 'Cylinder');
model.geom('geom1').feature('cyl1').set('r', 'r1');
model.geom('geom1').feature('cyl1').set('h', '1.1*lp*2');
model.geom('geom1').feature('cyl1').set('pos', {'-1.1*lp' '-ls+r2' '0'});
model.geom('geom1').feature('cyl1').set('axistype', 'x');
model.geom('geom1').run('cyl1');
model.geom('geom1').create('dif1', 'Difference');
model.geom('geom1').feature('dif1').selection('input').set({'ext1' 'mir1'});
model.geom('geom1').feature('dif1').selection('input2').set({'cyl1'});
model.geom('geom1').run('dif1');
model.geom('geom1').create('cyl2', 'Cylinder');
model.geom('geom1').feature('cyl2').set('r', 'hm/2');
model.geom('geom1').feature('cyl2').set('h', '1.1*lp*2');
model.geom('geom1').feature('cyl2').set('pos', {'-1.1*lp' '-ls+r2' '0'});
model.geom('geom1').feature('cyl2').set('axistype', 'x');
model.geom('geom1').run('cyl2');
model.geom('geom1').create('blk1', 'Block');
model.geom('geom1').feature('blk1').set('size', {'1.1*lp*2' 'r2*2' '1'});
model.geom('geom1').feature('blk1').setIndex('size', 'r2*2', 2);
model.geom('geom1').feature('blk1').set('base', 'center');
model.geom('geom1').feature('blk1').set('pos', {'0' '-ls+r2' '0'});
model.geom('geom1').run('blk1');
model.geom('geom1').create('dif2', 'Difference');
model.geom('geom1').feature('dif2').selection('input').set({'blk1'});
model.geom('geom1').feature('dif2').selection('input2').set({'cyl2'});
model.geom('geom1').run('dif2');
model.geom('geom1').create('blk2', 'Block');
model.geom('geom1').feature('blk2').set('size', {'1.1*lp*2' 'hm/2' '1'});
model.geom('geom1').feature('blk2').setIndex('size', 'hm', 2);
model.geom('geom1').feature('blk2').set('base', 'center');
model.geom('geom1').feature('blk2').set('pos', {'0' '-ls+hm/4' '0'});
model.geom('geom1').run('blk2');
model.geom('geom1').create('int1', 'Intersection');
model.geom('geom1').feature('int1').selection('input').set({'blk2' 'dif2'});
model.geom('geom1').run('int1');
model.geom('geom1').create('dif3', 'Difference');
model.geom('geom1').feature('dif3').selection('input').set({'dif1'});
model.geom('geom1').feature('dif3').selection('input2').set({'int1'});
model.geom('geom1').run('dif3');
model.geom('geom1').runPre('fin');
model.geom('geom1').create('uni1', 'Union');
model.geom('geom1').feature('uni1').selection('input').set({'dif3' 'ext2' 'ext3' 'mir2'});
model.geom('geom1').feature('uni1').set('intbnd', false);
model.geom('geom1').run('uni1');

model.title([]);

model.description('');

model.label('bracket_uncertainty_quantification_geom_sequence.mph');

model.modelNode.label('Components');

out = model;
