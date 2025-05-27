function out = model
%
% heat_exchanger_plate.m
%
% Model exported on May 26 2025, 21:31 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/Pipe_Flow_Module/Tutorials');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 3);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.physics.create('pfl', 'FlowInPipes', 'geom1');
model.physics('pfl').model('comp1');
model.physics.create('spf', 'LaminarFlow', 'geom1');
model.physics('spf').model('comp1');

model.study.create('std1');
model.study('std1').create('stat', 'Stationary');
model.study('std1').feature('stat').setSolveFor('/physics/pfl', true);
model.study('std1').feature('stat').setSolveFor('/physics/spf', true);

model.geom('geom1').insertFile('heat_exchanger_plate_geom_sequence.mph', 'geom1');
model.geom('geom1').run('cmd1');

model.material.create('mat1', 'Common', 'comp1');
model.material('mat1').propertyGroup('def').func.create('eta', 'Piecewise');
model.material('mat1').propertyGroup('def').func.create('Cp', 'Piecewise');
model.material('mat1').propertyGroup('def').func.create('rho', 'Piecewise');
model.material('mat1').propertyGroup('def').func.create('k', 'Piecewise');
model.material('mat1').propertyGroup('def').func.create('cs', 'Interpolation');
model.material('mat1').propertyGroup('def').func.create('an1', 'Analytic');
model.material('mat1').propertyGroup('def').func.create('an2', 'Analytic');
model.material('mat1').propertyGroup('def').func.create('an3', 'Analytic');
model.material('mat1').label('Water, liquid');
model.material('mat1').set('family', 'water');
model.material('mat1').propertyGroup('def').func('eta').set('arg', 'T');
model.material('mat1').propertyGroup('def').func('eta').set('pieces', {'273.15' '413.15' '1.3799566804-0.021224019151*T^1+1.3604562827E-4*T^2-4.6454090319E-7*T^3+8.9042735735E-10*T^4-9.0790692686E-13*T^5+3.8457331488E-16*T^6'; '413.15' '553.75' '0.00401235783-2.10746715E-5*T^1+3.85772275E-8*T^2-2.39730284E-11*T^3'});
model.material('mat1').propertyGroup('def').func('eta').set('argunit', 'K');
model.material('mat1').propertyGroup('def').func('eta').set('fununit', 'Pa*s');
model.material('mat1').propertyGroup('def').func('Cp').set('arg', 'T');
model.material('mat1').propertyGroup('def').func('Cp').set('pieces', {'273.15' '553.75' '12010.1471-80.4072879*T^1+0.309866854*T^2-5.38186884E-4*T^3+3.62536437E-7*T^4'});
model.material('mat1').propertyGroup('def').func('Cp').set('argunit', 'K');
model.material('mat1').propertyGroup('def').func('Cp').set('fununit', 'J/(kg*K)');
model.material('mat1').propertyGroup('def').func('rho').set('arg', 'T');
model.material('mat1').propertyGroup('def').func('rho').set('smooth', 'contd1');
model.material('mat1').propertyGroup('def').func('rho').set('pieces', {'273.15' '293.15' '0.000063092789034*T^3-0.060367639882855*T^2+18.9229382407066*T-950.704055329848'; '293.15' '373.15' '0.000010335053319*T^3-0.013395065634452*T^2+4.969288832655160*T+432.257114008512'});
model.material('mat1').propertyGroup('def').func('rho').set('argunit', 'K');
model.material('mat1').propertyGroup('def').func('rho').set('fununit', 'kg/m^3');
model.material('mat1').propertyGroup('def').func('k').set('arg', 'T');
model.material('mat1').propertyGroup('def').func('k').set('pieces', {'273.15' '553.75' '-0.869083936+0.00894880345*T^1-1.58366345E-5*T^2+7.97543259E-9*T^3'});
model.material('mat1').propertyGroup('def').func('k').set('argunit', 'K');
model.material('mat1').propertyGroup('def').func('k').set('fununit', 'W/(m*K)');
model.material('mat1').propertyGroup('def').func('cs').set('table', {'273' '1403';  ...
'278' '1427';  ...
'283' '1447';  ...
'293' '1481';  ...
'303' '1507';  ...
'313' '1526';  ...
'323' '1541';  ...
'333' '1552';  ...
'343' '1555';  ...
'353' '1555';  ...
'363' '1550';  ...
'373' '1543'});
model.material('mat1').propertyGroup('def').func('cs').set('interp', 'piecewisecubic');
model.material('mat1').propertyGroup('def').func('cs').set('fununit', {'m/s'});
model.material('mat1').propertyGroup('def').func('cs').set('argunit', {'K'});
model.material('mat1').propertyGroup('def').func('an1').set('funcname', 'alpha_p');
model.material('mat1').propertyGroup('def').func('an1').set('expr', '-1/rho(T)*d(rho(T),T)');
model.material('mat1').propertyGroup('def').func('an1').set('args', {'T'});
model.material('mat1').propertyGroup('def').func('an1').set('fununit', '1/K');
model.material('mat1').propertyGroup('def').func('an1').set('argunit', {'K'});
model.material('mat1').propertyGroup('def').func('an1').set('plotfixedvalue', {'273.15'});
model.material('mat1').propertyGroup('def').func('an1').set('plotargs', {'T' '273.15' '373.15'});
model.material('mat1').propertyGroup('def').func('an2').set('funcname', 'gamma_w');
model.material('mat1').propertyGroup('def').func('an2').set('expr', '1+(T/Cp(T))*(alpha_p(T)*cs(T))^2');
model.material('mat1').propertyGroup('def').func('an2').set('args', {'T'});
model.material('mat1').propertyGroup('def').func('an2').set('fununit', '1');
model.material('mat1').propertyGroup('def').func('an2').set('argunit', {'K'});
model.material('mat1').propertyGroup('def').func('an2').set('plotfixedvalue', {'273.15'});
model.material('mat1').propertyGroup('def').func('an2').set('plotargs', {'T' '273.15' '373.15'});
model.material('mat1').propertyGroup('def').func('an3').set('funcname', 'muB');
model.material('mat1').propertyGroup('def').func('an3').set('expr', '2.79*eta(T)');
model.material('mat1').propertyGroup('def').func('an3').set('args', {'T'});
model.material('mat1').propertyGroup('def').func('an3').set('fununit', 'Pa*s');
model.material('mat1').propertyGroup('def').func('an3').set('argunit', {'K'});
model.material('mat1').propertyGroup('def').func('an3').set('plotfixedvalue', {'273.15'});
model.material('mat1').propertyGroup('def').func('an3').set('plotargs', {'T' '273.15' '553.75'});
model.material('mat1').propertyGroup('def').set('thermalexpansioncoefficient', '');
model.material('mat1').propertyGroup('def').set('bulkviscosity', '');
model.material('mat1').propertyGroup('def').set('thermalexpansioncoefficient', {'alpha_p(T)' '0' '0' '0' 'alpha_p(T)' '0' '0' '0' 'alpha_p(T)'});
model.material('mat1').propertyGroup('def').set('bulkviscosity', 'muB(T)');
model.material('mat1').propertyGroup('def').set('dynamicviscosity', 'eta(T)');
model.material('mat1').propertyGroup('def').set('ratioofspecificheat', 'gamma_w(T)');
model.material('mat1').propertyGroup('def').set('electricconductivity', {'5.5e-6[S/m]' '0' '0' '0' '5.5e-6[S/m]' '0' '0' '0' '5.5e-6[S/m]'});
model.material('mat1').propertyGroup('def').set('heatcapacity', 'Cp(T)');
model.material('mat1').propertyGroup('def').set('density', 'rho(T)');
model.material('mat1').propertyGroup('def').set('thermalconductivity', {'k(T)' '0' '0' '0' 'k(T)' '0' '0' '0' 'k(T)'});
model.material('mat1').propertyGroup('def').set('soundspeed', 'cs(T)');
model.material('mat1').propertyGroup('def').addInput('temperature');
model.material.create('mat2', 'Common', 'comp1');
model.material('mat2').propertyGroup('def').func.create('eta', 'Piecewise');
model.material('mat2').propertyGroup('def').func.create('Cp', 'Piecewise');
model.material('mat2').propertyGroup('def').func.create('rho', 'Piecewise');
model.material('mat2').propertyGroup('def').func.create('k', 'Piecewise');
model.material('mat2').propertyGroup('def').func.create('cs', 'Interpolation');
model.material('mat2').propertyGroup('def').func.create('an1', 'Analytic');
model.material('mat2').propertyGroup('def').func.create('an2', 'Analytic');
model.material('mat2').propertyGroup('def').func.create('an3', 'Analytic');
model.material('mat2').label('Water, liquid 1');
model.material('mat2').set('family', 'water');
model.material('mat2').propertyGroup('def').func('eta').set('arg', 'T');
model.material('mat2').propertyGroup('def').func('eta').set('pieces', {'273.15' '413.15' '1.3799566804-0.021224019151*T^1+1.3604562827E-4*T^2-4.6454090319E-7*T^3+8.9042735735E-10*T^4-9.0790692686E-13*T^5+3.8457331488E-16*T^6'; '413.15' '553.75' '0.00401235783-2.10746715E-5*T^1+3.85772275E-8*T^2-2.39730284E-11*T^3'});
model.material('mat2').propertyGroup('def').func('eta').set('argunit', 'K');
model.material('mat2').propertyGroup('def').func('eta').set('fununit', 'Pa*s');
model.material('mat2').propertyGroup('def').func('Cp').set('arg', 'T');
model.material('mat2').propertyGroup('def').func('Cp').set('pieces', {'273.15' '553.75' '12010.1471-80.4072879*T^1+0.309866854*T^2-5.38186884E-4*T^3+3.62536437E-7*T^4'});
model.material('mat2').propertyGroup('def').func('Cp').set('argunit', 'K');
model.material('mat2').propertyGroup('def').func('Cp').set('fununit', 'J/(kg*K)');
model.material('mat2').propertyGroup('def').func('rho').set('arg', 'T');
model.material('mat2').propertyGroup('def').func('rho').set('smooth', 'contd1');
model.material('mat2').propertyGroup('def').func('rho').set('pieces', {'273.15' '293.15' '0.000063092789034*T^3-0.060367639882855*T^2+18.9229382407066*T-950.704055329848'; '293.15' '373.15' '0.000010335053319*T^3-0.013395065634452*T^2+4.969288832655160*T+432.257114008512'});
model.material('mat2').propertyGroup('def').func('rho').set('argunit', 'K');
model.material('mat2').propertyGroup('def').func('rho').set('fununit', 'kg/m^3');
model.material('mat2').propertyGroup('def').func('k').set('arg', 'T');
model.material('mat2').propertyGroup('def').func('k').set('pieces', {'273.15' '553.75' '-0.869083936+0.00894880345*T^1-1.58366345E-5*T^2+7.97543259E-9*T^3'});
model.material('mat2').propertyGroup('def').func('k').set('argunit', 'K');
model.material('mat2').propertyGroup('def').func('k').set('fununit', 'W/(m*K)');
model.material('mat2').propertyGroup('def').func('cs').set('table', {'273' '1403';  ...
'278' '1427';  ...
'283' '1447';  ...
'293' '1481';  ...
'303' '1507';  ...
'313' '1526';  ...
'323' '1541';  ...
'333' '1552';  ...
'343' '1555';  ...
'353' '1555';  ...
'363' '1550';  ...
'373' '1543'});
model.material('mat2').propertyGroup('def').func('cs').set('interp', 'piecewisecubic');
model.material('mat2').propertyGroup('def').func('cs').set('fununit', {'m/s'});
model.material('mat2').propertyGroup('def').func('cs').set('argunit', {'K'});
model.material('mat2').propertyGroup('def').func('an1').set('funcname', 'alpha_p');
model.material('mat2').propertyGroup('def').func('an1').set('expr', '-1/rho(T)*d(rho(T),T)');
model.material('mat2').propertyGroup('def').func('an1').set('args', {'T'});
model.material('mat2').propertyGroup('def').func('an1').set('fununit', '1/K');
model.material('mat2').propertyGroup('def').func('an1').set('argunit', {'K'});
model.material('mat2').propertyGroup('def').func('an1').set('plotfixedvalue', {'273.15'});
model.material('mat2').propertyGroup('def').func('an1').set('plotargs', {'T' '273.15' '373.15'});
model.material('mat2').propertyGroup('def').func('an2').set('funcname', 'gamma_w');
model.material('mat2').propertyGroup('def').func('an2').set('expr', '1+(T/Cp(T))*(alpha_p(T)*cs(T))^2');
model.material('mat2').propertyGroup('def').func('an2').set('args', {'T'});
model.material('mat2').propertyGroup('def').func('an2').set('fununit', '1');
model.material('mat2').propertyGroup('def').func('an2').set('argunit', {'K'});
model.material('mat2').propertyGroup('def').func('an2').set('plotfixedvalue', {'273.15'});
model.material('mat2').propertyGroup('def').func('an2').set('plotargs', {'T' '273.15' '373.15'});
model.material('mat2').propertyGroup('def').func('an3').set('funcname', 'muB');
model.material('mat2').propertyGroup('def').func('an3').set('expr', '2.79*eta(T)');
model.material('mat2').propertyGroup('def').func('an3').set('args', {'T'});
model.material('mat2').propertyGroup('def').func('an3').set('fununit', 'Pa*s');
model.material('mat2').propertyGroup('def').func('an3').set('argunit', {'K'});
model.material('mat2').propertyGroup('def').func('an3').set('plotfixedvalue', {'273.15'});
model.material('mat2').propertyGroup('def').func('an3').set('plotargs', {'T' '273.15' '553.75'});
model.material('mat2').propertyGroup('def').set('thermalexpansioncoefficient', '');
model.material('mat2').propertyGroup('def').set('bulkviscosity', '');
model.material('mat2').propertyGroup('def').set('thermalexpansioncoefficient', {'alpha_p(T)' '0' '0' '0' 'alpha_p(T)' '0' '0' '0' 'alpha_p(T)'});
model.material('mat2').propertyGroup('def').set('bulkviscosity', 'muB(T)');
model.material('mat2').propertyGroup('def').set('dynamicviscosity', 'eta(T)');
model.material('mat2').propertyGroup('def').set('ratioofspecificheat', 'gamma_w(T)');
model.material('mat2').propertyGroup('def').set('electricconductivity', {'5.5e-6[S/m]' '0' '0' '0' '5.5e-6[S/m]' '0' '0' '0' '5.5e-6[S/m]'});
model.material('mat2').propertyGroup('def').set('heatcapacity', 'Cp(T)');
model.material('mat2').propertyGroup('def').set('density', 'rho(T)');
model.material('mat2').propertyGroup('def').set('thermalconductivity', {'k(T)' '0' '0' '0' 'k(T)' '0' '0' '0' 'k(T)'});
model.material('mat2').propertyGroup('def').set('soundspeed', 'cs(T)');
model.material('mat2').propertyGroup('def').addInput('temperature');
model.material('mat2').selection.geom('geom1', 1);
model.material('mat2').selection.named('geom1_arr1_edg');

model.physics('pfl').selection.named('geom1_arr1_edg');
model.physics('pfl').feature('pipe1').set('shape', 'Square');
model.physics('pfl').feature('pipe1').set('innerw', '1[mm]');
model.physics('spf').create('inl1', 'InletBoundary', 2);
model.physics('spf').feature('inl1').selection.set([43]);
model.physics('spf').feature('inl1').set('BoundaryCondition', 'FullyDevelopedFlow');
model.physics('spf').feature('inl1').set('Uavfdf', '5[cm/s]');
model.physics('spf').create('out1', 'OutletBoundary', 2);
model.physics('spf').feature('out1').selection.set([5]);
model.physics('spf').feature('out1').set('NormalFlow', true);

model.multiphysics.create('plc1', 'PipeConnection', 'geom1', -1);

model.mesh('mesh1').autoMeshSize(3);
model.mesh('mesh1').run;
model.mesh('mesh1').automatic(false);
model.mesh('mesh1').feature('size2').set('hauto', 5);
model.mesh('mesh1').run;

model.study('std1').setGenPlots(false);

model.sol.create('sol1');

model.mesh('mesh1').stat.selection.geom(3);
model.mesh('mesh1').stat.selection.set([1 2]);
model.mesh('mesh1').stat.selection.geom(3);
model.mesh('mesh1').stat.selection.set([1 2]);

model.sol('sol1').study('std1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'stat');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').set('control', 'stat');
model.sol('sol1').create('s1', 'Stationary');
model.sol('sol1').feature('s1').feature('aDef').set('cachepattern', true);
model.sol('sol1').feature('s1').create('iDef', 'Iterative');
model.sol('sol1').feature('s1').create('seDef', 'Segregated');
model.sol('sol1').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('s1').feature('fc1').set('damp', 0.8);
model.sol('sol1').feature('s1').feature('fc1').set('stabacc', 'cflcmp');
model.sol('sol1').feature('s1').feature('fc1').set('initcfl', 5);
model.sol('sol1').feature('s1').feature('fc1').set('kppid', 0.65);
model.sol('sol1').feature('s1').feature('fc1').set('kdpid', 0.05);
model.sol('sol1').feature('s1').feature('fc1').set('kipid', 0.05);
model.sol('sol1').feature('s1').feature('fc1').set('cfltol', 0.1);
model.sol('sol1').feature('s1').feature('fc1').set('dtech', 'const');
model.sol('sol1').feature('s1').feature('fc1').set('maxiter', 150);
model.sol('sol1').feature('s1').create('i1', 'Iterative');
model.sol('sol1').feature('s1').feature('i1').set('linsolver', 'gmres');
model.sol('sol1').feature('s1').feature('i1').set('prefuntype', 'left');
model.sol('sol1').feature('s1').feature('i1').set('itrestart', 50);
model.sol('sol1').feature('s1').feature('i1').set('rhob', 20);
model.sol('sol1').feature('s1').feature('i1').set('maxlinit', 1000);
model.sol('sol1').feature('s1').feature('i1').set('nlinnormuse', 'on');
model.sol('sol1').feature('s1').feature('i1').label('AMG, fluid flow variables (plc1) (Merged)');
model.sol('sol1').feature('s1').feature('i1').create('mg1', 'Multigrid');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').set('prefun', 'saamg');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').set('mgcycle', 'v');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').set('maxcoarsedof', 80000);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').set('strconn', 0.02);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').set('nullspace', 'constant');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').set('usesmooth', false);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').set('saamgcompwise', true);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').set('loweramg', true);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('pr').create('va1', 'Vanka');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('pr').feature('va1').set('linesweeptype', 'ssor');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('pr').feature('va1').set('iter', 0);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('pr').feature('va1').set('seconditer', 1);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('pr').feature('va1').set('relax', 0.5);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('pr').feature('va1').set('vankavars', {'comp1_spf_inl1_Pinlfdf' 'comp1_plc1_Pinl_1' 'comp1_plc1_Pinl_2' 'comp1_plc1_Pinl_3' 'comp1_plc1_Pinl_4' 'comp1_plc1_Pinl_5' 'comp1_plc1_Pinl_6' 'comp1_plc1_Pinl_7' 'comp1_plc1_Pinl_8' 'comp1_plc1_Pinl_9'  ...
'comp1_plc1_Pinl_10'});
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('po').create('va1', 'Vanka');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('po').feature('va1').set('linesweeptype', 'ssor');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('po').feature('va1').set('iter', 1);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('po').feature('va1').set('seconditer', 1);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('po').feature('va1').set('relax', 0.5);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('po').feature('va1').set('vankavars', {'comp1_spf_inl1_Pinlfdf' 'comp1_plc1_Pinl_1' 'comp1_plc1_Pinl_2' 'comp1_plc1_Pinl_3' 'comp1_plc1_Pinl_4' 'comp1_plc1_Pinl_5' 'comp1_plc1_Pinl_6' 'comp1_plc1_Pinl_7' 'comp1_plc1_Pinl_8' 'comp1_plc1_Pinl_9'  ...
'comp1_plc1_Pinl_10'});
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('cs').create('d1', 'Direct');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('cs').feature('d1').set('linsolver', 'pardiso');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('cs').feature('d1').set('pivotperturb', 1.0E-13);
model.sol('sol1').feature('s1').create('d1', 'Direct');
model.sol('sol1').feature('s1').feature('d1').set('linsolver', 'pardiso');
model.sol('sol1').feature('s1').feature('d1').set('pivotperturb', 1.0E-13);
model.sol('sol1').feature('s1').feature('d1').label('Direct, fluid flow variables (plc1)');
model.sol('sol1').feature('s1').feature('fc1').set('linsolver', 'i1');
model.sol('sol1').feature('s1').feature('fc1').set('damp', 0.8);
model.sol('sol1').feature('s1').feature('fc1').set('stabacc', 'cflcmp');
model.sol('sol1').feature('s1').feature('fc1').set('initcfl', 5);
model.sol('sol1').feature('s1').feature('fc1').set('kppid', 0.65);
model.sol('sol1').feature('s1').feature('fc1').set('kdpid', 0.05);
model.sol('sol1').feature('s1').feature('fc1').set('kipid', 0.05);
model.sol('sol1').feature('s1').feature('fc1').set('cfltol', 0.1);
model.sol('sol1').feature('s1').feature('fc1').set('dtech', 'const');
model.sol('sol1').feature('s1').feature('fc1').set('maxiter', 150);
model.sol('sol1').feature('s1').feature.remove('fcDef');
model.sol('sol1').feature('s1').feature.remove('seDef');
model.sol('sol1').feature('s1').feature.remove('iDef');
model.sol('sol1').attach('std1');
model.sol('sol1').runAll;

model.result.create('pg1', 'PlotGroup3D');
model.result('pg1').run;
model.result('pg1').create('vol1', 'Volume');
model.result('pg1').feature('vol1').set('expr', 'p2');
model.result('pg1').run;
model.result('pg1').run;
model.result('pg1').label('Pressure');
model.result('pg1').create('line1', 'Line');
model.result('pg1').feature('line1').set('expr', 'p-1[atm]');
model.result('pg1').run;
model.result('pg1').feature('line1').set('colorlegend', false);
model.result('pg1').feature('line1').set('linetype', 'tube');
model.result('pg1').feature('line1').set('radiusexpr', '0.5');
model.result('pg1').feature('line1').set('tuberadiusscaleactive', true);
model.result('pg1').feature('line1').set('colortable', 'RainbowLight');

model.view('view1').set('showgrid', false);

model.result('pg1').run;
model.result('pg1').run;
model.result.duplicate('pg2', 'pg1');
model.result('pg2').run;
model.result('pg2').label('Velocity');
model.result('pg2').run;
model.result('pg2').feature('line1').set('expr', 'pfl.U');
model.result('pg2').feature('line1').set('descr', 'Velocity magnitude');
model.result('pg2').feature('line1').set('colorlegend', true);
model.result('pg2').run;
model.result('pg2').run;
model.result('pg2').feature('vol1').active(false);
model.result('pg2').run;

model.title('Convective Flow in a Heat Exchanger Plate');

model.description(['A common class of fluid flow problems consists of pipe segments connected larger volumes like tanks and or boxes.' newline  newline 'Here, a problem is set up with the Pipe Flow Module to model the flow in the microchannels of a heat exchanger. The example showcases the Pipe Connection feature that automatically connects a 3D volume and Pipe Flow sections.']);

model.mesh.clearMeshes;

model.sol('sol1').clearSolutionData;

model.label('heat_exchanger_plate.mph');

model.modelNode.label('Components');

out = model;
