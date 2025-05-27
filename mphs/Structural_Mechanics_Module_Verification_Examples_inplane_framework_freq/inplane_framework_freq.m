function out = model
%
% inplane_framework_freq.m
%
% Model exported on May 26 2025, 21:34 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/Structural_Mechanics_Module/Verification_Examples');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 2);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.physics.create('beam', 'HermitianBeam', 'geom1');
model.physics('beam').model('comp1');

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
model.study('std1').feature('eig').setSolveFor('/physics/beam', true);

model.common.create('mpf1', 'ParticipationFactors', 'comp1');

% To import content from file, use:
% model.param.loadFile('FILENAME');
model.param.set('a', '0.03[m]', 'Side length');
model.param.set('Emod', '200[GPa]', 'Young''s modulus');
model.param.set('I', '(a)^4/12', 'Area moment of inertia');
model.param.set('L', '1[m]', 'Framework member length');
model.param.set('m', '1000[kg]', 'Point mass');
model.param.set('r', 'L/4', 'Point mass radius');
model.param.set('J', 'm*r^2', 'Point mass moment of inertia');
model.param.set('w1', 'sqrt(48*Emod*I/(m*L^3))', 'Angular frequency, eigenfrequency 1');
model.param.set('w2', 'sqrt(48*32*Emod*I/(7*m*L^3))', 'Angular frequency, eigenfrequency 2');
model.param.set('f1', 'w1/(2*pi)', 'Eigenfrequency 1, analytical');
model.param.set('f2', 'w2/(2*pi)', 'Eigenfrequency 2, analytical');

model.geom('geom1').create('pol1', 'Polygon');
model.geom('geom1').feature('pol1').set('source', 'table');
model.geom('geom1').feature('pol1').set('type', 'open');
model.geom('geom1').feature('pol1').setIndex('table', 0, 0, 0);
model.geom('geom1').feature('pol1').setIndex('table', 0, 0, 1);
model.geom('geom1').feature('pol1').setIndex('table', 0, 1, 0);
model.geom('geom1').feature('pol1').setIndex('table', 'L', 1, 1);
model.geom('geom1').feature('pol1').setIndex('table', 'L/2', 2, 0);
model.geom('geom1').feature('pol1').setIndex('table', 'L', 2, 1);
model.geom('geom1').feature('pol1').setIndex('table', 'L', 3, 0);
model.geom('geom1').feature('pol1').setIndex('table', 'L', 3, 1);
model.geom('geom1').runPre('fin');
model.geom('geom1').run;

model.material.create('mat1', 'Common', 'comp1');
model.material('mat1').propertyGroup.create('Enu', 'Young''s_modulus_and_Poisson''s_ratio');
model.material('mat1').propertyGroup('Enu').set('E', {'Emod'});
model.material('mat1').propertyGroup('Enu').set('nu', {'0'});
model.material('mat1').propertyGroup('def').set('density', {'0'});

model.physics('beam').feature('csd1').set('SectionType', 'RectangularSection');
model.physics('beam').feature('csd1').set('hy_rect', 'a');
model.physics('beam').feature('csd1').set('hz_rect', 'a');
model.physics('beam').create('pin1', 'Pinned', 0);
model.physics('beam').feature('pin1').selection.set([1 4]);
model.physics('beam').create('pm1', 'PointMass', 0);
model.physics('beam').feature('pm1').selection.set([3]);
model.physics('beam').feature('pm1').set('pointmass', 'm');
model.physics('beam').create('pm2', 'PointMass', 0);
model.physics('beam').feature('pm2').selection.set([2]);
model.physics('beam').feature('pm2').set('mmi2D', 'J');

model.study('std1').feature('eig').set('neigsactive', true);
model.study('std1').feature('eig').set('neigs', 2);

model.sol.create('sol1');
model.sol('sol1').study('std1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'eig');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').set('control', 'eig');
model.sol('sol1').create('e1', 'Eigenvalue');
model.sol('sol1').feature('e1').set('eigvfunscale', 'maximum');
model.sol('sol1').feature('e1').set('eigvfunscaleparam', '1.4099999999999998E-6');
model.sol('sol1').feature('e1').set('control', 'eig');
model.sol('sol1').feature('e1').feature('aDef').set('cachepattern', true);
model.sol('sol1').attach('std1');
model.sol('sol1').runAll;

model.result.create('pg1', 'PlotGroup2D');
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
model.result('pg1').feature('line1').feature('def').set('expr', {'u' 'v'});
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
model.result('pg1').run;
model.result('pg1').run;
model.result('pg1').set('looplevel', [2]);
model.result('pg1').run;
model.result.numerical.create('gev1', 'EvalGlobal');
model.result.numerical('gev1').label('Eigenfrequency Comparison');
model.result.numerical('gev1').setIndex('expr', 'f1', 0);
model.result.numerical('gev1').setIndex('unit', '1/s', 0);
model.result.numerical('gev1').setIndex('descr', 'Eigenfrequency 1, analytical', 0);
model.result.numerical('gev1').setIndex('expr', 'f2', 1);
model.result.numerical('gev1').setIndex('unit', '1/s', 1);
model.result.numerical('gev1').setIndex('descr', 'Eigenfrequency 2, analytical', 1);
model.result.table.create('tbl1', 'Table');
model.result.table('tbl1').comments('Eigenfrequency Comparison');
model.result.numerical('gev1').set('table', 'tbl1');
model.result.numerical('gev1').setResult;
model.result.evaluationGroup('std1mpf1').run;
model.result.numerical.create('gev2', 'EvalGlobal');
model.result.numerical('gev2').label('Summed Modal Masses');
model.result.numerical('gev2').set('expr', {'mpf1.mEffLY'});
model.result.numerical('gev2').set('descr', {'Effective modal mass, Y-translation'});
model.result.numerical('gev2').set('unit', {'kg'});
model.result.numerical('gev2').setIndex('expr', 'mpf1.mEffLY', 0);
model.result.numerical('gev2').setIndex('unit', 'kg', 0);
model.result.numerical('gev2').setIndex('descr', 'Effective modal mass, Y-translation', 0);
model.result.numerical('gev2').setIndex('expr', 'mpf1.mEffRZ', 1);
model.result.numerical('gev2').setIndex('unit', 'kg*m^2', 1);
model.result.numerical('gev2').setIndex('descr', 'Effective modal mass, Z-rotation', 1);
model.result.numerical('gev2').set('dataseries', 'integral');
model.result.numerical('gev2').set('dataseriesmethod', 'summation');
model.result.table.create('tbl2', 'Table');
model.result.table('tbl2').comments('Summed Modal Masses');
model.result.numerical('gev2').set('table', 'tbl2');
model.result.numerical('gev2').setResult;
model.result('pg1').run;

model.title('In-Plane Framework with Discrete Mass and Mass Moment of Inertia');

model.description('This example calculates the eigenfrequencies for a simple in-plane framework with point mass and point mass moment of inertia. The framework is modeled using the Beam interface. The eigenfrequencies are compared with analytical values.');

model.label('inplane_framework_freq.mph');

model.modelNode.label('Components');

out = model;
