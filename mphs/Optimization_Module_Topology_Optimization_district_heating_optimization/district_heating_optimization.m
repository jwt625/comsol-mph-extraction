function out = model
%
% district_heating_optimization.m
%
% Model exported on May 26 2025, 21:31 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/Optimization_Module/Topology_Optimization');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 3);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.physics.create('nipfl', 'NonisothermalPipeFlow', 'geom1');
model.physics('nipfl').model('comp1');
model.physics.create('ce', 'CoefficientFormEdgePDE', 'geom1', {'P'});
model.physics('ce').prop('EquationForm').set('form', 'Automatic');
model.physics('ce').field('dimensionless').field('P');
model.physics('ce').prop('Units').set('DependentVariableQuantity', 'power');
model.physics('ce').prop('Units').set('SourceTermQuantity', 'power');

model.study.create('std1');
model.study('std1').create('stat', 'Stationary');
model.study('std1').feature('stat').setSolveFor('/physics/nipfl', true);
model.study('std1').feature('stat').setSolveFor('/physics/ce', true);

model.geom('geom1').insertFile('district_heating_optimization_geom_sequence.mph', 'geom1');
model.geom('geom1').run('unisel3');

model.param.label('Geometrical Parameters');
model.param.create('par2');
model.param('par2').label('Model Parameters');

% To import content from file, use:
% model.param('par2').loadFile('FILENAME');
model.param('par2').set('T1', '70[degC]', 'Inlet temperature');
model.param('par2').set('T2', '65[degC]', 'Inlet temperature');
model.param('par2').set('dp1', '10[kPa]', 'Inlet pressure');
model.param('par2').set('dp2', 'dp1', 'Inlet pressure');
model.param('par2').set('dp1c', '0', 'Inlet control');
model.param('par2').set('dp2c', '0', 'Inlet control');
model.param('par2').set('Tout', '-7[degC]', 'Outside temperature');
model.param('par2').set('pExp', '10', 'Constraint aggregation parameter');
model.param('par2').set('consumerPower', '5[kW]', 'Consumer power');
model.param('par2').set('roomT', '20[degC]', 'Consumer temperature');
model.param('par2').set('pumpWeight', '1e3[1/W]', 'Objective weight [EUR/W]');
model.param('par2').set('kRoom', '10[W/K/m]', 'Consumer thermal coupling');
model.param('par2').set('kOut', 'kRoom/1e2', 'Outside thermal coupling');
model.param('par2').set('dInit', '20[cm]', 'Initial network diameter');
model.param('par2').set('dInit2', '0.5*dInit', 'Initial consumer diameter');

model.material.create('mat1', 'Common', 'comp1');
model.material('mat1').propertyGroup('def').func.create('eta', 'Piecewise');
model.material('mat1').propertyGroup('def').func.create('Cp', 'Piecewise');
model.material('mat1').propertyGroup('def').func.create('rho', 'Piecewise');
model.material('mat1').propertyGroup('def').func.create('k', 'Piecewise');
model.material('mat1').propertyGroup('def').func.create('cs', 'Interpolation');
model.material('mat1').propertyGroup('def').func.create('an1', 'Analytic');
model.material('mat1').propertyGroup('def').func.create('an2', 'Analytic');
model.material('mat1').propertyGroup('def').func.create('an3', 'Analytic');
model.material('mat1').label('Water, liquid');
model.material('mat1').set('family', 'water');
model.material('mat1').propertyGroup('def').func('eta').set('arg', 'T');
model.material('mat1').propertyGroup('def').func('eta').set('pieces', {'273.15' '413.15' '1.3799566804-0.021224019151*T^1+1.3604562827E-4*T^2-4.6454090319E-7*T^3+8.9042735735E-10*T^4-9.0790692686E-13*T^5+3.8457331488E-16*T^6'; '413.15' '553.75' '0.00401235783-2.10746715E-5*T^1+3.85772275E-8*T^2-2.39730284E-11*T^3'});
model.material('mat1').propertyGroup('def').func('eta').set('argunit', 'K');
model.material('mat1').propertyGroup('def').func('eta').set('fununit', 'Pa*s');
model.material('mat1').propertyGroup('def').func('Cp').set('arg', 'T');
model.material('mat1').propertyGroup('def').func('Cp').set('pieces', {'273.15' '553.75' '12010.1471-80.4072879*T^1+0.309866854*T^2-5.38186884E-4*T^3+3.62536437E-7*T^4'});
model.material('mat1').propertyGroup('def').func('Cp').set('argunit', 'K');
model.material('mat1').propertyGroup('def').func('Cp').set('fununit', 'J/(kg*K)');
model.material('mat1').propertyGroup('def').func('rho').set('arg', 'T');
model.material('mat1').propertyGroup('def').func('rho').set('smooth', 'contd1');
model.material('mat1').propertyGroup('def').func('rho').set('pieces', {'273.15' '293.15' '0.000063092789034*T^3-0.060367639882855*T^2+18.9229382407066*T-950.704055329848'; '293.15' '373.15' '0.000010335053319*T^3-0.013395065634452*T^2+4.969288832655160*T+432.257114008512'});
model.material('mat1').propertyGroup('def').func('rho').set('argunit', 'K');
model.material('mat1').propertyGroup('def').func('rho').set('fununit', 'kg/m^3');
model.material('mat1').propertyGroup('def').func('k').set('arg', 'T');
model.material('mat1').propertyGroup('def').func('k').set('pieces', {'273.15' '553.75' '-0.869083936+0.00894880345*T^1-1.58366345E-5*T^2+7.97543259E-9*T^3'});
model.material('mat1').propertyGroup('def').func('k').set('argunit', 'K');
model.material('mat1').propertyGroup('def').func('k').set('fununit', 'W/(m*K)');
model.material('mat1').propertyGroup('def').func('cs').set('table', {'273' '1403';  ...
'278' '1427';  ...
'283' '1447';  ...
'293' '1481';  ...
'303' '1507';  ...
'313' '1526';  ...
'323' '1541';  ...
'333' '1552';  ...
'343' '1555';  ...
'353' '1555';  ...
'363' '1550';  ...
'373' '1543'});
model.material('mat1').propertyGroup('def').func('cs').set('interp', 'piecewisecubic');
model.material('mat1').propertyGroup('def').func('cs').set('fununit', {'m/s'});
model.material('mat1').propertyGroup('def').func('cs').set('argunit', {'K'});
model.material('mat1').propertyGroup('def').func('an1').set('funcname', 'alpha_p');
model.material('mat1').propertyGroup('def').func('an1').set('expr', '-1/rho(T)*d(rho(T),T)');
model.material('mat1').propertyGroup('def').func('an1').set('args', {'T'});
model.material('mat1').propertyGroup('def').func('an1').set('fununit', '1/K');
model.material('mat1').propertyGroup('def').func('an1').set('argunit', {'K'});
model.material('mat1').propertyGroup('def').func('an1').set('plotfixedvalue', {'273.15'});
model.material('mat1').propertyGroup('def').func('an1').set('plotargs', {'T' '273.15' '373.15'});
model.material('mat1').propertyGroup('def').func('an2').set('funcname', 'gamma_w');
model.material('mat1').propertyGroup('def').func('an2').set('expr', '1+(T/Cp(T))*(alpha_p(T)*cs(T))^2');
model.material('mat1').propertyGroup('def').func('an2').set('args', {'T'});
model.material('mat1').propertyGroup('def').func('an2').set('fununit', '1');
model.material('mat1').propertyGroup('def').func('an2').set('argunit', {'K'});
model.material('mat1').propertyGroup('def').func('an2').set('plotfixedvalue', {'273.15'});
model.material('mat1').propertyGroup('def').func('an2').set('plotargs', {'T' '273.15' '373.15'});
model.material('mat1').propertyGroup('def').func('an3').set('funcname', 'muB');
model.material('mat1').propertyGroup('def').func('an3').set('expr', '2.79*eta(T)');
model.material('mat1').propertyGroup('def').func('an3').set('args', {'T'});
model.material('mat1').propertyGroup('def').func('an3').set('fununit', 'Pa*s');
model.material('mat1').propertyGroup('def').func('an3').set('argunit', {'K'});
model.material('mat1').propertyGroup('def').func('an3').set('plotfixedvalue', {'273.15'});
model.material('mat1').propertyGroup('def').func('an3').set('plotargs', {'T' '273.15' '553.75'});
model.material('mat1').propertyGroup('def').set('thermalexpansioncoefficient', '');
model.material('mat1').propertyGroup('def').set('bulkviscosity', '');
model.material('mat1').propertyGroup('def').set('thermalexpansioncoefficient', {'alpha_p(T)' '0' '0' '0' 'alpha_p(T)' '0' '0' '0' 'alpha_p(T)'});
model.material('mat1').propertyGroup('def').set('bulkviscosity', 'muB(T)');
model.material('mat1').propertyGroup('def').set('dynamicviscosity', 'eta(T)');
model.material('mat1').propertyGroup('def').set('ratioofspecificheat', 'gamma_w(T)');
model.material('mat1').propertyGroup('def').set('electricconductivity', {'5.5e-6[S/m]' '0' '0' '0' '5.5e-6[S/m]' '0' '0' '0' '5.5e-6[S/m]'});
model.material('mat1').propertyGroup('def').set('heatcapacity', 'Cp(T)');
model.material('mat1').propertyGroup('def').set('density', 'rho(T)');
model.material('mat1').propertyGroup('def').set('thermalconductivity', {'k(T)' '0' '0' '0' 'k(T)' '0' '0' '0' 'k(T)'});
model.material('mat1').propertyGroup('def').set('soundspeed', 'cs(T)');
model.material('mat1').propertyGroup('def').addInput('temperature');

model.common.create('cvf1', 'ControlVariableField', 'comp1');
model.common('cvf1').label('Pipes');
model.common('cvf1').set('name', 'pipeControl');
model.common('cvf1').selection.geom('geom1', 1);
model.common('cvf1').selection.named('geom1_boxsel1');
model.common('cvf1').set('shapeFunctionType', 'shdisc');
model.common('cvf1').set('order', '0');
model.common('cvf1').set('lbound', 'log(0.01)');
model.common('cvf1').set('ubound', 'log(2)');
model.common.create('cvf2', 'ControlVariableField', 'comp1');
model.common('cvf2').label('Bypass');
model.common('cvf2').set('name', 'bypass');
model.common('cvf2').selection.geom('geom1', 0);
model.common('cvf2').selection.named('geom1_boxsel3');
model.common('cvf2').set('shapeFunctionType', 'shdisc');
model.common('cvf2').set('order', '0');
model.common('cvf2').set('lbound', 'log(0.01)');
model.common('cvf2').set('ubound', 'log(10)');
model.common.duplicate('cvf3', 'cvf2');
model.common('cvf3').label('Consumers');
model.common('cvf3').set('name', 'consumers');
model.common('cvf3').set('lbound', 'log(0.1)');

model.cpl.create('intop1', 'Integration', 'geom1');
model.cpl('intop1').set('axisym', true);
model.cpl('intop1').label('All Pipes');
model.cpl('intop1').set('opname', 'intopAll');
model.cpl('intop1').selection.geom('geom1', 1);
model.cpl('intop1').selection.all;
model.cpl.duplicate('intop2', 'intop1');
model.cpl('intop2').label('Hot Pipes');
model.cpl('intop2').set('opname', 'intopHot');
model.cpl('intop2').selection.named('geom1_boxsel1');
model.cpl.duplicate('intop3', 'intop2');
model.cpl('intop3').label('Consumers');
model.cpl('intop3').set('opname', 'intopConsumers');
model.cpl('intop3').selection.named('geom1_unisel2');
model.cpl.duplicate('intop4', 'intop3');
model.cpl('intop4').label('Inlet 1');
model.cpl('intop4').set('opname', 'intopInlet1');
model.cpl('intop4').selection.geom('geom1', 0);
model.cpl('intop4').selection.named('geom1_ballsel1');
model.cpl.duplicate('intop5', 'intop4');
model.cpl('intop5').label('Outlet 1');
model.cpl('intop5').set('opname', 'intopOutlet1');
model.cpl('intop5').selection.named('geom1_ballsel2');
model.cpl.duplicate('intop6', 'intop5');
model.cpl('intop6').label('Outlet 2');
model.cpl('intop6').selection.named('geom1_ballsel3');
model.cpl.duplicate('intop7', 'intop6');
model.cpl('intop7').label('Inlet 2');
model.cpl('intop7').set('opname', 'intopInlet2');
model.cpl('intop7').selection.named('geom1_ballsel4');
model.cpl.create('aveop1', 'Average', 'geom1');
model.cpl('aveop1').set('axisym', true);
model.cpl('aveop1').label('Consumer Average');
model.cpl('aveop1').set('opname', 'aveopConsumer');
model.cpl('aveop1').selection.geom('geom1', 1);
model.cpl('aveop1').selection.named('geom1_unisel2');
model.cpl.create('minop1', 'Minimum', 'geom1');
model.cpl('minop1').label('Consumer Minimum');
model.cpl('minop1').selection.geom('geom1', 0);
model.cpl('minop1').selection.named('geom1_boxsel3');
model.cpl.create('genext1', 'GeneralExtrusion', 'geom1');
model.cpl('genext1').selection.geom('geom1', 1);
model.cpl('genext1').selection.named('geom1_boxsel1');
model.cpl('genext1').set('dstmap', {'x' 'y' '0'});
model.cpl.duplicate('genext2', 'genext1');
model.cpl('genext2').selection.geom('geom1', 0);
model.cpl('genext2').selection.named('geom1_boxsel3');

model.nodeGroup.create('grp1', 'Definitions', 'comp1');
model.nodeGroup('grp1').set('type', 'cpl');
model.nodeGroup('grp1').add('cpl', 'intop1');
model.nodeGroup('grp1').add('cpl', 'intop2');
model.nodeGroup('grp1').add('cpl', 'intop3');
model.nodeGroup('grp1').add('cpl', 'intop4');
model.nodeGroup('grp1').add('cpl', 'intop5');
model.nodeGroup('grp1').add('cpl', 'intop6');
model.nodeGroup('grp1').add('cpl', 'intop7');
model.nodeGroup('grp1').add('cpl', 'aveop1');
model.nodeGroup('grp1').add('cpl', 'minop1');
model.nodeGroup('grp1').add('cpl', 'genext1');
model.nodeGroup('grp1').add('cpl', 'genext2');
model.nodeGroup('grp1').label('Operators');

model.func.create('an1', 'Analytic');
model.func('an1').model('comp1');
model.func('an1').label('Pipe Cost');
model.func('an1').set('funcname', 'pipeCost');
model.func('an1').set('expr', '2202+(2922-2202)*(x-0.032)/(0.4-0.032)');
model.func('an1').set('fununit', '1/m');
model.func('an1').setIndex('argunit', 'm', 0);

model.variable.create('var1');
model.variable('var1').model('comp1');
model.variable('var1').label('Hot Pipes');
model.variable('var1').selection.geom('geom1', 1);
model.variable('var1').selection.named('geom1_boxsel1');
model.variable('var1').set('qHeat', 'kOut*(Tout-T)');
model.variable('var1').descr('qHeat', 'Thermal Coupling');
model.variable('var1').set('pipeD', 'dInit*exp(pipeControl)');
model.variable('var1').descr('pipeD', 'Pipe diameter');
model.variable.duplicate('var2', 'var1');
model.variable('var2').label('Cold Pipes');
model.variable('var2').selection.named('geom1_boxsel2');
model.variable('var2').set('pipeD', 'genext1(pipeD)');
model.variable('var2').descr('pipeD', 'Pipe diameter');
model.variable.duplicate('var3', 'var2');
model.variable('var3').label('Consumers');
model.variable('var3').selection.named('geom1_unisel2');
model.variable('var3').set('qHeat', 'exp(genext2(consumers))*kRoom*(roomT-T)');
model.variable('var3').descr('qHeat', 'Thermal coupling');
model.variable('var3').set('pipeD', 'exp(genext2(bypass))*dInit2');
model.variable('var3').descr('pipeD', 'Pipe diameter');
model.variable.duplicate('var4', 'var3');
model.variable('var4').label('Inlet/Outlet');
model.variable('var4').selection.named('geom1_unisel3');
model.variable('var4').set('qHeat', 'kOut*(Tout-T)');
model.variable('var4').descr('qHeat', 'Thermal coupling');
model.variable('var4').set('pipeD', 'dInit');
model.variable('var4').descr('pipeD', 'Pipe diameter');
model.variable.create('var5');
model.variable('var5').model('comp1');
model.variable('var5').label('Objectives');
model.variable('var5').set('constr', 'log(aveopConsumer(exp(pExp*(1+P/consumerPower)^2)))/pExp');
model.variable('var5').descr('constr', 'Constraint');
model.variable('var5').set('pipePrice', '2*intopHot(pipeCost(pipeD))');
model.variable('var5').descr('pipePrice', 'Pipe price [EUR]');
model.variable('var5').set('power1', 'intopInlet1((p-1[atm])*nipfl.Qv)');
model.variable('var5').descr('power1', 'Pumping power');
model.variable('var5').set('power2', 'intopInlet2((p-1[atm])*nipfl.Qv)');
model.variable('var5').descr('power2', 'Pumping power');
model.variable('var5').set('pumpPrice', 'pumpWeight*(power1+power2)');
model.variable('var5').descr('pumpPrice', 'Pumping price [EUR]');
model.variable('var5').set('obj', 'pipePrice+pumpPrice');
model.variable('var5').descr('obj', 'Objective function');
model.variable('var5').set('flow1in', 'intopInlet1(nipfl.Qm)');
model.variable('var5').descr('flow1in', 'Mass flow rate, Inlet 1');
model.variable('var5').set('flow2in', 'intopInlet2(nipfl.Qm)');
model.variable('var5').descr('flow2in', 'Mass flow rate, Inlet 2');
model.variable('var5').set('Pin', 'flow1in*intopOutlet1((T1-T)*mat1.def.Cp(T))+flow2in*intopOutlet2((T2-T)*mat1.def.Cp(T))');
model.variable('var5').descr('Pin', 'Power input');
model.variable('var5').set('Pconsumer', 'intopConsumers(-P/Lz)');
model.variable('var5').descr('Pconsumer', 'Total consumer power');
model.variable('var5').set('Efficiency', 'Pconsumer/Pin');
model.variable('var5').descr('Efficiency', 'Network efficiency');
model.variable('var5').set('Pout', 'intopAll(-qHeat)');
model.variable('var5').descr('Pout', 'Total heat loss');
model.variable('var5').clear;

% To import content from file, use:
% model.variable('var5').loadFile('FILENAME');
model.variable('var5').set('constr', 'log(aveopConsumer(exp(pExp*(1+P/consumerPower)^2)))/pExp', 'Constraint');
model.variable('var5').set('pipePrice', '2*intopHot(pipeCost(pipeD))', 'Pipe price [EUR]');
model.variable('var5').set('power1', 'intopInlet1((p-1[atm])*nipfl.Qv)', 'Pumping power');
model.variable('var5').set('power2', 'intopInlet2((p-1[atm])*nipfl.Qv)', 'Pumping power');
model.variable('var5').set('pumpPrice', 'pumpWeight*(power1+power2)', 'Pump price [EUR]');
model.variable('var5').set('obj', 'pipePrice+pumpPrice', 'Objective function');
model.variable('var5').set('flow1in', 'intopInlet1(nipfl.Qm)', 'Mass flow rate, Inlet 1');
model.variable('var5').set('flow2in', 'intopInlet2(nipfl.Qm)', 'Mass flow rate, Inlet 2');
model.variable('var5').set('Pin', 'flow1in*intopOutlet1((T1-T)*mat1.def.Cp(T))+flow2in*intopOutlet2((T2-T)*mat1.def.Cp(T))', 'Energy input');
model.variable('var5').set('Pconsumer', 'intopConsumers(-P/Lz)', 'Total consumer power');
model.variable('var5').set('Efficiency', 'Pconsumer/Pin', 'Network efficiency');
model.variable('var5').set('Pout', 'intopAll(-qHeat)', 'Total heat loss');

model.physics('nipfl').feature('pipe1').set('shape', 'Round');
model.physics('nipfl').feature('pipe1').set('innerd', 'pipeD');
model.physics('nipfl').feature('pr1').set('p0', '1[atm]');
model.physics('nipfl').feature('temp1').set('Tin', 'T1');
model.physics('nipfl').create('hs1', 'HeatSource', 1);
model.physics('nipfl').feature('hs1').selection.all;
model.physics('nipfl').feature('hs1').set('Q', 'qHeat');
model.physics('nipfl').create('pr2', 'Pressure', 0);
model.physics('nipfl').feature('pr2').selection.named('geom1_ballsel1');
model.physics('nipfl').feature('pr2').set('p0', '1[atm]+dp1*exp(dp1c)');
model.physics('nipfl').feature.duplicate('pr3', 'pr2');
model.physics('nipfl').feature('pr3').selection.named('geom1_ballsel4');
model.physics('nipfl').feature('pr3').set('p0', '1[atm]+dp2*exp(dp2c)');
model.physics('nipfl').create('temp2', 'Temperature', 0);
model.physics('nipfl').feature('temp2').selection.named('geom1_ballsel4');
model.physics('nipfl').feature('temp2').set('Tin', 'T2');
model.physics('nipfl').create('hofl1', 'HeatOutflow', 0);
model.physics('nipfl').feature('hofl1').selection.named('geom1_ballsel2');
model.physics('nipfl').feature.duplicate('hofl2', 'hofl1');
model.physics('nipfl').feature('hofl2').selection.named('geom1_ballsel3');
model.physics('ce').label('Average Consumer Power');
model.physics('ce').selection.named('geom1_unisel2');
model.physics('ce').feature('cfeq1').setIndex('c', {'1e6*Lz^2' '0' '0' '0' '1e6*Lz^2' '0' '0' '0' '1e6*Lz^2'}, 0);
model.physics('ce').feature('cfeq1').setIndex('a', 1, 0);
model.physics('ce').feature('cfeq1').setIndex('f', 'qHeat*Lz', 0);

model.mesh('mesh1').autoMeshSize(1);

model.study('std1').label('Initial Design');

model.sol.create('sol1');
model.sol('sol1').study('std1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'stat');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').set('control', 'stat');
model.sol('sol1').create('s1', 'Stationary');
model.sol('sol1').feature('s1').create('seDef', 'Segregated');
model.sol('sol1').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('s1').create('d1', 'Direct');
model.sol('sol1').feature('s1').feature('d1').label('Direct (Merged)');
model.sol('sol1').feature('s1').feature('fc1').set('linsolver', 'd1');
model.sol('sol1').feature('s1').feature.remove('fcDef');
model.sol('sol1').feature('s1').feature.remove('seDef');
model.sol('sol1').attach('std1');
model.sol('sol1').runFromTo('st1', 'v1');

model.result.create('pg1', 'PlotGroup3D');
model.result('pg1').label('Pressure (nipfl)');
model.result('pg1').set('data', 'dset1');
model.result('pg1').set('defaultPlotID', 'pipeflow_NonisothermalPipeFlow/phys3/pdef1/pcond2/pg1');
model.result('pg1').feature.create('line1', 'Line');
model.result('pg1').feature('line1').set('showsolutionparams', 'on');
model.result('pg1').feature('line1').set('expr', 'p');
model.result('pg1').feature('line1').set('linetype', 'tube');
model.result('pg1').feature('line1').set('radiusexpr', '0.5*nipfl.dh');
model.result('pg1').feature('line1').set('smooth', 'internal');
model.result('pg1').feature('line1').set('showsolutionparams', 'on');
model.result('pg1').feature('line1').set('data', 'parent');
model.result.create('pg2', 'PlotGroup3D');
model.result('pg2').label('Velocity (nipfl)');
model.result('pg2').set('data', 'dset1');
model.result('pg2').set('defaultPlotID', 'pipeflow_NonisothermalPipeFlow/phys3/pdef1/pcond2/pg2');
model.result('pg2').feature.create('arwl1', 'ArrowLine');
model.result('pg2').feature('arwl1').set('showsolutionparams', 'on');
model.result('pg2').feature('arwl1').set('arrowcount', 20);
model.result('pg2').feature('arwl1').set('arrowlength', 'normalized');
model.result('pg2').feature('arwl1').set('showsolutionparams', 'on');
model.result('pg2').feature('arwl1').set('data', 'parent');
model.result('pg2').feature('arwl1').feature.create('col1', 'Color');
model.result('pg2').feature('arwl1').feature('col1').set('showcolordata', 'off');
model.result('pg2').feature('arwl1').feature('col1').set('expr', 'abs(u)');
model.result.create('pg3', 'PlotGroup3D');
model.result('pg3').label('Temperature (nipfl)');
model.result('pg3').set('data', 'dset1');
model.result('pg3').set('defaultPlotID', 'pipeflow_NonisothermalPipeFlow/phys3/pdef1/pcond2/pg3');
model.result('pg3').feature.create('line1', 'Line');
model.result('pg3').feature('line1').set('showsolutionparams', 'on');
model.result('pg3').feature('line1').set('linetype', 'tube');
model.result('pg3').feature('line1').set('radiusexpr', '0.5*nipfl.dh');
model.result('pg3').feature('line1').set('colortable', 'HeatCameraLight');
model.result('pg3').feature('line1').set('smooth', 'internal');
model.result('pg3').feature('line1').set('showsolutionparams', 'on');
model.result('pg3').feature('line1').set('data', 'parent');
model.result.create('pg4', 'PlotGroup3D');
model.result('pg4').set('data', 'dset1');
model.result('pg4').create('line1', 'Line');
model.result('pg4').label('Average Consumer Power');
model.result('pg4').feature('line1').set('expr', 'P');
model.result('pg1').run;

model.sol('sol1').feature('s1').create('se1', 'Segregated');
model.sol('sol1').feature('s1').feature('se1').create('ss1', 'SegregatedStep');
model.sol('sol1').feature('s1').feature('se1').feature('ss1').label('Temperature');
model.sol('sol1').feature('s1').feature('se1').feature('ss1').set('segvar', {'comp1_bypass' 'comp1_consumers' 'comp1_pipeControl' 'comp1_T'});
model.sol('sol1').feature('s1').feature('se1').create('ss2', 'SegregatedStep');
model.sol('sol1').feature('s1').feature('se1').feature('ss2').label('Power');
model.sol('sol1').feature('s1').feature('se1').feature('ss2').set('segvar', {'comp1_bypass' 'comp1_consumers' 'comp1_P' 'comp1_pipeControl'});
model.sol('sol1').feature('s1').feature('se1').feature('ssDef').label('Flow');
model.sol('sol1').feature('s1').feature('se1').feature('ssDef').set('segvar', {'comp1_bypass' 'comp1_consumers' 'comp1_p' 'comp1_pipeControl' 'comp1_u'});
model.sol('sol1').runAll;

model.result('pg1').run;
model.result('pg4').run;
model.result.remove('pg4');
model.result('pg2').run;
model.result('pg2').feature('arwl1').set('placement', 'gausspoints');
model.result('pg2').run;
model.result('pg3').run;
model.result('pg3').feature('line1').set('unit', 'degC');
model.result('pg3').run;
model.result('pg1').run;

model.nodeGroup.create('grp2', 'Results');
model.nodeGroup('grp2').set('type', 'plotgroup');
model.nodeGroup('grp2').add('plotgroup', 'pg1');
model.nodeGroup('grp2').add('plotgroup', 'pg2');
model.nodeGroup('grp2').add('plotgroup', 'pg3');
model.nodeGroup('grp2').label('Initial Design');

model.study.create('std2');
model.study('std2').create('stat', 'Stationary');
model.study('std2').feature('stat').setSolveFor('/physics/nipfl', true);
model.study('std2').feature('stat').setSolveFor('/physics/ce', true);
model.study.create('std3');
model.study('std3').create('stat', 'Stationary');
model.study('std3').feature('stat').setSolveFor('/physics/nipfl', true);
model.study('std3').feature('stat').setSolveFor('/physics/ce', true);
model.study('std2').create('opt', 'Optimization');
model.study('std2').feature('opt').set('optsolver', 'mma');
model.study('std2').feature('opt').set('nsolvemax', 50);
model.study('std2').feature('opt').set('optobj', {'comp1.constr'});
model.study('std2').feature('opt').set('descr', {'Constraint'});
model.study('std2').feature('opt').setIndex('optobj', 'log10(comp1.constr)', 0);
model.study('std2').feature('opt').setIndex('descr', 'Constraint', 0);
model.study('std2').setGenPlots(false);
model.study('std2').label('Feasible Design');

model.sol.create('sol2');
model.sol('sol2').study('std2');
model.sol('sol2').create('st1', 'StudyStep');
model.sol('sol2').feature('st1').set('study', 'std2');
model.sol('sol2').feature('st1').set('studystep', 'stat');
model.sol('sol2').create('v1', 'Variables');
model.sol('sol2').feature('v1').set('control', 'stat');
model.sol('sol2').create('o1', 'Optimization');
model.sol('sol2').feature('o1').set('control', 'opt');
model.sol('sol2').feature('o1').create('s1', 'StationaryAttrib');
model.sol('sol2').feature('o1').feature('s1').set('control', 'stat');
model.sol('sol2').feature('o1').feature('s1').create('seDef', 'Segregated');
model.sol('sol2').feature('o1').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol2').feature('o1').feature('s1').create('d1', 'Direct');
model.sol('sol2').feature('o1').feature('s1').feature('d1').label('Direct (Merged)');
model.sol('sol2').feature('o1').feature('s1').feature('fc1').set('linsolver', 'd1');
model.sol('sol2').feature('o1').feature('s1').feature.remove('fcDef');
model.sol('sol2').feature('o1').feature('s1').feature.remove('seDef');
model.sol('sol2').attach('std2');
model.sol('sol2').runFromTo('st1', 'v1');
model.sol('sol2').feature('o1').set('movelimitactive', true);
model.sol('sol2').feature('o1').feature('s1').create('se1', 'Segregated');
model.sol('sol2').feature('o1').feature('s1').feature('se1').create('ss1', 'SegregatedStep');
model.sol('sol2').feature('o1').feature('s1').feature('se1').feature('ss1').label('Temperature');
model.sol('sol2').feature('o1').feature('s1').feature('se1').feature('ss1').set('segvar', {'comp1_bypass' 'comp1_consumers' 'comp1_pipeControl' 'comp1_T'});
model.sol('sol2').feature('o1').feature('s1').feature('se1').create('ss2', 'SegregatedStep');
model.sol('sol2').feature('o1').feature('s1').feature('se1').feature('ss2').label('Power');
model.sol('sol2').feature('o1').feature('s1').feature('se1').feature('ss2').set('segvar', {'comp1_bypass' 'comp1_consumers' 'comp1_P' 'comp1_pipeControl'});
model.sol('sol2').feature('o1').feature('s1').feature('se1').feature('ssDef').label('Flow');
model.sol('sol2').feature('o1').feature('s1').feature('se1').feature('ssDef').set('segvar', {'comp1_bypass' 'comp1_consumers' 'comp1_p' 'comp1_pipeControl' 'comp1_u'});
model.sol('sol2').feature('o1').feature('s1').feature('d1').set('linsolver', 'pardiso');

model.result('pg1').run;
model.result.duplicate('pg4', 'pg1');

model.nodeGroup('grp2').add('plotgroup', 'pg4');

model.result.duplicate('pg5', 'pg2');

model.nodeGroup('grp2').add('plotgroup', 'pg5');

model.result.duplicate('pg6', 'pg3');

model.nodeGroup('grp2').add('plotgroup', 'pg6');

model.result('pg4').run;

model.nodeGroup('grp2').remove('plotgroup', 'pg6', false);
model.nodeGroup('grp2').remove('plotgroup', 'pg5', false);
model.nodeGroup('grp2').remove('plotgroup', 'pg4', false);

model.result('pg6').run;
model.result('pg4').run;
model.result('pg4').set('data', 'dset2');
model.result('pg5').run;
model.result('pg5').set('data', 'dset2');
model.result('pg6').run;
model.result('pg6').set('data', 'dset2');
model.result.create('pg7', 'PlotGroup3D');
model.result('pg7').run;
model.result('pg7').label('Power');
model.result('pg7').set('data', 'dset2');
model.result('pg7').create('line1', 'Line');
model.result('pg7').feature('line1').set('expr', '-P');
model.result('pg7').feature('line1').set('rangecoloractive', true);
model.result('pg7').feature('line1').set('rangecolormin', '0.8*consumerPower');
model.result('pg7').feature('line1').set('rangecolormax', '1.2*consumerPower');
model.result('pg7').feature('line1').set('linetype', 'tube');
model.result('pg7').feature('line1').set('radiusexpr', '5');
model.result('pg7').feature('line1').set('tuberadiusscaleactive', true);
model.result('pg7').feature('line1').set('colortable', 'ThermalDark');
model.result('pg4').run;

model.nodeGroup.create('grp3', 'Results');
model.nodeGroup('grp3').set('type', 'plotgroup');
model.nodeGroup.move('grp3', 2);
model.nodeGroup('grp3').add('plotgroup', 'pg4');
model.nodeGroup('grp3').add('plotgroup', 'pg5');
model.nodeGroup('grp3').add('plotgroup', 'pg6');
model.nodeGroup('grp3').add('plotgroup', 'pg7');
model.nodeGroup('grp3').label('Feasible Design');

model.study('std2').feature('opt').set('plot', true);
model.study('std2').feature('opt').set('plotgroup', 'pg7');

model.sol('sol2').runAll;

model.result('pg4').run;

model.study('std2').feature('opt').set('probewindow', '');

model.result.evaluationGroup.create('eg1', 'EvaluationGroup');
model.result.evaluationGroup('eg1').label('Feasible Design');
model.result.evaluationGroup('eg1').set('data', 'dset2');
model.result.evaluationGroup('eg1').create('gev1', 'EvalGlobal');
model.result.evaluationGroup('eg1').feature('gev1').set('expr', {'Efficiency'});
model.result.evaluationGroup('eg1').feature('gev1').set('descr', {'Network efficiency'});
model.result.evaluationGroup('eg1').feature('gev1').set('expr', {'Efficiency' 'pumpPrice'});
model.result.evaluationGroup('eg1').feature('gev1').set('descr', {'Network efficiency' 'Pump price [EUR]'});
model.result.evaluationGroup('eg1').feature('gev1').set('expr', {'Efficiency' 'pumpPrice' 'pipePrice'});
model.result.evaluationGroup('eg1').feature('gev1').set('descr', {'Network efficiency' 'Pump price [EUR]' 'Pipe price [EUR]'});
model.result.evaluationGroup('eg1').run;

model.study('std3').create('opt', 'Optimization');
model.study('std3').feature('opt').set('optsolver', 'mma');
model.study('std3').feature('opt').set('nsolvemax', 2000);
model.study('std3').feature('opt').set('optobj', {'comp1.obj'});
model.study('std3').feature('opt').set('descr', {'Objective function'});
model.study('std3').feature('opt').set('objectivescaling', 'init');
model.study('std3').feature('opt').setIndex('pname', 'consumerPower', 0);
model.study('std3').feature('opt').setIndex('initval', '5[kW]', 0);
model.study('std3').feature('opt').setIndex('scale', 1, 0);
model.study('std3').feature('opt').setIndex('lbound', '', 0);
model.study('std3').feature('opt').setIndex('ubound', '', 0);
model.study('std3').feature('opt').setIndex('pname', 'consumerPower', 0);
model.study('std3').feature('opt').setIndex('initval', '5[kW]', 0);
model.study('std3').feature('opt').setIndex('scale', 1, 0);
model.study('std3').feature('opt').setIndex('lbound', '', 0);
model.study('std3').feature('opt').setIndex('ubound', '', 0);
model.study('std3').feature('opt').setIndex('pname', 'dInit', 1);
model.study('std3').feature('opt').setIndex('initval', '20[cm]', 1);
model.study('std3').feature('opt').setIndex('scale', 1, 1);
model.study('std3').feature('opt').setIndex('lbound', '', 1);
model.study('std3').feature('opt').setIndex('ubound', '', 1);
model.study('std3').feature('opt').setIndex('pname', 'dInit', 1);
model.study('std3').feature('opt').setIndex('initval', '20[cm]', 1);
model.study('std3').feature('opt').setIndex('scale', 1, 1);
model.study('std3').feature('opt').setIndex('lbound', '', 1);
model.study('std3').feature('opt').setIndex('ubound', '', 1);
model.study('std3').feature('opt').setIndex('pname', 'dp1c', 0);
model.study('std3').feature('opt').setIndex('initval', 0, 0);
model.study('std3').feature('opt').setIndex('scale', 1, 0);
model.study('std3').feature('opt').setIndex('lbound', 'log(0.1)', 0);
model.study('std3').feature('opt').setIndex('ubound', 'log(10)', 0);
model.study('std3').feature('opt').setIndex('pname', 'dp2c', 1);
model.study('std3').feature('opt').setIndex('initval', 0, 1);
model.study('std3').feature('opt').setIndex('scale', 1, 1);
model.study('std3').feature('opt').setIndex('lbound', 'log(0.1)', 1);
model.study('std3').feature('opt').setIndex('ubound', 'log(10)', 1);
model.study('std3').feature('opt').set('constraintExpression', {'comp1.constr'});
model.study('std3').feature('opt').setIndex('constraintExpression', 'log10(comp1.constr/1e-3)', 0);
model.study('std3').feature('opt').setIndex('constraintLbound', '', 0);
model.study('std3').feature('opt').setIndex('constraintUbound', 0, 0);
model.study('std3').label('Optimization');
model.study('std3').setGenPlots(false);

model.sol.create('sol3');
model.sol('sol3').study('std3');
model.sol('sol3').create('st1', 'StudyStep');
model.sol('sol3').feature('st1').set('study', 'std3');
model.sol('sol3').feature('st1').set('studystep', 'stat');
model.sol('sol3').create('v1', 'Variables');
model.sol('sol3').feature('v1').set('control', 'stat');
model.sol('sol3').create('o1', 'Optimization');
model.sol('sol3').feature('o1').set('control', 'opt');
model.sol('sol3').feature('o1').create('s1', 'StationaryAttrib');
model.sol('sol3').feature('o1').feature('s1').set('control', 'stat');
model.sol('sol3').feature('o1').feature('s1').create('seDef', 'Segregated');
model.sol('sol3').feature('o1').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol3').feature('o1').feature('s1').create('d1', 'Direct');
model.sol('sol3').feature('o1').feature('s1').feature('d1').label('Direct (Merged)');
model.sol('sol3').feature('o1').feature('s1').feature('fc1').set('linsolver', 'd1');
model.sol('sol3').feature('o1').feature('s1').feature.remove('fcDef');
model.sol('sol3').feature('o1').feature('s1').feature.remove('seDef');
model.sol('sol3').attach('std3');
model.sol('sol3').runFromTo('st1', 'v1');
model.sol('sol3').feature('o1').feature('s1').create('se1', 'Segregated');
model.sol('sol3').feature('o1').feature('s1').feature('se1').create('ss1', 'SegregatedStep');
model.sol('sol3').feature('o1').feature('s1').feature('se1').feature('ss1').label('Temperature');
model.sol('sol3').feature('o1').feature('s1').feature('se1').feature('ss1').set('segvar', {'comp1_bypass' 'comp1_consumers' 'comp1_pipeControl' 'comp1_T'});
model.sol('sol3').feature('o1').feature('s1').feature('se1').create('ss2', 'SegregatedStep');
model.sol('sol3').feature('o1').feature('s1').feature('se1').feature('ss2').label('Power');
model.sol('sol3').feature('o1').feature('s1').feature('se1').feature('ss2').set('segvar', {'comp1_bypass' 'comp1_consumers' 'comp1_P' 'comp1_pipeControl'});
model.sol('sol3').feature('o1').feature('s1').feature('se1').feature('ssDef').label('Flow');
model.sol('sol3').feature('o1').feature('s1').feature('se1').feature('ssDef').set('segvar', {'comp1_bypass' 'comp1_consumers' 'comp1_p' 'comp1_pipeControl' 'comp1_u' 'conpar3' 'conpar4'});
model.sol('sol3').feature('o1').feature('s1').feature('d1').set('linsolver', 'pardiso');

model.result('pg4').run;
model.result.duplicate('pg8', 'pg4');

model.nodeGroup('grp3').add('plotgroup', 'pg8');

model.result.duplicate('pg9', 'pg5');

model.nodeGroup('grp3').add('plotgroup', 'pg9');

model.result.duplicate('pg10', 'pg6');

model.nodeGroup('grp3').add('plotgroup', 'pg10');

model.result.duplicate('pg11', 'pg7');

model.nodeGroup('grp3').add('plotgroup', 'pg11');

model.result('pg8').run;

model.nodeGroup('grp3').remove('plotgroup', 'pg11', false);
model.nodeGroup('grp3').remove('plotgroup', 'pg10', false);
model.nodeGroup('grp3').remove('plotgroup', 'pg9', false);
model.nodeGroup('grp3').remove('plotgroup', 'pg8', false);

model.result('pg11').run;
model.result('pg8').run;
model.result('pg8').label('Pressure (nipfl) 2');
model.result('pg8').set('data', 'dset3');
model.result('pg9').run;
model.result('pg9').label('Velocity (nipfl) 2');
model.result('pg9').set('data', 'dset3');
model.result('pg10').run;
model.result('pg10').set('data', 'dset3');
model.result('pg10').label('Temperature (nipfl) 2');
model.result('pg11').run;
model.result('pg11').label('Power and Pipe Diameters');
model.result('pg11').set('data', 'dset3');
model.result('pg11').set('titletype', 'label');
model.result('pg11').set('edges', false);
model.result('pg11').create('line2', 'Line');
model.result('pg11').feature('line2').set('expr', 'nipfl.dh');
model.result('pg11').feature('line2').set('descr', 'Hydraulic diameter');
model.result('pg11').feature('line2').set('linetype', 'tube');
model.result('pg11').feature('line2').set('radiusexpr', 'nipfl.dh/2');
model.result('pg11').feature('line2').set('tuberadiusscaleactive', true);
model.result('pg11').feature('line2').set('tuberadiusscale', 200);
model.result('pg11').feature('line2').set('smooth', 'none');
model.result('pg11').feature('line2').create('sel1', 'Selection');
model.result('pg11').feature('line2').feature('sel1').selection.named('geom1_boxsel1');
model.result('pg11').run;
model.result('pg11').create('ann1', 'Annotation');
model.result('pg11').feature('ann1').set('text', 'eval(dp1*exp(dp1c),kPa) kPa, eval(dp2*exp(dp2c),kPa) kPa, P=[eval(minop1(-P),kW), eval(-minop1(P),kW)] kW');
model.result('pg11').feature('ann1').set('level', 'global');
model.result('pg11').feature('ann1').set('posxexpr', 20);
model.result('pg11').feature('ann1').set('posyexpr', 285);
model.result('pg11').feature('ann1').set('exprprecision', 3);
model.result('pg11').feature('ann1').set('showpoint', false);
model.result('pg11').feature('ann1').set('backgroundcolor', 'green');
model.result('pg11').feature.duplicate('ann2', 'ann1');
model.result('pg11').run;
model.result('pg11').feature('ann2').set('text', 'c0=[eval(minop1(exp(bypass))), eval(-minop1(-exp(bypass)))], c1=[eval(minop1(exp(consumers))), eval(-minop1(-exp(consumers)))]');
model.result('pg11').feature('ann2').set('posyexpr', 250);
model.result.create('pg12', 'PlotGroup3D');
model.result('pg12').run;
model.result('pg12').label('Bypass');
model.result('pg12').set('data', 'dset3');
model.result('pg12').create('line1', 'Line');
model.result('pg12').feature('line1').set('expr', 'genext2(exp(bypass))');
model.result('pg12').feature('line1').set('linetype', 'tube');
model.result('pg12').feature('line1').set('tuberadiusscaleactive', true);
model.result('pg12').feature('line1').set('tuberadiusscale', 10);
model.result('pg12').run;
model.result('pg12').set('titletype', 'label');
model.result.duplicate('pg13', 'pg12');
model.result('pg13').run;
model.result('pg13').label('Consumers');
model.result('pg13').run;
model.result('pg13').feature('line1').set('expr', 'genext2(exp(consumers))');
model.result('pg8').run;

model.nodeGroup.create('grp4', 'Results');
model.nodeGroup('grp4').set('type', 'plotgroup');
model.nodeGroup.move('grp4', 3);
model.nodeGroup('grp4').add('plotgroup', 'pg8');
model.nodeGroup('grp4').add('plotgroup', 'pg9');
model.nodeGroup('grp4').add('plotgroup', 'pg10');
model.nodeGroup('grp4').add('plotgroup', 'pg11');
model.nodeGroup('grp4').add('plotgroup', 'pg12');
model.nodeGroup('grp4').add('plotgroup', 'pg13');
model.nodeGroup('grp4').label('Optimization');

model.study('std3').feature('opt').set('plot', true);
model.study('std3').feature('opt').set('plotgroup', 'pg11');
model.study('std3').feature('stat').set('useinitsol', true);
model.study('std3').feature('stat').set('initmethod', 'sol');
model.study('std3').feature('stat').set('initstudy', 'std2');

model.sol('sol3').feature('o1').set('movelimitactive', true);
model.sol('sol3').feature('o1').set('gcmma', false);
model.sol('sol3').runAll;

model.result('pg8').run;

model.study('std3').feature('opt').set('probewindow', '');

model.result.evaluationGroup.duplicate('eg2', 'eg1');
model.result.evaluationGroup('eg2').label('Optimization');
model.result.evaluationGroup('eg2').set('data', 'dset3');
model.result.evaluationGroup('eg2').run;
model.result('pg12').run;
model.result('pg12').feature('line1').set('rangecoloractive', true);
model.result('pg12').feature('line1').set('rangecolormax', 2);
model.result('pg12').run;
model.result('pg13').run;
model.result('pg13').run;
model.result('pg11').run;
model.result('pg11').run;

model.title('Topology Optimization of a District Heating Network');

model.description('The layout of a district heating network is designed using topology optimization.');

model.mesh.clearMeshes;

model.sol('sol1').clearSolutionData;
model.sol('sol2').clearSolutionData;
model.sol('sol3').clearSolutionData;

model.label('district_heating_optimization.mph');

model.modelNode.label('Components');

out = model;
