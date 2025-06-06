function out = model
%
% frame_with_cutout_plasticity.m
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

model.physics.create('shell', 'Shell', 'geom1');
model.physics('shell').model('comp1');

model.study.create('std1');
model.study('std1').create('stat', 'Stationary');
model.study('std1').feature('stat').setSolveFor('/physics/shell', true);

model.param.set('para', '0');
model.param.descr('para', 'Parameter');

model.func.create('pw1', 'Piecewise');
model.func('pw1').setIndex('pieces', 0, 0, 0);
model.func('pw1').setIndex('pieces', 1, 0, 1);
model.func('pw1').setIndex('pieces', 'x', 0, 2);
model.func('pw1').setIndex('pieces', 1, 1, 0);
model.func('pw1').setIndex('pieces', 2, 1, 1);
model.func('pw1').setIndex('pieces', '2-x', 1, 2);
model.func('pw1').set('argunit', '1');
model.func('pw1').set('fununit', 'N*m');

model.geom('geom1').create('blk1', 'Block');
model.geom('geom1').feature('blk1').set('type', 'surface');
model.geom('geom1').feature('blk1').set('size', [1.1 0.154 0.154]);
model.geom('geom1').feature('blk1').set('base', 'center');
model.geom('geom1').run('blk1');
model.geom('geom1').create('wp1', 'WorkPlane');
model.geom('geom1').feature('wp1').set('unite', true);
model.geom('geom1').feature('wp1').set('planetype', 'faceparallel');
model.geom('geom1').feature('wp1').selection('face').set('blk1', 3);
model.geom('geom1').feature('wp1').geom.create('r1', 'Rectangle');
model.geom('geom1').feature('wp1').geom.feature('r1').set('base', 'center');
model.geom('geom1').feature('wp1').geom.feature('r1').set('size', {'80 [mm]' '100 [mm]'});
model.geom('geom1').feature('wp1').geom.run('r1');
model.geom('geom1').feature('wp1').geom.create('fil1', 'Fillet');
model.geom('geom1').feature('wp1').geom.feature('fil1').selection('pointinsketch').set('r1', [1 2 3 4]);
model.geom('geom1').feature('wp1').geom.feature('fil1').set('radius', '10 [mm]');
model.geom('geom1').run('wp1');
model.geom('geom1').create('dif1', 'Difference');
model.geom('geom1').feature('dif1').selection('input').set({'blk1'});
model.geom('geom1').feature('dif1').selection('input2').set({'wp1'});
model.geom('geom1').run('dif1');
model.geom('geom1').create('del1', 'Delete');
model.geom('geom1').feature('del1').selection('input').set('dif1', [1 6]);
model.geom('geom1').runPre('fin');
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

model.physics('shell').create('llem1', 'LayeredElastic', 2);
model.physics('shell').feature('llem1').selection.all;
model.physics('shell').feature('llem1').create('lplsty1', 'LayeredPlasticity', 2);

model.material('mat1').propertyGroup.create('shell', 'Shell');
model.material('mat1').propertyGroup('shell').set('lth', {'6[mm]'});
model.material('mat1').propertyGroup('ElastoplasticModel').set('sigmags', {'355[MPa]'});
model.material('mat1').propertyGroup('ElastoplasticModel').set('Et', {'100[MPa]'});

model.physics('shell').create('disp1', 'Displacement1', 1);
model.physics('shell').feature('disp1').selection.set([1 2 4 6]);
model.physics('shell').feature('disp1').setIndex('Direction', 'prescribed', 0);
model.physics('shell').feature('disp1').setIndex('Direction', 'prescribed', 1);
model.physics('shell').feature('disp1').setIndex('Direction', 'prescribed', 2);
model.physics('shell').create('srig1', 'RigidConnectorShell', 1);
model.physics('shell').feature('srig1').selection.set([17 18 19 20]);
model.physics('shell').feature('srig1').create('rm1', 'RigidBodyMoment', -1);
model.physics('shell').feature('srig1').feature('rm1').label('Twisting Moment (x)');
model.physics('shell').feature('srig1').feature('rm1').set('Mt', {'9000*pw1(para)' '0' '0'});
model.physics('shell').feature('srig1').feature.duplicate('rm2', 'rm1');
model.physics('shell').feature('srig1').feature('rm2').label('Bending Moment (y)');
model.physics('shell').feature('srig1').feature('rm2').set('Mt', {'0' '60000*pw1(para)' '0'});

model.mesh('mesh1').create('ftri1', 'FreeTri');
model.mesh('mesh1').feature('size').set('custom', true);
model.mesh('mesh1').feature('size').set('hmax', 0.022);
model.mesh('mesh1').feature('size').set('hmin', 2.2E-4);
model.mesh('mesh1').feature('size').set('hgrad', 1.2);
model.mesh('mesh1').feature('size').set('hcurve', 0.2);
model.mesh('mesh1').feature('size').set('hnarrow', 1);
model.mesh('mesh1').feature('ftri1').selection.all;
model.mesh('mesh1').feature('ftri1').create('se1', 'SizeExpression');
model.mesh('mesh1').feature('ftri1').feature('se1').set('sizeexpr', 'if((abs(X)>0.12)||(Y>0),0.022,0.008)');
model.mesh('mesh1').feature('ftri1').feature('se1').set('numcell', 50);
model.mesh('mesh1').run;

model.study('std1').feature('stat').set('useparam', true);
model.study('std1').feature('stat').setIndex('pname', 'para', 0);
model.study('std1').feature('stat').setIndex('plistarr', '', 0);
model.study('std1').feature('stat').setIndex('punit', '', 0);
model.study('std1').feature('stat').setIndex('pname', 'para', 0);
model.study('std1').feature('stat').setIndex('plistarr', '', 0);
model.study('std1').feature('stat').setIndex('punit', '', 0);
model.study('std1').feature('stat').setIndex('plistarr', 'range(0,0.1,2)', 0);
model.study('std1').feature('stat').setIndex('punit', '', 0);

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
model.sol('sol1').feature('v1').feature('comp1_shell_rig_disp').set('scaleval', '0.011213527544889702');
model.sol('sol1').feature('v1').feature('comp1_ar').set('scaleval', '0.01');
model.sol('sol1').feature('v1').feature('comp1_shell_rig_rot').set('scaleval', '0.01');
model.sol('sol1').feature('v1').feature('comp1_u').set('scaleval', '1e-2*1.12135275448897');
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
model.sol('sol1').feature('s1').feature('fc1').set('linsolver', 'dDef');
model.sol('sol1').feature('s1').feature('fc1').set('termonres', 'auto');
model.sol('sol1').feature('s1').feature('fc1').set('reserrfact', 1000);
model.sol('sol1').feature('s1').feature.remove('fcDef');
model.sol('sol1').attach('std1');
model.sol('sol1').runAll;

model.result.dataset.create('dset1shelllshl', 'LayeredMaterial');
model.result.dataset('dset1shelllshl').set('data', 'dset1');
model.result.create('pg1', 'PlotGroup3D');
model.result('pg1').set('data', 'dset1shelllshl');
model.result('pg1').setIndex('looplevel', 21, 0);
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
model.result('pg1').feature('surf1').set('inheritplot', 'none');
model.result('pg1').set('data', 'dset1shelllshl');
model.result('pg1').run;
model.result('pg1').setIndex('looplevel', 11, 0);
model.result('pg1').run;
model.result('pg1').feature('surf1').set('unit', 'MPa');
model.result('pg1').run;
model.result.create('pg2', 'PlotGroup3D');
model.result('pg2').set('data', 'dset1');
model.result('pg2').setIndex('looplevel', 21, 0);
model.result('pg2').set('defaultPlotID', 'stressSlice');
model.result('pg2').set('showlegends', true);
model.result('pg2').set('frametype', 'spatial');
model.result('pg2').create('lss1', 'LayeredMaterialSlice');
model.result('pg2').feature('lss1').set('expr', {'shell.misesGp'});
model.result('pg2').feature('lss1').set('threshold', 'manual');
model.result('pg2').feature('lss1').set('thresholdvalue', 0.2);
model.result('pg2').feature('lss1').set('colortable', 'Prism');
model.result('pg2').feature('lss1').set('colortabletrans', 'none');
model.result('pg2').feature('lss1').set('colorscalemode', 'linear');
model.result('pg2').feature('lss1').set('descr', 'von Mises stress');
model.result('pg2').feature('lss1').set('locdef', 'relative');
model.result('pg2').feature('lss1').set('localzrel', 'shell.z');
model.result('pg2').feature('lss1').create('def', 'Deform');
model.result('pg2').feature('lss1').feature('def').set('expr', {'shell.u' 'shell.v' 'shell.w'});
model.result('pg2').label('Stress, Slice (shell)');
model.result('pg2').label('Stress, Slice (shell)');
model.result('pg2').run;
model.result('pg2').run;
model.result('pg2').feature('lss1').set('unit', 'MPa');
model.result('pg2').run;
model.result('pg2').feature('lss1').feature('def').set('scaleactive', true);
model.result('pg2').feature('lss1').feature('def').set('scale', 10);
model.result('pg2').run;
model.result.create('pg3', 'PlotGroup3D');
model.result('pg3').set('data', 'dset1shelllshl');
model.result('pg3').setIndex('looplevel', 21, 0);
model.result('pg3').label('Equivalent Plastic Strain (shell)');
model.result('pg3').set('defaultPlotID', 'equivalentPlasticStrain');
model.result('pg3').create('surf1', 'Surface');
model.result('pg3').feature('surf1').set('expr', {'shell.epeGp'});
model.result('pg3').feature('surf1').set('inheritplot', 'none');
model.result('pg3').feature('surf1').set('resolution', 'normal');
model.result('pg3').feature('surf1').set('colortabletype', 'discrete');
model.result('pg3').feature('surf1').set('bandcount', 11);
model.result('pg3').feature('surf1').set('colortable', 'AuroraAustralisDark');
model.result('pg3').feature('surf1').set('descractive', true);
model.result('pg3').feature('surf1').set('descr', 'Equivalent plastic strain');
model.result('pg3').label('Equivalent Plastic Strain (shell)');
model.result('pg3').run;
model.result('pg3').run;
model.result('pg3').feature('surf1').set('colortable', 'Rainbow');
model.result('pg3').feature('surf1').set('colortabletype', 'continuous');
model.result('pg3').feature('surf1').create('filt1', 'Filter');
model.result('pg3').run;
model.result('pg3').feature('surf1').feature('filt1').set('expr', 'shell.epeGp>1E-5');
model.result('pg3').run;
model.result('pg3').run;

model.title('Twisting and Bending of a Metal Frame');

model.description('A thin-walled metal frame with a central cutout, modeled using the Shell interface, is subjected to twisting and bending. Around the cutout, the stresses are higher than the yield stress, and the material undergoes plastic deformation. The residual stress and plastic strains after removal of the load are investigated.');

model.mesh.clearMeshes;

model.sol('sol1').clearSolutionData;

model.label('frame_with_cutout_plasticity.mph');

model.modelNode.label('Components');

out = model;
