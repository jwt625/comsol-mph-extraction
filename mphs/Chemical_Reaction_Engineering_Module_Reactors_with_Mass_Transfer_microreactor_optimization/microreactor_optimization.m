function out = model
%
% microreactor_optimization.m
%
% Model exported on May 26 2025, 21:27 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/Chemical_Reaction_Engineering_Module/Reactors_with_Mass_Transfer');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 2);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.physics.create('spf', 'LaminarFlow', 'geom1');
model.physics('spf').model('comp1');
model.physics.create('tds', 'DilutedSpecies', 'geom1', {'c'});

model.study.create('std1');
model.study('std1').create('stat', 'Stationary');
model.study('std1').feature('stat').setSolveFor('/physics/spf', true);
model.study('std1').feature('stat').setSolveFor('/physics/tds', true);

% To import content from file, use:
% model.param.loadFile('FILENAME');
model.param.set('q', '0.04', 'Optimization parameter');
model.param.set('Da', '1e-4', 'Darcy number');
model.param.set('L', '1[mm]', 'Length scale');
model.param.set('c_in', '1[mol/m^3]', 'Concentration at inlet');
model.param.set('k_a', '0.25[1/s]', 'Reaction rate coefficient');
model.param.set('delta_p', '0.25[Pa]', 'Pressure drop');
model.param.set('vol', '3*L*6*L', 'Volume of the reacting domain');
model.param.set('D', '3e-8[m^2/s]', 'Diffusion coefficient');

model.geom('geom1').lengthUnit('mm');
model.geom('geom1').create('r1', 'Rectangle');
model.geom('geom1').feature('r1').set('size', {'2*L' 'L'});
model.geom('geom1').run('r1');
model.geom('geom1').create('r2', 'Rectangle');
model.geom('geom1').feature('r2').set('size', {'6*L' '3*L'});
model.geom('geom1').feature('r2').set('pos', {'2*L' '0'});
model.geom('geom1').feature('r2').set('selresult', true);
model.geom('geom1').run('r2');
model.geom('geom1').create('r3', 'Rectangle');
model.geom('geom1').feature('r3').set('size', {'2*L' 'L'});
model.geom('geom1').feature('r3').set('pos', {'8*L' '0'});
model.geom('geom1').run('r3');

model.common.create('dtopo1', 'DensityTopology', 'comp1');
model.common('dtopo1').selection.all;

model.geom('geom1').run;

model.common('dtopo1').selection.named('geom1_r2_dom');
model.common('dtopo1').set('filterType', 'No_filter');
model.common('dtopo1').set('interpolationType', 'Darcy');
model.common('dtopo1').set('q_Darcy', 'q');
model.common('dtopo1').set('theta_0', '1');

model.variable.create('var1');
model.variable('var1').model('comp1');
model.variable('var1').selection.geom('geom1', 2);
model.variable('var1').selection.set([2]);
model.variable('var1').set('phi', 'k_a*(1-dtopo1.theta)*c');
model.variable('var1').descr('phi', 'Local reaction rate');
model.variable('var1').set('alpha', '(mat1.def.eta(minput.T)/(Da*L^2))*dtopo1.theta_p');
model.variable('var1').descr('alpha', 'Drag-force coefficient');

model.probe.create('dom1', 'Domain');
model.probe('dom1').model('comp1');
model.probe('dom1').set('intsurface', true);
model.probe('dom1').set('intvolume', true);
model.probe('dom1').label('Objective Function');
model.probe('dom1').set('probename', 'obj');
model.probe('dom1').selection.named('geom1_r2_dom');
model.probe('dom1').set('expr', 'phi');
model.probe('dom1').set('descr', 'Local reaction rate');

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

model.physics('spf').create('vf1', 'VolumeForce', 2);
model.physics('spf').feature('vf1').selection.set([2]);
model.physics('spf').feature('vf1').set('F', {'-alpha*u' '-alpha*v' '0'});
model.physics('spf').create('inl1', 'InletBoundary', 1);
model.physics('spf').feature('inl1').selection.set([1]);
model.physics('spf').feature('inl1').set('BoundaryCondition', 'Pressure');
model.physics('spf').feature('inl1').set('p0', 'delta_p');
model.physics('spf').create('sym1', 'Symmetry', 1);
model.physics('spf').feature('sym1').selection.set([2 5 9]);
model.physics('spf').create('out1', 'OutletBoundary', 1);
model.physics('spf').feature('out1').selection.set([12]);
model.physics('tds').feature('cdm1').set('D_c', {'D' '0' '0' '0' 'D' '0' '0' '0' 'D'});
model.physics('tds').create('reac1', 'Reactions', 2);
model.physics('tds').feature('reac1').selection.set([2]);
model.physics('tds').feature('reac1').setIndex('R_c', '-phi', 0);
model.physics('tds').create('conc1', 'Concentration', 1);
model.physics('tds').feature('conc1').setIndex('species', true, 0);
model.physics('tds').feature('conc1').setIndex('c0', 'c_in', 0);
model.physics('tds').feature('conc1').selection.set([1]);
model.physics('tds').create('out1', 'Outflow', 1);
model.physics('tds').feature('out1').selection.set([12]);

model.multiphysics.create('rfd1', 'ReactingFlowDS', 'geom1', 2);

model.mesh('mesh1').automatic(false);
model.mesh('mesh1').feature('size').set('table', 'default');
model.mesh('mesh1').feature('size').set('hauto', 1);
model.mesh('mesh1').feature('size1').active(false);
model.mesh('mesh1').feature('cr1').active(false);
model.mesh('mesh1').feature('bl1').active(false);
model.mesh('mesh1').run;

model.sol.create('sol1');

model.mesh('mesh1').stat.selection.geom(2);
model.mesh('mesh1').stat.selection.set([1 2 3]);
model.mesh('mesh1').stat.selection.geom(2);
model.mesh('mesh1').stat.selection.set([1 2 3]);

model.sol('sol1').study('std1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'stat');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').set('control', 'stat');
model.sol('sol1').create('s1', 'Stationary');
model.sol('sol1').feature('s1').set('stol', 0.001);
model.sol('sol1').feature('s1').feature('aDef').set('cachepattern', true);
model.sol('sol1').feature('s1').create('seDef', 'Segregated');
model.sol('sol1').feature('s1').create('se1', 'Segregated');
model.sol('sol1').feature('s1').feature('se1').feature.remove('ssDef');
model.sol('sol1').feature('s1').feature('se1').create('ss1', 'SegregatedStep');
model.sol('sol1').feature('s1').feature('se1').feature('ss1').set('segvar', {'comp1_p' 'comp1_u' 'comp1_dtopo1_theta_c'});
model.sol('sol1').feature('s1').feature('se1').feature('ss1').set('subdamp', 0.5);
model.sol('sol1').feature('s1').create('d1', 'Direct');
model.sol('sol1').feature('s1').feature('d1').set('linsolver', 'pardiso');
model.sol('sol1').feature('s1').feature('d1').set('pivotperturb', 1.0E-13);
model.sol('sol1').feature('s1').feature('d1').label('Direct, fluid flow variables (spf)');
model.sol('sol1').feature('s1').feature('se1').feature('ss1').set('linsolver', 'd1');
model.sol('sol1').feature('s1').feature('se1').feature('ss1').label('Velocity u, Pressure p');
model.sol('sol1').feature('s1').feature('se1').create('ss2', 'SegregatedStep');
model.sol('sol1').feature('s1').feature('se1').feature('ss2').set('segvar', {'comp1_c' 'comp1_dtopo1_theta_c'});
model.sol('sol1').feature('s1').feature('se1').feature('ss2').set('subdamp', 0.35);
model.sol('sol1').feature('s1').feature('se1').feature('ss2').set('subtermconst', 'itertol');
model.sol('sol1').feature('s1').feature('se1').feature('ss2').set('subntolfact', 1);
model.sol('sol1').feature('s1').feature('se1').feature('ss2').set('subiter', 3);
model.sol('sol1').feature('s1').create('d2', 'Direct');
model.sol('sol1').feature('s1').feature('d2').set('linsolver', 'pardiso');
model.sol('sol1').feature('s1').feature('d2').set('pivotperturb', 1.0E-13);
model.sol('sol1').feature('s1').feature('d2').label('Direct, concentrations (tds)');
model.sol('sol1').feature('s1').feature('se1').feature('ss2').set('linsolver', 'd2');
model.sol('sol1').feature('s1').feature('se1').feature('ss2').label('Concentration c');
model.sol('sol1').feature('s1').feature('se1').set('segstabacc', 'segcflcmp');
model.sol('sol1').feature('s1').feature('se1').set('subinitcfl', 5);
model.sol('sol1').feature('s1').feature('se1').set('submincfl', 10000);
model.sol('sol1').feature('s1').feature('se1').set('subkppid', 0.65);
model.sol('sol1').feature('s1').feature('se1').set('subkdpid', 0.15);
model.sol('sol1').feature('s1').feature('se1').set('subkipid', 0.15);
model.sol('sol1').feature('s1').feature('se1').set('subcfltol', 0.1);
model.sol('sol1').feature('s1').feature('se1').set('segcflaa', true);
model.sol('sol1').feature('s1').feature('se1').set('segcflaacfl', 9000);
model.sol('sol1').feature('s1').feature('se1').set('segcflaafact', 1);
model.sol('sol1').feature('s1').feature('se1').set('maxsegiter', 200);
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
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('po').feature('sc1').set('scgssolv', 'stored');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('po').feature('sc1').set('approxscgs', true);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('po').feature('sc1').set('scgsdirectmaxsize', 1000);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('cs').create('d1', 'Direct');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('cs').feature('d1').set('linsolver', 'pardiso');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('cs').feature('d1').set('pivotperturb', 1.0E-13);
model.sol('sol1').feature('s1').create('i2', 'Iterative');
model.sol('sol1').feature('s1').feature('i2').set('linsolver', 'gmres');
model.sol('sol1').feature('s1').feature('i2').set('prefuntype', 'left');
model.sol('sol1').feature('s1').feature('i2').set('itrestart', 50);
model.sol('sol1').feature('s1').feature('i2').set('rhob', 400);
model.sol('sol1').feature('s1').feature('i2').set('maxlinit', 1000);
model.sol('sol1').feature('s1').feature('i2').set('nlinnormuse', 'on');
model.sol('sol1').feature('s1').feature('i2').label('AMG, concentrations (tds)');
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
model.sol('sol1').feature('s1').feature('i2').feature('mg1').feature('pr').create('sl1', 'SORLine');
model.sol('sol1').feature('s1').feature('i2').feature('mg1').feature('pr').feature('sl1').set('linesweeptype', 'ssor');
model.sol('sol1').feature('s1').feature('i2').feature('mg1').feature('pr').feature('sl1').set('iter', 1);
model.sol('sol1').feature('s1').feature('i2').feature('mg1').feature('pr').feature('sl1').set('linerelax', 0.7);
model.sol('sol1').feature('s1').feature('i2').feature('mg1').feature('pr').feature('sl1').set('linealgorithm', 'mesh');
model.sol('sol1').feature('s1').feature('i2').feature('mg1').feature('pr').feature('sl1').set('linemethod', 'coupled');
model.sol('sol1').feature('s1').feature('i2').feature('mg1').feature('pr').feature('sl1').set('seconditer', 1);
model.sol('sol1').feature('s1').feature('i2').feature('mg1').feature('pr').feature('sl1').set('relax', 0.5);
model.sol('sol1').feature('s1').feature('i2').feature('mg1').feature('po').create('sl1', 'SORLine');
model.sol('sol1').feature('s1').feature('i2').feature('mg1').feature('po').feature('sl1').set('linesweeptype', 'ssor');
model.sol('sol1').feature('s1').feature('i2').feature('mg1').feature('po').feature('sl1').set('iter', 1);
model.sol('sol1').feature('s1').feature('i2').feature('mg1').feature('po').feature('sl1').set('linerelax', 0.7);
model.sol('sol1').feature('s1').feature('i2').feature('mg1').feature('po').feature('sl1').set('linealgorithm', 'mesh');
model.sol('sol1').feature('s1').feature('i2').feature('mg1').feature('po').feature('sl1').set('linemethod', 'coupled');
model.sol('sol1').feature('s1').feature('i2').feature('mg1').feature('po').feature('sl1').set('seconditer', 1);
model.sol('sol1').feature('s1').feature('i2').feature('mg1').feature('po').feature('sl1').set('relax', 0.5);
model.sol('sol1').feature('s1').feature('i2').feature('mg1').feature('cs').create('d1', 'Direct');
model.sol('sol1').feature('s1').feature('i2').feature('mg1').feature('cs').feature('d1').set('linsolver', 'pardiso');
model.sol('sol1').feature('s1').feature('i2').feature('mg1').feature('cs').feature('d1').set('pivotperturb', 1.0E-13);
model.sol('sol1').feature('s1').feature.remove('fcDef');
model.sol('sol1').feature('s1').feature.remove('seDef');
model.sol('sol1').attach('std1');

model.probe('dom1').genResult('none');

model.sol('sol1').runAll;

model.result.dataset('dset1').set('geom', 'geom1');
model.result.create('pg2', 'PlotGroup2D');
model.result('pg2').label('Velocity (spf)');
model.result('pg2').set('frametype', 'spatial');
model.result('pg2').set('data', 'dset1');
model.result('pg2').set('defaultPlotID', 'ResultDefaults_SinglePhaseFlow/icom1/pdef1/pcond1/pg1');
model.result('pg2').feature.create('surf1', 'Surface');
model.result('pg2').feature('surf1').label('Surface');
model.result('pg2').feature('surf1').set('showsolutionparams', 'on');
model.result('pg2').feature('surf1').set('smooth', 'internal');
model.result('pg2').feature('surf1').set('showsolutionparams', 'on');
model.result('pg2').feature('surf1').set('data', 'parent');
model.result.create('pg3', 'PlotGroup2D');
model.result('pg3').label('Pressure (spf)');
model.result('pg3').set('frametype', 'spatial');
model.result('pg3').set('data', 'dset1');
model.result('pg3').set('defaultPlotID', 'ResultDefaults_SinglePhaseFlow/icom1/pdef1/pcond1/pg2');
model.result('pg3').feature.create('con1', 'Contour');
model.result('pg3').feature('con1').label('Contour');
model.result('pg3').feature('con1').set('showsolutionparams', 'on');
model.result('pg3').feature('con1').set('expr', 'p');
model.result('pg3').feature('con1').set('number', 40);
model.result('pg3').feature('con1').set('levelrounding', false);
model.result('pg3').feature('con1').set('smooth', 'internal');
model.result('pg3').feature('con1').set('showsolutionparams', 'on');
model.result('pg3').feature('con1').set('data', 'parent');
model.result.create('pg4', 'PlotGroup2D');
model.result('pg4').set('data', 'dset1');
model.result('pg4').label('Concentration (tds)');
model.result('pg4').set('titletype', 'custom');
model.result('pg4').set('prefixintitle', '');
model.result('pg4').set('expressionintitle', false);
model.result('pg4').set('typeintitle', true);
model.result('pg4').create('surf1', 'Surface');
model.result('pg4').feature('surf1').set('expr', {'c'});
model.result('pg4').create('str1', 'Streamline');
model.result('pg4').feature('str1').set('expr', {'tds.tflux_cx' 'tds.tflux_cy'});
model.result('pg4').feature('str1').set('posmethod', 'uniform');
model.result('pg4').feature('str1').set('recover', 'pprint');
model.result('pg4').feature('str1').set('pointtype', 'arrow');
model.result('pg4').feature('str1').set('arrowlength', 'logarithmic');
model.result('pg4').feature('str1').set('color', 'gray');

model.nodeGroup.create('grp1', 'Results');
model.nodeGroup('grp1').label('Topology Optimization');
model.nodeGroup('grp1').set('type', 'plotgroup');
model.nodeGroup('grp1').placeAfter('plotgroup', 'pg4');
model.nodeGroup.move('grp1', 1);

model.result.create('pg5', 'PlotGroup2D');
model.result('pg5').label('Output material volume factor');
model.result.create('pg6', 'PlotGroup2D');
model.result('pg6').label('Threshold');

model.nodeGroup('grp1').add('plotgroup', 'pg5');
model.nodeGroup('grp1').add('plotgroup', 'pg6');

model.result.dataset.create('filt1', 'Filter');
model.result.dataset('filt1').label('Filter');
model.result.dataset('filt1').set('data', 'dset1');
model.result.dataset('filt1').set('expr', 'dtopo1.theta');
model.result.dataset('filt1').set('lowerexpr', '0.5');
model.result.dataset('filt1').set('smooth', 'none');
model.result.dataset('filt1').set('useder', false);
model.result('pg5').set('data', 'dset1');
model.result('pg5').create('surf1', 'Surface');
model.result('pg5').feature('surf1').set('expr', 'dtopo1.theta');
model.result('pg5').feature('surf1').set('rangecoloractive', true);
model.result('pg5').feature('surf1').set('colortabletrans', 'reverse');
model.result('pg5').feature('surf1').set('rangecolormin', 0);
model.result('pg5').feature('surf1').set('rangecolormax', 1);
model.result('pg6').set('data', 'filt1');
model.result('pg6').create('surf1', 'Surface');
model.result('pg6').feature('surf1').set('expr', '1');
model.result('pg6').feature('surf1').set('coloring', 'uniform');
model.result('pg6').feature('surf1').set('color', 'gray');
model.result('pg6').feature('surf1').set('titletype', 'none');
model.result('pg2').run;

model.study('std1').create('topo', 'TopologyOptimization');
model.study('std1').feature('topo').set('mmamaxiter', 50);
model.study('std1').feature('topo').set('optobj', {'comp1.obj'});
model.study('std1').feature('topo').set('descr', {'Objective Function'});
model.study('std1').feature('topo').set('objectivetype', 'maximization');
model.study('std1').feature('topo').set('objectivescaling', 'manual');
model.study('std1').feature('topo').set('objscaleval', 0.1);
model.study('std1').feature('topo').set('plot', true);

model.mesh('mesh1').stat.selection.geom(2);
model.mesh('mesh1').stat.selection.set([1 2 3]);
model.mesh('mesh1').stat.selection.geom(2);
model.mesh('mesh1').stat.selection.set([1 2 3]);

model.sol('sol1').study('std1');
model.sol('sol1').feature.remove('s1');
model.sol('sol1').feature.remove('v1');
model.sol('sol1').feature.remove('st1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'stat');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').set('control', 'stat');
model.sol('sol1').create('o1', 'Optimization');
model.sol('sol1').feature('o1').set('control', 'topo');
model.sol('sol1').feature('o1').create('s1', 'StationaryAttrib');
model.sol('sol1').feature('o1').feature('s1').set('stol', 0.001);
model.sol('sol1').feature('o1').feature('s1').set('control', 'stat');
model.sol('sol1').feature('o1').feature('s1').feature('aDef').set('cachepattern', true);
model.sol('sol1').feature('o1').feature('s1').create('seDef', 'Segregated');
model.sol('sol1').feature('o1').feature('s1').create('se1', 'Segregated');
model.sol('sol1').feature('o1').feature('s1').feature('se1').feature.remove('ssDef');
model.sol('sol1').feature('o1').feature('s1').feature('se1').create('ss1', 'SegregatedStep');
model.sol('sol1').feature('o1').feature('s1').feature('se1').feature('ss1').set('segvar', {'comp1_p' 'comp1_u' 'comp1_dtopo1_theta_c'});
model.sol('sol1').feature('o1').feature('s1').feature('se1').feature('ss1').set('subdamp', 0.5);
model.sol('sol1').feature('o1').feature('s1').create('d1', 'Direct');
model.sol('sol1').feature('o1').feature('s1').feature('d1').set('linsolver', 'pardiso');
model.sol('sol1').feature('o1').feature('s1').feature('d1').set('pivotperturb', 1.0E-13);
model.sol('sol1').feature('o1').feature('s1').feature('d1').label('Direct, fluid flow variables (spf)');
model.sol('sol1').feature('o1').feature('s1').feature('se1').feature('ss1').set('linsolver', 'd1');
model.sol('sol1').feature('o1').feature('s1').feature('se1').feature('ss1').label('Velocity u, Pressure p');
model.sol('sol1').feature('o1').feature('s1').feature('se1').create('ss2', 'SegregatedStep');
model.sol('sol1').feature('o1').feature('s1').feature('se1').feature('ss2').set('segvar', {'comp1_c' 'comp1_dtopo1_theta_c'});
model.sol('sol1').feature('o1').feature('s1').feature('se1').feature('ss2').set('subdamp', 0.35);
model.sol('sol1').feature('o1').feature('s1').feature('se1').feature('ss2').set('subtermconst', 'itertol');
model.sol('sol1').feature('o1').feature('s1').feature('se1').feature('ss2').set('subntolfact', 1);
model.sol('sol1').feature('o1').feature('s1').feature('se1').feature('ss2').set('subiter', 3);
model.sol('sol1').feature('o1').feature('s1').create('d2', 'Direct');
model.sol('sol1').feature('o1').feature('s1').feature('d2').set('linsolver', 'pardiso');
model.sol('sol1').feature('o1').feature('s1').feature('d2').set('pivotperturb', 1.0E-13);
model.sol('sol1').feature('o1').feature('s1').feature('d2').label('Direct, concentrations (tds)');
model.sol('sol1').feature('o1').feature('s1').feature('se1').feature('ss2').set('linsolver', 'd2');
model.sol('sol1').feature('o1').feature('s1').feature('se1').feature('ss2').label('Concentration c');
model.sol('sol1').feature('o1').feature('s1').feature('se1').set('segstabacc', 'segcflcmp');
model.sol('sol1').feature('o1').feature('s1').feature('se1').set('subinitcfl', 5);
model.sol('sol1').feature('o1').feature('s1').feature('se1').set('submincfl', 10000);
model.sol('sol1').feature('o1').feature('s1').feature('se1').set('subkppid', 0.65);
model.sol('sol1').feature('o1').feature('s1').feature('se1').set('subkdpid', 0.15);
model.sol('sol1').feature('o1').feature('s1').feature('se1').set('subkipid', 0.15);
model.sol('sol1').feature('o1').feature('s1').feature('se1').set('subcfltol', 0.1);
model.sol('sol1').feature('o1').feature('s1').feature('se1').set('segcflaa', true);
model.sol('sol1').feature('o1').feature('s1').feature('se1').set('segcflaacfl', 9000);
model.sol('sol1').feature('o1').feature('s1').feature('se1').set('segcflaafact', 1);
model.sol('sol1').feature('o1').feature('s1').feature('se1').set('maxsegiter', 200);
model.sol('sol1').feature('o1').feature('s1').create('i1', 'Iterative');
model.sol('sol1').feature('o1').feature('s1').feature('i1').set('linsolver', 'gmres');
model.sol('sol1').feature('o1').feature('s1').feature('i1').set('prefuntype', 'left');
model.sol('sol1').feature('o1').feature('s1').feature('i1').set('itrestart', 50);
model.sol('sol1').feature('o1').feature('s1').feature('i1').set('rhob', 20);
model.sol('sol1').feature('o1').feature('s1').feature('i1').set('maxlinit', 1000);
model.sol('sol1').feature('o1').feature('s1').feature('i1').set('nlinnormuse', 'on');
model.sol('sol1').feature('o1').feature('s1').feature('i1').label('AMG, fluid flow variables (spf)');
model.sol('sol1').feature('o1').feature('s1').feature('i1').create('mg1', 'Multigrid');
model.sol('sol1').feature('o1').feature('s1').feature('i1').feature('mg1').set('prefun', 'saamg');
model.sol('sol1').feature('o1').feature('s1').feature('i1').feature('mg1').set('mgcycle', 'v');
model.sol('sol1').feature('o1').feature('s1').feature('i1').feature('mg1').set('maxcoarsedof', 80000);
model.sol('sol1').feature('o1').feature('s1').feature('i1').feature('mg1').set('strconn', 0.02);
model.sol('sol1').feature('o1').feature('s1').feature('i1').feature('mg1').set('nullspace', 'constant');
model.sol('sol1').feature('o1').feature('s1').feature('i1').feature('mg1').set('usesmooth', false);
model.sol('sol1').feature('o1').feature('s1').feature('i1').feature('mg1').set('saamgcompwise', true);
model.sol('sol1').feature('o1').feature('s1').feature('i1').feature('mg1').set('loweramg', true);
model.sol('sol1').feature('o1').feature('s1').feature('i1').feature('mg1').set('compactaggregation', false);
model.sol('sol1').feature('o1').feature('s1').feature('i1').feature('mg1').feature('pr').create('sc1', 'SCGS');
model.sol('sol1').feature('o1').feature('s1').feature('i1').feature('mg1').feature('pr').feature('sc1').set('linesweeptype', 'ssor');
model.sol('sol1').feature('o1').feature('s1').feature('i1').feature('mg1').feature('pr').feature('sc1').set('iter', 0);
model.sol('sol1').feature('o1').feature('s1').feature('i1').feature('mg1').feature('pr').feature('sc1').set('scgsrelax', 0.7);
model.sol('sol1').feature('o1').feature('s1').feature('i1').feature('mg1').feature('pr').feature('sc1').set('scgsmethod', 'lines');
model.sol('sol1').feature('o1').feature('s1').feature('i1').feature('mg1').feature('pr').feature('sc1').set('scgsvertexrelax', 0.7);
model.sol('sol1').feature('o1').feature('s1').feature('i1').feature('mg1').feature('pr').feature('sc1').set('relax', 0.5);
model.sol('sol1').feature('o1').feature('s1').feature('i1').feature('mg1').feature('pr').feature('sc1').set('scgssolv', 'stored');
model.sol('sol1').feature('o1').feature('s1').feature('i1').feature('mg1').feature('pr').feature('sc1').set('approxscgs', true);
model.sol('sol1').feature('o1').feature('s1').feature('i1').feature('mg1').feature('pr').feature('sc1').set('scgsdirectmaxsize', 1000);
model.sol('sol1').feature('o1').feature('s1').feature('i1').feature('mg1').feature('po').create('sc1', 'SCGS');
model.sol('sol1').feature('o1').feature('s1').feature('i1').feature('mg1').feature('po').feature('sc1').set('linesweeptype', 'ssor');
model.sol('sol1').feature('o1').feature('s1').feature('i1').feature('mg1').feature('po').feature('sc1').set('iter', 1);
model.sol('sol1').feature('o1').feature('s1').feature('i1').feature('mg1').feature('po').feature('sc1').set('scgsrelax', 0.7);
model.sol('sol1').feature('o1').feature('s1').feature('i1').feature('mg1').feature('po').feature('sc1').set('scgsmethod', 'lines');
model.sol('sol1').feature('o1').feature('s1').feature('i1').feature('mg1').feature('po').feature('sc1').set('scgsvertexrelax', 0.7);
model.sol('sol1').feature('o1').feature('s1').feature('i1').feature('mg1').feature('po').feature('sc1').set('relax', 0.5);
model.sol('sol1').feature('o1').feature('s1').feature('i1').feature('mg1').feature('po').feature('sc1').set('scgssolv', 'stored');
model.sol('sol1').feature('o1').feature('s1').feature('i1').feature('mg1').feature('po').feature('sc1').set('approxscgs', true);
model.sol('sol1').feature('o1').feature('s1').feature('i1').feature('mg1').feature('po').feature('sc1').set('scgsdirectmaxsize', 1000);
model.sol('sol1').feature('o1').feature('s1').feature('i1').feature('mg1').feature('cs').create('d1', 'Direct');
model.sol('sol1').feature('o1').feature('s1').feature('i1').feature('mg1').feature('cs').feature('d1').set('linsolver', 'pardiso');
model.sol('sol1').feature('o1').feature('s1').feature('i1').feature('mg1').feature('cs').feature('d1').set('pivotperturb', 1.0E-13);
model.sol('sol1').feature('o1').feature('s1').create('i2', 'Iterative');
model.sol('sol1').feature('o1').feature('s1').feature('i2').set('linsolver', 'gmres');
model.sol('sol1').feature('o1').feature('s1').feature('i2').set('prefuntype', 'left');
model.sol('sol1').feature('o1').feature('s1').feature('i2').set('itrestart', 50);
model.sol('sol1').feature('o1').feature('s1').feature('i2').set('rhob', 400);
model.sol('sol1').feature('o1').feature('s1').feature('i2').set('maxlinit', 1000);
model.sol('sol1').feature('o1').feature('s1').feature('i2').set('nlinnormuse', 'on');
model.sol('sol1').feature('o1').feature('s1').feature('i2').label('AMG, concentrations (tds)');
model.sol('sol1').feature('o1').feature('s1').feature('i2').create('mg1', 'Multigrid');
model.sol('sol1').feature('o1').feature('s1').feature('i2').feature('mg1').set('prefun', 'saamg');
model.sol('sol1').feature('o1').feature('s1').feature('i2').feature('mg1').set('mgcycle', 'v');
model.sol('sol1').feature('o1').feature('s1').feature('i2').feature('mg1').set('maxcoarsedof', 50000);
model.sol('sol1').feature('o1').feature('s1').feature('i2').feature('mg1').set('strconn', 0.01);
model.sol('sol1').feature('o1').feature('s1').feature('i2').feature('mg1').set('nullspace', 'constant');
model.sol('sol1').feature('o1').feature('s1').feature('i2').feature('mg1').set('usesmooth', false);
model.sol('sol1').feature('o1').feature('s1').feature('i2').feature('mg1').set('saamgcompwise', true);
model.sol('sol1').feature('o1').feature('s1').feature('i2').feature('mg1').set('loweramg', true);
model.sol('sol1').feature('o1').feature('s1').feature('i2').feature('mg1').set('compactaggregation', false);
model.sol('sol1').feature('o1').feature('s1').feature('i2').feature('mg1').feature('pr').create('sl1', 'SORLine');
model.sol('sol1').feature('o1').feature('s1').feature('i2').feature('mg1').feature('pr').feature('sl1').set('linesweeptype', 'ssor');
model.sol('sol1').feature('o1').feature('s1').feature('i2').feature('mg1').feature('pr').feature('sl1').set('iter', 1);
model.sol('sol1').feature('o1').feature('s1').feature('i2').feature('mg1').feature('pr').feature('sl1').set('linerelax', 0.7);
model.sol('sol1').feature('o1').feature('s1').feature('i2').feature('mg1').feature('pr').feature('sl1').set('linealgorithm', 'mesh');
model.sol('sol1').feature('o1').feature('s1').feature('i2').feature('mg1').feature('pr').feature('sl1').set('linemethod', 'coupled');
model.sol('sol1').feature('o1').feature('s1').feature('i2').feature('mg1').feature('pr').feature('sl1').set('seconditer', 1);
model.sol('sol1').feature('o1').feature('s1').feature('i2').feature('mg1').feature('pr').feature('sl1').set('relax', 0.5);
model.sol('sol1').feature('o1').feature('s1').feature('i2').feature('mg1').feature('po').create('sl1', 'SORLine');
model.sol('sol1').feature('o1').feature('s1').feature('i2').feature('mg1').feature('po').feature('sl1').set('linesweeptype', 'ssor');
model.sol('sol1').feature('o1').feature('s1').feature('i2').feature('mg1').feature('po').feature('sl1').set('iter', 1);
model.sol('sol1').feature('o1').feature('s1').feature('i2').feature('mg1').feature('po').feature('sl1').set('linerelax', 0.7);
model.sol('sol1').feature('o1').feature('s1').feature('i2').feature('mg1').feature('po').feature('sl1').set('linealgorithm', 'mesh');
model.sol('sol1').feature('o1').feature('s1').feature('i2').feature('mg1').feature('po').feature('sl1').set('linemethod', 'coupled');
model.sol('sol1').feature('o1').feature('s1').feature('i2').feature('mg1').feature('po').feature('sl1').set('seconditer', 1);
model.sol('sol1').feature('o1').feature('s1').feature('i2').feature('mg1').feature('po').feature('sl1').set('relax', 0.5);
model.sol('sol1').feature('o1').feature('s1').feature('i2').feature('mg1').feature('cs').create('d1', 'Direct');
model.sol('sol1').feature('o1').feature('s1').feature('i2').feature('mg1').feature('cs').feature('d1').set('linsolver', 'pardiso');
model.sol('sol1').feature('o1').feature('s1').feature('i2').feature('mg1').feature('cs').feature('d1').set('pivotperturb', 1.0E-13);
model.sol('sol1').feature('o1').feature('s1').feature.remove('fcDef');
model.sol('sol1').feature('o1').feature('s1').feature.remove('seDef');
model.sol('sol1').attach('std1');
model.sol('sol1').feature('o1').set('gcmma', false);
model.sol('sol1').feature('o1').set('nojacmethod', false);

model.study('std1').feature('topo').set('plotgroup', 'pg4');

model.probe('dom1').genResult('none');

model.sol('sol1').runAll;

model.result('pg2').run;

model.study('std1').feature('topo').set('probewindow', '');

model.result('pg4').run;
model.result('pg4').set('edges', false);
model.result('pg4').set('showlegendsunit', true);
model.result('pg4').run;
model.result('pg4').feature('surf1').set('colortable', 'Prism');
model.result('pg4').run;
model.result('pg4').feature('str1').set('posmethod', 'selection');
model.result('pg4').feature('str1').selection.set([8]);
model.result('pg4').feature('str1').set('selnumber', 3);
model.result('pg4').feature('str1').set('arrowdistr', 'equalinvtime');
model.result('pg4').feature('str1').set('arrowcountactive', true);
model.result('pg4').feature('str1').set('arrowcount', 10);
model.result('pg4').feature('str1').set('arrowtype', 'cone');
model.result('pg4').feature('str1').set('arrowscaleactive', true);
model.result('pg4').feature('str1').set('arrowscale', 200);
model.result('pg4').run;
model.result('pg5').run;
model.result('pg5').label('Distribution of porous catalyst');
model.result('pg5').set('titletype', 'manual');
model.result('pg5').set('title', 'Distribution of porous catalyst');
model.result('pg5').run;
model.result('pg5').feature('surf1').set('colortable', 'GrayScale');
model.result('pg5').feature('surf1').set('colorlegend', false);
model.result('pg5').feature('surf1').set('colortabletrans', 'none');
model.result('pg5').run;
model.result.numerical.create('gev1', 'EvalGlobal');
model.result.numerical('gev1').set('expr', {'opt.obj1'});
model.result.numerical('gev1').set('descr', {'Objective Function'});
model.result.table.create('tbl3', 'Table');
model.result.table('tbl3').comments('Global Evaluation 1');
model.result.numerical('gev1').set('table', 'tbl3');
model.result.numerical('gev1').setResult;
model.result('pg6').run;
model.result('pg6').label('Local Reaction Rate');

model.title('Optimization of a Catalytic Microreactor');

model.description(['A solution is pumped through a catalytic bed where a solute species reacts as it gets in contact with the catalyst. For a given total pressure difference across the bed, this model finds the optimal catalyst distribution to maximize the total reaction rate of the solute.' newline  newline 'The model requires the Optimization Module.']);

model.label('microreactor_optimization.mph');

model.modelNode.label('Components');

out = model;
