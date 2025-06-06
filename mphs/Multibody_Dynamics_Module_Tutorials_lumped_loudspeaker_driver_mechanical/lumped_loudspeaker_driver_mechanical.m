function out = model
%
% lumped_loudspeaker_driver_mechanical.m
%
% Model exported on May 26 2025, 21:31 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/Multibody_Dynamics_Module/Tutorials');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 2);
model.geom('geom1').model('comp1');
model.geom('geom1').axisymmetric(true);

model.mesh.create('mesh1', 'geom1');

model.physics.create('acpr', 'PressureAcoustics', 'geom1');
model.physics('acpr').model('comp1');
model.physics.create('cir', 'Circuit', 'geom1');
model.physics('cir').model('comp1');
model.physics.create('lms', 'LumpedMechanicalSystem', 'geom1');
model.physics('lms').model('comp1');

model.study.create('std1');
model.study('std1').create('freq', 'Frequency');
model.study('std1').feature('freq').setSolveFor('/physics/acpr', true);
model.study('std1').feature('freq').setSolveFor('/physics/cir', true);
model.study('std1').feature('freq').setSolveFor('/physics/lms', true);

% To import content from file, use:
% model.param.loadFile('FILENAME');
model.param.set('fmax', '10[kHz]', 'Maximal study frequency');
model.param.set('c0', '343[m/s]', 'Speed of sound in air');
model.param.set('rho0', '1.2[kg/m^3]', 'Density of air');
model.param.set('M_MD', '33.4[g]', 'Moving mass (voice coil and diaphragm)');
model.param.set('C_MS', '1.18e-3[m/N]', 'Suspension compliance');
model.param.set('R_MS', '1.85[N*s/m]', 'Suspension mechanical losses');
model.param.set('BL', '11.4[T*m]', 'Force factor, flux density (B) times coil length (L)');
model.param.set('R_E', '7[ohm]', 'Voice coil resistance');
model.param.set('L_e', '6.89[mH]', 'Voice coil inductance (constant)');
model.param.set('n_e', '0.7', 'Voice coil loss factor');
model.param.set('V0', 'sqrt(2)[V]', 'Driving voltage (peak)');
model.param.set('V0rms', 'V0/sqrt(2)', 'Driving voltage (rms)');
model.param.set('R_g', '0[ohm]', 'Driver output resistance');
model.param.set('a', '12[cm]', 'Piston radius of driver (equivalent)');
model.param.set('Rair', '20[cm]', 'Air domain radius');
model.param.set('Rpml', '6[cm]', 'PML layer thickness');

model.geom('geom1').create('imp1', 'Import');
model.geom('geom1').feature('imp1').set('filename', 'lumped_loudspeaker_driver_mechanical.mphbin');
model.geom('geom1').feature('imp1').importData;
model.geom('geom1').run('fin');

model.variable.create('var1');
model.variable('var1').model('comp1');
model.variable('var1').label('Model variables');

% To import content from file, use:
% model.variable('var1').loadFile('FILENAME');
model.variable('var1').set('L_E', '(L_e/(sin(n_e*pi/2)))*(acpr.omega[s/rad])^(n_e-1)', 'Voice coil inductance (frequency dependent)');
model.variable('var1').set('Rp_E', '(L_e/(cos(n_e*pi/2)))*(acpr.omega[s/rad])^(n_e)[ohm/H]', 'Resistance (losses in magnetic system)');
model.variable('var1').set('F_D', 'intop((down(p)-up(p))*nz)', 'Axial pressure force');
model.variable('var1').set('P_AR', 'intop(up(acpr.Ir)*nr+up(acpr.Iz)*nz)', 'Radiated power');
model.variable('var1').set('P_E', '0.5*realdot(V0,cir.R1_i)', 'Electric input power (rms)');
model.variable('var1').set('eta', 'P_AR/P_E', 'Driver efficiency');
model.variable('var1').set('k0', 'acpr.omega/c0', 'Free space wave number');

model.selection.create('sel1', 'Explicit');
model.selection('sel1').model('comp1');
model.selection('sel1').label('Speaker');
model.selection('sel1').geom(1);
model.selection('sel1').set([6 11 14]);
model.selection.create('sel2', 'Explicit');
model.selection('sel2').model('comp1');
model.selection('sel2').label('Internal wall');
model.selection('sel2').geom(1);
model.selection('sel2').set([7 8 15]);

model.cpl.create('intop1', 'Integration', 'geom1');
model.cpl('intop1').set('axisym', true);
model.cpl('intop1').selection.geom('geom1', 1);
model.cpl('intop1').selection.named('sel1');
model.cpl('intop1').set('opname', 'intop');

model.coordSystem.create('pml1', 'geom1', 'PML');
model.coordSystem('pml1').selection.set([1 4]);
model.coordSystem('pml1').set('stretchingType', 'rational');
model.coordSystem('pml1').set('PMLfactor', '0.5');
model.coordSystem('pml1').set('PMLgamma', '5');

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

model.physics('acpr').create('ishb1', 'InteriorSoundHard', 1);
model.physics('acpr').feature('ishb1').selection.named('sel2');
model.physics('acpr').create('ina1', 'InteriorNormalAcceleration', 1);
model.physics('acpr').feature('ina1').selection.named('sel1');
model.physics('acpr').feature('ina1').set('acc', {'0' '0' 'lms.M1_a'});
model.physics('acpr').create('efc1', 'ExteriorFieldCalculation', 1);
model.physics('acpr').feature('efc1').selection.set([12]);
model.physics('acpr').feature('efc1').setIndex('SymmetryCondition2', 1, 0);
model.physics('cir').create('V1', 'VoltageSource', -1);
model.physics('cir').feature('V1').setIndex('Connections', 1, 0, 0);
model.physics('cir').feature('V1').setIndex('Connections', 0, 1, 0);
model.physics('cir').feature('V1').set('value', 'V0');
model.physics('cir').create('R1', 'Resistor', -1);
model.physics('cir').feature('R1').setIndex('Connections', 1, 0, 0);
model.physics('cir').feature('R1').setIndex('Connections', 2, 1, 0);
model.physics('cir').feature('R1').set('R', 'R_g');
model.physics('cir').create('R2', 'Resistor', -1);
model.physics('cir').feature('R2').setIndex('Connections', 2, 0, 0);
model.physics('cir').feature('R2').setIndex('Connections', 3, 1, 0);
model.physics('cir').feature('R2').set('R', 'R_E');
model.physics('cir').create('L1', 'Inductor', -1);
model.physics('cir').feature('L1').setIndex('Connections', 3, 0, 0);
model.physics('cir').feature('L1').setIndex('Connections', 4, 1, 0);
model.physics('cir').feature('L1').set('L', 'L_E');
model.physics('cir').create('R3', 'Resistor', -1);
model.physics('cir').feature('R3').setIndex('Connections', 3, 0, 0);
model.physics('cir').feature('R3').setIndex('Connections', 4, 1, 0);
model.physics('cir').feature('R3').set('R', 'Rp_E');
model.physics('cir').create('V2', 'VoltageSource', -1);
model.physics('cir').feature('V2').setIndex('Connections', 4, 0, 0);
model.physics('cir').feature('V2').setIndex('Connections', 0, 1, 0);
model.physics('cir').feature('V2').set('value', 'BL*lms.M1_v');
model.physics('lms').create('K1', 'Spring', -1);
model.physics('lms').feature('K1').setIndex('Connections', 0, 0, 0);
model.physics('lms').feature('K1').setIndex('Connections', 1, 1, 0);
model.physics('lms').feature('K1').set('k', '1/C_MS');
model.physics('lms').feature('K1').set('includeDisplacement', false);
model.physics('lms').create('C1', 'Damper', -1);
model.physics('lms').feature('C1').setIndex('Connections', 0, 0, 0);
model.physics('lms').feature('C1').setIndex('Connections', 1, 1, 0);
model.physics('lms').feature('C1').set('c', 'R_MS');
model.physics('lms').feature('C1').set('includeDisplacement', false);
model.physics('lms').create('M1', 'Mass', -1);
model.physics('lms').feature('M1').setIndex('Connections', 1, 0, 0);
model.physics('lms').feature('M1').setIndex('Connections', 2, 1, 0);
model.physics('lms').feature('M1').set('m', 'M_MD');
model.physics('lms').feature('M1').set('includeDisplacement', false);
model.physics('lms').feature('M1').set('includeVelocity', true);
model.physics('lms').create('frc1', 'ForceNode', -1);
model.physics('lms').feature('frc1').setIndex('Connections', 2, 0, 0);
model.physics('lms').feature('frc1').set('fp1', 'BL*cir.R2_i+F_D');

model.mesh('mesh1').contribute('physics/cir', false);
model.mesh('mesh1').contribute('physics/lms', false);

model.physics('acpr').prop('MeshControl').set('ElementsPerWavelength', 'UserDefined');
model.physics('acpr').prop('MeshControl').set('nperlambda', 8);

model.study('std1').feature('freq').set('plist', '{10, 10.3, 10.6, 10.9, 11.2, 11.5, 11.8, 12.2, 12.5, 12.8, 13.2, 13.6, 14, 14.5, 15, 15.5, 16, 16.5, 17, 17.5, 18, 18.5, 19, 19.5, 20, 20.6, 21.2, 21.8, 22.4, 23, 23.6, 24.3, 25, 25.8, 26.5, 27.2, 28, 29, 30, 30.7, 31.5, 32.5, 33.5, 34.5, 35.5, 36.5, 37.5, 38.7, 40, 41.2, 42.5, 43.7, 45, 46.2, 47.5, 48.7, 50, 51.5, 53, 54.5, 56, 58, 60, 61.5, 63, 65, 67, 69, 71, 73, 75, 77.5, 80, 82.5, 85, 87.5, 90, 92.5, 95, 97.5, 100, 103, 106, 109, 112, 115, 118, 122, 125, 128, 132, 136, 140, 145, 150, 155, 160, 165, 170, 175, 180, 185, 190, 195, 200, 206, 212, 218, 224, 230, 236, 243, 250, 258, 265, 272, 280, 290, 300, 307, 315, 325, 335, 345, 355, 365, 375, 387, 400, 412, 425, 437, 450, 462, 475, 487, 500, 515, 530, 545, 560, 580, 600, 615, 630, 650, 670, 690, 710, 730, 750, 775, 800, 825, 850, 875, 900, 925, 950, 975, 1e3, 1.03e3, 1.06e3, 1.09e3, 1.12e3, 1.15e3, 1.18e3, 1.22e3, 1.25e3, 1.28e3, 1.32e3, 1.36e3, 1.4e3, 1.45e3, 1.5e3, 1.55e3, 1.6e3, 1.65e3, 1.7e3, 1.75e3, 1.8e3, 1.85e3, 1.9e3, 1.95e3, 2e3, 2.06e3, 2.12e3, 2.18e3, 2.24e3, 2.3e3, 2.36e3, 2.43e3, 2.5e3, 2.58e3, 2.65e3, 2.72e3, 2.8e3, 2.9e3, 3e3, 3.07e3, 3.15e3, 3.25e3, 3.35e3, 3.45e3, 3.55e3, 3.65e3, 3.75e3, 3.87e3, 4e3, 4.12e3, 4.25e3, 4.37e3, 4.5e3, 4.62e3, 4.75e3, 4.87e3, 5e3, 5.15e3, 5.3e3, 5.45e3, 5.6e3, 5.8e3, 6e3, 6.15e3, 6.3e3, 6.5e3, 6.7e3, 6.9e3, 7.1e3, 7.3e3, 7.5e3, 7.75e3, 8e3, 8.25e3, 8.5e3, 8.75e3, 9e3, 9.25e3, 9.5e3, 9.75e3, 1e4}');

model.mesh('mesh1').run;

model.sol.create('sol1');
model.sol('sol1').study('std1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'freq');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').set('control', 'freq');
model.sol('sol1').create('s1', 'Stationary');
model.sol('sol1').feature('s1').set('stol', 0.001);
model.sol('sol1').feature('s1').create('p1', 'Parametric');
model.sol('sol1').feature('s1').feature.remove('pDef');
model.sol('sol1').feature('s1').feature('p1').set('pname', {'freq'});
model.sol('sol1').feature('s1').feature('p1').set('plistarr', {'{10, 10.3, 10.6, 10.9, 11.2, 11.5, 11.8, 12.2, 12.5, 12.8, 13.2, 13.6, 14, 14.5, 15, 15.5, 16, 16.5, 17, 17.5, 18, 18.5, 19, 19.5, 20, 20.6, 21.2, 21.8, 22.4, 23, 23.6, 24.3, 25, 25.8, 26.5, 27.2, 28, 29, 30, 30.7, 31.5, 32.5, 33.5, 34.5, 35.5, 36.5, 37.5, 38.7, 40, 41.2, 42.5, 43.7, 45, 46.2, 47.5, 48.7, 50, 51.5, 53, 54.5, 56, 58, 60, 61.5, 63, 65, 67, 69, 71, 73, 75, 77.5, 80, 82.5, 85, 87.5, 90, 92.5, 95, 97.5, 100, 103, 106, 109, 112, 115, 118, 122, 125, 128, 132, 136, 140, 145, 150, 155, 160, 165, 170, 175, 180, 185, 190, 195, 200, 206, 212, 218, 224, 230, 236, 243, 250, 258, 265, 272, 280, 290, 300, 307, 315, 325, 335, 345, 355, 365, 375, 387, 400, 412, 425, 437, 450, 462, 475, 487, 500, 515, 530, 545, 560, 580, 600, 615, 630, 650, 670, 690, 710, 730, 750, 775, 800, 825, 850, 875, 900, 925, 950, 975, 1e3, 1.03e3, 1.06e3, 1.09e3, 1.12e3, 1.15e3, 1.18e3, 1.22e3, 1.25e3, 1.28e3, 1.32e3, 1.36e3, 1.4e3, 1.45e3, 1.5e3, 1.55e3, 1.6e3, 1.65e3, 1.7e3, 1.75e3, 1.8e3, 1.85e3, 1.9e3, 1.95e3, 2e3, 2.06e3, 2.12e3, 2.18e3, 2.24e3, 2.3e3, 2.36e3, 2.43e3, 2.5e3, 2.58e3, 2.65e3, 2.72e3, 2.8e3, 2.9e3, 3e3, 3.07e3, 3.15e3, 3.25e3, 3.35e3, 3.45e3, 3.55e3, 3.65e3, 3.75e3, 3.87e3, 4e3, 4.12e3, 4.25e3, 4.37e3, 4.5e3, 4.62e3, 4.75e3, 4.87e3, 5e3, 5.15e3, 5.3e3, 5.45e3, 5.6e3, 5.8e3, 6e3, 6.15e3, 6.3e3, 6.5e3, 6.7e3, 6.9e3, 7.1e3, 7.3e3, 7.5e3, 7.75e3, 8e3, 8.25e3, 8.5e3, 8.75e3, 9e3, 9.25e3, 9.5e3, 9.75e3, 1e4}'});
model.sol('sol1').feature('s1').feature('p1').set('punit', {'Hz'});
model.sol('sol1').feature('s1').feature('p1').set('pcontinuationmode', 'no');
model.sol('sol1').feature('s1').feature('p1').set('preusesol', 'no');
model.sol('sol1').feature('s1').feature('p1').set('pdistrib', 'off');
model.sol('sol1').feature('s1').feature('p1').set('plot', 'off');
model.sol('sol1').feature('s1').feature('p1').set('plotgroup', 'Default');
model.sol('sol1').feature('s1').feature('p1').set('probesel', 'all');
model.sol('sol1').feature('s1').feature('p1').set('probes', {});
model.sol('sol1').feature('s1').feature('p1').set('control', 'freq');
model.sol('sol1').feature('s1').set('linpmethod', 'sol');
model.sol('sol1').feature('s1').set('linpsol', 'zero');
model.sol('sol1').feature('s1').set('control', 'freq');
model.sol('sol1').feature('s1').feature('aDef').set('complexfun', true);
model.sol('sol1').feature('s1').feature('aDef').set('cachepattern', true);
model.sol('sol1').feature('s1').feature('aDef').set('matherr', true);
model.sol('sol1').feature('s1').feature('aDef').set('blocksizeactive', false);
model.sol('sol1').feature('s1').create('seDef', 'Segregated');
model.sol('sol1').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('s1').feature('fc1').set('dtech', 'auto');
model.sol('sol1').feature('s1').feature('fc1').set('ntolfact', 1);
model.sol('sol1').feature('s1').feature('fc1').set('maxiter', 25);
model.sol('sol1').feature('s1').feature('fc1').set('ntermconst', 'tol');
model.sol('sol1').feature('s1').feature('fc1').set('damp', 1);
model.sol('sol1').feature('s1').feature('fc1').set('jtech', 'onevery');
model.sol('sol1').feature('s1').feature('fc1').set('linsolver', 'dDef');
model.sol('sol1').feature('s1').feature('fc1').set('dtech', 'auto');
model.sol('sol1').feature('s1').feature('fc1').set('ntolfact', 1);
model.sol('sol1').feature('s1').feature('fc1').set('maxiter', 25);
model.sol('sol1').feature('s1').feature('fc1').set('ntermconst', 'tol');
model.sol('sol1').feature('s1').feature('fc1').set('damp', 1);
model.sol('sol1').feature('s1').feature('fc1').set('jtech', 'onevery');
model.sol('sol1').feature('s1').feature.remove('fcDef');
model.sol('sol1').feature('s1').feature.remove('seDef');
model.sol('sol1').attach('std1');
model.sol('sol1').runAll;

model.result.create('pg1', 'PlotGroup2D');
model.result('pg1').set('data', 'dset1');
model.result('pg1').setIndex('looplevel', 241, 0);
model.result('pg1').create('surf1', 'Surface');
model.result('pg1').feature('surf1').set('expr', {'acpr.p_t'});
model.result('pg1').feature('surf1').set('colortable', 'Wave');
model.result('pg1').feature('surf1').set('colorscalemode', 'linearsymmetric');
model.result('pg1').set('showlegendsunit', true);
model.result('pg1').label('Acoustic Pressure (acpr)');
model.result.create('pg2', 'PlotGroup2D');
model.result('pg2').set('data', 'dset1');
model.result('pg2').setIndex('looplevel', 241, 0);
model.result('pg2').create('surf1', 'Surface');
model.result('pg2').feature('surf1').set('expr', {'acpr.Lp_t'});
model.result('pg2').feature('surf1').set('colortable', 'Rainbow');
model.result('pg2').feature('surf1').set('colorscalemode', 'linear');
model.result('pg2').set('showlegendsunit', true);
model.result('pg2').label('Sound Pressure Level (acpr)');
model.result.dataset.create('rev1', 'Revolve2D');
model.result.dataset('rev1').set('data', 'dset1');
model.result.dataset('rev1').set('revangle', 225);
model.result.dataset('rev1').set('startangle', -90);
model.result.dataset('rev1').set('hasspacevars', false);
model.result.create('pg3', 'PlotGroup3D');
model.result('pg3').set('data', 'rev1');
model.result('pg3').setIndex('looplevel', 241, 0);
model.result('pg3').create('surf1', 'Surface');
model.result('pg3').feature('surf1').set('expr', {'acpr.p_t'});
model.result('pg3').feature('surf1').set('colortable', 'Wave');
model.result('pg3').feature('surf1').set('colorscalemode', 'linearsymmetric');
model.result('pg3').set('showlegendsunit', true);
model.result('pg3').label('Acoustic Pressure, 3D (acpr)');
model.result.create('pg4', 'PlotGroup3D');
model.result('pg4').set('data', 'rev1');
model.result('pg4').setIndex('looplevel', 241, 0);
model.result('pg4').create('surf1', 'Surface');
model.result('pg4').feature('surf1').set('expr', {'acpr.Lp_t'});
model.result('pg4').feature('surf1').set('colortable', 'Rainbow');
model.result('pg4').feature('surf1').set('colorscalemode', 'linear');
model.result('pg4').set('showlegendsunit', true);
model.result('pg4').label('Sound Pressure Level, 3D (acpr)');
model.result.create('pg5', 'PolarGroup');
model.result('pg5').set('data', 'dset1');
model.result('pg5').create('rp1', 'RadiationPattern');
model.result('pg5').feature('rp1').set('expr', {'acpr.efc1.Lp_pext'});
model.result('pg5').feature('rp1').set('legend', true);
model.result('pg5').feature('rp1').set('phidisc', 180);
model.result('pg5').label('Exterior-Field Sound Pressure Level (acpr)');
model.result('pg5').setIndex('looplevelinput', 'last', 0);
model.result.create('pg6', 'PolarGroup');
model.result('pg6').set('data', 'dset1');
model.result('pg6').create('rp1', 'RadiationPattern');
model.result('pg6').feature('rp1').set('expr', {'acpr.efc1.pext'});
model.result('pg6').feature('rp1').set('legend', true);
model.result('pg6').feature('rp1').set('phidisc', 180);
model.result('pg6').label('Exterior-Field Pressure (acpr)');
model.result('pg6').setIndex('looplevelinput', 'last', 0);
model.result('pg5').set('symmetricangle', true);
model.result('pg5').set('zeroangle', 'up');
model.result('pg5').set('rotdir', 'cw');
model.result('pg6').set('symmetricangle', true);
model.result('pg6').set('zeroangle', 'up');
model.result('pg6').set('rotdir', 'cw');
model.result.create('pg7', 'PlotGroup1D');
model.result('pg7').label('Force, Amplitude (K1)');
model.result('pg7').set('showlooplevelinput', {'off' 'off' 'off'});
model.result('pg7').set('titletype', 'manual');
model.result('pg7').set('title', 'Force');
model.result('pg7').set('ylabel', 'Force');
model.result('pg7').set('data', 'dset1');
model.result('pg7').set('defaultPlotID', 'ForceAmp');
model.result('pg7').feature.create('glob1', 'Global');
model.result('pg7').feature('glob1').set('expr', {'lms.K1_fAmp'});
model.result('pg7').feature('glob1').set('xdatasolnumtype', 'inner');
model.result('pg7').feature('glob1').set('showunitcombo', 'off');
model.result('pg7').feature('glob1').set('linemarker', 'cycle');
model.result('pg7').feature('glob1').set('xdatasolnumtype', 'inner');
model.result('pg7').feature('glob1').set('data', 'parent');
model.result.create('pg8', 'PlotGroup1D');
model.result('pg8').label('Force, Phase (K1)');
model.result('pg8').set('showlooplevelinput', {'off' 'off' 'off'});
model.result('pg8').set('titletype', 'manual');
model.result('pg8').set('title', 'Phase');
model.result('pg8').set('ylabel', 'Phase');
model.result('pg8').set('data', 'dset1');
model.result('pg8').set('defaultPlotID', 'ForcePhase');
model.result('pg8').feature.create('glob1', 'Global');
model.result('pg8').feature('glob1').set('expr', {'lms.K1_fPhase'});
model.result('pg8').feature('glob1').set('xdatasolnumtype', 'inner');
model.result('pg8').feature('glob1').set('showunitcombo', 'off');
model.result('pg8').feature('glob1').set('linemarker', 'cycle');
model.result('pg8').feature('glob1').set('xdatasolnumtype', 'inner');
model.result('pg8').feature('glob1').set('data', 'parent');
model.result('pg7').label('Force, Amplitude (lms)');
model.result('pg7').set('data', 'dset1');
model.result('pg7').set('defaultPlotID', 'ForceAmp');
model.result('pg7').feature('glob1').set('expr', {});
model.result('pg7').feature('glob1').set('descr', {});
model.result('pg7').feature('glob1').set('expr', {'lms.C1_fAmp'});
model.result('pg7').feature('glob1').set('descr', {'Spring force, amplitude (K1)' 'Damping force, amplitude (C1)'});
model.result('pg7').feature('glob1').set('expr', {'lms.K1_fAmp' 'lms.C1_fAmp'});
model.result('pg7').feature('glob1').set('data', 'parent');
model.result('pg8').label('Force, Phase (lms)');
model.result('pg8').set('data', 'dset1');
model.result('pg8').set('defaultPlotID', 'ForcePhase');
model.result('pg8').feature('glob1').set('expr', {});
model.result('pg8').feature('glob1').set('descr', {});
model.result('pg8').feature('glob1').set('expr', {'lms.C1_fPhase'});
model.result('pg8').feature('glob1').set('descr', {'Spring force, phase (K1)' 'Damping force, phase (C1)'});
model.result('pg8').feature('glob1').set('expr', {'lms.K1_fPhase' 'lms.C1_fPhase'});
model.result('pg8').feature('glob1').set('data', 'parent');
model.result('pg7').label('Force, Amplitude (lms) 1');
model.result('pg7').set('data', 'dset1');
model.result('pg7').set('defaultPlotID', 'ForceAmp');
model.result('pg7').feature('glob1').set('expr', {});
model.result('pg7').feature('glob1').set('descr', {});
model.result('pg7').feature('glob1').set('expr', {'lms.M1_fAmp'});
model.result('pg7').feature('glob1').set('descr', {'Spring force, amplitude (K1)' 'Damping force, amplitude (C1)' 'Inertial force, amplitude (M1)'});
model.result('pg7').feature('glob1').set('expr', {'lms.K1_fAmp' 'lms.C1_fAmp' 'lms.M1_fAmp'});
model.result('pg7').feature('glob1').set('data', 'parent');
model.result('pg8').label('Force, Phase (lms) 1');
model.result('pg8').set('data', 'dset1');
model.result('pg8').set('defaultPlotID', 'ForcePhase');
model.result('pg8').feature('glob1').set('expr', {});
model.result('pg8').feature('glob1').set('descr', {});
model.result('pg8').feature('glob1').set('expr', {'lms.M1_fPhase'});
model.result('pg8').feature('glob1').set('descr', {'Spring force, phase (K1)' 'Damping force, phase (C1)' 'Inertial force, phase (M1)'});
model.result('pg8').feature('glob1').set('expr', {'lms.K1_fPhase' 'lms.C1_fPhase' 'lms.M1_fPhase'});
model.result('pg8').feature('glob1').set('data', 'parent');
model.result.create('pg9', 'PlotGroup1D');
model.result('pg9').label('Velocity, Amplitude (M1)');
model.result('pg9').set('showlooplevelinput', {'off' 'off' 'off'});
model.result('pg9').set('titletype', 'manual');
model.result('pg9').set('title', 'Velocity');
model.result('pg9').set('ylabel', 'Velocity');
model.result('pg9').set('data', 'dset1');
model.result('pg9').set('defaultPlotID', 'VelocityAmp');
model.result('pg9').feature.create('glob1', 'Global');
model.result('pg9').feature('glob1').set('expr', {'lms.M1_vAmp'});
model.result('pg9').feature('glob1').set('xdatasolnumtype', 'inner');
model.result('pg9').feature('glob1').set('showunitcombo', 'off');
model.result('pg9').feature('glob1').set('linemarker', 'cycle');
model.result('pg9').feature('glob1').set('xdatasolnumtype', 'inner');
model.result('pg9').feature('glob1').set('data', 'parent');
model.result.create('pg10', 'PlotGroup1D');
model.result('pg10').label('Velocity, Phase (M1)');
model.result('pg10').set('showlooplevelinput', {'off' 'off' 'off'});
model.result('pg10').set('titletype', 'manual');
model.result('pg10').set('title', 'Phase');
model.result('pg10').set('ylabel', 'Phase');
model.result('pg10').set('data', 'dset1');
model.result('pg10').set('defaultPlotID', 'VelocityPhase');
model.result('pg10').feature.create('glob1', 'Global');
model.result('pg10').feature('glob1').set('expr', {'lms.M1_vPhase'});
model.result('pg10').feature('glob1').set('xdatasolnumtype', 'inner');
model.result('pg10').feature('glob1').set('showunitcombo', 'off');
model.result('pg10').feature('glob1').set('linemarker', 'cycle');
model.result('pg10').feature('glob1').set('xdatasolnumtype', 'inner');
model.result('pg10').feature('glob1').set('data', 'parent');
model.result('pg1').run;
model.result('pg2').run;
model.result('pg2').setIndex('looplevel', 161, 0);
model.result('pg2').run;
model.result('pg2').setIndex('looplevel', 1, 0);
model.result('pg2').run;
model.result.dataset('dset1').selection.geom('geom1', 2);
model.result.dataset('dset1').selection.geom('geom1', 2);
model.result.dataset('dset1').selection.set([2 3]);
model.result('pg1').run;
model.result('pg1').setIndex('looplevel', 161, 0);
model.result('pg1').run;
model.result('pg1').setIndex('looplevel', 217, 0);
model.result('pg1').run;
model.result('pg5').run;
model.result('pg5').run;
model.result('pg5').feature('rp1').set('anglerestr', 'manual');
model.result('pg5').feature('rp1').set('phimin', -90);
model.result('pg5').feature('rp1').set('phirange', 180);
model.result('pg5').run;
model.result('pg6').run;
model.result('pg6').run;
model.result('pg6').feature('rp1').set('anglerestr', 'manual');
model.result('pg6').feature('rp1').set('phimin', -90);
model.result('pg6').feature('rp1').set('phirange', 180);
model.result('pg6').run;
model.result('pg7').run;
model.result('pg7').label('Mechanical Force, Amplitude');
model.result('pg7').set('titletype', 'label');
model.result('pg7').set('ylabel', 'Force (N)');
model.result('pg7').set('legendpos', 'upperleft');
model.result('pg7').set('xlog', true);
model.result('pg7').run;
model.result('pg8').run;
model.result('pg8').label('Mechanical Force, Phase');
model.result('pg8').set('titletype', 'label');
model.result('pg8').set('ylabel', 'Phase (rad)');
model.result('pg8').set('legendpos', 'lowerright');
model.result('pg8').set('xlog', true);
model.result('pg8').run;
model.result('pg9').run;
model.result('pg9').label('Diaphragm Velocity, Amplitude');
model.result('pg9').set('titletype', 'label');
model.result('pg9').set('ylabel', 'Velocity (m/s)');
model.result('pg9').set('xlog', true);
model.result('pg9').run;
model.result('pg10').run;
model.result('pg10').label('Diaphragm Velocity, Phase');
model.result('pg10').set('titletype', 'label');
model.result('pg10').set('ylabel', 'Phase (rad)');
model.result('pg10').set('xlog', true);
model.result('pg10').run;
model.result.create('pg11', 'PlotGroup1D');
model.result('pg11').run;
model.result('pg11').label('Acoustic Radiated Power');
model.result('pg11').set('titletype', 'label');
model.result('pg11').set('xlabelactive', true);
model.result('pg11').set('xlabel', 'f (Hz)');
model.result('pg11').set('ylabelactive', true);
model.result('pg11').set('ylabel', 'Power (W)');
model.result('pg11').set('legendpos', 'lowermiddle');
model.result('pg11').create('glob1', 'Global');
model.result('pg11').feature('glob1').set('markerpos', 'datapoints');
model.result('pg11').feature('glob1').set('linewidth', 'preference');
model.result('pg11').feature('glob1').set('expr', {'P_AR'});
model.result('pg11').feature('glob1').set('descr', {'Radiated power'});
model.result('pg11').feature('glob1').set('unit', {'W'});
model.result('pg11').run;
model.result('pg11').set('xlog', true);
model.result.create('pg12', 'PlotGroup1D');
model.result('pg12').run;
model.result('pg12').label('Electric Input Power');
model.result('pg12').set('titletype', 'label');
model.result('pg12').set('xlabelactive', true);
model.result('pg12').set('xlabel', 'f (Hz)');
model.result('pg12').set('ylabelactive', true);
model.result('pg12').set('ylabel', 'Power (W)');
model.result('pg12').set('legendpos', 'lowerright');
model.result('pg12').create('glob1', 'Global');
model.result('pg12').feature('glob1').set('markerpos', 'datapoints');
model.result('pg12').feature('glob1').set('linewidth', 'preference');
model.result('pg12').feature('glob1').set('expr', {'P_E'});
model.result('pg12').feature('glob1').set('descr', {'Electric input power (rms)'});
model.result('pg12').feature('glob1').set('unit', {'W'});
model.result('pg12').run;
model.result('pg12').set('xlog', true);
model.result.create('pg13', 'PlotGroup1D');
model.result('pg13').run;
model.result('pg13').label('Driver Efficiency');
model.result('pg13').set('titletype', 'label');
model.result('pg13').set('xlabelactive', true);
model.result('pg13').set('xlabel', 'f (Hz)');
model.result('pg13').set('ylabelactive', true);
model.result('pg13').set('ylabel', 'Efficiency (%)');
model.result('pg13').create('glob1', 'Global');
model.result('pg13').feature('glob1').set('markerpos', 'datapoints');
model.result('pg13').feature('glob1').set('linewidth', 'preference');
model.result('pg13').feature('glob1').setIndex('expr', 'eta*100', 0);
model.result('pg13').feature('glob1').setIndex('unit', 1, 0);
model.result('pg13').feature('glob1').setIndex('descr', 'Driver efficiency', 0);
model.result('pg13').run;
model.result('pg13').set('xlog', true);
model.result.dataset.create('pc1', 'ParCurve2D');
model.result.dataset('pc1').set('expry', 's*5[m]+(1-s)*Rair');
model.result.dataset('pc1').set('global', true);
model.result.create('pg14', 'PlotGroup1D');
model.result('pg14').run;
model.result('pg14').label('On-axis Pressure Field');
model.result('pg14').set('data', 'pc1');
model.result('pg14').set('titletype', 'label');
model.result('pg14').set('xlabelactive', true);
model.result('pg14').set('xlabel', 'z (m)');
model.result('pg14').set('ylabelactive', true);
model.result('pg14').set('ylabel', 'Pressure (Pa)');
model.result('pg14').setIndex('looplevelinput', 'manual', 0);
model.result('pg14').setIndex('looplevel', [161], 0);
model.result('pg14').set('showlegends', false);
model.result('pg14').create('lngr1', 'LineGraph');
model.result('pg14').feature('lngr1').set('markerpos', 'datapoints');
model.result('pg14').feature('lngr1').set('linewidth', 'preference');
model.result('pg14').feature('lngr1').set('expr', 'pext(r,z)');
model.result('pg14').feature('lngr1').set('xdata', 'expr');
model.result('pg14').feature('lngr1').set('xdataexpr', 'z');
model.result('pg14').feature('lngr1').set('resolution', 'extrafine');
model.result('pg14').run;
model.result.create('pg15', 'PlotGroup2D');
model.result('pg15').run;
model.result('pg15').label('Intensity');
model.result('pg15').create('surf1', 'Surface');
model.result('pg15').feature('surf1').set('expr', 'acpr.I_rms');
model.result('pg15').run;
model.result('pg15').create('arws1', 'ArrowSurface');
model.result('pg15').feature('arws1').set('expr', {'acpr.Ir' 'acpr.Iz'});
model.result('pg15').feature('arws1').set('descr', 'Intensity');
model.result('pg15').feature('arws1').set('color', 'black');
model.result('pg15').run;
model.result('pg15').create('arwl1', 'ArrowLine');
model.result('pg15').feature('arwl1').set('expr', {'acpr.nr' 'acpr.nz'});
model.result('pg15').feature('arwl1').set('descr', 'Normal vector');
model.result('pg15').feature('arwl1').set('color', 'black');
model.result('pg15').run;
model.result('pg15').run;
model.result('pg15').setIndex('looplevel', 217, 0);
model.result('pg15').run;
model.result('pg15').setIndex('looplevel', 161, 0);
model.result('pg15').run;
model.result('pg15').setIndex('looplevel', 81, 0);
model.result('pg15').run;
model.result.create('pg16', 'PlotGroup1D');
model.result('pg16').run;
model.result('pg16').label('Directivity');
model.result('pg16').create('dir1', 'Directivity');
model.result('pg16').feature('dir1').set('linewidth', 'preference');
model.result('pg16').feature('dir1').set('anglerestr', 'manual');
model.result('pg16').feature('dir1').set('phimin', -90);
model.result('pg16').feature('dir1').set('phirange', 180);
model.result('pg16').feature('dir1').set('layout', 'frequencyy');
model.result('pg16').run;
model.result('pg16').set('ylog', true);
model.result('pg3').run;
model.result('pg3').setIndex('looplevel', 217, 0);
model.result('pg3').run;

model.title('Lumped Loudspeaker Driver Using a Lumped Mechanical System');

model.description(['This is a model of a moving-coil loudspeaker where a lumped parameter analogy represents the behavior of the electrical and mechanical speaker components. The Thiele' native2unicode(hex2dec({'20' '13'}), 'unicode') 'Small parameters (small-signal parameters) serve as input to the lumped model, which is represented by an Electric Circuit interface. The lumped model is coupled to a 2D axisymmetric Pressure Acoustics model describing the surrounding air domain. The output from the model includes, among many things, the impedance and the radiated acoustic power.' newline  newline 'In this model, the mechanical speaker components such as moving mass, suspension compliance, and suspension mechanical losses are modeled using the Lumped Mechanical System interface.']);

model.mesh.clearMeshes;

model.sol('sol1').clearSolutionData;

model.label('lumped_loudspeaker_driver_mechanical.mph');

model.modelNode.label('Components');

out = model;
