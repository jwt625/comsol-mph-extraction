function out = model
%
% fresnel_rhomb.m
%
% Model exported on May 26 2025, 21:32 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/Ray_Optics_Module/Prisms_and_Coatings');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 3);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.physics.create('ge', 'GlobalEquations', 'geom1');
model.physics('ge').model('comp1');
model.physics('ge').prop('EquationForm').set('form', 'Automatic');

model.study.create('std1');
model.study('std1').create('stat', 'Stationary');
model.study('std1').feature('stat').setSolveFor('/physics/ge', true);

model.param.set('delta', '45[deg]');
model.param.descr('delta', 'Phase delay between s- and p-polarizations');
model.param.set('n1', '1');
model.param.descr('n1', 'Refractive index, air');
model.param.set('n2', '1.51');
model.param.descr('n2', 'Refractive index, glass');
model.param.set('n12', 'n1/n2');
model.param.descr('n12', 'Refractive index ratio');

model.geom('geom1').run;

model.physics('ge').feature('ge1').setIndex('name', 'thetai', 0, 0);
model.physics('ge').feature('ge1').setIndex('equation', 'cos(thetai)*sqrt(sin(thetai)^2-n12^2)/sin(thetai)^2-tan(delta/2)', 0, 0);
model.physics('ge').feature('ge1').setIndex('initialValueU', '45[deg]', 0, 0);

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

model.result.numerical.create('gev1', 'EvalGlobal');
model.result.numerical('gev1').set('data', 'dset1');
model.result.numerical('gev1').set('expr', {'thetai'});
model.result.numerical('gev1').set('descr', {'State variable thetai'});
model.result.table.create('tbl1', 'Table');
model.result.table('tbl1').comments('Global Evaluation 1');
model.result.numerical('gev1').set('table', 'tbl1');
model.result.numerical('gev1').setResult;

model.param.set('theta', '0.84855[rad]');
model.param.descr('theta', 'Angle of incidence');

model.geom('geom1').create('wp1', 'WorkPlane');
model.geom('geom1').feature('wp1').set('unite', true);
model.geom('geom1').feature('wp1').geom.create('pol1', 'Polygon');
model.geom('geom1').feature('wp1').geom.feature('pol1').set('source', 'table');
model.geom('geom1').feature('wp1').geom.feature('pol1').setIndex('table', 0, 0, 0);
model.geom('geom1').feature('wp1').geom.feature('pol1').setIndex('table', 0, 0, 1);
model.geom('geom1').feature('wp1').geom.feature('pol1').setIndex('table', 1, 1, 0);
model.geom('geom1').feature('wp1').geom.feature('pol1').setIndex('table', 0, 1, 1);
model.geom('geom1').feature('wp1').geom.feature('pol1').setIndex('table', 'cos(theta)+1', 2, 0);
model.geom('geom1').feature('wp1').geom.feature('pol1').setIndex('table', 'sin(theta)', 2, 1);
model.geom('geom1').feature('wp1').geom.feature('pol1').setIndex('table', 'cos(theta)', 3, 0);
model.geom('geom1').feature('wp1').geom.feature('pol1').setIndex('table', 'sin(theta)', 3, 1);
model.geom('geom1').feature('wp1').geom.run('pol1');
model.geom('geom1').run('wp1');
model.geom('geom1').feature.create('ext1', 'Extrude');
model.geom('geom1').feature('ext1').set('workplane', 'wp1');
model.geom('geom1').feature('ext1').selection('input').set({'wp1'});
model.geom('geom1').runPre('fin');

model.physics.create('gop', 'GeometricalOptics', 'geom1');
model.physics('gop').model('comp1');

model.study('std1').feature('stat').setSolveFor('/physics/gop', false);

model.geom('geom1').run;

model.study.create('std2');
model.study('std2').create('rtrac', 'RayTracing');
model.study('std2').feature('rtrac').setSolveFor('/physics/ge', false);
model.study('std2').feature('rtrac').setSolveFor('/physics/gop', true);

model.material.create('mat1', 'Common', 'comp1');
model.material('mat1').label('Glass');
model.material('mat1').propertyGroup.create('RefractiveIndex', 'Refractive_index');
model.material('mat1').propertyGroup('RefractiveIndex').set('n', {'n2'});

model.physics('gop').prop('ExteriorUnmeshedProperties').setIndex('next', 'n1', 0);
model.physics('gop').prop('MaximumSecondary').setIndex('MaximumSecondary', 0, 0);
model.physics('gop').prop('IntensityComputation').setIndex('IntensityComputation', 'ComputeIntensity', 0);
model.physics('gop').prop('ComputeOpticalPathLength').setIndex('ComputeOpticalPathLength', 1, 0);
model.physics('gop').create('relg1', 'ReleaseGrid', -1);
model.physics('gop').feature('relg1').setIndex('x0', 0.5, 1);
model.physics('gop').feature('relg1').setIndex('x0', 0.5, 2);
model.physics('gop').feature('relg1').set('L0', {'sin(theta)' '-cos(theta)' '0'});
model.physics('gop').feature('relg1').set('InitialPolarizationType', 'FullyPolarized');
model.physics('gop').feature('relg1').set('InitialPolarization', 'UserDefined');
model.physics('gop').feature('relg1').set('a20', 1);
model.physics('gop').create('matd2', 'MaterialDiscontinuity', 2);
model.physics('gop').feature('matd2').selection.set([1 6]);
model.physics('gop').feature('matd2').set('ThinDielectricFilmsOnBoundary', 'AntiReflectiveCoating');

model.study('std2').feature('rtrac').set('timestepspec', 'specifylength');
model.study('std2').feature('rtrac').set('llist', 'range(0,0.4,4)');

model.sol.create('sol2');
model.sol('sol2').study('std2');
model.sol('sol2').create('st1', 'StudyStep');
model.sol('sol2').feature('st1').set('study', 'std2');
model.sol('sol2').feature('st1').set('studystep', 'rtrac');
model.sol('sol2').create('v1', 'Variables');
model.sol('sol2').feature('v1').set('control', 'rtrac');
model.sol('sol2').create('t1', 'Time');
model.sol('sol2').feature('t1').set('tlist', 'range(0,0.01,1)');
model.sol('sol2').feature('t1').set('plot', 'off');
model.sol('sol2').feature('t1').set('plotgroup', 'Default');
model.sol('sol2').feature('t1').set('plotfreq', 'tout');
model.sol('sol2').feature('t1').set('probesel', 'all');
model.sol('sol2').feature('t1').set('probes', {});
model.sol('sol2').feature('t1').set('probefreq', 'tsteps');
model.sol('sol2').feature('t1').set('rtol', 1.0E-5);
model.sol('sol2').feature('t1').set('atolglobalvaluemethod', 'factor');
model.sol('sol2').feature('t1').set('reacf', false);
model.sol('sol2').feature('t1').set('storeudot', false);
model.sol('sol2').feature('t1').set('tstepsgenalpha', 'strict');
model.sol('sol2').feature('t1').set('endtimeinterpolation', true);
model.sol('sol2').feature('t1').set('timemethod', 'genalpha');
model.sol('sol2').feature('t1').set('estrat', 'exclude');
model.sol('sol2').feature('t1').set('control', 'rtrac');
model.sol('sol2').feature('t1').create('fc1', 'FullyCoupled');
model.sol('sol2').feature('t1').feature('fc1').set('ntolfact', 0.1);
model.sol('sol2').feature('t1').create('i1', 'Iterative');
model.sol('sol2').feature('t1').feature('i1').set('linsolver', 'gmres');
model.sol('sol2').feature('t1').feature('i1').create('ja1', 'Jacobi');
model.sol('sol2').feature('t1').feature('fc1').set('linsolver', 'i1');
model.sol('sol2').feature('t1').feature('fc1').set('ntolfact', 0.1);
model.sol('sol2').feature('t1').feature.remove('fcDef');
model.sol('sol2').attach('std2');
model.sol('sol2').runAll;

model.result.dataset.create('ray1', 'Ray');
model.result.dataset('ray1').set('solution', 'sol2');
model.result.dataset('ray1').set('posdof', {'comp1.qx' 'comp1.qy' 'comp1.qz'});
model.result.dataset('ray1').set('geom', 'geom1');
model.result.dataset('ray1').set('rgeom', 'pgeom_gop');
model.result.dataset('ray1').set('rgeomspec', 'fromphysics');
model.result.dataset('ray1').set('physicsinterface', 'gop');
model.result.create('pg1', 'PlotGroup3D');
model.result('pg1').set('data', 'ray1');
model.result('pg1').setIndex('looplevel', 11, 0);
model.result('pg1').label('Ray Trajectories (gop)');
model.result('pg1').create('rtrj1', 'RayTrajectories');
model.result('pg1').feature('rtrj1').set('linetype', 'line');
model.result('pg1').feature('rtrj1').create('col1', 'Color');
model.result('pg1').feature('rtrj1').feature('col1').set('expr', 'gop.I');
model.result('pg1').feature('rtrj1').create('filt1', 'RayTrajectoriesFilter');
model.result('pg1').run;
model.result('pg1').run;
model.result('pg1').feature('rtrj1').set('pointtype', 'ellipse');
model.result('pg1').feature('rtrj1').set('ellipsecount', 15);
model.result('pg1').run;
model.result('pg1').feature('rtrj1').feature('col1').set('expr', 'gop.L');
model.result('pg1').feature('rtrj1').feature('col1').set('descr', 'Optical path length');
model.result('pg1').feature('rtrj1').feature('col1').set('colortable', 'Magma');
model.result('pg1').run;

model.view('view1').camera.set('zoomanglefull', 6.4);
model.view('view1').camera.setIndex('position', 15.6, 0);
model.view('view1').camera.setIndex('position', -2.86, 1);
model.view('view1').camera.set('position', [15.6 -2.86 6.07]);
model.view('view1').camera.setIndex('target', 1.004, 0);
model.view('view1').camera.setIndex('target', 0.2, 1);
model.view('view1').camera.set('target', [1.004 0.2 0.5]);
model.view('view1').camera.setIndex('up', 0.215, 0);
model.view('view1').camera.setIndex('up', 0.978, 1);
model.view('view1').camera.set('up', [0.215 0.978 0.0095]);
model.view('view1').camera.setIndex('rotationpoint', 1, 0);
model.view('view1').camera.set('rotationpoint', [1 0.23 0]);
model.view('view1').camera.setIndex('viewoffset', -0.0048, 0);
model.view('view1').camera.set('viewoffset', [-0.0048 -0.1414]);
model.view('view1').set('showgrid', false);

model.result('pg1').run;
model.result.create('pg2', 'PlotGroup1D');
model.result('pg2').run;
model.result('pg2').set('data', 'ray1');
model.result('pg2').set('titletype', 'manual');
model.result('pg2').set('title', 'Degree of circular polarization');
model.result('pg2').set('ylabelactive', true);
model.result('pg2').set('ylabel', 'Degree of circular polarization');
model.result('pg2').create('rtp1', 'Ray1D');
model.result('pg2').feature('rtp1').set('markerpos', 'datapoints');
model.result('pg2').feature('rtp1').set('linewidth', 'preference');
model.result('pg2').feature('rtp1').set('expr', 'gop.s3/gop.s0');
model.result('pg2').run;
model.result('pg1').run;

model.title('Fresnel Rhomb');

model.description('A Fresnel rhomb is a prism that uses total internal reflection to manipulate the polarization of light. In this example, light in the prism is internally reflected at an angle of incidence that induces a 45-degree phase delay between s- and p-polarized radiation. By subjecting the light to two such reflections, the prism converts incoming linearly polarized light to circularly polarized light.');

model.label('fresnel_rhomb.mph');

model.modelNode.label('Components');

out = model;
