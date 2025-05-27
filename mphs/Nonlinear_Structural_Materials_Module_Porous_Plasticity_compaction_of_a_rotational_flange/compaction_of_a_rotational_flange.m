function out = model
%
% compaction_of_a_rotational_flange.m
%
% Model exported on May 26 2025, 21:31 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/Nonlinear_Structural_Materials_Module/Porous_Plasticity');

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

model.param.set('t', '0[s]');
model.param.descr('t', 'Time parameter');
model.param.set('mu', '0.08');
model.param.descr('mu', 'Coefficient of friction');
model.param.set('EE', '2000[MPa]');
model.param.descr('EE', 'Young''s modulus');
model.param.set('Nu', '0.37');
model.param.descr('Nu', 'Poisson''s ratio');
model.param.set('rhorel0', '0.4');
model.param.descr('rhorel0', 'Initial relative density');
model.param.set('F0', '1-rhorel0');
model.param.descr('F0', 'Initial void volume fraction');
model.param.set('Alpha', '0.25');
model.param.descr('Alpha', ['Drucker' native2unicode(hex2dec({'20' '13'}), 'unicode') 'Prager parameter']);
model.param.set('Kd', '25[MPa]');
model.param.descr('Kd', ['Drucker' native2unicode(hex2dec({'20' '13'}), 'unicode') 'Prager parameter']);
model.param.set('KIso', '100[MPa]');
model.param.descr('KIso', 'Isotropic hardening modulus');
model.param.set('Rc', '1.5');
model.param.descr('Rc', 'Ellipse aspect ratio');
model.param.set('Epvolmax', '0.525');
model.param.descr('Epvolmax', 'Maximum plastic volumetric strain');
model.param.set('pc0', '10[MPa]');
model.param.descr('pc0', 'Initial location of the hardening cap');
model.param.set('Rho', '7540[kg/m^3]');
model.param.descr('Rho', 'Final density of the component');

model.func.create('int1', 'Interpolation');
model.func('int1').model('comp1');
model.func('int1').label('Density in Isotropic Compression Test - Experiment');
model.func('int1').set('table', {'5.124106267500724E-12' '3670.0000000001496';  ...
'25.000000000177725' '4400.000000004407';  ...
'50.000071675036544' '5020.000974780497';  ...
'100.00000050752321' '5700.0000050752315';  ...
'150.0000014714994' '6200.000008828997';  ...
'225.00029352164609' '6600.001174086585';  ...
'300.105942248634' '6843.159834996097';  ...
'350.0000136844657' '6975.000034211164';  ...
'400.000356338005' '7040.000356338005';  ...
'425.00000048100975' '7050';  ...
'450.0000005185946' '7050'});
model.func.create('int2', 'Interpolation');
model.func('int2').model('comp1');
model.func('int2').label('Density in Isotropic Compression Test - Simulation');
model.func('int2').set('table', {'5.124106267500724E-12' '3687.059999999992';  ...
'25.000000000177725' '3974.1084329750547';  ...
'50.000071675036544' '4431.503303302606';  ...
'100.00000050752321' '5228.128227218859';  ...
'150.0000014714994' '5835.661575004491';  ...
'225.00029352164609' '6422.15272999815';  ...
'300.105942248634' '6734.565382659871';  ...
'350.0000136844657' '6850.267965173319';  ...
'400.000356338005' '6922.265116971169';  ...
'425.00000048100975' '6947.1027786016475';  ...
'450.0000005185946' '6966.549748925553'});
model.func.create('int3', 'Interpolation');
model.func('int3').model('comp1');
model.func('int3').label('Density in Triaxial Test - Experiment');
model.func('int3').set('table', {'-1.3829733361420127E-6' '5020';  ...
'0.027116839330413686' '5150.160828785985';  ...
'0.0549910071294019' '5283.95683422113';  ...
'0.08366447728146623' '5421.589490951038';  ...
'0.11318444711415693' '5546.145564899549';  ...
'0.1436024218360274' '5652.608476426096';  ...
'0.1749747552943908' '5762.411643530368';  ...
'0.20736327833973794' '5868.408195849344';  ...
'0.24083603240028045' '5952.090081000701';  ...
'0.27546813014024074' '6038.670325350601';  ...
'0.3113427705720695' '6117.0141558581045'});
model.func.create('int4', 'Interpolation');
model.func('int4').model('comp1');
model.func('int4').label('Density in Triaxial Test - Simulation');
model.func('int4').set('table', {'-1.3829733359060903E-6' '4431.49700147342';  ...
'0.027116839330413797' '4583.905246243627';  ...
'0.05499100712940126' '4734.799565060082';  ...
'0.08366447728146764' '4882.19594525478';  ...
'0.11318444711415668' '5025.306224619485';  ...
'0.14360242183602698' '5163.631164584266';  ...
'0.17497475529439166' '5296.7840614102015';  ...
'0.20736327833974072' '5424.483626878131';  ...
'0.2408360324002824' '5546.620255022213';  ...
'0.2754681301402422' '5663.396736544421';  ...
'0.31134277057207016' '5775.579776639445'});
model.func.create('int5', 'Interpolation');
model.func('int5').model('comp1');
model.func('int5').label('Axial Stress in Triaxial Test - Experiment');
model.func('int5').set('table', {'-1.3829733361420127E-6' '50';  ...
'0.027116839330413686' '66.27010359824821';  ...
'0.0549910071294019' '82.99460427764114';  ...
'0.08366447728146623' '100.19868636887973';  ...
'0.11318444711415693' '116.59222355707846';  ...
'0.1436024218360274' '131.80121091801368';  ...
'0.1749747552943908' '147.4873776471954';  ...
'0.20736327833973794' '163.681639169869';  ...
'0.24083603240028045' '180.41801620014024';  ...
'0.27546813014024074' '197.73406507012035';  ...
'0.3113427705720695' '214.5371082288278'});
model.func.create('int6', 'Interpolation');
model.func('int6').model('comp1');
model.func('int6').label('Axial Stress in Triaxial Test - Simulation');
model.func('int6').set('table', {'-1.3829733361420127E-6' '49.999151397166806';  ...
'0.027116839330413686' '73.52170084471575';  ...
'0.0549910071294019' '93.9501364667563';  ...
'0.08366447728146623' '112.39063884164347';  ...
'0.11318444711415693' '129.32874412367102';  ...
'0.1436024218360274' '144.9835510422869';  ...
'0.1749747552943908' '159.42631245640177';  ...
'0.20736327833973794' '172.62775349404595';  ...
'0.24083603240028045' '184.47913012096106';  ...
'0.27546813014024074' '194.80602710956902';  ...
'0.3113427705720695' '203.39026848868602'});
model.func('int1').createPlot('pg1');

model.result('pg1').run;

model.func('int2').createPlot('pg2');

model.result('pg2').run;
model.result.remove('pg2');
model.result('pg1').run;
model.result('pg1').label('Density vs. Hydrostatic Pressure in Isotropic Compression Test');
model.result('pg1').set('titletype', 'none');
model.result('pg1').set('xlabelactive', true);
model.result('pg1').set('xlabel', 'Hydrostatic pressure (MPa)');
model.result('pg1').set('ylabel', 'Density (kg/m<sup>3</sup>)');
model.result('pg1').set('axislimits', true);
model.result('pg1').set('ymin', 3500);
model.result('pg1').set('ymax', 7500);
model.result('pg1').set('xmax', 500);
model.result('pg1').set('xmin', -50);
model.result('pg1').set('legendpos', 'upperleft');
model.result('pg1').run;
model.result('pg1').feature('plot1').set('legend', true);
model.result('pg1').feature('plot1').set('legendmethod', 'manual');
model.result('pg1').feature('plot1').setIndex('legends', 'Experiment', 0);
model.result('pg1').feature.duplicate('plot2', 'plot1');
model.result('pg1').run;
model.result('pg1').feature('plot2').set('data', 'int2_ds1');
model.result('pg1').feature('plot2').set('expr', 'comp1.int2(t)');
model.result('pg1').feature('plot2').set('pointdef', 'ptds2');
model.result('pg1').feature('plot2').setIndex('legends', 'Simulation', 0);
model.result('pg1').run;

model.func('int3').createPlot('pg2');

model.result('pg2').run;

model.func('int4').createPlot('pg3');

model.result('pg3').run;
model.result.remove('pg3');
model.result('pg2').run;
model.result('pg2').label('Density vs. Logarithmic Axial Strain in Triaxial Test');
model.result('pg2').set('titletype', 'none');
model.result('pg2').set('xlabelactive', true);
model.result('pg2').set('xlabel', 'Logarithmic axial strain (1)');
model.result('pg2').set('ylabel', 'Density (kg/m<sup>3</sup>)');
model.result('pg2').set('axislimits', true);
model.result('pg2').set('ymin', 4000);
model.result('pg2').set('ymax', 6500);
model.result('pg2').set('xmax', 0.35);
model.result('pg2').set('xmin', -0.02);
model.result('pg2').set('legendpos', 'upperleft');
model.result('pg2').run;
model.result('pg2').feature('plot1').set('legend', true);
model.result('pg2').feature('plot1').set('legendmethod', 'manual');
model.result('pg2').feature('plot1').setIndex('legends', 'Experiment', 0);
model.result('pg2').feature.duplicate('plot2', 'plot1');
model.result('pg2').run;
model.result('pg2').feature('plot2').set('data', 'int4_ds1');
model.result('pg2').feature('plot2').set('expr', 'comp1.int4(t)');
model.result('pg2').feature('plot2').set('pointdef', 'ptds4');
model.result('pg2').feature('plot2').setIndex('legends', 'Simulation', 0);
model.result('pg2').run;

model.func('int5').createPlot('pg3');

model.result('pg3').run;

model.func('int6').createPlot('pg4');

model.result('pg4').run;
model.result.remove('pg4');
model.result('pg3').run;
model.result('pg3').label('Axial Cauchy Stress vs. Logarithmic Axial Strain in Triaxial Test');
model.result('pg3').set('titletype', 'none');
model.result('pg3').set('xlabelactive', true);
model.result('pg3').set('xlabel', 'Logarithmic axial strain (1)');
model.result('pg3').set('ylabel', 'Axial Cauchy stress (MPa)');
model.result('pg3').set('axislimits', true);
model.result('pg3').set('ymin', 0);
model.result('pg3').set('ymax', 240);
model.result('pg3').set('xmax', 0.35);
model.result('pg3').set('xmin', -0.02);
model.result('pg3').set('legendpos', 'upperleft');
model.result('pg3').run;
model.result('pg3').feature('plot1').set('legend', true);
model.result('pg3').feature('plot1').set('legendmethod', 'manual');
model.result('pg3').feature('plot1').setIndex('legends', 'Experiment', 0);
model.result('pg3').feature.duplicate('plot2', 'plot1');
model.result('pg3').run;
model.result('pg3').feature('plot2').set('data', 'int6_ds1');
model.result('pg3').feature('plot2').set('expr', 'comp1.int6(t)');
model.result('pg3').feature('plot2').set('pointdef', 'ptds6');
model.result('pg3').feature('plot2').setIndex('legends', 'Simulation', 0);
model.result('pg3').run;

model.func.create('int7', 'Interpolation');
model.func('int7').model('comp1');
model.func('int7').label('Top Punch Displacement');
model.func('int7').set('funcname', 'disp1');
model.func('int7').setIndex('table', 0, 0, 0);
model.func('int7').setIndex('table', 0, 0, 1);
model.func('int7').setIndex('table', 10, 1, 0);
model.func('int7').setIndex('table', -6.06, 1, 1);
model.func('int7').setIndex('argunit', 's', 0);
model.func('int7').setIndex('fununit', 'mm', 0);
model.func.duplicate('int8', 'int7');
model.func('int8').label('Bottom Punch Displacement');
model.func('int8').set('funcname', 'disp2');
model.func('int8').setIndex('table', 7.7, 1, 1);

model.geom('geom1').create('r1', 'Rectangle');
model.geom('geom1').lengthUnit('mm');
model.geom('geom1').feature('r1').set('size', [6.3 25.4]);
model.geom('geom1').run('r1');
model.geom('geom1').feature.duplicate('r2', 'r1');
model.geom('geom1').feature('r2').set('size', [4.6 13.7]);
model.geom('geom1').feature('r2').set('pos', [6.3 0]);
model.geom('geom1').run('r2');
model.geom('geom1').feature.duplicate('r3', 'r2');
model.geom('geom1').feature('r3').set('size', [20.2 11.7]);
model.geom('geom1').feature('r3').set('pos', [6.3 13.7]);
model.geom('geom1').run('r3');
model.geom('geom1').create('uni1', 'Union');
model.geom('geom1').feature('uni1').selection('input').set({'r2' 'r3'});
model.geom('geom1').run('uni1');
model.geom('geom1').feature.duplicate('r4', 'r3');
model.geom('geom1').feature('r4').set('size', [15.6 13.7]);
model.geom('geom1').feature('r4').set('pos', [10.9 0]);
model.geom('geom1').run('r4');
model.geom('geom1').feature.duplicate('r5', 'r4');
model.geom('geom1').feature('r5').set('size', [6.3 25.4]);
model.geom('geom1').feature('r5').set('pos', [26.5 0]);
model.geom('geom1').run('r5');
model.geom('geom1').create('uni2', 'Union');
model.geom('geom1').feature('uni2').selection('input').set({'r4' 'r5'});
model.geom('geom1').feature('uni2').set('intbnd', false);
model.geom('geom1').run('uni2');
model.geom('geom1').nodeGroup.create('grp1');
model.geom('geom1').nodeGroup('grp1').placeAfter([]);
model.geom('geom1').nodeGroup('grp1').add('r1');
model.geom('geom1').nodeGroup('grp1').label('Internal Die');
model.geom('geom1').nodeGroup.create('grp2');
model.geom('geom1').nodeGroup('grp2').placeAfter([]);
model.geom('geom1').nodeGroup('grp2').add('r2');
model.geom('geom1').nodeGroup('grp2').add('r3');
model.geom('geom1').nodeGroup('grp2').add('uni1');
model.geom('geom1').nodeGroup('grp2').label('Compact');
model.geom('geom1').nodeGroup.create('grp3');
model.geom('geom1').nodeGroup('grp3').placeAfter([]);
model.geom('geom1').nodeGroup('grp3').add('r4');
model.geom('geom1').nodeGroup('grp3').add('r5');
model.geom('geom1').nodeGroup('grp3').add('uni2');
model.geom('geom1').nodeGroup('grp3').label('External Die');
model.geom('geom1').feature('fin').set('action', 'assembly');
model.geom('geom1').feature('fin').set('pairtype', 'contact');
model.geom('geom1').run('fin');
model.geom('geom1').create('mce1', 'MeshControlEdges');
model.geom('geom1').feature('mce1').selection('input').set('fin', 8);
model.geom('geom1').run('mce1');

model.pair('ap2').swap;

model.physics('solid').selection.set([2]);
model.physics('solid').prop('ShapeProperty').set('order_displacement', 1);
model.physics('solid').feature('lemm1').set('geometricNonlinearity', 'totalLagrangian');
model.physics('solid').feature('lemm1').set('strainDecomposition', 'multiplicative');
model.physics('solid').feature('lemm1').create('popl1', 'PorousPlasticity', 2);
model.physics('solid').feature('lemm1').feature('popl1').set('YieldFunction', 'DPC');
model.physics('solid').feature('lemm1').feature('popl1').set('HardeningModel', 'Exponential');
model.physics('solid').feature('lemm1').feature('popl1').set('pb0', 'pc0');
model.physics('solid').feature('dcnt1').set('ContactMethodCtrl', 'AugmentedLagrange');
model.physics('solid').feature('dcnt1').set('SolutionMethod', 'coupled');
model.physics('solid').feature('dcnt1').create('fric1', 'Friction', 1);
model.physics('solid').feature('dcnt1').feature('fric1').set('mu_fric', 'mu');
model.physics('solid').create('disp1', 'Displacement1', 1);
model.physics('solid').feature('disp1').selection.set([7]);
model.physics('solid').feature('disp1').setIndex('Direction', 'prescribed', 2);
model.physics('solid').feature('disp1').setIndex('U0', 'disp1(t)', 2);
model.physics('solid').create('disp2', 'Displacement1', 1);
model.physics('solid').feature('disp2').selection.set([6]);
model.physics('solid').feature('disp2').setIndex('Direction', 'prescribed', 2);
model.physics('solid').feature('disp2').setIndex('U0', 'disp2(t)', 2);

model.material.create('mat1', 'Common', 'comp1');
model.material('mat1').label('Iron Powder');
model.material('mat1').selection.set([2]);
model.material('mat1').propertyGroup.create('Enu', 'Young''s_modulus_and_Poisson''s_ratio');
model.material('mat1').propertyGroup('Enu').set('E', {'EE'});
model.material('mat1').propertyGroup('Enu').set('nu', {'Nu'});
model.material('mat1').propertyGroup('def').set('density', {'Rho'});
model.material('mat1').propertyGroup.create('PoroplasticModel', 'Poroplastic_material_model');
model.material('mat1').propertyGroup('PoroplasticModel').set('f0', {'F0'});
model.material('mat1').propertyGroup.create('DruckerPrager', 'Drucker_Prager_criterion');
model.material('mat1').propertyGroup('DruckerPrager').set('alphaDrucker', {'Alpha'});
model.material('mat1').propertyGroup('DruckerPrager').set('kDrucker', {'Kd'});
model.material('mat1').propertyGroup.create('MohrCoulomb', 'Mohr_Coulomb_criterion');
model.material('mat1').propertyGroup('MohrCoulomb').set('Kiso', {'KIso'});
model.material('mat1').propertyGroup('MohrCoulomb').set('epvolmax', {'Epvolmax'});
model.material('mat1').propertyGroup('MohrCoulomb').set('Rcap', {'Rc'});

model.mesh('mesh1').create('map1', 'Map');
model.mesh('mesh1').feature('map1').selection.geom('geom1', 2);
model.mesh('mesh1').feature('map1').selection.set([2]);
model.mesh('mesh1').feature('map1').set('smoothcontrol', false);
model.mesh('mesh1').feature('map1').set('adjustedgdistr', true);
model.mesh('mesh1').feature('map1').create('dis1', 'Distribution');
model.mesh('mesh1').feature('map1').feature('dis1').selection.set([6 19]);
model.mesh('mesh1').feature('map1').feature('dis1').set('numelem', 4);
model.mesh('mesh1').feature('map1').create('dis2', 'Distribution');
model.mesh('mesh1').feature('map1').feature('dis2').selection.set([5]);
model.mesh('mesh1').feature('map1').feature('dis2').set('numelem', 20);
model.mesh('mesh1').create('map2', 'Map');
model.mesh('mesh1').feature('map2').selection.geom('geom1', 2);
model.mesh('mesh1').feature('map2').selection.set([4]);
model.mesh('mesh1').feature('map2').set('smoothcontrol', false);
model.mesh('mesh1').feature('map2').set('adjustedgdistr', true);
model.mesh('mesh1').feature('map2').create('dis1', 'Distribution');
model.mesh('mesh1').feature('map2').feature('dis1').selection.set([7 18]);
model.mesh('mesh1').feature('map2').feature('dis1').set('numelem', 20);
model.mesh('mesh1').feature('map2').create('dis2', 'Distribution');
model.mesh('mesh1').feature('map2').feature('dis2').selection.set([13]);
model.mesh('mesh1').feature('map2').feature('dis2').set('numelem', 16);
model.mesh('mesh1').feature('size').set('hauto', 7);
model.mesh('mesh1').create('fq1', 'FreeQuad');
model.mesh('mesh1').run;

model.study('std1').feature('stat').set('useparam', true);
model.study('std1').feature('stat').setIndex('pname', 't', 0);
model.study('std1').feature('stat').setIndex('plistarr', '', 0);
model.study('std1').feature('stat').setIndex('punit', 'm', 0);
model.study('std1').feature('stat').setIndex('pname', 't', 0);
model.study('std1').feature('stat').setIndex('plistarr', '', 0);
model.study('std1').feature('stat').setIndex('punit', 'm', 0);
model.study('std1').feature('stat').setIndex('plistarr', 'range(0,0.1,10)', 0);
model.study('std1').feature('stat').setIndex('punit', 's', 0);

model.sol.create('sol1');
model.sol('sol1').study('std1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'stat');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').feature('comp1_solid_Tn_ap1').set('scalemethod', 'manual');
model.sol('sol1').feature('v1').feature('comp1_solid_Tn_ap2').set('scalemethod', 'manual');
model.sol('sol1').feature('v1').feature('comp1_solid_Tt_ap2').set('scalemethod', 'manual');
model.sol('sol1').feature('v1').feature('comp1_solid_Tt_ap1').set('scalemethod', 'manual');
model.sol('sol1').feature('v1').feature('comp1_u').set('scalemethod', 'manual');
model.sol('sol1').feature('v1').feature('comp1_solid_Tn_ap1').set('scaleval', '100000000');
model.sol('sol1').feature('v1').feature('comp1_solid_Tn_ap2').set('scaleval', '100000000');
model.sol('sol1').feature('v1').feature('comp1_solid_Tt_ap2').set('scaleval', '10000000');
model.sol('sol1').feature('v1').feature('comp1_solid_Tt_ap1').set('scaleval', '10000000');
model.sol('sol1').feature('v1').feature('comp1_u').set('scaleval', '1e-2*0.041484937025383084');
model.sol('sol1').feature('v1').set('control', 'stat');
model.sol('sol1').create('s1', 'Stationary');
model.sol('sol1').feature('s1').create('p1', 'Parametric');
model.sol('sol1').feature('s1').feature.remove('pDef');
model.sol('sol1').feature('s1').feature('p1').set('porder', 'constant');
model.sol('sol1').feature('s1').feature('p1').set('control', 'stat');
model.sol('sol1').feature('s1').set('control', 'stat');
model.sol('sol1').feature('s1').feature('aDef').set('cachepattern', true);
model.sol('sol1').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('s1').feature('fc1').set('dtech', 'ddog');
model.sol('sol1').feature('s1').feature('fc1').set('linsolver', 'dDef');
model.sol('sol1').feature('s1').feature('fc1').set('dtech', 'ddog');
model.sol('sol1').feature('s1').feature.remove('fcDef');
model.sol('sol1').attach('std1');
model.sol('sol1').feature('s1').feature('p1').set('paramtuning', true);
model.sol('sol1').feature('s1').feature('p1').set('pminstep', '0.0005');
model.sol('sol1').feature('s1').feature('p1').set('porder', 'linear');
model.sol('sol1').feature('s1').feature('fc1').set('dtech', 'const');
model.sol('sol1').feature('s1').feature('fc1').set('stabacc', 'aacc');
model.sol('sol1').runAll;

model.result.create('pg4', 'PlotGroup2D');
model.result('pg4').set('data', 'dset1');
model.result('pg4').setIndex('looplevel', 101, 0);
model.result('pg4').set('defaultPlotID', 'stress');
model.result('pg4').label('Stress (solid)');
model.result('pg4').set('frametype', 'spatial');
model.result('pg4').create('surf1', 'Surface');
model.result('pg4').feature('surf1').set('expr', {'solid.misesGp'});
model.result('pg4').feature('surf1').set('threshold', 'manual');
model.result('pg4').feature('surf1').set('thresholdvalue', 0.2);
model.result('pg4').feature('surf1').set('colortable', 'Rainbow');
model.result('pg4').feature('surf1').set('colortabletrans', 'none');
model.result('pg4').feature('surf1').set('colorscalemode', 'linear');
model.result('pg4').feature('surf1').set('resolution', 'normal');
model.result('pg4').feature('surf1').set('colortable', 'Prism');
model.result('pg4').feature('surf1').create('def', 'Deform');
model.result('pg4').feature('surf1').feature('def').set('scaleactive', true);
model.result('pg4').feature('surf1').feature('def').set('scale', '1');
model.result('pg4').feature('surf1').feature('def').set('expr', {'u' 'w'});
model.result('pg4').feature('surf1').feature('def').set('descr', 'Displacement field');
model.result.dataset.create('dset1solidrev', 'Revolve2D');
model.result.dataset('dset1solidrev').set('data', 'dset1');
model.result.dataset('dset1solidrev').set('revangle', 225);
model.result.dataset('dset1solidrev').set('startangle', -90);
model.result.dataset('dset1solidrev').set('hasspacevars', true);
model.result.create('pg5', 'PlotGroup3D');
model.result('pg5').set('data', 'dset1solidrev');
model.result('pg5').setIndex('looplevel', 101, 0);
model.result('pg5').set('defaultPlotID', 'stress3D');
model.result('pg5').label('Stress, 3D (solid)');
model.result('pg5').set('frametype', 'spatial');
model.result('pg5').create('surf1', 'Surface');
model.result('pg5').feature('surf1').set('expr', {'solid.misesGp'});
model.result('pg5').feature('surf1').set('threshold', 'manual');
model.result('pg5').feature('surf1').set('thresholdvalue', 0.2);
model.result('pg5').feature('surf1').set('colortable', 'Rainbow');
model.result('pg5').feature('surf1').set('colortabletrans', 'none');
model.result('pg5').feature('surf1').set('colorscalemode', 'linear');
model.result('pg5').feature('surf1').set('colortable', 'Prism');
model.result('pg5').feature('surf1').create('def', 'Deform');
model.result.dataset('dset1solidrev').set('hasspacevars', true);
model.result('pg5').feature('surf1').feature('def').set('revcoordsys', 'cylindrical');
model.result('pg5').feature('surf1').feature('def').set('expr', {'u' 'v' 'w'});
model.result('pg5').feature('surf1').feature('def').set('descr', 'Displacement field');
model.result('pg5').feature('surf1').feature('def').set('descractive', true);
model.result('pg5').feature('surf1').feature('def').set('scaleactive', true);
model.result('pg5').feature('surf1').feature('def').set('scale', '1');
model.result('pg4').run;
model.result.create('pg6', 'PlotGroup2D');
model.result('pg6').set('data', 'dset1');
model.result('pg6').setIndex('looplevel', 101, 0);
model.result('pg6').label('Volumetric Plastic Strain (solid)');
model.result('pg6').set('defaultPlotID', 'volumetricPlasticStrain');
model.result('pg6').create('surf1', 'Surface');
model.result('pg6').feature('surf1').set('expr', {'solid.epvolGp'});
model.result('pg6').feature('surf1').set('inheritplot', 'none');
model.result('pg6').feature('surf1').set('resolution', 'normal');
model.result('pg6').feature('surf1').set('colortabletype', 'discrete');
model.result('pg6').feature('surf1').set('bandcount', 11);
model.result('pg6').feature('surf1').set('colortable', 'AuroraAustralisDark');
model.result('pg6').feature('surf1').set('descractive', true);
model.result('pg6').feature('surf1').set('descr', 'Volumetric plastic strain');
model.result('pg6').label('Volumetric Plastic Strain (solid)');
model.result.create('pg7', 'PlotGroup2D');
model.result('pg7').set('data', 'dset1');
model.result('pg7').setIndex('looplevel', 101, 0);
model.result('pg7').label('Current Void Volume Fraction (solid)');
model.result('pg7').set('defaultPlotID', 'voidVolumeFraction');
model.result('pg7').create('surf1', 'Surface');
model.result('pg7').feature('surf1').set('expr', {'solid.fGp'});
model.result('pg7').feature('surf1').create('def', 'Deform');
model.result('pg7').feature('surf1').feature('def').set('scaleactive', true);
model.result('pg7').feature('surf1').feature('def').set('scale', '1');
model.result('pg7').feature('surf1').feature('def').set('expr', {'u' 'w'});
model.result('pg7').feature('surf1').feature('def').set('descr', 'Displacement field');
model.result('pg7').feature('surf1').set('resolution', 'normal');
model.result('pg7').feature('surf1').set('colortabletype', 'discrete');
model.result('pg7').feature('surf1').set('bandcount', 11);
model.result('pg7').feature('surf1').set('colortable', 'Traffic');
model.result('pg7').feature('surf1').set('descractive', true);
model.result('pg7').feature('surf1').set('descr', 'Current void volume fraction');
model.result('pg7').label('Current Void Volume Fraction (solid)');
model.result('pg7').run;
model.result.dataset('dset1').selection.geom('geom1', 2);
model.result.dataset('dset1').selection.geom('geom1', 2);
model.result.dataset('dset1').selection.set([2]);
model.result.dataset.duplicate('dset2', 'dset1');
model.result.dataset('dset2').selection.geom('geom1', 2);
model.result.dataset('dset2').selection.set([]);
model.result.dataset('dset2').selection.geom('geom1', 2);
model.result.dataset('dset2').selection.set([1 3]);
model.result.dataset.duplicate('dset1solidrev1', 'dset1solidrev');
model.result.dataset('dset1solidrev1').set('data', 'dset2');
model.result('pg5').run;
model.result('pg5').set('edges', false);
model.result('pg5').create('surf2', 'Surface');
model.result('pg5').feature('surf2').set('data', 'dset1solidrev1');
model.result('pg5').feature('surf2').set('expr', '0');
model.result('pg5').feature('surf2').set('titletype', 'none');
model.result('pg5').feature('surf2').create('mtrl1', 'MaterialAppearance');
model.result('pg5').run;
model.result('pg5').feature('surf2').feature('mtrl1').set('appearance', 'custom');
model.result('pg5').feature('surf2').feature('mtrl1').set('family', 'steel');
model.result('pg5').run;

model.view('view2').set('showgrid', false);

model.result('pg6').run;
model.result('pg6').set('legendactive', true);
model.result('pg6').set('legendprecision', 4);
model.result('pg6').run;
model.result('pg6').feature('surf1').set('bandcount', 6);
model.result('pg6').feature('surf1').create('def1', 'Deform');
model.result('pg6').run;
model.result('pg6').feature('surf1').feature('def1').set('scaleactive', true);
model.result('pg6').feature('surf1').feature('def1').set('scale', 1);
model.result('pg6').run;
model.result('pg7').run;
model.result('pg7').label('Current Relative Density at Middle of Compaction');
model.result('pg7').setIndex('looplevel', 51, 0);
model.result('pg7').run;
model.result('pg7').feature('surf1').set('expr', 'solid.rhorelGp');
model.result('pg7').feature('surf1').set('descractive', false);
model.result('pg7').feature('surf1').set('colortabletrans', 'reverse');
model.result('pg7').run;
model.result('pg7').run;
model.result.duplicate('pg8', 'pg7');
model.result('pg8').run;
model.result('pg8').label('Current Relative Density at End of Compaction');
model.result('pg8').setIndex('looplevel', 101, 0);
model.result('pg8').run;
model.result('pg5').run;
model.result.duplicate('pg9', 'pg5');
model.result('pg9').run;
model.result('pg9').setIndex('looplevel', 1, 0);
model.result('pg9').set('showlegends', false);
model.result('pg9').set('titletype', 'none');
model.result('pg9').run;
model.result('pg9').feature('surf1').create('mtrl1', 'MaterialAppearance');
model.result('pg9').run;
model.result('pg9').feature('surf1').feature('mtrl1').set('appearance', 'custom');
model.result('pg9').feature('surf1').feature('mtrl1').set('family', 'iron');
model.result('pg9').run;
model.result('pg9').run;
model.result.remove('pg9');
model.result('pg5').run;

model.title('Powder Compaction of a Rotational Flanged Component');

model.description(['The powder compaction process is becoming common in the manufacturing industry, thanks to its potential to produce components of complex shape and high strength. In this example, the compaction of iron powder to form an axisymmetric rotational flanged component is analyzed with Capped Drucker' native2unicode(hex2dec({'20' '13'}), 'unicode') 'Prager plastic model. The friction between the metal powder and die is taken into account.']);

model.mesh.clearMeshes;

model.sol('sol1').clearSolutionData;

model.label('compaction_of_a_rotational_flange.mph');

model.modelNode.label('Components');

out = model;
