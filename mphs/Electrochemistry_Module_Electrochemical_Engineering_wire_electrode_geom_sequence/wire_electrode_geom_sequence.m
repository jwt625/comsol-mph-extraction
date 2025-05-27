function out = model
%
% wire_electrode_geom_sequence.m
%
% Model exported on May 26 2025, 21:28 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/Electrochemistry_Module/Electrochemical_Engineering');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 3);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.geom('geom1').lengthUnit('mm');
model.geom('geom1').create('blk1', 'Block');

model.view('view1').set('renderwireframe', true);

model.geom('geom1').feature('blk1').set('size', [22 8 5]);
model.geom('geom1').feature('blk1').set('pos', [-11 -4 0]);
model.geom('geom1').selection.create('csel1', 'CumulativeSelection');
model.geom('geom1').selection('csel1').label('Union');
model.geom('geom1').run('blk1');
model.geom('geom1').create('wp1', 'WorkPlane');
model.geom('geom1').feature('wp1').set('unite', true);
model.geom('geom1').feature('wp1').set('quickz', -1);
model.geom('geom1').feature('wp1').geom.create('sq1', 'Square');
model.geom('geom1').feature('wp1').geom.feature('sq1').set('size', 2);
model.geom('geom1').feature('wp1').geom.feature('sq1').set('pos', [-6 -1]);
model.geom('geom1').feature('wp1').geom.feature('sq1').set('selresult', true);
model.geom('geom1').feature('wp1').geom.run('sq1');
model.geom('geom1').feature('wp1').geom.create('fil1', 'Fillet');
model.geom('geom1').feature('wp1').geom.feature('fil1').selection('pointinsketch').set('sq1', [1 2 3 4]);
model.geom('geom1').feature('wp1').geom.feature('fil1').set('radius', 0.5);
model.geom('geom1').feature('wp1').geom.feature('fil1').set('selresult', true);
model.geom('geom1').feature('wp1').geom.run('fil1');
model.geom('geom1').feature('wp1').geom.create('arr1', 'Array');
model.geom('geom1').feature('wp1').geom.feature('arr1').selection('input').set({'fil1'});
model.geom('geom1').feature('wp1').geom.feature('arr1').set('fullsize', [3 1]);
model.geom('geom1').feature('wp1').geom.feature('arr1').set('displ', [5 0]);
model.geom('geom1').run('wp1');
model.geom('geom1').feature.create('ext1', 'Extrude');
model.geom('geom1').feature('ext1').setIndex('distance', 6, 0);
model.geom('geom1').feature('ext1').set('contributeto', 'csel1');
model.geom('geom1').run('ext1');
model.geom('geom1').create('wp2', 'WorkPlane');
model.geom('geom1').feature('wp2').set('unite', true);
model.geom('geom1').feature('wp2').set('quickplane', 'yz');
model.geom('geom1').feature('wp2').set('quickx', 11);
model.geom('geom1').feature('wp2').geom.create('sq1', 'Square');
model.geom('geom1').feature('wp2').geom.feature('sq1').set('size', 2);
model.geom('geom1').feature('wp2').geom.feature('sq1').set('base', 'center');
model.geom('geom1').feature('wp2').geom.feature('sq1').set('selresult', true);
model.geom('geom1').feature('wp2').geom.run('sq1');
model.geom('geom1').feature('wp2').geom.create('fil1', 'Fillet');
model.geom('geom1').feature('wp2').geom.feature('fil1').selection('pointinsketch').set('sq1', [1 2 3 4]);
model.geom('geom1').feature('wp2').geom.feature('fil1').set('radius', 0.5);
model.geom('geom1').run('wp2');
model.geom('geom1').feature.create('ext2', 'Extrude');
model.geom('geom1').feature('ext2').setIndex('distance', 22, 0);
model.geom('geom1').feature('ext2').set('reverse', true);
model.geom('geom1').feature('ext2').set('contributeto', 'csel1');
model.geom('geom1').run('ext2');
model.geom('geom1').create('uni1', 'Union');
model.geom('geom1').feature('uni1').selection('input').named('csel1');
model.geom('geom1').run('uni1');
model.geom('geom1').create('del1', 'Delete');
model.geom('geom1').feature('del1').selection('input').init(3);
model.geom('geom1').feature('del1').selection('input').set('uni1', [1 16]);
model.geom('geom1').feature('del1').set('selresult', true);
model.geom('geom1').run('del1');
model.geom('geom1').create('uni2', 'Union');
model.geom('geom1').feature('uni2').selection('input').named('del1');
model.geom('geom1').run('uni2');
model.geom('geom1').create('dif1', 'Difference');
model.geom('geom1').feature('dif1').selection('input').set({'blk1'});
model.geom('geom1').feature('uni2').set('selresult', true);
model.geom('geom1').feature('dif1').selection('input2').named('uni2');
model.geom('geom1').run('dif1');
model.geom('geom1').create('boxsel1', 'BoxSelection');
model.geom('geom1').feature('boxsel1').set('entitydim', 2);
model.geom('geom1').feature('boxsel1').set('xmin', -60);
model.geom('geom1').feature('boxsel1').set('xmax', 60);
model.geom('geom1').feature('boxsel1').set('ymin', -2);
model.geom('geom1').feature('boxsel1').set('ymax', 2);
model.geom('geom1').run('boxsel1');
model.geom('geom1').create('sel1', 'ExplicitSelection');
model.geom('geom1').feature('sel1').label('Cathodes');
model.geom('geom1').feature('sel1').selection('selection').init(2);
model.geom('geom1').feature('boxsel1').label('Anode');
model.geom('geom1').feature('boxsel1').set('condition', 'inside');
model.geom('geom1').runPre('sel1');
model.geom('geom1').feature('sel1').selection('selection').set('dif1', [2 5]);
model.geom('geom1').feature.move('sel1', 11);
model.geom('geom1').feature.move('boxsel1', 10);
model.geom('geom1').run('boxsel1');
model.geom('geom1').create('sel2', 'ExplicitSelection');
model.geom('geom1').feature('sel2').label('Inlet');
model.geom('geom1').feature('sel2').selection('selection').init(2);
model.geom('geom1').feature('sel2').selection('selection').set('fin', 1);
model.geom('geom1').feature.move('sel1', 11);
model.geom('geom1').run('sel2');
model.geom('geom1').create('sel3', 'ExplicitSelection');
model.geom('geom1').feature('sel3').label('Outlet');
model.geom('geom1').feature('sel3').selection('selection').init(2);
model.geom('geom1').feature('sel3').selection('selection').set('fin', 52);
model.geom('geom1').run('sel3');

model.title([]);

model.description('');

model.label('wire_electrode_geom_sequence.mph');

model.modelNode.label('Components');

out = model;
