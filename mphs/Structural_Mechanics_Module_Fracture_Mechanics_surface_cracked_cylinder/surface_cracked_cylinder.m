function out = model
%
% surface_cracked_cylinder.m
%
% Model exported on May 26 2025, 21:33 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/Structural_Mechanics_Module/Fracture_Mechanics');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 3);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.physics.create('solid', 'SolidMechanics', 'geom1');
model.physics('solid').model('comp1');

model.study.create('std1');
model.study('std1').create('stat', 'Stationary');
model.study('std1').feature('stat').setSolveFor('/physics/solid', true);

model.geom('geom1').insertFile('surface_cracked_cylinder_geom_sequence.mph', 'geom1');
model.geom('geom1').run('cmd1');

model.param.set('p', '1[MPa]');
model.param.descr('p', 'Pressure load');

model.material.create('mat1', 'Common', 'comp1');
model.material('mat1').propertyGroup.create('Enu', 'Young''s_modulus_and_Poisson''s_ratio');
model.material('mat1').propertyGroup('Enu').set('E', {'207[GPa]'});
model.material('mat1').propertyGroup('Enu').set('nu', {'0.3'});
model.material('mat1').propertyGroup('def').set('density', {'8000'});

model.physics('solid').create('sym1', 'SymmetrySolid', 2);
model.physics('solid').feature('sym1').selection.set([1 2 5 6 8 9 11 12 15 22 26]);
model.physics('solid').create('disp1', 'Displacement0', 0);
model.physics('solid').feature('disp1').selection.set([11]);
model.physics('solid').feature('disp1').setIndex('Direction', 'prescribed', 2);
model.physics('solid').create('crack1', 'Crack', 2);
model.physics('solid').feature('crack1').selection.set([6 9]);
model.physics('solid').feature('crack1').set('CrackSurface', 'Symmetric');
model.physics('solid').feature('crack1').selection('CrackFront').set([13]);
model.physics('solid').feature('crack1').create('jint1', 'JIntegral', 1);
model.physics('solid').create('bndl1', 'BoundaryLoad', 2);
model.physics('solid').feature('bndl1').selection.set([4 7 17 24 27 31]);
model.physics('solid').feature('bndl1').set('LoadType', 'FollowerPressure');
model.physics('solid').feature('bndl1').set('FollowerPressure', 'p');
model.physics('solid').feature('crack1').create('fl1', 'CrackFaceLoad', 2);
model.physics('solid').feature('crack1').feature('fl1').set('p', 'p');

model.mesh('mesh1').create('ftri1', 'FreeTri');
model.mesh('mesh1').feature('size').set('custom', true);
model.mesh('mesh1').feature('size').set('hmax', 'th/2');
model.mesh('mesh1').feature('size').set('hmin', 'a/200');
model.mesh('mesh1').feature('ftri1').selection.set([8]);
model.mesh('mesh1').feature('ftri1').create('size1', 'Size');
model.mesh('mesh1').feature('ftri1').feature('size1').selection.geom('geom1', 0);
model.mesh('mesh1').feature('ftri1').feature('size1').selection.set([5]);
model.mesh('mesh1').feature('ftri1').feature('size1').set('custom', true);
model.mesh('mesh1').feature('ftri1').feature('size1').set('hmaxactive', true);
model.mesh('mesh1').feature('ftri1').feature('size1').set('hmax', 'a/100');
model.mesh('mesh1').feature('ftri1').feature('size1').set('hminactive', true);
model.mesh('mesh1').feature('ftri1').feature('size1').set('hmin', 'a/200');
model.mesh('mesh1').feature('ftri1').feature('size1').set('hgradactive', true);
model.mesh('mesh1').feature('ftri1').feature('size1').set('hgrad', 1.2);
model.mesh('mesh1').run('ftri1');
model.mesh('mesh1').create('swe1', 'Sweep');
model.mesh('mesh1').feature('swe1').selection.geom('geom1', 3);
model.mesh('mesh1').feature('swe1').selection.set([3]);
model.mesh('mesh1').feature('swe1').set('targetmesh', 'morph');
model.mesh('mesh1').feature('swe1').create('dis1', 'Distribution');
model.mesh('mesh1').feature('swe1').feature('dis1').set('type', 'predefined');
model.mesh('mesh1').feature('swe1').feature('dis1').set('elemcount', 40);
model.mesh('mesh1').feature('swe1').feature('dis1').set('elemratio', 6);
model.mesh('mesh1').feature('swe1').feature('dis1').set('reverse', true);
model.mesh('mesh1').run('swe1');
model.mesh('mesh1').create('ftet1', 'FreeTet');
model.mesh('mesh1').feature('ftet1').selection.geom('geom1', 3);
model.mesh('mesh1').feature('ftet1').selection.set([2]);
model.mesh('mesh1').run('ftet1');
model.mesh('mesh1').create('swe2', 'Sweep');
model.mesh('mesh1').feature('swe2').selection.geom('geom1', 3);
model.mesh('mesh1').feature('swe2').selection.set([1 4]);
model.mesh('mesh1').create('swe3', 'Sweep');
model.mesh('mesh1').feature('swe3').create('dis1', 'Distribution');
model.mesh('mesh1').feature('swe3').feature('dis1').set('type', 'predefined');
model.mesh('mesh1').feature('swe3').feature('dis1').set('elemcount', 12);
model.mesh('mesh1').feature('swe3').feature('dis1').set('elemratio', 4);
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
model.result('pg1').feature('vol1').set('smooth', 'none');
model.result('pg1').feature('vol1').set('colortabletrans', 'nonlinear');
model.result('pg1').feature('vol1').set('colorcalibration', -1);
model.result('pg1').feature('vol1').create('def', 'Deform');
model.result('pg1').feature('vol1').feature('def').set('expr', {'u' 'v' 'w'});
model.result('pg1').feature('vol1').feature('def').set('descr', 'Displacement field');
model.result('pg1').run;
model.result('pg1').run;
model.result('pg1').feature('vol1').set('unit', 'MPa');
model.result('pg1').feature('vol1').set('rangecoloractive', true);
model.result('pg1').feature('vol1').set('rangecolormax', 20);
model.result('pg1').run;
model.result('pg1').set('edges', false);
model.result('pg1').run;
model.result.create('pg2', 'PlotGroup3D');
model.result('pg2').set('data', 'dset1');
model.result('pg2').set('defaultPlotID', 'cracks');
model.result('pg2').label('Cracks (solid)');
model.result('pg2').set('showlegends', true);
model.result('pg2').set('titletype', 'label');
model.result('pg2').set('frametype', 'material');
model.result('pg2').set('showlegendsunit', true);
model.result('pg2').create('arwl1', 'ArrowLine');
model.result('pg2').feature('arwl1').set('expr', {'solid.crack1.e1X*solid.crack1.crackSize ' 'solid.crack1.e1Y*solid.crack1.crackSize ' 'solid.crack1.e1Z*solid.crack1.crackSize '});
model.result('pg2').feature('arwl1').set('placement', 'elements');
model.result('pg2').feature('arwl1').set('scaleactive', true);
model.result('pg2').feature('arwl1').set('scale', '1');
model.result('pg2').feature('arwl1').label('Crack Growth Direction (Crack 1)');
model.result('pg2').create('arwl2', 'ArrowLine');
model.result('pg2').feature('arwl2').set('expr', {'solid.crack1.e1X*solid.crack1.crackSize ' 'solid.crack1.e1Y*solid.crack1.crackSize ' 'solid.crack1.e1Z*solid.crack1.crackSize '});
model.result('pg2').feature('arwl2').set('placement', 'elements');
model.result('pg2').feature('arwl2').set('scaleactive', true);
model.result('pg2').feature('arwl2').set('scale', '1');
model.result('pg2').feature('arwl2').label('Crack Growth Direction (Crack 1) 1');
model.result('pg2').feature('arwl2').active(false);
model.result('pg2').create('arwl3', 'ArrowLine');
model.result('pg2').feature('arwl3').set('expr', {'solid.crack1.e1X*solid.crack1.crackSize*solid.crack1.jint1.J/solid.crack1.jint1.Jmax' 'solid.crack1.e1Y*solid.crack1.crackSize*solid.crack1.jint1.J/solid.crack1.jint1.Jmax' 'solid.crack1.e1Z*solid.crack1.crackSize*solid.crack1.jint1.J/solid.crack1.jint1.Jmax'});
model.result('pg2').feature('arwl3').set('placement', 'elements');
model.result('pg2').feature('arwl3').set('scaleactive', true);
model.result('pg2').feature('arwl3').set('scale', '1');
model.result('pg2').feature('arwl3').label('J-Integral 1, Evaluation');
model.result('pg2').feature('arwl3').create('col1', 'Color');
model.result('pg2').feature('arwl3').feature('col1').set('expr', 'root.comp1.solid.crack1.jint1.J');
model.result('pg2').create('con1', 'Isosurface');
model.result('pg2').feature('con1').set('expr', 'sqrt((X-solid.crack1.jint1.Xp)^2+(Y-solid.crack1.jint1.Yp)^2+(Z-solid.crack1.jint1.Zp)^2)');
model.result('pg2').feature('con1').set('levelmethod', 'levels');
model.result('pg2').feature('con1').set('levels', {'solid.crack1.jint1.r'});
model.result('pg2').feature('con1').set('coloring', 'uniform');
model.result('pg2').feature('con1').set('color', 'gray');
model.result('pg2').feature('con1').create('tran1', 'Transparency');
model.result('pg2').feature('con1').set('colorlegend', false);
model.result('pg2').feature('con1').label('J-Integral 1, Integration Path');
model.result('pg2').label('Cracks (solid)');
model.result('pg2').run;
model.result.create('pg3', 'PlotGroup1D');
model.result('pg3').set('data', 'dset1');
model.result('pg3').set('defaultPlotID', 'jIntegralcrack1');
model.result('pg3').label('Crack 1, J-Integral (solid)');
model.result('pg3').set('showlegends', false);
model.result('pg3').set('titletype', 'label');
model.result('pg3').create('jint1', 'LineGraph');
model.result('pg3').feature('jint1').selection.set([13]);
model.result('pg3').feature('jint1').set('expr', 'solid.crack1.jint1.J');
model.result('pg3').feature('jint1').set('resolution', 'norefine');
model.result('pg3').feature('jint1').label('J-Integral 1');
model.result('pg3').label('Crack 1, J-Integral (solid)');
model.result('pg3').run;

model.variable.create('var1');
model.variable('var1').model('comp1');
model.variable('var1').selection.geom('geom1', 3);
model.variable('var1').selection.set([2 3]);
model.variable('var1').set('angle', 'atan2((Z-R1)/a,X/c)');
model.variable('var1').descr('angle', 'Parametric angle');

model.sol('sol1').updateSolution;

model.result('pg1').run;
model.result('pg3').run;
model.result('pg3').run;
model.result('pg3').feature('jint1').set('xdata', 'expr');
model.result('pg3').feature('jint1').set('xdataexpr', 'angle');
model.result('pg3').feature('jint1').set('xdataunit', [native2unicode(hex2dec({'00' 'b0'}), 'unicode') ]);
model.result('pg3').run;
model.result('pg3').run;
model.result.duplicate('pg4', 'pg3');
model.result('pg4').run;
model.result('pg4').label('Crack 1, KI');
model.result('pg4').run;
model.result('pg4').feature('jint1').label('KI');
model.result('pg4').feature('jint1').set('expr', 'solid.crack1.jint1.KI');
model.result('pg4').feature('jint1').set('descr', 'Stress intensity factor, mode I');
model.result('pg4').feature('jint1').set('expr', 'solid.crack1.jint1.KI/1e6');
model.result('pg4').run;
model.result('pg4').set('xlabelactive', true);
model.result('pg4').set('ylabelactive', true);
model.result('pg4').set('ylabel', 'Stress intensity factor');
model.result('pg4').set('axislimits', true);
model.result('pg4').set('ymin', 0);
model.result('pg4').run;
model.result.table.create('tbl1', 'Table');
model.result.table('tbl1').importData('surface_cracked_cylinder_results.txt');
model.result('pg4').run;
model.result('pg4').create('tblp1', 'Table');
model.result('pg4').feature('tblp1').set('markerpos', 'datapoints');
model.result('pg4').feature('tblp1').set('linewidth', 'preference');
model.result('pg4').feature('tblp1').set('linecolor', 'fromtheme');
model.result('pg4').feature('tblp1').set('linestyle', 'none');
model.result('pg4').feature('tblp1').set('linemarker', 'asterisk');
model.result('pg4').run;
model.result('pg4').run;
model.result('pg4').set('showlegends', true);
model.result('pg4').set('legendpos', 'upperleft');
model.result('pg4').run;
model.result('pg4').feature('jint1').set('legend', true);
model.result('pg4').feature('jint1').set('autosolution', false);
model.result('pg4').feature('jint1').set('autoplotlabel', true);
model.result('pg4').run;
model.result('pg4').feature('tblp1').set('legend', true);
model.result('pg4').feature('tblp1').set('legendmethod', 'manual');
model.result('pg4').feature('tblp1').setIndex('legends', 'KI, reference', 0);
model.result.evaluationGroup.create('eg_dset1solid', 'EvaluationGroup');
model.result.evaluationGroup('eg_dset1solid').set('defaultPlotID', 'crackTable');
model.result.evaluationGroup('eg_dset1solid').label('Fracture Mechanics Results (solid)');
model.result.evaluationGroup('eg_dset1solid').set('data', 'dset1');
model.result.evaluationGroup('eg_dset1solid').set('transpose', true);
model.result.evaluationGroup('eg_dset1solid').create('jint', 'EvalGlobal');
model.result.evaluationGroup('eg_dset1solid').feature('jint').label('J-Integrals');
model.result.evaluationGroup('eg_dset1solid').feature('jint').setIndex('expr', 'solid.crack1.jint1.Jmax', 0);
model.result.evaluationGroup('eg_dset1solid').feature('jint').setIndex('descr', 'Maximum J-integral [crack1/jint1]', 0);
model.result.evaluationGroup('eg_dset1solid').create('sif1', 'EvalGlobal');
model.result.evaluationGroup('eg_dset1solid').feature('sif1').label('Stress Intensity Factors, Mode 1');
model.result.evaluationGroup('eg_dset1solid').feature('sif1').setIndex('expr', 'solid.crack1.jint1.KImax', 0);
model.result.evaluationGroup('eg_dset1solid').feature('sif1').setIndex('descr', 'Maximum stress intensity factor, mode I [crack1/jint1]', 0);
model.result.evaluationGroup('eg_dset1solid').create('sif2', 'EvalGlobal');
model.result.evaluationGroup('eg_dset1solid').feature('sif2').label('Stress Intensity Factors, Mode 2');
model.result.evaluationGroup('eg_dset1solid').feature('sif2').setIndex('expr', 'solid.crack1.jint1.KIImax', 0);
model.result.evaluationGroup('eg_dset1solid').feature('sif2').setIndex('descr', 'Maximum stress intensity factor, mode II [crack1/jint1]', 0);
model.result.evaluationGroup('eg_dset1solid').create('sif3', 'EvalGlobal');
model.result.evaluationGroup('eg_dset1solid').feature('sif3').label('Stress Intensity Factors, Mode 3');
model.result.evaluationGroup('eg_dset1solid').feature('sif3').setIndex('expr', 'solid.crack1.jint1.KIIImax', 0);
model.result.evaluationGroup('eg_dset1solid').feature('sif3').setIndex('descr', 'Maximum stress intensity factor, mode III [crack1/jint1]', 0);
model.result.evaluationGroup('eg_dset1solid').label('Fracture Mechanics Results (solid)');
model.result('pg1').run;

model.title('Surface Cracked Cylinder');

model.description('In this benchmark example, a semi-elliptical crack at the inner surface of a cylinder is studied. The inside of the cylinder and the crack faces are subjected to a pressure load. The J-integral is calculated along the crack front, and the stress intensity factor is then compared with the reference values.');

model.label('surface_cracked_cylinder.mph');

model.modelNode.label('Components');

out = model;
