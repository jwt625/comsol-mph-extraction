function out = model
%
% heart_electrical.m
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

model.physics.create('g', 'GeneralFormPDE', 'geom1', {'u1' 'u2'});
model.physics('g').prop('EquationForm').set('form', 'Automatic');

model.study.create('std1');
model.study('std1').create('time', 'Transient');
model.study('std1').feature('time').setSolveFor('/physics/g', true);

model.baseSystem('none');

model.geom('geom1').create('sph1', 'Sphere');
model.geom('geom1').feature('sph1').set('r', 54);
model.geom('geom1').run('sph1');
model.geom('geom1').create('elp1', 'Ellipsoid');
model.geom('geom1').feature('elp1').set('semiaxes', [54 54 70]);
model.geom('geom1').run('elp1');
model.geom('geom1').create('blk1', 'Block');
model.geom('geom1').feature('blk1').set('size', [110 110 110]);
model.geom('geom1').feature('blk1').set('base', 'center');
model.geom('geom1').feature('blk1').set('pos', [0 0 55]);
model.geom('geom1').run('blk1');
model.geom('geom1').create('dif1', 'Difference');
model.geom('geom1').feature('dif1').selection('input').set({'elp1'});
model.geom('geom1').feature('dif1').selection('input2').set({'blk1'});
model.geom('geom1').run('dif1');
model.geom('geom1').create('blk2', 'Block');
model.geom('geom1').feature('blk2').set('size', [110 110 110]);
model.geom('geom1').feature('blk2').set('base', 'center');
model.geom('geom1').feature('blk2').set('pos', [0 0 -55]);
model.geom('geom1').run('blk2');
model.geom('geom1').create('dif2', 'Difference');
model.geom('geom1').feature('dif2').selection('input').set({'sph1'});
model.geom('geom1').feature('dif2').selection('input2').set({'blk2'});
model.geom('geom1').run('dif2');
model.geom('geom1').create('uni1', 'Union');
model.geom('geom1').feature('uni1').selection('input').set({'dif1' 'dif2'});
model.geom('geom1').runPre('fin');
model.geom('geom1').create('sca1', 'Scale');
model.geom('geom1').feature('sca1').set('keep', true);
model.geom('geom1').feature('sca1').selection('input').set({'uni1'});
model.geom('geom1').feature('sca1').set('isotropic', '2/3');
model.geom('geom1').run('sca1');

model.view('view1').set('transparency', true);

model.geom('geom1').create('dif3', 'Difference');
model.geom('geom1').feature('dif3').selection('input').set({'uni1'});
model.geom('geom1').feature('dif3').selection('input2').set({'sca1'});
model.geom('geom1').run('dif3');
model.geom('geom1').create('cyl1', 'Cylinder');
model.geom('geom1').feature('cyl1').set('r', 45);
model.geom('geom1').feature('cyl1').set('h', 10);
model.geom('geom1').feature('cyl1').set('pos', [-5 0 -5]);
model.geom('geom1').feature('cyl1').set('axistype', 'cartesian');
model.geom('geom1').feature('cyl1').set('ax3', [1 0 0]);
model.geom('geom1').run('cyl1');
model.geom('geom1').create('uni2', 'Union');
model.geom('geom1').feature('uni2').selection('input').set({'cyl1' 'dif3'});
model.geom('geom1').feature('uni2').set('intbnd', false);
model.geom('geom1').runPre('fin');

model.param.set('alpha', '0.1');
model.param.descr('alpha', 'Excitation threshold');
model.param.set('epsilon', '0.01');
model.param.descr('epsilon', 'Excitability');
model.param.set('beta', '0.5');
model.param.descr('beta', 'System parameter');
model.param.set('gamma', '1');
model.param.descr('gamma', 'System parameter');
model.param.set('delta', '0');
model.param.descr('delta', 'System parameter');
model.param.set('V0', '1');
model.param.descr('V0', 'Elevated potential value');
model.param.set('nu0', '0.3');
model.param.descr('nu0', 'Elevated inhibitor value');
model.param.set('d', '1e-5');
model.param.descr('d', 'Off-axis shift distance');

model.geom('geom1').run;

model.physics('g').feature('gfeq1').setIndex('Ga', {'0' '-u2y' '-u2z'}, 1);
model.physics('g').feature('gfeq1').setIndex('Ga', {'0' '0' '-u2z'}, 1);
model.physics('g').feature('gfeq1').setIndex('Ga', [0 0 0], 1);
model.physics('g').feature('gfeq1').setIndex('f', '(alpha-u1)*(u1-1)*u1-u2', 0);
model.physics('g').feature('gfeq1').setIndex('f', 'epsilon*(beta*u1-gamma*u2-delta)', 1);
model.physics('g').feature('init1').set('u1', 'V0*((x+d)>0)*((z+d)>0)');
model.physics('g').feature('init1').set('u2', 'nu0*((-x+d)>0)*((z+d)>0)');

model.mesh('mesh1').autoMeshSize(4);
model.mesh('mesh1').run;

model.study('std1').feature('time').set('tlist', 'range(0,5,500)');

model.sol.create('sol1');
model.sol('sol1').study('std1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'time');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').set('control', 'time');
model.sol('sol1').create('t1', 'Time');
model.sol('sol1').feature('t1').set('tlist', 'range(0,5,500)');
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
model.sol('sol1').runAll;

model.result.create('pg1', 'PlotGroup3D');
model.result('pg1').set('data', 'dset1');
model.result('pg1').setIndex('looplevel', 101, 0);
model.result('pg1').create('slc1', 'Slice');
model.result('pg1').label('General Form PDE');
model.result('pg1').feature('slc1').set('expr', 'u1');
model.result('pg1').run;
model.result.dataset('dset1').selection.geom('geom1', 2);
model.result.dataset('dset1').selection.geom('geom1', 2);
model.result.dataset('dset1').selection.set([1 3 10 11 12 13 14 15 16 17 18]);

model.selection.create('sel1', 'Explicit');
model.selection('sel1').model('comp1');
model.selection('sel1').geom(2);
model.selection('sel1').label('Explicit 1');
model.selection('sel1').set([1 3 10 11 12 13 14 15 16 17 18]);

model.result.dataset('dset1').selection.named('sel1');
model.result.create('pg2', 'PlotGroup3D');
model.result('pg2').run;
model.result('pg2').set('edges', false);
model.result('pg2').create('surf1', 'Surface');
model.result('pg2').run;

model.view('view1').set('transparency', false);

model.result('pg2').run;
model.result('pg2').setIndex('looplevel', 25, 0);
model.result('pg2').run;

model.physics.create('g2', 'GeneralFormPDE', 'geom1', {'v1' 'v2'});

model.study('std1').feature('time').setSolveFor('/physics/g2', false);

model.physics('g2').prop('EquationForm').set('form', 'Automatic');
model.physics('g2').field('dimensionless').field('v');

model.study.create('std2');
model.study('std2').create('time', 'Transient');
model.study('std2').feature('time').setSolveFor('/physics/g', false);
model.study('std2').feature('time').setSolveFor('/physics/g2', true);

model.param.set('c1', '2');
model.param.descr('c1', 'PDE parameter');
model.param.set('c3', '-0.2');
model.param.descr('c3', 'PDE parameter');

model.physics('g2').prop('ShapeProperty').set('shapeFunctionType', 'shherm');
model.physics('g2').feature('gfeq1').setIndex('Ga', {'-v1x+c1*v2x' '-v1y' '-v1z'}, 0);
model.physics('g2').feature('gfeq1').setIndex('Ga', {'-v1x+c1*v2x' '-v1y+c1*v2y' '-v1z'}, 0);
model.physics('g2').feature('gfeq1').setIndex('Ga', {'-v1x+c1*v2x' '-v1y+c1*v2y' '-v1z+c1*v2z'}, 0);
model.physics('g2').feature('gfeq1').setIndex('Ga', {'-c1*v1x-v2x' '-v2y' '-v2z'}, 1);
model.physics('g2').feature('gfeq1').setIndex('Ga', {'-c1*v1x-v2x' '-c1*v1y-v2y' '-v2z'}, 1);
model.physics('g2').feature('gfeq1').setIndex('Ga', {'-c1*v1x-v2x' '-c1*v1y-v2y' '-c1*v1z-v2z'}, 1);
model.physics('g2').feature('gfeq1').setIndex('f', 'v1-(v1-c3*v2)*(v1^2+v2^2)', 0);
model.physics('g2').feature('gfeq1').setIndex('f', 'v2-(c3*v1+v2)*(v1^2+v2^2)', 1);
model.physics('g2').feature('init1').set('v1', 'tanh(z[1/m])');
model.physics('g2').feature('init1').set('v2', '-tanh(z[1/m])');

model.study('std2').feature('time').set('tlist', 'range(0,5,75)');
model.study('std2').feature('time').set('usertol', true);
model.study('std2').feature('time').set('rtol', 0.001);

model.sol.create('sol2');
model.sol('sol2').study('std2');
model.sol('sol2').create('st1', 'StudyStep');
model.sol('sol2').feature('st1').set('study', 'std2');
model.sol('sol2').feature('st1').set('studystep', 'time');
model.sol('sol2').create('v1', 'Variables');
model.sol('sol2').feature('v1').set('control', 'time');
model.sol('sol2').create('t1', 'Time');
model.sol('sol2').feature('t1').set('tlist', 'range(0,5,75)');
model.sol('sol2').feature('t1').set('plot', 'off');
model.sol('sol2').feature('t1').set('plotgroup', 'pg1');
model.sol('sol2').feature('t1').set('plotfreq', 'tout');
model.sol('sol2').feature('t1').set('probesel', 'all');
model.sol('sol2').feature('t1').set('probes', {});
model.sol('sol2').feature('t1').set('probefreq', 'tsteps');
model.sol('sol2').feature('t1').set('atolglobalvaluemethod', 'factor');
model.sol('sol2').feature('t1').set('endtimeinterpolation', true);
model.sol('sol2').feature('t1').set('control', 'time');
model.sol('sol2').feature('t1').create('fc1', 'FullyCoupled');
model.sol('sol2').feature('t1').feature('fc1').set('linsolver', 'dDef');
model.sol('sol2').feature('t1').feature.remove('fcDef');
model.sol('sol2').attach('std2');
model.sol('sol2').feature('t1').set('atolglobalvaluemethod', 'manual');
model.sol('sol2').feature('t1').set('atolglobal', '0.0001');
model.sol('sol2').runAll;

model.result.create('pg3', 'PlotGroup3D');
model.result('pg3').set('data', 'dset2');
model.result('pg3').setIndex('looplevel', 16, 0);
model.result('pg3').create('slc1', 'Slice');
model.result('pg3').label('General Form PDE 2');
model.result('pg3').feature('slc1').set('expr', 'v1');
model.result('pg3').run;
model.result.dataset('dset2').selection.geom('geom1', 2);
model.result.dataset('dset2').selection.named('sel1');
model.result.create('pg4', 'PlotGroup3D');
model.result('pg4').run;
model.result('pg4').set('data', 'dset2');
model.result('pg4').set('edges', false);
model.result('pg4').create('surf1', 'Surface');
model.result('pg4').feature('surf1').set('expr', 'v1');
model.result('pg4').feature('surf1').set('descr', 'Dependent variable v1');
model.result('pg4').run;
model.result('pg4').run;
model.result('pg4').setIndex('looplevel', 10, 0);
model.result('pg4').run;

model.title('Electrical Signals in a Heart');

model.description(['In this example, two mathematical models ' native2unicode(hex2dec({'20' '14'}), 'unicode') ' based on the FitzHugh' native2unicode(hex2dec({'20' '13'}), 'unicode') 'Nagumo and the complex Ginzburg' native2unicode(hex2dec({'20' '13'}), 'unicode') 'Landau equations, respectively ' native2unicode(hex2dec({'20' '14'}), 'unicode') ' are used to describe different aspects of electrical signal propagation in cardiac tissue.']);

model.mesh.clearMeshes;

model.sol('sol1').clearSolutionData;
model.sol('sol2').clearSolutionData;

model.label('heart_electrical.mph');

model.modelNode.label('Components');

out = model;
