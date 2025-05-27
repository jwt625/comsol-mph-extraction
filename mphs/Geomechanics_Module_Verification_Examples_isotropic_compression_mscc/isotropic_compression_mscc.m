function out = model
%
% isotropic_compression_mscc.m
%
% Model exported on May 26 2025, 21:28 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/Geomechanics_Module/Verification_Examples');

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

model.param.label('Clay Material Properties');

% To import content from file, use:
% model.param.loadFile('FILENAME');
model.param.set('p0', '200[kPa]', 'Initial pressure');
model.param.set('GG', '3000[kPa]', 'Shear modulus');
model.param.set('Rho', '2000[kg/m^3]', 'Density');
model.param.set('MM', '1.15', 'Slope of critical state line');
model.param.set('lambdas', '0.147', 'Compression index of destructured soil');
model.param.set('kappas', '0.027', 'Swelling index of structured soil');
model.param.set('ee', '1.92', 'Void ratio at reference pressure');
model.param.set('deltae', '0.62', 'Additional void ratio');
model.param.set('zeta', '2', 'Plastic potential parameter');
model.param.set('dvs', '0.6', 'Destructuring index for volumetric deformation');
model.param.set('dss', '1', 'Destructuring index for shear deformation');
model.param.set('Pc0', '100[kPa]', 'Initial consolidation pressure');
model.param.set('Pbi', '30[kPa]', 'Initial structure strength');
model.param('default').paramCase.create('case1');
model.param('default').paramCase('case1').label('Natural Osaka Clay');
model.param('default').paramCase.create('case2');
model.param('default').paramCase('case2').set('p0', '800[kPa]');
model.param('default').paramCase('case2').set('GG', '45000[kPa]');
model.param('default').paramCase('case2').set('MM', '1.30');
model.param('default').paramCase('case2').set('lambdas', '0.025');
model.param('default').paramCase('case2').set('kappas', '0.009');
model.param('default').paramCase('case2').set('ee', '0.67');
model.param('default').paramCase('case2').set('deltae', '0.085');
model.param('default').paramCase('case2').set('zeta', '1.5');
model.param('default').paramCase('case2').set('dvs', '0.7');
model.param('default').paramCase('case2').set('Pc0', '4150[kPa]');
model.param('default').paramCase('case2').set('Pbi', '300[kPa]');
model.param('default').paramCase('case2').label('Natural Marl Clay');
model.param('default').paramCase.create('case3');
model.param('default').paramCase('case3').set('GG', '6000[kPa]');
model.param('default').paramCase('case3').set('MM', '1.60');
model.param('default').paramCase('case3').set('lambdas', '0.44');
model.param('default').paramCase('case3').set('kappas', '0.06');
model.param('default').paramCase('case3').set('ee', '4.37');
model.param('default').paramCase('case3').set('deltae', '1.50');
model.param('default').paramCase('case3').set('zeta', '1.8');
model.param('default').paramCase('case3').set('dvs', '0.15');
model.param('default').paramCase('case3').set('dss', '10');
model.param('default').paramCase('case3').set('Pc0', '50[kPa]');
model.param('default').paramCase('case3').set('Pbi', '50[kPa]');
model.param('default').paramCase('case3').label('Cemented Ariake Clay, Aw = 6%');
model.param('default').paramCase.create('case4');
model.param('default').paramCase('case4').set('p0', '300[kPa]');
model.param('default').paramCase('case4').set('GG', '8000[kPa]');
model.param('default').paramCase('case4').set('MM', '1.45');
model.param('default').paramCase('case4').set('lambdas', '0.44');
model.param('default').paramCase('case4').set('kappas', '0.024');
model.param('default').paramCase('case4').set('ee', '4.37');
model.param('default').paramCase('case4').set('deltae', '2.25');
model.param('default').paramCase('case4').set('zeta', '0.5');
model.param('default').paramCase('case4').set('dvs', '0.01');
model.param('default').paramCase('case4').set('dss', '10');
model.param('default').paramCase('case4').set('Pc0', '200[kPa]');
model.param('default').paramCase('case4').set('Pbi', '100[kPa]');
model.param('default').paramCase('case4').label('Cemented Ariake Clay, Aw = 9%');
model.param('default').paramCase.create('case5');
model.param('default').paramCase('case5').set('p0', '400[kPa]');
model.param('default').paramCase('case5').set('GG', '40000[kPa]');
model.param('default').paramCase('case5').set('MM', '1.35');
model.param('default').paramCase('case5').set('lambdas', '0.44');
model.param('default').paramCase('case5').set('kappas', '0.001');
model.param('default').paramCase('case5').set('ee', '4.37');
model.param('default').paramCase('case5').set('deltae', '2.65');
model.param('default').paramCase('case5').set('zeta', '0.1');
model.param('default').paramCase('case5').set('dvs', '0.001');
model.param('default').paramCase('case5').set('dss', '30');
model.param('default').paramCase('case5').set('Pc0', '1800[kPa]');
model.param('default').paramCase('case5').set('Pbi', '650[kPa]');
model.param('default').paramCase('case5').label('Cemented Ariake Clay, Aw = 18%');
model.param('default').paramCase.create('case6');
model.param('default').paramCase('case6').set('p0', '400[kPa]');
model.param('default').paramCase('case6').set('GG', '14000[kPa]');
model.param('default').paramCase('case6').set('MM', '1.13');
model.param('default').paramCase('case6').set('lambdas', '0.26');
model.param('default').paramCase('case6').set('kappas', '0.02');
model.param('default').paramCase('case6').set('ee', '2.86');
model.param('default').paramCase('case6').set('deltae', '0.55');
model.param('default').paramCase('case6').set('zeta', '1.5');
model.param('default').paramCase('case6').set('dvs', '0.02');
model.param('default').paramCase('case6').set('dss', '10');
model.param('default').paramCase('case6').set('Pc0', '150[kPa]');
model.param('default').paramCase('case6').set('Pbi', '60[kPa]');
model.param('default').paramCase('case6').label('Cemented Bangkok Clay, Aw = 5%');
model.param('default').paramCase.create('case7');
model.param('default').paramCase('case7').set('p0', '450[kPa]');
model.param('default').paramCase('case7').set('GG', '16000[kPa]');
model.param('default').paramCase('case7').set('MM', '1.13');
model.param('default').paramCase('case7').set('lambdas', '0.26');
model.param('default').paramCase('case7').set('kappas', '0.01');
model.param('default').paramCase('case7').set('ee', '2.86');
model.param('default').paramCase('case7').set('deltae', '0.60');
model.param('default').paramCase('case7').set('zeta', '0.2');
model.param('default').paramCase('case7').set('dvs', '0.01');
model.param('default').paramCase('case7').set('dss', '30');
model.param('default').paramCase('case7').set('Pc0', '430[kPa]');
model.param('default').paramCase('case7').set('Pbi', '400[kPa]');
model.param('default').paramCase('case7').label('Cemented Bangkok Clay, Aw = 10%');
model.param('default').paramCase.create('case8');
model.param('default').paramCase('case8').set('p0', '500[kPa]');
model.param('default').paramCase('case8').set('GG', '30000[kPa]');
model.param('default').paramCase('case8').set('MM', '1.13');
model.param('default').paramCase('case8').set('lambdas', '0.26');
model.param('default').paramCase('case8').set('kappas', '0.005');
model.param('default').paramCase('case8').set('ee', '2.86');
model.param('default').paramCase('case8').set('deltae', '0.75');
model.param('default').paramCase('case8').set('zeta', '0.1');
model.param('default').paramCase('case8').set('dvs', '0.01');
model.param('default').paramCase('case8').set('dss', '30');
model.param('default').paramCase('case8').set('Pc0', '600[kPa]');
model.param('default').paramCase('case8').set('Pbi', '500[kPa]');
model.param('default').paramCase('case8').label('Cemented Bangkok Clay, Aw = 15%');
model.param.create('par2');
model.param('par2').set('para', '0');
model.param('par2').descr('para', 'Parameter');

model.func.create('int1', 'Interpolation');
model.func('int1').label('Boundary Load');
model.func('int1').set('funcname', 'Pressure');
model.func('int1').setIndex('table', 0, 0, 0);
model.func('int1').setIndex('table', '0.01*p0', 0, 1);
model.func('int1').setIndex('table', 1, 1, 0);
model.func('int1').setIndex('table', '10*p0', 1, 1);
model.func('int1').setIndex('table', 2, 2, 0);
model.func('int1').setIndex('table', '50*p0', 2, 1);

model.geom('geom1').create('r1', 'Rectangle');
model.geom('geom1').feature('r1').set('size', {'5[cm]' '10[cm]'});
model.geom('geom1').run('r1');
model.geom('geom1').run;

model.material.create('mat1', 'Common', 'comp1');
model.material('mat1').label('Clay Material');

model.physics('solid').create('epsm1', 'ElastoplasticSoilMaterial', 2);
model.physics('solid').feature('epsm1').selection.all;
model.physics('solid').feature('epsm1').set('MaterialModel', 'StructuredCamClay');
model.physics('solid').feature('epsm1').set('CamClayOption', 'G');
model.physics('solid').feature('epsm1').set('epdevc_mat', 'userdef');
model.physics('solid').feature('epsm1').set('epdevc', 0.1);
model.physics('solid').feature('epsm1').set('pref', '1[kPa]');
model.physics('solid').feature('epsm1').set('pc0', 'Pc0');
model.physics('solid').create('bndl1', 'BoundaryLoad', 1);
model.physics('solid').feature('bndl1').selection.set([3 4]);
model.physics('solid').feature('bndl1').set('LoadType', 'FollowerPressure');
model.physics('solid').feature('bndl1').set('FollowerPressure', 'Pressure(para)');
model.physics('solid').create('roll1', 'Roller', 1);
model.physics('solid').feature('roll1').selection.set([2]);

model.material('mat1').propertyGroup.create('KG', 'Bulk_modulus_and_shear_modulus');
model.material('mat1').propertyGroup('KG').set('G', {'GG'});
model.material('mat1').propertyGroup.create('StructuredCamClayModel', 'Structured_Camclay');
model.material('mat1').propertyGroup('StructuredCamClayModel').set('kappaSwellingS', {'kappas'});
model.material('mat1').propertyGroup('StructuredCamClayModel').set('lambdaCompS', {'lambdas'});
model.material('mat1').propertyGroup('StructuredCamClayModel').set('evoidrefS', {'ee'});
model.material('mat1').propertyGroup('StructuredCamClayModel').set('dvS', {'dvs'});
model.material('mat1').propertyGroup('StructuredCamClayModel').set('dsS', {'dss'});
model.material('mat1').propertyGroup('StructuredCamClayModel').set('M', {'MM'});
model.material('mat1').propertyGroup('StructuredCamClayModel').set('Deltaei', {'deltae'});
model.material('mat1').propertyGroup('StructuredCamClayModel').set('pbi', {'Pbi'});
model.material('mat1').propertyGroup('StructuredCamClayModel').set('zetaS', {'zeta'});
model.material('mat1').propertyGroup('def').set('density', {'Rho'});

model.mesh('mesh1').create('map1', 'Map');
model.mesh('mesh1').feature('size').set('hauto', 7);
model.mesh('mesh1').run;

model.study('std1').setGenPlots(false);
model.study('std1').create('param', 'Parametric');
model.study('std1').feature('param').set('sweeptype', 'switch');
model.study('std1').feature('param').setIndex('switchname', 'default', 0);
model.study('std1').feature('param').setIndex('switchcase', 'all', 0);
model.study('std1').feature('param').setIndex('switchlistarr', 'range(1,1,8)', 0);
model.study('std1').feature('param').setIndex('switchname', 'default', 0);
model.study('std1').feature('param').setIndex('switchcase', 'all', 0);
model.study('std1').feature('param').setIndex('switchlistarr', 'range(1,1,8)', 0);
model.study('std1').feature('stat').set('useparam', true);
model.study('std1').feature('stat').setIndex('pname', 'deltae', 0);
model.study('std1').feature('stat').setIndex('plistarr', '', 0);
model.study('std1').feature('stat').setIndex('punit', '', 0);
model.study('std1').feature('stat').setIndex('pname', 'deltae', 0);
model.study('std1').feature('stat').setIndex('plistarr', '', 0);
model.study('std1').feature('stat').setIndex('punit', '', 0);
model.study('std1').feature('stat').setIndex('pname', 'para', 0);
model.study('std1').feature('stat').setIndex('plistarr', 'range(0,0.001,0.01) range(0.015,0.005,1) range(1.02,0.02,2)', 0);

model.sol.create('sol1');
model.sol('sol1').study('std1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'stat');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').feature('comp1_u').set('scalemethod', 'manual');
model.sol('sol1').feature('v1').feature('comp1_u').set('scaleval', '1e-2*0.11180339887498951');
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

model.batch.create('p1', 'Parametric');
model.batch('p1').study('std1');
model.batch('p1').create('so1', 'Solutionseq');
model.batch('p1').feature('so1').set('seq', 'sol1');
model.batch('p1').feature('so1').set('store', 'on');
model.batch('p1').feature('so1').set('clear', 'on');
model.batch('p1').feature('so1').set('psol', 'none');
model.batch('p1').set('pname', {});
model.batch('p1').set('plistarr', {});
model.batch('p1').set('sweeptype', 'switch');
model.batch('p1').set('probesel', 'all');
model.batch('p1').set('probes', {});
model.batch('p1').set('plot', 'off');
model.batch('p1').set('err', 'on');
model.batch('p1').attach('std1');
model.batch('p1').set('control', 'param');

model.sol.create('sol2');
model.sol('sol2').study('std1');
model.sol('sol2').label('Parametric Solutions 1');

model.batch('p1').feature('so1').set('psol', 'sol2');
model.batch('p1').run('compute');

model.result.create('pg1', 'PlotGroup1D');
model.result('pg1').run;
model.result('pg1').label('Natural Osaka Clay');
model.result('pg1').set('data', 'dset2');
model.result('pg1').setIndex('looplevelinput', 'manual', 1);
model.result('pg1').setIndex('looplevel', [1], 1);
model.result('pg1').set('xlog', true);
model.result('pg1').set('titletype', 'none');
model.result('pg1').set('xlabelactive', true);
model.result('pg1').set('xlabel', 'Pressure (kPa)');
model.result('pg1').set('ylabelactive', true);
model.result('pg1').set('ylabel', 'Void ratio (1)');
model.result('pg1').create('ptgr1', 'PointGraph');
model.result('pg1').feature('ptgr1').set('markerpos', 'datapoints');
model.result('pg1').feature('ptgr1').set('linewidth', 'preference');
model.result('pg1').feature('ptgr1').selection.set([4]);
model.result('pg1').feature('ptgr1').set('expr', 'solid.epsm1.evoid');
model.result('pg1').feature('ptgr1').set('descr', 'Void ratio');
model.result('pg1').feature('ptgr1').set('xdataexpr', 'solid.pmGp');
model.result('pg1').feature('ptgr1').set('xdatadescr', 'Pressure');
model.result('pg1').feature('ptgr1').set('xdataunit', 'kPa');
model.result('pg1').feature('ptgr1').set('legend', true);
model.result('pg1').feature('ptgr1').set('legendmethod', 'manual');
model.result('pg1').feature('ptgr1').setIndex('legends', 'Osaka clay', 0);
model.result('pg1').feature.duplicate('ptgr2', 'ptgr1');
model.result('pg1').run;
model.result('pg1').feature('ptgr2').set('expr', 'solid.epsm1.evoidc0');
model.result('pg1').feature('ptgr2').set('xdataexpr', 'solid.epsm1.pc0');
model.result('pg1').feature('ptgr2').set('linecolor', 'cyclereset');
model.result('pg1').feature('ptgr2').set('linewidth', 3);
model.result('pg1').feature('ptgr2').set('linemarker', 'point');
model.result('pg1').feature('ptgr2').set('legend', false);
model.result('pg1').run;
model.result('pg1').feature.duplicate('ptgr3', 'ptgr1');
model.result('pg1').run;
model.result('pg1').feature('ptgr3').set('expr', 'solid.epsm1.evoidrefd-solid.epsm1.lambdaCompS*log(solid.epsm1.p/solid.epsm1.pref)');
model.result('pg1').feature('ptgr3').set('linestyle', 'dashed');
model.result('pg1').feature('ptgr3').set('linecolor', 'fromtheme');
model.result('pg1').feature('ptgr3').setIndex('legends', 'ICL', 0);
model.result('pg1').run;
model.result('pg1').run;
model.result.duplicate('pg2', 'pg1');
model.result('pg2').run;
model.result('pg2').label('Natural Marl Clay');
model.result('pg2').setIndex('looplevel', [2], 1);
model.result('pg2').run;
model.result('pg2').feature('ptgr1').setIndex('legends', 'Marl clay', 0);
model.result('pg2').run;
model.result('pg2').run;
model.result.duplicate('pg3', 'pg2');
model.result('pg3').run;
model.result('pg3').label('Cemented Ariake Clay');
model.result('pg3').setIndex('looplevel', [3 4 5], 1);
model.result('pg3').run;
model.result('pg3').feature('ptgr1').setIndex('legends', 'Ariake clay, Aw = 6%', 0);
model.result('pg3').feature('ptgr1').setIndex('legends', 'Ariake clay, Aw = 9%', 1);
model.result('pg3').feature('ptgr1').setIndex('legends', 'Ariake clay, Aw = 18%', 2);
model.result('pg3').run;
model.result('pg3').feature('ptgr3').set('data', 'dset2');
model.result('pg3').feature('ptgr3').setIndex('looplevelinput', 'manual', 1);
model.result('pg3').feature('ptgr3').setIndex('looplevel', [3], 1);
model.result('pg3').run;
model.result('pg3').set('legendlayout', 'outside');
model.result('pg3').set('legendposoutside', 'bottom');
model.result('pg3').set('legendrowcount', 2);
model.result('pg3').run;
model.result.duplicate('pg4', 'pg3');
model.result('pg4').run;
model.result('pg4').label('Cemented Bangkok Clay');
model.result('pg4').setIndex('looplevel', [6 7 8], 1);
model.result('pg4').run;
model.result('pg4').feature('ptgr1').setIndex('legends', 'Bangkok clay, Aw = 5%', 0);
model.result('pg4').feature('ptgr1').setIndex('legends', 'Bangkok clay, Aw = 10%', 1);
model.result('pg4').feature('ptgr1').setIndex('legends', 'Bangkok clay, Aw = 15%', 2);
model.result('pg4').run;
model.result('pg4').feature('ptgr3').setIndex('looplevel', [6], 1);
model.result('pg4').run;
model.result('pg4').run;

model.title('Isotropic Compression Test for Structured Clays');

model.description('This model simulates the isotropic compression of naturally structured and artificially structured clays using the Modified Structured Cam-Clay (MSCC) material model. The aim of the example is to reproduce isotropic compression behavior given in a benchmark for four structured soils.');

model.mesh.clearMeshes;

model.sol('sol1').clearSolutionData;
model.sol('sol2').clearSolutionData;
model.sol('sol3').clearSolutionData;
model.sol('sol4').clearSolutionData;
model.sol('sol5').clearSolutionData;
model.sol('sol6').clearSolutionData;
model.sol('sol7').clearSolutionData;
model.sol('sol8').clearSolutionData;
model.sol('sol9').clearSolutionData;
model.sol('sol10').clearSolutionData;

model.label('isotropic_compression_mscc.mph');

model.modelNode.label('Components');

out = model;
