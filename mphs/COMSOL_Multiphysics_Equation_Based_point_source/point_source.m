function out = model
%
% point_source.m
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

model.physics.create('lpeq', 'LaplaceEquation', 'geom1');
model.physics('lpeq').model('comp1');
model.physics('lpeq').prop('EquationForm').set('form', 'Automatic');

model.study.create('std1');
model.study('std1').create('stat', 'Stationary');
model.study('std1').feature('stat').setSolveFor('/physics/lpeq', true);

model.geom('geom1').create('c1', 'Circle');
model.geom('geom1').run('c1');
model.geom('geom1').create('pt1', 'Point');
model.geom('geom1').runPre('fin');
model.geom('geom1').run;

model.physics('lpeq').create('dir1', 'DirichletBoundary', 1);
model.physics('lpeq').feature('dir1').selection.all;
model.physics('lpeq').create('ptsrc1', 'PointSourceTerm', 0);
model.physics('lpeq').feature('ptsrc1').selection.set([3]);
model.physics('lpeq').feature('ptsrc1').setIndex('f', 1, 0);

model.study('std1').feature('stat').set('errestandadap', 'adaption');
model.study('std1').feature('stat').set('meshadaptmethod', 'modify');

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
model.result('pg1').set('data', 'dset2');
model.result('pg1').setIndex('looplevel', 3, 0);
model.result('pg1').create('surf1', 'Surface');
model.result('pg1').label('Laplace''s Equation');
model.result('pg1').feature('surf1').set('expr', 'u');
model.result('pg1').run;
model.result('pg1').set('showlegendsmaxmin', true);
model.result('pg1').run;
model.result('pg1').feature('surf1').create('hght1', 'Height');
model.result('pg1').run;
model.result.dataset.create('cln1', 'CutLine2D');
model.result.dataset('cln1').set('data', 'dset2');
model.result.dataset('cln1').setIndex('genpoints', 0.02, 0, 0);
model.result.create('pg2', 'PlotGroup1D');
model.result('pg2').run;
model.result('pg2').set('data', 'cln1');
model.result('pg2').setIndex('looplevelinput', 'last', 0);
model.result('pg2').create('lngr1', 'LineGraph');
model.result('pg2').feature('lngr1').set('markerpos', 'datapoints');
model.result('pg2').feature('lngr1').set('linewidth', 'preference');
model.result('pg2').feature('lngr1').set('expr', 'u+log(x^2)/(4*pi)');
model.result('pg2').run;
model.result.numerical.create('int1', 'IntSurface');
model.result.numerical('int1').set('intvolume', true);
model.result.numerical('int1').set('data', 'dset2');
model.result.numerical('int1').setIndex('looplevelinput', 'last', 0);
model.result.numerical('int1').selection.set([1]);
model.result.numerical('int1').setIndex('expr', 'abs(u+log(sqrt(x^2+y^2))/(2*pi))', 0);
model.result.numerical('int1').setIndex('unit', '', 0);
model.result.numerical('int1').setIndex('descr', '', 0);
model.result.table.create('tbl1', 'Table');
model.result.table('tbl1').comments('Surface Integration 1');
model.result.numerical('int1').set('table', 'tbl1');
model.result.numerical('int1').setResult;
model.result('pg1').run;

model.title('Implementing a Point Source');

model.description('The solution of Poisson''s equation on a unit disk with a point source at the origin. The mesh density is high close to the origin to resolve the singularity at the point source. The solution is compared to the analytical solution.');

model.label('point_source.mph');

model.modelNode.label('Components');

out = model;
