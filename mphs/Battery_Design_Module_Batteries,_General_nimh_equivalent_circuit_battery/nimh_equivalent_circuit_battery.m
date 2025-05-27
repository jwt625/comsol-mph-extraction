function out = model
%
% nimh_equivalent_circuit_battery.m
%
% Model exported on May 26 2025, 21:25 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/Battery_Design_Module/Batteries,_General');

model.modelNode.create('comp1', true);

model.physics.create('cir', 'Circuit');
model.physics('cir').model('comp1');
model.physics('cir').feature('gnd1').set('Connections', {'0'});
model.physics('cir').create('OCV1', 'BatteryOpenCircuitVoltage');
model.physics('cir').feature('OCV1').set('Connections', {'1' '0'});
model.physics('cir').create('R1', 'Resistor');
model.physics('cir').feature('R1').set('Connections', {'1' '2'});
model.physics('cir').feature('R1').set('R', {'1e-3[ohm]'});
model.physics('cir').create('RC1', 'ResistorCapacitorCouple');
model.physics('cir').feature('RC1').set('Connections', {'2' '3'});
model.physics('cir').create('I1', 'CurrentSourceCircuit');
model.physics('cir').feature('I1').set('Connections', {'3' '0'});

model.study.create('std1');
model.study('std1').create('time', 'Transient');
model.study('std1').feature('time').setSolveFor('/physics/cir', true);

% To import content from file, use:
% model.param.loadFile('FILENAME');
model.param.set('T', '300[K]', 'Temperature');
model.param.set('R2', '0.786[mohm]-1.45*exp(-6[kcal/mol]/(R_const*T))[mohm]', 'Resistance in RC couple');
model.param.set('tau', '15[s]', 'Time constant');
model.param.set('C1', 'tau/R2', 'Capacitance in RC');
model.param.set('R', 'R_const', 'Gas constant');
model.param.set('i_1C', '85[A]', '1C Current');
model.param.set('SOC_0', '0.1', 'Initial state of charge');
model.param.set('Q0', '85[Ah]', 'Initial capacity');
model.param.set('R1', '0.786[mohm]', 'Series resistance');
model.param.set('t_cycle', '2*Q0/i0*(1-SOC_0)', 'Cycle time');
model.param.set('t_ch_stop', 't_cycle/2', 'Charging time');
model.param.set('i_charge', '-i0', 'Charging current');
model.param.set('i_disch', 'i0', 'Discharging current');
model.param.set('i0', 'i_1C*C_rate', 'Applied current magnitude');
model.param.set('C_rate', '1', 'C-rate');

model.func.create('step1', 'Step');

model.variable.create('var1');
model.variable('var1').model('comp1');

% To import content from file, use:
% model.variable('var1').loadFile('FILENAME');
model.variable('var1').set('i_load', 'i_charge*ch_on+i_disch*dis_on', 'Load cycle');
model.variable('var1').set('ch_on', 'step1((t_ch_stop-t)[1/s])', 'Charge on');
model.variable('var1').set('dis_on', 'step1((t-t_ch_stop)[1/s])', 'Discharge on');

model.physics('cir').feature('R1').set('R', 'R1');
model.physics('cir').feature('OCV1').set('Q_cell0', 'Q0');
model.physics('cir').feature('OCV1').set('SOC_cell0', 'SOC_0');
model.physics('cir').feature('OCV1').set('SOC_Eocv', []);
model.physics('cir').feature('OCV1').set('Eocv', []);
model.physics('cir').feature('OCV1').set('SOC_Eocv', [0 0.0063 0.0064 0.0065 0.0066 0.0067 0.0068 0.0069 0.007 0.0071 0.0072 0.0073 0.0074 0.0075 0.0076 0.0077 0.0078 0.0079 0.01 0.0101 0.0102 0.0103 0.0148 0.0149 0.0274 0.0319 0.04 0.05 0.0562 0.062 0.0651 0.0663 0.0702 0.0703 0.0772 0.0845 0.0927 0.0954 0.0955 0.0956 0.0957 0.0958 0.0959 0.096 0.0961 0.0962 0.0963 0.0964 0.0965 0.0966 0.0967 0.0968 0.0969 0.097 0.0971 0.0972 0.0973 0.0974 0.0998 0.0999 0.1 0.1098 0.115 0.1189 0.12 0.1281 0.13 0.14 0.1564 0.1618 0.1684 0.1787 0.1788 0.1837 0.189 0.1891 0.1892 0.191 0.197 0.1999 0.2 0.2113 0.2193 0.2248 0.2357 0.2509 0.251 0.2627 0.2628 0.2721 0.2861 0.2901 0.3 0.3085 0.3329 0.3605 0.3606 0.3607 0.3608 0.3609 0.3661 0.3662 0.3833 0.3874 0.4108 0.4275 0.4351 0.4476 0.4621 0.5308 0.6075 0.6441 0.696 0.702 0.7108 0.7643 0.7746 0.7857 0.8032 0.813 0.8222 0.83 0.8301 0.8436 0.8537 0.8784 0.8807 0.9 0.9083 0.9225 0.9296 0.9366 0.9449 0.9502 0.9582 0.9654 0.9655 0.9656 0.9657 0.9755 0.9819 0.9885 0.9932 0.9933 0.9934 0.9935 0.9936 0.9937 0.9938 0.9939 0.994 0.9941 0.9942 0.9943 0.9944 0.9945 0.9946 0.9947 0.9948 0.9949 0.995 0.9951 0.9952 0.9953 0.9954 0.9955 0.9956 0.9957 0.9958 0.9959 0.996 0.9961 0.9962 0.9963 0.9964 0.9965 0.9966 0.9967 0.9968 0.9969 0.997 0.9971 0.9972 0.9973 0.9974 0.9975 0.9976 0.9977 0.9986 0.9991 0.9992 0.9993 0.9994 0.9995 0.9996 0.9997 0.9998]);
model.physics('cir').feature('OCV1').set('Eocv', [1.0008 1.0518 1.0523 1.0527 1.0532 1.0537 1.0541 1.0546 1.055 1.0554 1.0559 1.0563 1.0567 1.0571 1.0575 1.0579 1.0583 1.0587 1.0662 1.0666 1.0669 1.0672 1.0796 1.0798 1.1037 1.1105 1.1215 1.1333 1.14 1.1458 1.1489 1.15 1.1537 1.1538 1.16 1.1662 1.1728 1.1749 1.175 1.1751 1.1752 1.1752 1.1753 1.1754 1.1755 1.1755 1.1756 1.1757 1.1758 1.1759 1.1759 1.176 1.1761 1.1762 1.1762 1.1763 1.1764 1.1765 1.1783 1.1784 1.1784 1.1856 1.1893 1.1919 1.1927 1.198 1.1992 1.2055 1.215 1.2179 1.2215 1.2267 1.2268 1.2292 1.2318 1.2318 1.2319 1.2327 1.2355 1.2368 1.2368 1.2418 1.2451 1.2473 1.2516 1.2571 1.2571 1.261 1.2611 1.2641 1.2683 1.2694 1.2721 1.2744 1.2802 1.2859 1.2859 1.2859 1.286 1.286 1.2869 1.287 1.2899 1.2906 1.2941 1.2962 1.2972 1.2986 1.3 1.3053 1.3092 1.3109 1.3138 1.3142 1.3148 1.3195 1.3207 1.3221 1.3245 1.326 1.3276 1.329 1.329 1.3317 1.3339 1.3401 1.3408 1.3469 1.35 1.3558 1.3591 1.3627 1.3674 1.3707 1.3764 1.3824 1.3825 1.3826 1.3827 1.393 1.4019 1.4149 1.4294 1.4298 1.4302 1.4307 1.4311 1.4315 1.4319 1.4324 1.4328 1.4333 1.4338 1.4342 1.4347 1.4352 1.4357 1.4362 1.4367 1.4373 1.4378 1.4384 1.4389 1.4395 1.4401 1.4407 1.4413 1.4419 1.4425 1.4432 1.4439 1.4446 1.4453 1.446 1.4467 1.4475 1.4483 1.4491 1.4499 1.4508 1.4517 1.4526 1.4536 1.4545 1.4556 1.4566 1.4578 1.4589 1.4726 1.4852 1.4886 1.4926 1.4973 1.5031 1.5105 1.5209 1.5387]);
model.physics('cir').feature('I1').set('value', 'i_load');
model.physics('cir').feature('RC1').set('RCMode', 'RC');
model.physics('cir').feature('RC1').set('R', 'R2');
model.physics('cir').feature('RC1').set('C', 'C1');

model.study('std1').create('param', 'Parametric');
model.study('std1').feature('param').setIndex('pname', 'T', 0);
model.study('std1').feature('param').setIndex('plistarr', '', 0);
model.study('std1').feature('param').setIndex('punit', 'K', 0);
model.study('std1').feature('param').setIndex('pname', 'T', 0);
model.study('std1').feature('param').setIndex('plistarr', '', 0);
model.study('std1').feature('param').setIndex('punit', 'K', 0);
model.study('std1').feature('param').setIndex('pname', 'C_rate', 0);
model.study('std1').feature('param').setIndex('plistarr', '2 4 8', 0);
model.study('std1').feature('param').setIndex('punit', 1, 0);
model.study('std1').feature('time').set('tlist', 'range(0,t_cycle/1000,t_cycle)');

model.sol.create('sol1');
model.sol('sol1').study('std1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'time');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').set('control', 'time');
model.sol('sol1').create('t1', 'Time');
model.sol('sol1').feature('t1').set('tlist', 'range(0,t_cycle/1000,t_cycle)');
model.sol('sol1').feature('t1').set('plot', 'off');
model.sol('sol1').feature('t1').set('plotgroup', 'Default');
model.sol('sol1').feature('t1').set('plotfreq', 'tout');
model.sol('sol1').feature('t1').set('probesel', 'all');
model.sol('sol1').feature('t1').set('probes', {});
model.sol('sol1').feature('t1').set('probefreq', 'tsteps');
model.sol('sol1').feature('t1').set('atolglobalvaluemethod', 'factor');
model.sol('sol1').feature('t1').set('endtimeinterpolation', true);
model.sol('sol1').feature('t1').set('control', 'time');
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
model.batch('p1').set('pname', {'C_rate'});
model.batch('p1').set('plistarr', {'2 4 8'});
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
model.result('pg1').label('Load Cycle Voltage');
model.result('pg1').set('data', 'dset2');
model.result('pg1').create('glob1', 'Global');
model.result('pg1').feature('glob1').set('markerpos', 'datapoints');
model.result('pg1').feature('glob1').set('linewidth', 'preference');
model.result('pg1').feature('glob1').set('expr', {'cir.v_3'});
model.result('pg1').feature('glob1').set('descr', {'Voltage at node 3'});
model.result('pg1').feature('glob1').set('unit', {'V'});
model.result('pg1').feature('glob1').set('xdata', 'expr');
model.result('pg1').feature('glob1').set('xdataexpr', 'Q0*comp1.cir.OCV1_SOC');
model.result('pg1').feature('glob1').set('xdataunit', 'Ah');
model.result('pg1').feature('glob1').set('xdatadescractive', true);
model.result('pg1').feature('glob1').set('xdatadescr', 'Capacity');
model.result('pg1').run;
model.result('pg1').run;
model.result.duplicate('pg2', 'pg1');
model.result('pg2').run;
model.result('pg2').label('Open Circuit Voltage and SOC vs. Time');
model.result('pg2').set('titletype', 'label');
model.result('pg2').set('twoyaxes', true);
model.result('pg2').run;
model.result('pg2').feature('glob1').set('expr', {'cir.OCV1.E_OCV'});
model.result('pg2').feature('glob1').set('descr', {'Open circuit voltage'});
model.result('pg2').feature('glob1').set('unit', {'V'});
model.result('pg2').feature('glob1').label('Open Circuit Voltage');
model.result('pg2').feature('glob1').set('xdata', 'solution');
model.result('pg2').run;
model.result('pg2').feature('glob1').set('linestyle', 'dashed');
model.result('pg2').run;
model.result('pg2').create('glob2', 'Global');
model.result('pg2').feature('glob2').set('markerpos', 'datapoints');
model.result('pg2').feature('glob2').set('linewidth', 'preference');
model.result('pg2').feature('glob2').set('expr', {'cir.OCV1.SOC'});
model.result('pg2').feature('glob2').set('descr', {'State of charge'});
model.result('pg2').feature('glob2').set('unit', {'1'});
model.result('pg2').feature('glob2').label('Cell State of Charge');
model.result('pg2').feature('glob2').set('plotonsecyaxis', true);
model.result('pg2').feature('glob2').set('linecolor', 'cyclereset');
model.result('pg2').run;
model.result('pg2').run;
model.result('pg2').set('showlegends', false);
model.result('pg2').run;
model.result('pg2').feature('glob1').set('linestyle', 'solid');
model.result('pg2').run;
model.result('pg2').feature('glob2').active(false);
model.result('pg2').run;
model.result('pg2').set('twoyaxes', false);
model.result('pg2').run;
model.result('pg2').run;
model.result('pg2').feature('glob2').active(true);
model.result('pg2').run;
model.result('pg2').set('twoyaxes', true);
model.result('pg2').run;
model.result('pg2').run;
model.result('pg2').feature('glob1').set('linestyle', 'dashed');
model.result('pg2').run;

model.title(['An Equivalent Circuit Model for a Nickel' native2unicode(hex2dec({'20' '13'}), 'unicode') 'Metal Hydride Battery']);

model.description(['This example simulates a nickel' native2unicode(hex2dec({'20' '13'}), 'unicode') 'metal hydride battery using an equivalent circuit model. The model consists of two resistors, a capacitor, a current source and a voltage source depending on the battery state of charge (SOC). Various charge-discharge cycles at different C-rates are simulated using a parametric sweep.']);

model.mesh.clearMeshes;

model.sol('sol1').clearSolutionData;
model.sol('sol2').clearSolutionData;
model.sol('sol3').clearSolutionData;
model.sol('sol4').clearSolutionData;
model.sol('sol5').clearSolutionData;

model.label('nimh_equivalent_circuit_battery.mph');

model.modelNode.label('Components');

out = model;
