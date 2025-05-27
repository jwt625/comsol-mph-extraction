function out = model
%
% mutual_inductance_coil_group.m
%
% Model exported on May 26 2025, 21:25 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/ACDC_Module/Tutorials,_Coils');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 2);
model.geom('geom1').model('comp1');
model.geom('geom1').axisymmetric(true);

model.mesh.create('mesh1', 'geom1');

model.physics.create('mf', 'InductionCurrents', 'geom1');
model.physics('mf').model('comp1');

model.study.create('std1');
model.study('std1').create('stat', 'Stationary');
model.study('std1').feature('stat').setSolveFor('/physics/mf', true);

model.param.set('r_wire', '1[mm]');
model.param.descr('r_wire', 'Radius, wire');
model.param.set('R1', '100[mm]');
model.param.descr('R1', 'Radius, outer coil');
model.param.set('R2', '10[mm]');
model.param.descr('R2', 'Radius, inner coil');
model.param.set('M', '20*(mu0_const*pi*R2^2)/(2*R1)');
model.param.descr('M', 'Analytic mutual inductance');
model.param.set('I1', '1[A]');
model.param.descr('I1', 'Current, outer coil');
model.param.set('I2', '0[A]');
model.param.descr('I2', 'Current, inner coil');

model.geom('geom1').create('c1', 'Circle');
model.geom('geom1').feature('c1').set('angle', 180);
model.geom('geom1').feature('c1').set('r', '1.75*R1');
model.geom('geom1').feature('c1').set('rot', -90);
model.geom('geom1').feature('c1').setIndex('layer', '50[mm]', 0);
model.geom('geom1').run('c1');
model.geom('geom1').create('c2', 'Circle');
model.geom('geom1').feature('c2').set('r', 'r_wire');
model.geom('geom1').feature('c2').set('pos', {'R1' '0'});
model.geom('geom1').run('c2');
model.geom('geom1').create('c3', 'Circle');
model.geom('geom1').feature('c3').set('r', 'r_wire');
model.geom('geom1').feature('c3').set('pos', {'R2-1.5*r_wire' '0'});
model.geom('geom1').feature('c3').setIndex('pos', '-13.5*r_wire', 1);
model.geom('geom1').run('c3');
model.geom('geom1').create('arr1', 'Array');
model.geom('geom1').feature('arr1').selection('input').set({'c3'});
model.geom('geom1').feature('arr1').set('fullsize', [2 10]);
model.geom('geom1').feature('arr1').set('displ', {'3*r_wire' '3*r_wire'});
model.geom('geom1').runPre('fin');

model.coordSystem.create('ie1', 'geom1', 'InfiniteElement');

model.geom('geom1').run;

model.coordSystem('ie1').selection.set([1 3]);

model.physics('mf').create('coil1', 'Coil', 2);
model.physics('mf').feature('coil1').selection.set([24]);
model.physics('mf').feature('coil1').set('ICoil', 'I1');
model.physics('mf').create('coil2', 'Coil', 2);
model.physics('mf').feature('coil2').set('coilGroup', true);
model.physics('mf').feature('coil2').selection.set([4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23]);
model.physics('mf').feature('coil2').set('ICoil', 'I2');

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
model.material('mat2').propertyGroup('def').set('heatcapacity', '385[J/(kg*K)]');
model.material('mat2').propertyGroup('def').set('relpermittivity', {'1' '0' '0' '0' '1' '0' '0' '0' '1'});
model.material('mat2').propertyGroup('def').set('emissivity', '0.5');
model.material('mat2').propertyGroup('def').set('density', '8940[kg/m^3]');
model.material('mat2').propertyGroup('def').set('thermalconductivity', {'400[W/(m*K)]' '0' '0' '0' '400[W/(m*K)]' '0' '0' '0' '400[W/(m*K)]'});
model.material('mat2').propertyGroup('Enu').set('E', '126e9[Pa]');
model.material('mat2').propertyGroup('Enu').set('nu', '0.34');
model.material('mat2').propertyGroup('linzRes').set('rho0', '1.667e-8[ohm*m]');
model.material('mat2').propertyGroup('linzRes').set('alpha', '3.862e-3[1/K]');
model.material('mat2').propertyGroup('linzRes').set('Tref', '293.15[K]');
model.material('mat2').propertyGroup('linzRes').addInput('temperature');
model.material('mat2').selection.set([4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24]);

model.mesh('mesh1').run;

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
model.sol('sol1').feature('s1').feature('fc1').set('linsolver', 'dDef');
model.sol('sol1').feature('s1').feature.remove('fcDef');
model.sol('sol1').attach('std1');
model.sol('sol1').runAll;

model.result.dataset('dset1').selection.geom('geom1', 2);
model.result.dataset('dset1').selection.geom('geom1', 2);
model.result.dataset('dset1').selection.set([2 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24]);
model.result.create('pg1', 'PlotGroup2D');
model.result('pg1').run;
model.result('pg1').create('str1', 'Streamline');
model.result('pg1').feature('str1').set('posmethod', 'start');
model.result('pg1').feature('str1').set('startmethod', 'coord');
model.result('pg1').feature('str1').set('xcoord', 'range(0,0.9*R1/49,0.9*R1)');
model.result('pg1').feature('str1').set('ycoord', 0);
model.result('pg1').feature('str1').set('linetype', 'tube');
model.result('pg1').feature('str1').create('col1', 'Color');
model.result('pg1').run;
model.result.numerical.create('gev1', 'EvalGlobal');
model.result.numerical('gev1').setIndex('expr', 'mf.LCoil_1', 0);
model.result.numerical('gev1').setIndex('unit', 'nH', 0);
model.result.numerical('gev1').setIndex('descr', 'External coil inductance', 0);
model.result.numerical('gev1').setIndex('expr', '2*mf.intWm/1[A^2]', 1);
model.result.numerical('gev1').setIndex('unit', 'nH', 1);
model.result.numerical('gev1').setIndex('descr', 'Energy estimate for external coil inductance', 1);
model.result.numerical('gev1').setIndex('expr', 'mf.L_2_1', 2);
model.result.numerical('gev1').setIndex('unit', 'nH', 2);
model.result.numerical('gev1').setIndex('descr', 'Computed mutual inductance', 2);
model.result.numerical('gev1').setIndex('expr', 'M', 3);
model.result.numerical('gev1').setIndex('unit', 'nH', 3);
model.result.numerical('gev1').setIndex('descr', 'Analytical mutual inductance', 3);
model.result.table.create('tbl1', 'Table');
model.result.table('tbl1').comments('Global Evaluation 1');
model.result.numerical('gev1').set('table', 'tbl1');
model.result.numerical('gev1').setResult;

model.param.set('I1', '0[A]');
model.param.set('I2', '1[A]');

model.study.create('std2');
model.study('std2').create('stat', 'Stationary');
model.study('std2').feature('stat').setSolveFor('/physics/mf', true);
model.study('std2').setGenPlots(false);

model.sol.create('sol2');
model.sol('sol2').study('std2');
model.sol('sol2').create('st1', 'StudyStep');
model.sol('sol2').feature('st1').set('study', 'std2');
model.sol('sol2').feature('st1').set('studystep', 'stat');
model.sol('sol2').create('v1', 'Variables');
model.sol('sol2').feature('v1').set('control', 'stat');
model.sol('sol2').create('s1', 'Stationary');
model.sol('sol2').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol2').feature('s1').feature('fc1').set('linsolver', 'dDef');
model.sol('sol2').feature('s1').feature.remove('fcDef');
model.sol('sol2').attach('std2');
model.sol('sol2').runAll;

model.result.numerical.create('gev2', 'EvalGlobal');
model.result.numerical('gev2').set('data', 'dset2');
model.result.numerical('gev2').setIndex('expr', 'mf.LCoil_2', 0);
model.result.numerical('gev2').setIndex('unit', 'nH', 0);
model.result.numerical('gev2').setIndex('descr', 'Internal coil inductance', 0);
model.result.numerical('gev2').setIndex('expr', '2*mf.intWm/1[A^2]', 1);
model.result.numerical('gev2').setIndex('unit', 'nH', 1);
model.result.numerical('gev2').setIndex('descr', 'Energy estimate for internal coil inductance', 1);
model.result.numerical('gev2').setIndex('expr', 'mf.L_1_2', 2);
model.result.numerical('gev2').setIndex('unit', 'nH', 2);
model.result.numerical('gev2').setIndex('descr', 'Computed mutual inductance', 2);
model.result.numerical('gev2').setIndex('expr', 'M', 3);
model.result.numerical('gev2').setIndex('unit', 'nH', 3);
model.result.numerical('gev2').setIndex('descr', 'Analytical mutual inductance', 3);
model.result.table.create('tbl2', 'Table');
model.result.table('tbl2').comments('Global Evaluation 2');
model.result.numerical('gev2').set('table', 'tbl2');
model.result.numerical('gev2').setResult;
model.result.dataset.create('cln1', 'CutLine2D');
model.result.dataset('cln1').setIndex('genpoints', 'R2', 1, 0);
model.result.dataset.create('cln2', 'CutLine2D');
model.result.dataset('cln2').setIndex('genpoints', 'R1', 1, 0);
model.result.numerical.create('int1', 'IntLine');
model.result.numerical('int1').set('intsurface', true);
model.result.numerical('int1').set('data', 'cln1');
model.result.numerical('int1').setIndex('expr', '20*mf.Bz/I1', 0);
model.result.numerical('int1').setIndex('unit', 'nH', 0);
model.result.table.create('tbl3', 'Table');
model.result.table('tbl3').comments('Line Integration 1');
model.result.numerical('int1').set('table', 'tbl3');
model.result.numerical('int1').setResult;
model.result.numerical.duplicate('int2', 'int1');
model.result.numerical('int2').set('data', 'cln2');
model.result.numerical('int2').setIndex('expr', 'mf.Bz/I1', 0);
model.result.numerical('int2').set('table', 'tbl3');
model.result.numerical('int2').appendResult;
model.result.dataset('cln1').set('data', 'dset2');
model.result.dataset('cln2').set('data', 'dset2');
model.result.numerical('int1').setIndex('expr', '20*mf.Bz/I2', 0);
model.result.numerical('int1').set('table', 'tbl3');
model.result.numerical('int1').appendResult;
model.result.numerical('int2').setIndex('expr', 'mf.Bz/I2', 0);
model.result.numerical('int2').set('table', 'tbl3');
model.result.numerical('int2').appendResult;

model.param.set('I1', '1[A]');
model.param.set('I2', '0[A]');

model.study.create('std3');
model.study('std3').create('freq', 'Frequency');
model.study('std3').feature('freq').setSolveFor('/physics/mf', true);
model.study('std3').feature('freq').set('plist', '1[kHz]');
model.study('std3').setGenPlots(false);

model.sol.create('sol3');
model.sol('sol3').study('std3');
model.sol('sol3').create('st1', 'StudyStep');
model.sol('sol3').feature('st1').set('study', 'std3');
model.sol('sol3').feature('st1').set('studystep', 'freq');
model.sol('sol3').create('v1', 'Variables');
model.sol('sol3').feature('v1').set('control', 'freq');
model.sol('sol3').create('s1', 'Stationary');
model.sol('sol3').feature('s1').create('p1', 'Parametric');
model.sol('sol3').feature('s1').feature.remove('pDef');
model.sol('sol3').feature('s1').feature('p1').set('pname', {'freq'});
model.sol('sol3').feature('s1').feature('p1').set('plistarr', {'1[kHz]'});
model.sol('sol3').feature('s1').feature('p1').set('punit', {'Hz'});
model.sol('sol3').feature('s1').feature('p1').set('pcontinuationmode', 'no');
model.sol('sol3').feature('s1').feature('p1').set('preusesol', 'no');
model.sol('sol3').feature('s1').feature('p1').set('pdistrib', 'off');
model.sol('sol3').feature('s1').feature('p1').set('plot', 'off');
model.sol('sol3').feature('s1').feature('p1').set('plotgroup', 'pg1');
model.sol('sol3').feature('s1').feature('p1').set('probesel', 'all');
model.sol('sol3').feature('s1').feature('p1').set('probes', {});
model.sol('sol3').feature('s1').feature('p1').set('control', 'freq');
model.sol('sol3').feature('s1').set('linpmethod', 'sol');
model.sol('sol3').feature('s1').set('linpsol', 'zero');
model.sol('sol3').feature('s1').set('control', 'freq');
model.sol('sol3').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol3').feature('s1').feature('fc1').set('linsolver', 'dDef');
model.sol('sol3').feature('s1').feature.remove('fcDef');
model.sol('sol3').attach('std3');
model.sol('sol3').runAll;

model.result.dataset('dset3').selection.geom('geom1', 2);
model.result.dataset('dset3').selection.geom('geom1', 2);
model.result.dataset('dset3').selection.set([4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23]);
model.result.create('pg2', 'PlotGroup2D');
model.result('pg2').run;
model.result('pg2').set('data', 'dset3');
model.result('pg2').create('surf1', 'Surface');
model.result.numerical.create('gev3', 'EvalGlobal');
model.result.numerical('gev3').set('data', 'dset3');
model.result.numerical('gev3').setIndex('expr', 'mf.VCoil_2/1[A]/mf.iomega', 0);
model.result.numerical('gev3').setIndex('unit', 'nH', 0);
model.result.table.create('tbl4', 'Table');
model.result.table('tbl4').comments('Global Evaluation 3');
model.result.numerical('gev3').set('table', 'tbl4');
model.result.numerical('gev3').setResult;

model.physics('mf').feature('coil2').set('CoilExcitation', 'Voltage');
model.physics('mf').feature('coil2').set('VCoil', 0);

model.study.create('std4');
model.study('std4').create('freq', 'Frequency');
model.study('std4').feature('freq').setSolveFor('/physics/mf', true);
model.study('std4').feature('freq').set('plist', '1[kHz]');
model.study('std4').setGenPlots(false);

model.sol.create('sol4');
model.sol('sol4').study('std4');
model.sol('sol4').create('st1', 'StudyStep');
model.sol('sol4').feature('st1').set('study', 'std4');
model.sol('sol4').feature('st1').set('studystep', 'freq');
model.sol('sol4').create('v1', 'Variables');
model.sol('sol4').feature('v1').set('control', 'freq');
model.sol('sol4').create('s1', 'Stationary');
model.sol('sol4').feature('s1').create('p1', 'Parametric');
model.sol('sol4').feature('s1').feature.remove('pDef');
model.sol('sol4').feature('s1').feature('p1').set('pname', {'freq'});
model.sol('sol4').feature('s1').feature('p1').set('plistarr', {'1[kHz]'});
model.sol('sol4').feature('s1').feature('p1').set('punit', {'Hz'});
model.sol('sol4').feature('s1').feature('p1').set('pcontinuationmode', 'no');
model.sol('sol4').feature('s1').feature('p1').set('preusesol', 'no');
model.sol('sol4').feature('s1').feature('p1').set('pdistrib', 'off');
model.sol('sol4').feature('s1').feature('p1').set('plot', 'off');
model.sol('sol4').feature('s1').feature('p1').set('plotgroup', 'pg1');
model.sol('sol4').feature('s1').feature('p1').set('probesel', 'all');
model.sol('sol4').feature('s1').feature('p1').set('probes', {});
model.sol('sol4').feature('s1').feature('p1').set('control', 'freq');
model.sol('sol4').feature('s1').set('linpmethod', 'sol');
model.sol('sol4').feature('s1').set('linpsol', 'zero');
model.sol('sol4').feature('s1').set('control', 'freq');
model.sol('sol4').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol4').feature('s1').feature('fc1').set('linsolver', 'dDef');
model.sol('sol4').feature('s1').feature.remove('fcDef');
model.sol('sol4').attach('std4');
model.sol('sol4').runAll;

model.result.dataset('dset4').selection.geom('geom1', 2);
model.result.dataset('dset4').selection.geom('geom1', 2);
model.result.dataset('dset4').selection.set([4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23]);
model.result.create('pg3', 'PlotGroup2D');
model.result('pg3').run;
model.result('pg3').set('data', 'dset4');
model.result('pg3').create('surf1', 'Surface');
model.result('pg3').feature('surf1').set('expr', 'mf.Jphi');
model.result('pg3').feature('surf1').set('descr', 'Current density, phi-component');
model.result('pg3').run;
model.result.numerical.create('gev4', 'EvalGlobal');
model.result.numerical('gev4').set('data', 'dset4');
model.result.numerical('gev4').setIndex('expr', 'mf.ICoil_2', 0);
model.result.numerical('gev4').setIndex('expr', '-mf.iomega*withsol(''sol1'',mf.L_2_1)/(withsol(''sol2'',mf.RCoil_2)+withsol(''sol2'',mf.LCoil_2)*mf.iomega)*mf.ICoil_1', 1);
model.result.table.create('tbl5', 'Table');
model.result.table('tbl5').comments('Global Evaluation 4');
model.result.numerical('gev4').set('table', 'tbl5');
model.result.numerical('gev4').setResult;

model.title('Self-Inductance and Mutual Inductance of a Single Conductor and a Helical Coil');

model.description('The mutual inductance and induced currents between a single-turn primary and twenty-turn secondary coil in a concentric coplanar arrangement is computed using a frequency-domain model. Each turn of the secondary coil is modeled explicitly. The results are compared against analytic predictions.');

model.mesh.clearMeshes;

model.sol('sol1').clearSolutionData;
model.sol('sol2').clearSolutionData;
model.sol('sol3').clearSolutionData;
model.sol('sol4').clearSolutionData;

model.label('mutual_inductance_coil_group.mph');

model.modelNode.label('Components');

out = model;
