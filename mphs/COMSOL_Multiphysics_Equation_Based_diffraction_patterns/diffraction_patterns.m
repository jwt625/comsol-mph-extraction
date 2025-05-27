function out = model
%
% diffraction_patterns.m
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
model.study('std1').create('stat', 'Stationary');
model.study('std1').feature('stat').setSolveFor('/physics/c', true);

model.param.set('l', '0.1[m]');
model.param.descr('l', 'Wavelength');
model.param.set('k', '2*pi[rad]/l');
model.param.descr('k', 'Wave number');
model.param.set('u0', '1');
model.param.descr('u0', 'Incident wave amplitude at inflow boundaries');

model.geom('geom1').create('c1', 'Circle');
model.geom('geom1').feature('c1').set('angle', 180);
model.geom('geom1').feature('c1').set('pos', [0.5 0]);
model.geom('geom1').feature('c1').set('rot', -90);
model.geom('geom1').run('c1');
model.geom('geom1').create('r1', 'Rectangle');
model.geom('geom1').feature('r1').set('size', [0.5 0.03]);
model.geom('geom1').feature('r1').set('pos', {'0' '-0.015-0.1'});
model.geom('geom1').run('r1');
model.geom('geom1').create('copy1', 'Copy');
model.geom('geom1').feature('copy1').selection('input').set({'r1'});
model.geom('geom1').feature('copy1').set('disply', 0.2);
model.geom('geom1').run('copy1');
model.geom('geom1').create('uni1', 'Union');
model.geom('geom1').feature('uni1').selection('input').set({'c1' 'copy1' 'r1'});
model.geom('geom1').feature('uni1').set('intbnd', false);
model.geom('geom1').run('fin');

model.physics('c').feature('cfeq1').setIndex('a', '-k^2', 0);
model.physics('c').feature('cfeq1').setIndex('f', 0, 0);
model.physics('c').create('flux1', 'FluxBoundary', 1);
model.physics('c').feature('flux1').selection.set([1 4]);
model.physics('c').feature('flux1').setIndex('g', '-i*k*u+2*u0*i*k*exp(-i*k*x)', 0);
model.physics('c').create('flux2', 'FluxBoundary', 1);
model.physics('c').feature('flux2').selection.set([11 12]);
model.physics('c').feature('flux2').setIndex('g', '-i*k*u', 0);

model.mesh('mesh1').create('ftri1', 'FreeTri');
model.mesh('mesh1').feature('size').set('custom', true);
model.mesh('mesh1').feature('size').set('hmax', 'l/5');
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

model.result.create('pg1', 'PlotGroup2D');
model.result('pg1').set('data', 'dset1');
model.result('pg1').create('surf1', 'Surface');
model.result('pg1').label('Coefficient Form PDE');
model.result('pg1').feature('surf1').set('expr', 'u');
model.result('pg1').run;
model.result('pg1').run;
model.result('pg1').feature('surf1').set('colortable', 'WaveLight');
model.result('pg1').run;

model.title('Diffraction Patterns');

model.description('This is a model of the well-known double-slit interference experiment. Two thin waveguides lead to slits in a screen. The example computes the diffraction pattern that appears on the other side.');

model.label('diffraction_patterns.mph');

model.modelNode.label('Components');

out = model;
