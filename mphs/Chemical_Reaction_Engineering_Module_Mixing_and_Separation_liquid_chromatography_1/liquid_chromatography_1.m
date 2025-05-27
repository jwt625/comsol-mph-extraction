function out = model
%
% liquid_chromatography_1.m
%
% Model exported on May 26 2025, 21:27 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/Chemical_Reaction_Engineering_Module/Mixing_and_Separation');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 1);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.physics.create('tds', 'DilutedSpeciesInPorousMedia', 'geom1', {'c1' 'c2'});

model.study.create('std1');
model.study('std1').create('time', 'Transient');
model.study('std1').feature('time').setSolveFor('/physics/tds', true);

% To import content from file, use:
% model.param.loadFile('FILENAME');
model.param.set('L_c', '120[mm]', 'Length column');
model.param.set('c01', '1[mol/m^3]', 'Maximum inlet injector concentration, component 1');
model.param.set('c02', '10[mol/m^3]', 'Maximum inlet injector concentration, component 2');
model.param.set('S', '1e5[m^2/kg]', 'Particle specific surface area');
model.param.set('rho_p', '2300[kg/m^3]', 'Density solid material particles');
model.param.set('eps_p', '0.6', 'Porosity');
model.param.set('v_l', '1.3[mm/s]', 'Linear velocity, mobile phase');
model.param.set('D_1', '1e-8[m^2/s]', 'Diffusion coefficient, component 1');
model.param.set('D_2', '1e-8[m^2/s]', 'Diffusion coefficient, component 2');
model.param.set('K1', '0.04[m^3/mol]', 'Langmuir adsorption constant, component 1');
model.param.set('K2', '0.05[m^3/mol]', 'Langmuir adsorption constant, component 2');
model.param.set('n01', '1e-6[mol/m^2]', 'Monolayer capacity, component 1');
model.param.set('n02', '5e-7[mol/m^2]', 'Monolayer capacity, component 2');

model.func.create('gp1', 'GaussianPulse');
model.func('gp1').label('Injection Pulse');
model.func('gp1').set('funcname', 'p1');
model.func('gp1').set('location', 3);

model.variable.create('var1');
model.variable('var1').set('pulse_inj', '2.5*p1(t/1[s])');
model.variable('var1').descr('pulse_inj', 'Time-dependent injection pulse with amplitude 1');
model.variable('var1').set('rho_c', 'rho_p*(1-eps_p)');
model.variable('var1').descr('rho_c', 'Density media in column');

model.geom('geom1').create('i1', 'Interval');
model.geom('geom1').feature('i1').setIndex('coord', 'L_c', 1);
model.geom('geom1').runPre('fin');
model.geom('geom1').run;

model.physics('tds').feature('porous1').create('ads1', 'Adsorptions', 1);
model.physics('tds').feature('porous1').feature('ads1').setIndex('species', true, 0);
model.physics('tds').feature('porous1').feature('ads1').setIndex('species', true, 1);
model.physics('tds').feature('porous1').feature('ads1').set('rho_db_mat', 'userdef');
model.physics('tds').feature('porous1').feature('ads1').set('rho_db', 'rho_c');
model.physics('tds').feature('porous1').feature('ads1').setIndex('KL', 'K1', 0);
model.physics('tds').feature('porous1').feature('ads1').setIndex('cPmax', 'S*n01', 0);
model.physics('tds').feature('porous1').feature('ads1').setIndex('KL', 'K2', 1);
model.physics('tds').feature('porous1').feature('ads1').setIndex('cPmax', 'S*n02', 1);
model.physics('tds').feature('porous1').feature('fluid1').set('u', {'v_l' '0' '0'});
model.physics('tds').feature('porous1').feature('fluid1').set('DF_c1', {'D_1' '0' '0' '0' 'D_1' '0' '0' '0' 'D_1'});
model.physics('tds').feature('porous1').feature('fluid1').set('DF_c2', {'D_2' '0' '0' '0' 'D_2' '0' '0' '0' 'D_2'});
model.physics('tds').feature('porous1').feature('pm1').set('poro_mat', 'userdef');
model.physics('tds').feature('porous1').feature('pm1').set('poro', 'eps_p');
model.physics('tds').create('in1', 'Inflow', 0);
model.physics('tds').feature('in1').selection.set([1]);
model.physics('tds').feature('in1').setIndex('c0', 'c01*pulse_inj', 0);
model.physics('tds').feature('in1').setIndex('c0', 'c02*pulse_inj', 1);
model.physics('tds').create('out1', 'Outflow', 0);
model.physics('tds').feature('out1').selection.set([2]);

model.mesh('mesh1').create('edg1', 'Edge');
model.mesh('mesh1').feature('size').set('custom', true);
model.mesh('mesh1').feature('size').set('hmax', '1e-4');
model.mesh('mesh1').run;

model.study('std1').feature('time').set('tlist', 'range(0,1,420)');
model.study('std1').feature('time').set('usertol', true);
model.study('std1').feature('time').set('rtol', '0.0010');

model.sol.create('sol1');

model.mesh('mesh1').stat.selection.geom(1);
model.mesh('mesh1').stat.selection.set([1]);

model.sol('sol1').study('std1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'time');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').set('control', 'time');
model.sol('sol1').create('t1', 'Time');
model.sol('sol1').feature('t1').set('tlist', 'range(0,1,420)');
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
model.sol('sol1').feature('v1').feature('comp1_c1').set('scalemethod', 'manual');
model.sol('sol1').feature('v1').feature('comp1_c1').set('scaleval', 'c01');
model.sol('sol1').feature('v1').feature('comp1_c2').set('scalemethod', 'manual');
model.sol('sol1').feature('v1').feature('comp1_c2').set('scaleval', 'c02');
model.sol('sol1').feature('t1').set('atolglobalvaluemethod', 'manual');
model.sol('sol1').feature('t1').set('atolglobal', '1e-4');
model.sol('sol1').runAll;

model.result.create('pg1', 'PlotGroup1D');
model.result('pg1').set('data', 'dset1');
model.result('pg1').set('titletype', 'manual');
model.result('pg1').set('title', 'Concentrations, All Species');
model.result('pg1').label('Concentrations, All Species (tds)');
model.result('pg1').create('lngr1', 'LineGraph');
model.result('pg1').feature('lngr1').set('xdata', 'expr');
model.result('pg1').feature('lngr1').set('xdataexpr', 'x');
model.result('pg1').feature('lngr1').selection.geom('geom1', 1);
model.result('pg1').feature('lngr1').selection.set([1]);
model.result('pg1').feature('lngr1').set('expr', {'c1'});
model.result('pg1').feature('lngr1').label('Species c1');
model.result('pg1').feature('lngr1').set('legend', true);
model.result('pg1').feature('lngr1').set('autosolution', false);
model.result('pg1').feature('lngr1').set('autoexpr', false);
model.result('pg1').feature('lngr1').set('autodescr', false);
model.result('pg1').feature('lngr1').set('legendprefix', 'c1 ');
model.result('pg1').create('lngr2', 'LineGraph');
model.result('pg1').feature('lngr2').set('xdata', 'expr');
model.result('pg1').feature('lngr2').set('xdataexpr', 'x');
model.result('pg1').feature('lngr2').selection.geom('geom1', 1);
model.result('pg1').feature('lngr2').selection.set([1]);
model.result('pg1').feature('lngr2').set('expr', {'c2'});
model.result('pg1').feature('lngr2').label('Species c2');
model.result('pg1').feature('lngr2').set('legend', true);
model.result('pg1').feature('lngr2').set('autosolution', false);
model.result('pg1').feature('lngr2').set('autoexpr', false);
model.result('pg1').feature('lngr2').set('autodescr', false);
model.result('pg1').feature('lngr2').set('legendprefix', 'c2 ');
model.result.create('pg2', 'PlotGroup1D');
model.result('pg2').set('data', 'dset1');
model.result('pg2').label('Concentration, c1 (tds)');
model.result('pg2').set('titletype', 'custom');
model.result('pg2').set('prefixintitle', 'Species c1:');
model.result('pg2').set('expressionintitle', false);
model.result('pg2').set('typeintitle', false);
model.result('pg2').create('lngr1', 'LineGraph');
model.result('pg2').feature('lngr1').set('xdata', 'expr');
model.result('pg2').feature('lngr1').set('xdataexpr', 'x');
model.result('pg2').feature('lngr1').selection.geom('geom1', 1);
model.result('pg2').feature('lngr1').selection.set([1]);
model.result('pg2').feature('lngr1').set('expr', {'c1'});
model.result.create('pg3', 'PlotGroup1D');
model.result('pg3').set('data', 'dset1');
model.result('pg3').label('Concentration, c2 (tds)');
model.result('pg3').set('titletype', 'custom');
model.result('pg3').set('prefixintitle', 'Species c2:');
model.result('pg3').set('expressionintitle', false);
model.result('pg3').set('typeintitle', false);
model.result('pg3').create('lngr1', 'LineGraph');
model.result('pg3').feature('lngr1').set('xdata', 'expr');
model.result('pg3').feature('lngr1').set('xdataexpr', 'x');
model.result('pg3').feature('lngr1').selection.geom('geom1', 1);
model.result('pg3').feature('lngr1').selection.set([1]);
model.result('pg3').feature('lngr1').set('expr', {'c2'});
model.result('pg1').run;
model.result('pg1').run;
model.result('pg1').setIndex('looplevelinput', 'interp', 0);
model.result('pg1').setIndex('interp', '10 100 200 300', 0);
model.result('pg1').set('titletype', 'none');
model.result('pg1').set('xlabelactive', true);
model.result('pg1').set('xlabel', 'Column length (m)');
model.result('pg1').set('axislimits', true);
model.result('pg1').set('ymin', 0);
model.result('pg1').set('legendcolumncount', 2);
model.result('pg1').run;
model.result('pg1').feature('lngr1').set('linewidth', 2);
model.result('pg1').feature('lngr1').set('autosolution', true);
model.result('pg1').run;
model.result('pg1').feature('lngr2').set('linestyle', 'dashed');
model.result('pg1').feature('lngr2').set('linecolor', 'cyclereset');
model.result('pg1').feature('lngr2').set('linewidth', 2);
model.result('pg1').feature('lngr2').set('autosolution', true);
model.result('pg1').run;
model.result('pg2').run;
model.result('pg2').setIndex('looplevelinput', 'interp', 0);
model.result('pg2').setIndex('interp', '5 50 100 200 300 385', 0);
model.result('pg2').set('titletype', 'none');
model.result('pg2').set('xlabelactive', true);
model.result('pg2').set('xlabel', 'Column length (m)');
model.result('pg2').set('axislimits', true);
model.result('pg2').set('ymin', 0);
model.result('pg2').run;
model.result('pg2').feature('lngr1').set('linewidth', 2);
model.result('pg2').feature('lngr1').set('legend', true);
model.result('pg2').run;
model.result('pg3').run;
model.result('pg3').setIndex('looplevelinput', 'interp', 0);
model.result('pg3').setIndex('interp', '5 50 100 200 300 385', 0);
model.result('pg3').set('titletype', 'none');
model.result('pg3').set('xlabelactive', true);
model.result('pg3').set('xlabel', 'Column length (m)');
model.result('pg3').set('axislimits', true);
model.result('pg3').set('ymin', 0);
model.result('pg3').set('legendlayout', 'outside');
model.result('pg3').run;
model.result('pg3').feature('lngr1').set('linewidth', 2);
model.result('pg3').feature('lngr1').set('legend', true);
model.result('pg3').run;
model.result.create('pg4', 'PlotGroup1D');
model.result('pg4').run;
model.result('pg4').label('Detected Concentration');
model.result('pg4').set('titletype', 'none');
model.result('pg4').create('ptgr1', 'PointGraph');
model.result('pg4').feature('ptgr1').set('markerpos', 'datapoints');
model.result('pg4').feature('ptgr1').set('linewidth', 'preference');
model.result('pg4').feature('ptgr1').selection.set([2]);
model.result('pg4').feature('ptgr1').set('expr', 'c1+c2');
model.result('pg4').feature('ptgr1').set('linewidth', 2);
model.result('pg4').run;
model.result('pg4').set('ylabelactive', true);
model.result('pg4').set('ylabel', 'Concentration (mol/m<sup>3</sup>)');
model.result('pg4').run;
model.result.export.create('anim1', 'Animation');
model.result.export('anim1').set('fontsize', '9');
model.result.export('anim1').set('colortheme', 'globaltheme');
model.result.export('anim1').set('customcolor', [1 1 1]);
model.result.export('anim1').set('background', 'color');
model.result.export('anim1').set('gltfincludelines', 'on');
model.result.export('anim1').set('title1d', 'on');
model.result.export('anim1').set('legend1d', 'on');
model.result.export('anim1').set('logo1d', 'on');
model.result.export('anim1').set('options1d', 'on');
model.result.export('anim1').set('title2d', 'on');
model.result.export('anim1').set('legend2d', 'on');
model.result.export('anim1').set('logo2d', 'on');
model.result.export('anim1').set('options2d', 'off');
model.result.export('anim1').set('title3d', 'on');
model.result.export('anim1').set('legend3d', 'on');
model.result.export('anim1').set('logo3d', 'on');
model.result.export('anim1').set('options3d', 'off');
model.result.export('anim1').set('axisorientation', 'on');
model.result.export('anim1').set('grid', 'on');
model.result.export('anim1').set('axes1d', 'on');
model.result.export('anim1').set('axes2d', 'on');
model.result.export('anim1').set('showgrid', 'on');
model.result.export('anim1').label('Liquid Chromatography Animation');
model.result.export('anim1').set('target', 'player');
model.result.export('anim1').set('looplevelinput', 'interp');
model.result.export('anim1').set('interp', 'range(0,2,420)');
model.result.export('anim1').run;

model.title('Liquid Chromatography');

model.description('Chromatography is an important group of methods for separating closely related components of complex mixtures. This example models the separation in a high-performance liquid chromatography (HPLC) column.');

model.mesh.clearMeshes;

model.sol('sol1').clearSolutionData;

model.label('liquid_chromatography_1.mph');

model.modelNode.label('Components');

out = model;
