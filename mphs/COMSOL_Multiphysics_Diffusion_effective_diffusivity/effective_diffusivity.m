function out = model
%
% effective_diffusivity.m
%
% Model exported on May 26 2025, 21:26 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/COMSOL_Multiphysics/Diffusion');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 2);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.physics.create('tds', 'DilutedSpecies', 'geom1', {'c'});

model.study.create('std1');
model.study('std1').create('time', 'Transient');
model.study('std1').feature('time').setSolveFor('/physics/tds', true);

model.geom('geom1').insertFile('effective_diffusivity_geom_sequence.mph', 'geom1');
model.geom('geom1').run('sel3');

model.param.set('D2', '1e-5[m^2/s]');
model.param.descr('D2', 'Diffusion coefficient');
model.param.set('c_max', '3[mol/m^3]');
model.param.descr('c_max', 'Peak initial concentration');
model.param.set('k_f', '5[m/s]');
model.param.descr('k_f', 'Mass transfer coefficient');
model.param.set('a', '1000');
model.param.descr('a', 'Dimensionless constant');

model.variable.create('var1');
model.variable('var1').set('c0', 'c_max*exp(a*(-(x/0.4[mm])^2))');
model.variable('var1').descr('c0', 'Initial concentration');

model.physics('tds').prop('TransportMechanism').set('Convection', false);
model.physics('tds').feature('cdm1').set('D_c', {'D2' '0' '0' '0' 'D2' '0' '0' '0' 'D2'});
model.physics('tds').feature('init1').setIndex('initc', 'c0', 0);
model.physics('tds').create('conc1', 'Concentration', 1);
model.physics('tds').feature('conc1').selection.named('geom1_sel2');
model.physics('tds').feature('conc1').setIndex('species', true, 0);
model.physics('tds').feature('conc1').setIndex('c0', 'c_max', 0);
model.physics('tds').create('fl1', 'FluxBoundary', 1);
model.physics('tds').feature('fl1').selection.named('geom1_sel3');
model.physics('tds').feature('fl1').set('FluxType', 'ExternalConvection');
model.physics('tds').feature('fl1').setIndex('species', true, 0);
model.physics('tds').feature('fl1').setIndex('kc', 'k_f', 0);

model.cpl.create('aveop1', 'Average', 'geom1');
model.cpl('aveop1').set('axisym', true);
model.cpl('aveop1').selection.geom('geom1', 1);
model.cpl('aveop1').selection.named('geom1_sel3');

model.variable.create('var2');
model.variable('var2').model('comp1');
model.variable('var2').set('flux_avg', 'aveop1(k_f*c)');
model.variable('var2').descr('flux_avg', 'Average flux');

model.mesh('mesh1').run;

model.study('std1').feature('time').set('tunit', 'ms');
model.study('std1').feature('time').set('tlist', 'range(0,2,100)');

model.sol.create('sol1');

model.mesh('mesh1').stat.selection.geom(2);
model.mesh('mesh1').stat.selection.set([1]);

model.sol('sol1').study('std1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'time');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').set('control', 'time');
model.sol('sol1').create('t1', 'Time');
model.sol('sol1').feature('t1').set('tlist', 'range(0,2,100)');
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
model.result('pg1').set('data', 'dset1');
model.result('pg1').setIndex('looplevel', 51, 0);
model.result('pg1').label('Concentration (tds)');
model.result('pg1').set('titletype', 'custom');
model.result('pg1').set('prefixintitle', '');
model.result('pg1').set('expressionintitle', false);
model.result('pg1').set('typeintitle', true);
model.result('pg1').create('surf1', 'Surface');
model.result('pg1').feature('surf1').set('expr', {'c'});
model.result('pg1').create('str1', 'Streamline');
model.result('pg1').feature('str1').set('expr', {'tds.tflux_cx' 'tds.tflux_cy'});
model.result('pg1').feature('str1').set('posmethod', 'uniform');
model.result('pg1').feature('str1').set('recover', 'pprint');
model.result('pg1').feature('str1').set('pointtype', 'arrow');
model.result('pg1').feature('str1').set('arrowlength', 'logarithmic');
model.result('pg1').feature('str1').set('color', 'gray');
model.result('pg1').run;
model.result('pg1').run;
model.result('pg1').feature('str1').set('posmethod', 'selection');
model.result('pg1').feature('str1').selection.set([1]);
model.result('pg1').feature('str1').set('selnumber', 40);
model.result('pg1').run;
model.result('pg1').run;
model.result('pg1').setIndex('looplevel', 26, 0);
model.result('pg1').run;
model.result.create('pg2', 'PlotGroup1D');
model.result('pg2').run;
model.result('pg2').create('ptgr1', 'PointGraph');
model.result('pg2').feature('ptgr1').set('markerpos', 'datapoints');
model.result('pg2').feature('ptgr1').set('linewidth', 'preference');
model.result('pg2').feature('ptgr1').selection.named('geom1_sel1');
model.result('pg2').feature('ptgr1').set('expr', 'flux_avg');
model.result('pg2').feature('ptgr1').set('descr', 'Average flux');
model.result('pg2').run;
model.result('pg2').label('Molar fluxes');
model.result('pg2').set('titletype', 'none');
model.result('pg2').set('ylabelactive', true);
model.result('pg2').set('ylabel', 'Average flux (mol/(m*s))');
model.result('pg2').run;
model.result.numerical.create('int1', 'IntSurface');
model.result.numerical('int1').set('intvolume', true);
model.result.numerical('int1').selection.all;
model.result.numerical('int1').setIndex('expr', '1/(0.8[mm])^2', 0);
model.result.table.create('tbl1', 'Table');
model.result.table('tbl1').comments('Surface Integration 1');
model.result.numerical('int1').set('table', 'tbl1');
model.result.numerical('int1').setResult;

model.modelNode.create('comp2', true);

model.geom.create('geom2', 1);
model.geom('geom2').model('comp2');

model.mesh.create('mesh2', 'geom2');

model.physics.create('tds2', 'DilutedSpecies', 'geom2', {'c2'});

model.study('std1').feature('time').setSolveFor('/physics/tds2', false);

model.geom('geom2').run;

model.study.create('std2');
model.study('std2').create('time', 'Transient');
model.study('std2').feature('time').setSolveFor('/physics/tds', false);
model.study('std2').feature('time').setSolveFor('/physics/tds2', true);

model.geom('geom2').create('i1', 'Interval');
model.geom('geom2').feature('i1').setIndex('coord', '8e-4', 1);
model.geom('geom2').run('i1');

model.param.set('epsilon', '0.383');
model.param.descr('epsilon', 'Porosity');
model.param.set('D1', '2.15e-6[m^2/s]');
model.param.descr('D1', 'Diffusion coefficient, 1D');

model.geom('geom2').run;

model.physics('tds2').prop('TransportMechanism').set('Convection', false);
model.physics('tds2').feature('cdm1').set('D_c2', {'D1/epsilon' '0' '0' '0' 'D1/epsilon' '0' '0' '0' 'D1/epsilon'});
model.physics('tds2').feature('init1').setIndex('initc', 'c0', 0);
model.physics('tds2').create('conc1', 'Concentration', 0);
model.physics('tds2').feature('conc1').selection.set([1]);
model.physics('tds2').feature('conc1').setIndex('species', true, 0);
model.physics('tds2').feature('conc1').setIndex('c0', 'c_max', 0);
model.physics('tds2').create('fl1', 'FluxBoundary', 0);
model.physics('tds2').feature('fl1').selection.set([2]);
model.physics('tds2').feature('fl1').set('FluxType', 'ExternalConvection');
model.physics('tds2').feature('fl1').setIndex('species', true, 0);
model.physics('tds2').feature('fl1').setIndex('kc', 'k_f/epsilon', 0);

model.variable.create('var3');
model.variable('var3').model('comp2');
model.variable('var3').set('flux_hom', 'k_f*c2');
model.variable('var3').descr('flux_hom', 'Flux, 1D model');

model.mesh('mesh2').autoMeshSize(2);
model.mesh('mesh2').run;

model.study('std2').feature('time').set('tunit', 'ms');
model.study('std2').feature('time').set('tlist', 'range(0,2,100)');

model.sol.create('sol2');

model.mesh('mesh2').stat.selection.geom(1);
model.mesh('mesh2').stat.selection.set([1]);

model.sol('sol2').study('std2');
model.sol('sol2').create('st1', 'StudyStep');
model.sol('sol2').feature('st1').set('study', 'std2');
model.sol('sol2').feature('st1').set('studystep', 'time');
model.sol('sol2').create('v1', 'Variables');
model.sol('sol2').feature('v1').set('control', 'time');
model.sol('sol2').create('t1', 'Time');
model.sol('sol2').feature('t1').set('tlist', 'range(0,2,100)');
model.sol('sol2').feature('t1').set('plot', 'off');
model.sol('sol2').feature('t1').set('plotgroup', 'pg1');
model.sol('sol2').feature('t1').set('plotfreq', 'tout');
model.sol('sol2').feature('t1').set('probesel', 'all');
model.sol('sol2').feature('t1').set('probes', {});
model.sol('sol2').feature('t1').set('probefreq', 'tsteps');
model.sol('sol2').feature('t1').set('rtol', 0.005);
model.sol('sol2').feature('t1').set('atolglobalvaluemethod', 'factor');
model.sol('sol2').feature('t1').set('reacf', true);
model.sol('sol2').feature('t1').set('storeudot', true);
model.sol('sol2').feature('t1').set('endtimeinterpolation', true);
model.sol('sol2').feature('t1').set('maxorder', 2);
model.sol('sol2').feature('t1').set('stabcntrl', true);
model.sol('sol2').feature('t1').set('control', 'time');
model.sol('sol2').feature('t1').feature('aDef').set('cachepattern', true);
model.sol('sol2').feature('t1').create('fc1', 'FullyCoupled');
model.sol('sol2').feature('t1').feature('fc1').set('jtech', 'once');
model.sol('sol2').feature('t1').feature('fc1').set('damp', 0.9);
model.sol('sol2').feature('t1').feature('fc1').set('maxiter', 8);
model.sol('sol2').feature('t1').feature('fc1').set('stabacc', 'aacc');
model.sol('sol2').feature('t1').feature('fc1').set('aaccdim', 5);
model.sol('sol2').feature('t1').feature('fc1').set('aaccmix', 0.9);
model.sol('sol2').feature('t1').feature('fc1').set('aaccdelay', 1);
model.sol('sol2').feature('t1').create('d1', 'Direct');
model.sol('sol2').feature('t1').feature('d1').set('linsolver', 'pardiso');
model.sol('sol2').feature('t1').feature('d1').set('pivotperturb', 1.0E-13);
model.sol('sol2').feature('t1').feature('d1').label('Direct, concentrations (tds2)');
model.sol('sol2').feature('t1').create('i1', 'Iterative');
model.sol('sol2').feature('t1').feature('i1').set('linsolver', 'gmres');
model.sol('sol2').feature('t1').feature('i1').set('prefuntype', 'left');
model.sol('sol2').feature('t1').feature('i1').set('itrestart', 50);
model.sol('sol2').feature('t1').feature('i1').set('rhob', 400);
model.sol('sol2').feature('t1').feature('i1').set('maxlinit', 50);
model.sol('sol2').feature('t1').feature('i1').set('nlinnormuse', 'on');
model.sol('sol2').feature('t1').feature('i1').label('AMG, concentrations (tds2)');
model.sol('sol2').feature('t1').feature('i1').create('mg1', 'Multigrid');
model.sol('sol2').feature('t1').feature('i1').feature('mg1').set('prefun', 'saamg');
model.sol('sol2').feature('t1').feature('i1').feature('mg1').set('mgcycle', 'v');
model.sol('sol2').feature('t1').feature('i1').feature('mg1').set('maxcoarsedof', 50000);
model.sol('sol2').feature('t1').feature('i1').feature('mg1').set('strconn', 0.01);
model.sol('sol2').feature('t1').feature('i1').feature('mg1').set('nullspace', 'constant');
model.sol('sol2').feature('t1').feature('i1').feature('mg1').set('usesmooth', false);
model.sol('sol2').feature('t1').feature('i1').feature('mg1').set('saamgcompwise', true);
model.sol('sol2').feature('t1').feature('i1').feature('mg1').set('loweramg', true);
model.sol('sol2').feature('t1').feature('i1').feature('mg1').set('compactaggregation', false);
model.sol('sol2').feature('t1').feature('i1').feature('mg1').feature('pr').create('sl1', 'SORLine');
model.sol('sol2').feature('t1').feature('i1').feature('mg1').feature('pr').feature('sl1').set('linesweeptype', 'ssor');
model.sol('sol2').feature('t1').feature('i1').feature('mg1').feature('pr').feature('sl1').set('iter', 1);
model.sol('sol2').feature('t1').feature('i1').feature('mg1').feature('pr').feature('sl1').set('linerelax', 0.7);
model.sol('sol2').feature('t1').feature('i1').feature('mg1').feature('pr').feature('sl1').set('linealgorithm', 'mesh');
model.sol('sol2').feature('t1').feature('i1').feature('mg1').feature('pr').feature('sl1').set('linemethod', 'coupled');
model.sol('sol2').feature('t1').feature('i1').feature('mg1').feature('pr').feature('sl1').set('seconditer', 1);
model.sol('sol2').feature('t1').feature('i1').feature('mg1').feature('pr').feature('sl1').set('relax', 0.5);
model.sol('sol2').feature('t1').feature('i1').feature('mg1').feature('po').create('sl1', 'SORLine');
model.sol('sol2').feature('t1').feature('i1').feature('mg1').feature('po').feature('sl1').set('linesweeptype', 'ssor');
model.sol('sol2').feature('t1').feature('i1').feature('mg1').feature('po').feature('sl1').set('iter', 1);
model.sol('sol2').feature('t1').feature('i1').feature('mg1').feature('po').feature('sl1').set('linerelax', 0.7);
model.sol('sol2').feature('t1').feature('i1').feature('mg1').feature('po').feature('sl1').set('linealgorithm', 'mesh');
model.sol('sol2').feature('t1').feature('i1').feature('mg1').feature('po').feature('sl1').set('linemethod', 'coupled');
model.sol('sol2').feature('t1').feature('i1').feature('mg1').feature('po').feature('sl1').set('seconditer', 1);
model.sol('sol2').feature('t1').feature('i1').feature('mg1').feature('po').feature('sl1').set('relax', 0.5);
model.sol('sol2').feature('t1').feature('i1').feature('mg1').feature('cs').create('d1', 'Direct');
model.sol('sol2').feature('t1').feature('i1').feature('mg1').feature('cs').feature('d1').set('linsolver', 'pardiso');
model.sol('sol2').feature('t1').feature('i1').feature('mg1').feature('cs').feature('d1').set('pivotperturb', 1.0E-13);
model.sol('sol2').feature('t1').feature('fc1').set('linsolver', 'd1');
model.sol('sol2').feature('t1').feature('fc1').set('jtech', 'once');
model.sol('sol2').feature('t1').feature('fc1').set('damp', 0.9);
model.sol('sol2').feature('t1').feature('fc1').set('maxiter', 8);
model.sol('sol2').feature('t1').feature('fc1').set('stabacc', 'aacc');
model.sol('sol2').feature('t1').feature('fc1').set('aaccdim', 5);
model.sol('sol2').feature('t1').feature('fc1').set('aaccmix', 0.9);
model.sol('sol2').feature('t1').feature('fc1').set('aaccdelay', 1);
model.sol('sol2').feature('t1').feature.remove('fcDef');
model.sol('sol2').attach('std2');
model.sol('sol2').runAll;

model.result.create('pg3', 'PlotGroup1D');
model.result('pg3').set('data', 'dset3');
model.result('pg3').label('Concentration (tds2)');
model.result('pg3').set('titletype', 'custom');
model.result('pg3').set('prefixintitle', '');
model.result('pg3').set('expressionintitle', false);
model.result('pg3').set('typeintitle', false);
model.result('pg3').create('lngr1', 'LineGraph');
model.result('pg3').feature('lngr1').set('xdata', 'expr');
model.result('pg3').feature('lngr1').set('xdataexpr', 'x');
model.result('pg3').feature('lngr1').selection.geom('geom2', 1);
model.result('pg3').feature('lngr1').selection.set([1]);
model.result('pg3').feature('lngr1').set('expr', {'c2'});
model.result('pg3').run;
model.result('pg2').run;
model.result('pg2').create('ptgr2', 'PointGraph');
model.result('pg2').feature('ptgr2').set('markerpos', 'datapoints');
model.result('pg2').feature('ptgr2').set('linewidth', 'preference');
model.result('pg2').feature('ptgr2').set('data', 'dset3');
model.result('pg2').feature('ptgr2').selection.set([2]);
model.result('pg2').feature('ptgr2').set('expr', 'flux_hom');
model.result('pg2').feature('ptgr2').set('descr', 'Flux, 1D model');
model.result('pg2').feature('ptgr2').set('linestyle', 'dashed');
model.result('pg2').run;
model.result('pg1').run;

model.title('Effective Diffusivity in Porous Materials');

model.description('This example introduces the concept of effective diffusivity in porous media by comparing the transport through an artificial porous structure, described in a detailed model, with a simplified homogeneous porous-medium approach using effective transport properties.');

model.mesh.clearMeshes;

model.sol('sol1').clearSolutionData;
model.sol('sol2').clearSolutionData;

model.label('effective_diffusivity.mph');

model.modelNode.label('Components');

out = model;
