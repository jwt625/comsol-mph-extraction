# COMSOL Few-Shot Examples

This file contains high-level model descriptions paired with complete MATLAB scripts for few-shot prompting with language models.

**Total Examples:** 3

---

## Example 1: biased_resonator_3d_modes

**Module:** MEMS_Module_Actuators_biased_resonator_3d_modes  
**Category:** Unknown_Category  

### Model Description

**Model Overview**:
The model simulates an electrostatically actuated MEMS (Microelectromechanical Systems) resonator. The device is driven by a combination of AC and DC bias voltage applied across a parallel plate capacitor. The simulation focuses on computing the deformation of the resonator under the influence of the applied DC bias voltage and the normal mode shapes and frequencies as a function of the applied bias.

**Geometry**:
The geometric setup consists of a resonator structure composed of polysilicon, which is sandwiched between layers of silicon nitride and silicon oxide. The resonator is anchored to the ground plane and faces an electrode with a specified gap. The dimensions and specific shapes are defined within the geometry sequence file 'biased_resonator_3d_geom_sequence.mph'.

**Materials**:
The model uses four main materials:
1. Polycrystalline silicon (PolySi) for the resonator, with properties such as Young's modulus, Poisson's ratio, and thermal properties.
2. Silicon nitride (Si3N4) for one of the layers, with its own set of mechanical and thermal properties.
3. Silicon oxide (SiO2) for another layer, with distinct mechanical and thermal properties.
4. Air, modeled as an ideal gas, filling the surrounding domain, with properties like density, thermal conductivity, and specific heat capacity.

**Physics**:
The model involves three main physics interfaces:
1. Solid Mechanics (solid) for structural deformation analysis.
2. Electrostatics (es) for electric field analysis.
3. Electromechanical Forces (eme1) for coupling between the electrostatics and structural mechanics.

**Boundary Conditions**:
Key boundary conditions include:
- Fixed constraint applied to the interface between the silicon nitride layer and the resonator structure.
- Symmetry conditions applied to certain boundaries to reduce the model size.
- Ground and voltage terminal conditions applied to the ground plane and electrode, respectively, for the electrostatics analysis.

**Mesh**:
The geometry is discretized using a combination of free tetrahedral mesh (ftri1) and a swept mesh (swe1) to capture the thin layers accurately. The mesh is refined based on the geometry and physics requirements.

**Study**:
The model performs a stationary analysis to compute the deformation under the applied DC bias and an eigenfrequency analysis to determine the normal mode shapes and frequencies of the resonator. A parametric study is also set up to evaluate the effect of varying the DC bias voltage.

**Key Parameters**:
- DC bias voltage (Vdc), which is varied in the parametric study from 5 V to 45 V.
- Material properties such as Young's modulus, Poisson's ratio, and thermal properties for each material.
- Geometric dimensions defined in the geometry sequence file.

**Expected Results**:
The model predicts the deformation of the resonator structure under the applied DC bias and the normal mode shapes and frequencies of the resonator as a function of the applied bias voltage. The results are presented in the form of 3D plots of displacement, electric potential, and electric field norm.

**Engineering Application**:
This model is relevant for designing and optimizing MEMS resonators for various applications such as sensors, actuators, and filters. Understanding the behavior of the resonator under different bias conditions is crucial for achieving desired performance characteristics and avoiding failure due to excessive deformation or unwanted resonances.

### COMSOL MATLAB Code

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

## Example 2: second_harmonic_generation_frequency_domain

**Module:** Wave_Optics_Module_Verification_Examples_second_harmonic_generation_frequency_domain  
**Category:** Unknown_Category  

### Model Description

**Model Overview**:
The simulation model is designed to demonstrate the process of second harmonic generation (SHG) in the frequency domain. SHG is a nonlinear optical process where photons interacting with a nonlinear medium are effectively "combined" to produce new photons at twice the original frequency. This model uses two Electromagnetic Waves, Frequency Domain interfaces, one for the fundamental wave and another for the second harmonic wave, to simulate this phenomenon.

**Geometry**:
The geometric setup consists of a rectangular domain with dimensions defined by 'sim_l' (25 times the fundamental wavelength) in length and 'sim_h' (1/16 of the second harmonic wavelength) in height. The domain is divided into two sections: a linear region and a nonlinear region, with the latter starting at a distance 'offset' (1.5 times the fundamental wavelength) from the left boundary.

**Materials**:
A single material, labeled 'mat1', is used throughout the domain, with a refractive index of 1 and a negligible extinction coefficient (ki = 0). This simplification is for convenience, ensuring perfect matching of the refractive index at both the fundamental and second harmonic frequencies.

**Physics**:
The model employs two instances of the Electromagnetic Waves, Frequency Domain (ewfd) physics interface, denoted as 'ewfd1' for the fundamental wave and 'ewfd2' for the second harmonic wave. The coupling between these two waves is achieved through a domain Polarization feature in each interface, where the nonlinear polarization is defined as:
- For the fundamental wave: P = (0, 2*d*ewfd2.Ey*conj(ewfd1.Ey), 0)
- For the second harmonic wave: P = (0, d*ewfd1.Ey*ewfd1.Ey, 0)
Here, 'd' is the nonlinear coefficient, and 'conj' denotes the complex conjugate.

**Boundary Conditions**:
The model applies Scattering boundary conditions at the left and right boundaries of the domain for both the fundamental and second harmonic waves. The incident electric field for the fundamental wave is defined with strength 'E1' along the y-axis, while the second harmonic wave has no incident field.

**Mesh**:
The geometry is discretized using a mapped mesh with a user-defined maximum element size 'hmax' set equal to 'sim_h'. This ensures a uniform mesh throughout the domain, suitable for the wave nature of the problem.

**Study**:
The analysis performed is a frequency-domain study, solving for the stationary response of the system at the fundamental frequency 'f1' and the second harmonic frequency 'f2' (twice the fundamental frequency).

**Key Parameters**:
- Fundamental wavelength (lambda1): 1.064 µm
- Second harmonic wavelength (lambda2): lambda1/2
- Nonlinear coefficient (d): 1e-18 C/V^2
- Incident fundamental intensity (I1): 30 MW/m^2
- Length of the nonlinear region (L): sim_l - 3*lambda1

**Expected Results**:
The model predicts the electric field distribution of both the fundamental and second harmonic waves within the domain. The results are visualized through surface plots of the electric field components and line graphs comparing the photon flux density obtained from the simulation with the analytical solution from the Slowly Varying Envelope Approximation (SVEA).

**Engineering Application**:
This model can be applied to the design and optimization of nonlinear optical devices for frequency conversion, such as those used in laser systems, optical communications, and various sensing applications. By understanding and predicting the SHG process, engineers can develop more efficient and compact devices for specific frequency conversion tasks.

### COMSOL MATLAB Code

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

model.result.create('pg1', 'PlotGroup2D');
model.result('pg1').label('Electric Field (ewfd1)');
model.result('pg1').set('frametype', 'spatial');
model.result('pg1').set('data', 'dset1');
model.result('pg1').setIndex('looplevel', 1, 0);
model.result('pg1').set('defaultPlotID', 'ElectromagneticWavesFrequencyDomain/phys1/pdef1/pcond2/pg1');
model.result('pg1').feature.create('surf1', 'Surface');
model.result('pg1').feature('surf1').set('smooth', 'internal');
model.result('pg1').feature('surf1').set('data', 'parent');
model.result.create('pg2', 'PlotGroup2D');
model.result('pg2').label('Electric Field (ewfd2)');
model.result('pg2').set('frametype', 'spatial');
model.result('pg2').set('data', 'dset1');
model.result('pg2').setIndex('looplevel', 1, 0);
model.result('pg2').set('defaultPlotID', 'ElectromagneticWavesFrequencyDomain/phys1/pdef1/pcond2/pg1');
model.result('pg2').feature.create('surf1', 'Surface');
model.result('pg2').feature('surf1').set('expr', 'ewfd2.normE');
model.result('pg2').feature('surf1').set('smooth', 'internal');
model.result('pg2').feature('surf1').set('data', 'parent');
model.result('pg1').run;
model.result('pg1').label('Fundamental');
model.result('pg1').run;
model.result('pg1').feature('surf1').set('expr', 'ewfd1.Ey');
model.result('pg1').run;
model.result('pg1').set('titletype', 'manual');
model.result('pg1').set('title', 'Electric field, y-component (V/m) for fundamental wave');
model.result('pg1').run;
model.result('pg2').run;
model.result('pg2').label('Second Harmonic');
model.result('pg2').run;
model.result('pg2').feature('surf1').set('expr', 'ewfd2.Ey');
model.result('pg2').run;
model.result('pg2').set('titletype', 'manual');
model.result('pg2').set('title', 'Electric field, y-component (V/m) for second harmonic wave');
model.result('pg2').run;
model.result.create('pg3', 'PlotGroup1D');
model.result('pg3').run;
model.result('pg3').label('Electric Fields');
model.result('pg3').create('lngr1', 'LineGraph');
model.result('pg3').feature('lngr1').set('markerpos', 'datapoints');
model.result('pg3').feature('lngr1').set('linewidth', 'preference');
model.result('pg3').feature('lngr1').label('Fundamental');
model.result('pg3').feature('lngr1').selection.set([2 5 8]);
model.result('pg3').feature('lngr1').set('expr', 'ewfd1.Ey');
model.result('pg3').feature('lngr1').set('xdata', 'expr');
model.result('pg3').feature('lngr1').set('xdataexpr', 'x');
model.result('pg3').feature('lngr1').set('linewidth', 2);
model.result('pg3').feature('lngr1').set('legend', true);
model.result('pg3').feature('lngr1').set('autoplotlabel', true);
model.result('pg3').feature('lngr1').set('autosolution', false);
model.result('pg3').feature.duplicate('lngr2', 'lngr1');
model.result('pg3').run;
model.result('pg3').feature('lngr2').label('Second Harmonic');
model.result('pg3').feature('lngr2').set('expr', 'ewfd2.Ey');
model.result('pg3').run;
model.result('pg3').set('titletype', 'manual');
model.result('pg3').set('title', 'Fundamental and Second Harmonic Electric Fields');
model.result.create('pg4', 'PlotGroup1D');
model.result('pg4').run;
model.result('pg4').label('Photon Flux Density');
model.result('pg4').create('lngr1', 'LineGraph');
model.result('pg4').feature('lngr1').set('markerpos', 'datapoints');
model.result('pg4').feature('lngr1').set('linewidth', 'preference');
model.result('pg4').feature('lngr1').label('Simulation Fundamental');
model.result('pg4').feature('lngr1').selection.set([2 5 8]);
model.result('pg4').feature('lngr1').set('expr', 'ewfd1.Ey*conj(ewfd1.Ey)/(2*Z0_const)/hbar_const/(2*pi*ewfd1.freq)');
model.result('pg4').feature('lngr1').set('xdata', 'expr');
model.result('pg4').feature('lngr1').set('xdataexpr', 'x');
model.result('pg4').feature('lngr1').set('linestyle', 'none');
model.result('pg4').feature('lngr1').set('linewidth', 5);
model.result('pg4').feature('lngr1').set('linemarker', 'diamond');
model.result('pg4').feature('lngr1').set('markerpos', 'interp');
model.result('pg4').feature('lngr1').set('markers', 20);
model.result('pg4').feature('lngr1').set('legend', true);
model.result('pg4').feature('lngr1').set('autoplotlabel', true);
model.result('pg4').feature('lngr1').set('autosolution', false);
model.result('pg4').feature.duplicate('lngr2', 'lngr1');
model.result('pg4').run;
model.result('pg4').feature('lngr2').label('Simulation Second Harmonic');
model.result('pg4').feature('lngr2').set('expr', 'ewfd2.Ey*conj(ewfd2.Ey)/(2*Z0_const)/hbar_const/(2*pi*ewfd2.freq)');
model.result('pg4').feature.duplicate('lngr3', 'lngr2');
model.result('pg4').run;
model.result('pg4').feature('lngr3').label('Slowly Varying Envelope Approximation (SVEA) Fundamental');
model.result('pg4').feature('lngr3').selection.set([5]);
model.result('pg4').feature('lngr3').set('expr', '(sech(gamma*(x - offset)/2))^2*I1/hbar_const/(2*pi*ewfd1.freq)');
model.result('pg4').feature('lngr3').set('linestyle', 'solid');
model.result('pg4').feature('lngr3').set('linewidth', 2);
model.result('pg4').feature('lngr3').set('linemarker', 'none');
model.result('pg4').feature('lngr3').set('legendmethod', 'manual');
model.result('pg4').feature('lngr3').setIndex('legends', 'SVEA Fundamental', 0);
model.result('pg4').feature.duplicate('lngr4', 'lngr3');
model.result('pg4').run;
model.result('pg4').feature('lngr4').label('Slowly Varying Envelope Approximation (SVEA) Second Harmonic');
model.result('pg4').feature('lngr4').set('expr', '(tanh(gamma*(x - offset)/2))^2*I1/hbar_const/(2*pi*ewfd2.freq)');
model.result('pg4').feature('lngr4').setIndex('legends', 'SVEA Second Harmonic', 0);
model.result('pg4').run;
model.result('pg4').set('titletype', 'manual');
model.result('pg4').set('title', 'Fundamental and Second Harmonic Photon Flux Density');
model.result('pg4').set('ylabelactive', true);
model.result('pg4').set('ylabel', 'Photon Flux Density (photons per m^2 s)');

model.title('Second Harmonic Generation in the Frequency Domain');

model.description(['This is a proof of principle example, describing the second harmonic generation (SHG) process using two Electromagnetic Waves, Frequency Domain interfaces. One for the fundamental wave and one for the second harmonic.' newline  newline 'For convenience, the refractive index is perfectly matched (at n = 1) for each frequency. The coupling between the waves is implemented using a domain Polarization feature for each interface.' newline  newline 'The results are compared against the analytical solution from the Slowly Varying Envelope Approximation (SVEA).']);

model.mesh.clearMeshes;

model.sol('sol1').clearSolutionData;

model.label('second_harmonic_generation_frequency_domain.mph');

model.modelNode.label('Components');

out = model;
```

---

## Example 3: residual_stress_resonator_2d_geom_sequence

**Module:** MEMS_Module_Actuators_residual_stress_resonator_2d_geom_sequence  
**Category:** Unknown_Category  

### Model Description

**Model Overview:**
The script provided is a MATLAB script exported from COMSOL Multiphysics, which sets up a 2D simulation model for a residual stress resonator. The physical phenomena being simulated likely involve structural mechanics, possibly with an emphasis on the effects of residual stresses within the material of the resonator.

**Geometry:**
The geometric setup consists of two components (comp1 and comp2), each with its own geometry (geom1 and geom2). Both geometries are 2D.

For comp1:
- A rectangle (r1) of size 250 µm by 120 µm is created.
- Another rectangle (r2) of size 2 µm by 200 µm is positioned at [100, 120] relative to r1.
- An array (arr1) of r2 is created with full size 2 by 2 and displacement [48, -320].

For comp2:
- A rectangle (r1) of size 250 µm by 120 µm is created.
- Another rectangle (r2) of size 2 µm by 172 µm is positioned at [100, 120] relative to r1.
- A rectangle (r3) of size 12 µm by 2 µm is positioned at [100, 290] relative to r1.
- Another rectangle (r4) of size 2 µm by 148 µm is positioned at [110, 144] relative to r1.
- A mirror operation (mir1) is applied to r2, r3, and r4, keeping the original objects and mirroring them around the point [125, 0].
- Another mirror operation (mir2) is applied to the result of mir1, r2, r3, and r4, keeping the original objects and mirroring them around the line through the origin with direction [0, 1] (y-axis).

**Materials:**
The script does not specify the materials used or their properties. This information is likely defined within the physics settings of the model, which are not detailed in the provided script.

**Physics:**
The physics interface used in this model is the Solid Mechanics interface, which is typically used for structural mechanics simulations. The interface is applied to both geometries (geom1 and geom2) within their respective components (comp1 and comp2).

**Boundary Conditions:**
Boundary conditions are not specified in the provided script. They would need to be defined within the physics settings, which are not detailed here.

**Mesh:**
The script creates a mesh for each geometry (mesh1 for geom1 and mesh2 for geom2) but does not specify the mesh settings. The mesh generation would be based on default settings or settings defined within the physics or study settings, which are not detailed in the provided script.

**Study:**
The type of analysis (steady-state, transient, frequency, etc.) is not specified in the provided script. This information would typically be defined within the study settings of the model.

**Key Parameters:**
Key parameters such as material properties, loads, constraints, and initial conditions are not specified in the provided script. These parameters would need to be defined within the physics or study settings, which are not detailed here.

**Expected Results:**
The expected results of this model would likely include the displacement, stress, and strain fields within the resonator structure due to the residual stresses. However, without more information on the physics settings and boundary conditions, it is difficult to predict the specific outputs.

**Engineering Application:**
This model could be used to analyze and optimize the design of MEMS (Microelectromechanical Systems) resonators, particularly focusing on the effects of residual stresses on the resonator's performance. Residual stresses can significantly impact the resonant frequency and quality factor of the resonator, which are critical parameters for their operation in various applications such as sensors, filters, and oscillators.

### COMSOL MATLAB Code

```matlab
function out = model
%
% residual_stress_resonator_2d_geom_sequence.m
%
% Model exported on May 26 2025, 21:30 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/MEMS_Module/Actuators');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 2);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.physics.create('solid', 'SolidMechanics', 'geom1');
model.physics('solid').model('comp1');

model.geom('geom1').lengthUnit([native2unicode(hex2dec({'00' 'b5'}), 'unicode') 'm']);
model.geom('geom1').create('r1', 'Rectangle');
model.geom('geom1').feature('r1').set('size', [250 120]);
model.geom('geom1').run('r1');
model.geom('geom1').create('r2', 'Rectangle');
model.geom('geom1').feature('r2').set('size', [2 200]);
model.geom('geom1').feature('r2').set('pos', [100 120]);
model.geom('geom1').run('r2');
model.geom('geom1').create('arr1', 'Array');
model.geom('geom1').feature('arr1').selection('input').set({'r2'});
model.geom('geom1').feature('arr1').set('fullsize', [2 2]);
model.geom('geom1').feature('arr1').set('displ', [48 -320]);
model.geom('geom1').runPre('fin');

model.modelNode.create('comp2', true);

model.geom.create('geom2', 2);
model.geom('geom2').model('comp2');

model.mesh.create('mesh2', 'geom2');

model.geom('geom2').lengthUnit([native2unicode(hex2dec({'00' 'b5'}), 'unicode') 'm']);
model.geom('geom2').create('r1', 'Rectangle');
model.geom('geom2').feature('r1').set('size', [250 120]);
model.geom('geom2').run('r1');
model.geom('geom2').create('r2', 'Rectangle');
model.geom('geom2').feature('r2').set('size', [2 172]);
model.geom('geom2').feature('r2').set('pos', [100 120]);
model.geom('geom2').run('r2');
model.geom('geom2').create('r3', 'Rectangle');
model.geom('geom2').feature('r3').set('size', [12 2]);
model.geom('geom2').feature('r3').set('pos', [100 290]);
model.geom('geom2').run('r3');
model.geom('geom2').create('r4', 'Rectangle');
model.geom('geom2').feature('r4').set('size', [2 148]);
model.geom('geom2').feature('r4').set('pos', [110 144]);
model.geom('geom2').run('r4');
model.geom('geom2').create('mir1', 'Mirror');
model.geom('geom2').feature('mir1').selection('input').set({'r2' 'r3' 'r4'});
model.geom('geom2').feature('mir1').set('keep', true);
model.geom('geom2').feature('mir1').set('pos', [125 0]);
model.geom('geom2').run('mir1');
model.geom('geom2').create('mir2', 'Mirror');
model.geom('geom2').feature('mir2').selection('input').set({'mir1' 'r2' 'r3' 'r4'});
model.geom('geom2').feature('mir2').set('keep', true);
model.geom('geom2').feature('mir2').set('pos', [0 60]);
model.geom('geom2').feature('mir2').set('axis', [0 1]);
model.geom('geom2').runPre('fin');

model.title([]);

model.description('');

model.label('residual_stress_resonator_2d_geom_sequence.mph');

model.modelNode.label('Components');

out = model;
```

---

