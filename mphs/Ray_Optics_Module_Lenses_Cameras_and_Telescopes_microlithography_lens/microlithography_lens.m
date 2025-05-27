function out = model
%
% microlithography_lens.m
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

model.param.create('par2');
model.param('par2').set('NA', '0.56');
model.param('par2').descr('NA', 'Numerical aperture');
model.param('par2').set('mag', '0.25');
model.param('par2').descr('mag', 'Magnification');
model.param('par2').set('alpha', 'atan(NA)*mag');
model.param('par2').descr('alpha', 'Cone angle');
model.param('par2').set('nhex', '25');
model.param('par2').descr('nhex', 'Number of hexapolar rings');

model.geom('geom1').lengthUnit('mm');
model.geom('geom1').label('Microlithography Lens Geometry Sequence');
model.geom('geom1').insertFile('microlithography_lens_geom_sequence.mph', 'geom1');
model.geom('geom1').run('fin');

model.view('view1').camera.set('projection', 'orthographic');

model.physics('gop').prop('MaximumSecondary').setIndex('MaximumSecondary', 0, 0);
model.physics('gop').prop('ExteriorUnmeshedProperties').setIndex('DispersionModel', 'AbsoluteVacuum', 0);
model.physics('gop').prop('ComputeOpticalPathLength').setIndex('ComputeOpticalPathLength', 1, 0);
model.physics('gop').feature('mp1').set('n_mat', 'userdef');
model.physics('gop').feature('mp1').set('n', [1.5084 0 0 0 1.5084 0 0 0 1.5084]);
model.physics('gop').feature('matd1').set('ReleaseReflectedRays', 'Never');
model.physics('gop').feature('op1').set('lambda0', '248[nm]');
model.physics('gop').create('wall1', 'Wall', 2);
model.physics('gop').feature('wall1').label('Obstructions');
model.physics('gop').feature('wall1').selection.named('geom1_csel2_bnd');
model.physics('gop').feature('wall1').set('WallCondition', 'Disappear');
model.physics('gop').create('wall2', 'Wall', 2);
model.physics('gop').feature('wall2').label('Image');
model.physics('gop').feature('wall2').selection.named('geom1_pi23_sel1');
model.physics('gop').create('relg1', 'ReleaseGrid', -1);
model.physics('gop').feature('relg1').set('RayDirectionVector', 'Conical');
model.physics('gop').feature('relg1').set('ConicalDistribution', 'Hexapolar');
model.physics('gop').feature('relg1').setIndex('Nctheta', 'nhex', 0);
model.physics('gop').feature('relg1').set('cax', [0 0 1]);
model.physics('gop').feature('relg1').set('alphac', 'alpha');
model.physics('gop').feature.duplicate('relg2', 'relg1');
model.physics('gop').feature('relg2').setIndex('x0', 'D_0/4', 1);
model.physics('gop').feature.duplicate('relg3', 'relg2');
model.physics('gop').feature('relg3').setIndex('x0', 'D_0/2', 1);

model.mesh('mesh1').create('size1', 'Size');
model.mesh('mesh1').feature('size1').selection.geom('geom1', 2);
model.mesh('mesh1').feature('size1').selection.named('geom1_csel1_bnd');
model.mesh('mesh1').feature('size1').set('custom', true);
model.mesh('mesh1').feature('size1').set('hmaxactive', true);
model.mesh('mesh1').feature('size1').set('hmax', '5[mm]');
model.mesh('mesh1').create('size2', 'Size');
model.mesh('mesh1').feature('size2').selection.geom('geom1', 2);
model.mesh('mesh1').feature('size2').selection.named('geom1_csel2_bnd');
model.mesh('mesh1').feature('size2').set('hauto', 2);
model.mesh('mesh1').create('ftet1', 'FreeTet');
model.mesh('mesh1').run;

model.study('std1').feature('rtrac').set('timestepspec', 'specifylength');
model.study('std1').feature('rtrac').set('llist', '0 1.5');

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
model.result('pg1').setIndex('looplevel', 2, 0);
model.result('pg1').label('Ray Trajectories (gop)');
model.result('pg1').create('rtrj1', 'RayTrajectories');
model.result('pg1').feature('rtrj1').set('linetype', 'line');
model.result('pg1').feature('rtrj1').create('col1', 'Color');
model.result('pg1').feature('rtrj1').feature('col1').set('expr', 'gop.L');
model.result('pg1').feature('rtrj1').create('filt1', 'RayTrajectoriesFilter');
model.result('pg1').run;
model.result('pg1').set('legendpos', 'bottom');
model.result('pg1').set('showlegendsunit', true);
model.result('pg1').create('surf1', 'Surface');
model.result('pg1').feature('surf1').set('coloring', 'uniform');
model.result('pg1').feature('surf1').set('color', 'blue');
model.result('pg1').feature('surf1').create('tran1', 'Transparency');
model.result('pg1').run;
model.result('pg1').run;
model.result('pg1').feature('rtrj1').feature('col1').set('expr', 'at(''last'',gop.rrel)');
model.result('pg1').feature('rtrj1').feature('col1').set('unit', [native2unicode(hex2dec({'00' 'b5'}), 'unicode') 'm']);
model.result('pg1').feature('rtrj1').feature('col1').set('colortable', 'HeatCameraLight');
model.result('pg1').feature('rtrj1').feature('col1').set('colortabletrans', 'reverse');
model.result('pg1').run;
model.result.create('pg2', 'PlotGroup2D');
model.result('pg2').run;
model.result('pg2').label('Spot Diagram');
model.result('pg2').set('showlegendsmaxmin', true);
model.result('pg2').set('showlegendsunit', true);
model.result('pg2').create('spot1', 'SpotDiagram');
model.result('pg2').feature('spot1').set('spotcoordsactive', true);
model.result('pg2').feature('spot1').set('spotcoordssystem', 'global');
model.result('pg2').feature('spot1').set('spotcoordsprecision', 7);
model.result('pg2').run;
model.result('pg2').feature('spot1').create('col1', 'Color');
model.result('pg2').run;
model.result('pg2').feature('spot1').feature('col1').set('expr', 'gop.phii');
model.result('pg2').feature('spot1').feature('col1').set('descr', 'Acute angle of incidence');
model.result('pg2').feature('spot1').feature('col1').set('unit', [native2unicode(hex2dec({'00' 'b0'}), 'unicode') ]);
model.result('pg2').run;

model.title('Microlithography Lens');

model.description(['Microlithography lenses are used to project the image of an integrated circuit onto a silicon substrate. This tutorial demonstrates how to create a 21-element fused silica lens which has a NA of 0.56 which is designed to be used at a wavelength of 248' native2unicode(hex2dec({'00' 'a0'}), 'unicode') 'nm. The lens, which has a total length of 1' native2unicode(hex2dec({'00' 'a0'}), 'unicode') 'meter, has a magnification of -0.25 with excellent image quality over a 23.4' native2unicode(hex2dec({'00' 'a0'}), 'unicode') 'mm image circle.']);

model.mesh.clearMeshes;

model.sol('sol1').clearSolutionData;

model.label('microlithography_lens.mph');

model.modelNode.label('Components');

out = model;
