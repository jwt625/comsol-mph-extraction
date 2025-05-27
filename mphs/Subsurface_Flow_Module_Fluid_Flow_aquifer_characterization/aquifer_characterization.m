function out = model
%
% aquifer_characterization.m
%
% Model exported on May 26 2025, 21:34 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/Subsurface_Flow_Module/Fluid_Flow');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 2);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.physics.create('dl', 'PorousMediaFlowDarcy', 'geom1');
model.physics('dl').model('comp1');

model.study.create('std1');
model.study('std1').create('stat', 'Stationary');
model.study('std1').feature('stat').setSolveFor('/physics/dl', true);

model.geom('geom1').create('sq1', 'Square');
model.geom('geom1').feature('sq1').set('size', 100);
model.geom('geom1').feature('sq1').set('pos', [-150 -150]);
model.geom('geom1').run('sq1');
model.geom('geom1').create('arr1', 'Array');
model.geom('geom1').feature('arr1').selection('input').set({'sq1'});
model.geom('geom1').feature('arr1').set('fullsize', [3 3]);
model.geom('geom1').feature('arr1').set('displ', [100 100]);
model.geom('geom1').run('arr1');
model.geom('geom1').create('pt1', 'Point');
model.geom('geom1').feature('pt1').setIndex('p', '-50,0,0,50', 0);
model.geom('geom1').feature('pt1').setIndex('p', '0,-50,50,0', 1);
model.geom('geom1').run('fin');

model.param.set('N0', '0.1[kg/(m*s)]');
model.param.descr('N0', 'Pump source strength');
model.param.set('deltaH', '1[cm]');
model.param.descr('deltaH', 'Hydraulic head measurement error');
model.param.set('logKs0', '-5');
model.param.descr('logKs0', 'Hydraulic conductivity, initial log10 value');
model.param.set('th', '1');
model.param.descr('th', 'Measurement-series index');
model.param.set('sigma', '1');
model.param.descr('sigma', 'Sill parameter');
model.param.set('r', '50[m]');
model.param.descr('r', 'Range parameter');
model.param.set('elementTypeFactor', '1');
model.param.descr('elementTypeFactor', '1 for quads, 0.5 for triangles');

model.func.create('int1', 'Interpolation');
model.func('int1').set('source', 'file');
model.func('int1').set('filename', 'aquifer_characterization_logKs_ref.txt');
model.func('int1').set('struct', 'grid');
model.func('int1').importData;
model.func('int1').label('logKs Reference');
model.func('int1').setIndex('funcs', 'logKs_ref', 0, 0);
model.func('int1').set('interp', 'neighbor');
model.func('int1').setIndex('fununit', 1, 0);
model.func('int1').setIndex('argunit', 'm', 0);
model.func('int1').setIndex('argunit', 'm', 1);

model.coordSystem.create('ie1', 'geom1', 'InfiniteElement');
model.coordSystem('ie1').selection.set([1 2 3 4 6 7 8 9]);

model.variable.create('var1');
model.variable('var1').model('comp1');
model.variable('var1').set('logKs', 'logKs_ref(x,y)');
model.variable('var1').descr('logKs', 'Hydraulic conductivity, log 10 value');

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

model.physics('dl').feature('porous1').feature('pm1').set('permeabilityModelType', 'conductivity');
model.physics('dl').feature('porous1').feature('pm1').set('K', {'10^logKs0' '0' '0' '0' '10^logKs0' '0' '0' '0' '10^logKs0'});
model.physics('dl').create('porous2', 'PorousMedium', 2);
model.physics('dl').feature('porous2').selection.set([5]);
model.physics('dl').feature('porous2').feature('pm1').set('permeabilityModelType', 'conductivity');
model.physics('dl').feature('porous2').feature('pm1').set('K', {'10^logKs' '0' '0' '0' '10^logKs' '0' '0' '0' '10^logKs'});
model.physics('dl').create('hh1', 'HydraulicHead', 1);
model.physics('dl').feature('hh1').selection.set([1 2 3 5 7 9 15 19 25 26 27 28]);
model.physics('dl').create('lms1', 'LineMassSource', 0);
model.physics('dl').feature('lms1').selection.set([6]);
model.physics('dl').feature('lms1').set('N0', 'if(th==1,N0,0)');
model.physics('dl').create('lms2', 'LineMassSource', 0);
model.physics('dl').feature('lms2').selection.set([7]);
model.physics('dl').feature('lms2').set('N0', 'if(th==2,N0,0)');
model.physics('dl').create('lms3', 'LineMassSource', 0);
model.physics('dl').feature('lms3').selection.set([8]);
model.physics('dl').feature('lms3').set('N0', 'if(th==3,N0,0)');
model.physics('dl').create('lms4', 'LineMassSource', 0);
model.physics('dl').feature('lms4').selection.set([10]);
model.physics('dl').feature('lms4').set('N0', 'if(th==4,N0,0)');
model.physics('dl').create('lms5', 'LineMassSource', 0);
model.physics('dl').feature('lms5').selection.set([11]);
model.physics('dl').feature('lms5').set('N0', 'if(th==4,-N0,0)');
model.physics('dl').create('lms6', 'LineMassSource', 0);
model.physics('dl').feature('lms6').selection.set([13]);
model.physics('dl').feature('lms6').set('N0', 'if(th==3,-N0,0)');
model.physics('dl').create('lms7', 'LineMassSource', 0);
model.physics('dl').feature('lms7').selection.set([14]);
model.physics('dl').feature('lms7').set('N0', 'if(th==2,-N0,0)');
model.physics('dl').create('lms8', 'LineMassSource', 0);
model.physics('dl').feature('lms8').selection.set([15]);
model.physics('dl').feature('lms8').set('N0', 'if(th==1,-N0,0)');

model.mesh('mesh1').automatic(false);
model.mesh('mesh1').feature('ftri1').create('size1', 'Size');
model.mesh('mesh1').feature('ftri1').feature('size1').selection.geom('geom1', 2);
model.mesh('mesh1').feature('ftri1').feature('size1').selection.set([5]);
model.mesh('mesh1').feature('ftri1').feature('size1').set('custom', true);
model.mesh('mesh1').feature('ftri1').feature('size1').set('hmaxactive', true);
model.mesh('mesh1').feature('ftri1').feature('size1').set('hmax', 5);
model.mesh('mesh1').feature('ftri1').create('size2', 'Size');
model.mesh('mesh1').feature('ftri1').feature('size2').selection.geom('geom1', 0);
model.mesh('mesh1').feature('ftri1').feature('size2').selection.set([6 7 8 10 11 13 14 15]);
model.mesh('mesh1').feature('ftri1').feature('size2').set('custom', true);
model.mesh('mesh1').feature('ftri1').feature('size2').set('hmaxactive', true);
model.mesh('mesh1').feature('ftri1').feature('size2').set('hmax', 0.1);
model.mesh('mesh1').run;

model.sol.create('sol1');

model.mesh('mesh1').stat.selection.geom(2);
model.mesh('mesh1').stat.selection.set([1 2 3 4 5 6 7 8 9]);

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
model.sol('sol1').feature('s1').feature('fc1').set('minstep', 1.0E-6);
model.sol('sol1').feature('s1').feature('fc1').set('maxiter', 50);
model.sol('sol1').feature('s1').create('d1', 'Direct');
model.sol('sol1').feature('s1').feature('d1').set('linsolver', 'pardiso');
model.sol('sol1').feature('s1').feature('d1').set('pivotperturb', 1.0E-13);
model.sol('sol1').feature('s1').feature('d1').label('Direct, pressure (dl)');
model.sol('sol1').feature('s1').create('i1', 'Iterative');
model.sol('sol1').feature('s1').feature('i1').set('linsolver', 'gmres');
model.sol('sol1').feature('s1').feature('i1').set('prefuntype', 'left');
model.sol('sol1').feature('s1').feature('i1').set('itrestart', 50);
model.sol('sol1').feature('s1').feature('i1').set('rhob', 400);
model.sol('sol1').feature('s1').feature('i1').set('maxlinit', 1000);
model.sol('sol1').feature('s1').feature('i1').set('nlinnormuse', 'on');
model.sol('sol1').feature('s1').feature('i1').label('AMG, pressure (dl)');
model.sol('sol1').feature('s1').feature('i1').create('mg1', 'Multigrid');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').set('prefun', 'saamg');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').set('mgcycle', 'v');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').set('maxcoarsedof', 50000);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').set('strconn', 0.01);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').set('nullspace', 'constant');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').set('usesmooth', false);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').set('saamgcompwise', false);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').set('loweramg', true);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').set('compactaggregation', false);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('pr').create('sl1', 'SORLine');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('pr').feature('sl1').set('linesweeptype', 'ssor');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('pr').feature('sl1').set('iter', 1);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('pr').feature('sl1').set('linerelax', 0.7);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('pr').feature('sl1').set('linealgorithm', 'mesh');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('pr').feature('sl1').set('linemethod', 'coupled');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('pr').feature('sl1').set('seconditer', 1);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('pr').feature('sl1').set('relax', 0.5);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('po').create('sl1', 'SORLine');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('po').feature('sl1').set('linesweeptype', 'ssor');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('po').feature('sl1').set('iter', 1);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('po').feature('sl1').set('linerelax', 0.7);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('po').feature('sl1').set('linealgorithm', 'mesh');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('po').feature('sl1').set('linemethod', 'coupled');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('po').feature('sl1').set('seconditer', 1);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('po').feature('sl1').set('relax', 0.5);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('cs').create('d1', 'Direct');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('cs').feature('d1').set('linsolver', 'pardiso');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('cs').feature('d1').set('pivotperturb', 1.0E-13);
model.sol('sol1').feature('s1').feature('fc1').set('linsolver', 'd1');
model.sol('sol1').feature('s1').feature('fc1').set('dtech', 'auto');
model.sol('sol1').feature('s1').feature('fc1').set('initstep', 0.01);
model.sol('sol1').feature('s1').feature('fc1').set('minstep', 1.0E-6);
model.sol('sol1').feature('s1').feature('fc1').set('maxiter', 50);
model.sol('sol1').feature('s1').feature.remove('fcDef');
model.sol('sol1').attach('std1');
model.sol('sol1').runAll;

model.result.create('pg1', 'PlotGroup2D');
model.result('pg1').label('Pressure (dl)');
model.result('pg1').set('titletype', 'custom');
model.result('pg1').set('data', 'dset1');
model.result('pg1').set('defaultPlotID', 'PhysicsInterfaces_PorousMediaFlow/icom6/pdef1/pcond2/pg1');
model.result('pg1').feature.create('surf1', 'Surface');
model.result('pg1').feature('surf1').label('Surface');
model.result('pg1').feature('surf1').set('showsolutionparams', 'on');
model.result('pg1').feature('surf1').set('smooth', 'internal');
model.result('pg1').feature('surf1').set('showsolutionparams', 'on');
model.result('pg1').feature('surf1').set('data', 'parent');
model.result('pg1').feature.create('str1', 'Streamline');
model.result('pg1').feature('str1').set('showsolutionparams', 'on');
model.result('pg1').feature('str1').set('posmethod', 'uniform');
model.result('pg1').feature('str1').set('pointtype', 'arrow');
model.result('pg1').feature('str1').set('arrowlength', 'logarithmic');
model.result('pg1').feature('str1').set('color', 'gray');
model.result('pg1').feature('str1').set('smooth', 'internal');
model.result('pg1').feature('str1').set('maxlen', Inf);
model.result('pg1').feature('str1').set('maxtime', Inf);
model.result('pg1').feature('str1').set('showsolutionparams', 'on');
model.result('pg1').feature('str1').set('maxlen', Inf);
model.result('pg1').feature('str1').set('maxtime', Inf);
model.result('pg1').feature('str1').set('showsolutionparams', 'on');
model.result('pg1').feature('str1').set('maxlen', Inf);
model.result('pg1').feature('str1').set('maxtime', Inf);
model.result('pg1').feature('str1').set('showsolutionparams', 'on');
model.result('pg1').feature('str1').set('maxlen', Inf);
model.result('pg1').feature('str1').set('maxtime', Inf);
model.result('pg1').feature('str1').set('showsolutionparams', 'on');
model.result('pg1').feature('str1').set('maxlen', Inf);
model.result('pg1').feature('str1').set('maxtime', Inf);
model.result('pg1').feature('str1').set('data', 'parent');
model.result('pg1').feature('str1').selection.geom('geom1', 1);
model.result('pg1').feature('str1').selection.set([1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28]);
model.result('pg1').run;
model.result('pg1').label('Pressure, Forward');
model.result.create('pg2', 'PlotGroup2D');
model.result('pg2').label('Flownet (dl)');
model.result('pg2').set('data', 'dset1');
model.result('pg2').set('defaultPlotID', 'PhysicsInterfaces_PorousMediaFlow/icom6/pdef1/pcond2/pcond5/pg3');
model.result('pg2').feature.create('con1', 'Contour');
model.result('pg2').feature('con1').set('expr', 'dl.H');
model.result('pg2').feature('con1').set('levelrounding', false);
model.result('pg2').feature('con1').set('coloring', 'uniform');
model.result('pg2').feature('con1').set('colorlegend', false);
model.result('pg2').feature('con1').set('color', 'green');
model.result('pg2').feature('con1').set('smooth', 'internal');
model.result('pg2').feature('con1').set('showsolutionparams', 'on');
model.result('pg2').feature('con1').set('data', 'parent');
model.result('pg2').feature.create('str1', 'Streamline');
model.result('pg2').feature('str1').set('posmethod', 'magnitude');
model.result('pg2').feature('str1').set('madv', 'manual');
model.result('pg2').feature('str1').set('msatfactor', 1.4);
model.result('pg2').feature('str1').set('color', 'blue');
model.result('pg2').feature('str1').set('resolution', 'extrafine');
model.result('pg2').feature('str1').set('smooth', 'internal');
model.result('pg2').feature('str1').set('showsolutionparams', 'on');
model.result('pg2').feature('str1').set('maxlen', Inf);
model.result('pg2').feature('str1').set('maxtime', Inf);
model.result('pg2').feature('str1').set('data', 'parent');
model.result('pg2').feature('str1').selection.geom('geom1', 1);
model.result('pg2').feature('str1').selection.set([1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28]);
model.result('pg2').label('Flownet (dl)');
model.result('pg2').run;
model.result('pg2').label('Flownet, Forward');

model.modelNode.create('comp2', true);

model.geom.create('geom2', 2);
model.geom('geom2').model('comp2');

model.mesh.create('mesh2', 'geom2');

model.physics.create('opt', 'GeneralOptimization', 'geom2');
model.physics('opt').model('comp2');

model.study('std1').feature('stat').setSolveFor('/physics/opt', true);

model.geom('geom2').run;

model.physics.create('dode', 'DomainODE', 'geom2', {'u'});

model.study('std1').feature('stat').setSolveFor('/physics/dode', true);

model.physics('dode').prop('EquationForm').set('form', 'Automatic');

model.study.create('std2');
model.study('std2').create('stat', 'Stationary');
model.study('std2').feature('stat').setSolveFor('/physics/dl', true);
model.study('std2').feature('stat').setSolveFor('/physics/opt', true);
model.study('std2').feature('stat').setSolveFor('/physics/dode', true);

model.geom('geom2').create('sq1', 'Square');
model.geom('geom2').feature('sq1').set('size', 100);
model.geom('geom2').feature('sq1').set('base', 'center');
model.geom('geom2').run('sq1');

model.cpl.create('genext1', 'GeneralExtrusion', 'geom2');

model.geom('geom2').run;

model.cpl('genext1').selection.all;
model.cpl.create('aveop1', 'Average', 'geom2');
model.cpl('aveop1').set('axisym', true);
model.cpl('aveop1').set('opname', 'mean');
model.cpl('aveop1').selection.all;
model.cpl.create('intop1', 'Integration', 'geom2');
model.cpl('intop1').set('axisym', true);
model.cpl('intop1').set('opname', 'int0');
model.cpl('intop1').selection.all;
model.cpl('intop1').set('intorder', 0);

model.variable.create('var2');
model.variable('var2').model('comp2');
model.variable('var2').label('Variables, Domain');
model.variable('var2').selection.geom('geom2', 2);
model.variable('var2').selection.set([1]);
model.variable('var2').set('logKs_ref', 'logKs_ref(x,y)');
model.variable('var2').descr('logKs_ref', 'Hydraulic conductivity, reference model');
model.variable('var2').set('areaFactor', '1/(elementTypeFactor*dvol)');
model.variable('var2').descr('areaFactor', 'Summation compensation factor');
model.variable('var2').set('dist', 'sqrt((x-dest(x))^2+(y-dest(y))^2)');
model.variable('var2').descr('dist', 'Distance between points inside summation');
model.variable.create('var3');
model.variable('var3').model('comp2');
model.variable('var3').label('Variables, Global');
model.variable('var3').set('MSE', 'mean((logKs-logKs_ref)^2)');
model.variable('var3').descr('MSE', 'Area-weighted mean squared error');
model.variable('var3').set('logKs_mean', 'int0(logKs*areaFactor)/int0(areaFactor)');
model.variable('var3').descr('logKs_mean', 'Discrete control variable mean');
model.variable('var3').set('L_penalty', 'int0((logKs-logKs_mean)*u*areaFactor)');
model.variable('var3').descr('L_penalty', 'Penalty function');

model.func.create('an1', 'Analytic');
model.func('an1').model('comp2');
model.func('an1').label('Covariance function');
model.func('an1').set('funcname', 'Q');
model.func('an1').set('expr', 'sigma^2*exp(-x/r)');
model.func('an1').setIndex('argunit', 'm', 0);
model.func('an1').set('fununit', '1');

model.physics('opt').create('cvar1', 'ControlVariableField', 2);
model.physics('opt').feature('cvar1').selection.all;
model.physics('opt').feature('cvar1').set('fieldVariableName', 'logKs');
model.physics('opt').feature('cvar1').set('initialValue', 'logKs_ref');
model.physics('opt').feature('cvar1').set('shapeFunctionType', 'shdisc');
model.physics('opt').feature('cvar1').set('order', 0);
model.physics('opt').create('glsobj1', 'GlobalLeastSquaresObjective', -1);
model.physics('opt').feature('glsobj1').set('fileName', 'aquifer_characterization_zero.csv');
model.physics('opt').feature('glsobj1').create('v1', 'ValueColumn', -1);
model.physics('opt').feature('glsobj1').feature('v1').set('columnExpression', 'sqrt(L_penalty)');
model.physics('dode').prop('Units').setIndex('CustomSourceTermUnit', 1, 0, 0);
model.physics('dode').prop('ShapeProperty').set('order', 0);
model.physics('dode').feature('dode1').setIndex('f', '(logKs-logKs_mean-int0(u*Q(dist)*areaFactor))', 0);

model.mesh('mesh2').create('map1', 'Map');
model.mesh('mesh2').feature('map1').create('dis1', 'Distribution');
model.mesh('mesh2').feature('map1').feature('dis1').selection.all;
model.mesh('mesh2').feature('map1').feature('dis1').set('numelem', 10);
model.mesh('mesh2').run;

model.variable.duplicate('var4', 'var1');
model.variable('var4').set('logKs', 'comp2.genext1(comp2.logKs)');

model.physics.create('opt2', 'GeneralOptimization', 'geom1');
model.physics('opt2').model('comp1');

model.study('std1').feature('stat').setSolveFor('/physics/opt2', true);
model.study('std2').feature('stat').setSolveFor('/physics/opt2', true);

model.physics('opt2').create('lsobj1', 'LeastSquaresObjective', 2);
model.physics('opt2').feature('lsobj1').selection.set([5]);
model.physics('opt2').feature('lsobj1').set('fileName', 'aquifer_characterization_H1.csv');
model.physics('opt2').feature('lsobj1').setIndex('paramNames', 'N0', 0, 0);
model.physics('opt2').feature('lsobj1').setIndex('paramExprs', '', 0, 0);
model.physics('opt2').feature('lsobj1').setIndex('paramExprs', '', 0, 0);
model.physics('opt2').feature('lsobj1').setIndex('paramNames', 'N0', 0, 0);
model.physics('opt2').feature('lsobj1').setIndex('paramExprs', '', 0, 0);
model.physics('opt2').feature('lsobj1').setIndex('paramNames', 'th', 0, 0);
model.physics('opt2').feature('lsobj1').setIndex('paramExprs', 1, 0, 0);
model.physics('opt2').feature('lsobj1').create('c1', 'CoordinateColumn', -1);
model.physics('opt2').feature('lsobj1').create('c2', 'CoordinateColumn', -1);
model.physics('opt2').feature('lsobj1').feature('c2').set('columnCoordinate', 2);
model.physics('opt2').feature('lsobj1').create('v1', 'ValueColumn', -1);
model.physics('opt2').feature('lsobj1').feature('v1').set('columnExpression', 'comp1.dl.H');
model.physics('opt2').feature('lsobj1').feature('v1').set('columnExpressionWeight', '1/deltaH^2');
model.physics('opt2').feature.duplicate('lsobj2', 'lsobj1');
model.physics('opt2').feature('lsobj2').set('fileName', 'aquifer_characterization_H2.csv');
model.physics('opt2').feature('lsobj2').setIndex('paramExprs', 2, 0, 0);
model.physics('opt2').feature.duplicate('lsobj3', 'lsobj2');
model.physics('opt2').feature('lsobj3').set('fileName', 'aquifer_characterization_H3.csv');
model.physics('opt2').feature('lsobj3').setIndex('paramExprs', 3, 0, 0);
model.physics('opt2').feature.duplicate('lsobj4', 'lsobj3');
model.physics('opt2').feature('lsobj4').set('fileName', 'aquifer_characterization_H4.csv');
model.physics('opt2').feature('lsobj4').setIndex('paramExprs', 4, 0, 0);

model.study('std2').feature('stat').set('useadvanceddisable', true);
model.study('std2').feature('stat').set('disabledvariables', {'var1'});

model.sol.create('sol2');

model.mesh('mesh1').stat.selection.geom(2);
model.mesh('mesh1').stat.selection.set([1 2 3 4 5 6 7 8 9]);

model.sol('sol2').study('std2');
model.sol('sol2').create('st1', 'StudyStep');
model.sol('sol2').feature('st1').set('study', 'std2');
model.sol('sol2').feature('st1').set('studystep', 'stat');
model.sol('sol2').create('v1', 'Variables');
model.sol('sol2').feature('v1').set('control', 'stat');
model.sol('sol2').create('s1', 'Stationary');
model.sol('sol2').feature('s1').feature('aDef').set('cachepattern', true);
model.sol('sol2').feature('s1').create('seDef', 'Segregated');
model.sol('sol2').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol2').feature('s1').feature('fc1').set('dtech', 'auto');
model.sol('sol2').feature('s1').feature('fc1').set('initstep', 0.01);
model.sol('sol2').feature('s1').feature('fc1').set('minstep', 1.0E-6);
model.sol('sol2').feature('s1').feature('fc1').set('maxiter', 50);
model.sol('sol2').feature('s1').create('d1', 'Direct');
model.sol('sol2').feature('s1').feature('d1').set('linsolver', 'mumps');
model.sol('sol2').feature('s1').feature('d1').set('pivotperturb', 1.0E-13);
model.sol('sol2').feature('s1').feature('d1').label('Direct, pressure (dl) (Merged)');
model.sol('sol2').feature('s1').create('i1', 'Iterative');
model.sol('sol2').feature('s1').feature('i1').set('linsolver', 'gmres');
model.sol('sol2').feature('s1').feature('i1').set('prefuntype', 'left');
model.sol('sol2').feature('s1').feature('i1').set('itrestart', 50);
model.sol('sol2').feature('s1').feature('i1').set('rhob', 400);
model.sol('sol2').feature('s1').feature('i1').set('maxlinit', 1000);
model.sol('sol2').feature('s1').feature('i1').set('nlinnormuse', 'on');
model.sol('sol2').feature('s1').feature('i1').label('AMG, pressure (dl)');
model.sol('sol2').feature('s1').feature('i1').create('mg1', 'Multigrid');
model.sol('sol2').feature('s1').feature('i1').feature('mg1').set('prefun', 'saamg');
model.sol('sol2').feature('s1').feature('i1').feature('mg1').set('mgcycle', 'v');
model.sol('sol2').feature('s1').feature('i1').feature('mg1').set('maxcoarsedof', 50000);
model.sol('sol2').feature('s1').feature('i1').feature('mg1').set('strconn', 0.01);
model.sol('sol2').feature('s1').feature('i1').feature('mg1').set('nullspace', 'constant');
model.sol('sol2').feature('s1').feature('i1').feature('mg1').set('usesmooth', false);
model.sol('sol2').feature('s1').feature('i1').feature('mg1').set('saamgcompwise', false);
model.sol('sol2').feature('s1').feature('i1').feature('mg1').set('loweramg', true);
model.sol('sol2').feature('s1').feature('i1').feature('mg1').set('compactaggregation', false);
model.sol('sol2').feature('s1').feature('i1').feature('mg1').feature('pr').create('sl1', 'SORLine');
model.sol('sol2').feature('s1').feature('i1').feature('mg1').feature('pr').feature('sl1').set('linesweeptype', 'ssor');
model.sol('sol2').feature('s1').feature('i1').feature('mg1').feature('pr').feature('sl1').set('iter', 1);
model.sol('sol2').feature('s1').feature('i1').feature('mg1').feature('pr').feature('sl1').set('linerelax', 0.7);
model.sol('sol2').feature('s1').feature('i1').feature('mg1').feature('pr').feature('sl1').set('linealgorithm', 'mesh');
model.sol('sol2').feature('s1').feature('i1').feature('mg1').feature('pr').feature('sl1').set('linemethod', 'coupled');
model.sol('sol2').feature('s1').feature('i1').feature('mg1').feature('pr').feature('sl1').set('seconditer', 1);
model.sol('sol2').feature('s1').feature('i1').feature('mg1').feature('pr').feature('sl1').set('relax', 0.5);
model.sol('sol2').feature('s1').feature('i1').feature('mg1').feature('po').create('sl1', 'SORLine');
model.sol('sol2').feature('s1').feature('i1').feature('mg1').feature('po').feature('sl1').set('linesweeptype', 'ssor');
model.sol('sol2').feature('s1').feature('i1').feature('mg1').feature('po').feature('sl1').set('iter', 1);
model.sol('sol2').feature('s1').feature('i1').feature('mg1').feature('po').feature('sl1').set('linerelax', 0.7);
model.sol('sol2').feature('s1').feature('i1').feature('mg1').feature('po').feature('sl1').set('linealgorithm', 'mesh');
model.sol('sol2').feature('s1').feature('i1').feature('mg1').feature('po').feature('sl1').set('linemethod', 'coupled');
model.sol('sol2').feature('s1').feature('i1').feature('mg1').feature('po').feature('sl1').set('seconditer', 1);
model.sol('sol2').feature('s1').feature('i1').feature('mg1').feature('po').feature('sl1').set('relax', 0.5);
model.sol('sol2').feature('s1').feature('i1').feature('mg1').feature('cs').create('d1', 'Direct');
model.sol('sol2').feature('s1').feature('i1').feature('mg1').feature('cs').feature('d1').set('linsolver', 'pardiso');
model.sol('sol2').feature('s1').feature('i1').feature('mg1').feature('cs').feature('d1').set('pivotperturb', 1.0E-13);
model.sol('sol2').feature('s1').feature('fc1').set('linsolver', 'd1');
model.sol('sol2').feature('s1').feature('fc1').set('dtech', 'auto');
model.sol('sol2').feature('s1').feature('fc1').set('initstep', 0.01);
model.sol('sol2').feature('s1').feature('fc1').set('minstep', 1.0E-6);
model.sol('sol2').feature('s1').feature('fc1').set('maxiter', 50);
model.sol('sol2').feature('s1').feature.remove('fcDef');
model.sol('sol2').feature('s1').feature.remove('seDef');
model.sol('sol2').attach('std2');
model.sol('sol2').runAll;

model.result.create('pg3', 'PlotGroup2D');
model.result('pg3').label('Pressure (dl)');
model.result('pg3').set('data', 'dset2');
model.result('pg3').set('titletype', 'custom');
model.result('pg3').set('data', 'dset2');
model.result('pg3').set('defaultPlotID', 'PhysicsInterfaces_PorousMediaFlow/icom6/pdef1/pcond2/pg1');
model.result('pg3').feature.create('surf1', 'Surface');
model.result('pg3').feature('surf1').label('Surface');
model.result('pg3').feature('surf1').set('showsolutionparams', 'on');
model.result('pg3').feature('surf1').set('smooth', 'internal');
model.result('pg3').feature('surf1').set('showsolutionparams', 'on');
model.result('pg3').feature('surf1').set('data', 'parent');
model.result('pg3').feature.create('str1', 'Streamline');
model.result('pg3').feature('str1').set('showsolutionparams', 'on');
model.result('pg3').feature('str1').set('posmethod', 'uniform');
model.result('pg3').feature('str1').set('pointtype', 'arrow');
model.result('pg3').feature('str1').set('arrowlength', 'logarithmic');
model.result('pg3').feature('str1').set('color', 'gray');
model.result('pg3').feature('str1').set('smooth', 'internal');
model.result('pg3').feature('str1').set('maxlen', Inf);
model.result('pg3').feature('str1').set('maxtime', Inf);
model.result('pg3').feature('str1').set('showsolutionparams', 'on');
model.result('pg3').feature('str1').set('maxlen', Inf);
model.result('pg3').feature('str1').set('maxtime', Inf);
model.result('pg3').feature('str1').set('showsolutionparams', 'on');
model.result('pg3').feature('str1').set('maxlen', Inf);
model.result('pg3').feature('str1').set('maxtime', Inf);
model.result('pg3').feature('str1').set('showsolutionparams', 'on');
model.result('pg3').feature('str1').set('maxlen', Inf);
model.result('pg3').feature('str1').set('maxtime', Inf);
model.result('pg3').feature('str1').set('showsolutionparams', 'on');
model.result('pg3').feature('str1').set('maxlen', Inf);
model.result('pg3').feature('str1').set('maxtime', Inf);
model.result('pg3').feature('str1').set('data', 'parent');
model.result('pg3').feature('str1').selection.geom('geom1', 1);
model.result('pg3').feature('str1').selection.set([1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28]);
model.result.numerical.create('gev1', 'EvalGlobal');
model.result.numerical('gev1').set('data', 'dset3');
model.result.numerical('gev1').set('expr', {'opt.glsobj1'});
model.result.numerical('gev1').set('descr', {'Objective value'});
model.result.create('pg4', 'PlotGroup2D');
model.result('pg4').set('data', 'dset3');
model.result('pg4').create('surf1', 'Surface');
model.result('pg4').label('General Optimization');
model.result('pg4').feature('surf1').set('expr', 'logKs');
model.result.create('pg5', 'PlotGroup2D');
model.result('pg5').set('data', 'dset3');
model.result('pg5').create('surf1', 'Surface');
model.result('pg5').label('Domain ODEs and DAEs');
model.result('pg5').feature('surf1').set('expr', 'u');
model.result.numerical.create('gev2', 'EvalGlobal');
model.result.numerical('gev2').set('data', 'dset2');
model.result.numerical('gev2').set('expr', {'opt2.lsobj1' 'opt2.lsobj2' 'opt2.lsobj3' 'opt2.lsobj4'});
model.result.numerical('gev2').set('descr', {'Objective value' 'Objective value' 'Objective value' 'Objective value'});
model.result('pg3').run;
model.result('pg4').run;
model.result('pg4').feature('surf1').set('rangecoloractive', true);
model.result('pg4').feature('surf1').set('rangecolormin', -7);
model.result('pg4').feature('surf1').set('rangecolormax', -3);
model.result('pg4').feature('surf1').set('smooth', 'none');
model.result('pg4').run;
model.result('pg4').run;
model.result('pg4').label('log Ks, 6 Obs.');
model.result('pg5').set('windowtitle', 'Graphics');
model.result('pg3').set('windowtitle', 'Graphics');
model.result('pg4').set('window', 'window2');
model.result('pg4').set('windowtitle', 'Plot 2');
model.result('pg4').set('window', 'window2');
model.result('pg4').set('windowtitle', 'Plot 2');
model.result('pg4').run;
model.result('pg4').set('window', 'graphics');
model.result('pg4').set('windowtitle', 'Graphics');

model.physics('opt').feature('cvar1').set('initialValue', 'logKs0');

model.study('std2').create('opt', 'Optimization');
model.study('std2').feature('opt').set('optsolver', 'lm');
model.study('std2').feature('opt').set('opttolinner', 0.002);
model.study('std2').feature('opt').setIndex('objectiveActive', false, 1);
model.study('std2').feature('opt').setIndex('objectiveActive', false, 2);
model.study('std2').feature('opt').setIndex('objectiveActive', false, 3);
model.study('std2').feature('opt').set('plot', true);
model.study('std2').feature('opt').set('plotgroup', 'pg4');
model.study('std2').feature('opt').set('useobjtable', false);

model.mesh('mesh1').stat.selection.geom(2);
model.mesh('mesh1').stat.selection.set([1 2 3 4 5 6 7 8 9]);

model.sol('sol2').study('std2');
model.sol('sol2').feature.remove('s1');
model.sol('sol2').feature.remove('v1');
model.sol('sol2').feature.remove('st1');

model.study('std2').feature('opt').set('lsqmessage', {});

model.sol('sol2').create('st1', 'StudyStep');
model.sol('sol2').feature('st1').set('study', 'std2');
model.sol('sol2').feature('st1').set('studystep', 'stat');
model.sol('sol2').create('v1', 'Variables');
model.sol('sol2').feature('v1').set('control', 'stat');
model.sol('sol2').create('o1', 'Optimization');
model.sol('sol2').feature('o1').set('control', 'opt');
model.sol('sol2').feature('o1').create('s1', 'StationaryAttrib');
model.sol('sol2').feature('o1').feature('s1').set('control', 'stat');
model.sol('sol2').feature('o1').feature('s1').create('p1', 'Parametric');
model.sol('sol2').feature('o1').feature('s1').feature.remove('pDef');
model.sol('sol2').feature('o1').feature('s1').feature('p1').set('control', 'stat');
model.sol('sol2').feature('o1').feature('s1').set('control', 'stat');
model.sol('sol2').feature('o1').feature('s1').feature('p1').set('plistarrlsq', {'1.0'});
model.sol('sol2').feature('o1').feature('s1').feature('p1').set('lsqparamsout', ['        th' newline '      1.00' newline ]);
model.sol('sol2').feature('o1').feature('s1').feature('p1').set('pnamelsq', {'th'});
model.sol('sol2').feature('v1').set('cname', {});
model.sol('sol2').feature('v1').set('clist', {});
model.sol('sol2').feature('v1').set('clistctrl', {});
model.sol('sol2').feature('v1').set('cname', {'th'});
model.sol('sol2').feature('v1').set('clist', {'1.0'});
model.sol('sol2').feature('v1').set('clistctrl', {'p1lsq'});
model.sol('sol2').feature('o1').feature('s1').feature('aDef').set('cachepattern', true);
model.sol('sol2').feature('o1').feature('s1').create('seDef', 'Segregated');
model.sol('sol2').feature('o1').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol2').feature('o1').feature('s1').feature('fc1').set('dtech', 'auto');
model.sol('sol2').feature('o1').feature('s1').feature('fc1').set('initstep', 0.01);
model.sol('sol2').feature('o1').feature('s1').feature('fc1').set('minstep', 1.0E-6);
model.sol('sol2').feature('o1').feature('s1').feature('fc1').set('maxiter', 50);
model.sol('sol2').feature('o1').feature('s1').create('d1', 'Direct');
model.sol('sol2').feature('o1').feature('s1').feature('d1').set('linsolver', 'mumps');
model.sol('sol2').feature('o1').feature('s1').feature('d1').set('pivotperturb', 1.0E-13);
model.sol('sol2').feature('o1').feature('s1').feature('d1').label('Direct, pressure (dl) (Merged)');
model.sol('sol2').feature('o1').feature('s1').create('i1', 'Iterative');
model.sol('sol2').feature('o1').feature('s1').feature('i1').set('linsolver', 'gmres');
model.sol('sol2').feature('o1').feature('s1').feature('i1').set('prefuntype', 'left');
model.sol('sol2').feature('o1').feature('s1').feature('i1').set('itrestart', 50);
model.sol('sol2').feature('o1').feature('s1').feature('i1').set('rhob', 400);
model.sol('sol2').feature('o1').feature('s1').feature('i1').set('maxlinit', 1000);
model.sol('sol2').feature('o1').feature('s1').feature('i1').set('nlinnormuse', 'on');
model.sol('sol2').feature('o1').feature('s1').feature('i1').label('AMG, pressure (dl)');
model.sol('sol2').feature('o1').feature('s1').feature('i1').create('mg1', 'Multigrid');
model.sol('sol2').feature('o1').feature('s1').feature('i1').feature('mg1').set('prefun', 'saamg');
model.sol('sol2').feature('o1').feature('s1').feature('i1').feature('mg1').set('mgcycle', 'v');
model.sol('sol2').feature('o1').feature('s1').feature('i1').feature('mg1').set('maxcoarsedof', 50000);
model.sol('sol2').feature('o1').feature('s1').feature('i1').feature('mg1').set('strconn', 0.01);
model.sol('sol2').feature('o1').feature('s1').feature('i1').feature('mg1').set('nullspace', 'constant');
model.sol('sol2').feature('o1').feature('s1').feature('i1').feature('mg1').set('usesmooth', false);
model.sol('sol2').feature('o1').feature('s1').feature('i1').feature('mg1').set('saamgcompwise', false);
model.sol('sol2').feature('o1').feature('s1').feature('i1').feature('mg1').set('loweramg', true);
model.sol('sol2').feature('o1').feature('s1').feature('i1').feature('mg1').set('compactaggregation', false);
model.sol('sol2').feature('o1').feature('s1').feature('i1').feature('mg1').feature('pr').create('sl1', 'SORLine');
model.sol('sol2').feature('o1').feature('s1').feature('i1').feature('mg1').feature('pr').feature('sl1').set('linesweeptype', 'ssor');
model.sol('sol2').feature('o1').feature('s1').feature('i1').feature('mg1').feature('pr').feature('sl1').set('iter', 1);
model.sol('sol2').feature('o1').feature('s1').feature('i1').feature('mg1').feature('pr').feature('sl1').set('linerelax', 0.7);
model.sol('sol2').feature('o1').feature('s1').feature('i1').feature('mg1').feature('pr').feature('sl1').set('linealgorithm', 'mesh');
model.sol('sol2').feature('o1').feature('s1').feature('i1').feature('mg1').feature('pr').feature('sl1').set('linemethod', 'coupled');
model.sol('sol2').feature('o1').feature('s1').feature('i1').feature('mg1').feature('pr').feature('sl1').set('seconditer', 1);
model.sol('sol2').feature('o1').feature('s1').feature('i1').feature('mg1').feature('pr').feature('sl1').set('relax', 0.5);
model.sol('sol2').feature('o1').feature('s1').feature('i1').feature('mg1').feature('po').create('sl1', 'SORLine');
model.sol('sol2').feature('o1').feature('s1').feature('i1').feature('mg1').feature('po').feature('sl1').set('linesweeptype', 'ssor');
model.sol('sol2').feature('o1').feature('s1').feature('i1').feature('mg1').feature('po').feature('sl1').set('iter', 1);
model.sol('sol2').feature('o1').feature('s1').feature('i1').feature('mg1').feature('po').feature('sl1').set('linerelax', 0.7);
model.sol('sol2').feature('o1').feature('s1').feature('i1').feature('mg1').feature('po').feature('sl1').set('linealgorithm', 'mesh');
model.sol('sol2').feature('o1').feature('s1').feature('i1').feature('mg1').feature('po').feature('sl1').set('linemethod', 'coupled');
model.sol('sol2').feature('o1').feature('s1').feature('i1').feature('mg1').feature('po').feature('sl1').set('seconditer', 1);
model.sol('sol2').feature('o1').feature('s1').feature('i1').feature('mg1').feature('po').feature('sl1').set('relax', 0.5);
model.sol('sol2').feature('o1').feature('s1').feature('i1').feature('mg1').feature('cs').create('d1', 'Direct');
model.sol('sol2').feature('o1').feature('s1').feature('i1').feature('mg1').feature('cs').feature('d1').set('linsolver', 'pardiso');
model.sol('sol2').feature('o1').feature('s1').feature('i1').feature('mg1').feature('cs').feature('d1').set('pivotperturb', 1.0E-13);
model.sol('sol2').feature('o1').feature('s1').feature('fc1').set('linsolver', 'd1');
model.sol('sol2').feature('o1').feature('s1').feature('fc1').set('dtech', 'auto');
model.sol('sol2').feature('o1').feature('s1').feature('fc1').set('initstep', 0.01);
model.sol('sol2').feature('o1').feature('s1').feature('fc1').set('minstep', 1.0E-6);
model.sol('sol2').feature('o1').feature('s1').feature('fc1').set('maxiter', 50);
model.sol('sol2').feature('o1').feature('s1').feature.remove('fcDef');
model.sol('sol2').feature('o1').feature('s1').feature.remove('seDef');
model.sol('sol2').attach('std2');
model.sol('sol2').runAll;

model.result('pg3').run;
model.result('pg2').run;
model.result('pg4').run;
model.result.numerical('gev1').label('MSE, 6 obs.');
model.result.numerical('gev1').set('expr', {'MSE'});
model.result.numerical('gev1').set('descr', {'Area-weighted mean squared error'});
model.result.numerical('gev1').set('unit', {'1'});
model.result.table.create('tbl1', 'Table');
model.result.table('tbl1').comments('MSE, 6 obs.');
model.result.numerical('gev1').set('table', 'tbl1');
model.result.numerical('gev1').setResult;

model.sol('sol2').copySolution('sol3');

model.study('std2').feature('opt').setIndex('objectiveActive', true, 1);
model.study('std2').feature('opt').setIndex('objectiveActive', true, 2);
model.study('std2').feature('opt').setIndex('objectiveActive', true, 3);

model.result('pg5').run;
model.result.remove('pg5');
model.result('pg4').run;
model.result('pg4').set('data', 'dset5');
model.result.duplicate('pg5', 'pg4');
model.result('pg5').run;
model.result('pg5').label('log Ks, 24 Obs.');
model.result('pg5').set('data', 'dset3');
model.result.numerical('gev1').set('data', 'dset5');

model.study('std2').feature('opt').set('plotgroup', 'pg5');

model.mesh('mesh1').stat.selection.geom(2);
model.mesh('mesh1').stat.selection.set([1 2 3 4 5 6 7 8 9]);

model.sol('sol2').study('std2');
model.sol('sol2').feature.remove('o1');
model.sol('sol2').feature.remove('v1');
model.sol('sol2').feature.remove('st1');

model.study('std2').feature('opt').set('lsqmessage', {});

model.sol('sol2').create('st1', 'StudyStep');
model.sol('sol2').feature('st1').set('study', 'std2');
model.sol('sol2').feature('st1').set('studystep', 'stat');
model.sol('sol2').create('v1', 'Variables');
model.sol('sol2').feature('v1').set('control', 'stat');
model.sol('sol2').create('o1', 'Optimization');
model.sol('sol2').feature('o1').set('control', 'opt');
model.sol('sol2').feature('o1').create('s1', 'StationaryAttrib');
model.sol('sol2').feature('o1').feature('s1').set('control', 'stat');
model.sol('sol2').feature('o1').feature('s1').create('p1', 'Parametric');
model.sol('sol2').feature('o1').feature('s1').feature.remove('pDef');
model.sol('sol2').feature('o1').feature('s1').feature('p1').set('control', 'stat');
model.sol('sol2').feature('o1').feature('s1').set('control', 'stat');
model.sol('sol2').feature('o1').feature('s1').feature('p1').set('plistarrlsq', {'1.0, 2.0, 3.0, 4.0'});
model.sol('sol2').feature('o1').feature('s1').feature('p1').set('lsqparamsout', ['        th' newline '      1.00' newline '      2.00' newline '      3.00' newline '      4.00' newline ]);
model.sol('sol2').feature('o1').feature('s1').feature('p1').set('pnamelsq', {'th'});
model.sol('sol2').feature('v1').set('cname', {});
model.sol('sol2').feature('v1').set('clist', {});
model.sol('sol2').feature('v1').set('clistctrl', {});
model.sol('sol2').feature('v1').set('cname', {'th'});
model.sol('sol2').feature('v1').set('clist', {'1.0, 2.0, 3.0, 4.0'});
model.sol('sol2').feature('v1').set('clistctrl', {'p1lsq'});
model.sol('sol2').feature('o1').feature('s1').feature('aDef').set('cachepattern', true);
model.sol('sol2').feature('o1').feature('s1').create('seDef', 'Segregated');
model.sol('sol2').feature('o1').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol2').feature('o1').feature('s1').feature('fc1').set('dtech', 'auto');
model.sol('sol2').feature('o1').feature('s1').feature('fc1').set('initstep', 0.01);
model.sol('sol2').feature('o1').feature('s1').feature('fc1').set('minstep', 1.0E-6);
model.sol('sol2').feature('o1').feature('s1').feature('fc1').set('maxiter', 50);
model.sol('sol2').feature('o1').feature('s1').create('d1', 'Direct');
model.sol('sol2').feature('o1').feature('s1').feature('d1').set('linsolver', 'mumps');
model.sol('sol2').feature('o1').feature('s1').feature('d1').set('pivotperturb', 1.0E-13);
model.sol('sol2').feature('o1').feature('s1').feature('d1').label('Direct, pressure (dl) (Merged)');
model.sol('sol2').feature('o1').feature('s1').create('i1', 'Iterative');
model.sol('sol2').feature('o1').feature('s1').feature('i1').set('linsolver', 'gmres');
model.sol('sol2').feature('o1').feature('s1').feature('i1').set('prefuntype', 'left');
model.sol('sol2').feature('o1').feature('s1').feature('i1').set('itrestart', 50);
model.sol('sol2').feature('o1').feature('s1').feature('i1').set('rhob', 400);
model.sol('sol2').feature('o1').feature('s1').feature('i1').set('maxlinit', 1000);
model.sol('sol2').feature('o1').feature('s1').feature('i1').set('nlinnormuse', 'on');
model.sol('sol2').feature('o1').feature('s1').feature('i1').label('AMG, pressure (dl)');
model.sol('sol2').feature('o1').feature('s1').feature('i1').create('mg1', 'Multigrid');
model.sol('sol2').feature('o1').feature('s1').feature('i1').feature('mg1').set('prefun', 'saamg');
model.sol('sol2').feature('o1').feature('s1').feature('i1').feature('mg1').set('mgcycle', 'v');
model.sol('sol2').feature('o1').feature('s1').feature('i1').feature('mg1').set('maxcoarsedof', 50000);
model.sol('sol2').feature('o1').feature('s1').feature('i1').feature('mg1').set('strconn', 0.01);
model.sol('sol2').feature('o1').feature('s1').feature('i1').feature('mg1').set('nullspace', 'constant');
model.sol('sol2').feature('o1').feature('s1').feature('i1').feature('mg1').set('usesmooth', false);
model.sol('sol2').feature('o1').feature('s1').feature('i1').feature('mg1').set('saamgcompwise', false);
model.sol('sol2').feature('o1').feature('s1').feature('i1').feature('mg1').set('loweramg', true);
model.sol('sol2').feature('o1').feature('s1').feature('i1').feature('mg1').set('compactaggregation', false);
model.sol('sol2').feature('o1').feature('s1').feature('i1').feature('mg1').feature('pr').create('sl1', 'SORLine');
model.sol('sol2').feature('o1').feature('s1').feature('i1').feature('mg1').feature('pr').feature('sl1').set('linesweeptype', 'ssor');
model.sol('sol2').feature('o1').feature('s1').feature('i1').feature('mg1').feature('pr').feature('sl1').set('iter', 1);
model.sol('sol2').feature('o1').feature('s1').feature('i1').feature('mg1').feature('pr').feature('sl1').set('linerelax', 0.7);
model.sol('sol2').feature('o1').feature('s1').feature('i1').feature('mg1').feature('pr').feature('sl1').set('linealgorithm', 'mesh');
model.sol('sol2').feature('o1').feature('s1').feature('i1').feature('mg1').feature('pr').feature('sl1').set('linemethod', 'coupled');
model.sol('sol2').feature('o1').feature('s1').feature('i1').feature('mg1').feature('pr').feature('sl1').set('seconditer', 1);
model.sol('sol2').feature('o1').feature('s1').feature('i1').feature('mg1').feature('pr').feature('sl1').set('relax', 0.5);
model.sol('sol2').feature('o1').feature('s1').feature('i1').feature('mg1').feature('po').create('sl1', 'SORLine');
model.sol('sol2').feature('o1').feature('s1').feature('i1').feature('mg1').feature('po').feature('sl1').set('linesweeptype', 'ssor');
model.sol('sol2').feature('o1').feature('s1').feature('i1').feature('mg1').feature('po').feature('sl1').set('iter', 1);
model.sol('sol2').feature('o1').feature('s1').feature('i1').feature('mg1').feature('po').feature('sl1').set('linerelax', 0.7);
model.sol('sol2').feature('o1').feature('s1').feature('i1').feature('mg1').feature('po').feature('sl1').set('linealgorithm', 'mesh');
model.sol('sol2').feature('o1').feature('s1').feature('i1').feature('mg1').feature('po').feature('sl1').set('linemethod', 'coupled');
model.sol('sol2').feature('o1').feature('s1').feature('i1').feature('mg1').feature('po').feature('sl1').set('seconditer', 1);
model.sol('sol2').feature('o1').feature('s1').feature('i1').feature('mg1').feature('po').feature('sl1').set('relax', 0.5);
model.sol('sol2').feature('o1').feature('s1').feature('i1').feature('mg1').feature('cs').create('d1', 'Direct');
model.sol('sol2').feature('o1').feature('s1').feature('i1').feature('mg1').feature('cs').feature('d1').set('linsolver', 'pardiso');
model.sol('sol2').feature('o1').feature('s1').feature('i1').feature('mg1').feature('cs').feature('d1').set('pivotperturb', 1.0E-13);
model.sol('sol2').feature('o1').feature('s1').feature('fc1').set('linsolver', 'd1');
model.sol('sol2').feature('o1').feature('s1').feature('fc1').set('dtech', 'auto');
model.sol('sol2').feature('o1').feature('s1').feature('fc1').set('initstep', 0.01);
model.sol('sol2').feature('o1').feature('s1').feature('fc1').set('minstep', 1.0E-6);
model.sol('sol2').feature('o1').feature('s1').feature('fc1').set('maxiter', 50);
model.sol('sol2').feature('o1').feature('s1').feature.remove('fcDef');
model.sol('sol2').feature('o1').feature('s1').feature.remove('seDef');
model.sol('sol2').attach('std2');
model.sol('sol2').runAll;

model.result('pg3').run;
model.result('pg5').run;
model.result.numerical('gev2').label('MSE, 24 obs.');
model.result.numerical('gev2').set('expr', {'comp2.MSE'});
model.result.numerical('gev2').set('descr', {'Area-weighted mean squared error'});
model.result.numerical('gev2').set('unit', {'1'});
model.result.table.create('tbl2', 'Table');
model.result.table('tbl2').comments('MSE, 24 obs.');
model.result.numerical('gev2').set('table', 'tbl2');
model.result.numerical('gev2').setResult;

model.study('std1').feature('stat').set('useadvanceddisable', true);
model.study('std1').feature('stat').set('disabledvariables', {'var4'});

model.result('pg5').run;

model.title('Aquifer Characterization');

model.description('This example uses the Optimization interface to solve the inverse problem of determining the spatially variable hydraulic conductivity on a discretized quadratic grid from a number of aquifer pump tests. Because the number of observations is smaller than the number of unknown parameters, a geostatistical penalty term is used to discriminate between solutions with comparable fitness values. The measurement data is generated from a given forward model implemented using the Darcy''s Law interface, making it possible to analyze the efficiency and accuracy of the inverse method as well as the optimization solver''s performance.');

model.label('aquifer_characterization.mph');

model.modelNode.label('Components');

out = model;
