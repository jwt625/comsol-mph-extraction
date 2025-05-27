function out = model
%
% tesla_microvalve_shape_optimization_geom_sequence.m
%
% Model exported on May 26 2025, 21:30 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/Microfluidics_Module/Fluid_Flow');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 2);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.param.set('D', '0.2[mm]');
model.param.descr('D', 'Characteristic length');
model.param.set('L', '5*D');
model.param.descr('L', 'Channel length');
model.param.set('H', '1.75*D');
model.param.descr('H', 'Channel width');
model.param.set('LT', ['150[' native2unicode(hex2dec({'00' 'b5'}), 'unicode') 'm]']);
model.param.descr('LT', 'First line x and y range');
model.param.set('XT', ['250[' native2unicode(hex2dec({'00' 'b5'}), 'unicode') 'm]']);
model.param.descr('XT', 'First line position');
model.param.set('LT2', 'LT/2');
model.param.descr('LT2', 'Second line x and y range');
model.param.set('XT2', 'XT+LT2');
model.param.descr('XT2', 'Second line position');
model.param.set('X3', ['150[' native2unicode(hex2dec({'00' 'b5'}), 'unicode') 'm]']);
model.param.descr('X3', 'Third line x position');
model.param.set('Y3', 'H/2');
model.param.descr('Y3', 'Third line y position');
model.param.set('L3', ['100[' native2unicode(hex2dec({'00' 'b5'}), 'unicode') 'm]']);
model.param.descr('L3', 'Third line length');
model.param.set('phi1', '-pi/2 [rad]');
model.param.descr('phi1', 'Third line orientation');

model.geom('geom1').lengthUnit('mm');
model.geom('geom1').create('r1', 'Rectangle');
model.geom('geom1').feature('r1').set('size', {'L' 'H'});
model.geom('geom1').run('r1');
model.geom('geom1').create('r2', 'Rectangle');
model.geom('geom1').feature('r2').set('size', {'D/2' 'D/2'});
model.geom('geom1').feature('r2').set('pos', {'-D/2' '0'});
model.geom('geom1').run('r2');
model.geom('geom1').create('r3', 'Rectangle');
model.geom('geom1').run('r3');
model.geom('geom1').feature('r3').set('size', {'D/2' 'D/2'});
model.geom('geom1').feature('r3').set('pos', {'L' '0'});
model.geom('geom1').run('r3');
model.geom('geom1').create('pol1', 'Polygon');
model.geom('geom1').feature('pol1').set('source', 'table');
model.geom('geom1').feature('pol1').setIndex('table', 'L-H+D/2', 0, 0);
model.geom('geom1').feature('pol1').setIndex('table', 'H', 0, 1);
model.geom('geom1').feature('pol1').setIndex('table', 'L', 1, 0);
model.geom('geom1').feature('pol1').setIndex('table', 'D/2', 1, 1);
model.geom('geom1').feature('pol1').setIndex('table', 'L', 2, 0);
model.geom('geom1').feature('pol1').setIndex('table', 'H', 2, 1);
model.geom('geom1').run('pol1');
model.geom('geom1').create('ls1', 'LineSegment');
model.geom('geom1').feature('ls1').set('specify1', 'coord');
model.geom('geom1').feature('ls1').set('coord1', {'XT' '0'});
model.geom('geom1').feature('ls1').set('specify2', 'coord');
model.geom('geom1').feature('ls1').set('coord2', {'XT+LT' 'LT'});
model.geom('geom1').feature('ls1').set('selresult', true);
model.geom('geom1').run('ls1');
model.geom('geom1').create('ls2', 'LineSegment');
model.geom('geom1').feature('ls2').set('specify1', 'coord');
model.geom('geom1').feature('ls2').set('coord1', {'XT2' 'H'});
model.geom('geom1').feature('ls2').set('specify2', 'coord');
model.geom('geom1').feature('ls2').set('coord2', {'XT2+LT2' 'H-LT2'});
model.geom('geom1').feature('ls2').set('selresult', true);
model.geom('geom1').run('ls2');
model.geom('geom1').create('ls3', 'LineSegment');
model.geom('geom1').feature('ls3').set('specify1', 'coord');
model.geom('geom1').feature('ls3').set('coord1', {'X1+L1*cos(phi1)/2' '0'});
model.geom('geom1').feature('ls3').setIndex('coord1', 'Y3+L3*sin(phi1)/2', 1);
model.geom('geom1').feature('ls3').setIndex('coord1', 'X3+L3*cos(phi1)/2', 0);
model.geom('geom1').feature('ls3').set('specify2', 'coord');
model.geom('geom1').feature('ls3').set('coord2', {'X3-L3*cos(phi1)/2' '0'});
model.geom('geom1').feature('ls3').setIndex('coord2', 'Y3-L3*sin(phi1)/2', 1);
model.geom('geom1').feature('ls3').set('selresult', true);
model.geom('geom1').run('ls3');
model.geom('geom1').create('dif1', 'Difference');
model.geom('geom1').feature('dif1').selection('input').set({'r1'});
model.geom('geom1').feature('dif1').selection('input2').set({'pol1'});
model.geom('geom1').run('dif1');
model.geom('geom1').create('boxsel1', 'BoxSelection');
model.geom('geom1').feature('boxsel1').label('Symmetry');
model.geom('geom1').feature('boxsel1').set('entitydim', 1);
model.geom('geom1').feature('boxsel1').set('ymax', '1e3*eps');
model.geom('geom1').feature('boxsel1').set('condition', 'inside');
model.geom('geom1').run('boxsel1');
model.geom('geom1').create('boxsel2', 'BoxSelection');
model.geom('geom1').feature('boxsel2').label('Left');
model.geom('geom1').feature('boxsel2').set('entitydim', 1);
model.geom('geom1').feature('boxsel2').set('xmax', '-D/2+1e3*eps');
model.geom('geom1').feature('boxsel2').set('condition', 'inside');
model.geom('geom1').run('boxsel2');
model.geom('geom1').create('boxsel3', 'BoxSelection');
model.geom('geom1').feature('boxsel3').label('Right');
model.geom('geom1').feature('boxsel3').set('entitydim', 1);
model.geom('geom1').feature('boxsel3').set('xmin', 'L+D/2-1e3*eps');
model.geom('geom1').feature('boxsel3').set('condition', 'inside');
model.geom('geom1').run('boxsel3');
model.geom('geom1').create('boxsel4', 'BoxSelection');
model.geom('geom1').feature('boxsel4').label('Top');
model.geom('geom1').feature('boxsel4').set('entitydim', 1);
model.geom('geom1').feature('boxsel4').set('ymin', 'H*0.999');
model.geom('geom1').feature('boxsel4').set('condition', 'inside');
model.geom('geom1').run('boxsel4');
model.geom('geom1').create('unisel1', 'UnionSelection');
model.geom('geom1').feature('unisel1').label('Interior Walls');
model.geom('geom1').feature('unisel1').set('entitydim', 1);
model.geom('geom1').feature('unisel1').set('input', {'ls1' 'ls2' 'ls3'});
model.geom('geom1').run('unisel1');
model.geom('geom1').create('unisel2', 'UnionSelection');
model.geom('geom1').feature('unisel2').set('entitydim', 1);
model.geom('geom1').feature('unisel2').label('Top and Bottom');
model.geom('geom1').feature('unisel2').set('input', {'boxsel1' 'boxsel4'});
model.geom('geom1').run('fin');

model.title([]);

model.description('');

model.label('tesla_microvalve_shape_optimization_geom_sequence.mph');

model.modelNode.label('Components');

out = model;
