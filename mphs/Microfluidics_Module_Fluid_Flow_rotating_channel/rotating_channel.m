function out = model
%
% rotating_channel.m
%
% Model exported on May 26 2025, 21:30 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/Microfluidics_Module/Fluid_Flow');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 3);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.physics.create('spf', 'LaminarFlow', 'geom1');
model.physics('spf').model('comp1');

model.study.create('std1');
model.study('std1').create('stat', 'Stationary');
model.study('std1').feature('stat').setSolveFor('/physics/spf', true);

model.param.set('omega', '100[rad/s]');
model.param.descr('omega', 'Angular velocity');

model.geom('geom1').lengthUnit('mm');
model.geom('geom1').create('blk1', 'Block');
model.geom('geom1').feature('blk1').set('size', [10 0.1 0.1]);
model.geom('geom1').feature('blk1').set('pos', [20 0 0]);
model.geom('geom1').run('blk1');
model.geom('geom1').create('arr1', 'Array');
model.geom('geom1').feature('arr1').selection('input').set({'blk1'});
model.geom('geom1').feature('arr1').set('fullsize', [1 2 2]);
model.geom('geom1').feature('arr1').set('displ', [0 0.1 0.1]);
model.geom('geom1').runPre('fin');
model.geom('geom1').run;

model.material.create('mat1', 'Common', 'comp1');
model.material('mat1').propertyGroup('def').set('density', {'977'});
model.material('mat1').propertyGroup('def').set('dynamicviscosity', {'8.55e-4'});

model.view.create('view2', 'geom1');
model.view('view2').model('comp1');
model.view('view2').set('renderwireframe', true);
model.view('view2').camera.set('viewscaletype', 'automatic');
model.view('view2').camera.set('autocontext', 'anisotropic');
model.view('view2').camera.set('xweight', 6);

model.cpl.create('intop1', 'Integration', 'geom1');
model.cpl('intop1').set('axisym', true);
model.cpl('intop1').selection.geom('geom1', 2);
model.cpl('intop1').selection.set([17 18 19 20]);

model.variable.create('var1');
model.variable('var1').model('comp1');
model.variable('var1').set('Q', 'intop1(u)');
model.variable('var1').descr('Q', 'Total flow rate');

model.physics('spf').create('vf1', 'VolumeForce', 3);
model.physics('spf').feature('vf1').label('Centrifugal force');
model.physics('spf').feature('vf1').selection.all;
model.physics('spf').feature('vf1').set('F', {'spf.rho*x*omega^2' '0' '0'});
model.physics('spf').create('vf2', 'VolumeForce', 3);
model.physics('spf').feature('vf2').label('Coriolis force');
model.physics('spf').feature('vf2').selection.all;
model.physics('spf').feature('vf2').set('F', {'-2*spf.rho*omega*v' '2*spf.rho*omega*u' '0'});
model.physics('spf').create('open1', 'OpenBoundary', 2);
model.physics('spf').feature('open1').selection.set([1 4 8 11 17 18 19 20]);

model.mesh('mesh1').create('map1', 'Map');
model.mesh('mesh1').feature('map1').selection.set([1 4 8 11]);
model.mesh('mesh1').feature('map1').create('dis1', 'Distribution');
model.mesh('mesh1').feature('map1').feature('dis1').selection.set([1 2 4 5 7 9 10 12 13 15 17 19]);
model.mesh('mesh1').create('swe1', 'Sweep');
model.mesh('mesh1').feature('swe1').create('dis1', 'Distribution');
model.mesh('mesh1').feature('swe1').feature('dis1').set('numelem', 150);
model.mesh('mesh1').run;

model.sol.create('sol1');

model.mesh('mesh1').stat.selection.geom(3);
model.mesh('mesh1').stat.selection.set([1 2 3 4]);

model.sol('sol1').study('std1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'stat');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').set('control', 'stat');
model.sol('sol1').create('s1', 'Stationary');
model.sol('sol1').feature('s1').feature('aDef').set('cachepattern', true);
model.sol('sol1').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('s1').feature('fc1').set('dtech', 'auto');
model.sol('sol1').feature('s1').feature('fc1').set('initstep', 0.01);
model.sol('sol1').feature('s1').feature('fc1').set('minstep', 1.0E-4);
model.sol('sol1').feature('s1').feature('fc1').set('maxiter', 100);
model.sol('sol1').feature('s1').create('d1', 'Direct');
model.sol('sol1').feature('s1').feature('d1').set('linsolver', 'pardiso');
model.sol('sol1').feature('s1').feature('d1').set('pivotperturb', 1.0E-13);
model.sol('sol1').feature('s1').feature('d1').label('Direct, fluid flow variables (spf)');
model.sol('sol1').feature('s1').create('i1', 'Iterative');
model.sol('sol1').feature('s1').feature('i1').set('linsolver', 'gmres');
model.sol('sol1').feature('s1').feature('i1').set('prefuntype', 'left');
model.sol('sol1').feature('s1').feature('i1').set('itrestart', 50);
model.sol('sol1').feature('s1').feature('i1').set('rhob', 20);
model.sol('sol1').feature('s1').feature('i1').set('maxlinit', 1000);
model.sol('sol1').feature('s1').feature('i1').set('nlinnormuse', 'on');
model.sol('sol1').feature('s1').feature('i1').label('AMG, fluid flow variables (spf)');
model.sol('sol1').feature('s1').feature('i1').create('mg1', 'Multigrid');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').set('prefun', 'saamg');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').set('mgcycle', 'v');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').set('maxcoarsedof', 80000);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').set('strconn', 0.02);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').set('nullspace', 'constant');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').set('usesmooth', false);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').set('saamgcompwise', true);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').set('loweramg', true);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').set('compactaggregation', false);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('pr').create('sc1', 'SCGS');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('pr').feature('sc1').set('linesweeptype', 'ssor');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('pr').feature('sc1').set('iter', 0);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('pr').feature('sc1').set('scgsrelax', 0.7);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('pr').feature('sc1').set('scgsmethod', 'lines');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('pr').feature('sc1').set('scgsvertexrelax', 0.7);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('pr').feature('sc1').set('relax', 0.5);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('pr').feature('sc1').set('scgssolv', 'stored');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('pr').feature('sc1').set('approxscgs', true);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('pr').feature('sc1').set('scgsdirectmaxsize', 1000);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('po').create('sc1', 'SCGS');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('po').feature('sc1').set('linesweeptype', 'ssor');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('po').feature('sc1').set('iter', 1);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('po').feature('sc1').set('scgsrelax', 0.7);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('po').feature('sc1').set('scgsmethod', 'lines');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('po').feature('sc1').set('scgsvertexrelax', 0.7);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('po').feature('sc1').set('relax', 0.5);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('po').feature('sc1').set('scgssolv', 'stored');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('po').feature('sc1').set('approxscgs', true);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('po').feature('sc1').set('scgsdirectmaxsize', 1000);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('cs').create('d1', 'Direct');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('cs').feature('d1').set('linsolver', 'pardiso');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('cs').feature('d1').set('pivotperturb', 1.0E-13);
model.sol('sol1').feature('s1').feature('fc1').set('linsolver', 'd1');
model.sol('sol1').feature('s1').feature('fc1').set('dtech', 'auto');
model.sol('sol1').feature('s1').feature('fc1').set('initstep', 0.01);
model.sol('sol1').feature('s1').feature('fc1').set('minstep', 1.0E-4);
model.sol('sol1').feature('s1').feature('fc1').set('maxiter', 100);
model.sol('sol1').feature('s1').feature.remove('fcDef');
model.sol('sol1').attach('std1');
model.sol('sol1').runAll;

model.result.dataset('dset1').set('geom', 'geom1');
model.result.create('pg1', 'PlotGroup3D');
model.result('pg1').label('Velocity (spf)');
model.result('pg1').set('frametype', 'spatial');
model.result('pg1').set('data', 'dset1');
model.result('pg1').set('defaultPlotID', 'ResultDefaults_SinglePhaseFlow/icom1/pdef1/pcond2/pg1');
model.result('pg1').feature.create('slc1', 'Slice');
model.result('pg1').feature('slc1').label('Slice');
model.result('pg1').feature('slc1').set('showsolutionparams', 'on');
model.result('pg1').feature('slc1').set('smooth', 'internal');
model.result('pg1').feature('slc1').set('showsolutionparams', 'on');
model.result('pg1').feature('slc1').set('data', 'parent');
model.result.dataset.create('surf1', 'Surface');
model.result.dataset('surf1').label('Exterior Walls');
model.result.dataset('surf1').set('data', 'dset1');
model.result.dataset('surf1').selection.geom('geom1', 2);
model.result.dataset('surf1').selection.set([2 3 5 7 10 14 15 16]);
model.result.create('pg2', 'PlotGroup3D');
model.result('pg2').label('Pressure (spf)');
model.result('pg2').set('data', 'surf1');
model.result('pg2').set('frametype', 'spatial');
model.result('pg2').set('data', 'surf1');
model.result('pg2').set('defaultPlotID', 'ResultDefaults_SinglePhaseFlow/icom1/pdef1/pcond2/pcond2/pcond1/pg4');
model.result('pg2').feature.create('surf1', 'Surface');
model.result('pg2').feature('surf1').label('Surface');
model.result('pg2').feature('surf1').set('showsolutionparams', 'on');
model.result('pg2').feature('surf1').set('expr', 'p');
model.result('pg2').feature('surf1').set('colortable', 'Dipole');
model.result('pg2').feature('surf1').set('smooth', 'internal');
model.result('pg2').feature('surf1').set('showsolutionparams', 'on');
model.result('pg2').feature('surf1').set('data', 'parent');
model.result('pg2').feature('surf1').feature.create('tran1', 'Transparency');
model.result('pg1').run;
model.result.dataset.create('edg1', 'Edge3D');
model.result.dataset('edg1').selection.set([14]);
model.result.create('pg3', 'PlotGroup1D');
model.result('pg3').run;
model.result('pg3').label('Pressure drop');
model.result('pg3').set('data', 'edg1');
model.result('pg3').create('lngr1', 'LineGraph');
model.result('pg3').feature('lngr1').set('markerpos', 'datapoints');
model.result('pg3').feature('lngr1').set('linewidth', 'preference');
model.result('pg3').feature('lngr1').set('expr', 'p');
model.result('pg3').feature('lngr1').set('descr', 'Pressure');
model.result('pg3').feature('lngr1').set('xdataexpr', 'x');
model.result('pg3').feature('lngr1').set('xdatadescr', 'x-coordinate');
model.result('pg3').run;
model.result.numerical.create('gev1', 'EvalGlobal');
model.result.numerical('gev1').set('expr', {'Q'});
model.result.numerical('gev1').set('descr', {'Total flow rate'});
model.result.numerical('gev1').set('unit', {'m^3/s'});
model.result.numerical('gev1').setIndex('unit', 'dm^3/s', 0);
model.result.table.create('tbl1', 'Table');
model.result.table('tbl1').comments('Global Evaluation 1');
model.result.numerical('gev1').set('table', 'tbl1');
model.result.numerical('gev1').setResult;
model.result('pg2').run;

model.title('Rotating Channel');

model.description('This example computes the radial pressure distribution and flow rate through a rotating Lab-On-A-Chip (LOAC) platform. The flow through the device is a result of centrifugal and Coriolis forces. The results compare well with the referenced publication.');

model.mesh.clearMeshes;

model.sol('sol1').clearSolutionData;

model.label('rotating_channel.mph');

model.modelNode.label('Components');

out = model;
