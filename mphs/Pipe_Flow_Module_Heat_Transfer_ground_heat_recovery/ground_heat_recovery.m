function out = model
%
% ground_heat_recovery.m
%
% Model exported on May 26 2025, 21:31 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/Pipe_Flow_Module/Heat_Transfer');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 3);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.physics.create('ht', 'HeatTransfer', 'geom1');
model.physics('ht').model('comp1');
model.physics.create('htp', 'HeatTransferPipes', 'geom1');
model.physics('htp').model('comp1');
model.physics.create('ev', 'Events', 'geom1');
model.physics('ev').model('comp1');
model.physics.create('ge', 'GlobalEquations', 'geom1');
model.physics('ge').model('comp1');
model.physics('ge').prop('EquationForm').set('form', 'Automatic');

model.study.create('std1');
model.study('std1').create('time', 'Transient');
model.study('std1').feature('time').setSolveFor('/physics/ht', true);
model.study('std1').feature('time').setSolveFor('/physics/htp', true);
model.study('std1').feature('time').setSolveFor('/physics/ev', true);
model.study('std1').feature('time').setSolveFor('/physics/ge', true);

model.geom.load({'part1' 'part2' 'part3'}, 'ground_heat_recovery_geom_sequence.mph', {'part1' 'part2' 'part3'});

model.param.set('pattern', '3');
model.param.descr('pattern', 'Parameter for selecting the pattern');
model.param.set('d_pipe', '36[mm]');
model.param.descr('d_pipe', 'Pipe diameter in soil');
model.param.set('flowrate_pipe', '1[l/s]');
model.param.descr('flowrate_pipe', 'Flow rate inside pipes');
model.param.set('heat_demand', '30[kW*h]');
model.param.descr('heat_demand', 'Daily heat demand');
model.param.set('power', '4[kW]');
model.param.descr('power', 'Heat pump power');
model.param.set('dt', '30[s]');
model.param.descr('dt', 'Smoothed heater state transition zone');
model.param.set('depth', '4[m]');
model.param.descr('depth', 'Depth of heat exchanger');
model.param.set('Tz_depth', '0.5[K/m]');
model.param.descr('Tz_depth', 'Temperature gradient');
model.param.set('month', '1');
model.param.descr('month', 'Month index');
model.param.set('humidity', '1');
model.param.descr('humidity', 'Soil humidity');
model.param.set('k_soil', '0.18[W/(m*K)]+(1.5-0.18)*humidity');
model.param.descr('k_soil', 'Soil thermal conductivity');

model.geom('geom1').create('wp1', 'WorkPlane');
model.geom('geom1').feature('wp1').set('unite', true);
model.geom('geom1').feature('wp1').set('quickz', '-depth');
model.geom('geom1').selection.create('csel1', 'CumulativeSelection');
model.geom('geom1').selection('csel1').label('Pipes');
model.geom('geom1').feature('wp1').set('contributeto', 'csel1');
model.geom('geom1').feature('wp1').geom.create('if1', 'If');
model.geom('geom1').feature('wp1').geom.feature.createAfter('endif1', 'EndIf', 'if1');
model.geom('geom1').feature('wp1').geom.feature('if1').set('condition', 'pattern==1');
model.geom('geom1').feature('wp1').geom.run('if1');
model.geom('geom1').feature('wp1').geom.create('imp1', 'Import');
model.geom('geom1').feature('wp1').geom.feature('imp1').set('type', 'sequence');
model.geom('geom1').feature('wp1').geom.feature('imp1').set('sequence', 'part1');
model.geom('geom1').feature('wp1').geom.run('imp1');
model.geom('geom1').feature('wp1').geom.create('elseif1', 'ElseIf');
model.geom('geom1').feature('wp1').geom.feature('elseif1').set('condition', 'pattern==2');
model.geom('geom1').feature('wp1').geom.run('elseif1');
model.geom('geom1').feature('wp1').geom.create('imp2', 'Import');
model.geom('geom1').feature('wp1').geom.feature('imp2').set('type', 'sequence');
model.geom('geom1').feature('wp1').geom.feature('imp2').set('sequence', 'part2');
model.geom('geom1').feature('wp1').geom.run('imp2');
model.geom('geom1').feature('wp1').geom.create('else1', 'Else');
model.geom('geom1').feature('wp1').geom.create('imp3', 'Import');
model.geom('geom1').feature('wp1').geom.feature('imp3').set('type', 'sequence');
model.geom('geom1').feature('wp1').geom.feature('imp3').set('sequence', 'part3');
model.geom('geom1').run('wp1');
model.geom('geom1').create('pol1', 'Polygon');
model.geom('geom1').feature('pol1').set('source', 'table');
model.geom('geom1').feature('pol1').setIndex('table', 2.5, 0, 0);
model.geom('geom1').feature('pol1').setIndex('table', 20, 0, 1);
model.geom('geom1').feature('pol1').setIndex('table', 0, 0, 2);
model.geom('geom1').feature('pol1').setIndex('table', 2.5, 1, 0);
model.geom('geom1').feature('pol1').setIndex('table', 20, 1, 1);
model.geom('geom1').feature('pol1').setIndex('table', '-depth', 1, 2);
model.geom('geom1').feature('pol1').set('contributeto', 'csel1');
model.geom('geom1').run('pol1');
model.geom('geom1').create('copy1', 'Copy');
model.geom('geom1').feature('copy1').selection('input').set({'pol1'});
model.geom('geom1').feature('copy1').set('displx', 0.5);
model.geom('geom1').feature('copy1').set('contributeto', 'csel1');
model.geom('geom1').run('copy1');
model.geom('geom1').create('blk1', 'Block');
model.geom('geom1').feature('blk1').set('size', {'15' '22' 'depth+3[m]'});
model.geom('geom1').feature('blk1').set('pos', {'0' '0' '-(depth+3[m])'});
model.geom('geom1').selection.create('csel2', 'CumulativeSelection');
model.geom('geom1').selection('csel2').label('Ground');
model.geom('geom1').feature('blk1').set('contributeto', 'csel2');
model.geom('geom1').runPre('fin');

model.view('view1').hideEntities.create('hide1');

model.geom('geom1').run;

model.view('view1').hideEntities('hide1').geom('geom1', 2);
model.view('view1').hideEntities('hide1').set([1 2 4]);

model.func.create('int1', 'Interpolation');
model.func('int1').label('Yearly Temperature Profile');
model.func('int1').set('funcname', 'T_z0');
model.func('int1').set('table', {'1/12' '-1.1';  ...
'2/12' '0.1';  ...
'3/12' '3';  ...
'4/12' '7.4';  ...
'5/12' '12.2';  ...
'6/12' '15.4';  ...
'7/12' '17';  ...
'8/12' '16.5';  ...
'9/12' '13.1';  ...
'10/12' '8.4';  ...
'11/12' '3.4';  ...
'12/12' '0.2'});
model.func('int1').set('interp', 'piecewisecubic');
model.func('int1').setIndex('argunit', 'a', 0);
model.func('int1').setIndex('fununit', 'degC', 0);
model.func('int1').createPlot('pg1');

model.result('pg1').run;
model.result('pg1').label('Temperature Profile');
model.result('pg1').set('titletype', 'none');
model.result('pg1').set('xlabelactive', true);
model.result('pg1').set('xlabel', 'Month');
model.result('pg1').run;
model.result('pg1').feature('plot1').set('expr', 'T_z0(root.t[a])[1/degC]');
model.result('pg1').feature('plot1').set('xdataexpr', 'root.t*12');
model.result('pg1').feature('plot1').set('lowerbound', 1);
model.result('pg1').feature('plot1').set('upperbound', 12);
model.result('pg1').feature('plot1').set('xdatadescr', 'Month');
model.result('pg1').feature('plot1').set('linewidth', 3);
model.result('pg1').run;
model.result('pg1').create('lngr1', 'LineGraph');
model.result('pg1').feature('lngr1').set('markerpos', 'datapoints');
model.result('pg1').feature('lngr1').set('linewidth', 'preference');
model.result('pg1').feature('lngr1').set('data', 'int1_ds1');
model.result('pg1').feature('lngr1').set('expr', 'T_z0(root.t[a])[1/degC]');
model.result('pg1').feature('lngr1').set('xdata', 'expr');
model.result('pg1').feature('lngr1').set('xdataexpr', 'month');
model.result('pg1').feature('lngr1').set('linecolor', 'black');
model.result('pg1').feature('lngr1').set('linewidth', 3);
model.result('pg1').run;

model.func.create('an1', 'Analytic');
model.func('an1').label('Depth Temperature Gradient');
model.func('an1').set('funcname', 'T0');
model.func('an1').set('expr', 'T_z0(month[a]/12)[1/degC]+Tz_depth[m/K]*(-z)');
model.func('an1').set('args', 'z');
model.func('an1').setIndex('argunit', 'm', 0);
model.func('an1').set('fununit', 'degC');
model.func('an1').setIndex('plotargs', -10, 0, 1);
model.func('an1').setIndex('plotargs', 0, 0, 2);
model.func('an1').createPlot('pg2');

model.result('pg2').run;
model.result('pg2').label('Temperature Gradient');
model.result('pg2').set('titletype', 'none');
model.result('pg2').set('xlabelactive', true);
model.result('pg2').set('xlabel', 'Depth (m)');
model.result('pg2').run;
model.result('pg2').feature('plot1').set('linewidth', 3);
model.result('pg2').run;

model.func.create('step1', 'Step');
model.func('step1').label('Smoothed Heaviside Function');
model.func('step1').set('smooth', 1);

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
model.material('mat1').selection.geom('geom1', 1);
model.material('mat1').selection.named('geom1_csel1_edg');
model.material.create('mat2', 'Common', 'comp1');
model.material('mat2').label('Soil');
model.material('mat2').selection.named('geom1_csel2_dom');
model.material('mat2').propertyGroup('def').set('thermalconductivity', {'k_soil'});
model.material('mat2').propertyGroup('def').set('density', {'1742'});
model.material('mat2').propertyGroup('def').set('heatcapacity', {'1175'});

model.physics('ht').feature('init1').set('Tinit', 'T0(z)');
model.physics('ht').create('temp1', 'TemperatureBoundary', 2);
model.physics('ht').feature('temp1').selection.set([4]);
model.physics('ht').feature('temp1').set('T0', 'T_z0(t+month[a]/12)');
model.physics('ht').create('hf1', 'HeatFluxBoundary', 2);
model.physics('ht').feature('hf1').selection.set([3]);
model.physics('ht').feature('hf1').set('q0_input', '-ht.k_iso*Tz_depth');
model.physics('htp').selection.named('geom1_csel1_edg');
model.physics('htp').feature('ht1').set('u', 'flowrate_pipe*(1/10+heater_state_smoothed*9/10)/htp.A');
model.physics('htp').feature('pipe1').set('shape', 'Round');
model.physics('htp').feature('pipe1').set('innerd', 'd_pipe');

model.cpl.create('intop1', 'Integration', 'geom1');
model.cpl('intop1').set('axisym', true);
model.cpl('intop1').selection.geom('geom1', 0);
model.cpl('intop1').selection.set([11]);
model.cpl.create('intop2', 'Integration', 'geom1');
model.cpl('intop2').set('axisym', true);
model.cpl('intop2').selection.geom('geom1', 0);
model.cpl('intop2').selection.set([7]);

model.variable.create('var1');
model.variable('var1').model('comp1');
model.variable('var1').set('heater_state_smoothed', 'if(heater_state,1,step1((mod(t+dt/2,1[d])-dt)/dt))*if(t_stop>0,1-step1((t-(t_stop+dt/2))/dt),1)');
model.variable('var1').descr('heater_state_smoothed', 'Smoothed heater state');
model.variable('var1').set('T_out', 'intop1(T2)');
model.variable('var1').descr('T_out', 'Water temperature at pipe outlet');
model.variable('var1').set('T_in', 'nojac(T_out-power*heater_state_smoothed/(intop1(htp.rho)*intop1(htp.Cp)*flowrate_pipe))');
model.variable('var1').descr('T_in', 'Inlet temperature for pipes');

model.physics('htp').feature('temp1').set('Tin', 'T_in');
model.physics('htp').feature('init1').set('T2', 'T0(z)');
model.physics('htp').create('hofl1', 'HeatOutflow', 0);
model.physics('htp').feature('hofl1').selection.set([11]);
model.physics('htp').create('wht1', 'WallHeatTransfer', 1);
model.physics('htp').feature('wht1').selection.named('geom1_csel1_edg');
model.physics('htp').feature('wht1').create('intfilm1', 'InternalFilmResistance', 1);
model.physics('htp').feature('wht1').create('wall1', 'WallLayer', 1);
model.physics('htp').feature('wht1').feature('wall1').set('kChoice', 'UserDefined');
model.physics('htp').feature('wht1').feature('wall1').set('k', 400);
model.physics('htp').feature('wht1').feature('wall1').set('deltawChoice', 'UserDefined');
model.physics('htp').feature('wht1').feature('wall1').set('item.deltaw', '3.25[mm]');

model.multiphysics.create('pwhtc1', 'PipeWallHeatTransfer', 'geom1', 1);

model.physics('ev').create('ds1', 'DiscreteStates', -1);
model.physics('ev').feature('ds1').setIndex('dim', 'heater_state', 0, 0);
model.physics('ev').feature('ds1').setIndex('dimInit', 0, 0, 0);
model.physics('ev').feature('ds1').setIndex('dimInit', 0, 0, 0);
model.physics('ev').create('is1', 'IndicatorStates', -1);
model.physics('ev').feature('is1').setIndex('indDim', 'heat_diff', 0, 0);
model.physics('ev').feature('is1').setIndex('g', 0, 0, 0);
model.physics('ev').feature('is1').setIndex('dimInit', 0, 0, 0);
model.physics('ev').feature('is1').setIndex('g', 'heat_demand-heat_prod', 0, 0);
model.physics('ev').feature('is1').setIndex('dimInit', 'heat_demand', 0, 0);
model.physics('ev').create('expl1', 'ExplicitEvent', -1);
model.physics('ev').feature('expl1').set('start', 'dt');
model.physics('ev').feature('expl1').set('period', '24[h]');
model.physics('ev').feature('expl1').setIndex('reInitName', 'heater_state', 0, 0);
model.physics('ev').feature('expl1').setIndex('reInitValue', 0, 0, 0);
model.physics('ev').feature('expl1').setIndex('reInitValue', 1, 0, 0);
model.physics('ev').feature('expl1').setIndex('reInitName', 't_stop', 1, 0);
model.physics('ev').feature('expl1').setIndex('reInitValue', 0, 1, 0);
model.physics('ev').feature('expl1').setIndex('reInitValue', 't', 1, 0);
model.physics('ev').feature('expl1').setIndex('reInitName', 'heat_prod', 2, 0);
model.physics('ev').feature('expl1').setIndex('reInitValue', 0, 2, 0);
model.physics('ev').feature('expl1').setIndex('reInitValue', 0, 2, 0);
model.physics('ev').create('impl1', 'ImplicitEvent', -1);
model.physics('ev').feature('impl1').set('condition', 'heat_diff<0');
model.physics('ev').feature('impl1').setIndex('reInitName', 'heater_state', 0, 0);
model.physics('ev').feature('impl1').setIndex('reInitValue', 0, 0, 0);
model.physics('ev').feature('impl1').setIndex('reInitValue', 0, 0, 0);
model.physics('ge').feature('ge1').setIndex('name', 'heat_prod', 0, 0);
model.physics('ge').feature('ge1').setIndex('equation', 'power*heater_state-heat_prodt', 0, 0);
model.physics('ge').feature('ge1').set('DependentVariableQuantity', 'energy');
model.physics('ge').feature('ge1').set('SourceTermQuantity', 'power');
model.physics('ge').create('ge2', 'GlobalEquations', -1);
model.physics('ge').feature('ge2').setIndex('name', 't_stop', 0, 0);
model.physics('ge').feature('ge2').setIndex('equation', 'heater_state-t_stopt', 0, 0);
model.physics('ge').feature('ge2').set('DependentVariableQuantity', 'time');

model.probe.create('var1', 'GlobalVariable');
model.probe('var1').model('comp1');
model.probe('var1').label('Outlet Temperature');
model.probe('var1').set('expr', 'T_out');
model.probe('var1').set('descr', 'Water temperature at pipe outlet');
model.probe('var1').set('unit', 'degC');
model.probe('var1').set('table', 'new');
model.probe('var1').set('window', 'new');
model.probe.create('var2', 'GlobalVariable');
model.probe('var2').model('comp1');
model.probe('var2').label('Heat Production');
model.probe('var2').set('unit', 'kWh');
model.probe('var2').set('table', 'new');
model.probe('var2').set('window', 'new');
model.probe.create('var3', 'GlobalVariable');
model.probe('var3').model('comp1');
model.probe('var3').label('Heater State');
model.probe('var3').set('expr', 'heater_state_smoothed');
model.probe('var3').set('descr', 'Smoothed heater state');
model.probe('var3').set('table', 'new');
model.probe('var3').set('window', 'new');

model.mesh('mesh1').create('edg1', 'Edge');
model.mesh('mesh1').feature('edg1').selection.named('geom1_csel1_edg');
model.mesh('mesh1').feature('edg1').create('size1', 'Size');
model.mesh('mesh1').feature('edg1').feature('size1').selection.geom('geom1', 0);
model.mesh('mesh1').feature('edg1').feature('size1').selection.set([7 11]);
model.mesh('mesh1').feature('edg1').feature('size1').set('hauto', 1);
model.mesh('mesh1').feature('edg1').feature('size1').set('custom', true);
model.mesh('mesh1').feature('edg1').feature('size1').set('hmaxactive', true);
model.mesh('mesh1').feature('edg1').feature('size1').set('hmax', 0.25);
model.mesh('mesh1').feature('edg1').create('size2', 'Size');
model.mesh('mesh1').feature('edg1').feature('size2').set('hauto', 2);
model.mesh('mesh1').feature('edg1').feature('size2').set('custom', true);
model.mesh('mesh1').feature('edg1').feature('size2').set('hmaxactive', true);
model.mesh('mesh1').feature('edg1').feature('size2').set('hmax', 0.5);
model.mesh('mesh1').feature('edg1').feature('size2').set('hminactive', true);
model.mesh('mesh1').feature('edg1').feature('size2').set('hmin', 0.02);
model.mesh('mesh1').create('ftet1', 'FreeTet');
model.mesh('mesh1').feature('size').set('hauto', 4);
model.mesh('mesh1').run;

model.study('std1').create('param', 'Parametric');
model.study('std1').feature('param').setIndex('pname', 'pattern', 0);
model.study('std1').feature('param').setIndex('plistarr', '', 0);
model.study('std1').feature('param').setIndex('punit', '', 0);
model.study('std1').feature('param').setIndex('pname', 'pattern', 0);
model.study('std1').feature('param').setIndex('plistarr', '', 0);
model.study('std1').feature('param').setIndex('punit', '', 0);
model.study('std1').feature('param').setIndex('plistarr', '1 2 3', 0);
model.study('std1').feature('time').set('tunit', 'd');
model.study('std1').feature('time').set('tlist', 'range(0,3[h],2)');

model.sol.create('sol1');
model.sol('sol1').study('std1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'time');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').set('control', 'time');
model.sol('sol1').create('t1', 'Time');
model.sol('sol1').feature('t1').set('tlist', 'range(0,3[h],2)');
model.sol('sol1').feature('t1').set('plot', 'off');
model.sol('sol1').feature('t1').set('plotgroup', 'pg1');
model.sol('sol1').feature('t1').set('plotfreq', 'tout');
model.sol('sol1').feature('t1').set('probesel', 'all');
model.sol('sol1').feature('t1').set('probes', {'var1' 'var2' 'var3'});
model.sol('sol1').feature('t1').set('probefreq', 'tsteps');
model.sol('sol1').feature('t1').set('atolglobalvaluemethod', 'factor');
model.sol('sol1').feature('t1').set('atolmethod', {'comp1_htp_wht1_intfilm1_Tout' 'global' 'comp1_htp_wht1_wall1_Tout' 'global' 'comp1_T' 'global' 'comp1_T2' 'global' 'comp1_ev_ds1_dim' 'global'  ...
'comp1_ev_is1_indDim' 'global' 'comp1_ODE1' 'global' 'comp1_ODE2' 'global'});
model.sol('sol1').feature('t1').set('atol', {'comp1_htp_wht1_intfilm1_Tout' '1e-3' 'comp1_htp_wht1_wall1_Tout' '1e-3' 'comp1_T' '1e-3' 'comp1_T2' '1e-3' 'comp1_ev_ds1_dim' '1e-3'  ...
'comp1_ev_is1_indDim' '1e-3' 'comp1_ODE1' '1e-3' 'comp1_ODE2' '1e-3'});
model.sol('sol1').feature('t1').set('atolvaluemethod', {'comp1_htp_wht1_intfilm1_Tout' 'factor' 'comp1_htp_wht1_wall1_Tout' 'factor' 'comp1_T' 'factor' 'comp1_T2' 'factor' 'comp1_ev_ds1_dim' 'factor'  ...
'comp1_ev_is1_indDim' 'factor' 'comp1_ODE1' 'factor' 'comp1_ODE2' 'factor'});
model.sol('sol1').feature('t1').set('reacf', true);
model.sol('sol1').feature('t1').set('storeudot', true);
model.sol('sol1').feature('t1').set('endtimeinterpolation', true);
model.sol('sol1').feature('t1').set('estrat', 'exclude');
model.sol('sol1').feature('t1').set('maxorder', 2);
model.sol('sol1').feature('t1').set('control', 'time');
model.sol('sol1').feature('t1').create('seDef', 'Segregated');
model.sol('sol1').feature('t1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('t1').feature('fc1').set('stabacc', 'aacc');
model.sol('sol1').feature('t1').feature('fc1').set('aaccdim', 5);
model.sol('sol1').feature('t1').feature('fc1').set('aaccdelay', 0);
model.sol('sol1').feature('t1').feature('fc1').set('aaccmix', 0.9);
model.sol('sol1').feature('t1').feature('fc1').set('damp', 0.9);
model.sol('sol1').feature('t1').feature('fc1').set('jtech', 'once');
model.sol('sol1').feature('t1').feature('fc1').set('linsolver', 'dDef');
model.sol('sol1').feature('t1').feature('fc1').set('stabacc', 'aacc');
model.sol('sol1').feature('t1').feature('fc1').set('aaccdim', 5);
model.sol('sol1').feature('t1').feature('fc1').set('aaccdelay', 0);
model.sol('sol1').feature('t1').feature('fc1').set('aaccmix', 0.9);
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
model.batch('p1').set('pname', {'pattern'});
model.batch('p1').set('plistarr', {'1 2 3'});
model.batch('p1').set('sweeptype', 'sparse');
model.batch('p1').set('probesel', 'all');
model.batch('p1').set('probes', {'var1' 'var2' 'var3'});
model.batch('p1').set('plot', 'off');
model.batch('p1').set('err', 'on');
model.batch('p1').attach('std1');
model.batch('p1').set('control', 'param');

model.sol('sol1').feature('t1').set('initialstepbdfactive', true);
model.sol('sol1').feature('t1').set('initialstepbdf', '0.1[s]');
model.sol('sol1').feature('t1').set('maxstepconstraintbdf', 'const');
model.sol('sol1').feature('t1').set('maxstepbdf', '30[min]');
model.sol('sol1').feature('t1').feature('fc1').set('damp', '1');
model.sol('sol1').feature('t1').feature('fc1').set('jtech', 'minimal');
model.sol.create('sol2');
model.sol('sol2').study('std1');
model.sol('sol2').label('Parametric Solutions 1');

model.batch('p1').feature('so1').set('psol', 'sol2');

model.probe('var1').genResult('none');
model.probe('var2').genResult('none');
model.probe('var3').genResult('none');

model.batch('p1').run('compute');

model.result.create('pg6', 'PlotGroup3D');
model.result('pg6').label('Temperature (ht)');
model.result('pg6').set('data', 'dset2');
model.result('pg6').setIndex('looplevel', 17, 0);
model.result('pg6').setIndex('looplevel', 3, 1);
model.result('pg6').set('data', 'dset2');
model.result('pg6').setIndex('looplevel', 17, 0);
model.result('pg6').setIndex('looplevel', 3, 1);
model.result('pg6').set('defaultPlotID', 'ht/HT_PhysicsInterfaces/icom8/pdef1/pcond3/pcond3/pg1');
model.result('pg6').feature.create('vol1', 'Volume');
model.result('pg6').feature('vol1').set('showsolutionparams', 'on');
model.result('pg6').feature('vol1').set('solutionparams', 'parent');
model.result('pg6').feature('vol1').set('colortable', 'HeatCameraLight');
model.result('pg6').feature('vol1').set('smooth', 'internal');
model.result('pg6').feature('vol1').set('showsolutionparams', 'on');
model.result('pg6').feature('vol1').set('data', 'parent');
model.result.create('pg7', 'PlotGroup3D');
model.result('pg7').label('Temperature (htp)');
model.result('pg7').set('data', 'dset2');
model.result('pg7').setIndex('looplevel', 17, 0);
model.result('pg7').setIndex('looplevel', 3, 1);
model.result('pg7').set('data', 'dset2');
model.result('pg7').setIndex('looplevel', 17, 0);
model.result('pg7').setIndex('looplevel', 3, 1);
model.result('pg7').set('defaultPlotID', 'pipeflow_HeatTransferPipes/phys2/pdef1/pcond2/pg1');
model.result('pg7').feature.create('line1', 'Line');
model.result('pg7').feature('line1').set('showsolutionparams', 'on');
model.result('pg7').feature('line1').set('expr', 'T2');
model.result('pg7').feature('line1').set('linetype', 'tube');
model.result('pg7').feature('line1').set('radiusexpr', '0.5*htp.dh');
model.result('pg7').feature('line1').set('colortable', 'HeatCameraLight');
model.result('pg7').feature('line1').set('smooth', 'internal');
model.result('pg7').feature('line1').set('showsolutionparams', 'on');
model.result('pg7').feature('line1').set('data', 'parent');
model.result.numerical.create('gev4', 'EvalGlobal');
model.result.numerical('gev4').set('data', 'dset2');
model.result.numerical('gev4').set('expr', {'heat_prod' 't_stop'});
model.result.numerical('gev4').set('descr', {'State variable heat_prod' 'State variable t_stop'});
model.result.create('pg8', 'PlotGroup1D');
model.result('pg8').set('data', 'dset2');
model.result('pg8').create('glob1', 'Global');
model.result('pg8').feature('glob1').set('expr', {'heat_prod' 't_stop'});
model.result('pg8').feature('glob1').set('descr', {'State variable heat_prod' 'State variable t_stop'});
model.result.create('pg9', 'PlotGroup3D');
model.result('pg9').label('Temperature (pwhtc1)');
model.result('pg9').set('data', 'dset2');
model.result('pg9').setIndex('looplevel', 17, 0);
model.result('pg9').setIndex('looplevel', 3, 1);
model.result('pg9').set('data', 'dset2');
model.result('pg9').setIndex('looplevel', 17, 0);
model.result('pg9').setIndex('looplevel', 3, 1);
model.result('pg9').set('defaultPlotID', 'PipeCouplingFeatures/edgcpl1/pdef1/pcond2/pg1');
model.result('pg9').feature.create('line1', 'Line');
model.result('pg9').feature('line1').set('showsolutionparams', 'on');
model.result('pg9').feature('line1').set('expr', 'T2');
model.result('pg9').feature('line1').set('linetype', 'tube');
model.result('pg9').feature('line1').set('radiusexpr', 'pwhtc1.radiusExt');
model.result('pg9').feature('line1').set('tuberadiusscaleactive', true);
model.result('pg9').feature('line1').set('colortable', 'HeatCameraLight');
model.result('pg9').feature('line1').set('smooth', 'internal');
model.result('pg9').feature('line1').set('showsolutionparams', 'on');
model.result('pg9').feature('line1').set('data', 'parent');
model.result('pg9').feature.create('slc1', 'Slice');
model.result('pg9').feature('slc1').set('showsolutionparams', 'on');
model.result('pg9').feature('slc1').set('smooth', 'internal');
model.result('pg9').feature('slc1').set('showsolutionparams', 'on');
model.result('pg9').feature('slc1').set('data', 'parent');
model.result('pg9').feature('slc1').set('inheritplot', 'line1');
model.result('pg6').run;
model.result('pg6').run;
model.result('pg6').feature('vol1').create('tran1', 'Transparency');
model.result('pg6').run;
model.result('pg7').run;
model.result('pg7').run;
model.result('pg7').feature('line1').set('unit', 'degC');
model.result('pg7').run;
model.result('pg9').run;
model.result('pg9').create('surf1', 'Surface');
model.result('pg9').run;
model.result('pg9').feature('slc1').active(false);
model.result('pg9').run;
model.result('pg9').feature('surf1').set('unit', 'degC');
model.result('pg9').feature('surf1').set('inheritplot', 'line1');
model.result('pg9').run;
model.result('pg9').feature('line1').set('unit', 'degC');
model.result('pg9').feature('line1').set('tuberadiusscale', 5);
model.result('pg9').run;
model.result('pg3').set('window', 'window2');
model.result('pg3').set('windowtitle', 'Probe Plot 2');
model.result('pg3').run;
model.result('pg3').label('Outlet Temperature');
model.result('pg3').set('window', 'window2');
model.result('pg3').set('windowtitle', 'Probe Plot 2');
model.result('pg3').run;
model.result('pg4').set('window', 'window3');
model.result('pg4').set('windowtitle', 'Probe Plot 3');
model.result('pg4').run;
model.result('pg4').label('Heat Production');
model.result('pg4').set('ylabelactive', true);
model.result('pg4').set('ylabel', 'Heat Production (kWh)');
model.result('pg4').set('window', 'window3');
model.result('pg4').set('windowtitle', 'Probe Plot 3');
model.result('pg4').run;
model.result('pg5').set('window', 'window4');
model.result('pg5').set('windowtitle', 'Probe Plot 4');
model.result('pg5').run;
model.result('pg5').label('Heater State');
model.result('pg5').set('ylabelactive', true);
model.result('pg5').set('ylabel', 'Heater State');
model.result('pg5').set('window', 'window4');
model.result('pg5').set('windowtitle', 'Probe Plot 4');
model.result('pg5').run;
model.result('pg7').run;

model.title('Ground Heat Recovery for Radiant Floor Heating');

model.description(['Geothermal heating is an environmentally friendly and energy efficient method to supply newer and well insulated houses with heat. To cut heating costs, there is need to investigate ways of arranging heat collectors in the subsurface.' newline  newline 'This model compares three different arrangements, embedded in the subsurface of the top soil layer in a garden using the Pipe Flow Module. Typical thermal properties of the soil layer are obtained using data import from measurements.']);

model.mesh.clearMeshes;

model.sol('sol1').clearSolutionData;
model.sol('sol2').clearSolutionData;
model.sol('sol3').clearSolutionData;
model.sol('sol4').clearSolutionData;
model.sol('sol5').clearSolutionData;

model.label('ground_heat_recovery.mph');

model.modelNode.label('Components');

out = model;
