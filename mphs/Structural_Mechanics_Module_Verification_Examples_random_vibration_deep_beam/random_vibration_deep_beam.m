function out = model
%
% random_vibration_deep_beam.m
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

model.physics.create('beam', 'HermitianBeam', 'geom1');
model.physics('beam').model('comp1');

model.study.create('std1');
model.study('std1').create('eig', 'Eigenfrequency');
model.study('std1').feature('eig').setSolveFor('/physics/beam', true);
model.study.create('std2');
model.study('std2').create('mr', 'ModelReduction');
model.study('std2').feature('mr').setSolveFor('/physics/beam', true);

model.common.create('grmi1', 'GlobalReducedModelInputs', '');

model.reduced.create('rom1', 'ModalFrequency');
model.reduced.create('rvib1', 'RandomVibration');
model.reduced('rvib1').set('frequencyResponseModel', 'rom1');

model.study('std1').feature('eig').set('neigsactive', true);
model.study('std1').feature('eig').set('neigs', 12);
model.study('std1').feature('eig').set('shiftactive', true);
model.study('std1').feature('eig').set('shift', '1');
model.study('std2').setGenPlots(false);
model.study('std2').setGenConv(false);
model.study('std2').feature('mr').set('trainingStudy', 'std1');
model.study('std2').feature('mr').set('trainingStep', 'eig');
model.study('std2').feature('mr').feature.create('freq1', 'Frequency');
model.study('std2').feature('mr').feature('freq1').set('plist', '100');
model.study('std2').feature('mr').set('unreducedModelStudy', 'std2');
model.study('std2').feature('mr').set('unreducedModelStep', 'freq1');
model.study('std2').feature('mr').set('romdata', 'rom1');

model.param.set('F', '1e6[N/m]');
model.param.descr('F', 'Edge load');
model.param.set('PSD', 'F^2/1[Hz]');
model.param.descr('PSD', 'Random edge load, power spectral density');

model.geom('geom1').create('ls1', 'LineSegment');
model.geom('geom1').feature('ls1').set('specify1', 'coord');
model.geom('geom1').feature('ls1').set('specify2', 'coord');
model.geom('geom1').feature('ls1').set('coord2', [10 0 0]);
model.geom('geom1').runPre('fin');
model.geom('geom1').run;

model.material.create('mat1', 'Common', 'comp1');
model.material('mat1').propertyGroup.create('Enu', 'Young''s_modulus_and_Poisson''s_ratio');
model.material('mat1').propertyGroup('Enu').set('E', {'2e11'});
model.material('mat1').propertyGroup('Enu').set('nu', {'0.3'});
model.material('mat1').propertyGroup('def').set('density', {'8000'});

model.physics('beam').prop('BeamFormulation').set('BeamFormulation', 'Timoshenko');
model.physics('beam').feature('csd1').set('SectionType', 'RectangularSection');
model.physics('beam').feature('csd1').set('hy_rect', 2);
model.physics('beam').feature('csd1').set('hz_rect', 2);
model.physics('beam').feature('csd1').feature('so1').set('OrientationMethod', 'vector_beam');
model.physics('beam').feature('csd1').feature('so1').set('vector_beam', [0 0 1]);
model.physics('beam').feature('emm1').create('dmp1', 'Damping', 1);
model.physics('beam').feature('emm1').feature('dmp1').set('alpha_dM', 5.36);
model.physics('beam').feature('emm1').feature('dmp1').set('beta_dK', '7.46e-5');
model.physics('beam').create('pdr1', 'DispRot0', 0);
model.physics('beam').feature('pdr1').selection.set([1]);
model.physics('beam').feature('pdr1').setIndex('Direction', 'prescribed', 0);
model.physics('beam').feature('pdr1').setIndex('Direction', 'prescribed', 1);
model.physics('beam').feature('pdr1').setIndex('Direction', 'prescribed', 2);
model.physics('beam').feature('pdr1').set('RotationType', 'RotationGroup');
model.physics('beam').feature('pdr1').setIndex('FreeRotationAround', true, 1);
model.physics('beam').feature('pdr1').setIndex('FreeRotationAround', true, 2);
model.physics('beam').create('pdr2', 'DispRot0', 0);
model.physics('beam').feature('pdr2').selection.set([2]);
model.physics('beam').feature('pdr2').setIndex('Direction', 'prescribed', 1);
model.physics('beam').feature('pdr2').setIndex('Direction', 'prescribed', 2);

model.mesh('mesh1').create('edg1', 'Edge');
model.mesh('mesh1').feature('edg1').selection.set([1]);
model.mesh('mesh1').feature('edg1').create('dis1', 'Distribution');
model.mesh('mesh1').run;

model.cpl.create('genext1', 'GeneralExtrusion', 'geom1');
model.cpl('genext1').selection.geom('geom1', 1);
model.cpl('genext1').selection.set([1]);
model.cpl('genext1').set('dstmap', {'5' '0' '0'});
model.cpl('genext1').set('srcframe', 'material');

model.variable.create('var1');
model.variable('var1').model('comp1');
model.variable('var1').set('V', 'genext1(v)');
model.variable('var1').descr('V', 'Displacement, y-component');
model.variable('var1').set('Sb', 'genext1(beam.sb1)');
model.variable('var1').descr('Sb', 'Bending stress');

model.common('grmi1').setIndex('name', 'Fy', 0);
model.common('grmi1').setIndex('expression', 'F', 0);

model.physics('beam').create('el1', 'EdgeLoad', 1);
model.physics('beam').feature('el1').selection.set([1]);
model.physics('beam').feature('el1').set('FeperLength', {'0' 'Fy' '0'});

model.study('std1').feature('eig').set('shift', '40');
model.study('std1').feature('eig').set('useadvanceddisable', true);
model.study('std1').feature('eig').set('disabledphysics', {'beam/emm1/dmp1'});

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

model.result.create('pg1', 'PlotGroup3D');
model.result('pg1').set('data', 'dset1');
model.result('pg1').setIndex('looplevel', 1, 0);
model.result('pg1').set('defaultPlotID', 'modeShape');
model.result('pg1').set('showlegends', false);
model.result('pg1').create('line1', 'Line');
model.result('pg1').feature('line1').set('expr', {'beam.disp'});
model.result('pg1').feature('line1').set('threshold', 'manual');
model.result('pg1').feature('line1').set('thresholdvalue', 0.2);
model.result('pg1').feature('line1').set('colortable', 'Rainbow');
model.result('pg1').feature('line1').set('colortabletrans', 'none');
model.result('pg1').feature('line1').set('colorscalemode', 'linear');
model.result('pg1').label('Mode Shape (beam)');
model.result('pg1').feature('line1').set('colortable', 'AuroraBorealis');
model.result('pg1').feature('line1').set('linetype', 'tube');
model.result('pg1').feature('line1').set('radiusexpr', 'beam.re');
model.result('pg1').feature('line1').set('tuberadiusscaleactive', true);
model.result('pg1').feature('line1').set('tuberadiusscale', 1);
model.result('pg1').feature('line1').set('tubeendcaps', false);
model.result('pg1').feature('line1').create('def', 'Deform');
model.result('pg1').feature('line1').feature('def').set('expr', {'u' 'v' 'w'});
model.result('pg1').feature('line1').feature('def').set('descr', 'Displacement field');
model.result.evaluationGroup.create('std1EvgFrq', 'EvaluationGroup');
model.result.evaluationGroup('std1EvgFrq').set('defaultPlotID', 'eigenfrequenciesTable_beam');
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
model.result('pg1').run;

model.sol.create('sol2');
model.sol('sol2').study('std2');
model.sol('sol2').create('st1', 'StudyStep');
model.sol('sol2').feature('st1').set('study', 'std2');
model.sol('sol2').feature('st1').set('studystep', 'mr');
model.sol('sol2').create('v1', 'Variables');
model.sol('sol2').feature('v1').set('control', 'mr');
model.sol('sol2').create('mor1', 'ModalReduction');
model.sol('sol2').feature('mor1').set('analysistype', 'frequency');
model.sol('sol2').feature('mor1').set('control', 'mr');
model.sol('sol2').create('st2', 'StudyStep');
model.sol('sol2').feature('st2').set('study', 'std2');
model.sol('sol2').feature('st2').set('studystep', 'mr');
model.sol('sol2').feature('st2').set('useForModelReduction', false);
model.sol('sol2').feature('mor1').set('control', 'mr');
model.sol('sol2').feature('mor1').feature('aDef').set('cachepattern', true);
model.sol('sol2').attach('std2');
model.sol('sol2').runAll;

model.reduced('rvib1').setIndex('powerSpectralDensity', 'PSD', 0);

model.sol('sol2').updateSolution;

model.result.numerical.create('gevs1', 'EvalGlobalSweep');
model.result.numerical('gevs1').setIndex('pname', 'freq', 0);
model.result.numerical('gevs1').setIndex('plistarr', 'range(20,1,41) range(41.5,0.01,43.5) range(44,1,60) [Hz]', 0);
model.result.numerical('gevs1').setIndex('expr', 'rvib1.psd(V)', 0);
model.result.numerical('gevs1').setIndex('unit', 'mm^2/Hz', 0);
model.result.numerical('gevs1').setIndex('descr', 'Random response PSD', 0);
model.result.numerical('gevs1').setIndex('expr', 'abs(rom1.eval(V))^2', 1);
model.result.numerical('gevs1').setIndex('unit', 'mm^2', 1);
model.result.numerical('gevs1').setIndex('descr', 'Frequency response squared', 1);
model.result.numerical('gevs1').set('data', 'dset2');
model.result.table.create('tbl1', 'Table');
model.result.table('tbl1').comments('Global Evaluation Sweep 1');
model.result.numerical('gevs1').set('table', 'tbl1');
model.result.numerical('gevs1').setResult;
model.result.create('pg2', 'PlotGroup1D');
model.result('pg2').set('data', 'none');
model.result('pg2').create('tblp1', 'Table');
model.result('pg2').feature('tblp1').set('source', 'table');
model.result('pg2').feature('tblp1').set('table', 'tbl1');
model.result('pg2').feature('tblp1').set('linewidth', 'preference');
model.result('pg2').feature('tblp1').set('markerpos', 'datapoints');
model.result('pg2').run;
model.result('pg2').feature('tblp1').set('linemarker', 'cycle');
model.result('pg2').feature('tblp1').set('markerpos', 'interp');
model.result('pg2').feature('tblp1').set('legend', true);
model.result('pg2').run;
model.result('pg2').set('xextra', 42.65);
model.result('pg2').set('legendpos', 'upperleft');
model.result('pg2').run;
model.result.numerical.duplicate('gevs2', 'gevs1');
model.result.numerical('gevs2').setIndex('plistarr', '42.66 [Hz]', 0);
model.result.numerical('gevs2').setIndex('expr', 'rvib1.psd(V)', 0);
model.result.numerical('gevs2').setIndex('unit', 'mm^2/Hz', 0);
model.result.numerical('gevs2').setIndex('descr', 'Displacement, y-component, maximum PSD', 0);
model.result.numerical('gevs2').setIndex('expr', 'rvib1.psd(Sb)', 1);
model.result.numerical('gevs2').setIndex('unit', '(N/mm^2)^2/Hz', 1);
model.result.numerical('gevs2').setIndex('descr', 'Bending stress, maximum PSD', 1);
model.result.table.create('tbl2', 'Table');
model.result.table('tbl2').comments('Global Evaluation Sweep 2');
model.result.numerical('gevs2').set('table', 'tbl2');
model.result.numerical('gevs2').setResult;

model.title('Random Vibration Analysis of a Deep Beam');

model.description('In this verification example, forced random vibrations of a simply-supported deep beam are studied. The beam is loaded by a distributed force with a uniform power spectral density (PSD). The output PSD is computed for the displacement and bending stress response. The computed values are compared with analytical results.');

model.label('random_vibration_deep_beam.mph');

model.modelNode.label('Components');

out = model;
