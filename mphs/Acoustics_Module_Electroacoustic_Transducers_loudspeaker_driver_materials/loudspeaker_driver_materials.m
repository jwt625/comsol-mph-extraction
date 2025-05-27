function out = model
%
% loudspeaker_driver_materials.m
%
% Model exported on May 26 2025, 21:25 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/Acoustics_Module/Electroacoustic_Transducers');

model.label('loudspeaker_driver_materials.mph');

model.material.create('mat1', 'Common', '');
model.material.create('mat2', 'Common', '');
model.material.create('mat3', 'Common', '');
model.material.create('mat4', 'Common', '');
model.material.create('mat5', 'Common', '');
model.material.create('mat6', 'Common', '');
model.material('mat6').propertyGroup.create('RemanentFluxDensity', 'Remanent flux density');
model.material('mat1').label('Composite');
model.material('mat1').propertyGroup('def').set('youngsmodulus', '2[GPa]');
model.material('mat1').propertyGroup('def').set('poissonsratio', '0.42');
model.material('mat1').propertyGroup('def').set('density', '1200[kg/m^3]');
model.material('mat1').propertyGroup('def').set('lossfactor', '0.04');
model.material('mat2').label('Cloth');
model.material('mat2').propertyGroup('def').set('electricconductivity', {'0' '0' '0' '0' '0' '0' '0' '0' '0'});
model.material('mat2').propertyGroup('def').set('relpermittivity', {'1' '0' '0' '0' '1' '0' '0' '0' '1'});
model.material('mat2').propertyGroup('def').set('relpermeability', {'1' '0' '0' '0' '1' '0' '0' '0' '1'});
model.material('mat2').propertyGroup('def').set('youngsmodulus', '0.58[GPa]');
model.material('mat2').propertyGroup('def').set('poissonsratio', '0.3');
model.material('mat2').propertyGroup('def').set('density', '650[kg/m^3]');
model.material('mat3').label('Foam');
model.material('mat3').propertyGroup('def').set('youngsmodulus', '5[MPa]');
model.material('mat3').propertyGroup('def').set('poissonsratio', '0.4');
model.material('mat3').propertyGroup('def').set('density', '67[Kg/m^3]');
model.material('mat4').label('Coil');
model.material('mat4').propertyGroup('def').set('relpermittivity', {'1' '0' '0' '0' '1' '0' '0' '0' '1'});
model.material('mat4').propertyGroup('def').set('relpermeability', {'1' '0' '0' '0' '1' '0' '0' '0' '1'});
model.material('mat4').propertyGroup('def').set('youngsmodulus', '110[GPa]');
model.material('mat4').propertyGroup('def').set('poissonsratio', '0.35');
model.material('mat4').propertyGroup('def').set('density', '4500[kg/m^3]');
model.material('mat5').label('Glass Fiber');
model.material('mat5').propertyGroup('def').set('electricconductivity', {'0' '0' '0' '0' '0' '0' '0' '0' '0'});
model.material('mat5').propertyGroup('def').set('relpermittivity', {'1' '0' '0' '0' '1' '0' '0' '0' '1'});
model.material('mat5').propertyGroup('def').set('relpermeability', {'1' '0' '0' '0' '1' '0' '0' '0' '1'});
model.material('mat5').propertyGroup('def').set('youngsmodulus', '70[GPa]');
model.material('mat5').propertyGroup('def').set('poissonsratio', '0.33');
model.material('mat5').propertyGroup('def').set('density', '2000[kg/m^3]');
model.material('mat5').propertyGroup('def').set('lossfactor', '0.04');
model.material('mat6').label('Generic Ferrite');
model.material('mat6').propertyGroup('def').set('electricconductivity', {'0' '0' '0' '0' '0' '0' '0' '0' '0'});
model.material('mat6').propertyGroup('def').set('relpermittivity', {'1' '0' '0' '0' '1' '0' '0' '0' '1'});
model.material('mat6').propertyGroup('RemanentFluxDensity').set('murec', '');
model.material('mat6').propertyGroup('RemanentFluxDensity').set('normBr', '');
model.material('mat6').propertyGroup('RemanentFluxDensity').set('murec', {'1' '0' '0' '0' '1' '0' '0' '0' '1'});
model.material('mat6').propertyGroup('RemanentFluxDensity').set('normBr', '0.4[T]');

model.label('loudspeaker_driver_materials.mph');

model.material('mat6').propertyGroup('def').set('poissonsratio', '');
model.material('mat6').propertyGroup('def').set('youngsmodulus', '');
model.material('mat6').propertyGroup('def').set('density', '');
model.material('mat6').propertyGroup('def').set('poissonsratio', {'0.3'});
model.material('mat6').propertyGroup('def').set('youngsmodulus', {'200[GPa]'});
model.material('mat6').propertyGroup('def').set('density', {'5000[kg/m^3]'});

model.label('loudspeaker_driver_materials.mph');

model.material.create('mat7', 'Common', '');
model.material('mat7').label('Fiberboard');
model.material('mat7').propertyGroup('def').set('density', '');
model.material('mat7').propertyGroup('def').set('poissonsratio', '');
model.material('mat7').propertyGroup('def').set('youngsmodulus', '');
model.material('mat7').propertyGroup('def').set('density', {'900[kg/m^3]'});
model.material('mat7').propertyGroup('def').set('poissonsratio', {'4[GPa]'});
model.material('mat7').propertyGroup('def').set('youngsmodulus', {'0.3'});

model.label('loudspeaker_driver_materials.mph');

model.material('mat7').propertyGroup('def').set('poissonsratio', {});
model.material('mat7').propertyGroup('def').set('youngsmodulus', {'4[GPa]'});
model.material('mat7').propertyGroup('def').set('poissonsratio', {'0.3'});

model.label('loudspeaker_driver_materials.mph');

model.material('mat4').propertyGroup('def').set('lossfactor', {'0.05'});
model.material('mat6').propertyGroup('def').set('lossfactor', {'0.01'});
model.material('mat7').propertyGroup('def').set('lossfactor', {'0.07'});
model.material('mat3').propertyGroup('def').set('density', {'67[kg/m^3]'});

model.label('loudspeaker_driver_materials.mph');

model.modelNode.label('Components');

out = model;
