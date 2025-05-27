function out = model
%
% flywheel_profile.m
%
% Model exported on May 26 2025, 21:31 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/Optimization_Module/Shape_Optimization');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 2);
model.geom('geom1').model('comp1');
model.geom('geom1').axisymmetric(true);

model.mesh.create('mesh1', 'geom1');

model.physics.create('solid', 'SolidMechanics', 'geom1');
model.physics('solid').model('comp1');

model.study.create('std1');
model.study('std1').create('stat', 'Stationary');
model.study('std1').feature('stat').setSolveFor('/physics/solid', true);

model.param.set('r0', '1[cm]');
model.param.descr('r0', 'Inner flywheel radius');
model.param.set('r1', '60[cm]');
model.param.descr('r1', 'Outer flywheel radius');
model.param.set('H0', '3[cm]');
model.param.descr('H0', 'Initial flywheel thickness');
model.param.set('omega', '2*pi*50[rad/s]');
model.param.descr('omega', 'Angular velocity');
model.param.set('pExp', '10');
model.param.descr('pExp', 'P-norm exponent');

model.geom('geom1').create('r1', 'Rectangle');
model.geom('geom1').feature('r1').set('size', {'r1-r0' 'H0'});
model.geom('geom1').feature('r1').set('pos', {'r0' '0'});
model.geom('geom1').run;

model.material.create('mat1', 'Common', 'comp1');
model.material('mat1').propertyGroup.create('Enu', 'Young''s modulus and Poisson''s ratio');
model.material('mat1').propertyGroup('Enu').func.create('int1', 'Interpolation');
model.material('mat1').propertyGroup('Enu').func.create('int2', 'Interpolation');
model.material('mat1').propertyGroup.create('Murnaghan', 'Murnaghan');
model.material('mat1').propertyGroup.create('ElastoplasticModel', 'Elastoplastic material model');
model.material('mat1').propertyGroup('ElastoplasticModel').func.create('int1', 'Interpolation');
model.material('mat1').propertyGroup.create('Ludwik', 'Ludwik');
model.material('mat1').propertyGroup('Ludwik').func.create('int1', 'Interpolation');
model.material('mat1').propertyGroup.create('JohnsonCook', 'Johnson-Cook');
model.material('mat1').propertyGroup.create('Swift', 'Swift');
model.material('mat1').propertyGroup.create('Voce', 'Voce');
model.material('mat1').propertyGroup('Voce').func.create('int1', 'Interpolation');
model.material('mat1').propertyGroup.create('HockettSherby', 'Hockett-Sherby');
model.material('mat1').propertyGroup('HockettSherby').func.create('int1', 'Interpolation');
model.material('mat1').propertyGroup.create('ArmstrongFrederick', 'Armstrong-Frederick');
model.material('mat1').propertyGroup('ArmstrongFrederick').func.create('int1', 'Interpolation');
model.material('mat1').propertyGroup.create('Norton', 'Norton');
model.material('mat1').propertyGroup.create('Garofalo', 'Garofalo (hyperbolic sine)');
model.material('mat1').propertyGroup.create('ChabocheViscoplasticity', 'Chaboche viscoplasticity');
model.material('mat1').label('Structural steel');
model.material('mat1').set('family', 'custom');
model.material('mat1').set('customspecular', [0.7843137254901961 0.7843137254901961 0.7843137254901961]);
model.material('mat1').set('customdiffuse', [0.6666666666666666 0.6666666666666666 0.6666666666666666]);
model.material('mat1').set('customambient', [0.6666666666666666 0.6666666666666666 0.6666666666666666]);
model.material('mat1').set('noise', true);
model.material('mat1').set('fresnel', 0.9);
model.material('mat1').set('roughness', 0.3);
model.material('mat1').set('metallic', 0);
model.material('mat1').set('pearl', 0);
model.material('mat1').set('diffusewrap', 0);
model.material('mat1').set('clearcoat', 0);
model.material('mat1').set('reflectance', 0);
model.material('mat1').propertyGroup('def').set('lossfactor', '0.02');
model.material('mat1').propertyGroup('def').set('relpermeability', {'1' '0' '0' '0' '1' '0' '0' '0' '1'});
model.material('mat1').propertyGroup('def').set('heatcapacity', '475[J/(kg*K)]');
model.material('mat1').propertyGroup('def').set('thermalconductivity', {'44.5[W/(m*K)]' '0' '0' '0' '44.5[W/(m*K)]' '0' '0' '0' '44.5[W/(m*K)]'});
model.material('mat1').propertyGroup('def').set('electricconductivity', {'4.032e6[S/m]' '0' '0' '0' '4.032e6[S/m]' '0' '0' '0' '4.032e6[S/m]'});
model.material('mat1').propertyGroup('def').set('relpermittivity', {'1' '0' '0' '0' '1' '0' '0' '0' '1'});
model.material('mat1').propertyGroup('def').set('thermalexpansioncoefficient', {'12.3e-6[1/K]' '0' '0' '0' '12.3e-6[1/K]' '0' '0' '0' '12.3e-6[1/K]'});
model.material('mat1').propertyGroup('def').set('density', '7850[kg/m^3]');
model.material('mat1').propertyGroup('Enu').func('int1').set('funcname', 'E');
model.material('mat1').propertyGroup('Enu').func('int1').set('table', {'293.15' '200e9'; '793.15' '166.6e9'});
model.material('mat1').propertyGroup('Enu').func('int1').set('extrap', 'linear');
model.material('mat1').propertyGroup('Enu').func('int1').set('fununit', {'Pa'});
model.material('mat1').propertyGroup('Enu').func('int1').set('argunit', {'K'});
model.material('mat1').propertyGroup('Enu').func('int2').set('funcname', 'nu');
model.material('mat1').propertyGroup('Enu').func('int2').set('table', {'293.15' '0.30'; '793.15' '0.315'});
model.material('mat1').propertyGroup('Enu').func('int2').set('extrap', 'linear');
model.material('mat1').propertyGroup('Enu').func('int2').set('fununit', {'1'});
model.material('mat1').propertyGroup('Enu').func('int2').set('argunit', {'K'});
model.material('mat1').propertyGroup('Enu').set('E', 'E(T)');
model.material('mat1').propertyGroup('Enu').set('nu', 'nu(T)');
model.material('mat1').propertyGroup('Enu').addInput('temperature');
model.material('mat1').propertyGroup('Murnaghan').set('l', '-3.0e11[Pa]');
model.material('mat1').propertyGroup('Murnaghan').set('m', '-6.2e11[Pa]');
model.material('mat1').propertyGroup('Murnaghan').set('n', '-7.2e11[Pa]');
model.material('mat1').propertyGroup('ElastoplasticModel').func('int1').set('funcname', 'a');
model.material('mat1').propertyGroup('ElastoplasticModel').func('int1').set('table', {'600' '1'; '1100' '0.1'; '1643' '0'});
model.material('mat1').propertyGroup('ElastoplasticModel').func('int1').set('fununit', {'1'});
model.material('mat1').propertyGroup('ElastoplasticModel').func('int1').set('argunit', {'K'});
model.material('mat1').propertyGroup('ElastoplasticModel').set('sigmags', '350[MPa]*a(T)');
model.material('mat1').propertyGroup('ElastoplasticModel').set('Et', '1.045[GPa]*a(T)');
model.material('mat1').propertyGroup('ElastoplasticModel').set('Ek', '1.045[GPa]*a(T)');
model.material('mat1').propertyGroup('ElastoplasticModel').set('sigmagh', '1.050[GPa]*epe*a(T)');
model.material('mat1').propertyGroup('ElastoplasticModel').addInput('temperature');
model.material('mat1').propertyGroup('ElastoplasticModel').addInput('effectiveplasticstrain');
model.material('mat1').propertyGroup('Ludwik').func('int1').set('funcname', 'a');
model.material('mat1').propertyGroup('Ludwik').func('int1').set('table', {'600' '1'; '1100' '0.1'; '1643' '0'});
model.material('mat1').propertyGroup('Ludwik').func('int1').set('fununit', {'1'});
model.material('mat1').propertyGroup('Ludwik').func('int1').set('argunit', {'K'});
model.material('mat1').propertyGroup('Ludwik').set('k_lud', '560[MPa]*a(T)');
model.material('mat1').propertyGroup('Ludwik').set('n_lud', '0.61');
model.material('mat1').propertyGroup('Ludwik').addInput('temperature');
model.material('mat1').propertyGroup('JohnsonCook').set('k_jcook', '560[MPa]');
model.material('mat1').propertyGroup('JohnsonCook').set('n_jcook', '0.61');
model.material('mat1').propertyGroup('JohnsonCook').set('C_jcook', '0.12');
model.material('mat1').propertyGroup('JohnsonCook').set('epet0_jcook', '1[1/s]');
model.material('mat1').propertyGroup('JohnsonCook').set('m_jcook', '0.6');
model.material('mat1').propertyGroup('Swift').set('e0_swi', '0.021');
model.material('mat1').propertyGroup('Swift').set('n_swi', '0.2');
model.material('mat1').propertyGroup('Voce').func('int1').set('funcname', 'a');
model.material('mat1').propertyGroup('Voce').func('int1').set('table', {'600' '1'; '1100' '0.1'; '1643' '0'});
model.material('mat1').propertyGroup('Voce').func('int1').set('fununit', {'1'});
model.material('mat1').propertyGroup('Voce').func('int1').set('argunit', {'K'});
model.material('mat1').propertyGroup('Voce').set('sigma_voc', '249[MPa]*a(T)');
model.material('mat1').propertyGroup('Voce').set('beta_voc', '9.3');
model.material('mat1').propertyGroup('Voce').addInput('temperature');
model.material('mat1').propertyGroup('HockettSherby').func('int1').set('funcname', 'a');
model.material('mat1').propertyGroup('HockettSherby').func('int1').set('table', {'600' '1'; '1100' '0.1'; '1643' '0'});
model.material('mat1').propertyGroup('HockettSherby').func('int1').set('fununit', {'1'});
model.material('mat1').propertyGroup('HockettSherby').func('int1').set('argunit', {'K'});
model.material('mat1').propertyGroup('HockettSherby').set('sigma_hoc', '684[MPa]*a(T)');
model.material('mat1').propertyGroup('HockettSherby').set('m_hoc', '3.9');
model.material('mat1').propertyGroup('HockettSherby').set('n_hoc', '0.85');
model.material('mat1').propertyGroup('HockettSherby').addInput('temperature');
model.material('mat1').propertyGroup('ArmstrongFrederick').func('int1').set('funcname', 'a');
model.material('mat1').propertyGroup('ArmstrongFrederick').func('int1').set('table', {'600' '1'; '1100' '0.1'; '1643' '0'});
model.material('mat1').propertyGroup('ArmstrongFrederick').func('int1').set('fununit', {'1'});
model.material('mat1').propertyGroup('ArmstrongFrederick').func('int1').set('argunit', {'K'});
model.material('mat1').propertyGroup('ArmstrongFrederick').set('Ck', '2.070[GPa]*a(T)');
model.material('mat1').propertyGroup('ArmstrongFrederick').set('gammak', '8.0');
model.material('mat1').propertyGroup('ArmstrongFrederick').addInput('temperature');
model.material('mat1').propertyGroup('Norton').set('A_nor', '1.2e-15[1/s]');
model.material('mat1').propertyGroup('Norton').set('sigRef_nor', '1[MPa]');
model.material('mat1').propertyGroup('Norton').set('n_nor', '4.5');
model.material('mat1').propertyGroup('Garofalo').set('A_gar', '1e-6[1/s]');
model.material('mat1').propertyGroup('Garofalo').set('sigRef_gar', '100[MPa]');
model.material('mat1').propertyGroup('Garofalo').set('n_gar', '4.6');
model.material('mat1').propertyGroup('ChabocheViscoplasticity').set('A_cha', '1');
model.material('mat1').propertyGroup('ChabocheViscoplasticity').set('sigRef_cha', '490[MPa]');
model.material('mat1').propertyGroup('ChabocheViscoplasticity').set('n_cha', '9');

model.physics('solid').create('rotf1', 'RotatingFrame', 2);
model.physics('solid').feature('rotf1').set('Ovm', 'omega');
model.physics('solid').create('symp1', 'SymmetryPlane', 1);
model.physics('solid').feature('symp1').selection.set([2]);

model.mesh('mesh1').create('map1', 'Map');
model.mesh('mesh1').feature('size').set('hauto', 1);

model.massProp.create('mass1', 'MassProperties');
model.massProp('mass1').model('comp1');
model.massProp('mass1').set('densitySource', 'fromPhysics');

model.cpl.create('aveop1', 'Average', 'geom1');
model.cpl('aveop1').set('axisym', true);
model.cpl('aveop1').selection.all;

model.study('std1').label('Initial Design');
model.study('std1').setGenPlots(false);

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
model.sol('sol1').feature('s1').feature('fc1').set('linsolver', 'dDef');
model.sol('sol1').feature('s1').feature('fc1').set('termonres', 'auto');
model.sol('sol1').feature('s1').feature('fc1').set('reserrfact', 1000);
model.sol('sol1').feature('s1').feature.remove('fcDef');
model.sol('sol1').attach('std1');
model.sol('sol1').runAll;

model.result.evaluationGroup.create('eg1', 'EvaluationGroup');
model.result.evaluationGroup('eg1').label('Initial Design');
model.result.evaluationGroup('eg1').create('gev1', 'EvalGlobal');
model.result.evaluationGroup('eg1').feature('gev1').label('Initial Constraints');
model.result.evaluationGroup('eg1').feature('gev1').setIndex('expr', 'aveop1(solid.mises^pExp)^(1/pExp)', 0);
model.result.evaluationGroup('eg1').feature('gev1').setIndex('unit', 'N/m^2', 0);
model.result.evaluationGroup('eg1').feature('gev1').setIndex('descr', 'Average 1', 0);
model.result.evaluationGroup('eg1').run;

model.param.set('sigma0', '96.2[MPa]');
model.param.descr('sigma0', 'Initial p-norm stress');

model.common.create('fsd1', 'FreeShapeDomain', 'comp1');
model.common('fsd1').selection.all;
model.common.create('fsr1', 'FreeShapeSymmetry', 'comp1');
model.common('fsr1').selection.set([1 4]);
model.common.create('fsb1', 'FreeShapeBoundary', 'comp1');
model.common('fsb1').selection.set([3]);
model.common('fsb1').set('maximumDisplacement', '2*H0/3');
model.common('fsb1').set('filterRadiusType', 'Small');

model.variable.create('var1');
model.variable('var1').model('comp1');
model.variable('var1').set('stress_Pnorm', 'aveop1((solid.mises/sigma0)^pExp)^(1/pExp)');
model.variable('var1').descr('stress_Pnorm', 'Scaled P-norm of von Mises stress');

model.study.create('std2');
model.study('std2').create('stat', 'Stationary');
model.study('std2').feature('stat').setSolveFor('/physics/solid', true);
model.study('std1').feature('stat').setEntry('activate', 'frame:material1', false);
model.study('std1').feature('stat').setEntry('activate', 'comp1:shape', false);
model.study('std2').label('Shape Optimization');

model.sol.create('sol2');

model.mesh('mesh1').stat.selection.geom(2);
model.mesh('mesh1').stat.selection.set([1]);

model.sol('sol2').study('std2');
model.sol('sol2').create('st1', 'StudyStep');
model.sol('sol2').feature('st1').set('study', 'std2');
model.sol('sol2').feature('st1').set('studystep', 'stat');
model.sol('sol2').create('v1', 'Variables');
model.sol('sol2').feature('v1').feature('comp1_fsb1_d').set('scalemethod', 'manual');
model.sol('sol2').feature('v1').feature('comp1_material_disp').set('scalemethod', 'manual');
model.sol('sol2').feature('v1').feature('comp1_fsb1_d').set('scaleval', '2*H0/3');
model.sol('sol2').feature('v1').feature('comp1_material_disp').set('scaleval', '0.012492197564880247');
model.sol('sol2').feature('v1').set('control', 'stat');
model.sol('sol2').create('s1', 'Stationary');
model.sol('sol2').feature('s1').feature('aDef').set('cachepattern', true);
model.sol('sol2').feature('s1').create('seDef', 'Segregated');
model.sol('sol2').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol2').feature('s1').feature('fc1').set('linsolver', 'dDef');
model.sol('sol2').feature('s1').feature.remove('fcDef');
model.sol('sol2').feature('s1').feature.remove('seDef');
model.sol('sol2').attach('std2');
model.sol('sol2').runFromTo('st1', 'v1');

model.result.create('pg1', 'PlotGroup2D');
model.result('pg1').set('data', 'dset2');
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
model.result('pg1').feature('surf1').feature('def').set('expr', {'u' 'w'});
model.result('pg1').feature('surf1').feature('def').set('descr', 'Displacement field');
model.result.dataset.create('dset2solidrev', 'Revolve2D');
model.result.dataset('dset2solidrev').set('data', 'dset2');
model.result.dataset('dset2solidrev').set('revangle', 225);
model.result.dataset('dset2solidrev').set('startangle', -90);
model.result.dataset('dset2solidrev').set('hasspacevars', true);
model.result.create('pg2', 'PlotGroup3D');
model.result('pg2').set('data', 'dset2solidrev');
model.result('pg2').set('defaultPlotID', 'stress3D');
model.result('pg2').label('Stress, 3D (solid)');
model.result('pg2').set('frametype', 'spatial');
model.result('pg2').create('surf1', 'Surface');
model.result('pg2').feature('surf1').set('expr', {'solid.misesGp'});
model.result('pg2').feature('surf1').set('threshold', 'manual');
model.result('pg2').feature('surf1').set('thresholdvalue', 0.2);
model.result('pg2').feature('surf1').set('colortable', 'Rainbow');
model.result('pg2').feature('surf1').set('colortabletrans', 'none');
model.result('pg2').feature('surf1').set('colorscalemode', 'linear');
model.result('pg2').feature('surf1').set('colortable', 'Prism');
model.result('pg2').feature('surf1').create('def', 'Deform');
model.result.dataset('dset2solidrev').set('hasspacevars', true);
model.result('pg2').feature('surf1').feature('def').set('revcoordsys', 'cylindrical');
model.result('pg2').feature('surf1').feature('def').set('expr', {'u' 'v' 'w'});
model.result('pg2').feature('surf1').feature('def').set('descr', 'Displacement field');
model.result('pg2').feature('surf1').feature('def').set('descractive', true);
model.result.create('pg3', 'PlotGroup2D');
model.result.dataset.duplicate('dset2g1', 'dset2');
model.result.dataset('dset2g1').label('Shape Optimization/Solution 2 (2) - Geometry');
model.result.dataset('dset2g1').set('frametype', 'geometry');
model.result('pg3').label('Shape Optimization');
model.result('pg3').set('data', 'dset2');
model.result('pg3').set('frametype', 'geometry');
model.result('pg3').set('edgecolor', 'gray');
model.result('pg3').set('titletype', 'none');
model.result('pg3').create('line1', 'Line');
model.result('pg3').feature('line1').set('expr', '1');
model.result('pg3').feature('line1').set('coloring', 'uniform');
model.result('pg3').feature('line1').set('color', 'fromtheme');
model.result('pg3').create('arwl1', 'ArrowLine');
model.result('pg3').feature('arwl1').set('data', 'dset2g1');
model.result('pg3').feature('arwl1').set('expr', {'fsd1.dRg' 'fsd1.dZg'});
model.result('pg3').feature('arwl1').set('scaleactive', true);
model.result('pg3').feature('arwl1').set('scale', '1');
model.result('pg3').feature('arwl1').set('placement', 'uniform');
model.result('pg3').feature('arwl1').set('arrowcount', 200);
model.result('pg3').feature('arwl1').create('col1', 'Color');
model.result('pg3').feature('arwl1').feature('col1').set('expr', 'fsd1.rel_disp');
model.result('pg3').feature('arwl1').feature('col1').set('rangecoloractive', 'on');
model.result('pg3').feature('arwl1').feature('col1').set('rangecolormin', 0);
model.result('pg3').feature('arwl1').feature('col1').set('rangecolormax', 1);
model.result('pg3').feature('arwl1').create('sel1', 'Selection');
model.result('pg3').feature('arwl1').feature('sel1').selection.named('dsel_fsd1');
model.result('pg1').run;
model.result('pg3').run;
model.result('pg3').run;
model.result('pg3').feature('arwl1').set('placement', 'elements');

model.study('std2').create('sho', 'ShapeOptimization');
model.study('std2').feature('sho').set('optsolver', 'ipopt');
model.study('std2').feature('sho').set('optobj', {'comp1.mass1.Ip1'});
model.study('std2').feature('sho').set('descr', {'First moment of inertia principal value'});
model.study('std2').feature('sho').set('constraintExpression', {'comp1.fsd1.relVolume' 'comp1.stress_Pnorm'});
model.study('std2').feature('sho').set('objectivescaling', 'init');
model.study('std2').feature('sho').set('objectivetype', 'maximization');
model.study('std2').feature('sho').setIndex('constraintExpression', 'comp1.fsd1.relVolume', 0);
model.study('std2').feature('sho').setIndex('constraintLbound', '', 0);
model.study('std2').feature('sho').setIndex('constraintUbound', '', 0);
model.study('std2').feature('sho').setIndex('constraintUbound', 1, 0);
model.study('std2').feature('sho').setIndex('constraintExpression', 'comp1.stress_Pnorm', 1);
model.study('std2').feature('sho').setIndex('constraintLbound', '', 1);
model.study('std2').feature('sho').setIndex('constraintUbound', '', 1);
model.study('std2').feature('sho').setIndex('constraintUbound', 1, 1);
model.study('std2').feature('sho').set('plot', true);
model.study('std2').feature('sho').set('plotgroup', 'pg3');

model.mesh('mesh1').stat.selection.geom(2);
model.mesh('mesh1').stat.selection.set([1]);

model.sol('sol2').study('std2');
model.sol('sol2').feature.remove('s1');
model.sol('sol2').feature.remove('v1');
model.sol('sol2').feature.remove('st1');
model.sol('sol2').create('st1', 'StudyStep');
model.sol('sol2').feature('st1').set('study', 'std2');
model.sol('sol2').feature('st1').set('studystep', 'stat');
model.sol('sol2').create('v1', 'Variables');
model.sol('sol2').feature('v1').feature('comp1_fsb1_d').set('scalemethod', 'manual');
model.sol('sol2').feature('v1').feature('comp1_material_disp').set('scalemethod', 'manual');
model.sol('sol2').feature('v1').feature('comp1_fsb1_d').set('scaleval', '2*H0/3');
model.sol('sol2').feature('v1').feature('comp1_material_disp').set('scaleval', '0.012492197564880247');
model.sol('sol2').feature('v1').set('control', 'stat');
model.sol('sol2').create('o1', 'Optimization');
model.sol('sol2').feature('o1').set('control', 'sho');
model.sol('sol2').feature('o1').create('s1', 'StationaryAttrib');
model.sol('sol2').feature('o1').feature('s1').set('control', 'stat');
model.sol('sol2').feature('o1').feature('s1').feature('aDef').set('cachepattern', true);
model.sol('sol2').feature('o1').feature('s1').create('seDef', 'Segregated');
model.sol('sol2').feature('o1').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol2').feature('o1').feature('s1').feature('fc1').set('linsolver', 'dDef');
model.sol('sol2').feature('o1').feature('s1').feature.remove('fcDef');
model.sol('sol2').feature('o1').feature('s1').feature.remove('seDef');
model.sol('sol2').attach('std2');
model.sol('sol2').runAll;

model.result('pg1').run;

model.study('std2').feature('sho').set('probewindow', '');

model.result.dataset.create('mir1', 'Mirror2D');
model.result.dataset('mir1').setIndex('genpoints', 1, 1, 0);
model.result.dataset('mir1').setIndex('genpoints', 0, 1, 1);
model.result.dataset('mir1').set('hasvar', true);
model.result.dataset.duplicate('mir2', 'mir1');
model.result.dataset('mir2').set('data', 'dset2');
model.result('pg1').run;
model.result('pg1').set('data', 'mir2');
model.result('pg1').set('titletype', 'manual');
model.result('pg1').set('title', 'Surface: von Mises stress, Initial Design (bottom) and Optimized (top)');
model.result('pg1').run;
model.result('pg1').feature.duplicate('surf2', 'surf1');
model.result('pg1').run;
model.result('pg1').run;
model.result('pg1').run;
model.result('pg1').feature('surf1').feature.remove('def');
model.result('pg1').run;
model.result('pg1').run;
model.result('pg1').feature('surf2').set('data', 'mir1');
model.result('pg1').feature('surf2').set('inheritplot', 'surf1');
model.result('pg1').run;
model.result('pg1').feature('surf2').feature('def').set('expr', {'0' 'if(mir1side,1,-1)*-3*H0'});
model.result('pg1').feature('surf2').feature('def').set('scaleactive', true);
model.result('pg1').feature('surf2').feature('def').set('scale', 1);
model.result('pg1').run;

model.title('Optimizing a Flywheel Profile');

model.description('This example solves the problem of finding the optimal thickness profile of a flywheel, so that the moment of inertia is maximized without increasing the mass or the maximum stress in the flywheel.');

model.label('flywheel_profile.mph');

model.modelNode.label('Components');

out = model;
