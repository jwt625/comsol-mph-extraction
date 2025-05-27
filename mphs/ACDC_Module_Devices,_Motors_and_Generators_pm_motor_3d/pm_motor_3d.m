function out = model
%
% pm_motor_3d.m
%
% Model exported on May 26 2025, 21:24 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/ACDC_Module/Devices,_Motors_and_Generators');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 3);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.physics.create('rmm', 'RotatingMachineryMagnetic', 'geom1');
model.physics('rmm').model('comp1');

model.study.create('std1');
model.study('std1').create('stat', 'Stationary');
model.study('std1').feature('stat').setSolveFor('/physics/rmm', true);

% To import content from file, use:
% model.param.loadFile('FILENAME');
model.param.set('n_sectors', '18', 'Number of sectors');
model.param.set('n_pairs', 'n_sectors/2', 'Number of coil pairs');
model.param.set('sector_angle', '360[deg]/n_sectors', 'Sector angle');
model.param.set('rpm', '3000[rpm]', 'Motor RPM');
model.param.set('time_one_cycle', '1/(rpm*n_sectors)', 'The time for rotation for one sector');
model.param.set('omega_rotor', '2*pi*rpm', 'Angular frequency of rotor');
model.param.set('freq', 'n_pairs*rpm', 'Supply frequency');
model.param.set('omega', '2*pi*freq', 'Supply angular frequency');
model.param.set('I_RMS', '100[A]', 'Coil Ampere-turns, RMS');
model.param.set('I0', 'I_RMS*sqrt(2)', 'Coil Ampere-turns, peak value');
model.param.set('t', '0[s]', 'Set the time t to zero for the stationary study');
model.param.set('r_outer', '1[dm]', 'outer radius of stator');
model.param.set('th_outer', '0.05[dm]', 'radial thickness of outer stator iron');
model.param.set('w_pole', '0.1[dm]', 'stator pole width');
model.param.set('sector_angle_shift', '2[deg]', 'sector angle');
model.param.set('r_inner', '0.8[dm]', 'inner radius of stator pole center piece');
model.param.set('th_inner', '0.02[dm]', 'radial thickness of inner stator iron');
model.param.set('coil_offset', '0.01[dm]', 'coil offset');
model.param.set('h_coil', '(r_outer-th_outer)-r_inner-2*coil_offset-t_pole_chamfer', 'radial extent of coil');
model.param.set('w_coil', '0.05[dm]', 'coil width');
model.param.set('a_coil', 'w_coil*h_coil', 'coil cross section area');
model.param.set('m_th', '0.1[dm]', 'radial extent of permanent magnet');
model.param.set('magnet_angle_shift', '5[deg]', 'angular parameter for magnet');
model.param.set('s_th', '0.1[dm]', 'thickness of rotor iron');
model.param.set('air_gap', '0.02[dm]', 'air gap thickness');
model.param.set('t_case', '2[mm]', 'thickness of Al case');
model.param.set('r_shaft', '20[mm]', 'shaft radius');
model.param.set('t_stator_core', '10[mm]', 'stator core (half) axial dimension');
model.param.set('t_inner', '18[mm]', 'extrusion length for stator and rotor air');
model.param.set('t_shaft', '60[mm]', 'extrusion length for shaft');
model.param.set('t_magnet', '10[mm]', 'magnet (half) axial dimension');
model.param.set('t_pole_chamfer', '3[mm]', 'chamfer size for stator iron');
model.param.set('magnet_fillet', '3[mm]', 'magnet fillet radius');
model.param.set('end_winding_fillet', '2[mm]', 'end winding fillet radius');

model.geom('geom1').create('imp1', 'Import');
model.geom('geom1').feature('imp1').set('filename', 'pm_motor_3d.mphbin');
model.geom('geom1').feature('imp1').importData;
model.geom('geom1').feature('fin').set('action', 'assembly');
model.geom('geom1').feature('fin').set('imprint', true);
model.geom('geom1').run('fin');

model.view('view1').set('renderwireframe', true);

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
model.material.create('mat2', 'Common', 'comp1');
model.material('mat2').propertyGroup.create('BHCurve', 'B-H Curve');
model.material('mat2').propertyGroup('BHCurve').func.create('BH', 'Interpolation');
model.material('mat2').propertyGroup.create('EffectiveBHCurve', 'Effective B-H Curve');
model.material('mat2').propertyGroup('EffectiveBHCurve').func.create('BHeff', 'Interpolation');
model.material('mat2').label('Soft Iron (Without Losses)');
model.material('mat2').set('family', 'iron');
model.material('mat2').propertyGroup('def').set('electricconductivity', {'0[S/m]' '0' '0' '0' '0[S/m]' '0' '0' '0' '0[S/m]'});
model.material('mat2').propertyGroup('def').set('relpermittivity', {'1' '0' '0' '0' '1' '0' '0' '0' '1'});
model.material('mat2').propertyGroup('BHCurve').label('B-H Curve');
model.material('mat2').propertyGroup('BHCurve').func('BH').label('Interpolation 1');
model.material('mat2').propertyGroup('BHCurve').func('BH').set('table', {'0' '0';  ...
'663.146' '1';  ...
'1067.5' '1.1';  ...
'1705.23' '1.2';  ...
'2463.11' '1.3';  ...
'3841.67' '1.4';  ...
'5425.74' '1.5';  ...
'7957.75' '1.6';  ...
'12298.3' '1.7';  ...
'20462.8' '1.8';  ...
'32169.6' '1.9';  ...
'61213.4' '2';  ...
'111408' '2.1';  ...
'188487.757' '2.2';  ...
'267930.364' '2.3';  ...
'347507.836' '2.4'});
model.material('mat2').propertyGroup('BHCurve').func('BH').set('extrap', 'linear');
model.material('mat2').propertyGroup('BHCurve').func('BH').set('fununit', {'T'});
model.material('mat2').propertyGroup('BHCurve').func('BH').set('argunit', {'A/m'});
model.material('mat2').propertyGroup('BHCurve').func('BH').set('defineinv', true);
model.material('mat2').propertyGroup('BHCurve').func('BH').set('defineprimfun', true);
model.material('mat2').propertyGroup('BHCurve').set('normB', 'BH(normHin)');
model.material('mat2').propertyGroup('BHCurve').set('normH', 'BH_inv(normBin)');
model.material('mat2').propertyGroup('BHCurve').set('Wpm', 'BH_prim(normHin)');
model.material('mat2').propertyGroup('BHCurve').descr('normHin', 'Magnetic field norm');
model.material('mat2').propertyGroup('BHCurve').descr('normBin', 'Magnetic flux density norm');
model.material('mat2').propertyGroup('BHCurve').addInput('magneticfield');
model.material('mat2').propertyGroup('BHCurve').addInput('magneticfluxdensity');
model.material('mat2').propertyGroup('EffectiveBHCurve').label('Effective B-H Curve');
model.material('mat2').propertyGroup('EffectiveBHCurve').func('BHeff').label('Interpolation 1');
model.material('mat2').propertyGroup('EffectiveBHCurve').func('BHeff').set('table', {'0' '0';  ...
'663.146' '1.000000051691021';  ...
'1067.5' '1.4936495124126294';  ...
'1705.23' '1.9415328461315795';  ...
'2463.11' '2.257765669366018';  ...
'3841.67' '2.609980642431287';  ...
'5425.74' '2.8664452090837504';  ...
'7957.75' '3.1441438097176118';  ...
'12298.3' '3.448538051654125';  ...
'20462.8' '3.7816711973679054';  ...
'32169.6' '4.058345590113038';  ...
'61213.4' '4.420646552950275';  ...
'111408' '4.721274089545955';  ...
'188487.757' '4.972148140718701';  ...
'267930.364' '5.145510860855953';  ...
'347507.836' '5.245510861426532'});
model.material('mat2').propertyGroup('EffectiveBHCurve').func('BHeff').set('extrap', 'linear');
model.material('mat2').propertyGroup('EffectiveBHCurve').func('BHeff').set('fununit', {'T'});
model.material('mat2').propertyGroup('EffectiveBHCurve').func('BHeff').set('argunit', {'A/m'});
model.material('mat2').propertyGroup('EffectiveBHCurve').func('BHeff').set('defineinv', true);
model.material('mat2').propertyGroup('EffectiveBHCurve').set('normBeff', 'BHeff(normHeffin)');
model.material('mat2').propertyGroup('EffectiveBHCurve').set('normHeff', 'BHeff_inv(normBeffin)');
model.material('mat2').propertyGroup('EffectiveBHCurve').descr('normHeffin', 'Effective magnetic field norm');
model.material('mat2').propertyGroup('EffectiveBHCurve').descr('normBeffin', 'Effective magnetic flux density norm');
model.material('mat2').propertyGroup('EffectiveBHCurve').addInput('magneticfield');
model.material('mat2').propertyGroup('EffectiveBHCurve').addInput('magneticfluxdensity');
model.material.create('mat3', 'Common', 'comp1');
model.material('mat3').propertyGroup.create('RemanentFluxDensity', 'Remanent flux density');
model.material('mat3').label('N50 (Sintered NdFeB)');
model.material('mat3').set('family', 'chrome');
model.material('mat3').propertyGroup('def').set('electricconductivity', {'1/1.4[uohm*m]' '0' '0' '0' '1/1.4[uohm*m]' '0' '0' '0' '1/1.4[uohm*m]'});
model.material('mat3').propertyGroup('def').set('relpermittivity', {'1' '0' '0' '0' '1' '0' '0' '0' '1'});
model.material('mat3').propertyGroup('RemanentFluxDensity').set('murec', {'1.05' '0' '0' '0' '1.05' '0' '0' '0' '1.05'});
model.material('mat3').propertyGroup('RemanentFluxDensity').set('normBr', '1.41[T]');
model.material.create('mat4', 'Common', 'comp1');
model.material('mat4').propertyGroup.create('Enu', 'Young''s modulus and Poisson''s ratio');
model.material('mat4').propertyGroup.create('Murnaghan', 'Murnaghan');
model.material('mat4').label('Aluminum');
model.material('mat4').set('family', 'aluminum');
model.material('mat4').propertyGroup('def').set('relpermeability', {'1' '0' '0' '0' '1' '0' '0' '0' '1'});
model.material('mat4').propertyGroup('def').set('heatcapacity', '900[J/(kg*K)]');
model.material('mat4').propertyGroup('def').set('thermalconductivity', {'238[W/(m*K)]' '0' '0' '0' '238[W/(m*K)]' '0' '0' '0' '238[W/(m*K)]'});
model.material('mat4').propertyGroup('def').set('electricconductivity', {'3.774e7[S/m]' '0' '0' '0' '3.774e7[S/m]' '0' '0' '0' '3.774e7[S/m]'});
model.material('mat4').propertyGroup('def').set('relpermittivity', {'1' '0' '0' '0' '1' '0' '0' '0' '1'});
model.material('mat4').propertyGroup('def').set('thermalexpansioncoefficient', {'23e-6[1/K]' '0' '0' '0' '23e-6[1/K]' '0' '0' '0' '23e-6[1/K]'});
model.material('mat4').propertyGroup('def').set('density', '2700[kg/m^3]');
model.material('mat4').propertyGroup('Enu').set('E', '70[GPa]');
model.material('mat4').propertyGroup('Enu').set('nu', '0.33');
model.material('mat4').propertyGroup('Murnaghan').set('l', '-250[GPa]');
model.material('mat4').propertyGroup('Murnaghan').set('m', '-330[GPa]');
model.material('mat4').propertyGroup('Murnaghan').set('n', '-350[GPa]');
model.material.create('mat5', 'Common', 'comp1');
model.material('mat5').propertyGroup.create('Enu', 'Young''s modulus and Poisson''s ratio');
model.material('mat5').propertyGroup('Enu').func.create('int1', 'Interpolation');
model.material('mat5').propertyGroup('Enu').func.create('int2', 'Interpolation');
model.material('mat5').propertyGroup.create('Murnaghan', 'Murnaghan');
model.material('mat5').propertyGroup.create('ElastoplasticModel', 'Elastoplastic material model');
model.material('mat5').propertyGroup('ElastoplasticModel').func.create('int1', 'Interpolation');
model.material('mat5').propertyGroup.create('Ludwik', 'Ludwik');
model.material('mat5').propertyGroup('Ludwik').func.create('int1', 'Interpolation');
model.material('mat5').propertyGroup.create('JohnsonCook', 'Johnson-Cook');
model.material('mat5').propertyGroup.create('Swift', 'Swift');
model.material('mat5').propertyGroup.create('Voce', 'Voce');
model.material('mat5').propertyGroup('Voce').func.create('int1', 'Interpolation');
model.material('mat5').propertyGroup.create('HockettSherby', 'Hockett-Sherby');
model.material('mat5').propertyGroup('HockettSherby').func.create('int1', 'Interpolation');
model.material('mat5').propertyGroup.create('ArmstrongFrederick', 'Armstrong-Frederick');
model.material('mat5').propertyGroup('ArmstrongFrederick').func.create('int1', 'Interpolation');
model.material('mat5').propertyGroup.create('Norton', 'Norton');
model.material('mat5').propertyGroup.create('Garofalo', 'Garofalo (hyperbolic sine)');
model.material('mat5').propertyGroup.create('ChabocheViscoplasticity', 'Chaboche viscoplasticity');
model.material('mat5').label('Structural steel');
model.material('mat5').set('family', 'custom');
model.material('mat5').set('customspecular', [0.7843137254901961 0.7843137254901961 0.7843137254901961]);
model.material('mat5').set('customdiffuse', [0.6666666666666666 0.6666666666666666 0.6666666666666666]);
model.material('mat5').set('customambient', [0.6666666666666666 0.6666666666666666 0.6666666666666666]);
model.material('mat5').set('noise', true);
model.material('mat5').set('fresnel', 0.9);
model.material('mat5').set('roughness', 0.3);
model.material('mat5').set('metallic', 0);
model.material('mat5').set('pearl', 0);
model.material('mat5').set('diffusewrap', 0);
model.material('mat5').set('clearcoat', 0);
model.material('mat5').set('reflectance', 0);
model.material('mat5').propertyGroup('def').set('lossfactor', '0.02');
model.material('mat5').propertyGroup('def').set('relpermeability', {'1' '0' '0' '0' '1' '0' '0' '0' '1'});
model.material('mat5').propertyGroup('def').set('heatcapacity', '475[J/(kg*K)]');
model.material('mat5').propertyGroup('def').set('thermalconductivity', {'44.5[W/(m*K)]' '0' '0' '0' '44.5[W/(m*K)]' '0' '0' '0' '44.5[W/(m*K)]'});
model.material('mat5').propertyGroup('def').set('electricconductivity', {'4.032e6[S/m]' '0' '0' '0' '4.032e6[S/m]' '0' '0' '0' '4.032e6[S/m]'});
model.material('mat5').propertyGroup('def').set('relpermittivity', {'1' '0' '0' '0' '1' '0' '0' '0' '1'});
model.material('mat5').propertyGroup('def').set('thermalexpansioncoefficient', {'12.3e-6[1/K]' '0' '0' '0' '12.3e-6[1/K]' '0' '0' '0' '12.3e-6[1/K]'});
model.material('mat5').propertyGroup('def').set('density', '7850[kg/m^3]');
model.material('mat5').propertyGroup('Enu').func('int1').set('funcname', 'E');
model.material('mat5').propertyGroup('Enu').func('int1').set('table', {'293.15' '200e9'; '793.15' '166.6e9'});
model.material('mat5').propertyGroup('Enu').func('int1').set('extrap', 'linear');
model.material('mat5').propertyGroup('Enu').func('int1').set('fununit', {'Pa'});
model.material('mat5').propertyGroup('Enu').func('int1').set('argunit', {'K'});
model.material('mat5').propertyGroup('Enu').func('int2').set('funcname', 'nu');
model.material('mat5').propertyGroup('Enu').func('int2').set('table', {'293.15' '0.30'; '793.15' '0.315'});
model.material('mat5').propertyGroup('Enu').func('int2').set('extrap', 'linear');
model.material('mat5').propertyGroup('Enu').func('int2').set('fununit', {'1'});
model.material('mat5').propertyGroup('Enu').func('int2').set('argunit', {'K'});
model.material('mat5').propertyGroup('Enu').set('E', 'E(T)');
model.material('mat5').propertyGroup('Enu').set('nu', 'nu(T)');
model.material('mat5').propertyGroup('Enu').addInput('temperature');
model.material('mat5').propertyGroup('Murnaghan').set('l', '-3.0e11[Pa]');
model.material('mat5').propertyGroup('Murnaghan').set('m', '-6.2e11[Pa]');
model.material('mat5').propertyGroup('Murnaghan').set('n', '-7.2e11[Pa]');
model.material('mat5').propertyGroup('ElastoplasticModel').func('int1').set('funcname', 'a');
model.material('mat5').propertyGroup('ElastoplasticModel').func('int1').set('table', {'600' '1'; '1100' '0.1'; '1643' '0'});
model.material('mat5').propertyGroup('ElastoplasticModel').func('int1').set('fununit', {'1'});
model.material('mat5').propertyGroup('ElastoplasticModel').func('int1').set('argunit', {'K'});
model.material('mat5').propertyGroup('ElastoplasticModel').set('sigmags', '350[MPa]*a(T)');
model.material('mat5').propertyGroup('ElastoplasticModel').set('Et', '1.045[GPa]*a(T)');
model.material('mat5').propertyGroup('ElastoplasticModel').set('Ek', '1.045[GPa]*a(T)');
model.material('mat5').propertyGroup('ElastoplasticModel').set('sigmagh', '1.050[GPa]*epe*a(T)');
model.material('mat5').propertyGroup('ElastoplasticModel').addInput('temperature');
model.material('mat5').propertyGroup('ElastoplasticModel').addInput('effectiveplasticstrain');
model.material('mat5').propertyGroup('Ludwik').func('int1').set('funcname', 'a');
model.material('mat5').propertyGroup('Ludwik').func('int1').set('table', {'600' '1'; '1100' '0.1'; '1643' '0'});
model.material('mat5').propertyGroup('Ludwik').func('int1').set('fununit', {'1'});
model.material('mat5').propertyGroup('Ludwik').func('int1').set('argunit', {'K'});
model.material('mat5').propertyGroup('Ludwik').set('k_lud', '560[MPa]*a(T)');
model.material('mat5').propertyGroup('Ludwik').set('n_lud', '0.61');
model.material('mat5').propertyGroup('Ludwik').addInput('temperature');
model.material('mat5').propertyGroup('JohnsonCook').set('k_jcook', '560[MPa]');
model.material('mat5').propertyGroup('JohnsonCook').set('n_jcook', '0.61');
model.material('mat5').propertyGroup('JohnsonCook').set('C_jcook', '0.12');
model.material('mat5').propertyGroup('JohnsonCook').set('epet0_jcook', '1[1/s]');
model.material('mat5').propertyGroup('JohnsonCook').set('m_jcook', '0.6');
model.material('mat5').propertyGroup('Swift').set('e0_swi', '0.021');
model.material('mat5').propertyGroup('Swift').set('n_swi', '0.2');
model.material('mat5').propertyGroup('Voce').func('int1').set('funcname', 'a');
model.material('mat5').propertyGroup('Voce').func('int1').set('table', {'600' '1'; '1100' '0.1'; '1643' '0'});
model.material('mat5').propertyGroup('Voce').func('int1').set('fununit', {'1'});
model.material('mat5').propertyGroup('Voce').func('int1').set('argunit', {'K'});
model.material('mat5').propertyGroup('Voce').set('sigma_voc', '249[MPa]*a(T)');
model.material('mat5').propertyGroup('Voce').set('beta_voc', '9.3');
model.material('mat5').propertyGroup('Voce').addInput('temperature');
model.material('mat5').propertyGroup('HockettSherby').func('int1').set('funcname', 'a');
model.material('mat5').propertyGroup('HockettSherby').func('int1').set('table', {'600' '1'; '1100' '0.1'; '1643' '0'});
model.material('mat5').propertyGroup('HockettSherby').func('int1').set('fununit', {'1'});
model.material('mat5').propertyGroup('HockettSherby').func('int1').set('argunit', {'K'});
model.material('mat5').propertyGroup('HockettSherby').set('sigma_hoc', '684[MPa]*a(T)');
model.material('mat5').propertyGroup('HockettSherby').set('m_hoc', '3.9');
model.material('mat5').propertyGroup('HockettSherby').set('n_hoc', '0.85');
model.material('mat5').propertyGroup('HockettSherby').addInput('temperature');
model.material('mat5').propertyGroup('ArmstrongFrederick').func('int1').set('funcname', 'a');
model.material('mat5').propertyGroup('ArmstrongFrederick').func('int1').set('table', {'600' '1'; '1100' '0.1'; '1643' '0'});
model.material('mat5').propertyGroup('ArmstrongFrederick').func('int1').set('fununit', {'1'});
model.material('mat5').propertyGroup('ArmstrongFrederick').func('int1').set('argunit', {'K'});
model.material('mat5').propertyGroup('ArmstrongFrederick').set('Ck', '2.070[GPa]*a(T)');
model.material('mat5').propertyGroup('ArmstrongFrederick').set('gammak', '8.0');
model.material('mat5').propertyGroup('ArmstrongFrederick').addInput('temperature');
model.material('mat5').propertyGroup('Norton').set('A_nor', '1.2e-15[1/s]');
model.material('mat5').propertyGroup('Norton').set('sigRef_nor', '1[MPa]');
model.material('mat5').propertyGroup('Norton').set('n_nor', '4.5');
model.material('mat5').propertyGroup('Garofalo').set('A_gar', '1e-6[1/s]');
model.material('mat5').propertyGroup('Garofalo').set('sigRef_gar', '100[MPa]');
model.material('mat5').propertyGroup('Garofalo').set('n_gar', '4.6');
model.material('mat5').propertyGroup('ChabocheViscoplasticity').set('A_cha', '1');
model.material('mat5').propertyGroup('ChabocheViscoplasticity').set('sigRef_cha', '490[MPa]');
model.material('mat5').propertyGroup('ChabocheViscoplasticity').set('n_cha', '9');
model.material.create('mat6', 'Common', 'comp1');
model.material('mat6').propertyGroup.create('Enu', 'Young''s modulus and Poisson''s ratio');
model.material('mat6').propertyGroup.create('linzRes', 'Linearized resistivity');
model.material('mat6').label('Copper');
model.material('mat6').set('family', 'copper');
model.material('mat6').propertyGroup('def').set('relpermeability', {'1' '0' '0' '0' '1' '0' '0' '0' '1'});
model.material('mat6').propertyGroup('def').set('electricconductivity', {'5.998e7[S/m]' '0' '0' '0' '5.998e7[S/m]' '0' '0' '0' '5.998e7[S/m]'});
model.material('mat6').propertyGroup('def').set('thermalexpansioncoefficient', {'17e-6[1/K]' '0' '0' '0' '17e-6[1/K]' '0' '0' '0' '17e-6[1/K]'});
model.material('mat6').propertyGroup('def').set('heatcapacity', '385[J/(kg*K)]');
model.material('mat6').propertyGroup('def').set('relpermittivity', {'1' '0' '0' '0' '1' '0' '0' '0' '1'});
model.material('mat6').propertyGroup('def').set('density', '8960[kg/m^3]');
model.material('mat6').propertyGroup('def').set('thermalconductivity', {'400[W/(m*K)]' '0' '0' '0' '400[W/(m*K)]' '0' '0' '0' '400[W/(m*K)]'});
model.material('mat6').propertyGroup('Enu').set('E', '110[GPa]');
model.material('mat6').propertyGroup('Enu').set('nu', '0.35');
model.material('mat6').propertyGroup('linzRes').set('rho0', '1.72e-8[ohm*m]');
model.material('mat6').propertyGroup('linzRes').set('alpha', '0.0039[1/K]');
model.material('mat6').propertyGroup('linzRes').set('Tref', '298[K]');
model.material('mat6').propertyGroup('linzRes').addInput('temperature');
model.material('mat2').selection.set([4 12]);
model.material('mat2').propertyGroup('def').set('electricconductivity', {'1[S/m]'});
model.material('mat3').label('Magnet');
model.material('mat3').selection.set([14]);
model.material('mat3').propertyGroup('def').set('electricconductivity', {'7e5'});
model.material('mat3').propertyGroup('RemanentFluxDensity').set('murec', {'1.02'});
model.material('mat3').propertyGroup('RemanentFluxDensity').set('normBr', {'1[T]'});
model.material('mat4').selection.set([1 2 3]);
model.material('mat5').selection.set([13 15 16]);
model.material('mat6').selection.set([7 8 9]);

model.physics('rmm').selection.set([4 5 6 7 8 9 10 11 12 14]);
model.physics('rmm').prop('ShapeProperty').set('order_magneticvectorpotential', 1);
model.physics('rmm').prop('ShapeProperty').set('order_magneticscalarpotential', 1);
model.physics('rmm').create('mfc1', 'MagneticFluxConservation', 3);
model.physics('rmm').feature('mfc1').label('Magnetic Flux Conservation - air');
model.physics('rmm').feature('mfc1').selection.set([5 6 10 11]);
model.physics('rmm').create('mfc2', 'MagneticFluxConservation', 3);
model.physics('rmm').feature('mfc2').label('Magnetic Flux Conservation - iron');
model.physics('rmm').feature('mfc2').selection.set([12]);
model.physics('rmm').feature('mfc2').set('ConstitutiveRelationBH', 'BHCurve');
model.physics('rmm').create('al2', 'AmperesLaw', 3);
model.physics('rmm').feature('al2').label(['Amp' native2unicode(hex2dec({'00' 'e8'}), 'unicode') 're''s Law - stator core']);
model.physics('rmm').feature('al2').selection.set([4]);
model.physics('rmm').feature('al2').set('ConstitutiveRelationBH', 'BHCurve');
model.physics('rmm').feature('al2').create('loss1', 'LossCalculation', 3);
model.physics('rmm').feature('al2').feature('loss1').set('LossModel', 'Steinmetz');
model.physics('rmm').create('cmag1', 'ConductingMagnet', 3);
model.physics('rmm').feature('cmag1').selection.set([14]);
model.physics('rmm').feature('cmag1').create('loss1', 'LossCalculation', 3);
model.physics('rmm').feature('cmag1').feature('north1').selection.set([100]);
model.physics('rmm').feature('cmag1').feature('south1').selection.set([99]);
model.physics('rmm').create('coil1', 'Coil', 3);
model.physics('rmm').feature('coil1').selection.set([7 8 9]);
model.physics('rmm').feature('coil1').set('ConductorModel', 'Multi');
model.physics('rmm').feature('coil1').set('CoilType', 'Numeric');
model.physics('rmm').feature('coil1').set('ICoil', 'I0*sin(omega*t)');
model.physics('rmm').feature('coil1').set('N', 1);
model.physics('rmm').feature('coil1').set('coilWindArea', 'a_coil');
model.physics('rmm').feature('coil1').create('loss1', 'LossCalculation', 3);
model.physics('rmm').feature('coil1').feature('ccc1').set('fl', 2);
model.physics('rmm').feature('coil1').feature('ccc1').feature('ct1').selection.set([43]);
model.physics('rmm').feature('coil1').feature('ccc1').create('cg1', 'CoilGround', 2);
model.physics('rmm').feature('coil1').feature('ccc1').feature('cg1').selection.set([61]);

model.common.create('rot1', 'RotatingDomain', 'comp1');
model.common('rot1').selection.all;
model.common('rot1').selection.set([10 11 12 14]);
model.common('rot1').set('rotationAngle', 'omega_rotor*t');
model.common('rot1').set('rotationAxis', {'0' '0' '-1'});

model.physics('rmm').create('fcal1', 'ForceCalculation', 3);
model.physics('rmm').feature('fcal1').selection.set([12 14]);
model.physics('rmm').create('gfa1', 'GaugeFixingA', 3);
model.physics('rmm').create('pc1', 'PeriodicCondition', 2);
model.physics('rmm').feature('pc1').selection.set([26 32 71 72]);
model.physics('rmm').feature('pc1').set('PeriodicType', 'AntiPeriodicity');
model.physics('rmm').feature.duplicate('pc2', 'pc1');
model.physics('rmm').feature('pc2').selection.set([23 73]);
model.physics('rmm').feature.duplicate('pc3', 'pc2');
model.physics('rmm').feature('pc3').selection.set([74 78 82 113 114 115]);
model.physics('rmm').create('ssc1', 'SectorSymmetry', 2);
model.physics('rmm').feature('ssc1').set('pairs', {'ap3'});
model.physics('rmm').feature('ssc1').set('nsector', 'n_sectors');
model.physics('rmm').feature('ssc1').set('PeriodicType', 'AntiPeriodicity');
model.physics('rmm').feature('ssc1').set('constraintOptions', 'weakConstraints');
model.physics('rmm').create('ark1', 'ArkkioTorqueCalculation', 3);

model.cpl.create('intop1', 'Integration', 'geom1');
model.cpl('intop1').set('axisym', true);
model.cpl('intop1').label('Integration - Magnet');
model.cpl('intop1').set('opname', 'intop1_magnet');
model.cpl('intop1').selection.set([14]);
model.cpl.duplicate('intop2', 'intop1');
model.cpl('intop2').label('Integration - Coil');
model.cpl('intop2').set('opname', 'intop2_coil');
model.cpl('intop2').selection.set([7 8 9]);

model.probe.create('var1', 'GlobalVariable');
model.probe('var1').model('comp1');
model.probe('var1').label('Global Variable Probe 1 - Torque');
model.probe('var1').set('expr', 'rmm.Tax_0*n_sectors*2');
model.probe('var1').set('descractive', true);
model.probe('var1').set('descr', 'Axial Torque (N*m)');
model.probe.duplicate('var2', 'var1');
model.probe('var2').label('Global Variable Probe 2 - Arkkio''s Torque method');
model.probe('var2').set('expr', 'rmm.Tark_1*2');
model.probe('var2').set('descr', 'Arkkio''s Torque Method (N*m)');
model.probe.create('var3', 'GlobalVariable');
model.probe('var3').model('comp1');
model.probe('var3').label('Global Variable Probe 3 - Magnet Loss');
model.probe('var3').set('expr', 'intop1_magnet(rmm.Qh)*n_sectors*2');
model.probe('var3').set('descractive', true);
model.probe('var3').set('descr', 'Losses in Magnets (W)');
model.probe('var3').set('window', 'new');
model.probe.duplicate('var4', 'var3');
model.probe('var4').label('Global Variable Probe 4 - Coil Loss');
model.probe('var4').set('expr', 'intop2_coil(rmm.Qh)*n_sectors*2');
model.probe('var4').set('descr', 'Losses in Coils (W)');

model.mesh('mesh1').autoMeshSize(4);
model.mesh('mesh1').automatic(false);
model.mesh('mesh1').run('size');
model.mesh('mesh1').create('size1', 'Size');
model.mesh('mesh1').feature('size1').selection.geom('geom1', 2);
model.mesh('mesh1').feature('size1').selection.set([92 100 109]);
model.mesh('mesh1').feature('size1').set('custom', true);
model.mesh('mesh1').feature('size1').set('hmaxactive', true);
model.mesh('mesh1').feature('size1').set('hmax', '0.0005');
model.mesh('mesh1').run('size1');
model.mesh('mesh1').create('ftri1', 'FreeTri');
model.mesh('mesh1').feature('ftri1').selection.set([36]);
model.mesh('mesh1').feature('ftri1').create('size1', 'Size');
model.mesh('mesh1').feature('ftri1').feature('size1').set('custom', true);
model.mesh('mesh1').feature('ftri1').feature('size1').set('hmaxactive', true);
model.mesh('mesh1').feature('ftri1').feature('size1').set('hmax', 0.001);
model.mesh('mesh1').feature.duplicate('ftri2', 'ftri1');
model.mesh('mesh1').feature('ftri2').selection.set([75]);
model.mesh('mesh1').feature('ftri2').feature('size1').set('hmax', '0.001/1.25');
model.mesh('mesh1').run('ftri2');
model.mesh('mesh1').feature.duplicate('ftri3', 'ftri2');
model.mesh('mesh1').feature('ftri3').selection.set([23 26 32 74 78 82]);
model.mesh('mesh1').feature('ftri3').feature('size1').set('custom', false);
model.mesh('mesh1').feature('ftri3').feature('size1').set('hauto', 2);
model.mesh('mesh1').run('ftri3');
model.mesh('mesh1').run('id3');
model.mesh('mesh1').feature('ftet1').selection.set([4 5 6 7 8 9 10 11 12]);
model.mesh('mesh1').feature('ftet1').create('size1', 'Size');
model.mesh('mesh1').feature('ftet1').feature('size1').selection.geom('geom1', 1);
model.mesh('mesh1').feature('ftet1').feature('size1').selection.set([105 124]);
model.mesh('mesh1').feature('ftet1').feature('size1').set('custom', true);
model.mesh('mesh1').feature('ftet1').feature('size1').set('hmaxactive', true);
model.mesh('mesh1').feature('ftet1').feature('size1').set('hmax', '0.001/2');
model.mesh('mesh1').run('ftet1');
model.mesh('mesh1').create('bl1', 'BndLayer');
model.mesh('mesh1').feature('bl1').create('blp', 'BndLayerProp');
model.mesh('mesh1').feature('bl1').selection.geom('geom1', 3);
model.mesh('mesh1').feature('bl1').selection.set([14]);
model.mesh('mesh1').feature('bl1').feature('blp').selection.set([91 92 94 99 100 109 110]);
model.mesh('mesh1').feature('bl1').feature('blp').set('blnlayers', 5);
model.mesh('mesh1').feature('bl1').feature('blp').set('blstretch', 1.8);
model.mesh('mesh1').run('bl1');

model.study('std1').setGenPlots(false);
model.study('std1').create('ccc', 'CoilCurrentCalculation');
model.study('std1').feature.move('ccc', 0);

model.sol.create('sol1');
model.sol('sol1').study('std1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'ccc');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').set('control', 'ccc');
model.sol('sol1').create('s1', 'Stationary');
model.sol('sol1').feature('s1').create('se1', 'Segregated');
model.sol('sol1').feature('s1').feature('se1').feature.remove('ssDef');
model.sol('sol1').feature('s1').feature('se1').create('ss1', 'SegregatedStep');
model.sol('sol1').feature('s1').feature('se1').feature('ss1').set('segvar', {'comp1_rmm_coil1_ccc1_s'});
model.sol('sol1').feature('s1').feature('se1').feature('ss1').set('linsolver', 'dDef');
model.sol('sol1').feature('s1').feature('se1').create('ss2', 'SegregatedStep');
model.sol('sol1').feature('s1').feature('se1').feature('ss2').set('segvar', {'comp1_rmm_coil1_ccc1_p' 'comp1_rmm_coil1_ccc1_lm'});
model.sol('sol1').feature('s1').feature('se1').feature('ss2').set('linsolver', 'dDef');
model.sol('sol1').feature('s1').feature('se1').set('segterm', 'itertol');
model.sol('sol1').feature('s1').feature('se1').set('segiter', 6);
model.sol('sol1').feature('s1').feature.remove('fcDef');
model.sol('sol1').create('su1', 'StoreSolution');
model.sol('sol1').create('st2', 'StudyStep');
model.sol('sol1').feature('st2').set('study', 'std1');
model.sol('sol1').feature('st2').set('studystep', 'stat');
model.sol('sol1').create('v2', 'Variables');
model.sol('sol1').feature('v2').set('initmethod', 'sol');
model.sol('sol1').feature('v2').set('initsol', 'sol1');
model.sol('sol1').feature('v2').set('notsolmethod', 'sol');
model.sol('sol1').feature('v2').set('notsol', 'sol1');
model.sol('sol1').feature('v2').set('control', 'stat');
model.sol('sol1').create('s2', 'Stationary');
model.sol('sol1').feature('s2').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('s2').feature('fc1').set('jtech', 'once');
model.sol('sol1').feature('s2').feature('fc1').set('maxiter', 100);
model.sol('sol1').feature('s2').feature('fc1').set('ntolfact', 1);
model.sol('sol1').feature('s2').feature('fc1').set('linsolver', 'dDef');
model.sol('sol1').feature('s2').feature('fc1').set('jtech', 'once');
model.sol('sol1').feature('s2').feature('fc1').set('maxiter', 100);
model.sol('sol1').feature('s2').feature('fc1').set('ntolfact', 1);
model.sol('sol1').feature('s2').feature.remove('fcDef');
model.sol('sol1').feature('v2').set('notsolnum', 'auto');
model.sol('sol1').feature('v2').set('notsolvertype', 'solnum');
model.sol('sol1').feature('v2').set('solnum', 'auto');
model.sol('sol1').feature('v2').set('solvertype', 'solnum');
model.sol('sol1').attach('std1');
model.sol('sol1').feature('s2').set('stol', '1e-6');

model.probe('var1').genResult('none');
model.probe('var2').genResult('none');
model.probe('var3').genResult('none');
model.probe('var4').genResult('none');

model.sol('sol1').runAll;

model.result.create('pg4', 'PlotGroup3D');
model.result('pg4').run;
model.result('pg4').label('Magnetic Flux Density (stationary)');
model.result('pg4').set('frametype', 'spatial');
model.result('pg4').create('vol1', 'Volume');
model.result('pg4').run;
model.result('pg4').create('arws1', 'ArrowSurface');
model.result('pg4').feature('arws1').set('arrowcount', 2000);
model.result('pg4').feature('arws1').set('color', 'black');
model.result('pg4').run;

model.study.create('std2');
model.study('std2').create('time', 'Transient');
model.study('std2').feature('time').setSolveFor('/physics/rmm', true);
model.study('std2').setGenPlots(false);
model.study('std2').feature('time').set('tlist', 'range(0,time_one_cycle/25,1.5*time_one_cycle)');
model.study('std2').feature('time').set('useinitsol', true);
model.study('std2').feature('time').set('initmethod', 'sol');
model.study('std2').feature('time').set('initstudy', 'std1');
model.study('std2').feature('time').set('usesol', true);
model.study('std2').feature('time').set('notsolmethod', 'sol');
model.study('std2').feature('time').set('notstudy', 'std1');

model.sol.create('sol3');
model.sol('sol3').study('std2');
model.sol('sol3').create('st1', 'StudyStep');
model.sol('sol3').feature('st1').set('study', 'std2');
model.sol('sol3').feature('st1').set('studystep', 'time');
model.sol('sol3').create('v1', 'Variables');
model.sol('sol3').feature('v1').set('control', 'time');
model.sol('sol3').create('t1', 'Time');
model.sol('sol3').feature('t1').set('tlist', 'range(0,time_one_cycle/25,1.5*time_one_cycle)');
model.sol('sol3').feature('t1').set('plot', 'off');
model.sol('sol3').feature('t1').set('plotgroup', 'pg1');
model.sol('sol3').feature('t1').set('plotfreq', 'tout');
model.sol('sol3').feature('t1').set('probesel', 'all');
model.sol('sol3').feature('t1').set('probes', {'var1' 'var2' 'var3' 'var4'});
model.sol('sol3').feature('t1').set('probefreq', 'tsteps');
model.sol('sol3').feature('t1').set('tout', 'tstepsclosest');
model.sol('sol3').feature('t1').set('atolglobalvaluemethod', 'factor');
model.sol('sol3').feature('t1').set('reacf', true);
model.sol('sol3').feature('t1').set('storeudot', true);
model.sol('sol3').feature('t1').set('tstepsbdf', 'strict');
model.sol('sol3').feature('t1').set('endtimeinterpolation', true);
model.sol('sol3').feature('t1').set('estrat', 'exclude');
model.sol('sol3').feature('t1').set('maxorder', 2);
model.sol('sol3').feature('t1').set('control', 'time');
model.sol('sol3').feature('t1').feature('aDef').set('cachepattern', true);
model.sol('sol3').feature('t1').create('fc1', 'FullyCoupled');
model.sol('sol3').feature('t1').feature('fc1').set('jtech', 'once');
model.sol('sol3').feature('t1').feature('fc1').set('maxiter', 25);
model.sol('sol3').feature('t1').feature('fc1').set('ntolfact', 0.2);
model.sol('sol3').feature('t1').feature('fc1').set('linsolver', 'dDef');
model.sol('sol3').feature('t1').feature('fc1').set('jtech', 'once');
model.sol('sol3').feature('t1').feature('fc1').set('maxiter', 25);
model.sol('sol3').feature('t1').feature('fc1').set('ntolfact', 0.2);
model.sol('sol3').feature('t1').feature.remove('fcDef');
model.sol('sol3').attach('std2');
model.sol('sol3').feature('v1').set('scalemethod', 'none');
model.sol('sol3').feature('t1').feature('dDef').set('linsolver', 'pardiso');
model.sol('sol3').feature('t1').feature('fc1').set('jtech', 'onevery');
model.sol('sol3').feature('t1').feature('fc1').set('maxiter', 8);
model.sol('sol3').feature('t1').feature('fc1').set('ntolfact', '1e-3');

model.result.create('pg5', 'PlotGroup3D');
model.result('pg5').run;
model.result('pg5').label('Current Density, Magnet (transient)');
model.result('pg5').set('data', 'dset4');
model.result('pg5').selection.geom('geom1', 3);
model.result('pg5').selection.geom('geom1', 3);
model.result('pg5').selection.set([14]);
model.result('pg5').create('vol1', 'Volume');
model.result('pg5').feature('vol1').set('expr', 'rmm.normJ');
model.result('pg5').feature('vol1').set('descr', 'Current density norm');
model.result('pg5').run;
model.result('pg5').create('arws1', 'ArrowSurface');
model.result('pg5').feature('arws1').set('expr', {'rmm.Jx' 'rmm.Jy' 'rmm.Jz'});
model.result('pg5').feature('arws1').set('descr', 'Current density (spatial frame)');
model.result('pg5').feature('arws1').set('arrowcount', 400);
model.result('pg5').feature('arws1').set('color', 'black');
model.result('pg5').run;
model.result('pg5').set('frametype', 'spatial');

model.study('std2').feature('time').set('plot', true);
model.study('std2').feature('time').set('plotgroup', 'pg5');

model.probe('var1').genResult('none');
model.probe('var2').genResult('none');
model.probe('var3').genResult('none');
model.probe('var4').genResult('none');

model.sol('sol3').runAll;

model.result('pg5').run;
model.result('pg1').set('window', 'window1');
model.result('pg1').run;
model.result('pg1').label('Torque');
model.result('pg1').set('window', 'window1');
model.result('pg1').run;
model.result('pg2').set('window', 'window2');
model.result('pg2').set('windowtitle', 'Probe Plot 2');
model.result('pg2').run;
model.result('pg2').label('Losses in Magnets');
model.result('pg2').set('window', 'window2');
model.result('pg2').set('windowtitle', 'Probe Plot 2');
model.result('pg2').run;
model.result('pg3').set('window', 'window3');
model.result('pg3').set('windowtitle', 'Probe Plot 3');
model.result('pg3').run;
model.result('pg3').label('Losses in Coils');
model.result('pg3').set('window', 'window3');
model.result('pg3').set('windowtitle', 'Probe Plot 3');
model.result('pg3').run;
model.result.dataset.duplicate('dset5', 'dset4');
model.result.dataset('dset5').selection.geom('geom1', 3);
model.result.dataset('dset5').selection.geom('geom1', 3);
model.result.dataset('dset5').selection.set([4 12 14]);
model.result.create('pg6', 'PlotGroup3D');
model.result('pg6').run;
model.result('pg6').label('Magnetic Flux Density (transient)');
model.result('pg6').set('data', 'dset5');
model.result('pg6').set('frametype', 'spatial');
model.result('pg6').create('vol1', 'Volume');
model.result('pg6').run;
model.result('pg6').create('arws1', 'ArrowSurface');
model.result('pg6').feature('arws1').set('arrowcount', 2000);
model.result('pg6').feature('arws1').set('color', 'black');
model.result('pg6').run;

model.study.create('std3');
model.study('std3').create('emloss', 'TimeToFrequencyLosses');
model.study('std3').feature('emloss').set('fftinputstudy', 'current');
model.study('std3').feature('emloss').set('lossstarttime', '0');
model.study('std3').feature('emloss').set('notsolnum', 'auto');
model.study('std3').feature('emloss').set('outputmap', {});
model.study('std3').feature('emloss').setSolveFor('/physics/rmm', true);
model.study('std3').setGenPlots(false);
model.study('std3').label('Loss Calculation');
model.study('std3').feature('emloss').set('fftinputstudy', 'std2');
model.study('std3').feature('emloss').set('emT0', 'time_one_cycle');
model.study('std3').feature('emloss').set('nharmonics', 12);

model.sol.create('sol4');
model.sol('sol4').study('std3');
model.sol('sol4').create('st1', 'StudyStep');
model.sol('sol4').feature('st1').set('study', 'std3');
model.sol('sol4').feature('st1').set('studystep', 'emloss');
model.sol('sol4').create('v1', 'Variables');
model.sol('sol4').feature('v1').set('control', 'emloss');
model.sol('sol4').create('fft1', 'FFT');
model.sol('sol4').feature('fft1').set('control', 'emloss');
model.sol('sol3').getPVals;

model.study('std3').feature('emloss').set('fftendtime', 0.0016444444444444445);
model.study('std3').feature('emloss').set('fftstarttime', '0.0016444444444444445[s]-((time_one_cycle)[s])');
model.study('std3').feature('emloss').set('fftmaxfreq', '12/((time_one_cycle)[s])');

model.sol('sol4').create('su1', 'StoreSolution');
model.sol('sol4').create('cms1', 'CombineSolution');
model.sol('sol4').feature('cms1').set('soloper', 'gensum');
model.sol('sol4').feature('cms1').setIndex('gensumexpressionactive', 'on', 15);
model.sol('sol4').feature('cms1').setIndex('gensumexpression', 'comp1.rmm.Qloss', 15);
model.sol('sol4').feature('cms1').set('control', 'emloss');
model.sol('sol4').attach('std3');
model.sol('sol4').runAll;

model.result.create('pg7', 'PlotGroup3D');
model.result('pg7').run;
model.result('pg7').label('Loss Density in Magnets');
model.result('pg7').set('data', 'dset6');
model.result('pg7').create('vol1', 'Volume');
model.result('pg7').feature('vol1').set('expr', 'rmm.Qh');
model.result('pg7').feature('vol1').create('sel1', 'Selection');
model.result('pg7').feature('vol1').feature('sel1').selection.set([14]);
model.result('pg7').run;
model.result.numerical.create('int1', 'IntVolume');
model.result.numerical('int1').set('data', 'dset6');
model.result.numerical('int1').selection.set([14]);
model.result.numerical('int1').setIndex('expr', 'rmm.Qh*n_sectors*2', 0);
model.result.numerical('int1').setIndex('descr', 'Total loss power of the magnet', 0);
model.result.table.create('tbl2', 'Table');
model.result.table('tbl2').comments('Volume Integration 1');
model.result.numerical('int1').set('table', 'tbl2');
model.result.numerical('int1').setResult;

model.title('Permanent Magnet Motor in 3D');

model.description(['Permanent magnet (PM) motors are used in many high-end applications, such as in electric and hybrid vehicles. An important design limitation is that the magnets are sensitive to high temperatures, which can occur through heat losses caused by currents, particularly eddy currents.' newline  newline 'In this tutorial, an 18-pole PM motor is modeled in 3D to accurately capture eddy current losses in the magnets. The central part of the geometry, containing the rotor and part of the air gap, is modeled as rotating relative to the coordinate system of the stator. Sector symmetry and axial mirror symmetry are leveraged to reduce the computational effort while still capturing the full 3D behavior of the device.']);

model.mesh.clearMeshes;

model.sol('sol1').clearSolutionData;
model.sol('sol2').clearSolutionData;
model.sol('sol3').clearSolutionData;
model.sol('sol4').clearSolutionData;
model.sol('sol5').clearSolutionData;

model.label('pm_motor_3d.mph');

model.modelNode.label('Components');

out = model;
