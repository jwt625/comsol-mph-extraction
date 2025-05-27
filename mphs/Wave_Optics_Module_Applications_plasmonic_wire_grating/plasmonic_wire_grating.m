function out = model
%
% plasmonic_wire_grating.m
%
% Model exported on May 26 2025, 21:34 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/Wave_Optics_Module/Applications');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 2);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.physics.create('ewfd', 'ElectromagneticWavesFrequencyDomain', 'geom1');
model.physics('ewfd').model('comp1');

model.study.create('std1');
model.study('std1').create('freq', 'Frequency');
model.study('std1').feature('freq').set('solnum', 'auto');
model.study('std1').feature('freq').set('notsolnum', 'auto');
model.study('std1').feature('freq').set('outputmap', {});
model.study('std1').feature('freq').set('ngenAUX', '1');
model.study('std1').feature('freq').set('goalngenAUX', '1');
model.study('std1').feature('freq').set('ngenAUX', '1');
model.study('std1').feature('freq').set('goalngenAUX', '1');
model.study('std1').feature('freq').setSolveFor('/physics/ewfd', true);

model.param.set('na', '1');
model.param.descr('na', 'Refractive index, air');
model.param.set('nb', '1.2');
model.param.descr('nb', 'Refractive index, substrate');
model.param.set('d', '400[nm]');
model.param.descr('d', 'Grating constant');
model.param.set('lam0', '441[nm]');
model.param.descr('lam0', 'Vacuum wavelength');
model.param.set('f0', 'c_const/lam0');
model.param.descr('f0', 'Frequency');
model.param.set('alpha_deg', '45');
model.param.descr('alpha_deg', 'Angle of incidence, in degrees');
model.param.set('alpha', 'alpha_deg[deg]');
model.param.descr('alpha', 'Angle of incidence');
model.param.set('beta', 'asin(na*sin(alpha)/nb)');
model.param.descr('beta', 'Refraction angle');
model.param.set('r_wire', '80[nm]');
model.param.descr('r_wire', 'Wire radius');
model.param.set('epsilon_prime', '-1.75');
model.param.descr('epsilon_prime', 'Relative permittivity, real part');
model.param.set('epsilon_dprime', '5.4');
model.param.descr('epsilon_dprime', 'Relative permittivity, imaginary part');

model.geom('geom1').run;

model.study('std1').feature('freq').set('plist', 'f0');

model.geom('geom1').lengthUnit('mm');
model.geom('geom1').create('r1', 'Rectangle');
model.geom('geom1').feature('r1').set('size', {'d' '3*d'});
model.geom('geom1').feature.duplicate('r2', 'r1');
model.geom('geom1').feature('r2').set('pos', {'0' '-3*d'});
model.geom('geom1').run('r2');
model.geom('geom1').create('c1', 'Circle');
model.geom('geom1').feature('c1').set('r', 'r_wire');
model.geom('geom1').feature('c1').set('pos', {'d/2' '0'});
model.geom('geom1').run('c1');
model.geom('geom1').create('uni1', 'Union');
model.geom('geom1').feature('uni1').selection('input').set({'c1' 'r1' 'r2'});
model.geom('geom1').run('uni1');
model.geom('geom1').create('del1', 'Delete');
model.geom('geom1').feature('del1').selection('input').set('uni1', 6);
model.geom('geom1').run;

model.physics('ewfd').prop('components').set('components', 'outofplane');
model.physics('ewfd').create('wee2', 'WaveEquationElectric', 2);
model.physics('ewfd').feature('wee2').selection.set([3]);
model.physics('ewfd').feature('wee2').set('DisplacementFieldModel', 'DielectricLoss');

model.material.create('mat1', 'Common', 'comp1');
model.material('mat1').label('Air');
model.material('mat1').propertyGroup.create('RefractiveIndex', 'Refractive_index');
model.material('mat1').propertyGroup('RefractiveIndex').set('n', {'na'});
model.material('mat1').propertyGroup('RefractiveIndex').set('ki', {'0'});
model.material.create('mat2', 'Common', 'comp1');
model.material('mat2').label('Dielectric');
model.material('mat2').selection.set([1]);
model.material('mat2').propertyGroup.create('RefractiveIndex', 'Refractive_index');
model.material('mat2').propertyGroup('RefractiveIndex').set('n', {'nb'});
model.material('mat2').propertyGroup('RefractiveIndex').set('ki', {'0'});
model.material.create('mat3', 'Common', 'comp1');
model.material('mat3').label('Gold');
model.material('mat3').selection.set([3]);
model.material('mat3').propertyGroup.create('DielectricLoss', 'Dielectric_losses');
model.material('mat3').propertyGroup('DielectricLoss').set('epsilonBis', {'epsilon_dprime'});
model.material('mat3').propertyGroup('DielectricLoss').set('epsilonPrim', {'epsilon_prime'});
model.material('mat3').propertyGroup('def').set('relpermeability', {'1'});
model.material('mat3').propertyGroup('def').set('electricconductivity', {'0'});

model.physics('ewfd').create('port1', 'Port', 1);
model.physics('ewfd').feature('port1').selection.set([5]);
model.physics('ewfd').feature('port1').set('PortType', 'Periodic');
model.physics('ewfd').feature('port1').set('InputType', 'H');
model.physics('ewfd').feature('port1').set('Hampl', [0 0 1]);
model.physics('ewfd').feature('port1').set('InputType', 'E');
model.physics('ewfd').feature('port1').set('Eampl', [0 0 1]);
model.physics('ewfd').feature('port1').set('alpha_inc', 'alpha');
model.physics('ewfd').feature('port1').set('n', {'na' '0' '0' '0' 'na' '0' '0' '0' 'na'});
model.physics('ewfd').create('port2', 'Port', 1);
model.physics('ewfd').feature('port2').selection.set([2]);
model.physics('ewfd').feature('port2').set('PortType', 'Periodic');
model.physics('ewfd').feature('port2').set('InputType', 'H');
model.physics('ewfd').feature('port2').set('Hampl', [0 0 1]);
model.physics('ewfd').feature('port2').set('InputType', 'E');
model.physics('ewfd').feature('port2').set('Eampl', [0 0 1]);
model.physics('ewfd').feature('port2').set('n', {'nb' '0' '0' '0' 'nb' '0' '0' '0' 'nb'});
model.physics('ewfd').feature('port1').create('dport1', 'DiffractionOrder', 1);
model.physics('ewfd').feature('port1').feature('dport1').set('components', 'outofplane');
model.physics('ewfd').feature('port1').feature('dport1').set('mOrder', -1);
model.physics('ewfd').feature('port1').create('dport2', 'DiffractionOrder', 1);
model.physics('ewfd').feature('port1').feature('dport2').set('components', 'outofplane');
model.physics('ewfd').feature('port1').feature('dport2').set('mOrder', 1);
model.physics('ewfd').feature('port2').create('dport1', 'DiffractionOrder', 1);
model.physics('ewfd').feature('port2').feature('dport1').set('components', 'outofplane');
model.physics('ewfd').feature('port2').feature('dport1').set('mOrder', -1);
model.physics('ewfd').feature('port2').create('dport2', 'DiffractionOrder', 1);
model.physics('ewfd').feature('port2').feature('dport2').set('components', 'outofplane');
model.physics('ewfd').feature('port2').feature('dport2').set('mOrder', 1);
model.physics('ewfd').feature('port1').create('dport3', 'DiffractionOrder', 1);
model.physics('ewfd').feature('port1').feature('dport3').set('components', 'outofplane');
model.physics('ewfd').feature('port1').feature('dport3').set('mOrder', -2);
model.physics('ewfd').feature('port1').create('dport4', 'DiffractionOrder', 1);
model.physics('ewfd').feature('port1').feature('dport4').set('components', 'outofplane');
model.physics('ewfd').feature('port1').feature('dport4').set('mOrder', 2);
model.physics('ewfd').feature('port2').create('dport3', 'DiffractionOrder', 1);
model.physics('ewfd').feature('port2').feature('dport3').set('components', 'outofplane');
model.physics('ewfd').feature('port2').feature('dport3').set('mOrder', -2);
model.physics('ewfd').feature('port2').create('dport4', 'DiffractionOrder', 1);
model.physics('ewfd').feature('port2').feature('dport4').set('components', 'outofplane');
model.physics('ewfd').feature('port2').feature('dport4').set('mOrder', 2);
model.physics('ewfd').create('pc1', 'PeriodicCondition', 1);
model.physics('ewfd').feature('pc1').selection.set([1 3 7 8]);
model.physics('ewfd').feature('pc1').set('PeriodicType', 'Floquet');
model.physics('ewfd').feature('pc1').set('Floquet_source', 'FromPeriodicPort');

model.cpl.create('genext1', 'GeneralExtrusion', 'geom1');
model.cpl('genext1').selection.set([1]);
model.cpl.create('genext2', 'GeneralExtrusion', 'geom1');
model.cpl('genext2').selection.set([2]);
model.cpl.create('genext3', 'GeneralExtrusion', 'geom1');
model.cpl('genext3').selection.set([3]);
model.cpl.create('genext4', 'GeneralExtrusion', 'geom1');
model.cpl('genext4').selection.geom('geom1', 1);
model.cpl('genext4').selection.set([2 5]);

model.physics('ewfd').prop('MeshControl').set('SizeControlParameter', 'UserDefined');
model.physics('ewfd').prop('MeshControl').set('PhysicsControlledMeshMaximumElementSize', 'lam0/10');

model.study('std1').create('param', 'Parametric');
model.study('std1').feature('param').setIndex('pname', 'na', 0);
model.study('std1').feature('param').setIndex('plistarr', '', 0);
model.study('std1').feature('param').setIndex('punit', '', 0);
model.study('std1').feature('param').setIndex('pname', 'na', 0);
model.study('std1').feature('param').setIndex('plistarr', '', 0);
model.study('std1').feature('param').setIndex('punit', '', 0);
model.study('std1').feature('param').setIndex('pname', 'alpha_deg', 0);
model.study('std1').feature('param').setIndex('plistarr', 'range(0,5,85)', 0);
model.study('std1').setGenPlots(false);

model.sol.create('sol1');
model.sol('sol1').study('std1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'freq');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').set('control', 'freq');
model.sol('sol1').create('s1', 'Stationary');
model.sol('sol1').feature('s1').set('stol', 0.01);
model.sol('sol1').feature('s1').create('p1', 'Parametric');
model.sol('sol1').feature('s1').feature('p1').set('pname', {'alpha_deg'});
model.sol('sol1').feature('s1').feature('p1').set('plistarr', {'range(0,5,85)'});
model.sol('sol1').feature('s1').feature('p1').set('punit', {''});
model.sol('sol1').feature('s1').feature('p1').set('sweeptype', 'sparse');
model.sol('sol1').feature('s1').feature('p1').set('preusesol', 'no');
model.sol('sol1').feature('s1').feature('p1').set('pcontinuationmode', 'no');
model.sol('sol1').feature('s1').feature('p1').set('plot', 'off');
model.sol('sol1').feature('s1').feature('p1').set('plotgroup', 'Default');
model.sol('sol1').feature('s1').feature('p1').set('probesel', 'all');
model.sol('sol1').feature('s1').feature('p1').set('probes', {});
model.sol('sol1').feature('s1').feature('p1').set('control', 'param');
model.sol('sol1').feature('s1').set('control', 'freq');
model.sol('sol1').feature('s1').set('linpmethod', 'sol');
model.sol('sol1').feature('s1').set('linpsol', 'zero');
model.sol('sol1').feature('s1').set('control', 'freq');
model.sol('sol1').feature('s1').feature('aDef').set('complexfun', true);
model.sol('sol1').feature('s1').feature('aDef').set('cachepattern', true);
model.sol('sol1').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('s1').create('d1', 'Direct');
model.sol('sol1').feature('s1').feature('d1').set('linsolver', 'mumps');
model.sol('sol1').feature('s1').feature('d1').label('Suggested Direct Solver (ewfd)');
model.sol('sol1').feature('s1').feature('fc1').set('linsolver', 'd1');
model.sol('sol1').feature('s1').feature.remove('fcDef');
model.sol('sol1').attach('std1');
model.sol('sol1').runAll;

model.modelNode.create('comp2', true);

model.geom.create('geom2', 3);
model.geom('geom2').model('comp2');

model.mesh.create('mesh2', 'geom2');

model.geom('geom2').lengthUnit('mm');
model.geom('geom2').create('wp1', 'WorkPlane');
model.geom('geom2').feature('wp1').set('unite', true);
model.geom('geom2').feature('wp1').geom.create('r1', 'Rectangle');
model.geom('geom2').feature('wp1').geom.feature('r1').set('size', {'d' '3*d'});
model.geom('geom2').feature('wp1').geom.feature.duplicate('r2', 'r1');
model.geom('geom2').feature('wp1').geom.feature('r2').set('pos', {'0' '-3*d'});
model.geom('geom2').feature('wp1').geom.run('r2');
model.geom('geom2').feature('wp1').geom.create('c1', 'Circle');
model.geom('geom2').feature('wp1').geom.feature('c1').set('r', 'r_wire');
model.geom('geom2').feature('wp1').geom.feature('c1').set('pos', {'d/2' '0'});
model.geom('geom2').feature('wp1').geom.run('c1');
model.geom('geom2').feature('wp1').geom.create('uni1', 'Union');
model.geom('geom2').feature('wp1').geom.feature('uni1').selection('input').set({'c1' 'r1' 'r2'});
model.geom('geom2').feature('wp1').geom.run('uni1');
model.geom('geom2').feature('wp1').geom.create('del1', 'Delete');
model.geom('geom2').feature('wp1').geom.feature('del1').selection('input').set('uni1', 6);
model.geom('geom2').run('wp1');
model.geom('geom2').feature.create('ext1', 'Extrude');
model.geom('geom2').feature('ext1').setIndex('distance', '2e-3', 0);
model.geom('geom2').runPre('fin');

model.physics.create('ewfd2', 'ElectromagneticWavesFrequencyDomain', 'geom2');
model.physics('ewfd2').model('comp2');

model.study('std1').feature('freq').setSolveFor('/physics/ewfd2', true);

model.geom('geom2').run;

model.study('std1').feature('freq').setEntry('activate', 'ewfd2', false);

model.material.create('mat4', 'Common', 'comp2');
model.material('mat4').propertyGroup.create('RefractiveIndex', 'Refractive_index');
model.material('mat4').propertyGroup('RefractiveIndex').set('n', {'1'});
model.material('mat4').propertyGroup('RefractiveIndex').set('ki', {'0'});

model.mesh('mesh2').create('copy1', 'Copy');
model.mesh('mesh2').feature('copy1').selection('source').geom(3);
model.mesh('mesh2').feature('copy1').selection('destination').geom(3);
model.mesh('mesh2').feature('copy1').set('mesh', 'mesh1');
model.mesh('mesh2').feature('copy1').selection('source').set([1 2 3]);
model.mesh('mesh2').feature('copy1').selection('destination').set([4 8 13]);
model.mesh('mesh2').create('swe1', 'Sweep');
model.mesh('mesh2').feature('swe1').create('dis1', 'Distribution');
model.mesh('mesh2').feature('swe1').feature('dis1').set('numelem', 1);

model.view('view2').camera.set('zoomanglefull', 59.977142333984375);
model.view('view2').camera.setIndex('position', -0.0019886500667780638, 0);
model.view('view2').camera.setIndex('position', 8.877148502506316E-4, 1);
model.view('view2').camera.setIndex('position', 0.004594876430928707, 2);
model.view('view2').camera.setIndex('target', 0.020195061340928078, 0);
model.view('view2').camera.setIndex('target', -0.004083880223333836, 1);
model.view('view2').camera.setIndex('target', -0.015399274416267872, 2);
model.view('view2').camera.setIndex('up', 0.11592207103967667, 0);
model.view('view2').camera.setIndex('up', 0.9863825440406799, 1);
model.view('view2').camera.setIndex('up', -0.11664930731058121, 2);
model.view('view2').camera.setIndex('rotationpoint', 0.0020000000949949026, 0);
model.view('view2').camera.setIndex('rotationpoint', -6.154295988380909E-6, 1);
model.view('view2').camera.setIndex('viewoffset', 0.02189672365784645, 0);
model.view('view2').camera.setIndex('viewoffset', 0.027129866182804108, 1);

model.study.create('std2');
model.study('std2').setGenPlots(false);
model.study('std2').create('stat', 'Stationary');

model.sol.create('sol2');
model.sol('sol2').study('std2');
model.sol('sol2').create('st1', 'StudyStep');
model.sol('sol2').feature('st1').set('study', 'std2');
model.sol('sol2').feature('st1').set('studystep', 'stat');
model.sol('sol2').create('v1', 'Variables');
model.sol('sol2').feature('v1').set('control', 'stat');
model.sol('sol2').create('s1', 'Stationary');
model.sol('sol2').attach('std2');
model.sol('sol2').runAll;

model.result.create('pg1', 'PlotGroup1D');
model.result('pg1').run;
model.result('pg1').label('Reflectance and Transmittance');
model.result('pg1').set('titletype', 'none');
model.result('pg1').set('xlabelactive', true);
model.result('pg1').set('xlabel', 'Angle of incidence (degrees)');
model.result('pg1').set('ylabelactive', true);
model.result('pg1').set('ylabel', 'Reflectance and transmittance');
model.result('pg1').create('glob1', 'Global');
model.result('pg1').feature('glob1').set('markerpos', 'datapoints');
model.result('pg1').feature('glob1').set('linewidth', 'preference');
model.result('pg1').feature('glob1').setIndex('expr', 'abs(ewfd.S11)^2', 0);
model.result('pg1').feature('glob1').setIndex('unit', 1, 0);
model.result('pg1').feature('glob1').setIndex('descr', '', 0);
model.result('pg1').feature('glob1').setIndex('expr', 'abs(ewfd.S21)^2', 1);
model.result('pg1').feature('glob1').setIndex('unit', 1, 1);
model.result('pg1').feature('glob1').setIndex('descr', '', 1);
model.result('pg1').feature('glob1').setIndex('expr', 'abs(ewfd.S31)^2', 2);
model.result('pg1').feature('glob1').setIndex('unit', 1, 2);
model.result('pg1').feature('glob1').setIndex('descr', '', 2);
model.result('pg1').feature('glob1').setIndex('expr', 'abs(ewfd.S41)^2', 3);
model.result('pg1').feature('glob1').setIndex('unit', 1, 3);
model.result('pg1').feature('glob1').setIndex('descr', '', 3);
model.result('pg1').feature('glob1').setIndex('expr', 'abs(ewfd.S51)^2', 4);
model.result('pg1').feature('glob1').setIndex('unit', 1, 4);
model.result('pg1').feature('glob1').setIndex('descr', '', 4);
model.result('pg1').feature('glob1').setIndex('expr', 'abs(ewfd.S61)^2', 5);
model.result('pg1').feature('glob1').setIndex('unit', 1, 5);
model.result('pg1').feature('glob1').setIndex('descr', '', 5);
model.result('pg1').feature('glob1').setIndex('expr', 'abs(ewfd.S71)^2', 6);
model.result('pg1').feature('glob1').setIndex('unit', 1, 6);
model.result('pg1').feature('glob1').setIndex('descr', '', 6);
model.result('pg1').feature('glob1').setIndex('expr', 'abs(ewfd.S81)^2', 7);
model.result('pg1').feature('glob1').setIndex('unit', 1, 7);
model.result('pg1').feature('glob1').setIndex('descr', '', 7);
model.result('pg1').feature('glob1').setIndex('expr', 'abs(ewfd.S91)^2', 8);
model.result('pg1').feature('glob1').setIndex('unit', 1, 8);
model.result('pg1').feature('glob1').setIndex('descr', '', 8);
model.result('pg1').feature('glob1').setIndex('expr', 'abs(ewfd.S10_1)^2', 9);
model.result('pg1').feature('glob1').setIndex('unit', 1, 9);
model.result('pg1').feature('glob1').setIndex('descr', '', 9);
model.result('pg1').feature('glob1').set('xdata', 'expr');
model.result('pg1').feature('glob1').set('xdataexpr', 'alpha*180/pi');
model.result('pg1').feature('glob1').set('linemarker', 'cycle');
model.result('pg1').feature('glob1').set('legendmethod', 'manual');
model.result('pg1').feature('glob1').setIndex('legends', 'R<sub>0</sub>', 0);
model.result('pg1').feature('glob1').setIndex('legends', 'T<sub>0</sub>', 1);
model.result('pg1').feature('glob1').setIndex('legends', 'R<sub>-1</sub>', 2);
model.result('pg1').feature('glob1').setIndex('legends', 'R<sub>1</sub>', 3);
model.result('pg1').feature('glob1').setIndex('legends', 'T<sub>-1</sub>', 4);
model.result('pg1').feature('glob1').setIndex('legends', 'T<sub>1</sub>', 5);
model.result('pg1').feature('glob1').setIndex('legends', 'R<sub>-2</sub>', 6);
model.result('pg1').feature('glob1').setIndex('legends', 'R<sub>2</sub>', 7);
model.result('pg1').feature('glob1').setIndex('legends', 'T<sub>-2</sub>', 8);
model.result('pg1').feature('glob1').setIndex('legends', 'T<sub>2</sub>', 9);
model.result('pg1').run;
model.result.create('pg2', 'PlotGroup3D');
model.result('pg2').run;
model.result('pg2').set('titletype', 'manual');
model.result('pg2').set('title', 'Electric Field Norm and Diffraction Order Wave Vectors');
model.result.dataset('dset3').selection.geom('geom2', 3);
model.result.dataset('dset3').selection.geom('geom2', 3);
model.result.dataset('dset3').selection.set([1 3]);
model.result.dataset.create('arr1', 'Array3D');
model.result.dataset('arr1').set('fullsize', [11 1 1]);
model.result.dataset.duplicate('dset4', 'dset3');
model.result.dataset('dset4').selection.geom('geom2', 2);

model.view('view2').set('renderwireframe', true);

model.result.dataset('dset4').selection.geom('geom2', 2);
model.result.dataset('dset4').selection.set([2 9]);
model.result.dataset.duplicate('arr2', 'arr1');
model.result.dataset('arr2').set('data', 'dset4');
model.result.dataset.duplicate('dset5', 'dset3');
model.result.dataset('dset5').selection.geom('geom2', 3);
model.result.dataset('dset5').selection.set([1 2 3]);
model.result.dataset.duplicate('arr3', 'arr1');
model.result.dataset('arr3').set('data', 'dset5');
model.result('pg2').run;
model.result('pg2').label('Electric Field Norm and Diffraction Order Wave Vectors');
model.result('pg2').set('edges', false);
model.result('pg2').create('arws1', 'ArrowSurface');
model.result('pg2').feature('arws1').setIndex('expr', 'comp1.genext4(withsol(''sol1'',with(10,(ewfd.kIncx_1))))', 0);
model.result('pg2').feature('arws1').setIndex('expr', 'comp1.genext4(withsol(''sol1'',with(10,(ewfd.kIncy_1))))', 1);
model.result('pg2').feature('arws1').setIndex('expr', 0, 2);
model.result('pg2').feature('arws1').set('color', 'magenta');
model.result('pg2').feature('arws1').set('data', 'arr2');
model.result('pg2').run;
model.result('pg2').feature('arws1').set('arrowcount', 5);
model.result('pg2').run;
model.result('pg2').feature.duplicate('arws2', 'arws1');
model.result('pg2').run;
model.result('pg2').feature('arws2').setIndex('expr', 'comp1.genext4(withsol(''sol1'',with(10,(ewfd.kModex_1))))', 0);
model.result('pg2').feature('arws2').setIndex('expr', 'comp1.genext4(withsol(''sol1'',with(10,(ewfd.kModey_1))))', 1);
model.result('pg2').feature('arws2').set('color', 'blue');
model.result('pg2').feature.duplicate('arws3', 'arws2');
model.result('pg2').run;
model.result('pg2').feature('arws3').setIndex('expr', 'comp1.genext4(withsol(''sol1'',with(10,(ewfd.kModex_2))))', 0);
model.result('pg2').feature('arws3').setIndex('expr', 'comp1.genext4(withsol(''sol1'',with(10,(ewfd.kModey_2))))', 1);
model.result('pg2').feature.duplicate('arws4', 'arws3');
model.result('pg2').run;
model.result('pg2').feature('arws4').setIndex('expr', 'comp1.genext4(withsol(''sol1'',with(10,(ewfd.kModex_3))))', 0);
model.result('pg2').feature('arws4').setIndex('expr', 'comp1.genext4(withsol(''sol1'',with(10,(ewfd.kModey_3))))', 1);
model.result('pg2').feature('arws4').set('color', 'cyan');
model.result('pg2').feature.duplicate('arws5', 'arws4');
model.result('pg2').run;
model.result('pg2').feature('arws5').setIndex('expr', 'comp1.genext4(withsol(''sol1'',with(10,(ewfd.kModex_4))))', 0);
model.result('pg2').feature('arws5').setIndex('expr', 'comp1.genext4(withsol(''sol1'',with(10,(ewfd.kModey_4))))', 1);
model.result('pg2').feature('arws5').set('color', 'green');
model.result('pg2').feature.duplicate('arws6', 'arws5');
model.result('pg2').run;
model.result('pg2').feature('arws6').setIndex('expr', 'comp1.genext4(withsol(''sol1'',with(10,(ewfd.kModex_5))))', 0);
model.result('pg2').feature('arws6').setIndex('expr', 'comp1.genext4(withsol(''sol1'',with(10,(ewfd.kModey_5))))', 1);
model.result('pg2').feature('arws6').set('color', 'cyan');
model.result('pg2').feature.duplicate('arws7', 'arws6');
model.result('pg2').run;
model.result('pg2').feature('arws7').setIndex('expr', 'comp1.genext4(withsol(''sol1'',with(10,(ewfd.kModex_6))))', 0);
model.result('pg2').feature('arws7').setIndex('expr', 'comp1.genext4(withsol(''sol1'',with(10,(ewfd.kModey_6))))', 1);
model.result('pg2').feature('arws7').set('color', 'green');
model.result('pg2').feature.duplicate('arws8', 'arws7');
model.result('pg2').run;
model.result('pg2').feature('arws8').setIndex('expr', 'comp1.genext4(withsol(''sol1'',with(10,(ewfd.kModex_7))))', 0);
model.result('pg2').feature('arws8').setIndex('expr', 'comp1.genext4(withsol(''sol1'',with(10,(ewfd.kModey_7))))', 1);
model.result('pg2').feature('arws8').set('color', 'custom');
model.result('pg2').feature('arws8').set('customcolor', [0.7490196228027344 0.1411764770746231 0.3686274588108063]);
model.result('pg2').feature.duplicate('arws9', 'arws8');
model.result('pg2').run;
model.result('pg2').feature('arws9').setIndex('expr', 'comp1.genext4(withsol(''sol1'',with(10,(ewfd.kModex_8))))', 0);
model.result('pg2').feature('arws9').setIndex('expr', 'comp1.genext4(withsol(''sol1'',with(10,(ewfd.kModey_8))))', 1);
model.result('pg2').feature('arws9').set('color', 'gray');
model.result('pg2').run;
model.result('pg2').feature.duplicate('arws10', 'arws8');
model.result('pg2').run;
model.result('pg2').feature('arws10').setIndex('expr', 'comp1.genext4(withsol(''sol1'',with(10,(ewfd.kModex_9))))', 0);
model.result('pg2').feature('arws10').setIndex('expr', 'comp1.genext4(withsol(''sol1'',with(10,(ewfd.kModey_9))))', 1);
model.result('pg2').run;
model.result('pg2').feature.duplicate('arws11', 'arws9');
model.result('pg2').run;
model.result('pg2').feature('arws11').setIndex('expr', 'comp1.genext4(withsol(''sol1'',with(10,(ewfd.kModex_10))))', 0);
model.result('pg2').feature('arws11').setIndex('expr', 'comp1.genext4(withsol(''sol1'',with(10,(ewfd.kModey_10))))', 1);
model.result('pg2').run;
model.result('pg2').create('con1', 'Contour');
model.result('pg2').feature('con1').set('data', 'arr3');
model.result('pg2').feature('con1').set('expr', 'comp1.genext2(withsol(''sol1'',with(10,(ewfd.normE))))');
model.result('pg2').feature('con1').set('number', 10);
model.result('pg2').feature('con1').set('colortable', 'AuroraAustralis');
model.result('pg2').feature('con1').set('colorlegend', false);
model.result('pg2').feature('con1').create('filt1', 'Filter');
model.result('pg2').run;
model.result('pg2').feature('con1').feature('filt1').set('expr', 'z<1e-9');
model.result('pg2').run;
model.result('pg2').feature('con1').create('def1', 'Deform');
model.result('pg2').run;
model.result('pg2').feature('con1').feature('def1').set('expr', {'0' '0' '1e-3'});
model.result('pg2').feature('con1').feature('def1').set('scaleactive', true);
model.result('pg2').feature('con1').feature('def1').set('scale', 1);
model.result('pg2').run;
model.result('pg2').create('surf1', 'Surface');
model.result('pg2').feature('surf1').set('expr', 'comp1.genext1(withsol(''sol1'',with(10,(ewfd.normE))))');
model.result('pg2').feature('surf1').set('data', 'arr1');
model.result('pg2').feature('surf1').set('colortable', 'JupiterAuroraBorealis');
model.result('pg2').feature('surf1').set('colorlegend', false);
model.result('pg2').run;
model.result('pg2').create('surf2', 'Surface');
model.result('pg2').feature('surf2').set('expr', 'comp1.genext3(withsol(''sol1'',with(10,(ewfd.normE))))');
model.result('pg2').feature('surf2').set('data', 'arr1');
model.result('pg2').feature('surf2').set('colortable', 'ThermalDark');
model.result('pg2').feature('surf2').set('colorlegend', false);
model.result('pg2').feature('surf2').set('inheritplot', 'surf1');
model.result('pg2').run;
model.result('pg2').run;
model.result('pg2').feature('arws8').active(false);
model.result('pg2').feature('arws9').active(false);
model.result('pg2').feature('arws10').active(false);
model.result('pg2').feature('arws11').active(false);

model.study.create('std3');
model.study('std3').setGenPlots(false);
model.study('std3').create('stat', 'Stationary');

model.sol.create('sol3');
model.sol('sol3').study('std3');
model.sol('sol3').create('st1', 'StudyStep');
model.sol('sol3').feature('st1').set('study', 'std3');
model.sol('sol3').feature('st1').set('studystep', 'stat');
model.sol('sol3').create('v1', 'Variables');
model.sol('sol3').feature('v1').set('control', 'stat');
model.sol('sol3').create('s1', 'Stationary');
model.sol('sol3').attach('std3');
model.sol('sol3').runAll;

model.result.dataset('dset7').selection.geom('geom2', 3);
model.result.dataset('dset7').selection.geom('geom2', 3);
model.result.dataset('dset7').selection.set([1 3]);
model.result.dataset.create('arr4', 'Array3D');
model.result.dataset('arr4').set('data', 'dset7');
model.result.dataset('arr4').set('fullsize', [11 1 1]);
model.result.create('pg3', 'PlotGroup3D');
model.result('pg3').run;
model.result('pg3').label('Virtual Geometry');
model.result('pg3').set('data', 'arr4');
model.result('pg3').set('titletype', 'manual');
model.result('pg3').set('titlecolor', 'white');
model.result('pg3').set('title', 'Virtual Geometry');
model.result('pg3').set('edgecolor', 'custom');
model.result('pg3').set('customedgecolor', [0.6627451181411743 0.8705882430076599 0.9254902005195618]);
model.result('pg3').create('surf1', 'Surface');
model.result('pg3').feature('surf1').set('expr', '1');
model.result('pg3').feature('surf1').set('coloring', 'uniform');
model.result('pg3').feature('surf1').set('color', 'custom');
model.result('pg3').feature('surf1').set('customcolor', [0.3490196168422699 0.7137255072593689 0.8470588326454163]);
model.result('pg2').run;
model.result('pg2').set('view', 'view4');

model.view('view4').set('showgrid', false);
model.view('view4').set('showaxisorientation', false);
model.view('view4').camera.set('zoomanglefull', 10.747868537902832);
model.view('view4').camera.setIndex('position', -0.01279455330222845, 0);
model.view('view4').camera.setIndex('position', 0.0094717713072896, 1);
model.view('view4').camera.setIndex('position', 0.023080037906765938, 2);
model.view('view4').camera.setIndex('target', 0.002197401598095894, 0);
model.view('view4').camera.setIndex('target', -1.73225998878479E-7, 1);
model.view('view4').camera.setIndex('target', 9.861160069704056E-4, 2);
model.view('view4').camera.setIndex('up', 0.19846932590007782, 0);
model.view('view4').camera.setIndex('up', 0.9423726201057434, 1);
model.view('view4').camera.setIndex('up', -0.2693345546722412, 2);
model.view('view4').camera.setIndex('rotationpoint', 0.9423726201057434, 1);
model.view('view4').camera.setIndex('viewoffset', 0.008778523653745651, 0);
model.view('view4').camera.setIndex('viewoffset', 0.11581753939390182, 1);

model.title([]);

model.description('');

model.label('plasmonic_wire_grating_embedded.mph');

model.setExpectedComputationTime('4 seconds');

model.result.report.create('rpt1', 'Report');
model.result.report('rpt1').set('format', 'docx');
model.result.report('rpt1').set('filename', 'user:///plasmonic_wire_grating');
model.result.report('rpt1').set('imagesize', 'large');
model.result.report('rpt1').set('templatesource', 'brief');
model.result.report('rpt1').feature.create('tp1', 'TitlePage');
model.result.report('rpt1').feature('tp1').label('Plasmonic Wire Grating Analyzer');
model.result.report('rpt1').feature('tp1').set('reportdate', 'custom');
model.result.report('rpt1').feature('tp1').set('date', 'Mar 20, 2015 3:36:12 PM');
model.result.report('rpt1').feature('tp1').set('summary', 'This application computes coefficients of refraction, specular reflection, and first and second order diffraction as functions of the angle of incidence for a wire grating on a dielectric substrate. The incident angle of a plane wave is swept from the normal angle to the grazing angle on the grating structure. The application also shows the electric field norm plot for multiple grating periods for a selected angle of incidence.');
model.result.report('rpt1').feature.create('toc1', 'TableOfContents');
model.result.report('rpt1').feature.create('sec1', 'Section');
model.result.report('rpt1').feature('sec1').label('Software Information');
model.result.report('rpt1').feature('sec1').feature.create('root1', 'Model');
model.result.report('rpt1').feature('sec1').feature('root1').label('About the Software');
model.result.report('rpt1').feature('sec1').feature.create('std1', 'Study');
model.result.report('rpt1').feature.create('sec2', 'Section');
model.result.report('rpt1').feature('sec2').label('Global Definitions');
model.result.report('rpt1').feature('sec2').feature.create('sec1', 'Section');
model.result.report('rpt1').feature('sec2').feature('sec1').set('source', 'firstchild');
model.result.report('rpt1').feature('sec2').feature('sec1').feature.create('param1', 'Parameter');
model.result.report('rpt1').feature('sec2').feature('sec1').feature('param1').setIndex('children', false, 5, 1);
model.result.report('rpt1').feature('sec2').feature('sec1').feature('param1').setIndex('children', false, 6, 1);
model.result.report('rpt1').feature('sec2').feature('sec1').feature('param1').setIndex('children', false, 7, 1);
model.result.report('rpt1').set('imagesize', 'xlarge');
model.result.report('rpt1').feature.create('sec3', 'Section');
model.result.report('rpt1').feature('sec3').label('Results');
model.result.report('rpt1').feature('sec3').feature.create('field1', 'StringDataField');
model.result.report('rpt1').feature('sec3').feature.create('sec1', 'Section');
model.result.report('rpt1').feature('sec3').feature('sec1').label('Plot Groups');
model.result.report('rpt1').feature('sec3').feature('sec1').feature.create('sec1', 'Section');
model.result.report('rpt1').feature('sec3').feature('sec1').feature('sec1').set('source', 'firstchild');
model.result.report('rpt1').feature('sec3').feature('sec1').feature('sec1').feature.create('pg1', 'PlotGroup');
model.result.report('rpt1').feature('sec3').feature('sec1').feature.create('sec2', 'Section');
model.result.report('rpt1').feature('sec3').feature('sec1').feature('sec2').set('source', 'firstchild');
model.result.report('rpt1').feature('sec3').feature('sec1').feature('sec2').feature.create('pg1', 'PlotGroup');
model.result.report('rpt1').feature('sec3').feature('sec1').feature('sec2').feature('pg1').set('noderef', 'pg2');

model.title('Plasmonic Wire Grating Analyzer');

model.description(['This app demonstrates the following:' newline  newline  native2unicode(hex2dec({'20' '22'}), 'unicode') ' Choice of different user interface layouts for computer/tablet or smartphone' newline  native2unicode(hex2dec({'20' '22'}), 'unicode') ' Custom background image and color' newline  native2unicode(hex2dec({'20' '22'}), 'unicode') ' Graphics appearance with custom top color and bottom color' newline  native2unicode(hex2dec({'20' '22'}), 'unicode') ' Custom position of the graphics toolbar' newline  newline 'The app computes diffraction efficiencies for the zeroth, first, and second diffraction orders, in transmission and reflection, as functions of the angle of incidence for a wire grating on a dielectric substrate. The app also shows the electric field norm plot for multiple grating periods for a selected angle of incidence.']);

model.mesh.clearMeshes;

model.sol('sol1').clearSolutionData;
model.sol('sol2').clearSolutionData;
model.sol('sol3').clearSolutionData;

model.label('plasmonic_wire_grating.mph');

model.modelNode.label('Components');

out = model;
