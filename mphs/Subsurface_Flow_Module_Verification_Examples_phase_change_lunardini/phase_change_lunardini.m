function out = model
%
% phase_change_lunardini.m
%
% Model exported on May 26 2025, 21:34 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/Subsurface_Flow_Module/Verification_Examples');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 1);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.physics.create('ht', 'PorousMediaHeatTransfer', 'geom1');
model.physics('ht').model('comp1');

model.study.create('std1');
model.study('std1').create('time', 'Transient');
model.study('std1').feature('time').setSolveFor('/physics/ht', true);

model.geom('geom1').create('i1', 'Interval');
model.geom('geom1').feature('i1').setIndex('coord', 10, 1);
model.geom('geom1').runPre('fin');

% To import content from file, use:
% model.param.loadFile('FILENAME');
model.param.set('por', '0.336', 'Porosity');
model.param.set('Sw_res', '0.391', 'Residual water saturation');
model.param.set('rho_solid', '2530.1[kg/m^3]', 'Density of soil');
model.param.set('rho_water', '1000[kg/m^3]', 'Density of water');
model.param.set('rho_ice', '920[kg/m^3]', 'Density of ice');
model.param.set('k_water', '0.598[W/m/K]', 'Thermal conductivity of water');
model.param.set('Cv', '690030[J/m^3/K]', 'Volumetric heat capacity');
model.param.set('L', '334560[J/kg]', 'Latent heat of freezing');
model.param.set('k_solid', '(2.417196[W/m/K]-por*k_water)/(1-por)', 'Thermal conductivity of soil');
model.param.set('k_ice', '((3.462696[W/m/K]-(1-por)*k_solid)/por-Sw_res*k_water)/(1-Sw_res)', 'Thermal conductivity of ice');
model.param.set('T_init', '4[degC]', 'Initial temperature');
model.param.set('T_in', '-6[degC]', 'Imposed temperature');

model.geom('geom1').run;

model.physics('ht').feature('porous1').feature('fluid1').create('phc1', 'PhaseChangeMaterial', 1);
model.physics('ht').feature('porous1').feature('fluid1').feature('phc1').set('PhaseTransitionFunction12', 'userdef');
model.physics('ht').feature('porous1').feature('fluid1').feature('phc1').set('L_pc12', 'L');
model.physics('ht').feature('porous1').feature('fluid1').feature('phc1').set('alpha12', 'f_phtr(T)');
model.physics('ht').feature('porous1').feature('fluid1').feature('phc1').set('k_phase1_mat', 'userdef');
model.physics('ht').feature('porous1').feature('fluid1').feature('phc1').set('k_phase1', {'k_ice' '0' '0' '0' 'k_ice' '0' '0' '0' 'k_ice'});
model.physics('ht').feature('porous1').feature('fluid1').feature('phc1').set('rho_phase1_mat', 'userdef');
model.physics('ht').feature('porous1').feature('fluid1').feature('phc1').set('rho_phase1', 'rho_ice');
model.physics('ht').feature('porous1').feature('fluid1').feature('phc1').set('Cp_phase1_mat', 'userdef');
model.physics('ht').feature('porous1').feature('fluid1').feature('phc1').set('Cp_phase1', 'Cv/rho_ice');
model.physics('ht').feature('porous1').feature('fluid1').feature('phc1').set('k_phase2_mat', 'userdef');
model.physics('ht').feature('porous1').feature('fluid1').feature('phc1').set('k_phase2', {'k_water' '0' '0' '0' 'k_water' '0' '0' '0' 'k_water'});
model.physics('ht').feature('porous1').feature('fluid1').feature('phc1').set('rho_phase2_mat', 'userdef');
model.physics('ht').feature('porous1').feature('fluid1').feature('phc1').set('rho_phase2', 'rho_water');
model.physics('ht').feature('porous1').feature('fluid1').feature('phc1').set('Cp_phase2_mat', 'userdef');
model.physics('ht').feature('porous1').feature('fluid1').feature('phc1').set('Cp_phase2', 'Cv/rho_water');

model.func.create('int1', 'Interpolation');
model.func('int1').model('comp1');
model.func('int1').set('funcname', 'f_phtr');
model.func('int1').setIndex('table', -4, 0, 0);
model.func('int1').setIndex('table', 'Sw_res', 0, 1);
model.func('int1').setIndex('table', -1, 1, 0);
model.func('int1').setIndex('table', 'Sw_res', 1, 1);
model.func('int1').setIndex('table', 0, 2, 0);
model.func('int1').setIndex('table', 1, 2, 1);
model.func('int1').setIndex('table', 6, 3, 0);
model.func('int1').setIndex('table', 1, 3, 1);
model.func('int1').setIndex('fununit', 1, 0);
model.func('int1').setIndex('argunit', 'degC', 0);

model.physics('ht').feature('porous1').feature('pm1').set('poro_mat', 'userdef');
model.physics('ht').feature('porous1').feature('pm1').set('poro', 'por');
model.physics('ht').feature('porous1').feature('pm1').set('porousMatrixPropertiesType', 'solidPhaseProperties');
model.physics('ht').feature('porous1').feature('pm1').set('k_sp_mat', 'userdef');
model.physics('ht').feature('porous1').feature('pm1').set('k_sp', {'k_solid' '0' '0' '0' 'k_solid' '0' '0' '0' 'k_solid'});
model.physics('ht').feature('porous1').feature('pm1').set('rho_sp_mat', 'userdef');
model.physics('ht').feature('porous1').feature('pm1').set('rho_sp', 'rho_solid');
model.physics('ht').feature('porous1').feature('pm1').set('Cp_sp_mat', 'userdef');
model.physics('ht').feature('porous1').feature('pm1').set('Cp_sp', 'Cv/rho_solid');
model.physics('ht').feature('init1').set('Tinit', 'T_init');
model.physics('ht').create('temp1', 'TemperatureBoundary', 0);
model.physics('ht').feature('temp1').selection.set([1]);
model.physics('ht').feature('temp1').set('T0', 'T_in');

model.mesh('mesh1').create('edg1', 'Edge');
model.mesh('mesh1').feature('edg1').create('dis1', 'Distribution');
model.mesh('mesh1').feature('edg1').feature('dis1').set('type', 'predefined');
model.mesh('mesh1').feature('edg1').feature('dis1').set('elemcount', 100);
model.mesh('mesh1').feature('edg1').feature('dis1').set('elemratio', 10);
model.mesh('mesh1').run;

model.study('std1').feature('time').set('tunit', 'h');
model.study('std1').feature('time').set('tlist', '0 24 48 72');

model.sol.create('sol1');
model.sol('sol1').study('std1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'time');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').set('control', 'time');
model.sol('sol1').create('t1', 'Time');
model.sol('sol1').feature('t1').set('tlist', '0 24 48 72');
model.sol('sol1').feature('t1').set('plot', 'off');
model.sol('sol1').feature('t1').set('plotgroup', 'Default');
model.sol('sol1').feature('t1').set('plotfreq', 'tout');
model.sol('sol1').feature('t1').set('probesel', 'all');
model.sol('sol1').feature('t1').set('probes', {});
model.sol('sol1').feature('t1').set('probefreq', 'tsteps');
model.sol('sol1').feature('t1').set('atolglobalvaluemethod', 'factor');
model.sol('sol1').feature('t1').set('atolmethod', {'comp1_T' 'global'});
model.sol('sol1').feature('t1').set('atol', {'comp1_T' '1e-3'});
model.sol('sol1').feature('t1').set('atolvaluemethod', {'comp1_T' 'factor'});
model.sol('sol1').feature('t1').set('reacf', true);
model.sol('sol1').feature('t1').set('storeudot', true);
model.sol('sol1').feature('t1').set('endtimeinterpolation', true);
model.sol('sol1').feature('t1').set('estrat', 'exclude');
model.sol('sol1').feature('t1').set('maxorder', 2);
model.sol('sol1').feature('t1').set('control', 'time');
model.sol('sol1').feature('t1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('t1').feature('fc1').set('jtech', 'once');
model.sol('sol1').feature('t1').feature('fc1').set('damp', 0.9);
model.sol('sol1').feature('t1').feature('fc1').set('stabacc', 'aacc');
model.sol('sol1').feature('t1').feature('fc1').set('aaccdim', 5);
model.sol('sol1').feature('t1').feature('fc1').set('aaccmix', 0.9);
model.sol('sol1').feature('t1').feature('fc1').set('aaccdelay', 1);
model.sol('sol1').feature('t1').create('d1', 'Direct');
model.sol('sol1').feature('t1').feature('d1').set('linsolver', 'pardiso');
model.sol('sol1').feature('t1').feature('d1').set('pivotperturb', 1.0E-13);
model.sol('sol1').feature('t1').feature('d1').label('Direct, heat transfer variables (ht)');
model.sol('sol1').feature('t1').create('i1', 'Iterative');
model.sol('sol1').feature('t1').feature('i1').set('linsolver', 'gmres');
model.sol('sol1').feature('t1').feature('i1').set('prefuntype', 'left');
model.sol('sol1').feature('t1').feature('i1').set('itrestart', 50);
model.sol('sol1').feature('t1').feature('i1').set('rhob', 20);
model.sol('sol1').feature('t1').feature('i1').set('maxlinit', 10000);
model.sol('sol1').feature('t1').feature('i1').set('nlinnormuse', 'on');
model.sol('sol1').feature('t1').feature('i1').label('AMG, heat transfer variables (ht)');
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
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('pr').create('so1', 'SOR');
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('pr').feature('so1').set('iter', 2);
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('pr').feature('so1').set('relax', 0.9);
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('po').create('so1', 'SOR');
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('po').feature('so1').set('iter', 2);
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('po').feature('so1').set('relax', 0.9);
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('cs').create('d1', 'Direct');
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('cs').feature('d1').set('linsolver', 'pardiso');
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('cs').feature('d1').set('pivotperturb', 1.0E-13);
model.sol('sol1').feature('t1').feature('fc1').set('linsolver', 'd1');
model.sol('sol1').feature('t1').feature('fc1').set('jtech', 'once');
model.sol('sol1').feature('t1').feature('fc1').set('damp', 0.9);
model.sol('sol1').feature('t1').feature('fc1').set('stabacc', 'aacc');
model.sol('sol1').feature('t1').feature('fc1').set('aaccdim', 5);
model.sol('sol1').feature('t1').feature('fc1').set('aaccmix', 0.9);
model.sol('sol1').feature('t1').feature('fc1').set('aaccdelay', 1);
model.sol('sol1').feature('t1').feature.remove('fcDef');
model.sol('sol1').attach('std1');
model.sol('sol1').feature('t1').set('maxstepconstraintbdf', 'const');
model.sol('sol1').feature('t1').set('maxstepbdf', '2[min]');
model.sol('sol1').runAll;

model.result.create('pg1', 'PlotGroup1D');
model.result('pg1').label('Temperature (ht)');
model.result('pg1').set('showlooplevelinput', {'off' 'off' 'off'});
model.result('pg1').set('data', 'dset1');
model.result('pg1').set('defaultPlotID', 'ht/HT_PhysicsInterfaces/icom8/pdef1/pcond1/pg1');
model.result('pg1').feature.create('lngr1', 'LineGraph');
model.result('pg1').feature('lngr1').set('xdata', 'expr');
model.result('pg1').feature('lngr1').set('xdataexpr', 'x');
model.result('pg1').feature('lngr1').set('data', 'parent');
model.result('pg1').feature('lngr1').selection.geom('geom1', 1);
model.result('pg1').feature('lngr1').selection.set([1]);
model.result('pg1').run;
model.result('pg1').setIndex('looplevelinput', 'manual', 0);
model.result('pg1').setIndex('looplevel', [2 3 4], 0);
model.result('pg1').set('legendlayout', 'outside');
model.result('pg1').set('legendposoutside', 'bottom');
model.result('pg1').run;
model.result('pg1').feature('lngr1').set('unit', 'degC');
model.result('pg1').feature('lngr1').set('legend', true);
model.result.table.create('tbl1', 'Table');
model.result.table('tbl1').importData('phase_change_lunardini_analytical_solution.txt');
model.result('pg1').run;
model.result('pg1').create('tblp1', 'Table');
model.result('pg1').feature('tblp1').set('markerpos', 'datapoints');
model.result('pg1').feature('tblp1').set('linewidth', 'preference');
model.result('pg1').feature('tblp1').set('linestyle', 'none');
model.result('pg1').feature('tblp1').set('linecolor', 'cyclereset');
model.result('pg1').feature('tblp1').set('linemarker', 'asterisk');
model.result('pg1').feature('tblp1').set('markerpos', 'interp');
model.result('pg1').feature('tblp1').set('markers', 25);
model.result('pg1').run;
model.result('pg1').set('axislimits', true);
model.result('pg1').set('xmax', 5);
model.result('pg1').run;

model.title('Phase Change in a Semi-Infinite Soil Column');

model.description('In this example, a heat-conduction problem with phase change in a porous material is solved and the results are compared with the analytical solution, also known as the Lunardini solution.');

model.label('phase_change_lunardini.mph');

model.modelNode.label('Components');

out = model;
