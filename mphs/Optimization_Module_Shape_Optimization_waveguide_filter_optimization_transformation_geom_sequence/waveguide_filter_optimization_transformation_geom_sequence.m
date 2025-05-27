function out = model
%
% waveguide_filter_optimization_transformation_geom_sequence.m
%
% Model exported on May 26 2025, 21:31 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/Optimization_Module/Shape_Optimization');

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
model.geom('geom1').feature('r1').set('size', {'2*l_wg+cavities*spacing' '1'});
model.geom('geom1').feature('r1').setIndex('size', 'w_wg/2', 1);
model.geom('geom1').feature('r1').set('pos', {'-l_wg-cavities/2*spacing' '0'});
model.geom('geom1').feature('r1').set('selresult', true);
model.geom('geom1').run('r1');
model.geom('geom1').create('r2', 'Rectangle');
model.geom('geom1').feature('r2').set('size', {'w_wg/12' 'w_wg/4'});
model.geom('geom1').feature('r2').set('pos', {'-l_wg-w_wg/24' '0'});
model.geom('geom1').feature('r2').setIndex('pos', 'w_wg/4', 1);
model.geom('geom1').feature('r2').set('selresult', true);
model.geom('geom1').run('r2');
model.geom('geom1').create('arr1', 'Array');
model.geom('geom1').feature('arr1').selection('input').named('r2');
model.geom('geom1').feature('arr1').set('fullsize', {'cavities+1' '1'});
model.geom('geom1').feature('arr1').set('displ', {'spacing' '0'});
model.geom('geom1').run('arr1');
model.geom('geom1').create('dif1', 'Difference');
model.geom('geom1').feature('dif1').selection('input').named('r1');
model.geom('geom1').feature('dif1').selection('input2').named('r2');
model.geom('geom1').run('dif1');
model.geom('geom1').create('boxsel1', 'BoxSelection');
model.geom('geom1').feature('boxsel1').label('Symmetry');
model.geom('geom1').feature('boxsel1').set('entitydim', 1);
model.geom('geom1').feature('boxsel1').set('ymin', 'w_wg/2.1');
model.geom('geom1').feature('boxsel1').set('condition', 'inside');
model.geom('geom1').run('boxsel1');
model.geom('geom1').create('mir1', 'Mirror');
model.geom('geom1').feature('mir1').selection('input').named('r1');
model.geom('geom1').feature('mir1').set('keep', true);
model.geom('geom1').feature('mir1').set('axis', [0 1]);
model.geom('geom1').run('mir1');
model.geom('geom1').create('uni1', 'Union');
model.geom('geom1').feature('uni1').selection('input').named('r1');
model.geom('geom1').feature('uni1').set('selresult', true);
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
model.geom('geom1').feature('adjsel1').set('input', {'uni1'});
model.geom('geom1').run('adjsel1');
model.geom('geom1').create('boxsel2', 'BoxSelection');
model.geom('geom1').feature('boxsel2').label('Control Boundaries');
model.geom('geom1').feature('boxsel2').set('entitydim', 1);
model.geom('geom1').feature('boxsel2').set('xmin', '-spacing/10');
model.geom('geom1').feature('boxsel2').set('xmax', 'l_wg+cavities*spacing/2.1');
model.geom('geom1').feature('boxsel2').set('ymin', 0);
model.geom('geom1').feature('boxsel2').set('ymax', 'w_wg/2.1');
model.geom('geom1').feature('boxsel2').set('inputent', 'selections');
model.geom('geom1').feature('boxsel2').set('input', {'adjsel1'});
model.geom('geom1').run('boxsel2');
model.geom('geom1').create('boxsel3', 'BoxSelection');
model.geom('geom1').feature('boxsel3').label('Port 1');
model.geom('geom1').feature('boxsel3').set('entitydim', 1);
model.geom('geom1').feature('boxsel3').set('xmax', '-l_wg-cavities*spacing/2.1');
model.geom('geom1').feature('boxsel3').set('condition', 'inside');
model.geom('geom1').feature.duplicate('boxsel4', 'boxsel3');
model.geom('geom1').feature('boxsel4').label('Port 2');
model.geom('geom1').feature('boxsel4').set('xmin', 'l_wg+cavities*spacing/2.1');
model.geom('geom1').feature('boxsel4').set('xmax', Inf);
model.geom('geom1').run('fin');
model.geom('geom1').create('boxsel5', 'BoxSelection');
model.geom('geom1').feature('boxsel5').label('Free Shape Domain');
model.geom('geom1').feature('boxsel5').set('xmin', '-w_wg*0.001');
model.geom('geom1').feature('boxsel5').set('ymin', '-w_wg*0.001');
model.geom('geom1').feature('boxsel5').set('condition', 'inside');
model.geom('geom1').run('boxsel5');
model.geom('geom1').create('comsel1', 'ComplementSelection');
model.geom('geom1').feature('comsel1').label('Sector Symmetry');
model.geom('geom1').feature('comsel1').set('input', {'boxsel5'});
model.geom('geom1').run('comsel1');
model.geom('geom1').create('boxsel6', 'BoxSelection');
model.geom('geom1').feature('boxsel6').label('Center Line');
model.geom('geom1').feature('boxsel6').set('entitydim', 1);
model.geom('geom1').feature('boxsel6').set('ymin', '-0.001*w_wg');
model.geom('geom1').feature('boxsel6').set('ymax', '0.001*w_wg');
model.geom('geom1').feature('boxsel6').set('condition', 'inside');
model.geom('geom1').run('boxsel6');
model.geom('geom1').create('unisel1', 'UnionSelection');
model.geom('geom1').feature('unisel1').set('entitydim', 1);
model.geom('geom1').feature('unisel1').label('Symmetry/Roller');
model.geom('geom1').feature('unisel1').set('input', {'boxsel1' 'ls1' 'boxsel6'});

model.title([]);

model.description('');

model.label('waveguide_filter_optimization_transformation_geom_sequence.mph');

model.modelNode.label('Components');

out = model;
