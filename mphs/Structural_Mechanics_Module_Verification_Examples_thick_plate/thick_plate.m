function out = model
%
% thick_plate.m
%
% Model exported on May 26 2025, 21:34 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/Structural_Mechanics_Module/Verification_Examples');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 3);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.physics.create('solid', 'SolidMechanics', 'geom1');
model.physics('solid').model('comp1');

model.study.create('std1');
model.study('std1').create('stat', 'Stationary');
model.study('std1').feature('stat').setSolveFor('/physics/solid', true);

model.geom('geom1').create('wp1', 'WorkPlane');
model.geom('geom1').feature('wp1').set('unite', true);
model.geom('geom1').feature('wp1').geom.create('e1', 'Ellipse');
model.geom('geom1').feature('wp1').geom.feature('e1').set('semiaxes', [3.25 2.75]);
model.geom('geom1').feature('wp1').geom.feature('e1').set('angle', 90);
model.geom('geom1').feature('wp1').geom.run('e1');
model.geom('geom1').feature('wp1').geom.create('e2', 'Ellipse');
model.geom('geom1').feature('wp1').geom.feature('e2').set('semiaxes', [2 1]);
model.geom('geom1').feature('wp1').geom.feature('e2').set('angle', 90);
model.geom('geom1').feature('wp1').geom.run('e2');
model.geom('geom1').feature('wp1').geom.create('e3', 'Ellipse');
model.geom('geom1').feature('wp1').geom.feature('e3').set('semiaxes', [2.416 1.583]);
model.geom('geom1').feature('wp1').geom.feature('e3').set('angle', 90);
model.geom('geom1').feature('wp1').geom.run('e3');
model.geom('geom1').feature('wp1').geom.create('dif1', 'Difference');
model.geom('geom1').feature('wp1').geom.feature('dif1').selection('input').set({'e1' 'e3'});
model.geom('geom1').feature('wp1').geom.feature('dif1').selection('input2').set({'e2'});
model.geom('geom1').feature('wp1').geom.run('dif1');
model.geom('geom1').feature('wp1').geom.create('pol1', 'Polygon');
model.geom('geom1').feature('wp1').geom.feature('pol1').set('source', 'table');
model.geom('geom1').feature('wp1').geom.feature('pol1').set('type', 'open');
model.geom('geom1').feature('wp1').geom.feature('pol1').setIndex('table', 1.783, 0, 0);
model.geom('geom1').feature('wp1').geom.feature('pol1').setIndex('table', 2.3, 0, 1);
model.geom('geom1').feature('wp1').geom.feature('pol1').setIndex('table', 1.165, 1, 0);
model.geom('geom1').feature('wp1').geom.feature('pol1').setIndex('table', 0.812, 1, 1);
model.geom('geom1').feature('wp1').geom.run('pol1');
model.geom('geom1').feature('wp1').geom.create('pol2', 'Polygon');
model.geom('geom1').feature('wp1').geom.feature('pol2').set('source', 'table');
model.geom('geom1').feature('wp1').geom.feature('pol2').set('type', 'open');
model.geom('geom1').feature('wp1').geom.feature('pol2').setIndex('table', 2.833, 0, 0);
model.geom('geom1').feature('wp1').geom.feature('pol2').setIndex('table', 1.348, 0, 1);
model.geom('geom1').feature('wp1').geom.feature('pol2').setIndex('table', 1.783, 1, 0);
model.geom('geom1').feature('wp1').geom.feature('pol2').setIndex('table', 0.453, 1, 1);
model.geom('geom1').feature('wp1').geom.run('pol2');
model.geom('geom1').feature('wp1').geom.create('par1', 'Partition');
model.geom('geom1').feature('wp1').geom.feature('par1').selection('input').set({'dif1'});
model.geom('geom1').feature('wp1').geom.feature('par1').selection('tool').set({'pol1' 'pol2'});
model.geom('geom1').feature('wp1').geom.run('par1');
model.geom('geom1').run('wp1');
model.geom('geom1').feature.create('ext1', 'Extrude');
model.geom('geom1').feature('ext1').set('workplane', 'wp1');
model.geom('geom1').feature('ext1').selection('input').set({'wp1'});
model.geom('geom1').feature('ext1').setIndex('distance', 0.3, 0);
model.geom('geom1').feature('ext1').setIndex('distance', 0.6, 1);
model.geom('geom1').feature('ext1').set('displ', {'0' '0'; '0' '0'});
model.geom('geom1').feature('ext1').set('scale', {'1' '1'; '1' '1'});
model.geom('geom1').feature('ext1').set('twist', {'0' '0'});
model.geom('geom1').run('ext1');
model.geom('geom1').run;

model.material.create('mat1', 'Common', 'comp1');
model.material('mat1').propertyGroup.create('Enu', 'Young''s_modulus_and_Poisson''s_ratio');
model.material('mat1').propertyGroup('Enu').set('E', {'210[GPa]'});
model.material('mat1').propertyGroup('Enu').set('nu', {'0.3'});
model.material('mat1').propertyGroup('def').set('density', {'7850'});

model.physics('solid').create('sym1', 'SymmetrySolid', 2);
model.physics('solid').feature('sym1').selection.set([1 4 8 11 40 41 49 50]);
model.physics('solid').create('disp1', 'Displacement2', 2);
model.physics('solid').feature('disp1').selection.set([15 16 31 32 51 52]);
model.physics('solid').feature('disp1').setIndex('Direction', 'prescribed', 0);
model.physics('solid').feature('disp1').setIndex('Direction', 'prescribed', 1);
model.physics('solid').create('disp2', 'Displacement1', 1);
model.physics('solid').feature('disp2').selection.set([20 41 72]);
model.physics('solid').feature('disp2').setIndex('Direction', 'prescribed', 2);
model.physics('solid').create('bndl1', 'BoundaryLoad', 2);
model.physics('solid').feature('bndl1').selection.set([7 14 23 30 39 48]);
model.physics('solid').feature('bndl1').set('FperArea', {'0' '0' '-1e6'});

model.mesh('mesh1').create('map1', 'Map');
model.mesh('mesh1').feature('map1').create('dis1', 'Distribution');
model.mesh('mesh1').feature('map1').selection.set([7 14 23 30 39 48]);
model.mesh('mesh1').feature('map1').feature('dis1').set('numelem', 2);
model.mesh('mesh1').feature('map1').feature('dis1').selection.all;
model.mesh('mesh1').run('map1');
model.mesh('mesh1').create('swe1', 'Sweep');
model.mesh('mesh1').run;

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
model.sol('sol1').feature('s1').feature('d1').label('Suggested Direct Solver (solid)');
model.sol('sol1').feature('s1').create('i1', 'Iterative');
model.sol('sol1').feature('s1').feature('i1').set('linsolver', 'gmres');
model.sol('sol1').feature('s1').feature('i1').set('rhob', 400);
model.sol('sol1').feature('s1').feature('i1').set('nlinnormuse', true);
model.sol('sol1').feature('s1').feature('i1').label('Suggested Iterative Solver (solid)');
model.sol('sol1').feature('s1').feature('i1').create('mg1', 'Multigrid');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').set('prefun', 'gmg');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('pr').create('so1', 'SOR');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('pr').feature('so1').set('relax', 0.8);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('po').create('so1', 'SOR');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('po').feature('so1').set('relax', 0.8);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('cs').create('d1', 'Direct');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('cs').feature('d1').set('linsolver', 'pardiso');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('cs').feature('d1').set('pivotperturb', 1.0E-9);
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
model.result('pg1').feature('vol1').feature('def').set('expr', {'u' 'v' 'w'});
model.result('pg1').feature('vol1').feature('def').set('descr', 'Displacement field');
model.result('pg1').run;
model.result.numerical.create('pev1', 'EvalPoint');
model.result.numerical('pev1').selection.set([24]);
model.result.numerical('pev1').set('expr', {'solid.sGpyy'});
model.result.numerical('pev1').set('descr', {'Stress tensor, yy-component'});
model.result.numerical('pev1').set('unit', {'N/m^2'});
model.result.numerical('pev1').setIndex('unit', 'MPa', 0);
model.result.numerical('pev1').setIndex('descr', 'Stress tensor, y-component (COMSOL)', 0);
model.result.numerical('pev1').setIndex('expr', '-5.38[MPa]', 1);
model.result.numerical('pev1').setIndex('unit', 'MPa', 1);
model.result.numerical('pev1').setIndex('descr', 'Stress tensor, y-component (NAFEMS)', 1);
model.result.table.create('tbl1', 'Table');
model.result.table('tbl1').comments('Point Evaluation 1');
model.result.numerical('pev1').set('table', 'tbl1');
model.result.numerical('pev1').setResult;
model.result('pg1').run;
model.result('pg1').feature('vol1').set('expr', 'solid.sGpyy');
model.result('pg1').feature('vol1').set('descr', 'Stress tensor, yy-component');
model.result('pg1').feature('vol1').set('unit', 'MPa');
model.result('pg1').feature('vol1').set('colortable', 'Rainbow');
model.result('pg1').run;

model.title('Thick Plate Stress Analysis');

model.description(['A benchmark where a thick plate exposed to pressure on the top surface is analyzed.' newline 'The solution is compared with a NAFEMS benchmark solution.']);

model.label('thick_plate.mph');

model.modelNode.label('Components');

out = model;
