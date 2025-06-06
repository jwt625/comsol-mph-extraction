function out = model
%
% aquifer_water_table.m
%
% Model exported on May 26 2025, 21:34 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/Subsurface_Flow_Module/Solute_Transport');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 2);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.physics.create('dl', 'PorousMediaFlowDarcy', 'geom1');
model.physics('dl').model('comp1');
model.physics.create('tds', 'DilutedSpeciesInPorousMedia', 'geom1', {'c'});

model.study.create('std1');
model.study('std1').create('stat', 'Stationary');
model.study('std1').feature('stat').setSolveFor('/physics/dl', true);
model.study('std1').feature('stat').setSolveFor('/physics/tds', true);

model.geom('geom1').create('pol1', 'Polygon');
model.geom('geom1').feature('pol1').set('source', 'table');
model.geom('geom1').feature('pol1').setIndex('table', 0, 0, 0);
model.geom('geom1').feature('pol1').setIndex('table', 0, 0, 1);
model.geom('geom1').feature('pol1').setIndex('table', 250, 1, 0);
model.geom('geom1').feature('pol1').setIndex('table', 0, 1, 1);
model.geom('geom1').feature('pol1').setIndex('table', 250, 2, 0);
model.geom('geom1').feature('pol1').setIndex('table', 5.35, 2, 1);
model.geom('geom1').feature('pol1').setIndex('table', 180, 3, 0);
model.geom('geom1').feature('pol1').setIndex('table', 5.575, 3, 1);
model.geom('geom1').feature('pol1').setIndex('table', 155, 4, 0);
model.geom('geom1').feature('pol1').setIndex('table', 6.045, 4, 1);
model.geom('geom1').feature('pol1').setIndex('table', 127, 5, 0);
model.geom('geom1').feature('pol1').setIndex('table', 6.455, 5, 1);
model.geom('geom1').feature('pol1').setIndex('table', 80, 6, 0);
model.geom('geom1').feature('pol1').setIndex('table', 6.603, 6, 1);
model.geom('geom1').feature('pol1').setIndex('table', 0, 7, 0);
model.geom('geom1').feature('pol1').setIndex('table', 6.645, 7, 1);
model.geom('geom1').run('pol1');
model.geom('geom1').create('r1', 'Rectangle');
model.geom('geom1').feature('r1').set('size', [120 2]);
model.geom('geom1').feature('r1').set('pos', [0 2]);
model.geom('geom1').run('r1');
model.geom('geom1').create('r2', 'Rectangle');
model.geom('geom1').feature('r2').set('size', [70 2]);
model.geom('geom1').feature('r2').set('pos', [180 2]);
model.geom('geom1').runPre('fin');

model.view.create('view2', 'geom1');
model.view('view2').model('comp1');
model.view('view2').axis.set('viewscaletype', 'automatic');

model.geom('geom1').run;

model.physics('dl').feature('porous1').feature('pm1').set('permeabilityModelType', 'conductivity');
model.physics('dl').feature('porous1').feature('pm1').set('K', {'5e-4[cm/s]' '0' '0' '0' '5e-4[cm/s]' '0' '0' '0' '5e-4[cm/s]'});
model.physics('dl').feature.duplicate('porous2', 'porous1');
model.physics('dl').feature('porous2').selection.set([2 3]);
model.physics('dl').feature('porous2').feature('pm1').set('K', {'1e-2[cm/s]' '0' '0' '0' '1e-2[cm/s]' '0' '0' '0' '1e-2[cm/s]'});
model.physics('dl').create('inl1', 'Inlet', 1);
model.physics('dl').feature('inl1').selection.set([7 8 10 11 15]);
model.physics('dl').feature('inl1').set('U0in', '10[cm/a]');
model.physics('dl').create('hh1', 'HydraulicHead', 1);
model.physics('dl').feature('hh1').selection.set([16 17 18]);
model.physics('dl').feature('hh1').set('H0', 5.3486);
model.physics('dl').create('sym1', 'Symmetry', 1);
model.physics('dl').feature('sym1').selection.set([1 3 5]);
model.physics('tds').feature('porous1').feature('fluid1').set('u_src', 'root.comp1.dl.u');
model.physics('tds').feature('porous1').feature('fluid1').set('DF_c', {'1.34e-5[cm^2/s]' '0' '0' '0' '1.34e-5[cm^2/s]' '0' '0' '0' '1.34e-5[cm^2/s]'});
model.physics('tds').feature('porous1').create('disp1', 'Dispersion', 2);
model.physics('tds').feature('porous1').feature('disp1').set('DispersionTensor', 'Dispersivity');
model.physics('tds').feature('porous1').feature('disp1').set('alphaL', 0.5);
model.physics('tds').feature('porous1').feature('disp1').set('alphaT', 0.005);

model.func.create('rect1', 'Rectangle');
model.func('rect1').model('comp1');
model.func('rect1').set('lower', 40);
model.func('rect1').set('upper', 80);

model.physics('tds').create('conc1', 'Concentration', 1);
model.physics('tds').feature('conc1').selection.set([7 8 10 11 15]);
model.physics('tds').feature('conc1').setIndex('species', true, 0);
model.physics('tds').feature('conc1').setIndex('c0', 'rect1(x[1/m])*(t<=5[a])', 0);
model.physics('tds').create('conc2', 'Concentration', 1);
model.physics('tds').feature('conc2').selection.set([1 3 5]);
model.physics('tds').feature('conc2').setIndex('species', true, 0);
model.physics('tds').create('out1', 'Outflow', 1);
model.physics('tds').feature('out1').selection.set([2 16 17 18]);

model.material.create('mat1', 'Common', 'comp1');
model.material('mat1').propertyGroup('def').set('density', {'1000'});
model.material('mat1').propertyGroup('def').set('porosity', {'0.35'});

model.mesh('mesh1').autoMeshSize(1);
model.mesh('mesh1').automatic(false);
model.mesh('mesh1').feature('size').set('custom', true);
model.mesh('mesh1').feature('size').set('hmax', 0.5);
model.mesh('mesh1').run;

model.study('std1').feature('stat').setEntry('activate', 'tds', false);
model.study('std1').create('time', 'Transient');
model.study('std1').feature('time').setEntry('activate', 'dl', false);
model.study('std1').feature('time').set('tunit', 'a');
model.study('std1').feature('time').set('tlist', 'range(0,1,20)');

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
model.sol('sol1').feature('v2').set('notsoluse', 'sol2');
model.sol('sol1').feature('v2').set('control', 'time');
model.sol('sol1').create('t1', 'Time');
model.sol('sol1').feature('t1').set('tlist', 'range(0,1,20)');
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
model.sol('sol1').feature('t1').set('tstepsbdf', 'strict');
model.sol('sol1').runAll;

model.result.create('pg1', 'PlotGroup2D');
model.result('pg1').label('Pressure (dl)');
model.result('pg1').set('titletype', 'custom');
model.result('pg1').set('data', 'dset1');
model.result('pg1').setIndex('looplevel', 21, 0);
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
model.result('pg1').feature('str1').selection.set([1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18]);
model.result.create('pg2', 'PlotGroup2D');
model.result('pg2').set('data', 'dset1');
model.result('pg2').setIndex('looplevel', 21, 0);
model.result('pg2').label('Concentration (tds)');
model.result('pg2').set('titletype', 'custom');
model.result('pg2').set('prefixintitle', '');
model.result('pg2').set('expressionintitle', false);
model.result('pg2').set('typeintitle', true);
model.result('pg2').create('surf1', 'Surface');
model.result('pg2').feature('surf1').set('expr', {'c'});
model.result('pg2').create('str1', 'Streamline');
model.result('pg2').feature('str1').set('expr', {'tds.tflux_cx' 'tds.tflux_cy'});
model.result('pg2').feature('str1').set('posmethod', 'uniform');
model.result('pg2').feature('str1').set('recover', 'pprint');
model.result('pg2').feature('str1').set('pointtype', 'arrow');
model.result('pg2').feature('str1').set('arrowlength', 'logarithmic');
model.result('pg2').feature('str1').set('color', 'gray');
model.result('pg1').run;
model.result('pg1').label('Hydraulic Head');
model.result('pg1').run;
model.result('pg1').feature('surf1').set('expr', 'dl.H');
model.result('pg1').run;
model.result('pg1').feature('str1').set('posmethod', 'selection');
model.result('pg1').feature('str1').selection.set([7 8 10 11 15]);
model.result('pg1').feature('str1').set('selnumber', 15);
model.result('pg1').feature('str1').set('arrowlength', 'normalized');
model.result('pg1').feature('str1').set('arrowscaleactive', true);
model.result('pg1').feature('str1').set('arrowscale', '3e7');
model.result('pg1').run;
model.result.create('pg3', 'PlotGroup2D');
model.result('pg3').run;
model.result('pg3').label('Concentration Contours');
model.result('pg3').create('con1', 'Contour');
model.result('pg3').feature('con1').set('expr', 'c');
model.result('pg3').feature('con1').set('number', 10);
model.result('pg3').feature('con1').set('contourtype', 'filled');
model.result('pg3').feature('con1').set('colortable', 'Cividis');
model.result('pg3').run;
model.result('pg3').setIndex('looplevel', 13, 0);
model.result('pg3').run;
model.result('pg3').setIndex('looplevel', 9, 0);
model.result('pg3').run;
model.result('pg3').setIndex('looplevel', 21, 0);
model.result('pg3').run;

model.title('Aquifer Water Table Calculation');

model.description('This model demonstrates the application of COMSOL Multiphysics to a benchmark case of steady-state subsurface fluid flow and transient solute transport along a vertical cross section in an unconfined aquifer. Solute transport is subjected to highly irregular flow conditions with strong anisotropic dispersion.');

model.mesh.clearMeshes;

model.sol('sol1').clearSolutionData;
model.sol('sol2').clearSolutionData;

model.label('aquifer_water_table.mph');

model.modelNode.label('Components');

out = model;
