function out = model
%
% potato_drying.m
%
% Model exported on May 26 2025, 21:29 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/Heat_Transfer_Module/Phase_Change');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 2);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.physics.create('spf', 'LaminarFlow', 'geom1');
model.physics('spf').model('comp1');
model.physics('spf').prop('AdvancedSettingProperty').set('UsePseudoTime', '1');
model.physics('spf').prop('PhysicalModelProperty').set('Compressibility', 'WeaklyCompressible');
model.physics.create('mt', 'MoistureTransportInAir', 'geom1');
model.physics('mt').model('comp1');
model.physics('mt').prop('PhysicalModelProperty').set('dz', '1[m]');
model.physics('mt').prop('ShapeProperty').set('order_relativehumidity_disc', '1');
model.physics.create('ht', 'HeatTransferInMoistAir', 'geom1');
model.physics('ht').model('comp1');

model.multiphysics.create('mf1', 'MoistureFlow', 'geom1', 2);
model.multiphysics('mf1').set('Fluid_physics', 'spf');
model.multiphysics('mf1').set('Transport_physics', 'mt');
model.multiphysics.create('ham1', 'HeatAndMoisture', 'geom1', 2);
model.multiphysics('ham1').set('Heat_physics', 'ht');
model.multiphysics('ham1').set('Moist_physics', 'mt');
model.multiphysics('ham1').selection.all;
model.multiphysics.create('nitf1', 'NonIsothermalFlow', 'geom1', 2);
model.multiphysics('nitf1').set('Fluid_physics', 'spf');
model.multiphysics('nitf1').set('Heat_physics', 'ht');

model.study.create('std1');
model.study('std1').create('time', 'Transient');
model.study('std1').feature('time').setSolveFor('/physics/spf', true);
model.study('std1').feature('time').setSolveFor('/physics/mt', true);
model.study('std1').feature('time').setSolveFor('/physics/ht', true);
model.study('std1').feature('time').setSolveFor('/multiphysics/mf1', true);
model.study('std1').feature('time').setSolveFor('/multiphysics/ham1', true);
model.study('std1').feature('time').setSolveFor('/multiphysics/nitf1', true);

% To import content from file, use:
% model.param.loadFile('FILENAME');
model.param.set('T0', '293.15[K]', 'Ambient temperature');
model.param.set('u0', '0.1[m/s]', 'Freestream velocity');
model.param.set('phi_0', '0.1', 'Ambient relative humidity');
model.param.set('phi_1', '0.985', 'Porous medium relative humidity');
model.param.set('S_il', '0.1', 'Irreductible liquid phase saturation');
model.param.set('por', '0.8', 'Porosity');
model.param.set('kappa', '1e-14[m^2]', 'Permeability');
model.param.set('k_s', '0.21[W/(m*K)]', 'Porous matrix thermal conductivity (Potato mat. prop. [Hadler et al.])');
model.param.set('cp_s', '1650[J/(kg*K)]', 'Porous matrix heat capacity (Potato mat. prop. [Hadler et al.])');
model.param.set('rho_s', '1528[kg/m^3]', 'Porous matrix density (Potato mat. prop. [Hadler et al.])');

model.func.create('pw1', 'Piecewise');
model.func('pw1').model('comp1');
model.func('pw1').label('Relative Permeability, Moist Air');
model.func('pw1').set('funcname', 'kappa_rma');
model.func('pw1').set('arg', 'S_l');
model.func('pw1').setIndex('pieces', 0, 0, 0);
model.func('pw1').setIndex('pieces', '1/1.1', 0, 1);
model.func('pw1').setIndex('pieces', '1-1.1*S_l', 0, 2);
model.func('pw1').setIndex('pieces', '1/1.1', 1, 0);
model.func('pw1').setIndex('pieces', 1, 1, 1);
model.func('pw1').setIndex('pieces', 'eps', 1, 2);
model.func.create('pw2', 'Piecewise');
model.func('pw2').model('comp1');
model.func('pw2').label('Relative Permeability, Liquid Phase');
model.func('pw2').set('funcname', 'kappa_rl');
model.func('pw2').set('arg', 'S_l');
model.func('pw2').setIndex('pieces', 0, 0, 0);
model.func('pw2').setIndex('pieces', 'S_il', 0, 1);
model.func('pw2').setIndex('pieces', 'eps', 0, 2);
model.func('pw2').setIndex('pieces', 'S_il', 1, 0);
model.func('pw2').setIndex('pieces', 1, 1, 1);
model.func('pw2').setIndex('pieces', '((S_l-S_il)/(1-S_il))^3', 1, 2);
model.func.create('int1', 'Interpolation');
model.func('int1').model('comp1');
model.func('int1').label('Sorption Isotherm');
model.func('int1').set('funcname', 'wc_int');
model.func('int1').set('table', {'0.003393653' '12';  ...
'0.029277859' '16';  ...
'0.087160155' '20';  ...
'0.164632661' '24';  ...
'0.247214032' '28';  ...
'0.326229692' '32';  ...
'0.397902657' '36';  ...
'0.461214875' '40';  ...
'0.516448722' '44';  ...
'0.564402552' '48';  ...
'0.606011795' '52';  ...
'0.642181463' '56';  ...
'0.673721743' '60';  ...
'0.701331381' '64';  ...
'0.725601769' '68';  ...
'0.747028867' '72';  ...
'0.766027058' '76';  ...
'0.782942386' '80';  ...
'0.798064241' '84';  ...
'0.811635275' '88';  ...
'0.823859627' '92';  ...
'0.834909687' '96';  ...
'0.844931611' '100';  ...
'0.854049824' '104';  ...
'0.86237068' '108';  ...
'0.86998546' '112';  ...
'0.876972814' '116';  ...
'0.883400773' '120';  ...
'0.889328402' '124';  ...
'0.894807168' '128';  ...
'0.899882072' '132';  ...
'0.904592595' '136';  ...
'0.908973484' '140';  ...
'0.913055418' '144';  ...
'0.916865561' '148';  ...
'0.920428035' '152';  ...
'0.923764321' '156';  ...
'0.926893596' '160';  ...
'0.929833024' '164';  ...
'0.932598007' '168';  ...
'0.935202394' '172';  ...
'0.937658669' '176';  ...
'0.939978109' '180';  ...
'0.94217092' '184';  ...
'0.944246362' '188';  ...
'0.946212848' '192';  ...
'0.948078037' '196';  ...
'0.949848916' '200';  ...
'0.951531869' '204';  ...
'0.953132737' '208';  ...
'0.954656877' '212';  ...
'0.956109204' '216';  ...
'0.957494241' '220';  ...
'0.958816152' '224';  ...
'0.960078774' '228';  ...
'0.961285656' '232';  ...
'0.962440074' '236';  ...
'0.963545065' '240';  ...
'0.964603443' '244';  ...
'0.965617819' '248';  ...
'0.966590623' '252';  ...
'0.96752411' '256';  ...
'0.968420386' '260';  ...
'0.969281411' '264';  ...
'0.970109016' '268';  ...
'0.970904911' '272';  ...
'0.971670696' '276';  ...
'0.972407867' '280';  ...
'0.97311783' '284';  ...
'0.973801899' '288';  ...
'0.974461311' '292';  ...
'0.975097226' '296';  ...
'0.975710738' '300';  ...
'0.976302872' '304';  ...
'0.976874598' '308';  ...
'0.977426827' '312';  ...
'0.977960422' '316';  ...
'0.978476194' '320';  ...
'0.978974912' '324';  ...
'0.979457303' '328';  ...
'0.979924053' '332';  ...
'0.980375814' '336';  ...
'0.980813201' '340';  ...
'0.981236799' '344';  ...
'0.981647164' '348';  ...
'0.982044821' '352';  ...
'0.982430271' '356';  ...
'0.982803988' '360';  ...
'0.983166426' '364';  ...
'0.983518014' '368';  ...
'0.983859162' '372';  ...
'0.984190261' '376';  ...
'0.984511682' '380';  ...
'0.98482378' '384';  ...
'0.985126893' '388';  ...
'0.985421346' '392';  ...
'0.985707445' '396';  ...
'0.985985488' '400';  ...
'' '';  ...
'' '';  ...
'' '';  ...
'' '';  ...
'' '';  ...
'' '';  ...
'' '';  ...
'' '';  ...
'' ''});
model.func('int1').setIndex('argunit', 1, 0);
model.func('int1').setIndex('fununit', 'kg/m^3', 0);

model.geom('geom1').create('r1', 'Rectangle');
model.geom('geom1').feature('r1').set('size', [0.15 0.05]);
model.geom('geom1').run('r1');
model.geom('geom1').create('r2', 'Rectangle');
model.geom('geom1').feature('r2').set('size', [0.04 0.005]);
model.geom('geom1').feature('r2').set('pos', [0.04 0]);
model.geom('geom1').run('r2');
model.geom('geom1').create('fil1', 'Fillet');
model.geom('geom1').feature('fil1').selection('pointinsketch').set('r2', [3 4]);
model.geom('geom1').feature('fil1').set('radius', '2e-3');
model.geom('geom1').run('fin');

model.common.create('ampr1', 'AmbientProperties', 'comp1');
model.common('ampr1').set('T_amb', 'T0');
model.common('ampr1').set('phi_amb', 'phi_0');

model.physics('ht').feature('init1').set('Tinit_src', 'root.comp1.ampr1.T_amb');
model.physics('ht').create('mporous1', 'MoistPorousMediumHeatTransferModel', 2);
model.physics('ht').feature('mporous1').selection.set([2]);
model.physics('ht').feature('mporous1').feature('pm1').set('porousMatrixPropertiesType', 'solidPhaseProperties');
model.physics('ht').create('ifl1', 'Inflow', 1);
model.physics('ht').feature('ifl1').selection.set([1]);
model.physics('ht').feature('ifl1').set('Tustr_src', 'root.comp1.ampr1.T_amb');
model.physics('ht').create('ofl1', 'ConvectiveOutflow', 1);
model.physics('ht').feature('ofl1').selection.set([9]);
model.physics('spf').prop('PhysicalModelProperty').set('Compressibility', 'CompressibleMALT03');
model.physics('spf').prop('PhysicalModelProperty').set('EnablePorousMediaDomains', true);
model.physics('spf').create('porous1', 'PorousMedium', 2);
model.physics('spf').feature('porous1').selection.set([2]);
model.physics('spf').feature('porous1').feature('pm1').set('epsilon_p_mat', 'userdef');
model.physics('spf').feature('porous1').feature('pm1').set('epsilon_p', 'por*(1-mt.sl)');
model.physics('spf').feature('porous1').feature('pm1').set('kappa_mat', 'userdef');
model.physics('spf').feature('porous1').feature('pm1').set('kappa', {'kappa_rma(mt.sl)*kappa' '0' '0' '0' 'kappa_rma(mt.sl)*kappa' '0' '0' '0' 'kappa_rma(mt.sl)*kappa'});
model.physics('spf').create('inl1', 'InletBoundary', 1);
model.physics('spf').feature('inl1').selection.set([1]);
model.physics('spf').feature('inl1').set('BoundaryCondition', 'FullyDevelopedFlow');
model.physics('spf').feature('inl1').set('Uavfdf', 'u0');
model.physics('spf').create('out1', 'OutletBoundary', 1);
model.physics('spf').feature('out1').selection.set([9]);
model.physics('mt').feature('init1').set('phi_init_src', 'root.comp1.ampr1.phi_amb');
model.physics('mt').create('hporous1', 'HygroscopicPorousMediumModel', 2);
model.physics('mt').feature('hporous1').selection.set([2]);
model.physics('mt').feature('hporous1').set('capillaryConductionModel', 'diffusion');
model.physics('mt').feature('hporous1').feature('lw1').set('kappa_rl', 'kappa_rl(mt.sl)');
model.physics('mt').create('init2', 'InitialValues', 2);
model.physics('mt').feature('init2').selection.set([2]);
model.physics('mt').feature('init2').set('phi_init', 'phi_1');
model.physics('mt').create('ifl1', 'Inflow', 1);
model.physics('mt').feature('ifl1').selection.set([1]);
model.physics('mt').feature('ifl1').set('Tustr_src', 'root.comp1.ampr1.T_amb');
model.physics('mt').feature('ifl1').set('phiustr_src', 'root.comp1.ampr1.phi_amb');
model.physics('mt').create('ofl1', 'Outflow', 1);
model.physics('mt').feature('ofl1').selection.set([9]);

model.material.create('pmat1', 'PorousMedia', 'comp1');
model.material('pmat1').label('Potato');
model.material('pmat1').selection.set([2]);
model.material('pmat1').feature.create('solid1', 'Solid', 'comp1');
model.material('pmat1').feature('solid1').set('vfrac', '1-por');
model.material('pmat1').feature('solid1').propertyGroup('def').set('density', {'rho_s'});
model.material('pmat1').feature('solid1').propertyGroup('def').set('thermalconductivity', {'k_s'});
model.material('pmat1').feature('solid1').propertyGroup('def').set('heatcapacity', {'cp_s'});
model.material('pmat1').propertyGroup('def').set('diffusion', {'1e-8[m^2/s]*exp(-2.8+2*w_c/rho_s/(1-por))'});
model.material('pmat1').propertyGroup('def').set('watercontent', {'wc_int(phi)'});
model.material('pmat1').propertyGroup('def').set('hydraulicpermeability', {'kappa'});
model.material('pmat1').propertyGroup('def').addInput('relativehumidity');

model.cpl.create('intop1', 'Integration', 'geom1');
model.cpl('intop1').set('axisym', true);
model.cpl('intop1').selection.set([2]);
model.cpl('intop1').label('Integration Porous Medium');
model.cpl('intop1').set('opname', 'intopPorous');

model.mesh('mesh1').autoMeshSize(2);
model.mesh('mesh1').run;

model.study('std1').create('stat', 'Stationary');
model.study('std1').feature.move('stat', 0);
model.study('std1').feature('stat').setEntry('activate', 'mt', false);
model.study('std1').feature('stat').setEntry('activate', 'ht', false);
model.study('std1').feature('time').set('tlist', 'range(0,10,90) range(100,100,900) range(1000,1000,40000)');
model.study('std1').feature('time').set('usertol', true);
model.study('std1').feature('time').set('rtol', 0.001);

model.sol.create('sol1');

model.mesh('mesh1').stat.selection.geom(2);
model.mesh('mesh1').stat.selection.set([1 2]);
model.mesh('mesh1').stat.selection.geom(2);
model.mesh('mesh1').stat.selection.set([1 2]);

model.sol('sol1').study('std1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'stat');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').set('control', 'stat');
model.sol('sol1').create('s1', 'Stationary');
model.sol('sol1').feature('s1').feature('aDef').set('cachepattern', true);
model.sol('sol1').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('s1').feature('fc1').set('dtech', 'auto');
model.sol('sol1').feature('s1').feature('fc1').set('initstep', 0.01);
model.sol('sol1').feature('s1').feature('fc1').set('minstep', 1.0E-4);
model.sol('sol1').feature('s1').feature('fc1').set('maxiter', 100);
model.sol('sol1').feature('s1').create('d1', 'Direct');
model.sol('sol1').feature('s1').feature('d1').set('linsolver', 'pardiso');
model.sol('sol1').feature('s1').feature('d1').set('pivotperturb', 1.0E-13);
model.sol('sol1').feature('s1').feature('d1').label('Direct, fluid flow variables (spf)');
model.sol('sol1').feature('s1').create('i1', 'Iterative');
model.sol('sol1').feature('s1').feature('i1').set('linsolver', 'gmres');
model.sol('sol1').feature('s1').feature('i1').set('prefuntype', 'left');
model.sol('sol1').feature('s1').feature('i1').set('itrestart', 50);
model.sol('sol1').feature('s1').feature('i1').set('rhob', 20);
model.sol('sol1').feature('s1').feature('i1').set('maxlinit', 1000);
model.sol('sol1').feature('s1').feature('i1').set('nlinnormuse', 'on');
model.sol('sol1').feature('s1').feature('i1').label('AMG, fluid flow variables (spf)');
model.sol('sol1').feature('s1').feature('i1').create('mg1', 'Multigrid');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').set('prefun', 'saamg');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').set('mgcycle', 'v');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').set('maxcoarsedof', 80000);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').set('strconn', 0.02);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').set('nullspace', 'constant');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').set('usesmooth', false);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').set('saamgcompwise', true);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').set('loweramg', true);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').set('compactaggregation', false);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('pr').create('sc1', 'SCGS');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('pr').feature('sc1').set('linesweeptype', 'ssor');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('pr').feature('sc1').set('iter', 0);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('pr').feature('sc1').set('scgsrelax', 0.7);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('pr').feature('sc1').set('scgsmethod', 'lines');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('pr').feature('sc1').set('scgsvertexrelax', 0.7);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('pr').feature('sc1').set('relax', 0.5);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('pr').feature('sc1').set('vankavarsactive', 'on');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('pr').feature('sc1').set('vankavars', {'comp1_spf_inl1_Pinlfdf'});
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('pr').feature('sc1').set('scgssolv', 'stored');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('pr').feature('sc1').set('approxscgs', true);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('pr').feature('sc1').set('scgsdirectmaxsize', 1000);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('po').create('sc1', 'SCGS');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('po').feature('sc1').set('linesweeptype', 'ssor');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('po').feature('sc1').set('iter', 1);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('po').feature('sc1').set('scgsrelax', 0.7);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('po').feature('sc1').set('scgsmethod', 'lines');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('po').feature('sc1').set('scgsvertexrelax', 0.7);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('po').feature('sc1').set('relax', 0.5);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('po').feature('sc1').set('vankavarsactive', 'on');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('po').feature('sc1').set('vankavars', {'comp1_spf_inl1_Pinlfdf'});
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('po').feature('sc1').set('scgssolv', 'stored');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('po').feature('sc1').set('approxscgs', true);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('po').feature('sc1').set('scgsdirectmaxsize', 1000);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('cs').create('d1', 'Direct');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('cs').feature('d1').set('linsolver', 'pardiso');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('cs').feature('d1').set('pivotperturb', 1.0E-13);
model.sol('sol1').feature('s1').feature('fc1').set('linsolver', 'd1');
model.sol('sol1').feature('s1').feature('fc1').set('dtech', 'auto');
model.sol('sol1').feature('s1').feature('fc1').set('initstep', 0.01);
model.sol('sol1').feature('s1').feature('fc1').set('minstep', 1.0E-4);
model.sol('sol1').feature('s1').feature('fc1').set('maxiter', 100);
model.sol('sol1').feature('s1').feature.remove('fcDef');
model.sol('sol1').create('su1', 'StoreSolution');
model.sol('sol1').create('st2', 'StudyStep');
model.sol('sol1').feature('st2').set('study', 'std1');
model.sol('sol1').feature('st2').set('studystep', 'time');
model.sol('sol1').create('v2', 'Variables');
model.sol('sol1').feature('v2').feature('comp1_mt_phi').set('scalemethod', 'manual');
model.sol('sol1').feature('v2').set('initmethod', 'sol');
model.sol('sol1').feature('v2').set('initsol', 'sol1');
model.sol('sol1').feature('v2').set('initsoluse', 'sol2');
model.sol('sol1').feature('v2').set('notsolmethod', 'sol');
model.sol('sol1').feature('v2').set('notsol', 'sol1');
model.sol('sol1').feature('v2').set('notsoluse', 'sol2');
model.sol('sol1').feature('v2').set('control', 'time');
model.sol('sol1').create('t1', 'Time');
model.sol('sol1').feature('t1').set('tlist', 'range(0,10,90) range(100,100,900) range(1000,1000,40000)');
model.sol('sol1').feature('t1').set('plot', 'off');
model.sol('sol1').feature('t1').set('plotgroup', 'Default');
model.sol('sol1').feature('t1').set('plotfreq', 'tout');
model.sol('sol1').feature('t1').set('probesel', 'all');
model.sol('sol1').feature('t1').set('probes', {});
model.sol('sol1').feature('t1').set('probefreq', 'tsteps');
model.sol('sol1').feature('t1').set('rtol', 0.001);
model.sol('sol1').feature('t1').set('atolglobalvaluemethod', 'factor');
model.sol('sol1').feature('t1').set('atolmethod', {'comp1_mt_phi' 'global' 'comp1_nitf1_Uave' 'global' 'comp1_p' 'scaled' 'comp1_T' 'global' 'comp1_u' 'global'  ...
'comp1_spf_inl1_Pinlfdf' 'global'});
model.sol('sol1').feature('t1').set('atol', {'comp1_mt_phi' '1e-3' 'comp1_nitf1_Uave' '1e-3' 'comp1_p' '1e-3' 'comp1_T' '1e-3' 'comp1_u' '1e-3'  ...
'comp1_spf_inl1_Pinlfdf' '1e-3'});
model.sol('sol1').feature('t1').set('atolvaluemethod', {'comp1_mt_phi' 'factor' 'comp1_nitf1_Uave' 'factor' 'comp1_p' 'factor' 'comp1_T' 'factor' 'comp1_u' 'factor'  ...
'comp1_spf_inl1_Pinlfdf' 'factor'});
model.sol('sol1').feature('t1').set('atolfactor', {'comp1_mt_phi' '0.1' 'comp1_nitf1_Uave' '0.1' 'comp1_p' '1' 'comp1_T' '0.1' 'comp1_u' '0.1'  ...
'comp1_spf_inl1_Pinlfdf' '0.1'});
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
model.sol('sol1').feature('t1').create('se1', 'Segregated');
model.sol('sol1').feature('t1').feature('se1').feature.remove('ssDef');
model.sol('sol1').feature('t1').feature('se1').create('ss1', 'SegregatedStep');
model.sol('sol1').feature('t1').feature('se1').feature('ss1').set('segvar', {'comp1_u' 'comp1_p' 'comp1_spf_inl1_Pinlfdf'});
model.sol('sol1').feature('t1').feature('se1').feature('ss1').set('subdamp', 0.8);
model.sol('sol1').feature('t1').feature('se1').feature('ss1').set('subjtech', 'once');
model.sol('sol1').feature('t1').create('d1', 'Direct');
model.sol('sol1').feature('t1').feature('d1').set('linsolver', 'pardiso');
model.sol('sol1').feature('t1').feature('d1').set('pivotperturb', 1.0E-13);
model.sol('sol1').feature('t1').feature('d1').label('Direct, fluid flow variables (spf)');
model.sol('sol1').feature('t1').feature('se1').feature('ss1').set('linsolver', 'd1');
model.sol('sol1').feature('t1').feature('se1').feature('ss1').label('Velocity u, Pressure p');
model.sol('sol1').feature('t1').feature('se1').create('ss2', 'SegregatedStep');
model.sol('sol1').feature('t1').feature('se1').feature('ss2').set('segvar', {'comp1_mt_phi'});
model.sol('sol1').feature('t1').feature('se1').feature('ss2').set('subdtech', 'const');
model.sol('sol1').feature('t1').feature('se1').feature('ss2').set('subdamp', 0.7);
model.sol('sol1').feature('t1').feature('se1').feature('ss2').set('subjtech', 'onfirst');
model.sol('sol1').feature('t1').feature('se1').feature('ss2').set('subiter', 2);
model.sol('sol1').feature('t1').create('d2', 'Direct');
model.sol('sol1').feature('t1').feature('d2').set('linsolver', 'pardiso');
model.sol('sol1').feature('t1').feature('d2').set('pivotperturb', 1.0E-13);
model.sol('sol1').feature('t1').feature('d2').label('Direct, moisture transport variables (mt)');
model.sol('sol1').feature('t1').feature('se1').feature('ss2').set('linsolver', 'd2');
model.sol('sol1').feature('t1').feature('se1').feature('ss2').label('Relative Humidity');
model.sol('sol1').feature('t1').feature('se1').create('ss3', 'SegregatedStep');
model.sol('sol1').feature('t1').feature('se1').feature('ss3').set('segvar', {'comp1_T'});
model.sol('sol1').feature('t1').feature('se1').feature('ss3').set('subdamp', 0.8);
model.sol('sol1').feature('t1').feature('se1').feature('ss3').set('subjtech', 'once');
model.sol('sol1').feature('t1').create('d3', 'Direct');
model.sol('sol1').feature('t1').feature('d3').set('linsolver', 'pardiso');
model.sol('sol1').feature('t1').feature('d3').set('pivotperturb', 1.0E-13);
model.sol('sol1').feature('t1').feature('d3').label('Direct, heat transfer variables (ht)');
model.sol('sol1').feature('t1').feature('se1').feature('ss3').set('linsolver', 'd3');
model.sol('sol1').feature('t1').feature('se1').feature('ss3').label('Temperature');
model.sol('sol1').feature('t1').feature('se1').set('ntolfact', 0.01);
model.sol('sol1').feature('t1').feature('se1').set('segstabacc', 'segaacc');
model.sol('sol1').feature('t1').feature('se1').set('segaaccdim', 5);
model.sol('sol1').feature('t1').feature('se1').set('segaaccmix', 0.9);
model.sol('sol1').feature('t1').feature('se1').set('segaaccdelay', 1);
model.sol('sol1').feature('t1').feature('se1').set('maxsegiter', 10);
model.sol('sol1').feature('t1').feature('se1').create('ll1', 'LowerLimit');
model.sol('sol1').feature('t1').feature('se1').feature('ll1').set('lowerlimit', 'comp1.T 0 ');
model.sol('sol1').feature('t1').create('i1', 'Iterative');
model.sol('sol1').feature('t1').feature('i1').set('linsolver', 'gmres');
model.sol('sol1').feature('t1').feature('i1').set('prefuntype', 'left');
model.sol('sol1').feature('t1').feature('i1').set('itrestart', 50);
model.sol('sol1').feature('t1').feature('i1').set('rhob', 20);
model.sol('sol1').feature('t1').feature('i1').set('maxlinit', 100);
model.sol('sol1').feature('t1').feature('i1').set('nlinnormuse', 'on');
model.sol('sol1').feature('t1').feature('i1').label('AMG, fluid flow variables (spf)');
model.sol('sol1').feature('t1').feature('i1').create('mg1', 'Multigrid');
model.sol('sol1').feature('t1').feature('i1').feature('mg1').set('prefun', 'saamg');
model.sol('sol1').feature('t1').feature('i1').feature('mg1').set('mgcycle', 'v');
model.sol('sol1').feature('t1').feature('i1').feature('mg1').set('maxcoarsedof', 80000);
model.sol('sol1').feature('t1').feature('i1').feature('mg1').set('strconn', 0.02);
model.sol('sol1').feature('t1').feature('i1').feature('mg1').set('nullspace', 'constant');
model.sol('sol1').feature('t1').feature('i1').feature('mg1').set('usesmooth', false);
model.sol('sol1').feature('t1').feature('i1').feature('mg1').set('saamgcompwise', true);
model.sol('sol1').feature('t1').feature('i1').feature('mg1').set('loweramg', true);
model.sol('sol1').feature('t1').feature('i1').feature('mg1').set('compactaggregation', false);
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('pr').create('sc1', 'SCGS');
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('pr').feature('sc1').set('linesweeptype', 'ssor');
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('pr').feature('sc1').set('iter', 0);
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('pr').feature('sc1').set('scgsrelax', 0.7);
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('pr').feature('sc1').set('scgsmethod', 'lines');
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('pr').feature('sc1').set('scgsvertexrelax', 0.7);
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('pr').feature('sc1').set('relax', 0.5);
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('pr').feature('sc1').set('vankavarsactive', 'on');
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('pr').feature('sc1').set('vankavars', {'comp1_spf_inl1_Pinlfdf'});
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('pr').feature('sc1').set('scgssolv', 'stored');
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('pr').feature('sc1').set('approxscgs', true);
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('pr').feature('sc1').set('scgsdirectmaxsize', 1000);
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('po').create('sc1', 'SCGS');
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('po').feature('sc1').set('linesweeptype', 'ssor');
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('po').feature('sc1').set('iter', 1);
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('po').feature('sc1').set('scgsrelax', 0.7);
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('po').feature('sc1').set('scgsmethod', 'lines');
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('po').feature('sc1').set('scgsvertexrelax', 0.7);
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('po').feature('sc1').set('relax', 0.5);
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('po').feature('sc1').set('vankavarsactive', 'on');
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('po').feature('sc1').set('vankavars', {'comp1_spf_inl1_Pinlfdf'});
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('po').feature('sc1').set('scgssolv', 'stored');
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('po').feature('sc1').set('approxscgs', true);
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('po').feature('sc1').set('scgsdirectmaxsize', 1000);
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('cs').create('d1', 'Direct');
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('cs').feature('d1').set('linsolver', 'pardiso');
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('cs').feature('d1').set('pivotperturb', 1.0E-13);
model.sol('sol1').feature('t1').create('i2', 'Iterative');
model.sol('sol1').feature('t1').feature('i2').set('linsolver', 'gmres');
model.sol('sol1').feature('t1').feature('i2').set('prefuntype', 'left');
model.sol('sol1').feature('t1').feature('i2').set('itrestart', 50);
model.sol('sol1').feature('t1').feature('i2').set('rhob', 400);
model.sol('sol1').feature('t1').feature('i2').set('maxlinit', 10000);
model.sol('sol1').feature('t1').feature('i2').set('nlinnormuse', 'on');
model.sol('sol1').feature('t1').feature('i2').label('AMG, moisture transport variables (mt)');
model.sol('sol1').feature('t1').feature('i2').create('mg1', 'Multigrid');
model.sol('sol1').feature('t1').feature('i2').feature('mg1').set('prefun', 'saamg');
model.sol('sol1').feature('t1').feature('i2').feature('mg1').set('mgcycle', 'v');
model.sol('sol1').feature('t1').feature('i2').feature('mg1').set('maxcoarsedof', 50000);
model.sol('sol1').feature('t1').feature('i2').feature('mg1').set('strconn', 0.01);
model.sol('sol1').feature('t1').feature('i2').feature('mg1').set('nullspace', 'constant');
model.sol('sol1').feature('t1').feature('i2').feature('mg1').set('usesmooth', false);
model.sol('sol1').feature('t1').feature('i2').feature('mg1').set('saamgcompwise', false);
model.sol('sol1').feature('t1').feature('i2').feature('mg1').set('loweramg', true);
model.sol('sol1').feature('t1').feature('i2').feature('mg1').set('compactaggregation', false);
model.sol('sol1').feature('t1').feature('i2').feature('mg1').feature('pr').create('so1', 'SOR');
model.sol('sol1').feature('t1').feature('i2').feature('mg1').feature('pr').feature('so1').set('iter', 2);
model.sol('sol1').feature('t1').feature('i2').feature('mg1').feature('pr').feature('so1').set('relax', 0.9);
model.sol('sol1').feature('t1').feature('i2').feature('mg1').feature('po').create('so1', 'SOR');
model.sol('sol1').feature('t1').feature('i2').feature('mg1').feature('po').feature('so1').set('iter', 2);
model.sol('sol1').feature('t1').feature('i2').feature('mg1').feature('po').feature('so1').set('relax', 0.9);
model.sol('sol1').feature('t1').feature('i2').feature('mg1').feature('cs').create('d1', 'Direct');
model.sol('sol1').feature('t1').feature('i2').feature('mg1').feature('cs').feature('d1').set('linsolver', 'pardiso');
model.sol('sol1').feature('t1').feature('i2').feature('mg1').feature('cs').feature('d1').set('pivotperturb', 1.0E-13);
model.sol('sol1').feature('t1').create('d4', 'Direct');
model.sol('sol1').feature('t1').feature('d4').label('Direct (Merged)');
model.sol('sol1').feature('t1').create('i3', 'Iterative');
model.sol('sol1').feature('t1').feature('i3').set('linsolver', 'gmres');
model.sol('sol1').feature('t1').feature('i3').set('prefuntype', 'left');
model.sol('sol1').feature('t1').feature('i3').set('itrestart', 50);
model.sol('sol1').feature('t1').feature('i3').set('rhob', 20);
model.sol('sol1').feature('t1').feature('i3').set('maxlinit', 10000);
model.sol('sol1').feature('t1').feature('i3').set('nlinnormuse', 'on');
model.sol('sol1').feature('t1').feature('i3').label('AMG, heat transfer variables (ht)');
model.sol('sol1').feature('t1').feature('i3').create('mg1', 'Multigrid');
model.sol('sol1').feature('t1').feature('i3').feature('mg1').set('prefun', 'saamg');
model.sol('sol1').feature('t1').feature('i3').feature('mg1').set('mgcycle', 'v');
model.sol('sol1').feature('t1').feature('i3').feature('mg1').set('maxcoarsedof', 50000);
model.sol('sol1').feature('t1').feature('i3').feature('mg1').set('strconn', 0.01);
model.sol('sol1').feature('t1').feature('i3').feature('mg1').set('nullspace', 'constant');
model.sol('sol1').feature('t1').feature('i3').feature('mg1').set('usesmooth', false);
model.sol('sol1').feature('t1').feature('i3').feature('mg1').set('saamgcompwise', true);
model.sol('sol1').feature('t1').feature('i3').feature('mg1').set('loweramg', true);
model.sol('sol1').feature('t1').feature('i3').feature('mg1').set('compactaggregation', false);
model.sol('sol1').feature('t1').feature('i3').feature('mg1').feature('pr').create('so1', 'SOR');
model.sol('sol1').feature('t1').feature('i3').feature('mg1').feature('pr').feature('so1').set('iter', 2);
model.sol('sol1').feature('t1').feature('i3').feature('mg1').feature('pr').feature('so1').set('relax', 0.9);
model.sol('sol1').feature('t1').feature('i3').feature('mg1').feature('po').create('so1', 'SOR');
model.sol('sol1').feature('t1').feature('i3').feature('mg1').feature('po').feature('so1').set('iter', 2);
model.sol('sol1').feature('t1').feature('i3').feature('mg1').feature('po').feature('so1').set('relax', 0.9);
model.sol('sol1').feature('t1').feature('i3').feature('mg1').feature('cs').create('d1', 'Direct');
model.sol('sol1').feature('t1').feature('i3').feature('mg1').feature('cs').feature('d1').set('linsolver', 'pardiso');
model.sol('sol1').feature('t1').feature('i3').feature('mg1').feature('cs').feature('d1').set('pivotperturb', 1.0E-13);
model.sol('sol1').feature('t1').feature.remove('fcDef');
model.sol('sol1').feature('t1').feature.remove('seDef');
model.sol('sol1').attach('std1');
model.sol('sol1').runAll;

model.result.dataset('dset1').set('geom', 'geom1');
model.result.create('pg1', 'PlotGroup2D');
model.result('pg1').label('Velocity (spf)');
model.result('pg1').set('frametype', 'spatial');
model.result('pg1').set('data', 'dset1');
model.result('pg1').setIndex('looplevel', 59, 0);
model.result('pg1').set('defaultPlotID', 'ResultDefaults_SinglePhaseFlow/icom1/pdef1/pcond1/pg1');
model.result('pg1').feature.create('surf1', 'Surface');
model.result('pg1').feature('surf1').label('Surface');
model.result('pg1').feature('surf1').set('showsolutionparams', 'on');
model.result('pg1').feature('surf1').set('smooth', 'internal');
model.result('pg1').feature('surf1').set('showsolutionparams', 'on');
model.result('pg1').feature('surf1').set('data', 'parent');
model.result.create('pg2', 'PlotGroup2D');
model.result('pg2').label('Pressure (spf)');
model.result('pg2').set('frametype', 'spatial');
model.result('pg2').set('data', 'dset1');
model.result('pg2').setIndex('looplevel', 59, 0);
model.result('pg2').set('defaultPlotID', 'ResultDefaults_SinglePhaseFlow/icom1/pdef1/pcond1/pg2');
model.result('pg2').feature.create('con1', 'Contour');
model.result('pg2').feature('con1').label('Contour');
model.result('pg2').feature('con1').set('showsolutionparams', 'on');
model.result('pg2').feature('con1').set('expr', 'p');
model.result('pg2').feature('con1').set('number', 40);
model.result('pg2').feature('con1').set('levelrounding', false);
model.result('pg2').feature('con1').set('smooth', 'internal');
model.result('pg2').feature('con1').set('showsolutionparams', 'on');
model.result('pg2').feature('con1').set('data', 'parent');
model.result.create('pg3', 'PlotGroup2D');
model.result('pg3').label('Relative Humidity (mt)');
model.result('pg3').set('data', 'dset1');
model.result('pg3').setIndex('looplevel', 59, 0);
model.result('pg3').set('defaultPlotID', 'MoistureTransportFactory/icom5/pdef1/pcond2/pg2');
model.result('pg3').feature.create('surf1', 'Surface');
model.result('pg3').feature('surf1').set('expr', 'mt.phi');
model.result('pg3').feature('surf1').set('colortable', 'JupiterAuroraBorealis');
model.result('pg3').feature('surf1').set('colortabletrans', 'reverse');
model.result('pg3').feature('surf1').set('smooth', 'internal');
model.result('pg3').feature('surf1').set('data', 'parent');
model.result.create('pg4', 'PlotGroup2D');
model.result('pg4').label('Temperature (ht)');
model.result('pg4').set('data', 'dset1');
model.result('pg4').setIndex('looplevel', 59, 0);
model.result('pg4').set('defaultPlotID', 'ht/HT_PhysicsInterfaces/icom8/pdef1/pcond2/pcond4/pg2');
model.result('pg4').feature.create('surf1', 'Surface');
model.result('pg4').feature('surf1').set('showsolutionparams', 'on');
model.result('pg4').feature('surf1').set('solutionparams', 'parent');
model.result('pg4').feature('surf1').set('expr', 'T');
model.result('pg4').feature('surf1').set('colortable', 'HeatCameraLight');
model.result('pg4').feature('surf1').set('showsolutionparams', 'on');
model.result('pg4').feature('surf1').set('data', 'parent');
model.result.create('pg5', 'PlotGroup2D');
model.result('pg5').label('Temperature and Fluid Flow (nitf1)');
model.result('pg5').set('showlegendsunit', true);
model.result('pg5').set('data', 'dset1');
model.result('pg5').setIndex('looplevel', 59, 0);
model.result('pg5').set('defaultPlotID', 'MultiphysicsNonIsothermalFlow/cfcom1/pdef1/pcond4/pcond4/pcond1/pg3');
model.result('pg5').feature.create('surf1', 'Surface');
model.result('pg5').feature('surf1').label('Fluid Temperature');
model.result('pg5').feature('surf1').set('showsolutionparams', 'on');
model.result('pg5').feature('surf1').set('solutionparams', 'parent');
model.result('pg5').feature('surf1').set('expr', 'nitf1.T');
model.result('pg5').feature('surf1').set('colortable', 'HeatCameraLight');
model.result('pg5').feature('surf1').set('smooth', 'internal');
model.result('pg5').feature('surf1').set('showsolutionparams', 'on');
model.result('pg5').feature('surf1').set('data', 'parent');
model.result('pg5').feature('surf1').feature.create('sel1', 'Selection');
model.result('pg5').feature('surf1').feature('sel1').selection.geom('geom1', 2);
model.result('pg5').feature('surf1').feature('sel1').selection.set([1 2]);
model.result('pg5').feature.create('arws1', 'ArrowSurface');
model.result('pg5').feature('arws1').label('Fluid Flow');
model.result('pg5').feature('arws1').set('showsolutionparams', 'on');
model.result('pg5').feature('arws1').set('solutionparams', 'parent');
model.result('pg5').feature('arws1').set('expr', {'nitf1.ux' 'nitf1.uy'});
model.result('pg5').feature('arws1').set('xnumber', 30);
model.result('pg5').feature('arws1').set('ynumber', 30);
model.result('pg5').feature('arws1').set('arrowtype', 'cone');
model.result('pg5').feature('arws1').set('arrowlength', 'logarithmic');
model.result('pg5').feature('arws1').set('showsolutionparams', 'on');
model.result('pg5').feature('arws1').set('data', 'parent');
model.result('pg5').feature('arws1').feature.create('col1', 'Color');
model.result('pg5').feature('arws1').feature('col1').set('showcolordata', 'off');
model.result('pg5').feature('arws1').feature.create('filt1', 'Filter');
model.result('pg5').feature('arws1').feature('filt1').set('expr', 'spf.U>nitf1.Uave');
model.result('pg1').run;
model.result('pg2').run;
model.result('pg3').run;
model.result('pg3').setIndex('looplevel', 24, 0);
model.result('pg3').run;
model.result('pg4').run;
model.result('pg4').setIndex('looplevel', 24, 0);
model.result('pg4').run;
model.result.create('pg6', 'PlotGroup2D');
model.result('pg6').label('Saturation (mt)');
model.result('pg6').set('data', 'dset1');
model.result('pg6').setIndex('looplevel', 59, 0);
model.result('pg6').set('defaultPlotID', 'MoistureTransportFactory/icom5/pdef1/pcond2/pcond2/pg3');
model.result('pg6').feature.create('surf1', 'Surface');
model.result('pg6').feature('surf1').set('solutionparams', 'parent');
model.result('pg6').feature('surf1').set('expr', 'mt.sl');
model.result('pg6').feature('surf1').set('smooth', 'internal');
model.result('pg6').feature('surf1').set('showsolutionparams', 'on');
model.result('pg6').feature('surf1').set('data', 'parent');
model.result('pg6').label('Saturation (mt)');
model.result('pg6').run;
model.result('pg6').setIndex('looplevel', 24, 0);
model.result('pg6').run;
model.result.create('pg7', 'PlotGroup1D');
model.result('pg7').run;
model.result('pg7').label('Moisture Content in Porous Medium over Time');
model.result('pg7').set('titletype', 'manual');
model.result('pg7').set('title', 'Total moisture content in the potato');
model.result('pg7').set('ylabelactive', true);
model.result('pg7').set('ylabel', 'Total moisture content in the potato (kg/m)');
model.result('pg7').create('glob1', 'Global');
model.result('pg7').feature('glob1').set('markerpos', 'datapoints');
model.result('pg7').feature('glob1').set('linewidth', 'preference');
model.result('pg7').feature('glob1').setIndex('expr', 'intopPorous(mt.wcVar)', 0);
model.result('pg7').feature('glob1').setIndex('unit', 'kg/m', 0);
model.result('pg7').feature('glob1').setIndex('descr', 'Integration Porous Medium', 0);
model.result('pg7').feature('glob1').set('linewidth', 2);
model.result('pg7').feature('glob1').set('legend', false);
model.result('pg7').run;
model.result.numerical.create('gev1', 'EvalGlobal');
model.result.numerical('gev1').label('Mass Balance');
model.result.numerical('gev1').set('expr', {'mt.massBalance'});
model.result.numerical('gev1').set('descr', {'Mass balance'});
model.result.numerical('gev1').set('unit', {'kg/s'});
model.result.numerical('gev1').set('expr', {'mt.massBalance' 'mt.dwcInt'});
model.result.numerical('gev1').set('descr', {'Mass balance' 'Total accumulated moisture rate'});
model.result.numerical('gev1').set('expr', {'mt.massBalance' 'mt.dwcInt' 'mt.ntfluxInt'});
model.result.numerical('gev1').set('descr', {'Mass balance' 'Total accumulated moisture rate' 'Total net moisture rate'});
model.result.numerical('gev1').set('expr', {'mt.massBalance' 'mt.dwcInt' 'mt.ntfluxInt' 'mt.GInt'});
model.result.numerical('gev1').set('descr', {'Mass balance' 'Total accumulated moisture rate' 'Total net moisture rate' 'Total mass source'});
model.result.table.create('tbl1', 'Table');
model.result.table('tbl1').comments('Mass Balance');
model.result.numerical('gev1').set('table', 'tbl1');
model.result.numerical('gev1').setResult;
model.result.create('pg8', 'PlotGroup1D');
model.result('pg8').set('data', 'none');
model.result('pg8').create('tblp1', 'Table');
model.result('pg8').feature('tblp1').set('source', 'table');
model.result('pg8').feature('tblp1').set('table', 'tbl1');
model.result('pg8').feature('tblp1').set('linewidth', 'preference');
model.result('pg8').feature('tblp1').set('markerpos', 'datapoints');
model.result('pg8').run;
model.result('pg8').run;
model.result('pg8').label('Mass Balance');
model.result('pg8').run;
model.result('pg8').feature('tblp1').set('legend', true);
model.result('pg8').feature('tblp1').set('linewidth', 2);
model.result('pg3').run;

model.title('Drying of a Potato Sample');

model.description('This tutorial describes a drying case with laminar airflow through an unsaturated porous medium. The air is dry at the inlet and its moisture content increases as air flows through the porous medium. The water saturation in the porous medium is computed over time. It is supposed that water leaves the potato sample only as vapor.');

model.mesh.clearMeshes;

model.sol('sol1').clearSolutionData;
model.sol('sol2').clearSolutionData;

model.label('potato_drying.mph');

model.modelNode.label('Components');

out = model;
