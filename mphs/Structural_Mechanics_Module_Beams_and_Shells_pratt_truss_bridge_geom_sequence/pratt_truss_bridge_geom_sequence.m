function out = model
%
% pratt_truss_bridge_geom_sequence.m
%
% Model exported on May 26 2025, 21:33 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/Structural_Mechanics_Module/Beams_and_Shells');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 3);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.param.set('width', '7[m]');
model.param.descr('width', 'Width of bridge');
model.param.set('height', '5[m]');
model.param.descr('height', 'Height of bridge');
model.param.set('spacing', '5[m]');
model.param.descr('spacing', 'Spacing between members along the bridge');
model.param.set('length', '40[m]');
model.param.descr('length', 'Total bridge length');

model.geom('geom1').create('wp1', 'WorkPlane');
model.geom('geom1').feature('wp1').set('unite', true);
model.geom('geom1').feature('wp1').geom.create('r1', 'Rectangle');
model.geom('geom1').feature('wp1').geom.feature('r1').set('size', {'spacing' 'width'});
model.geom('geom1').feature('wp1').geom.feature('r1').set('pos', {'-length/2' '0'});
model.geom('geom1').feature('wp1').geom.run('r1');
model.geom('geom1').feature('wp1').geom.create('arr1', 'Array');
model.geom('geom1').feature('wp1').geom.feature('arr1').set('type', 'linear');
model.geom('geom1').feature('wp1').geom.feature('arr1').selection('input').set({'r1'});
model.geom('geom1').feature('wp1').geom.feature('arr1').set('linearsize', 'length/spacing');
model.geom('geom1').feature('wp1').geom.feature('arr1').set('displ', {'spacing' '0'});
model.geom('geom1').feature('wp1').geom.run('arr1');
model.geom('geom1').run('fin');
model.geom('geom1').run('wp1');
model.geom('geom1').create('wp2', 'WorkPlane');
model.geom('geom1').feature('wp2').set('unite', true);
model.geom('geom1').feature('wp2').set('quickplane', 'xz');
model.geom('geom1').feature('wp2').geom.create('pol1', 'Polygon');
model.geom('geom1').feature('wp2').geom.feature('pol1').set('source', 'table');
model.geom('geom1').feature('wp2').geom.feature('pol1').set('type', 'open');
model.geom('geom1').feature('wp2').geom.feature('pol1').set('source', 'vectors');
model.geom('geom1').feature('wp2').geom.feature('pol1').set('x', '0 spacing spacing spacing');
model.geom('geom1').feature('wp2').geom.feature('pol1').set('y', '0 height height 0');
model.geom('geom1').feature('wp2').geom.run('pol1');
model.geom('geom1').feature('wp2').geom.create('ls1', 'LineSegment');
model.geom('geom1').feature('wp2').geom.feature('ls1').set('specify1', 'coord');
model.geom('geom1').feature('wp2').geom.feature('ls1').set('specify2', 'coord');
model.geom('geom1').feature('wp2').geom.feature('ls1').set('coord1', {'0' 'height'});
model.geom('geom1').feature('wp2').geom.feature('ls1').set('coord2', {'spacing' 'height'});
model.geom('geom1').feature('wp2').geom.run('ls1');
model.geom('geom1').feature('wp2').geom.create('arr1', 'Array');
model.geom('geom1').feature('wp2').geom.feature('arr1').set('type', 'linear');
model.geom('geom1').feature('wp2').geom.feature('arr1').selection('input').set({'ls1' 'pol1'});
model.geom('geom1').feature('wp2').geom.feature('arr1').set('linearsize', 'length/(2*spacing)-1');
model.geom('geom1').feature('wp2').geom.feature('arr1').set('displ', {'spacing' '0'});
model.geom('geom1').feature('wp2').geom.run('arr1');
model.geom('geom1').feature('wp2').geom.create('ls2', 'LineSegment');
model.geom('geom1').feature('wp2').geom.feature('ls2').set('specify1', 'coord');
model.geom('geom1').feature('wp2').geom.feature('ls2').set('specify2', 'coord');
model.geom('geom1').feature('wp2').geom.feature('ls2').set('coord1', {'length/2-spacing' '0'});
model.geom('geom1').feature('wp2').geom.feature('ls2').setIndex('coord1', 'height', 1);
model.geom('geom1').feature('wp2').geom.feature('ls2').set('coord2', {'length/2' '0'});
model.geom('geom1').feature('wp2').geom.run('ls2');
model.geom('geom1').feature('wp2').geom.create('mir1', 'Mirror');
model.geom('geom1').feature('wp2').geom.feature('mir1').selection('input').set({'arr1' 'ls2'});
model.geom('geom1').feature('wp2').geom.feature('mir1').set('keep', true);
model.geom('geom1').feature('wp2').geom.run('mir1');
model.geom('geom1').feature('wp2').geom.create('ls3', 'LineSegment');
model.geom('geom1').feature('wp2').geom.feature('ls3').set('specify1', 'coord');
model.geom('geom1').feature('wp2').geom.feature('ls3').set('specify2', 'coord');
model.geom('geom1').feature('wp2').geom.feature('ls3').set('coord2', {'0' 'height'});
model.geom('geom1').feature('wp2').geom.run('ls3');
model.geom('geom1').run('fin');
model.geom('geom1').run('wp2');
model.geom('geom1').create('copy1', 'Copy');
model.geom('geom1').feature('copy1').set('disply', 'width');
model.geom('geom1').feature('copy1').selection('input').set({'wp2'});
model.geom('geom1').runPre('fin');
model.geom('geom1').create('ls1', 'LineSegment');
model.geom('geom1').feature('ls1').set('specify1', 'coord');
model.geom('geom1').feature('ls1').set('specify2', 'coord');
model.geom('geom1').feature('ls1').set('coord1', {'-length/2+spacing' '0' '0'});
model.geom('geom1').feature('ls1').setIndex('coord1', 'height', 2);
model.geom('geom1').feature('ls1').set('coord2', {'-length/2+spacing' '0' '0'});
model.geom('geom1').feature('ls1').setIndex('coord2', 'width', 1);
model.geom('geom1').feature('ls1').setIndex('coord2', 'height', 2);
model.geom('geom1').runPre('fin');
model.geom('geom1').create('arr1', 'Array');
model.geom('geom1').feature('arr1').selection('input').set({'ls1'});
model.geom('geom1').feature('arr1').set('type', 'linear');
model.geom('geom1').feature('arr1').set('displ', {'spacing' '0' '0'});
model.geom('geom1').feature('arr1').set('linearsize', 'length/spacing-1');
model.geom('geom1').runPre('fin');

model.title([]);

model.description('');

model.label('pratt_truss_bridge_geom_sequence.mph');

model.modelNode.label('Components');

out = model;
