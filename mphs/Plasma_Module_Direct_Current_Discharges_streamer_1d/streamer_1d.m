function out = model
%
% streamer_1d.m
%
% Model exported on May 26 2025, 21:31 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/Plasma_Module/Direct_Current_Discharges');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 1);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.physics.create('plas', 'ColdPlasma', 'geom1');
model.physics('plas').model('comp1');

model.study.create('std1');
model.study('std1').create('time', 'Transient');
model.study('std1').feature('time').setSolveFor('/physics/plas', true);

model.geom('geom1').lengthUnit('mm');
model.geom('geom1').create('i1', 'Interval');
model.geom('geom1').feature('i1').setIndex('coord', 1.15, 1);
model.geom('geom1').run('i1');
model.geom('geom1').create('i2', 'Interval');
model.geom('geom1').feature('i2').setIndex('coord', 1.15, 0);
model.geom('geom1').feature('i2').setIndex('coord', 1.151, 1);
model.geom('geom1').runPre('fin');

model.variable.create('var1');
model.variable('var1').model('comp1');

model.geom('geom1').run;

model.variable('var1').set('ne0', 'ne0max*exp(-((x-x0)/sigma)^2)+ne0min');
model.variable('var1').set('ne0min', '1e-15[m^-3]');
model.variable('var1').set('ne0max', '5e16[m^-3]');
model.variable('var1').set('x0', '0.02e-3[m]');
model.variable('var1').set('sigma', '0.01e-4[m]');

model.param.set('Efield', '-100[kV/cm]');

model.physics('plas').prop('Stabilization').set('SourceStabilization', false);
model.physics('plas').prop('Stabilization').set('ReactionSourceStabilization', false);
model.physics('plas').prop('ElectronProperties').set('ReducedProps', true);
model.physics('plas').prop('ElectronProperties').set('MeanElectronEnergyModel', 'LocalFieldApproximationE');
model.physics('plas').create('eir1', 'ElectronImpactReaction', 1);
model.physics('plas').feature('eir1').set('formula', 'e+N=>2e+N+');
model.physics('plas').feature('eir1').set('type', 'Ionization');
model.physics('plas').feature('eir1').set('de', 15.6);
model.physics('plas').feature('eir1').set('SpecifyReactionUsing', 'UseLookupTable');
model.physics('plas').feature('eir1').set('RateConstantForm', 'UseTownsend');
model.physics('plas').feature('eir1').set('xtownratedata', [0 0.013061613 0.093540084 0.228107915 0.3849651 0.548393454 0.711943481 0.873094428 1.030952274 1.185305533 1.33622818 1.483907137 1.62856571 1.770429612 1.909712486 2.046610487 2.181301066 2.313943661 2.444681161 2.57364161 3.786025481 4.898764283 5.944640553 6.941089171 7.898753833 8.824740665 9.724098546 10.6005823 11.45708358 12.29589151 13.1188591 13.92751417 14.72313607 15.50681025 16.27946821 17.04191719]);
model.physics('plas').feature('eir1').set('ytownratedata', {'0' '8.90E-30' '2.24E-32' '1.54E-31' '2.36E-30' '2.81E-29' '2.28E-28' '1.31E-27' '5.69E-27' '1.97E-26'  ...
'5.68E-26' '1.42E-25' '3.14E-25' '6.30E-25' '1.17E-24' '2.02E-24' '3.31E-24' '5.16E-24' '7.71E-24' '1.11E-23'  ...
'1.23E-22' '4.33E-22' '9.47E-22' '1.61E-21' '2.38E-21' '3.20E-21' '4.03E-21' '4.87E-21' '5.70E-21' '6.50E-21'  ...
'7.28E-21' '8.02E-21' '8.74E-21' '9.43E-21' '1.01E-20' '1.07E-20'});
model.physics('plas').feature('N').set('FromMassConstraint', true);
model.physics('plas').feature('N').set('PresetSpeciesData', 'N2');
model.physics('plas').feature('N_1p').set('InitIon', true);
model.physics('plas').feature('N_1p').set('PresetSpeciesData', 'N2');
model.physics('plas').create('sr1', 'SurfaceReaction', 0);
model.physics('plas').feature('sr1').set('formula', 'N+=>N');
model.physics('plas').feature('sr1').selection.all;
model.physics('plas').feature('sr1').selection.set([1 2]);
model.physics('plas').feature('pes1').set('SpecifyElectronDensityAndEnergy', 'UseLookupTables');
model.physics('plas').feature('pes1').set('muNXdata', [0 0.013061613 0.093540084 0.228107915 0.3849651 0.548393454 0.711943481 0.873094428 1.030952274 1.185305533 1.33622818 1.483907137 1.62856571 1.770429612 1.909712486 2.046610487 2.181301066 2.313943661 2.444681161 2.57364161 3.786025481 4.898764283 5.944640553 6.941089171 7.898753833 8.824740665 9.724098546 10.6005823 11.45708358 12.29589151 13.1188591 13.92751417 14.72313607 15.50681025 16.27946821 17.04191719]);
model.physics('plas').feature('pes1').set('muNYdata', {'0' '1.86E+24' '1.65E+24' '1.46E+24' '1.34E+24' '1.26E+24' '1.21E+24' '1.17E+24' '1.14E+24' '1.12E+24'  ...
'1.11E+24' '1.10E+24' '1.09E+24' '1.08E+24' '1.08E+24' '1.08E+24' '1.07E+24' '1.07E+24' '1.07E+24' '1.07E+24'  ...
'1.09E+24' '1.12E+24' '1.15E+24' '1.18E+24' '1.21E+24' '1.23E+24' '1.25E+24' '1.28E+24' '1.30E+24' '1.32E+24'  ...
'1.34E+24' '1.35E+24' '1.37E+24' '1.39E+24' '1.40E+24' '1.42E+24'});
model.physics('plas').feature('pes1').set('deNXdata', [0 0.013061613 0.093540084 0.228107915 0.3849651 0.548393454 0.711943481 0.873094428 1.030952274 1.185305533 1.33622818 1.483907137 1.62856571 1.770429612 1.909712486 2.046610487 2.181301066 2.313943661 2.444681161 2.57364161 3.786025481 4.898764283 5.944640553 6.941089171 7.898753833 8.824740665 9.724098546 10.6005823 11.45708358 12.29589151 13.1188591 13.92751417 14.72313607 15.50681025 16.27946821 17.04191719]);
model.physics('plas').feature('pes1').set('deNYdata', {'0' '7.52E+23' '7.36E+23' '7.40E+23' '7.68E+23' '8.11E+23' '8.62E+23' '9.18E+23' '9.80E+23' '1.04E+24'  ...
'1.11E+24' '1.18E+24' '1.25E+24' '1.32E+24' '1.40E+24' '1.47E+24' '1.55E+24' '1.62E+24' '1.70E+24' '1.78E+24'  ...
'2.60E+24' '3.47E+24' '4.37E+24' '5.31E+24' '6.28E+24' '7.27E+24' '8.29E+24' '9.32E+24' '1.04E+25' '1.14E+25'  ...
'1.25E+25' '1.36E+25' '1.47E+25' '1.58E+25' '1.70E+25' '1.81E+25'});
model.physics('plas').feature('pes1').set('SpecifyMeanElectronEnergy', 'MeanEnergyTable');
model.physics('plas').feature('pes1').set('enrgXdata', [0 10 15 20 25 30 35 40 45 50 55 60 65 70 75 80 85 90 95 100 150 200 250 300 350 400 450 500 550 600 650 700 750 800 850 900]);
model.physics('plas').feature('pes1').set('enrgYdata', [0 0.013061613 0.093540084 0.228107915 0.3849651 0.548393454 0.711943481 0.873094428 1.030952274 1.185305533 1.33622818 1.483907137 1.62856571 1.770429612 1.909712486 2.046610487 2.181301066 2.313943661 2.444681161 2.57364161 3.786025481 4.898764283 5.944640553 6.941089171 7.898753833 8.824740665 9.724098546 10.6005823 11.45708358 12.29589151 13.1188591 13.92751417 14.72313607 15.50681025 16.27946821 17.04191719]);
model.physics('plas').feature('init1').set('neinit', 'ne0');
model.physics('plas').create('wall1', 'WallDriftDiffusion', 0);
model.physics('plas').feature('wall1').selection.all;
model.physics('plas').create('gnd1', 'Ground', 0);
model.physics('plas').feature('gnd1').selection.set([1]);
model.physics('plas').create('df1', 'DisplacementField', 0);
model.physics('plas').feature('df1').set('D0', {'Efield*epsilon0_const' '0' '0'});
model.physics('plas').feature('df1').selection.all;
model.physics('plas').create('ccn1', 'ChargeConservation', 1);
model.physics('plas').feature('ccn1').selection.all;
model.physics('plas').feature('ccn1').selection.set([2]);
model.physics('plas').feature('ccn1').set('epsilonr_mat', 'userdef');
model.physics('plas').feature('ccn1').set('epsilonr', [10 0 0 0 10 0 0 0 10]);

model.mesh('mesh1').create('edg1', 'Edge');
model.mesh('mesh1').feature('edg1').create('dis1', 'Distribution');
model.mesh('mesh1').feature('edg1').feature('dis1').selection.set([1]);
model.mesh('mesh1').feature('edg1').feature('dis1').set('numelem', 2000);
model.mesh('mesh1').feature.duplicate('edg2', 'edg1');
model.mesh('mesh1').feature('edg2').feature('dis1').selection.all;
model.mesh('mesh1').feature('edg2').feature('dis1').selection.set([2]);
model.mesh('mesh1').feature('edg2').feature('dis1').set('numelem', 10);
model.mesh('mesh1').run;

model.study('std1').setGenPlots(false);
model.study('std1').feature('time').set('tunit', 'ns');
model.study('std1').feature('time').set('tlist', 'range(0,0.9/19,0.9)');
model.study('std1').feature('time').set('plot', true);
model.study('std1').feature('time').set('plotfreq', 'tsteps');

model.sol.create('sol1');
model.sol('sol1').study('std1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'time');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').set('control', 'time');
model.sol('sol1').create('t1', 'Time');
model.sol('sol1').feature('t1').set('tlist', 'range(0,0.9/19,0.9)');
model.sol('sol1').feature('t1').set('plot', 'on');
model.sol('sol1').feature('t1').set('plotgroup', 'Default');
model.sol('sol1').feature('t1').set('plotfreq', 'tsteps');
model.sol('sol1').feature('t1').set('probesel', 'all');
model.sol('sol1').feature('t1').set('probes', {});
model.sol('sol1').feature('t1').set('probefreq', 'tsteps');
model.sol('sol1').feature('t1').set('rtol', 0.001);
model.sol('sol1').feature('t1').set('atolglobalvaluemethod', 'manual');
model.sol('sol1').feature('t1').set('atolglobalmethod', 'unscaled');
model.sol('sol1').feature('t1').set('atolglobal', 0.001);
model.sol('sol1').feature('t1').set('atolglobalvaluemethod', 'manual');
model.sol('sol1').feature('t1').set('reacf', true);
model.sol('sol1').feature('t1').set('storeudot', true);
model.sol('sol1').feature('t1').set('endtimeinterpolation', true);
model.sol('sol1').feature('t1').set('estrat', 'exclude');
model.sol('sol1').feature('t1').set('maxorder', 2);
model.sol('sol1').feature('t1').set('initialstepbdfactive', true);
model.sol('sol1').feature('t1').set('initialstepbdf', '(1.0E-13)[s]');
model.sol('sol1').feature('t1').set('control', 'time');
model.sol('sol1').feature('t1').feature('aDef').set('matherr', false);
model.sol('sol1').feature('t1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('t1').feature('fc1').set('jtech', 'once');
model.sol('sol1').feature('t1').create('d1', 'Direct');
model.sol('sol1').feature('t1').feature('d1').set('linsolver', 'pardiso');
model.sol('sol1').feature('t1').feature('fc1').set('linsolver', 'd1');
model.sol('sol1').feature('t1').feature('fc1').set('jtech', 'once');
model.sol('sol1').feature('t1').feature.remove('fcDef');
model.sol('sol1').attach('std1');

model.result.create('pg1', 'PlotGroup1D');
model.result('pg1').set('data', 'dset1');
model.result('pg1').create('lngr1', 'LineGraph');
model.result('pg1').feature('lngr1').set('xdata', 'expr');
model.result('pg1').feature('lngr1').set('xdataexpr', 'x');
model.result('pg1').feature('lngr1').selection.geom('geom1', 1);
model.result('pg1').feature('lngr1').selection.set([1 2]);
model.result('pg1').feature('lngr1').set('expr', {'plas.ne'});

model.sol('sol1').runFromTo('st1', 'v1');

model.result.remove('pg1');

model.study('std1').feature('time').set('plotgroup', 'Default');

model.result.create('pg1', 'PlotGroup1D');
model.result('pg1').run;
model.result('pg1').label('Charged Species');
model.result('pg1').setIndex('looplevelinput', 'last', 0);
model.result('pg1').set('titletype', 'none');
model.result('pg1').set('ylabelactive', true);
model.result('pg1').set('ylabel', 'Density (m<sup>-3</sup>)');
model.result('pg1').set('axislimits', true);
model.result('pg1').set('xmin', 0);
model.result('pg1').set('ymin', 0);
model.result('pg1').set('ymax', '1.8e19');
model.result('pg1').create('lngr1', 'LineGraph');
model.result('pg1').feature('lngr1').set('markerpos', 'datapoints');
model.result('pg1').feature('lngr1').set('linewidth', 'preference');
model.result('pg1').feature('lngr1').label('Electrons');
model.result('pg1').feature('lngr1').selection.set([1]);
model.result('pg1').feature('lngr1').set('xdata', 'expr');
model.result('pg1').feature('lngr1').set('xdataexpr', 'x');
model.result('pg1').feature('lngr1').set('legend', true);
model.result('pg1').feature.duplicate('lngr2', 'lngr1');
model.result('pg1').run;
model.result('pg1').feature('lngr2').label('Ions');
model.result('pg1').feature('lngr2').set('expr', 'plas.n_wN_1p');
model.result('pg1').feature('lngr2').set('linestyle', 'dashed');
model.result('pg1').feature('lngr2').set('linecolor', 'black');
model.result('pg1').feature('lngr2').set('legend', false);

model.sol('sol1').study('std1');
model.sol('sol1').feature.remove('t1');
model.sol('sol1').feature.remove('v1');
model.sol('sol1').feature.remove('st1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'time');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').set('control', 'time');
model.sol('sol1').create('t1', 'Time');
model.sol('sol1').feature('t1').set('tlist', 'range(0,0.9/19,0.9)');
model.sol('sol1').feature('t1').set('plot', 'on');
model.sol('sol1').feature('t1').set('plotgroup', 'pg1');
model.sol('sol1').feature('t1').set('plotfreq', 'tsteps');
model.sol('sol1').feature('t1').set('probesel', 'all');
model.sol('sol1').feature('t1').set('probes', {});
model.sol('sol1').feature('t1').set('probefreq', 'tsteps');
model.sol('sol1').feature('t1').set('rtol', 0.001);
model.sol('sol1').feature('t1').set('atolglobalvaluemethod', 'manual');
model.sol('sol1').feature('t1').set('atolglobalmethod', 'unscaled');
model.sol('sol1').feature('t1').set('atolglobal', 0.001);
model.sol('sol1').feature('t1').set('atolglobalvaluemethod', 'manual');
model.sol('sol1').feature('t1').set('reacf', true);
model.sol('sol1').feature('t1').set('storeudot', true);
model.sol('sol1').feature('t1').set('endtimeinterpolation', true);
model.sol('sol1').feature('t1').set('estrat', 'exclude');
model.sol('sol1').feature('t1').set('maxorder', 2);
model.sol('sol1').feature('t1').set('initialstepbdfactive', true);
model.sol('sol1').feature('t1').set('initialstepbdf', '(1.0E-13)[s]');
model.sol('sol1').feature('t1').set('control', 'time');
model.sol('sol1').feature('t1').feature('aDef').set('matherr', false);
model.sol('sol1').feature('t1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('t1').feature('fc1').set('jtech', 'once');
model.sol('sol1').feature('t1').create('d1', 'Direct');
model.sol('sol1').feature('t1').feature('d1').set('linsolver', 'pardiso');
model.sol('sol1').feature('t1').feature('fc1').set('linsolver', 'd1');
model.sol('sol1').feature('t1').feature('fc1').set('jtech', 'once');
model.sol('sol1').feature('t1').feature.remove('fcDef');
model.sol('sol1').attach('std1');
model.sol('sol1').runAll;

model.result('pg1').run;
model.result('pg1').setIndex('looplevelinput', 'manual', 0);
model.result('pg1').setIndex('looplevel', [3 9 14 20], 0);
model.result('pg1').run;
model.result('pg1').run;
model.result('pg1').run;
model.result.create('pg2', 'PlotGroup1D');
model.result('pg2').run;
model.result('pg2').label('Mean electron energy');
model.result('pg2').setIndex('looplevelinput', 'manual', 0);
model.result('pg2').setIndex('looplevel', [3 9 14 20], 0);
model.result('pg2').set('titletype', 'none');
model.result('pg2').set('axislimits', true);
model.result('pg2').set('xmin', 0);
model.result('pg2').set('ymin', -0.1);
model.result('pg2').set('ymax', 9);
model.result('pg2').set('legendpos', 'lowerright');
model.result('pg2').create('lngr1', 'LineGraph');
model.result('pg2').feature('lngr1').set('markerpos', 'datapoints');
model.result('pg2').feature('lngr1').set('linewidth', 'preference');
model.result('pg2').feature('lngr1').set('expr', 'plas.ebar');
model.result('pg2').feature('lngr1').selection.set([1]);
model.result('pg2').feature('lngr1').set('xdata', 'expr');
model.result('pg2').feature('lngr1').set('xdataexpr', 'x');
model.result('pg2').feature('lngr1').set('legend', true);
model.result('pg2').run;
model.result('pg2').run;
model.result.duplicate('pg3', 'pg2');
model.result('pg3').run;
model.result('pg3').label('Space charge');
model.result('pg3').set('ymin', -2);
model.result('pg3').set('ymax', 2);
model.result('pg3').set('legendpos', 'upperright');
model.result('pg3').run;
model.result('pg3').feature('lngr1').set('expr', 'plas.scharge');
model.result('pg3').run;
model.result.create('pg4', 'PlotGroup1D');
model.result('pg4').run;
model.result('pg4').label('Velocity');
model.result('pg4').setIndex('looplevelinput', 'manual', 0);
model.result('pg4').setIndex('looplevel', [9 14 20], 0);
model.result('pg4').set('titletype', 'none');
model.result('pg4').set('ylabelactive', true);
model.result('pg4').set('ylabel', 'Velocity (m/s)');
model.result('pg4').create('lngr1', 'LineGraph');
model.result('pg4').feature('lngr1').set('markerpos', 'datapoints');
model.result('pg4').feature('lngr1').set('linewidth', 'preference');
model.result('pg4').feature('lngr1').label('Drift velocity');
model.result('pg4').feature('lngr1').selection.set([1]);
model.result('pg4').feature('lngr1').set('expr', 'plas.mflux_nex/plas.ne');
model.result('pg4').feature('lngr1').set('xdata', 'expr');
model.result('pg4').feature('lngr1').set('xdataexpr', 'x');
model.result('pg4').feature('lngr1').set('legend', true);
model.result('pg4').run;
model.result('pg4').create('lngr2', 'LineGraph');
model.result('pg4').feature('lngr2').set('markerpos', 'datapoints');
model.result('pg4').feature('lngr2').set('linewidth', 'preference');
model.result('pg4').feature('lngr2').label('Analytic');
model.result('pg4').feature('lngr2').selection.set([1]);
model.result('pg4').feature('lngr2').set('expr', 'plas.muexx*abs(plas.Ex)+2*sqrt(plas.Dexx*plas.muexx*abs(plas.Ex)*plas.alpha_1*plas.Nn)');
model.result('pg4').feature('lngr2').set('xdata', 'expr');
model.result('pg4').feature('lngr2').set('xdataexpr', 'x');
model.result('pg4').feature('lngr2').set('linestyle', 'dashed');
model.result('pg4').feature('lngr2').set('linecolor', 'black');
model.result('pg4').run;
model.result('pg4').run;
model.result('pg2').run;
model.result.duplicate('pg5', 'pg2');
model.result('pg5').run;
model.result('pg5').label('Electric field');
model.result('pg5').set('ymin', -102);
model.result('pg5').set('ymax', 2);
model.result('pg5').set('legendpos', 'upperright');
model.result('pg5').run;
model.result('pg5').feature('lngr1').set('expr', 'plas.Ex');
model.result('pg5').feature('lngr1').set('unit', 'kV/cm');
model.result('pg5').run;

model.title('Negative Streamer in Nitrogen');

model.description(['Streamers are transient filamentary electric discharges that can develop in a nonconducting background in the presence of an intense electric field. These discharges can attain high electron number density and consequently a high concentration of chemical active species that are relevant for numerous applications. Industrial applications include ozone production, pollution control, and surface processing.' newline  newline 'The propagation of streamers is driven by very nonlinear dynamics that involve very steep density gradients and high space charge density distributed in very thin layers. This tutorial model presents a study of a negative streamer in atmospheric pressure nitrogen in a constant electric field of -100 kV/cm. The model is one-dimensional and describes the transient behavior of an initial electron seed from electron growth in an unperturbed electric field to streamer propagation.']);

model.mesh.clearMeshes;

model.sol('sol1').clearSolutionData;

model.label('streamer_1d.mph');

model.modelNode.label('Components');

out = model;
