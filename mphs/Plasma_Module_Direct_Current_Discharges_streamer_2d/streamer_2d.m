function out = model
%
% streamer_2d.m
%
% Model exported on May 26 2025, 21:31 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/Plasma_Module/Direct_Current_Discharges');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 2);
model.geom('geom1').model('comp1');
model.geom('geom1').axisymmetric(true);

model.mesh.create('mesh1', 'geom1');

model.physics.create('plas', 'ColdPlasma', 'geom1');
model.physics('plas').model('comp1');

model.study.create('std1');
model.study('std1').create('time', 'Transient');
model.study('std1').feature('time').setSolveFor('/physics/plas', true);

model.geom('geom1').lengthUnit('cm');
model.geom('geom1').create('r1', 'Rectangle');
model.geom('geom1').feature('r1').setIndex('layername', 'Layer 1', 0);
model.geom('geom1').feature('r1').setIndex('layer', 0.05, 0);
model.geom('geom1').feature('r1').set('layerleft', true);
model.geom('geom1').feature('r1').set('layerbottom', false);
model.geom('geom1').runPre('fin');
model.geom('geom1').run('fin');
model.geom('geom1').create('mce1', 'MeshControlEdges');
model.geom('geom1').feature('mce1').selection('input').set('fin', 4);
model.geom('geom1').run('mce1');

model.variable.create('var1');
model.variable('var1').model('comp1');

% To import content from file, use:
% model.variable('var1').loadFile('FILENAME');
model.variable('var1').set('P', '760', 'Pressure in Torr');
model.variable('var1').set('mue', '2.9e5[cm^2/s/V]/P', 'Electron mobility');
model.variable('var1').set('mui', '2.6e3[cm^2/s/V]/P', 'Ion mobility');
model.variable('var1').set('Ri', 'alpha(plas.normE)*mue*plas.normE/plas.c_wM', 'Rate constant');
model.variable('var1').set('DeL', '1800[cm^2/s]', 'Longitudinal electron diffusivity');
model.variable('var1').set('DeT', '2190[cm^2/s]', 'Transverse electron diffusivity');
model.variable('var1').set('ne0', 'ne0_min+ne0_max*exp(- ((z-z0)/sz)^2-((r)/sr)^2 )', 'Initial electron density');
model.variable('var1').set('ne0_min', '1e8[cm^-3]', 'Minimum initial electron density');
model.variable('var1').set('ne0_max', '1e14[cm^-3]', 'Maximum initial electron density');
model.variable('var1').set('z0', '0.5[cm]', 'Axial position');
model.variable('var1').set('sz', '0.027[cm]', 'Dispersion in z');
model.variable('var1').set('sr', '0.021[cm]', 'Dispersion in r');
model.variable('var1').set('V0', '52[kV]', 'Applied voltage');

model.func.create('an1', 'Analytic');
model.func('an1').model('comp1');
model.func('an1').label('Townsend coefficient');
model.func('an1').set('funcname', 'alpha');
model.func('an1').set('expr', '5.7*760*exp(-260*760/x)');
model.func('an1').setIndex('argunit', 'V/cm', 0);
model.func('an1').set('fununit', 'cm^-1');
model.func('an1').setIndex('plotargs', '1[kV/cm]', 0, 1);
model.func('an1').setIndex('plotargs', '150e3[kV/cm]', 0, 2);

model.physics('plas').prop('ElectronProperties').set('MeanElectronEnergyModel', 'LocalFieldApproximationE');
model.physics('plas').prop('ShapeProperty').set('Formulation', 'FEMQuadratic');
model.physics('plas').create('eir1', 'ElectronImpactReaction', 2);
model.physics('plas').feature('eir1').set('formula', 'e+M=>e+e+M+');
model.physics('plas').feature('eir1').set('type', 'Ionization');
model.physics('plas').feature('eir1').set('de', 10);
model.physics('plas').feature('eir1').set('kf', 'Ri');
model.physics('plas').feature('M').set('FromMassConstraint', true);
model.physics('plas').feature('M').set('PresetSpeciesData', 'N2');
model.physics('plas').feature('M_1p').set('InitIon', true);
model.physics('plas').feature('M_1p').set('PresetSpeciesData', 'N2');
model.physics('plas').feature('M_1p').set('MobilityDiffusivitySpecification', 'SpecifyMobilityComputeDiffusivity');
model.physics('plas').feature('M_1p').set('um', 'mui');
model.physics('plas').feature('pes1').set('mue', {'mue' '0' '0' '0' 'mue' '0' '0' '0' 'mue'});
model.physics('plas').feature('pes1').set('SpecifyElectronDensityAndEnergy', 'SpecifyAll');
model.physics('plas').feature('pes1').set('De', {'DeL' '0' '0' '0' '0' '0' '0' '0' 'DeT'});
model.physics('plas').feature('init1').set('neinit', 'ne0');
model.physics('plas').create('gnd1', 'Ground', 1);
model.physics('plas').feature('gnd1').selection.set([2]);
model.physics('plas').create('mct1', 'MetalContact', 1);
model.physics('plas').feature('mct1').set('V0', 'V0');
model.physics('plas').feature('mct1').selection.set([3]);
model.physics('plas').create('ede1', 'ElectronDensityAndEnergy', 1);
model.physics('plas').feature('ede1').selection.set([2 3]);
model.physics('plas').feature('ede1').set('fixne', true);
model.physics('plas').feature('ede1').set('newall', 'ne0_min');

model.mesh('mesh1').automatic(false);
model.mesh('mesh1').feature('size').set('table', 'default');
model.mesh('mesh1').feature('size').set('hauto', 5);
model.mesh('mesh1').create('map1', 'Map');
model.mesh('mesh1').feature.move('map1', 1);
model.mesh('mesh1').feature('map1').selection.geom('geom1', 2);
model.mesh('mesh1').feature('map1').selection.set([1]);
model.mesh('mesh1').feature('map1').set('smoothcontrol', false);
model.mesh('mesh1').feature('map1').create('dis1', 'Distribution');
model.mesh('mesh1').feature('map1').feature('dis1').selection.set([3 5]);
model.mesh('mesh1').feature('map1').feature('dis1').set('type', 'predefined');
model.mesh('mesh1').feature('map1').feature('dis1').set('elemcount', 30);
model.mesh('mesh1').feature('map1').feature('dis1').set('elemratio', 5);
model.mesh('mesh1').feature('map1').feature('dis1').set('growthrate', 'exponential');
model.mesh('mesh1').feature('map1').create('dis2', 'Distribution');
model.mesh('mesh1').feature('map1').feature('dis2').selection.set([1 7]);
model.mesh('mesh1').feature('map1').feature('dis2').set('numelem', 600);
model.mesh('mesh1').feature('ftri1').set('smoothcontrol', false);
model.mesh('mesh1').run;

model.view.create('view2', 'geom1');
model.view('view2').model('comp1');
model.view('view2').set('locked', true);
model.view('view2').axis.set('xmin', -0.06);
model.view('view2').axis.set('xmax', 0.06);
model.view('view2').axis.set('ymin', 0);
model.view('view2').axis.set('ymax', 1);
model.view('view2').axis.set('viewscaletype', 'manual');
model.view('view2').axis.set('yscale', 0.17);

model.study('std1').setGenPlots(false);

model.sol.create('sol1');
model.sol('sol1').study('std1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'time');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').feature('comp1_plas_M_1p_w').set('scalemethod', 'manual');
model.sol('sol1').feature('v1').feature('comp1_Ne').set('scalemethod', 'manual');
model.sol('sol1').feature('v1').feature('comp1_V').set('scalemethod', 'manual');
model.sol('sol1').feature('v1').feature('comp1_plas_M_1p_w').set('scaleval', '1E-5');
model.sol('sol1').feature('v1').feature('comp1_Ne').set('scaleval', '1E20');
model.sol('sol1').feature('v1').feature('comp1_V').set('scaleval', '100');
model.sol('sol1').feature('v1').set('control', 'time');
model.sol('sol1').create('t1', 'Time');
model.sol('sol1').feature('t1').set('tlist', 'range(0,0.1,1)');
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
model.sol('sol1').feature('t1').set('maxorder', 2);
model.sol('sol1').feature('t1').set('initialstepbdfactive', true);
model.sol('sol1').feature('t1').set('initialstepbdf', '(1.0E-13)[s]');
model.sol('sol1').feature('t1').set('control', 'time');
model.sol('sol1').feature('t1').feature('aDef').set('cachepattern', true);
model.sol('sol1').feature('t1').feature('aDef').set('matherr', false);
model.sol('sol1').feature('t1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('t1').feature('fc1').set('jtech', 'once');
model.sol('sol1').feature('t1').feature('fc1').set('stabacc', 'aacc');
model.sol('sol1').feature('t1').feature('fc1').set('aaccdim', 5);
model.sol('sol1').feature('t1').create('d1', 'Direct');
model.sol('sol1').feature('t1').feature('d1').set('linsolver', 'pardiso');
model.sol('sol1').feature('t1').feature('d1').set('pivotperturb', 1.0E-13);
model.sol('sol1').feature('t1').feature('fc1').set('linsolver', 'd1');
model.sol('sol1').feature('t1').feature('fc1').set('jtech', 'once');
model.sol('sol1').feature('t1').feature('fc1').set('stabacc', 'aacc');
model.sol('sol1').feature('t1').feature('fc1').set('aaccdim', 5);
model.sol('sol1').feature('t1').feature.remove('fcDef');
model.sol('sol1').attach('std1');
model.sol('sol1').runFromTo('st1', 'v1');

model.result.dataset.create('mir1', 'Mirror2D');
model.result.create('pg1', 'PlotGroup2D');
model.result('pg1').run;
model.result('pg1').label('Electron Number Density');
model.result('pg1').set('data', 'mir1');
model.result('pg1').set('view', 'view1');
model.result('pg1').create('surf1', 'Surface');
model.result('pg1').run;

model.study('std1').feature('time').set('tunit', 'ns');
model.study('std1').feature('time').set('tlist', 'range(0,0.5,2.5)');
model.study('std1').feature('time').set('plot', true);
model.study('std1').feature('time').set('plotfreq', 'tsteps');

model.sol('sol1').study('std1');
model.sol('sol1').feature.remove('t1');
model.sol('sol1').feature.remove('v1');
model.sol('sol1').feature.remove('st1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'time');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').feature('comp1_plas_M_1p_w').set('scalemethod', 'manual');
model.sol('sol1').feature('v1').feature('comp1_Ne').set('scalemethod', 'manual');
model.sol('sol1').feature('v1').feature('comp1_V').set('scalemethod', 'manual');
model.sol('sol1').feature('v1').feature('comp1_plas_M_1p_w').set('scaleval', '1E-5');
model.sol('sol1').feature('v1').feature('comp1_Ne').set('scaleval', '1E20');
model.sol('sol1').feature('v1').feature('comp1_V').set('scaleval', '100');
model.sol('sol1').feature('v1').set('control', 'time');
model.sol('sol1').create('t1', 'Time');
model.sol('sol1').feature('t1').set('tlist', 'range(0,0.5,2.5)');
model.sol('sol1').feature('t1').set('plot', 'on');
model.sol('sol1').feature('t1').set('plotgroup', 'pg1');
model.sol('sol1').feature('t1').set('plotfreq', 'tsteps');
model.sol('sol1').feature('t1').set('probesel', 'all');
model.sol('sol1').feature('t1').set('probes', {});
model.sol('sol1').feature('t1').set('probefreq', 'tsteps');
model.sol('sol1').feature('t1').set('rtol', 1.0E-4);
model.sol('sol1').feature('t1').set('atolglobalvaluemethod', 'factor');
model.sol('sol1').feature('t1').set('reacf', true);
model.sol('sol1').feature('t1').set('storeudot', true);
model.sol('sol1').feature('t1').set('endtimeinterpolation', true);
model.sol('sol1').feature('t1').set('maxorder', 2);
model.sol('sol1').feature('t1').set('initialstepbdfactive', true);
model.sol('sol1').feature('t1').set('initialstepbdf', '(1.0E-13)[s]');
model.sol('sol1').feature('t1').set('control', 'time');
model.sol('sol1').feature('t1').feature('aDef').set('cachepattern', true);
model.sol('sol1').feature('t1').feature('aDef').set('matherr', false);
model.sol('sol1').feature('t1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('t1').feature('fc1').set('jtech', 'once');
model.sol('sol1').feature('t1').feature('fc1').set('stabacc', 'aacc');
model.sol('sol1').feature('t1').feature('fc1').set('aaccdim', 5);
model.sol('sol1').feature('t1').create('d1', 'Direct');
model.sol('sol1').feature('t1').feature('d1').set('linsolver', 'pardiso');
model.sol('sol1').feature('t1').feature('d1').set('pivotperturb', 1.0E-13);
model.sol('sol1').feature('t1').feature('fc1').set('linsolver', 'd1');
model.sol('sol1').feature('t1').feature('fc1').set('jtech', 'once');
model.sol('sol1').feature('t1').feature('fc1').set('stabacc', 'aacc');
model.sol('sol1').feature('t1').feature('fc1').set('aaccdim', 5);
model.sol('sol1').feature('t1').feature.remove('fcDef');
model.sol('sol1').attach('std1');
model.sol('sol1').runAll;

model.result('pg1').run;
model.result.create('pg2', 'PlotGroup2D');
model.result('pg2').run;
model.result('pg2').label('Electric Potential and Space Charge Density');
model.result('pg2').set('data', 'mir1');
model.result('pg2').set('view', 'view1');
model.result('pg2').create('surf1', 'Surface');
model.result('pg2').feature('surf1').set('expr', 'plas.scharge');
model.result('pg2').run;
model.result('pg2').feature('surf1').set('colortable', 'Dipole');
model.result('pg2').run;
model.result('pg2').create('con1', 'Contour');
model.result('pg2').feature('con1').set('expr', 'V');
model.result('pg2').run;
model.result.create('pg3', 'PlotGroup2D');
model.result('pg3').run;
model.result('pg3').label('Electron Density Contour');
model.result('pg3').set('data', 'mir1');
model.result('pg3').create('con1', 'Contour');
model.result('pg3').feature('con1').set('levelmethod', 'levels');
model.result('pg3').feature('con1').set('levels', 'range(1.0e19,1.0e19,1.3e20)');
model.result('pg3').run;
model.result('pg3').run;
model.result('pg3').set('view', 'view2');
model.result('pg3').run;
model.result.create('pg4', 'PlotGroup1D');
model.result('pg4').run;
model.result('pg4').label('Charged species number density');
model.result('pg4').set('titletype', 'none');
model.result('pg4').set('ylabelactive', true);
model.result('pg4').set('ylabel', 'Number Density (1/m<sup>3</sup>)');
model.result('pg4').create('lngr1', 'LineGraph');
model.result('pg4').feature('lngr1').set('markerpos', 'datapoints');
model.result('pg4').feature('lngr1').set('linewidth', 'preference');
model.result('pg4').feature('lngr1').selection.set([1]);
model.result('pg4').feature('lngr1').set('xdata', 'expr');
model.result('pg4').feature('lngr1').set('xdataexpr', 'z');
model.result('pg4').feature('lngr1').set('legend', true);
model.result('pg4').feature('lngr1').set('resolution', 'norefine');
model.result('pg4').run;
model.result('pg4').feature.duplicate('lngr2', 'lngr1');
model.result('pg4').run;
model.result('pg4').feature('lngr2').set('legend', false);
model.result('pg4').feature('lngr2').set('expr', 'plas.n_wM_1p');
model.result('pg4').feature('lngr2').set('linestyle', 'dotted');
model.result('pg4').feature('lngr2').set('linecolor', 'black');
model.result.create('pg5', 'PlotGroup1D');
model.result('pg5').run;
model.result('pg5').label('Electric field');
model.result('pg5').set('titletype', 'none');
model.result('pg5').set('axislimits', true);
model.result('pg5').set('xmin', 0);
model.result('pg5').set('ymin', '-2e7');
model.result('pg5').set('ymax', 0);
model.result('pg5').set('legendpos', 'lowerright');
model.result('pg5').create('lngr1', 'LineGraph');
model.result('pg5').feature('lngr1').set('markerpos', 'datapoints');
model.result('pg5').feature('lngr1').set('linewidth', 'preference');
model.result('pg5').feature('lngr1').selection.set([1]);
model.result('pg5').feature('lngr1').set('expr', 'plas.Ez');
model.result('pg5').feature('lngr1').set('xdata', 'expr');
model.result('pg5').feature('lngr1').set('xdataexpr', 'z');
model.result('pg5').feature('lngr1').set('legend', true);
model.result('pg5').run;
model.result('pg1').run;
model.result('pg2').run;
model.result('pg3').run;
model.result('pg4').run;
model.result('pg5').run;

model.title('Double-Headed Streamer in Nitrogen');

model.description(['This tutorial model presents a study of a double-headed streamer in nitrogen at atmospheric pressure. An initial seed of electrons is placed between two electrodes which apply an initial electric field of 52' native2unicode(hex2dec({'00' 'a0'}), 'unicode') 'kV/cm to the gas. A negative and positive streamer propagate toward the electrodes. The electron density, electric field, and the propagation velocity of the streamer agrees well with simulation results published by Bessi' native2unicode(hex2dec({'00' 'e8'}), 'unicode') 'res and others.']);

model.mesh.clearMeshes;

model.sol('sol1').clearSolutionData;

model.label('streamer_2d.mph');

model.modelNode.label('Components');

out = model;
