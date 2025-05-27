function out = model
%
% gaussian_pulse_perfectly_matched_layers.m
%
% Model exported on May 26 2025, 21:25 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/Acoustics_Module/Tutorials,_Pressure_Acoustics');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 2);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.physics.create('actd', 'TransientPressureAcoustics', 'geom1');
model.physics('actd').model('comp1');

model.study.create('std1');
model.study('std1').create('time', 'Transient');
model.study('std1').feature('time').setSolveFor('/physics/actd', true);

model.baseSystem('none');

% To import content from file, use:
% model.param.loadFile('FILENAME');
model.param.set('W', '70', 'Domain width');
model.param.set('dW', '9', 'Perfectly matched layer width');
model.param.set('c0', '1', 'Speed of sound');
model.param.set('rho0', '1', 'Background density');
model.param.set('p0', '1[atm]/(c0^2*rho0)', 'Background pressure');
model.param.set('alpha', 'log(2)/9', 'Gaussian pulse width');
model.param.set('beta', '0.04', 'Gaussian pulse velocity factor');

model.variable.create('var1');
model.variable('var1').model('comp1');

model.geom('geom1').run;

% To import content from file, use:
% model.variable('var1').loadFile('FILENAME');
model.variable('var1').set('G', 'exp(-alpha*(x^2+y^2))', 'Gaussian');
model.variable('var1').set('p_i', 'rho0*c0^2*G', 'Pressure initial condition');
model.variable('var1').set('u_i', 'c0*beta*x*G', 'x-velocity initial condition');
model.variable('var1').set('v_i', 'c0*beta*y*G', 'y-velocity initial condition');
model.variable('var1').set('dp_i', '-c0^2*rho0*(d(u_i, x) + d(v_i, y))', 'Time derivative of pressure initial condition');
model.variable('var1').set('r', 'sqrt(x^2+y^2)', 'Distance variables');
model.variable('var1').set('p_a', '1/(2*alpha)*integrate((cos(L*t)-beta/(2*alpha)*L*sin(L*t))*L*besselj(0,L*r)*exp(-L^2/(4*alpha)),L,0,10,1e-3)', 'Analytical pressure expression');

model.geom('geom1').create('sq1', 'Square');
model.geom('geom1').feature('sq1').set('base', 'center');
model.geom('geom1').feature('sq1').set('size', 'W');
model.geom('geom1').feature('sq1').set('layerleft', true);
model.geom('geom1').feature('sq1').set('layerright', true);
model.geom('geom1').feature('sq1').set('layertop', true);
model.geom('geom1').feature('sq1').setIndex('layername', 'Layer 1', 0);
model.geom('geom1').feature('sq1').setIndex('layer', 'dW', 0);
model.geom('geom1').run('fin');

model.coordSystem.create('pml1', 'geom1', 'PML');
model.coordSystem('pml1').selection.set([1 2 3 4 6 7 8 9]);
model.coordSystem('pml1').set('PMLgamma', '3');

model.physics('actd').prop('TransientSettings').set('fmax', 0.3);
model.physics('actd').feature('tpam1').set('c_mat', 'userdef');
model.physics('actd').feature('tpam1').set('c', 'c0');
model.physics('actd').feature('tpam1').set('rho_mat', 'userdef');
model.physics('actd').feature('tpam1').set('rho', 'rho0');
model.physics('actd').feature('init1').set('p', 'p_i');
model.physics('actd').feature('init1').set('dp/dt', 'dp_i');

model.mesh('mesh1').create('ftri1', 'FreeTri');
model.mesh('mesh1').feature('ftri1').selection.geom('geom1', 2);
model.mesh('mesh1').feature('ftri1').selection.set([5]);
model.mesh('mesh1').feature('ftri1').create('size1', 'Size');
model.mesh('mesh1').feature('ftri1').feature('size1').set('custom', true);
model.mesh('mesh1').feature('ftri1').feature('size1').set('hmaxactive', true);
model.mesh('mesh1').feature('ftri1').feature('size1').set('hmax', 1.5);
model.mesh('mesh1').create('map1', 'Map');
model.mesh('mesh1').feature('map1').create('size1', 'Size');
model.mesh('mesh1').feature('map1').feature('size1').set('custom', true);
model.mesh('mesh1').feature('map1').feature('size1').set('hmaxactive', true);
model.mesh('mesh1').feature('map1').feature('size1').set('hmax', 1.5);

model.study('std1').feature('time').set('tlist', 'range(0,1,120)');

model.sol.create('sol1');
model.sol('sol1').study('std1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'time');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').set('control', 'time');
model.sol('sol1').create('t1', 'Time');
model.sol('sol1').feature('t1').set('tlist', 'range(0,1,120)');
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
model.sol('sol1').feature('t1').set('tstepsgenalpha', 'manual');
model.sol('sol1').feature('t1').set('timestepgenalpha', '1/(60*0.3)');
model.sol('sol1').feature('t1').set('timestepbdf', '1/(60*0.3)');
model.sol('sol1').feature('t1').set('endtimeinterpolation', true);
model.sol('sol1').feature('t1').set('timemethod', 'genalpha');
model.sol('sol1').feature('t1').set('maxorder', 2);
model.sol('sol1').feature('t1').set('initialstepbdfactive', true);
model.sol('sol1').feature('t1').set('initialstepbdf', '(1/30)[s]');
model.sol('sol1').feature('t1').set('maxstepconstraintbdf', 'const');
model.sol('sol1').feature('t1').set('maxstepbdf', '1/9');
model.sol('sol1').feature('t1').set('initialstepgenalphaactive', true);
model.sol('sol1').feature('t1').set('initialstepgenalpha', '(1/30)[s]');
model.sol('sol1').feature('t1').set('maxstepconstraintgenalpha', 'const');
model.sol('sol1').feature('t1').set('maxstepgenalpha', '1/9');
model.sol('sol1').feature('t1').set('control', 'time');
model.sol('sol1').feature('t1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('t1').feature('fc1').set('linsolver', 'dDef');
model.sol('sol1').feature('t1').feature.remove('fcDef');
model.sol('sol1').attach('std1');
model.sol('sol1').runAll;

model.result.create('pg1', 'PlotGroup2D');
model.result('pg1').set('data', 'dset1');
model.result('pg1').setIndex('looplevel', 121, 0);
model.result('pg1').create('surf1', 'Surface');
model.result('pg1').feature('surf1').set('expr', {'actd.p_t'});
model.result('pg1').feature('surf1').set('colortable', 'Wave');
model.result('pg1').feature('surf1').set('colorscalemode', 'linearsymmetric');
model.result('pg1').set('showlegendsunit', true);
model.result('pg1').label('Acoustic Pressure (actd)');
model.result('pg1').run;
model.result('pg1').setIndex('looplevel', 1, 0);
model.result('pg1').run;
model.result('pg1').setIndex('looplevel', 11, 0);
model.result('pg1').run;
model.result('pg1').setIndex('looplevel', 31, 0);
model.result('pg1').run;
model.result('pg1').setIndex('looplevel', 51, 0);
model.result('pg1').run;
model.result('pg1').setIndex('looplevel', 121, 0);
model.result('pg1').run;
model.result.dataset.create('cpt1', 'CutPoint2D');
model.result.dataset('cpt1').set('pointx', 20);
model.result.dataset('cpt1').set('pointy', 10);
model.result.create('pg2', 'PlotGroup1D');
model.result('pg2').run;
model.result('pg2').label('Pressure at Point');
model.result('pg2').set('data', 'cpt1');
model.result('pg2').create('ptgr1', 'PointGraph');
model.result('pg2').feature('ptgr1').set('markerpos', 'datapoints');
model.result('pg2').feature('ptgr1').set('linewidth', 'preference');
model.result('pg2').feature('ptgr1').set('expr', 'p');
model.result('pg2').feature('ptgr1').set('legend', true);
model.result('pg2').feature('ptgr1').set('legendmethod', 'manual');
model.result('pg2').feature('ptgr1').setIndex('legends', 'COMSOL Model', 0);
model.result('pg2').run;
model.result('pg2').create('ptgr2', 'PointGraph');
model.result('pg2').feature('ptgr2').set('markerpos', 'datapoints');
model.result('pg2').feature('ptgr2').set('linewidth', 'preference');
model.result('pg2').feature('ptgr2').set('expr', 'p_a');
model.result('pg2').feature('ptgr2').set('legend', true);
model.result('pg2').feature('ptgr2').set('legendmethod', 'manual');
model.result('pg2').feature('ptgr2').setIndex('legends', 'Analytical', 0);
model.result('pg2').feature('ptgr2').set('linestyle', 'none');
model.result('pg2').feature('ptgr2').set('linemarker', 'point');
model.result('pg2').feature('ptgr2').set('markerpos', 'interp');
model.result('pg2').feature('ptgr2').set('markers', 100);
model.result('pg2').run;
model.result.dataset.create('cln1', 'CutLine2D');
model.result.dataset('cln1').setIndex('genpoints', '-W/2', 0, 0);
model.result.dataset('cln1').setIndex('genpoints', 'W/2', 1, 0);
model.result.dataset.create('cln2', 'CutLine2D');
model.result.dataset('cln2').setIndex('genpoints', '-W/2+dW', 0, 0);
model.result.dataset('cln2').setIndex('genpoints', 'W/2-dW', 1, 0);
model.result.create('pg3', 'PlotGroup1D');
model.result('pg3').run;
model.result('pg3').label('Pressure along Cut Line');
model.result('pg3').set('data', 'none');
model.result('pg3').create('lngr1', 'LineGraph');
model.result('pg3').feature('lngr1').set('markerpos', 'datapoints');
model.result('pg3').feature('lngr1').set('linewidth', 'preference');
model.result('pg3').feature('lngr1').set('data', 'cln1');
model.result('pg3').feature('lngr1').setIndex('looplevelinput', 'manual', 0);
model.result('pg3').feature('lngr1').setIndex('looplevel', [41], 0);
model.result('pg3').feature('lngr1').set('expr', 'p');
model.result('pg3').feature('lngr1').set('xdata', 'expr');
model.result('pg3').feature('lngr1').set('xdataexpr', 'x');
model.result('pg3').feature('lngr1').set('legend', true);
model.result('pg3').feature('lngr1').set('legendmethod', 'manual');
model.result('pg3').feature('lngr1').setIndex('legends', 'COMSOL Model', 0);
model.result('pg3').run;
model.result('pg3').create('lngr2', 'LineGraph');
model.result('pg3').feature('lngr2').set('markerpos', 'datapoints');
model.result('pg3').feature('lngr2').set('linewidth', 'preference');
model.result('pg3').feature('lngr2').set('data', 'cln2');
model.result('pg3').feature('lngr2').setIndex('looplevelinput', 'manual', 0);
model.result('pg3').feature('lngr2').setIndex('looplevel', [41], 0);
model.result('pg3').feature('lngr2').set('expr', 'p_a');
model.result('pg3').feature('lngr2').set('xdata', 'expr');
model.result('pg3').feature('lngr2').set('xdataexpr', 'x');
model.result('pg3').feature('lngr2').set('legend', true);
model.result('pg3').feature('lngr2').set('legendmethod', 'manual');
model.result('pg3').feature('lngr2').setIndex('legends', 'Analytical', 0);
model.result('pg3').feature('lngr2').set('linestyle', 'none');
model.result('pg3').feature('lngr2').set('linemarker', 'point');
model.result('pg3').feature('lngr2').set('markerpos', 'interp');
model.result('pg3').feature('lngr2').set('markers', 100);
model.result('pg3').run;
model.result.create('pg4', 'PlotGroup1D');
model.result('pg4').run;
model.result('pg4').label('Pressure at Point, FFT');
model.result('pg4').set('data', 'cpt1');
model.result('pg4').create('ptgr1', 'PointGraph');
model.result('pg4').feature('ptgr1').set('markerpos', 'datapoints');
model.result('pg4').feature('ptgr1').set('linewidth', 'preference');
model.result('pg4').feature('ptgr1').set('xdata', 'fourier');
model.result('pg4').feature('ptgr1').set('fouriershow', 'spectrum');
model.result('pg4').run;

model.title('Gaussian Pulse Absorption by Perfectly Matched Layers: Pressure Acoustics, Transient');

model.description(['This tutorial simulates a standard test and benchmark model for perfectly matched layers (PMLs) as absorbing boundary conditions in the time domain. It involves the propagation of a transient Gaussian pulse with no flow. The Pressure Acoustics, Transient interface is used together with PMLs to reduce the computational domain and suppress the reflections from the artificial boundaries.' newline  newline 'An acoustic pulse is generated by an initial Gaussian distribution at the center of the computational domain. The analytical solution to the problem is used to validate the solution, showing very good agreement.']);

model.mesh.clearMeshes;

model.sol('sol1').clearSolutionData;

model.label('gaussian_pulse_perfectly_matched_layers.mph');

model.modelNode.label('Components');

out = model;
