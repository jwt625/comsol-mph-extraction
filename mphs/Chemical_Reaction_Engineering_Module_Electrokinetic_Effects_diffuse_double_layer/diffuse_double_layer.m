function out = model
%
% diffuse_double_layer.m
%
% Model exported on May 26 2025, 21:27 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/Chemical_Reaction_Engineering_Module/Electrokinetic_Effects');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 1);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.physics.create('es', 'Electrostatics', 'geom1');
model.physics('es').model('comp1');
model.physics('es').field('electricpotential').field('phi');
model.physics.create('tds', 'DilutedSpecies', 'geom1', {'cA' 'cX'});
model.physics('tds').prop('TransportMechanism').set('Convection', '0');
model.physics('tds').prop('TransportMechanism').set('Migration', '1');
model.physics('tds').prop('ShapeProperty').set('order_concentration', '2');

model.multiphysics.create('pc1', 'PotentialCoupling', 'geom1', 1);
model.multiphysics('pc1').set('PotentialSource_physics', 'es');
model.multiphysics('pc1').set('PotentialDestination_physics', 'tds');
model.multiphysics('pc1').selection.all;
model.multiphysics.create('scdc1', 'SpaceChargeDensityCoupling', 'geom1', 1);
model.multiphysics('scdc1').set('SpaceChargeDensitySource_physics', 'tds');
model.multiphysics('scdc1').set('SpaceChargeDensityDestination_physics', 'es');
model.multiphysics('scdc1').selection.all;

model.study.create('std1');
model.study('std1').create('stat', 'Stationary');
model.study('std1').feature('stat').setSolveFor('/physics/es', true);
model.study('std1').feature('stat').setSolveFor('/physics/tds', true);
model.study('std1').feature('stat').setSolveFor('/multiphysics/pc1', true);
model.study('std1').feature('stat').setSolveFor('/multiphysics/scdc1', true);

% To import content from file, use:
% model.param.loadFile('FILENAME');
model.param.set('T0', '25[degC]', 'Temperature');
model.param.set('V_therm', 'R_const*T0/F_const', 'Thermal voltage');
model.param.set('DA', '1e-9[m^2/s]', 'Diffusion coefficient, cation');
model.param.set('DX', 'DA', 'Diffusion coefficient, anion');
model.param.set('cA_bulk', '10[mol/m^3]', 'Bulk cation concentration');
model.param.set('cX_bulk', 'cA_bulk', 'Bulk anion concentration');
model.param.set('zA', '+1', 'Cation charge');
model.param.set('zX', '-1', 'Anion charge');
model.param.set('Istr_bulk', '0.5*((zA^2+zX^2)*cA_bulk)', 'Bulk ionic strength');
model.param.set('eps_H2O', '78.5', 'Relative permittivity of water');
model.param.set('xD', 'sqrt(epsilon0_const*eps_H2O*V_therm/(2*F_const*Istr_bulk))', 'Debye length');
model.param.set('xS', '0.2[nm]', 'Stern layer thickness');
model.param.set('L_cell', 'xD*10', 'Cell length');
model.param.set('h_max', 'L_cell/20', 'Maximum mesh element size');
model.param.set('h_max_surf', 'xD/100', 'Maximum mesh element size (electrode)');
model.param.set('Cd_GCS', 'epsilon0_const/(xD/eps_H2O+xS/eps_S)', 'Capacitance per unit area (GCS theory, low potential limit)');
model.param.set('phiM', '1[mV]', 'Voltage of electrode vs PZC');
model.param.set('eps_S', '10', 'Relative permittivity of Stern layer');

model.variable.create('var1');
model.variable('var1').model('comp1');

model.geom('geom1').run;

% To import content from file, use:
% model.variable('var1').loadFile('FILENAME');
model.variable('var1').set('deltaphi', 'phiM-phi', 'Electrode-OHP potential difference');
model.variable('var1').set('rho_surf', 'epsilon0_const*eps_S*deltaphi/xS', 'Surface charge density');

model.geom('geom1').create('i1', 'Interval');
model.geom('geom1').feature('i1').setIndex('coord', 'L_cell', 1);
model.geom('geom1').runPre('fin');
model.geom('geom1').run;

model.physics('es').feature('ccn1').set('epsilonr_mat', 'userdef');
model.physics('es').feature('ccn1').set('epsilonr', {'eps_H2O' '0' '0' '0' 'eps_H2O' '0' '0' '0' 'eps_H2O'});
model.physics('es').create('sfcd1', 'SurfaceChargeDensity', 0);
model.physics('es').feature('sfcd1').selection.set([1]);
model.physics('es').feature('sfcd1').set('rhoqs', 'rho_surf');
model.physics('es').create('gnd1', 'Ground', 0);
model.physics('es').feature('gnd1').selection.set([2]);
model.physics('tds').feature('sp1').setIndex('z', 'zA', 0);
model.physics('tds').feature('sp1').setIndex('z', 'zX', 1);
model.physics('tds').feature('cdm1').set('D_cA', {'DA' '0' '0' '0' 'DA' '0' '0' '0' 'DA'});
model.physics('tds').feature('cdm1').set('D_cX', {'DX' '0' '0' '0' 'DX' '0' '0' '0' 'DX'});
model.physics('tds').feature('init1').setIndex('initc', 'cA_bulk', 0);
model.physics('tds').feature('init1').setIndex('initc', 'cX_bulk', 1);
model.physics('tds').create('conc1', 'Concentration', 0);
model.physics('tds').feature('conc1').selection.set([2]);
model.physics('tds').feature('conc1').setIndex('species', true, 0);
model.physics('tds').feature('conc1').setIndex('c0', 'cA_bulk', 0);
model.physics('tds').feature('conc1').setIndex('species', true, 1);
model.physics('tds').feature('conc1').setIndex('c0', 'cX_bulk', 1);

model.common('cminpt').set('modified', {'temperature' 'T0'});

model.mesh('mesh1').automatic(false);
model.mesh('mesh1').feature('edg1').create('size1', 'Size');
model.mesh('mesh1').feature('edg1').feature('size1').set('custom', true);
model.mesh('mesh1').feature('edg1').feature('size1').set('hmaxactive', true);
model.mesh('mesh1').feature('edg1').feature('size1').set('hmax', 'h_max');
model.mesh('mesh1').feature('edg1').create('size2', 'Size');
model.mesh('mesh1').feature('edg1').feature('size2').selection.geom('geom1', 0);
model.mesh('mesh1').feature('edg1').feature('size2').selection.set([1]);
model.mesh('mesh1').feature('edg1').feature('size2').set('custom', true);
model.mesh('mesh1').feature('edg1').feature('size2').set('hmaxactive', true);
model.mesh('mesh1').feature('edg1').feature('size2').set('hmax', 'h_max_surf');
model.mesh('mesh1').run;

model.study('std1').feature('stat').set('useparam', true);
model.study('std1').feature('stat').setIndex('pname', 'T0', 0);
model.study('std1').feature('stat').setIndex('plistarr', '', 0);
model.study('std1').feature('stat').setIndex('punit', 'K', 0);
model.study('std1').feature('stat').setIndex('pname', 'T0', 0);
model.study('std1').feature('stat').setIndex('plistarr', '', 0);
model.study('std1').feature('stat').setIndex('punit', 'K', 0);
model.study('std1').feature('stat').setIndex('pname', 'phiM', 0);
model.study('std1').feature('stat').setIndex('plistarr', 'range(1,1,10)', 0);
model.study('std1').feature('stat').setIndex('punit', 'mV', 0);

model.sol.create('sol1');

model.mesh('mesh1').stat.selection.geom(1);
model.mesh('mesh1').stat.selection.set([1]);

model.sol('sol1').study('std1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'stat');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').set('control', 'stat');
model.sol('sol1').create('s1', 'Stationary');
model.sol('sol1').feature('s1').set('stol', 0.001);
model.sol('sol1').feature('s1').create('p1', 'Parametric');
model.sol('sol1').feature('s1').feature.remove('pDef');
model.sol('sol1').feature('s1').feature('p1').set('control', 'stat');
model.sol('sol1').feature('s1').set('control', 'stat');
model.sol('sol1').feature('s1').feature('aDef').set('cachepattern', true);
model.sol('sol1').feature('s1').create('seDef', 'Segregated');
model.sol('sol1').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('s1').feature('fc1').set('dtech', 'auto');
model.sol('sol1').feature('s1').feature('fc1').set('maxiter', 50);
model.sol('sol1').feature('s1').feature('fc1').set('initstep', 0.01);
model.sol('sol1').feature('s1').feature('fc1').set('minstep', 1.0E-6);
model.sol('sol1').feature('s1').create('d1', 'Direct');
model.sol('sol1').feature('s1').feature('d1').label('Direct (Merged)');
model.sol('sol1').feature('s1').create('i1', 'Iterative');
model.sol('sol1').feature('s1').feature('i1').set('linsolver', 'gmres');
model.sol('sol1').feature('s1').feature('i1').set('prefuntype', 'left');
model.sol('sol1').feature('s1').feature('i1').set('itrestart', 50);
model.sol('sol1').feature('s1').feature('i1').set('rhob', 400);
model.sol('sol1').feature('s1').feature('i1').set('maxlinit', 1000);
model.sol('sol1').feature('s1').feature('i1').set('nlinnormuse', 'on');
model.sol('sol1').feature('s1').feature('i1').label('AMG, concentrations (tds)');
model.sol('sol1').feature('s1').feature('i1').create('mg1', 'Multigrid');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').set('prefun', 'saamg');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').set('mgcycle', 'v');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').set('maxcoarsedof', 50000);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').set('strconn', 0.01);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').set('nullspace', 'constant');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').set('usesmooth', false);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').set('saamgcompwise', true);
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
model.sol('sol1').feature('s1').feature('fc1').set('maxiter', 50);
model.sol('sol1').feature('s1').feature('fc1').set('initstep', 0.01);
model.sol('sol1').feature('s1').feature('fc1').set('minstep', 1.0E-6);
model.sol('sol1').feature('s1').feature.remove('fcDef');
model.sol('sol1').feature('s1').feature.remove('seDef');
model.sol('sol1').attach('std1');
model.sol('sol1').runAll;

model.result.create('pg1', 'PlotGroup1D');
model.result('pg1').label('Electric Potential (es)');
model.result('pg1').set('showlooplevelinput', {'off' 'off' 'off'});
model.result('pg1').set('data', 'dset1');
model.result('pg1').set('defaultPlotID', 'InterfaceComponents/PlotDefaults/icom2/pdef1/pcond2/pcond4/pg1');
model.result('pg1').feature.create('lngr1', 'LineGraph');
model.result('pg1').feature('lngr1').set('showsolutionparams', 'on');
model.result('pg1').feature('lngr1').set('solutionparams', 'parent');
model.result('pg1').feature('lngr1').set('xdata', 'expr');
model.result('pg1').feature('lngr1').set('xdataexpr', 'x');
model.result('pg1').feature('lngr1').set('showsolutionparams', 'on');
model.result('pg1').feature('lngr1').set('data', 'parent');
model.result('pg1').feature('lngr1').selection.geom('geom1', 1);
model.result('pg1').feature('lngr1').selection.set([1]);
model.result.create('pg2', 'PlotGroup1D');
model.result('pg2').set('data', 'dset1');
model.result('pg2').set('titletype', 'manual');
model.result('pg2').set('title', 'Concentrations, All Species');
model.result('pg2').label('Concentrations, All Species (tds)');
model.result('pg2').create('lngr1', 'LineGraph');
model.result('pg2').feature('lngr1').set('xdata', 'expr');
model.result('pg2').feature('lngr1').set('xdataexpr', 'x');
model.result('pg2').feature('lngr1').selection.geom('geom1', 1);
model.result('pg2').feature('lngr1').selection.set([1]);
model.result('pg2').feature('lngr1').set('expr', {'cA'});
model.result('pg2').feature('lngr1').label('Species A');
model.result('pg2').feature('lngr1').set('legend', true);
model.result('pg2').feature('lngr1').set('autosolution', false);
model.result('pg2').feature('lngr1').set('autoexpr', false);
model.result('pg2').feature('lngr1').set('autodescr', false);
model.result('pg2').feature('lngr1').set('legendprefix', 'A ');
model.result('pg2').create('lngr2', 'LineGraph');
model.result('pg2').feature('lngr2').set('xdata', 'expr');
model.result('pg2').feature('lngr2').set('xdataexpr', 'x');
model.result('pg2').feature('lngr2').selection.geom('geom1', 1);
model.result('pg2').feature('lngr2').selection.set([1]);
model.result('pg2').feature('lngr2').set('expr', {'cX'});
model.result('pg2').feature('lngr2').label('Species X');
model.result('pg2').feature('lngr2').set('legend', true);
model.result('pg2').feature('lngr2').set('autosolution', false);
model.result('pg2').feature('lngr2').set('autoexpr', false);
model.result('pg2').feature('lngr2').set('autodescr', false);
model.result('pg2').feature('lngr2').set('legendprefix', 'X ');
model.result.create('pg3', 'PlotGroup1D');
model.result('pg3').set('data', 'dset1');
model.result('pg3').label('Concentration, A (tds)');
model.result('pg3').set('titletype', 'custom');
model.result('pg3').set('prefixintitle', 'Species A:');
model.result('pg3').set('expressionintitle', false);
model.result('pg3').set('typeintitle', false);
model.result('pg3').create('lngr1', 'LineGraph');
model.result('pg3').feature('lngr1').set('xdata', 'expr');
model.result('pg3').feature('lngr1').set('xdataexpr', 'x');
model.result('pg3').feature('lngr1').selection.geom('geom1', 1);
model.result('pg3').feature('lngr1').selection.set([1]);
model.result('pg3').feature('lngr1').set('expr', {'cA'});
model.result.create('pg4', 'PlotGroup1D');
model.result('pg4').set('data', 'dset1');
model.result('pg4').label('Concentration, X (tds)');
model.result('pg4').set('titletype', 'custom');
model.result('pg4').set('prefixintitle', 'Species X:');
model.result('pg4').set('expressionintitle', false);
model.result('pg4').set('typeintitle', false);
model.result('pg4').create('lngr1', 'LineGraph');
model.result('pg4').feature('lngr1').set('xdata', 'expr');
model.result('pg4').feature('lngr1').set('xdataexpr', 'x');
model.result('pg4').feature('lngr1').selection.geom('geom1', 1);
model.result('pg4').feature('lngr1').selection.set([1]);
model.result('pg4').feature('lngr1').set('expr', {'cX'});
model.result('pg1').run;
model.result('pg1').setIndex('looplevelinput', 'last', 0);
model.result('pg1').set('ylabelactive', true);
model.result('pg1').run;
model.result('pg1').feature('lngr1').set('xdataexpr', 'x/xD');
model.result('pg1').feature('lngr1').set('xdatadescractive', true);
model.result('pg1').feature('lngr1').set('xdatadescr', 'Length (unit Debye lengths)');
model.result('pg1').feature('lngr1').set('legend', true);
model.result('pg1').feature('lngr1').set('legendmethod', 'manual');
model.result('pg1').feature('lngr1').setIndex('legends', 'Phi', 0);
model.result('pg1').run;
model.result('pg1').create('ptgr1', 'PointGraph');
model.result('pg1').feature('ptgr1').set('markerpos', 'datapoints');
model.result('pg1').feature('ptgr1').set('linewidth', 'preference');
model.result('pg1').feature('ptgr1').selection.set([1]);
model.result('pg1').feature('ptgr1').set('expr', 'phiM');
model.result('pg1').feature('ptgr1').set('xdata', 'expr');
model.result('pg1').feature('ptgr1').set('xdataexpr', 'x/xD');
model.result('pg1').feature('ptgr1').set('xdatadescractive', true);
model.result('pg1').feature('ptgr1').set('xdatadescr', 'Length (unit Debye lengths)');
model.result('pg1').feature('ptgr1').set('linestyle', 'none');
model.result('pg1').feature('ptgr1').set('linecolor', 'red');
model.result('pg1').feature('ptgr1').set('linemarker', 'point');
model.result('pg1').feature('ptgr1').set('legend', true);
model.result('pg1').feature('ptgr1').set('legendmethod', 'manual');
model.result('pg1').feature('ptgr1').setIndex('legends', 'PhiM', 0);
model.result('pg1').run;
model.result('pg2').run;
model.result('pg2').setIndex('looplevelinput', 'last', 0);
model.result('pg2').set('titletype', 'none');
model.result('pg2').run;
model.result('pg2').feature('lngr1').set('xdataunit', 'nm');
model.result('pg2').feature('lngr1').set('legendmethod', 'manual');
model.result('pg2').feature('lngr1').setIndex('legends', 'A<sup>+</sup> Concentration', 0);
model.result('pg2').run;
model.result('pg2').feature('lngr2').set('xdataunit', 'nm');
model.result('pg2').feature('lngr2').set('legendmethod', 'manual');
model.result('pg2').feature('lngr2').setIndex('legends', 'X<sup>-</sup> Concentration', 0);
model.result('pg2').run;
model.result('pg3').run;
model.result('pg3').feature('lngr1').set('linemarker', 'cycle');
model.result('pg3').feature('lngr1').set('markers', 1);
model.result('pg3').feature('lngr1').set('legend', true);
model.result('pg3').feature('lngr1').create('col1', 'Color');
model.result('pg3').run;
model.result('pg3').feature('lngr1').feature('col1').set('expr', 'phiM');
model.result('pg3').run;
model.result('pg3').run;
model.result('pg3').set('legendlayout', 'outside');
model.result('pg4').run;
model.result('pg4').feature('lngr1').set('legend', true);
model.result('pg4').feature('lngr1').set('linemarker', 'cycle');
model.result('pg4').feature('lngr1').set('markers', 1);
model.result('pg4').feature('lngr1').create('col1', 'Color');
model.result('pg4').run;
model.result('pg4').feature('lngr1').feature('col1').set('expr', 'phiM');
model.result('pg4').run;
model.result('pg4').run;
model.result('pg4').set('legendlayout', 'outside');
model.result.create('pg5', 'PlotGroup1D');
model.result('pg5').run;
model.result('pg5').label('Surface Charge Density');
model.result('pg5').set('titletype', 'none');
model.result('pg5').create('ptgr1', 'PointGraph');
model.result('pg5').feature('ptgr1').set('markerpos', 'datapoints');
model.result('pg5').feature('ptgr1').set('linewidth', 'preference');
model.result('pg5').feature('ptgr1').selection.set([1]);
model.result('pg5').feature('ptgr1').set('expr', 'rho_surf');
model.result('pg5').feature('ptgr1').set('xdata', 'expr');
model.result('pg5').feature('ptgr1').set('xdataexpr', 'phiM');
model.result('pg5').feature('ptgr1').set('linestyle', 'none');
model.result('pg5').feature('ptgr1').set('linemarker', 'circle');
model.result('pg5').feature('ptgr1').set('legend', true);
model.result('pg5').feature('ptgr1').set('legendmethod', 'manual');
model.result('pg5').feature('ptgr1').setIndex('legends', 'Surface charge density (simulation)', 0);
model.result('pg5').run;
model.result('pg5').run;
model.result('pg5').create('glob1', 'Global');
model.result('pg5').feature('glob1').set('markerpos', 'datapoints');
model.result('pg5').feature('glob1').set('linewidth', 'preference');
model.result('pg5').feature('glob1').setIndex('expr', 'Cd_GCS*phiM', 0);
model.result('pg5').feature('glob1').setIndex('descr', 'Surface charge density (theory)', 0);
model.result('pg5').feature('glob1').set('xdata', 'expr');
model.result('pg5').feature('glob1').set('xdataexpr', 'phiM');
model.result('pg5').run;
model.result('pg5').set('ylabelactive', true);
model.result('pg5').set('ylabel', 'Charge density (C/m<sup>2</sup>)');
model.result('pg5').set('legendpos', 'lowerright');
model.result('pg5').run;

model.title('Diffuse Double Layer');

model.description(['This example is an extension of the Diffuse Double Layer model and demonstrates how to incorporate charge transfer in a diffuse double layer described by the coupled Nernst' native2unicode(hex2dec({'20' '13'}), 'unicode') 'Planck' native2unicode(hex2dec({'20' '13'}), 'unicode') 'Poisson set of equations.']);

model.label('diffuse_double_layer.mph');

model.modelNode.label('Components');

out = model;
