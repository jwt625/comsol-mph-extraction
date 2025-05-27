function out = model
%
% temperature_dependent_plasticity_geom_sequence.m
%
% Model exported on May 26 2025, 21:31 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/Nonlinear_Structural_Materials_Module/Plasticity');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 3);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.physics.create('solid', 'SolidMechanics', 'geom1');
model.physics('solid').model('comp1');
model.physics('solid').prop('StructuralTransientBehavior').set('StructuralTransientBehavior', 'Quasistatic');
model.physics.create('ht', 'HeatTransfer', 'geom1');
model.physics('ht').model('comp1');

model.multiphysics.create('te1', 'ThermalExpansion', 'geom1', 3);
model.multiphysics('te1').set('Heat_physics', 'ht');
model.multiphysics('te1').set('Solid_physics', 'solid');
model.multiphysics('te1').selection.all;

model.study.create('std1');
model.study('std1').create('stat', 'Stationary');
model.study('std1').feature('stat').setSolveFor('/physics/solid', true);
model.study('std1').feature('stat').setSolveFor('/physics/ht', true);
model.study('std1').feature('stat').setSolveFor('/multiphysics/te1', true);

model.geom('geom1').create('wp1', 'WorkPlane');
model.geom('geom1').feature('wp1').set('unite', true);
model.geom('geom1').feature('wp1').set('quickplane', 'xz');
model.geom('geom1').feature('wp1').set('unite', false);
model.geom('geom1').feature('wp1').geom.create('pol1', 'Polygon');
model.geom('geom1').feature('wp1').geom.feature('pol1').set('source', 'vectors');
model.geom('geom1').feature('wp1').geom.feature('pol1').set('x', '1.3 1.08 1.08 1.12 1.3');
model.geom('geom1').feature('wp1').geom.feature('pol1').set('y', '0.07 0.07 0.14 0.1 0.1');
model.geom('geom1').feature('wp1').geom.run('pol1');
model.geom('geom1').feature('wp1').geom.create('r1', 'Rectangle');
model.geom('geom1').feature('wp1').geom.feature('r1').set('size', [0.3 0.01]);
model.geom('geom1').feature('wp1').geom.feature('r1').set('pos', [1 0.06]);
model.geom('geom1').feature('wp1').geom.run('r1');
model.geom('geom1').run('wp1');
model.geom('geom1').feature.create('rev1', 'Revolve');
model.geom('geom1').feature('rev1').set('workplane', 'wp1');
model.geom('geom1').feature('rev1').selection('input').set({'wp1'});
model.geom('geom1').feature('rev1').set('angtype', 'full');
model.geom('geom1').feature('rev1').set('axis', [1 0]);
model.geom('geom1').feature('rev1').set('angtype', 'specang');
model.geom('geom1').feature('rev1').set('angle2', -90);
model.geom('geom1').run('rev1');
model.geom('geom1').create('wp2', 'WorkPlane');
model.geom('geom1').feature('wp2').set('unite', true);
model.geom('geom1').feature('wp2').set('quickplane', 'xz');
model.geom('geom1').feature('wp2').set('unite', false);
model.geom('geom1').feature('wp2').geom.create('r1', 'Rectangle');
model.geom('geom1').feature('wp2').geom.feature('r1').set('size', [0.09 0.3]);
model.geom('geom1').feature('wp2').geom.feature('r1').set('pos', [1.01 0]);
model.geom('geom1').feature('wp2').geom.run('r1');
model.geom('geom1').feature('wp2').geom.create('r2', 'Rectangle');
model.geom('geom1').feature('wp2').geom.feature('r2').set('size', [0.01 0.3]);
model.geom('geom1').feature('wp2').geom.feature('r2').set('pos', [1 0]);
model.geom('geom1').feature('wp2').geom.run('r2');
model.geom('geom1').run('wp2');
model.geom('geom1').feature.create('rev2', 'Revolve');
model.geom('geom1').feature('rev2').set('workplane', 'wp2');
model.geom('geom1').feature('rev2').selection('input').set({'wp2'});
model.geom('geom1').feature('rev2').set('angtype', 'specang');
model.geom('geom1').feature('rev2').set('angle2', 45);
model.geom('geom1').run('rev2');
model.geom('geom1').create('dif1', 'Difference');
model.geom('geom1').feature('dif1').set('keepsubtract', true);
model.geom('geom1').feature('dif1').set('intbnd', false);
model.geom('geom1').feature('dif1').selection('input').set({'rev1(2)'});
model.geom('geom1').feature('dif1').selection('input2').set({'rev2(2)'});
model.geom('geom1').run('dif1');
model.geom('geom1').create('dif2', 'Difference');
model.geom('geom1').feature('dif2').set('keepsubtract', true);
model.geom('geom1').feature('dif2').selection('input').set({'rev1(1)'});
model.geom('geom1').feature('dif2').selection('input2').set({'rev2(1)'});
model.geom('geom1').run('dif2');
model.geom('geom1').create('cyl1', 'Cylinder');
model.geom('geom1').feature('cyl1').set('r', 0.06);
model.geom('geom1').feature('cyl1').set('h', 0.4);
model.geom('geom1').feature('cyl1').set('pos', [0.95 0 0]);
model.geom('geom1').feature('cyl1').set('axistype', 'cartesian');
model.geom('geom1').feature('cyl1').set('ax3', [1 0 0]);
model.geom('geom1').run('cyl1');
model.geom('geom1').create('dif3', 'Difference');
model.geom('geom1').feature('dif3').selection('input').set({'rev2'});
model.geom('geom1').feature('dif3').selection('input2').set({'cyl1'});
model.geom('geom1').run('dif3');
model.geom('geom1').create('dif4', 'Difference');
model.geom('geom1').feature('dif4').selection('input').set({'dif3'});
model.geom('geom1').feature('dif4').selection('input2').set({'dif1'});
model.geom('geom1').feature('dif4').set('keepsubtract', true);
model.geom('geom1').run('dif4');
model.geom('geom1').run('fin');

model.title([]);

model.description('');

model.label('temperature_dependent_plasticity_geom_sequence.mph');

model.modelNode.label('Components');

out = model;
