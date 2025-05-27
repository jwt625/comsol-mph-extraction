function out = model
%
% generator_2d.m
%
% Model exported on May 26 2025, 21:24 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/ACDC_Module/Devices,_Motors_and_Generators');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 2);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.physics.create('rmm', 'RotatingMachineryMagnetic', 'geom1');
model.physics('rmm').model('comp1');

model.study.create('std1');
model.study('std1').create('stat', 'Stationary');
model.study('std1').feature('stat').setSolveFor('/physics/rmm', true);

model.param.set('L', '0.4[m]');
model.param.descr('L', 'Length of generator');
model.param.set('rpm', '60[1/min]');
model.param.descr('rpm', 'Rotational speed of rotor');
model.param.set('d_wire', '3[mm]');
model.param.descr('d_wire', 'Diameter of wire in the winding');
model.param.set('N', '100');
model.param.descr('N', 'Number of turns in the winding');

model.geom.load({'part1'}, 'ACDC_Module\Rotating_Machinery_2D\Rotors\Internal\surface_mounted_magnet_internal_rotor_2d.mph', {'part1'});
model.geom('geom1').create('pi1', 'PartInstance');
model.geom('geom1').feature('pi1').set('selkeepnoncontr', false);
model.geom('geom1').feature('pi1').set('part', 'part1');
model.geom.load({'part2'}, 'ACDC_Module\Rotating_Machinery_2D\Stators\External\slotted_external_stator_2d.mph', {'part1'});
model.geom('geom1').run('pi1');
model.geom('geom1').create('pi2', 'PartInstance');
model.geom('geom1').feature('pi2').set('selkeepnoncontr', false);
model.geom('geom1').feature('pi2').set('part', 'part2');
model.geom('geom1').run('fin');
model.geom('geom1').feature('pi1').setEntry('inputexpr', 'number_of_poles', 8);
model.geom('geom1').feature('pi1').setEntry('inputexpr', 'number_of_modeled_poles', 8);
model.geom('geom1').feature('pi1').setEntry('inputexpr', 'shaft_diam', '10[cm]');
model.geom('geom1').feature('pi1').setEntry('inputexpr', 'rotor_diam', '30[cm]+2*6.5[cm]');
model.geom('geom1').feature('pi1').setEntry('inputexpr', 'cont_diam', '0.45[m]');
model.geom('geom1').feature('pi1').setEntry('inputexpr', 'magnet_h', '6.5[cm]');
model.geom('geom1').feature('pi1').setEntry('inputexpr', 'magnet_w', '10 [cm]');
model.geom('geom1').feature('pi1').setEntry('inputexpr', 'magnet_fillet_size', '0.6[cm]');
model.geom('geom1').feature('pi1').setEntry('selkeepdom', 'pi1_shaft.dom', true);
model.geom('geom1').feature('pi1').setEntry('selkeepdom', 'pi1_rotor_iron.dom', true);
model.geom('geom1').feature('pi1').setEntry('selkeepdom', 'pi1_magnets_odd.dom', true);
model.geom('geom1').feature('pi1').setEntry('selkeepdom', 'pi1_magnets_even.dom', true);
model.geom('geom1').feature('pi1').setEntry('selkeepdom', 'pi1_rotor_magnets', true);
model.geom('geom1').feature('pi1').setEntry('selkeepdom', 'pi1_rotor_solid_domains.dom', true);
model.geom('geom1').feature('pi1').setEntry('selkeepdom', 'pi1_rotor_air.dom', true);
model.geom('geom1').feature('pi1').setEntry('selkeepdom', 'pi1_all.dom', true);
model.geom('geom1').feature('pi2').setEntry('inputexpr', 'number_of_slots', 8);
model.geom('geom1').feature('pi2').setEntry('inputexpr', 'number_of_modeled_slots', 8);
model.geom('geom1').feature('pi2').setEntry('inputexpr', 'backiron_th', '6 [cm]');
model.geom('geom1').feature('pi2').setEntry('inputexpr', 'stator_diam', '80 [cm]');
model.geom('geom1').feature('pi2').setEntry('inputexpr', 'external_air_size', '0[cm]');
model.geom('geom1').feature('pi2').setEntry('inputexpr', 'cont_diam', '45[cm]');
model.geom('geom1').feature('pi2').setEntry('inputexpr', 'shoe_h', '1.75[cm]');
model.geom('geom1').feature('pi2').setEntry('inputexpr', 'shoe_w', '11.5[cm]');
model.geom('geom1').feature('pi2').setEntry('inputexpr', 'tooth_h', '10.5[cm]');
model.geom('geom1').feature('pi2').setEntry('inputexpr', 'tooth_w', '9[cm]');
model.geom('geom1').feature('pi2').setEntry('inputexpr', 'shoe_fillet_size', '0.4[cm]');
model.geom('geom1').feature('pi2').setEntry('inputexpr', 'slot_outer_fillet_size', '0.4[cm]');
model.geom('geom1').feature('pi2').setEntry('inputexpr', 'slot_inner_fillet_size', '0.4[cm]');
model.geom('geom1').feature('pi2').setEntry('inputexpr', 'slot_winding_type', 2);
model.geom('geom1').feature('pi2').setEntry('selkeepdom', 'pi2_stator_iron.dom', true);
model.geom('geom1').feature('pi2').setEntry('selkeepdom', 'pi2_stator_slots', true);
model.geom('geom1').feature('pi2').setEntry('selkeepdom', 'pi2_stator_air.dom', true);
model.geom('geom1').feature('pi2').setEntry('selkeepdom', 'pi2_all.dom', true);

model.selection.create('uni1', 'Union');
model.selection('uni1').model('comp1');

model.geom('geom1').run;

model.selection('uni1').set('input', {'geom1_pi1_shaft_dom' 'geom1_pi1_rotor_iron_dom' 'geom1_pi2_stator_iron_dom'});
model.selection('uni1').label('Iron');
model.selection.create('uni2', 'Union');
model.selection('uni2').model('comp1');
model.selection('uni2').set('input', {'uni1' 'geom1_pi1_rotor_magnets'});
model.selection('uni2').label('Iron and Magnets');

model.geom('geom1').feature('fin').set('action', 'assembly');
model.geom('geom1').run('fin');

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
model.material('mat2').selection.named('uni1');
model.material('mat3').selection.named('geom1_pi1_rotor_magnets');

model.physics('rmm').prop('d').set('d', 'L');

model.common.create('rot1', 'RotatingDomain', 'comp1');
model.common('rot1').selection.all;
model.common('rot1').selection.named('geom1_pi1_all_dom');
model.common('rot1').set('rotationType', 'rotationalVelocity');
model.common('rot1').set('rotationalVelocityExpression', 'constantRevolutionsPerTime');
model.common('rot1').set('revolutionsPerTime', 'rpm');

model.physics('rmm').create('cmag1', 'ConductingMagnet', 2);
model.physics('rmm').feature('cmag1').selection.named('geom1_pi1_rotor_magnets');
model.physics('rmm').feature('cmag1').set('PatternType', 'CircularPattern');
model.physics('rmm').feature('cmag1').set('PeriodicType', 'Alternating');
model.physics('rmm').feature('cmag1').feature('north1').selection.set([220]);
model.physics('rmm').feature('cmag1').feature('south1').selection.set([226]);
model.physics('rmm').feature('cmag1').create('loss1', 'LossCalculation', 2);
model.physics('rmm').create('al2', 'AmperesLaw', 2);
model.physics('rmm').feature('al2').set('ConstitutiveRelationBH', 'BHCurve');
model.physics('rmm').feature('al2').selection.named('uni1');
model.physics('rmm').feature('al2').label('Iron');
model.physics('rmm').feature('al2').create('loss1', 'LossCalculation', 2);
model.physics('rmm').feature('al2').feature('loss1').set('LossModel', 'Bertotti');
model.physics('rmm').create('coil1', 'Coil', 2);
model.physics('rmm').feature('coil1').selection.named('geom1_pi2_stator_slots');
model.physics('rmm').feature('coil1').set('ConductorModel', 'Multi');
model.physics('rmm').feature('coil1').set('ICoil', '0[A]');
model.physics('rmm').feature('coil1').set('N', 'N');
model.physics('rmm').feature('coil1').set('AreaFrom', 'Diameter');
model.physics('rmm').feature('coil1').set('coilWindDiameter', 'd_wire');
model.physics('rmm').feature('coil1').set('coilGroup', true);
model.physics('rmm').feature('coil1').create('rcd1', 'ReverseCoilGroupDomain', 2);
model.physics('rmm').feature('coil1').feature('rcd1').selection.set([1 4 8 10 11 13 16 18]);

model.study('std1').create('time', 'Transient');
model.study('std1').feature('time').set('tlist', 'range(0,0.005,0.25)');

model.selection.create('sel1', 'Explicit');
model.selection('sel1').model('comp1');
model.selection('sel1').geom(1);
model.selection('sel1').label('destination');
model.selection('sel1').set([196 197 198 212 213 240 241 255]);

model.mesh('mesh1').create('ftri1', 'FreeTri');
model.mesh('mesh1').feature('size').set('hauto', 7);
model.mesh('mesh1').feature('size').set('custom', true);
model.mesh('mesh1').feature('size').set('hmax', 0.015);
model.mesh('mesh1').feature('ftri1').create('size1', 'Size');
model.mesh('mesh1').feature('ftri1').feature('size1').selection.geom('geom1', 1);
model.mesh('mesh1').feature('ftri1').feature('size1').selection.named('sel1');
model.mesh('mesh1').feature('ftri1').feature('size1').set('hauto', 1);
model.mesh('mesh1').run;

model.physics('rmm').prop('ShapeProperty').set('order_magneticvectorpotential', 1);
model.physics('rmm').prop('ShapeProperty').set('order_magneticscalarpotential', 1);
model.physics('rmm').feature('dcont1').set('constraintOptions', 'weakConstraints');

model.sol.create('sol1');
model.sol('sol1').study('std1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'stat');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').set('control', 'stat');
model.sol('sol1').create('s1', 'Stationary');
model.sol('sol1').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('s1').feature('fc1').set('jtech', 'once');
model.sol('sol1').feature('s1').feature('fc1').set('maxiter', 100);
model.sol('sol1').feature('s1').feature('fc1').set('ntolfact', 1);
model.sol('sol1').feature('s1').feature('fc1').set('linsolver', 'dDef');
model.sol('sol1').feature('s1').feature('fc1').set('jtech', 'once');
model.sol('sol1').feature('s1').feature('fc1').set('maxiter', 100);
model.sol('sol1').feature('s1').feature('fc1').set('ntolfact', 1);
model.sol('sol1').feature('s1').feature.remove('fcDef');
model.sol('sol1').create('su1', 'StoreSolution');
model.sol('sol1').create('st2', 'StudyStep');
model.sol('sol1').feature('st2').set('study', 'std1');
model.sol('sol1').feature('st2').set('studystep', 'time');
model.sol('sol1').create('v2', 'Variables');
model.sol('sol1').feature('v2').set('initmethod', 'sol');
model.sol('sol1').feature('v2').set('initsol', 'sol1');
model.sol('sol1').feature('v2').set('initsoluse', 'sol2');
model.sol('sol1').feature('v2').set('notsolmethod', 'sol');
model.sol('sol1').feature('v2').set('notsol', 'sol1');
model.sol('sol1').feature('v2').set('notsoluse', 'sol2');
model.sol('sol1').feature('v2').set('control', 'time');
model.sol('sol1').create('t1', 'Time');
model.sol('sol1').feature('t1').set('tlist', 'range(0,0.005,0.25)');
model.sol('sol1').feature('t1').set('plot', 'off');
model.sol('sol1').feature('t1').set('plotgroup', 'Default');
model.sol('sol1').feature('t1').set('plotfreq', 'tout');
model.sol('sol1').feature('t1').set('probesel', 'all');
model.sol('sol1').feature('t1').set('probes', {});
model.sol('sol1').feature('t1').set('probefreq', 'tsteps');
model.sol('sol1').feature('t1').set('tout', 'tstepsclosest');
model.sol('sol1').feature('t1').set('atolglobalvaluemethod', 'factor');
model.sol('sol1').feature('t1').set('reacf', true);
model.sol('sol1').feature('t1').set('storeudot', true);
model.sol('sol1').feature('t1').set('tstepsbdf', 'strict');
model.sol('sol1').feature('t1').set('endtimeinterpolation', true);
model.sol('sol1').feature('t1').set('estrat', 'exclude');
model.sol('sol1').feature('t1').set('maxorder', 2);
model.sol('sol1').feature('t1').set('control', 'time');
model.sol('sol1').feature('t1').feature('aDef').set('cachepattern', true);
model.sol('sol1').feature('t1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('t1').feature('fc1').set('jtech', 'once');
model.sol('sol1').feature('t1').feature('fc1').set('maxiter', 25);
model.sol('sol1').feature('t1').feature('fc1').set('ntolfact', 0.2);
model.sol('sol1').feature('t1').feature('fc1').set('linsolver', 'dDef');
model.sol('sol1').feature('t1').feature('fc1').set('jtech', 'once');
model.sol('sol1').feature('t1').feature('fc1').set('maxiter', 25);
model.sol('sol1').feature('t1').feature('fc1').set('ntolfact', 0.2);
model.sol('sol1').feature('t1').feature.remove('fcDef');
model.sol('sol1').attach('std1');
model.sol('sol1').feature('s1').set('stol', '1e-5');
model.sol('sol1').feature('v2').set('scalemethod', 'init');
model.sol('sol1').feature('t1').feature('fc1').set('dtech', 'auto');
model.sol('sol1').feature('t1').feature('dDef').set('linsolver', 'pardiso');
model.sol('sol1').runAll;

model.result.create('pg1', 'PlotGroup2D');
model.result('pg1').label('Magnetic Flux Density Norm (rmm)');
model.result('pg1').set('frametype', 'spatial');
model.result('pg1').set('showlegendsmaxmin', true);
model.result('pg1').set('data', 'dset1');
model.result('pg1').setIndex('looplevel', 51, 0);
model.result('pg1').set('defaultPlotID', 'InterfaceComponents/PlotDefaults/icom6/pdef1/pcond2/pcond2/pg1');
model.result('pg1').feature.create('surf1', 'Surface');
model.result('pg1').feature('surf1').set('showsolutionparams', 'on');
model.result('pg1').feature('surf1').set('solutionparams', 'parent');
model.result('pg1').feature('surf1').set('colortable', 'Prism');
model.result('pg1').feature('surf1').set('colortabletrans', 'nonlinear');
model.result('pg1').feature('surf1').set('colorcalibration', -0.8);
model.result('pg1').feature('surf1').set('showsolutionparams', 'on');
model.result('pg1').feature('surf1').set('data', 'parent');
model.result('pg1').feature.create('str1', 'Streamline');
model.result('pg1').feature('str1').set('showsolutionparams', 'on');
model.result('pg1').feature('str1').set('solutionparams', 'parent');
model.result('pg1').feature('str1').set('titletype', 'none');
model.result('pg1').feature('str1').set('posmethod', 'uniform');
model.result('pg1').feature('str1').set('udist', 0.03);
model.result('pg1').feature('str1').set('maxlen', 0.4);
model.result('pg1').feature('str1').set('maxtime', Inf);
model.result('pg1').feature('str1').set('inheritcolor', false);
model.result('pg1').feature('str1').set('showsolutionparams', 'on');
model.result('pg1').feature('str1').set('maxtime', Inf);
model.result('pg1').feature('str1').set('showsolutionparams', 'on');
model.result('pg1').feature('str1').set('maxtime', Inf);
model.result('pg1').feature('str1').set('showsolutionparams', 'on');
model.result('pg1').feature('str1').set('maxtime', Inf);
model.result('pg1').feature('str1').set('showsolutionparams', 'on');
model.result('pg1').feature('str1').set('maxtime', Inf);
model.result('pg1').feature('str1').set('data', 'parent');
model.result('pg1').feature('str1').selection.geom('geom1', 1);
model.result('pg1').feature('str1').selection.set([1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40 41 42 43 44 45 46 47 48 49 50 51 52 53 54 55 56 57 58 59 60 61 62 63 64 65 66 67 68 69 70 71 72 73 74 75 76 77 78 79 80 81 82 83 84 85 86 87 88 89 90 91 92 93 94 95 96 97 98 99 100 101 102 103 104 105 106 107 108 109 110 111 112 113 114 115 116 117 118 119 120 121 122 123 124 125 126 127 128 129 130 131 132 133 134 135 136 137 138 139 140 141 142 143 144 145 146 147 148 149 150 151 152 153 154 155 156 157 158 159 160 161 162 163 164 165 166 167 168 169 170 171 172 173 174 175 176 177 178 179 180 181 182 183 184 185 186 187 188 189 190 191 192 193 194 195 196 197 198 199 200 201 202 203 204 205 206 207 208 209 210 211 212 213 214 215 216 217 218 219 220 221 222 223 224 225 226 227 228 229 230 231 232 233 234 235 236 237 238 239 240 241 242 243 244 245 246 247 248 249 250 251 252 253 254 255 256]);
model.result('pg1').feature('str1').set('inheritplot', 'surf1');
model.result('pg1').feature('str1').feature.create('col1', 'Color');
model.result('pg1').feature('str1').feature('col1').set('colortable', 'PrismDark');
model.result('pg1').feature('str1').feature('col1').set('colorlegend', false);
model.result('pg1').feature('str1').feature('col1').set('colortabletrans', 'nonlinear');
model.result('pg1').feature('str1').feature('col1').set('colorcalibration', -0.8);
model.result('pg1').feature('str1').feature.create('filt1', 'Filter');
model.result('pg1').feature('str1').feature('filt1').set('expr', '!isScalingSystemDomain');
model.result('pg1').feature.create('con1', 'Contour');
model.result('pg1').feature('con1').set('showsolutionparams', 'on');
model.result('pg1').feature('con1').set('solutionparams', 'parent');
model.result('pg1').feature('con1').set('expr', 'rmm.Az');
model.result('pg1').feature('con1').set('titletype', 'none');
model.result('pg1').feature('con1').set('number', 10);
model.result('pg1').feature('con1').set('levelrounding', false);
model.result('pg1').feature('con1').set('coloring', 'uniform');
model.result('pg1').feature('con1').set('colorlegend', false);
model.result('pg1').feature('con1').set('color', 'custom');
model.result('pg1').feature('con1').set('customcolor', [0.3764705955982208 0.3764705955982208 0.3764705955982208]);
model.result('pg1').feature('con1').set('resolution', 'fine');
model.result('pg1').feature('con1').set('inheritcolor', false);
model.result('pg1').feature('con1').set('showsolutionparams', 'on');
model.result('pg1').feature('con1').set('data', 'parent');
model.result('pg1').feature('con1').set('inheritplot', 'surf1');
model.result('pg1').feature('con1').feature.create('filt1', 'Filter');
model.result('pg1').feature('con1').feature('filt1').set('expr', '!isScalingSystemDomain');
model.result('pg1').run;
model.result('pg1').setIndex('looplevel', 41, 0);
model.result('pg1').run;
model.result.create('pg2', 'PlotGroup1D');
model.result('pg2').run;
model.result('pg2').label('Induced Coil Voltage');
model.result('pg2').set('titletype', 'manual');
model.result('pg2').set('title', 'Induced voltage');
model.result('pg2').set('xlabelactive', true);
model.result('pg2').set('xlabel', 'Time (s)');
model.result('pg2').set('ylabelactive', true);
model.result('pg2').set('ylabel', 'Voltage (V)');
model.result('pg2').create('glob1', 'Global');
model.result('pg2').feature('glob1').set('markerpos', 'datapoints');
model.result('pg2').feature('glob1').set('linewidth', 'preference');
model.result('pg2').feature('glob1').set('expr', {'rmm.VCoil_1'});
model.result('pg2').feature('glob1').set('descr', {'Coil voltage'});
model.result('pg2').feature('glob1').set('unit', {'V'});
model.result('pg2').run;

model.study.create('std2');
model.study('std2').create('emloss', 'TimeToFrequencyLosses');
model.study('std2').feature('emloss').set('fftinputstudy', 'current');
model.study('std2').feature('emloss').set('lossstarttime', '0');
model.study('std2').feature('emloss').set('notsolnum', 'auto');
model.study('std2').feature('emloss').set('outputmap', {});
model.study('std2').feature('emloss').setSolveFor('/physics/rmm', true);
model.study('std2').feature('emloss').set('fftinputstudy', 'std1');
model.study('std2').feature('emloss').set('emT0', 0.25);

model.sol.create('sol3');
model.sol('sol3').study('std2');
model.sol('sol3').create('st1', 'StudyStep');
model.sol('sol3').feature('st1').set('study', 'std2');
model.sol('sol3').feature('st1').set('studystep', 'emloss');
model.sol('sol3').create('v1', 'Variables');
model.sol('sol3').feature('v1').set('control', 'emloss');
model.sol('sol3').create('fft1', 'FFT');
model.sol('sol3').feature('fft1').set('control', 'emloss');
model.sol('sol1').getPVals;

model.study('std2').feature('emloss').set('fftendtime', 0.25);
model.study('std2').feature('emloss').set('fftstarttime', '0.25[s]-((0.25)[s])');
model.study('std2').feature('emloss').set('fftmaxfreq', '6/((0.25)[s])');

model.sol('sol3').create('su1', 'StoreSolution');
model.sol('sol3').create('cms1', 'CombineSolution');
model.sol('sol3').feature('cms1').set('soloper', 'gensum');
model.sol('sol3').feature('cms1').setIndex('gensumexpressionactive', 'on', 7);
model.sol('sol3').feature('cms1').setIndex('gensumexpression', 'comp1.rmm.Qloss', 7);
model.sol('sol3').feature('cms1').set('control', 'emloss');
model.sol('sol3').attach('std2');
model.sol('sol3').runAll;

model.result.create('pg3', 'PlotGroup2D');
model.result('pg3').label('Cycle Averaged Losses (rmm)');
model.result('pg3').set('data', 'dset3');
model.result('pg3').set('frametype', 'spatial');
model.result('pg3').set('showlegendsmaxmin', true);
model.result('pg3').set('data', 'dset3');
model.result('pg3').set('defaultPlotID', 'InterfaceComponents/PlotDefaults/icom7/pdef1/pcond1/pcond2/pg1');
model.result('pg3').feature.create('surf1', 'Surface');
model.result('pg3').feature('surf1').set('showsolutionparams', 'on');
model.result('pg3').feature('surf1').set('solutionparams', 'parent');
model.result('pg3').feature('surf1').set('expr', 'rmm.Qh');
model.result('pg3').feature('surf1').set('colortable', 'GrayBody');
model.result('pg3').feature('surf1').set('showsolutionparams', 'on');
model.result('pg3').feature('surf1').set('data', 'parent');
model.result('pg3').feature('surf1').feature.create('filt1', 'Filter');
model.result('pg3').feature('surf1').feature('filt1').set('expr', 'rmm.isLossCalculationDomain');
model.result('pg3').run;
model.result.numerical.create('int1', 'IntSurface');
model.result.numerical('int1').set('intvolume', true);
model.result.numerical('int1').set('data', 'dset3');
model.result.numerical('int1').selection.named('uni2');
model.result.numerical('int1').set('expr', {'rmm.Qh'});
model.result.numerical('int1').set('descr', {'Volumetric loss density, electromagnetic'});
model.result.numerical('int1').set('unit', {'W/m'});
model.result.numerical('int1').setIndex('expr', 'rmm.Qh*L', 0);
model.result.numerical('int1').setIndex('descr', 'Total loss power', 0);
model.result.table.create('tbl1', 'Table');
model.result.table('tbl1').comments('Surface Integration 1');
model.result.numerical('int1').set('table', 'tbl1');
model.result.numerical('int1').setResult;
model.result('pg1').run;

model.title('Generator in 2D');

model.description('A rotor with permanent magnets and a nonlinear magnetic material is rotating within a stator of the same magnetic material. The generated voltage in windings around the stator is calculated as a function of time. COMSOL Multiphysics models the rotation with assemblies and identity pairs, using a prescribed rotation coordinate transform in Moving Mesh. The nonlinearity of the magnetic material is modeled using an interpolating function defined in a material library.');

model.mesh.clearMeshes;

model.sol('sol1').clearSolutionData;
model.sol('sol2').clearSolutionData;
model.sol('sol3').clearSolutionData;
model.sol('sol4').clearSolutionData;

model.label('generator_2d.mph');

model.modelNode.label('Components');

out = model;
