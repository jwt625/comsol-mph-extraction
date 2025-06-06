function out = model
%
% frozen_inclusion.m
%
% Model exported on May 26 2025, 21:32 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/Porous_Media_Flow_Module/Heat_Transfer');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 2);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.physics.create('dl', 'PorousMediaFlowDarcy', 'geom1');
model.physics('dl').model('comp1');
model.physics.create('ht', 'PorousMediaHeatTransfer', 'geom1');
model.physics('ht').model('comp1');

model.study.create('std1');
model.study('std1').create('stat', 'Stationary');
model.study('std1').feature('stat').setSolveFor('/physics/dl', true);
model.study('std1').feature('stat').setSolveFor('/physics/ht', true);

% To import content from file, use:
% model.param.loadFile('FILENAME');
model.param.set('T_initial_w', '5[degC]', 'Initial temperature for the thawed domain');
model.param.set('T_initial_i', '-5[degC]', 'Initial temperature for inclusion');
model.param.set('lambda_w', '0.6[W/(m*K)]', 'Thermal conductivity for water');
model.param.set('lambda_i', '2.14[W/(m*K)]', 'Thermal conductivity for ice');
model.param.set('lambda_s', '9[W/(m*K)]', 'Thermal conductivity for solid matrix');
model.param.set('Cw', '4182[J/(kg*K)]', 'Water heat capacity');
model.param.set('Ci', '2060[J/(kg*K)]', 'Ice heat capacity');
model.param.set('Cs', '835[J/(kg*K)]', 'Solid matrix heat capacity');
model.param.set('rho_w', '1000[kg/m^3]', 'Water density');
model.param.set('rho_i', '920[kg/m^3]', 'Ice density');
model.param.set('rho_s', '2650[kg/m^3]', 'Density of solid matrix');
model.param.set('L', '334[kJ/kg]', 'Latent heat');
model.param.set('epsilon_p', '0.37', 'Porosity');
model.param.set('beta', '1e-8[1/Pa]', 'Effective compressibility');
model.param.set('Sw_res', '0.05', 'Residual saturation in Sw(T)');
model.param.set('mu_w', '1.793e-3[Pa*s]', 'Water dynamic viscosity');
model.param.set('k_int', '1.3e-10[m^2]', 'Intrinsic permeability');
model.param.set('Omega', '50', 'Impedance factor');
model.param.set('T_pc', '-0.5[degC]', 'Phase change temperature');
model.param.set('delta_H_dLx', '3[%]', 'Hydraulic head gradient');

model.geom('geom1').create('r1', 'Rectangle');
model.geom('geom1').feature('r1').set('size', [3 0.5]);
model.geom('geom1').run('r1');
model.geom('geom1').create('r2', 'Rectangle');
model.geom('geom1').feature('r2').set('size', {'0.333' '0.333/2'});
model.geom('geom1').feature('r2').set('base', 'center');
model.geom('geom1').feature('r2').set('pos', {'1' '0.5-0.333/4'});
model.geom('geom1').run('fin');

model.material.create('mat1', 'Common', 'comp1');
model.material('mat1').label('Solid Matrix');
model.material.create('mat2', 'Common', 'comp1');
model.material('mat2').label('Water');
model.material.create('mat3', 'Common', 'comp1');
model.material('mat3').label('Ice');
model.material.create('pmat1', 'PorousMedia', 'comp1');
model.material('pmat1').selection.all;
model.material('pmat1').feature.create('fluid1', 'Fluid', 'comp1');
model.material('pmat1').feature.create('solid1', 'Solid', 'comp1');
model.material('pmat1').feature('fluid1').set('link', 'mat2');
model.material('pmat1').feature('solid1').set('link', 'mat1');
model.material('pmat1').feature('solid1').set('vfrac', '1-epsilon_p');
model.material('pmat1').feature.create('imfluid1', 'ImFluid', 'comp1');
model.material('pmat1').feature('imfluid1').set('link', 'mat2');
model.material('pmat1').feature('imfluid1').set('vfrac', 'epsilon_p*Sw_res');

model.physics('ht').prop('PhysicalModelProperty').set('Tref', 'T_initial_w');
model.physics('ht').feature('porous1').feature('pm1').set('porousMatrixPropertiesType', 'solidPhaseProperties');
model.physics('ht').feature('porous1').create('imf1', 'ImmobileFluidPorousMaterial', 2);
model.physics('ht').feature('porous1').feature('fluid1').set('minput_pressure_src', 'root.comp1.dl.pA');
model.physics('ht').feature('porous1').feature('fluid1').set('u_src', 'root.comp1.dl.u');
model.physics('ht').feature('porous1').feature('fluid1').create('phc1', 'PhaseChangeMaterial', 2);
model.physics('ht').feature('porous1').feature('fluid1').feature('phc1').set('PhaseTransitionFunction12', 'userdef');
model.physics('ht').feature('porous1').feature('fluid1').feature('phc1').set('alpha12', 'f_phtr(T)');
model.physics('ht').feature('porous1').feature('fluid1').feature('phc1').set('L_pc12', 'L');
model.physics('ht').feature('porous1').feature('fluid1').feature('phc1').set('MaterialPhase1', 'mat3');
model.physics('ht').feature('porous1').feature('fluid1').feature('phc1').set('MaterialPhase2', 'mat2');

model.param.set('W', '0.5[K]');
model.param.descr('W', 'Parameter for phase transition function');

model.func.create('an1', 'Analytic');
model.func('an1').model('comp1');
model.func('an1').set('funcname', 'f_phtr');
model.func('an1').set('expr', 'exp(-((T-273.15)/W)^2)*(T<273.15)+1*(T>=273.15)');
model.func('an1').set('args', 'T');
model.func('an1').setIndex('argunit', 'K', 0);
model.func('an1').setIndex('plotargs', 270, 0, 1);
model.func('an1').setIndex('plotargs', 275, 0, 2);

model.physics('ht').feature('init1').set('Tinit', 'T_initial_w');
model.physics('ht').create('init2', 'init', 2);
model.physics('ht').feature('init2').selection.set([2]);
model.physics('ht').feature('init2').set('Tinit', 'T_initial_i');
model.physics('ht').create('temp1', 'TemperatureBoundary', 1);
model.physics('ht').feature('temp1').selection.set([1]);
model.physics('ht').feature('temp1').set('T0', 'T_initial_w');
model.physics('ht').create('ofl1', 'ConvectiveOutflow', 1);
model.physics('ht').feature('ofl1').selection.set([9]);
model.physics('ht').create('sym1', 'Symmetry', 1);
model.physics('ht').feature('sym1').selection.set([3 6 8]);

model.variable.create('var1');
model.variable('var1').model('comp1');
model.variable('var1').set('Sw', 'Sw_res+(1-Sw_res)*f_phtr(T)');
model.variable('var1').descr('Sw', 'Water saturation');
model.variable('var1').set('kr', 'max(10^(-Omega*epsilon_p*(1-Sw)),1e-6)');
model.variable('var1').descr('kr', 'Relative permeability');
model.variable('var1').set('kappa_w', 'k_int*kr');
model.variable('var1').descr('kappa_w', 'Permeability');

model.physics('dl').prop('ShapeProperty').set('order_pressure', 1);
model.physics('dl').feature('porous1').set('storageModelType', 'userdef');
model.physics('dl').feature('porous1').set('Sp', 'Sw*epsilon_p*beta');
model.physics('dl').feature('porous1').feature('pm1').set('epsilon_mat', 'userdef');
model.physics('dl').feature('porous1').feature('pm1').set('epsilon', 'epsilon_p*Sw');
model.physics('dl').create('ms1', 'MassSource', 2);
model.physics('dl').feature('ms1').selection.all;
model.physics('dl').feature('ms1').set('Qm', 'dl.epsilon*(rho_i-rho_w)*d(Sw,t)');
model.physics('dl').create('inl1', 'Inlet', 1);
model.physics('dl').feature('inl1').set('BoundaryCondition', 'Pressure');
model.physics('dl').feature('inl1').selection.set([1]);
model.physics('dl').feature('inl1').set('p0', 'g_const*delta_H_dLx*3[m]*rho_w');
model.physics('dl').create('out1', 'Outlet', 1);
model.physics('dl').feature('out1').selection.set([9]);
model.physics('dl').feature('out1').set('BoundaryCondition', 'Pressure');
model.physics('dl').create('sym1', 'Symmetry', 1);
model.physics('dl').feature('sym1').selection.set([3 6 8]);

model.material('pmat1').propertyGroup('def').set('hydraulicpermeability', {'kappa_w'});
model.material('mat1').propertyGroup('def').set('density', {'rho_s'});
model.material('mat1').propertyGroup('def').set('thermalconductivity', {'lambda_s'});
model.material('mat1').propertyGroup('def').set('heatcapacity', {'Cs'});
model.material('mat2').propertyGroup('def').set('density', {'rho_w'});
model.material('mat2').propertyGroup('def').set('dynamicviscosity', {'mu_w'});
model.material('mat2').propertyGroup('def').set('thermalconductivity', {'lambda_w'});
model.material('mat2').propertyGroup('def').set('heatcapacity', {'Cw'});
model.material('mat3').propertyGroup('def').set('thermalconductivity', {'lambda_i'});
model.material('mat3').propertyGroup('def').set('density', {'rho_i'});
model.material('mat3').propertyGroup('def').set('heatcapacity', {'Ci'});

model.mesh('mesh1').create('ftri1', 'FreeTri');
model.mesh('mesh1').feature('ftri1').selection.geom('geom1', 2);
model.mesh('mesh1').feature('ftri1').selection.set([2]);
model.mesh('mesh1').feature('ftri1').create('size1', 'Size');
model.mesh('mesh1').feature('ftri1').feature('size1').set('custom', true);
model.mesh('mesh1').feature('ftri1').feature('size1').set('hmaxactive', true);
model.mesh('mesh1').feature('ftri1').feature('size1').set('hmax', 0.005);
model.mesh('mesh1').run('ftri1');
model.mesh('mesh1').create('ftri2', 'FreeTri');
model.mesh('mesh1').feature('size').set('hauto', 2);
model.mesh('mesh1').run;

model.study('std1').feature('stat').setEntry('activate', 'ht', false);

model.sol.create('sol1');

model.mesh('mesh1').stat.selection.geom(2);
model.mesh('mesh1').stat.selection.set([1 2]);

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
model.result('pg1').feature('str1').selection.set([1 2 3 4 5 6 7 8 9]);
model.result('pg1').run;

model.study('std1').create('time', 'Transient');
model.study('std1').feature('time').set('tunit', 'h');
model.study('std1').feature('time').set('tlist', 'range(0,5,60)[min] range(1.5,0.5,18) range(18.1,0.025,22) range(22.5,0.5,28) range(29,1,56)');
model.study('std1').feature('time').set('usertol', true);
model.study('std1').feature('time').set('rtol', 0.005);

model.mesh('mesh1').stat.selection.geom(2);
model.mesh('mesh1').stat.selection.set([1 2]);
model.mesh('mesh1').stat.selection.geom(2);
model.mesh('mesh1').stat.selection.set([1 2]);

model.sol('sol1').study('std1');

model.study('std1').feature('time').set('notsolnum', 'auto');
model.study('std1').feature('time').set('notsolvertype', 'solnum');
model.study('std1').feature('time').set('notsolnumhide', 'off');
model.study('std1').feature('time').set('notstudyhide', 'off');
model.study('std1').feature('time').set('notsolhide', 'on');
model.study('std1').feature('time').set('solnum', 'auto');
model.study('std1').feature('time').set('solvertype', 'solnum');
model.study('std1').feature('time').set('solnumhide', 'off');
model.study('std1').feature('time').set('initstudyhide', 'off');
model.study('std1').feature('time').set('initsolhide', 'on');

model.sol('sol1').feature.remove('s1');
model.sol('sol1').feature.remove('v1');
model.sol('sol1').feature.remove('st1');
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
model.sol('sol1').create('su1', 'StoreSolution');
model.sol('sol1').create('st2', 'StudyStep');
model.sol('sol1').feature('st2').set('study', 'std1');
model.sol('sol1').feature('st2').set('studystep', 'time');
model.sol('sol1').create('v2', 'Variables');
model.sol('sol1').feature('v2').set('initmethod', 'sol');
model.sol('sol1').feature('v2').set('initsol', 'sol1');
model.sol('sol1').feature('v2').set('initsoluse', 'sol2');
model.sol('sol1').feature('v2').set('notsolmethod', 'sol');
model.sol('sol1').feature('v2').set('notsol', 'sol1');
model.sol('sol1').feature('v2').set('control', 'time');
model.sol('sol1').create('t1', 'Time');
model.sol('sol1').feature('t1').set('tlist', 'range(0,5,60)[min] range(1.5,0.5,18) range(18.1,0.025,22) range(22.5,0.5,28) range(29,1,56)');
model.sol('sol1').feature('t1').set('plot', 'off');
model.sol('sol1').feature('t1').set('plotgroup', 'pg1');
model.sol('sol1').feature('t1').set('plotfreq', 'tout');
model.sol('sol1').feature('t1').set('probesel', 'all');
model.sol('sol1').feature('t1').set('probes', {});
model.sol('sol1').feature('t1').set('probefreq', 'tsteps');
model.sol('sol1').feature('t1').set('rtol', 0.005);
model.sol('sol1').feature('t1').set('atolglobalvaluemethod', 'factor');
model.sol('sol1').feature('t1').set('atolmethod', {'comp1_p' 'global' 'comp1_T' 'global'});
model.sol('sol1').feature('t1').set('atol', {'comp1_p' '1e-3' 'comp1_T' '1e-3'});
model.sol('sol1').feature('t1').set('atolvaluemethod', {'comp1_p' 'factor' 'comp1_T' 'factor'});
model.sol('sol1').feature('t1').set('reacf', true);
model.sol('sol1').feature('t1').set('storeudot', true);
model.sol('sol1').feature('t1').set('endtimeinterpolation', true);
model.sol('sol1').feature('t1').set('estrat', 'exclude');
model.sol('sol1').feature('t1').set('maxorder', 2);
model.sol('sol1').feature('t1').set('stabcntrl', true);
model.sol('sol1').feature('t1').set('control', 'time');
model.sol('sol1').feature('t1').feature('aDef').set('cachepattern', true);
model.sol('sol1').feature('t1').create('seDef', 'Segregated');
model.sol('sol1').feature('t1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('t1').feature('fc1').set('jtech', 'once');
model.sol('sol1').feature('t1').feature('fc1').set('maxiter', 8);
model.sol('sol1').feature('t1').feature('fc1').set('stabacc', 'aacc');
model.sol('sol1').feature('t1').feature('fc1').set('aaccdim', 5);
model.sol('sol1').feature('t1').feature('fc1').set('aaccmix', 0.9);
model.sol('sol1').feature('t1').feature('fc1').set('aaccdelay', 1);
model.sol('sol1').feature('t1').feature('fc1').set('damp', 0.9);
model.sol('sol1').feature('t1').create('d1', 'Direct');
model.sol('sol1').feature('t1').feature('d1').set('linsolver', 'pardiso');
model.sol('sol1').feature('t1').feature('d1').set('pivotperturb', 1.0E-13);
model.sol('sol1').feature('t1').feature('d1').label('Direct, pressure (dl) (Merged)');
model.sol('sol1').feature('t1').create('i1', 'Iterative');
model.sol('sol1').feature('t1').feature('i1').set('linsolver', 'gmres');
model.sol('sol1').feature('t1').feature('i1').set('prefuntype', 'left');
model.sol('sol1').feature('t1').feature('i1').set('itrestart', 50);
model.sol('sol1').feature('t1').feature('i1').set('rhob', 400);
model.sol('sol1').feature('t1').feature('i1').set('maxlinit', 50);
model.sol('sol1').feature('t1').feature('i1').set('nlinnormuse', 'on');
model.sol('sol1').feature('t1').feature('i1').label('AMG, pressure (dl)');
model.sol('sol1').feature('t1').feature('i1').create('mg1', 'Multigrid');
model.sol('sol1').feature('t1').feature('i1').feature('mg1').set('prefun', 'saamg');
model.sol('sol1').feature('t1').feature('i1').feature('mg1').set('mgcycle', 'v');
model.sol('sol1').feature('t1').feature('i1').feature('mg1').set('maxcoarsedof', 50000);
model.sol('sol1').feature('t1').feature('i1').feature('mg1').set('strconn', 0.01);
model.sol('sol1').feature('t1').feature('i1').feature('mg1').set('nullspace', 'constant');
model.sol('sol1').feature('t1').feature('i1').feature('mg1').set('usesmooth', false);
model.sol('sol1').feature('t1').feature('i1').feature('mg1').set('saamgcompwise', false);
model.sol('sol1').feature('t1').feature('i1').feature('mg1').set('loweramg', true);
model.sol('sol1').feature('t1').feature('i1').feature('mg1').set('compactaggregation', false);
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('pr').create('sl1', 'SORLine');
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('pr').feature('sl1').set('linesweeptype', 'ssor');
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('pr').feature('sl1').set('iter', 1);
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('pr').feature('sl1').set('linerelax', 0.7);
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('pr').feature('sl1').set('linealgorithm', 'mesh');
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('pr').feature('sl1').set('linemethod', 'coupled');
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('pr').feature('sl1').set('seconditer', 1);
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('pr').feature('sl1').set('relax', 0.5);
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('po').create('sl1', 'SORLine');
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('po').feature('sl1').set('linesweeptype', 'ssor');
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('po').feature('sl1').set('iter', 1);
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('po').feature('sl1').set('linerelax', 0.7);
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('po').feature('sl1').set('linealgorithm', 'mesh');
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('po').feature('sl1').set('linemethod', 'coupled');
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('po').feature('sl1').set('seconditer', 1);
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('po').feature('sl1').set('relax', 0.5);
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('cs').create('d1', 'Direct');
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('cs').feature('d1').set('linsolver', 'pardiso');
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('cs').feature('d1').set('pivotperturb', 1.0E-13);
model.sol('sol1').feature('t1').create('i2', 'Iterative');
model.sol('sol1').feature('t1').feature('i2').set('linsolver', 'gmres');
model.sol('sol1').feature('t1').feature('i2').set('prefuntype', 'left');
model.sol('sol1').feature('t1').feature('i2').set('itrestart', 50);
model.sol('sol1').feature('t1').feature('i2').set('rhob', 20);
model.sol('sol1').feature('t1').feature('i2').set('maxlinit', 10000);
model.sol('sol1').feature('t1').feature('i2').set('nlinnormuse', 'on');
model.sol('sol1').feature('t1').feature('i2').label('AMG, heat transfer variables (ht)');
model.sol('sol1').feature('t1').feature('i2').create('mg1', 'Multigrid');
model.sol('sol1').feature('t1').feature('i2').feature('mg1').set('prefun', 'saamg');
model.sol('sol1').feature('t1').feature('i2').feature('mg1').set('mgcycle', 'v');
model.sol('sol1').feature('t1').feature('i2').feature('mg1').set('maxcoarsedof', 50000);
model.sol('sol1').feature('t1').feature('i2').feature('mg1').set('strconn', 0.01);
model.sol('sol1').feature('t1').feature('i2').feature('mg1').set('nullspace', 'constant');
model.sol('sol1').feature('t1').feature('i2').feature('mg1').set('usesmooth', false);
model.sol('sol1').feature('t1').feature('i2').feature('mg1').set('saamgcompwise', true);
model.sol('sol1').feature('t1').feature('i2').feature('mg1').set('loweramg', true);
model.sol('sol1').feature('t1').feature('i2').feature('mg1').set('compactaggregation', false);
model.sol('sol1').feature('t1').feature('i2').feature('mg1').feature('pr').create('so1', 'SOR');
model.sol('sol1').feature('t1').feature('i2').feature('mg1').feature('pr').feature('so1').set('iter', 2);
model.sol('sol1').feature('t1').feature('i2').feature('mg1').feature('pr').feature('so1').set('relax', 0.9);
model.sol('sol1').feature('t1').feature('i2').feature('mg1').feature('po').create('so1', 'SOR');
model.sol('sol1').feature('t1').feature('i2').feature('mg1').feature('po').feature('so1').set('iter', 2);
model.sol('sol1').feature('t1').feature('i2').feature('mg1').feature('po').feature('so1').set('relax', 0.9);
model.sol('sol1').feature('t1').feature('i2').feature('mg1').feature('cs').create('d1', 'Direct');
model.sol('sol1').feature('t1').feature('i2').feature('mg1').feature('cs').feature('d1').set('linsolver', 'pardiso');
model.sol('sol1').feature('t1').feature('i2').feature('mg1').feature('cs').feature('d1').set('pivotperturb', 1.0E-13);
model.sol('sol1').feature('t1').feature('fc1').set('linsolver', 'd1');
model.sol('sol1').feature('t1').feature('fc1').set('jtech', 'once');
model.sol('sol1').feature('t1').feature('fc1').set('maxiter', 8);
model.sol('sol1').feature('t1').feature('fc1').set('stabacc', 'aacc');
model.sol('sol1').feature('t1').feature('fc1').set('aaccdim', 5);
model.sol('sol1').feature('t1').feature('fc1').set('aaccmix', 0.9);
model.sol('sol1').feature('t1').feature('fc1').set('aaccdelay', 1);
model.sol('sol1').feature('t1').feature('fc1').set('damp', 0.9);
model.sol('sol1').feature('t1').feature.remove('fcDef');
model.sol('sol1').feature('t1').feature.remove('seDef');
model.sol('sol1').attach('std1');
model.sol('sol1').feature('t1').set('tstepsbdf', 'strict');
model.sol('sol1').feature('t1').set('initialstepbdfactive', true);
model.sol('sol1').feature('t1').set('initialstepbdf', '1[s]');
model.sol('sol1').copySolution('sol2');
model.sol('sol1').runFromTo('st2', 't1');

model.result('pg1').run;
model.result.dataset.create('mir1', 'Mirror2D');
model.result.dataset('mir1').setIndex('genpoints', 0.5, 0, 1);
model.result.dataset('mir1').setIndex('genpoints', 3, 1, 0);
model.result.dataset('mir1').setIndex('genpoints', 0.5, 1, 1);
model.result.dataset('mir1').set('removesymelem', true);
model.result('pg1').run;
model.result('pg1').set('data', 'mir1');
model.result('pg1').setIndex('looplevel', 29, 0);
model.result('pg1').run;
model.result('pg1').feature('str1').set('posmethod', 'magnitude');
model.result('pg1').feature('str1').set('mdist', [0.02 0.1]);
model.result('pg1').run;
model.result.create('pg2', 'PlotGroup2D');
model.result('pg2').label('Temperature (ht)');
model.result('pg2').set('data', 'dset1');
model.result('pg2').setIndex('looplevel', 244, 0);
model.result('pg2').set('defaultPlotID', 'ht/HT_PhysicsInterfaces/icom8/pdef1/pcond2/pcond4/pg2');
model.result('pg2').feature.create('surf1', 'Surface');
model.result('pg2').feature('surf1').set('solutionparams', 'parent');
model.result('pg2').feature('surf1').set('expr', 'T');
model.result('pg2').feature('surf1').set('colortable', 'HeatCameraLight');
model.result('pg2').feature('surf1').set('showsolutionparams', 'on');
model.result('pg2').feature('surf1').set('data', 'parent');
model.result('pg2').label('Temperature (ht)');
model.result('pg2').run;
model.result('pg2').set('data', 'mir1');
model.result('pg2').setIndex('looplevel', 29, 0);
model.result('pg2').run;
model.result('pg2').feature('surf1').set('unit', 'degC');
model.result('pg2').run;
model.result.create('pg3', 'PlotGroup2D');
model.result('pg3').run;
model.result('pg3').label('Liquid Water Saturation');
model.result('pg3').set('data', 'mir1');
model.result('pg3').setIndex('looplevel', 29, 0);
model.result('pg3').create('con1', 'Contour');
model.result('pg3').feature('con1').set('expr', 'Sw');
model.result('pg3').feature('con1').set('levelmethod', 'levels');
model.result('pg3').feature('con1').set('levels', '0.05 0.5 1');
model.result('pg3').feature('con1').set('contourtype', 'filled');
model.result('pg3').feature('con1').set('colortable', 'JupiterAuroraBorealis');
model.result('pg3').feature('con1').set('colortabletrans', 'reverse');
model.result('pg3').run;
model.result.numerical.create('min1', 'MinSurface');
model.result.numerical('min1').selection.all;
model.result.numerical('min1').set('expr', {'T'});
model.result.numerical('min1').set('descr', {'Temperature'});
model.result.numerical('min1').set('unit', {'K'});
model.result.numerical('min1').setIndex('unit', 'degC', 0);
model.result.numerical('min1').setIndex('descr', 'Temperature', 0);
model.result.table.create('tbl1', 'Table');
model.result.table('tbl1').comments('Surface Minimum 1');
model.result.numerical('min1').set('table', 'tbl1');
model.result.numerical('min1').setResult;
model.result.create('pg4', 'PlotGroup1D');
model.result('pg4').set('data', 'none');
model.result('pg4').create('tblp1', 'Table');
model.result('pg4').feature('tblp1').set('source', 'table');
model.result('pg4').feature('tblp1').set('table', 'tbl1');
model.result('pg4').feature('tblp1').set('linewidth', 'preference');
model.result('pg4').feature('tblp1').set('markerpos', 'datapoints');
model.result('pg4').run;
model.result('pg4').run;
model.result('pg4').label('Minimum Temperature');
model.result.numerical.create('int1', 'IntLine');
model.result.numerical('int1').set('intsurface', true);
model.result.numerical('int1').selection.set([9]);
model.result.numerical('int1').set('expr', {'ht.ntflux'});
model.result.numerical('int1').set('descr', {'Normal total heat flux'});
model.result.numerical('int1').set('unit', {'W/m'});
model.result.numerical('int1').setIndex('expr', 'ht.ntflux*dl.d*2', 0);
model.result.numerical('int1').setIndex('unit', 'W', 0);
model.result.numerical('int1').setIndex('descr', 'Total Heat Flux', 0);
model.result.table.create('tbl2', 'Table');
model.result.table('tbl2').comments('Line Integration 1');
model.result.numerical('int1').set('table', 'tbl2');
model.result.numerical('int1').setResult;
model.result.create('pg5', 'PlotGroup1D');
model.result('pg5').set('data', 'none');
model.result('pg5').create('tblp1', 'Table');
model.result('pg5').feature('tblp1').set('source', 'table');
model.result('pg5').feature('tblp1').set('table', 'tbl2');
model.result('pg5').feature('tblp1').set('linewidth', 'preference');
model.result('pg5').feature('tblp1').set('markerpos', 'datapoints');
model.result('pg5').run;
model.result('pg5').run;
model.result('pg5').label('Total Heat Flux');
model.result.numerical.create('int2', 'IntSurface');
model.result.numerical('int2').set('intvolume', true);
model.result.numerical('int2').selection.all;
model.result.numerical('int2').set('expr', {});
model.result.numerical('int2').set('descr', {});
model.result.numerical('int2').setIndex('expr', 'Sw*epsilon_p*dl.d*2', 0);
model.result.numerical('int2').setIndex('unit', 'm^3', 0);
model.result.numerical('int2').setIndex('descr', 'Total liquid water volume', 0);
model.result.table.create('tbl3', 'Table');
model.result.table('tbl3').comments('Surface Integration 2');
model.result.numerical('int2').set('table', 'tbl3');
model.result.numerical('int2').setResult;
model.result.create('pg6', 'PlotGroup1D');
model.result('pg6').set('data', 'none');
model.result('pg6').create('tblp1', 'Table');
model.result('pg6').feature('tblp1').set('source', 'table');
model.result('pg6').feature('tblp1').set('table', 'tbl3');
model.result('pg6').feature('tblp1').set('linewidth', 'preference');
model.result('pg6').feature('tblp1').set('markerpos', 'datapoints');
model.result('pg6').run;
model.result('pg6').run;
model.result('pg6').label('Total Liquid Water Volume');

model.title('Frozen Inclusion');

model.description('This example is a benchmark problem for simulating phase change in porous media. It studies the melting process of an ice inclusion within porous media and therefore demonstrates how to couple Darcy''s Law with the Heat Transfer in Porous Media interface including phase change. It is one of the test cases from the INTERFROST project - an intercomparison project for coupled thermo-hydraulic systems with respect to climate change in permafrost regions.');

model.mesh.clearMeshes;

model.sol('sol1').clearSolutionData;
model.sol('sol2').clearSolutionData;

model.label('frozen_inclusion.mph');

model.modelNode.label('Components');

out = model;
