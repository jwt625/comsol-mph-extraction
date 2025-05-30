# COMSOL Electromagnetism Examples

This file contains concise, high-level COMSOL model descriptions and MATLAB scripts focused on **Electromagnetism** physics.

**Target Physics Types:** Electrostatics, ElectrostaticsBoundaryElements, ConductiveMedia, ElectricCurrentsShell, ElectricInductionCurrents, InductionCurrents, MagneticFieldFormulation, MagneticFieldsCurrentsOnly, MagneticFieldsNoCurrentsBoundaryElements, MagnetostaticsNoCurrents, ElectromagneticWaves, ElectromagneticWavesBEM, ElectromagneticWavesBeamEnvelopes, ElectromagneticWavesFrequencyDomain, ElectromagneticWavesTransient, TransientElectromagneticWaves, MagneticMachineryTimePeriodic, RotatingMachineryMagnetic

**Total Examples:** 3

---

# Example 1: biased_resonator_3d_modes

**Module:** MEMS_Module_Actuators_biased_resonator_3d_modes  
**Category:** Unknown_Category  
**Physics Category:** Electromagnetism  

## Model Description

This COMSOL model simulates the behavior of an electrostatically actuated MEMS (Microelectromechanical Systems) resonator. The device is driven by a combination of AC and DC bias voltage applied across a parallel plate capacitor. The model aims to compute the deformation of the resonator and analyze its normal mode shapes and frequencies under different DC bias conditions.

The model involves multiphysics coupling between Solid Mechanics and Electrostatics. The Solid Mechanics interface is used to model the structural deformation of the resonator, while the Electrostatics interface is used to model the electric field and potential distribution within the device. The Electromechanical Forces multiphysics interface is used to couple the structural and electrostatic simulations.

The geometry of the model is 3D and consists of a resonator structure made of polysilicon, which is sandwiched between layers of silicon nitride and silicon oxide. The resonator is anchored to a ground plane and has an electrode attached to it. The geometry also includes air domains surrounding the resonator structure.

Key features of the simulation include:
- Application of DC bias voltage to the electrode
- Fixed constraint at the anchor point of the resonator
- Symmetry boundary conditions applied to reduce the size of the model
- Material properties defined for polysilicon, silicon nitride, silicon oxide, and air
- Meshing of the geometry with appropriate size and refinement settings

The model performs a stationary analysis to compute the deformation of the resonator under the applied DC bias voltage. It also includes an eigenfrequency analysis to determine the normal mode shapes and frequencies of the resonator. Additionally, a parametric study is conducted to analyze the effect of varying the DC bias voltage on the resonant frequency.

The expected results from this model include:
- Displacement field of the resonator under the applied DC bias voltage
- Electric potential distribution within the device
- Normal mode shapes and frequencies of the resonator
- Variation of the resonant frequency with the applied DC bias voltage

These results provide valuable insights into the behavior of the MEMS resonator and can be used to optimize its design and performance for various applications.

## Complete COMSOL MATLAB Code

```matlab
function out = model
%
% biased_resonator_3d_modes.m
%
% Model exported on May 26 2025, 21:30 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/MEMS_Module/Actuators');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 3);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.physics.create('solid', 'SolidMechanics', 'geom1');
model.physics('solid').model('comp1');
model.physics.create('es', 'Electrostatics', 'geom1');
model.physics('es').model('comp1');
model.physics('es').feature('ccn1').set('materialType', {'solid'});
model.physics('es').feature('ccn1').label('Charge Conservation, Solid');

model.multiphysics.create('eme1', 'ElectromechanicalForces', 'geom1', 3);
model.multiphysics('eme1').set('Solid_physics', 'solid');
model.multiphysics('eme1').set('Electrostatics_physics', 'es');

model.common.create('free1', 'DeformingDomain', 'comp1');
model.common('free1').set('smoothingType', 'hyperelastic');
model.common('free1').selection.set([]);
model.common.create('sym1', 'Symmetry', 'comp1');
model.common('sym1').selection.set([]);

model.study.create('std1');
model.study('std1').create('stat', 'Stationary');
model.study('std1').feature('stat').setSolveFor('/physics/solid', true);
model.study('std1').feature('stat').setSolveFor('/physics/es', true);
model.study('std1').feature('stat').setSolveFor('/multiphysics/eme1', true);

model.geom('geom1').insertFile('biased_resonator_3d_geom_sequence.mph', 'geom1');
model.geom('geom1').run('sel2');

model.param.set('Vdc', '35[V]');
model.param.descr('Vdc', 'DC bias voltage');

model.selection.create('sel1', 'Explicit');
model.selection('sel1').model('comp1');
model.selection('sel1').all;
model.selection('sel1').label('All domains');
model.selection.create('box1', 'Box');
model.selection('box1').model('comp1');
model.selection('box1').set('zmin', -2);
model.selection('box1').set('zmax', -1);
model.selection('box1').set('condition', 'inside');
model.selection('box1').set('entitydim', 2);
model.selection('box1').label('Ground Plane');
model.selection.create('box2', 'Box');
model.selection('box2').model('comp1');
model.selection('box2').set('zmin', -1);
model.selection('box2').set('zmax', -0.9);
model.selection('box2').label('Oxide');
model.selection.create('box3', 'Box');
model.selection('box3').model('comp1');
model.selection('box3').set('zmin', -0.4);
model.selection('box3').set('zmax', -0.35);
model.selection('box3').label('Nitride');
model.selection.create('box4', 'Box');
model.selection('box4').model('comp1');
model.selection('box4').set('xmin', -0.1);
model.selection('box4').set('xmax', 0.1);
model.selection('box4').set('ymin', -4.2);
model.selection('box4').set('zmin', -0.15);
model.selection('box4').set('zmax', -0.1);
model.selection('box4').label('Electrode');
model.selection.create('ball1', 'Ball');
model.selection('ball1').model('comp1');
model.selection('ball1').set('posz', 1);
model.selection('ball1').set('r', 0.1);
model.selection.create('box5', 'Box');
model.selection('box5').model('comp1');
model.selection('box5').set('ymax', 4.8);
model.selection('box5').set('zmin', -0.35);
model.selection('box5').set('zmax', 0.05);
model.selection('box5').set('condition', 'inside');
model.selection.duplicate('box6', 'box5');
model.selection('box6').set('xmin', -15);
model.selection('box6').set('xmax', 15);
model.selection.create('dif1', 'Difference');
model.selection('dif1').model('comp1');
model.selection('dif1').set('add', {'ball1' 'box5'});
model.selection('dif1').set('subtract', {'box6'});
model.selection('dif1').label('Resonator');
model.selection.create('uni1', 'Union');
model.selection('uni1').model('comp1');
model.selection('uni1').set('input', {'box4' 'dif1'});
model.selection('uni1').label('PolySi');
model.selection.create('dif2', 'Difference');
model.selection('dif2').model('comp1');
model.selection('dif2').set('add', {'sel1'});
model.selection('dif2').set('subtract', {'box2' 'box3' 'uni1'});
model.selection('dif2').label('Air');
model.selection.create('adj1', 'Adjacent');
model.selection('adj1').model('comp1');
model.selection('adj1').set('input', {'dif1'});
model.selection('adj1').label('Resonator Boundaries');
model.selection.create('adj2', 'Adjacent');
model.selection('adj2').model('comp1');
model.selection('adj2').set('input', {'box4'});
model.selection('adj2').label('Electrode Boundaries');
model.selection.create('adj3', 'Adjacent');
model.selection('adj3').model('comp1');
model.selection('adj3').set('input', {'box3'});
model.selection('adj3').label('Nitride Boundaries');
model.selection.create('adj4', 'Adjacent');
model.selection('adj4').model('comp1');
model.selection('adj4').set('input', {'sel1'});
model.selection('adj4').label('Geometry Exterior Boundaries');
model.selection.create('dif3', 'Difference');
model.selection('dif3').model('comp1');
model.selection('dif3').set('entitydim', 2);
model.selection('dif3').set('add', {'adj1'});
model.selection('dif3').set('subtract', {'adj4'});
model.selection('dif3').label('Resonator Exterior Boundaries');
model.selection.create('dif4', 'Difference');
model.selection('dif4').model('comp1');
model.selection('dif4').set('entitydim', 2);
model.selection('dif4').set('add', {'adj2'});
model.selection('dif4').set('subtract', {'adj4'});
model.selection('dif4').label('Electrode Exterior Boundaries');
model.selection.create('int1', 'Intersection');
model.selection('int1').model('comp1');
model.selection('int1').set('entitydim', 2);
model.selection('int1').set('input', {'adj1' 'adj3'});
model.selection('int1').label('Fixed Boundaries');
model.selection.create('box7', 'Box');
model.selection('box7').model('comp1');
model.selection('box7').set('entitydim', 2);
model.selection('box7').set('xmin', -0.1);
model.selection('box7').set('xmax', 0.1);
model.selection('box7').set('condition', 'inside');
model.selection('box7').label('Symmetry Boundaries');

model.material.create('mat1', 'Common', 'comp1');
model.material('mat1').propertyGroup.create('Enu', 'Young''s modulus and Poisson''s ratio');
model.material('mat1').label('Si - Polycrystalline silicon');
model.material('mat1').set('family', 'custom');
model.material('mat1').set('customspecular', [0.7843137254901961 1 1]);
model.material('mat1').set('customdiffuse', [0.6666666666666666 0.6666666666666666 0.7058823529411765]);
model.material('mat1').set('customambient', [0.6666666666666666 0.6666666666666666 0.7058823529411765]);
model.material('mat1').set('noise', true);
model.material('mat1').set('fresnel', 0.7);
model.material('mat1').set('metallic', 0);
model.material('mat1').set('pearl', 0);
model.material('mat1').set('diffusewrap', 0);
model.material('mat1').set('clearcoat', 0);
model.material('mat1').set('reflectance', 0);
model.material('mat1').propertyGroup('def').set('thermalexpansioncoefficient', {'2.6e-6[1/K]' '0' '0' '0' '2.6e-6[1/K]' '0' '0' '0' '2.6e-6[1/K]'});
model.material('mat1').propertyGroup('def').set('heatcapacity', '678[J/(kg*K)]');
model.material('mat1').propertyGroup('def').set('relpermittivity', {'4.5' '0' '0' '0' '4.5' '0' '0' '0' '4.5'});
model.material('mat1').propertyGroup('def').set('density', '2320[kg/m^3]');
model.material('mat1').propertyGroup('def').set('thermalconductivity', {'34[W/(m*K)]' '0' '0' '0' '34[W/(m*K)]' '0' '0' '0' '34[W/(m*K)]'});
model.material('mat1').propertyGroup('Enu').set('E', '160e9[Pa]');
model.material('mat1').propertyGroup('Enu').set('nu', '0.22');
model.material('mat1').set('family', 'custom');
model.material('mat1').set('lighting', 'cooktorrance');
model.material('mat1').set('fresnel', 0.7);
model.material('mat1').set('roughness', 0.5);
model.material('mat1').set('anisotropy', 0);
model.material('mat1').set('flipanisotropy', false);
model.material('mat1').set('metallic', 0);
model.material('mat1').set('pearl', 0);
model.material('mat1').set('diffusewrap', 0);
model.material('mat1').set('clearcoat', 0);
model.material('mat1').set('reflectance', 0);
model.material('mat1').set('ambient', 'custom');
model.material('mat1').set('customambient', [0.6666666666666666 0.6666666666666666 0.7058823529411765]);
model.material('mat1').set('diffuse', 'custom');
model.material('mat1').set('customdiffuse', [0.6666666666666666 0.6666666666666666 0.7058823529411765]);
model.material('mat1').set('specular', 'custom');
model.material('mat1').set('customspecular', [0.7843137254901961 1 1]);
model.material('mat1').set('noisecolor', 'custom');
model.material('mat1').set('customnoisecolor', [0 0 0]);
model.material('mat1').set('noisescale', 0);
model.material('mat1').set('noise', 'off');
model.material('mat1').set('noisefreq', 1);
model.material('mat1').set('normalnoisebrush', '0');
model.material('mat1').set('normalnoisetype', '0');
model.material('mat1').set('alpha', 1);
model.material('mat1').set('anisotropyaxis', [0 0 1]);
model.material.create('mat2', 'Common', 'comp1');
model.material('mat2').propertyGroup.create('Enu', 'Young''s modulus and Poisson''s ratio');
model.material('mat2').label('Si3N4 - Silicon nitride');
model.material('mat2').propertyGroup('def').set('electricconductivity', {'0[S/m]' '0' '0' '0' '0[S/m]' '0' '0' '0' '0[S/m]'});
model.material('mat2').propertyGroup('def').set('thermalexpansioncoefficient', {'2.3e-6[1/K]' '0' '0' '0' '2.3e-6[1/K]' '0' '0' '0' '2.3e-6[1/K]'});
model.material('mat2').propertyGroup('def').set('heatcapacity', '700[J/(kg*K)]');
model.material('mat2').propertyGroup('def').set('relpermittivity', {'9.7' '0' '0' '0' '9.7' '0' '0' '0' '9.7'});
model.material('mat2').propertyGroup('def').set('density', '3100[kg/m^3]');
model.material('mat2').propertyGroup('def').set('thermalconductivity', {'20[W/(m*K)]' '0' '0' '0' '20[W/(m*K)]' '0' '0' '0' '20[W/(m*K)]'});
model.material('mat2').propertyGroup('Enu').set('E', '250e9[Pa]');
model.material('mat2').propertyGroup('Enu').set('nu', '0.23');
model.material('mat2').set('family', 'plastic');
model.material.create('mat3', 'Common', 'comp1');
model.material('mat3').propertyGroup.create('Enu', 'Young''s modulus and Poisson''s ratio');
model.material('mat3').label('SiO2 - Silicon oxide');
model.material('mat3').propertyGroup('def').set('electricconductivity', {'0[S/m]' '0' '0' '0' '0[S/m]' '0' '0' '0' '0[S/m]'});
model.material('mat3').propertyGroup('def').set('thermalexpansioncoefficient', {'0.5e-6[1/K]' '0' '0' '0' '0.5e-6[1/K]' '0' '0' '0' '0.5e-6[1/K]'});
model.material('mat3').propertyGroup('def').set('heatcapacity', '730[J/(kg*K)]');
model.material('mat3').propertyGroup('def').set('relpermittivity', {'4.2' '0' '0' '0' '4.2' '0' '0' '0' '4.2'});
model.material('mat3').propertyGroup('def').set('density', '2200[kg/m^3]');
model.material('mat3').propertyGroup('def').set('thermalconductivity', {'1.4[W/(m*K)]' '0' '0' '0' '1.4[W/(m*K)]' '0' '0' '0' '1.4[W/(m*K)]'});
model.material('mat3').propertyGroup('Enu').set('E', '70e9[Pa]');
model.material('mat3').propertyGroup('Enu').set('nu', '0.17');
model.material('mat3').set('family', 'plastic');
model.material.create('mat4', 'Common', 'comp1');
model.material('mat4').propertyGroup('def').func.create('eta', 'Piecewise');
model.material('mat4').propertyGroup('def').func.create('Cp', 'Piecewise');
model.material('mat4').propertyGroup('def').func.create('rho', 'Analytic');
model.material('mat4').propertyGroup('def').func.create('k', 'Piecewise');
model.material('mat4').propertyGroup('def').func.create('cs', 'Analytic');
model.material('mat4').propertyGroup('def').func.create('an1', 'Analytic');
model.material('mat4').propertyGroup('def').func.create('an2', 'Analytic');
model.material('mat4').propertyGroup.create('RefractiveIndex', 'Refractive index');
model.material('mat4').propertyGroup.create('NonlinearModel', 'Nonlinear model');
model.material('mat4').propertyGroup.create('idealGas', 'Ideal gas');
model.material('mat4').propertyGroup('idealGas').func.create('Cp', 'Piecewise');
model.material('mat4').label('Air');
model.material('mat4').set('family', 'air');
model.material('mat4').propertyGroup('def').func('eta').set('arg', 'T');
model.material('mat4').propertyGroup('def').func('eta').set('pieces', {'200.0' '1600.0' '-8.38278E-7+8.35717342E-8*T^1-7.69429583E-11*T^2+4.6437266E-14*T^3-1.06585607E-17*T^4'});
model.material('mat4').propertyGroup('def').func('eta').set('argunit', 'K');
model.material('mat4').propertyGroup('def').func('eta').set('fununit', 'Pa*s');
model.material('mat4').propertyGroup('def').func('Cp').set('arg', 'T');
model.material('mat4').propertyGroup('def').func('Cp').set('pieces', {'200.0' '1600.0' '1047.63657-0.372589265*T^1+9.45304214E-4*T^2-6.02409443E-7*T^3+1.2858961E-10*T^4'});
model.material('mat4').propertyGroup('def').func('Cp').set('argunit', 'K');
model.material('mat4').propertyGroup('def').func('Cp').set('fununit', 'J/(kg*K)');
model.material('mat4').propertyGroup('def').func('rho').set('expr', 'pA*0.02897/R_const[K*mol/J]/T');
model.material('mat4').propertyGroup('def').func('rho').set('args', {'pA' 'T'});
model.material('mat4').propertyGroup('def').func('rho').set('fununit', 'kg/m^3');
model.material('mat4').propertyGroup('def').func('rho').set('argunit', {'Pa' 'K'});
model.material('mat4').propertyGroup('def').func('rho').set('plotargs', {'pA' '101325' '101325'; 'T' '273.15' '293.15'});
model.material('mat4').propertyGroup('def').func('k').set('arg', 'T');
model.material('mat4').propertyGroup('def').func('k').set('pieces', {'200.0' '1600.0' '-0.00227583562+1.15480022E-4*T^1-7.90252856E-8*T^2+4.11702505E-11*T^3-7.43864331E-15*T^4'});
model.material('mat4').propertyGroup('def').func('k').set('argunit', 'K');
model.material('mat4').propertyGroup('def').func('k').set('fununit', 'W/(m*K)');
model.material('mat4').propertyGroup('def').func('cs').set('expr', 'sqrt(1.4*R_const[K*mol/J]/0.02897*T)');
model.material('mat4').propertyGroup('def').func('cs').set('args', {'T'});
model.material('mat4').propertyGroup('def').func('cs').set('fununit', 'm/s');
model.material('mat4').propertyGroup('def').func('cs').set('argunit', {'K'});
model.material('mat4').propertyGroup('def').func('cs').set('plotargs', {'T' '273.15' '373.15'});
model.material('mat4').propertyGroup('def').func('an1').set('funcname', 'alpha_p');
model.material('mat4').propertyGroup('def').func('an1').set('expr', '-1/rho(pA,T)*d(rho(pA,T),T)');
model.material('mat4').propertyGroup('def').func('an1').set('args', {'pA' 'T'});
model.material('mat4').propertyGroup('def').func('an1').set('fununit', '1/K');
model.material('mat4').propertyGroup('def').func('an1').set('argunit', {'Pa' 'K'});
model.material('mat4').propertyGroup('def').func('an1').set('plotargs', {'pA' '101325' '101325'; 'T' '273.15' '373.15'});
model.material('mat4').propertyGroup('def').func('an2').set('funcname', 'muB');
model.material('mat4').propertyGroup('def').func('an2').set('expr', '0.6*eta(T)');
model.material('mat4').propertyGroup('def').func('an2').set('args', {'T'});
model.material('mat4').propertyGroup('def').func('an2').set('fununit', 'Pa*s');
model.material('mat4').propertyGroup('def').func('an2').set('argunit', {'K'});
model.material('mat4').propertyGroup('def').func('an2').set('plotargs', {'T' '200' '1600'});
model.material('mat4').propertyGroup('def').set('thermalexpansioncoefficient', '');
model.material('mat4').propertyGroup('def').set('molarmass', '');
model.material('mat4').propertyGroup('def').set('bulkviscosity', '');
model.material('mat4').propertyGroup('def').set('thermalexpansioncoefficient', {'alpha_p(pA,T)' '0' '0' '0' 'alpha_p(pA,T)' '0' '0' '0' 'alpha_p(pA,T)'});
model.material('mat4').propertyGroup('def').set('molarmass', '0.02897[kg/mol]');
model.material('mat4').propertyGroup('def').set('bulkviscosity', 'muB(T)');
model.material('mat4').propertyGroup('def').set('relpermeability', {'1' '0' '0' '0' '1' '0' '0' '0' '1'});
model.material('mat4').propertyGroup('def').set('relpermittivity', {'1' '0' '0' '0' '1' '0' '0' '0' '1'});
model.material('mat4').propertyGroup('def').set('dynamicviscosity', 'eta(T)');
model.material('mat4').propertyGroup('def').set('ratioofspecificheat', '1.4');
model.material('mat4').propertyGroup('def').set('electricconductivity', {'0[S/m]' '0' '0' '0' '0[S/m]' '0' '0' '0' '0[S/m]'});
model.material('mat4').propertyGroup('def').set('heatcapacity', 'Cp(T)');
model.material('mat4').propertyGroup('def').set('density', 'rho(pA,T)');
model.material('mat4').propertyGroup('def').set('thermalconductivity', {'k(T)' '0' '0' '0' 'k(T)' '0' '0' '0' 'k(T)'});
model.material('mat4').propertyGroup('def').set('soundspeed', 'cs(T)');
model.material('mat4').propertyGroup('def').addInput('temperature');
model.material('mat4').propertyGroup('def').addInput('pressure');
model.material('mat4').propertyGroup('RefractiveIndex').set('n', {'1' '0' '0' '0' '1' '0' '0' '0' '1'});
model.material('mat4').propertyGroup('NonlinearModel').set('BA', '(def.gamma+1)/2');
model.material('mat4').propertyGroup('idealGas').func('Cp').label('Piecewise 2');
model.material('mat4').propertyGroup('idealGas').func('Cp').set('arg', 'T');
model.material('mat4').propertyGroup('idealGas').func('Cp').set('pieces', {'200.0' '1600.0' '1047.63657-0.372589265*T^1+9.45304214E-4*T^2-6.02409443E-7*T^3+1.2858961E-10*T^4'});
model.material('mat4').propertyGroup('idealGas').func('Cp').set('argunit', 'K');
model.material('mat4').propertyGroup('idealGas').func('Cp').set('fununit', 'J/(kg*K)');
model.material('mat4').propertyGroup('idealGas').set('Rs', 'R_const/Mn');
model.material('mat4').propertyGroup('idealGas').set('heatcapacity', 'Cp(T)');
model.material('mat4').propertyGroup('idealGas').set('ratioofspecificheat', '1.4');
model.material('mat4').propertyGroup('idealGas').set('molarmass', '0.02897');
model.material('mat4').propertyGroup('idealGas').addInput('temperature');
model.material('mat4').propertyGroup('idealGas').addInput('pressure');
model.material('mat4').materialType('nonSolid');
model.material('mat4').set('family', 'air');
model.material('mat1').selection.named('uni1');
model.material('mat2').selection.named('box3');
model.material('mat3').selection.named('box2');
model.material('mat4').selection.named('dif2');

model.physics('solid').selection.named('dif1');
model.physics('solid').create('fix1', 'Fixed', 2);
model.physics('solid').feature('fix1').selection.named('int1');
model.physics('solid').create('sym1', 'SymmetrySolid', 2);
model.physics('solid').feature('sym1').selection.named('box7');

model.common('free1').selection.named('dif2');
model.common('sym1').selection.named('box7');

model.physics('es').create('ccn2', 'ChargeConservation', 3);
model.physics('es').feature('ccn2').label('Charge Conservation, Air');
model.physics('es').feature('ccn2').selection.named('dif2');
model.physics('es').create('term1', 'DomainTerminal', 3);
model.physics('es').feature('term1').selection.named('dif1');
model.physics('es').feature('term1').set('TerminalType', 'Voltage');
model.physics('es').feature('term1').set('V0', 0);
model.physics('es').create('gnd1', 'Ground', 2);
model.physics('es').feature('gnd1').selection.named('box1');
model.physics('es').create('term2', 'DomainTerminal', 3);
model.physics('es').feature('term2').selection.named('geom1_boxsel4');
model.physics('es').feature('term2').set('TerminalType', 'Voltage');
model.physics('es').feature('term2').set('V0', 'Vdc');

model.mesh('mesh1').create('ftri1', 'FreeTri');
model.mesh('mesh1').feature('ftri1').selection.named('geom1_sel2');
model.mesh('mesh1').run('ftri1');
model.mesh('mesh1').create('swe1', 'Sweep');
model.mesh('mesh1').run('swe1');

model.study('std1').label('Stationary');

model.sol.create('sol1');

model.mesh('mesh1').stat.selection.geom(3);
model.mesh('mesh1').stat.selection.set([3 6 9 12 15 16 17 18 19 20 22 23 24 25 30 31 32 33 34 35 36]);

model.sol('sol1').study('std1');

model.study('std1').feature('stat').set('notlistsolnum', 1);
model.study('std1').feature('stat').set('notsolnum', 'auto');
model.study('std1').feature('stat').set('listsolnum', 1);
model.study('std1').feature('stat').set('solnum', 'auto');

model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'stat');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').feature('comp1_spatial_disp').set('scalemethod', 'manual');
model.sol('sol1').feature('v1').feature('comp1_u').set('scalemethod', 'manual');
model.sol('sol1').feature('v1').feature('comp1_spatial_disp').set('scaleval', '1e-2*4.097926304852248E-5');
model.sol('sol1').feature('v1').feature('comp1_u').set('scaleval', '1e-2*4.097926304852248E-5');
model.sol('sol1').feature('v1').set('control', 'stat');
model.sol('sol1').create('s1', 'Stationary');
model.sol('sol1').feature('s1').feature('aDef').set('cachepattern', true);
model.sol('sol1').feature('s1').create('seDef', 'Segregated');
model.sol('sol1').feature('s1').create('se1', 'Segregated');
model.sol('sol1').feature('s1').feature('se1').feature.remove('ssDef');
model.sol('sol1').feature('s1').feature('se1').create('ss1', 'SegregatedStep');
model.sol('sol1').feature('s1').feature('se1').feature('ss1').set('segvar', {'comp1_V'});
model.sol('sol1').feature('s1').create('d1', 'Direct');
model.sol('sol1').feature('s1').feature('d1').set('linsolver', 'mumps');
model.sol('sol1').feature('s1').feature('se1').feature('ss1').set('linsolver', 'd1');
model.sol('sol1').feature('s1').feature('se1').feature('ss1').label('Electric potential');
model.sol('sol1').feature('s1').feature('se1').create('ss2', 'SegregatedStep');
model.sol('sol1').feature('s1').feature('se1').feature('ss2').set('segvar', {'comp1_u'});
model.sol('sol1').feature('s1').feature('se1').feature('ss2').set('linsolver', 'd1');
model.sol('sol1').feature('s1').feature('se1').feature('ss2').label('Displacement field');
model.sol('sol1').feature('s1').feature('se1').create('ss3', 'SegregatedStep');
model.sol('sol1').feature('s1').feature('se1').feature('ss3').set('segvar', {'comp1_spatial_disp'});
model.sol('sol1').feature('s1').feature('se1').feature('ss3').set('subdtech', 'const');
model.sol('sol1').feature('s1').feature('se1').feature('ss3').set('subjtech', 'onevery');
model.sol('sol1').feature('s1').feature('se1').feature('ss3').set('linsolver', 'd1');
model.sol('sol1').feature('s1').feature('se1').feature('ss3').label('Spatial mesh displacement');
model.sol('sol1').feature('s1').feature('se1').set('segstabacc', 'segaacc');
model.sol('sol1').feature('s1').feature('se1').set('segaaccdim', 5);
model.sol('sol1').feature('s1').create('i1', 'Iterative');
model.sol('sol1').feature('s1').feature('i1').set('linsolver', 'gmres');
model.sol('sol1').feature('s1').feature('i1').set('rhob', 40);
model.sol('sol1').feature('s1').feature('i1').set('nlinnormuse', true);
model.sol('sol1').feature('s1').feature('i1').set('itrestart', 5000);
model.sol('sol1').feature('s1').feature('i1').label('Iterative Solver (GMRES with SA AMG) (eme1)');
model.sol('sol1').feature('s1').feature('i1').create('mg1', 'Multigrid');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').set('hybridization', 'multi');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').set('hybridvar', {'comp1_u' 'comp1_V'});
model.sol('sol1').feature('s1').feature('i1').feature('mg1').set('prefun', 'saamg');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').set('usesmooth', false);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('pr').create('so1', 'SOR');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('pr').feature('so1').set('relax', 0.8);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('po').create('so1', 'SOR');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('po').feature('so1').set('relax', 0.8);
model.sol('sol1').feature('s1').feature('i1').create('dp1', 'DirectPreconditioner');
model.sol('sol1').feature('s1').feature('i1').feature('dp1').set('hybridization', 'multi');
model.sol('sol1').feature('s1').feature('i1').feature('dp1').set('hybridvar', {'comp1_spatial_disp'});
model.sol('sol1').feature('s1').feature.remove('fcDef');
model.sol('sol1').feature('s1').feature.remove('seDef');
model.sol('sol1').attach('std1');

model.result.create('pg1', 'PlotGroup3D');
model.result('pg1').set('data', 'dset1');
model.result('pg1').set('defaultPlotID', 'displacement');
model.result('pg1').label('Displacement (solid)');
model.result('pg1').set('frametype', 'spatial');
model.result('pg1').create('vol1', 'Volume');
model.result('pg1').feature('vol1').set('expr', {'solid.disp'});
model.result('pg1').feature('vol1').set('threshold', 'manual');
model.result('pg1').feature('vol1').set('thresholdvalue', 0.2);
model.result('pg1').feature('vol1').set('resolution', 'custom');
model.result('pg1').feature('vol1').set('refine', 2);
model.result('pg1').feature('vol1').set('colortable', 'SpectrumLight');
model.result.create('pg2', 'PlotGroup3D');
model.result('pg2').label('Electric Potential (es)');
model.result('pg2').set('frametype', 'spatial');
model.result('pg2').set('showlegendsmaxmin', true);
model.result('pg2').set('data', 'dset1');
model.result('pg2').set('defaultPlotID', 'InterfaceComponents/PlotDefaults/icom2/pdef1/pcond2/pcond1/pcond1/pg1');
model.result('pg2').feature.create('mslc1', 'Multislice');
model.result('pg2').feature('mslc1').set('showsolutionparams', 'on');
model.result('pg2').feature('mslc1').set('solutionparams', 'parent');
model.result('pg2').feature('mslc1').set('expr', 'V');
model.result('pg2').feature('mslc1').set('multiplanexmethod', 'coord');
model.result('pg2').feature('mslc1').set('xcoord', 'es.CPx');
model.result('pg2').feature('mslc1').set('multiplaneymethod', 'coord');
model.result('pg2').feature('mslc1').set('ycoord', 'es.CPy');
model.result('pg2').feature('mslc1').set('multiplanezmethod', 'coord');
model.result('pg2').feature('mslc1').set('zcoord', 'es.CPz');
model.result('pg2').feature('mslc1').set('colortable', 'Dipole');
model.result('pg2').feature('mslc1').set('showsolutionparams', 'on');
model.result('pg2').feature('mslc1').set('data', 'parent');
model.result('pg2').feature.create('strmsl1', 'StreamlineMultislice');
model.result('pg2').feature('strmsl1').set('showsolutionparams', 'on');
model.result('pg2').feature('strmsl1').set('solutionparams', 'parent');
model.result('pg2').feature('strmsl1').set('expr', {'es.Ex' 'es.Ey' 'es.Ez'});
model.result('pg2').feature('strmsl1').set('multiplanexmethod', 'coord');
model.result('pg2').feature('strmsl1').set('xcoord', 'es.CPx');
model.result('pg2').feature('strmsl1').set('multiplaneymethod', 'coord');
model.result('pg2').feature('strmsl1').set('ycoord', 'es.CPy');
model.result('pg2').feature('strmsl1').set('multiplanezmethod', 'coord');
model.result('pg2').feature('strmsl1').set('zcoord', 'es.CPz');
model.result('pg2').feature('strmsl1').set('titletype', 'none');
model.result('pg2').feature('strmsl1').set('posmethod', 'uniform');
model.result('pg2').feature('strmsl1').set('udist', 0.02);
model.result('pg2').feature('strmsl1').set('maxlen', 0.4);
model.result('pg2').feature('strmsl1').set('maxtime', Inf);
model.result('pg2').feature('strmsl1').set('inheritcolor', false);
model.result('pg2').feature('strmsl1').set('showsolutionparams', 'on');
model.result('pg2').feature('strmsl1').set('maxtime', Inf);
model.result('pg2').feature('strmsl1').set('showsolutionparams', 'on');
model.result('pg2').feature('strmsl1').set('maxtime', Inf);
model.result('pg2').feature('strmsl1').set('showsolutionparams', 'on');
model.result('pg2').feature('strmsl1').set('maxtime', Inf);
model.result('pg2').feature('strmsl1').set('showsolutionparams', 'on');
model.result('pg2').feature('strmsl1').set('maxtime', Inf);
model.result('pg2').feature('strmsl1').set('data', 'parent');
model.result('pg2').feature('strmsl1').set('inheritplot', 'mslc1');
model.result('pg2').feature('strmsl1').feature.create('col1', 'Color');
model.result('pg2').feature('strmsl1').feature('col1').set('expr', 'V');
model.result('pg2').feature('strmsl1').feature('col1').set('colortable', 'DipoleDark');
model.result('pg2').feature('strmsl1').feature('col1').set('colorlegend', false);
model.result('pg2').feature('strmsl1').feature.create('filt1', 'Filter');
model.result('pg2').feature('strmsl1').feature('filt1').set('expr', '!isScalingSystemDomain');
model.result.create('pg3', 'PlotGroup3D');
model.result('pg3').label('Electric Field Norm (es)');
model.result('pg3').set('frametype', 'spatial');
model.result('pg3').set('showlegendsmaxmin', true);
model.result('pg3').set('data', 'dset1');
model.result('pg3').set('defaultPlotID', 'InterfaceComponents/PlotDefaults/icom3/pdef1/pcond2/pcond1/pg1');
model.result('pg3').feature.create('mslc1', 'Multislice');
model.result('pg3').feature('mslc1').set('showsolutionparams', 'on');
model.result('pg3').feature('mslc1').set('solutionparams', 'parent');
model.result('pg3').feature('mslc1').set('expr', 'es.normE');
model.result('pg3').feature('mslc1').set('multiplanexmethod', 'coord');
model.result('pg3').feature('mslc1').set('xcoord', 'es.CPx');
model.result('pg3').feature('mslc1').set('multiplaneymethod', 'coord');
model.result('pg3').feature('mslc1').set('ycoord', 'es.CPy');
model.result('pg3').feature('mslc1').set('multiplanezmethod', 'coord');
model.result('pg3').feature('mslc1').set('zcoord', 'es.CPz');
model.result('pg3').feature('mslc1').set('colortable', 'Prism');
model.result('pg3').feature('mslc1').set('colortabletrans', 'nonlinear');
model.result('pg3').feature('mslc1').set('colorcalibration', -0.8);
model.result('pg3').feature('mslc1').set('showsolutionparams', 'on');
model.result('pg3').feature('mslc1').set('data', 'parent');
model.result('pg3').feature.create('strmsl1', 'StreamlineMultislice');
model.result('pg3').feature('strmsl1').set('showsolutionparams', 'on');
model.result('pg3').feature('strmsl1').set('solutionparams', 'parent');
model.result('pg3').feature('strmsl1').set('expr', {'es.Ex' 'es.Ey' 'es.Ez'});
model.result('pg3').feature('strmsl1').set('multiplanexmethod', 'coord');
model.result('pg3').feature('strmsl1').set('xcoord', 'es.CPx');
model.result('pg3').feature('strmsl1').set('multiplaneymethod', 'coord');
model.result('pg3').feature('strmsl1').set('ycoord', 'es.CPy');
model.result('pg3').feature('strmsl1').set('multiplanezmethod', 'coord');
model.result('pg3').feature('strmsl1').set('zcoord', 'es.CPz');
model.result('pg3').feature('strmsl1').set('titletype', 'none');
model.result('pg3').feature('strmsl1').set('posmethod', 'uniform');
model.result('pg3').feature('strmsl1').set('udist', 0.02);
model.result('pg3').feature('strmsl1').set('maxlen', 0.4);
model.result('pg3').feature('strmsl1').set('maxtime', Inf);
model.result('pg3').feature('strmsl1').set('inheritcolor', false);
model.result('pg3').feature('strmsl1').set('showsolutionparams', 'on');
model.result('pg3').feature('strmsl1').set('maxtime', Inf);
model.result('pg3').feature('strmsl1').set('showsolutionparams', 'on');
model.result('pg3').feature('strmsl1').set('maxtime', Inf);
model.result('pg3').feature('strmsl1').set('showsolutionparams', 'on');
model.result('pg3').feature('strmsl1').set('maxtime', Inf);
model.result('pg3').feature('strmsl1').set('showsolutionparams', 'on');
model.result('pg3').feature('strmsl1').set('maxtime', Inf);
model.result('pg3').feature('strmsl1').set('data', 'parent');
model.result('pg3').feature('strmsl1').set('inheritplot', 'mslc1');
model.result('pg3').feature('strmsl1').feature.create('col1', 'Color');
model.result('pg3').feature('strmsl1').feature('col1').set('expr', 'es.normE');
model.result('pg3').feature('strmsl1').feature('col1').set('colortable', 'PrismDark');
model.result('pg3').feature('strmsl1').feature('col1').set('colorlegend', false);
model.result('pg3').feature('strmsl1').feature('col1').set('colortabletrans', 'nonlinear');
model.result('pg3').feature('strmsl1').feature('col1').set('colorcalibration', -0.8);
model.result('pg3').feature('strmsl1').feature.create('filt1', 'Filter');
model.result('pg3').feature('strmsl1').feature('filt1').set('expr', '!isScalingSystemDomain');

model.sol('sol1').runAll;

model.result('pg1').run;
model.result.dataset.create('mir1', 'Mirror3D');
model.result.create('pg4', 'PlotGroup3D');
model.result('pg4').run;
model.result('pg4').set('data', 'mir1');
model.result('pg4').create('vol1', 'Volume');
model.result('pg4').feature('vol1').set('expr', 'w');
model.result('pg4').feature('vol1').set('descr', 'Displacement field, Z-component');
model.result('pg4').feature('vol1').set('colortabletrans', 'reverse');
model.result('pg4').run;
model.result('pg4').create('iso1', 'Isosurface');
model.result('pg4').feature('iso1').set('expr', 'V');
model.result('pg4').feature('iso1').set('descr', 'Electric potential');
model.result('pg4').feature('iso1').set('levelmethod', 'levels');
model.result('pg4').feature('iso1').set('levels', '10 20 30');
model.result('pg4').feature('iso1').set('colortable', 'Traffic');
model.result('pg4').feature('iso1').set('colorlegend', false);
model.result('pg4').run;
model.result('pg4').label('Biased Displacement');

model.view.create('view4', 3);
model.view('view3').set('locked', true);
model.view('view3').camera.set('zoomanglefull', 22);
model.view('view3').camera.setIndex('position', 130.13919, 0);
model.view('view3').camera.setIndex('position', 147.58559, 1);
model.view('view3').camera.setIndex('position', 111.8392, 2);
model.view('view3').camera.setIndex('target', 19.45, 0);
model.view('view3').camera.set('target', [19.45 0 1.15]);
model.view('view3').camera.setIndex('up', 0.3087, 0);
model.view('view3').camera.setIndex('up', 0.4116, 1);
model.view('view3').camera.setIndex('up', 0.85749, 2);
model.view('view3').camera.setIndex('rotationpoint', -19.45, 0);
model.view('view3').camera.setIndex('rotationpoint', 1.15, 2);
model.view('view3').camera.setIndex('viewoffset', -0.2, 0);
model.view('view3').camera.set('viewoffset', [-0.2 -0.1]);

model.result('pg4').run;
model.result('pg4').set('view', 'view3');
model.result('pg4').run;

model.title(['Stationary Analysis of a Biased Resonator ' native2unicode(hex2dec({'20' '14'}), 'unicode') ' 3D']);

model.description('An electrostatically actuated MEMS resonator is simulated. The device is driven by an AC + DC bias voltage applied across a parallel plate capacitor. In this example, the deformation of the resonator is computed with an applied DC bias.');

model.label('biased_resonator_3d_basic.mph');

model.result('pg4').run;

model.geom('geom1').run('ext1');
model.geom('geom1').create('mir1', 'Mirror');
model.geom('geom1').feature('mir1').set('axis', [1 0 0]);
model.geom('geom1').feature('mir1').selection('input').set({'blk1' 'ext1'});
model.geom('geom1').feature('mir1').set('keep', true);
model.geom('geom1').runPre('fin');

model.view('view1').set('renderwireframe', true);

model.geom('geom1').run;

model.func.create('int1', 'Interpolation');
model.func('int1').model('comp1');
model.func('int1').set('source', 'file');
model.func('int1').set('filename', 'biased_resonator_3d_modes_experiment.txt');
model.func('int1').importData;
model.func('int1').setIndex('argunit', 'Hz', 0);
model.func('int1').setIndex('fununit', 'V', 0);
model.func('int1').set('extrap', 'value');
model.func('int1').set('extrapvalue', NaN);

model.physics('solid').feature('sym1').active(false);

model.mesh('mesh1').feature('size').set('custom', true);
model.mesh('mesh1').feature('size').set('hmin', 1);
model.mesh('mesh1').run;

model.study.create('std2');
model.study('std2').create('eig', 'Eigenfrequency');
model.study('std2').feature('eig').set('plotgroup', 'Default');
model.study('std2').feature('eig').set('shift', '1[Hz]');
model.study('std2').feature('eig').set('chkeigregion', true);
model.study('std2').feature('eig').set('conrad', '1');
model.study('std2').feature('eig').set('conradynhm', '1');
model.study('std2').feature('eig').set('storefact', false);
model.study('std2').feature('eig').set('linpsolnum', 'auto');
model.study('std2').feature('eig').set('solnum', 'auto');
model.study('std2').feature('eig').set('notsolnum', 'auto');
model.study('std2').feature('eig').set('outputmap', {});
model.study('std2').feature('eig').set('ngenAUX', '1');
model.study('std2').feature('eig').set('goalngenAUX', '1');
model.study('std2').feature('eig').set('ngenAUX', '1');
model.study('std2').feature('eig').set('goalngenAUX', '1');
model.study('std2').feature('eig').setSolveFor('/physics/solid', true);
model.study('std2').feature('eig').setSolveFor('/physics/es', true);
model.study('std2').feature('eig').setSolveFor('/multiphysics/eme1', true);

model.common.create('mpf1', 'ParticipationFactors', 'comp1');

model.study('std2').feature('eig').set('neigsactive', true);
model.study('std2').feature('eig').set('neigs', 3);
model.study('std2').feature('eig').setEntry('outputmap', 'es', 'none');
model.study('std2').feature('eig').setEntry('outputmap', 'frame:spatial1', 'none');

model.sol.create('sol2');

model.mesh('mesh1').stat.selection.geom(3);
model.mesh('mesh1').stat.selection.set([3 6 9 12 15 16 17 18 19 20 22 23 24 25 30 31 32 33 34 35 36 43 44 45 46 50 51 52 56 58 62 63 64 68 69 70 75 76 77 78 79 80]);

model.sol('sol2').study('std2');
model.sol('sol2').create('st1', 'StudyStep');
model.sol('sol2').feature('st1').set('study', 'std2');
model.sol('sol2').feature('st1').set('studystep', 'eig');
model.sol('sol2').create('v1', 'Variables');
model.sol('sol2').feature('v1').feature('comp1_spatial_disp').set('scalemethod', 'manual');
model.sol('sol2').feature('v1').feature('comp1_u').set('scalemethod', 'manual');
model.sol('sol2').feature('v1').feature('comp1_spatial_disp').set('scaleval', '1e-2*7.886019274640408E-5');
model.sol('sol2').feature('v1').feature('comp1_u').set('scaleval', '1e-2*7.886019274640408E-5');
model.sol('sol2').feature('v1').set('control', 'eig');
model.sol('sol2').create('e1', 'Eigenvalue');
model.sol('sol2').feature('e1').set('eigvfunscale', 'maximum');
model.sol('sol2').feature('e1').set('eigvfunscaleparam', '7.89E-11');
model.sol('sol2').feature('e1').set('storelinpoint', true);
model.sol('sol2').feature('e1').set('control', 'eig');
model.sol('sol2').feature('e1').feature('aDef').set('cachepattern', true);
model.sol('sol2').attach('std2');

model.study('std2').label('Unbiased Eigenfrequency');
model.study('std2').setGenPlots(false);

model.mesh('mesh1').stat.selection.geom(3);
model.mesh('mesh1').stat.selection.set([3 6 9 12 15 16 17 18 19 20 22 23 24 25 30 31 32 33 34 35 36 43 44 45 46 50 51 52 56 58 62 63 64 68 69 70 75 76 77 78 79 80]);

model.sol('sol2').study('std2');
model.sol('sol2').feature.remove('e1');
model.sol('sol2').feature.remove('v1');
model.sol('sol2').feature.remove('st1');
model.sol('sol2').create('st1', 'StudyStep');
model.sol('sol2').feature('st1').set('study', 'std2');
model.sol('sol2').feature('st1').set('studystep', 'eig');
model.sol('sol2').create('v1', 'Variables');
model.sol('sol2').feature('v1').feature('comp1_spatial_disp').set('scalemethod', 'manual');
model.sol('sol2').feature('v1').feature('comp1_u').set('scalemethod', 'manual');
model.sol('sol2').feature('v1').feature('comp1_spatial_disp').set('scaleval', '1e-2*7.886019274640408E-5');
model.sol('sol2').feature('v1').feature('comp1_u').set('scaleval', '1e-2*7.886019274640408E-5');
model.sol('sol2').feature('v1').set('control', 'eig');
model.sol('sol2').create('e1', 'Eigenvalue');
model.sol('sol2').feature('e1').set('eigvfunscale', 'maximum');
model.sol('sol2').feature('e1').set('eigvfunscaleparam', '7.89E-11');
model.sol('sol2').feature('e1').set('storelinpoint', true);
model.sol('sol2').feature('e1').set('control', 'eig');
model.sol('sol2').feature('e1').feature('aDef').set('cachepattern', true);
model.sol('sol2').attach('std2');
model.sol('sol2').runAll;

model.result.dataset('dset2').set('frametype', 'material');
model.result.create('pg5', 'PlotGroup3D');
model.result('pg5').run;
model.result('pg5').set('data', 'dset2');
model.result('pg5').create('vol1', 'Volume');
model.result('pg5').feature('vol1').set('expr', 'solid.disp');
model.result('pg5').feature('vol1').set('descr', 'Displacement magnitude');
model.result('pg5').feature('vol1').set('colorlegend', false);
model.result('pg5').feature('vol1').create('def1', 'Deform');
model.result('pg5').run;
model.result('pg5').run;
model.result('pg5').label('Unbiased Modes');
model.result('pg5').set('looplevel', [2]);
model.result('pg5').run;
model.result('pg5').set('looplevel', [3]);
model.result('pg5').run;

model.study.create('std3');
model.study('std3').create('stat', 'Stationary');
model.study('std3').feature('stat').set('plotgroup', 'Default');
model.study('std3').feature('stat').set('outputmap', {});
model.study('std3').feature('stat').set('ngenAUX', '1');
model.study('std3').feature('stat').set('goalngenAUX', '1');
model.study('std3').feature('stat').set('ngenAUX', '1');
model.study('std3').feature('stat').set('goalngenAUX', '1');
model.study('std3').feature('stat').setSolveFor('/physics/solid', true);
model.study('std3').feature('stat').setSolveFor('/physics/es', true);
model.study('std3').feature('stat').setSolveFor('/multiphysics/eme1', true);
model.study('std3').create('eig', 'Eigenfrequency');
model.study('std3').feature('eig').set('plotgroup', 'Default');
model.study('std3').feature('eig').set('shift', '1[Hz]');
model.study('std3').feature('eig').set('chkeigregion', true);
model.study('std3').feature('eig').set('conrad', '1');
model.study('std3').feature('eig').set('conradynhm', '1');
model.study('std3').feature('eig').set('storefact', false);
model.study('std3').feature('eig').set('outputmap', {});
model.study('std3').feature('eig').set('ngenAUX', '1');
model.study('std3').feature('eig').set('goalngenAUX', '1');
model.study('std3').feature('eig').set('ngenAUX', '1');
model.study('std3').feature('eig').set('goalngenAUX', '1');
model.study('std3').feature('eig').setSolveFor('/physics/solid', true);
model.study('std3').feature('eig').setSolveFor('/physics/es', true);
model.study('std3').feature('eig').setSolveFor('/multiphysics/eme1', true);
model.study('std3').label('Biased Eigenfrequency');
model.study('std3').create('param', 'Parametric');
model.study('std3').feature('param').setIndex('pname', 'Vdc', 0);
model.study('std3').feature('param').setIndex('plistarr', '', 0);
model.study('std3').feature('param').setIndex('punit', 'V', 0);
model.study('std3').feature('param').setIndex('pname', 'Vdc', 0);
model.study('std3').feature('param').setIndex('plistarr', '', 0);
model.study('std3').feature('param').setIndex('punit', 'V', 0);
model.study('std3').feature('param').setIndex('plistarr', 'range(5,5,45)', 0);
model.study('std3').feature('eig').set('neigsactive', true);
model.study('std3').feature('eig').set('neigs', 1);

model.sol.create('sol3');

model.mesh('mesh1').stat.selection.geom(3);
model.mesh('mesh1').stat.selection.set([3 6 9 12 15 16 17 18 19 20 22 23 24 25 30 31 32 33 34 35 36 43 44 45 46 50 51 52 56 58 62 63 64 68 69 70 75 76 77 78 79 80]);
model.mesh('mesh1').stat.selection.geom(3);
model.mesh('mesh1').stat.selection.set([3 6 9 12 15 16 17 18 19 20 22 23 24 25 30 31 32 33 34 35 36 43 44 45 46 50 51 52 56 58 62 63 64 68 69 70 75 76 77 78 79 80]);

model.sol('sol3').study('std3');
model.sol('sol3').create('st1', 'StudyStep');
model.sol('sol3').feature('st1').set('study', 'std3');
model.sol('sol3').feature('st1').set('studystep', 'stat');
model.sol('sol3').create('v1', 'Variables');
model.sol('sol3').feature('v1').feature('comp1_spatial_disp').set('scalemethod', 'manual');
model.sol('sol3').feature('v1').feature('comp1_u').set('scalemethod', 'manual');
model.sol('sol3').feature('v1').feature('comp1_spatial_disp').set('scaleval', '1e-2*7.886019274640408E-5');
model.sol('sol3').feature('v1').feature('comp1_u').set('scaleval', '1e-2*7.886019274640408E-5');
model.sol('sol3').feature('v1').set('control', 'stat');
model.sol('sol3').create('s1', 'Stationary');
model.sol('sol3').feature('s1').feature('aDef').set('cachepattern', true);
model.sol('sol3').feature('s1').create('seDef', 'Segregated');
model.sol('sol3').feature('s1').create('se1', 'Segregated');
model.sol('sol3').feature('s1').feature('se1').feature.remove('ssDef');
model.sol('sol3').feature('s1').feature('se1').create('ss1', 'SegregatedStep');
model.sol('sol3').feature('s1').feature('se1').feature('ss1').set('segvar', {'comp1_V'});
model.sol('sol3').feature('s1').create('d1', 'Direct');
model.sol('sol3').feature('s1').feature('d1').set('linsolver', 'mumps');
model.sol('sol3').feature('s1').feature('se1').feature('ss1').set('linsolver', 'd1');
model.sol('sol3').feature('s1').feature('se1').feature('ss1').label('Electric Potential');
model.sol('sol3').feature('s1').feature('se1').create('ss2', 'SegregatedStep');
model.sol('sol3').feature('s1').feature('se1').feature('ss2').set('segvar', {'comp1_u'});
model.sol('sol3').feature('s1').feature('se1').feature('ss2').set('linsolver', 'd1');
model.sol('sol3').feature('s1').feature('se1').feature('ss2').label('Displacement Field');
model.sol('sol3').feature('s1').feature('se1').create('ss3', 'SegregatedStep');
model.sol('sol3').feature('s1').feature('se1').feature('ss3').set('segvar', {'comp1_spatial_disp'});
model.sol('sol3').feature('s1').feature('se1').feature('ss3').set('subdtech', 'const');
model.sol('sol3').feature('s1').feature('se1').feature('ss3').set('subjtech', 'onevery');
model.sol('sol3').feature('s1').feature('se1').feature('ss3').set('linsolver', 'd1');
model.sol('sol3').feature('s1').feature('se1').feature('ss3').label('Spatial Mesh Displacement');
model.sol('sol3').feature('s1').feature('se1').set('segstabacc', 'segaacc');
model.sol('sol3').feature('s1').feature('se1').set('segaaccdim', 5);
model.sol('sol3').feature('s1').create('i1', 'Iterative');
model.sol('sol3').feature('s1').feature('i1').set('linsolver', 'gmres');
model.sol('sol3').feature('s1').feature('i1').set('rhob', 40);
model.sol('sol3').feature('s1').feature('i1').set('nlinnormuse', true);
model.sol('sol3').feature('s1').feature('i1').set('itrestart', 5000);
model.sol('sol3').feature('s1').feature('i1').label('Iterative Solver (GMRES with SA AMG) (eme1)');
model.sol('sol3').feature('s1').feature('i1').create('mg1', 'Multigrid');
model.sol('sol3').feature('s1').feature('i1').feature('mg1').set('hybridization', 'multi');
model.sol('sol3').feature('s1').feature('i1').feature('mg1').set('hybridvar', {'comp1_u' 'comp1_V'});
model.sol('sol3').feature('s1').feature('i1').feature('mg1').set('prefun', 'saamg');
model.sol('sol3').feature('s1').feature('i1').feature('mg1').set('usesmooth', false);
model.sol('sol3').feature('s1').feature('i1').feature('mg1').feature('pr').create('so1', 'SOR');
model.sol('sol3').feature('s1').feature('i1').feature('mg1').feature('pr').feature('so1').set('relax', 0.8);
model.sol('sol3').feature('s1').feature('i1').feature('mg1').feature('po').create('so1', 'SOR');
model.sol('sol3').feature('s1').feature('i1').feature('mg1').feature('po').feature('so1').set('relax', 0.8);
model.sol('sol3').feature('s1').feature('i1').create('dp1', 'DirectPreconditioner');
model.sol('sol3').feature('s1').feature('i1').feature('dp1').set('hybridization', 'multi');
model.sol('sol3').feature('s1').feature('i1').feature('dp1').set('hybridvar', {'comp1_spatial_disp'});
model.sol('sol3').feature('s1').feature.remove('fcDef');
model.sol('sol3').feature('s1').feature.remove('seDef');
model.sol('sol3').create('su1', 'StoreSolution');
model.sol('sol3').create('st2', 'StudyStep');
model.sol('sol3').feature('st2').set('study', 'std3');
model.sol('sol3').feature('st2').set('studystep', 'eig');
model.sol('sol3').create('v2', 'Variables');
model.sol('sol3').feature('v2').feature('comp1_spatial_disp').set('scalemethod', 'manual');
model.sol('sol3').feature('v2').feature('comp1_u').set('scalemethod', 'manual');
model.sol('sol3').feature('v2').feature('comp1_spatial_disp').set('scaleval', '1e-2*7.886019274640408E-5');
model.sol('sol3').feature('v2').feature('comp1_u').set('scaleval', '1e-2*7.886019274640408E-5');
model.sol('sol3').feature('v2').set('initmethod', 'sol');
model.sol('sol3').feature('v2').set('initsol', 'sol3');
model.sol('sol3').feature('v2').set('initsoluse', 'sol4');
model.sol('sol3').feature('v2').set('notsolmethod', 'sol');
model.sol('sol3').feature('v2').set('notsol', 'sol3');
model.sol('sol3').feature('v2').set('control', 'eig');
model.sol('sol3').create('e1', 'Eigenvalue');
model.sol('sol3').feature('e1').set('eigvfunscale', 'maximum');
model.sol('sol3').feature('e1').set('eigvfunscaleparam', '7.89E-11');
model.sol('sol3').feature('e1').set('storelinpoint', true);
model.sol('sol3').feature('e1').set('control', 'eig');
model.sol('sol3').feature('e1').set('linpmethod', 'sol');
model.sol('sol3').feature('e1').set('linpsol', 'sol3');
model.sol('sol3').feature('e1').set('linpsoluse', 'sol4');
model.sol('sol3').feature('e1').set('control', 'eig');
model.sol('sol3').feature('e1').feature('aDef').set('cachepattern', true);
model.sol('sol3').feature('v2').set('notsolnum', 'auto');
model.sol('sol3').feature('v2').set('notsolvertype', 'solnum');
model.sol('sol3').attach('std3');

model.batch.create('p1', 'Parametric');
model.batch('p1').study('std3');
model.batch('p1').create('so1', 'Solutionseq');
model.batch('p1').feature('so1').set('seq', 'sol3');
model.batch('p1').feature('so1').set('store', 'on');
model.batch('p1').feature('so1').set('clear', 'on');
model.batch('p1').feature('so1').set('psol', 'none');
model.batch('p1').set('pname', {'Vdc'});
model.batch('p1').set('plistarr', {'range(5,5,45)'});
model.batch('p1').set('sweeptype', 'sparse');
model.batch('p1').set('probesel', 'all');
model.batch('p1').set('probes', {});
model.batch('p1').set('plot', 'off');
model.batch('p1').set('err', 'on');
model.batch('p1').attach('std3');
model.batch('p1').set('control', 'param');

model.sol('sol3').feature('v2').feature('comp1_spatial_disp').set('scalemethod', 'auto');
model.sol('sol3').feature('v2').feature('comp1_u').set('scalemethod', 'auto');

model.study('std3').setGenPlots(false);

model.sol.create('sol5');
model.sol('sol5').study('std3');
model.sol('sol5').label('Parametric Solutions 1');

model.batch('p1').feature('so1').set('psol', 'sol5');
model.batch('p1').run('compute');

model.result.create('pg6', 'PlotGroup1D');
model.result('pg6').run;
model.result('pg6').set('data', 'dset5');
model.result('pg6').create('ptgr1', 'PointGraph');
model.result('pg6').feature('ptgr1').set('markerpos', 'datapoints');
model.result('pg6').feature('ptgr1').set('linewidth', 'preference');
model.result('pg6').feature('ptgr1').selection.set([1]);
model.result('pg6').feature('ptgr1').set('expr', 'solid.freq');
model.result('pg6').feature('ptgr1').set('xdatasolnumtype', 'outer');
model.result('pg6').feature('ptgr1').set('linestyle', 'none');
model.result('pg6').feature('ptgr1').set('linemarker', 'square');
model.result('pg6').feature('ptgr1').set('legend', true);
model.result('pg6').feature('ptgr1').set('legendmethod', 'manual');
model.result('pg6').feature('ptgr1').setIndex('legends', 'COMSOL Solution', 0);
model.result('pg6').feature.duplicate('ptgr2', 'ptgr1');
model.result('pg6').run;
model.result('pg6').feature('ptgr2').set('data', 'dset2');
model.result('pg6').feature('ptgr2').setIndex('looplevelinput', 'first', 0);
model.result('pg6').feature('ptgr2').set('linecolor', 'blue');
model.result('pg6').feature('ptgr2').set('legend', false);
model.result('pg6').run;
model.result('pg6').create('glob1', 'Global');
model.result('pg6').feature('glob1').set('markerpos', 'datapoints');
model.result('pg6').feature('glob1').set('linewidth', 'preference');
model.result('pg6').feature('glob1').set('data', 'dset5');
model.result('pg6').feature('glob1').setIndex('looplevelinput', 'manual', 1);
model.result('pg6').feature('glob1').setIndex('looplevel', [2 3 4 5 6 7 8 9], 1);
model.result('pg6').feature('glob1').setIndex('expr', 'int1(Vdc)', 0);
model.result('pg6').feature('glob1').setIndex('descr', '', 0);
model.result('pg6').feature('glob1').set('xdatasolnumtype', 'outer');
model.result('pg6').feature('glob1').set('xdata', 'expr');
model.result('pg6').feature('glob1').set('xdataexpr', 'Vdc');
model.result('pg6').feature('glob1').set('legendmethod', 'manual');
model.result('pg6').feature('glob1').setIndex('legends', 'Experiment: Bannon et. al.', 0);
model.result('pg6').run;
model.result('pg6').set('titletype', 'manual');
model.result('pg6').set('title', 'Eigenfrequency vs. DC voltage');
model.result('pg6').set('xlabelactive', true);
model.result('pg6').set('xlabel', 'DC Bias (V)');
model.result('pg6').set('ylabelactive', true);
model.result('pg6').set('ylabel', 'Resonant Frequency (Hz)');
model.result('pg6').label('Eigenfrequency vs. DC Voltage');

model.title(['Normal Modes of a Biased Resonator ' native2unicode(hex2dec({'20' '14'}), 'unicode') ' 3D']);

model.description('An electrostatically actuated MEMS resonator is simulated. The device is driven by an AC + DC bias voltage applied across a parallel plate capacitor. In this example, the normal mode shapes and frequencies are computed, as a function of applied bias.');

model.mesh.clearMeshes;

model.sol('sol1').clearSolutionData;
model.sol('sol2').clearSolutionData;
model.sol('sol3').clearSolutionData;
model.sol('sol4').clearSolutionData;
model.sol('sol5').clearSolutionData;
model.sol('sol6').clearSolutionData;
model.sol('sol7').clearSolutionData;
model.sol('sol8').clearSolutionData;
model.sol('sol9').clearSolutionData;
model.sol('sol10').clearSolutionData;
model.sol('sol11').clearSolutionData;
model.sol('sol12').clearSolutionData;
model.sol('sol13').clearSolutionData;
model.sol('sol14').clearSolutionData;

model.label('biased_resonator_3d_modes.mph');

model.modelNode.label('Components');

out = model;
```

---

# Example 2: second_harmonic_generation_frequency_domain

**Module:** Wave_Optics_Module_Verification_Examples_second_harmonic_generation_frequency_domain  
**Category:** Unknown_Category  
**Physics Category:** Electromagnetism  

## Model Description

This COMSOL model simulates the process of second harmonic generation (SHG) in the frequency domain, a nonlinear optical phenomenon where photons interacting with a nonlinear material are converted to photons at twice the original frequency. The model uses two Electromagnetic Waves, Frequency Domain interfaces, one for the fundamental wave and another for the second harmonic wave, to represent the coupling between the two frequencies through a domain Polarization feature. The geometry consists of a 2D rectangular domain representing the nonlinear material, with the refractive index perfectly matched for each frequency. The simulation compares the results against the analytical solution from the Slowly Varying Envelope Approximation (SVEA).

The key physics involved in this model is electromagnetism, specifically the frequency domain analysis of electromagnetic waves. The geometry is a simple 2D rectangle, with the main feature being the nonlinear material region where the SHG process occurs. The material properties are defined using a constant refractive index for simplicity.

The model sets up a stationary study to solve for the electric field distribution of both the fundamental and second harmonic waves. It includes boundary conditions representing the incident fundamental wave and uses the Polarization feature to couple the two wave equations. The model also defines variables to compute the photon flux density and compare it with the SVEA analytical solution.

The expected results from this model include the spatial distribution of the electric field for both the fundamental and second harmonic waves, as well as the photon flux density along the propagation direction. These results provide insights into the efficiency of the SHG process and the conversion of photons from the fundamental frequency to the second harmonic. The comparison with the SVEA analytical solution helps validate the accuracy of the numerical simulation.

In summary, this model demonstrates the use of COMSOL's Electromagnetic Waves, Frequency Domain interfaces to simulate the second harmonic generation process in a nonlinear material, providing valuable insights into the underlying physics and the efficiency of the frequency conversion process.

## Complete COMSOL MATLAB Code

```matlab
function out = model
%
% second_harmonic_generation_frequency_domain.m
%
% Model exported on May 26 2025, 21:34 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/Wave_Optics_Module/Verification_Examples');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 2);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.physics.create('ewfd', 'ElectromagneticWavesFrequencyDomain', 'geom1');
model.physics('ewfd').model('comp1');
model.physics.create('ewfd2', 'ElectromagneticWavesFrequencyDomain', 'geom1');
model.physics('ewfd2').model('comp1');

model.study.create('std1');
model.study('std1').create('freq', 'Frequency');
model.study('std1').feature('freq').set('solnum', 'auto');
model.study('std1').feature('freq').set('notsolnum', 'auto');
model.study('std1').feature('freq').set('outputmap', {});
model.study('std1').feature('freq').set('ngenAUX', '1');
model.study('std1').feature('freq').set('goalngenAUX', '1');
model.study('std1').feature('freq').set('ngenAUX', '1');
model.study('std1').feature('freq').set('goalngenAUX', '1');
model.study('std1').feature('freq').setSolveFor('/physics/ewfd', true);
model.study('std1').feature('freq').setSolveFor('/physics/ewfd2', true);

% To import content from file, use:
% model.param.loadFile('FILENAME');
model.param.set('lambda1', '1.064[um]', 'Fundamental wavelength');
model.param.set('f1', 'c_const/lambda1', 'Fundamental frequency');
model.param.set('f2', '2*f1', 'Second harmonic frequency');
model.param.set('lambda2', 'c_const/f2', 'Second harmonic wavelength');
model.param.set('sim_l', 'lambda1*25', 'Simulation length');
model.param.set('sim_h', 'lambda2/16', 'Simulation height');
model.param.set('d', '1e-18[C/V^2]', 'Nonlinear coefficient');
model.param.set('L', 'sim_l - 3*lambda1', 'Length of nonlinear region');
model.param.set('I1', '30[MW/m^2]', 'Incident fundamental intensity');
model.param.set('E1', 'sqrt(2*I1/c_const/epsilon0_const)', 'Incident fundamental electric field strength');
model.param.set('offset', '1.5*lambda1', 'Start of nonlinear region');

model.geom('geom1').create('r1', 'Rectangle');
model.geom('geom1').feature('r1').set('size', {'sim_l' 'sim_h'});
model.geom('geom1').feature('r1').setIndex('layername', 'Layer 1', 0);
model.geom('geom1').feature('r1').setIndex('layer', 'offset', 0);
model.geom('geom1').feature('r1').set('layerleft', true);
model.geom('geom1').feature('r1').set('layerright', true);
model.geom('geom1').feature('r1').set('layerbottom', false);

model.view('view1').axis.set('viewscaletype', 'automatic');

model.geom('geom1').run;

model.material.create('mat1', 'Common', 'comp1');
model.material('mat1').propertyGroup.create('RefractiveIndex', 'Refractive_index');
model.material('mat1').propertyGroup('RefractiveIndex').set('n', {'1'});
model.material('mat1').propertyGroup('RefractiveIndex').set('ki', {'0'});

model.physics('ewfd').label('Fundamental');
model.physics('ewfd').tag('ewfd1');
model.physics('ewfd1').prop('components').set('components', 'inplane');
model.physics('ewfd1').create('pol1', 'Polarization', 2);
model.physics('ewfd1').feature('pol1').selection.set([2]);
model.physics('ewfd1').feature('pol1').set('P', {'0' '2*d*ewfd2.Ey*conj(ewfd1.Ey)' '0'});
model.physics('ewfd1').create('sctr1', 'Scattering', 1);
model.physics('ewfd1').feature('sctr1').selection.set([1]);
model.physics('ewfd1').feature('sctr1').set('IncidentField', 'EField');
model.physics('ewfd1').feature('sctr1').set('E0i', {'0' 'E1' '0'});
model.physics('ewfd1').create('sctr2', 'Scattering', 1);
model.physics('ewfd1').feature('sctr2').selection.set([10]);
model.physics('ewfd2').label('Second Harmonic');
model.physics('ewfd2').prop('components').set('components', 'inplane');
model.physics('ewfd2').prop('EquationForm').setIndex('form', 'Frequency', 0);
model.physics('ewfd2').prop('EquationForm').setIndex('freq_src', 'userdef', 0);
model.physics('ewfd2').prop('EquationForm').setIndex('freq', 'f2', 0);
model.physics('ewfd2').create('pol1', 'Polarization', 2);
model.physics('ewfd2').feature('pol1').selection.set([2]);
model.physics('ewfd2').feature('pol1').set('P', {'0' 'd*ewfd1.Ey*ewfd1.Ey' '0'});
model.physics('ewfd2').create('sctr1', 'Scattering', 1);
model.physics('ewfd2').feature('sctr1').selection.set([1 10]);

model.mesh('mesh1').create('map1', 'Map');
model.mesh('mesh1').feature('size').set('custom', true);
model.mesh('mesh1').feature('size').set('hmax', 'sim_h');
model.mesh('mesh1').feature('size').set('hmin', 'sim_h');

model.variable.create('var1');
model.variable('var1').model('comp1');
model.variable('var1').set('gamma', 'sqrt(8*d^2*Z0_const^3*(2*pi*ewfd1.freq)^2*I1)');
model.variable('var1').descr('gamma', 'Coupling coefficient');

model.study('std1').feature('freq').set('plist', 'f1');

model.sol.create('sol1');
model.sol('sol1').study('std1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'freq');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').set('control', 'freq');
model.sol('sol1').create('s1', 'Stationary');
model.sol('sol1').feature('s1').set('stol', 0.01);
model.sol('sol1').feature('s1').create('p1', 'Parametric');
model.sol('sol1').feature('s1').feature.remove('pDef');
model.sol('sol1').feature('s1').feature('p1').set('pname', {'freq'});
model.sol('sol1').feature('s1').feature('p1').set('plistarr', {'f1'});
model.sol('sol1').feature('s1').feature('p1').set('punit', {'THz'});
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
model.sol('sol1').feature('s1').feature('aDef').set('cachepattern', false);
model.sol('sol1').feature('s1').create('seDef', 'Segregated');
model.sol('sol1').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('s1').create('d1', 'Direct');
model.sol('sol1').feature('s1').feature('d1').set('linsolver', 'mumps');
model.sol('sol1').feature('s1').feature('d1').label('Suggested Direct Solver (ewfd1) (Merged)');
model.sol('sol1').feature('s1').feature('fc1').set('linsolver', 'd1');
model.sol('sol1').feature('s1').feature.remove('fcDef');
model.sol('sol1').feature('s1').feature.remove('seDef');
model.sol('sol1').attach('std1');
model.sol('sol1').feature('st1').set('splitcomplex', true);
model.sol('sol1').feature('s1').set('stol', 0.001);
model.sol('sol1').runAll;

model.title('Second Harmonic Generation in the Frequency Domain');

model.description(['This is a proof of principle example, describing the second harmonic generation (SHG) process using two Electromagnetic Waves, Frequency Domain interfaces. One for the fundamental wave and one for the second harmonic.' newline  newline 'For convenience, the refractive index is perfectly matched (at n = 1) for each frequency. The coupling between the waves is implemented using a domain Polarization feature for each interface.' newline  newline 'The results are compared against the analytical solution from the Slowly Varying Envelope Approximation (SVEA).']);

model.mesh.clearMeshes;

model.sol('sol1').clearSolutionData;

model.label('second_harmonic_generation_frequency_domain.mph');

model.modelNode.label('Components');

out = model;
```

---

# Example 3: plasmonic_wire_grating

**Module:** Wave_Optics_Module_Gratings_and_Metamaterials_plasmonic_wire_grating  
**Category:** Unknown_Category  
**Physics Category:** Electromagnetism  

## Model Description

This COMSOL model simulates the diffraction of light by a plasmonic wire grating on a dielectric substrate, to analyze the efficiency of different diffraction orders under varying angles of incidence. The model aims to solve the engineering problem of designing efficient optical gratings for applications like spectroscopy, optical computing, and solar cells.

The physics involved in this simulation is electromagnetism, specifically the frequency-domain modeling of electromagnetic waves using the Wave Optics Module. The geometry is a 2D representation of the wire grating, consisting of periodic rectangular wires on a dielectric substrate, with a surrounding medium of air. The key features include the use of periodic boundary conditions to model the infinite grating, port boundary conditions to excite and collect the diffracted light, and the incorporation of dispersive material properties for the metal wires using the Brendel-Bormann model for gold.

The study type is a parametric stationary analysis, where the angle of incidence is varied to compute the diffraction efficiencies. The model provides outputs of the electric field distribution and the reflectance and transmittance of the zeroth and first diffraction orders, both in transmission and reflection, as functions of the angle of incidence. These insights can be used to optimize the grating design for specific applications, such as maximizing the efficiency of a particular diffraction order or minimizing the reflection losses.

In summary, this model provides a powerful tool for designing and optimizing plasmonic wire gratings for various optical applications, by simulating the diffraction of light and analyzing the efficiency of different diffraction orders under varying angles of incidence.

## Complete COMSOL MATLAB Code

```matlab
function out = model
%
% plasmonic_wire_grating.m
%
% Model exported on May 26 2025, 21:34 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/Wave_Optics_Module/Gratings_and_Metamaterials');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 2);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.physics.create('ewfd', 'ElectromagneticWavesFrequencyDomain', 'geom1');
model.physics('ewfd').model('comp1');

model.study.create('std1');
model.study('std1').create('wave', 'Wavelength');
model.study('std1').feature('wave').set('solnum', 'auto');
model.study('std1').feature('wave').set('notsolnum', 'auto');
model.study('std1').feature('wave').set('outputmap', {});
model.study('std1').feature('wave').set('ngenAUX', '1');
model.study('std1').feature('wave').set('goalngenAUX', '1');
model.study('std1').feature('wave').set('ngenAUX', '1');
model.study('std1').feature('wave').set('goalngenAUX', '1');
model.study('std1').feature('wave').setSolveFor('/physics/ewfd', true);

model.param.set('na', '1');
model.param.descr('na', 'Refractive index, air');
model.param.set('nb', '1.2');
model.param.descr('nb', 'Refractive index, dielectric');
model.param.set('d', '400[nm]');
model.param.descr('d', 'Grating constant');
model.param.set('lam0', '441[nm]');
model.param.descr('lam0', 'Vacuum wavelength');
model.param.set('f0', 'c_const/lam0');
model.param.descr('f0', 'Frequency');
model.param.set('alpha', '0[deg]');
model.param.descr('alpha', 'Angle of incidence');
model.param.set('beta', 'asin(na*sin(alpha)/nb)');
model.param.descr('beta', 'Refraction angle');

model.geom('geom1').run;

model.study('std1').feature('wave').set('plist', 'lam0');
model.study('std1').feature('wave').set('useparam', true);
model.study('std1').feature('wave').setIndex('pname_aux', 'na', 0);
model.study('std1').feature('wave').setIndex('plistarr_aux', '', 0);
model.study('std1').feature('wave').setIndex('punit_aux', '', 0);
model.study('std1').feature('wave').setIndex('pname_aux', 'na', 0);
model.study('std1').feature('wave').setIndex('plistarr_aux', '', 0);
model.study('std1').feature('wave').setIndex('punit_aux', '', 0);
model.study('std1').feature('wave').setIndex('pname_aux', 'alpha', 0);
model.study('std1').feature('wave').setIndex('plistarr_aux', 'range(0[rad],pi/40[rad],(pi/2-pi/40)[rad])', 0);
model.study('std1').feature('wave').setIndex('punit_aux', 'deg', 0);

model.geom('geom1').create('r1', 'Rectangle');
model.geom('geom1').feature('r1').set('size', {'d' '3*d'});
model.geom('geom1').run('r1');
model.geom('geom1').create('r2', 'Rectangle');
model.geom('geom1').feature('r2').set('size', {'d' '3*d'});
model.geom('geom1').feature('r2').set('pos', {'0' '-3*d'});
model.geom('geom1').run('r2');
model.geom('geom1').create('c1', 'Circle');
model.geom('geom1').feature('c1').set('r', 'd/5');
model.geom('geom1').feature('c1').set('pos', {'d/2' '0'});
model.geom('geom1').run('c1');
model.geom('geom1').create('uni1', 'Union');
model.geom('geom1').feature('uni1').selection('input').set({'c1' 'r1' 'r2'});
model.geom('geom1').run('uni1');
model.geom('geom1').create('del1', 'Delete');
model.geom('geom1').feature('del1').selection('input').set('uni1', 6);
model.geom('geom1').run('del1');
model.geom('geom1').run('fin');

model.material.create('mat1', 'Common', 'comp1');
model.material('mat1').label('Air');
model.material('mat1').propertyGroup.create('RefractiveIndex', 'Refractive_index');
model.material('mat1').propertyGroup('RefractiveIndex').set('n', {'na'});
model.material.create('mat2', 'Common', 'comp1');
model.material('mat2').label('Dielectric');
model.material('mat2').selection.set([1]);
model.material('mat2').propertyGroup.create('RefractiveIndex', 'Refractive_index');
model.material('mat2').propertyGroup('RefractiveIndex').set('n', {'nb'});
model.material.create('mat3', 'Common', 'comp1');
model.material('mat3').propertyGroup.create('RefractiveIndex', 'Refractive index');
model.material('mat3').propertyGroup('RefractiveIndex').func.create('int1', 'Interpolation');
model.material('mat3').propertyGroup('RefractiveIndex').func.create('int2', 'Interpolation');
model.material('mat3').label('Au (Gold) (Rakic et al. 1998: Brendel-Bormann model; n,k 0.248-6.20 um)');
model.material('mat3').propertyGroup('RefractiveIndex').func('int1').set('funcname', 'nr');
model.material('mat3').propertyGroup('RefractiveIndex').func('int1').set('fununit', {'1'});
model.material('mat3').propertyGroup('RefractiveIndex').func('int1').set('argunit', {'um'});
model.material('mat3').propertyGroup('RefractiveIndex').func('int2').set('funcname', 'ni');
model.material('mat3').propertyGroup('RefractiveIndex').func('int2').set('fununit', {'1'});
model.material('mat3').propertyGroup('RefractiveIndex').func('int2').set('argunit', {'um'});
model.material('mat3').propertyGroup('RefractiveIndex').set('n', {'nr(c_const/freq)' '0' '0' '0' 'nr(c_const/freq)' '0' '0' '0' 'nr(c_const/freq)'});
model.material('mat3').propertyGroup('RefractiveIndex').set('ki', {'ni(c_const/freq)' '0' '0' '0' 'ni(c_const/freq)' '0' '0' '0' 'ni(c_const/freq)'});
model.material('mat3').propertyGroup('RefractiveIndex').addInput('frequency');
model.material('mat3').selection.set([3]);

model.physics('ewfd').prop('components').set('components', 'outofplane');
model.physics('ewfd').create('port1', 'Port', 1);
model.physics('ewfd').feature('port1').selection.set([5]);
model.physics('ewfd').feature('port1').set('PortType', 'Periodic');
model.physics('ewfd').feature('port1').set('Eampl', [0 0 1]);
model.physics('ewfd').feature('port1').set('alpha_inc', 'alpha');
model.physics('ewfd').feature('port1').set('n', {'na' '0' '0' '0' 'na' '0' '0' '0' 'na'});
model.physics('ewfd').feature('port1').set('IncludeInAutomaticDiffractionOrderCalculation', false);
model.physics('ewfd').create('port2', 'Port', 1);
model.physics('ewfd').feature('port2').selection.set([2]);
model.physics('ewfd').feature('port2').set('PortType', 'Periodic');
model.physics('ewfd').feature('port2').set('Eampl', [0 0 1]);
model.physics('ewfd').feature('port2').set('n', {'nb' '0' '0' '0' 'nb' '0' '0' '0' 'nb'});
model.physics('ewfd').feature('port1').create('dport1', 'DiffractionOrder', 1);
model.physics('ewfd').feature('port1').feature('dport1').set('components', 'outofplane');
model.physics('ewfd').feature('port1').feature('dport1').set('mOrder', -1);
model.physics('ewfd').feature('port1').feature.duplicate('dport2', 'dport1');
model.physics('ewfd').feature('port1').feature('dport2').set('mOrder', 1);
model.physics('ewfd').feature('port1').runCommand('addDiffractionOrders');
model.physics('ewfd').create('pc1', 'PeriodicCondition', 1);
model.physics('ewfd').feature('pc1').selection.set([1 3 7 8]);
model.physics('ewfd').feature('pc1').set('PeriodicType', 'Floquet');
model.physics('ewfd').feature('pc1').set('Floquet_source', 'FromPeriodicPort');

model.sol.create('sol1');
model.sol('sol1').study('std1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'wave');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').set('control', 'wave');
model.sol('sol1').create('s1', 'Stationary');
model.sol('sol1').feature('s1').set('stol', 0.01);
model.sol('sol1').feature('s1').create('p1', 'Parametric');
model.sol('sol1').feature('s1').feature.remove('pDef');
model.sol('sol1').feature('s1').feature('p1').set('pname', {'lambda0' 'alpha'});
model.sol('sol1').feature('s1').feature('p1').set('punit', {[native2unicode(hex2dec({'00' 'b5'}), 'unicode') 'm'] 'deg'});
model.sol('sol1').feature('s1').feature('p1').set('sweeptype', 'filled');
model.sol('sol1').feature('s1').feature('p1').set('plistarr', {'lam0' 'range(0[rad],pi/40[rad],(pi/2-pi/40)[rad])'});
model.sol('sol1').feature('s1').feature('p1').set('pcontinuationmode', 'no');
model.sol('sol1').feature('s1').feature('p1').set('pcontinuation', '');
model.sol('sol1').feature('s1').feature('p1').set('preusesol', 'no');
model.sol('sol1').feature('s1').feature('p1').set('pdistrib', 'off');
model.sol('sol1').feature('s1').feature('p1').set('plot', 'off');
model.sol('sol1').feature('s1').feature('p1').set('plotgroup', 'Default');
model.sol('sol1').feature('s1').feature('p1').set('probesel', 'all');
model.sol('sol1').feature('s1').feature('p1').set('probes', {});
model.sol('sol1').feature('s1').feature('p1').set('control', 'wave');
model.sol('sol1').feature('s1').set('control', 'wave');
model.sol('sol1').feature('s1').feature('aDef').set('complexfun', true);
model.sol('sol1').feature('s1').feature('aDef').set('cachepattern', true);
model.sol('sol1').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('s1').create('d1', 'Direct');
model.sol('sol1').feature('s1').feature('d1').set('linsolver', 'mumps');
model.sol('sol1').feature('s1').feature('d1').label('Suggested Direct Solver (ewfd)');
model.sol('sol1').feature('s1').feature('fc1').set('linsolver', 'd1');
model.sol('sol1').feature('s1').feature.remove('fcDef');
model.sol('sol1').attach('std1');
model.sol('sol1').runAll;


model.physics('ewfd').prop('components').set('components', 'inplane');
model.physics('ewfd').feature('port1').set('InputType', 'H');
model.physics('ewfd').feature('port1').set('Hampl', [0 0 1]);
model.physics('ewfd').feature('port1').runCommand('addDiffractionOrders');
model.physics('ewfd').feature('port1').feature('dport1').set('components', 'inplane');
model.physics('ewfd').feature('port1').feature('dport2').set('components', 'inplane');
model.physics('ewfd').feature('port2').set('InputType', 'H');
model.physics('ewfd').feature('port2').set('Hampl', [0 0 1]);

model.study.create('std2');
model.study('std2').create('wave', 'Wavelength');
model.study('std2').feature('wave').set('plotgroup', 'Default');
model.study('std2').feature('wave').set('solnum', 'auto');
model.study('std2').feature('wave').set('notsolnum', 'auto');
model.study('std2').feature('wave').set('outputmap', {});
model.study('std2').feature('wave').set('ngenAUX', '1');
model.study('std2').feature('wave').set('goalngenAUX', '1');
model.study('std2').feature('wave').set('ngenAUX', '1');
model.study('std2').feature('wave').set('goalngenAUX', '1');
model.study('std2').feature('wave').setSolveFor('/physics/ewfd', true);
model.study('std2').feature('wave').set('plist', 'lam0');
model.study('std2').feature('wave').set('useparam', true);
model.study('std2').feature('wave').setIndex('pname_aux', 'na', 0);
model.study('std2').feature('wave').setIndex('plistarr_aux', '', 0);
model.study('std2').feature('wave').setIndex('punit_aux', '', 0);
model.study('std2').feature('wave').setIndex('pname_aux', 'na', 0);
model.study('std2').feature('wave').setIndex('plistarr_aux', '', 0);
model.study('std2').feature('wave').setIndex('punit_aux', '', 0);
model.study('std2').feature('wave').setIndex('pname_aux', 'alpha', 0);
model.study('std2').feature('wave').setIndex('plistarr_aux', 'range(0[rad],pi/40[rad],(pi/2-pi/40)[rad])', 0);
model.study('std2').feature('wave').setIndex('punit_aux', 'deg', 0);

model.sol.create('sol2');
model.sol('sol2').study('std2');
model.sol('sol2').create('st1', 'StudyStep');
model.sol('sol2').feature('st1').set('study', 'std2');
model.sol('sol2').feature('st1').set('studystep', 'wave');
model.sol('sol2').create('v1', 'Variables');
model.sol('sol2').feature('v1').set('control', 'wave');
model.sol('sol2').create('s1', 'Stationary');
model.sol('sol2').feature('s1').set('stol', 0.01);
model.sol('sol2').feature('s1').create('p1', 'Parametric');
model.sol('sol2').feature('s1').feature.remove('pDef');
model.sol('sol2').feature('s1').feature('p1').set('pname', {'lambda0' 'alpha'});
model.sol('sol2').feature('s1').feature('p1').set('punit', {[native2unicode(hex2dec({'00' 'b5'}), 'unicode') 'm'] 'deg'});
model.sol('sol2').feature('s1').feature('p1').set('sweeptype', 'filled');
model.sol('sol2').feature('s1').feature('p1').set('plistarr', {'lam0' 'range(0[rad],pi/40[rad],(pi/2-pi/40)[rad])'});
model.sol('sol2').feature('s1').feature('p1').set('pcontinuationmode', 'no');
model.sol('sol2').feature('s1').feature('p1').set('pcontinuation', '');
model.sol('sol2').feature('s1').feature('p1').set('preusesol', 'no');
model.sol('sol2').feature('s1').feature('p1').set('pdistrib', 'off');
model.sol('sol2').feature('s1').feature('p1').set('plot', 'off');
model.sol('sol2').feature('s1').feature('p1').set('plotgroup', 'Default');
model.sol('sol2').feature('s1').feature('p1').set('probesel', 'all');
model.sol('sol2').feature('s1').feature('p1').set('probes', {});
model.sol('sol2').feature('s1').feature('p1').set('control', 'wave');
model.sol('sol2').feature('s1').set('control', 'wave');
model.sol('sol2').feature('s1').feature('aDef').set('complexfun', true);
model.sol('sol2').feature('s1').feature('aDef').set('cachepattern', true);
model.sol('sol2').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol2').feature('s1').create('d1', 'Direct');
model.sol('sol2').feature('s1').feature('d1').set('linsolver', 'mumps');
model.sol('sol2').feature('s1').feature('d1').label('Suggested Direct Solver (ewfd)');
model.sol('sol2').feature('s1').feature('fc1').set('linsolver', 'd1');
model.sol('sol2').feature('s1').feature.remove('fcDef');
model.sol('sol2').attach('std2');
model.sol('sol2').runAll;

model.title('Plasmonic Wire Grating');

model.description(['A plane wave is incident on a wire grating on a dielectric substrate. Diffraction efficiencies for the zeroth and first diffraction orders ' native2unicode(hex2dec({'20' '14'}), 'unicode') ' both in transmission and reflection ' native2unicode(hex2dec({'20' '14'}), 'unicode') ' are all computed as functions of the angle of incidence.']);

model.mesh.clearMeshes;

model.sol('sol1').clearSolutionData;
model.sol('sol2').clearSolutionData;

model.label('plasmonic_wire_grating.mph');

model.modelNode.label('Components');

out = model;
```

---

