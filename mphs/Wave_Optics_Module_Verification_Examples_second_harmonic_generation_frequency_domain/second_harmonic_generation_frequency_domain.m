function out = model
%
% second_harmonic_generation_frequency_domain.m
%
% Model exported on May 26 2025, 21:34 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/Wave_Optics_Module/Verification_Examples');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 2);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.physics.create('ewfd', 'ElectromagneticWavesFrequencyDomain', 'geom1');
model.physics('ewfd').model('comp1');
model.physics.create('ewfd2', 'ElectromagneticWavesFrequencyDomain', 'geom1');
model.physics('ewfd2').model('comp1');

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
model.study('std1').feature('freq').setSolveFor('/physics/ewfd2', true);

% To import content from file, use:
% model.param.loadFile('FILENAME');
model.param.set('lambda1', '1.064[um]', 'Fundamental wavelength');
model.param.set('f1', 'c_const/lambda1', 'Fundamental frequency');
model.param.set('f2', '2*f1', 'Second harmonic frequency');
model.param.set('lambda2', 'c_const/f2', 'Second harmonic wavelength');
model.param.set('sim_l', 'lambda1*25', 'Simulation length');
model.param.set('sim_h', 'lambda2/16', 'Simulation height');
model.param.set('d', '1e-18[C/V^2]', 'Nonlinear coefficient');
model.param.set('L', 'sim_l - 3*lambda1', 'Length of nonlinear region');
model.param.set('I1', '30[MW/m^2]', 'Incident fundamental intensity');
model.param.set('E1', 'sqrt(2*I1/c_const/epsilon0_const)', 'Incident fundamental electric field strength');
model.param.set('offset', '1.5*lambda1', 'Start of nonlinear region');

model.geom('geom1').create('r1', 'Rectangle');
model.geom('geom1').feature('r1').set('size', {'sim_l' 'sim_h'});
model.geom('geom1').feature('r1').setIndex('layername', 'Layer 1', 0);
model.geom('geom1').feature('r1').setIndex('layer', 'offset', 0);
model.geom('geom1').feature('r1').set('layerleft', true);
model.geom('geom1').feature('r1').set('layerright', true);
model.geom('geom1').feature('r1').set('layerbottom', false);

model.view('view1').axis.set('viewscaletype', 'automatic');

model.geom('geom1').run;

model.material.create('mat1', 'Common', 'comp1');
model.material('mat1').propertyGroup.create('RefractiveIndex', 'Refractive_index');
model.material('mat1').propertyGroup('RefractiveIndex').set('n', {'1'});
model.material('mat1').propertyGroup('RefractiveIndex').set('ki', {'0'});

model.physics('ewfd').label('Fundamental');
model.physics('ewfd').tag('ewfd1');
model.physics('ewfd1').prop('components').set('components', 'inplane');
model.physics('ewfd1').create('pol1', 'Polarization', 2);
model.physics('ewfd1').feature('pol1').selection.set([2]);
model.physics('ewfd1').feature('pol1').set('P', {'0' '2*d*ewfd2.Ey*conj(ewfd1.Ey)' '0'});
model.physics('ewfd1').create('sctr1', 'Scattering', 1);
model.physics('ewfd1').feature('sctr1').selection.set([1]);
model.physics('ewfd1').feature('sctr1').set('IncidentField', 'EField');
model.physics('ewfd1').feature('sctr1').set('E0i', {'0' 'E1' '0'});
model.physics('ewfd1').create('sctr2', 'Scattering', 1);
model.physics('ewfd1').feature('sctr2').selection.set([10]);
model.physics('ewfd2').label('Second Harmonic');
model.physics('ewfd2').prop('components').set('components', 'inplane');
model.physics('ewfd2').prop('EquationForm').setIndex('form', 'Frequency', 0);
model.physics('ewfd2').prop('EquationForm').setIndex('freq_src', 'userdef', 0);
model.physics('ewfd2').prop('EquationForm').setIndex('freq', 'f2', 0);
model.physics('ewfd2').create('pol1', 'Polarization', 2);
model.physics('ewfd2').feature('pol1').selection.set([2]);
model.physics('ewfd2').feature('pol1').set('P', {'0' 'd*ewfd1.Ey*ewfd1.Ey' '0'});
model.physics('ewfd2').create('sctr1', 'Scattering', 1);
model.physics('ewfd2').feature('sctr1').selection.set([1 10]);

model.mesh('mesh1').create('map1', 'Map');
model.mesh('mesh1').feature('size').set('custom', true);
model.mesh('mesh1').feature('size').set('hmax', 'sim_h');
model.mesh('mesh1').feature('size').set('hmin', 'sim_h');

model.variable.create('var1');
model.variable('var1').model('comp1');
model.variable('var1').set('gamma', 'sqrt(8*d^2*Z0_const^3*(2*pi*ewfd1.freq)^2*I1)');
model.variable('var1').descr('gamma', 'Coupling coefficient');

model.study('std1').feature('freq').set('plist', 'f1');

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
model.sol('sol1').feature('s1').feature.remove('pDef');
model.sol('sol1').feature('s1').feature('p1').set('pname', {'freq'});
model.sol('sol1').feature('s1').feature('p1').set('plistarr', {'f1'});
model.sol('sol1').feature('s1').feature('p1').set('punit', {'THz'});
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
model.sol('sol1').feature('s1').feature('aDef').set('cachepattern', false);
model.sol('sol1').feature('s1').create('seDef', 'Segregated');
model.sol('sol1').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('s1').create('d1', 'Direct');
model.sol('sol1').feature('s1').feature('d1').set('linsolver', 'mumps');
model.sol('sol1').feature('s1').feature('d1').label('Suggested Direct Solver (ewfd1) (Merged)');
model.sol('sol1').feature('s1').feature('fc1').set('linsolver', 'd1');
model.sol('sol1').feature('s1').feature.remove('fcDef');
model.sol('sol1').feature('s1').feature.remove('seDef');
model.sol('sol1').attach('std1');
model.sol('sol1').feature('st1').set('splitcomplex', true);
model.sol('sol1').feature('s1').set('stol', 0.001);
model.sol('sol1').runAll;

model.result.create('pg1', 'PlotGroup2D');
model.result('pg1').label('Electric Field (ewfd1)');
model.result('pg1').set('frametype', 'spatial');
model.result('pg1').set('data', 'dset1');
model.result('pg1').setIndex('looplevel', 1, 0);
model.result('pg1').set('defaultPlotID', 'ElectromagneticWavesFrequencyDomain/phys1/pdef1/pcond2/pg1');
model.result('pg1').feature.create('surf1', 'Surface');
model.result('pg1').feature('surf1').set('smooth', 'internal');
model.result('pg1').feature('surf1').set('data', 'parent');
model.result.create('pg2', 'PlotGroup2D');
model.result('pg2').label('Electric Field (ewfd2)');
model.result('pg2').set('frametype', 'spatial');
model.result('pg2').set('data', 'dset1');
model.result('pg2').setIndex('looplevel', 1, 0);
model.result('pg2').set('defaultPlotID', 'ElectromagneticWavesFrequencyDomain/phys1/pdef1/pcond2/pg1');
model.result('pg2').feature.create('surf1', 'Surface');
model.result('pg2').feature('surf1').set('expr', 'ewfd2.normE');
model.result('pg2').feature('surf1').set('smooth', 'internal');
model.result('pg2').feature('surf1').set('data', 'parent');
model.result('pg1').run;
model.result('pg1').label('Fundamental');
model.result('pg1').run;
model.result('pg1').feature('surf1').set('expr', 'ewfd1.Ey');
model.result('pg1').run;
model.result('pg1').set('titletype', 'manual');
model.result('pg1').set('title', 'Electric field, y-component (V/m) for fundamental wave');
model.result('pg1').run;
model.result('pg2').run;
model.result('pg2').label('Second Harmonic');
model.result('pg2').run;
model.result('pg2').feature('surf1').set('expr', 'ewfd2.Ey');
model.result('pg2').run;
model.result('pg2').set('titletype', 'manual');
model.result('pg2').set('title', 'Electric field, y-component (V/m) for second harmonic wave');
model.result('pg2').run;
model.result.create('pg3', 'PlotGroup1D');
model.result('pg3').run;
model.result('pg3').label('Electric Fields');
model.result('pg3').create('lngr1', 'LineGraph');
model.result('pg3').feature('lngr1').set('markerpos', 'datapoints');
model.result('pg3').feature('lngr1').set('linewidth', 'preference');
model.result('pg3').feature('lngr1').label('Fundamental');
model.result('pg3').feature('lngr1').selection.set([2 5 8]);
model.result('pg3').feature('lngr1').set('expr', 'ewfd1.Ey');
model.result('pg3').feature('lngr1').set('xdata', 'expr');
model.result('pg3').feature('lngr1').set('xdataexpr', 'x');
model.result('pg3').feature('lngr1').set('linewidth', 2);
model.result('pg3').feature('lngr1').set('legend', true);
model.result('pg3').feature('lngr1').set('autoplotlabel', true);
model.result('pg3').feature('lngr1').set('autosolution', false);
model.result('pg3').feature.duplicate('lngr2', 'lngr1');
model.result('pg3').run;
model.result('pg3').feature('lngr2').label('Second Harmonic');
model.result('pg3').feature('lngr2').set('expr', 'ewfd2.Ey');
model.result('pg3').run;
model.result('pg3').set('titletype', 'manual');
model.result('pg3').set('title', 'Fundamental and Second Harmonic Electric Fields');
model.result.create('pg4', 'PlotGroup1D');
model.result('pg4').run;
model.result('pg4').label('Photon Flux Density');
model.result('pg4').create('lngr1', 'LineGraph');
model.result('pg4').feature('lngr1').set('markerpos', 'datapoints');
model.result('pg4').feature('lngr1').set('linewidth', 'preference');
model.result('pg4').feature('lngr1').label('Simulation Fundamental');
model.result('pg4').feature('lngr1').selection.set([2 5 8]);
model.result('pg4').feature('lngr1').set('expr', 'ewfd1.Ey*conj(ewfd1.Ey)/(2*Z0_const)/hbar_const/(2*pi*ewfd1.freq)');
model.result('pg4').feature('lngr1').set('xdata', 'expr');
model.result('pg4').feature('lngr1').set('xdataexpr', 'x');
model.result('pg4').feature('lngr1').set('linestyle', 'none');
model.result('pg4').feature('lngr1').set('linewidth', 5);
model.result('pg4').feature('lngr1').set('linemarker', 'diamond');
model.result('pg4').feature('lngr1').set('markerpos', 'interp');
model.result('pg4').feature('lngr1').set('markers', 20);
model.result('pg4').feature('lngr1').set('legend', true);
model.result('pg4').feature('lngr1').set('autoplotlabel', true);
model.result('pg4').feature('lngr1').set('autosolution', false);
model.result('pg4').feature.duplicate('lngr2', 'lngr1');
model.result('pg4').run;
model.result('pg4').feature('lngr2').label('Simulation Second Harmonic');
model.result('pg4').feature('lngr2').set('expr', 'ewfd2.Ey*conj(ewfd2.Ey)/(2*Z0_const)/hbar_const/(2*pi*ewfd2.freq)');
model.result('pg4').feature.duplicate('lngr3', 'lngr2');
model.result('pg4').run;
model.result('pg4').feature('lngr3').label('Slowly Varying Envelope Approximation (SVEA) Fundamental');
model.result('pg4').feature('lngr3').selection.set([5]);
model.result('pg4').feature('lngr3').set('expr', '(sech(gamma*(x - offset)/2))^2*I1/hbar_const/(2*pi*ewfd1.freq)');
model.result('pg4').feature('lngr3').set('linestyle', 'solid');
model.result('pg4').feature('lngr3').set('linewidth', 2);
model.result('pg4').feature('lngr3').set('linemarker', 'none');
model.result('pg4').feature('lngr3').set('legendmethod', 'manual');
model.result('pg4').feature('lngr3').setIndex('legends', 'SVEA Fundamental', 0);
model.result('pg4').feature.duplicate('lngr4', 'lngr3');
model.result('pg4').run;
model.result('pg4').feature('lngr4').label('Slowly Varying Envelope Approximation (SVEA) Second Harmonic');
model.result('pg4').feature('lngr4').set('expr', '(tanh(gamma*(x - offset)/2))^2*I1/hbar_const/(2*pi*ewfd2.freq)');
model.result('pg4').feature('lngr4').setIndex('legends', 'SVEA Second Harmonic', 0);
model.result('pg4').run;
model.result('pg4').set('titletype', 'manual');
model.result('pg4').set('title', 'Fundamental and Second Harmonic Photon Flux Density');
model.result('pg4').set('ylabelactive', true);
model.result('pg4').set('ylabel', 'Photon Flux Density (photons per m^2 s)');

model.title('Second Harmonic Generation in the Frequency Domain');

model.description(['This is a proof of principle example, describing the second harmonic generation (SHG) process using two Electromagnetic Waves, Frequency Domain interfaces. One for the fundamental wave and one for the second harmonic.' newline  newline 'For convenience, the refractive index is perfectly matched (at n = 1) for each frequency. The coupling between the waves is implemented using a domain Polarization feature for each interface.' newline  newline 'The results are compared against the analytical solution from the Slowly Varying Envelope Approximation (SVEA).']);

model.mesh.clearMeshes;

model.sol('sol1').clearSolutionData;

model.label('second_harmonic_generation_frequency_domain.mph');

model.modelNode.label('Components');

out = model;
