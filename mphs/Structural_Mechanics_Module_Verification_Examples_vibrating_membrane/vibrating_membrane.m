function out = model
%
% vibrating_membrane.m
%
% Model exported on May 26 2025, 21:34 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/Structural_Mechanics_Module/Verification_Examples');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 3);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.physics.create('mbrn', 'StructuralMembrane', 'geom1');
model.physics('mbrn').model('comp1');

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
model.study('std1').feature('eig').setSolveFor('/physics/mbrn', true);

model.common.create('mpf1', 'ParticipationFactors', 'comp1');

model.param.set('R', '250[mm]');
model.param.descr('R', 'Radius');
model.param.set('thic', '0.2[mm]');
model.param.descr('thic', 'Thickness');
model.param.set('T0', '100[MPa]*thic');
model.param.descr('T0', 'Pretension force');
model.param.set('E1', '200[GPa]');
model.param.descr('E1', 'Young''s modulus');
model.param.set('rho1', '7850[kg/m^3]');
model.param.descr('rho1', 'Density');
model.param.set('nu1', '0.33');
model.param.descr('nu1', 'Poisson''s ratio');
model.param.set('fct', 'sqrt(T0/(thic*rho1))/(2*pi*R)');
model.param.descr('fct', 'Common factor in natural frequencies');
model.param.set('f10', '2.4048*fct');
model.param.descr('f10', '1st natural frequency');
model.param.set('f11', '3.8317*fct');
model.param.descr('f11', '2nd and 3d natural frequencies');
model.param.set('f12', '5.1356*fct');
model.param.descr('f12', '4th and 5th natural frequencies');
model.param.set('f20', '5.5201*fct');
model.param.descr('f20', '6th natural frequency');

model.coordSystem.create('sys2', 'geom1', 'Cylindrical');

model.geom('geom1').run;
model.geom('geom1').create('wp1', 'WorkPlane');
model.geom('geom1').feature('wp1').set('unite', true);
model.geom('geom1').feature('wp1').geom.create('c1', 'Circle');
model.geom('geom1').feature('wp1').geom.feature('c1').set('r', 'R');
model.geom('geom1').run('fin');

model.material.create('mat1', 'Common', 'comp1');
model.material('mat1').propertyGroup.create('Enu', 'Young''s_modulus_and_Poisson''s_ratio');
model.material('mat1').propertyGroup('Enu').set('E', {'E1'});
model.material('mat1').propertyGroup('Enu').set('nu', {'nu1'});
model.material('mat1').propertyGroup('def').set('density', {'rho1'});

model.physics('mbrn').feature('to1').set('d', 'thic');
model.physics('mbrn').feature('lemm1').create('iss1', 'InitialStressandStrain', 2);
model.physics('mbrn').feature('lemm1').feature('iss1').set('N0', {'T0' '0' '0' 'T0'});
model.physics('mbrn').create('disp1', 'Displacement1', 1);
model.physics('mbrn').feature('disp1').selection.set([1 2 3 4]);
model.physics('mbrn').feature('disp1').setIndex('Direction', 'prescribed', 2);
model.physics('mbrn').create('fix1', 'Fixed', 0);
model.physics('mbrn').feature('fix1').selection.set([1]);
model.physics('mbrn').create('disp2', 'Displacement0', 0);
model.physics('mbrn').feature('disp2').selection.set([2]);
model.physics('mbrn').feature('disp2').setIndex('Direction', 'prescribed', 1);

model.mesh('mesh1').autoMeshSize(4);

model.study('std1').feature('eig').set('geometricNonlinearity', true);

model.sol.create('sol1');
model.sol('sol1').study('std1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'eig');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').feature('comp1_mbrn_unn').set('scalemethod', 'manual');
model.sol('sol1').feature('v1').feature('comp1_u').set('scalemethod', 'manual');
model.sol('sol1').feature('v1').feature('comp1_mbrn_unn').set('scaleval', '1e-3');
model.sol('sol1').feature('v1').feature('comp1_u').set('scaleval', '1e-2*0.7071067811865476');
model.sol('sol1').feature('v1').set('control', 'eig');
model.sol('sol1').create('e1', 'Eigenvalue');
model.sol('sol1').feature('e1').set('eigvfunscale', 'maximum');
model.sol('sol1').feature('e1').set('eigvfunscaleparam', '7.07E-7');
model.sol('sol1').feature('e1').set('control', 'eig');
model.sol('sol1').feature('e1').feature('aDef').set('cachepattern', true);
model.sol('sol1').attach('std1');
model.sol('sol1').runAll;

model.result.dataset('dset1').set('frametype', 'spatial');
model.result.create('pg1', 'PlotGroup3D');
model.result('pg1').set('data', 'dset1');
model.result('pg1').setIndex('looplevel', 1, 0);
model.result('pg1').set('frametype', 'spatial');
model.result('pg1').set('defaultPlotID', 'modeShape');
model.result('pg1').label('Mode Shape (mbrn)');
model.result('pg1').set('showlegends', false);
model.result('pg1').create('surf1', 'Surface');
model.result('pg1').feature('surf1').set('expr', {'mbrn.disp'});
model.result('pg1').feature('surf1').set('threshold', 'manual');
model.result('pg1').feature('surf1').set('thresholdvalue', 0.2);
model.result('pg1').feature('surf1').set('colortable', 'Rainbow');
model.result('pg1').feature('surf1').set('colortabletrans', 'none');
model.result('pg1').feature('surf1').set('colorscalemode', 'linear');
model.result('pg1').feature('surf1').set('colortable', 'AuroraBorealis');
model.result('pg1').feature('surf1').create('def', 'Deform');
model.result('pg1').feature('surf1').feature('def').set('expr', {'u' 'v' 'w'});
model.result('pg1').feature('surf1').feature('def').set('descr', 'Displacement field');
model.result.evaluationGroup.create('std1EvgFrq', 'EvaluationGroup');
model.result.evaluationGroup('std1EvgFrq').set('defaultPlotID', 'eigenfrequenciesTable_mbrn');
model.result.evaluationGroup('std1EvgFrq').set('data', 'dset1');
model.result.evaluationGroup('std1EvgFrq').label('Eigenfrequencies (Study 1)');
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
model.result.evaluationGroup('std1mpf1').label('Participation Factors (Study 1)');
model.result.evaluationGroup('std1mpf1').create('gev1', 'EvalGlobal');
model.result.evaluationGroup('std1mpf1').feature('gev1').setIndex('expr', 'mpf1.pfLnormX', 0);
model.result.evaluationGroup('std1mpf1').feature('gev1').setIndex('unit', '1', 0);
model.result.evaluationGroup('std1mpf1').feature('gev1').setIndex('descr', 'Participation factor, normalized, X-translation', 0);
model.result.evaluationGroup('std1mpf1').feature('gev1').setIndex('expr', 'mpf1.pfLnormY', 1);
model.result.evaluationGroup('std1mpf1').feature('gev1').setIndex('unit', '1', 1);
model.result.evaluationGroup('std1mpf1').feature('gev1').setIndex('descr', 'Participation factor, normalized, Y-translation', 1);
model.result.evaluationGroup('std1mpf1').feature('gev1').setIndex('expr', 'mpf1.pfLnormZ', 2);
model.result.evaluationGroup('std1mpf1').feature('gev1').setIndex('unit', '1', 2);
model.result.evaluationGroup('std1mpf1').feature('gev1').setIndex('descr', 'Participation factor, normalized, Z-translation', 2);
model.result.evaluationGroup('std1mpf1').feature('gev1').setIndex('expr', 'mpf1.pfRnormX', 3);
model.result.evaluationGroup('std1mpf1').feature('gev1').setIndex('unit', '1', 3);
model.result.evaluationGroup('std1mpf1').feature('gev1').setIndex('descr', 'Participation factor, normalized, X-rotation', 3);
model.result.evaluationGroup('std1mpf1').feature('gev1').setIndex('expr', 'mpf1.pfRnormY', 4);
model.result.evaluationGroup('std1mpf1').feature('gev1').setIndex('unit', '1', 4);
model.result.evaluationGroup('std1mpf1').feature('gev1').setIndex('descr', 'Participation factor, normalized, Y-rotation', 4);
model.result.evaluationGroup('std1mpf1').feature('gev1').setIndex('expr', 'mpf1.pfRnormZ', 5);
model.result.evaluationGroup('std1mpf1').feature('gev1').setIndex('unit', '1', 5);
model.result.evaluationGroup('std1mpf1').feature('gev1').setIndex('descr', 'Participation factor, normalized, Z-rotation', 5);
model.result.evaluationGroup('std1mpf1').feature('gev1').setIndex('expr', 'mpf1.mEffLX', 6);
model.result.evaluationGroup('std1mpf1').feature('gev1').setIndex('unit', 'kg', 6);
model.result.evaluationGroup('std1mpf1').feature('gev1').setIndex('descr', 'Effective modal mass, X-translation', 6);
model.result.evaluationGroup('std1mpf1').feature('gev1').setIndex('expr', 'mpf1.mEffLY', 7);
model.result.evaluationGroup('std1mpf1').feature('gev1').setIndex('unit', 'kg', 7);
model.result.evaluationGroup('std1mpf1').feature('gev1').setIndex('descr', 'Effective modal mass, Y-translation', 7);
model.result.evaluationGroup('std1mpf1').feature('gev1').setIndex('expr', 'mpf1.mEffLZ', 8);
model.result.evaluationGroup('std1mpf1').feature('gev1').setIndex('unit', 'kg', 8);
model.result.evaluationGroup('std1mpf1').feature('gev1').setIndex('descr', 'Effective modal mass, Z-translation', 8);
model.result.evaluationGroup('std1mpf1').feature('gev1').setIndex('expr', 'mpf1.mEffRX', 9);
model.result.evaluationGroup('std1mpf1').feature('gev1').setIndex('unit', 'kg*m^2', 9);
model.result.evaluationGroup('std1mpf1').feature('gev1').setIndex('descr', 'Effective modal mass, X-rotation', 9);
model.result.evaluationGroup('std1mpf1').feature('gev1').setIndex('expr', 'mpf1.mEffRY', 10);
model.result.evaluationGroup('std1mpf1').feature('gev1').setIndex('unit', 'kg*m^2', 10);
model.result.evaluationGroup('std1mpf1').feature('gev1').setIndex('descr', 'Effective modal mass, Y-rotation', 10);
model.result.evaluationGroup('std1mpf1').feature('gev1').setIndex('expr', 'mpf1.mEffRZ', 11);
model.result.evaluationGroup('std1mpf1').feature('gev1').setIndex('unit', 'kg*m^2', 11);
model.result.evaluationGroup('std1mpf1').feature('gev1').setIndex('descr', 'Effective modal mass, Z-rotation', 11);
model.result.evaluationGroup('std1mpf1').run;
model.result('pg1').run;
model.result('pg1').run;
model.result('pg1').feature('surf1').set('expr', 'w');
model.result('pg1').run;
model.result('pg1').run;
model.result('pg1').set('looplevel', [2]);
model.result('pg1').run;
model.result('pg1').set('looplevel', [3]);
model.result('pg1').run;
model.result('pg1').set('looplevel', [4]);
model.result('pg1').run;
model.result('pg1').set('looplevel', [5]);
model.result('pg1').run;
model.result('pg1').set('looplevel', [6]);
model.result('pg1').run;

model.study.create('std2');
model.study('std2').create('stat', 'Stationary');
model.study('std2').feature('stat').set('plotgroup', 'Default');
model.study('std2').feature('stat').set('outputmap', {});
model.study('std2').feature('stat').set('ngenAUX', '1');
model.study('std2').feature('stat').set('goalngenAUX', '1');
model.study('std2').feature('stat').set('ngenAUX', '1');
model.study('std2').feature('stat').set('goalngenAUX', '1');
model.study('std2').feature('stat').setSolveFor('/physics/mbrn', true);
model.study('std2').create('eig', 'Eigenfrequency');
model.study('std2').feature('eig').set('plotgroup', 'Default');
model.study('std2').feature('eig').set('chkeigregion', true);
model.study('std2').feature('eig').set('conrad', '1');
model.study('std2').feature('eig').set('conradynhm', '1');
model.study('std2').feature('eig').set('storefact', false);
model.study('std2').feature('eig').set('geometricNonlinearity', true);
model.study('std2').feature('eig').set('outputmap', {});
model.study('std2').feature('eig').set('ngenAUX', '1');
model.study('std2').feature('eig').set('goalngenAUX', '1');
model.study('std2').feature('eig').set('ngenAUX', '1');
model.study('std2').feature('eig').set('goalngenAUX', '1');
model.study('std2').feature('eig').setSolveFor('/physics/mbrn', true);

model.physics('mbrn').create('el1', 'EdgeLoad', 1);
model.physics('mbrn').feature('el1').selection.set([1 2 3 4]);
model.physics('mbrn').feature('el1').set('coordinateSystem', 'sys2');
model.physics('mbrn').feature('el1').set('FperLength', {'T0' '0' '0'});
model.physics('mbrn').create('spf1', 'SpringFoundation2', 2);
model.physics('mbrn').feature('spf1').selection.set([1]);
model.physics('mbrn').feature('spf1').set('kPerArea', [0 0 0 0 0 0 0 0 10]);

model.study('std2').feature('stat').set('geometricNonlinearity', true);
model.study('std2').feature('stat').set('useadvanceddisable', true);
model.study('std2').feature('stat').set('disabledphysics', {'mbrn/lemm1/iss1'});
model.study('std2').feature('eig').set('useadvanceddisable', true);
model.study('std2').feature('eig').set('disabledphysics', {'mbrn/lemm1/iss1' 'mbrn/spf1'});

model.sol.create('sol2');
model.sol('sol2').study('std2');
model.sol('sol2').create('st1', 'StudyStep');
model.sol('sol2').feature('st1').set('study', 'std2');
model.sol('sol2').feature('st1').set('studystep', 'stat');
model.sol('sol2').create('v1', 'Variables');
model.sol('sol2').feature('v1').feature('comp1_mbrn_unn').set('scalemethod', 'manual');
model.sol('sol2').feature('v1').feature('comp1_u').set('scalemethod', 'manual');
model.sol('sol2').feature('v1').feature('comp1_mbrn_unn').set('scaleval', '1e-3');
model.sol('sol2').feature('v1').feature('comp1_u').set('scaleval', '1e-2*0.7071067811865476');
model.sol('sol2').feature('v1').set('control', 'stat');
model.sol('sol2').create('s1', 'Stationary');
model.sol('sol2').feature('s1').feature('aDef').set('cachepattern', true);
model.sol('sol2').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol2').feature('s1').feature('fc1').set('termonres', 'off');
model.sol('sol2').feature('s1').feature('fc1').set('linsolver', 'dDef');
model.sol('sol2').feature('s1').feature('fc1').set('termonres', 'off');
model.sol('sol2').feature('s1').feature.remove('fcDef');
model.sol('sol2').create('su1', 'StoreSolution');
model.sol('sol2').create('st2', 'StudyStep');
model.sol('sol2').feature('st2').set('study', 'std2');
model.sol('sol2').feature('st2').set('studystep', 'eig');
model.sol('sol2').create('v2', 'Variables');
model.sol('sol2').feature('v2').feature('comp1_mbrn_unn').set('scalemethod', 'manual');
model.sol('sol2').feature('v2').feature('comp1_u').set('scalemethod', 'manual');
model.sol('sol2').feature('v2').feature('comp1_mbrn_unn').set('scaleval', '1e-3');
model.sol('sol2').feature('v2').feature('comp1_u').set('scaleval', '1e-2*0.7071067811865476');
model.sol('sol2').feature('v2').set('initmethod', 'sol');
model.sol('sol2').feature('v2').set('initsol', 'sol2');
model.sol('sol2').feature('v2').set('initsoluse', 'sol3');
model.sol('sol2').feature('v2').set('notsolmethod', 'sol');
model.sol('sol2').feature('v2').set('notsol', 'sol2');
model.sol('sol2').feature('v2').set('control', 'eig');
model.sol('sol2').create('e1', 'Eigenvalue');
model.sol('sol2').feature('e1').set('eigvfunscale', 'maximum');
model.sol('sol2').feature('e1').set('eigvfunscaleparam', '7.07E-7');
model.sol('sol2').feature('e1').set('control', 'eig');
model.sol('sol2').feature('e1').set('linpmethod', 'sol');
model.sol('sol2').feature('e1').set('linpsol', 'sol2');
model.sol('sol2').feature('e1').set('linpsoluse', 'sol3');
model.sol('sol2').feature('e1').set('control', 'eig');
model.sol('sol2').feature('e1').feature('aDef').set('cachepattern', true);
model.sol('sol2').feature('v2').set('notsolnum', 'auto');
model.sol('sol2').feature('v2').set('notsolvertype', 'solnum');
model.sol('sol2').attach('std2');
model.sol('sol2').runAll;

model.result.dataset('dset2').set('frametype', 'spatial');
model.result.create('pg2', 'PlotGroup3D');
model.result('pg2').set('data', 'dset2');
model.result('pg2').setIndex('looplevel', 1, 0);
model.result('pg2').set('frametype', 'spatial');
model.result('pg2').set('defaultPlotID', 'modeShape');
model.result('pg2').label('Mode Shape (mbrn) 1');
model.result('pg2').set('showlegends', false);
model.result('pg2').create('surf1', 'Surface');
model.result('pg2').feature('surf1').set('expr', {'mbrn.disp'});
model.result('pg2').feature('surf1').set('threshold', 'manual');
model.result('pg2').feature('surf1').set('thresholdvalue', 0.2);
model.result('pg2').feature('surf1').set('colortable', 'Rainbow');
model.result('pg2').feature('surf1').set('colortabletrans', 'none');
model.result('pg2').feature('surf1').set('colorscalemode', 'linear');
model.result('pg2').feature('surf1').set('colortable', 'AuroraBorealis');
model.result('pg2').feature('surf1').create('def', 'Deform');
model.result('pg2').feature('surf1').feature('def').set('expr', {'u' 'v' 'w'});
model.result('pg2').feature('surf1').feature('def').set('descr', 'Displacement field');
model.result.evaluationGroup.create('std2EvgFrq', 'EvaluationGroup');
model.result.evaluationGroup('std2EvgFrq').set('defaultPlotID', 'eigenfrequenciesTable_mbrn');
model.result.evaluationGroup('std2EvgFrq').set('data', 'dset2');
model.result.evaluationGroup('std2EvgFrq').label('Eigenfrequencies (Study 2)');
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
model.result.evaluationGroup('std2mpf1').label('Participation Factors (Study 2)');
model.result.evaluationGroup('std2mpf1').create('gev1', 'EvalGlobal');
model.result.evaluationGroup('std2mpf1').feature('gev1').setIndex('expr', 'mpf1.pfLnormX', 0);
model.result.evaluationGroup('std2mpf1').feature('gev1').setIndex('unit', '1', 0);
model.result.evaluationGroup('std2mpf1').feature('gev1').setIndex('descr', 'Participation factor, normalized, X-translation', 0);
model.result.evaluationGroup('std2mpf1').feature('gev1').setIndex('expr', 'mpf1.pfLnormY', 1);
model.result.evaluationGroup('std2mpf1').feature('gev1').setIndex('unit', '1', 1);
model.result.evaluationGroup('std2mpf1').feature('gev1').setIndex('descr', 'Participation factor, normalized, Y-translation', 1);
model.result.evaluationGroup('std2mpf1').feature('gev1').setIndex('expr', 'mpf1.pfLnormZ', 2);
model.result.evaluationGroup('std2mpf1').feature('gev1').setIndex('unit', '1', 2);
model.result.evaluationGroup('std2mpf1').feature('gev1').setIndex('descr', 'Participation factor, normalized, Z-translation', 2);
model.result.evaluationGroup('std2mpf1').feature('gev1').setIndex('expr', 'mpf1.pfRnormX', 3);
model.result.evaluationGroup('std2mpf1').feature('gev1').setIndex('unit', '1', 3);
model.result.evaluationGroup('std2mpf1').feature('gev1').setIndex('descr', 'Participation factor, normalized, X-rotation', 3);
model.result.evaluationGroup('std2mpf1').feature('gev1').setIndex('expr', 'mpf1.pfRnormY', 4);
model.result.evaluationGroup('std2mpf1').feature('gev1').setIndex('unit', '1', 4);
model.result.evaluationGroup('std2mpf1').feature('gev1').setIndex('descr', 'Participation factor, normalized, Y-rotation', 4);
model.result.evaluationGroup('std2mpf1').feature('gev1').setIndex('expr', 'mpf1.pfRnormZ', 5);
model.result.evaluationGroup('std2mpf1').feature('gev1').setIndex('unit', '1', 5);
model.result.evaluationGroup('std2mpf1').feature('gev1').setIndex('descr', 'Participation factor, normalized, Z-rotation', 5);
model.result.evaluationGroup('std2mpf1').feature('gev1').setIndex('expr', 'mpf1.mEffLX', 6);
model.result.evaluationGroup('std2mpf1').feature('gev1').setIndex('unit', 'kg', 6);
model.result.evaluationGroup('std2mpf1').feature('gev1').setIndex('descr', 'Effective modal mass, X-translation', 6);
model.result.evaluationGroup('std2mpf1').feature('gev1').setIndex('expr', 'mpf1.mEffLY', 7);
model.result.evaluationGroup('std2mpf1').feature('gev1').setIndex('unit', 'kg', 7);
model.result.evaluationGroup('std2mpf1').feature('gev1').setIndex('descr', 'Effective modal mass, Y-translation', 7);
model.result.evaluationGroup('std2mpf1').feature('gev1').setIndex('expr', 'mpf1.mEffLZ', 8);
model.result.evaluationGroup('std2mpf1').feature('gev1').setIndex('unit', 'kg', 8);
model.result.evaluationGroup('std2mpf1').feature('gev1').setIndex('descr', 'Effective modal mass, Z-translation', 8);
model.result.evaluationGroup('std2mpf1').feature('gev1').setIndex('expr', 'mpf1.mEffRX', 9);
model.result.evaluationGroup('std2mpf1').feature('gev1').setIndex('unit', 'kg*m^2', 9);
model.result.evaluationGroup('std2mpf1').feature('gev1').setIndex('descr', 'Effective modal mass, X-rotation', 9);
model.result.evaluationGroup('std2mpf1').feature('gev1').setIndex('expr', 'mpf1.mEffRY', 10);
model.result.evaluationGroup('std2mpf1').feature('gev1').setIndex('unit', 'kg*m^2', 10);
model.result.evaluationGroup('std2mpf1').feature('gev1').setIndex('descr', 'Effective modal mass, Y-rotation', 10);
model.result.evaluationGroup('std2mpf1').feature('gev1').setIndex('expr', 'mpf1.mEffRZ', 11);
model.result.evaluationGroup('std2mpf1').feature('gev1').setIndex('unit', 'kg*m^2', 11);
model.result.evaluationGroup('std2mpf1').feature('gev1').setIndex('descr', 'Effective modal mass, Z-rotation', 11);
model.result.evaluationGroup('std2mpf1').run;
model.result('pg2').run;

model.study('std1').feature('eig').set('useadvanceddisable', true);
model.study('std1').feature('eig').set('disabledphysics', {'mbrn/el1' 'mbrn/spf1'});

model.result('pg1').run;
model.result('pg1').set('looplevel', [4]);

model.title('Vibrating Membrane');

model.description('This example studies the natural frequencies of a pretensioned membrane exhibiting stress stiffening. The model results are compared with the analytical solution. Two different techniques for generating the prestress are explored.');

model.mesh.clearMeshes;

model.sol('sol1').clearSolutionData;
model.sol('sol2').clearSolutionData;
model.sol('sol3').clearSolutionData;

model.label('vibrating_membrane.mph');

model.modelNode.label('Components');

out = model;
