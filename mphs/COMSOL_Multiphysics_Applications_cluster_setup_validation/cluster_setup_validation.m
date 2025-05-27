function out = model
%
% cluster_setup_validation.m
%
% Model exported on May 26 2025, 21:26 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/COMSOL_Multiphysics/Applications');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 3);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.physics.create('acpr', 'PressureAcoustics', 'geom1');
model.physics('acpr').model('comp1');

model.study.create('std1');
model.study('std1').create('freq', 'Frequency');
model.study('std1').feature('freq').setSolveFor('/physics/acpr', true);

model.param.set('p0', '1[Pa]');
model.param.descr('p0', 'Inlet pressure amplitude');

model.geom('geom1').insertFile('automotive_muffler_geom_sequence.mph', 'geom1');
model.geom('geom1').run('fin');

model.cpl.create('intop1', 'Integration', 'geom1');
model.cpl('intop1').set('axisym', true);
model.cpl('intop1').selection.geom('geom1', 2);
model.cpl('intop1').selection.set([1]);
model.cpl('intop1').set('opname', 'intop_inlet');
model.cpl('intop1').label('Inlet');
model.cpl.create('intop2', 'Integration', 'geom1');
model.cpl('intop2').set('axisym', true);
model.cpl('intop2').selection.geom('geom1', 2);

model.view('view1').set('renderwireframe', true);

model.cpl('intop2').selection.set([50]);
model.cpl('intop2').set('opname', 'intop_outlet');
model.cpl('intop2').label('Outlet');

model.variable.create('var1');
model.variable('var1').model('comp1');
model.variable('var1').set('P_in', 'intop_inlet(p0^2/(2*acpr.rho*acpr.c))');
model.variable('var1').descr('P_in', 'Incoming power');
model.variable('var1').set('P_out', 'intop_outlet(p*conj(p)/(2*acpr.rho*acpr.c))');
model.variable('var1').descr('P_out', 'Outgoing power');
model.variable('var1').set('TL', '10*log10(P_in/P_out)');
model.variable('var1').descr('TL', 'Transmission loss');

model.selection.create('sel1', 'Explicit');
model.selection('sel1').model('comp1');
model.selection('sel1').geom(2);
model.selection('sel1').set([10 11 13 14 16 20 21 22 23 25 26 28 29 32 36 37 38 39]);

model.view('view1').set('renderwireframe', false);

model.selection('sel1').label('Interior Boundaries');

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
model.material('mat1').propertyGroup('def').func('rho').set('plotargs', {'pA' '101325' '101325'; 'T' '273.15' '293.15'});
model.material('mat1').propertyGroup('def').func('k').set('arg', 'T');
model.material('mat1').propertyGroup('def').func('k').set('pieces', {'200.0' '1600.0' '-0.00227583562+1.15480022E-4*T^1-7.90252856E-8*T^2+4.11702505E-11*T^3-7.43864331E-15*T^4'});
model.material('mat1').propertyGroup('def').func('k').set('argunit', 'K');
model.material('mat1').propertyGroup('def').func('k').set('fununit', 'W/(m*K)');
model.material('mat1').propertyGroup('def').func('cs').set('expr', 'sqrt(1.4*R_const[K*mol/J]/0.02897*T)');
model.material('mat1').propertyGroup('def').func('cs').set('args', {'T'});
model.material('mat1').propertyGroup('def').func('cs').set('fununit', 'm/s');
model.material('mat1').propertyGroup('def').func('cs').set('argunit', {'K'});
model.material('mat1').propertyGroup('def').func('cs').set('plotargs', {'T' '273.15' '373.15'});
model.material('mat1').propertyGroup('def').func('an1').set('funcname', 'alpha_p');
model.material('mat1').propertyGroup('def').func('an1').set('expr', '-1/rho(pA,T)*d(rho(pA,T),T)');
model.material('mat1').propertyGroup('def').func('an1').set('args', {'pA' 'T'});
model.material('mat1').propertyGroup('def').func('an1').set('fununit', '1/K');
model.material('mat1').propertyGroup('def').func('an1').set('argunit', {'Pa' 'K'});
model.material('mat1').propertyGroup('def').func('an1').set('plotargs', {'pA' '101325' '101325'; 'T' '273.15' '373.15'});
model.material('mat1').propertyGroup('def').func('an2').set('funcname', 'muB');
model.material('mat1').propertyGroup('def').func('an2').set('expr', '0.6*eta(T)');
model.material('mat1').propertyGroup('def').func('an2').set('args', {'T'});
model.material('mat1').propertyGroup('def').func('an2').set('fununit', 'Pa*s');
model.material('mat1').propertyGroup('def').func('an2').set('argunit', {'K'});
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
model.material('mat1').propertyGroup('NonlinearModel').set('BA', '(def.gamma+1)/2');
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
model.material('mat1').set('family', 'air');

model.physics('acpr').create('pwr1', 'PlaneWaveRadiation', 2);
model.physics('acpr').feature('pwr1').selection.set([1]);
model.physics('acpr').feature('pwr1').create('ipf1', 'IncidentPressureField', 2);
model.physics('acpr').feature('pwr1').feature('ipf1').set('pamp', 'p0');
model.physics('acpr').feature('pwr1').feature('ipf1').set('c_mat', 'from_mat');
model.physics('acpr').feature('pwr1').feature('ipf1').set('PressureFieldMaterial', 'mat1');
model.physics('acpr').create('pwr2', 'PlaneWaveRadiation', 2);
model.physics('acpr').feature('pwr2').selection.set([50]);

model.view('view1').set('transparency', true);

model.physics('acpr').create('ishb1', 'InteriorSoundHard', 2);
model.physics('acpr').feature('ishb1').selection.named('sel1');

model.study('std1').feature('freq').set('plist', 'range(100,10,1000)');

model.physics('acpr').prop('MeshControl').set('ElementsPerWavelength', 'UserDefined');
model.physics('acpr').prop('MeshControl').set('nperlambda', 10);

model.mesh('mesh1').run;

model.sol.create('sol1');
model.sol('sol1').study('std1');

model.study('std1').feature('freq').set('notlistsolnum', 1);
model.study('std1').feature('freq').set('notsolnum', 'auto');
model.study('std1').feature('freq').set('listsolnum', 1);
model.study('std1').feature('freq').set('solnum', 'auto');

model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'freq');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').set('control', 'freq');
model.sol('sol1').create('s1', 'Stationary');
model.sol('sol1').feature('s1').set('stol', 0.001);
model.sol('sol1').feature('s1').create('p1', 'Parametric');
model.sol('sol1').feature('s1').feature.remove('pDef');
model.sol('sol1').feature('s1').feature('p1').set('pname', {'freq'});
model.sol('sol1').feature('s1').feature('p1').set('plistarr', {'range(100,10,1000)'});
model.sol('sol1').feature('s1').feature('p1').set('punit', {'Hz'});
model.sol('sol1').feature('s1').feature('p1').set('pcontinuationmode', 'no');
model.sol('sol1').feature('s1').feature('p1').set('preusesol', 'auto');
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
model.sol('sol1').feature('s1').create('d1', 'Direct');
model.sol('sol1').feature('s1').feature('d1').set('linsolver', 'mumps');
model.sol('sol1').feature('s1').feature('d1').label('Suggested Direct Solver (acpr)');
model.sol('sol1').feature('s1').create('i1', 'Iterative');
model.sol('sol1').feature('s1').feature('i1').set('linsolver', 'gmres');
model.sol('sol1').feature('s1').feature('i1').label('Suggested Iterative Solver (GMRES with GMG) (acpr)');
model.sol('sol1').feature('s1').feature('i1').create('mg1', 'Multigrid');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').set('prefun', 'gmg');
model.sol('sol1').feature('s1').create('i2', 'Iterative');
model.sol('sol1').feature('s1').feature('i2').set('linsolver', 'fgmres');
model.sol('sol1').feature('s1').feature('i2').label('Suggested Iterative Solver (FGMRES with GMG) (acpr)');
model.sol('sol1').feature('s1').feature('i2').create('mg1', 'Multigrid');
model.sol('sol1').feature('s1').feature('i2').feature('mg1').set('prefun', 'gmg');
model.sol('sol1').feature('s1').create('i3', 'Iterative');
model.sol('sol1').feature('s1').feature('i3').set('linsolver', 'gmres');
model.sol('sol1').feature('s1').feature('i3').label('Suggested Iterative Solver (Shifted Laplace) (acpr)');
model.sol('sol1').feature('s1').feature('i3').create('mg1', 'Multigrid');
model.sol('sol1').feature('s1').feature('i3').feature('mg1').set('prefun', 'gmg');
model.sol('sol1').feature('s1').feature('i3').feature('mg1').set('iter', 1);
model.sol('sol1').feature('s1').feature('i3').feature('mg1').set('mcasegen', 'coarse');
model.sol('sol1').feature('s1').feature('i3').feature('mg1').set('scale', '3');
model.sol('sol1').feature('s1').feature('i3').feature('mg1').set('slaplacemain', false);
model.sol('sol1').feature('s1').feature('i3').feature('mg1').set('slaplacemg', true);
model.sol('sol1').feature('s1').feature('i3').feature('mg1').set('addweakcontribslaplacemain', {});
model.sol('sol1').feature('s1').feature('i3').feature('mg1').set('addweakcontribslaplacemg', {});
model.sol('sol1').feature('s1').feature('i3').feature('mg1').set('epsslaplacemain', {'acpr' '0.4'});
model.sol('sol1').feature('s1').feature('i3').feature('mg1').set('epsslaplacemg', {'acpr' '0.4'});
model.sol('sol1').feature('s1').create('i4', 'Iterative');
model.sol('sol1').feature('s1').feature('i4').set('linsolver', 'gmres');
model.sol('sol1').feature('s1').feature('i4').label('Suggested Iterative Solver (Domain Decomposition) (acpr)');
model.sol('sol1').feature('s1').feature('i4').create('dd1', 'DomainDecomposition');
model.sol('sol1').feature('s1').feature('i4').feature('dd1').set('prefun', 'ddhyb');
model.sol('sol1').feature('s1').feature('i4').feature('dd1').set('ddolhandling', 'ddrestricted');
model.sol('sol1').feature('s1').feature('i4').feature('dd1').set('dompernodemax', 1);
model.sol('sol1').feature('s1').feature('i4').feature('dd1').set('dompernodemaxactive', 'on');
model.sol('sol1').feature('s1').feature('i4').feature('dd1').set('userac', 'off');
model.sol('sol1').feature('s1').feature('i4').feature('dd1').set('usecoarse', false);
model.sol('sol1').feature('s1').feature('i4').feature('dd1').set('ddboundary', 'absorbing');
model.sol('sol1').feature('s1').feature('i4').feature('dd1').set('slaplacemain', true);
model.sol('sol1').feature('s1').feature('i4').feature('dd1').set('slaplacemg', 'on');
model.sol('sol1').feature('s1').feature('i4').feature('dd1').set('alphaabsorbing', {'acpr' '1'});
model.sol('sol1').feature('s1').feature('i4').feature('dd1').set('betaabsorbing', {'acpr' '0.1'});
model.sol('sol1').feature('s1').feature('i4').feature('dd1').set('sndorderabsorbing', {'acpr' 'on'});
model.sol('sol1').feature('s1').feature('i4').feature('dd1').set('epsslaplacemain', {'acpr' '0.4'});
model.sol('sol1').feature('s1').feature('i4').feature('dd1').set('epsslaplacemg', {'acpr' '0.4'});
model.sol('sol1').feature('s1').feature('i4').feature('dd1').set('iter', 1);
model.sol('sol1').feature('s1').feature('i4').feature('dd1').feature('ds').create('mg1', 'Multigrid');
model.sol('sol1').feature('s1').feature('i4').feature('dd1').feature('ds').feature('mg1').set('slaplacemg', 'on');
model.sol('sol1').feature('s1').feature('i4').feature('dd1').feature('ds').feature('mg1').set('epsslaplacemg', {'acpr' '0.4'});
model.sol('sol1').feature('s1').feature('i4').feature('dd1').feature('ds').feature('mg1').set('iter', 1);
model.sol('sol1').feature('s1').feature('fc1').set('linsolver', 'd1');
model.sol('sol1').feature('s1').feature.remove('fcDef');
model.sol('sol1').attach('std1');

model.result.create('pg1', 'PlotGroup3D');
model.result('pg1').set('data', 'dset1');
model.result('pg1').create('surf1', 'Surface');
model.result('pg1').feature('surf1').set('expr', {'acpr.p_t'});
model.result('pg1').feature('surf1').set('colortable', 'Wave');
model.result('pg1').feature('surf1').set('colorscalemode', 'linearsymmetric');
model.result('pg1').set('showlegendsunit', true);
model.result('pg1').label('Acoustic Pressure (acpr)');
model.result.create('pg2', 'PlotGroup3D');
model.result('pg2').set('data', 'dset1');
model.result('pg2').create('surf1', 'Surface');
model.result('pg2').feature('surf1').set('expr', {'acpr.Lp_t'});
model.result('pg2').set('showlegendsunit', true);
model.result('pg2').label('Sound Pressure Level (acpr)');
model.result.create('pg3', 'PlotGroup3D');
model.result('pg3').set('data', 'dset1');
model.result('pg3').create('iso1', 'Isosurface');
model.result('pg3').feature('iso1').set('expr', {'acpr.p_t'});
model.result('pg3').feature('iso1').set('number', '10');
model.result('pg3').feature('iso1').set('colortable', 'Wave');
model.result('pg3').feature('iso1').set('colorscalemode', 'linearsymmetric');
model.result('pg3').set('showlegendsunit', true);
model.result('pg3').label('Acoustic Pressure, Isosurfaces (acpr)');

model.sol('sol1').runAll;

model.result('pg1').run;
model.result.dataset('dset1').selection.geom('geom1', 2);
model.result.dataset('dset1').selection.geom('geom1', 2);
model.result.dataset('dset1').selection.set([1 2 3 4 5 6 7 9 10 11 12 13 14 16 17 19 20 21 22 23 24 25 26 27 28 29 31 32 33 35 36 37 38 39 40 41 43 44 45 46 47 48 49 50]);
model.result('pg1').run;
model.result('pg1').setIndex('looplevel', 40, 0);
model.result('pg1').run;
model.result('pg1').feature('surf1').set('expr', 'acpr.absp_t');
model.result('pg1').feature('surf1').set('descr', 'Absolute total acoustic pressure');
model.result('pg1').feature('surf1').set('colorscalemode', 'linear');
model.result('pg1').run;
model.result('pg1').run;
model.result('pg1').create('iso1', 'Isosurface');
model.result('pg1').feature('iso1').set('expr', 'p');
model.result('pg1').feature('iso1').set('descr', 'Pressure');
model.result('pg1').feature('iso1').set('number', 10);
model.result('pg1').feature('iso1').set('colortable', 'Wave');
model.result('pg1').feature('iso1').set('colorscalemode', 'linearsymmetric');
model.result('pg1').run;
model.result.create('pg4', 'PlotGroup1D');
model.result('pg4').run;
model.result('pg4').create('glob1', 'Global');
model.result('pg4').feature('glob1').set('markerpos', 'datapoints');
model.result('pg4').feature('glob1').set('linewidth', 'preference');
model.result('pg4').feature('glob1').set('expr', {'TL'});
model.result('pg4').feature('glob1').set('descr', {'Transmission loss'});
model.result('pg4').feature('glob1').set('unit', {''});
model.result('pg4').run;
model.result('pg4').label('Transmission Loss');
model.result('pg4').set('xlabelactive', true);
model.result('pg4').set('xlabel', 'Frequency (Hz)');
model.result('pg4').set('ylabelactive', true);
model.result('pg4').set('ylabel', 'Transmission loss (dB)');
model.result('pg4').run;
model.result('pg1').run;

model.title('Automotive Muffler');

model.description(['This example simulates the pressure wave propagation in a muffler for a combustion engine. It uses a general approach for analysis of damping of the propagation of harmonic pressure waves. The model is solved in the frequency domain and provides efficient damping in a frequency range of 100-1000' native2unicode(hex2dec({'00' 'a0'}), 'unicode') 'Hz.']);

model.label('automotive_muffler.mph');

model.result('pg1').run;

model.title('Cluster Setup Validation');

model.description(['Use this app to validate that the default settings correctly submit jobs to a cluster. These default settings are taken from the preferences.' newline  newline 'The app allows you to override the default cluster settings, test modifications to the current setup, and test different settings for connecting to a cluster.']);

model.sol.remove('sol1');

model.study.create('std2');
model.study('std2').create('freq', 'Frequency');
model.study('std2').feature('freq').setSolveFor('/physics/acpr', false);
model.study('std2').feature('freq').set('plist', 490);
model.study('std2').feature('freq').setEntry('activate', 'acpr', true);
model.study('std1').create('cluco', 'ClusterComputing');
model.study('std2').create('cluco', 'ClusterComputing');
model.study('std1').feature('cluco').set('batchfileactive', true);
model.study('std1').feature('cluco').set('batchfile', 'Sweep.mph');
model.study('std2').feature('cluco').set('batchfileactive', true);
model.study('std2').feature('cluco').set('batchfile', 'Stationary.mph');

model.title('Cluster Setup Validation');

model.description(['Use this app to validate that the default settings correctly submit jobs to a cluster. These default settings are taken from the preferences.' newline  newline 'The app allows you to override the default cluster settings, test modifications to the current setup, and test different settings for connecting to a cluster.']);

model.label('cluster_setup_validation.mph');

model.setExpectedComputationTime('1 minute; 5 minutes');

model.title('Cluster Setup Validation');

model.description(['Use this app to validate that the default settings correctly submit jobs to a cluster. These default settings are taken from the preferences.' newline  newline 'The app allows you to override the default cluster settings, test modifications to the current setup, and test different settings for connecting to a cluster.']);

model.label('cluster_setup_validation.mph');

model.modelNode.label('Components');

out = model;
