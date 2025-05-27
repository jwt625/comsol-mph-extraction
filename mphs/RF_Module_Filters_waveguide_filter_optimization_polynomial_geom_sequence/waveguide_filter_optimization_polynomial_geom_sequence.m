function out = model
%
% waveguide_filter_optimization_polynomial_geom_sequence.m
%
% Model exported on May 26 2025, 21:32 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/RF_Module/Filters');

model.param.set('h_wg', '1[cm]');
model.param.descr('h_wg', 'Waveguide width');
model.param.set('w_wg', '2*h_wg');
model.param.descr('w_wg', 'Waveguide width');
model.param.set('spacing', 'w_wg');
model.param.descr('spacing', 'Cavity spacing');
model.param.set('cavities', '3');
model.param.descr('cavities', 'Number of cavities');
model.param.set('l_wg', '1.5*w_wg');
model.param.descr('l_wg', 'Port distance to cavities');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 2);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.geom('geom1').lengthUnit('mm');
model.geom('geom1').create('r1', 'Rectangle');
model.geom('geom1').feature('r1').set('size', {'l_wg' 'w_wg/2'});
model.geom('geom1').feature('r1').set('pos', {'-l_wg-cavities/2*spacing' '0'});
model.geom('geom1').feature('r1').set('selresult', true);
model.geom('geom1').feature.duplicate('r2', 'r1');
model.geom('geom1').feature('r2').set('pos', {'cavities/2*spacing' '0'});
model.geom('geom1').run('r2');
model.geom('geom1').create('r3', 'Rectangle');
model.geom('geom1').feature('r3').set('size', {'spacing' 'w_wg/2'});
model.geom('geom1').feature('r3').set('pos', {'-spacing*cavities/2' '0'});
model.geom('geom1').feature('r3').set('selresult', true);
model.geom('geom1').run('r3');
model.geom('geom1').create('arr1', 'Array');
model.geom('geom1').feature('arr1').selection('input').named('r3');
model.geom('geom1').feature('arr1').set('fullsize', {'cavities' '1'});
model.geom('geom1').feature('arr1').set('displ', {'spacing' '0'});
model.geom('geom1').run('arr1');
model.geom('geom1').create('boxsel1', 'BoxSelection');
model.geom('geom1').feature('boxsel1').label('Chamfer Points');
model.geom('geom1').feature('boxsel1').set('entitydim', 0);
model.geom('geom1').feature('boxsel1').set('xmin', '-l_wg-cavities*spacing/2.1');
model.geom('geom1').feature('boxsel1').set('xmax', 'l_wg+cavities*spacing/2.1');
model.geom('geom1').feature('boxsel1').set('ymin', 'w_wg/4');
model.geom('geom1').run('boxsel1');
model.geom('geom1').create('cha1', 'Chamfer');
model.geom('geom1').feature('cha1').selection('point').named('boxsel1');
model.geom('geom1').feature('cha1').set('dist', 'w_wg/4');
model.geom('geom1').feature('cha1').set('selresult', true);
model.geom('geom1').run('cha1');
model.geom('geom1').create('boxsel2', 'BoxSelection');
model.geom('geom1').feature('boxsel2').label('Symmetry');
model.geom('geom1').feature('boxsel2').set('entitydim', 1);
model.geom('geom1').feature('boxsel2').set('ymin', 'w_wg/2.1');
model.geom('geom1').feature('boxsel2').set('condition', 'inside');
model.geom('geom1').run('boxsel2');
model.geom('geom1').create('mir1', 'Mirror');
model.geom('geom1').feature('mir1').selection('input').named('cha1');
model.geom('geom1').feature('mir1').set('keep', true);
model.geom('geom1').feature('mir1').set('axis', [0 1]);
model.geom('geom1').run('mir1');
model.geom('geom1').create('uni1', 'Union');
model.geom('geom1').feature('uni1').selection('input').named('cha1');
model.geom('geom1').run('uni1');
model.geom('geom1').create('ls1', 'LineSegment');
model.geom('geom1').feature('ls1').set('specify1', 'coord');
model.geom('geom1').feature('ls1').set('coord1', {'0' '-w_wg/2'});
model.geom('geom1').feature('ls1').set('specify2', 'coord');
model.geom('geom1').feature('ls1').set('coord2', {'0' 'w_wg/2'});
model.geom('geom1').feature('ls1').set('selresult', true);
model.geom('geom1').run('ls1');
model.geom('geom1').create('adjsel1', 'AdjacentSelection');
model.geom('geom1').feature('adjsel1').label('Exterior Boundaries');
model.geom('geom1').feature('adjsel1').set('input', {'cha1'});
model.geom('geom1').run('adjsel1');
model.geom('geom1').create('boxsel3', 'BoxSelection');
model.geom('geom1').feature('boxsel3').label('Moving Boundaries');
model.geom('geom1').feature('boxsel3').set('entitydim', 1);
model.geom('geom1').feature('boxsel3').set('xmin', '-spacing/10');
model.geom('geom1').feature('boxsel3').set('xmax', 'l_wg+cavities*spacing/2.1');
model.geom('geom1').feature('boxsel3').set('ymin', 0);
model.geom('geom1').feature('boxsel3').set('ymax', 'w_wg/2.1');
model.geom('geom1').feature('boxsel3').set('inputent', 'selections');
model.geom('geom1').feature('boxsel3').set('input', {'adjsel1'});
model.geom('geom1').run('boxsel3');
model.geom('geom1').create('boxsel4', 'BoxSelection');
model.geom('geom1').feature('boxsel4').label('Port 1');
model.geom('geom1').feature('boxsel4').set('entitydim', 1);
model.geom('geom1').feature('boxsel4').set('xmax', '-l_wg-cavities*spacing/2.1');
model.geom('geom1').feature('boxsel4').set('condition', 'inside');
model.geom('geom1').feature.duplicate('boxsel5', 'boxsel4');
model.geom('geom1').feature('boxsel5').label('Port 2');
model.geom('geom1').feature('boxsel5').set('xmax', Inf);
model.geom('geom1').feature('boxsel5').set('xmin', 'l_wg+cavities*spacing/2.1');
model.geom('geom1').run('fin');
model.geom('geom1').create('boxsel6', 'BoxSelection');
model.geom('geom1').feature('boxsel6').label('Free Shape Domain');
model.geom('geom1').feature('boxsel6').set('xmin', '-w_wg*0.001');
model.geom('geom1').feature('boxsel6').set('ymin', '-w_wg*0.001');
model.geom('geom1').feature('boxsel6').set('condition', 'inside');
model.geom('geom1').run('boxsel6');
model.geom('geom1').create('comsel1', 'ComplementSelection');
model.geom('geom1').feature('comsel1').label('Sector Symmetry');
model.geom('geom1').feature('comsel1').set('input', {'boxsel6'});
model.geom('geom1').run('comsel1');
model.geom('geom1').create('boxsel7', 'BoxSelection');
model.geom('geom1').feature('boxsel7').label('Center Line');
model.geom('geom1').feature('boxsel7').set('entitydim', 1);
model.geom('geom1').feature('boxsel7').set('ymin', '-0.001*w_wg');
model.geom('geom1').feature('boxsel7').set('ymax', '0.001*w_wg');
model.geom('geom1').feature('boxsel7').set('condition', 'inside');
model.geom('geom1').run('boxsel7');
model.geom('geom1').create('unisel1', 'UnionSelection');
model.geom('geom1').feature('unisel1').set('entitydim', 1);
model.geom('geom1').feature('unisel1').label('Symmetry/Roller');
model.geom('geom1').feature('unisel1').set('input', {'boxsel2' 'ls1' 'boxsel7'});

model.title([]);

model.description('');

model.label('waveguide_filter_optimization_polynomial_geom_sequence.mph');

model.modelNode.label('Components');

out = model;
