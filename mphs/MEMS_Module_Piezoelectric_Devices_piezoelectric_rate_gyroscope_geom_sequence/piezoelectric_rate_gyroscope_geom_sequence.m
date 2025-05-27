function out = model
%
% piezoelectric_rate_gyroscope_geom_sequence.m
%
% Model exported on May 26 2025, 21:30 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/MEMS_Module/Piezoelectric_Devices');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 3);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

% To import content from file, use:
% model.param.loadFile('FILENAME');
model.param.set('tQz', '0.5[mm]', 'Quartz thickness');
model.param.set('w_m', '1[mm]', 'Mount width');
model.param.set('l_w', '(l_f-w_m)/2-w_tbf', 'Wing length');
model.param.set('w_w', '0.25[mm]', 'Wing width');
model.param.set('l_f', '4[mm]', 'Frame length');
model.param.set('w_f', '3[mm]', 'Frame width');
model.param.set('w_tbf', '0.4[mm]', 'Frame top/bottom thickness');
model.param.set('w_sf', '0.25[mm]', 'Frame side thickness');
model.param.set('l_d', '6[mm]', 'Drive tine length');
model.param.set('w_d', '0.4[mm]', 'Drive tine width');
model.param.set('l_s', '5.5[mm]', 'Sense tine length');
model.param.set('w_s', '0.4[mm]', 'Sense tine width');
model.param.set('gap', '1[mm]', 'Gap between tines');

model.geom('geom1').lengthUnit('mm');
model.geom('geom1').repairTolType('relative');
model.geom('geom1').create('wp1', 'WorkPlane');
model.geom('geom1').feature('wp1').set('unite', true);
model.geom('geom1').feature('wp1').set('quickz', '-tQz/2');
model.geom('geom1').feature('wp1').geom.create('r1', 'Rectangle');
model.geom('geom1').feature('wp1').geom.feature('r1').set('size', {'w_f' 'l_f'});
model.geom('geom1').feature('wp1').geom.feature('r1').set('base', 'center');
model.geom('geom1').feature('wp1').geom.feature.duplicate('r2', 'r1');
model.geom('geom1').feature('wp1').geom.feature('r2').set('size', {'w_f-2*w_sf' 'l_f-2*w_tbf'});
model.geom('geom1').feature('wp1').geom.run('r2');
model.geom('geom1').feature('wp1').geom.create('dif1', 'Difference');
model.geom('geom1').feature('wp1').geom.feature('dif1').selection('input').set({'r1'});
model.geom('geom1').feature('wp1').geom.feature('dif1').selection('input2').set({'r2'});
model.geom('geom1').feature('wp1').geom.run('dif1');
model.geom('geom1').feature('wp1').geom.create('sq1', 'Square');
model.geom('geom1').feature('wp1').geom.feature('sq1').set('size', 'w_m');
model.geom('geom1').feature('wp1').geom.feature('sq1').set('base', 'center');
model.geom('geom1').feature('wp1').geom.run('sq1');
model.geom('geom1').feature('wp1').geom.create('r3', 'Rectangle');
model.geom('geom1').feature('wp1').geom.feature('r3').set('size', {'w_w' 'l_w'});
model.geom('geom1').feature('wp1').geom.feature('r3').set('pos', {'-w_w/2' 'w_m/2'});
model.geom('geom1').feature('wp1').geom.run('r3');
model.geom('geom1').feature('wp1').geom.create('r4', 'Rectangle');
model.geom('geom1').feature('wp1').geom.feature('r4').set('size', {'w_w' 'l_w'});
model.geom('geom1').feature('wp1').geom.feature('r4').set('pos', {'-w_w/2' '-w_m/2-l_w'});
model.geom('geom1').feature('wp1').geom.run('r4');
model.geom('geom1').feature('wp1').geom.create('r5', 'Rectangle');
model.geom('geom1').feature('wp1').geom.feature('r5').set('size', {'w_d' 'l_d'});
model.geom('geom1').feature('wp1').geom.feature('r5').set('pos', {'gap/2' 'l_f/2'});
model.geom('geom1').feature('wp1').geom.run('r5');
model.geom('geom1').feature('wp1').geom.create('r6', 'Rectangle');
model.geom('geom1').feature('wp1').geom.feature('r6').set('size', {'w_s' 'l_s'});
model.geom('geom1').feature('wp1').geom.feature('r6').set('pos', {'gap/2' '-l_f/2-l_s'});
model.geom('geom1').feature('wp1').geom.run('r6');
model.geom('geom1').feature('wp1').geom.create('mir1', 'Mirror');
model.geom('geom1').feature('wp1').geom.feature('mir1').selection('input').set({'r5' 'r6'});
model.geom('geom1').feature('wp1').geom.feature('mir1').set('keep', true);
model.geom('geom1').feature('wp1').geom.run('mir1');
model.geom('geom1').feature('wp1').geom.create('uni1', 'Union');
model.geom('geom1').feature('wp1').geom.feature('uni1').selection('input').set({'dif1' 'mir1' 'r3' 'r4' 'r5' 'r6' 'sq1'});
model.geom('geom1').feature('wp1').geom.feature('uni1').set('intbnd', false);
model.geom('geom1').run('wp1');
model.geom('geom1').feature.create('ext1', 'Extrude');
model.geom('geom1').feature('ext1').setIndex('distance', 'tQz', 0);
model.geom('geom1').run('ext1');
model.geom('geom1').create('wp2', 'WorkPlane');
model.geom('geom1').feature('wp2').set('unite', true);
model.geom('geom1').feature('wp2').set('quickoffsettype', 'vertex');
model.geom('geom1').feature('wp2').selection('offsetvertex').set('ext1', 21);
model.geom('geom1').feature('wp2').set('unite', false);
model.geom('geom1').feature('wp2').geom.create('c1', 'Circle');
model.geom('geom1').feature('wp2').geom.feature('c1').set('r', '0.4*w_m');
model.geom('geom1').feature('wp2').geom.run('c1');
model.geom('geom1').feature('wp2').geom.create('r1', 'Rectangle');
model.geom('geom1').feature('wp2').geom.feature('r1').set('size', {'w_d*0.6' 'l_d*0.8'});
model.geom('geom1').feature('wp2').geom.feature('r1').set('pos', {'gap/2+w_d*0.2' '0'});
model.geom('geom1').feature('wp2').geom.feature('r1').setIndex('pos', 'l_f/2+l_d*0.1', 1);
model.geom('geom1').feature('wp2').geom.run('r1');
model.geom('geom1').feature('wp2').geom.create('mir1', 'Mirror');
model.geom('geom1').feature('wp2').geom.feature('mir1').selection('input').set({'r1'});
model.geom('geom1').feature('wp2').geom.feature('mir1').set('keep', true);
model.geom('geom1').run('wp2');
model.geom('geom1').create('arr1', 'Array');
model.geom('geom1').feature('arr1').selection('input').set({'wp2.mir1' 'wp2.r1'});
model.geom('geom1').feature('arr1').set('type', 'linear');
model.geom('geom1').feature('arr1').set('linearsize', 2);
model.geom('geom1').feature('arr1').set('displ', {'0' '0' 'tQz'});
model.geom('geom1').run('arr1');
model.geom('geom1').create('wp3', 'WorkPlane');
model.geom('geom1').feature('wp3').set('unite', true);
model.geom('geom1').feature('wp3').set('quickplane', 'yz');
model.geom('geom1').feature('wp3').set('quickoffsettype', 'vertex');
model.geom('geom1').feature('wp3').selection('offsetvertex').set('ext1', 58);
model.geom('geom1').feature('wp3').geom.create('r1', 'Rectangle');
model.geom('geom1').feature('wp3').geom.feature('r1').set('size', {'l_d*0.8' 'tQz*0.6'});
model.geom('geom1').feature('wp3').geom.feature('r1').set('base', 'center');
model.geom('geom1').feature('wp3').geom.feature('r1').set('pos', {'(l_f+l_d)/2' '0'});
model.geom('geom1').run('wp3');
model.geom('geom1').create('arr2', 'Array');
model.geom('geom1').feature('arr2').selection('input').set({'wp3'});
model.geom('geom1').feature('arr2').set('type', 'linear');
model.geom('geom1').feature('arr2').set('linearsize', 2);
model.geom('geom1').feature('arr2').set('displ', {'-w_d' '0' '0'});
model.geom('geom1').run('arr2');
model.geom('geom1').create('mir1', 'Mirror');
model.geom('geom1').feature('mir1').selection('input').set({'arr2'});
model.geom('geom1').feature('mir1').set('keep', true);
model.geom('geom1').feature('mir1').set('axis', [1 0 0]);
model.geom('geom1').run('mir1');
model.geom('geom1').create('wp4', 'WorkPlane');
model.geom('geom1').feature('wp4').set('unite', true);
model.geom('geom1').feature('wp4').set('quickplane', 'yz');
model.geom('geom1').feature('wp4').set('quickoffsettype', 'vertex');
model.geom('geom1').feature('wp4').selection('offsetvertex').set('ext1', 58);
model.geom('geom1').feature('wp4').geom.create('r1', 'Rectangle');
model.geom('geom1').feature('wp4').geom.feature('r1').set('size', {'l_s*0.8' 'tQz*0.2'});
model.geom('geom1').feature('wp4').geom.feature('r1').set('base', 'center');
model.geom('geom1').feature('wp4').geom.feature('r1').set('pos', {'-(l_f+l_s)/2' '0'});
model.geom('geom1').feature('wp4').geom.feature('r1').setIndex('pos', '-tQz*0.3', 1);
model.geom('geom1').feature('wp4').geom.run('r1');
model.geom('geom1').feature('wp4').geom.create('mir1', 'Mirror');
model.geom('geom1').feature('wp4').geom.feature('mir1').set('keep', true);
model.geom('geom1').feature('wp4').geom.feature('mir1').selection('input').set({'r1'});
model.geom('geom1').feature('wp4').geom.feature('mir1').set('axis', [0 1]);
model.geom('geom1').run('wp4');
model.geom('geom1').create('arr3', 'Array');
model.geom('geom1').feature('arr3').selection('input').set({'wp4'});
model.geom('geom1').feature('arr3').set('type', 'linear');
model.geom('geom1').feature('arr3').set('linearsize', 2);
model.geom('geom1').feature('arr3').set('displ', {'-w_s' '0' '0'});
model.geom('geom1').run('arr3');
model.geom('geom1').create('mir2', 'Mirror');
model.geom('geom1').feature('mir2').selection('input').set({'arr3'});
model.geom('geom1').feature('mir2').set('keep', true);
model.geom('geom1').feature('mir2').set('axis', [1 0 0]);
model.geom('geom1').run('mir2');
model.geom('geom1').create('wp5', 'WorkPlane');
model.geom('geom1').feature('wp5').set('unite', true);
model.geom('geom1').run('wp5');
model.geom('geom1').create('par1', 'Partition');
model.geom('geom1').feature('par1').selection('input').set({'ext1'});
model.geom('geom1').feature('par1').set('partitionwith', 'workplane');
model.geom('geom1').run('par1');
model.geom('geom1').create('wp6', 'WorkPlane');
model.geom('geom1').feature('wp6').set('unite', true);
model.geom('geom1').feature('wp6').set('quickplane', 'yz');
model.geom('geom1').run('wp6');
model.geom('geom1').create('par2', 'Partition');
model.geom('geom1').feature('par2').selection('input').set({'par1'});
model.geom('geom1').feature('par2').set('partitionwith', 'workplane');
model.geom('geom1').runPre('fin');

model.title([]);

model.description('');

model.label('piezoelectric_rate_gyroscope_geom_sequence.mph');

model.modelNode.label('Components');

out = model;
