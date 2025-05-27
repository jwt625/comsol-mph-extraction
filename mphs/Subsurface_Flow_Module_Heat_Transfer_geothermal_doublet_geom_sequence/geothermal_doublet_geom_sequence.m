function out = model
%
% geothermal_doublet_geom_sequence.m
%
% Model exported on May 26 2025, 21:34 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/Subsurface_Flow_Module/Heat_Transfer');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 3);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.param.set('r_bore', '1[m]');
model.param.descr('r_bore', 'Borehole skin zone radius');
model.param.set('l_well', '20[m]');
model.param.descr('l_well', 'Well length');
model.param.set('length', '500[m]');
model.param.descr('length', 'Domain size');
model.param.set('depth_w', '-900[m]');
model.param.descr('depth_w', 'Well depth');
model.param.set('alpha', '10[deg]');
model.param.descr('alpha', 'Well inclination');
model.param.set('dist', '250[m]');
model.param.descr('dist', 'Lateral well distance');
model.param.set('depth', '-length-650[m]');
model.param.descr('depth', 'Reservoir depth');

model.func.create('int1', 'Interpolation');
model.func('int1').model('comp1');
model.func('int1').set('source', 'file');
model.func('int1').set('filename', 'geothermal_doublet_geom_sequence_interpolation.txt');

model.geom('geom1').create('blk1', 'Block');
model.geom('geom1').feature('blk1').set('size', {'length' 'length' '1'});
model.geom('geom1').feature('blk1').setIndex('size', 'length', 2);
model.geom('geom1').feature('blk1').set('pos', {'0' '0' '-length-650[m]'});
model.geom('geom1').run('blk1');
model.geom('geom1').create('ps1', 'ParametricSurface');
model.geom('geom1').feature('ps1').set('parmax1', 10);
model.geom('geom1').feature('ps1').set('parmax2', 10);
model.geom('geom1').feature('ps1').set('coord', {'50*s1' '50*s2' '30*int1(s1,s2)+depth+300'});
model.geom('geom1').feature('ps1').set('rtol', '5e-2');
model.geom('geom1').feature('ps1').set('maxknots', 200);
model.geom('geom1').feature.duplicate('ps2', 'ps1');
model.geom('geom1').feature('ps2').set('coord', {'50*s1' '50*s2' '60*int1(s1,s2)+depth+100'});
model.geom('geom1').feature.duplicate('ps3', 'ps2');
model.geom('geom1').feature('ps3').set('coord', {'50*s1' '50*s2' '15*int1(s1,s2)+depth'});
model.geom('geom1').feature.duplicate('ps4', 'ps3');
model.geom('geom1').feature('ps4').set('coord', {'50*s1' '50*s2' '17*int1(s1,s2)+depth+425'});
model.geom('geom1').runPre('fin');
model.geom('geom1').create('par1', 'Partition');
model.geom('geom1').feature('par1').selection('input').set({'blk1'});
model.geom('geom1').feature('par1').selection('tool').set({'ps1' 'ps2' 'ps3' 'ps4'});
model.geom('geom1').runPre('fin');
model.geom('geom1').create('del1', 'Delete');
model.geom('geom1').feature('del1').selection('input').init(3);
model.geom('geom1').feature('del1').selection('input').set('par1', [1 5]);
model.geom('geom1').runPre('fin');
model.geom('geom1').create('ps5', 'ParametricSurface');
model.geom('geom1').feature('ps5').set('parmax1', 20);
model.geom('geom1').feature('ps5').set('parmin2', -5);
model.geom('geom1').feature('ps5').set('parmax2', 15);
model.geom('geom1').feature('ps5').set('coord', {'50*s1' '50*s2' '25*int1(s1,s2)+depth+450'});
model.geom('geom1').feature('ps5').set('pos', [-50 500 0]);
model.geom('geom1').feature('ps5').set('axistype', 'cartesian');
model.geom('geom1').feature('ps5').set('ax3', [-2 0 1]);
model.geom('geom1').feature('ps5').set('rtol', 0.02);
model.geom('geom1').feature('ps5').set('maxknots', 200);
model.geom('geom1').run('ps5');
model.geom('geom1').create('co1', 'Compose');
model.geom('geom1').feature('co1').selection('input').set({'del1' 'ps5'});
model.geom('geom1').feature('co1').set('formula', 'del1+del1*ps5');
model.geom('geom1').runPre('fin');
model.geom('geom1').create('ls1', 'LineSegment');
model.geom('geom1').feature('ls1').set('specify1', 'coord');
model.geom('geom1').feature('ls1').set('coord1', {'250-dist/2' '0' '0'});
model.geom('geom1').feature('ls1').setIndex('coord1', 250, 1);
model.geom('geom1').feature('ls1').setIndex('coord1', 'depth_w+l_well', 2);
model.geom('geom1').feature('ls1').set('specify2', 'coord');
model.geom('geom1').feature('ls1').set('coord2', {'250-dist/2' '0' '0'});
model.geom('geom1').feature('ls1').setIndex('coord2', 250, 1);
model.geom('geom1').feature('ls1').setIndex('coord2', 'depth_w', 2);
model.geom('geom1').feature('ls1').setIndex('coord1', 'depth_w', 2);
model.geom('geom1').feature('ls1').setIndex('coord2', 'depth_w+l_well', 2);
model.geom('geom1').runPre('fin');
model.geom('geom1').create('rot1', 'Rotate');
model.geom('geom1').feature('rot1').selection('input').set({'ls1'});
model.geom('geom1').feature('rot1').set('rot', 'alpha');
model.geom('geom1').feature('rot1').set('pos', {'250' '250' 'depth_w'});
model.geom('geom1').feature('rot1').set('axistype', 'y');
model.geom('geom1').feature.duplicate('ls2', 'ls1');
model.geom('geom1').feature('ls2').set('coord1', {'250+dist/2' '250' 'depth_w'});
model.geom('geom1').feature('ls2').setIndex('coord2', '250+dist/2', 0);
model.geom('geom1').feature.duplicate('rot2', 'rot1');
model.geom('geom1').runPre('rot2');
model.geom('geom1').feature('rot2').selection('input').set({'ls2'});
model.geom('geom1').feature('rot2').set('rot', '-alpha');
model.geom('geom1').feature('rot2').set('pos', {'300' '250' 'depth_w'});
model.geom('geom1').run('fin');
model.geom('geom1').create('clf1', 'CollapseFaces');
model.geom('geom1').feature('clf1').selection('input').set('fin', 30);
model.geom('geom1').run('clf1');

model.title([]);

model.description('');

model.label('geothermal_doublet_geom_sequence.mph');

model.modelNode.label('Components');

out = model;
