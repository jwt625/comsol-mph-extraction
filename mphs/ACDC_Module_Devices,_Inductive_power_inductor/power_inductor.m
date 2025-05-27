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
