function out = model
%
% water_hammer_verification.m
%
% Model exported on May 26 2025, 21:31 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/Pipe_Flow_Module/Verification_Examples');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 3);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.physics.create('whtd', 'WaterHammer', 'geom1');
model.physics('whtd').model('comp1');

model.study.create('std1');
model.study('std1').create('time', 'Transient');
model.study('std1').feature('time').setSolveFor('/physics/whtd', true);

% To import content from file, use:
% model.param.loadFile('FILENAME');
model.param.set('L', '20[m]', 'Pipe length');
model.param.set('R', '398.5[mm]', 'Pipe inner radius');
model.param.set('w', '8[mm]', 'Pipe wall thickness');
model.param.set('E', '210[GPa]', 'Pipe Young''s modulus');
model.param.set('Q0', '0.5[m^3/s]', 'Initial flow rate');
model.param.set('u0', 'Q0/(R^2*pi)', 'Initial velocity');
model.param.set('p0', '1[atm]', 'Initial pressure');
model.param.set('z0', '11.15[m]', 'Measurement point');
model.param.set('dt', '0.1*L/N/1020[m/s]', 'Time step according to CFL');
model.param.set('N', '400', 'Number of mesh points');

model.geom('geom1').create('pol1', 'Polygon');
model.geom('geom1').feature('pol1').set('source', 'table');
model.geom('geom1').feature('pol1').setIndex('table', 0, 0, 0);
model.geom('geom1').feature('pol1').setIndex('table', 0, 0, 1);
model.geom('geom1').feature('pol1').setIndex('table', 0, 0, 2);
model.geom('geom1').feature('pol1').setIndex('table', 'z0', 1, 0);
model.geom('geom1').feature('pol1').setIndex('table', 0, 1, 1);
model.geom('geom1').feature('pol1').setIndex('table', 0, 1, 2);
model.geom('geom1').feature('pol1').setIndex('table', 'L', 2, 0);
model.geom('geom1').feature('pol1').setIndex('table', 0, 2, 1);
model.geom('geom1').feature('pol1').setIndex('table', 0, 2, 2);
model.geom('geom1').runPre('fin');
model.geom('geom1').run;

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

model.physics('whtd').feature('pipe1').set('shape', 'Round');
model.physics('whtd').feature('pipe1').set('innerd', '2*R');
model.physics('whtd').feature('pipe1').set('E_mat', 'userdef');
model.physics('whtd').feature('pipe1').set('E', 'E');
model.physics('whtd').feature('pipe1').set('dw', 'w');
model.physics('whtd').feature('pipe1').set('frictionmodel', 100);
model.physics('whtd').feature('init1').set('p', 'p0');
model.physics('whtd').feature('init1').set('u', 'u0');
model.physics('whtd').create('pres1', 'Pressure', 0);
model.physics('whtd').feature('pres1').selection.set([1]);
model.physics('whtd').feature('pres1').set('p', 'p0');

model.mesh('mesh1').create('edg1', 'Edge');
model.mesh('mesh1').feature('edg1').selection.set([1 2]);
model.mesh('mesh1').feature('size').set('custom', true);
model.mesh('mesh1').feature('size').set('hmax', 'L/N');
model.mesh('mesh1').feature('size').set('hmin', '1[mm]');
model.mesh('mesh1').run;

model.study('std1').feature('time').set('tlist', 'range(0,1e-3,0.24)');

model.sol.create('sol1');
model.sol('sol1').study('std1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'time');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').set('control', 'time');
model.sol('sol1').create('t1', 'Time');
model.sol('sol1').feature('t1').set('tlist', 'range(0,1e-3,0.24)');
model.sol('sol1').feature('t1').set('plot', 'off');
model.sol('sol1').feature('t1').set('plotgroup', 'Default');
model.sol('sol1').feature('t1').set('plotfreq', 'tout');
model.sol('sol1').feature('t1').set('probesel', 'all');
model.sol('sol1').feature('t1').set('probes', {});
model.sol('sol1').feature('t1').set('probefreq', 'tsteps');
model.sol('sol1').feature('t1').set('rtol', 1.0E-4);
model.sol('sol1').feature('t1').set('atolglobalvaluemethod', 'factor');
model.sol('sol1').feature('t1').set('reacf', true);
model.sol('sol1').feature('t1').set('storeudot', true);
model.sol('sol1').feature('t1').set('endtimeinterpolation', true);
model.sol('sol1').feature('t1').set('timemethod', 'genalpha');
model.sol('sol1').feature('t1').set('control', 'time');
model.sol('sol1').feature('t1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('t1').feature('fc1').set('linsolver', 'dDef');
model.sol('sol1').feature('t1').feature.remove('fcDef');
model.sol('sol1').attach('std1');
model.sol('sol1').feature('t1').set('tstepsgenalpha', 'manual');
model.sol('sol1').feature('t1').set('timestepgenalpha', 'dt');
model.sol('sol1').feature('t1').set('rhoinf', 0.2);
model.sol('sol1').runAll;

model.result.create('pg1', 'PlotGroup3D');
model.result('pg1').label('Acoustic Pressure (whtd)');
model.result('pg1').set('showlegendsunit', true);
model.result('pg1').set('data', 'dset1');
model.result('pg1').setIndex('looplevel', 241, 0);
model.result('pg1').set('defaultPlotID', 'pipeacoustics_PhysicsInterfaceComponents/icom2/pdef1/pcond2/pg1');
model.result('pg1').feature.create('line1', 'Line');
model.result('pg1').feature('line1').label('Line');
model.result('pg1').feature('line1').set('showsolutionparams', 'on');
model.result('pg1').feature('line1').set('linetype', 'tube');
model.result('pg1').feature('line1').set('radiusexpr', '0.5*whtd.dh');
model.result('pg1').feature('line1').set('tuberadiusscaleactive', true);
model.result('pg1').feature('line1').set('colortable', 'Wave');
model.result('pg1').feature('line1').set('colorscalemode', 'linearsymmetric');
model.result('pg1').feature('line1').set('smooth', 'internal');
model.result('pg1').feature('line1').set('showsolutionparams', 'on');
model.result('pg1').feature('line1').set('data', 'parent');
model.result.create('pg2', 'PlotGroup3D');
model.result('pg2').label('Acoustic Velocity (whtd)');
model.result('pg2').set('showlegendsunit', true);
model.result('pg2').set('data', 'dset1');
model.result('pg2').setIndex('looplevel', 241, 0);
model.result('pg2').set('defaultPlotID', 'pipeacoustics_PhysicsInterfaceComponents/icom2/pdef1/pcond2/pg2');
model.result('pg2').feature.create('line1', 'Line');
model.result('pg2').feature('line1').label('Line');
model.result('pg2').feature('line1').set('showsolutionparams', 'on');
model.result('pg2').feature('line1').set('expr', 'u');
model.result('pg2').feature('line1').set('linetype', 'tube');
model.result('pg2').feature('line1').set('radiusexpr', '0.5*whtd.dh');
model.result('pg2').feature('line1').set('tuberadiusscaleactive', true);
model.result('pg2').feature('line1').set('colorscalemode', 'linearsymmetric');
model.result('pg2').feature('line1').set('smooth', 'internal');
model.result('pg2').feature('line1').set('showsolutionparams', 'on');
model.result('pg2').feature('line1').set('data', 'parent');
model.result('pg1').run;
model.result.create('pg3', 'PlotGroup1D');
model.result('pg3').run;
model.result('pg3').create('ptgr1', 'PointGraph');
model.result('pg3').feature('ptgr1').set('markerpos', 'datapoints');
model.result('pg3').feature('ptgr1').set('linewidth', 'preference');
model.result('pg3').feature('ptgr1').selection.set([2]);
model.result('pg3').feature('ptgr1').set('expr', 'p-p0');
model.result('pg3').run;
model.result('pg3').run;
model.result('pg3').label('Measurement point');
model.result.create('pg4', 'PlotGroup1D');
model.result('pg4').run;
model.result('pg4').create('ptgr1', 'PointGraph');
model.result('pg4').feature('ptgr1').set('markerpos', 'datapoints');
model.result('pg4').feature('ptgr1').set('linewidth', 'preference');
model.result('pg4').feature('ptgr1').selection.set([3]);
model.result('pg4').feature('ptgr1').set('expr', 'p-p0');
model.result('pg4').feature.duplicate('ptgr2', 'ptgr1');
model.result('pg4').run;
model.result('pg4').feature('ptgr2').set('expr', 'whtd.rho*u0*sqrt(1/whtd.invc2)');
model.result('pg4').run;
model.result('pg4').run;
model.result('pg4').label('Valve');
model.result.create('pg5', 'PlotGroup1D');
model.result('pg5').run;
model.result('pg5').create('lngr1', 'LineGraph');
model.result('pg5').feature('lngr1').set('markerpos', 'datapoints');
model.result('pg5').feature('lngr1').set('linewidth', 'preference');
model.result('pg5').feature('lngr1').selection.set([1 2]);
model.result('pg5').feature('lngr1').set('expr', 'p-p0');
model.result('pg5').run;
model.result('pg5').setIndex('looplevelinput', 'last', 0);
model.result('pg5').run;
model.result('pg5').label('Pressure profile');

model.title('Water Hammer');

model.description(['When a valve is rapidly closed in a pipe network it gives rise to a hydraulic transient known as a "water hammer". The propagation of these hydraulic transients can in extreme cases cause failures of pipe systems caused by overpressures.' newline  newline 'This is a model of a simple validation of with the Water Hammer interface analyzing a pipe system consisting of a reservoir, a pipe, and a valve.']);

model.label('water_hammer_verification.mph');

model.modelNode.label('Components');

out = model;
