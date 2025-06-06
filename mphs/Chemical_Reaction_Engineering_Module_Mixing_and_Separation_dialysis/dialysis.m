function out = model
%
% dialysis.m
%
% Model exported on May 26 2025, 21:27 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/Chemical_Reaction_Engineering_Module/Mixing_and_Separation');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 2);
model.geom('geom1').model('comp1');
model.geom('geom1').axisymmetric(true);

model.mesh.create('mesh1', 'geom1');

model.physics.create('tds', 'DilutedSpecies', 'geom1', {'c'});
model.physics.create('spf', 'LaminarFlow', 'geom1');
model.physics('spf').model('comp1');

model.study.create('std1');
model.study('std1').create('stat', 'Stationary');
model.study('std1').feature('stat').setSolveFor('/physics/tds', true);
model.study('std1').feature('stat').setSolveFor('/physics/spf', true);

% To import content from file, use:
% model.param.loadFile('FILENAME');
model.param.set('Rhf', '0.2[mm]', 'Inner radius, hollow fiber');
model.param.set('Lm', '0.08[mm]', 'Thickness, membrane');
model.param.set('Lpc', '0.42[mm]', 'Width, concentric permeate channel');
model.param.set('H', '21[mm]', 'Length, fiber');
model.param.set('D', '1e-9[m^2/s]', 'Diffusion constant, liquid phases');
model.param.set('Dm', '1e-9[m^2/s]', 'Diffusion constant, membrane');
model.param.set('K', '0.7', 'Partition coefficient');
model.param.set('c0_dia', '1[mol/liter]', 'Inlet concentration, dialysate');
model.param.set('c0_per', 'c0_dia*0.1', 'Inlet concentration, permeate');
model.param.set('c0_mem', '0[mol/liter]', 'Initial concentration, membrane');
model.param.set('Uave_dia', '0.5[mm/s]', 'Average velocity, dialysate');
model.param.set('Uave_per', '0.8[mm/s]', 'Average velocity, permeate');

model.geom('geom1').lengthUnit('mm');
model.geom('geom1').create('r1', 'Rectangle');
model.geom('geom1').feature('r1').set('size', {'Rhf' 'H'});
model.geom('geom1').run('r1');
model.geom('geom1').create('r2', 'Rectangle');
model.geom('geom1').feature('r2').set('size', {'Lm' 'H'});
model.geom('geom1').feature('r2').set('pos', {'Rhf' '0'});
model.geom('geom1').run('r2');
model.geom('geom1').create('r3', 'Rectangle');
model.geom('geom1').feature('r3').set('size', {'Lpc' 'H'});
model.geom('geom1').feature('r3').set('pos', {'Rhf+Lm' '0'});
model.geom('geom1').run('r3');
model.geom('geom1').run('fin');
model.geom('geom1').create('sel1', 'ExplicitSelection');
model.geom('geom1').feature('sel1').label('Dialysate and Permeate');
model.geom('geom1').feature('sel1').selection('selection').set('fin', [1 3]);
model.geom('geom1').run('sel1');
model.geom('geom1').create('sel2', 'ExplicitSelection');
model.geom('geom1').feature('sel2').label('Membrane');
model.geom('geom1').feature('sel2').selection('selection').set('fin', 2);
model.geom('geom1').run;

model.physics('tds').feature('cdm1').label('Transport Properties - Dialysate and Permeate');
model.physics('tds').feature('cdm1').set('u_src', 'root.comp1.u');
model.physics('tds').feature('cdm1').set('D_c', {'D' '0' '0' '0' 'D' '0' '0' '0' 'D'});
model.physics('tds').create('cdm2', 'ConvectionDiffusionMigration', 2);
model.physics('tds').feature('cdm2').selection.set([2]);
model.physics('tds').feature('cdm2').label('Transport Properties - Membrane');
model.physics('tds').feature('cdm2').set('D_c', {'Dm' '0' '0' '0' 'Dm' '0' '0' '0' 'Dm'});
model.physics('tds').feature('init1').setIndex('initc', 'c0_dia', 0);
model.physics('tds').feature.duplicate('init2', 'init1');
model.physics('tds').feature('init2').selection.set([3]);
model.physics('tds').feature('init2').setIndex('initc', 'c0_per', 0);
model.physics('tds').create('in1', 'Inflow', 1);
model.physics('tds').feature('in1').selection.set([2]);
model.physics('tds').feature('in1').setIndex('c0', 'c0_dia', 0);
model.physics('tds').feature('in1').set('BoundaryConditionType', 'FluxDanckwerts');
model.physics('tds').create('in2', 'Inflow', 1);
model.physics('tds').feature('in2').selection.set([8]);
model.physics('tds').feature('in2').setIndex('c0', 'c0_per', 0);
model.physics('tds').feature('in2').set('BoundaryConditionType', 'FluxDanckwerts');
model.physics('tds').create('out1', 'Outflow', 1);
model.physics('tds').feature('out1').selection.set([3 9]);
model.physics('tds').create('pac1', 'PartitionCondition', 1);
model.physics('tds').feature('pac1').selection.set([4]);
model.physics('tds').feature('pac1').setIndex('K', 'K', 0);
model.physics('tds').create('pac2', 'PartitionCondition', 1);
model.physics('tds').feature('pac2').selection.set([7]);
model.physics('tds').feature('pac2').set('ReverseDirection', true);
model.physics('tds').feature('pac2').setIndex('K', 'K', 0);

model.material.create('mat1', 'Common', 'comp1');
model.material('mat1').propertyGroup('def').func.create('eta', 'Piecewise');
model.material('mat1').propertyGroup('def').func.create('Cp', 'Piecewise');
model.material('mat1').propertyGroup('def').func.create('rho', 'Piecewise');
model.material('mat1').propertyGroup('def').func.create('k', 'Piecewise');
model.material('mat1').propertyGroup('def').func.create('cs', 'Interpolation');
model.material('mat1').propertyGroup('def').func.create('an1', 'Analytic');
model.material('mat1').propertyGroup('def').func.create('an2', 'Analytic');
model.material('mat1').propertyGroup('def').func.create('an3', 'Analytic');
model.material('mat1').label('Water');
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
model.material('mat1').propertyGroup('def').func('an1').label('Analytic ');
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

model.physics('spf').selection.named('geom1_sel1');
model.physics('spf').create('inl1', 'InletBoundary', 1);
model.physics('spf').feature('inl1').selection.set([2]);
model.physics('spf').feature('inl1').set('BoundaryCondition', 'FullyDevelopedFlow');
model.physics('spf').feature('inl1').set('Uavfdf', 'Uave_dia');
model.physics('spf').create('inl2', 'InletBoundary', 1);
model.physics('spf').feature('inl2').selection.set([8]);
model.physics('spf').feature('inl2').set('BoundaryCondition', 'FullyDevelopedFlow');
model.physics('spf').feature('inl2').set('Uavfdf', 'Uave_per');
model.physics('spf').create('out1', 'OutletBoundary', 1);
model.physics('spf').feature('out1').selection.set([3 9]);
model.physics('spf').feature('out1').set('NormalFlow', true);

model.mesh('mesh1').create('map1', 'Map');
model.mesh('mesh1').feature('map1').create('dis1', 'Distribution');
model.mesh('mesh1').feature('map1').feature('dis1').selection.set([1 4 7 10]);
model.mesh('mesh1').feature('map1').feature('dis1').set('type', 'predefined');
model.mesh('mesh1').feature('map1').feature('dis1').set('elemcount', 250);
model.mesh('mesh1').feature('map1').feature('dis1').set('elemratio', 25);
model.mesh('mesh1').feature('map1').create('dis2', 'Distribution');
model.mesh('mesh1').feature('map1').feature('dis2').selection.set([5 6]);
model.mesh('mesh1').feature('map1').feature('dis2').set('type', 'predefined');
model.mesh('mesh1').feature('map1').feature('dis2').set('elemcount', 7);
model.mesh('mesh1').feature('map1').feature('dis2').set('elemratio', 2);
model.mesh('mesh1').feature('map1').feature('dis2').set('symmetric', true);
model.mesh('mesh1').feature('map1').create('dis3', 'Distribution');
model.mesh('mesh1').feature('map1').feature('dis3').selection.set([2 3]);
model.mesh('mesh1').feature('map1').feature('dis3').set('type', 'predefined');
model.mesh('mesh1').feature('map1').feature('dis3').set('elemcount', 20);
model.mesh('mesh1').feature('map1').feature('dis3').set('elemratio', 2);
model.mesh('mesh1').feature('map1').create('dis4', 'Distribution');
model.mesh('mesh1').feature('map1').feature('dis4').selection.set([8 9]);
model.mesh('mesh1').feature('map1').feature('dis4').set('type', 'predefined');
model.mesh('mesh1').feature('map1').feature('dis4').set('elemcount', 30);
model.mesh('mesh1').feature('map1').feature('dis4').set('elemratio', 3);
model.mesh('mesh1').feature('map1').feature('dis4').set('reverse', true);

model.study('std1').feature('stat').label('Laminar Flow');
model.study('std1').feature('stat').setEntry('activate', 'tds', false);
model.study('std1').create('stat2', 'Stationary');
model.study('std1').feature('stat2').label('Transport of Diluted Species');
model.study('std1').feature('stat2').setEntry('activate', 'spf', false);

model.sol.create('sol1');

model.mesh('mesh1').stat.selection.geom(2);
model.mesh('mesh1').stat.selection.set([1 3]);
model.mesh('mesh1').stat.selection.geom(2);
model.mesh('mesh1').stat.selection.set([1 2 3]);
model.mesh('mesh1').stat.selection.geom(2);
model.mesh('mesh1').stat.selection.set([1 3]);

model.sol('sol1').study('std1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'stat');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').set('control', 'stat');
model.sol('sol1').create('s1', 'Stationary');
model.sol('sol1').feature('s1').feature('aDef').set('cachepattern', true);
model.sol('sol1').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('s1').feature('fc1').set('dtech', 'auto');
model.sol('sol1').feature('s1').feature('fc1').set('initstep', 0.01);
model.sol('sol1').feature('s1').feature('fc1').set('minstep', 1.0E-4);
model.sol('sol1').feature('s1').feature('fc1').set('maxiter', 100);
model.sol('sol1').feature('s1').create('d1', 'Direct');
model.sol('sol1').feature('s1').feature('d1').set('linsolver', 'pardiso');
model.sol('sol1').feature('s1').feature('d1').set('pivotperturb', 1.0E-13);
model.sol('sol1').feature('s1').feature('d1').label('Direct, fluid flow variables (spf)');
model.sol('sol1').feature('s1').create('i1', 'Iterative');
model.sol('sol1').feature('s1').feature('i1').set('linsolver', 'gmres');
model.sol('sol1').feature('s1').feature('i1').set('prefuntype', 'left');
model.sol('sol1').feature('s1').feature('i1').set('itrestart', 50);
model.sol('sol1').feature('s1').feature('i1').set('rhob', 20);
model.sol('sol1').feature('s1').feature('i1').set('maxlinit', 1000);
model.sol('sol1').feature('s1').feature('i1').set('nlinnormuse', 'on');
model.sol('sol1').feature('s1').feature('i1').label('AMG, fluid flow variables (spf)');
model.sol('sol1').feature('s1').feature('i1').create('mg1', 'Multigrid');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').set('prefun', 'saamg');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').set('mgcycle', 'v');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').set('maxcoarsedof', 80000);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').set('strconn', 0.02);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').set('nullspace', 'constant');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').set('usesmooth', false);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').set('saamgcompwise', true);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').set('loweramg', true);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').set('compactaggregation', false);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('pr').create('sc1', 'SCGS');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('pr').feature('sc1').set('linesweeptype', 'ssor');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('pr').feature('sc1').set('iter', 0);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('pr').feature('sc1').set('scgsrelax', 0.7);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('pr').feature('sc1').set('scgsmethod', 'lines');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('pr').feature('sc1').set('scgsvertexrelax', 0.7);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('pr').feature('sc1').set('relax', 0.5);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('pr').feature('sc1').set('vankavarsactive', 'on');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('pr').feature('sc1').set('vankavars', {'comp1_spf_inl1_Pinlfdf' 'comp1_spf_inl2_Pinlfdf'});
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('pr').feature('sc1').set('scgssolv', 'stored');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('pr').feature('sc1').set('approxscgs', true);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('pr').feature('sc1').set('scgsdirectmaxsize', 1000);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('po').create('sc1', 'SCGS');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('po').feature('sc1').set('linesweeptype', 'ssor');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('po').feature('sc1').set('iter', 1);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('po').feature('sc1').set('scgsrelax', 0.7);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('po').feature('sc1').set('scgsmethod', 'lines');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('po').feature('sc1').set('scgsvertexrelax', 0.7);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('po').feature('sc1').set('relax', 0.5);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('po').feature('sc1').set('vankavarsactive', 'on');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('po').feature('sc1').set('vankavars', {'comp1_spf_inl1_Pinlfdf' 'comp1_spf_inl2_Pinlfdf'});
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('po').feature('sc1').set('scgssolv', 'stored');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('po').feature('sc1').set('approxscgs', true);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('po').feature('sc1').set('scgsdirectmaxsize', 1000);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('cs').create('d1', 'Direct');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('cs').feature('d1').set('linsolver', 'pardiso');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('cs').feature('d1').set('pivotperturb', 1.0E-13);
model.sol('sol1').feature('s1').feature('fc1').set('linsolver', 'd1');
model.sol('sol1').feature('s1').feature('fc1').set('dtech', 'auto');
model.sol('sol1').feature('s1').feature('fc1').set('initstep', 0.01);
model.sol('sol1').feature('s1').feature('fc1').set('minstep', 1.0E-4);
model.sol('sol1').feature('s1').feature('fc1').set('maxiter', 100);
model.sol('sol1').feature('s1').feature.remove('fcDef');
model.sol('sol1').create('su1', 'StoreSolution');
model.sol('sol1').create('st2', 'StudyStep');
model.sol('sol1').feature('st2').set('study', 'std1');
model.sol('sol1').feature('st2').set('studystep', 'stat2');
model.sol('sol1').create('v2', 'Variables');
model.sol('sol1').feature('v2').set('initmethod', 'sol');
model.sol('sol1').feature('v2').set('initsol', 'sol1');
model.sol('sol1').feature('v2').set('notsolmethod', 'sol');
model.sol('sol1').feature('v2').set('notsol', 'sol1');
model.sol('sol1').feature('v2').set('control', 'stat2');
model.sol('sol1').create('s2', 'Stationary');
model.sol('sol1').feature('s2').set('stol', 0.001);
model.sol('sol1').feature('s2').feature('aDef').set('cachepattern', true);
model.sol('sol1').feature('s2').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('s2').feature('fc1').set('dtech', 'auto');
model.sol('sol1').feature('s2').feature('fc1').set('initstep', 0.01);
model.sol('sol1').feature('s2').feature('fc1').set('minstep', 1.0E-6);
model.sol('sol1').feature('s2').feature('fc1').set('maxiter', 50);
model.sol('sol1').feature('s2').create('d1', 'Direct');
model.sol('sol1').feature('s2').feature('d1').set('linsolver', 'pardiso');
model.sol('sol1').feature('s2').feature('d1').set('pivotperturb', 1.0E-13);
model.sol('sol1').feature('s2').feature('d1').label('Direct, concentrations (tds)');
model.sol('sol1').feature('s2').create('i1', 'Iterative');
model.sol('sol1').feature('s2').feature('i1').set('linsolver', 'gmres');
model.sol('sol1').feature('s2').feature('i1').set('prefuntype', 'left');
model.sol('sol1').feature('s2').feature('i1').set('itrestart', 50);
model.sol('sol1').feature('s2').feature('i1').set('rhob', 400);
model.sol('sol1').feature('s2').feature('i1').set('maxlinit', 1000);
model.sol('sol1').feature('s2').feature('i1').set('nlinnormuse', 'on');
model.sol('sol1').feature('s2').feature('i1').label('AMG, concentrations (tds)');
model.sol('sol1').feature('s2').feature('i1').create('mg1', 'Multigrid');
model.sol('sol1').feature('s2').feature('i1').feature('mg1').set('prefun', 'saamg');
model.sol('sol1').feature('s2').feature('i1').feature('mg1').set('mgcycle', 'v');
model.sol('sol1').feature('s2').feature('i1').feature('mg1').set('maxcoarsedof', 50000);
model.sol('sol1').feature('s2').feature('i1').feature('mg1').set('strconn', 0.01);
model.sol('sol1').feature('s2').feature('i1').feature('mg1').set('nullspace', 'constant');
model.sol('sol1').feature('s2').feature('i1').feature('mg1').set('usesmooth', false);
model.sol('sol1').feature('s2').feature('i1').feature('mg1').set('saamgcompwise', true);
model.sol('sol1').feature('s2').feature('i1').feature('mg1').set('loweramg', true);
model.sol('sol1').feature('s2').feature('i1').feature('mg1').set('compactaggregation', false);
model.sol('sol1').feature('s2').feature('i1').feature('mg1').feature('pr').create('sl1', 'SORLine');
model.sol('sol1').feature('s2').feature('i1').feature('mg1').feature('pr').feature('sl1').set('linesweeptype', 'ssor');
model.sol('sol1').feature('s2').feature('i1').feature('mg1').feature('pr').feature('sl1').set('iter', 1);
model.sol('sol1').feature('s2').feature('i1').feature('mg1').feature('pr').feature('sl1').set('linerelax', 0.7);
model.sol('sol1').feature('s2').feature('i1').feature('mg1').feature('pr').feature('sl1').set('linealgorithm', 'mesh');
model.sol('sol1').feature('s2').feature('i1').feature('mg1').feature('pr').feature('sl1').set('linemethod', 'coupled');
model.sol('sol1').feature('s2').feature('i1').feature('mg1').feature('pr').feature('sl1').set('seconditer', 1);
model.sol('sol1').feature('s2').feature('i1').feature('mg1').feature('pr').feature('sl1').set('relax', 0.5);
model.sol('sol1').feature('s2').feature('i1').feature('mg1').feature('po').create('sl1', 'SORLine');
model.sol('sol1').feature('s2').feature('i1').feature('mg1').feature('po').feature('sl1').set('linesweeptype', 'ssor');
model.sol('sol1').feature('s2').feature('i1').feature('mg1').feature('po').feature('sl1').set('iter', 1);
model.sol('sol1').feature('s2').feature('i1').feature('mg1').feature('po').feature('sl1').set('linerelax', 0.7);
model.sol('sol1').feature('s2').feature('i1').feature('mg1').feature('po').feature('sl1').set('linealgorithm', 'mesh');
model.sol('sol1').feature('s2').feature('i1').feature('mg1').feature('po').feature('sl1').set('linemethod', 'coupled');
model.sol('sol1').feature('s2').feature('i1').feature('mg1').feature('po').feature('sl1').set('seconditer', 1);
model.sol('sol1').feature('s2').feature('i1').feature('mg1').feature('po').feature('sl1').set('relax', 0.5);
model.sol('sol1').feature('s2').feature('i1').feature('mg1').feature('cs').create('d1', 'Direct');
model.sol('sol1').feature('s2').feature('i1').feature('mg1').feature('cs').feature('d1').set('linsolver', 'pardiso');
model.sol('sol1').feature('s2').feature('i1').feature('mg1').feature('cs').feature('d1').set('pivotperturb', 1.0E-13);
model.sol('sol1').feature('s2').feature('fc1').set('linsolver', 'd1');
model.sol('sol1').feature('s2').feature('fc1').set('dtech', 'auto');
model.sol('sol1').feature('s2').feature('fc1').set('initstep', 0.01);
model.sol('sol1').feature('s2').feature('fc1').set('minstep', 1.0E-6);
model.sol('sol1').feature('s2').feature('fc1').set('maxiter', 50);
model.sol('sol1').feature('s2').feature.remove('fcDef');
model.sol('sol1').feature('v2').set('notsolnum', 'auto');
model.sol('sol1').feature('v2').set('notsolvertype', 'solnum');
model.sol('sol1').feature('v2').set('solnum', 'auto');
model.sol('sol1').feature('v2').set('solvertype', 'solnum');
model.sol('sol1').attach('std1');
model.sol('sol1').runAll;

model.result.create('pg1', 'PlotGroup2D');
model.result('pg1').set('data', 'dset1');
model.result('pg1').label('Concentration (tds)');
model.result('pg1').set('titletype', 'custom');
model.result('pg1').set('prefixintitle', '');
model.result('pg1').set('expressionintitle', false);
model.result('pg1').set('typeintitle', true);
model.result('pg1').create('surf1', 'Surface');
model.result('pg1').feature('surf1').set('expr', {'c'});
model.result('pg1').create('str1', 'Streamline');
model.result('pg1').feature('str1').set('expr', {'tds.tflux_cr' 'tds.tflux_cz'});
model.result('pg1').feature('str1').set('posmethod', 'uniform');
model.result('pg1').feature('str1').set('recover', 'pprint');
model.result('pg1').feature('str1').set('pointtype', 'arrow');
model.result('pg1').feature('str1').set('arrowlength', 'logarithmic');
model.result('pg1').feature('str1').set('color', 'gray');
model.result.dataset.create('rev1', 'Revolve2D');
model.result.dataset('rev1').set('data', 'dset1');
model.result.dataset('rev1').set('revangle', 225);
model.result.dataset('rev1').set('startangle', -90);
model.result.dataset('rev1').set('hasspacevars', false);
model.result.create('pg2', 'PlotGroup3D');
model.result('pg2').set('data', 'rev1');
model.result('pg2').label('Concentration, 3D (tds)');
model.result('pg2').create('surf1', 'Surface');
model.result('pg2').feature('surf1').set('expr', {'c'});
model.result('pg2').set('titletype', 'custom');
model.result('pg2').set('typeintitle', false);
model.result('pg2').set('prefixintitle', '');
model.result('pg2').set('expressionintitle', false);
model.result.dataset('dset1').set('geom', 'geom1');
model.result.create('pg3', 'PlotGroup2D');
model.result('pg3').label('Velocity (spf)');
model.result('pg3').set('dataisaxisym', 'off');
model.result('pg3').set('frametype', 'spatial');
model.result('pg3').set('data', 'dset1');
model.result('pg3').set('defaultPlotID', 'ResultDefaults_SinglePhaseFlow/icom1/pdef1/pcond1/pg1');
model.result('pg3').feature.create('surf1', 'Surface');
model.result('pg3').feature('surf1').label('Surface');
model.result('pg3').feature('surf1').set('showsolutionparams', 'on');
model.result('pg3').feature('surf1').set('expr', 'spf.U');
model.result('pg3').feature('surf1').set('smooth', 'internal');
model.result('pg3').feature('surf1').set('showsolutionparams', 'on');
model.result('pg3').feature('surf1').set('data', 'parent');
model.result.create('pg4', 'PlotGroup2D');
model.result('pg4').label('Pressure (spf)');
model.result('pg4').set('dataisaxisym', 'off');
model.result('pg4').set('frametype', 'spatial');
model.result('pg4').set('data', 'dset1');
model.result('pg4').set('defaultPlotID', 'ResultDefaults_SinglePhaseFlow/icom1/pdef1/pcond1/pg2');
model.result('pg4').feature.create('con1', 'Contour');
model.result('pg4').feature('con1').label('Contour');
model.result('pg4').feature('con1').set('showsolutionparams', 'on');
model.result('pg4').feature('con1').set('expr', 'p');
model.result('pg4').feature('con1').set('number', 40);
model.result('pg4').feature('con1').set('levelrounding', false);
model.result('pg4').feature('con1').set('smooth', 'internal');
model.result('pg4').feature('con1').set('showsolutionparams', 'on');
model.result('pg4').feature('con1').set('data', 'parent');
model.result.dataset('rev1').set('data', 'dset1');
model.result.create('pg5', 'PlotGroup3D');
model.result('pg5').label('Velocity, 3D (spf)');
model.result('pg5').set('frametype', 'spatial');
model.result('pg5').set('data', 'rev1');
model.result('pg5').set('defaultPlotID', 'ResultDefaults_SinglePhaseFlow/icom1/pdef1/pcond1/pcond1/pg1');
model.result('pg5').feature.create('surf1', 'Surface');
model.result('pg5').feature('surf1').label('Surface');
model.result('pg5').feature('surf1').set('showsolutionparams', 'on');
model.result('pg5').feature('surf1').set('expr', 'spf.U');
model.result('pg5').feature('surf1').set('smooth', 'internal');
model.result('pg5').feature('surf1').set('showsolutionparams', 'on');
model.result('pg5').feature('surf1').set('data', 'parent');
model.result('pg1').run;

model.view.create('view2', 2);
model.view('view2').axis.set('viewscaletype', 'manual');
model.view('view2').axis.set('xscale', 25);

model.result('pg1').run;
model.result('pg1').set('view', 'view2');
model.result('pg1').run;
model.result('pg1').run;
model.result('pg1').feature('surf1').set('colortable', 'JupiterAuroraBorealis');
model.result('pg1').run;
model.result('pg1').feature('str1').set('posmethod', 'selection');
model.result('pg1').feature('str1').set('selnumber', 13);
model.result('pg1').feature('str1').selection.set([2]);
model.result('pg1').feature('str1').set('arrowdistr', 'equaltime');
model.result('pg1').feature('str1').set('arrowlength', 'normalized');
model.result('pg1').feature('str1').set('arrowscaleactive', true);
model.result('pg1').feature('str1').set('arrowscale', 2);
model.result('pg1').feature('str1').set('color', 'custom');
model.result('pg1').feature('str1').set('customcolor', [0.03529411926865578 0.4627451002597809 0.03529411926865578]);
model.result('pg1').run;
model.result('pg1').create('arwl1', 'ArrowLine');
model.result('pg1').feature('arwl1').create('sel1', 'Selection');
model.result('pg1').feature('arwl1').feature('sel1').selection.set([2 8]);
model.result('pg1').run;
model.result('pg1').feature('arwl1').set('expr', {'u' 'w'});
model.result('pg1').feature('arwl1').set('descr', 'Velocity field');
model.result('pg1').feature('arwl1').set('arrowcount', 39);
model.result('pg1').feature('arwl1').set('scaleactive', true);
model.result('pg1').feature('arwl1').set('scale', 1400);
model.result('pg1').run;
model.result('pg2').run;
model.result('pg2').label('Concentration 2D Revolution');
model.result('pg2').set('edges', false);
model.result('pg2').run;
model.result('pg2').feature('surf1').set('colortable', 'JupiterAuroraBorealis');

model.view('view3').camera.set('zoomanglefull', 15.56965351104736);
model.view('view3').camera.setIndex('position', -65.4335327148437, 0);
model.view('view3').camera.setIndex('position', -74.4683685302734, 1);
model.view('view3').camera.setIndex('position', 59.57064056396484, 2);
model.view('view3').camera.setIndex('target', 0.1020736694335937, 0);
model.view('view3').camera.setIndex('target', -1.37329101562E-4, 1);
model.view('view3').camera.setIndex('target', 10.49999618530273, 2);
model.view('view3').camera.setIndex('up', 0.268209069967269, 0);
model.view('view3').camera.setIndex('up', 0.3542815446853637, 1);
model.view('view3').camera.setIndex('up', 0.895850718021392, 2);
model.view('view3').camera.setIndex('rotationpoint', 0.1020634174346923, 0);
model.view('view3').camera.setIndex('rotationpoint', -1.122951507568359E-4, 1);
model.view('view3').camera.setIndex('rotationpoint', '10.50', 2);
model.view('view3').camera.setIndex('viewoffset', -0.0531463846564292, 0);
model.view('view3').camera.setIndex('viewoffset', '-0.0173676982522010', 1);

model.result('pg2').run;
model.result('pg2').run;
model.result('pg3').run;
model.result('pg3').run;
model.result('pg3').feature('surf1').set('colortable', 'Wave');
model.result('pg4').run;
model.result('pg4').run;
model.result('pg4').feature('con1').create('sel1', 'Selection');
model.result('pg4').feature('con1').feature('sel1').selection.set([3]);
model.result('pg4').run;
model.result('pg4').feature('con1').set('number', 20);
model.result('pg4').feature.duplicate('con2', 'con1');
model.result('pg4').run;
model.result('pg4').run;
model.result('pg4').feature('con2').feature('sel1').selection.set([1]);
model.result('pg4').run;
model.result('pg5').run;
model.result('pg5').label('Velocity 2D Revolution');
model.result('pg5').run;
model.result('pg5').feature('surf1').set('colortable', 'Wave');
model.result.dataset.create('cln1', 'CutLine2D');
model.result.dataset('cln1').setIndex('genpoints', 'H/2', 0, 1);
model.result.dataset('cln1').setIndex('genpoints', 'Rhf+Lm+Lpc', 1, 0);
model.result.dataset('cln1').setIndex('genpoints', 'H/2', 1, 1);
model.result.dataset.create('cln2', 'CutLine2D');
model.result.dataset('cln2').setIndex('genpoints', 'H', 0, 1);
model.result.dataset('cln2').setIndex('genpoints', 'Rhf+Lm+Lpc', 1, 0);
model.result.dataset('cln2').setIndex('genpoints', 'H', 1, 1);
model.result.create('pg6', 'PlotGroup1D');
model.result('pg6').run;
model.result('pg6').label('Concentration Jump');
model.result('pg6').create('lngr1', 'LineGraph');
model.result('pg6').feature('lngr1').set('markerpos', 'datapoints');
model.result('pg6').feature('lngr1').set('linewidth', 'preference');
model.result('pg6').feature('lngr1').label('At H/2');
model.result('pg6').feature('lngr1').set('data', 'cln1');
model.result('pg6').feature('lngr1').set('xdata', 'expr');
model.result('pg6').feature('lngr1').set('xdataexpr', 'r');
model.result('pg6').feature('lngr1').set('linewidth', 2);
model.result('pg6').feature('lngr1').set('legend', true);
model.result('pg6').feature('lngr1').set('legendmethod', 'manual');
model.result('pg6').feature('lngr1').setIndex('legends', 'At half fiber length', 0);
model.result('pg6').run;
model.result('pg6').create('lngr2', 'LineGraph');
model.result('pg6').feature('lngr2').set('markerpos', 'datapoints');
model.result('pg6').feature('lngr2').set('linewidth', 'preference');
model.result('pg6').feature('lngr2').label('At H');
model.result('pg6').feature('lngr2').set('data', 'cln2');
model.result('pg6').feature('lngr2').set('titletype', 'none');
model.result('pg6').feature('lngr2').set('xdata', 'expr');
model.result('pg6').feature('lngr2').set('xdataexpr', 'r');
model.result('pg6').feature('lngr2').set('linewidth', 2);
model.result('pg6').feature('lngr2').set('legend', true);
model.result('pg6').feature('lngr2').set('legendmethod', 'manual');
model.result('pg6').feature('lngr2').setIndex('legends', 'At outlet', 0);
model.result('pg6').run;

model.title('Separation Through Dialysis');

model.description(['This example computes the contaminant concentration in an aqueous stream that undergoes dialysis. A dialysis device is typically made of a hollow fiber module, where many hollow fibers act as a membrane. The process is diffusion-driven; that is, the contaminants diffuse through the membrane due to concentration differences between the dialysate and the permeate sides of the membrane.' newline  newline 'This example models the contaminant removal within a single hollow fiber and assumes fully developed laminar flow within the geometry. Partition equilibria between the different parts of the fiber that cause discontinuities in the transported species concentration are also accounted for.']);

model.mesh.clearMeshes;

model.sol('sol1').clearSolutionData;
model.sol('sol2').clearSolutionData;

model.label('dialysis.mph');

model.modelNode.label('Components');

out = model;
