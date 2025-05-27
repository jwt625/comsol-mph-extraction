function out = model
%
% bandgap_photonic_crystal.m
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
model.study('std1').create('eig', 'Eigenfrequency');
model.study('std1').feature('eig').set('conrad', '1');
model.study('std1').feature('eig').set('conradynhm', '1');
model.study('std1').feature('eig').set('linpsolnum', 'auto');
model.study('std1').feature('eig').set('solnum', 'auto');
model.study('std1').feature('eig').set('notsolnum', 'auto');
model.study('std1').feature('eig').set('outputmap', {});
model.study('std1').feature('eig').set('ngenAUX', '1');
model.study('std1').feature('eig').set('goalngenAUX', '1');
model.study('std1').feature('eig').set('ngenAUX', '1');
model.study('std1').feature('eig').set('goalngenAUX', '1');
model.study('std1').feature('eig').setSolveFor('/physics/ewfd', true);

model.param.set('a', '375[nm]');
model.param.descr('a', 'Primitive cell side length');
model.param.set('b', '70[nm]');
model.param.descr('b', 'GaAs pillar radius');
model.param.set('k', '0');
model.param.descr('k', 'Fraction of wave vector magnitude');
model.param.set('k1', '1');
model.param.descr('k1', 'First component of wave direction vector');
model.param.set('k2', '1');
model.param.descr('k2', 'Second component of wave direction vector');
model.param.set('a1x', 'a');
model.param.descr('a1x', 'First lattice vector, x-component');
model.param.set('a1y', '0[nm]');
model.param.descr('a1y', 'First lattice vector, y-component');
model.param.set('a2x', '0[nm]');
model.param.descr('a2x', 'Second lattice vector, x-component');
model.param.set('a2y', 'a');
model.param.descr('a2y', 'Second lattice vector, y-component');
model.param.set('band', '1');
model.param.descr('band', 'Band number');

model.variable.create('var1');
model.variable('var1').model('comp1');

model.geom('geom1').run;

model.variable('var1').set('b1x', '2*pi*a2y/(a1x*a2y-a1y*a2x)');
model.variable('var1').descr('b1x', 'First reciprocal lattice vector, x-component');
model.variable('var1').set('b1y', '-2*pi*a2x/(a1x*a2y-a1y*a2x)');
model.variable('var1').descr('b1y', 'First reciprocal lattice vector, y-component');
model.variable('var1').set('b2x', '-2*pi*a1y/(a1x*a2y-a1y*a2x)');
model.variable('var1').descr('b2x', 'Second reciprocal lattice vector, x-component');
model.variable('var1').set('b2y', '2*pi*a1x/(a1x*a2y-a1y*a2x)');
model.variable('var1').descr('b2y', 'Second reciprocal lattice vector, y-component');
model.variable('var1').set('kx', 'k*(k1*b1x+k2*b2x)');
model.variable('var1').descr('kx', 'Floquet vector, x-component');
model.variable('var1').set('ky', 'k*(k1*b1y+k2*b2y)');
model.variable('var1').descr('ky', 'Floquet vector, y-component');

model.geom('geom1').create('sq1', 'Square');
model.geom('geom1').feature('sq1').set('size', 'a');
model.geom('geom1').feature('sq1').set('base', 'center');
model.geom('geom1').run('sq1');
model.geom('geom1').create('c1', 'Circle');
model.geom('geom1').feature('c1').set('r', 'b');
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

model.func.create('an1', 'Analytic');
model.func('an1').model('comp1');
model.func('an1').set('funcname', 'n_GaAs');
model.func('an1').set('expr', '-3.3285e5[1/m]*c_const/f+3.8359');
model.func('an1').set('args', 'f');
model.func('an1').setIndex('argunit', 'Hz', 0);
model.func('an1').set('fununit', '1');

model.physics('ewfd').prop('components').set('components', 'outofplane');
model.physics('ewfd').create('pc1', 'PeriodicCondition', 1);
model.physics('ewfd').feature('pc1').selection.set([1 4]);
model.physics('ewfd').feature('pc1').set('PeriodicType', 'Floquet');
model.physics('ewfd').feature('pc1').set('kFloquet', {'kx' 'ky' '0'});
model.physics('ewfd').create('pc2', 'PeriodicCondition', 1);
model.physics('ewfd').feature('pc2').selection.set([2 3]);
model.physics('ewfd').feature('pc2').set('PeriodicType', 'Floquet');
model.physics('ewfd').feature('pc2').set('kFloquet', {'kx' 'ky' '0'});
model.physics('ewfd').create('wee2', 'WaveEquationElectric', 2);
model.physics('ewfd').feature('wee2').selection.set([2]);
model.physics('ewfd').feature('wee2').set('n_mat', 'userdef');
model.physics('ewfd').feature('wee2').set('n', {'n_GaAs(freq)' '0' '0' '0' 'n_GaAs(freq)' '0' '0' '0' 'n_GaAs(freq)'});
model.physics('ewfd').feature('wee2').set('ki_mat', 'userdef');

model.mesh('mesh1').autoMeshSize(3);
model.mesh('mesh1').create('edg1', 'Edge');
model.mesh('mesh1').feature('edg1').selection.set([1 2]);
model.mesh('mesh1').create('cpe1', 'CopyEdge');
model.mesh('mesh1').feature('cpe1').selection('source').geom(1);
model.mesh('mesh1').feature('cpe1').selection('destination').geom(1);
model.mesh('mesh1').feature('cpe1').selection('source').set([1]);
model.mesh('mesh1').feature('cpe1').selection('destination').set([4]);
model.mesh('mesh1').create('cpe2', 'CopyEdge');
model.mesh('mesh1').feature('cpe2').selection('source').geom(1);
model.mesh('mesh1').feature('cpe2').selection('destination').geom(1);
model.mesh('mesh1').feature('cpe2').selection('source').set([2]);
model.mesh('mesh1').feature('cpe2').selection('destination').set([3]);
model.mesh('mesh1').create('ftri1', 'FreeTri');
model.mesh('mesh1').run;

model.study('std1').feature('eig').set('neigsactive', true);
model.study('std1').feature('eig').set('neigs', 5);
model.study('std1').feature('eig').set('shift', '550[THz]');

model.sol.create('sol1');
model.sol('sol1').study('std1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'eig');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').set('control', 'eig');
model.sol('sol1').create('e1', 'Eigenvalue');
model.sol('sol1').feature('e1').set('control', 'eig');
model.sol('sol1').feature('e1').feature('aDef').set('complexfun', true);
model.sol('sol1').feature('e1').feature('aDef').set('cachepattern', false);
model.sol('sol1').feature('e1').create('d1', 'Direct');
model.sol('sol1').feature('e1').feature('d1').set('linsolver', 'mumps');
model.sol('sol1').feature('e1').feature('d1').label('Suggested Direct Solver (ewfd)');
model.sol('sol1').attach('std1');
model.sol('sol1').feature('e1').set('eigref', '550[THz]');
model.sol('sol1').runAll;

model.result.create('pg1', 'PlotGroup2D');
model.result('pg1').label('Electric Field (ewfd)');
model.result('pg1').set('frametype', 'spatial');
model.result('pg1').set('data', 'dset1');
model.result('pg1').setIndex('looplevel', 1, 0);
model.result('pg1').set('defaultPlotID', 'ElectromagneticWavesFrequencyDomain/phys1/pdef1/pcond2/pg1');
model.result('pg1').feature.create('surf1', 'Surface');
model.result('pg1').feature('surf1').set('smooth', 'internal');
model.result('pg1').feature('surf1').set('data', 'parent');
model.result.numerical.create('gev1', 'EvalGlobal');
model.result.numerical('gev1').label('Eigenfrequencies (ewfd)');
model.result.numerical('gev1').set('data', 'dset1');
model.result.numerical('gev1').set('expr', {'ewfd.freq' 'ewfd.Qfactor'});
model.result.numerical('gev1').set('unit', {'THz' '1'});
model.result.table.create('tbl1', 'Table');
model.result.numerical('gev1').set('table', 'tbl1');
model.result.numerical('gev1').run;
model.result.numerical('gev1').setResult;
model.result('pg1').run;
model.result('pg1').run;
model.result('pg1').feature('surf1').set('expr', 'ewfd.Ez');
model.result('pg1').feature('surf1').create('hght1', 'Height');
model.result('pg1').run;

model.physics.create('ge', 'GlobalEquations', 'geom1');
model.physics('ge').model('comp1');

model.study('std1').feature('eig').setSolveFor('/physics/ge', true);

model.physics('ge').prop('EquationForm').set('form', 'Automatic');
model.physics.create('ewfd2', 'ElectromagneticWavesFrequencyDomain', 'geom1');
model.physics('ewfd2').model('comp1');

model.study('std1').feature('eig').setSolveFor('/physics/ewfd2', true);

model.physics('ge').feature('ge1').setIndex('name', 'freq1', 0, 0);
model.physics('ge').feature('ge1').setIndex('equation', '1[V^2/m^2]-nEz', 0, 0);
model.physics('ge').feature('ge1').setIndex('initialValueU', '-imag(lambda)/(2*pi)', 0, 0);
model.physics('ge').feature('ge1').setIndex('description', 'Frequency', 0, 0);
model.physics('ge').feature('ge1').set('DependentVariableQuantity', 'frequency');
model.physics('ge').feature('ge1').set('CustomSourceTermUnit', '1');
model.physics('ge').feature('ge1').set('SourceTermQuantity', 'none');
model.physics('ge').feature('ge1').setIndex('CustomSourceTermUnit', 'V^2/m^2', 0, 0);
model.physics('ewfd2').prop('EquationForm').setIndex('form', 'Frequency', 0);
model.physics('ewfd2').prop('EquationForm').setIndex('freq_src', 'userdef', 0);
model.physics('ewfd2').prop('EquationForm').setIndex('freq', 'freq1', 0);
model.physics('ewfd2').prop('components').set('components', 'outofplane');
model.physics('ewfd2').feature('init1').set('E2', {'0' '0' 'ewfd.Ez'});
model.physics('ewfd2').create('pc1', 'PeriodicCondition', 1);
model.physics('ewfd2').feature('pc1').selection.set([1 4]);
model.physics('ewfd2').feature('pc1').set('PeriodicType', 'Floquet');
model.physics('ewfd2').feature('pc1').set('kFloquet', {'kx' 'ky' '0'});
model.physics('ewfd2').create('pc2', 'PeriodicCondition', 1);
model.physics('ewfd2').feature('pc2').selection.set([2 3]);
model.physics('ewfd2').feature('pc2').set('PeriodicType', 'Floquet');
model.physics('ewfd2').feature('pc2').set('kFloquet', {'kx' 'ky' '0'});
model.physics('ewfd2').create('wee2', 'WaveEquationElectric', 2);
model.physics('ewfd2').feature('wee2').selection.set([2]);
model.physics('ewfd2').feature('wee2').set('n_mat', 'userdef');
model.physics('ewfd2').feature('wee2').set('n', {'n_GaAs(freq1)' '0' '0' '0' 'n_GaAs(freq1)' '0' '0' '0' 'n_GaAs(freq1)'});
model.physics('ewfd2').feature('wee2').set('ki_mat', 'userdef');

model.cpl.create('intop1', 'Integration', 'geom1');
model.cpl('intop1').set('axisym', true);
model.cpl('intop1').selection.set([1 2]);

model.variable('var1').set('A', 'intop1(1)');
model.variable('var1').descr('A', 'Area');
model.variable('var1').set('nEz', 'intop1(realdot(ewfd2.Ez,ewfd2.Ez))/A');
model.variable('var1').descr('nEz', 'Normalization integral');

model.study.create('std2');
model.study('std2').create('stat', 'Stationary');
model.study('std2').feature('stat').setSolveFor('/physics/ewfd', true);
model.study('std2').feature('stat').setSolveFor('/physics/ge', true);
model.study('std2').feature('stat').setSolveFor('/physics/ewfd2', true);
model.study('std2').feature('stat').set('useinitsol', true);
model.study('std2').feature('stat').set('initstudy', 'std1');
model.study('std2').feature('stat').set('solnum', 'manual');
model.study('std2').feature('stat').set('manualsolnum', 'band');
model.study('std2').feature('stat').set('useparam', true);
model.study('std2').feature('stat').setIndex('pname', 'a', 0);
model.study('std2').feature('stat').setIndex('plistarr', '', 0);
model.study('std2').feature('stat').setIndex('punit', 'm', 0);
model.study('std2').feature('stat').setIndex('pname', 'a', 0);
model.study('std2').feature('stat').setIndex('plistarr', '', 0);
model.study('std2').feature('stat').setIndex('punit', 'm', 0);
model.study('std2').feature('stat').setIndex('pname', 'k', 0);
model.study('std2').feature('stat').setIndex('plistarr', 'range(0,0.01,0.5)', 0);

model.sol.create('sol2');
model.sol('sol2').study('std2');
model.sol('sol2').create('st1', 'StudyStep');
model.sol('sol2').feature('st1').set('study', 'std2');
model.sol('sol2').feature('st1').set('studystep', 'stat');
model.sol('sol2').create('v1', 'Variables');
model.sol('sol2').feature('v1').set('control', 'stat');
model.sol('sol2').create('s1', 'Stationary');
model.sol('sol2').feature('s1').set('stol', 0.001);
model.sol('sol2').feature('s1').create('p1', 'Parametric');
model.sol('sol2').feature('s1').feature.remove('pDef');
model.sol('sol2').feature('s1').feature('p1').set('control', 'stat');
model.sol('sol2').feature('s1').set('control', 'stat');
model.sol('sol2').feature('s1').feature('aDef').set('complexfun', true);
model.sol('sol2').feature('s1').feature('aDef').set('cachepattern', false);
model.sol('sol2').feature('s1').create('seDef', 'Segregated');
model.sol('sol2').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol2').feature('s1').create('d1', 'Direct');
model.sol('sol2').feature('s1').feature('d1').set('linsolver', 'mumps');
model.sol('sol2').feature('s1').feature('d1').label('Suggested Direct Solver (ewfd2) (Merged)');
model.sol('sol2').feature('s1').feature('fc1').set('linsolver', 'd1');
model.sol('sol2').feature('s1').feature.remove('fcDef');
model.sol('sol2').feature('s1').feature.remove('seDef');
model.sol('sol2').attach('std2');
model.sol('sol2').feature('st1').set('splitcomplex', true);

model.physics('ge').feature('ge1').set('valueType', 'real');

model.study('std2').create('param', 'Parametric');
model.study('std2').feature('param').setIndex('pname', 'a', 0);
model.study('std2').feature('param').setIndex('plistarr', '', 0);
model.study('std2').feature('param').setIndex('punit', 'm', 0);
model.study('std2').feature('param').setIndex('pname', 'a', 0);
model.study('std2').feature('param').setIndex('plistarr', '', 0);
model.study('std2').feature('param').setIndex('punit', 'm', 0);
model.study('std2').feature('param').setIndex('pname', 'band', 0);
model.study('std2').feature('param').setIndex('plistarr', 'range(1,1,5)', 0);

model.sol('sol2').feature('s1').feature('p1').set('paramtuning', true);
model.sol('sol2').feature('s1').feature('p1').set('pinitstep', '0.0001');
model.sol('sol2').feature('s1').feature('p1').set('pminstep', '0.0001');
model.sol('sol2').feature('s1').feature('p1').set('pmaxstep', 0.01);
model.sol('sol2').feature('s1').feature('p1').set('porder', 'constant');

model.batch.create('p1', 'Parametric');
model.batch('p1').study('std2');
model.batch('p1').create('so1', 'Solutionseq');
model.batch('p1').feature('so1').set('seq', 'sol2');
model.batch('p1').feature('so1').set('store', 'on');
model.batch('p1').feature('so1').set('clear', 'on');
model.batch('p1').feature('so1').set('psol', 'none');
model.batch('p1').set('pname', {'band'});
model.batch('p1').set('plistarr', {'range(1,1,5)'});
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

model.result.numerical.create('gev2', 'EvalGlobal');
model.result.numerical('gev2').set('data', 'dset3');
model.result.numerical('gev2').set('expr', {'freq1'});
model.result.numerical('gev2').set('descr', {'Frequency'});
model.result.create('pg2', 'PlotGroup2D');
model.result('pg2').label('Electric Field (ewfd2)');
model.result('pg2').set('data', 'dset3');
model.result('pg2').setIndex('looplevel', 51, 0);
model.result('pg2').setIndex('looplevel', 5, 1);
model.result('pg2').set('frametype', 'spatial');
model.result('pg2').set('data', 'dset3');
model.result('pg2').setIndex('looplevel', 51, 0);
model.result('pg2').setIndex('looplevel', 5, 1);
model.result('pg2').set('defaultPlotID', 'ElectromagneticWavesFrequencyDomain/phys1/pdef1/pcond2/pg1');
model.result('pg2').feature.create('surf1', 'Surface');
model.result('pg2').feature('surf1').set('expr', 'ewfd2.normE');
model.result('pg2').feature('surf1').set('smooth', 'internal');
model.result('pg2').feature('surf1').set('data', 'parent');
model.result('pg2').run;
model.result('pg2').set('phasetype', 'manual');
model.result('pg2').set('phase', 180);
model.result('pg2').run;
model.result('pg2').feature('surf1').set('expr', 'ewfd2.Ez');
model.result('pg2').feature('surf1').create('hght1', 'Height');
model.result('pg2').run;
model.result.create('pg3', 'PlotGroup1D');
model.result('pg3').run;
model.result('pg3').set('data', 'dset3');
model.result('pg3').create('glob1', 'Global');
model.result('pg3').feature('glob1').set('markerpos', 'datapoints');
model.result('pg3').feature('glob1').set('linewidth', 'preference');
model.result('pg3').feature('glob1').set('legendmethod', 'manual');
model.result('pg3').feature('glob1').setIndex('legends', 'band=1', 0);
model.result('pg3').feature('glob1').setIndex('legends', 'band=2', 1);
model.result('pg3').feature('glob1').setIndex('legends', 'band=3', 2);
model.result('pg3').feature('glob1').setIndex('legends', 'band=4', 3);
model.result('pg3').feature('glob1').setIndex('legends', 'band=5', 4);
model.result('pg3').run;
model.result('pg1').run;

model.study('std1').feature('eig').setEntry('activate', 'ge', false);
model.study('std1').feature('eig').setEntry('activate', 'ewfd2', false);

model.title('Band-Gap Analysis of a Photonic Crystal');

model.description('The model investigates the wave propagation in a photonic crystal that consists of GaAs pillars placed equidistant from each other. The photonic crystal structure is the same as the one used in the other photonic crystal model, but this example extracts the band diagram for the lowest bands of the crystal. It performs a nonlinear sweep of an eigenvalue analysis, using the nonlinear solver with an extra normalization equation for the eigenvalue.');

model.mesh.clearMeshes;

model.sol('sol1').clearSolutionData;
model.sol('sol2').clearSolutionData;
model.sol('sol3').clearSolutionData;
model.sol('sol4').clearSolutionData;
model.sol('sol5').clearSolutionData;
model.sol('sol6').clearSolutionData;
model.sol('sol7').clearSolutionData;
model.sol('sol8').clearSolutionData;

model.label('bandgap_photonic_crystal.mph');

model.modelNode.label('Components');

out = model;
