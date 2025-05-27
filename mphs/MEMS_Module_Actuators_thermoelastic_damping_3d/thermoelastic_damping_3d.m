function out = model
%
% thermoelastic_damping_3d.m
%
% Model exported on May 26 2025, 21:30 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/MEMS_Module/Actuators');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 3);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.physics.create('solid', 'SolidMechanics', 'geom1');
model.physics('solid').model('comp1');
model.physics('solid').prop('StructuralTransientBehavior').set('StructuralTransientBehavior', 'IncludeInertia');
model.physics.create('ht', 'HeatTransfer', 'geom1');
model.physics('ht').model('comp1');

model.multiphysics.create('te1', 'ThermalExpansion', 'geom1', 3);
model.multiphysics('te1').set('Heat_physics', 'ht');
model.multiphysics('te1').set('Solid_physics', 'solid');
model.multiphysics('te1').selection.all;

model.study.create('std1');
model.study('std1').create('stat', 'Stationary');
model.study('std1').feature('stat').set('solnum', 'auto');
model.study('std1').feature('stat').set('notsolnum', 'auto');
model.study('std1').feature('stat').set('outputmap', {});
model.study('std1').feature('stat').set('ngenAUX', '1');
model.study('std1').feature('stat').set('goalngenAUX', '1');
model.study('std1').feature('stat').set('ngenAUX', '1');
model.study('std1').feature('stat').set('goalngenAUX', '1');
model.study('std1').feature('stat').setSolveFor('/physics/solid', true);
model.study('std1').feature('stat').setSolveFor('/physics/ht', true);
model.study('std1').feature('stat').setSolveFor('/multiphysics/te1', true);
model.study('std1').create('eig', 'Eigenfrequency');
model.study('std1').feature('eig').set('conrad', '1');
model.study('std1').feature('eig').set('conradynhm', '1');
model.study('std1').feature('eig').set('linpsolnum', 'auto');
model.study('std1').feature('eig').set('solnum', 'auto');
model.study('std1').feature('eig').set('notsolnum', 'auto');
model.study('std1').feature('eig').set('outputmap', {});
model.study('std1').feature('eig').set('ngenAUX', '1');
model.study('std1').feature('eig').set('goalngenAUX', '1');
model.study('std1').feature('eig').set('ngenAUX', '1');
model.study('std1').feature('eig').set('goalngenAUX', '1');
model.study('std1').feature('eig').setSolveFor('/physics/solid', true);
model.study('std1').feature('eig').setSolveFor('/physics/ht', true);
model.study('std1').feature('eig').setSolveFor('/multiphysics/te1', true);

model.geom('geom1').lengthUnit([native2unicode(hex2dec({'00' 'b5'}), 'unicode') 'm']);
model.geom('geom1').create('blk1', 'Block');
model.geom('geom1').feature('blk1').set('size', [400 12 12]);
model.geom('geom1').runPre('fin');

% To import content from file, use:
% model.param.loadFile('FILENAME');
model.param.set('E0', '157[GPa]', 'Young''s modulus');
model.param.set('rho0', '2330[kg/m^3]', 'Density');
model.param.set('nu0', '0.3', 'Poisson''s ratio');
model.param.set('alpha0', '2.6e-6[1/K]', 'Coefficient of thermal expansion');
model.param.set('Cp0', '700[J/(kg*K)]', 'Heat capacity');
model.param.set('kappa0', '90[W/(m*K)]', 'Thermal conductivity');

model.geom('geom1').run;

model.material.create('mat1', 'Common', 'comp1');
model.material('mat1').propertyGroup.create('Enu', 'Young''s_modulus_and_Poisson''s_ratio');
model.material('mat1').propertyGroup('Enu').set('E', {'E0'});
model.material('mat1').propertyGroup('Enu').set('nu', {'nu0'});
model.material('mat1').propertyGroup('def').set('density', {'rho0'});
model.material('mat1').propertyGroup('def').set('thermalconductivity', {'kappa0'});
model.material('mat1').propertyGroup('def').set('heatcapacity', {'Cp0'});
model.material('mat1').propertyGroup('def').set('thermalexpansioncoefficient', {'alpha0'});

model.physics('solid').create('fix1', 'Fixed', 2);
model.physics('solid').feature('fix1').selection.set([1 6]);
model.physics('solid').create('sym1', 'SymmetrySolid', 2);
model.physics('solid').feature('sym1').selection.set([2]);
model.physics('ht').create('temp1', 'TemperatureBoundary', 2);
model.physics('ht').feature('temp1').selection.set([1 6]);

model.mesh('mesh1').create('map1', 'Map');
model.mesh('mesh1').feature('map1').selection.set([1]);
model.mesh('mesh1').feature('map1').create('dis1', 'Distribution');
model.mesh('mesh1').feature('map1').feature('dis1').selection.set([1 2]);
model.mesh('mesh1').create('swe1', 'Sweep');
model.mesh('mesh1').feature('swe1').create('dis1', 'Distribution');
model.mesh('mesh1').feature('swe1').feature('dis1').set('numelem', 70);
model.mesh('mesh1').run;

model.study('std1').feature('eig').set('neigsactive', true);
model.study('std1').feature('eig').set('neigs', 1);
model.study('std1').feature('eig').set('shiftactive', true);
model.study('std1').feature('eig').set('shift', '0.63e6');
model.study('std1').feature('eig').set('eigwhich', 'lr');

model.sol.create('sol1');
model.sol('sol1').study('std1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'stat');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').set('control', 'stat');
model.sol('sol1').create('s1', 'Stationary');
model.sol('sol1').feature('s1').feature('aDef').set('cachepattern', true);
model.sol('sol1').feature('s1').create('se1', 'Segregated');
model.sol('sol1').feature('s1').feature('se1').feature.remove('ssDef');
model.sol('sol1').feature('s1').feature('se1').create('ss1', 'SegregatedStep');
model.sol('sol1').feature('s1').feature('se1').feature('ss1').set('segvar', {'comp1_T'});
model.sol('sol1').feature('s1').feature('se1').feature('ss1').set('subdamp', 1);
model.sol('sol1').feature('s1').create('d1', 'Direct');
model.sol('sol1').feature('s1').feature('d1').set('linsolver', 'pardiso');
model.sol('sol1').feature('s1').feature('d1').set('pivotperturb', 1.0E-13);
model.sol('sol1').feature('s1').feature('d1').label('Direct, heat transfer variables ht (te1)');
model.sol('sol1').feature('s1').feature('se1').feature('ss1').set('linsolver', 'd1');
model.sol('sol1').feature('s1').feature('se1').feature('ss1').label('Temperature');
model.sol('sol1').feature('s1').feature('se1').create('ss2', 'SegregatedStep');
model.sol('sol1').feature('s1').feature('se1').feature('ss2').set('segvar', {'comp1_u'});
model.sol('sol1').feature('s1').create('d2', 'Direct');
model.sol('sol1').feature('s1').feature('d2').set('linsolver', 'pardiso');
model.sol('sol1').feature('s1').feature('d2').set('pivotperturb', 1.0E-9);
model.sol('sol1').feature('s1').feature('d2').label('Suggested Direct Solver solid (te1)');
model.sol('sol1').feature('s1').feature('se1').feature('ss2').set('linsolver', 'd2');
model.sol('sol1').feature('s1').feature('se1').feature('ss2').label('Solid Mechanics');
model.sol('sol1').feature('s1').feature('se1').set('segtermonres', 'off');
model.sol('sol1').feature('s1').feature('se1').create('ll1', 'LowerLimit');
model.sol('sol1').feature('s1').feature('se1').feature('ll1').set('lowerlimit', 'comp1.T 0 ');
model.sol('sol1').feature('s1').create('i1', 'Iterative');
model.sol('sol1').feature('s1').feature('i1').set('linsolver', 'gmres');
model.sol('sol1').feature('s1').feature('i1').set('rhob', 400);
model.sol('sol1').feature('s1').feature('i1').set('nlinnormuse', true);
model.sol('sol1').feature('s1').feature('i1').label('Suggested Iterative Solver solid (te1)');
model.sol('sol1').feature('s1').feature('i1').create('mg1', 'Multigrid');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').set('prefun', 'gmg');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('pr').create('so1', 'SOR');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('pr').feature('so1').set('relax', 0.8);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('po').create('so1', 'SOR');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('po').feature('so1').set('relax', 0.8);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('cs').create('d1', 'Direct');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('cs').feature('d1').set('linsolver', 'pardiso');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('cs').feature('d1').set('pivotperturb', 1.0E-9);
model.sol('sol1').feature('s1').create('i2', 'Iterative');
model.sol('sol1').feature('s1').feature('i2').set('linsolver', 'gmres');
model.sol('sol1').feature('s1').feature('i2').set('prefuntype', 'left');
model.sol('sol1').feature('s1').feature('i2').set('itrestart', 50);
model.sol('sol1').feature('s1').feature('i2').set('rhob', 20);
model.sol('sol1').feature('s1').feature('i2').set('maxlinit', 10000);
model.sol('sol1').feature('s1').feature('i2').set('nlinnormuse', 'on');
model.sol('sol1').feature('s1').feature('i2').label('AMG, heat transfer variables ht (te1)');
model.sol('sol1').feature('s1').feature('i2').create('mg1', 'Multigrid');
model.sol('sol1').feature('s1').feature('i2').feature('mg1').set('prefun', 'saamg');
model.sol('sol1').feature('s1').feature('i2').feature('mg1').set('mgcycle', 'v');
model.sol('sol1').feature('s1').feature('i2').feature('mg1').set('maxcoarsedof', 50000);
model.sol('sol1').feature('s1').feature('i2').feature('mg1').set('strconn', 0.01);
model.sol('sol1').feature('s1').feature('i2').feature('mg1').set('nullspace', 'constant');
model.sol('sol1').feature('s1').feature('i2').feature('mg1').set('usesmooth', false);
model.sol('sol1').feature('s1').feature('i2').feature('mg1').set('saamgcompwise', true);
model.sol('sol1').feature('s1').feature('i2').feature('mg1').set('loweramg', true);
model.sol('sol1').feature('s1').feature('i2').feature('mg1').set('compactaggregation', false);
model.sol('sol1').feature('s1').feature('i2').feature('mg1').feature('pr').create('so1', 'SOR');
model.sol('sol1').feature('s1').feature('i2').feature('mg1').feature('pr').feature('so1').set('iter', 2);
model.sol('sol1').feature('s1').feature('i2').feature('mg1').feature('pr').feature('so1').set('relax', 0.9);
model.sol('sol1').feature('s1').feature('i2').feature('mg1').feature('po').create('so1', 'SOR');
model.sol('sol1').feature('s1').feature('i2').feature('mg1').feature('po').feature('so1').set('iter', 2);
model.sol('sol1').feature('s1').feature('i2').feature('mg1').feature('po').feature('so1').set('relax', 0.9);
model.sol('sol1').feature('s1').feature('i2').feature('mg1').feature('cs').create('d1', 'Direct');
model.sol('sol1').feature('s1').feature('i2').feature('mg1').feature('cs').feature('d1').set('linsolver', 'pardiso');
model.sol('sol1').feature('s1').feature('i2').feature('mg1').feature('cs').feature('d1').set('pivotperturb', 1.0E-13);
model.sol('sol1').feature('s1').feature.remove('fcDef');
model.sol('sol1').create('su1', 'StoreSolution');
model.sol('sol1').create('st2', 'StudyStep');
model.sol('sol1').feature('st2').set('study', 'std1');
model.sol('sol1').feature('st2').set('studystep', 'eig');
model.sol('sol1').create('v2', 'Variables');
model.sol('sol1').feature('v2').set('initmethod', 'sol');
model.sol('sol1').feature('v2').set('initsol', 'sol1');
model.sol('sol1').feature('v2').set('initsoluse', 'sol2');
model.sol('sol1').feature('v2').set('notsolmethod', 'sol');
model.sol('sol1').feature('v2').set('notsol', 'sol1');
model.sol('sol1').feature('v2').set('control', 'eig');
model.sol('sol1').create('e1', 'Eigenvalue');
model.sol('sol1').feature('e1').set('eigvfunscale', 'maximum');
model.sol('sol1').feature('e1').set('eigvfunscaleparam', '4.0E-10');
model.sol('sol1').feature('e1').set('storelinpoint', true);
model.sol('sol1').feature('e1').set('control', 'eig');
model.sol('sol1').feature('e1').set('linpmethod', 'sol');
model.sol('sol1').feature('e1').set('linpsol', 'sol1');
model.sol('sol1').feature('e1').set('linpsoluse', 'sol2');
model.sol('sol1').feature('e1').set('control', 'eig');
model.sol('sol1').feature('e1').feature('aDef').set('cachepattern', true);
model.sol('sol1').feature('e1').create('d1', 'Direct');
model.sol('sol1').feature('e1').feature('d1').set('linsolver', 'mumps');
model.sol('sol1').feature('e1').feature('d1').set('pivotperturb', 1.0E-13);
model.sol('sol1').feature('e1').feature('d1').label('Direct, heat transfer variables ht (te1) (Merged)');
model.sol('sol1').feature('e1').create('i1', 'Iterative');
model.sol('sol1').feature('e1').feature('i1').set('linsolver', 'gmres');
model.sol('sol1').feature('e1').feature('i1').set('prefuntype', 'left');
model.sol('sol1').feature('e1').feature('i1').set('itrestart', 50);
model.sol('sol1').feature('e1').feature('i1').set('rhob', 20);
model.sol('sol1').feature('e1').feature('i1').set('maxlinit', 10000);
model.sol('sol1').feature('e1').feature('i1').label('AMG, heat transfer variables ht (te1)');
model.sol('sol1').feature('e1').feature('i1').create('mg1', 'Multigrid');
model.sol('sol1').feature('e1').feature('i1').feature('mg1').set('prefun', 'saamg');
model.sol('sol1').feature('e1').feature('i1').feature('mg1').set('mgcycle', 'v');
model.sol('sol1').feature('e1').feature('i1').feature('mg1').set('maxcoarsedof', 50000);
model.sol('sol1').feature('e1').feature('i1').feature('mg1').set('strconn', 0.01);
model.sol('sol1').feature('e1').feature('i1').feature('mg1').set('nullspace', 'constant');
model.sol('sol1').feature('e1').feature('i1').feature('mg1').set('usesmooth', false);
model.sol('sol1').feature('e1').feature('i1').feature('mg1').set('saamgcompwise', true);
model.sol('sol1').feature('e1').feature('i1').feature('mg1').set('loweramg', true);
model.sol('sol1').feature('e1').feature('i1').feature('mg1').set('compactaggregation', false);
model.sol('sol1').feature('e1').feature('i1').feature('mg1').feature('pr').create('so1', 'SOR');
model.sol('sol1').feature('e1').feature('i1').feature('mg1').feature('pr').feature('so1').set('iter', 2);
model.sol('sol1').feature('e1').feature('i1').feature('mg1').feature('pr').feature('so1').set('relax', 0.9);
model.sol('sol1').feature('e1').feature('i1').feature('mg1').feature('po').create('so1', 'SOR');
model.sol('sol1').feature('e1').feature('i1').feature('mg1').feature('po').feature('so1').set('iter', 2);
model.sol('sol1').feature('e1').feature('i1').feature('mg1').feature('po').feature('so1').set('relax', 0.9);
model.sol('sol1').feature('e1').feature('i1').feature('mg1').feature('cs').create('d1', 'Direct');
model.sol('sol1').feature('e1').feature('i1').feature('mg1').feature('cs').feature('d1').set('linsolver', 'pardiso');
model.sol('sol1').feature('e1').feature('i1').feature('mg1').feature('cs').feature('d1').set('pivotperturb', 1.0E-13);
model.sol('sol1').feature('e1').feature('d1').active(true);
model.sol('sol1').feature('v2').set('notsolnum', 'auto');
model.sol('sol1').feature('v2').set('notsolvertype', 'solnum');
model.sol('sol1').attach('std1');
model.sol('sol1').feature('v1').set('scalemethod', 'manual');
model.sol('sol1').runAll;

model.result.create('pg1', 'PlotGroup3D');
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
model.result('pg1').feature('surf1').feature('def').set('expr', {'u' 'v' 'w'});
model.result('pg1').feature('surf1').feature('def').set('descr', 'Displacement field');
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
model.result.create('pg2', 'PlotGroup3D');
model.result('pg2').label('Temperature (ht)');
model.result('pg2').set('data', 'dset1');
model.result('pg2').setIndex('looplevel', 1, 0);
model.result('pg2').set('defaultPlotID', 'ht/HT_PhysicsInterfaces/icom8/pdef1/pcond3/pcond3/pg1');
model.result('pg2').feature.create('vol1', 'Volume');
model.result('pg2').feature('vol1').set('showsolutionparams', 'on');
model.result('pg2').feature('vol1').set('solutionparams', 'parent');
model.result('pg2').feature('vol1').set('expr', 'T');
model.result('pg2').feature('vol1').set('evalmethodactive', 'off');
model.result('pg2').feature('vol1').set('colortable', 'HeatCameraLight');
model.result('pg2').feature('vol1').set('smooth', 'internal');
model.result('pg2').feature('vol1').set('showsolutionparams', 'on');
model.result('pg2').feature('vol1').set('evalmethodactive', 'off');
model.result('pg2').feature('vol1').set('showsolutionparams', 'on');
model.result('pg2').feature('vol1').set('evalmethodactive', 'off');
model.result('pg2').feature('vol1').set('showsolutionparams', 'on');
model.result('pg2').feature('vol1').set('evalmethodactive', 'off');
model.result('pg2').feature('vol1').set('showsolutionparams', 'on');
model.result('pg2').feature('vol1').set('evalmethodactive', 'off');
model.result('pg2').feature('vol1').set('data', 'parent');
model.result('pg1').run;
model.result('pg2').run;
model.result('pg2').set('showlegends', false);
model.result('pg2').run;
model.result('pg2').feature('vol1').create('def1', 'Deform');
model.result('pg2').run;
model.result('pg2').run;
model.result.numerical.create('gev1', 'EvalGlobal');
model.result.numerical('gev1').set('expr', {'solid.Q_eig'});
model.result.numerical('gev1').set('descr', {'Quality factor for eigenvalue'});
model.result.numerical('gev1').set('unit', {'1'});
model.result.table.create('tbl1', 'Table');
model.result.table('tbl1').comments('Global Evaluation 1');
model.result.numerical('gev1').set('table', 'tbl1');
model.result.numerical('gev1').setResult;

model.title('Thermoelastic Damping in a MEMS Resonator');

model.description('Thermoelastic damping is an important factor when designing MEMS resonators. The cyclic deformation of the resonator creates local temperature variations and thermal expansion of the material, which appears as damping. This 3D model shows how to model thermoelastic damping in a MEMS resonator using fully coupled thermal and structural equations.');

model.mesh.clearMeshes;

model.sol('sol1').clearSolutionData;
model.sol('sol2').clearSolutionData;

model.label('thermoelastic_damping_3d.mph');

model.modelNode.label('Components');

out = model;
