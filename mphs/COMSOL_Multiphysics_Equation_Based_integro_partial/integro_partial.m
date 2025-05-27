function out = model
%
% integro_partial.m
%
% Model exported on May 26 2025, 21:26 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/COMSOL_Multiphysics/Equation_Based');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 1);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.physics.create('ht', 'HeatTransfer', 'geom1');
model.physics('ht').model('comp1');

model.study.create('std1');
model.study('std1').create('time', 'Transient');
model.study('std1').feature('time').setSolveFor('/physics/ht', true);

model.param.set('epsilon', '1');
model.param.descr('epsilon', 'Emissivity');
model.param.set('T_cold', '300[K]');
model.param.descr('T_cold', 'Temperature, cold end');
model.param.set('DT_max', '1200[K]');
model.param.descr('DT_max', 'Maximum temperature difference');
model.param.set('T_init', 'T_cold');
model.param.descr('T_init', 'Initial temperature');
model.param.set('D_i', '1[in]');
model.param.descr('D_i', 'Inner diameter');
model.param.set('D_o', '1.1*D_i');
model.param.descr('D_o', 'Outer diameter');
model.param.set('L', '0.2[m]');
model.param.descr('L', 'Length');

model.geom('geom1').create('i1', 'Interval');
model.geom('geom1').feature('i1').setIndex('coord', 'L', 1);
model.geom('geom1').runPre('fin');

model.cpl.create('intop1', 'Integration', 'geom1');

model.geom('geom1').run;

model.cpl('intop1').set('axisym', true);
model.cpl('intop1').selection.all;

model.variable.create('var1');
model.variable('var1').model('comp1');
model.variable('var1').selection.geom('geom1', 1);
model.variable('var1').selection.all;
model.variable('var1').set('xi', 'abs(dest(x)-x)/D_i');
model.variable('var1').descr('xi', '');
model.variable('var1').set('k', '1-(2*xi^3+3*xi)/(2*(xi^2+1)^1.5)');
model.variable('var1').descr('k', 'Integral kernel');
model.variable('var1').set('Q_source', '4/(D_o^2-D_i^2)*epsilon*sigma_const*intop1(k*T^4)');
model.variable('var1').descr('Q_source', 'Heat source');
model.variable('var1').set('Q_loss', '-4*D_i/(D_o^2-D_i^2)*epsilon*sigma_const*T^4');
model.variable('var1').descr('Q_loss', 'Heat loss');

model.material.create('mat1', 'Common', 'comp1');
model.material('mat1').propertyGroup('def').set('thermalconductivity', {'13'});
model.material('mat1').propertyGroup('def').set('density', {'8700'});
model.material('mat1').propertyGroup('def').set('heatcapacity', {'300'});

model.physics('ht').create('hs1', 'HeatSource', 1);
model.physics('ht').feature('hs1').selection.all;
model.physics('ht').feature('hs1').set('Q0', 'Q_source+Q_loss');
model.physics('ht').feature('init1').set('Tinit', 'T_init');
model.physics('ht').create('temp1', 'TemperatureBoundary', 0);
model.physics('ht').feature('temp1').selection.set([1]);
model.physics('ht').feature('temp1').set('T0', 'T_cold+DT_max*tanh(t/1[min])');
model.physics('ht').create('temp2', 'TemperatureBoundary', 0);
model.physics('ht').feature('temp2').selection.set([2]);
model.physics('ht').feature('temp2').set('T0', 'T_cold');

model.mesh('mesh1').autoMeshSize(2);
model.mesh('mesh1').run;

model.study('std1').feature('time').set('tlist', 'range(0,1[min],1[h])');
model.study('std1').create('param', 'Parametric');
model.study('std1').feature('param').setIndex('pname', 'epsilon', 0);
model.study('std1').feature('param').setIndex('plistarr', '', 0);
model.study('std1').feature('param').setIndex('punit', '', 0);
model.study('std1').feature('param').setIndex('pname', 'epsilon', 0);
model.study('std1').feature('param').setIndex('plistarr', '', 0);
model.study('std1').feature('param').setIndex('punit', '', 0);
model.study('std1').feature('param').setIndex('pname', 'epsilon', 0);
model.study('std1').feature('param').setIndex('plistarr', '0 1', 0);

model.sol.create('sol1');
model.sol('sol1').study('std1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'time');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').set('control', 'time');
model.sol('sol1').create('t1', 'Time');
model.sol('sol1').feature('t1').set('tlist', 'range(0,1[min],1[h])');
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

model.batch.create('p1', 'Parametric');
model.batch('p1').study('std1');
model.batch('p1').create('so1', 'Solutionseq');
model.batch('p1').feature('so1').set('seq', 'sol1');
model.batch('p1').feature('so1').set('store', 'on');
model.batch('p1').feature('so1').set('clear', 'on');
model.batch('p1').feature('so1').set('psol', 'none');
model.batch('p1').set('pname', {'epsilon'});
model.batch('p1').set('plistarr', {'0 1'});
model.batch('p1').set('sweeptype', 'sparse');
model.batch('p1').set('probesel', 'all');
model.batch('p1').set('probes', {});
model.batch('p1').set('plot', 'off');
model.batch('p1').set('err', 'on');
model.batch('p1').attach('std1');
model.batch('p1').set('control', 'param');

model.sol.create('sol2');
model.sol('sol2').study('std1');
model.sol('sol2').label('Parametric Solutions 1');

model.batch('p1').feature('so1').set('psol', 'sol2');
model.batch('p1').run('compute');

model.result.create('pg1', 'PlotGroup1D');
model.result('pg1').label('Temperature (ht)');
model.result('pg1').set('data', 'dset2');
model.result('pg1').set('showlooplevelinput', {'off' 'off' 'off'});
model.result('pg1').set('data', 'dset2');
model.result('pg1').set('defaultPlotID', 'ht/HT_PhysicsInterfaces/icom8/pdef1/pcond1/pg1');
model.result('pg1').feature.create('lngr1', 'LineGraph');
model.result('pg1').feature('lngr1').set('xdata', 'expr');
model.result('pg1').feature('lngr1').set('xdataexpr', 'x');
model.result('pg1').feature('lngr1').set('data', 'parent');
model.result('pg1').feature('lngr1').selection.geom('geom1', 1);
model.result('pg1').feature('lngr1').selection.set([1]);
model.result('pg1').run;
model.result('pg1').run;
model.result('pg1').setIndex('looplevelinput', 'last', 0);
model.result('pg1').run;
model.result('pg1').feature('lngr1').set('legend', true);
model.result('pg1').run;
model.result('pg1').run;

model.title('An Integro-Partial Differential Equation');

model.description('This example contains an analysis of conductive and radiative heat transfer in a hollow pipe, where the ends are held at two different temperatures. To solve this integro-partial differential equation, the example makes use of the destination operator and an integration coupling operator.');

model.mesh.clearMeshes;

model.sol('sol1').clearSolutionData;
model.sol('sol2').clearSolutionData;
model.sol('sol3').clearSolutionData;
model.sol('sol4').clearSolutionData;

model.label('integro_partial.mph');

model.modelNode.label('Components');

out = model;
