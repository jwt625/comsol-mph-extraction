function out = model
%
% lumped_li_battery_parameter_estimation.m
%
% Model exported on May 26 2025, 21:26 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/Battery_Design_Module/Batteries,_Lithium-Ion');

model.modelNode.create('comp1', true);

model.physics.create('lb', 'LumpedBattery');
model.physics('lb').model('comp1');

model.study.create('std1');
model.study('std1').create('time', 'Transient');
model.study('std1').feature('time').setSolveFor('/physics/lb', true);

% To import content from file, use:
% model.param.loadFile('FILENAME');
model.param.set('eta_IR_1C', '10[mV]', 'Ohmic overpotential at 1C, fitting parameter');
model.param.set('invJ0', '1', 'Inverse dimensionless charge exchange current, fitting parameter');
model.param.set('tau', '1000[s]', 'Diffusion time constant, fitting parameter');
model.param.set('J0', '1/invJ0', 'Dimensionless charge exchange current');
model.param.set('Q_cell0', '12[A*h]', 'Battery capacity');
model.param.set('SOC_0', '0.3797', 'Initial state of charge');
model.param.set('T', '298.15[K]', 'Temperature');

model.variable.create('var1');
model.variable('var1').model('comp1');

% To import content from file, use:
% model.variable('var1').loadFile('FILENAME');
model.variable('var1').set('I_cell_exp', 'I_cell_exp(t)[A]', 'Experimental cell current');
model.variable('var1').set('E_cell_exp', 'E_cell_exp(t)[V]', 'Experimental cell voltage');

model.result.table.create('tbl1', 'Table');
model.result.table('tbl1').label('Load Cycle Data');
model.result.table('tbl1').importData('lumped_li_battery_parameter_estimation_E_I_vs_t_data.txt');

model.func.create('int1', 'Interpolation');
model.func('int1').model('comp1');
model.func('int1').label('Interpolation - E and I vs. t');
model.func('int1').set('source', 'resultTable');
model.func('int1').setIndex('funcs', 'E_cell_exp', 0, 0);
model.func('int1').setIndex('funcs', 'I_cell_exp', 1, 0);
model.func('int1').setIndex('funcs', 2, 1, 1);
model.func('int1').setIndex('argunit', 's', 0);

model.physics('lb').prop('BatterySettings').set('I_app', 'I_cell_exp');
model.physics('lb').prop('BatterySettings').set('Q_cell0', 'Q_cell0');
model.physics('lb').prop('BatterySettings').set('SOC_cell0', 'SOC_0');
model.physics('lb').feature('cep1').set('SOC_Eocv', []);
model.physics('lb').feature('cep1').set('Eocv', []);
model.physics('lb').feature('cep1').set('SOC_Eocv', [0 0.01 0.02 0.030000000000000002 0.04 0.05 0.060000000000000005 0.07 0.08 0.09000000000000001 0.1 0.11 0.12000000000000001 0.13 0.14 0.15 0.16 0.17 0.18000000000000002 0.19 0.2 0.21000000000000002 0.22 0.23 0.24000000000000002 0.25 0.26 0.27 0.28 0.29000000000000004 0.3 0.31 0.32 0.33 0.34 0.35000000000000003 0.36000000000000004 0.37 0.38 0.39 0.4 0.41000000000000003 0.42000000000000004 0.43 0.44 0.45 0.46 0.47000000000000003 0.48000000000000004 0.49000000000000005 0.5 0.51 0.52 0.53 0.54 0.55 0.56 0.5700000000000001 0.5800000000000001 0.5900000000000001 0.6 0.61 0.62 0.63 0.64 0.65 0.66 0.67 0.68 0.6900000000000001 0.7000000000000001 0.7100000000000001 0.7200000000000001 0.73 0.74 0.75 0.76 0.77 0.78 0.79 0.8 0.81 0.8200000000000001 0.8300000000000001 0.8400000000000001 0.8500000000000001 0.86 0.87 0.88 0.89 0.9 0.91 0.92 0.93 0.9400000000000001 0.9500000000000001 0.9600000000000001 0.9700000000000001 0.9800000000000001 0.9900000000000001 1]);
model.physics('lb').feature('cep1').set('Eocv', [1.3104190837885064 2.2611069048882873 2.8334213300309643 3.1844362423678003 3.393016295869783 3.510875145406253 3.5869463584273378 3.6264514929037994 3.6557565420023983 3.6850615911009976 3.6994551120045407 3.7113345164250635 3.7232139208455868 3.7350933252661096 3.746972729686633 3.7588394760123167 3.7669805471052284 3.7751216181981406 3.7832626892910524 3.7914037603839645 3.7995448314768763 3.8076859025697884 3.8158269736627 3.8239680447556124 3.832109115848524 3.8402384951548894 3.844926614135922 3.8496147331169555 3.8543028520979887 3.8589909710790216 3.863679090060055 3.8683672090410877 3.873055328022121 3.877743447003154 3.882431565984187 3.8871182387192977 3.891379235814907 3.8956402329105164 3.900108284697505 3.9048921849677303 3.910004858946812 3.9155565350495363 3.9213824207219656 3.927676048105941 3.9340438371441717 3.94051108662678 3.9470234377800457 3.9533348394394214 3.9592735197022777 3.9650124251831564 3.970366661250179 3.975134457606617 3.979408469784772 3.9832924969139087 3.986400783870235 3.989209391104789 3.9920179983393425 3.994805300205646 3.9971563232603926 3.9995073463151387 4.001858369369885 4.004209392424632 4.006560415479378 4.008911438534124 4.011262461588871 4.014107842011973 4.017168121841405 4.020228401670838 4.02328868150027 4.0263489613297025 4.029409241159136 4.032469520988568 4.03470071596249 4.035374828848886 4.036048941735283 4.036723054621679 4.037397167508075 4.038071280394472 4.038745393280867 4.039419506167263 4.039965701342635 4.040511627548762 4.041057553754889 4.041603479961017 4.042149406167145 4.042695332373272 4.0432412585794 4.04546697590993 4.048603777764223 4.0517405796185155 4.054877381472807 4.0580141833271 4.061150985181393 4.064287787035685 4.069434668295399 4.079298736570241 4.091601063364331 4.110991916734893 4.13395738036637 4.167078533171239 4.204442586248173]);
model.physics('lb').feature('cep1').set('Tref', 'T');
model.physics('lb').feature('vl1').set('IncludeConcentrationOverpotential', true);

model.study('std1').label('Study 1 - Load Curve Simulation');
model.study('std1').feature('time').set('tlist', 'range(0,1,300)');
model.study('std1').feature('time').set('usertol', true);
model.study('std1').feature('time').set('rtol', 0.001);

model.sol.create('sol1');
model.sol('sol1').study('std1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'time');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').feature('comp1_lb_vl1_SOC').set('scalemethod', 'manual');
model.sol('sol1').feature('v1').feature('comp1_lb_vl1_SOC').set('scaleval', '1');
model.sol('sol1').feature('v1').set('control', 'time');
model.sol('sol1').create('t1', 'Time');
model.sol('sol1').feature('t1').set('tlist', 'range(0,1,300)');
model.sol('sol1').feature('t1').set('plot', 'off');
model.sol('sol1').feature('t1').set('plotgroup', 'Default');
model.sol('sol1').feature('t1').set('plotfreq', 'tout');
model.sol('sol1').feature('t1').set('probesel', 'all');
model.sol('sol1').feature('t1').set('probes', {});
model.sol('sol1').feature('t1').set('probefreq', 'tsteps');
model.sol('sol1').feature('t1').set('atolglobalvaluemethod', 'factor');
model.sol('sol1').feature('t1').set('eventout', true);
model.sol('sol1').feature('t1').set('reacf', true);
model.sol('sol1').feature('t1').set('storeudot', true);
model.sol('sol1').feature('t1').set('endtimeinterpolation', true);
model.sol('sol1').feature('t1').set('initialstepbdfactive', true);
model.sol('sol1').feature('t1').set('initialstepbdf', '(1)[s]');
model.sol('sol1').feature('t1').set('control', 'time');
model.sol('sol1').feature('t1').feature('aDef').set('cachepattern', true);
model.sol('sol1').feature('t1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('t1').feature('fc1').set('linsolver', 'dDef');
model.sol('sol1').feature('t1').feature.remove('fcDef');
model.sol('sol1').attach('std1');
model.sol('sol1').runAll;

model.result.create('pg1', 'PlotGroup1D');
model.result('pg1').label('Cell Potential and Load (lb)');
model.result('pg1').set('showlooplevelinput', {'off' 'off' 'off'});
model.result('pg1').set('ylabel', 'Cell potential (V)');
model.result('pg1').set('showsecylabel', 'on');
model.result('pg1').set('twoyaxes', true);
model.result('pg1').set('legendpos', 'lowerleft');
model.result('pg1').set('data', 'dset1');
model.result('pg1').set('defaultPlotID', 'BFCMeshStudyResultDefaultsComponents/icom32/pdef1/pcond1/pg1');
model.result('pg1').feature.create('glob1', 'Global');
model.result('pg1').feature('glob1').set('showsolutionparams', 'on');
model.result('pg1').feature('glob1').set('expr', {'lb.E_cell'});
model.result('pg1').feature('glob1').set('xdatasolnumtype', 'inner');
model.result('pg1').feature('glob1').set('showunitcombo', 'off');
model.result('pg1').feature('glob1').set('showsolutionparams', 'on');
model.result('pg1').feature('glob1').set('xdatasolnumtype', 'inner');
model.result('pg1').feature('glob1').set('showunitcombo', 'off');
model.result('pg1').feature('glob1').set('showsolutionparams', 'on');
model.result('pg1').feature('glob1').set('xdatasolnumtype', 'inner');
model.result('pg1').feature('glob1').set('showunitcombo', 'off');
model.result('pg1').feature('glob1').set('showsolutionparams', 'on');
model.result('pg1').feature('glob1').set('xdatasolnumtype', 'inner');
model.result('pg1').feature('glob1').set('showunitcombo', 'off');
model.result('pg1').feature('glob1').set('showsolutionparams', 'on');
model.result('pg1').feature('glob1').set('xdatasolnumtype', 'inner');
model.result('pg1').feature('glob1').set('showunitcombo', 'off');
model.result('pg1').feature('glob1').set('data', 'parent');
model.result('pg1').feature.create('glob2', 'Global');
model.result('pg1').feature('glob2').set('showsolutionparams', 'on');
model.result('pg1').feature('glob2').set('expr', {'lb.Eocv_cell'});
model.result('pg1').feature('glob2').set('xdatasolnumtype', 'inner');
model.result('pg1').feature('glob2').set('showunitcombo', 'off');
model.result('pg1').feature('glob2').set('showsolutionparams', 'on');
model.result('pg1').feature('glob2').set('xdatasolnumtype', 'inner');
model.result('pg1').feature('glob2').set('showunitcombo', 'off');
model.result('pg1').feature('glob2').set('showsolutionparams', 'on');
model.result('pg1').feature('glob2').set('xdatasolnumtype', 'inner');
model.result('pg1').feature('glob2').set('showunitcombo', 'off');
model.result('pg1').feature('glob2').set('showsolutionparams', 'on');
model.result('pg1').feature('glob2').set('xdatasolnumtype', 'inner');
model.result('pg1').feature('glob2').set('showunitcombo', 'off');
model.result('pg1').feature('glob2').set('showsolutionparams', 'on');
model.result('pg1').feature('glob2').set('xdatasolnumtype', 'inner');
model.result('pg1').feature('glob2').set('showunitcombo', 'off');
model.result('pg1').feature('glob2').set('data', 'parent');
model.result('pg1').feature.create('glob3', 'Global');
model.result('pg1').feature('glob3').set('showsolutionparams', 'on');
model.result('pg1').feature('glob3').set('plotonsecyaxis', true);
model.result('pg1').feature('glob3').set('expr', {'lb.I_cell'});
model.result('pg1').feature('glob3').set('xdatasolnumtype', 'inner');
model.result('pg1').feature('glob3').set('showunitcombo', 'off');
model.result('pg1').feature('glob3').set('showsolutionparams', 'on');
model.result('pg1').feature('glob3').set('xdatasolnumtype', 'inner');
model.result('pg1').feature('glob3').set('showunitcombo', 'off');
model.result('pg1').feature('glob3').set('showsolutionparams', 'on');
model.result('pg1').feature('glob3').set('xdatasolnumtype', 'inner');
model.result('pg1').feature('glob3').set('showunitcombo', 'off');
model.result('pg1').feature('glob3').set('showsolutionparams', 'on');
model.result('pg1').feature('glob3').set('xdatasolnumtype', 'inner');
model.result('pg1').feature('glob3').set('showunitcombo', 'off');
model.result('pg1').feature('glob3').set('showsolutionparams', 'on');
model.result('pg1').feature('glob3').set('xdatasolnumtype', 'inner');
model.result('pg1').feature('glob3').set('showunitcombo', 'off');
model.result('pg1').feature('glob3').set('data', 'parent');
model.result.create('pg2', 'PlotGroup1D');
model.result('pg2').label('Cell State of Charge (lb)');
model.result('pg2').set('showlooplevelinput', {'off' 'off' 'off'});
model.result('pg2').set('showsecylabel', 'on');
model.result('pg2').set('twoyaxes', true);
model.result('pg2').set('legendpos', 'lowerleft');
model.result('pg2').set('data', 'dset1');
model.result('pg2').set('defaultPlotID', 'BFCMeshStudyResultDefaultsComponents/icom32/pdef1/pcond1/pg2');
model.result('pg2').feature.create('glob1', 'Global');
model.result('pg2').feature('glob1').set('showsolutionparams', 'on');
model.result('pg2').feature('glob1').set('expr', {'lb.SOC_cell'});
model.result('pg2').feature('glob1').set('xdatasolnumtype', 'inner');
model.result('pg2').feature('glob1').set('showunitcombo', 'off');
model.result('pg2').feature('glob1').set('showsolutionparams', 'on');
model.result('pg2').feature('glob1').set('xdatasolnumtype', 'inner');
model.result('pg2').feature('glob1').set('showunitcombo', 'off');
model.result('pg2').feature('glob1').set('showsolutionparams', 'on');
model.result('pg2').feature('glob1').set('xdatasolnumtype', 'inner');
model.result('pg2').feature('glob1').set('showunitcombo', 'off');
model.result('pg2').feature('glob1').set('showsolutionparams', 'on');
model.result('pg2').feature('glob1').set('xdatasolnumtype', 'inner');
model.result('pg2').feature('glob1').set('showunitcombo', 'off');
model.result('pg2').feature('glob1').set('showsolutionparams', 'on');
model.result('pg2').feature('glob1').set('xdatasolnumtype', 'inner');
model.result('pg2').feature('glob1').set('showunitcombo', 'off');
model.result('pg2').feature('glob1').set('data', 'parent');
model.result('pg2').feature.create('glob2', 'Global');
model.result('pg2').feature('glob2').set('showsolutionparams', 'on');
model.result('pg2').feature('glob2').set('plotonsecyaxis', true);
model.result('pg2').feature('glob2').set('expr', {'lb.I_cell'});
model.result('pg2').feature('glob2').set('xdatasolnumtype', 'inner');
model.result('pg2').feature('glob2').set('showunitcombo', 'off');
model.result('pg2').feature('glob2').set('showsolutionparams', 'on');
model.result('pg2').feature('glob2').set('xdatasolnumtype', 'inner');
model.result('pg2').feature('glob2').set('showunitcombo', 'off');
model.result('pg2').feature('glob2').set('showsolutionparams', 'on');
model.result('pg2').feature('glob2').set('xdatasolnumtype', 'inner');
model.result('pg2').feature('glob2').set('showunitcombo', 'off');
model.result('pg2').feature('glob2').set('showsolutionparams', 'on');
model.result('pg2').feature('glob2').set('xdatasolnumtype', 'inner');
model.result('pg2').feature('glob2').set('showunitcombo', 'off');
model.result('pg2').feature('glob2').set('showsolutionparams', 'on');
model.result('pg2').feature('glob2').set('xdatasolnumtype', 'inner');
model.result('pg2').feature('glob2').set('showunitcombo', 'off');
model.result('pg2').feature('glob2').set('data', 'parent');
model.result('pg1').run;
model.result('pg1').label('Cell Voltage');
model.result('pg1').set('titletype', 'none');
model.result('pg1').set('twoyaxes', false);
model.result('pg1').set('legendpos', 'lowerright');
model.result('pg1').run;
model.result('pg1').feature('glob1').setIndex('descr', 'Modeled cell voltage', 0);
model.result('pg1').run;
model.result('pg1').feature('glob3').set('expr', {'E_cell_exp'});
model.result('pg1').feature('glob3').set('descr', {'Experimental cell voltage'});
model.result('pg1').feature('glob3').set('unit', {'V'});
model.result('pg1').run;
model.result('pg1').set('axislimits', true);
model.result('pg1').set('xmax', 305);
model.result('pg1').set('ymin', 3.35);
model.result('pg1').set('ymax', 4.2);
model.result('pg1').run;
model.result('pg2').run;
model.result.create('pg3', 'PlotGroup1D');
model.result('pg3').run;
model.result('pg3').label('Voltage Losses and Load');
model.result('pg3').create('glob1', 'Global');
model.result('pg3').feature('glob1').set('markerpos', 'datapoints');
model.result('pg3').feature('glob1').set('linewidth', 'preference');
model.result('pg3').feature('glob1').set('expr', {'lb.eta_ir'});
model.result('pg3').feature('glob1').set('descr', {'Ohmic overpotential'});
model.result('pg3').feature('glob1').set('unit', {'V'});
model.result('pg3').feature('glob1').set('expr', {'lb.eta_ir' 'lb.eta_act'});
model.result('pg3').feature('glob1').set('descr', {'Ohmic overpotential' 'Activation overpotential'});
model.result('pg3').feature('glob1').set('expr', {'lb.eta_ir' 'lb.eta_act' 'lb.eta_conc'});
model.result('pg3').feature('glob1').set('descr', {'Ohmic overpotential' 'Activation overpotential' 'Concentration overpotential'});
model.result('pg3').feature('glob1').set('xdata', 'expr');
model.result('pg3').feature('glob1').set('xdataexpr', 't');
model.result('pg3').run;
model.result('pg3').create('glob2', 'Global');
model.result('pg3').feature('glob2').set('markerpos', 'datapoints');
model.result('pg3').feature('glob2').set('linewidth', 'preference');
model.result('pg3').feature('glob2').set('expr', {'lb.I_cell'});
model.result('pg3').feature('glob2').set('descr', {'Cell current'});
model.result('pg3').feature('glob2').set('unit', {'A'});
model.result('pg3').feature('glob2').set('xdata', 'expr');
model.result('pg3').feature('glob2').set('xdataexpr', 't');
model.result('pg3').feature('glob2').set('linestyle', 'dotted');
model.result('pg3').feature('glob2').set('linecolor', 'black');
model.result('pg3').run;
model.result('pg3').set('titletype', 'none');
model.result('pg3').set('ylabelactive', true);
model.result('pg3').set('ylabel', 'Overvoltage (V)');
model.result('pg3').set('twoyaxes', true);
model.result('pg3').setIndex('plotonsecyaxis', true, 1, 1);
model.result('pg3').set('axislimits', true);
model.result('pg3').set('xmax', 305);
model.result('pg3').set('ymin', -0.4);
model.result('pg3').set('ymax', 0.2);
model.result('pg3').set('yminsec', -350);
model.result('pg3').set('ymaxsec', 200);
model.result('pg3').set('legendpos', 'lowerleft');
model.result('pg3').run;

model.physics('lb').feature('vl1').set('minput_temperature', 'T');
model.physics('lb').feature('vl1').set('eta_ir1C', 'eta_IR_1C');
model.physics('lb').feature('vl1').set('J0', 'J0');
model.physics('lb').feature('vl1').set('tau', 'tau');

model.study.create('std2');
model.study('std2').create('time', 'Transient');
model.study('std2').feature('time').setSolveFor('/physics/lb', true);
model.study('std2').label('Study 2 - Parameter Estimation');
model.study('std2').setGenPlots(false);
model.study('std2').create('lsqo', 'LSQOptimization');
model.study('std2').feature('lsqo').set('source', 'resultTable');
model.study('std2').feature('lsqo').setEntry('columnType', 'col3', 'none');
model.study('std2').feature('lsqo').setEntry('modelExpression', 'col2', 'comp1.lb.E_cell');
model.study('std2').feature('lsqo').setEntry('unit', 'col2', 'V');
model.study('std2').feature('lsqo').setIndex('pname', 'eta_IR_1C', 0);
model.study('std2').feature('lsqo').setIndex('initval', '10[mV]', 0);
model.study('std2').feature('lsqo').setIndex('scale', 1, 0);
model.study('std2').feature('lsqo').setIndex('lbound', '', 0);
model.study('std2').feature('lsqo').setIndex('ubound', '', 0);
model.study('std2').feature('lsqo').setIndex('pname', 'eta_IR_1C', 0);
model.study('std2').feature('lsqo').setIndex('initval', '10[mV]', 0);
model.study('std2').feature('lsqo').setIndex('scale', 1, 0);
model.study('std2').feature('lsqo').setIndex('lbound', '', 0);
model.study('std2').feature('lsqo').setIndex('ubound', '', 0);
model.study('std2').feature('lsqo').setIndex('pname', 'invJ0', 1);
model.study('std2').feature('lsqo').setIndex('initval', 1, 1);
model.study('std2').feature('lsqo').setIndex('scale', 1, 1);
model.study('std2').feature('lsqo').setIndex('lbound', '', 1);
model.study('std2').feature('lsqo').setIndex('ubound', '', 1);
model.study('std2').feature('lsqo').setIndex('pname', 'invJ0', 1);
model.study('std2').feature('lsqo').setIndex('initval', 1, 1);
model.study('std2').feature('lsqo').setIndex('scale', 1, 1);
model.study('std2').feature('lsqo').setIndex('lbound', '', 1);
model.study('std2').feature('lsqo').setIndex('ubound', '', 1);
model.study('std2').feature('lsqo').setIndex('pname', 'tau', 2);
model.study('std2').feature('lsqo').setIndex('initval', '1000[s]', 2);
model.study('std2').feature('lsqo').setIndex('scale', 1, 2);
model.study('std2').feature('lsqo').setIndex('lbound', '', 2);
model.study('std2').feature('lsqo').setIndex('ubound', '', 2);
model.study('std2').feature('lsqo').setIndex('pname', 'tau', 2);
model.study('std2').feature('lsqo').setIndex('initval', '1000[s]', 2);
model.study('std2').feature('lsqo').setIndex('scale', 1, 2);
model.study('std2').feature('lsqo').setIndex('lbound', '', 2);
model.study('std2').feature('lsqo').setIndex('ubound', '', 2);
model.study('std2').feature('lsqo').setIndex('scale', 0.01, 0);
model.study('std2').feature('lsqo').setIndex('scale', 1000, 2);
model.study('std2').feature('lsqo').set('lsqdatamethod', 'lsq');

model.probe.create('var1', 'GlobalVariable');
model.probe('var1').model('comp1');
model.probe('var1').set('expr', 'eta_IR_1C');
model.probe.create('var2', 'GlobalVariable');
model.probe('var2').model('comp1');
model.probe('var2').set('expr', 'invJ0');
model.probe.create('var3', 'GlobalVariable');
model.probe('var3').model('comp1');
model.probe('var3').set('expr', 'tau');

model.sol.create('sol2');
model.sol('sol2').study('std2');

model.study('std2').feature('lsqo').set('lsqmessage', {});

model.sol('sol2').create('st1', 'StudyStep');
model.sol('sol2').feature('st1').set('study', 'std2');
model.sol('sol2').feature('st1').set('studystep', 'time');
model.sol('sol2').create('v1', 'Variables');
model.sol('sol2').feature('v1').feature('comp1_lb_vl1_SOC').set('scalemethod', 'manual');
model.sol('sol2').feature('v1').feature('comp1_lb_vl1_SOC').set('scaleval', '1');
model.sol('sol2').feature('v1').set('control', 'time');
model.sol('sol2').create('o1', 'Optimization');
model.sol('sol2').feature('o1').set('control', 'lsqo');
model.sol('sol2').feature('o1').create('t1', 'TimeAttrib');
model.sol('sol2').feature('o1').feature('t1').set('atolglobalvaluemethod', 'factor');
model.sol('sol2').feature('o1').feature('t1').set('eventout', true);
model.sol('sol2').feature('o1').feature('t1').set('reacf', true);
model.sol('sol2').feature('o1').feature('t1').set('storeudot', true);
model.sol('sol2').feature('o1').feature('t1').set('endtimeinterpolation', true);
model.sol('sol2').feature('o1').feature('t1').set('initialstepbdfactive', true);
model.sol('sol2').feature('o1').feature('t1').set('initialstepbdf', '(1)[s]');
model.sol('sol2').feature('o1').feature('t1').set('control', 'time');
model.sol('sol2').feature('o1').feature('t1').set('tlistlsq', [1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40 41 42 43 44 45 46 47 48 49 50 51 52 53 54 55 56 57 58 59 60 61 62 63 64 65 66 67 68 69 70 71 72 73 74 75 76 77 78 79 80 81 82 83 84 85 86 87 88 89 90 91 92 93 94 95 96 97 98 99 100 101 102 103 104 105 106 107 108 109 110 111 112 113 114 115 116 117 118 119 120 121 122 123 124 125 126 127 128 129 130 131 132 133 134 135 136 137 138 139 140 141 142 143 144 145 146 147 148 149 150 151 152 153 154 155 156 157 158 159 160 161 162 163 164 165 166 167 168 169 170 171 172 173 174 175 176 177 178 179 180 181 182 183 184 185 186 187 188 189 190 191 192 193 194 195 196 197 198 199 200 201 202 203 204 205 206 207 208 209 210 211 212 213 214 215 216 217 218 219 220 221 222 223 224 225 226 227 228 229 230 231 232 233 234 235 236 237 238 239 240 241 242 243 244 245 246 247 248 249 250 251 252 253 254 255 256 257 258 259 260 261 262 263 264 265 266 267 268 269 270 271 272 273 274 275 276 277 278 279 280 281 282 283 284 285 286 287 288 289 290 291 292 293 294 295 296 297 298 299 300]);
model.sol('sol2').feature('o1').feature('t1').set('lsqtimesout', ['      1.00' newline '      2.00' newline '      3.00' newline '      4.00' newline '      5.00' newline '      6.00' newline '      7.00' newline '      8.00' newline '      9.00' newline '      10.0' newline '      11.0' newline '      12.0' newline '      13.0' newline '      14.0' newline '      15.0' newline '      16.0' newline '      17.0' newline '      18.0' newline '      19.0' newline '      20.0' newline '      21.0' newline '      22.0' newline '      23.0' newline '      24.0' newline '      25.0' newline '      26.0' newline '      27.0' newline '      28.0' newline '      29.0' newline '      30.0' newline '      31.0' newline '      32.0' newline '      33.0' newline '      34.0' newline '      35.0' newline '      36.0' newline '      37.0' newline '      38.0' newline '      39.0' newline '      40.0' newline '      41.0' newline '      42.0' newline '      43.0' newline '      44.0' newline '      45.0' newline '      46.0' newline '      47.0' newline '      48.0' newline '      49.0' newline '      50.0' newline '      51.0' newline '      52.0' newline '      53.0' newline '      54.0' newline '      55.0' newline '      56.0' newline '      57.0' newline '      58.0' newline '      59.0' newline '      60.0' newline '      61.0' newline '      62.0' newline '      63.0' newline '      64.0' newline '      65.0' newline '      66.0' newline '      67.0' newline '      68.0' newline '      69.0' newline '      70.0' newline '      71.0' newline '      72.0' newline '      73.0' newline '      74.0' newline '      75.0' newline '      76.0' newline '      77.0' newline '      78.0' newline '      79.0' newline '      80.0' newline '      81.0' newline '      82.0' newline '      83.0' newline '      84.0' newline '      85.0' newline '      86.0' newline '      87.0' newline '      88.0' newline '      89.0' newline '      90.0' newline '      91.0' newline '      92.0' newline '      93.0' newline '      94.0' newline '      95.0' newline '      96.0' newline '      97.0' newline '      98.0' newline '      99.0' newline '       100' newline '       101' newline '       102' newline '       103' newline '       104' newline '       105' newline '       106' newline '       107' newline '       108' newline '       109' newline '       110' newline '       111' newline '       112' newline '       113' newline '       114' newline '       115' newline '       116' newline '       117' newline '       118' newline '       119' newline '       120' newline '       121' newline '       122' newline '       123' newline '       124' newline '       125' newline '       126' newline '       127' newline '       128' newline '       129' newline '       130' newline '       131' newline '       132' newline '       133' newline '       134' newline '       135' newline '       136' newline '       137' newline '       138' newline '       139' newline '       140' newline '       141' newline '       142' newline '       143' newline '       144' newline '       145' newline '       146' newline '       147' newline '       148' newline '       149' newline '       150' newline '       151' newline '       152' newline '       153' newline '       154' newline '       155' newline '       156' newline '       157' newline '       158' newline '       159' newline '       160' newline '       161' newline '       162' newline '       163' newline '       164' newline '       165' newline '       166' newline '       167' newline '       168' newline '       169' newline '       170' newline '       171' newline '       172' newline '       173' newline '       174' newline '       175' newline '       176' newline '       177' newline '       178' newline '       179' newline '       180' newline '       181' newline '       182' newline '       183' newline '       184' newline '       185' newline '       186' newline '       187' newline '       188' newline '       189' newline '       190' newline '       191' newline '       192' newline '       193' newline '       194' newline '       195' newline '       196' newline '       197' newline '       198' newline '       199' newline '       200' newline '       201' newline '       202' newline '       203' newline '       204' newline '       205' newline '       206' newline '       207' newline '       208' newline '       209' newline '       210' newline '       211' newline '       212' newline '       213' newline '       214' newline '       215' newline '       216' newline '       217' newline '       218' newline '       219' newline '       220' newline '       221' newline '       222' newline '       223' newline '       224' newline '       225' newline '       226' newline '       227' newline '       228' newline '       229' newline '       230' newline '       231' newline '       232' newline '       233' newline '       234' newline '       235' newline '       236' newline '       237' newline '       238' newline '       239' newline '       240' newline '       241' newline '       242' newline '       243' newline '       244' newline '       245' newline '       246' newline '       247' newline '       248' newline '       249' newline '       250' newline '       251' newline '       252' newline '       253' newline '       254' newline '       255' newline '       256' newline '       257' newline '       258' newline '       259' newline '       260' newline '       261' newline '       262' newline '       263' newline '       264' newline '       265' newline '       266' newline '       267' newline '       268' newline '       269' newline '       270' newline '       271' newline '       272' newline '       273' newline '       274' newline '       275' newline '       276' newline '       277' newline '       278' newline '       279' newline '       280' newline '       281' newline '       282' newline '       283' newline '       284' newline '       285' newline '       286' newline '       287' newline '       288' newline '       289' newline '       290' newline '       291' newline '       292' newline '       293' newline '       294' newline '       295' newline '       296' newline '       297' newline '       298' newline '       299' newline '       300' newline ]);
model.sol('sol2').feature('o1').feature('t1').set('tout', 'tlist');
model.sol('sol2').feature('o1').feature('t1').feature('aDef').set('cachepattern', true);
model.sol('sol2').feature('o1').feature('t1').create('fc1', 'FullyCoupled');
model.sol('sol2').feature('o1').feature('t1').feature('fc1').set('linsolver', 'dDef');
model.sol('sol2').feature('o1').feature('t1').feature.remove('fcDef');
model.sol('sol2').attach('std2');

model.probe('var1').genResult('none');
model.probe('var2').genResult('none');
model.probe('var3').genResult('none');

model.sol('sol2').runAll;

model.study('std2').feature('lsqo').set('probewindow', '');

model.result('pg1').run;
model.result('pg1').set('data', 'dset2');
model.result('pg1').run;
model.result('pg3').run;
model.result('pg3').set('data', 'dset2');
model.result('pg3').run;

model.study('std2').feature('lsqo').set('plot', true);

model.result.table.create('tbl4', 'Table');
model.result.table('tbl4').label('Full Load Cycle Data');
model.result.table('tbl4').importData('lumped_li_battery_parameter_estimation_E_I_vs_t_fulldata.txt');

model.func.create('int2', 'Interpolation');
model.func('int2').model('comp1');
model.func('int2').label('Interpolation - E and I vs. t (full)');
model.func('int2').set('source', 'resultTable');
model.func('int2').set('resultTable', 'tbl4');
model.func('int2').setIndex('funcs', 'E_cell_exp_full', 0, 0);
model.func('int2').setIndex('funcs', 'I_cell_exp_full', 1, 0);
model.func('int2').setIndex('funcs', 2, 1, 1);
model.func('int2').setIndex('argunit', 's', 0);

model.variable.duplicate('var2', 'var1');
model.variable('var2').set('I_cell_exp', 'I_cell_exp_full(t)[A]');
model.variable('var2').descr('I_cell_exp', 'Experimental cell current - full load cycle');
model.variable('var2').set('E_cell_exp', 'E_cell_exp_full(t)[V]');
model.variable('var2').descr('E_cell_exp', 'Experimental cell voltage - full load cycle');

model.study.create('std3');
model.study('std3').create('time', 'Transient');
model.study('std3').feature('time').setSolveFor('/physics/lb', true);
model.study('std3').label('Study 3 - Full Load Curve Prediction');
model.study('std3').feature('time').set('tlist', 'range(0,1,600)');
model.study('std3').feature('time').set('usertol', true);
model.study('std3').feature('time').set('rtol', 0.001);
model.study('std3').feature('time').set('useadvanceddisable', true);
model.study('std3').feature('time').set('disabledvariables', {'var1'});
model.study('std3').feature('time').set('useinitsol', true);
model.study('std3').feature('time').set('usesol', true);
model.study('std3').feature('time').set('notsolmethod', 'sol');
model.study('std3').feature('time').set('notstudy', 'std2');
model.study('std3').setGenPlots(false);
model.study('std1').feature('time').set('useadvanceddisable', true);
model.study('std1').feature('time').set('disabledvariables', {'var2'});
model.study('std2').feature('time').set('useadvanceddisable', true);
model.study('std2').feature('time').set('disabledvariables', {'var2'});

model.sol.create('sol3');
model.sol('sol3').study('std3');
model.sol('sol3').create('st1', 'StudyStep');
model.sol('sol3').feature('st1').set('study', 'std3');
model.sol('sol3').feature('st1').set('studystep', 'time');
model.sol('sol3').create('v1', 'Variables');
model.sol('sol3').feature('v1').feature('comp1_lb_vl1_SOC').set('scalemethod', 'manual');
model.sol('sol3').feature('v1').feature('comp1_lb_vl1_SOC').set('scaleval', '1');
model.sol('sol3').feature('v1').set('control', 'time');
model.sol('sol3').create('t1', 'Time');
model.sol('sol3').feature('t1').set('tlist', 'range(0,1,600)');
model.sol('sol3').feature('t1').set('plot', 'off');
model.sol('sol3').feature('t1').set('plotgroup', 'pg1');
model.sol('sol3').feature('t1').set('plotfreq', 'tout');
model.sol('sol3').feature('t1').set('probesel', 'all');
model.sol('sol3').feature('t1').set('probes', {'var1' 'var2' 'var3'});
model.sol('sol3').feature('t1').set('probefreq', 'tsteps');
model.sol('sol3').feature('t1').set('atolglobalvaluemethod', 'factor');
model.sol('sol3').feature('t1').set('eventout', true);
model.sol('sol3').feature('t1').set('reacf', true);
model.sol('sol3').feature('t1').set('storeudot', true);
model.sol('sol3').feature('t1').set('endtimeinterpolation', true);
model.sol('sol3').feature('t1').set('initialstepbdfactive', true);
model.sol('sol3').feature('t1').set('initialstepbdf', '(1)[s]');
model.sol('sol3').feature('t1').set('control', 'time');
model.sol('sol3').feature('t1').feature('aDef').set('cachepattern', true);
model.sol('sol3').feature('t1').create('fc1', 'FullyCoupled');
model.sol('sol3').feature('t1').feature('fc1').set('linsolver', 'dDef');
model.sol('sol3').feature('t1').feature.remove('fcDef');
model.sol('sol3').attach('std3');

model.probe('var1').genResult('none');
model.probe('var2').genResult('none');
model.probe('var3').genResult('none');

model.sol('sol3').runAll;

model.result('pg1').run;
model.result.duplicate('pg5', 'pg1');
model.result('pg5').run;
model.result('pg5').label('Cell Voltage: Full Cycle Prediction');
model.result('pg5').set('data', 'dset4');
model.result('pg5').set('xmax', 610);
model.result('pg5').set('legendpos', 'lowerleft');
model.result('pg5').run;
model.result('pg5').feature('glob1').setIndex('descr', 'Predicted cell voltage', 0);
model.result('pg5').run;
model.result.numerical.create('gev4', 'EvalGlobal');
model.result.numerical('gev4').label('Global Evaluation: Standard Deviation (Study1)');
model.result.numerical('gev4').setIndex('expr', 'lb.E_cell-E_cell_exp', 0);
model.result.numerical('gev4').set('dataseries', 'stddev');
model.result.table.create('tbl5', 'Table');
model.result.table('tbl5').comments('Global Evaluation: Standard Deviation (Study1)');
model.result.numerical('gev4').set('table', 'tbl5');
model.result.numerical('gev4').setResult;
model.result.numerical.duplicate('gev5', 'gev4');
model.result.numerical('gev5').label('Global Evaluation: Standard Deviation (Study2)');
model.result.numerical('gev5').set('data', 'dset2');
model.result.numerical('gev5').set('table', 'tbl5');
model.result.numerical('gev5').appendResult;
model.result.numerical.duplicate('gev6', 'gev5');
model.result.numerical('gev6').label('Global Evaluation: Standard Deviation (Study3)');
model.result.numerical('gev6').set('data', 'dset4');
model.result.numerical('gev6').setIndex('looplevelinput', 'manualindices', 0);
model.result.numerical('gev6').setIndex('looplevelindices', 'range(302,1,601)', 0);
model.result.numerical('gev6').set('table', 'tbl5');
model.result.numerical('gev6').appendResult;

model.title('Parameter Estimation of a Time-Dependent Lumped Battery Model');

model.description(['This tutorial uses a "black-box" approach to define a battery model based on a small set of lumped parameters, assuming no knowledge of the internal structure or design of the battery electrodes, or choice of materials.' newline  newline 'The input to the model is the battery capacity, the initial state of charge (SOC), and an open circuit voltage vs SOC curve, in combination with load cycle experimental data.' newline  newline 'The lumped parameters are determined using the Parameter Estimation study step.']);

model.mesh.clearMeshes;

model.sol('sol1').clearSolutionData;
model.sol('sol2').clearSolutionData;
model.sol('sol3').clearSolutionData;

model.label('lumped_li_battery_parameter_estimation.mph');

model.modelNode.label('Components');

out = model;
