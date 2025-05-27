function out = model
%
% pid_control.m
%
% Model exported on May 26 2025, 21:27 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/COMSOL_Multiphysics/Multiphysics');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 2);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.physics.create('spf', 'LaminarFlow', 'geom1');
model.physics('spf').model('comp1');
model.physics.create('tds', 'DilutedSpecies', 'geom1', {'c'});

model.study.create('std1');
model.study('std1').create('time', 'Transient');
model.study('std1').feature('time').setSolveFor('/physics/spf', true);
model.study('std1').feature('time').setSolveFor('/physics/tds', true);

model.param.set('v_in_top', '0.01[m/s]');
model.param.descr('v_in_top', 'Velocity, upper inlet');
model.param.set('c_in_top', '1[mol/m^3]');
model.param.descr('c_in_top', 'Concentration, upper inlet');
model.param.set('c_in_inlet', '0.2[mol/m^3]');
model.param.descr('c_in_inlet', 'Concentration, controlled inlet');
model.param.set('c00', '0.5[mol/m^3]');
model.param.descr('c00', 'Initial concentration, chamber interior');
model.param.set('D', '1e-4[m^2/s]');
model.param.descr('D', 'Diffusivity');
model.param.set('c_set', '0.5[mol/m^3]');
model.param.descr('c_set', 'Setpoint concentration');
model.param.set('k_P_ctrl', '-0.5[m^4/(mol*s)]');
model.param.descr('k_P_ctrl', 'Proportional parameter');
model.param.set('k_I_ctrl', '-1[m^4/(mol*s^2)]');
model.param.descr('k_I_ctrl', 'Integral parameter');
model.param.set('k_D_ctrl', '-1e-3[m^4/mol]');
model.param.descr('k_D_ctrl', 'Derivative parameter');

model.geom('geom1').insertFile('pid_control_geom_sequence.mph', 'geom1');
model.geom('geom1').run('fin');

model.probe.create('pdom1', 'DomainPoint');
model.probe('pdom1').model('comp1');
model.probe('pdom1').setIndex('coords2', -0.002, 1);
model.probe('pdom1').feature('ppb1').set('probename', 'c_mp');
model.probe('pdom1').feature('ppb1').set('expr', 'c');
model.probe('pdom1').feature('ppb1').set('descr', 'Concentration');
model.probe('pdom1').feature.create('ppb2', 'PointExpr');
model.probe('pdom1').feature('ppb2').set('probename', 'ct_mp');
model.probe('pdom1').feature('ppb2').set('expr', 'ct');

model.param.set('k_D_ctrl_temp_param', 'k_D_ctrl');
model.param.remove('k_D_ctrl_temp_param');

model.modelNode.create('comp2', true);

model.physics.create('ge1', 'GlobalEquations');
model.physics('ge1').model('comp2');
model.physics('ge1').feature('ge1').setIndex('name', 'I', 0, 0);
model.physics('ge1').feature('ge1').setIndex('equation', 'It[s]-(c_set[1/(mol/m^3)]-comp1.c_mp[1/(mol/m^3)])', 0, 0);
model.physics('ge1').feature('ge1').setIndex('description', 'Time integral term', 0, 0);
model.physics('ge1').feature('ge1').setIndex('name', 'I2', 1, 0);
model.physics('ge1').feature('ge1').setIndex('equation', 'I2t[s]+((u_temp-10)*(u_temp>10)+(u_temp-0)*(u_temp<0))[1/((m^4/(s*mol))*(mol/m^3))]', 1, 0);
model.physics('ge1').feature('ge1').setIndex('initialValueU', 0, 1, 0);
model.physics('ge1').feature('ge1').setIndex('initialValueUt', 0, 1, 0);
model.physics('ge1').feature('ge1').setIndex('description', 'Time integral term 2', 1, 0);

model.variable.create('var1');
model.variable.var1.model('comp2');

model.param.set('k_D_ctrl_temp_param', 'k_D_ctrl');
model.param.remove('k_D_ctrl_temp_param');

model.physics('ge1').feature('ge1').setIndex('name', 'd', 2, 0);
model.physics('ge1').feature('ge1').setIndex('equation', '(1[s])[1/s]*dt[s]+d+(k_D_ctrl*d(comp1.c_mp,TIME))[1/((m^4/(s*mol))*(mol/m^3))]', 2, 0);
model.physics('ge1').feature('ge1').setIndex('initialValueU', 0, 2, 0);
model.physics('ge1').feature('ge1').setIndex('initialValueUt', 0, 2, 0);
model.physics('ge1').feature('ge1').setIndex('description', 'Derivative term', 2, 0);

model.param.set('k_D_ctrl_temp_param', 'k_D_ctrl');
model.param.remove('k_D_ctrl_temp_param');

model.variable('var1').set('u_temp', 'nojac(0+k_P_ctrl*(c_set-comp1.c_mp)+k_I_ctrl*I[s][mol/m^3]-d[(m^4/(s*mol))*(mol/m^3)]+1/(1[s])*I2[s][(m^4/(s*mol))*(mol/m^3)])', 'Temp control variable');
model.variable('var1').set('u_in_ctrl', 'if(u_temp<0, 0, if(u_temp>10, 10, u_temp))', 'Control variable');

model.material.create('mat1', 'Common', 'comp1');
model.material('mat1').label('Fluid');
model.material('mat1').propertyGroup('def').set('density', {'1.2[kg/m^3]'});
model.material('mat1').propertyGroup('def').set('dynamicviscosity', {'3e-5[Pa*s]'});

model.physics('spf').create('inl1', 'InletBoundary', 1);
model.physics('spf').feature('inl1').selection.set([1]);
model.physics('spf').feature('inl1').set('U0in', 'comp2.u_in_ctrl');
model.physics('spf').create('inl2', 'InletBoundary', 1);
model.physics('spf').feature('inl2').selection.set([7]);
model.physics('spf').feature('inl2').set('U0in', 'v_in_top');
model.physics('spf').create('out1', 'OutletBoundary', 1);
model.physics('spf').feature('out1').selection.set([13]);
model.physics('spf').create('wallbc2', 'WallBC', 1);
model.physics('spf').feature('wallbc2').selection.set([2 3 6 8]);
model.physics('spf').feature('wallbc2').set('BoundaryCondition', 'Slip');
model.physics('tds').feature('cdm1').set('u_src', 'root.comp1.u');
model.physics('tds').feature('cdm1').set('D_c', {'D' '0' '0' '0' 'D' '0' '0' '0' 'D'});
model.physics('tds').feature('init1').setIndex('initc', 'c00', 0);
model.physics('tds').create('in1', 'Inflow', 1);
model.physics('tds').feature('in1').selection.set([1]);
model.physics('tds').feature('in1').setIndex('c0', 'c_in_inlet', 0);
model.physics('tds').create('in2', 'Inflow', 1);
model.physics('tds').feature('in2').selection.set([7]);
model.physics('tds').feature('in2').setIndex('c0', 'c_in_top', 0);
model.physics('tds').create('out1', 'Outflow', 1);
model.physics('tds').feature('out1').selection.set([13]);

model.mesh('mesh1').autoMeshSize(3);
model.mesh('mesh1').run;

model.study('std1').create('param', 'Parametric');
model.study('std1').feature('param').setIndex('pname', 'v_in_top', 0);
model.study('std1').feature('param').setIndex('plistarr', '', 0);
model.study('std1').feature('param').setIndex('punit', 'm/s', 0);
model.study('std1').feature('param').setIndex('pname', 'v_in_top', 0);
model.study('std1').feature('param').setIndex('plistarr', '', 0);
model.study('std1').feature('param').setIndex('punit', 'm/s', 0);
model.study('std1').feature('param').setIndex('pname', 'k_P_ctrl', 0);
model.study('std1').feature('param').setIndex('plistarr', '-0.1 -0.5', 0);
model.study('std1').feature('time').set('tlist', 'range(0,0.05,1) range(1.1,0.1,6)');

model.sol.create('sol1');

model.mesh('mesh1').stat.selection.geom(2);
model.mesh('mesh1').stat.selection.set([1]);
model.mesh('mesh1').stat.selection.geom(2);
model.mesh('mesh1').stat.selection.set([1]);

model.sol('sol1').study('std1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'time');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').set('control', 'time');
model.sol('sol1').create('t1', 'Time');
model.sol('sol1').feature('t1').set('tlist', 'range(0,0.05,1) range(1.1,0.1,6)');
model.sol('sol1').feature('t1').set('plot', 'off');
model.sol('sol1').feature('t1').set('plotgroup', 'Default');
model.sol('sol1').feature('t1').set('plotfreq', 'tout');
model.sol('sol1').feature('t1').set('probesel', 'all');
model.sol('sol1').feature('t1').set('probes', {'pdom1'});
model.sol('sol1').feature('t1').set('probefreq', 'tsteps');
model.sol('sol1').feature('t1').set('rtol', 0.005);
model.sol('sol1').feature('t1').set('atolglobalmethod', 'scaled');
model.sol('sol1').feature('t1').set('atolglobalfactor', 0.05);
model.sol('sol1').feature('t1').set('atolglobalvaluemethod', 'factor');
model.sol('sol1').feature('t1').set('atolmethod', {'comp1_c' 'global' 'comp1_p' 'scaled' 'comp1_u' 'global' 'comp2_ODE1' 'global'});
model.sol('sol1').feature('t1').set('atolvaluemethod', {'comp1_c' 'factor' 'comp1_p' 'factor' 'comp1_u' 'factor' 'comp2_ODE1' 'factor'});
model.sol('sol1').feature('t1').set('atolfactor', {'comp1_c' '0.1' 'comp1_p' '1' 'comp1_u' '0.1' 'comp2_ODE1' '0.1'});
model.sol('sol1').feature('t1').set('reacf', true);
model.sol('sol1').feature('t1').set('storeudot', true);
model.sol('sol1').feature('t1').set('endtimeinterpolation', true);
model.sol('sol1').feature('t1').set('estrat', 'exclude');
model.sol('sol1').feature('t1').set('rhoinf', 0.5);
model.sol('sol1').feature('t1').set('predictor', 'constant');
model.sol('sol1').feature('t1').set('maxorder', 2);
model.sol('sol1').feature('t1').set('stabcntrl', true);
model.sol('sol1').feature('t1').set('bwinitstepfrac', '0.01');
model.sol('sol1').feature('t1').set('control', 'time');
model.sol('sol1').feature('t1').feature('aDef').set('cachepattern', true);
model.sol('sol1').feature('t1').create('seDef', 'Segregated');
model.sol('sol1').feature('t1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('t1').feature('fc1').set('stabacc', 'aacc');
model.sol('sol1').feature('t1').feature('fc1').set('aaccdim', 5);
model.sol('sol1').feature('t1').feature('fc1').set('aaccdelay', 0);
model.sol('sol1').feature('t1').feature('fc1').set('aaccmix', 0.9);
model.sol('sol1').feature('t1').feature('fc1').set('ntolfact', 0.5);
model.sol('sol1').feature('t1').feature('fc1').set('maxiter', 8);
model.sol('sol1').feature('t1').feature('fc1').set('damp', 0.9);
model.sol('sol1').feature('t1').feature('fc1').set('jtech', 'once');
model.sol('sol1').feature('t1').create('d1', 'Direct');
model.sol('sol1').feature('t1').feature('d1').set('linsolver', 'mumps');
model.sol('sol1').feature('t1').feature('d1').set('pivotperturb', 1.0E-13);
model.sol('sol1').feature('t1').feature('d1').label('Direct (Merged)');
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
model.sol('sol1').feature('t1').create('i2', 'Iterative');
model.sol('sol1').feature('t1').feature('i2').set('linsolver', 'gmres');
model.sol('sol1').feature('t1').feature('i2').set('prefuntype', 'left');
model.sol('sol1').feature('t1').feature('i2').set('itrestart', 50);
model.sol('sol1').feature('t1').feature('i2').set('rhob', 20);
model.sol('sol1').feature('t1').feature('i2').set('maxlinit', 100);
model.sol('sol1').feature('t1').feature('i2').set('nlinnormuse', 'on');
model.sol('sol1').feature('t1').feature('i2').label('AMG, fluid flow variables (spf)');
model.sol('sol1').feature('t1').feature('i2').create('mg1', 'Multigrid');
model.sol('sol1').feature('t1').feature('i2').feature('mg1').set('prefun', 'saamg');
model.sol('sol1').feature('t1').feature('i2').feature('mg1').set('mgcycle', 'v');
model.sol('sol1').feature('t1').feature('i2').feature('mg1').set('maxcoarsedof', 80000);
model.sol('sol1').feature('t1').feature('i2').feature('mg1').set('strconn', 0.02);
model.sol('sol1').feature('t1').feature('i2').feature('mg1').set('nullspace', 'constant');
model.sol('sol1').feature('t1').feature('i2').feature('mg1').set('usesmooth', false);
model.sol('sol1').feature('t1').feature('i2').feature('mg1').set('saamgcompwise', true);
model.sol('sol1').feature('t1').feature('i2').feature('mg1').set('loweramg', true);
model.sol('sol1').feature('t1').feature('i2').feature('mg1').set('compactaggregation', false);
model.sol('sol1').feature('t1').feature('i2').feature('mg1').feature('pr').create('sc1', 'SCGS');
model.sol('sol1').feature('t1').feature('i2').feature('mg1').feature('pr').feature('sc1').set('linesweeptype', 'ssor');
model.sol('sol1').feature('t1').feature('i2').feature('mg1').feature('pr').feature('sc1').set('iter', 0);
model.sol('sol1').feature('t1').feature('i2').feature('mg1').feature('pr').feature('sc1').set('scgsrelax', 0.7);
model.sol('sol1').feature('t1').feature('i2').feature('mg1').feature('pr').feature('sc1').set('scgsmethod', 'lines');
model.sol('sol1').feature('t1').feature('i2').feature('mg1').feature('pr').feature('sc1').set('scgsvertexrelax', 0.7);
model.sol('sol1').feature('t1').feature('i2').feature('mg1').feature('pr').feature('sc1').set('relax', 0.5);
model.sol('sol1').feature('t1').feature('i2').feature('mg1').feature('pr').feature('sc1').set('scgssolv', 'stored');
model.sol('sol1').feature('t1').feature('i2').feature('mg1').feature('pr').feature('sc1').set('approxscgs', true);
model.sol('sol1').feature('t1').feature('i2').feature('mg1').feature('pr').feature('sc1').set('scgsdirectmaxsize', 1000);
model.sol('sol1').feature('t1').feature('i2').feature('mg1').feature('po').create('sc1', 'SCGS');
model.sol('sol1').feature('t1').feature('i2').feature('mg1').feature('po').feature('sc1').set('linesweeptype', 'ssor');
model.sol('sol1').feature('t1').feature('i2').feature('mg1').feature('po').feature('sc1').set('iter', 1);
model.sol('sol1').feature('t1').feature('i2').feature('mg1').feature('po').feature('sc1').set('scgsrelax', 0.7);
model.sol('sol1').feature('t1').feature('i2').feature('mg1').feature('po').feature('sc1').set('scgsmethod', 'lines');
model.sol('sol1').feature('t1').feature('i2').feature('mg1').feature('po').feature('sc1').set('scgsvertexrelax', 0.7);
model.sol('sol1').feature('t1').feature('i2').feature('mg1').feature('po').feature('sc1').set('relax', 0.5);
model.sol('sol1').feature('t1').feature('i2').feature('mg1').feature('po').feature('sc1').set('scgssolv', 'stored');
model.sol('sol1').feature('t1').feature('i2').feature('mg1').feature('po').feature('sc1').set('approxscgs', true);
model.sol('sol1').feature('t1').feature('i2').feature('mg1').feature('po').feature('sc1').set('scgsdirectmaxsize', 1000);
model.sol('sol1').feature('t1').feature('i2').feature('mg1').feature('cs').create('d1', 'Direct');
model.sol('sol1').feature('t1').feature('i2').feature('mg1').feature('cs').feature('d1').set('linsolver', 'pardiso');
model.sol('sol1').feature('t1').feature('i2').feature('mg1').feature('cs').feature('d1').set('pivotperturb', 1.0E-13);
model.sol('sol1').feature('t1').feature('fc1').set('linsolver', 'd1');
model.sol('sol1').feature('t1').feature('fc1').set('stabacc', 'aacc');
model.sol('sol1').feature('t1').feature('fc1').set('aaccdim', 5);
model.sol('sol1').feature('t1').feature('fc1').set('aaccdelay', 0);
model.sol('sol1').feature('t1').feature('fc1').set('aaccmix', 0.9);
model.sol('sol1').feature('t1').feature('fc1').set('ntolfact', 0.5);
model.sol('sol1').feature('t1').feature('fc1').set('maxiter', 8);
model.sol('sol1').feature('t1').feature('fc1').set('damp', 0.9);
model.sol('sol1').feature('t1').feature('fc1').set('jtech', 'once');
model.sol('sol1').feature('t1').feature.remove('fcDef');
model.sol('sol1').feature('t1').feature.remove('seDef');
model.sol('sol1').attach('std1');

model.batch.create('p1', 'Parametric');
model.batch('p1').study('std1');
model.batch('p1').create('so1', 'Solutionseq');
model.batch('p1').feature('so1').set('seq', 'sol1');
model.batch('p1').feature('so1').set('store', 'on');
model.batch('p1').feature('so1').set('clear', 'on');
model.batch('p1').feature('so1').set('psol', 'none');
model.batch('p1').set('pname', {'k_P_ctrl'});
model.batch('p1').set('plistarr', {'-0.1 -0.5'});
model.batch('p1').set('sweeptype', 'sparse');
model.batch('p1').set('probesel', 'all');
model.batch('p1').set('probes', {'pdom1'});
model.batch('p1').set('plot', 'off');
model.batch('p1').set('err', 'on');
model.batch('p1').attach('std1');
model.batch('p1').set('control', 'param');

model.sol('sol1').feature('t1').set('timemethod', 'genalpha');
model.sol('sol1').feature('t1').set('tstepsgenalpha', 'intermediate');
model.sol.create('sol2');
model.sol('sol2').study('std1');
model.sol('sol2').label('Parametric Solutions 1');

model.batch('p1').feature('so1').set('psol', 'sol2');

model.probe('pdom1').genResult('none');

model.batch('p1').run('compute');

model.result.dataset('dset2').set('geom', 'geom1');
model.result.create('pg2', 'PlotGroup2D');
model.result('pg2').label('Velocity (spf)');
model.result('pg2').set('data', 'dset2');
model.result('pg2').setIndex('looplevel', 71, 0);
model.result('pg2').setIndex('looplevel', 2, 1);
model.result('pg2').set('frametype', 'spatial');
model.result('pg2').set('data', 'dset2');
model.result('pg2').setIndex('looplevel', 71, 0);
model.result('pg2').setIndex('looplevel', 2, 1);
model.result('pg2').set('defaultPlotID', 'ResultDefaults_SinglePhaseFlow/icom1/pdef1/pcond1/pg1');
model.result('pg2').feature.create('surf1', 'Surface');
model.result('pg2').feature('surf1').label('Surface');
model.result('pg2').feature('surf1').set('showsolutionparams', 'on');
model.result('pg2').feature('surf1').set('smooth', 'internal');
model.result('pg2').feature('surf1').set('showsolutionparams', 'on');
model.result('pg2').feature('surf1').set('data', 'parent');
model.result.create('pg3', 'PlotGroup2D');
model.result('pg3').label('Pressure (spf)');
model.result('pg3').set('data', 'dset2');
model.result('pg3').setIndex('looplevel', 71, 0);
model.result('pg3').setIndex('looplevel', 2, 1);
model.result('pg3').set('frametype', 'spatial');
model.result('pg3').set('data', 'dset2');
model.result('pg3').setIndex('looplevel', 71, 0);
model.result('pg3').setIndex('looplevel', 2, 1);
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
model.result('pg4').set('data', 'dset2');
model.result('pg4').setIndex('looplevel', 71, 0);
model.result('pg4').setIndex('looplevel', 2, 1);
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
model.result.numerical.create('gev1', 'EvalGlobal');
model.result.numerical('gev1').set('data', 'dset2');
model.result.numerical('gev1').set('expr', {'comp2.I' 'comp2.I2' 'comp2.d'});
model.result.numerical('gev1').set('descr', {'Time integral term' 'Time integral term 2' 'Derivative term'});
model.result.create('pg5', 'PlotGroup1D');
model.result('pg5').set('data', 'dset2');
model.result('pg5').create('glob1', 'Global');
model.result('pg5').feature('glob1').set('expr', {'comp2.I' 'comp2.I2' 'comp2.d'});
model.result('pg5').feature('glob1').set('descr', {'Time integral term' 'Time integral term 2' 'Derivative term'});
model.result('pg2').run;
model.result('pg4').run;
model.result('pg4').run;
model.result('pg4').feature('str1').set('expr', {'u' 'v'});
model.result('pg4').feature('str1').set('descr', 'Velocity field');
model.result('pg4').feature('str1').set('posmethod', 'magnitude');
model.result('pg4').feature('str1').set('mdist', [0.005 0.1]);
model.result('pg4').run;
model.result('pg4').run;
model.result('pg4').setIndex('looplevel', 2, 0);
model.result('pg4').run;
model.result('pg4').setIndex('looplevel', 41, 0);
model.result('pg4').run;
model.result('pg5').run;
model.result('pg5').label('Inlet Velocity');
model.result('pg5').set('titletype', 'manual');
model.result('pg5').set('title', 'Inlet velocity');
model.result('pg5').set('ylabelactive', true);
model.result('pg5').set('ylabel', 'u<sub>in,ctrl</sub> (mm/s)');
model.result('pg5').run;
model.result('pg5').feature('glob1').set('expr', {'comp2.u_in_ctrl'});
model.result('pg5').feature('glob1').set('descr', {'Control variable'});
model.result('pg5').feature('glob1').set('unit', {'m/s'});
model.result('pg5').feature('glob1').set('autodescr', false);
model.result('pg5').run;
model.result('pg5').run;
model.result.duplicate('pg6', 'pg5');
model.result('pg6').run;
model.result('pg6').label('Concentration, Measurement Point');
model.result('pg6').set('title', 'Concentration, measurement point');
model.result('pg6').set('ylabel', 'c<sub>mp</sub> (mol/m<sup>3</sup>)');
model.result('pg6').run;
model.result('pg6').feature('glob1').set('expr', {'c_mp'});
model.result('pg6').feature('glob1').set('descr', {'Domain Point Probe 1, c'});
model.result('pg6').feature('glob1').set('unit', {'mol/m^3'});
model.result('pg6').run;

model.title('Process Control Using a PID Controller');

model.description('This example illustrates how to implement a PID (proportional-integral-derivative) control algorithm to simulate a process control system and to find the optimal PID parameters.');

model.mesh.clearMeshes;

model.sol('sol1').clearSolutionData;
model.sol('sol2').clearSolutionData;
model.sol('sol3').clearSolutionData;
model.sol('sol4').clearSolutionData;

model.label('pid_control.mph');

model.modelNode.label('Components');

out = model;
