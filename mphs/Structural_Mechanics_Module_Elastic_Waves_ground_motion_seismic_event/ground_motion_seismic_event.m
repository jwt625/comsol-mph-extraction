function out = model
%
% ground_motion_seismic_event.m
%
% Model exported on May 26 2025, 21:33 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/Structural_Mechanics_Module/Elastic_Waves');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 2);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.physics.create('elte', 'ElasticWavesTimeExplicit', 'geom1');
model.physics('elte').model('comp1');

model.study.create('std1');
model.study('std1').create('time', 'Transient');
model.study('std1').feature('time').setSolveFor('/physics/elte', true);

% To import content from file, use:
% model.param.loadFile('FILENAME');
model.param.set('Gm', '0.2', 'Mountain height');
model.param.set('f0', '2[Hz]', 'Source center frequency');
model.param.set('t0', '0.6[s]', 'Source time shift');
model.param.set('dS', '1e3[1/m^2]', 'Source extent');
model.param.set('cp', '3.2[km/s]', 'Pressure wave speed');
model.param.set('cs', '1.8475[km/s]', 'Shear wave speed');
model.param.set('rho', '2200[kg/m^3]', 'Density');
model.param.set('K', 'rho*(cp^2 - 4*cs^2/3)', 'Bulk modulus');
model.param.set('G', 'rho*cs^2', 'Shear modulus');
model.param.set('nu', '0.5*(1 - 3*G/(3*K + G))', 'Poisson''s ratio');
model.param.set('cr', 'cs*(0.87 + 1.12*nu)/(1 + nu)', 'Rayleigh wave speed');

model.func.create('an1', 'Analytic');
model.func('an1').set('funcname', 'G_space');
model.func('an1').set('expr', '1/sqrt(pi*dS)*exp(-x^2/dS)');
model.func('an1').setIndex('argunit', 'm', 0);
model.func('an1').set('fununit', '1');
model.func.create('an2', 'Analytic');
model.func('an2').set('funcname', 'G_time');
model.func('an2').set('expr', '1e9*(2*(pi*f0*(t - t0))^2 - 1)*exp(-(pi*f0*(t - t0))^2)');
model.func('an2').set('args', 't');
model.func('an2').setIndex('argunit', 's', 0);
model.func('an2').set('fununit', 'Pa');
model.func('an2').setIndex('plotargs', 3, 0, 2);
model.func('an2').createPlot('pg1');

model.result('pg1').run;
model.result('pg1').label('Impulse Frequency Content');
model.result('pg1').set('title', 'FFT of G_time (Pa)');
model.result('pg1').set('ylabelactive', true);
model.result('pg1').set('ylabel', 'FFT of the signal (Pa)');
model.result('pg1').run;
model.result('pg1').feature('plot1').set('display', 'fourier');
model.result('pg1').feature('plot1').set('fouriershow', 'spectrum');
model.result('pg1').feature('plot1').set('scale', 'multiplyperiod');
model.result('pg1').run;
model.result('pg1').feature('plot1').set('freqrangeactive', true);
model.result('pg1').feature('plot1').set('freqmax', 10);
model.result('pg1').run;

model.geom('geom1').create('r1', 'Rectangle');
model.geom('geom1').feature('r1').set('size', {'40[km]' '20[km]'});
model.geom('geom1').feature('r1').set('pos', {'-20[km]' '-20[km]'});
model.geom('geom1').feature('r1').set('layerleft', true);
model.geom('geom1').feature('r1').set('layerright', true);
model.geom('geom1').feature('r1').setIndex('layername', 'Layer 1', 0);
model.geom('geom1').feature('r1').setIndex('layer', '2[km]', 0);
model.geom('geom1').run('r1');
model.geom('geom1').create('pc1', 'ParametricCurve');
model.geom('geom1').feature('pc1').set('parmax', '2[km]');
model.geom('geom1').feature('pc1').set('coord', {'s' '0.2*(exp(-((s - 1[km])/0.3[km])^2) - exp(-(1[km]/0.3[km])^2))[km]'});
model.geom('geom1').feature('pc1').set('pos', {'-6[km]' '0'});
model.geom('geom1').run('pc1');
model.geom('geom1').create('r2', 'Rectangle');
model.geom('geom1').feature('r2').set('size', {'2.4[km]' '0.7[km]'});
model.geom('geom1').feature('r2').set('pos', {'-6.2[km]' '0'});
model.geom('geom1').run('r2');
model.geom('geom1').create('pt1', 'Point');
model.geom('geom1').run('pt1');
model.geom('geom1').create('par1', 'Partition');
model.geom('geom1').feature('par1').selection('input').set({'r2'});
model.geom('geom1').feature('par1').selection('tool').set({'pc1'});
model.geom('geom1').run('par1');
model.geom('geom1').create('del1', 'Delete');
model.geom('geom1').feature('del1').selection('input').init(2);
model.geom('geom1').feature('del1').selection('input').set('par1', 1);
model.geom('geom1').run('del1');
model.geom('geom1').run('fin');
model.geom('geom1').create('cmd1', 'CompositeDomains');
model.geom('geom1').feature('cmd1').selection('input').set('fin', [4 5]);
model.geom('geom1').run('cmd1');

model.coordSystem.create('ab1', 'geom1', 'AbsorbingLayer');
model.coordSystem('ab1').selection.set([1 2 3 5 6]);

model.material.create('mat1', 'Common', 'comp1');
model.material('mat1').label('Ground Material');

model.physics('elte').feature('eltem1').set('IsotropicOption', 'CpCs');

model.material('mat1').propertyGroup.create('CpCs', 'Pressure_wave_and_shear_wave_speeds');
model.material('mat1').propertyGroup('CpCs').set('cp', {'3.2[km/s]'});
model.material('mat1').propertyGroup('CpCs').set('cs', {'1.8475[km/s]'});
model.material('mat1').propertyGroup('def').set('density', {'2200[kg/m^3]'});

model.physics('elte').create('bndl1', 'BoundaryLoad', 1);
model.physics('elte').feature('bndl1').selection.set([10 11]);
model.physics('elte').feature('bndl1').set('FperArea', {'0' 'G_space(x)*G_time(t)' '0'});
model.physics('elte').create('lrb1', 'LowReflectingBoundary', 1);
model.physics('elte').feature('lrb1').selection.set([1 2 3 7 13 17 18]);

model.mesh('mesh1').create('map1', 'Map');
model.mesh('mesh1').feature('size').set('custom', true);
model.mesh('mesh1').feature('size').set('hmax', 'cr/(2*f0)/1.5');
model.mesh('mesh1').run;

model.study('std1').feature('time').set('tlist', 'range(0, 1, 12)');

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
model.sol('sol1').feature('t1').set('tlist', 'range(0, 1, 12)');
model.sol('sol1').feature('t1').set('plot', 'off');
model.sol('sol1').feature('t1').set('plotgroup', 'pg1');
model.sol('sol1').feature('t1').set('plotfreq', 'tout');
model.sol('sol1').feature('t1').set('probesel', 'all');
model.sol('sol1').feature('t1').set('probes', {});
model.sol('sol1').feature('t1').set('probefreq', 'tsteps');
model.sol('sol1').feature('t1').set('exprs', {'root.comp1.elte.wtc' 'root.comp1.elte.wtc'});
model.sol('sol1').feature('t1').set('tstepping', 'elemexprs');
model.sol('sol1').feature('t1').set('control', 'time');
model.sol('sol1').feature('t1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('t1').feature('fc1').set('linsolver', 'dDef');
model.sol('sol1').feature('t1').feature.remove('fcDef');
model.sol('sol1').attach('std1');
model.sol('sol1').runAll;

model.result.create('pg2', 'PlotGroup2D');
model.result('pg2').label('Velocity Magnitude (elte)');
model.result('pg2').set('showlegendsunit', true);
model.result('pg2').set('data', 'dset1');
model.result('pg2').setIndex('looplevel', 13, 0);
model.result('pg2').set('defaultPlotID', 'ElasticWavesTimeExplicit/phys1/pdef1/pcond2/pg1');
model.result('pg2').feature.create('surf1', 'Surface');
model.result('pg2').feature('surf1').set('resolution', 'custom');
model.result('pg2').feature('surf1').set('refine', 6);
model.result('pg2').feature('surf1').set('smooth', 'internal');
model.result('pg2').feature('surf1').set('data', 'parent');
model.result.create('pg3', 'PlotGroup2D');
model.result('pg3').label('Pressure (elte)');
model.result('pg3').set('showlegendsunit', true);
model.result('pg3').set('data', 'dset1');
model.result('pg3').setIndex('looplevel', 13, 0);
model.result('pg3').set('defaultPlotID', 'ElasticWavesTimeExplicit/phys1/pdef1/pcond2/pg2');
model.result('pg3').feature.create('surf1', 'Surface');
model.result('pg3').feature('surf1').set('expr', 'elte.p');
model.result('pg3').feature('surf1').set('colortable', 'Wave');
model.result('pg3').feature('surf1').set('colorscalemode', 'linearsymmetric');
model.result('pg3').feature('surf1').set('resolution', 'custom');
model.result('pg3').feature('surf1').set('refine', 6);
model.result('pg3').feature('surf1').set('smooth', 'internal');
model.result('pg3').feature('surf1').set('data', 'parent');
model.result('pg2').run;
model.result.dataset('dset1').selection.geom('geom1', 2);
model.result.dataset('dset1').selection.geom('geom1', 2);
model.result.dataset('dset1').selection.set([4]);
model.result('pg2').run;
model.result('pg2').setIndex('looplevel', 4, 0);
model.result('pg2').run;
model.result('pg2').feature('surf1').set('colortable', 'AuroraAustralis');
model.result('pg2').feature('surf1').set('rangecoloractive', true);
model.result('pg2').feature('surf1').set('rangecolormax', 0.5);
model.result('pg2').run;
model.result('pg2').run;
model.result('pg2').setIndex('looplevel', 7, 0);
model.result('pg2').run;
model.result('pg2').setIndex('looplevel', 10, 0);
model.result('pg2').run;
model.result('pg2').setIndex('looplevel', 13, 0);
model.result('pg2').run;
model.result('pg2').setIndex('looplevel', 7, 0);
model.result('pg3').run;
model.result('pg3').setIndex('looplevel', 7, 0);
model.result('pg3').run;
model.result('pg3').feature('surf1').set('unit', 'MPa');
model.result('pg3').run;
model.result.create('pg4', 'PlotGroup2D');
model.result('pg4').run;
model.result('pg4').label('Pressure and Shear Waves');
model.result('pg4').setIndex('looplevel', 4, 0);
model.result('pg4').set('titletype', 'label');
model.result('pg4').set('showlegendsunit', true);
model.result('pg4').create('surf1', 'Surface');
model.result('pg4').feature('surf1').set('expr', 'sqrt(abs(elte.I2s))*sign(elte.I2s)');
model.result('pg4').feature('surf1').set('unit', 'MPa');
model.result('pg4').feature('surf1').set('descractive', true);
model.result('pg4').feature('surf1').set('descr', 'Signed square root of the second principal invariant');
model.result('pg4').feature('surf1').set('rangecoloractive', true);
model.result('pg4').feature('surf1').set('rangecolormin', -0.24);
model.result('pg4').feature('surf1').set('rangecolormax', 0.3);
model.result('pg4').feature('surf1').set('colortable', 'Twilight');
model.result('pg4').run;
model.result('pg4').set('showlegends', false);
model.result('pg4').run;
model.result('pg4').setIndex('looplevel', 7, 0);
model.result('pg4').run;
model.result('pg4').setIndex('looplevel', 10, 0);
model.result('pg4').run;
model.result('pg4').setIndex('looplevel', 13, 0);
model.result('pg4').run;
model.result('pg4').setIndex('looplevel', 7, 0);
model.result('pg4').run;
model.result('pg4').set('showlegends', true);

model.title('Ground Motion After Seismic Event: Scattering off a Small Mountain');

model.description(['In this tutorial, the propagation of elastic waves in the ground after a seismic event is simulated using a 2D model. The effect of the ground surface topology on the wave propagation is illustrated when an ideal half space is modified with the presence of a small mountain. The model is a variation of Lamb''s problem. The propagation of the elastic waves is modeled using the Elastic Waves, Time Explicit physics interface and the model captures the propagation and scattering of pressure waves, shear waves, Rayleigh waves, and von' native2unicode(hex2dec({'00' 'a0'}), 'unicode') 'Schmidt waves.']);

model.mesh.clearMeshes;

model.sol('sol1').clearSolutionData;

model.label('ground_motion_seismic_event.mph');

model.modelNode.label('Components');

out = model;
