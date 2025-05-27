function out = model
%
% symmetric_laser_cavity.m
%
% Model exported on May 26 2025, 21:34 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/Wave_Optics_Module/Verification_Examples');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 2);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.physics.create('ewbe', 'ElectromagneticWavesBeamEnvelopes', 'geom1');
model.physics('ewbe').model('comp1');

model.study.create('std1');
model.study('std1').create('stat', 'Stationary');

model.geom('geom1').run;

model.param.set('wlref', '1[um]');
model.param.descr('wlref', 'Reference wavelength');
model.param.set('d', '1[m]');
model.param.descr('d', 'Cavity length');
model.param.set('R', '1.5*d');
model.param.descr('R', 'Mirror radius');
model.param.set('g', '1-d/R');
model.param.descr('g', 'Stability parameter');
model.param.set('q', 'floor(2*d/wlref)');
model.param.descr('q', 'Longitudinal mode number');
model.param.set('n', '0');
model.param.descr('n', 'Transverse mode number');
model.param.set('fqn', 'c_const/(2*d)*(q+1+1/pi*(1+2*n)*atan(sqrt((1-g)/(1+g))))');
model.param.descr('fqn', 'Mode frequency');
model.param.set('wlqn', 'c_const/fqn');
model.param.descr('wlqn', 'Mode wavelength');
model.param.set('w0', 'sqrt(d*wlqn/(2*pi)*sqrt((1+g)/(1-g)))');
model.param.descr('w0', 'Spot radius');
model.param.set('z0', 'pi*w0^2/wlqn');
model.param.descr('z0', 'Rayleigh range');
model.param.set('wR', 'sqrt(d*wlqn/pi*sqrt(1/(1-g^2)))');
model.param.descr('wR', 'Spot radius at the mirrors');
model.param.set('h0', '10*wR');
model.param.descr('h0', 'Cavity height');
model.param.set('k0', '2*pi*fqn/c_const');
model.param.descr('k0', 'Wave number');

model.func.create('an1', 'Analytic');
model.func('an1').set('funcname', 'hermite');
model.func('an1').set('expr', 'if(n==0,1,if(n==1,2*x,if(n==2,4*x^2-2,0)))');
model.func('an1').set('args', 'n,x');

model.geom('geom1').create('c1', 'Circle');
model.geom('geom1').feature('c1').set('r', 'R');
model.geom('geom1').feature('c1').set('pos', {'d/2-R' '0'});
model.geom('geom1').run('c1');
model.geom('geom1').create('r1', 'Rectangle');
model.geom('geom1').feature('r1').set('size', {'d/2' 'h0/2'});
model.geom('geom1').run('r1');
model.geom('geom1').create('int1', 'Intersection');
model.geom('geom1').feature('int1').selection('input').set({'c1' 'r1'});
model.geom('geom1').run('int1');
model.geom('geom1').create('mir1', 'Mirror');
model.geom('geom1').feature('mir1').selection('input').set({'int1'});
model.geom('geom1').feature('mir1').set('keep', true);
model.geom('geom1').run('mir1');
model.geom('geom1').create('mir2', 'Mirror');
model.geom('geom1').feature('mir2').selection('input').set({'int1' 'mir1'});
model.geom('geom1').feature('mir2').set('axis', [0 1]);
model.geom('geom1').feature('mir2').set('keep', true);
model.geom('geom1').runPre('fin');

model.view.create('view2', 'geom1');
model.view('view2').model('comp1');
model.view('view2').axis.set('viewscaletype', 'manual');
model.view('view2').axis.set('yscale', 40);

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

model.physics('ewbe').prop('components').set('components', 'outofplane');
model.physics.create('ge', 'GlobalEquations', 'geom1');
model.physics('ge').model('comp1');

model.study('std1').feature('stat').setSolveFor('/physics/ge', true);

model.physics('ge').prop('EquationForm').set('form', 'Automatic');
model.physics('ge').feature('ge1').setIndex('name', 'freq1', 0, 0);
model.physics('ge').feature('ge1').setIndex('equation', '1-nEz', 0, 0);
model.physics('ge').feature('ge1').setIndex('initialValueU', 'fqn', 0, 0);
model.physics('ge').feature('ge1').setIndex('description', 'Frequency', 0, 0);
model.physics('ge').feature('ge1').set('DependentVariableQuantity', 'frequency');
model.physics('ge').feature('ge1').set('CustomSourceTermUnit', '1');
model.physics('ge').feature('ge1').set('SourceTermQuantity', 'none');
model.physics('ge').feature('ge1').setIndex('CustomSourceTermUnit', 'V^2/m^2', 0, 0);
model.physics('ewbe').prop('EquationForm').setIndex('form', 'Frequency', 0);
model.physics('ewbe').prop('EquationForm').setIndex('freq_src', 'userdef', 0);
model.physics('ewbe').prop('EquationForm').setIndex('freq', 'freq1', 0);
model.physics('ewbe').feature('init1').set('E1', {'0' '0' 'hermite(n,sqrt(2)*y/w0)*exp(-(y/w0)^2)'});
model.physics('ewbe').feature('init1').set('E2', {'0' '0' '-hermite(n,sqrt(2)*y/w0)*exp(-(y/w0)^2)*exp(-j*k0*d)'});

model.cpl.create('intop1', 'Integration', 'geom1');
model.cpl('intop1').set('axisym', true);
model.cpl('intop1').selection.set([1]);

model.variable.create('var1');
model.variable('var1').model('comp1');
model.variable('var1').set('A', 'intop1(1)');
model.variable('var1').descr('A', 'Area');
model.variable('var1').set('nEz', 'intop1(realdot(ewbe.Ez,ewbe.Ez))/A');
model.variable('var1').descr('nEz', 'Normalization');

model.physics('ewbe').prop('MeshControl').set('elemCountT', 50);
model.physics('ewbe').prop('MeshControl').set('elemCountL', 30);

model.mesh('mesh1').run;

model.study('std1').create('param', 'Parametric');
model.study('std1').feature('param').setIndex('pname', 'wlref', 0);
model.study('std1').feature('param').setIndex('plistarr', '', 0);
model.study('std1').feature('param').setIndex('punit', 'm', 0);
model.study('std1').feature('param').setIndex('pname', 'wlref', 0);
model.study('std1').feature('param').setIndex('plistarr', '', 0);
model.study('std1').feature('param').setIndex('punit', 'm', 0);
model.study('std1').feature('param').setIndex('pname', 'n', 0);
model.study('std1').feature('param').setIndex('plistarr', '0 1 2', 0);

model.sol.create('sol1');
model.sol('sol1').study('std1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'stat');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').set('control', 'stat');
model.sol('sol1').create('s1', 'Stationary');
model.sol('sol1').feature('s1').feature('aDef').set('complexfun', true);
model.sol('sol1').feature('s1').feature('aDef').set('cachepattern', false);
model.sol('sol1').feature('s1').feature('aDef').set('matherr', true);
model.sol('sol1').feature('s1').feature('aDef').set('blocksizeactive', false);
model.sol('sol1').feature('s1').feature('aDef').set('nullfun', 'auto');
model.sol('sol1').feature('s1').create('seDef', 'Segregated');
model.sol('sol1').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('s1').feature('fc1').set('linsolver', 'dDef');
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
model.batch('p1').set('pname', {'n'});
model.batch('p1').set('plistarr', {'0 1 2'});
model.batch('p1').set('sweeptype', 'sparse');
model.batch('p1').set('probesel', 'all');
model.batch('p1').set('probes', {});
model.batch('p1').set('plot', 'off');
model.batch('p1').set('err', 'on');
model.batch('p1').attach('std1');
model.batch('p1').set('control', 'param');

model.sol('sol1').feature('st1').set('splitcomplex', true);

model.physics('ge').feature('ge1').set('valueType', 'real');

model.sol.create('sol2');
model.sol('sol2').study('std1');
model.sol('sol2').label('Parametric Solutions 1');

model.batch('p1').feature('so1').set('psol', 'sol2');
model.batch('p1').run('compute');

model.result.create('pg1', 'PlotGroup2D');
model.result('pg1').label('Electric Field (ewbe)');
model.result('pg1').set('data', 'dset2');
model.result('pg1').setIndex('looplevel', 3, 0);
model.result('pg1').set('data', 'dset2');
model.result('pg1').setIndex('looplevel', 3, 0);
model.result('pg1').set('defaultPlotID', 'ElectromagneticWavesBeamEnvelopes/phys1/pdef1/pcond2/pg1');
model.result('pg1').feature.create('surf1', 'Surface');
model.result('pg1').feature('surf1').label('Electric Field');
model.result('pg1').feature('surf1').set('smooth', 'internal');
model.result('pg1').feature('surf1').set('data', 'parent');
model.result.numerical.create('gev1', 'EvalGlobal');
model.result.numerical('gev1').set('data', 'dset2');
model.result.numerical('gev1').set('expr', {'freq1'});
model.result.numerical('gev1').set('descr', {'Frequency'});
model.result('pg1').run;
model.result('pg1').run;
model.result('pg1').feature('surf1').set('expr', 'ewbe.normE1');
model.result('pg1').run;
model.result('pg1').setIndex('looplevel', 1, 0);
model.result('pg1').run;
model.result('pg1').setIndex('looplevel', 2, 0);
model.result('pg1').run;
model.result('pg1').setIndex('looplevel', 3, 0);
model.result('pg1').run;
model.result.table.create('tbl1', 'Table');
model.result.table('tbl1').comments('Global Evaluation 1');
model.result.numerical('gev1').set('table', 'tbl1');
model.result.numerical('gev1').setResult;
model.result.numerical('gev1').setIndex('expr', 'fqn', 0);
model.result.numerical('gev1').setIndex('unit', 'Hz', 0);
model.result.numerical('gev1').setIndex('descr', 'Mode frequency', 0);
model.result.numerical('gev1').set('table', 'tbl1');
model.result.numerical('gev1').appendResult;
model.result('pg1').run;

model.title('Transverse Modes for a Symmetric Laser Cavity');

model.description(['This example demonstrates how a nonlinear equation system can be set up to solve for the eigenfrequencies of a symmetric laser cavity. The example uses the bidirectional formulation of the Electromagnetic Waves, Beam Envelopes physics interface.' newline  newline 'The computed eigenfrequencies are verified to values from analytical expressions.']);

model.mesh.clearMeshes;

model.sol('sol1').clearSolutionData;
model.sol('sol2').clearSolutionData;
model.sol('sol3').clearSolutionData;
model.sol('sol4').clearSolutionData;
model.sol('sol5').clearSolutionData;

model.label('symmetric_laser_cavity.mph');

model.modelNode.label('Components');

out = model;
