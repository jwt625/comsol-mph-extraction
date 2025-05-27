function out = model
%
% nonlinear_magnetostriction.m
%
% Model exported on May 26 2025, 21:24 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/ACDC_Module/Electromagnetics_and_Mechanics');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 2);
model.geom('geom1').model('comp1');
model.geom('geom1').axisymmetric(true);

model.mesh.create('mesh1', 'geom1');

model.physics.create('solid', 'SolidMechanics', 'geom1');
model.physics('solid').model('comp1');
model.physics.create('mf', 'InductionCurrents', 'geom1');
model.physics('mf').model('comp1');
model.physics('mf').create('alnm1', 'AmperesLawNonlinearMagnetostrictive');
model.physics('mf').feature('alnm1').selection.all;

model.multiphysics.create('npzm1', 'NonlinearMagnetostriction', 'geom1', 2);
model.multiphysics('npzm1').set('Solid_physics', 'solid');
model.multiphysics('npzm1').set('MagneticFields_physics', 'mf');
model.multiphysics('npzm1').selection.all;

model.study.create('std1');
model.study('std1').create('stat', 'Stationary');
model.study('std1').feature('stat').setSolveFor('/physics/solid', true);
model.study('std1').feature('stat').setSolveFor('/physics/mf', true);
model.study('std1').feature('stat').setSolveFor('/multiphysics/npzm1', true);

model.geom('geom1').lengthUnit('mm');
model.geom('geom1').create('r1', 'Rectangle');
model.geom('geom1').feature('r1').set('size', [3 50]);
model.geom('geom1').feature('r1').set('pos', [0 -25]);
model.geom('geom1').run('r1');
model.geom('geom1').create('copy1', 'Copy');
model.geom('geom1').feature('copy1').selection('input').set({'r1'});
model.geom('geom1').feature('copy1').set('displx', 7.5);
model.geom('geom1').run('copy1');
model.geom('geom1').create('r2', 'Rectangle');
model.geom('geom1').feature('r2').set('size', [20 5]);
model.geom('geom1').feature('r2').set('pos', [0 -30]);
model.geom('geom1').run('r2');
model.geom('geom1').create('copy2', 'Copy');
model.geom('geom1').feature('copy2').selection('input').set({'r2'});
model.geom('geom1').feature('copy2').set('disply', 55);
model.geom('geom1').run('copy2');
model.geom('geom1').create('r3', 'Rectangle');
model.geom('geom1').feature('r3').set('size', [5 50]);
model.geom('geom1').feature('r3').set('pos', [15 -25]);
model.geom('geom1').run('r3');
model.geom('geom1').create('r4', 'Rectangle');
model.geom('geom1').feature('r4').set('size', [90 180]);
model.geom('geom1').feature('r4').set('pos', [0 -90]);
model.geom('geom1').run('r4');
model.geom('geom1').create('uni1', 'Union');
model.geom('geom1').feature('uni1').selection('input').set({'copy2' 'r2' 'r3'});
model.geom('geom1').feature('uni1').set('intbnd', false);
model.geom('geom1').run('uni1');
model.geom('geom1').create('pt1', 'Point');
model.geom('geom1').runPre('fin');

model.param.set('J0', '1e6[A/m^2]');
model.param.descr('J0', 'Current density');
model.param.set('F0', '0[MPa]');
model.param.descr('F0', 'Mechanical load');

model.geom('geom1').run;

model.physics('solid').selection.set([3]);
model.physics('mf').create('als1', 'AmperesLawSolid', 2);
model.physics('mf').feature('als1').selection.set([2]);
model.physics('mf').feature('als1').set('ConstitutiveRelationBH', 'BHCurve');
model.physics('mf').feature('alnm1').selection.set([3]);
model.physics('mf').create('ecd1', 'ExternalCurrentDensity', 2);
model.physics('mf').feature('ecd1').selection.set([5]);
model.physics('mf').feature('ecd1').set('Je', {'0' 'J0' '0'});

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
model.material('mat1').selection.set([1 4 5 6]);
model.material('mat2').selection.set([2]);
model.material.create('mat3', 'Common', 'comp1');
model.material('mat3').label('Magnetostrictive');
model.material('mat3').selection.set([3]);
model.material('mat3').propertyGroup.create('Enu', 'Young''s_modulus_and_Poisson''s_ratio');
model.material('mat3').propertyGroup('Enu').set('E', {'60e9'});
model.material('mat3').propertyGroup('Enu').set('nu', {'0.45'});
model.material('mat3').propertyGroup('def').set('density', {'7870'});
model.material('mat3').propertyGroup.create('Magnetostrictive', 'Magnetostrictive');
model.material('mat3').propertyGroup('Magnetostrictive').set('chi0', {'200'});
model.material('mat3').propertyGroup.create('JilesAtherton', 'Jiles-Atherton_model_parameters');
model.material('mat3').propertyGroup('JilesAtherton').set('alphaJA', {'0'});
model.material('mat3').propertyGroup('def').set('electricconductivity', {'5.96e6'});
model.material('mat3').propertyGroup('def').set('relpermittivity', {'1'});
model.material('mat3').propertyGroup('Magnetostrictive').set('Ms', {'1.5e6'});
model.material('mat3').propertyGroup('Magnetostrictive').set('lambdas', {'200[ppm]'});

model.physics('solid').create('fix1', 'Fixed', 1);
model.physics('solid').feature('fix1').selection.set([6]);

model.mesh('mesh1').create('fq1', 'FreeQuad');
model.mesh('mesh1').feature('fq1').selection.geom('geom1', 2);
model.mesh('mesh1').feature('fq1').selection.set([2 3]);
model.mesh('mesh1').feature('fq1').create('size1', 'Size');
model.mesh('mesh1').feature('fq1').feature('size1').set('custom', true);
model.mesh('mesh1').feature('fq1').feature('size1').set('hmaxactive', true);
model.mesh('mesh1').feature('fq1').feature('size1').set('hmax', 0.75);
model.mesh('mesh1').create('ftri1', 'FreeTri');
model.mesh('mesh1').run;

model.sol.create('sol1');
model.sol('sol1').study('std1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'stat');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').feature('comp1_u').set('scalemethod', 'manual');
model.sol('sol1').feature('v1').feature('comp1_u').set('scaleval', '1e-2*0.20124611797498107');
model.sol('sol1').feature('v1').set('control', 'stat');
model.sol('sol1').create('s1', 'Stationary');
model.sol('sol1').feature('s1').feature('aDef').set('cachepattern', true);
model.sol('sol1').feature('s1').create('seDef', 'Segregated');
model.sol('sol1').feature('s1').create('se1', 'Segregated');
model.sol('sol1').feature('s1').feature('se1').feature.remove('ssDef');
model.sol('sol1').feature('s1').feature('se1').create('ss1', 'SegregatedStep');
model.sol('sol1').feature('s1').feature('se1').feature('ss1').set('segvar', {'comp1_mf_PsiOrA' 'comp1_mf_Mmg'});
model.sol('sol1').feature('s1').feature('se1').feature('ss1').set('subdtech', 'auto');
model.sol('sol1').feature('s1').feature('se1').feature('ss1').set('subminstep', 0.001);
model.sol('sol1').feature('s1').feature('se1').feature('ss1').set('usesubminsteprecovery', 'on');
model.sol('sol1').feature('s1').feature('se1').feature('ss1').set('subtermauto', 'itertol');
model.sol('sol1').feature('s1').feature('se1').feature('ss1').set('subiter', 35);
model.sol('sol1').feature('s1').feature('se1').feature('ss1').set('subntolfact', 1);
model.sol('sol1').feature('s1').create('d1', 'Direct');
model.sol('sol1').feature('s1').feature('d1').set('linsolver', 'pardiso');
model.sol('sol1').feature('s1').feature('se1').feature('ss1').set('linsolver', 'd1');
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
model.sol('sol1').feature('s1').feature.remove('fcDef');
model.sol('sol1').feature('s1').feature.remove('seDef');
model.sol('sol1').attach('std1');
model.sol('sol1').runAll;

model.result.create('pg1', 'PlotGroup2D');
model.result('pg1').set('data', 'dset1');
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
model.result('pg1').feature('surf1').feature('def').set('expr', {'u' 'w'});
model.result('pg1').feature('surf1').feature('def').set('descr', 'Displacement field');
model.result.dataset.create('dset1solidrev', 'Revolve2D');
model.result.dataset('dset1solidrev').set('data', 'dset1');
model.result.dataset('dset1solidrev').set('revangle', 225);
model.result.dataset('dset1solidrev').set('startangle', -90);
model.result.dataset('dset1solidrev').set('hasspacevars', true);
model.result.create('pg2', 'PlotGroup3D');
model.result('pg2').set('data', 'dset1solidrev');
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
model.result.create('pg3', 'PlotGroup2D');
model.result('pg3').label('Magnetic Flux Density Norm (mf)');
model.result('pg3').set('dataisaxisym', 'off');
model.result('pg3').set('frametype', 'spatial');
model.result('pg3').set('showlegendsmaxmin', true);
model.result('pg3').set('data', 'dset1');
model.result('pg3').set('defaultPlotID', 'InterfaceComponents/PlotDefaults/icom6/pdef1/pcond2/pcond2/pg1');
model.result('pg3').feature.create('surf1', 'Surface');
model.result('pg3').feature('surf1').set('showsolutionparams', 'on');
model.result('pg3').feature('surf1').set('solutionparams', 'parent');
model.result('pg3').feature('surf1').set('expr', 'mf.normB');
model.result('pg3').feature('surf1').set('colortable', 'Prism');
model.result('pg3').feature('surf1').set('colortabletrans', 'nonlinear');
model.result('pg3').feature('surf1').set('colorcalibration', -0.8);
model.result('pg3').feature('surf1').set('showsolutionparams', 'on');
model.result('pg3').feature('surf1').set('data', 'parent');
model.result('pg3').feature.create('str1', 'Streamline');
model.result('pg3').feature('str1').set('showsolutionparams', 'on');
model.result('pg3').feature('str1').set('solutionparams', 'parent');
model.result('pg3').feature('str1').set('expr', {'mf.Br' 'mf.Bz'});
model.result('pg3').feature('str1').set('titletype', 'none');
model.result('pg3').feature('str1').set('posmethod', 'uniform');
model.result('pg3').feature('str1').set('udist', 0.03);
model.result('pg3').feature('str1').set('maxlen', 0.4);
model.result('pg3').feature('str1').set('maxtime', Inf);
model.result('pg3').feature('str1').set('inheritcolor', false);
model.result('pg3').feature('str1').set('showsolutionparams', 'on');
model.result('pg3').feature('str1').set('maxtime', Inf);
model.result('pg3').feature('str1').set('showsolutionparams', 'on');
model.result('pg3').feature('str1').set('maxtime', Inf);
model.result('pg3').feature('str1').set('showsolutionparams', 'on');
model.result('pg3').feature('str1').set('maxtime', Inf);
model.result('pg3').feature('str1').set('showsolutionparams', 'on');
model.result('pg3').feature('str1').set('maxtime', Inf);
model.result('pg3').feature('str1').set('data', 'parent');
model.result('pg3').feature('str1').selection.geom('geom1', 1);
model.result('pg3').feature('str1').selection.set([1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26]);
model.result('pg3').feature('str1').set('inheritplot', 'surf1');
model.result('pg3').feature('str1').feature.create('col1', 'Color');
model.result('pg3').feature('str1').feature('col1').set('expr', 'mf.normB');
model.result('pg3').feature('str1').feature('col1').set('colortable', 'PrismDark');
model.result('pg3').feature('str1').feature('col1').set('colorlegend', false);
model.result('pg3').feature('str1').feature('col1').set('colortabletrans', 'nonlinear');
model.result('pg3').feature('str1').feature('col1').set('colorcalibration', -0.8);
model.result('pg3').feature('str1').feature.create('filt1', 'Filter');
model.result('pg3').feature('str1').feature('filt1').set('expr', '!isScalingSystemDomain');
model.result('pg3').feature.create('con1', 'Contour');
model.result('pg3').feature('con1').set('showsolutionparams', 'on');
model.result('pg3').feature('con1').set('solutionparams', 'parent');
model.result('pg3').feature('con1').set('expr', 'r*mf.Aphi');
model.result('pg3').feature('con1').set('titletype', 'none');
model.result('pg3').feature('con1').set('number', 10);
model.result('pg3').feature('con1').set('levelrounding', false);
model.result('pg3').feature('con1').set('coloring', 'uniform');
model.result('pg3').feature('con1').set('colorlegend', false);
model.result('pg3').feature('con1').set('color', 'custom');
model.result('pg3').feature('con1').set('customcolor', [0.3764705955982208 0.3764705955982208 0.3764705955982208]);
model.result('pg3').feature('con1').set('resolution', 'fine');
model.result('pg3').feature('con1').set('inheritcolor', false);
model.result('pg3').feature('con1').set('showsolutionparams', 'on');
model.result('pg3').feature('con1').set('data', 'parent');
model.result('pg3').feature('con1').set('inheritplot', 'surf1');
model.result('pg3').feature('con1').feature.create('filt1', 'Filter');
model.result('pg3').feature('con1').feature('filt1').set('expr', '!isScalingSystemDomain');
model.result.dataset.create('rev1', 'Revolve2D');
model.result.dataset('rev1').set('data', 'none');
model.result.dataset('rev1').set('startangle', -90);
model.result.dataset('rev1').set('revangle', 225);
model.result.dataset('rev1').set('data', 'dset1');
model.result.create('pg4', 'PlotGroup3D');
model.result('pg4').label('Magnetic Flux Density Norm, Revolved Geometry (mf)');
model.result('pg4').set('data', 'rev1');
model.result('pg4').set('frametype', 'spatial');
model.result('pg4').set('showlegendsmaxmin', true);
model.result('pg4').set('data', 'rev1');
model.result('pg4').set('defaultPlotID', 'InterfaceComponents/PlotDefaults/icom6/pdef1/pcond2/pcond3/pg1');
model.result('pg4').feature.create('vol1', 'Volume');
model.result('pg4').feature('vol1').set('showsolutionparams', 'on');
model.result('pg4').feature('vol1').set('solutionparams', 'parent');
model.result('pg4').feature('vol1').set('expr', 'mf.normB');
model.result('pg4').feature('vol1').set('colortable', 'Prism');
model.result('pg4').feature('vol1').set('colortabletrans', 'nonlinear');
model.result('pg4').feature('vol1').set('colorcalibration', -0.8);
model.result('pg4').feature('vol1').set('showsolutionparams', 'on');
model.result('pg4').feature('vol1').set('data', 'parent');
model.result('pg4').feature.create('con1', 'Contour');
model.result('pg4').feature('con1').set('showsolutionparams', 'on');
model.result('pg4').feature('con1').set('solutionparams', 'parent');
model.result('pg4').feature('con1').set('expr', 'r*mf.Aphi');
model.result('pg4').feature('con1').set('titletype', 'none');
model.result('pg4').feature('con1').set('number', 10);
model.result('pg4').feature('con1').set('levelrounding', false);
model.result('pg4').feature('con1').set('coloring', 'uniform');
model.result('pg4').feature('con1').set('colorlegend', false);
model.result('pg4').feature('con1').set('color', 'custom');
model.result('pg4').feature('con1').set('customcolor', [0.3764705955982208 0.3764705955982208 0.3764705955982208]);
model.result('pg4').feature('con1').set('resolution', 'fine');
model.result('pg4').feature('con1').set('inheritcolor', false);
model.result('pg4').feature('con1').set('showsolutionparams', 'on');
model.result('pg4').feature('con1').set('data', 'parent');
model.result('pg4').feature('con1').set('inheritplot', 'vol1');
model.result('pg4').feature('con1').feature.create('filt1', 'Filter');
model.result('pg4').feature('con1').feature('filt1').set('expr', '!isScalingSystemDomain');
model.result('pg4').feature('con1').feature('filt1').set('shownodespec', 'on');
model.result('pg1').run;

model.view('view1').axis.set('xmax', 60);
model.view('view1').axis.set('xmin', -52);
model.view('view1').axis.set('ymin', -45);
model.view('view1').axis.set('ymax', 45);

model.result('pg1').run;
model.result('pg1').run;
model.result('pg1').feature('surf1').set('unit', 'MPa');
model.result('pg1').feature('surf1').set('colortabletrans', 'nonlinear');
model.result('pg1').feature('surf1').set('colorcalibration', -1);
model.result('pg2').run;
model.result('pg2').run;
model.result('pg2').feature('surf1').set('unit', 'MPa');
model.result('pg2').feature('surf1').set('colortabletrans', 'nonlinear');
model.result('pg2').feature('surf1').set('colorcalibration', -1);
model.result.create('pg5', 'PlotGroup2D');
model.result('pg5').run;
model.result('pg5').label('Strain (solid)');
model.result('pg5').create('surf1', 'Surface');
model.result('pg5').feature('surf1').set('expr', 'solid.eZZ');
model.result('pg5').feature('surf1').set('descr', 'Strain tensor, ZZ-component');
model.result('pg5').run;
model.result('pg3').run;
model.result('pg3').create('arws1', 'ArrowSurface');
model.result('pg3').feature('arws1').set('expr', {'mf.Br' 'mf.Bz'});
model.result('pg3').feature('arws1').set('xnumber', 20);
model.result('pg3').feature('arws1').set('arrowlength', 'normalized');
model.result('pg3').feature('arws1').set('color', 'black');
model.result('pg3').run;
model.result('pg4').run;
model.result('pg4').run;
model.result('pg4').feature('vol1').create('filt1', 'Filter');
model.result('pg4').run;
model.result('pg4').feature('vol1').feature('filt1').set('expr', 'dom!=1');
model.result('pg4').run;
model.result('pg4').set('edges', false);
model.result('pg4').create('arwv1', 'ArrowVolume');
model.result('pg4').feature('arwv1').set('revcoordsys', 'cylindrical');
model.result('pg4').feature('arwv1').set('expr', {'mf.Br' 'mf.Bphi' 'w'});
model.result('pg4').feature('arwv1').setIndex('expr', 'mf.Bz', 2);
model.result('pg4').feature('arwv1').set('arrowxmethod', 'coord');
model.result('pg4').feature('arwv1').set('xcoord', 'range(-20,4,20)');
model.result('pg4').feature('arwv1').set('arrowymethod', 'coord');
model.result('pg4').feature('arwv1').set('ycoord', 'range(-20,4,20)');
model.result('pg4').feature('arwv1').set('arrowzmethod', 'coord');
model.result('pg4').feature('arwv1').set('zcoord', 'range(-30,2.5,30)');
model.result('pg4').feature('arwv1').set('arrowlength', 'normalized');
model.result('pg4').feature('arwv1').set('scaleactive', true);
model.result('pg4').feature('arwv1').set('scale', 5);
model.result('pg4').feature('arwv1').set('color', 'black');
model.result('pg4').run;

model.physics('solid').create('bndl1', 'BoundaryLoad', 1);
model.physics('solid').feature('bndl1').selection.set([9]);
model.physics('solid').feature('bndl1').set('FperArea', {'0' '0' 'F0'});

model.study.create('std2');
model.study('std2').create('stat', 'Stationary');
model.study('std2').feature('stat').setSolveFor('/physics/solid', true);
model.study('std2').feature('stat').setSolveFor('/physics/mf', true);
model.study('std2').feature('stat').setSolveFor('/multiphysics/npzm1', true);
model.study('std2').setGenPlots(false);
model.study('std2').feature('stat').set('useparam', true);
model.study('std2').feature('stat').setIndex('pname', 'J0', 0);
model.study('std2').feature('stat').setIndex('plistarr', '', 0);
model.study('std2').feature('stat').setIndex('punit', 'A/m^2', 0);
model.study('std2').feature('stat').setIndex('pname', 'J0', 0);
model.study('std2').feature('stat').setIndex('plistarr', '', 0);
model.study('std2').feature('stat').setIndex('punit', 'A/m^2', 0);
model.study('std2').feature('stat').setIndex('pname', 'J0', 0);
model.study('std2').feature('stat').setIndex('plistarr', '10^{range(0,0.1,7.3)}', 0);
model.study('std2').create('param', 'Parametric');
model.study('std2').feature('param').setIndex('pname', 'J0', 0);
model.study('std2').feature('param').setIndex('plistarr', '', 0);
model.study('std2').feature('param').setIndex('punit', 'A/m^2', 0);
model.study('std2').feature('param').setIndex('pname', 'J0', 0);
model.study('std2').feature('param').setIndex('plistarr', '', 0);
model.study('std2').feature('param').setIndex('punit', 'A/m^2', 0);
model.study('std2').feature('param').setIndex('pname', 'F0', 0);
model.study('std2').feature('param').setIndex('plistarr', '0 10 30', 0);
model.study('std2').feature('param').setIndex('punit', 'MPa', 0);

model.sol.create('sol2');
model.sol('sol2').study('std2');
model.sol('sol2').create('st1', 'StudyStep');
model.sol('sol2').feature('st1').set('study', 'std2');
model.sol('sol2').feature('st1').set('studystep', 'stat');
model.sol('sol2').create('v1', 'Variables');
model.sol('sol2').feature('v1').feature('comp1_u').set('scalemethod', 'manual');
model.sol('sol2').feature('v1').feature('comp1_u').set('scaleval', '1e-2*0.20124611797498107');
model.sol('sol2').feature('v1').set('control', 'stat');
model.sol('sol2').create('s1', 'Stationary');
model.sol('sol2').feature('s1').create('p1', 'Parametric');
model.sol('sol2').feature('s1').feature.remove('pDef');
model.sol('sol2').feature('s1').feature('p1').set('control', 'stat');
model.sol('sol2').feature('s1').set('control', 'stat');
model.sol('sol2').feature('s1').feature('aDef').set('cachepattern', true);
model.sol('sol2').feature('s1').create('seDef', 'Segregated');
model.sol('sol2').feature('s1').create('se1', 'Segregated');
model.sol('sol2').feature('s1').feature('se1').feature.remove('ssDef');
model.sol('sol2').feature('s1').feature('se1').create('ss1', 'SegregatedStep');
model.sol('sol2').feature('s1').feature('se1').feature('ss1').set('segvar', {'comp1_mf_PsiOrA' 'comp1_mf_Mmg'});
model.sol('sol2').feature('s1').feature('se1').feature('ss1').set('subdtech', 'auto');
model.sol('sol2').feature('s1').feature('se1').feature('ss1').set('subminstep', 0.001);
model.sol('sol2').feature('s1').feature('se1').feature('ss1').set('usesubminsteprecovery', 'on');
model.sol('sol2').feature('s1').feature('se1').feature('ss1').set('subtermauto', 'itertol');
model.sol('sol2').feature('s1').feature('se1').feature('ss1').set('subiter', 35);
model.sol('sol2').feature('s1').feature('se1').feature('ss1').set('subntolfact', 1);
model.sol('sol2').feature('s1').create('d1', 'Direct');
model.sol('sol2').feature('s1').feature('d1').set('linsolver', 'pardiso');
model.sol('sol2').feature('s1').feature('se1').feature('ss1').set('linsolver', 'd1');
model.sol('sol2').feature('s1').feature('se1').feature('ss1').label('Magnetic Potential');
model.sol('sol2').feature('s1').feature('se1').create('ss2', 'SegregatedStep');
model.sol('sol2').feature('s1').feature('se1').feature('ss2').set('segvar', {'comp1_u'});
model.sol('sol2').feature('s1').feature('se1').feature('ss2').set('subdtech', 'auto');
model.sol('sol2').feature('s1').feature('se1').feature('ss2').set('subminstep', 0.001);
model.sol('sol2').feature('s1').feature('se1').feature('ss2').set('usesubminsteprecovery', 'on');
model.sol('sol2').feature('s1').feature('se1').feature('ss2').set('subtermauto', 'itertol');
model.sol('sol2').feature('s1').feature('se1').feature('ss2').set('subiter', 35);
model.sol('sol2').feature('s1').feature('se1').feature('ss2').set('subntolfact', 1);
model.sol('sol2').feature('s1').feature('se1').feature('ss2').set('linsolver', 'dDef');
model.sol('sol2').feature('s1').feature('se1').feature('ss2').label('Displacement Field');
model.sol('sol2').feature('s1').feature.remove('fcDef');
model.sol('sol2').feature('s1').feature.remove('seDef');
model.sol('sol2').attach('std2');

model.batch.create('p1', 'Parametric');
model.batch('p1').study('std2');
model.batch('p1').create('so1', 'Solutionseq');
model.batch('p1').feature('so1').set('seq', 'sol2');
model.batch('p1').feature('so1').set('store', 'on');
model.batch('p1').feature('so1').set('clear', 'on');
model.batch('p1').feature('so1').set('psol', 'none');
model.batch('p1').set('pname', {'F0'});
model.batch('p1').set('plistarr', {'0 10 30'});
model.batch('p1').set('sweeptype', 'sparse');
model.batch('p1').set('probesel', 'all');
model.batch('p1').set('probes', {});
model.batch('p1').set('plot', 'off');
model.batch('p1').set('err', 'on');
model.batch('p1').attach('std2');
model.batch('p1').set('control', 'param');

model.sol.create('sol3');
model.sol('sol3').study('std2');
model.sol('sol3').label('Parametric Solutions 1');

model.batch('p1').feature('so1').set('psol', 'sol3');
model.batch('p1').run('compute');

model.result.create('pg6', 'PlotGroup1D');
model.result('pg6').run;
model.result('pg6').label('Magnetostriction');
model.result('pg6').set('data', 'dset3');
model.result('pg6').set('titletype', 'manual');
model.result('pg6').set('title', 'Magnetostriction curve');
model.result('pg6').set('xlabelactive', true);
model.result('pg6').set('xlabel', 'Magnetic field (A/m)');
model.result('pg6').set('ylabelactive', true);
model.result('pg6').set('ylabel', 'Magnetostriction (ppm)');
model.result('pg6').set('legendpos', 'middleright');
model.result('pg6').create('ptgr1', 'PointGraph');
model.result('pg6').feature('ptgr1').set('markerpos', 'datapoints');
model.result('pg6').feature('ptgr1').set('linewidth', 'preference');
model.result('pg6').feature('ptgr1').selection.set([4]);
model.result('pg6').feature('ptgr1').set('expr', 'npzm1.emeZZ');
model.result('pg6').feature('ptgr1').set('descr', 'Magnetostrictive strain tensor, ZZ-component');
model.result('pg6').feature('ptgr1').set('unit', 'ppm');
model.result('pg6').feature('ptgr1').set('xdata', 'expr');
model.result('pg6').feature('ptgr1').set('xdataexpr', 'mf.HZ');
model.result('pg6').feature('ptgr1').set('xdatadescr', 'Magnetic field, Z-component');
model.result('pg6').feature('ptgr1').set('legend', true);
model.result('pg6').feature('ptgr1').set('autopoint', false);
model.result('pg6').run;
model.result('pg6').run;
model.result.duplicate('pg7', 'pg6');
model.result('pg7').run;
model.result('pg7').label('BH Curve');
model.result('pg7').set('title', 'BH curve');
model.result('pg7').set('ylabel', 'Magnetic flux density (T)');
model.result('pg7').run;
model.result('pg7').feature('ptgr1').set('expr', 'mf.BZ');
model.result('pg7').feature('ptgr1').set('descr', 'Magnetic flux density, Z-component');
model.result('pg7').run;
model.result.create('pg8', 'PlotGroup1D');
model.result('pg8').run;
model.result('pg8').label('Piezomagnetic Coefficients');
model.result('pg8').set('data', 'dset3');
model.result('pg8').setIndex('looplevelinput', 'first', 1);
model.result('pg8').set('titletype', 'manual');
model.result('pg8').set('title', 'Tangent piezomagnetic coupling coefficients');
model.result('pg8').set('xlabelactive', true);
model.result('pg8').set('xlabel', 'Magnetic field (A/m)');
model.result('pg8').set('ylabelactive', true);
model.result('pg8').set('ylabel', 'Coupling coefficients (m/A)');
model.result('pg8').create('ptgr1', 'PointGraph');
model.result('pg8').feature('ptgr1').set('markerpos', 'datapoints');
model.result('pg8').feature('ptgr1').set('linewidth', 'preference');
model.result('pg8').feature('ptgr1').selection.set([4]);
model.result('pg8').feature('ptgr1').set('expr', 'npzm1.dHT33');
model.result('pg8').feature('ptgr1').set('descr', 'Tangent piezomagnetic coupling matrix, Voigt notation, 33-component');
model.result('pg8').feature('ptgr1').set('xdata', 'expr');
model.result('pg8').feature('ptgr1').set('xdataexpr', 'mf.HZ');
model.result('pg8').feature('ptgr1').set('legend', true);
model.result('pg8').feature('ptgr1').set('legendmethod', 'manual');
model.result('pg8').feature('ptgr1').setIndex('legends', 'dHT33', 0);
model.result('pg8').feature.duplicate('ptgr2', 'ptgr1');
model.result('pg8').run;
model.result('pg8').feature('ptgr2').set('expr', 'npzm1.dHT31');
model.result('pg8').feature('ptgr2').setIndex('legends', 'dHT31', 0);
model.result('pg8').feature.duplicate('ptgr3', 'ptgr2');
model.result('pg8').run;
model.result('pg8').feature('ptgr3').set('expr', 'npzm1.dHT15');
model.result('pg8').feature('ptgr3').setIndex('legends', 'dHT15', 0);
model.result('pg8').feature.duplicate('ptgr4', 'ptgr3');
model.result('pg8').run;
model.result('pg8').feature('ptgr4').set('expr', '-(npzm1.dHT31+npzm1.dHT32)');
model.result('pg8').feature('ptgr4').setIndex('legends', '-(dHT31+dHT32)', 0);
model.result('pg8').feature('ptgr4').set('linestyle', 'none');
model.result('pg8').feature('ptgr4').set('linemarker', 'cycle');
model.result('pg8').feature('ptgr4').set('markerpos', 'interp');
model.result('pg8').run;

model.title('Nonlinear Magnetostrictive Transducer');

model.description('The magnetic field and displacement as functions of the applied current are computed for a magnetostrictive transducer, for which both the magnetostriction and material magnetization are assumed to be nonlinear.');

model.mesh.clearMeshes;

model.sol('sol1').clearSolutionData;
model.sol('sol2').clearSolutionData;
model.sol('sol3').clearSolutionData;
model.sol('sol4').clearSolutionData;
model.sol('sol5').clearSolutionData;
model.sol('sol6').clearSolutionData;

model.label('nonlinear_magnetostriction.mph');

model.modelNode.label('Components');

out = model;
