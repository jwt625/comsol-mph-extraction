function out = model
%
% magnetic_brake.m
%
% Model exported on May 26 2025, 21:24 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/ACDC_Module/Devices,_Transducers_and_Actuators');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 3);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.physics.create('mef', 'ElectricInductionCurrents', 'geom1');
model.physics('mef').model('comp1');
model.physics.create('ge', 'GlobalEquations', 'geom1');
model.physics('ge').model('comp1');
model.physics('ge').prop('EquationForm').set('form', 'Automatic');

model.study.create('std1');
model.study('std1').create('stat', 'Stationary');
model.study('std1').feature('stat').setSolveFor('/physics/mef', true);
model.study('std1').feature('stat').setSolveFor('/physics/ge', true);

model.param.set('dt', '1[cm]');
model.param.descr('dt', 'Disc thickness');
model.param.set('dr', '10[cm]');
model.param.descr('dr', 'Disc radius');
model.param.set('mh', '12[cm]');
model.param.descr('mh', 'Magnet height');
model.param.set('mw', '2[cm]');
model.param.descr('mw', 'Magnet width');
model.param.set('ml', '8[cm]');
model.param.descr('ml', 'Magnet length');
model.param.set('mt', '2[cm]');
model.param.descr('mt', 'Magnet thickness');
model.param.set('mg', '1.5[cm]');
model.param.descr('mg', 'Magnet air gap');
model.param.set('mB', '1[T]');
model.param.descr('mB', 'Magnet flux');
model.param.set('ymur', '4000');
model.param.descr('ymur', 'Yoke relative permeability');
model.param.set('dV0', '1000[rpm]');
model.param.descr('dV0', 'Disc initial angular frequency');

model.geom('geom1').create('sph1', 'Sphere');
model.geom('geom1').feature('sph1').set('r', 'dr*3');
model.geom('geom1').run('sph1');
model.geom('geom1').create('cyl1', 'Cylinder');
model.geom('geom1').feature('cyl1').label('Disc');
model.geom('geom1').feature('cyl1').set('r', 'dr');
model.geom('geom1').feature('cyl1').set('h', 'dt');
model.geom('geom1').feature('cyl1').set('pos', {'0' '0' '-dt/2'});
model.geom('geom1').feature('cyl1').set('selresult', true);
model.geom('geom1').run('cyl1');
model.geom('geom1').create('wp1', 'WorkPlane');
model.geom('geom1').feature('wp1').set('unite', true);
model.geom('geom1').feature('wp1').set('quickplane', 'yz');
model.geom('geom1').feature('wp1').set('quickx', '-mt/2');
model.geom('geom1').feature('wp1').geom.create('r1', 'Rectangle');
model.geom('geom1').feature('wp1').geom.feature('r1').set('size', {'mw' 'mh-2*mw'});
model.geom('geom1').feature('wp1').geom.feature('r1').set('base', 'center');
model.geom('geom1').feature('wp1').geom.feature('r1').set('pos', {'dr+ml/2-mw/2' '0'});
model.geom('geom1').feature('wp1').geom.run('r1');
model.geom('geom1').feature('wp1').geom.create('r2', 'Rectangle');
model.geom('geom1').feature('wp1').geom.feature('r2').set('size', {'ml-mw' 'mw'});
model.geom('geom1').feature('wp1').geom.feature('r2').set('pos', {'dr-ml/2+mw' 'mh/2-mw'});
model.geom('geom1').feature('wp1').geom.run('r2');
model.geom('geom1').feature('wp1').geom.create('r3', 'Rectangle');
model.geom('geom1').feature('wp1').geom.feature('r3').set('size', {'mw' 'mh/2-mg/2'});
model.geom('geom1').feature('wp1').geom.feature('r3').set('pos', {'dr-ml/2' 'mg/2'});
model.geom('geom1').feature('wp1').geom.run('r3');
model.geom('geom1').feature('wp1').geom.create('mir1', 'Mirror');
model.geom('geom1').feature('wp1').geom.feature('mir1').selection('input').set({'r2' 'r3'});
model.geom('geom1').feature('wp1').geom.feature('mir1').set('keep', true);
model.geom('geom1').feature('wp1').geom.feature('mir1').set('axis', [0 1]);
model.geom('geom1').feature('wp1').geom.run('mir1');
model.geom('geom1').run('wp1');
model.geom('geom1').feature.create('ext1', 'Extrude');
model.geom('geom1').feature('ext1').setIndex('distance', 'mt', 0);
model.geom('geom1').runPre('fin');

model.view('view1').hideObjects.create('hide1');
model.view('view1').hideObjects('hide1').init(2);
model.view('view1').hideObjects('hide1').set('sph1', [1 2 3 4 5 6 7 8]);

model.cpl.create('intop1', 'Integration', 'geom1');

model.geom('geom1').run;

model.cpl('intop1').set('axisym', true);
model.cpl('intop1').set('opname', 'intdisc');
model.cpl('intop1').selection.set([2]);
model.cpl('intop1').label('Integration over Disc');

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
model.material('mat2').propertyGroup.create('linzRes', 'Linearized resistivity');
model.material('mat2').label('Copper');
model.material('mat2').set('family', 'copper');
model.material('mat2').propertyGroup('def').set('relpermeability', {'1' '0' '0' '0' '1' '0' '0' '0' '1'});
model.material('mat2').propertyGroup('def').set('electricconductivity', {'5.998e7[S/m]' '0' '0' '0' '5.998e7[S/m]' '0' '0' '0' '5.998e7[S/m]'});
model.material('mat2').propertyGroup('def').set('thermalexpansioncoefficient', {'17e-6[1/K]' '0' '0' '0' '17e-6[1/K]' '0' '0' '0' '17e-6[1/K]'});
model.material('mat2').propertyGroup('def').set('heatcapacity', '385[J/(kg*K)]');
model.material('mat2').propertyGroup('def').set('relpermittivity', {'1' '0' '0' '0' '1' '0' '0' '0' '1'});
model.material('mat2').propertyGroup('def').set('density', '8960[kg/m^3]');
model.material('mat2').propertyGroup('def').set('thermalconductivity', {'400[W/(m*K)]' '0' '0' '0' '400[W/(m*K)]' '0' '0' '0' '400[W/(m*K)]'});
model.material('mat2').propertyGroup('Enu').set('E', '110[GPa]');
model.material('mat2').propertyGroup('Enu').set('nu', '0.35');
model.material('mat2').propertyGroup('linzRes').set('rho0', '1.72e-8[ohm*m]');
model.material('mat2').propertyGroup('linzRes').set('alpha', '0.0039[1/K]');
model.material('mat2').propertyGroup('linzRes').set('Tref', '298[K]');
model.material('mat2').propertyGroup('linzRes').addInput('temperature');
model.material('mat2').selection.named('geom1_cyl1_dom');
model.material.create('mat3', 'Common', 'comp1');
model.material('mat3').selection.set([3 4 5 6]);
model.material('mat3').propertyGroup('def').set('relpermeability', {'ymur'});
model.material('mat3').propertyGroup('def').set('electricconductivity', {'0'});
model.material('mat3').propertyGroup('def').set('relpermittivity', {'1'});
model.material('mat3').label('Yoke');
model.material.create('mat4', 'Common', 'comp1');
model.material('mat4').propertyGroup.create('RemanentFluxDensity', 'Remanent flux density');
model.material('mat4').label('N50 (Sintered NdFeB)');
model.material('mat4').set('family', 'chrome');
model.material('mat4').propertyGroup('def').set('electricconductivity', {'1/1.4[uohm*m]' '0' '0' '0' '1/1.4[uohm*m]' '0' '0' '0' '1/1.4[uohm*m]'});
model.material('mat4').propertyGroup('def').set('relpermittivity', {'1' '0' '0' '0' '1' '0' '0' '0' '1'});
model.material('mat4').propertyGroup('RemanentFluxDensity').set('murec', {'1.05' '0' '0' '0' '1.05' '0' '0' '0' '1.05'});
model.material('mat4').propertyGroup('RemanentFluxDensity').set('normBr', '1.41[T]');
model.material('mat4').selection.set([7]);
model.material('mat4').propertyGroup('def').set('electricconductivity', {'1'});
model.material('mat4').propertyGroup('RemanentFluxDensity').set('murec', {'1'});
model.material('mat4').propertyGroup('RemanentFluxDensity').set('normBr', {'mB'});
model.material('mat4').label('Generic Magnet');

model.massProp.create('mass1', 'MassProperties');
model.massProp('mass1').model('comp1');
model.massProp('mass1').selection.set([]);
model.massProp('mass1').selection.named('geom1_cyl1_dom');
model.massProp('mass1').set('outputFrame', 'spatial');
model.massProp('mass1').set('expr', 'mat2.def.rho');
model.massProp('mass1').set('createVolume', false);
model.massProp('mass1').set('createMass', false);
model.massProp('mass1').set('createCenterOfMass', false);
model.massProp('mass1').set('createPrincipalInertia', false);

model.physics('mef').feature('alc1').set('sigma_mat', 'userdef');
model.physics('mef').feature('alc1').set('sigma', [1 0 0 0 1 0 0 0 1]);
model.physics('mef').create('alc2', 'ElectromagneticModel', 3);
model.physics('mef').feature('alc2').selection.set([7]);
model.physics('mef').feature('alc2').set('ConstitutiveRelationBH', 'RemanentFluxDensity');
model.physics('mef').feature('alc2').set('e_crel_BH_RemanentFluxDensity', [0 0 1]);
model.physics('mef').feature('alc2').label('Permanent Magnet');
model.physics('mef').create('alc3', 'ElectromagneticModel', 3);
model.physics('mef').feature('alc3').selection.named('geom1_cyl1_dom');
model.physics('mef').feature('alc3').label('Disc');
model.physics('mef').create('vlt1', 'Velocity', 3);
model.physics('mef').feature('vlt1').selection.named('geom1_cyl1_dom');
model.physics('mef').feature('vlt1').set('v', {'-y*W' 'x*W' '0'});
model.physics('ge').feature('ge1').setIndex('name', 'W', 0, 0);
model.physics('ge').feature('ge1').setIndex('equation', 'Wt-intdisc(x*mef.FLtzy-y*mef.FLtzx)/mass1.Izz', 0, 0);
model.physics('ge').feature('ge1').setIndex('initialValueU', '2*pi*dV0', 0, 0);
model.physics('ge').feature('ge1').setIndex('description', 'Angular Velocity', 0, 0);
model.physics('ge').feature('ge1').set('DependentVariableQuantity', 'angularfrequency');
model.physics('ge').feature('ge1').set('SourceTermQuantity', 'angularacceleration');

model.variable.create('var1');
model.variable('var1').model('comp1');
model.variable('var1').set('axialTorque', '-intdisc(x*mef.FLtzy-y*mef.FLtzx)');
model.variable('var1').descr('axialTorque', 'Axial torque');
model.variable('var1').set('totalHeating', 'intdisc(mef.Qh)');
model.variable('var1').descr('totalHeating', 'Total heating');

model.probe.create('var1', 'GlobalVariable');
model.probe('var1').model('comp1');
model.probe('var1').set('window', 'new');
model.probe.create('var2', 'GlobalVariable');
model.probe('var2').model('comp1');
model.probe('var2').set('expr', 'axialTorque');
model.probe('var2').set('descr', 'Axial torque');
model.probe('var2').set('window', 'new');
model.probe.create('var3', 'GlobalVariable');
model.probe('var3').model('comp1');
model.probe('var3').set('expr', 'totalHeating');
model.probe('var3').set('descr', 'Total heating');
model.probe('var3').set('window', 'new');

model.mesh('mesh1').create('size1', 'Size');
model.mesh('mesh1').feature('size').set('hauto', 7);
model.mesh('mesh1').feature('size1').set('hauto', 1);
model.mesh('mesh1').feature('size1').selection.geom('geom1', 3);
model.mesh('mesh1').feature('size1').selection.set([2 3 4]);
model.mesh('mesh1').create('ftet1', 'FreeTet');
model.mesh('mesh1').feature('ftet1').set('zscale', 1.1);
model.mesh('mesh1').run;

model.study('std1').feature('stat').setEntry('activate', 'ge', false);
model.study('std1').create('time', 'Transient');
model.study('std1').feature('time').set('tlist', 'range(0,0.5,25)');
model.study('std1').setGenPlots(false);

model.sol.create('sol1');
model.sol('sol1').study('std1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'stat');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').set('control', 'stat');
model.sol('sol1').create('s1', 'Stationary');
model.sol('sol1').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('s1').create('i1', 'Iterative');
model.sol('sol1').feature('s1').feature('i1').set('linsolver', 'fgmres');
model.sol('sol1').feature('s1').feature('i1').set('nlinnormuse', true);
model.sol('sol1').feature('s1').feature('i1').set('rhob', 10000);
model.sol('sol1').feature('s1').feature('i1').create('mg1', 'Multigrid');
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
model.sol('sol1').feature('t1').set('tlist', 'range(0,0.5,25)');
model.sol('sol1').feature('t1').set('plot', 'off');
model.sol('sol1').feature('t1').set('plotgroup', 'Default');
model.sol('sol1').feature('t1').set('plotfreq', 'tout');
model.sol('sol1').feature('t1').set('probesel', 'all');
model.sol('sol1').feature('t1').set('probes', {'var1' 'var2' 'var3'});
model.sol('sol1').feature('t1').set('probefreq', 'tsteps');
model.sol('sol1').feature('t1').set('atolglobalvaluemethod', 'factor');
model.sol('sol1').feature('t1').set('reacf', true);
model.sol('sol1').feature('t1').set('storeudot', true);
model.sol('sol1').feature('t1').set('tstepsbdf', 'strict');
model.sol('sol1').feature('t1').set('endtimeinterpolation', true);
model.sol('sol1').feature('t1').set('estrat', 'exclude');
model.sol('sol1').feature('t1').set('control', 'time');
model.sol('sol1').feature('t1').create('se1', 'Segregated');
model.sol('sol1').feature('t1').feature('se1').feature.remove('ssDef');
model.sol('sol1').feature('t1').feature('se1').create('ss1', 'SegregatedStep');
model.sol('sol1').feature('t1').feature('se1').feature('ss1').set('segvar', {'comp1_ODE1'});
model.sol('sol1').feature('t1').feature('se1').feature('ss1').set('linsolver', 'dDef');
model.sol('sol1').feature('t1').feature('se1').feature('ss1').label('Global ODEs and DAEs');
model.sol('sol1').feature('t1').feature('se1').create('ss2', 'SegregatedStep');
model.sol('sol1').feature('t1').feature('se1').feature('ss2').set('segvar', {'comp1_A' 'comp1_V'});
model.sol('sol1').feature('t1').create('i1', 'Iterative');
model.sol('sol1').feature('t1').feature('i1').set('linsolver', 'fgmres');
model.sol('sol1').feature('t1').feature('i1').set('nlinnormuse', true);
model.sol('sol1').feature('t1').feature('i1').create('mg1', 'Multigrid');
model.sol('sol1').feature('t1').feature('i1').feature('mg1').set('hybridization', 'multi');
model.sol('sol1').feature('t1').feature('i1').feature('mg1').set('hybridvar', {'comp1_V'});
model.sol('sol1').feature('t1').feature('i1').create('mg2', 'Multigrid');
model.sol('sol1').feature('t1').feature('i1').feature('mg2').set('hybridization', 'multi');
model.sol('sol1').feature('t1').feature('i1').feature('mg2').set('hybridvar', {'comp1_A'});
model.sol('sol1').feature('t1').feature('se1').feature('ss2').set('linsolver', 'i1');
model.sol('sol1').feature('t1').feature('se1').feature('ss2').label('Magnetic and Electric Fields');
model.sol('sol1').feature('t1').feature.remove('fcDef');
model.sol('sol1').attach('std1');
model.sol('sol1').feature('t1').setEntry('atolmethod', 'comp1_ODE1', 'unscaled');
model.sol('sol1').feature('t1').setEntry('atolvaluemethod', 'comp1_ODE1', 'manual');
model.sol('sol1').feature('t1').setEntry('atol', 'comp1_ODE1', '0.1');
model.sol('sol1').feature('t1').set('tstepsbdf', 'intermediate');
model.sol('sol1').feature('t1').feature('i1').set('rhob', 1);

model.probe('var1').genResult('none');
model.probe('var2').genResult('none');
model.probe('var3').genResult('none');

model.sol('sol1').runAll;

model.result('pg1').set('window', 'window1');
model.result('pg1').run;
model.result('pg1').label('Angular Velocity vs. Time');
model.result('pg2').set('window', 'window2');
model.result('pg2').set('windowtitle', 'Probe Plot 2');
model.result('pg2').run;
model.result('pg2').label('Axial Torque vs. Time');
model.result('pg3').set('window', 'window3');
model.result('pg3').set('windowtitle', 'Probe Plot 3');
model.result('pg3').run;
model.result('pg3').label('Total Heating vs. Time');
model.result.create('pg4', 'PlotGroup3D');
model.result('pg4').run;
model.result('pg4').set('edges', false);
model.result('pg4').create('vol1', 'Volume');
model.result('pg4').feature('vol1').set('expr', 'mef.normJ');
model.result('pg4').feature('vol1').set('descr', 'Current density norm');
model.result('pg4').feature('vol1').create('sel1', 'Selection');
model.result('pg4').feature('vol1').feature('sel1').selection.set([2]);
model.result('pg4').run;
model.result('pg4').create('vol2', 'Volume');
model.result('pg4').feature('vol2').set('expr', '1');
model.result('pg4').feature('vol2').set('coloring', 'uniform');
model.result('pg4').feature('vol2').set('color', 'gray');
model.result('pg4').feature('vol2').create('sel1', 'Selection');
model.result('pg4').feature('vol2').feature('sel1').selection.set([3 4 5 6 7]);
model.result('pg4').run;
model.result('pg4').create('arws1', 'ArrowSurface');
model.result('pg4').feature('arws1').set('expr', {'mef.Jx' 'mef.Jy' 'mef.Jz'});
model.result('pg4').feature('arws1').set('descr', 'Current density');
model.result('pg4').feature('arws1').set('arrowcount', 1000);
model.result('pg4').feature('arws1').set('color', 'white');
model.result('pg4').run;
model.result('pg4').setIndex('looplevel', 1, 0);
model.result('pg4').run;
model.result('pg4').setIndex('looplevel', 51, 0);
model.result('pg4').run;

model.title('Magnetic Brake');

model.description('A metal disk is rotating in the air gap of a magnet. Currents are induced, and the resulting Lorentz forces (JxB) yield a braking torque that slows down the disk. This 3D model computes the eddy current and Lorentz force distribution and in parallel solves a coupled ordinary differential equation for the time evolution of the angular velocity.');

model.mesh.clearMeshes;

model.sol('sol1').clearSolutionData;
model.sol('sol2').clearSolutionData;

model.label('magnetic_brake.mph');

model.modelNode.label('Components');

out = model;
