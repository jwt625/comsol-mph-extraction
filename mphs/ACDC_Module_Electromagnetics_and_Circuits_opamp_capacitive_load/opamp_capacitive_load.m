function out = model
%
% opamp_capacitive_load.m
%
% Model exported on May 26 2025, 21:24 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/ACDC_Module/Electromagnetics_and_Circuits');

model.modelNode.create('comp1', true);

model.physics.create('cir', 'Circuit');
model.physics('cir').model('comp1');

model.study.create('std1');
model.study('std1').create('time', 'Transient');
model.study('std1').feature('time').setSolveFor('/physics/cir', true);

model.param.set('OPAMP_RIN', '100[kohm]');
model.param.descr('OPAMP_RIN', 'Op-amp input resistance');
model.param.set('OPAMP_GAIN', '1e5');
model.param.descr('OPAMP_GAIN', 'Op-amp gain');
model.param.set('CLOAD', '10[nF]');
model.param.descr('CLOAD', 'Capacitive load');
model.param.set('R1', '470[ohm]');
model.param.descr('R1', 'Feedback resistance 1');
model.param.set('R2', '4700[ohm]');
model.param.descr('R2', 'Feedback resistance 2');
model.param.set('OPAMP_P', '100[Hz]');
model.param.descr('OPAMP_P', 'Op-amp pole frequency');
model.param.set('OPAMP_ROUT', '100[ohm]');
model.param.descr('OPAMP_ROUT', 'Op-amp output resistance');

model.func.create('step1', 'Step');
model.func('step1').model('comp1');

model.variable.create('var1');
model.variable('var1').model('comp1');
model.variable('var1').set('VIN', '.5[V]*step1((t-.05[us])/1[us])');
model.variable('var1').descr('VIN', 'Input voltage');

model.physics('cir').create('sub1', 'SubCircuitBlock', -1);
model.physics('cir').feature('sub1').label('OPAMP');
model.physics('cir').feature('sub1').setIndex('Connections', 'a', 2, 0);
model.physics('cir').feature('sub1').setIndex('Connections', 'a', 2, 0);
model.physics('cir').feature('sub1').setIndex('Connections', 'a', 3, 0);
model.physics('cir').feature('sub1').setIndex('Connections', 'a', 3, 0);
model.physics('cir').feature('sub1').setIndex('Connections', 'p', 0, 0);
model.physics('cir').feature('sub1').setIndex('Connections', 'n', 1, 0);
model.physics('cir').feature('sub1').setIndex('Connections', 'out', 2, 0);
model.physics('cir').feature('sub1').setIndex('Connections', 'gnd', 3, 0);
model.physics('cir').feature('sub1').create('R1', 'Resistor', -1);
model.physics('cir').feature('sub1').feature('R1').label('Resistor RIN');
model.physics('cir').feature('sub1').feature('R1').tag('RIN');
model.physics('cir').feature('sub1').feature('RIN').setIndex('Connections', 'p', 0, 0);
model.physics('cir').feature('sub1').feature('RIN').setIndex('Connections', 'n', 1, 0);
model.physics('cir').feature('sub1').feature('RIN').set('R', 'OPAMP_RIN');
model.physics('cir').feature('sub1').create('E1', 'VoltageVoltageSource', -1);
model.physics('cir').feature('sub1').feature('E1').label('Voltage-Controlled Voltage Source EGAIN');
model.physics('cir').feature('sub1').feature('E1').tag('EGAIN');
model.physics('cir').feature('sub1').feature('EGAIN').setIndex('Connections', 'gnd', 1, 0);
model.physics('cir').feature('sub1').feature('EGAIN').setIndex('Connections', 'p', 2, 0);
model.physics('cir').feature('sub1').feature('EGAIN').setIndex('Connections', 'n', 3, 0);
model.physics('cir').feature('sub1').feature('EGAIN').set('gain', 'OPAMP_GAIN');
model.physics('cir').feature('sub1').create('R1', 'Resistor', -1);
model.physics('cir').feature('sub1').feature('R1').label('Resistor RP');
model.physics('cir').feature('sub1').feature('R1').tag('RP');
model.physics('cir').feature('sub1').feature('RP').setIndex('Connections', 1, 0, 0);
model.physics('cir').feature('sub1').feature('RP').setIndex('Connections', 2, 1, 0);
model.physics('cir').feature('sub1').feature('RP').set('R', '1/(2*pi*OPAMP_P*1[nF])');
model.physics('cir').feature('sub1').create('C1', 'Capacitor', -1);
model.physics('cir').feature('sub1').feature('C1').label('Capacitor CP');
model.physics('cir').feature('sub1').feature('C1').tag('CP');
model.physics('cir').feature('sub1').feature('CP').setIndex('Connections', 2, 0, 0);
model.physics('cir').feature('sub1').feature('CP').setIndex('Connections', 'gnd', 1, 0);
model.physics('cir').feature('sub1').feature('CP').set('C', '1[nF]');
model.physics('cir').feature('sub1').create('E1', 'VoltageVoltageSource', -1);
model.physics('cir').feature('sub1').feature('E1').label('Voltage-Controlled Voltage Source EBUFFER');
model.physics('cir').feature('sub1').feature('E1').tag('EBUFFER');
model.physics('cir').feature('sub1').feature('EBUFFER').setIndex('Connections', 'gnd', 1, 0);
model.physics('cir').feature('sub1').feature('EBUFFER').setIndex('Connections', 2, 2, 0);
model.physics('cir').feature('sub1').feature('EBUFFER').setIndex('Connections', 'gnd', 3, 0);
model.physics('cir').feature('sub1').create('R1', 'Resistor', -1);
model.physics('cir').feature('sub1').feature('R1').label('Resistor ROUT');
model.physics('cir').feature('sub1').feature('R1').tag('ROUT');
model.physics('cir').feature('sub1').feature('ROUT').setIndex('Connections', 3, 0, 0);
model.physics('cir').feature('sub1').feature('ROUT').setIndex('Connections', 'out', 1, 0);
model.physics('cir').feature('sub1').feature('ROUT').set('R', 'OPAMP_ROUT');
model.physics('cir').create('V1', 'VoltageSource', -1);
model.physics('cir').feature('V1').label('Voltage Source VIN');
model.physics('cir').feature('V1').tag('VIN');
model.physics('cir').feature('VIN').setIndex('Connections', 0, 1, 0);
model.physics('cir').feature('VIN').set('value', 'VIN');
model.physics('cir').create('X1', 'SubCircuit', -1);
model.physics('cir').feature('X1').label('Subcircuit Instance XOPAMP');
model.physics('cir').feature('X1').tag('XOPAMP');
model.physics('cir').feature('XOPAMP').set('subCircuitName', 'sub1');
model.physics('cir').feature('XOPAMP').setIndex('Connections', 1, 0, 0);
model.physics('cir').feature('XOPAMP').setIndex('Connections', 2, 1, 0);
model.physics('cir').feature('XOPAMP').setIndex('Connections', 3, 2, 0);
model.physics('cir').feature('XOPAMP').setIndex('Connections', 0, 3, 0);
model.physics('cir').create('R1', 'Resistor', -1);
model.physics('cir').feature('R1').setIndex('Connections', 2, 0, 0);
model.physics('cir').feature('R1').setIndex('Connections', 0, 1, 0);
model.physics('cir').feature('R1').set('R', 'R1');
model.physics('cir').create('R2', 'Resistor', -1);
model.physics('cir').feature('R2').setIndex('Connections', 2, 0, 0);
model.physics('cir').feature('R2').setIndex('Connections', 3, 1, 0);
model.physics('cir').feature('R2').set('R', 'R2');
model.physics('cir').create('C1', 'Capacitor', -1);
model.physics('cir').feature('C1').label('Capacitor CLOAD');
model.physics('cir').feature('C1').tag('CLOAD');
model.physics('cir').feature('CLOAD').setIndex('Connections', 3, 0, 0);
model.physics('cir').feature('CLOAD').setIndex('Connections', 0, 1, 0);
model.physics('cir').feature('CLOAD').set('C', 'CLOAD');
model.physics('cir').create('vm1', 'VoltMeter', -1);
model.physics('cir').feature('vm1').setIndex('Connections', 3, 0, 0);
model.physics('cir').feature('vm1').setIndex('Connections', 0, 1, 0);

model.study('std1').feature('time').set('tlist', 'range(0,0.05[us],10[us])');

model.sol.create('sol1');
model.sol('sol1').study('std1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'time');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').set('control', 'time');
model.sol('sol1').create('t1', 'Time');
model.sol('sol1').feature('t1').set('tlist', 'range(0,0.05[us],10[us])');
model.sol('sol1').feature('t1').set('plot', 'off');
model.sol('sol1').feature('t1').set('plotgroup', 'Default');
model.sol('sol1').feature('t1').set('plotfreq', 'tout');
model.sol('sol1').feature('t1').set('probesel', 'all');
model.sol('sol1').feature('t1').set('probes', {'VoltMeter_cir_vm1'});
model.sol('sol1').feature('t1').set('probefreq', 'tsteps');
model.sol('sol1').feature('t1').set('atolglobalvaluemethod', 'factor');
model.sol('sol1').feature('t1').set('endtimeinterpolation', true);
model.sol('sol1').feature('t1').set('control', 'time');
model.sol('sol1').feature('t1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('t1').feature('fc1').set('linsolver', 'dDef');
model.sol('sol1').feature('t1').feature.remove('fcDef');
model.sol('sol1').attach('std1');

model.probe('VoltMeter_cir_vm1').genResult('none');

model.sol('sol1').runAll;

model.result('pg1').set('window', 'window1');
model.result('pg1').run;

model.title('Operational Amplifier with Capacitive Load');

model.description(['An operational amplifier (op-amp) is a differential voltage amplifier with a wide range of applications in analog electronics. This tutorial models an op-amp connected to a feedback loop and a capacitive load.' newline  newline 'The op-amp is modeled as an equivalent linear subcircuit in the Electrical Circuit interface, where it is inserted into an outer circuit. The model is partially based on the SPICE format. The model is simulated for 10' native2unicode(hex2dec({'00' 'a0'}), 'unicode') 'ms with data output every 0.05' native2unicode(hex2dec({'00' 'a0'}), 'unicode') 'ms. The internal dynamics of the op-amp interact with the feedback network, causing ringing in the output signal (step response).']);

model.mesh.clearMeshes;

model.sol('sol1').clearSolutionData;

model.label('opamp_capacitive_load.mph');

model.modelNode.label('Components');

out = model;
