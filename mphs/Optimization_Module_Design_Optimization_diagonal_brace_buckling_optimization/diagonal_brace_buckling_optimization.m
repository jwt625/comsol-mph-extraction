function out = model
%
% diagonal_brace_buckling_optimization.m
%
% Model exported on May 26 2025, 21:31 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/Optimization_Module/Design_Optimization');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 3);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.physics.create('shell', 'Shell', 'geom1');
model.physics('shell').model('comp1');

model.study.create('std1');
model.study('std1').create('stat', 'Stationary');
model.study('std1').feature('stat').set('solnum', 'auto');
model.study('std1').feature('stat').set('notsolnum', 'auto');
model.study('std1').feature('stat').set('outputmap', {});
model.study('std1').feature('stat').set('ngenAUX', '1');
model.study('std1').feature('stat').set('goalngenAUX', '1');
model.study('std1').feature('stat').set('ngenAUX', '1');
model.study('std1').feature('stat').set('goalngenAUX', '1');
model.study('std1').feature('stat').setSolveFor('/physics/shell', true);
model.study('std1').create('buckling', 'LinearBuckling');
model.study('std1').feature('buckling').set('neigsactive', true);
model.study('std1').feature('buckling').set('solnum', 'auto');
model.study('std1').feature('buckling').set('notsolnum', 'auto');
model.study('std1').feature('buckling').set('outputmap', {});
model.study('std1').feature('buckling').set('ngenAUX', '1');
model.study('std1').feature('buckling').set('goalngenAUX', '1');
model.study('std1').feature('buckling').set('ngenAUX', '1');
model.study('std1').feature('buckling').set('goalngenAUX', '1');
model.study('std1').feature('buckling').setSolveFor('/physics/shell', true);

model.param.set('Lz', '6[m]');
model.param.descr('Lz', 'Length of brace');
model.param.set('Lxy', '5[cm]');
model.param.descr('Lxy', 'Brace width');
model.param.set('thickness', '5[mm]');
model.param.descr('thickness', 'Brace thickness');
model.param.set('Lz1', '3*Lxy');
model.param.descr('Lz1', 'Brace end length');
model.param.set('Rhole', 'Lz1/10');
model.param.descr('Rhole', 'Hole radius');
model.param.set('Fload', '1[kN]');
model.param.descr('Fload', 'Load');

model.geom('geom1').create('blk1', 'Block');
model.geom('geom1').feature('blk1').set('size', {'Lxy' 'Lxy' 'Lz'});
model.geom('geom1').feature('blk1').setIndex('layername', 'Layer 1', 0);
model.geom('geom1').feature('blk1').setIndex('layer', 'Lz1', 0);
model.geom('geom1').feature('blk1').setIndex('layername', 'Layer 1', 1);
model.geom('geom1').feature('blk1').setIndex('layer', 'Lz-2*Lz1', 1);
model.geom('geom1').run('blk1');
model.geom('geom1').create('boxsel1', 'BoxSelection');
model.geom('geom1').feature('boxsel1').label('Boundaries to Delete');
model.geom('geom1').feature('boxsel1').set('entitydim', 2);
model.geom('geom1').feature('boxsel1').set('xmin', 'Lxy*0.1');
model.geom('geom1').feature('boxsel1').set('ymin', 'Lxy*0.1');
model.geom('geom1').run('boxsel1');
model.geom('geom1').create('del1', 'Delete');
model.geom('geom1').feature('del1').selection('input').named('boxsel1');
model.geom('geom1').feature('del1').set('selresult', true);
model.geom('geom1').run('del1');
model.geom('geom1').create('cyl1', 'Cylinder');
model.geom('geom1').feature('cyl1').set('r', 'Rhole');
model.geom('geom1').feature('cyl1').set('h', 'Rhole');
model.geom('geom1').feature('cyl1').set('pos', {'Lxy/2' '-Rhole/2' '0'});
model.geom('geom1').feature('cyl1').setIndex('pos', 'Lz1/2', 2);
model.geom('geom1').feature('cyl1').set('axistype', 'y');
model.geom('geom1').feature.duplicate('cyl2', 'cyl1');
model.geom('geom1').feature('cyl2').setIndex('pos', 'Lz-Lz1/2', 2);
model.geom('geom1').run('cyl2');
model.geom('geom1').create('dif1', 'Difference');
model.geom('geom1').feature('dif1').selection('input').named('del1');
model.geom('geom1').feature('dif1').selection('input2').set({'cyl1' 'cyl2'});

model.view('view1').set('showgrid', false);

model.geom('geom1').run('dif1');
model.geom('geom1').create('boxsel2', 'BoxSelection');
model.geom('geom1').feature('boxsel2').label('Internal Edges');
model.geom('geom1').feature('boxsel2').set('entitydim', 1);
model.geom('geom1').feature('boxsel2').set('zmin', 'Lz1*0.999');
model.geom('geom1').feature('boxsel2').set('zmax', 'Lz1*1.001');
model.geom('geom1').feature('boxsel2').set('condition', 'inside');
model.geom('geom1').run('boxsel2');
model.geom('geom1').create('cylsel1', 'CylinderSelection');
model.geom('geom1').feature('cylsel1').set('entitydim', 1);
model.geom('geom1').feature('cylsel1').set('r', 'Rhole*1.01');
model.geom('geom1').feature('cylsel1').set('pos', {'Lxy/2' '0' 'Lz1/2'});
model.geom('geom1').feature('cylsel1').set('axistype', 'y');
model.geom('geom1').feature.duplicate('cylsel2', 'cylsel1');
model.geom('geom1').feature('cylsel2').set('pos', {'Lxy/2' '0' 'Lz-Lz1/2'});
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

model.physics('shell').feature('to1').set('d', 'thickness');
model.physics('shell').create('srig1', 'RigidConnectorShell', 1);
model.physics('shell').feature('srig1').selection.named('geom1_cylsel1');
model.physics('shell').feature('srig1').setIndex('Direction', true, 0);
model.physics('shell').feature('srig1').setIndex('Direction', true, 1);
model.physics('shell').feature('srig1').setIndex('Direction', true, 2);
model.physics('shell').feature('srig1').set('RotationType', 'ConstrainedRotationGroup');
model.physics('shell').feature('srig1').setIndex('ConstrainedRotation', true, 2);
model.physics('shell').feature('srig1').setIndex('ConstrainedRotation', true, 0);
model.physics('shell').feature.duplicate('srig2', 'srig1');
model.physics('shell').feature('srig2').selection.named('geom1_cylsel2');
model.physics('shell').feature('srig2').setIndex('Direction', false, 2);
model.physics('shell').feature('srig2').create('rf1', 'RigidBodyForce', -1);
model.physics('shell').feature('srig2').feature('rf1').set('Ft', {'0' '0' '-Fload'});

model.mesh('mesh1').create('edg1', 'Edge');
model.mesh('mesh1').feature('edg1').selection.named('geom1_boxsel2');
model.mesh('mesh1').feature('edg1').create('dis1', 'Distribution');
model.mesh('mesh1').create('map1', 'Map');
model.mesh('mesh1').feature('map1').selection.set([3 4]);
model.mesh('mesh1').feature('map1').create('dis1', 'Distribution');
model.mesh('mesh1').feature('map1').feature('dis1').selection.set([4]);
model.mesh('mesh1').feature('map1').feature('dis1').set('numelem', 20);
model.mesh('mesh1').create('ftri1', 'FreeTri');
model.mesh('mesh1').feature('ftri1').selection.remaining;
model.mesh('mesh1').feature('size').set('hauto', 2);
model.mesh('mesh1').run;

model.massProp.create('mass1', 'MassProperties');
model.massProp('mass1').model('comp1');
model.massProp('mass1').selection.geom('geom1', 2);
model.massProp('mass1').selection.all;
model.massProp('mass1').set('densitySource', 'fromPhysics');

model.study('std1').label('Initial Design');

model.sol.create('sol1');
model.sol('sol1').study('std1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'stat');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').feature('comp1_shell_rig_disp').set('scalemethod', 'manual');
model.sol('sol1').feature('v1').feature('comp1_ar').set('scalemethod', 'manual');
model.sol('sol1').feature('v1').feature('comp1_shell_rig_rot').set('scalemethod', 'manual');
model.sol('sol1').feature('v1').feature('comp1_u').set('scalemethod', 'manual');
model.sol('sol1').feature('v1').feature('comp1_shell_rig_disp').set('resscalemethod', 'parent');
model.sol('sol1').feature('v1').feature('comp1_ar').set('resscalemethod', 'parent');
model.sol('sol1').feature('v1').feature('comp1_shell_rig_rot').set('resscalemethod', 'parent');
model.sol('sol1').feature('v1').feature('comp1_shell_rig_disp').set('scaleval', '0.060004166522000794');
model.sol('sol1').feature('v1').feature('comp1_ar').set('scaleval', '0.01');
model.sol('sol1').feature('v1').feature('comp1_shell_rig_rot').set('scaleval', '0.01');
model.sol('sol1').feature('v1').feature('comp1_u').set('scaleval', '1e-2*6.000416652200079');
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
model.sol('sol1').create('su1', 'StoreSolution');
model.sol('sol1').create('st2', 'StudyStep');
model.sol('sol1').feature('st2').set('study', 'std1');
model.sol('sol1').feature('st2').set('studystep', 'buckling');
model.sol('sol1').create('v2', 'Variables');
model.sol('sol1').feature('v2').feature('comp1_shell_rig_disp').set('scalemethod', 'manual');
model.sol('sol1').feature('v2').feature('comp1_ar').set('scalemethod', 'manual');
model.sol('sol1').feature('v2').feature('comp1_shell_rig_rot').set('scalemethod', 'manual');
model.sol('sol1').feature('v2').feature('comp1_u').set('scalemethod', 'manual');
model.sol('sol1').feature('v2').feature('comp1_shell_rig_disp').set('resscalemethod', 'parent');
model.sol('sol1').feature('v2').feature('comp1_ar').set('resscalemethod', 'parent');
model.sol('sol1').feature('v2').feature('comp1_shell_rig_rot').set('resscalemethod', 'parent');
model.sol('sol1').feature('v2').feature('comp1_shell_rig_disp').set('scaleval', '0.060004166522000794');
model.sol('sol1').feature('v2').feature('comp1_ar').set('scaleval', '0.01');
model.sol('sol1').feature('v2').feature('comp1_shell_rig_rot').set('scaleval', '0.01');
model.sol('sol1').feature('v2').feature('comp1_u').set('scaleval', '1e-2*6.000416652200079');
model.sol('sol1').feature('v2').set('initmethod', 'sol');
model.sol('sol1').feature('v2').set('initsol', 'sol1');
model.sol('sol1').feature('v2').set('initsoluse', 'sol2');
model.sol('sol1').feature('v2').set('notsolmethod', 'sol');
model.sol('sol1').feature('v2').set('notsol', 'sol1');
model.sol('sol1').feature('v2').set('control', 'buckling');
model.sol('sol1').create('e1', 'Eigenvalue');
model.sol('sol1').feature('e1').set('eigvfunscale', 'maximum');
model.sol('sol1').feature('e1').set('eigvfunscaleparam', '6.0E-6');
model.sol('sol1').feature('e1').set('control', 'buckling');
model.sol('sol1').feature('e1').set('linpmethod', 'sol');
model.sol('sol1').feature('e1').set('linpsol', 'sol1');
model.sol('sol1').feature('e1').set('linpsoluse', 'sol2');
model.sol('sol1').feature('e1').set('control', 'buckling');
model.sol('sol1').feature('e1').feature('aDef').set('cachepattern', true);
model.sol('sol1').feature('v2').set('notsolnum', 'auto');
model.sol('sol1').feature('v2').set('notsolvertype', 'solnum');
model.sol('sol1').attach('std1');
model.sol('sol1').runAll;

model.result.dataset('dset1').set('frametype', 'spatial');
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
model.result('pg1').setIndex('looplevel', 1, 0);
model.result('pg1').set('frametype', 'spatial');
model.result('pg1').set('defaultPlotID', 'modeShape');
model.result('pg1').label('Mode Shape (shell)');
model.result('pg1').set('showlegends', false);
model.result('pg1').set('data', 'dset1shellshl');
model.result('pg1').create('surf1', 'Surface');
model.result('pg1').feature('surf1').set('expr', {'shell.disp'});
model.result('pg1').feature('surf1').set('threshold', 'manual');
model.result('pg1').feature('surf1').set('thresholdvalue', 0.2);
model.result('pg1').feature('surf1').set('colortable', 'Rainbow');
model.result('pg1').feature('surf1').set('colortabletrans', 'none');
model.result('pg1').feature('surf1').set('colorscalemode', 'linear');
model.result('pg1').feature('surf1').set('colortable', 'AuroraBorealis');
model.result('pg1').feature('surf1').create('def', 'Deform');
model.result('pg1').feature('surf1').feature('def').set('expr', {'shell.u' 'shell.v' 'shell.w'});
model.result('pg1').run;
model.result.evaluationGroup.create('eg1', 'EvaluationGroup');
model.result.evaluationGroup('eg1').label('Mass and Critical Load Factor');
model.result.evaluationGroup('eg1').create('gev1', 'EvalGlobal');
model.result.evaluationGroup('eg1').feature('gev1').set('expr', {'mass1.mass'});
model.result.evaluationGroup('eg1').feature('gev1').set('descr', {'Mass'});
model.result.evaluationGroup('eg1').feature('gev1').set('expr', {'mass1.mass' 'shell.LFcrit'});
model.result.evaluationGroup('eg1').feature('gev1').set('descr', {'Mass' 'Critical load factor'});
model.result.evaluationGroup('eg1').run;
model.result('pg1').run;
model.result('pg1').label('Mode Shape, Initial Design');

model.param.set('M0', '23.5[kg]');
model.param.descr('M0', 'Initial Mass');

model.study.create('std2');
model.study('std2').create('stat', 'Stationary');
model.study('std2').feature('stat').set('plotgroup', 'Default');
model.study('std2').feature('stat').set('solnum', 'auto');
model.study('std2').feature('stat').set('notsolnum', 'auto');
model.study('std2').feature('stat').set('outputmap', {});
model.study('std2').feature('stat').set('ngenAUX', '1');
model.study('std2').feature('stat').set('goalngenAUX', '1');
model.study('std2').feature('stat').set('ngenAUX', '1');
model.study('std2').feature('stat').set('goalngenAUX', '1');
model.study('std2').feature('stat').setSolveFor('/physics/shell', true);
model.study('std2').create('buckling', 'LinearBuckling');
model.study('std2').feature('buckling').set('plotgroup', 'Default');
model.study('std2').feature('buckling').set('neigsactive', true);
model.study('std2').feature('buckling').set('solnum', 'auto');
model.study('std2').feature('buckling').set('notsolnum', 'auto');
model.study('std2').feature('buckling').set('outputmap', {});
model.study('std2').feature('buckling').set('ngenAUX', '1');
model.study('std2').feature('buckling').set('goalngenAUX', '1');
model.study('std2').feature('buckling').set('ngenAUX', '1');
model.study('std2').feature('buckling').set('goalngenAUX', '1');
model.study('std2').feature('buckling').setSolveFor('/physics/shell', true);
model.study('std2').create('param', 'Parametric');
model.study('std2').feature('param').setIndex('pname', 'Lz', 0);
model.study('std2').feature('param').setIndex('plistarr', '', 0);
model.study('std2').feature('param').setIndex('punit', 'm', 0);
model.study('std2').feature('param').setIndex('pname', 'Lz', 0);
model.study('std2').feature('param').setIndex('plistarr', '', 0);
model.study('std2').feature('param').setIndex('punit', 'm', 0);
model.study('std2').feature('param').setIndex('plistarr', '4 6', 0);
model.study('std2').feature('param').setIndex('punit', 'm', 0);
model.study('std2').label('Optimization');
model.study('std2').create('opt', 'Optimization');
model.study('std2').feature('opt').set('optsolver', 'cobyla');
model.study('std2').feature('opt').setIndex('optobj', 'abs(comp1.shell.LFcrit)', 0);
model.study('std2').feature('opt').setIndex('descr', '', 0);
model.study('std2').feature('opt').set('objectivetype', 'maximization');
model.study('std2').feature('opt').set('objectivesolution', 'min');
model.study('std2').feature('opt').setIndex('pname', 'Lz', 0);
model.study('std2').feature('opt').setIndex('initval', '6[m]', 0);
model.study('std2').feature('opt').setIndex('scale', 1, 0);
model.study('std2').feature('opt').setIndex('lbound', '', 0);
model.study('std2').feature('opt').setIndex('ubound', '', 0);
model.study('std2').feature('opt').setIndex('pname', 'Lz', 0);
model.study('std2').feature('opt').setIndex('initval', '6[m]', 0);
model.study('std2').feature('opt').setIndex('scale', 1, 0);
model.study('std2').feature('opt').setIndex('lbound', '', 0);
model.study('std2').feature('opt').setIndex('ubound', '', 0);
model.study('std2').feature('opt').setIndex('pname', 'Lxy', 1);
model.study('std2').feature('opt').setIndex('initval', '5[cm]', 1);
model.study('std2').feature('opt').setIndex('scale', 1, 1);
model.study('std2').feature('opt').setIndex('lbound', '', 1);
model.study('std2').feature('opt').setIndex('ubound', '', 1);
model.study('std2').feature('opt').setIndex('pname', 'Lxy', 1);
model.study('std2').feature('opt').setIndex('initval', '5[cm]', 1);
model.study('std2').feature('opt').setIndex('scale', 1, 1);
model.study('std2').feature('opt').setIndex('lbound', '', 1);
model.study('std2').feature('opt').setIndex('ubound', '', 1);
model.study('std2').feature('opt').setIndex('pname', '', 0);
model.study('std2').feature('opt').setIndex('initval', '5[cm]', 0);
model.study('std2').feature('opt').setIndex('scale', '5[cm]', 0);
model.study('std2').feature('opt').setIndex('lbound', '1[cm]', 0);
model.study('std2').feature('opt').setIndex('ubound', '20[cm]', 0);
model.study('std2').feature('opt').setIndex('pname', 'thickness', 1);
model.study('std2').feature('opt').setIndex('pname', 'Lxy', 0);
model.study('std2').feature('opt').setIndex('initval', '5[mm]', 1);
model.study('std2').feature('opt').setIndex('scale', '5[mm]', 1);
model.study('std2').feature('opt').setIndex('lbound', '1[mm]', 1);
model.study('std2').feature('opt').setIndex('ubound', '20[mm]', 1);
model.study('std2').feature('opt').set('constraintExpression', {'comp1.mass1.mass'});
model.study('std2').feature('opt').setIndex('constraintExpression', 'comp1.mass1.mass/M0', 0);
model.study('std2').feature('opt').setIndex('constraintUbound', 'Lz/(6[m])', 0);

model.sol.create('sol3');
model.sol('sol3').study('std2');
model.sol('sol3').create('st1', 'StudyStep');
model.sol('sol3').feature('st1').set('study', 'std2');
model.sol('sol3').feature('st1').set('studystep', 'stat');
model.sol('sol3').create('v1', 'Variables');
model.sol('sol3').feature('v1').feature('comp1_shell_rig_disp').set('scalemethod', 'manual');
model.sol('sol3').feature('v1').feature('comp1_ar').set('scalemethod', 'manual');
model.sol('sol3').feature('v1').feature('comp1_shell_rig_rot').set('scalemethod', 'manual');
model.sol('sol3').feature('v1').feature('comp1_u').set('scalemethod', 'manual');
model.sol('sol3').feature('v1').feature('comp1_shell_rig_disp').set('resscalemethod', 'parent');
model.sol('sol3').feature('v1').feature('comp1_ar').set('resscalemethod', 'parent');
model.sol('sol3').feature('v1').feature('comp1_shell_rig_rot').set('resscalemethod', 'parent');
model.sol('sol3').feature('v1').feature('comp1_shell_rig_disp').set('scaleval', '0.060004166522000794');
model.sol('sol3').feature('v1').feature('comp1_ar').set('scaleval', '0.01');
model.sol('sol3').feature('v1').feature('comp1_shell_rig_rot').set('scaleval', '0.01');
model.sol('sol3').feature('v1').feature('comp1_u').set('scaleval', '1e-2*6.000416652200079');
model.sol('sol3').feature('v1').set('control', 'stat');
model.sol('sol3').create('s1', 'Stationary');
model.sol('sol3').feature('s1').feature('aDef').set('cachepattern', true);
model.sol('sol3').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol3').feature('s1').feature('fc1').set('termonres', 'auto');
model.sol('sol3').feature('s1').feature('fc1').set('reserrfact', 1000);
model.sol('sol3').feature('s1').feature('fc1').set('linsolver', 'dDef');
model.sol('sol3').feature('s1').feature('fc1').set('termonres', 'auto');
model.sol('sol3').feature('s1').feature('fc1').set('reserrfact', 1000);
model.sol('sol3').feature('s1').feature.remove('fcDef');
model.sol('sol3').create('su1', 'StoreSolution');
model.sol('sol3').create('st2', 'StudyStep');
model.sol('sol3').feature('st2').set('study', 'std2');
model.sol('sol3').feature('st2').set('studystep', 'buckling');
model.sol('sol3').create('v2', 'Variables');
model.sol('sol3').feature('v2').feature('comp1_shell_rig_disp').set('scalemethod', 'manual');
model.sol('sol3').feature('v2').feature('comp1_ar').set('scalemethod', 'manual');
model.sol('sol3').feature('v2').feature('comp1_shell_rig_rot').set('scalemethod', 'manual');
model.sol('sol3').feature('v2').feature('comp1_u').set('scalemethod', 'manual');
model.sol('sol3').feature('v2').feature('comp1_shell_rig_disp').set('resscalemethod', 'parent');
model.sol('sol3').feature('v2').feature('comp1_ar').set('resscalemethod', 'parent');
model.sol('sol3').feature('v2').feature('comp1_shell_rig_rot').set('resscalemethod', 'parent');
model.sol('sol3').feature('v2').feature('comp1_shell_rig_disp').set('scaleval', '0.060004166522000794');
model.sol('sol3').feature('v2').feature('comp1_ar').set('scaleval', '0.01');
model.sol('sol3').feature('v2').feature('comp1_shell_rig_rot').set('scaleval', '0.01');
model.sol('sol3').feature('v2').feature('comp1_u').set('scaleval', '1e-2*6.000416652200079');
model.sol('sol3').feature('v2').set('initmethod', 'sol');
model.sol('sol3').feature('v2').set('initsol', 'sol3');
model.sol('sol3').feature('v2').set('initsoluse', 'sol4');
model.sol('sol3').feature('v2').set('notsolmethod', 'sol');
model.sol('sol3').feature('v2').set('notsol', 'sol3');
model.sol('sol3').feature('v2').set('control', 'buckling');
model.sol('sol3').create('e1', 'Eigenvalue');
model.sol('sol3').feature('e1').set('eigvfunscale', 'maximum');
model.sol('sol3').feature('e1').set('eigvfunscaleparam', '6.0E-6');
model.sol('sol3').feature('e1').set('control', 'buckling');
model.sol('sol3').feature('e1').set('linpmethod', 'sol');
model.sol('sol3').feature('e1').set('linpsol', 'sol3');
model.sol('sol3').feature('e1').set('linpsoluse', 'sol4');
model.sol('sol3').feature('e1').set('control', 'buckling');
model.sol('sol3').feature('e1').feature('aDef').set('cachepattern', true);
model.sol('sol3').feature('v2').set('notsolnum', 'auto');
model.sol('sol3').feature('v2').set('notsolvertype', 'solnum');
model.sol('sol3').attach('std2');

model.batch.create('o1', 'Optimization');
model.batch('o1').study('std2');
model.batch('p1').study('std2');
model.batch('o1').attach('std2');
model.batch('p1').create('so1', 'Solutionseq');
model.batch('p1').feature('so1').set('seq', 'sol3');
model.batch('p1').feature('so1').set('store', 'on');
model.batch('p1').feature('so1').set('clear', 'on');
model.batch('p1').feature('so1').set('psol', 'none');
model.batch('p1').attach('std2');
model.batch('p1').set('optimization', 'o1');
model.batch('p1').set('err', 'on');
model.batch('p1').set('control', 'opt');
model.batch('o1').set('parametricjobs', {'p1'});
model.batch.create('p2', 'Parametric');
model.batch('p2').study('std2');
model.batch('p2').create('jo1', 'Jobseq');
model.batch('p2').feature('jo1').set('seq', 'o1');
model.batch('p2').set('pname', {'Lz'});
model.batch('p2').set('plistarr', {'4 6'});
model.batch('p2').set('sweeptype', 'sparse');
model.batch('p2').set('err', 'on');
model.batch('p2').attach('std2');
model.batch('p2').set('control', 'param');

model.sol.create('sol5');
model.sol('sol5').study('std2');
model.sol('sol5').label('Parametric Solutions 1');

model.batch('p1').feature('so1').set('psol', 'sol5');
model.batch('p2').run('compute');

model.result.dataset('dset5').set('frametype', 'spatial');
model.result.dataset.create('dset5shellshl', 'Shell');
model.result.dataset('dset5shellshl').set('data', 'dset5');
model.result.dataset('dset5shellshl').setIndex('topconst', '1', 3, 1);
model.result.dataset('dset5shellshl').setIndex('bottomconst', '-1', 3, 1);
model.result.dataset('dset5shellshl').setIndex('orientationexpr', 'shell.nlX', 0);
model.result.dataset('dset5shellshl').setIndex('displacementexpr', 'arx', 0);
model.result.dataset('dset5shellshl').setIndex('orientationexpr', 'shell.nlY', 1);
model.result.dataset('dset5shellshl').setIndex('displacementexpr', 'ary', 1);
model.result.dataset('dset5shellshl').setIndex('orientationexpr', 'shell.nlZ', 2);
model.result.dataset('dset5shellshl').setIndex('displacementexpr', 'arz', 2);
model.result.dataset('dset5shellshl').set('distanceexpr', 'shell.z_pos');
model.result.dataset('dset5shellshl').set('seplevels', false);
model.result.dataset('dset5shellshl').set('resolution', 2);
model.result.dataset('dset5shellshl').set('areascalefactor', 'shell.ASF');
model.result.dataset('dset5shellshl').set('linescalefactor', 'shell.LSF');
model.result.create('pg2', 'PlotGroup3D');
model.result('pg2').set('data', 'dset5shellshl');
model.result('pg2').setIndex('looplevel', 1, 0);
model.result('pg2').setIndex('looplevel', 2, 1);
model.result('pg2').set('frametype', 'spatial');
model.result('pg2').set('defaultPlotID', 'modeShape');
model.result('pg2').label('Mode Shape (shell)');
model.result('pg2').set('showlegends', false);
model.result('pg2').set('data', 'dset5shellshl');
model.result('pg2').create('surf1', 'Surface');
model.result('pg2').feature('surf1').set('expr', {'shell.disp'});
model.result('pg2').feature('surf1').set('threshold', 'manual');
model.result('pg2').feature('surf1').set('thresholdvalue', 0.2);
model.result('pg2').feature('surf1').set('colortable', 'Rainbow');
model.result('pg2').feature('surf1').set('colortabletrans', 'none');
model.result('pg2').feature('surf1').set('colorscalemode', 'linear');
model.result('pg2').feature('surf1').set('colortable', 'AuroraBorealis');
model.result('pg2').feature('surf1').create('def', 'Deform');
model.result('pg2').feature('surf1').feature('def').set('expr', {'shell.u' 'shell.v' 'shell.w'});
model.result('pg2').run;

model.study('std2').feature('opt').set('probewindow', '');

model.result('pg2').label('Mode Shape, Optimization');
model.result('pg2').run;
model.result.evaluationGroup('eg1').feature.duplicate('gev2', 'gev1');
model.result.evaluationGroup('eg1').feature('gev2').set('data', 'dset5');
model.result.evaluationGroup('eg1').run;
model.result.create('pg3', 'PlotGroup3D');
model.result('pg3').run;
model.result('pg3').label('Thumbnail');
model.result('pg3').set('data', 'dset1shellshl');
model.result('pg3').create('surf1', 'Surface');
model.result('pg3').feature('surf1').create('def1', 'Deform');
model.result('pg3').run;
model.result('pg3').run;
model.result('pg3').feature.duplicate('surf2', 'surf1');
model.result('pg3').run;
model.result('pg3').feature('surf2').set('data', 'dset5shellshl');
model.result('pg3').feature('surf2').set('inheritplot', 'surf1');
model.result('pg3').run;
model.result('pg3').create('line1', 'Line');
model.result('pg3').feature('line1').set('data', 'dset5shellshl');
model.result('pg3').feature('line1').set('expr', '1');
model.result('pg3').feature('line1').set('coloring', 'uniform');
model.result('pg3').feature('line1').set('color', 'black');
model.result('pg3').run;
model.result('pg3').feature('surf2').create('trn1', 'Translation');
model.result('pg3').run;
model.result('pg3').feature('surf2').feature('trn1').set('trans', [-0.25 0 0]);
model.result('pg3').feature('surf2').feature('trn1').set('applytodatasetedges', false);
model.result('pg3').run;
model.result('pg3').feature('line1').feature.copy('trn1', 'pg3/surf2/trn1');
model.result('pg3').run;
model.result('pg3').run;

model.title('Maximizing the Buckling Load of a Diagonal Brace');

model.description('Buckling is a common failure mode for slender structural components. This model shows how the buckling load of a diagonal brace can be maximized, while constraining the volume of the brace.');

model.mesh.clearMeshes;

model.sol('sol1').clearSolutionData;
model.sol('sol2').clearSolutionData;
model.sol('sol3').clearSolutionData;
model.sol('sol4').clearSolutionData;
model.sol('sol5').clearSolutionData;
model.sol('sol6').clearSolutionData;
model.sol('sol7').clearSolutionData;

model.label('diagonal_brace_buckling_optimization.mph');

model.modelNode.label('Components');

out = model;
