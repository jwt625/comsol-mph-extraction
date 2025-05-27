function out = model
%
% thin_film_resistance.m
%
% Model exported on May 26 2025, 21:26 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/COMSOL_Multiphysics/Electromagnetics');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 3);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.physics.create('ec', 'ConductiveMedia', 'geom1');
model.physics('ec').model('comp1');

model.study.create('std1');
model.study('std1').create('stat', 'Stationary');
model.study('std1').feature('stat').setSolveFor('/physics/ec', true);

model.geom('geom1').create('wp1', 'WorkPlane');
model.geom('geom1').feature('wp1').set('unite', true);
model.geom('geom1').feature('wp1').set('quickz', 0.1);
model.geom('geom1').feature('wp1').set('unite', false);
model.geom('geom1').feature('wp1').geom.create('c1', 'Circle');
model.geom('geom1').feature('wp1').geom.feature('c1').set('r', 0.6);
model.geom('geom1').feature('wp1').geom.feature('c1').set('pos', [0 1]);
model.geom('geom1').feature('wp1').geom.run('c1');
model.geom('geom1').feature('wp1').geom.create('sq1', 'Square');
model.geom('geom1').feature('wp1').geom.run('sq1');
model.geom('geom1').feature('wp1').geom.create('int1', 'Intersection');
model.geom('geom1').feature('wp1').geom.feature('int1').selection('input').set({'c1' 'sq1'});
model.geom('geom1').feature('wp1').geom.run('int1');
model.geom('geom1').feature('wp1').geom.create('sq2', 'Square');
model.geom('geom1').feature('wp1').geom.run('sq2');
model.geom('geom1').run('wp1');
model.geom('geom1').feature.create('ext1', 'Extrude');
model.geom('geom1').feature('ext1').set('workplane', 'wp1');
model.geom('geom1').feature('ext1').selection('input').set({'wp1.sq2'});
model.geom('geom1').feature('ext1').setIndex('distance', -0.1, 0);
model.geom('geom1').run('ext1');
model.geom('geom1').create('blk1', 'Block');
model.geom('geom1').feature('blk1').set('size', [1 1 0.1]);
model.geom('geom1').feature('blk1').set('pos', [0 0 -0.1]);
model.geom('geom1').run('blk1');
model.geom('geom1').create('copy1', 'Copy');
model.geom('geom1').feature('copy1').selection('input').set({'blk1' 'ext1' 'wp1.int1'});
model.geom('geom1').feature('copy1').set('displx', 1.5);
model.geom('geom1').feature('copy1').set('disply', -1);
model.geom('geom1').run('copy1');
model.geom('geom1').create('mov1', 'Move');
model.geom('geom1').feature('mov1').selection('input').set({'blk1'});
model.geom('geom1').feature('mov1').set('displz', -0.02);
model.geom('geom1').run('mov1');
model.geom('geom1').create('blk2', 'Block');
model.geom('geom1').feature('blk2').set('size', [1 1 0.02]);
model.geom('geom1').feature('blk2').set('pos', [0 0 -0.02]);
model.geom('geom1').runPre('fin');
model.geom('geom1').run;

model.physics('ec').feature('cucn1').set('sigma_mat', 'userdef');
model.physics('ec').feature('cucn1').set('sigma', [1 0 0 0 1 0 0 0 1]);
model.physics('ec').create('ncd1', 'NormalCurrentDensity', 2);
model.physics('ec').feature('ncd1').selection.set([3 20]);
model.physics('ec').feature('ncd1').set('nJ', 0.3);
model.physics('ec').create('gnd1', 'Ground', 2);
model.physics('ec').feature('gnd1').selection.set([11 25]);
model.physics('ec').create('ci1', 'ContactImpedance', 2);

model.view('view1').set('renderwireframe', true);

model.physics('ec').feature('ci1').selection.set([23]);

model.view('view1').set('renderwireframe', false);

model.physics('ec').feature('ci1').set('ds', 0.02);
model.physics('ec').feature('ci1').set('sigmabnd_mat', 'userdef');
model.physics('ec').feature('ci1').set('epsilonrbnd_mat', 'userdef');
model.physics('ec').create('cucn2', 'CurrentConservation', 3);
model.physics('ec').feature('cucn2').selection.set([2]);
model.physics('ec').feature('cucn2').set('sigma_mat', 'userdef');
model.physics('ec').feature('cucn2').set('sigma', [0.01 0 0 0 0.01 0 0 0 0.01]);

model.study('std1').setGenPlots(false);

model.sol.create('sol1');
model.sol('sol1').study('std1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'stat');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').set('control', 'stat');
model.sol('sol1').create('s1', 'Stationary');
model.sol('sol1').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('s1').create('i1', 'Iterative');
model.sol('sol1').feature('s1').feature('i1').set('linsolver', 'cg');
model.sol('sol1').feature('s1').feature('i1').create('mg1', 'Multigrid');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').set('prefun', 'amg');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').set('coarseningmethod', 'classic');
model.sol('sol1').feature('s1').feature('fc1').set('linsolver', 'i1');
model.sol('sol1').feature('s1').feature.remove('fcDef');
model.sol('sol1').attach('std1');
model.sol('sol1').runAll;

model.result.create('pg1', 'PlotGroup3D');
model.result('pg1').run;
model.result('pg1').create('vol1', 'Volume');
model.result('pg1').feature('vol1').set('colorlegend', false);
model.result('pg1').run;
model.result.dataset.create('cln1', 'CutLine3D');
model.result.dataset('cln1').setIndex('genpoints', 0.5, 0, 0);
model.result.dataset('cln1').setIndex('genpoints', 0.5, 0, 1);
model.result.dataset('cln1').setIndex('genpoints', -0.1, 0, 2);
model.result.dataset('cln1').setIndex('genpoints', 0.5, 1, 0);
model.result.dataset('cln1').setIndex('genpoints', 0.5, 1, 1);
model.result.dataset('cln1').setIndex('genpoints', 0.1, 1, 2);
model.result.dataset.duplicate('cln2', 'cln1');
model.result.dataset('cln2').setIndex('genpoints', 2, 0, 0);
model.result.dataset('cln2').setIndex('genpoints', -0.5, 0, 1);
model.result.dataset('cln2').setIndex('genpoints', 2, 1, 0);
model.result.dataset('cln2').setIndex('genpoints', -0.5, 1, 1);
model.result.create('pg2', 'PlotGroup1D');
model.result('pg2').run;
model.result('pg2').set('titletype', 'none');
model.result('pg2').set('axislimits', true);
model.result('pg2').set('xmin', -0.1);
model.result('pg2').set('xmax', 0.1);
model.result('pg2').set('ymin', 0.2);
model.result('pg2').create('lngr1', 'LineGraph');
model.result('pg2').feature('lngr1').set('markerpos', 'datapoints');
model.result('pg2').feature('lngr1').set('linewidth', 'preference');
model.result('pg2').feature('lngr1').set('data', 'cln1');
model.result('pg2').feature('lngr1').set('xdataexpr', 'z');
model.result('pg2').feature('lngr1').set('xdatadescr', 'z-coordinate');
model.result('pg2').feature('lngr1').set('legend', true);
model.result('pg2').feature('lngr1').set('legendmethod', 'manual');
model.result('pg2').feature('lngr1').setIndex('legends', 'Full 3D model', 0);
model.result('pg2').feature.duplicate('lngr2', 'lngr1');
model.result('pg2').run;
model.result('pg2').feature('lngr2').set('data', 'cln2');
model.result('pg2').feature('lngr2').setIndex('legends', 'Thin-film approximation', 0);
model.result('pg2').run;
model.result('pg1').run;

model.title('Thin-Film Resistance');

model.description(['This example illustrates the technique of approximating a thin layer with a surface in diffusion-type problems, which leads to considerable savings in memory usage. In this example the effect of a thin layer with relatively low conductivity on the potential distribution in a structure is studied. The results show that the thin-layer approximation can be valid even for a layer as thick as 10' native2unicode(hex2dec({'00' 'a0'}), 'unicode') 'percent of the total height of the structure.']);

model.label('thin_film_resistance.mph');

model.modelNode.label('Components');

out = model;
