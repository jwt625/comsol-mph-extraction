function out = model
%
% plate_deflected_by_magnet.m
%
% Model exported on May 26 2025, 21:33 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/Structural_Mechanics_Module/Magnetomechanics');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 3);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.physics.create('solid', 'SolidMechanics', 'geom1');
model.physics('solid').model('comp1');
model.physics.create('mfnc', 'MagnetostaticsNoCurrents', 'geom1');
model.physics('mfnc').model('comp1');
model.physics('mfnc').feature('mfc1').set('materialType', {'solid'});
model.physics('mfnc').feature('mfc1').label('Magnetic Flux Conservation, Solid');

model.multiphysics.create('mmcpl1', 'Magnetomechanics', 'geom1', 3);
model.multiphysics('mmcpl1').set('Solid_physics', 'solid');
model.multiphysics('mmcpl1').set('MagneticFields_physics', 'mfnc');
model.multiphysics('mmcpl1').selection.all;

model.common.create('free1', 'DeformingDomain', 'comp1');
model.common('free1').set('smoothingType', 'hyperelastic');
model.common('free1').selection.set([]);
model.common.create('sym1', 'Symmetry', 'comp1');
model.common('sym1').selection.set([]);

model.study.create('std1');
model.study('std1').create('stat', 'Stationary');
model.study('std1').feature('stat').setSolveFor('/physics/solid', true);
model.study('std1').feature('stat').setSolveFor('/physics/mfnc', true);
model.study('std1').feature('stat').setSolveFor('/multiphysics/mmcpl1', true);

model.param.label('Parameters, geometry');
model.param.set('dm', '3[mm]');
model.param.descr('dm', 'Distance to magnet');
model.param.set('hp', '1[mm]');
model.param.descr('hp', 'Plate thickness');
model.param.set('lp', '20[cm]');
model.param.descr('lp', 'Plate length');
model.param.set('wp', '6[cm]');
model.param.descr('wp', 'Plate width');
model.param.set('H', '7[cm]');
model.param.descr('H', 'Distance to bottom wall');

model.geom('geom1').create('wp1', 'WorkPlane');
model.geom('geom1').feature('wp1').set('unite', true);
model.geom('geom1').feature('wp1').set('quickplane', 'zy');
model.geom('geom1').feature('wp1').set('quickx', 0.01);
model.geom('geom1').feature('wp1').geom.create('c1', 'Circle');
model.geom('geom1').feature('wp1').geom.feature('c1').set('r', 0.04);
model.geom('geom1').feature('wp1').geom.feature('c1').set('angle', 90);
model.geom('geom1').feature('wp1').geom.feature('c1').set('pos', [0.06 0]);
model.geom('geom1').feature('wp1').geom.feature.duplicate('c2', 'c1');
model.geom('geom1').feature('wp1').geom.feature('c2').set('r', 0.02);
model.geom('geom1').feature('wp1').geom.run('c2');
model.geom('geom1').feature('wp1').geom.create('dif1', 'Difference');
model.geom('geom1').feature('wp1').geom.feature('dif1').selection('input').set({'c1'});
model.geom('geom1').feature('wp1').geom.feature('dif1').selection('input2').set({'c2'});
model.geom('geom1').feature('wp1').geom.run('dif1');
model.geom('geom1').feature('wp1').geom.create('r1', 'Rectangle');
model.geom('geom1').feature('wp1').geom.feature('r1').set('size', [0.05 0.02]);
model.geom('geom1').feature('wp1').geom.feature('r1').set('pos', [0 0.02]);
model.geom('geom1').feature('wp1').geom.feature.duplicate('r2', 'r1');
model.geom('geom1').feature('wp1').geom.feature('r2').set('size', [0.01 0.02]);
model.geom('geom1').feature('wp1').geom.feature('r2').set('pos', [0.05 0.02]);
model.geom('geom1').feature('wp1').geom.run('r2');
model.geom('geom1').run('wp1');
model.geom('geom1').feature.create('ext1', 'Extrude');
model.geom('geom1').feature('ext1').set('workplane', 'wp1');
model.geom('geom1').feature('ext1').selection('input').set({'wp1'});
model.geom('geom1').feature('ext1').setIndex('distance', 0.01, 0);
model.geom('geom1').run('ext1');
model.geom('geom1').create('blk1', 'Block');
model.geom('geom1').feature('blk1').set('size', {'wp/2' 'lp/2' 'hp'});
model.geom('geom1').feature('blk1').set('pos', {'0' '0' '-(dm+hp)'});
model.geom('geom1').run('blk1');
model.geom('geom1').create('blk2', 'Block');
model.geom('geom1').feature('blk2').set('size', {'2*wp' 'lp/2+wp' '1'});
model.geom('geom1').feature('blk2').setIndex('size', 0.2, 2);
model.geom('geom1').feature('blk2').set('pos', {'0' '0' '-H'});
model.geom('geom1').feature('blk2').setIndex('layername', 'Layer 1', 0);
model.geom('geom1').feature('blk2').setIndex('layer', 'H-2*dm-hp', 0);
model.geom('geom1').feature('blk2').setIndex('layername', 'Layer 2', 1);
model.geom('geom1').feature('blk2').setIndex('layer', '2*dm+hp', 1);
model.geom('geom1').runPre('fin');

model.view('view1').set('transparency', true);

model.geom('geom1').run;

model.material.create('mat1', 'Common', 'comp1');
model.material('mat1').propertyGroup.create('BHCurve', 'B-H Curve');
model.material('mat1').propertyGroup('BHCurve').func.create('BH', 'Interpolation');
model.material('mat1').propertyGroup.create('EffectiveBHCurve', 'Effective B-H Curve');
model.material('mat1').propertyGroup('EffectiveBHCurve').func.create('BHeff', 'Interpolation');
model.material('mat1').label('Soft Iron (Without Losses)');
model.material('mat1').set('family', 'iron');
model.material('mat1').propertyGroup('def').set('electricconductivity', {'0[S/m]' '0' '0' '0' '0[S/m]' '0' '0' '0' '0[S/m]'});
model.material('mat1').propertyGroup('def').set('relpermittivity', {'1' '0' '0' '0' '1' '0' '0' '0' '1'});
model.material('mat1').propertyGroup('BHCurve').label('B-H Curve');
model.material('mat1').propertyGroup('BHCurve').func('BH').label('Interpolation 1');
model.material('mat1').propertyGroup('BHCurve').func('BH').set('table', {'0' '0';  ...
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
model.material('mat1').propertyGroup('BHCurve').func('BH').set('extrap', 'linear');
model.material('mat1').propertyGroup('BHCurve').func('BH').set('fununit', {'T'});
model.material('mat1').propertyGroup('BHCurve').func('BH').set('argunit', {'A/m'});
model.material('mat1').propertyGroup('BHCurve').func('BH').set('defineinv', true);
model.material('mat1').propertyGroup('BHCurve').func('BH').set('defineprimfun', true);
model.material('mat1').propertyGroup('BHCurve').set('normB', 'BH(normHin)');
model.material('mat1').propertyGroup('BHCurve').set('normH', 'BH_inv(normBin)');
model.material('mat1').propertyGroup('BHCurve').set('Wpm', 'BH_prim(normHin)');
model.material('mat1').propertyGroup('BHCurve').descr('normHin', 'Magnetic field norm');
model.material('mat1').propertyGroup('BHCurve').descr('normBin', 'Magnetic flux density norm');
model.material('mat1').propertyGroup('BHCurve').addInput('magneticfield');
model.material('mat1').propertyGroup('BHCurve').addInput('magneticfluxdensity');
model.material('mat1').propertyGroup('EffectiveBHCurve').label('Effective B-H Curve');
model.material('mat1').propertyGroup('EffectiveBHCurve').func('BHeff').label('Interpolation 1');
model.material('mat1').propertyGroup('EffectiveBHCurve').func('BHeff').set('table', {'0' '0';  ...
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
model.material('mat1').propertyGroup('EffectiveBHCurve').func('BHeff').set('extrap', 'linear');
model.material('mat1').propertyGroup('EffectiveBHCurve').func('BHeff').set('fununit', {'T'});
model.material('mat1').propertyGroup('EffectiveBHCurve').func('BHeff').set('argunit', {'A/m'});
model.material('mat1').propertyGroup('EffectiveBHCurve').func('BHeff').set('defineinv', true);
model.material('mat1').propertyGroup('EffectiveBHCurve').set('normBeff', 'BHeff(normHeffin)');
model.material('mat1').propertyGroup('EffectiveBHCurve').set('normHeff', 'BHeff_inv(normBeffin)');
model.material('mat1').propertyGroup('EffectiveBHCurve').descr('normHeffin', 'Effective magnetic field norm');
model.material('mat1').propertyGroup('EffectiveBHCurve').descr('normBeffin', 'Effective magnetic flux density norm');
model.material('mat1').propertyGroup('EffectiveBHCurve').addInput('magneticfield');
model.material('mat1').propertyGroup('EffectiveBHCurve').addInput('magneticfluxdensity');
model.material('mat1').selection.set([3 5 7]);
model.material.create('mat2', 'Common', 'comp1');
model.material('mat2').propertyGroup.create('RemanentFluxDensity', 'Remanent flux density');
model.material('mat2').label('N35 (Sintered NdFeB)');
model.material('mat2').set('family', 'chrome');
model.material('mat2').propertyGroup('def').set('electricconductivity', {'1/1.4[uohm*m]' '0' '0' '0' '1/1.4[uohm*m]' '0' '0' '0' '1/1.4[uohm*m]'});
model.material('mat2').propertyGroup('def').set('relpermittivity', {'1' '0' '0' '0' '1' '0' '0' '0' '1'});
model.material('mat2').propertyGroup('RemanentFluxDensity').set('murec', {'1.05' '0' '0' '0' '1.05' '0' '0' '0' '1.05'});
model.material('mat2').propertyGroup('RemanentFluxDensity').set('normBr', '1.21[T]');
model.material('mat2').selection.set([6]);
model.material.create('mat3', 'Common', 'comp1');
model.material('mat3').propertyGroup('def').func.create('eta', 'Piecewise');
model.material('mat3').propertyGroup('def').func.create('Cp', 'Piecewise');
model.material('mat3').propertyGroup('def').func.create('rho', 'Analytic');
model.material('mat3').propertyGroup('def').func.create('k', 'Piecewise');
model.material('mat3').propertyGroup('def').func.create('cs', 'Analytic');
model.material('mat3').propertyGroup('def').func.create('an1', 'Analytic');
model.material('mat3').propertyGroup('def').func.create('an2', 'Analytic');
model.material('mat3').propertyGroup.create('RefractiveIndex', 'Refractive index');
model.material('mat3').propertyGroup.create('NonlinearModel', 'Nonlinear model');
model.material('mat3').propertyGroup.create('idealGas', 'Ideal gas');
model.material('mat3').propertyGroup('idealGas').func.create('Cp', 'Piecewise');
model.material('mat3').label('Air');
model.material('mat3').set('family', 'air');
model.material('mat3').propertyGroup('def').func('eta').set('arg', 'T');
model.material('mat3').propertyGroup('def').func('eta').set('pieces', {'200.0' '1600.0' '-8.38278E-7+8.35717342E-8*T^1-7.69429583E-11*T^2+4.6437266E-14*T^3-1.06585607E-17*T^4'});
model.material('mat3').propertyGroup('def').func('eta').set('argunit', 'K');
model.material('mat3').propertyGroup('def').func('eta').set('fununit', 'Pa*s');
model.material('mat3').propertyGroup('def').func('Cp').set('arg', 'T');
model.material('mat3').propertyGroup('def').func('Cp').set('pieces', {'200.0' '1600.0' '1047.63657-0.372589265*T^1+9.45304214E-4*T^2-6.02409443E-7*T^3+1.2858961E-10*T^4'});
model.material('mat3').propertyGroup('def').func('Cp').set('argunit', 'K');
model.material('mat3').propertyGroup('def').func('Cp').set('fununit', 'J/(kg*K)');
model.material('mat3').propertyGroup('def').func('rho').set('expr', 'pA*0.02897/R_const[K*mol/J]/T');
model.material('mat3').propertyGroup('def').func('rho').set('args', {'pA' 'T'});
model.material('mat3').propertyGroup('def').func('rho').set('fununit', 'kg/m^3');
model.material('mat3').propertyGroup('def').func('rho').set('argunit', {'Pa' 'K'});
model.material('mat3').propertyGroup('def').func('rho').set('plotaxis', {'off' 'on'});
model.material('mat3').propertyGroup('def').func('rho').set('plotfixedvalue', {'101325' '273.15'});
model.material('mat3').propertyGroup('def').func('rho').set('plotargs', {'pA' '101325' '101325'; 'T' '273.15' '293.15'});
model.material('mat3').propertyGroup('def').func('k').set('arg', 'T');
model.material('mat3').propertyGroup('def').func('k').set('pieces', {'200.0' '1600.0' '-0.00227583562+1.15480022E-4*T^1-7.90252856E-8*T^2+4.11702505E-11*T^3-7.43864331E-15*T^4'});
model.material('mat3').propertyGroup('def').func('k').set('argunit', 'K');
model.material('mat3').propertyGroup('def').func('k').set('fununit', 'W/(m*K)');
model.material('mat3').propertyGroup('def').func('cs').set('expr', 'sqrt(1.4*R_const[K*mol/J]/0.02897*T)');
model.material('mat3').propertyGroup('def').func('cs').set('args', {'T'});
model.material('mat3').propertyGroup('def').func('cs').set('fununit', 'm/s');
model.material('mat3').propertyGroup('def').func('cs').set('argunit', {'K'});
model.material('mat3').propertyGroup('def').func('cs').set('plotfixedvalue', {'273.15'});
model.material('mat3').propertyGroup('def').func('cs').set('plotargs', {'T' '273.15' '373.15'});
model.material('mat3').propertyGroup('def').func('an1').set('funcname', 'alpha_p');
model.material('mat3').propertyGroup('def').func('an1').set('expr', '-1/rho(pA,T)*d(rho(pA,T),T)');
model.material('mat3').propertyGroup('def').func('an1').set('args', {'pA' 'T'});
model.material('mat3').propertyGroup('def').func('an1').set('fununit', '1/K');
model.material('mat3').propertyGroup('def').func('an1').set('argunit', {'Pa' 'K'});
model.material('mat3').propertyGroup('def').func('an1').set('plotaxis', {'off' 'on'});
model.material('mat3').propertyGroup('def').func('an1').set('plotfixedvalue', {'101325' '273.15'});
model.material('mat3').propertyGroup('def').func('an1').set('plotargs', {'pA' '101325' '101325'; 'T' '273.15' '373.15'});
model.material('mat3').propertyGroup('def').func('an2').set('funcname', 'muB');
model.material('mat3').propertyGroup('def').func('an2').set('expr', '0.6*eta(T)');
model.material('mat3').propertyGroup('def').func('an2').set('args', {'T'});
model.material('mat3').propertyGroup('def').func('an2').set('fununit', 'Pa*s');
model.material('mat3').propertyGroup('def').func('an2').set('argunit', {'K'});
model.material('mat3').propertyGroup('def').func('an2').set('plotfixedvalue', {'200'});
model.material('mat3').propertyGroup('def').func('an2').set('plotargs', {'T' '200' '1600'});
model.material('mat3').propertyGroup('def').set('thermalexpansioncoefficient', '');
model.material('mat3').propertyGroup('def').set('molarmass', '');
model.material('mat3').propertyGroup('def').set('bulkviscosity', '');
model.material('mat3').propertyGroup('def').set('thermalexpansioncoefficient', {'alpha_p(pA,T)' '0' '0' '0' 'alpha_p(pA,T)' '0' '0' '0' 'alpha_p(pA,T)'});
model.material('mat3').propertyGroup('def').set('molarmass', '0.02897[kg/mol]');
model.material('mat3').propertyGroup('def').set('bulkviscosity', 'muB(T)');
model.material('mat3').propertyGroup('def').set('relpermeability', {'1' '0' '0' '0' '1' '0' '0' '0' '1'});
model.material('mat3').propertyGroup('def').set('relpermittivity', {'1' '0' '0' '0' '1' '0' '0' '0' '1'});
model.material('mat3').propertyGroup('def').set('dynamicviscosity', 'eta(T)');
model.material('mat3').propertyGroup('def').set('ratioofspecificheat', '1.4');
model.material('mat3').propertyGroup('def').set('electricconductivity', {'0[S/m]' '0' '0' '0' '0[S/m]' '0' '0' '0' '0[S/m]'});
model.material('mat3').propertyGroup('def').set('heatcapacity', 'Cp(T)');
model.material('mat3').propertyGroup('def').set('density', 'rho(pA,T)');
model.material('mat3').propertyGroup('def').set('thermalconductivity', {'k(T)' '0' '0' '0' 'k(T)' '0' '0' '0' 'k(T)'});
model.material('mat3').propertyGroup('def').set('soundspeed', 'cs(T)');
model.material('mat3').propertyGroup('def').addInput('temperature');
model.material('mat3').propertyGroup('def').addInput('pressure');
model.material('mat3').propertyGroup('RefractiveIndex').set('n', {'1' '0' '0' '0' '1' '0' '0' '0' '1'});
model.material('mat3').propertyGroup('NonlinearModel').set('BA', 'def.gamma-1');
model.material('mat3').propertyGroup('idealGas').func('Cp').label('Piecewise 2');
model.material('mat3').propertyGroup('idealGas').func('Cp').set('arg', 'T');
model.material('mat3').propertyGroup('idealGas').func('Cp').set('pieces', {'200.0' '1600.0' '1047.63657-0.372589265*T^1+9.45304214E-4*T^2-6.02409443E-7*T^3+1.2858961E-10*T^4'});
model.material('mat3').propertyGroup('idealGas').func('Cp').set('argunit', 'K');
model.material('mat3').propertyGroup('idealGas').func('Cp').set('fununit', 'J/(kg*K)');
model.material('mat3').propertyGroup('idealGas').set('Rs', 'R_const/Mn');
model.material('mat3').propertyGroup('idealGas').set('heatcapacity', 'Cp(T)');
model.material('mat3').propertyGroup('idealGas').set('ratioofspecificheat', '1.4');
model.material('mat3').propertyGroup('idealGas').set('molarmass', '0.02897');
model.material('mat3').propertyGroup('idealGas').addInput('temperature');
model.material('mat3').propertyGroup('idealGas').addInput('pressure');
model.material('mat3').materialType('nonSolid');
model.material('mat3').selection.set([1 2 4]);

model.common('free1').selection.set([2]);
model.common('sym1').selection.set([4 5]);

model.physics('solid').selection.set([3]);
model.physics('solid').create('fix1', 'Fixed', 2);
model.physics('solid').feature('fix1').selection.set([29]);
model.physics('solid').create('sym1', 'SymmetrySolid', 2);
model.physics('solid').feature('sym1').selection.set([7 8]);
model.physics('mfnc').feature('mfc1').set('ConstitutiveRelationBH', 'BHCurve');
model.physics('mfnc').create('mfc2', 'MagneticFluxConservation', 3);
model.physics('mfnc').feature('mfc2').label('Magnetic Flux Conservation, Magnet');
model.physics('mfnc').feature('mfc2').selection.set([6]);
model.physics('mfnc').feature('mfc2').setIndex('materialType', 'solid', 0);
model.physics('mfnc').feature('mfc2').set('ConstitutiveRelationBH', 'RemanentFluxDensity');
model.physics('mfnc').feature('mfc2').set('e_crel_BH_RemanentFluxDensity', [0 0 1]);
model.physics('mfnc').create('mfc3', 'MagneticFluxConservation', 3);
model.physics('mfnc').feature('mfc3').label('Magnetic Flux Conservation, Air');
model.physics('mfnc').feature('mfc3').selection.set([1 2 4]);
model.physics('mfnc').create('symp1', 'SymmetryPlane', 2);
model.physics('mfnc').feature('symp1').label('Symmetry Plane, Symmetry');
model.physics('mfnc').feature('symp1').selection.set([1 4 7 11 14 17 20 23]);
model.physics('mfnc').create('symp2', 'SymmetryPlane', 2);
model.physics('mfnc').feature('symp2').label('Symmetry Plane, Antisymmetry');
model.physics('mfnc').feature('symp2').set('Symmetry_type', 'Antisymmetry');
model.physics('mfnc').feature('symp2').selection.set([2 5 8 12 15]);

model.material('mat1').propertyGroup.create('Enu', 'Young''s_modulus_and_Poisson''s_ratio');
model.material('mat1').propertyGroup('Enu').set('E', {'200[GPa]'});
model.material('mat1').propertyGroup('Enu').set('nu', {'0.29'});
model.material('mat1').propertyGroup('def').set('density', {'7870[kg/m^3]'});
model.material('mat1').propertyGroup('BHCurve').func('BH').set('extrap', 'linear');

model.param.create('par2');
model.param('par2').label('Parameters, accuracy');
model.param('par2').set('ap', '0');
model.param('par2').descr('ap', 'Accuracy parameter: 0 - normal, 1 - high');
model.param('par2').set('hmax1', '5[mm]-2.6[mm]*ap');
model.param('par2').descr('hmax1', 'Meshing parameter');
model.param('par2').set('hmax2', '20[mm]-10[mm]*ap');
model.param('par2').descr('hmax2', 'Meshing parameter');

model.mesh('mesh1').create('ftri1', 'FreeTri');
model.mesh('mesh1').feature('ftri1').selection.set([10 22]);
model.mesh('mesh1').feature('ftri1').create('size1', 'Size');
model.mesh('mesh1').feature('ftri1').feature('size1').set('custom', true);
model.mesh('mesh1').feature('ftri1').feature('size1').set('hmaxactive', true);
model.mesh('mesh1').feature('ftri1').feature('size1').set('hmax', 'hmax1');
model.mesh('mesh1').create('swe1', 'Sweep');
model.mesh('mesh1').feature('swe1').selection.geom('geom1', 3);
model.mesh('mesh1').feature('swe1').selection.set([5 6 7]);
model.mesh('mesh1').feature('swe1').create('dis1', 'Distribution');
model.mesh('mesh1').feature('swe1').feature('dis1').selection.set([5 6]);
model.mesh('mesh1').feature('swe1').feature('dis1').set('numelem', 10);
model.mesh('mesh1').feature('swe1').create('dis2', 'Distribution');
model.mesh('mesh1').feature('swe1').feature('dis2').selection.set([7]);
model.mesh('mesh1').feature('swe1').feature('dis2').set('numelem', 2);
model.mesh('mesh1').create('swe2', 'Sweep');
model.mesh('mesh1').feature('swe2').selection.geom('geom1', 3);
model.mesh('mesh1').feature('swe2').selection.set([3]);
model.mesh('mesh1').feature('swe2').create('dis1', 'Distribution');
model.mesh('mesh1').feature('swe2').feature('dis1').set('numelem', 3);
model.mesh('mesh1').create('ftet1', 'FreeTet');
model.mesh('mesh1').feature('ftet1').create('size1', 'Size');
model.mesh('mesh1').feature('ftet1').feature('size1').set('custom', true);
model.mesh('mesh1').feature('ftet1').feature('size1').set('hmaxactive', true);
model.mesh('mesh1').feature('ftet1').feature('size1').set('hmax', 'hmax2');
model.mesh('mesh1').run;

model.study('std1').create('param', 'Parametric');
model.study('std1').feature('param').setIndex('pname', 'ap', 0);
model.study('std1').feature('param').setIndex('plistarr', '', 0);
model.study('std1').feature('param').setIndex('punit', '', 0);
model.study('std1').feature('param').setIndex('pname', 'ap', 0);
model.study('std1').feature('param').setIndex('plistarr', '', 0);
model.study('std1').feature('param').setIndex('punit', '', 0);
model.study('std1').feature('param').setIndex('pname', 'dm', 0);
model.study('std1').feature('param').setIndex('plistarr', '7 5 4 3', 0);
model.study('std1').feature('param').setIndex('punit', 'mm', 0);

model.sol.create('sol1');

model.mesh('mesh1').stat.selection.geom(3);
model.mesh('mesh1').stat.selection.set([2]);

model.sol('sol1').study('std1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'stat');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').feature('comp1_spatial_disp').set('scalemethod', 'manual');
model.sol('sol1').feature('v1').feature('comp1_u').set('scalemethod', 'manual');
model.sol('sol1').feature('v1').feature('comp1_spatial_disp').set('scaleval', '1e-2*0.28284271247461906');
model.sol('sol1').feature('v1').feature('comp1_u').set('scaleval', '1e-2*0.28284271247461906');
model.sol('sol1').feature('v1').set('control', 'stat');
model.sol('sol1').create('s1', 'Stationary');
model.sol('sol1').feature('s1').feature('aDef').set('cachepattern', true);
model.sol('sol1').feature('s1').create('seDef', 'Segregated');
model.sol('sol1').feature('s1').create('se1', 'Segregated');
model.sol('sol1').feature('s1').feature('se1').feature.remove('ssDef');
model.sol('sol1').feature('s1').feature('se1').create('ss1', 'SegregatedStep');
model.sol('sol1').feature('s1').feature('se1').feature('ss1').set('segvar', {'comp1_Vm'});
model.sol('sol1').feature('s1').feature('se1').feature('ss1').set('subdtech', 'auto');
model.sol('sol1').feature('s1').feature('se1').feature('ss1').set('subminstep', 0.001);
model.sol('sol1').feature('s1').feature('se1').feature('ss1').set('usesubminsteprecovery', 'on');
model.sol('sol1').feature('s1').feature('se1').feature('ss1').set('subtermauto', 'itertol');
model.sol('sol1').feature('s1').feature('se1').feature('ss1').set('subiter', 35);
model.sol('sol1').feature('s1').feature('se1').feature('ss1').set('subntolfact', 1);
model.sol('sol1').feature('s1').create('i1', 'Iterative');
model.sol('sol1').feature('s1').feature('i1').set('linsolver', 'gmres');
model.sol('sol1').feature('s1').feature('i1').set('nlinnormuse', true);
model.sol('sol1').feature('s1').feature('i1').set('prefuntype', 'right');
model.sol('sol1').feature('s1').feature('i1').create('mg1', 'Multigrid');
model.sol('sol1').feature('s1').feature('se1').feature('ss1').set('linsolver', 'i1');
model.sol('sol1').feature('s1').feature('se1').feature('ss1').label('Magnetic Potential');
model.sol('sol1').feature('s1').feature('se1').create('ss2', 'SegregatedStep');
model.sol('sol1').feature('s1').feature('se1').feature('ss2').set('segvar', {'comp1_u'});
model.sol('sol1').feature('s1').feature('se1').feature('ss2').set('subdtech', 'auto');
model.sol('sol1').feature('s1').feature('se1').feature('ss2').set('subminstep', 0.001);
model.sol('sol1').feature('s1').feature('se1').feature('ss2').set('usesubminsteprecovery', 'on');
model.sol('sol1').feature('s1').feature('se1').feature('ss2').set('subtermauto', 'itertol');
model.sol('sol1').feature('s1').feature('se1').feature('ss2').set('subiter', 35);
model.sol('sol1').feature('s1').feature('se1').feature('ss2').set('subntolfact', 1);
model.sol('sol1').feature('s1').feature('se1').feature('ss2').set('linsolver', 'dDef');
model.sol('sol1').feature('s1').feature('se1').feature('ss2').label('Displacement Field');
model.sol('sol1').feature('s1').feature('se1').create('ss3', 'SegregatedStep');
model.sol('sol1').feature('s1').feature('se1').feature('ss3').set('segvar', {'comp1_spatial_disp'});
model.sol('sol1').feature('s1').feature('se1').feature('ss3').set('subdtech', 'auto');
model.sol('sol1').feature('s1').feature('se1').feature('ss3').set('subminstep', 0.001);
model.sol('sol1').feature('s1').feature('se1').feature('ss3').set('usesubminsteprecovery', 'on');
model.sol('sol1').feature('s1').feature('se1').feature('ss3').set('subtermauto', 'itertol');
model.sol('sol1').feature('s1').feature('se1').feature('ss3').set('subiter', 35);
model.sol('sol1').feature('s1').feature('se1').feature('ss3').set('subntolfact', 1);
model.sol('sol1').feature('s1').feature('se1').feature('ss3').set('linsolver', 'dDef');
model.sol('sol1').feature('s1').feature('se1').feature('ss3').label('Spatial Mesh Displacement');
model.sol('sol1').feature('s1').feature.remove('fcDef');
model.sol('sol1').feature('s1').feature.remove('seDef');
model.sol('sol1').attach('std1');

model.batch.create('p1', 'Parametric');
model.batch('p1').study('std1');
model.batch('p1').create('so1', 'Solutionseq');
model.batch('p1').feature('so1').set('seq', 'sol1');
model.batch('p1').feature('so1').set('store', 'on');
model.batch('p1').feature('so1').set('clear', 'on');
model.batch('p1').feature('so1').set('psol', 'none');
model.batch('p1').set('pname', {'dm'});
model.batch('p1').set('plistarr', {'7 5 4 3'});
model.batch('p1').set('sweeptype', 'sparse');
model.batch('p1').set('probesel', 'all');
model.batch('p1').set('probes', {});
model.batch('p1').set('plot', 'off');
model.batch('p1').set('err', 'on');
model.batch('p1').attach('std1');
model.batch('p1').set('control', 'param');

model.sol('sol1').feature('s1').feature('se1').feature('ss1').set('linsolver', 'dDef');
model.sol.create('sol2');
model.sol('sol2').study('std1');
model.sol('sol2').label('Parametric Solutions 1');

model.batch('p1').feature('so1').set('psol', 'sol2');

model.result.create('pg1', 'PlotGroup3D');
model.result('pg1').set('data', 'dset2');
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
model.result.create('pg2', 'PlotGroup3D');
model.result('pg2').label('Magnetic Flux Density Norm (mfnc)');
model.result('pg2').set('data', 'dset2');
model.result('pg2').set('frametype', 'spatial');
model.result('pg2').set('showlegendsmaxmin', true);
model.result('pg2').set('data', 'dset2');
model.result('pg2').set('defaultPlotID', 'InterfaceComponents/PlotDefaults/icom12/pdef1/pcond2/pcond1/pg1');
model.result('pg2').feature.create('mslc1', 'Multislice');
model.result('pg2').feature('mslc1').set('showsolutionparams', 'on');
model.result('pg2').feature('mslc1').set('solutionparams', 'parent');
model.result('pg2').feature('mslc1').set('expr', 'mfnc.normB');
model.result('pg2').feature('mslc1').set('multiplanexmethod', 'coord');
model.result('pg2').feature('mslc1').set('xcoord', 'mfnc.CPx');
model.result('pg2').feature('mslc1').set('multiplaneymethod', 'coord');
model.result('pg2').feature('mslc1').set('ycoord', 'mfnc.CPy');
model.result('pg2').feature('mslc1').set('multiplanezmethod', 'coord');
model.result('pg2').feature('mslc1').set('zcoord', 'mfnc.CPz');
model.result('pg2').feature('mslc1').set('colortable', 'Prism');
model.result('pg2').feature('mslc1').set('colortabletrans', 'nonlinear');
model.result('pg2').feature('mslc1').set('colorcalibration', -0.8);
model.result('pg2').feature('mslc1').set('showsolutionparams', 'on');
model.result('pg2').feature('mslc1').set('data', 'parent');
model.result('pg2').feature.create('strmsl1', 'StreamlineMultislice');
model.result('pg2').feature('strmsl1').set('showsolutionparams', 'on');
model.result('pg2').feature('strmsl1').set('solutionparams', 'parent');
model.result('pg2').feature('strmsl1').set('expr', {'mfnc.Bx' 'mfnc.By' 'mfnc.Bz'});
model.result('pg2').feature('strmsl1').set('multiplanexmethod', 'coord');
model.result('pg2').feature('strmsl1').set('xcoord', 'mfnc.CPx');
model.result('pg2').feature('strmsl1').set('multiplaneymethod', 'coord');
model.result('pg2').feature('strmsl1').set('ycoord', 'mfnc.CPy');
model.result('pg2').feature('strmsl1').set('multiplanezmethod', 'coord');
model.result('pg2').feature('strmsl1').set('zcoord', 'mfnc.CPz');
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
model.result('pg2').feature('strmsl1').feature('col1').set('expr', 'mfnc.normB');
model.result('pg2').feature('strmsl1').feature('col1').set('colortable', 'PrismDark');
model.result('pg2').feature('strmsl1').feature('col1').set('colorlegend', false);
model.result('pg2').feature('strmsl1').feature('col1').set('colortabletrans', 'nonlinear');
model.result('pg2').feature('strmsl1').feature('col1').set('colorcalibration', -0.8);
model.result('pg2').feature('strmsl1').feature.create('filt1', 'Filter');
model.result('pg2').feature('strmsl1').feature('filt1').set('expr', '!isScalingSystemDomain');
model.result.create('pg3', 'PlotGroup3D');
model.result('pg3').label('Magnetic Scalar Potential (mfnc)');
model.result('pg3').set('data', 'dset2');
model.result('pg3').set('frametype', 'spatial');
model.result('pg3').set('showlegendsmaxmin', true);
model.result('pg3').set('data', 'dset2');
model.result('pg3').set('defaultPlotID', 'InterfaceComponents/PlotDefaults/icom5/pdef1/pcond2/pcond1/pg1');
model.result('pg3').feature.create('mslc1', 'Multislice');
model.result('pg3').feature('mslc1').set('showsolutionparams', 'on');
model.result('pg3').feature('mslc1').set('solutionparams', 'parent');
model.result('pg3').feature('mslc1').set('expr', 'Vm');
model.result('pg3').feature('mslc1').set('multiplanexmethod', 'coord');
model.result('pg3').feature('mslc1').set('xcoord', 'mfnc.CPx');
model.result('pg3').feature('mslc1').set('multiplaneymethod', 'coord');
model.result('pg3').feature('mslc1').set('ycoord', 'mfnc.CPy');
model.result('pg3').feature('mslc1').set('multiplanezmethod', 'coord');
model.result('pg3').feature('mslc1').set('zcoord', 'mfnc.CPz');
model.result('pg3').feature('mslc1').set('colortable', 'Dipole');
model.result('pg3').feature('mslc1').set('showsolutionparams', 'on');
model.result('pg3').feature('mslc1').set('data', 'parent');
model.result('pg3').feature.create('strmsl1', 'StreamlineMultislice');
model.result('pg3').feature('strmsl1').set('showsolutionparams', 'on');
model.result('pg3').feature('strmsl1').set('solutionparams', 'parent');
model.result('pg3').feature('strmsl1').set('expr', {'mfnc.Hx' 'mfnc.Hy' 'mfnc.Hz'});
model.result('pg3').feature('strmsl1').set('multiplanexmethod', 'coord');
model.result('pg3').feature('strmsl1').set('xcoord', 'mfnc.CPx');
model.result('pg3').feature('strmsl1').set('multiplaneymethod', 'coord');
model.result('pg3').feature('strmsl1').set('ycoord', 'mfnc.CPy');
model.result('pg3').feature('strmsl1').set('multiplanezmethod', 'coord');
model.result('pg3').feature('strmsl1').set('zcoord', 'mfnc.CPz');
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
model.result('pg3').feature('strmsl1').feature('col1').set('expr', 'Vm');
model.result('pg3').feature('strmsl1').feature('col1').set('colortable', 'DipoleDark');
model.result('pg3').feature('strmsl1').feature('col1').set('colorlegend', false);
model.result('pg3').feature('strmsl1').feature.create('filt1', 'Filter');
model.result('pg3').feature('strmsl1').feature('filt1').set('expr', '!isScalingSystemDomain');
model.result.create('pg4', 'PlotGroup3D');
model.result('pg4').set('data', 'dset2');
model.result('pg4').label('Moving Mesh');
model.result('pg4').create('mesh1', 'Mesh');
model.result('pg4').feature('mesh1').set('meshdomain', 'volume');
model.result('pg4').feature('mesh1').set('colortable', 'TrafficFlow');
model.result('pg4').feature('mesh1').set('colortabletrans', 'nonlinear');
model.result('pg4').feature('mesh1').set('nonlinearcolortablerev', true);
model.result('pg4').feature('mesh1').create('sel1', 'MeshSelection');
model.result('pg4').feature('mesh1').feature('sel1').selection.set([2 3]);
model.result('pg4').feature('mesh1').set('qualmeasure', 'custom');
model.result('pg4').feature('mesh1').set('qualexpr', 'comp1.spatial.relVol');
model.result('pg4').feature('mesh1').set('colorrangeunitinterval', false);
model.result('pg1').run;

model.study('std1').feature('param').set('plot', true);

model.batch('p1').run('compute');

model.result('pg1').run;
model.result.dataset.create('mir1', 'Mirror3D');
model.result.dataset('mir1').label('Mirror 3D, symmetry yz-plane');
model.result.dataset('mir1').set('data', 'dset2');
model.result.dataset.create('mir2', 'Mirror3D');
model.result.dataset('mir2').set('data', 'mir1');
model.result.dataset('mir2').label('Mirror 3D, symmetry xz-plane');
model.result.dataset('mir2').set('quickplane', 'xz');
model.result.dataset.duplicate('mir3', 'mir2');
model.result.dataset('mir3').set('vectortrans', 'antisymmetric');
model.result.dataset('mir3').set('hasvar', true);
model.result.dataset('mir3').label('Mirror 3D, antisymmetry xz-plane');
model.result.dataset('dset2').set('frametype', 'material');
model.result('pg1').run;
model.result('pg1').set('data', 'mir2');
model.result('pg1').run;
model.result('pg1').feature('vol1').set('unit', 'MPa');
model.result('pg1').feature('vol1').create('def1', 'Deform');
model.result('pg1').run;
model.result('pg1').feature('vol1').feature('def1').set('scaleactive', true);
model.result('pg1').feature('vol1').feature('def1').set('scale', 1);
model.result('pg1').run;
model.result('pg2').run;
model.result('pg2').set('data', 'mir3');
model.result('pg2').run;
model.result('pg2').feature('mslc1').set('xcoord', 0);
model.result('pg2').feature('mslc1').set('ycoord', '');
model.result('pg2').feature('mslc1').set('zcoord', '-dm*1.1');
model.result('pg2').run;
model.result('pg2').feature('strmsl1').set('xcoord', 0);
model.result('pg2').feature('strmsl1').set('ycoord', '');
model.result('pg2').feature('strmsl1').set('zcoord', '-dm*1.1');
model.result('pg2').feature('strmsl1').set('udist', 0.015);
model.result('pg2').run;
model.result('pg2').run;
model.result('pg2').set('view', 'new');
model.result('pg2').run;
model.result('pg1').run;
model.result.duplicate('pg5', 'pg1');
model.result('pg5').run;
model.result('pg5').label('Displacement (solid)');
model.result('pg5').run;
model.result('pg5').feature('vol1').set('expr', 'solid.disp');
model.result('pg5').feature('vol1').set('unit', 'mm');
model.result('pg5').feature('vol1').set('colortable', 'SpectrumLight');
model.result('pg5').run;

model.cpl.create('maxop1', 'Maximum', 'geom1');
model.cpl('maxop1').selection.set([3]);

model.physics('mfnc').create('fcal1', 'ForceCalculation', 3);
model.physics('mfnc').feature('fcal1').label('Force Calculation, for Postprocessing');
model.physics('mfnc').feature('fcal1').selection.set([3]);

model.sol('sol1').updateSolution;
model.sol('sol2').updateSolution;

model.result.create('pg6', 'PlotGroup1D');
model.result('pg6').run;
model.result('pg6').label('Maximum displacement');
model.result('pg6').set('data', 'dset2');
model.result('pg6').set('titletype', 'manual');
model.result('pg6').set('title', 'Maximum of relative vertical displacement (in %)');
model.result('pg6').set('showlegends', false);
model.result('pg6').create('glob1', 'Global');
model.result('pg6').feature('glob1').set('markerpos', 'datapoints');
model.result('pg6').feature('glob1').set('linewidth', 'preference');
model.result('pg6').feature('glob1').setIndex('expr', 'maxop1(w/dm)', 0);
model.result('pg6').feature('glob1').setIndex('unit', '%', 0);
model.result('pg6').feature('glob1').setIndex('descr', 'max(w/dm)', 0);
model.result('pg6').feature('glob1').set('linemarker', 'cycle');
model.result('pg6').run;
model.result.create('pg7', 'PlotGroup1D');
model.result('pg7').run;
model.result('pg7').label('Total force');
model.result('pg7').set('data', 'dset2');
model.result('pg7').create('glob1', 'Global');
model.result('pg7').feature('glob1').set('markerpos', 'datapoints');
model.result('pg7').feature('glob1').set('linewidth', 'preference');
model.result('pg7').feature('glob1').set('expr', {'mfnc.Forcez_0'});
model.result('pg7').feature('glob1').set('descr', {'Electromagnetic force, z-component'});
model.result('pg7').feature('glob1').set('unit', {'N'});
model.result('pg7').feature('glob1').setIndex('expr', '4*mfnc.Forcez_0', 0);
model.result('pg7').feature('glob1').setIndex('unit', 'N', 0);
model.result('pg7').feature('glob1').setIndex('descr', 'Total electromagnetic force, z-component', 0);
model.result('pg7').feature('glob1').set('linemarker', 'cycle');
model.result('pg7').run;
model.result('pg7').create('glob2', 'Global');
model.result('pg7').feature('glob2').set('markerpos', 'datapoints');
model.result('pg7').feature('glob2').set('linewidth', 'preference');
model.result('pg7').feature('glob2').set('expr', {'solid.RFtotalz'});
model.result('pg7').feature('glob2').set('descr', {'Total reaction force, z-component'});
model.result('pg7').feature('glob2').set('unit', {'N'});
model.result('pg7').feature('glob2').setIndex('expr', '-4*solid.RFtotalz', 0);
model.result('pg7').feature('glob2').setIndex('unit', 'N', 0);
model.result('pg7').feature('glob2').setIndex('descr', 'Total reaction force, z-component (with minus sign)', 0);
model.result('pg7').feature('glob2').set('linestyle', 'dashed');
model.result('pg7').feature('glob2').set('linecolor', 'red');
model.result('pg7').run;
model.result('pg1').run;

model.title('Deformation of an Iron Plate by Magnetic Force');

model.description('A strong permanent magnet is placed close to a clamped thin plate made of iron. The magnetic force causes the plate to be deflected. This example studies the plate elastic deformation and stress. The deformation of the plate has an influence on the distribution of the magnetic field. This effect is accounted for using the moving mesh in the air surrounding the plate. The model is set up using the Magnetomechanics, No Currents multiphysics interface.');

model.mesh.clearMeshes;

model.sol('sol1').clearSolutionData;
model.sol('sol2').clearSolutionData;
model.sol('sol3').clearSolutionData;
model.sol('sol4').clearSolutionData;
model.sol('sol5').clearSolutionData;
model.sol('sol6').clearSolutionData;

model.label('plate_deflected_by_magnet.mph');

model.modelNode.label('Components');

out = model;
