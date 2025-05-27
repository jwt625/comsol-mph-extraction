function out = model
%
% sagnac_interferometer.m
%
% Model exported on May 26 2025, 21:32 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/Ray_Optics_Module/Spectrometers_and_Monochromators');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 2);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.physics.create('gop', 'GeometricalOptics', 'geom1');
model.physics('gop').model('comp1');

model.study.create('std1');
model.study('std1').create('rtrac', 'RayTracing');
model.study('std1').feature('rtrac').setSolveFor('/physics/gop', true);

% To import content from file, use:
% model.param.loadFile('FILENAME');
model.param.set('Omega', '10[deg/h]', 'Interferometer angular velocity');
model.param.set('lam0', '632.8[nm]', 'Vacuum wavelength');
model.param.set('R', '10[cm]', 'Ring radius');
model.param.set('th', '3[cm]', 'Out-of-plane thickness');
model.param.set('A', '0.5*(1.5*R)*(R*sqrt(3))', 'Triangle area');
model.param.set('P', '3*(R*sqrt(3))', 'Triangle perimeter');
model.param.set('phi0', '30[deg]', 'Initial ray angle');
model.param.set('xc', 'R', 'Center of rotation, x-coordinate');
model.param.set('yc', '0', 'Center of rotation, y-coordinate');
model.param.set('wm', '3[cm]', 'Mirror width');
model.param.set('hm', '2[mm]', 'Mirror height');
model.param.set('xm1', 'xc+(R+hm/2)*sin(phi0)', 'Lower right mirror center, x-coordinate');
model.param.set('ym1', 'yc-(R+hm/2)*cos(phi0)', 'Lower right mirror center, y-coordinate');
model.param.set('xm2', 'xc+(R+hm/2)*sin(phi0)', 'Upper right mirror center, x-coordinate');
model.param.set('ym2', 'yc+(R+hm/2)*cos(phi0)', 'Upper right mirror center, y-coordinate');
model.param.set('ws', '3[cm]', 'Beam splitter width');
model.param.set('hs', '2[mm]', 'Beam splitter height');
model.param.set('L0x', 'cos(phi0)', 'Initial ray direction, x-component');
model.param.set('L0y', 'sin(phi0)', 'Initial ray direction, y-component');
model.param.set('q0x', '-5[cm]*L0x', 'Ray release, x-coordinate');
model.param.set('q0y', '-5[cm]*L0y', 'Ray release, y-coordinate');
model.param.set('Lo', '3[cm]', 'Distance to obstruction');
model.param.set('wo', '3[cm]', 'Obstruction width');
model.param.set('ho', '2[mm]', 'Obstruction height');
model.param.set('xo', '-(Lo+ho/2)*L0x', 'Center of obstruction, x-coordinate');
model.param.set('yo', '(Lo+ho/2)*L0y', 'Center of obstruction, y-coordinate');
model.param.set('dphi', '8*pi*A/(c_const*lam0)*Omega', 'Expected phase shift');
model.param.set('zf', '4*A/(c_const*lam0)*Omega', 'Expected fringe shift');
model.param.set('dt_exp', '4*A*Omega/c_const^2', 'Expected transit time difference');
model.param.set('dL_exp', 'dt_exp*c_const', 'Expected path difference');
model.param.set('nu', 'c_const/lam0', 'Frequency');
model.param.set('dnu_exp', '4*A*Omega/(lam0*P)', 'Expected beat frequency');
model.param.set('SF_exp', '4*A/(lam0*P)', 'Expected scale factor');
model.param.set('Omega_t', 'P*eps*c_const/(4*A)', 'Threshold for cancellation error');

model.geom('geom1').lengthUnit('cm');
model.geom('geom1').create('r1', 'Rectangle');
model.geom('geom1').feature('r1').label('Bottom-Right Mirror');
model.geom('geom1').feature('r1').set('size', {'wm' 'hm'});
model.geom('geom1').feature('r1').set('base', 'center');
model.geom('geom1').feature('r1').set('pos', {'xm1' 'ym1'});
model.geom('geom1').feature('r1').set('rot', 30);
model.geom('geom1').run('r1');
model.geom('geom1').create('r2', 'Rectangle');
model.geom('geom1').feature('r2').label('Top-Right Mirror');
model.geom('geom1').feature('r2').set('size', {'wm' 'hm'});
model.geom('geom1').feature('r2').set('base', 'center');
model.geom('geom1').feature('r2').set('pos', {'xm2' 'ym2'});
model.geom('geom1').feature('r2').set('rot', 150);
model.geom('geom1').run('r2');
model.geom('geom1').create('r3', 'Rectangle');
model.geom('geom1').feature('r3').label('Beam Splitter');
model.geom('geom1').feature('r3').set('size', {'ws' 'hs'});
model.geom('geom1').feature('r3').set('base', 'center');
model.geom('geom1').feature('r3').setIndex('layername', 'Layer 1', 0);
model.geom('geom1').feature('r3').setIndex('layer', 'hs/2', 0);
model.geom('geom1').run('r3');
model.geom('geom1').create('r4', 'Rectangle');
model.geom('geom1').feature('r4').label('Obstruction');
model.geom('geom1').feature('r4').set('size', {'wo' 'ho'});
model.geom('geom1').feature('r4').set('base', 'center');
model.geom('geom1').feature('r4').set('pos', {'xo' 'yo'});
model.geom('geom1').feature('r4').set('rot', 60);
model.geom('geom1').runPre('fin');

model.common.create('rot1', 'RotatingDomain', 'comp1');
model.common('rot1').selection.all;

model.geom('geom1').run;

model.common('rot1').set('rotationType', 'rotationalVelocity');
model.common('rot1').set('angularVelocity', 'Omega');
model.common('rot1').set('rotationAxisBasePoint', {'xc' 'yc' '0'});

model.variable.create('var1');
model.variable('var1').model('comp1');

% To import content from file, use:
% model.variable('var1').loadFile('FILENAME');
model.variable('var1').set('L1', 'gop.gopop1(if(gop.pidx==1,gop.L,0))', 'Optical path length, first ray');
model.variable('var1').set('L4', 'gop.gopop1(if(gop.pidx==4,gop.L,0))', 'Optical path length, fourth ray');
model.variable('var1').set('dL', 'L4-L1', 'Optical path difference');
model.variable('var1').set('dnu', 'dL/P*nu', 'Beat frequency');
model.variable('var1').set('SF', 'dnu/Omega', 'Scale factor');

model.physics('gop').prop('MaximumSecondary').setIndex('MaximumSecondary', 3, 0);
model.physics('gop').prop('IntensityComputation').setIndex('IntensityComputation', 'ComputeIntensity', 0);
model.physics('gop').prop('ComputeOpticalPathLength').setIndex('ComputeOpticalPathLength', 1, 0);
model.physics('gop').feature('op1').set('lambda0', 'lam0');
model.physics('gop').create('matd2', 'MaterialDiscontinuity', 1);
model.physics('gop').feature('matd2').selection.set([6 9]);
model.physics('gop').feature('matd2').set('ReleaseReflectedRays', 'Never');
model.physics('gop').feature('matd2').label('ARC');
model.physics('gop').create('matd3', 'MaterialDiscontinuity', 1);
model.physics('gop').feature('matd3').selection.set([8]);
model.physics('gop').feature('matd3').label('Beam Splitter');
model.physics('gop').feature('matd3').set('ThinDielectricFilmsOnBoundary', 'SpecifyReflectance');
model.physics('gop').feature('matd3').set('Rf', 0.5);
model.physics('gop').create('mir1', 'Mirror', 1);
model.physics('gop').feature('mir1').selection.set([13 15]);
model.physics('gop').feature('mir1').label('Mirrors');
model.physics('gop').create('wall1', 'Wall', 1);
model.physics('gop').feature('wall1').selection.set([3]);
model.physics('gop').feature('wall1').label('Obstruction');
model.physics('gop').create('relg1', 'ReleaseGrid', -1);
model.physics('gop').feature('relg1').setIndex('x0', 'q0x', 0);
model.physics('gop').feature('relg1').setIndex('x0', 'q0y', 1);
model.physics('gop').feature('relg1').set('L0', {'L0x' 'L0y' '0'});
model.physics('gop').create('rt1', 'RayTermination', -1);
model.physics('gop').feature('rt1').set('SpatialExtentsOfRayPropagation', 'BoundingBoxFromGeometry');

model.material.create('mat1', 'Common', 'comp1');
model.material('mat1').propertyGroup.create('RefractiveIndex', 'Refractive_index');
model.material('mat1').propertyGroup('RefractiveIndex').set('n', {'1.5'});

model.study('std1').create('param', 'Parametric');
model.study('std1').feature('param').setIndex('pname', 'Omega', 0);
model.study('std1').feature('param').setIndex('plistarr', '', 0);
model.study('std1').feature('param').setIndex('punit', 'rad/s', 0);
model.study('std1').feature('param').setIndex('pname', 'Omega', 0);
model.study('std1').feature('param').setIndex('plistarr', '', 0);
model.study('std1').feature('param').setIndex('punit', 'rad/s', 0);
model.study('std1').feature('param').setIndex('pname', 'Omega', 0);
model.study('std1').feature('param').setIndex('plistarr', '10^{range(0,0.2,5)}', 0);
model.study('std1').feature('param').setIndex('punit', 'deg/h', 0);
model.study('std1').feature('rtrac').set('timestepspec', 'specifylength');
model.study('std1').feature('rtrac').set('lunit', 'cm');
model.study('std1').feature('rtrac').set('llist', '0 1.5*P');

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

model.batch.create('p1', 'Parametric');
model.batch('p1').study('std1');
model.batch('p1').create('so1', 'Solutionseq');
model.batch('p1').feature('so1').set('seq', 'sol1');
model.batch('p1').feature('so1').set('store', 'on');
model.batch('p1').feature('so1').set('clear', 'on');
model.batch('p1').feature('so1').set('psol', 'none');
model.batch('p1').set('pname', {'Omega'});
model.batch('p1').set('plistarr', {'10^{range(0,0.2,5)}'});
model.batch('p1').set('sweeptype', 'sparse');
model.batch('p1').set('probesel', 'all');
model.batch('p1').set('probes', {});
model.batch('p1').set('plot', 'off');
model.batch('p1').set('err', 'on');
model.batch('p1').attach('std1');
model.batch('p1').set('control', 'param');

model.sol.create('sol2');
model.sol('sol2').study('std1');
model.sol('sol2').label('Parametric Solutions 1');

model.batch('p1').feature('so1').set('psol', 'sol2');
model.batch('p1').run('compute');

model.result.dataset.create('ray1', 'Ray');
model.result.dataset('ray1').set('solution', 'sol2');
model.result.dataset('ray1').set('posdof', {'comp1.qx' 'comp1.qy'});
model.result.dataset('ray1').set('geom', 'geom1');
model.result.dataset('ray1').set('rgeom', 'pgeom_gop');
model.result.dataset('ray1').set('rgeomspec', 'fromphysics');
model.result.dataset('ray1').set('physicsinterface', 'gop');
model.result.create('pg1', 'PlotGroup2D');
model.result('pg1').set('data', 'ray1');
model.result('pg1').setIndex('looplevel', 2, 0);
model.result('pg1').setIndex('looplevel', 26, 1);
model.result('pg1').label('Ray Trajectories (gop)');
model.result('pg1').create('rtrj1', 'RayTrajectories');
model.result('pg1').feature('rtrj1').set('linetype', 'line');
model.result('pg1').feature('rtrj1').create('col1', 'Color');
model.result('pg1').feature('rtrj1').feature('col1').set('expr', 'gop.I');
model.result('pg1').feature('rtrj1').create('filt1', 'RayTrajectoriesFilter');
model.result('pg1').run;
model.result('pg1').run;
model.result('pg1').feature('rtrj1').feature('col1').set('expr', 'gop.pidx');
model.result('pg1').feature('rtrj1').feature('col1').set('descr', 'Ray index');
model.result('pg1').run;
model.result.create('pg2', 'PlotGroup1D');
model.result('pg2').run;
model.result('pg2').label('Beat Frequency');
model.result('pg2').set('data', 'ray1');
model.result('pg2').setIndex('looplevelinput', 'last', 0);
model.result('pg2').create('glob1', 'Global');
model.result('pg2').feature('glob1').set('markerpos', 'datapoints');
model.result('pg2').feature('glob1').set('linewidth', 'preference');
model.result('pg2').feature('glob1').set('expr', {'dnu'});
model.result('pg2').feature('glob1').set('descr', {'Beat frequency'});
model.result('pg2').feature('glob1').set('unit', {'1/s'});
model.result('pg2').feature('glob1').set('xdatasolnumtype', 'outer');
model.result('pg2').feature('glob1').set('linemarker', 'point');
model.result('pg2').run;
model.result('pg2').set('xlog', true);
model.result('pg2').set('ylog', true);
model.result('pg2').run;
model.result.duplicate('pg3', 'pg2');
model.result('pg3').run;
model.result('pg3').label('Scale Factor');
model.result('pg3').run;
model.result('pg3').feature('glob1').set('expr', {'SF'});
model.result('pg3').feature('glob1').set('descr', {'Scale factor'});
model.result('pg3').feature('glob1').set('unit', {'rad'});
model.result('pg3').feature('glob1').set('expr', {'SF' 'SF_exp'});
model.result('pg3').feature('glob1').set('descr', {'Scale factor' 'Expected scale factor'});
model.result('pg3').run;

model.title('Sagnac Interferometer');

model.description('This is a model of a simple Sagnac interferometer consisting of two mirrors and a beam splitter arranged in a triangle. The entire modeling domain rotates; as a result, the rays propagating in opposite directions in the triangle have different optical path lengths due to the Sagnac effect. This can be used to deduce the angular velocity of the system.');

model.mesh.clearMeshes;

model.sol('sol1').clearSolutionData;
model.sol('sol2').clearSolutionData;
model.sol('sol3').clearSolutionData;
model.sol('sol4').clearSolutionData;
model.sol('sol5').clearSolutionData;
model.sol('sol6').clearSolutionData;
model.sol('sol7').clearSolutionData;
model.sol('sol8').clearSolutionData;
model.sol('sol9').clearSolutionData;
model.sol('sol10').clearSolutionData;
model.sol('sol11').clearSolutionData;
model.sol('sol12').clearSolutionData;
model.sol('sol13').clearSolutionData;
model.sol('sol14').clearSolutionData;
model.sol('sol15').clearSolutionData;
model.sol('sol16').clearSolutionData;
model.sol('sol17').clearSolutionData;
model.sol('sol18').clearSolutionData;
model.sol('sol19').clearSolutionData;
model.sol('sol20').clearSolutionData;
model.sol('sol21').clearSolutionData;
model.sol('sol22').clearSolutionData;
model.sol('sol23').clearSolutionData;
model.sol('sol24').clearSolutionData;
model.sol('sol25').clearSolutionData;
model.sol('sol26').clearSolutionData;
model.sol('sol27').clearSolutionData;
model.sol('sol28').clearSolutionData;

model.label('sagnac_interferometer.mph');

model.modelNode.label('Components');

out = model;
