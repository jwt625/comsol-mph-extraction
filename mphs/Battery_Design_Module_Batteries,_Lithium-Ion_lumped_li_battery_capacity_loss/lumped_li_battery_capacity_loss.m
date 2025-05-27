function out = model
%
% lumped_li_battery_capacity_loss.m
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
model.param.set('eta_IR_1C', '4.5[mV]', 'Ohmic overpotential at 1C');
model.param.set('invJ0', '0.862', 'Inverse dimensionless charge exchange current');
model.param.set('tau', '1375[s]', 'Diffusion time constant');
model.param.set('J0', '1/invJ0', 'Dimensionless charge exchange current');
model.param.set('tau_loss', '5[a]', 'Calendar aging time constant');
model.param.set('E_offset', '0.3[V]', 'Offset potential');
model.param.set('alpha', '0.35', 'Transfer coefficient');
model.param.set('G', '50', 'Decelerating aging factor');
model.param.set('H', '2e-3', 'Cycling capacity loss factor');
model.param.set('Q_cell0', '12[A*h]', 'Battery capacity');
model.param.set('SOC_0', '1', 'Initial state of charge');
model.param.set('T', '298.15[K]', 'Temperature');
model.param.set('V_min', '3.2[V]', 'Minimum voltage');
model.param.set('V_max', '4.15[V]', 'Maximum voltage');
model.param.set('t_rest', '500[s]', 'Resting time');

model.func.create('int1', 'Interpolation');
model.func('int1').model('comp1');
model.func('int1').label('Interpolation 1 - E_OCP');
model.func('int1').set('funcname', 'E_OCP');
model.func('int1').set('table', {'0' '1.3104190837885064';  ...
'0.01' '2.2611069048882873';  ...
'0.02' '2.8334213300309643';  ...
'0.030000000000000002' '3.1844362423678003';  ...
'0.04' '3.393016295869783';  ...
'0.05' '3.510875145406253';  ...
'0.060000000000000005' '3.5869463584273378';  ...
'0.07' '3.6264514929037994';  ...
'0.08' '3.6557565420023983';  ...
'0.09000000000000001' '3.6850615911009976';  ...
'0.1' '3.6994551120045407';  ...
'0.11' '3.7113345164250635';  ...
'0.12000000000000001' '3.7232139208455868';  ...
'0.13' '3.7350933252661096';  ...
'0.14' '3.746972729686633';  ...
'0.15' '3.7588394760123167';  ...
'0.16' '3.7669805471052284';  ...
'0.17' '3.7751216181981406';  ...
'0.18000000000000002' '3.7832626892910524';  ...
'0.19' '3.7914037603839645';  ...
'0.2' '3.7995448314768763';  ...
'0.21000000000000002' '3.8076859025697884';  ...
'0.22' '3.8158269736627';  ...
'0.23' '3.8239680447556124';  ...
'0.24000000000000002' '3.832109115848524';  ...
'0.25' '3.8402384951548894';  ...
'0.26' '3.844926614135922';  ...
'0.27' '3.8496147331169555';  ...
'0.28' '3.8543028520979887';  ...
'0.29000000000000004' '3.8589909710790216';  ...
'0.3' '3.863679090060055';  ...
'0.31' '3.8683672090410877';  ...
'0.32' '3.873055328022121';  ...
'0.33' '3.877743447003154';  ...
'0.34' '3.882431565984187';  ...
'0.35000000000000003' '3.8871182387192977';  ...
'0.36000000000000004' '3.891379235814907';  ...
'0.37' '3.8956402329105164';  ...
'0.38' '3.900108284697505';  ...
'0.39' '3.9048921849677303';  ...
'0.4' '3.910004858946812';  ...
'0.41000000000000003' '3.9155565350495363';  ...
'0.42000000000000004' '3.9213824207219656';  ...
'0.43' '3.927676048105941';  ...
'0.44' '3.9340438371441717';  ...
'0.45' '3.94051108662678';  ...
'0.46' '3.9470234377800457';  ...
'0.47000000000000003' '3.9533348394394214';  ...
'0.48000000000000004' '3.9592735197022777';  ...
'0.49000000000000005' '3.9650124251831564';  ...
'0.5' '3.970366661250179';  ...
'0.51' '3.975134457606617';  ...
'0.52' '3.979408469784772';  ...
'0.53' '3.9832924969139087';  ...
'0.54' '3.986400783870235';  ...
'0.55' '3.989209391104789';  ...
'0.56' '3.9920179983393425';  ...
'0.5700000000000001' '3.994805300205646';  ...
'0.5800000000000001' '3.9971563232603926';  ...
'0.5900000000000001' '3.9995073463151387';  ...
'0.6' '4.001858369369885';  ...
'0.61' '4.004209392424632';  ...
'0.62' '4.006560415479378';  ...
'0.63' '4.008911438534124';  ...
'0.64' '4.011262461588871';  ...
'0.65' '4.014107842011973';  ...
'0.66' '4.017168121841405';  ...
'0.67' '4.020228401670838';  ...
'0.68' '4.02328868150027';  ...
'0.6900000000000001' '4.0263489613297025';  ...
'0.7000000000000001' '4.029409241159136';  ...
'0.7100000000000001' '4.032469520988568';  ...
'0.7200000000000001' '4.03470071596249';  ...
'0.73' '4.035374828848886';  ...
'0.74' '4.036048941735283';  ...
'0.75' '4.036723054621679';  ...
'0.76' '4.037397167508075';  ...
'0.77' '4.038071280394472';  ...
'0.78' '4.038745393280867';  ...
'0.79' '4.039419506167263';  ...
'0.8' '4.039965701342635';  ...
'0.81' '4.040511627548762';  ...
'0.8200000000000001' '4.041057553754889';  ...
'0.8300000000000001' '4.041603479961017';  ...
'0.8400000000000001' '4.042149406167145';  ...
'0.8500000000000001' '4.042695332373272';  ...
'0.86' '4.0432412585794';  ...
'0.87' '4.04546697590993';  ...
'0.88' '4.048603777764223';  ...
'0.89' '4.0517405796185155';  ...
'0.9' '4.054877381472807';  ...
'0.91' '4.0580141833271';  ...
'0.92' '4.061150985181393';  ...
'0.93' '4.064287787035685';  ...
'0.9400000000000001' '4.069434668295399';  ...
'0.9500000000000001' '4.079298736570241';  ...
'0.9600000000000001' '4.091601063364331';  ...
'0.9700000000000001' '4.110991916734893';  ...
'0.9800000000000001' '4.13395738036637';  ...
'0.9900000000000001' '4.167078533171239';  ...
'1' '4.204442586248173'});

model.physics('lb').prop('BatterySettings').set('OperationMode', 'Potentiostatic');
model.physics('lb').prop('BatterySettings').set('E_app', 'E_OCP(SOC_0)');
model.physics('lb').prop('BatterySettings').set('Q_cell0', 'Q_cell0');
model.physics('lb').prop('BatterySettings').set('SOC_cell0', 'SOC_0');
model.physics('lb').feature('cep1').set('OpenCircuitVoltageInput', 'fromdef');
model.physics('lb').feature('cep1').set('Eocvdef', 'int1');
model.physics('lb').feature('vl1').set('minput_temperature', 'T');
model.physics('lb').feature('vl1').set('eta_ir1C', 'eta_IR_1C');
model.physics('lb').feature('vl1').set('J0', 'J0');
model.physics('lb').feature('vl1').set('IncludeConcentrationOverpotential', true);
model.physics('lb').feature('vl1').set('tau', 'tau');
model.physics('lb').create('cl1', 'CapacityLoss', -1);
model.physics('lb').feature('cl1').set('minput_temperature', 'T');
model.physics('lb').feature('cl1').set('tau_loss', 'tau_loss');
model.physics('lb').feature('cl1').set('factorE', true);
model.physics('lb').feature('cl1').set('E_offset', 'E_offset');
model.physics('lb').feature('cl1').set('alpha', 'alpha');
model.physics('lb').feature('cl1').set('factoraged', true);
model.physics('lb').feature('cl1').set('G', 'G');

model.study('std1').label('Study 1: Calendar Life');
model.study('std1').create('param', 'Parametric');
model.study('std1').feature('param').setIndex('pname', 'eta_IR_1C', 0);
model.study('std1').feature('param').setIndex('plistarr', '', 0);
model.study('std1').feature('param').setIndex('punit', 'V', 0);
model.study('std1').feature('param').setIndex('pname', 'eta_IR_1C', 0);
model.study('std1').feature('param').setIndex('plistarr', '', 0);
model.study('std1').feature('param').setIndex('punit', 'V', 0);
model.study('std1').feature('param').setIndex('pname', 'SOC_0', 0);
model.study('std1').feature('param').setIndex('plistarr', '0.25 0.5 1', 0);
model.study('std1').feature('time').set('tlist', 'range(0,10[d],2[a])');
model.study('std1').setGenPlots(false);

model.sol.create('sol1');
model.sol('sol1').study('std1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'time');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').feature('comp1_lb_Q_norm').set('scalemethod', 'manual');
model.sol('sol1').feature('v1').feature('comp1_lb_vl1_SOC').set('scalemethod', 'manual');
model.sol('sol1').feature('v1').feature('comp1_lb_Q_norm').set('scaleval', '1');
model.sol('sol1').feature('v1').feature('comp1_lb_vl1_SOC').set('scaleval', '1');
model.sol('sol1').feature('v1').set('control', 'time');
model.sol('sol1').create('t1', 'Time');
model.sol('sol1').feature('t1').set('tlist', 'range(0,10[d],2[a])');
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

model.batch.create('p1', 'Parametric');
model.batch('p1').study('std1');
model.batch('p1').create('so1', 'Solutionseq');
model.batch('p1').feature('so1').set('seq', 'sol1');
model.batch('p1').feature('so1').set('store', 'on');
model.batch('p1').feature('so1').set('clear', 'on');
model.batch('p1').feature('so1').set('psol', 'none');
model.batch('p1').set('pname', {'SOC_0'});
model.batch('p1').set('plistarr', {'0.25 0.5 1'});
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
model.result('pg1').run;
model.result('pg1').label('Cell State-of-Health');
model.result('pg1').set('data', 'dset2');
model.result('pg1').create('glob1', 'Global');
model.result('pg1').feature('glob1').set('markerpos', 'datapoints');
model.result('pg1').feature('glob1').set('linewidth', 'preference');
model.result('pg1').feature('glob1').set('expr', {'lb.SOH_cell'});
model.result('pg1').feature('glob1').set('descr', {'Cell state of health'});
model.result('pg1').feature('glob1').set('unit', {'1'});
model.result('pg1').feature('glob1').set('xdataparamunit', 'a');
model.result('pg1').feature('glob1').set('legendmethod', 'evaluated');
model.result('pg1').feature('glob1').set('legendpattern', 'eval(SOC_0*100)% SOC');
model.result('pg1').run;
model.result('pg1').set('titletype', 'none');
model.result('pg1').set('legendpos', 'lowerleft');
model.result('pg1').run;

model.physics('lb').prop('BatterySettings').set('OperationMode', 'ChargeDischargeCycling');
model.physics('lb').prop('BatterySettings').set('Idch', '-lb.I_1C');
model.physics('lb').prop('BatterySettings').set('Vmin', 'V_min');
model.physics('lb').prop('BatterySettings').set('item.OCDCH', true);
model.physics('lb').prop('BatterySettings').set('tredch', 't_rest');
model.physics('lb').prop('BatterySettings').set('Ich', 'lb.I_1C');
model.physics('lb').prop('BatterySettings').set('Vmax', 'V_max');
model.physics('lb').prop('BatterySettings').set('item.OCCH', true);
model.physics('lb').prop('BatterySettings').set('trech', 't_rest');
model.physics('lb').feature('cl1').set('factorI', true);
model.physics('lb').feature('cl1').set('H', 'H');

model.study.create('std2');
model.study('std2').create('time', 'Transient');
model.study('std2').feature('time').setSolveFor('/physics/lb', true);
model.study('std2').label('Study 2: Single Load Cycle');
model.study('std2').feature('time').set('tlist', 'range(0,1,7800)');

model.sol.create('sol6');
model.sol('sol6').study('std2');
model.sol('sol6').create('st1', 'StudyStep');
model.sol('sol6').feature('st1').set('study', 'std2');
model.sol('sol6').feature('st1').set('studystep', 'time');
model.sol('sol6').create('v1', 'Variables');
model.sol('sol6').feature('v1').feature('comp1_lb_Q_norm').set('scalemethod', 'manual');
model.sol('sol6').feature('v1').feature('comp1_lb_vl1_SOC').set('scalemethod', 'manual');
model.sol('sol6').feature('v1').feature('comp1_lb_Q_norm').set('scaleval', '1');
model.sol('sol6').feature('v1').feature('comp1_lb_vl1_SOC').set('scaleval', '1');
model.sol('sol6').feature('v1').set('control', 'time');
model.sol('sol6').create('t1', 'Time');
model.sol('sol6').feature('t1').set('tlist', 'range(0,1,7800)');
model.sol('sol6').feature('t1').set('plot', 'off');
model.sol('sol6').feature('t1').set('plotgroup', 'pg1');
model.sol('sol6').feature('t1').set('plotfreq', 'tout');
model.sol('sol6').feature('t1').set('probesel', 'all');
model.sol('sol6').feature('t1').set('probes', {});
model.sol('sol6').feature('t1').set('probefreq', 'tsteps');
model.sol('sol6').feature('t1').set('atolglobalvaluemethod', 'factor');
model.sol('sol6').feature('t1').set('eventout', true);
model.sol('sol6').feature('t1').set('reacf', true);
model.sol('sol6').feature('t1').set('storeudot', true);
model.sol('sol6').feature('t1').set('endtimeinterpolation', true);
model.sol('sol6').feature('t1').set('initialstepbdfactive', true);
model.sol('sol6').feature('t1').set('initialstepbdf', '(1)[s]');
model.sol('sol6').feature('t1').set('control', 'time');
model.sol('sol6').feature('t1').feature('aDef').set('cachepattern', true);
model.sol('sol6').feature('t1').create('fc1', 'FullyCoupled');
model.sol('sol6').feature('t1').feature('fc1').set('linsolver', 'dDef');
model.sol('sol6').feature('t1').feature.remove('fcDef');
model.sol('sol6').attach('std2');
model.sol('sol6').runAll;

model.result.create('pg2', 'PlotGroup1D');
model.result('pg2').label('Cell Potential and Load (lb)');
model.result('pg2').set('data', 'dset3');
model.result('pg2').set('showlooplevelinput', {'off' 'off' 'off'});
model.result('pg2').set('ylabel', 'Cell potential (V)');
model.result('pg2').set('showsecylabel', 'on');
model.result('pg2').set('twoyaxes', true);
model.result('pg2').set('legendpos', 'lowerleft');
model.result('pg2').set('data', 'dset3');
model.result('pg2').set('defaultPlotID', 'BFCMeshStudyResultDefaultsComponents/icom32/pdef1/pcond1/pg1');
model.result('pg2').feature.create('glob1', 'Global');
model.result('pg2').feature('glob1').set('showsolutionparams', 'on');
model.result('pg2').feature('glob1').set('expr', {'lb.E_cell'});
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
model.result('pg2').feature('glob2').set('expr', {'lb.Eocv_cell'});
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
model.result('pg2').feature.create('glob3', 'Global');
model.result('pg2').feature('glob3').set('showsolutionparams', 'on');
model.result('pg2').feature('glob3').set('plotonsecyaxis', true);
model.result('pg2').feature('glob3').set('expr', {'lb.I_cell'});
model.result('pg2').feature('glob3').set('xdatasolnumtype', 'inner');
model.result('pg2').feature('glob3').set('showunitcombo', 'off');
model.result('pg2').feature('glob3').set('showsolutionparams', 'on');
model.result('pg2').feature('glob3').set('xdatasolnumtype', 'inner');
model.result('pg2').feature('glob3').set('showunitcombo', 'off');
model.result('pg2').feature('glob3').set('showsolutionparams', 'on');
model.result('pg2').feature('glob3').set('xdatasolnumtype', 'inner');
model.result('pg2').feature('glob3').set('showunitcombo', 'off');
model.result('pg2').feature('glob3').set('showsolutionparams', 'on');
model.result('pg2').feature('glob3').set('xdatasolnumtype', 'inner');
model.result('pg2').feature('glob3').set('showunitcombo', 'off');
model.result('pg2').feature('glob3').set('showsolutionparams', 'on');
model.result('pg2').feature('glob3').set('xdatasolnumtype', 'inner');
model.result('pg2').feature('glob3').set('showunitcombo', 'off');
model.result('pg2').feature('glob3').set('data', 'parent');
model.result.create('pg3', 'PlotGroup1D');
model.result('pg3').label('Cell State of Charge (lb)');
model.result('pg3').set('data', 'dset3');
model.result('pg3').set('showlooplevelinput', {'off' 'off' 'off'});
model.result('pg3').set('showsecylabel', 'on');
model.result('pg3').set('twoyaxes', true);
model.result('pg3').set('legendpos', 'lowerleft');
model.result('pg3').set('data', 'dset3');
model.result('pg3').set('defaultPlotID', 'BFCMeshStudyResultDefaultsComponents/icom32/pdef1/pcond1/pg2');
model.result('pg3').feature.create('glob1', 'Global');
model.result('pg3').feature('glob1').set('showsolutionparams', 'on');
model.result('pg3').feature('glob1').set('expr', {'lb.SOC_cell'});
model.result('pg3').feature('glob1').set('xdatasolnumtype', 'inner');
model.result('pg3').feature('glob1').set('showunitcombo', 'off');
model.result('pg3').feature('glob1').set('showsolutionparams', 'on');
model.result('pg3').feature('glob1').set('xdatasolnumtype', 'inner');
model.result('pg3').feature('glob1').set('showunitcombo', 'off');
model.result('pg3').feature('glob1').set('showsolutionparams', 'on');
model.result('pg3').feature('glob1').set('xdatasolnumtype', 'inner');
model.result('pg3').feature('glob1').set('showunitcombo', 'off');
model.result('pg3').feature('glob1').set('showsolutionparams', 'on');
model.result('pg3').feature('glob1').set('xdatasolnumtype', 'inner');
model.result('pg3').feature('glob1').set('showunitcombo', 'off');
model.result('pg3').feature('glob1').set('showsolutionparams', 'on');
model.result('pg3').feature('glob1').set('xdatasolnumtype', 'inner');
model.result('pg3').feature('glob1').set('showunitcombo', 'off');
model.result('pg3').feature('glob1').set('data', 'parent');
model.result('pg3').feature.create('glob2', 'Global');
model.result('pg3').feature('glob2').set('showsolutionparams', 'on');
model.result('pg3').feature('glob2').set('plotonsecyaxis', true);
model.result('pg3').feature('glob2').set('expr', {'lb.I_cell'});
model.result('pg3').feature('glob2').set('xdatasolnumtype', 'inner');
model.result('pg3').feature('glob2').set('showunitcombo', 'off');
model.result('pg3').feature('glob2').set('showsolutionparams', 'on');
model.result('pg3').feature('glob2').set('xdatasolnumtype', 'inner');
model.result('pg3').feature('glob2').set('showunitcombo', 'off');
model.result('pg3').feature('glob2').set('showsolutionparams', 'on');
model.result('pg3').feature('glob2').set('xdatasolnumtype', 'inner');
model.result('pg3').feature('glob2').set('showunitcombo', 'off');
model.result('pg3').feature('glob2').set('showsolutionparams', 'on');
model.result('pg3').feature('glob2').set('xdatasolnumtype', 'inner');
model.result('pg3').feature('glob2').set('showunitcombo', 'off');
model.result('pg3').feature('glob2').set('showsolutionparams', 'on');
model.result('pg3').feature('glob2').set('xdatasolnumtype', 'inner');
model.result('pg3').feature('glob2').set('showunitcombo', 'off');
model.result('pg3').feature('glob2').set('data', 'parent');
model.result('pg2').run;
model.result('pg2').label('Cell Potential and Load (Single Load Cycle)');
model.result('pg2').set('titletype', 'none');
model.result('pg2').set('legendpos', 'lowerright');
model.result('pg3').run;
model.result('pg3').label('Cell State of Charge (Single Load Cycle)');
model.result('pg3').set('titletype', 'none');
model.result('pg3').set('legendpos', 'lowerright');

model.study.create('std3');
model.study('std3').create('time', 'Transient');
model.study('std3').feature('time').setSolveFor('/physics/lb', true);
model.study('std3').label('Study 3: Cycle Life');
model.study('std3').feature('time').set('tlist', 'range(0,10[d],1[a])');
model.study('std3').setGenPlots(false);

model.sol.create('sol7');
model.sol('sol7').study('std3');
model.sol('sol7').create('st1', 'StudyStep');
model.sol('sol7').feature('st1').set('study', 'std3');
model.sol('sol7').feature('st1').set('studystep', 'time');
model.sol('sol7').create('v1', 'Variables');
model.sol('sol7').feature('v1').feature('comp1_lb_Q_norm').set('scalemethod', 'manual');
model.sol('sol7').feature('v1').feature('comp1_lb_vl1_SOC').set('scalemethod', 'manual');
model.sol('sol7').feature('v1').feature('comp1_lb_Q_norm').set('scaleval', '1');
model.sol('sol7').feature('v1').feature('comp1_lb_vl1_SOC').set('scaleval', '1');
model.sol('sol7').feature('v1').set('control', 'time');
model.sol('sol7').create('t1', 'Time');
model.sol('sol7').feature('t1').set('tlist', 'range(0,10[d],1[a])');
model.sol('sol7').feature('t1').set('plot', 'off');
model.sol('sol7').feature('t1').set('plotgroup', 'pg1');
model.sol('sol7').feature('t1').set('plotfreq', 'tout');
model.sol('sol7').feature('t1').set('probesel', 'all');
model.sol('sol7').feature('t1').set('probes', {});
model.sol('sol7').feature('t1').set('probefreq', 'tsteps');
model.sol('sol7').feature('t1').set('atolglobalvaluemethod', 'factor');
model.sol('sol7').feature('t1').set('eventout', true);
model.sol('sol7').feature('t1').set('reacf', true);
model.sol('sol7').feature('t1').set('storeudot', true);
model.sol('sol7').feature('t1').set('endtimeinterpolation', true);
model.sol('sol7').feature('t1').set('initialstepbdfactive', true);
model.sol('sol7').feature('t1').set('initialstepbdf', '(1)[s]');
model.sol('sol7').feature('t1').set('control', 'time');
model.sol('sol7').feature('t1').feature('aDef').set('cachepattern', true);
model.sol('sol7').feature('t1').create('fc1', 'FullyCoupled');
model.sol('sol7').feature('t1').feature('fc1').set('linsolver', 'dDef');
model.sol('sol7').feature('t1').feature.remove('fcDef');
model.sol('sol7').attach('std3');
model.sol('sol7').runAll;

model.result('pg1').run;
model.result('pg1').run;
model.result('pg1').feature.duplicate('glob2', 'glob1');
model.result('pg1').run;
model.result('pg1').feature('glob2').set('data', 'dset4');
model.result('pg1').feature('glob2').set('legendmethod', 'manual');
model.result('pg1').feature('glob2').setIndex('legends', '1 C cycling', 0);
model.result('pg1').run;
model.result('pg1').run;

model.title('Aging Analysis of a Lumped Battery Model');

model.description(['This tutorial demonstrates the Lumped Battery interface for modeling capacity loss in a battery. A set of lumped parameters are used to describe the capacity loss that occurs due to parasitic reactions in the battery, assuming no knowledge of the internal structure or design of the battery electrodes, or choice of materials.' newline  newline 'The aging analysis includes calendar life and cycle life studies.']);

model.mesh.clearMeshes;

model.sol('sol1').clearSolutionData;
model.sol('sol2').clearSolutionData;
model.sol('sol3').clearSolutionData;
model.sol('sol4').clearSolutionData;
model.sol('sol5').clearSolutionData;
model.sol('sol6').clearSolutionData;
model.sol('sol7').clearSolutionData;

model.label('lumped_li_battery_capacity_loss.mph');

model.modelNode.label('Components');

out = model;
