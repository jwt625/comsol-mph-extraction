function out = model
%
% tapered_cantilever.m
%
% Model exported on May 26 2025, 21:27 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/COMSOL_Multiphysics/Structural_Mechanics');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 2);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.physics.create('solid', 'SolidMechanics', 'geom1');
model.physics('solid').model('comp1');

model.study.create('std1');
model.study('std1').create('stat', 'Stationary');
model.study('std1').feature('stat').setSolveFor('/physics/solid', true);

model.geom('geom1').create('pol1', 'Polygon');
model.geom('geom1').feature('pol1').set('source', 'vectors');
model.geom('geom1').feature('pol1').set('x', '0 4 4 0 0');
model.geom('geom1').feature('pol1').set('y', '0 1 3 4 0');
model.geom('geom1').run('pol1');
model.geom('geom1').create('pt1', 'Point');
model.geom('geom1').feature('pt1').setIndex('p', 2, 1);
model.geom('geom1').run('pt1');
model.geom('geom1').run('fin');

model.material.create('mat1', 'Common', 'comp1');
model.material('mat1').propertyGroup.create('Enu', 'Young''s_modulus_and_Poisson''s_ratio');
model.material('mat1').propertyGroup('Enu').set('E', {'210[GPa]'});
model.material('mat1').propertyGroup('Enu').set('nu', {'0.3'});
model.material('mat1').propertyGroup('def').set('density', {'7000[kg/m^3]'});

model.group.create('lg1', 'LoadGroup');
model.group('lg1').label('Load Group Gravity');
model.group('lg1').paramName('lgG');
model.group.create('lg2', 'LoadGroup');
model.group('lg2').label('Load Group Force');
model.group('lg2').paramName('lgF');
model.group.create('cg1', 'ConstraintGroup');
model.group('cg1').label('Constraint Group Gravity');
model.group('cg1').paramName('cgGravity');
model.group.create('cg2', 'ConstraintGroup');
model.group('cg2').label('Constraint Group Force');
model.group('cg2').paramName('cgForce');

model.physics('solid').prop('Type2D').set('Type2D', 'PlaneStress');
model.physics('solid').prop('d').set('d', 0.1);
model.physics('solid').create('fix1', 'Fixed', 1);
model.physics('solid').feature('fix1').selection.set([1 3]);
model.physics('solid').feature('fix1').set('constraintGroup', 'cg1');
model.physics('solid').create('bl1', 'BodyLoad', 2);
model.physics('solid').feature('bl1').selection.set([1]);
model.physics('solid').feature('bl1').set('FperVol', {'0' '-g_const*solid.rho' '0'});
model.physics('solid').feature('bl1').set('loadGroup', 'lg1');
model.physics('solid').create('roll1', 'Roller', 1);
model.physics('solid').feature('roll1').selection.set([1 3]);
model.physics('solid').feature('roll1').set('constraintGroup', 'cg2');
model.physics('solid').create('bndl1', 'BoundaryLoad', 1);
model.physics('solid').feature('bndl1').selection.set([5]);
model.physics('solid').feature('bndl1').set('LoadType', 'ForceLength');
model.physics('solid').feature('bndl1').set('FperLength', {'10[MN/m]' '0' '0'});
model.physics('solid').feature('bndl1').set('loadGroup', 'lg2');
model.physics('solid').create('fix2', 'Fixed', 0);
model.physics('solid').feature('fix2').selection.set([2]);

model.mesh('mesh1').run;

model.study('std1').feature('stat').set('useloadcase', true);
model.study('std1').feature('stat').setIndex('loadcase', 'Load case 1', 0);
model.study('std1').feature('stat').setIndex('loadgroup', false, 0, 0);
model.study('std1').feature('stat').setIndex('loadgroupweight', '1.0', 0, 0);
model.study('std1').feature('stat').setIndex('loadgroup', false, 0, 1);
model.study('std1').feature('stat').setIndex('loadgroupweight', '1.0', 0, 1);
model.study('std1').feature('stat').setIndex('constraintgroup', false, 0, 0);
model.study('std1').feature('stat').setIndex('constraintgroup', false, 0, 1);
model.study('std1').feature('stat').setIndex('loadcase', 'Load case 1', 0);
model.study('std1').feature('stat').setIndex('loadgroup', false, 0, 0);
model.study('std1').feature('stat').setIndex('loadgroupweight', '1.0', 0, 0);
model.study('std1').feature('stat').setIndex('loadgroup', false, 0, 1);
model.study('std1').feature('stat').setIndex('loadgroupweight', '1.0', 0, 1);
model.study('std1').feature('stat').setIndex('constraintgroup', false, 0, 0);
model.study('std1').feature('stat').setIndex('constraintgroup', false, 0, 1);
model.study('std1').feature('stat').setIndex('loadcase', 'Gravity', 0);
model.study('std1').feature('stat').setIndex('loadgroup', true, 0, 0);
model.study('std1').feature('stat').setIndex('constraintgroup', true, 0, 0);
model.study('std1').feature('stat').setIndex('loadcase', 'Load case 1', 1);
model.study('std1').feature('stat').setIndex('loadgroup', false, 1, 0);
model.study('std1').feature('stat').setIndex('loadgroupweight', '1.0', 1, 0);
model.study('std1').feature('stat').setIndex('loadgroup', false, 1, 1);
model.study('std1').feature('stat').setIndex('loadgroupweight', '1.0', 1, 1);
model.study('std1').feature('stat').setIndex('constraintgroup', false, 1, 0);
model.study('std1').feature('stat').setIndex('constraintgroup', false, 1, 1);
model.study('std1').feature('stat').setIndex('loadcase', 'Load case 1', 1);
model.study('std1').feature('stat').setIndex('loadgroup', false, 1, 0);
model.study('std1').feature('stat').setIndex('loadgroupweight', '1.0', 1, 0);
model.study('std1').feature('stat').setIndex('loadgroup', false, 1, 1);
model.study('std1').feature('stat').setIndex('loadgroupweight', '1.0', 1, 1);
model.study('std1').feature('stat').setIndex('constraintgroup', false, 1, 0);
model.study('std1').feature('stat').setIndex('constraintgroup', false, 1, 1);
model.study('std1').feature('stat').setIndex('loadcase', 'Force', 1);
model.study('std1').feature('stat').setIndex('loadgroup', true, 1, 1);
model.study('std1').feature('stat').setIndex('constraintgroup', true, 1, 1);

model.sol.create('sol1');
model.sol('sol1').study('std1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'stat');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').set('control', 'stat');
model.sol('sol1').create('s1', 'Stationary');
model.sol('sol1').feature('s1').create('p1', 'Parametric');
model.sol('sol1').feature('s1').feature.remove('pDef');
model.sol('sol1').feature('s1').feature('p1').set('control', 'stat');
model.sol('sol1').feature('s1').set('control', 'stat');
model.sol('sol1').feature('s1').feature('aDef').set('cachepattern', true);
model.sol('sol1').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('s1').feature('fc1').set('termonres', 'auto');
model.sol('sol1').feature('s1').feature('fc1').set('reserrfact', 1000);
model.sol('sol1').feature('s1').feature('fc1').set('linsolver', 'dDef');
model.sol('sol1').feature('s1').feature('fc1').set('termonres', 'auto');
model.sol('sol1').feature('s1').feature('fc1').set('reserrfact', 1000);
model.sol('sol1').feature('s1').feature.remove('fcDef');
model.sol('sol1').attach('std1');
model.sol('sol1').runAll;

model.result.create('pg1', 'PlotGroup2D');
model.result('pg1').set('data', 'dset1');
model.result('pg1').setIndex('looplevel', 2, 0);
model.result('pg1').set('defaultPlotID', 'stress');
model.result('pg1').label('Stress (solid)');
model.result('pg1').set('frametype', 'spatial');
model.result('pg1').create('surf1', 'Surface');
model.result('pg1').feature('surf1').set('expr', {'solid.misesGp'});
model.result('pg1').feature('surf1').set('threshold', 'manual');
model.result('pg1').feature('surf1').set('thresholdvalue', 0.2);
model.result('pg1').feature('surf1').set('colortable', 'Rainbow');
model.result('pg1').feature('surf1').set('colortabletrans', 'none');
model.result('pg1').feature('surf1').set('colorscalemode', 'linear');
model.result('pg1').feature('surf1').set('resolution', 'normal');
model.result('pg1').feature('surf1').set('colortable', 'Prism');
model.result('pg1').feature('surf1').create('def', 'Deform');
model.result('pg1').feature('surf1').feature('def').set('expr', {'u' 'v'});
model.result('pg1').feature('surf1').feature('def').set('descr', 'Displacement field');
model.result('pg1').run;
model.result('pg1').label('Normal stress');
model.result('pg1').run;
model.result('pg1').feature('surf1').set('expr', 'solid.sGpxx');
model.result('pg1').feature('surf1').set('descr', 'Stress tensor, xx-component');
model.result('pg1').run;
model.result('pg1').run;
model.result.duplicate('pg2', 'pg1');
model.result('pg2').run;
model.result('pg2').label('Shear stress');
model.result('pg2').setIndex('looplevel', 1, 0);
model.result('pg2').run;
model.result('pg2').feature('surf1').set('expr', 'solid.sGpxy');
model.result('pg2').run;
model.result.numerical.create('pev1', 'EvalPoint');
model.result.numerical('pev1').label('Point Evaluation - normal stress');
model.result.numerical('pev1').selection.set([2]);
model.result.numerical('pev1').set('expr', {'solid.sGpxx'});
model.result.numerical('pev1').set('descr', {'Stress tensor, xx-component'});
model.result.numerical('pev1').set('unit', {'N/m^2'});
model.result.table.create('tbl1', 'Table');
model.result.table('tbl1').comments('Point Evaluation - normal stress');
model.result.numerical('pev1').set('table', 'tbl1');
model.result.numerical('pev1').setResult;
model.result.numerical.create('pev2', 'EvalPoint');
model.result.numerical('pev2').label('Point Evaluation - shear stress');
model.result.numerical('pev2').selection.set([2]);
model.result.numerical('pev2').set('expr', {'solid.sGpxy'});
model.result.numerical('pev2').set('descr', {'Stress tensor, xy-component'});
model.result.numerical('pev2').set('unit', {'N/m^2'});
model.result.table.create('tbl2', 'Table');
model.result.table('tbl2').comments('Point Evaluation - shear stress');
model.result.numerical('pev2').set('table', 'tbl2');
model.result.numerical('pev2').setResult;
model.result('pg1').run;

model.title('Tapered Cantilever with Two Load Cases');

model.description('This example shows a 2D plane stress model of a thin tapered cantilever. Different boundary and load scenarios are examined. It is demonstrated how to apply and how to evaluate different load and constraint groups. Resulting stresses are compared to NAFEMS benchmark values.');

model.label('tapered_cantilever.mph');

model.modelNode.label('Components');

out = model;
