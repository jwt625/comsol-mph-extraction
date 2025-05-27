function out = model
%
% free_cylinder.m
%
% Model exported on May 26 2025, 21:34 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/Structural_Mechanics_Module/Verification_Examples');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 2);
model.geom('geom1').model('comp1');
model.geom('geom1').axisymmetric(true);

model.mesh.create('mesh1', 'geom1');

model.physics.create('solid', 'SolidMechanics', 'geom1');
model.physics('solid').model('comp1');

model.study.create('std1');
model.study('std1').create('eig', 'Eigenfrequency');
model.study('std1').feature('eig').set('chkeigregion', true);
model.study('std1').feature('eig').set('conrad', '1');
model.study('std1').feature('eig').set('conradynhm', '1');
model.study('std1').feature('eig').set('storefact', false);
model.study('std1').feature('eig').set('solnum', 'auto');
model.study('std1').feature('eig').set('notsolnum', 'auto');
model.study('std1').feature('eig').set('outputmap', {});
model.study('std1').feature('eig').set('ngenAUX', '1');
model.study('std1').feature('eig').set('goalngenAUX', '1');
model.study('std1').feature('eig').set('ngenAUX', '1');
model.study('std1').feature('eig').set('goalngenAUX', '1');
model.study('std1').feature('eig').setSolveFor('/physics/solid', true);

model.common.create('mpf1', 'ParticipationFactors', 'comp1');

model.param.set('height', '10[m]');
model.param.descr('height', 'Height of cylinder');
model.param.set('thic', '0.4[m]');
model.param.descr('thic', 'Thickness of cylinder');
model.param.set('r_in', '1.8[m]');
model.param.descr('r_in', 'Inner radius');

model.geom('geom1').create('r1', 'Rectangle');
model.geom('geom1').feature('r1').set('size', {'thic' 'height'});
model.geom('geom1').feature('r1').set('pos', {'r_in' '0'});
model.geom('geom1').runPre('fin');

model.material.create('mat1', 'Common', '');
model.material('mat1').propertyGroup('def').set('density', '');
model.material('mat1').propertyGroup.create('Enu', 'Young''s_modulus_and_Poisson''s_ratio');
model.material('mat1').propertyGroup('def').set('density', {'8000'});
model.material('mat1').propertyGroup('Enu').set('E', {'2e11'});
model.material('mat1').propertyGroup('Enu').set('nu', {'0.3'});

model.geom('geom1').run;

model.material.create('matlnk1', 'Link', 'comp1');

model.mesh('mesh1').create('map1', 'Map');
model.mesh('mesh1').feature('map1').create('dis1', 'Distribution');
model.mesh('mesh1').feature('map1').feature('dis1').set('numelem', 20);
model.mesh('mesh1').feature('map1').feature('dis1').selection.set([1]);
model.mesh('mesh1').feature('map1').create('dis2', 'Distribution');
model.mesh('mesh1').feature('map1').feature('dis2').set('numelem', 2);
model.mesh('mesh1').feature('map1').feature('dis2').selection.set([2]);
model.mesh('mesh1').run;

model.study('std1').label('Study 1, 2D Axisymmetric Solid');

model.sol.create('sol1');
model.sol('sol1').study('std1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'eig');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').set('control', 'eig');
model.sol('sol1').create('e1', 'Eigenvalue');
model.sol('sol1').feature('e1').set('eigvfunscale', 'maximum');
model.sol('sol1').feature('e1').set('eigvfunscaleparam', '9.999999999999999E-6');
model.sol('sol1').feature('e1').set('control', 'eig');
model.sol('sol1').feature('e1').feature('aDef').set('cachepattern', true);
model.sol('sol1').attach('std1');
model.sol('sol1').runAll;

model.result.create('pg1', 'PlotGroup2D');
model.result('pg1').set('data', 'dset1');
model.result('pg1').setIndex('looplevel', 1, 0);
model.result('pg1').set('defaultPlotID', 'modeShape');
model.result('pg1').label('Mode Shape (solid)');
model.result('pg1').set('showlegends', false);
model.result('pg1').create('surf1', 'Surface');
model.result('pg1').feature('surf1').set('expr', {'solid.disp'});
model.result('pg1').feature('surf1').set('threshold', 'manual');
model.result('pg1').feature('surf1').set('thresholdvalue', 0.2);
model.result('pg1').feature('surf1').set('colortable', 'Rainbow');
model.result('pg1').feature('surf1').set('colortabletrans', 'none');
model.result('pg1').feature('surf1').set('colorscalemode', 'linear');
model.result('pg1').feature('surf1').set('colortable', 'AuroraBorealis');
model.result('pg1').feature('surf1').create('def', 'Deform');
model.result('pg1').feature('surf1').feature('def').set('expr', {'u' 'w'});
model.result('pg1').feature('surf1').feature('def').set('descr', 'Displacement field');
model.result.dataset.create('dset1solidrev', 'Revolve2D');
model.result.dataset('dset1solidrev').set('data', 'dset1');
model.result.dataset('dset1solidrev').set('revangle', 225);
model.result.dataset('dset1solidrev').set('startangle', -90);
model.result.dataset('dset1solidrev').set('hasspacevars', true);
model.result.dataset('dset1solidrev').set('modenumber', 'solid.mk');
model.result.create('pg2', 'PlotGroup3D');
model.result('pg2').set('data', 'dset1solidrev');
model.result('pg2').setIndex('looplevel', 1, 0);
model.result('pg2').set('defaultPlotID', 'modeShape3D');
model.result('pg2').label('Mode Shape, 3D (solid)');
model.result('pg2').set('showlegends', false);
model.result('pg2').create('surf1', 'Surface');
model.result('pg2').feature('surf1').set('expr', {'solid.disp'});
model.result('pg2').feature('surf1').set('threshold', 'manual');
model.result('pg2').feature('surf1').set('thresholdvalue', 0.2);
model.result('pg2').feature('surf1').set('colortable', 'Rainbow');
model.result('pg2').feature('surf1').set('colortabletrans', 'none');
model.result('pg2').feature('surf1').set('colorscalemode', 'linear');
model.result('pg2').feature('surf1').set('colortable', 'AuroraBorealis');
model.result('pg2').feature('surf1').create('def', 'Deform');
model.result.dataset('dset1solidrev').set('hasspacevars', true);
model.result('pg2').feature('surf1').feature('def').set('revcoordsys', 'cylindrical');
model.result('pg2').feature('surf1').feature('def').set('expr', {'u' 'v' 'w'});
model.result('pg2').feature('surf1').feature('def').set('descr', 'Displacement field');
model.result('pg2').feature('surf1').feature('def').set('descractive', true);
model.result.evaluationGroup.create('std1EvgFrq', 'EvaluationGroup');
model.result.evaluationGroup('std1EvgFrq').set('defaultPlotID', 'eigenfrequenciesTable_solid');
model.result.evaluationGroup('std1EvgFrq').set('data', 'dset1');
model.result.evaluationGroup('std1EvgFrq').label('Eigenfrequencies (Study 1, 2D Axisymmetric Solid)');
model.result.evaluationGroup('std1EvgFrq').create('gev1', 'EvalGlobal');
model.result.evaluationGroup('std1EvgFrq').feature('gev1').setIndex('expr', '2*pi*freq', 0);
model.result.evaluationGroup('std1EvgFrq').feature('gev1').setIndex('unit', 'rad/s', 0);
model.result.evaluationGroup('std1EvgFrq').feature('gev1').setIndex('descr', 'Angular frequency', 0);
model.result.evaluationGroup('std1EvgFrq').feature('gev1').setIndex('expr', 'imag(freq)/abs(freq)', 1);
model.result.evaluationGroup('std1EvgFrq').feature('gev1').setIndex('unit', '1', 1);
model.result.evaluationGroup('std1EvgFrq').feature('gev1').setIndex('descr', 'Damping ratio', 1);
model.result.evaluationGroup('std1EvgFrq').feature('gev1').setIndex('expr', 'abs(freq)/imag(freq)/2', 2);
model.result.evaluationGroup('std1EvgFrq').feature('gev1').setIndex('unit', '1', 2);
model.result.evaluationGroup('std1EvgFrq').feature('gev1').setIndex('descr', 'Quality factor', 2);
model.result.evaluationGroup('std1EvgFrq').run;
model.result.evaluationGroup.create('std1mpf1', 'EvaluationGroup');
model.result.evaluationGroup('std1mpf1').set('data', 'dset1');
model.result.evaluationGroup('std1mpf1').label('Participation Factors (Study 1, 2D Axisymmetric Solid)');
model.result.evaluationGroup('std1mpf1').create('gev1', 'EvalGlobal');
model.result.evaluationGroup('std1mpf1').feature('gev1').setIndex('expr', 'mpf1.pfLnormR', 0);
model.result.evaluationGroup('std1mpf1').feature('gev1').setIndex('unit', '1', 0);
model.result.evaluationGroup('std1mpf1').feature('gev1').setIndex('descr', 'Participation factor, normalized, R-translation', 0);
model.result.evaluationGroup('std1mpf1').feature('gev1').setIndex('expr', 'mpf1.pfLnormZ', 1);
model.result.evaluationGroup('std1mpf1').feature('gev1').setIndex('unit', '1', 1);
model.result.evaluationGroup('std1mpf1').feature('gev1').setIndex('descr', 'Participation factor, normalized, Z-translation', 1);
model.result.evaluationGroup('std1mpf1').feature('gev1').setIndex('expr', 'mpf1.pfRnormZ', 2);
model.result.evaluationGroup('std1mpf1').feature('gev1').setIndex('unit', '1', 2);
model.result.evaluationGroup('std1mpf1').feature('gev1').setIndex('descr', 'Participation factor, normalized, Z-rotation', 2);
model.result.evaluationGroup('std1mpf1').feature('gev1').setIndex('expr', 'mpf1.mEffLR', 3);
model.result.evaluationGroup('std1mpf1').feature('gev1').setIndex('unit', 'kg', 3);
model.result.evaluationGroup('std1mpf1').feature('gev1').setIndex('descr', 'Effective modal mass, R-translation', 3);
model.result.evaluationGroup('std1mpf1').feature('gev1').setIndex('expr', 'mpf1.mEffLZ', 4);
model.result.evaluationGroup('std1mpf1').feature('gev1').setIndex('unit', 'kg', 4);
model.result.evaluationGroup('std1mpf1').feature('gev1').setIndex('descr', 'Effective modal mass, Z-translation', 4);
model.result.evaluationGroup('std1mpf1').feature('gev1').setIndex('expr', 'mpf1.mEffRZ', 5);
model.result.evaluationGroup('std1mpf1').feature('gev1').setIndex('unit', 'kg*m^2', 5);
model.result.evaluationGroup('std1mpf1').feature('gev1').setIndex('descr', 'Effective modal mass, Z-rotation', 5);
model.result.evaluationGroup('std1mpf1').run;
model.result('pg1').run;
model.result('pg2').run;
model.result('pg2').set('looplevel', [2]);

model.view('view2').set('showgrid', false);

model.result('pg2').run;

model.physics.create('shell', 'Shell', 'geom1');
model.physics('shell').model('comp1');

model.study('std1').feature('eig').setSolveFor('/physics/shell', true);

model.physics('shell').selection.set([1]);
model.physics('shell').feature('to1').set('d', 'thic');
model.physics('shell').feature('to1').set('OffsetDefinition', 'top');

model.material.create('matlnk2', 'Link', 'comp1');
model.material('matlnk2').selection.geom('geom1', 1);
model.material('matlnk2').selection.set([1]);

model.study.create('std2');
model.study('std2').create('eig', 'Eigenfrequency');
model.study('std2').feature('eig').set('plotgroup', 'Default');
model.study('std2').feature('eig').set('chkeigregion', true);
model.study('std2').feature('eig').set('conrad', '1');
model.study('std2').feature('eig').set('conradynhm', '1');
model.study('std2').feature('eig').set('storefact', false);
model.study('std2').feature('eig').set('solnum', 'auto');
model.study('std2').feature('eig').set('notsolnum', 'auto');
model.study('std2').feature('eig').set('outputmap', {});
model.study('std2').feature('eig').set('ngenAUX', '1');
model.study('std2').feature('eig').set('goalngenAUX', '1');
model.study('std2').feature('eig').set('ngenAUX', '1');
model.study('std2').feature('eig').set('goalngenAUX', '1');
model.study('std2').feature('eig').setSolveFor('/physics/solid', false);
model.study('std2').feature('eig').setSolveFor('/physics/shell', true);
model.study('std2').label('Study 2, 2D Axisymmetric Shell');

model.sol.create('sol2');
model.sol('sol2').study('std2');
model.sol('sol2').create('st1', 'StudyStep');
model.sol('sol2').feature('st1').set('study', 'std2');
model.sol('sol2').feature('st1').set('studystep', 'eig');
model.sol('sol2').create('v1', 'Variables');
model.sol('sol2').feature('v1').feature('comp1_ar').set('scalemethod', 'manual');
model.sol('sol2').feature('v1').feature('comp1_ar').set('resscalemethod', 'parent');
model.sol('sol2').feature('v1').feature('comp1_ar').set('scaleval', '0.01');
model.sol('sol2').feature('v1').set('control', 'eig');
model.sol('sol2').create('e1', 'Eigenvalue');
model.sol('sol2').feature('e1').set('eigvfunscale', 'maximum');
model.sol('sol2').feature('e1').set('eigvfunscaleparam', '9.999999999999999E-6');
model.sol('sol2').feature('e1').set('control', 'eig');
model.sol('sol2').feature('e1').feature('aDef').set('cachepattern', true);
model.sol('sol2').attach('std2');
model.sol('sol2').runAll;

model.result.dataset.create('dset2shellshl', 'Shell');
model.result.dataset('dset2shellshl').set('data', 'dset2');
model.result.dataset('dset2shellshl').setIndex('topconst', '1', 6, 1);
model.result.dataset('dset2shellshl').setIndex('bottomconst', '-1', 6, 1);
model.result.dataset('dset2shellshl').setIndex('orientation2expr', 'shell.nlR', 0);
model.result.dataset('dset2shellshl').setIndex('displacement2expr', 'arr', 0);
model.result.dataset('dset2shellshl').setIndex('orientation2expr', 'shell.nlZ', 1);
model.result.dataset('dset2shellshl').setIndex('displacement2expr', 'arz', 1);
model.result.dataset('dset2shellshl').set('distanceexpr', 'shell.z_pos');
model.result.dataset('dset2shellshl').set('seplevels', false);
model.result.dataset('dset2shellshl').set('resolution', 2);
model.result.dataset('dset2shellshl').set('areascalefactor', 'shell.ASF');
model.result.dataset('dset2shellshl').set('linescalefactor', 'shell.LSF');
model.result.create('pg3', 'PlotGroup2D');
model.result('pg3').set('data', 'dset2shellshl');
model.result('pg3').setIndex('looplevel', 1, 0);
model.result('pg3').set('defaultPlotID', 'modeShape');
model.result('pg3').label('Mode Shape (shell)');
model.result('pg3').set('showlegends', false);
model.result('pg3').set('data', 'dset2shellshl');
model.result('pg3').create('surf1', 'Surface');
model.result('pg3').feature('surf1').set('expr', {'shell.disp'});
model.result('pg3').feature('surf1').set('threshold', 'manual');
model.result('pg3').feature('surf1').set('thresholdvalue', 0.2);
model.result('pg3').feature('surf1').set('colortable', 'Rainbow');
model.result('pg3').feature('surf1').set('colortabletrans', 'none');
model.result('pg3').feature('surf1').set('colorscalemode', 'linear');
model.result('pg3').feature('surf1').set('colortable', 'AuroraBorealis');
model.result('pg3').feature('surf1').create('def', 'Deform');
model.result('pg3').feature('surf1').feature('def').set('expr', {'shell.u' 'shell.w'});
model.result.dataset.create('dset2shellrev', 'Revolve2D');
model.result.dataset('dset2shellrev').set('data', 'dset2shellshl');
model.result.dataset('dset2shellrev').set('revangle', 225);
model.result.dataset('dset2shellrev').set('startangle', -90);
model.result.dataset('dset2shellrev').set('hasspacevars', true);
model.result.create('pg4', 'PlotGroup3D');
model.result('pg4').set('data', 'dset2shellrev');
model.result('pg4').setIndex('looplevel', 1, 0);
model.result('pg4').set('defaultPlotID', 'modeShape3D');
model.result('pg4').label('Mode Shape, 3D (shell)');
model.result('pg4').set('showlegends', false);
model.result.dataset('dset2shellrev').set('modenumber', 'shell.mk');
model.result('pg4').set('data', 'dset2shellrev');
model.result('pg4').create('surf1', 'Surface');
model.result('pg4').feature('surf1').set('expr', {'shell.disp'});
model.result('pg4').feature('surf1').set('threshold', 'manual');
model.result('pg4').feature('surf1').set('thresholdvalue', 0.2);
model.result('pg4').feature('surf1').set('colortable', 'Rainbow');
model.result('pg4').feature('surf1').set('colortabletrans', 'none');
model.result('pg4').feature('surf1').set('colorscalemode', 'linear');
model.result('pg4').feature('surf1').set('colortable', 'AuroraBorealis');
model.result('pg4').feature('surf1').create('def', 'Deform');
model.result('pg4').feature('surf1').feature('def').set('revcoordsys', 'cylindrical');
model.result('pg4').feature('surf1').feature('def').set('expr', {'shell.u' 'shell.v' 'shell.w'});
model.result.evaluationGroup.create('std2EvgFrq', 'EvaluationGroup');
model.result.evaluationGroup('std2EvgFrq').set('defaultPlotID', 'eigenfrequenciesTable_shell');
model.result.evaluationGroup('std2EvgFrq').set('data', 'dset2');
model.result.evaluationGroup('std2EvgFrq').label('Eigenfrequencies (Study 2, 2D Axisymmetric Shell)');
model.result.evaluationGroup('std2EvgFrq').create('gev1', 'EvalGlobal');
model.result.evaluationGroup('std2EvgFrq').feature('gev1').setIndex('expr', '2*pi*freq', 0);
model.result.evaluationGroup('std2EvgFrq').feature('gev1').setIndex('unit', 'rad/s', 0);
model.result.evaluationGroup('std2EvgFrq').feature('gev1').setIndex('descr', 'Angular frequency', 0);
model.result.evaluationGroup('std2EvgFrq').feature('gev1').setIndex('expr', 'imag(freq)/abs(freq)', 1);
model.result.evaluationGroup('std2EvgFrq').feature('gev1').setIndex('unit', '1', 1);
model.result.evaluationGroup('std2EvgFrq').feature('gev1').setIndex('descr', 'Damping ratio', 1);
model.result.evaluationGroup('std2EvgFrq').feature('gev1').setIndex('expr', 'abs(freq)/imag(freq)/2', 2);
model.result.evaluationGroup('std2EvgFrq').feature('gev1').setIndex('unit', '1', 2);
model.result.evaluationGroup('std2EvgFrq').feature('gev1').setIndex('descr', 'Quality factor', 2);
model.result.evaluationGroup('std2EvgFrq').run;
model.result.evaluationGroup.create('std2mpf1', 'EvaluationGroup');
model.result.evaluationGroup('std2mpf1').set('data', 'dset2');
model.result.evaluationGroup('std2mpf1').label('Participation Factors (Study 2, 2D Axisymmetric Shell)');
model.result.evaluationGroup('std2mpf1').create('gev1', 'EvalGlobal');
model.result.evaluationGroup('std2mpf1').feature('gev1').setIndex('expr', 'mpf1.pfLnormR', 0);
model.result.evaluationGroup('std2mpf1').feature('gev1').setIndex('unit', '1', 0);
model.result.evaluationGroup('std2mpf1').feature('gev1').setIndex('descr', 'Participation factor, normalized, R-translation', 0);
model.result.evaluationGroup('std2mpf1').feature('gev1').setIndex('expr', 'mpf1.pfLnormZ', 1);
model.result.evaluationGroup('std2mpf1').feature('gev1').setIndex('unit', '1', 1);
model.result.evaluationGroup('std2mpf1').feature('gev1').setIndex('descr', 'Participation factor, normalized, Z-translation', 1);
model.result.evaluationGroup('std2mpf1').feature('gev1').setIndex('expr', 'mpf1.pfRnormZ', 2);
model.result.evaluationGroup('std2mpf1').feature('gev1').setIndex('unit', '1', 2);
model.result.evaluationGroup('std2mpf1').feature('gev1').setIndex('descr', 'Participation factor, normalized, Z-rotation', 2);
model.result.evaluationGroup('std2mpf1').feature('gev1').setIndex('expr', 'mpf1.mEffLR', 3);
model.result.evaluationGroup('std2mpf1').feature('gev1').setIndex('unit', 'kg', 3);
model.result.evaluationGroup('std2mpf1').feature('gev1').setIndex('descr', 'Effective modal mass, R-translation', 3);
model.result.evaluationGroup('std2mpf1').feature('gev1').setIndex('expr', 'mpf1.mEffLZ', 4);
model.result.evaluationGroup('std2mpf1').feature('gev1').setIndex('unit', 'kg', 4);
model.result.evaluationGroup('std2mpf1').feature('gev1').setIndex('descr', 'Effective modal mass, Z-translation', 4);
model.result.evaluationGroup('std2mpf1').feature('gev1').setIndex('expr', 'mpf1.mEffRZ', 5);
model.result.evaluationGroup('std2mpf1').feature('gev1').setIndex('unit', 'kg*m^2', 5);
model.result.evaluationGroup('std2mpf1').feature('gev1').setIndex('descr', 'Effective modal mass, Z-rotation', 5);
model.result.evaluationGroup('std2mpf1').run;
model.result('pg3').run;
model.result('pg4').run;
model.result('pg4').set('looplevel', [2]);

model.view('view3').set('showgrid', false);

model.result('pg4').run;

model.modelNode.create('comp2', true);

model.geom.create('geom2', 3);
model.geom('geom2').model('comp2');

model.mesh.create('mesh2', 'geom2');

model.geom('geom2').create('wp1', 'WorkPlane');
model.geom('geom2').feature('wp1').set('unite', true);
model.geom('geom2').feature('wp1').set('quickplane', 'xz');
model.geom('geom2').feature('wp1').geom.feature.copy('r1', 'geom1/r1');
model.geom('geom2').run('wp1');
model.geom('geom2').feature.create('rev1', 'Revolve');
model.geom('geom2').feature('rev1').set('workplane', 'wp1');
model.geom('geom2').feature('rev1').selection('input').set({'wp1'});
model.geom('geom2').feature('rev1').set('angtype', 'specang');
model.geom('geom2').feature('rev1').set('angle2', 15);
model.geom('geom2').runPre('fin');

model.physics.create('solid2', 'SolidMechanics', 'geom2');
model.physics('solid2').model('comp2');

model.study('std1').feature('eig').setSolveFor('/physics/solid2', true);
model.study('std2').feature('eig').setSolveFor('/physics/solid2', true);

model.geom('geom2').run;

model.physics('solid2').create('pc1', 'PeriodicCondition', 2);
model.physics('solid2').feature('pc1').selection.set([2 5]);
model.physics('solid2').feature('pc1').set('PeriodicType', 'CyclicSymmetry');

model.mesh('mesh2').create('map1', 'Map');
model.mesh('mesh2').feature('map1').selection.set([3]);
model.mesh('mesh2').feature('map1').create('dis1', 'Distribution');
model.mesh('mesh2').feature('map1').feature('dis1').set('numelem', 2);
model.mesh('mesh2').feature('map1').feature('dis1').selection.set([2 7]);
model.mesh('mesh2').run('map1');
model.mesh('mesh2').create('swe1', 'Sweep');
model.mesh('mesh2').feature('swe1').create('dis1', 'Distribution');
model.mesh('mesh2').feature('swe1').feature('dis1').set('numelem', 20);
model.mesh('mesh2').run;

model.material.create('matlnk3', 'Link', 'comp2');

model.study.create('std3');
model.study('std3').create('eig', 'Eigenfrequency');
model.study('std3').feature('eig').set('plotgroup', 'Default');
model.study('std3').feature('eig').set('chkeigregion', true);
model.study('std3').feature('eig').set('conrad', '1');
model.study('std3').feature('eig').set('conradynhm', '1');
model.study('std3').feature('eig').set('storefact', false);
model.study('std3').feature('eig').set('solnum', 'auto');
model.study('std3').feature('eig').set('notsolnum', 'auto');
model.study('std3').feature('eig').set('outputmap', {});
model.study('std3').feature('eig').set('ngenAUX', '1');
model.study('std3').feature('eig').set('goalngenAUX', '1');
model.study('std3').feature('eig').set('ngenAUX', '1');
model.study('std3').feature('eig').set('goalngenAUX', '1');
model.study('std3').feature('eig').setSolveFor('/physics/solid', false);
model.study('std3').feature('eig').setSolveFor('/physics/shell', false);
model.study('std3').feature('eig').setSolveFor('/physics/solid2', true);

model.common.create('mpf2', 'ParticipationFactors', 'comp2');

model.study('std3').label('Study 3, 3D Solid Sector');
model.study('std3').feature('eig').set('neigsactive', true);
model.study('std3').feature('eig').set('neigs', 10);

model.sol.create('sol3');
model.sol('sol3').study('std3');
model.sol('sol3').create('st1', 'StudyStep');
model.sol('sol3').feature('st1').set('study', 'std3');
model.sol('sol3').feature('st1').set('studystep', 'eig');
model.sol('sol3').create('v1', 'Variables');
model.sol('sol3').feature('v1').set('control', 'eig');
model.sol('sol3').create('e1', 'Eigenvalue');
model.sol('sol3').feature('e1').set('eigvfunscale', 'maximum');
model.sol('sol3').feature('e1').set('eigvfunscaleparam', '9.999999999999999E-6');
model.sol('sol3').feature('e1').set('control', 'eig');
model.sol('sol3').feature('e1').feature('aDef').set('cachepattern', true);
model.sol('sol3').attach('std3');
model.sol('sol3').runAll;

model.result.create('pg5', 'PlotGroup3D');
model.result('pg5').set('data', 'dset4');
model.result('pg5').setIndex('looplevel', 1, 0);
model.result('pg5').set('defaultPlotID', 'modeShape');
model.result('pg5').label('Mode Shape (solid2)');
model.result('pg5').set('showlegends', false);
model.result('pg5').create('surf1', 'Surface');
model.result('pg5').feature('surf1').set('expr', {'solid2.disp'});
model.result('pg5').feature('surf1').set('threshold', 'manual');
model.result('pg5').feature('surf1').set('thresholdvalue', 0.2);
model.result('pg5').feature('surf1').set('colortable', 'Rainbow');
model.result('pg5').feature('surf1').set('colortabletrans', 'none');
model.result('pg5').feature('surf1').set('colorscalemode', 'linear');
model.result('pg5').feature('surf1').set('colortable', 'AuroraBorealis');
model.result('pg5').feature('surf1').create('def', 'Deform');
model.result('pg5').feature('surf1').feature('def').set('expr', {'u3' 'v3' 'w3'});
model.result('pg5').feature('surf1').feature('def').set('descr', 'Displacement field');
model.result.evaluationGroup.create('std3EvgFrq', 'EvaluationGroup');
model.result.evaluationGroup('std3EvgFrq').set('defaultPlotID', 'eigenfrequenciesTable_solid2');
model.result.evaluationGroup('std3EvgFrq').set('data', 'dset4');
model.result.evaluationGroup('std3EvgFrq').label('Eigenfrequencies (Study 3, 3D Solid Sector)');
model.result.evaluationGroup('std3EvgFrq').create('gev1', 'EvalGlobal');
model.result.evaluationGroup('std3EvgFrq').feature('gev1').setIndex('expr', '2*pi*freq', 0);
model.result.evaluationGroup('std3EvgFrq').feature('gev1').setIndex('unit', 'rad/s', 0);
model.result.evaluationGroup('std3EvgFrq').feature('gev1').setIndex('descr', 'Angular frequency', 0);
model.result.evaluationGroup('std3EvgFrq').feature('gev1').setIndex('expr', 'imag(freq)/abs(freq)', 1);
model.result.evaluationGroup('std3EvgFrq').feature('gev1').setIndex('unit', '1', 1);
model.result.evaluationGroup('std3EvgFrq').feature('gev1').setIndex('descr', 'Damping ratio', 1);
model.result.evaluationGroup('std3EvgFrq').feature('gev1').setIndex('expr', 'abs(freq)/imag(freq)/2', 2);
model.result.evaluationGroup('std3EvgFrq').feature('gev1').setIndex('unit', '1', 2);
model.result.evaluationGroup('std3EvgFrq').feature('gev1').setIndex('descr', 'Quality factor', 2);
model.result.evaluationGroup('std3EvgFrq').run;
model.result.evaluationGroup.create('std3mpf2', 'EvaluationGroup');
model.result.evaluationGroup('std3mpf2').set('data', 'dset4');
model.result.evaluationGroup('std3mpf2').label('Participation Factors (Study 3, 3D Solid Sector)');
model.result.evaluationGroup('std3mpf2').create('gev1', 'EvalGlobal');
model.result.evaluationGroup('std3mpf2').feature('gev1').setIndex('expr', 'mpf2.pfLnormX', 0);
model.result.evaluationGroup('std3mpf2').feature('gev1').setIndex('unit', '1', 0);
model.result.evaluationGroup('std3mpf2').feature('gev1').setIndex('descr', 'Participation factor, normalized, X-translation', 0);
model.result.evaluationGroup('std3mpf2').feature('gev1').setIndex('expr', 'mpf2.pfLnormY', 1);
model.result.evaluationGroup('std3mpf2').feature('gev1').setIndex('unit', '1', 1);
model.result.evaluationGroup('std3mpf2').feature('gev1').setIndex('descr', 'Participation factor, normalized, Y-translation', 1);
model.result.evaluationGroup('std3mpf2').feature('gev1').setIndex('expr', 'mpf2.pfLnormZ', 2);
model.result.evaluationGroup('std3mpf2').feature('gev1').setIndex('unit', '1', 2);
model.result.evaluationGroup('std3mpf2').feature('gev1').setIndex('descr', 'Participation factor, normalized, Z-translation', 2);
model.result.evaluationGroup('std3mpf2').feature('gev1').setIndex('expr', 'mpf2.pfRnormX', 3);
model.result.evaluationGroup('std3mpf2').feature('gev1').setIndex('unit', '1', 3);
model.result.evaluationGroup('std3mpf2').feature('gev1').setIndex('descr', 'Participation factor, normalized, X-rotation', 3);
model.result.evaluationGroup('std3mpf2').feature('gev1').setIndex('expr', 'mpf2.pfRnormY', 4);
model.result.evaluationGroup('std3mpf2').feature('gev1').setIndex('unit', '1', 4);
model.result.evaluationGroup('std3mpf2').feature('gev1').setIndex('descr', 'Participation factor, normalized, Y-rotation', 4);
model.result.evaluationGroup('std3mpf2').feature('gev1').setIndex('expr', 'mpf2.pfRnormZ', 5);
model.result.evaluationGroup('std3mpf2').feature('gev1').setIndex('unit', '1', 5);
model.result.evaluationGroup('std3mpf2').feature('gev1').setIndex('descr', 'Participation factor, normalized, Z-rotation', 5);
model.result.evaluationGroup('std3mpf2').feature('gev1').setIndex('expr', 'mpf2.mEffLX', 6);
model.result.evaluationGroup('std3mpf2').feature('gev1').setIndex('unit', 'kg', 6);
model.result.evaluationGroup('std3mpf2').feature('gev1').setIndex('descr', 'Effective modal mass, X-translation', 6);
model.result.evaluationGroup('std3mpf2').feature('gev1').setIndex('expr', 'mpf2.mEffLY', 7);
model.result.evaluationGroup('std3mpf2').feature('gev1').setIndex('unit', 'kg', 7);
model.result.evaluationGroup('std3mpf2').feature('gev1').setIndex('descr', 'Effective modal mass, Y-translation', 7);
model.result.evaluationGroup('std3mpf2').feature('gev1').setIndex('expr', 'mpf2.mEffLZ', 8);
model.result.evaluationGroup('std3mpf2').feature('gev1').setIndex('unit', 'kg', 8);
model.result.evaluationGroup('std3mpf2').feature('gev1').setIndex('descr', 'Effective modal mass, Z-translation', 8);
model.result.evaluationGroup('std3mpf2').feature('gev1').setIndex('expr', 'mpf2.mEffRX', 9);
model.result.evaluationGroup('std3mpf2').feature('gev1').setIndex('unit', 'kg*m^2', 9);
model.result.evaluationGroup('std3mpf2').feature('gev1').setIndex('descr', 'Effective modal mass, X-rotation', 9);
model.result.evaluationGroup('std3mpf2').feature('gev1').setIndex('expr', 'mpf2.mEffRY', 10);
model.result.evaluationGroup('std3mpf2').feature('gev1').setIndex('unit', 'kg*m^2', 10);
model.result.evaluationGroup('std3mpf2').feature('gev1').setIndex('descr', 'Effective modal mass, Y-rotation', 10);
model.result.evaluationGroup('std3mpf2').feature('gev1').setIndex('expr', 'mpf2.mEffRZ', 11);
model.result.evaluationGroup('std3mpf2').feature('gev1').setIndex('unit', 'kg*m^2', 11);
model.result.evaluationGroup('std3mpf2').feature('gev1').setIndex('descr', 'Effective modal mass, Z-rotation', 11);
model.result.evaluationGroup('std3mpf2').run;
model.result('pg5').run;
model.result('pg5').set('looplevel', [4]);
model.result('pg5').run;
model.result.dataset.create('sec1', 'Sector3D');
model.result.dataset('sec1').set('sectors', '360/15');
model.result.dataset('sec1').set('include', 'manual');
model.result.dataset('sec1').set('startsector', 18);
model.result.dataset('sec1').set('sectorsinclude', 15);
model.result('pg5').run;
model.result('pg5').set('data', 'sec1');
model.result('pg5').run;

model.view('view6').set('showgrid', false);

model.result('pg5').set('looplevel', [3]);
model.result('pg5').run;

model.physics.create('shell2', 'Shell', 'geom2');
model.physics('shell2').model('comp2');

model.study('std1').feature('eig').setSolveFor('/physics/shell2', true);
model.study('std2').feature('eig').setSolveFor('/physics/shell2', true);
model.study('std3').feature('eig').setSolveFor('/physics/shell2', true);

model.physics('shell2').selection.set([1]);
model.physics('shell2').feature('to1').set('d', 'thic');
model.physics('shell2').feature('to1').set('OffsetDefinition', 'top');

model.coordSystem.create('sys3', 'geom2', 'Cylindrical');

model.physics('shell2').create('pc1', 'PeriodicCondition', 1);
model.physics('shell2').feature('pc1').selection.set([1 6]);
model.physics('shell2').feature('pc1').set('PeriodicType', 'CyclicSymmetry');
model.physics('shell2').feature('pc1').set('thetaS', '15[deg]');
model.physics('shell2').feature('pc1').set('TransformationMethod', 'sys3');

model.material.create('matlnk4', 'Link', 'comp2');
model.material('matlnk4').selection.geom('geom2', 2);
model.material('matlnk4').selection.set([1]);

model.study.create('std4');
model.study('std4').create('eig', 'Eigenfrequency');
model.study('std4').feature('eig').set('plotgroup', 'Default');
model.study('std4').feature('eig').set('chkeigregion', true);
model.study('std4').feature('eig').set('conrad', '1');
model.study('std4').feature('eig').set('conradynhm', '1');
model.study('std4').feature('eig').set('storefact', false);
model.study('std4').feature('eig').set('solnum', 'auto');
model.study('std4').feature('eig').set('notsolnum', 'auto');
model.study('std4').feature('eig').set('outputmap', {});
model.study('std4').feature('eig').set('ngenAUX', '1');
model.study('std4').feature('eig').set('goalngenAUX', '1');
model.study('std4').feature('eig').set('ngenAUX', '1');
model.study('std4').feature('eig').set('goalngenAUX', '1');
model.study('std4').feature('eig').setSolveFor('/physics/solid', false);
model.study('std4').feature('eig').setSolveFor('/physics/shell', false);
model.study('std4').feature('eig').setSolveFor('/physics/solid2', false);
model.study('std4').feature('eig').setSolveFor('/physics/shell2', true);
model.study('std4').label('Study 4, 3D Shell Sector');
model.study('std4').feature('eig').set('neigsactive', true);
model.study('std4').feature('eig').set('neigs', 10);

model.sol.create('sol4');
model.sol('sol4').study('std4');
model.sol('sol4').create('st1', 'StudyStep');
model.sol('sol4').feature('st1').set('study', 'std4');
model.sol('sol4').feature('st1').set('studystep', 'eig');
model.sol('sol4').create('v1', 'Variables');
model.sol('sol4').feature('v1').feature('comp2_ar2').set('scalemethod', 'manual');
model.sol('sol4').feature('v1').feature('comp2_ar2').set('resscalemethod', 'parent');
model.sol('sol4').feature('v1').feature('comp2_ar2').set('scaleval', '0.01');
model.sol('sol4').feature('v1').set('control', 'eig');
model.sol('sol4').create('e1', 'Eigenvalue');
model.sol('sol4').feature('e1').set('eigvfunscale', 'maximum');
model.sol('sol4').feature('e1').set('eigvfunscaleparam', '9.999999999999999E-6');
model.sol('sol4').feature('e1').set('control', 'eig');
model.sol('sol4').feature('e1').feature('aDef').set('cachepattern', true);
model.sol('sol4').attach('std4');
model.sol('sol4').runAll;

model.result.dataset.create('dset6shell2shl', 'Shell');
model.result.dataset('dset6shell2shl').set('data', 'dset6');
model.result.dataset('dset6shell2shl').setIndex('topconst', '1', 6, 1);
model.result.dataset('dset6shell2shl').setIndex('bottomconst', '-1', 6, 1);
model.result.dataset('dset6shell2shl').setIndex('orientationexpr', 'shell2.nlX', 0);
model.result.dataset('dset6shell2shl').setIndex('displacementexpr', 'ar2x', 0);
model.result.dataset('dset6shell2shl').setIndex('orientationexpr', 'shell2.nlY', 1);
model.result.dataset('dset6shell2shl').setIndex('displacementexpr', 'ar2y', 1);
model.result.dataset('dset6shell2shl').setIndex('orientationexpr', 'shell2.nlZ', 2);
model.result.dataset('dset6shell2shl').setIndex('displacementexpr', 'ar2z', 2);
model.result.dataset('dset6shell2shl').set('distanceexpr', 'shell2.z_pos');
model.result.dataset('dset6shell2shl').set('seplevels', false);
model.result.dataset('dset6shell2shl').set('resolution', 2);
model.result.dataset('dset6shell2shl').set('areascalefactor', 'shell2.ASF');
model.result.dataset('dset6shell2shl').set('linescalefactor', 'shell2.LSF');
model.result.create('pg6', 'PlotGroup3D');
model.result('pg6').set('data', 'dset6shell2shl');
model.result('pg6').setIndex('looplevel', 1, 0);
model.result('pg6').set('defaultPlotID', 'modeShape');
model.result('pg6').label('Mode Shape (shell2)');
model.result('pg6').set('showlegends', false);
model.result('pg6').set('data', 'dset6shell2shl');
model.result('pg6').create('surf1', 'Surface');
model.result('pg6').feature('surf1').set('expr', {'shell2.disp'});
model.result('pg6').feature('surf1').set('threshold', 'manual');
model.result('pg6').feature('surf1').set('thresholdvalue', 0.2);
model.result('pg6').feature('surf1').set('colortable', 'Rainbow');
model.result('pg6').feature('surf1').set('colortabletrans', 'none');
model.result('pg6').feature('surf1').set('colorscalemode', 'linear');
model.result('pg6').feature('surf1').set('colortable', 'AuroraBorealis');
model.result('pg6').feature('surf1').create('def', 'Deform');
model.result('pg6').feature('surf1').feature('def').set('expr', {'shell2.u' 'shell2.v' 'shell2.w'});
model.result.evaluationGroup.create('std4EvgFrq', 'EvaluationGroup');
model.result.evaluationGroup('std4EvgFrq').set('defaultPlotID', 'eigenfrequenciesTable_shell2');
model.result.evaluationGroup('std4EvgFrq').set('data', 'dset6');
model.result.evaluationGroup('std4EvgFrq').label('Eigenfrequencies (Study 4, 3D Shell Sector)');
model.result.evaluationGroup('std4EvgFrq').create('gev1', 'EvalGlobal');
model.result.evaluationGroup('std4EvgFrq').feature('gev1').setIndex('expr', '2*pi*freq', 0);
model.result.evaluationGroup('std4EvgFrq').feature('gev1').setIndex('unit', 'rad/s', 0);
model.result.evaluationGroup('std4EvgFrq').feature('gev1').setIndex('descr', 'Angular frequency', 0);
model.result.evaluationGroup('std4EvgFrq').feature('gev1').setIndex('expr', 'imag(freq)/abs(freq)', 1);
model.result.evaluationGroup('std4EvgFrq').feature('gev1').setIndex('unit', '1', 1);
model.result.evaluationGroup('std4EvgFrq').feature('gev1').setIndex('descr', 'Damping ratio', 1);
model.result.evaluationGroup('std4EvgFrq').feature('gev1').setIndex('expr', 'abs(freq)/imag(freq)/2', 2);
model.result.evaluationGroup('std4EvgFrq').feature('gev1').setIndex('unit', '1', 2);
model.result.evaluationGroup('std4EvgFrq').feature('gev1').setIndex('descr', 'Quality factor', 2);
model.result.evaluationGroup('std4EvgFrq').run;
model.result.evaluationGroup.create('std4mpf2', 'EvaluationGroup');
model.result.evaluationGroup('std4mpf2').set('data', 'dset6');
model.result.evaluationGroup('std4mpf2').label('Participation Factors (Study 4, 3D Shell Sector)');
model.result.evaluationGroup('std4mpf2').create('gev1', 'EvalGlobal');
model.result.evaluationGroup('std4mpf2').feature('gev1').setIndex('expr', 'mpf2.pfLnormX', 0);
model.result.evaluationGroup('std4mpf2').feature('gev1').setIndex('unit', '1', 0);
model.result.evaluationGroup('std4mpf2').feature('gev1').setIndex('descr', 'Participation factor, normalized, X-translation', 0);
model.result.evaluationGroup('std4mpf2').feature('gev1').setIndex('expr', 'mpf2.pfLnormY', 1);
model.result.evaluationGroup('std4mpf2').feature('gev1').setIndex('unit', '1', 1);
model.result.evaluationGroup('std4mpf2').feature('gev1').setIndex('descr', 'Participation factor, normalized, Y-translation', 1);
model.result.evaluationGroup('std4mpf2').feature('gev1').setIndex('expr', 'mpf2.pfLnormZ', 2);
model.result.evaluationGroup('std4mpf2').feature('gev1').setIndex('unit', '1', 2);
model.result.evaluationGroup('std4mpf2').feature('gev1').setIndex('descr', 'Participation factor, normalized, Z-translation', 2);
model.result.evaluationGroup('std4mpf2').feature('gev1').setIndex('expr', 'mpf2.pfRnormX', 3);
model.result.evaluationGroup('std4mpf2').feature('gev1').setIndex('unit', '1', 3);
model.result.evaluationGroup('std4mpf2').feature('gev1').setIndex('descr', 'Participation factor, normalized, X-rotation', 3);
model.result.evaluationGroup('std4mpf2').feature('gev1').setIndex('expr', 'mpf2.pfRnormY', 4);
model.result.evaluationGroup('std4mpf2').feature('gev1').setIndex('unit', '1', 4);
model.result.evaluationGroup('std4mpf2').feature('gev1').setIndex('descr', 'Participation factor, normalized, Y-rotation', 4);
model.result.evaluationGroup('std4mpf2').feature('gev1').setIndex('expr', 'mpf2.pfRnormZ', 5);
model.result.evaluationGroup('std4mpf2').feature('gev1').setIndex('unit', '1', 5);
model.result.evaluationGroup('std4mpf2').feature('gev1').setIndex('descr', 'Participation factor, normalized, Z-rotation', 5);
model.result.evaluationGroup('std4mpf2').feature('gev1').setIndex('expr', 'mpf2.mEffLX', 6);
model.result.evaluationGroup('std4mpf2').feature('gev1').setIndex('unit', 'kg', 6);
model.result.evaluationGroup('std4mpf2').feature('gev1').setIndex('descr', 'Effective modal mass, X-translation', 6);
model.result.evaluationGroup('std4mpf2').feature('gev1').setIndex('expr', 'mpf2.mEffLY', 7);
model.result.evaluationGroup('std4mpf2').feature('gev1').setIndex('unit', 'kg', 7);
model.result.evaluationGroup('std4mpf2').feature('gev1').setIndex('descr', 'Effective modal mass, Y-translation', 7);
model.result.evaluationGroup('std4mpf2').feature('gev1').setIndex('expr', 'mpf2.mEffLZ', 8);
model.result.evaluationGroup('std4mpf2').feature('gev1').setIndex('unit', 'kg', 8);
model.result.evaluationGroup('std4mpf2').feature('gev1').setIndex('descr', 'Effective modal mass, Z-translation', 8);
model.result.evaluationGroup('std4mpf2').feature('gev1').setIndex('expr', 'mpf2.mEffRX', 9);
model.result.evaluationGroup('std4mpf2').feature('gev1').setIndex('unit', 'kg*m^2', 9);
model.result.evaluationGroup('std4mpf2').feature('gev1').setIndex('descr', 'Effective modal mass, X-rotation', 9);
model.result.evaluationGroup('std4mpf2').feature('gev1').setIndex('expr', 'mpf2.mEffRY', 10);
model.result.evaluationGroup('std4mpf2').feature('gev1').setIndex('unit', 'kg*m^2', 10);
model.result.evaluationGroup('std4mpf2').feature('gev1').setIndex('descr', 'Effective modal mass, Y-rotation', 10);
model.result.evaluationGroup('std4mpf2').feature('gev1').setIndex('expr', 'mpf2.mEffRZ', 11);
model.result.evaluationGroup('std4mpf2').feature('gev1').setIndex('unit', 'kg*m^2', 11);
model.result.evaluationGroup('std4mpf2').feature('gev1').setIndex('descr', 'Effective modal mass, Z-rotation', 11);
model.result.evaluationGroup('std4mpf2').run;
model.result('pg6').run;
model.result('pg6').set('looplevel', [4]);
model.result('pg6').run;
model.result.dataset.create('sec2', 'Sector3D');
model.result.dataset('sec2').set('data', 'dset6shell2shl');
model.result.dataset('sec2').set('sectors', '360/15');
model.result.dataset('sec2').set('include', 'manual');
model.result.dataset('sec2').set('startsector', 18);
model.result.dataset('sec2').set('sectorsinclude', 15);
model.result('pg6').run;
model.result('pg6').set('data', 'sec2');
model.result('pg6').run;

model.view('view7').set('showgrid', false);

model.result('pg6').set('looplevel', [3]);
model.result('pg6').run;

model.physics('solid').prop('Mode2Daxi').set('ModeExtension', true);

model.study('std1').feature('eig').setEntry('activate', 'shell', false);
model.study('std1').feature('eig').setEntry('activate', 'solid2', false);
model.study('std1').feature('eig').setEntry('activate', 'shell2', false);
model.study('std1').feature('eig').set('neigsactive', true);
model.study('std1').feature('eig').set('neigs', 10);

model.sol('sol1').study('std1');
model.sol('sol1').feature.remove('e1');
model.sol('sol1').feature.remove('v1');
model.sol('sol1').feature.remove('st1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'eig');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').set('control', 'eig');
model.sol('sol1').create('e1', 'Eigenvalue');
model.sol('sol1').feature('e1').set('eigvfunscale', 'maximum');
model.sol('sol1').feature('e1').set('eigvfunscaleparam', '9.999999999999999E-6');
model.sol('sol1').feature('e1').set('control', 'eig');
model.sol('sol1').feature('e1').feature('aDef').set('cachepattern', true);
model.sol('sol1').attach('std1');
model.sol('sol1').runAll;

model.result('pg1').run;
model.result('pg2').run;
model.result('pg2').set('looplevel', [3]);
model.result('pg2').run;
model.result('pg2').set('looplevel', [4]);
model.result('pg2').run;

model.physics('shell').prop('Mode2Daxi').set('ModeExtension', true);

model.study('std2').feature('eig').setEntry('activate', 'solid', false);
model.study('std2').feature('eig').setEntry('activate', 'solid2', false);
model.study('std2').feature('eig').setEntry('activate', 'shell2', false);
model.study('std2').feature('eig').set('neigsactive', true);
model.study('std2').feature('eig').set('neigs', 10);

model.sol('sol2').study('std2');
model.sol('sol2').feature.remove('e1');
model.sol('sol2').feature.remove('v1');
model.sol('sol2').feature.remove('st1');
model.sol('sol2').create('st1', 'StudyStep');
model.sol('sol2').feature('st1').set('study', 'std2');
model.sol('sol2').feature('st1').set('studystep', 'eig');
model.sol('sol2').create('v1', 'Variables');
model.sol('sol2').feature('v1').feature('comp1_ar').set('scalemethod', 'manual');
model.sol('sol2').feature('v1').feature('comp1_ar').set('resscalemethod', 'parent');
model.sol('sol2').feature('v1').feature('comp1_ar').set('scaleval', '0.01');
model.sol('sol2').feature('v1').set('control', 'eig');
model.sol('sol2').create('e1', 'Eigenvalue');
model.sol('sol2').feature('e1').set('eigvfunscale', 'maximum');
model.sol('sol2').feature('e1').set('eigvfunscaleparam', '9.999999999999999E-6');
model.sol('sol2').feature('e1').set('control', 'eig');
model.sol('sol2').feature('e1').feature('aDef').set('cachepattern', true);
model.sol('sol2').attach('std2');
model.sol('sol2').runAll;

model.result('pg3').run;
model.result('pg4').run;
model.result('pg4').set('looplevel', [3]);
model.result('pg4').run;
model.result('pg4').set('looplevel', [4]);
model.result('pg4').run;

model.study('std3').feature('eig').setEntry('activate', 'shell2', false);

model.result('pg2').run;
model.result('pg2').run;

model.title('Eigenfrequency Analysis of a Free Cylinder');

model.description('Eigenfrequencies for a free cylindrical tube are compared with a NAFEMS benchmark solution. Three different physics interfaces are used: Solid Mechanics and Shell in 2D axisymmetry, and Solid Mechanics in 3D with cyclic symmetry boundary conditions. In addition, it is shown how to also compute eigenmodes with a twisting deformation.');

model.mesh.clearMeshes;

model.sol('sol1').clearSolutionData;
model.sol('sol2').clearSolutionData;
model.sol('sol3').clearSolutionData;
model.sol('sol4').clearSolutionData;

model.label('free_cylinder.mph');

model.modelNode.label('Components');

out = model;
