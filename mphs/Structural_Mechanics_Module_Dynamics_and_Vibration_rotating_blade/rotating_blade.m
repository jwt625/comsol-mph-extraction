function out = model
%
% rotating_blade.m
%
% Model exported on May 26 2025, 21:33 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/Structural_Mechanics_Module/Dynamics_and_Vibration');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 3);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.physics.create('solid', 'SolidMechanics', 'geom1');
model.physics('solid').model('comp1');

model.study.create('std1');
model.study('std1').create('stat', 'Stationary');
model.study('std1').feature('stat').set('outputmap', {});
model.study('std1').feature('stat').set('ngenAUX', '1');
model.study('std1').feature('stat').set('goalngenAUX', '1');
model.study('std1').feature('stat').set('ngenAUX', '1');
model.study('std1').feature('stat').set('goalngenAUX', '1');
model.study('std1').feature('stat').setSolveFor('/physics/solid', true);
model.study('std1').create('eig', 'Eigenfrequency');
model.study('std1').feature('eig').set('chkeigregion', true);
model.study('std1').feature('eig').set('conrad', '1');
model.study('std1').feature('eig').set('conradynhm', '1');
model.study('std1').feature('eig').set('storefact', false);
model.study('std1').feature('eig').set('geometricNonlinearity', true);
model.study('std1').feature('eig').set('outputmap', {});
model.study('std1').feature('eig').set('ngenAUX', '1');
model.study('std1').feature('eig').set('goalngenAUX', '1');
model.study('std1').feature('eig').set('ngenAUX', '1');
model.study('std1').feature('eig').set('goalngenAUX', '1');
model.study('std1').feature('eig').setSolveFor('/physics/solid', true);

model.common.create('mpf1', 'ParticipationFactors', 'comp1');

model.view('view1').set('showgrid', false);

model.param.set('Omega', '0*pi[rad/s]');
model.param.descr('Omega', 'Angular velocity');
model.param.set('L', '5[in]');
model.param.descr('L', 'Blade length');
model.param.set('b', '1[in]');
model.param.descr('b', 'Blade width');
model.param.set('d', '0.0625[in]');
model.param.descr('d', 'Blade thickness');
model.param.set('E0', '221[GPa]');
model.param.descr('E0', 'Young''s modulus');
model.param.set('rho0', '7850[kg/m^3]');
model.param.descr('rho0', 'Density');
model.param.set('r', '10[in]');
model.param.descr('r', 'Inner radius');
model.param.set('mpl', 'rho0*b*d');
model.param.descr('mpl', 'Mass per unit length');
model.param.set('I', 'b*d^3/12');
model.param.descr('I', 'Area moment of inertia');
model.param.set('f_0', '1.875^2*sqrt(E0*I/(mpl*L^4))/(2*pi)');
model.param.descr('f_0', 'Euler beam resonance frequency');
model.param.set('f_ref', 'f_0*sqrt(1+mpl*Omega^2*r^4/(E0*I)*((L/r)^3/8+(L/r)^4*(1/10.6-1/12.45)))');
model.param.descr('f_ref', 'Reference resonance frequency');

model.geom('geom1').create('blk1', 'Block');
model.geom('geom1').feature('blk1').set('size', {'L' 'b' 'd'});
model.geom('geom1').feature('blk1').set('pos', {'r' '0' '-d/2'});
model.geom('geom1').run('blk1');
model.geom('geom1').run('fin');

model.material.create('mat1', 'Common', 'comp1');
model.material('mat1').propertyGroup.create('Enu', 'Young''s_modulus_and_Poisson''s_ratio');
model.material('mat1').propertyGroup('Enu').set('E', {'E0'});
model.material('mat1').propertyGroup('Enu').set('nu', {'0'});
model.material('mat1').propertyGroup('def').set('density', {'rho0'});

model.physics('solid').create('rotf1', 'RotatingFrame', 3);
model.physics('solid').feature('rotf1').set('AxisOfRotation', 'yAxis');
model.physics('solid').feature('rotf1').set('Ovm', 'Omega');
model.physics('solid').create('fix1', 'Fixed', 2);
model.physics('solid').feature('fix1').selection.set([1]);

model.mesh('mesh1').create('map1', 'Map');
model.mesh('mesh1').feature('map1').selection.set([4]);
model.mesh('mesh1').feature('map1').create('dis1', 'Distribution');
model.mesh('mesh1').feature('map1').feature('dis1').selection.set([4]);
model.mesh('mesh1').feature('map1').create('dis2', 'Distribution');
model.mesh('mesh1').feature('map1').feature('dis2').selection.set([5]);
model.mesh('mesh1').feature('map1').feature('dis2').set('numelem', 25);
model.mesh('mesh1').run('map1');
model.mesh('mesh1').create('swe1', 'Sweep');
model.mesh('mesh1').feature('swe1').create('dis1', 'Distribution');
model.mesh('mesh1').feature('swe1').feature('dis1').set('numelem', 4);
model.mesh('mesh1').run;

model.sol.create('sol1');
model.sol('sol1').study('std1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'stat');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').set('control', 'stat');
model.sol('sol1').create('s1', 'Stationary');
model.sol('sol1').feature('s1').feature('aDef').set('cachepattern', true);
model.sol('sol1').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('s1').feature('fc1').set('termonres', 'auto');
model.sol('sol1').feature('s1').feature('fc1').set('reserrfact', 1000);
model.sol('sol1').feature('s1').create('d1', 'Direct');
model.sol('sol1').feature('s1').feature('d1').set('linsolver', 'pardiso');
model.sol('sol1').feature('s1').feature('d1').set('pivotperturb', 1.0E-9);
model.sol('sol1').feature('s1').feature('d1').label('Suggested Direct Solver (solid)');
model.sol('sol1').feature('s1').create('i1', 'Iterative');
model.sol('sol1').feature('s1').feature('i1').set('linsolver', 'gmres');
model.sol('sol1').feature('s1').feature('i1').set('rhob', 400);
model.sol('sol1').feature('s1').feature('i1').set('nlinnormuse', true);
model.sol('sol1').feature('s1').feature('i1').label('Suggested Iterative Solver (solid)');
model.sol('sol1').feature('s1').feature('i1').create('mg1', 'Multigrid');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').set('prefun', 'gmg');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('pr').create('so1', 'SOR');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('pr').feature('so1').set('relax', 0.8);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('po').create('so1', 'SOR');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('po').feature('so1').set('relax', 0.8);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('cs').create('d1', 'Direct');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('cs').feature('d1').set('linsolver', 'pardiso');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('cs').feature('d1').set('pivotperturb', 1.0E-9);
model.sol('sol1').feature('s1').feature('fc1').set('linsolver', 'd1');
model.sol('sol1').feature('s1').feature('fc1').set('termonres', 'auto');
model.sol('sol1').feature('s1').feature('fc1').set('reserrfact', 1000);
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
model.sol('sol1').feature('e1').set('eigvfunscaleparam', '1.3E-7');
model.sol('sol1').feature('e1').set('storelinpoint', true);
model.sol('sol1').feature('e1').set('control', 'eig');
model.sol('sol1').feature('e1').set('linpmethod', 'sol');
model.sol('sol1').feature('e1').set('linpsol', 'sol1');
model.sol('sol1').feature('e1').set('linpsoluse', 'sol2');
model.sol('sol1').feature('e1').set('control', 'eig');
model.sol('sol1').feature('e1').feature('aDef').set('cachepattern', true);
model.sol('sol1').feature('v2').set('notsolnum', 'auto');
model.sol('sol1').feature('v2').set('notsolvertype', 'solnum');
model.sol('sol1').attach('std1');
model.sol('sol1').runAll;

model.result.dataset('dset1').set('frametype', 'spatial');
model.result.create('pg1', 'PlotGroup3D');
model.result('pg1').set('data', 'dset1');
model.result('pg1').setIndex('looplevel', 1, 0);
model.result('pg1').set('frametype', 'spatial');
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
model.result.numerical.create('gev1', 'EvalGlobal');
model.result.numerical('gev1').setIndex('looplevelinput', 'first', 0);
model.result.numerical('gev1').set('expr', {'f_ref'});
model.result.numerical('gev1').set('descr', {'Reference resonance frequency'});
model.result.numerical('gev1').set('unit', {'rad/s'});
model.result.table.create('tbl1', 'Table');
model.result.table('tbl1').comments('Global Evaluation 1');
model.result.numerical('gev1').set('table', 'tbl1');
model.result.numerical('gev1').setResult;

model.param.set('Omega', '0*pi[rad/s]', 'Angular velocity');
model.param.set('Omega', '100*pi[rad/s]');
model.param.descr('Omega', 'Angular velocity');

model.sol('sol1').study('std1');

model.study('std1').feature('eig').set('notsolnum', 'auto');
model.study('std1').feature('eig').set('notsolvertype', 'solnum');
model.study('std1').feature('eig').set('notsolnumhide', 'off');
model.study('std1').feature('eig').set('notstudyhide', 'off');
model.study('std1').feature('eig').set('notsolhide', 'off');

model.sol('sol2').copySolution('sol3');

model.study('std1').feature('eig').set('notlistsolnum', 1);
model.study('std1').feature('eig').set('notsolnum', 'auto');
model.study('std1').feature('eig').set('listsolnum', 1);
model.study('std1').feature('eig').set('solnum', 'auto');
model.study('std1').feature('eig').set('linplistsolnum', {'1'});
model.study('std1').feature('eig').set('linpsolnum', 'auto');
model.study('std1').feature('eig').set('notlistsolnum', 1);
model.study('std1').feature('eig').set('notsolnum', 'auto');
model.study('std1').feature('eig').set('listsolnum', 1);
model.study('std1').feature('eig').set('solnum', 'auto');
model.study('std1').feature('eig').set('linplistsolnum', {'1'});
model.study('std1').feature('eig').set('linpsolnum', 'auto');

model.result.dataset('dset2').set('solution', 'none');

model.sol('sol1').feature.remove('e1');
model.sol('sol1').feature.remove('v2');
model.sol('sol1').feature.remove('st2');
model.sol('sol1').feature.remove('su1');
model.sol('sol1').feature.remove('s1');
model.sol('sol1').feature.remove('v1');
model.sol('sol1').feature.remove('st1');
model.sol('sol3').copySolution('sol2');
model.sol.remove('sol3');
model.sol('sol2').label('Solution Store 1');

model.result.dataset.remove('dset4');

model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'stat');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').set('control', 'stat');
model.sol('sol1').create('s1', 'Stationary');
model.sol('sol1').feature('s1').feature('aDef').set('cachepattern', true);
model.sol('sol1').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('s1').feature('fc1').set('termonres', 'auto');
model.sol('sol1').feature('s1').feature('fc1').set('reserrfact', 1000);
model.sol('sol1').feature('s1').create('d1', 'Direct');
model.sol('sol1').feature('s1').feature('d1').set('linsolver', 'pardiso');
model.sol('sol1').feature('s1').feature('d1').set('pivotperturb', 1.0E-9);
model.sol('sol1').feature('s1').feature('d1').label('Suggested Direct Solver (solid)');
model.sol('sol1').feature('s1').create('i1', 'Iterative');
model.sol('sol1').feature('s1').feature('i1').set('linsolver', 'gmres');
model.sol('sol1').feature('s1').feature('i1').set('rhob', 400);
model.sol('sol1').feature('s1').feature('i1').set('nlinnormuse', true);
model.sol('sol1').feature('s1').feature('i1').label('Suggested Iterative Solver (solid)');
model.sol('sol1').feature('s1').feature('i1').create('mg1', 'Multigrid');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').set('prefun', 'gmg');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('pr').create('so1', 'SOR');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('pr').feature('so1').set('relax', 0.8);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('po').create('so1', 'SOR');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('po').feature('so1').set('relax', 0.8);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('cs').create('d1', 'Direct');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('cs').feature('d1').set('linsolver', 'pardiso');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('cs').feature('d1').set('pivotperturb', 1.0E-9);
model.sol('sol1').feature('s1').feature('fc1').set('linsolver', 'd1');
model.sol('sol1').feature('s1').feature('fc1').set('termonres', 'auto');
model.sol('sol1').feature('s1').feature('fc1').set('reserrfact', 1000);
model.sol('sol1').feature('s1').feature.remove('fcDef');
model.sol('sol1').create('su1', 'StoreSolution');
model.sol('sol1').feature('su1').set('sol', 'sol2');
model.sol('sol1').feature('su1').label('Solution Store 1');
model.sol('sol1').create('st2', 'StudyStep');
model.sol('sol1').feature('st2').set('study', 'std1');
model.sol('sol1').feature('st2').set('studystep', 'eig');

model.study('std1').feature('eig').set('initsoluse', 'sol2');
model.study('std1').feature('eig').set('linpsoluse', 'sol2');

model.sol('sol1').create('v2', 'Variables');
model.sol('sol1').feature('v2').set('initmethod', 'sol');
model.sol('sol1').feature('v2').set('initsol', 'sol1');
model.sol('sol1').feature('v2').set('initsoluse', 'sol2');
model.sol('sol1').feature('v2').set('notsolmethod', 'sol');
model.sol('sol1').feature('v2').set('notsol', 'sol1');
model.sol('sol1').feature('v2').set('control', 'eig');
model.sol('sol1').create('e1', 'Eigenvalue');
model.sol('sol1').feature('e1').set('eigvfunscale', 'maximum');
model.sol('sol1').feature('e1').set('eigvfunscaleparam', '1.3E-7');
model.sol('sol1').feature('e1').set('storelinpoint', true);
model.sol('sol1').feature('e1').set('control', 'eig');
model.sol('sol1').feature('e1').set('linpmethod', 'sol');
model.sol('sol1').feature('e1').set('linpsol', 'sol1');
model.sol('sol1').feature('e1').set('linpsoluse', 'sol2');
model.sol('sol1').feature('e1').set('control', 'eig');
model.sol('sol1').feature('e1').feature('aDef').set('cachepattern', true);

model.result.dataset('dset2').set('solution', 'sol2');

model.sol('sol1').feature('v2').set('notsolnum', 'auto');
model.sol('sol1').feature('v2').set('notsolvertype', 'solnum');

model.study('std1').feature('eig').set('notsolnum', 'auto');
model.study('std1').feature('eig').set('notsolvertype', 'solnum');
model.study('std1').feature('eig').set('notsolnumhide', 'off');
model.study('std1').feature('eig').set('notstudyhide', 'off');
model.study('std1').feature('eig').set('notsolhide', 'off');

model.sol('sol1').attach('std1');
model.sol('sol1').runAll;

model.result('pg1').run;
model.result.numerical('gev1').set('table', 'tbl1');
model.result.numerical('gev1').appendResult;

model.physics('solid').feature('rotf1').set('CoriolisForce', true);

model.sol('sol1').study('std1');

model.study('std1').feature('eig').set('notsolnum', 'auto');
model.study('std1').feature('eig').set('notsolvertype', 'solnum');
model.study('std1').feature('eig').set('notsolnumhide', 'off');
model.study('std1').feature('eig').set('notstudyhide', 'off');
model.study('std1').feature('eig').set('notsolhide', 'off');

model.sol('sol2').copySolution('sol3');

model.study('std1').feature('eig').set('notlistsolnum', 1);
model.study('std1').feature('eig').set('notsolnum', 'auto');
model.study('std1').feature('eig').set('listsolnum', 1);
model.study('std1').feature('eig').set('solnum', 'auto');
model.study('std1').feature('eig').set('linplistsolnum', {'1'});
model.study('std1').feature('eig').set('linpsolnum', 'auto');
model.study('std1').feature('eig').set('notlistsolnum', 1);
model.study('std1').feature('eig').set('notsolnum', 'auto');
model.study('std1').feature('eig').set('listsolnum', 1);
model.study('std1').feature('eig').set('solnum', 'auto');
model.study('std1').feature('eig').set('linplistsolnum', {'1'});
model.study('std1').feature('eig').set('linpsolnum', 'auto');

model.result.dataset('dset2').set('solution', 'none');

model.sol('sol1').feature.remove('e1');
model.sol('sol1').feature.remove('v2');
model.sol('sol1').feature.remove('st2');
model.sol('sol1').feature.remove('su1');
model.sol('sol1').feature.remove('s1');
model.sol('sol1').feature.remove('v1');
model.sol('sol1').feature.remove('st1');
model.sol('sol3').copySolution('sol2');
model.sol.remove('sol3');
model.sol('sol2').label('Solution Store 1');

model.result.dataset.remove('dset4');

model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'stat');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').set('control', 'stat');
model.sol('sol1').create('s1', 'Stationary');
model.sol('sol1').feature('s1').feature('aDef').set('cachepattern', true);
model.sol('sol1').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('s1').feature('fc1').set('termonres', 'auto');
model.sol('sol1').feature('s1').feature('fc1').set('reserrfact', 1000);
model.sol('sol1').feature('s1').create('d1', 'Direct');
model.sol('sol1').feature('s1').feature('d1').set('linsolver', 'pardiso');
model.sol('sol1').feature('s1').feature('d1').set('pivotperturb', 1.0E-9);
model.sol('sol1').feature('s1').feature('d1').label('Suggested Direct Solver (solid)');
model.sol('sol1').feature('s1').create('i1', 'Iterative');
model.sol('sol1').feature('s1').feature('i1').set('linsolver', 'gmres');
model.sol('sol1').feature('s1').feature('i1').set('rhob', 400);
model.sol('sol1').feature('s1').feature('i1').set('nlinnormuse', true);
model.sol('sol1').feature('s1').feature('i1').label('Suggested Iterative Solver (solid)');
model.sol('sol1').feature('s1').feature('i1').create('mg1', 'Multigrid');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').set('prefun', 'gmg');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('pr').create('so1', 'SOR');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('pr').feature('so1').set('relax', 0.8);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('po').create('so1', 'SOR');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('po').feature('so1').set('relax', 0.8);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('cs').create('d1', 'Direct');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('cs').feature('d1').set('linsolver', 'pardiso');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('cs').feature('d1').set('pivotperturb', 1.0E-9);
model.sol('sol1').feature('s1').feature('fc1').set('linsolver', 'd1');
model.sol('sol1').feature('s1').feature('fc1').set('termonres', 'auto');
model.sol('sol1').feature('s1').feature('fc1').set('reserrfact', 1000);
model.sol('sol1').feature('s1').feature.remove('fcDef');
model.sol('sol1').create('su1', 'StoreSolution');
model.sol('sol1').feature('su1').set('sol', 'sol2');
model.sol('sol1').feature('su1').label('Solution Store 1');
model.sol('sol1').create('st2', 'StudyStep');
model.sol('sol1').feature('st2').set('study', 'std1');
model.sol('sol1').feature('st2').set('studystep', 'eig');

model.study('std1').feature('eig').set('initsoluse', 'sol2');
model.study('std1').feature('eig').set('linpsoluse', 'sol2');

model.sol('sol1').create('v2', 'Variables');
model.sol('sol1').feature('v2').set('initmethod', 'sol');
model.sol('sol1').feature('v2').set('initsol', 'sol1');
model.sol('sol1').feature('v2').set('initsoluse', 'sol2');
model.sol('sol1').feature('v2').set('notsolmethod', 'sol');
model.sol('sol1').feature('v2').set('notsol', 'sol1');
model.sol('sol1').feature('v2').set('control', 'eig');
model.sol('sol1').create('e1', 'Eigenvalue');
model.sol('sol1').feature('e1').set('eigvfunscale', 'maximum');
model.sol('sol1').feature('e1').set('eigvfunscaleparam', '1.3E-7');
model.sol('sol1').feature('e1').set('storelinpoint', true);
model.sol('sol1').feature('e1').set('control', 'eig');
model.sol('sol1').feature('e1').set('linpmethod', 'sol');
model.sol('sol1').feature('e1').set('linpsol', 'sol1');
model.sol('sol1').feature('e1').set('linpsoluse', 'sol2');
model.sol('sol1').feature('e1').set('control', 'eig');
model.sol('sol1').feature('e1').feature('aDef').set('cachepattern', true);

model.result.dataset('dset2').set('solution', 'sol2');

model.sol('sol1').feature('v2').set('notsolnum', 'auto');
model.sol('sol1').feature('v2').set('notsolvertype', 'solnum');

model.study('std1').feature('eig').set('notsolnum', 'auto');
model.study('std1').feature('eig').set('notsolvertype', 'solnum');
model.study('std1').feature('eig').set('notsolnumhide', 'off');
model.study('std1').feature('eig').set('notstudyhide', 'off');
model.study('std1').feature('eig').set('notsolhide', 'off');

model.sol('sol1').attach('std1');
model.sol('sol1').runAll;

model.result('pg1').run;

model.physics('solid').feature('rotf1').set('CoriolisForce', false);

model.study('std1').create('param', 'Parametric');
model.study('std1').feature('param').setIndex('pname', 'Omega', 0);
model.study('std1').feature('param').setIndex('plistarr', '', 0);
model.study('std1').feature('param').setIndex('punit', 'rad/s', 0);
model.study('std1').feature('param').setIndex('pname', 'Omega', 0);
model.study('std1').feature('param').setIndex('plistarr', '', 0);
model.study('std1').feature('param').setIndex('punit', 'rad/s', 0);
model.study('std1').feature('param').setIndex('pname', 'Omega', 0);
model.study('std1').feature('param').setIndex('plistarr', 'pi*range(0,50,1000)', 0);
model.study('std1').feature('eig').set('shift', '1000');
model.study('std1').feature('eig').set('neigsactive', true);
model.study('std1').feature('eig').set('neigs', 7);

model.sol('sol1').study('std1');

model.study('std1').feature('eig').set('notsolnum', 'auto');
model.study('std1').feature('eig').set('notsolvertype', 'solnum');
model.study('std1').feature('eig').set('notsolnumhide', 'off');
model.study('std1').feature('eig').set('notstudyhide', 'off');
model.study('std1').feature('eig').set('notsolhide', 'off');

model.sol('sol2').copySolution('sol3');

model.study('std1').feature('eig').set('notlistsolnum', 1);
model.study('std1').feature('eig').set('notsolnum', 'auto');
model.study('std1').feature('eig').set('listsolnum', 1);
model.study('std1').feature('eig').set('solnum', 'auto');
model.study('std1').feature('eig').set('linplistsolnum', {'1'});
model.study('std1').feature('eig').set('linpsolnum', 'auto');
model.study('std1').feature('eig').set('notlistsolnum', 1);
model.study('std1').feature('eig').set('notsolnum', 'auto');
model.study('std1').feature('eig').set('listsolnum', 1);
model.study('std1').feature('eig').set('solnum', 'auto');
model.study('std1').feature('eig').set('linplistsolnum', {'1'});
model.study('std1').feature('eig').set('linpsolnum', 'auto');

model.result.dataset('dset2').set('solution', 'none');

model.sol('sol1').feature.remove('e1');
model.sol('sol1').feature.remove('v2');
model.sol('sol1').feature.remove('st2');
model.sol('sol1').feature.remove('su1');
model.sol('sol1').feature.remove('s1');
model.sol('sol1').feature.remove('v1');
model.sol('sol1').feature.remove('st1');
model.sol('sol3').copySolution('sol2');
model.sol.remove('sol3');
model.sol('sol2').label('Solution Store 1');

model.result.dataset.remove('dset4');

model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'stat');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').set('control', 'stat');
model.sol('sol1').create('s1', 'Stationary');
model.sol('sol1').feature('s1').feature('aDef').set('cachepattern', true);
model.sol('sol1').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('s1').feature('fc1').set('termonres', 'auto');
model.sol('sol1').feature('s1').feature('fc1').set('reserrfact', 1000);
model.sol('sol1').feature('s1').create('d1', 'Direct');
model.sol('sol1').feature('s1').feature('d1').set('linsolver', 'pardiso');
model.sol('sol1').feature('s1').feature('d1').set('pivotperturb', 1.0E-9);
model.sol('sol1').feature('s1').feature('d1').label('Suggested Direct Solver (solid)');
model.sol('sol1').feature('s1').create('i1', 'Iterative');
model.sol('sol1').feature('s1').feature('i1').set('linsolver', 'gmres');
model.sol('sol1').feature('s1').feature('i1').set('rhob', 400);
model.sol('sol1').feature('s1').feature('i1').set('nlinnormuse', true);
model.sol('sol1').feature('s1').feature('i1').label('Suggested Iterative Solver (solid)');
model.sol('sol1').feature('s1').feature('i1').create('mg1', 'Multigrid');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').set('prefun', 'gmg');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('pr').create('so1', 'SOR');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('pr').feature('so1').set('relax', 0.8);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('po').create('so1', 'SOR');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('po').feature('so1').set('relax', 0.8);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('cs').create('d1', 'Direct');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('cs').feature('d1').set('linsolver', 'pardiso');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('cs').feature('d1').set('pivotperturb', 1.0E-9);
model.sol('sol1').feature('s1').feature('fc1').set('linsolver', 'd1');
model.sol('sol1').feature('s1').feature('fc1').set('termonres', 'auto');
model.sol('sol1').feature('s1').feature('fc1').set('reserrfact', 1000);
model.sol('sol1').feature('s1').feature.remove('fcDef');
model.sol('sol1').create('su1', 'StoreSolution');
model.sol('sol1').feature('su1').set('sol', 'sol2');
model.sol('sol1').feature('su1').label('Solution Store 1');
model.sol('sol1').create('st2', 'StudyStep');
model.sol('sol1').feature('st2').set('study', 'std1');
model.sol('sol1').feature('st2').set('studystep', 'eig');

model.study('std1').feature('eig').set('initsoluse', 'sol2');
model.study('std1').feature('eig').set('linpsoluse', 'sol2');

model.sol('sol1').create('v2', 'Variables');
model.sol('sol1').feature('v2').set('initmethod', 'sol');
model.sol('sol1').feature('v2').set('initsol', 'sol1');
model.sol('sol1').feature('v2').set('initsoluse', 'sol2');
model.sol('sol1').feature('v2').set('notsolmethod', 'sol');
model.sol('sol1').feature('v2').set('notsol', 'sol1');
model.sol('sol1').feature('v2').set('control', 'eig');
model.sol('sol1').create('e1', 'Eigenvalue');
model.sol('sol1').feature('e1').set('eigvfunscale', 'maximum');
model.sol('sol1').feature('e1').set('eigvfunscaleparam', '1.3E-7');
model.sol('sol1').feature('e1').set('storelinpoint', true);
model.sol('sol1').feature('e1').set('control', 'eig');
model.sol('sol1').feature('e1').set('linpmethod', 'sol');
model.sol('sol1').feature('e1').set('linpsol', 'sol1');
model.sol('sol1').feature('e1').set('linpsoluse', 'sol2');
model.sol('sol1').feature('e1').set('control', 'eig');
model.sol('sol1').feature('e1').feature('aDef').set('cachepattern', true);

model.result.dataset('dset2').set('solution', 'sol2');

model.sol('sol1').feature('v2').set('notsolnum', 'auto');
model.sol('sol1').feature('v2').set('notsolvertype', 'solnum');

model.study('std1').feature('eig').set('notsolnum', 'auto');
model.study('std1').feature('eig').set('notsolvertype', 'solnum');
model.study('std1').feature('eig').set('notsolnumhide', 'off');
model.study('std1').feature('eig').set('notstudyhide', 'off');
model.study('std1').feature('eig').set('notsolhide', 'off');

model.sol('sol1').attach('std1');

model.batch.create('p1', 'Parametric');
model.batch('p1').study('std1');
model.batch('p1').create('so1', 'Solutionseq');
model.batch('p1').feature('so1').set('seq', 'sol1');
model.batch('p1').feature('so1').set('store', 'on');
model.batch('p1').feature('so1').set('clear', 'on');
model.batch('p1').feature('so1').set('psol', 'none');
model.batch('p1').set('pname', {'Omega'});
model.batch('p1').set('plistarr', {'pi*range(0,50,1000)'});
model.batch('p1').set('sweeptype', 'sparse');
model.batch('p1').set('probesel', 'all');
model.batch('p1').set('probes', {});
model.batch('p1').set('plot', 'off');
model.batch('p1').set('err', 'on');
model.batch('p1').attach('std1');
model.batch('p1').set('control', 'param');

model.sol.create('sol3');
model.sol('sol3').study('std1');
model.sol('sol3').label('Parametric Solutions 1');

model.batch('p1').feature('so1').set('psol', 'sol3');
model.batch('p1').run('compute');

model.result.dataset('dset3').set('frametype', 'spatial');
model.result.create('pg2', 'PlotGroup3D');
model.result('pg2').set('data', 'dset3');
model.result('pg2').setIndex('looplevel', 1, 0);
model.result('pg2').setIndex('looplevel', 21, 1);
model.result('pg2').set('frametype', 'spatial');
model.result('pg2').set('defaultPlotID', 'modeShape');
model.result('pg2').label('Mode Shape (solid) 1');
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
model.result('pg2').feature('surf1').feature('def').set('expr', {'u' 'v' 'w'});
model.result('pg2').feature('surf1').feature('def').set('descr', 'Displacement field');
model.result.evaluationGroup.create('std1EvgFrq1', 'EvaluationGroup');
model.result.evaluationGroup('std1EvgFrq1').set('defaultPlotID', 'eigenfrequenciesTable_solid');
model.result.evaluationGroup('std1EvgFrq1').set('data', 'dset3');
model.result.evaluationGroup('std1EvgFrq1').label('Eigenfrequencies (Study 1) 1');
model.result.evaluationGroup('std1EvgFrq1').create('gev1', 'EvalGlobal');
model.result.evaluationGroup('std1EvgFrq1').feature('gev1').setIndex('expr', '2*pi*freq', 0);
model.result.evaluationGroup('std1EvgFrq1').feature('gev1').setIndex('unit', 'rad/s', 0);
model.result.evaluationGroup('std1EvgFrq1').feature('gev1').setIndex('descr', 'Angular frequency', 0);
model.result.evaluationGroup('std1EvgFrq1').feature('gev1').setIndex('expr', 'imag(freq)/abs(freq)', 1);
model.result.evaluationGroup('std1EvgFrq1').feature('gev1').setIndex('unit', '1', 1);
model.result.evaluationGroup('std1EvgFrq1').feature('gev1').setIndex('descr', 'Damping ratio', 1);
model.result.evaluationGroup('std1EvgFrq1').feature('gev1').setIndex('expr', 'abs(freq)/imag(freq)/2', 2);
model.result.evaluationGroup('std1EvgFrq1').feature('gev1').setIndex('unit', '1', 2);
model.result.evaluationGroup('std1EvgFrq1').feature('gev1').setIndex('descr', 'Quality factor', 2);
model.result.evaluationGroup('std1EvgFrq1').run;
model.result.evaluationGroup.create('std1mpf11', 'EvaluationGroup');
model.result.evaluationGroup('std1mpf11').set('data', 'dset3');
model.result.evaluationGroup('std1mpf11').label('Participation Factors (Study 1) 1');
model.result.evaluationGroup('std1mpf11').create('gev1', 'EvalGlobal');
model.result.evaluationGroup('std1mpf11').feature('gev1').setIndex('expr', 'mpf1.pfLnormX', 0);
model.result.evaluationGroup('std1mpf11').feature('gev1').setIndex('unit', '1', 0);
model.result.evaluationGroup('std1mpf11').feature('gev1').setIndex('descr', 'Participation factor, normalized, X-translation', 0);
model.result.evaluationGroup('std1mpf11').feature('gev1').setIndex('expr', 'mpf1.pfLnormY', 1);
model.result.evaluationGroup('std1mpf11').feature('gev1').setIndex('unit', '1', 1);
model.result.evaluationGroup('std1mpf11').feature('gev1').setIndex('descr', 'Participation factor, normalized, Y-translation', 1);
model.result.evaluationGroup('std1mpf11').feature('gev1').setIndex('expr', 'mpf1.pfLnormZ', 2);
model.result.evaluationGroup('std1mpf11').feature('gev1').setIndex('unit', '1', 2);
model.result.evaluationGroup('std1mpf11').feature('gev1').setIndex('descr', 'Participation factor, normalized, Z-translation', 2);
model.result.evaluationGroup('std1mpf11').feature('gev1').setIndex('expr', 'mpf1.pfRnormX', 3);
model.result.evaluationGroup('std1mpf11').feature('gev1').setIndex('unit', '1', 3);
model.result.evaluationGroup('std1mpf11').feature('gev1').setIndex('descr', 'Participation factor, normalized, X-rotation', 3);
model.result.evaluationGroup('std1mpf11').feature('gev1').setIndex('expr', 'mpf1.pfRnormY', 4);
model.result.evaluationGroup('std1mpf11').feature('gev1').setIndex('unit', '1', 4);
model.result.evaluationGroup('std1mpf11').feature('gev1').setIndex('descr', 'Participation factor, normalized, Y-rotation', 4);
model.result.evaluationGroup('std1mpf11').feature('gev1').setIndex('expr', 'mpf1.pfRnormZ', 5);
model.result.evaluationGroup('std1mpf11').feature('gev1').setIndex('unit', '1', 5);
model.result.evaluationGroup('std1mpf11').feature('gev1').setIndex('descr', 'Participation factor, normalized, Z-rotation', 5);
model.result.evaluationGroup('std1mpf11').feature('gev1').setIndex('expr', 'mpf1.mEffLX', 6);
model.result.evaluationGroup('std1mpf11').feature('gev1').setIndex('unit', 'kg', 6);
model.result.evaluationGroup('std1mpf11').feature('gev1').setIndex('descr', 'Effective modal mass, X-translation', 6);
model.result.evaluationGroup('std1mpf11').feature('gev1').setIndex('expr', 'mpf1.mEffLY', 7);
model.result.evaluationGroup('std1mpf11').feature('gev1').setIndex('unit', 'kg', 7);
model.result.evaluationGroup('std1mpf11').feature('gev1').setIndex('descr', 'Effective modal mass, Y-translation', 7);
model.result.evaluationGroup('std1mpf11').feature('gev1').setIndex('expr', 'mpf1.mEffLZ', 8);
model.result.evaluationGroup('std1mpf11').feature('gev1').setIndex('unit', 'kg', 8);
model.result.evaluationGroup('std1mpf11').feature('gev1').setIndex('descr', 'Effective modal mass, Z-translation', 8);
model.result.evaluationGroup('std1mpf11').feature('gev1').setIndex('expr', 'mpf1.mEffRX', 9);
model.result.evaluationGroup('std1mpf11').feature('gev1').setIndex('unit', 'kg*m^2', 9);
model.result.evaluationGroup('std1mpf11').feature('gev1').setIndex('descr', 'Effective modal mass, X-rotation', 9);
model.result.evaluationGroup('std1mpf11').feature('gev1').setIndex('expr', 'mpf1.mEffRY', 10);
model.result.evaluationGroup('std1mpf11').feature('gev1').setIndex('unit', 'kg*m^2', 10);
model.result.evaluationGroup('std1mpf11').feature('gev1').setIndex('descr', 'Effective modal mass, Y-rotation', 10);
model.result.evaluationGroup('std1mpf11').feature('gev1').setIndex('expr', 'mpf1.mEffRZ', 11);
model.result.evaluationGroup('std1mpf11').feature('gev1').setIndex('unit', 'kg*m^2', 11);
model.result.evaluationGroup('std1mpf11').feature('gev1').setIndex('descr', 'Effective modal mass, Z-rotation', 11);
model.result.evaluationGroup('std1mpf11').run;
model.result('pg2').run;
model.result.create('pg3', 'PlotGroup1D');
model.result('pg3').run;
model.result('pg3').set('data', 'dset3');
model.result('pg3').setIndex('looplevelinput', 'manualindices', 0);
model.result('pg3').setIndex('looplevelindices', 'range(1,1,6)', 0);
model.result('pg3').set('titletype', 'manual');
model.result('pg3').set('title', 'Campbell diagram for the six lowest modes');
model.result('pg3').set('xlabelactive', true);
model.result('pg3').set('xlabel', 'Rotational angular velocity [rad/s]');
model.result('pg3').set('ylabelactive', true);
model.result('pg3').set('ylabel', 'Natural frequency [Hz]');
model.result('pg3').set('axislimits', true);
model.result('pg3').set('xmin', -100);
model.result('pg3').set('xmax', 4000);
model.result('pg3').set('ymin', 0);
model.result('pg3').set('ymax', 4500);
model.result('pg3').create('glob1', 'Global');
model.result('pg3').feature('glob1').set('markerpos', 'datapoints');
model.result('pg3').feature('glob1').set('linewidth', 'preference');
model.result('pg3').feature('glob1').set('expr', {'solid.freq'});
model.result('pg3').feature('glob1').set('descr', {'Frequency'});
model.result('pg3').feature('glob1').set('unit', {'Hz'});
model.result('pg3').feature('glob1').set('xdatasolnumtype', 'outer');
model.result('pg3').feature('glob1').set('linestyle', 'cycle');
model.result('pg3').feature('glob1').set('linewidth', 4);
model.result('pg3').feature('glob1').set('legendmethod', 'manual');
model.result('pg3').feature('glob1').setIndex('legends', 'Mode 1', 0);
model.result('pg3').feature('glob1').setIndex('legends', 'Mode 2', 1);
model.result('pg3').feature('glob1').setIndex('legends', 'Mode 3', 2);
model.result('pg3').feature('glob1').setIndex('legends', 'Mode 4', 3);
model.result('pg3').feature('glob1').setIndex('legends', 'Mode 5', 4);
model.result('pg3').feature('glob1').setIndex('legends', 'Mode 6', 5);
model.result('pg3').run;
model.result('pg3').label('Campbell diagram');
model.result('pg3').set('legendpos', 'upperleft');
model.result('pg3').run;

model.title('Fundamental Eigenfrequency of a Rotating Blade');

model.description('The eigenfrequencies of a rotating blade are studied in this benchmark. It shows how stress stiffening and the combined effect from stress stiffening and spin softening affects the fundamental eigenfrequency.');

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
model.sol('sol20').clearSolutionData;
model.sol('sol21').clearSolutionData;
model.sol('sol22').clearSolutionData;
model.sol('sol23').clearSolutionData;
model.sol('sol24').clearSolutionData;

model.label('rotating_blade.mph');

model.modelNode.label('Components');

out = model;
