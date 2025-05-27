function out = model
%
% antireflective_coating_multilayer.m
%
% Model exported on May 26 2025, 21:32 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/Ray_Optics_Module/Prisms_and_Coatings');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 2);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.physics.create('gop', 'GeometricalOptics', 'geom1');
model.physics('gop').model('comp1');

model.study.create('std1');
model.study('std1').create('rtrac', 'RayTracing');
model.study('std1').feature('rtrac').setSolveFor('/physics/gop', true);

model.param.set('n_air', '1');
model.param.descr('n_air', 'Refractive index of air');
model.param.set('n_glass', '1.5');
model.param.descr('n_glass', 'Refractive index of glass');
model.param.set('n_CeF3', '1.63');
model.param.descr('n_CeF3', 'Refractive index of CeF3');
model.param.set('n_MgF2', '1.38');
model.param.descr('n_MgF2', 'Refractive index of MgF2');
model.param.set('n_ZrO2', '2.2');
model.param.descr('n_ZrO2', 'Refractive index of ZrO2');
model.param.set('lam0', '550[nm]');
model.param.descr('lam0', 'Vacuum wavelength');

model.geom('geom1').create('sq1', 'Square');
model.geom('geom1').feature('sq1').setIndex('layername', 'Layer 1', 0);
model.geom('geom1').feature('sq1').setIndex('layer', 0.5, 0);
model.geom('geom1').runPre('fin');
model.geom('geom1').run;

model.material.create('mat1', 'Common', 'comp1');
model.material('mat1').propertyGroup.create('RefractiveIndex', 'Refractive_index');
model.material('mat1').propertyGroup('RefractiveIndex').set('n', {'n_air'});
model.material.create('mat2', 'Common', 'comp1');
model.material('mat2').selection.set([1]);
model.material('mat2').propertyGroup.create('RefractiveIndex', 'Refractive_index');
model.material('mat2').propertyGroup('RefractiveIndex').set('n', {'n_glass'});

model.physics('gop').prop('IntensityComputation').setIndex('IntensityComputation', 'ComputeIntensityAndPower', 0);
model.physics('gop').prop('WavelengthDistribution').setIndex('WavelengthDistribution', 'PolychromaticWavelength', 0);
model.physics('gop').prop('MaximumSecondary').setIndex('MaximumSecondary', 0, 0);
model.physics('gop').feature('matd1').set('ShowBoundaryNormal', true);
model.physics('gop').feature('matd1').set('ThinDielectricFilmsOnBoundary', 'AddLayersToSurface');
model.physics('gop').feature('matd1').set('ReleaseReflectedRays', 'Never');
model.physics('gop').feature('matd1').create('film1', 'ThinDielectricFilm', 1);
model.physics('gop').feature('matd1').feature('film1').set('nf', 'n_CeF3');
model.physics('gop').feature('matd1').feature('film1').set('tf', 'lam0/(4*n_CeF3)');
model.physics('gop').feature('matd1').create('film2', 'ThinDielectricFilm', 1);
model.physics('gop').feature('matd1').feature('film2').set('nf', 'n_MgF2');
model.physics('gop').feature('matd1').feature('film2').set('tf', 'lam0/(4*n_MgF2)');
model.physics('gop').create('relg1', 'ReleaseGrid', -1);
model.physics('gop').feature('relg1').setIndex('x0', 0.5, 0);
model.physics('gop').feature('relg1').setIndex('x0', 1, 1);
model.physics('gop').feature('relg1').set('L0', [0 -1 0]);
model.physics('gop').feature('relg1').set('LDistributionFunction', 'ListOfValues');
model.physics('gop').feature('relg1').setIndex('lambda0vals', 'range(400[nm],(800[nm]-(400[nm]))/99,800[nm])', 0);

model.study('std1').feature('rtrac').set('timestepspec', 'specifylength');
model.study('std1').feature('rtrac').set('llist', 'range(0,0.01,1.1)');

model.sol.create('sol1');
model.sol('sol1').study('std1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'rtrac');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').set('control', 'rtrac');
model.sol('sol1').create('t1', 'Time');
model.sol('sol1').feature('t1').set('tlist', 'range(0,0.01,1)');
model.sol('sol1').feature('t1').set('plot', 'off');
model.sol('sol1').feature('t1').set('plotgroup', 'Default');
model.sol('sol1').feature('t1').set('plotfreq', 'tout');
model.sol('sol1').feature('t1').set('probesel', 'all');
model.sol('sol1').feature('t1').set('probes', {});
model.sol('sol1').feature('t1').set('probefreq', 'tsteps');
model.sol('sol1').feature('t1').set('rtol', 1.0E-5);
model.sol('sol1').feature('t1').set('atolglobalvaluemethod', 'factor');
model.sol('sol1').feature('t1').set('reacf', false);
model.sol('sol1').feature('t1').set('storeudot', false);
model.sol('sol1').feature('t1').set('tstepsgenalpha', 'strict');
model.sol('sol1').feature('t1').set('endtimeinterpolation', true);
model.sol('sol1').feature('t1').set('timemethod', 'genalpha');
model.sol('sol1').feature('t1').set('estrat', 'exclude');
model.sol('sol1').feature('t1').set('control', 'rtrac');
model.sol('sol1').feature('t1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('t1').feature('fc1').set('ntolfact', 0.1);
model.sol('sol1').feature('t1').create('i1', 'Iterative');
model.sol('sol1').feature('t1').feature('i1').set('linsolver', 'gmres');
model.sol('sol1').feature('t1').feature('i1').create('ja1', 'Jacobi');
model.sol('sol1').feature('t1').feature('fc1').set('linsolver', 'i1');
model.sol('sol1').feature('t1').feature('fc1').set('ntolfact', 0.1);
model.sol('sol1').feature('t1').feature.remove('fcDef');
model.sol('sol1').attach('std1');
model.sol('sol1').runAll;

model.result.dataset.create('ray1', 'Ray');
model.result.dataset('ray1').set('solution', 'sol1');
model.result.dataset('ray1').set('posdof', {'comp1.qx' 'comp1.qy'});
model.result.dataset('ray1').set('geom', 'geom1');
model.result.dataset('ray1').set('rgeom', 'pgeom_gop');
model.result.dataset('ray1').set('rgeomspec', 'fromphysics');
model.result.dataset('ray1').set('physicsinterface', 'gop');
model.result.create('pg1', 'PlotGroup2D');
model.result('pg1').set('data', 'ray1');
model.result('pg1').setIndex('looplevel', 111, 0);
model.result('pg1').label('Ray Trajectories (gop)');
model.result('pg1').create('rtrj1', 'RayTrajectories');
model.result('pg1').feature('rtrj1').set('linetype', 'line');
model.result('pg1').feature('rtrj1').create('col1', 'Color');
model.result('pg1').feature('rtrj1').feature('col1').set('expr', 'gop.I');
model.result('pg1').feature('rtrj1').create('filt1', 'RayTrajectoriesFilter');
model.result('pg1').run;
model.result.create('pg2', 'PlotGroup1D');
model.result('pg2').run;
model.result('pg2').label('Reflectance');
model.result('pg2').set('data', 'ray1');
model.result('pg2').setIndex('looplevelinput', 'last', 0);
model.result('pg2').set('titletype', 'manual');
model.result('pg2').set('title', 'Reflectance of Multilayer Films');
model.result('pg2').set('xlabelactive', true);
model.result('pg2').set('xlabel', 'Vacuum wavelength (nm)');
model.result('pg2').set('ylabelactive', true);
model.result('pg2').set('ylabel', 'Reflectance (%)');
model.result('pg2').create('rtp1', 'Ray1D');
model.result('pg2').feature('rtp1').set('markerpos', 'datapoints');
model.result('pg2').feature('rtp1').set('linewidth', 'preference');
model.result('pg2').feature('rtp1').set('expr', '100*(gop.relg1.Q0-gop.Q)/gop.relg1.Q0');
model.result('pg2').feature('rtp1').set('xdata', 'expr');
model.result('pg2').feature('rtp1').set('xdataexpr', 'gop.lambda0');
model.result('pg2').feature('rtp1').set('xdataunit', 'nm');
model.result('pg2').feature('rtp1').set('legend', true);
model.result('pg2').feature('rtp1').set('legendmethod', 'manual');
model.result('pg2').feature('rtp1').setIndex('legends', 'Quarter-Quarter', 0);
model.result('pg2').run;

model.physics('gop').feature('matd1').create('film3', 'ThinDielectricFilm', 1);
model.physics('gop').feature('matd1').feature.move('film3', 1);
model.physics('gop').feature('matd1').feature('film3').set('nf', 'n_ZrO2');
model.physics('gop').feature('matd1').feature('film3').set('tf', 'lam0/(2*n_ZrO2)');

model.study.create('std2');
model.study('std2').create('rtrac', 'RayTracing');
model.study('std2').feature('rtrac').setSolveFor('/physics/gop', true);
model.study('std2').feature('rtrac').set('timestepspec', 'specifylength');
model.study('std2').feature('rtrac').set('llist', 'range(0,0.01,1.1)');
model.study('std2').feature('rtrac').set('raystopcond', 'noactive');

model.sol.create('sol2');
model.sol('sol2').study('std2');
model.sol('sol2').create('st1', 'StudyStep');
model.sol('sol2').feature('st1').set('study', 'std2');
model.sol('sol2').feature('st1').set('studystep', 'rtrac');
model.sol('sol2').create('v1', 'Variables');
model.sol('sol2').feature('v1').set('control', 'rtrac');
model.sol('sol2').create('t1', 'Time');
model.sol('sol2').feature('t1').set('tlist', 'range(0,0.01,1)');
model.sol('sol2').feature('t1').set('plot', 'off');
model.sol('sol2').feature('t1').set('plotgroup', 'pg1');
model.sol('sol2').feature('t1').set('plotfreq', 'tout');
model.sol('sol2').feature('t1').set('probesel', 'all');
model.sol('sol2').feature('t1').set('probes', {});
model.sol('sol2').feature('t1').set('probefreq', 'tsteps');
model.sol('sol2').feature('t1').set('rtol', 1.0E-5);
model.sol('sol2').feature('t1').set('atolglobalvaluemethod', 'factor');
model.sol('sol2').feature('t1').set('reacf', false);
model.sol('sol2').feature('t1').set('storeudot', false);
model.sol('sol2').feature('t1').set('tstepsgenalpha', 'strict');
model.sol('sol2').feature('t1').set('endtimeinterpolation', true);
model.sol('sol2').feature('t1').set('timemethod', 'genalpha');
model.sol('sol2').feature('t1').set('estrat', 'exclude');
model.sol('sol2').feature('t1').set('control', 'rtrac');
model.sol('sol2').feature('t1').create('fc1', 'FullyCoupled');
model.sol('sol2').feature('t1').feature('fc1').set('ntolfact', 0.1);
model.sol('sol2').feature('t1').create('i1', 'Iterative');
model.sol('sol2').feature('t1').feature('i1').set('linsolver', 'gmres');
model.sol('sol2').feature('t1').feature('i1').create('ja1', 'Jacobi');
model.sol('sol2').feature('t1').feature('fc1').set('linsolver', 'i1');
model.sol('sol2').feature('t1').feature('fc1').set('ntolfact', 0.1);
model.sol('sol2').feature('t1').feature.remove('fcDef');
model.sol('sol2').attach('std2');
model.sol('sol2').runAll;

model.result.dataset.create('ray2', 'Ray');
model.result.dataset('ray2').set('solution', 'sol2');
model.result.dataset('ray2').set('posdof', {'comp1.qx' 'comp1.qy'});
model.result.dataset('ray2').set('geom', 'geom1');
model.result.dataset('ray2').set('rgeom', 'pgeom_gop');
model.result.dataset('ray2').set('rgeomspec', 'fromphysics');
model.result.dataset('ray2').set('physicsinterface', 'gop');
model.result.create('pg3', 'PlotGroup2D');
model.result('pg3').set('data', 'ray2');
model.result('pg3').setIndex('looplevel', 111, 0);
model.result('pg3').label('Ray Trajectories (gop) 1');
model.result('pg3').create('rtrj1', 'RayTrajectories');
model.result('pg3').feature('rtrj1').set('linetype', 'line');
model.result('pg3').feature('rtrj1').create('col1', 'Color');
model.result('pg3').feature('rtrj1').feature('col1').set('expr', 'gop.I');
model.result('pg3').feature('rtrj1').create('filt1', 'RayTrajectoriesFilter');
model.result('pg3').run;
model.result('pg2').run;
model.result('pg2').feature.duplicate('rtp2', 'rtp1');
model.result('pg2').run;
model.result('pg2').feature('rtp2').set('data', 'ray2');
model.result('pg2').feature('rtp2').setIndex('looplevelinput', 'last', 0);
model.result('pg2').feature('rtp2').setIndex('legends', 'Quarter-Half-Quarter', 0);
model.result('pg2').run;

model.title('Anti-Reflective Coating with Multiple Layers');

model.description(['Anti-reflective coatings are frequently used in optical systems to reduce the amount of stray light produced when a beam of light crosses from one medium into another medium with a different refractive index. The simplest example of an anti-reflective coating is a quarter-wavelength layer, in which the thickness of a monolayer dielectric film is adjusted to be one fourth of the optical wavelength. Although a single-layer coating can reduce the reflectance to zero for light at a specific wavelength and angle of incidence, the reflectance can be substantially larger for other wavelengths. One possible solution is to use a multilayer coating that gives consistently low reflectance over a wider spectral band.' newline  newline 'In this tutorial, light crosses a boundary between two media with different refractive indices at normal incidence. The reflectance of two different multilayer coatings is compared over a wide spectral range: a quarter-quarter coating (two layers), and a quarter-half-quarter coating (three layers). The quarter-half-quarter coating is shown to have more consistently low reflectance across most of the visible spectrum.']);

model.label('antireflective_coating_multilayer.mph');

model.modelNode.label('Components');

out = model;
