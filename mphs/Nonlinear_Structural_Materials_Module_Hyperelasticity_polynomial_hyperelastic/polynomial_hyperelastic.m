function out = model
%
% polynomial_hyperelastic.m
%
% Model exported on May 26 2025, 21:31 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/Nonlinear_Structural_Materials_Module/Hyperelasticity');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 3);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.physics.create('solid', 'SolidMechanics', 'geom1');
model.physics('solid').model('comp1');

model.study.create('std1');
model.study('std1').create('stat', 'Stationary');
model.study('std1').feature('stat').setSolveFor('/physics/solid', true);

model.param.set('kappa', '3[MPa]');
model.param.descr('kappa', 'Bulk modulus');
model.param.set('C01', '0.5[MPa]');
model.param.descr('C01', 'Polynomial coefficient C01');
model.param.set('C10', '0.1[MPa]');
model.param.descr('C10', 'Polynomial coefficient C10');
model.param.set('C11', '0.15[MPa]');
model.param.descr('C11', 'Polynomial coefficient C11');
model.param.set('C20', '0.2[MPa]');
model.param.descr('C20', 'Polynomial coefficient C20');
model.param.set('C02', '-0.2[MPa]');
model.param.descr('C02', 'Polynomial coefficient C02');

model.geom('geom1').create('blk1', 'Block');
model.geom('geom1').feature('blk1').set('size', [0.1 0.05 0.02]);
model.geom('geom1').feature('blk1').set('rot', -90);
model.geom('geom1').runPre('fin');

model.variable.create('var1');
model.variable('var1').model('comp1');

model.geom('geom1').run;

model.variable('var1').set('Wsiso_MR2', 'C10*(solid.I1CIel-3)+C01*(solid.I2CIel-3)');
model.variable('var1').descr('Wsiso_MR2', ['Isochoric strain energy density, Mooney' native2unicode(hex2dec({'20' '13'}), 'unicode') 'Rivlin two parameters']);
model.variable('var1').set('Wsiso_MR5', 'Wsiso_MR2+C20*(solid.I1CIel-3)^2+C02*(solid.I2CIel-3)^2+C11*(solid.I1CIel-3)*(solid.I2CIel-3)');
model.variable('var1').descr('Wsiso_MR5', ['Isochoric strain energy density, Mooney' native2unicode(hex2dec({'20' '13'}), 'unicode') 'Rivlin five parameters']);
model.variable('var1').set('Wsvol', '0.5*kappa*(solid.Jel-1)^2');
model.variable('var1').descr('Wsvol', 'Volumetric strain energy density');

model.physics('solid').create('fix1', 'Fixed', 2);
model.physics('solid').feature('fix1').selection.set([5]);
model.physics('solid').create('sym1', 'SymmetrySolid', 2);
model.physics('solid').feature('sym1').selection.set([1 3]);
model.physics('solid').create('bndl1', 'BoundaryLoad', 2);
model.physics('solid').feature('bndl1').selection.set([2]);
model.physics('solid').feature('bndl1').set('FperArea', {'0' '-1[MPa]' '0'});
model.physics('solid').create('hmm1', 'HyperelasticModel', 3);
model.physics('solid').feature('hmm1').label('Polynomial, Two Parameters');
model.physics('solid').feature('hmm1').selection.all;
model.physics('solid').feature('hmm1').set('MaterialModel', 'userDefined');
model.physics('solid').feature('hmm1').set('Compressibility_UserDef', 'NearlyIncompressible');
model.physics('solid').feature('hmm1').set('Wsiso', 'Wsiso_MR2');
model.physics('solid').feature('hmm1').set('Uvol', 'Wsvol');

model.mesh('mesh1').create('map1', 'Map');
model.mesh('mesh1').feature('map1').selection.set([5]);
model.mesh('mesh1').feature('map1').create('dis1', 'Distribution');
model.mesh('mesh1').feature('map1').feature('dis1').selection.set([6 12]);
model.mesh('mesh1').feature('map1').feature('dis1').set('type', 'predefined');
model.mesh('mesh1').feature('map1').feature('dis1').set('elemcount', 4);
model.mesh('mesh1').feature('map1').feature('dis1').set('elemratio', 5);
model.mesh('mesh1').feature('map1').feature('dis1').set('reverse', true);
model.mesh('mesh1').feature('map1').create('dis2', 'Distribution');
model.mesh('mesh1').feature('map1').feature('dis2').selection.set([7 8]);
model.mesh('mesh1').feature('map1').feature('dis2').set('type', 'predefined');
model.mesh('mesh1').feature('map1').feature('dis2').set('elemcount', 6);
model.mesh('mesh1').feature('map1').feature('dis2').set('elemratio', 5);
model.mesh('mesh1').create('swe1', 'Sweep');
model.mesh('mesh1').feature('swe1').create('dis1', 'Distribution');
model.mesh('mesh1').feature('swe1').feature('dis1').set('type', 'predefined');
model.mesh('mesh1').feature('swe1').feature('dis1').set('elemcount', 15);
model.mesh('mesh1').feature('swe1').feature('dis1').set('elemratio', 5);
model.mesh('mesh1').run;

model.physics('solid').create('hmm2', 'HyperelasticModel', 3);
model.physics('solid').feature('hmm2').label(['Mooney' native2unicode(hex2dec({'20' '13'}), 'unicode') 'Rivlin']);
model.physics('solid').feature('hmm2').selection.all;
model.physics('solid').feature('hmm2').set('MaterialModel', 'MooneyRivlin');
model.physics('solid').feature('hmm2').set('C10_mat', 'userdef');
model.physics('solid').feature('hmm2').set('C10', 'C10');
model.physics('solid').feature('hmm2').set('C01_mat', 'userdef');
model.physics('solid').feature('hmm2').set('C01', 'C01');
model.physics('solid').feature('hmm2').set('kappa', 'kappa');
model.physics('solid').feature.duplicate('hmm3', 'hmm1');
model.physics('solid').feature('hmm3').label('Polynomial, Five Parameters');
model.physics('solid').feature('hmm3').set('Wsiso', 'Wsiso_MR5');

model.study('std1').label('Study: Polynomial, Two Parameters');
model.study('std1').feature('stat').set('useadvanceddisable', true);
model.study('std1').feature('stat').set('disabledphysics', {'solid/hmm2' 'solid/hmm3'});

model.sol.create('sol1');
model.sol('sol1').study('std1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'stat');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').set('control', 'stat');
model.sol('sol1').create('s1', 'Stationary');
model.sol('sol1').feature('s1').feature('aDef').set('cachepattern', true);
model.sol('sol1').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('s1').feature('fc1').set('termonres', 'auto');
model.sol('sol1').feature('s1').feature('fc1').set('reserrfact', 1000);
model.sol('sol1').feature('s1').create('d1', 'Direct');
model.sol('sol1').feature('s1').feature('d1').set('linsolver', 'pardiso');
model.sol('sol1').feature('s1').feature('d1').set('pivotperturb', 1.0E-9);
model.sol('sol1').feature('s1').feature('d1').set('nliniterrefine', true);
model.sol('sol1').feature('s1').feature('d1').label('Suggested Direct Solver (solid)');
model.sol('sol1').feature('s1').create('i1', 'Iterative');
model.sol('sol1').feature('s1').feature('i1').set('linsolver', 'gmres');
model.sol('sol1').feature('s1').feature('i1').set('prefuntype', 'right');
model.sol('sol1').feature('s1').feature('i1').set('rhob', 40);
model.sol('sol1').feature('s1').feature('i1').set('nlinnormuse', true);
model.sol('sol1').feature('s1').feature('i1').label('Suggested Iterative Solver (solid)');
model.sol('sol1').feature('s1').feature('i1').create('mg1', 'Multigrid');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').set('prefun', 'gmg');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('pr').create('so1', 'SOR');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('pr').feature('so1').set('iter', 1);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('po').create('so1', 'SOR');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('po').feature('so1').set('iter', 1);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('cs').create('mg1', 'Multigrid');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('cs').feature('mg1').set('prefun', 'saamg');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('cs').feature('mg1').set('usesmooth', false);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('cs').feature('mg1').set('iter', 2);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('cs').feature('mg1').set('mglevels', 2);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('cs').feature('mg1').set('maxcoarsedof', 10000);
model.sol('sol1').feature('s1').feature('fc1').set('linsolver', 'd1');
model.sol('sol1').feature('s1').feature('fc1').set('termonres', 'auto');
model.sol('sol1').feature('s1').feature('fc1').set('reserrfact', 1000);
model.sol('sol1').feature('s1').feature.remove('fcDef');
model.sol('sol1').attach('std1');
model.sol('sol1').runAll;

model.result.create('pg1', 'PlotGroup3D');
model.result('pg1').set('data', 'dset1');
model.result('pg1').set('defaultPlotID', 'stress');
model.result('pg1').label('Stress (solid)');
model.result('pg1').set('frametype', 'spatial');
model.result('pg1').create('vol1', 'Volume');
model.result('pg1').feature('vol1').set('expr', {'solid.misesGp'});
model.result('pg1').feature('vol1').set('threshold', 'manual');
model.result('pg1').feature('vol1').set('thresholdvalue', 0.2);
model.result('pg1').feature('vol1').set('colortable', 'Rainbow');
model.result('pg1').feature('vol1').set('colortabletrans', 'none');
model.result('pg1').feature('vol1').set('colorscalemode', 'linear');
model.result('pg1').feature('vol1').set('resolution', 'custom');
model.result('pg1').feature('vol1').set('refine', 2);
model.result('pg1').feature('vol1').set('colortable', 'Prism');
model.result('pg1').feature('vol1').create('def', 'Deform');
model.result('pg1').feature('vol1').feature('def').set('scaleactive', true);
model.result('pg1').feature('vol1').feature('def').set('scale', '1');
model.result('pg1').feature('vol1').feature('def').set('expr', {'u' 'v' 'w'});
model.result('pg1').feature('vol1').feature('def').set('descr', 'Displacement field');
model.result('pg1').run;
model.result('pg1').label('Stress (Polynomial, Two Parameters)');
model.result('pg1').run;
model.result('pg1').feature('vol1').set('unit', 'MPa');
model.result('pg1').run;
model.result.numerical.create('max1', 'MaxVolume');
model.result.numerical('max1').selection.all;
model.result.numerical('max1').set('expr', {'v'});
model.result.numerical('max1').set('descr', {'Displacement field, Y-component'});
model.result.numerical('max1').set('unit', {'m'});
model.result.numerical('max1').set('obj', 'abs');
model.result.table.create('tbl1', 'Table');
model.result.table('tbl1').comments('Volume Maximum 1');
model.result.numerical('max1').set('table', 'tbl1');
model.result.numerical('max1').setResult;

model.study.create('std2');
model.study('std2').create('stat', 'Stationary');
model.study('std2').feature('stat').setSolveFor('/physics/solid', true);
model.study('std2').feature('stat').set('useadvanceddisable', true);
model.study('std2').feature('stat').set('disabledphysics', {'solid/hmm3'});
model.study('std2').label(['Study: Mooney' native2unicode(hex2dec({'20' '13'}), 'unicode') 'Rivlin']);

model.sol.create('sol2');
model.sol('sol2').study('std2');
model.sol('sol2').create('st1', 'StudyStep');
model.sol('sol2').feature('st1').set('study', 'std2');
model.sol('sol2').feature('st1').set('studystep', 'stat');
model.sol('sol2').create('v1', 'Variables');
model.sol('sol2').feature('v1').set('control', 'stat');
model.sol('sol2').create('s1', 'Stationary');
model.sol('sol2').feature('s1').feature('aDef').set('cachepattern', true);
model.sol('sol2').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol2').feature('s1').feature('fc1').set('termonres', 'auto');
model.sol('sol2').feature('s1').feature('fc1').set('reserrfact', 1000);
model.sol('sol2').feature('s1').create('d1', 'Direct');
model.sol('sol2').feature('s1').feature('d1').set('linsolver', 'pardiso');
model.sol('sol2').feature('s1').feature('d1').set('pivotperturb', 1.0E-9);
model.sol('sol2').feature('s1').feature('d1').set('nliniterrefine', true);
model.sol('sol2').feature('s1').feature('d1').label('Suggested Direct Solver (solid)');
model.sol('sol2').feature('s1').create('i1', 'Iterative');
model.sol('sol2').feature('s1').feature('i1').set('linsolver', 'gmres');
model.sol('sol2').feature('s1').feature('i1').set('prefuntype', 'right');
model.sol('sol2').feature('s1').feature('i1').set('rhob', 40);
model.sol('sol2').feature('s1').feature('i1').set('nlinnormuse', true);
model.sol('sol2').feature('s1').feature('i1').label('Suggested Iterative Solver (solid)');
model.sol('sol2').feature('s1').feature('i1').create('mg1', 'Multigrid');
model.sol('sol2').feature('s1').feature('i1').feature('mg1').set('prefun', 'gmg');
model.sol('sol2').feature('s1').feature('i1').feature('mg1').feature('pr').create('so1', 'SOR');
model.sol('sol2').feature('s1').feature('i1').feature('mg1').feature('pr').feature('so1').set('iter', 1);
model.sol('sol2').feature('s1').feature('i1').feature('mg1').feature('po').create('so1', 'SOR');
model.sol('sol2').feature('s1').feature('i1').feature('mg1').feature('po').feature('so1').set('iter', 1);
model.sol('sol2').feature('s1').feature('i1').feature('mg1').feature('cs').create('mg1', 'Multigrid');
model.sol('sol2').feature('s1').feature('i1').feature('mg1').feature('cs').feature('mg1').set('prefun', 'saamg');
model.sol('sol2').feature('s1').feature('i1').feature('mg1').feature('cs').feature('mg1').set('usesmooth', false);
model.sol('sol2').feature('s1').feature('i1').feature('mg1').feature('cs').feature('mg1').set('iter', 2);
model.sol('sol2').feature('s1').feature('i1').feature('mg1').feature('cs').feature('mg1').set('mglevels', 2);
model.sol('sol2').feature('s1').feature('i1').feature('mg1').feature('cs').feature('mg1').set('maxcoarsedof', 10000);
model.sol('sol2').feature('s1').feature('fc1').set('linsolver', 'd1');
model.sol('sol2').feature('s1').feature('fc1').set('termonres', 'auto');
model.sol('sol2').feature('s1').feature('fc1').set('reserrfact', 1000);
model.sol('sol2').feature('s1').feature.remove('fcDef');
model.sol('sol2').attach('std2');
model.sol('sol2').runAll;

model.result.create('pg2', 'PlotGroup3D');
model.result('pg2').set('data', 'dset2');
model.result('pg2').set('defaultPlotID', 'stress');
model.result('pg2').label('Stress (solid)');
model.result('pg2').set('frametype', 'spatial');
model.result('pg2').create('vol1', 'Volume');
model.result('pg2').feature('vol1').set('expr', {'solid.misesGp'});
model.result('pg2').feature('vol1').set('threshold', 'manual');
model.result('pg2').feature('vol1').set('thresholdvalue', 0.2);
model.result('pg2').feature('vol1').set('colortable', 'Rainbow');
model.result('pg2').feature('vol1').set('colortabletrans', 'none');
model.result('pg2').feature('vol1').set('colorscalemode', 'linear');
model.result('pg2').feature('vol1').set('resolution', 'custom');
model.result('pg2').feature('vol1').set('refine', 2);
model.result('pg2').feature('vol1').set('colortable', 'Prism');
model.result('pg2').feature('vol1').create('def', 'Deform');
model.result('pg2').feature('vol1').feature('def').set('scaleactive', true);
model.result('pg2').feature('vol1').feature('def').set('scale', '1');
model.result('pg2').feature('vol1').feature('def').set('expr', {'u' 'v' 'w'});
model.result('pg2').feature('vol1').feature('def').set('descr', 'Displacement field');
model.result('pg2').run;
model.result('pg2').label(['Stress (Mooney' native2unicode(hex2dec({'20' '13'}), 'unicode') 'Rivlin)']);
model.result('pg2').run;
model.result('pg2').feature('vol1').set('unit', 'MPa');
model.result('pg2').run;
model.result.numerical('max1').set('data', 'dset2');
model.result.numerical('max1').set('table', 'tbl1');
model.result.numerical('max1').appendResult;

model.study.create('std3');
model.study('std3').create('stat', 'Stationary');
model.study('std3').feature('stat').setSolveFor('/physics/solid', true);
model.study('std3').label('Study: Polynomial, Five Parameters');

model.sol.create('sol3');
model.sol('sol3').study('std3');
model.sol('sol3').create('st1', 'StudyStep');
model.sol('sol3').feature('st1').set('study', 'std3');
model.sol('sol3').feature('st1').set('studystep', 'stat');
model.sol('sol3').create('v1', 'Variables');
model.sol('sol3').feature('v1').set('control', 'stat');
model.sol('sol3').create('s1', 'Stationary');
model.sol('sol3').feature('s1').feature('aDef').set('cachepattern', true);
model.sol('sol3').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol3').feature('s1').feature('fc1').set('termonres', 'auto');
model.sol('sol3').feature('s1').feature('fc1').set('reserrfact', 1000);
model.sol('sol3').feature('s1').create('d1', 'Direct');
model.sol('sol3').feature('s1').feature('d1').set('linsolver', 'pardiso');
model.sol('sol3').feature('s1').feature('d1').set('pivotperturb', 1.0E-9);
model.sol('sol3').feature('s1').feature('d1').set('nliniterrefine', true);
model.sol('sol3').feature('s1').feature('d1').label('Suggested Direct Solver (solid)');
model.sol('sol3').feature('s1').create('i1', 'Iterative');
model.sol('sol3').feature('s1').feature('i1').set('linsolver', 'gmres');
model.sol('sol3').feature('s1').feature('i1').set('prefuntype', 'right');
model.sol('sol3').feature('s1').feature('i1').set('rhob', 40);
model.sol('sol3').feature('s1').feature('i1').set('nlinnormuse', true);
model.sol('sol3').feature('s1').feature('i1').label('Suggested Iterative Solver (solid)');
model.sol('sol3').feature('s1').feature('i1').create('mg1', 'Multigrid');
model.sol('sol3').feature('s1').feature('i1').feature('mg1').set('prefun', 'gmg');
model.sol('sol3').feature('s1').feature('i1').feature('mg1').feature('pr').create('so1', 'SOR');
model.sol('sol3').feature('s1').feature('i1').feature('mg1').feature('pr').feature('so1').set('iter', 1);
model.sol('sol3').feature('s1').feature('i1').feature('mg1').feature('po').create('so1', 'SOR');
model.sol('sol3').feature('s1').feature('i1').feature('mg1').feature('po').feature('so1').set('iter', 1);
model.sol('sol3').feature('s1').feature('i1').feature('mg1').feature('cs').create('mg1', 'Multigrid');
model.sol('sol3').feature('s1').feature('i1').feature('mg1').feature('cs').feature('mg1').set('prefun', 'saamg');
model.sol('sol3').feature('s1').feature('i1').feature('mg1').feature('cs').feature('mg1').set('usesmooth', false);
model.sol('sol3').feature('s1').feature('i1').feature('mg1').feature('cs').feature('mg1').set('iter', 2);
model.sol('sol3').feature('s1').feature('i1').feature('mg1').feature('cs').feature('mg1').set('mglevels', 2);
model.sol('sol3').feature('s1').feature('i1').feature('mg1').feature('cs').feature('mg1').set('maxcoarsedof', 10000);
model.sol('sol3').feature('s1').feature('fc1').set('linsolver', 'd1');
model.sol('sol3').feature('s1').feature('fc1').set('termonres', 'auto');
model.sol('sol3').feature('s1').feature('fc1').set('reserrfact', 1000);
model.sol('sol3').feature('s1').feature.remove('fcDef');
model.sol('sol3').attach('std3');
model.sol('sol3').runAll;

model.result.create('pg3', 'PlotGroup3D');
model.result('pg3').set('data', 'dset3');
model.result('pg3').set('defaultPlotID', 'stress');
model.result('pg3').label('Stress (solid)');
model.result('pg3').set('frametype', 'spatial');
model.result('pg3').create('vol1', 'Volume');
model.result('pg3').feature('vol1').set('expr', {'solid.misesGp'});
model.result('pg3').feature('vol1').set('threshold', 'manual');
model.result('pg3').feature('vol1').set('thresholdvalue', 0.2);
model.result('pg3').feature('vol1').set('colortable', 'Rainbow');
model.result('pg3').feature('vol1').set('colortabletrans', 'none');
model.result('pg3').feature('vol1').set('colorscalemode', 'linear');
model.result('pg3').feature('vol1').set('resolution', 'custom');
model.result('pg3').feature('vol1').set('refine', 2);
model.result('pg3').feature('vol1').set('colortable', 'Prism');
model.result('pg3').feature('vol1').create('def', 'Deform');
model.result('pg3').feature('vol1').feature('def').set('scaleactive', true);
model.result('pg3').feature('vol1').feature('def').set('scale', '1');
model.result('pg3').feature('vol1').feature('def').set('expr', {'u' 'v' 'w'});
model.result('pg3').feature('vol1').feature('def').set('descr', 'Displacement field');
model.result('pg3').run;
model.result('pg3').label('Stress (Polynomial, Five Parameters)');
model.result('pg3').run;
model.result('pg3').feature('vol1').set('unit', 'MPa');
model.result('pg3').run;
model.result.numerical('max1').set('data', 'dset3');
model.result.numerical('max1').set('table', 'tbl1');
model.result.numerical('max1').appendResult;
model.result.create('pg4', 'PlotGroup1D');
model.result('pg4').run;
model.result('pg4').label(['Second Piola' native2unicode(hex2dec({'20' '13'}), 'unicode') 'Kirchhoff Stress']);
model.result('pg4').create('lngr1', 'LineGraph');
model.result('pg4').feature('lngr1').set('markerpos', 'datapoints');
model.result('pg4').feature('lngr1').set('linewidth', 'preference');
model.result('pg4').feature('lngr1').selection.set([2]);
model.result('pg4').feature('lngr1').set('expr', 'solid.SGpYY');
model.result('pg4').feature('lngr1').set('descr', ['Second Piola' native2unicode(hex2dec({'20' '13'}), 'unicode') 'Kirchhoff stress, YY-component']);
model.result('pg4').feature('lngr1').set('unit', 'MPa');
model.result('pg4').feature('lngr1').set('linemarker', 'cycle');
model.result('pg4').feature('lngr1').set('markerpos', 'interp');
model.result('pg4').feature('lngr1').set('legend', true);
model.result('pg4').feature('lngr1').set('legendmethod', 'manual');
model.result('pg4').feature('lngr1').setIndex('legends', 'Polynomial, two parameters', 0);
model.result('pg4').feature.duplicate('lngr2', 'lngr1');
model.result('pg4').run;
model.result('pg4').feature('lngr2').set('data', 'dset2');
model.result('pg4').feature('lngr2').set('markers', 10);
model.result('pg4').feature('lngr2').setIndex('legends', ['Mooney' native2unicode(hex2dec({'20' '13'}), 'unicode') 'Rivlin'], 0);
model.result('pg4').feature('lngr2').set('titletype', 'none');
model.result('pg4').run;
model.result('pg3').run;

model.title('Polynomial Hyperelastic Model');

model.description(['This example illustrates how to implement a two-terms and a five-terms Mooney' native2unicode(hex2dec({'20' '13'}), 'unicode') 'Rivlin constitutive material model using a user-defined strain energy density.']);

model.label('polynomial_hyperelastic.mph');

model.modelNode.label('Components');

out = model;
