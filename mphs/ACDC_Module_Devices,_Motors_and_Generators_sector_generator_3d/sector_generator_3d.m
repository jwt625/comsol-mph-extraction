function out = model
%
% sector_generator_3d.m
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
model.study('std1').create('ccc', 'CoilCurrentCalculation');
model.study('std1').feature('ccc').set('CoilName', '1');
model.study('std1').feature('ccc').set('outputmap', {});
model.study('std1').feature('ccc').set('ngenAUX', '1');
model.study('std1').feature('ccc').set('goalngenAUX', '1');
model.study('std1').feature('ccc').set('ngenAUX', '1');
model.study('std1').feature('ccc').set('goalngenAUX', '1');
model.study('std1').feature('ccc').setSolveFor('/physics/rmm', true);

model.param.set('d_wire', '3[mm]');
model.param.descr('d_wire', 'Diameter of wire in the winding');
model.param.set('N', '100');
model.param.descr('N', 'Number of turns in the winding');
model.param.set('rpm', '60[rpm]');
model.param.descr('rpm', 'Angular velocity of the rotor');

model.geom('geom1').insertFile('sector_generator_3d_geom_sequence.mph', 'geom1');
model.geom('geom1').run('fin');

model.coordSystem.create('sys2', 'geom1', 'Cylindrical');

model.selection.create('sel1', 'Explicit');
model.selection('sel1').model('comp1');
model.selection('sel1').label('Stator Coil');

model.view('view1').set('renderwireframe', true);

model.selection('sel1').set([17 19 20 22 23 24]);
model.selection.create('sel2', 'Explicit');
model.selection('sel2').model('comp1');
model.selection('sel2').label('Permanent Magnet');
model.selection('sel2').set([9 10]);
model.selection.create('sel3', 'Explicit');
model.selection('sel3').model('comp1');
model.selection('sel3').label('Rotating Domains');
model.selection('sel3').set([1 2 3 4 5 6 7 8 9 10]);
model.selection.create('com1', 'Complement');
model.selection('com1').model('comp1');
model.selection('com1').label('Stationary Domains');
model.selection('com1').set('input', {'sel3'});
model.selection.create('sel4', 'Explicit');
model.selection('sel4').model('comp1');
model.selection('sel4').label('Periodic Condition: Rotor');
model.selection('sel4').geom(2);
model.selection('sel4').set([1 2 6 7 14 18 23 27]);
model.selection.create('sel5', 'Explicit');
model.selection('sel5').model('comp1');
model.selection('sel5').label('Periodic Condition: Stator, Scalar Potential');
model.selection('sel5').geom(2);
model.selection('sel5').set([49 52 56 59]);
model.selection.create('sel6', 'Explicit');
model.selection('sel6').model('comp1');
model.selection('sel6').label('Periodic Condition: Stator, Vector Potential');
model.selection('sel6').geom(2);
model.selection('sel6').set([75 78 96 98 118 125]);
model.selection.create('sel7', 'Explicit');
model.selection('sel7').model('comp1');
model.selection('sel7').label('Destination');
model.selection('sel7').geom(2);
model.selection('sel7').set([41 42 43 44]);
model.selection.create('sel8', 'Explicit');
model.selection('sel8').model('comp1');
model.selection('sel8').label('Source');
model.selection('sel8').geom(2);
model.selection('sel8').set([48 51 55 58]);

model.pair('ap1').swap;

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
model.material('mat2').selection.set([1 2 5 6 15 16]);
model.material('mat3').selection.named('sel2');

model.physics('rmm').create('mfc1', 'MagneticFluxConservation', 3);
model.physics('rmm').feature('mfc1').label('Magnetic Flux Conservation: Air Gap');
model.physics('rmm').feature('mfc1').selection.set([3 4 7 8 11 12 13 14]);
model.physics('rmm').create('mfc2', 'MagneticFluxConservation', 3);
model.physics('rmm').feature('mfc2').label('Magnetic Flux Conservation: Rotor Iron');
model.physics('rmm').feature('mfc2').selection.set([1 2 5 6]);
model.physics('rmm').feature('mfc2').set('ConstitutiveRelationBH', 'BHCurve');
model.physics('rmm').feature('mfc2').create('loss1', 'LossCalculation', 3);
model.physics('rmm').feature('mfc2').feature('loss1').set('LossModel', 'Bertotti');
model.physics('rmm').create('al2', 'AmperesLaw', 3);
model.physics('rmm').feature('al2').label(['Amp' native2unicode(hex2dec({'00' 'e8'}), 'unicode') 're''s Law: Stator Iron']);
model.physics('rmm').feature('al2').selection.set([15 16]);
model.physics('rmm').feature('al2').set('ConstitutiveRelationBH', 'BHCurve');
model.physics('rmm').feature('al2').create('loss1', 'LossCalculation', 3);
model.physics('rmm').feature('al2').feature('loss1').set('LossModel', 'Bertotti');
model.physics('rmm').create('cmag1', 'ConductingMagnet', 3);
model.physics('rmm').feature('cmag1').selection.named('sel2');
model.physics('rmm').feature('cmag1').set('ConstrainForInducedCurrents', 'NoInducedCurrentsConstrain');
model.physics('rmm').feature('cmag1').feature('north1').selection.set([45 46]);
model.physics('rmm').feature('cmag1').feature('south1').selection.set([30 34]);
model.physics('rmm').feature('cmag1').create('loss1', 'LossCalculation', 3);
model.physics('rmm').create('coil1', 'Coil', 3);
model.physics('rmm').feature('coil1').selection.named('sel1');
model.physics('rmm').feature('coil1').set('ConductorModel', 'Multi');
model.physics('rmm').feature('coil1').set('CoilType', 'Numeric');
model.physics('rmm').feature('coil1').set('ICoil', '0[A]');
model.physics('rmm').feature('coil1').set('N', 'N');
model.physics('rmm').feature('coil1').set('AreaFrom', 'Diameter');
model.physics('rmm').feature('coil1').set('coilWindDiameter', 'd_wire');
model.physics('rmm').feature('coil1').feature('ccc1').set('fl', 16);
model.physics('rmm').feature('coil1').feature('ccc1').feature('ct1').selection.set([97]);
model.physics('rmm').feature('coil1').feature('ccc1').create('cg1', 'CoilGround', 2);
model.physics('rmm').feature('coil1').feature('ccc1').feature('cg1').selection.set([76]);
model.physics('rmm').create('gfa1', 'GaugeFixingA', 3);
model.physics('rmm').create('ssc1', 'SectorSymmetry', 2);
model.physics('rmm').feature('ssc1').set('pairs', {'ap1'});
model.physics('rmm').feature('ssc1').set('nsector', 8);
model.physics('rmm').feature('ssc1').set('PeriodicType', 'AntiPeriodicity');
model.physics('rmm').feature('ssc1').set('constraintOptions', 'weakConstraints');
model.physics('rmm').create('pc1', 'PeriodicCondition', 2);
model.physics('rmm').feature('pc1').selection.named('sel4');
model.physics('rmm').feature('pc1').set('PeriodicType', 'AntiPeriodicity');
model.physics('rmm').create('pc2', 'PeriodicCondition', 2);
model.physics('rmm').feature('pc2').selection.named('sel5');
model.physics('rmm').feature('pc2').set('PeriodicType', 'AntiPeriodicity');
model.physics('rmm').create('pc3', 'PeriodicCondition', 2);
model.physics('rmm').feature('pc3').selection.named('sel6');
model.physics('rmm').feature('pc3').set('PeriodicType', 'AntiPeriodicity');

model.common.create('rot1', 'RotatingDomain', 'comp1');
model.common('rot1').selection.all;
model.common('rot1').selection.named('sel3');
model.common('rot1').set('rotationType', 'rotationalVelocity');
model.common('rot1').set('rotationalVelocityExpression', 'constantRevolutionsPerTime');
model.common('rot1').set('revolutionsPerTime', 'rpm');

model.physics('rmm').prop('ShapeProperty').set('order_magneticvectorpotential', 1);
model.physics('rmm').prop('ShapeProperty').set('order_magneticscalarpotential', 1);

model.material('mat1').propertyGroup('def').set('electricconductivity', {'1[S/m]'});
model.material('mat2').propertyGroup('def').set('electricconductivity', {'1[S/m]'});

model.mesh('mesh1').create('ftet1', 'FreeTet');
model.mesh('mesh1').feature('ftet1').selection.geom('geom1', 3);
model.mesh('mesh1').feature('ftet1').selection.set([4 14 21 22 23]);
model.mesh('mesh1').run('ftet1');
model.mesh('mesh1').create('swe1', 'Sweep');
model.mesh('mesh1').feature('swe1').selection.geom('geom1', 3);
model.mesh('mesh1').feature('swe1').selection.set([2 6 8 10 13 16 24]);
model.mesh('mesh1').feature('swe1').create('dis1', 'Distribution');
model.mesh('mesh1').feature('swe1').feature('dis1').set('type', 'predefined');
model.mesh('mesh1').feature('swe1').feature('dis1').set('elemcount', 10);
model.mesh('mesh1').feature('swe1').feature('dis1').set('elemratio', 10);
model.mesh('mesh1').feature('swe1').feature('dis1').set('growthrate', 'exponential');
model.mesh('mesh1').run('swe1');
model.mesh('mesh1').create('cpd1', 'CopyDomain');
model.mesh('mesh1').feature('cpd1').selection('source').geom(3);
model.mesh('mesh1').feature('cpd1').selection('destination').geom(3);
model.mesh('mesh1').feature('cpd1').selection('source').set([2 4 6 8 10 13 14 16 21 22 23 24]);
model.mesh('mesh1').feature('cpd1').selection('destination').set([1 3 5 7 9 11 12 15 17 18 19 20]);
model.mesh('mesh1').run;

model.study('std1').create('stat', 'Stationary');
model.study('std1').create('time', 'Transient');
model.study('std1').feature('time').set('tlist', 'range(0,0.005,0.25)');
model.study('std1').feature('time').set('useadvanceddisable', true);
model.study('std1').feature('time').set('disabledphysics', {'rmm/gfa1'});

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
model.sol('sol1').create('su2', 'StoreSolution');
model.sol('sol1').create('st3', 'StudyStep');
model.sol('sol1').feature('st3').set('study', 'std1');
model.sol('sol1').feature('st3').set('studystep', 'time');
model.sol('sol1').create('v3', 'Variables');
model.sol('sol1').feature('v3').set('initmethod', 'sol');
model.sol('sol1').feature('v3').set('initsol', 'sol1');
model.sol('sol1').feature('v3').set('initsoluse', 'sol3');
model.sol('sol1').feature('v3').set('notsolmethod', 'sol');
model.sol('sol1').feature('v3').set('notsol', 'sol1');
model.sol('sol1').feature('v3').set('notsoluse', 'sol3');
model.sol('sol1').feature('v3').set('control', 'time');
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
model.sol('sol1').feature('v2').set('notsolnum', 'auto');
model.sol('sol1').feature('v2').set('notsolvertype', 'solnum');
model.sol('sol1').feature('v2').set('solnum', 'auto');
model.sol('sol1').feature('v2').set('solvertype', 'solnum');
model.sol('sol1').attach('std1');
model.sol('sol1').feature('s2').set('stol', '1e-6');
model.sol('sol1').feature('v3').set('scalemethod', 'none');
model.sol('sol1').feature('t1').feature('dDef').set('linsolver', 'pardiso');
model.sol('sol1').feature('t1').feature('fc1').set('jtech', 'onevery');

model.result.dataset('dset1').selection.geom('geom1', 3);
model.result.dataset('dset1').selection.geom('geom1', 3);
model.result.dataset('dset1').selection.set([1 2 5 6 9 10 15 16]);
model.result.dataset.create('sec1', 'Sector3D');
model.result.dataset('sec1').set('sectors', 8);
model.result.dataset('sec1').set('rotinv', true);
model.result.dataset.create('mir1', 'Mirror3D');
model.result.dataset('mir1').label('Complete Geometry, Iron');
model.result.dataset('mir1').set('data', 'sec1');
model.result.dataset('mir1').set('quickplane', 'xy');
model.result.create('pg1', 'PlotGroup3D');
model.result('pg1').run;
model.result('pg1').label('Magnetic Flux Density (Radial Component)');
model.result('pg1').set('data', 'mir1');
model.result('pg1').set('titletype', 'label');
model.result('pg1').set('frametype', 'spatial');
model.result('pg1').set('showlegendsmaxmin', true);
model.result('pg1').set('showlegendsunit', true);
model.result('pg1').create('vol1', 'Volume');
model.result('pg1').feature('vol1').set('expr', 'sys2.e_r1');
model.result('pg1').feature('vol1').set('descr', 'Base vector (sys2) r, x-component');
model.result('pg1').feature('vol1').set('expr', 'sys2.e_r1*rmm.Bx+sys2.e_r2*rmm.By');
model.result('pg1').feature('vol1').set('descractive', true);
model.result('pg1').feature('vol1').set('descr', 'Magnetic flux density, r component');
model.result('pg1').feature('vol1').set('colortable', 'Dipole');
model.result('pg1').feature('vol1').set('colorscalemode', 'linearsymmetric');

model.study('std1').feature('time').set('plot', true);
model.study('std1').feature('time').set('plotfreq', 'tsteps');
model.study('std1').setGenPlots(false);

model.sol('sol1').runAll;

model.result('pg1').run;
model.result('pg1').set('data', 'dset1');
model.result('pg1').run;
model.result('pg1').set('data', 'mir1');
model.result('pg1').setIndex('looplevel', 17, 0);
model.result('pg1').run;
model.result.create('pg2', 'PlotGroup1D');
model.result('pg2').run;
model.result('pg2').label('Induced Coil Voltage');
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

model.sol.create('sol4');
model.sol('sol4').study('std2');
model.sol('sol4').create('st1', 'StudyStep');
model.sol('sol4').feature('st1').set('study', 'std2');
model.sol('sol4').feature('st1').set('studystep', 'emloss');
model.sol('sol4').create('v1', 'Variables');
model.sol('sol4').feature('v1').set('control', 'emloss');
model.sol('sol4').create('fft1', 'FFT');
model.sol('sol4').feature('fft1').set('control', 'emloss');
model.sol('sol1').getPVals;

model.study('std2').feature('emloss').set('fftendtime', 0.25);
model.study('std2').feature('emloss').set('fftstarttime', '0.25[s]-((0.25)[s])');
model.study('std2').feature('emloss').set('fftmaxfreq', '6/((0.25)[s])');

model.sol('sol4').create('su1', 'StoreSolution');
model.sol('sol4').create('cms1', 'CombineSolution');
model.sol('sol4').feature('cms1').set('soloper', 'gensum');
model.sol('sol4').feature('cms1').setIndex('gensumexpressionactive', 'on', 13);
model.sol('sol4').feature('cms1').setIndex('gensumexpression', 'comp1.rmm.Qloss', 13);
model.sol('sol4').feature('cms1').set('control', 'emloss');
model.sol('sol4').attach('std2');
model.sol('sol4').runAll;

model.result.create('pg3', 'PlotGroup3D');
model.result('pg3').label('Cycle Averaged Losses (rmm)');
model.result('pg3').set('data', 'dset4');
model.result('pg3').set('frametype', 'spatial');
model.result('pg3').set('showlegendsmaxmin', true);
model.result('pg3').set('data', 'dset4');
model.result('pg3').set('defaultPlotID', 'InterfaceComponents/PlotDefaults/icom7/pdef1/pcond1/pcond1/pg1');
model.result('pg3').feature.create('vol1', 'Volume');
model.result('pg3').feature('vol1').set('showsolutionparams', 'on');
model.result('pg3').feature('vol1').set('solutionparams', 'parent');
model.result('pg3').feature('vol1').set('expr', 'rmm.Qh');
model.result('pg3').feature('vol1').set('colortable', 'GrayBody');
model.result('pg3').feature('vol1').set('showsolutionparams', 'on');
model.result('pg3').feature('vol1').set('data', 'parent');
model.result('pg3').feature('vol1').feature.create('filt1', 'Filter');
model.result('pg3').feature('vol1').feature('filt1').set('expr', 'rmm.isLossCalculationDomain');
model.result('pg3').run;
model.result.numerical.create('int1', 'IntVolume');
model.result.numerical('int1').set('data', 'dset4');
model.result.numerical('int1').selection.set([1 2 5 6 9 10 15 16]);
model.result.numerical('int1').setIndex('expr', 'rmm.Qh*16', 0);
model.result.numerical('int1').setIndex('descr', 'Loss power', 0);
model.result.table.create('tbl1', 'Table');
model.result.table('tbl1').comments('Volume Integration 1');
model.result.numerical('int1').set('table', 'tbl1');
model.result.numerical('int1').setResult;
model.result.export.create('anim1', 'Animation');
model.result.export('anim1').set('target', 'player');
model.result.export('anim1').set('fontsize', '9');
model.result.export('anim1').set('colortheme', 'globaltheme');
model.result.export('anim1').set('customcolor', [1 1 1]);
model.result.export('anim1').set('background', 'color');
model.result.export('anim1').set('gltfincludelines', 'on');
model.result.export('anim1').set('title1d', 'on');
model.result.export('anim1').set('legend1d', 'on');
model.result.export('anim1').set('logo1d', 'on');
model.result.export('anim1').set('options1d', 'on');
model.result.export('anim1').set('title2d', 'on');
model.result.export('anim1').set('legend2d', 'on');
model.result.export('anim1').set('logo2d', 'on');
model.result.export('anim1').set('options2d', 'off');
model.result.export('anim1').set('title3d', 'on');
model.result.export('anim1').set('legend3d', 'on');
model.result.export('anim1').set('logo3d', 'on');
model.result.export('anim1').set('options3d', 'off');
model.result.export('anim1').set('axisorientation', 'on');
model.result.export('anim1').set('grid', 'on');
model.result.export('anim1').set('axes1d', 'on');
model.result.export('anim1').set('axes2d', 'on');
model.result.export('anim1').set('showgrid', 'on');
model.result.export('anim1').showFrame;
model.result.export('anim1').set('repeat', 'iterations');
model.result.export('anim1').set('iterations', 10);
model.result('pg1').run;
model.result('pg1').run;

model.title('Modeling of an Electric Generator in 3D');

model.description(['This application illustrates how to model an electric machine, such as a generator, motor, or drive, by exploiting its sector symmetry to reduce the size of the problem. The machine being studied is a simplified electric generator in 3D, based on the geometry used in the generator_2d application.' newline  newline 'The application uses the Rotating Machinery, Magnetic interface. It is recommended to have a look at the model rotating_machinery_3d_tutorial before proceeding with this application.']);

model.mesh.clearMeshes;

model.sol('sol1').clearSolutionData;
model.sol('sol2').clearSolutionData;
model.sol('sol3').clearSolutionData;
model.sol('sol4').clearSolutionData;
model.sol('sol5').clearSolutionData;

model.label('sector_generator_3d.mph');

model.modelNode.label('Components');

out = model;
