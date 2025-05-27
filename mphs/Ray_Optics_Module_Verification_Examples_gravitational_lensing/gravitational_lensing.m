function out = model
%
% gravitational_lensing.m
%
% Model exported on May 26 2025, 21:32 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/Ray_Optics_Module/Verification_Examples');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 3);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.physics.create('gop', 'GeometricalOptics', 'geom1');
model.physics('gop').model('comp1');

model.study.create('std1');
model.study('std1').create('rtrac', 'RayTracing');
model.study('std1').feature('rtrac').setSolveFor('/physics/gop', true);

model.param.set('r0', '7E5[km]');
model.param.descr('r0', 'Radius of the sun');
model.param.set('m0', '2E30[kg]');
model.param.descr('m0', 'Solar mass');

model.geom('geom1').lengthUnit('km');
model.geom('geom1').create('sph1', 'Sphere');
model.geom('geom1').feature('sph1').set('r', 'r0');
model.geom('geom1').run('sph1');
model.geom('geom1').create('blk1', 'Block');
model.geom('geom1').feature('blk1').set('size', {'2E8' '1E7' '1E7'});
model.geom('geom1').feature('blk1').set('pos', {'0.5E8' '0' '0'});
model.geom('geom1').feature('blk1').set('base', 'center');
model.geom('geom1').runPre('fin');

model.view('view1').set('renderwireframe', true);

model.variable.create('var1');
model.variable('var1').model('comp1');

model.geom('geom1').run;

model.variable('var1').set('r', 'sqrt(x^2+y^2+z^2+eps)');
model.variable('var1').descr('r', 'Radial distance from center of the sun');
model.variable('var1').set('n', '1+2*G_const*m0/(c_const^2*r)');
model.variable('var1').descr('n', 'Refractive index');

model.material.create('mat1', 'Common', 'comp1');
model.material('mat1').propertyGroup.create('RefractiveIndex', 'Refractive_index');
model.material('mat1').propertyGroup('RefractiveIndex').set('n', {'n'});

model.physics('gop').prop('MaximumSecondary').setIndex('MaximumSecondary', 0, 0);
model.physics('gop').create('relg1', 'ReleaseGrid', -1);
model.physics('gop').feature('relg1').setIndex('x0', '-0.5E8', 0);
model.physics('gop').feature('relg1').setIndex('x0', '-7.01E5 7.01E5', 1);
model.physics('gop').feature('relg1').set('L0', [1 0 0]);

model.mesh('mesh1').autoMeshSize(3);
model.mesh('mesh1').run;

model.study('std1').feature('rtrac').set('timestepspec', 'specifylength');
model.study('std1').feature('rtrac').set('lunit', 'km');
model.study('std1').feature('rtrac').set('llist', 'range(0,2020202.0202020202,200000000)');

model.sol.create('sol1');
model.sol('sol1').study('std1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'rtrac');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').set('control', 'rtrac');
model.sol('sol1').create('t1', 'Time');
model.sol('sol1').feature('t1').set('tlist', 'range(0,0.01,1)');
model.sol('sol1').feature('t1').set('plot', 'off');
model.sol('sol1').feature('t1').set('plotgroup', 'Default');
model.sol('sol1').feature('t1').set('plotfreq', 'tout');
model.sol('sol1').feature('t1').set('probesel', 'all');
model.sol('sol1').feature('t1').set('probes', {});
model.sol('sol1').feature('t1').set('probefreq', 'tsteps');
model.sol('sol1').feature('t1').set('rtol', 1.0E-5);
model.sol('sol1').feature('t1').set('atolglobalvaluemethod', 'factor');
model.sol('sol1').feature('t1').set('reacf', false);
model.sol('sol1').feature('t1').set('storeudot', false);
model.sol('sol1').feature('t1').set('tstepsgenalpha', 'strict');
model.sol('sol1').feature('t1').set('endtimeinterpolation', true);
model.sol('sol1').feature('t1').set('timemethod', 'genalpha');
model.sol('sol1').feature('t1').set('estrat', 'exclude');
model.sol('sol1').feature('t1').set('control', 'rtrac');
model.sol('sol1').feature('t1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('t1').feature('fc1').set('ntolfact', 0.1);
model.sol('sol1').feature('t1').create('i1', 'Iterative');
model.sol('sol1').feature('t1').feature('i1').set('linsolver', 'gmres');
model.sol('sol1').feature('t1').feature('i1').create('ja1', 'Jacobi');
model.sol('sol1').feature('t1').feature('fc1').set('linsolver', 'i1');
model.sol('sol1').feature('t1').feature('fc1').set('ntolfact', 0.1);
model.sol('sol1').feature('t1').feature.remove('fcDef');
model.sol('sol1').attach('std1');
model.sol('sol1').feature('t1').set('maxstepconstraintgenalpha', 'const');
model.sol('sol1').feature('t1').set('maxstepgenalpha', 1);
model.sol('sol1').runAll;

model.result.dataset.create('ray1', 'Ray');
model.result.dataset('ray1').set('solution', 'sol1');
model.result.dataset('ray1').set('posdof', {'comp1.qx' 'comp1.qy' 'comp1.qz'});
model.result.dataset('ray1').set('geom', 'geom1');
model.result.dataset('ray1').set('rgeom', 'pgeom_gop');
model.result.dataset('ray1').set('rgeomspec', 'fromphysics');
model.result.dataset('ray1').set('physicsinterface', 'gop');
model.result.create('pg1', 'PlotGroup3D');
model.result('pg1').set('data', 'ray1');
model.result('pg1').setIndex('looplevel', 100, 0);
model.result('pg1').label('Ray Trajectories (gop)');
model.result('pg1').create('rtrj1', 'RayTrajectories');
model.result('pg1').feature('rtrj1').set('linetype', 'line');
model.result('pg1').feature('rtrj1').create('col1', 'Color');
model.result('pg1').feature('rtrj1').feature('col1').set('expr', 't');
model.result('pg1').feature('rtrj1').create('filt1', 'RayTrajectoriesFilter');
model.result('pg1').run;
model.result('pg1').run;
model.result('pg1').feature('rtrj1').feature('col1').set('expr', 'asin(gop.niy)');
model.result('pg1').feature('rtrj1').feature('col1').set('unit', 'arcsec');
model.result('pg1').run;
model.result.numerical.create('ray1', 'Ray');
model.result.numerical('ray1').setIndex('looplevelinput', 'last', 0);
model.result.numerical('ray1').set('expr', 'asin(gop.niy)');
model.result.numerical('ray1').set('unit', 'arcsec');
model.result.table.create('tbl1', 'Table');
model.result.table('tbl1').comments('Ray Evaluation 1');
model.result.numerical('ray1').set('table', 'tbl1');
model.result.numerical('ray1').setResult;
model.result.create('pg2', 'PlotGroup1D');
model.result('pg2').run;
model.result('pg2').label('Deviation from Initial Direction');
model.result('pg2').set('data', 'ray1');
model.result('pg2').set('titletype', 'none');
model.result('pg2').set('ylabelactive', true);
model.result('pg2').set('ylabel', 'Deflection angle in arcseconds');
model.result('pg2').create('rtp1', 'Ray1D');
model.result('pg2').feature('rtp1').set('markerpos', 'datapoints');
model.result('pg2').feature('rtp1').set('linewidth', 'preference');
model.result('pg2').feature('rtp1').set('expr', 'abs(asin(gop.niy))');
model.result('pg2').feature('rtp1').set('unit', 'arcsec');
model.result('pg2').run;
model.result('pg2').feature('rtp1').set('dataseries', 'average');
model.result('pg2').run;

model.title('Gravitational Lensing');

model.description(['This example demonstrates how the sun causes 1.75' native2unicode(hex2dec({'00' 'a0'}), 'unicode') 'arcseconds of deflection for rays grazing the sun''s surface as observed from Earth. Einstein predicted this value after refining his theory of relativity during World War I.']);

model.label('gravitational_lensing.mph');

model.modelNode.label('Components');

out = model;
