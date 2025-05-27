function out = model
%
% czerny_turner_monochromator.m
%
% Model exported on May 26 2025, 21:32 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/Ray_Optics_Module/Spectrometers_and_Monochromators');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 2);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.physics.create('gop', 'GeometricalOptics', 'geom1');
model.physics('gop').model('comp1');

model.study.create('std1');
model.study('std1').create('rtrac', 'RayTracing');
model.study('std1').feature('rtrac').setSolveFor('/physics/gop', true);

model.geom('geom1').insertFile('czerny_turner_monochromator_geom_sequence.mph', 'geom1');
model.geom('geom1').run('fin');

model.param.set('lambda0min', '450[nm]');
model.param.descr('lambda0min', 'Minimum vacuum wavelength');
model.param.set('lambda0max', '850[nm]');
model.param.descr('lambda0max', 'Maximum vacuum wavelength');
model.param.set('N', '3648');
model.param.descr('N', 'Number of pixels');
model.param.set('wp', '8[um]');
model.param.descr('wp', 'Pixel width');
model.param.set('Fnum', '10');
model.param.descr('Fnum', 'F-number');
model.param.set('NA', '1/(2*Fnum)');
model.param.descr('NA', 'Numerical aperture');
model.param.set('Srange', '650[nm]');
model.param.descr('Srange', 'Spectral range');

model.physics('gop').selection.set([]);
model.physics('gop').prop('WavelengthDistribution').setIndex('WavelengthDistribution', 'PolychromaticWavelength', 0);
model.physics('gop').create('relg1', 'ReleaseGrid', -1);
model.physics('gop').feature('relg1').setIndex('x0', -10, 0);
model.physics('gop').feature('relg1').setIndex('x0', 16.16104903340627, 1);
model.physics('gop').feature('relg1').set('RayDirectionVector', 'Conical');
model.physics('gop').feature('relg1').setIndex('Nw', 20, 0);
model.physics('gop').feature('relg1').set('alphac', 'asin(NA)');
model.physics('gop').feature('relg1').set('LDistributionFunction', 'Uniform');
model.physics('gop').feature('relg1').setIndex('lambda0Nval', 20, 0);
model.physics('gop').feature('relg1').set('lambda0min', 'lambda0min');
model.physics('gop').feature('relg1').set('lambda0max', 'lambda0max');
model.physics('gop').create('wall1', 'Wall', 1);
model.physics('gop').feature('wall1').selection.set([8]);
model.physics('gop').create('mir1', 'Mirror', 1);
model.physics('gop').feature('mir1').selection.set([15 16]);
model.physics('gop').create('grat1', 'Grating', 1);
model.physics('gop').feature('grat1').selection.set([3]);
model.physics('gop').feature('grat1').set('dg', '1[mm]/600');
model.physics('gop').feature('grat1').set('RaysToRelease', 'Reflected');
model.physics('gop').feature('grat1').set('DirectionOfPeriodicity', 'Reverse');
model.physics('gop').feature('grat1').feature('dfo1').set('mg', 1);

model.mesh('mesh1').automatic(false);
model.mesh('mesh1').feature('size').set('custom', true);
model.mesh('mesh1').feature('size').set('hmin', 0.002);
model.mesh('mesh1').feature('size').set('hcurve', 0.002);
model.mesh('mesh1').run;

model.variable.create('var1');
model.variable('var1').model('comp1');
model.variable('var1').set('pnum', 'ceil(N/2-(qx-Qdx)/(wp*cos(theta_d)))');
model.variable('var1').descr('pnum', 'Pixel number');
model.variable('var1').set('samefreq', 'abs(gop.nu-dest(gop.nu))<1[Hz]');
model.variable('var1').descr('samefreq', 'Logical expression for rays on the detector with the same frequency');
model.variable('var1').set('distance', 'sqrt((qx-dest(qx))^2+(qy-dest(qy))^2)');
model.variable('var1').descr('distance', 'Distance between the rays');
model.variable('var1').set('distance2', 'gop.max(if(samefreq,distance,0))');
model.variable('var1').descr('distance2', 'Maximum distance to given ray');
model.variable('var1').set('wi', 'gop.max(if(samefreq,distance2,0))');
model.variable('var1').descr('wi', 'Image width of the entrance slit');

model.study('std1').feature('rtrac').set('tlist', 'range(0,0.01,0.8)');

model.sol.create('sol1');
model.sol('sol1').study('std1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'rtrac');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').set('control', 'rtrac');
model.sol('sol1').create('t1', 'Time');
model.sol('sol1').feature('t1').set('tlist', 'range(0,0.01,0.8)');
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
model.result('pg1').setIndex('looplevel', 81, 0);
model.result('pg1').label('Ray Trajectories (gop)');
model.result('pg1').create('rtrj1', 'RayTrajectories');
model.result('pg1').feature('rtrj1').set('linetype', 'line');
model.result('pg1').feature('rtrj1').create('col1', 'Color');
model.result('pg1').feature('rtrj1').feature('col1').set('expr', 't');
model.result('pg1').feature('rtrj1').create('filt1', 'RayTrajectoriesFilter');
model.result('pg1').run;
model.result.dataset.create('rbin1', 'RayBin');
model.result.dataset('rbin1').set('expr', 'gop.lambda0');
model.result.dataset('rbin1').set('descr', 'Vacuum wavelength');
model.result.dataset('rbin1').set('method', 'tolerance');
model.result.dataset('rbin1').set('tolerance', '1[nm]');
model.result('pg1').run;
model.result('pg1').feature('rtrj1').set('linetype', 'tube');
model.result('pg1').feature('rtrj1').set('tuberadiusscaleactive', true);
model.result('pg1').feature('rtrj1').set('tuberadiusscale', 0.025);
model.result('pg1').run;
model.result('pg1').feature('rtrj1').feature('col1').set('expr', 'gop.lambda0');
model.result('pg1').feature('rtrj1').feature('col1').set('descr', 'Vacuum wavelength');
model.result('pg1').feature('rtrj1').feature('col1').set('colortable', 'Spectrum');
model.result('pg1').feature('rtrj1').feature('col1').set('unit', 'nm');
model.result('pg1').run;
model.result.create('pg2', 'PlotGroup1D');
model.result('pg2').run;
model.result('pg2').label('Pixel Number');
model.result('pg2').set('data', 'rbin1');
model.result('pg2').setIndex('looplevelinput', 'last', 0);
model.result('pg2').create('rtp1', 'Ray1D');
model.result('pg2').feature('rtp1').set('markerpos', 'datapoints');
model.result('pg2').feature('rtp1').set('linewidth', 'preference');
model.result('pg2').feature('rtp1').set('expr', 'pnum');
model.result('pg2').feature('rtp1').set('xdata', 'expr');
model.result('pg2').feature('rtp1').set('xdataexpr', 'gop.lambda0');
model.result('pg2').feature('rtp1').set('xdataunit', 'nm');
model.result('pg2').feature('rtp1').set('linemarker', 'circle');
model.result('pg2').run;
model.result.create('pg3', 'PlotGroup1D');
model.result('pg3').run;
model.result('pg3').label('Device Resolution');
model.result('pg3').set('data', 'rbin1');
model.result('pg3').setIndex('looplevelinput', 'last', 0);
model.result('pg3').set('titletype', 'none');
model.result('pg3').create('rtp1', 'Ray1D');
model.result('pg3').feature('rtp1').set('markerpos', 'datapoints');
model.result('pg3').feature('rtp1').set('linewidth', 'preference');
model.result('pg3').feature('rtp1').set('expr', 'Srange/N*wi/wp');
model.result('pg3').feature('rtp1').set('unit', 'nm');
model.result('pg3').feature('rtp1').set('descractive', true);
model.result('pg3').feature('rtp1').set('descr', 'Spectral resolution');
model.result('pg3').feature('rtp1').set('xdata', 'expr');
model.result('pg3').feature('rtp1').set('xdataexpr', 'gop.lambda0');
model.result('pg3').feature('rtp1').set('xdataunit', 'nm');
model.result('pg3').feature('rtp1').set('linemarker', 'circle');
model.result('pg3').run;

model.title(['Czerny' native2unicode(hex2dec({'20' '13'}), 'unicode') 'Turner Monochromator']);

model.description(['A Czerny' native2unicode(hex2dec({'20' '13'}), 'unicode') 'Turner monochromator spatially separates polychromatic light into a series of monochromatic rays. This example simulates a crossed Czerny' native2unicode(hex2dec({'20' '13'}), 'unicode') 'Turner configuration that consists of a spherical collimating mirror, a planar diffraction grating, a spherical imaging mirror, and an array charge coupled device (CCD) detector. The example uses the Geometrical Optics interface to compute the positions of incident rays on the detector plane, from which the device''s resolution can be derived.']);

model.label('czerny_turner_monochromator.mph');

model.modelNode.label('Components');

out = model;
