function out = model
%
% tuning_fork_shape_optimization.m
%
% Model exported on May 26 2025, 21:31 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/Optimization_Module/Shape_Optimization');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 3);
model.geom('geom1').model('comp1');

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

model.param.set('L', '7.8[cm]');
model.param.descr('L', 'Cylinder length');
model.param.set('R1', '7.5[mm]');
model.param.descr('R1', 'Base radius');
model.param.set('R2', '2.5[mm]');
model.param.descr('R2', 'Prong radius');

model.geom('geom1').create('cone1', 'Cone');
model.geom('geom1').feature('cone1').set('specifytop', 'radius');
model.geom('geom1').feature('cone1').set('r', 'R2');
model.geom('geom1').feature('cone1').set('h', '2e-2');
model.geom('geom1').feature('cone1').set('specifytop', 'angle');
model.geom('geom1').feature('cone1').set('ang', 2);
model.geom('geom1').feature('cone1').set('pos', {'R1' '0' '-R1'});
model.geom('geom1').feature('cone1').set('axistype', 'cartesian');
model.geom('geom1').feature('cone1').set('ax3', [0 0 -1]);
model.geom('geom1').run('cone1');
model.geom('geom1').create('sph1', 'Sphere');
model.geom('geom1').feature('sph1').set('r', '4e-3');
model.geom('geom1').feature('sph1').set('pos', {'R1' '0' '-(R1+2.25e-2)'});
model.geom('geom1').run('sph1');
model.geom('geom1').create('tor1', 'Torus');
model.geom('geom1').feature('tor1').set('rmaj', 'R1');
model.geom('geom1').feature('tor1').set('rmin', 'R2');
model.geom('geom1').feature('tor1').set('angle', 180);
model.geom('geom1').feature('tor1').set('pos', {'R1' '0' '0'});
model.geom('geom1').feature('tor1').set('axistype', 'cartesian');
model.geom('geom1').feature('tor1').set('ax3', [0 1 0]);
model.geom('geom1').feature('tor1').set('rot', -90);
model.geom('geom1').run('tor1');
model.geom('geom1').create('uni1', 'Union');
model.geom('geom1').feature('uni1').set('intbnd', false);
model.geom('geom1').feature('uni1').selection('input').set({'cone1' 'sph1' 'tor1'});
model.geom('geom1').run('uni1');
model.geom('geom1').create('cyl1', 'Cylinder');
model.geom('geom1').feature('cyl1').set('r', 'R2');
model.geom('geom1').feature('cyl1').set('h', 'L');
model.geom('geom1').run('cyl1');
model.geom('geom1').create('cyl2', 'Cylinder');
model.geom('geom1').feature('cyl2').set('r', 'R2');
model.geom('geom1').feature('cyl2').set('h', 'L');
model.geom('geom1').feature('cyl2').set('pos', {'2*R1' '0' '0'});
model.geom('geom1').run('fin');
model.geom('geom1').create('ige1', 'IgnoreEdges');
model.geom('geom1').feature('ige1').selection('input').set('fin', [22 23 29 32 33 39 42 43]);
model.geom('geom1').run('ige1');

model.material.create('mat1', 'Common', 'comp1');
model.material('mat1').propertyGroup.create('Enu', 'Young''s modulus and Poisson''s ratio');
model.material('mat1').label('Steel AISI 4340');
model.material('mat1').set('family', 'steel');
model.material('mat1').propertyGroup('def').set('relpermeability', {'1' '0' '0' '0' '1' '0' '0' '0' '1'});
model.material('mat1').propertyGroup('def').set('electricconductivity', {'4.032e6[S/m]' '0' '0' '0' '4.032e6[S/m]' '0' '0' '0' '4.032e6[S/m]'});
model.material('mat1').propertyGroup('def').set('thermalexpansioncoefficient', {'12.3e-6[1/K]' '0' '0' '0' '12.3e-6[1/K]' '0' '0' '0' '12.3e-6[1/K]'});
model.material('mat1').propertyGroup('def').set('heatcapacity', '475[J/(kg*K)]');
model.material('mat1').propertyGroup('def').set('relpermittivity', {'1' '0' '0' '0' '1' '0' '0' '0' '1'});
model.material('mat1').propertyGroup('def').set('density', '7850[kg/m^3]');
model.material('mat1').propertyGroup('def').set('thermalconductivity', {'44.5[W/(m*K)]' '0' '0' '0' '44.5[W/(m*K)]' '0' '0' '0' '44.5[W/(m*K)]'});
model.material('mat1').propertyGroup('Enu').set('E', '205[GPa]');
model.material('mat1').propertyGroup('Enu').set('nu', '0.28');

model.mesh('mesh1').autoMeshSize(4);
model.mesh('mesh1').create('ftri1', 'FreeTri');
model.mesh('mesh1').feature('ftri1').selection.set([6 24]);
model.mesh('mesh1').run('ftri1');
model.mesh('mesh1').create('swe1', 'Sweep');
model.mesh('mesh1').feature('swe1').selection.geom('geom1', 3);
model.mesh('mesh1').feature('swe1').selection.set([1 3]);
model.mesh('mesh1').feature('swe1').create('dis1', 'Distribution');
model.mesh('mesh1').feature('swe1').feature('dis1').set('numelem', 50);
model.mesh('mesh1').run('swe1');
model.mesh('mesh1').create('ftet1', 'FreeTet');
model.mesh('mesh1').run;

model.study('std1').create('param', 'Parametric');
model.study('std1').feature('param').setIndex('pname', 'L', 0);
model.study('std1').feature('param').setIndex('plistarr', '', 0);
model.study('std1').feature('param').setIndex('punit', 'm', 0);
model.study('std1').feature('param').setIndex('pname', 'L', 0);
model.study('std1').feature('param').setIndex('plistarr', '', 0);
model.study('std1').feature('param').setIndex('punit', 'm', 0);
model.study('std1').feature('param').setIndex('pname', 'L', 0);
model.study('std1').feature('param').setIndex('plistarr', 'range(0.078,1e-4,0.0795)', 0);
model.study('std1').feature('eig').set('neigsactive', true);
model.study('std1').feature('eig').set('neigs', 1);
model.study('std1').feature('eig').set('shift', '440');

model.sol.create('sol1');
model.sol('sol1').study('std1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'eig');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').set('control', 'eig');
model.sol('sol1').create('e1', 'Eigenvalue');
model.sol('sol1').feature('e1').set('eigvfunscale', 'maximum');
model.sol('sol1').feature('e1').set('eigvfunscaleparam', '1.14E-7');
model.sol('sol1').feature('e1').set('control', 'eig');
model.sol('sol1').feature('e1').feature('aDef').set('cachepattern', true);
model.sol('sol1').attach('std1');

model.batch.create('p1', 'Parametric');
model.batch('p1').study('std1');
model.batch('p1').create('so1', 'Solutionseq');
model.batch('p1').feature('so1').set('seq', 'sol1');
model.batch('p1').feature('so1').set('store', 'on');
model.batch('p1').feature('so1').set('clear', 'on');
model.batch('p1').feature('so1').set('psol', 'none');
model.batch('p1').set('pname', {'L'});
model.batch('p1').set('plistarr', {'range(0.078,1e-4,0.0795)'});
model.batch('p1').set('sweeptype', 'sparse');
model.batch('p1').set('probesel', 'all');
model.batch('p1').set('probes', {});
model.batch('p1').set('plot', 'off');
model.batch('p1').set('err', 'on');
model.batch('p1').attach('std1');
model.batch('p1').set('control', 'param');

model.sol('sol1').feature('e1').set('rtol', '1e-3');
model.sol.create('sol2');
model.sol('sol2').study('std1');
model.sol('sol2').label('Parametric Solutions 1');

model.batch('p1').feature('so1').set('psol', 'sol2');
model.batch('p1').run('compute');

model.result.create('pg1', 'PlotGroup3D');
model.result('pg1').set('data', 'dset2');
model.result('pg1').setIndex('looplevel', 1, 0);
model.result('pg1').setIndex('looplevel', 16, 1);
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
model.result('pg1').feature('surf1').feature('def').set('expr', {'u' 'v' 'w'});
model.result('pg1').feature('surf1').feature('def').set('descr', 'Displacement field');
model.result.evaluationGroup.create('std1EvgFrq', 'EvaluationGroup');
model.result.evaluationGroup('std1EvgFrq').set('defaultPlotID', 'eigenfrequenciesTable_solid');
model.result.evaluationGroup('std1EvgFrq').set('data', 'dset2');
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
model.result.numerical.create('gev1', 'EvalGlobal');
model.result.numerical('gev1').set('data', 'dset2');
model.result.numerical('gev1').set('tablecols', 'inner');
model.result.numerical('gev1').set('expr', {'solid.freq'});
model.result.numerical('gev1').set('descr', {'Frequency'});
model.result.numerical('gev1').set('unit', {'Hz'});
model.result.table.create('tbl1', 'Table');
model.result.table('tbl1').comments('Global Evaluation 1');
model.result.numerical('gev1').set('table', 'tbl1');
model.result.numerical('gev1').setResult;
model.result('pg1').run;
model.result('pg1').set('looplevel', [1 12]);
model.result('pg1').run;

model.title('Tuning Fork');

model.description(['This example computes the fundamental eigenfrequency and eigenmode for a tuning fork. When correctly designed, the tuning fork vibrates at 440' native2unicode(hex2dec({'00' 'a0'}), 'unicode') 'Hz, a frequency known as standard concert pitch.']);

model.label('tuning_fork.mph');

model.result('pg1').run;

model.param.set('scaleZ', '1');
model.param.descr('scaleZ', 'Z scaling');

model.common.create('pres1', 'PrescribedDeformationDeformedGeometry', 'comp1');
model.common('pres1').selection.all;

model.geom('geom1').run;

model.common('pres1').selection.set([1 3]);
model.common('pres1').set('prescribedDeformation', {'0' '0' 'Zg*(scaleZ-1)'});

model.probe.create('var1', 'GlobalVariable');
model.probe('var1').model('comp1');
model.probe('var1').label('Scaled Prong Length');
model.probe('var1').set('probename', 'scaledL');
model.probe('var1').set('expr', 'L*scaleZ');

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
model.study('std2').feature('eig').setSolveFor('/physics/solid', true);
model.study('std2').feature('eig').set('neigsactive', true);
model.study('std2').feature('eig').set('neigs', 1);
model.study('std2').feature('eig').set('shift', '440');
model.study('std2').create('opt', 'Optimization');
model.study('std2').feature('opt').set('optsolver', 'ipopt');
model.study('std2').feature('opt').setIndex('optobj', '(freq-440[Hz])^2', 0);
model.study('std2').feature('opt').setIndex('descr', '', 0);
model.study('std2').feature('opt').setIndex('pname', 'L', 0);
model.study('std2').feature('opt').setIndex('initval', '7.8[cm]', 0);
model.study('std2').feature('opt').setIndex('scale', 1, 0);
model.study('std2').feature('opt').setIndex('lbound', '', 0);
model.study('std2').feature('opt').setIndex('ubound', '', 0);
model.study('std2').feature('opt').setIndex('pname', 'L', 0);
model.study('std2').feature('opt').setIndex('initval', '7.8[cm]', 0);
model.study('std2').feature('opt').setIndex('scale', 1, 0);
model.study('std2').feature('opt').setIndex('lbound', '', 0);
model.study('std2').feature('opt').setIndex('ubound', '', 0);
model.study('std2').feature('opt').setIndex('pname', 'scaleZ', 0);
model.study('std2').feature('opt').setIndex('initval', 1, 0);
model.study('std2').feature('opt').setIndex('scale', 1, 0);
model.study('std2').feature('opt').setIndex('lbound', 0.8, 0);
model.study('std2').feature('opt').setIndex('ubound', 1.2, 0);

model.sol.create('sol19');
model.sol('sol19').study('std2');
model.sol('sol19').create('st1', 'StudyStep');
model.sol('sol19').feature('st1').set('study', 'std2');
model.sol('sol19').feature('st1').set('studystep', 'eig');
model.sol('sol19').create('v1', 'Variables');
model.sol('sol19').feature('v1').set('control', 'eig');
model.sol('sol19').create('o1', 'Optimization');
model.sol('sol19').feature('o1').set('control', 'opt');
model.sol('sol19').feature('o1').create('e1', 'EigenvalueAttrib');
model.sol('sol19').feature('o1').feature('e1').set('eigvfunscale', 'maximum');
model.sol('sol19').feature('o1').feature('e1').set('eigvfunscaleparam', '1.14E-7');
model.sol('sol19').feature('o1').feature('e1').set('solveforvars', {'comp1_u' 'conpar2'});
model.sol('sol19').feature('o1').feature('e1').set('control', 'eig');
model.sol('sol19').feature('o1').feature('e1').feature('aDef').set('cachepattern', true);
model.sol('sol19').attach('std2');

model.probe('var1').genResult('none');

model.sol('sol19').runAll;

model.result.create('pg3', 'PlotGroup3D');
model.result('pg3').set('data', 'dset3');
model.result('pg3').setIndex('looplevel', 1, 0);
model.result('pg3').set('defaultPlotID', 'modeShape');
model.result('pg3').label('Mode Shape (solid) 1');
model.result('pg3').set('showlegends', false);
model.result('pg3').create('surf1', 'Surface');
model.result('pg3').feature('surf1').set('expr', {'solid.disp'});
model.result('pg3').feature('surf1').set('threshold', 'manual');
model.result('pg3').feature('surf1').set('thresholdvalue', 0.2);
model.result('pg3').feature('surf1').set('colortable', 'Rainbow');
model.result('pg3').feature('surf1').set('colortabletrans', 'none');
model.result('pg3').feature('surf1').set('colorscalemode', 'linear');
model.result('pg3').feature('surf1').set('colortable', 'AuroraBorealis');
model.result('pg3').feature('surf1').create('def', 'Deform');
model.result('pg3').feature('surf1').feature('def').set('expr', {'u' 'v' 'w'});
model.result('pg3').feature('surf1').feature('def').set('descr', 'Displacement field');
model.result.evaluationGroup.create('std2EvgFrq', 'EvaluationGroup');
model.result.evaluationGroup('std2EvgFrq').set('defaultPlotID', 'eigenfrequenciesTable_solid');
model.result.evaluationGroup('std2EvgFrq').set('data', 'dset3');
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
model.result.create('pg4', 'PlotGroup3D');
model.result('pg4').set('data', 'dset3');
model.result('pg4').setIndex('looplevel', 1, 0);
model.result('pg4').label('Deformed Geometry');
model.result('pg4').create('mesh1', 'Mesh');
model.result('pg4').feature('mesh1').set('meshdomain', 'volume');
model.result('pg4').feature('mesh1').set('colortable', 'TrafficFlow');
model.result('pg4').feature('mesh1').set('colortabletrans', 'nonlinear');
model.result('pg4').feature('mesh1').set('nonlinearcolortablerev', true);
model.result('pg4').feature('mesh1').create('sel1', 'MeshSelection');
model.result('pg4').feature('mesh1').feature('sel1').selection.set([1 3]);
model.result('pg4').feature('mesh1').set('qualmeasure', 'custom');
model.result('pg4').feature('mesh1').set('qualexpr', 'comp1.material.relVol');
model.result('pg4').feature('mesh1').set('colorrangeunitinterval', false);
model.result('pg3').run;

model.study('std2').feature('opt').set('probewindow', '');

model.result('pg2').set('window', 'window1');
model.result('pg2').run;
model.result('pg2').set('window', 'window1');
model.result('pg2').run;

model.title('Shape Optimization of a Tuning Fork');

model.description(['Extending the Tuning Fork model, this example shows how to set up an Optimization Study to determine the prong length at which the fork vibrates at the standard concert pitch, 440' native2unicode(hex2dec({'00' 'a0'}), 'unicode') 'Hz.']);

model.mesh.clearMeshes;

model.sol('sol1').clearSolutionData;
model.sol('sol2').clearSolutionData;
model.sol('sol3').clearSolutionData;
model.sol('sol4').clearSolutionData;
model.sol('sol5').clearSolutionData;
model.sol('sol6').clearSolutionData;
model.sol('sol7').clearSolutionData;
model.sol('sol8').clearSolutionData;
model.sol('sol9').clearSolutionData;
model.sol('sol10').clearSolutionData;
model.sol('sol11').clearSolutionData;
model.sol('sol12').clearSolutionData;
model.sol('sol13').clearSolutionData;
model.sol('sol14').clearSolutionData;
model.sol('sol15').clearSolutionData;
model.sol('sol16').clearSolutionData;
model.sol('sol17').clearSolutionData;
model.sol('sol18').clearSolutionData;
model.sol('sol19').clearSolutionData;

model.label('tuning_fork_shape_optimization.mph');

model.modelNode.label('Components');

out = model;
