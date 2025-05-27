function out = model
%
% brewster_interface.m
%
% Model exported on May 26 2025, 21:34 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/Wave_Optics_Module/Optical_Scattering');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 2);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.physics.create('ewbe', 'ElectromagneticWavesBeamEnvelopes', 'geom1');
model.physics('ewbe').model('comp1');

model.study.create('std1');
model.study('std1').create('freq', 'Frequency');
model.study('std1').feature('freq').set('solnum', 'auto');
model.study('std1').feature('freq').set('notsolnum', 'auto');
model.study('std1').feature('freq').set('outputmap', {});
model.study('std1').feature('freq').set('ngenAUX', '1');
model.study('std1').feature('freq').set('goalngenAUX', '1');
model.study('std1').feature('freq').set('ngenAUX', '1');
model.study('std1').feature('freq').set('goalngenAUX', '1');
model.study('std1').feature('freq').setSolveFor('/physics/ewbe', true);

% To import content from file, use:
% model.param.loadFile('FILENAME');
model.param.set('lda0', '1[um]', 'Wavelength');
model.param.set('f0', 'c_const/lda0', 'Frequency');
model.param.set('w0', '10*lda0', 'Spot radius');
model.param.set('z0', 'pi*w0^2/lda0', 'Rayleigh range');
model.param.set('alpha', 'atan(n2)', 'Angle of incidence (at Brewster angle)');
model.param.set('a', '6*w0', 'Width');
model.param.set('b', 'n2*a', 'Propagation length');
model.param.set('n2', '1.5', 'Refractive index');
model.param.set('alpha2', 'asin(sin(alpha)/n2)', 'Refracted angle');
model.param.set('k0', '2*pi/lda0', 'Wave number in air');
model.param.set('k1x_air', 'k0', 'Wave vector in air, first wave, x-component');
model.param.set('k1y_air', '0[1/m]', 'Wave vector in air, first wave, y-component');
model.param.set('k2x_air', '-k0*cos(2*alpha)', 'Wave vector in air, second wave, x-component');
model.param.set('k2y_air', '-k0*sin(2*alpha)', 'Wave vector in air, second wave, y-component');
model.param.set('k1x_glass', 'k0*n2*cos(alpha-alpha2)', 'Wave vector in glass, first wave, x-component');
model.param.set('k1y_glass', 'k0*n2*sin(alpha-alpha2)', 'Wave vector in glass, first wave, y-component');
model.param.set('k2x_glass', '-k0*n2*cos(alpha+alpha2)', 'Wave vector in glass, second wave, x-component');
model.param.set('k2y_glass', '-k0*n2*sin(alpha+alpha2)', 'Wave vector in glass, second wave, y-component');

model.geom('geom1').create('r1', 'Rectangle');
model.geom('geom1').feature('r1').set('size', {'b' 'a'});
model.geom('geom1').feature('r1').set('base', 'center');
model.geom('geom1').run('r1');
model.geom('geom1').create('pol1', 'Polygon');
model.geom('geom1').feature('pol1').set('source', 'table');
model.geom('geom1').feature('pol1').setIndex('table', '-b/2', 0, 0);
model.geom('geom1').feature('pol1').setIndex('table', 'a/2', 0, 1);
model.geom('geom1').feature('pol1').setIndex('table', 'b/2', 1, 0);
model.geom('geom1').feature('pol1').setIndex('table', '-a/2', 1, 1);
model.geom('geom1').runPre('fin');

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

model.geom('geom1').run;

model.material.create('mat2', 'Common', 'comp1');
model.material('mat2').label('Glass');
model.material('mat2').selection.set([2]);
model.material('mat2').propertyGroup.create('RefractiveIndex', 'Refractive_index');
model.material('mat2').propertyGroup('RefractiveIndex').set('n', {'n2'});

model.variable.create('var1');
model.variable('var1').model('comp1');
model.variable('var1').selection.geom('geom1', 2);
model.variable('var1').selection.set([1]);
model.variable('var1').set('phi1', 'k1x_air*x+k1y_air*y');
model.variable('var1').descr('phi1', 'Phase in air, first wave');
model.variable('var1').set('phi2', 'k2x_air*x+k2y_air*y');
model.variable('var1').descr('phi2', 'Phase in air, second wave');
model.variable.create('var2');
model.variable('var2').model('comp1');
model.variable('var2').selection.geom('geom1', 2);
model.variable('var2').selection.set([2]);
model.variable('var2').set('phi1', 'k1x_glass*x+k1y_glass*y', 'Phase in air, first wave');
model.variable('var2').descr('phi1', 'Phase in glass, first wave');
model.variable('var2').set('phi2', 'k2x_glass*x+k2y_glass*y', 'Phase in air, second wave');
model.variable('var2').descr('phi2', 'Phase in glass, second wave');

model.physics('ewbe').prop('WaveVector').set('PhaseSpec', 'UserDefined');
model.physics('ewbe').prop('WaveVector').set('phase1', 'phi1');
model.physics('ewbe').prop('WaveVector').set('phase2', 'phi2');
model.physics('ewbe').prop('components').set('components', 'outofplane');
model.physics('ewbe').create('mbc1', 'MatchedBoundaryCondition', 1);
model.physics('ewbe').feature('mbc1').selection.set([1]);
model.physics('ewbe').feature('mbc1').set('IncidentField', 'GaussianBeam');
model.physics('ewbe').feature('mbc1').set('w0', 'w0');
model.physics('ewbe').feature('mbc1').set('Eg0', {'0' '0' '1[V/m]'});
model.physics('ewbe').feature('mbc1').set('NoScatteredField', true);
model.physics('ewbe').create('mbc2', 'MatchedBoundaryCondition', 1);
model.physics('ewbe').feature('mbc2').selection.set([4 5]);
model.physics('ewbe').feature('mbc2').set('InputWave', 'SecondWave');
model.physics('ewbe').create('mbc3', 'MatchedBoundaryCondition', 1);
model.physics('ewbe').feature('mbc3').selection.set([2]);

model.cpl.create('intop1', 'Integration', 'geom1');
model.cpl('intop1').set('axisym', true);
model.cpl('intop1').selection.geom('geom1', 1);
model.cpl('intop1').selection.set([1]);
model.cpl.create('intop2', 'Integration', 'geom1');
model.cpl('intop2').set('axisym', true);
model.cpl('intop2').selection.geom('geom1', 1);
model.cpl('intop2').selection.set([4 5]);
model.cpl.create('intop3', 'Integration', 'geom1');
model.cpl('intop3').set('axisym', true);
model.cpl('intop3').selection.geom('geom1', 1);
model.cpl('intop3').selection.set([2]);

model.variable.create('var3');
model.variable('var3').model('comp1');
model.variable('var3').set('Pin', '-intop1(ewbe.nPoav)');
model.variable('var3').descr('Pin', 'Input power');
model.variable('var3').set('Pt', 'intop2(ewbe.nPoav)');
model.variable('var3').descr('Pt', 'Transmitted power');
model.variable('var3').set('Pr', 'intop3(ewbe.nPoav)');
model.variable('var3').descr('Pr', 'Reflected power');

model.physics('ewbe').prop('MeshControl').set('MeshType', 'Triangular');
model.physics('ewbe').prop('MeshControl').set('hMax', 'lda0/2');

model.study('std1').feature('freq').set('plist', 'f0');

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
model.sol('sol1').feature('s1').feature('p1').set('plistarr', {'f0'});
model.sol('sol1').feature('s1').feature('p1').set('punit', {'THz'});
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
model.sol('sol1').feature('s1').feature('aDef').set('complexfun', true);
model.sol('sol1').feature('s1').feature('aDef').set('cachepattern', false);
model.sol('sol1').feature('s1').feature('aDef').set('matherr', true);
model.sol('sol1').feature('s1').feature('aDef').set('blocksizeactive', false);
model.sol('sol1').feature('s1').feature('aDef').set('nullfun', 'auto');
model.sol('sol1').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('s1').feature('fc1').set('linsolver', 'dDef');
model.sol('sol1').feature('s1').feature.remove('fcDef');
model.sol('sol1').attach('std1');
model.sol('sol1').runAll;

model.result.create('pg1', 'PlotGroup2D');
model.result('pg1').label('Electric Field (ewbe)');
model.result('pg1').set('data', 'dset1');
model.result('pg1').setIndex('looplevel', 1, 0);
model.result('pg1').set('defaultPlotID', 'ElectromagneticWavesBeamEnvelopes/phys1/pdef1/pcond2/pg1');
model.result('pg1').feature.create('surf1', 'Surface');
model.result('pg1').feature('surf1').label('Electric Field');
model.result('pg1').feature('surf1').set('smooth', 'internal');
model.result('pg1').feature('surf1').set('data', 'parent');
model.result('pg1').run;
model.result('pg1').run;
model.result('pg1').feature('surf1').set('resolution', 'extrafine');
model.result('pg1').run;
model.result.numerical.create('gev1', 'EvalGlobal');
model.result.numerical('gev1').setIndex('expr', 'Pr/Pin', 0);
model.result.numerical('gev1').setIndex('unit', 1, 0);
model.result.numerical('gev1').setIndex('descr', '', 0);
model.result.table.create('tbl1', 'Table');
model.result.table('tbl1').comments('Global Evaluation 1');
model.result.numerical('gev1').set('table', 'tbl1');
model.result.numerical('gev1').setResult;
model.result.numerical('gev1').setIndex('expr', '((1-n2^2)/(1+n2^2))^2', 0);
model.result.numerical('gev1').set('table', 'tbl1');
model.result.numerical('gev1').appendResult;
model.result.numerical('gev1').setIndex('expr', '(Pr+Pt)/Pin', 0);
model.result.numerical('gev1').set('table', 'tbl1');
model.result.numerical('gev1').appendResult;

model.physics('ewbe').prop('components').set('components', 'inplane');
model.physics('ewbe').feature('mbc1').set('Eg0', {'0' '1[V/m]' '0'});

model.sol('sol1').study('std1');
model.sol('sol1').feature.remove('s1');
model.sol('sol1').feature.remove('v1');
model.sol('sol1').feature.remove('st1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'freq');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').set('control', 'freq');
model.sol('sol1').create('s1', 'Stationary');
model.sol('sol1').feature('s1').create('p1', 'Parametric');
model.sol('sol1').feature('s1').feature.remove('pDef');
model.sol('sol1').feature('s1').feature('p1').set('pname', {'freq'});
model.sol('sol1').feature('s1').feature('p1').set('plistarr', {'f0'});
model.sol('sol1').feature('s1').feature('p1').set('punit', {'THz'});
model.sol('sol1').feature('s1').feature('p1').set('pcontinuationmode', 'no');
model.sol('sol1').feature('s1').feature('p1').set('preusesol', 'no');
model.sol('sol1').feature('s1').feature('p1').set('pdistrib', 'off');
model.sol('sol1').feature('s1').feature('p1').set('plot', 'off');
model.sol('sol1').feature('s1').feature('p1').set('plotgroup', 'pg1');
model.sol('sol1').feature('s1').feature('p1').set('probesel', 'all');
model.sol('sol1').feature('s1').feature('p1').set('probes', {});
model.sol('sol1').feature('s1').feature('p1').set('control', 'freq');
model.sol('sol1').feature('s1').set('linpmethod', 'sol');
model.sol('sol1').feature('s1').set('linpsol', 'zero');
model.sol('sol1').feature('s1').set('control', 'freq');
model.sol('sol1').feature('s1').feature('aDef').set('complexfun', true);
model.sol('sol1').feature('s1').feature('aDef').set('cachepattern', false);
model.sol('sol1').feature('s1').feature('aDef').set('matherr', true);
model.sol('sol1').feature('s1').feature('aDef').set('blocksizeactive', false);
model.sol('sol1').feature('s1').feature('aDef').set('nullfun', 'auto');
model.sol('sol1').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('s1').feature('fc1').set('linsolver', 'dDef');
model.sol('sol1').feature('s1').feature.remove('fcDef');
model.sol('sol1').attach('std1');
model.sol('sol1').runAll;

model.result('pg1').run;
model.result.numerical('gev1').setIndex('expr', 'Pr/Pin', 0);
model.result.numerical('gev1').set('table', 'tbl1');
model.result.numerical('gev1').appendResult;
model.result('pg1').run;

model.title('Gaussian Beam Incident at the Brewster Angle');

model.description('This example demonstrates the polarization properties for a Gaussian beam incident at an interface between two media at the Brewster angle. It shows how to use the Electromagnetic Waves, Beam Envelopes interface with a user-defined phase specification. Matched Boundary Condition features are used for absorbing waves incident on boundaries at oblique angles.');

model.mesh.clearMeshes;

model.sol('sol1').clearSolutionData;

model.label('brewster_interface.mph');

model.modelNode.label('Components');

out = model;
