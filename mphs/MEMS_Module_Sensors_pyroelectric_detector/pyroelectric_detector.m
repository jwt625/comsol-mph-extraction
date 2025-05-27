function out = model
%
% pyroelectric_detector.m
%
% Model exported on May 26 2025, 21:30 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/MEMS_Module/Sensors');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 2);
model.geom('geom1').model('comp1');
model.geom('geom1').axisymmetric(true);

model.mesh.create('mesh1', 'geom1');

model.physics.create('es', 'Electrostatics', 'geom1');
model.physics('es').model('comp1');
model.physics('es').create('ccnp1', 'ChargeConservationPiezo');
model.physics('es').feature('ccnp1').selection.all;
model.physics.create('solid', 'SolidMechanics', 'geom1');
model.physics('solid').model('comp1');
model.physics('solid').create('pzm1', 'PiezoelectricMaterialModel');
model.physics('solid').feature('pzm1').selection.all;
model.physics.create('ht', 'HeatTransfer', 'geom1');
model.physics('ht').model('comp1');
model.physics.create('cir', 'Circuit', 'geom1');
model.physics('cir').model('comp1');

model.multiphysics.create('pze1', 'PiezoelectricEffect', 'geom1', 2);
model.multiphysics('pze1').set('Solid_physics', 'solid');
model.multiphysics('pze1').set('Electrostatics_physics', 'es');
model.multiphysics.create('te1', 'ThermalExpansion', 'geom1', 2);
model.multiphysics('te1').set('Heat_physics', 'ht');
model.multiphysics('te1').set('Solid_physics', 'solid');
model.multiphysics('te1').selection.all;
model.multiphysics.create('pye1', 'Pyroelectricity', 'geom1', 2);
model.multiphysics('pye1').set('Electrostatics_physics', 'es');
model.multiphysics('pye1').set('Heat_physics', 'ht');
model.multiphysics('pye1').selection.all;

model.study.create('std1');
model.study('std1').create('time', 'Transient');
model.study('std1').feature('time').setSolveFor('/physics/es', true);
model.study('std1').feature('time').setSolveFor('/physics/solid', true);
model.study('std1').feature('time').setSolveFor('/physics/ht', true);
model.study('std1').feature('time').setSolveFor('/physics/cir', true);
model.study('std1').feature('time').setSolveFor('/multiphysics/pze1', true);
model.study('std1').feature('time').setSolveFor('/multiphysics/te1', true);
model.study('std1').feature('time').setSolveFor('/multiphysics/pye1', true);

model.param.set('r_el', '1.4[mm]');
model.param.descr('r_el', 'Radius of top electrode');
model.param.set('r_s', '0.25[mm]');
model.param.descr('r_s', 'Width of standoff');
model.param.set('r_d', '1.5[mm]');
model.param.descr('r_d', 'Radius of crystal');
model.param.set('t_d', '0.025[mm]');
model.param.descr('t_d', 'Thickness of crystal');
model.param.set('t_s', '0.040[mm]');
model.param.descr('t_s', 'Thickness of standoff');
model.param.set('w_b', '2[mm]');
model.param.descr('w_b', 'Width of laser beam');
model.param.set('Qmax', '500[W/m^2]');
model.param.descr('Qmax', 'Maximum laser power density');
model.param.set('pulse', '1[s]');
model.param.descr('pulse', 'Duration of laser pulse');
model.param.set('C_ext', '100[pF]');
model.param.descr('C_ext', 'Capacitance of C1');
model.param.set('R_ext', '1000[ohm]');
model.param.descr('R_ext', 'Resistance of R1');

model.func.create('rect1', 'Rectangle');
model.func('rect1').model('comp1');
model.func('rect1').set('lower', 0.2);
model.func('rect1').set('upper', 1);
model.func.create('an1', 'Analytic');
model.func('an1').model('comp1');
model.func('an1').set('expr', 'exp(-((r^2)/(2*(10000)^2)))');
model.func('an1').set('args', 'r');
model.func('an1').setIndex('argunit', 'um', 0);

model.variable.create('var1');
model.variable('var1').model('comp1');

model.geom('geom1').run;

model.variable('var1').set('Flux', 'Qmax*an1(r)*rect1(t/pulse)');
model.variable('var1').descr('Flux', 'Power density distribution');

model.geom('geom1').lengthUnit('mm');
model.geom('geom1').create('r1', 'Rectangle');
model.geom('geom1').feature('r1').set('size', {'r_d' 't_d'});
model.geom('geom1').run('r1');
model.geom('geom1').create('r2', 'Rectangle');
model.geom('geom1').feature('r2').set('size', {'r_s' 't_s'});
model.geom('geom1').feature('r2').set('pos', {'r_d-r_s' '-t_s'});
model.geom('geom1').run('r2');
model.geom('geom1').create('r3', 'Rectangle');
model.geom('geom1').feature('r3').set('size', {'r_el' 't_d'});
model.geom('geom1').run('r3');
model.geom('geom1').run;

model.multiphysics('pye1').selection.set([1 3]);

model.material.create('mat1', 'Common', 'comp1');
model.material('mat1').propertyGroup.create('StrainCharge', 'Strain-charge form');
model.material('mat1').propertyGroup.create('StressCharge', 'Stress-charge form');
model.material('mat1').label('Lithium Niobate');
model.material('mat1').set('family', 'custom');
model.material('mat1').set('customspecular', [0.7843137254901961 1 1]);
model.material('mat1').set('customdiffuse', [0.7843137254901961 0.7843137254901961 0.7843137254901961]);
model.material('mat1').set('noise', true);
model.material('mat1').set('fresnel', 0.9);
model.material('mat1').set('roughness', 0.1);
model.material('mat1').set('metallic', 0);
model.material('mat1').set('pearl', 0);
model.material('mat1').set('diffusewrap', 0);
model.material('mat1').set('clearcoat', 0);
model.material('mat1').set('reflectance', 0);
model.material('mat1').propertyGroup('def').set('relpermittivity', {'43.6' '0' '0' '0' '43.6' '0' '0' '0' '29.16'});
model.material('mat1').propertyGroup('def').set('density', '4700[kg/m^3]');
model.material('mat1').propertyGroup('StrainCharge').set('sE', {'5.78e-012[1/Pa]' '-1.01e-012[1/Pa]' '-1.47e-012[1/Pa]' '-1.02e-012[1/Pa]' '0[1/Pa]' '0[1/Pa]' '-1.01e-012[1/Pa]' '5.78e-012[1/Pa]' '-1.47e-012[1/Pa]' '1.02e-012[1/Pa]'  ...
'0[1/Pa]' '0[1/Pa]' '-1.47e-012[1/Pa]' '-1.47e-012[1/Pa]' '5.02e-012[1/Pa]' '0[1/Pa]' '0[1/Pa]' '0[1/Pa]' '-1.02e-012[1/Pa]' '1.02e-012[1/Pa]'  ...
'0[1/Pa]' '1.7e-011[1/Pa]' '0[1/Pa]' '0[1/Pa]' '0[1/Pa]' '0[1/Pa]' '0[1/Pa]' '0[1/Pa]' '1.7e-011[1/Pa]' '-2.04e-012[1/Pa]'  ...
'0[1/Pa]' '0[1/Pa]' '0[1/Pa]' '0[1/Pa]' '-2.04e-012[1/Pa]' '1.36e-011[1/Pa]'});
model.material('mat1').propertyGroup('StrainCharge').set('dET', {'0[C/N]' '-2.1e-011[C/N]' '-1e-012[C/N]' '0[C/N]' '2.1e-011[C/N]' '-1e-012[C/N]' '0[C/N]' '0[C/N]' '6e-012[C/N]' '0[C/N]'  ...
'6.8e-011[C/N]' '0[C/N]' '6.8e-011[C/N]' '0[C/N]' '0[C/N]' '-4.2e-011[C/N]' '0[C/N]' '0[C/N]'});
model.material('mat1').propertyGroup('StrainCharge').set('epsilonrT', {'84' '0' '0' '0' '84' '0' '0' '0' '30'});
model.material('mat1').propertyGroup('StressCharge').set('cE', {'2.02897e+011[Pa]' '5.29177e+010[Pa]' '7.49098e+010[Pa]' '8.99874e+009[Pa]' '0[Pa]' '0[Pa]' '5.29177e+010[Pa]' '2.02897e+011[Pa]' '7.49098e+010[Pa]' '-8.99874e+009[Pa]'  ...
'0[Pa]' '0[Pa]' '7.49098e+010[Pa]' '7.49098e+010[Pa]' '2.43075e+011[Pa]' '0[Pa]' '0[Pa]' '0[Pa]' '8.99874e+009[Pa]' '-8.99874e+009[Pa]'  ...
'0[Pa]' '5.99034e+010[Pa]' '0[Pa]' '0[Pa]' '0[Pa]' '0[Pa]' '0[Pa]' '0[Pa]' '5.99018e+010[Pa]' '8.98526e+009[Pa]'  ...
'0[Pa]' '0[Pa]' '0[Pa]' '0[Pa]' '8.98526e+009[Pa]' '7.48772e+010[Pa]'});
model.material('mat1').propertyGroup('StressCharge').set('eES', {'0[C/m^2]' '-2.53764[C/m^2]' '0.193644[C/m^2]' '0[C/m^2]' '2.53764[C/m^2]' '0.193644[C/m^2]' '0[C/m^2]' '0[C/m^2]' '1.30863[C/m^2]' '0[C/m^2]'  ...
'3.69548[C/m^2]' '0[C/m^2]' '3.69594[C/m^2]' '0[C/m^2]' '0[C/m^2]' '-2.53384[C/m^2]' '0[C/m^2]' '0[C/m^2]'});
model.material('mat1').propertyGroup('StressCharge').set('epsilonrS', {'43.6' '0' '0' '0' '43.6' '0' '0' '0' '29.16'});
model.material('mat1').propertyGroup('def').set('thermalconductivity', {'4.2'});
model.material('mat1').propertyGroup('def').set('heatcapacity', {'628'});
model.material('mat1').propertyGroup('def').set('thermalexpansioncoefficient', {'6.5e-6' '6.5e-6' '14.8e-6'});
model.material('mat1').propertyGroup.create('Pyroelectric', 'Pyroelectric');
model.material('mat1').propertyGroup('Pyroelectric').set('pET', {'0' '0' '-8.3e-5'});

model.physics('es').feature('ccnp1').selection.set([1 3]);
model.physics('es').create('gnd1', 'Ground', 1);
model.physics('es').feature('gnd1').selection.set([2 6 8]);
model.physics('es').create('term1', 'Terminal', 1);
model.physics('es').feature('term1').selection.set([3]);
model.physics('es').feature('term1').set('TerminalType', 'Circuit');
model.physics('es').feature('ccn1').setIndex('materialType', 'solid', 0);
model.physics('solid').feature('pzm1').selection.set([1 3]);
model.physics('solid').create('fix1', 'Fixed', 1);
model.physics('solid').feature('fix1').selection.set([5]);
model.physics('ht').create('hf1', 'HeatFluxBoundary', 1);
model.physics('ht').feature('hf1').setIndex('materialType', 'solid', 0);
model.physics('ht').feature('hf1').set('q0_input', 'Flux');
model.physics('ht').feature('hf1').selection.set([3 9]);
model.physics('ht').create('temp1', 'TemperatureBoundary', 1);
model.physics('ht').feature('temp1').selection.set([5]);
model.physics('cir').create('R1', 'Resistor', -1);
model.physics('cir').feature('R1').setIndex('Connections', 0, 1, 0);
model.physics('cir').feature('R1').set('R', 'R_ext');
model.physics('cir').create('C1', 'Capacitor', -1);
model.physics('cir').feature('C1').setIndex('Connections', 1, 0, 0);
model.physics('cir').feature('C1').setIndex('Connections', 0, 1, 0);
model.physics('cir').feature('C1').set('C', 'C_ext');
model.physics('cir').create('termI1', 'ModelTerminalIV', -1);
model.physics('cir').feature('termI1').set('Connections', 1);
model.physics('cir').feature('termI1').set('V_src', 'root.comp1.es.V0_1');

model.material.create('mat2', 'Common', 'comp1');
model.material('mat2').propertyGroup.create('Enu', 'Young''s modulus and Poisson''s ratio');
model.material('mat2').label('Ag - Silver');
model.material('mat2').set('family', 'custom');
model.material('mat2').set('customspecular', [0.7843137254901961 1 1]);
model.material('mat2').set('customdiffuse', [0.7843137254901961 0.7843137254901961 0.7843137254901961]);
model.material('mat2').set('noise', true);
model.material('mat2').set('fresnel', 0.9);
model.material('mat2').set('roughness', 0.1);
model.material('mat2').set('metallic', 0);
model.material('mat2').set('pearl', 0);
model.material('mat2').set('diffusewrap', 0);
model.material('mat2').set('clearcoat', 0);
model.material('mat2').set('reflectance', 0);
model.material('mat2').propertyGroup('def').set('electricconductivity', {'61.6e6[S/m]' '0' '0' '0' '61.6e6[S/m]' '0' '0' '0' '61.6e6[S/m]'});
model.material('mat2').propertyGroup('def').set('thermalexpansioncoefficient', {'18.9e-6[1/K]' '0' '0' '0' '18.9e-6[1/K]' '0' '0' '0' '18.9e-6[1/K]'});
model.material('mat2').propertyGroup('def').set('heatcapacity', '235[J/(kg*K)]');
model.material('mat2').propertyGroup('def').set('density', '10500[kg/m^3]');
model.material('mat2').propertyGroup('def').set('thermalconductivity', {'429[W/(m*K)]' '0' '0' '0' '429[W/(m*K)]' '0' '0' '0' '429[W/(m*K)]'});
model.material('mat2').propertyGroup('Enu').set('E', '83e9[Pa]');
model.material('mat2').propertyGroup('Enu').set('nu', '0.37');
model.material('mat2').selection.set([2]);
model.material('mat2').propertyGroup('def').set('relpermittivity', {'1'});

model.mesh('mesh1').create('ftri1', 'FreeTri');
model.mesh('mesh1').feature('ftri1').create('size1', 'Size');
model.mesh('mesh1').feature('ftri1').feature('size1').set('hauto', 1);
model.mesh('mesh1').run('ftri1');

model.study('std1').feature('time').set('tlist', 'range(0,0.02,2)');
model.study('std1').feature('time').label('Time Dependent, Full Model');
model.study('std1').feature('time').set('useparam', true);
model.study('std1').feature('time').setIndex('pname', 'r_el', 0);
model.study('std1').feature('time').setIndex('plistarr', '', 0);
model.study('std1').feature('time').setIndex('punit', 'm', 0);
model.study('std1').feature('time').setIndex('pname', 'r_el', 0);
model.study('std1').feature('time').setIndex('plistarr', '', 0);
model.study('std1').feature('time').setIndex('punit', 'm', 0);
model.study('std1').feature('time').setIndex('pname', 'R_ext', 0);
model.study('std1').feature('time').setIndex('plistarr', '0.1 5e6 5e7 1e9', 0);
model.study('std1').setGenPlots(false);

model.sol.create('sol1');
model.sol('sol1').study('std1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'time');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').feature('comp1_u').set('scalemethod', 'manual');
model.sol('sol1').feature('v1').feature('comp1_u').set('scaleval', '1e-2*0.0015014076728190784');
model.sol('sol1').feature('v1').set('control', 'time');
model.sol('sol1').create('t1', 'Time');
model.sol('sol1').feature('t1').set('tlist', 'range(0,0.02,2)');
model.sol('sol1').feature('t1').set('plot', 'off');
model.sol('sol1').feature('t1').set('plotgroup', 'Default');
model.sol('sol1').feature('t1').set('plotfreq', 'tout');
model.sol('sol1').feature('t1').set('probesel', 'all');
model.sol('sol1').feature('t1').set('probes', {});
model.sol('sol1').feature('t1').set('probefreq', 'tsteps');
model.sol('sol1').feature('t1').set('rtol', 0.001);
model.sol('sol1').feature('t1').set('atolglobalvaluemethod', 'factor');
model.sol('sol1').feature('t1').set('atolmethod', {'comp1_T' 'global' 'comp1_u' 'global' 'comp1_V' 'global' 'comp1_es_term1_V0_ode' 'global' 'comp1_es_term1_Q0_ode' 'global'  ...
'comp1_currents' 'global' 'comp1_voltages' 'global'});
model.sol('sol1').feature('t1').set('atol', {'comp1_T' '1e-3' 'comp1_u' '1e-3' 'comp1_V' '1e-3' 'comp1_es_term1_V0_ode' '1e-3' 'comp1_es_term1_Q0_ode' '1e-3'  ...
'comp1_currents' '1e-3' 'comp1_voltages' '1e-3'});
model.sol('sol1').feature('t1').set('atolvaluemethod', {'comp1_T' 'factor' 'comp1_u' 'factor' 'comp1_V' 'factor' 'comp1_es_term1_V0_ode' 'factor' 'comp1_es_term1_Q0_ode' 'factor'  ...
'comp1_currents' 'factor' 'comp1_voltages' 'factor'});
model.sol('sol1').feature('t1').set('reacf', true);
model.sol('sol1').feature('t1').set('storeudot', true);
model.sol('sol1').feature('t1').set('tstepsbdf', 'intermediate');
model.sol('sol1').feature('t1').set('endtimeinterpolation', true);
model.sol('sol1').feature('t1').set('estrat', 'exclude');
model.sol('sol1').feature('t1').set('maxorder', 2);
model.sol('sol1').feature('t1').create('tp1', 'TimeParametric');
model.sol('sol1').feature('t1').feature.remove('tpDef');
model.sol('sol1').feature('t1').feature('tp1').set('control', 'time');
model.sol('sol1').feature('t1').set('control', 'time');
model.sol('sol1').feature('t1').feature('aDef').set('cachepattern', true);
model.sol('sol1').feature('t1').create('seDef', 'Segregated');
model.sol('sol1').feature('t1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('t1').feature('fc1').set('stabacc', 'aacc');
model.sol('sol1').feature('t1').feature('fc1').set('aaccdim', 5);
model.sol('sol1').feature('t1').feature('fc1').set('aaccdelay', 0);
model.sol('sol1').feature('t1').feature('fc1').set('aaccmix', 0.9);
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
model.sol('sol1').feature('t1').feature('i1').set('rhob', 20);
model.sol('sol1').feature('t1').feature('i1').set('maxlinit', 10000);
model.sol('sol1').feature('t1').feature('i1').set('nlinnormuse', 'on');
model.sol('sol1').feature('t1').feature('i1').label('AMG, heat transfer variables (pye1)');
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
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('pr').create('so1', 'SOR');
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('pr').feature('so1').set('iter', 2);
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('pr').feature('so1').set('relax', 0.9);
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('po').create('so1', 'SOR');
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('po').feature('so1').set('iter', 2);
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('po').feature('so1').set('relax', 0.9);
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('cs').create('d1', 'Direct');
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('cs').feature('d1').set('linsolver', 'pardiso');
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('cs').feature('d1').set('pivotperturb', 1.0E-13);
model.sol('sol1').feature('t1').feature('fc1').set('linsolver', 'd1');
model.sol('sol1').feature('t1').feature('fc1').set('stabacc', 'aacc');
model.sol('sol1').feature('t1').feature('fc1').set('aaccdim', 5);
model.sol('sol1').feature('t1').feature('fc1').set('aaccdelay', 0);
model.sol('sol1').feature('t1').feature('fc1').set('aaccmix', 0.9);
model.sol('sol1').feature('t1').feature('fc1').set('damp', 0.9);
model.sol('sol1').feature('t1').feature('fc1').set('jtech', 'once');
model.sol('sol1').feature('t1').feature.remove('fcDef');
model.sol('sol1').feature('t1').feature.remove('seDef');
model.sol('sol1').attach('std1');
model.sol('sol1').runAll;

model.study.create('std2');
model.study('std2').create('time', 'Transient');
model.study('std2').feature('time').setSolveFor('/physics/es', true);
model.study('std2').feature('time').setSolveFor('/physics/solid', true);
model.study('std2').feature('time').setSolveFor('/physics/ht', true);
model.study('std2').feature('time').setSolveFor('/physics/cir', true);
model.study('std2').feature('time').setSolveFor('/multiphysics/pze1', true);
model.study('std2').feature('time').setSolveFor('/multiphysics/te1', true);
model.study('std2').feature('time').setSolveFor('/multiphysics/pye1', true);
model.study('std2').feature('time').label('Time Dependent - Pyroelectricity Only');
model.study('std2').feature('time').set('tlist', 'range(0,0.02,2)');
model.study('std2').feature('time').setEntry('activate', 'solid', false);
model.study('std2').feature('time').setEntry('activateCoupling', 'pze1', false);
model.study('std2').feature('time').setEntry('activateCoupling', 'te1', false);
model.study('std2').feature('time').set('useparam', true);
model.study('std2').feature('time').setIndex('pname', 'r_el', 0);
model.study('std2').feature('time').setIndex('plistarr', '', 0);
model.study('std2').feature('time').setIndex('punit', 'm', 0);
model.study('std2').feature('time').setIndex('pname', 'r_el', 0);
model.study('std2').feature('time').setIndex('plistarr', '', 0);
model.study('std2').feature('time').setIndex('punit', 'm', 0);
model.study('std2').feature('time').setIndex('pname', 'R_ext', 0);
model.study('std2').feature('time').setIndex('plistarr', '0.1 5e6 5e7 1e9', 0);
model.study('std2').setGenPlots(false);

model.sol.create('sol2');
model.sol('sol2').study('std2');
model.sol('sol2').create('st1', 'StudyStep');
model.sol('sol2').feature('st1').set('study', 'std2');
model.sol('sol2').feature('st1').set('studystep', 'time');
model.sol('sol2').create('v1', 'Variables');
model.sol('sol2').feature('v1').set('control', 'time');
model.sol('sol2').create('t1', 'Time');
model.sol('sol2').feature('t1').set('tlist', 'range(0,0.02,2)');
model.sol('sol2').feature('t1').set('plot', 'off');
model.sol('sol2').feature('t1').set('plotgroup', 'Default');
model.sol('sol2').feature('t1').set('plotfreq', 'tout');
model.sol('sol2').feature('t1').set('probesel', 'all');
model.sol('sol2').feature('t1').set('probes', {});
model.sol('sol2').feature('t1').set('probefreq', 'tsteps');
model.sol('sol2').feature('t1').set('atolglobalvaluemethod', 'factor');
model.sol('sol2').feature('t1').set('atolmethod', {'comp1_T' 'global' 'comp1_u' 'global' 'comp1_V' 'global' 'comp1_es_term1_V0_ode' 'global' 'comp1_es_term1_Q0_ode' 'global'  ...
'comp1_currents' 'global' 'comp1_voltages' 'global'});
model.sol('sol2').feature('t1').set('atol', {'comp1_T' '1e-3' 'comp1_u' '1e-3' 'comp1_V' '1e-3' 'comp1_es_term1_V0_ode' '1e-3' 'comp1_es_term1_Q0_ode' '1e-3'  ...
'comp1_currents' '1e-3' 'comp1_voltages' '1e-3'});
model.sol('sol2').feature('t1').set('atolvaluemethod', {'comp1_T' 'factor' 'comp1_u' 'factor' 'comp1_V' 'factor' 'comp1_es_term1_V0_ode' 'factor' 'comp1_es_term1_Q0_ode' 'factor'  ...
'comp1_currents' 'factor' 'comp1_voltages' 'factor'});
model.sol('sol2').feature('t1').set('reacf', true);
model.sol('sol2').feature('t1').set('storeudot', true);
model.sol('sol2').feature('t1').set('tstepsbdf', 'intermediate');
model.sol('sol2').feature('t1').set('endtimeinterpolation', true);
model.sol('sol2').feature('t1').set('estrat', 'exclude');
model.sol('sol2').feature('t1').set('maxorder', 2);
model.sol('sol2').feature('t1').create('tp1', 'TimeParametric');
model.sol('sol2').feature('t1').feature.remove('tpDef');
model.sol('sol2').feature('t1').feature('tp1').set('control', 'time');
model.sol('sol2').feature('t1').set('control', 'time');
model.sol('sol2').feature('t1').create('seDef', 'Segregated');
model.sol('sol2').feature('t1').create('fc1', 'FullyCoupled');
model.sol('sol2').feature('t1').feature('fc1').set('stabacc', 'aacc');
model.sol('sol2').feature('t1').feature('fc1').set('aaccdim', 5);
model.sol('sol2').feature('t1').feature('fc1').set('aaccdelay', 0);
model.sol('sol2').feature('t1').feature('fc1').set('aaccmix', 0.9);
model.sol('sol2').feature('t1').feature('fc1').set('damp', 0.9);
model.sol('sol2').feature('t1').feature('fc1').set('jtech', 'once');
model.sol('sol2').feature('t1').create('d1', 'Direct');
model.sol('sol2').feature('t1').feature('d1').set('linsolver', 'mumps');
model.sol('sol2').feature('t1').feature('d1').set('pivotperturb', 1.0E-13);
model.sol('sol2').feature('t1').feature('d1').label('Direct (Merged)');
model.sol('sol2').feature('t1').create('i1', 'Iterative');
model.sol('sol2').feature('t1').feature('i1').set('linsolver', 'gmres');
model.sol('sol2').feature('t1').feature('i1').set('prefuntype', 'left');
model.sol('sol2').feature('t1').feature('i1').set('itrestart', 50);
model.sol('sol2').feature('t1').feature('i1').set('rhob', 20);
model.sol('sol2').feature('t1').feature('i1').set('maxlinit', 10000);
model.sol('sol2').feature('t1').feature('i1').set('nlinnormuse', 'on');
model.sol('sol2').feature('t1').feature('i1').label('AMG, heat transfer variables (pye1)');
model.sol('sol2').feature('t1').feature('i1').create('mg1', 'Multigrid');
model.sol('sol2').feature('t1').feature('i1').feature('mg1').set('prefun', 'saamg');
model.sol('sol2').feature('t1').feature('i1').feature('mg1').set('mgcycle', 'v');
model.sol('sol2').feature('t1').feature('i1').feature('mg1').set('maxcoarsedof', 50000);
model.sol('sol2').feature('t1').feature('i1').feature('mg1').set('strconn', 0.01);
model.sol('sol2').feature('t1').feature('i1').feature('mg1').set('nullspace', 'constant');
model.sol('sol2').feature('t1').feature('i1').feature('mg1').set('usesmooth', false);
model.sol('sol2').feature('t1').feature('i1').feature('mg1').set('saamgcompwise', true);
model.sol('sol2').feature('t1').feature('i1').feature('mg1').set('loweramg', true);
model.sol('sol2').feature('t1').feature('i1').feature('mg1').set('compactaggregation', false);
model.sol('sol2').feature('t1').feature('i1').feature('mg1').feature('pr').create('so1', 'SOR');
model.sol('sol2').feature('t1').feature('i1').feature('mg1').feature('pr').feature('so1').set('iter', 2);
model.sol('sol2').feature('t1').feature('i1').feature('mg1').feature('pr').feature('so1').set('relax', 0.9);
model.sol('sol2').feature('t1').feature('i1').feature('mg1').feature('po').create('so1', 'SOR');
model.sol('sol2').feature('t1').feature('i1').feature('mg1').feature('po').feature('so1').set('iter', 2);
model.sol('sol2').feature('t1').feature('i1').feature('mg1').feature('po').feature('so1').set('relax', 0.9);
model.sol('sol2').feature('t1').feature('i1').feature('mg1').feature('cs').create('d1', 'Direct');
model.sol('sol2').feature('t1').feature('i1').feature('mg1').feature('cs').feature('d1').set('linsolver', 'pardiso');
model.sol('sol2').feature('t1').feature('i1').feature('mg1').feature('cs').feature('d1').set('pivotperturb', 1.0E-13);
model.sol('sol2').feature('t1').feature('fc1').set('linsolver', 'd1');
model.sol('sol2').feature('t1').feature('fc1').set('stabacc', 'aacc');
model.sol('sol2').feature('t1').feature('fc1').set('aaccdim', 5);
model.sol('sol2').feature('t1').feature('fc1').set('aaccdelay', 0);
model.sol('sol2').feature('t1').feature('fc1').set('aaccmix', 0.9);
model.sol('sol2').feature('t1').feature('fc1').set('damp', 0.9);
model.sol('sol2').feature('t1').feature('fc1').set('jtech', 'once');
model.sol('sol2').feature('t1').feature.remove('fcDef');
model.sol('sol2').feature('t1').feature.remove('seDef');
model.sol('sol2').attach('std2');
model.sol('sol2').runAll;

model.result.create('pg1', 'PlotGroup1D');
model.result('pg1').run;
model.result('pg1').label('Temperature and Current Density, Full Model');
model.result('pg1').set('twoyaxes', true);
model.result('pg1').create('ptgr1', 'PointGraph');
model.result('pg1').feature('ptgr1').set('markerpos', 'datapoints');
model.result('pg1').feature('ptgr1').set('linewidth', 'preference');
model.result('pg1').feature('ptgr1').selection.set([2]);
model.result('pg1').feature('ptgr1').set('expr', 'T');
model.result('pg1').feature('ptgr1').set('descractive', true);
model.result('pg1').run;
model.result('pg1').feature('ptgr1').label('Temperature');
model.result('pg1').run;
model.result('pg1').create('glob1', 'Global');
model.result('pg1').feature('glob1').set('markerpos', 'datapoints');
model.result('pg1').feature('glob1').set('linewidth', 'preference');
model.result('pg1').feature('glob1').label('Circuit Current');
model.result('pg1').feature('glob1').set('plotonsecyaxis', true);
model.result('pg1').feature('glob1').setIndex('expr', 'cir.R1_i', 0);
model.result('pg1').feature('glob1').setIndex('unit', 'uA', 0);
model.result('pg1').feature('glob1').set('autodescr', false);
model.result('pg1').run;
model.result('pg1').run;
model.result('pg1').run;
model.result.create('pg2', 'PlotGroup1D');
model.result('pg2').run;
model.result('pg2').label('Voltage, Full Model');
model.result('pg2').set('legendpos', 'lowerright');
model.result('pg2').create('glob1', 'Global');
model.result('pg2').feature('glob1').set('markerpos', 'datapoints');
model.result('pg2').feature('glob1').set('linewidth', 'preference');
model.result('pg2').feature('glob1').set('expr', {'cir.R1_v'});
model.result('pg2').feature('glob1').set('descr', {'Voltage across device R1'});
model.result('pg2').feature('glob1').set('unit', {'V'});
model.result('pg2').feature('glob1').set('autodescr', false);
model.result('pg2').run;
model.result.create('pg3', 'PlotGroup1D');
model.result('pg3').run;
model.result('pg3').label('Electric Power, Full Model');
model.result('pg3').create('glob1', 'Global');
model.result('pg3').feature('glob1').set('markerpos', 'datapoints');
model.result('pg3').feature('glob1').set('linewidth', 'preference');
model.result('pg3').feature('glob1').setIndex('expr', 'realdot(cir.R1_i,cir.R1_v)', 0);
model.result('pg3').feature('glob1').setIndex('unit', 'uW', 0);
model.result('pg3').feature('glob1').setIndex('descr', 'Electric Power', 0);
model.result('pg3').feature('glob1').set('autodescr', false);
model.result('pg3').run;
model.result.create('pg4', 'PlotGroup1D');
model.result('pg4').run;
model.result('pg4').label('Full Model vs. Pyroelectricity Only');
model.result('pg4').create('glob1', 'Global');
model.result('pg4').feature('glob1').set('markerpos', 'datapoints');
model.result('pg4').feature('glob1').set('linewidth', 'preference');
model.result('pg4').feature('glob1').label('Electric Power, Full Model');
model.result('pg4').feature('glob1').set('data', 'dset1');
model.result('pg4').feature('glob1').setIndex('looplevelinput', 'manual', 1);
model.result('pg4').feature('glob1').setIndex('looplevel', [4], 1);
model.result('pg4').feature('glob1').setIndex('expr', 'realdot(cir.R1_i,cir.R1_v)', 0);
model.result('pg4').feature('glob1').setIndex('unit', 'uW', 0);
model.result('pg4').feature('glob1').setIndex('descr', 'Electric Power, Full Model', 0);
model.result('pg4').feature('glob1').set('autosolution', false);
model.result('pg4').feature.duplicate('glob2', 'glob1');
model.result('pg4').run;
model.result('pg4').feature('glob2').label('Electric Power, Pyroelectricity Only');
model.result('pg4').feature('glob2').set('data', 'dset2');
model.result('pg4').feature('glob2').setIndex('descr', 'Electric Power, Pyroelectricity Only', 0);
model.result('pg4').run;
model.result.dataset.create('rev1', 'Revolve2D');
model.result.create('pg5', 'PlotGroup3D');
model.result('pg5').run;
model.result('pg5').label('Temperature Distribution');
model.result('pg5').setIndex('looplevel', 26, 0);
model.result('pg5').create('vol1', 'Volume');
model.result('pg5').feature('vol1').set('expr', 'T');
model.result('pg5').feature('vol1').set('descractive', true);
model.result('pg5').feature('vol1').set('colortable', 'ThermalDark');
model.result('pg5').run;

model.title('Pyroelectric Detector');

model.description('This 2D axisymmetric model demonstrates the operation of a pyroelectric detector found in instruments for measuring laser energy. A disk of lithium niobate (LiNbO3) is sandwiched between two electrodes and connected to an external circuit. The disk is mounted on a ring-shaped conducting pad with limited thermal conduction. A pulsed energy flux applied to the top surface of the disk represents the absorption of infrared laser. This model uses the Piezoelectricity and Pyroelectricity Multiphysics Interface which includes Pyroelectricity, Piezoelectricity, and Thermal Expansion couplings. A time-dependent study is used to compute the temperature evolution in the disk and the pyroelectric current.');

model.mesh.clearMeshes;

model.sol('sol1').clearSolutionData;
model.sol('sol2').clearSolutionData;

model.label('pyroelectric_detector.mph');

model.modelNode.label('Components');

out = model;
