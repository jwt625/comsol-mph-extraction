function out = model
%
% failure_prediction_in_a_laminated_composite_shell.m
%
% Model exported on May 26 2025, 21:27 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/Composite_Materials_Module/Verification_Examples');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 3);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.physics.create('shell', 'Shell', 'geom1');
model.physics('shell').model('comp1');

model.study.create('std1');
model.study('std1').create('stat', 'Stationary');
model.study('std1').feature('stat').setSolveFor('/physics/shell', true);

% To import content from file, use:
% model.param.loadFile('FILENAME');
model.param.set('th', '0.05e-3[m]', 'Ply thickness');
model.param.set('Ftotal', '15[N]', 'Total edge load');
model.param.set('E1', '207[GPa]', 'Young''s modulus, 11 direction');
model.param.set('E2', '7.6[GPa]', 'Young''s modulus, 22 direction');
model.param.set('nu12', '0.3', 'Poisson''s ratio, 12 direction');
model.param.set('nu23', '0', 'Poisson''s ratio, 23 direction');
model.param.set('G', '5[GPa]', 'Shear modulus');
model.param.set('Sigmats1', '500[MPa]', 'Tensile strength, 11 direction');
model.param.set('Sigmats2', '5[MPa]', 'Tensile strength, 22 direction');
model.param.set('Sigmats3', 'Sigmats2', 'Tensile strength, 33 direction');
model.param.set('Sigmacs1', '350[MPa]', 'Compressive strength, 11 direction');
model.param.set('Sigmacs2', '75[MPa]', 'Compressive strength, 22 direction');
model.param.set('Sigmacs3', 'Sigmacs2', 'Compressive strength, 33 direction');
model.param.set('Sigmass23', '35[MPa]', 'Shear strength, 23 direction');
model.param.set('Sigmass13', 'Sigmass23', 'Shear strength, 13 direction');
model.param.set('Sigmass12', 'Sigmass23', 'Shear strength, 12 direction');

model.material.create('mat1', 'Common', '');
model.material.create('lmat1', 'LayeredMaterial', '');
model.material('lmat1').setIndex('rotation', 90, 0);
model.material('lmat1').setIndex('thickness', 'th', 0);
model.material('lmat1').setIndex('meshPoints', 1, 0);
model.material('lmat1').setIndex('layername', 'Layer 2', 1);
model.material('lmat1').setIndex('link', 'mat1', 1);
model.material('lmat1').setIndex('rotation', 90, 1);
model.material('lmat1').setIndex('thickness', 'th', 1);
model.material('lmat1').setIndex('meshPoints', 1, 1);
model.material('lmat1').setIndex('tag', 'lmat1_2', 1);
model.material('lmat1').setIndex('layername', 'Layer 2', 1);
model.material('lmat1').setIndex('link', 'mat1', 1);
model.material('lmat1').setIndex('rotation', 90, 1);
model.material('lmat1').setIndex('thickness', 'th', 1);
model.material('lmat1').setIndex('meshPoints', 1, 1);
model.material('lmat1').setIndex('tag', 'lmat1_2', 1);
model.material('lmat1').setIndex('layername', 'Layer 3', 2);
model.material('lmat1').setIndex('link', 'mat1', 2);
model.material('lmat1').setIndex('rotation', 90, 2);
model.material('lmat1').setIndex('thickness', 'th', 2);
model.material('lmat1').setIndex('meshPoints', 1, 2);
model.material('lmat1').setIndex('tag', 'lmat1_3', 2);
model.material('lmat1').setIndex('layername', 'Layer 3', 2);
model.material('lmat1').setIndex('link', 'mat1', 2);
model.material('lmat1').setIndex('rotation', 90, 2);
model.material('lmat1').setIndex('thickness', 'th', 2);
model.material('lmat1').setIndex('meshPoints', 1, 2);
model.material('lmat1').setIndex('tag', 'lmat1_3', 2);
model.material('lmat1').setIndex('layername', 'Layer 4', 3);
model.material('lmat1').setIndex('link', 'mat1', 3);
model.material('lmat1').setIndex('rotation', 90, 3);
model.material('lmat1').setIndex('thickness', 'th', 3);
model.material('lmat1').setIndex('meshPoints', 1, 3);
model.material('lmat1').setIndex('tag', 'lmat1_4', 3);
model.material('lmat1').setIndex('layername', 'Layer 4', 3);
model.material('lmat1').setIndex('link', 'mat1', 3);
model.material('lmat1').setIndex('rotation', 90, 3);
model.material('lmat1').setIndex('thickness', 'th', 3);
model.material('lmat1').setIndex('meshPoints', 1, 3);
model.material('lmat1').setIndex('tag', 'lmat1_4', 3);
model.material('lmat1').setIndex('rotation', -45, 1);
model.material('lmat1').setIndex('rotation', 45, 2);
model.material('lmat1').setIndex('rotation', 0, 3);
model.material('lmat1').label('Layered Material: [90/-45/45/0]');
model.material('lmat1').set('widthRatio', 0.4);

model.view('view1').set('showgrid', false);

model.geom('geom1').lengthUnit('mm');
model.geom('geom1').create('wp1', 'WorkPlane');
model.geom('geom1').feature('wp1').set('unite', true);
model.geom('geom1').feature('wp1').geom.create('sq1', 'Square');
model.geom('geom1').feature('wp1').geom.feature('sq1').set('size', 10);
model.geom('geom1').feature('wp1').geom.run('sq1');
model.geom('geom1').run;

model.material.create('llmat1', 'LayeredMaterialLink', 'comp1');

model.physics('shell').prop('ShapeProperty').set('order_displacement', 1);
model.physics('shell').create('llem1', 'LayeredElastic', 2);
model.physics('shell').feature('llem1').selection.set([1]);
model.physics('shell').feature('llem1').set('SolidModel', 'Orthotropic');
model.physics('shell').feature('llem1').set('TransverseIsotropic', true);

model.material('mat1').propertyGroup.create('TransverseIsotropic', 'Transversely_isotropic');
model.material('mat1').propertyGroup('TransverseIsotropic').set('Evect', {'E1' 'E2'});
model.material('mat1').propertyGroup('TransverseIsotropic').set('nuvect', {'nu12' 'nu23'});
model.material('mat1').propertyGroup('TransverseIsotropic').set('Gvect1', {'G'});
model.material('mat1').propertyGroup('def').set('density', {'1500'});

model.physics('shell').feature('llem1').create('lsf1', 'LayeredSafety', 2);
model.physics('shell').feature('llem1').feature('lsf1').label(['Safety: Tsai' native2unicode(hex2dec({'20' '13'}), 'unicode') 'Wu Orthotropic, Plane Stress Criterion']);
model.physics('shell').feature('llem1').feature('lsf1').set('FailureCriterion', 'Tsai-Wu Orthotropic');
model.physics('shell').feature('llem1').feature('lsf1').set('usePlaneStressVersion', true);
model.physics('shell').feature('llem1').feature.duplicate('lsf2', 'lsf1');
model.physics('shell').feature('llem1').feature('lsf2').label('Safety: Hoffman Criterion');
model.physics('shell').feature('llem1').feature('lsf2').set('FailureCriterion', 'Hoffman');
model.physics('shell').feature('llem1').feature.duplicate('lsf3', 'lsf2');
model.physics('shell').feature('llem1').feature('lsf3').label(['Safety: Tsai' native2unicode(hex2dec({'20' '13'}), 'unicode') 'Hill, Plane Stress Criterion']);
model.physics('shell').feature('llem1').feature('lsf3').set('FailureCriterion', 'Tsai-Hill');
model.physics('shell').feature('llem1').feature.duplicate('lsf4', 'lsf3');
model.physics('shell').feature('llem1').feature('lsf4').label(['Safety: Azzi' native2unicode(hex2dec({'20' '13'}), 'unicode') 'Tsai' native2unicode(hex2dec({'20' '13'}), 'unicode') 'Hill Criterion']);
model.physics('shell').feature('llem1').feature('lsf4').set('FailureCriterion', 'Azzi-Tsai-Hill');
model.physics('shell').feature('llem1').feature.duplicate('lsf5', 'lsf4');
model.physics('shell').feature('llem1').feature('lsf5').label('Safety: Norris Criterion');
model.physics('shell').feature('llem1').feature('lsf5').set('FailureCriterion', 'Norris');
model.physics('shell').feature('llem1').feature.duplicate('lsf6', 'lsf5');
model.physics('shell').feature('llem1').feature('lsf6').label(['Safety: Tsai' native2unicode(hex2dec({'20' '13'}), 'unicode') 'Wu Anisotropic Criterion']);
model.physics('shell').feature('llem1').feature('lsf6').set('FailureCriterion', 'Tsai-Wu Anisotropic');

model.material('mat1').propertyGroup.create('OrthotropicStrengthParameters', 'Orthotropic_strength_parameters_in_Voigt_notation');
model.material('mat1').propertyGroup('OrthotropicStrengthParameters').set('sigmats', {'Sigmats1' 'Sigmats2' 'Sigmats3'});
model.material('mat1').propertyGroup('OrthotropicStrengthParameters').set('sigmacs', {'Sigmacs1' 'Sigmacs2' 'Sigmacs3'});
model.material('mat1').propertyGroup('OrthotropicStrengthParameters').set('sigmass', {'Sigmass23' 'Sigmass13' 'Sigmass12'});
model.material('mat1').propertyGroup.create('AnisotropicStrengthParameters', 'Anisotropic_strength_parameters_in_Voigt_notation');
model.material('mat1').propertyGroup('AnisotropicStrengthParameters').set('F_s', {'1/Sigmats1-1/Sigmacs1' '1/Sigmats2-1/Sigmacs2' '1/Sigmats3-1/Sigmacs3' '0' '0' '0'});
model.material('mat1').propertyGroup('AnisotropicStrengthParameters').set('F_f', {'1/(Sigmats1*Sigmacs1)' '-0.5*sqrt(1/((Sigmats1*Sigmacs1)*(Sigmats2*Sigmacs2)))' '1/(Sigmats2*Sigmacs2)' '-0.5*sqrt(1/((Sigmats1*Sigmacs1)*(Sigmats3*Sigmacs3)))' '-0.5*sqrt(1/((Sigmats2*Sigmacs2)*(Sigmats3*Sigmacs3)))' '1/(Sigmats3*Sigmacs3)' '0' '0' '0' '1/Sigmass23^2'  ...
'0' '0' '0' '0' '1/Sigmass13^2' '0' '0' '0' '0' '0'  ...
'1/Sigmass12^2'});

model.physics('shell').create('fix1', 'Fixed', 0);
model.physics('shell').feature('fix1').selection.set([1]);
model.physics('shell').create('disp1', 'Displacement0', 0);
model.physics('shell').feature('disp1').selection.set([2]);
model.physics('shell').feature('disp1').setIndex('Direction', 'prescribed', 0);
model.physics('shell').create('el1', 'EdgeLoad', 1);
model.physics('shell').feature('el1').selection.set([4]);
model.physics('shell').feature('el1').set('LoadTypeForce', 'TotalForce');
model.physics('shell').feature('el1').set('FeTot', {'Ftotal' '0' '0'});

model.mesh('mesh1').create('fq1', 'FreeQuad');
model.mesh('mesh1').feature('fq1').selection.set([1]);
model.mesh('mesh1').feature('fq1').create('dis1', 'Distribution');
model.mesh('mesh1').feature('fq1').feature('dis1').selection.all;
model.mesh('mesh1').feature('fq1').feature('dis1').set('numelem', 1);
model.mesh('mesh1').run;

model.study('std1').setGenPlots(false);

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

model.result.dataset.create('lshl1', 'LayeredMaterial');
model.result.dataset('lshl1').set('scale', 10);
model.result.evaluationGroup.create('eg1', 'EvaluationGroup');
model.result.evaluationGroup('eg1').label('Failure Indices in Ply 1');
model.result.evaluationGroup('eg1').set('data', 'lshl1');
model.result.evaluationGroup('eg1').set('transpose', true);
model.result.evaluationGroup('eg1').create('pev1', 'EvalPoint');
model.result.evaluationGroup('eg1').feature('pev1').selection.set([4]);
model.result.evaluationGroup('eg1').feature('pev1').set('locdef', 'physical');
model.result.evaluationGroup('eg1').feature('pev1').set('localzphys', '0.5*th');
model.result.evaluationGroup('eg1').feature('pev1').set('expr', {'mean(mean(shell.llem1.lsf1.f_i))' 'mean(mean(shell.llem1.lsf2.f_i))' 'mean(mean(shell.llem1.lsf3.f_i))' 'mean(mean(shell.llem1.lsf4.f_i))' 'mean(mean(shell.llem1.lsf5.f_i))' 'mean(mean(shell.llem1.lsf6.f_i))'});
model.result.evaluationGroup('eg1').feature('pev1').set('descr', {'Tsai-Wu orthotropic failure index' 'Hoffman failure index' 'Tsai-Hill failure index, plane stress' 'Azzi-Tsai-Hill failure index' 'Norris failure index' 'Tsai-Wu anisotropic failure index'});
model.result.evaluationGroup('eg1').run;
model.result.evaluationGroup.duplicate('eg2', 'eg1');
model.result.evaluationGroup('eg2').label('Failure Indices in Ply 2');
model.result.evaluationGroup('eg2').feature('pev1').set('localzphys', '1.5*th');
model.result.evaluationGroup('eg2').run;
model.result.evaluationGroup.duplicate('eg3', 'eg2');
model.result.evaluationGroup('eg3').label('Failure Indices in Ply 3');
model.result.evaluationGroup('eg3').feature('pev1').set('localzphys', '2.5*th');
model.result.evaluationGroup('eg3').run;
model.result.evaluationGroup.duplicate('eg4', 'eg3');
model.result.evaluationGroup('eg4').label('Failure Indices in Ply 4');
model.result.evaluationGroup('eg4').feature('pev1').set('localzphys', '3.5*th');
model.result.evaluationGroup('eg4').run;
model.result.evaluationGroup.create('eg5', 'EvaluationGroup');
model.result.evaluationGroup('eg5').label('Safety Factors in Ply 1');
model.result.evaluationGroup('eg5').set('data', 'lshl1');
model.result.evaluationGroup('eg5').set('transpose', true);
model.result.evaluationGroup('eg5').create('pev1', 'EvalPoint');
model.result.evaluationGroup('eg5').feature('pev1').selection.set([4]);
model.result.evaluationGroup('eg5').feature('pev1').set('locdef', 'physical');
model.result.evaluationGroup('eg5').feature('pev1').set('localzphys', '0.5*th');
model.result.evaluationGroup('eg5').feature('pev1').set('expr', {'mean(mean(shell.llem1.lsf1.s_f))' 'mean(mean(shell.llem1.lsf2.s_f))' 'mean(mean(shell.llem1.lsf3.s_f))' 'mean(mean(shell.llem1.lsf4.s_f))' 'mean(mean(shell.llem1.lsf5.s_f))' 'mean(mean(shell.llem1.lsf6.s_f))'});
model.result.evaluationGroup('eg5').feature('pev1').set('descr', {'Tsai-Wu orthotropic safety factor' 'Hoffman safety factor' 'Tsai-Hill safety factor, plane stress' 'Azzi-Tsai-Hill safety factor' 'Norris safety factor' 'Tsai-Wu anisotropic safety factor'});
model.result.evaluationGroup('eg5').run;
model.result.evaluationGroup.duplicate('eg6', 'eg5');
model.result.evaluationGroup('eg6').label('Safety Factors in Ply 2');
model.result.evaluationGroup('eg6').feature('pev1').set('localzphys', '1.5*th');
model.result.evaluationGroup('eg6').run;
model.result.evaluationGroup.duplicate('eg7', 'eg6');
model.result.evaluationGroup('eg7').label('Safety Factors in Ply 3');
model.result.evaluationGroup('eg7').feature('pev1').set('localzphys', '2.5*th');
model.result.evaluationGroup('eg7').run;
model.result.evaluationGroup.duplicate('eg8', 'eg7');
model.result.evaluationGroup('eg8').label('Safety Factors in Ply 4');
model.result.evaluationGroup('eg8').feature('pev1').set('localzphys', '3.5*th');
model.result.evaluationGroup('eg8').run;
model.result.evaluationGroup.create('eg9', 'EvaluationGroup');
model.result.evaluationGroup('eg9').label('Stresses in Ply 1');
model.result.evaluationGroup('eg9').set('data', 'lshl1');
model.result.evaluationGroup('eg9').set('transpose', true);
model.result.evaluationGroup('eg9').create('pev1', 'EvalPoint');
model.result.evaluationGroup('eg9').feature('pev1').selection.set([4]);
model.result.evaluationGroup('eg9').feature('pev1').set('locdef', 'physical');
model.result.evaluationGroup('eg9').feature('pev1').set('localzphys', '0.5*th');
model.result.evaluationGroup('eg9').feature('pev1').set('expr', {'mean(mean(shell.Sll11))' 'mean(mean(shell.Sll22))' 'mean(mean(shell.Sll12))'});
model.result.evaluationGroup('eg9').feature('pev1').set('descr', {'Second Piola-Kirchhoff stress, layer coordinate system, 11 component' 'Second Piola-Kirchhoff stress, layer coordinate system, 22 component' 'Second Piola-Kirchhoff stress, layer coordinate system, 12 component'});
model.result.evaluationGroup('eg9').run;
model.result.evaluationGroup.duplicate('eg10', 'eg9');
model.result.evaluationGroup('eg10').label('Stresses in Ply 2');
model.result.evaluationGroup('eg10').feature('pev1').set('localzphys', '1.5*th');
model.result.evaluationGroup('eg10').run;
model.result.evaluationGroup.duplicate('eg11', 'eg10');
model.result.evaluationGroup('eg11').label('Stresses in Ply 3');
model.result.evaluationGroup('eg11').feature('pev1').set('localzphys', '2.5*th');
model.result.evaluationGroup('eg11').run;
model.result.evaluationGroup.duplicate('eg12', 'eg11');
model.result.evaluationGroup('eg12').label('Stresses in Ply 4');
model.result.evaluationGroup('eg12').feature('pev1').set('localzphys', '3.5*th');
model.result.evaluationGroup('eg12').run;
model.result.create('pg1', 'PlotGroup3D');
model.result('pg1').run;
model.result('pg1').label('von Mises Stress (Ply)');
model.result('pg1').set('titletype', 'manual');
model.result('pg1').set('title', 'Layered Material Slice: von Mises Stress (MPa)');
model.result('pg1').set('legendpos', 'rightdouble');
model.result('pg1').set('plotarrayenable', true);
model.result('pg1').set('arrayaxis', 'z');
model.result('pg1').set('displacementlinear', 'absolute');
model.result('pg1').set('celldisp', '3E4*th');
model.result('pg1').create('lss1', 'LayeredMaterialSlice');
model.result('pg1').feature('lss1').set('arraydim', '1');
model.result('pg1').feature('lss1').label('Ply 1');
model.result('pg1').feature('lss1').set('expr', 'shell.misesGp');
model.result('pg1').feature('lss1').set('descr', 'von Mises stress');
model.result('pg1').feature('lss1').set('expr', 'round(shell.mises)');
model.result('pg1').feature('lss1').set('unit', 'MPa');
model.result('pg1').feature('lss1').set('locdef', 'relative');
model.result('pg1').feature('lss1').set('localzrel', -0.75);
model.result('pg1').feature.duplicate('lss2', 'lss1');
model.result('pg1').feature('lss2').set('arraydim', '1');
model.result('pg1').run;
model.result('pg1').feature('lss2').label('Ply 2');
model.result('pg1').feature('lss2').set('localzrel', -0.25);
model.result('pg1').feature('lss2').set('titletype', 'none');
model.result('pg1').feature('lss2').set('colortable', 'Cyclic');
model.result('pg1').feature.duplicate('lss3', 'lss2');
model.result('pg1').feature('lss3').set('arraydim', '1');
model.result('pg1').run;
model.result('pg1').feature('lss3').label('Ply 3');
model.result('pg1').feature('lss3').set('localzrel', 0.25);
model.result('pg1').feature('lss3').set('colortable', 'Disco');
model.result('pg1').feature.duplicate('lss4', 'lss3');
model.result('pg1').feature('lss4').set('arraydim', '1');
model.result('pg1').run;
model.result('pg1').feature('lss4').label('Ply 4');
model.result('pg1').feature('lss4').set('localzrel', 0.75);
model.result('pg1').feature('lss4').set('colortable', 'ThermalDark');
model.result('pg1').run;

model.view('view1').set('showgrid', true);

model.result('pg1').run;
model.result.duplicate('pg2', 'pg1');
model.result('pg2').run;
model.result('pg2').label('Hoffman Safety Factors (Ply)');
model.result('pg2').set('title', 'Layered Material Slice: Hoffman Safety Factors (1)');
model.result('pg2').feature('lss1').set('arraydim', '1');
model.result('pg2').run;
model.result('pg2').feature('lss1').set('expr', 'shell.llem1.lsf2.s_f');
model.result('pg2').feature('lss1').set('descr', 'Hoffman safety factor');
model.result('pg2').feature('lss2').set('arraydim', '1');
model.result('pg2').run;
model.result('pg2').feature('lss2').set('expr', 'shell.llem1.lsf2.s_f');
model.result('pg2').feature('lss2').set('descr', 'Hoffman safety factor');
model.result('pg2').feature('lss3').set('arraydim', '1');
model.result('pg2').run;
model.result('pg2').feature('lss3').set('expr', 'shell.llem1.lsf2.s_f');
model.result('pg2').feature('lss3').set('descr', 'Hoffman safety factor');
model.result('pg2').feature('lss4').set('arraydim', '1');
model.result('pg2').run;
model.result('pg2').feature('lss4').set('expr', 'shell.llem1.lsf2.s_f');
model.result('pg2').feature('lss4').set('descr', 'Hoffman safety factor');
model.result('pg2').run;
model.result('pg2').run;
model.result.create('pg3', 'PlotGroup3D');
model.result('pg3').run;
model.result('pg3').label('von Mises Stress (Laminate)');
model.result('pg3').set('data', 'lshl1');
model.result('pg3').create('surf1', 'Surface');
model.result('pg3').feature('surf1').set('expr', 'shell.misesGp');
model.result('pg3').feature('surf1').set('descr', 'von Mises stress');
model.result('pg3').feature('surf1').set('unit', 'MPa');
model.result('pg3').feature('surf1').set('colortable', 'RainbowLight');
model.result('pg3').run;
model.result.dataset.create('cpt1', 'CutPoint3D');
model.result.dataset('cpt1').set('pointx', '0.5e-2');
model.result.dataset('cpt1').set('pointy', '0.5e-2');
model.result.dataset('cpt1').set('pointz', 0);
model.result.create('pg4', 'PlotGroup1D');
model.result('pg4').run;
model.result('pg4').label('von Mises Stress at Midpoint (Through-Thickness)');
model.result('pg4').set('data', 'cpt1');
model.result('pg4').set('showlegends', false);
model.result('pg4').create('thr1', 'ThroughThickness');
model.result('pg4').feature('thr1').set('markerpos', 'datapoints');
model.result('pg4').feature('thr1').set('linewidth', 'preference');
model.result('pg4').feature('thr1').set('expr', 'shell.mises');
model.result('pg4').feature('thr1').set('unit', 'MPa');
model.result('pg4').feature('thr1').set('thicknesscoordinateunit', 'mm');
model.result('pg4').run;
model.result('pg2').run;

model.title('Failure Prediction in a Laminated Composite Shell');

model.description(['Laminated composite shells made of carbon fiber reinforced polymer (CFRP) are common in a large variety of applications due to their high strength-to-weight ratio. Evaluation of the structural integrity of a laminated composite shell for a set of applied loads is necessary to make the design of such structures reliable. The structural integrity of a laminate with different fiber orientations in each ply is assessed through the parameters called Failure Index and Safety Factor, using different polynomial failure criteria.' newline  newline 'This example shows how to model laminated composite shells using the Shell interface together with the Composite Materials Module. In this example, six different polynomial criteria are compared. This model is a NAFEMS benchmark model, and the results computed are compared with reference data.']);

model.label('failure_prediction_in_a_laminated_composite_shell.mph');

model.modelNode.label('Components');

out = model;
