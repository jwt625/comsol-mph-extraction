function out = model
%
% acoustic_structure.m
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
model.physics.create('solid', 'SolidMechanics', 'geom1');
model.physics('solid').model('comp1');

model.multiphysics.create('asb1', 'AcousticStructureBoundary', 'geom1', 2);
model.multiphysics('asb1').set('Acoustics_physics', 'acpr');
model.multiphysics('asb1').set('Structure_physics', 'solid');
model.multiphysics('asb1').selection.all;

model.study.create('std1');
model.study('std1').create('freq', 'Frequency');
model.study('std1').feature('freq').setSolveFor('/physics/acpr', true);
model.study('std1').feature('freq').setSolveFor('/physics/solid', true);
model.study('std1').feature('freq').setSolveFor('/multiphysics/asb1', true);

% To import content from file, use:
% model.param.loadFile('FILENAME');
model.param.set('f', '60[kHz]', 'Frequency');
model.param.set('phi', '(-pi/6)[rad]', 'Wave direction angle, phi');
model.param.set('theta', '(4*pi/6)[rad]', 'Wave direction angle, theta');
model.param.set('k1', 'sin(theta)*cos(phi)', 'Incident wave direction vector, X-component');
model.param.set('k2', 'sin(theta)*sin(phi)', 'Incident wave direction vector, Y-component');
model.param.set('k3', 'cos(theta)', 'Incident wave direction vector, Z-component');
model.param.set('R', '30[mm]', 'Model domain radius');
model.param.set('f', '60[kHz]', 'Frequency');
model.param.set('f', '60[kHz]');
model.param.descr('f', 'Frequency');
model.param.set('phi', '(-pi/6)[rad]', 'Wave direction angle, phi');
model.param.set('phi', '(-pi/6)[rad]');
model.param.descr('phi', 'Wave direction angle, phi');
model.param.set('theta', '(4*pi/6)[rad]', 'Wave direction angle, theta');
model.param.set('theta', '(4*pi/6)[rad]');
model.param.descr('theta', 'Wave direction angle, theta');
model.param.set('k1', 'sin(theta)*cos(phi)', 'Incident wave direction vector, X-component');
model.param.set('k1', 'sin(theta)*cos(phi)');
model.param.descr('k1', 'Incident wave direction vector, X component');
model.param.set('k2', 'sin(theta)*sin(phi)', 'Incident wave direction vector, Y-component');
model.param.set('k2', 'sin(theta)*sin(phi)');
model.param.descr('k2', 'Incident wave direction vector, Y component');
model.param.set('k3', 'cos(theta)', 'Incident wave direction vector, Z-component');
model.param.set('k3', 'cos(theta)');
model.param.descr('k3', 'Incident wave direction vector, Z component');
model.param.set('R', '30[mm]', 'Model domain radius');
model.param.set('R', '30[mm]');
model.param.descr('R', 'Model domain radius');

model.geom('geom1').lengthUnit('mm');
model.geom('geom1').create('cyl1', 'Cylinder');
model.geom('geom1').feature('cyl1').set('r', 5);
model.geom('geom1').feature('cyl1').set('h', 20);
model.geom('geom1').feature('cyl1').set('pos', [0 0 -10]);
model.geom('geom1').run('cyl1');
model.geom('geom1').create('sph1', 'Sphere');
model.geom('geom1').feature('sph1').set('r', 'R');
model.geom('geom1').run('sph1');

model.view('view1').set('renderwireframe', true);

model.selection.create('sel1', 'Explicit');
model.selection('sel1').model('comp1');

model.geom('geom1').run;

model.selection('sel1').label('Fluid Domain');
model.selection('sel1').set([1]);
model.selection.create('sel2', 'Explicit');
model.selection('sel2').model('comp1');
model.selection('sel2').label('Solid Domain');
model.selection('sel2').set([2]);
model.selection.create('sel3', 'Explicit');
model.selection('sel3').model('comp1');
model.selection('sel3').label('Radiation Boundaries');
model.selection('sel3').all;
model.selection('sel3').geom('geom1', 3, 2, {'exterior'});
model.selection('sel3').all;
model.selection.create('sel4', 'Explicit');
model.selection('sel4').model('comp1');
model.selection('sel4').label('Solid Boundaries');
model.selection('sel4').set([2]);
model.selection('sel4').geom('geom1', 3, 2, {'exterior'});
model.selection('sel4').set([2]);

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
model.material.create('mat2', 'Common', 'comp1');
model.material('mat2').propertyGroup.create('Enu', 'Young''s modulus and Poisson''s ratio');
model.material('mat2').label('Aluminum 3003-H18');
model.material('mat2').set('family', 'aluminum');
model.material('mat2').propertyGroup('def').set('relpermeability', {'1' '0' '0' '0' '1' '0' '0' '0' '1'});
model.material('mat2').propertyGroup('def').set('electricconductivity', {'2.326e7[S/m]' '0' '0' '0' '2.326e7[S/m]' '0' '0' '0' '2.326e7[S/m]'});
model.material('mat2').propertyGroup('def').set('thermalexpansioncoefficient', {'23.2e-6[1/K]' '0' '0' '0' '23.2e-6[1/K]' '0' '0' '0' '23.2e-6[1/K]'});
model.material('mat2').propertyGroup('def').set('heatcapacity', '893[J/(kg*K)]');
model.material('mat2').propertyGroup('def').set('relpermittivity', {'1' '0' '0' '0' '1' '0' '0' '0' '1'});
model.material('mat2').propertyGroup('def').set('density', '2730[kg/m^3]');
model.material('mat2').propertyGroup('def').set('thermalconductivity', {'155[W/(m*K)]' '0' '0' '0' '155[W/(m*K)]' '0' '0' '0' '155[W/(m*K)]'});
model.material('mat2').propertyGroup('Enu').set('E', '69[GPa]');
model.material('mat2').propertyGroup('Enu').set('nu', '0.33');
model.material('mat1').selection.named('sel1');
model.material('mat2').selection.named('sel2');

model.physics('acpr').selection.named('sel1');
model.physics('acpr').prop('ReferencePressure').set('ReferenceType', 'ReferencePressureWater');
model.physics('acpr').create('swr1', 'SphericalWaveRadiation', 2);
model.physics('acpr').feature('swr1').selection.named('sel3');
model.physics('acpr').feature('swr1').create('ipf1', 'IncidentPressureField', 2);
model.physics('acpr').feature('swr1').feature('ipf1').set('pamp', 1);
model.physics('acpr').feature('swr1').feature('ipf1').set('c_mat', 'from_mat');
model.physics('acpr').feature('swr1').feature('ipf1').set('PressureFieldMaterial', 'mat1');
model.physics('acpr').feature('swr1').feature('ipf1').set('dir', {'k1' 'k2' 'k3'});
model.physics('solid').selection.named('sel2');

model.study('std1').label('Study 1 - Sound Hard Cylinder');
model.study('std1').setGenPlots(false);
model.study('std1').feature('freq').set('plist', 'f');

model.physics('acpr').prop('MeshControl').set('ElementsPerWavelength', 'UserDefined');
model.physics('acpr').prop('MeshControl').set('nperlambda', 6);

model.mesh('mesh1').run;

model.view('view1').set('transparency', false);

model.study('std1').feature('freq').setEntry('activate', 'solid', false);
model.study('std1').feature('freq').setEntry('activateCoupling', 'asb1', false);

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
model.sol('sol1').feature('s1').feature('p1').set('plistarr', {'f'});
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
model.sol('sol1').feature('s1').feature('i3').feature('mg1').set('addweakcontribslaplacemain', {'solid' 'off'});
model.sol('sol1').feature('s1').feature('i3').feature('mg1').set('addweakcontribslaplacemg', {'solid' 'off'});
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

model.study.create('std2');
model.study('std2').create('freq', 'Frequency');
model.study('std2').feature('freq').setSolveFor('/physics/acpr', true);
model.study('std2').feature('freq').setSolveFor('/physics/solid', true);
model.study('std2').feature('freq').setSolveFor('/multiphysics/asb1', true);
model.study('std2').label('Study 2 - Aluminum Cylinder');
model.study('std2').setGenPlots(false);
model.study('std2').feature('freq').set('plist', 'f');

model.sol.create('sol2');
model.sol('sol2').study('std2');
model.sol('sol2').create('st1', 'StudyStep');
model.sol('sol2').feature('st1').set('study', 'std2');
model.sol('sol2').feature('st1').set('studystep', 'freq');
model.sol('sol2').create('v1', 'Variables');
model.sol('sol2').feature('v1').set('control', 'freq');
model.sol('sol2').create('s1', 'Stationary');
model.sol('sol2').feature('s1').set('stol', 0.001);
model.sol('sol2').feature('s1').create('p1', 'Parametric');
model.sol('sol2').feature('s1').feature.remove('pDef');
model.sol('sol2').feature('s1').feature('p1').set('pname', {'freq'});
model.sol('sol2').feature('s1').feature('p1').set('plistarr', {'f'});
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
model.sol('sol2').feature('s1').feature('aDef').set('complexfun', true);
model.sol('sol2').feature('s1').feature('aDef').set('cachepattern', true);
model.sol('sol2').feature('s1').feature('aDef').set('matherr', true);
model.sol('sol2').feature('s1').feature('aDef').set('blocksizeactive', false);
model.sol('sol2').feature('s1').create('seDef', 'Segregated');
model.sol('sol2').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol2').feature('s1').create('d1', 'Direct');
model.sol('sol2').feature('s1').feature('d1').set('linsolver', 'mumps');
model.sol('sol2').feature('s1').feature('d1').label('Suggested Direct Solver (asb1) (Merged)');
model.sol('sol2').feature('s1').create('i1', 'Iterative');
model.sol('sol2').feature('s1').feature('i1').set('linsolver', 'gmres');
model.sol('sol2').feature('s1').feature('i1').label('Suggested Iterative Solver (GMRES with GMG) (asb1)');
model.sol('sol2').feature('s1').feature('i1').create('mg1', 'Multigrid');
model.sol('sol2').feature('s1').feature('i1').feature('mg1').set('hybridization', 'multi');
model.sol('sol2').feature('s1').feature('i1').feature('mg1').set('hybridvar', {'comp1_p'});
model.sol('sol2').feature('s1').feature('i1').create('mg2', 'Multigrid');
model.sol('sol2').feature('s1').feature('i1').feature('mg2').set('hybridization', 'multi');
model.sol('sol2').feature('s1').feature('i1').feature('mg2').set('hybridvar', {'comp1_u'});
model.sol('sol2').feature('s1').create('i2', 'Iterative');
model.sol('sol2').feature('s1').feature('i2').set('linsolver', 'gmres');
model.sol('sol2').feature('s1').feature('i2').label('Suggested Iterative Solver (GMRES with GMG and Direct Precond.) (asb1)');
model.sol('sol2').feature('s1').feature('i2').create('mg1', 'Multigrid');
model.sol('sol2').feature('s1').feature('i2').feature('mg1').set('hybridization', 'multi');
model.sol('sol2').feature('s1').feature('i2').feature('mg1').set('hybridvar', {'comp1_p'});
model.sol('sol2').feature('s1').feature('i2').create('dp1', 'DirectPreconditioner');
model.sol('sol2').feature('s1').feature('i2').feature('dp1').set('hybridization', 'multi');
model.sol('sol2').feature('s1').feature('i2').feature('dp1').set('hybridvar', {'comp1_u'});
model.sol('sol2').feature('s1').feature('i2').feature('dp1').set('pivotperturb', '1.0E-9');
model.sol('sol2').feature('s1').feature('i2').feature('dp1').set('mumpsblr', true);
model.sol('sol2').feature('s1').feature('fc1').set('linsolver', 'd1');
model.sol('sol2').feature('s1').feature.remove('fcDef');
model.sol('sol2').feature('s1').feature.remove('seDef');
model.sol('sol2').attach('std2');
model.sol('sol2').runAll;

model.result.dataset.create('cln1', 'CutLine3D');
model.result.dataset('cln1').setIndex('genpoints', '-R*k1', 0, 0);
model.result.dataset('cln1').setIndex('genpoints', '-R*k2', 0, 1);
model.result.dataset('cln1').setIndex('genpoints', '-R*k3', 0, 2);
model.result.dataset('cln1').setIndex('genpoints', 'R*k1', 1, 0);
model.result.dataset('cln1').setIndex('genpoints', 'R*k2', 1, 1);
model.result.dataset('cln1').setIndex('genpoints', 'R*k3', 1, 2);
model.result.dataset.duplicate('cln2', 'cln1');
model.result.dataset('cln2').set('data', 'dset2');
model.result.create('pg1', 'PlotGroup1D');
model.result('pg1').run;
model.result('pg1').label('Sound Pressure Level Along Propagation Direction');
model.result('pg1').set('titletype', 'label');
model.result('pg1').create('lngr1', 'LineGraph');
model.result('pg1').feature('lngr1').set('markerpos', 'datapoints');
model.result('pg1').feature('lngr1').set('linewidth', 'preference');
model.result('pg1').feature('lngr1').set('data', 'cln1');
model.result('pg1').feature('lngr1').set('expr', 'acpr.Lp_t');
model.result('pg1').feature('lngr1').set('descr', 'Total sound pressure level');
model.result('pg1').feature('lngr1').set('xdata', 'expr');
model.result('pg1').feature('lngr1').set('xdataexpr', 'x');
model.result('pg1').feature('lngr1').set('legend', true);
model.result('pg1').feature('lngr1').set('legendmethod', 'manual');
model.result('pg1').feature('lngr1').setIndex('legends', 'Hard cylinder', 0);
model.result('pg1').feature.duplicate('lngr2', 'lngr1');
model.result('pg1').run;
model.result('pg1').feature('lngr2').set('data', 'cln2');
model.result('pg1').feature('lngr2').setIndex('legends', 'Aluminum cylinder', 0);
model.result('pg1').run;
model.result.create('pg2', 'PlotGroup3D');
model.result('pg2').run;
model.result('pg2').label('Sound Pressure Level and Displacement');
model.result('pg2').set('data', 'dset2');
model.result('pg2').set('edges', false);
model.result('pg2').set('showlegendsunit', true);
model.result('pg2').set('titletype', 'label');
model.result('pg2').create('surf1', 'Surface');
model.result('pg2').feature('surf1').set('expr', 'solid.disp');
model.result('pg2').feature('surf1').set('descr', 'Displacement magnitude');
model.result('pg2').feature('surf1').set('colortable', 'AuroraBorealis');
model.result('pg2').feature('surf1').set('colorscalemode', 'linear');
model.result('pg2').feature('surf1').create('def1', 'Deform');
model.result('pg2').run;
model.result('pg2').run;
model.result('pg2').create('slc1', 'Slice');
model.result('pg2').feature('slc1').set('expr', 'acpr.Lp_t');
model.result('pg2').feature('slc1').set('descr', 'Total sound pressure level');
model.result('pg2').feature('slc1').set('quickplane', 'zx');
model.result('pg2').feature('slc1').set('quickymethod', 'coord');
model.result('pg2').feature('slc1').set('quicky', 5);
model.result('pg2').feature('slc1').set('colortable', 'Rainbow');
model.result('pg2').feature('slc1').set('colorscalemode', 'linear');
model.result('pg2').run;
model.result('pg2').create('arws1', 'ArrowSurface');
model.result('pg2').feature('arws1').set('expr', {'solid.u_ttX' 'solid.u_ttY' 'solid.u_ttZ'});
model.result('pg2').feature('arws1').set('descr', 'Acceleration');
model.result('pg2').feature('arws1').set('arrowbase', 'head');
model.result('pg2').feature('arws1').set('scaleactive', true);
model.result('pg2').feature('arws1').set('scale', 20);
model.result('pg2').feature('arws1').set('arrowcount', 5000);
model.result('pg2').feature('arws1').set('color', 'white');

model.view('view1').camera.setIndex('position', -280.7, 0);
model.view('view1').camera.setIndex('position', -374.27, 1);
model.view('view1').camera.setIndex('position', 280.7, 2);
model.view('view1').camera.set('zoomanglefull', 3.82319);
model.view('view1').camera.set('target', [233.78 311.17 0]);
model.view('view1').camera.setIndex('target', -233.78, 2);
model.view('view1').camera.setIndex('up', 0.30869, 0);
model.view('view1').camera.setIndex('up', 0.41159, 1);
model.view('view1').camera.setIndex('up', 0.85749, 2);
model.view('view1').camera.setIndex('viewoffset', 0.05287, 0);
model.view('view1').camera.set('viewoffset', [0.05287 -0.0399]);

model.result('pg2').run;
model.result('pg2').run;

model.title(['Acoustic' native2unicode(hex2dec({'20' '13'}), 'unicode') 'Structure Interaction']);

model.description(['This example illustrates the Acoustic' native2unicode(hex2dec({'20' '13'}), 'unicode') 'Solid Interaction multiphysics interface of the Acoustics Module by modeling the behavior of a solid aluminum cylinder immersed in water and exposed to a sound signal. The acoustic pressure (sound) interacts with the elastic solid and moves the walls, which in turn push on the water thereby setting up additional sound waves. This two-way coupling is set up automatically. The frequency response from the structure is calculated, which is then fed back to the acoustics domain so that the wave pattern can be analyzed. As such, this model becomes a good example of a scattering problem. The interaction between liquid or gas acoustics with structural objects have applications in many engineering problems, for example, loudspeakers, hearing aids, acoustic sensors, and medical ultrasound diagnostics.']);

model.mesh.clearMeshes;

model.sol('sol1').clearSolutionData;
model.sol('sol2').clearSolutionData;

model.label('acoustic_structure.mph');

model.modelNode.label('Components');

out = model;
