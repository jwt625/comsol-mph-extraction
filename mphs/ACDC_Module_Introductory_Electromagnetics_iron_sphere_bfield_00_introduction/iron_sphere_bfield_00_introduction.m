function out = model
%
% iron_sphere_bfield_00_introduction.m
%
% Model exported on May 26 2025, 21:25 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/ACDC_Module/Introductory_Electromagnetics');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 3);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.physics.create('mf', 'InductionCurrents', 'geom1');
model.physics('mf').model('comp1');

model.study.create('std1');
model.study('std1').create('freq', 'Frequency');
model.study('std1').feature('freq').setSolveFor('/physics/mf', true);

model.view('view1').set('showgrid', false);
model.view('view1').set('showaxisorientation', false);

model.geom('geom1').lengthUnit('mm');

model.param.set('B0', '1[mT]');
model.param.descr('B0', 'Background magnetic field');
model.param.set('r0', '0.125[mm]');
model.param.descr('r0', 'Radius, iron sphere');
model.param.set('sigma_air', '0 [S/m]');
model.param.descr('sigma_air', 'Stabilization electrical conductivity of air');

model.geom('geom1').create('sph1', 'Sphere');
model.geom('geom1').feature('sph1').set('r', '3*r0');
model.geom('geom1').feature('sph1').setIndex('layer', 'r0', 0);
model.geom('geom1').feature('sph1').setIndex('layer', 'r0', 1);
model.geom('geom1').runPre('fin');

model.view('view1').set('renderwireframe', true);

model.selection.create('sel1', 'Explicit');
model.selection('sel1').model('comp1');

model.geom('geom1').run;

model.selection('sel1').label('Iron Sphere');
model.selection('sel1').set([9]);
model.selection.create('sel2', 'Explicit');
model.selection('sel2').model('comp1');
model.selection('sel2').label('Iron Sphere Surface');
model.selection('sel2').geom(2);
model.selection('sel2').set('groupcontang', true);
model.selection('sel2').add([17 18 19 20 31 32 39 42]);
model.selection.create('sel3', 'Explicit');
model.selection('sel3').model('comp1');
model.selection('sel3').label('Infinite Element Domain');
model.selection('sel3').set([1 2 3 4 10 11 14 17]);
model.selection.create('com1', 'Complement');
model.selection('com1').model('comp1');
model.selection('com1').label('Analysis domain');
model.selection('com1').set('input', {'sel3'});

model.coordSystem.create('ie1', 'geom1', 'InfiniteElement');
model.coordSystem('ie1').selection.named('sel3');
model.coordSystem('ie1').set('ScalingType', 'Spherical');

model.view('view1').hideEntities.create('hide1');
model.view('view1').hideEntities('hide1').set([2 6 11 13]);

model.physics('mf').prop('BackgroundField').set('SolveFor', 'ReducedField');
model.physics('mf').prop('BackgroundField').set('Ab', {'0' '0' 'B0*y'});
model.physics('mf').create('als1', 'AmperesLawSolid', 3);
model.physics('mf').feature('als1').selection.named('sel1');

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
model.material('mat2').propertyGroup.create('Enu', 'Young''s modulus and Poisson''s ratio');
model.material('mat2').label('Iron');
model.material('mat2').set('family', 'iron');
model.material('mat2').propertyGroup('def').set('relpermeability', {'4000' '0' '0' '0' '4000' '0' '0' '0' '4000'});
model.material('mat2').propertyGroup('def').set('electricconductivity', {'1.12e7[S/m]' '0' '0' '0' '1.12e7[S/m]' '0' '0' '0' '1.12e7[S/m]'});
model.material('mat2').propertyGroup('def').set('thermalexpansioncoefficient', {'12.2e-6[1/K]' '0' '0' '0' '12.2e-6[1/K]' '0' '0' '0' '12.2e-6[1/K]'});
model.material('mat2').propertyGroup('def').set('heatcapacity', '440[J/(kg*K)]');
model.material('mat2').propertyGroup('def').set('relpermittivity', {'1' '0' '0' '0' '1' '0' '0' '0' '1'});
model.material('mat2').propertyGroup('def').set('density', '7870[kg/m^3]');
model.material('mat2').propertyGroup('def').set('thermalconductivity', {'76.2[W/(m*K)]' '0' '0' '0' '76.2[W/(m*K)]' '0' '0' '0' '76.2[W/(m*K)]'});
model.material('mat2').propertyGroup('Enu').set('E', '200[GPa]');
model.material('mat2').propertyGroup('Enu').set('nu', '0.29');
model.material('mat1').propertyGroup('def').set('electricconductivity', {'sigma_air'});
model.material('mat2').selection.named('sel1');
model.material.duplicate('mat3', 'mat2');
model.material('mat3').selection.geom('geom1', 2);
model.material('mat3').selection.named('sel2');

model.title(['Iron Sphere in a Magnetic Field ' native2unicode(hex2dec({'20' '14'}), 'unicode') ' Introduction']);

model.description('An iron sphere is exposed to a selection of spatially uniform background magnetic fields. The introduction gives a summary of the four different modeling scenarios covered in the series and the corresponding results. It also gives the modeling instructions for setting up the geometry and materials for the subsequent tutorial models. The following tutorials all use the introduction model as a starting point and can be completed in any order.');

model.label('iron_sphere_bfield_00_introduction.mph');

model.modelNode.label('Components');

out = model;
