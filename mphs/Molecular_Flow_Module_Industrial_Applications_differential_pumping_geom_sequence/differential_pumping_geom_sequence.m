function out = model
%
% differential_pumping_geom_sequence.m
%
% Model exported on May 26 2025, 21:30 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/Molecular_Flow_Module/Industrial_Applications');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 3);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.geom('geom1').create('cyl1', 'Cylinder');
model.geom('geom1').feature('cyl1').set('r', 0.3);
model.geom('geom1').feature('cyl1').set('h', 0.45);
model.geom('geom1').feature('cyl1').set('pos', [0.35 0 -0.225]);
model.geom('geom1').run('cyl1');
model.geom('geom1').create('cyl2', 'Cylinder');
model.geom('geom1').feature('cyl2').set('r', 0.125);
model.geom('geom1').feature('cyl2').set('h', 0.7);
model.geom('geom1').feature('cyl2').set('pos', [0.35 -0.35 0]);
model.geom('geom1').feature('cyl2').set('axistype', 'y');
model.geom('geom1').run('cyl2');
model.geom('geom1').create('cyl3', 'Cylinder');
model.geom('geom1').feature('cyl3').set('r', 0.125);
model.geom('geom1').feature('cyl3').set('h', 0.075);
model.geom('geom1').feature('cyl3').set('pos', [0.35 0 -0.3]);
model.geom('geom1').run('cyl3');
model.geom('geom1').create('cyl4', 'Cylinder');
model.geom('geom1').feature('cyl4').set('r', 0.065);
model.geom('geom1').feature('cyl4').set('h', 0.4);
model.geom('geom1').feature('cyl4').set('pos', [-0.05 0 0]);
model.geom('geom1').feature('cyl4').set('axistype', 'x');
model.geom('geom1').run('cyl4');
model.geom('geom1').create('cyl5', 'Cylinder');
model.geom('geom1').feature('cyl5').set('r', 0.125);
model.geom('geom1').feature('cyl5').set('h', 0.35);
model.geom('geom1').feature('cyl5').set('pos', [0.35 0 0]);
model.geom('geom1').feature('cyl5').set('axistype', 'x');
model.geom('geom1').run('cyl5');
model.geom('geom1').create('uni1', 'Union');
model.geom('geom1').feature('uni1').selection('input').set({'cyl1' 'cyl2' 'cyl3' 'cyl4' 'cyl5'});
model.geom('geom1').feature('uni1').set('intbnd', false);
model.geom('geom1').run('uni1');
model.geom('geom1').create('cyl6', 'Cylinder');
model.geom('geom1').feature('cyl6').set('r', 0.065);
model.geom('geom1').feature('cyl6').set('h', 0.04);
model.geom('geom1').feature('cyl6').set('pos', [-0.1 0 0]);
model.geom('geom1').feature('cyl6').set('axistype', 'x');
model.geom('geom1').run('cyl6');
model.geom('geom1').create('cone1', 'Cone');
model.geom('geom1').feature('cone1').set('specifytop', 'radius');
model.geom('geom1').feature('cone1').set('r', '20[mm]');
model.geom('geom1').feature('cone1').set('h', '27[mm]');
model.geom('geom1').feature('cone1').set('rtop', '15.5[mm]');
model.geom('geom1').feature('cone1').set('pos', [-0.08 0 -0.09]);
model.geom('geom1').run('cone1');
model.geom('geom1').create('uni2', 'Union');
model.geom('geom1').feature('uni2').selection('input').set({'cone1' 'cyl6'});
model.geom('geom1').feature('uni2').set('intbnd', false);
model.geom('geom1').run('uni2');
model.geom('geom1').create('cyl7', 'Cylinder');
model.geom('geom1').feature('cyl7').set('r', 0.015);
model.geom('geom1').feature('cyl7').set('h', 0.02);
model.geom('geom1').feature('cyl7').set('pos', [-0.08 0 0]);
model.geom('geom1').feature('cyl7').set('axistype', 'x');
model.geom('geom1').run('cyl7');
model.geom('geom1').create('dif1', 'Difference');
model.geom('geom1').feature('dif1').selection('input').set({'uni2'});
model.geom('geom1').feature('dif1').selection('input2').set({'cyl7'});
model.geom('geom1').run('dif1');
model.geom('geom1').create('cyl8', 'Cylinder');
model.geom('geom1').feature('cyl8').set('r', '1.5[mm]');
model.geom('geom1').feature('cyl8').set('h', 0.03);
model.geom('geom1').feature('cyl8').set('pos', [-0.08 0 0]);
model.geom('geom1').feature('cyl8').set('axistype', 'x');
model.geom('geom1').run('cyl8');
model.geom('geom1').create('wp1', 'WorkPlane');
model.geom('geom1').feature('wp1').set('unite', true);
model.geom('geom1').feature('wp1').set('quickplane', 'zx');
model.geom('geom1').run('wp1');
model.geom('geom1').create('par1', 'Partition');
model.geom('geom1').feature('par1').selection('input').set({'cyl8' 'dif1' 'uni1'});
model.geom('geom1').feature('par1').set('partitionwith', 'workplane');
model.geom('geom1').run('par1');
model.geom('geom1').create('del1', 'Delete');
model.geom('geom1').feature('del1').selection('input').init(3);
model.geom('geom1').feature('del1').selection('input').set('par1(1)', 1);
model.geom('geom1').feature('del1').selection('input').set('par1(2)', 1);
model.geom('geom1').feature('del1').selection('input').set('par1(3)', 1);
model.geom('geom1').run('del1');
model.geom('geom1').run('fin');
model.geom('geom1').create('sel1', 'ExplicitSelection');
model.geom('geom1').feature('sel1').label('Chamber Domain');
model.geom('geom1').feature('sel1').selection('selection').set('fin', 3);
model.geom('geom1').run('sel1');
model.geom('geom1').create('adjsel1', 'AdjacentSelection');
model.geom('geom1').feature('adjsel1').label('Chamber and Outlet');
model.geom('geom1').feature('adjsel1').set('input', {'sel1'});
model.geom('geom1').run('adjsel1');
model.geom('geom1').create('sel2', 'ExplicitSelection');
model.geom('geom1').feature('sel2').label('Outlet');
model.geom('geom1').feature('sel2').selection('selection').init(2);

model.view('view1').set('renderwireframe', true);

model.geom('geom1').feature('sel2').selection('selection').set('fin', 19);
model.geom('geom1').run('sel2');
model.geom('geom1').create('difsel1', 'DifferenceSelection');
model.geom('geom1').feature('difsel1').label('Chamber');
model.geom('geom1').feature('difsel1').set('entitydim', 2);
model.geom('geom1').feature('difsel1').set('add', {'adjsel1'});
model.geom('geom1').feature('difsel1').set('subtract', {'sel2'});
model.geom('geom1').run('difsel1');
model.geom('geom1').create('sel3', 'ExplicitSelection');
model.geom('geom1').feature('sel3').label('Inlet');
model.geom('geom1').feature('sel3').selection('selection').init(2);
model.geom('geom1').feature('sel3').selection('selection').set('fin', 9);
model.geom('geom1').run('sel3');
model.geom('geom1').create('sel4', 'ExplicitSelection');
model.geom('geom1').feature('sel4').label('Tube');
model.geom('geom1').feature('sel4').selection('selection').init(2);
model.geom('geom1').feature('sel4').set('groupcontang', true);
model.geom('geom1').feature('sel4').selection('selection').add('fin', [11 12]);
model.geom('geom1').run('sel4');
model.geom('geom1').create('sel5', 'ExplicitSelection');
model.geom('geom1').feature('sel5').label('Pump');
model.geom('geom1').feature('sel5').selection('selection').init(2);
model.geom('geom1').feature('sel5').selection('selection').set('fin', 25);
model.geom('geom1').run('sel5');
model.geom('geom1').create('sel6', 'ExplicitSelection');
model.geom('geom1').feature('sel6').label('Port');
model.geom('geom1').feature('sel6').selection('selection').init(2);
model.geom('geom1').feature('sel6').selection('selection').set('fin', 35);
model.geom('geom1').run('sel6');
model.geom('geom1').create('boxsel1', 'BoxSelection');
model.geom('geom1').feature('boxsel1').set('entitydim', 2);
model.geom('geom1').feature('boxsel1').set('ymin', '-0.1[mm]');
model.geom('geom1').feature('boxsel1').set('condition', 'inside');
model.geom('geom1').run('boxsel1');
model.geom('geom1').create('cylsel1', 'CylinderSelection');
model.geom('geom1').feature('cylsel1').set('r', 0.1);
model.geom('geom1').feature('cylsel1').set('axistype', 'x');
model.geom('geom1').feature('cylsel1').set('condition', 'inside');
model.geom('geom1').feature('cylsel1').set('entitydim', 2);
model.geom('geom1').run('cylsel1');
model.geom('geom1').create('cylsel2', 'CylinderSelection');
model.geom('geom1').feature('cylsel2').set('entitydim', 2);
model.geom('geom1').feature('cylsel2').set('r', 0.2);
model.geom('geom1').feature('cylsel2').set('pos', [0.35 0 0]);
model.geom('geom1').feature('cylsel2').set('condition', 'inside');
model.geom('geom1').run('cylsel2');
model.geom('geom1').create('difsel2', 'DifferenceSelection');
model.geom('geom1').feature('difsel2').label('Postprocessing');
model.geom('geom1').feature('difsel2').set('entitydim', 2);
model.geom('geom1').feature('difsel2').set('add', {'boxsel1'});
model.geom('geom1').feature('difsel2').set('subtract', {'cylsel1' 'cylsel2'});

model.title([]);

model.description('');

model.label('differential_pumping_geom_sequence.mph');

model.modelNode.label('Components');

out = model;
