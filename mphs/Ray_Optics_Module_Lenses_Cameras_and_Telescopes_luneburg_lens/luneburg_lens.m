function out = model
%
% luneburg_lens.m
%
% Model exported on May 26 2025, 21:32 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/Ray_Optics_Module/Lenses_Cameras_and_Telescopes');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 3);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.physics.create('gop', 'GeometricalOptics', 'geom1');
model.physics('gop').model('comp1');

model.study.create('std1');
model.study('std1').create('rtrac', 'RayTracing');
model.study('std1').feature('rtrac').setSolveFor('/physics/gop', true);

model.param.set('L', '1[m]');
model.param.descr('L', 'Box length');
model.param.set('R', '0.4[m]');
model.param.descr('R', 'Outer radius');

model.geom('geom1').create('sph1', 'Sphere');
model.geom('geom1').feature('sph1').set('r', 'R');
model.geom('geom1').runPre('fin');

model.view('view1').camera.set('projection', 'orthographic');

model.variable.create('var1');
model.variable('var1').model('comp1');

model.geom('geom1').run;

model.variable('var1').set('r', 'sqrt(x^2+y^2+z^2+eps)');
model.variable('var1').descr('r', 'Radial coordinate');
model.variable('var1').set('f', '1.0');
model.variable('var1').descr('f', 'Focal shift parameter');
model.variable('var1').set('n', 'sqrt(1+f^2-(r/R)^2)/f');
model.variable('var1').descr('n', 'Refractive index');

model.material.create('mat1', 'Common', 'comp1');
model.material('mat1').propertyGroup.create('RefractiveIndex', 'Refractive_index');
model.material('mat1').propertyGroup('RefractiveIndex').set('n', {'n'});

model.physics('gop').prop('MaximumSecondary').setIndex('MaximumSecondary', 0, 0);
model.physics('gop').feature('matd1').set('ReleaseReflectedRays', 'Never');
model.physics('gop').create('relg1', 'ReleaseGrid', -1);
model.physics('gop').feature('relg1').set('GridType', 'Hexapolar');
model.physics('gop').feature('relg1').set('qcc', [-0.75 0 0]);
model.physics('gop').feature('relg1').set('Rc', 0.35);
model.physics('gop').feature('relg1').setIndex('Ncr', 10, 0);
model.physics('gop').feature('relg1').set('L0', [1 0 0]);

model.mesh('mesh1').run;

model.study('std1').feature('rtrac').set('timestepspec', 'specifylength');
model.study('std1').feature('rtrac').set('llist', 'range(0,0.05,1.75)');

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
model.sol('sol1').feature('t1').set('maxstepgenalpha', '2.5e-12');
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
model.result('pg1').setIndex('looplevel', 36, 0);
model.result('pg1').label('Ray Trajectories (gop)');
model.result('pg1').create('rtrj1', 'RayTrajectories');
model.result('pg1').feature('rtrj1').set('linetype', 'line');
model.result('pg1').feature('rtrj1').create('col1', 'Color');
model.result('pg1').feature('rtrj1').feature('col1').set('expr', 't');
model.result('pg1').feature('rtrj1').create('filt1', 'RayTrajectoriesFilter');
model.result('pg1').run;
model.result('pg1').label('Ray Diagram 1');
model.result('pg1').set('showlegendsunit', true);
model.result('pg1').run;
model.result('pg1').feature('rtrj1').feature('col1').set('expr', 'at(4.5975768e-9,gop.rrel)');
model.result('pg1').feature('rtrj1').feature('col1').set('unit', [native2unicode(hex2dec({'00' 'b5'}), 'unicode') 'm']);
model.result('pg1').feature('rtrj1').feature('col1').set('colortable', 'Plasma');
model.result('pg1').run;
model.result('pg1').create('surf1', 'Surface');
model.result('pg1').feature('surf1').set('coloring', 'uniform');
model.result('pg1').feature('surf1').set('color', 'gray');
model.result('pg1').feature('surf1').create('tran1', 'Transparency');
model.result('pg1').run;
model.result('pg1').feature('surf1').feature('tran1').set('uniformblending', 0.8);
model.result('pg1').run;
model.result('pg1').create('mslc1', 'Multislice');
model.result('pg1').feature('mslc1').set('expr', 'n');
model.result('pg1').feature('mslc1').set('xnumber', '0');
model.result('pg1').feature('mslc1').set('colortable', 'GrayScale');
model.result('pg1').feature('mslc1').set('colorlegend', false);
model.result('pg1').feature('mslc1').create('tran1', 'Transparency');
model.result('pg1').run;
model.result('pg1').feature('mslc1').feature('tran1').set('transparency', 0.2);
model.result('pg1').run;
model.result.create('pg2', 'PlotGroup2D');
model.result('pg2').run;
model.result('pg2').label('Spot Diagram');
model.result('pg2').set('showlegendsmaxmin', true);
model.result('pg2').set('showlegendsunit', true);
model.result('pg2').set('legendactive', true);
model.result('pg2').set('legendprecision', 8);
model.result('pg2').create('spot1', 'SpotDiagram');
model.result('pg2').feature('spot1').set('normal', 'userdefined');
model.result('pg2').feature('spot1').set('normalexpr', [1 0 0]);
model.result.dataset.create('ip1', 'IntersectionPoint3D');
model.result('pg2').feature('spot1').set('data', 'ip1');
model.result.dataset('ip1').set('data', 'ray1');
model.result.dataset('ip1').set('genmethod', 'pointnormal');
model.result.dataset('ip1').setIndex('genpnpoint', '0.45706464647540856[m]', 0);
model.result.dataset('ip1').setIndex('genpnpoint', '-9.0738829675944E-13[m]', 1);
model.result.dataset('ip1').setIndex('genpnpoint', '1.0691347102696938E-17[m]', 2);
model.result.dataset('ip1').set('genpnvec', [1 0 0]);
model.result('pg2').feature('spot1').run;
model.result.dataset('ip1').set('genmethod', 'pointnormal');
model.result.dataset('ip1').setIndex('genpnpoint', '0.40000036261898697[m]', 0);
model.result.dataset('ip1').setIndex('genpnpoint', '-1.2851225622439189E-12[m]', 1);
model.result.dataset('ip1').setIndex('genpnpoint', '1.458320708233554E-16[m]', 2);
model.result.dataset('ip1').set('genpnvec', [1 0 0]);
model.result('pg2').set('ispendingzoom', true);
model.result('pg2').feature('spot1').run;
model.result('pg2').feature('spot1').set('spotcoordsactive', true);
model.result('pg2').feature('spot1').set('spotcoordssystem', 'global');
model.result('pg2').feature('spot1').set('spotcoordsprecision', 6);
model.result('pg2').feature('spot1').set('spotsizeprecision', 4);
model.result('pg2').feature('spot1').create('col1', 'Color');
model.result('pg2').run;
model.result('pg2').feature('spot1').feature('col1').set('expr', 't');
model.result('pg2').feature('spot1').feature('col1').set('colortable', 'Plasma');
model.result('pg2').run;

model.title('Luneburg Lens');

model.description('A Luneburg lens has a graded refractive index which leads to special focusing properties. This example model uses the Geometrical Optics interface to compute the curved ray trajectories in the graded-index medium.');

model.label('luneburg_lens.mph');

model.modelNode.label('Components');

out = model;
