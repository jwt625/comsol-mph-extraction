function out = model
%
% achromatic_phase_shifter.m
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

% To import content from file, use:
% model.param.loadFile('FILENAME');
model.param.set('lam0', '600[nm]', 'Free-space wavelength');
model.param.set('np', '1.509', 'Prism refractive index');
model.param.set('nf1', '2.0535', 'Refractive index, layer 1');
model.param.set('nf2', '1.496', 'Refractive index, layer 2');
model.param.set('nf3', '1.664', 'Refractive index, layer 3');
model.param.set('nf4', '2.346', 'Refractive index, layer 4');
model.param.set('tf1', '0.089*lam0', 'Thickness, layer 1');
model.param.set('tf2', '0.3856*lam0', 'Thickness, layer 2');
model.param.set('tf3', '0.111*lam0', 'Thickness, layer 3');
model.param.set('tf4', '0.0447*lam0', 'Thickness, layer 4');

model.geom('geom1').create('wp1', 'WorkPlane');
model.geom('geom1').feature('wp1').set('unite', true);
model.geom('geom1').feature('wp1').geom.create('pol1', 'Polygon');
model.geom('geom1').feature('wp1').geom.feature('pol1').set('source', 'table');
model.geom('geom1').feature('wp1').geom.feature('pol1').setIndex('table', 0, 0, 0);
model.geom('geom1').feature('wp1').geom.feature('pol1').setIndex('table', 0, 0, 1);
model.geom('geom1').feature('wp1').geom.feature('pol1').setIndex('table', 1, 1, 0);
model.geom('geom1').feature('wp1').geom.feature('pol1').setIndex('table', 1, 1, 1);
model.geom('geom1').feature('wp1').geom.feature('pol1').setIndex('table', 0, 2, 0);
model.geom('geom1').feature('wp1').geom.feature('pol1').setIndex('table', 1, 2, 1);
model.geom('geom1').feature('wp1').geom.run('pol1');
model.geom('geom1').run('wp1');
model.geom('geom1').feature.create('ext1', 'Extrude');
model.geom('geom1').feature('ext1').set('workplane', 'wp1');
model.geom('geom1').feature('ext1').selection('input').set({'wp1'});
model.geom('geom1').run('ext1');
model.geom('geom1').run;

model.material.create('mat1', 'Common', 'comp1');
model.material('mat1').propertyGroup.create('RefractiveIndex', 'Refractive_index');
model.material('mat1').propertyGroup('RefractiveIndex').set('n', {'np'});

model.physics('gop').prop('WavelengthDistribution').setIndex('WavelengthDistribution', 'PolychromaticWavelength', 0);
model.physics('gop').prop('MaximumSecondary').setIndex('MaximumSecondary', 0, 0);
model.physics('gop').prop('IntensityComputation').setIndex('IntensityComputation', 'ComputeIntensity', 0);
model.physics('gop').create('relg1', 'ReleaseGrid', -1);
model.physics('gop').feature('relg1').setIndex('x0', 0.2, 0);
model.physics('gop').feature('relg1').setIndex('x0', 0.5, 1);
model.physics('gop').feature('relg1').setIndex('x0', 0.5, 2);
model.physics('gop').feature('relg1').set('L0', [1 0 0]);
model.physics('gop').feature('relg1').set('LDistributionFunction', 'ListOfValues');
model.physics('gop').feature('relg1').setIndex('lambda0vals', 'range(lam0/0.8,(lam0/1.3-(lam0/0.8))/99,lam0/1.3)', 0);
model.physics('gop').feature('relg1').set('InitialPolarizationType', 'FullyPolarized');
model.physics('gop').feature('relg1').set('InitialPolarization', 'UserDefined');
model.physics('gop').feature('relg1').set('a20', 1);
model.physics('gop').create('matd2', 'MaterialDiscontinuity', 2);
model.physics('gop').feature('matd2').selection.set([2]);
model.physics('gop').feature('matd2').label('Single-layer Coating');
model.physics('gop').feature('matd2').set('ThinDielectricFilmsOnBoundary', 'AddLayersToSurface');
model.physics('gop').feature('matd2').create('film1', 'ThinDielectricFilm', 2);
model.physics('gop').feature('matd2').feature('film1').set('nf', 'nf1');
model.physics('gop').feature('matd2').feature('film1').set('tf', 'tf1');
model.physics('gop').create('matd3', 'MaterialDiscontinuity', 2);
model.physics('gop').feature('matd3').selection.set([2]);
model.physics('gop').feature('matd3').label('Triple-layer Coating');
model.physics('gop').feature('matd3').set('ThinDielectricFilmsOnBoundary', 'AddLayersToSurface');
model.physics('gop').feature('matd3').create('film1', 'ThinDielectricFilm', 2);
model.physics('gop').feature('matd3').feature('film1').set('nf', 'nf2');
model.physics('gop').feature('matd3').feature('film1').set('tf', 'tf2');
model.physics('gop').feature('matd3').create('film2', 'ThinDielectricFilm', 2);
model.physics('gop').feature('matd3').feature('film2').set('nf', 'nf3');
model.physics('gop').feature('matd3').feature('film2').set('tf', 'tf3');
model.physics('gop').feature('matd3').create('film3', 'ThinDielectricFilm', 2);
model.physics('gop').feature('matd3').feature('film3').set('nf', 'nf4');
model.physics('gop').feature('matd3').feature('film3').set('tf', 'tf4');

model.study('std1').feature('rtrac').set('timestepspec', 'specifylength');
model.study('std1').feature('rtrac').set('llist', '0 0.6');
model.study('std1').feature('rtrac').set('useadvanceddisable', true);
model.study('std1').feature('rtrac').set('disabledphysics', {'gop/matd3'});

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
model.result.dataset('ray1').set('posdof', {'comp1.qx' 'comp1.qy' 'comp1.qz'});
model.result.dataset('ray1').set('geom', 'geom1');
model.result.dataset('ray1').set('rgeom', 'pgeom_gop');
model.result.dataset('ray1').set('rgeomspec', 'fromphysics');
model.result.dataset('ray1').set('physicsinterface', 'gop');
model.result.create('pg1', 'PlotGroup3D');
model.result('pg1').set('data', 'ray1');
model.result('pg1').setIndex('looplevel', 2, 0);
model.result('pg1').label('Ray Trajectories (gop)');
model.result('pg1').create('rtrj1', 'RayTrajectories');
model.result('pg1').feature('rtrj1').set('linetype', 'line');
model.result('pg1').feature('rtrj1').create('col1', 'Color');
model.result('pg1').feature('rtrj1').feature('col1').set('expr', 'gop.I');
model.result('pg1').feature('rtrj1').create('filt1', 'RayTrajectoriesFilter');
model.result('pg1').run;
model.result('pg1').label('Polarization Ellipses, Single-layer Coating');
model.result('pg1').run;
model.result('pg1').feature('rtrj1').set('pointtype', 'ellipse');
model.result('pg1').run;
model.result('pg1').feature('rtrj1').feature('col1').set('expr', 'gop.s3/gop.s0');
model.result('pg1').run;
model.result.create('pg2', 'PlotGroup1D');
model.result('pg2').run;
model.result('pg2').label('Phase Retardation vs. Wavelength');
model.result('pg2').set('data', 'ray1');
model.result('pg2').setIndex('looplevelinput', 'last', 0);
model.result('pg2').set('titletype', 'manual');
model.result('pg2').set('title', 'Phase Retardation for Single- and Triple-layer Films');
model.result('pg2').set('xlabelactive', true);
model.result('pg2').set('xlabel', '\lambda<sub>0</sub>/\lambda');
model.result('pg2').set('ylabelactive', true);
model.result('pg2').set('ylabel', 'Phase Retardation (deg)');
model.result('pg2').set('legendpos', 'upperleft');
model.result('pg2').create('rtp1', 'Ray1D');
model.result('pg2').feature('rtp1').set('markerpos', 'datapoints');
model.result('pg2').feature('rtp1').set('linewidth', 'preference');
model.result('pg2').feature('rtp1').set('expr', 'gop.delta');
model.result('pg2').feature('rtp1').set('unit', [native2unicode(hex2dec({'00' 'b0'}), 'unicode') ]);
model.result('pg2').feature('rtp1').set('xdata', 'expr');
model.result('pg2').feature('rtp1').set('xdataexpr', 'lam0/gop.lambda0');
model.result('pg2').feature('rtp1').set('legend', true);
model.result('pg2').feature('rtp1').set('legendmethod', 'manual');
model.result('pg2').feature('rtp1').setIndex('legends', 'Single-layer coating', 0);
model.result('pg2').run;

model.study.create('std2');
model.study('std2').create('rtrac', 'RayTracing');
model.study('std2').feature('rtrac').setSolveFor('/physics/gop', true);
model.study('std2').feature('rtrac').set('timestepspec', 'specifylength');
model.study('std2').feature('rtrac').set('llist', '0 0.6');
model.study('std2').feature('rtrac').set('useadvanceddisable', true);
model.study('std2').feature('rtrac').set('disabledphysics', {'gop/matd2'});

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
model.result.dataset('ray2').set('posdof', {'comp1.qx' 'comp1.qy' 'comp1.qz'});
model.result.dataset('ray2').set('geom', 'geom1');
model.result.dataset('ray2').set('rgeom', 'pgeom_gop');
model.result.dataset('ray2').set('rgeomspec', 'fromphysics');
model.result.dataset('ray2').set('physicsinterface', 'gop');
model.result.create('pg3', 'PlotGroup3D');
model.result('pg3').set('data', 'ray2');
model.result('pg3').setIndex('looplevel', 2, 0);
model.result('pg3').label('Ray Trajectories (gop)');
model.result('pg3').create('rtrj1', 'RayTrajectories');
model.result('pg3').feature('rtrj1').set('linetype', 'line');
model.result('pg3').feature('rtrj1').create('col1', 'Color');
model.result('pg3').feature('rtrj1').feature('col1').set('expr', 'gop.I');
model.result('pg3').feature('rtrj1').create('filt1', 'RayTrajectoriesFilter');
model.result('pg3').run;
model.result('pg3').label('Polarization Ellipses, Triple-layer Coating');
model.result('pg3').run;
model.result('pg3').feature('rtrj1').set('pointtype', 'ellipse');
model.result('pg3').run;
model.result('pg3').feature('rtrj1').feature('col1').set('expr', 'gop.s3/gop.s0');
model.result('pg3').run;
model.result('pg2').run;
model.result('pg2').feature.duplicate('rtp2', 'rtp1');
model.result('pg2').run;
model.result('pg2').feature('rtp2').set('data', 'ray2');
model.result('pg2').feature('rtp2').setIndex('looplevelinput', 'last', 0);
model.result('pg2').feature('rtp2').setIndex('legends', 'Triple-layer coating', 0);
model.result('pg2').run;

model.title('Total Internal Reflection Thin-Film Achromatic Phase Shifter (TIRTF APS)');

model.description(['The capability to alter the polarization of light is crucial to a wide variety of optical devices. For example, the polarization of light has a significant effect on the performance of optical isolators, attenuators, and beam splitters. By assigning a specific polarization to light, most notably linear or circular polarization, it is possible to substantially reduce glare in optical systems.' newline  newline 'One of the most fundamental methods of manipulating polarization is wave retardation in which one component of the electric field is subjected to a phase delay, or retarded, relative to the orthogonal electric field component in a propagating beam of light. Phase retardation can occur when light is subjected to total internal reflection (TIR) at a surface. The phase difference between electric field components is affected by the presence of thin dielectric films on the reflecting surface.' newline  newline 'In this benchmark model, phase retardation angles for single- and triple-layer coatings are computed and compared against published results. This principle can be used to design a total internal reflection thin-film achromatic phase shifter (TIRTF APS) with nearly uniform phase retardation over a wide spectral range.']);

model.mesh.clearMeshes;

model.sol('sol1').clearSolutionData;
model.sol('sol2').clearSolutionData;

model.label('achromatic_phase_shifter.mph');

model.modelNode.label('Components');

out = model;
