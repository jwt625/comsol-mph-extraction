function out = model
%
% gaussian_pulse_absorbing_layers.m
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

model.physics.create('cwe', 'ConvectedWaveEquation', 'geom1');
model.physics('cwe').model('comp1');

model.study.create('std1');
model.study('std1').create('time', 'Transient');
model.study('std1').feature('time').setSolveFor('/physics/cwe', true);

% To import content from file, use:
% model.param.loadFile('FILENAME');
model.param.set('W', '100', 'Domain width');
model.param.set('dW', '20', 'Absorbing layer width');
model.param.set('c0', '1', 'Speed of sound');
model.param.set('rho0', '1', 'Background density');
model.param.set('p0', '1[atm]/(c0^2*rho0)', 'Background pressure');
model.param.set('alpha', 'log(2)/9', 'Gaussian pulse width');
model.param.set('beta', '0.04', 'Gaussian pulse velocity factor');
model.param.set('Ma', '0.5', 'Mach number');

model.geom('geom1').create('sq1', 'Square');
model.geom('geom1').feature('sq1').set('size', 'W');
model.geom('geom1').feature('sq1').set('base', 'center');
model.geom('geom1').feature('sq1').set('layerleft', true);
model.geom('geom1').feature('sq1').set('layerright', true);
model.geom('geom1').feature('sq1').set('layertop', true);
model.geom('geom1').feature('sq1').setIndex('layername', 'Layer 1', 0);
model.geom('geom1').feature('sq1').setIndex('layer', 'dW', 0);
model.geom('geom1').runPre('fin');

model.variable.create('var1');
model.variable('var1').model('comp1');

model.geom('geom1').run;

% To import content from file, use:
% model.variable('var1').loadFile('FILENAME');
model.variable('var1').set('G', 'exp(-alpha*(x^2+y^2))', 'Gaussian');
model.variable('var1').set('u_i', 'c0*beta*x*G', 'x-velocity initial condition');
model.variable('var1').set('v_i', 'c0*beta*y*G', 'y-velocity initial condition');
model.variable('var1').set('p_i', 'rho0*c0^2*G', 'Pressure initial condition');
model.variable('var1').set('r', 'sqrt((x-Ma*t)^2+y^2)', 'Distance variables (moving frame)');
model.variable('var1').set('p_a', '1/(2*alpha)*integrate((cos(L*t)-beta/(2*alpha)*L*sin(L*t))*L*besselj(0,L*r)*exp(-L^2/(4*alpha)),L,0,10,1e-3)', 'Analytical pressure expression');

model.coordSystem.create('ab1', 'geom1', 'AbsorbingLayer');
model.coordSystem('ab1').selection.set([1 2 3 4 6 7 8 9]);

model.baseSystem('none');

model.physics('cwe').feature('cwem1').set('minput_pressure', 'p0');
model.physics('cwe').feature('cwem1').set('minput_velocity', {'Ma*c0' '0' '0'});
model.physics('cwe').feature('cwem1').set('rho0_mat', 'userdef');
model.physics('cwe').feature('cwem1').set('rho0', 'rho0');
model.physics('cwe').feature('cwem1').set('c0_mat', 'userdef');
model.physics('cwe').feature('cwem1').set('c0', 'c0');
model.physics('cwe').feature('init1').set('p', 'p_i');
model.physics('cwe').feature('init1').set('u', {'u_i' 'v_i' '0'});
model.physics('cwe').create('imp1', 'AcousticImpedance', 1);
model.physics('cwe').feature('imp1').selection.all;

model.mesh('mesh1').autoMeshSize(3);

model.study('std1').feature('time').set('tlist', 'range(0,1,120)');

model.sol.create('sol1');
model.sol('sol1').study('std1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'time');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').set('control', 'time');
model.sol('sol1').create('t1', 'Time');
model.sol('sol1').feature('t1').set('odesolvertype', 'explicit');
model.sol('sol1').feature('t1').set('timemethodexp', 'erk');
model.sol('sol1').feature('t1').set('tlist', 'range(0,1,120)');
model.sol('sol1').feature('t1').set('plot', 'off');
model.sol('sol1').feature('t1').set('plotgroup', 'Default');
model.sol('sol1').feature('t1').set('plotfreq', 'tout');
model.sol('sol1').feature('t1').set('probesel', 'all');
model.sol('sol1').feature('t1').set('probes', {});
model.sol('sol1').feature('t1').set('probefreq', 'tsteps');
model.sol('sol1').feature('t1').set('exprs', {'root.comp1.cwe.wtc' 'root.comp1.cwe.wtc'});
model.sol('sol1').feature('t1').set('tstepping', 'elemexprs');
model.sol('sol1').feature('t1').set('control', 'time');
model.sol('sol1').feature('t1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('t1').feature('fc1').set('linsolver', 'dDef');
model.sol('sol1').feature('t1').feature.remove('fcDef');
model.sol('sol1').attach('std1');
model.sol('sol1').runAll;

model.result.create('pg1', 'PlotGroup2D');
model.result('pg1').label('Acoustic Pressure (cwe)');
model.result('pg1').set('showlegendsunit', true);
model.result('pg1').set('data', 'dset1');
model.result('pg1').setIndex('looplevel', 121, 0);
model.result('pg1').set('defaultPlotID', 'ConvectedWaveEquation/phys1/pdef1/pcond2/pg1');
model.result('pg1').feature.create('surf1', 'Surface');
model.result('pg1').feature('surf1').set('colortable', 'Wave');
model.result('pg1').feature('surf1').set('colorscalemode', 'linearsymmetric');
model.result('pg1').feature('surf1').set('resolution', 'custom');
model.result('pg1').feature('surf1').set('refine', 6);
model.result('pg1').feature('surf1').set('smooth', 'internal');
model.result('pg1').feature('surf1').set('data', 'parent');
model.result.create('pg2', 'PlotGroup2D');
model.result('pg2').label('Acoustic Velocity (cwe)');
model.result('pg2').set('showlegendsunit', true);
model.result('pg2').set('data', 'dset1');
model.result('pg2').setIndex('looplevel', 121, 0);
model.result('pg2').set('defaultPlotID', 'ConvectedWaveEquation/phys1/pdef1/pcond2/pg2');
model.result('pg2').feature.create('surf1', 'Surface');
model.result('pg2').feature('surf1').set('expr', 'cwe.v_inst');
model.result('pg2').feature('surf1').set('unit', 'm/s');
model.result('pg2').feature('surf1').set('resolution', 'custom');
model.result('pg2').feature('surf1').set('refine', 6);
model.result('pg2').feature('surf1').set('smooth', 'internal');
model.result('pg2').feature('surf1').set('data', 'parent');
model.result('pg2').feature.create('arws1', 'ArrowSurface');
model.result('pg2').feature('arws1').set('color', 'white');
model.result('pg2').feature('arws1').set('data', 'parent');
model.result.create('pg3', 'PlotGroup2D');
model.result('pg3').label('Background Mean Flow (cwe)');
model.result('pg3').set('showlegendsunit', true);
model.result('pg3').set('data', 'dset1');
model.result('pg3').setIndex('looplevel', 121, 0);
model.result('pg3').set('defaultPlotID', 'ConvectedWaveEquation/phys1/pdef1/pcond2/pg3');
model.result('pg3').feature.create('surf1', 'Surface');
model.result('pg3').feature('surf1').set('expr', 'cwe.p0');
model.result('pg3').feature('surf1').set('resolution', 'custom');
model.result('pg3').feature('surf1').set('refine', 6);
model.result('pg3').feature('surf1').set('smooth', 'internal');
model.result('pg3').feature('surf1').set('data', 'parent');
model.result('pg3').feature.create('arws1', 'ArrowSurface');
model.result('pg3').feature('arws1').set('expr', {'cwe.u0x' 'cwe.u0y'});
model.result('pg3').feature('arws1').set('xnumber', 7);
model.result('pg3').feature('arws1').set('ynumber', 7);
model.result('pg3').feature('arws1').set('data', 'parent');
model.result('pg1').run;
model.result('pg1').setIndex('looplevel', 1, 0);
model.result('pg1').run;
model.result('pg1').setIndex('looplevel', 11, 0);
model.result('pg1').run;
model.result('pg1').setIndex('looplevel', 21, 0);
model.result('pg1').run;
model.result('pg1').setIndex('looplevel', 41, 0);
model.result('pg1').run;
model.result('pg1').setIndex('looplevel', 121, 0);
model.result('pg1').run;
model.result('pg2').run;
model.result('pg2').setIndex('looplevel', 1, 0);
model.result('pg2').run;
model.result('pg2').setIndex('looplevel', 11, 0);
model.result('pg2').run;
model.result('pg2').setIndex('looplevel', 21, 0);
model.result('pg2').run;
model.result('pg2').setIndex('looplevel', 31, 0);
model.result('pg2').run;
model.result('pg2').setIndex('looplevel', 121, 0);
model.result('pg2').run;
model.result.dataset.create('cpt1', 'CutPoint2D');
model.result.dataset('cpt1').set('pointx', 20);
model.result.dataset('cpt1').set('pointy', 10);
model.result.dataset.create('cln1', 'CutLine2D');
model.result.dataset('cln1').setIndex('genpoints', -50, 0, 0);
model.result.dataset('cln1').setIndex('genpoints', 50, 1, 0);
model.result.dataset.create('cln2', 'CutLine2D');
model.result.dataset('cln2').setIndex('genpoints', -30, 0, 0);
model.result.dataset('cln2').setIndex('genpoints', 30, 1, 0);
model.result.create('pg4', 'PlotGroup1D');
model.result('pg4').run;
model.result('pg4').label('Pressure in Point');
model.result('pg4').set('data', 'cpt1');
model.result('pg4').create('ptgr1', 'PointGraph');
model.result('pg4').feature('ptgr1').set('markerpos', 'datapoints');
model.result('pg4').feature('ptgr1').set('linewidth', 'preference');
model.result('pg4').feature('ptgr1').set('legend', true);
model.result('pg4').feature('ptgr1').set('legendmethod', 'manual');
model.result('pg4').feature('ptgr1').setIndex('legends', 'COMSOL Model', 0);
model.result('pg4').run;
model.result('pg4').create('ptgr2', 'PointGraph');
model.result('pg4').feature('ptgr2').set('markerpos', 'datapoints');
model.result('pg4').feature('ptgr2').set('linewidth', 'preference');
model.result('pg4').feature('ptgr2').set('expr', 'p_a');
model.result('pg4').feature('ptgr2').set('legend', true);
model.result('pg4').feature('ptgr2').set('legendmethod', 'manual');
model.result('pg4').feature('ptgr2').setIndex('legends', 'Analytical', 0);
model.result('pg4').feature('ptgr2').set('linestyle', 'none');
model.result('pg4').feature('ptgr2').set('linemarker', 'point');
model.result('pg4').feature('ptgr2').set('markerpos', 'interp');
model.result('pg4').feature('ptgr2').set('markers', 100);
model.result('pg4').run;
model.result.create('pg5', 'PlotGroup1D');
model.result('pg5').run;
model.result('pg5').label('Pressure over Cut Line');
model.result('pg5').set('data', 'none');
model.result('pg5').create('lngr1', 'LineGraph');
model.result('pg5').feature('lngr1').set('markerpos', 'datapoints');
model.result('pg5').feature('lngr1').set('linewidth', 'preference');
model.result('pg5').feature('lngr1').set('data', 'cln1');
model.result('pg5').feature('lngr1').setIndex('looplevelinput', 'manual', 0);
model.result('pg5').feature('lngr1').setIndex('looplevel', [41], 0);
model.result('pg5').feature('lngr1').set('expr', 'p');
model.result('pg5').feature('lngr1').set('xdata', 'expr');
model.result('pg5').feature('lngr1').set('xdataexpr', 'x');
model.result('pg5').feature('lngr1').set('legend', true);
model.result('pg5').feature('lngr1').set('legendmethod', 'manual');
model.result('pg5').feature('lngr1').setIndex('legends', 'COMSOL Model', 0);
model.result('pg5').feature('lngr1').set('resolution', 'extrafine');
model.result('pg5').run;
model.result('pg5').run;
model.result('pg5').create('lngr2', 'LineGraph');
model.result('pg5').feature('lngr2').set('markerpos', 'datapoints');
model.result('pg5').feature('lngr2').set('linewidth', 'preference');
model.result('pg5').feature('lngr2').set('data', 'cln2');
model.result('pg5').feature('lngr2').setIndex('looplevelinput', 'manual', 0);
model.result('pg5').feature('lngr2').setIndex('looplevel', [41], 0);
model.result('pg5').feature('lngr2').set('expr', 'p_a');
model.result('pg5').feature('lngr2').set('xdata', 'expr');
model.result('pg5').feature('lngr2').set('xdataexpr', 'x');
model.result('pg5').feature('lngr2').set('linestyle', 'none');
model.result('pg5').feature('lngr2').set('linemarker', 'point');
model.result('pg5').feature('lngr2').set('markerpos', 'interp');
model.result('pg5').feature('lngr2').set('markers', 100);
model.result('pg5').feature('lngr2').set('legend', true);
model.result('pg5').feature('lngr2').set('legendmethod', 'manual');
model.result('pg5').feature('lngr2').setIndex('legends', 'Analytical', 0);
model.result('pg5').feature('lngr2').set('resolution', 'extrafine');
model.result('pg5').run;
model.result('pg1').run;
model.result.duplicate('pg6', 'pg1');
model.result('pg6').run;
model.result('pg6').label('Acoustic Pressure (cwe) Selection');
model.result('pg6').run;
model.result('pg6').feature('surf1').create('sel1', 'Selection');
model.result('pg6').feature('surf1').feature('sel1').selection.set([5]);
model.result('pg6').run;

model.title('Gaussian Pulse in 2D Uniform Flow: Convected Wave Equation and Absorbing Layers');

model.description(['This small tutorial simulates a standard test and benchmark model for nonreflecting conditions and sponge layers for linearized Euler-like systems. It involves the propagation of a transient Gaussian pulse in a 2D uniform flow. The Convected Wave Equation, Time Explicit interface solves the linearized Euler equations with an adiabatic equation of state and the interface uses the Absorbing Layers feature to model infinite domains.' newline  newline 'An acoustic pulse is generated by an initial Gaussian distribution at the center of the computational domain. The pulse propagates in a high Mach number uniform flow. The analytical solution to the problem is used to validate the solution and it shows very good agreement.' newline  newline 'The model also illustrates how to set up and use the absorbing layers. By using absorbing layers, you can reduce spuriously reflected waves to 1/1000 of the incident field amplitude.']);

model.mesh.clearMeshes;

model.sol('sol1').clearSolutionData;

model.label('gaussian_pulse_absorbing_layers.mph');

model.modelNode.label('Components');

out = model;
