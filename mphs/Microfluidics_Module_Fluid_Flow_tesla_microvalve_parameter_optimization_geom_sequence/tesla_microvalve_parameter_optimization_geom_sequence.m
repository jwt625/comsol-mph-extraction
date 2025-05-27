function out = model
%
% tesla_microvalve_parameter_optimization_geom_sequence.m
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

model.param.set('L', '1[mm]');
model.param.descr('L', 'Channel length');
model.param.set('D', '0.2[mm]');
model.param.descr('D', 'Characteristic dimension');
model.param.set('H', '1.75*D');
model.param.descr('H', 'Channel width');
model.param.set('tol', ['10[' native2unicode(hex2dec({'00' 'b5'}), 'unicode') 'm]']);
model.param.descr('tol', 'length tolerance');
model.param.set('error', '0[m]');
model.param.descr('error', '+/- tol');
model.param.set('aLT', '0.4');
model.param.descr('aLT', 'Triangle size parameter (0<aLT<1)');
model.param.set('LT', '(H-8*tol)*aLT');
model.param.descr('LT', 'Triangle length and width');
model.param.set('aXT', '0.5');
model.param.descr('aXT', 'Triangle position parameter (a<aXT<1)');
model.param.set('XT', 'R+5*tol+(L-LT-R-5*tol)*aXT');
model.param.descr('XT', 'Triangle position');
model.param.set('YC', '0.5*(LT+H-R)');
model.param.descr('YC', 'Middle circle Y position');
model.param.set('aRC', '1');
model.param.descr('aRC', 'Middle circle radius parameter (0<aRC<1)');
model.param.set('RC', '(H-LT-R-2*tol)/2*aRC');
model.param.descr('RC', 'Middle circle radius');
model.param.set('aR', '0.4');
model.param.descr('aR', 'Upper circle radius parameter (0<aR<1)');
model.param.set('R', '(H-LT-3*tol)*aR');
model.param.descr('R', 'Upper half circle radius');
model.param.set('XC', 'max(XT/2,RC+2*tol)');
model.param.descr('XC', 'Middle circle X position');

model.geom('geom1').lengthUnit('mm');
model.geom('geom1').create('r1', 'Rectangle');
model.geom('geom1').feature('r1').set('size', {'1' 'H'});
model.geom('geom1').run('r1');
model.geom('geom1').create('r2', 'Rectangle');
model.geom('geom1').feature('r2').set('size', {'D/2' 'D/2'});
model.geom('geom1').feature('r2').set('pos', {'-D/2' '0'});
model.geom('geom1').run('r2');
model.geom('geom1').create('r3', 'Rectangle');
model.geom('geom1').feature('r3').set('pos', {'L' '0'});
model.geom('geom1').feature('r3').set('size', {'D/2' 'D/2'});
model.geom('geom1').run('r3');
model.geom('geom1').create('pol1', 'Polygon');
model.geom('geom1').feature('pol1').set('source', 'table');
model.geom('geom1').feature('pol1').setIndex('table', 'XT', 0, 0);
model.geom('geom1').feature('pol1').setIndex('table', 0, 0, 1);
model.geom('geom1').feature('pol1').setIndex('table', 'XT+LT', 1, 0);
model.geom('geom1').feature('pol1').setIndex('table', 'LT', 1, 1);
model.geom('geom1').feature('pol1').setIndex('table', 'XT+LT', 2, 0);
model.geom('geom1').feature('pol1').setIndex('table', 0, 2, 1);
model.geom('geom1').run('pol1');
model.geom('geom1').create('sca1', 'Scale');
model.geom('geom1').feature('sca1').selection('input').set({'pol1'});
model.geom('geom1').feature('sca1').set('isotropic', '(LT/2+error)/LT*2');
model.geom('geom1').feature('sca1').set('pos', {'XT+LT/2' '0'});
model.geom('geom1').run('sca1');
model.geom('geom1').create('c1', 'Circle');
model.geom('geom1').feature('c1').set('pos', {'XT+LT-R' '0'});
model.geom('geom1').feature('c1').set('r', 'R');
model.geom('geom1').feature('c1').set('pos', {'XT+LT-R' 'H'});
model.geom('geom1').run('c1');
model.geom('geom1').create('sca2', 'Scale');
model.geom('geom1').feature('sca2').selection('input').set({'c1'});
model.geom('geom1').feature('sca2').set('isotropic', '(R+error)/R');
model.geom('geom1').feature('sca2').set('pos', {'XT+LT-R' 'H'});
model.geom('geom1').run('sca2');
model.geom('geom1').create('c2', 'Circle');
model.geom('geom1').feature('c2').set('r', 'RC');
model.geom('geom1').feature('c2').set('pos', {'XC' 'YC'});
model.geom('geom1').run('c2');
model.geom('geom1').create('sca3', 'Scale');
model.geom('geom1').feature('sca3').selection('input').set({'c2'});
model.geom('geom1').feature('sca3').set('isotropic', '(RC+error)/RC');
model.geom('geom1').feature('sca3').set('pos', {'XC' 'YC'});
model.geom('geom1').run('sca3');
model.geom('geom1').create('pol2', 'Polygon');
model.geom('geom1').feature('pol2').set('source', 'table');
model.geom('geom1').feature('pol2').setIndex('table', 'L', 0, 0);
model.geom('geom1').feature('pol2').setIndex('table', 'D/2', 0, 1);
model.geom('geom1').feature('pol2').setIndex('table', 'L', 1, 0);
model.geom('geom1').feature('pol2').setIndex('table', 'H', 1, 1);
model.geom('geom1').feature('pol2').setIndex('table', 'L-H+D/2', 2, 0);
model.geom('geom1').feature('pol2').setIndex('table', 'H', 2, 1);
model.geom('geom1').run('pol2');
model.geom('geom1').create('dif1', 'Difference');
model.geom('geom1').feature('dif1').selection('input').set({'r1'});
model.geom('geom1').feature('dif1').selection('input2').set({'pol2' 'sca1' 'sca2' 'sca3'});
model.geom('geom1').run('dif1');
model.geom('geom1').create('boxsel1', 'BoxSelection');
model.geom('geom1').feature('boxsel1').label('Right');
model.geom('geom1').feature('boxsel1').set('entitydim', 1);
model.geom('geom1').feature('boxsel1').set('xmin', 'L+D/2-1e3*eps');
model.geom('geom1').feature('boxsel1').set('condition', 'inside');
model.geom('geom1').run('boxsel1');
model.geom('geom1').create('boxsel2', 'BoxSelection');
model.geom('geom1').feature('boxsel2').label('Left');
model.geom('geom1').feature('boxsel2').set('entitydim', 1);
model.geom('geom1').feature('boxsel2').set('xmax', '-D/2+1e3*eps');
model.geom('geom1').feature('boxsel2').set('condition', 'inside');
model.geom('geom1').run('boxsel2');
model.geom('geom1').create('boxsel3', 'BoxSelection');
model.geom('geom1').feature('boxsel3').set('entitydim', 1);
model.geom('geom1').feature('boxsel3').label('Symmetry');
model.geom('geom1').feature('boxsel3').set('xmax', '1e3*eps');
model.geom('geom1').feature('boxsel3').set('condition', 'inside');
model.geom('geom1').feature('boxsel3').set('xmax', Inf);
model.geom('geom1').feature('boxsel3').set('ymax', '1e3*eps');
model.geom('geom1').runPre('fin');
model.geom('geom1').run('fin');

model.title([]);

model.description('');

model.label('tesla_microvalve_parameter_optimization_geom_sequence.mph');

model.modelNode.label('Components');

out = model;
