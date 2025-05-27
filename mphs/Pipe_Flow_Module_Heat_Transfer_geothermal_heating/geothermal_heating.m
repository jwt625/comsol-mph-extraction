function out = model
%
% geothermal_heating.m
%
% Model exported on May 26 2025, 21:31 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/Pipe_Flow_Module/Heat_Transfer');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 3);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.physics.create('nipfl', 'NonisothermalPipeFlow', 'geom1');
model.physics('nipfl').model('comp1');

model.study.create('std1');
model.study('std1').create('stat', 'Stationary');
model.study('std1').feature('stat').setSolveFor('/physics/nipfl', true);

model.geom('geom1').insertFile('geothermal_heating_geom_sequence.mph', 'geom1');
model.geom('geom1').run('fin');

model.func.create('int1', 'Interpolation');
model.func('int1').model('comp1');
model.func('int1').setIndex('table', 0, 0, 0);
model.func('int1').setIndex('table', 284, 0, 1);
model.func('int1').setIndex('table', 2, 1, 0);
model.func('int1').setIndex('table', 288, 1, 1);
model.func('int1').setIndex('table', 4, 2, 0);
model.func('int1').setIndex('table', 291, 2, 1);
model.func('int1').setIndex('table', 6, 3, 0);
model.func('int1').setIndex('table', 293, 3, 1);
model.func('int1').setIndex('argunit', 'm', 0);
model.func('int1').setIndex('fununit', 'K', 0);

model.variable.create('var1');
model.variable('var1').model('comp1');

% To import content from file, use:
% model.variable('var1').loadFile('FILENAME');
model.variable('var1').set('T_pond', 'int1(z)', 'Water temperature');
model.variable('var1').set('d_wall', '2[mm]', 'Thickness of pipe wall');
model.variable('var1').set('k_wall', '0.46[W/m/K]', 'Thermal conductivity of high density polyethylene');

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

model.physics('nipfl').feature('pipe1').set('shape', 'Round');
model.physics('nipfl').feature('pipe1').set('innerd', '20[mm]');
model.physics('nipfl').feature('temp1').set('Tin', '5[degC]');
model.physics('nipfl').create('pipe2', 'PipeProperties', 1);
model.physics('nipfl').feature('pipe2').selection.set([1 2 3 4 5 6 7 8 9 10 11 12 15 17 18 19 20 21 27 28 29 33 34 35 39 41 42 43 44 45 51 52 53 57 58 59 63 65 66 67 68 69 75 76 77 81 82 83 87 89 90 91 97 98 102 103]);
model.physics('nipfl').feature('pipe2').set('shape', 'Round');
model.physics('nipfl').feature('pipe2').set('innerd', '50[mm]');
model.physics('nipfl').create('wht1', 'WallHeatTransfer', 1);
model.physics('nipfl').feature('wht1').selection.set([7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40 41 42 43 44 45 46 47 48 49 50 51 52 53 54 55 56 57 58 59 60 61 62 63 64 65 66 67 68 69 70 71 72 73 74 75 76 77 78 79 80 81 82 83 84 85 86 87 88 89 90 91 92 93 94 95 96 97 98 99 100 101 102 103 104]);
model.physics('nipfl').feature('wht1').set('Text', 'T_pond');
model.physics('nipfl').feature('wht1').create('intfilm1', 'InternalFilmResistance', 1);
model.physics('nipfl').feature('wht1').create('wall1', 'WallLayer', 1);
model.physics('nipfl').feature('wht1').feature('wall1').set('kChoice', 'UserDefined');
model.physics('nipfl').feature('wht1').feature('wall1').set('k', 'k_wall');
model.physics('nipfl').feature('wht1').feature('wall1').set('deltawChoice', 'UserDefined');
model.physics('nipfl').feature('wht1').feature('wall1').set('item.deltaw', 'd_wall');
model.physics('nipfl').feature('wht1').create('extfilm1', 'ExternalFilmResistance', 1);
model.physics('nipfl').feature('wht1').feature('extfilm1').set('externalMaterial', 'mat1');
model.physics('nipfl').feature('wht1').feature('extfilm1').set('u', '0.2[m/s]');
model.physics('nipfl').create('inl1', 'Inlet', 0);
model.physics('nipfl').feature('inl1').selection.set([1]);
model.physics('nipfl').feature('inl1').set('spec', 1);
model.physics('nipfl').feature('inl1').set('qv0', '4[l/s]');
model.physics('nipfl').create('hofl1', 'HeatOutflow', 0);
model.physics('nipfl').feature('hofl1').selection.set([2]);

model.mesh('mesh1').autoMeshSize(1);
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
model.sol('sol1').feature('s1').create('d1', 'Direct');
model.sol('sol1').feature('s1').feature('d1').set('linsolver', 'mumps');
model.sol('sol1').feature('s1').feature('d1').set('mumpsalloc', 1.5);
model.sol('sol1').feature('s1').feature('d1').set('ooc', 'auto');
model.sol('sol1').feature('s1').feature('d1').set('errorchk', 'auto');
model.sol('sol1').feature('s1').feature('d1').set('rhob', 1);
model.sol('sol1').feature('s1').feature('fc1').set('linsolver', 'd1');
model.sol('sol1').feature('s1').feature.remove('fcDef');
model.sol('sol1').attach('std1');
model.sol('sol1').runAll;

model.result.create('pg1', 'PlotGroup3D');
model.result('pg1').label('Pressure (nipfl)');
model.result('pg1').set('data', 'dset1');
model.result('pg1').set('defaultPlotID', 'pipeflow_NonisothermalPipeFlow/phys3/pdef1/pcond2/pg1');
model.result('pg1').feature.create('line1', 'Line');
model.result('pg1').feature('line1').set('showsolutionparams', 'on');
model.result('pg1').feature('line1').set('expr', 'p');
model.result('pg1').feature('line1').set('linetype', 'tube');
model.result('pg1').feature('line1').set('radiusexpr', '0.5*nipfl.dh');
model.result('pg1').feature('line1').set('smooth', 'internal');
model.result('pg1').feature('line1').set('showsolutionparams', 'on');
model.result('pg1').feature('line1').set('data', 'parent');
model.result.create('pg2', 'PlotGroup3D');
model.result('pg2').label('Velocity (nipfl)');
model.result('pg2').set('data', 'dset1');
model.result('pg2').set('defaultPlotID', 'pipeflow_NonisothermalPipeFlow/phys3/pdef1/pcond2/pg2');
model.result('pg2').feature.create('arwl1', 'ArrowLine');
model.result('pg2').feature('arwl1').set('showsolutionparams', 'on');
model.result('pg2').feature('arwl1').set('arrowcount', 20);
model.result('pg2').feature('arwl1').set('arrowlength', 'normalized');
model.result('pg2').feature('arwl1').set('showsolutionparams', 'on');
model.result('pg2').feature('arwl1').set('data', 'parent');
model.result('pg2').feature('arwl1').feature.create('col1', 'Color');
model.result('pg2').feature('arwl1').feature('col1').set('showcolordata', 'off');
model.result('pg2').feature('arwl1').feature('col1').set('expr', 'abs(u)');
model.result.create('pg3', 'PlotGroup3D');
model.result('pg3').label('Temperature (nipfl)');
model.result('pg3').set('data', 'dset1');
model.result('pg3').set('defaultPlotID', 'pipeflow_NonisothermalPipeFlow/phys3/pdef1/pcond2/pg3');
model.result('pg3').feature.create('line1', 'Line');
model.result('pg3').feature('line1').set('showsolutionparams', 'on');
model.result('pg3').feature('line1').set('linetype', 'tube');
model.result('pg3').feature('line1').set('radiusexpr', '0.5*nipfl.dh');
model.result('pg3').feature('line1').set('colortable', 'HeatCameraLight');
model.result('pg3').feature('line1').set('smooth', 'internal');
model.result('pg3').feature('line1').set('showsolutionparams', 'on');
model.result('pg3').feature('line1').set('data', 'parent');
model.result('pg1').run;

model.view('view1').camera.setIndex('position', -162.9903, 0);
model.view('view1').camera.setIndex('position', -177.904, 1);
model.view('view1').camera.setIndex('position', 146.1404, 2);
model.view('view1').camera.setIndex('target', -21.95, 0);
model.view('view1').camera.setIndex('target', 10.1495, 1);
model.view('view1').camera.setIndex('target', 5.1, 2);
model.view('view1').camera.setIndex('up', 0.3087, 0);
model.view('view1').camera.setIndex('up', 0.4116, 1);
model.view('view1').camera.setIndex('up', 0.85749, 2);
model.view('view1').camera.setIndex('rotationpoint', -21.95, 0);
model.view('view1').camera.setIndex('rotationpoint', 10.1495, 1);
model.view('view1').camera.setIndex('rotationpoint', 5.1, 2);
model.view('view1').camera.setIndex('viewoffset', -0.34399, 0);
model.view('view1').camera.set('viewoffset', [-0.34399 -0.06628]);
model.view('view1').camera.set('zoomanglefull', 6.75069);
model.view('view1').set('locked', true);
model.view('view1').set('showgrid', false);

model.result('pg1').run;
model.result('pg3').run;
model.result('pg3').run;
model.result('pg3').feature('line1').set('unit', 'degC');
model.result('pg3').run;
model.result.create('pg4', 'PlotGroup3D');
model.result('pg4').run;
model.result('pg4').label('Reynolds'' number');
model.result('pg4').create('line1', 'Line');
model.result('pg4').feature('line1').set('expr', 'nipfl.Re');
model.result('pg4').feature('line1').set('descr', 'Reynolds number');
model.result('pg4').feature('line1').set('linetype', 'tube');
model.result('pg4').run;

model.title('Geothermal Heating from a Pond Loop');

model.description('Ponds and lakes can serve as thermal reservoirs in geothermal heating applications with heat pumps. In this example, water circulates in a pond through polyethylene piping in a closed system. The pipes are coiled in a slinky shape and grouped onto sleds. The Nonisothermal Pipe Flow interface sets up and solves the problem of temperature distribution, pressure drops, velocity distribution and heat exchange.');

model.label('geothermal_heating.mph');

model.modelNode.label('Components');

out = model;
