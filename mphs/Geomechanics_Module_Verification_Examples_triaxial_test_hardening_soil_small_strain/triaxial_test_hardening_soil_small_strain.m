function out = model
%
% triaxial_test_hardening_soil_small_strain.m
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
model.physics.create('solid2', 'SolidMechanics', 'geom1');
model.physics('solid2').model('comp1');

model.study.create('std1');
model.study('std1').create('stat', 'Stationary');
model.study('std1').feature('stat').setSolveFor('/physics/solid', true);
model.study('std1').feature('stat').setSolveFor('/physics/solid2', true);

model.param.set('disp', '0[cm]');
model.param.descr('disp', 'Displacement parameter');
model.param.set('para', '0');
model.param.descr('para', 'Parameter');
model.param.set('G_0', '190[MPa]');
model.param.descr('G_0', 'Initial shear modulus for Hostun dense soil');
model.param.set('a', '0.385');
model.param.descr('a', 'Material parameter');
model.param.create('par2');
model.param('par2').label('Soil Properties');

% To import content from file, use:
% model.param('par2').loadFile('FILENAME');
model.param('par2').set('Rho', '2400[kg/m^3]', 'Density');
model.param('par2').set('Nu', '0.25', 'Poisson''s ratio');
model.param('par2').set('Eiref', '65.488[MPa]', 'Reference initial stiffness for primary loading');
model.param('par2').set('Eurref', '90[MPa]', 'Reference stiffness for unloading and reloading');
model.param('par2').set('e0', '0.65', 'Initial void ratio');
model.param('par2').set('m', '0.55', 'Stress exponent');
model.param('par2').set('rc', '1.84', 'Swelling to compression ratio');
model.param('par2').set('c', '1[kPa]', 'Cohesion');
model.param('par2').set('Psi', '16[deg]', 'Dilatation angle');
model.param('par2').set('Phi', '42[deg]', 'Angle of internal friction');
model.param('par2').set('Rc', '0.68027', 'Ellipse aspect ratio');
model.param('par2').set('p0', '300[kPa]', 'Pressure');
model.param('par2').set('gamma_a', '2e-4', 'Threshold shear strain');
model.param('par2').set('gammaR', 'gamma_a/a', 'Reference shear strain');
model.param('par2').set('E0ref', '270[MPa]', 'Initial Young''s modulus at reference pressure');
model.param('par2').set('G0ref', 'E0ref/(2*(1+Nu))', 'Initial shear modulus at reference pressure');
model.param('par2').paramCase.create('case1');
model.param('par2').paramCase('case1').label('Hostun Dense Soil Properties');
model.param('par2').paramCase.create('case2');
model.param('par2').paramCase('case2').label('Hostun Loose Sand Properties');
model.param('par2').paramCase('case2').set('Rho', '2000[kg/m^3]');
model.param('par2').paramCase('case2').set('Eiref', '23.8[MPa]');
model.param('par2').paramCase('case2').set('Eurref', '60[MPa]');
model.param('par2').paramCase('case2').set('e0', '0.85');
model.param('par2').paramCase('case2').set('m', '0.75');
model.param('par2').paramCase('case2').set('rc', '2.01');
model.param('par2').paramCase('case2').set('Psi', '0[deg]');
model.param('par2').paramCase('case2').set('Phi', '34[deg]');
model.param('par2').paramCase('case2').set('Rc', '0.64103');
model.param('par2').paramCase('case2').set('gamma_a', '1e-4');
model.param('par2').paramCase('case2').set('E0ref', '168[MPa]');
model.param('par2').paramCase.create('case3');
model.param('par2').paramCase('case3').label('Kaolin Clay Properties');
model.param('par2').paramCase('case3').set('Rho', '1700[kg/m^3]');
model.param('par2').paramCase('case3').set('Nu', '0.2');
model.param('par2').paramCase('case3').set('Eiref', '14.05[MPa]');
model.param('par2').paramCase('case3').set('Eurref', '11.5[MPa]');
model.param('par2').paramCase('case3').set('e0', '0.9');
model.param('par2').paramCase('case3').set('m', '0.8');
model.param('par2').paramCase('case3').set('rc', '4.76');
model.param('par2').paramCase('case3').set('Psi', '0[deg]');
model.param('par2').paramCase('case3').set('Phi', '20[deg]');
model.param('par2').paramCase('case3').set('Rc', '1.2821');
model.param('par2').paramCase('case3').set('E0ref', '80[MPa]');

model.func.create('int1', 'Interpolation');
model.func('int1').model('comp1');
model.func('int1').set('funcname', 'appliedDisp');
model.func('int1').setIndex('table', 0, 0, 0);
model.func('int1').setIndex('table', 0, 0, 1);
model.func('int1').setIndex('table', 1, 1, 0);
model.func('int1').setIndex('table', '5e-3', 1, 1);
model.func('int1').setIndex('table', 2, 2, 0);
model.func('int1').setIndex('table', '-5e-3', 2, 1);
model.func('int1').setIndex('table', 3, 3, 0);
model.func('int1').setIndex('table', '5e-3', 3, 1);
model.func('int1').setIndex('fununit', 'cm', 0);
model.func('int1').setIndex('argunit', 1, 0);

model.geom('geom1').create('r1', 'Rectangle');
model.geom('geom1').feature('r1').set('size', {'5[cm]' '10[cm]'});
model.geom('geom1').run('r1');
model.geom('geom1').create('arr1', 'Array');
model.geom('geom1').feature('arr1').selection('input').set({'r1'});
model.geom('geom1').feature('arr1').set('fullsize', [1 2]);
model.geom('geom1').feature('arr1').set('displ', {'0' '20[cm]'});
model.geom('geom1').run('arr1');
model.geom('geom1').run;

model.physics('solid').label('Solid Mechanics [Monotonic]');
model.physics('solid').prop('ShapeProperty').set('order_displacement', 1);
model.physics('solid').create('epsm1', 'ElastoplasticSoilMaterial', 2);
model.physics('solid').feature('epsm1').label(['Hardening Soil Small Strain: Mohr' native2unicode(hex2dec({'20' '13'}), 'unicode') 'Coulomb']);
model.physics('solid').feature('epsm1').selection.set([1]);
model.physics('solid').feature('epsm1').set('MaterialModel', 'HardeningSoilSmall');
model.physics('solid').feature('epsm1').set('EiRef_mat', 'from_mat');
model.physics('solid').feature('epsm1').set('Kc_mat', 'FromRatio');
model.physics('solid').feature('epsm1').set('pref', 'p0');
model.physics('solid').feature('epsm1').set('pc0', '200[MPa]');
model.physics('solid').feature('epsm1').create('exs1', 'ExternalStress', 2);
model.physics('solid').feature('epsm1').feature('exs1').set('StressInputType', 'InSituStress');
model.physics('solid').feature('epsm1').feature('exs1').set('sins', {'-p0' '0' '0' '0' '-p0' '0' '0' '0' '-p0'});
model.physics('solid').feature.duplicate('epsm2', 'epsm1');
model.physics('solid').feature('epsm2').label(['Hardening Soil Small Strain: Matsuoka' native2unicode(hex2dec({'20' '13'}), 'unicode') 'Nakai']);
model.physics('solid').feature('epsm2').selection.set([2]);
model.physics('solid').feature('epsm2').set('HardeningSoilOption', 'HSSmooth');
model.physics('solid').create('roll1', 'Roller', 1);
model.physics('solid').feature('roll1').selection.set([2 5]);
model.physics('solid').create('disp1', 'Displacement1', 1);
model.physics('solid').feature('disp1').selection.set([3 6]);
model.physics('solid').feature('disp1').setIndex('Direction', 'prescribed', 2);
model.physics('solid').feature('disp1').setIndex('U0', '-disp', 2);
model.physics('solid2').label('Solid Mechanics [Cyclic]');
model.physics('solid2').selection.set([1]);
model.physics('solid2').prop('ShapeProperty').set('order_displacement', 1);
model.physics('solid2').create('epsm1', 'ElastoplasticSoilMaterial', 2);
model.physics('solid2').feature('epsm1').label(['Hardening Soil Small Strain: Matsuoka' native2unicode(hex2dec({'20' '13'}), 'unicode') 'Nakai']);
model.physics('solid2').feature('epsm1').selection.set([1]);
model.physics('solid2').feature('epsm1').set('MaterialModel', 'HardeningSoilSmall');
model.physics('solid2').feature('epsm1').set('HardeningSoilOption', 'HSSmooth');
model.physics('solid2').feature('epsm1').set('EiRef_mat', 'from_mat');
model.physics('solid2').feature('epsm1').set('G0_mat', 'from_mat');
model.physics('solid2').feature('epsm1').set('Kc_mat', 'FromRatio');
model.physics('solid2').feature('epsm1').set('pref', 'p0');
model.physics('solid2').feature('epsm1').set('pc0', '200[MPa]');
model.physics('solid2').feature('epsm1').create('exs1', 'ExternalStress', 2);
model.physics('solid2').feature('epsm1').feature('exs1').set('StressInputType', 'InSituStress');
model.physics('solid2').feature('epsm1').feature('exs1').set('sins', {'-p0' '0' '0' '0' '-p0' '0' '0' '0' '-p0'});
model.physics('solid2').create('roll1', 'Roller', 1);
model.physics('solid2').feature('roll1').selection.set([2]);
model.physics('solid2').create('disp1', 'Displacement1', 1);
model.physics('solid2').feature('disp1').selection.set([3]);
model.physics('solid2').feature('disp1').setIndex('Direction', 'prescribed', 2);
model.physics('solid2').feature('disp1').setIndex('U0', '-appliedDisp(para)', 2);

model.material.create('mat1', 'Common', 'comp1');
model.material('mat1').label('Soil Material');
model.material('mat1').propertyGroup.create('Enu', 'Young''s_modulus_and_Poisson''s_ratio');
model.material('mat1').propertyGroup('Enu').set('nu', {'Nu'});
model.material('mat1').propertyGroup.create('HardeningSoilModel', 'Hardening_Soil');
model.material('mat1').propertyGroup('HardeningSoilModel').set('EiRef', {'Eiref'});
model.material('mat1').propertyGroup('HardeningSoilModel').set('EurRef', {'Eurref'});
model.material('mat1').propertyGroup('HardeningSoilModel').set('G0Ref', {'G0ref'});
model.material('mat1').propertyGroup('HardeningSoilModel').set('gammaRef', {'gammaR'});
model.material('mat1').propertyGroup('HardeningSoilModel').set('mH', {'m'});
model.material('mat1').propertyGroup.create('MohrCoulomb', 'Mohr_Coulomb_criterion');
model.material('mat1').propertyGroup('MohrCoulomb').set('cohesion', {'c'});
model.material('mat1').propertyGroup('MohrCoulomb').set('psid', {'Psi'});
model.material('mat1').propertyGroup('HardeningSoilModel').set('rsc', {'rc'});
model.material('mat1').propertyGroup('HardeningSoilModel').set('Rcap', {'Rc'});
model.material('mat1').propertyGroup('HardeningSoilModel').set('evoid0', {'e0'});
model.material('mat1').propertyGroup('MohrCoulomb').set('internalphi', {'Phi'});
model.material('mat1').propertyGroup('def').set('density', {'Rho'});
model.material('mat1').propertyGroup('HardeningSoilModel').set('G0', {'G_0'});

model.mesh('mesh1').create('map1', 'Map');
model.mesh('mesh1').feature('map1').create('dis1', 'Distribution');
model.mesh('mesh1').feature('map1').feature('dis1').selection.all;
model.mesh('mesh1').feature('map1').feature('dis1').set('numelem', 1);
model.mesh('mesh1').run('map1');

model.study('std1').label('Study: Monotonic Triaxial Loading');
model.study('std1').setGenPlots(false);
model.study('std1').create('param', 'Parametric');
model.study('std1').feature('param').set('sweeptype', 'switch');
model.study('std1').feature('param').setIndex('switchname', 'default', 0);
model.study('std1').feature('param').setIndex('switchcase', 'all', 0);
model.study('std1').feature('param').setIndex('switchlistarr', '', 0);
model.study('std1').feature('param').setIndex('switchname', 'default', 0);
model.study('std1').feature('param').setIndex('switchcase', 'all', 0);
model.study('std1').feature('param').setIndex('switchlistarr', '', 0);
model.study('std1').feature('param').setIndex('switchname', 'par2', 0);
model.study('std1').feature('stat').setEntry('activate', 'solid2', false);
model.study('std1').feature('stat').set('useparam', true);
model.study('std1').feature('stat').setIndex('pname', 'a', 0);
model.study('std1').feature('stat').setIndex('plistarr', '', 0);
model.study('std1').feature('stat').setIndex('punit', '', 0);
model.study('std1').feature('stat').setIndex('pname', 'a', 0);
model.study('std1').feature('stat').setIndex('plistarr', '', 0);
model.study('std1').feature('stat').setIndex('punit', '', 0);
model.study('std1').feature('stat').setIndex('pname', 'disp', 0);
model.study('std1').feature('stat').setIndex('plistarr', 'range(0,0.02,1.2)', 0);
model.study('std1').feature('stat').setIndex('punit', 'cm', 0);

model.sol.create('sol1');
model.sol('sol1').study('std1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'stat');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').feature('comp1_solid_sp').set('scalemethod', 'manual');
model.sol('sol1').feature('v1').feature('comp1_u').set('scalemethod', 'manual');
model.sol('sol1').feature('v1').feature('comp1_solid_sp').set('resscalemethod', 'parent');
model.sol('sol1').feature('v1').feature('comp1_solid_sp').set('scaleval', '10000');
model.sol('sol1').feature('v1').feature('comp1_u').set('scaleval', '1e-2*0.3041381265149111');
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

model.sol('sol1').feature('s1').feature('p1').set('porder', 'constant');
model.sol.create('sol2');
model.sol('sol2').study('std1');
model.sol('sol2').label('Parametric Solutions 1');

model.batch('p1').feature('so1').set('psol', 'sol2');
model.batch('p1').run('compute');

model.study.create('std2');
model.study('std2').create('stat', 'Stationary');
model.study('std2').feature('stat').setSolveFor('/physics/solid', true);
model.study('std2').feature('stat').setSolveFor('/physics/solid2', true);
model.study('std2').label('Study: Cyclic Triaxial Loading');
model.study('std2').setGenPlots(false);
model.study('std2').feature('stat').setEntry('activate', 'solid', false);
model.study('std2').feature('stat').set('useparam', true);
model.study('std2').feature('stat').setIndex('pname', 'a', 0);
model.study('std2').feature('stat').setIndex('plistarr', '', 0);
model.study('std2').feature('stat').setIndex('punit', '', 0);
model.study('std2').feature('stat').setIndex('pname', 'a', 0);
model.study('std2').feature('stat').setIndex('plistarr', '', 0);
model.study('std2').feature('stat').setIndex('punit', '', 0);
model.study('std2').feature('stat').setIndex('pname', 'para', 0);
model.study('std2').feature('stat').setIndex('plistarr', 'range(0,0.001,3)', 0);
model.study('std2').feature('stat').setIndex('punit', 1, 0);

model.sol.create('sol6');
model.sol('sol6').study('std2');
model.sol('sol6').create('st1', 'StudyStep');
model.sol('sol6').feature('st1').set('study', 'std2');
model.sol('sol6').feature('st1').set('studystep', 'stat');
model.sol('sol6').create('v1', 'Variables');
model.sol('sol6').feature('v1').feature('comp1_u2').set('scalemethod', 'manual');
model.sol('sol6').feature('v1').feature('comp1_solid2_sp').set('scalemethod', 'manual');
model.sol('sol6').feature('v1').feature('comp1_solid2_sp').set('resscalemethod', 'parent');
model.sol('sol6').feature('v1').feature('comp1_u2').set('scaleval', '1e-2*0.3041381265149111');
model.sol('sol6').feature('v1').feature('comp1_solid2_sp').set('scaleval', '10000');
model.sol('sol6').feature('v1').set('control', 'stat');
model.sol('sol6').create('s1', 'Stationary');
model.sol('sol6').feature('s1').create('p1', 'Parametric');
model.sol('sol6').feature('s1').feature.remove('pDef');
model.sol('sol6').feature('s1').feature('p1').set('control', 'stat');
model.sol('sol6').feature('s1').set('control', 'stat');
model.sol('sol6').feature('s1').feature('aDef').set('cachepattern', true);
model.sol('sol6').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol6').feature('s1').feature('fc1').set('termonres', 'auto');
model.sol('sol6').feature('s1').feature('fc1').set('reserrfact', 1000);
model.sol('sol6').feature('s1').feature('fc1').set('linsolver', 'dDef');
model.sol('sol6').feature('s1').feature('fc1').set('termonres', 'auto');
model.sol('sol6').feature('s1').feature('fc1').set('reserrfact', 1000);
model.sol('sol6').feature('s1').feature.remove('fcDef');
model.sol('sol6').attach('std2');
model.sol('sol6').feature('s1').feature('p1').set('porder', 'constant');
model.sol('sol6').runAll;

model.result.create('pg1', 'PlotGroup1D');
model.result('pg1').run;
model.result('pg1').label('Axial Stress vs. Axial Strain (Monotonic)');
model.result('pg1').set('titletype', 'manual');
model.result('pg1').set('title', 'Axial Stress vs. Axial Strain');
model.result('pg1').set('xlabelactive', true);
model.result('pg1').set('xlabel', 'Axial strain (1)');
model.result('pg1').set('ylabelactive', true);
model.result('pg1').set('ylabel', 'Nondimensional axial stress (1)');
model.result('pg1').set('legendlayout', 'outside');
model.result('pg1').set('legendposoutside', 'bottom');
model.result('pg1').set('legendrowcount', 2);
model.result('pg1').create('ptgr1', 'PointGraph');
model.result('pg1').feature('ptgr1').set('markerpos', 'datapoints');
model.result('pg1').feature('ptgr1').set('linewidth', 'preference');
model.result('pg1').feature('ptgr1').set('data', 'dset2');
model.result('pg1').feature('ptgr1').setIndex('looplevelinput', 'manual', 1);
model.result('pg1').feature('ptgr1').setIndex('looplevel', [1], 1);
model.result('pg1').feature('ptgr1').selection.set([6]);
model.result('pg1').feature('ptgr1').set('expr', '-solid.SZZ/p0');
model.result('pg1').feature('ptgr1').set('xdata', 'expr');
model.result('pg1').feature('ptgr1').set('xdataexpr', '-solid.eZZ');
model.result('pg1').feature('ptgr1').set('linemarker', 'asterisk');
model.result('pg1').feature('ptgr1').set('markerpos', 'interp');
model.result('pg1').feature('ptgr1').set('legend', true);
model.result('pg1').feature('ptgr1').set('legendmethod', 'manual');
model.result('pg1').feature('ptgr1').setIndex('legends', 'Hostun dense soil, MC', 0);
model.result('pg1').feature.duplicate('ptgr2', 'ptgr1');
model.result('pg1').run;
model.result('pg1').feature('ptgr2').selection.set([8]);
model.result('pg1').feature('ptgr2').set('linemarker', 'circle');
model.result('pg1').feature('ptgr2').set('markers', 10);
model.result('pg1').feature('ptgr2').setIndex('legends', 'Hostun dense soil, MN', 0);
model.result('pg1').run;
model.result('pg1').feature.duplicate('ptgr3', 'ptgr1');
model.result('pg1').run;
model.result('pg1').feature('ptgr3').setIndex('looplevel', [2], 1);
model.result('pg1').feature('ptgr3').setIndex('legends', 'Hostun loose soil, MC', 0);
model.result('pg1').run;
model.result('pg1').feature.duplicate('ptgr4', 'ptgr2');
model.result('pg1').run;
model.result('pg1').feature('ptgr4').setIndex('looplevel', [2], 1);
model.result('pg1').feature('ptgr4').setIndex('legends', 'Hostun loose soil, MN', 0);
model.result('pg1').run;
model.result('pg1').feature.duplicate('ptgr5', 'ptgr3');
model.result('pg1').run;
model.result('pg1').feature('ptgr5').setIndex('looplevel', [3], 1);
model.result('pg1').feature('ptgr5').setIndex('legends', 'Kaolin clay, MC', 0);
model.result('pg1').run;
model.result('pg1').feature.duplicate('ptgr6', 'ptgr4');
model.result('pg1').run;
model.result('pg1').feature('ptgr6').setIndex('looplevel', [3], 1);
model.result('pg1').feature('ptgr6').setIndex('legends', 'Kaolin clay, MN', 0);
model.result('pg1').run;
model.result('pg1').run;
model.result.duplicate('pg2', 'pg1');
model.result('pg2').run;
model.result('pg2').label('Volumetric Strain vs. Axial Strain (Monotonic)');
model.result('pg2').set('title', 'Volumetric Strain vs. Axial Strain');
model.result('pg2').set('ylabel', 'Volumetric strain (1)');
model.result('pg2').run;
model.result('pg2').feature('ptgr1').set('expr', 'solid.evol');
model.result('pg2').run;
model.result('pg2').feature('ptgr2').set('expr', 'solid.evol');
model.result('pg2').run;
model.result('pg2').feature('ptgr3').set('expr', 'solid.evol');
model.result('pg2').run;
model.result('pg2').feature('ptgr4').set('expr', 'solid.evol');
model.result('pg2').run;
model.result('pg2').feature('ptgr5').set('expr', 'solid.evol');
model.result('pg2').run;
model.result('pg2').feature('ptgr6').set('expr', 'solid.evol');
model.result('pg2').run;
model.result.create('pg3', 'PlotGroup1D');
model.result('pg3').run;
model.result('pg3').label('Axial Stress vs. Axial Strain (Cyclic)');
model.result('pg3').set('data', 'dset3');
model.result('pg3').set('titletype', 'manual');
model.result('pg3').set('title', 'Axial Stress vs. Axial Strain');
model.result('pg3').set('xlabelactive', true);
model.result('pg3').set('xlabel', 'Axial strain (1)');
model.result('pg3').set('ylabelactive', true);
model.result('pg3').set('ylabel', 'Axial stress (kPa)');
model.result('pg3').set('legendpos', 'upperleft');
model.result('pg3').create('ptgr1', 'PointGraph');
model.result('pg3').feature('ptgr1').set('markerpos', 'datapoints');
model.result('pg3').feature('ptgr1').set('linewidth', 'preference');
model.result('pg3').feature('ptgr1').set('data', 'dset3');
model.result('pg3').feature('ptgr1').setIndex('looplevelinput', 'manualindices', 0);
model.result('pg3').feature('ptgr1').setIndex('looplevelindices', 'range(1,1,1001)', 0);
model.result('pg3').feature('ptgr1').selection.set([6]);
model.result('pg3').feature('ptgr1').set('expr', '-(solid2.Sl33+p0)');
model.result('pg3').feature('ptgr1').set('unit', 'kPa');
model.result('pg3').feature('ptgr1').set('xdata', 'expr');
model.result('pg3').feature('ptgr1').set('xdataexpr', '-solid2.el33');
model.result('pg3').feature('ptgr1').set('legend', true);
model.result('pg3').feature('ptgr1').set('legendmethod', 'manual');
model.result('pg3').feature('ptgr1').setIndex('legends', 'Primary loading', 0);
model.result('pg3').feature.duplicate('ptgr2', 'ptgr1');
model.result('pg3').run;
model.result('pg3').feature('ptgr2').setIndex('looplevelindices', 'range(1001,1,3001)', 0);
model.result('pg3').feature('ptgr2').setIndex('legends', 'Unloading and reloading', 0);
model.result('pg3').run;
model.result('pg3').run;
model.result.duplicate('pg4', 'pg3');
model.result('pg4').run;
model.result('pg4').label('Young''s Modulus vs. Axial Strain (Cyclic)');
model.result('pg4').set('title', 'Young''s Modulus vs. Axial Strain');
model.result('pg4').set('ylabel', 'Young''s modulus (MPa)');
model.result('pg4').run;
model.result('pg4').feature('ptgr1').set('expr', 'solid2.E');
model.result('pg4').feature('ptgr1').set('unit', 'MPa');
model.result('pg4').feature('ptgr1').set('xdataexpr', 'abs(solid2.el33)');
model.result('pg4').run;
model.result('pg4').feature('ptgr2').setIndex('looplevelindices', 'range(2002,1,3001)', 0);
model.result('pg4').feature('ptgr2').set('expr', 'solid2.E');
model.result('pg4').feature('ptgr2').set('unit', 'MPa');
model.result('pg4').feature('ptgr2').set('xdataexpr', 'abs(solid2.el33-withsol(''sol6'',solid2.el33,setval(para,2)))');
model.result('pg4').feature('ptgr2').setIndex('legends', 'Reloading', 0);
model.result('pg4').run;
model.result('pg4').set('xlog', true);
model.result('pg4').set('legendpos', 'lowerleft');
model.result('pg4').run;
model.result('pg4').run;

model.title('Triaxial Test with Hardening Soil Small Strain Material Model');

model.description(['In this example, monotonic and cyclic triaxial tests are simulated using the Hardening Soil Small Strain material model.' newline  newline 'The model captures the effects of small strain stiffness and hysteresis under cyclic loading. The stress-strain relationship matches the hyperbolic curve reported in the reference.']);

model.mesh.clearMeshes;

model.sol('sol1').clearSolutionData;
model.sol('sol2').clearSolutionData;
model.sol('sol3').clearSolutionData;
model.sol('sol4').clearSolutionData;
model.sol('sol5').clearSolutionData;
model.sol('sol6').clearSolutionData;

model.label('triaxial_test_hardening_soil_small_strain.mph');

model.modelNode.label('Components');

out = model;
