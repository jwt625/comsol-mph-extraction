function out = model
%
% over_discharge_protection.m
%
% Model exported on May 26 2025, 21:25 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/Battery_Design_Module/Batteries,_General');

model.modelNode.create('comp1', true);

model.physics.create('lb', 'LumpedBattery');
model.physics('lb').model('comp1');
model.physics.create('lb2', 'LumpedBattery');
model.physics('lb2').model('comp1');
model.physics.create('cir', 'Circuit');
model.physics('cir').model('comp1');

model.study.create('std1');
model.study('std1').create('time', 'Transient');
model.study('std1').feature('time').setSolveFor('/physics/lb', true);
model.study('std1').feature('time').setSolveFor('/physics/lb2', true);
model.study('std1').feature('time').setSolveFor('/physics/cir', true);

% To import content from file, use:
% model.param.loadFile('FILENAME');
model.param.set('eta_IR_1C', '4.5[mV]', 'Ohmic overpotential at 1C');
model.param.set('invJ0', '0.862', 'Inverse dimensionless charge exchange current');
model.param.set('tau', '1375[s]', 'Diffusion time constant');
model.param.set('J0', '1/invJ0', 'Dimensionless charge exchange current');
model.param.set('Q_cell0', '12[A*h]', 'Battery capacity');
model.param.set('SOC_0', '1', 'Initial state of charge');
model.param.set('T', '298.15[K]', 'Temperature');
model.param.set('C_rate', '0.5', 'C-rate');
model.param.set('I_1C', 'Q_cell0/3600[s]', '1C discharge');
model.param.set('I_app', 'I_1C*C_rate', 'Applied current');
model.param.set('t_stop', '(1[h]*SOC_window)/C_rate', 'Time to stop');
model.param.set('SOC_stop', '0.2', 'Minimum SOC level');
model.param.set('SOC_window', 'SOC_0-SOC_stop', 'SOC window for simulation');
model.param.set('R1', '1e8[ohm]', 'Shunt resistor value');
model.param.set('G_short', '0.5[S]', 'Short circuit conductance');
model.param.set('t_short_start', '50[s]', 'Onset for short circuit in battery');

model.func.create('step1', 'Step');
model.func('step1').model('comp1');
model.func('step1').label('Short');
model.func.create('int1', 'Interpolation');
model.func('int1').model('comp1');
model.func('int1').label('E_OCP');
model.func('int1').set('source', 'file');
model.func('int1').set('filename', 'over_discharge_protection_E_OCP.txt');
model.func('int1').importData;
model.func('int1').set('extrap', 'interior');
model.func('int1').setIndex('argunit', 1, 0);
model.func('int1').setIndex('fununit', 'V', 0);

model.physics('lb').prop('BatterySettings').set('OperationMode', 'CircuitTerminal');
model.physics('lb').prop('BatterySettings').set('Q_cell0', 'Q_cell0');
model.physics('lb').prop('BatterySettings').set('SOC_cell0', 'SOC_0');
model.physics('lb').feature('cep1').set('OpenCircuitVoltageInput', 'fromdef');
model.physics('lb').feature('cep1').set('Eocvdef', 'int1');
model.physics('lb').feature('vl1').set('eta_ir1C', 'eta_IR_1C');
model.physics('lb').feature('vl1').set('J0', 'J0');
model.physics('lb').feature('vl1').set('IncludeConcentrationOverpotential', true);
model.physics('lb').feature('vl1').set('tau', 'tau');
model.physics('lb').create('isc1', 'ShortCircuit', -1);
model.physics('lb').feature('isc1').set('G_short', 'G_short*step1((t-t_short_start)/1[s])');
model.physics('lb2').prop('BatterySettings').set('OperationMode', 'CircuitTerminal');
model.physics('lb2').prop('BatterySettings').set('Q_cell0', 'Q_cell0');
model.physics('lb2').prop('BatterySettings').set('SOC_cell0', 'SOC_0');
model.physics('lb2').feature('cep1').set('OpenCircuitVoltageInput', 'fromdef');
model.physics('lb2').feature('cep1').set('Eocvdef', 'int1');
model.physics('lb2').feature('vl1').set('eta_ir1C', 'eta_IR_1C');
model.physics('lb2').feature('vl1').set('J0', 'J0');
model.physics('lb2').feature('vl1').set('IncludeConcentrationOverpotential', true);
model.physics('lb2').feature('vl1').set('tau', 'tau');
model.physics('cir').create('I1', 'CurrentSourceCircuit', -1);
model.physics('cir').feature('I1').setIndex('Connections', 0, 1, 0);
model.physics('cir').feature('I1').set('value', 'I_app');
model.physics('cir').create('IvsU1', 'ModelDeviceIV', -1);
model.physics('cir').feature('IvsU1').label('Lumped Battery 1');
model.physics('cir').feature('IvsU1').setIndex('Connections', 1, 0, 0);
model.physics('cir').feature('IvsU1').setIndex('Connections', 2, 1, 0);
model.physics('cir').feature('IvsU1').set('V_src', 'root.comp1.lb.vl1.VCircuit');
model.physics('cir').feature.duplicate('IvsU2', 'IvsU1');
model.physics('cir').feature('IvsU2').label('Lumped Battery 2');
model.physics('cir').feature('IvsU2').setIndex('Connections', 2, 0, 0);
model.physics('cir').feature('IvsU2').setIndex('Connections', 3, 1, 0);
model.physics('cir').feature('IvsU2').set('V_src', 'root.comp1.lb2.vl1.VCircuit');
model.physics('cir').create('R1', 'Resistor', -1);
model.physics('cir').feature('R1').setIndex('Connections', 3, 0, 0);
model.physics('cir').feature('R1').setIndex('Connections', 0, 1, 0);
model.physics('cir').feature('R1').set('R', ['10[m' 'ohm' ']']);
model.physics('cir').create('vm1', 'VoltMeter', -1);
model.physics('cir').feature('vm1').setIndex('Connections', 1, 0, 0);
model.physics('cir').feature('vm1').setIndex('Connections', 3, 1, 0);

model.study('std1').label('Study 1: Without Shunts');
model.study('std1').setGenPlots(false);
model.study('std1').feature('time').set('tlist', 'range(0,100,10000)');
model.study('std1').feature('time').set('useparam', true);
model.study('std1').feature('time').set('sweeptype', 'filled');
model.study('std1').feature('time').setIndex('pname', 'eta_IR_1C', 0);
model.study('std1').feature('time').setIndex('plistarr', '', 0);
model.study('std1').feature('time').setIndex('punit', 'V', 0);
model.study('std1').feature('time').setIndex('pname', 'eta_IR_1C', 0);
model.study('std1').feature('time').setIndex('plistarr', '', 0);
model.study('std1').feature('time').setIndex('punit', 'V', 0);
model.study('std1').feature('time').setIndex('pname', 'C_rate', 0);
model.study('std1').feature('time').setIndex('plistarr', '0.5 2', 0);

model.sol.create('sol1');
model.sol('sol1').study('std1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'time');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').feature('comp1_lb2_vl1_SOC').set('scalemethod', 'manual');
model.sol('sol1').feature('v1').feature('comp1_lb_vl1_SOC').set('scalemethod', 'manual');
model.sol('sol1').feature('v1').feature('comp1_lb2_vl1_SOC').set('scaleval', '1');
model.sol('sol1').feature('v1').feature('comp1_lb_vl1_SOC').set('scaleval', '1');
model.sol('sol1').feature('v1').set('control', 'time');
model.sol('sol1').create('t1', 'Time');
model.sol('sol1').feature('t1').set('tlist', 'range(0,100,10000)');
model.sol('sol1').feature('t1').set('plot', 'off');
model.sol('sol1').feature('t1').set('plotgroup', 'Default');
model.sol('sol1').feature('t1').set('plotfreq', 'tout');
model.sol('sol1').feature('t1').set('probesel', 'all');
model.sol('sol1').feature('t1').set('probes', {'VoltMeter_cir_vm1'});
model.sol('sol1').feature('t1').set('probefreq', 'tsteps');
model.sol('sol1').feature('t1').set('atolglobalvaluemethod', 'factor');
model.sol('sol1').feature('t1').set('eventout', true);
model.sol('sol1').feature('t1').set('reacf', true);
model.sol('sol1').feature('t1').set('storeudot', true);
model.sol('sol1').feature('t1').set('endtimeinterpolation', true);
model.sol('sol1').feature('t1').set('initialstepbdfactive', true);
model.sol('sol1').feature('t1').set('initialstepbdf', '(1)[s]');
model.sol('sol1').feature('t1').create('tp1', 'TimeParametric');
model.sol('sol1').feature('t1').feature.remove('tpDef');
model.sol('sol1').feature('t1').feature('tp1').set('control', 'time');
model.sol('sol1').feature('t1').set('control', 'time');
model.sol('sol1').feature('t1').feature('aDef').set('cachepattern', true);
model.sol('sol1').feature('t1').create('seDef', 'Segregated');
model.sol('sol1').feature('t1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('t1').feature('fc1').set('linsolver', 'dDef');
model.sol('sol1').feature('t1').feature.remove('fcDef');
model.sol('sol1').feature('t1').feature.remove('seDef');
model.sol('sol1').attach('std1');
model.sol('sol1').feature('t1').create('st1', 'StopCondition');
model.sol('sol1').feature('t1').feature('st1').setIndex('stopcondarr', '', 0);
model.sol('sol1').feature('t1').feature('st1').setIndex('stopcondterminateon', 'true', 0);
model.sol('sol1').feature('t1').feature('st1').setIndex('stopcondActive', true, 0);
model.sol('sol1').feature('t1').feature('st1').setIndex('stopconddesc', 'Stop expression 1', 0);
model.sol('sol1').feature('t1').feature('st1').setIndex('stopcondarr', '', 0);
model.sol('sol1').feature('t1').feature('st1').setIndex('stopcondterminateon', 'true', 0);
model.sol('sol1').feature('t1').feature('st1').setIndex('stopcondActive', true, 0);
model.sol('sol1').feature('t1').feature('st1').setIndex('stopconddesc', 'Stop expression 1', 0);
model.sol('sol1').feature('t1').feature('st1').setIndex('stopcondarr', 'comp1.lb2.SOC_cell<=0.0', 0);

model.probe('VoltMeter_cir_vm1').genResult('none');

model.sol('sol1').runAll;

model.result.create('pg2', 'PlotGroup1D');
model.result('pg2').run;
model.result('pg2').label('Cell Voltage');
model.result('pg2').set('data', 'none');
model.result('pg2').set('titletype', 'label');
model.result('pg2').set('ylabelactive', true);
model.result('pg2').set('ylabel', 'Cell Potential (V)');
model.result('pg2').set('legendpos', 'lowerright');
model.result('pg2').create('glob1', 'Global');
model.result('pg2').feature('glob1').set('markerpos', 'datapoints');
model.result('pg2').feature('glob1').set('linewidth', 'preference');
model.result('pg2').feature('glob1').set('data', 'dset1');
model.result('pg2').feature('glob1').set('expr', {'lb.E_cell'});
model.result('pg2').feature('glob1').set('descr', {'Cell potential'});
model.result('pg2').feature('glob1').setIndex('descr', 'Cell 1', 0);
model.result('pg2').feature('glob1').set('expr', {'lb.E_cell' 'lb2.E_cell'});
model.result('pg2').feature('glob1').set('descr', {'Cell 1' 'Cell potential'});
model.result('pg2').feature('glob1').setIndex('descr', 'Cell 2', 1);
model.result('pg2').feature('glob1').set('expr', {'lb.E_cell' 'lb2.E_cell' 'cir.vm1.v'});
model.result('pg2').feature('glob1').set('descr', {'Cell 1' 'Cell 2' 'Voltage across Volt meter #'});
model.result('pg2').feature('glob1').setIndex('descr', 'Total', 2);
model.result('pg2').feature('glob1').set('xdatasolnumtype', 'level1');
model.result('pg2').feature('glob1').set('linecolor', 'cyclereset');
model.result('pg2').run;
model.result('pg2').run;
model.result.duplicate('pg3', 'pg2');
model.result('pg3').run;
model.result('pg3').label('Cell Current');
model.result('pg3').set('ylabel', 'Cell Current (A)');
model.result('pg3').set('axislimits', true);
model.result('pg3').set('ymin', -30);
model.result('pg3').set('ymax', 1);
model.result('pg3').run;
model.result('pg3').feature('glob1').set('expr', {});
model.result('pg3').feature('glob1').set('descr', {});
model.result('pg3').feature('glob1').set('expr', {'lb.I_cell'});
model.result('pg3').feature('glob1').set('descr', {'Cell current'});
model.result('pg3').feature('glob1').set('unit', {'A'});
model.result('pg3').feature('glob1').setIndex('descr', 'Cell 1', 0);
model.result('pg3').feature('glob1').set('expr', {'lb.I_cell' 'lb2.I_cell'});
model.result('pg3').feature('glob1').set('descr', {'Cell 1' 'Cell current'});
model.result('pg3').feature('glob1').setIndex('descr', 'Cell 2', 1);
model.result('pg3').run;
model.result.create('pg4', 'PlotGroup1D');
model.result('pg4').run;
model.result('pg4').label('State of Charge');
model.result('pg4').set('data', 'none');
model.result('pg4').set('titletype', 'label');
model.result('pg4').set('ylabelactive', true);
model.result('pg4').set('ylabel', 'State of charge');
model.result('pg4').create('glob1', 'Global');
model.result('pg4').feature('glob1').set('markerpos', 'datapoints');
model.result('pg4').feature('glob1').set('linewidth', 'preference');
model.result('pg4').feature('glob1').set('data', 'dset1');
model.result('pg4').feature('glob1').set('expr', {'lb.SOC_cell'});
model.result('pg4').feature('glob1').set('descr', {'Cell state of charge'});
model.result('pg4').feature('glob1').setIndex('descr', 'Cell 1', 0);
model.result('pg4').feature('glob1').set('expr', {'lb.SOC_cell' 'lb2.SOC_cell'});
model.result('pg4').feature('glob1').set('descr', {'Cell 1' 'Cell state of charge'});
model.result('pg4').feature('glob1').setIndex('descr', 'Cell 2', 1);
model.result('pg4').feature('glob1').set('linecolor', 'cyclereset');
model.result('pg4').run;

model.physics.create('ev', 'Events');
model.physics('ev').model('comp1');

model.study('std1').feature('time').setSolveFor('/physics/ev', true);

model.physics('ev').create('ds1', 'DiscreteStates', -1);
model.physics('ev').feature('ds1').setIndex('dim', 'Shunt_R1_on', 0, 0);
model.physics('ev').feature('ds1').setIndex('dimInit', 0, 0, 0);
model.physics('ev').feature('ds1').setIndex('dimInit', 1, 0, 0);
model.physics('ev').feature('ds1').setIndex('dim', 'Shunt_R2_on', 1, 0);
model.physics('ev').feature('ds1').setIndex('dimInit', 0, 1, 0);
model.physics('ev').feature('ds1').setIndex('dimDescr', '', 1, 0);
model.physics('ev').feature('ds1').setIndex('dimInit', 1, 1, 0);
model.physics('ev').create('is1', 'IndicatorStates', -1);
model.physics('ev').feature('is1').setIndex('indDim', 'discharge_lb_1', 0, 0);
model.physics('ev').feature('is1').setIndex('g', 0, 0, 0);
model.physics('ev').feature('is1').setIndex('dimInit', 0, 0, 0);
model.physics('ev').feature('is1').setIndex('g', '(comp1.lb.SOC_cell-0.2)*(Shunt_R1_on==1)', 0, 0);
model.physics('ev').feature('is1').setIndex('dimDescr', 'Discharge through shunt R1', 0, 0);
model.physics('ev').feature('is1').setIndex('indDim', 'discharge_lb_2', 1, 0);
model.physics('ev').feature('is1').setIndex('g', 0, 1, 0);
model.physics('ev').feature('is1').setIndex('dimInit', 0, 1, 0);
model.physics('ev').feature('is1').setIndex('dimDescr', '', 1, 0);
model.physics('ev').feature('is1').setIndex('g', '(comp1.lb2.SOC_cell-0.2)*(Shunt_R2_on==1)', 1, 0);
model.physics('ev').feature('is1').setIndex('dimDescr', 'Discharge through shunt R2', 1, 0);
model.physics('ev').create('impl1', 'ImplicitEvent', -1);
model.physics('ev').feature('impl1').set('condition', 'discharge_lb_1<0');
model.physics('ev').feature('impl1').setIndex('reInitName', 'Shunt_R1_on', 0, 0);
model.physics('ev').feature('impl1').setIndex('reInitValue', 0, 0, 0);
model.physics('ev').feature('impl1').setIndex('reInitValue', 'eps', 0, 0);
model.physics('ev').feature.duplicate('impl2', 'impl1');
model.physics('ev').feature('impl2').set('condition', 'discharge_lb_2<0');
model.physics('ev').feature('impl2').setIndex('reInitName', 'Shunt_R2_on', 0, 0);
model.physics('cir').create('R2', 'Resistor', -1);
model.physics('cir').feature('R2').label('Shunt R1');
model.physics('cir').feature('R2').set('R', 'R1*Shunt_R1_on');
model.physics('cir').feature('R2').setIndex('Connections', 1, 0, 0);
model.physics('cir').feature('R2').setIndex('Connections', 2, 1, 0);
model.physics('cir').feature.duplicate('R3', 'R2');
model.physics('cir').feature('R3').label('Shunt R2');
model.physics('cir').feature('R3').setIndex('Connections', 2, 0, 0);
model.physics('cir').feature('R3').setIndex('Connections', 3, 1, 0);
model.physics('cir').feature('R3').set('R', 'R1*Shunt_R2_on');

model.study.create('std2');
model.study('std2').create('time', 'Transient');
model.study('std2').feature('time').setSolveFor('/physics/lb', true);
model.study('std2').feature('time').setSolveFor('/physics/lb2', true);
model.study('std2').feature('time').setSolveFor('/physics/cir', true);
model.study('std2').feature('time').setSolveFor('/physics/ev', true);
model.study('std2').label('Study 2: With Shunts');
model.study('std2').feature('time').set('tlist', 'range(0,100,10000)');
model.study('std2').feature('time').set('useparam', true);
model.study('std2').feature('time').setIndex('pname', 'eta_IR_1C', 0);
model.study('std2').feature('time').setIndex('plistarr', '', 0);
model.study('std2').feature('time').setIndex('punit', 'V', 0);
model.study('std2').feature('time').setIndex('pname', 'eta_IR_1C', 0);
model.study('std2').feature('time').setIndex('plistarr', '', 0);
model.study('std2').feature('time').setIndex('punit', 'V', 0);
model.study('std2').feature('time').setIndex('pname', 'C_rate', 0);
model.study('std2').feature('time').setIndex('plistarr', '0.5 2', 0);
model.study('std2').setGenPlots(false);

model.sol.create('sol2');
model.sol('sol2').study('std2');
model.sol('sol2').create('st1', 'StudyStep');
model.sol('sol2').feature('st1').set('study', 'std2');
model.sol('sol2').feature('st1').set('studystep', 'time');
model.sol('sol2').create('v1', 'Variables');
model.sol('sol2').feature('v1').feature('comp1_lb2_vl1_SOC').set('scalemethod', 'manual');
model.sol('sol2').feature('v1').feature('comp1_lb_vl1_SOC').set('scalemethod', 'manual');
model.sol('sol2').feature('v1').feature('comp1_lb2_vl1_SOC').set('scaleval', '1');
model.sol('sol2').feature('v1').feature('comp1_lb_vl1_SOC').set('scaleval', '1');
model.sol('sol2').feature('v1').set('control', 'time');
model.sol('sol2').create('t1', 'Time');
model.sol('sol2').feature('t1').set('tlist', 'range(0,100,10000)');
model.sol('sol2').feature('t1').set('plot', 'off');
model.sol('sol2').feature('t1').set('plotgroup', 'pg1');
model.sol('sol2').feature('t1').set('plotfreq', 'tout');
model.sol('sol2').feature('t1').set('probesel', 'all');
model.sol('sol2').feature('t1').set('probes', {'VoltMeter_cir_vm1'});
model.sol('sol2').feature('t1').set('probefreq', 'tsteps');
model.sol('sol2').feature('t1').set('atolglobalvaluemethod', 'factor');
model.sol('sol2').feature('t1').set('eventout', true);
model.sol('sol2').feature('t1').set('reacf', true);
model.sol('sol2').feature('t1').set('storeudot', true);
model.sol('sol2').feature('t1').set('endtimeinterpolation', true);
model.sol('sol2').feature('t1').set('initialstepbdfactive', true);
model.sol('sol2').feature('t1').set('initialstepbdf', '(1)[s]');
model.sol('sol2').feature('t1').create('tp1', 'TimeParametric');
model.sol('sol2').feature('t1').feature.remove('tpDef');
model.sol('sol2').feature('t1').feature('tp1').set('control', 'time');
model.sol('sol2').feature('t1').set('control', 'time');
model.sol('sol2').feature('t1').feature('aDef').set('cachepattern', true);
model.sol('sol2').feature('t1').create('seDef', 'Segregated');
model.sol('sol2').feature('t1').create('fc1', 'FullyCoupled');
model.sol('sol2').feature('t1').feature('fc1').set('linsolver', 'dDef');
model.sol('sol2').feature('t1').feature.remove('fcDef');
model.sol('sol2').feature('t1').feature.remove('seDef');
model.sol('sol2').attach('std2');

model.probe('VoltMeter_cir_vm1').genResult('none');

model.sol('sol2').runAll;

model.result('pg2').run;
model.result('pg2').run;
model.result('pg2').run;
model.result('pg2').feature.duplicate('glob2', 'glob1');
model.result('pg2').run;
model.result('pg2').feature('glob2').set('data', 'dset3');
model.result('pg2').feature('glob2').set('linestyle', 'dashed');
model.result('pg2').feature('glob2').set('legend', false);
model.result('pg2').run;
model.result('pg3').run;
model.result('pg3').feature.duplicate('glob2', 'glob1');
model.result('pg3').run;
model.result('pg3').feature('glob2').set('data', 'dset3');
model.result('pg3').feature('glob2').set('linestyle', 'dashed');
model.result('pg3').feature('glob2').set('legend', false);
model.result('pg4').run;
model.result('pg4').feature('glob1').set('xdatasolnumtype', 'level1');
model.result('pg4').feature.duplicate('glob2', 'glob1');
model.result('pg4').run;
model.result('pg4').feature('glob2').set('data', 'dset3');
model.result('pg4').feature('glob2').set('linestyle', 'dashed');
model.result('pg4').feature('glob2').set('legend', false);
model.result('pg4').run;

model.study('std1').feature('time').setEntry('activate', 'ev', false);
model.study('std1').feature('time').set('useadvanceddisable', true);
model.study('std1').feature('time').set('disabledphysics', {'cir/R2' 'cir/R3'});

model.title('Battery Over-Discharge Protection Using Shunt Resistances');

model.description('This tutorial demonstrates how to integrate multiple Lumped Battery models into the Electrical Circuit interface. Two batteries are connected in series. Each battery is protected by a shunt resistances that is activated if the battery state of charge reaches below a certain threshold level.');

model.mesh.clearMeshes;

model.sol('sol1').clearSolutionData;
model.sol('sol2').clearSolutionData;

model.label('over_discharge_protection.mph');

model.modelNode.label('Components');

out = model;
