# COMSOL Few-Shot Examples (Detailed Analysis)

This file contains highly detailed model descriptions paired with complete MATLAB scripts for few-shot prompting with language models. Each description includes segment-by-segment analysis of the code.

**Total Examples:** 1

---

# Example 1: biased_resonator_3d_modes

**Module:** MEMS_Module_Actuators_biased_resonator_3d_modes  
**Category:** Unknown_Category  

## Model Description

# Model Overview

1. **Model Overview**: This COMSOL model simulates an electrostatically actuated MEMS resonator, specifically analyzing the deformation and normal mode shapes of the resonator under the influence of an applied DC bias voltage across a parallel plate capacitor.

2. **Engineering Application**: This model can be used to design and optimize MEMS resonators for applications such as sensors, actuators, and filters in microelectromechanical systems (MEMS). Understanding the behavior of the resonator under varying bias voltages is crucial for designing devices with desired performance characteristics.

3. **Key Physics**: The model involves the following physics interfaces and equations:
   - Solid Mechanics (solid): Governs the deformation of the resonator under electrostatic forces.
   - Electrostatics (es): Models the electric field and potential distribution in the device.
   - Electromechanical Forces (eme1): Couples the electrostatics and solid mechanics to compute the deformation due to electrostatic forces.

4. **Geometry Summary**: The geometric setup consists of a 3D resonator structure with layers of different materials (polysilicon, silicon nitride, and silicon oxide) and a ground plane. The resonator is enclosed by air domains on all sides.

5. **Analysis Type**: The model performs a stationary analysis to compute the deformation of the resonator under a given DC bias voltage. It also conducts an eigenfrequency analysis to determine the normal mode shapes and frequencies of the resonator at different bias voltages.

6. **Expected Outputs**: The model produces the following results:
   - Displacement field of the resonator under applied bias voltage.
   - Electric potential distribution in the device.
   - Normal mode shapes and frequencies of the resonator at different bias voltages.
   - Comparison of the computed resonant frequencies with experimental data.

These outputs provide valuable insights into the behavior of the MEMS resonator and can be used to optimize its design for specific applications.

# Detailed Code Analysis

The MATLAB script is organized into 36 functional segments:

## Segment 1: Unknown (Lines 1-9)

1. **Purpose**: This code segment appears to be the initialization part of a COMSOL model named "biased_resonator_3d_modes" which is likely simulating the behavior of a biased resonator in a 3D space. The purpose of this segment is to set up the environment for the model, including importing necessary Java packages from COMSOL to interact with the model and utilize its functionalities.

2. **Step-by-Step Analysis**:

   - `function out = model`: This line declares a MATLAB function named `model`, which is expected to return a variable `out`. In the context of COMSOL, this function is likely the main entry point for defining and running the simulation model.

   - The following lines are comments providing metadata about the model:
     - `% biased_resonator_3d_modes.m`: Indicates the name of the MATLAB file.
     - `% Model exported on May 26 2025, 21:30 by COMSOL 6.2.0.339.`: Provides information about when the model was exported and the version of COMSOL used.

   - `import com.comsol.model.*`: This line imports all classes from the `com.comsol.model` package. This package likely contains the core functionality to create and manipulate COMSOL models within MATLAB.

   - `import com.comsol.model.util.*`: Similarly, this line imports all classes from the `com.comsol.model.util` package. This package may contain utility classes and functions that facilitate working with COMSOL models, such as helper functions for common tasks.

3. **COMSOL Context**: The imported packages `com.comsol.model` and `com.comsol.model.util` are specific to COMSOL and provide the necessary tools to build and interact with COMSOL models from within MATLAB. These packages are essential for creating the geometry, setting up physics, meshing, solving, and post-processing the results of the simulation.

4. **Physical Meaning**: This code segment does not directly represent any physical aspect of the simulation. Instead, it sets up the MATLAB environment to interact with COMSOL for defining and running a simulation of a biased resonator in 3D. The physical meaning will be defined in subsequent parts of the model where the geometry, physics, and material properties are set up.

5. **Dependencies**: This segment is the foundation for the rest of the model definition. It sets up the necessary environment for other parts of the model to build upon. Following this segment, one would expect to find code that defines the geometry of the resonator, sets up the necessary physics (such as structural mechanics, electrostatics, etc.), defines material properties, sets up boundary conditions, mesh settings, solver settings, and post-processing for extracting and visualizing the results. Each of these parts will depend on the environment set up by this initialization segment to function correctly.

## Segment 2: Model Creation (Lines 10-16)

### Purpose

This code segment is responsible for initializing a new COMSOL model, setting up the model path, creating a component, and initializing the geometry for a MEMS module named "Actuators_biased_resonator_3d_modes". This is a foundational step in creating a simulation that likely aims to analyze the behavior of a biased resonator in a three-dimensional space, which is common in microelectromechanical systems (MEMS) for applications like sensors or actuators.

### Step-by-Step Analysis

#### Line 1: `model = ModelUtil.create('Model');`
- **Command**: `ModelUtil.create`
- **Purpose**: This line creates a new COMSOL model using the `ModelUtil` utility class. The string parameter `'Model'` specifies that a new model is being created.
- **Contribution**: This is the first step in setting up a simulation environment. It initializes a blank model where components, physics, and meshes can be added.

#### Line 2: `model.modelPath('/Applications/COMSOL62/Multiphysics/applications/MEMS_Module/Actuators');`
- **Command**: `modelPath`
- **Parameters**: `'/Applications/COMSOL62/Multiphysics/applications/MEMS_Module/Actuators'`
- **Purpose**: Sets the path where the model is stored or where it references external files. This path suggests that the model is part of a larger MEMS module focused on actuators.
- **Contribution**: This line ensures that the model can access necessary resources and is saved in the correct directory structure, which is crucial for managing complex simulations and ensuring that dependent files are accessible.

#### Line 3: `model.modelNode.create('comp1', true);`
- **Command**: `modelNode.create`
- **Parameters**: `'comp1'`, `true`
- **Purpose**: Creates a new component named `'comp1'` within the model. The boolean parameter `true` indicates that this component is to be created in a "build" mode, which allows for the construction of geometry.
- **Contribution**: This step is essential for organizing the model into manageable parts. Components can contain different geometries, physics settings, and meshes, allowing for a modular approach to simulation setup.

#### Line 4: `model.geom.create('geom1', 3);`
- **Command**: `geom.create`
- **Parameters**: `'geom1'`, `3`
- **Purpose**: Initializes a new geometry named `'geom1'` within the component `comp1`. The second parameter, `3`, specifies that this geometry is three-dimensional.
- **Contribution**: This line sets the stage for defining the physical shapes and domains where the simulation will take place. Three-dimensional geometries are necessary for modeling complex MEMS devices that have structures or phenomena occurring in 3D space.

### COMSOL Context

- **ModelUtil.create**: A utility function provided by COMSOL to create new models programmatically.
- **modelPath**: A property of the model that defines the directory path for the model file and associated resources.
- **modelNode.create**: A method to create a new component (or "model node") within the model, which is a fundamental part of structuring COMSOL simulations.
- **geom.create**: A method to initialize a new geometry within a component, specifying its name and dimensionality (2D or 3D).

### Physical Meaning

This code sets up the computational framework for simulating a biased resonator's behavior in a three-dimensional space. The "biased" term suggests that there might be an external force or field applied to the resonator, affecting its modal analysis. The physical representation could involve complex shapes and materials, with the goal of understanding how the resonator vibrates or responds to certain stimuli.

### Dependencies

This segment is foundational and sets the stage for further detailed work in defining the geometry, specifying materials, applying physics conditions, meshing, solving, and post-processing the results. Subsequent code would likely involve adding specific geometric shapes to `geom1`, defining material properties, setting up the physics of the simulation (like structural mechanics or electromechanics for the resonator behavior), and configuring solvers. This initial setup is crucial because it establishes the framework within which all other model specifications will be placed.

## Segment 3: Geometry (Lines 17-21)

### Purpose

This code segment is part of a larger COMSOL Multiphysics model setup for simulating a biased resonator's 3D modes, likely within the context of microelectromechanical systems (MEMS). Specifically, it initializes the geometry, mesh, and physics settings for the model named "biased_resonator_3d_modes" within the "MEMS_Module_Actuators_biased_resonator_3d_modes" module. The segment focuses on defining the geometry, creating a mesh for it, and setting up the solid mechanics physics interface to analyze the mechanical behavior of the resonator under certain biases or loads.

### Step-by-Step Analysis

#### Line 1: `model.geom('geom1').model('comp1');`

- **Command Explanation**: This line selects the geometry named 'geom1' within the current model and specifies that subsequent operations will be applied within the context of this geometry. The `model('comp1')` part suggests a selection of a component within the geometry, possibly to limit the scope of following operations to a specific part of the model.
- **Purpose**: Setting the stage for defining the geometry that will be meshed and analyzed. It ensures that any further commands are applied to the correct geometric component.

#### Line 2: `model.mesh.create('mesh1', 'geom1');`

- **Command Explanation**: This line creates a mesh object named 'mesh1' based on the geometry 'geom1'. Meshing is a critical step in finite element analysis (FEA) as it discretizes the geometry into smaller, simpler elements that the solver can handle.
- **Parameters**: 'mesh1' is the name of the mesh object, and 'geom1' specifies the geometry to be meshed.
- **Purpose**: Preparing the geometry for analysis by dividing it into a finite number of elements. The mesh quality and element size can significantly affect the accuracy and computational cost of the simulation.

#### Line 3: `model.physics.create('solid', 'SolidMechanics', 'geom1');`

- **Command Explanation**: This line creates a physics interface named 'solid' of the type 'SolidMechanics' within the geometry 'geom1'. The SolidMechanics interface is used for structural mechanics analysis, which is suitable for studying the deformation, stress, and modal characteristics of solid structures.
- **Parameters**: 'solid' is the name given to the physics interface, 'SolidMechanics' specifies the type of analysis, and 'geom1' indicates the geometry where this physics interface is applied.
- **Purpose**: Setting up the physics of the problem to be solved, in this case, the mechanical behavior of the biased resonator. This includes defining the equations governing the system's behavior, material properties, boundary conditions, and loads.

### COMSOL Context

In COMSOL Multiphysics, the `.geom()` function is used to access geometry objects, while `.mesh.create()` is a method for generating a mesh based on a given geometry. The `.physics.create()` method is used to set up the physics interfaces that define the type of analysis to be performed on the model, such as structural mechanics, fluid dynamics, or electromagnetics.

### Physical Meaning

This code segment sets the foundation for simulating the mechanical behavior of a biased resonator in a 3D space. The geometry represents the physical structure of the resonator, the mesh discretizes this structure into elements that can be computationally analyzed, and the physics interface defines the mathematical and physical laws governing the resonator's behavior under various conditions, such as external forces, constraints, and material properties.

### Dependencies

This segment is foundational and sets the stage for further definitions and configurations, such as material properties, boundary conditions, loads, and solver settings. The choices made here (e.g., mesh size, physics interface settings) will influence the accuracy and computational efficiency of the subsequent analysis steps. Additionally, this segment depends on prior definitions of the geometry 'geom1' and possibly the component 'comp1'. Following segments would likely involve specifying materials, applying boundary conditions, setting up studies (e.g., stationary, eigenfrequency), and defining solver settings.

## Segment 4: Physics (Lines 22-38)

This COMSOL MATLAB code segment is setting up a multiphysics model that combines solid mechanics with electrostatics to simulate an electromechanical problem, likely within a biased resonator in a 3D geometry. Let's break down the code segment in detail:

1. **Purpose**: The code is setting up a model to analyze the interaction between structural mechanics and electrostatic forces, typically to study phenomena such as electrostatic actuation or sensing in MEMS devices.

2. **Step-by-Step Analysis**:

   - `model.physics('solid').model('comp1');`
     This line selects the solid mechanics physics interface for the first component (`comp1`) of the model. It is preparing to set up the structural part of the simulation.

   - `model.physics.create('es', 'Electrostatics', 'geom1');`
     Here, an electrostatics physics interface named `es` is created and associated with the first geometry (`geom1`). This will be used to model the electric field and charge distribution.

   - `model.physics('es').model('comp1');`
     This line associates the electrostatics physics interface with the first component (`comp1`), similar to what was done with the solid mechanics interface.

   - `model.physics('es').feature('ccn1').set('materialType', {'solid'});`
     The charge conservation feature (`ccn1`) within the electrostatics physics interface is set to use a solid material type. This is important for defining how the electrostatic fields interact with the material.

   - `model.physics('es').feature('ccn1').label('Charge Conservation, Solid');`
     A label is applied to the charge conservation feature for clarity in the model.

   - `model.multiphysics.create('eme1', 'ElectromechanicalForces', 'geom1', 3);`
     A multiphysics interface named `eme1` is created to couple the electrostatics and solid mechanics physics interfaces. The `3` likely refers to the dimensionality of the problem (3D).

   - `model.multiphysics('eme1').set('Solid_physics', 'solid');`
     The solid mechanics physics interface is linked to the multiphysics interface.

   - `model.multiphysics('eme1').set('Electrostatics_physics', 'es');`
     The electrostatics physics interface is linked to the multiphysics interface.

   - `model.common.create('free1', 'DeformingDomain', 'comp1');`
     A domain for deforming geometry (mesh) is created, which is necessary for simulations where the domain changes shape due to applied forces or other effects.

   - `model.common('free1').set('smoothingType', 'hyperelastic');`
     The smoothing type for the deforming domain is set to 'hyperelastic', which is a method to handle large deformations in the material.

   - `model.common('free1').selection.set([]);`
     No specific selection is set for the deforming domain, implying that the entire component will be considered for deformation.

   - `model.common.create('sym1', 'Symmetry', 'comp1');`
     A symmetry condition is created, which can be used to reduce the size of the problem by exploiting geometric symmetries.

   - `model.common('sym1').selection.set([]);`
     No specific selection is set for the symmetry condition, which means the entire component will be considered for symmetry.

   - `model.study.create('std1');`
     A study named `std1` is created, which will be used to define the type of analysis (e.g., stationary, time-dependent, eigenvalue, etc.) and to run the simulation.

3. **COMSOL Context**: The code uses COMSOL's MATLAB API to create and configure the physics interfaces, multiphysics couplings, and study settings. The naming conventions (`'solid'`, `'es'`, `'eme1'`, `'ccn1'`, etc.) are specific to COMSOL and are used to reference different parts of the model.

4. **Physical Meaning**: This code sets up a simulation environment where the mechanical stress-strain behavior of a solid structure is coupled with the electrostatic forces acting on it. This could represent a scenario where an electric field is applied to a deformable structure, causing it to actuate or resonate.

5. **Dependencies**: This code segment depends on the prior definition of the geometry (`geom1`) and the material properties associated with the component (`comp1`). It also sets the stage for further configuration, such as boundary conditions, mesh settings, and solver settings, which are necessary to run the simulation. Additionally, the study settings will determine the type of analysis performed and how the results are computed and visualized.

This detailed explanation should provide a COMSOL expert with a clear understanding of the code segment's implementation and its role in setting up a multiphysics simulation involving solid mechanics and electrostatics.

## Segment 5: Study (Lines 39-43)

**Purpose**: This code segment is creating a stationary study in COMSOL, which is used to solve for the stationary (time-independent) solution of the model. It is setting up the study to solve for the solid mechanics, electrostatics, and multiphysics interface equations. This is typically done to find the equilibrium state of the system under the given loads and constraints.

**Step-by-Step Analysis**:

1. `model.study('std1').create('stat', 'Stationary');`
   - This line creates a new study named 'stat' of type 'Stationary' within the 'std1' study. A stationary study is used for solving the model at a single point in time, without considering time-dependent effects. This is useful for finding steady-state solutions.

2. `model.study('std1').feature('stat').setSolveFor('/physics/solid', true);`
   - This line configures the 'stat' study to solve for the solid mechanics physics interface. The '/physics/solid' parameter specifies the solid mechanics physics interface, and setting it to 'true' indicates that this interface should be included in the solution process. This is necessary for analyzing the structural behavior of the model.

3. `model.study('std1').feature('stat').setSolveFor('/physics/es', true);`
   - This line sets the 'stat' study to solve for the electrostatics physics interface. The '/physics/es' parameter specifies the electrostatics interface, and setting it to 'true' includes it in the solution. This is required for analyzing the electric field and potential distribution within the model.

4. `model.study('std1').feature('stat').setSolveFor('/multiphysics/eme1', true);`
   - This line configures the 'stat' study to solve for the multiphysics interface 'eme1'. The '/multiphysics/eme1' parameter specifies the multiphysics interface, which may couple the solid mechanics and electrostatics physics. Setting it to 'true' includes this interface in the solution process, allowing for the analysis of coupled electromechanical effects.

**COMSOL Context**: These commands are specific to the COMSOL Multiphysics software and are used to set up and configure studies within a model. The `model.study()` function is used to access and manipulate studies, while the `feature()` function is used to access and configure specific features within a study. The `setSolveFor()` function is used to specify which physics interfaces should be included in the solution process.

**Physical Meaning**: This code segment represents the setup of a stationary study to analyze the coupled electromechanical behavior of a biased resonator in a 3D model. The solid mechanics physics interface is used to model the structural behavior of the resonator, while the electrostatics physics interface is used to model the electric field and potential distribution. The multiphysics interface couples these two physics together, allowing for the analysis of the interaction between the mechanical and electrical aspects of the system.

**Dependencies**: This code segment is likely dependent on other parts of the model, such as the geometry, mesh, materials, and boundary conditions. The solid mechanics and electrostatics physics interfaces may require specific material properties and boundary conditions to be defined. Additionally, the multiphysics interface may depend on the coupling between the solid mechanics and electrostatics physics. The results of this stationary study may also be used as input for other studies or analyses within the model.

## Segment 6: Geometry (Lines 44-50)

### Purpose

This code segment is designed to set up the geometry and initial parameters for a COMSOL model named `biased_resonator_3d_modes`, which is part of the `MEMS_Module_Actuators_biased_resonator_3d_modes` module. The code imports a predefined geometry, sets a specific DC bias voltage, and creates a selection for further use in the model.

### Step-by-Step Analysis

#### Line 1
```matlab
model.geom('geom1').insertFile('biased_resonator_3d_geom_sequence.mph', 'geom1');
```
- **Command**: `insertFile`
- **Function**: This line imports a geometry from an external COMSOL file named `biased_resonator_3d_geom_sequence.mph` into the current geometry sequence named `geom1`.
- **Purpose**: It is used to include a predefined geometry that represents the physical structure of the biased resonator, which is essential for the 3D simulation of the modes.

#### Line 2
```matlab
model.geom('geom1').run('sel2');
```
- **Command**: `run`
- **Function**: Executes a geometry sequence operation named `sel2`, which is likely a predefined selection or operation within the geometry sequence `geom1`.
- **Purpose**: This could be used to select specific domains, boundaries, or features of the geometry for further operations, such as meshing or applying boundary conditions.

#### Line 3
```matlab
model.param.set('Vdc', '35[V]');
```
- **Command**: `set`
- **Function**: Sets the value of a model parameter named `Vdc` to `35[V]`, which represents a DC bias voltage.
- **Purpose**: This parameter is crucial for defining the electrostatic conditions under which the resonator will operate. The DC bias voltage influences the electrostatic forces and, consequently, the resonance behavior of the structure.

#### Line 4
```matlab
model.param.descr('Vdc', 'DC bias voltage');
```
- **Command**: `descr`
- **Function**: Adds a description to the parameter `Vdc`, labeling it as 'DC bias voltage'.
- **Purpose**: This enhances the readability and maintainability of the model by providing clear documentation of what the parameter represents.

#### Line 5
```matlab
model.selection.create('sel1', 'Explicit');
```
- **Command**: `create`
- **Function**: Creates a new selection named `sel1` with the type 'Explicit'.
- **Purpose**: This selection can be used to group specific geometric entities (like domains or boundaries) for applying conditions, materials, or mesh settings. The 'Explicit' type suggests that the entities will be manually selected rather than automatically based on some criteria.

### COMSOL Context

- **Geometry Import**: The `insertFile` command is a COMSOL-specific function used to import geometries from external files, which is crucial for reusing and modularizing geometry setups.
- **Parameter Setup**: The `param.set` and `param.descr` commands are used to define and describe model parameters, which are fundamental in COMSOL for setting up conditions that can be varied or optimized.
- **Selections**: The `selection.create` command is used to define groups of geometric entities for applying conditions or settings, which is a common practice in COMSOL for managing complex models.

### Physical Meaning

This code segment sets up the initial conditions for simulating a biased resonator's modes in a 3D space. The DC bias voltage is a critical parameter that affects the resonator's behavior, as it determines the electrostatic forces acting on the structure. The imported geometry represents the physical layout of the resonator, which is necessary for the simulation to accurately model the real-world device.

### Dependencies

This segment is foundational for the subsequent steps in setting up the COMSOL model, including defining the physics, meshing, solving, and post-processing. The geometry and parameters set here will be used throughout the model to define the material properties, apply boundary conditions, and set up the equations governing the resonator's behavior. The selections created here may also be used in later stages to apply specific settings or conditions to parts of the geometry.

## Segment 7: Selection (Lines 51-147)

This COMSOL MATLAB code segment is part of a larger model that simulates a biased resonator in a 3D environment. The segment is focused on creating selections within the model, which are used to define different domains and boundaries for the simulation. These selections will later be associated with different materials, physics settings, and meshing properties. The code is written in the COMSOL scripting language, which is based on MATLAB syntax.

### Purpose

The purpose of this code segment is to define geometric entities (domains and boundaries) of the biased resonator model. These entities will be used to assign material properties, apply boundary conditions, and define the mesh for the finite element analysis. The specific entities created include the ground plane, oxide layer, nitride layer, electrode, resonator, air domain, and various boundary selections for the resonator, electrode, nitride, and the exterior of the geometry.

### Step-by-Step Analysis

1. **Create All Domains Selection (`sel1`)**:
   - `model.selection('sel1').model('comp1');`
   - `model.selection('sel1').all;`
   - `model.selection('sel1').label('All domains');`
   - This block creates a selection named `sel1` that includes all domains in the model component `comp1`. It is labeled "All domains" for clarity.

2. **Create Ground Plane Selection (`box1`)**:
   - `model.selection.create('box1', 'Box');`
   - `model.selection('box1').model('comp1');`
   - `model.selection('box1').set('zmin', -2);`
   - `model.selection('box1').set('zmax', -1);`
   - `model.selection('box1').set('condition', 'inside');`
   - `model.selection('box1').set('entitydim', 2);`
   - `model.selection('box1').label('Ground Plane');`
   - This block creates a box selection for the ground plane, specifying its dimensions and that it should include only faces (`entitydim`, 2).

3. **Create Oxide Layer Selection (`box2`)**:
   - Similar to the ground plane, but with different `zmin` and `zmax` values to define the oxide layer's position.

4. **Create Nitride Layer Selection (`box3`)**:
   - Similar to the previous boxes, defining the nitride layer's position.

5. **Create Electrode Selection (`box4`)**:
   - This block defines the electrode's position and dimensions, which is smaller and located at a specific part of the z-axis.

6. **Create Ball Selection (`ball1`)**:
   - `model.selection.create('ball1', 'Ball');`
   - `model.selection('ball1').model('comp1');`
   - `model.selection('ball1').set('posz', 1);`
   - `model.selection('ball1').set('r', 0.1);`
   - This creates a spherical selection used later to form the resonator shape.

7. **Create Box Selection for Resonator (`box5`)**:
   - This defines a box that will be used to shape the resonator, with specific dimensions.

8. **Duplicate Box for Resonator (`box6`)**:
   - `model.selection.duplicate('box6', 'box5');`
   - `model.selection('box6').set('xmin', -15);`
   - `model.selection('box6').set('xmax', 15);`
   - This duplicates `box5` to create `box6`, modifying its x-dimensions for a subsequent operation.

9. **Create Resonator Shape (`dif1`)**:
   - `model.selection.create('dif1', 'Difference');`
   - `model.selection('dif1').model('comp1');`
   - `model.selection('dif1').set('add', {'ball1' 'box5'});`
   - `model.selection('dif1').set('subtract', {'box6'});`
   - `model.selection('dif1').label('Resonator');`
   - This creates the resonator's shape by taking the difference between the ball and two boxes, resulting in a complex 3D shape.

10. **Combine Electrode and Resonator (`uni1`)**:
    - `model.selection.create('uni1', 'Union');`
    - `model.selection('uni1').model('comp1');`
    - `model.selection('uni1').set('input', {'box4' 'dif1'});`
    - `model.selection('uni1').label('PolySi');`
    - This combines the electrode and resonator selections into a single entity, labeled "PolySi".

11. **Create Air Domain (`dif2`)**:
    - This block creates the air domain by subtracting the solid domains (oxide, nitride, and polysilicon) from the all domains selection.

12. **Create Boundary Selections (`adj1` to `int1`, `box7`)**:
    - These blocks create various boundary selections that will be used to apply boundary conditions or to define specific meshing properties. Each `Adjacent` selection is used to identify boundaries between different domains.

13. **Create Material (`mat1`)**:
    - `model.material.create('mat1', 'Common', 'comp1');`
    - This line initializes a material named `mat1` that can be assigned to the domains created earlier.

### COMSOL Context

- **Selections**: COMSOL uses selections to group geometric entities for assigning properties or conditions. These can be boxes, balls, or more complex shapes created through boolean operations like Union, Difference, and Intersection.
- **Entities**: COMSOL refers to geometric objects as entities, which can be points (0D), lines (1D), surfaces (2D), or volumes (3D). The `entitydim` parameter specifies the dimension of the entity being selected.
- **Components**: The model is divided into components (`comp1`), which can represent different parts of the geometry or physics.

### Physical Meaning

This code segment is defining the geometry of a biased resonator, including its different material layers (ground plane, oxide, nitride) and functional parts (electrode, resonator). The resonator is designed to have a specific 3D shape that is partially defined by a spherical cap. The physical simulation will likely involve analyzing the resonator's behavior under certain conditions, such as its vibrational modes or response to electrical signals.

### Dependencies

This segment is foundational for the model, as the defined selections will be used in subsequent steps to:
- Assign material properties to different domains.
- Define physics settings, such as electrostatics or structural mechanics.
- Apply boundary conditions, such as fixed constraints or electrical potentials.
- Set up meshing parameters for the finite element analysis.

The material created at the end (`mat1`) will be associated with one or more of the selections, defining their physical properties for the simulation.

## Segment 8: Material (Lines 148-302)

### Purpose

This code segment is defining material properties for a COMSOL model named "biased_resonator_3d_modes" within the "MEMS_Module_Actuators_biased_resonator_3d_modes" module. It is setting up four different materials with specific properties relevant to their physical behavior in the simulation.

### Step-by-Step Analysis

#### Material 1 (mat1) - Polycrystalline Silicon
- **Line 1-2**: Creates a material named 'mat1' and a property group for Young's modulus and Poisson's ratio.
- **Line 3-4**: Sets the label and family for the material.
- **Line 5-7**: Defines the optical properties (specular, diffuse, and ambient) for rendering purposes.
- **Line 8-16**: Sets various rendering parameters such as noise, Fresnel, metallic, pearl, diffuse wrap, clearcoat, and reflectance.
- **Line 17-23**: Defines thermal expansion coefficients, heat capacity, relative permittivity, density, and thermal conductivity.
- **Line 24-25**: Sets Young's modulus (E) and Poisson's ratio (nu).
- **Line 26-34**: Reiterates the material family and rendering settings.
- **Line 35-47**: Configures more rendering properties including ambient, diffuse, specular, noise, and alpha.

#### Material 2 (mat2) - Silicon Nitride
- **Line 48-50**: Creates 'mat2' and sets its property group for Young's modulus and Poisson's ratio.
- **Line 51-58**: Defines various properties such as electric conductivity, thermal expansion coefficients, heat capacity, relative permittivity, density, and thermal conductivity.
- **Line 59-60**: Sets Young's modulus and Poisson's ratio.
- **Line 61**: Sets the material family.

#### Material 3 (mat3) - Silicon Oxide
- **Line 62-64**: Creates 'mat3' and sets its property group for Young's modulus and Poisson's ratio.
- **Line 65-72**: Similar to mat2, defines electric conductivity, thermal expansion coefficients, heat capacity, relative permittivity, density, and thermal conductivity.
- **Line 73-74**: Sets Young's modulus and Poisson's ratio.
- **Line 75**: Sets the material family.

#### Material 4 (mat4) - Air
- **Line 76-85**: Creates 'mat4' and sets up several functional dependencies for properties such as dynamic viscosity, heat capacity, density, and thermal conductivity.
- **Line 86-104**: Sets up additional functions for sound speed, thermal expansion coefficients, and bulk viscosity.
- **Line 105-119**: Configures material properties such as thermal expansion coefficient, molar mass, bulk viscosity, relative permeability and permittivity, dynamic viscosity, ratio of specific heats, electric conductivity, heat capacity, density, and thermal conductivity.
- **Line 120-121**: Sets the material to be a non-solid type and assigns the family as 'air'.
- **Line 122-125**: Assigns selections to the materials for application in the model geometry.

### COMSOL Context

- **Material Creation**: The `model.material.create()` function is used to define new materials.
- **Property Groups**: Property groups such as 'Enu' for Young's modulus and Poisson's ratio are created using `propertyGroup.create()`.
- **Setting Properties**: Material properties are set using the `set()` function, and functional dependencies are defined using `func.create()` with specific arguments and units.
- **Selections**: The `selection.named()` function assigns selections to the materials, which are used to apply these materials to specific domains or boundaries in the geometry.

### Physical Meaning

This code segment is setting up the mechanical, thermal, and optical properties of the materials used in the simulation. These properties are essential for accurately modeling the behavior of the materials under various physical conditions, such as mechanical stress, heat transfer, and electromagnetic wave propagation.

### Dependencies

This segment is likely dependent on other parts of the model, such as the geometry definitions, mesh settings, and physics definitions. The materials defined here would be applied to different domains or boundaries within the geometry, and their properties would influence the solutions of the physics equations set up in the model. Additionally, the functional dependencies defined for 'mat4' (Air) suggest that this material's properties may change with temperature and pressure, which could be influenced by other physics settings in the model, such as fluid dynamics or heat transfer.

## Segment 9: Physics (Lines 303-325)

### Purpose

This code segment is setting up a physics model for a biased resonator in a 3D environment using COMSOL's MEMS module. It defines constraints, symmetry conditions, charge conservation, and terminal conditions for the simulation of the resonator's behavior.

### Step-by-Step Analysis

1. `model.physics('solid').selection.named('dif1');`
   - This line selects a domain named 'dif1' for the solid mechanics physics interface. It is likely preparing to apply a specific condition to this domain.

2. `model.physics('solid').create('fix1', 'Fixed', 2);`
   - Creates a fixed constraint named 'fix1' in the solid mechanics physics interface. The '2' indicates that it's applied to boundaries.

3. `model.physics('solid').feature('fix1').selection.named('int1');`
   - Applies the fixed constraint 'fix1' to a boundary selection named 'int1'. This typically means that the selected boundaries are fixed in place with no displacement.

4. `model.physics('solid').create('sym1', 'SymmetrySolid', 2);`
   - Creates a symmetry condition named 'sym1' for the solid mechanics physics interface, applied to boundaries (indicated by '2'). This is used to reduce the model size by exploiting symmetry.

5. `model.physics('solid').feature('sym1').selection.named('box7');`
   - Applies the symmetry condition 'sym1' to a boundary selection named 'box7'.

6. `model.common('free1').selection.named('dif2');`
   - Selects a domain named 'dif2' for a common feature possibly related to a free boundary condition or similar.

7. `model.common('sym1').selection.named('box7');`
   - Applies the symmetry condition 'sym1' to a selection named 'box7' for a common feature, likely related to the previous line.

8. `model.physics('es').create('ccn2', 'ChargeConservation', 3);`
   - Creates a charge conservation feature named 'ccn2' within the electrostatics physics interface, applied to domains (indicated by '3').

9. `model.physics('es').feature('ccn2').label('Charge Conservation, Air');`
   - Labels the 'ccn2' feature as 'Charge Conservation, Air' for clarity in the model.

10. `model.physics('es').feature('ccn2').selection.named('dif2');`
    - Applies the charge conservation feature 'ccn2' to the domain selection named 'dif2'.

11. `model.physics('es').create('term1', 'DomainTerminal', 3);`
    - Creates a domain terminal named 'term1' within the electrostatics physics interface, applied to domains.

12. `model.physics('es').feature('term1').selection.named('dif1');`
    - Applies the domain terminal 'term1' to the domain selection named 'dif1'.

13. `model.physics('es').feature('term1').set('TerminalType', 'Voltage');`
    - Sets the terminal type of 'term1' to 'Voltage', indicating that this terminal will apply a voltage.

14. `model.physics('es').feature('term1').set('V0', 0);`
    - Sets the voltage of terminal 'term1' to 0, effectively grounding this terminal.

15. `model.physics('es').create('gnd1', 'Ground', 2);`
    - Creates a ground feature named 'gnd1' in the electrostatics physics interface, applied to boundaries.

16. `model.physics('es').feature('gnd1').selection.named('box1');`
    - Applies the ground feature 'gnd1' to the boundary selection named 'box1'.

17. `model.physics('es').create('term2', 'DomainTerminal', 3);`
    - Creates another domain terminal named 'term2' within the electrostatics physics interface, applied to domains.

18. `model.physics('es').feature('term2').selection.named('geom1_boxsel4');`
    - Applies the domain terminal 'term2' to the domain selection named 'geom1_boxsel4'.

19. `model.physics('es').feature('term2').set('TerminalType', 'Voltage');`
    - Sets the terminal type of 'term2' to 'Voltage'.

20. `model.physics('es').feature('term2').set('V0', 'Vdc');`
    - Sets the voltage of terminal 'term2' to a variable 'Vdc', which represents a DC voltage bias.

### COMSOL Context

- The code uses COMSOL's MATLAB API to set up the physics of the model.
- The `model.physics` command is used to access different physics interfaces ('solid' for solid mechanics, 'es' for electrostatics).
- Features like 'Fixed', 'SymmetrySolid', 'ChargeConservation', 'DomainTerminal', and 'Ground' are predefined features in COMSOL that are applied to specific selections of the geometry.
- The `selection.named` method is used to apply physics settings to specific geometric entities.

### Physical Meaning

- The solid mechanics constraints simulate the structural behavior of the resonator, including fixed boundaries and symmetry to reduce computational complexity.
- The electrostatics settings simulate the electric field and charge distribution within the resonator, with terminals applying voltages and a ground condition.

### Dependencies

- This code segment depends on the geometry of the model, specifically the named selections 'dif1', 'int1', 'box7', 'dif2', 'box1', and 'geom1_boxsel4'.
- The 'Vdc' variable used for the voltage of 'term2' is expected to be defined elsewhere in the model, possibly as part of the study settings or as input parameters.
- The physics settings here would also be related to the meshing of the model, as the constraints and conditions need to be applied to the discretized geometry.
- The results from this physics setup would be used in post-processing to analyze the resonator's behavior, such as displacement, stress, and electric potential distributions.

## Segment 10: Mesh (Lines 326-331)

This COMSOL MATLAB code segment is responsible for creating and executing a meshing sequence for a model named "biased_resonator_3d_modes" within the "MEMS_Module_Actuators_biased_resonator_3d_modes" module. Meshing is a critical step in finite element analysis (FEA) that involves dividing the model geometry into small, simple shapes called elements. The quality of the mesh can significantly influence the accuracy and computational efficiency of the simulation. Let's dissect this code segment in detail:

### Purpose
The purpose of this code segment is to generate a mesh for the 3D geometry of a biased resonator model. It defines the type of mesh elements to use, selects the geometry to mesh, and executes the meshing operations.

### Step-by-Step Analysis

1. **Create Free Triangular Mesh Feature**
   ```matlab
   model.mesh('mesh1').create('ftri1', 'FreeTri');
   ```
   This line creates a new mesh feature named 'ftri1' of type 'FreeTri' (Free Triangular) within the mesh object 'mesh1'. The 'FreeTri' type indicates that the mesh will consist of triangular elements, which are suitable for complex geometries. This is a common choice for 3D models where tetrahedral elements are desirable.

2. **Select Geometry for Meshing**
   ```matlab
   model.mesh('mesh1').feature('ftri1').selection.named('geom1_sel2');
   ```
   Here, the code specifies the geometry selection for the meshing operation. The selection is named 'geom1_sel2', which likely corresponds to a predefined selection of the geometry within the COMSOL model. This selection could include specific domains or boundaries where the meshing should be applied.

3. **Execute Free Triangular Meshing**
   ```matlab
   model.mesh('mesh1').run('ftri1');
   ```
   This command executes the meshing operation defined by the 'ftri1' feature. It generates the actual mesh elements based on the specified settings and the selected geometry. Running this feature populates the model with the triangular mesh, which is a prerequisite for further analysis steps like solving for the physics of the model.

4. **Create Sweep Mesh Feature**
   ```matlab
   model.mesh('mesh1').create('swe1', 'Sweep');
   ```
   A new mesh feature named 'swe1' of type 'Sweep' is created within the same mesh object 'mesh1'. The 'Sweep' type is typically used to generate a structured mesh along a specific direction, often used in conjunction with other meshing techniques to improve mesh quality or to mesh volumes that are bounded by surfaces that have already been meshed.

5. **Execute Sweep Meshing**
   ```matlab
   model.mesh('mesh1').run('swe1');
   ```
   Similar to the previous run command, this line executes the 'swe1' mesh feature, applying the sweep meshing operation. This could be used to mesh additional volumes or to refine the mesh in specific regions based on the initial triangular mesh.

### COMSOL Context
In the context of COMSOL, this code segment uses the COMSOL MATLAB API to interact with the meshing module of the software. The commands `create`, `feature`, `selection`, and `run` are part of the COMSOL scripting language, which allows for the automation and customization of the modeling process.

### Physical Meaning
Physically, this code segment represents the discretization of the continuous 3D space of the biased resonator into a finite number of elements. This process is essential for transforming the continuous partial differential equations (PDEs) that describe the physics of the problem into a set of algebraic equations that can be solved numerically.

### Dependencies
This meshing sequence is likely dependent on previous definitions in the model setup, such as the geometry, material properties, and the physics being simulated. The meshing commands here are also in preparation for the subsequent steps in the modeling workflow, such as setting up boundary conditions, solving the model, and post-processing the results. The quality and settings of the mesh can significantly impact the solution's accuracy and the computational resources required.

In summary, this code segment is a critical part of the simulation setup, ensuring that the geometry is appropriately discretized for the numerical solution of the physics at hand. The specific choices of meshing techniques and settings would be informed by the geometry's complexity and the expected behavior of the physical phenomena being modeled.

## Segment 11: Study (Lines 332-335)

This COMSOL MATLAB code segment is part of a larger model that simulates the behavior of a biased resonator in a 3D space. The specific segment you've provided is related to setting up a study and a solution sequence for the model named "biased_resonator_3d_modes". Let's break down the code segment in detail:

### Purpose
The purpose of this code segment is to define a stationary study and create a solution sequence for the model. In COMSOL, a study is a configuration that defines how to solve the model, including the type of analysis (e.g., stationary, time-dependent, eigenvalue), while a solution sequence is a set of instructions on how to compute the solution.

### Step-by-Step Analysis

#### Line 332: `model.study('std1').label('Stationary');`
- **Command**: `model.study('std1')` selects the study with the identifier 'std1'.
- **Parameters**: 'std1' is the identifier for the study. This is likely the default identifier for the first study created in the model.
- **Configuration**: `.label('Stationary')` sets the label of the study to 'Stationary'. This indicates that the study is set up for a stationary (steady-state) analysis, meaning it will solve for the model's behavior at a single point in time, without considering time-dependent effects.
- **Contribution to Modeling Goal**: This line sets up the foundation for a steady-state analysis of the biased resonator, which is essential for understanding its behavior under constant conditions.

#### Line 333: `model.sol.create('sol1');`
- **Command**: `model.sol.create('sol1')` creates a new solution sequence with the identifier 'sol1'.
- **Parameters**: 'sol1' is the identifier for the solution sequence. This is likely the default identifier for the first solution sequence created in the study.
- **Configuration**: This line does not explicitly set any parameters for the solution sequence but initializes it for further configuration.
- **Contribution to Modeling Goal**: Creating a solution sequence is necessary to define how COMSOL will solve the model, including settings for solvers, meshing, and post-processing. This is a crucial step in setting up the simulation.

### COMSOL Context
- **Study**: In COMSOL, a study is a container for settings that define the type of analysis to be performed on a model. Common study types include stationary, time-dependent, and eigenvalue analyses.
- **Solution Sequence**: A solution sequence is a set of steps that COMSOL follows to solve the model, including setting up solvers, meshing the geometry, and computing the solution. It is part of a study and is configured to solve for specific physics and boundary conditions.

### Physical Meaning
This code segment sets up a stationary study and a solution sequence for a model of a biased resonator in 3D. In the context of the physical simulation, this means that the model will be solved to find the steady-state response of the resonator to a constant bias, without considering transient effects. This could be used to analyze the resonant frequencies, mode shapes, and other steady-state characteristics of the resonator.

### Dependencies
This segment is foundational and sets the stage for further configuration of the study and solution sequence. It is likely that subsequent code will define the physics to be solved, mesh settings, solver settings, and post-processing settings. The effectiveness of this setup depends on the correct definition of the model's geometry, materials, and boundary conditions, which are typically defined earlier in the COMSOL script or model setup.

## Segment 12: Mesh (Lines 336-338)

This COMSOL MATLAB code segment is part of a larger model named "biased_resonator_3d_modes" within the module "MEMS_Module_Actuators_biased_resonator_3d_modes". The segment is categorized under the "mesh" type, indicating that it is related to the meshing process of the model. The specific lines of code under analysis are lines 336 to 338.

### Purpose
The purpose of this code segment is to select specific geometric entities within the model for meshing and to apply a specific meshing configuration to those entities. This is a crucial step in the finite element analysis process, as the mesh quality directly impacts the accuracy and computational efficiency of the simulation.

### Step-by-Step Analysis

#### Line 336: `model.mesh('mesh1').stat.selection.geom(3);`
- **Command**: `model.mesh('mesh1')` accesses the mesh settings of the model, specifically the mesh named 'mesh1'.
- **Parameters**: `.stat.selection.geom(3)` specifies that the selection is being made in a static (non-dynamic) context, and `.geom(3)` indicates that geometric entities of dimension 3 (3D volumes) are being selected.
- **Purpose**: This line prepares the mesh settings to operate on 3D geometric entities within the model.

#### Line 337: `model.mesh('mesh1').stat.selection.set([3 6 9 12 15 16 17 18 19 20 22 23 24 25 30 31 32 33 34 35 36]);`
- **Command**: `model.mesh('mesh1').stat.selection.set([...])` sets a specific selection of geometric entities for the meshing operation.
- **Parameters**: The array `[3 6 9 12 15 16 17 18 19 20 22 23 24 25 30 31 32 33 34 35 36]` lists the indices of the geometric entities to be selected. These indices correspond to specific volumes within the 3D geometry of the model.
- **Purpose**: This line specifies exactly which 3D volumes of the model will have the mesh settings applied to them. This selection allows for targeted meshing strategies, optimizing the simulation by applying finer or coarser meshes where necessary.

### COMSOL Context
In COMSOL, meshing is a critical step that discretizes the geometry into small elements, enabling the finite element method (FEM) to approximate the solution to the physical problem being modeled. The commands used in this segment are specific to configuring the mesh settings for selected geometric entities within the model.

### Physical Meaning
In the context of the physical simulation, this code segment is defining how the 3D space of the model will be discretized for analysis. By selecting specific volumes and applying mesh settings to them, the modeler is ensuring that the simulation will accurately capture the physical phenomena occurring within those regions.

### Dependencies
This segment is likely dependent on previous definitions of the geometry and the setup of the physical phenomena being simulated. The selection of specific geometric entities for meshing implies an understanding of the model's geometry and the areas where higher or lower mesh resolution is required. Additionally, the mesh settings applied here will directly impact the results of the simulation, influencing the accuracy of the solutions obtained for the physical phenomena being studied.

## Segment 13: Solver (Lines 339-340)

1. **Purpose**: This code segment is written in MATLAB and is used to interface with COMSOL Multiphysics, a finite element analysis software. The purpose of this code is to access a specific solution ('sol1') and study ('std1') within a COMSOL model named 'biased_resonator_3d_modes'. This allows the user to manipulate and analyze the solution and study settings for the model.

2. **Step-by-Step Analysis**:

   Line 339: `model.sol('sol1')`
   - This line of code is accessing a solution named 'sol1' within the COMSOL model. The `model` object represents the current COMSOL model, and the `sol` method is used to access a specific solution within that model. 'sol1' is likely the first or main solution in the model, which contains the results of the simulation.

   Line 340: `.study('std1')`
   - This line is a continuation of the previous line and is accessing a study named 'std1' within the 'sol1' solution. The `study` method is used to access a specific study within a solution. 'std1' is likely the first or main study in the solution, which contains the settings for the simulation, such as the physics being solved, mesh settings, and solver settings.

3. **COMSOL Context**: 
   - `model`: This is a MATLAB object that represents the current COMSOL model. It allows the user to access and manipulate various aspects of the model, such as geometry, physics, mesh, and solver settings.
   - `sol`: This is a method of the `model` object that is used to access a specific solution within the model. In COMSOL, a solution contains the results of a simulation, such as the computed field values, derived values, and postprocessing data.
   - `study`: This is a method of the `sol` object that is used to access a specific study within a solution. In COMSOL, a study contains the settings for a simulation, such as the physics being solved, mesh settings, and solver settings.

4. **Physical Meaning**: 
   - The physical meaning of this code segment is related to the specific COMSOL model being used. In this case, the model is named 'biased_resonator_3d_modes', which suggests that it is simulating the 3D modes of a biased resonator. A biased resonator is a device that resonates at a specific frequency and is biased by an external force or field. The 3D modes refer to the different vibrational modes that the resonator can exhibit in three dimensions.

5. **Dependencies**:
   - This code segment is dependent on the specific COMSOL model being used. The 'biased_resonator_3d_modes' model must be loaded and initialized in MATLAB before this code can be executed.
   - The code is also dependent on the existence of the 'sol1' solution and 'std1' study within the model. If these do not exist, the code will generate an error.
   - The results and settings accessed by this code segment are likely used in subsequent MATLAB code for further analysis and manipulation of the simulation data.

## Segment 14: Study (Lines 341-345)

This COMSOL MATLAB code segment is configuring the solution settings for a stationary study named 'std1' in a model called 'biased_resonator_3d_modes'. The study is likely part of a larger model simulating a biased resonator's 3D modes, possibly in the context of MEMS (Microelectromechanical Systems). Let's break down each line for a detailed understanding:

1. **Purpose**: The code segment is setting up the solution sequence and output for a stationary study within the COMSOL model. It determines how many solutions to compute and list in the study.

2. **Step-by-Step Analysis**:

   Line 1: `model.study('std1').feature('stat').set('notlistsolnum', 1);`
   - This line sets the 'notlistsolnum' property of the stationary solver ('stat') in study 'std1' to 1.
   - 'notlistsolnum' refers to the number of non-listed solutions to compute before listing a solution. Setting it to 1 means that for every listed solution, there will be one non-listed solution computed beforehand.
   - This configuration is useful for cases where intermediate solutions are not of interest, and only specific solution points are desired.

   Line 2: `model.study('std1').feature('stat').set('notsolnum', 'auto');`
   - Sets the 'notsolnum' property to 'auto', which tells COMSOL to automatically determine the number of non-listed solutions to compute.
   - COMSOL will use its default heuristic to decide how many non-listed solutions are needed for an efficient and accurate solution sequence.

   Line 3: `model.study('std1').feature('stat').set('listsolnum', 1);`
   - Configures the 'listsolnum' property to 1, indicating that every first solution (after the non-listed ones) will be listed.
   - This means that the solution sequence will include one listed solution after each non-listed solution computed based on the 'notlistsolnum' setting.

   Line 4: `model.study('std1').feature('stat').set('solnum', 'auto');`
   - Sets the 'solnum' property to 'auto', delegating to COMSOL the decision on the total number of solutions to compute.
   - COMSOL will determine an appropriate number of solutions based on the model's complexity and the solver's settings.

3. **COMSOL Context**: These commands are specific to configuring the solution sequence in a COMSOL study. The 'std1' refers to a predefined stationary study, and 'stat' is the identifier for the stationary solver within that study. The properties 'notlistsolnum', 'notsolnum', 'listsolnum', and 'solnum' are part of the solver settings that control the solution output and computation process.

4. **Physical Meaning**: In the context of a biased resonator's 3D modes simulation, these settings determine how the solver will approach finding the resonant frequencies and mode shapes. The solution sequence is crucial for accurately capturing the physical behavior of the resonator under the specified bias conditions.

5. **Dependencies**: This code segment is part of a larger modeling workflow and depends on the correct setup of the geometry, mesh, material properties, boundary conditions, and other physics settings in the 'biased_resonator_3d_modes' model. The solution sequence configured here will be used when solving the model, and the results will depend on the overall model configuration.

In summary, this code segment is an essential part of configuring the solver for a stationary study in a COMSOL model of a biased resonator. It sets up the solution sequence to efficiently compute and output the resonator's 3D modes, which are critical for understanding its physical behavior under bias conditions. The settings made here are interdependent with the rest of the model setup and will impact the accuracy and efficiency of the simulation results.

## Segment 15: Solver (Lines 346-400)

### Purpose

This COMSOL MATLAB code segment is setting up a solver for a stationary study in a model named `biased_resonator_3d_modes`. The solver configuration includes setting up variables, segregated steps for solving different physics such as electric potential and displacement field, and configuring iterative and direct solvers. The code also sets up a plot group for 3D visualization of the results.

### Step-by-Step Analysis

1. `model.sol('sol1').create('st1', 'StudyStep');`
   - Creates a study step named `st1` in the solution sequence `sol1`.

2. `model.sol('sol1').feature('st1').set('study', 'std1');`
   - Sets the study type of `st1` to `std1`, which is likely a stationary study.

3. `model.sol('sol1').feature('st1').set('studystep', 'stat');`
   - Sets the study step type to `stat`, indicating a stationary analysis.

4. `model.sol('sol1').create('v1', 'Variables');`
   - Creates a variables feature `v1` for defining the scale of variables.

5. `model.sol('sol1').feature('v1').feature('comp1_spatial_disp').set('scalemethod', 'manual');`
   - Sets the scaling method for the spatial displacement variable to manual.

6. `model.sol('sol1').feature('v1').feature('comp1_u').set('scalemethod', 'manual');`
   - Sets the scaling method for the displacement variable `comp1_u` to manual.

7. `model.sol('sol1').feature('v1').feature('comp1_spatial_disp').set('scaleval', '1e-2*4.097926304852248E-5');`
   - Sets the scale value for the spatial displacement variable.

8. `model.sol('sol1').feature('v1').feature('comp1_u').set('scaleval', '1e-2*4.097926304852248E-5');`
   - Sets the scale value for the displacement variable `comp1_u`.

9. `model.sol('sol1').feature('v1').set('control', 'stat');`
   - Sets the control type for the variables to stationary.

10. `model.sol('sol1').create('s1', 'Stationary');`
    - Creates a stationary solver feature `s1`.

11. `model.sol('sol1').feature('s1').feature('aDef').set('cachepattern', true);`
    - Enables caching of the solution pattern for efficiency.

12. `model.sol('sol1').feature('s1').create('seDef', 'Segregated');`
    - Creates a segregated solver feature `seDef`.

13. `model.sol('sol1').feature('s1').create('se1', 'Segregated');`
    - Creates another segregated solver feature `se1`.

14. `model.sol('sol1').feature('s1').feature('se1').feature.remove('ssDef');`
    - Removes the default segregated step.

15. `model.sol('sol1').feature('s1').feature('se1').create('ss1', 'SegregatedStep');`
    - Creates a segregated step `ss1` for solving electric potential.

16. `model.sol('sol1').feature('s1').feature('se1').feature('ss1').set('segvar', {'comp1_V'});`
    - Sets the segregated variable to electric potential `comp1_V`.

17. `model.sol('sol1').feature('s1').create('d1', 'Direct');`
    - Creates a direct solver feature `d1`.

18. `model.sol('sol1').feature('s1').feature('d1').set('linsolver', 'mumps');`
    - Sets the linear solver to MUMPS.

19. `model.sol('sol1').feature('s1').feature('se1').feature('ss1').set('linsolver', 'd1');`
    - Sets the linear solver for the segregated step `ss1` to the direct solver `d1`.

20. `model.sol('sol1').feature('s1').feature('se1').feature('ss1').label('Electric potential');`
    - Labels the segregated step `ss1` as "Electric potential".

21. `model.sol('sol1').feature('s1').feature('se1').create('ss2', 'SegregatedStep');`
    - Creates another segregated step `ss2` for solving displacement.

22. `model.sol('sol1').feature('s1').feature('se1').feature('ss2').set('segvar', {'comp1_u'});`
    - Sets the segregated variable to displacement `comp1_u`.

23. `model.sol('sol1').feature('s1').feature('se1').feature('ss2').set('linsolver', 'd1');`
    - Sets the linear solver for the segregated step `ss2` to the direct solver `d1`.

24. `model.sol('sol1').feature('s1').feature('se1').feature('ss2').label('Displacement field');`
    - Labels the segregated step `ss2` as "Displacement field".

25. `model.sol('sol1').feature('s1').feature('se1').create('ss3', 'SegregatedStep');`
    - Creates another segregated step `ss3` for solving spatial mesh displacement.

26. `model.sol('sol1').feature('s1').feature('se1').feature('ss3').set('segvar', {'comp1_spatial_disp'});`
    - Sets the segregated variable to spatial displacement `comp1_spatial_disp`.

27. `model.sol('sol1').feature('s1').feature('se1').feature('ss3').set('subdtech', 'const');`
    - Sets the subdomain technology to constant.

28. `model.sol('sol1').feature('s1').feature('se1').feature('ss3').set('subjtech', 'onevery');`
    - Sets the subdomain technology to apply on every iteration.

29. `model.sol('sol1').feature('s1').feature('se1').feature('ss3').set('linsolver', 'd1');`
    - Sets the linear solver for the segregated step `ss3` to the direct solver `d1`.

30. `model.sol('sol1').feature('s1').feature('se1').feature('ss3').label('Spatial mesh displacement');`
    - Labels the segregated step `ss3` as "Spatial mesh displacement".

31. `model.sol('sol1').feature('s1').feature('se1').set('segstabacc', 'segaacc');`
    - Sets the segregated stabilization accuracy.

32. `model.sol('sol1').feature('s1').feature('se1').set('segaaccdim', 5);`
    - Sets the dimension of the stabilization accuracy.

33. `model.sol('sol1').feature('s1').create('i1', 'Iterative');`
    - Creates an iterative solver feature `i1`.

34. `model.sol('sol1').feature('s1').feature('i1').set('linsolver', 'gmres');`
    - Sets the linear solver to GMRES.

35. `model.sol('sol1').feature('s1').feature('i1').set('rhob', 40);`
    - Sets the relative tolerance for the iterative solver.

36. `model.sol('sol1').feature('s1').feature('i1').set('nlinnormuse', true);`
    - Enables the use of nonlinear norm in the iterative solver.

37. `model.sol('sol1').feature('s1').feature('i1').set('itrestart', 5000);`
    - Sets the iteration restart value to 5000.

38. `model.sol('sol1').feature('s1').feature('i1').label('Iterative Solver (GMRES with SA AMG) (eme1)');`
    - Labels the iterative solver feature.

39. `model.sol('sol1').feature('s1').feature('i1').create('mg1', 'Multigrid');`
    - Creates a multigrid preconditioner feature `mg1`.

40. `model.sol('sol1').feature('s1').feature('i1').feature('mg1').set('hybridization', 'multi');`
    - Sets the hybridization type to multi.

41. `model.sol('sol1').feature('s1').feature('i1').feature('mg1').set('hybridvar', {'comp1_u' 'comp1_V'});`
    - Sets the hybridization variables to displacement and electric potential.

42. `model.sol('sol1').feature('s1').feature('i1').feature('mg1').set('prefun', 'saamg');`
    - Sets the preconditioner function to SA-AMG.

43. `model.sol('sol1').feature('s1').feature('i1').feature('mg1').set('usesmooth', false);`
    - Disables the use of smoothing in the multigrid preconditioner.

44. `model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('pr').create('so1', 'SOR');`
    - Creates a SOR preconditioner for the multigrid.

45. `model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('pr').feature('so1').set('relax', 0.8);`
    - Sets the relaxation factor for the SOR preconditioner.

46. `model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('po').create('so1', 'SOR');`
    - Creates a SOR post-preconditioner for the multigrid.

47. `model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('po').feature('so1').set('relax', 0.8);`
    - Sets the relaxation factor for the SOR post-preconditioner.

48. `model.sol('sol1').feature('s1').feature('i1').create('dp1', 'DirectPreconditioner');`
    - Creates a direct preconditioner feature `dp1`.

49. `model.sol('sol1').feature('s1').feature('i1').feature('dp1').set('hybridization', 'multi');`
    - Sets the hybridization type to multi.

50. `model.sol('sol1').feature('s1').feature('i1').feature('dp1').set('hybridvar', {'comp1_spatial_disp'});`
    - Sets the hybridization variable to spatial displacement.

51. `model.sol('sol1').feature('s1').feature.remove('fcDef');`
    - Removes the default fully coupled step.

52. `model.sol('sol1').feature('s1').feature.remove('seDef');`
    - Removes the default segregated step.

53. `model.sol('sol1').attach('std1');`
    - Attaches the solver to the study `std1`.

54. `model.result.create('pg1', 'PlotGroup3D');`
    - Creates a 3D plot group for visualization of the results.

### COMSOL Context

- **Study and Solver Configuration**: COMSOL uses a hierarchical structure for organizing studies and solvers. This code sets up a stationary solver with segregated steps for different physics and iterative and direct solvers.
- **Variables and Scaling**: The scaling of variables is important for the numerical stability of the solver. Here, the scaling is set manually for displacement and spatial displacement variables.
- **Linear Solvers**: MUMPS and GMRES are used as linear solvers. MUMPS is a direct solver, and GMRES is an iterative solver. The choice of solver depends on the problem size and type.
- **Preconditioners**: Preconditioners like SA-AMG and SOR are used to accelerate the convergence of the iterative solver. They modify the system of equations to improve the conditioning.
- **Multigrid**: The multigrid method is a popular technique for solving large systems of equations efficiently. It uses a hierarchy of grids to reduce error on different scales.

### Physical Meaning

This code sets up a solver for a 3D biased resonator model, which likely involves the simulation of electric potential and structural displacement due to electrostatic forces. The segregated solver steps represent the different physical quantities being solved for, such as electric potential and displacement field. The spatial mesh displacement step is related to the deformation of the mesh due to the structural displacement.

### Dependencies

This segment is dependent on the correct setup of the physics in the model, including the definitions of the electric potential and displacement fields. The solver configuration would need to match the physics and mesh setup. The study `std1` must be defined elsewhere in the model, and the plot group `pg1` will be used to visualize the results obtained from this solver.

## Segment 16: Results (Lines 401-518)

### Purpose

This COMSOL MATLAB code segment is responsible for setting up the visualization and post-processing of results for a 3D biased resonator model. It defines three plot groups to represent different physical quantities: displacement of the solid structure, electric potential, and electric field norm. Each plot group is configured with specific settings for visualizing the respective fields, including color tables, slice planes, and streamlines to illustrate the direction and magnitude of the fields.

### Step-by-Step Analysis

#### Plot Group 1: Displacement (solid)
- `model.result('pg1').set('data', 'dset1');`
  - Sets the data source for the plot group to dataset `dset1`.
- `model.result('pg1').set('defaultPlotID', 'displacement');`
  - Sets the default plot ID to represent displacement.
- `model.result('pg1').label('Displacement (solid)');`
  - Labels the plot group for clarity.
- `model.result('pg1').set('frametype', 'spatial');`
  - Configures the plot frame type to spatial, indicating a 3D plot.
- `model.result('pg1').create('vol1', 'Volume');`
  - Creates a volume plot within the plot group.
- `model.result('pg1').feature('vol1').set('expr', {'solid.disp'});`
  - Sets the expression to plot the displacement field of the solid mechanics physics.
- `model.result('pg1').feature('vol1').set('threshold', 'manual');`
  - Configures the threshold for the plot to be manually set.
- `model.result('pg1').feature('vol1').set('thresholdvalue', 0.2);`
  - Sets the threshold value to 0.2, controlling the visibility of small displacements.
- `model.result('pg1').feature('vol1').set('resolution', 'custom');`
  - Sets the resolution of the plot to custom, allowing detailed control.
- `model.result('pg1').feature('vol1').set('refine', 2);`
  - Refines the mesh for plotting purposes, enhancing the visual quality.
- `model.result('pg1').feature('vol1').set('colortable', 'SpectrumLight');`
  - Chooses a color table for the displacement plot to visually distinguish different displacement magnitudes.

#### Plot Group 2: Electric Potential (es)
- `model.result.create('pg2', 'PlotGroup3D');`
  - Creates a new 3D plot group for electric potential.
- `model.result('pg2').label('Electric Potential (es)');`
  - Labels the plot group.
- `model.result('pg2').set('frametype', 'spatial');`
  - Sets the frame type to spatial for a 3D representation.
- `model.result('pg2').set('showlegendsmaxmin', true);`
  - Enables showing legends for maximum and minimum values in the plot.
- `model.result('pg2').feature.create('mslc1', 'Multislice');`
  - Creates a multislice plot to visualize the electric potential across multiple slice planes.
- `model.result('pg2').feature('mslc1').set('expr', 'V');`
  - Sets the expression to plot the electric potential `V`.
- `model.result('pg2').feature('mslc1').set('multiplanexmethod', 'coord');`
  - Configures the slice plane positioning based on coordinates.
- `model.result('pg2').feature('mslc1').set('xcoord', 'es.CPx');`
  - Sets the x-coordinate of the slice planes.
- Similar configurations are made for y- and z-coordinates.
- `model.result('pg2').feature('mslc1').set('colortable', 'Dipole');`
  - Sets the color table for the multislice plot.
- `model.result('pg2').feature.create('strmsl1', 'StreamlineMultislice');`
  - Creates a streamline plot to visualize the electric field direction and magnitude.
- `model.result('pg2').feature('strmsl1').set('expr', {'es.Ex' 'es.Ey' 'es.Ez'});`
  - Sets the expressions for the electric field components.
- Additional settings for streamlines include positioning, length, and color configuration.

#### Plot Group 3: Electric Field Norm (es)
- Similar to Plot Group 2, but visualizing the norm of the electric field (`es.normE`) instead of the electric potential.
- Configurations include multislice and streamline plots with specific expressions, color tables, and slice plane coordinates.

### COMSOL Context

- **Plot Groups**: COMSOL uses plot groups to organize and manage the visualization of different physical quantities in a model.
- **Features**: Within each plot group, features such as volume plots, multislice plots, and streamline plots are used to represent the data. These features are configured with specific expressions, color tables, and other parameters to accurately visualize the simulation results.
- **Expressions**: The expressions set for each feature define the physical quantity to be plotted, such as `solid.disp` for displacement and `es.normE` for the norm of the electric field.
- **Slice Planes and Streamlines**: These are used to visualize fields in 3D space, providing insights into the distribution and directionality of physical quantities.

### Physical Meaning

This code segment is part of a larger model simulating a biased resonator in 3D. The physical quantities being visualized include:
- **Displacement**: The deformation of the solid structure under applied loads or biases.
- **Electric Potential**: The distribution of voltage within the device, indicating regions of high and low potential.
- **Electric Field Norm**: The magnitude of the electric field, showing areas of strong and weak fields.

### Dependencies

This segment is closely tied to the definition of the physics in the model, specifically the solid mechanics and electrostatics. The expressions used in the plots (`solid.disp`, `V`, `es.normE`, etc.) are directly related to the variables and fields computed in the model's physics settings. Additionally, the dataset `dset1` used for plotting is likely generated from the solution of the model, making this segment dependent on the successful computation of the model's solution.

## Segment 17: Solver (Lines 519-520)

**Purpose:**

This code segment is responsible for running the entire solution sequence for a specific study named 'sol1' within the COMSOL model named 'biased_resonator_3d_modes'. The solution sequence typically includes solving for the dependent variables of the model, such as the deformation or stress fields in a structural mechanics problem, or the electric potential and field distributions in an electromagnetics problem, based on the physics defined in the model.

**Step-by-Step Analysis:**

- `model.sol('sol1')`: This part of the code accesses the solution ('sol') settings of the model, specifically the solution sequence named 'sol1'. In COMSOL, a solution sequence is a set of instructions that tells the software how to solve the model, including which study to run, which solvers to use, and in what order.

- `.runAll`: This command is a method that is called on the solution sequence 'sol1'. The `.runAll` method instructs COMSOL to execute all the steps defined in the solution sequence. This typically includes the setup phase, where the solver settings are prepared, the solution phase, where the actual computation is performed, and the cleanup phase, where post-processing tasks are carried out.

**COMSOL Context:**

In COMSOL, the `model` object represents the current model being worked on. The `sol` property of the model object is used to access and manipulate the solution sequences. The `'sol1'` string is the name of the solution sequence that is being referred to. The `.runAll` method is a built-in function within COMSOL that is used to run the entire solution sequence.

**Physical Meaning:**

The physical meaning of running the solution sequence depends on the specifics of the model 'biased_resonator_3d_modes'. In the context of a biased resonator, this could involve solving for the resonant modes of the structure under a specified bias condition. The solution sequence would compute the deformation of the resonator, the stress distribution, or the electromagnetic fields, depending on the physics involved in the model.

**Dependencies:**

This code segment is dependent on the correct setup of the 'sol1' solution sequence within the model. This includes proper definition of the physics, geometry, mesh, boundary conditions, and solver settings. The solution sequence 'sol1' would typically be configured through the COMSOL user interface or through additional scripting commands prior to the execution of this code segment.

The outcome of this code segment is also dependent on the initial conditions and parameters set in the model. Changes to material properties, geometry dimensions, or load conditions would affect the results obtained from running the solution sequence.

In summary, this code segment is a critical part of the simulation process, where the actual computation is performed based on the model setup. The results from this computation can then be post-processed to visualize the solution, extract specific values, or perform additional analyses.

## Segment 18: Results (Lines 521-568)

This COMSOL MATLAB code segment is designed to post-process and visualize the results of a stationary analysis of a biased MEMS resonator. The resonator is electrostatically actuated, and the simulation focuses on computing the deformation of the resonator under the influence of an applied DC bias voltage. The code creates visual representations of the displacement field and electric potential within the resonator.

### Step-by-Step Analysis

1. `model.result('pg1').run;`
   - This line runs the result named 'pg1', which is likely a predefined plot group that contains settings for visualizing results.

2. `model.result.dataset.create('mir1', 'Mirror3D');`
   - Creates a new dataset named 'mir1' of type 'Mirror3D'. This dataset is probably used to mirror the results across a plane to create a full 3D representation of the resonator, given that only half of the geometry might have been modeled due to symmetry.

3. `model.result.create('pg4', 'PlotGroup3D');`
   - Creates a new 3D plot group named 'pg4' for organizing 3D visualizations.

4. `model.result('pg4').run;`
   - Runs the newly created plot group 'pg4', which is necessary to initialize it.

5. `model.result('pg4').set('data', 'mir1');`
   - Sets the data source for 'pg4' to the dataset 'mir1', which means that the visualizations in 'pg4' will be based on the mirrored dataset.

6. `model.result('pg4').create('vol1', 'Volume');`
   - Creates a volume plot named 'vol1' within 'pg4' to visualize data over the 3D volume of the resonator.

7. `model.result('pg4').feature('vol1').set('expr', 'w');`
   - Sets the expression for 'vol1' to 'w', which likely represents the displacement field in the Z-direction.

8. `model.result('pg4').feature('vol1').set('descr', 'Displacement field, Z-component');`
   - Sets the description for the volume plot to "Displacement field, Z-component" for clarity in the visualization.

9. `model.result('pg4').feature('vol1').set('colortabletrans', 'reverse');`
   - Reverses the color table transparency for the volume plot, which affects how the data is visually represented.

10. `model.result('pg4').run;`
    - Runs the plot group 'pg4' again to update the visualization with the new settings.

11. `model.result('pg4').create('iso1', 'Isosurface');`
    - Creates an isosurface plot named 'iso1' within 'pg4' to visualize surfaces of constant value.

12. `model.result('pg4').feature('iso1').set('expr', 'V');`
    - Sets the expression for 'iso1' to 'V', which likely represents the electric potential.

13. `model.result('pg4').feature('iso1').set('descr', 'Electric potential');`
    - Sets the description for the isosurface plot to "Electric potential".

14. `model.result('pg4').feature('iso1').set('levelmethod', 'levels');`
    - Sets the method for determining isosurface levels to manual specification.

15. `model.result('pg4').feature('iso1').set('levels', '10 20 30');`
    - Sets the specific values at which isosurfaces are generated.

16. `model.result('pg4').feature('iso1').set('colortable', 'Traffic');`
    - Sets the color table for the isosurface plot to "Traffic", which is a predefined color scheme in COMSOL.

17. `model.result('pg4').feature('iso1').set('colorlegend', false);`
    - Disables the color legend for the isosurface plot.

18. `model.result('pg4').run;`
    - Runs the plot group 'pg4' again to update the visualization with the new isosurface settings.

19. `model.result('pg4').label('Biased Displacement');`
    - Labels the plot group 'pg4' as "Biased Displacement".

20. `model.view.create('view4', 3);`
    - Creates a new 3D view named 'view4'.

21. `model.view('view3').set('locked', true);`
    - Locks the view 'view3', preventing it from being accidentally modified.

22. `model.view('view3').camera.set('zoomanglefull', 22);`
    - Sets the zoom angle for 'view3' to provide an appropriate level of detail.

23-34. Various `model.view('view3').camera.setIndex` and `model.view('view3').camera.set` commands:
    - These lines configure the camera position, target, up vector, rotation point, and view offset for 'view3' to obtain a specific orientation and perspective of the 3D model.

35. `model.result('pg4').run;`
    - Runs the plot group 'pg4' again, likely to ensure all settings are applied.

36. `model.result('pg4').set('view', 'view3');`
    - Sets the view for 'pg4' to 'view3', applying the camera settings configured earlier.

37. `model.result('pg4').run;`
    - Runs the plot group 'pg4' again to update the visualization with the new view settings.

38. `model.title(['Stationary Analysis of a Biased Resonator ' native2unicode(hex2dec({'20' '14'}), 'unicode') ' 3D']);`
    - Sets the title of the model to include the analysis type and the fact that it's a 3D simulation, along with a Unicode character represented by the hexadecimal values '20' and '14'.

39. `model.description('An electrostatically actuated MEMS resonator is simulated...');`
    - Sets a description for the model, providing context about the physical system being simulated.

40. `model.label('biased_resonator_3d_basic.mph');`
    - Labels the model with a filename, possibly for identification or saving purposes.

41. `model.result('pg4').run;`
    - Runs the plot group 'pg4' one final time to ensure all settings are applied and visualizations are up to date.

### COMSOL Context

The code uses COMSOL's MATLAB API to interact with the COMSOL Multiphysics software. Commands like `model.result.create` and `model.view.create` are specific to COMSOL and are used to create and configure result visualizations and view settings, respectively.

### Physical Meaning

This code segment represents the post-processing part of a simulation where the deformation (displacement field) and the electric potential distribution within a MEMS resonator are visualized. The resonator is subject to an electrostatic force due to a DC bias voltage, causing it to deform. The physical phenomena are captured by the variables 'w' for the Z-component of displacement and 'V' for the electric potential.

### Dependencies

This segment depends on the preceding parts of the model definition where the geometry, mesh, physics settings, and solver settings are defined. The dataset 'mir1' and plot group 'pg1' must have been previously defined or generated by the simulation. The visualizations created here are based on the computed solution, and changes to the model's physics or geometry would necessitate a re-run of the simulation to update these visualizations.

## Segment 19: Geometry (Lines 569-580)

### Purpose

This code segment is designed to perform a series of operations within COMSOL Multiphysics using the MATLAB LiveLink interface. The primary objectives of this segment are:

1. To execute a geometry sequence named 'ext1' within the geometry 'geom1'.
2. To create a mirror feature 'mir1' within the same geometry, mirroring selected entities about a specified axis.
3. To configure the visualization settings for a specific view.
4. To re-run the geometry sequence to apply the changes.
5. To create an interpolation function 'int1'.

### Step-by-Step Analysis

#### Line 1: `model.geom('geom1').run('ext1');`
- **Command**: `run`
- **Function**: Executes the geometry sequence named 'ext1' within the geometry 'geom1'.
- **Purpose**: This line runs a predefined sequence of geometry operations, possibly creating or modifying geometric entities within the model.

#### Line 2-5: Mirror Feature Creation
```matlab
model.geom('geom1').create('mir1', 'Mirror');
model.geom('geom1').feature('mir1').set('axis', [1 0 0]);
model.geom('geom1').feature('mir1').selection('input').set({'blk1' 'ext1'});
model.geom('geom1').feature('mir1').set('keep', true);
```
- **Command**: `create`, `set`, `selection`
- **Function**: Creates a mirror feature named 'mir1', sets its mirroring axis to the x-axis ([1 0 0]), selects the entities ('blk1' and 'ext1') to be mirrored, and specifies that the original entities should be kept.
- **Purpose**: This block of code defines a mirror operation that duplicates the selected entities ('blk1' and 'ext1') symmetrically about the x-axis, with the original entities preserved in the geometry.

#### Line 6: `model.geom('geom1').runPre('fin');`
- **Command**: `runPre`
- **Function**: Executes the geometry sequence 'fin' in preparation mode, typically used for finalizing geometry operations or setting up conditions for the next steps.
- **Purpose**: This line might be used to apply any finishing touches or adjustments to the geometry before proceeding to visualization or further analysis.

#### Line 7: `model.view('view1').set('renderwireframe', true);`
- **Command**: `set`
- **Function**: Configures the view settings for 'view1', specifically setting the 'renderwireframe' option to true, which enables the wireframe rendering mode for the view.
- **Purpose**: This line adjusts the visualization settings to display the geometry in wireframe mode, which can be useful for inspecting the structure of the model.

#### Line 8: `model.geom('geom1').run;`
- **Command**: `run`
- **Function**: Executes the entire geometry sequence 'geom1', applying all modifications and operations defined within it.
- **Purpose**: This line ensures that all changes made to the geometry, including the mirror operation, are fully applied and the geometry is updated accordingly.

#### Line 9: `model.func.create('int1', 'Interpolation');`
- **Command**: `create`
- **Function**: Creates a new function named 'int1' of type 'Interpolation'.
- **Purpose**: This line sets up an interpolation function that can be used for mapping or transforming data within the model, possibly for defining material properties, loads, or boundary conditions based on interpolated values.

### COMSOL Context

- **Geometry and Features**: COMSOL uses a hierarchical structure for defining geometry and features. This code manipulates that structure, creating and configuring geometric features.
- **MATLAB LiveLink**: The syntax used is specific to the MATLAB LiveLink interface, allowing for the manipulation of COMSOL models using MATLAB commands.

### Physical Meaning

This code segment is part of a larger model aimed at simulating a biased resonator's 3D modes. The specific operations performed here are related to setting up the geometry of the resonator, possibly preparing it for meshing and analysis. The mirror feature could be used to create a symmetric model, reducing the computational domain and exploiting symmetry to simplify the analysis.

### Dependencies

This segment is likely dependent on previous definitions of the geometry sequences 'ext1' and 'fin', as well as the entities 'blk1' and 'ext1'. The interpolation function 'int1' might be used in subsequent steps for applying material properties or boundary conditions. The visualization settings adjusted here affect how the model is displayed, which is crucial for visual inspection and verification of the geometry before running simulations.

## Segment 20: Function (Lines 581-589)

### Purpose

This code segment is designed to import data from an external file named `biased_resonator_3d_modes_experiment.txt` into a COMSOL model named `biased_resonator_3d_modes` within the `MEMS_Module_Actuators_biased_resonator_3d_modes` module. The data is likely experimental or pre-calculated data that is to be used within the model for comparison, validation, or as input for further calculations. The segment sets up an interpolation function based on this data, specifying units and handling of out-of-range values.

### Step-by-Step Analysis

1. **Select Model and Module**:
   - `model.func('int1').model('comp1');`
   - This line selects the model and the component (`comp1`) where the function will be defined. It specifies that the interpolation function `int1` is to be associated with the `comp1` component of the model.

2. **Set Function Source**:
   - `model.func('int1').set('source', 'file');`
   - This command sets the source of the function `int1` to be from an external file. It indicates that the function values will be imported from a file rather than defined within COMSOL.

3. **Specify File Name**:
   - `model.func('int1').set('filename', 'biased_resonator_3d_modes_experiment.txt');`
   - This line specifies the name of the file from which the data will be imported. The file `biased_resonator_3d_modes_experiment.txt` is expected to contain the data points that will be used to define the function.

4. **Import Data**:
   - `model.func('int1').importData;`
   - This command initiates the import of data from the specified file. COMSOL reads the data from the file and uses it to define the function `int1`.

5. **Set Argument Unit**:
   - `model.func('int1').setIndex('argunit', 'Hz', 0);`
   - This line sets the unit of the function's argument (x-axis) to Hertz (Hz), indicating that the independent variable represents frequency. The `0` at the end specifies the index of the argument to which the unit applies, which in this case is the first (and possibly only) argument.

6. **Set Function Unit**:
   - `model.func('int1').setIndex('fununit', 'V', 0);`
   - This command sets the unit of the function's output (y-axis) to Volts (V), indicating that the dependent variable represents a voltage. Similar to the argument unit setting, the `0` specifies the index of the function value to which the unit applies.

7. **Set Extrapolation Method**:
   - `model.func('int1').set('extrap', 'value');`
   - This line specifies the method for handling values outside the range of the imported data. The `'value'` option indicates that a specific value will be used for extrapolation.

8. **Set Extrapolation Value**:
   - `model.func('int1').set('extrapvalue', NaN);`
   - This command sets the value to be used for extrapolation outside the data range to `NaN` (Not a Number). This means that any query for function values outside the range of the imported data will return `NaN`, effectively indicating that the function is undefined outside its data range.

### COMSOL Context

The code uses COMSOL's Application Programming Interface (API) to interact with the model, specifically to define and configure an interpolation function. The `model.func` syntax is COMSOL-specific and is used to access and manipulate functions within the model. The `set` and `setIndex` methods are used to configure various properties of the function, such as its source, units, and extrapolation behavior.

### Physical Meaning

In the context of the physical simulation, this code segment is importing experimental or pre-calculated data that represents some aspect of the biased resonator's behavior, possibly its response to different frequencies. The data could represent voltage measurements across the resonator at various frequencies. By importing this data into the model as an interpolation function, the simulation can use it for comparisons with simulated data, to validate the model, or as input for further calculations.

### Dependencies

This segment is likely dependent on other parts of the model that will utilize the imported data. For example, the model might include study steps that compare simulated results with the imported experimental data for validation purposes. Additionally, other model components might use the defined function `int1` as input for their calculations. The segment assumes the existence of the specified file and its correct format, which is an external dependency. Any changes to the experimental setup or data collection that affect the file's contents or structure would necessitate adjustments to this code segment.

## Segment 21: Physics (Lines 590-591)

1. **Purpose**:
This code segment is deactivating a symmetry boundary condition feature named 'sym1' in a physics interface called 'solid' within a COMSOL model named 'biased_resonator_3d_modes'.

2. **Step-by-Step Analysis**:
- `model.physics('solid')`: This command selects the physics interface named 'solid' within the current model. The 'solid' physics interface is likely related to structural mechanics, possibly for modeling the deformation or stress within a solid object.
  
- `.feature('sym1')`: This command selects a specific feature within the 'solid' physics interface. The feature 'sym1' is a symmetry boundary condition. Symmetry boundary conditions are used when you have a model with geometrical symmetry, allowing you to model only a portion of the geometry and thus reduce computational resources and time.

- `.active(false)`: This command deactivates the selected feature, in this case, the symmetry boundary condition 'sym1'. When a feature is deactivated, it is not included in the model's setup and does not affect the computation. This could be done for various reasons, such as troubleshooting, comparing different model configurations, or because the symmetry condition is no longer applicable to the current analysis.

3. **COMSOL Context**:
In COMSOL, the `model.physics` command is used to access and manipulate physics interfaces. Physics interfaces define the type of physics being solved, such as structural mechanics, heat transfer, fluid dynamics, etc. The `feature` command is used to access and manipulate specific features within a physics interface, such as boundary conditions, material properties, or source terms. The `active` property is a common feature property that determines whether a feature is included in the model or not.

4. **Physical Meaning**:
In the physical simulation, this code segment represents the decision to exclude a symmetry condition in the structural mechanics analysis of the model. This could mean that the user is exploring the model's behavior without the assumption of symmetry, perhaps to capture more complex or asymmetric behavior.

5. **Dependencies**:
This code segment is likely dependent on previous definitions of the 'solid' physics interface and the 'sym1' feature. The 'solid' physics interface would have been added to the model earlier in the code, and the 'sym1' feature would have been defined with specific settings for the symmetry boundary condition. Additionally, deactivating this feature may affect other parts of the model, such as the meshing, solver settings, and post-processing, as the model will now solve for the full geometry instead of just a symmetric portion.

## Segment 22: Mesh (Lines 592-596)

### Purpose

This code segment is part of a COMSOL model that focuses on simulating a biased resonator in 3D modes. Specifically, this segment is concerned with configuring the mesh settings of the model to ensure accurate simulation results and creating a study to potentially solve the model under certain conditions.

### Step-by-Step Analysis

#### Line 1: `model.mesh('mesh1').feature('size').set('custom', true);`
- **Command**: This line is accessing the mesh settings of the model named 'mesh1' and then specifically targeting the feature named 'size'.
- **Parameters**: The `set` function is used to modify the properties of the 'size' feature. The parameter 'custom' is set to `true`.
- **Purpose**: By setting 'custom' to `true`, the user is opting for a custom mesh size instead of using the default mesh settings provided by COMSOL. This allows for finer control over the mesh, which is crucial for accurate simulations, especially in complex geometries or where high gradients are expected.

#### Line 2: `model.mesh('mesh1').feature('size').set('hmin', 1);`
- **Command**: This line continues to configure the 'size' feature of the 'mesh1' mesh.
- **Parameters**: The parameter 'hmin' is set to `1`. 'hmin' refers to the minimum element size in the mesh.
- **Purpose**: Setting 'hmin' to `1` ensures that the smallest element size in the mesh is 1 unit (the unit depends on the model's geometry settings). This is important for capturing small features or high gradients within the model, ensuring accuracy in the simulation results.

#### Line 3: `model.mesh('mesh1').run;`
- **Command**: This line executes the meshing process based on the settings specified in the previous lines.
- **Purpose**: Running the mesh feature generates the mesh according to the custom settings provided. This step is crucial as it prepares the model geometry for analysis by discretizing it into small elements.

#### Line 4: `model.study.create('std2');`
- **Command**: This line creates a new study in the model named 'std2'.
- **Purpose**: Studies in COMSOL are used to define the type of analysis (e.g., stationary, time-dependent, eigenvalue) and to set up parameters for solving the model. Creating a new study allows the user to configure and run a specific type of analysis on the model.

### COMSOL Context

- **Mesh Configuration**: The first three lines deal with mesh configuration, which is a critical part of the preprocessing stage in COMSOL simulations. The mesh quality can significantly affect the accuracy and computational efficiency of the simulation.
- **Study Creation**: The last line initiates the setup for solving the model by creating a study. This is where the user can specify the type of solver and analysis settings.

### Physical Meaning

- **Meshing**: The physical meaning of meshing is to divide the physical domain of the problem into small, discrete elements. This process is fundamental in the Finite Element Method (FEM), which COMSOL uses to solve various physics problems.
- **Study**: Creating a study is the step towards defining how the physical problem will be solved, including the type of physics involved, the solver settings, and the parameters that will be analyzed.

### Dependencies

- **Geometry and Physics**: The mesh settings are closely related to the geometry of the model and the physics being simulated. Finer meshes are often required in regions where high gradients or complex phenomena are expected.
- **Solver and Results**: The study settings will depend on the physics involved and the desired outcomes. The solver's settings and the mesh quality are interdependent, as the solver's performance and the accuracy of the results depend on an appropriate mesh.

This code segment is foundational for setting up a simulation in COMSOL, ensuring that the model's geometry is appropriately discretized and that a framework for solving the model is established. The detailed configuration of the mesh and the creation of a study are steps that directly impact the simulation's accuracy and efficiency.

## Segment 23: Study (Lines 597-624)

### Purpose

This COMSOL MATLAB code segment is setting up an eigenfrequency study for a model named `biased_resonator_3d_modes`. The study aims to compute the natural frequencies (eigenfrequencies) and mode shapes of a structure, which is likely a biased resonator, given the model's name. Eigenfrequency analysis is crucial for understanding the dynamic behavior of structures, especially for resonators that are designed to operate at specific frequencies.

### Step-by-Step Analysis

1. **Create Eigenfrequency Study**:
   - `model.study('std2').create('eig', 'Eigenfrequency');`
   - This line creates a new study named `eig` of type `Eigenfrequency` within the study `std2`. Eigenfrequency studies are used to find the natural frequencies and mode shapes of a system.

2. **Configure Plot Group**:
   - `model.study('std2').feature('eig').set('plotgroup', 'Default');`
   - Sets the plot group for the results of the eigenfrequency study to the default plot group, which determines how the results are visualized.

3. **Set Shift Frequency**:
   - `model.study('std2').feature('eig').set('shift', '1[Hz]');`
   - Specifies a shift value of 1 Hz for the eigenfrequency solver. The shift is often used to avoid zero-frequency modes or to target a specific frequency range of interest.

4. **Check Eigenvalue Region**:
   - `model.study('std2').feature('eig').set('chkeigregion', true);`
   - Enables checking of the eigenvalue region to ensure that the computed eigenvalues fall within the expected range.

5. **Set Solver Parameters**:
   - `model.study('std2').feature('eig').set('conrad', '1');`
   - `model.study('std2').feature('eig').set('conradynhm', '1');`
   - These lines set the convergence ratio (`conrad`) and the convergence ratio for the Newton method (`conradynhm`) to 1, affecting the solver's convergence criteria.

6. **Configure Advanced Solver Settings**:
   - `model.study('std2').feature('eig').set('storefact', false);`
   - Disables the storage of factorization, which can save memory but may slow down the solver if re-factorization is needed.
   - `model.study('std2').feature('eig').set('linpsolnum', 'auto');`
   - Sets the linear solver to automatic selection, allowing COMSOL to choose the most appropriate solver.
   - `model.study('std2').feature('eig').set('solnum', 'auto');`
   - `model.study('std2').feature('eig').set('notsolnum', 'auto');`
   - Sets the solution number and the number of non-solution (not solved for) variables to automatic, letting COMSOL optimize these settings.

7. **Output Mapping**:
   - `model.study('std2').feature('eig').set('outputmap', {});`
   - Clears the output mapping, which controls what fields are output for post-processing.

8. **Set Number of Eigenvalues**:
   - `model.study('std2').feature('eig').set('ngenAUX', '1');`
   - `model.study('std2').feature('eig').set('goalngenAUX', '1');`
   - These lines set the number of eigenvalues to compute and the goal number of eigenvalues, both to 1. This is likely a placeholder or a specific requirement for this model.

9. **Solve for Physics Interfaces**:
   - `model.study('std2').feature('eig').setSolveFor('/physics/solid', true);`
   - `model.study('std2').feature('eig').setSolveFor('/physics/es', true);`
   - `model.study('std2').feature('eig').setSolveFor('/multiphysics/eme1', true);`
   - Configures the eigenfrequency study to solve for the solid mechanics, electrostatics, and multiphysics interface `eme1`, indicating a coupled physics problem.

10. **Create Participation Factors**:
    - `model.common.create('mpf1', 'ParticipationFactors', 'comp1');`
    - This line creates a participation factors study object, which can be used to analyze the contribution of different modes to the overall response of the structure.

11. **Activate Number of Eigenvalues**:
    - `model.study('std2').feature('eig').set('neigsactive', true);`
    - Activates the setting for the number of eigenvalues to compute.
    - `model.study('std2').feature('eig').set('neigs', 3);`
    - Sets the number of eigenvalues to compute to 3, indicating an interest in the first three modes.

12. **Configure Output Mapping**:
    - `model.study('std2').feature('eig').setEntry('outputmap', 'es', 'none');`
    - `model.study('std2').feature('eig').setEntry('outputmap', 'frame:spatial1', 'none');`
    - These lines configure the output mapping to exclude electrostatics and spatial frame fields from the output, focusing the results on the desired quantities.

13. **Create Solution**:
    - `model.sol.create('sol2');`
    - Creates a solution sequence named `sol2` to store the results of the eigenfrequency study.

### COMSOL Context

The code uses COMSOL's MATLAB API to interact with the model, configuring an eigenfrequency study with specific solver settings, output configurations, and participation factors. COMSOL's studies and solvers are designed to handle complex multiphysics problems, and this code demonstrates setting up a sophisticated analysis for a resonator structure.

### Physical Meaning

This code sets up an analysis to find the natural frequencies and mode shapes of a biased resonator, which is essential for understanding how the resonator will respond to dynamic loads or excitations at various frequencies. The settings chosen indicate an interest in the lower modes of vibration and the interaction between mechanical and electrostatic effects.

### Dependencies

This segment is part of a larger model setup and depends on the correct definition of the geometry, mesh, physics interfaces, and material properties. The eigenfrequency study results will also inform further analyses, such as frequency response or transient analyses, to fully characterize the resonator's behavior.

## Segment 24: Mesh (Lines 625-627)

1. **Purpose**: This code segment is used to define the meshing of a specific geometry within a COMSOL model. It selects certain geometric entities (like domains or boundaries) for meshing and specifies which entities will be included in the mesh.

2. **Step-by-Step Analysis**:

   - `model.mesh('mesh1').stat.selection.geom(3);`
     - This line selects geometry entity number 3 for meshing. In COMSOL, the `.stat` property is used for setting up the meshing parameters, and `.selection.geom` specifies which geometric entity to select. The number `3` refers to a specific domain or boundary within the geometry of the model.

   - `model.mesh('mesh1').stat.selection.set([3 6 9 12 15 16 17 18 19 20 22 23 24 25 30 31 32 33 34 35 36 43 44 45 46 50 51 52 56 58 62 63 64 68 69 70 75 76 77 78 79 80]);`
     - This line sets a list of geometric entities to be included in the mesh. The `.set` function is used to specify an array of entity numbers that will be meshed. Each number in the array corresponds to a specific domain or boundary within the geometry. By selecting these entities, the user is specifying which parts of the geometry will be discretized during the meshing process.

3. **COMSOL Context**: In COMSOL, the meshing process is crucial for creating a numerical representation of the model's geometry that can be used for simulations. The `model.mesh` command is used to access the mesh settings for a particular mesh operation named 'mesh1'. The `stat.selection` property is used to specify which geometric entities will be included in the mesh. This is important because the mesh quality can significantly affect the accuracy and computational efficiency of the simulation.

4. **Physical Meaning**: In the context of a physical simulation, meshing is the process of dividing the geometry into small, simple elements (like tetrahedra or hexahedra) that can be used to approximate the solution of the physical problem. By selecting specific geometric entities for meshing, the user is defining which parts of the physical domain will be discretized and included in the simulation. This can be important for accurately capturing the physics of the problem, especially in regions with complex geometry or high gradients in the solution variables.

5. **Dependencies**: This code segment is likely part of a larger modeling workflow in COMSOL. The meshing settings defined here will be used in subsequent steps, such as setting up the physics of the problem, defining boundary conditions, and solving the model. The specific entities selected for meshing may depend on the geometry of the model and the physics being simulated. Other parts of the model, such as the material properties, boundary conditions, and solver settings, may also depend on the meshing settings defined here.

## Segment 25: Solver (Lines 628-645)

### Purpose

This code segment is part of a larger COMSOL model named `biased_resonator_3d_modes`, within the module `MEMS_Module_Actuators_biased_resonator_3d_modes`. The specific purpose of this segment is to configure a solver (`sol2`) for an eigenvalue analysis, which is typically used to find the resonant frequencies and mode shapes of a structure. This is common in simulations of mechanical systems such as resonators, where understanding the vibration characteristics is crucial.

### Step-by-Step Analysis

1. **`model.sol('sol2').study('std2');`**
   - This line selects the study `std2` within the solver `sol2`. Studies in COMSOL are used to define the type of analysis (e.g., stationary, time-dependent, eigenvalue).

2. **`model.sol('sol2').create('st1', 'StudyStep');`**
   - Creates a study step named `st1` of type `StudyStep` within the solver `sol2`. This step is where the analysis settings are defined.

3. **`model.sol('sol2').feature('st1').set('study', 'std2');`**
   - Associates the study step `st1` with the study `std2`.

4. **`model.sol('sol2').feature('st1').set('studystep', 'eig');`**
   - Sets the type of study step to `eig`, indicating that this step is for an eigenvalue analysis.

5. **`model.sol('sol2').create('v1', 'Variables');`**
   - Creates a `Variables` feature named `v1` within the solver `sol2`. This is used to define the variables involved in the analysis, such as displacement fields.

6. **`model.sol('sol2').feature('v1').feature('comp1_spatial_disp').set('scalemethod', 'manual');`**
   - Configures the scaling method for the variable `comp1_spatial_disp` (likely representing a spatial displacement component) to `manual`. This means the scaling factor is set explicitly.

7. **`model.sol('sol2').feature('v1').feature('comp1_u').set('scalemethod', 'manual');`**
   - Similar to the previous line, but for the variable `comp1_u` (possibly the displacement in the x-direction).

8. **`model.sol('sol2').feature('v1').feature('comp1_spatial_disp').set('scaleval', '1e-2*7.886019274640408E-5');`**
   - Sets the manual scaling value for `comp1_spatial_disp` to `1e-2*7.886019274640408E-5`. This scaling is important for ensuring numerical stability and convergence in the solver.

9. **`model.sol('sol2').feature('v1').feature('comp1_u').set('scaleval', '1e-2*7.886019274640408E-5');`**
   - Sets the same scaling value for `comp1_u`.

10. **`model.sol('sol2').feature('v1').set('control', 'eig');`**
    - Sets the control variable for the `Variables` feature to `eig`, indicating that the variables are controlled by the eigenvalue solver.

11. **`model.sol('sol2').create('e1', 'Eigenvalue');`**
    - Creates an `Eigenvalue` analysis feature named `e1` within the solver `sol2`.

12. **`model.sol('sol2').feature('e1').set('eigvfunscale', 'maximum');`**
    - Sets the scaling method for the eigenfunction to `maximum`. This determines how the eigenfunctions (mode shapes) are normalized.

13. **`model.sol('sol2').feature('e1').set('eigvfunscaleparam', '7.89E-11');`**
    - Sets a specific parameter value for the eigenfunction scaling. This value likely has physical significance related to the expected magnitude of the eigenfunctions.

14. **`model.sol('sol2').feature('e1').set('storelinpoint', true);`**
    - Configures the solver to store linearization points. This is useful for post-processing and analyzing the sensitivity of the eigenvalues to model parameters.

15. **`model.sol('sol2').feature('e1').set('control', 'eig');`**
    - Sets the control for the `Eigenvalue` feature to `eig`, ensuring it is part of the eigenvalue analysis.

16. **`model.sol('sol2').feature('e1').feature('aDef').set('cachepattern', true);`**
    - Configures caching of the pattern for the eigenvalue analysis, which can improve computational efficiency by reusing previously computed results.

17. **`model.sol('sol2').attach('std2');`**
    - Attaches the solver `sol2` to the study `std2`, finalizing the configuration and making the solver settings part of the study.

### COMSOL Context

The code uses COMSOL's MATLAB API to interact with the model. Commands like `model.sol()`, `create()`, `set()`, and `attach()` are part of COMSOL's scripting language, which allows for programmatic model configuration. This is particularly useful for complex models where manual configuration would be time-consuming or error-prone.

### Physical Meaning

This segment is configuring an eigenvalue analysis to find the resonant frequencies and mode shapes of a biased resonator in a 3D model. The physical meaning is tied to understanding how the resonator vibrates at different frequencies and identifying critical modes that could affect the device's performance or reliability.

### Dependencies

This segment is likely dependent on previous definitions of the geometry, materials, and boundary conditions of the resonator model. The eigenvalue solver's configuration relies on these definitions to accurately represent the physical system. Additionally, the choice of scaling factors and other parameters may be informed by the expected operating conditions or previous simulation results. The results from this solver may also be used in subsequent analyses, such as studying the device's response to external excitations or optimizing the design for specific performance criteria.

## Segment 26: Study (Lines 646-648)

This COMSOL MATLAB code segment is part of a larger model named "biased_resonator_3d_modes" within the module "MEMS_Module_Actuators_biased_resonator_3d_modes". The segment is from a study, specifically lines 646-648. Let's analyze it in detail:

### Purpose
The purpose of this code segment is to configure a study named "std2" within the COMSOL model. The study is being labeled as "Unbiased Eigenfrequency" and is set to not generate plots by default.

### Step-by-Step Analysis

#### Line 1: `model.study('std2').label('Unbiased Eigenfrequency');`
- **Command**: `model.study('std2')` selects the study named "std2" within the model.
- **Action**: `.label('Unbiased Eigenfrequency')` sets the label of the study to "Unbiased Eigenfrequency".
- **Contribution**: This line gives a descriptive name to the study, which helps in identifying the purpose of the study within the model. In this case, it suggests that the study is focused on finding the eigenfrequencies of the resonator when it is unbiased.

#### Line 2: `model.study('std2').setGenPlots(false);`
- **Command**: `model.study('std2')` again selects the study named "std2".
- **Action**: `.setGenPlots(false)` sets the generation of plots for this study to "false", meaning no plots will be automatically generated when this study is run.
- **Contribution**: This line configures the study to suppress the automatic generation of plots. This could be for various reasons, such as reducing computational overhead or because the plots are not necessary for the analysis being performed.

### COMSOL Context
In COMSOL, studies are used to define the type of analysis to be performed on a model, such as stationary, time-dependent, or eigenfrequency analysis. The `model.study` command is used to access and configure these studies. The `label` property is used to give a meaningful name to the study, and the `setGenPlots` method is used to control the automatic generation of plots, which can include results such as displacement, stress, or mode shapes.

### Physical Meaning
In the context of a biased resonator 3D modes analysis, this study likely aims to compute the resonant frequencies (eigenfrequencies) of the structure when it is in an unbiased state. This is important for understanding the dynamic behavior of the resonator and can be used to predict its response to various excitations.

### Dependencies
This segment is part of a larger model and is likely dependent on other parts, such as the geometry definition, material properties, boundary conditions, and mesh settings. The results of this study may also be used in subsequent analyses or for post-processing to visualize the mode shapes or to couple with other physics.

In summary, this code segment is configuring a study in COMSOL to analyze the unbiased eigenfrequencies of a resonator, labeling it appropriately, and disabling the automatic generation of plots. This study is part of a larger effort to understand the dynamic behavior of the resonator and may interact with other components of the model.

## Segment 27: Mesh (Lines 649-651)

This COMSOL MATLAB code segment is part of a larger model named "biased_resonator_3d_modes" within the "MEMS_Module_Actuators_biased_resonator_3d_modes" module. The segment is categorized under the "mesh" type, indicating that it is related to the meshing process of the model geometry. The specific lines of code, 649-651, are focused on selecting certain geometric entities for meshing purposes. Let's break down the code segment in detail:

### Line 649:
```matlab
model.mesh('mesh1').stat.selection.geom(3);
```
- **Purpose**: This line is selecting a specific geometric entity for further meshing operations.
- **Command Explanation**: The `model.mesh('mesh1')` command accesses the mesh settings named 'mesh1' within the current model. The `.stat.selection.geom(3)` part specifies that the selection is being made in the geometry of the model, and the argument `3` indicates that the third geometric entity (which could be a domain, boundary, or point, depending on the geometry) is being selected.
- **Contribution to Modeling Goal**: By selecting a specific geometric entity, the modeler can apply different mesh settings to different parts of the geometry, allowing for more control over the mesh density and quality in critical areas of the model.

### Line 650-651:
```matlab
model.mesh('mesh1').stat.selection.set([3 6 9 12 15 16 17 18 19 20 22 23 24 25 30 31 32 33 34 35 36 43 44 45 46 50 51 52 56 58 62 63 64 68 69 70 75 76 77 78 79 80]);
```
- **Purpose**: These lines are setting a more complex selection of geometric entities for meshing.
- **Command Explanation**: Similar to the previous line, `model.mesh('mesh1').stat.selection.set([...])` is used to define a custom selection of geometric entities. The array of numbers within the square brackets represents the indices of the geometric entities to be selected. This selection could be used to apply specific mesh settings to these entities.
- **Contribution to Modeling Goal**: By specifying a detailed selection of geometric entities, the modeler can fine-tune the mesh to ensure that the critical areas of the model are meshed with appropriate density and quality, which is crucial for accurate simulation results.

### COMSOL Context:
- The `model.mesh('mesh1')` syntax is specific to COMSOL and is used to access and modify the mesh settings of the model.
- The `.stat.selection.geom()` and `.stat.selection.set()` commands are part of COMSOL's meshing interface, allowing for the selection of geometric entities for meshing operations.

### Physical Meaning:
- This code segment is directly related to the discretization of the model geometry into a finite element mesh. The mesh is a fundamental component of finite element analysis (FEA), as it defines the set of elements used to approximate the solution of the physical problem being modeled.

### Dependencies:
- This segment is likely dependent on previous definitions of the geometry and the mesh settings within the model.
- The effectiveness of this segment relies on the correct identification of geometric entities, which in turn depends on the geometry construction and numbering.
- Subsequent steps in the modeling process, such as setting up the physics of the problem, defining boundary conditions, and solving the model, will rely on the mesh generated based on these selections.

In summary, this code segment is a critical part of the meshing process in COMSOL, allowing for detailed control over the mesh density and quality in specific areas of the model geometry. This level of control is essential for ensuring accurate and efficient simulations, especially in complex models where different regions may require different levels of mesh refinement.

## Segment 28: Solver (Lines 652-675)

### Purpose

This COMSOL MATLAB code segment is configuring a solver for a biased resonator 3D modes study. It sets up an eigenvalue analysis to compute the resonant frequencies and mode shapes of a structure under certain biasing conditions. The solver is part of a larger model named `biased_resonator_3d_modes` within the `MEMS_Module_Actuators_biased_resonator_3d_modes` module.

### Step-by-Step Analysis

1. **Select Study and Remove Features**:
   - `model.sol('sol2').study('std2');` selects the study `std2` for the solver `sol2`.
   - The following three lines remove existing features `e1`, `v1`, and `st1` from the solver configuration. This is likely done to clear previous settings before reconfiguring the solver.

2. **Create Study Step**:
   - `model.sol('sol2').create('st1', 'StudyStep');` creates a new study step named `st1` for the eigenvalue analysis.
   - `model.sol('sol2').feature('st1').set('study', 'std2');` associates the study step with the previously selected study `std2`.
   - `model.sol('sol2').feature('st1').set('studystep', 'eig');` specifies that this study step is for an eigenvalue problem.

3. **Configure Variables**:
   - `model.sol('sol2').create('v1', 'Variables');` creates a variables feature `v1` for defining the scale of the solution variables.
   - The subsequent lines set the scaling method to 'manual' for the spatial displacement (`comp1_spatial_disp`) and the displacement field (`comp1_u`).
   - `model.sol('sol2').feature('v1').feature('comp1_spatial_disp').set('scaleval', '1e-2*7.886019274640408E-5');` and a similar line for `comp1_u` set the scale values for these variables. The scale values are chosen based on the expected order of magnitude of the solution to aid in numerical stability and convergence.

4. **Create Eigenvalue Solver**:
   - `model.sol('sol2').create('e1', 'Eigenvalue');` creates an eigenvalue solver feature `e1`.
   - `model.sol('sol2').feature('e1').set('eigvfunscale', 'maximum');` sets the eigenvalue function scaling to 'maximum', which means the eigenvalue corresponding to the maximum eigenfunction value will be computed.
   - `model.sol('sol2').feature('e1').set('eigvfunscaleparam', '7.89E-11');` sets a specific parameter for the eigenvalue function scaling, which is related to the physical properties of the resonator.
   - `model.sol('sol2').feature('e1').set('storelinpoint', true);` enables storing linearization points, which can be used for nonlinear analysis or sensitivity studies.
   - `model.sol('sol2').feature('e1').feature('aDef').set('cachepattern', true);` sets caching of the pattern for the eigenvalue solver, which can improve computational efficiency.

5. **Run Solver and Post-Processing**:
   - `model.sol('sol2').attach('std2');` attaches the solver to the study `std2`.
   - `model.sol('sol2').runAll;` runs the solver with the configured settings.
   - The last two lines configure the result dataset and create a 3D plot group for visualization of the results.

### COMSOL Context

The code uses COMSOL's MATLAB API to interact with the model. Commands like `model.sol`, `feature`, and `set` are part of COMSOL's scripting language, which allows for programmatic manipulation of the model, solver, and study settings. The `eig` study step is specific to eigenvalue problems, which are common in resonator analysis to find natural frequencies and mode shapes.

### Physical Meaning

This code sets up an eigenvalue analysis for a biased resonator, which could represent a microelectromechanical system (MEMS) device or any structure that resonates at specific frequencies due to its geometry and material properties. The biasing refers to an initial stress or electric field that influences the resonant behavior. The eigenvalues correspond to the resonant frequencies, and the eigenfunctions (mode shapes) describe the deformation pattern at each frequency.

### Dependencies

This segment is part of a larger model and depends on the correct setup of the geometry, material properties, and boundary conditions of the resonator. The biasing conditions must be defined elsewhere in the model. The results from this solver may be used in subsequent analyses, such as evaluating the device performance or conducting parametric studies to optimize the design.

## Segment 29: Results (Lines 676-691)

1. **Purpose**: This code segment is designed to post-process and visualize the results of a COMSOL simulation, specifically for a biased resonator's 3D modes. It sets up a results dataset, creates a volume plot of the displacement magnitude, applies deformation scaling for better visualization, and sets up study settings for different bias levels.

2. **Step-by-Step Analysis**:

   - `model.result('pg5').run;`: This line runs the result sequence 'pg5', which is likely a post-processing sequence that has been previously defined in the COMSOL model. Running this sequence is necessary to generate the data needed for the subsequent operations.

   - `model.result('pg5').set('data', 'dset2');`: This sets the data source for the result sequence to 'dset2', which is presumably a dataset containing the solution data for the simulation. This dataset could be a selection or a combination of the computed fields from the study.

   - `model.result('pg5').create('vol1', 'Volume');`: This command creates a new 3D volume plot in the result sequence named 'vol1'. Volume plots are used to visualize scalar fields in 3D space.

   - `model.result('pg5').feature('vol1').set('expr', 'solid.disp');`: This sets the expression for the volume plot to 'solid.disp', which represents the displacement field in the solid mechanics physics interface. This will visualize the magnitude of displacement in the structure.

   - `model.result('pg5').feature('vol1').set('descr', 'Displacement magnitude');`: This sets the description of the volume plot to 'Displacement magnitude', which will appear in the COMSOL GUI and help to identify what the plot represents.

   - `model.result('pg5').feature('vol1').set('colorlegend', false);`: This disables the color legend for the volume plot. The color legend is a color scale that indicates the range of values in the plot.

   - `model.result('pg5').feature('vol1').create('def1', 'Deform');`: This creates a deformation plot named 'def1' within the volume plot. A deformation plot is used to visualize the deformation of the geometry based on the displacement field.

   - `model.result('pg5').run;`: This line runs the result sequence again, which is necessary to update the visualization with the newly created volume and deformation plots.

   - `model.result('pg5').run;`: This line runs the result sequence once more, possibly to ensure that all visualizations are up to date. It is not clear why this line is repeated immediately, but it could be for redundancy or to ensure that the previous run has completed.

   - `model.result('pg5').label('Unbiased Modes');`: This sets the label for the result sequence to 'Unbiased Modes', which could indicate that this sequence is visualizing the modes of the resonator without any biasing effects applied.

   - `model.result('pg5').set('looplevel', [2]);`: This sets the 'looplevel' parameter of the result sequence to 2. 'looplevel' could be a custom parameter that controls the level of detail or the specific mode being visualized. The exact meaning of this parameter depends on how it is used within the result sequence.

   - `model.result('pg5').run;`: This runs the result sequence with the updated 'looplevel' parameter.

   - `model.result('pg5').set('looplevel', [3]);`: Similar to the previous 'looplevel' setting, this sets the parameter to 3, possibly to visualize a different mode or level of detail.

   - `model.result('pg5').run;`: This runs the result sequence again with the new 'looplevel' setting.

   - `model.study.create('std3');`: This creates a new study in the model named 'std3'. Studies in COMSOL are used to define the solver settings and parameters for running the simulation. The purpose of this new study is not clear from the provided code segment but could be for running a different analysis or for a different set of parameters.

3. **COMSOL Context**: The code uses COMSOL's MATLAB API to interact with the model. The `model` object represents the COMSOL model, and the `result` object is used to post-process and visualize the simulation results. The `feature` and `set` methods are used to configure the plots and set parameters, respectively.

4. **Physical Meaning**: This code segment is visualizing the displacement field in a biased resonator structure. The displacement magnitude represents how much the structure deforms from its original position due to the applied loads or boundary conditions. By visualizing different modes (potentially different resonant frequencies or vibration shapes), the analyst can gain insights into the behavior of the resonator under various biasing conditions.

5. **Dependencies**: This code segment depends on the previous setup of the model, including the definition of the geometry, physics, mesh, and solver settings. The dataset 'dset2' must have been generated from a previous study or solution step. The result sequence 'pg5' must also have been defined earlier in the script. The new study 'std3' that is created at the end may depend on the results obtained from this post-processing sequence.

## Segment 30: Study (Lines 692-730)

This COMSOL MATLAB code segment is creating and configuring a study named "std3" for the model "biased_resonator_3d_modes" within the module "MEMS_Module_Actuators_biased_resonator_3d_modes". The study consists of two analysis types: a stationary study ('stat') and an eigenfrequency study ('eig'). Additionally, a parametric study is set up to vary a parameter 'Vdc'. The code then creates a solution sequence ('sol3') to solve the studies. Here's a detailed, step-by-step analysis:

1. **Purpose**: The code aims to set up a COMSOL model to analyze the stationary behavior and eigenfrequencies of a biased resonator in a 3D space. It also incorporates a parametric sweep to study the effects of varying a DC voltage ('Vdc') on the resonator's behavior.

2. **Step-by-Step Analysis**:

   - `model.study('std3').create('stat', 'Stationary');`: Creates a stationary study named 'stat' within the 'std3' study. This study will analyze the static behavior of the model.
   
   - `model.study('std3').feature('stat').set('plotgroup', 'Default');`: Sets the plot group for the stationary study to 'Default'.
   
   - `model.study('std3').feature('stat').set('outputmap', {});`: Specifies an empty output map for the stationary study, indicating no special output settings.
   
   - `model.study('std3').feature('stat').set('ngenAUX', '1');` and similar lines: These lines set various solver parameters for the stationary study, such as the number of generations for the adaptive mesh refinement ('ngenAUX') and the goal number of generations ('goalngenAUX'). These settings control the mesh refinement process during the solution phase.
   
   - `model.study('std3').feature('stat').setSolveFor('/physics/solid', true);` and similar lines: These lines specify which physics interfaces should be solved in the stationary study. In this case, the solid mechanics ('/physics/solid'), electrostatics ('/physics/es'), and multiphysics electromechanics ('/multiphysics/eme1') interfaces are set to be solved.
   
   - `model.study('std3').create('eig', 'Eigenfrequency');`: Creates an eigenfrequency study named 'eig' within the 'std3' study. This study will compute the resonant frequencies and mode shapes of the structure.
   
   - `model.study('std3').feature('eig').set('shift', '1[Hz]');`: Sets the shift value for the eigenfrequency study to '1 Hz'. This parameter is used to shift the computed eigenfrequencies away from zero to avoid numerical issues.
   
   - `model.study('std3').feature('eig').set('chkeigregion', true);`: Enables the check of the eigenfrequency region, ensuring that the computed eigenfrequencies fall within the specified range.
   
   - `model.study('std3').feature('eig').set('conrad', '1');` and similar lines: These lines set various solver parameters for the eigenfrequency study, such as the convergence ratio ('conrad') and the convergence ratio for the damped eigenfrequency analysis ('conradynhm').
   
   - `model.study('std3').feature('eig').set('storefact', false);`: Disables the storage of factorization data for the eigenfrequency study, reducing memory usage.
   
   - `model.study('std3').feature('eig').set('outputmap', {});`: Specifies an empty output map for the eigenfrequency study, indicating no special output settings.
   
   - `model.study('std3').feature('eig').setSolveFor('/physics/solid', true);` and similar lines: These lines specify which physics interfaces should be solved in the eigenfrequency study, similar to the stationary study.
   
   - `model.study('std3').label('Biased Eigenfrequency');`: Sets the label for the 'std3' study to "Biased Eigenfrequency".
   
   - `model.study('std3').create('param', 'Parametric');`: Creates a parametric study named 'param' within the 'std3' study. This study will vary the 'Vdc' parameter and analyze its effect on the resonator's behavior.
   
   - `model.study('std3').feature('param').setIndex('pname', 'Vdc', 0);` and similar lines: These lines set the name ('pname'), value list ('plistarr'), and unit ('punit') for the 'Vdc' parameter in the parametric study. The value list is initially set to an empty string and then updated to a range of values from 5 to 45.
   
   - `model.study('std3').feature('eig').set('neigsactive', true);`: Enables the computation of eigenfrequencies in the 'eig' study.
   
   - `model.study('std3').feature('eig').set('neigs', 1);`: Sets the number of eigenfrequencies to compute in the 'eig' study to 1.
   
   - `model.sol.create('sol3');`: Creates a solution sequence named 'sol3' to solve the studies defined in the 'std3' study.

3. **COMSOL Context**: The code uses COMSOL-specific commands to create and configure studies, set solver parameters, and define physics interfaces to be solved. The studies are created using the `create` method, and their properties are set using the `set` method. The physics interfaces are specified using their respective paths, such as '/physics/solid' for solid mechanics and '/physics/es' for electrostatics.

4. **Physical Meaning**: This code segment sets up a COMSOL model to study the behavior of a biased resonator in a 3D space. The stationary study analyzes the static behavior of the resonator, while the eigenfrequency study computes its resonant frequencies and mode shapes. The parametric study investigates the effect of varying the DC voltage ('Vdc') on the resonator's behavior.

5. **Dependencies**: This code segment is part of a larger COMSOL model and relies on the proper definition of the geometry, mesh, physics interfaces, and boundary conditions. The studies created in this segment will use the settings and parameters defined in other parts of the model to compute the desired results. The solution sequence 'sol3' will be executed to solve the studies and generate the output data for further analysis.

## Segment 31: Mesh (Lines 731-735)

1. **Purpose**: This code segment is used to define a specific mesh selection for a geometry within a COMSOL Multiphysics model named "biased_resonator_3d_modes". The mesh selection is likely being set up to apply certain mesh settings or to define a subdomain for the simulation.

2. **Step-by-Step Analysis**:

   Line 731:
   ```matlab
   model.mesh('mesh1').stat.selection.geom(3);
   ```
   - This line selects geometry entity 3 within the model's mesh named 'mesh1'. The `stat.selection.geom` method is used to specify which geometric entity the subsequent operations will apply to. In this case, it is preparing to set a selection on geometry entity 3.

   Line 732:
   ```matlab
   model.mesh('mesh1').stat.selection.set([3 6 9 12 15 16 17 18 19 20 22 23 24 25 30 31 32 33 34 35 36 43 44 45 46 50 51 52 56 58 62 63 64 68 69 70 75 76 77 78 79 80]);
   ```
   - This line sets a specific selection of mesh elements within the previously selected geometry entity 3. The `selection.set` method is used to define an array of indices that correspond to specific mesh elements. These elements are being selected for a particular purpose, such as applying a finer mesh or defining a subdomain for the simulation.

   Line 733:
   ```matlab
   model.mesh('mesh1').stat.selection.geom(3);
   ```
   - This line is a repetition of line 731, again selecting geometry entity 3. It is unclear why this line is repeated unless it is to ensure that the geometry entity is selected before the next operation. However, it is redundant given the previous selection.

   Line 734:
   ```matlab
   model.mesh('mesh1').stat.selection.set([3 6 9 12 15 16 17 18 19 20 22 23 24 25 30 31 32 33 34 35 36 43 44 45 46 50 51 52 56 58 62 63 64 68 69 70 75 76 77 78 79 80]);
   ```
   - This line is identical to line 732 and sets the same selection of mesh elements within geometry entity 3. The repetition of this line suggests that it might be an error or an unnecessary duplication unless there is an intermediate operation not shown here that would justify reapplying the selection.

3. **COMSOL Context**: The commands used in this code segment are specific to the COMSOL Multiphysics software and its MATLAB API. The `model.mesh` method is used to access the mesh settings of the model, and the `stat.selection` object is used to define selections of mesh elements within a geometry. These selections can be used for various purposes, such as refining the mesh in specific areas or defining subdomains for different material properties or boundary conditions.

4. **Physical Meaning**: In the context of the physical simulation, this code segment is defining a specific set of mesh elements within a certain geometric entity (entity 3). The selection of these elements could be used to apply a more detailed mesh in critical areas of the model, which can affect the accuracy of the simulation results. The physical interpretation depends on the geometry and physics of the "biased_resonator_3d_modes" model.

5. **Dependencies**: This code segment is likely part of a larger modeling workflow within COMSOL. The mesh selection defined here may be used in subsequent steps to apply material properties, boundary conditions, or mesh refinements. The specific indices selected (3, 6, 9, etc.) are probably determined based on the geometry and the desired simulation accuracy in those regions. The overall model setup, including the physics being simulated and the geometry being modeled, would influence the choice of these mesh elements.

## Segment 32: Solver (Lines 736-837)

### Purpose

This code segment is part of a COMSOL Multiphysics model, specifically tailored for a biased resonator 3D modes analysis. The segment sets up a solver sequence that includes a stationary study step followed by an eigenvalue study step. It configures the solver settings for the electrical and mechanical parts of the model, sets up the solution storage, and defines a parametric sweep to analyze the model's behavior over a range of applied DC bias voltages.

### Step-by-Step Analysis

1. **Model Setup for Study 'std3'**:
   - `model.sol('sol3').study('std3');` associates the solution 'sol3' with a study named 'std3'.
   - `model.sol('sol3').create('st1', 'StudyStep');` creates a study step 'st1' in 'sol3'.
   - Subsequent lines configure the study step type as stationary (`stat`).

2. **Variables Scaling**:
   - `model.sol('sol3').create('v1', 'Variables');` creates a Variables feature 'v1'.
   - Scaling methods and values are set for 'comp1_spatial_disp' and 'comp1_u', which likely represent spatial displacement and electrical potential, respectively. The scaling values are set to a specific value (`1e-2*7.886019274640408E-5`), which could be based on expected magnitudes of the variables to improve solver performance.

3. **Stationary Solver Configuration**:
   - `model.sol('sol3').create('s1', 'Stationary');` creates a stationary solver 's1'.
   - Various features such as segregated solver ('se1'), direct solver ('d1'), and iterative solver ('i1') are created and configured. These solvers are used to solve different parts of the problem (electric potential, displacement field, and spatial mesh displacement).
   - Parameters like linear solver, stabilization, and multigrid settings are specified to optimize the solver performance and stability.

4. **Eigenvalue Solver Configuration**:
   - `model.sol('sol3').create('st2', 'StudyStep');` creates another study step 'st2' for the eigenvalue analysis.
   - Variables scaling and initialization methods are set, indicating that the eigenvalue solver will use the results from the stationary solver as its starting point.
   - The eigenvalue solver settings, such as the scale factor for eigenvalue function and storage of linear points, are defined.

5. **Parametric Sweep Setup**:
   - `model.batch.create('p1', 'Parametric');` creates a parametric sweep named 'p1'.
   - The sweep is configured to vary the parameter 'Vdc' over a specified range, and it's set to use the solution sequence 'sol3'.
   - Settings for solution storage, clearing previous solutions, and error handling are specified.

6. **Final Adjustments**:
   - The scaling methods for 'comp1_spatial_disp' and 'comp1_u' are set back to 'auto', likely to revert to default behavior after the specific settings used for the stationary solver.

### COMSOL Context

- **Study and Solver Configuration**: COMSOL uses a hierarchical structure to organize studies and solvers. This code sets up a study with a stationary solver followed by an eigenvalue solver, which is a common approach for analyzing resonant systems.
- **Solver Types**: The use of segregated, direct, and iterative solvers reflects the multifaceted nature of the problem, involving both electrical and mechanical fields.
- **Parametric Sweep**: This is a powerful feature in COMSOL for studying the model's response to changes in parameters, here applied to the DC bias voltage.

### Physical Meaning

This code is part of a simulation that models a resonator, possibly a microelectromechanical system (MEMS) device, under the influence of a DC bias voltage. The stationary solver step might be used to find the static equilibrium of the device under the applied voltage, while the eigenvalue solver step is used to find the resonant frequencies and mode shapes of the device at this equilibrium.

### Dependencies

This segment is likely part of a larger model definition that includes the geometry, mesh, material properties, and boundary conditions of the resonator. The solver settings and parametric sweep are dependent on the physics of the problem, which dictates the need for both electrical and mechanical solvers. The choice of solver settings and scaling factors may also be influenced by the expected range of values for the variables, which in turn depends on the material properties and dimensions of the resonator.

## Segment 33: Study (Lines 838-840)

### Purpose

This code segment is part of a COMSOL Multiphysics model, specifically tailored for simulating a biased resonator's 3D modes. The segment's primary purpose is to configure the study settings and create a new solution sequence for the model named 'biased_resonator_3d_modes'. This is crucial for setting up the simulation to solve for specific physics phenomena within the defined geometry and mesh, under a set of constraints and boundary conditions that represent the biased resonator.

### Step-by-Step Analysis

#### Line 1: `model.study('std3').setGenPlots(false);`
- **Command**: `model.study('std3')` selects the study named 'std3' within the model. Studies in COMSOL are used to define how the model is solved, including the type of solver and the study settings.
- **Action**: `.setGenPlots(false)` configures the study to not generate default plots automatically after solving. This can be useful for reducing computational overhead or when custom plots are preferred.
- **Contribution**: This line ensures that the study 'std3' is set up to run efficiently by not generating plots that may not be necessary for the analysis at hand.

#### Line 2: `model.sol.create('sol5');`
- **Command**: `model.sol` refers to the solutions section of the model, where different solution sequences can be defined.
- **Action**: `.create('sol5')` creates a new solution sequence named 'sol5'. Solution sequences in COMSOL are used to define the steps that COMSOL should take to solve the model, including the solver settings, output, and any study extensions.
- **Contribution**: This line sets up a new solution sequence, which will be used to solve the model according to the settings defined within 'sol5'. This is a critical step in preparing the model for simulation, as it dictates how the solver will approach the problem.

### COMSOL Context

- **Studies**: In COMSOL, studies are used to define the type of analysis (e.g., stationary, time-dependent, eigenvalue, etc.) and the solver settings. Configuring a study properly is essential for obtaining accurate and efficient solutions.
- **Solutions**: Solution sequences define the steps COMSOL takes to solve the physics of the model. This includes specifying the solver type, tolerances, and other settings that affect how the model is solved and the results that are produced.

### Physical Meaning

This code segment does not directly relate to the physical phenomena being simulated (such as structural mechanics, electromagnetics, etc.). Instead, it sets up the computational framework within which the physical simulation will be performed. The study and solution settings are abstract, computational aspects that support the underlying physics but do not represent physical quantities themselves.

### Dependencies

This segment is intimately connected with other parts of the model, including:
- **Geometry and Mesh**: The solution sequence will operate on the meshed geometry of the model. The quality and size of the mesh can significantly affect the solution process.
- **Physics Settings**: The actual physical phenomena being modeled (e.g., solid mechanics, electrostatics) and their respective settings will dictate the type of study and solution sequence required.
- **Material Properties and Boundary Conditions**: These define the physical behavior of the model and are essential for the solver to compute the solution accurately.
- **Previous Solution Sequences**: The settings for 'sol5' may depend on the results or settings from previous solution sequences, especially if it is intended to continue or extend a previous analysis.

In summary, while this code segment focuses on the computational setup, its effectiveness is contingent upon the accurate representation of the physical system and the interplay between the model's geometry, physics, and solver settings.

## Segment 34: Solver (Lines 841-847)

### Purpose

This COMSOL MATLAB code segment is designed to solve a specific study within a model, execute a parametric sweep, and then create a plot group to visualize the results of the parametric solutions. It is part of a larger model named `biased_resonator_3d_modes`, which likely simulates the behavior of a resonator under various bias conditions in a 3D space. The segment specifically deals with setting up and running a parametric analysis and post-processing the results for visualization.

### Step-by-Step Analysis

#### Line 1: `model.sol('sol5').study('std3');`

- **Command**: This line sets the focus on a specific solution named `'sol5'` within the model and associates it with a study labeled `'std3'`.
- **Purpose**: It prepares the model to work with a particular solution configuration, where `'std3'` could represent a study that involves varying certain parameters to observe their effects on the resonator's behavior.

#### Line 2: `model.sol('sol5').label('Parametric Solutions 1');`

- **Command**: This line labels the solution `'sol5'` as `'Parametric Solutions 1'`.
- **Purpose**: The label provides a human-readable description of what this solution represents, which is useful for understanding the output and managing the model's various components.

#### Line 3: `model.batch('p1').feature('so1').set('psol', 'sol5');`

- **Command**: This line configures a batch sweep named `'p1'` by setting its feature `'so1'` to use the parametric solution `'sol5'`.
- **Purpose**: It links the batch sweep process to the specific solution setup earlier, ensuring that the parametric study will be executed based on the configurations defined in `'sol5'`.

#### Line 4: `model.batch('p1').run('compute');`

- **Command**: This line runs the computation for the batch sweep `'p1'`.
- **Purpose**: It initiates the actual parametric analysis, where the model computes the results across the range of parameters defined in the sweep.

#### Line 5: `model.result.create('pg6', 'PlotGroup1D');`

- **Command**: This line creates a new result object named `'pg6'` of type `'PlotGroup1D'`.
- **Purpose**: It sets up a container for 1D plot results, which will be used to visualize the outcomes of the parametric analysis, making it easier to interpret the effects of varying parameters on the model's behavior.

### COMSOL Context

- **Solution and Study**: COMSOL uses the concept of solutions and studies to organize the computational process. A solution (`sol`) defines how to solve the model (e.g., which methods to use, how to apply them), while a study (`std`) organizes the sequence of solutions to be computed.
- **Batch Sweeps**: The batch (`batch`) command is used for running parametric sweeps, where a range of parameter values is defined, and the model is solved for each combination of parameters.
- **Results and Plot Groups**: After computation, results can be visualized using plot groups. `PlotGroup1D` is a specific type of plot for visualizing 1D data, such as graphs of parameter values against a result variable.

### Physical Meaning

In the context of a biased resonator, this code segment represents the computational steps to analyze how the resonator's modes (e.g., frequencies, mode shapes) change with varying bias conditions. The parametric sweep could be varying the bias voltage or mechanical stress, and the resulting plots would show how these changes affect the resonator's performance, such as shifts in resonance frequencies or changes in mode shapes.

### Dependencies

This code segment is part of a larger modeling workflow and depends on:

- **Preceding Definitions**: Earlier definitions in the model setup, including geometry, materials, physics settings, and meshing, which collectively define the resonator's physical and operational characteristics.
- **Parameter Sweep Setup**: The specific parameters and their ranges for the batch sweep must be defined elsewhere in the script or model setup.
- **Post-Processing**: After this segment, additional commands might be used to customize the plot's appearance, extract specific data points, or perform further analysis on the computed results.

In summary, this segment is a critical part of the modeling process, bridging the setup of the physical model with the analysis and visualization of its behavior under varying conditions.

## Segment 35: Results (Lines 848-895)

1. **Purpose**: This code segment is designed to post-process and visualize the results of a COMSOL simulation, specifically for a model named "biased_resonator_3d_modes". The goal is to create a graph that shows the relationship between the eigenfrequency (resonant frequency) of a MEMS resonator and the applied DC voltage bias. The code sets up the graph properties, including titles, labels, and data sources, and it also adds data points and a global dataset to the graph for comparison.

2. **Step-by-Step Analysis**:

- `model.result('pg6').run;`: This line runs the result object 'pg6' which is likely a plot or graph that has been previously defined in the model.
  
- `model.result('pg6').set('data', 'dset5');`: Sets the data source for the result object 'pg6' to dataset 'dset5'. This dataset probably contains the simulation results for the eigenfrequencies at various DC bias voltages.
  
- `model.result('pg6').create('ptgr1', 'PointGraph');`: Creates a new point graph feature named 'ptgr1' within the result object 'pg6'. This graph will display discrete data points.
  
- `model.result('pg6').feature('ptgr1').set('markerpos', 'datapoints');`: Configures the point graph to place markers at the data points.
  
- `model.result('pg6').feature('ptgr1').set('linewidth', 'preference');`: Sets the line width of the graph to follow the preference settings of COMSOL.
  
- `model.result('pg6').feature('ptgr1').selection.set([1]);`: Selects the first (and possibly only) data series for the point graph.
  
- `model.result('pg6').feature('ptgr1').set('expr', 'solid.freq');`: Sets the expression for the y-axis data to 'solid.freq', which likely represents the resonant frequency of the solid mechanics simulation.
  
- `model.result('pg6').feature('ptgr1').set('xdatasolnumtype', 'outer');`: Sets the type of solution data to use for the x-axis to 'outer', which probably refers to the outer loop of a parameter sweep, in this case, the DC voltage bias.
  
- `model.result('pg6').feature('ptgr1').set('linestyle', 'none');`: Sets the line style to none, so no line will connect the data points.
  
- `model.result('pg6').feature('ptgr1').set('linemarker', 'square');`: Sets the marker style to square for the data points.
  
- `model.result('pg6').feature('ptgr1').set('legend', true);`: Enables the legend for this point graph.
  
- `model.result('pg6').feature('ptgr1').set('legendmethod', 'manual');`: Sets the legend method to manual, allowing custom legend entries.
  
- `model.result('pg6').feature('ptgr1').setIndex('legends', 'COMSOL Solution', 0);`: Sets the manual legend entry for this data series to "COMSOL Solution".
  
- `model.result('pg6').feature.duplicate('ptgr2', 'ptgr1');`: Duplicates the 'ptgr1' point graph feature to create a new feature named 'ptgr2'.
  
- `model.result('pg6').run;`: Runs the result object 'pg6' again, likely to update it with the new features.
  
- `model.result('pg6').feature('ptgr2').set('data', 'dset2');`: Sets the data source for the duplicated point graph 'ptgr2' to dataset 'dset2'. This might be a different set of results or experimental data for comparison.
  
- `model.result('pg6').feature('ptgr2').setIndex('looplevelinput', 'first', 0);`: Sets the loop level input for 'ptgr2' to the first dataset in the loop.
  
- `model.result('pg6').feature('ptgr2').set('linecolor', 'blue');`: Sets the line color for 'ptgr2' to blue, distinguishing it from the original data series.
  
- `model.result('pg6').feature('ptgr2').set('legend', false);`: Disables the legend for 'ptgr2', possibly because it is a comparative dataset and does not need a legend entry.
  
- `model.result('pg6').run;`: Runs the result object 'pg6' again to update the graph with the changes made to 'ptgr2'.
  
- `model.result('pg6').create('glob1', 'Global');`: Creates a new global feature named 'glob1' within the result object 'pg6'. This is likely for adding a global dataset or a constant line to the graph.
  
- `model.result('pg6').feature('glob1').set('markerpos', 'datapoints');`: Sets the marker position for the global feature to the data points.
  
- `model.result('pg6').feature('glob1').set('linewidth', 'preference');`: Sets the line width to follow the preference settings.
  
- `model.result('pg6').feature('glob1').set('data', 'dset5');`: Sets the data source for the global feature to 'dset5'.
  
- `model.result('pg6').feature('glob1').setIndex('looplevelinput', 'manual', 1);`: Sets the loop level input for the global feature to manual and specifies the level as 1.
  
- `model.result('pg6').feature('glob1').setIndex('looplevel', [2 3 4 5 6 7 8 9], 1);`: Sets the loop levels for the global feature to a range of values from 2 to 9 at level 1.
  
- `model.result('pg6').feature('glob1').setIndex('expr', 'int1(Vdc)', 0);`: Sets the expression for the global feature to 'int1(Vdc)', which could be an integral expression involving the DC voltage.
  
- `model.result('pg6').feature('glob1').setIndex('descr', '', 0);`: Sets the description for the global feature to an empty string.
  
- `model.result('pg6').feature('glob1').set('xdatasolnumtype', 'outer');`: Sets the x-axis data solution type to 'outer', similar to the point graph.
  
- `model.result('pg6').feature('glob1').set('xdata', 'expr');`: Sets the x-axis data to be defined by an expression.
  
- `model.result('pg6').feature('glob1').set('xdataexpr', 'Vdc');`: Sets the expression for the x-axis data to 'Vdc', representing the DC voltage bias.
  
- `model.result('pg6').feature('glob1').set('legendmethod', 'manual');`: Sets the legend method for the global feature to manual.
  
- `model.result('pg6').feature('glob1').setIndex('legends', 'Experiment: Bannon et. al.', 0);`: Sets the manual legend entry for the global feature to "Experiment: Bannon et. al.", indicating that this data might represent experimental results for comparison.
  
- `model.result('pg6').run;`: Runs the result object 'pg6' again to update the graph with the global feature.
  
- `model.result('pg6').set('titletype', 'manual');`: Sets the title type for the graph to manual, allowing a custom title to be set.
  
- `model.result('pg6').set('title', 'Eigenfrequency vs. DC voltage');`: Sets the title of the graph to "Eigenfrequency vs. DC voltage".
  
- `model.result('pg6').set('xlabelactive', true);`: Enables the x-axis label.
  
- `model.result('pg6').set('xlabel', 'DC Bias (V)');`: Sets the x-axis label to "DC Bias (V)".
  
- `model.result('pg6').set('ylabelactive', true);`: Enables the y-axis label.
  
- `model.result('pg6').set('ylabel', 'Resonant Frequency (Hz)');`: Sets the y-axis label to "Resonant Frequency (Hz)".
  
- `model.result('pg6').label('Eigenfrequency vs. DC Voltage');`: Adds a label to the graph with the text "Eigenfrequency vs. DC Voltage".
  
- `model.title(['Normal Modes of a Biased Resonator ' native2unicode(hex2dec({'20' '14'}), 'unicode') ' 3D']);`: Sets the title of the model to "Normal Modes of a Biased Resonator ⌴ 3D". The Unicode character is created from hexadecimal values.
  
- `model.description('An electrostatically actuated MEMS resonator is simulated...');`: Sets a description for the model, explaining the physical system being simulated.
  
- `model.mesh.clearMeshes;`: Clears any existing meshes in the model, possibly to regenerate them or to prepare for a new simulation.

3. **COMSOL Context**: The code uses COMSOL's MATLAB API to interact with the model and its result objects. COMSOL-specific commands include `.result()`, `.feature()`, `.set()`, `.create()`, `.selection.set()`, and `.setIndex()`. These commands are used to access result objects, create new graph features, set properties, and configure data sources and expressions.

4. **Physical Meaning**: This code segment is part of a larger simulation of a MEMS resonator, which is a microelectromechanical system that resonates at specific frequencies. The resonator is actuated by an electrostatic force generated by a combination of AC and DC voltage applied across a parallel plate capacitor. The code is specifically analyzing the relationship between the resonant frequency (eigenfrequency) and the applied DC voltage bias. The graph created by this code will help visualize how the resonant frequency changes with varying DC bias, which is important for understanding and designing the behavior of the resonator.

5. **Dependencies**: This code segment is dependent on the existence of datasets 'dset5' and 'dset2', which should contain the simulation and possibly experimental results, respectively. The code also assumes the existence of a result object 'pg6' that has been previously defined in the model. Additionally, the code may be part of a larger script or model that sets up the geometry, physics, mesh, and solver settings for the MEMS resonator simulation. The results generated by this code segment could be used in conjunction with other analyses, such as stress or displacement analyses, to fully characterize the behavior of the resonator.

## Segment 36: Solver (Lines 896-916)

### Purpose

This code segment is responsible for clearing the solution data of multiple solutions (sol1 through sol14) from a COMSOL model named 'biased_resonator_3d_modes'. After clearing the solution data, it labels the model and then defines the model's node label as 'Components'. Finally, the model is assigned to the variable 'out'. The overall goal appears to be preparing the model for a new set of calculations by removing any previously stored solution data, which could be necessary to free up computational resources or to ensure that new simulations start with a clean slate.

### Step-by-Step Analysis

1. **Clearing Solution Data**:
   - `model.sol('sol1').clearSolutionData;`
   - This line clears the solution data associated with the solution named 'sol1' in the COMSOL model. Clearing the solution data means that any previously computed results for this solution are discarded. This is repeated for solutions 'sol2' through 'sol14'. Clearing solution data is essential when re-running simulations with different parameters to ensure that the new results do not get mixed up with the old ones.

2. **Model Labeling**:
   - `model.label('biased_resonator_3d_modes.mph');`
   - This line sets the label of the model to 'biased_resonator_3d_modes.mph'. The label could be used to identify the model within COMSOL's user interface or when saving the model to a file. The '.mph' extension suggests that this label is also setting or reflecting the filename of the model when saved.

3. **Model Node Labeling**:
   - `model.modelNode.label('Components');`
   - Here, the label of the model's node is set to 'Components'. In COMSOL, a model node typically contains all the definitions and settings for the physics, mesh, and study settings. Labeling the model node can help organize and identify different parts of the model, especially when dealing with complex models that have multiple components or physics interfaces.

4. **Assigning Model to Variable**:
   - `out = model;`
   - This line assigns the entire model to the variable 'out'. This could be done to pass the model to another function or script, or to make the model accessible outside the current scope.

### COMSOL Context

The commands used in this code segment are specific to COMSOL's MATLAB scripting interface. COMSOL allows users to automate and extend the functionality of their models using MATLAB scripts. The `model.sol()` function is used to access and manipulate solutions within a model, and the `clearSolutionData` method is used to clear any stored solution data for that specific solution. The `model.label` and `model.modelNode.label` properties are used to set labels for the model and its model node, respectively, which can be useful for organizing and identifying different parts of the model.

### Physical Meaning

In the context of a physical simulation, clearing the solution data means that any previously computed results, such as field distributions, displacements, or eigenfrequencies for a biased resonator, are discarded. This action is often taken before running new simulations with updated parameters or settings, to ensure that the new results accurately reflect the current configuration of the model.

### Dependencies

This code segment is likely part of a larger script or program that sets up, runs, and post-processes a COMSOL model. The clearing of solution data could be a preliminary step before re-running the model with different parameters, or before exporting the model for use in another simulation or analysis. The dependencies would include the definitions of the solutions ('sol1' through 'sol14'), the physics settings, mesh settings, and any other parameters that define the behavior of the model. Additionally, the script or program may include functions or commands that utilize the 'out' variable to further process or analyze the model after this segment has been executed.



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

