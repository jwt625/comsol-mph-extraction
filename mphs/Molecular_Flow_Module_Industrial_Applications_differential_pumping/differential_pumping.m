function out = model
%
% differential_pumping.m
%
% Model exported on May 26 2025, 21:30 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/Molecular_Flow_Module/Industrial_Applications');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 3);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.physics.create('fmf', 'FreeMolecularFlow', 'geom1', {'G'});

model.study.create('std1');
model.study('std1').create('stat', 'Stationary');
model.study('std1').feature('stat').setSolveFor('/physics/fmf', true);

model.geom('geom1').insertFile('differential_pumping_geom_sequence.mph', 'geom1');
model.geom('geom1').run('difsel2');

% To import content from file, use:
% model.param.loadFile('FILENAME');
model.param.set('Dtube', '3[mm]', 'Tube diameter');
model.param.set('Ltube', '30[mm]', 'Tube length');
model.param.set('T0', '300[K]', 'Temperature of system');
model.param.set('Mn0', '0.04[kg/mol]', 'Molar mass');
model.param.set('mu0', '22.9e-6[Pa*s]', 'Viscosity of gas');
model.param.set('pa_inf', '1e-4[torr]', 'Reservoir pressure (low vacuum)');
model.param.set('alpha', '1', 'Tube accommodation coefficient');
model.param.set('Spump', '500[l/s]', 'Pump speed');

model.view('view1').set('renderwireframe', true);

model.cpl.create('aveop1', 'Average', 'geom1');
model.cpl('aveop1').set('axisym', true);
model.cpl('aveop1').selection.geom('geom1', 2);
model.cpl('aveop1').selection.set([16]);

model.variable.create('var1');
model.variable('var1').model('comp1');

% To import content from file, use:
% model.variable('var1').loadFile('FILENAME');
model.variable('var1').set('pb_inf', 'abs(aveop1(fmf.N_G))*k_B_const*T0', 'Reservoir pressure (high vacuum)');
model.variable('var1').set('qa_inf', 'pa_inf+6*plambda', 'Reservoir mass conductance (low vacuum)');
model.variable('var1').set('qb_inf', 'pb_inf+6*plambda', 'Reservoir mass conductance (high vacuum)');
model.variable('var1').set('omegabar', '(2-alpha)/alpha*((1+b1*alpha)+(epsilon*b0-(1+b1*alpha))*(b2*plambda)/(pa_inf-pb_inf)*log((pa_inf+b2*plambda)/(pb_inf+b2*plambda)))', 'Dimensionless function');
model.variable('var1').set('F', 'Fc*(1+(16*plambda)/(qa_inf+qb_inf)*(omegabar-3/4))', 'Dimensionless function');
model.variable('var1').set('Fc', '3*pi*Dtube/(32*Ltube)', 'Dimensionless function');
model.variable('var1').set('qa', '(((1+F)*qa_inf^2+F*qb_inf^2)/(1+2*F))^0.5', 'Inlet mass conductance (low vacuum side)');
model.variable('var1').set('qb', '(((1+F)*qb_inf^2+F*qa_inf^2)/(1+2*F))^0.5', 'Outlet mass conductance (high vacuum side)');
model.variable('var1').set('pa', 'qa-6*plambda', 'Inlet pressure (low vacuum side)');
model.variable('var1').set('pb', 'qb-6*plambda', 'Outlet pressure (high vacuum side)');
model.variable('var1').set('Mdot', 'beta*F*(qa^2-qb^2)', 'General mass flow rate');
model.variable('var1').set('pm', '(pb+pa)/2', 'Average pressure');
model.variable('var1').set('Knm', 'plambda/pm', 'Average Knudsen number');
model.variable('var1').set('rho_b', 'Mn0*pb_inf/(R_const*T0)', 'Average density in reservoir b');
model.variable('var1').set('lambda_b', '2*mu0/(c*rho_b)', 'Mean free path in reservoir b');
model.variable('var1').set('Knm_b', 'lambda_b/0.5[m]', 'Knudsen number in reservoir b');
model.variable('var1').set('c', 'sqrt((8*R_const*T0)/(pi*Mn0))', 'Molecular mean thermal speed');
model.variable('var1').set('b0', '16/(3*pi)', 'Dimensionless parameter');
model.variable('var1').set('b1', '0.15', 'Dimensionless parameter');
model.variable('var1').set('b2', '0.7*alpha/(2-alpha)', 'Dimensionless parameter');
model.variable('var1').set('delta', '4/3*(2-alpha)', 'Dimensionless parameter');
model.variable('var1').set('kappa', '(delta-1)/delta*alpha*Ltube/Dtube', 'Dimensionless parameter');
model.variable('var1').set('epsilon', '(1+kappa)/(delta+kappa)', 'Dimensionless parameter');
model.variable('var1').set('plambda', 'pi*mu0*c/(4*Dtube)', 'Pressure at which the Knudsen number is unity');
model.variable('var1').set('beta', 'Dtube^3/(3*pi*mu0*c^2)', 'Mass flow rate coefficient');
model.variable('var1').set('omegabar_f', '(2-alpha)/alpha*epsilon*b0', 'Free molecular flow limit for omegabar');
model.variable('var1').set('Mdot_c_inf', 'Dtube^4*pm*(pa_inf-pb_inf)/(16*mu0*c^2*Ltube)', 'Mass flow rate, continuum limit, infinite tube');
model.variable('var1').set('Mdot_f_inf', 'Mdot_c_inf*8*plambda/pm*omegabar_f', 'Mass flow rate, free molecular flow limit, infinite tube');
model.variable('var1').set('Mdot_inf', 'Mdot_c_inf*(1+8*plambda/pm*omegabar)', 'Mass flow rate, infinite tube');

model.physics('fmf').selection.named('geom1_sel1');
model.physics('fmf').prop('Compute').set('ComputeP', false);
model.physics('fmf').prop('IntegrationProperty').set('IntegrationResolution', 1024);
model.physics('fmf').feature('fmfp1').setIndex('Mn_G', 'Mn0', 0);
model.physics('fmf').feature('st1').set('T', 'T0');
model.physics('fmf').create('pmp1', 'VacuumPump', 2);
model.physics('fmf').feature('pmp1').selection.named('geom1_sel5');
model.physics('fmf').feature('pmp1').set('SpecifyPump', 'PumpSpeed');
model.physics('fmf').feature('pmp1').setIndex('pspeed', 'Spump/2', 0);
model.physics('fmf').create('wall2', 'Wall', 2);
model.physics('fmf').feature('wall2').selection.named('geom1_sel2');
model.physics('fmf').feature('wall2').set('BCType', 'OutgassingWall');
model.physics('fmf').feature('wall2').set('BoundaryCondition', 'TotalMassFlow');
model.physics('fmf').feature('wall2').setIndex('tmf', 'Mdot/2', 0);
model.physics('fmf').create('msym1', 'Symmetry', -1);
model.physics('fmf').feature('msym1').selection('FirstReflectionPlane').set([17]);

model.mesh('mesh1').create('size1', 'Size');
model.mesh('mesh1').feature('size1').selection.geom('geom1', 2);
model.mesh('mesh1').feature('size1').selection.named('geom1_sel2');
model.mesh('mesh1').feature('size1').set('hauto', 1);
model.mesh('mesh1').feature('size').set('hauto', 2);
model.mesh('mesh1').create('ftri1', 'FreeTri');
model.mesh('mesh1').feature('ftri1').selection.named('geom1_adjsel1');
model.mesh('mesh1').run;

model.study('std1').feature('stat').set('useparam', true);
model.study('std1').feature('stat').setIndex('pname', 'Dtube', 0);
model.study('std1').feature('stat').setIndex('plistarr', '', 0);
model.study('std1').feature('stat').setIndex('punit', 'm', 0);
model.study('std1').feature('stat').setIndex('pname', 'Dtube', 0);
model.study('std1').feature('stat').setIndex('plistarr', '', 0);
model.study('std1').feature('stat').setIndex('punit', 'm', 0);
model.study('std1').feature('stat').setIndex('pname', 'pa_inf', 0);
model.study('std1').feature('stat').setIndex('plistarr', '1e-1[torr] 5e-2[torr] 3e-2[torr] 2e-2[torr] 1e-2[torr] 5e-3[torr] 1e-3[torr] 1e-4[torr]', 0);

model.sol.create('sol1');
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
model.sol('sol1').feature('s1').create('se1', 'Segregated');
model.sol('sol1').feature('s1').feature('se1').feature.remove('ssDef');
model.sol('sol1').feature('s1').feature('se1').create('ss1', 'SegregatedStep');
model.sol('sol1').feature('s1').feature('se1').feature('ss1').set('segvar', {'comp1_G'});
model.sol('sol1').feature('s1').create('i1', 'Iterative');
model.sol('sol1').feature('s1').feature('i1').set('linsolver', 'gmres');
model.sol('sol1').feature('s1').feature('i1').create('mg1', 'Multigrid');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').set('prefun', 'gmg');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').set('mcasegen', 'any');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('pr').create('sl1', 'SORLine');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('pr').feature('sl1').set('iter', 2);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('pr').feature('sl1').set('linerelax', 0.2);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('pr').feature('sl1').set('seconditer', 1);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('pr').feature('sl1').set('relax', 0.4);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('po').create('sl1', 'SORLine');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('po').feature('sl1').set('iter', 2);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('po').feature('sl1').set('linerelax', 0.2);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('po').feature('sl1').set('seconditer', 2);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('po').feature('sl1').set('relax', 0.4);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('cs').create('d1', 'Direct');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('cs').feature('d1').set('linsolver', 'pardiso');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('cs').feature('d1').set('pivotperturb', 1.0E-13);
model.sol('sol1').feature('s1').feature('se1').feature('ss1').set('linsolver', 'i1');
model.sol('sol1').feature('s1').feature('se1').create('ss2', 'SegregatedStep');
model.sol('sol1').feature('s1').feature('se1').feature('ss2').set('segvar', {'comp1_fmf_N_G'});
model.sol('sol1').feature('s1').feature('se1').feature('ss2').set('linsolver', 'i1');
model.sol('sol1').feature('s1').feature.remove('fcDef');
model.sol('sol1').attach('std1');
model.sol('sol1').runAll;

model.result.create('pg1', 'PlotGroup3D');
model.result('pg1').label('Incident Molecular Flux (fmf)');
model.result('pg1').set('data', 'dset1');
model.result('pg1').setIndex('looplevel', 8, 0);
model.result('pg1').set('defaultPlotID', 'FreeMolecularFlow/phys1/pdef1/pcond1/pg1');
model.result('pg1').feature.create('surf1', 'Surface');
model.result('pg1').feature('surf1').label('Surface');
model.result('pg1').feature('surf1').set('showsolutionparams', 'on');
model.result('pg1').feature('surf1').set('expr', 'fmf.Gtot');
model.result('pg1').feature('surf1').set('resolution', 'norefine');
model.result('pg1').feature('surf1').set('smooth', 'internal');
model.result('pg1').feature('surf1').set('showsolutionparams', 'on');
model.result('pg1').feature('surf1').set('data', 'parent');
model.result.create('pg2', 'PlotGroup3D');
model.result('pg2').label('Total Number Density (fmf)');
model.result('pg2').set('data', 'dset1');
model.result('pg2').setIndex('looplevel', 8, 0);
model.result('pg2').set('defaultPlotID', 'FreeMolecularFlow/phys1/pdef1/pcond1/pcond1/pg1');
model.result('pg2').feature.create('surf1', 'Surface');
model.result('pg2').feature('surf1').label('Surface');
model.result('pg2').feature('surf1').set('showsolutionparams', 'on');
model.result('pg2').feature('surf1').set('expr', 'fmf.ntot');
model.result('pg2').feature('surf1').set('resolution', 'norefine');
model.result('pg2').feature('surf1').set('smooth', 'internal');
model.result('pg2').feature('surf1').set('showsolutionparams', 'on');
model.result('pg2').feature('surf1').set('data', 'parent');
model.result('pg1').run;
model.result.dataset('dset1').selection.geom('geom1', 2);
model.result.dataset('dset1').selection.named('geom1_difsel2');
model.result('pg1').run;
model.result('pg1').run;
model.result('pg2').run;
model.result('pg2').run;
model.result.create('pg3', 'PlotGroup1D');
model.result('pg3').run;
model.result('pg3').label('Tube mass flow rate');
model.result('pg3').create('glob1', 'Global');
model.result('pg3').feature('glob1').set('markerpos', 'datapoints');
model.result('pg3').feature('glob1').set('linewidth', 'preference');
model.result('pg3').feature('glob1').setIndex('expr', 'Mdot', 0);
model.result('pg3').feature('glob1').setIndex('unit', 'kg/s', 0);
model.result('pg3').feature('glob1').setIndex('descr', 'General mass flow rate', 0);
model.result('pg3').feature('glob1').set('legend', false);
model.result('pg3').feature('glob1').set('xdata', 'expr');
model.result('pg3').feature('glob1').set('xdataexpr', '1/Knm');
model.result('pg3').feature('glob1').set('linemarker', 'circle');
model.result('pg3').set('xlog', true);
model.result('pg3').set('ylog', true);
model.result('pg3').run;
model.result.create('pg4', 'PlotGroup1D');
model.result('pg4').run;
model.result('pg4').set('legendpos', 'upperleft');
model.result('pg4').set('ylabelactive', true);
model.result('pg4').set('ylabel', 'Normalized Flow Rate (1)');
model.result('pg4').create('glob1', 'Global');
model.result('pg4').feature('glob1').set('markerpos', 'datapoints');
model.result('pg4').feature('glob1').set('linewidth', 'preference');
model.result('pg4').feature('glob1').setIndex('expr', 'Mdot/Mdot_f_inf', 0);
model.result('pg4').feature('glob1').setIndex('unit', 1, 0);
model.result('pg4').feature('glob1').setIndex('descr', 'Mass flow rate', 0);
model.result('pg4').feature('glob1').setIndex('expr', 'Mdot_inf/Mdot_f_inf', 1);
model.result('pg4').feature('glob1').setIndex('unit', 1, 1);
model.result('pg4').feature('glob1').setIndex('descr', 'Mass flow rate, infinite tube', 1);
model.result('pg4').feature('glob1').set('xdata', 'expr');
model.result('pg4').feature('glob1').set('xdataexpr', '1/Knm');
model.result('pg4').set('xlog', true);
model.result('pg4').set('ylog', true);
model.result('pg4').feature('glob1').set('linemarker', 'diamond');
model.result('pg4').run;
model.result('pg4').label('Normalized mass flow rate');
model.result('pg4').run;
model.result.numerical.create('gev1', 'EvalGlobal');
model.result.numerical('gev1').setIndex('expr', 'Knm_b', 0);
model.result.table.create('tbl1', 'Table');
model.result.table('tbl1').comments('Global Evaluation 1');
model.result.numerical('gev1').set('table', 'tbl1');
model.result.numerical('gev1').setResult;

model.physics.create('fmf2', 'FreeMolecularFlow', 'geom1', {'G2'});

model.study('std1').feature('stat').setSolveFor('/physics/fmf2', false);
model.study.create('std2');
model.study('std2').create('stat', 'Stationary');
model.study('std2').feature('stat').setSolveFor('/physics/fmf', true);
model.study('std2').feature('stat').setSolveFor('/physics/fmf2', true);

model.physics('fmf2').selection.set([2 3]);
model.physics('fmf2').prop('Compute').set('ComputeP', false);
model.physics('fmf2').prop('IntegrationProperty').set('IntegrationResolution', 2048);
model.physics('fmf2').feature('fmfp1').setIndex('Mn_G2', 'Mn0', 0);
model.physics('fmf2').feature('st1').set('T', 'T0');
model.physics('fmf2').create('pmp1', 'VacuumPump', 2);
model.physics('fmf2').feature('pmp1').selection.named('geom1_sel5');
model.physics('fmf2').feature('pmp1').set('SpecifyPump', 'PumpSpeed');
model.physics('fmf2').feature('pmp1').setIndex('pspeed', 'Spump/2', 0);
model.physics('fmf2').create('res1', 'Reservoir', 2);
model.physics('fmf2').feature('res1').selection.named('geom1_sel3');
model.physics('fmf2').feature('res1').setIndex('p0', 'pa_inf', 0);

model.cpl.create('intop1', 'Integration', 'geom1');
model.cpl('intop1').set('axisym', true);
model.cpl('intop1').selection.geom('geom1', 2);
model.cpl('intop1').selection.named('geom1_sel3');
model.cpl.duplicate('intop2', 'intop1');
model.cpl('intop2').selection.set([]);
model.cpl('intop2').selection.named('geom1_sel5');

model.physics('fmf2').create('msym1', 'Symmetry', -1);
model.physics('fmf2').feature('msym1').selection('FirstReflectionPlane').set([10 17]);

model.mesh.create('mesh2', 'geom1');
model.mesh('mesh2').create('size1', 'Size');
model.mesh('mesh2').feature('size1').selection.geom('geom1', 2);
model.mesh('mesh2').feature('size1').selection.named('geom1_sel6');
model.mesh('mesh2').feature('size1').set('table', 'cfd');
model.mesh('mesh2').feature('size1').set('hauto', 2);
model.mesh('mesh2').feature('size').set('hauto', 2);
model.mesh('mesh2').create('size2', 'Size');
model.mesh('mesh2').feature('size2').selection.geom('geom1', 2);
model.mesh('mesh2').feature('size2').selection.named('geom1_sel3');
model.mesh('mesh2').feature('size2').set('table', 'cfd');
model.mesh('mesh2').feature('size2').set('hauto', 1);
model.mesh('mesh2').create('ftri1', 'FreeTri');
model.mesh('mesh2').feature('ftri1').selection.named('geom1_sel3');
model.mesh('mesh2').run('ftri1');
model.mesh('mesh2').create('map1', 'Map');
model.mesh('mesh2').feature('map1').selection.named('geom1_sel4');
model.mesh('mesh2').feature('map1').create('dis1', 'Distribution');
model.mesh('mesh2').feature('map1').feature('dis1').set('numelem', 80);
model.mesh('mesh2').feature('map1').feature('dis1').selection.set([19]);
model.mesh('mesh2').create('ftri2', 'FreeTri');
model.mesh('mesh2').feature('ftri2').selection.named('geom1_difsel1');
model.mesh('mesh2').create('ftri3', 'FreeTri');
model.mesh('mesh2').feature('ftri3').selection.set([10]);
model.mesh('mesh2').run;

model.study('std2').feature('stat').setEntry('activate', 'fmf', false);
model.study('std2').feature('stat').setEntry('mesh', 'geom1', 'mesh2');

model.sol.create('sol2');
model.sol('sol2').study('std2');
model.sol('sol2').create('st1', 'StudyStep');
model.sol('sol2').feature('st1').set('study', 'std2');
model.sol('sol2').feature('st1').set('studystep', 'stat');
model.sol('sol2').create('v1', 'Variables');
model.sol('sol2').feature('v1').set('control', 'stat');
model.sol('sol2').create('s1', 'Stationary');
model.sol('sol2').feature('s1').set('stol', 0.001);
model.sol('sol2').feature('s1').create('se1', 'Segregated');
model.sol('sol2').feature('s1').feature('se1').feature.remove('ssDef');
model.sol('sol2').feature('s1').feature('se1').create('ss1', 'SegregatedStep');
model.sol('sol2').feature('s1').feature('se1').feature('ss1').set('segvar', {'comp1_G2'});
model.sol('sol2').feature('s1').create('i1', 'Iterative');
model.sol('sol2').feature('s1').feature('i1').set('linsolver', 'gmres');
model.sol('sol2').feature('s1').feature('i1').create('mg1', 'Multigrid');
model.sol('sol2').feature('s1').feature('i1').feature('mg1').set('prefun', 'gmg');
model.sol('sol2').feature('s1').feature('i1').feature('mg1').set('mcasegen', 'any');
model.sol('sol2').feature('s1').feature('i1').feature('mg1').feature('pr').create('sl1', 'SORLine');
model.sol('sol2').feature('s1').feature('i1').feature('mg1').feature('pr').feature('sl1').set('iter', 2);
model.sol('sol2').feature('s1').feature('i1').feature('mg1').feature('pr').feature('sl1').set('linerelax', 0.2);
model.sol('sol2').feature('s1').feature('i1').feature('mg1').feature('pr').feature('sl1').set('seconditer', 1);
model.sol('sol2').feature('s1').feature('i1').feature('mg1').feature('pr').feature('sl1').set('relax', 0.4);
model.sol('sol2').feature('s1').feature('i1').feature('mg1').feature('po').create('sl1', 'SORLine');
model.sol('sol2').feature('s1').feature('i1').feature('mg1').feature('po').feature('sl1').set('iter', 2);
model.sol('sol2').feature('s1').feature('i1').feature('mg1').feature('po').feature('sl1').set('linerelax', 0.2);
model.sol('sol2').feature('s1').feature('i1').feature('mg1').feature('po').feature('sl1').set('seconditer', 2);
model.sol('sol2').feature('s1').feature('i1').feature('mg1').feature('po').feature('sl1').set('relax', 0.4);
model.sol('sol2').feature('s1').feature('i1').feature('mg1').feature('cs').create('d1', 'Direct');
model.sol('sol2').feature('s1').feature('i1').feature('mg1').feature('cs').feature('d1').set('linsolver', 'pardiso');
model.sol('sol2').feature('s1').feature('i1').feature('mg1').feature('cs').feature('d1').set('pivotperturb', 1.0E-13);
model.sol('sol2').feature('s1').feature('se1').feature('ss1').set('linsolver', 'i1');
model.sol('sol2').feature('s1').feature('se1').create('ss2', 'SegregatedStep');
model.sol('sol2').feature('s1').feature('se1').feature('ss2').set('segvar', {'comp1_fmf2_N_G2'});
model.sol('sol2').feature('s1').feature('se1').feature('ss2').set('linsolver', 'i1');
model.sol('sol2').feature('s1').feature.remove('fcDef');
model.sol('sol2').attach('std2');
model.sol('sol2').runAll;

model.result.create('pg5', 'PlotGroup3D');
model.result('pg5').label('Incident Molecular Flux (fmf2)');
model.result('pg5').set('data', 'dset2');
model.result('pg5').set('defaultPlotID', 'FreeMolecularFlow/phys1/pdef1/pcond1/pg1');
model.result('pg5').feature.create('surf1', 'Surface');
model.result('pg5').feature('surf1').label('Surface');
model.result('pg5').feature('surf1').set('showsolutionparams', 'on');
model.result('pg5').feature('surf1').set('expr', 'fmf2.Gtot');
model.result('pg5').feature('surf1').set('resolution', 'norefine');
model.result('pg5').feature('surf1').set('smooth', 'internal');
model.result('pg5').feature('surf1').set('showsolutionparams', 'on');
model.result('pg5').feature('surf1').set('data', 'parent');
model.result.create('pg6', 'PlotGroup3D');
model.result('pg6').label('Total Number Density (fmf2)');
model.result('pg6').set('data', 'dset2');
model.result('pg6').set('defaultPlotID', 'FreeMolecularFlow/phys1/pdef1/pcond1/pcond1/pg1');
model.result('pg6').feature.create('surf1', 'Surface');
model.result('pg6').feature('surf1').label('Surface');
model.result('pg6').feature('surf1').set('showsolutionparams', 'on');
model.result('pg6').feature('surf1').set('expr', 'fmf2.ntot');
model.result('pg6').feature('surf1').set('resolution', 'norefine');
model.result('pg6').feature('surf1').set('smooth', 'internal');
model.result('pg6').feature('surf1').set('showsolutionparams', 'on');
model.result('pg6').feature('surf1').set('data', 'parent');
model.result('pg5').run;
model.result.dataset.duplicate('dset3', 'dset2');
model.result.dataset('dset2').selection.geom('geom1', 2);
model.result.dataset('dset2').selection.named('geom1_difsel2');
model.result('pg5').run;
model.result('pg5').run;
model.result('pg6').run;
model.result('pg6').run;
model.result.create('pg7', 'PlotGroup1D');
model.result('pg7').run;
model.result('pg7').set('data', 'dset3');
model.result('pg7').set('xlabelactive', true);
model.result('pg7').set('xlabel', 'position (mm)');
model.result('pg7').set('ylabelactive', true);
model.result('pg7').set('ylabel', 'number density (1/m<sup>3</sup>)');
model.result('pg7').set('legendpos', 'lowerright');
model.result('pg7').set('titletype', 'none');
model.result('pg7').label('Number density in the tube');
model.result('pg7').create('lngr1', 'LineGraph');
model.result('pg7').feature('lngr1').set('markerpos', 'datapoints');
model.result('pg7').feature('lngr1').set('linewidth', 'preference');
model.result('pg7').feature('lngr1').selection.set([19]);
model.result('pg7').feature('lngr1').set('expr', 'fmf2.ntot');
model.result('pg7').feature('lngr1').set('xdata', 'reversedarc');
model.result('pg7').feature('lngr1').set('resolution', 'norefine');
model.result('pg7').run;
model.result('pg7').create('glob1', 'Global');
model.result('pg7').feature('glob1').set('markerpos', 'datapoints');
model.result('pg7').feature('glob1').set('linewidth', 'preference');
model.result('pg7').feature('glob1').setIndex('expr', 'pb/(k_B_const*T0)', 0);
model.result('pg7').feature('glob1').setIndex('unit', '1/m^3', 0);
model.result('pg7').feature('glob1').setIndex('descr', '', 0);
model.result('pg7').feature('glob1').set('xdata', 'expr');
model.result('pg7').feature('glob1').set('xdataexpr', '0');
model.result('pg7').feature('glob1').set('linestyle', 'none');
model.result('pg7').feature('glob1').set('linecolor', 'black');
model.result('pg7').feature('glob1').set('linemarker', 'circle');
model.result('pg7').feature('glob1').setIndex('descr', 'Analytic outlet number density', 0);
model.result('pg7').run;
model.result('pg7').create('glob2', 'Global');
model.result('pg7').feature('glob2').set('markerpos', 'datapoints');
model.result('pg7').feature('glob2').set('linewidth', 'preference');
model.result('pg7').feature('glob2').setIndex('expr', 'pa/(k_B_const*T0)', 0);
model.result('pg7').feature('glob2').setIndex('unit', '1/m^3', 0);
model.result('pg7').feature('glob2').setIndex('descr', '', 0);
model.result('pg7').feature('glob2').setIndex('descr', 'Analytic inlet number density', 0);
model.result('pg7').feature('glob2').set('xdata', 'expr');
model.result('pg7').feature('glob2').set('xdataexpr', '30[mm]');
model.result('pg7').feature('glob2').set('linestyle', 'none');
model.result('pg7').feature('glob2').set('linecolor', 'red');
model.result('pg7').feature('glob2').set('linemarker', 'circle');
model.result.numerical.create('gev2', 'EvalGlobal');
model.result.numerical('gev2').set('data', 'dset2');
model.result.numerical('gev2').setIndex('expr', 'Mdot', 0);
model.result.numerical('gev2').setIndex('descr', 'Analytic Inflow', 0);
model.result.table.create('tbl2', 'Table');
model.result.table('tbl2').comments('Global Evaluation 2');
model.result.numerical('gev2').set('table', 'tbl2');
model.result.numerical('gev2').setResult;
model.result.numerical.duplicate('gev3', 'gev2');
model.result.numerical('gev3').setIndex('expr', '2*intop1(fmf2.Jnet_G2)*Mn0/N_A_const', 0);
model.result.numerical('gev3').setIndex('descr', 'Numerical Inflow', 0);
model.result.numerical('gev3').set('table', 'tbl2');
model.result.numerical('gev3').appendResult;
model.result.numerical.duplicate('gev4', 'gev3');
model.result.numerical('gev4').setIndex('expr', '2*intop2(fmf2.Jnet_G2)*Mn0/N_A_const', 0);
model.result.numerical('gev4').setIndex('descr', 'Numerical Outflow', 0);
model.result.numerical('gev4').set('table', 'tbl2');
model.result.numerical('gev4').appendResult;

model.title('Differential Pumping');

model.description('Differentially pumped vacuum systems use a small orifice or tube to connect two parts of a vacuum system that are at very different pressures. Such systems are necessary when processes run at higher pressures and are monitored by detectors that require UHV for operation. In this model, gas flow through a narrow tube and into a high vacuum chamber is approximated using an analytic expression for the flow rate. The model can also be adapted to use experimental data directly. The results obtained by coupling the analytic model to the free molecular flow interface are compared with a simulation that incorporates free molecular flow in both the tube and the UHV part of the system.');

model.mesh.clearMeshes;

model.sol('sol1').clearSolutionData;
model.sol('sol2').clearSolutionData;

model.label('differential_pumping.mph');

model.modelNode.label('Components');

out = model;
