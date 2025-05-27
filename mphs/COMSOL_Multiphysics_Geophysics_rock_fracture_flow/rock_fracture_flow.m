function out = model
%
% rock_fracture_flow.m
%
% Model exported on May 26 2025, 21:26 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/COMSOL_Multiphysics/Geophysics');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 2);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.physics.create('cdeq', 'ConvectionDiffusionEquation', 'geom1');
model.physics('cdeq').model('comp1');
model.physics('cdeq').prop('EquationForm').set('form', 'Automatic');
model.physics('cdeq').field('dimensionless').field('H');
model.physics('cdeq').prop('Units').set('DependentVariableQuantity', 'head');
model.physics('cdeq').prop('Units').set('SourceTermQuantity', 'timechangeinpressurehead');

model.study.create('std1');
model.study('std1').create('stat', 'Stationary');
model.study('std1').feature('stat').setSolveFor('/physics/cdeq', true);

model.param.set('rho', '1000[kg/m^3]');
model.param.descr('rho', 'Fluid density');
model.param.set('mu', '0.001[Pa*s]');
model.param.descr('mu', 'Fluid dynamic viscosity');

model.func.create('int1', 'Interpolation');
model.func('int1').set('source', 'file');
model.func('int1').set('filename', 'rock_fracture_flow_aperture_data.txt');
model.func('int1').importData;
model.func('int1').setIndex('funcs', 'data', 0, 0);
model.func('int1').setIndex('funcs', 1, 0, 1);
model.func('int1').setIndex('argunit', 'mm', 0);
model.func('int1').setIndex('argunit', 'mm', 1);
model.func('int1').setIndex('fununit', 'mm', 0);

model.geom('geom1').lengthUnit('mm');
model.geom('geom1').create('r1', 'Rectangle');
model.geom('geom1').feature('r1').set('size', [80 50]);
model.geom('geom1').feature('r1').set('pos', [10 20]);
model.geom('geom1').run('r1');

model.variable.create('var1');
model.variable('var1').model('comp1');

model.geom('geom1').run;

model.variable('var1').set('a', 'data(x,y)/1000');
model.variable('var1').descr('a', 'Aperture');
model.variable('var1').set('Ks', 'a^2*rho*g_const/mu');
model.variable('var1').descr('Ks', 'Hydraulic conductivity');
model.variable('var1').set('Ts', 'Ks*a');
model.variable('var1').descr('Ts', 'Transmissivity');
model.variable('var1').set('u', '-Ks*Hx');
model.variable('var1').descr('u', 'Velocity, x component');
model.variable('var1').set('v', '-Ks*Hy');
model.variable('var1').descr('v', 'Velocity, y component');
model.variable('var1').set('U', 'sqrt(u^2+v^2)');
model.variable('var1').descr('U', 'Velocity magnitude');

model.physics('cdeq').feature('cdeq1').setIndex('c', {'Ts' '0' '0' 'Ts'}, 0);
model.physics('cdeq').feature('cdeq1').setIndex('f', 0, 0);
model.physics('cdeq').feature('cdeq1').setIndex('da', 0, 0);
model.physics('cdeq').create('dir1', 'DirichletBoundary', 1);
model.physics('cdeq').feature('dir1').selection.set([2]);
model.physics('cdeq').create('dir2', 'DirichletBoundary', 1);
model.physics('cdeq').feature('dir2').selection.set([3]);
model.physics('cdeq').feature('dir2').setIndex('r', '20[mm]', 0);

model.mesh('mesh1').autoMeshSize(2);

model.sol.create('sol1');
model.sol('sol1').study('std1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'stat');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').set('control', 'stat');
model.sol('sol1').create('s1', 'Stationary');
model.sol('sol1').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('s1').feature('fc1').set('linsolver', 'dDef');
model.sol('sol1').feature('s1').feature.remove('fcDef');
model.sol('sol1').attach('std1');
model.sol('sol1').runAll;

model.result.create('pg1', 'PlotGroup2D');
model.result('pg1').set('data', 'dset1');
model.result('pg1').create('surf1', 'Surface');
model.result('pg1').label('Convection-Diffusion Equation');
model.result('pg1').feature('surf1').set('expr', 'H');
model.result('pg1').run;
model.result('pg1').label('Velocity (2D)');
model.result('pg1').run;
model.result('pg1').feature('surf1').set('expr', 'U');
model.result('pg1').feature('surf1').create('hght1', 'Height');
model.result('pg1').run;
model.result('pg1').feature('surf1').feature('hght1').set('heightdata', 'expr');
model.result('pg1').feature('surf1').feature('hght1').set('expr', 'data(x,y)');
model.result('pg1').feature('surf1').feature('hght1').set('scaleactive', true);
model.result('pg1').feature('surf1').feature('hght1').set('scale', 1);
model.result('pg1').run;

model.modelNode.create('comp2', true);

model.geom.create('geom2', 3);
model.geom('geom2').model('comp2');

model.mesh.create('mesh2', 'geom2');

model.geom('geom2').lengthUnit('mm');
model.geom('geom2').create('ps1', 'ParametricSurface');
model.geom('geom2').feature('ps1').set('parmin1', 10);
model.geom('geom2').feature('ps1').set('parmax1', 90);
model.geom('geom2').feature('ps1').set('parmin2', 20);
model.geom('geom2').feature('ps1').set('parmax2', 70);
model.geom('geom2').feature('ps1').set('coord', {'s1' 's2' 'data(s1,s2)'});
model.geom('geom2').feature('ps1').set('rtol', '1.0E-2');
model.geom('geom2').feature('ps1').set('maxknots', 100);
model.geom('geom2').runPre('fin');

model.variable.create('var2');
model.variable('var2').model('comp2');

model.geom('geom2').run;

model.variable('var2').set('a', 'data(x,y)/1000', 'Aperture');
model.variable('var2').descr('a', 'Aperture');
model.variable('var2').set('Ks', 'a^2*rho*g_const/mu', 'Hydraulic conductivity');
model.variable('var2').descr('Ks', 'Hydraulic conductivity');
model.variable('var2').set('Ts', 'a*Ks', 'Transmissivity');
model.variable('var2').descr('Ts', 'Transmissivity');
model.variable('var2').set('u', '-Ks*H2Tx', 'Velocity, x component');
model.variable('var2').descr('u', 'Velocity, x component');
model.variable('var2').set('v', '-Ks*H2Ty', 'Velocity, y component');
model.variable('var2').descr('v', 'Velocity, y component');
model.variable('var2').set('w', '-Ks*H2Tz');
model.variable('var2').descr('w', 'Velocity, z component');
model.variable('var2').set('U', 'sqrt(u^2+v^2+w^2)', 'Velocity magnitude');
model.variable('var2').descr('U', 'Velocity magnitude');

model.physics.create('cb', 'CoefficientFormBoundaryPDE', 'geom2', {'H2'});

model.study('std1').feature('stat').setSolveFor('/physics/cb', false);

model.physics('cb').prop('EquationForm').set('form', 'Automatic');
model.physics('cb').field('dimensionless').field('H2');
model.physics('cb').prop('Units').set('DependentVariableQuantity', 'head');
model.physics('cb').prop('Units').set('SourceTermQuantity', 'timechangeinpressurehead');
model.physics('cb').feature('cfeq1').setIndex('c', {'-Ts' '0' '0' '0' '-Ts' '0' '0' '0' '-Ts'}, 0);
model.physics('cb').feature('cfeq1').setIndex('f', 0, 0);
model.physics('cb').feature('cfeq1').setIndex('da', 0, 0);
model.physics('cb').create('dir1', 'DirichletBoundary', 1);
model.physics('cb').feature('dir1').selection.set([2]);
model.physics('cb').create('dir2', 'DirichletBoundary', 1);
model.physics('cb').feature('dir2').selection.set([3]);
model.physics('cb').feature('dir2').setIndex('r', '20[mm]', 0);

model.study.create('std2');
model.study('std2').create('stat', 'Stationary');
model.study('std2').feature('stat').setSolveFor('/physics/cdeq', false);
model.study('std2').feature('stat').setSolveFor('/physics/cb', true);

model.sol.create('sol2');
model.sol('sol2').study('std2');
model.sol('sol2').create('st1', 'StudyStep');
model.sol('sol2').feature('st1').set('study', 'std2');
model.sol('sol2').feature('st1').set('studystep', 'stat');
model.sol('sol2').create('v1', 'Variables');
model.sol('sol2').feature('v1').set('control', 'stat');
model.sol('sol2').create('s1', 'Stationary');
model.sol('sol2').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol2').feature('s1').feature('fc1').set('linsolver', 'dDef');
model.sol('sol2').feature('s1').feature.remove('fcDef');
model.sol('sol2').attach('std2');
model.sol('sol2').runAll;

model.result.create('pg2', 'PlotGroup3D');
model.result('pg2').set('data', 'dset3');
model.result('pg2').create('surf1', 'Surface');
model.result('pg2').label('Coefficient Form Boundary PDE');
model.result('pg2').feature('surf1').set('expr', 'H2');
model.result('pg2').run;
model.result('pg2').label('Velocity (3D)');
model.result('pg2').run;
model.result('pg2').feature('surf1').set('expr', 'U');
model.result('pg2').run;
model.result('pg2').create('arws1', 'ArrowSurface');
model.result('pg2').feature('arws1').set('expr', {'u' 'v' 'w'});
model.result('pg2').feature('arws1').set('arrowlength', 'normalized');
model.result('pg2').feature('arws1').set('placement', 'elements');
model.result('pg2').run;
model.result('pg2').run;

model.title('Rock Fracture Flow');

model.description('The flow on a rock fracture is modeled both in 2D and 3D. The example uses synthetically generated fracture aperture (width) data and an interpolation function. The fracture''s transmissivity is assumed to be proportional to the cube of the aperture.');

model.mesh.clearMeshes;

model.sol('sol1').clearSolutionData;
model.sol('sol2').clearSolutionData;

model.label('rock_fracture_flow.mph');

model.modelNode.label('Components');

out = model;
