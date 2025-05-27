function out = model
%
% conical_quantum_dot.m
%
% Model exported on May 26 2025, 21:26 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/COMSOL_Multiphysics/Equation_Based');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 2);
model.geom('geom1').model('comp1');
model.geom('geom1').axisymmetric(true);

model.mesh.create('mesh1', 'geom1');

model.physics.create('c', 'CoefficientFormPDE', 'geom1', {'u'});
model.physics('c').prop('EquationForm').set('form', 'Automatic');

model.study.create('std1');
model.study('std1').create('eigv', 'Eigenvalue');
model.study('std1').feature('eigv').setSolveFor('/physics/c', true);

model.param.set('m', 'me_const[1/kg]/e_const[1/C]');
model.param.descr('m', 'Electron mass (eV/c^2)');
model.param.set('hbar', 'hbar_const[1/(J*s)]/e_const[1/C]');
model.param.descr('hbar', 'Reduced Planck constant (eV*s)');
model.param.set('V_In', '0');
model.param.descr('V_In', 'Potential barrier, InAs (eV)');
model.param.set('V_Ga', '0.697');
model.param.descr('V_Ga', 'Potential barrier, GaAs (eV)');
model.param.set('c_In', 'hbar^2/(2*0.023*m)');
model.param.descr('c_In', 'c coefficient, InAs');
model.param.set('c_Ga', 'hbar^2/(2*0.067*m)');
model.param.descr('c_Ga', 'c coefficient, GaAs');
model.param.set('l', '0');
model.param.descr('l', 'Principal quantum number');

model.geom('geom1').lengthUnit('nm');
model.geom('geom1').create('r1', 'Rectangle');
model.geom('geom1').feature('r1').set('size', [25 100]);
model.geom('geom1').feature('r1').set('base', 'center');
model.geom('geom1').feature('r1').set('pos', [12.5 0]);
model.geom('geom1').run('r1');
model.geom('geom1').create('r2', 'Rectangle');
model.geom('geom1').feature('r2').set('size', [25 2]);
model.geom('geom1').feature('r2').set('base', 'center');
model.geom('geom1').feature('r2').set('pos', [12.5 0]);
model.geom('geom1').run('r2');
model.geom('geom1').create('pol1', 'Polygon');
model.geom('geom1').feature('pol1').set('source', 'table');
model.geom('geom1').feature('pol1').setIndex('table', 0, 0, 0);
model.geom('geom1').feature('pol1').setIndex('table', 0, 0, 1);
model.geom('geom1').feature('pol1').setIndex('table', 12, 1, 0);
model.geom('geom1').feature('pol1').setIndex('table', 0, 1, 1);
model.geom('geom1').feature('pol1').setIndex('table', 0, 2, 0);
model.geom('geom1').feature('pol1').setIndex('table', 3.6, 2, 1);
model.geom('geom1').run('pol1');
model.geom('geom1').create('co1', 'Compose');
model.geom('geom1').feature('co1').selection('input').set({'pol1' 'r2'});
model.geom('geom1').feature('co1').set('formula', 'r2+pol1');
model.geom('geom1').feature('co1').set('intbnd', false);
model.geom('geom1').run('co1');
model.geom('geom1').create('co2', 'Compose');
model.geom('geom1').feature('co2').selection('input').set({'co1' 'r1'});
model.geom('geom1').feature('co2').set('formula', 'r1+co1');
model.geom('geom1').run('co2');
model.geom('geom1').run;

model.physics('c').feature('cfeq1').setIndex('c', {'c_In' '0' '0' 'c_In'}, 0);
model.physics('c').feature('cfeq1').setIndex('a', 'c_In*(l/r)^2+V_In', 0);
model.physics('c').feature('cfeq1').setIndex('be', {'-c_In/r' '0'}, 0);
model.physics('c').feature('cfeq1').setIndex('be', {'-c_In/r' '0'}, 0);
model.physics('c').create('cfeq2', 'CoefficientFormPDE', 2);
model.physics('c').feature('cfeq2').selection.set([1 3]);
model.physics('c').feature('cfeq2').setIndex('c', {'c_Ga' '0' '0' 'c_Ga'}, 0);
model.physics('c').feature('cfeq2').setIndex('a', 'c_Ga*(l/r)^2+V_Ga', 0);
model.physics('c').feature('cfeq2').setIndex('be', {'-c_Ga/r' '0'}, 0);
model.physics('c').feature('cfeq2').setIndex('be', {'-c_Ga/r' '0'}, 0);
model.physics('c').create('dir1', 'DirichletBoundary', 1);
model.physics('c').feature('dir1').selection.set([2 9]);

model.mesh('mesh1').run;

model.study('std1').feature('eigv').set('neigsactive', true);
model.study('std1').feature('eigv').set('neigs', 4);

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
model.result.dataset.create('rev1', 'Revolve2D');
model.result.dataset('rev1').set('data', 'dset1');
model.result.dataset('rev1').set('revangle', 225);
model.result.dataset('rev1').set('startangle', -90);
model.result.dataset('rev1').set('hasspacevars', false);
model.result.create('pg2', 'PlotGroup3D');
model.result('pg2').set('data', 'rev1');
model.result('pg2').setIndex('looplevel', 1, 0);
model.result('pg2').create('surf1', 'Surface');
model.result('pg2').label('Coefficient Form PDE 1');
model.result('pg2').feature('surf1').set('expr', 'u');
model.result('pg1').run;
model.result('pg1').run;
model.result('pg1').feature('surf1').create('hght1', 'Height');
model.result('pg1').run;
model.result('pg1').run;
model.result('pg1').set('looplevel', [2]);
model.result('pg1').run;
model.result('pg1').set('looplevel', [3]);
model.result('pg1').run;
model.result('pg1').set('looplevel', [4]);
model.result('pg1').run;

model.title('Conical Quantum Dot');

model.description('Quantum dots are created by confining free electrons on the surface of a semiconductor. This is a model of the electronic states of a conical InAs quantum dot grown on a GaAs substrate.');

model.label('conical_quantum_dot.mph');

model.modelNode.label('Components');

out = model;
