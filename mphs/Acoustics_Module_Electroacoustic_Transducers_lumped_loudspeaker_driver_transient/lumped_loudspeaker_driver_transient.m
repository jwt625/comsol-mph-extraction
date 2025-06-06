function out = model
%
% lumped_loudspeaker_driver_transient.m
%
% Model exported on May 26 2025, 21:25 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/Acoustics_Module/Electroacoustic_Transducers');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 2);
model.geom('geom1').model('comp1');
model.geom('geom1').axisymmetric(true);

model.mesh.create('mesh1', 'geom1');

model.physics.create('actd', 'TransientPressureAcoustics', 'geom1');
model.physics('actd').model('comp1');

model.study.create('std1');
model.study('std1').create('time', 'Transient');
model.study('std1').feature('time').setSolveFor('/physics/actd', true);

% To import content from file, use:
% model.param.loadFile('FILENAME');
model.param.set('f0', '50[Hz]', 'Driving frequency');
model.param.set('T0', '1/f0', 'Period at f0');
model.param.set('N0', '4', 'Harmonics to resolve by solver');
model.param.set('M_MD', '33.4[g]', 'Moving mass (voice coil and diaphragm)');
model.param.set('R_E', '7[ohm]', 'Voice coil resistance');
model.param.set('L_E', '6.89[mH]', 'Voice coil inductance (constant)');
model.param.set('V0', '15[V]', 'Driving voltage (peak)');
model.param.set('V0rms', 'V0/sqrt(2)', 'Driving voltage (RMS)');
model.param.set('a', '12[cm]', 'Piston radius of driver (equivalent)');
model.param.set('S_D', 'a^2*pi', 'Driver equivalent area');
model.param.set('Rair', '20[cm]', 'Air domain radius');
model.param.set('Rpml', '6[cm]', 'PML layer thickness');

model.func.create('int1', 'Interpolation');
model.func('int1').set('source', 'file');
model.func('int1').set('filename', 'lumped_loudspeaker_driver_transient_bl.txt');
model.func('int1').importData;
model.func('int1').set('funcname', 'BL');
model.func('int1').set('interp', 'piecewisecubic');
model.func('int1').set('extrap', 'linear');
model.func('int1').setIndex('fununit', 'Wb/m', 0);
model.func('int1').setIndex('argunit', 'mm', 0);
model.func.create('int2', 'Interpolation');
model.func('int2').set('source', 'file');
model.func('int2').set('filename', 'lumped_loudspeaker_driver_transient_c_ms.txt');
model.func('int2').importData;
model.func('int2').set('funcname', 'C_MS');
model.func('int2').set('extrap', 'linear');
model.func('int2').setIndex('fununit', 'mm/N', 0);
model.func('int2').setIndex('argunit', 'mm', 0);
model.func.create('int3', 'Interpolation');
model.func('int3').set('source', 'file');
model.func('int3').set('filename', 'lumped_loudspeaker_driver_transient_r_ms.txt');
model.func('int3').importData;
model.func('int3').set('funcname', 'R_MS');
model.func('int3').set('interp', 'cubicspline');
model.func('int3').setIndex('fununit', 'N*s/m', 0);
model.func('int3').setIndex('argunit', 'm/s', 0);
model.func.create('rm1', 'Ramp');
model.func('rm1').model('comp1');
model.func('rm1').set('location', '0.1*T0');
model.func('rm1').set('slope', '1/T0');
model.func('rm1').set('cutoffactive', true);
model.func('rm1').set('smoothzonelocactive', true);
model.func('rm1').set('smoothzoneloc', '0.2*T0');
model.func('rm1').set('smoothzonecutoffactive', true);
model.func('rm1').set('smoothzonecutoff', '0.2*T0');

model.geom('geom1').create('c1', 'Circle');
model.geom('geom1').feature('c1').set('r', '1[cm]');
model.geom('geom1').feature('c1').set('angle', 180);
model.geom('geom1').feature('c1').set('pos', {'a' '0'});
model.geom('geom1').run('c1');
model.geom('geom1').create('c2', 'Circle');
model.geom('geom1').feature('c2').set('r', 'Rair+Rpml');
model.geom('geom1').feature('c2').set('angle', 180);
model.geom('geom1').feature('c2').set('rot', -90);
model.geom('geom1').feature('c2').setIndex('layername', 'Layer 1', 0);
model.geom('geom1').feature('c2').setIndex('layer', 'Rpml', 0);
model.geom('geom1').run('c2');
model.geom('geom1').create('pol1', 'Polygon');
model.geom('geom1').feature('pol1').set('source', 'table');
model.geom('geom1').feature('pol1').set('type', 'open');
model.geom('geom1').feature('pol1').setIndex('table', '3[cm]', 0, 0);
model.geom('geom1').feature('pol1').setIndex('table', '-4[cm]', 0, 1);
model.geom('geom1').feature('pol1').setIndex('table', 'a-1[cm]', 1, 0);
model.geom('geom1').feature('pol1').setIndex('table', 0, 1, 1);
model.geom('geom1').run('pol1');
model.geom('geom1').create('pol2', 'Polygon');
model.geom('geom1').feature('pol2').set('source', 'table');
model.geom('geom1').feature('pol2').set('type', 'open');
model.geom('geom1').feature('pol2').setIndex('table', 'a+1[cm]', 0, 0);
model.geom('geom1').feature('pol2').setIndex('table', 0, 0, 1);
model.geom('geom1').feature('pol2').setIndex('table', 'Rair', 1, 0);
model.geom('geom1').feature('pol2').setIndex('table', 0, 1, 1);
model.geom('geom1').runPre('fin');
model.geom('geom1').create('qb1', 'QuadraticBezier');
model.geom('geom1').feature('qb1').setIndex('p', '1.8[cm]', 0, 1);
model.geom('geom1').feature('qb1').setIndex('p', '3[cm]', 0, 2);
model.geom('geom1').feature('qb1').setIndex('p', '-3[cm]', 1, 0);
model.geom('geom1').feature('qb1').setIndex('p', '-3.1[cm]', 1, 1);
model.geom('geom1').feature('qb1').setIndex('p', '-4[cm]', 1, 2);
model.geom('geom1').feature('qb1').set('w', [1 1.5 1]);
model.geom('geom1').runPre('fin');
model.geom('geom1').create('del1', 'Delete');
model.geom('geom1').feature('del1').selection('input').set('c1', [3 4]);
model.geom('geom1').run('del1');
model.geom('geom1').create('pol3', 'Polygon');
model.geom('geom1').feature('pol3').set('source', 'table');
model.geom('geom1').feature('pol3').set('type', 'open');
model.geom('geom1').feature('pol3').setIndex('table', 0.15, 0, 0);
model.geom('geom1').feature('pol3').setIndex('table', 0, 0, 1);
model.geom('geom1').feature('pol3').setIndex('table', 0.15, 1, 0);
model.geom('geom1').feature('pol3').setIndex('table', -0.1, 1, 1);
model.geom('geom1').feature('pol3').setIndex('table', 0, 2, 0);
model.geom('geom1').feature('pol3').setIndex('table', -0.1, 2, 1);
model.geom('geom1').runPre('fin');

model.coordSystem.create('pml1', 'geom1', 'PML');

model.geom('geom1').run;

model.coordSystem('pml1').selection.set([1 5]);
model.coordSystem('pml1').set('PMLgamma', '3');

model.selection.create('sel1', 'Explicit');
model.selection('sel1').model('comp1');
model.selection('sel1').label('Baffle (interior wall)');
model.selection('sel1').geom(1);
model.selection('sel1').set([9 11 12 19]);
model.selection.create('sel2', 'Explicit');
model.selection('sel2').model('comp1');
model.selection('sel2').label('Speaker');
model.selection('sel2').geom(1);
model.selection('sel2').set([8 15 18]);

model.physics('actd').create('ishb1', 'InteriorSoundHard', 1);
model.physics('actd').feature('ishb1').selection.named('sel1');
model.physics('actd').create('ilsb1', 'InteriorLumpedSpeakerBoundary', 1);
model.physics('actd').feature('ilsb1').selection.named('sel2');
model.physics.create('cir', 'Circuit', 'geom1');
model.physics('cir').model('comp1');

model.study('std1').feature('time').setSolveFor('/physics/cir', true);

model.physics('cir').create('V1', 'VoltageSource', -1);
model.physics('cir').feature('V1').setIndex('Connections', 0, 1, 0);
model.physics('cir').feature('V1').set('value', 'V0*sin(2*pi*f0*t)*nojac(rm1(t))');
model.physics('cir').create('R1', 'Resistor', -1);
model.physics('cir').feature('R1').setIndex('Connections', 1, 0, 0);
model.physics('cir').feature('R1').setIndex('Connections', 2, 1, 0);
model.physics('cir').feature('R1').set('R', 'R_E');
model.physics('cir').create('L1', 'Inductor', -1);
model.physics('cir').feature('L1').setIndex('Connections', 2, 0, 0);
model.physics('cir').feature('L1').setIndex('Connections', 3, 1, 0);
model.physics('cir').feature('L1').set('L', 'L_E');
model.physics('cir').create('H1', 'CurrentVoltageSource', -1);
model.physics('cir').feature('H1').setIndex('Connections', 3, 0, 0);
model.physics('cir').feature('H1').setIndex('Connections', 0, 1, 0);
model.physics('cir').feature('H1').set('gain', 'BL(actd.ilsb1.x_ax)[m/Wb*ohm]');
model.physics('cir').create('H2', 'CurrentVoltageSource', -1);
model.physics('cir').feature('H2').setIndex('Connections', 0, 1, 0);
model.physics('cir').feature('H2').set('device', 'R1');
model.physics('cir').feature('H2').set('gain', 'BL(actd.ilsb1.x_ax)[m/Wb*ohm]');
model.physics('cir').create('L2', 'Inductor', -1);
model.physics('cir').feature('L2').setIndex('Connections', 4, 0, 0);
model.physics('cir').feature('L2').setIndex('Connections', 5, 1, 0);
model.physics('cir').feature('L2').set('L', 'M_MD[H/kg]');
model.physics('cir').feature('H1').set('device', 'L2');
model.physics('cir').create('R2', 'Resistor', -1);
model.physics('cir').feature('R2').setIndex('Connections', 5, 0, 0);
model.physics('cir').feature('R2').setIndex('Connections', 6, 1, 0);
model.physics('cir').feature('R2').set('R', 'R_MS(actd.ilsb1.v_ax)[ohm/kg*s]');
model.physics('cir').create('G1', 'VoltageCurrentSource', -1);
model.physics('cir').feature('G1').label('Voltage-Controlled Current Source 1 - Generalized Capacitor');
model.physics('cir').feature('G1').setIndex('Connections', 6, 0, 0);
model.physics('cir').feature('G1').setIndex('Connections', 7, 1, 0);
model.physics('cir').feature('G1').setIndex('Connections', 6, 2, 0);
model.physics('cir').feature('G1').setIndex('Connections', 7, 3, 0);
model.physics('cir').feature('G1').set('method', 'expression');
model.physics('cir').feature('G1').set('expr', 'd(C_MS(actd.ilsb1.x_ax)*sens.v,t)');
model.physics('cir').create('IvsU1', 'ModelDeviceIV', -1);
model.physics('cir').feature('IvsU1').setIndex('Connections', 7, 0, 0);
model.physics('cir').feature('IvsU1').setIndex('Connections', 0, 1, 0);
model.physics('cir').feature('IvsU1').set('V_src', 'root.comp1.actd.ilsb1.V_cir');
model.physics('actd').prop('TransientSettings').set('fmax', 'N0*f0');

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

model.mesh('mesh1').contribute('physics/cir', false);
model.mesh('mesh1').run;

model.study('std1').feature('time').set('tlist', 'range(0,T0/30,10*T0)');

model.sol.create('sol1');
model.sol('sol1').study('std1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'time');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').set('control', 'time');
model.sol('sol1').create('t1', 'Time');
model.sol('sol1').feature('t1').set('tlist', 'range(0,T0/30,10*T0)');
model.sol('sol1').feature('t1').set('plot', 'off');
model.sol('sol1').feature('t1').set('plotgroup', 'Default');
model.sol('sol1').feature('t1').set('plotfreq', 'tout');
model.sol('sol1').feature('t1').set('probesel', 'all');
model.sol('sol1').feature('t1').set('probes', {});
model.sol('sol1').feature('t1').set('probefreq', 'tsteps');
model.sol('sol1').feature('t1').set('rtol', 1.0E-4);
model.sol('sol1').feature('t1').set('atolglobalvaluemethod', 'factor');
model.sol('sol1').feature('t1').set('eventtol', 0.01);
model.sol('sol1').feature('t1').set('reacf', true);
model.sol('sol1').feature('t1').set('storeudot', true);
model.sol('sol1').feature('t1').set('tstepsgenalpha', 'manual');
model.sol('sol1').feature('t1').set('timestepgenalpha', 'min(1/(60*N0*f0),1/(60*N0*f0))');
model.sol('sol1').feature('t1').set('timestepbdf', 'min(1/(60*N0*f0),1/(60*N0*f0))');
model.sol('sol1').feature('t1').set('endtimeinterpolation', true);
model.sol('sol1').feature('t1').set('timemethod', 'genalpha');
model.sol('sol1').feature('t1').set('maxorder', 2);
model.sol('sol1').feature('t1').set('minorder', 1);
model.sol('sol1').feature('t1').set('initialstepbdfactive', true);
model.sol('sol1').feature('t1').set('initialstepbdf', 'min(1/(100*N0*f0),1/(100*N0*f0))');
model.sol('sol1').feature('t1').set('maxstepconstraintbdf', 'const');
model.sol('sol1').feature('t1').set('maxstepbdf', 'min(min(1e100,1/(30*N0*f0)),1/(30*N0*f0))');
model.sol('sol1').feature('t1').set('initialstepgenalphaactive', true);
model.sol('sol1').feature('t1').set('initialstepgenalpha', 'min(1/(100*N0*f0),1/(100*N0*f0))');
model.sol('sol1').feature('t1').set('maxstepconstraintgenalpha', 'const');
model.sol('sol1').feature('t1').set('maxstepgenalpha', 'min(min(1e100,1/(30*N0*f0)),1/(30*N0*f0))');
model.sol('sol1').feature('t1').set('rescaleafterinitbw', false);
model.sol('sol1').feature('t1').set('bwinitstepfrac', '0.001');
model.sol('sol1').feature('t1').set('control', 'time');
model.sol('sol1').feature('t1').create('seDef', 'Segregated');
model.sol('sol1').feature('t1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('t1').feature('fc1').set('linsolver', 'dDef');
model.sol('sol1').feature('t1').feature.remove('fcDef');
model.sol('sol1').feature('t1').feature.remove('seDef');
model.sol('sol1').attach('std1');
model.sol('sol1').runAll;

model.result.create('pg1', 'PlotGroup2D');
model.result('pg1').set('data', 'dset1');
model.result('pg1').setIndex('looplevel', 301, 0);
model.result('pg1').create('surf1', 'Surface');
model.result('pg1').feature('surf1').set('expr', {'actd.p_t'});
model.result('pg1').feature('surf1').set('colortable', 'Wave');
model.result('pg1').feature('surf1').set('colorscalemode', 'linearsymmetric');
model.result('pg1').set('showlegendsunit', true);
model.result('pg1').label('Acoustic Pressure (actd)');
model.result.dataset.create('rev1', 'Revolve2D');
model.result.dataset('rev1').set('data', 'dset1');
model.result.dataset('rev1').set('revangle', 225);
model.result.dataset('rev1').set('startangle', -90);
model.result.dataset('rev1').set('hasspacevars', false);
model.result.create('pg2', 'PlotGroup3D');
model.result('pg2').set('data', 'rev1');
model.result('pg2').setIndex('looplevel', 301, 0);
model.result('pg2').create('surf1', 'Surface');
model.result('pg2').feature('surf1').set('expr', {'actd.p_t'});
model.result('pg2').feature('surf1').set('colortable', 'Wave');
model.result('pg2').feature('surf1').set('colorscalemode', 'linearsymmetric');
model.result('pg2').set('showlegendsunit', true);
model.result('pg2').label('Acoustic Pressure, 3D (actd)');
model.result('pg1').run;
model.result.create('pg3', 'PlotGroup1D');
model.result('pg3').run;
model.result('pg3').label('Pressure On-Axis');
model.result('pg3').set('titletype', 'label');
model.result('pg3').create('ptgr1', 'PointGraph');
model.result('pg3').feature('ptgr1').set('markerpos', 'datapoints');
model.result('pg3').feature('ptgr1').set('linewidth', 'preference');
model.result('pg3').feature('ptgr1').selection.set([6]);
model.result('pg3').run;
model.result.create('pg4', 'PlotGroup1D');
model.result('pg4').run;
model.result('pg4').label('Pressure On-Axis FFT');
model.result('pg4').setIndex('looplevelinput', 'interp', 0);
model.result('pg4').setIndex('interp', 'range(2*T0,T0/100,10*T0)', 0);
model.result('pg4').set('titletype', 'label');
model.result('pg4').set('ylabelactive', true);
model.result('pg4').set('ylabel', 'Fourier coefficient (dB SPL)');
model.result('pg4').create('ptgr1', 'PointGraph');
model.result('pg4').feature('ptgr1').set('markerpos', 'datapoints');
model.result('pg4').feature('ptgr1').set('linewidth', 'preference');
model.result('pg4').feature('ptgr1').selection.set([6]);
model.result('pg4').feature('ptgr1').set('xdata', 'fourier');
model.result('pg4').feature('ptgr1').set('fouriershow', 'spectrum');
model.result('pg4').feature('ptgr1').set('scale', 'multiplyperiod');
model.result('pg4').feature('ptgr1').set('freqrangeactive', true);
model.result('pg4').feature('ptgr1').set('freqmax', '(N0+1.5)*f0');
model.result('pg4').feature('ptgr1').set('indb', true);
model.result('pg4').feature('ptgr1').set('dbtype', '20log');
model.result('pg4').feature('ptgr1').set('dbref', 'manual');
model.result('pg4').feature('ptgr1').set('dbmanualref', '20e-6');
model.result('pg4').run;
model.result('pg4').feature('ptgr1').create('gmrk1', 'GraphMarker');
model.result('pg4').feature('ptgr1').feature('gmrk1').set('linewidth', 'preference');
model.result('pg4').run;
model.result('pg4').feature('ptgr1').feature('gmrk1').set('display', 'max');
model.result('pg4').feature('ptgr1').feature('gmrk1').set('scope', 'local');
model.result('pg4').feature('ptgr1').feature('gmrk1').set('precision', 3);
model.result('pg4').feature('ptgr1').feature('gmrk1').set('labelsuffix', ' dB');
model.result('pg4').run;
model.result.create('pg5', 'PlotGroup1D');
model.result('pg5').run;
model.result('pg5').label('Speaker Position x(t)');
model.result('pg5').set('titletype', 'label');
model.result('pg5').create('glob1', 'Global');
model.result('pg5').feature('glob1').set('markerpos', 'datapoints');
model.result('pg5').feature('glob1').set('linewidth', 'preference');
model.result('pg5').feature('glob1').set('expr', {'actd.ilsb1.x_ax'});
model.result('pg5').feature('glob1').set('descr', {'Speaker axial position'});
model.result('pg5').feature('glob1').set('unit', {'m'});
model.result('pg5').feature('glob1').setIndex('unit', 'mm', 0);
model.result('pg5').feature('glob1').setIndex('descr', 'Speaker axial position', 0);
model.result('pg5').run;
model.result.create('pg6', 'PlotGroup1D');
model.result('pg6').run;
model.result('pg6').label('Speaker Velocity v(t)');
model.result('pg6').set('titletype', 'label');
model.result('pg6').create('glob1', 'Global');
model.result('pg6').feature('glob1').set('markerpos', 'datapoints');
model.result('pg6').feature('glob1').set('linewidth', 'preference');
model.result('pg6').feature('glob1').set('expr', {'actd.ilsb1.v_ax'});
model.result('pg6').feature('glob1').set('descr', {'Speaker axial velocity'});
model.result('pg6').feature('glob1').set('unit', {'m/s'});
model.result('pg6').run;
model.result.create('pg7', 'PlotGroup1D');
model.result('pg7').run;
model.result('pg7').label('C_MS(x(t))');
model.result('pg7').setIndex('looplevelinput', 'interp', 0);
model.result('pg7').setIndex('interp', 'range(5*T0,T0/60,10*T0)', 0);
model.result('pg7').create('glob1', 'Global');
model.result('pg7').feature('glob1').set('markerpos', 'datapoints');
model.result('pg7').feature('glob1').set('linewidth', 'preference');
model.result('pg7').feature('glob1').setIndex('expr', 'C_MS(actd.ilsb1.x_ax)', 0);
model.result('pg7').feature('glob1').setIndex('unit', 's^2/kg', 0);
model.result('pg7').feature('glob1').setIndex('descr', 'C_MS(x(t))', 0);
model.result('pg7').run;
model.result.create('pg8', 'PlotGroup1D');
model.result('pg8').run;
model.result('pg8').label('BL(x(t))');
model.result('pg8').setIndex('looplevelinput', 'interp', 0);
model.result('pg8').setIndex('interp', 'range(5*T0,T0/60,10*T0)', 0);
model.result('pg8').create('glob1', 'Global');
model.result('pg8').feature('glob1').set('markerpos', 'datapoints');
model.result('pg8').feature('glob1').set('linewidth', 'preference');
model.result('pg8').feature('glob1').setIndex('expr', 'BL(actd.ilsb1.x_ax)', 0);
model.result('pg8').feature('glob1').setIndex('unit', 'Wb/m', 0);
model.result('pg8').feature('glob1').setIndex('descr', 'BL(x(t))', 0);
model.result('pg8').run;
model.result.create('pg9', 'PlotGroup1D');
model.result('pg9').run;
model.result('pg9').label('R_MS(v(t))');
model.result('pg9').setIndex('looplevelinput', 'interp', 0);
model.result('pg9').setIndex('interp', 'range(5*T0,T0/60,10*T0)', 0);
model.result('pg9').create('glob1', 'Global');
model.result('pg9').feature('glob1').set('markerpos', 'datapoints');
model.result('pg9').feature('glob1').set('linewidth', 'preference');
model.result('pg9').feature('glob1').setIndex('expr', 'R_MS(actd.ilsb1.v_ax)', 0);
model.result('pg9').feature('glob1').setIndex('unit', 'N*s/m', 0);
model.result('pg9').feature('glob1').setIndex('descr', 'R_MS(v(t))', 0);
model.result('pg9').run;

model.func('int1').createPlot('pg10');

model.result('pg10').run;
model.result('pg10').label('Interpolation Data: BL(x)');
model.result('pg10').run;

model.func('int2').createPlot('pg11');

model.result('pg11').run;
model.result('pg11').label('Interpolation Data: C_MS(x)');
model.result('pg11').run;

model.func('int3').createPlot('pg12');

model.result('pg12').run;
model.result('pg12').label('Interpolation Data: R_MS(v)');
model.result('pg12').run;
model.result('pg10').run;
model.result('pg10').set('titletype', 'label');
model.result('pg10').set('xlabelactive', true);
model.result('pg10').set('xlabel', 'x (mm)');
model.result('pg10').set('ylabelactive', true);
model.result('pg10').set('ylabel', 'BL(x) (Wb/m)');
model.result('pg11').run;
model.result('pg11').set('titletype', 'label');
model.result('pg11').set('xlabelactive', true);
model.result('pg11').set('xlabel', 'x (mm)');
model.result('pg11').set('ylabelactive', true);
model.result('pg11').set('ylabel', 'C_MS(x) (mm/N)');
model.result('pg12').run;
model.result('pg12').set('titletype', 'label');
model.result('pg12').set('xlabelactive', true);
model.result('pg12').set('xlabel', 'v (m/s)');
model.result('pg12').set('ylabelactive', true);
model.result('pg12').set('ylabel', 'R_MS(v) (N\cdot s/m)');
model.result('pg4').run;

model.title('Lumped Loudspeaker Driver Transient Analysis with Nonlinear Large-Signal Parameters');

model.description(['This model shows how to include the nonlinear (large-signal) behavior of certain lumped components in a simplified loudspeaker analysis. The mechanical and electrical system is modeled using an equivalent electrical circuit. The large-signal compliance CMS(x) and force factor BL(x) are here nonlinear functions of the speaker location. Moreover, the mechanical damping RMS(v) is a function of the speaker velocity. The nonlinear effects associated with the compliance and BL factor are especially important at lower frequencies. This is also where a lumped modeling approach has its main application.' newline  newline 'The model uses the built-in coupling between the Interior Lumped Speaker Boundary (or Lumped Speaker Boundary) feature and an Electric Circuit interface together with built-in variables for the speaker location x and velocity v.']);

model.mesh.clearMeshes;

model.sol('sol1').clearSolutionData;

model.label('lumped_loudspeaker_driver_transient.mph');

model.modelNode.label('Components');

out = model;
