function out = model
%
% eigenmodes_of_room.m
%
% Model exported on May 26 2025, 21:26 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/COMSOL_Multiphysics/Acoustics');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 3);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.physics.create('acpr', 'PressureAcoustics', 'geom1');
model.physics('acpr').model('comp1');

model.study.create('std1');
model.study('std1').create('eig', 'Eigenfrequency');
model.study('std1').feature('eig').set('chkeigregion', true);
model.study('std1').feature('eig').set('conrad', '1');
model.study('std1').feature('eig').set('conradynhm', '1');
model.study('std1').feature('eig').set('storefact', false);
model.study('std1').feature('eig').set('linpsolnum', 'auto');
model.study('std1').feature('eig').set('solnum', 'auto');
model.study('std1').feature('eig').set('notsolnum', 'auto');
model.study('std1').feature('eig').set('outputmap', {});
model.study('std1').feature('eig').set('ngenAUX', '1');
model.study('std1').feature('eig').set('goalngenAUX', '1');
model.study('std1').feature('eig').set('ngenAUX', '1');
model.study('std1').feature('eig').set('goalngenAUX', '1');
model.study('std1').feature('eig').setSolveFor('/physics/acpr', true);

model.geom('geom1').create('imp1', 'Import');
model.geom('geom1').feature('imp1').set('filename', 'eigenmodes_of_room.mphbin');
model.geom('geom1').feature('imp1').importData;

model.view('view1').set('renderwireframe', true);

model.geom('geom1').run;

model.material.create('mat1', 'Common', 'comp1');
model.material('mat1').label('Air');
model.material('mat1').propertyGroup('def').set('density', {'1.25'});
model.material('mat1').propertyGroup('def').set('soundspeed', {'343'});

model.mesh('mesh1').create('ftet1', 'FreeTet');

model.study('std1').feature('eig').set('shift', '90');

model.sol.create('sol1');
model.sol('sol1').study('std1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'eig');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').set('control', 'eig');
model.sol('sol1').create('e1', 'Eigenvalue');
model.sol('sol1').feature('e1').set('neigs', 6);
model.sol('sol1').feature('e1').set('shift', '0');
model.sol('sol1').feature('e1').set('rtol', 1.0E-6);
model.sol('sol1').feature('e1').set('transform', 'none');
model.sol('sol1').feature('e1').set('eigref', '100');
model.sol('sol1').feature('e1').set('eigvfunscale', 'average');
model.sol('sol1').feature('e1').set('control', 'eig');
model.sol('sol1').feature('e1').feature('aDef').set('complexfun', true);
model.sol('sol1').feature('e1').feature('aDef').set('cachepattern', true);
model.sol('sol1').feature('e1').feature('aDef').set('matherr', true);
model.sol('sol1').feature('e1').feature('aDef').set('blocksizeactive', false);
model.sol('sol1').feature('e1').feature('aDef').set('nullfun', 'auto');
model.sol('sol1').feature('e1').create('d1', 'Direct');
model.sol('sol1').feature('e1').feature('d1').set('linsolver', 'mumps');
model.sol('sol1').feature('e1').feature('d1').label('Suggested Direct Solver (acpr)');
model.sol('sol1').feature('e1').create('i1', 'Iterative');
model.sol('sol1').feature('e1').feature('i1').set('linsolver', 'gmres');
model.sol('sol1').feature('e1').feature('i1').label('Suggested Iterative Solver (GMRES with GMG) (acpr)');
model.sol('sol1').feature('e1').feature('i1').create('mg1', 'Multigrid');
model.sol('sol1').feature('e1').feature('i1').feature('mg1').set('prefun', 'gmg');
model.sol('sol1').feature('e1').create('i2', 'Iterative');
model.sol('sol1').feature('e1').feature('i2').set('linsolver', 'fgmres');
model.sol('sol1').feature('e1').feature('i2').label('Suggested Iterative Solver (FGMRES with GMG) (acpr)');
model.sol('sol1').feature('e1').feature('i2').create('mg1', 'Multigrid');
model.sol('sol1').feature('e1').feature('i2').feature('mg1').set('prefun', 'gmg');
model.sol('sol1').feature('e1').feature('d1').active(true);
model.sol('sol1').attach('std1');
model.sol('sol1').runAll;

model.result.create('pg1', 'PlotGroup3D');
model.result('pg1').set('data', 'dset1');
model.result('pg1').setIndex('looplevel', 1, 0);
model.result('pg1').create('surf1', 'Surface');
model.result('pg1').feature('surf1').set('expr', {'acpr.p_t'});
model.result('pg1').feature('surf1').set('colortable', 'Wave');
model.result('pg1').feature('surf1').set('colorscalemode', 'linearsymmetric');
model.result('pg1').set('showlegendsunit', true);
model.result('pg1').label('Acoustic Pressure (acpr)');
model.result('pg1').feature('surf1').set('colortable', 'WaveLight');
model.result('pg1').create('con1', 'Contour');
model.result('pg1').feature('con1').set('expr', {'acpr.p_t'});
model.result('pg1').feature('con1').set('colortable', 'Wave');
model.result('pg1').feature('con1').set('colorscalemode', 'linearsymmetric');
model.result('pg1').feature('con1').set('colorlegend', false);
model.result.create('pg2', 'PlotGroup3D');
model.result('pg2').set('data', 'dset1');
model.result('pg2').setIndex('looplevel', 1, 0);
model.result('pg2').create('surf1', 'Surface');
model.result('pg2').feature('surf1').set('expr', {'acpr.Lp_t'});
model.result('pg2').feature('surf1').set('colortable', 'Rainbow');
model.result('pg2').feature('surf1').set('colorscalemode', 'linear');
model.result('pg2').set('showlegendsunit', true);
model.result('pg2').label('Sound Pressure Level (acpr)');
model.result.create('pg3', 'PlotGroup3D');
model.result('pg3').set('data', 'dset1');
model.result('pg3').setIndex('looplevel', 1, 0);
model.result('pg3').create('iso1', 'Isosurface');
model.result('pg3').feature('iso1').set('expr', {'acpr.p_t'});
model.result('pg3').feature('iso1').set('number', '10');
model.result('pg3').feature('iso1').set('colortable', 'Wave');
model.result('pg3').feature('iso1').set('colorscalemode', 'linearsymmetric');
model.result('pg3').set('showlegendsunit', true);
model.result('pg3').label('Acoustic Pressure, Isosurfaces (acpr)');
model.result.evaluationGroup.create('std1EvgFrq', 'EvaluationGroup');
model.result.evaluationGroup('std1EvgFrq').set('defaultPlotID', 'eigenfrequenciesTable_acpr');
model.result.evaluationGroup('std1EvgFrq').set('data', 'dset1');
model.result.evaluationGroup('std1EvgFrq').label('Eigenfrequencies (Study 1)');
model.result.evaluationGroup('std1EvgFrq').create('gev1', 'EvalGlobal');
model.result.evaluationGroup('std1EvgFrq').feature('gev1').setIndex('expr', '2*pi*freq', 0);
model.result.evaluationGroup('std1EvgFrq').feature('gev1').setIndex('unit', 'rad/s', 0);
model.result.evaluationGroup('std1EvgFrq').feature('gev1').setIndex('descr', 'Angular frequency', 0);
model.result.evaluationGroup('std1EvgFrq').feature('gev1').setIndex('expr', 'imag(freq)/abs(freq)', 1);
model.result.evaluationGroup('std1EvgFrq').feature('gev1').setIndex('unit', '1', 1);
model.result.evaluationGroup('std1EvgFrq').feature('gev1').setIndex('descr', 'Damping ratio', 1);
model.result.evaluationGroup('std1EvgFrq').feature('gev1').setIndex('expr', 'abs(freq)/imag(freq)/2', 2);
model.result.evaluationGroup('std1EvgFrq').feature('gev1').setIndex('unit', '1', 2);
model.result.evaluationGroup('std1EvgFrq').feature('gev1').setIndex('descr', 'Quality factor', 2);
model.result.evaluationGroup('std1EvgFrq').run;
model.result('pg1').run;
model.result.dataset('dset1').selection.geom('geom1', 2);
model.result.dataset('dset1').selection.geom('geom1', 2);
model.result.dataset('dset1').selection.all;
model.result.dataset('dset1').selection.geom('geom1', 2);
model.result.dataset('dset1').selection.set([3 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40 41 42 43 44 45 46 47 48 49 50 51 52 53 54 55 56 57 58 59 60 61 62 63 64 65 66 67 68 69 70 71 72 73 74 75 76 77 78 79]);
model.result('pg1').run;
model.result('pg3').run;
model.result('pg3').run;
model.result('pg3').feature('iso1').set('number', 5);
model.result('pg3').run;
model.result('pg3').run;
model.result('pg3').create('surf1', 'Surface');
model.result('pg3').run;
model.result('pg3').run;
model.result('pg3').feature('iso1').set('colorlegend', false);
model.result('pg3').run;
model.result('pg3').set('looplevel', [8]);
model.result('pg3').run;
model.result('pg1').run;
model.result.create('pg4', 'PlotGroup3D');
model.result('pg4').set('data', 'dset1');
model.result('pg4').setIndex('looplevel', 1, 0);
model.result('pg4').create('surf1', 'Surface');
model.result('pg4').feature('surf1').set('expr', {'acpr.Lp_t'});
model.result('pg4').feature('surf1').set('colortable', 'Rainbow');
model.result('pg4').feature('surf1').set('colorscalemode', 'linear');
model.result('pg4').set('showlegendsunit', true);
model.result('pg4').label('Sound Pressure Level (acpr) 1');
model.result('pg4').run;
model.result('pg4').run;
model.result('pg4').feature('surf1').set('descractive', true);
model.result('pg4').feature('surf1').set('descr', 'Total SPL');
model.result('pg4').run;

model.title('Eigenmodes of a Room');

model.description('This example simulates standing acoustic waves in a room with furniture. The eigenmodes differ slightly from the exact solution for an empty room.');

model.mesh.clearMeshes;

model.sol('sol1').clearSolutionData;

model.label('eigenmodes_of_room.mph');

model.modelNode.label('Components');

out = model;
