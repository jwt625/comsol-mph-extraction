function out = model
%
% hysteresis_small_strain_overlay.m
%
% Model exported on May 26 2025, 21:28 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/Geomechanics_Module/Verification_Examples');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 2);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.physics.create('solid', 'SolidMechanics', 'geom1');
model.physics('solid').model('comp1');

model.study.create('std1');
model.study('std1').create('stat', 'Stationary');
model.study('std1').feature('stat').setSolveFor('/physics/solid', true);

model.param.set('para', '0');
model.param.descr('para', 'Parameter');
model.param.set('Nu', '0.2');
model.param.descr('Nu', 'Poisson''s ratio');
model.param.set('G_0', '185[MPa]');
model.param.descr('G_0', 'Initial shear modulus');
model.param.set('gamma_a', '2e-4');
model.param.descr('gamma_a', 'Threshold shear strain');
model.param.set('a', '0.385');
model.param.descr('a', 'Material parameter');
model.param.set('gamma_ref', 'gamma_a/a');
model.param.descr('gamma_ref', 'Reference shear strain');

model.func.create('int1', 'Interpolation');
model.func('int1').model('comp1');
model.func('int1').set('funcname', 'appliedDisp');
model.func('int1').setIndex('table', 0, 0, 0);
model.func('int1').setIndex('table', 0, 0, 1);
model.func('int1').setIndex('table', 1, 1, 0);
model.func('int1').setIndex('table', '5e-3', 1, 1);
model.func('int1').setIndex('table', 2, 2, 0);
model.func('int1').setIndex('table', 0, 2, 1);
model.func('int1').setIndex('table', 3, 3, 0);
model.func('int1').setIndex('table', '-5e-3', 3, 1);
model.func('int1').setIndex('table', 4, 4, 0);
model.func('int1').setIndex('table', 0, 4, 1);
model.func('int1').setIndex('table', 5, 5, 0);
model.func('int1').setIndex('table', '5e-3', 5, 1);
model.func('int1').setIndex('fununit', 'cm', 0);
model.func('int1').setIndex('argunit', 1, 0);

model.geom('geom1').create('r1', 'Rectangle');
model.geom('geom1').feature('r1').set('size', {'5[cm]' '10[cm]'});
model.geom('geom1').run('r1');
model.geom('geom1').run;

model.physics('solid').prop('ShapeProperty').set('order_displacement', 1);
model.physics('solid').create('nlemm1', 'NonlinearElasticMaterial', 2);
model.physics('solid').feature('nlemm1').selection.set([1]);
model.physics('solid').feature('nlemm1').set('NonlinearElasticModel', 'SmallStrainOverlay');
model.physics('solid').create('roll1', 'Roller', 1);
model.physics('solid').feature('roll1').selection.set([1 2]);
model.physics('solid').create('disp1', 'Displacement1', 1);
model.physics('solid').feature('disp1').selection.set([3]);
model.physics('solid').feature('disp1').setIndex('Direction', 'prescribed', 1);
model.physics('solid').feature('disp1').setIndex('U0', '-appliedDisp(para)', 1);
model.physics('solid').create('disp2', 'Displacement1', 1);
model.physics('solid').feature('disp2').selection.set([4]);
model.physics('solid').feature('disp2').setIndex('Direction', 'prescribed', 1);
model.physics('solid').feature('disp2').setIndex('U0', 'appliedDisp(para)', 1);
model.physics('solid').feature.duplicate('disp3', 'disp2');
model.physics('solid').feature('disp3').selection.set([1]);
model.physics('solid').feature('disp3').setIndex('U0', 0, 1);
model.physics('solid').create('disp4', 'Displacement1', 1);
model.physics('solid').feature('disp4').selection.set([3]);
model.physics('solid').feature('disp4').setIndex('Direction', 'prescribed', 0);
model.physics('solid').feature('disp4').setIndex('U0', 'appliedDisp(para)', 0);
model.physics('solid').feature.duplicate('disp5', 'disp4');
model.physics('solid').feature('disp5').selection.set([2]);
model.physics('solid').feature('disp5').setIndex('U0', 0, 0);

model.nodeGroup.create('grp1', 'Physics', 'solid');
model.nodeGroup('grp1').placeAfter('nlemm1');
model.nodeGroup('grp1').add('roll1');
model.nodeGroup('grp1').add('disp1');
model.nodeGroup('grp1').label('Cyclic Triaxial Loading');
model.nodeGroup.create('grp2', 'Physics', 'solid');
model.nodeGroup('grp2').placeAfter('nlemm1');
model.nodeGroup('grp2').add('disp2');
model.nodeGroup('grp2').add('disp3');
model.nodeGroup('grp2').add('disp4');
model.nodeGroup('grp2').add('disp5');
model.nodeGroup('grp2').label('Cyclic Shear Loading');

model.material.create('mat1', 'Common', 'comp1');
model.material('mat1').label('Soil Material');
model.material('mat1').propertyGroup.create('NonlinearElasticMaterial', 'Nonlinear_elastic_material');
model.material('mat1').propertyGroup('NonlinearElasticMaterial').set('gammaRef', {'gamma_ref'});
model.material('mat1').propertyGroup.create('Enu', 'Young''s_modulus_and_Poisson''s_ratio');
model.material('mat1').propertyGroup('Enu').set('nu', {'Nu'});
model.material('mat1').propertyGroup('NonlinearElasticMaterial').set('G0', {'G_0'});
model.material('mat1').propertyGroup('def').set('density', {'2400'});

model.mesh('mesh1').create('map1', 'Map');
model.mesh('mesh1').feature('map1').create('dis1', 'Distribution');
model.mesh('mesh1').feature('map1').feature('dis1').selection.all;
model.mesh('mesh1').feature('map1').feature('dis1').set('numelem', 1);
model.mesh('mesh1').run('map1');

model.study('std1').label('Study: Cyclic Triaxial Loading');
model.study('std1').setGenPlots(false);
model.study('std1').feature('stat').set('useadvanceddisable', true);
model.study('std1').feature('stat').set('disabledphysics', {'solid/disp2' 'solid/disp3' 'solid/disp4' 'solid/disp5'});
model.study('std1').feature('stat').set('useparam', true);
model.study('std1').feature('stat').setIndex('pname', 'para', 0);
model.study('std1').feature('stat').setIndex('plistarr', '', 0);
model.study('std1').feature('stat').setIndex('punit', '', 0);
model.study('std1').feature('stat').setIndex('pname', 'para', 0);
model.study('std1').feature('stat').setIndex('plistarr', '', 0);
model.study('std1').feature('stat').setIndex('punit', '', 0);
model.study('std1').feature('stat').setIndex('plistarr', 'range(0,0.001,5)', 0);

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

model.study.create('std2');
model.study('std2').create('stat', 'Stationary');
model.study('std2').feature('stat').setSolveFor('/physics/solid', true);
model.study('std2').label('Study: Cyclic Shear Loading');
model.study('std2').setGenPlots(false);
model.study('std2').feature('stat').set('useparam', true);
model.study('std2').feature('stat').setIndex('pname', 'para', 0);
model.study('std2').feature('stat').setIndex('plistarr', '', 0);
model.study('std2').feature('stat').setIndex('punit', '', 0);
model.study('std2').feature('stat').setIndex('pname', 'para', 0);
model.study('std2').feature('stat').setIndex('plistarr', '', 0);
model.study('std2').feature('stat').setIndex('punit', '', 0);
model.study('std2').feature('stat').setIndex('plistarr', 'range(0,0.001,5)', 0);

model.sol.create('sol2');
model.sol('sol2').study('std2');
model.sol('sol2').create('st1', 'StudyStep');
model.sol('sol2').feature('st1').set('study', 'std2');
model.sol('sol2').feature('st1').set('studystep', 'stat');
model.sol('sol2').create('v1', 'Variables');
model.sol('sol2').feature('v1').set('control', 'stat');
model.sol('sol2').create('s1', 'Stationary');
model.sol('sol2').feature('s1').create('p1', 'Parametric');
model.sol('sol2').feature('s1').feature.remove('pDef');
model.sol('sol2').feature('s1').feature('p1').set('control', 'stat');
model.sol('sol2').feature('s1').set('control', 'stat');
model.sol('sol2').feature('s1').feature('aDef').set('cachepattern', true);
model.sol('sol2').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol2').feature('s1').feature('fc1').set('termonres', 'auto');
model.sol('sol2').feature('s1').feature('fc1').set('reserrfact', 1000);
model.sol('sol2').feature('s1').feature('fc1').set('linsolver', 'dDef');
model.sol('sol2').feature('s1').feature('fc1').set('termonres', 'auto');
model.sol('sol2').feature('s1').feature('fc1').set('reserrfact', 1000);
model.sol('sol2').feature('s1').feature.remove('fcDef');
model.sol('sol2').attach('std2');
model.sol('sol2').runAll;

model.result.create('pg1', 'PlotGroup1D');
model.result('pg1').run;
model.result('pg1').label('Axial Stress vs. Axial Strain');
model.result('pg1').set('titletype', 'manual');
model.result('pg1').set('title', 'Axial Stress vs. Axial Strain');
model.result('pg1').set('xlabelactive', true);
model.result('pg1').set('xlabel', 'Axial strain (1)');
model.result('pg1').set('ylabelactive', true);
model.result('pg1').set('ylabel', 'Axial stress (kPa)');
model.result('pg1').set('legendpos', 'upperleft');
model.result('pg1').create('ptgr1', 'PointGraph');
model.result('pg1').feature('ptgr1').set('markerpos', 'datapoints');
model.result('pg1').feature('ptgr1').set('linewidth', 'preference');
model.result('pg1').feature('ptgr1').set('data', 'dset1');
model.result('pg1').feature('ptgr1').setIndex('looplevelinput', 'manualindices', 0);
model.result('pg1').feature('ptgr1').setIndex('looplevelindices', 'range(1,1,1001)', 0);
model.result('pg1').feature('ptgr1').selection.set([4]);
model.result('pg1').feature('ptgr1').set('expr', '-solid.SYY');
model.result('pg1').feature('ptgr1').set('unit', 'kPa');
model.result('pg1').feature('ptgr1').set('xdata', 'expr');
model.result('pg1').feature('ptgr1').set('xdataexpr', '-solid.eYY');
model.result('pg1').feature('ptgr1').set('legend', true);
model.result('pg1').feature('ptgr1').set('legendmethod', 'manual');
model.result('pg1').feature('ptgr1').setIndex('legends', 'Primary loading', 0);
model.result('pg1').feature.duplicate('ptgr2', 'ptgr1');
model.result('pg1').run;
model.result('pg1').feature('ptgr2').setIndex('looplevelindices', 'range(1001,1,5001)', 0);
model.result('pg1').feature('ptgr2').setIndex('legends', 'Unloading and reloading', 0);
model.result('pg1').run;
model.result('pg1').run;
model.result.duplicate('pg2', 'pg1');
model.result('pg2').run;
model.result('pg2').label('Young''s Modulus vs. Axial Strain');
model.result('pg2').set('title', 'Young''s Modulus vs. Axial Strain');
model.result('pg2').set('ylabel', 'Young''s Modulus (MPa)');
model.result('pg2').run;
model.result('pg2').feature('ptgr1').set('expr', 'solid.E');
model.result('pg2').feature('ptgr1').set('unit', 'MPa');
model.result('pg2').feature('ptgr1').set('xdataexpr', 'abs(solid.eYY)');
model.result('pg2').run;
model.result('pg2').feature('ptgr2').setIndex('looplevelindices', 'range(3002,1,4001)', 0);
model.result('pg2').feature('ptgr2').set('expr', 'solid.E');
model.result('pg2').feature('ptgr2').set('unit', 'MPa');
model.result('pg2').feature('ptgr2').set('xdataexpr', 'abs(solid.eYY-withsol(''sol1'',solid.eYY,setval(para,3)))');
model.result('pg2').feature('ptgr2').setIndex('legends', 'Reloading', 0);
model.result('pg2').run;
model.result('pg2').set('xlog', true);
model.result('pg2').set('legendpos', 'lowerleft');
model.result('pg2').run;
model.result('pg1').run;
model.result.duplicate('pg3', 'pg1');
model.result('pg3').run;
model.result('pg3').label('Shear Stress vs. Shear Strain');
model.result('pg3').set('data', 'dset2');
model.result('pg3').set('title', 'Shear Stress vs. Shear Strain');
model.result('pg3').set('xlabel', 'Shear strain (1)');
model.result('pg3').set('ylabel', 'Shear stress (kPa)');
model.result('pg3').run;
model.result('pg3').feature('ptgr1').set('data', 'dset2');
model.result('pg3').feature('ptgr1').set('expr', 'solid.SXY');
model.result('pg3').feature('ptgr1').set('xdataexpr', 'solid.eXY');
model.result('pg3').run;
model.result('pg3').feature('ptgr2').set('data', 'dset2');
model.result('pg3').feature('ptgr2').set('expr', 'solid.SXY');
model.result('pg3').feature('ptgr2').set('xdataexpr', 'solid.eXY');
model.result('pg3').run;
model.result('pg2').run;
model.result.duplicate('pg4', 'pg2');
model.result('pg4').run;
model.result('pg4').label('Shear Modulus vs. Shear Strain');
model.result('pg4').set('data', 'dset2');
model.result('pg4').set('title', 'Shear Modulus vs. Shear Strain');
model.result('pg4').set('xlabel', 'Shear strain (1)');
model.result('pg4').set('ylabel', 'Shear modulus (MPa)');
model.result('pg4').run;
model.result('pg4').feature('ptgr1').set('data', 'dset2');
model.result('pg4').feature('ptgr1').set('expr', 'solid.G');
model.result('pg4').feature('ptgr1').set('xdataexpr', 'abs(solid.eXY)');
model.result('pg4').run;
model.result('pg4').feature('ptgr2').set('data', 'dset2');
model.result('pg4').feature('ptgr2').set('expr', 'solid.G');
model.result('pg4').feature('ptgr2').set('xdataexpr', 'abs(solid.eXY-withsol(''sol2'',solid.eXY,setval(para,3)))');
model.result('pg4').run;
model.result('pg1').run;

model.nodeGroup.create('grp3', 'Results');
model.nodeGroup('grp3').set('type', 'plotgroup');
model.nodeGroup('grp3').add('plotgroup', 'pg1');
model.nodeGroup('grp3').add('plotgroup', 'pg2');
model.nodeGroup('grp3').label('Triaxial Loading');

model.result('pg3').run;

model.nodeGroup.create('grp4', 'Results');
model.nodeGroup('grp4').set('type', 'plotgroup');
model.nodeGroup.move('grp4', 3);
model.nodeGroup('grp4').add('plotgroup', 'pg3');
model.nodeGroup('grp4').add('plotgroup', 'pg4');
model.nodeGroup('grp4').label('Shear Loading');

model.result('pg1').run;

model.title('Hysteresis in Soil Using the Small-Strain Overlay Model');

model.description(['The small-strain overlay material model captures the effect of high stiffness at low strain as well as the hysteresis under cyclic loading, which is a common effect for most soils. The formulation allows stiffness degradation with an increase in shear strain and the full recovery of stiffness at load reversal.' newline  newline 'In this example, cyclic tensile and shear tests show the stiffness degradation and the hysteresis effect with the small-strain overlay model.']);

model.label('hysteresis_small_strain_overlay.mph');

model.modelNode.label('Components');

out = model;
