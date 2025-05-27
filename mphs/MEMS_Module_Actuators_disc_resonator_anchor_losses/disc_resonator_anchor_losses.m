function out = model
%
% disc_resonator_anchor_losses.m
%
% Model exported on May 26 2025, 21:30 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/MEMS_Module/Actuators');

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

model.param.set('R_d', '10[um]');
model.param.descr('R_d', 'Disc radius');
model.param.set('H_d', '3[um]');
model.param.descr('H_d', 'Disc height');
model.param.set('H_p', '0.8[um]');
model.param.descr('H_p', 'Post height');
model.param.set('R_p', '0.8[um]');
model.param.descr('R_p', 'Post radius');
model.param.set('R_s', '40[um]');
model.param.descr('R_s', 'Substrate section radius');
model.param.set('t_PML', 'wl');
model.param.descr('t_PML', 'PML thickness');
model.param.set('wl', '9.5[um]');
model.param.descr('wl', 'Wavelength of acoustic waves');

model.geom('geom1').create('r1', 'Rectangle');
model.geom('geom1').feature('r1').set('size', {'R_d' 'H_d'});
model.geom('geom1').feature('r1').set('pos', {'0' 'H_p'});
model.geom('geom1').run('r1');
model.geom('geom1').create('r2', 'Rectangle');
model.geom('geom1').feature('r2').set('size', {'R_p' '2*H_d+2*H_p'});
model.geom('geom1').run('r2');
model.geom('geom1').create('r3', 'Rectangle');
model.geom('geom1').feature('r3').set('size', {'2.5*R_p' 'H_d'});
model.geom('geom1').feature('r3').set('pos', {'0' 'H_d+2*H_p'});
model.geom('geom1').run('r3');
model.geom('geom1').create('c1', 'Circle');
model.geom('geom1').feature('c1').set('r', 'R_s+t_PML');
model.geom('geom1').feature('c1').set('angle', 90);
model.geom('geom1').feature('c1').set('rot', 270);
model.geom('geom1').feature('c1').setIndex('layer', 't_PML', 0);
model.geom('geom1').feature('c1').setIndex('layer', 'R_s+-R_d', 1);
model.geom('geom1').run('c1');

model.coordSystem.create('pml1', 'geom1', 'PML');

model.geom('geom1').run;

model.coordSystem('pml1').selection.set([1]);

model.material.create('mat1', 'Common', 'comp1');
model.material('mat1').label('Silicon Substrate');
model.material('mat1').propertyGroup.create('Enu', 'Young''s_modulus_and_Poisson''s_ratio');
model.material('mat1').propertyGroup('Enu').set('E', {'130[GPa]'});
model.material('mat1').propertyGroup('Enu').set('nu', {'0.28'});
model.material('mat1').propertyGroup('def').set('density', {'2230[kg/m^3]'});
model.material.create('mat2', 'Common', 'comp1');
model.material('mat2').label('Polysilicon');
model.material('mat2').selection.set([4 5 6 7 9]);
model.material('mat2').propertyGroup.create('Enu', 'Young''s_modulus_and_Poisson''s_ratio');
model.material('mat2').propertyGroup('Enu').set('E', {'150[GPa]'});
model.material('mat2').propertyGroup('Enu').set('nu', {'0.22'});
model.material('mat2').propertyGroup('def').set('density', {'2330[kg/m^3]'});
model.material.create('mat3', 'Common', 'comp1');
model.material('mat3').label('Diamond');
model.material('mat3').selection.set([8]);
model.material('mat3').propertyGroup.create('Enu', 'Young''s_modulus_and_Poisson''s_ratio');
model.material('mat3').propertyGroup('Enu').set('E', {'1061[GPa]'});
model.material('mat3').propertyGroup('Enu').set('nu', {'0.12'});
model.material('mat3').propertyGroup('def').set('density', {'3440[kg/m^3]'});

model.physics('solid').create('fix1', 'Fixed', 1);
model.physics('solid').feature('fix1').selection.set([26]);

model.mesh('mesh1').create('map1', 'Map');
model.mesh('mesh1').feature('map1').selection.geom('geom1', 2);
model.mesh('mesh1').feature('map1').selection.set([1 4 5 6 7 8 9]);
model.mesh('mesh1').feature('map1').create('dis1', 'Distribution');
model.mesh('mesh1').feature('map1').feature('dis1').selection.set([25]);
model.mesh('mesh1').feature('map1').feature('dis1').set('numelem', 8);
model.mesh('mesh1').feature('map1').create('dis2', 'Distribution');
model.mesh('mesh1').feature('map1').feature('dis2').selection.set([5 12 13]);
model.mesh('mesh1').feature('map1').feature('dis2').set('numelem', 4);
model.mesh('mesh1').create('ftri1', 'FreeTri');
model.mesh('mesh1').feature('size').set('hauto', 1);
model.mesh('mesh1').run;

model.study('std1').feature('eig').set('neigsactive', true);
model.study('std1').feature('eig').set('neigs', 1);
model.study('std1').feature('eig').set('shift', '5e8');

model.sol.create('sol1');
model.sol('sol1').study('std1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'eig');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').set('control', 'eig');
model.sol('sol1').create('e1', 'Eigenvalue');
model.sol('sol1').feature('e1').set('eigvfunscale', 'maximum');
model.sol('sol1').feature('e1').set('eigvfunscaleparam', '7.559999999999999E-11');
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
model.result('pg1').run;
model.result('pg1').feature('surf1').feature('def').set('scaleactive', true);
model.result('pg1').feature('surf1').feature('def').set('scale', '1E-7');
model.result('pg1').run;
model.result('pg2').run;
model.result('pg2').feature('surf1').feature('def').active(false);
model.result('pg2').run;
model.result('pg2').feature('surf1').set('unit', [native2unicode(hex2dec({'00' 'b5'}), 'unicode') 'm']);
model.result('pg2').feature('surf1').set('rangecoloractive', true);
model.result('pg2').feature('surf1').set('rangecolormax', '6e-7');
model.result('pg2').run;
model.result.numerical.create('gev1', 'EvalGlobal');
model.result.numerical('gev1').setIndex('expr', 'imag(-lambda)/(2*abs(real(lambda)))', 0);
model.result.table.create('tbl1', 'Table');
model.result.table('tbl1').comments('Global Evaluation 1');
model.result.numerical('gev1').set('table', 'tbl1');
model.result.numerical('gev1').setResult;

model.title('Disc Resonator Anchor Losses');

model.description('This example shows how to compute the anchor loss limited quality factor of a diamond disc resonator. The resonator is anchored to the substrate by a polysilicon post and power is transmitted to the substrate through the post. A perfectly matched layer is used to represent the essentially infinite substrate. The model is based on a paper presented at the 2007 COMSOL conference in Grenoble (P. Steeneken "Parameter Extraction and Support-Loss in MEMS Resonators", COMSOL Users Conference 2007, Grenoble).');

model.mesh.clearMeshes;

model.sol('sol1').clearSolutionData;

model.label('disc_resonator_anchor_losses.mph');

model.modelNode.label('Components');

out = model;
