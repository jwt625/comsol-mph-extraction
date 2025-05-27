function out = model
%
% biomedical_stent.m
%
% Model exported on May 26 2025, 21:31 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/Nonlinear_Structural_Materials_Module/Plasticity');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 3);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.physics.create('solid', 'SolidMechanics', 'geom1');
model.physics('solid').model('comp1');

model.study.create('std1');
model.study('std1').create('stat', 'Stationary');
model.study('std1').feature('stat').setSolveFor('/physics/solid', true);

model.geom('geom1').create('imp1', 'Import');
model.geom('geom1').feature('imp1').set('type', 'native');
model.geom('geom1').feature('imp1').set('filename', 'biomedical_stent.mphbin');
model.geom('geom1').feature('imp1').importData;
model.geom('geom1').run;

model.physics('solid').feature('lemm1').set('geometricNonlinearity', 'totalLagrangian');
model.physics('solid').feature('lemm1').create('plsty1', 'Plasticity', 3);

model.material.create('mat1', 'Common', 'comp1');
model.material('mat1').propertyGroup.create('Enu', 'Young''s_modulus_and_Poisson''s_ratio');
model.material('mat1').propertyGroup('Enu').set('E', {'193[GPa]'});
model.material('mat1').propertyGroup('Enu').set('nu', {'0.27'});
model.material('mat1').propertyGroup('def').set('density', {'7050'});
model.material('mat1').propertyGroup.create('ElastoplasticModel', 'Elastoplastic_material_model');
model.material('mat1').propertyGroup('ElastoplasticModel').set('sigmags', {'207[MPa]'});
model.material('mat1').propertyGroup('ElastoplasticModel').set('Et', {'692[MPa]'});
model.material('mat1').set('family', 'steel');

model.func.create('step1', 'Step');
model.func('step1').model('comp1');
model.func('step1').set('location', '2[mm]');
model.func('step1').set('from', 1);
model.func('step1').set('to', 0);
model.func('step1').set('smooth', '1e-5');

model.variable.create('var1');
model.variable('var1').model('comp1');
model.variable('var1').set('r', 'sqrt(y^2+z^2)');
model.variable('var1').descr('r', 'Radial distance from x-axis');

model.cpl.create('aveop1', 'Average', 'geom1');
model.cpl('aveop1').set('axisym', true);
model.cpl('aveop1').selection.geom('geom1', 1);
model.cpl('aveop1').selection.set([28]);
model.cpl('aveop1').set('frame', 'material');

model.func.create('pw1', 'Piecewise');
model.func('pw1').model('comp1');
model.func('pw1').set('funcname', 'r0');
model.func('pw1').set('arg', 't');
model.func('pw1').setIndex('pieces', 0, 0, 0);
model.func('pw1').setIndex('pieces', 1, 0, 1);
model.func('pw1').setIndex('pieces', '(2e-3-7.1e-4)*t+7.1e-4', 0, 2);
model.func('pw1').setIndex('pieces', 1, 1, 0);
model.func('pw1').setIndex('pieces', 2, 1, 1);
model.func('pw1').setIndex('pieces', '(2e-3-7.1e-4)*(1-t)+2e-3', 1, 2);
model.func('pw1').set('argunit', 's');
model.func('pw1').set('fununit', 'm');

model.physics('solid').create('sym1', 'SymmetrySolid', 2);
model.physics('solid').feature('sym1').selection.set([5 12 18 24 30 31]);
model.physics('solid').create('bndl1', 'BoundaryLoad', 2);
model.physics('solid').feature('bndl1').selection.set([4]);
model.physics('solid').feature('bndl1').set('LoadType', 'FollowerPressure');
model.physics('solid').feature('bndl1').set('FollowerPressure', 'p*step1(r)');
model.physics('solid').create('ge1', 'GlobalEquations', -1);
model.physics('solid').feature('ge1').setIndex('name', 'p', 0, 0);
model.physics('solid').feature('ge1').setIndex('equation', 'aveop1(r)-r0(t)', 0, 0);
model.physics('solid').feature('ge1').setIndex('description', 'Pressure', 0, 0);
model.physics('solid').feature('ge1').set('DependentVariableQuantity', 'pressure');
model.physics('solid').feature('ge1').set('SourceTermQuantity', 'length');

model.mesh('mesh1').create('ftri1', 'FreeTri');
model.mesh('mesh1').feature('ftri1').selection.set([3]);
model.mesh('mesh1').feature('ftri1').create('size1', 'Size');
model.mesh('mesh1').feature('ftri1').feature('size1').set('custom', true);
model.mesh('mesh1').feature('ftri1').feature('size1').set('hmaxactive', true);
model.mesh('mesh1').feature('ftri1').feature('size1').set('hmax', '4.5e-5');
model.mesh('mesh1').feature('ftri1').feature('size1').set('hminactive', true);
model.mesh('mesh1').feature('ftri1').feature('size1').set('hmin', '4e-6');
model.mesh('mesh1').feature('ftri1').feature('size1').set('hgradactive', true);
model.mesh('mesh1').feature('ftri1').feature('size1').set('hgrad', 1.4);
model.mesh('mesh1').feature('ftri1').feature('size1').set('hcurveactive', true);
model.mesh('mesh1').feature('ftri1').feature('size1').set('hcurve', 0.3);
model.mesh('mesh1').create('swe1', 'Sweep');
model.mesh('mesh1').feature('swe1').create('dis1', 'Distribution');
model.mesh('mesh1').feature('swe1').feature('dis1').set('numelem', 2);
model.mesh('mesh1').run;

model.cpl.create('intop1', 'Integration', 'geom1');
model.cpl('intop1').set('axisym', true);
model.cpl('intop1').selection.geom('geom1', 0);
model.cpl('intop1').selection.set([57]);
model.cpl('intop1').set('opname', 'central');
model.cpl('intop1').set('frame', 'material');
model.cpl.create('intop2', 'Integration', 'geom1');
model.cpl('intop2').set('axisym', true);
model.cpl('intop2').selection.geom('geom1', 0);
model.cpl('intop2').selection.set([3]);
model.cpl('intop2').set('opname', 'distal');
model.cpl('intop2').set('frame', 'material');

model.variable('var1').set('dogboning', '(distal(r)-central(r))/distal(r)');
model.variable('var1').descr('dogboning', 'Dogboning');
model.variable('var1').set('length', '2*abs(distal(x)-central(x))');
model.variable('var1').descr('length', 'Length of the deformed stent');
model.variable('var1').set('L0', '2*abs(distal(X)-central(X))');
model.variable('var1').descr('L0', 'Length of the undeformed stent');
model.variable('var1').set('foreshortening', '(length-L0)/length');
model.variable('var1').descr('foreshortening', 'Foreshortening');

model.param.set('t', '0[s]');
model.param.descr('t', 'Time');

model.study('std1').feature('stat').set('useparam', true);
model.study('std1').feature('stat').setIndex('pname', 't', 0);
model.study('std1').feature('stat').setIndex('plistarr', '', 0);
model.study('std1').feature('stat').setIndex('punit', 'm', 0);
model.study('std1').feature('stat').setIndex('pname', 't', 0);
model.study('std1').feature('stat').setIndex('plistarr', '', 0);
model.study('std1').feature('stat').setIndex('punit', 'm', 0);
model.study('std1').feature('stat').setIndex('plistarr', 'range(0,1e-2,1.5)', 0);
model.study('std1').feature('stat').setIndex('punit', 's', 0);

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
model.sol('sol1').feature('s1').feature('p1').set('porder', 'constant');
model.sol('sol1').feature('s1').feature('p1').set('control', 'stat');
model.sol('sol1').feature('s1').set('control', 'stat');
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
model.sol('sol1').feature('s1').feature('i1').set('rhob', 40);
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
model.sol('sol1').feature('v1').feature('comp1_ODE1').set('scalemethod', 'manual');
model.sol('sol1').feature('v1').feature('comp1_ODE1').set('scaleval', '1e6');
model.sol('sol1').feature('s1').feature('p1').create('st1', 'StopCondition');
model.sol('sol1').feature('s1').feature('p1').feature('st1').setIndex('stopcondarr', '', 0);
model.sol('sol1').feature('s1').feature('p1').feature('st1').setIndex('stopcondterminateon', 'true', 0);
model.sol('sol1').feature('s1').feature('p1').feature('st1').setIndex('stopcondActive', true, 0);
model.sol('sol1').feature('s1').feature('p1').feature('st1').setIndex('stopconddesc', 'Stop expression 1', 0);
model.sol('sol1').feature('s1').feature('p1').feature('st1').setIndex('stopcondarr', '', 0);
model.sol('sol1').feature('s1').feature('p1').feature('st1').setIndex('stopcondterminateon', 'true', 0);
model.sol('sol1').feature('s1').feature('p1').feature('st1').setIndex('stopcondActive', true, 0);
model.sol('sol1').feature('s1').feature('p1').feature('st1').setIndex('stopconddesc', 'Stop expression 1', 0);
model.sol('sol1').feature('s1').feature('p1').feature('st1').setIndex('stopcondarr', 'comp1.p<0', 0);
model.sol('sol1').feature('s1').feature('p1').feature('st1').set('storestopcondsol', 'stepbefore');
model.sol('sol1').runAll;

model.result.create('pg1', 'PlotGroup3D');
model.result('pg1').set('data', 'dset1');
model.result('pg1').setIndex('looplevel', 103, 0);
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
model.result.create('pg2', 'PlotGroup3D');
model.result('pg2').set('data', 'dset1');
model.result('pg2').setIndex('looplevel', 103, 0);
model.result('pg2').label('Equivalent Plastic Strain (solid)');
model.result('pg2').set('defaultPlotID', 'equivalentPlasticStrain');
model.result('pg2').create('surf1', 'Surface');
model.result('pg2').feature('surf1').set('expr', {'solid.epeGp'});
model.result('pg2').feature('surf1').set('inheritplot', 'none');
model.result('pg2').feature('surf1').set('resolution', 'normal');
model.result('pg2').feature('surf1').set('colortabletype', 'discrete');
model.result('pg2').feature('surf1').set('bandcount', 11);
model.result('pg2').feature('surf1').set('colortable', 'AuroraAustralisDark');
model.result('pg2').feature('surf1').set('descractive', true);
model.result('pg2').feature('surf1').set('descr', 'Equivalent plastic strain');
model.result('pg2').label('Equivalent Plastic Strain (solid)');
model.result('pg2').run;
model.result('pg1').run;
model.result.dataset.create('mir1', 'Mirror3D');
model.result.dataset.create('mir2', 'Mirror3D');
model.result.dataset('mir2').set('data', 'mir1');
model.result.dataset('mir2').set('quickplane', 'zx');
model.result.dataset.create('sec1', 'Sector3D');
model.result.dataset('sec1').set('data', 'mir2');
model.result.dataset('sec1').setIndex('genpoints', 1, 1, 0);
model.result.dataset('sec1').setIndex('genpoints', 0, 1, 2);
model.result.dataset('sec1').set('sectors', 6);
model.result('pg1').run;
model.result('pg1').set('data', 'sec1');
model.result('pg1').set('edges', false);
model.result('pg1').run;
model.result('pg1').feature('vol1').set('unit', 'MPa');
model.result('pg1').run;
model.result('pg1').create('surf1', 'Surface');
model.result('pg1').feature('surf1').set('titletype', 'none');
model.result('pg1').feature('surf1').create('mtrl1', 'MaterialAppearance');
model.result('pg1').run;
model.result('pg1').run;

model.view('view2').set('showgrid', false);

model.result('pg1').run;
model.result('pg1').stepPrevious(0);
model.result('pg1').run;
model.result('pg1').stepPrevious(0);
model.result('pg1').run;
model.result('pg1').run;
model.result('pg2').run;
model.result('pg2').set('data', 'sec1');
model.result('pg2').set('edges', false);
model.result('pg2').run;
model.result('pg2').feature.duplicate('surf2', 'surf1');
model.result('pg2').run;
model.result('pg2').run;
model.result('pg2').feature('surf1').create('def1', 'Deform');
model.result('pg2').run;
model.result('pg2').feature('surf1').feature('def1').set('scaleactive', true);
model.result('pg2').feature('surf1').feature('def1').set('scale', 1);
model.result('pg2').run;
model.result('pg2').feature('surf2').set('titletype', 'none');
model.result('pg2').feature('surf2').create('mtrl1', 'MaterialAppearance');
model.result('pg2').run;
model.result('pg2').run;
model.result.create('pg3', 'PlotGroup1D');
model.result('pg3').run;
model.result('pg3').label('Dogboning and Foreshortening');
model.result('pg3').setIndex('looplevelinput', 'manual', 0);
model.result('pg3').setIndex('looplevel', [1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40 41 42 43 44 45 46 47 48 49 50 51 52 53 54 55 56 57 58 59 60 61 62 63 64 65 66 67 68 69 70 71 72 73 74 75 76 77 78 79 80 81 82 83 84 85 86 87 88 89 90 91 92 93 94 95 96 97 98 99 100 101], 0);
model.result('pg3').create('glob1', 'Global');
model.result('pg3').feature('glob1').set('markerpos', 'datapoints');
model.result('pg3').feature('glob1').set('linewidth', 'preference');
model.result('pg3').feature('glob1').set('expr', {'dogboning'});
model.result('pg3').feature('glob1').set('descr', {'Dogboning'});
model.result('pg3').feature('glob1').set('unit', {'1'});
model.result('pg3').feature('glob1').set('expr', {'dogboning' 'foreshortening'});
model.result('pg3').feature('glob1').set('descr', {'Dogboning' 'Foreshortening'});
model.result('pg3').feature('glob1').set('xdataexpr', 'p');
model.result('pg3').feature('glob1').set('xdatadescr', 'Pressure');
model.result('pg3').run;
model.result.evaluationGroup.create('eg1', 'EvaluationGroup');
model.result.evaluationGroup('eg1').label('Recoil Evaluation');
model.result.evaluationGroup('eg1').setIndex('looplevelinput', 'manual', 0);
model.result.evaluationGroup('eg1').setIndex('looplevel', [101], 0);
model.result.evaluationGroup('eg1').create('gev1', 'EvalGlobal');
model.result.evaluationGroup('eg1').feature('gev1').setIndex('expr', '(length-with(103,length))/length', 0);
model.result.evaluationGroup('eg1').feature('gev1').setIndex('descr', 'Longitudinal recoil', 0);
model.result.evaluationGroup('eg1').feature('gev1').setIndex('expr', '(distal(r)-with(103,distal(r)))/distal(r)', 1);
model.result.evaluationGroup('eg1').feature('gev1').setIndex('descr', 'Distal radial recoil', 1);
model.result.evaluationGroup('eg1').feature('gev1').setIndex('expr', '(central(r)-with(103,central(r)))/central(r)', 2);
model.result.evaluationGroup('eg1').feature('gev1').setIndex('descr', 'Central radial recoil', 2);
model.result.evaluationGroup('eg1').run;
model.result.create('pg4', 'PlotGroup3D');
model.result('pg4').run;
model.result('pg4').label('Full Geometry and Mesh');
model.result('pg4').set('titletype', 'none');
model.result('pg4').create('surf1', 'Surface');
model.result('pg4').feature('surf1').set('data', 'sec1');
model.result('pg4').feature('surf1').create('mtrl1', 'MaterialAppearance');
model.result('pg4').run;
model.result('pg4').run;
model.result('pg4').create('mesh1', 'Mesh');
model.result('pg4').feature('mesh1').set('colortable', 'TrafficFlow');
model.result('pg4').feature('mesh1').set('colortabletrans', 'nonlinear');
model.result('pg4').feature('mesh1').set('nonlinearcolortablerev', true);
model.result('pg4').feature('mesh1').set('elemcolor', 'none');
model.result('pg4').run;
model.result('pg1').run;

model.title('Plastic Deformation During the Expansion of a Biomedical Stent');

model.description('A stent is a wire-mesh tube used to open a coronary artery during angioplasty, a process for the removal or compression of plaque. The expanded stent acts as a scaffold that keeps the blood vessel open. During this procedure, damage can be inflicted on the artery by both the nonuniform expansion of the stent, as well as by its foreshortening. This example studies the deformation of a stent subjected to a radial outward pressure using an elastoplastic material model with linear hardening.');

model.mesh.clearMeshes;

model.sol('sol1').clearSolutionData;

model.label('biomedical_stent.mph');

model.modelNode.label('Components');

out = model;
