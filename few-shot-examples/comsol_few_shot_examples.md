# COMSOL Few-Shot Examples

This file contains high-level model descriptions paired with complete MATLAB scripts for few-shot prompting with language models.

**Total Examples:** 20

---

## Example 1: biased_resonator_3d_modes

**Module:** MEMS_Module_Actuators_biased_resonator_3d_modes  
**Category:** Unknown_Category  

### Model Description

**Model Overview**:
The model simulates an electrostatically actuated MEMS (Microelectromechanical Systems) resonator. The device is driven by a combination of AC and DC bias voltage applied across a parallel plate capacitor. The simulation focuses on computing the deformation of the resonator under the influence of the applied DC bias and the normal mode shapes and frequencies as a function of the applied bias.

**Geometry**:
The geometry consists of a complex 3D structure that includes components such as the resonator, electrodes, oxide and nitride layers, and surrounding air. The resonator is a detailed structure with specific dimensions and shapes, including a ball-shaped component and a box-shaped component. The exact dimensions are defined within the geometry sequence file 'biased_resonator_3d_geom_sequence.mph'.

**Materials**:
The model uses several materials, including Polycrystalline silicon (Si), Silicon nitride (Si3N4), Silicon oxide (SiO2), and Air. Each material is defined with specific properties such as Young's modulus, Poisson's ratio, thermal expansion coefficient, heat capacity, relative permittivity, density, and thermal conductivity. The material properties are set to accurately represent the behavior of the materials under the given conditions.

**Physics**:
The simulation involves the Solid Mechanics and Electrostatics physics interfaces, along with the Electromechanical Forces multiphysics coupling. The Solid Mechanics interface is used to compute the deformation of the resonator, while the Electrostatics interface calculates the electric potential and field distribution. The Electromechanical Forces coupling accounts for the interaction between the electric field and the mechanical deformation.

**Boundary Conditions**:
Various boundary conditions are applied in the model. The resonator is fixed at certain boundaries (Fixed constraint), and symmetry conditions are applied to reduce the computational domain. The ground plane is assigned a ground condition in the Electrostatics interface, and the electrode is assigned a voltage terminal with the applied DC bias voltage (Vdc). The DC bias voltage is a parameter that can be varied in the simulation.

**Mesh**:
The geometry is discretized using a mesh that is generated based on the specified mesh settings. The mesh is refined in certain regions to capture the important features and gradients accurately. The mesh settings are adjusted to ensure a good balance between accuracy and computational efficiency.

**Study**:
The simulation performs a stationary analysis to compute the deformation of the resonator under the applied DC bias voltage. Additionally, an eigenfrequency analysis is conducted to determine the normal mode shapes and frequencies of the resonator as a function of the applied bias. The eigenfrequency analysis is performed for both unbiased and biased conditions.

**Key Parameters**:
The key parameters in the model include the DC bias voltage (Vdc), which is varied in the parametric study. Other important parameters include the material properties, geometric dimensions, and boundary conditions.

**Expected Results**:
The model predicts the deformation of the resonator under the applied DC bias voltage and the normal mode shapes and frequencies of the resonator. The results are expected to provide insights into the behavior of the MEMS resonator under different bias conditions and help in understanding the electrostatic actuation mechanism.

**Engineering Application**:
This model is relevant to the design and analysis of MEMS resonators and other electrostatically actuated devices. It can be used to optimize the design parameters, such as the geometry, materials, and bias conditions, to achieve desired performance characteristics. The model can also be used to study the effects of various factors on the resonator's behavior and to predict its performance under different operating conditions. This can aid in the development of efficient and reliable MEMS devices for various applications, such as sensors, actuators, and filters.

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
The simulation model is designed to demonstrate the process of second harmonic generation (SHG) in the frequency domain. SHG is a nonlinear optical process where photons with the same frequency interact with a nonlinear material and are converted into photons at twice the original frequency (second harmonic). This model uses two Electromagnetic Waves, Frequency Domain interfaces to represent the fundamental wave and the second harmonic wave, and it includes a comparison with the analytical solution from the Slowly Varying Envelope Approximation (SVEA).

**Geometry**:
The geometric setup consists of a rectangular domain with dimensions defined by 'sim_l' (25 times the fundamental wavelength) for the length and 'sim_h' (second harmonic wavelength divided by 16) for the height. The geometry is created in 2D space.

**Materials**:
A single material ('mat1') is used, which is defined as having a refractive index of 1 with zero extinction coefficient (perfectly matched for each frequency). The material properties are set under the property group 'RefractiveIndex'.

**Physics**:
Two physics interfaces are used: 'ElectromagneticWavesFrequencyDomain' (ewfd) for the fundamental wave and 'ElectromagneticWavesFrequencyDomain' (ewfd2) for the second harmonic wave. Both are set up for in-plane components. The coupling between the waves is implemented using a domain 'Polarization' feature for each interface, where the nonlinear polarization is defined in terms of the electric field components of the respective waves and the nonlinear coefficient 'd'.

**Boundary Conditions**:
Boundary conditions include a 'Scattering' feature (sctr1) for the fundamental wave, which defines an incident electric field with strength 'E1' along the y-axis. Another 'Scattering' feature (sctr2) is applied to the second harmonic wave without specifying an incident field, as it is generated through the nonlinear interaction.

**Mesh**:
The geometry is discretized using a 'Map' mesh (map1) with a maximum and minimum element size set to 'sim_h'. This creates a structured mesh suitable for the rectangular geometry.

**Study**:
The analysis performed is a frequency-domain study with a single frequency step defined by the fundamental frequency 'f1'. The solver settings include a stationary solver with a parametric sweep over the frequency.

**Key Parameters**:
Key parameters include the fundamental wavelength 'lambda1' (1.064 um), the second harmonic wavelength 'lambda2', the nonlinear coefficient 'd' (1e-18 C/V^2), the incident fundamental intensity 'I1' (30 MW/m^2), and the coupling coefficient 'gamma', which is a derived variable based on the material properties and incident intensity.

**Expected Results**:
The model predicts the electric field distribution for both the fundamental and second harmonic waves within the domain. It also compares the photon flux density obtained from the simulation with the analytical solution from SVEA for both the fundamental and second harmonic waves.

**Engineering Application**:
This model can be applied to the design and optimization of nonlinear optical devices, such as frequency doublers used in laser systems. Understanding and predicting the efficiency of SHG is crucial for applications in telecommunications, material processing, and spectroscopy.

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
The simulation model "residual_stress_resonator_2d_geom_sequence" appears to be designed to study the mechanical behavior of a resonator structure, likely within the context of microelectromechanical systems (MEMS). The model is set up to analyze the stress and strain distribution within the resonator due to residual stresses, which are important factors in the performance and reliability of MEMS devices.

**Geometry:**
The geometric setup consists of two components, each with its own 2D geometry:

1. Component 1 (`comp1`):
   - A base rectangle of dimensions 250 µm by 120 µm.
   - A smaller rectangle of dimensions 2 µm by 200 µm positioned 100 µm from the left and 120 µm from the bottom of the base rectangle.
   - An array of the smaller rectangle, with full size 2 by 2 and a displacement of 48 µm in the x-direction and -320 µm in the y-direction.

2. Component 2 (`comp2`):
   - A base rectangle identical to that in `comp1`.
   - A smaller rectangle of dimensions 2 µm by 172 µm positioned at the same location as in `comp1`.
   - A thin rectangle of dimensions 12 µm by 2 µm positioned at 100 µm from the left and 290 µm from the bottom of the base rectangle.
   - Another small rectangle of dimensions 2 µm by 148 µm positioned at 110 µm from the left and 144 µm from the bottom of the base rectangle.
   - The smaller rectangles are mirrored along the x-axis and then along the y-axis to create a symmetric structure.

**Materials:**
The script does not explicitly define material properties, which suggests that the material properties are either defined within the physics interface settings or are using default values provided by COMSOL. Material properties would be crucial for accurate simulation of stress and strain and would typically include Young's modulus, Poisson's ratio, and density.

**Physics:**
The physics interface used in this model is the Solid Mechanics interface, which is suitable for analyzing structural mechanics problems including stress, strain, and displacement in solid structures. The governing equations for this interface typically include the balance of forces and the constitutive relations that describe the material's response to applied loads.

**Boundary Conditions:**
The script does not specify boundary conditions for the physics interface. In a structural mechanics problem, typical boundary conditions could include fixed constraints, where displacement is set to zero, or applied forces and pressures. These conditions are essential for solving the problem and would need to be defined for a successful simulation.

**Mesh:**
The geometry is discretized using a mesh, which is created for each component geometry (`mesh1` for `geom1` and `mesh2` for `geom2`). The script does not specify the mesh settings, so the default mesh settings of COMSOL would be applied. The mesh is a critical aspect of the finite element analysis, and its quality can significantly affect the accuracy of the simulation results.

**Study:**
The type of analysis is not specified in the provided script. It could be a stationary (steady-state) study for finding the equilibrium state of the structure under residual stress or a frequency domain study if the resonant frequencies of the structure are of interest.

**Key Parameters:**
Key parameters would include the geometric dimensions, material properties, and any loads or constraints applied. Since the material properties and loads are not specified in the script, these would be important parameters to define for the simulation.

**Expected Results:**
The expected results from this model would include the stress and strain distribution within the resonator structure, as well as the displacement field. These results would help in understanding how residual stresses affect the performance and reliability of the resonator.

**Engineering Application:**
This model is likely used in the design and optimization of MEMS resonators, which have applications in various fields such as sensors, actuators, and communication devices. Understanding the impact of residual stresses is crucial for designing resonators that can withstand mechanical stress and operate reliably over time.

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

## Example 4: damage_test_bar

**Module:** Nonlinear_Structural_Materials_Module_Damage_damage_test_bar  
**Category:** Unknown_Category  

### Model Description

**Model Overview**:
The model simulates the behavior of brittle damage in a uniaxial tension test using two different approaches: the Crack Band model and the Implicit Gradient damage model. The purpose is to analyze and compare the damage evolution and localization in a simple bar under tension.

**Geometry**:
The geometric setup consists of a rectangular bar with dimensions defined by parameters 'L' (length) and 'H' (height). The bar's length is set to 0.1 meters, and its height is defined as L/50, making it 0.002 meters.

**Materials**:
The material used in the simulation is defined with properties typical for brittle materials. The material properties include:
- Young's modulus (E): 30 GPa
- Poisson's ratio (ν): 0.2
- Density: 2400 kg/m³
- Tensile strength (σp): 2 MPa
- Fracture energy (Gf): 60 N/m

The material also incorporates a scalar damage model with a piecewise weakening function.

**Physics**:
The model employs the Solid Mechanics interface to simulate the structural behavior of the bar. The damage models are implemented through the following features:
- Damage: Crack Band (dmg1)
- Damage: Implicit Gradient (dmg2)

The Crack Band model uses a fixed length scale approach, while the Implicit Gradient model uses an implicit gradient regularization with a length scale parameter 'lscale' set to 0.001 meters.

**Boundary Conditions**:
The bar is subjected to the following boundary conditions:
- Roller boundary condition on the bottom edges, constraining the vertical displacement.
- Displacement boundary condition on the top edge, applying a prescribed horizontal displacement based on the 'average_strain' parameter.

**Mesh**:
The geometry is discretized using a mapped mesh with a distribution of 101 elements along the height of the bar. The mesh is refined to capture the damage localization accurately.

**Study**:
The model performs a stationary (steady-state) analysis with a parametric study varying the 'average_strain' parameter from 0 to 'max_average_strain' (5e-4) to simulate the loading process.

**Key Parameters**:
- Bar length (L): 0.1 m
- Bar thickness (H): L/50 = 0.002 m
- Maximum average strain (max_average_strain): 5e-4
- Length scale (lscale): 0.001 m

**Expected Results**:
The model predicts the stress distribution, damage evolution, and displacement field in the bar under uniaxial tension. It also provides a comparison between the Crack Band and Implicit Gradient damage models in terms of localization and damage patterns.

**Engineering Application**:
This model can be used to study the failure mechanisms in brittle materials subjected to tensile loading. It helps engineers understand the damage initiation and propagation, as well as the influence of different damage models on the structural response. The insights gained from this simulation can be applied to design and optimize structures and components made of brittle materials, ensuring their safety and reliability under various loading conditions.

### COMSOL MATLAB Code

```matlab
function out = model
%
% damage_test_bar.m
%
% Model exported on May 26 2025, 21:31 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/Nonlinear_Structural_Materials_Module/Damage');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 2);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.physics.create('solid', 'SolidMechanics', 'geom1');
model.physics('solid').model('comp1');

model.study.create('std1');
model.study('std1').create('stat', 'Stationary');
model.study('std1').feature('stat').setSolveFor('/physics/solid', true);

model.param.set('L', '0.1[m]');
model.param.descr('L', 'Bar length');
model.param.set('H', 'L/50');
model.param.descr('H', 'Bar thickness');
model.param.set('max_average_strain', '5e-4');
model.param.descr('max_average_strain', 'Maximum average strain');
model.param.set('average_strain', '0');
model.param.descr('average_strain', 'Average strain (loading parameter)');
model.param.set('lscale', '0.001[m]');
model.param.descr('lscale', 'Length scale');

model.geom('geom1').create('r1', 'Rectangle');
model.geom('geom1').feature('r1').set('size', {'L' 'H/2'});
model.geom('geom1').runPre('fin');

model.cpl.create('intop1', 'Integration', 'geom1');

model.geom('geom1').run;

model.cpl('intop1').set('axisym', true);
model.cpl('intop1').selection.geom('geom1', 1);
model.cpl('intop1').selection.set([4]);
model.cpl('intop1').set('method', 'summation');

model.physics('solid').prop('Type2D').set('Type2D', 'PlaneStress');
model.physics('solid').prop('d').set('d', 'H');
model.physics('solid').feature('lemm1').create('dmg1', 'Damage', 2);
model.physics('solid').feature('lemm1').feature('dmg1').label('Damage: Crack Band');
model.physics('solid').feature('lemm1').create('dmg2', 'Damage', 2);
model.physics('solid').feature('lemm1').feature('dmg2').label('Damage: Implicit Gradient');
model.physics('solid').feature('lemm1').feature('dmg2').set('regType', 'impGradient');
model.physics('solid').feature('lemm1').feature('dmg2').set('lint', 'lscale');
model.physics('solid').feature('lemm1').feature('dmg2').set('hdmg', '3*lscale');

model.material.create('mat1', 'Common', 'comp1');
model.material('mat1').propertyGroup.create('Enu', 'Young''s_modulus_and_Poisson''s_ratio');
model.material('mat1').propertyGroup('Enu').set('E', {'30[GPa]'});
model.material('mat1').propertyGroup('Enu').set('nu', {'0.2'});
model.material('mat1').propertyGroup('def').set('density', {'2400'});
model.material('mat1').propertyGroup.create('ScalarDamage', 'Scalar_damage');
model.material('mat1').propertyGroup('ScalarDamage').set('sigmap', {'2[MPa]'});
model.material('mat1').propertyGroup('ScalarDamage').set('Gf', {'60'});
model.material('mat1').propertyGroup('ScalarDamage').func.create('pw1', 'Piecewise');
model.material('mat1').propertyGroup('ScalarDamage').func('pw1').label('Piecewise: Weakening');
model.material('mat1').propertyGroup('ScalarDamage').func('pw1').set('funcname', 'weak');
model.material('mat1').propertyGroup('ScalarDamage').func('pw1').setIndex('pieces', 0, 0, 0);
model.material('mat1').propertyGroup('ScalarDamage').func('pw1').setIndex('pieces', 0.0495, 0, 1);
model.material('mat1').propertyGroup('ScalarDamage').func('pw1').setIndex('pieces', 1, 0, 2);
model.material('mat1').propertyGroup('ScalarDamage').func('pw1').setIndex('pieces', 0.0495, 1, 0);
model.material('mat1').propertyGroup('ScalarDamage').func('pw1').setIndex('pieces', 0.0505, 1, 1);
model.material('mat1').propertyGroup('ScalarDamage').func('pw1').setIndex('pieces', 0.975, 1, 2);
model.material('mat1').propertyGroup('ScalarDamage').func('pw1').setIndex('pieces', 0.0505, 2, 0);
model.material('mat1').propertyGroup('ScalarDamage').func('pw1').setIndex('pieces', '.1', 2, 1);
model.material('mat1').propertyGroup('ScalarDamage').func('pw1').setIndex('pieces', 1, 2, 2);
model.material('mat1').propertyGroup('ScalarDamage').func('pw1').set('argunit', 'm');
model.material('mat1').propertyGroup('ScalarDamage').func('pw1').set('fununit', '1');
model.material('mat1').propertyGroup('ScalarDamage').set('sigmap', {'2[MPa]*weak(X)'});

model.physics('solid').create('roll1', 'Roller', 1);
model.physics('solid').feature('roll1').selection.set([1 2]);
model.physics('solid').create('disp1', 'Displacement1', 1);
model.physics('solid').feature('disp1').selection.set([4]);
model.physics('solid').feature('disp1').setIndex('Direction', 'prescribed', 0);
model.physics('solid').feature('disp1').setIndex('U0', 'L*average_strain', 0);

model.mesh('mesh1').create('map1', 'Map');
model.mesh('mesh1').feature('map1').create('dis1', 'Distribution');
model.mesh('mesh1').feature('map1').feature('dis1').selection.set([2]);
model.mesh('mesh1').feature('map1').feature('dis1').set('numelem', 101);

model.study('std1').label('Crack Band, Quadratic');
model.study('std1').feature('stat').set('useparam', true);
model.study('std1').feature('stat').setIndex('pname', 'L', 0);
model.study('std1').feature('stat').setIndex('plistarr', '', 0);
model.study('std1').feature('stat').setIndex('punit', 'm', 0);
model.study('std1').feature('stat').setIndex('pname', 'L', 0);
model.study('std1').feature('stat').setIndex('plistarr', '', 0);
model.study('std1').feature('stat').setIndex('punit', 'm', 0);
model.study('std1').feature('stat').setIndex('pname', 'average_strain', 0);
model.study('std1').feature('stat').setIndex('plistarr', 'range(0,0.01,1)*max_average_strain', 0);
model.study('std1').feature('stat').set('useadvanceddisable', true);
model.study('std1').feature('stat').set('disabledphysics', {'solid/lemm1/dmg2'});

model.sol.create('sol1');
model.sol('sol1').study('std1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'stat');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').set('control', 'stat');
model.sol('sol1').create('s1', 'Stationary');
model.sol('sol1').feature('s1').create('p1', 'Parametric');
model.sol('sol1').feature('s1').feature.remove('pDef');
model.sol('sol1').feature('s1').feature('p1').set('control', 'stat');
model.sol('sol1').feature('s1').set('control', 'stat');
model.sol('sol1').feature('s1').feature('aDef').set('cachepattern', true);
model.sol('sol1').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('s1').feature('fc1').set('dtech', 'const');
model.sol('sol1').feature('s1').feature('fc1').set('maxiter', 8);
model.sol('sol1').feature('s1').feature('fc1').set('linsolver', 'dDef');
model.sol('sol1').feature('s1').feature('fc1').set('dtech', 'const');
model.sol('sol1').feature('s1').feature('fc1').set('maxiter', 8);
model.sol('sol1').feature('s1').feature.remove('fcDef');
model.sol('sol1').attach('std1');
model.sol('sol1').feature('s1').feature('p1').set('paramtuning', true);
model.sol('sol1').feature('s1').feature('p1').set('pminstep', '1e-5*max_average_strain');
model.sol('sol1').feature('s1').feature('p1').set('pinitstep', '0.01*max_average_strain');
model.sol('sol1').feature('s1').feature('p1').set('pmaxstep', '0.01*max_average_strain');
model.sol('sol1').feature('v1').set('scalemethod', 'manual');
model.sol('sol1').feature('v1').set('scaleval', '1.0e-4');
model.sol('sol1').runAll;

model.result.create('pg1', 'PlotGroup2D');
model.result('pg1').set('data', 'dset1');
model.result('pg1').setIndex('looplevel', 101, 0);
model.result('pg1').set('defaultPlotID', 'stress');
model.result('pg1').label('Stress (solid)');
model.result('pg1').set('frametype', 'spatial');
model.result('pg1').create('surf1', 'Surface');
model.result('pg1').feature('surf1').set('expr', {'solid.misesGp'});
model.result('pg1').feature('surf1').set('threshold', 'manual');
model.result('pg1').feature('surf1').set('thresholdvalue', 0.2);
model.result('pg1').feature('surf1').set('colortable', 'Rainbow');
model.result('pg1').feature('surf1').set('colortabletrans', 'none');
model.result('pg1').feature('surf1').set('colorscalemode', 'linear');
model.result('pg1').feature('surf1').set('resolution', 'normal');
model.result('pg1').feature('surf1').set('colortable', 'Prism');
model.result('pg1').feature('surf1').create('def', 'Deform');
model.result('pg1').feature('surf1').feature('def').set('expr', {'u' 'v'});
model.result('pg1').feature('surf1').feature('def').set('descr', 'Displacement field');
model.result('pg1').run;
model.result.create('pg2', 'PlotGroup2D');
model.result('pg2').set('data', 'dset1');
model.result('pg2').setIndex('looplevel', 101, 0);
model.result('pg2').label('Damage (solid)');
model.result('pg2').set('defaultPlotID', 'damage');
model.result('pg2').create('surf1', 'Surface');
model.result('pg2').feature('surf1').set('expr', {'solid.dmgGp'});
model.result('pg2').feature('surf1').set('inheritplot', 'none');
model.result('pg2').feature('surf1').set('resolution', 'normal');
model.result('pg2').feature('surf1').set('colortabletype', 'discrete');
model.result('pg2').feature('surf1').set('bandcount', 11);
model.result('pg2').feature('surf1').set('colortable', 'RainbowLight');
model.result('pg2').feature('surf1').set('smooth', 'none');
model.result('pg2').feature('surf1').set('descractive', true);
model.result('pg2').feature('surf1').set('descr', 'Damage');
model.result('pg2').label('Damage (solid)');
model.result('pg2').run;
model.result('pg2').label('Damage: Crack Band');
model.result('pg2').set('titletype', 'label');
model.result('pg2').set('edges', false);
model.result('pg2').run;
model.result('pg2').feature('surf1').set('resolution', 'custom');
model.result('pg2').feature('surf1').set('refine', 2);
model.result('pg2').feature('surf1').create('def1', 'Deform');
model.result('pg2').run;
model.result('pg2').feature('surf1').feature('def1').set('scaleactive', true);
model.result('pg2').feature('surf1').feature('def1').set('scale', 100);
model.result('pg2').run;
model.result('pg2').create('mesh1', 'Mesh');
model.result('pg2').feature('mesh1').set('colortable', 'TrafficFlow');
model.result('pg2').feature('mesh1').set('colortabletrans', 'nonlinear');
model.result('pg2').feature('mesh1').set('nonlinearcolortablerev', true);
model.result('pg2').feature('mesh1').set('elemcolor', 'none');
model.result('pg2').feature('mesh1').set('wireframecolor', 'white');
model.result('pg2').feature('mesh1').set('inheritplot', 'surf1');
model.result('pg2').feature('mesh1').create('def1', 'Deform');
model.result('pg2').run;
model.result('pg2').run;

model.study.create('std2');
model.study('std2').create('stat', 'Stationary');
model.study('std2').feature('stat').setSolveFor('/physics/solid', true);
model.study('std2').feature('stat').set('useparam', true);
model.study('std2').feature('stat').setIndex('pname', 'L', 0);
model.study('std2').feature('stat').setIndex('plistarr', '', 0);
model.study('std2').feature('stat').setIndex('punit', 'm', 0);
model.study('std2').feature('stat').setIndex('pname', 'L', 0);
model.study('std2').feature('stat').setIndex('plistarr', '', 0);
model.study('std2').feature('stat').setIndex('punit', 'm', 0);
model.study('std2').feature('stat').setIndex('pname', 'average_strain', 0);
model.study('std2').feature('stat').setIndex('plistarr', 'range(0,0.01,1)*max_average_strain', 0);

model.sol.create('sol2');
model.sol('sol2').study('std2');
model.sol('sol2').create('st1', 'StudyStep');
model.sol('sol2').feature('st1').set('study', 'std2');
model.sol('sol2').feature('st1').set('studystep', 'stat');
model.sol('sol2').create('v1', 'Variables');
model.sol('sol2').feature('v1').feature('comp1_solid_eeqnl').set('scalemethod', 'manual');
model.sol('sol2').feature('v1').feature('comp1_solid_eeqnl').set('scaleval', '1e-3');
model.sol('sol2').feature('v1').set('control', 'stat');
model.sol('sol2').create('s1', 'Stationary');
model.sol('sol2').feature('s1').create('p1', 'Parametric');
model.sol('sol2').feature('s1').feature.remove('pDef');
model.sol('sol2').feature('s1').feature('p1').set('control', 'stat');
model.sol('sol2').feature('s1').set('control', 'stat');
model.sol('sol2').feature('s1').feature('aDef').set('cachepattern', true);
model.sol('sol2').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol2').feature('s1').feature('fc1').set('dtech', 'const');
model.sol('sol2').feature('s1').feature('fc1').set('maxiter', 8);
model.sol('sol2').feature('s1').feature('fc1').set('linsolver', 'dDef');
model.sol('sol2').feature('s1').feature('fc1').set('dtech', 'const');
model.sol('sol2').feature('s1').feature('fc1').set('maxiter', 8);
model.sol('sol2').feature('s1').feature.remove('fcDef');
model.sol('sol2').attach('std2');
model.sol('sol2').feature('s1').feature('p1').set('paramtuning', true);
model.sol('sol2').feature('s1').feature('p1').set('pminstep', '1e-5*max_average_strain');
model.sol('sol2').feature('s1').feature('p1').set('pinitstep', '0.01*max_average_strain');
model.sol('sol2').feature('s1').feature('p1').set('pmaxstep', '0.01*max_average_strain');
model.sol('sol2').feature('v1').set('scalemethod', 'manual');
model.sol('sol2').feature('v1').set('scaleval', '1.0e-4');

model.study('std2').setGenPlots(false);
model.study('std2').label('Implicit Gradient, Quadratic');

model.sol('sol2').runAll;

model.physics('solid').create('disc1', 'Discretization', -1);
model.physics('solid').feature('disc1').set('order_displacement', 1);
model.physics('solid').feature('disc1').label('Discretization Linear');

model.study.create('std3');
model.study('std3').create('stat', 'Stationary');
model.study('std3').feature('stat').setSolveFor('/physics/solid', true);
model.study('std3').feature('stat').set('useparam', true);
model.study('std3').feature('stat').setIndex('pname', 'L', 0);
model.study('std3').feature('stat').setIndex('plistarr', '', 0);
model.study('std3').feature('stat').setIndex('punit', 'm', 0);
model.study('std3').feature('stat').setIndex('pname', 'L', 0);
model.study('std3').feature('stat').setIndex('plistarr', '', 0);
model.study('std3').feature('stat').setIndex('punit', 'm', 0);
model.study('std3').feature('stat').setIndex('pname', 'average_strain', 0);
model.study('std3').feature('stat').setIndex('plistarr', 'range(0,0.01,1)*max_average_strain', 0);
model.study('std3').feature('stat').set('useadvanceddisable', true);
model.study('std3').feature('stat').set('disabledphysics', {'solid/lemm1/dmg2'});
model.study('std3').feature('stat').setEntry('discretization', 'solid', 'disc1');

model.sol.create('sol3');
model.sol('sol3').study('std3');
model.sol('sol3').create('st1', 'StudyStep');
model.sol('sol3').feature('st1').set('study', 'std3');
model.sol('sol3').feature('st1').set('studystep', 'stat');
model.sol('sol3').create('v1', 'Variables');
model.sol('sol3').feature('v1').set('control', 'stat');
model.sol('sol3').create('s1', 'Stationary');
model.sol('sol3').feature('s1').create('p1', 'Parametric');
model.sol('sol3').feature('s1').feature.remove('pDef');
model.sol('sol3').feature('s1').feature('p1').set('control', 'stat');
model.sol('sol3').feature('s1').set('control', 'stat');
model.sol('sol3').feature('s1').feature('aDef').set('cachepattern', true);
model.sol('sol3').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol3').feature('s1').feature('fc1').set('dtech', 'const');
model.sol('sol3').feature('s1').feature('fc1').set('maxiter', 8);
model.sol('sol3').feature('s1').feature('fc1').set('linsolver', 'dDef');
model.sol('sol3').feature('s1').feature('fc1').set('dtech', 'const');
model.sol('sol3').feature('s1').feature('fc1').set('maxiter', 8);
model.sol('sol3').feature('s1').feature.remove('fcDef');
model.sol('sol3').attach('std3');
model.sol('sol3').feature('s1').feature('p1').set('paramtuning', true);
model.sol('sol3').feature('s1').feature('p1').set('pminstep', '1e-5*max_average_strain');
model.sol('sol3').feature('s1').feature('p1').set('pinitstep', '0.01*max_average_strain');
model.sol('sol3').feature('s1').feature('p1').set('pmaxstep', '0.01*max_average_strain');
model.sol('sol3').feature('v1').set('scalemethod', 'manual');
model.sol('sol3').feature('v1').set('scaleval', '1.0e-4');

model.study('std3').setGenPlots(false);
model.study('std3').label('Crack Band, Linear');

model.sol('sol3').runAll;

model.study.create('std4');
model.study('std4').create('stat', 'Stationary');
model.study('std4').feature('stat').setSolveFor('/physics/solid', true);
model.study('std4').feature('stat').set('useadvanceddisable', true);
model.study('std4').feature('stat').setEntry('discretization', 'solid', 'disc1');
model.study('std4').feature('stat').set('useparam', true);
model.study('std4').feature('stat').setIndex('pname', 'L', 0);
model.study('std4').feature('stat').setIndex('plistarr', '', 0);
model.study('std4').feature('stat').setIndex('punit', 'm', 0);
model.study('std4').feature('stat').setIndex('pname', 'L', 0);
model.study('std4').feature('stat').setIndex('plistarr', '', 0);
model.study('std4').feature('stat').setIndex('punit', 'm', 0);
model.study('std4').feature('stat').setIndex('pname', 'average_strain', 0);
model.study('std4').feature('stat').setIndex('plistarr', 'range(0,0.01,1)*max_average_strain', 0);

model.sol.create('sol4');
model.sol('sol4').study('std4');
model.sol('sol4').create('st1', 'StudyStep');
model.sol('sol4').feature('st1').set('study', 'std4');
model.sol('sol4').feature('st1').set('studystep', 'stat');
model.sol('sol4').create('v1', 'Variables');
model.sol('sol4').feature('v1').feature('comp1_solid_eeqnl').set('scalemethod', 'manual');
model.sol('sol4').feature('v1').feature('comp1_solid_eeqnl').set('scaleval', '1e-3');
model.sol('sol4').feature('v1').set('control', 'stat');
model.sol('sol4').create('s1', 'Stationary');
model.sol('sol4').feature('s1').create('p1', 'Parametric');
model.sol('sol4').feature('s1').feature.remove('pDef');
model.sol('sol4').feature('s1').feature('p1').set('control', 'stat');
model.sol('sol4').feature('s1').set('control', 'stat');
model.sol('sol4').feature('s1').feature('aDef').set('cachepattern', true);
model.sol('sol4').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol4').feature('s1').feature('fc1').set('dtech', 'const');
model.sol('sol4').feature('s1').feature('fc1').set('maxiter', 8);
model.sol('sol4').feature('s1').feature('fc1').set('linsolver', 'dDef');
model.sol('sol4').feature('s1').feature('fc1').set('dtech', 'const');
model.sol('sol4').feature('s1').feature('fc1').set('maxiter', 8);
model.sol('sol4').feature('s1').feature.remove('fcDef');
model.sol('sol4').attach('std4');
model.sol('sol4').feature('s1').feature('p1').set('paramtuning', true);
model.sol('sol4').feature('s1').feature('p1').set('pminstep', '1e-5*max_average_strain');
model.sol('sol4').feature('s1').feature('p1').set('pinitstep', '0.01*max_average_strain');
model.sol('sol4').feature('s1').feature('p1').set('pmaxstep', '0.01*max_average_strain');
model.sol('sol4').feature('v1').set('scalemethod', 'manual');
model.sol('sol4').feature('v1').set('scaleval', '1.0e-4');

model.study('std4').setGenPlots(false);
model.study('std4').label('Implicit Gradient, Linear');

model.sol('sol4').runAll;

model.result('pg2').run;
model.result('pg2').create('ann1', 'Annotation');
model.result('pg2').feature('ann1').set('text', 'Quadratic Shape Order');
model.result('pg2').feature('ann1').set('posyexpr', '2*H');
model.result('pg2').feature('ann1').set('showpoint', false);
model.result('pg2').run;
model.result('pg2').run;
model.result('pg2').feature.duplicate('surf2', 'surf1');
model.result('pg2').feature.duplicate('mesh2', 'mesh1');
model.result('pg2').feature.duplicate('ann2', 'ann1');
model.result('pg2').run;
model.result('pg2').feature('surf2').set('data', 'dset3');
model.result('pg2').feature('surf2').set('inheritplot', 'surf1');
model.result('pg2').run;
model.result('pg2').feature('surf2').feature('def1').set('expr', {'u' 'v+4*H/100'});
model.result('pg2').run;
model.result('pg2').feature('mesh2').set('data', 'dset3');
model.result('pg2').run;
model.result('pg2').feature('mesh2').feature('def1').set('expr', {'u' 'v+4*H/100'});
model.result('pg2').run;
model.result('pg2').feature('ann2').set('text', 'Linear Shape Order');
model.result('pg2').feature('ann2').set('posyexpr', '6*H');
model.result('pg2').run;
model.result('pg2').run;
model.result.duplicate('pg3', 'pg2');
model.result('pg3').run;
model.result('pg3').label('Damage: Implicit Gradient');
model.result('pg3').set('data', 'dset2');
model.result('pg3').run;
model.result('pg3').feature('surf2').set('data', 'dset4');
model.result('pg3').run;
model.result('pg3').feature('mesh2').set('data', 'dset4');
model.result('pg3').run;
model.result.create('pg4', 'PlotGroup1D');
model.result('pg4').run;
model.result('pg4').label('Axial Force');
model.result('pg4').create('glob1', 'Global');
model.result('pg4').feature('glob1').set('markerpos', 'datapoints');
model.result('pg4').feature('glob1').set('linewidth', 'preference');
model.result('pg4').feature('glob1').setIndex('expr', 'intop1(solid.RFx)', 0);
model.result('pg4').feature('glob1').setIndex('descr', 'Force', 0);
model.result('pg4').feature('glob1').set('linewidth', 2);
model.result('pg4').feature('glob1').set('legendmethod', 'manual');
model.result('pg4').feature('glob1').setIndex('legends', 'Crack Band, Quadratic', 0);
model.result('pg4').feature.duplicate('glob2', 'glob1');
model.result('pg4').run;
model.result('pg4').feature('glob2').set('data', 'dset2');
model.result('pg4').feature('glob2').setIndex('legends', 'Implicit Gradient, Quadratic', 0);
model.result('pg4').feature.duplicate('glob3', 'glob2');
model.result('pg4').run;
model.result('pg4').feature('glob3').set('data', 'dset3');
model.result('pg4').feature('glob3').setIndex('legends', 'Crack Band, Linear', 0);
model.result('pg4').feature.duplicate('glob4', 'glob3');
model.result('pg4').run;
model.result('pg4').feature('glob4').set('data', 'dset4');
model.result('pg4').feature('glob4').setIndex('legends', 'Implicit Gradient, Linear', 0);
model.result('pg4').run;
model.result('pg4').set('titletype', 'none');
model.result('pg4').set('xlabelactive', true);
model.result('pg4').set('xlabel', 'Average strain');
model.result('pg4').run;
model.result.dataset.create('cpt1', 'CutPoint2D');
model.result.dataset('cpt1').set('pointx', 'L/2');
model.result.dataset('cpt1').set('pointy', 0);
model.result.dataset('cpt1').label('Cut Point: Study 1');
model.result.dataset.duplicate('cpt2', 'cpt1');
model.result.dataset('cpt2').label('Cut Point: Study 2');
model.result.dataset('cpt2').set('data', 'dset2');
model.result.dataset.duplicate('cpt3', 'cpt2');
model.result.dataset('cpt3').label('Cut Point: Study 3');
model.result.dataset('cpt3').set('data', 'dset3');
model.result.dataset.duplicate('cpt4', 'cpt3');
model.result.dataset('cpt4').label('Cut Point: Study 4');
model.result.dataset('cpt4').set('data', 'dset4');
model.result.create('pg5', 'PlotGroup1D');
model.result('pg5').run;
model.result('pg5').label('Damaged Stress vs. Strain');
model.result('pg5').set('titletype', 'none');
model.result('pg5').create('ptgr1', 'PointGraph');
model.result('pg5').feature('ptgr1').set('markerpos', 'datapoints');
model.result('pg5').feature('ptgr1').set('linewidth', 'preference');
model.result('pg5').feature('ptgr1').set('data', 'cpt1');
model.result('pg5').feature('ptgr1').set('expr', 'solid.sdGpxx');
model.result('pg5').feature('ptgr1').set('descr', 'Stress tensor, damaged, xx-component');
model.result('pg5').feature('ptgr1').set('xdata', 'expr');
model.result('pg5').feature('ptgr1').set('xdataexpr', 'solid.eXX');
model.result('pg5').feature('ptgr1').set('xdatadescr', 'Strain tensor, XX-component');
model.result('pg5').run;
model.result('pg5').feature('ptgr1').set('linewidth', 2);
model.result('pg5').feature('ptgr1').set('legend', true);
model.result('pg5').feature('ptgr1').set('legendmethod', 'manual');
model.result('pg5').feature('ptgr1').setIndex('legends', 'Crack Band, Quadratic', 0);
model.result('pg5').feature.duplicate('ptgr2', 'ptgr1');
model.result('pg5').run;
model.result('pg5').feature('ptgr2').set('data', 'cpt2');
model.result('pg5').feature('ptgr2').setIndex('legends', 'Implicit Gradient, Quadratic', 0);
model.result('pg5').feature.duplicate('ptgr3', 'ptgr2');
model.result('pg5').run;
model.result('pg5').feature('ptgr3').set('data', 'cpt3');
model.result('pg5').feature('ptgr3').setIndex('legends', 'Crack Band, Linear', 0);
model.result('pg5').feature.duplicate('ptgr4', 'ptgr3');
model.result('pg5').run;
model.result('pg5').feature('ptgr4').set('data', 'cpt4');
model.result('pg5').feature('ptgr4').setIndex('legends', 'Implicit Gradient, Linear', 0);
model.result('pg5').run;
model.result('pg5').run;
model.result.duplicate('pg6', 'pg5');
model.result('pg6').run;
model.result('pg6').label('Damage Evolution');
model.result('pg6').set('legendpos', 'lowerright');
model.result('pg6').run;
model.result('pg6').feature('ptgr1').set('xdataexpr', 'solid.dmg');
model.result('pg6').feature('ptgr1').set('expr', 'solid.dmg');
model.result('pg6').feature('ptgr1').set('xdata', 'solution');
model.result('pg6').run;
model.result('pg6').feature('ptgr2').set('expr', 'solid.dmg');
model.result('pg6').feature('ptgr2').set('xdata', 'solution');
model.result('pg6').run;
model.result('pg6').feature('ptgr3').set('expr', 'solid.dmg');
model.result('pg6').feature('ptgr3').set('xdata', 'solution');
model.result('pg6').run;
model.result('pg6').feature('ptgr4').set('expr', 'solid.dmg');
model.result('pg6').feature('ptgr4').set('xdata', 'solution');
model.result('pg6').run;
model.result.create('pg7', 'PlotGroup1D');
model.result('pg7').run;
model.result('pg7').label('Localization, Quadratic');
model.result('pg7').setIndex('looplevelinput', 'last', 0);
model.result('pg7').set('titletype', 'none');
model.result('pg7').create('lngr1', 'LineGraph');
model.result('pg7').feature('lngr1').set('markerpos', 'datapoints');
model.result('pg7').feature('lngr1').set('linewidth', 'preference');
model.result('pg7').feature('lngr1').selection.set([2]);
model.result('pg7').feature('lngr1').set('expr', 'solid.kappadmgGp');
model.result('pg7').feature('lngr1').set('descr', 'Maximum value of equivalent strain');
model.result('pg7').feature('lngr1').set('xdata', 'expr');
model.result('pg7').feature('lngr1').set('xdataexpr', 'X');
model.result('pg7').feature('lngr1').set('linewidth', 2);
model.result('pg7').feature('lngr1').set('linemarker', 'cycle');
model.result('pg7').feature('lngr1').set('markerpos', 'interp');
model.result('pg7').feature('lngr1').set('markers', 15);
model.result('pg7').feature('lngr1').set('resolution', 'norefine');
model.result('pg7').feature('lngr1').set('smooth', 'none');
model.result('pg7').feature('lngr1').set('legend', true);
model.result('pg7').feature('lngr1').set('legendmethod', 'manual');
model.result('pg7').feature('lngr1').setIndex('legends', 'CB: Max Eq. Strain', 0);
model.result('pg7').run;
model.result('pg7').feature.duplicate('lngr2', 'lngr1');
model.result('pg7').run;
model.result('pg7').feature('lngr2').set('data', 'dset2');
model.result('pg7').feature('lngr2').setIndex('looplevelinput', 'last', 0);
model.result('pg7').feature('lngr2').setIndex('legends', 'IG: Max Eq. Strain', 0);
model.result('pg7').run;
model.result('pg7').run;
model.result('pg7').feature.duplicate('lngr3', 'lngr1');
model.result('pg7').feature.duplicate('lngr4', 'lngr2');
model.result('pg7').run;
model.result('pg7').feature('lngr3').set('expr', 'solid.dmgGp');
model.result('pg7').feature('lngr3').set('descr', 'Damage');
model.result('pg7').feature('lngr3').setIndex('legends', 'CB: Damage', 0);
model.result('pg7').run;
model.result('pg7').feature('lngr4').set('expr', 'solid.dmg');
model.result('pg7').feature('lngr4').setIndex('legends', 'IG: Damage', 0);
model.result('pg7').run;
model.result('pg7').set('twoyaxes', true);
model.result('pg7').setIndex('plotonsecyaxis', true, 2, 1);
model.result('pg7').setIndex('plotonsecyaxis', true, 3, 1);
model.result('pg7').run;
model.result.duplicate('pg8', 'pg7');
model.result('pg8').run;
model.result('pg8').label('Localization, Linear');
model.result('pg8').set('data', 'dset3');
model.result('pg8').run;
model.result('pg8').feature('lngr2').set('data', 'dset4');
model.result('pg8').run;
model.result('pg8').feature('lngr4').set('data', 'dset4');
model.result('pg8').run;
model.result('pg7').run;
model.result.duplicate('pg9', 'pg7');
model.result('pg9').run;
model.result('pg9').label('Horizontal Displacement');
model.result('pg9').set('twoyaxes', false);
model.result('pg9').run;
model.result('pg9').feature('lngr1').set('expr', 'u');
model.result('pg9').feature('lngr1').setIndex('legends', 'Crack Band, Quadratic', 0);
model.result('pg9').feature('lngr1').set('markerpos', 'datapoints');
model.result('pg9').run;
model.result('pg9').feature('lngr2').set('expr', 'u');
model.result('pg9').feature('lngr2').setIndex('legends', 'Implicit Gradient, Quadratic', 0);
model.result('pg9').feature('lngr2').set('markerpos', 'datapoints');
model.result('pg9').run;
model.result('pg9').feature('lngr3').set('data', 'dset3');
model.result('pg9').feature('lngr3').setIndex('looplevelinput', 'last', 0);
model.result('pg9').feature('lngr3').set('expr', 'u');
model.result('pg9').feature('lngr3').setIndex('legends', 'Crack Band, Linear', 0);
model.result('pg9').feature('lngr3').set('markerpos', 'datapoints');
model.result('pg9').run;
model.result('pg9').feature('lngr4').set('data', 'dset4');
model.result('pg9').feature('lngr4').set('expr', 'u');
model.result('pg9').feature('lngr4').setIndex('legends', 'Implicit Gradient, Linear', 0);
model.result('pg9').feature('lngr4').set('markerpos', 'datapoints');
model.result('pg9').run;
model.result('pg9').set('axislimits', true);
model.result('pg9').set('xmin', 0.04);
model.result('pg9').set('xmax', 0.06);
model.result('pg9').set('legendpos', 'middleright');
model.result('pg9').run;
model.result('pg3').run;
model.result('pg3').feature('mesh1').active(false);
model.result('pg3').feature('ann1').active(false);
model.result('pg3').feature('mesh2').active(false);
model.result('pg3').feature('ann2').active(false);
model.result('pg3').run;
model.result('pg3').set('view', 'new');
model.result('pg3').run;

model.view('view2').set('locked', true);
model.view('view2').axis.set('viewscaletype', 'automatic');
model.view('view2').axis.set('autocontext', 'anisotropic');
model.view('view2').axis.set('xweight', 2);

model.result('pg3').run;
model.result('pg3').run;

model.view.remove('view2');

model.result('pg3').run;
model.result('pg3').feature('mesh1').active(true);
model.result('pg3').feature('ann1').active(true);
model.result('pg3').feature('mesh2').active(true);
model.result('pg3').feature('ann2').active(true);
model.result('pg4').run;

model.title('Brittle Damage in Uniaxial Tension');

model.description('In this tutorial model, the behavior of two models for brittle damage are shown in a uniaxial tension test.');

model.mesh.clearMeshes;

model.sol('sol1').clearSolutionData;
model.sol('sol2').clearSolutionData;
model.sol('sol3').clearSolutionData;
model.sol('sol4').clearSolutionData;

model.label('damage_test_bar.mph');

model.modelNode.label('Components');

out = model;
```

---

## Example 5: acoustics_pipe_system

**Module:** Acoustics_Module_Tutorials,_Pipe_Acoustics_acoustics_pipe_system  
**Category:** Unknown_Category  

### Model Description

**Model Overview**:
The model simulates the propagation of acoustic waves in a pipe system with a 3D bend and junction, coupling the Pipe Acoustics interface with the Pressure Acoustics interface. The simulation is performed in both time and frequency domains to analyze the response of the pipe system to acoustic signals, which can be relevant for detecting leaks or deformations in pipe systems used in the oil and gas industry and water delivery systems.

**Geometry**:
The geometric setup consists of a pipe system with long straight pipe portions connected by a 3D pipe junction and a 3D pipe bend. The dimensions and shapes are defined by parameters such as 'Di', 'L1', 'L2', 'L3', and 'L4', representing the inner diameter and lengths of different pipe sections.

**Materials**:
The model uses three instances of the "Water, liquid" material, each with different property functions for dynamic viscosity, heat capacity, density, thermal conductivity, and sound speed. The material properties are temperature-dependent and defined by piecewise and interpolation functions.

**Physics**:
The model involves several physics interfaces:
- Transient Pipe Acoustics (patd)
- Transient Pressure Acoustics (actd)
- Boundary Mode Acoustics (acbm)
- Frequency Pipe Acoustics (pafd)
- Pressure Acoustics (acpr)
- Acoustic Pipe Acoustic Connection (apc1 and apc2)

The equations governing the acoustic wave propagation are solved in the respective physics interfaces.

**Boundary Conditions**:
The model applies volume force excitation in the straight pipe sections and end impedance boundary conditions at the pipe ends. The specific expressions and locations of these boundary conditions are defined in the model setup.

**Mesh**:
The geometry is discretized using a combination of free tetrahedral and free triangular mesh elements. The mesh size is controlled by specifying maximum and minimum element sizes based on the wavelength and pipe diameter. Additional mesh refinement is applied to the 3D junction and bend regions.

**Study**:
The model performs transient analysis (Study 1) to simulate the time-domain response of the pipe system, mode analysis (Study 2) to identify the resonant modes in the 3D junction and bend regions, and frequency-domain analysis (Study 3) to evaluate the system's response at specific frequencies.

**Key Parameters**:
Important parameters include the signal frequency (f0), speed of sound (c0), wavelength (lam0), simulation end time (Tend), and pipe dimensions (Di, L1, L2, L3, L4). These parameters are defined in the model's parameter list.

**Expected Results**:
The model predicts the acoustic pressure distribution and propagation in the pipe system, including the effects of the 3D junction and bend. The results can be visualized as 3D pressure plots, surface plots, and point graphs showing the pressure variation at specific locations over time or frequency.

**Engineering Application**:
This model can be used to analyze and predict the acoustic response of pipe systems, aiding in the detection of leaks, deformations, or other anomalies. By understanding the acoustic wave propagation characteristics, engineers can design more efficient and reliable pipe systems for various applications, such as in the oil and gas industry and water delivery infrastructure.

### COMSOL MATLAB Code

```matlab
function out = model
%
% acoustics_pipe_system.m
%
% Model exported on May 26 2025, 21:25 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/Acoustics_Module/Tutorials,_Pipe_Acoustics');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 3);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.geom('geom1').insertFile('acoustics_pipe_system_geom_sequence.mph', 'geom1');
model.geom('geom1').run('fin');

model.view('view1').hideObjects.create('hide1');
model.view('view1').hideObjects('hide1').init(3);
model.view('view1').hideObjects('hide1').add('fin', [1]);
model.view('view1').hideObjects('hide1').add('fin', [2]);
model.view('view1').hideObjects('hide1').add('fin', [3]);
model.view('view1').set('hidestatus', 'showonlyhidden');
model.view('view1').hideObjects.clear;
model.view('view1').hideObjects.create('hide1');
model.view('view1').hideObjects('hide1').init(3);
model.view('view1').hideObjects('hide1').add('fin', [4]);
model.view('view1').hideObjects('hide1').add('fin', [5]);
model.view('view1').hideObjects('hide1').add('fin', [6]);
model.view('view1').set('hidestatus', 'ignore');
model.view('view1').hideObjects.clear;

model.param.label('Geometry');
model.param.create('par2');
model.param('par2').label('Model Parameters');

% To import content from file, use:
% model.param('par2').loadFile('FILENAME');
model.param('par2').set('f0', '120[Hz]', 'Signal frequency');
model.param('par2').set('c0', '1500[m/s]', 'Speed of sound');
model.param('par2').set('lam0', 'c0/f0', 'Wavelength at f0');
model.param('par2').set('T0', '1/f0', 'Period at f0');
model.param('par2').set('Tend', '2.5*lbent/c0', 'Simulation end time');
model.param('par2').set('Lprop', 'c0*Tend', 'Propagation length at Tend');
model.param('par2').set('lbent', 'L1+L3', 'Total distance to the bend');

model.func.create('rect1', 'Rectangle');
model.func('rect1').model('comp1');
model.func('rect1').set('lower', '0.5*T0');
model.func('rect1').set('upper', '3*T0');
model.func('rect1').set('smooth', 'T0');
model.func.create('an1', 'Analytic');
model.func('an1').model('comp1');
model.func('an1').label('Volume force');
model.func('an1').set('funcname', 'volforc');
model.func('an1').set('expr', 'rect1(t[1/s])*sin(2*pi*f0*t)');
model.func('an1').set('args', 't');
model.func('an1').setIndex('argunit', 's', 0);
model.func('an1').set('fununit', 'N/m^3');
model.func('an1').setIndex('plotargs', '3.5*T0', 0, 2);

model.selection.create('sel1', 'Explicit');
model.selection('sel1').model('comp1');
model.selection('sel1').label('1D Pipes');
model.selection('sel1').geom(1);
model.selection('sel1').set([1 2 20 37 60]);
model.selection.create('sel2', 'Explicit');
model.selection('sel2').model('comp1');
model.selection('sel2').label('Pipe Ends');
model.selection('sel2').geom(0);
model.selection('sel2').set([1 11 38]);

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
model.material.create('mat2', 'Common', 'comp1');
model.material('mat2').propertyGroup('def').func.create('eta', 'Piecewise');
model.material('mat2').propertyGroup('def').func.create('Cp', 'Piecewise');
model.material('mat2').propertyGroup('def').func.create('rho', 'Piecewise');
model.material('mat2').propertyGroup('def').func.create('k', 'Piecewise');
model.material('mat2').propertyGroup('def').func.create('cs', 'Interpolation');
model.material('mat2').propertyGroup('def').func.create('an1', 'Analytic');
model.material('mat2').propertyGroup('def').func.create('an2', 'Analytic');
model.material('mat2').propertyGroup('def').func.create('an3', 'Analytic');
model.material('mat2').label('Water, liquid 1');
model.material('mat2').set('family', 'water');
model.material('mat2').propertyGroup('def').func('eta').set('arg', 'T');
model.material('mat2').propertyGroup('def').func('eta').set('pieces', {'273.15' '413.15' '1.3799566804-0.021224019151*T^1+1.3604562827E-4*T^2-4.6454090319E-7*T^3+8.9042735735E-10*T^4-9.0790692686E-13*T^5+3.8457331488E-16*T^6'; '413.15' '553.75' '0.00401235783-2.10746715E-5*T^1+3.85772275E-8*T^2-2.39730284E-11*T^3'});
model.material('mat2').propertyGroup('def').func('eta').set('argunit', 'K');
model.material('mat2').propertyGroup('def').func('eta').set('fununit', 'Pa*s');
model.material('mat2').propertyGroup('def').func('Cp').set('arg', 'T');
model.material('mat2').propertyGroup('def').func('Cp').set('pieces', {'273.15' '553.75' '12010.1471-80.4072879*T^1+0.309866854*T^2-5.38186884E-4*T^3+3.62536437E-7*T^4'});
model.material('mat2').propertyGroup('def').func('Cp').set('argunit', 'K');
model.material('mat2').propertyGroup('def').func('Cp').set('fununit', 'J/(kg*K)');
model.material('mat2').propertyGroup('def').func('rho').set('arg', 'T');
model.material('mat2').propertyGroup('def').func('rho').set('smooth', 'contd1');
model.material('mat2').propertyGroup('def').func('rho').set('pieces', {'273.15' '293.15' '0.000063092789034*T^3-0.060367639882855*T^2+18.9229382407066*T-950.704055329848'; '293.15' '373.15' '0.000010335053319*T^3-0.013395065634452*T^2+4.969288832655160*T+432.257114008512'});
model.material('mat2').propertyGroup('def').func('rho').set('argunit', 'K');
model.material('mat2').propertyGroup('def').func('rho').set('fununit', 'kg/m^3');
model.material('mat2').propertyGroup('def').func('k').set('arg', 'T');
model.material('mat2').propertyGroup('def').func('k').set('pieces', {'273.15' '553.75' '-0.869083936+0.00894880345*T^1-1.58366345E-5*T^2+7.97543259E-9*T^3'});
model.material('mat2').propertyGroup('def').func('k').set('argunit', 'K');
model.material('mat2').propertyGroup('def').func('k').set('fununit', 'W/(m*K)');
model.material('mat2').propertyGroup('def').func('cs').set('table', {'273' '1403';  ...
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
model.material('mat2').propertyGroup('def').func('cs').set('interp', 'piecewisecubic');
model.material('mat2').propertyGroup('def').func('cs').set('fununit', {'m/s'});
model.material('mat2').propertyGroup('def').func('cs').set('argunit', {'K'});
model.material('mat2').propertyGroup('def').func('an1').set('funcname', 'alpha_p');
model.material('mat2').propertyGroup('def').func('an1').set('expr', '-1/rho(T)*d(rho(T),T)');
model.material('mat2').propertyGroup('def').func('an1').set('args', {'T'});
model.material('mat2').propertyGroup('def').func('an1').set('fununit', '1/K');
model.material('mat2').propertyGroup('def').func('an1').set('argunit', {'K'});
model.material('mat2').propertyGroup('def').func('an1').set('plotfixedvalue', {'273.15'});
model.material('mat2').propertyGroup('def').func('an1').set('plotargs', {'T' '273.15' '373.15'});
model.material('mat2').propertyGroup('def').func('an2').set('funcname', 'gamma_w');
model.material('mat2').propertyGroup('def').func('an2').set('expr', '1+(T/Cp(T))*(alpha_p(T)*cs(T))^2');
model.material('mat2').propertyGroup('def').func('an2').set('args', {'T'});
model.material('mat2').propertyGroup('def').func('an2').set('fununit', '1');
model.material('mat2').propertyGroup('def').func('an2').set('argunit', {'K'});
model.material('mat2').propertyGroup('def').func('an2').set('plotfixedvalue', {'273.15'});
model.material('mat2').propertyGroup('def').func('an2').set('plotargs', {'T' '273.15' '373.15'});
model.material('mat2').propertyGroup('def').func('an3').set('funcname', 'muB');
model.material('mat2').propertyGroup('def').func('an3').set('expr', '2.79*eta(T)');
model.material('mat2').propertyGroup('def').func('an3').set('args', {'T'});
model.material('mat2').propertyGroup('def').func('an3').set('fununit', 'Pa*s');
model.material('mat2').propertyGroup('def').func('an3').set('argunit', {'K'});
model.material('mat2').propertyGroup('def').func('an3').set('plotfixedvalue', {'273.15'});
model.material('mat2').propertyGroup('def').func('an3').set('plotargs', {'T' '273.15' '553.75'});
model.material('mat2').propertyGroup('def').set('thermalexpansioncoefficient', '');
model.material('mat2').propertyGroup('def').set('bulkviscosity', '');
model.material('mat2').propertyGroup('def').set('thermalexpansioncoefficient', {'alpha_p(T)' '0' '0' '0' 'alpha_p(T)' '0' '0' '0' 'alpha_p(T)'});
model.material('mat2').propertyGroup('def').set('bulkviscosity', 'muB(T)');
model.material('mat2').propertyGroup('def').set('dynamicviscosity', 'eta(T)');
model.material('mat2').propertyGroup('def').set('ratioofspecificheat', 'gamma_w(T)');
model.material('mat2').propertyGroup('def').set('electricconductivity', {'5.5e-6[S/m]' '0' '0' '0' '5.5e-6[S/m]' '0' '0' '0' '5.5e-6[S/m]'});
model.material('mat2').propertyGroup('def').set('heatcapacity', 'Cp(T)');
model.material('mat2').propertyGroup('def').set('density', 'rho(T)');
model.material('mat2').propertyGroup('def').set('thermalconductivity', {'k(T)' '0' '0' '0' 'k(T)' '0' '0' '0' 'k(T)'});
model.material('mat2').propertyGroup('def').set('soundspeed', 'cs(T)');
model.material('mat2').propertyGroup('def').addInput('temperature');
model.material.create('mat3', 'Common', 'comp1');
model.material('mat3').propertyGroup('def').func.create('eta', 'Piecewise');
model.material('mat3').propertyGroup('def').func.create('Cp', 'Piecewise');
model.material('mat3').propertyGroup('def').func.create('rho', 'Piecewise');
model.material('mat3').propertyGroup('def').func.create('k', 'Piecewise');
model.material('mat3').propertyGroup('def').func.create('cs', 'Interpolation');
model.material('mat3').propertyGroup('def').func.create('an1', 'Analytic');
model.material('mat3').propertyGroup('def').func.create('an2', 'Analytic');
model.material('mat3').propertyGroup('def').func.create('an3', 'Analytic');
model.material('mat3').label('Water, liquid 2');
model.material('mat3').set('family', 'water');
model.material('mat3').propertyGroup('def').func('eta').set('arg', 'T');
model.material('mat3').propertyGroup('def').func('eta').set('pieces', {'273.15' '413.15' '1.3799566804-0.021224019151*T^1+1.3604562827E-4*T^2-4.6454090319E-7*T^3+8.9042735735E-10*T^4-9.0790692686E-13*T^5+3.8457331488E-16*T^6'; '413.15' '553.75' '0.00401235783-2.10746715E-5*T^1+3.85772275E-8*T^2-2.39730284E-11*T^3'});
model.material('mat3').propertyGroup('def').func('eta').set('argunit', 'K');
model.material('mat3').propertyGroup('def').func('eta').set('fununit', 'Pa*s');
model.material('mat3').propertyGroup('def').func('Cp').set('arg', 'T');
model.material('mat3').propertyGroup('def').func('Cp').set('pieces', {'273.15' '553.75' '12010.1471-80.4072879*T^1+0.309866854*T^2-5.38186884E-4*T^3+3.62536437E-7*T^4'});
model.material('mat3').propertyGroup('def').func('Cp').set('argunit', 'K');
model.material('mat3').propertyGroup('def').func('Cp').set('fununit', 'J/(kg*K)');
model.material('mat3').propertyGroup('def').func('rho').set('arg', 'T');
model.material('mat3').propertyGroup('def').func('rho').set('smooth', 'contd1');
model.material('mat3').propertyGroup('def').func('rho').set('pieces', {'273.15' '293.15' '0.000063092789034*T^3-0.060367639882855*T^2+18.9229382407066*T-950.704055329848'; '293.15' '373.15' '0.000010335053319*T^3-0.013395065634452*T^2+4.969288832655160*T+432.257114008512'});
model.material('mat3').propertyGroup('def').func('rho').set('argunit', 'K');
model.material('mat3').propertyGroup('def').func('rho').set('fununit', 'kg/m^3');
model.material('mat3').propertyGroup('def').func('k').set('arg', 'T');
model.material('mat3').propertyGroup('def').func('k').set('pieces', {'273.15' '553.75' '-0.869083936+0.00894880345*T^1-1.58366345E-5*T^2+7.97543259E-9*T^3'});
model.material('mat3').propertyGroup('def').func('k').set('argunit', 'K');
model.material('mat3').propertyGroup('def').func('k').set('fununit', 'W/(m*K)');
model.material('mat3').propertyGroup('def').func('cs').set('table', {'273' '1403';  ...
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
model.material('mat3').propertyGroup('def').func('cs').set('interp', 'piecewisecubic');
model.material('mat3').propertyGroup('def').func('cs').set('fununit', {'m/s'});
model.material('mat3').propertyGroup('def').func('cs').set('argunit', {'K'});
model.material('mat3').propertyGroup('def').func('an1').set('funcname', 'alpha_p');
model.material('mat3').propertyGroup('def').func('an1').set('expr', '-1/rho(T)*d(rho(T),T)');
model.material('mat3').propertyGroup('def').func('an1').set('args', {'T'});
model.material('mat3').propertyGroup('def').func('an1').set('fununit', '1/K');
model.material('mat3').propertyGroup('def').func('an1').set('argunit', {'K'});
model.material('mat3').propertyGroup('def').func('an1').set('plotfixedvalue', {'273.15'});
model.material('mat3').propertyGroup('def').func('an1').set('plotargs', {'T' '273.15' '373.15'});
model.material('mat3').propertyGroup('def').func('an2').set('funcname', 'gamma_w');
model.material('mat3').propertyGroup('def').func('an2').set('expr', '1+(T/Cp(T))*(alpha_p(T)*cs(T))^2');
model.material('mat3').propertyGroup('def').func('an2').set('args', {'T'});
model.material('mat3').propertyGroup('def').func('an2').set('fununit', '1');
model.material('mat3').propertyGroup('def').func('an2').set('argunit', {'K'});
model.material('mat3').propertyGroup('def').func('an2').set('plotfixedvalue', {'273.15'});
model.material('mat3').propertyGroup('def').func('an2').set('plotargs', {'T' '273.15' '373.15'});
model.material('mat3').propertyGroup('def').func('an3').set('funcname', 'muB');
model.material('mat3').propertyGroup('def').func('an3').set('expr', '2.79*eta(T)');
model.material('mat3').propertyGroup('def').func('an3').set('args', {'T'});
model.material('mat3').propertyGroup('def').func('an3').set('fununit', 'Pa*s');
model.material('mat3').propertyGroup('def').func('an3').set('argunit', {'K'});
model.material('mat3').propertyGroup('def').func('an3').set('plotfixedvalue', {'273.15'});
model.material('mat3').propertyGroup('def').func('an3').set('plotargs', {'T' '273.15' '553.75'});
model.material('mat3').propertyGroup('def').set('thermalexpansioncoefficient', '');
model.material('mat3').propertyGroup('def').set('bulkviscosity', '');
model.material('mat3').propertyGroup('def').set('thermalexpansioncoefficient', {'alpha_p(T)' '0' '0' '0' 'alpha_p(T)' '0' '0' '0' 'alpha_p(T)'});
model.material('mat3').propertyGroup('def').set('bulkviscosity', 'muB(T)');
model.material('mat3').propertyGroup('def').set('dynamicviscosity', 'eta(T)');
model.material('mat3').propertyGroup('def').set('ratioofspecificheat', 'gamma_w(T)');
model.material('mat3').propertyGroup('def').set('electricconductivity', {'5.5e-6[S/m]' '0' '0' '0' '5.5e-6[S/m]' '0' '0' '0' '5.5e-6[S/m]'});
model.material('mat3').propertyGroup('def').set('heatcapacity', 'Cp(T)');
model.material('mat3').propertyGroup('def').set('density', 'rho(T)');
model.material('mat3').propertyGroup('def').set('thermalconductivity', {'k(T)' '0' '0' '0' 'k(T)' '0' '0' '0' 'k(T)'});
model.material('mat3').propertyGroup('def').set('soundspeed', 'cs(T)');
model.material('mat3').propertyGroup('def').addInput('temperature');
model.material('mat2').selection.geom('geom1', 1);
model.material('mat2').selection.named('sel1');
model.material('mat3').selection.geom('geom1', 2);
model.material('mat3').selection.set([1]);

model.physics.create('patd', 'TransientPipeAcoustics', 'geom1');
model.physics('patd').model('comp1');
model.physics.create('actd', 'TransientPressureAcoustics', 'geom1');
model.physics('actd').model('comp1');
model.physics.create('acbm', 'BoundaryModeAcoustics', 'geom1');
model.physics('acbm').model('comp1');
model.physics.create('pafd', 'FrequencyPipeAcoustics', 'geom1');
model.physics('pafd').model('comp1');
model.physics.create('acpr', 'PressureAcoustics', 'geom1');
model.physics('acpr').model('comp1');
model.physics('patd').selection.named('sel1');
model.physics('patd').prop('TransientSettings').set('fmax', 'f0');
model.physics('patd').feature('pipe1').set('shape', 'Round');
model.physics('patd').feature('pipe1').set('innerd', 'Di');
model.physics('patd').create('pipe2', 'PipeProperties', 1);
model.physics('patd').feature('pipe2').selection.set([20]);
model.physics('patd').feature('pipe2').set('shape', 'Round');
model.physics('patd').feature('pipe2').set('innerd', 'Di*2/3');
model.physics('patd').create('endimp1', 'EndImpedance', 0);
model.physics('patd').feature('endimp1').selection.named('sel2');
model.physics('patd').create('vf1', 'VolumeForce', 1);
model.physics('patd').feature('vf1').selection.set([1]);
model.physics('patd').feature('vf1').set('F', {'volforc(t)' '0' '0'});
model.physics('actd').prop('TransientSettings').set('fmax', 'f0');
model.physics('acbm').selection.set([1]);
model.physics('pafd').selection.named('sel1');
model.physics('pafd').feature('pipe1').set('shape', 'Round');
model.physics('pafd').feature('pipe1').set('innerd', 'Di');
model.physics('pafd').create('pipe2', 'PipeProperties', 1);
model.physics('pafd').feature('pipe2').selection.set([20]);
model.physics('pafd').feature('pipe2').set('shape', 'Round');
model.physics('pafd').feature('pipe2').set('innerd', 'Di*2/3');
model.physics('pafd').create('endimp1', 'EndImpedance', 0);
model.physics('pafd').feature('endimp1').selection.named('sel2');
model.physics('pafd').create('vf1', 'VolumeForce', 1);
model.physics('pafd').feature('vf1').selection.set([1]);
model.physics('pafd').feature('vf1').set('F', [1 0 0]);

model.multiphysics.create('apc1', 'AcousticPipeAcousticConnection', 'geom1', -1);
model.multiphysics.create('apc2', 'AcousticPipeAcousticConnection', 'geom1', -1);
model.multiphysics('apc2').set('Acoustics_physics', 'acpr');
model.multiphysics('apc2').set('Pipe_physics', 'pafd');

model.mesh('mesh1').create('ftet1', 'FreeTet');
model.mesh('mesh1').feature('size').set('custom', true);
model.mesh('mesh1').feature('size').set('hmax', 'min(lam0/12,Di/2)');
model.mesh('mesh1').feature('size').set('hmin', 'min(lam0/24,Di/6)');
model.mesh('mesh1').run('size');
model.mesh('mesh1').create('edg1', 'Edge');
model.mesh('mesh1').feature('edg1').selection.named('sel1');
model.mesh('mesh1').create('ftri1', 'FreeTri');
model.mesh('mesh1').feature('ftri1').selection.set([1]);
model.mesh('mesh1').feature('ftri1').create('size1', 'Size');
model.mesh('mesh1').feature('ftri1').feature('size1').set('custom', true);
model.mesh('mesh1').feature('ftri1').feature('size1').set('hmaxactive', true);
model.mesh('mesh1').feature('ftri1').feature('size1').set('hmax', 'Di/12');
model.mesh('mesh1').feature('ftri1').feature('size1').set('hminactive', true);
model.mesh('mesh1').feature('ftri1').feature('size1').set('hmin', 'Di/12');
model.mesh('mesh1').run;

model.study.create('std1');
model.study('std1').create('time', 'Transient');
model.study('std1').feature('time').setSolveFor('/physics/patd', true);
model.study('std1').feature('time').setSolveFor('/physics/actd', true);
model.study('std1').feature('time').setSolveFor('/physics/acbm', false);
model.study('std1').feature('time').setSolveFor('/physics/pafd', false);
model.study('std1').feature('time').setSolveFor('/physics/acpr', false);
model.study('std1').feature('time').setSolveFor('/multiphysics/apc1', true);
model.study('std1').feature('time').setSolveFor('/multiphysics/apc2', false);
model.study('std1').feature('time').set('tlist', 'range(0,T0/24,Tend)');
model.study('std1').setGenPlots(false);
model.study('std1').label('Study 1 - Pipe System Transient');

model.sol.create('sol1');
model.sol('sol1').study('std1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'time');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').set('control', 'time');
model.sol('sol1').create('t1', 'Time');
model.sol('sol1').feature('t1').set('tlist', 'range(0,T0/24,Tend)');
model.sol('sol1').feature('t1').set('plot', 'off');
model.sol('sol1').feature('t1').set('plotgroup', 'Default');
model.sol('sol1').feature('t1').set('plotfreq', 'tout');
model.sol('sol1').feature('t1').set('probesel', 'all');
model.sol('sol1').feature('t1').set('probes', {});
model.sol('sol1').feature('t1').set('probefreq', 'tsteps');
model.sol('sol1').feature('t1').set('rtol', 1.0E-4);
model.sol('sol1').feature('t1').set('atolglobalvaluemethod', 'factor');
model.sol('sol1').feature('t1').set('reacf', true);
model.sol('sol1').feature('t1').set('storeudot', true);
model.sol('sol1').feature('t1').set('tstepsgenalpha', 'manual');
model.sol('sol1').feature('t1').set('timestepgenalpha', 'min(1/(60*f0),1/(60*f0))');
model.sol('sol1').feature('t1').set('timestepbdf', 'min(1/(60*f0),1/(60*f0))');
model.sol('sol1').feature('t1').set('endtimeinterpolation', true);
model.sol('sol1').feature('t1').set('timemethod', 'genalpha');
model.sol('sol1').feature('t1').set('maxorder', 2);
model.sol('sol1').feature('t1').set('initialstepbdfactive', true);
model.sol('sol1').feature('t1').set('initialstepbdf', 'min(1/(100*f0),1/(100*f0))');
model.sol('sol1').feature('t1').set('maxstepconstraintbdf', 'const');
model.sol('sol1').feature('t1').set('maxstepbdf', 'min(min(1e100,1/(30*f0)),1/(30*f0))');
model.sol('sol1').feature('t1').set('initialstepgenalphaactive', true);
model.sol('sol1').feature('t1').set('initialstepgenalpha', 'min(1/(100*f0),1/(100*f0))');
model.sol('sol1').feature('t1').set('maxstepconstraintgenalpha', 'const');
model.sol('sol1').feature('t1').set('maxstepgenalpha', 'min(min(1e100,1/(30*f0)),1/(30*f0))');
model.sol('sol1').feature('t1').set('control', 'time');
model.sol('sol1').feature('t1').create('seDef', 'Segregated');
model.sol('sol1').feature('t1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('t1').feature('fc1').set('linsolver', 'dDef');
model.sol('sol1').feature('t1').feature.remove('fcDef');
model.sol('sol1').feature('t1').feature.remove('seDef');
model.sol('sol1').attach('std1');
model.sol('sol1').runAll;

model.study.create('std2');
model.study('std2').create('mode', 'ModeAnalysis');
model.study('std2').feature('mode').set('chkeigregion', true);
model.study('std2').feature('mode').set('conrad', '1');
model.study('std2').feature('mode').set('conradynhm', '1');
model.study('std2').feature('mode').set('storefact', false);
model.study('std2').feature('mode').set('linpsolnum', 'auto');
model.study('std2').feature('mode').set('solnum', 'auto');
model.study('std2').feature('mode').set('notsolnum', 'auto');
model.study('std2').feature('mode').set('outputmap', {});
model.study('std2').feature('mode').set('ngenAUX', '1');
model.study('std2').feature('mode').set('goalngenAUX', '1');
model.study('std2').feature('mode').set('ngenAUX', '1');
model.study('std2').feature('mode').set('goalngenAUX', '1');
model.study('std2').feature('mode').setSolveFor('/physics/patd', false);
model.study('std2').feature('mode').setSolveFor('/physics/actd', false);
model.study('std2').feature('mode').setSolveFor('/physics/acbm', true);
model.study('std2').feature('mode').setSolveFor('/physics/pafd', false);
model.study('std2').feature('mode').setSolveFor('/physics/acpr', false);
model.study('std2').feature('mode').setSolveFor('/multiphysics/apc1', false);
model.study('std2').feature('mode').setSolveFor('/multiphysics/apc2', false);
model.study('std2').label('Study 2 - Mode Analysis Cut on/off');
model.study('std2').setGenPlots(false);
model.study('std2').feature('mode').set('modeFreq', 'f0');
model.study('std2').feature('mode').set('neigsactive', true);
model.study('std2').feature('mode').set('neigs', 10);
model.study('std2').feature('mode').set('shiftactive', true);

model.sol.create('sol2');
model.sol('sol2').study('std2');
model.sol('sol2').create('st1', 'StudyStep');
model.sol('sol2').feature('st1').set('study', 'std2');
model.sol('sol2').feature('st1').set('studystep', 'mode');
model.sol('sol2').create('v1', 'Variables');
model.sol('sol2').feature('v1').set('control', 'mode');
model.sol('sol2').create('e1', 'Eigenvalue');
model.sol('sol2').feature('e1').set('neigs', 6);
model.sol('sol2').feature('e1').set('shift', '0');
model.sol('sol2').feature('e1').set('rtol', 1.0E-6);
model.sol('sol2').feature('e1').set('transform', 'none');
model.sol('sol2').feature('e1').set('eigref', '0');
model.sol('sol2').feature('e1').set('eigvfunscale', 'average');
model.sol('sol2').feature('e1').set('control', 'mode');
model.sol('sol2').feature('e1').feature('aDef').set('complexfun', true);
model.sol('sol2').feature('e1').feature('aDef').set('cachepattern', false);
model.sol('sol2').feature('e1').feature('aDef').set('matherr', true);
model.sol('sol2').feature('e1').feature('aDef').set('blocksizeactive', false);
model.sol('sol2').feature('e1').feature('aDef').set('nullfun', 'auto');
model.sol('sol2').attach('std2');
model.sol('sol2').runAll;

model.study.create('std3');
model.study('std3').create('freq', 'Frequency');
model.study('std3').feature('freq').setSolveFor('/physics/patd', false);
model.study('std3').feature('freq').setSolveFor('/physics/actd', false);
model.study('std3').feature('freq').setSolveFor('/physics/acbm', false);
model.study('std3').feature('freq').setSolveFor('/physics/pafd', true);
model.study('std3').feature('freq').setSolveFor('/physics/acpr', true);
model.study('std3').feature('freq').setSolveFor('/multiphysics/apc1', false);
model.study('std3').feature('freq').setSolveFor('/multiphysics/apc2', true);
model.study('std3').label('Study 3 - Pipe System Frequency Domain');
model.study('std3').setGenPlots(false);
model.study('std3').feature('freq').set('plist', 'f0');

model.sol.create('sol3');
model.sol('sol3').study('std3');
model.sol('sol3').create('st1', 'StudyStep');
model.sol('sol3').feature('st1').set('study', 'std3');
model.sol('sol3').feature('st1').set('studystep', 'freq');
model.sol('sol3').create('v1', 'Variables');
model.sol('sol3').feature('v1').set('control', 'freq');
model.sol('sol3').create('s1', 'Stationary');
model.sol('sol3').feature('s1').set('stol', 0.001);
model.sol('sol3').feature('s1').create('p1', 'Parametric');
model.sol('sol3').feature('s1').feature.remove('pDef');
model.sol('sol3').feature('s1').feature('p1').set('pname', {'freq'});
model.sol('sol3').feature('s1').feature('p1').set('plistarr', {'f0'});
model.sol('sol3').feature('s1').feature('p1').set('punit', {'Hz'});
model.sol('sol3').feature('s1').feature('p1').set('pcontinuationmode', 'no');
model.sol('sol3').feature('s1').feature('p1').set('preusesol', 'no');
model.sol('sol3').feature('s1').feature('p1').set('pdistrib', 'off');
model.sol('sol3').feature('s1').feature('p1').set('plot', 'off');
model.sol('sol3').feature('s1').feature('p1').set('plotgroup', 'Default');
model.sol('sol3').feature('s1').feature('p1').set('probesel', 'all');
model.sol('sol3').feature('s1').feature('p1').set('probes', {});
model.sol('sol3').feature('s1').feature('p1').set('control', 'freq');
model.sol('sol3').feature('s1').set('linpmethod', 'sol');
model.sol('sol3').feature('s1').set('linpsol', 'zero');
model.sol('sol3').feature('s1').set('control', 'freq');
model.sol('sol3').feature('s1').feature('aDef').set('complexfun', true);
model.sol('sol3').feature('s1').feature('aDef').set('cachepattern', true);
model.sol('sol3').feature('s1').feature('aDef').set('matherr', true);
model.sol('sol3').feature('s1').feature('aDef').set('blocksizeactive', false);
model.sol('sol3').feature('s1').create('seDef', 'Segregated');
model.sol('sol3').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol3').feature('s1').feature('fc1').set('linsolver', 'dDef');
model.sol('sol3').feature('s1').feature.remove('fcDef');
model.sol('sol3').feature('s1').feature.remove('seDef');
model.sol('sol3').attach('std3');
model.sol('sol3').runAll;

model.result.dataset.create('surf1', 'Surface');
model.result.dataset('surf1').set('data', 'dset2');
model.result.dataset('surf1').selection.set([1]);
model.result.create('pg1', 'PlotGroup3D');
model.result('pg1').run;
model.result('pg1').label('Acoustic Pressure (patd)');
model.result('pg1').setIndex('looplevel', 73, 0);
model.result('pg1').set('titletype', 'manual');
model.result('pg1').set('title', 'Pressure (Pa)');
model.result('pg1').set('paramindicator', 'Time= eval(t,s) s');
model.result('pg1').set('showlegendsmaxmin', true);
model.result('pg1').create('line1', 'Line');
model.result('pg1').feature('line1').set('rangecoloractive', true);
model.result('pg1').feature('line1').set('rangecolormin', -0.005);
model.result('pg1').feature('line1').set('rangecolormax', 0.005);
model.result('pg1').feature('line1').set('linetype', 'tube');
model.result('pg1').feature('line1').set('radiusexpr', '0.5*patd.dh');
model.result('pg1').feature('line1').set('tuberadiusscaleactive', true);
model.result('pg1').feature('line1').set('colortable', 'Wave');
model.result('pg1').feature('line1').set('colorscalemode', 'linearsymmetric');
model.result('pg1').feature('line1').create('def1', 'Deform');
model.result('pg1').run;
model.result('pg1').feature('line1').feature('def1').set('expr', {'0' '0' 'p'});
model.result('pg1').feature('line1').feature('def1').set('descractive', true);
model.result('pg1').feature('line1').feature('def1').set('descr', '20');
model.result('pg1').run;
model.result('pg1').create('surf1', 'Surface');
model.result('pg1').feature('surf1').set('expr', 'p2');
model.result('pg1').feature('surf1').set('inheritplot', 'line1');
model.result('pg1').feature('surf1').create('def1', 'Deform');
model.result('pg1').run;
model.result('pg1').feature('surf1').feature('def1').set('expr', {'0' '0' 'p2'});
model.result('pg1').run;
model.result('pg1').create('tlan1', 'TableAnnotation');
model.result('pg1').feature('tlan1').set('source', 'localtable');
model.result('pg1').feature('tlan1').setIndex('localtablematrix', '-L1+Lj/2', 0, 0);
model.result('pg1').feature('tlan1').setIndex('localtablematrix', 0, 0, 1);
model.result('pg1').feature('tlan1').setIndex('localtablematrix', 0, 0, 2);
model.result('pg1').feature('tlan1').setIndex('localtablematrix', 'Point A', 0, 3);
model.result('pg1').feature('tlan1').setIndex('localtablematrix', '-Lj/2', 1, 0);
model.result('pg1').feature('tlan1').setIndex('localtablematrix', '-L2', 1, 1);
model.result('pg1').feature('tlan1').setIndex('localtablematrix', 0, 1, 2);
model.result('pg1').feature('tlan1').setIndex('localtablematrix', 'Point B', 1, 3);
model.result('pg1').feature('tlan1').setIndex('localtablematrix', 'L3', 2, 0);
model.result('pg1').feature('tlan1').setIndex('localtablematrix', '-L4', 2, 1);
model.result('pg1').feature('tlan1').setIndex('localtablematrix', 0, 2, 2);
model.result('pg1').feature('tlan1').setIndex('localtablematrix', 'Point C', 2, 3);
model.result('pg1').run;
model.result('pg1').run;
model.result('pg1').setIndex('looplevel', 145, 0);
model.result('pg1').setIndex('looplevel', 217, 0);
model.result('pg1').setIndex('looplevel', 289, 0);
model.result.create('pg2', 'PlotGroup1D');
model.result('pg2').run;
model.result('pg2').label('Acoustic Pressure in Points');
model.result('pg2').set('titletype', 'manual');
model.result('pg2').set('title', 'Pressure at various points (Pa)');
model.result('pg2').set('xlabelactive', true);
model.result('pg2').set('xlabel', 'Time (s)');
model.result('pg2').set('ylabelactive', true);
model.result('pg2').set('ylabel', 'Pressure (Pa)');
model.result('pg2').set('legendpos', 'upperleft');
model.result('pg2').create('ptgr1', 'PointGraph');
model.result('pg2').feature('ptgr1').set('markerpos', 'datapoints');
model.result('pg2').feature('ptgr1').set('linewidth', 'preference');
model.result('pg2').feature('ptgr1').label('Point A');
model.result('pg2').feature('ptgr1').selection.set([2]);
model.result('pg2').feature('ptgr1').set('legend', true);
model.result('pg2').feature('ptgr1').set('autoplotlabel', true);
model.result('pg2').feature('ptgr1').set('autopoint', false);
model.result('pg2').feature('ptgr1').set('autosolution', false);
model.result('pg2').run;
model.result('pg2').create('ptgr2', 'PointGraph');
model.result('pg2').feature('ptgr2').set('markerpos', 'datapoints');
model.result('pg2').feature('ptgr2').set('linewidth', 'preference');
model.result('pg2').feature('ptgr2').label('Point B');
model.result('pg2').feature('ptgr2').selection.set([11]);
model.result('pg2').feature('ptgr2').set('expr', 'p+1[Pa]');
model.result('pg2').feature('ptgr2').set('legend', true);
model.result('pg2').feature('ptgr2').set('autoplotlabel', true);
model.result('pg2').feature('ptgr2').set('autopoint', false);
model.result('pg2').feature('ptgr2').set('autosolution', false);
model.result('pg2').feature('ptgr2').set('legendsuffix', ' (offset by 1 Pa)');
model.result('pg2').run;
model.result('pg2').create('ptgr3', 'PointGraph');
model.result('pg2').feature('ptgr3').set('markerpos', 'datapoints');
model.result('pg2').feature('ptgr3').set('linewidth', 'preference');
model.result('pg2').feature('ptgr3').label('Point C');
model.result('pg2').feature('ptgr3').selection.set([38]);
model.result('pg2').feature('ptgr3').set('expr', 'p+2[Pa]');
model.result('pg2').feature('ptgr3').set('legend', true);
model.result('pg2').feature('ptgr3').set('autoplotlabel', true);
model.result('pg2').feature('ptgr3').set('autopoint', false);
model.result('pg2').feature('ptgr3').set('autosolution', false);
model.result('pg2').feature('ptgr3').set('legendsuffix', ' (offset by 2 Pa)');
model.result('pg2').run;
model.result.create('pg3', 'PlotGroup2D');
model.result('pg3').run;
model.result('pg3').label('Mode Analysis Pressure (acbm)');
model.result('pg3').create('surf1', 'Surface');
model.result('pg3').feature('surf1').set('expr', 'p3');
model.result('pg3').feature('surf1').set('colortable', 'Wave');
model.result('pg3').feature('surf1').set('colorscalemode', 'linearsymmetric');
model.result('pg3').run;
model.result.create('pg4', 'PlotGroup3D');
model.result('pg4').run;
model.result('pg4').label('Acoustic Pressure (pafd)');
model.result('pg4').set('data', 'dset3');
model.result('pg4').set('titletype', 'manual');
model.result('pg4').set('title', 'Pressure (Pa)');
model.result('pg4').set('paramindicator', 'freq =eval(freq,Hz) Hz');
model.result('pg4').create('line1', 'Line');
model.result('pg4').feature('line1').set('expr', 'p4');
model.result('pg4').feature('line1').set('linetype', 'tube');
model.result('pg4').feature('line1').set('radiusexpr', '0.5*pafd.dh');
model.result('pg4').feature('line1').set('tuberadiusscaleactive', true);
model.result('pg4').feature('line1').set('colortable', 'Wave');
model.result('pg4').feature('line1').set('colorscalemode', 'linearsymmetric');
model.result('pg4').feature('line1').create('def1', 'Deform');
model.result('pg4').run;
model.result('pg4').feature('line1').feature('def1').set('expr', {'0' '0' 'p4'});
model.result('pg4').feature('line1').feature('def1').set('scaleactive', true);
model.result('pg4').feature('line1').feature('def1').set('scale', 2);
model.result('pg4').run;
model.result('pg4').create('surf1', 'Surface');
model.result('pg4').feature('surf1').set('expr', 'p5');
model.result('pg4').feature('surf1').set('inheritplot', 'line1');
model.result('pg4').feature('surf1').create('def1', 'Deform');
model.result('pg4').run;
model.result('pg4').feature('surf1').feature('def1').set('expr', {'0' '0' 'p5'});
model.result('pg4').run;
model.result('pg4').run;

model.title('Acoustics of a Pipe System with 3D Bend and Junction');

model.description(['This tutorial shows how to model the propagation of acoustic waves in large pipe systems by coupling the Pipe Acoustics interface to the Pressure Acoustics interface. The tutorial is set up in both the time domain and the frequency domain.' newline  newline '1D pipe acoustics is used to model the propagation in the long straight pipe portions. A 3D model of a pipe junction and pipe bend is coupled to the 1D pipe model in order to model these parts in detail.' newline  newline 'This kind of model can be used to model and predict the response of pipe systems, such as when detecting leaks or deformations, for example, and is relevant in the oil and gas industry and in water delivery pipe systems.']);

model.mesh.clearMeshes;

model.sol('sol1').clearSolutionData;
model.sol('sol2').clearSolutionData;
model.sol('sol3').clearSolutionData;

model.label('acoustics_pipe_system.mph');

model.modelNode.label('Components');

out = model;
```

---

## Example 6: plasmonic_wire_grating

**Module:** Wave_Optics_Module_Gratings_and_Metamaterials_plasmonic_wire_grating  
**Category:** Unknown_Category  

### Model Description

**Model Overview**:
The simulation model "plasmonic_wire_grating" is designed to analyze the diffraction of light by a wire grating on a dielectric substrate. The model focuses on computing diffraction efficiencies for the zeroth and first diffraction orders in both transmission and reflection as functions of the angle of incidence. This model is particularly relevant for studying the optical properties of periodic structures and their potential applications in areas such as optical communications, sensors, and photonic devices.

**Geometry**:
The geometric setup consists of a rectangular dielectric substrate with a periodic array of circular wires (grating) placed on top of it. The dimensions include a grating constant (d = 400 nm), which defines the periodicity of the structure, and the diameter of the wires (d/5). The substrate and the wires extend for a length of 3 times the grating constant (3*d) in the direction perpendicular to the incidence plane.

**Materials**:
Three materials are used in the model:
1. Air (refractive index, na = 1)
2. Dielectric (refractive index, nb = 1.2)
3. Gold (Au) - characterized by a complex refractive index based on the Brendel-Bormann model; the data for the refractive index and extinction coefficient are provided as interpolation functions of the wavelength.

**Physics**:
The model employs the Electromagnetic Waves, Frequency Domain interface (ewfd) to simulate the propagation and interaction of light with the grating structure. The physics interface solves Maxwell's equations in the frequency domain, considering both in-plane and out-of-plane field components for TE (Transverse Electric) and TM (Transverse Magnetic) polarizations.

**Boundary Conditions**:
The model applies periodic boundary conditions to simulate an infinitely periodic structure. Port boundary conditions are used to define the incident wave and to compute the reflection and transmission coefficients for different diffraction orders. The incident wave vector and the port mode wave vectors are defined based on the angle of incidence and the refractive indices of the materials.

**Mesh**:
The geometry is discretized using a mesh that is fine enough to resolve the optical wavelengths and the fine details of the wire grating. The mesh settings are not explicitly specified in the provided code but are typically generated automatically by COMSOL based on the specified physics and the minimum feature size of the geometry.

**Study**:
The model performs a frequency-domain analysis for different angles of incidence. The study is set up to compute the diffraction efficiencies as functions of the angle of incidence, sweeping through a range of values from 0 to 90 degrees.

**Key Parameters**:
- Grating constant (d = 400 nm)
- Wavelength of the incident light (lam0 = 441 nm)
- Refractive indices of air (na = 1) and dielectric (nb = 1.2)
- Angle of incidence (alpha, swept from 0 to 90 degrees)

**Expected Results**:
The model predicts the diffraction efficiencies (reflectance and transmittance) for the zeroth and first diffraction orders as functions of the angle of incidence. The results are presented in the form of plots showing the variation of the diffraction efficiencies with the angle of incidence for both TE and TM polarizations.

**Engineering Application**:
This model can be used to design and optimize periodic optical structures, such as diffraction gratings and metamaterials, for various engineering applications. These include designing efficient optical filters, sensors, and photonic devices that require precise control over the diffraction and propagation of light. By understanding the relationship between the geometric parameters, material properties, and the resulting diffraction patterns, engineers can tailor the design of these structures to achieve desired optical properties and performance characteristics.

### COMSOL MATLAB Code

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
model.material('mat3').propertyGroup('RefractiveIndex').func('int1').set('table', {'2.4797e-01' '1.4943e+00';  ...
'2.5201e-01' '1.5158e+00';  ...
'2.5612e-01' '1.5382e+00';  ...
'2.6030e-01' '1.5611e+00';  ...
'2.6454e-01' '1.5844e+00';  ...
'2.6886e-01' '1.6078e+00';  ...
'2.7324e-01' '1.6306e+00';  ...
'2.7770e-01' '1.6527e+00';  ...
'2.8222e-01' '1.6733e+00';  ...
'2.8683e-01' '1.6921e+00';  ...
'2.9150e-01' '1.7085e+00';  ...
'2.9626e-01' '1.7220e+00';  ...
'3.0109e-01' '1.7322e+00';  ...
'3.0600e-01' '1.7387e+00';  ...
'3.1099e-01' '1.7411e+00';  ...
'3.1606e-01' '1.7391e+00';  ...
'3.2121e-01' '1.7327e+00';  ...
'3.2645e-01' '1.7219e+00';  ...
'3.3177e-01' '1.7071e+00';  ...
'3.3718e-01' '1.6887e+00';  ...
'3.4268e-01' '1.6677e+00';  ...
'3.4827e-01' '1.6452e+00';  ...
'3.5395e-01' '1.6224e+00';  ...
'3.5972e-01' '1.6006e+00';  ...
'3.6559e-01' '1.5810e+00';  ...
'3.7155e-01' '1.5645e+00';  ...
'3.7761e-01' '1.5515e+00';  ...
'3.8377e-01' '1.5419e+00';  ...
'3.9002e-01' '1.5351e+00';  ...
'3.9638e-01' '1.5301e+00';  ...
'4.0285e-01' '1.5255e+00';  ...
'4.0942e-01' '1.5196e+00';  ...
'4.1609e-01' '1.5107e+00';  ...
'4.2288e-01' '1.4971e+00';  ...
'4.2977e-01' '1.4771e+00';  ...
'4.3678e-01' '1.4493e+00';  ...
'4.4390e-01' '1.4126e+00';  ...
'4.5114e-01' '1.3661e+00';  ...
'4.5850e-01' '1.3095e+00';  ...
'4.6598e-01' '1.2427e+00';  ...
'4.7358e-01' '1.1664e+00';  ...
'4.8130e-01' '1.0821e+00';  ...
'4.8915e-01' '9.9182e-01';  ...
'4.9712e-01' '8.9849e-01';  ...
'5.0523e-01' '8.0543e-01';  ...
'5.1347e-01' '7.1590e-01';  ...
'5.2184e-01' '6.3260e-01';  ...
'5.3035e-01' '5.5731e-01';  ...
'5.3900e-01' '4.9085e-01';  ...
'5.4779e-01' '4.3326e-01';  ...
'5.5672e-01' '3.8405e-01';  ...
'5.6580e-01' '3.4242e-01';  ...
'5.7503e-01' '3.0751e-01';  ...
'5.8440e-01' '2.7843e-01';  ...
'5.9393e-01' '2.5437e-01';  ...
'6.0362e-01' '2.3457e-01';  ...
'6.1346e-01' '2.1841e-01';  ...
'6.2346e-01' '2.0533e-01';  ...
'6.3363e-01' '1.9487e-01';  ...
'6.4396e-01' '1.8664e-01';  ...
'6.5446e-01' '1.8030e-01';  ...
'6.6514e-01' '1.7558e-01';  ...
'6.7598e-01' '1.7227e-01';  ...
'6.8701e-01' '1.7016e-01';  ...
'6.9821e-01' '1.6911e-01';  ...
'7.0959e-01' '1.6897e-01';  ...
'7.2117e-01' '1.6966e-01';  ...
'7.3292e-01' '1.7107e-01';  ...
'7.4488e-01' '1.7313e-01';  ...
'7.5702e-01' '1.7577e-01';  ...
'7.6937e-01' '1.7895e-01';  ...
'7.8191e-01' '1.8262e-01';  ...
'7.9466e-01' '1.8675e-01';  ...
'8.0762e-01' '1.9129e-01';  ...
'8.2079e-01' '1.9621e-01';  ...
'8.3418e-01' '2.0151e-01';  ...
'8.4778e-01' '2.0715e-01';  ...
'8.6160e-01' '2.1311e-01';  ...
'8.7565e-01' '2.1938e-01';  ...
'8.8993e-01' '2.2594e-01';  ...
'9.0445e-01' '2.3278e-01';  ...
'9.1919e-01' '2.3989e-01';  ...
'9.3418e-01' '2.4725e-01';  ...
'9.4942e-01' '2.5486e-01';  ...
'9.6490e-01' '2.6271e-01';  ...
'9.8063e-01' '2.7079e-01';  ...
'9.9662e-01' '2.7909e-01';  ...
'1.0129e+00' '2.8761e-01';  ...
'1.0294e+00' '2.9634e-01';  ...
'1.0462e+00' '3.0528e-01';  ...
'1.0632e+00' '3.1442e-01';  ...
'1.0806e+00' '3.2376e-01';  ...
'1.0982e+00' '3.3329e-01';  ...
'1.1161e+00' '3.4302e-01';  ...
'1.1343e+00' '3.5293e-01';  ...
'1.1528e+00' '3.6304e-01';  ...
'1.1716e+00' '3.7334e-01';  ...
'1.1907e+00' '3.8382e-01';  ...
'1.2101e+00' '3.9449e-01';  ...
'1.2299e+00' '4.0535e-01';  ...
'1.2499e+00' '4.1641e-01';  ...
'1.2703e+00' '4.2765e-01';  ...
'1.2910e+00' '4.3909e-01';  ...
'1.3121e+00' '4.5072e-01';  ...
'1.3335e+00' '4.6256e-01';  ...
'1.3552e+00' '4.7459e-01';  ...
'1.3773e+00' '4.8684e-01';  ...
'1.3998e+00' '4.9930e-01';  ...
'1.4226e+00' '5.1198e-01';  ...
'1.4458e+00' '5.2488e-01';  ...
'1.4694e+00' '5.3801e-01';  ...
'1.4933e+00' '5.5138e-01';  ...
'1.5177e+00' '5.6499e-01';  ...
'1.5424e+00' '5.7885e-01';  ...
'1.5676e+00' '5.9297e-01';  ...
'1.5931e+00' '6.0736e-01';  ...
'1.6191e+00' '6.2203e-01';  ...
'1.6455e+00' '6.3699e-01';  ...
'1.6723e+00' '6.5224e-01';  ...
'1.6996e+00' '6.6780e-01';  ...
'1.7273e+00' '6.8368e-01';  ...
'1.7555e+00' '6.9989e-01';  ...
'1.7841e+00' '7.1645e-01';  ...
'1.8132e+00' '7.3336e-01';  ...
'1.8428e+00' '7.5065e-01';  ...
'1.8728e+00' '7.6831e-01';  ...
'1.9034e+00' '7.8638e-01';  ...
'1.9344e+00' '8.0486e-01';  ...
'1.9660e+00' '8.2377e-01';  ...
'1.9980e+00' '8.4313e-01';  ...
'2.0306e+00' '8.6294e-01';  ...
'2.0637e+00' '8.8324e-01';  ...
'2.0974e+00' '9.0404e-01';  ...
'2.1316e+00' '9.2535e-01';  ...
'2.1663e+00' '9.4720e-01';  ...
'2.2016e+00' '9.6961e-01';  ...
'2.2375e+00' '9.9259e-01';  ...
'2.2740e+00' '1.0162e+00';  ...
'2.3111e+00' '1.0404e+00';  ...
'2.3488e+00' '1.0652e+00';  ...
'2.3871e+00' '1.0907e+00';  ...
'2.4260e+00' '1.1169e+00';  ...
'2.4656e+00' '1.1438e+00';  ...
'2.5058e+00' '1.1715e+00';  ...
'2.5467e+00' '1.1999e+00';  ...
'2.5882e+00' '1.2291e+00';  ...
'2.6304e+00' '1.2592e+00';  ...
'2.6733e+00' '1.2901e+00';  ...
'2.7169e+00' '1.3219e+00';  ...
'2.7612e+00' '1.3545e+00';  ...
'2.8062e+00' '1.3882e+00';  ...
'2.8520e+00' '1.4228e+00';  ...
'2.8985e+00' '1.4584e+00';  ...
'2.9457e+00' '1.4951e+00';  ...
'2.9938e+00' '1.5328e+00';  ...
'3.0426e+00' '1.5717e+00';  ...
'3.0922e+00' '1.6117e+00';  ...
'3.1426e+00' '1.6529e+00';  ...
'3.1939e+00' '1.6954e+00';  ...
'3.2460e+00' '1.7391e+00';  ...
'3.2989e+00' '1.7842e+00';  ...
'3.3527e+00' '1.8306e+00';  ...
'3.4074e+00' '1.8784e+00';  ...
'3.4629e+00' '1.9277e+00';  ...
'3.5194e+00' '1.9785e+00';  ...
'3.5768e+00' '2.0308e+00';  ...
'3.6351e+00' '2.0847e+00';  ...
'3.6944e+00' '2.1403e+00';  ...
'3.7546e+00' '2.1976e+00';  ...
'3.8159e+00' '2.2566e+00';  ...
'3.8781e+00' '2.3175e+00';  ...
'3.9413e+00' '2.3802e+00';  ...
'4.0056e+00' '2.4449e+00';  ...
'4.0709e+00' '2.5116e+00';  ...
'4.1373e+00' '2.5803e+00';  ...
'4.2048e+00' '2.6511e+00';  ...
'4.2733e+00' '2.7242e+00';  ...
'4.3430e+00' '2.7995e+00';  ...
'4.4138e+00' '2.8771e+00';  ...
'4.4858e+00' '2.9572e+00';  ...
'4.5589e+00' '3.0397e+00';  ...
'4.6333e+00' '3.1247e+00';  ...
'4.7088e+00' '3.2124e+00';  ...
'4.7856e+00' '3.3028e+00';  ...
'4.8637e+00' '3.3960e+00';  ...
'4.9430e+00' '3.4921e+00';  ...
'5.0236e+00' '3.5911e+00';  ...
'5.1055e+00' '3.6932e+00';  ...
'5.1888e+00' '3.7985e+00';  ...
'5.2734e+00' '3.9069e+00';  ...
'5.3594e+00' '4.0187e+00';  ...
'5.4468e+00' '4.1340e+00';  ...
'5.5356e+00' '4.2528e+00';  ...
'5.6258e+00' '4.3752e+00';  ...
'5.7176e+00' '4.5013e+00';  ...
'5.8108e+00' '4.6314e+00';  ...
'5.9056e+00' '4.7653e+00';  ...
'6.0019e+00' '4.9034e+00';  ...
'6.0997e+00' '5.0456e+00';  ...
'6.1992e+00' '5.1922e+00'});
model.material('mat3').propertyGroup('RefractiveIndex').func('int1').set('fununit', {'1'});
model.material('mat3').propertyGroup('RefractiveIndex').func('int1').set('argunit', {'um'});
model.material('mat3').propertyGroup('RefractiveIndex').func('int2').set('funcname', 'ni');
model.material('mat3').propertyGroup('RefractiveIndex').func('int2').set('table', {'2.4797e-01' '1.9575e+00';  ...
'2.5201e-01' '1.9594e+00';  ...
'2.5612e-01' '1.9605e+00';  ...
'2.6030e-01' '1.9604e+00';  ...
'2.6454e-01' '1.9587e+00';  ...
'2.6886e-01' '1.9551e+00';  ...
'2.7324e-01' '1.9494e+00';  ...
'2.7770e-01' '1.9414e+00';  ...
'2.8222e-01' '1.9312e+00';  ...
'2.8683e-01' '1.9188e+00';  ...
'2.9150e-01' '1.9042e+00';  ...
'2.9626e-01' '1.8879e+00';  ...
'3.0109e-01' '1.8700e+00';  ...
'3.0600e-01' '1.8512e+00';  ...
'3.1099e-01' '1.8319e+00';  ...
'3.1606e-01' '1.8128e+00';  ...
'3.2121e-01' '1.7946e+00';  ...
'3.2645e-01' '1.7784e+00';  ...
'3.3177e-01' '1.7648e+00';  ...
'3.3718e-01' '1.7548e+00';  ...
'3.4268e-01' '1.7490e+00';  ...
'3.4827e-01' '1.7479e+00';  ...
'3.5395e-01' '1.7516e+00';  ...
'3.5972e-01' '1.7597e+00';  ...
'3.6559e-01' '1.7714e+00';  ...
'3.7155e-01' '1.7856e+00';  ...
'3.7761e-01' '1.8007e+00';  ...
'3.8377e-01' '1.8152e+00';  ...
'3.9002e-01' '1.8276e+00';  ...
'3.9638e-01' '1.8366e+00';  ...
'4.0285e-01' '1.8413e+00';  ...
'4.0942e-01' '1.8411e+00';  ...
'4.1609e-01' '1.8362e+00';  ...
'4.2288e-01' '1.8268e+00';  ...
'4.2977e-01' '1.8140e+00';  ...
'4.3678e-01' '1.7988e+00';  ...
'4.4390e-01' '1.7829e+00';  ...
'4.5114e-01' '1.7681e+00';  ...
'4.5850e-01' '1.7567e+00';  ...
'4.6598e-01' '1.7509e+00';  ...
'4.7358e-01' '1.7532e+00';  ...
'4.8130e-01' '1.7661e+00';  ...
'4.8915e-01' '1.7916e+00';  ...
'4.9712e-01' '1.8312e+00';  ...
'5.0523e-01' '1.8852e+00';  ...
'5.1347e-01' '1.9530e+00';  ...
'5.2184e-01' '2.0328e+00';  ...
'5.3035e-01' '2.1222e+00';  ...
'5.3900e-01' '2.2188e+00';  ...
'5.4779e-01' '2.3201e+00';  ...
'5.5672e-01' '2.4245e+00';  ...
'5.6580e-01' '2.5305e+00';  ...
'5.7503e-01' '2.6370e+00';  ...
'5.8440e-01' '2.7434e+00';  ...
'5.9393e-01' '2.8493e+00';  ...
'6.0362e-01' '2.9545e+00';  ...
'6.1346e-01' '3.0587e+00';  ...
'6.2346e-01' '3.1621e+00';  ...
'6.3363e-01' '3.2645e+00';  ...
'6.4396e-01' '3.3662e+00';  ...
'6.5446e-01' '3.4671e+00';  ...
'6.6514e-01' '3.5675e+00';  ...
'6.7598e-01' '3.6674e+00';  ...
'6.8701e-01' '3.7669e+00';  ...
'6.9821e-01' '3.8661e+00';  ...
'7.0959e-01' '3.9653e+00';  ...
'7.2117e-01' '4.0644e+00';  ...
'7.3292e-01' '4.1635e+00';  ...
'7.4488e-01' '4.2629e+00';  ...
'7.5702e-01' '4.3625e+00';  ...
'7.6937e-01' '4.4624e+00';  ...
'7.8191e-01' '4.5627e+00';  ...
'7.9466e-01' '4.6635e+00';  ...
'8.0762e-01' '4.7649e+00';  ...
'8.2079e-01' '4.8669e+00';  ...
'8.3418e-01' '4.9695e+00';  ...
'8.4778e-01' '5.0729e+00';  ...
'8.6160e-01' '5.1770e+00';  ...
'8.7565e-01' '5.2820e+00';  ...
'8.8993e-01' '5.3878e+00';  ...
'9.0445e-01' '5.4946e+00';  ...
'9.1919e-01' '5.6024e+00';  ...
'9.3418e-01' '5.7111e+00';  ...
'9.4942e-01' '5.8210e+00';  ...
'9.6490e-01' '5.9319e+00';  ...
'9.8063e-01' '6.0440e+00';  ...
'9.9662e-01' '6.1573e+00';  ...
'1.0129e+00' '6.2718e+00';  ...
'1.0294e+00' '6.3875e+00';  ...
'1.0462e+00' '6.5046e+00';  ...
'1.0632e+00' '6.6231e+00';  ...
'1.0806e+00' '6.7429e+00';  ...
'1.0982e+00' '6.8642e+00';  ...
'1.1161e+00' '6.9869e+00';  ...
'1.1343e+00' '7.1112e+00';  ...
'1.1528e+00' '7.2370e+00';  ...
'1.1716e+00' '7.3644e+00';  ...
'1.1907e+00' '7.4935e+00';  ...
'1.2101e+00' '7.6242e+00';  ...
'1.2299e+00' '7.7566e+00';  ...
'1.2499e+00' '7.8908e+00';  ...
'1.2703e+00' '8.0268e+00';  ...
'1.2910e+00' '8.1646e+00';  ...
'1.3121e+00' '8.3044e+00';  ...
'1.3335e+00' '8.4460e+00';  ...
'1.3552e+00' '8.5896e+00';  ...
'1.3773e+00' '8.7353e+00';  ...
'1.3998e+00' '8.8829e+00';  ...
'1.4226e+00' '9.0327e+00';  ...
'1.4458e+00' '9.1847e+00';  ...
'1.4694e+00' '9.3388e+00';  ...
'1.4933e+00' '9.4951e+00';  ...
'1.5177e+00' '9.6538e+00';  ...
'1.5424e+00' '9.8147e+00';  ...
'1.5676e+00' '9.9780e+00';  ...
'1.5931e+00' '1.0144e+01';  ...
'1.6191e+00' '1.0312e+01';  ...
'1.6455e+00' '1.0483e+01';  ...
'1.6723e+00' '1.0656e+01';  ...
'1.6996e+00' '1.0832e+01';  ...
'1.7273e+00' '1.1010e+01';  ...
'1.7555e+00' '1.1192e+01';  ...
'1.7841e+00' '1.1376e+01';  ...
'1.8132e+00' '1.1563e+01';  ...
'1.8428e+00' '1.1752e+01';  ...
'1.8728e+00' '1.1945e+01';  ...
'1.9034e+00' '1.2140e+01';  ...
'1.9344e+00' '1.2339e+01';  ...
'1.9660e+00' '1.2541e+01';  ...
'1.9980e+00' '1.2745e+01';  ...
'2.0306e+00' '1.2953e+01';  ...
'2.0637e+00' '1.3164e+01';  ...
'2.0974e+00' '1.3379e+01';  ...
'2.1316e+00' '1.3597e+01';  ...
'2.1663e+00' '1.3818e+01';  ...
'2.2016e+00' '1.4042e+01';  ...
'2.2375e+00' '1.4271e+01';  ...
'2.2740e+00' '1.4502e+01';  ...
'2.3111e+00' '1.4738e+01';  ...
'2.3488e+00' '1.4977e+01';  ...
'2.3871e+00' '1.5219e+01';  ...
'2.4260e+00' '1.5466e+01';  ...
'2.4656e+00' '1.5717e+01';  ...
'2.5058e+00' '1.5971e+01';  ...
'2.5467e+00' '1.6229e+01';  ...
'2.5882e+00' '1.6492e+01';  ...
'2.6304e+00' '1.6758e+01';  ...
'2.6733e+00' '1.7029e+01';  ...
'2.7169e+00' '1.7304e+01';  ...
'2.7612e+00' '1.7584e+01';  ...
'2.8062e+00' '1.7867e+01';  ...
'2.8520e+00' '1.8156e+01';  ...
'2.8985e+00' '1.8448e+01';  ...
'2.9457e+00' '1.8746e+01';  ...
'2.9938e+00' '1.9048e+01';  ...
'3.0426e+00' '1.9354e+01';  ...
'3.0922e+00' '1.9666e+01';  ...
'3.1426e+00' '1.9982e+01';  ...
'3.1939e+00' '2.0304e+01';  ...
'3.2460e+00' '2.0630e+01';  ...
'3.2989e+00' '2.0962e+01';  ...
'3.3527e+00' '2.1299e+01';  ...
'3.4074e+00' '2.1640e+01';  ...
'3.4629e+00' '2.1988e+01';  ...
'3.5194e+00' '2.2340e+01';  ...
'3.5768e+00' '2.2699e+01';  ...
'3.6351e+00' '2.3062e+01';  ...
'3.6944e+00' '2.3432e+01';  ...
'3.7546e+00' '2.3807e+01';  ...
'3.8159e+00' '2.4188e+01';  ...
'3.8781e+00' '2.4575e+01';  ...
'3.9413e+00' '2.4967e+01';  ...
'4.0056e+00' '2.5366e+01';  ...
'4.0709e+00' '2.5771e+01';  ...
'4.1373e+00' '2.6182e+01';  ...
'4.2048e+00' '2.6600e+01';  ...
'4.2733e+00' '2.7023e+01';  ...
'4.3430e+00' '2.7454e+01';  ...
'4.4138e+00' '2.7890e+01';  ...
'4.4858e+00' '2.8334e+01';  ...
'4.5589e+00' '2.8784e+01';  ...
'4.6333e+00' '2.9241e+01';  ...
'4.7088e+00' '2.9705e+01';  ...
'4.7856e+00' '3.0176e+01';  ...
'4.8637e+00' '3.0653e+01';  ...
'4.9430e+00' '3.1139e+01';  ...
'5.0236e+00' '3.1631e+01';  ...
'5.1055e+00' '3.2130e+01';  ...
'5.1888e+00' '3.2637e+01';  ...
'5.2734e+00' '3.3152e+01';  ...
'5.3594e+00' '3.3674e+01';  ...
'5.4468e+00' '3.4204e+01';  ...
'5.5356e+00' '3.4741e+01';  ...
'5.6258e+00' '3.5287e+01';  ...
'5.7176e+00' '3.5840e+01';  ...
'5.8108e+00' '3.6401e+01';  ...
'5.9056e+00' '3.6971e+01';  ...
'6.0019e+00' '3.7548e+01';  ...
'6.0997e+00' '3.8134e+01';  ...
'6.1992e+00' '3.8728e+01'});
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

model.result.create('pg1', 'PlotGroup2D');
model.result('pg1').label('Electric Field (ewfd)');
model.result('pg1').set('frametype', 'spatial');
model.result('pg1').set('data', 'dset1');
model.result('pg1').setIndex('looplevel', 20, 0);
model.result('pg1').setIndex('looplevel', 1, 1);
model.result('pg1').set('defaultPlotID', 'ElectromagneticWavesFrequencyDomain/phys1/pdef1/pcond2/pg1');
model.result('pg1').feature.create('surf1', 'Surface');
model.result('pg1').feature('surf1').set('smooth', 'internal');
model.result('pg1').feature('surf1').set('data', 'parent');
model.result.create('pg2', 'PlotGroup1D');
model.result('pg2').set('data', 'dset1');
model.result('pg2').create('glob1', 'Global');
model.result('pg2').feature('glob1').set('unit', {'' '' '' '' '' '' '' '' '' ''});
model.result('pg2').feature('glob1').set('expr', {'ewfd.Rorder_0' 'ewfd.Rorder_n1_op' 'ewfd.Rorder_p1_op' 'ewfd.Rtotal' 'ewfd.Torder_0' 'ewfd.Torder_n1_op' 'ewfd.Torder_p1_op' 'ewfd.Ttotal' 'ewfd.RTtotal' 'ewfd.Atotal'});
model.result('pg2').feature('glob1').set('descr', {'Reflectance, order 0' 'Reflectance, order -1, out-of-plane' 'Reflectance, order 1, out-of-plane' 'Total reflectance' 'Transmittance, order 0' 'Transmittance, order -1, out-of-plane' 'Transmittance, order 1, out-of-plane' 'Total transmittance' 'Total reflectance and transmittance' 'Absorptance'});
model.result('pg2').label('Reflectance, Transmittance, and Absorptance (ewfd)');
model.result('pg2').feature('glob1').set('titletype', 'none');
model.result('pg2').feature('glob1').set('xdata', 'expr');
model.result('pg2').set('ylabelactive', true);
model.result('pg2').set('ylabel', 'Reflectance, transmittance, and absorptance (1)');
model.result('pg2').feature('glob1').set('xdataexpr', 'alpha');
model.result('pg2').feature('glob1').set('xdataunit', 'deg');
model.result('pg2').feature('glob1').set('markerpos', 'datapoints');
model.result('pg2').feature('glob1').set('xdatasolnumtype', 'all');
model.result('pg1').run;
model.result('pg1').create('arwl1', 'ArrowLine');
model.result('pg1').feature('arwl1').set('expr', {'ewfd.kIncx_1' 'ewfd.kIncy_1'});
model.result('pg1').feature('arwl1').set('descr', 'Incident wave vector');
model.result('pg1').feature('arwl1').set('color', 'magenta');
model.result('pg1').feature('arwl1').set('descractive', true);
model.result('pg1').feature('arwl1').set('descr', 'Incident wave (magenta)');
model.result('pg1').run;
model.result('pg1').create('arwl2', 'ArrowLine');
model.result('pg1').feature('arwl2').set('expr', {'ewfd.kModex_1' 'ewfd.kModey_1'});
model.result('pg1').feature('arwl2').set('descr', 'Port mode wave vector');
model.result('pg1').feature('arwl2').set('color', 'blue');
model.result('pg1').feature('arwl2').set('descractive', true);
model.result('pg1').feature('arwl2').set('descr', 'Reflected wave (blue)');
model.result('pg1').run;
model.result('pg1').create('arwl3', 'ArrowLine');
model.result('pg1').feature('arwl3').set('expr', {'ewfd.kModex_2' 'ewfd.kModey_2'});
model.result('pg1').feature('arwl3').set('descr', 'Port mode wave vector');
model.result('pg1').feature('arwl3').set('color', 'blue');
model.result('pg1').feature('arwl3').set('descractive', true);
model.result('pg1').feature('arwl3').set('descr', 'Transmitted wave (blue)');
model.result('pg1').run;
model.result('pg1').create('arwl4', 'ArrowLine');
model.result('pg1').feature('arwl4').set('expr', {'ewfd.kModex_3' 'ewfd.kModey_3'});
model.result('pg1').feature('arwl4').set('descr', 'Port mode wave vector');
model.result('pg1').feature('arwl4').set('color', 'cyan');
model.result('pg1').feature('arwl4').set('descractive', true);
model.result('pg1').feature('arwl4').set('descr', 'Reflected mode, m = -1 (cyan)');
model.result('pg1').feature.duplicate('arwl5', 'arwl4');
model.result('pg1').run;
model.result('pg1').feature('arwl5').set('expr', {'ewfd.kModex_4' 'ewfd.kModey_4'});
model.result('pg1').feature('arwl5').set('color', 'green');
model.result('pg1').feature('arwl5').set('descr', 'Reflected mode, m = 1 (green)');
model.result('pg1').run;
model.result('pg1').feature.duplicate('arwl6', 'arwl4');
model.result('pg1').run;
model.result('pg1').feature('arwl6').setIndex('expr', 'ewfd.kModex_5', 0);
model.result('pg1').feature('arwl6').setIndex('expr', 'ewfd.kModey_5', 1);
model.result('pg1').feature('arwl6').set('descr', 'Transmitted mode, m = -1 (cyan)');
model.result('pg1').run;
model.result('pg1').feature.duplicate('arwl7', 'arwl5');
model.result('pg1').run;
model.result('pg1').feature('arwl7').setIndex('expr', 'ewfd.kModex_6', 0);
model.result('pg1').feature('arwl7').setIndex('expr', 'ewfd.kModey_6', 1);
model.result('pg1').feature('arwl7').set('descr', 'Transmitted mode, m = 1 (green)');
model.result('pg1').run;
model.result('pg1').label('TE Electric Field');
model.result('pg1').setIndex('looplevel', 9, 0);
model.result('pg1').set('titletype', 'custom');
model.result('pg1').set('typeintitle', false);
model.result('pg1').run;
model.result('pg2').run;
model.result('pg2').label('TE Reflectance, Transmittance, and Absorptance');
model.result('pg2').set('titletype', 'manual');
model.result('pg2').set('title', 'Reflectance and Transmittance of TE Wave');
model.result('pg2').run;
model.result('pg2').feature('glob1').set('linemarker', 'cycle');
model.result('pg2').feature('glob1').set('markerpos', 'interp');
model.result('pg2').feature('glob1').set('legendmethod', 'manual');
model.result('pg2').feature('glob1').setIndex('legends', 'R<sub>0</sub>', 0);
model.result('pg2').feature('glob1').setIndex('legends', 'R<sub>-1</sub>', 1);
model.result('pg2').feature('glob1').setIndex('legends', 'R<sub>1</sub>', 2);
model.result('pg2').feature('glob1').setIndex('legends', 'R<sub>tot</sub>', 3);
model.result('pg2').feature('glob1').setIndex('legends', 'T<sub>0</sub>', 4);
model.result('pg2').feature('glob1').setIndex('legends', 'T<sub>-1</sub>', 5);
model.result('pg2').feature('glob1').setIndex('legends', 'T<sub>1</sub>', 6);
model.result('pg2').feature('glob1').setIndex('legends', 'T<sub>tot</sub>', 7);
model.result('pg2').feature('glob1').setIndex('legends', 'R<sub>tot</sub>+T<sub>tot</sub>', 8);
model.result('pg2').feature('glob1').setIndex('legends', 'A', 9);
model.result('pg2').run;

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

model.result.create('pg3', 'PlotGroup2D');
model.result('pg3').label('Electric Field (ewfd)');
model.result('pg3').set('data', 'dset2');
model.result('pg3').setIndex('looplevel', 20, 0);
model.result('pg3').setIndex('looplevel', 1, 1);
model.result('pg3').set('frametype', 'spatial');
model.result('pg3').set('data', 'dset2');
model.result('pg3').setIndex('looplevel', 20, 0);
model.result('pg3').setIndex('looplevel', 1, 1);
model.result('pg3').set('defaultPlotID', 'ElectromagneticWavesFrequencyDomain/phys1/pdef1/pcond2/pg1');
model.result('pg3').feature.create('surf1', 'Surface');
model.result('pg3').feature('surf1').set('smooth', 'internal');
model.result('pg3').feature('surf1').set('data', 'parent');
model.result.create('pg4', 'PlotGroup1D');
model.result('pg4').set('data', 'dset2');
model.result('pg4').create('glob1', 'Global');
model.result('pg4').feature('glob1').set('unit', {'' '' '' '' '' '' '' '' '' ''});
model.result('pg4').feature('glob1').set('expr', {'ewfd.Rorder_0' 'ewfd.Rorder_n1_ip' 'ewfd.Rorder_p1_ip' 'ewfd.Rtotal' 'ewfd.Torder_0' 'ewfd.Torder_n1_ip' 'ewfd.Torder_p1_ip' 'ewfd.Ttotal' 'ewfd.RTtotal' 'ewfd.Atotal'});
model.result('pg4').feature('glob1').set('descr', {'Reflectance, order 0' 'Reflectance, order -1, in-plane' 'Reflectance, order 1, in-plane' 'Total reflectance' 'Transmittance, order 0' 'Transmittance, order -1, in-plane' 'Transmittance, order 1, in-plane' 'Total transmittance' 'Total reflectance and transmittance' 'Absorptance'});
model.result('pg4').label('Reflectance, Transmittance, and Absorptance (ewfd)');
model.result('pg4').feature('glob1').set('titletype', 'none');
model.result('pg4').feature('glob1').set('xdata', 'expr');
model.result('pg4').set('ylabelactive', true);
model.result('pg4').set('ylabel', 'Reflectance, transmittance, and absorptance (1)');
model.result('pg4').feature('glob1').set('xdataexpr', 'alpha');
model.result('pg4').feature('glob1').set('xdataunit', 'deg');
model.result('pg4').feature('glob1').set('markerpos', 'datapoints');
model.result('pg4').feature('glob1').set('xdatasolnumtype', 'all');
model.result('pg3').run;
model.result('pg3').create('arwl1', 'ArrowLine');
model.result('pg3').feature('arwl1').set('expr', {'ewfd.kIncx_1' 'ewfd.kIncy_1'});
model.result('pg3').feature('arwl1').set('descr', 'Incident wave vector');
model.result('pg3').feature('arwl1').set('color', 'magenta');
model.result('pg3').feature('arwl1').set('descractive', true);
model.result('pg3').feature('arwl1').set('descr', 'Incident wave (magenta)');
model.result('pg3').run;
model.result('pg3').create('arwl2', 'ArrowLine');
model.result('pg3').feature('arwl2').set('expr', {'ewfd.kModex_1' 'ewfd.kModey_1'});
model.result('pg3').feature('arwl2').set('descr', 'Port mode wave vector');
model.result('pg3').feature('arwl2').set('color', 'blue');
model.result('pg3').feature('arwl2').set('descractive', true);
model.result('pg3').feature('arwl2').set('descr', 'Reflected wave (blue)');
model.result('pg3').run;
model.result('pg3').create('arwl3', 'ArrowLine');
model.result('pg3').feature('arwl3').set('expr', {'ewfd.kModex_2' 'ewfd.kModey_2'});
model.result('pg3').feature('arwl3').set('descr', 'Port mode wave vector');
model.result('pg3').feature('arwl3').set('color', 'blue');
model.result('pg3').feature('arwl3').set('descractive', true);
model.result('pg3').feature('arwl3').set('descr', 'Transmitted wave (blue)');
model.result('pg3').run;
model.result('pg3').create('arwl4', 'ArrowLine');
model.result('pg3').feature('arwl4').set('expr', {'ewfd.kModex_3' 'ewfd.kModey_3'});
model.result('pg3').feature('arwl4').set('descr', 'Port mode wave vector');
model.result('pg3').feature('arwl4').set('color', 'cyan');
model.result('pg3').feature('arwl4').set('descractive', true);
model.result('pg3').feature('arwl4').set('descr', 'Reflected mode, m = -1 (cyan)');
model.result('pg3').feature.duplicate('arwl5', 'arwl4');
model.result('pg3').run;
model.result('pg3').feature('arwl5').set('expr', {'ewfd.kModex_4' 'ewfd.kModey_4'});
model.result('pg3').feature('arwl5').set('color', 'green');
model.result('pg3').feature('arwl5').set('descr', 'Reflected mode, m = 1 (green)');
model.result('pg3').run;
model.result('pg3').feature.duplicate('arwl6', 'arwl4');
model.result('pg3').run;
model.result('pg3').feature('arwl6').setIndex('expr', 'ewfd.kModex_5', 0);
model.result('pg3').feature('arwl6').setIndex('expr', 'ewfd.kModey_5', 1);
model.result('pg3').feature('arwl6').set('descr', 'Transmitted mode, m = -1 (cyan)');
model.result('pg3').run;
model.result('pg3').feature.duplicate('arwl7', 'arwl5');
model.result('pg3').run;
model.result('pg3').feature('arwl7').setIndex('expr', 'ewfd.kModex_6', 0);
model.result('pg3').feature('arwl7').setIndex('expr', 'ewfd.kModey_6', 1);
model.result('pg3').feature('arwl7').set('descr', 'Transmitted mode, m = 1 (green)');
model.result('pg3').run;
model.result('pg3').label('TM Electric Field');
model.result('pg3').setIndex('looplevel', 9, 0);
model.result('pg3').set('titletype', 'custom');
model.result('pg3').set('typeintitle', false);
model.result('pg3').run;
model.result('pg4').run;
model.result('pg4').label('TM Reflectance, Transmittance, and Absorptance');
model.result('pg4').set('titletype', 'manual');
model.result('pg4').set('title', 'Reflectance and Transmittance of TM Wave');
model.result('pg4').run;
model.result('pg4').feature('glob1').set('linemarker', 'cycle');
model.result('pg4').feature('glob1').set('markerpos', 'interp');
model.result('pg4').feature('glob1').set('legendmethod', 'manual');
model.result('pg4').feature('glob1').setIndex('legends', 'R<sub>0</sub>', 0);
model.result('pg4').feature('glob1').setIndex('legends', 'R<sub>-1</sub>', 1);
model.result('pg4').feature('glob1').setIndex('legends', 'R<sub>1</sub>', 2);
model.result('pg4').feature('glob1').setIndex('legends', 'R<sub>tot</sub>', 3);
model.result('pg4').feature('glob1').setIndex('legends', 'T<sub>0</sub>', 4);
model.result('pg4').feature('glob1').setIndex('legends', 'T<sub>-1</sub>', 5);
model.result('pg4').feature('glob1').setIndex('legends', 'T<sub>1</sub>', 6);
model.result('pg4').feature('glob1').setIndex('legends', 'T<sub>tot</sub>', 7);
model.result('pg4').feature('glob1').setIndex('legends', 'R<sub>tot</sub>+T<sub>tot</sub>', 8);
model.result('pg4').feature('glob1').setIndex('legends', 'A', 9);
model.result('pg4').run;

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

## Example 7: impeller

**Module:** Structural_Mechanics_Module_Dynamics_and_Vibration_impeller  
**Category:** Unknown_Category  

### Model Description

**Model Overview**:
The model simulates the vibrations of an impeller, focusing on the dynamic behavior and eigenfrequencies of the structure. It employs dynamic cyclic symmetry to analyze a single sector of the impeller and then extends the results to the full geometry, which consists of eight identical blades. The model compares the eigenfrequencies computed for the full impeller with those obtained using cyclic symmetry conditions on a single sector.

**Geometry**:
The geometry of the impeller is not explicitly described in terms of dimensions in the provided script, but it is imported from a file named 'impeller.mphbin'. The impeller is divided into eight sectors of symmetry, and the analysis focuses on one of these sectors.

**Materials**:
The material used in the model is Aluminum, with the following key properties:
- Young's modulus (E): 70 GPa
- Poisson's ratio (ν): 0.33
- Density (ρ): 2700 kg/m³
- Murnaghan constants (l, m, n): -250 GPa, -330 GPa, -350 GPa

**Physics**:
The model uses the Solid Mechanics interface to simulate the structural dynamics of the impeller. The physics interfaces involved are:
- 'solid': Solid Mechanics for the full impeller geometry
- 'solid2': Solid Mechanics for a single sector with cyclic symmetry

**Boundary Conditions**:
Boundary conditions include:
- Fixed constraints applied to specific boundaries of the impeller to represent fixed supports.
- Periodic conditions applied to the sector boundaries to simulate cyclic symmetry in 'solid2'.

**Mesh**:
The geometry is discretized using a mesh with a specified 'autoMeshSize' of 4. The mesh is refined to a 'finer' setting for more accurate results. Identical mesh is ensured across the sector boundaries to maintain compatibility with the cyclic symmetry conditions.

**Study**:
The analysis includes:
- Eigenfrequency study to compute the natural frequencies and mode shapes of the impeller.
- Frequency-response analysis to study the dynamic behavior at a specific frequency (200 Hz).

**Key Parameters**:
- Number of sectors (N): 8
- Unit sector angle (theta): 2π/N
- Azimuthal mode number (mn): 3
- Load magnitude (p0): 10^4 Pa

**Expected Results**:
The model predicts the eigenfrequencies, mode shapes, and dynamic displacement field of the impeller. It also evaluates participation factors and effective modal masses for the vibration modes.

**Engineering Application**:
This model is applicable to the design and analysis of rotating machinery, such as turbines and compressors, where understanding the vibration characteristics of impellers is crucial for avoiding resonance, ensuring structural integrity, and optimizing performance. The use of cyclic symmetry reduces computational cost while accurately capturing the dynamic behavior of the full impeller geometry.

### COMSOL MATLAB Code

```matlab
function out = model
%
% impeller.m
%
% Model exported on May 26 2025, 21:33 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/Structural_Mechanics_Module/Dynamics_and_Vibration');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 3);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.physics.create('solid', 'SolidMechanics', 'geom1');
model.physics('solid').model('comp1');

model.study.create('std1');
model.study('std1').create('eig', 'Eigenfrequency');
model.study('std1').feature('eig').set('chkeigregion', true);
model.study('std1').feature('eig').set('conrad', '1');
model.study('std1').feature('eig').set('conradynhm', '1');
model.study('std1').feature('eig').set('storefact', false);
model.study('std1').feature('eig').set('solnum', 'auto');
model.study('std1').feature('eig').set('notsolnum', 'auto');
model.study('std1').feature('eig').set('outputmap', {});
model.study('std1').feature('eig').set('ngenAUX', '1');
model.study('std1').feature('eig').set('goalngenAUX', '1');
model.study('std1').feature('eig').set('ngenAUX', '1');
model.study('std1').feature('eig').set('goalngenAUX', '1');
model.study('std1').feature('eig').setSolveFor('/physics/solid', true);

model.common.create('mpf1', 'ParticipationFactors', 'comp1');

model.view('view1').set('showgrid', false);

model.geom('geom1').create('imp1', 'Import');
model.geom('geom1').feature('imp1').set('filename', 'impeller.mphbin');
model.geom('geom1').feature('imp1').importData;
model.geom('geom1').run('fin');

model.param.set('N', '8');
model.param.descr('N', 'Number of sectors');
model.param.set('theta', '2*pi/N');
model.param.descr('theta', 'Unit sector angle');
model.param.set('mn', '3');
model.param.descr('mn', 'Azimuthal mode number');
model.param.set('p0', '1e4[Pa]');
model.param.descr('p0', 'Load magnitude');

model.physics.create('solid2', 'SolidMechanics', 'geom1');
model.physics('solid2').model('comp1');

model.study('std1').feature('eig').setSolveFor('/physics/solid2', true);

model.physics('solid2').selection.set([8]);

model.material.create('mat1', 'Common', 'comp1');
model.material('mat1').propertyGroup.create('Enu', 'Young''s modulus and Poisson''s ratio');
model.material('mat1').propertyGroup.create('Murnaghan', 'Murnaghan');
model.material('mat1').label('Aluminum');
model.material('mat1').set('family', 'aluminum');
model.material('mat1').propertyGroup('def').set('relpermeability', {'1' '0' '0' '0' '1' '0' '0' '0' '1'});
model.material('mat1').propertyGroup('def').set('heatcapacity', '900[J/(kg*K)]');
model.material('mat1').propertyGroup('def').set('thermalconductivity', {'238[W/(m*K)]' '0' '0' '0' '238[W/(m*K)]' '0' '0' '0' '238[W/(m*K)]'});
model.material('mat1').propertyGroup('def').set('electricconductivity', {'3.774e7[S/m]' '0' '0' '0' '3.774e7[S/m]' '0' '0' '0' '3.774e7[S/m]'});
model.material('mat1').propertyGroup('def').set('relpermittivity', {'1' '0' '0' '0' '1' '0' '0' '0' '1'});
model.material('mat1').propertyGroup('def').set('thermalexpansioncoefficient', {'23e-6[1/K]' '0' '0' '0' '23e-6[1/K]' '0' '0' '0' '23e-6[1/K]'});
model.material('mat1').propertyGroup('def').set('density', '2700[kg/m^3]');
model.material('mat1').propertyGroup('Enu').set('E', '70[GPa]');
model.material('mat1').propertyGroup('Enu').set('nu', '0.33');
model.material('mat1').propertyGroup('Murnaghan').set('l', '-250[GPa]');
model.material('mat1').propertyGroup('Murnaghan').set('m', '-330[GPa]');
model.material('mat1').propertyGroup('Murnaghan').set('n', '-350[GPa]');

model.physics('solid').create('fix1', 'Fixed', 2);
model.physics('solid').feature('fix1').selection.set([54 55 67 68 85 87 109 113]);
model.physics('solid2').create('fix1', 'Fixed', 2);
model.physics('solid2').feature('fix1').selection.set([113]);
model.physics('solid2').create('pc1', 'PeriodicCondition', 2);
model.physics('solid2').feature('pc1').selection.set([112 134]);
model.physics('solid2').feature('pc1').set('PeriodicType', 'CyclicSymmetry');
model.physics('solid2').feature('pc1').set('mFloquet', 'mn');
model.physics('solid2').feature('pc1').set('manualDestinationSelection', true);
model.physics('solid2').feature('pc1').selection('destinationDomains').set([112]);

model.mesh('mesh1').autoMeshSize(4);
model.mesh('mesh1').create('id1', 'IdenticalMesh');
model.mesh('mesh1').feature('id1').selection('group1').set([134]);
model.mesh('mesh1').feature('id1').selection('group2').set([112]);
model.mesh('mesh1').create('ftet1', 'FreeTet');
model.mesh('mesh1').feature('ftet1').selection.geom('geom1', 3);
model.mesh('mesh1').feature('ftet1').selection.set([8]);
model.mesh('mesh1').create('cpd1', 'CopyDomain');
model.mesh('mesh1').feature('cpd1').selection('source').geom(3);
model.mesh('mesh1').feature('cpd1').selection('destination').geom(3);
model.mesh('mesh1').feature('cpd1').selection('source').set([8]);
model.mesh('mesh1').feature('cpd1').selection('destination').set([1 2 3 4 5 6 7]);
model.mesh('mesh1').run;

model.study('std1').feature('eig').set('neigsactive', true);
model.study('std1').feature('eig').set('neigs', 32);
model.study('std1').feature('eig').set('useadvanceddisable', true);
model.study('std1').feature('eig').setSolveFor('/physics/solid2', false);
model.study('std1').feature('eig').set('disabledphysics', {'solid2'});

model.sol.create('sol1');
model.sol('sol1').study('std1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'eig');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').set('control', 'eig');
model.sol('sol1').create('e1', 'Eigenvalue');
model.sol('sol1').feature('e1').set('eigvfunscale', 'maximum');
model.sol('sol1').feature('e1').set('eigvfunscaleparam', '2.9599999999999995E-7');
model.sol('sol1').feature('e1').set('control', 'eig');
model.sol('sol1').feature('e1').feature('aDef').set('cachepattern', true);
model.sol('sol1').attach('std1');
model.sol('sol1').runAll;

model.result.create('pg1', 'PlotGroup3D');
model.result('pg1').set('data', 'dset1');
model.result('pg1').setIndex('looplevel', 1, 0);
model.result('pg1').set('defaultPlotID', 'modeShape');
model.result('pg1').label('Mode Shape (solid)');
model.result('pg1').set('showlegends', false);
model.result('pg1').create('surf1', 'Surface');
model.result('pg1').feature('surf1').set('expr', {'solid.disp'});
model.result('pg1').feature('surf1').set('threshold', 'manual');
model.result('pg1').feature('surf1').set('thresholdvalue', 0.2);
model.result('pg1').feature('surf1').set('colortable', 'Rainbow');
model.result('pg1').feature('surf1').set('colortabletrans', 'none');
model.result('pg1').feature('surf1').set('colorscalemode', 'linear');
model.result('pg1').feature('surf1').set('colortable', 'AuroraBorealis');
model.result('pg1').feature('surf1').create('def', 'Deform');
model.result('pg1').feature('surf1').feature('def').set('expr', {'u' 'v' 'w'});
model.result('pg1').feature('surf1').feature('def').set('descr', 'Displacement field');
model.result.evaluationGroup.create('std1EvgFrq', 'EvaluationGroup');
model.result.evaluationGroup('std1EvgFrq').set('defaultPlotID', 'eigenfrequenciesTable_solid');
model.result.evaluationGroup('std1EvgFrq').set('data', 'dset1');
model.result.evaluationGroup('std1EvgFrq').label('Eigenfrequencies (Study 1)');
model.result.evaluationGroup('std1EvgFrq').create('gev1', 'EvalGlobal');
model.result.evaluationGroup('std1EvgFrq').feature('gev1').setIndex('expr', '2*pi*freq', 0);
model.result.evaluationGroup('std1EvgFrq').feature('gev1').setIndex('unit', 'rad/s', 0);
model.result.evaluationGroup('std1EvgFrq').feature('gev1').setIndex('descr', 'Angular frequency', 0);
model.result.evaluationGroup('std1EvgFrq').feature('gev1').setIndex('expr', 'imag(freq)/abs(freq)', 1);
model.result.evaluationGroup('std1EvgFrq').feature('gev1').setIndex('unit', '1', 1);
model.result.evaluationGroup('std1EvgFrq').feature('gev1').setIndex('descr', 'Damping ratio', 1);
model.result.evaluationGroup('std1EvgFrq').feature('gev1').setIndex('expr', 'abs(freq)/imag(freq)/2', 2);
model.result.evaluationGroup('std1EvgFrq').feature('gev1').setIndex('unit', '1', 2);
model.result.evaluationGroup('std1EvgFrq').feature('gev1').setIndex('descr', 'Quality factor', 2);
model.result.evaluationGroup('std1EvgFrq').run;
model.result.evaluationGroup.create('std1mpf1', 'EvaluationGroup');
model.result.evaluationGroup('std1mpf1').set('data', 'dset1');
model.result.evaluationGroup('std1mpf1').label('Participation Factors (Study 1)');
model.result.evaluationGroup('std1mpf1').create('gev1', 'EvalGlobal');
model.result.evaluationGroup('std1mpf1').feature('gev1').setIndex('expr', 'mpf1.pfLnormX', 0);
model.result.evaluationGroup('std1mpf1').feature('gev1').setIndex('unit', '1', 0);
model.result.evaluationGroup('std1mpf1').feature('gev1').setIndex('descr', 'Participation factor, normalized, X-translation', 0);
model.result.evaluationGroup('std1mpf1').feature('gev1').setIndex('expr', 'mpf1.pfLnormY', 1);
model.result.evaluationGroup('std1mpf1').feature('gev1').setIndex('unit', '1', 1);
model.result.evaluationGroup('std1mpf1').feature('gev1').setIndex('descr', 'Participation factor, normalized, Y-translation', 1);
model.result.evaluationGroup('std1mpf1').feature('gev1').setIndex('expr', 'mpf1.pfLnormZ', 2);
model.result.evaluationGroup('std1mpf1').feature('gev1').setIndex('unit', '1', 2);
model.result.evaluationGroup('std1mpf1').feature('gev1').setIndex('descr', 'Participation factor, normalized, Z-translation', 2);
model.result.evaluationGroup('std1mpf1').feature('gev1').setIndex('expr', 'mpf1.pfRnormX', 3);
model.result.evaluationGroup('std1mpf1').feature('gev1').setIndex('unit', '1', 3);
model.result.evaluationGroup('std1mpf1').feature('gev1').setIndex('descr', 'Participation factor, normalized, X-rotation', 3);
model.result.evaluationGroup('std1mpf1').feature('gev1').setIndex('expr', 'mpf1.pfRnormY', 4);
model.result.evaluationGroup('std1mpf1').feature('gev1').setIndex('unit', '1', 4);
model.result.evaluationGroup('std1mpf1').feature('gev1').setIndex('descr', 'Participation factor, normalized, Y-rotation', 4);
model.result.evaluationGroup('std1mpf1').feature('gev1').setIndex('expr', 'mpf1.pfRnormZ', 5);
model.result.evaluationGroup('std1mpf1').feature('gev1').setIndex('unit', '1', 5);
model.result.evaluationGroup('std1mpf1').feature('gev1').setIndex('descr', 'Participation factor, normalized, Z-rotation', 5);
model.result.evaluationGroup('std1mpf1').feature('gev1').setIndex('expr', 'mpf1.mEffLX', 6);
model.result.evaluationGroup('std1mpf1').feature('gev1').setIndex('unit', 'kg', 6);
model.result.evaluationGroup('std1mpf1').feature('gev1').setIndex('descr', 'Effective modal mass, X-translation', 6);
model.result.evaluationGroup('std1mpf1').feature('gev1').setIndex('expr', 'mpf1.mEffLY', 7);
model.result.evaluationGroup('std1mpf1').feature('gev1').setIndex('unit', 'kg', 7);
model.result.evaluationGroup('std1mpf1').feature('gev1').setIndex('descr', 'Effective modal mass, Y-translation', 7);
model.result.evaluationGroup('std1mpf1').feature('gev1').setIndex('expr', 'mpf1.mEffLZ', 8);
model.result.evaluationGroup('std1mpf1').feature('gev1').setIndex('unit', 'kg', 8);
model.result.evaluationGroup('std1mpf1').feature('gev1').setIndex('descr', 'Effective modal mass, Z-translation', 8);
model.result.evaluationGroup('std1mpf1').feature('gev1').setIndex('expr', 'mpf1.mEffRX', 9);
model.result.evaluationGroup('std1mpf1').feature('gev1').setIndex('unit', 'kg*m^2', 9);
model.result.evaluationGroup('std1mpf1').feature('gev1').setIndex('descr', 'Effective modal mass, X-rotation', 9);
model.result.evaluationGroup('std1mpf1').feature('gev1').setIndex('expr', 'mpf1.mEffRY', 10);
model.result.evaluationGroup('std1mpf1').feature('gev1').setIndex('unit', 'kg*m^2', 10);
model.result.evaluationGroup('std1mpf1').feature('gev1').setIndex('descr', 'Effective modal mass, Y-rotation', 10);
model.result.evaluationGroup('std1mpf1').feature('gev1').setIndex('expr', 'mpf1.mEffRZ', 11);
model.result.evaluationGroup('std1mpf1').feature('gev1').setIndex('unit', 'kg*m^2', 11);
model.result.evaluationGroup('std1mpf1').feature('gev1').setIndex('descr', 'Effective modal mass, Z-rotation', 11);
model.result.evaluationGroup('std1mpf1').run;
model.result('pg1').run;

model.study.create('std2');
model.study('std2').create('eig', 'Eigenfrequency');
model.study('std2').feature('eig').set('plotgroup', 'Default');
model.study('std2').feature('eig').set('chkeigregion', true);
model.study('std2').feature('eig').set('conrad', '1');
model.study('std2').feature('eig').set('conradynhm', '1');
model.study('std2').feature('eig').set('storefact', false);
model.study('std2').feature('eig').set('solnum', 'auto');
model.study('std2').feature('eig').set('notsolnum', 'auto');
model.study('std2').feature('eig').set('outputmap', {});
model.study('std2').feature('eig').set('ngenAUX', '1');
model.study('std2').feature('eig').set('goalngenAUX', '1');
model.study('std2').feature('eig').set('ngenAUX', '1');
model.study('std2').feature('eig').set('goalngenAUX', '1');
model.study('std2').feature('eig').setSolveFor('/physics/solid', true);
model.study('std2').feature('eig').setSolveFor('/physics/solid2', true);
model.study('std2').feature('eig').set('neigsactive', true);
model.study('std2').feature('eig').set('neigs', 4);
model.study('std2').feature('eig').set('useadvanceddisable', true);
model.study('std2').feature('eig').setSolveFor('/physics/solid', false);
model.study('std2').feature('eig').set('disabledphysics', {'solid'});
model.study('std2').feature('eig').set('useparam', true);
model.study('std2').feature('eig').setIndex('pname', 'N', 0);
model.study('std2').feature('eig').setIndex('plistarr', '', 0);
model.study('std2').feature('eig').setIndex('punit', '', 0);
model.study('std2').feature('eig').setIndex('pname', 'N', 0);
model.study('std2').feature('eig').setIndex('plistarr', '', 0);
model.study('std2').feature('eig').setIndex('punit', '', 0);
model.study('std2').feature('eig').setIndex('pname', 'mn', 0);
model.study('std2').feature('eig').setIndex('plistarr', 'range(0,1,N/2)', 0);

model.sol.create('sol2');
model.sol('sol2').study('std2');
model.sol('sol2').create('st1', 'StudyStep');
model.sol('sol2').feature('st1').set('study', 'std2');
model.sol('sol2').feature('st1').set('studystep', 'eig');
model.sol('sol2').create('v1', 'Variables');
model.sol('sol2').feature('v1').set('control', 'eig');
model.sol('sol2').create('e1', 'Eigenvalue');
model.sol('sol2').feature('e1').create('ep1', 'EigenvalueParam');
model.sol('sol2').feature('e1').feature('ep1').set('control', 'eig');
model.sol('sol2').feature('e1').set('eigvfunscale', 'maximum');
model.sol('sol2').feature('e1').set('eigvfunscaleparam', '2.9599999999999995E-7');
model.sol('sol2').feature('e1').set('control', 'eig');
model.sol('sol2').feature('e1').feature('aDef').set('cachepattern', true);
model.sol('sol2').attach('std2');
model.sol('sol2').runAll;

model.result.create('pg2', 'PlotGroup3D');
model.result('pg2').set('data', 'dset2');
model.result('pg2').setIndex('looplevel', 4, 0);
model.result('pg2').setIndex('looplevel', 5, 1);
model.result('pg2').set('defaultPlotID', 'modeShape');
model.result('pg2').label('Mode Shape (solid2)');
model.result('pg2').set('showlegends', false);
model.result('pg2').create('surf1', 'Surface');
model.result('pg2').feature('surf1').set('expr', {'solid2.disp'});
model.result('pg2').feature('surf1').set('threshold', 'manual');
model.result('pg2').feature('surf1').set('thresholdvalue', 0.2);
model.result('pg2').feature('surf1').set('colortable', 'Rainbow');
model.result('pg2').feature('surf1').set('colortabletrans', 'none');
model.result('pg2').feature('surf1').set('colorscalemode', 'linear');
model.result('pg2').feature('surf1').set('colortable', 'AuroraBorealis');
model.result('pg2').feature('surf1').create('def', 'Deform');
model.result('pg2').feature('surf1').feature('def').set('expr', {'u2' 'v2' 'w2'});
model.result('pg2').feature('surf1').feature('def').set('descr', 'Displacement field');
model.result.evaluationGroup.create('std2EvgFrq', 'EvaluationGroup');
model.result.evaluationGroup('std2EvgFrq').set('defaultPlotID', 'eigenfrequenciesTable_solid2');
model.result.evaluationGroup('std2EvgFrq').set('data', 'dset2');
model.result.evaluationGroup('std2EvgFrq').label('Eigenfrequencies (Study 2)');
model.result.evaluationGroup('std2EvgFrq').create('gev1', 'EvalGlobal');
model.result.evaluationGroup('std2EvgFrq').feature('gev1').setIndex('expr', '2*pi*freq', 0);
model.result.evaluationGroup('std2EvgFrq').feature('gev1').setIndex('unit', 'rad/s', 0);
model.result.evaluationGroup('std2EvgFrq').feature('gev1').setIndex('descr', 'Angular frequency', 0);
model.result.evaluationGroup('std2EvgFrq').feature('gev1').setIndex('expr', 'imag(freq)/abs(freq)', 1);
model.result.evaluationGroup('std2EvgFrq').feature('gev1').setIndex('unit', '1', 1);
model.result.evaluationGroup('std2EvgFrq').feature('gev1').setIndex('descr', 'Damping ratio', 1);
model.result.evaluationGroup('std2EvgFrq').feature('gev1').setIndex('expr', 'abs(freq)/imag(freq)/2', 2);
model.result.evaluationGroup('std2EvgFrq').feature('gev1').setIndex('unit', '1', 2);
model.result.evaluationGroup('std2EvgFrq').feature('gev1').setIndex('descr', 'Quality factor', 2);
model.result.evaluationGroup('std2EvgFrq').run;
model.result.evaluationGroup.create('std2mpf1', 'EvaluationGroup');
model.result.evaluationGroup('std2mpf1').set('data', 'dset2');
model.result.evaluationGroup('std2mpf1').label('Participation Factors (Study 2)');
model.result.evaluationGroup('std2mpf1').create('gev1', 'EvalGlobal');
model.result.evaluationGroup('std2mpf1').feature('gev1').setIndex('expr', 'mpf1.pfLnormX', 0);
model.result.evaluationGroup('std2mpf1').feature('gev1').setIndex('unit', '1', 0);
model.result.evaluationGroup('std2mpf1').feature('gev1').setIndex('descr', 'Participation factor, normalized, X-translation', 0);
model.result.evaluationGroup('std2mpf1').feature('gev1').setIndex('expr', 'mpf1.pfLnormY', 1);
model.result.evaluationGroup('std2mpf1').feature('gev1').setIndex('unit', '1', 1);
model.result.evaluationGroup('std2mpf1').feature('gev1').setIndex('descr', 'Participation factor, normalized, Y-translation', 1);
model.result.evaluationGroup('std2mpf1').feature('gev1').setIndex('expr', 'mpf1.pfLnormZ', 2);
model.result.evaluationGroup('std2mpf1').feature('gev1').setIndex('unit', '1', 2);
model.result.evaluationGroup('std2mpf1').feature('gev1').setIndex('descr', 'Participation factor, normalized, Z-translation', 2);
model.result.evaluationGroup('std2mpf1').feature('gev1').setIndex('expr', 'mpf1.pfRnormX', 3);
model.result.evaluationGroup('std2mpf1').feature('gev1').setIndex('unit', '1', 3);
model.result.evaluationGroup('std2mpf1').feature('gev1').setIndex('descr', 'Participation factor, normalized, X-rotation', 3);
model.result.evaluationGroup('std2mpf1').feature('gev1').setIndex('expr', 'mpf1.pfRnormY', 4);
model.result.evaluationGroup('std2mpf1').feature('gev1').setIndex('unit', '1', 4);
model.result.evaluationGroup('std2mpf1').feature('gev1').setIndex('descr', 'Participation factor, normalized, Y-rotation', 4);
model.result.evaluationGroup('std2mpf1').feature('gev1').setIndex('expr', 'mpf1.pfRnormZ', 5);
model.result.evaluationGroup('std2mpf1').feature('gev1').setIndex('unit', '1', 5);
model.result.evaluationGroup('std2mpf1').feature('gev1').setIndex('descr', 'Participation factor, normalized, Z-rotation', 5);
model.result.evaluationGroup('std2mpf1').feature('gev1').setIndex('expr', 'mpf1.mEffLX', 6);
model.result.evaluationGroup('std2mpf1').feature('gev1').setIndex('unit', 'kg', 6);
model.result.evaluationGroup('std2mpf1').feature('gev1').setIndex('descr', 'Effective modal mass, X-translation', 6);
model.result.evaluationGroup('std2mpf1').feature('gev1').setIndex('expr', 'mpf1.mEffLY', 7);
model.result.evaluationGroup('std2mpf1').feature('gev1').setIndex('unit', 'kg', 7);
model.result.evaluationGroup('std2mpf1').feature('gev1').setIndex('descr', 'Effective modal mass, Y-translation', 7);
model.result.evaluationGroup('std2mpf1').feature('gev1').setIndex('expr', 'mpf1.mEffLZ', 8);
model.result.evaluationGroup('std2mpf1').feature('gev1').setIndex('unit', 'kg', 8);
model.result.evaluationGroup('std2mpf1').feature('gev1').setIndex('descr', 'Effective modal mass, Z-translation', 8);
model.result.evaluationGroup('std2mpf1').feature('gev1').setIndex('expr', 'mpf1.mEffRX', 9);
model.result.evaluationGroup('std2mpf1').feature('gev1').setIndex('unit', 'kg*m^2', 9);
model.result.evaluationGroup('std2mpf1').feature('gev1').setIndex('descr', 'Effective modal mass, X-rotation', 9);
model.result.evaluationGroup('std2mpf1').feature('gev1').setIndex('expr', 'mpf1.mEffRY', 10);
model.result.evaluationGroup('std2mpf1').feature('gev1').setIndex('unit', 'kg*m^2', 10);
model.result.evaluationGroup('std2mpf1').feature('gev1').setIndex('descr', 'Effective modal mass, Y-rotation', 10);
model.result.evaluationGroup('std2mpf1').feature('gev1').setIndex('expr', 'mpf1.mEffRZ', 11);
model.result.evaluationGroup('std2mpf1').feature('gev1').setIndex('unit', 'kg*m^2', 11);
model.result.evaluationGroup('std2mpf1').feature('gev1').setIndex('descr', 'Effective modal mass, Z-rotation', 11);
model.result.evaluationGroup('std2mpf1').run;
model.result('pg2').run;
model.result.dataset.create('sec1', 'Sector3D');
model.result.dataset('sec1').set('data', 'dset2');
model.result.dataset('sec1').set('sectors', 8);
model.result.dataset('sec1').set('modenumber', 'solid2.pc1.mFloquet');
model.result('pg2').run;
model.result('pg2').set('data', 'sec1');
model.result('pg2').run;
model.result.evaluationGroup('std1EvgFrq').run;
model.result.evaluationGroup('std2EvgFrq').run;

model.physics('solid').create('bndl1', 'BoundaryLoad', 2);
model.physics('solid').feature('bndl1').selection.all;
model.physics('solid').feature('bndl1').selection.set([1 2 3 5 6 7 8 9 10 11 12 13 14 15 16 17 18 20 21 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40 41 42 43 44 45 46 47 48 49 50 51 52 53 56 57 58 59 60 61 62 63 64 65 66 69 70 71 72 73 74 75 77 78 79 80 81 82 83 84 88 89 90 91 92 93 94 95 96 97 98 99 100 101 102 103 104 105 106 107 110 111 114 115 116 117 118 119 120 121 122 123 124 125 126 127 128 129 130 131 132 133 135 136 137 138 139 140 141 142 143 144 145 146 147 148 149 150 151 152]);
model.physics('solid').feature('bndl1').set('coordinateSystem', 'sys1');
model.physics('solid').feature('bndl1').set('FperArea', {'0' '0' '-p0*exp(-j*mn*atan2(Y,X))'});
model.physics('solid2').create('bndl1', 'BoundaryLoad', 2);
model.physics('solid2').feature('bndl1').selection.set([114 115 119 123 125 130 131 133 136 137 142 143 144 145 146 150 151]);
model.physics('solid2').feature('bndl1').set('coordinateSystem', 'sys1');
model.physics('solid2').feature('bndl1').set('FperArea', {'0' '0' '-p0*exp(-j*mn*atan2(Y,X))'});

model.study.create('std3');
model.study('std3').create('freq', 'Frequency');
model.study('std3').feature('freq').setSolveFor('/physics/solid', true);
model.study('std3').feature('freq').setSolveFor('/physics/solid2', false);
model.study('std3').feature('freq').set('plist', 200);
model.study('std3').feature('freq').setEntry('outputmap', 'solid', 'physics');
model.study('std3').feature('freq').setEntry('outputmap', 'solid2', 'none');
model.study('std3').setGenPlots(false);

model.sol.create('sol3');
model.sol('sol3').study('std3');
model.sol('sol3').create('st1', 'StudyStep');
model.sol('sol3').feature('st1').set('study', 'std3');
model.sol('sol3').feature('st1').set('studystep', 'freq');
model.sol('sol3').create('v1', 'Variables');
model.sol('sol3').feature('v1').set('control', 'freq');
model.sol('sol3').create('s1', 'Stationary');
model.sol('sol3').feature('s1').create('p1', 'Parametric');
model.sol('sol3').feature('s1').feature.remove('pDef');
model.sol('sol3').feature('s1').feature('p1').set('pname', {'freq'});
model.sol('sol3').feature('s1').feature('p1').set('plistarr', {'200'});
model.sol('sol3').feature('s1').feature('p1').set('punit', {'Hz'});
model.sol('sol3').feature('s1').feature('p1').set('pcontinuationmode', 'no');
model.sol('sol3').feature('s1').feature('p1').set('preusesol', 'no');
model.sol('sol3').feature('s1').feature('p1').set('pdistrib', 'off');
model.sol('sol3').feature('s1').feature('p1').set('plot', 'off');
model.sol('sol3').feature('s1').feature('p1').set('plotgroup', 'pg1');
model.sol('sol3').feature('s1').feature('p1').set('probesel', 'all');
model.sol('sol3').feature('s1').feature('p1').set('probes', {});
model.sol('sol3').feature('s1').feature('p1').set('control', 'freq');
model.sol('sol3').feature('s1').set('linpmethod', 'sol');
model.sol('sol3').feature('s1').set('linpsol', 'zero');
model.sol('sol3').feature('s1').set('control', 'freq');
model.sol('sol3').feature('s1').feature('aDef').set('cachepattern', true);
model.sol('sol3').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol3').feature('s1').create('d1', 'Direct');
model.sol('sol3').feature('s1').feature('d1').set('linsolver', 'pardiso');
model.sol('sol3').feature('s1').feature('d1').set('pivotperturb', 1.0E-9);
model.sol('sol3').feature('s1').feature('d1').label('Suggested Direct Solver (solid)');
model.sol('sol3').feature('s1').create('i1', 'Iterative');
model.sol('sol3').feature('s1').feature('i1').set('linsolver', 'gmres');
model.sol('sol3').feature('s1').feature('i1').set('rhob', 400);
model.sol('sol3').feature('s1').feature('i1').set('nlinnormuse', true);
model.sol('sol3').feature('s1').feature('i1').label('Suggested Iterative Solver (solid)');
model.sol('sol3').feature('s1').feature('i1').create('mg1', 'Multigrid');
model.sol('sol3').feature('s1').feature('i1').feature('mg1').set('prefun', 'gmg');
model.sol('sol3').feature('s1').feature('i1').feature('mg1').feature('pr').create('so1', 'SOR');
model.sol('sol3').feature('s1').feature('i1').feature('mg1').feature('pr').feature('so1').set('relax', 0.8);
model.sol('sol3').feature('s1').feature('i1').feature('mg1').feature('po').create('so1', 'SOR');
model.sol('sol3').feature('s1').feature('i1').feature('mg1').feature('po').feature('so1').set('relax', 0.8);
model.sol('sol3').feature('s1').feature('i1').feature('mg1').feature('cs').create('d1', 'Direct');
model.sol('sol3').feature('s1').feature('i1').feature('mg1').feature('cs').feature('d1').set('linsolver', 'pardiso');
model.sol('sol3').feature('s1').feature('i1').feature('mg1').feature('cs').feature('d1').set('pivotperturb', 1.0E-9);
model.sol('sol3').feature('s1').feature('fc1').set('linsolver', 'd1');
model.sol('sol3').feature('s1').feature.remove('fcDef');
model.sol('sol3').attach('std3');
model.sol('sol3').study('std3');
model.sol('sol3').feature.remove('s1');
model.sol('sol3').feature.remove('v1');
model.sol('sol3').feature.remove('st1');
model.sol('sol3').create('st1', 'StudyStep');
model.sol('sol3').feature('st1').set('study', 'std3');
model.sol('sol3').feature('st1').set('studystep', 'freq');
model.sol('sol3').create('v1', 'Variables');
model.sol('sol3').feature('v1').set('control', 'freq');
model.sol('sol3').create('s1', 'Stationary');
model.sol('sol3').feature('s1').create('p1', 'Parametric');
model.sol('sol3').feature('s1').feature.remove('pDef');
model.sol('sol3').feature('s1').feature('p1').set('pname', {'freq'});
model.sol('sol3').feature('s1').feature('p1').set('plistarr', {'200'});
model.sol('sol3').feature('s1').feature('p1').set('punit', {'Hz'});
model.sol('sol3').feature('s1').feature('p1').set('pcontinuationmode', 'no');
model.sol('sol3').feature('s1').feature('p1').set('preusesol', 'no');
model.sol('sol3').feature('s1').feature('p1').set('pdistrib', 'off');
model.sol('sol3').feature('s1').feature('p1').set('plot', 'off');
model.sol('sol3').feature('s1').feature('p1').set('plotgroup', 'pg1');
model.sol('sol3').feature('s1').feature('p1').set('probesel', 'all');
model.sol('sol3').feature('s1').feature('p1').set('probes', {});
model.sol('sol3').feature('s1').feature('p1').set('control', 'freq');
model.sol('sol3').feature('s1').set('linpmethod', 'sol');
model.sol('sol3').feature('s1').set('linpsol', 'zero');
model.sol('sol3').feature('s1').set('control', 'freq');
model.sol('sol3').feature('s1').feature('aDef').set('cachepattern', true);
model.sol('sol3').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol3').feature('s1').create('d1', 'Direct');
model.sol('sol3').feature('s1').feature('d1').set('linsolver', 'pardiso');
model.sol('sol3').feature('s1').feature('d1').set('pivotperturb', 1.0E-9);
model.sol('sol3').feature('s1').feature('d1').label('Suggested Direct Solver (solid)');
model.sol('sol3').feature('s1').create('i1', 'Iterative');
model.sol('sol3').feature('s1').feature('i1').set('linsolver', 'gmres');
model.sol('sol3').feature('s1').feature('i1').set('rhob', 400);
model.sol('sol3').feature('s1').feature('i1').set('nlinnormuse', true);
model.sol('sol3').feature('s1').feature('i1').label('Suggested Iterative Solver (solid)');
model.sol('sol3').feature('s1').feature('i1').create('mg1', 'Multigrid');
model.sol('sol3').feature('s1').feature('i1').feature('mg1').set('prefun', 'gmg');
model.sol('sol3').feature('s1').feature('i1').feature('mg1').feature('pr').create('so1', 'SOR');
model.sol('sol3').feature('s1').feature('i1').feature('mg1').feature('pr').feature('so1').set('relax', 0.8);
model.sol('sol3').feature('s1').feature('i1').feature('mg1').feature('po').create('so1', 'SOR');
model.sol('sol3').feature('s1').feature('i1').feature('mg1').feature('po').feature('so1').set('relax', 0.8);
model.sol('sol3').feature('s1').feature('i1').feature('mg1').feature('cs').create('d1', 'Direct');
model.sol('sol3').feature('s1').feature('i1').feature('mg1').feature('cs').feature('d1').set('linsolver', 'pardiso');
model.sol('sol3').feature('s1').feature('i1').feature('mg1').feature('cs').feature('d1').set('pivotperturb', 1.0E-9);
model.sol('sol3').feature('s1').feature('fc1').set('linsolver', 'd1');
model.sol('sol3').feature('s1').feature.remove('fcDef');
model.sol('sol3').attach('std3');
model.sol('sol3').runAll;

model.result.create('pg3', 'PlotGroup3D');
model.result('pg3').run;
model.result('pg3').label('Displacement (solid)');
model.result('pg3').set('data', 'dset3');
model.result('pg3').create('surf1', 'Surface');
model.result('pg3').feature('surf1').set('resolution', 'finer');
model.result('pg3').feature('surf1').set('colortable', 'SpectrumLight');
model.result('pg3').feature('surf1').create('def1', 'Deform');
model.result('pg3').run;
model.result('pg3').feature('surf1').feature('def1').set('scaleactive', true);
model.result('pg3').feature('surf1').feature('def1').set('scale', 25);
model.result('pg3').run;

model.study.create('std4');
model.study('std4').create('freq', 'Frequency');
model.study('std4').feature('freq').setSolveFor('/physics/solid', false);
model.study('std4').feature('freq').setSolveFor('/physics/solid2', true);
model.study('std4').feature('freq').set('plist', 200);
model.study('std4').feature('freq').setEntry('outputmap', 'solid', 'none');
model.study('std4').feature('freq').setEntry('outputmap', 'solid2', 'physics');
model.study('std4').setGenPlots(false);

model.sol.create('sol4');
model.sol('sol4').study('std4');
model.sol('sol4').create('st1', 'StudyStep');
model.sol('sol4').feature('st1').set('study', 'std4');
model.sol('sol4').feature('st1').set('studystep', 'freq');
model.sol('sol4').create('v1', 'Variables');
model.sol('sol4').feature('v1').set('control', 'freq');
model.sol('sol4').create('s1', 'Stationary');
model.sol('sol4').feature('s1').create('p1', 'Parametric');
model.sol('sol4').feature('s1').feature.remove('pDef');
model.sol('sol4').feature('s1').feature('p1').set('pname', {'freq'});
model.sol('sol4').feature('s1').feature('p1').set('plistarr', {'200'});
model.sol('sol4').feature('s1').feature('p1').set('punit', {'Hz'});
model.sol('sol4').feature('s1').feature('p1').set('pcontinuationmode', 'no');
model.sol('sol4').feature('s1').feature('p1').set('preusesol', 'no');
model.sol('sol4').feature('s1').feature('p1').set('pdistrib', 'off');
model.sol('sol4').feature('s1').feature('p1').set('plot', 'off');
model.sol('sol4').feature('s1').feature('p1').set('plotgroup', 'pg1');
model.sol('sol4').feature('s1').feature('p1').set('probesel', 'all');
model.sol('sol4').feature('s1').feature('p1').set('probes', {});
model.sol('sol4').feature('s1').feature('p1').set('control', 'freq');
model.sol('sol4').feature('s1').set('linpmethod', 'sol');
model.sol('sol4').feature('s1').set('linpsol', 'zero');
model.sol('sol4').feature('s1').set('control', 'freq');
model.sol('sol4').feature('s1').feature('aDef').set('cachepattern', true);
model.sol('sol4').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol4').feature('s1').create('d1', 'Direct');
model.sol('sol4').feature('s1').feature('d1').set('linsolver', 'pardiso');
model.sol('sol4').feature('s1').feature('d1').set('pivotperturb', 1.0E-9);
model.sol('sol4').feature('s1').feature('d1').label('Suggested Direct Solver (solid2)');
model.sol('sol4').feature('s1').create('i1', 'Iterative');
model.sol('sol4').feature('s1').feature('i1').set('linsolver', 'gmres');
model.sol('sol4').feature('s1').feature('i1').set('rhob', 400);
model.sol('sol4').feature('s1').feature('i1').set('nlinnormuse', true);
model.sol('sol4').feature('s1').feature('i1').label('Suggested Iterative Solver (solid2)');
model.sol('sol4').feature('s1').feature('i1').create('mg1', 'Multigrid');
model.sol('sol4').feature('s1').feature('i1').feature('mg1').set('prefun', 'gmg');
model.sol('sol4').feature('s1').feature('i1').feature('mg1').feature('pr').create('so1', 'SOR');
model.sol('sol4').feature('s1').feature('i1').feature('mg1').feature('pr').feature('so1').set('relax', 0.8);
model.sol('sol4').feature('s1').feature('i1').feature('mg1').feature('po').create('so1', 'SOR');
model.sol('sol4').feature('s1').feature('i1').feature('mg1').feature('po').feature('so1').set('relax', 0.8);
model.sol('sol4').feature('s1').feature('i1').feature('mg1').feature('cs').create('d1', 'Direct');
model.sol('sol4').feature('s1').feature('i1').feature('mg1').feature('cs').feature('d1').set('linsolver', 'pardiso');
model.sol('sol4').feature('s1').feature('i1').feature('mg1').feature('cs').feature('d1').set('pivotperturb', 1.0E-9);
model.sol('sol4').feature('s1').feature('fc1').set('linsolver', 'd1');
model.sol('sol4').feature('s1').feature.remove('fcDef');
model.sol('sol4').attach('std4');
model.sol('sol4').study('std4');
model.sol('sol4').feature.remove('s1');
model.sol('sol4').feature.remove('v1');
model.sol('sol4').feature.remove('st1');
model.sol('sol4').create('st1', 'StudyStep');
model.sol('sol4').feature('st1').set('study', 'std4');
model.sol('sol4').feature('st1').set('studystep', 'freq');
model.sol('sol4').create('v1', 'Variables');
model.sol('sol4').feature('v1').set('control', 'freq');
model.sol('sol4').create('s1', 'Stationary');
model.sol('sol4').feature('s1').create('p1', 'Parametric');
model.sol('sol4').feature('s1').feature.remove('pDef');
model.sol('sol4').feature('s1').feature('p1').set('pname', {'freq'});
model.sol('sol4').feature('s1').feature('p1').set('plistarr', {'200'});
model.sol('sol4').feature('s1').feature('p1').set('punit', {'Hz'});
model.sol('sol4').feature('s1').feature('p1').set('pcontinuationmode', 'no');
model.sol('sol4').feature('s1').feature('p1').set('preusesol', 'no');
model.sol('sol4').feature('s1').feature('p1').set('pdistrib', 'off');
model.sol('sol4').feature('s1').feature('p1').set('plot', 'off');
model.sol('sol4').feature('s1').feature('p1').set('plotgroup', 'pg1');
model.sol('sol4').feature('s1').feature('p1').set('probesel', 'all');
model.sol('sol4').feature('s1').feature('p1').set('probes', {});
model.sol('sol4').feature('s1').feature('p1').set('control', 'freq');
model.sol('sol4').feature('s1').set('linpmethod', 'sol');
model.sol('sol4').feature('s1').set('linpsol', 'zero');
model.sol('sol4').feature('s1').set('control', 'freq');
model.sol('sol4').feature('s1').feature('aDef').set('cachepattern', true);
model.sol('sol4').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol4').feature('s1').create('d1', 'Direct');
model.sol('sol4').feature('s1').feature('d1').set('linsolver', 'pardiso');
model.sol('sol4').feature('s1').feature('d1').set('pivotperturb', 1.0E-9);
model.sol('sol4').feature('s1').feature('d1').label('Suggested Direct Solver (solid2)');
model.sol('sol4').feature('s1').create('i1', 'Iterative');
model.sol('sol4').feature('s1').feature('i1').set('linsolver', 'gmres');
model.sol('sol4').feature('s1').feature('i1').set('rhob', 400);
model.sol('sol4').feature('s1').feature('i1').set('nlinnormuse', true);
model.sol('sol4').feature('s1').feature('i1').label('Suggested Iterative Solver (solid2)');
model.sol('sol4').feature('s1').feature('i1').create('mg1', 'Multigrid');
model.sol('sol4').feature('s1').feature('i1').feature('mg1').set('prefun', 'gmg');
model.sol('sol4').feature('s1').feature('i1').feature('mg1').feature('pr').create('so1', 'SOR');
model.sol('sol4').feature('s1').feature('i1').feature('mg1').feature('pr').feature('so1').set('relax', 0.8);
model.sol('sol4').feature('s1').feature('i1').feature('mg1').feature('po').create('so1', 'SOR');
model.sol('sol4').feature('s1').feature('i1').feature('mg1').feature('po').feature('so1').set('relax', 0.8);
model.sol('sol4').feature('s1').feature('i1').feature('mg1').feature('cs').create('d1', 'Direct');
model.sol('sol4').feature('s1').feature('i1').feature('mg1').feature('cs').feature('d1').set('linsolver', 'pardiso');
model.sol('sol4').feature('s1').feature('i1').feature('mg1').feature('cs').feature('d1').set('pivotperturb', 1.0E-9);
model.sol('sol4').feature('s1').feature('fc1').set('linsolver', 'd1');
model.sol('sol4').feature('s1').feature.remove('fcDef');
model.sol('sol4').attach('std4');
model.sol('sol4').runAll;

model.result.dataset.create('sec2', 'Sector3D');
model.result.dataset('sec2').set('data', 'dset4');
model.result.dataset('sec2').set('sectors', 8);
model.result.dataset('sec2').set('modenumber', 'solid2.pc1.mFloquet');
model.result.create('pg4', 'PlotGroup3D');
model.result('pg4').run;
model.result('pg4').label('Displacement (solid2)');
model.result('pg4').set('data', 'sec2');
model.result('pg4').create('surf1', 'Surface');
model.result('pg4').feature('surf1').set('expr', 'solid2.disp');
model.result('pg4').feature('surf1').set('resolution', 'finer');
model.result('pg4').feature('surf1').set('colortable', 'SpectrumLight');
model.result('pg4').feature('surf1').create('def1', 'Deform');
model.result('pg4').run;
model.result('pg4').feature('surf1').feature('def1').set('scaleactive', true);
model.result('pg4').feature('surf1').feature('def1').set('scale', 25);
model.result('pg4').feature('surf1').feature('def1').set('expr', {'u2' 'v2' 'w2'});
model.result('pg4').run;

model.view('view3').set('showgrid', false);

model.title('Vibrations of an Impeller');

model.description('This is a tutorial intended to demonstrate the use of dynamic cyclic symmetry while visualizing the results on the full geometry. A 3D impeller with eight identical blades can be divided into eight sectors of symmetry. The model computes the fundamental frequencies for the whole impeller geometry, and compares them to the values computed for a single sector using a cyclic symmetry condition on two sector boundaries. It also demonstrates how to set up a frequency-response analysis for one sector of symmetry.');

model.mesh.clearMeshes;

model.sol('sol1').clearSolutionData;
model.sol('sol2').clearSolutionData;
model.sol('sol3').clearSolutionData;
model.sol('sol4').clearSolutionData;

model.label('impeller.mph');

model.modelNode.label('Components');

out = model;
```

---

## Example 8: pharmaceutical_tableting_process

**Module:** Nonlinear_Structural_Materials_Module_Porous_Plasticity_pharmaceutical_tableting_process  
**Category:** Unknown_Category  

### Model Description

### Model Overview
The COMSOL MATLAB script provided simulates the pharmaceutical tableting process, which involves the compaction of microcrystalline cellulose (MCC) powder within a die. This process is critical in the pharmaceutical industry for producing tablets. The simulation employs the Capped Drucker-Prager model, which is suitable for simulating the compaction processes of pharmaceutical powders where material properties are density-dependent.

### Geometry
The geometric setup consists of a powder-filled mold with an initial height (H0) of 12.5 mm and an initial radius (R0) of 6 mm. The geometry is axisymmetric, simplifying the 3D problem to a 2D analysis. The model includes a die and a punch for applying compaction pressure to the powder.

### Materials
The material used in the simulation is microcrystalline cellulose (MCC), a common excipient in pharmaceutical tablets. The material properties are calibrated based on experimental data and include:
- Young's Modulus and Poisson's ratio, which are functions of the relative density.
- Poroplastic material model with an initial void volume fraction (F0).
- Drucker-Prager criterion parameters (alpha and k) that depend on the relative density.
- Mohr-Coulomb criterion with an isotropic hardening modulus (KIso).
- Density that updates with the current powder density during compaction.

### Physics
The simulation utilizes the Nonlinear Structural Materials Module with the Porous Plasticity interface to account for the density-dependent material behavior. The physics interfaces involved include:
- Solid Mechanics (solid) for structural analysis.
- Porous Plasticity (popl1) for modeling the powder compaction with a Capped Drucker-Prager yield surface and an exponential hardening model.
- Friction (fric1) for contact between the powder and the die walls.
- Rigid Domain (rd1) for the punch movement.

### Boundary Conditions
Boundary conditions include:
- A prescribed displacement on the top boundary, representing the punch movement.
- Frictional contact between the powder and the die walls.

### Mesh
The geometry is discretized using a mapped mesh with different distribution settings for various geometry features to ensure adequate resolution. The mesh is refined in critical areas to capture the high stress and strain gradients during compaction accurately.

### Study
The analysis performed is a stationary (steady-state) study, which means the solution does not depend on time. The study uses parametric analysis to simulate the compaction process by varying the punch displacement.

### Key Parameters
Important parameters include:
- Initial height (H0) and radius (R0) of the powder mold.
- True powder density (Rhof) and tapped bulk powder density (Rhobulk).
- Initial relative density (Rhorel0) and void volume fraction (F0).
- Isotropic hardening modulus (KIso) and ellipse aspect ratio (Rc) for the Mohr-Coulomb criterion.
- Punch displacement (punchDisp) for controlling the compaction process.

### Expected Results
The model predicts the stress distribution, displacement field, and relative density distribution within the powder during compaction. It also computes the punch force required for compaction and the resulting tablet density.

### Engineering Application
This simulation addresses the real-world engineering problem of optimizing the pharmaceutical tableting process. By understanding the compaction behavior of MCC powder under different conditions, engineers can design more efficient tableting processes, ensuring uniform density distribution and minimizing defects in the final tablets. This optimization is crucial for producing high-quality pharmaceutical products with consistent mechanical properties and drug content uniformity.

### COMSOL MATLAB Code

```matlab
function out = model
%
% pharmaceutical_tableting_process.m
%
% Model exported on May 26 2025, 21:31 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/Nonlinear_Structural_Materials_Module/Porous_Plasticity');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 2);
model.geom('geom1').model('comp1');
model.geom('geom1').axisymmetric(true);

model.mesh.create('mesh1', 'geom1');

model.physics.create('solid', 'SolidMechanics', 'geom1');
model.physics('solid').model('comp1');

model.study.create('std1');
model.study('std1').create('stat', 'Stationary');
model.study('std1').feature('stat').setSolveFor('/physics/solid', true);

% To import content from file, use:
% model.param.loadFile('FILENAME');
model.param.set('para', '0', 'Parameter');
model.param.set('H0', '12.5[mm]', 'Initial height of the powder mold');
model.param.set('R0', '6[mm]', 'Initial radius of the powder mold');
model.param.set('Nu', '0.16', 'Poisson''s ratio');
model.param.set('Rhof', '1.59[g/cm^3]', 'True powder density');
model.param.set('Rhobulk', '0.36[g/cm^3]', 'Tapped bulk powder density');
model.param.set('Rhorel0', 'Rhobulk/Rhof', 'Initial relative density');
model.param.set('F0', '1-Rhorel0', 'Initial void volume fraction');
model.param.set('KIso', '37.5[MPa]', 'Isotropic hardening modulus');
model.param.set('Rc', '3*sqrt(3)*0.5', 'Ellipse aspect ratio');
model.param.set('Pb0', '0[MPa]', 'Initial location of the cap');
model.param.set('A0', 'pi*R0^2', 'Die area');
model.param.set('V0', 'A0*H0', 'Initial powder volume');
model.param.set('PowderMass', 'Rhobulk*V0', 'Powder mass inside the die');
model.param.set('Hf', '(PowderMass/(A0))/Rhof', 'Final height of the powder mold');
model.param.set('Epzmax', '-((Hf-H0)/H0+0.5*((Hf-H0)/H0)^2)', 'Maximum plastic axial strain');
model.param.set('Epvolmax', 'Epzmax', 'Maximum plastic volumetric strain');

model.func.create('an1', 'Analytic');
model.func('an1').label('Young''s Modulus');
model.func('an1').set('funcname', 'EE');
model.func('an1').set('expr', '111.96*exp(4.395*x)');
model.func('an1').setIndex('argunit', 1, 0);
model.func('an1').set('fununit', 'MPa');
model.func('an1').setIndex('plotargs', 0.3, 0, 1);
model.func('an1').setIndex('plotargs', 1, 0, 2);
model.func.create('an2', 'Analytic');
model.func('an2').label('Drucker Prager Parameter k');
model.func('an2').set('funcname', 'Kd');
model.func('an2').set('expr', '0.2955*exp(4.5642*x)/sqrt(3)');
model.func('an2').setIndex('argunit', 1, 0);
model.func('an2').set('fununit', 'MPa');
model.func('an2').setIndex('plotargs', 0.6, 0, 1);
model.func('an2').setIndex('plotargs', 0.875, 0, 2);
model.func.create('an3', 'Analytic');
model.func('an3').label('Drucker Prager Parameter alpha');
model.func('an3').set('funcname', 'Alpha');
model.func('an3').set('expr', 'tan((12.628*x+56.194)[deg])/(3*sqrt(3))');
model.func('an3').setIndex('argunit', 1, 0);
model.func('an3').set('fununit', '1');
model.func('an3').setIndex('plotargs', 0.6, 0, 1);
model.func('an3').setIndex('plotargs', 0.875, 0, 2);
model.func.create('an4', 'Analytic');
model.func('an4').label('Hardening Function');
model.func('an4').set('funcname', 'Pbh');
model.func('an4').set('expr', '-KIso*log(1+x/Epvolmax)');
model.func('an4').setIndex('argunit', 1, 0);
model.func('an4').set('fununit', 'Pa');
model.func('an4').setIndex('plotargs', '-Epvolmax', 0, 1);
model.func('an4').setIndex('plotargs', 0, 0, 2);

model.geom('geom1').create('r1', 'Rectangle');
model.geom('geom1').feature('r1').set('size', {'R0' 'H0'});
model.geom('geom1').feature.duplicate('r2', 'r1');
model.geom('geom1').feature('r2').set('size', {'R0' 'H0/10'});
model.geom('geom1').feature('r2').set('pos', {'0' 'H0'});
model.geom('geom1').feature.duplicate('r3', 'r2');
model.geom('geom1').feature('r3').set('pos', {'0' '-H0/10'});
model.geom('geom1').feature.duplicate('r4', 'r3');
model.geom('geom1').feature('r4').set('size', {'R0/4' 'H0'});
model.geom('geom1').feature('r4').set('pos', {'R0' '0'});
model.geom('geom1').runPre('fin');
model.geom('geom1').feature('fin').set('action', 'assembly');
model.geom('geom1').feature('fin').set('pairtype', 'contact');
model.geom('geom1').run('fin');

model.pair('ap2').swap;
model.pair('ap3').swap;

model.cpl.create('intop1', 'Integration', 'geom1');
model.cpl('intop1').set('axisym', true);
model.cpl('intop1').selection.geom('geom1', 1);
model.cpl('intop1').selection.set([7]);
model.cpl.duplicate('intop2', 'intop1');
model.cpl('intop2').selection.set([8]);
model.cpl('intop2').set('axisym', false);

model.variable.create('var1');
model.variable('var1').model('comp1');
model.variable('var1').set('Punchforce', 'intop1(-solid.sz)');
model.variable('var1').descr('Punchforce', 'Punch force');
model.variable('var1').set('Punchpressure', 'Punchforce/A0');
model.variable('var1').descr('Punchpressure', 'Punch force');
model.variable('var1').set('Rho', 'PowderMass/(A0*intop2(1))');
model.variable('var1').descr('Rho', 'Current powder density');

model.func.create('pw1', 'Piecewise');
model.func('pw1').model('comp1');
model.func('pw1').set('funcname', 'punchDisp');
model.func('pw1').setIndex('pieces', 0, 0, 0);
model.func('pw1').setIndex('pieces', 1, 0, 1);
model.func('pw1').setIndex('pieces', '0.75*H0*x', 0, 2);
model.func('pw1').setIndex('pieces', 1, 1, 0);
model.func('pw1').setIndex('pieces', 2, 1, 1);
model.func('pw1').setIndex('pieces', '0.75*H0-0.15*H0*(x-1)', 1, 2);
model.func('pw1').set('argunit', '1');
model.func('pw1').set('fununit', 'm');

model.physics('solid').selection.set([2 3]);
model.physics('solid').feature('lemm1').create('popl1', 'PorousPlasticity', 2);
model.physics('solid').feature('lemm1').feature('popl1').set('YieldFunction', 'DPC');
model.physics('solid').feature('lemm1').feature('popl1').set('HardeningModel', 'Exponential');
model.physics('solid').feature('lemm1').feature('popl1').set('pb0', 'Pb0');
model.physics('solid').feature('lemm1').feature('popl1').set('nonlocalPlasticModel', 'impGradient');
model.physics('solid').feature('lemm1').feature('popl1').set('lintm', '1.6[mm]');
model.physics('solid').feature('dcnt1').create('fric1', 'Friction', 1);
model.physics('solid').feature('dcnt1').feature('fric1').set('mu_fric', 0.1);
model.physics('solid').create('rd1', 'RigidDomain', 2);
model.physics('solid').feature('rd1').selection.set([3]);
model.physics('solid').feature('rd1').create('pdr1', 'PrescribedDispRot', -1);
model.physics('solid').feature('rd1').feature('pdr1').set('W0', '-punchDisp(para)');

model.material.create('mat1', 'Common', 'comp1');
model.material('mat1').label('Microcrystalline Cellulose (MCC)');
model.material('mat1').selection.set([2]);
model.material('mat1').propertyGroup.create('Enu', 'Young''s_modulus_and_Poisson''s_ratio');
model.material('mat1').propertyGroup('Enu').set('E', {'EE(nojac(solid.lemm1.popl1.rhorel))'});
model.material('mat1').propertyGroup('Enu').set('nu', {'Nu'});
model.material('mat1').propertyGroup('def').set('density', {'Rho'});
model.material('mat1').propertyGroup.create('PoroplasticModel', 'Poroplastic_material_model');
model.material('mat1').propertyGroup('PoroplasticModel').set('f0', {'F0'});
model.material('mat1').propertyGroup.create('DruckerPrager', 'Drucker_Prager_criterion');
model.material('mat1').propertyGroup('DruckerPrager').set('alphaDrucker', {'Alpha(nojac(solid.lemm1.popl1.rhorel))'});
model.material('mat1').propertyGroup('DruckerPrager').set('kDrucker', {'Kd(nojac(solid.lemm1.popl1.rhorel))'});
model.material('mat1').propertyGroup.create('MohrCoulomb', 'Mohr_Coulomb_criterion');
model.material('mat1').propertyGroup('MohrCoulomb').set('Kiso', {'KIso'});
model.material('mat1').propertyGroup('MohrCoulomb').set('epvolmax', {'Epvolmax'});
model.material('mat1').propertyGroup('MohrCoulomb').set('Rcap', {'Rc'});

model.mesh('mesh1').create('map1', 'Map');
model.mesh('mesh1').feature('map1').create('dis1', 'Distribution');
model.mesh('mesh1').feature('map1').feature('dis1').selection.set([2 4 11 12 13 14]);
model.mesh('mesh1').feature('map1').feature('dis1').set('numelem', 1);
model.mesh('mesh1').feature('map1').create('dis2', 'Distribution');
model.mesh('mesh1').feature('map1').feature('dis2').selection.set([6]);
model.mesh('mesh1').feature('map1').feature('dis2').set('numelem', 12);
model.mesh('mesh1').feature('map1').create('dis3', 'Distribution');
model.mesh('mesh1').feature('map1').feature('dis3').selection.set([5]);
model.mesh('mesh1').feature('map1').feature('dis3').set('numelem', 16);
model.mesh('mesh1').run;

model.study('std1').feature('stat').set('useparam', true);
model.study('std1').feature('stat').setIndex('pname', 'para', 0);
model.study('std1').feature('stat').setIndex('plistarr', '', 0);
model.study('std1').feature('stat').setIndex('punit', '', 0);
model.study('std1').feature('stat').setIndex('pname', 'para', 0);
model.study('std1').feature('stat').setIndex('plistarr', '', 0);
model.study('std1').feature('stat').setIndex('punit', '', 0);
model.study('std1').feature('stat').setIndex('plistarr', 'range(0,0.01,1.1)', 0);
model.study('std1').feature('stat').setIndex('punit', 1, 0);

model.sol.create('sol1');
model.sol('sol1').study('std1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'stat');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').feature('comp1_solid_lemm1_popl1_epmnl').set('scalemethod', 'manual');
model.sol('sol1').feature('v1').feature('comp1_solid_rd_disp').set('scalemethod', 'manual');
model.sol('sol1').feature('v1').feature('comp1_u').set('scalemethod', 'manual');
model.sol('sol1').feature('v1').feature('comp1_solid_lemm1_popl1_epmnl').set('resscalemethod', 'parent');
model.sol('sol1').feature('v1').feature('comp1_solid_rd_disp').set('resscalemethod', 'parent');
model.sol('sol1').feature('v1').feature('comp1_solid_lemm1_popl1_epmnl').set('scaleval', '1');
model.sol('sol1').feature('v1').feature('comp1_solid_rd_disp').set('scaleval', '1.6770509831248427E-4');
model.sol('sol1').feature('v1').feature('comp1_u').set('scaleval', '1e-2*0.016770509831248427');
model.sol('sol1').feature('v1').set('control', 'stat');
model.sol('sol1').create('s1', 'Stationary');
model.sol('sol1').feature('s1').create('p1', 'Parametric');
model.sol('sol1').feature('s1').feature.remove('pDef');
model.sol('sol1').feature('s1').feature('p1').set('porder', 'constant');
model.sol('sol1').feature('s1').feature('p1').set('control', 'stat');
model.sol('sol1').feature('s1').set('control', 'stat');
model.sol('sol1').feature('s1').feature('aDef').set('cachepattern', true);
model.sol('sol1').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('s1').feature('fc1').set('dtech', 'ddog');
model.sol('sol1').feature('s1').feature('fc1').set('linsolver', 'dDef');
model.sol('sol1').feature('s1').feature('fc1').set('dtech', 'ddog');
model.sol('sol1').feature('s1').feature.remove('fcDef');
model.sol('sol1').attach('std1');
model.sol('sol1').feature('s1').feature('p1').set('paramtuning', true);
model.sol('sol1').feature('s1').feature('p1').set('pinitstep', '1E-5');
model.sol('sol1').feature('s1').feature('p1').set('pminstep', '1E-5');
model.sol('sol1').feature('s1').feature('p1').set('porder', 'auto');
model.sol('sol1').feature('s1').feature('fc1').set('dtech', 'const');
model.sol('sol1').runAll;

model.result.create('pg1', 'PlotGroup2D');
model.result('pg1').set('data', 'dset1');
model.result('pg1').setIndex('looplevel', 111, 0);
model.result('pg1').set('defaultPlotID', 'stress');
model.result('pg1').label('Stress (solid)');
model.result('pg1').set('frametype', 'spatial');
model.result('pg1').create('surf1', 'Surface');
model.result('pg1').feature('surf1').set('expr', {'solid.misesGp'});
model.result('pg1').feature('surf1').set('threshold', 'manual');
model.result('pg1').feature('surf1').set('thresholdvalue', 0.2);
model.result('pg1').feature('surf1').set('colortable', 'Rainbow');
model.result('pg1').feature('surf1').set('colortabletrans', 'none');
model.result('pg1').feature('surf1').set('colorscalemode', 'linear');
model.result('pg1').feature('surf1').set('resolution', 'normal');
model.result('pg1').feature('surf1').set('colortable', 'Prism');
model.result('pg1').feature('surf1').create('def', 'Deform');
model.result('pg1').feature('surf1').feature('def').set('scaleactive', true);
model.result('pg1').feature('surf1').feature('def').set('scale', '1');
model.result('pg1').feature('surf1').feature('def').set('expr', {'u' 'w'});
model.result('pg1').feature('surf1').feature('def').set('descr', 'Displacement field');
model.result.dataset.create('dset1solidrev', 'Revolve2D');
model.result.dataset('dset1solidrev').set('data', 'dset1');
model.result.dataset('dset1solidrev').set('revangle', 225);
model.result.dataset('dset1solidrev').set('startangle', -90);
model.result.dataset('dset1solidrev').set('hasspacevars', true);
model.result.create('pg2', 'PlotGroup3D');
model.result('pg2').set('data', 'dset1solidrev');
model.result('pg2').setIndex('looplevel', 111, 0);
model.result('pg2').set('defaultPlotID', 'stress3D');
model.result('pg2').label('Stress, 3D (solid)');
model.result('pg2').set('frametype', 'spatial');
model.result('pg2').create('surf1', 'Surface');
model.result('pg2').feature('surf1').set('expr', {'solid.misesGp'});
model.result('pg2').feature('surf1').set('threshold', 'manual');
model.result('pg2').feature('surf1').set('thresholdvalue', 0.2);
model.result('pg2').feature('surf1').set('colortable', 'Rainbow');
model.result('pg2').feature('surf1').set('colortabletrans', 'none');
model.result('pg2').feature('surf1').set('colorscalemode', 'linear');
model.result('pg2').feature('surf1').set('colortable', 'Prism');
model.result('pg2').feature('surf1').create('def', 'Deform');
model.result.dataset('dset1solidrev').set('hasspacevars', true);
model.result('pg2').feature('surf1').feature('def').set('revcoordsys', 'cylindrical');
model.result('pg2').feature('surf1').feature('def').set('expr', {'u' 'v' 'w'});
model.result('pg2').feature('surf1').feature('def').set('descr', 'Displacement field');
model.result('pg2').feature('surf1').feature('def').set('descractive', true);
model.result('pg2').feature('surf1').feature('def').set('scaleactive', true);
model.result('pg2').feature('surf1').feature('def').set('scale', '1');
model.result('pg1').run;
model.result('pg1').setIndex('looplevel', 101, 0);
model.result('pg1').run;
model.result.dataset.duplicate('dset2', 'dset1');
model.result.dataset('dset2').selection.geom('geom1', 2);
model.result.dataset('dset2').selection.geom('geom1', 2);
model.result.dataset('dset2').selection.set([4]);
model.result.dataset.duplicate('dset1solidrev1', 'dset1solidrev');
model.result.dataset('dset1solidrev1').set('data', 'dset2');
model.result.dataset.create('av1', 'Average');
model.result.dataset('av1').set('intsurface', true);
model.result.dataset('av1').set('intvolume', true);
model.result.dataset('av1').set('showlevel', 'off');
model.result.dataset('av1').selection.geom('geom1', 2);
model.result.dataset('av1').selection.set([2]);
model.result('pg2').run;
model.result('pg2').setIndex('looplevel', 51, 0);
model.result('pg2').set('titletype', 'custom');
model.result('pg2').set('solutionintitle', false);
model.result('pg2').set('edges', false);
model.result('pg2').set('plotarrayenable', true);
model.result('pg2').set('legendpos', 'bottom');
model.result('pg2').create('surf2', 'Surface');
model.result('pg2').feature('surf2').set('arraydim', '1');
model.result('pg2').feature('surf2').set('data', 'dset1solidrev1');
model.result('pg2').feature('surf2').set('solutionparams', 'parent');
model.result('pg2').feature('surf2').set('expr', '1');
model.result('pg2').feature('surf2').set('titletype', 'none');
model.result('pg2').feature('surf2').set('coloring', 'uniform');
model.result('pg2').feature('surf2').set('color', 'gray');
model.result('pg2').feature('surf2').set('manualindexing', true);
model.result('pg2').feature('surf2').create('mtrl1', 'MaterialAppearance');
model.result('pg2').run;
model.result('pg2').feature('surf2').feature('mtrl1').set('appearance', 'custom');
model.result('pg2').feature('surf2').feature('mtrl1').set('family', 'steel');
model.result('pg2').run;
model.result('pg2').create('line1', 'Line');
model.result('pg2').feature('line1').set('arraydim', '1');
model.result('pg2').feature('line1').set('data', 'dset1solidrev1');
model.result('pg2').feature('line1').set('expr', '1');
model.result('pg2').feature('line1').set('titletype', 'none');
model.result('pg2').feature('line1').set('coloring', 'uniform');
model.result('pg2').feature('line1').set('color', 'black');
model.result('pg2').feature('line1').set('manualindexing', true);
model.result('pg2').feature('surf1').set('arraydim', '1');
model.result('pg2').run;
model.result('pg2').feature('surf1').set('unit', 'MPa');
model.result('pg2').feature.duplicate('surf3', 'surf1');
model.result('pg2').feature('surf3').set('arraydim', '1');
model.result('pg2').run;
model.result('pg2').feature('surf3').set('data', 'dset1solidrev');
model.result('pg2').feature('surf3').setIndex('looplevel', 101, 0);
model.result('pg2').feature('surf3').set('titletype', 'none');
model.result('pg2').feature('surf3').set('inheritplot', 'surf1');
model.result('pg2').feature('surf2').set('arraydim', '1');
model.result('pg2').run;
model.result('pg2').feature.duplicate('surf4', 'surf2');
model.result('pg2').feature('surf4').set('arraydim', '1');
model.result('pg2').run;
model.result('pg2').feature('surf4').set('arrayindex', 1);
model.result('pg2').feature('line1').set('arraydim', '1');
model.result('pg2').run;
model.result('pg2').feature.duplicate('line2', 'line1');
model.result('pg2').feature('line2').set('arraydim', '1');
model.result('pg2').run;
model.result('pg2').feature('line2').set('arrayindex', 1);
model.result('pg2').feature('surf3').set('arraydim', '1');
model.result('pg2').run;
model.result('pg2').feature.duplicate('surf5', 'surf3');
model.result('pg2').feature('surf5').set('arraydim', '1');
model.result('pg2').run;
model.result('pg2').feature('surf5').setIndex('looplevel', 111, 0);
model.result('pg2').feature('surf4').set('arraydim', '1');
model.result('pg2').run;
model.result('pg2').feature.duplicate('surf6', 'surf4');
model.result('pg2').feature('surf6').set('arraydim', '1');
model.result('pg2').run;
model.result('pg2').feature('surf6').set('arrayindex', 2);
model.result('pg2').feature('line2').set('arraydim', '1');
model.result('pg2').run;
model.result('pg2').feature.duplicate('line3', 'line2');
model.result('pg2').feature('line3').set('arraydim', '1');
model.result('pg2').run;
model.result('pg2').feature('line3').set('arrayindex', 2);
model.result('pg2').run;
model.result('pg2').create('tlan1', 'TableAnnotation');
model.result('pg2').feature('tlan1').set('arraydim', '1');
model.result('pg2').feature('tlan1').set('source', 'localtable');
model.result('pg2').feature('tlan1').setIndex('localtablematrix', '-R0', 0, 0);
model.result('pg2').feature('tlan1').setIndex('localtablematrix', 0, 0, 1);
model.result('pg2').feature('tlan1').setIndex('localtablematrix', '-6[mm]', 0, 2);
model.result('pg2').feature('tlan1').setIndex('localtablematrix', 'Half compaction', 0, 3);
model.result('pg2').feature('tlan1').setIndex('localtablematrix', '3*R0', 1, 0);
model.result('pg2').feature('tlan1').setIndex('localtablematrix', 0, 1, 1);
model.result('pg2').feature('tlan1').setIndex('localtablematrix', '-10[mm]', 1, 2);
model.result('pg2').feature('tlan1').setIndex('localtablematrix', 'Max compaction', 1, 3);
model.result('pg2').feature('tlan1').setIndex('localtablematrix', '6*R0', 2, 0);
model.result('pg2').feature('tlan1').setIndex('localtablematrix', 0, 2, 1);
model.result('pg2').feature('tlan1').setIndex('localtablematrix', '-10[mm]', 2, 2);
model.result('pg2').feature('tlan1').setIndex('localtablematrix', 'Decompression', 2, 3);
model.result('pg2').run;
model.result('pg2').feature('tlan1').set('latexmarkup', true);
model.result('pg2').feature('tlan1').set('showpoint', false);
model.result('pg2').run;

model.view('view2').set('showgrid', false);

model.result('pg2').run;
model.result.duplicate('pg3', 'pg2');
model.result('pg3').run;
model.result('pg3').label('Relative Density');
model.result('pg3').set('showlegendsmaxmin', true);
model.result('pg3').feature('surf1').set('arraydim', '1');
model.result('pg3').run;
model.result('pg3').feature('surf1').set('expr', 'solid.rhorelGp');
model.result('pg3').feature('surf1').set('descr', 'Current relative density');
model.result('pg3').feature('surf1').set('colortable', 'Rainbow');
model.result('pg3').feature('surf3').set('arraydim', '1');
model.result('pg3').run;
model.result('pg3').feature('surf3').set('expr', 'solid.rhorelGp');
model.result('pg3').feature('surf3').set('descr', 'Current relative density');
model.result('pg3').feature('surf5').set('arraydim', '1');
model.result('pg3').run;
model.result('pg3').feature('surf5').set('expr', 'solid.rhorelGp');
model.result('pg3').feature('surf5').set('descr', 'Current relative density');
model.result('pg3').run;
model.result('pg3').run;
model.result.create('pg4', 'PlotGroup2D');
model.result('pg4').set('data', 'dset1');
model.result('pg4').setIndex('looplevel', 111, 0);
model.result('pg4').label('Volumetric Plastic Strain (solid)');
model.result('pg4').set('defaultPlotID', 'volumetricPlasticStrain');
model.result('pg4').create('surf1', 'Surface');
model.result('pg4').feature('surf1').set('expr', {'solid.epvolGp'});
model.result('pg4').feature('surf1').set('inheritplot', 'none');
model.result('pg4').feature('surf1').set('resolution', 'normal');
model.result('pg4').feature('surf1').set('colortabletype', 'discrete');
model.result('pg4').feature('surf1').set('bandcount', 11);
model.result('pg4').feature('surf1').set('colortable', 'AuroraAustralisDark');
model.result('pg4').feature('surf1').set('descractive', true);
model.result('pg4').feature('surf1').set('descr', 'Volumetric plastic strain');
model.result('pg4').label('Volumetric Plastic Strain (solid)');
model.result('pg4').run;
model.result('pg4').setIndex('looplevel', 101, 0);
model.result('pg4').set('legendactive', true);
model.result('pg4').set('legendprecision', 4);
model.result('pg4').run;
model.result.create('pg5', 'PlotGroup1D');
model.result('pg5').run;
model.result('pg5').label('Axial Punch Pressure Vs. Axial Compaction');
model.result('pg5').set('titletype', 'none');
model.result('pg5').set('xlabelactive', true);
model.result('pg5').set('xlabel', 'Axial compaction (mm)');
model.result('pg5').set('ylabelactive', true);
model.result('pg5').set('ylabel', 'Axial punch force (MPa)');
model.result('pg5').create('glob1', 'Global');
model.result('pg5').feature('glob1').set('markerpos', 'datapoints');
model.result('pg5').feature('glob1').set('linewidth', 'preference');
model.result('pg5').feature('glob1').setIndex('expr', 'Punchpressure', 0);
model.result('pg5').feature('glob1').setIndex('unit', 'MPa', 0);
model.result('pg5').feature('glob1').setIndex('descr', 'Punch Pressure', 0);
model.result('pg5').feature('glob1').set('xdata', 'expr');
model.result('pg5').feature('glob1').set('xdataexpr', 'punchDisp(para)');
model.result('pg5').feature('glob1').set('xdataunit', 'mm');
model.result('pg5').feature('glob1').set('legend', false);
model.result('pg5').run;
model.result.create('pg6', 'PlotGroup1D');
model.result('pg6').run;
model.result('pg6').label('Relative Density and Volume Ratio');
model.result('pg6').setIndex('looplevelinput', 'manualindices', 0);
model.result('pg6').setIndex('looplevelindices', 'range(1,1,101)', 0);
model.result('pg6').set('titletype', 'none');
model.result('pg6').set('xlabelactive', true);
model.result('pg6').set('xlabel', 'Axial compaction (mm)');
model.result('pg6').set('ylabelactive', true);
model.result('pg6').set('ylabel', 'Relative density (1)');
model.result('pg6').set('twoyaxes', true);
model.result('pg6').set('yseclabelactive', true);
model.result('pg6').set('yseclabel', 'Volume ratio (1)');
model.result('pg6').create('glob1', 'Global');
model.result('pg6').feature('glob1').set('markerpos', 'datapoints');
model.result('pg6').feature('glob1').set('linewidth', 'preference');
model.result('pg6').feature('glob1').setIndex('expr', '((PowderMass/(A0*intop2(1)))/Rhof)', 0);
model.result('pg6').feature('glob1').setIndex('unit', 1, 0);
model.result('pg6').feature('glob1').setIndex('descr', 'Tablet relative density', 0);
model.result('pg6').feature('glob1').set('xdata', 'expr');
model.result('pg6').feature('glob1').set('xdataexpr', 'punchDisp(para)');
model.result('pg6').feature('glob1').set('xdataunit', 'mm');
model.result('pg6').feature('glob1').set('autosolution', false);
model.result('pg6').feature.duplicate('glob2', 'glob1');
model.result('pg6').run;
model.result('pg6').feature('glob2').set('data', 'av1');
model.result('pg6').feature('glob2').setIndex('looplevelinput', 'manualindices', 0);
model.result('pg6').feature('glob2').setIndex('looplevelindices', 'range(1,1,101)', 0);
model.result('pg6').feature('glob2').setIndex('expr', 'solid.lemm1.popl1.rhorel', 0);
model.result('pg6').feature('glob2').setIndex('unit', 1, 0);
model.result('pg6').feature('glob2').setIndex('descr', 'Average relative density', 0);
model.result('pg6').feature.duplicate('glob3', 'glob2');
model.result('pg6').run;
model.result('pg6').feature('glob3').setIndex('expr', 'solid.J', 0);
model.result('pg6').feature('glob3').setIndex('unit', 1, 0);
model.result('pg6').feature('glob3').setIndex('descr', 'Total volume ratio', 0);
model.result('pg6').feature('glob3').setIndex('expr', 'solid.Jp', 1);
model.result('pg6').feature('glob3').setIndex('unit', 1, 1);
model.result('pg6').feature('glob3').setIndex('descr', 'Plastic volume ratio', 1);
model.result('pg6').run;
model.result('pg6').setIndex('plotonsecyaxis', true, 2, 1);
model.result('pg6').set('legendpos', 'middleleft');
model.result('pg6').run;
model.result('pg3').run;

model.title('Pharmaceutical Tableting Process');

model.description(['Powder compaction is a popular manufacturing process not only in powder metallurgy, but also in the pharmaceutical industry. The Capped Drucker' native2unicode(hex2dec({'20' '13'}), 'unicode') 'Prager model is commonly used for simulating the compaction processes of pharmaceutical powders, where the material properties depend on the powder density. In this example, microcrystalline cellulose (MCC) is compacted, and the constitutive material properties are calibrated based on experimental data.']);

model.mesh.clearMeshes;

model.sol('sol1').clearSolutionData;

model.label('pharmaceutical_tableting_process.mph');

model.modelNode.label('Components');

out = model;
```

---

## Example 9: bracket_thermal

**Module:** Structural_Mechanics_Module_Tutorials_bracket_thermal  
**Category:** Unknown_Category  

### Model Description

**Model Overview**:
The COMSOL MATLAB script provided simulates a thermal-stress analysis of a bracket. This type of analysis is crucial in understanding how structures respond to thermal loads, which can cause expansion, contraction, and consequently, stress within the material. The model combines heat transfer and structural mechanics to evaluate the thermal stresses developed within the bracket when subjected to thermal and mechanical boundary conditions.

**Geometry**:
The geometry of the model is imported from an external file named "bracket.mphbin". The specifics of the geometry such as dimensions and shapes are not detailed in the script, but it is implied that the bracket has features such as holes and fillets typical of a structural support component.

**Materials**:
The material used in the simulation is labeled as "Structural Steel". The key properties of the material are defined both as constants and as functions of temperature. These properties include:
- Young's modulus and Poisson's ratio (with temperature-dependent interpolation functions)
- Thermal expansion coefficient
- Heat capacity
- Thermal conductivity
- Electrical conductivity
- Density
The material also includes definitions for various elasto-plastic and viscoplastic models such as Murnaghan, Elastoplastic, Ludwik, Johnson-Cook, Swift, Voce, Hockett-Sherby, Armstrong-Frederick, Norton, and Garofalo. These models are used to describe the material's behavior under different loading conditions.

**Physics**:
The model involves two primary physics interfaces:
1. Solid Mechanics (solid) - for simulating the structural behavior of the bracket.
2. Heat Transfer (ht) - for simulating the thermal behavior of the bracket.
Additionally, a multiphysics interface, Thermal Expansion (te1), is used to couple the thermal and structural simulations, allowing the heat transfer analysis to affect the structural analysis through thermal expansion.

**Boundary Conditions**:
Boundary conditions applied to the model include:
- Roller boundary conditions on certain edges (possibly to simulate fixed points where the bracket is attached or supported).
- Spring Foundation boundary conditions on other edges (possibly to simulate some form of elastic support).
- Convective heat flux boundary condition over most of the bracket's surface (to simulate heat exchange with the surrounding environment).
- A specific heat flux boundary condition applied to two selected surfaces (possibly where a heat source is applied).

**Mesh**:
The geometry is discretized using a mesh with a custom size setting. The maximum element size is set to 8 mm, and the mesh is refined with a factor of 2. This discretization is crucial for accurately capturing the geometry and the physical phenomena occurring within the model.

**Study**:
The analysis performed is stationary (steady-state), meaning that the solution does not account for time-dependent changes. The study solves for both the structural and thermal fields simultaneously.

**Key Parameters**:
Important parameters include material properties that are temperature-dependent, the convective heat transfer coefficient (10 W/(m*K)), and the heat flux applied to specific surfaces (1e4 W/m^2). The mechanical properties of the spring foundation boundary conditions are also important, with a stiffness of 600 kN/mm.

**Expected Results**:
The model predicts the temperature distribution within the bracket and the resulting stresses and displacements due to thermal expansion and applied mechanical constraints. The stress distribution is visualized using a volume plot of the von Mises stress, and the temperature distribution is visualized using a volume plot of the temperature field.

**Engineering Application**:
This model can be applied to analyze and design brackets and other structural components that are subjected to thermal loads, such as those found in engines, furnaces, or other high-temperature environments. By understanding the thermal stresses that develop within the material, engineers can optimize the design for safety, efficiency, and durability.

### COMSOL MATLAB Code

```matlab
function out = model
%
% bracket_thermal.m
%
% Model exported on May 26 2025, 21:33 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/Structural_Mechanics_Module/Tutorials');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 3);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.physics.create('solid', 'SolidMechanics', 'geom1');
model.physics('solid').model('comp1');
model.physics('solid').prop('StructuralTransientBehavior').set('StructuralTransientBehavior', 'Quasistatic');
model.physics.create('ht', 'HeatTransfer', 'geom1');
model.physics('ht').model('comp1');

model.multiphysics.create('te1', 'ThermalExpansion', 'geom1', 3);
model.multiphysics('te1').set('Heat_physics', 'ht');
model.multiphysics('te1').set('Solid_physics', 'solid');
model.multiphysics('te1').selection.all;

model.study.create('std1');
model.study('std1').create('stat', 'Stationary');
model.study('std1').feature('stat').setSolveFor('/physics/solid', true);
model.study('std1').feature('stat').setSolveFor('/physics/ht', true);
model.study('std1').feature('stat').setSolveFor('/multiphysics/te1', true);

model.geom('geom1').create('imp1', 'Import');
model.geom('geom1').feature('imp1').set('type', 'native');
model.geom('geom1').feature('imp1').set('filename', 'bracket.mphbin');
model.geom('geom1').feature('imp1').importData;
model.geom('geom1').run('fin');

model.material.create('mat1', 'Common', 'comp1');
model.material('mat1').propertyGroup.create('Enu', 'Young''s modulus and Poisson''s ratio');
model.material('mat1').propertyGroup('Enu').func.create('int1', 'Interpolation');
model.material('mat1').propertyGroup('Enu').func.create('int2', 'Interpolation');
model.material('mat1').propertyGroup.create('Murnaghan', 'Murnaghan');
model.material('mat1').propertyGroup.create('ElastoplasticModel', 'Elastoplastic material model');
model.material('mat1').propertyGroup('ElastoplasticModel').func.create('int1', 'Interpolation');
model.material('mat1').propertyGroup.create('Ludwik', 'Ludwik');
model.material('mat1').propertyGroup('Ludwik').func.create('int1', 'Interpolation');
model.material('mat1').propertyGroup.create('JohnsonCook', 'Johnson-Cook');
model.material('mat1').propertyGroup.create('Swift', 'Swift');
model.material('mat1').propertyGroup.create('Voce', 'Voce');
model.material('mat1').propertyGroup('Voce').func.create('int1', 'Interpolation');
model.material('mat1').propertyGroup.create('HockettSherby', 'Hockett-Sherby');
model.material('mat1').propertyGroup('HockettSherby').func.create('int1', 'Interpolation');
model.material('mat1').propertyGroup.create('ArmstrongFrederick', 'Armstrong-Frederick');
model.material('mat1').propertyGroup('ArmstrongFrederick').func.create('int1', 'Interpolation');
model.material('mat1').propertyGroup.create('Norton', 'Norton');
model.material('mat1').propertyGroup.create('Garofalo', 'Garofalo (hyperbolic sine)');
model.material('mat1').propertyGroup.create('ChabocheViscoplasticity', 'Chaboche viscoplasticity');
model.material('mat1').label('Structural steel');
model.material('mat1').set('family', 'custom');
model.material('mat1').set('customspecular', [0.7843137254901961 0.7843137254901961 0.7843137254901961]);
model.material('mat1').set('customdiffuse', [0.6666666666666666 0.6666666666666666 0.6666666666666666]);
model.material('mat1').set('customambient', [0.6666666666666666 0.6666666666666666 0.6666666666666666]);
model.material('mat1').set('noise', true);
model.material('mat1').set('fresnel', 0.9);
model.material('mat1').set('roughness', 0.3);
model.material('mat1').set('metallic', 0);
model.material('mat1').set('pearl', 0);
model.material('mat1').set('diffusewrap', 0);
model.material('mat1').set('clearcoat', 0);
model.material('mat1').set('reflectance', 0);
model.material('mat1').propertyGroup('def').set('lossfactor', '0.02');
model.material('mat1').propertyGroup('def').set('relpermeability', {'1' '0' '0' '0' '1' '0' '0' '0' '1'});
model.material('mat1').propertyGroup('def').set('heatcapacity', '475[J/(kg*K)]');
model.material('mat1').propertyGroup('def').set('thermalconductivity', {'44.5[W/(m*K)]' '0' '0' '0' '44.5[W/(m*K)]' '0' '0' '0' '44.5[W/(m*K)]'});
model.material('mat1').propertyGroup('def').set('electricconductivity', {'4.032e6[S/m]' '0' '0' '0' '4.032e6[S/m]' '0' '0' '0' '4.032e6[S/m]'});
model.material('mat1').propertyGroup('def').set('relpermittivity', {'1' '0' '0' '0' '1' '0' '0' '0' '1'});
model.material('mat1').propertyGroup('def').set('thermalexpansioncoefficient', {'12.3e-6[1/K]' '0' '0' '0' '12.3e-6[1/K]' '0' '0' '0' '12.3e-6[1/K]'});
model.material('mat1').propertyGroup('def').set('density', '7850[kg/m^3]');
model.material('mat1').propertyGroup('Enu').func('int1').set('funcname', 'E');
model.material('mat1').propertyGroup('Enu').func('int1').set('table', {'293.15' '200e9'; '793.15' '166.6e9'});
model.material('mat1').propertyGroup('Enu').func('int1').set('extrap', 'linear');
model.material('mat1').propertyGroup('Enu').func('int1').set('fununit', {'Pa'});
model.material('mat1').propertyGroup('Enu').func('int1').set('argunit', {'K'});
model.material('mat1').propertyGroup('Enu').func('int2').set('funcname', 'nu');
model.material('mat1').propertyGroup('Enu').func('int2').set('table', {'293.15' '0.30'; '793.15' '0.315'});
model.material('mat1').propertyGroup('Enu').func('int2').set('extrap', 'linear');
model.material('mat1').propertyGroup('Enu').func('int2').set('fununit', {'1'});
model.material('mat1').propertyGroup('Enu').func('int2').set('argunit', {'K'});
model.material('mat1').propertyGroup('Enu').set('E', 'E(T)');
model.material('mat1').propertyGroup('Enu').set('nu', 'nu(T)');
model.material('mat1').propertyGroup('Enu').addInput('temperature');
model.material('mat1').propertyGroup('Murnaghan').set('l', '-3.0e11[Pa]');
model.material('mat1').propertyGroup('Murnaghan').set('m', '-6.2e11[Pa]');
model.material('mat1').propertyGroup('Murnaghan').set('n', '-7.2e11[Pa]');
model.material('mat1').propertyGroup('ElastoplasticModel').func('int1').set('funcname', 'a');
model.material('mat1').propertyGroup('ElastoplasticModel').func('int1').set('table', {'600' '1'; '1100' '0.1'; '1643' '0'});
model.material('mat1').propertyGroup('ElastoplasticModel').func('int1').set('fununit', {'1'});
model.material('mat1').propertyGroup('ElastoplasticModel').func('int1').set('argunit', {'K'});
model.material('mat1').propertyGroup('ElastoplasticModel').set('sigmags', '350[MPa]*a(T)');
model.material('mat1').propertyGroup('ElastoplasticModel').set('Et', '1.045[GPa]*a(T)');
model.material('mat1').propertyGroup('ElastoplasticModel').set('Ek', '1.045[GPa]*a(T)');
model.material('mat1').propertyGroup('ElastoplasticModel').set('sigmagh', '1.050[GPa]*epe*a(T)');
model.material('mat1').propertyGroup('ElastoplasticModel').addInput('temperature');
model.material('mat1').propertyGroup('ElastoplasticModel').addInput('effectiveplasticstrain');
model.material('mat1').propertyGroup('Ludwik').func('int1').set('funcname', 'a');
model.material('mat1').propertyGroup('Ludwik').func('int1').set('table', {'600' '1'; '1100' '0.1'; '1643' '0'});
model.material('mat1').propertyGroup('Ludwik').func('int1').set('fununit', {'1'});
model.material('mat1').propertyGroup('Ludwik').func('int1').set('argunit', {'K'});
model.material('mat1').propertyGroup('Ludwik').set('k_lud', '560[MPa]*a(T)');
model.material('mat1').propertyGroup('Ludwik').set('n_lud', '0.61');
model.material('mat1').propertyGroup('Ludwik').addInput('temperature');
model.material('mat1').propertyGroup('JohnsonCook').set('k_jcook', '560[MPa]');
model.material('mat1').propertyGroup('JohnsonCook').set('n_jcook', '0.61');
model.material('mat1').propertyGroup('JohnsonCook').set('C_jcook', '0.12');
model.material('mat1').propertyGroup('JohnsonCook').set('epet0_jcook', '1[1/s]');
model.material('mat1').propertyGroup('JohnsonCook').set('m_jcook', '0.6');
model.material('mat1').propertyGroup('Swift').set('e0_swi', '0.021');
model.material('mat1').propertyGroup('Swift').set('n_swi', '0.2');
model.material('mat1').propertyGroup('Voce').func('int1').set('funcname', 'a');
model.material('mat1').propertyGroup('Voce').func('int1').set('table', {'600' '1'; '1100' '0.1'; '1643' '0'});
model.material('mat1').propertyGroup('Voce').func('int1').set('fununit', {'1'});
model.material('mat1').propertyGroup('Voce').func('int1').set('argunit', {'K'});
model.material('mat1').propertyGroup('Voce').set('sigma_voc', '249[MPa]*a(T)');
model.material('mat1').propertyGroup('Voce').set('beta_voc', '9.3');
model.material('mat1').propertyGroup('Voce').addInput('temperature');
model.material('mat1').propertyGroup('HockettSherby').func('int1').set('funcname', 'a');
model.material('mat1').propertyGroup('HockettSherby').func('int1').set('table', {'600' '1'; '1100' '0.1'; '1643' '0'});
model.material('mat1').propertyGroup('HockettSherby').func('int1').set('fununit', {'1'});
model.material('mat1').propertyGroup('HockettSherby').func('int1').set('argunit', {'K'});
model.material('mat1').propertyGroup('HockettSherby').set('sigma_hoc', '684[MPa]*a(T)');
model.material('mat1').propertyGroup('HockettSherby').set('m_hoc', '3.9');
model.material('mat1').propertyGroup('HockettSherby').set('n_hoc', '0.85');
model.material('mat1').propertyGroup('HockettSherby').addInput('temperature');
model.material('mat1').propertyGroup('ArmstrongFrederick').func('int1').set('funcname', 'a');
model.material('mat1').propertyGroup('ArmstrongFrederick').func('int1').set('table', {'600' '1'; '1100' '0.1'; '1643' '0'});
model.material('mat1').propertyGroup('ArmstrongFrederick').func('int1').set('fununit', {'1'});
model.material('mat1').propertyGroup('ArmstrongFrederick').func('int1').set('argunit', {'K'});
model.material('mat1').propertyGroup('ArmstrongFrederick').set('Ck', '2.070[GPa]*a(T)');
model.material('mat1').propertyGroup('ArmstrongFrederick').set('gammak', '8.0');
model.material('mat1').propertyGroup('ArmstrongFrederick').addInput('temperature');
model.material('mat1').propertyGroup('Norton').set('A_nor', '1.2e-15[1/s]');
model.material('mat1').propertyGroup('Norton').set('sigRef_nor', '1[MPa]');
model.material('mat1').propertyGroup('Norton').set('n_nor', '4.5');
model.material('mat1').propertyGroup('Garofalo').set('A_gar', '1e-6[1/s]');
model.material('mat1').propertyGroup('Garofalo').set('sigRef_gar', '100[MPa]');
model.material('mat1').propertyGroup('Garofalo').set('n_gar', '4.6');
model.material('mat1').propertyGroup('ChabocheViscoplasticity').set('A_cha', '1');
model.material('mat1').propertyGroup('ChabocheViscoplasticity').set('sigRef_cha', '490[MPa]');
model.material('mat1').propertyGroup('ChabocheViscoplasticity').set('n_cha', '9');

model.physics('solid').create('roll1', 'Roller', 2);
model.physics('solid').feature('roll1').selection.set([17 27]);
model.physics('solid').create('spf1', 'SpringFoundation2', 2);
model.physics('solid').feature('spf1').selection.set([18 19 20 21 31 32 33 34]);
model.physics('solid').feature('spf1').set('SpringType', 'kTot');
model.physics('solid').feature('spf1').set('kTot', {'600[kN/mm]' '0' '0' '0' '600[kN/mm]' '0' '0' '0' '0'});
model.physics('ht').create('hf1', 'HeatFluxBoundary', 2);
model.physics('ht').feature('hf1').selection.all;
model.physics('ht').feature('hf1').selection.set([1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 18 19 20 21 22 23 24 25 26 28 29 30 31 32 33 34 35 36 37 38 39 40 41 42 43 44]);
model.physics('ht').feature('hf1').set('HeatFluxType', 'ConvectiveHeatFlux');
model.physics('ht').feature('hf1').set('h', 10);
model.physics('ht').create('hf2', 'HeatFluxBoundary', 2);
model.physics('ht').feature('hf2').selection.set([17 27]);
model.physics('ht').feature('hf2').set('q0_input', '1e4');

model.mesh('mesh1').automatic(false);
model.mesh('mesh1').feature('size').set('hauto', 3);
model.mesh('mesh1').feature('ftet1').create('size1', 'Size');
model.mesh('mesh1').feature('ftet1').feature('size1').set('custom', true);
model.mesh('mesh1').feature('ftet1').feature('size1').set('hmaxactive', true);
model.mesh('mesh1').feature('ftet1').feature('size1').set('hmax', '8[mm]');
model.mesh('mesh1').run;

model.sol.create('sol1');
model.sol('sol1').study('std1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'stat');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').set('control', 'stat');
model.sol('sol1').create('s1', 'Stationary');
model.sol('sol1').feature('s1').feature('aDef').set('cachepattern', true);
model.sol('sol1').feature('s1').create('se1', 'Segregated');
model.sol('sol1').feature('s1').feature('se1').feature.remove('ssDef');
model.sol('sol1').feature('s1').feature('se1').create('ss1', 'SegregatedStep');
model.sol('sol1').feature('s1').feature('se1').feature('ss1').set('segvar', {'comp1_T'});
model.sol('sol1').feature('s1').feature('se1').feature('ss1').set('subdamp', 1);
model.sol('sol1').feature('s1').create('d1', 'Direct');
model.sol('sol1').feature('s1').feature('d1').set('linsolver', 'pardiso');
model.sol('sol1').feature('s1').feature('d1').set('pivotperturb', 1.0E-13);
model.sol('sol1').feature('s1').feature('d1').label('Direct, heat transfer variables ht (te1)');
model.sol('sol1').feature('s1').feature('se1').feature('ss1').set('linsolver', 'd1');
model.sol('sol1').feature('s1').feature('se1').feature('ss1').label('Temperature');
model.sol('sol1').feature('s1').feature('se1').create('ss2', 'SegregatedStep');
model.sol('sol1').feature('s1').feature('se1').feature('ss2').set('segvar', {'comp1_u'});
model.sol('sol1').feature('s1').create('d2', 'Direct');
model.sol('sol1').feature('s1').feature('d2').set('linsolver', 'pardiso');
model.sol('sol1').feature('s1').feature('d2').set('pivotperturb', 1.0E-9);
model.sol('sol1').feature('s1').feature('d2').label('Suggested Direct Solver solid (te1)');
model.sol('sol1').feature('s1').feature('se1').feature('ss2').set('linsolver', 'd2');
model.sol('sol1').feature('s1').feature('se1').feature('ss2').label('Solid Mechanics');
model.sol('sol1').feature('s1').feature('se1').set('segtermonres', 'off');
model.sol('sol1').feature('s1').feature('se1').create('ll1', 'LowerLimit');
model.sol('sol1').feature('s1').feature('se1').feature('ll1').set('lowerlimit', 'comp1.T 0 ');
model.sol('sol1').feature('s1').create('i1', 'Iterative');
model.sol('sol1').feature('s1').feature('i1').set('linsolver', 'gmres');
model.sol('sol1').feature('s1').feature('i1').set('rhob', 400);
model.sol('sol1').feature('s1').feature('i1').set('nlinnormuse', true);
model.sol('sol1').feature('s1').feature('i1').label('Suggested Iterative Solver solid (te1)');
model.sol('sol1').feature('s1').feature('i1').create('mg1', 'Multigrid');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').set('prefun', 'gmg');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('pr').create('so1', 'SOR');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('pr').feature('so1').set('relax', 0.8);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('po').create('so1', 'SOR');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('po').feature('so1').set('relax', 0.8);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('cs').create('d1', 'Direct');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('cs').feature('d1').set('linsolver', 'pardiso');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('cs').feature('d1').set('pivotperturb', 1.0E-9);
model.sol('sol1').feature('s1').create('i2', 'Iterative');
model.sol('sol1').feature('s1').feature('i2').set('linsolver', 'gmres');
model.sol('sol1').feature('s1').feature('i2').set('prefuntype', 'left');
model.sol('sol1').feature('s1').feature('i2').set('itrestart', 50);
model.sol('sol1').feature('s1').feature('i2').set('rhob', 20);
model.sol('sol1').feature('s1').feature('i2').set('maxlinit', 10000);
model.sol('sol1').feature('s1').feature('i2').set('nlinnormuse', 'on');
model.sol('sol1').feature('s1').feature('i2').label('AMG, heat transfer variables ht (te1)');
model.sol('sol1').feature('s1').feature('i2').create('mg1', 'Multigrid');
model.sol('sol1').feature('s1').feature('i2').feature('mg1').set('prefun', 'saamg');
model.sol('sol1').feature('s1').feature('i2').feature('mg1').set('mgcycle', 'v');
model.sol('sol1').feature('s1').feature('i2').feature('mg1').set('maxcoarsedof', 50000);
model.sol('sol1').feature('s1').feature('i2').feature('mg1').set('strconn', 0.01);
model.sol('sol1').feature('s1').feature('i2').feature('mg1').set('nullspace', 'constant');
model.sol('sol1').feature('s1').feature('i2').feature('mg1').set('usesmooth', false);
model.sol('sol1').feature('s1').feature('i2').feature('mg1').set('saamgcompwise', true);
model.sol('sol1').feature('s1').feature('i2').feature('mg1').set('loweramg', true);
model.sol('sol1').feature('s1').feature('i2').feature('mg1').set('compactaggregation', false);
model.sol('sol1').feature('s1').feature('i2').feature('mg1').feature('pr').create('so1', 'SOR');
model.sol('sol1').feature('s1').feature('i2').feature('mg1').feature('pr').feature('so1').set('iter', 2);
model.sol('sol1').feature('s1').feature('i2').feature('mg1').feature('pr').feature('so1').set('relax', 0.9);
model.sol('sol1').feature('s1').feature('i2').feature('mg1').feature('po').create('so1', 'SOR');
model.sol('sol1').feature('s1').feature('i2').feature('mg1').feature('po').feature('so1').set('iter', 2);
model.sol('sol1').feature('s1').feature('i2').feature('mg1').feature('po').feature('so1').set('relax', 0.9);
model.sol('sol1').feature('s1').feature('i2').feature('mg1').feature('cs').create('d1', 'Direct');
model.sol('sol1').feature('s1').feature('i2').feature('mg1').feature('cs').feature('d1').set('linsolver', 'pardiso');
model.sol('sol1').feature('s1').feature('i2').feature('mg1').feature('cs').feature('d1').set('pivotperturb', 1.0E-13);
model.sol('sol1').feature('s1').feature.remove('fcDef');
model.sol('sol1').attach('std1');
model.sol('sol1').feature('s1').feature('se1').set('segterm', 'iter');
model.sol('sol1').runAll;

model.result.create('pg1', 'PlotGroup3D');
model.result('pg1').set('data', 'dset1');
model.result('pg1').set('defaultPlotID', 'stress');
model.result('pg1').label('Stress (solid)');
model.result('pg1').set('frametype', 'spatial');
model.result('pg1').create('vol1', 'Volume');
model.result('pg1').feature('vol1').set('expr', {'solid.misesGp'});
model.result('pg1').feature('vol1').set('threshold', 'manual');
model.result('pg1').feature('vol1').set('thresholdvalue', 0.2);
model.result('pg1').feature('vol1').set('colortable', 'Rainbow');
model.result('pg1').feature('vol1').set('colortabletrans', 'none');
model.result('pg1').feature('vol1').set('colorscalemode', 'linear');
model.result('pg1').feature('vol1').set('resolution', 'custom');
model.result('pg1').feature('vol1').set('refine', 2);
model.result('pg1').feature('vol1').set('colortable', 'Prism');
model.result('pg1').feature('vol1').create('def', 'Deform');
model.result('pg1').feature('vol1').feature('def').set('expr', {'u' 'v' 'w'});
model.result('pg1').feature('vol1').feature('def').set('descr', 'Displacement field');
model.result.create('pg2', 'PlotGroup3D');
model.result('pg2').label('Temperature (ht)');
model.result('pg2').set('data', 'dset1');
model.result('pg2').set('defaultPlotID', 'ht/HT_PhysicsInterfaces/icom8/pdef1/pcond3/pcond3/pg1');
model.result('pg2').feature.create('vol1', 'Volume');
model.result('pg2').feature('vol1').set('showsolutionparams', 'on');
model.result('pg2').feature('vol1').set('solutionparams', 'parent');
model.result('pg2').feature('vol1').set('expr', 'T');
model.result('pg2').feature('vol1').set('colortable', 'HeatCameraLight');
model.result('pg2').feature('vol1').set('smooth', 'internal');
model.result('pg2').feature('vol1').set('showsolutionparams', 'on');
model.result('pg2').feature('vol1').set('data', 'parent');
model.result('pg1').run;
model.result('pg1').run;
model.result('pg1').feature('vol1').set('unit', 'MPa');

model.view('view1').set('showgrid', false);

model.result('pg1').run;
model.result('pg2').run;
model.result('pg2').create('arws1', 'ArrowSurface');
model.result('pg2').feature('arws1').set('expr', {'0' '0' '1'});
model.result('pg2').feature('arws1').set('arrowbase', 'head');
model.result('pg2').feature('arws1').create('sel1', 'Selection');
model.result('pg2').feature('arws1').feature('sel1').selection.set([17 27]);
model.result('pg2').run;
model.result('pg2').feature('arws1').set('arrowcount', 100);
model.result('pg2').feature('arws1').set('scaleactive', true);
model.result('pg2').feature('arws1').set('scale', 0.02);
model.result('pg2').run;
model.result('pg2').feature('vol1').set('unit', 'degC');
model.result('pg2').feature('vol1').create('tran1', 'Transparency');
model.result('pg2').run;
model.result('pg2').feature('vol1').feature('tran1').set('transparency', 0.4);
model.result('pg2').feature('vol1').feature('tran1').set('uniformblending', 0.4);
model.result('pg2').run;

model.title(['Bracket ' native2unicode(hex2dec({'20' '14'}), 'unicode') ' Thermal-Stress Analysis']);

model.description('This example demonstrates how to use the Thermal Stress interface.');

model.mesh.clearMeshes;

model.sol('sol1').clearSolutionData;

model.label('bracket_thermal.mph');

model.modelNode.label('Components');

out = model;
```

---

## Example 10: flat_plate_nitf_turbulent

**Module:** Heat_Transfer_Module_Verification_Examples_flat_plate_nitf_turbulent  
**Category:** Unknown_Category  

### Model Description

**Model Overview**:
The model simulates nonisothermal turbulent flow over a flat plate, focusing on the heat transfer aspects. It aims to compare the heat transfer coefficient obtained from the simulation with correlations from literature, specifically Nusselt number-based correlations for turbulent flow.

**Geometry**:
The geometry consists of a rectangular domain representing the flat plate and the surrounding fluid. The plate length (L) is 5 meters, and the height (b) of the domain is 0.5 meters. The plate is positioned at the bottom of the domain, with the fluid flow directed from left to right.

**Materials**:
The material used in the simulation is air, with properties defined by piecewise functions for dynamic viscosity, heat capacity, thermal conductivity, and other properties. The material properties are temperature-dependent, and the model accounts for the compressibility of air.

**Physics**:
The model includes two main physics interfaces:
1. Turbulent Flow: The 'TurbulentFlowSST' interface models the fluid flow using the SST (Shear Stress Transport) turbulence model.
2. Heat Transfer in Fluids: The 'HeatTransferInFluids' interface models the heat transfer in the fluid domain, considering convection and conduction.

The NonIsothermal Flow multiphysics interface couples the fluid flow and heat transfer physics.

**Boundary Conditions**:
- Inlet: A fully developed flow boundary condition is applied at the inlet, with a specified inlet velocity (U0 = 0.5 m/s) and temperature (T0 = 283 K).
- Outlet: A convective outflow boundary condition is applied at the outlet.
- Plate: A wall heat flux boundary condition is applied at the plate surface, with a specified heat flux (qw = 10 W/m^2).
- Top and side walls: Symmetry boundary conditions are applied on the top and side walls of the domain.

**Mesh**:
The geometry is discretized using a mapped mesh with a user-defined distribution of elements. The number of elements in the horizontal direction is controlled by the parameter 'mesh_coeff'. The mesh is refined near the plate surface to resolve the boundary layers accurately.

**Study**:
The model performs a stationary (steady-state) analysis using a parametric study to investigate the effect of different mesh resolutions. The study includes a wall distance initialization step followed by the main stationary solver.

**Key Parameters**:
- Plate length (L): 5 m
- Height (b): 0.5 m
- Inlet temperature (T0): 283 K
- Inlet velocity (U0): 0.5 m/s
- Wall heat flux (qw): 10 W/m^2
- Mesh coefficient (mesh_coeff): 0.1, 0.25, 0.5, 0.75 (parametric study)

**Expected Results**:
The model predicts the velocity and temperature fields in the fluid domain, as well as the heat transfer coefficient along the plate surface. The heat transfer coefficient obtained from the simulation is compared with correlations from Bejan and Lienhard for turbulent flow over a flat plate.

**Engineering Application**:
This model can be used to study and optimize heat transfer in turbulent flow situations, such as in heat exchangers, cooling systems, and aerodynamic applications. It provides insights into the relationship between fluid flow and heat transfer, helping engineers design efficient thermal systems and understand the underlying physical phenomena.

### COMSOL MATLAB Code

```matlab
function out = model
%
% flat_plate_nitf_turbulent.m
%
% Model exported on May 26 2025, 21:29 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/Heat_Transfer_Module/Verification_Examples');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 2);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.physics.create('spf', 'TurbulentFlowSST', 'geom1');
model.physics('spf').model('comp1');
model.physics('spf').prop('AdvancedSettingProperty').set('UsePseudoTime', '1');
model.physics('spf').prop('PhysicalModelProperty').set('Compressibility', 'WeaklyCompressible');
model.physics.create('ht', 'HeatTransferInFluids', 'geom1');
model.physics('ht').model('comp1');
model.physics('ht').prop('PhysicalModelProperty').set('dz', '1[m]');
model.physics('ht').prop('ShapeProperty').set('order_temperature', '1');

model.multiphysics.create('nitf1', 'NonIsothermalFlow', 'geom1', 2);
model.multiphysics('nitf1').set('Fluid_physics', 'spf');
model.multiphysics('nitf1').set('Heat_physics', 'ht');

model.study.create('std1');
model.study('std1').create('wdi', 'WallDistanceInitialization');
model.study('std1').feature('wdi').set('solnum', 'auto');
model.study('std1').feature('wdi').set('notsolnum', 'auto');
model.study('std1').feature('wdi').set('outputmap', {});
model.study('std1').feature('wdi').set('ngenAUX', '1');
model.study('std1').feature('wdi').set('goalngenAUX', '1');
model.study('std1').feature('wdi').set('ngenAUX', '1');
model.study('std1').feature('wdi').set('goalngenAUX', '1');
model.study('std1').feature('wdi').setSolveFor('/physics/spf', true);
model.study('std1').feature('wdi').setSolveFor('/physics/ht', true);
model.study('std1').feature('wdi').setSolveFor('/multiphysics/nitf1', true);
model.study('std1').feature('wdi').setSolveFor('/physics/ht', false);
model.study('std1').feature('wdi').setSolveFor('/multiphysics/nitf1', false);
model.study('std1').create('stat', 'Stationary');
model.study('std1').feature('stat').set('solnum', 'auto');
model.study('std1').feature('stat').set('notsolnum', 'auto');
model.study('std1').feature('stat').set('outputmap', {});
model.study('std1').feature('stat').set('ngenAUX', '1');
model.study('std1').feature('stat').set('goalngenAUX', '1');
model.study('std1').feature('stat').set('ngenAUX', '1');
model.study('std1').feature('stat').set('goalngenAUX', '1');
model.study('std1').feature('stat').setSolveFor('/physics/spf', true);
model.study('std1').feature('stat').setSolveFor('/physics/ht', true);
model.study('std1').feature('stat').setSolveFor('/multiphysics/nitf1', true);

model.param.set('L', '5[m]');
model.param.descr('L', 'Plate length');
model.param.set('b', '0.5[m]');
model.param.descr('b', 'Height');
model.param.set('T0', '283[K]');
model.param.descr('T0', 'Inlet temperature');
model.param.set('U0', '0.5[m/s]');
model.param.descr('U0', 'Inlet velocity');
model.param.set('qw', '10[W/m^2]');
model.param.descr('qw', 'Wall heat flux');
model.param.set('mesh_coeff', '0.1');
model.param.descr('mesh_coeff', 'Mesh coefficient for parametric study');

model.geom('geom1').create('r1', 'Rectangle');
model.geom('geom1').feature('r1').set('size', {'L*2' 'b'});
model.geom('geom1').feature('r1').setIndex('layername', 'Layer 1', 0);
model.geom('geom1').feature('r1').setIndex('layer', 'L', 0);
model.geom('geom1').feature('r1').set('layerbottom', false);
model.geom('geom1').feature('r1').set('layerleft', true);
model.geom('geom1').runPre('fin');
model.geom('geom1').run;

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

model.variable.create('var1');
model.variable('var1').model('comp1');
model.variable('var1').set('Tb', 'integrate(comp1.at2(x,y,u*T),y,0,b)/integrate(comp1.at2(x,y,u),y,0,b)');
model.variable('var1').descr('Tb', 'Bulk temperature');
model.variable('var1').set('x_plate', 'x-L');
model.variable('var1').descr('x_plate', 'Position along the plate');
model.variable('var1').set('T_film', '0.5*(T+T0)');
model.variable('var1').descr('T_film', 'Film temperature');
model.variable('var1').set('rho_film', 'mat1.def.rho(ht.pA,T_film)');
model.variable('var1').descr('rho_film', 'Film density');
model.variable('var1').set('k_film', 'mat1.def.k(T_film)');
model.variable('var1').descr('k_film', 'Film thermal conductivity');
model.variable('var1').set('Cp_film', 'mat1.def.Cp(T_film)');
model.variable('var1').descr('Cp_film', 'Film heat capacity');
model.variable('var1').set('mu_film', 'mat1.def.eta(T_film)');
model.variable('var1').descr('mu_film', 'Film viscosity');
model.variable('var1').set('Pr_film', 'Cp_film*mu_film/k_film');
model.variable('var1').descr('Pr_film', 'Prandtl number based on film properties');
model.variable('var1').set('Re_film', 'rho_film*U0*x_plate/mu_film');
model.variable('var1').descr('Re_film', 'Reynolds number based on film properties');
model.variable('var1').set('Nu_x_turb_Bejan', '0.0296*Re_film^0.8*Pr_film^(1/3)');
model.variable('var1').descr('Nu_x_turb_Bejan', 'Nusselt number (Bejan, 5.131'')');
model.variable('var1').set('Nu_x_turb_Lienhard', '0.032*Re_film^0.8*Pr_film^0.43');
model.variable('var1').descr('Nu_x_turb_Lienhard', 'Nusselt number (Lienhard, 6.115)');

model.physics('spf').prop('PhysicalModelProperty').set('Compressibility', 'CompressibleMALT03');
model.physics('spf').feature('init1').set('u_init', {'U0' '0' '0'});
model.physics('spf').create('inl1', 'InletBoundary', 1);
model.physics('spf').feature('inl1').selection.set([1]);
model.physics('spf').feature('inl1').set('BoundaryCondition', 'FullyDevelopedFlow');
model.physics('spf').feature('inl1').set('Uavfdf', 'U0');
model.physics('spf').create('out1', 'OutletBoundary', 1);
model.physics('spf').feature('out1').selection.set([7]);
model.physics('spf').create('sym1', 'Symmetry', 1);
model.physics('spf').feature('sym1').selection.set([3 6]);
model.physics('ht').create('ifl1', 'Inflow', 1);
model.physics('ht').feature('ifl1').selection.set([1]);
model.physics('ht').feature('ifl1').set('Tustr', 'T0');
model.physics('ht').create('ofl1', 'ConvectiveOutflow', 1);
model.physics('ht').feature('ofl1').selection.set([7]);
model.physics('ht').create('sym1', 'Symmetry', 1);
model.physics('ht').feature('sym1').selection.set([3 6]);
model.physics('ht').create('hf1', 'HeatFluxBoundary', 1);
model.physics('ht').feature('hf1').set('q0_input', 'qw');
model.physics('ht').feature('hf1').selection.set([5]);

model.mesh('mesh1').automatic(false);
model.mesh('mesh1').feature.remove('size1');
model.mesh('mesh1').feature.remove('cr1');
model.mesh('mesh1').feature.remove('ftri1');
model.mesh('mesh1').feature.remove('bl1');
model.mesh('mesh1').create('map1', 'Map');
model.mesh('mesh1').feature('map1').create('dis1', 'Distribution');
model.mesh('mesh1').feature('map1').feature('dis1').label('Distribution (horizontal)');
model.mesh('mesh1').feature('map1').feature('dis1').selection.set([2 3 5 6]);
model.mesh('mesh1').feature('map1').feature('dis1').set('numelem', 'L*100*mesh_coeff');
model.mesh('mesh1').feature('map1').feature.duplicate('dis2', 'dis1');
model.mesh('mesh1').feature('map1').feature('dis2').label('Distribution (vertical)');
model.mesh('mesh1').feature('map1').feature('dis2').selection.set([1 4 7]);
model.mesh('mesh1').feature('map1').feature('dis2').set('type', 'predefined');
model.mesh('mesh1').feature('map1').feature('dis2').set('elemcount', '100*mesh_coeff');
model.mesh('mesh1').feature('map1').feature('dis2').set('elemratio', 8);
model.mesh('mesh1').run;

model.study('std1').create('param', 'Parametric');
model.study('std1').feature('param').setIndex('pname', 'L', 0);
model.study('std1').feature('param').setIndex('plistarr', '', 0);
model.study('std1').feature('param').setIndex('punit', 'm', 0);
model.study('std1').feature('param').setIndex('pname', 'L', 0);
model.study('std1').feature('param').setIndex('plistarr', '', 0);
model.study('std1').feature('param').setIndex('punit', 'm', 0);
model.study('std1').feature('param').setIndex('pname', 'mesh_coeff', 0);
model.study('std1').feature('param').setIndex('plistarr', '0.1 0.25 0.5 0.75', 0);

model.sol.create('sol1');

model.mesh('mesh1').stat.selection.geom(2);
model.mesh('mesh1').stat.selection.set([1 2]);
model.mesh('mesh1').stat.selection.geom(2);
model.mesh('mesh1').stat.selection.set([1 2]);
model.mesh('mesh1').stat.selection.geom(2);
model.mesh('mesh1').stat.selection.set([1 2]);

model.sol('sol1').study('std1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'wdi');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').set('control', 'wdi');
model.sol('sol1').create('s1', 'Stationary');
model.sol('sol1').feature('s1').set('stol', 1.0E-6);
model.sol('sol1').feature('s1').feature('aDef').set('cachepattern', true);
model.sol('sol1').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('s1').feature('fc1').set('dtech', 'auto');
model.sol('sol1').feature('s1').feature('fc1').set('initstep', 0.01);
model.sol('sol1').feature('s1').feature('fc1').set('minstep', 1.0E-6);
model.sol('sol1').feature('s1').feature('fc1').set('maxiter', 50);
model.sol('sol1').feature('s1').create('d1', 'Direct');
model.sol('sol1').feature('s1').feature('d1').set('linsolver', 'pardiso');
model.sol('sol1').feature('s1').feature('d1').set('pivotperturb', 1.0E-13);
model.sol('sol1').feature('s1').feature('d1').label('Direct, wall distance (spf)');
model.sol('sol1').feature('s1').create('i1', 'Iterative');
model.sol('sol1').feature('s1').feature('i1').set('linsolver', 'gmres');
model.sol('sol1').feature('s1').feature('i1').set('prefuntype', 'left');
model.sol('sol1').feature('s1').feature('i1').set('itrestart', 50);
model.sol('sol1').feature('s1').feature('i1').set('rhob', 400);
model.sol('sol1').feature('s1').feature('i1').set('maxlinit', 1000);
model.sol('sol1').feature('s1').feature('i1').set('nlinnormuse', 'on');
model.sol('sol1').feature('s1').feature('i1').label('AMG, wall distance (spf)');
model.sol('sol1').feature('s1').feature('i1').create('mg1', 'Multigrid');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').set('prefun', 'saamg');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').set('mgcycle', 'v');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').set('maxcoarsedof', 50000);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').set('strconn', 0.01);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').set('nullspace', 'constant');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').set('usesmooth', false);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').set('saamgcompwise', true);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').set('loweramg', true);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').set('compactaggregation', false);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('pr').create('sl1', 'SORLine');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('pr').feature('sl1').set('linesweeptype', 'ssor');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('pr').feature('sl1').set('iter', 1);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('pr').feature('sl1').set('linerelax', 0.7);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('pr').feature('sl1').set('linealgorithm', 'mesh');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('pr').feature('sl1').set('linemethod', 'uncoupled');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('pr').feature('sl1').set('seconditer', 1);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('pr').feature('sl1').set('relax', 0.5);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('po').create('sl1', 'SORLine');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('po').feature('sl1').set('linesweeptype', 'ssor');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('po').feature('sl1').set('iter', 1);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('po').feature('sl1').set('linerelax', 0.7);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('po').feature('sl1').set('linealgorithm', 'mesh');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('po').feature('sl1').set('linemethod', 'uncoupled');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('po').feature('sl1').set('seconditer', 1);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('po').feature('sl1').set('relax', 0.5);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('cs').create('d1', 'Direct');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('cs').feature('d1').set('linsolver', 'pardiso');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('cs').feature('d1').set('pivotperturb', 1.0E-13);
model.sol('sol1').feature('s1').feature('fc1').set('linsolver', 'd1');
model.sol('sol1').feature('s1').feature('fc1').set('dtech', 'auto');
model.sol('sol1').feature('s1').feature('fc1').set('initstep', 0.01);
model.sol('sol1').feature('s1').feature('fc1').set('minstep', 1.0E-6);
model.sol('sol1').feature('s1').feature('fc1').set('maxiter', 50);
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
model.sol('sol1').feature('s2').feature('aDef').set('cachepattern', true);
model.sol('sol1').feature('s2').create('seDef', 'Segregated');
model.sol('sol1').feature('s2').create('se1', 'Segregated');
model.sol('sol1').feature('s2').feature('se1').feature.remove('ssDef');
model.sol('sol1').feature('s2').feature('se1').create('ss1', 'SegregatedStep');
model.sol('sol1').feature('s2').feature('se1').feature('ss1').set('segvar', {'comp1_p' 'comp1_u' 'comp1_spf_inl1_Pinlfdf'});
model.sol('sol1').feature('s2').feature('se1').feature('ss1').set('subdamp', 0.5);
model.sol('sol1').feature('s2').create('d1', 'Direct');
model.sol('sol1').feature('s2').feature('d1').set('linsolver', 'pardiso');
model.sol('sol1').feature('s2').feature('d1').set('pivotperturb', 1.0E-13);
model.sol('sol1').feature('s2').feature('d1').label('Direct, fluid flow variables (spf)');
model.sol('sol1').feature('s2').feature('se1').feature('ss1').set('linsolver', 'd1');
model.sol('sol1').feature('s2').feature('se1').feature('ss1').label('Velocity u, Pressure p');
model.sol('sol1').feature('s2').feature('se1').create('ss2', 'SegregatedStep');
model.sol('sol1').feature('s2').feature('se1').feature('ss2').set('segvar', {'comp1_T' 'comp1_nitf1_TWall_d' 'comp1_nitf1_TWall_u'});
model.sol('sol1').feature('s2').feature('se1').feature('ss2').set('subdamp', 0.5);
model.sol('sol1').feature('s2').create('d2', 'Direct');
model.sol('sol1').feature('s2').feature('d2').set('linsolver', 'pardiso');
model.sol('sol1').feature('s2').feature('d2').set('pivotperturb', 1.0E-13);
model.sol('sol1').feature('s2').feature('d2').label('Direct, heat transfer variables (ht)');
model.sol('sol1').feature('s2').feature('se1').feature('ss2').set('linsolver', 'd2');
model.sol('sol1').feature('s2').feature('se1').feature('ss2').label('Temperature');
model.sol('sol1').feature('s2').feature('se1').create('ss3', 'SegregatedStep');
model.sol('sol1').feature('s2').feature('se1').feature('ss3').set('segvar', {'comp1_k' 'comp1_om'});
model.sol('sol1').feature('s2').feature('se1').feature('ss3').set('subdamp', 0.45);
model.sol('sol1').feature('s2').feature('se1').feature('ss3').set('subiter', 3);
model.sol('sol1').feature('s2').feature('se1').feature('ss3').set('subtermconst', 'itertol');
model.sol('sol1').feature('s2').feature('se1').feature('ss3').set('subntolfact', 1);
model.sol('sol1').feature('s2').create('d3', 'Direct');
model.sol('sol1').feature('s2').feature('d3').set('linsolver', 'pardiso');
model.sol('sol1').feature('s2').feature('d3').set('pivotperturb', 1.0E-13);
model.sol('sol1').feature('s2').feature('d3').label('Direct, turbulence variables (spf)');
model.sol('sol1').feature('s2').feature('se1').feature('ss3').set('linsolver', 'd3');
model.sol('sol1').feature('s2').feature('se1').feature('ss3').label('Turbulence Variables');
model.sol('sol1').feature('s2').feature('se1').set('segstabacc', 'segcflcmp');
model.sol('sol1').feature('s2').feature('se1').set('subinitcfl', 2);
model.sol('sol1').feature('s2').feature('se1').set('submincfl', 10000);
model.sol('sol1').feature('s2').feature('se1').set('subkppid', 0.65);
model.sol('sol1').feature('s2').feature('se1').set('subkdpid', 0.05);
model.sol('sol1').feature('s2').feature('se1').set('subkipid', 0.05);
model.sol('sol1').feature('s2').feature('se1').set('subcfltol', 0.1);
model.sol('sol1').feature('s2').feature('se1').set('segcflaa', true);
model.sol('sol1').feature('s2').feature('se1').set('segcflaacfl', 9000);
model.sol('sol1').feature('s2').feature('se1').set('segcflaafact', 1);
model.sol('sol1').feature('s2').feature('se1').set('maxsegiter', 300);
model.sol('sol1').feature('s2').feature('se1').create('ll1', 'LowerLimit');
model.sol('sol1').feature('s2').feature('se1').feature('ll1').set('lowerlimit', 'comp1.om 0 comp1.k 0 comp1.T 0 ');
model.sol('sol1').feature('s2').create('i1', 'Iterative');
model.sol('sol1').feature('s2').feature('i1').set('linsolver', 'gmres');
model.sol('sol1').feature('s2').feature('i1').set('prefuntype', 'left');
model.sol('sol1').feature('s2').feature('i1').set('itrestart', 50);
model.sol('sol1').feature('s2').feature('i1').set('rhob', 20);
model.sol('sol1').feature('s2').feature('i1').set('maxlinit', 1000);
model.sol('sol1').feature('s2').feature('i1').set('nlinnormuse', 'on');
model.sol('sol1').feature('s2').feature('i1').label('AMG, fluid flow variables (spf)');
model.sol('sol1').feature('s2').feature('i1').create('mg1', 'Multigrid');
model.sol('sol1').feature('s2').feature('i1').feature('mg1').set('prefun', 'saamg');
model.sol('sol1').feature('s2').feature('i1').feature('mg1').set('mgcycle', 'v');
model.sol('sol1').feature('s2').feature('i1').feature('mg1').set('maxcoarsedof', 80000);
model.sol('sol1').feature('s2').feature('i1').feature('mg1').set('strconn', 0.02);
model.sol('sol1').feature('s2').feature('i1').feature('mg1').set('nullspace', 'constant');
model.sol('sol1').feature('s2').feature('i1').feature('mg1').set('usesmooth', false);
model.sol('sol1').feature('s2').feature('i1').feature('mg1').set('saamgcompwise', true);
model.sol('sol1').feature('s2').feature('i1').feature('mg1').set('loweramg', true);
model.sol('sol1').feature('s2').feature('i1').feature('mg1').set('compactaggregation', false);
model.sol('sol1').feature('s2').feature('i1').feature('mg1').feature('pr').create('sc1', 'SCGS');
model.sol('sol1').feature('s2').feature('i1').feature('mg1').feature('pr').feature('sc1').set('linesweeptype', 'ssor');
model.sol('sol1').feature('s2').feature('i1').feature('mg1').feature('pr').feature('sc1').set('iter', 0);
model.sol('sol1').feature('s2').feature('i1').feature('mg1').feature('pr').feature('sc1').set('scgsrelax', 0.7);
model.sol('sol1').feature('s2').feature('i1').feature('mg1').feature('pr').feature('sc1').set('scgsmethod', 'lines');
model.sol('sol1').feature('s2').feature('i1').feature('mg1').feature('pr').feature('sc1').set('scgsvertexrelax', 0.7);
model.sol('sol1').feature('s2').feature('i1').feature('mg1').feature('pr').feature('sc1').set('relax', 0.5);
model.sol('sol1').feature('s2').feature('i1').feature('mg1').feature('pr').feature('sc1').set('vankavarsactive', 'on');
model.sol('sol1').feature('s2').feature('i1').feature('mg1').feature('pr').feature('sc1').set('vankavars', {'comp1_spf_inl1_Pinlfdf'});
model.sol('sol1').feature('s2').feature('i1').feature('mg1').feature('pr').feature('sc1').set('scgssolv', 'stored');
model.sol('sol1').feature('s2').feature('i1').feature('mg1').feature('pr').feature('sc1').set('approxscgs', true);
model.sol('sol1').feature('s2').feature('i1').feature('mg1').feature('pr').feature('sc1').set('scgsdirectmaxsize', 1000);
model.sol('sol1').feature('s2').feature('i1').feature('mg1').feature('po').create('sc1', 'SCGS');
model.sol('sol1').feature('s2').feature('i1').feature('mg1').feature('po').feature('sc1').set('linesweeptype', 'ssor');
model.sol('sol1').feature('s2').feature('i1').feature('mg1').feature('po').feature('sc1').set('iter', 1);
model.sol('sol1').feature('s2').feature('i1').feature('mg1').feature('po').feature('sc1').set('scgsrelax', 0.7);
model.sol('sol1').feature('s2').feature('i1').feature('mg1').feature('po').feature('sc1').set('scgsmethod', 'lines');
model.sol('sol1').feature('s2').feature('i1').feature('mg1').feature('po').feature('sc1').set('scgsvertexrelax', 0.7);
model.sol('sol1').feature('s2').feature('i1').feature('mg1').feature('po').feature('sc1').set('relax', 0.5);
model.sol('sol1').feature('s2').feature('i1').feature('mg1').feature('po').feature('sc1').set('vankavarsactive', 'on');
model.sol('sol1').feature('s2').feature('i1').feature('mg1').feature('po').feature('sc1').set('vankavars', {'comp1_spf_inl1_Pinlfdf'});
model.sol('sol1').feature('s2').feature('i1').feature('mg1').feature('po').feature('sc1').set('scgssolv', 'stored');
model.sol('sol1').feature('s2').feature('i1').feature('mg1').feature('po').feature('sc1').set('approxscgs', true);
model.sol('sol1').feature('s2').feature('i1').feature('mg1').feature('po').feature('sc1').set('scgsdirectmaxsize', 1000);
model.sol('sol1').feature('s2').feature('i1').feature('mg1').feature('cs').create('d1', 'Direct');
model.sol('sol1').feature('s2').feature('i1').feature('mg1').feature('cs').feature('d1').set('linsolver', 'pardiso');
model.sol('sol1').feature('s2').feature('i1').feature('mg1').feature('cs').feature('d1').set('pivotperturb', 1.0E-13);
model.sol('sol1').feature('s2').create('i2', 'Iterative');
model.sol('sol1').feature('s2').feature('i2').set('linsolver', 'gmres');
model.sol('sol1').feature('s2').feature('i2').set('prefuntype', 'left');
model.sol('sol1').feature('s2').feature('i2').set('itrestart', 50);
model.sol('sol1').feature('s2').feature('i2').set('rhob', 20);
model.sol('sol1').feature('s2').feature('i2').set('maxlinit', 10000);
model.sol('sol1').feature('s2').feature('i2').set('nlinnormuse', 'on');
model.sol('sol1').feature('s2').feature('i2').label('AMG, heat transfer variables (ht)');
model.sol('sol1').feature('s2').feature('i2').create('mg1', 'Multigrid');
model.sol('sol1').feature('s2').feature('i2').feature('mg1').set('prefun', 'saamg');
model.sol('sol1').feature('s2').feature('i2').feature('mg1').set('mgcycle', 'v');
model.sol('sol1').feature('s2').feature('i2').feature('mg1').set('maxcoarsedof', 50000);
model.sol('sol1').feature('s2').feature('i2').feature('mg1').set('strconn', 0.01);
model.sol('sol1').feature('s2').feature('i2').feature('mg1').set('nullspace', 'constant');
model.sol('sol1').feature('s2').feature('i2').feature('mg1').set('usesmooth', false);
model.sol('sol1').feature('s2').feature('i2').feature('mg1').set('saamgcompwise', true);
model.sol('sol1').feature('s2').feature('i2').feature('mg1').set('loweramg', true);
model.sol('sol1').feature('s2').feature('i2').feature('mg1').set('compactaggregation', false);
model.sol('sol1').feature('s2').feature('i2').feature('mg1').feature('pr').create('so1', 'SOR');
model.sol('sol1').feature('s2').feature('i2').feature('mg1').feature('pr').feature('so1').set('iter', 2);
model.sol('sol1').feature('s2').feature('i2').feature('mg1').feature('pr').feature('so1').set('relax', 0.9);
model.sol('sol1').feature('s2').feature('i2').feature('mg1').feature('po').create('so1', 'SOR');
model.sol('sol1').feature('s2').feature('i2').feature('mg1').feature('po').feature('so1').set('iter', 2);
model.sol('sol1').feature('s2').feature('i2').feature('mg1').feature('po').feature('so1').set('relax', 0.9);
model.sol('sol1').feature('s2').feature('i2').feature('mg1').feature('cs').create('d1', 'Direct');
model.sol('sol1').feature('s2').feature('i2').feature('mg1').feature('cs').feature('d1').set('linsolver', 'pardiso');
model.sol('sol1').feature('s2').feature('i2').feature('mg1').feature('cs').feature('d1').set('pivotperturb', 1.0E-13);
model.sol('sol1').feature('s2').create('i3', 'Iterative');
model.sol('sol1').feature('s2').feature('i3').set('linsolver', 'gmres');
model.sol('sol1').feature('s2').feature('i3').set('prefuntype', 'left');
model.sol('sol1').feature('s2').feature('i3').set('itrestart', 50);
model.sol('sol1').feature('s2').feature('i3').set('rhob', 20);
model.sol('sol1').feature('s2').feature('i3').set('maxlinit', 1000);
model.sol('sol1').feature('s2').feature('i3').set('nlinnormuse', 'on');
model.sol('sol1').feature('s2').feature('i3').label('AMG, turbulence variables (spf)');
model.sol('sol1').feature('s2').feature('i3').create('mg1', 'Multigrid');
model.sol('sol1').feature('s2').feature('i3').feature('mg1').set('prefun', 'saamg');
model.sol('sol1').feature('s2').feature('i3').feature('mg1').set('mgcycle', 'v');
model.sol('sol1').feature('s2').feature('i3').feature('mg1').set('maxcoarsedof', 50000);
model.sol('sol1').feature('s2').feature('i3').feature('mg1').set('strconn', 0.01);
model.sol('sol1').feature('s2').feature('i3').feature('mg1').set('nullspace', 'constant');
model.sol('sol1').feature('s2').feature('i3').feature('mg1').set('usesmooth', false);
model.sol('sol1').feature('s2').feature('i3').feature('mg1').set('saamgcompwise', true);
model.sol('sol1').feature('s2').feature('i3').feature('mg1').set('loweramg', true);
model.sol('sol1').feature('s2').feature('i3').feature('mg1').set('compactaggregation', false);
model.sol('sol1').feature('s2').feature('i3').feature('mg1').feature('pr').create('sl1', 'SORLine');
model.sol('sol1').feature('s2').feature('i3').feature('mg1').feature('pr').feature('sl1').set('linesweeptype', 'ssor');
model.sol('sol1').feature('s2').feature('i3').feature('mg1').feature('pr').feature('sl1').set('iter', 0);
model.sol('sol1').feature('s2').feature('i3').feature('mg1').feature('pr').feature('sl1').set('linerelax', 0.7);
model.sol('sol1').feature('s2').feature('i3').feature('mg1').feature('pr').feature('sl1').set('linealgorithm', 'mesh');
model.sol('sol1').feature('s2').feature('i3').feature('mg1').feature('pr').feature('sl1').set('linemethod', 'uncoupled');
model.sol('sol1').feature('s2').feature('i3').feature('mg1').feature('pr').feature('sl1').set('seconditer', 1);
model.sol('sol1').feature('s2').feature('i3').feature('mg1').feature('pr').feature('sl1').set('relax', 0.5);
model.sol('sol1').feature('s2').feature('i3').feature('mg1').feature('po').create('sl1', 'SORLine');
model.sol('sol1').feature('s2').feature('i3').feature('mg1').feature('po').feature('sl1').set('linesweeptype', 'ssor');
model.sol('sol1').feature('s2').feature('i3').feature('mg1').feature('po').feature('sl1').set('iter', 1);
model.sol('sol1').feature('s2').feature('i3').feature('mg1').feature('po').feature('sl1').set('linerelax', 0.7);
model.sol('sol1').feature('s2').feature('i3').feature('mg1').feature('po').feature('sl1').set('linealgorithm', 'mesh');
model.sol('sol1').feature('s2').feature('i3').feature('mg1').feature('po').feature('sl1').set('linemethod', 'uncoupled');
model.sol('sol1').feature('s2').feature('i3').feature('mg1').feature('po').feature('sl1').set('seconditer', 1);
model.sol('sol1').feature('s2').feature('i3').feature('mg1').feature('po').feature('sl1').set('relax', 0.5);
model.sol('sol1').feature('s2').feature('i3').feature('mg1').feature('cs').create('d1', 'Direct');
model.sol('sol1').feature('s2').feature('i3').feature('mg1').feature('cs').feature('d1').set('linsolver', 'pardiso');
model.sol('sol1').feature('s2').feature('i3').feature('mg1').feature('cs').feature('d1').set('pivotperturb', 1.0E-13);
model.sol('sol1').feature('s2').feature.remove('fcDef');
model.sol('sol1').feature('s2').feature.remove('seDef');
model.sol('sol1').feature('v2').set('notsolnum', 'auto');
model.sol('sol1').feature('v2').set('notsolvertype', 'solnum');
model.sol('sol1').feature('v2').set('solnum', 'auto');
model.sol('sol1').feature('v2').set('solvertype', 'solnum');
model.sol('sol1').attach('std1');

model.batch.create('p1', 'Parametric');
model.batch('p1').study('std1');
model.batch('p1').create('so1', 'Solutionseq');
model.batch('p1').feature('so1').set('seq', 'sol1');
model.batch('p1').feature('so1').set('store', 'on');
model.batch('p1').feature('so1').set('clear', 'on');
model.batch('p1').feature('so1').set('psol', 'none');
model.batch('p1').set('pname', {'mesh_coeff'});
model.batch('p1').set('plistarr', {'0.1 0.25 0.5 0.75'});
model.batch('p1').set('sweeptype', 'sparse');
model.batch('p1').set('probesel', 'all');
model.batch('p1').set('probes', {});
model.batch('p1').set('plot', 'off');
model.batch('p1').set('err', 'on');
model.batch('p1').attach('std1');
model.batch('p1').set('control', 'param');

model.sol.create('sol3');
model.sol('sol3').study('std1');
model.sol('sol3').label('Parametric Solutions 1');

model.batch('p1').feature('so1').set('psol', 'sol3');
model.batch('p1').run('compute');

model.result.dataset('dset3').set('geom', 'geom1');
model.result.create('pg1', 'PlotGroup2D');
model.result('pg1').label('Velocity (spf)');
model.result('pg1').set('data', 'dset3');
model.result('pg1').setIndex('looplevel', 4, 0);
model.result('pg1').set('frametype', 'spatial');
model.result('pg1').set('data', 'dset3');
model.result('pg1').setIndex('looplevel', 4, 0);
model.result('pg1').set('defaultPlotID', 'ResultDefaults_SinglePhaseFlow/icom1/pdef1/pcond1/pg1');
model.result('pg1').feature.create('surf1', 'Surface');
model.result('pg1').feature('surf1').label('Surface');
model.result('pg1').feature('surf1').set('showsolutionparams', 'on');
model.result('pg1').feature('surf1').set('smooth', 'internal');
model.result('pg1').feature('surf1').set('showsolutionparams', 'on');
model.result('pg1').feature('surf1').set('data', 'parent');
model.result.create('pg2', 'PlotGroup2D');
model.result('pg2').label('Pressure (spf)');
model.result('pg2').set('data', 'dset3');
model.result('pg2').setIndex('looplevel', 4, 0);
model.result('pg2').set('frametype', 'spatial');
model.result('pg2').set('data', 'dset3');
model.result('pg2').setIndex('looplevel', 4, 0);
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
model.result.dataset.create('edg1', 'Edge2D');
model.result.dataset('edg1').label('Exterior Walls');
model.result.dataset('edg1').set('data', 'dset3');
model.result.dataset('edg1').selection.geom('geom1', 1);
model.result.dataset('edg1').selection.set([2 5]);
model.result.create('pg3', 'PlotGroup2D');
model.result('pg3').label('Wall Resolution (spf)');
model.result('pg3').set('data', 'dset3');
model.result('pg3').setIndex('looplevel', 4, 0);
model.result('pg3').set('frametype', 'spatial');
model.result('pg3').set('data', 'dset3');
model.result('pg3').setIndex('looplevel', 4, 0);
model.result('pg3').set('defaultPlotID', 'ResultDefaults_SinglePhaseFlow/icom1/pdef1/pcond1/pcond2/pcond4/pg2');
model.result('pg3').feature.create('line1', 'Line');
model.result('pg3').feature('line1').label('Wall Resolution');
model.result('pg3').feature('line1').set('showsolutionparams', 'on');
model.result('pg3').feature('line1').set('expr', 'spf.Delta_wPlus');
model.result('pg3').feature('line1').set('linetype', 'tube');
model.result('pg3').feature('line1').set('smooth', 'internal');
model.result('pg3').feature('line1').set('showsolutionparams', 'on');
model.result('pg3').feature('line1').set('data', 'parent');
model.result('pg3').feature('line1').feature.create('hght1', 'Height');
model.result('pg3').feature('line1').feature('hght1').label('Height Expression');
model.result('pg3').feature('line1').feature('hght1').set('heightdata', 'expr');
model.result('pg3').feature('line1').feature('hght1').set('expr', 'spf.WRHeightExpr');
model.result.create('pg4', 'PlotGroup2D');
model.result('pg4').label('Temperature (ht)');
model.result('pg4').set('data', 'dset3');
model.result('pg4').setIndex('looplevel', 4, 0);
model.result('pg4').set('data', 'dset3');
model.result('pg4').setIndex('looplevel', 4, 0);
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
model.result('pg5').set('data', 'dset3');
model.result('pg5').setIndex('looplevel', 4, 0);
model.result('pg5').set('showlegendsunit', true);
model.result('pg5').set('data', 'dset3');
model.result('pg5').setIndex('looplevel', 4, 0);
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
model.result.dataset.create('dset4', 'Solution');
model.result.dataset('dset4').set('solution', 'sol3');
model.result.dataset('dset4').selection.geom('geom1', 2);
model.result.dataset('dset4').selection.geom('geom1', 2);
model.result.dataset('dset4').selection.set([2]);
model.result('pg1').run;
model.result('pg1').set('data', 'dset4');
model.result('pg1').run;
model.result('pg4').run;
model.result('pg4').set('data', 'dset4');
model.result('pg4').run;
model.result.create('pg6', 'PlotGroup1D');
model.result('pg6').run;
model.result('pg6').label('Heat Transfer Coefficient');
model.result('pg6').set('data', 'dset3');
model.result('pg6').set('titletype', 'manual');
model.result('pg6').set('title', ['Heat transfer coefficient (W/(m' native2unicode(hex2dec({'00' 'b2'}), 'unicode') '.K))']);
model.result('pg6').set('axislimits', true);
model.result('pg6').set('xmin', 0);
model.result('pg6').set('xmax', 5);
model.result('pg6').set('ymin', 2);
model.result('pg6').set('ymax', 6);
model.result('pg6').create('lngr1', 'LineGraph');
model.result('pg6').feature('lngr1').set('markerpos', 'datapoints');
model.result('pg6').feature('lngr1').set('linewidth', 'preference');
model.result('pg6').feature('lngr1').label('Numerical');
model.result('pg6').feature('lngr1').selection.set([5]);
model.result('pg6').feature('lngr1').set('expr', 'qw/(T-Tb)');
model.result('pg6').feature('lngr1').set('xdata', 'expr');
model.result('pg6').feature('lngr1').set('xdataexpr', 'x_plate');
model.result('pg6').feature('lngr1').set('legend', true);
model.result('pg6').feature('lngr1').set('autoplotlabel', true);
model.result('pg6').run;
model.result('pg6').create('lngr2', 'LineGraph');
model.result('pg6').feature('lngr2').set('markerpos', 'datapoints');
model.result('pg6').feature('lngr2').set('linewidth', 'preference');
model.result('pg6').feature('lngr2').set('data', 'dset3');
model.result('pg6').feature('lngr2').setIndex('looplevelinput', 'last', 0);
model.result('pg6').feature('lngr2').selection.set([5]);
model.result('pg6').feature('lngr2').label('Bejan''s correlation');
model.result('pg6').feature('lngr2').set('expr', 'ht.kxx*Nu_x_turb_Bejan/x_plate');
model.result('pg6').feature('lngr2').set('xdata', 'expr');
model.result('pg6').feature('lngr2').set('xdataexpr', 'x_plate');
model.result('pg6').feature('lngr2').set('linestyle', 'dashed');
model.result('pg6').feature('lngr2').set('linecolor', 'fromtheme');
model.result('pg6').feature('lngr2').set('legend', true);
model.result('pg6').feature('lngr2').set('autosolution', false);
model.result('pg6').feature('lngr2').set('autoplotlabel', true);
model.result('pg6').run;
model.result('pg6').create('lngr3', 'LineGraph');
model.result('pg6').feature('lngr3').set('markerpos', 'datapoints');
model.result('pg6').feature('lngr3').set('linewidth', 'preference');
model.result('pg6').feature('lngr3').set('data', 'dset3');
model.result('pg6').feature('lngr3').setIndex('looplevelinput', 'last', 0);
model.result('pg6').feature('lngr3').selection.set([5]);
model.result('pg6').feature('lngr3').label('Lienhard''s correlation');
model.result('pg6').feature('lngr3').set('expr', 'ht.kxx*Nu_x_turb_Lienhard/x_plate');
model.result('pg6').feature('lngr3').set('xdata', 'expr');
model.result('pg6').feature('lngr3').set('xdataexpr', 'x_plate');
model.result('pg6').feature('lngr3').set('linestyle', 'dotted');
model.result('pg6').feature('lngr3').set('linecolor', 'fromtheme');
model.result('pg6').feature('lngr3').set('legend', true);
model.result('pg6').feature('lngr3').set('autosolution', false);
model.result('pg6').feature('lngr3').set('autoplotlabel', true);
model.result('pg6').run;

model.title('Nonisothermal Turbulent Flow over a Flat Plate');

model.description('This benchmark model simulates fully developed nonisothermal turbulent flow over a flat plate. It compares the heat transfer coefficient obtained from simulation with a Nusselt number based correlation function.');

model.mesh.clearMeshes;

model.sol('sol1').clearSolutionData;
model.sol('sol2').clearSolutionData;
model.sol('sol3').clearSolutionData;
model.sol('sol4').clearSolutionData;
model.sol('sol5').clearSolutionData;
model.sol('sol6').clearSolutionData;
model.sol('sol7').clearSolutionData;

model.label('flat_plate_nitf_turbulent.mph');

model.modelNode.label('Components');

out = model;
```

---

## Example 11: high_voltage_insulator_geom_sequence

**Module:** ACDC_Module_Devices,_Capacitive_high_voltage_insulator_geom_sequence  
**Category:** Unknown_Category  

### Model Description

**Model Overview:**
The COMSOL MATLAB script provided outlines a simulation model for a high voltage insulator, which is likely a capacitive device given the module path. The model is designed to analyze the electric field distribution and possibly the capacitive behavior of the insulator under high voltage conditions. The simulation is set within the AC/DC Module of COMSOL, which is typically used for electromagnetics and electrostatics simulations.

**Geometry:**
The geometric setup consists of a 2D axisymmetric model with a series of rectangles and polynomial curves that form the insulator's shape. The insulator is composed of a sequence of rectangular and curved sections, with specific dimensions provided in millimeters. The main components are three rectangles with dimensions 12x100 mm, 6x1050 mm, and 12x100 mm, positioned at different heights. Curved sections are created using polynomial curves and quadratic Bezier curves, which are then arrayed to create a repeating pattern of the insulator geometry. The final insulator structure is obtained by converting the arrayed geometry to a solid and applying fillets with a radius of 8 mm at designated corners.

**Materials:**
The script does not explicitly define the materials used in the simulation. Material properties would typically be defined within the model's physics settings, which are not detailed in the provided script. The insulator material and surrounding medium (likely air or a dielectric) would have key properties such as relative permittivity, electrical conductivity, and possibly other electromagnetic properties.

**Physics:**
The script does not specify the physics interfaces used. However, given the context of a high voltage insulator, the physics would likely involve the Electrostatics interface or the Electric Currents interface from the AC/DC Module. These interfaces solve for electric fields, potentials, and charge distributions, which are critical for understanding the performance of a high voltage insulator.

**Boundary Conditions:**
Boundary conditions are not explicitly defined in the provided script. For a high voltage insulator model, typical boundary conditions would include setting electric potential differences between the insulator's ends, applying ground conditions, and possibly defining surface charge densities or electric field intensities at specific boundaries.

**Mesh:**
The geometry is discretized using a mesh named 'mesh1'. The script does not specify the mesh settings, but COMSOL typically uses a physics-controlled mesh that adapts to the expected fields and charges. Finer meshes would be applied in regions with high field gradients, such as near sharp edges or small gaps in the insulator.

**Study:**
The type of analysis is not specified in the script. However, for a high voltage insulator, a stationary (steady-state) study would be common to determine the electric field distribution under constant voltage conditions. A frequency-domain study could also be used if the effects of alternating currents are of interest.

**Key Parameters:**
Key parameters would include the applied voltage, the geometric dimensions of the insulator, the material properties (relative permittivity, conductivity), and any specified boundary conditions. The script does not list specific values for these parameters, which would typically be defined in the physics settings or study setup.

**Expected Results:**
The model is expected to predict the electric field distribution, potential distribution, and possibly the capacitance of the insulator. These results would help engineers understand the performance of the insulator under high voltage conditions, identify potential hot spots of high electric field intensity, and optimize the insulator design for improved performance and reliability.

**Engineering Application:**
This simulation model addresses the engineering problem of designing and analyzing high voltage insulators, which are critical components in power transmission and distribution systems, as well as in high voltage equipment like transformers and switchgear. The model would assist engineers in optimizing the insulator geometry and material selection to ensure reliable operation under high electric stress, minimize electrical breakdown risks, and improve the overall efficiency and safety of electrical systems.

### COMSOL MATLAB Code

```matlab
function out = model
%
% high_voltage_insulator_geom_sequence.m
%
% Model exported on May 26 2025, 21:24 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/ACDC_Module/Devices,_Capacitive');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 2);
model.geom('geom1').model('comp1');
model.geom('geom1').axisymmetric(true);

model.mesh.create('mesh1', 'geom1');

model.geom('geom1').lengthUnit('mm');
model.geom('geom1').create('r1', 'Rectangle');
model.geom('geom1').feature('r1').set('size', [12 100]);
model.geom('geom1').run('r1');
model.geom('geom1').create('r2', 'Rectangle');
model.geom('geom1').feature('r2').set('size', [6 1050]);
model.geom('geom1').feature('r2').set('pos', [0 50]);
model.geom('geom1').run('r2');
model.geom('geom1').create('r3', 'Rectangle');
model.geom('geom1').feature('r3').set('size', [12 100]);
model.geom('geom1').feature('r3').set('pos', [0 1050]);
model.geom('geom1').run('r3');
model.geom('geom1').create('pol1', 'Polygon');
model.geom('geom1').feature('pol1').set('source', 'table');
model.geom('geom1').feature('pol1').set('type', 'open');
model.geom('geom1').feature('pol1').setIndex('table', 12, 0, 0);
model.geom('geom1').feature('pol1').setIndex('table', 100, 0, 1);
model.geom('geom1').feature('pol1').setIndex('table', 12, 1, 0);
model.geom('geom1').feature('pol1').setIndex('table', 150, 1, 1);
model.geom('geom1').feature('pol1').setIndex('table', 60, 2, 0);
model.geom('geom1').feature('pol1').setIndex('table', 150, 2, 1);
model.geom('geom1').feature('pol1').setIndex('table', 20, 3, 0);
model.geom('geom1').feature('pol1').setIndex('table', 153, 3, 1);
model.geom('geom1').run('pol1');
model.geom('geom1').create('qb1', 'QuadraticBezier');
model.geom('geom1').feature('qb1').setIndex('p', 20, 0, 0);
model.geom('geom1').feature('qb1').setIndex('p', 153, 1, 0);
model.geom('geom1').feature('qb1').setIndex('p', 13, 0, 1);
model.geom('geom1').feature('qb1').setIndex('p', 154, 1, 1);
model.geom('geom1').feature('qb1').setIndex('p', 12, 0, 2);
model.geom('geom1').feature('qb1').setIndex('p', 161, 1, 2);
model.geom('geom1').feature('qb1').set('w', [1 1 1]);
model.geom('geom1').run('qb1');
model.geom('geom1').create('pol2', 'Polygon');
model.geom('geom1').feature('pol2').set('source', 'table');
model.geom('geom1').feature('pol2').set('type', 'open');
model.geom('geom1').feature('pol2').setIndex('table', 12, 0, 0);
model.geom('geom1').feature('pol2').setIndex('table', 161, 0, 1);
model.geom('geom1').feature('pol2').setIndex('table', 12, 1, 0);
model.geom('geom1').feature('pol2').setIndex('table', 200, 1, 1);
model.geom('geom1').feature('pol2').setIndex('table', 60, 2, 0);
model.geom('geom1').feature('pol2').setIndex('table', 200, 2, 1);
model.geom('geom1').feature('pol2').setIndex('table', 20, 3, 0);
model.geom('geom1').feature('pol2').setIndex('table', 203, 3, 1);
model.geom('geom1').run('pol2');
model.geom('geom1').create('qb2', 'QuadraticBezier');
model.geom('geom1').feature('qb2').setIndex('p', 20, 0, 0);
model.geom('geom1').feature('qb2').setIndex('p', 203, 1, 0);
model.geom('geom1').feature('qb2').setIndex('p', 13, 0, 1);
model.geom('geom1').feature('qb2').setIndex('p', 204, 1, 1);
model.geom('geom1').feature('qb2').setIndex('p', 12, 0, 2);
model.geom('geom1').feature('qb2').setIndex('p', 211, 1, 2);
model.geom('geom1').feature('qb2').set('w', [1 1 1]);
model.geom('geom1').run('qb2');
model.geom('geom1').create('pol3', 'Polygon');
model.geom('geom1').feature('pol3').set('source', 'table');
model.geom('geom1').feature('pol3').set('type', 'open');
model.geom('geom1').feature('pol3').setIndex('table', 12, 0, 0);
model.geom('geom1').feature('pol3').setIndex('table', 211, 0, 1);
model.geom('geom1').feature('pol3').setIndex('table', 12, 1, 0);
model.geom('geom1').feature('pol3').setIndex('table', 250, 1, 1);
model.geom('geom1').feature('pol3').setIndex('table', 80, 2, 0);
model.geom('geom1').feature('pol3').setIndex('table', 250, 2, 1);
model.geom('geom1').feature('pol3').setIndex('table', 20, 3, 0);
model.geom('geom1').feature('pol3').setIndex('table', 253, 3, 1);
model.geom('geom1').run('pol3');
model.geom('geom1').create('qb3', 'QuadraticBezier');
model.geom('geom1').feature('qb3').setIndex('p', 20, 0, 0);
model.geom('geom1').feature('qb3').setIndex('p', 253, 1, 0);
model.geom('geom1').feature('qb3').setIndex('p', 13, 0, 1);
model.geom('geom1').feature('qb3').setIndex('p', 254, 1, 1);
model.geom('geom1').feature('qb3').setIndex('p', 12, 0, 2);
model.geom('geom1').feature('qb3').setIndex('p', 261, 1, 2);
model.geom('geom1').feature('qb3').set('w', [1 1 1]);
model.geom('geom1').run('qb3');
model.geom('geom1').feature.compositeCurves({'pol1' 'qb1' 'pol2' 'qb2' 'pol3' 'qb3'});
model.geom('geom1').create('arr1', 'Array');
model.geom('geom1').feature('arr1').selection('input').set({'cc1'});
model.geom('geom1').feature('arr1').set('type', 'linear');
model.geom('geom1').feature('arr1').set('linearsize', 5);
model.geom('geom1').feature('arr1').set('displ', [0 161]);
model.geom('geom1').run('arr1');
model.geom('geom1').feature.duplicate('cc2', 'cc1');
model.geom('geom1').run('cc2');
model.geom('geom1').create('mov1', 'Move');
model.geom('geom1').feature('mov1').selection('input').set({'cc2'});
model.geom('geom1').feature('mov1').set('disply', 794);
model.geom('geom1').run('mov1');
model.geom('geom1').feature('cc2').feature('pol1').setIndex('table', 111, 0, 1);
model.geom('geom1').feature('cc2').feature('pol3').setIndex('table', 256, 1, 1);
model.geom('geom1').feature('cc2').feature('pol3').setIndex('table', 6, 2, 0);
model.geom('geom1').feature('cc2').feature('pol3').setIndex('table', 256, 2, 1);
model.geom('geom1').feature('cc2').feature('pol3').setIndex('table', 6, 3, 0);
model.geom('geom1').feature('cc2').feature('pol3').setIndex('table', -694, 3, 1);
model.geom('geom1').feature('cc2').feature('pol3').setIndex('table', 12, 4, 0);
model.geom('geom1').feature('cc2').feature('pol3').setIndex('table', -694, 4, 1);
model.geom('geom1').feature('cc2').feature.removeCurveComponents({'qb3'});
model.geom('geom1').run('mov1');
model.geom('geom1').create('csol1', 'ConvertToSolid');
model.geom('geom1').feature('csol1').selection('input').set({'arr1' 'mov1'});
model.geom('geom1').run('csol1');
model.geom('geom1').create('fil1', 'Fillet');
model.geom('geom1').feature('fil1').selection('point').set('r1', 2);
model.geom('geom1').feature('fil1').selection('point').set('r3', 3);
model.geom('geom1').feature('fil1').set('radius', 8);
model.geom('geom1').runPre('fin');
model.geom('geom1').create('c1', 'Circle');
model.geom('geom1').feature('c1').set('r', '2[m]');
model.geom('geom1').feature('c1').set('pos', [0 500]);
model.geom('geom1').feature('c1').set('angle', 180);
model.geom('geom1').feature('c1').set('rot', -90);
model.geom('geom1').runPre('fin');

model.title([]);

model.description('');

model.label('high_voltage_insulator_geom_sequence.mph');

model.modelNode.label('Components');

out = model;
```

---

## Example 12: micromechanical_model_of_a_tpms_composite

**Module:** Structural_Mechanics_Module_Material_Models_micromechanical_model_of_a_tpms_composite  
**Category:** Unknown_Category  

### Model Description

**Model Overview**:
The model simulates the micromechanical behavior of a composite material that incorporates a triply periodic minimal surface (TPMS) structure. The primary focus is on determining the homogenized elastic and thermal properties of the composite, such as Young's modulus, Poisson's ratio, shear modulus, and coefficient of thermal expansion. The effects of varying the volume fraction of the TPMS and its Poisson's ratio on the overall material properties are analyzed.

**Geometry**:
The geometric setup consists of a unit cell with dimensions defined by the parameter `L` (100 mm), incorporating a gyroid TPMS structure with a wall thickness defined by the parameter `th` (4 mm). The TPMS structure is created by importing a predefined geometry from a file.

**Materials**:
Two materials are used in the composite:
1. Matrix: Material 1, with Young's modulus `E_m` (10 GPa), Poisson's ratio `nu_m` (0.3), and coefficient of thermal expansion `alpha_m` (44E-6 1/K).
2. TPMS: Material 2, with Young's modulus `E_f` (20 times `E_m`), Poisson's ratio `nu_f` (0.3), and coefficient of thermal expansion `alpha_f` (0.8E-6 1/K).

**Physics**:
The model employs the Structural Mechanics Module for solid mechanics analysis, utilizing the "Solid Mechanics" interface. The analysis includes both elastic and thermal properties, with the "Cell Periodicity" feature to apply periodic boundary conditions and obtain homogenized material properties.

**Boundary Conditions**:
Periodic boundary conditions are applied to the unit cell to simulate an infinite medium with the embedded TPMS structure. The specific conditions are defined through the "Boundary Pair" features within the "Cell Periodicity" feature of the solid mechanics interface.

**Mesh**:
The geometry is discretized using a mesh with a default element size, which can be automatically generated or refined as needed. The mesh is created and run before solving the model.

**Study**:
The analysis is performed using a parametric study to evaluate the effects of varying the wall thickness (`th`) and Poisson's ratio (`nu_f`) of the TPMS material. The study includes a stationary solver to compute the homogenized material properties for each set of parameters.

**Key Parameters**:
- `th`: Wall thickness of the TPMS structure (4 mm to 12 mm).
- `L`: Unit cell length (100 mm).
- `E_m` and `E_f`: Young's moduli of the matrix and TPMS materials, respectively.
- `nu_m` and `nu_f`: Poisson's ratios of the matrix and TPMS materials, respectively.
- `alpha_m` and `alpha_f`: Coefficients of thermal expansion for the matrix and TPMS materials, respectively.

**Expected Results**:
The model predicts the homogenized material properties (Young's modulus, Poisson's ratio, shear modulus, and coefficient of thermal expansion) for the composite material with varying TPMS volume fractions and Poisson's ratios. The results are presented in the form of plots and tables.

**Engineering Application**:
This model can be used to design and optimize composite materials with tailored mechanical and thermal properties for various engineering applications, such as lightweight structures, thermal management systems, and energy absorption devices. By understanding the relationship between the TPMS structure's geometry and the resulting homogenized properties, engineers can develop novel materials with unique combinations of stiffness, strength, and thermal behavior.

### COMSOL MATLAB Code

```matlab
function out = model
%
% micromechanical_model_of_a_tpms_composite.m
%
% Model exported on May 26 2025, 21:33 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/Structural_Mechanics_Module/Material_Models');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 3);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.physics.create('solid', 'SolidMechanics', 'geom1');
model.physics('solid').model('comp1');

% To import content from file, use:
% model.param.loadFile('FILENAME');
model.param.set('th', '4[mm]', 'Wall thickness');
model.param.set('L', '100[mm]', 'Unit cell length');
model.param.set('E_m', '10[GPa]', 'Young''s modulus, matrix');
model.param.set('E_f', '20*E_m', 'Young''s modulus, TPMS');
model.param.set('nu_m', '0.3', 'Poisson''s ratio, matrix');
model.param.set('nu_f', '0.3', 'Poisson''s ratio, TPMS');
model.param.set('G_m', 'E_m/(2*(1+nu_m))', 'Shear modulus, matrix');
model.param.set('alpha_m', '44E-6[1/K]', 'Coefficient of thermal expansion, matrix');
model.param.set('alpha_f', '0.8E-6[1/K]', 'Coefficient of thermal expansion, TPMS');
model.param.set('rho_m', '3000[kg/m^3]', 'Density, matrix');
model.param.set('rho_f', '7000[kg/m^3]', 'Density, TPMS');

model.geom.load({'part1'}, 'COMSOL_Multiphysics/Unit_Cells_and_RVEs/Miscellaneous/gyroid.mph', {'part1'});
model.geom('geom1').create('pi1', 'PartInstance');
model.geom('geom1').feature('pi1').set('selkeepnoncontr', false);
model.geom('geom1').feature('pi1').set('part', 'part1');
model.geom('geom1').feature('pi1').setEntry('inputexpr', 'lm', 'L');
model.geom('geom1').feature('pi1').setEntry('inputexpr', 'th', 'th');
model.geom('geom1').run('fin');
model.geom('geom1').create('rmd1', 'RemoveDetails');
model.geom('geom1').feature('rmd1').set('contangletol', 10);
model.geom('geom1').run('rmd1');
model.geom('geom1').run('rmd1');

model.view('view1').set('showgrid', false);
model.view('view1').set('transparency', false);

model.cpl.create('intop1', 'Integration', 'geom1');
model.cpl('intop1').set('axisym', true);
model.cpl('intop1').selection.named('geom1_pi1_gyroid_dom');

model.variable.create('var1');
model.variable('var1').model('comp1');
model.variable('var1').set('v_f', 'intop1(1)/L^3');
model.variable('var1').descr('v_f', 'Volume fraction of tpms');
model.variable('var1').set('E_h', '1/solid.cp1.Dinv11');
model.variable('var1').descr('E_h', 'Homogenized Young''s modulus');
model.variable('var1').set('nu_h', '-E_h*solid.cp1.Dinv12');
model.variable('var1').descr('nu_h', 'Homogenized Poisson''s ratio');
model.variable('var1').set('G_h', '1/solid.cp1.Dinv55');
model.variable('var1').descr('G_h', 'Homogenized shear modulus');
model.variable('var1').set('alpha_h', 'solid.cp2.alphaXX');
model.variable('var1').descr('alpha_h', 'Homogenized coefficient of thermal expansion');

model.physics('solid').feature('lemm1').create('te1', 'ThermalExpansion', 3);
model.physics('solid').feature('lemm1').feature('te1').set('minput_temperature_src', 'userdef');
model.physics('solid').feature('lemm1').feature('te1').set('minput_temperature', '294.15[K]');
model.physics('solid').create('cp1', 'CellPeriodicity', 3);
model.physics('solid').feature('cp1').label('Cell Periodicity for Elastic Properties');
model.physics('solid').feature('cp1').set('BoundaryExpansion', 'PrescribedStrain');
model.physics('solid').feature('cp1').set('EffectivePropertiese', 'ElasticityMatrixStandard');
model.physics('solid').feature('cp1').create('bp1', 'BoundaryPair', 2);
model.physics('solid').feature('cp1').feature('bp1').selection.named('geom1_pi1_pair1');
model.physics('solid').feature('cp1').feature('bp1').set('manualDestinationSelection', true);
model.physics('solid').feature('cp1').feature('bp1').selection('destinationDomains').named('geom1_pi1_pair1dst');
model.physics('solid').feature('cp1').feature.duplicate('bp2', 'bp1');
model.physics('solid').feature('cp1').feature('bp2').selection.named('geom1_pi1_pair2');
model.physics('solid').feature('cp1').feature('bp2').selection('destinationDomains').named('geom1_pi1_pair2dst');
model.physics('solid').feature('cp1').feature.duplicate('bp3', 'bp2');
model.physics('solid').feature('cp1').feature('bp3').selection.named('geom1_pi1_pair3');
model.physics('solid').feature('cp1').feature('bp3').selection('destinationDomains').named('geom1_pi1_pair3dst');
model.physics('solid').feature('cp1').set('parametricStudy', 'yes');
model.physics('solid').feature('cp1').set('parametricSweep', 'filled');
model.physics('solid').feature('cp1').setIndex('parameterName', 'para', 1, 0);
model.physics('solid').feature('cp1').setIndex('parameterRange', 'range(0,0.1,1)', 1, 0);
model.physics('solid').feature('cp1').setIndex('parameterUnit', 1, 1, 0);
model.physics('solid').feature('cp1').setIndex('parameterRange', 'range(0,0.1,1)', 1, 0);
model.physics('solid').feature('cp1').setIndex('parameterUnit', 1, 1, 0);
model.physics('solid').feature('cp1').setIndex('parameterName', 'para', 1, 0);
model.physics('solid').feature('cp1').setIndex('parameterRange', 'range(0,0.1,1)', 1, 0);
model.physics('solid').feature('cp1').setIndex('parameterUnit', 1, 1, 0);
model.physics('solid').feature('cp1').setIndex('parameterName', 'th', 0, 0);
model.physics('solid').feature('cp1').setIndex('parameterRange', 'range(4,2,12)', 0, 0);
model.physics('solid').feature('cp1').setIndex('parameterUnit', 'mm', 0, 0);
model.physics('solid').feature('cp1').setIndex('parameterName', 'nu_f', 1, 0);
model.physics('solid').feature('cp1').setIndex('parameterRange', '0.3 -0.3 -0.5 -0.75', 1, 0);
model.physics('solid').feature('cp1').setIndex('parameterUnit', 1, 1, 0);
model.physics('solid').feature('cp1').runCommand('createLoadGroupsandStudy');
model.physics('solid').feature.duplicate('cp2', 'cp1');
model.physics('solid').feature('cp2').label('Cell Periodicity for Thermal Properties');
model.physics('solid').feature('cp2').set('BoundaryExpansion', 'FreeExpansion');
model.physics('solid').feature('cp2').set('EffectiveProperties', 'ThermalExpansion');

model.material.create('mat1', 'Common', 'comp1');
model.material('mat1').label('Material 1: Matrix');
model.material('mat1').selection.named('geom1_pi1_matrix');
model.material('mat1').propertyGroup.create('Enu', 'Young''s_modulus_and_Poisson''s_ratio');
model.material('mat1').propertyGroup('Enu').set('E', {'E_m'});
model.material('mat1').propertyGroup('Enu').set('nu', {'nu_m'});
model.material('mat1').propertyGroup('def').set('density', {'rho_m'});
model.material('mat1').propertyGroup('def').set('thermalexpansioncoefficient', {'alpha_m'});
model.material.create('mat2', 'Common', 'comp1');
model.material('mat2').label('Material 2: TPMS');
model.material('mat2').selection.named('geom1_pi1_gyroid_dom');
model.material('mat2').propertyGroup.create('Enu', 'Young''s_modulus_and_Poisson''s_ratio');
model.material('mat2').propertyGroup('Enu').set('E', {'E_f'});
model.material('mat2').propertyGroup('Enu').set('nu', {'nu_f'});
model.material('mat2').propertyGroup('def').set('density', {'rho_f'});
model.material('mat2').propertyGroup('def').set('thermalexpansioncoefficient', {'alpha_f'});

model.mesh('mesh1').autoMeshSize(4);
model.mesh('mesh1').run;

model.study('solidcp1std').label('Cell Periodicity Study for Elastic Properties');
model.study('solidcp1std').feature('solidcp1stat').set('useadvanceddisable', true);
model.study('solidcp1std').feature('solidcp1stat').set('disabledphysics', {'solid/lemm1/te1' 'solid/cp2'});

model.sol('solidcp1sol').feature('s1').feature('i1').active(true);

model.batch('solidcp1p').run('compute');

model.result.create('pg1', 'PlotGroup3D');
model.result('pg1').set('data', 'dset2');
model.result('pg1').setIndex('looplevel', 6, 0);
model.result('pg1').setIndex('looplevel', 4, 1);
model.result('pg1').setIndex('looplevel', 5, 2);
model.result('pg1').set('defaultPlotID', 'stress');
model.result('pg1').label('Stress (solid)');
model.result('pg1').set('frametype', 'spatial');
model.result('pg1').create('vol1', 'Volume');
model.result('pg1').feature('vol1').set('expr', {'solid.misesGp'});
model.result('pg1').feature('vol1').set('threshold', 'manual');
model.result('pg1').feature('vol1').set('thresholdvalue', 0.2);
model.result('pg1').feature('vol1').set('colortable', 'Rainbow');
model.result('pg1').feature('vol1').set('colortabletrans', 'none');
model.result('pg1').feature('vol1').set('colorscalemode', 'linear');
model.result('pg1').feature('vol1').set('resolution', 'custom');
model.result('pg1').feature('vol1').set('refine', 2);
model.result('pg1').feature('vol1').set('colortable', 'Prism');
model.result('pg1').feature('vol1').create('def', 'Deform');
model.result('pg1').feature('vol1').feature('def').set('expr', {'u' 'v' 'w'});
model.result('pg1').feature('vol1').feature('def').set('descr', 'Displacement field');
model.result.evaluationGroup.create('solidcp1stdEg', 'EvaluationGroup');
model.result.evaluationGroup('solidcp1stdEg').set('defaultPlotID', 'homogenizedMaterialTablecp1');
model.result.evaluationGroup('solidcp1stdEg').set('data', 'dset2');
model.result.evaluationGroup('solidcp1stdEg').set('includeparameters', 'off');
model.result.evaluationGroup('solidcp1stdEg').setIndex('looplevelinput', 'last', 0);
model.result.evaluationGroup('solidcp1stdEg').setIndex('looplevelinput', 'last', 1);
model.result.evaluationGroup('solidcp1stdEg').setIndex('looplevelinput', 'last', 2);
model.result.evaluationGroup('solidcp1stdEg').label('Material Properties (Cell Periodicity Study for Elastic Properties)');
model.result.evaluationGroup('solidcp1stdEg').create('gmevcp1', 'EvalGlobalMatrix');
model.result.evaluationGroup('solidcp1stdEg').feature('gmevcp1').set('expr', 'root.comp1.solid.cp1.D');
model.result.evaluationGroup('solidcp1stdEg').feature('gmevcp1').set('descr', 'Elasticity matrix');
model.result.evaluationGroup('solidcp1stdEg').run;
model.result('pg1').run;

model.study.create('std1');
model.study('std1').create('stat', 'Stationary');
model.study('std1').feature('stat').setSolveFor('/physics/solid', true);

model.geom('geom1').run;

model.study('std1').label('Cell Periodicity Study for Thermal Properties');
model.study('std1').create('param', 'Parametric');
model.study('std1').feature('param').set('sweeptype', 'filled');
model.study('std1').feature('param').setIndex('pname', 'th', 0);
model.study('std1').feature('param').setIndex('plistarr', '', 0);
model.study('std1').feature('param').setIndex('punit', 'm', 0);
model.study('std1').feature('param').setIndex('pname', 'th', 0);
model.study('std1').feature('param').setIndex('plistarr', '', 0);
model.study('std1').feature('param').setIndex('punit', 'm', 0);
model.study('std1').feature('param').setIndex('plistarr', 'range(4,2,12)', 0);
model.study('std1').feature('param').setIndex('punit', 'mm', 0);
model.study('std1').feature('param').setIndex('pname', 'L', 1);
model.study('std1').feature('param').setIndex('plistarr', '', 1);
model.study('std1').feature('param').setIndex('punit', 'm', 1);
model.study('std1').feature('param').setIndex('pname', 'L', 1);
model.study('std1').feature('param').setIndex('plistarr', '', 1);
model.study('std1').feature('param').setIndex('punit', 'm', 1);
model.study('std1').feature('param').setIndex('pname', 'nu_f', 1);
model.study('std1').feature('param').setIndex('plistarr', '0.3 -0.3 -0.5 -0.75', 1);
model.study('std1').feature('param').setIndex('punit', 1, 1);
model.study('std1').feature('stat').set('useadvanceddisable', true);
model.study('std1').feature('stat').set('disabledphysics', {'solid/cp1'});

model.sol.create('sol21');
model.sol('sol21').study('std1');
model.sol('sol21').create('st1', 'StudyStep');
model.sol('sol21').feature('st1').set('study', 'std1');
model.sol('sol21').feature('st1').set('studystep', 'stat');
model.sol('sol21').create('v1', 'Variables');
model.sol('sol21').feature('v1').set('control', 'stat');
model.sol('sol21').create('s1', 'Stationary');
model.sol('sol21').feature('s1').feature('aDef').set('cachepattern', true);
model.sol('sol21').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol21').feature('s1').feature('fc1').set('termonres', 'auto');
model.sol('sol21').feature('s1').feature('fc1').set('reserrfact', 1000);
model.sol('sol21').feature('s1').create('d1', 'Direct');
model.sol('sol21').feature('s1').feature('d1').set('linsolver', 'mumps');
model.sol('sol21').feature('s1').feature('d1').label('Suggested Direct Solver (solid)');
model.sol('sol21').feature('s1').create('i1', 'Iterative');
model.sol('sol21').feature('s1').feature('i1').set('linsolver', 'fgmres');
model.sol('sol21').feature('s1').feature('i1').set('rhob', 400);
model.sol('sol21').feature('s1').feature('i1').set('nlinnormuse', true);
model.sol('sol21').feature('s1').feature('i1').label('Suggested Iterative Solver (solid)');
model.sol('sol21').feature('s1').feature('i1').create('mg1', 'Multigrid');
model.sol('sol21').feature('s1').feature('i1').feature('mg1').set('prefun', 'gmg');
model.sol('sol21').feature('s1').feature('i1').feature('mg1').feature('pr').create('so1', 'SOR');
model.sol('sol21').feature('s1').feature('i1').feature('mg1').feature('pr').feature('so1').set('relax', 0.8);
model.sol('sol21').feature('s1').feature('i1').feature('mg1').feature('po').create('so1', 'SOR');
model.sol('sol21').feature('s1').feature('i1').feature('mg1').feature('po').feature('so1').set('relax', 0.8);
model.sol('sol21').feature('s1').feature('i1').feature('mg1').feature('cs').create('d1', 'Direct');
model.sol('sol21').feature('s1').feature('i1').feature('mg1').feature('cs').feature('d1').set('linsolver', 'pardiso');
model.sol('sol21').feature('s1').feature('i1').feature('mg1').feature('cs').feature('d1').set('pivotperturb', 1.0E-9);
model.sol('sol21').feature('s1').feature('fc1').set('linsolver', 'd1');
model.sol('sol21').feature('s1').feature('fc1').set('termonres', 'auto');
model.sol('sol21').feature('s1').feature('fc1').set('reserrfact', 1000);
model.sol('sol21').feature('s1').feature.remove('fcDef');
model.sol('sol21').attach('std1');

model.batch.create('p1', 'Parametric');
model.batch('p1').study('std1');
model.batch('p1').create('so1', 'Solutionseq');
model.batch('p1').feature('so1').set('seq', 'sol21');
model.batch('p1').feature('so1').set('store', 'on');
model.batch('p1').feature('so1').set('clear', 'on');
model.batch('p1').feature('so1').set('psol', 'none');
model.batch('p1').set('pname', {'th' 'nu_f'});
model.batch('p1').set('plistarr', {'range(4,2,12)' '0.3 -0.3 -0.5 -0.75'});
model.batch('p1').set('sweeptype', 'filled');
model.batch('p1').set('probesel', 'all');
model.batch('p1').set('probes', {});
model.batch('p1').set('plot', 'off');
model.batch('p1').set('err', 'on');
model.batch('p1').attach('std1');
model.batch('p1').set('control', 'param');

model.sol.create('sol22');
model.sol('sol22').study('std1');
model.sol('sol22').label('Parametric Solutions 1');

model.batch('p1').feature('so1').set('psol', 'sol22');
model.batch('p1').run('compute');

model.result.create('pg2', 'PlotGroup3D');
model.result('pg2').set('data', 'dset4');
model.result('pg2').setIndex('looplevel', 4, 0);
model.result('pg2').setIndex('looplevel', 5, 1);
model.result('pg2').set('defaultPlotID', 'stress');
model.result('pg2').label('Stress (solid) 1');
model.result('pg2').set('frametype', 'spatial');
model.result('pg2').create('vol1', 'Volume');
model.result('pg2').feature('vol1').set('expr', {'solid.misesGp'});
model.result('pg2').feature('vol1').set('threshold', 'manual');
model.result('pg2').feature('vol1').set('thresholdvalue', 0.2);
model.result('pg2').feature('vol1').set('colortable', 'Rainbow');
model.result('pg2').feature('vol1').set('colortabletrans', 'none');
model.result('pg2').feature('vol1').set('colorscalemode', 'linear');
model.result('pg2').feature('vol1').set('resolution', 'custom');
model.result('pg2').feature('vol1').set('refine', 2);
model.result('pg2').feature('vol1').set('colortable', 'Prism');
model.result('pg2').feature('vol1').create('def', 'Deform');
model.result('pg2').feature('vol1').feature('def').set('expr', {'u' 'v' 'w'});
model.result('pg2').feature('vol1').feature('def').set('descr', 'Displacement field');
model.result.evaluationGroup.create('std1Eg', 'EvaluationGroup');
model.result.evaluationGroup('std1Eg').set('defaultPlotID', 'homogenizedMaterialTablecp2');
model.result.evaluationGroup('std1Eg').set('data', 'dset4');
model.result.evaluationGroup('std1Eg').set('includeparameters', 'off');
model.result.evaluationGroup('std1Eg').setIndex('looplevelinput', 'last', 0);
model.result.evaluationGroup('std1Eg').setIndex('looplevelinput', 'last', 1);
model.result.evaluationGroup('std1Eg').label('Material Properties (Cell Periodicity Study for Thermal Properties)');
model.result.evaluationGroup('std1Eg').create('gmevcp2', 'EvalGlobalMatrix');
model.result.evaluationGroup('std1Eg').feature('gmevcp2').set('expr', 'root.comp1.solid.cp2.alpha');
model.result.evaluationGroup('std1Eg').feature('gmevcp2').set('descr', 'Coefficient of thermal expansion');
model.result.evaluationGroup('std1Eg').run;
model.result('pg2').run;
model.result('pg1').run;
model.result('pg1').setIndex('looplevel', 1, 2);
model.result('pg1').setIndex('looplevel', 1, 0);
model.result('pg1').setIndex('looplevel', 1, 1);
model.result('pg1').run;
model.result('pg2').run;
model.result('pg2').setIndex('looplevel', 1, 1);
model.result('pg2').setIndex('looplevel', 1, 0);
model.result('pg2').run;
model.result.create('pg3', 'PlotGroup1D');
model.result('pg3').run;
model.result('pg3').label('Homogenized Young''s Modulus vs. TPMS Volume Fraction');
model.result('pg3').set('data', 'dset2');
model.result('pg3').setIndex('looplevelinput', 'first', 0);
model.result('pg3').set('titletype', 'label');
model.result('pg3').set('xlabelactive', true);
model.result('pg3').set('xlabel', 'v<sub>f</sub>');
model.result('pg3').set('ylabelactive', true);
model.result('pg3').set('ylabel', 'E<sub>h</sub>/E<sub>m</sub>');
model.result('pg3').set('legendpos', 'upperleft');
model.result('pg3').create('glob1', 'Global');
model.result('pg3').feature('glob1').set('markerpos', 'datapoints');
model.result('pg3').feature('glob1').set('linewidth', 'preference');
model.result('pg3').feature('glob1').setIndex('expr', 'E_h/E_m', 0);
model.result('pg3').feature('glob1').setIndex('unit', 1, 0);
model.result('pg3').feature('glob1').setIndex('descr', '', 0);
model.result('pg3').feature('glob1').set('xdatasolnumtype', 'level3');
model.result('pg3').feature('glob1').set('xdata', 'expr');
model.result('pg3').feature('glob1').set('xdataexpr', 'v_f');
model.result('pg3').feature('glob1').set('linemarker', 'cycle');
model.result('pg3').feature('glob1').set('markerpos', 'interp');
model.result('pg3').feature('glob1').set('legendmethod', 'manual');
model.result('pg3').feature('glob1').setIndex('legends', '\nu<sub>f</sub>= 0.3', 0);
model.result('pg3').feature('glob1').setIndex('legends', '\nu<sub>f</sub>= -0.3', 1);
model.result('pg3').feature('glob1').setIndex('legends', '\nu<sub>f</sub>= -0.5', 2);
model.result('pg3').feature('glob1').setIndex('legends', '\nu<sub>f</sub>= -0.75', 3);
model.result('pg3').run;
model.result('pg3').run;
model.result.duplicate('pg4', 'pg3');
model.result('pg4').run;
model.result('pg4').label('Homogenized Poisson''s Ratio vs. TPMS Volume Fraction');
model.result('pg4').set('ylabel', '\nu<sub>h</sub>');
model.result('pg4').set('legendpos', 'lowerleft');
model.result('pg4').run;
model.result('pg4').feature('glob1').setIndex('expr', 'nu_h', 0);
model.result('pg4').feature('glob1').setIndex('unit', 1, 0);
model.result('pg4').feature('glob1').setIndex('descr', '', 0);
model.result('pg4').run;
model.result('pg3').run;
model.result.duplicate('pg5', 'pg3');
model.result('pg5').run;
model.result('pg5').label('Homogenized Shear Modulus vs. TPMS Volume Fraction');
model.result('pg5').set('ylabel', 'G<sub>h</sub>/G<sub>m</sub>');
model.result('pg5').run;
model.result('pg5').feature('glob1').setIndex('expr', 'G_h/G_m', 0);
model.result('pg5').feature('glob1').setIndex('unit', 1, 0);
model.result('pg5').feature('glob1').setIndex('descr', '', 0);
model.result('pg5').run;
model.result('pg3').run;
model.result.duplicate('pg6', 'pg3');
model.result('pg6').run;
model.result('pg6').label('Homogenized Coefficient of Thermal Expansion vs. TPMS Volume Fraction');
model.result('pg6').set('data', 'none');
model.result('pg6').set('ylabel', '\alpha<sub>h</sub>/\alpha<sub>m</sub>');
model.result('pg6').set('legendpos', 'upperright');
model.result('pg6').run;
model.result('pg6').feature('glob1').setIndex('expr', 'alpha_h/alpha_m', 0);
model.result('pg6').run;
model.result('pg6').set('data', 'dset4');
model.result('pg6').run;
model.result('pg6').feature('glob1').set('xdatasolnumtype', 'level2');
model.result('pg6').run;
model.result('pg2').run;

model.title('Micromechanical Model of a Triply-Periodic-Minimal-Surface-Based Composite');

model.description(['In this example, the homogenized elastic and thermal properties of a composite material based on a triply periodic minimal surface (TPMS) are computed.' newline  newline 'A gyroid TPMS-based unit cell is subjected to periodic boundary conditions to get the homogenized material properties. The effects of a negative Poisson''s ratio and different volume fractions on the homogenized properties are analyzed.']);

model.mesh.clearMeshes;

model.sol('solidcp1sol').clearSolutionData;
model.sol('solidcp1solp').clearSolutionData;
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
model.sol('sol15').clearSolutionData;
model.sol('sol16').clearSolutionData;
model.sol('sol17').clearSolutionData;
model.sol('sol18').clearSolutionData;
model.sol('sol19').clearSolutionData;
model.sol('sol20').clearSolutionData;
model.sol('sol21').clearSolutionData;
model.sol('sol22').clearSolutionData;
model.sol('sol23').clearSolutionData;
model.sol('sol24').clearSolutionData;
model.sol('sol25').clearSolutionData;
model.sol('sol26').clearSolutionData;
model.sol('sol27').clearSolutionData;
model.sol('sol28').clearSolutionData;
model.sol('sol29').clearSolutionData;
model.sol('sol30').clearSolutionData;
model.sol('sol31').clearSolutionData;
model.sol('sol32').clearSolutionData;
model.sol('sol33').clearSolutionData;
model.sol('sol34').clearSolutionData;
model.sol('sol35').clearSolutionData;
model.sol('sol36').clearSolutionData;
model.sol('sol37').clearSolutionData;
model.sol('sol38').clearSolutionData;
model.sol('sol39').clearSolutionData;
model.sol('sol40').clearSolutionData;
model.sol('sol41').clearSolutionData;
model.sol('sol42').clearSolutionData;

model.label('micromechanical_model_of_a_tpms_composite.mph');

model.modelNode.label('Components');

out = model;
```

---

## Example 13: power_transistor

**Module:** Heat_Transfer_Module_Power_Electronics_and_Electronic_Cooling_power_transistor  
**Category:** Unknown_Category  

### Model Description

### Model Overview

The simulation model, named "power_transistor," is designed to analyze the thermal behavior of a power transistor system, which includes a part of a circuit board with copper pathways connected to the transistor. The primary aim is to determine the operating temperature of the transistor, which may significantly exceed ambient temperature due to resistive heating caused by the current passing through the transistor and the connecting copper routes.

### Geometry

The geometric setup of the model is not explicitly detailed in the provided MATLAB code, but it can be inferred that it includes a power transistor, copper pathways, and possibly a section of a circuit board. The geometry is likely a 3D model, as indicated by the creation of a 3D geometry object (`geom1`). The specific dimensions and shapes are not directly provided in the code snippet but are likely defined within the imported geometry sequence file (`power_transistor_geom_sequence.mph`).

### Materials

The model includes four different materials, each with distinct properties:

1. **Copper (mat1)**: Used for the transistor and connecting routes, with high electrical conductivity (`5.998e7 S/m`) and thermal conductivity (`400 W/(m*K)`).
2. **FR4 (Circuit Board) (mat2)**: A common material for circuit boards, with lower electrical conductivity (`0.004 S/m`) and thermal conductivity (`0.3 W/(m*K)`) compared to copper.
3. **Silica Glass (mat3)**: Likely used for insulation or encapsulation purposes, with very low electrical conductivity (`1e-14 S/m`) and moderate thermal conductivity (`1.38 W/(m*K)`).
4. **Solder, 60Sn-40Pb (mat4)**: Used for joining components, with high electrical conductivity (`6.67e6 S/m`) and thermal conductivity (`50 W/(m*K)`).

### Physics

The model employs two main physics interfaces:

1. **Conductive Media (ec)**: Models the electric current conduction through the transistor and copper pathways.
2. **Heat Transfer (ht)**: Simulates heat generation due to resistive losses and the subsequent heat transfer through conduction, convection, and possibly radiation.

Additionally, an Electromagnetic Heating (emh1) multiphysics interface couples the electric current conduction to the heat transfer, allowing for the simulation of Joule heating.

### Boundary Conditions

Key boundary conditions include:

- **Ground (gnd1)**: Applied to certain boundaries of the copper components, setting the electric potential to zero.
- **Normal Current Density (ncd1, ncd2, ncd3)**: Applied to specific boundaries to represent the current flowing into and out of the transistor.
- **Heat Flux Boundary (hf1)**: A convective heat flux condition applied to all boundaries, modeling heat dissipation to the environment through a heat transfer coefficient (`h_coeff`).
- **Boundary Heat Source (bhs1)**: Represents a heat source at a specific boundary, possibly modeling localized heating.

### Mesh

The geometry is discretized using a mesh generator (`mesh1`), with an automatic mesh size setting of 4, indicating a relatively fine mesh for accurate results.

### Study

The analysis performed is stationary (steady-state), aiming to find the equilibrium state of the system where the temperature distribution no longer changes over time.

### Key Parameters

Important parameters include:

- **Current Density (j_CE)**: `1e5 A/m^2`, representing the current flowing through the transistor.
- **Boundary Heat Source Strength (Q_h)**: `1e5 W/m^2`, the strength of any applied heat source.
- **Heat Transfer Coefficient (h_coeff)**: `5 W/(m^2*K)`, characterizing the convective heat loss to the environment.

### Expected Results

The model predicts the electric potential and current density distribution within the transistor and copper pathways, as well as the temperature distribution throughout the system. It specifically aims to determine the operating temperature of the transistor under steady-state conditions.

### Engineering Application

This model addresses the real-world engineering problem of managing and predicting the thermal performance of power transistors in electronic circuits. Understanding the temperature profile is crucial for the design and reliability of electronic devices, as excessive heat can lead to component failure. The simulation aids in optimizing the design of the transistor and its heat management system to ensure reliable operation within safe temperature limits.

### COMSOL MATLAB Code

```matlab
function out = model
%
% power_transistor.m
%
% Model exported on May 26 2025, 21:29 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/Heat_Transfer_Module/Power_Electronics_and_Electronic_Cooling');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 3);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.physics.create('ec', 'ConductiveMedia', 'geom1');
model.physics('ec').model('comp1');
model.physics.create('ht', 'HeatTransfer', 'geom1');
model.physics('ht').model('comp1');

model.multiphysics.create('emh1', 'ElectromagneticHeating', 'geom1', 3);
model.multiphysics('emh1').set('EMHeat_physics', 'ec');
model.multiphysics('emh1').set('Heat_physics', 'ht');
model.multiphysics('emh1').selection.all;

model.study.create('std1');
model.study('std1').create('stat', 'Stationary');
model.study('std1').feature('stat').setSolveFor('/physics/ec', true);
model.study('std1').feature('stat').setSolveFor('/physics/ht', true);
model.study('std1').feature('stat').setSolveFor('/multiphysics/emh1', true);

model.geom('geom1').insertFile('power_transistor_geom_sequence.mph', 'geom1');
model.geom('geom1').run('cmd2');

model.param.set('j_CE', '1e5[A/m^2]');
model.param.descr('j_CE', 'Current density, collector and emitter routes');
model.param.set('Q_h', '1e5[W/m^2]');
model.param.descr('Q_h', 'Boundary heat source strength');
model.param.set('h_coeff', '5[W/(m^2*K)]');
model.param.descr('h_coeff', 'Heat transfer coefficient');

model.material.create('mat1', 'Common', 'comp1');
model.material('mat1').propertyGroup.create('Enu', 'Young''s modulus and Poisson''s ratio');
model.material('mat1').propertyGroup.create('linzRes', 'Linearized resistivity');
model.material('mat1').label('Copper');
model.material('mat1').set('family', 'copper');
model.material('mat1').propertyGroup('def').set('relpermeability', {'1' '0' '0' '0' '1' '0' '0' '0' '1'});
model.material('mat1').propertyGroup('def').set('electricconductivity', {'5.998e7[S/m]' '0' '0' '0' '5.998e7[S/m]' '0' '0' '0' '5.998e7[S/m]'});
model.material('mat1').propertyGroup('def').set('thermalexpansioncoefficient', {'17e-6[1/K]' '0' '0' '0' '17e-6[1/K]' '0' '0' '0' '17e-6[1/K]'});
model.material('mat1').propertyGroup('def').set('heatcapacity', '385[J/(kg*K)]');
model.material('mat1').propertyGroup('def').set('relpermittivity', {'1' '0' '0' '0' '1' '0' '0' '0' '1'});
model.material('mat1').propertyGroup('def').set('density', '8960[kg/m^3]');
model.material('mat1').propertyGroup('def').set('thermalconductivity', {'400[W/(m*K)]' '0' '0' '0' '400[W/(m*K)]' '0' '0' '0' '400[W/(m*K)]'});
model.material('mat1').propertyGroup('Enu').set('E', '110[GPa]');
model.material('mat1').propertyGroup('Enu').set('nu', '0.35');
model.material('mat1').propertyGroup('linzRes').set('rho0', '1.72e-8[ohm*m]');
model.material('mat1').propertyGroup('linzRes').set('alpha', '0.0039[1/K]');
model.material('mat1').propertyGroup('linzRes').set('Tref', '298[K]');
model.material('mat1').propertyGroup('linzRes').addInput('temperature');
model.material.create('mat2', 'Common', 'comp1');
model.material('mat2').propertyGroup.create('Enu', 'Young''s modulus and Poisson''s ratio');
model.material('mat2').label('FR4 (Circuit Board)');
model.material('mat2').set('family', 'pcbgreen');
model.material('mat2').propertyGroup('def').set('relpermeability', {'1' '0' '0' '0' '1' '0' '0' '0' '1'});
model.material('mat2').propertyGroup('def').set('electricconductivity', {'0.004[S/m]' '0' '0' '0' '0.004[S/m]' '0' '0' '0' '0.004[S/m]'});
model.material('mat2').propertyGroup('def').set('relpermittivity', {'4.5' '0' '0' '0' '4.5' '0' '0' '0' '4.5'});
model.material('mat2').propertyGroup('def').set('thermalexpansioncoefficient', {'18e-6[1/K]' '0' '0' '0' '18e-6[1/K]' '0' '0' '0' '18e-6[1/K]'});
model.material('mat2').propertyGroup('def').set('heatcapacity', '1369[J/(kg*K)]');
model.material('mat2').propertyGroup('def').set('density', '1900[kg/m^3]');
model.material('mat2').propertyGroup('def').set('thermalconductivity', {'0.3[W/(m*K)]' '0' '0' '0' '0.3[W/(m*K)]' '0' '0' '0' '0.3[W/(m*K)]'});
model.material('mat2').propertyGroup('Enu').set('E', '22[GPa]');
model.material('mat2').propertyGroup('Enu').set('nu', '0.15');
model.material.create('mat3', 'Common', 'comp1');
model.material('mat3').propertyGroup.create('Enu', 'Young''s modulus and Poisson''s ratio');
model.material('mat3').propertyGroup.create('RefractiveIndex', 'Refractive index');
model.material('mat3').label('Silica glass');
model.material('mat3').set('family', 'custom');
model.material('mat3').set('customambient', [1 1 1]);
model.material('mat3').set('noise', true);
model.material('mat3').set('fresnel', 0.99);
model.material('mat3').set('roughness', 0.02);
model.material('mat3').set('metallic', 0);
model.material('mat3').set('pearl', 0);
model.material('mat3').set('diffusewrap', 0);
model.material('mat3').set('clearcoat', 0);
model.material('mat3').set('reflectance', 0);
model.material('mat3').propertyGroup('def').set('relpermeability', {'1' '0' '0' '0' '1' '0' '0' '0' '1'});
model.material('mat3').propertyGroup('def').set('electricconductivity', {'1e-14[S/m]' '0' '0' '0' '1e-14[S/m]' '0' '0' '0' '1e-14[S/m]'});
model.material('mat3').propertyGroup('def').set('thermalexpansioncoefficient', {'0.55e-6[1/K]' '0' '0' '0' '0.55e-6[1/K]' '0' '0' '0' '0.55e-6[1/K]'});
model.material('mat3').propertyGroup('def').set('heatcapacity', '703[J/(kg*K)]');
model.material('mat3').propertyGroup('def').set('relpermittivity', {'3.75' '0' '0' '0' '3.75' '0' '0' '0' '3.75'});
model.material('mat3').propertyGroup('def').set('density', '2203[kg/m^3]');
model.material('mat3').propertyGroup('def').set('thermalconductivity', {'1.38[W/(m*K)]' '0' '0' '0' '1.38[W/(m*K)]' '0' '0' '0' '1.38[W/(m*K)]'});
model.material('mat3').propertyGroup('Enu').set('E', '73.1[GPa]');
model.material('mat3').propertyGroup('Enu').set('nu', '0.17');
model.material('mat3').propertyGroup('RefractiveIndex').set('n', {'1.45' '0' '0' '0' '1.45' '0' '0' '0' '1.45'});
model.material.create('mat4', 'Common', 'comp1');
model.material('mat4').propertyGroup.create('Enu', 'Young''s modulus and Poisson''s ratio');
model.material('mat4').propertyGroup.create('linzRes', 'Linearized resistivity');
model.material('mat4').propertyGroup.create('Anand', 'Anand viscoplasticity');
model.material('mat4').label('Solder, 60Sn-40Pb');
model.material('mat4').set('family', 'custom');
model.material('mat4').set('customspecular', [0.7843137254901961 1 1]);
model.material('mat4').set('customdiffuse', [0.7843137254901961 0.7843137254901961 0.7843137254901961]);
model.material('mat4').set('noise', true);
model.material('mat4').set('fresnel', 0.9);
model.material('mat4').set('roughness', 0.1);
model.material('mat4').set('metallic', 0);
model.material('mat4').set('pearl', 0);
model.material('mat4').set('diffusewrap', 0);
model.material('mat4').set('clearcoat', 0);
model.material('mat4').set('reflectance', 0);
model.material('mat4').propertyGroup('def').set('electricconductivity', {'6.67e6[S/m]' '0' '0' '0' '6.67e6[S/m]' '0' '0' '0' '6.67e6[S/m]'});
model.material('mat4').propertyGroup('def').set('thermalexpansioncoefficient', {'21e-6[1/K]' '0' '0' '0' '21e-6[1/K]' '0' '0' '0' '21e-6[1/K]'});
model.material('mat4').propertyGroup('def').set('heatcapacity', '150[J/(kg*K)]');
model.material('mat4').propertyGroup('def').set('density', '9000[kg/m^3]');
model.material('mat4').propertyGroup('def').set('thermalconductivity', {'50[W/(m*K)]' '0' '0' '0' '50[W/(m*K)]' '0' '0' '0' '50[W/(m*K)]'});
model.material('mat4').propertyGroup('Enu').set('E', '10[GPa]');
model.material('mat4').propertyGroup('Enu').set('nu', '0.4');
model.material('mat4').propertyGroup('linzRes').set('rho0', '4.99e-7[ohm*m]');
model.material('mat4').propertyGroup('linzRes').addInput('temperature');
model.material('mat4').propertyGroup('Anand').set('A_ana', '1.49e7');
model.material('mat4').propertyGroup('Anand').set('Q_ana', '90046');
model.material('mat4').propertyGroup('Anand').set('xi_ana', '11');
model.material('mat4').propertyGroup('Anand').set('m_ana', '0.303');
model.material('mat4').propertyGroup('Anand').set('ssat_ana', '80.42[MPa]');
model.material('mat4').propertyGroup('Anand').set('sa_init', '56.33[MPa]');
model.material('mat4').propertyGroup('Anand').set('h0_ana', '2640.75[MPa]');
model.material('mat4').propertyGroup('Anand').set('a_ana', '1.34');
model.material('mat4').propertyGroup('Anand').set('n_ana', '0.0231');

model.view('view1').set('renderwireframe', true);

model.material('mat1').selection.set([2 3 4 9 10 11 12]);
model.material('mat2').selection.set([1]);
model.material('mat3').selection.set([8]);
model.material('mat4').selection.set([5 6 7]);
model.material('mat4').propertyGroup('def').set('relpermittivity', {'1'});

model.physics('ec').selection.set([2 3 4 5 6 7 9 10 11]);
model.physics('ec').create('gnd1', 'Ground', 2);
model.physics('ec').feature('gnd1').selection.set([84 104 124]);
model.physics('ec').create('ncd1', 'NormalCurrentDensity', 2);
model.physics('ec').feature('ncd1').selection.set([10]);
model.physics('ec').feature('ncd1').set('nJ', '(1-1e-3)*j_CE');
model.physics('ec').create('ncd2', 'NormalCurrentDensity', 2);
model.physics('ec').feature('ncd2').selection.set([5]);
model.physics('ec').feature('ncd2').set('nJ', '-j_CE');
model.physics('ec').create('ncd3', 'NormalCurrentDensity', 2);
model.physics('ec').feature('ncd3').selection.set([15]);
model.physics('ec').feature('ncd3').set('nJ', '1e-3*j_CE');
model.physics('ht').create('hf1', 'HeatFluxBoundary', 2);
model.physics('ht').feature('hf1').selection.all;
model.physics('ht').feature('hf1').set('HeatFluxType', 'ConvectiveHeatFlux');
model.physics('ht').feature('hf1').set('h', 'h_coeff');
model.physics('ht').create('bhs1', 'BoundaryHeatSource', 2);
model.physics('ht').feature('bhs1').selection.named('geom1_wp2_bnd');
model.physics('ht').feature('bhs1').set('Qb_input', 'Q_h');

model.mesh('mesh1').autoMeshSize(4);
model.mesh('mesh1').run;

model.sol.create('sol1');
model.sol('sol1').study('std1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'stat');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').set('control', 'stat');
model.sol('sol1').create('s1', 'Stationary');
model.sol('sol1').feature('s1').create('se1', 'Segregated');
model.sol('sol1').feature('s1').feature('se1').feature.remove('ssDef');
model.sol('sol1').feature('s1').feature('se1').create('ss1', 'SegregatedStep');
model.sol('sol1').feature('s1').feature('se1').feature('ss1').set('segvar', {'comp1_V'});
model.sol('sol1').feature('s1').create('i1', 'Iterative');
model.sol('sol1').feature('s1').feature('i1').set('linsolver', 'cg');
model.sol('sol1').feature('s1').feature('i1').create('mg1', 'Multigrid');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').set('prefun', 'amg');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').set('coarseningmethod', 'classic');
model.sol('sol1').feature('s1').feature('se1').feature('ss1').set('linsolver', 'i1');
model.sol('sol1').feature('s1').feature('se1').feature('ss1').label('Electric Currents');
model.sol('sol1').feature('s1').feature('se1').create('ss2', 'SegregatedStep');
model.sol('sol1').feature('s1').feature('se1').feature('ss2').set('segvar', {'comp1_T'});
model.sol('sol1').feature('s1').feature('se1').feature('ss2').set('subdamp', 0.8);
model.sol('sol1').feature('s1').create('d1', 'Direct');
model.sol('sol1').feature('s1').feature('d1').set('linsolver', 'pardiso');
model.sol('sol1').feature('s1').feature('d1').set('pivotperturb', 1.0E-13);
model.sol('sol1').feature('s1').feature('d1').label('Direct, heat transfer variables (ht)');
model.sol('sol1').feature('s1').feature('se1').feature('ss2').set('linsolver', 'd1');
model.sol('sol1').feature('s1').feature('se1').feature('ss2').label('Temperature');
model.sol('sol1').feature('s1').feature('se1').create('ll1', 'LowerLimit');
model.sol('sol1').feature('s1').feature('se1').feature('ll1').set('lowerlimit', 'comp1.T 0 ');
model.sol('sol1').feature('s1').create('i2', 'Iterative');
model.sol('sol1').feature('s1').feature('i2').set('linsolver', 'gmres');
model.sol('sol1').feature('s1').feature('i2').set('prefuntype', 'left');
model.sol('sol1').feature('s1').feature('i2').set('itrestart', 50);
model.sol('sol1').feature('s1').feature('i2').set('rhob', 20);
model.sol('sol1').feature('s1').feature('i2').set('maxlinit', 10000);
model.sol('sol1').feature('s1').feature('i2').set('nlinnormuse', 'on');
model.sol('sol1').feature('s1').feature('i2').label('AMG, heat transfer variables (ht)');
model.sol('sol1').feature('s1').feature('i2').create('mg1', 'Multigrid');
model.sol('sol1').feature('s1').feature('i2').feature('mg1').set('prefun', 'saamg');
model.sol('sol1').feature('s1').feature('i2').feature('mg1').set('mgcycle', 'v');
model.sol('sol1').feature('s1').feature('i2').feature('mg1').set('maxcoarsedof', 50000);
model.sol('sol1').feature('s1').feature('i2').feature('mg1').set('strconn', 0.01);
model.sol('sol1').feature('s1').feature('i2').feature('mg1').set('nullspace', 'constant');
model.sol('sol1').feature('s1').feature('i2').feature('mg1').set('usesmooth', false);
model.sol('sol1').feature('s1').feature('i2').feature('mg1').set('saamgcompwise', true);
model.sol('sol1').feature('s1').feature('i2').feature('mg1').set('loweramg', true);
model.sol('sol1').feature('s1').feature('i2').feature('mg1').set('compactaggregation', false);
model.sol('sol1').feature('s1').feature('i2').feature('mg1').feature('pr').create('so1', 'SOR');
model.sol('sol1').feature('s1').feature('i2').feature('mg1').feature('pr').feature('so1').set('iter', 2);
model.sol('sol1').feature('s1').feature('i2').feature('mg1').feature('pr').feature('so1').set('relax', 0.9);
model.sol('sol1').feature('s1').feature('i2').feature('mg1').feature('po').create('so1', 'SOR');
model.sol('sol1').feature('s1').feature('i2').feature('mg1').feature('po').feature('so1').set('iter', 2);
model.sol('sol1').feature('s1').feature('i2').feature('mg1').feature('po').feature('so1').set('relax', 0.9);
model.sol('sol1').feature('s1').feature('i2').feature('mg1').feature('cs').create('d1', 'Direct');
model.sol('sol1').feature('s1').feature('i2').feature('mg1').feature('cs').feature('d1').set('linsolver', 'pardiso');
model.sol('sol1').feature('s1').feature('i2').feature('mg1').feature('cs').feature('d1').set('pivotperturb', 1.0E-13);
model.sol('sol1').feature('s1').feature.remove('fcDef');
model.sol('sol1').attach('std1');
model.sol('sol1').runAll;

model.result.create('pg1', 'PlotGroup3D');
model.result('pg1').label('Electric Potential (ec)');
model.result('pg1').set('frametype', 'spatial');
model.result('pg1').set('showlegendsmaxmin', true);
model.result('pg1').set('data', 'dset1');
model.result('pg1').set('defaultPlotID', 'InterfaceComponents/PlotDefaults/icom2/pdef1/pcond2/pcond1/pcond2/pg1');
model.result('pg1').feature.create('vol1', 'Volume');
model.result('pg1').feature('vol1').set('showsolutionparams', 'on');
model.result('pg1').feature('vol1').set('solutionparams', 'parent');
model.result('pg1').feature('vol1').set('colortable', 'Dipole');
model.result('pg1').feature('vol1').set('showsolutionparams', 'on');
model.result('pg1').feature('vol1').set('data', 'parent');
model.result.create('pg2', 'PlotGroup3D');
model.result('pg2').label('Electric Field Norm (ec)');
model.result('pg2').set('frametype', 'spatial');
model.result('pg2').set('showlegendsmaxmin', true);
model.result('pg2').set('data', 'dset1');
model.result('pg2').set('defaultPlotID', 'InterfaceComponents/PlotDefaults/icom3/pdef1/pcond2/pcond1/pg1');
model.result('pg2').feature.create('mslc1', 'Multislice');
model.result('pg2').feature('mslc1').set('showsolutionparams', 'on');
model.result('pg2').feature('mslc1').set('solutionparams', 'parent');
model.result('pg2').feature('mslc1').set('expr', 'ec.normE');
model.result('pg2').feature('mslc1').set('multiplanexmethod', 'coord');
model.result('pg2').feature('mslc1').set('xcoord', 'ec.CPx');
model.result('pg2').feature('mslc1').set('multiplaneymethod', 'coord');
model.result('pg2').feature('mslc1').set('ycoord', 'ec.CPy');
model.result('pg2').feature('mslc1').set('multiplanezmethod', 'coord');
model.result('pg2').feature('mslc1').set('zcoord', 'ec.CPz');
model.result('pg2').feature('mslc1').set('colortable', 'Prism');
model.result('pg2').feature('mslc1').set('colortabletrans', 'nonlinear');
model.result('pg2').feature('mslc1').set('colorcalibration', -0.8);
model.result('pg2').feature('mslc1').set('showsolutionparams', 'on');
model.result('pg2').feature('mslc1').set('data', 'parent');
model.result('pg2').feature.create('strmsl1', 'StreamlineMultislice');
model.result('pg2').feature('strmsl1').set('showsolutionparams', 'on');
model.result('pg2').feature('strmsl1').set('solutionparams', 'parent');
model.result('pg2').feature('strmsl1').set('expr', {'ec.Ex' 'ec.Ey' 'ec.Ez'});
model.result('pg2').feature('strmsl1').set('multiplanexmethod', 'coord');
model.result('pg2').feature('strmsl1').set('xcoord', 'ec.CPx');
model.result('pg2').feature('strmsl1').set('multiplaneymethod', 'coord');
model.result('pg2').feature('strmsl1').set('ycoord', 'ec.CPy');
model.result('pg2').feature('strmsl1').set('multiplanezmethod', 'coord');
model.result('pg2').feature('strmsl1').set('zcoord', 'ec.CPz');
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
model.result('pg2').feature('strmsl1').feature('col1').set('expr', 'ec.normE');
model.result('pg2').feature('strmsl1').feature('col1').set('colortable', 'PrismDark');
model.result('pg2').feature('strmsl1').feature('col1').set('colorlegend', false);
model.result('pg2').feature('strmsl1').feature('col1').set('colortabletrans', 'nonlinear');
model.result('pg2').feature('strmsl1').feature('col1').set('colorcalibration', -0.8);
model.result('pg2').feature('strmsl1').feature.create('filt1', 'Filter');
model.result('pg2').feature('strmsl1').feature('filt1').set('expr', '!isScalingSystemDomain');
model.result.create('pg3', 'PlotGroup3D');
model.result('pg3').label('Temperature (ht)');
model.result('pg3').set('data', 'dset1');
model.result('pg3').set('defaultPlotID', 'ht/HT_PhysicsInterfaces/icom8/pdef1/pcond3/pcond3/pg1');
model.result('pg3').feature.create('vol1', 'Volume');
model.result('pg3').feature('vol1').set('showsolutionparams', 'on');
model.result('pg3').feature('vol1').set('solutionparams', 'parent');
model.result('pg3').feature('vol1').set('expr', 'T');
model.result('pg3').feature('vol1').set('colortable', 'HeatCameraLight');
model.result('pg3').feature('vol1').set('smooth', 'internal');
model.result('pg3').feature('vol1').set('showsolutionparams', 'on');
model.result('pg3').feature('vol1').set('data', 'parent');
model.result('pg1').run;
model.result('pg1').run;
model.result('pg3').run;
model.result('pg3').create('arws1', 'ArrowSurface');
model.result('pg3').feature('arws1').set('expr', {'ht.tfluxx' 'ht.tfluxy' 'ht.tfluxz'});
model.result('pg3').feature('arws1').set('descr', 'Total heat flux');
model.result('pg3').feature('arws1').set('arrowcount', '5e3');
model.result('pg3').feature('arws1').set('color', 'black');
model.result('pg3').run;
model.result.create('pg4', 'PlotGroup1D');
model.result('pg4').run;
model.result('pg4').label('Temperature along Copper Routes');
model.result('pg4').create('lngr1', 'LineGraph');
model.result('pg4').feature('lngr1').set('markerpos', 'datapoints');
model.result('pg4').feature('lngr1').set('linewidth', 'preference');
model.result('pg4').feature('lngr1').selection.set([28 41 50 59 65]);
model.result('pg4').feature('lngr1').set('expr', 'T');
model.result('pg4').feature('lngr1').set('descr', 'Temperature');
model.result('pg4').feature('lngr1').set('xdata', 'reversedarc');
model.result('pg4').feature('lngr1').set('legend', true);
model.result('pg4').feature('lngr1').set('legendmethod', 'manual');
model.result('pg4').feature('lngr1').setIndex('legends', 'Base', 0);
model.result('pg4').run;
model.result('pg4').feature.duplicate('lngr2', 'lngr1');
model.result('pg4').run;
model.result('pg4').feature('lngr2').selection.set([14 38 47 56 62]);
model.result('pg4').feature('lngr2').setIndex('legends', 'Collector', 0);
model.result('pg4').run;
model.result('pg4').run;
model.result('pg4').set('titletype', 'none');
model.result('pg4').set('xlabelactive', true);
model.result('pg4').set('xlabel', 'Distance from connector (mm)');
model.result('pg4').run;
model.result('pg3').run;

model.title('Power Transistor');

model.description('This example simulates a system consisting of a small part of a circuit board containing a power transistor and the copper pathways connected to the transistor. The purpose of the simulation is to determine the transistor''s operating temperature, which can be substantially above room temperature due to undesired resistive heating.');

model.mesh.clearMeshes;

model.sol('sol1').clearSolutionData;

model.label('power_transistor.mph');

model.modelNode.label('Components');

out = model;
```

---

## Example 14: three_phase_mixer

**Module:** Mixer_Module_Tutorials_three_phase_mixer  
**Category:** Unknown_Category  

### Model Description

**Model Overview**:
The model simulates the mixing and separation process of a three-phase system consisting of a fluid and two types of particles (light and heavy) within a mixer. The light particles are less dense than the fluid and tend to rise to the top, while the heavy particles are denser and sediment at the bottom. The mixer's impeller action is intended to homogenize the mixture of the three phases.

**Geometry**:
The geometry of the model is not explicitly described in the provided code but is likely a representation of a mixing tank with an impeller. The geometry is imported from a file named 'three_phase_mixer.mphbin', suggesting a complex 3D structure.

**Materials**:
The model includes a material representing water (liquid) with temperature-dependent properties for dynamic viscosity (eta), heat capacity (Cp), density (rho), thermal conductivity (k), sound speed (cs), and other derived properties such as thermal expansion coefficient and bulk viscosity. The properties are defined using piecewise functions, analytic functions, and interpolation tables.

**Physics**:
The model involves two main physics interfaces:
1. Turbulent Flow (spf): This interface models the fluid flow using the k-epsilon turbulence model suitable for simulating the turbulent mixing process.
2. Phase Transport (phtr): This interface models the transport of the two particle phases (light and heavy) within the fluid, considering their respective volume fractions.

Additionally, a Multiphase Flow Mixture Model (mfmm1) is used to couple the fluid flow with the phase transport, accounting for the mixture's viscosity and the slip velocity between phases.

**Boundary Conditions**:
The boundary conditions include:
- A wall boundary condition (wallbc2) applied to a selection of boundaries, likely the mixer's walls, enforcing a no-slip condition.
- A pressure point constraint (prpc1) applied to a point, possibly to set a reference pressure.
- Initial conditions for the volume fractions of the particle phases are set to 0.1 for both light and heavy particles, indicating a homogeneous distribution at the start.

**Mesh**:
The geometry is discretized using a mesh (mesh1) with an automatic mesh size setting of 7, which implies a relatively fine mesh.

**Study**:
The model performs a transient analysis (time-dependent study) with a time list ranging from 0 to 0.5 seconds, with 10 equally spaced time steps.

**Key Parameters**:
- The impeller's rotational velocity is ramped up using a ramp function (rm1) over a period of 1.55 seconds.
- The densities of the light and heavy particles are set to 1100 kg/m^3 and 850 kg/m^3, respectively.
- The mixture viscosity model uses a power-law relationship dependent on the volume fractions of the particles.

**Expected Results**:
The model is expected to predict the spatial distribution and mixing efficiency of the three phases over time, as well as the velocity and pressure fields within the mixer.

**Engineering Application**:
This model can be applied to the design and optimization of mixing processes in various industries, such as chemical processing, pharmaceuticals, and food processing, where efficient mixing of multiple phases is crucial for product quality and process efficiency. The model can help in understanding the effects of impeller design, rotational speed, and particle properties on the mixing and separation behavior.

### COMSOL MATLAB Code

```matlab
function out = model
%
% three_phase_mixer.m
%
% Model exported on May 26 2025, 21:30 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/Mixer_Module/Tutorials');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 3);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.physics.create('spf', 'TurbulentFlowkeps', 'geom1');
model.physics('spf').model('comp1');
model.physics('spf').prop('PhysicalModelProperty').set('Compressibility', 'CompressibleMALT03');
model.physics.create('phtr', 'PhaseTransport', 'geom1', {'s1' 's2'});

model.multiphysics.create('mfmm1', 'MultiphaseFlowMixtureModel', 'geom1', 3);
model.multiphysics('mfmm1').set('multiphaseflow_physics', 'phtr');
model.multiphysics('mfmm1').set('fluidflow_physics', 'spf');
model.multiphysics('mfmm1').selection.all;

model.common.create('rot1', 'RotatingDomain', 'comp1');
model.common('rot1').set('rotationType', 'rotationalVelocity');
model.common('rot1').set('rotationalVelocityExpression', 'generalRevolutionsPerTime');
model.common('rot1').selection.all;

model.study.create('std1');
model.study('std1').create('time', 'Transient');
model.study('std1').feature('time').setSolveFor('/physics/spf', true);
model.study('std1').feature('time').setSolveFor('/physics/phtr', true);
model.study('std1').feature('time').setSolveFor('/multiphysics/mfmm1', true);

model.geom('geom1').create('imp1', 'Import');
model.geom('geom1').feature('imp1').set('filename', 'three_phase_mixer.mphbin');
model.geom('geom1').feature('fin').set('action', 'assembly');

model.func.create('rm1', 'Ramp');
model.func('rm1').model('comp1');
model.func('rm1').set('location', 1.55);
model.func('rm1').set('cutoffactive', true);
model.func('rm1').set('smoothzonelocactive', true);

model.geom('geom1').run;

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

model.common('rot1').selection.set([2]);
model.common('rot1').set('revolutionsPerTime', '100[rpm]*rm1(t*1[1/s])');

model.physics('spf').prop('PhysicalModelProperty').set('IncludeGravity', true);
model.physics('spf').create('wallbc2', 'WallBC', 2);
model.physics('spf').feature('wallbc2').selection.set([13]);
model.physics('spf').feature('wallbc2').set('TranslationalVelocityOption', 'ZeroFixedWall');
model.physics('spf').create('prpc1', 'PressurePointConstraint', 0);
model.physics('spf').feature('prpc1').selection.set([2]);
model.physics('phtr').field('volumefraction').component({'s1' 's2' 's3'});
model.physics('phtr').feature('init1').setIndex('s0', 0.1, 1);
model.physics('phtr').feature('init1').setIndex('s0', 0.1, 2);

model.multiphysics('mfmm1').set('mumixture', 'mfmm1.muc*max(1-max(0,min(s2+s3,0.999*0.62))/0.62,eps)^(-2.5*0.62)');
model.multiphysics('mfmm1').set('SlipModel', 'HadamardRybczynski');
model.multiphysics('mfmm1').set('rho_s2_mat', 'userdef');
model.multiphysics('mfmm1').set('rho_s2', '1100[kg/m^3]');
model.multiphysics('mfmm1').set('rho_s3_mat', 'userdef');
model.multiphysics('mfmm1').set('rho_s3', '850[kg/m^3]');

model.mesh('mesh1').autoMeshSize(7);

model.study('std1').feature('time').set('tlist', 'range(0,0.5,10)');

model.sol.create('sol1');

model.mesh('mesh1').stat.selection.geom(3);
model.mesh('mesh1').stat.selection.set([1 2]);
model.mesh('mesh1').stat.selection.geom(3);
model.mesh('mesh1').stat.selection.set([1 2]);
model.mesh('mesh1').stat.selection.geom(3);
model.mesh('mesh1').stat.selection.set([1 2]);

model.sol('sol1').study('std1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'time');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').feature('comp1_s2').set('scalemethod', 'manual');
model.sol('sol1').feature('v1').feature('comp1_s3').set('scalemethod', 'manual');
model.sol('sol1').feature('v1').feature('comp1_ode1').set('scalemethod', 'manual');
model.sol('sol1').feature('v1').feature('comp1_s2').set('scaleval', '1');
model.sol('sol1').feature('v1').feature('comp1_s3').set('scaleval', '1');
model.sol('sol1').feature('v1').feature('comp1_ode1').set('scaleval', '1');
model.sol('sol1').feature('v1').set('control', 'time');
model.sol('sol1').create('t1', 'Time');
model.sol('sol1').feature('t1').set('tlist', 'range(0,0.5,10)');
model.sol('sol1').feature('t1').set('plot', 'off');
model.sol('sol1').feature('t1').set('plotgroup', 'Default');
model.sol('sol1').feature('t1').set('plotfreq', 'tout');
model.sol('sol1').feature('t1').set('probesel', 'all');
model.sol('sol1').feature('t1').set('probes', {});
model.sol('sol1').feature('t1').set('probefreq', 'tsteps');
model.sol('sol1').feature('t1').set('rtol', 0.005);
model.sol('sol1').feature('t1').set('atolglobalmethod', 'scaled');
model.sol('sol1').feature('t1').set('atolglobalfactor', 0.05);
model.sol('sol1').feature('t1').set('atolglobalvaluemethod', 'factor');
model.sol('sol1').feature('t1').set('atolmethod', {'comp1_ep' 'unscaled' 'comp1_k' 'unscaled' 'comp1_p' 'scaled' 'comp1_s2' 'global' 'comp1_s3' 'global'  ...
'comp1_u' 'global' 'comp1_ode1' 'global'});
model.sol('sol1').feature('t1').set('atol', {'comp1_ep' '0.09*sqrt((0.01*1)^3)/(0.035*0.6364008902903789)' 'comp1_k' '(0.01*1)^2' 'comp1_p' '1e-3' 'comp1_s2' '1e-3' 'comp1_s3' '1e-3'  ...
'comp1_u' '1e-3' 'comp1_ode1' '1e-3'});
model.sol('sol1').feature('t1').set('atolvaluemethod', {'comp1_ep' 'manual' 'comp1_k' 'manual' 'comp1_p' 'factor' 'comp1_s2' 'factor' 'comp1_s3' 'factor'  ...
'comp1_u' 'factor' 'comp1_ode1' 'factor'});
model.sol('sol1').feature('t1').set('atolfactor', {'comp1_ep' '0.1' 'comp1_k' '0.1' 'comp1_p' '1' 'comp1_s2' '0.1' 'comp1_s3' '0.1'  ...
'comp1_u' '0.1' 'comp1_ode1' '0.1'});
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
model.sol('sol1').feature('t1').feature('se1').feature('ss1').set('segvar', {'comp1_ode1'});
model.sol('sol1').feature('t1').feature('se1').feature('ss1').set('subdamp', 1);
model.sol('sol1').feature('t1').feature('se1').feature('ss1').set('subntolfact', 0.1);
model.sol('sol1').feature('t1').feature('se1').feature('ss1').set('subjtech', 'onevery');
model.sol('sol1').feature('t1').feature('se1').feature('ss1').set('subtermconst', 'iter');
model.sol('sol1').feature('t1').feature('se1').feature('ss1').set('subiter', 1);
model.sol('sol1').feature('t1').create('d1', 'Direct');
model.sol('sol1').feature('t1').feature('d1').set('linsolver', 'pardiso');
model.sol('sol1').feature('t1').feature('d1').set('pivotperturb', 1.0E-13);
model.sol('sol1').feature('t1').feature('d1').label('Direct, angular displacement (spf)');
model.sol('sol1').feature('t1').feature('se1').feature('ss1').set('linsolver', 'd1');
model.sol('sol1').feature('t1').feature('se1').feature('ss1').label('Angular Displacement');
model.sol('sol1').feature('t1').feature('se1').create('ss2', 'SegregatedStep');
model.sol('sol1').feature('t1').feature('se1').feature('ss2').set('segvar', {'comp1_u' 'comp1_p'});
model.sol('sol1').feature('t1').feature('se1').feature('ss2').set('subdamp', 0.8);
model.sol('sol1').feature('t1').feature('se1').feature('ss2').set('subjtech', 'once');
model.sol('sol1').feature('t1').create('d2', 'Direct');
model.sol('sol1').feature('t1').feature('d2').set('linsolver', 'pardiso');
model.sol('sol1').feature('t1').feature('d2').set('pivotperturb', 1.0E-13);
model.sol('sol1').feature('t1').feature('d2').label('Direct, fluid flow variables (spf)');
model.sol('sol1').feature('t1').feature('se1').feature('ss2').set('linsolver', 'd2');
model.sol('sol1').feature('t1').feature('se1').feature('ss2').label('Velocity u, Pressure p');
model.sol('sol1').feature('t1').feature('se1').create('ss3', 'SegregatedStep');
model.sol('sol1').feature('t1').feature('se1').feature('ss3').set('segvar', {'comp1_k' 'comp1_ep'});
model.sol('sol1').feature('t1').feature('se1').feature('ss3').set('subdamp', 0.8);
model.sol('sol1').feature('t1').feature('se1').feature('ss3').set('subiter', 1);
model.sol('sol1').feature('t1').feature('se1').feature('ss3').set('subtermconst', 'iter');
model.sol('sol1').feature('t1').feature('se1').feature('ss3').set('subjtech', 'onevery');
model.sol('sol1').feature('t1').feature('se1').feature('ss3').set('subntolfact', 0.1);
model.sol('sol1').feature('t1').create('d3', 'Direct');
model.sol('sol1').feature('t1').feature('d3').set('linsolver', 'pardiso');
model.sol('sol1').feature('t1').feature('d3').set('pivotperturb', 1.0E-13);
model.sol('sol1').feature('t1').feature('d3').label('Direct, turbulence variables (spf)');
model.sol('sol1').feature('t1').feature('se1').feature('ss3').set('linsolver', 'd3');
model.sol('sol1').feature('t1').feature('se1').feature('ss3').label('Turbulence Variables');
model.sol('sol1').feature('t1').feature('se1').create('ss4', 'SegregatedStep');
model.sol('sol1').feature('t1').feature('se1').feature('ss4').set('segvar', {'comp1_s2' 'comp1_s3'});
model.sol('sol1').feature('t1').feature('se1').feature('ss4').set('subjtech', 'once');
model.sol('sol1').feature('t1').feature('se1').feature('ss4').set('subdamp', 0.8);
model.sol('sol1').feature('t1').feature('se1').feature('ss4').set('subiter', 1);
model.sol('sol1').feature('t1').feature('se1').feature('ss4').set('subntolfact', 0.1);
model.sol('sol1').feature('t1').feature('se1').feature('ss4').set('subtermconst', 'iter');
model.sol('sol1').feature('t1').create('d4', 'Direct');
model.sol('sol1').feature('t1').feature('d4').set('linsolver', 'pardiso');
model.sol('sol1').feature('t1').feature('d4').set('pivotperturb', 1.0E-13);
model.sol('sol1').feature('t1').feature('d4').label('Direct, volume fractions (phtr)');
model.sol('sol1').feature('t1').feature('se1').feature('ss4').set('linsolver', 'd4');
model.sol('sol1').feature('t1').feature('se1').feature('ss4').label('Volume Fractions');
model.sol('sol1').feature('t1').feature('se1').set('ntolfact', 0.5);
model.sol('sol1').feature('t1').feature('se1').set('maxsegiter', 10);
model.sol('sol1').feature('t1').feature('se1').set('segstabacc', 'segaacc');
model.sol('sol1').feature('t1').feature('se1').set('segaaccdim', 5);
model.sol('sol1').feature('t1').feature('se1').set('segaaccdelay', 0);
model.sol('sol1').feature('t1').feature('se1').set('segaaccmix', 0.9);
model.sol('sol1').feature('t1').feature('se1').create('ll1', 'LowerLimit');
model.sol('sol1').feature('t1').feature('se1').feature('ll1').set('lowerlimit', 'comp1.k 0 comp1.ep 0 ');
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
model.sol('sol1').feature('t1').feature('i2').set('rhob', 20);
model.sol('sol1').feature('t1').feature('i2').set('maxlinit', 200);
model.sol('sol1').feature('t1').feature('i2').set('nlinnormuse', 'on');
model.sol('sol1').feature('t1').feature('i2').label('AMG, turbulence variables (spf)');
model.sol('sol1').feature('t1').feature('i2').create('mg1', 'Multigrid');
model.sol('sol1').feature('t1').feature('i2').feature('mg1').set('prefun', 'saamg');
model.sol('sol1').feature('t1').feature('i2').feature('mg1').set('mgcycle', 'v');
model.sol('sol1').feature('t1').feature('i2').feature('mg1').set('maxcoarsedof', 50000);
model.sol('sol1').feature('t1').feature('i2').feature('mg1').set('strconn', 0.01);
model.sol('sol1').feature('t1').feature('i2').feature('mg1').set('nullspace', 'constant');
model.sol('sol1').feature('t1').feature('i2').feature('mg1').set('usesmooth', false);
model.sol('sol1').feature('t1').feature('i2').feature('mg1').set('saamgcompwise', true);
model.sol('sol1').feature('t1').feature('i2').feature('mg1').set('loweramg', true);
model.sol('sol1').feature('t1').feature('i2').feature('mg1').set('compactaggregation', false);
model.sol('sol1').feature('t1').feature('i2').feature('mg1').feature('pr').create('sl1', 'SORLine');
model.sol('sol1').feature('t1').feature('i2').feature('mg1').feature('pr').feature('sl1').set('linesweeptype', 'ssor');
model.sol('sol1').feature('t1').feature('i2').feature('mg1').feature('pr').feature('sl1').set('iter', 0);
model.sol('sol1').feature('t1').feature('i2').feature('mg1').feature('pr').feature('sl1').set('linerelax', 0.7);
model.sol('sol1').feature('t1').feature('i2').feature('mg1').feature('pr').feature('sl1').set('linealgorithm', 'mesh');
model.sol('sol1').feature('t1').feature('i2').feature('mg1').feature('pr').feature('sl1').set('linemethod', 'uncoupled');
model.sol('sol1').feature('t1').feature('i2').feature('mg1').feature('pr').feature('sl1').set('seconditer', 1);
model.sol('sol1').feature('t1').feature('i2').feature('mg1').feature('pr').feature('sl1').set('relax', 0.5);
model.sol('sol1').feature('t1').feature('i2').feature('mg1').feature('po').create('sl1', 'SORLine');
model.sol('sol1').feature('t1').feature('i2').feature('mg1').feature('po').feature('sl1').set('linesweeptype', 'ssor');
model.sol('sol1').feature('t1').feature('i2').feature('mg1').feature('po').feature('sl1').set('iter', 1);
model.sol('sol1').feature('t1').feature('i2').feature('mg1').feature('po').feature('sl1').set('linerelax', 0.7);
model.sol('sol1').feature('t1').feature('i2').feature('mg1').feature('po').feature('sl1').set('linealgorithm', 'mesh');
model.sol('sol1').feature('t1').feature('i2').feature('mg1').feature('po').feature('sl1').set('linemethod', 'uncoupled');
model.sol('sol1').feature('t1').feature('i2').feature('mg1').feature('po').feature('sl1').set('seconditer', 1);
model.sol('sol1').feature('t1').feature('i2').feature('mg1').feature('po').feature('sl1').set('relax', 0.5);
model.sol('sol1').feature('t1').feature('i2').feature('mg1').feature('cs').create('d1', 'Direct');
model.sol('sol1').feature('t1').feature('i2').feature('mg1').feature('cs').feature('d1').set('linsolver', 'pardiso');
model.sol('sol1').feature('t1').feature('i2').feature('mg1').feature('cs').feature('d1').set('pivotperturb', 1.0E-13);
model.sol('sol1').feature('t1').create('i3', 'Iterative');
model.sol('sol1').feature('t1').feature('i3').set('linsolver', 'gmres');
model.sol('sol1').feature('t1').feature('i3').set('prefuntype', 'left');
model.sol('sol1').feature('t1').feature('i3').set('itrestart', 50);
model.sol('sol1').feature('t1').feature('i3').set('rhob', 20);
model.sol('sol1').feature('t1').feature('i3').set('maxlinit', 50);
model.sol('sol1').feature('t1').feature('i3').set('nlinnormuse', 'on');
model.sol('sol1').feature('t1').feature('i3').label('AMG, volume fractions (phtr)');
model.sol('sol1').feature('t1').feature('i3').create('mg1', 'Multigrid');
model.sol('sol1').feature('t1').feature('i3').feature('mg1').set('prefun', 'saamg');
model.sol('sol1').feature('t1').feature('i3').feature('mg1').set('mgcycle', 'v');
model.sol('sol1').feature('t1').feature('i3').feature('mg1').set('maxcoarsedof', 50000);
model.sol('sol1').feature('t1').feature('i3').feature('mg1').set('strconn', 0.01);
model.sol('sol1').feature('t1').feature('i3').feature('mg1').set('nullspace', 'constant');
model.sol('sol1').feature('t1').feature('i3').feature('mg1').set('usesmooth', false);
model.sol('sol1').feature('t1').feature('i3').feature('mg1').set('saamgcompwise', false);
model.sol('sol1').feature('t1').feature('i3').feature('mg1').set('loweramg', true);
model.sol('sol1').feature('t1').feature('i3').feature('mg1').set('compactaggregation', false);
model.sol('sol1').feature('t1').feature('i3').feature('mg1').feature('pr').create('sl1', 'SORLine');
model.sol('sol1').feature('t1').feature('i3').feature('mg1').feature('pr').feature('sl1').set('linesweeptype', 'sor');
model.sol('sol1').feature('t1').feature('i3').feature('mg1').feature('pr').feature('sl1').set('iter', 1);
model.sol('sol1').feature('t1').feature('i3').feature('mg1').feature('pr').feature('sl1').set('linerelax', 0.6);
model.sol('sol1').feature('t1').feature('i3').feature('mg1').feature('pr').feature('sl1').set('linealgorithm', 'matrix');
model.sol('sol1').feature('t1').feature('i3').feature('mg1').feature('pr').feature('sl1').set('linemethod', 'uncoupled');
model.sol('sol1').feature('t1').feature('i3').feature('mg1').feature('pr').feature('sl1').set('seconditer', 1);
model.sol('sol1').feature('t1').feature('i3').feature('mg1').feature('pr').feature('sl1').set('relax', 0.4);
model.sol('sol1').feature('t1').feature('i3').feature('mg1').feature('pr').feature('sl1').set('maxline', 15);
model.sol('sol1').feature('t1').feature('i3').feature('mg1').feature('po').create('sl1', 'SORLine');
model.sol('sol1').feature('t1').feature('i3').feature('mg1').feature('po').feature('sl1').set('linesweeptype', 'soru');
model.sol('sol1').feature('t1').feature('i3').feature('mg1').feature('po').feature('sl1').set('iter', 1);
model.sol('sol1').feature('t1').feature('i3').feature('mg1').feature('po').feature('sl1').set('linerelax', 0.6);
model.sol('sol1').feature('t1').feature('i3').feature('mg1').feature('po').feature('sl1').set('linealgorithm', 'matrix');
model.sol('sol1').feature('t1').feature('i3').feature('mg1').feature('po').feature('sl1').set('linemethod', 'uncoupled');
model.sol('sol1').feature('t1').feature('i3').feature('mg1').feature('po').feature('sl1').set('seconditer', 1);
model.sol('sol1').feature('t1').feature('i3').feature('mg1').feature('po').feature('sl1').set('relax', 0.4);
model.sol('sol1').feature('t1').feature('i3').feature('mg1').feature('po').feature('sl1').set('maxline', 15);
model.sol('sol1').feature('t1').feature('i3').feature('mg1').feature('cs').create('d1', 'Direct');
model.sol('sol1').feature('t1').feature('i3').feature('mg1').feature('cs').feature('d1').set('linsolver', 'pardiso');
model.sol('sol1').feature('t1').feature('i3').feature('mg1').feature('cs').feature('d1').set('pivotperturb', 1.0E-13);
model.sol('sol1').feature('t1').feature.remove('fcDef');
model.sol('sol1').feature('t1').feature.remove('seDef');
model.sol('sol1').attach('std1');
model.sol('sol1').feature('t1').set('tstepsbdf', 'strict');
model.sol('sol1').feature('t1').set('bwinitstepfrac', 1);
model.sol('sol1').feature('t1').feature('se1').feature('ss2').set('subjtech', 'onevery');
model.sol('sol1').feature('t1').feature('se1').feature('ss4').set('subjtech', 'onevery');
model.sol('sol1').runAll;

model.result.dataset('dset1').set('geom', 'geom1');
model.result.create('pg1', 'PlotGroup3D');
model.result('pg1').label('Velocity (spf)');
model.result('pg1').set('frametype', 'spatial');
model.result('pg1').set('data', 'dset1');
model.result('pg1').setIndex('looplevel', 21, 0);
model.result('pg1').set('defaultPlotID', 'ResultDefaults_SinglePhaseFlow/icom1/pdef1/pcond2/pg1');
model.result('pg1').feature.create('slc1', 'Slice');
model.result('pg1').feature('slc1').label('Slice');
model.result('pg1').feature('slc1').set('showsolutionparams', 'on');
model.result('pg1').feature('slc1').set('smooth', 'internal');
model.result('pg1').feature('slc1').set('showsolutionparams', 'on');
model.result('pg1').feature('slc1').set('data', 'parent');
model.result.dataset.create('surf1', 'Surface');
model.result.dataset('surf1').label('Exterior Walls');
model.result.dataset('surf1').set('data', 'dset1');
model.result.dataset('surf1').selection.geom('geom1', 2);
model.result.dataset('surf1').selection.set([1 2 3 4 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34]);
model.result.create('pg2', 'PlotGroup3D');
model.result('pg2').label('Pressure (spf)');
model.result('pg2').set('data', 'surf1');
model.result('pg2').setIndex('looplevel', 21, 0);
model.result('pg2').set('frametype', 'spatial');
model.result('pg2').set('data', 'surf1');
model.result('pg2').setIndex('looplevel', 21, 0);
model.result('pg2').set('defaultPlotID', 'ResultDefaults_SinglePhaseFlow/icom1/pdef1/pcond2/pcond1/pcond1/pg4');
model.result('pg2').feature.create('surf1', 'Surface');
model.result('pg2').feature('surf1').label('Surface');
model.result('pg2').feature('surf1').set('showsolutionparams', 'on');
model.result('pg2').feature('surf1').set('expr', 'p');
model.result('pg2').feature('surf1').set('colortable', 'Dipole');
model.result('pg2').feature('surf1').set('smooth', 'internal');
model.result('pg2').feature('surf1').set('showsolutionparams', 'on');
model.result('pg2').feature('surf1').set('data', 'parent');
model.result('pg2').feature('surf1').feature.create('tran1', 'Transparency');
model.result.create('pg3', 'PlotGroup3D');
model.result('pg3').label('Wall Resolution (spf)');
model.result('pg3').set('data', 'surf1');
model.result('pg3').setIndex('looplevel', 21, 0);
model.result('pg3').set('frametype', 'spatial');
model.result('pg3').set('data', 'surf1');
model.result('pg3').setIndex('looplevel', 21, 0);
model.result('pg3').set('defaultPlotID', 'ResultDefaults_SinglePhaseFlow/icom1/pdef1/pcond2/pcond1/pcond1/pg3');
model.result('pg3').feature.create('surf1', 'Surface');
model.result('pg3').feature('surf1').label('Wall Resolution');
model.result('pg3').feature('surf1').set('showsolutionparams', 'on');
model.result('pg3').feature('surf1').set('expr', 'spf.Delta_wPlus');
model.result('pg3').feature('surf1').set('smooth', 'internal');
model.result('pg3').feature('surf1').set('showsolutionparams', 'on');
model.result('pg3').feature('surf1').set('data', 'parent');
model.result.create('pg4', 'PlotGroup3D');
model.result('pg4').label('Volume Fraction (phtr)');
model.result('pg4').set('data', 'dset1');
model.result('pg4').setIndex('looplevel', 21, 0);
model.result('pg4').set('defaultPlotID', 'ResultDefaults_Phtr/icom2/pdef1/pcond1/pg1');
model.result('pg4').feature.create('slc1', 'Slice');
model.result('pg4').feature('slc1').label('Slice');
model.result('pg4').feature('slc1').set('showsolutionparams', 'on');
model.result('pg4').feature('slc1').set('expr', 's1');
model.result('pg4').feature('slc1').set('smooth', 'internal');
model.result('pg4').feature('slc1').set('showsolutionparams', 'on');
model.result('pg4').feature('slc1').set('data', 'parent');
model.result.create('pg5', 'PlotGroup3D');
model.result('pg5').label('Volume Fraction (phtr) 1');
model.result('pg5').set('data', 'dset1');
model.result('pg5').setIndex('looplevel', 21, 0);
model.result('pg5').set('defaultPlotID', 'ResultDefaults_Phtr/icom2/pdef1/pcond1/pg2');
model.result('pg5').feature.create('surf1', 'Surface');
model.result('pg5').feature('surf1').label('Surface');
model.result('pg5').feature('surf1').set('showsolutionparams', 'on');
model.result('pg5').feature('surf1').set('expr', 's1');
model.result('pg5').feature('surf1').set('smooth', 'internal');
model.result('pg5').feature('surf1').set('showsolutionparams', 'on');
model.result('pg5').feature('surf1').set('data', 'parent');
model.result('pg1').run;

model.view('view1').set('transparency', true);
model.view('view1').set('uniformblending', true);
model.view('view1').set('transparency', false);

model.result.dataset.create('cpl1', 'CutPlane');
model.result.dataset('cpl1').set('quickplane', 'xz');
model.result.create('pg6', 'PlotGroup2D');
model.result('pg6').run;
model.result('pg6').set('data', 'cpl1');
model.result('pg6').create('surf1', 'Surface');
model.result('pg6').feature('surf1').set('expr', 's2');
model.result('pg6').feature('surf1').set('rangecoloractive', true);
model.result('pg6').feature('surf1').set('rangecolormax', 0.62);
model.result('pg6').feature('surf1').set('colortable', 'JupiterAuroraBorealis');
model.result('pg6').feature('surf1').set('colortabletrans', 'reverse');
model.result('pg6').run;
model.result('pg6').set('plotarrayenable', true);
model.result('pg6').set('arrayshape', 'square');
model.result('pg6').set('order', 'columnmajor');
model.result('pg6').setIndex('looplevel', 4, 0);
model.result('pg6').feature('surf1').set('arraydim', '2');
model.result('pg6').run;
model.result('pg6').feature.duplicate('surf2', 'surf1');
model.result('pg6').feature('surf2').set('arraydim', '2');
model.result('pg6').run;
model.result('pg6').feature('surf2').set('data', 'cpl1');
model.result('pg6').feature('surf2').setIndex('looplevel', 3, 0);
model.result('pg6').feature('surf2').set('inheritplot', 'surf1');
model.result('pg6').feature.duplicate('surf3', 'surf2');
model.result('pg6').feature('surf3').set('arraydim', '2');
model.result('pg6').run;
model.result('pg6').feature('surf3').setIndex('looplevel', 2, 0);
model.result('pg6').feature('surf1').set('arraydim', '2');
model.result('pg6').run;
model.result('pg6').feature.duplicate('surf4', 'surf1');
model.result('pg6').feature('surf4').set('arraydim', '2');
model.result('pg6').run;
model.result('pg6').feature('surf4').set('expr', 's3');
model.result('pg6').feature('surf4').set('inheritplot', 'surf1');
model.result('pg6').feature.duplicate('surf5', 'surf4');
model.result('pg6').feature('surf5').set('arraydim', '2');
model.result('pg6').run;
model.result('pg6').feature('surf5').set('data', 'cpl1');
model.result('pg6').feature('surf5').setIndex('looplevel', 3, 0);
model.result('pg6').feature.duplicate('surf6', 'surf5');
model.result('pg6').feature('surf6').set('arraydim', '2');
model.result('pg6').run;
model.result('pg6').feature('surf6').setIndex('looplevel', 2, 0);
model.result('pg6').run;

model.view('view3').set('showgrid', false);

model.result('pg6').set('titletype', 'none');
model.result('pg1').run;
model.result('pg1').run;
model.result('pg1').feature('slc1').set('quickplane', 'xy');
model.result('pg1').feature('slc1').set('quickznumber', 3);
model.result('pg1').feature('slc1').set('interactive', true);
model.result('pg1').feature('slc1').set('shift', 0.03);
model.result('pg1').run;
model.result('pg1').create('arwv1', 'ArrowVolume');
model.result('pg1').feature('arwv1').set('xnumber', 10);
model.result('pg1').feature('arwv1').set('ynumber', 10);
model.result('pg1').feature('arwv1').set('arrowzmethod', 'coord');
model.result('pg1').feature('arwv1').set('zcoord', '0.08 0.18 0.28');
model.result('pg1').run;
model.result('pg1').create('surf1', 'Surface');
model.result('pg1').feature('surf1').create('sel1', 'Selection');
model.result('pg1').feature('surf1').feature('sel1').selection.set([2 3 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34]);
model.result('pg1').run;
model.result('pg1').feature('surf1').create('mtrl1', 'MaterialAppearance');
model.result('pg1').run;
model.result('pg1').feature('surf1').feature('mtrl1').set('appearance', 'custom');
model.result('pg1').feature('surf1').feature('mtrl1').set('family', 'steel');
model.result('pg1').run;
model.result('pg1').setIndex('looplevel', 9, 0);
model.result('pg1').run;
model.result('pg1').setIndex('looplevel', 21, 0);
model.result('pg1').run;
model.result('pg4').run;
model.result('pg4').set('frametype', 'spatial');
model.result('pg4').run;
model.result('pg4').feature('slc1').set('expr', 's2');
model.result('pg4').feature('slc1').set('quickxnumber', 1);
model.result('pg4').feature('slc1').set('coloring', 'gradient');
model.result('pg4').feature('slc1').set('bottomcolor', 'blue');
model.result('pg4').feature('slc1').set('colortabletrans', 'reverse');
model.result('pg4').feature('slc1').set('rangecoloractive', true);
model.result('pg4').feature('slc1').set('rangecolormin', 0);
model.result('pg4').feature('slc1').set('rangecolormax', 0.62);
model.result('pg4').feature.duplicate('slc2', 'slc1');
model.result('pg4').run;
model.result('pg4').feature('slc2').set('expr', 's3');
model.result('pg4').feature('slc2').set('quickplane', 'zx');
model.result('pg4').feature('slc2').set('quickynumber', 1);
model.result('pg4').feature('slc2').set('bottomcolor', 'red');
model.result('pg1').run;
model.result('pg1').feature.duplicate('surf2', 'surf1');
model.result('pg1').run;
model.result('pg4').feature.copy('surf2', 'pg1/surf2');
model.result('pg1').feature.remove('surf2');
model.result('pg4').run;
model.result('pg4').setIndex('looplevel', 7, 0);
model.result('pg4').run;
model.result('pg4').setIndex('looplevel', 11, 0);
model.result('pg4').run;
model.result('pg4').setIndex('looplevel', 15, 0);
model.result('pg4').run;
model.result('pg4').setIndex('looplevel', 19, 0);
model.result('pg4').run;
model.result('pg5').run;
model.result('pg5').set('frametype', 'spatial');
model.result('pg1').run;
model.result('pg1').set('view', 'view4');
model.result('pg1').run;

model.title('Three-Phase Mixer');

model.description('This model simulates the separation and mixing of a suspension with light and heavy particles. Initially the distribution of both particle populations is homogeneous throughout the fluid. Before the impeller starts rotating, the fluid and the two particle populations tend to separate since the light particles rise to the top of the tank and the heavy particles sediment at the bottom. When the suspension is stirred, the three phases mix again.');

model.mesh.clearMeshes;

model.sol('sol1').clearSolutionData;

model.label('three_phase_mixer.mph');

model.modelNode.label('Components');

out = model;
```

---

## Example 15: power_inductor

**Module:** ACDC_Module_Devices,_Inductive_power_inductor  
**Category:** Unknown_Category  

### Model Description

**Model Overview**:
The model simulates the inductance of a power inductor, which is a critical component in low-frequency power applications such as switched power supplies for computer motherboards and other components. The simulation focuses on extracting the inductance using the Terminal boundary condition and compares solutions with and without gauge fixing.

**Geometry**:
The geometric setup involves a block with dimensions 0.2 m x 0.15 m x 0.12 m, positioned at [-0.1, -0.08, -0.04]. The geometry is imported from a file named "power_inductor.mphbin".

**Materials**:
Two main materials are used in the model:

1. Copper (mat1): Key properties include a relative permeability of 1, an electrical conductivity of 5.998e7 S/m, a thermal expansion coefficient of 17e-6 1/K, a heat capacity of 385 J/(kg*K), a relative permittivity of 1, a density of 8960 kg/m^3, and a thermal conductivity of 400 W/(m*K).
2. Air (mat2): Key properties are defined by functions of temperature and pressure, including dynamic viscosity, thermal conductivity, heat capacity, density, and speed of sound. The relative permeability and permittivity are set to 1.

**Physics**:
The model uses the Electric Induction Currents (mef) physics interface under the AC/DC Module. The equations involved are not explicitly stated in the provided code but typically include Maxwell's equations for the magnetic vector potential and electric scalar potential.

**Boundary Conditions**:
Boundary conditions include:

1. Electric Insulation (ein1): Applied to boundaries 1, 2, 3, 4, 5, and 79.
2. Terminal (term1): Applied to boundary 17, with the Terminal Type set to Voltage.

**Mesh**:
The geometry is discretized using a mesh with a custom size setting for the core material (boundary 2) with a maximum element size of 5 mm. Additionally, boundary layers are applied to several boundaries with 2 layers and a minimum thickness of 0.5 mm.

**Study**:
The analysis is a frequency-domain study, solving for a single frequency of 1 kHz. Two studies are performed: one with an ungauged formulation and the other with a gauged formulation.

**Key Parameters**:
Important parameters include the frequency of 1 kHz, the material properties, and the boundary conditions. The model also includes parameters for the iterative solver, such as the linear solver (GMRES), the nonlinear relaxation factor (rhob), and the use of multigrid and Vanka preconditioners.

**Expected Results**:
The model predicts the inductance of the power inductor and the distribution of the electric potential and electric field within the device. The results are compared for the ungauged and gauged formulations.

**Engineering Application**:
This model addresses the real-world engineering problem of designing and optimizing power inductors for efficient power conversion in electronic devices. By accurately predicting the inductance and electromagnetic fields, engineers can improve the performance and reliability of power supplies in various applications.

### COMSOL MATLAB Code

```matlab
function out = model
%
% power_inductor.m
%
% Model exported on May 26 2025, 21:24 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/ACDC_Module/Devices,_Inductive');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 3);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.physics.create('mef', 'ElectricInductionCurrents', 'geom1');
model.physics('mef').model('comp1');

model.study.create('std1');
model.study('std1').create('freq', 'Frequency');
model.study('std1').feature('freq').setSolveFor('/physics/mef', true);

model.geom('geom1').create('imp1', 'Import');
model.geom('geom1').feature('imp1').set('filename', 'power_inductor.mphbin');
model.geom('geom1').feature('imp1').importData;
model.geom('geom1').create('blk1', 'Block');
model.geom('geom1').feature('blk1').set('size', [0.2 0.15 0.12]);
model.geom('geom1').feature('blk1').set('pos', [-0.1 -0.08 -0.04]);
model.geom('geom1').runPre('fin');

model.view('view1').set('renderwireframe', true);

model.geom('geom1').run;

model.material.create('mat1', 'Common', 'comp1');
model.material('mat1').propertyGroup.create('Enu', 'Young''s modulus and Poisson''s ratio');
model.material('mat1').propertyGroup.create('linzRes', 'Linearized resistivity');
model.material('mat1').label('Copper');
model.material('mat1').set('family', 'copper');
model.material('mat1').propertyGroup('def').set('relpermeability', {'1' '0' '0' '0' '1' '0' '0' '0' '1'});
model.material('mat1').propertyGroup('def').set('electricconductivity', {'5.998e7[S/m]' '0' '0' '0' '5.998e7[S/m]' '0' '0' '0' '5.998e7[S/m]'});
model.material('mat1').propertyGroup('def').set('thermalexpansioncoefficient', {'17e-6[1/K]' '0' '0' '0' '17e-6[1/K]' '0' '0' '0' '17e-6[1/K]'});
model.material('mat1').propertyGroup('def').set('heatcapacity', '385[J/(kg*K)]');
model.material('mat1').propertyGroup('def').set('relpermittivity', {'1' '0' '0' '0' '1' '0' '0' '0' '1'});
model.material('mat1').propertyGroup('def').set('density', '8960[kg/m^3]');
model.material('mat1').propertyGroup('def').set('thermalconductivity', {'400[W/(m*K)]' '0' '0' '0' '400[W/(m*K)]' '0' '0' '0' '400[W/(m*K)]'});
model.material('mat1').propertyGroup('Enu').set('E', '110[GPa]');
model.material('mat1').propertyGroup('Enu').set('nu', '0.35');
model.material('mat1').propertyGroup('linzRes').set('rho0', '1.72e-8[ohm*m]');
model.material('mat1').propertyGroup('linzRes').set('alpha', '0.0039[1/K]');
model.material('mat1').propertyGroup('linzRes').set('Tref', '298[K]');
model.material('mat1').propertyGroup('linzRes').addInput('temperature');
model.material.create('mat2', 'Common', 'comp1');
model.material('mat2').propertyGroup('def').func.create('eta', 'Piecewise');
model.material('mat2').propertyGroup('def').func.create('Cp', 'Piecewise');
model.material('mat2').propertyGroup('def').func.create('rho', 'Analytic');
model.material('mat2').propertyGroup('def').func.create('k', 'Piecewise');
model.material('mat2').propertyGroup('def').func.create('cs', 'Analytic');
model.material('mat2').propertyGroup('def').func.create('an1', 'Analytic');
model.material('mat2').propertyGroup('def').func.create('an2', 'Analytic');
model.material('mat2').propertyGroup.create('RefractiveIndex', 'Refractive index');
model.material('mat2').propertyGroup.create('NonlinearModel', 'Nonlinear model');
model.material('mat2').propertyGroup.create('idealGas', 'Ideal gas');
model.material('mat2').propertyGroup('idealGas').func.create('Cp', 'Piecewise');
model.material('mat2').label('Air');
model.material('mat2').set('family', 'air');
model.material('mat2').propertyGroup('def').func('eta').set('arg', 'T');
model.material('mat2').propertyGroup('def').func('eta').set('pieces', {'200.0' '1600.0' '-8.38278E-7+8.35717342E-8*T^1-7.69429583E-11*T^2+4.6437266E-14*T^3-1.06585607E-17*T^4'});
model.material('mat2').propertyGroup('def').func('eta').set('argunit', 'K');
model.material('mat2').propertyGroup('def').func('eta').set('fununit', 'Pa*s');
model.material('mat2').propertyGroup('def').func('Cp').set('arg', 'T');
model.material('mat2').propertyGroup('def').func('Cp').set('pieces', {'200.0' '1600.0' '1047.63657-0.372589265*T^1+9.45304214E-4*T^2-6.02409443E-7*T^3+1.2858961E-10*T^4'});
model.material('mat2').propertyGroup('def').func('Cp').set('argunit', 'K');
model.material('mat2').propertyGroup('def').func('Cp').set('fununit', 'J/(kg*K)');
model.material('mat2').propertyGroup('def').func('rho').set('expr', 'pA*0.02897/R_const[K*mol/J]/T');
model.material('mat2').propertyGroup('def').func('rho').set('args', {'pA' 'T'});
model.material('mat2').propertyGroup('def').func('rho').set('fununit', 'kg/m^3');
model.material('mat2').propertyGroup('def').func('rho').set('argunit', {'Pa' 'K'});
model.material('mat2').propertyGroup('def').func('rho').set('plotaxis', {'off' 'on'});
model.material('mat2').propertyGroup('def').func('rho').set('plotfixedvalue', {'101325' '273.15'});
model.material('mat2').propertyGroup('def').func('rho').set('plotargs', {'pA' '101325' '101325'; 'T' '273.15' '293.15'});
model.material('mat2').propertyGroup('def').func('k').set('arg', 'T');
model.material('mat2').propertyGroup('def').func('k').set('pieces', {'200.0' '1600.0' '-0.00227583562+1.15480022E-4*T^1-7.90252856E-8*T^2+4.11702505E-11*T^3-7.43864331E-15*T^4'});
model.material('mat2').propertyGroup('def').func('k').set('argunit', 'K');
model.material('mat2').propertyGroup('def').func('k').set('fununit', 'W/(m*K)');
model.material('mat2').propertyGroup('def').func('cs').set('expr', 'sqrt(1.4*R_const[K*mol/J]/0.02897*T)');
model.material('mat2').propertyGroup('def').func('cs').set('args', {'T'});
model.material('mat2').propertyGroup('def').func('cs').set('fununit', 'm/s');
model.material('mat2').propertyGroup('def').func('cs').set('argunit', {'K'});
model.material('mat2').propertyGroup('def').func('cs').set('plotfixedvalue', {'273.15'});
model.material('mat2').propertyGroup('def').func('cs').set('plotargs', {'T' '273.15' '373.15'});
model.material('mat2').propertyGroup('def').func('an1').set('funcname', 'alpha_p');
model.material('mat2').propertyGroup('def').func('an1').set('expr', '-1/rho(pA,T)*d(rho(pA,T),T)');
model.material('mat2').propertyGroup('def').func('an1').set('args', {'pA' 'T'});
model.material('mat2').propertyGroup('def').func('an1').set('fununit', '1/K');
model.material('mat2').propertyGroup('def').func('an1').set('argunit', {'Pa' 'K'});
model.material('mat2').propertyGroup('def').func('an1').set('plotaxis', {'off' 'on'});
model.material('mat2').propertyGroup('def').func('an1').set('plotfixedvalue', {'101325' '273.15'});
model.material('mat2').propertyGroup('def').func('an1').set('plotargs', {'pA' '101325' '101325'; 'T' '273.15' '373.15'});
model.material('mat2').propertyGroup('def').func('an2').set('funcname', 'muB');
model.material('mat2').propertyGroup('def').func('an2').set('expr', '0.6*eta(T)');
model.material('mat2').propertyGroup('def').func('an2').set('args', {'T'});
model.material('mat2').propertyGroup('def').func('an2').set('fununit', 'Pa*s');
model.material('mat2').propertyGroup('def').func('an2').set('argunit', {'K'});
model.material('mat2').propertyGroup('def').func('an2').set('plotfixedvalue', {'200'});
model.material('mat2').propertyGroup('def').func('an2').set('plotargs', {'T' '200' '1600'});
model.material('mat2').propertyGroup('def').set('thermalexpansioncoefficient', '');
model.material('mat2').propertyGroup('def').set('molarmass', '');
model.material('mat2').propertyGroup('def').set('bulkviscosity', '');
model.material('mat2').propertyGroup('def').set('thermalexpansioncoefficient', {'alpha_p(pA,T)' '0' '0' '0' 'alpha_p(pA,T)' '0' '0' '0' 'alpha_p(pA,T)'});
model.material('mat2').propertyGroup('def').set('molarmass', '0.02897[kg/mol]');
model.material('mat2').propertyGroup('def').set('bulkviscosity', 'muB(T)');
model.material('mat2').propertyGroup('def').set('relpermeability', {'1' '0' '0' '0' '1' '0' '0' '0' '1'});
model.material('mat2').propertyGroup('def').set('relpermittivity', {'1' '0' '0' '0' '1' '0' '0' '0' '1'});
model.material('mat2').propertyGroup('def').set('dynamicviscosity', 'eta(T)');
model.material('mat2').propertyGroup('def').set('ratioofspecificheat', '1.4');
model.material('mat2').propertyGroup('def').set('electricconductivity', {'0[S/m]' '0' '0' '0' '0[S/m]' '0' '0' '0' '0[S/m]'});
model.material('mat2').propertyGroup('def').set('heatcapacity', 'Cp(T)');
model.material('mat2').propertyGroup('def').set('density', 'rho(pA,T)');
model.material('mat2').propertyGroup('def').set('thermalconductivity', {'k(T)' '0' '0' '0' 'k(T)' '0' '0' '0' 'k(T)'});
model.material('mat2').propertyGroup('def').set('soundspeed', 'cs(T)');
model.material('mat2').propertyGroup('def').addInput('temperature');
model.material('mat2').propertyGroup('def').addInput('pressure');
model.material('mat2').propertyGroup('RefractiveIndex').set('n', {'1' '0' '0' '0' '1' '0' '0' '0' '1'});
model.material('mat2').propertyGroup('NonlinearModel').set('BA', 'def.gamma-1');
model.material('mat2').propertyGroup('idealGas').func('Cp').label('Piecewise 2');
model.material('mat2').propertyGroup('idealGas').func('Cp').set('arg', 'T');
model.material('mat2').propertyGroup('idealGas').func('Cp').set('pieces', {'200.0' '1600.0' '1047.63657-0.372589265*T^1+9.45304214E-4*T^2-6.02409443E-7*T^3+1.2858961E-10*T^4'});
model.material('mat2').propertyGroup('idealGas').func('Cp').set('argunit', 'K');
model.material('mat2').propertyGroup('idealGas').func('Cp').set('fununit', 'J/(kg*K)');
model.material('mat2').propertyGroup('idealGas').set('Rs', 'R_const/Mn');
model.material('mat2').propertyGroup('idealGas').set('heatcapacity', 'Cp(T)');
model.material('mat2').propertyGroup('idealGas').set('ratioofspecificheat', '1.4');
model.material('mat2').propertyGroup('idealGas').set('molarmass', '0.02897');
model.material('mat2').propertyGroup('idealGas').addInput('temperature');
model.material('mat2').propertyGroup('idealGas').addInput('pressure');
model.material('mat2').materialType('nonSolid');
model.material('mat1').selection.set([3]);
model.material('mat2').selection.set([1]);

model.physics('mef').prop('ShapeProperty').set('order_magneticvectorpotential', 1);
model.physics('mef').prop('ShapeProperty').set('order_electricpotential', 1);
model.physics('mef').feature('mi1').create('ein1', 'ElectricInsulation', 2);
model.physics('mef').feature('mi1').feature('ein1').selection.set([1 2 3 4 5 79]);
model.physics('mef').feature('mi1').create('term1', 'Terminal', 2);
model.physics('mef').feature('mi1').feature('term1').selection.set([17]);
model.physics('mef').feature('mi1').feature('term1').set('TerminalType', 'Voltage');
model.physics('mef').create('alc2', 'ElectromagneticModel', 3);
model.physics('mef').feature('alc2').selection.set([2]);
model.physics('mef').feature('alc2').set('ConstitutiveRelationBH', 'MagneticLosses');
model.physics('mef').create('gfa1', 'GaugeFixingA', 3);

model.material.create('mat3', 'Common', 'comp1');
model.material('mat3').label('Core Material');
model.material('mat3').selection.set([2]);
model.material('mat3').propertyGroup.create('MagneticLosses', 'Magnetic_losses');
model.material('mat3').propertyGroup('MagneticLosses').set('murPrim', {'1000'});
model.material('mat3').propertyGroup('MagneticLosses').set('murBis', {'10'});
model.material('mat3').propertyGroup('def').set('electricconductivity', {'0'});
model.material('mat3').propertyGroup('def').set('relpermittivity', {'1'});

model.mesh('mesh1').autoMeshSize(8);
model.mesh('mesh1').automatic(false);
model.mesh('mesh1').feature('ftet1').create('size1', 'Size');
model.mesh('mesh1').feature('ftet1').feature('size1').selection.geom('geom1', 3);
model.mesh('mesh1').feature('ftet1').feature('size1').selection.set([2]);
model.mesh('mesh1').feature('ftet1').feature('size1').set('custom', true);
model.mesh('mesh1').feature('ftet1').feature('size1').set('hmaxactive', true);
model.mesh('mesh1').feature('ftet1').feature('size1').set('hmax', '5[mm]');
model.mesh('mesh1').create('bl1', 'BndLayer');
model.mesh('mesh1').feature('bl1').create('blp', 'BndLayerProp');
model.mesh('mesh1').feature('bl1').selection.geom(3);
model.mesh('mesh1').feature('bl1').selection.set([]);
model.mesh('mesh1').feature('bl1').selection.allGeom;
model.mesh('mesh1').feature('bl1').selection.geom('geom1', 3);
model.mesh('mesh1').feature('bl1').selection.set([3]);
model.mesh('mesh1').feature('bl1').feature('blp').selection.set([16 18 19 20 21 22 23 24 25 26 62 64 65 66 67 68 69 70 71 72 73 74]);
model.mesh('mesh1').feature('bl1').feature('blp').set('blnlayers', 2);
model.mesh('mesh1').feature('bl1').feature('blp').set('inittype', 'blhmin');
model.mesh('mesh1').feature('bl1').feature('blp').set('blhmin', '0.5[mm]');
model.mesh('mesh1').run;

model.study('std1').feature('freq').set('plist', '1[kHz]');
model.study('std1').feature('freq').set('useadvanceddisable', true);
model.study('std1').feature('freq').set('disabledphysics', {'mef/gfa1'});

model.sol.create('sol1');
model.sol('sol1').study('std1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'freq');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').set('control', 'freq');
model.sol('sol1').create('s1', 'Stationary');
model.sol('sol1').feature('s1').create('p1', 'Parametric');
model.sol('sol1').feature('s1').feature.remove('pDef');
model.sol('sol1').feature('s1').feature('p1').set('pname', {'freq'});
model.sol('sol1').feature('s1').feature('p1').set('plistarr', {'1[kHz]'});
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
model.sol('sol1').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('s1').create('i1', 'Iterative');
model.sol('sol1').feature('s1').feature('i1').set('linsolver', 'fgmres');
model.sol('sol1').feature('s1').feature('i1').set('nlinnormuse', true);
model.sol('sol1').feature('s1').feature('i1').set('rhob', 10000);
model.sol('sol1').feature('s1').feature('i1').create('mg1', 'Multigrid');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').set('prefun', 'amg');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('pr').create('so1', 'SOR');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('po').create('so1', 'SOR');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('cs').create('kp1', 'KrylovPreconditioner');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('cs').feature('kp1').set('prefuntype', 'right');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('cs').feature('kp1').set('prefun', 'gmres');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('cs').feature('kp1').set('iterm', 'itertol');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('cs').feature('kp1').set('iter', '25');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('cs').feature('kp1').create('so1', 'SOR');
model.sol('sol1').feature('s1').feature('fc1').set('linsolver', 'i1');
model.sol('sol1').feature('s1').feature.remove('fcDef');
model.sol('sol1').attach('std1');
model.sol('sol1').feature('s1').feature('i1').set('linsolver', 'gmres');
model.sol('sol1').feature('s1').feature('i1').set('itrestart', 500);
model.sol('sol1').feature('s1').feature('i1').set('prefuntype', 'right');
model.sol('sol1').feature('s1').feature('i1').set('rhob', '1e7');
model.sol('sol1').feature('s1').feature('i1').create('so1', 'SOR');

model.study('std1').setGenPlots(false);
model.study('std1').label('Ungauged Formulation');

model.sol('sol1').runAll;

model.study.create('std2');
model.study('std2').create('freq', 'Frequency');
model.study('std2').feature('freq').setSolveFor('/physics/mef', true);
model.study('std2').feature('freq').set('plist', '1[kHz]');

model.sol.create('sol2');
model.sol('sol2').study('std2');
model.sol('sol2').create('st1', 'StudyStep');
model.sol('sol2').feature('st1').set('study', 'std2');
model.sol('sol2').feature('st1').set('studystep', 'freq');
model.sol('sol2').create('v1', 'Variables');
model.sol('sol2').feature('v1').set('control', 'freq');
model.sol('sol2').create('s1', 'Stationary');
model.sol('sol2').feature('s1').create('p1', 'Parametric');
model.sol('sol2').feature('s1').feature.remove('pDef');
model.sol('sol2').feature('s1').feature('p1').set('pname', {'freq'});
model.sol('sol2').feature('s1').feature('p1').set('plistarr', {'1[kHz]'});
model.sol('sol2').feature('s1').feature('p1').set('punit', {'Hz'});
model.sol('sol2').feature('s1').feature('p1').set('pcontinuationmode', 'no');
model.sol('sol2').feature('s1').feature('p1').set('preusesol', 'no');
model.sol('sol2').feature('s1').feature('p1').set('pdistrib', 'off');
model.sol('sol2').feature('s1').feature('p1').set('plot', 'off');
model.sol('sol2').feature('s1').feature('p1').set('plotgroup', 'Default');
model.sol('sol2').feature('s1').feature('p1').set('probesel', 'all');
model.sol('sol2').feature('s1').feature('p1').set('probes', {});
model.sol('sol2').feature('s1').feature('p1').set('control', 'freq');
model.sol('sol2').feature('s1').set('linpmethod', 'sol');
model.sol('sol2').feature('s1').set('linpsol', 'zero');
model.sol('sol2').feature('s1').set('control', 'freq');
model.sol('sol2').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol2').feature('s1').create('i1', 'Iterative');
model.sol('sol2').feature('s1').feature('i1').set('linsolver', 'gmres');
model.sol('sol2').feature('s1').feature('i1').set('nlinnormuse', true);
model.sol('sol2').feature('s1').feature('i1').set('prefuntype', 'right');
model.sol('sol2').feature('s1').feature('i1').set('rhob', 10000);
model.sol('sol2').feature('s1').feature('i1').create('mg1', 'Multigrid');
model.sol('sol2').feature('s1').feature('i1').feature('mg1').feature('pr').create('va1', 'Vanka');
model.sol('sol2').feature('s1').feature('i1').feature('mg1').feature('pr').feature('va1').set('vankavars', {'comp1_mef_psi' 'comp1_V'});
model.sol('sol2').feature('s1').feature('i1').feature('mg1').feature('po').create('va1', 'Vanka');
model.sol('sol2').feature('s1').feature('i1').feature('mg1').feature('po').feature('va1').set('vankavars', {'comp1_mef_psi' 'comp1_V'});
model.sol('sol2').feature('s1').feature('fc1').set('linsolver', 'i1');
model.sol('sol2').feature('s1').feature.remove('fcDef');
model.sol('sol2').attach('std2');
model.sol('sol2').feature('s1').feature('fc1').set('linsolver', 'dDef');

model.study('std2').label('Gauged Formulation');
model.study('std2').setGenPlots(false);

model.sol('sol2').runAll;

model.result.numerical.create('gev1', 'EvalGlobal');
model.result.numerical('gev1').setIndex('expr', 'real(mef.Y11)', 0);
model.result.numerical('gev1').setIndex('expr', 'real(1/mef.Y11/mef.iomega)', 1);
model.result.numerical('gev1').setIndex('unit', 'uH', 1);
model.result.table.create('tbl1', 'Table');
model.result.table('tbl1').comments('Global Evaluation 1');
model.result.numerical('gev1').set('table', 'tbl1');
model.result.numerical('gev1').setResult;
model.result.numerical.create('int1', 'IntVolume');
model.result.numerical('int1').selection.set([2 3]);
model.result.numerical('int1').setIndex('expr', '2*mef.Qh/1[V^2]', 0);
model.result.numerical('int1').set('table', 'tbl1');
model.result.numerical('int1').appendResult;
model.result.numerical('gev1').set('data', 'dset2');
model.result.numerical('gev1').set('table', 'tbl1');
model.result.numerical('gev1').appendResult;
model.result.create('pg1', 'PlotGroup3D');
model.result('pg1').run;
model.result('pg1').label('Electric Potential, Comparison');
model.result('pg1').set('edges', false);
model.result('pg1').create('vol1', 'Volume');
model.result('pg1').feature('vol1').set('data', 'dset1');
model.result('pg1').feature('vol1').create('sel1', 'Selection');
model.result('pg1').feature('vol1').feature('sel1').selection.set([3]);
model.result('pg1').run;
model.result('pg1').feature.duplicate('vol2', 'vol1');
model.result('pg1').run;
model.result('pg1').feature('vol2').set('data', 'dset2');
model.result('pg1').feature('vol2').set('inheritplot', 'vol1');
model.result('pg1').feature('vol2').create('trn1', 'Translation');
model.result('pg1').run;
model.result('pg1').feature('vol2').feature('trn1').set('trans', [0.2 0 0]);

model.view('view1').set('showgrid', false);

model.result('pg1').run;
model.result('pg1').run;
model.result.duplicate('pg2', 'pg1');
model.result('pg2').run;
model.result('pg2').label('Electric Field, Comparison');
model.result('pg2').run;
model.result('pg2').feature('vol1').set('expr', 'mef.normE');
model.result('pg2').run;
model.result('pg2').feature('vol2').set('expr', 'mef.normE');
model.result('pg2').run;
model.result.create('pg3', 'PlotGroup3D');
model.result('pg3').run;
model.result('pg3').label('Electric Potential, Gauged Formulation');
model.result('pg3').set('data', 'dset2');
model.result('pg3').create('surf1', 'Surface');
model.result('pg3').feature('surf1').create('sel1', 'Selection');
model.result('pg3').feature('surf1').feature('sel1').selection.set([3 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40 41 42 43 44 45 46 47 48 49 50 51 52 53 54 55 56 57 58 59 60 61 62 63 64 65 66 67 68 69 70 71 72 73 74 75 76 77 78 79]);
model.result('pg3').run;
model.result('pg3').run;
model.result('pg3').run;

model.title('Inductance of a Power Inductor');

model.description('Power inductors are a central part of many low-frequency power applications. They are, for example, used in the switched power supply for the motherboard and all other components in a computer. This example shows how to use the Terminal boundary condition to extract the inductance. It also shows how to solve the model with and without gauge.');

model.mesh.clearMeshes;

model.sol('sol1').clearSolutionData;
model.sol('sol2').clearSolutionData;

model.label('power_inductor.mph');

model.modelNode.label('Components');

out = model;
```

---

## Example 16: transport_and_adsorption

**Module:** Unknown_Module  
**Category:** COMSOL_Multiphysics_Chemical_Engineering_transport_and_adsorption  

### Model Description

**Model Overview:**
The simulation model "transport_and_adsorption" is designed to investigate the coupling of surface diffusion and surface reactions with species transport to a reacting surface. This type of model is relevant in scenarios where surface-specific species interactions play a crucial role, such as in catalysis, biochip technology, semiconductor fabrication, or any process involving surface-specific chemical reactions.

**Geometry:**
The geometric setup consists of a rectangle with dimensions 0.1 mm by 0.3 mm, positioned with its lower-left corner at the origin (0, -0.1) within a coordinate system. The geometry also includes two points, likely used for specifying certain conditions or probes within the simulation.

**Materials:**
The script does not explicitly define material properties, suggesting that the material properties are either defined by default settings within COMSOL or are not critical to the specific phenomena being modeled.

**Physics:**
The model employs two physics interfaces:
1. Diluted Species Transport (tds) - for simulating the transport of chemical species within the bulk phase.
2. General Form Boundary PDE (gb) - for modeling the surface reactions and surface diffusion on the boundary of the domain.

The equations involved include convection and diffusion for the species transport, and a surface reaction rate equation defined as `R = k_ads*c*(Gamma_s-cs)-k_des*cs`, where `k_ads` is the forward rate constant, `k_des` is the backward rate constant, `Gamma_s` is the active site concentration, `c` is the concentration of the species in the bulk, and `cs` is the surface concentration of the adsorbed species.

**Boundary Conditions:**
Boundary conditions include:
- A concentration boundary condition at the inlet specifying the initial concentration (`c0`).
- A flux boundary condition where the flux is defined by the surface reaction rate (`-R`).
- An outflow boundary condition at the outlet.
- Symmetry boundary conditions along the sides.

**Mesh:**
The geometry is discretized using a free triangular mesh with a custom size setting applied to the active surface, where the maximum element size is set to 1.5 um, indicating a refined mesh in this region to capture the surface phenomena accurately.

**Study:**
The analysis performed is transient, with a time-dependent study set up to solve for both the species transport and the surface reactions over a specified time range.

**Key Parameters:**
Key parameters include:
- Initial concentration (`c0`): 1000 mol/m^3
- Forward rate constant (`k_ads`): 1e-6 m^3/(mol*s)
- Backward rate constant (`k_des`): 1e-9 1/s
- Active site concentration (`Gamma_s`): 1000 mol/m^2
- Surface diffusivity (`Ds`): 1e-11 m^2/s
- Gas diffusivity (`D`): 1e-9 m^2/s
- Maximum velocity (`v_max`): 1 mm/s
- Channel width (`delta`): 0.1 mm

**Expected Results:**
The model predicts the concentration distribution of the chemical species in the bulk phase and on the surface, the surface reaction rate along the active surface, and the development of these quantities over time.

**Engineering Application:**
This model can be applied to analyze and optimize processes in various engineering fields where surface reactions and species transport are critical, such as heterogeneous catalysis for optimizing reactor designs, semiconductor processing for understanding and controlling surface reactions, and biochip design for enhancing the sensitivity and specificity of detection.

The model provides insights into the interplay between mass transport and surface reactions, which can guide the design and operation of reactors, sensors, and other devices where surface processes are paramount. By adjusting the key parameters, engineers can explore different scenarios and optimize the performance of the system for specific applications.

### COMSOL MATLAB Code

```matlab
function out = model
%
% transport_and_adsorption.m
%
% Model exported on May 26 2025, 21:26 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/COMSOL_Multiphysics/Chemical_Engineering');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 2);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.physics.create('tds', 'DilutedSpecies', 'geom1', {'c'});
model.physics.create('gb', 'GeneralFormBoundaryPDE', 'geom1', {'cs'});
model.physics('gb').prop('EquationForm').set('form', 'Automatic');

model.study.create('std1');
model.study('std1').create('time', 'Transient');
model.study('std1').feature('time').setSolveFor('/physics/tds', true);
model.study('std1').feature('time').setSolveFor('/physics/gb', true);

% To import content from file, use:
% model.param.loadFile('FILENAME');
model.param.set('c0', '1000[mol/m^3]', 'Initial concentration');
model.param.set('k_ads', '1e-6[m^3/(mol*s)]', 'Forward rate constant');
model.param.set('k_des', '1e-9[1/s]', 'Backward rate constant');
model.param.set('Gamma_s', '1000[mol/m^2]', 'Active site concentration');
model.param.set('Ds', '1e-11[m^2/s]', 'Surface diffusivity');
model.param.set('D', '1e-9[m^2/s]', 'Gas diffusivity');
model.param.set('v_max', '1[mm/s]', 'Maximum velocity');
model.param.set('delta', '0.1[mm]', 'Channel width');

model.geom('geom1').lengthUnit('mm');
model.geom('geom1').create('r1', 'Rectangle');
model.geom('geom1').feature('r1').set('size', [0.1 0.3]);
model.geom('geom1').feature('r1').set('pos', [0 -0.1]);
model.geom('geom1').runPre('fin');
model.geom('geom1').create('pt1', 'Point');
model.geom('geom1').feature('pt1').setIndex('p', 0.1, 0);
model.geom('geom1').runPre('fin');
model.geom('geom1').create('pt2', 'Point');
model.geom('geom1').feature('pt2').setIndex('p', 0.1, 0);
model.geom('geom1').feature('pt2').setIndex('p', 0.1, 1);
model.geom('geom1').runPre('fin');

model.variable.create('var1');
model.variable('var1').model('comp1');

model.geom('geom1').run;

model.variable('var1').selection.geom('geom1', 1);
model.variable('var1').selection.set([5]);
model.variable('var1').set('R', 'k_ads*c*(Gamma_s-cs)-k_des*cs');
model.variable('var1').descr('R', 'Surface reaction rate');
model.variable.create('var2');
model.variable('var2').model('comp1');
model.variable('var2').selection.geom('geom1', 2);
model.variable('var2').selection.set([1]);
model.variable('var2').set('v_lam', 'v_max*(1-((x-0.5*delta)/(0.5*delta))^2)');
model.variable('var2').descr('v_lam', 'Inlet velocity profile');

model.physics('tds').feature('cdm1').set('D_c', {'D' '0' '0' '0' 'D' '0' '0' '0' 'D'});
model.physics('tds').feature('cdm1').set('u', {'0' 'v_lam' '0'});
model.physics('tds').feature('init1').setIndex('initc', 'c0', 0);
model.physics('tds').create('conc1', 'Concentration', 1);
model.physics('tds').feature('conc1').selection.set([2]);
model.physics('tds').feature('conc1').setIndex('species', true, 0);
model.physics('tds').feature('conc1').setIndex('c0', 'c0', 0);
model.physics('tds').create('fl1', 'FluxBoundary', 1);
model.physics('tds').feature('fl1').selection.set([5]);
model.physics('tds').feature('fl1').setIndex('species', true, 0);
model.physics('tds').feature('fl1').setIndex('J0', '-R', 0);
model.physics('tds').create('out1', 'Outflow', 1);
model.physics('tds').feature('out1').selection.set([3]);
model.physics('tds').create('sym1', 'Symmetry', 1);
model.physics('tds').feature('sym1').selection.set([1 4 6]);
model.physics('gb').selection.set([5]);
model.physics('gb').prop('Units').set('CustomDependentVariableUnit', '1');
model.physics('gb').prop('Units').set('DependentVariableQuantity', 'none');
model.physics('gb').prop('Units').setIndex('CustomDependentVariableUnit', 'mol/m^2', 0, 0);
model.physics('gb').prop('Units').setIndex('CustomSourceTermUnit', 'mol/(m^2*s)', 0, 0);
model.physics('gb').feature('gfeq1').setIndex('Ga', {'-csTx*Ds' '-csTy'}, 0);
model.physics('gb').feature('gfeq1').setIndex('Ga', {'-csTx*Ds' '-csTy*Ds'}, 0);
model.physics('gb').feature('gfeq1').setIndex('f', 'R', 0);

model.mesh('mesh1').create('ftri1', 'FreeTri');
model.mesh('mesh1').feature('ftri1').create('size1', 'Size');
model.mesh('mesh1').feature('ftri1').feature('size1').selection.geom('geom1', 1);
model.mesh('mesh1').feature('ftri1').feature('size1').selection.set([5]);
model.mesh('mesh1').feature('ftri1').feature('size1').set('custom', true);
model.mesh('mesh1').feature('ftri1').feature('size1').set('hmaxactive', true);
model.mesh('mesh1').feature('ftri1').feature('size1').set('hmax', '1.5[um]');
model.mesh('mesh1').run;

model.study('std1').feature('time').set('tlist', 'range(0,0.05,2)');

model.sol.create('sol1');

model.mesh('mesh1').stat.selection.geom(2);
model.mesh('mesh1').stat.selection.set([1]);

model.sol('sol1').study('std1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'time');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').set('control', 'time');
model.sol('sol1').create('t1', 'Time');
model.sol('sol1').feature('t1').set('tlist', 'range(0,0.05,2)');
model.sol('sol1').feature('t1').set('plot', 'off');
model.sol('sol1').feature('t1').set('plotgroup', 'Default');
model.sol('sol1').feature('t1').set('plotfreq', 'tout');
model.sol('sol1').feature('t1').set('probesel', 'all');
model.sol('sol1').feature('t1').set('probes', {});
model.sol('sol1').feature('t1').set('probefreq', 'tsteps');
model.sol('sol1').feature('t1').set('rtol', 0.005);
model.sol('sol1').feature('t1').set('atolglobalvaluemethod', 'factor');
model.sol('sol1').feature('t1').set('reacf', true);
model.sol('sol1').feature('t1').set('storeudot', true);
model.sol('sol1').feature('t1').set('endtimeinterpolation', true);
model.sol('sol1').feature('t1').set('maxorder', 2);
model.sol('sol1').feature('t1').set('stabcntrl', true);
model.sol('sol1').feature('t1').set('control', 'time');
model.sol('sol1').feature('t1').feature('aDef').set('cachepattern', true);
model.sol('sol1').feature('t1').create('seDef', 'Segregated');
model.sol('sol1').feature('t1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('t1').feature('fc1').set('stabacc', 'aacc');
model.sol('sol1').feature('t1').feature('fc1').set('aaccdim', 5);
model.sol('sol1').feature('t1').feature('fc1').set('aaccdelay', 0);
model.sol('sol1').feature('t1').feature('fc1').set('aaccmix', 0.9);
model.sol('sol1').feature('t1').feature('fc1').set('maxiter', 8);
model.sol('sol1').feature('t1').feature('fc1').set('damp', 0.9);
model.sol('sol1').feature('t1').feature('fc1').set('jtech', 'once');
model.sol('sol1').feature('t1').create('d1', 'Direct');
model.sol('sol1').feature('t1').feature('d1').label('Direct (Merged)');
model.sol('sol1').feature('t1').create('i1', 'Iterative');
model.sol('sol1').feature('t1').feature('i1').set('linsolver', 'gmres');
model.sol('sol1').feature('t1').feature('i1').set('prefuntype', 'left');
model.sol('sol1').feature('t1').feature('i1').set('itrestart', 50);
model.sol('sol1').feature('t1').feature('i1').set('rhob', 400);
model.sol('sol1').feature('t1').feature('i1').set('maxlinit', 50);
model.sol('sol1').feature('t1').feature('i1').set('nlinnormuse', 'on');
model.sol('sol1').feature('t1').feature('i1').label('AMG, concentrations (tds)');
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
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('pr').create('sl1', 'SORLine');
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('pr').feature('sl1').set('linesweeptype', 'ssor');
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('pr').feature('sl1').set('iter', 1);
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('pr').feature('sl1').set('linerelax', 0.7);
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('pr').feature('sl1').set('linealgorithm', 'mesh');
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('pr').feature('sl1').set('linemethod', 'coupled');
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('pr').feature('sl1').set('seconditer', 1);
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('pr').feature('sl1').set('relax', 0.5);
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('po').create('sl1', 'SORLine');
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('po').feature('sl1').set('linesweeptype', 'ssor');
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('po').feature('sl1').set('iter', 1);
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('po').feature('sl1').set('linerelax', 0.7);
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('po').feature('sl1').set('linealgorithm', 'mesh');
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('po').feature('sl1').set('linemethod', 'coupled');
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('po').feature('sl1').set('seconditer', 1);
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('po').feature('sl1').set('relax', 0.5);
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('cs').create('d1', 'Direct');
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('cs').feature('d1').set('linsolver', 'pardiso');
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('cs').feature('d1').set('pivotperturb', 1.0E-13);
model.sol('sol1').feature('t1').feature('fc1').set('linsolver', 'd1');
model.sol('sol1').feature('t1').feature('fc1').set('stabacc', 'aacc');
model.sol('sol1').feature('t1').feature('fc1').set('aaccdim', 5);
model.sol('sol1').feature('t1').feature('fc1').set('aaccdelay', 0);
model.sol('sol1').feature('t1').feature('fc1').set('aaccmix', 0.9);
model.sol('sol1').feature('t1').feature('fc1').set('maxiter', 8);
model.sol('sol1').feature('t1').feature('fc1').set('damp', 0.9);
model.sol('sol1').feature('t1').feature('fc1').set('jtech', 'once');
model.sol('sol1').feature('t1').feature.remove('fcDef');
model.sol('sol1').feature('t1').feature.remove('seDef');
model.sol('sol1').attach('std1');
model.sol('sol1').runAll;

model.result.create('pg1', 'PlotGroup2D');
model.result('pg1').set('data', 'dset1');
model.result('pg1').setIndex('looplevel', 41, 0);
model.result('pg1').label('Concentration (tds)');
model.result('pg1').set('titletype', 'custom');
model.result('pg1').set('prefixintitle', '');
model.result('pg1').set('expressionintitle', false);
model.result('pg1').set('typeintitle', true);
model.result('pg1').create('surf1', 'Surface');
model.result('pg1').feature('surf1').set('expr', {'c'});
model.result('pg1').create('str1', 'Streamline');
model.result('pg1').feature('str1').set('expr', {'tds.tflux_cx' 'tds.tflux_cy'});
model.result('pg1').feature('str1').set('posmethod', 'uniform');
model.result('pg1').feature('str1').set('recover', 'pprint');
model.result('pg1').feature('str1').set('pointtype', 'arrow');
model.result('pg1').feature('str1').set('arrowlength', 'logarithmic');
model.result('pg1').feature('str1').set('color', 'gray');
model.result.create('pg2', 'PlotGroup2D');
model.result('pg2').set('data', 'dset1');
model.result('pg2').setIndex('looplevel', 41, 0);
model.result('pg2').create('line1', 'Line');
model.result('pg2').label('General Form Boundary PDE');
model.result('pg2').feature('line1').set('expr', 'cs');
model.result('pg1').run;
model.result('pg1').label('Concentration Species in Reactor');
model.result('pg1').run;
model.result.create('pg3', 'PlotGroup1D');
model.result('pg3').run;
model.result('pg3').label('Concentration Reacting Species Along Active Surface');
model.result('pg3').setIndex('looplevelinput', 'manual', 0);
model.result('pg3').setIndex('looplevel', [41], 0);
model.result('pg3').create('lngr1', 'LineGraph');
model.result('pg3').feature('lngr1').set('markerpos', 'datapoints');
model.result('pg3').feature('lngr1').set('linewidth', 'preference');
model.result('pg3').feature('lngr1').selection.set([5]);
model.result('pg3').feature('lngr1').set('xdataexpr', 'y');
model.result('pg3').feature('lngr1').set('xdatadescr', 'y-coordinate');
model.result('pg3').run;
model.result('pg3').run;
model.result.duplicate('pg4', 'pg3');
model.result('pg4').run;
model.result('pg4').label('Concentration Adsorbed Species Along Active Surface');
model.result('pg4').setIndex('looplevel', [2 11 21 31 41], 0);
model.result('pg4').run;
model.result('pg4').feature('lngr1').set('expr', 'cs');
model.result('pg4').feature('lngr1').set('descr', 'Dependent variable cs');
model.result('pg4').run;
model.result('pg4').run;
model.result.duplicate('pg5', 'pg4');
model.result('pg5').run;
model.result('pg5').label('Surface Reaction Rate Along Active Surface');
model.result('pg5').run;
model.result('pg5').feature('lngr1').set('expr', 'R');
model.result('pg5').feature('lngr1').set('descr', 'Surface reaction rate');
model.result('pg5').run;
model.result('pg2').run;
model.result('pg2').label('Concentration Adsorbed Species at Active Surface');
model.result('pg2').run;
model.result('pg2').feature('line1').set('linetype', 'tube');
model.result('pg2').feature('line1').set('tuberadiusscaleactive', true);
model.result('pg2').feature('line1').set('tuberadiusscale', 0.005);
model.result('pg2').run;

model.title('Transport and Adsorption');

model.description('This example shows surface diffusion and surface reactions coupled to species transport to the reacting surface. In adsorption reactions it is necessary to model the surface concentrations of the active sites or surface complex as well as the bulk concentration in the gas phase. This device could be a catalyst, biochip, semiconductor component, or any process with surface-specific species.');

model.mesh.clearMeshes;

model.sol('sol1').clearSolutionData;

model.label('transport_and_adsorption.mph');

model.modelNode.label('Components');

out = model;
```

---

## Example 17: soec_co2

**Module:** Fuel_Cell_and_Electrolyzer_Module_Electrolyzers_soec_co2  
**Category:** Unknown_Category  

### Model Description

**Model Overview**:
The model simulates the co-electrolysis of water and carbon dioxide in a solid oxide electrolyzer cell (SOEC). It encompasses the full coupling between mass balances and gas flow in the hydrogen and oxygen gas diffusion electrodes, momentum balances in the gas flow channels, energy balance across the cell, the balance of the ionic current carried by the oxide ion, and an electronic current balance. Additionally, a reversible water gas shift reaction is included in the hydrogen gas diffusion electrode and hydrogen gas flow channel.

**Geometry**:
The geometry consists of a 2D representation of a solid oxide electrolyzer cell with layers representing the interconnect, gas flow channels, gas diffusion electrodes (anode and cathode), and the membrane. The dimensions are as follows:
- Planar SOEC length (L): 20 mm
- Planar SOEC thickness (W): 3.7 mm
- Gas flow channel height (dg): 1 mm
- Interconnect thickness (di): 500 μm
- Anode thickness (da): 100 μm
- Membrane thickness (dm): 100 μm
- Cathode thickness (dc): 500 μm

**Materials**:
Two main materials are used in the model:
1. Yttria-Stabilized Zirconia (8YSZ) for the electrolyte, with properties like electrolyte conductivity.
2. Steel AISI 4340 for the interconnect, with properties such as Young's modulus, Poisson's ratio, thermal expansion coefficient, heat capacity, and thermal conductivity.

**Physics**:
The model employs several physics interfaces:
- WaterElectrolyzer (we) for the electrolysis process.
- HeatTransferInSolidsAndFluids (ht) for the thermal analysis.
- GeneralProjection (genproj1) for evaluating the spatial distribution of current density.

**Boundary Conditions**:
Key boundary conditions include:
- Applied potential (E_app) of 0.5 V at the anode current collector.
- Ground (0 V) at the cathode current collector.
- Inlet mass fractions and mass flow rates for H2O, CO2, CO, and H2 in the hydrogen gas flow channel.
- Inlet mass fraction and mass flow rate for N2 in the oxygen gas flow channel.

**Mesh**:
The geometry is discretized using a mesh with distribution and map settings to control the element size and distribution across different domains. The mesh includes:
- Distribution (dis1 to dis6) for various domains with specific element counts and growth rates.
- Map (map1) for the mesh distribution.

**Study**:
The model performs a stationary (steady-state) analysis to evaluate the performance of the SOEC under constant operating conditions.

**Key Parameters**:
Important parameters include:
- Operating temperature (T_in): 1073 K
- Electrode porosity (epsg) and electrolyte volume fraction (epsl): 0.4
- Electrode tortuosity (taug): 3
- Reference exchange current densities for H2O electrolysis (i0_ref_HER), CO2 electrolysis (i0_ref_COER), and oxygen evolution reaction (i0_ref_OER): 1 A/m²
- Initial mole fractions for H2O, CO2, CO, and H2.
- Gas mass flux (Mflux_in): 0.001 kg/s
- Thermal conductivities for the cathode (kc), anode (ka), electrolyte (km), and interconnect (ki).

**Expected Results**:
The model predicts the spatial distributions of various species (H2, O2, H2O, CO2, CO, N2) across the gas diffusion electrodes and gas flow channels, the temperature distribution, and the current density distribution along the electrode length.

**Engineering Application**:
This model can be used to design, optimize, and analyze the performance of solid oxide electrolyzer cells for hydrogen and syngas production from water and carbon dioxide electrolysis. It aids in understanding the complex coupling between electrochemical reactions, mass transport, and heat transfer in SOECs, which is crucial for the development of efficient and robust electrolysis systems for renewable energy applications.

### COMSOL MATLAB Code

```matlab
function out = model
%
% soec_co2.m
%
% Model exported on May 26 2025, 21:28 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/Fuel_Cell_and_Electrolyzer_Module/Electrolyzers');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 2);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.physics.create('we', 'WaterElectrolyzer', 'geom1');
model.physics('we').model('comp1');
model.physics('we').prop('H2GasMixture').set('H2O', '1');
model.physics('we').prop('H2GasMixture').set('GasPhaseDiffusion', '1');
model.physics('we').prop('DefaultElectrodeReactionSettings').set('ElectrolyteType', 'SolidOxide');
model.physics('we').prop('DefaultElectrodeReactionSettings').set('OperationMode', 'Electrolyzer');
model.physics('we').prop('DefaultElectrodeReactionSettings').set('TRHE', '700[degC]');
model.physics.create('ht', 'HeatTransferInSolidsAndFluids', 'geom1');
model.physics('ht').model('comp1');

model.study.create('std1');
model.study('std1').create('cdi', 'CurrentDistributionInitialization');
model.study('std1').feature('cdi').set('solnum', 'auto');
model.study('std1').feature('cdi').set('notsolnum', 'auto');
model.study('std1').feature('cdi').set('outputmap', {});
model.study('std1').feature('cdi').set('ngenAUX', '1');
model.study('std1').feature('cdi').set('goalngenAUX', '1');
model.study('std1').feature('cdi').set('ngenAUX', '1');
model.study('std1').feature('cdi').set('goalngenAUX', '1');
model.study('std1').feature('cdi').setSolveFor('/physics/we', true);
model.study('std1').feature('cdi').setSolveFor('/physics/ht', true);
model.study('std1').create('stat', 'Stationary');
model.study('std1').feature('stat').set('solnum', 'auto');
model.study('std1').feature('stat').set('notsolnum', 'auto');
model.study('std1').feature('stat').set('outputmap', {});
model.study('std1').feature('stat').set('ngenAUX', '1');
model.study('std1').feature('stat').set('goalngenAUX', '1');
model.study('std1').feature('stat').set('ngenAUX', '1');
model.study('std1').feature('stat').set('goalngenAUX', '1');
model.study('std1').feature('stat').setSolveFor('/physics/we', true);
model.study('std1').feature('stat').setSolveFor('/physics/ht', true);

% To import content from file, use:
% model.param.loadFile('FILENAME');
model.param.set('T_in', '1073[K]', 'Operating temperature');
model.param.set('epsg', '0.4', 'Electrode porosity');
model.param.set('epsl', '0.4', 'Electrolyte volume fraction');
model.param.set('taug', '3', 'Electrode tortuosity');
model.param.set('dc', '500[um]', 'Cathode thickness');
model.param.set('dm', '100[um]', 'Membrane thickness');
model.param.set('da', '100[um]', 'Anode thickness');
model.param.set('dg', '1[mm]', 'Gas flow channel height');
model.param.set('di', '500[um]', 'Interconnect thickness');
model.param.set('L', '20[mm]', 'Planar SOEC length');
model.param.set('W', '3.7[mm]', 'Planar SOEC thickness');
model.param.set('Mflux_in', '0.001[kg/s]', 'Gas mass flux');
model.param.set('E_app', '0.5[V]', 'SOEC operating potential');
model.param.set('kc', '11[W/m/K]', 'Cathode thermal conductivity');
model.param.set('ka', '6[W/m/K]', 'Anode thermal conductivity');
model.param.set('km', '2.7[W/m/K]', 'Electrolyte thermal conductivity');
model.param.set('ki', '1.1[W/m/K]', 'Interconnect thermal conductivity');
model.param.set('x0_H2O', '0.498', 'Initial mole fraction of H2O');
model.param.set('x0_CO2', '0.5', 'Initial mole fraction of CO2');
model.param.set('x0_CO', '0.001', 'Initial mole fraction of CO');
model.param.set('x0_H2', '0.001', 'Initial mole fraction of H2');
model.param.set('w0_H2O', 'x0_H2O*18[g/mol]/(x0_H2O*18[g/mol]+x0_CO2*44[g/mol]+x0_CO*28[g/mol]+x0_H2*2[g/mol])', 'Initial mass fraction of H2O');
model.param.set('w0_CO2', 'x0_CO2*44[g/mol]/(x0_H2O*18[g/mol]+x0_CO2*44[g/mol]+x0_CO*28[g/mol]+x0_H2*2[g/mol])', 'Initial mass fraction of CO2');
model.param.set('w0_CO', 'x0_CO*28[g/mol]/(x0_H2O*18[g/mol]+x0_CO2*44[g/mol]+x0_CO*28[g/mol]+x0_H2*2[g/mol])', 'Initial mass fraction of CO');
model.param.set('x0_N2', '0.79', 'Initial mole fraction of N2');
model.param.set('w0_N2', 'x0_N2*28[g/mol]/(x0_N2*28[g/mol]+0.21*32[g/mol])', 'Initial mass fraction of N2');
model.param.set('kappag_GDE', '1e-10[m^2]', 'Gas permeability, gas diffusion electrode');
model.param.set('S', '1e9[m^2/m^3]', 'Electrode specific surface area');
model.param.set('i0_ref_HER', '1[A/m^2]', 'Reference exchange current density for H2O electrolysis');
model.param.set('i0_ref_COER', '1[A/m^2]', 'Reference exchange current density for CO2 electrolysis');
model.param.set('i0_ref_OER', '1[A/m^2]', 'Reference exchange current density for oxygen evolution reaction');

model.geom('geom1').create('r1', 'Rectangle');
model.geom('geom1').feature('r1').set('size', {'L' 'W'});
model.geom('geom1').feature('r1').setIndex('layer', 'di', 0);
model.geom('geom1').feature('r1').setIndex('layer', 'dg', 1);
model.geom('geom1').feature('r1').setIndex('layer', 'da', 2);
model.geom('geom1').feature('r1').setIndex('layer', 'dm', 3);
model.geom('geom1').feature('r1').setIndex('layer', 'dc', 4);
model.geom('geom1').feature('r1').setIndex('layer', 'dg', 5);
model.geom('geom1').runPre('fin');

model.variable.create('var1');
model.variable('var1').model('comp1');

model.geom('geom1').run;

% To import content from file, use:
% model.variable('var1').loadFile('FILENAME');
model.variable('var1').set('k_wgsr', '0.0171*exp(-103191[J/mol]/(R_const*T)) [mol/m^3/s]', 'Water gas shift reaction rate constant');

model.cpl.create('genproj1', 'GeneralProjection', 'geom1');
model.cpl('genproj1').selection.set([5]);

model.physics('we').prop('H2GasMixture').set('CO2', true);
model.physics('we').prop('H2GasMixture').set('CO', true);
model.physics('we').prop('H2GasMixture').set('GasMixtureDarcy', true);
model.physics('we').prop('O2GasMixture').set('N2', true);
model.physics('we').prop('O2GasMixture').set('GasPhaseDiffusion', true);
model.physics('we').prop('O2GasMixture').set('GasMixtureDarcy', true);
model.physics('we').create('mem1', 'Membrane', 2);
model.physics('we').feature('mem1').selection.set([4]);
model.physics('we').create('h2gde1', 'H2GasDiffusionElectrode', 2);
model.physics('we').feature('h2gde1').selection.set([5]);
model.physics('we').feature('h2gde1').set('epsl', 'epsl');
model.physics('we').feature('h2gde1').set('DiffusionCorrModel', 'Tortuosity');
model.physics('we').feature('h2gde1').set('epsg', 'epsg');
model.physics('we').feature('h2gde1').set('taug', {'taug' '0' '0' '0' 'taug' '0' '0' '0' 'taug'});
model.physics('we').feature('h2gde1').set('kappag', {'kappag_GDE' '0' '0' '0' 'kappag_GDE' '0' '0' '0' 'kappag_GDE'});
model.physics('we').feature('h2gde1').feature('h2gder1').label('H2 Gas Diffusion Electrode Reaction: Water Electrolysis');
model.physics('we').feature('h2gde1').feature('h2gder1').set('i0_ref', 'i0_ref_HER');
model.physics('we').feature('h2gde1').feature('h2gder1').set('alphaa', 0.5);
model.physics('we').feature('h2gde1').feature('h2gder1').set('Av', 'S');
model.physics('we').feature('h2gde1').create('h2gder2', 'H2GasDiffusionElectrodeReaction', 2);
model.physics('we').feature('h2gde1').feature('h2gder2').label('H2 Gas Diffusion Electrode Reaction: CO2 Electrolysis');
model.physics('we').feature('h2gde1').feature('h2gder2').set('nuCO2', -1);
model.physics('we').feature('h2gde1').feature('h2gder2').set('nuCO', 1);
model.physics('we').feature('h2gde1').feature('h2gder2').set('i0_ref', 'i0_ref_COER');
model.physics('we').feature('h2gde1').feature('h2gder2').set('Av', 'S');
model.physics('we').create('o2gde1', 'O2GasDiffusionElectrode', 2);
model.physics('we').feature('o2gde1').selection.set([3]);
model.physics('we').feature('o2gde1').set('epsl', 'epsl');
model.physics('we').feature('o2gde1').set('DiffusionCorrModel', 'Tortuosity');
model.physics('we').feature('o2gde1').set('epsg', 'epsg');
model.physics('we').feature('o2gde1').set('taug', {'taug' '0' '0' '0' 'taug' '0' '0' '0' 'taug'});
model.physics('we').feature('o2gde1').set('kappag', {'kappag_GDE' '0' '0' '0' 'kappag_GDE' '0' '0' '0' 'kappag_GDE'});
model.physics('we').feature('o2gde1').feature('o2gder1').set('i0_ref', 'i0_ref_OER');
model.physics('we').feature('o2gde1').feature('o2gder1').set('Av', 'S');
model.physics('we').create('h2fch1', 'H2FlowChannel', 2);
model.physics('we').feature('h2fch1').selection.set([6]);
model.physics('we').feature('h2fch1').set('GasPermeabilityModel', 'StraightChannels');
model.physics('we').feature('h2fch1').set('H_ch', 'dg');
model.physics('we').feature('h2fch1').set('W_ch', 'dg');
model.physics('we').create('o2fch1', 'O2FlowChannel', 2);
model.physics('we').feature('o2fch1').selection.set([2]);
model.physics('we').feature('o2fch1').set('GasPermeabilityModel', 'StraightChannels');
model.physics('we').feature('o2fch1').set('H_ch', 'dg');
model.physics('we').feature('o2fch1').set('W_ch', 'dg');
model.physics('we').create('cc1', 'CurrentCollector', 2);
model.physics('we').feature('cc1').selection.set([1 7]);
model.physics('we').feature('cc1').set('sigmas_mat', 'from_mat');
model.physics('we').feature('ecph1').create('inito2dom1', 'InitialValuesO2Domains', 2);
model.physics('we').feature('ecph1').feature('inito2dom1').selection.set([3]);
model.physics('we').feature('ecph1').feature('inito2dom1').set('initphis', 'E_app');
model.physics('we').feature('ecph1').create('egnd1', 'ElectricGround', 1);
model.physics('we').feature('ecph1').feature('egnd1').selection.set([12]);
model.physics('we').feature('ecph1').create('pot1', 'ElectricPotential', 1);
model.physics('we').feature('ecph1').feature('pot1').selection.set([6]);
model.physics('we').feature('ecph1').feature('pot1').set('phisbnd', 'E_app');
model.physics('we').feature('h2gasph1').feature('init1').set('x0H2O', 'x0_H2O');
model.physics('we').feature('h2gasph1').feature('init1').set('x0CO2', 'x0_CO2');
model.physics('we').feature('h2gasph1').feature('init1').set('x0CO', 'x0_CO');
model.physics('we').feature('h2gasph1').create('wgsr1', 'WaterGasShiftReaction', 2);
model.physics('we').feature('h2gasph1').feature('wgsr1').set('k_wgsr', 'k_wgsr');
model.physics('we').feature('h2gasph1').feature('wgsr1').set('pref', '1[Pa]');
model.physics('we').feature('h2gasph1').create('h2in1', 'H2Inlet', 1);
model.physics('we').feature('h2gasph1').feature('h2in1').selection.set([11]);
model.physics('we').feature('h2gasph1').feature('h2in1').set('MixtureSpecification', 'MassFlowRates');
model.physics('we').feature('h2gasph1').feature('h2in1').set('J0H2O', 'Mflux_in*w0_H2O');
model.physics('we').feature('h2gasph1').feature('h2in1').set('J0CO2', 'Mflux_in*w0_CO2');
model.physics('we').feature('h2gasph1').feature('h2in1').set('J0CO', 'Mflux_in*w0_CO');
model.physics('we').feature('h2gasph1').feature('h2in1').set('w0bndH2O', 'w0_H2O');
model.physics('we').feature('h2gasph1').feature('h2in1').set('w0bndCO2', 'w0_CO2');
model.physics('we').feature('h2gasph1').feature('h2in1').set('w0bndCO', 'w0_CO');
model.physics('we').feature('h2gasph1').feature('h2in1').set('FlowBoundaryCondition', 'TotalMassFlowRate');
model.physics('we').feature('h2gasph1').feature('h2in1').set('J0', 'Mflux_in');
model.physics('we').feature('h2gasph1').create('h2out1', 'H2Outlet', 1);
model.physics('we').feature('h2gasph1').feature('h2out1').selection.set([21]);
model.physics('we').feature('o2gasph1').feature('init1').set('x0N2', 'x0_N2');
model.physics('we').feature('o2gasph1').create('o2in1', 'O2Inlet', 1);
model.physics('we').feature('o2gasph1').feature('o2in1').selection.set([3]);
model.physics('we').feature('o2gasph1').feature('o2in1').set('MixtureSpecification', 'MassFlowRates');
model.physics('we').feature('o2gasph1').feature('o2in1').set('J0N2', 'Mflux_in*w0_N2');
model.physics('we').feature('o2gasph1').feature('o2in1').set('w0bndN2', 'w0_N2');
model.physics('we').feature('o2gasph1').feature('o2in1').set('FlowBoundaryCondition', 'TotalMassFlowRate');
model.physics('we').feature('o2gasph1').feature('o2in1').set('J0', 'Mflux_in');
model.physics('we').feature('o2gasph1').create('o2out1', 'O2Outlet', 1);
model.physics('we').feature('o2gasph1').feature('o2out1').selection.set([17]);
model.physics('ht').prop('PhysicalModelProperty').set('Tref', 'T_in');
model.physics('ht').feature('solid1').label('Solid: Interconnects');
model.physics('ht').feature('fluid1').label('Fluid: Flow Channels');
model.physics('ht').feature('fluid1').selection.set([2 6]);
model.physics('ht').feature('fluid1').set('minput_pressure_src', 'userdef');
model.physics('ht').feature('fluid1').set('minput_pressure', 'we.pA');
model.physics('ht').feature('fluid1').set('u', {'we.u' 'we.v' '0'});
model.physics('ht').feature('fluid1').set('k_mat', 'root.comp1.we.kgas_mix_tensorxx');
model.physics('ht').feature('fluid1').set('fluidType', 'gasLiquid');
model.physics('ht').feature('fluid1').set('rho_mat', 'root.comp1.we.rho');
model.physics('ht').feature('fluid1').set('Cp_mat', 'root.comp1.we.Cp_mix');
model.physics('ht').feature('init1').set('Tinit', 'T_in');
model.physics('ht').create('porous1', 'PorousMediumHeatTransferModel', 2);
model.physics('ht').feature('porous1').label('Porous Medium: Cathode GDE');
model.physics('ht').feature('porous1').selection.set([5]);
model.physics('ht').feature('porous1').feature('fluid1').set('minput_pressure_src', 'userdef');
model.physics('ht').feature('porous1').feature('fluid1').set('minput_pressure', 'we.pA');
model.physics('ht').feature('porous1').feature('fluid1').set('u', {'we.u' 'we.v' '0'});
model.physics('ht').feature('porous1').feature('fluid1').set('k_mat', 'root.comp1.we.kgas_mix_tensorxx');
model.physics('ht').feature('porous1').feature('fluid1').set('rho_mat', 'root.comp1.we.rho');
model.physics('ht').feature('porous1').feature('fluid1').set('Cp_mat', 'root.comp1.we.Cp_mix');
model.physics('ht').feature('porous1').feature('pm1').set('poro_mat', 'userdef');
model.physics('ht').feature('porous1').feature('pm1').set('poro', 'epsg');
model.physics('ht').feature('porous1').feature('pm1').set('k_b_mat', 'userdef');
model.physics('ht').feature('porous1').feature('pm1').set('k_b', {'kc' '0' '0' '0' 'kc' '0' '0' '0' 'kc'});
model.physics('ht').feature('porous1').feature('pm1').set('rho_b_mat', 'userdef');
model.physics('ht').feature('porous1').feature('pm1').set('Cp_b_mat', 'userdef');
model.physics('ht').create('porous2', 'PorousMediumHeatTransferModel', 2);
model.physics('ht').feature('porous2').label('Porous Medium: Anode GDE');
model.physics('ht').feature('porous2').selection.set([3]);
model.physics('ht').feature('porous2').feature('fluid1').set('minput_pressure_src', 'userdef');
model.physics('ht').feature('porous2').feature('fluid1').set('minput_pressure', 'we.pA');
model.physics('ht').feature('porous2').feature('fluid1').set('u', {'we.u' 'we.v' '0'});
model.physics('ht').feature('porous2').feature('fluid1').set('k_mat', 'root.comp1.we.kgas_mix_tensorxx');
model.physics('ht').feature('porous2').feature('fluid1').set('rho_mat', 'root.comp1.we.rho');
model.physics('ht').feature('porous2').feature('fluid1').set('Cp_mat', 'root.comp1.we.Cp_mix');
model.physics('ht').feature('porous2').feature('pm1').set('poro_mat', 'userdef');
model.physics('ht').feature('porous2').feature('pm1').set('poro', 'epsg');
model.physics('ht').feature('porous2').feature('pm1').set('k_b_mat', 'userdef');
model.physics('ht').feature('porous2').feature('pm1').set('k_b', {'ka' '0' '0' '0' 'ka' '0' '0' '0' 'ka'});
model.physics('ht').feature('porous2').feature('pm1').set('rho_b_mat', 'userdef');
model.physics('ht').feature('porous2').feature('pm1').set('Cp_b_mat', 'userdef');
model.physics('ht').create('solid2', 'SolidHeatTransferModel', 2);
model.physics('ht').feature('solid2').label('Solid: Membrane');
model.physics('ht').feature('solid2').selection.set([4]);
model.physics('ht').feature('solid2').set('k_mat', 'userdef');
model.physics('ht').feature('solid2').set('k', {'km' '0' '0' '0' 'km' '0' '0' '0' 'km'});
model.physics('ht').feature('solid2').set('rho_mat', 'userdef');
model.physics('ht').feature('solid2').set('Cp_mat', 'userdef');
model.physics('ht').create('ifl1', 'Inflow', 1);
model.physics('ht').feature('ifl1').selection.set([3 11]);
model.physics('ht').feature('ifl1').set('Tustr', 'T_in');
model.physics('ht').create('ofl1', 'ConvectiveOutflow', 1);
model.physics('ht').feature('ofl1').selection.set([17 21]);
model.physics('ht').create('pc1', 'PeriodicHeat', 1);
model.physics('ht').feature('pc1').selection.set([2 15]);

model.multiphysics.create('ech1', 'ElectrochemicalHeating', 'geom1', 2);

model.material.create('mat1', 'Common', 'comp1');
model.material('mat1').propertyGroup.create('ElectrolyteConductivity', 'Electrolyte conductivity');
model.material('mat1').propertyGroup('ElectrolyteConductivity').func.create('int1', 'Interpolation');
model.material('mat1').label('Yttria-Stabilized Zirconia, 8YSZ, (ZrO2)0.92-(Y2O3)0.08');
model.material('mat1').propertyGroup('ElectrolyteConductivity').func('int1').set('funcname', 'log_sigmaT_vs_invT');
model.material('mat1').propertyGroup('ElectrolyteConductivity').func('int1').set('table', {'0.8202666666666667' '2.2431906614786';  ...
'0.8526222222222222' '2.0972762645914402';  ...
'0.8912' '1.922178988326849';  ...
'0.9335111111111112' '1.7373540856031133';  ...
'0.9820444444444445' '1.5233463035019446';  ...
'1.0268444444444444' '1.319066147859922';  ...
'1.0766222222222224' '1.0856031128404666';  ...
'1.1463111111111113' '0.745136186770428';  ...
'1.2160000000000002' '0.3754863813229572';  ...
'1.296888888888889' '-0.03307392996108938';  ...
'1.384' '-0.5097276264591439';  ...
'1.4860444444444445' '-1.073929961089494';  ...
'1.6042666666666667' '-1.735408560311284';  ...
'1.7424000000000002' '-2.5136186770428006'});
model.material('mat1').propertyGroup('ElectrolyteConductivity').func('int1').set('fununit', {'1'});
model.material('mat1').propertyGroup('ElectrolyteConductivity').func('int1').set('argunit', {'1/K'});
model.material('mat1').propertyGroup('ElectrolyteConductivity').set('sigmal', {'(10^(log_sigmaT_vs_invT(1000/T_reg))[S/cm*K])/T_reg' '0' '0' '0' '(10^(log_sigmaT_vs_invT(1000/T_reg))[S/cm*K])/T_reg' '0' '0' '0' '(10^(log_sigmaT_vs_invT(1000/T_reg))[S/cm*K])/T_reg'});
model.material('mat1').propertyGroup('ElectrolyteConductivity').set('INFO_PREFIX:sigmal', ['Electrolytes for solid oxide fuel cells, J. Fergus, Journal of Power Sources 162 (2006) 30' native2unicode(hex2dec({'20' '13'}), 'unicode') '40.' newline  newline 'Conductivity values averaged from Figure 2.' newline ]);
model.material('mat1').propertyGroup('ElectrolyteConductivity').set('T_reg', 'max(min(T,1/0.8203e-3),1/1.74e-3)');
model.material('mat1').propertyGroup('ElectrolyteConductivity').descr('T_reg', 'Temperature (regularized to valid range)');
model.material('mat1').propertyGroup('ElectrolyteConductivity').addInput('temperature');
model.material('mat1').selection.set([3 4 5]);
model.material.create('mat2', 'Common', 'comp1');
model.material('mat2').propertyGroup.create('Enu', 'Young''s modulus and Poisson''s ratio');
model.material('mat2').label('Steel AISI 4340');
model.material('mat2').set('family', 'steel');
model.material('mat2').propertyGroup('def').set('relpermeability', {'1' '0' '0' '0' '1' '0' '0' '0' '1'});
model.material('mat2').propertyGroup('def').set('electricconductivity', {'4.032e6[S/m]' '0' '0' '0' '4.032e6[S/m]' '0' '0' '0' '4.032e6[S/m]'});
model.material('mat2').propertyGroup('def').set('thermalexpansioncoefficient', {'12.3e-6[1/K]' '0' '0' '0' '12.3e-6[1/K]' '0' '0' '0' '12.3e-6[1/K]'});
model.material('mat2').propertyGroup('def').set('heatcapacity', '475[J/(kg*K)]');
model.material('mat2').propertyGroup('def').set('relpermittivity', {'1' '0' '0' '0' '1' '0' '0' '0' '1'});
model.material('mat2').propertyGroup('def').set('density', '7850[kg/m^3]');
model.material('mat2').propertyGroup('def').set('thermalconductivity', {'44.5[W/(m*K)]' '0' '0' '0' '44.5[W/(m*K)]' '0' '0' '0' '44.5[W/(m*K)]'});
model.material('mat2').propertyGroup('Enu').set('E', '205[GPa]');
model.material('mat2').propertyGroup('Enu').set('nu', '0.28');
model.material('mat2').selection.set([1 7]);

model.mesh('mesh1').create('dis1', 'Distribution');
model.mesh('mesh1').feature('dis1').selection.set([2 4 6 8 10 12 14 15]);
model.mesh('mesh1').feature('dis1').set('numelem', 100);
model.mesh('mesh1').create('dis2', 'Distribution');
model.mesh('mesh1').feature('dis2').selection.set([1 13 16 22]);
model.mesh('mesh1').feature('dis2').set('numelem', 2);
model.mesh('mesh1').create('dis3', 'Distribution');
model.mesh('mesh1').feature('dis3').selection.set([3 11 17 21]);
model.mesh('mesh1').feature('dis3').set('numelem', 10);
model.mesh('mesh1').create('dis4', 'Distribution');
model.mesh('mesh1').feature('dis4').selection.set([7 19]);
model.mesh('mesh1').feature('dis4').set('numelem', 2);
model.mesh('mesh1').create('dis5', 'Distribution');
model.mesh('mesh1').feature('dis5').selection.set([9 20]);
model.mesh('mesh1').feature('dis5').set('type', 'predefined');
model.mesh('mesh1').feature('dis5').set('elemcount', 20);
model.mesh('mesh1').feature('dis5').set('elemratio', 10);
model.mesh('mesh1').feature('dis5').set('growthrate', 'exponential');
model.mesh('mesh1').create('dis6', 'Distribution');
model.mesh('mesh1').feature('dis6').selection.set([5 18]);
model.mesh('mesh1').feature('dis6').set('type', 'predefined');
model.mesh('mesh1').feature('dis6').set('elemcount', 10);
model.mesh('mesh1').feature('dis6').set('elemratio', 5);
model.mesh('mesh1').feature('dis6').set('growthrate', 'exponential');
model.mesh('mesh1').feature('dis6').set('reverse', true);
model.mesh('mesh1').create('map1', 'Map');
model.mesh('mesh1').run;

model.study('std1').feature('cdi').set('initType', 'secondary');
model.study('std1').feature('stat').set('useparam', true);
model.study('std1').feature('stat').setIndex('pname', 'T_in', 0);
model.study('std1').feature('stat').setIndex('plistarr', '', 0);
model.study('std1').feature('stat').setIndex('punit', 'K', 0);
model.study('std1').feature('stat').setIndex('pname', 'T_in', 0);
model.study('std1').feature('stat').setIndex('plistarr', '', 0);
model.study('std1').feature('stat').setIndex('punit', 'K', 0);
model.study('std1').feature('stat').setIndex('pname', 'E_app', 0);
model.study('std1').feature('stat').setIndex('plistarr', '0.5 1 1.5', 0);

model.sol.create('sol1');
model.sol('sol1').study('std1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'cdi');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').feature('comp1_we_phil').set('scalemethod', 'manual');
model.sol('sol1').feature('v1').feature('comp1_we_phis').set('scalemethod', 'manual');
model.sol('sol1').feature('v1').feature('comp1_we_phil').set('scaleval', '1');
model.sol('sol1').feature('v1').feature('comp1_we_phis').set('scaleval', '1');
model.sol('sol1').feature('v1').set('control', 'cdi');
model.sol('sol1').create('s1', 'Stationary');
model.sol('sol1').feature('s1').set('stol', 1.0E-4);
model.sol('sol1').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('s1').feature('fc1').set('dtech', 'auto');
model.sol('sol1').feature('s1').feature('fc1').set('maxiter', 50);
model.sol('sol1').feature('s1').feature('fc1').set('minstep', 1.0E-6);
model.sol('sol1').feature('s1').create('d1', 'Direct');
model.sol('sol1').feature('s1').feature('d1').set('linsolver', 'pardiso');
model.sol('sol1').feature('s1').feature('d1').label('Direct (we)');
model.sol('sol1').feature('s1').create('i1', 'Iterative');
model.sol('sol1').feature('s1').feature('i1').set('maxlinit', 1000);
model.sol('sol1').feature('s1').feature('i1').set('nlinnormuse', 'on');
model.sol('sol1').feature('s1').feature('i1').label('Algebraic Multigrid (we)');
model.sol('sol1').feature('s1').feature('i1').create('mg1', 'Multigrid');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').set('prefun', 'saamg');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').set('maxcoarsedof', 50000);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').set('saamgcompwise', true);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').set('compactaggregation', true);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('pr').create('sc1', 'SCGS');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('pr').feature('sc1').set('linesweeptype', 'ssor');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('pr').feature('sc1').set('iter', 1);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('pr').feature('sc1').set('scgsmethod', 'lines');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('po').create('sc1', 'SCGS');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('po').feature('sc1').set('linesweeptype', 'ssor');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('po').feature('sc1').set('iter', 1);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('po').feature('sc1').set('scgsmethod', 'lines');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('cs').create('d1', 'Direct');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('cs').feature('d1').set('linsolver', 'pardiso');
model.sol('sol1').feature('s1').create('i2', 'Iterative');
model.sol('sol1').feature('s1').feature('i2').set('maxlinit', 1000);
model.sol('sol1').feature('s1').feature('i2').set('nlinnormuse', 'on');
model.sol('sol1').feature('s1').feature('i2').label('Geometric Multigrid (we)');
model.sol('sol1').feature('s1').feature('i2').create('mg1', 'Multigrid');
model.sol('sol1').feature('s1').feature('i2').feature('mg1').feature('pr').create('sc1', 'SCGS');
model.sol('sol1').feature('s1').feature('i2').feature('mg1').feature('pr').feature('sc1').set('linesweeptype', 'ssor');
model.sol('sol1').feature('s1').feature('i2').feature('mg1').feature('pr').feature('sc1').set('iter', 1);
model.sol('sol1').feature('s1').feature('i2').feature('mg1').feature('pr').feature('sc1').set('scgsmethod', 'lines');
model.sol('sol1').feature('s1').feature('i2').feature('mg1').feature('po').create('sc1', 'SCGS');
model.sol('sol1').feature('s1').feature('i2').feature('mg1').feature('po').feature('sc1').set('linesweeptype', 'ssor');
model.sol('sol1').feature('s1').feature('i2').feature('mg1').feature('po').feature('sc1').set('iter', 1);
model.sol('sol1').feature('s1').feature('i2').feature('mg1').feature('po').feature('sc1').set('scgsmethod', 'lines');
model.sol('sol1').feature('s1').feature('i2').feature('mg1').feature('cs').create('d1', 'Direct');
model.sol('sol1').feature('s1').feature('i2').feature('mg1').feature('cs').feature('d1').set('linsolver', 'pardiso');
model.sol('sol1').feature('s1').feature('fc1').set('linsolver', 'd1');
model.sol('sol1').feature('s1').feature('fc1').set('dtech', 'auto');
model.sol('sol1').feature('s1').feature('fc1').set('maxiter', 50);
model.sol('sol1').feature('s1').feature('fc1').set('minstep', 1.0E-6);
model.sol('sol1').feature('s1').feature.remove('fcDef');
model.sol('sol1').create('su1', 'StoreSolution');
model.sol('sol1').create('st2', 'StudyStep');
model.sol('sol1').feature('st2').set('study', 'std1');
model.sol('sol1').feature('st2').set('studystep', 'stat');
model.sol('sol1').create('v2', 'Variables');
model.sol('sol1').feature('v2').feature('comp1_we_wH2O_H2').set('scalemethod', 'manual');
model.sol('sol1').feature('v2').feature('comp1_we_wCO_H2').set('scalemethod', 'manual');
model.sol('sol1').feature('v2').feature('comp1_we_h2gasph1_h2in1_wbndH2O').set('scalemethod', 'manual');
model.sol('sol1').feature('v2').feature('comp1_we_h2gasph1_h2in1_wbndCO2').set('scalemethod', 'manual');
model.sol('sol1').feature('v2').feature('comp1_we_wN2_O2').set('scalemethod', 'manual');
model.sol('sol1').feature('v2').feature('comp1_we_o2gasph1_o2in1_wbndN2').set('scalemethod', 'manual');
model.sol('sol1').feature('v2').feature('comp1_we_phil').set('scalemethod', 'manual');
model.sol('sol1').feature('v2').feature('comp1_we_h2gasph1_h2in1_wbndCO').set('scalemethod', 'manual');
model.sol('sol1').feature('v2').feature('comp1_we_phis').set('scalemethod', 'manual');
model.sol('sol1').feature('v2').feature('comp1_we_wCO2_H2').set('scalemethod', 'manual');
model.sol('sol1').feature('v2').feature('comp1_we_wH2O_H2').set('scaleval', '1');
model.sol('sol1').feature('v2').feature('comp1_we_wCO_H2').set('scaleval', '1');
model.sol('sol1').feature('v2').feature('comp1_we_h2gasph1_h2in1_wbndH2O').set('scaleval', '1');
model.sol('sol1').feature('v2').feature('comp1_we_h2gasph1_h2in1_wbndCO2').set('scaleval', '1');
model.sol('sol1').feature('v2').feature('comp1_we_wN2_O2').set('scaleval', '1');
model.sol('sol1').feature('v2').feature('comp1_we_o2gasph1_o2in1_wbndN2').set('scaleval', '1');
model.sol('sol1').feature('v2').feature('comp1_we_phil').set('scaleval', '1');
model.sol('sol1').feature('v2').feature('comp1_we_h2gasph1_h2in1_wbndCO').set('scaleval', '1');
model.sol('sol1').feature('v2').feature('comp1_we_phis').set('scaleval', '1');
model.sol('sol1').feature('v2').feature('comp1_we_wCO2_H2').set('scaleval', '1');
model.sol('sol1').feature('v2').set('initmethod', 'sol');
model.sol('sol1').feature('v2').set('initsol', 'sol1');
model.sol('sol1').feature('v2').set('initsoluse', 'sol2');
model.sol('sol1').feature('v2').set('notsolmethod', 'sol');
model.sol('sol1').feature('v2').set('notsol', 'sol1');
model.sol('sol1').feature('v2').set('control', 'stat');
model.sol('sol1').create('s2', 'Stationary');
model.sol('sol1').feature('s2').set('stol', 1.0E-4);
model.sol('sol1').feature('s2').create('p1', 'Parametric');
model.sol('sol1').feature('s2').feature.remove('pDef');
model.sol('sol1').feature('s2').feature('p1').set('porder', 'constant');
model.sol('sol1').feature('s2').feature('p1').set('control', 'stat');
model.sol('sol1').feature('s2').set('control', 'stat');
model.sol('sol1').feature('s2').create('seDef', 'Segregated');
model.sol('sol1').feature('s2').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('s2').feature('fc1').set('dtech', 'auto');
model.sol('sol1').feature('s2').feature('fc1').set('initstep', 0.01);
model.sol('sol1').feature('s2').feature('fc1').set('minstep', 1.0E-6);
model.sol('sol1').feature('s2').feature('fc1').set('maxiter', 50);
model.sol('sol1').feature('s2').feature('fc1').set('termonres', 'off');
model.sol('sol1').feature('s2').create('d1', 'Direct');
model.sol('sol1').feature('s2').feature('d1').set('linsolver', 'pardiso');
model.sol('sol1').feature('s2').feature('d1').set('pivotperturb', 1.0E-13);
model.sol('sol1').feature('s2').feature('d1').label('Direct, heat transfer variables (ht) (Merged)');
model.sol('sol1').feature('s2').create('i1', 'Iterative');
model.sol('sol1').feature('s2').feature('i1').set('maxlinit', 1000);
model.sol('sol1').feature('s2').feature('i1').set('nlinnormuse', 'on');
model.sol('sol1').feature('s2').feature('i1').label('Algebraic Multigrid (we)');
model.sol('sol1').feature('s2').feature('i1').create('mg1', 'Multigrid');
model.sol('sol1').feature('s2').feature('i1').feature('mg1').set('prefun', 'saamg');
model.sol('sol1').feature('s2').feature('i1').feature('mg1').set('maxcoarsedof', 50000);
model.sol('sol1').feature('s2').feature('i1').feature('mg1').set('saamgcompwise', true);
model.sol('sol1').feature('s2').feature('i1').feature('mg1').set('compactaggregation', true);
model.sol('sol1').feature('s2').feature('i1').feature('mg1').feature('pr').create('sc1', 'SCGS');
model.sol('sol1').feature('s2').feature('i1').feature('mg1').feature('pr').feature('sc1').set('linesweeptype', 'ssor');
model.sol('sol1').feature('s2').feature('i1').feature('mg1').feature('pr').feature('sc1').set('iter', 1);
model.sol('sol1').feature('s2').feature('i1').feature('mg1').feature('pr').feature('sc1').set('scgsmethod', 'lines');
model.sol('sol1').feature('s2').feature('i1').feature('mg1').feature('po').create('sc1', 'SCGS');
model.sol('sol1').feature('s2').feature('i1').feature('mg1').feature('po').feature('sc1').set('linesweeptype', 'ssor');
model.sol('sol1').feature('s2').feature('i1').feature('mg1').feature('po').feature('sc1').set('iter', 1);
model.sol('sol1').feature('s2').feature('i1').feature('mg1').feature('po').feature('sc1').set('scgsmethod', 'lines');
model.sol('sol1').feature('s2').feature('i1').feature('mg1').feature('cs').create('d1', 'Direct');
model.sol('sol1').feature('s2').feature('i1').feature('mg1').feature('cs').feature('d1').set('linsolver', 'pardiso');
model.sol('sol1').feature('s2').create('i2', 'Iterative');
model.sol('sol1').feature('s2').feature('i2').set('maxlinit', 1000);
model.sol('sol1').feature('s2').feature('i2').set('nlinnormuse', 'on');
model.sol('sol1').feature('s2').feature('i2').label('Geometric Multigrid (we)');
model.sol('sol1').feature('s2').feature('i2').create('mg1', 'Multigrid');
model.sol('sol1').feature('s2').feature('i2').feature('mg1').feature('pr').create('sc1', 'SCGS');
model.sol('sol1').feature('s2').feature('i2').feature('mg1').feature('pr').feature('sc1').set('linesweeptype', 'ssor');
model.sol('sol1').feature('s2').feature('i2').feature('mg1').feature('pr').feature('sc1').set('iter', 1);
model.sol('sol1').feature('s2').feature('i2').feature('mg1').feature('pr').feature('sc1').set('scgsmethod', 'lines');
model.sol('sol1').feature('s2').feature('i2').feature('mg1').feature('po').create('sc1', 'SCGS');
model.sol('sol1').feature('s2').feature('i2').feature('mg1').feature('po').feature('sc1').set('linesweeptype', 'ssor');
model.sol('sol1').feature('s2').feature('i2').feature('mg1').feature('po').feature('sc1').set('iter', 1);
model.sol('sol1').feature('s2').feature('i2').feature('mg1').feature('po').feature('sc1').set('scgsmethod', 'lines');
model.sol('sol1').feature('s2').feature('i2').feature('mg1').feature('cs').create('d1', 'Direct');
model.sol('sol1').feature('s2').feature('i2').feature('mg1').feature('cs').feature('d1').set('linsolver', 'pardiso');
model.sol('sol1').feature('s2').create('i3', 'Iterative');
model.sol('sol1').feature('s2').feature('i3').set('linsolver', 'gmres');
model.sol('sol1').feature('s2').feature('i3').set('prefuntype', 'left');
model.sol('sol1').feature('s2').feature('i3').set('itrestart', 50);
model.sol('sol1').feature('s2').feature('i3').set('rhob', 20);
model.sol('sol1').feature('s2').feature('i3').set('maxlinit', 10000);
model.sol('sol1').feature('s2').feature('i3').set('nlinnormuse', 'on');
model.sol('sol1').feature('s2').feature('i3').label('AMG, heat transfer variables (ht)');
model.sol('sol1').feature('s2').feature('i3').create('mg1', 'Multigrid');
model.sol('sol1').feature('s2').feature('i3').feature('mg1').set('prefun', 'saamg');
model.sol('sol1').feature('s2').feature('i3').feature('mg1').set('mgcycle', 'v');
model.sol('sol1').feature('s2').feature('i3').feature('mg1').set('maxcoarsedof', 50000);
model.sol('sol1').feature('s2').feature('i3').feature('mg1').set('strconn', 0.01);
model.sol('sol1').feature('s2').feature('i3').feature('mg1').set('nullspace', 'constant');
model.sol('sol1').feature('s2').feature('i3').feature('mg1').set('usesmooth', false);
model.sol('sol1').feature('s2').feature('i3').feature('mg1').set('saamgcompwise', true);
model.sol('sol1').feature('s2').feature('i3').feature('mg1').set('loweramg', true);
model.sol('sol1').feature('s2').feature('i3').feature('mg1').set('compactaggregation', false);
model.sol('sol1').feature('s2').feature('i3').feature('mg1').feature('pr').create('so1', 'SOR');
model.sol('sol1').feature('s2').feature('i3').feature('mg1').feature('pr').feature('so1').set('iter', 2);
model.sol('sol1').feature('s2').feature('i3').feature('mg1').feature('pr').feature('so1').set('relax', 0.9);
model.sol('sol1').feature('s2').feature('i3').feature('mg1').feature('po').create('so1', 'SOR');
model.sol('sol1').feature('s2').feature('i3').feature('mg1').feature('po').feature('so1').set('iter', 2);
model.sol('sol1').feature('s2').feature('i3').feature('mg1').feature('po').feature('so1').set('relax', 0.9);
model.sol('sol1').feature('s2').feature('i3').feature('mg1').feature('cs').create('d1', 'Direct');
model.sol('sol1').feature('s2').feature('i3').feature('mg1').feature('cs').feature('d1').set('linsolver', 'pardiso');
model.sol('sol1').feature('s2').feature('i3').feature('mg1').feature('cs').feature('d1').set('pivotperturb', 1.0E-13);
model.sol('sol1').feature('s2').feature('fc1').set('linsolver', 'd1');
model.sol('sol1').feature('s2').feature('fc1').set('dtech', 'auto');
model.sol('sol1').feature('s2').feature('fc1').set('initstep', 0.01);
model.sol('sol1').feature('s2').feature('fc1').set('minstep', 1.0E-6);
model.sol('sol1').feature('s2').feature('fc1').set('maxiter', 50);
model.sol('sol1').feature('s2').feature('fc1').set('termonres', 'off');
model.sol('sol1').feature('s2').feature.remove('fcDef');
model.sol('sol1').feature('s2').feature.remove('seDef');
model.sol('sol1').feature('v2').set('notsolnum', 'auto');
model.sol('sol1').feature('v2').set('notsolvertype', 'solnum');
model.sol('sol1').attach('std1');
model.sol('sol1').runAll;

model.result.create('pg1', 'PlotGroup2D');
model.result('pg1').set('data', 'dset1');
model.result('pg1').setIndex('looplevel', 3, 0);
model.result('pg1').label('Electrode Potential with Respect to Ground (we)');
model.result('pg1').create('surf1', 'Surface');
model.result('pg1').feature('surf1').set('expr', {'we.phis'});
model.result('pg1').create('arws1', 'ArrowSurface');
model.result('pg1').feature('arws1').set('expr', {'we.Isx' 'we.Isy'});
model.result('pg1').feature('arws1').set('arrowbase', 'center');
model.result('pg1').feature('arws1').set('color', 'gray');
model.result('pg1').feature('arws1').create('filt1', 'Filter');
model.result('pg1').feature('arws1').feature('filt1').set('expr', 'isdefined(root.comp1.we.phis)');
model.result('pg1').feature('arws1').feature('filt1').set('nodespec', 'all');
model.result.create('pg2', 'PlotGroup2D');
model.result('pg2').set('data', 'dset1');
model.result('pg2').setIndex('looplevel', 3, 0);
model.result('pg2').label('Electrolyte Potential (we)');
model.result('pg2').create('surf1', 'Surface');
model.result('pg2').feature('surf1').set('expr', {'we.phil'});
model.result('pg2').create('arws1', 'ArrowSurface');
model.result('pg2').feature('arws1').set('expr', {'we.Ilx' 'we.Ily'});
model.result('pg2').feature('arws1').set('arrowbase', 'center');
model.result('pg2').feature('arws1').set('color', 'gray');
model.result('pg2').feature('arws1').create('filt1', 'Filter');
model.result('pg2').feature('arws1').feature('filt1').set('expr', 'isdefined(we.phil)');
model.result('pg2').feature('arws1').feature('filt1').set('nodespec', 'all');
model.result.create('pg3', 'PlotGroup2D');
model.result('pg3').set('data', 'dset1');
model.result('pg3').setIndex('looplevel', 3, 0);
model.result('pg3').label('Mole Fraction, H2 (we)');
model.result('pg3').set('titletype', 'custom');
model.result('pg3').set('prefixintitle', 'Species H2:');
model.result('pg3').set('expressionintitle', false);
model.result('pg3').set('typeintitle', true);
model.result('pg3').create('surf1', 'Surface');
model.result('pg3').feature('surf1').set('expr', {'we.xH2'});
model.result('pg3').create('str1', 'Streamline');
model.result('pg3').feature('str1').set('expr', {'we.tfluxH2x' 'we.tfluxH2y'});
model.result('pg3').feature('str1').set('posmethod', 'uniform');
model.result('pg3').feature('str1').set('recover', 'pprint');
model.result('pg3').feature('str1').set('pointtype', 'arrow');
model.result('pg3').feature('str1').set('arrowlength', 'logarithmic');
model.result('pg3').feature('str1').set('color', 'gray');
model.result.create('pg4', 'PlotGroup2D');
model.result('pg4').set('data', 'dset1');
model.result('pg4').setIndex('looplevel', 3, 0);
model.result('pg4').label('Mole Fraction, O2 (we)');
model.result('pg4').set('titletype', 'custom');
model.result('pg4').set('prefixintitle', 'Species O2:');
model.result('pg4').set('expressionintitle', false);
model.result('pg4').set('typeintitle', true);
model.result('pg4').create('surf1', 'Surface');
model.result('pg4').feature('surf1').set('expr', {'we.xO2'});
model.result('pg4').create('str1', 'Streamline');
model.result('pg4').feature('str1').set('expr', {'we.tfluxO2x' 'we.tfluxO2y'});
model.result('pg4').feature('str1').set('posmethod', 'uniform');
model.result('pg4').feature('str1').set('recover', 'pprint');
model.result('pg4').feature('str1').set('pointtype', 'arrow');
model.result('pg4').feature('str1').set('arrowlength', 'logarithmic');
model.result('pg4').feature('str1').set('color', 'gray');
model.result.create('pg5', 'PlotGroup2D');
model.result('pg5').set('data', 'dset1');
model.result('pg5').setIndex('looplevel', 3, 0);
model.result('pg5').label('Mole Fraction, H2O (we)');
model.result('pg5').set('titletype', 'custom');
model.result('pg5').set('prefixintitle', 'Species H2O:');
model.result('pg5').set('expressionintitle', false);
model.result('pg5').set('typeintitle', true);
model.result('pg5').create('surf1', 'Surface');
model.result('pg5').feature('surf1').set('expr', {'we.xH2O'});
model.result('pg5').create('str1', 'Streamline');
model.result('pg5').feature('str1').set('expr', {'we.tfluxH2Ox' 'we.tfluxH2Oy'});
model.result('pg5').feature('str1').set('posmethod', 'uniform');
model.result('pg5').feature('str1').set('recover', 'pprint');
model.result('pg5').feature('str1').set('pointtype', 'arrow');
model.result('pg5').feature('str1').set('arrowlength', 'logarithmic');
model.result('pg5').feature('str1').set('color', 'gray');
model.result.create('pg6', 'PlotGroup2D');
model.result('pg6').set('data', 'dset1');
model.result('pg6').setIndex('looplevel', 3, 0);
model.result('pg6').label('Mole Fraction, N2 (we)');
model.result('pg6').set('titletype', 'custom');
model.result('pg6').set('prefixintitle', 'Species N2:');
model.result('pg6').set('expressionintitle', false);
model.result('pg6').set('typeintitle', true);
model.result('pg6').create('surf1', 'Surface');
model.result('pg6').feature('surf1').set('expr', {'we.xN2'});
model.result('pg6').create('str1', 'Streamline');
model.result('pg6').feature('str1').set('expr', {'we.tfluxN2x' 'we.tfluxN2y'});
model.result('pg6').feature('str1').set('posmethod', 'uniform');
model.result('pg6').feature('str1').set('recover', 'pprint');
model.result('pg6').feature('str1').set('pointtype', 'arrow');
model.result('pg6').feature('str1').set('arrowlength', 'logarithmic');
model.result('pg6').feature('str1').set('color', 'gray');
model.result.create('pg7', 'PlotGroup2D');
model.result('pg7').set('data', 'dset1');
model.result('pg7').setIndex('looplevel', 3, 0);
model.result('pg7').label('Mole Fraction, CO2 (we)');
model.result('pg7').set('titletype', 'custom');
model.result('pg7').set('prefixintitle', 'Species CO2:');
model.result('pg7').set('expressionintitle', false);
model.result('pg7').set('typeintitle', true);
model.result('pg7').create('surf1', 'Surface');
model.result('pg7').feature('surf1').set('expr', {'we.xCO2'});
model.result('pg7').create('str1', 'Streamline');
model.result('pg7').feature('str1').set('expr', {'we.tfluxCO2x' 'we.tfluxCO2y'});
model.result('pg7').feature('str1').set('posmethod', 'uniform');
model.result('pg7').feature('str1').set('recover', 'pprint');
model.result('pg7').feature('str1').set('pointtype', 'arrow');
model.result('pg7').feature('str1').set('arrowlength', 'logarithmic');
model.result('pg7').feature('str1').set('color', 'gray');
model.result.create('pg8', 'PlotGroup2D');
model.result('pg8').set('data', 'dset1');
model.result('pg8').setIndex('looplevel', 3, 0);
model.result('pg8').label('Mole Fraction, CO (we)');
model.result('pg8').set('titletype', 'custom');
model.result('pg8').set('prefixintitle', 'Species CO:');
model.result('pg8').set('expressionintitle', false);
model.result('pg8').set('typeintitle', true);
model.result('pg8').create('surf1', 'Surface');
model.result('pg8').feature('surf1').set('expr', {'we.xCO'});
model.result('pg8').create('str1', 'Streamline');
model.result('pg8').feature('str1').set('expr', {'we.tfluxCOx' 'we.tfluxCOy'});
model.result('pg8').feature('str1').set('posmethod', 'uniform');
model.result('pg8').feature('str1').set('recover', 'pprint');
model.result('pg8').feature('str1').set('pointtype', 'arrow');
model.result('pg8').feature('str1').set('arrowlength', 'logarithmic');
model.result('pg8').feature('str1').set('color', 'gray');
model.result.create('pg9', 'PlotGroup2D');
model.result('pg9').set('data', 'dset1');
model.result('pg9').setIndex('looplevel', 3, 0);
model.result('pg9').label('Pressure (we)');
model.result('pg9').create('surf1', 'Surface');
model.result('pg9').feature('surf1').set('expr', {'we.p'});
model.result('pg9').create('str1', 'Streamline');
model.result('pg9').feature('str1').set('expr', {'we.u' 'we.v'});
model.result('pg9').feature('str1').set('posmethod', 'uniform');
model.result('pg9').feature('str1').set('recover', 'pprint');
model.result('pg9').feature('str1').set('pointtype', 'arrow');
model.result('pg9').feature('str1').set('arrowlength', 'logarithmic');
model.result('pg9').feature('str1').set('color', 'gray');
model.result.create('pg10', 'PlotGroup2D');
model.result('pg10').label('Temperature (ht)');
model.result('pg10').set('defaultPlotID', 'ht/HT_PhysicsInterfaces/icom8/pdef1/pcond2/pcond4/pg2');
model.result('pg10').feature.create('surf1', 'Surface');
model.result('pg10').feature('surf1').set('showsolutionparams', 'on');
model.result('pg10').feature('surf1').set('solutionparams', 'parent');
model.result('pg10').feature('surf1').set('expr', 'T');
model.result('pg10').feature('surf1').set('colortable', 'HeatCameraLight');
model.result('pg10').feature('surf1').set('showsolutionparams', 'on');
model.result('pg10').feature('surf1').set('data', 'parent');
model.result('pg1').run;
model.result('pg3').run;
model.result('pg3').run;
model.result('pg8').run;
model.result('pg8').run;
model.result('pg10').run;
model.result('pg10').run;
model.result('pg10').feature('surf1').set('expr', 'T-T_in');
model.result('pg10').run;
model.result('pg10').set('titletype', 'manual');
model.result('pg10').set('title', 'Surface: Change in Temperature (K)');
model.result('pg10').run;
model.result.create('pg11', 'PlotGroup2D');
model.result('pg11').run;
model.result('pg11').label('Water Gas Shift Reaction Rate');
model.result('pg11').create('surf1', 'Surface');
model.result('pg11').feature('surf1').set('expr', 'we.r_wgsr');
model.result('pg11').run;
model.result.create('pg12', 'PlotGroup1D');
model.result('pg12').run;
model.result('pg12').label('Current Density Distribution');
model.result('pg12').setIndex('looplevelinput', 'last', 0);
model.result('pg12').set('titletype', 'manual');
model.result('pg12').set('title', 'Current Density Distribution, Cathode Side');
model.result('pg12').set('xlabelactive', true);
model.result('pg12').set('xlabel', 'Electrode length (m)');
model.result('pg12').set('ylabelactive', true);
model.result('pg12').set('ylabel', 'Integrated current density in y-direction (A/cm<sup>2</sup>)');
model.result('pg12').create('lngr1', 'LineGraph');
model.result('pg12').feature('lngr1').set('markerpos', 'datapoints');
model.result('pg12').feature('lngr1').set('linewidth', 'preference');
model.result('pg12').feature('lngr1').selection.set([10]);
model.result('pg12').feature('lngr1').set('expr', 'genproj1(we.iv_h2gder1)');
model.result('pg12').feature('lngr1').set('unit', 'A/cm^2');
model.result('pg12').feature('lngr1').set('linewidth', 2);
model.result('pg12').feature('lngr1').set('legend', true);
model.result('pg12').feature('lngr1').set('legendmethod', 'manual');
model.result('pg12').feature('lngr1').setIndex('legends', 'H2O', 0);
model.result('pg12').run;
model.result('pg12').create('lngr2', 'LineGraph');
model.result('pg12').feature('lngr2').set('markerpos', 'datapoints');
model.result('pg12').feature('lngr2').set('linewidth', 'preference');
model.result('pg12').feature('lngr2').selection.set([10]);
model.result('pg12').feature('lngr2').set('expr', 'genproj1(we.iv_h2gder2)');
model.result('pg12').feature('lngr2').set('unit', 'A/cm^2');
model.result('pg12').feature('lngr2').set('linewidth', 2);
model.result('pg12').feature('lngr2').set('legend', true);
model.result('pg12').feature('lngr2').set('legendmethod', 'manual');
model.result('pg12').feature('lngr2').setIndex('legends', 'CO2', 0);
model.result('pg12').run;
model.result('pg12').run;

model.title('Water and Carbon Dioxide Co-Electrolysis in a Solid Oxide Electrolyzer Cell');

model.description(['This example models co-electrolysis of water and carbon dioxide using a solid oxide electrolyzer cell. The model includes the full coupling between the mass balances and gas flow in the hydrogen and oxygen gas diffusion electrodes, the momentum balances in the hydrogen and oxygen gas flow channels, the energy balance across the cell, the balance of the ionic current carried by the oxide ion, and an electronic-current balance. A reversible water gas shift reaction is included in the hydrogen gas diffusion electrode and hydrogen gas flow channel.' newline  newline 'The model computes the spatial distributions of the various species across the gas diffusion electrodes and gas flow channels. The spatial distribution of the total current density along the electrode length is also evaluated in the model using the general projection operator.']);

model.mesh.clearMeshes;

model.sol('sol1').clearSolutionData;
model.sol('sol2').clearSolutionData;

model.label('soec_co2.mph');

model.modelNode.label('Components');

out = model;
```

---

## Example 18: transmission_line_calculator

**Module:** Unknown_Module  
**Category:** COMSOL_Multiphysics_Applications_transmission_line_calculator  

### Model Description

**Model Overview**:
The model simulates the electromagnetic wave propagation along four types of transmission lines: coaxial line, twin lead, microstrip line, and coplanar waveguide (CPW). It calculates the distributed resistance (R), inductance (L), conductance (G), and capacitance (C) per unit length, as well as the characteristic impedance (Zc) and the propagation constant (gamma) for each type of transmission line.

**Geometry**:
The model includes four separate geometric setups, one for each transmission line type:
1. Coaxial line: Consists of an inner conductor and an outer conductor (shield) separated by a dielectric material.
2. Twin lead: Comprises two parallel conductors separated by a dielectric material.
3. Microstrip line: A conductor strip separated from a ground plane by a dielectric substrate.
4. Coplanar waveguide (CPW): A central conductor strip separated from two ground planes by a dielectric substrate.

**Materials**:
The model uses various materials for the conductors and dielectrics. The key properties include:
- Relative permittivity (εr) and conductivity (σ) of the dielectric materials.
- Conductivity (σ) of the conductor materials.

**Physics**:
The model employs the following physics interfaces:
1. Conductive Media (ec) for modeling the dielectric materials.
2. Induction Currents (mf) for modeling the conductor materials and computing the magnetic fields.
3. Electric Potential (pot) for applying voltage boundary conditions.
4. Ground (gnd) for setting ground reference.
5. Perfect Magnetic Conductor (pmc) for simulating magnetic wall boundary conditions.

**Boundary Conditions**:
The model applies the following boundary conditions:
1. Electric potential (V) is set to 1 V and -1 V on the conductors of each transmission line.
2. Ground (0 V) is applied to the outer conductor of the coaxial line and the ground planes of the microstrip line and CPW.
3. Perfect magnetic conductor (PMC) conditions are applied to the symmetry planes of the twin lead and microstrip line.

**Mesh**:
The geometry is discretized using a boundary layer mesh to accurately capture the skin effect in the conductors. The mesh size is refined based on the skin depth (delta) at the specified frequency for each transmission line type.

**Study**:
The model performs a frequency-domain study at a specified frequency for each transmission line type. The study computes the stationary solution for the electric and magnetic fields.

**Key Parameters**:
The key parameters include:
1. Frequency (frq) for each transmission line type.
2. Geometric dimensions (e.g., inner and outer radii for coaxial line, strip width and height for microstrip line).
3. Material properties (relative permittivity and conductivity of dielectrics, conductivity of conductors).

**Expected Results**:
The model calculates the following outputs for each transmission line type:
1. Distributed resistance (R) per unit length.
2. Distributed inductance (L) per unit length.
3. Distributed conductance (G) per unit length.
4. Distributed capacitance (C) per unit length.
5. Characteristic impedance (Zc).
6. Propagation constant (gamma).

**Engineering Application**:
This model is useful for designing and analyzing transmission lines in various RF and microwave applications, such as:
1. Designing coaxial cables for signal transmission in communication systems.
2. Optimizing the dimensions and material properties of twin leads, microstrip lines, and CPWs for minimal signal loss and distortion in PCB designs.
3. Investigating the effects of frequency and material properties on the transmission line parameters and performance.

The model provides valuable insights into the electromagnetic behavior of transmission lines and aids engineers in making informed design decisions for their specific applications.

### COMSOL MATLAB Code

```matlab
function out = model
%
% transmission_line_calculator.m
%
% Model exported on May 26 2025, 21:26 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/COMSOL_Multiphysics/Applications');

model.fontSize(6);

model.param.set('frq_coax', '1[GHz]');
model.param.descr('frq_coax', 'Frequency');
model.param.set('Ri_coax', '0.405[mm]');
model.param.descr('Ri_coax', 'Inner radius');
model.param.set('dR_coax', '1.045[mm]');
model.param.descr('dR_coax', 'Dielectric thickness');
model.param.set('d_s_coax', '0.1[mm]');
model.param.descr('d_s_coax', 'Screen thickness');
model.param.set('epsr_coax', '2.25');
model.param.descr('epsr_coax', 'Relative permittivity of dielectric');
model.param.set('mur_coax', '1');
model.param.descr('mur_coax', 'Relative permeability of dielectric');
model.param.set('sigma_d_coax', '1e-14[S/m]');
model.param.descr('sigma_d_coax', 'Conductivity of dielectric');
model.param.set('sigma_c_coax', '5.98e7[S/m]');
model.param.descr('sigma_c_coax', 'Conductivity of conductors');
model.param.set('Ro_coax', 'Ri_coax+dR_coax');
model.param.descr('Ro_coax', 'Outer radius');
model.param.set('w_coax', '2*pi*frq_coax');
model.param.descr('w_coax', 'Angular frequency');
model.param.set('delta_coax', 'sqrt(2/(w_coax*mur_coax*mu0_const*sigma_c_coax))');
model.param.descr('delta_coax', 'Skin depth');
model.param.set('d_c_coax', 'dR_coax');
model.param.descr('d_c_coax', 'Conductor distance');
model.param.set('lambda_coax', 'c_const/frq_coax/sqrt(mur_coax*epsr_coax)');
model.param.descr('lambda_coax', 'Wavelength in dielectric');
model.param.set('QS_coax', 'd_c_coax<(0.1*lambda_coax)');
model.param.descr('QS_coax', 'Validity of quasistatic analysis');
model.param.set('frq_twin', '300[MHz]');
model.param.descr('frq_twin', 'Frequency');
model.param.set('R1_twin', '1[mm]');
model.param.descr('R1_twin', 'Wire radius');
model.param.set('d_twin', '12[mm]');
model.param.descr('d_twin', 'Ribbon width');
model.param.set('t_ins_twin', '1[mm]');
model.param.descr('t_ins_twin', 'Wire insulation thickness');
model.param.set('t_ribbon_twin', 't_ins_twin');
model.param.descr('t_ribbon_twin', 'Ribbon thickness');
model.param.set('epsr_twin', '2.25');
model.param.descr('epsr_twin', 'Relative permittivity of dielectric');
model.param.set('sigma_d_twin', '1e-14[S/m]');
model.param.descr('sigma_d_twin', 'Conductivity of dielectric');
model.param.set('sigma_c_twin', '5.98e7[S/m]');
model.param.descr('sigma_c_twin', 'Conductivity of conductors');
model.param.set('w_twin', '2*pi*frq_twin');
model.param.descr('w_twin', 'Angular frequency');
model.param.set('delta_twin', 'sqrt(2/(w_twin*1*mu0_const*sigma_c_twin))');
model.param.descr('delta_twin', 'Skin depth');
model.param.set('d_c_twin', '2*t_ins_twin+d_twin');
model.param.descr('d_c_twin', 'Conductor distance');
model.param.set('lambda_twin', 'c_const/frq_twin');
model.param.descr('lambda_twin', 'Wavelength');
model.param.set('QS_twin', 'd_c_twin<(0.1*lambda_twin)');
model.param.descr('QS_twin', 'Validity of quasistatic analysis');
model.param.set('frq_ms', '10[GHz]');
model.param.descr('frq_ms', 'Frequency');
model.param.set('W_ms', '0.17[mm]');
model.param.descr('W_ms', 'Strip width');
model.param.set('t_ms', '0.01[mm]');
model.param.descr('t_ms', 'Strip thickness');
model.param.set('h_ms', '0.06[mm]');
model.param.descr('h_ms', 'Dielectric height');
model.param.set('t_gp_ms', '0.01[mm]');
model.param.descr('t_gp_ms', 'Ground plane thickness');
model.param.set('epsr_ms', '2.25');
model.param.descr('epsr_ms', 'Relative permittivity of dielectric');
model.param.set('sigma_d_ms', '1e-14[S/m]');
model.param.descr('sigma_d_ms', 'Conductivity of dielectric');
model.param.set('sigma_c_ms', '5.98e7[S/m]');
model.param.descr('sigma_c_ms', 'Conductivity of conductors');
model.param.set('w_ms', '2*pi*frq_ms');
model.param.descr('w_ms', 'Angular frequency');
model.param.set('delta_ms', 'sqrt(2/(w_ms*1*mu0_const*sigma_c_ms))');
model.param.descr('delta_ms', 'Skin depth');
model.param.set('ms_width', 'max(5*(t_ms+h_ms+t_gp_ms),10*W_ms)');
model.param.descr('ms_width', 'Domain width');
model.param.set('ms_height', 'max(10*(t_ms+h_ms+t_gp_ms),5*W_ms)');
model.param.descr('ms_height', 'Domain height');
model.param.set('d_c_ms', 'h_ms');
model.param.descr('d_c_ms', 'Conductor distance');
model.param.set('lambda_ms', 'c_const/frq_ms/sqrt(epsr_ms)');
model.param.descr('lambda_ms', 'Wavelength in dielectric');
model.param.set('QS_ms', 'd_c_ms<(0.1*lambda_ms)');
model.param.descr('QS_ms', 'Validity of quasistatic analysis');
model.param.set('bad_aspect_ratio_ms', 'max(h_ms/W_ms,h_ms/t_gp_ms/5)>50');
model.param.descr('bad_aspect_ratio_ms', 'Aspect ratio evaluation');
model.param.set('frq_cpw', '10[GHz]');
model.param.descr('frq_cpw', 'Frequency');
model.param.set('W_cpw', '0.17[mm]');
model.param.descr('W_cpw', 'Central track width');
model.param.set('g_cpw', '0.1[mm]');
model.param.descr('g_cpw', 'Gap to ground width');
model.param.set('t_cpw', '0.01[mm]');
model.param.descr('t_cpw', 'Track thickness');
model.param.set('h_cpw', '0.06[mm]');
model.param.descr('h_cpw', 'Dielectric height');
model.param.set('t_bp_cpw', '0.01[mm]');
model.param.descr('t_bp_cpw', 'Thickness of metallic back plane');
model.param.set('epsr_cpw', '2.25');
model.param.descr('epsr_cpw', 'Relative permittivity of dielectric');
model.param.set('sigma_d_cpw', '1e-14[S/m]');
model.param.descr('sigma_d_cpw', 'Conductivity of dielectric');
model.param.set('sigma_c_cpw', '5.98e7[S/m]');
model.param.descr('sigma_c_cpw', 'Conductivity of conductors');
model.param.set('w_cpw', '2*pi*frq_cpw');
model.param.descr('w_cpw', 'Angular frequency');
model.param.set('delta_cpw', 'sqrt(2/(w_cpw*1*mu0_const*sigma_c_cpw))');
model.param.descr('delta_cpw', 'Skin depth');
model.param.set('cpw_width', 'max(5*h_cpw,5*(W_cpw+2*g_cpw))');
model.param.descr('cpw_width', 'Domain width');
model.param.set('cpw_height', 'cpw_width/2');
model.param.descr('cpw_height', 'Domain height');
model.param.set('sigma_bp_cpw', 'if(bp_cpw,sigma_c_cpw,0)');
model.param.descr('sigma_bp_cpw', 'Domain conductivity');
model.param.set('epsilonr_bp_cpw', '1');
model.param.descr('epsilonr_bp_cpw', 'Domain relative permittivity');
model.param.set('h_bp_cpw', 'if(bp_cpw,t_bp_cpw,cpw_height)');
model.param.descr('h_bp_cpw', 'Domain height');
model.param.set('bp_cpw', '1');
model.param.descr('bp_cpw', 'Conductive back plane switch (1/0)');
model.param.set('d_c_cpw', 'max(g_cpw,h_cpw)');
model.param.descr('d_c_cpw', 'Conductor distance');
model.param.set('lambda_cpw', 'c_const/frq_cpw/sqrt(epsr_cpw)');
model.param.descr('lambda_cpw', 'Wavelength in dielectric');
model.param.set('QS_cpw', 'd_c_cpw<(0.1*lambda_cpw)');
model.param.descr('QS_cpw', 'Validity of quasistatic analysis');
model.param.set('bad_aspect_ratio_cpw', '(max(max(max(h_cpw/h_bp_cpw/5,h_cpw/t_cpw/5),h_cpw/g_cpw),h_cpw/W_cpw)>50)||((g_cpw/W_cpw)>2)');
model.param.descr('bad_aspect_ratio_cpw', 'Aspect ratio evaluation');
model.param.set('FR_coax', 'delta_coax<d_s_coax');
model.param.descr('FR_coax', 'Validity of reasonable frequency range');
model.param.set('FR_twin', 'delta_twin<R1_twin');
model.param.descr('FR_twin', 'Validity of reasonable frequency range');
model.param.set('FR_ms', 'delta_ms<min(t_gp_ms,t_ms)');
model.param.descr('FR_ms', 'Validity of reasonable frequency range');
model.param.set('FR_cpw', 'delta_ms<min(h_bp_cpw,t_cpw)');
model.param.descr('FR_cpw', 'Validity of reasonable frequency range');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 2);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.modelNode('comp1').label('Coaxial Line');
model.modelNode('comp1').sorder('linear');

model.geom('geom1').lengthUnit('mm');

model.variable.create('var1');
model.variable('var1').model('comp1');

model.geom('geom1').run;

model.variable('var1').set('R_coax', 'real(1[V/m]/intop2(mf.Jz))');
model.variable('var1').descr('R_coax', 'Distributed resistance');
model.variable('var1').set('L_coax', 'imag(1[V/m]/intop2(mf.Jz))/w_coax');
model.variable('var1').descr('L_coax', 'Distributed inductance');
model.variable('var1').set('C_coax', 'imag(intop1(reacf(V)*1[A/m])/1[V])/w_coax');
model.variable('var1').descr('C_coax', 'Capacitance');
model.variable('var1').set('G_coax', 'real(intop1(reacf(V)*1[A/m])/1[V])');
model.variable('var1').descr('G_coax', 'Shunt conductance');
model.variable('var1').set('Zc_coax', 'sqrt((R_coax+j*w_coax*L_coax)/(G_coax+j*w_coax*C_coax))');
model.variable('var1').descr('Zc_coax', 'Characteristic impedance');
model.variable('var1').set('gamma_coax', 'sqrt((R_coax+j*w_coax*L_coax)*(G_coax+j*w_coax*C_coax))');
model.variable('var1').descr('gamma_coax', 'Propagation constant');

model.geom('geom1').create('c1', 'Circle');
model.geom('geom1').feature('c1').set('r', 'Ro_coax+d_s_coax');
model.geom('geom1').feature('c1').set('selresult', true);
model.geom('geom1').feature('c1').set('color', 'custom');
model.geom('geom1').feature('c1').set('customcolor', [0.21960784494876862 0.501960813999176 0.5647059082984924]);
model.geom('geom1').run('c1');
model.geom('geom1').create('c2', 'Circle');
model.geom('geom1').feature('c2').set('r', 'Ro_coax');
model.geom('geom1').run('c2');
model.geom('geom1').create('dif1', 'Difference');
model.geom('geom1').feature('dif1').selection('input').set({'c1'});
model.geom('geom1').feature('dif1').selection('input2').set({'c2'});
model.geom('geom1').run('dif1');
model.geom('geom1').create('c3', 'Circle');
model.geom('geom1').feature('c3').set('r', 'Ro_coax');
model.geom('geom1').run('c3');
model.geom('geom1').create('c4', 'Circle');
model.geom('geom1').feature('c4').set('r', 'Ri_coax');
model.geom('geom1').feature('c4').set('selresult', true);
model.geom('geom1').feature('c4').set('color', 'custom');
model.geom('geom1').feature('c4').set('customcolor', [0.21960784494876862 0.501960813999176 0.5647059082984924]);
model.geom('geom1').run('fin');

model.cpl.create('intop1', 'Integration', 'geom1');
model.cpl('intop1').set('axisym', true);
model.cpl('intop1').selection.geom('geom1', 1);
model.cpl('intop1').selection.set([5 6 9 10]);
model.cpl('intop1').set('method', 'summation');
model.cpl.create('intop2', 'Integration', 'geom1');
model.cpl('intop2').set('axisym', true);
model.cpl('intop2').selection.set([3]);

model.physics.create('ec', 'ConductiveMedia', 'geom1');
model.physics('ec').model('comp1');
model.physics('ec').selection.set([2]);
model.physics('ec').feature('cucn1').set('sigma_mat', 'userdef');
model.physics('ec').feature('cucn1').set('sigma', {'sigma_d_coax+j*w_coax*epsr_coax*epsilon0_const' '0' '0' '0' 'sigma_d_coax+j*w_coax*epsr_coax*epsilon0_const' '0' '0' '0' 'sigma_d_coax+j*w_coax*epsr_coax*epsilon0_const'});
model.physics('ec').feature('cucn1').set('epsilonr_mat', 'userdef');
model.physics('ec').feature('cucn1').set('epsilonr', [0 0 0 0 0 0 0 0 0]);
model.physics('ec').create('gnd1', 'Ground', 1);
model.physics('ec').feature('gnd1').selection.set([3 4 8 11]);
model.physics('ec').create('pot1', 'ElectricPotential', 1);
model.physics('ec').feature('pot1').selection.set([5 6 9 10]);
model.physics('ec').feature('pot1').set('V0', 1);
model.physics.create('mf', 'InductionCurrents', 'geom1');
model.physics('mf').model('comp1');
model.physics('mf').prop('EquationForm').setIndex('form', 'Frequency', 0);
model.physics('mf').prop('EquationForm').setIndex('freq_src', 'userdef', 0);
model.physics('mf').prop('EquationForm').setIndex('freq', 'frq_coax', 0);
model.physics('mf').create('als1', 'AmperesLawSolid', 2);
model.physics('mf').feature('als1').selection.all;
model.physics('mf').feature('als1').set('sigma_mat', 'userdef');
model.physics('mf').feature('als1').set('mur_mat', 'userdef');
model.physics('mf').feature('als1').set('mur', {'mur_coax' '0' '0' '0' 'mur_coax' '0' '0' '0' 'mur_coax'});
model.physics('mf').feature('als1').set('epsilonr_mat', 'userdef');
model.physics('mf').feature('als1').set('epsilonr', [0 0 0 0 0 0 0 0 0]);
model.physics('mf').create('als2', 'AmperesLawSolid', 2);
model.physics('mf').feature('als2').selection.set([1 3]);
model.physics('mf').feature('als2').set('sigma_mat', 'userdef');
model.physics('mf').feature('als2').set('sigma', {'sigma_c_coax' '0' '0' '0' 'sigma_c_coax' '0' '0' '0' 'sigma_c_coax'});
model.physics('mf').feature('als2').set('mur_mat', 'userdef');
model.physics('mf').feature('als2').set('epsilonr_mat', 'userdef');
model.physics('mf').feature('als2').set('epsilonr', [0 0 0 0 0 0 0 0 0]);
model.physics('mf').create('ecd1', 'ExternalCurrentDensity', 2);
model.physics('mf').feature('ecd1').selection.set([3]);
model.physics('mf').feature('ecd1').set('Je', {'0' '0' 'sigma_c_coax*1[V/m]'});

model.mesh('mesh1').automatic(false);
model.mesh('mesh1').feature('size').set('hauto', 3);
model.mesh('mesh1').create('bl1', 'BndLayer');
model.mesh('mesh1').feature('bl1').create('blp', 'BndLayerProp');
model.mesh('mesh1').feature('bl1').selection.geom(2);
model.mesh('mesh1').feature('bl1').selection.set([]);
model.mesh('mesh1').feature('bl1').selection.allGeom;
model.mesh('mesh1').feature('bl1').selection.geom('geom1', 2);
model.mesh('mesh1').feature.move('bl1', 1);
model.mesh('mesh1').feature('bl1').selection.set([1 3]);
model.mesh('mesh1').feature('bl1').feature('blp').selection.set([3 4 5 6 8 9 10 11]);
model.mesh('mesh1').feature('bl1').feature('blp').set('inittype', 'blhmin');
model.mesh('mesh1').feature('bl1').feature('blp').set('blhmin', 'delta_coax/2');

model.modelNode.create('comp2', true);

model.geom.create('geom2', 2);
model.geom('geom2').model('comp2');

model.mesh.create('mesh2', 'geom2');

model.geom('geom2').lengthUnit('mm');

model.modelNode('comp2').label('Twin Lead');
model.modelNode('comp2').sorder('linear');

model.variable.create('var2');
model.variable('var2').model('comp2');

model.geom('geom2').run;

model.variable('var2').set('R_twin', 'real(1[V/m]/intop4(mf2.Jz))');
model.variable('var2').descr('R_twin', 'Distributed resistance');
model.variable('var2').set('L_twin', 'imag(1[V/m]/intop4(mf2.Jz))/w_twin');
model.variable('var2').descr('L_twin', 'Distributed inductance');
model.variable('var2').set('C_twin', 'imag(intop3(reacf(V2)*1[A/m])/1[V])/w_twin');
model.variable('var2').descr('C_twin', 'Capacitance');
model.variable('var2').set('G_twin', 'real(intop3(reacf(V2)*1[A/m])/1[V])');
model.variable('var2').descr('G_twin', 'Shunt conductance');
model.variable('var2').set('Zc_twin', 'sqrt((R_twin+j*w_twin*L_twin)/(G_twin+j*w_twin*C_twin))');
model.variable('var2').descr('Zc_twin', 'Characteristic impedance');
model.variable('var2').set('gamma_twin', 'sqrt((R_twin+j*w_twin*L_twin)*(G_twin+j*w_twin*C_twin))');
model.variable('var2').descr('gamma_twin', 'Propagation constant');

model.geom('geom2').create('r1', 'Rectangle');
model.geom('geom2').feature('r1').set('size', {'max(10*(d_twin+4*(t_ins_twin+R1_twin)), 3*(d_twin+4*(t_ins_twin+R1_twin)))' '1'});
model.geom('geom2').feature('r1').setIndex('size', 'max(6*(d_twin+4*(t_ins_twin+R1_twin)), 5*(d_twin+4*(t_ins_twin+R1_twin)))', 1);
model.geom('geom2').feature('r1').set('base', 'center');
model.geom('geom2').run('r1');
model.geom('geom2').create('c1', 'Circle');
model.geom('geom2').feature('c1').set('r', 'R1_twin+t_ins_twin');
model.geom('geom2').feature('c1').set('pos', {'-(d_twin/2+t_ins_twin+R1_twin)' '0'});
model.geom('geom2').run('c1');
model.geom('geom2').create('c2', 'Circle');
model.geom('geom2').feature('c2').set('r', 'R1_twin+t_ins_twin');
model.geom('geom2').feature('c2').set('pos', {'(d_twin/2+t_ins_twin+R1_twin)' '0'});
model.geom('geom2').run('c2');
model.geom('geom2').create('r2', 'Rectangle');
model.geom('geom2').feature('r2').set('size', {'d_twin+1.9*t_ins_twin' '1'});
model.geom('geom2').feature('r2').setIndex('size', 't_ribbon_twin', 1);
model.geom('geom2').feature('r2').set('base', 'center');
model.geom('geom2').run('r2');
model.geom('geom2').create('uni1', 'Union');
model.geom('geom2').feature('uni1').selection('input').set({'c1' 'c2' 'r2'});
model.geom('geom2').feature('uni1').set('intbnd', false);
model.geom('geom2').run('uni1');
model.geom('geom2').create('c3', 'Circle');
model.geom('geom2').feature('c3').set('r', 'R1_twin');
model.geom('geom2').feature('c3').set('pos', {'-(d_twin/2+t_ins_twin+R1_twin)' '0'});
model.geom('geom2').feature('c3').set('selresult', true);
model.geom('geom2').feature('c3').set('color', 'custom');
model.geom('geom2').feature('c3').set('customcolor', [0.21960784494876862 0.501960813999176 0.5647059082984924]);
model.geom('geom2').run('c3');
model.geom('geom2').create('c4', 'Circle');
model.geom('geom2').feature('c4').set('r', 'R1_twin');
model.geom('geom2').feature('c4').set('pos', {'(d_twin/2+t_ins_twin+R1_twin)' '0'});
model.geom('geom2').feature('c4').set('selresult', true);
model.geom('geom2').feature('c4').set('color', 'custom');
model.geom('geom2').feature('c4').set('customcolor', [0.21960784494876862 0.501960813999176 0.5647059082984924]);
model.geom('geom2').run('fin');
model.geom('geom2').create('sel1', 'ExplicitSelection');
model.geom('geom2').feature('sel1').selection('selection').set('fin', 1);

model.view('view2').hideObjects.create('hide1');
model.view('view2').hideObjects('hide1').init(2);
model.view('view2').hideObjects('hide1').named('sel1');

model.cpl.create('intop3', 'Integration', 'geom2');

model.geom('geom2').run;

model.cpl('intop3').set('axisym', true);
model.cpl('intop3').selection.geom('geom2', 1);
model.cpl('intop3').selection.set([17 18 20 21]);
model.cpl('intop3').set('method', 'summation');
model.cpl.create('intop4', 'Integration', 'geom2');
model.cpl('intop4').set('axisym', true);
model.cpl('intop4').selection.set([4]);

model.physics.create('ec2', 'ConductiveMedia', 'geom2');
model.physics('ec2').model('comp2');
model.physics('ec2').selection.set([1 2]);
model.physics('ec2').feature('cucn1').set('sigma_mat', 'userdef');
model.physics('ec2').feature('cucn1').set('sigma', {'j*w_twin*epsilon0_const' '0' '0' '0' 'j*w_twin*epsilon0_const' '0' '0' '0' 'j*w_twin*epsilon0_const'});
model.physics('ec2').feature('cucn1').set('epsilonr_mat', 'userdef');
model.physics('ec2').feature('cucn1').set('epsilonr', [0 0 0 0 0 0 0 0 0]);
model.physics('ec2').create('cucn2', 'CurrentConservation', 2);
model.physics('ec2').feature('cucn2').selection.set([2]);
model.physics('ec2').feature('cucn2').set('sigma_mat', 'userdef');
model.physics('ec2').feature('cucn2').set('sigma', {'sigma_d_twin+j*w_twin*epsr_twin*epsilon0_const' '0' '0' '0' 'sigma_d_twin+j*w_twin*epsr_twin*epsilon0_const' '0' '0' '0' 'sigma_d_twin+j*w_twin*epsr_twin*epsilon0_const'});
model.physics('ec2').feature('cucn2').set('epsilonr_mat', 'userdef');
model.physics('ec2').feature('cucn2').set('epsilonr', [0 0 0 0 0 0 0 0 0]);
model.physics('ec2').create('pot1', 'ElectricPotential', 1);
model.physics('ec2').feature('pot1').selection.set([9 10 12 13]);
model.physics('ec2').feature('pot1').set('V0', '-0.5[V]');
model.physics('ec2').create('pot2', 'ElectricPotential', 1);
model.physics('ec2').feature('pot2').selection.set([17 18 20 21]);
model.physics('ec2').feature('pot2').set('V0', '0.5[V]');
model.physics.create('mf2', 'InductionCurrents', 'geom2');
model.physics('mf2').model('comp2');
model.physics('mf2').prop('EquationForm').setIndex('form', 'Frequency', 0);
model.physics('mf2').prop('EquationForm').setIndex('freq_src', 'userdef', 0);
model.physics('mf2').prop('EquationForm').setIndex('freq', 'frq_twin', 0);
model.physics('mf2').create('als1', 'AmperesLawSolid', 2);
model.physics('mf2').feature('als1').selection.all;
model.physics('mf2').feature('als1').set('sigma_mat', 'userdef');
model.physics('mf2').feature('als1').set('mur_mat', 'userdef');
model.physics('mf2').feature('als1').set('epsilonr_mat', 'userdef');
model.physics('mf2').feature('als1').set('epsilonr', [0 0 0 0 0 0 0 0 0]);
model.physics('mf2').create('als2', 'AmperesLawSolid', 2);
model.physics('mf2').feature('als2').selection.set([2]);
model.physics('mf2').feature('als2').set('sigma_mat', 'userdef');
model.physics('mf2').feature('als2').set('sigma', {'sigma_d_twin' '0' '0' '0' 'sigma_d_twin' '0' '0' '0' 'sigma_d_twin'});
model.physics('mf2').feature('als2').set('mur_mat', 'userdef');
model.physics('mf2').feature('als2').set('epsilonr_mat', 'userdef');
model.physics('mf2').feature('als2').set('epsilonr', {'epsr_twin' '0' '0' '0' 'epsr_twin' '0' '0' '0' 'epsr_twin'});
model.physics('mf2').create('als3', 'AmperesLawSolid', 2);
model.physics('mf2').feature('als3').selection.set([3 4]);
model.physics('mf2').feature('als3').set('sigma_mat', 'userdef');
model.physics('mf2').feature('als3').set('sigma', {'sigma_c_twin' '0' '0' '0' 'sigma_c_twin' '0' '0' '0' 'sigma_c_twin'});
model.physics('mf2').feature('als3').set('mur_mat', 'userdef');
model.physics('mf2').feature('als3').set('epsilonr_mat', 'userdef');
model.physics('mf2').create('ecd1', 'ExternalCurrentDensity', 2);
model.physics('mf2').feature('ecd1').selection.set([3]);
model.physics('mf2').feature('ecd1').set('Je', {'0' '0' '-sigma_c_twin*0.5[V/m]'});
model.physics('mf2').create('ecd2', 'ExternalCurrentDensity', 2);
model.physics('mf2').feature('ecd2').selection.set([4]);
model.physics('mf2').feature('ecd2').set('Je', {'0' '0' 'sigma_c_twin*0.5[V/m]'});

model.mesh('mesh2').automatic(false);
model.mesh('mesh2').feature('size').set('hauto', 3);
model.mesh('mesh2').feature('size').set('custom', true);
model.mesh('mesh2').feature('size').set('hmax', '10*(d_twin+4*(t_ins_twin+R1_twin))/50');
model.mesh('mesh2').feature('size').set('hmin', 2.09E-5);
model.mesh('mesh2').create('bl1', 'BndLayer');
model.mesh('mesh2').feature('bl1').create('blp', 'BndLayerProp');
model.mesh('mesh2').feature('bl1').selection.geom(2);
model.mesh('mesh2').feature('bl1').selection.set([]);
model.mesh('mesh2').feature('bl1').selection.allGeom;
model.mesh('mesh2').feature('bl1').selection.geom('geom2', 2);
model.mesh('mesh2').feature('bl1').selection.set([3 4]);
model.mesh('mesh2').feature('bl1').feature('blp').selection.set([9 10 12 13 17 18 20 21]);
model.mesh('mesh2').feature('bl1').feature('blp').set('inittype', 'blhmin');
model.mesh('mesh2').feature('bl1').feature('blp').set('blhmin', 'delta_twin/2');
model.mesh('mesh2').feature.move('ftri1', 2);

model.modelNode.create('comp3', true);

model.geom.create('geom3', 2);
model.geom('geom3').model('comp3');

model.mesh.create('mesh3', 'geom3');

model.modelNode('comp3').label('Microstrip');
model.modelNode('comp3').sorder('linear');

model.geom('geom3').lengthUnit('mm');
model.geom('geom3').create('r1', 'Rectangle');
model.geom('geom3').feature('r1').set('size', {'ms_width' 'ms_height'});
model.geom('geom3').run('r1');
model.geom('geom3').create('r2', 'Rectangle');
model.geom('geom3').feature('r2').set('size', {'ms_width' 'h_ms'});
model.geom('geom3').run('r2');
model.geom('geom3').create('r3', 'Rectangle');
model.geom('geom3').feature('r3').set('size', {'W_ms' 't_ms'});
model.geom('geom3').feature('r3').set('pos', {'ms_width/2-W_ms/2' '0'});
model.geom('geom3').feature('r3').setIndex('pos', 'h_ms', 1);
model.geom('geom3').feature('r3').set('selresult', true);
model.geom('geom3').feature('r3').set('color', 'custom');
model.geom('geom3').feature('r3').set('customcolor', [0.21960784494876862 0.501960813999176 0.5647059082984924]);
model.geom('geom3').run('r3');
model.geom('geom3').create('r4', 'Rectangle');
model.geom('geom3').feature('r4').set('size', {'ms_width' 't_gp_ms'});
model.geom('geom3').feature('r4').set('pos', {'0' '-t_gp_ms'});
model.geom('geom3').feature('r4').set('selresult', true);
model.geom('geom3').feature('r4').set('color', 'custom');
model.geom('geom3').feature('r4').set('customcolor', [0.21960784494876862 0.501960813999176 0.5647059082984924]);
model.geom('geom3').run('r4');
model.geom('geom3').create('r5', 'Rectangle');
model.geom('geom3').feature('r5').set('size', {'W_ms*2' 'h_ms+t_ms+t_gp_ms'});
model.geom('geom3').feature('r5').set('pos', {'ms_width/2-W_ms' '0'});
model.geom('geom3').feature('r5').setIndex('pos', '-t_gp_ms', 1);
model.geom('geom3').run('fin');
model.geom('geom3').create('sel1', 'ExplicitSelection');
model.geom('geom3').feature('sel1').selection('selection').set('fin', [1 2 3 6 8 9 10]);
model.geom('geom3').run('sel1');

model.view('view3').hideObjects.create('hide1');
model.view('view3').hideObjects('hide1').init(2);
model.view('view3').hideObjects('hide1').named('sel1');

model.cpl.create('intop5', 'Integration', 'geom3');
model.cpl('intop5').set('axisym', true);
model.cpl('intop5').selection.geom('geom3', 1);
model.cpl('intop5').selection.set([15 16 17 18]);
model.cpl('intop5').set('method', 'summation');
model.cpl.create('intop6', 'Integration', 'geom3');
model.cpl('intop6').set('axisym', true);
model.cpl('intop6').selection.set([7]);

model.physics.create('ec3', 'ConductiveMedia', 'geom3');
model.physics('ec3').model('comp3');
model.physics('ec3').selection.set([2 3 5 6 8 10]);
model.physics('ec3').feature('cucn1').set('sigma_mat', 'userdef');
model.physics('ec3').feature('cucn1').set('sigma', {'j*w_ms*epsilon0_const' '0' '0' '0' 'j*w_ms*epsilon0_const' '0' '0' '0' 'j*w_ms*epsilon0_const'});
model.physics('ec3').feature('cucn1').set('epsilonr_mat', 'userdef');
model.physics('ec3').feature('cucn1').set('epsilonr', [0 0 0 0 0 0 0 0 0]);
model.physics('ec3').create('pot1', 'ElectricPotential', 1);
model.physics('ec3').feature('pot1').selection.set([15 16 17 18]);
model.physics('ec3').feature('pot1').set('V0', '1[V]');
model.physics('ec3').create('gnd1', 'Ground', 1);
model.physics('ec3').feature('gnd1').selection.set([4 11 24]);
model.physics('ec3').create('cucn2', 'CurrentConservation', 2);
model.physics('ec3').feature('cucn2').selection.set([2 5 10]);
model.physics('ec3').feature('cucn2').set('sigma_mat', 'userdef');
model.physics('ec3').feature('cucn2').set('sigma', {'sigma_d_ms+j*w_ms*epsr_ms*epsilon0_const' '0' '0' '0' 'sigma_d_ms+j*w_ms*epsr_ms*epsilon0_const' '0' '0' '0' 'sigma_d_ms+j*w_ms*epsr_ms*epsilon0_const'});
model.physics('ec3').feature('cucn2').set('epsilonr_mat', 'userdef');
model.physics('ec3').feature('cucn2').set('epsilonr', [0 0 0 0 0 0 0 0 0]);
model.physics.create('mf3', 'InductionCurrents', 'geom3');
model.physics('mf3').model('comp3');
model.physics('mf3').prop('EquationForm').setIndex('form', 'Frequency', 0);
model.physics('mf3').prop('EquationForm').setIndex('freq_src', 'userdef', 0);
model.physics('mf3').prop('EquationForm').setIndex('freq', 'frq_ms', 0);
model.physics('mf3').create('als1', 'AmperesLawSolid', 2);
model.physics('mf3').feature('als1').selection.all;
model.physics('mf3').feature('als1').set('sigma_mat', 'userdef');
model.physics('mf3').feature('als1').set('mur_mat', 'userdef');
model.physics('mf3').feature('als1').set('epsilonr_mat', 'userdef');
model.physics('mf3').feature('als1').set('epsilonr', [0 0 0 0 0 0 0 0 0]);
model.physics('mf3').create('als2', 'AmperesLawSolid', 2);
model.physics('mf3').feature('als2').selection.set([2 5 10]);
model.physics('mf3').feature('als2').set('sigma_mat', 'userdef');
model.physics('mf3').feature('als2').set('sigma', {'sigma_d_ms' '0' '0' '0' 'sigma_d_ms' '0' '0' '0' 'sigma_d_ms'});
model.physics('mf3').feature('als2').set('mur_mat', 'userdef');
model.physics('mf3').feature('als2').set('epsilonr_mat', 'userdef');
model.physics('mf3').feature('als2').set('epsilonr', {'epsr_ms' '0' '0' '0' 'epsr_ms' '0' '0' '0' 'epsr_ms'});
model.physics('mf3').create('als3', 'AmperesLawSolid', 2);
model.physics('mf3').feature('als3').selection.set([1 4 7 9]);
model.physics('mf3').feature('als3').set('sigma_mat', 'userdef');
model.physics('mf3').feature('als3').set('sigma', {'sigma_c_ms' '0' '0' '0' 'sigma_c_ms' '0' '0' '0' 'sigma_c_ms'});
model.physics('mf3').feature('als3').set('mur_mat', 'userdef');
model.physics('mf3').feature('als3').set('epsilonr_mat', 'userdef');
model.physics('mf3').create('ecd1', 'ExternalCurrentDensity', 2);
model.physics('mf3').feature('ecd1').selection.set([7]);
model.physics('mf3').feature('ecd1').set('Je', {'0' '0' 'sigma_c_ms*1[V/m]'});
model.physics('mf3').create('pmc1', 'PerfectMagneticConductor', 1);
model.physics('mf3').feature('pmc1').selection.set([2 9 22]);

model.variable.create('var3');
model.variable('var3').model('comp3');
model.variable('var3').set('R_ms', 'real(1[V/m]/intop6(mf3.Jz))');
model.variable('var3').descr('R_ms', 'Distributed resistance');
model.variable('var3').set('L_ms', 'imag(1[V/m]/intop6(mf3.Jz))/w_ms');
model.variable('var3').descr('L_ms', 'Distributed inductance');
model.variable('var3').set('C_ms', 'imag(intop5(reacf(V3)*1[A/m])/1[V])/w_ms');
model.variable('var3').descr('C_ms', 'Capacitance');
model.variable('var3').set('G_ms', 'real(intop5(reacf(V3)*1[A/m])/1[V])');
model.variable('var3').descr('G_ms', 'Shunt conductance');
model.variable('var3').set('Zc_ms', 'sqrt((R_ms+j*w_ms*L_ms)/(G_ms+j*w_ms*C_ms))');
model.variable('var3').descr('Zc_ms', 'Characteristic impedance');
model.variable('var3').set('gamma_ms', 'sqrt((R_ms+j*w_ms*L_ms)*(G_ms+j*w_ms*C_ms))');
model.variable('var3').descr('gamma_ms', 'Propagation constant');

model.mesh('mesh3').automatic(false);
model.mesh('mesh3').feature('size').set('hmax', 'min(ms_width/25,h_ms/2)');
model.mesh('mesh3').feature('size').set('hmin', 5.1E-7);
model.mesh('mesh3').create('size1', 'Size');
model.mesh('mesh3').feature('size1').selection.geom('geom3', 2);
model.mesh('mesh3').feature('size1').selection.set([1 4 7 9]);
model.mesh('mesh3').feature('size1').set('hauto', 9);
model.mesh('mesh3').feature.move('size1', 1);
model.mesh('mesh3').create('bl1', 'BndLayer');
model.mesh('mesh3').feature('bl1').create('blp', 'BndLayerProp');
model.mesh('mesh3').feature('bl1').selection.geom(2);
model.mesh('mesh3').feature('bl1').selection.set([]);
model.mesh('mesh3').feature('bl1').selection.allGeom;
model.mesh('mesh3').feature('bl1').selection.geom('geom3', 2);
model.mesh('mesh3').feature('bl1').selection.set([1 4 9]);
model.mesh('mesh3').feature('bl1').feature('blp').selection.set([4 11 24]);
model.mesh('mesh3').feature('bl1').feature('blp').set('inittype', 'blhmin');
model.mesh('mesh3').feature('bl1').feature('blp').set('blhmin', 'min(delta_ms/2,t_gp_ms/10)');
model.mesh('mesh3').create('bl2', 'BndLayer');
model.mesh('mesh3').feature('bl2').create('blp', 'BndLayerProp');
model.mesh('mesh3').feature('bl2').selection.geom('geom3', 2);
model.mesh('mesh3').feature('bl2').selection.set([7]);
model.mesh('mesh3').feature('bl2').feature('blp').selection.set([15 16 17 18]);
model.mesh('mesh3').feature('bl2').feature('blp').set('inittype', 'blhmin');
model.mesh('mesh3').feature('bl2').feature('blp').set('blhmin', 'min(delta_ms/2,t_ms/10)');

model.modelNode.create('comp4', true);

model.geom.create('geom4', 2);
model.geom('geom4').model('comp4');

model.mesh.create('mesh4', 'geom4');

model.modelNode('comp4').label('Coplanar Waveguide');
model.modelNode('comp4').sorder('linear');

model.variable.create('var4');
model.variable('var4').model('comp4');

model.geom('geom4').run;

model.variable('var4').set('R_cpw', 'real(1[V/m]/intop8(mf4.Jz))');
model.variable('var4').descr('R_cpw', 'Distributed resistance');
model.variable('var4').set('L_cpw', 'imag(1[V/m]/intop8(mf4.Jz))/w_cpw');
model.variable('var4').descr('L_cpw', 'Distributed inductance');
model.variable('var4').set('C_cpw', 'imag(intop7(reacf(V4)*1[A/m])/1[V])/w_cpw');
model.variable('var4').descr('C_cpw', 'Capacitance');
model.variable('var4').set('G_cpw', 'real(intop7(reacf(V4)*1[A/m])/1[V])');
model.variable('var4').descr('G_cpw', 'Shunt conductance');
model.variable('var4').set('Zc_cpw', 'sqrt((R_cpw+j*w_cpw*L_cpw)/(G_cpw+j*w_cpw*C_cpw))');
model.variable('var4').descr('Zc_cpw', 'Characteristic impedance');
model.variable('var4').set('gamma_cpw', 'sqrt((R_cpw+j*w_cpw*L_cpw)*(G_cpw+j*w_cpw*C_cpw))');
model.variable('var4').descr('gamma_cpw', 'Propagation constant');

model.geom('geom4').lengthUnit('mm');
model.geom('geom4').create('r1', 'Rectangle');
model.geom('geom4').feature('r1').set('size', {'cpw_width' 'cpw_height'});
model.geom('geom4').feature('r1').set('pos', {'-cpw_width/2' '0'});
model.geom('geom4').feature('r1').label('Air');
model.geom('geom4').run('r1');
model.geom('geom4').create('r2', 'Rectangle');
model.geom('geom4').feature('r2').set('size', {'W_cpw' 't_cpw'});
model.geom('geom4').feature('r2').set('pos', {'-W_cpw/2' '0'});
model.geom('geom4').feature('r2').label('Track');
model.geom('geom4').feature('r2').set('selresult', true);
model.geom('geom4').feature('r2').set('color', 'custom');
model.geom('geom4').feature('r2').set('customcolor', [0.21960784494876862 0.501960813999176 0.5647059082984924]);
model.geom('geom4').run('r2');
model.geom('geom4').create('r3', 'Rectangle');
model.geom('geom4').feature('r3').set('size', {'(cpw_width-W_cpw-2*g_cpw)/2' '1'});
model.geom('geom4').feature('r3').setIndex('size', 't_cpw', 1);
model.geom('geom4').feature('r3').set('pos', {'-cpw_width/2' '0'});
model.geom('geom4').feature('r3').label('Left GP');
model.geom('geom4').feature('r3').set('selresult', true);
model.geom('geom4').feature('r3').set('color', 'custom');
model.geom('geom4').feature('r3').set('customcolor', [0.21960784494876862 0.501960813999176 0.5647059082984924]);
model.geom('geom4').run('r3');
model.geom('geom4').create('r4', 'Rectangle');
model.geom('geom4').feature('r4').set('size', {'(cpw_width-W_cpw-2*g_cpw)/2' '1'});
model.geom('geom4').feature('r4').setIndex('size', 't_cpw', 1);
model.geom('geom4').feature('r4').set('pos', {'W_cpw/2+g_cpw' '0'});
model.geom('geom4').feature('r4').label('Right GP');
model.geom('geom4').feature('r4').set('selresult', true);
model.geom('geom4').feature('r4').set('color', 'custom');
model.geom('geom4').feature('r4').set('customcolor', [0.21960784494876862 0.501960813999176 0.5647059082984924]);
model.geom('geom4').run('r4');
model.geom('geom4').create('r5', 'Rectangle');
model.geom('geom4').feature('r5').set('size', {'cpw_width' 'h_cpw'});
model.geom('geom4').feature('r5').set('pos', {'-cpw_width/2' '0'});
model.geom('geom4').feature('r5').setIndex('pos', '-h_cpw', 1);
model.geom('geom4').feature('r5').label('Dielectric');
model.geom('geom4').run('r5');
model.geom('geom4').create('r6', 'Rectangle');
model.geom('geom4').feature('r6').set('size', {'cpw_width' 'h_bp_cpw'});
model.geom('geom4').feature('r6').set('pos', {'-cpw_width/2' '0'});
model.geom('geom4').feature('r6').setIndex('pos', '-h_cpw-h_bp_cpw', 1);
model.geom('geom4').feature('r6').label('Backplane/Bottom Domain');
model.geom('geom4').feature('r6').set('selresult', true);
model.geom('geom4').feature('r6').set('color', 'custom');
model.geom('geom4').feature('r6').set('customcolor', [0.21960784494876862 0.501960813999176 0.5647059082984924]);
model.geom('geom4').run('r6');
model.geom('geom4').create('r7', 'Rectangle');
model.geom('geom4').feature('r7').set('size', {'g_cpw*2+W_cpw+((cpw_width-W_cpw-2*g_cpw)/2)*0.2' '1'});
model.geom('geom4').feature('r7').setIndex('size', 'h_cpw+h_bp_cpw+t_cpw', 1);
model.geom('geom4').feature('r7').set('pos', {'-cpw_width/2+(cpw_width-W_cpw-2*g_cpw)/2-((cpw_width-W_cpw-2*g_cpw)/2)*0.1' '0'});
model.geom('geom4').feature('r7').setIndex('pos', '-h_cpw-h_bp_cpw', 1);
model.geom('geom4').feature('r7').set('type', 'curve');
model.geom('geom4').run('fin');
model.geom('geom4').create('sel1', 'ExplicitSelection');
model.geom('geom4').feature('sel1').selection('selection').set('fin', [1 2 3 4 8 10 12 13 14]);

model.view('view4').hideObjects.create('hide1');
model.view('view4').hideObjects('hide1').init(2);
model.view('view4').hideObjects('hide1').named('sel1');

model.cpl.create('intop7', 'Integration', 'geom4');

model.geom('geom4').run;

model.cpl('intop7').set('axisym', true);
model.cpl('intop7').selection.geom('geom4', 1);
model.cpl('intop7').selection.set([20 21 22 23]);
model.cpl('intop7').set('method', 'summation');
model.cpl.create('intop8', 'Integration', 'geom4');
model.cpl('intop8').set('axisym', true);
model.cpl('intop8').selection.set([9]);

model.physics.create('ec4', 'ConductiveMedia', 'geom4');
model.physics('ec4').model('comp4');
model.physics('ec4').selection.set([2 4 6 8 10 13]);
model.physics('ec4').feature('cucn1').set('sigma_mat', 'userdef');
model.physics('ec4').feature('cucn1').set('sigma', {'j*w_cpw*epsilon0_const' '0' '0' '0' 'j*w_cpw*epsilon0_const' '0' '0' '0' 'j*w_cpw*epsilon0_const'});
model.physics('ec4').feature('cucn1').set('epsilonr_mat', 'userdef');
model.physics('ec4').feature('cucn1').set('epsilonr', [0 0 0 0 0 0 0 0 0]);
model.physics('ec4').create('cucn2', 'CurrentConservation', 2);
model.physics('ec4').feature('cucn2').selection.set([2 6 13]);
model.physics('ec4').feature('cucn2').set('sigma_mat', 'userdef');
model.physics('ec4').feature('cucn2').set('sigma', {'sigma_d_cpw+j*w_cpw*epsr_cpw*epsilon0_const' '0' '0' '0' 'sigma_d_cpw+j*w_cpw*epsr_cpw*epsilon0_const' '0' '0' '0' 'sigma_d_cpw+j*w_cpw*epsr_cpw*epsilon0_const'});
model.physics('ec4').feature('cucn2').set('epsilonr_mat', 'userdef');
model.physics('ec4').feature('cucn2').set('epsilonr', [0 0 0 0 0 0 0 0 0]);
model.physics('ec4').create('pot1', 'ElectricPotential', 1);
model.physics('ec4').feature('pot1').selection.set([20 21 22 23]);
model.physics('ec4').feature('pot1').set('V0', 1);
model.physics('ec4').create('gnd1', 'Ground', 1);
model.physics('ec4').feature('gnd1').selection.set([6 8 15 16 17 26 27 28 34 35]);
model.physics('ec4').create('gnd2', 'Ground', 1);
model.physics('ec4').feature('gnd2').selection.set([4 13 32]);
model.physics.create('mf4', 'InductionCurrents', 'geom4');
model.physics('mf4').model('comp4');
model.physics('mf4').prop('EquationForm').setIndex('form', 'Frequency', 0);
model.physics('mf4').prop('EquationForm').setIndex('freq_src', 'userdef', 0);
model.physics('mf4').prop('EquationForm').setIndex('freq', 'frq_cpw', 0);
model.physics('mf4').create('als1', 'AmperesLawSolid', 2);
model.physics('mf4').feature('als1').selection.all;
model.physics('mf4').feature('als1').set('sigma_mat', 'userdef');
model.physics('mf4').feature('als1').set('mur_mat', 'userdef');
model.physics('mf4').feature('als1').set('epsilonr_mat', 'userdef');
model.physics('mf4').create('als2', 'AmperesLawSolid', 2);
model.physics('mf4').feature('als2').selection.set([3 7 9 11 14]);
model.physics('mf4').feature('als2').set('sigma_mat', 'userdef');
model.physics('mf4').feature('als2').set('sigma', {'sigma_c_cpw' '0' '0' '0' 'sigma_c_cpw' '0' '0' '0' 'sigma_c_cpw'});
model.physics('mf4').feature('als2').set('mur_mat', 'userdef');
model.physics('mf4').feature('als2').set('epsilonr_mat', 'userdef');
model.physics('mf4').create('als3', 'AmperesLawSolid', 2);
model.physics('mf4').feature('als3').selection.set([1 5 12]);
model.physics('mf4').feature('als3').set('sigma_mat', 'userdef');
model.physics('mf4').feature('als3').set('sigma', {'sigma_bp_cpw' '0' '0' '0' 'sigma_bp_cpw' '0' '0' '0' 'sigma_bp_cpw'});
model.physics('mf4').feature('als3').set('mur_mat', 'userdef');
model.physics('mf4').feature('als3').set('epsilonr_mat', 'userdef');
model.physics('mf4').create('als4', 'AmperesLawSolid', 2);
model.physics('mf4').feature('als4').selection.set([2 6 13]);
model.physics('mf4').feature('als4').set('sigma_mat', 'userdef');
model.physics('mf4').feature('als4').set('sigma', {'sigma_d_cpw' '0' '0' '0' 'sigma_d_cpw' '0' '0' '0' 'sigma_d_cpw'});
model.physics('mf4').feature('als4').set('mur_mat', 'userdef');
model.physics('mf4').feature('als4').set('epsilonr_mat', 'userdef');
model.physics('mf4').feature('als4').set('epsilonr', {'epsr_cpw' '0' '0' '0' 'epsr_cpw' '0' '0' '0' 'epsr_cpw'});
model.physics('mf4').create('ecd1', 'ExternalCurrentDensity', 2);
model.physics('mf4').feature('ecd1').selection.set([9]);
model.physics('mf4').feature('ecd1').set('Je', {'0' '0' 'sigma_c_cpw*1[V/m]'});
model.physics('mf4').create('pmc1', 'PerfectMagneticConductor', 1);
model.physics('mf4').feature('pmc1').selection.set([2 11 30]);

model.mesh('mesh4').automatic(false);
model.mesh('mesh4').feature('size').set('custom', true);
model.mesh('mesh4').feature('size').set('hmax', 'min(cpw_width/25,h_cpw/2)');
model.mesh('mesh4').feature('size').set('hmin', 5.55E-7);
model.mesh('mesh4').create('size1', 'Size');
model.mesh('mesh4').feature('size1').selection.geom('geom4', 2);
model.mesh('mesh4').feature('size1').selection.set([1 3 5 7 9 11 12 14]);
model.mesh('mesh4').feature('size1').set('hauto', 9);
model.mesh('mesh4').feature('size1').set('custom', true);
model.mesh('mesh4').feature('size1').set('hmaxactive', true);
model.mesh('mesh4').feature('size1').set('hmax', 'min(cpw_width/25,h_cpw/2)');
model.mesh('mesh4').feature.move('size1', 1);
model.mesh('mesh4').create('bl1', 'BndLayer');
model.mesh('mesh4').feature('bl1').create('blp', 'BndLayerProp');
model.mesh('mesh4').feature('bl1').selection.geom(2);
model.mesh('mesh4').feature('bl1').selection.set([]);
model.mesh('mesh4').feature('bl1').selection.allGeom;
model.mesh('mesh4').feature('bl1').selection.geom('geom4', 2);
model.mesh('mesh4').feature('bl1').selection.set([9]);
model.mesh('mesh4').feature('bl1').feature('blp').selection.set([20 21 22 23]);
model.mesh('mesh4').feature('bl1').feature('blp').set('inittype', 'blhmin');
model.mesh('mesh4').feature('bl1').feature('blp').set('blhmin', 'min(delta_cpw/2,t_cpw/10)');
model.mesh('mesh4').create('bl2', 'BndLayer');
model.mesh('mesh4').feature('bl2').create('blp', 'BndLayerProp');
model.mesh('mesh4').feature('bl2').selection.geom('geom4', 2);
model.mesh('mesh4').feature('bl2').selection.set([3 7 11 14]);
model.mesh('mesh4').feature('bl2').feature('blp').selection.set([6 8 15 16 17 26 27 28 34 35]);
model.mesh('mesh4').feature('bl2').feature('blp').set('inittype', 'blhmin');
model.mesh('mesh4').feature('bl2').feature('blp').set('blhmin', 'min(delta_cpw/2,t_cpw/10)');
model.mesh('mesh4').create('bl3', 'BndLayer');
model.mesh('mesh4').feature('bl3').create('blp', 'BndLayerProp');
model.mesh('mesh4').feature('bl3').selection.geom('geom4', 2);
model.mesh('mesh4').feature('bl3').selection.set([1 5 12]);
model.mesh('mesh4').feature('bl3').feature('blp').selection.set([4 13 32]);
model.mesh('mesh4').feature('bl3').feature('blp').set('inittype', 'blhmin');
model.mesh('mesh4').feature('bl3').feature('blp').set('blhmin', 'min(delta_cpw/2,t_bp_cpw/10)');

model.study.create('std1');
model.study('std1').create('stat', 'Stationary');
model.study('std1').feature('stat').setSolveFor('/physics/ec', true);
model.study('std1').feature('stat').setSolveFor('/physics/mf', true);
model.study('std1').feature('stat').setSolveFor('/physics/ec2', true);
model.study('std1').feature('stat').setSolveFor('/physics/mf2', true);
model.study('std1').feature('stat').setSolveFor('/physics/ec3', true);
model.study('std1').feature('stat').setSolveFor('/physics/mf3', true);
model.study('std1').feature('stat').setSolveFor('/physics/ec4', true);
model.study('std1').feature('stat').setSolveFor('/physics/mf4', true);
model.study.create('std2');
model.study('std2').create('stat', 'Stationary');
model.study('std2').feature('stat').setSolveFor('/physics/ec', true);
model.study('std2').feature('stat').setSolveFor('/physics/mf', true);
model.study('std2').feature('stat').setSolveFor('/physics/ec2', true);
model.study('std2').feature('stat').setSolveFor('/physics/mf2', true);
model.study('std2').feature('stat').setSolveFor('/physics/ec3', true);
model.study('std2').feature('stat').setSolveFor('/physics/mf3', true);
model.study('std2').feature('stat').setSolveFor('/physics/ec4', true);
model.study('std2').feature('stat').setSolveFor('/physics/mf4', true);
model.study.create('std3');
model.study('std3').create('stat', 'Stationary');
model.study('std3').feature('stat').setSolveFor('/physics/ec', true);
model.study('std3').feature('stat').setSolveFor('/physics/mf', true);
model.study('std3').feature('stat').setSolveFor('/physics/ec2', true);
model.study('std3').feature('stat').setSolveFor('/physics/mf2', true);
model.study('std3').feature('stat').setSolveFor('/physics/ec3', true);
model.study('std3').feature('stat').setSolveFor('/physics/mf3', true);
model.study('std3').feature('stat').setSolveFor('/physics/ec4', true);
model.study('std3').feature('stat').setSolveFor('/physics/mf4', true);
model.study.create('std4');
model.study('std4').create('stat', 'Stationary');
model.study('std4').feature('stat').setSolveFor('/physics/ec', true);
model.study('std4').feature('stat').setSolveFor('/physics/mf', true);
model.study('std4').feature('stat').setSolveFor('/physics/ec2', true);
model.study('std4').feature('stat').setSolveFor('/physics/mf2', true);
model.study('std4').feature('stat').setSolveFor('/physics/ec3', true);
model.study('std4').feature('stat').setSolveFor('/physics/mf3', true);
model.study('std4').feature('stat').setSolveFor('/physics/ec4', true);
model.study('std4').feature('stat').setSolveFor('/physics/mf4', true);
model.study('std1').setGenPlots(false);
model.study('std1').setGenConv(false);
model.study('std1').feature('stat').setEntry('activate', 'ec2', false);
model.study('std1').feature('stat').setEntry('activate', 'mf2', false);
model.study('std1').feature('stat').setEntry('activate', 'ec3', false);
model.study('std1').feature('stat').setEntry('activate', 'mf3', false);
model.study('std1').feature('stat').setEntry('activate', 'ec4', false);
model.study('std1').feature('stat').setEntry('activate', 'mf4', false);
model.study('std1').feature('stat').setEntry('mesh', 'geom2', 'nomesh');
model.study('std1').feature('stat').setEntry('mesh', 'geom3', 'nomesh');
model.study('std1').feature('stat').setEntry('mesh', 'geom4', 'nomesh');
model.study('std2').setGenPlots(false);
model.study('std2').setGenConv(false);
model.study('std2').feature('stat').setEntry('activate', 'ec', false);
model.study('std2').feature('stat').setEntry('activate', 'mf', false);
model.study('std2').feature('stat').setEntry('activate', 'ec3', false);
model.study('std2').feature('stat').setEntry('activate', 'mf3', false);
model.study('std2').feature('stat').setEntry('activate', 'ec4', false);
model.study('std2').feature('stat').setEntry('activate', 'mf4', false);
model.study('std2').feature('stat').setEntry('mesh', 'geom1', 'nomesh');
model.study('std2').feature('stat').setEntry('mesh', 'geom3', 'nomesh');
model.study('std2').feature('stat').setEntry('mesh', 'geom4', 'nomesh');
model.study('std3').setGenPlots(false);
model.study('std3').setGenConv(false);
model.study('std3').feature('stat').setEntry('activate', 'ec', false);
model.study('std3').feature('stat').setEntry('activate', 'mf', false);
model.study('std3').feature('stat').setEntry('activate', 'ec2', false);
model.study('std3').feature('stat').setEntry('activate', 'mf2', false);
model.study('std3').feature('stat').setEntry('activate', 'ec4', false);
model.study('std3').feature('stat').setEntry('activate', 'mf4', false);
model.study('std3').feature('stat').setEntry('mesh', 'geom1', 'nomesh');
model.study('std3').feature('stat').setEntry('mesh', 'geom2', 'nomesh');
model.study('std3').feature('stat').setEntry('mesh', 'geom4', 'nomesh');
model.study('std4').setGenPlots(false);
model.study('std4').setGenConv(false);
model.study('std4').feature('stat').setEntry('activate', 'ec', false);
model.study('std4').feature('stat').setEntry('activate', 'mf', false);
model.study('std4').feature('stat').setEntry('activate', 'ec2', false);
model.study('std4').feature('stat').setEntry('activate', 'mf2', false);
model.study('std4').feature('stat').setEntry('activate', 'ec3', false);
model.study('std4').feature('stat').setEntry('activate', 'mf3', false);
model.study('std4').feature('stat').setEntry('mesh', 'geom1', 'nomesh');
model.study('std4').feature('stat').setEntry('mesh', 'geom2', 'nomesh');
model.study('std4').feature('stat').setEntry('mesh', 'geom3', 'nomesh');

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
model.sol('sol1').feature('s1').feature('fc1').set('linsolver', 'dDef');
model.sol('sol1').feature('s1').feature.remove('fcDef');
model.sol('sol1').feature('s1').feature.remove('seDef');
model.sol('sol1').attach('std1');
model.sol.create('sol2');
model.sol('sol2').study('std2');
model.sol('sol2').create('st1', 'StudyStep');
model.sol('sol2').feature('st1').set('study', 'std2');
model.sol('sol2').feature('st1').set('studystep', 'stat');
model.sol('sol2').create('v1', 'Variables');
model.sol('sol2').feature('v1').set('control', 'stat');
model.sol('sol2').create('s1', 'Stationary');
model.sol('sol2').feature('s1').create('seDef', 'Segregated');
model.sol('sol2').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol2').feature('s1').feature('fc1').set('linsolver', 'dDef');
model.sol('sol2').feature('s1').feature.remove('fcDef');
model.sol('sol2').feature('s1').feature.remove('seDef');
model.sol('sol2').attach('std2');
model.sol.create('sol3');
model.sol('sol3').study('std3');
model.sol('sol3').create('st1', 'StudyStep');
model.sol('sol3').feature('st1').set('study', 'std3');
model.sol('sol3').feature('st1').set('studystep', 'stat');
model.sol('sol3').create('v1', 'Variables');
model.sol('sol3').feature('v1').set('control', 'stat');
model.sol('sol3').create('s1', 'Stationary');
model.sol('sol3').feature('s1').create('seDef', 'Segregated');
model.sol('sol3').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol3').feature('s1').feature('fc1').set('linsolver', 'dDef');
model.sol('sol3').feature('s1').feature.remove('fcDef');
model.sol('sol3').feature('s1').feature.remove('seDef');
model.sol('sol3').attach('std3');
model.sol.create('sol4');
model.sol('sol4').study('std4');
model.sol('sol4').create('st1', 'StudyStep');
model.sol('sol4').feature('st1').set('study', 'std4');
model.sol('sol4').feature('st1').set('studystep', 'stat');
model.sol('sol4').create('v1', 'Variables');
model.sol('sol4').feature('v1').set('control', 'stat');
model.sol('sol4').create('s1', 'Stationary');
model.sol('sol4').feature('s1').create('seDef', 'Segregated');
model.sol('sol4').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol4').feature('s1').feature('fc1').set('linsolver', 'dDef');
model.sol('sol4').feature('s1').feature.remove('fcDef');
model.sol('sol4').feature('s1').feature.remove('seDef');
model.sol('sol4').attach('std4');

model.result.dataset.remove('dset5');
model.result.dataset.remove('dset6');
model.result.dataset.remove('dset7');
model.result.dataset.remove('dset8');
model.result.dataset.remove('dset9');
model.result.dataset.remove('dset10');
model.result.dataset.remove('dset11');
model.result.dataset.remove('dset12');
model.result.dataset.remove('dset13');
model.result.dataset.remove('dset14');
model.result.dataset.remove('dset15');
model.result.dataset.remove('dset16');
model.result.dataset('dset2').set('solution', 'sol2');
model.result.dataset('dset3').set('solution', 'sol3');
model.result.dataset('dset4').set('solution', 'sol4');
model.result.dataset.create('cln1', 'CutLine2D');
model.result.dataset('cln1').set('data', 'dset2');
model.result.dataset('cln1').setIndex('genpoints', '-3*(d_twin+4*(t_ins_twin+R1_twin))', 0, 1);
model.result.dataset('cln1').setIndex('genpoints', 0, 1, 0);
model.result.dataset('cln1').setIndex('genpoints', '3*(d_twin+4*(t_ins_twin+R1_twin))', 1, 1);
model.result.numerical.create('gev1', 'EvalGlobal');
model.result.numerical('gev1').label('Coaxial Resistance');
model.result.numerical('gev1').setIndex('expr', 'R_coax', 0);
model.result.numerical('gev1').setIndex('unit', ['ohm' '/m'], 0);
model.result.numerical('gev1').setIndex('descr', 'Distributed resistance', 0);
model.result.table.create('tbl1', 'Table');
model.result.table('tbl1').comments('Coaxial Resistance');
model.result.numerical('gev1').set('table', 'tbl1');
model.result.numerical('gev1').setResult;
model.result.table('tbl1').label('Coaxial');
model.result.numerical.create('gev2', 'EvalGlobal');
model.result.numerical('gev2').label('Coaxial Inductance');
model.result.numerical('gev2').setIndex('expr', 'L_coax', 0);
model.result.numerical('gev2').setIndex('unit', 'H/m', 0);
model.result.numerical('gev2').setIndex('descr', 'Distributed inductance', 0);
model.result.numerical('gev2').set('table', 'tbl1');
model.result.numerical('gev2').setResult;
model.result.numerical.create('gev3', 'EvalGlobal');
model.result.numerical('gev3').label('Coaxial Conductance');
model.result.numerical('gev3').setIndex('expr', 'G_coax', 0);
model.result.numerical('gev3').setIndex('unit', 'S/m', 0);
model.result.numerical('gev3').setIndex('descr', 'Shunt conductance', 0);
model.result.numerical('gev3').set('table', 'tbl1');
model.result.numerical('gev3').setResult;
model.result.numerical.create('gev4', 'EvalGlobal');
model.result.numerical('gev4').label('Coaxial Capacitance');
model.result.numerical('gev4').setIndex('expr', 'C_coax', 0);
model.result.numerical('gev4').setIndex('unit', 'F/m', 0);
model.result.numerical('gev4').setIndex('descr', 'Capacitance', 0);
model.result.numerical('gev4').set('table', 'tbl1');
model.result.numerical('gev4').setResult;
model.result.numerical.create('gev5', 'EvalGlobal');
model.result.numerical('gev5').label('Coaxial Characteristic Impedance');
model.result.numerical('gev5').setIndex('expr', 'Zc_coax', 0);
model.result.numerical('gev5').setIndex('unit', ['ohm' ], 0);
model.result.numerical('gev5').setIndex('descr', 'Characteristic impedance', 0);
model.result.numerical('gev5').set('table', 'tbl1');
model.result.numerical('gev5').setResult;
model.result.numerical.create('gev6', 'EvalGlobal');
model.result.numerical('gev6').label('Coaxial Propagation Constant');
model.result.numerical('gev6').setIndex('expr', 'gamma_coax', 0);
model.result.numerical('gev6').setIndex('unit', '1/m', 0);
model.result.numerical('gev6').setIndex('descr', 'Propagation constant', 0);
model.result.numerical('gev6').set('table', 'tbl1');
model.result.numerical('gev6').setResult;
model.result.numerical.create('gev7', 'EvalGlobal');
model.result.numerical('gev7').label('Twin Lead Resistance');
model.result.numerical('gev7').set('data', 'dset2');
model.result.numerical('gev7').setIndex('expr', 'R_twin', 0);
model.result.numerical('gev7').setIndex('unit', ['ohm' '/m'], 0);
model.result.numerical('gev7').setIndex('descr', 'Distributed resistance', 0);
model.result.table.create('tbl2', 'Table');
model.result.table('tbl2').comments('Twin Lead Resistance');
model.result.numerical('gev7').set('table', 'tbl2');
model.result.numerical('gev7').setResult;
model.result.table('tbl2').label('Twin Lead');
model.result.numerical.create('gev8', 'EvalGlobal');
model.result.numerical('gev8').label('Twin Lead Inductance');
model.result.numerical('gev8').set('data', 'dset2');
model.result.numerical('gev8').setIndex('expr', 'L_twin', 0);
model.result.numerical('gev8').setIndex('unit', 'H/m', 0);
model.result.numerical('gev8').setIndex('descr', 'Distributed inductance', 0);
model.result.numerical('gev8').set('table', 'tbl2');
model.result.numerical('gev8').setResult;
model.result.numerical.create('gev9', 'EvalGlobal');
model.result.numerical('gev9').label('Twin Lead Conductance');
model.result.numerical('gev9').set('data', 'dset2');
model.result.numerical('gev9').setIndex('expr', 'G_twin', 0);
model.result.numerical('gev9').setIndex('unit', 'S/m', 0);
model.result.numerical('gev9').setIndex('descr', 'Shunt conductance', 0);
model.result.numerical('gev9').set('table', 'tbl2');
model.result.numerical('gev9').setResult;
model.result.numerical.create('gev10', 'EvalGlobal');
model.result.numerical('gev10').label('Twin Lead Capacitance');
model.result.numerical('gev10').set('data', 'dset2');
model.result.numerical('gev10').setIndex('expr', 'C_twin', 0);
model.result.numerical('gev10').setIndex('unit', 'F/m', 0);
model.result.numerical('gev10').setIndex('descr', 'Capacitance', 0);
model.result.numerical('gev10').set('table', 'tbl2');
model.result.numerical('gev10').setResult;
model.result.numerical.create('gev11', 'EvalGlobal');
model.result.numerical('gev11').label('Twin Lead Characteristic Impedance');
model.result.numerical('gev11').set('data', 'dset2');
model.result.numerical('gev11').setIndex('expr', 'Zc_twin', 0);
model.result.numerical('gev11').setIndex('unit', ['ohm' ], 0);
model.result.numerical('gev11').setIndex('descr', 'Characteristic impedance', 0);
model.result.numerical('gev11').set('table', 'tbl2');
model.result.numerical('gev11').setResult;
model.result.numerical.create('gev12', 'EvalGlobal');
model.result.numerical('gev12').label('Twin Lead Propagation Constant');
model.result.numerical('gev12').set('data', 'dset2');
model.result.numerical('gev12').setIndex('expr', 'gamma_twin', 0);
model.result.numerical('gev12').setIndex('unit', '1/m', 0);
model.result.numerical('gev12').setIndex('descr', 'Propagation constant', 0);
model.result.numerical('gev12').set('table', 'tbl2');
model.result.numerical('gev12').setResult;
model.result.numerical.create('gev13', 'EvalGlobal');
model.result.numerical('gev13').label('Microstrip Resistance');
model.result.numerical('gev13').set('data', 'dset3');
model.result.numerical('gev13').setIndex('expr', 'R_ms', 0);
model.result.numerical('gev13').setIndex('unit', ['ohm' '/m'], 0);
model.result.numerical('gev13').setIndex('descr', 'Distributed resistance', 0);
model.result.table.create('tbl3', 'Table');
model.result.table('tbl3').comments('Microstrip Resistance');
model.result.numerical('gev13').set('table', 'tbl3');
model.result.numerical('gev13').setResult;
model.result.table('tbl3').label('Microstrip');
model.result.numerical.create('gev14', 'EvalGlobal');
model.result.numerical('gev14').label('Microstrip Inductance');
model.result.numerical('gev14').set('data', 'dset3');
model.result.numerical('gev14').setIndex('expr', 'L_ms', 0);
model.result.numerical('gev14').setIndex('unit', 'H/m', 0);
model.result.numerical('gev14').setIndex('descr', 'Distributed inductance', 0);
model.result.numerical('gev14').set('table', 'tbl3');
model.result.numerical('gev14').setResult;
model.result.numerical.create('gev15', 'EvalGlobal');
model.result.numerical('gev15').label('Microstrip Conductance');
model.result.numerical('gev15').set('data', 'dset3');
model.result.numerical('gev15').setIndex('expr', 'G_ms', 0);
model.result.numerical('gev15').setIndex('unit', 'S/m', 0);
model.result.numerical('gev15').setIndex('descr', 'Shunt conductance', 0);
model.result.numerical('gev15').set('table', 'tbl3');
model.result.numerical('gev15').setResult;
model.result.numerical.create('gev16', 'EvalGlobal');
model.result.numerical('gev16').label('Microstrip Capacitance');
model.result.numerical('gev16').set('data', 'dset3');
model.result.numerical('gev16').setIndex('expr', 'C_ms', 0);
model.result.numerical('gev16').setIndex('unit', 'F/m', 0);
model.result.numerical('gev16').setIndex('descr', 'Capacitance', 0);
model.result.numerical('gev16').set('table', 'tbl3');
model.result.numerical('gev16').setResult;
model.result.numerical.create('gev17', 'EvalGlobal');
model.result.numerical('gev17').label('Microstrip Characteristic Impedance');
model.result.numerical('gev17').set('data', 'dset3');
model.result.numerical('gev17').setIndex('expr', 'Zc_ms', 0);
model.result.numerical('gev17').setIndex('unit', ['ohm' ], 0);
model.result.numerical('gev17').setIndex('descr', 'Characteristic impedance', 0);
model.result.numerical('gev17').set('table', 'tbl3');
model.result.numerical('gev17').setResult;
model.result.numerical.create('gev18', 'EvalGlobal');
model.result.numerical('gev18').label('Microstrip Propagation Constant');
model.result.numerical('gev18').set('data', 'dset3');
model.result.numerical('gev18').setIndex('expr', 'gamma_ms', 0);
model.result.numerical('gev18').setIndex('unit', '1/m', 0);
model.result.numerical('gev18').setIndex('descr', 'Propagation constant', 0);
model.result.numerical('gev18').set('table', 'tbl3');
model.result.numerical('gev18').setResult;
model.result.numerical.create('gev19', 'EvalGlobal');
model.result.numerical('gev19').label('Coplanar Waveguide Resistance');
model.result.numerical('gev19').set('data', 'dset4');
model.result.numerical('gev19').setIndex('expr', 'R_cpw', 0);
model.result.numerical('gev19').setIndex('unit', ['ohm' '/m'], 0);
model.result.numerical('gev19').setIndex('descr', 'Distributed resistance', 0);
model.result.table.create('tbl4', 'Table');
model.result.table('tbl4').comments('Coplanar Waveguide Resistance');
model.result.numerical('gev19').set('table', 'tbl4');
model.result.numerical('gev19').setResult;
model.result.table('tbl4').label('Coplanar Waveguide');
model.result.numerical.create('gev20', 'EvalGlobal');
model.result.numerical('gev20').label('Coplanar Waveguide Inductance');
model.result.numerical('gev20').set('data', 'dset4');
model.result.numerical('gev20').setIndex('expr', 'L_cpw', 0);
model.result.numerical('gev20').setIndex('unit', 'H/m', 0);
model.result.numerical('gev20').setIndex('descr', 'Distributed inductance', 0);
model.result.numerical('gev20').set('table', 'tbl4');
model.result.numerical('gev20').setResult;
model.result.numerical.create('gev21', 'EvalGlobal');
model.result.numerical('gev21').label('Coplanar Waveguide Conductance');
model.result.numerical('gev21').set('data', 'dset4');
model.result.numerical('gev21').setIndex('expr', 'G_cpw', 0);
model.result.numerical('gev21').setIndex('unit', 'S/m', 0);
model.result.numerical('gev21').setIndex('descr', 'Shunt conductance', 0);
model.result.numerical('gev21').set('table', 'tbl4');
model.result.numerical('gev21').setResult;
model.result.numerical.create('gev22', 'EvalGlobal');
model.result.numerical('gev22').label('Coplanar Waveguide Capacitance');
model.result.numerical('gev22').set('data', 'dset4');
model.result.numerical('gev22').setIndex('expr', 'C_cpw', 0);
model.result.numerical('gev22').setIndex('unit', 'F/m', 0);
model.result.numerical('gev22').setIndex('descr', 'Capacitance', 0);
model.result.numerical('gev22').set('table', 'tbl4');
model.result.numerical('gev22').setResult;
model.result.numerical.create('gev23', 'EvalGlobal');
model.result.numerical('gev23').label('Coplanar Waveguide Characteristic Impedance');
model.result.numerical('gev23').set('data', 'dset4');
model.result.numerical('gev23').setIndex('expr', 'Zc_cpw', 0);
model.result.numerical('gev23').setIndex('unit', ['ohm' ], 0);
model.result.numerical('gev23').setIndex('descr', 'Characteristic impedance', 0);
model.result.numerical('gev23').set('table', 'tbl4');
model.result.numerical('gev23').setResult;
model.result.numerical.create('gev24', 'EvalGlobal');
model.result.numerical('gev24').label('Coplanar Waveguide Propagation Constant');
model.result.numerical('gev24').set('data', 'dset4');
model.result.numerical('gev24').setIndex('expr', 'gamma_cpw', 0);
model.result.numerical('gev24').setIndex('unit', '1/m', 0);
model.result.numerical('gev24').setIndex('descr', 'Propagation constant', 0);
model.result.numerical('gev24').set('table', 'tbl4');
model.result.numerical('gev24').setResult;
model.result.create('pg1', 'PlotGroup2D');
model.result('pg1').run;
model.result('pg1').label('Coaxial');
model.result('pg1').create('surf1', 'Surface');
model.result('pg1').run;
model.result('pg1').create('con1', 'Contour');
model.result('pg1').feature('con1').set('expr', 'imag(Az)');
model.result('pg1').feature('con1').set('coloring', 'uniform');
model.result('pg1').feature('con1').set('color', 'white');
model.result('pg1').feature('con1').set('colorlegend', false);
model.result('pg1').feature('con1').create('sel1', 'Selection');
model.result('pg1').feature('con1').feature('sel1').selection.set([2]);
model.result('pg1').run;
model.result('pg1').create('str1', 'Streamline');
model.result('pg1').feature('str1').set('expr', {'ec.Ex' 'ec.Ey'});
model.result('pg1').feature('str1').selection.set([5 6 9 10]);
model.result('pg1').run;
model.result('pg1').set('titletype', 'manual');
model.result('pg1').set('title', 'Electric potential. Lines: Electric Field, Magnetic Flux Density');
model.result('pg1').set('legendpos', 'bottom');
model.result.duplicate('pg2', 'pg1');
model.result('pg2').run;
model.result('pg2').label('Twin Lead');
model.result('pg2').set('data', 'dset2');
model.result('pg2').set('showhiddenobjects', true);
model.result('pg2').run;
model.result('pg2').run;
model.result('pg2').feature('surf1').set('expr', 'V2');
model.result('pg2').run;
model.result('pg2').feature('con1').set('expr', 'imag(A2z)');
model.result('pg2').run;
model.result('pg2').feature('con1').feature('sel1').selection.set([1]);
model.result('pg2').run;
model.result('pg2').feature('str1').set('expr', {'ec2.Ex' 'ec2.Ey'});
model.result('pg2').feature('str1').set('posmethod', 'start');
model.result('pg2').feature('str1').set('startdata', 'cln1');
model.result('pg1').run;
model.result.duplicate('pg3', 'pg1');
model.result('pg3').run;
model.result('pg3').label('Microstrip');
model.result('pg3').set('data', 'dset3');
model.result('pg3').set('showhiddenobjects', true);
model.result('pg3').run;
model.result('pg3').run;
model.result('pg3').feature('surf1').set('expr', 'V3');
model.result('pg3').run;
model.result('pg3').feature('con1').set('expr', 'imag(A3z)');
model.result('pg3').run;
model.result('pg3').feature('con1').feature('sel1').selection.set([2 3 5 6 8 10]);
model.result('pg3').run;
model.result('pg3').feature('str1').set('expr', {'ec3.Ex' 'ec3.Ey'});
model.result('pg3').feature('str1').selection.set([15 16 17 18]);
model.result('pg1').run;
model.result.duplicate('pg4', 'pg1');
model.result('pg4').run;
model.result('pg4').label('Coplanar Waveguide');
model.result('pg4').set('data', 'dset4');
model.result('pg4').set('showhiddenobjects', true);
model.result('pg4').run;
model.result('pg4').run;
model.result('pg4').feature('surf1').set('expr', 'V4');
model.result('pg4').run;
model.result('pg4').feature('con1').set('expr', 'imag(A4z)');
model.result('pg4').run;
model.result('pg4').feature('con1').feature('sel1').selection.set([1 2 4 5 6 8 10 12 13]);
model.result('pg4').run;
model.result('pg4').feature('str1').set('expr', {'ec4.Ex' 'ec4.Ey'});
model.result('pg4').feature('str1').selection.set([20 21 22 23]);

model.sol('sol4').study('std4');
model.sol('sol4').feature.remove('s1');
model.sol('sol4').feature.remove('v1');
model.sol('sol4').feature.remove('st1');
model.sol('sol4').create('st1', 'StudyStep');
model.sol('sol4').feature('st1').set('study', 'std4');
model.sol('sol4').feature('st1').set('studystep', 'stat');
model.sol('sol4').create('v1', 'Variables');
model.sol('sol4').feature('v1').set('control', 'stat');
model.sol('sol4').create('s1', 'Stationary');
model.sol('sol4').feature('s1').create('seDef', 'Segregated');
model.sol('sol4').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol4').feature('s1').feature('fc1').set('linsolver', 'dDef');
model.sol('sol4').feature('s1').feature.remove('fcDef');
model.sol('sol4').feature('s1').feature.remove('seDef');
model.sol('sol4').attach('std4');
model.sol('sol4').runAll;

model.result('pg4').run;

model.view('view4').axis.set('xmin', '-.28');
model.view('view4').axis.set('xmax', 0.28);
model.view('view4').axis.set('ymin', '-.08');
model.view('view4').axis.set('ymax', 0.4);

model.title([]);

model.description('');

model.label('transmission_line_calculator_embedded.mph');

model.setExpectedComputationTime('4 seconds');

model.result.report.create('rpt1', 'Report');
model.result.report('rpt1').set('format', 'docx');
model.result.report('rpt1').set('filename', 'user:///transmission_line_calculator_coax');
model.result.report('rpt1').set('alwaysask', true);
model.result.report('rpt1').feature.create('tp1', 'TitlePage');
model.result.report('rpt1').feature('tp1').set('title', 'Coaxial Line');
model.result.report('rpt1').feature('tp1').set('titleimage', 'none');
model.result.report('rpt1').feature('tp1').set('summary', 'This report shows the relevant input parameters together with computed transmission line parameters R, L, G and C as well as the characteristic impedance and propagation constant for a coaxial line.');
model.result.report('rpt1').feature.create('toc1', 'TableOfContents');
model.result.report('rpt1').feature.create('sec1', 'Section');
model.result.report('rpt1').feature('sec1').label('Software Information');
model.result.report('rpt1').feature('sec1').feature.create('root1', 'Model');
model.result.report('rpt1').feature('sec1').feature.create('std1', 'Study');
model.result.report('rpt1').feature('sec1').feature('std1').setIndex('children', false, 0, 1);
model.result.report('rpt1').label('Coaxial');
model.result.report('rpt1').feature.create('sec2', 'Section');
model.result.report('rpt1').feature('sec2').label('Global Definitions');
model.result.report('rpt1').feature('sec2').feature.create('param1', 'Parameter');
model.result.report('rpt1').feature('sec2').feature('param1').setIndex('children', false, 9, 1);
model.result.report('rpt1').feature('sec2').feature('param1').setIndex('children', false, 10, 1);
model.result.report('rpt1').feature('sec2').feature('param1').setIndex('children', false, 11, 1);
model.result.report('rpt1').feature('sec2').feature('param1').setIndex('children', false, 12, 1);
model.result.report('rpt1').feature('sec2').feature('param1').setIndex('children', false, 13, 1);
model.result.report('rpt1').feature('sec2').feature('param1').setIndex('children', false, 14, 1);
model.result.report('rpt1').feature('sec2').feature('param1').setIndex('children', false, 15, 1);
model.result.report('rpt1').feature('sec2').feature('param1').setIndex('children', false, 16, 1);
model.result.report('rpt1').feature('sec2').feature('param1').setIndex('children', false, 17, 1);
model.result.report('rpt1').feature('sec2').feature('param1').setIndex('children', false, 18, 1);
model.result.report('rpt1').feature('sec2').feature('param1').setIndex('children', false, 19, 1);
model.result.report('rpt1').feature('sec2').feature('param1').setIndex('children', false, 20, 1);
model.result.report('rpt1').feature('sec2').feature('param1').setIndex('children', false, 21, 1);
model.result.report('rpt1').feature('sec2').feature('param1').setIndex('children', false, 22, 1);
model.result.report('rpt1').feature('sec2').feature('param1').setIndex('children', false, 23, 1);
model.result.report('rpt1').feature('sec2').feature('param1').setIndex('children', false, 24, 1);
model.result.report('rpt1').feature('sec2').feature('param1').setIndex('children', false, 25, 1);
model.result.report('rpt1').feature('sec2').feature('param1').setIndex('children', false, 26, 1);
model.result.report('rpt1').feature('sec2').feature('param1').setIndex('children', false, 27, 1);
model.result.report('rpt1').feature('sec2').feature('param1').setIndex('children', false, 28, 1);
model.result.report('rpt1').feature('sec2').feature('param1').setIndex('children', false, 29, 1);
model.result.report('rpt1').feature('sec2').feature('param1').setIndex('children', false, 30, 1);
model.result.report('rpt1').feature('sec2').feature('param1').setIndex('children', false, 31, 1);
model.result.report('rpt1').feature('sec2').feature('param1').setIndex('children', false, 32, 1);
model.result.report('rpt1').feature('sec2').feature('param1').setIndex('children', false, 33, 1);
model.result.report('rpt1').feature('sec2').feature('param1').setIndex('children', false, 34, 1);
model.result.report('rpt1').feature('sec2').feature('param1').setIndex('children', false, 35, 1);
model.result.report('rpt1').feature('sec2').feature('param1').setIndex('children', false, 36, 1);
model.result.report('rpt1').feature('sec2').feature('param1').setIndex('children', false, 37, 1);
model.result.report('rpt1').feature('sec2').feature('param1').setIndex('children', false, 38, 1);
model.result.report('rpt1').feature('sec2').feature('param1').setIndex('children', false, 39, 1);
model.result.report('rpt1').feature('sec2').feature('param1').setIndex('children', false, 40, 1);
model.result.report('rpt1').feature('sec2').feature('param1').setIndex('children', false, 41, 1);
model.result.report('rpt1').feature('sec2').feature('param1').setIndex('children', false, 42, 1);
model.result.report('rpt1').feature('sec2').feature('param1').setIndex('children', false, 43, 1);
model.result.report('rpt1').feature('sec2').feature('param1').setIndex('children', false, 44, 1);
model.result.report('rpt1').feature('sec2').feature('param1').setIndex('children', false, 45, 1);
model.result.report('rpt1').feature('sec2').feature('param1').setIndex('children', false, 46, 1);
model.result.report('rpt1').feature('sec2').feature('param1').setIndex('children', false, 47, 1);
model.result.report('rpt1').feature('sec2').feature('param1').setIndex('children', false, 48, 1);
model.result.report('rpt1').feature('sec2').feature('param1').setIndex('children', false, 49, 1);
model.result.report('rpt1').feature('sec2').feature('param1').setIndex('children', false, 50, 1);
model.result.report('rpt1').feature('sec2').feature('param1').setIndex('children', false, 51, 1);
model.result.report('rpt1').feature('sec2').feature('param1').setIndex('children', false, 52, 1);
model.result.report('rpt1').feature('sec2').feature('param1').setIndex('children', false, 53, 1);
model.result.report('rpt1').feature('sec2').feature('param1').setIndex('children', false, 54, 1);
model.result.report('rpt1').feature('sec2').feature('param1').setIndex('children', false, 55, 1);
model.result.report('rpt1').feature('sec2').feature('param1').setIndex('children', false, 56, 1);
model.result.report('rpt1').feature('sec2').feature('param1').setIndex('children', false, 57, 1);
model.result.report('rpt1').feature('sec2').feature('param1').setIndex('children', false, 58, 1);
model.result.report('rpt1').feature('sec2').feature('param1').setIndex('children', false, 59, 1);
model.result.report('rpt1').feature('sec2').feature('param1').setIndex('children', false, 60, 1);
model.result.report('rpt1').feature('sec2').feature('param1').setIndex('children', false, 61, 1);
model.result.report('rpt1').feature('sec2').feature('param1').setIndex('children', false, 62, 1);
model.result.report('rpt1').feature('sec2').feature('param1').setIndex('children', false, 63, 1);
model.result.report('rpt1').feature.create('sec3', 'Section');
model.result.report('rpt1').feature('sec3').label('Results');
model.result.report('rpt1').feature('sec3').feature.create('sec1', 'Section');
model.result.report('rpt1').feature('sec3').feature('sec1').label('Tables');
model.result.report('rpt1').feature('sec3').feature('sec1').feature.create('mtbl1', 'Table');
model.result.report('rpt1').feature('sec3').feature('sec1').feature('mtbl1').label('R, L, G, C, Zc, gamma');
model.result.report('rpt1').feature('sec3').feature('sec1').feature('mtbl1').set('commentssource', 'none');
model.result.report('rpt1').feature('sec3').feature.create('sec2', 'Section');
model.result.report('rpt1').feature('sec3').feature('sec2').label('Plots');
model.result.report('rpt1').feature('sec3').feature('sec2').feature.create('pg1', 'PlotGroup');
model.result.report('rpt1').feature('sec3').feature('sec2').feature.create('mesh1', 'Mesh');
model.result.report('rpt1').feature('sec3').feature('sec2').feature('mesh1').setIndex('children', false, 0, 1);
model.result.report('rpt1').feature('sec3').feature('sec2').feature('mesh1').setIndex('children', false, 1, 1);
model.result.report('rpt1').feature('sec3').feature('sec2').feature('mesh1').setIndex('children', false, 2, 1);
model.result.report.duplicate('rpt2', 'rpt1');
model.result.report('rpt2').label('Twin Lead');
model.result.report('rpt2').set('filename', 'user:///transmission_line_calculator_twin');
model.result.report('rpt2').feature('tp1').label('Twin Lead');
model.result.report('rpt2').feature('tp1').set('summary', 'This report shows the relevant input parameters together with computed transmission line parameters R, L, G and C as well as the characteristic impedance and propagation constant for a twin lead line.');
model.result.report('rpt2').feature('sec1').feature('std1').set('noderef', 'std2');
model.result.report('rpt2').feature('sec1').feature('std1').setIndex('children', false, 0, 1);
model.result.report('rpt2').feature('sec2').feature('param1').setIndex('children', false, 0, 1);
model.result.report('rpt2').feature('sec2').feature('param1').setIndex('children', false, 1, 1);
model.result.report('rpt2').feature('sec2').feature('param1').setIndex('children', false, 2, 1);
model.result.report('rpt2').feature('sec2').feature('param1').setIndex('children', false, 3, 1);
model.result.report('rpt2').feature('sec2').feature('param1').setIndex('children', false, 4, 1);
model.result.report('rpt2').feature('sec2').feature('param1').setIndex('children', false, 5, 1);
model.result.report('rpt2').feature('sec2').feature('param1').setIndex('children', false, 6, 1);
model.result.report('rpt2').feature('sec2').feature('param1').setIndex('children', false, 7, 1);
model.result.report('rpt2').feature('sec2').feature('param1').setIndex('children', false, 8, 1);
model.result.report('rpt2').feature('sec2').feature('param1').setIndex('children', true, 14, 1);
model.result.report('rpt2').feature('sec2').feature('param1').setIndex('children', true, 15, 1);
model.result.report('rpt2').feature('sec2').feature('param1').setIndex('children', true, 16, 1);
model.result.report('rpt2').feature('sec2').feature('param1').setIndex('children', true, 17, 1);
model.result.report('rpt2').feature('sec2').feature('param1').setIndex('children', true, 18, 1);
model.result.report('rpt2').feature('sec2').feature('param1').setIndex('children', true, 19, 1);
model.result.report('rpt2').feature('sec2').feature('param1').setIndex('children', true, 20, 1);
model.result.report('rpt2').feature('sec2').feature('param1').setIndex('children', true, 21, 1);
model.result.report('rpt2').feature('sec3').feature('sec1').feature('mtbl1').set('noderef', 'tbl2');
model.result.report('rpt2').feature('sec3').feature('sec2').feature('pg1').set('noderef', 'pg2');
model.result.report('rpt2').feature('sec3').feature('sec2').feature('mesh1').set('noderef', 'mesh2');
model.result.report('rpt2').feature('sec3').feature('sec2').feature('mesh1').setIndex('children', false, 0, 1);
model.result.report('rpt2').feature('sec3').feature('sec2').feature('mesh1').setIndex('children', false, 1, 1);
model.result.report('rpt2').feature('sec3').feature('sec2').feature('mesh1').setIndex('children', false, 2, 1);
model.result.report.duplicate('rpt3', 'rpt1');
model.result.report('rpt3').label('Microstrip');
model.result.report('rpt3').set('filename', 'user:///transmission_line_calculator_twin');
model.result.report('rpt3').feature('tp1').label('Microstrip');
model.result.report('rpt3').feature('tp1').set('summary', 'This report shows the relevant input parameters together with computed transmission line parameters R, L, G and C as well as the characteristic impedance and propagation constant for a twin lead line.');
model.result.report('rpt3').feature('sec1').feature('std1').set('noderef', 'std3');
model.result.report('rpt3').feature('sec1').feature('std1').setIndex('children', false, 0, 1);
model.result.report('rpt3').feature('sec2').feature('param1').setIndex('children', false, 0, 1);
model.result.report('rpt3').feature('sec2').feature('param1').setIndex('children', false, 1, 1);
model.result.report('rpt3').feature('sec2').feature('param1').setIndex('children', false, 2, 1);
model.result.report('rpt3').feature('sec2').feature('param1').setIndex('children', false, 3, 1);
model.result.report('rpt3').feature('sec2').feature('param1').setIndex('children', false, 4, 1);
model.result.report('rpt3').feature('sec2').feature('param1').setIndex('children', false, 5, 1);
model.result.report('rpt3').feature('sec2').feature('param1').setIndex('children', false, 6, 1);
model.result.report('rpt3').feature('sec2').feature('param1').setIndex('children', false, 7, 1);
model.result.report('rpt3').feature('sec2').feature('param1').setIndex('children', false, 8, 1);
model.result.report('rpt3').feature('sec2').feature('param1').setIndex('children', true, 27, 1);
model.result.report('rpt3').feature('sec2').feature('param1').setIndex('children', true, 28, 1);
model.result.report('rpt3').feature('sec2').feature('param1').setIndex('children', true, 29, 1);
model.result.report('rpt3').feature('sec2').feature('param1').setIndex('children', true, 30, 1);
model.result.report('rpt3').feature('sec2').feature('param1').setIndex('children', true, 31, 1);
model.result.report('rpt3').feature('sec2').feature('param1').setIndex('children', true, 32, 1);
model.result.report('rpt3').feature('sec2').feature('param1').setIndex('children', true, 33, 1);
model.result.report('rpt3').feature('sec2').feature('param1').setIndex('children', true, 34, 1);
model.result.report('rpt3').feature('sec3').feature('sec1').feature('mtbl1').set('noderef', 'tbl3');
model.result.report('rpt3').feature('sec3').feature('sec2').feature('pg1').set('noderef', 'pg3');
model.result.report('rpt3').feature('sec3').feature('sec2').feature('mesh1').set('noderef', 'mesh3');
model.result.report('rpt3').feature('sec3').feature('sec2').feature('mesh1').setIndex('children', false, 0, 1);
model.result.report('rpt3').feature('sec3').feature('sec2').feature('mesh1').setIndex('children', false, 1, 1);
model.result.report('rpt3').feature('sec3').feature('sec2').feature('mesh1').setIndex('children', false, 2, 1);
model.result.report('rpt3').feature('sec3').feature('sec2').feature('mesh1').setIndex('children', false, 3, 1);
model.result.report('rpt3').feature('sec3').feature('sec2').feature('mesh1').setIndex('children', false, 4, 1);
model.result.report.duplicate('rpt4', 'rpt1');
model.result.report('rpt4').label('Coplanar Waveguide');
model.result.report('rpt4').set('filename', 'user:///transmission_line_calculator_cpw');
model.result.report('rpt4').feature('tp1').label('Coplanar Waveguide');
model.result.report('rpt4').feature('tp1').set('summary', 'This report shows the relevant input parameters together with computed transmission line parameters R, L, G and C as well as the characteristic impedance and propagation constant for a twin lead line.');
model.result.report('rpt4').feature('sec1').feature('std1').set('noderef', 'std4');
model.result.report('rpt4').feature('sec1').feature('std1').setIndex('children', false, 0, 1);
model.result.report('rpt4').feature('sec2').feature('param1').setIndex('children', false, 0, 1);
model.result.report('rpt4').feature('sec2').feature('param1').setIndex('children', false, 1, 1);
model.result.report('rpt4').feature('sec2').feature('param1').setIndex('children', false, 2, 1);
model.result.report('rpt4').feature('sec2').feature('param1').setIndex('children', false, 3, 1);
model.result.report('rpt4').feature('sec2').feature('param1').setIndex('children', false, 4, 1);
model.result.report('rpt4').feature('sec2').feature('param1').setIndex('children', false, 5, 1);
model.result.report('rpt4').feature('sec2').feature('param1').setIndex('children', false, 6, 1);
model.result.report('rpt4').feature('sec2').feature('param1').setIndex('children', false, 7, 1);
model.result.report('rpt4').feature('sec2').feature('param1').setIndex('children', false, 8, 1);
model.result.report('rpt4').feature('sec2').feature('param1').setIndex('children', true, 43, 1);
model.result.report('rpt4').feature('sec2').feature('param1').setIndex('children', true, 44, 1);
model.result.report('rpt4').feature('sec2').feature('param1').setIndex('children', true, 45, 1);
model.result.report('rpt4').feature('sec2').feature('param1').setIndex('children', true, 46, 1);
model.result.report('rpt4').feature('sec2').feature('param1').setIndex('children', true, 47, 1);
model.result.report('rpt4').feature('sec2').feature('param1').setIndex('children', true, 48, 1);
model.result.report('rpt4').feature('sec2').feature('param1').setIndex('children', true, 49, 1);
model.result.report('rpt4').feature('sec2').feature('param1').setIndex('children', true, 50, 1);
model.result.report('rpt4').feature('sec2').feature('param1').setIndex('children', true, 51, 1);
model.result.report('rpt4').feature('sec3').feature('sec1').feature('mtbl1').set('noderef', 'tbl4');
model.result.report('rpt4').feature('sec3').feature('sec2').feature('pg1').set('noderef', 'pg4');
model.result.report('rpt4').feature('sec3').feature('sec2').feature('mesh1').set('noderef', 'mesh4');
model.result.report('rpt4').feature('sec3').feature('sec2').feature('mesh1').setIndex('children', false, 0, 1);
model.result.report('rpt4').feature('sec3').feature('sec2').feature('mesh1').setIndex('children', false, 1, 1);
model.result.report('rpt4').feature('sec3').feature('sec2').feature('mesh1').setIndex('children', false, 2, 1);
model.result.report('rpt4').feature('sec3').feature('sec2').feature('mesh1').setIndex('children', false, 3, 1);
model.result.report('rpt4').feature('sec3').feature('sec2').feature('mesh1').setIndex('children', false, 4, 1);
model.result.report('rpt4').feature('sec3').feature('sec2').feature('mesh1').setIndex('children', false, 5, 1);

model.title('Transmission Line Parameter Calculator');

model.description(['This app demonstrates the following:' newline  newline  native2unicode(hex2dec({'20' '22'}), 'unicode') ' Creating apps for small screens such as smartphones' newline  native2unicode(hex2dec({'20' '22'}), 'unicode') ' User-interface navigation with a top menu typically used on websites' newline  native2unicode(hex2dec({'20' '22'}), 'unicode') ' Dynamically hiding forms using card stacks to minimize the space required by the app' newline  native2unicode(hex2dec({'20' '22'}), 'unicode') ' Changing appearance by using different background colors.' newline  newline 'Transmission line theory is a cornerstone in the teaching of RF and microwave engineering.' newline  newline 'Transmission lines are used to guide waves of electromagnetic fields at radio frequencies. They exist in a variety of forms, many of which are adapted for easy fabrication and employment in printed circuit board (PCB) designs. Often, they are used to carry information, with minimal loss and distortion, within a device and between devices.' newline  newline 'Electromagnetic fields propagate along transmission lines as transverse electromagnetic (TEM) waves. The Transmission Line Parameter Calculator app computes resistance (R), inductance (L), conductance (G), and capacitance (C) as well as the characteristic impedance and propagation constant for some common transmission lines types: coaxial line, twin lead, microstrip line, and coplanar waveguide (CPW).']);

model.mesh.clearMeshes;

model.sol('sol1').clearSolutionData;
model.sol('sol2').clearSolutionData;
model.sol('sol3').clearSolutionData;
model.sol('sol4').clearSolutionData;

model.label('transmission_line_calculator.mph');

model.modelNode.label('Components');

out = model;
```

---

## Example 19: phase_change_lunardini

**Module:** Subsurface_Flow_Module_Verification_Examples_phase_change_lunardini  
**Category:** Unknown_Category  

### Model Description

**Model Overview**:
The simulation model "phase_change_lunardini" is designed to simulate heat conduction in a porous medium with phase change, specifically focusing on the freezing and thawing processes in soil. The model aims to predict the temperature distribution and phase change over time within a semi-infinite soil column subjected to a temperature change at its surface. The results from this model are intended to be compared with an analytical solution known as the Lunardini solution, which provides a benchmark for validating the accuracy of the COMSOL simulation.

**Geometry**:
The geometric setup of the model is a one-dimensional domain representing a semi-infinite soil column. The specifics of the geometry dimensions are not explicitly provided in the MATLAB code, but it is implied that the domain extends from the surface (x=0) into the soil (x>0) and is discretized using an interval with specified coordinates.

**Materials**:
The model includes three material phases: water, ice, and soil. The key properties of these materials are defined as follows:
- Water: Density (rho_water) is 1000 kg/m^3, and thermal conductivity (k_water) is 0.598 W/m/K.
- Ice: Density (rho_ice) is 920 kg/m^3, and thermal conductivity (k_ice) is calculated based on the porosity and the thermal conductivities of water and soil.
- Soil: Density (rho_solid) is 2530.1 kg/m^3, and thermal conductivity (k_solid) is calculated based on the porosity and the thermal conductivities of water and ice.

**Physics**:
The model utilizes the "PorousMediaHeatTransfer" physics interface to simulate heat transfer in the porous medium with phase change. The governing equations for this interface account for heat conduction in the solid and fluid phases, as well as the latent heat associated with the phase change between water and ice. The phase change is modeled using the "PhaseChangeMaterial" feature, which considers the phase transition function, latent heat, and the thermal properties of each phase.

**Boundary Conditions**:
The model applies a temperature boundary condition at the surface of the soil column (x=0), where the imposed temperature (T_in) is set to -6°C. The initial temperature (T_init) of the soil column is set to 4°C.

**Mesh**:
The geometry is discretized using a mesh with 100 elements along the interval, with a higher element density near the surface (x=0) and a gradually increasing element size towards the interior of the soil column. The mesh is generated using the "Distribution" feature with a predefined element count and element ratio.

**Study**:
The model performs a transient analysis to simulate the heat conduction and phase change processes over time. The study is set up with a time-dependent solver, and the simulation is run for a specified list of time points (0, 24, 48, 72 hours).

**Key Parameters**:
The key parameters in this model include:
- Porosity (por): 0.336
- Residual water saturation (Sw_res): 0.391
- Volumetric heat capacity (Cv): 690030 J/m^3/K
- Latent heat of freezing (L): 334560 J/kg
- Initial temperature (T_init): 4°C
- Imposed temperature at the surface (T_in): -6°C

**Expected Results**:
The model is expected to predict the temperature distribution within the soil column over time, as well as the progression of the freezing front (phase change interface) as it moves into the soil. The results will be compared with the Lunardini analytical solution to assess the accuracy of the simulation.

**Engineering Application**:
This model addresses the real-world engineering problem of predicting and understanding the freezing and thawing processes in soil, which is relevant to various applications such as geotechnical engineering, permafrost studies, and cold regions engineering. The ability to accurately simulate heat conduction and phase change in porous media is crucial for designing and managing infrastructure, assessing the stability of frozen ground, and predicting the impacts of climate change on permafrost regions.

### COMSOL MATLAB Code

```matlab
function out = model
%
% phase_change_lunardini.m
%
% Model exported on May 26 2025, 21:34 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/Subsurface_Flow_Module/Verification_Examples');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 1);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.physics.create('ht', 'PorousMediaHeatTransfer', 'geom1');
model.physics('ht').model('comp1');

model.study.create('std1');
model.study('std1').create('time', 'Transient');
model.study('std1').feature('time').setSolveFor('/physics/ht', true);

model.geom('geom1').create('i1', 'Interval');
model.geom('geom1').feature('i1').setIndex('coord', 10, 1);
model.geom('geom1').runPre('fin');

% To import content from file, use:
% model.param.loadFile('FILENAME');
model.param.set('por', '0.336', 'Porosity');
model.param.set('Sw_res', '0.391', 'Residual water saturation');
model.param.set('rho_solid', '2530.1[kg/m^3]', 'Density of soil');
model.param.set('rho_water', '1000[kg/m^3]', 'Density of water');
model.param.set('rho_ice', '920[kg/m^3]', 'Density of ice');
model.param.set('k_water', '0.598[W/m/K]', 'Thermal conductivity of water');
model.param.set('Cv', '690030[J/m^3/K]', 'Volumetric heat capacity');
model.param.set('L', '334560[J/kg]', 'Latent heat of freezing');
model.param.set('k_solid', '(2.417196[W/m/K]-por*k_water)/(1-por)', 'Thermal conductivity of soil');
model.param.set('k_ice', '((3.462696[W/m/K]-(1-por)*k_solid)/por-Sw_res*k_water)/(1-Sw_res)', 'Thermal conductivity of ice');
model.param.set('T_init', '4[degC]', 'Initial temperature');
model.param.set('T_in', '-6[degC]', 'Imposed temperature');

model.geom('geom1').run;

model.physics('ht').feature('porous1').feature('fluid1').create('phc1', 'PhaseChangeMaterial', 1);
model.physics('ht').feature('porous1').feature('fluid1').feature('phc1').set('PhaseTransitionFunction12', 'userdef');
model.physics('ht').feature('porous1').feature('fluid1').feature('phc1').set('L_pc12', 'L');
model.physics('ht').feature('porous1').feature('fluid1').feature('phc1').set('alpha12', 'f_phtr(T)');
model.physics('ht').feature('porous1').feature('fluid1').feature('phc1').set('k_phase1_mat', 'userdef');
model.physics('ht').feature('porous1').feature('fluid1').feature('phc1').set('k_phase1', {'k_ice' '0' '0' '0' 'k_ice' '0' '0' '0' 'k_ice'});
model.physics('ht').feature('porous1').feature('fluid1').feature('phc1').set('rho_phase1_mat', 'userdef');
model.physics('ht').feature('porous1').feature('fluid1').feature('phc1').set('rho_phase1', 'rho_ice');
model.physics('ht').feature('porous1').feature('fluid1').feature('phc1').set('Cp_phase1_mat', 'userdef');
model.physics('ht').feature('porous1').feature('fluid1').feature('phc1').set('Cp_phase1', 'Cv/rho_ice');
model.physics('ht').feature('porous1').feature('fluid1').feature('phc1').set('k_phase2_mat', 'userdef');
model.physics('ht').feature('porous1').feature('fluid1').feature('phc1').set('k_phase2', {'k_water' '0' '0' '0' 'k_water' '0' '0' '0' 'k_water'});
model.physics('ht').feature('porous1').feature('fluid1').feature('phc1').set('rho_phase2_mat', 'userdef');
model.physics('ht').feature('porous1').feature('fluid1').feature('phc1').set('rho_phase2', 'rho_water');
model.physics('ht').feature('porous1').feature('fluid1').feature('phc1').set('Cp_phase2_mat', 'userdef');
model.physics('ht').feature('porous1').feature('fluid1').feature('phc1').set('Cp_phase2', 'Cv/rho_water');

model.func.create('int1', 'Interpolation');
model.func('int1').model('comp1');
model.func('int1').set('funcname', 'f_phtr');
model.func('int1').setIndex('table', -4, 0, 0);
model.func('int1').setIndex('table', 'Sw_res', 0, 1);
model.func('int1').setIndex('table', -1, 1, 0);
model.func('int1').setIndex('table', 'Sw_res', 1, 1);
model.func('int1').setIndex('table', 0, 2, 0);
model.func('int1').setIndex('table', 1, 2, 1);
model.func('int1').setIndex('table', 6, 3, 0);
model.func('int1').setIndex('table', 1, 3, 1);
model.func('int1').setIndex('fununit', 1, 0);
model.func('int1').setIndex('argunit', 'degC', 0);

model.physics('ht').feature('porous1').feature('pm1').set('poro_mat', 'userdef');
model.physics('ht').feature('porous1').feature('pm1').set('poro', 'por');
model.physics('ht').feature('porous1').feature('pm1').set('porousMatrixPropertiesType', 'solidPhaseProperties');
model.physics('ht').feature('porous1').feature('pm1').set('k_sp_mat', 'userdef');
model.physics('ht').feature('porous1').feature('pm1').set('k_sp', {'k_solid' '0' '0' '0' 'k_solid' '0' '0' '0' 'k_solid'});
model.physics('ht').feature('porous1').feature('pm1').set('rho_sp_mat', 'userdef');
model.physics('ht').feature('porous1').feature('pm1').set('rho_sp', 'rho_solid');
model.physics('ht').feature('porous1').feature('pm1').set('Cp_sp_mat', 'userdef');
model.physics('ht').feature('porous1').feature('pm1').set('Cp_sp', 'Cv/rho_solid');
model.physics('ht').feature('init1').set('Tinit', 'T_init');
model.physics('ht').create('temp1', 'TemperatureBoundary', 0);
model.physics('ht').feature('temp1').selection.set([1]);
model.physics('ht').feature('temp1').set('T0', 'T_in');

model.mesh('mesh1').create('edg1', 'Edge');
model.mesh('mesh1').feature('edg1').create('dis1', 'Distribution');
model.mesh('mesh1').feature('edg1').feature('dis1').set('type', 'predefined');
model.mesh('mesh1').feature('edg1').feature('dis1').set('elemcount', 100);
model.mesh('mesh1').feature('edg1').feature('dis1').set('elemratio', 10);
model.mesh('mesh1').run;

model.study('std1').feature('time').set('tunit', 'h');
model.study('std1').feature('time').set('tlist', '0 24 48 72');

model.sol.create('sol1');
model.sol('sol1').study('std1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'time');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').set('control', 'time');
model.sol('sol1').create('t1', 'Time');
model.sol('sol1').feature('t1').set('tlist', '0 24 48 72');
model.sol('sol1').feature('t1').set('plot', 'off');
model.sol('sol1').feature('t1').set('plotgroup', 'Default');
model.sol('sol1').feature('t1').set('plotfreq', 'tout');
model.sol('sol1').feature('t1').set('probesel', 'all');
model.sol('sol1').feature('t1').set('probes', {});
model.sol('sol1').feature('t1').set('probefreq', 'tsteps');
model.sol('sol1').feature('t1').set('atolglobalvaluemethod', 'factor');
model.sol('sol1').feature('t1').set('atolmethod', {'comp1_T' 'global'});
model.sol('sol1').feature('t1').set('atol', {'comp1_T' '1e-3'});
model.sol('sol1').feature('t1').set('atolvaluemethod', {'comp1_T' 'factor'});
model.sol('sol1').feature('t1').set('reacf', true);
model.sol('sol1').feature('t1').set('storeudot', true);
model.sol('sol1').feature('t1').set('endtimeinterpolation', true);
model.sol('sol1').feature('t1').set('estrat', 'exclude');
model.sol('sol1').feature('t1').set('maxorder', 2);
model.sol('sol1').feature('t1').set('control', 'time');
model.sol('sol1').feature('t1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('t1').feature('fc1').set('jtech', 'once');
model.sol('sol1').feature('t1').feature('fc1').set('damp', 0.9);
model.sol('sol1').feature('t1').feature('fc1').set('stabacc', 'aacc');
model.sol('sol1').feature('t1').feature('fc1').set('aaccdim', 5);
model.sol('sol1').feature('t1').feature('fc1').set('aaccmix', 0.9);
model.sol('sol1').feature('t1').feature('fc1').set('aaccdelay', 1);
model.sol('sol1').feature('t1').create('d1', 'Direct');
model.sol('sol1').feature('t1').feature('d1').set('linsolver', 'pardiso');
model.sol('sol1').feature('t1').feature('d1').set('pivotperturb', 1.0E-13);
model.sol('sol1').feature('t1').feature('d1').label('Direct, heat transfer variables (ht)');
model.sol('sol1').feature('t1').create('i1', 'Iterative');
model.sol('sol1').feature('t1').feature('i1').set('linsolver', 'gmres');
model.sol('sol1').feature('t1').feature('i1').set('prefuntype', 'left');
model.sol('sol1').feature('t1').feature('i1').set('itrestart', 50);
model.sol('sol1').feature('t1').feature('i1').set('rhob', 20);
model.sol('sol1').feature('t1').feature('i1').set('maxlinit', 10000);
model.sol('sol1').feature('t1').feature('i1').set('nlinnormuse', 'on');
model.sol('sol1').feature('t1').feature('i1').label('AMG, heat transfer variables (ht)');
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
model.sol('sol1').feature('t1').feature('fc1').set('jtech', 'once');
model.sol('sol1').feature('t1').feature('fc1').set('damp', 0.9);
model.sol('sol1').feature('t1').feature('fc1').set('stabacc', 'aacc');
model.sol('sol1').feature('t1').feature('fc1').set('aaccdim', 5);
model.sol('sol1').feature('t1').feature('fc1').set('aaccmix', 0.9);
model.sol('sol1').feature('t1').feature('fc1').set('aaccdelay', 1);
model.sol('sol1').feature('t1').feature.remove('fcDef');
model.sol('sol1').attach('std1');
model.sol('sol1').feature('t1').set('maxstepconstraintbdf', 'const');
model.sol('sol1').feature('t1').set('maxstepbdf', '2[min]');
model.sol('sol1').runAll;

model.result.create('pg1', 'PlotGroup1D');
model.result('pg1').label('Temperature (ht)');
model.result('pg1').set('showlooplevelinput', {'off' 'off' 'off'});
model.result('pg1').set('data', 'dset1');
model.result('pg1').set('defaultPlotID', 'ht/HT_PhysicsInterfaces/icom8/pdef1/pcond1/pg1');
model.result('pg1').feature.create('lngr1', 'LineGraph');
model.result('pg1').feature('lngr1').set('xdata', 'expr');
model.result('pg1').feature('lngr1').set('xdataexpr', 'x');
model.result('pg1').feature('lngr1').set('data', 'parent');
model.result('pg1').feature('lngr1').selection.geom('geom1', 1);
model.result('pg1').feature('lngr1').selection.set([1]);
model.result('pg1').run;
model.result('pg1').setIndex('looplevelinput', 'manual', 0);
model.result('pg1').setIndex('looplevel', [2 3 4], 0);
model.result('pg1').set('legendlayout', 'outside');
model.result('pg1').set('legendposoutside', 'bottom');
model.result('pg1').run;
model.result('pg1').feature('lngr1').set('unit', 'degC');
model.result('pg1').feature('lngr1').set('legend', true);
model.result.table.create('tbl1', 'Table');
model.result.table('tbl1').importData('phase_change_lunardini_analytical_solution.txt');
model.result('pg1').run;
model.result('pg1').create('tblp1', 'Table');
model.result('pg1').feature('tblp1').set('markerpos', 'datapoints');
model.result('pg1').feature('tblp1').set('linewidth', 'preference');
model.result('pg1').feature('tblp1').set('linestyle', 'none');
model.result('pg1').feature('tblp1').set('linecolor', 'cyclereset');
model.result('pg1').feature('tblp1').set('linemarker', 'asterisk');
model.result('pg1').feature('tblp1').set('markerpos', 'interp');
model.result('pg1').feature('tblp1').set('markers', 25);
model.result('pg1').run;
model.result('pg1').set('axislimits', true);
model.result('pg1').set('xmax', 5);
model.result('pg1').run;

model.title('Phase Change in a Semi-Infinite Soil Column');

model.description('In this example, a heat-conduction problem with phase change in a porous material is solved and the results are compared with the analytical solution, also known as the Lunardini solution.');

model.label('phase_change_lunardini.mph');

model.modelNode.label('Components');

out = model;
```

---

## Example 20: corner_cube_retroreflector

**Module:** Ray_Optics_Module_Verification_Examples_corner_cube_retroreflector  
**Category:** Unknown_Category  

### Model Description

**Model Overview:**

The simulation model, named "corner_cube_retroreflector," is designed to simulate the reflection of a bundle of rays by a corner cube retroreflector. A corner cube retroreflector has the unique property of reflecting incoming rays in a direction that is exactly antiparallel to their initial direction, irrespective of the angle of incidence. This model employs the Geometrical Optics interface to demonstrate this optical phenomenon.

**Geometry:**

The geometric setup of the model is based on a corner cube retroreflector, which is essentially a set of three mutually perpendicular reflective surfaces that form the corner of a cube. The dimensions are not explicitly stated in the MATLAB code, but the retroreflector is likely of a standard size that is suitable for the verification example it is part of. The model is created in 3D space with millimeters as the length unit.

**Materials:**

The material used for the corner cube retroreflector is not explicitly defined in the provided MATLAB code. However, it is common for retroreflectors to use a material with a high refractive index to maximize reflection. The code sets the refractive index to 1.5 for the material, which is a typical value for many types of glass or optical plastics.

**Physics:**

The physics of the model is governed by the Geometrical Optics interface, which is part of the Ray Optics Module. This interface is responsible for simulating the propagation of light rays through the domain, taking into account the effects of reflection and refraction at interfaces between different media.

**Boundary Conditions:**

The boundary conditions for this model include the definition of mirror surfaces (reflective boundaries) and wall boundaries. The mirror boundary condition is applied to the three reflective surfaces of the corner cube, which are labeled as boundaries 5, 6, and 7. A wall boundary condition is applied to boundary 2, which may represent an entrance or exit surface for the rays.

**Mesh:**

The geometry is discretized using a mesh, which is created and named 'mesh1'. The specifics of the mesh settings are not detailed in the provided code snippet, but it is likely that the mesh is automatically generated by COMSOL with settings appropriate for the Geometrical Optics simulation.

**Study:**

The analysis performed in this model is a Ray Tracing study, which is a type of transient analysis used to compute the paths of rays as they propagate and interact with the geometry over time. The study is set up to solve for the ray trajectories at specified time steps.

**Key Parameters:**

Key parameters include the refractive index of the material (set to 1.5), the number of rays released (1000), and the angular spread of the released rays (with a half-angle of pi/18 radians). The rays are released from three different points, with coordinates defined relative to the corner of the cube.

**Expected Results:**

The model is expected to predict the trajectories of the rays as they are reflected by the corner cube retroreflector. The results will show how the rays are reflected in a direction antiparallel to their incident direction, demonstrating the unique property of the retroreflector.

**Engineering Application:**

Corner cube retroreflectors have various engineering applications, including in surveying instruments, where they are used as targets for laser range finders, in the aerospace industry for tracking and positioning of satellites and spacecraft, and in the automotive industry for enhancing visibility and safety. This simulation model can be used to design and optimize the performance of corner cube retroreflectors for specific applications, ensuring that they meet the required optical specifications.

### COMSOL MATLAB Code

```matlab
function out = model
%
% corner_cube_retroreflector.m
%
% Model exported on May 26 2025, 21:32 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/Ray_Optics_Module/Verification_Examples');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 3);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.physics.create('gop', 'GeometricalOptics', 'geom1');
model.physics('gop').model('comp1');

model.study.create('std1');
model.study('std1').create('rtrac', 'RayTracing');
model.study('std1').feature('rtrac').setSolveFor('/physics/gop', true);

model.geom('geom1').lengthUnit('mm');
model.geom.load({'part1'}, 'Ray_Optics_Module/3D/Retroreflectors/corner_cube_retroreflector_3d.mph', {'part1'});
model.geom('geom1').create('pi1', 'PartInstance');
model.geom('geom1').feature('pi1').set('selkeepnoncontr', false);
model.geom('geom1').feature('pi1').set('part', 'part1');
model.geom('geom1').feature('pi1').setEntry('inputexpr', 'niy', 1);
model.geom('geom1').feature('pi1').setEntry('inputexpr', 'niz', 1);
model.geom('geom1').run;

model.physics('gop').prop('MaximumSecondary').setIndex('MaximumSecondary', 0, 0);
model.physics('gop').feature('mp1').set('n_mat', 'userdef');
model.physics('gop').feature('mp1').set('n', [1.5 0 0 0 1.5 0 0 0 1.5]);
model.physics('gop').create('mir1', 'Mirror', 2);
model.physics('gop').feature('mir1').selection.set([5 6 7]);
model.physics('gop').create('wall1', 'Wall', 2);
model.physics('gop').feature('wall1').selection.set([2]);
model.physics('gop').create('relg1', 'ReleaseGrid', -1);
model.physics('gop').feature('relg1').setIndex('x0', '-22/sqrt(3)', 0);
model.physics('gop').feature('relg1').setIndex('x0', '-22/sqrt(3)-5', 1);
model.physics('gop').feature('relg1').setIndex('x0', '-22/sqrt(3)+5', 2);
model.physics('gop').feature('relg1').set('RayDirectionVector', 'Conical');
model.physics('gop').feature('relg1').setIndex('Nw', 1000, 0);
model.physics('gop').feature('relg1').set('cax', [1 1.3 1]);
model.physics('gop').feature('relg1').set('alphac', 'pi/18');

model.study('std1').feature('rtrac').set('timestepspec', 'specifylength');
model.study('std1').feature('rtrac').set('lunit', 'mm');
model.study('std1').feature('rtrac').set('llist', 'range(0,0.2,70)');

model.sol.create('sol1');
model.sol('sol1').study('std1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'rtrac');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').set('control', 'rtrac');
model.sol('sol1').create('t1', 'Time');
model.sol('sol1').feature('t1').set('tlist', 'range(0,0.01,1)');
model.sol('sol1').feature('t1').set('plot', 'off');
model.sol('sol1').feature('t1').set('plotgroup', 'Default');
model.sol('sol1').feature('t1').set('plotfreq', 'tout');
model.sol('sol1').feature('t1').set('probesel', 'all');
model.sol('sol1').feature('t1').set('probes', {});
model.sol('sol1').feature('t1').set('probefreq', 'tsteps');
model.sol('sol1').feature('t1').set('rtol', 1.0E-5);
model.sol('sol1').feature('t1').set('atolglobalvaluemethod', 'factor');
model.sol('sol1').feature('t1').set('reacf', false);
model.sol('sol1').feature('t1').set('storeudot', false);
model.sol('sol1').feature('t1').set('tstepsgenalpha', 'strict');
model.sol('sol1').feature('t1').set('endtimeinterpolation', true);
model.sol('sol1').feature('t1').set('timemethod', 'genalpha');
model.sol('sol1').feature('t1').set('estrat', 'exclude');
model.sol('sol1').feature('t1').set('control', 'rtrac');
model.sol('sol1').feature('t1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('t1').feature('fc1').set('ntolfact', 0.1);
model.sol('sol1').feature('t1').create('i1', 'Iterative');
model.sol('sol1').feature('t1').feature('i1').set('linsolver', 'gmres');
model.sol('sol1').feature('t1').feature('i1').create('ja1', 'Jacobi');
model.sol('sol1').feature('t1').feature('fc1').set('linsolver', 'i1');
model.sol('sol1').feature('t1').feature('fc1').set('ntolfact', 0.1);
model.sol('sol1').feature('t1').feature.remove('fcDef');
model.sol('sol1').attach('std1');
model.sol('sol1').runAll;

model.result.dataset.create('ray1', 'Ray');
model.result.dataset('ray1').set('solution', 'sol1');
model.result.dataset('ray1').set('posdof', {'comp1.qx' 'comp1.qy' 'comp1.qz'});
model.result.dataset('ray1').set('geom', 'geom1');
model.result.dataset('ray1').set('rgeom', 'pgeom_gop');
model.result.dataset('ray1').set('rgeomspec', 'fromphysics');
model.result.dataset('ray1').set('physicsinterface', 'gop');
model.result.create('pg1', 'PlotGroup3D');
model.result('pg1').set('data', 'ray1');
model.result('pg1').setIndex('looplevel', 351, 0);
model.result('pg1').label('Ray Trajectories (gop)');
model.result('pg1').create('rtrj1', 'RayTrajectories');
model.result('pg1').feature('rtrj1').set('linetype', 'line');
model.result('pg1').feature('rtrj1').create('col1', 'Color');
model.result('pg1').feature('rtrj1').feature('col1').set('expr', 't');
model.result('pg1').feature('rtrj1').create('filt1', 'RayTrajectoriesFilter');
model.result('pg1').run;
model.result('pg1').run;
model.result('pg1').feature('rtrj1').feature('col1').set('expr', 'gop.pidx');
model.result('pg1').run;
model.result.create('pg2', 'PlotGroup1D');
model.result('pg2').run;
model.result('pg2').label('Acute Angle of Incidence');
model.result('pg2').set('data', 'ray1');
model.result('pg2').setIndex('looplevelinput', 'last', 0);
model.result('pg2').create('rtp1', 'Ray1D');
model.result('pg2').feature('rtp1').set('markerpos', 'datapoints');
model.result('pg2').feature('rtp1').set('linewidth', 'preference');
model.result('pg2').feature('rtp1').set('expr', 'gop.phii');
model.result('pg2').feature('rtp1').set('xdata', 'expr');
model.result('pg2').feature('rtp1').set('xdataexpr', 'at(0,gop.phii)');
model.result('pg2').run;
model.result('pg2').set('titletype', 'none');
model.result('pg2').run;

model.title('Corner Cube Retroreflector');

model.description('A corner cube retroreflector can be used to reflect rays in a direction exactly antiparallel to their initial direction, regardless of the angle of incidence. This tutorial shows how to simulate the reflection of a bundle of rays at a corner cube retroreflector using the Geometrical Optics interface.');

model.mesh.clearMeshes;

model.sol('sol1').clearSolutionData;

model.label('corner_cube_retroreflector.mph');

model.modelNode.label('Components');

out = model;
```

---

