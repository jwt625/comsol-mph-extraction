function out = model
%
% distributed_bragg_reflector.m
%
% Model exported on May 26 2025, 21:32 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/Ray_Optics_Module/Prisms_and_Coatings');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 3);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.physics.create('gop', 'GeometricalOptics', 'geom1');
model.physics('gop').model('comp1');

model.study.create('std1');
model.study('std1').create('rtrac', 'RayTracing');
model.study('std1').feature('rtrac').setSolveFor('/physics/gop', true);

model.param.set('ns', '1.5');
model.param.descr('ns', 'Refractive index of substrate');
model.param.set('nh', '2.32');
model.param.descr('nh', 'Refractive index of ZnS');
model.param.set('nl', '1.38');
model.param.descr('nl', 'Refractive index of MgF2');
model.param.set('lam0', '550[nm]');
model.param.descr('lam0', 'Vacuum wavelength');
model.param.set('Nc', '2');
model.param.descr('Nc', 'Number of unit cells');

model.geom('geom1').lengthUnit('mm');
model.geom('geom1').create('cyl1', 'Cylinder');
model.geom('geom1').feature('cyl1').set('r', 10);
model.geom('geom1').feature('cyl1').set('h', 5);
model.geom('geom1').runPre('fin');
model.geom('geom1').run;

model.physics('gop').prop('IntensityComputation').setIndex('IntensityComputation', 'ComputeIntensity', 0);
model.physics('gop').prop('WavelengthDistribution').setIndex('WavelengthDistribution', 'PolychromaticWavelength', 0);
model.physics('gop').prop('MaximumSecondary').setIndex('MaximumSecondary', 0, 0);

model.material.create('mat1', 'Common', 'comp1');
model.material('mat1').propertyGroup.create('RefractiveIndex', 'Refractive_index');
model.material('mat1').propertyGroup('RefractiveIndex').set('n', {'ns'});

model.physics('gop').feature('matd1').set('ThinDielectricFilmsOnBoundary', 'AddLayersToSurfaceRepeating');
model.physics('gop').feature('matd1').set('Nft', 'Nc');
model.physics('gop').feature('matd1').set('ReleaseReflectedRays', 'Never');

model.view('view1').set('renderwireframe', true);

model.physics('gop').feature('matd1').set('ShowBoundaryNormal', true);
model.physics('gop').feature('matd1').create('film1', 'ThinDielectricFilm', 2);
model.physics('gop').feature('matd1').feature('film1').set('nf', 'nh');
model.physics('gop').feature('matd1').feature('film1').set('tf', 'lam0/(4*nh)');
model.physics('gop').feature('matd1').create('film2', 'ThinDielectricFilm', 2);
model.physics('gop').feature('matd1').feature('film2').set('nf', 'nl');
model.physics('gop').feature('matd1').feature('film2').set('tf', 'lam0/(4*nl)');
model.physics('gop').feature('matd1').feature.duplicate('film3', 'film1');
model.physics('gop').feature('matd1').feature('film1').set('RepeatLayerInMultilayerFilms', false);
model.physics('gop').create('relg1', 'ReleaseGrid', -1);
model.physics('gop').feature('relg1').setIndex('x0', 10, 2);
model.physics('gop').feature('relg1').set('L0', [0 0 -1]);
model.physics('gop').feature('relg1').set('LDistributionFunction', 'ListOfValues');
model.physics('gop').feature('relg1').setIndex('lambda0vals', 'range(400[nm],(800[nm]-(400[nm]))/999,800[nm])', 0);

model.study('std1').create('param', 'Parametric');
model.study('std1').feature('param').setIndex('pname', 'ns', 0);
model.study('std1').feature('param').setIndex('plistarr', '', 0);
model.study('std1').feature('param').setIndex('punit', '', 0);
model.study('std1').feature('param').setIndex('pname', 'ns', 0);
model.study('std1').feature('param').setIndex('plistarr', '', 0);
model.study('std1').feature('param').setIndex('punit', '', 0);
model.study('std1').feature('param').setIndex('pname', 'Nc', 0);
model.study('std1').feature('param').setIndex('plistarr', '2 5 10 20', 0);
model.study('std1').feature('rtrac').set('tlist', '0 0.025');

model.sol.create('sol1');
model.sol('sol1').study('std1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'rtrac');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').set('control', 'rtrac');
model.sol('sol1').create('t1', 'Time');
model.sol('sol1').feature('t1').set('tlist', '0 0.025');
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

model.batch.create('p1', 'Parametric');
model.batch('p1').study('std1');
model.batch('p1').create('so1', 'Solutionseq');
model.batch('p1').feature('so1').set('seq', 'sol1');
model.batch('p1').feature('so1').set('store', 'on');
model.batch('p1').feature('so1').set('clear', 'on');
model.batch('p1').feature('so1').set('psol', 'none');
model.batch('p1').set('pname', {'Nc'});
model.batch('p1').set('plistarr', {'2 5 10 20'});
model.batch('p1').set('sweeptype', 'sparse');
model.batch('p1').set('probesel', 'all');
model.batch('p1').set('probes', {});
model.batch('p1').set('plot', 'off');
model.batch('p1').set('err', 'on');
model.batch('p1').attach('std1');
model.batch('p1').set('control', 'param');

model.sol.create('sol2');
model.sol('sol2').study('std1');
model.sol('sol2').label('Parametric Solutions 1');

model.batch('p1').feature('so1').set('psol', 'sol2');
model.batch('p1').run('compute');

model.result.dataset.create('ray1', 'Ray');
model.result.dataset('ray1').set('solution', 'sol2');
model.result.dataset('ray1').set('posdof', {'comp1.qx' 'comp1.qy' 'comp1.qz'});
model.result.dataset('ray1').set('geom', 'geom1');
model.result.dataset('ray1').set('rgeom', 'pgeom_gop');
model.result.dataset('ray1').set('rgeomspec', 'fromphysics');
model.result.dataset('ray1').set('physicsinterface', 'gop');
model.result.create('pg1', 'PlotGroup3D');
model.result('pg1').set('data', 'ray1');
model.result('pg1').setIndex('looplevel', 2, 0);
model.result('pg1').setIndex('looplevel', 4, 1);
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
model.result('pg2').set('titletype', 'none');
model.result('pg2').set('xlabelactive', true);
model.result('pg2').set('xlabel', 'Vacuum wavelength (nm)');
model.result('pg2').set('ylabelactive', true);
model.result('pg2').set('ylabel', 'Reflectance (%)');
model.result('pg2').create('rtp1', 'Ray1D');
model.result('pg2').feature('rtp1').set('markerpos', 'datapoints');
model.result('pg2').feature('rtp1').set('linewidth', 'preference');
model.result('pg2').feature('rtp1').set('expr', '100*(gop.relg1.I0-gop.I)/gop.relg1.I0');
model.result('pg2').feature('rtp1').set('xdata', 'expr');
model.result('pg2').feature('rtp1').set('xdataexpr', 'gop.lambda0');
model.result('pg2').feature('rtp1').set('xdataunit', 'nm');
model.result('pg2').feature('rtp1').set('legend', true);
model.result('pg2').feature('rtp1').set('legendmethod', 'evaluated');
model.result('pg2').feature('rtp1').set('legendpattern', 'eval(2*Nc+1) layers');
model.result('pg2').run;

model.title('Distributed Bragg Reflector');

model.description(['A distributed Bragg reflector (DBR) is a periodic structure formed from alternating dielectric layers that can be used to achieve nearly total reflection within a range of frequencies, with minimal losses. In this tutorial a Bragg reflector is modeled with a central wavelength of 550' native2unicode(hex2dec({'00' 'a0'}), 'unicode') 'nm and stopband of 180' native2unicode(hex2dec({'00' 'a0'}), 'unicode') 'nm.']);

model.label('distributed_bragg_reflector.mph');

model.modelNode.label('Components');

out = model;
