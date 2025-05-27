function out = model
%
% postbuckling_shell.m
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

model.physics.create('shell', 'Shell', 'geom1');
model.physics('shell').model('comp1');

model.study.create('std1');
model.study('std1').create('stat', 'Stationary');
model.study('std1').feature('stat').setSolveFor('/physics/shell', true);

model.param.set('R', '2540[mm]');
model.param.descr('R', 'Panel radius');
model.param.set('L', '254[mm]');
model.param.descr('L', 'Panel length');
model.param.set('thic', '6.35[mm]');
model.param.descr('thic', 'Panel thickness');
model.param.set('theta', '0.1[rad]');
model.param.descr('theta', 'Panel section angle');
model.param.set('E0', '3.103[GPa]');
model.param.descr('E0', 'Young''s modulus');
model.param.set('nu0', '0.3');
model.param.descr('nu0', 'Poisson''s ratio');
model.param.set('disp', '0');
model.param.descr('disp', 'Displacement parameter');

model.geom('geom1').create('wp1', 'WorkPlane');
model.geom('geom1').feature('wp1').set('unite', true);
model.geom('geom1').feature('wp1').set('quickplane', 'xz');
model.geom('geom1').feature('wp1').geom.create('ls1', 'LineSegment');
model.geom('geom1').feature('wp1').geom.feature('ls1').set('specify1', 'coord');
model.geom('geom1').feature('wp1').geom.feature('ls1').set('specify2', 'coord');
model.geom('geom1').feature('wp1').geom.feature('ls1').set('coord1', {'0' 'R'});
model.geom('geom1').feature('wp1').geom.feature('ls1').set('coord2', {'L' 'R'});
model.geom('geom1').feature('wp1').geom.run('ls1');
model.geom('geom1').run('wp1');
model.geom('geom1').feature.create('rev1', 'Revolve');
model.geom('geom1').feature('rev1').set('angtype', 'specang');
model.geom('geom1').feature('rev1').set('angle2', 'theta');
model.geom('geom1').feature('rev1').set('axis', [1 0]);
model.geom('geom1').run('rev1');

model.cpl.create('aveop1', 'Average', 'geom1');

model.geom('geom1').run;

model.cpl('aveop1').set('axisym', true);
model.cpl('aveop1').selection.geom('geom1', 2);
model.cpl('aveop1').selection.set([1]);
model.cpl.create('intop1', 'Integration', 'geom1');
model.cpl('intop1').set('axisym', true);
model.cpl('intop1').selection.geom('geom1', 0);
model.cpl('intop1').selection.set([4]);

model.variable.create('var1');
model.variable('var1').model('comp1');
model.variable('var1').set('w_center', '-intop1(w)');
model.variable('var1').descr('w_center', 'Vertical displacement at shell center');

model.physics('shell').feature('to1').set('d', 'thic');
model.physics('shell').create('sym1', 'SymmetrySolid1', 1);
model.physics('shell').feature('sym1').selection.set([3]);
model.physics('shell').create('sym2', 'SymmetrySolid1', 1);
model.physics('shell').feature('sym2').selection.set([4]);
model.physics('shell').feature('sym2').set('coordinateSystem', 'GlobalSystem');
model.physics('shell').feature('sym2').set('NormalAxis', 1);
model.physics('shell').create('pin1', 'Pinned', 1);
model.physics('shell').feature('pin1').selection.set([2]);
model.physics('shell').create('pl1', 'PointLoad', 0);
model.physics('shell').feature('pl1').selection.set([4]);
model.physics('shell').feature('pl1').set('Fp', {'0' '0' '-P/4'});
model.physics('shell').create('ge1', 'GlobalEquations', -1);
model.physics('shell').feature('ge1').setIndex('name', 'P', 0, 0);
model.physics('shell').feature('ge1').setIndex('equation', 'aveop1(-w)-disp', 0, 0);
model.physics('shell').feature('ge1').setIndex('description', 'Force at shell center', 0, 0);
model.physics('shell').feature('ge1').set('DependentVariableQuantity', 'force');
model.physics('shell').feature('ge1').set('SourceTermQuantity', 'displacement');

model.material.create('mat1', 'Common', 'comp1');
model.material('mat1').propertyGroup.create('Enu', 'Young''s_modulus_and_Poisson''s_ratio');
model.material('mat1').propertyGroup('Enu').set('E', {'E0'});
model.material('mat1').propertyGroup('Enu').set('nu', {'nu0'});
model.material('mat1').propertyGroup('def').set('density', {'0'});

model.mesh('mesh1').create('map1', 'Map');
model.mesh('mesh1').feature('map1').selection.set([1]);
model.mesh('mesh1').feature('map1').create('dis1', 'Distribution');
model.mesh('mesh1').feature('map1').feature('dis1').selection.set([1 2]);
model.mesh('mesh1').feature('map1').feature('dis1').set('numelem', 10);
model.mesh('mesh1').run('map1');

model.study('std1').feature('stat').set('useparam', true);
model.study('std1').feature('stat').setIndex('pname', 'R', 0);
model.study('std1').feature('stat').setIndex('plistarr', '', 0);
model.study('std1').feature('stat').setIndex('punit', 'm', 0);
model.study('std1').feature('stat').setIndex('pname', 'R', 0);
model.study('std1').feature('stat').setIndex('plistarr', '', 0);
model.study('std1').feature('stat').setIndex('punit', 'm', 0);
model.study('std1').feature('stat').setIndex('pname', 'disp', 0);
model.study('std1').feature('stat').setIndex('plistarr', 'range(0,2e-4,1)', 0);
model.study('std1').feature('stat').set('geometricNonlinearity', true);
model.study('std1').label('Postbuckling Study');

model.sol.create('sol1');
model.sol('sol1').study('std1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'stat');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').feature('comp1_ar').set('scalemethod', 'manual');
model.sol('sol1').feature('v1').feature('comp1_ar').set('resscalemethod', 'parent');
model.sol('sol1').feature('v1').feature('comp1_ar').set('scaleval', '0.01');
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
model.sol('sol1').feature('s1').feature('p1').create('st1', 'StopCondition');
model.sol('sol1').feature('s1').feature('p1').feature('st1').setIndex('stopcondarr', '', 0);
model.sol('sol1').feature('s1').feature('p1').feature('st1').setIndex('stopcondterminateon', 'true', 0);
model.sol('sol1').feature('s1').feature('p1').feature('st1').setIndex('stopcondActive', true, 0);
model.sol('sol1').feature('s1').feature('p1').feature('st1').setIndex('stopconddesc', 'Stop expression 1', 0);
model.sol('sol1').feature('s1').feature('p1').feature('st1').setIndex('stopcondarr', '', 0);
model.sol('sol1').feature('s1').feature('p1').feature('st1').setIndex('stopcondterminateon', 'true', 0);
model.sol('sol1').feature('s1').feature('p1').feature('st1').setIndex('stopcondActive', true, 0);
model.sol('sol1').feature('s1').feature('p1').feature('st1').setIndex('stopconddesc', 'Stop expression 1', 0);
model.sol('sol1').feature('s1').feature('p1').feature('st1').setIndex('stopcondarr', 'comp1.w_center>0.035', 0);
model.sol('sol1').feature('s1').feature('p1').feature('st1').set('storestopcondsol', 'stepbefore');
model.sol('sol1').feature('s1').feature('p1').feature('st1').set('stopcondwarn', false);
model.sol('sol1').feature('s1').set('reacf', false);
model.sol('sol1').runAll;

model.result.dataset.create('dset1shellshl', 'Shell');
model.result.dataset('dset1shellshl').set('data', 'dset1');
model.result.dataset('dset1shellshl').setIndex('topconst', '1', 3, 1);
model.result.dataset('dset1shellshl').setIndex('bottomconst', '-1', 3, 1);
model.result.dataset('dset1shellshl').setIndex('orientationexpr', 'shell.nlX', 0);
model.result.dataset('dset1shellshl').setIndex('displacementexpr', 'arx', 0);
model.result.dataset('dset1shellshl').setIndex('orientationexpr', 'shell.nlY', 1);
model.result.dataset('dset1shellshl').setIndex('displacementexpr', 'ary', 1);
model.result.dataset('dset1shellshl').setIndex('orientationexpr', 'shell.nlZ', 2);
model.result.dataset('dset1shellshl').setIndex('displacementexpr', 'arz', 2);
model.result.dataset('dset1shellshl').set('distanceexpr', 'shell.z_pos');
model.result.dataset('dset1shellshl').set('seplevels', false);
model.result.dataset('dset1shellshl').set('resolution', 2);
model.result.dataset('dset1shellshl').set('areascalefactor', 'shell.ASF');
model.result.dataset('dset1shellshl').set('linescalefactor', 'shell.LSF');
model.result.create('pg1', 'PlotGroup3D');
model.result('pg1').set('data', 'dset1shellshl');
model.result('pg1').setIndex('looplevel', 92, 0);
model.result('pg1').set('defaultPlotID', 'stress');
model.result('pg1').label('Stress (shell)');
model.result('pg1').set('showlegends', true);
model.result('pg1').set('frametype', 'spatial');
model.result('pg1').create('surf1', 'Surface');
model.result('pg1').feature('surf1').set('expr', {'shell.misesGp'});
model.result('pg1').feature('surf1').set('threshold', 'manual');
model.result('pg1').feature('surf1').set('thresholdvalue', 0.2);
model.result('pg1').feature('surf1').set('colortable', 'Rainbow');
model.result('pg1').feature('surf1').set('colortabletrans', 'none');
model.result('pg1').feature('surf1').set('colorscalemode', 'linear');
model.result('pg1').feature('surf1').set('descr', 'von Mises stress');
model.result('pg1').feature('surf1').set('colortable', 'Prism');
model.result('pg1').feature('surf1').create('def', 'Deform');
model.result('pg1').feature('surf1').feature('def').set('expr', {'shell.u' 'shell.v' 'shell.w'});
model.result('pg1').feature('surf1').feature('def').set('scaleactive', true);
model.result('pg1').feature('surf1').feature('def').set('scale', '1');
model.result('pg1').run;
model.result.evaluationGroup.create('eg1', 'EvaluationGroup');
model.result.evaluationGroup('eg1').label('Evaluation Group: Force vs. Displacement');
model.result.evaluationGroup('eg1').create('pev1', 'EvalPoint');
model.result.evaluationGroup('eg1').feature('pev1').selection.set([4]);
model.result.evaluationGroup('eg1').feature('pev1').setIndex('expr', 'w_center', 0);
model.result.evaluationGroup('eg1').feature('pev1').setIndex('expr', 'P', 1);
model.result.evaluationGroup('eg1').set('includeparameters', false);
model.result.evaluationGroup('eg1').run;
model.result.create('pg2', 'PlotGroup1D');
model.result('pg2').run;
model.result('pg2').label('Force vs. Displacement');
model.result('pg2').set('xlabelactive', true);
model.result('pg2').set('xlabel', 'Vertical displacement at shell center (m)');
model.result('pg2').set('ylabelactive', true);
model.result('pg2').set('ylabel', 'Force at shell center (N)');
model.result('pg2').create('tblp1', 'Table');
model.result('pg2').feature('tblp1').set('markerpos', 'datapoints');
model.result('pg2').feature('tblp1').set('linewidth', 'preference');
model.result('pg2').feature('tblp1').set('source', 'evaluationgroup');
model.result('pg2').run;

model.title('Postbuckling Analysis of a Hinged Cylindrical Shell');

model.description('This example shows how to trace a postbuckling path where neither load nor displacement is increasing monotonously. The results are compared to published values.');

model.mesh.clearMeshes;

model.sol('sol1').clearSolutionData;

model.label('postbuckling_shell.mph');

model.modelNode.label('Components');

out = model;
