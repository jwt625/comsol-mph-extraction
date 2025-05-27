function out = model
%
% capacitor_transient.m
%
% Model exported on May 26 2025, 21:24 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/ACDC_Module/Devices,_Capacitive');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 3);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.physics.create('ec', 'ConductiveMedia', 'geom1');
model.physics('ec').model('comp1');
model.physics.create('cir', 'Circuit', 'geom1');
model.physics('cir').model('comp1');

model.study.create('std1');
model.study('std1').create('time', 'Transient');
model.study('std1').feature('time').setSolveFor('/physics/ec', true);
model.study('std1').feature('time').setSolveFor('/physics/cir', true);

model.param.set('R', '1000[ohm]');
model.param.descr('R', 'External resistor resistance');
model.param.set('C', '43.4[pF]');
model.param.descr('C', 'Device capacitance');
model.param.set('V0', '1[V]');
model.param.descr('V0', 'Applied voltage');

model.geom('geom1').lengthUnit('cm');
model.geom('geom1').create('cyl1', 'Cylinder');
model.geom('geom1').feature('cyl1').set('r', 20);
model.geom('geom1').feature('cyl1').set('h', 20);
model.geom('geom1').run('cyl1');

model.view('view1').set('renderwireframe', true);

model.geom('geom1').create('cyl2', 'Cylinder');
model.geom('geom1').feature('cyl2').set('r', 10);
model.geom('geom1').feature('cyl2').set('h', 4);
model.geom('geom1').feature('cyl2').set('pos', [0 0 8]);
model.geom('geom1').feature('cyl2').setIndex('layer', '5[mm]', 0);
model.geom('geom1').feature('cyl2').set('layerside', false);
model.geom('geom1').feature('cyl2').set('layerbottom', true);
model.geom('geom1').feature('cyl2').set('layertop', true);
model.geom('geom1').run('cyl2');
model.geom('geom1').create('cyl3', 'Cylinder');
model.geom('geom1').feature('cyl3').set('r', 0.75);
model.geom('geom1').feature('cyl3').set('h', 8);
model.geom('geom1').feature.duplicate('cyl4', 'cyl3');
model.geom('geom1').feature('cyl4').set('pos', [0 0 12]);
model.geom('geom1').runPre('fin');
model.geom('geom1').run;

model.view('view1').hideEntities.create('hide1');
model.view('view1').hideEntities('hide1').geom('geom1', 2);
model.view('view1').hideEntities('hide1').set([1 4 23]);

model.physics('ec').create('term1', 'DomainTerminal', 3);
model.physics('ec').feature('term1').selection.set([4 6]);
model.physics('ec').feature('term1').set('TerminalType', 'Circuit');

model.selection.create('sel1', 'Explicit');
model.selection('sel1').model('comp1');
model.selection('sel1').set([2 5]);
model.selection('sel1').geom('geom1', 3, 2, {'exterior'});
model.selection('sel1').set([2 5]);

model.physics('ec').create('gnd1', 'Ground', 2);
model.physics('ec').feature('gnd1').selection.named('sel1');
model.physics('ec').selection.set([1 3 4 6]);
model.physics('cir').create('R1', 'Resistor', -1);
model.physics('cir').feature('R1').setIndex('Connections', 0, 1, 0);
model.physics('cir').feature('R1').set('R', 'R');
model.physics('cir').create('V1', 'VoltageSource', -1);
model.physics('cir').feature('V1').setIndex('Connections', 0, 1, 0);
model.physics('cir').feature('V1').set('value', 'V0');
model.physics('cir').create('IvsU1', 'ModelDeviceIV', -1);
model.physics('cir').feature('IvsU1').setIndex('Connections', 2, 0, 0);
model.physics('cir').feature('IvsU1').setIndex('Connections', 1, 1, 0);
model.physics('cir').feature('IvsU1').set('V_src', 'root.comp1.ec.V0_1');

model.material.create('mat1', 'Common', 'comp1');
model.material('mat1').propertyGroup('def').func.create('eta', 'Piecewise');
model.material('mat1').propertyGroup('def').func.create('Cp', 'Piecewise');
model.material('mat1').propertyGroup('def').func.create('rho', 'Analytic');
model.material('mat1').propertyGroup('def').func.create('k', 'Piecewise');
model.material('mat1').propertyGroup('def').func.create('cs', 'Analytic');
model.material('mat1').propertyGroup('def').func.create('an1', 'Analytic');
model.material('mat1').propertyGroup('def').func.create('an2', 'Analytic');
model.material('mat1').propertyGroup.create('RefractiveIndex', 'Refractive index');
model.material('mat1').propertyGroup.create('NonlinearModel', 'Nonlinear model');
model.material('mat1').propertyGroup.create('idealGas', 'Ideal gas');
model.material('mat1').propertyGroup('idealGas').func.create('Cp', 'Piecewise');
model.material('mat1').label('Air');
model.material('mat1').set('family', 'air');
model.material('mat1').propertyGroup('def').func('eta').set('arg', 'T');
model.material('mat1').propertyGroup('def').func('eta').set('pieces', {'200.0' '1600.0' '-8.38278E-7+8.35717342E-8*T^1-7.69429583E-11*T^2+4.6437266E-14*T^3-1.06585607E-17*T^4'});
model.material('mat1').propertyGroup('def').func('eta').set('argunit', 'K');
model.material('mat1').propertyGroup('def').func('eta').set('fununit', 'Pa*s');
model.material('mat1').propertyGroup('def').func('Cp').set('arg', 'T');
model.material('mat1').propertyGroup('def').func('Cp').set('pieces', {'200.0' '1600.0' '1047.63657-0.372589265*T^1+9.45304214E-4*T^2-6.02409443E-7*T^3+1.2858961E-10*T^4'});
model.material('mat1').propertyGroup('def').func('Cp').set('argunit', 'K');
model.material('mat1').propertyGroup('def').func('Cp').set('fununit', 'J/(kg*K)');
model.material('mat1').propertyGroup('def').func('rho').set('expr', 'pA*0.02897/R_const[K*mol/J]/T');
model.material('mat1').propertyGroup('def').func('rho').set('args', {'pA' 'T'});
model.material('mat1').propertyGroup('def').func('rho').set('fununit', 'kg/m^3');
model.material('mat1').propertyGroup('def').func('rho').set('argunit', {'Pa' 'K'});
model.material('mat1').propertyGroup('def').func('rho').set('plotaxis', {'off' 'on'});
model.material('mat1').propertyGroup('def').func('rho').set('plotfixedvalue', {'101325' '273.15'});
model.material('mat1').propertyGroup('def').func('rho').set('plotargs', {'pA' '101325' '101325'; 'T' '273.15' '293.15'});
model.material('mat1').propertyGroup('def').func('k').set('arg', 'T');
model.material('mat1').propertyGroup('def').func('k').set('pieces', {'200.0' '1600.0' '-0.00227583562+1.15480022E-4*T^1-7.90252856E-8*T^2+4.11702505E-11*T^3-7.43864331E-15*T^4'});
model.material('mat1').propertyGroup('def').func('k').set('argunit', 'K');
model.material('mat1').propertyGroup('def').func('k').set('fununit', 'W/(m*K)');
model.material('mat1').propertyGroup('def').func('cs').set('expr', 'sqrt(1.4*R_const[K*mol/J]/0.02897*T)');
model.material('mat1').propertyGroup('def').func('cs').set('args', {'T'});
model.material('mat1').propertyGroup('def').func('cs').set('fununit', 'm/s');
model.material('mat1').propertyGroup('def').func('cs').set('argunit', {'K'});
model.material('mat1').propertyGroup('def').func('cs').set('plotfixedvalue', {'273.15'});
model.material('mat1').propertyGroup('def').func('cs').set('plotargs', {'T' '273.15' '373.15'});
model.material('mat1').propertyGroup('def').func('an1').set('funcname', 'alpha_p');
model.material('mat1').propertyGroup('def').func('an1').set('expr', '-1/rho(pA,T)*d(rho(pA,T),T)');
model.material('mat1').propertyGroup('def').func('an1').set('args', {'pA' 'T'});
model.material('mat1').propertyGroup('def').func('an1').set('fununit', '1/K');
model.material('mat1').propertyGroup('def').func('an1').set('argunit', {'Pa' 'K'});
model.material('mat1').propertyGroup('def').func('an1').set('plotaxis', {'off' 'on'});
model.material('mat1').propertyGroup('def').func('an1').set('plotfixedvalue', {'101325' '273.15'});
model.material('mat1').propertyGroup('def').func('an1').set('plotargs', {'pA' '101325' '101325'; 'T' '273.15' '373.15'});
model.material('mat1').propertyGroup('def').func('an2').set('funcname', 'muB');
model.material('mat1').propertyGroup('def').func('an2').set('expr', '0.6*eta(T)');
model.material('mat1').propertyGroup('def').func('an2').set('args', {'T'});
model.material('mat1').propertyGroup('def').func('an2').set('fununit', 'Pa*s');
model.material('mat1').propertyGroup('def').func('an2').set('argunit', {'K'});
model.material('mat1').propertyGroup('def').func('an2').set('plotfixedvalue', {'200'});
model.material('mat1').propertyGroup('def').func('an2').set('plotargs', {'T' '200' '1600'});
model.material('mat1').propertyGroup('def').set('thermalexpansioncoefficient', '');
model.material('mat1').propertyGroup('def').set('molarmass', '');
model.material('mat1').propertyGroup('def').set('bulkviscosity', '');
model.material('mat1').propertyGroup('def').set('thermalexpansioncoefficient', {'alpha_p(pA,T)' '0' '0' '0' 'alpha_p(pA,T)' '0' '0' '0' 'alpha_p(pA,T)'});
model.material('mat1').propertyGroup('def').set('molarmass', '0.02897[kg/mol]');
model.material('mat1').propertyGroup('def').set('bulkviscosity', 'muB(T)');
model.material('mat1').propertyGroup('def').set('relpermeability', {'1' '0' '0' '0' '1' '0' '0' '0' '1'});
model.material('mat1').propertyGroup('def').set('relpermittivity', {'1' '0' '0' '0' '1' '0' '0' '0' '1'});
model.material('mat1').propertyGroup('def').set('dynamicviscosity', 'eta(T)');
model.material('mat1').propertyGroup('def').set('ratioofspecificheat', '1.4');
model.material('mat1').propertyGroup('def').set('electricconductivity', {'0[S/m]' '0' '0' '0' '0[S/m]' '0' '0' '0' '0[S/m]'});
model.material('mat1').propertyGroup('def').set('heatcapacity', 'Cp(T)');
model.material('mat1').propertyGroup('def').set('density', 'rho(pA,T)');
model.material('mat1').propertyGroup('def').set('thermalconductivity', {'k(T)' '0' '0' '0' 'k(T)' '0' '0' '0' 'k(T)'});
model.material('mat1').propertyGroup('def').set('soundspeed', 'cs(T)');
model.material('mat1').propertyGroup('def').addInput('temperature');
model.material('mat1').propertyGroup('def').addInput('pressure');
model.material('mat1').propertyGroup('RefractiveIndex').set('n', {'1' '0' '0' '0' '1' '0' '0' '0' '1'});
model.material('mat1').propertyGroup('NonlinearModel').set('BA', 'def.gamma-1');
model.material('mat1').propertyGroup('idealGas').func('Cp').label('Piecewise 2');
model.material('mat1').propertyGroup('idealGas').func('Cp').set('arg', 'T');
model.material('mat1').propertyGroup('idealGas').func('Cp').set('pieces', {'200.0' '1600.0' '1047.63657-0.372589265*T^1+9.45304214E-4*T^2-6.02409443E-7*T^3+1.2858961E-10*T^4'});
model.material('mat1').propertyGroup('idealGas').func('Cp').set('argunit', 'K');
model.material('mat1').propertyGroup('idealGas').func('Cp').set('fununit', 'J/(kg*K)');
model.material('mat1').propertyGroup('idealGas').set('Rs', 'R_const/Mn');
model.material('mat1').propertyGroup('idealGas').set('heatcapacity', 'Cp(T)');
model.material('mat1').propertyGroup('idealGas').set('ratioofspecificheat', '1.4');
model.material('mat1').propertyGroup('idealGas').set('molarmass', '0.02897');
model.material('mat1').propertyGroup('idealGas').addInput('temperature');
model.material('mat1').propertyGroup('idealGas').addInput('pressure');
model.material('mat1').materialType('nonSolid');
model.material('mat1').propertyGroup('def').set('electricconductivity', {'5e-15[S/m]'});
model.material.create('mat2', 'Common', 'comp1');
model.material('mat2').propertyGroup.create('RefractiveIndex', 'Refractive index');
model.material('mat2').label('Glass (quartz)');
model.material('mat2').set('family', 'custom');
model.material('mat2').set('customambient', [1 1 1]);
model.material('mat2').set('noise', true);
model.material('mat2').set('fresnel', 0.99);
model.material('mat2').set('roughness', 0.02);
model.material('mat2').set('metallic', 0);
model.material('mat2').set('pearl', 0);
model.material('mat2').set('diffusewrap', 0);
model.material('mat2').set('clearcoat', 0);
model.material('mat2').set('reflectance', 0);
model.material('mat2').propertyGroup('def').set('relpermeability', {'1' '0' '0' '0' '1' '0' '0' '0' '1'});
model.material('mat2').propertyGroup('def').set('electricconductivity', {'1e-14[S/m]' '0' '0' '0' '1e-14[S/m]' '0' '0' '0' '1e-14[S/m]'});
model.material('mat2').propertyGroup('def').set('relpermittivity', {'4.2' '0' '0' '0' '4.2' '0' '0' '0' '4.2'});
model.material('mat2').propertyGroup('def').set('density', '2210[kg/m^3]');
model.material('mat2').propertyGroup('def').set('thermalconductivity', {'1.4[W/(m*K)]' '0' '0' '0' '1.4[W/(m*K)]' '0' '0' '0' '1.4[W/(m*K)]'});
model.material('mat2').propertyGroup('def').set('heatcapacity', '730[J/(kg*K)]');
model.material('mat2').propertyGroup('RefractiveIndex').set('n', {'1.5' '0' '0' '0' '1.5' '0' '0' '0' '1.5'});
model.material('mat2').selection.set([3]);

model.mesh('mesh1').run;

model.study('std1').setGenPlots(false);
model.study('std1').feature('time').set('tlist', 'range(0,2.0e-8,2.0e-7)');

model.sol.create('sol1');
model.sol('sol1').study('std1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'time');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').set('control', 'time');
model.sol('sol1').create('t1', 'Time');
model.sol('sol1').feature('t1').set('tlist', 'range(0,2.0e-8,2.0e-7)');
model.sol('sol1').feature('t1').set('plot', 'off');
model.sol('sol1').feature('t1').set('plotgroup', 'Default');
model.sol('sol1').feature('t1').set('plotfreq', 'tout');
model.sol('sol1').feature('t1').set('probesel', 'all');
model.sol('sol1').feature('t1').set('probes', {});
model.sol('sol1').feature('t1').set('probefreq', 'tsteps');
model.sol('sol1').feature('t1').set('atolglobalvaluemethod', 'factor');
model.sol('sol1').feature('t1').set('endtimeinterpolation', true);
model.sol('sol1').feature('t1').set('control', 'time');
model.sol('sol1').feature('t1').create('iDef', 'Iterative');
model.sol('sol1').feature('t1').create('seDef', 'Segregated');
model.sol('sol1').feature('t1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('t1').create('i1', 'Iterative');
model.sol('sol1').feature('t1').feature('i1').set('linsolver', 'gmres');
model.sol('sol1').feature('t1').feature('i1').set('nlinnormuse', true);
model.sol('sol1').feature('t1').feature('i1').set('prefuntype', 'right');
model.sol('sol1').feature('t1').feature('i1').create('mg1', 'Multigrid');
model.sol('sol1').feature('t1').feature('i1').feature('mg1').set('prefun', 'amg');
model.sol('sol1').feature('t1').feature('i1').feature('mg1').set('coarseningmethod', 'classic');
model.sol('sol1').feature('t1').feature('i1').feature('mg1').set('hybridization', 'multi');
model.sol('sol1').feature('t1').feature('i1').feature('mg1').set('hybridvar', {'comp1_V' 'comp1_ec_term1_V0_ode'});
model.sol('sol1').feature('t1').feature('i1').create('dp1', 'DirectPreconditioner');
model.sol('sol1').feature('t1').feature('i1').feature('dp1').set('linsolver', 'pardiso');
model.sol('sol1').feature('t1').feature('i1').feature('dp1').set('hybridization', 'multi');
model.sol('sol1').feature('t1').feature('i1').feature('dp1').set('hybridvar', {'comp1_currents'});
model.sol('sol1').feature('t1').feature('fc1').set('linsolver', 'i1');
model.sol('sol1').feature('t1').feature.remove('fcDef');
model.sol('sol1').feature('t1').feature.remove('seDef');
model.sol('sol1').feature('t1').feature.remove('iDef');
model.sol('sol1').attach('std1');
model.sol('sol1').feature('t1').create('fc2', 'FullyCoupled');
model.sol('sol1').feature('t1').feature('dDef').active(true);
model.sol('sol1').feature('t1').set('estrat', 'exclude');
model.sol('sol1').feature('t1').set('maxorder', 1);
model.sol('sol1').feature('t1').set('maxstepconstraintbdf', 'const');
model.sol('sol1').feature('t1').set('maxstepbdf', '5e-9');
model.sol('sol1').runAll;

model.result.dataset.create('cpt1', 'CutPoint3D');
model.result.dataset('cpt1').set('pointx', 0);
model.result.dataset('cpt1').set('pointy', 0);
model.result.dataset('cpt1').set('pointz', 10);
model.result.create('pg1', 'PlotGroup3D');
model.result('pg1').run;
model.result('pg1').create('slc1', 'Slice');
model.result('pg1').feature('slc1').set('quickxnumber', 1);
model.result('pg1').run;
model.result.dataset('dset1').selection.geom('geom1', 3);
model.result.dataset('dset1').selection.geom('geom1', 3);
model.result.dataset('dset1').selection.set([1 3]);
model.result('pg1').run;
model.result('pg1').run;
model.result.create('pg2', 'PlotGroup1D');
model.result('pg2').run;
model.result('pg2').create('glob1', 'Global');
model.result('pg2').feature('glob1').set('markerpos', 'datapoints');
model.result('pg2').feature('glob1').set('linewidth', 'preference');
model.result('pg2').feature('glob1').set('expr', {'ec.I0_1'});
model.result('pg2').feature('glob1').set('descr', {'Terminal current'});
model.result('pg2').feature('glob1').set('unit', {'A'});
model.result('pg2').feature('glob1').set('linestyle', 'none');
model.result('pg2').feature('glob1').set('linemarker', 'circle');
model.result('pg2').run;
model.result('pg2').create('glob2', 'Global');
model.result('pg2').feature('glob2').set('markerpos', 'datapoints');
model.result('pg2').feature('glob2').set('linewidth', 'preference');
model.result('pg2').feature('glob2').setIndex('expr', '(V0/R)*exp(-t/(R*C))', 0);
model.result('pg2').feature('glob2').setIndex('descr', 'Analytic approximation', 0);
model.result('pg2').run;
model.result.create('pg3', 'PlotGroup1D');
model.result('pg3').run;
model.result('pg3').set('data', 'cpt1');
model.result('pg3').create('ptgr1', 'PointGraph');
model.result('pg3').feature('ptgr1').set('markerpos', 'datapoints');
model.result('pg3').feature('ptgr1').set('linewidth', 'preference');
model.result('pg3').feature('ptgr1').set('expr', '-ec.Jiz');
model.result('pg3').feature('ptgr1').set('linemarker', 'circle');
model.result('pg3').feature('ptgr1').set('legend', true);
model.result('pg3').feature('ptgr1').set('legendmethod', 'manual');
model.result('pg3').feature('ptgr1').setIndex('legends', 'Induced conduction current density', 0);
model.result('pg3').run;
model.result('pg3').feature.duplicate('ptgr2', 'ptgr1');
model.result('pg3').run;
model.result('pg3').feature('ptgr2').set('expr', '-ec.Jdz');
model.result('pg3').feature('ptgr2').setIndex('legends', 'Displacement current density', 0);
model.result('pg3').run;

model.study('std1').feature('time').set('tlist', 'range(0,5e-8,2e-6)');

model.sol('sol1').runAll;

model.result('pg1').run;
model.result('pg3').run;
model.result('pg3').set('ylog', true);
model.result('pg3').run;
model.result('pg2').run;
model.result('pg2').set('ylog', true);
model.result('pg2').run;

model.title('Transient Modeling of a Capacitor in a Circuit');

model.description('This example solves a transient model of a capacitor in combination with an external electrical circuit. The finite element model of the capacitor is combined with a circuit model of a voltage source and a resistor. A step change in voltage is applied, and the transient current through the capacitor is computed and compared to the analytic result.');

model.mesh.clearMeshes;

model.sol('sol1').clearSolutionData;

model.label('capacitor_transient.mph');

model.modelNode.label('Components');

out = model;
