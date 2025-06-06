function out = model
%
% electroosmotic_flow.m
%
% Model exported on May 26 2025, 21:27 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/Chemical_Reaction_Engineering_Module/Electrokinetic_Effects');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 2);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.physics.create('ec', 'ConductiveMedia', 'geom1');
model.physics('ec').model('comp1');
model.physics.create('g', 'GeneralFormPDE', 'geom1', {'u'});
model.physics('g').prop('EquationForm').set('form', 'Automatic');
model.physics.create('tds', 'DilutedSpecies', 'geom1', {'c'});

model.study.create('std1');
model.study('std1').create('stat', 'Stationary');
model.study('std1').feature('stat').setSolveFor('/physics/ec', true);
model.study('std1').feature('stat').setSolveFor('/physics/g', true);
model.study('std1').feature('stat').setSolveFor('/physics/tds', true);

% To import content from file, use:
% model.param.loadFile('FILENAME');
model.param.set('T', '298[K]', 'Temperature');
model.param.set('eps_p', '0.6', 'Porosity');
model.param.set('a', '10[um]', 'Average pore radius');
model.param.set('kappa0', '3.5e-4[S/m]', 'Electrolyte conductivity');
model.param.set('V_anode', '50[V]', 'Anode potential');
model.param.set('eps_w', '80.2*epsilon0_const', 'Electric permittivity');
model.param.set('eta', '1e-3[Pa*s]', 'Dynamic viscosity');
model.param.set('zeta', '-0.1[V]', 'Zeta potential');
model.param.set('p1', '0.01*1.013e5[Pa]', 'Inlet pressure');
model.param.set('k_p', 'eps_p*a^2/(8*eta)', 'Prefactor, flow-velocity pressure term');
model.param.set('k_V', 'eps_p*eps_w*zeta/eta', 'Prefactor, flow-velocity electroosmotic term');
model.param.set('D', '1e-9[m^2/s]', 'Tracer diffusion coefficient');
model.param.set('zn', '1', 'Tracer ion charge number');
model.param.set('ctop', '1[mmol/m^3]', 'Tracer top initial concentration');
model.param.set('p_w', '0.2[mm]', 'Tracer concentration-profile peak width');
model.param.set('x_m', '3[mm]', 'Tracer concentration-profile peak position within geometry');

model.variable.create('var1');
model.variable('var1').model('comp1');

model.geom('geom1').run;

% To import content from file, use:
% model.variable('var1').loadFile('FILENAME');
model.variable('var1').set('u_p', '-k_p*px', 'Velocity pressure term, x-component');
model.variable('var1').set('v_p', '-k_p*py', 'Velocity pressure term, y-component');
model.variable('var1').set('U_p', 'sqrt(u_p^2+v_p^2)', 'Velocity pressure term, magnitude');
model.variable('var1').set('u_eo', 'k_V*Vx', 'Velocity electroosmotic term, x-component');
model.variable('var1').set('v_eo', 'k_V*Vy', 'Velocity electroosmotic term, y-component');
model.variable('var1').set('U_eo', 'sqrt(u_eo^2+v_eo^2)', 'Flow-velocity electroosmosis term, magnitude');
model.variable('var1').set('u_flow', 'u_p+u_eo', 'Velocity, x-component');
model.variable('var1').set('v_flow', 'v_p+v_eo', 'Velocity, y-component');
model.variable('var1').set('U_flow', 'sqrt(u_flow^2+v_flow^2)', 'Velocity, magnitude');
model.variable('var1').set('c_init', 'ctop*exp(-0.5*((x-x_m)/p_w)^2)', 'Initial concentration distribution');

model.geom('geom1').lengthUnit('mm');
model.geom('geom1').create('r1', 'Rectangle');
model.geom('geom1').feature('r1').set('size', [8 3]);
model.geom('geom1').feature('r1').set('pos', [-4 0]);
model.geom('geom1').run('r1');
model.geom('geom1').create('r2', 'Rectangle');
model.geom('geom1').feature('r2').set('size', [0.2 1.5]);
model.geom('geom1').feature('r2').set('pos', [-2 0]);
model.geom('geom1').run('r2');
model.geom('geom1').create('c1', 'Circle');
model.geom('geom1').feature('c1').set('r', 0.1);
model.geom('geom1').feature('c1').set('pos', [-1.9 1.5]);
model.geom('geom1').run('c1');
model.geom('geom1').create('uni1', 'Union');
model.geom('geom1').feature('uni1').selection('input').set({'c1' 'r2'});
model.geom('geom1').feature('uni1').set('intbnd', false);
model.geom('geom1').run('uni1');
model.geom('geom1').create('copy1', 'Copy');
model.geom('geom1').feature('copy1').selection('input').set({'uni1'});
model.geom('geom1').feature('copy1').set('displx', 3.8);
model.geom('geom1').run('copy1');
model.geom('geom1').create('dif1', 'Difference');
model.geom('geom1').feature('dif1').selection('input').set({'r1'});
model.geom('geom1').feature('dif1').selection('input2').set({'copy1' 'uni1'});
model.geom('geom1').runPre('fin');
model.geom('geom1').create('sel1', 'ExplicitSelection');
model.geom('geom1').feature('sel1').label('Cathode');
model.geom('geom1').feature('sel1').selection('selection').init(1);
model.geom('geom1').feature('sel1').selection('selection').set('dif1', [4 5 11 12]);
model.geom('geom1').run('sel1');
model.geom('geom1').create('sel2', 'ExplicitSelection');
model.geom('geom1').feature('sel2').label('Anode');
model.geom('geom1').feature('sel2').selection('selection').init(1);
model.geom('geom1').feature('sel2').selection('selection').set('dif1', [7 8 13 14]);
model.geom('geom1').run('sel2');
model.geom('geom1').create('sel3', 'ExplicitSelection');
model.geom('geom1').feature('sel3').label('Inlet');
model.geom('geom1').feature('sel3').selection('selection').init(1);
model.geom('geom1').feature('sel3').selection('selection').set('dif1', 1);
model.geom('geom1').run('sel3');
model.geom('geom1').create('sel4', 'ExplicitSelection');
model.geom('geom1').feature('sel4').label('Outlet');
model.geom('geom1').feature('sel4').selection('selection').init(1);
model.geom('geom1').feature('sel4').selection('selection').set('dif1', 10);
model.geom('geom1').run;

model.physics('ec').feature('cucn1').set('sigma_mat', 'userdef');
model.physics('ec').feature('cucn1').set('sigma', {'kappa0' '0' '0' '0' 'kappa0' '0' '0' '0' 'kappa0'});
model.physics('ec').feature('cucn1').set('epsilonr_mat', 'userdef');
model.physics('ec').create('pot1', 'ElectricPotential', 1);
model.physics('ec').feature('pot1').selection.named('geom1_sel1');
model.physics('ec').create('pot2', 'ElectricPotential', 1);
model.physics('ec').feature('pot2').selection.named('geom1_sel2');
model.physics('ec').feature('pot2').set('V0', 'V_anode');
model.physics('g').label('Electroosmotic Pressure');
model.physics('g').prop('Units').set('DependentVariableQuantity', 'pressure');
model.physics('g').prop('Units').setIndex('CustomSourceTermUnit', '1/s', 0, 0);
model.physics('g').field('dimensionless').field('p');
model.physics('g').field('dimensionless').component(1, 'p');
model.physics('g').feature('gfeq1').setIndex('Ga', {'u_flow' '-uy'}, 0);
model.physics('g').feature('gfeq1').setIndex('Ga', {'u_flow' 'v_flow'}, 0);
model.physics('g').feature('gfeq1').setIndex('f', 0, 0);
model.physics('g').feature('gfeq1').setIndex('da', 0, 0);
model.physics('g').create('dir1', 'DirichletBoundary', 1);
model.physics('g').feature('dir1').label('Inlet - p=0');
model.physics('g').feature('dir1').selection.named('geom1_sel3');
model.physics('g').create('dir2', 'DirichletBoundary', 1);
model.physics('g').feature('dir2').label('Outlet - p=p1');
model.physics('g').feature('dir2').selection.named('geom1_sel4');
model.physics('g').feature('dir2').setIndex('r', 'p1', 0);
model.physics('tds').prop('TransportMechanism').set('Migration', true);
model.physics('tds').feature('sp1').setIndex('z', 'zn', 0);
model.physics('tds').feature('cdm1').set('minput_temperature_src', 'userdef');
model.physics('tds').feature('cdm1').set('minput_temperature', 'T');
model.physics('tds').feature('cdm1').set('D_c', {'D' '0' '0' '0' 'D' '0' '0' '0' 'D'});
model.physics('tds').feature('cdm1').set('u', {'u_flow' 'v_flow' '0'});
model.physics('tds').feature('cdm1').set('V_src', 'root.comp1.V');
model.physics('tds').feature('init1').setIndex('initc', 'c_init', 0);
model.physics('tds').create('fl1', 'FluxBoundary', 1);
model.physics('tds').feature('fl1').selection.set([1 10]);
model.physics('tds').feature('fl1').setIndex('species', true, 0);
model.physics('tds').feature('fl1').setIndex('J0', '-tds.nmflux_c', 0);

model.mesh('mesh1').autoMeshSize(1);

model.study('std1').feature('stat').setEntry('activate', 'tds', false);
model.study('std1').create('time', 'Transient');
model.study('std1').feature('time').set('tlist', 'range(0,0.1,2)');
model.study('std1').feature('time').set('usertol', true);
model.study('std1').feature('time').set('rtol', 0.005);
model.study('std1').feature('time').setEntry('activate', 'ec', false);
model.study('std1').feature('time').setEntry('activate', 'g', false);

model.sol.create('sol1');

model.mesh('mesh1').stat.selection.geom(2);
model.mesh('mesh1').stat.selection.set([1]);

model.sol('sol1').study('std1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'stat');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').set('control', 'stat');
model.sol('sol1').create('s1', 'Stationary');
model.sol('sol1').feature('s1').create('seDef', 'Segregated');
model.sol('sol1').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('s1').feature('fc1').set('linsolver', 'dDef');
model.sol('sol1').feature('s1').feature.remove('fcDef');
model.sol('sol1').feature('s1').feature.remove('seDef');
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
model.sol('sol1').feature('v2').set('notsoluse', 'sol2');
model.sol('sol1').feature('v2').set('control', 'time');
model.sol('sol1').create('t1', 'Time');
model.sol('sol1').feature('t1').set('tlist', 'range(0,0.1,2)');
model.sol('sol1').feature('t1').set('plot', 'off');
model.sol('sol1').feature('t1').set('plotgroup', 'Default');
model.sol('sol1').feature('t1').set('plotfreq', 'tout');
model.sol('sol1').feature('t1').set('probesel', 'all');
model.sol('sol1').feature('t1').set('probes', {});
model.sol('sol1').feature('t1').set('probefreq', 'tsteps');
model.sol('sol1').feature('t1').set('rtol', 0.005);
model.sol('sol1').feature('t1').set('atolglobalvaluemethod', 'factor');
model.sol('sol1').feature('t1').set('reacf', true);
model.sol('sol1').feature('t1').set('storeudot', true);
model.sol('sol1').feature('t1').set('endtimeinterpolation', true);
model.sol('sol1').feature('t1').set('maxorder', 2);
model.sol('sol1').feature('t1').set('stabcntrl', true);
model.sol('sol1').feature('t1').set('control', 'time');
model.sol('sol1').feature('t1').feature('aDef').set('cachepattern', true);
model.sol('sol1').feature('t1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('t1').feature('fc1').set('jtech', 'once');
model.sol('sol1').feature('t1').feature('fc1').set('damp', 0.9);
model.sol('sol1').feature('t1').feature('fc1').set('maxiter', 8);
model.sol('sol1').feature('t1').feature('fc1').set('stabacc', 'aacc');
model.sol('sol1').feature('t1').feature('fc1').set('aaccdim', 5);
model.sol('sol1').feature('t1').feature('fc1').set('aaccmix', 0.9);
model.sol('sol1').feature('t1').feature('fc1').set('aaccdelay', 1);
model.sol('sol1').feature('t1').create('d1', 'Direct');
model.sol('sol1').feature('t1').feature('d1').set('linsolver', 'pardiso');
model.sol('sol1').feature('t1').feature('d1').set('pivotperturb', 1.0E-13);
model.sol('sol1').feature('t1').feature('d1').label('Direct, concentrations (tds)');
model.sol('sol1').feature('t1').create('i1', 'Iterative');
model.sol('sol1').feature('t1').feature('i1').set('linsolver', 'gmres');
model.sol('sol1').feature('t1').feature('i1').set('prefuntype', 'left');
model.sol('sol1').feature('t1').feature('i1').set('itrestart', 50);
model.sol('sol1').feature('t1').feature('i1').set('rhob', 400);
model.sol('sol1').feature('t1').feature('i1').set('maxlinit', 50);
model.sol('sol1').feature('t1').feature('i1').set('nlinnormuse', 'on');
model.sol('sol1').feature('t1').feature('i1').label('AMG, concentrations (tds)');
model.sol('sol1').feature('t1').feature('i1').create('mg1', 'Multigrid');
model.sol('sol1').feature('t1').feature('i1').feature('mg1').set('prefun', 'saamg');
model.sol('sol1').feature('t1').feature('i1').feature('mg1').set('mgcycle', 'v');
model.sol('sol1').feature('t1').feature('i1').feature('mg1').set('maxcoarsedof', 50000);
model.sol('sol1').feature('t1').feature('i1').feature('mg1').set('strconn', 0.01);
model.sol('sol1').feature('t1').feature('i1').feature('mg1').set('nullspace', 'constant');
model.sol('sol1').feature('t1').feature('i1').feature('mg1').set('usesmooth', false);
model.sol('sol1').feature('t1').feature('i1').feature('mg1').set('saamgcompwise', true);
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
model.sol('sol1').feature('t1').feature('fc1').set('linsolver', 'd1');
model.sol('sol1').feature('t1').feature('fc1').set('jtech', 'once');
model.sol('sol1').feature('t1').feature('fc1').set('damp', 0.9);
model.sol('sol1').feature('t1').feature('fc1').set('maxiter', 8);
model.sol('sol1').feature('t1').feature('fc1').set('stabacc', 'aacc');
model.sol('sol1').feature('t1').feature('fc1').set('aaccdim', 5);
model.sol('sol1').feature('t1').feature('fc1').set('aaccmix', 0.9);
model.sol('sol1').feature('t1').feature('fc1').set('aaccdelay', 1);
model.sol('sol1').feature('t1').feature.remove('fcDef');
model.sol('sol1').attach('std1');
model.sol('sol1').runAll;

model.result.create('pg1', 'PlotGroup2D');
model.result('pg1').label('Electric Potential (ec)');
model.result('pg1').set('frametype', 'spatial');
model.result('pg1').set('showlegendsmaxmin', true);
model.result('pg1').set('data', 'dset1');
model.result('pg1').setIndex('looplevel', 21, 0);
model.result('pg1').set('defaultPlotID', 'InterfaceComponents/PlotDefaults/icom2/pdef1/pcond2/pcond2/pg1');
model.result('pg1').feature.create('surf1', 'Surface');
model.result('pg1').feature('surf1').set('showsolutionparams', 'on');
model.result('pg1').feature('surf1').set('solutionparams', 'parent');
model.result('pg1').feature('surf1').set('colortable', 'Dipole');
model.result('pg1').feature('surf1').set('showsolutionparams', 'on');
model.result('pg1').feature('surf1').set('data', 'parent');
model.result('pg1').feature.create('str1', 'Streamline');
model.result('pg1').feature('str1').set('showsolutionparams', 'on');
model.result('pg1').feature('str1').set('solutionparams', 'parent');
model.result('pg1').feature('str1').set('expr', {'ec.Ex' 'ec.Ey'});
model.result('pg1').feature('str1').set('titletype', 'none');
model.result('pg1').feature('str1').set('posmethod', 'uniform');
model.result('pg1').feature('str1').set('udist', 0.02);
model.result('pg1').feature('str1').set('maxlen', 0.4);
model.result('pg1').feature('str1').set('maxtime', Inf);
model.result('pg1').feature('str1').set('inheritcolor', false);
model.result('pg1').feature('str1').set('showsolutionparams', 'on');
model.result('pg1').feature('str1').set('maxtime', Inf);
model.result('pg1').feature('str1').set('showsolutionparams', 'on');
model.result('pg1').feature('str1').set('maxtime', Inf);
model.result('pg1').feature('str1').set('showsolutionparams', 'on');
model.result('pg1').feature('str1').set('maxtime', Inf);
model.result('pg1').feature('str1').set('showsolutionparams', 'on');
model.result('pg1').feature('str1').set('maxtime', Inf);
model.result('pg1').feature('str1').set('data', 'parent');
model.result('pg1').feature('str1').selection.geom('geom1', 1);
model.result('pg1').feature('str1').selection.set([1 2 3 4 5 6 7 8 9 10 11 12 13 14]);
model.result('pg1').feature('str1').set('inheritplot', 'surf1');
model.result('pg1').feature('str1').feature.create('col1', 'Color');
model.result('pg1').feature('str1').feature('col1').set('colortable', 'DipoleDark');
model.result('pg1').feature('str1').feature('col1').set('colorlegend', false);
model.result('pg1').feature('str1').feature.create('filt1', 'Filter');
model.result('pg1').feature('str1').feature('filt1').set('expr', '!isScalingSystemDomain');
model.result.create('pg2', 'PlotGroup2D');
model.result('pg2').label('Electric Field Norm (ec)');
model.result('pg2').set('frametype', 'spatial');
model.result('pg2').set('showlegendsmaxmin', true);
model.result('pg2').set('data', 'dset1');
model.result('pg2').setIndex('looplevel', 21, 0);
model.result('pg2').set('defaultPlotID', 'InterfaceComponents/PlotDefaults/icom3/pdef1/pcond2/pcond2/pg1');
model.result('pg2').feature.create('surf1', 'Surface');
model.result('pg2').feature('surf1').set('showsolutionparams', 'on');
model.result('pg2').feature('surf1').set('solutionparams', 'parent');
model.result('pg2').feature('surf1').set('expr', 'ec.normE');
model.result('pg2').feature('surf1').set('colortable', 'Prism');
model.result('pg2').feature('surf1').set('colortabletrans', 'nonlinear');
model.result('pg2').feature('surf1').set('colorcalibration', -0.8);
model.result('pg2').feature('surf1').set('showsolutionparams', 'on');
model.result('pg2').feature('surf1').set('data', 'parent');
model.result('pg2').feature.create('str1', 'Streamline');
model.result('pg2').feature('str1').set('showsolutionparams', 'on');
model.result('pg2').feature('str1').set('solutionparams', 'parent');
model.result('pg2').feature('str1').set('expr', {'ec.Ex' 'ec.Ey'});
model.result('pg2').feature('str1').set('titletype', 'none');
model.result('pg2').feature('str1').set('posmethod', 'uniform');
model.result('pg2').feature('str1').set('udist', 0.02);
model.result('pg2').feature('str1').set('maxlen', 0.4);
model.result('pg2').feature('str1').set('maxtime', Inf);
model.result('pg2').feature('str1').set('inheritcolor', false);
model.result('pg2').feature('str1').set('showsolutionparams', 'on');
model.result('pg2').feature('str1').set('maxtime', Inf);
model.result('pg2').feature('str1').set('showsolutionparams', 'on');
model.result('pg2').feature('str1').set('maxtime', Inf);
model.result('pg2').feature('str1').set('showsolutionparams', 'on');
model.result('pg2').feature('str1').set('maxtime', Inf);
model.result('pg2').feature('str1').set('showsolutionparams', 'on');
model.result('pg2').feature('str1').set('maxtime', Inf);
model.result('pg2').feature('str1').set('data', 'parent');
model.result('pg2').feature('str1').selection.geom('geom1', 1);
model.result('pg2').feature('str1').selection.set([1 2 3 4 5 6 7 8 9 10 11 12 13 14]);
model.result('pg2').feature('str1').set('inheritplot', 'surf1');
model.result('pg2').feature('str1').feature.create('col1', 'Color');
model.result('pg2').feature('str1').feature('col1').set('expr', 'ec.normE');
model.result('pg2').feature('str1').feature('col1').set('colortable', 'PrismDark');
model.result('pg2').feature('str1').feature('col1').set('colorlegend', false);
model.result('pg2').feature('str1').feature('col1').set('colortabletrans', 'nonlinear');
model.result('pg2').feature('str1').feature('col1').set('colorcalibration', -0.8);
model.result('pg2').feature('str1').feature.create('filt1', 'Filter');
model.result('pg2').feature('str1').feature('filt1').set('expr', '!isScalingSystemDomain');
model.result.create('pg3', 'PlotGroup2D');
model.result('pg3').set('data', 'dset1');
model.result('pg3').setIndex('looplevel', 21, 0);
model.result('pg3').create('surf1', 'Surface');
model.result('pg3').label('Electroosmotic Pressure');
model.result('pg3').feature('surf1').set('expr', 'p');
model.result.create('pg4', 'PlotGroup2D');
model.result('pg4').set('data', 'dset1');
model.result('pg4').setIndex('looplevel', 21, 0);
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
model.result('pg1').run;
model.result('pg4').run;
model.result('pg4').run;
model.result('pg4').feature('str1').active(false);
model.result('pg4').run;
model.result('pg4').feature('surf1').set('data', 'dset1');
model.result('pg4').feature('surf1').setIndex('looplevel', 1, 0);
model.result('pg4').feature('surf1').set('colortable', 'TrafficLight');
model.result('pg4').run;
model.result('pg4').feature('surf1').setIndex('looplevel', 7, 0);
model.result('pg4').run;
model.result('pg4').feature('surf1').setIndex('looplevel', 13, 0);
model.result('pg4').run;
model.result('pg4').feature('surf1').setIndex('looplevel', 19, 0);
model.result('pg4').run;
model.result.create('pg5', 'PlotGroup2D');
model.result('pg5').run;
model.result('pg5').label('Velocity Electroosmotic Term');
model.result('pg5').set('data', 'dset2');
model.result('pg5').set('showlegendsunit', true);
model.result('pg5').set('titletype', 'none');
model.result('pg5').create('surf1', 'Surface');
model.result('pg5').feature('surf1').label('Velocity Magnitude');
model.result('pg5').feature('surf1').set('expr', 'U_eo');
model.result('pg5').feature('surf1').set('descr', 'Flow-velocity electroosmosis term, magnitude');
model.result('pg5').feature('surf1').set('unit', 'mm/s');
model.result('pg5').run;
model.result('pg5').create('arws1', 'ArrowSurface');
model.result('pg5').feature('arws1').label('Velocity Field');
model.result('pg5').feature('arws1').set('expr', {'u_eo' 'v_eo'});
model.result('pg5').feature('arws1').set('descractive', true);
model.result('pg5').feature('arws1').set('descr', 'Velocity Electroosmotic Term');
model.result('pg5').run;
model.result.create('pg6', 'PlotGroup2D');
model.result('pg6').run;
model.result('pg6').label('Velocity Pressure Term');
model.result('pg6').set('data', 'dset2');
model.result('pg6').set('showlegendsunit', true);
model.result('pg6').set('titletype', 'none');
model.result('pg6').create('surf1', 'Surface');
model.result('pg6').feature('surf1').label('Velocity Magnitude');
model.result('pg6').feature('surf1').set('expr', 'U_p');
model.result('pg6').feature('surf1').set('descr', 'Velocity pressure term, magnitude');
model.result('pg6').feature('surf1').set('unit', 'mm/s');
model.result('pg6').run;
model.result('pg6').create('arws1', 'ArrowSurface');
model.result('pg6').feature('arws1').label('Velocity Field');
model.result('pg6').feature('arws1').set('expr', {'u_p' 'v_p'});
model.result('pg6').feature('arws1').set('descractive', true);
model.result('pg6').feature('arws1').set('descr', 'Velocity Pressure Term');
model.result('pg6').run;
model.result.dataset.create('cln1', 'CutLine2D');
model.result.dataset('cln1').setIndex('genpoints', -4, 0, 0);
model.result.dataset('cln1').setIndex('genpoints', 2.5, 0, 1);
model.result.dataset('cln1').setIndex('genpoints', 4, 1, 0);
model.result.dataset('cln1').setIndex('genpoints', 2.5, 1, 1);
model.result.create('pg7', 'PlotGroup1D');
model.result('pg7').run;
model.result('pg7').label('Concentration Along x-axis @ y=2.5mm');
model.result('pg7').set('data', 'cln1');
model.result('pg7').setIndex('looplevelinput', 'manual', 0);
model.result('pg7').setIndex('looplevel', [1 6 11 16 21], 0);
model.result('pg7').set('legendlayout', 'outside');
model.result('pg7').create('lngr1', 'LineGraph');
model.result('pg7').feature('lngr1').set('markerpos', 'datapoints');
model.result('pg7').feature('lngr1').set('linewidth', 'preference');
model.result('pg7').feature('lngr1').set('expr', 'c');
model.result('pg7').feature('lngr1').set('descr', 'Concentration');
model.result('pg7').feature('lngr1').set('xdataexpr', 'x');
model.result('pg7').feature('lngr1').set('xdatadescr', 'x-coordinate');
model.result('pg7').feature('lngr1').set('legend', true);
model.result('pg7').run;
model.result('pg3').run;
model.result('pg3').label('Pressure');

model.title('Electroosmotic Flow in Porous Media');

model.description('Electroosmotic flow in porous media is demonstrated in this example. The system consists of a compartment of sintered porous material and two electrodes that generate an electric field. The cell combines pressure and electroosmosis-driven flow.');

model.mesh.clearMeshes;

model.sol('sol1').clearSolutionData;
model.sol('sol2').clearSolutionData;

model.label('electroosmotic_flow.mph');

model.modelNode.label('Components');

out = model;
