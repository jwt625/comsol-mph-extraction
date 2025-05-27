function out = model
%
% thin_layer_chronoamperometry.m
%
% Model exported on May 26 2025, 21:28 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/Electrochemistry_Module/Electroanalysis');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 1);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.physics.create('tcd', 'TertiaryElectroanalysis', 'geom1', {'c'});

model.study.create('std1');
model.study('std1').create('time', 'Transient');
model.study('std1').feature('time').setSolveFor('/physics/tcd', true);

% To import content from file, use:
% model.param.loadFile('FILENAME');
model.param.set('c_bulk', '1[mol/m^3]', 'Bulk concentration of reactant');
model.param.set('L', '60[um]', 'Thin layer cell thickness');
model.param.set('A_el', '1[mm^2]', 'Electrode area');
model.param.set('D', '1e-9[m^2/s]', 'Diffusion coefficient');
model.param.set('t_rise', '1[us]', 'Potentiostatic rise time');
model.param.set('x_step', 'sqrt(2*t_rise*D)', 'Resolved diffusion layer thickness');

model.geom('geom1').create('i1', 'Interval');
model.geom('geom1').feature('i1').setIndex('coord', 'L', 1);
model.geom('geom1').run('fin');

model.func.create('step1', 'Step');
model.func('step1').model('comp1');
model.func('step1').set('location', 0.5);
model.func('step1').set('smooth', 1);

model.variable.create('var1');
model.variable('var1').model('comp1');
model.variable('var1').set('i_el', '-F_const*A_el*tcd.tflux_cx');
model.variable('var1').descr('i_el', 'Total Current');
model.variable('var1').set('i_Cottrell', 'F_const*A_el*c_bulk*sqrt(D/(pi*t+eps))');
model.variable('var1').descr('i_Cottrell', 'Cottrell equation current');

model.physics('tcd').feature('ice1').set('D_c', {'D' '0' '0' '0' 'D' '0' '0' '0' 'D'});
model.physics('tcd').feature('init1').setIndex('initc', 'c_bulk', 0);
model.physics('tcd').create('conc1', 'Concentration', 0);
model.physics('tcd').feature('conc1').selection.set([1]);
model.physics('tcd').feature('conc1').setIndex('species', true, 0);
model.physics('tcd').feature('conc1').setIndex('c0', 'c_bulk*(1-step1(t/t_rise))', 0);

model.mesh('mesh1').automatic(false);
model.mesh('mesh1').feature('size').set('hauto', 2);
model.mesh('mesh1').feature('edg1').create('size1', 'Size');
model.mesh('mesh1').feature('edg1').feature('size1').selection.geom('geom1', 0);
model.mesh('mesh1').feature('edg1').feature('size1').selection.set([1]);
model.mesh('mesh1').feature('edg1').feature('size1').set('custom', true);
model.mesh('mesh1').feature('edg1').feature('size1').set('hmaxactive', true);
model.mesh('mesh1').feature('edg1').feature('size1').set('hmax', 'x_step/5');
model.mesh('mesh1').run('edg1');

model.study('std1').feature('time').set('tlist', 'range(0,0.1,5)');

model.sol.create('sol1');
model.sol('sol1').study('std1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'time');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').set('control', 'time');
model.sol('sol1').create('t1', 'Time');
model.sol('sol1').feature('t1').set('tlist', 'range(0,0.1,5)');
model.sol('sol1').feature('t1').set('plot', 'off');
model.sol('sol1').feature('t1').set('plotgroup', 'Default');
model.sol('sol1').feature('t1').set('plotfreq', 'tout');
model.sol('sol1').feature('t1').set('probesel', 'all');
model.sol('sol1').feature('t1').set('probes', {});
model.sol('sol1').feature('t1').set('probefreq', 'tsteps');
model.sol('sol1').feature('t1').set('tout', 'tsteps');
model.sol('sol1').feature('t1').set('rtol', 0.001);
model.sol('sol1').feature('t1').set('atolglobalvaluemethod', 'factor');
model.sol('sol1').feature('t1').set('eventout', true);
model.sol('sol1').feature('t1').set('reacf', true);
model.sol('sol1').feature('t1').set('storeudot', true);
model.sol('sol1').feature('t1').set('endtimeinterpolation', true);
model.sol('sol1').feature('t1').set('maxorder', 2);
model.sol('sol1').feature('t1').set('control', 'time');
model.sol('sol1').feature('t1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('t1').feature('fc1').set('dtech', 'const');
model.sol('sol1').feature('t1').feature('fc1').set('jtech', 'once');
model.sol('sol1').feature('t1').feature('fc1').set('damp', 1);
model.sol('sol1').feature('t1').feature('fc1').set('stabacc', 'aacc');
model.sol('sol1').feature('t1').feature('fc1').set('aaccdim', 5);
model.sol('sol1').feature('t1').feature('fc1').set('aaccmix', 0.9);
model.sol('sol1').feature('t1').feature('fc1').set('aaccdelay', 1);
model.sol('sol1').feature('t1').create('d1', 'Direct');
model.sol('sol1').feature('t1').feature('d1').set('linsolver', 'pardiso');
model.sol('sol1').feature('t1').feature('d1').label('Direct (tcd)');
model.sol('sol1').feature('t1').create('i1', 'Iterative');
model.sol('sol1').feature('t1').feature('i1').set('maxlinit', 1000);
model.sol('sol1').feature('t1').feature('i1').set('nlinnormuse', 'on');
model.sol('sol1').feature('t1').feature('i1').label('Algebraic Multigrid (tcd)');
model.sol('sol1').feature('t1').feature('i1').create('mg1', 'Multigrid');
model.sol('sol1').feature('t1').feature('i1').feature('mg1').set('prefun', 'saamg');
model.sol('sol1').feature('t1').feature('i1').feature('mg1').set('maxcoarsedof', 50000);
model.sol('sol1').feature('t1').feature('i1').feature('mg1').set('saamgcompwise', true);
model.sol('sol1').feature('t1').feature('i1').feature('mg1').set('compactaggregation', true);
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('pr').create('sc1', 'SCGS');
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('pr').feature('sc1').set('linesweeptype', 'ssor');
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('pr').feature('sc1').set('iter', 1);
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('pr').feature('sc1').set('scgsmethod', 'lines');
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('po').create('sc1', 'SCGS');
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('po').feature('sc1').set('linesweeptype', 'ssor');
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('po').feature('sc1').set('iter', 1);
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('po').feature('sc1').set('scgsmethod', 'lines');
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('cs').create('d1', 'Direct');
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('cs').feature('d1').set('linsolver', 'pardiso');
model.sol('sol1').feature('t1').create('i2', 'Iterative');
model.sol('sol1').feature('t1').feature('i2').set('maxlinit', 1000);
model.sol('sol1').feature('t1').feature('i2').set('nlinnormuse', 'on');
model.sol('sol1').feature('t1').feature('i2').label('Geometric Multigrid (tcd)');
model.sol('sol1').feature('t1').feature('i2').create('mg1', 'Multigrid');
model.sol('sol1').feature('t1').feature('i2').feature('mg1').feature('pr').create('sc1', 'SCGS');
model.sol('sol1').feature('t1').feature('i2').feature('mg1').feature('pr').feature('sc1').set('linesweeptype', 'ssor');
model.sol('sol1').feature('t1').feature('i2').feature('mg1').feature('pr').feature('sc1').set('iter', 1);
model.sol('sol1').feature('t1').feature('i2').feature('mg1').feature('pr').feature('sc1').set('scgsmethod', 'lines');
model.sol('sol1').feature('t1').feature('i2').feature('mg1').feature('po').create('sc1', 'SCGS');
model.sol('sol1').feature('t1').feature('i2').feature('mg1').feature('po').feature('sc1').set('linesweeptype', 'ssor');
model.sol('sol1').feature('t1').feature('i2').feature('mg1').feature('po').feature('sc1').set('iter', 1);
model.sol('sol1').feature('t1').feature('i2').feature('mg1').feature('po').feature('sc1').set('scgsmethod', 'lines');
model.sol('sol1').feature('t1').feature('i2').feature('mg1').feature('cs').create('d1', 'Direct');
model.sol('sol1').feature('t1').feature('i2').feature('mg1').feature('cs').feature('d1').set('linsolver', 'pardiso');
model.sol('sol1').feature('t1').feature('fc1').set('linsolver', 'd1');
model.sol('sol1').feature('t1').feature('fc1').set('dtech', 'const');
model.sol('sol1').feature('t1').feature('fc1').set('jtech', 'once');
model.sol('sol1').feature('t1').feature('fc1').set('damp', 1);
model.sol('sol1').feature('t1').feature('fc1').set('stabacc', 'aacc');
model.sol('sol1').feature('t1').feature('fc1').set('aaccdim', 5);
model.sol('sol1').feature('t1').feature('fc1').set('aaccmix', 0.9);
model.sol('sol1').feature('t1').feature('fc1').set('aaccdelay', 1);
model.sol('sol1').feature('t1').feature.remove('fcDef');
model.sol('sol1').attach('std1');
model.sol('sol1').feature('t1').set('initialstepbdfactive', true);
model.sol('sol1').feature('t1').set('initialstepbdf', '1e-7');
model.sol('sol1').runAll;

model.result.create('pg1', 'PlotGroup1D');
model.result('pg1').set('data', 'dset1');
model.result('pg1').label('Concentration (tcd)');
model.result('pg1').set('titletype', 'custom');
model.result('pg1').set('prefixintitle', '');
model.result('pg1').set('expressionintitle', false);
model.result('pg1').set('typeintitle', false);
model.result('pg1').create('lngr1', 'LineGraph');
model.result('pg1').feature('lngr1').set('xdata', 'expr');
model.result('pg1').feature('lngr1').set('xdataexpr', 'x');
model.result('pg1').feature('lngr1').selection.geom('geom1', 1);
model.result('pg1').feature('lngr1').selection.set([1]);
model.result('pg1').feature('lngr1').set('expr', {'c'});
model.result('pg1').run;
model.result.create('pg2', 'PlotGroup1D');
model.result('pg2').run;
model.result('pg2').create('ptgr1', 'PointGraph');
model.result('pg2').feature('ptgr1').set('markerpos', 'datapoints');
model.result('pg2').feature('ptgr1').set('linewidth', 'preference');
model.result('pg2').feature('ptgr1').selection.set([1]);
model.result('pg2').feature('ptgr1').set('expr', 'i_el');
model.result('pg2').run;
model.result('pg2').label('Chronoamperogram');
model.result('pg2').set('axislimits', true);
model.result('pg2').set('xmin', 0.1);
model.result('pg2').set('xmax', 5);
model.result('pg2').set('ymin', 0);
model.result('pg2').set('ymax', '5e-6');
model.result('pg2').run;
model.result.duplicate('pg3', 'pg2');
model.result('pg3').run;
model.result('pg3').label('Comparison to Cottrell equation');
model.result('pg3').create('glob1', 'Global');
model.result('pg3').feature('glob1').set('markerpos', 'datapoints');
model.result('pg3').feature('glob1').set('linewidth', 'preference');
model.result('pg3').feature('glob1').setIndex('expr', 'i_Cottrell', 0);
model.result('pg3').run;
model.result('pg3').set('axislimits', false);
model.result('pg3').set('xlog', true);
model.result('pg3').set('ylog', true);
model.result('pg3').run;
model.result('pg3').set('axislimits', true);
model.result('pg3').set('xmin', '1e-5');
model.result('pg3').run;
model.result.numerical.create('av1', 'AvLine');
model.result.numerical('av1').set('intsurface', true);
model.result.numerical('av1').selection.set([1]);
model.result.numerical('av1').setIndex('expr', '(c_bulk-c)/c_bulk', 0);
model.result.numerical('av1').setIndex('descr', 'Extent of reaction', 0);
model.result.table.create('tbl1', 'Table');
model.result.table('tbl1').comments('Line Average 1');
model.result.numerical('av1').set('table', 'tbl1');
model.result.numerical('av1').setResult;
model.result.create('pg4', 'PlotGroup1D');
model.result('pg4').set('data', 'none');
model.result('pg4').create('tblp1', 'Table');
model.result('pg4').feature('tblp1').set('source', 'table');
model.result('pg4').feature('tblp1').set('table', 'tbl1');
model.result('pg4').feature('tblp1').set('linewidth', 'preference');
model.result('pg4').feature('tblp1').set('markerpos', 'datapoints');
model.result('pg4').run;
model.result('pg4').run;
model.result('pg4').label('Extent of reaction');

model.title('Thin Layer Chronoamperometry');

model.description('The common electroanalytical method of exhaustive amperometric detection in a microscopic thin layer is modeled as a 1D-symmetric diffusion problem. The simulated result agrees with the analytical Cottrell equation at short times, and deviates as expected at long times when the diffusion layer spans the thin layer cell.');

model.label('thin_layer_chronoamperometry.mph');

model.modelNode.label('Components');

out = model;
