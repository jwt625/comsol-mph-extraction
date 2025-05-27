function out = model
%
% pcb_designer_geom_sequence.m
%
% Model exported on May 26 2025, 21:28 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/Electrodeposition_Module/Tutorials');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 3);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

% To import content from file, use:
% model.param.loadFile('FILENAME');
model.param.set('BathWidth', '200[mm]', 'Plating bath width (dimension along x-axis)');
model.param.set('BathDepth', '100[mm]', 'Plating bath depth (dimension along z-axis)');
model.param.set('BathHeight', '200[mm]', 'Plating bath height (dimension along y-axis)');
model.param.set('ApertureWidth', '70[mm]', 'Aperture width (dimension along x-axis)');
model.param.set('ApertureHeight', '70[mm]', 'Aperture height (dimension along y-axis)');
model.param.set('ApertureOffset', '50[mm]', 'Aperture offset to PCB layout (along z-axis)');
model.param.set('ApertureThickness', '1[mm]', 'Aperture thickness (dimension along z-axis)');
model.param.set('PCBxMin', '7.9925[in]', 'Minimum x-coordinate of bounding box of imported PCB layout');
model.param.set('PCBxMax', '11.0075[in]', 'Maximum x-coordinate of bounding box of imported PCB layout');
model.param.set('PCByMin', '8.9925[in]', 'Minimum y-coordinate of bounding box of imported PCB layout');
model.param.set('PCByMax', '11.0075[in]', 'Maximum y-coordinate of bounding box of imported PCB layout');
model.param.set('PCBWidth', 'PCBxMax-PCBxMin', 'Width of imported PCB layout (dimension along x-axis)');
model.param.set('PCBHeight', 'PCByMax-PCByMin', 'Depth of imported PCB layout (dimension along y-axis)');
model.param.set('PCBThickness', '2[mm]', 'Thickness of PCB dielectric material (dimension along z-axis)');
model.param.set('PCBOffset', '10[mm]', 'Offset of PCB copper layout to back wall of plating bath (along z-axis)');
model.param.set('PCBMargin', '1[mm]', 'Margin applied to dielectric outside of imported PCB layout in x- and y-directions');
model.param.set('CopperArea', '0.4262900321[in^2]', 'Area of copper traces from imported PCB layout');
model.param.set('DummyArea', '1.1869299746[in^2]', 'Area of dummy pattern');
model.param.set('CathodeArea', 'CopperArea+DummyArea', 'Cathode area');
model.param.set('AnodeThickness', '10[mm]', 'Anode thickness (dimension along z-axis)');
model.param.set('UseAperture', '1', 'Set to 1 if aperture is used, otherwise set to 0');
model.param.set('UseDummy', '1', 'Set to 1 if dummy pattern is used, otherwise set to 0');

model.geom('geom1').lengthUnit('in');
model.geom('geom1').create('blk1', 'Block');
model.geom('geom1').feature('blk1').label('PCB');
model.geom('geom1').feature('blk1').set('size', {'PCBWidth+2*PCBMargin' '1' '1'});
model.geom('geom1').feature('blk1').setIndex('size', 'PCBHeight+2*PCBMargin', 1);
model.geom('geom1').feature('blk1').setIndex('size', 'PCBThickness', 2);
model.geom('geom1').feature('blk1').set('pos', {'PCBxMin-PCBMargin' '0' '0'});
model.geom('geom1').feature('blk1').setIndex('pos', 'PCByMin-PCBMargin', 1);
model.geom('geom1').feature('blk1').setIndex('pos', 'PCBOffset-PCBThickness', 2);
model.geom('geom1').feature('blk1').set('selresult', true);

model.view('view1').set('transparency', true);

model.geom('geom1').run('blk1');
model.geom('geom1').create('wp1', 'WorkPlane');
model.geom('geom1').feature('wp1').set('unite', true);
model.geom('geom1').feature('wp1').set('quickz', 'PCBOffset');
model.geom('geom1').selection.create('csel1', 'CumulativeSelection');
model.geom('geom1').selection('csel1').label('PCB copper layout');
model.geom('geom1').feature('wp1').set('contributeto', 'csel1');
model.geom('geom1').feature('wp1').geom.create('imp1', 'Import');
model.geom('geom1').feature('wp1').geom.feature('imp1').set('filename', 'example_pcb.tgz');
model.geom('geom1').feature('wp1').geom.feature('imp1').importData;
model.geom('geom1').feature('wp1').geom.feature('imp1').setIndex('importlayer', false, 2);
model.geom('geom1').run('wp1');
model.geom('geom1').create('if1', 'If');
model.geom('geom1').feature.createAfter('endif1', 'EndIf', 'if1');
model.geom('geom1').feature('if1').set('condition', 'UseDummy');
model.geom('geom1').create('wp2', 'WorkPlane');
model.geom('geom1').feature('wp2').set('unite', true);
model.geom('geom1').feature('wp2').set('quickz', 'PCBOffset');
model.geom('geom1').selection.create('csel2', 'CumulativeSelection');
model.geom('geom1').selection('csel2').label('PCB dummy layout');
model.geom('geom1').feature('wp2').set('contributeto', 'csel2');
model.geom('geom1').feature('wp2').geom.create('imp1', 'Import');
model.geom('geom1').feature('wp2').geom.feature('imp1').set('filename', 'example_pcb_dummy_pattern.tgz');
model.geom('geom1').feature('wp2').geom.feature('imp1').importData;
model.geom('geom1').feature('wp2').geom.feature('imp1').setIndex('importlayer', false, 2);
model.geom('geom1').runPre('fin');
model.geom('geom1').create('unisel1', 'UnionSelection');
model.geom('geom1').feature('unisel1').label('Cathode');
model.geom('geom1').feature('unisel1').set('entitydim', -1);
model.geom('geom1').feature('unisel1').set('input', {'csel1' 'csel2'});
model.geom('geom1').run('unisel1');
model.geom('geom1').create('blk2', 'Block');
model.geom('geom1').feature('blk2').label('Bath');
model.geom('geom1').feature('blk2').set('size', {'BathWidth' 'BathHeight' '1'});
model.geom('geom1').feature('blk2').setIndex('size', 'BathDepth', 2);
model.geom('geom1').feature('blk2').set('pos', {'PCBxMin-(BathWidth-PCBWidth)/2' '0' '0'});
model.geom('geom1').feature('blk2').setIndex('pos', 'PCByMin-(BathHeight-PCBHeight)/2', 1);
model.geom('geom1').feature('blk2').set('selresult', true);
model.geom('geom1').run('blk2');
model.geom('geom1').create('blk3', 'Block');
model.geom('geom1').feature('blk3').label('Electrolyte swept mesh region 1');
model.geom('geom1').feature('blk3').set('size', {'BathWidth' 'BathHeight' '1'});
model.geom('geom1').feature('blk3').setIndex('size', 'PCBThickness', 2);
model.geom('geom1').feature('blk3').set('pos', {'PCBxMin-(BathWidth-PCBWidth)/2' '0' '0'});
model.geom('geom1').feature('blk3').setIndex('pos', 'PCByMin-(BathHeight-PCBHeight)/2', 1);
model.geom('geom1').feature('blk3').setIndex('pos', 'PCBOffset-PCBThickness', 2);
model.geom('geom1').feature('blk3').set('selresult', true);
model.geom('geom1').run('blk3');
model.geom('geom1').create('wp3', 'WorkPlane');
model.geom('geom1').feature('wp3').set('unite', true);
model.geom('geom1').feature('wp3').set('planetype', 'faceparallel');
model.geom('geom1').feature('wp3').selection('face').set('blk2', 4);
model.geom('geom1').feature('wp3').geom.create('r1', 'Rectangle');
model.geom('geom1').feature('wp3').geom.feature('r1').set('size', {'BathWidth/6' '1'});
model.geom('geom1').feature('wp3').geom.feature('r1').setIndex('size', 'BathHeight', 1);
model.geom('geom1').feature('wp3').geom.feature('r1').set('pos', {'-BathWidth/2+BathWidth/6/2' '0'});
model.geom('geom1').feature('wp3').geom.feature('r1').setIndex('pos', '-BathHeight/2', 1);
model.geom('geom1').feature('wp3').geom.run('r1');
model.geom('geom1').feature('wp3').geom.create('arr1', 'Array');
model.geom('geom1').feature('wp3').geom.feature('arr1').selection('input').set({'r1'});
model.geom('geom1').feature('wp3').geom.feature('arr1').set('fullsize', [3 1]);
model.geom('geom1').feature('wp3').geom.feature('arr1').set('displ', {'BathWidth/3' '0'});
model.geom('geom1').run('wp3');
model.geom('geom1').feature.create('ext1', 'Extrude');
model.geom('geom1').feature('ext1').set('workplane', 'wp3');
model.geom('geom1').feature('ext1').selection('input').set({'wp3'});
model.geom('geom1').feature('ext1').label('Anode');
model.geom('geom1').feature('ext1').setIndex('distance', 'AnodeThickness', 0);
model.geom('geom1').feature('ext1').set('reverse', true);
model.geom('geom1').feature('ext1').set('selresult', true);
model.geom('geom1').feature('ext1').set('selresultshow', 'bnd');
model.geom('geom1').run('ext1');
model.geom('geom1').create('dif1', 'Difference');
model.geom('geom1').feature('dif1').selection('input').set({'blk2' 'blk3'});
model.geom('geom1').feature('dif1').selection('input2').named('blk1');
model.geom('geom1').feature('dif1').selection('input2').set({'blk1' 'ext1'});
model.geom('geom1').run('dif1');
model.geom('geom1').create('if2', 'If');
model.geom('geom1').feature.createAfter('endif2', 'EndIf', 'if2');
model.geom('geom1').feature('if2').set('condition', 'UseAperture');
model.geom('geom1').create('wp4', 'WorkPlane');
model.geom('geom1').feature('wp4').set('unite', true);
model.geom('geom1').feature('wp4').set('quickz', 'ApertureOffset+PCBOffset');
model.geom('geom1').feature('wp4').geom.create('cro1', 'CrossSection');
model.geom('geom1').feature('wp4').geom.feature('cro1').set('intersect', 'selected');
model.geom('geom1').feature('wp4').geom.feature('cro1').selection('input').named('blk2');
model.geom('geom1').run('wp4');
model.geom('geom1').feature.create('ext2', 'Extrude');
model.geom('geom1').feature('ext2').setIndex('distance', 'ApertureThickness', 0);
model.geom('geom1').run('ext2');
model.geom('geom1').create('dif2', 'Difference');
model.geom('geom1').feature('dif2').selection('input').set({'dif1'});
model.geom('geom1').feature('dif2').selection('input2').set({'ext2'});
model.geom('geom1').run('dif2');
model.geom('geom1').create('wp5', 'WorkPlane');
model.geom('geom1').feature('wp5').set('unite', true);
model.geom('geom1').feature('wp5').label('Aperture source');
model.geom('geom1').feature('wp5').set('quickz', 'ApertureOffset+PCBOffset');
model.geom('geom1').feature('wp5').set('selresult', true);
model.geom('geom1').feature('wp5').geom.create('r1', 'Rectangle');
model.geom('geom1').feature('wp5').geom.feature('r1').set('size', {'ApertureWidth' '1'});
model.geom('geom1').feature('wp5').geom.feature('r1').setIndex('size', 'ApertureHeight', 1);
model.geom('geom1').feature('wp5').geom.feature('r1').set('pos', {'PCBxMin-(BathWidth-PCBWidth)/2+(BathWidth-ApertureWidth)/2' '0'});
model.geom('geom1').feature('wp5').geom.feature('r1').setIndex('pos', 'PCByMin-(BathHeight-PCBHeight)/2+(BathHeight-ApertureHeight)/2', 1);
model.geom('geom1').run('wp5');
model.geom('geom1').feature.create('ext3', 'Extrude');
model.geom('geom1').feature('ext3').label('Aperture');
model.geom('geom1').feature('ext3').setIndex('distance', 'ApertureThickness', 0);
model.geom('geom1').feature('ext3').set('selresult', true);
model.geom('geom1').run('fin');

model.title([]);

model.description('');

model.label('pcb_designer_geom_sequence.mph');

model.modelNode.label('Components');

out = model;
