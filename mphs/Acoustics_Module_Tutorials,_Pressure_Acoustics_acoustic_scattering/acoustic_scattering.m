function out = model
%
% acoustic_scattering.m
%
% Model exported on May 26 2025, 21:25 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/Acoustics_Module/Tutorials,_Pressure_Acoustics');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 3);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.physics.create('acpr', 'PressureAcoustics', 'geom1');
model.physics('acpr').model('comp1');

model.study.create('std1');
model.study('std1').create('freq', 'Frequency');
model.study('std1').feature('freq').setSolveFor('/physics/acpr', true);

% To import content from file, use:
% model.param.loadFile('FILENAME');
model.param.set('Ri', '1[m]', 'Inner sphere radius');
model.param.set('Rext', '10[m]', 'Exterior field evaluation distance');
model.param.set('f0', '1000[Hz]', 'Driving frequency');
model.param.set('c0', '1500[m/s]', 'Speed of sound');
model.param.set('lambda_min', 'c0/f0', 'Wavelength');
model.param.set('A', '0.5[m]', 'x-semiaxis ellipsoid');
model.param.set('B', '0.25[m]', 'y-semiaxis ellipsoid');
model.param.set('C', '0.25[m]', 'z-semiaxis ellipsoid');

model.geom('geom1').create('elp1', 'Ellipsoid');
model.geom('geom1').feature('elp1').set('semiaxes', {'A' 'B' 'C'});
model.geom('geom1').run('elp1');
model.geom('geom1').create('sph1', 'Sphere');
model.geom('geom1').feature('sph1').set('r', 'Ri');
model.geom('geom1').run('sph1');

model.view('view1').set('renderwireframe', true);

model.geom('geom1').create('dif1', 'Difference');
model.geom('geom1').feature('dif1').selection('input').set({'sph1'});
model.geom('geom1').feature('dif1').selection('input2').set({'elp1'});
model.geom('geom1').runPre('fin');

model.selection.create('sel1', 'Explicit');
model.selection('sel1').model('comp1');

model.geom('geom1').run;

model.selection('sel1').geom(2);
model.selection('sel1').set([1 2 3 4 9 10 13 16]);
model.selection('sel1').label('Exterior Field');

model.material.create('mat1', 'Common', 'comp1');
model.material('mat1').propertyGroup('def').func.create('eta', 'Piecewise');
model.material('mat1').propertyGroup('def').func.create('Cp', 'Piecewise');
model.material('mat1').propertyGroup('def').func.create('rho', 'Piecewise');
model.material('mat1').propertyGroup('def').func.create('k', 'Piecewise');
model.material('mat1').propertyGroup('def').func.create('cs', 'Interpolation');
model.material('mat1').propertyGroup('def').func.create('an1', 'Analytic');
model.material('mat1').propertyGroup('def').func.create('an2', 'Analytic');
model.material('mat1').propertyGroup('def').func.create('an3', 'Analytic');
model.material('mat1').label('Water, liquid');
model.material('mat1').set('family', 'water');
model.material('mat1').propertyGroup('def').func('eta').set('arg', 'T');
model.material('mat1').propertyGroup('def').func('eta').set('pieces', {'273.15' '413.15' '1.3799566804-0.021224019151*T^1+1.3604562827E-4*T^2-4.6454090319E-7*T^3+8.9042735735E-10*T^4-9.0790692686E-13*T^5+3.8457331488E-16*T^6'; '413.15' '553.75' '0.00401235783-2.10746715E-5*T^1+3.85772275E-8*T^2-2.39730284E-11*T^3'});
model.material('mat1').propertyGroup('def').func('eta').set('argunit', 'K');
model.material('mat1').propertyGroup('def').func('eta').set('fununit', 'Pa*s');
model.material('mat1').propertyGroup('def').func('Cp').set('arg', 'T');
model.material('mat1').propertyGroup('def').func('Cp').set('pieces', {'273.15' '553.75' '12010.1471-80.4072879*T^1+0.309866854*T^2-5.38186884E-4*T^3+3.62536437E-7*T^4'});
model.material('mat1').propertyGroup('def').func('Cp').set('argunit', 'K');
model.material('mat1').propertyGroup('def').func('Cp').set('fununit', 'J/(kg*K)');
model.material('mat1').propertyGroup('def').func('rho').set('arg', 'T');
model.material('mat1').propertyGroup('def').func('rho').set('smooth', 'contd1');
model.material('mat1').propertyGroup('def').func('rho').set('pieces', {'273.15' '293.15' '0.000063092789034*T^3-0.060367639882855*T^2+18.9229382407066*T-950.704055329848'; '293.15' '373.15' '0.000010335053319*T^3-0.013395065634452*T^2+4.969288832655160*T+432.257114008512'});
model.material('mat1').propertyGroup('def').func('rho').set('argunit', 'K');
model.material('mat1').propertyGroup('def').func('rho').set('fununit', 'kg/m^3');
model.material('mat1').propertyGroup('def').func('k').set('arg', 'T');
model.material('mat1').propertyGroup('def').func('k').set('pieces', {'273.15' '553.75' '-0.869083936+0.00894880345*T^1-1.58366345E-5*T^2+7.97543259E-9*T^3'});
model.material('mat1').propertyGroup('def').func('k').set('argunit', 'K');
model.material('mat1').propertyGroup('def').func('k').set('fununit', 'W/(m*K)');
model.material('mat1').propertyGroup('def').func('cs').set('table', {'273' '1403';  ...
'278' '1427';  ...
'283' '1447';  ...
'293' '1481';  ...
'303' '1507';  ...
'313' '1526';  ...
'323' '1541';  ...
'333' '1552';  ...
'343' '1555';  ...
'353' '1555';  ...
'363' '1550';  ...
'373' '1543'});
model.material('mat1').propertyGroup('def').func('cs').set('interp', 'piecewisecubic');
model.material('mat1').propertyGroup('def').func('cs').set('fununit', {'m/s'});
model.material('mat1').propertyGroup('def').func('cs').set('argunit', {'K'});
model.material('mat1').propertyGroup('def').func('an1').set('funcname', 'alpha_p');
model.material('mat1').propertyGroup('def').func('an1').set('expr', '-1/rho(T)*d(rho(T),T)');
model.material('mat1').propertyGroup('def').func('an1').set('args', {'T'});
model.material('mat1').propertyGroup('def').func('an1').set('fununit', '1/K');
model.material('mat1').propertyGroup('def').func('an1').set('argunit', {'K'});
model.material('mat1').propertyGroup('def').func('an1').set('plotfixedvalue', {'273.15'});
model.material('mat1').propertyGroup('def').func('an1').set('plotargs', {'T' '273.15' '373.15'});
model.material('mat1').propertyGroup('def').func('an2').set('funcname', 'gamma_w');
model.material('mat1').propertyGroup('def').func('an2').set('expr', '1+(T/Cp(T))*(alpha_p(T)*cs(T))^2');
model.material('mat1').propertyGroup('def').func('an2').set('args', {'T'});
model.material('mat1').propertyGroup('def').func('an2').set('fununit', '1');
model.material('mat1').propertyGroup('def').func('an2').set('argunit', {'K'});
model.material('mat1').propertyGroup('def').func('an2').set('plotfixedvalue', {'273.15'});
model.material('mat1').propertyGroup('def').func('an2').set('plotargs', {'T' '273.15' '373.15'});
model.material('mat1').propertyGroup('def').func('an3').set('funcname', 'muB');
model.material('mat1').propertyGroup('def').func('an3').set('expr', '2.79*eta(T)');
model.material('mat1').propertyGroup('def').func('an3').set('args', {'T'});
model.material('mat1').propertyGroup('def').func('an3').set('fununit', 'Pa*s');
model.material('mat1').propertyGroup('def').func('an3').set('argunit', {'K'});
model.material('mat1').propertyGroup('def').func('an3').set('plotfixedvalue', {'273.15'});
model.material('mat1').propertyGroup('def').func('an3').set('plotargs', {'T' '273.15' '553.75'});
model.material('mat1').propertyGroup('def').set('thermalexpansioncoefficient', '');
model.material('mat1').propertyGroup('def').set('bulkviscosity', '');
model.material('mat1').propertyGroup('def').set('thermalexpansioncoefficient', {'alpha_p(T)' '0' '0' '0' 'alpha_p(T)' '0' '0' '0' 'alpha_p(T)'});
model.material('mat1').propertyGroup('def').set('bulkviscosity', 'muB(T)');
model.material('mat1').propertyGroup('def').set('dynamicviscosity', 'eta(T)');
model.material('mat1').propertyGroup('def').set('ratioofspecificheat', 'gamma_w(T)');
model.material('mat1').propertyGroup('def').set('electricconductivity', {'5.5e-6[S/m]' '0' '0' '0' '5.5e-6[S/m]' '0' '0' '0' '5.5e-6[S/m]'});
model.material('mat1').propertyGroup('def').set('heatcapacity', 'Cp(T)');
model.material('mat1').propertyGroup('def').set('density', 'rho(T)');
model.material('mat1').propertyGroup('def').set('thermalconductivity', {'k(T)' '0' '0' '0' 'k(T)' '0' '0' '0' 'k(T)'});
model.material('mat1').propertyGroup('def').set('soundspeed', 'cs(T)');
model.material('mat1').propertyGroup('def').addInput('temperature');

model.physics('acpr').prop('ReferencePressure').set('ReferenceType', 'ReferencePressureWater');
model.physics('acpr').create('bpf1', 'BackgroundPressureField', 3);
model.physics('acpr').feature('bpf1').selection.set([1]);
model.physics('acpr').feature('bpf1').set('pamp', 1);
model.physics('acpr').feature('bpf1').set('c_mat', 'from_mat');
model.physics('acpr').feature('bpf1').set('PressureFieldMaterial', 'mat1');
model.physics('acpr').feature('bpf1').set('dir', [1 0 1]);
model.physics('acpr').create('efc1', 'ExteriorFieldCalculation', 2);
model.physics('acpr').feature('efc1').selection.named('sel1');
model.physics('acpr').create('pmb1', 'PerfectlyMatchedBoundary', 2);
model.physics('acpr').feature('pmb1').selection.named('sel1');

model.study('std1').feature('freq').set('plist', 'f0');

model.physics('acpr').prop('MeshControl').set('ElementsPerWavelength', 'UserDefined');
model.physics('acpr').prop('MeshControl').set('nperlambda', 6);

model.mesh('mesh1').run;

model.view('view1').hideEntities.create('hide1');
model.view('view1').hideEntities('hide1').geom(2);
model.view('view1').hideEntities('hide1').add([2]);
model.view('view1').hideObjects.clear;
model.view('view1').hideEntities.clear;

model.study('std1').setGenPlots(false);

model.sol.create('sol1');
model.sol('sol1').study('std1');
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
model.sol('sol1').feature('s1').feature('p1').set('plistarr', {'f0'});
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
model.sol('sol1').feature('s1').feature('aDef').set('complexfun', true);
model.sol('sol1').feature('s1').feature('aDef').set('cachepattern', true);
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
model.sol('sol1').runAll;

model.result.create('pg1', 'PlotGroup3D');
model.result('pg1').run;
model.result('pg1').label('Total Field');
model.result('pg1').set('showlegendsunit', true);
model.result('pg1').create('mslc1', 'Multislice');
model.result('pg1').run;
model.result('pg1').run;
model.result.duplicate('pg2', 'pg1');
model.result('pg2').run;
model.result('pg2').label('Scattered Field');
model.result('pg2').run;
model.result('pg2').feature('mslc1').set('expr', 'acpr.p_s');
model.result('pg2').run;
model.result('pg2').run;
model.result.duplicate('pg3', 'pg2');
model.result('pg3').run;
model.result('pg3').label('Background Field');
model.result('pg3').run;
model.result('pg3').feature('mslc1').set('expr', 'acpr.p_b');
model.result('pg3').run;
model.result('pg3').run;
model.result.duplicate('pg4', 'pg3');
model.result('pg4').run;
model.result('pg4').label('Sound Pressure Level');
model.result('pg4').run;
model.result('pg4').feature('mslc1').set('expr', 'acpr.Lp_s');
model.result('pg4').feature('mslc1').set('colortable', 'Rainbow');
model.result('pg4').feature('mslc1').set('colorscalemode', 'linear');
model.result('pg4').run;
model.result.create('pg5', 'PolarGroup');
model.result('pg5').run;
model.result('pg5').label('Exterior-Field Pressure, xy-Plane');
model.result('pg5').create('rp1', 'RadiationPattern');
model.result('pg5').feature('rp1').set('markerpos', 'datapoints');
model.result('pg5').feature('rp1').set('linewidth', 'preference');
model.result('pg5').feature('rp1').set('expr', 'acpr.efc1.pext');
model.result('pg5').feature('rp1').set('radius', 'Rext');
model.result('pg5').run;
model.result('pg5').run;
model.result.duplicate('pg6', 'pg5');
model.result('pg6').run;
model.result('pg6').label('Exterior-Field SPL, xy-Plane');
model.result('pg6').run;
model.result('pg6').feature('rp1').set('expr', 'acpr.efc1.Lp_pext');
model.result('pg6').run;
model.result('pg5').run;
model.result.duplicate('pg7', 'pg5');
model.result('pg7').run;
model.result('pg7').label('Exterior-Field Pressure, yz-Plane');
model.result('pg7').run;
model.result('pg7').feature('rp1').set('refdir', [0 1 0]);
model.result('pg7').feature('rp1').set('normal', [1 0 0]);
model.result('pg7').run;
model.result('pg6').run;
model.result.duplicate('pg8', 'pg6');
model.result('pg8').run;
model.result('pg8').label('Exterior-Field SPL, yz-Plane');
model.result('pg8').run;
model.result('pg8').feature('rp1').set('refdir', [0 1 0]);
model.result('pg8').feature('rp1').set('normal', [1 0 0]);
model.result('pg8').run;
model.result.create('pg9', 'PlotGroup3D');
model.result('pg9').set('data', 'dset1');
model.result('pg9').setIndex('looplevel', 1, 0);
model.result('pg9').set('edges', 'off');
model.result('pg9').set('view', 'new');
model.result('pg9').create('rp1', 'RadiationPattern');
model.result('pg9').feature('rp1').set('expr', {'acpr.efc1.Lp_pext'});
model.result('pg9').feature('rp1').set('thetadisc', 40);
model.result('pg9').feature('rp1').set('phidisc', 60);
model.result('pg9').feature('rp1').set('grid', 'fine');
model.result('pg9').feature('rp1').set('colortable', 'Rainbow');
model.result('pg9').feature('rp1').set('colorscalemode', 'linear');
model.result('pg9').set('showlegendsunit', true);
model.result('pg9').label('Exterior-Field Sound Pressure Level (acpr)');
model.result('pg9').label('Exterior-Field Sound Pressure Level (acpr)');
model.result('pg9').run;
model.result('pg9').set('view', 'new');
model.result('pg9').run;
model.result('pg9').feature('rp1').set('sphere', 'manual');
model.result('pg9').feature('rp1').set('radius', 'Rext');
model.result('pg9').run;
model.result('pg9').feature('rp1').set('expr', 'acpr.efc1.Lp_pext-66');
model.result('pg9').feature('rp1').set('descractive', true);
model.result('pg9').feature('rp1').set('descr', 'Exterior-field sound pressure level');
model.result('pg9').feature('rp1').set('useradiusascolor', false);
model.result('pg9').run;
model.result.dataset.create('grid1', 'Grid3D');
model.result.dataset('grid1').set('source', 'data');
model.result.dataset('grid1').set('parmin1', -10);
model.result.dataset('grid1').set('parmax1', 10);
model.result.dataset('grid1').set('parmin2', -10);
model.result.dataset('grid1').set('parmax2', 10);
model.result.dataset('grid1').set('parmax3', 0);
model.result.dataset('grid1').set('res1', 300);
model.result.dataset('grid1').set('res2', 300);
model.result.dataset('grid1').set('res3', 2);
model.result.create('pg10', 'PlotGroup3D');
model.result('pg10').run;
model.result('pg10').label('Exterior Pressure Field');
model.result('pg10').set('view', 'view3');
model.result('pg10').set('showlegendsunit', true);
model.result('pg10').create('surf1', 'Surface');
model.result('pg10').feature('surf1').set('data', 'grid1');
model.result('pg10').feature('surf1').set('expr', 'acpr.efc1.pext');
model.result('pg10').feature('surf1').create('filt1', 'Filter');
model.result('pg10').run;
model.result('pg10').feature('surf1').feature('filt1').set('expr', 'sqrt(x^2+y^2+z^2)>Ri*1.05');
model.result('pg10').run;
model.result('pg10').run;

model.title('Acoustic Scattering off an Ellipsoid');

model.description('This example demonstrates how to use a background field and the exterior-field calculation in a 3D sound scattering problem. The application concerns predicting the scattering of an incident plane wave off a solid ellipsoid. The resulting scattered field is determined outside the computational domain using the exterior-field calculation feature.');

model.mesh.clearMeshes;

model.sol('sol1').clearSolutionData;

model.label('acoustic_scattering.mph');

model.modelNode.label('Components');

out = model;
