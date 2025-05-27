function out = model
%
% cooling_flange.m
%
% Model exported on May 26 2025, 21:29 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/Heat_Transfer_Module/Thermal_Processing');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 3);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.physics.create('ht', 'HeatTransfer', 'geom1');
model.physics('ht').model('comp1');

model.study.create('std1');
model.study('std1').create('stat', 'Stationary');
model.study('std1').feature('stat').setSolveFor('/physics/ht', true);

model.param.set('k', '26.2[mW/(m*K)]');
model.param.descr('k', 'Thermal conductivity, air');
model.param.set('T_inner', '363[K]');
model.param.descr('T_inner', 'Temperature, process fluid');
model.param.set('Hh', '15[W/(m^2*K)]');
model.param.descr('Hh', 'Heat transfer coefficient');
model.param.set('nu', '18e-6[m^2/s]');
model.param.descr('nu', 'Kinematic viscosity');
model.param.set('r_inner', '8[mm]');
model.param.descr('r_inner', 'Inner pipe radius');
model.param.set('l1', '12[mm]');
model.param.descr('l1', 'Pipe length excluding flanges');
model.param.set('t1', '3[mm]');
model.param.descr('t1', 'Pipe thickness');
model.param.set('t2', '4[mm]');
model.param.descr('t2', 'Pipe thickness, flange section');
model.param.set('hf', '10[mm]');
model.param.descr('hf', 'Flange height');
model.param.set('wf', '4[mm]');
model.param.descr('wf', 'Flange width');
model.param.set('D', '2*(r_inner+t2+hf)');
model.param.descr('D', 'Outer flange diameter');

model.func.create('int1', 'Interpolation');
model.func('int1').set('funcname', 'f');
model.func('int1').setIndex('table', 0, 0, 0);
model.func('int1').setIndex('table', 0.48, 0, 1);
model.func('int1').setIndex('table', 90, 1, 0);
model.func('int1').setIndex('table', 0.46, 1, 1);
model.func('int1').setIndex('table', 100, 2, 0);
model.func('int1').setIndex('table', 0.45, 2, 1);
model.func('int1').setIndex('table', 110, 3, 0);
model.func('int1').setIndex('table', 0.435, 3, 1);
model.func('int1').setIndex('table', 120, 4, 0);
model.func('int1').setIndex('table', 0.42, 4, 1);
model.func('int1').setIndex('table', 130, 5, 0);
model.func('int1').setIndex('table', 0.38, 5, 1);
model.func('int1').setIndex('table', 140, 6, 0);
model.func('int1').setIndex('table', 0.35, 6, 1);
model.func('int1').setIndex('table', 150, 7, 0);
model.func('int1').setIndex('table', 0.28, 7, 1);
model.func('int1').setIndex('table', 160, 8, 0);
model.func('int1').setIndex('table', 0.22, 8, 1);
model.func('int1').setIndex('table', 180, 9, 0);
model.func('int1').setIndex('table', 0.15, 9, 1);
model.func('int1').setIndex('argunit', 'deg', 0);
model.func('int1').setIndex('fununit', 1, 0);

model.geom('geom1').create('wp1', 'WorkPlane');
model.geom('geom1').feature('wp1').set('unite', true);
model.geom('geom1').feature('wp1').geom.create('r1', 'Rectangle');
model.geom('geom1').feature('wp1').geom.feature('r1').set('size', {'2*wf' 't2'});
model.geom('geom1').feature('wp1').geom.feature('r1').set('pos', {'0' 'r_inner'});
model.geom('geom1').feature('wp1').geom.run('r1');
model.geom('geom1').feature('wp1').geom.create('qb1', 'QuadraticBezier');
model.geom('geom1').feature('wp1').geom.feature('qb1').setIndex('p', 'r_inner+t2', 1, 0);
model.geom('geom1').feature('wp1').geom.feature('qb1').setIndex('p', 'wf/2', 0, 1);
model.geom('geom1').feature('wp1').geom.feature('qb1').setIndex('p', 'r_inner+t2', 1, 1);
model.geom('geom1').feature('wp1').geom.feature('qb1').setIndex('p', 'wf/2', 0, 2);
model.geom('geom1').feature('wp1').geom.feature('qb1').setIndex('p', 'r_inner+t2+wf/2', 1, 2);
model.geom('geom1').feature('wp1').geom.run('qb1');
model.geom('geom1').feature('wp1').geom.create('ls1', 'LineSegment');
model.geom('geom1').feature('wp1').geom.feature('ls1').set('specify1', 'coord');
model.geom('geom1').feature('wp1').geom.feature('ls1').set('specify2', 'coord');
model.geom('geom1').feature('wp1').geom.feature('ls1').set('coord1', {'wf/2' '0'});
model.geom('geom1').feature('wp1').geom.feature('ls1').set('coord2', {'3*wf/2' '0'});
model.geom('geom1').feature('wp1').geom.feature('ls1').set('coord1', {'wf/2' 'r_inner+t2+wf/2'});
model.geom('geom1').feature('wp1').geom.feature('ls1').set('coord2', {'3*wf/2' 'r_inner+t2+wf/2'});
model.geom('geom1').feature('wp1').geom.run('ls1');
model.geom('geom1').feature('wp1').geom.create('qb2', 'QuadraticBezier');
model.geom('geom1').feature('wp1').geom.feature('qb2').setIndex('p', '3*wf/2', 0, 0);
model.geom('geom1').feature('wp1').geom.feature('qb2').setIndex('p', 'r_inner+t2+wf/2', 1, 0);
model.geom('geom1').feature('wp1').geom.feature('qb2').setIndex('p', '3*wf/2', 0, 1);
model.geom('geom1').feature('wp1').geom.feature('qb2').setIndex('p', 'r_inner+t2', 1, 1);
model.geom('geom1').feature('wp1').geom.feature('qb2').setIndex('p', '2*wf', 0, 2);
model.geom('geom1').feature('wp1').geom.feature('qb2').setIndex('p', 'r_inner+t2', 1, 2);
model.geom('geom1').feature('wp1').geom.run('qb2');
model.geom('geom1').feature('wp1').geom.create('ls2', 'LineSegment');
model.geom('geom1').feature('wp1').geom.feature('ls2').set('specify1', 'coord');
model.geom('geom1').feature('wp1').geom.feature('ls2').set('specify2', 'coord');
model.geom('geom1').feature('wp1').geom.feature('ls2').set('coord1', {'0' 'r_inner+t2'});
model.geom('geom1').feature('wp1').geom.feature('ls2').set('coord2', {'2*wf' 'r_inner+t2'});
model.geom('geom1').feature('wp1').geom.run('ls2');
model.geom('geom1').feature('wp1').geom.create('csol1', 'ConvertToSolid');
model.geom('geom1').feature('wp1').geom.feature('csol1').selection('input').set({'ls1' 'ls2' 'qb1' 'qb2'});
model.geom('geom1').feature('wp1').geom.run('csol1');
model.geom('geom1').feature('wp1').geom.create('r2', 'Rectangle');
model.geom('geom1').feature('wp1').geom.feature('r2').set('size', {'wf' 'hf-wf'});
model.geom('geom1').feature('wp1').geom.feature('r2').set('pos', {'wf/2' 'r_inner+t2+wf/2'});
model.geom('geom1').feature('wp1').geom.run('r2');
model.geom('geom1').feature('wp1').geom.create('c1', 'Circle');
model.geom('geom1').feature('wp1').geom.feature('c1').set('r', 'wf/2');
model.geom('geom1').feature('wp1').geom.feature('c1').set('angle', 180);
model.geom('geom1').feature('wp1').geom.feature('c1').set('pos', {'wf' 'r_inner+t2+hf-wf/2'});
model.geom('geom1').feature('wp1').geom.run('c1');
model.geom('geom1').feature('wp1').geom.create('arr1', 'Array');
model.geom('geom1').feature('wp1').geom.feature('arr1').selection('input').set({'c1' 'csol1' 'r1' 'r2'});
model.geom('geom1').feature('wp1').geom.feature('arr1').set('type', 'linear');
model.geom('geom1').feature('wp1').geom.feature('arr1').set('linearsize', 3);
model.geom('geom1').feature('wp1').geom.feature('arr1').set('displ', {'2*wf' '0'});
model.geom('geom1').feature('wp1').geom.run('arr1');
model.geom('geom1').feature('wp1').geom.create('pol1', 'Polygon');
model.geom('geom1').feature('wp1').geom.feature('pol1').set('source', 'table');
model.geom('geom1').feature('wp1').geom.feature('pol1').set('type', 'open');
model.geom('geom1').feature('wp1').geom.feature('pol1').set('source', 'vectors');
model.geom('geom1').feature('wp1').geom.feature('pol1').set('x', '0 0 -l1 -l1 -l1 -l1 -2*l1/3');
model.geom('geom1').feature('wp1').geom.feature('pol1').set('y', 'r_inner+t2 r_inner r_inner r_inner r_inner+t1 r_inner+t1 r_inner+t1');
model.geom('geom1').feature('wp1').geom.run('pol1');
model.geom('geom1').feature('wp1').geom.create('cb1', 'CubicBezier');
model.geom('geom1').feature('wp1').geom.feature('cb1').setIndex('p', '-2*l1/3', 0, 0);
model.geom('geom1').feature('wp1').geom.feature('cb1').setIndex('p', 'r_inner+t1', 1, 0);
model.geom('geom1').feature('wp1').geom.feature('cb1').setIndex('p', '-l1/3', 0, 1);
model.geom('geom1').feature('wp1').geom.feature('cb1').setIndex('p', 'r_inner+t1', 1, 1);
model.geom('geom1').feature('wp1').geom.feature('cb1').setIndex('p', '-l1/3', 0, 2);
model.geom('geom1').feature('wp1').geom.feature('cb1').setIndex('p', 'r_inner+t2', 1, 2);
model.geom('geom1').feature('wp1').geom.feature('cb1').setIndex('p', 'r_inner+t2', 1, 3);
model.geom('geom1').feature('wp1').geom.run('cb1');
model.geom('geom1').feature('wp1').geom.create('csol2', 'ConvertToSolid');
model.geom('geom1').feature('wp1').geom.feature('csol2').selection('input').set({'cb1' 'pol1'});
model.geom('geom1').feature('wp1').geom.run('csol2');

model.view('view2').set('showlabels', true);

model.geom('geom1').run('fin');
model.geom('geom1').run('wp1');
model.geom('geom1').feature.create('rev1', 'Revolve');
model.geom('geom1').feature('rev1').set('angtype', 'specang');
model.geom('geom1').feature('rev1').set('angle2', 180);
model.geom('geom1').feature('rev1').set('axis', [1 0]);
model.geom('geom1').run('fin');

model.variable.create('var1');
model.variable('var1').model('comp1');
model.variable('var1').selection.geom('geom1', 2);
model.variable('var1').selection.set([3 7 9 10 13 19 23 25 29 32 35 38 39 40 41 42 45 51 55 57 61 64 67 70 71 72 73 74 77 83 87 89 93 96 99 102 103 104 105 106]);

model.selection.create('sel1', 'Explicit');
model.selection('sel1').model('comp1');
model.selection('sel1').geom(2);
model.selection('sel1').label('Outer Boundaries');
model.selection('sel1').set([3 7 9 10 13 19 23 25 29 32 35 38 39 40 41 42 45 51 55 57 61 64 67 70 71 72 73 74 77 83 87 89 93 96 99 102 103 104 105 106]);

model.variable('var1').selection.named('sel1');
model.variable('var1').set('alphap', '1/ampr1.T_amb');
model.variable('var1').descr('alphap', 'Coefficient of thermal expansion');
model.variable('var1').set('Gr', 'g_const*alphap*(T-ampr1.T_amb)*D^3/nu^2');
model.variable('var1').descr('Gr', 'Grashof number');
model.variable('var1').set('theta', 'atan(y/z)+90[deg]');
model.variable('var1').descr('theta', 'Incidence angle');
model.variable('var1').set('Hc', 'k*f(theta)*Gr^0.25/D');
model.variable('var1').descr('Hc', 'Heat transfer film coefficient');

model.material.create('mat1', 'Common', 'comp1');
model.material('mat1').propertyGroup.create('Enu', 'Young''s modulus and Poisson''s ratio');
model.material('mat1').propertyGroup.create('RefractiveIndex', 'Refractive index');
model.material('mat1').label('Silica glass');
model.material('mat1').set('family', 'custom');
model.material('mat1').set('customambient', [1 1 1]);
model.material('mat1').set('noise', true);
model.material('mat1').set('fresnel', 0.99);
model.material('mat1').set('roughness', 0.02);
model.material('mat1').set('metallic', 0);
model.material('mat1').set('pearl', 0);
model.material('mat1').set('diffusewrap', 0);
model.material('mat1').set('clearcoat', 0);
model.material('mat1').set('reflectance', 0);
model.material('mat1').propertyGroup('def').set('relpermeability', {'1' '0' '0' '0' '1' '0' '0' '0' '1'});
model.material('mat1').propertyGroup('def').set('electricconductivity', {'1e-14[S/m]' '0' '0' '0' '1e-14[S/m]' '0' '0' '0' '1e-14[S/m]'});
model.material('mat1').propertyGroup('def').set('thermalexpansioncoefficient', {'0.55e-6[1/K]' '0' '0' '0' '0.55e-6[1/K]' '0' '0' '0' '0.55e-6[1/K]'});
model.material('mat1').propertyGroup('def').set('heatcapacity', '703[J/(kg*K)]');
model.material('mat1').propertyGroup('def').set('relpermittivity', {'3.75' '0' '0' '0' '3.75' '0' '0' '0' '3.75'});
model.material('mat1').propertyGroup('def').set('density', '2203[kg/m^3]');
model.material('mat1').propertyGroup('def').set('thermalconductivity', {'1.38[W/(m*K)]' '0' '0' '0' '1.38[W/(m*K)]' '0' '0' '0' '1.38[W/(m*K)]'});
model.material('mat1').propertyGroup('Enu').set('E', '73.1[GPa]');
model.material('mat1').propertyGroup('Enu').set('nu', '0.17');
model.material('mat1').propertyGroup('RefractiveIndex').set('n', {'1.45' '0' '0' '0' '1.45' '0' '0' '0' '1.45'});

model.common.create('ampr1', 'AmbientProperties', 'comp1');
model.common('ampr1').set('T_amb', '298[K]');

model.physics('ht').prop('ShapeProperty').set('order_temperature', '2s');
model.physics('ht').feature('init1').set('Tinit', '323.15[K]');
model.physics('ht').create('sym1', 'Symmetry', 2);

model.view('view1').set('renderwireframe', true);

model.physics('ht').feature('sym1').selection.set([2 8 12 15 21 22 24 27 33 34 44 47 53 54 56 59 65 66 76 79 85 86 88 91 97 98]);
model.physics('ht').create('hf1', 'HeatFluxBoundary', 2);
model.physics('ht').feature('hf1').selection.set([4 6 16 18 48 50 80 82]);
model.physics('ht').feature('hf1').set('HeatFluxType', 'ConvectiveHeatFlux');
model.physics('ht').feature('hf1').set('h', 'Hh');
model.physics('ht').feature('hf1').set('Text', 'T_inner');

model.view('view1').set('renderwireframe', false);

model.physics('ht').create('hf2', 'HeatFluxBoundary', 2);
model.physics('ht').feature('hf2').selection.named('sel1');
model.physics('ht').feature('hf2').set('HeatFluxType', 'ConvectiveHeatFlux');
model.physics('ht').feature('hf2').set('h', 'Hc');
model.physics('ht').feature('hf2').set('Text_src', 'root.comp1.ampr1.T_amb');

model.mesh('mesh1').create('map1', 'Map');
model.mesh('mesh1').feature('map1').selection.set([8 21 22 33 53 54 65 85 86 97]);
model.mesh('mesh1').feature('map1').feature.create('size1', 'Size');
model.mesh('mesh1').feature('map1').feature('size1').set('hauto', 2);
model.mesh('mesh1').run('map1');
model.mesh('mesh1').create('ftri1', 'FreeTri');
model.mesh('mesh1').feature('ftri1').selection.set([34 66 98]);
model.mesh('mesh1').run('ftri1');
model.mesh('mesh1').create('swe1', 'Sweep');
model.mesh('mesh1').feature('swe1').create('dis1', 'Distribution');
model.mesh('mesh1').feature('swe1').feature('dis1').set('numelem', 30);
model.mesh('mesh1').run;

model.sol.create('sol1');
model.sol('sol1').study('std1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'stat');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').set('control', 'stat');
model.sol('sol1').create('s1', 'Stationary');
model.sol('sol1').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('s1').feature('fc1').set('dtech', 'auto');
model.sol('sol1').feature('s1').feature('fc1').set('initstep', 0.01);
model.sol('sol1').feature('s1').feature('fc1').set('minstep', 1.0E-6);
model.sol('sol1').feature('s1').feature('fc1').set('maxiter', 50);
model.sol('sol1').feature('s1').feature('fc1').set('termonres', 'off');
model.sol('sol1').feature('s1').create('d1', 'Direct');
model.sol('sol1').feature('s1').feature('d1').set('linsolver', 'pardiso');
model.sol('sol1').feature('s1').feature('d1').set('pivotperturb', 1.0E-13);
model.sol('sol1').feature('s1').feature('d1').label('Direct, heat transfer variables (ht)');
model.sol('sol1').feature('s1').create('i1', 'Iterative');
model.sol('sol1').feature('s1').feature('i1').set('linsolver', 'gmres');
model.sol('sol1').feature('s1').feature('i1').set('prefuntype', 'left');
model.sol('sol1').feature('s1').feature('i1').set('itrestart', 50);
model.sol('sol1').feature('s1').feature('i1').set('rhob', 20);
model.sol('sol1').feature('s1').feature('i1').set('maxlinit', 10000);
model.sol('sol1').feature('s1').feature('i1').set('nlinnormuse', 'on');
model.sol('sol1').feature('s1').feature('i1').label('AMG, heat transfer variables (ht)');
model.sol('sol1').feature('s1').feature('i1').create('mg1', 'Multigrid');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').set('prefun', 'saamg');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').set('mgcycle', 'v');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').set('maxcoarsedof', 50000);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').set('strconn', 0.01);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').set('nullspace', 'constant');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').set('usesmooth', false);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').set('saamgcompwise', true);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').set('loweramg', true);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').set('compactaggregation', false);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('pr').create('so1', 'SOR');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('pr').feature('so1').set('iter', 2);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('pr').feature('so1').set('relax', 0.9);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('po').create('so1', 'SOR');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('po').feature('so1').set('iter', 2);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('po').feature('so1').set('relax', 0.9);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('cs').create('d1', 'Direct');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('cs').feature('d1').set('linsolver', 'pardiso');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('cs').feature('d1').set('pivotperturb', 1.0E-13);
model.sol('sol1').feature('s1').feature('fc1').set('linsolver', 'd1');
model.sol('sol1').feature('s1').feature('fc1').set('dtech', 'auto');
model.sol('sol1').feature('s1').feature('fc1').set('initstep', 0.01);
model.sol('sol1').feature('s1').feature('fc1').set('minstep', 1.0E-6);
model.sol('sol1').feature('s1').feature('fc1').set('maxiter', 50);
model.sol('sol1').feature('s1').feature('fc1').set('termonres', 'off');
model.sol('sol1').feature('s1').feature.remove('fcDef');
model.sol('sol1').attach('std1');
model.sol('sol1').runAll;

model.result.create('pg1', 'PlotGroup3D');
model.result('pg1').label('Temperature (ht)');
model.result('pg1').set('data', 'dset1');
model.result('pg1').set('defaultPlotID', 'ht/HT_PhysicsInterfaces/icom8/pdef1/pcond3/pcond3/pg1');
model.result('pg1').feature.create('vol1', 'Volume');
model.result('pg1').feature('vol1').set('showsolutionparams', 'on');
model.result('pg1').feature('vol1').set('solutionparams', 'parent');
model.result('pg1').feature('vol1').set('colortable', 'HeatCameraLight');
model.result('pg1').feature('vol1').set('smooth', 'internal');
model.result('pg1').feature('vol1').set('showsolutionparams', 'on');
model.result('pg1').feature('vol1').set('data', 'parent');
model.result('pg1').run;

model.view.create('view3', 3);
model.view('view3').camera.set('zoomanglefull', 16.5);
model.view('view3').camera.setIndex('position', -0.2, 0);
model.view('view3').camera.setIndex('position', 0.1, 1);
model.view('view3').camera.set('position', [-0.2 0.1 0.2]);
model.view('view3').camera.setIndex('target', '0.0', 0);
model.view('view3').camera.setIndex('target', '0.0', 1);
model.view('view3').camera.set('target', {'0.0' '0.0' '0.01'});
model.view('view3').camera.setIndex('up', 0.3, 0);
model.view('view3').camera.setIndex('up', 1, 1);
model.view('view3').camera.set('up', [0.3 1 -0.25]);
model.view('view3').camera.setIndex('rotationpoint', '0.0', 0);
model.view('view3').camera.setIndex('rotationpoint', '0.0', 1);
model.view('view3').camera.set('rotationpoint', {'0.0' '0.0' '0.0'});
model.view('view3').camera.setIndex('viewoffset', -0.04, 0);
model.view('view3').camera.set('viewoffset', [-0.04 -0.02]);
model.view('view3').set('locked', true);

model.result('pg1').run;
model.result('pg1').set('view', 'view3');
model.result('pg1').run;
model.result.create('pg2', 'PlotGroup3D');
model.result('pg2').run;
model.result('pg2').label('Heat Transfer Film Coefficient');
model.result('pg2').set('view', 'view3');
model.result('pg2').create('surf1', 'Surface');
model.result('pg2').feature('surf1').set('expr', 'Hc');
model.result('pg2').feature('surf1').set('descr', 'Heat transfer film coefficient');
model.result('pg2').run;
model.result.numerical.create('int1', 'IntSurface');
model.result.numerical('int1').set('intvolume', true);
model.result.numerical('int1').label('Outgoing Heat Flux');
model.result.numerical('int1').selection.named('sel1');
model.result.numerical('int1').set('expr', {'ht.ntflux'});
model.result.numerical('int1').set('descr', {'Normal total heat flux'});
model.result.numerical('int1').set('unit', {'W'});
model.result.table.create('tbl1', 'Table');
model.result.table('tbl1').comments('Outgoing Heat Flux');
model.result.numerical('int1').set('table', 'tbl1');
model.result.numerical('int1').setResult;

model.cpl.create('intop1', 'Integration', 'geom1');
model.cpl('intop1').set('axisym', true);
model.cpl('intop1').label('Integration, Outer');
model.cpl('intop1').set('opname', 'intop_outer');
model.cpl('intop1').selection.geom('geom1', 2);
model.cpl('intop1').selection.named('sel1');

model.variable.create('var2');
model.variable('var2').model('comp1');
model.variable('var2').set('P_cooling', '2*intop_outer(ht.q0)');
model.variable('var2').descr('P_cooling', 'Cooling power');

model.study.create('std2');
model.study('std2').create('stat', 'Stationary');
model.study('std2').feature('stat').setSolveFor('/physics/ht', true);
model.study('std2').create('param', 'Parametric');
model.study('std2').feature('param').setIndex('pname', 'k', 0);
model.study('std2').feature('param').setIndex('plistarr', '', 0);
model.study('std2').feature('param').setIndex('punit', 'W/(m*K)', 0);
model.study('std2').feature('param').setIndex('pname', 'k', 0);
model.study('std2').feature('param').setIndex('plistarr', '', 0);
model.study('std2').feature('param').setIndex('punit', 'W/(m*K)', 0);
model.study('std2').feature('param').setIndex('pname', 'r_inner', 0);
model.study('std2').feature('param').setIndex('plistarr', 'range(6,1,10)', 0);
model.study('std2').feature('param').setIndex('punit', 'mm', 0);

model.sol.create('sol2');
model.sol('sol2').study('std2');
model.sol('sol2').create('st1', 'StudyStep');
model.sol('sol2').feature('st1').set('study', 'std2');
model.sol('sol2').feature('st1').set('studystep', 'stat');
model.sol('sol2').create('v1', 'Variables');
model.sol('sol2').feature('v1').set('control', 'stat');
model.sol('sol2').create('s1', 'Stationary');
model.sol('sol2').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol2').feature('s1').feature('fc1').set('dtech', 'auto');
model.sol('sol2').feature('s1').feature('fc1').set('initstep', 0.01);
model.sol('sol2').feature('s1').feature('fc1').set('minstep', 1.0E-6);
model.sol('sol2').feature('s1').feature('fc1').set('maxiter', 50);
model.sol('sol2').feature('s1').feature('fc1').set('termonres', 'off');
model.sol('sol2').feature('s1').create('d1', 'Direct');
model.sol('sol2').feature('s1').feature('d1').set('linsolver', 'pardiso');
model.sol('sol2').feature('s1').feature('d1').set('pivotperturb', 1.0E-13);
model.sol('sol2').feature('s1').feature('d1').label('Direct, heat transfer variables (ht)');
model.sol('sol2').feature('s1').create('i1', 'Iterative');
model.sol('sol2').feature('s1').feature('i1').set('linsolver', 'gmres');
model.sol('sol2').feature('s1').feature('i1').set('prefuntype', 'left');
model.sol('sol2').feature('s1').feature('i1').set('itrestart', 50);
model.sol('sol2').feature('s1').feature('i1').set('rhob', 20);
model.sol('sol2').feature('s1').feature('i1').set('maxlinit', 10000);
model.sol('sol2').feature('s1').feature('i1').set('nlinnormuse', 'on');
model.sol('sol2').feature('s1').feature('i1').label('AMG, heat transfer variables (ht)');
model.sol('sol2').feature('s1').feature('i1').create('mg1', 'Multigrid');
model.sol('sol2').feature('s1').feature('i1').feature('mg1').set('prefun', 'saamg');
model.sol('sol2').feature('s1').feature('i1').feature('mg1').set('mgcycle', 'v');
model.sol('sol2').feature('s1').feature('i1').feature('mg1').set('maxcoarsedof', 50000);
model.sol('sol2').feature('s1').feature('i1').feature('mg1').set('strconn', 0.01);
model.sol('sol2').feature('s1').feature('i1').feature('mg1').set('nullspace', 'constant');
model.sol('sol2').feature('s1').feature('i1').feature('mg1').set('usesmooth', false);
model.sol('sol2').feature('s1').feature('i1').feature('mg1').set('saamgcompwise', true);
model.sol('sol2').feature('s1').feature('i1').feature('mg1').set('loweramg', true);
model.sol('sol2').feature('s1').feature('i1').feature('mg1').set('compactaggregation', false);
model.sol('sol2').feature('s1').feature('i1').feature('mg1').feature('pr').create('so1', 'SOR');
model.sol('sol2').feature('s1').feature('i1').feature('mg1').feature('pr').feature('so1').set('iter', 2);
model.sol('sol2').feature('s1').feature('i1').feature('mg1').feature('pr').feature('so1').set('relax', 0.9);
model.sol('sol2').feature('s1').feature('i1').feature('mg1').feature('po').create('so1', 'SOR');
model.sol('sol2').feature('s1').feature('i1').feature('mg1').feature('po').feature('so1').set('iter', 2);
model.sol('sol2').feature('s1').feature('i1').feature('mg1').feature('po').feature('so1').set('relax', 0.9);
model.sol('sol2').feature('s1').feature('i1').feature('mg1').feature('cs').create('d1', 'Direct');
model.sol('sol2').feature('s1').feature('i1').feature('mg1').feature('cs').feature('d1').set('linsolver', 'pardiso');
model.sol('sol2').feature('s1').feature('i1').feature('mg1').feature('cs').feature('d1').set('pivotperturb', 1.0E-13);
model.sol('sol2').feature('s1').feature('fc1').set('linsolver', 'd1');
model.sol('sol2').feature('s1').feature('fc1').set('dtech', 'auto');
model.sol('sol2').feature('s1').feature('fc1').set('initstep', 0.01);
model.sol('sol2').feature('s1').feature('fc1').set('minstep', 1.0E-6);
model.sol('sol2').feature('s1').feature('fc1').set('maxiter', 50);
model.sol('sol2').feature('s1').feature('fc1').set('termonres', 'off');
model.sol('sol2').feature('s1').feature.remove('fcDef');
model.sol('sol2').attach('std2');

model.batch.create('p1', 'Parametric');
model.batch('p1').study('std2');
model.batch('p1').create('so1', 'Solutionseq');
model.batch('p1').feature('so1').set('seq', 'sol2');
model.batch('p1').feature('so1').set('store', 'on');
model.batch('p1').feature('so1').set('clear', 'on');
model.batch('p1').feature('so1').set('psol', 'none');
model.batch('p1').set('pname', {'r_inner'});
model.batch('p1').set('plistarr', {'range(6,1,10)'});
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

model.result.create('pg3', 'PlotGroup3D');
model.result('pg3').label('Temperature (ht) 1');
model.result('pg3').set('data', 'dset3');
model.result('pg3').setIndex('looplevel', 5, 0);
model.result('pg3').set('data', 'dset3');
model.result('pg3').setIndex('looplevel', 5, 0);
model.result('pg3').set('defaultPlotID', 'ht/HT_PhysicsInterfaces/icom8/pdef1/pcond3/pcond3/pg1');
model.result('pg3').feature.create('vol1', 'Volume');
model.result('pg3').feature('vol1').set('showsolutionparams', 'on');
model.result('pg3').feature('vol1').set('solutionparams', 'parent');
model.result('pg3').feature('vol1').set('colortable', 'HeatCameraLight');
model.result('pg3').feature('vol1').set('smooth', 'internal');
model.result('pg3').feature('vol1').set('showsolutionparams', 'on');
model.result('pg3').feature('vol1').set('data', 'parent');
model.result('pg3').run;
model.result('pg3').set('view', 'view3');
model.result.create('pg4', 'PlotGroup1D');
model.result('pg4').run;
model.result('pg4').label('Cooling Power');
model.result('pg4').set('data', 'dset3');
model.result('pg4').create('glob1', 'Global');
model.result('pg4').feature('glob1').set('markerpos', 'datapoints');
model.result('pg4').feature('glob1').set('linewidth', 'preference');
model.result('pg4').feature('glob1').set('expr', {'P_cooling'});
model.result('pg4').feature('glob1').set('descr', {'Cooling power'});
model.result('pg4').feature('glob1').set('legend', false);
model.result('pg4').run;
model.result('pg4').set('xlabelactive', true);
model.result('pg4').set('xlabel', 'Inner pipe radius (m)');
model.result('pg4').run;
model.result('pg1').run;

model.title('Temperature Field in a Cooling Flange');

model.description('This example of a cooling flange uses heat transfer coefficients for forced convection in the channel and for free convection on the outer surfaces. The model also makes use of the interpolation and mapped mesh features and involves a parametric sweep over the channel radius.');

model.mesh.clearMeshes;

model.sol('sol1').clearSolutionData;
model.sol('sol2').clearSolutionData;
model.sol('sol3').clearSolutionData;
model.sol('sol4').clearSolutionData;
model.sol('sol5').clearSolutionData;
model.sol('sol6').clearSolutionData;
model.sol('sol7').clearSolutionData;
model.sol('sol8').clearSolutionData;

model.label('cooling_flange.mph');

model.modelNode.label('Components');

out = model;
