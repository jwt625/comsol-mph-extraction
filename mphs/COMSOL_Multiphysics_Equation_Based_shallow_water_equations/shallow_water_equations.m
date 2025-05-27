function out = model
%
% shallow_water_equations.m
%
% Model exported on May 26 2025, 21:26 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/COMSOL_Multiphysics/Equation_Based');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 1);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.physics.create('g', 'GeneralFormPDE', 'geom1', {'Z' 'V'});
model.physics('g').prop('EquationForm').set('form', 'Automatic');

model.study.create('std1');
model.study('std1').create('time', 'Transient');
model.study('std1').feature('time').setSolveFor('/physics/g', true);

model.baseSystem('none');

model.param.set('nu1', '1e-6');
model.param.descr('nu1', 'Kinematic viscosity (m^2/s)');
model.param.set('x0', '6');
model.param.descr('x0', 'Sea bed ridge position (m)');
model.param.set('a', '0.005');
model.param.descr('a', 'Sea bed ridge height (m)');
model.param.set('k1', '0.0015');
model.param.descr('k1', 'Sea bed slope parameter');
model.param.set('tune', '0.1');
model.param.descr('tune', 'Tuning parameter');

model.geom('geom1').create('i1', 'Interval');
model.geom('geom1').feature('i1').setIndex('coord', 10, 1);
model.geom('geom1').runPre('fin');

model.variable.create('var1');
model.variable('var1').model('comp1');

model.geom('geom1').run;

model.variable('var1').set('Zf', 'a*exp(-(x-x0)^2)+k1*x');
model.variable('var1').descr('Zf', 'Sea bed profile');
model.variable('var1').set('dZfdx', 'd(Zf,x)');
model.variable('var1').descr('dZfdx', 'Sea bed profile, x derivative');
model.variable('var1').set('Zs', 'Z+Zf');
model.variable('var1').descr('Zs', 'Sea surface level');
model.variable('var1').set('Z0', '0.02-Zf+0.005*exp(-(x-3)^2)');
model.variable('var1').descr('Z0', 'Initial water depth profile');
model.variable('var1').set('vphase', 'abs(V)+sqrt(g_const*Z)');
model.variable('var1').descr('vphase', 'Maximal wave propagation velocity');
model.variable('var1').set('nu', 'nu1+vphase*h*tune');
model.variable('var1').descr('nu', 'Effective kinematic viscosity');

model.physics('g').feature('gfeq1').setIndex('Ga', 'V*Z', 0);
model.physics('g').feature('gfeq1').setIndex('Ga', '-nu*Vx', 1);
model.physics('g').feature('gfeq1').setIndex('f', 0, 0);
model.physics('g').feature('gfeq1').setIndex('f', '-g_const*(Zx+dZfdx)-V*Vx+nu*Vx*Zx/Z', 1);
model.physics('g').feature('init1').set('Z', 'Z0');
model.physics('g').create('cons1', 'Constraint', 0);
model.physics('g').feature('cons1').selection.set([1 2]);
model.physics('g').feature('cons1').setIndex('R', '-V', 1);

model.mesh('mesh1').create('edg1', 'Edge');
model.mesh('mesh1').feature('size').set('custom', true);
model.mesh('mesh1').feature('size').set('hmax', 0.05);
model.mesh('mesh1').run;

model.study('std1').feature('time').set('tlist', 'range(0,60)');
model.study('std1').feature('time').set('usertol', true);
model.study('std1').feature('time').set('rtol', '1e-5');

model.sol.create('sol1');
model.sol('sol1').study('std1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'time');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').set('control', 'time');
model.sol('sol1').create('t1', 'Time');
model.sol('sol1').feature('t1').set('tlist', 'range(0,60)');
model.sol('sol1').feature('t1').set('plot', 'off');
model.sol('sol1').feature('t1').set('plotgroup', 'Default');
model.sol('sol1').feature('t1').set('plotfreq', 'tout');
model.sol('sol1').feature('t1').set('probesel', 'all');
model.sol('sol1').feature('t1').set('probes', {});
model.sol('sol1').feature('t1').set('probefreq', 'tsteps');
model.sol('sol1').feature('t1').set('atolglobalvaluemethod', 'factor');
model.sol('sol1').feature('t1').set('endtimeinterpolation', true);
model.sol('sol1').feature('t1').set('control', 'time');
model.sol('sol1').feature('t1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('t1').feature('fc1').set('linsolver', 'dDef');
model.sol('sol1').feature('t1').feature.remove('fcDef');
model.sol('sol1').attach('std1');
model.sol('sol1').feature('t1').set('atolglobalvaluemethod', 'manual');
model.sol('sol1').feature('t1').set('atolglobal', '1e-7');
model.sol('sol1').runAll;

model.result.create('pg1', 'PlotGroup1D');
model.result('pg1').set('data', 'dset1');
model.result('pg1').create('lngr1', 'LineGraph');
model.result('pg1').feature('lngr1').set('xdata', 'expr');
model.result('pg1').feature('lngr1').set('xdataexpr', 'x');
model.result('pg1').feature('lngr1').selection.geom('geom1', 1);
model.result('pg1').feature('lngr1').selection.set([1]);
model.result('pg1').feature('lngr1').set('expr', 'Z');
model.result('pg1').label('General Form PDE');
model.result('pg1').run;
model.result('pg1').set('legendpos', 'lowerright');
model.result('pg1').run;
model.result('pg1').feature('lngr1').set('data', 'dset1');
model.result('pg1').feature('lngr1').setIndex('looplevelinput', 'manual', 0);
model.result('pg1').feature('lngr1').setIndex('looplevel', [1], 0);
model.result('pg1').feature('lngr1').set('expr', 'Zf');
model.result('pg1').feature('lngr1').set('descr', 'Sea bed profile');
model.result('pg1').feature('lngr1').set('legend', true);
model.result('pg1').feature('lngr1').set('legendmethod', 'manual');
model.result('pg1').feature('lngr1').setIndex('legends', 'Zf', 0);
model.result('pg1').run;
model.result('pg1').feature.duplicate('lngr2', 'lngr1');
model.result('pg1').run;
model.result('pg1').feature('lngr2').set('expr', 'Zs');
model.result('pg1').feature('lngr2').set('descr', 'Sea surface level');
model.result('pg1').feature('lngr2').setIndex('legends', 'Zs (t = 0)', 0);
model.result('pg1').run;
model.result('pg1').feature('lngr2').setIndex('looplevel', [4], 0);
model.result('pg1').feature('lngr2').setIndex('legends', 'Zs (t = 3 s)', 0);
model.result('pg1').run;
model.result('pg1').feature('lngr2').setIndex('looplevel', [7], 0);
model.result('pg1').feature('lngr2').setIndex('legends', 'Zs (t = 6 s)', 0);
model.result('pg1').run;
model.result('pg1').feature('lngr2').setIndex('looplevel', [10], 0);
model.result('pg1').feature('lngr2').setIndex('legends', 'Zs (t = 9 s)', 0);
model.result('pg1').run;
model.result('pg1').feature('lngr2').setIndex('looplevel', [13], 0);
model.result('pg1').feature('lngr2').setIndex('legends', 'Zs (t = 12 s)', 0);
model.result('pg1').run;
model.result('pg1').feature('lngr2').setIndex('looplevel', [16], 0);
model.result('pg1').feature('lngr2').setIndex('legends', 'Zs (t = 15 s)', 0);
model.result('pg1').run;

model.title('The Shallow Water Equations');

model.description('This 1D model uses the shallow water equations to investigate the settling of a wave over a variable bed as a function of time. The initial wave and the shape of the bed are represented by mathematical relations so that parameters such as the wave amplitude or the bed''s shape can easily be changed.');

model.mesh.clearMeshes;

model.sol('sol1').clearSolutionData;

model.label('shallow_water_equations.mph');

model.modelNode.label('Components');

out = model;
