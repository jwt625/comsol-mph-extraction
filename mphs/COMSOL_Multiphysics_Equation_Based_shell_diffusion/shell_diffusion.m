function out = model
%
% shell_diffusion.m
%
% Model exported on May 26 2025, 21:26 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/COMSOL_Multiphysics/Equation_Based');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 3);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.physics.create('cb', 'CoefficientFormBoundaryPDE', 'geom1', {'V'});
model.physics('cb').prop('EquationForm').set('form', 'Automatic');

model.study.create('std1');
model.study('std1').create('stat', 'Stationary');
model.study('std1').feature('stat').setSolveFor('/physics/cb', true);

model.param.set('sigma', '4.032e6[S/m]');
model.param.descr('sigma', 'Conductivity');
model.param.set('d', '1[mm]');
model.param.descr('d', 'Shell thickness');

model.geom('geom1').insertFile('shell_diffusion_geom_sequence.mph', 'geom1');
model.geom('geom1').run('igf1');

model.physics('cb').prop('Units').set('DependentVariableQuantity', 'electricpotential');
model.physics('cb').prop('Units').setIndex('CustomSourceTermUnit', 'A*m^-2', 0, 0);
model.physics('cb').feature('cfeq1').setIndex('c', {'sigma*d' '0' '0' '0' 'sigma*d' '0' '0' '0' 'sigma*d'}, 0);
model.physics('cb').feature('cfeq1').setIndex('f', 0, 0);
model.physics('cb').create('dir1', 'DirichletBoundary', 1);
model.physics('cb').feature('dir1').selection.set([14 15 25 29]);
model.physics('cb').feature('dir1').setIndex('r', 400, 0);
model.physics('cb').create('dir2', 'DirichletBoundary', 1);
model.physics('cb').feature('dir2').selection.set([40 41 42 43]);

model.mesh('mesh1').autoMeshSize(3);
model.mesh('mesh1').run;

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

model.result.create('pg1', 'PlotGroup3D');
model.result('pg1').set('data', 'dset1');
model.result('pg1').create('surf1', 'Surface');
model.result('pg1').label('Coefficient Form Boundary PDE');
model.result('pg1').feature('surf1').set('expr', 'V');
model.result('pg1').run;

model.view('view1').camera.setIndex('position', 4.16655, 0);
model.view('view1').camera.setIndex('position', -2.86828, 1);
model.view('view1').camera.setIndex('position', 3.13374, 2);
model.view('view1').camera.set('zoomanglefull', 15.0478);
model.view('view1').camera.set('target', [3.43595 -2.36534 0.5]);
model.view('view1').camera.setIndex('target', 2.67192, 2);
model.view('view1').camera.setIndex('up', 0.67972, 0);
model.view('view1').camera.setIndex('up', 0.47146, 1);
model.view('view1').camera.setIndex('up', -0.56187, 2);
model.view('view1').camera.setIndex('viewoffset', -0.00121, 0);
model.view('view1').camera.set('viewoffset', [-0.00121 -0.00415]);

model.result('pg1').run;
model.result('pg1').run;
model.result('pg1').create('arws1', 'ArrowSurface');
model.result('pg1').feature('arws1').set('expr', {'-sigma*VTx' 'VTy' 'VTz'});
model.result('pg1').feature('arws1').setIndex('expr', '-sigma*VTy', 1);
model.result('pg1').feature('arws1').setIndex('expr', '-sigma*VTz', 2);
model.result('pg1').feature('arws1').set('descractive', true);
model.result('pg1').feature('arws1').set('descr', 'Current field (-sigma*VTx, -sigma*VTy, -sigma*VTz)');
model.result('pg1').feature('arws1').set('arrowlength', 'normalized');
model.result('pg1').run;
model.result.create('pg2', 'PlotGroup3D');
model.result('pg2').run;
model.result('pg2').set('titletype', 'manual');
model.result('pg2').set('title', 'Current density (A/m<sup>2</sup>)');
model.result('pg2').create('surf1', 'Surface');
model.result('pg2').feature('surf1').set('expr', 'sigma*sqrt(VTx^2+VTy^2+VTz^2)');
model.result('pg2').run;

model.title('Shell Diffusion in a Tank');

model.description('This 3D model shows how to compute the current density in the tank shell and the potential distribution on the surface.');

model.label('shell_diffusion.mph');

model.modelNode.label('Components');

out = model;
