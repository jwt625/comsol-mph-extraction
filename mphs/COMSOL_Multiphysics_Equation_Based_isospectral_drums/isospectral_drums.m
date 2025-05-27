function out = model
%
% isospectral_drums.m
%
% Model exported on May 26 2025, 21:26 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/COMSOL_Multiphysics/Equation_Based');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 2);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.physics.create('c', 'CoefficientFormPDE', 'geom1', {'u'});
model.physics('c').prop('EquationForm').set('form', 'Automatic');

model.study.create('std1');
model.study('std1').create('eigv', 'Eigenvalue');
model.study('std1').feature('eigv').setSolveFor('/physics/c', true);

model.geom('geom1').create('pol1', 'Polygon');
model.geom('geom1').feature('pol1').set('source', 'table');
model.geom('geom1').feature('pol1').setIndex('table', -3, 0, 0);
model.geom('geom1').feature('pol1').setIndex('table', -3, 0, 1);
model.geom('geom1').feature('pol1').setIndex('table', -3, 1, 0);
model.geom('geom1').feature('pol1').setIndex('table', -1, 1, 1);
model.geom('geom1').feature('pol1').setIndex('table', 1, 2, 0);
model.geom('geom1').feature('pol1').setIndex('table', 3, 2, 1);
model.geom('geom1').feature('pol1').setIndex('table', 1, 3, 0);
model.geom('geom1').feature('pol1').setIndex('table', 1, 3, 1);
model.geom('geom1').feature('pol1').setIndex('table', 3, 4, 0);
model.geom('geom1').feature('pol1').setIndex('table', 1, 4, 1);
model.geom('geom1').feature('pol1').setIndex('table', 1, 5, 0);
model.geom('geom1').feature('pol1').setIndex('table', -1, 5, 1);
model.geom('geom1').feature('pol1').setIndex('table', -1, 6, 0);
model.geom('geom1').feature('pol1').setIndex('table', -1, 6, 1);
model.geom('geom1').feature('pol1').setIndex('table', -1, 7, 0);
model.geom('geom1').feature('pol1').setIndex('table', -3, 7, 1);
model.geom('geom1').runPre('fin');
model.geom('geom1').run;

model.physics('c').create('dir1', 'DirichletBoundary', 1);
model.physics('c').feature('dir1').selection.all;

model.mesh('mesh1').autoMeshSize(2);
model.mesh('mesh1').run;

model.sol.create('sol1');
model.sol('sol1').study('std1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'eigv');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').set('control', 'eigv');
model.sol('sol1').create('e1', 'Eigenvalue');
model.sol('sol1').feature('e1').set('control', 'eigv');
model.sol('sol1').attach('std1');
model.sol('sol1').runAll;

model.result.create('pg1', 'PlotGroup2D');
model.result('pg1').set('data', 'dset1');
model.result('pg1').setIndex('looplevel', 1, 0);
model.result('pg1').create('surf1', 'Surface');
model.result('pg1').label('Coefficient Form PDE');
model.result('pg1').feature('surf1').set('expr', 'u');
model.result('pg1').run;

model.modelNode.create('comp2', true);

model.geom.create('geom2', 2);
model.geom('geom2').model('comp2');

model.mesh.create('mesh2', 'geom2');

model.physics.create('c2', 'CoefficientFormPDE', 'geom2', {'u2'});

model.study('std1').feature('eigv').setSolveFor('/physics/c2', false);

model.physics('c2').prop('EquationForm').set('form', 'Automatic');

model.geom('geom2').run;

model.study.create('std2');
model.study('std2').create('eigv', 'Eigenvalue');
model.study('std2').feature('eigv').setSolveFor('/physics/c', false);
model.study('std2').feature('eigv').setSolveFor('/physics/c2', true);

model.geom('geom2').create('pol1', 'Polygon');
model.geom('geom2').feature('pol1').set('source', 'table');
model.geom('geom2').feature('pol1').setIndex('table', -3, 0, 0);
model.geom('geom2').feature('pol1').setIndex('table', 1, 0, 1);
model.geom('geom2').feature('pol1').setIndex('table', 1, 1, 0);
model.geom('geom2').feature('pol1').setIndex('table', 1, 1, 1);
model.geom('geom2').feature('pol1').setIndex('table', 1, 2, 0);
model.geom('geom2').feature('pol1').setIndex('table', 3, 2, 1);
model.geom('geom2').feature('pol1').setIndex('table', 3, 3, 0);
model.geom('geom2').feature('pol1').setIndex('table', 1, 3, 1);
model.geom('geom2').feature('pol1').setIndex('table', 1, 4, 0);
model.geom('geom2').feature('pol1').setIndex('table', -1, 4, 1);
model.geom('geom2').feature('pol1').setIndex('table', -1, 5, 0);
model.geom('geom2').feature('pol1').setIndex('table', -1, 5, 1);
model.geom('geom2').feature('pol1').setIndex('table', -1, 6, 0);
model.geom('geom2').feature('pol1').setIndex('table', -3, 6, 1);
model.geom('geom2').feature('pol1').setIndex('table', -3, 7, 0);
model.geom('geom2').feature('pol1').setIndex('table', -1, 7, 1);
model.geom('geom2').runPre('fin');
model.geom('geom2').run;

model.physics('c2').create('dir1', 'DirichletBoundary', 1);
model.physics('c2').feature('dir1').selection.all;

model.mesh('mesh2').autoMeshSize(2);
model.mesh('mesh2').run;

model.sol.create('sol2');
model.sol('sol2').study('std2');
model.sol('sol2').create('st1', 'StudyStep');
model.sol('sol2').feature('st1').set('study', 'std2');
model.sol('sol2').feature('st1').set('studystep', 'eigv');
model.sol('sol2').create('v1', 'Variables');
model.sol('sol2').feature('v1').set('control', 'eigv');
model.sol('sol2').create('e1', 'Eigenvalue');
model.sol('sol2').feature('e1').set('control', 'eigv');
model.sol('sol2').attach('std2');
model.sol('sol2').runAll;

model.result.create('pg2', 'PlotGroup2D');
model.result('pg2').set('data', 'dset3');
model.result('pg2').setIndex('looplevel', 1, 0);
model.result('pg2').create('surf1', 'Surface');
model.result('pg2').label('Coefficient Form PDE 2');
model.result('pg2').feature('surf1').set('expr', 'u2');
model.result('pg2').run;
model.result.numerical.create('int1', 'IntSurface');
model.result.numerical('int1').set('intvolume', true);
model.result.numerical('int1').selection.set([1]);
model.result.numerical('int1').setIndex('expr', 'with(1,u)*with(2,u)', 0);
model.result.table.create('tbl1', 'Table');
model.result.table('tbl1').comments('Surface Integration 1');
model.result.numerical('int1').set('table', 'tbl1');
model.result.numerical('int1').setResult;
model.result.numerical.create('int2', 'IntSurface');
model.result.numerical('int2').set('intvolume', true);
model.result.numerical('int2').set('data', 'dset3');
model.result.numerical('int2').selection.set([1]);
model.result.numerical('int2').setIndex('expr', 'with(1,u2)*with(2,u2)', 0);
model.result.table.create('tbl2', 'Table');
model.result.table('tbl2').comments('Surface Integration 2');
model.result.numerical('int2').set('table', 'tbl2');
model.result.numerical('int2').setResult;
model.result('pg2').run;

model.title('Isospectral Drums');

model.description('By computing the same set of eigenvalues for two different planar membrane shapes, this example demonstrates that you cannot hear the shape of a drum.');

model.label('isospectral_drums.mph');

model.modelNode.label('Components');

out = model;
