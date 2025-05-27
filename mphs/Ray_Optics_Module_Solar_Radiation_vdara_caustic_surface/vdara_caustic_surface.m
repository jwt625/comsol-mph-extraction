function out = model
%
% vdara_caustic_surface.m
%
% Model exported on May 26 2025, 21:32 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/Ray_Optics_Module/Solar_Radiation');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 3);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.physics.create('gop', 'GeometricalOptics', 'geom1');
model.physics('gop').model('comp1');

model.study.create('std1');
model.study('std1').create('rtrac', 'RayTracing');
model.study('std1').feature('rtrac').setSolveFor('/physics/gop', true);

model.geom('geom1').lengthUnit('km');
model.geom('geom1').geomRep('cadps');
model.geom('geom1').create('imp1', 'Import');
model.geom('geom1').feature('imp1').set('filename', 'vdara_caustic_surface.x_b');
model.geom('geom1').feature('imp1').importData;

model.selection.create('box1', 'Box');
model.selection('box1').model('comp1');

model.geom('geom1').run;

model.selection('box1').label('Hotel Surfaces');
model.selection('box1').set('condition', 'inside');
model.selection('box1').set('entitydim', 2);
model.selection('box1').set('xmin', 0.475);
model.selection('box1').set('xmax', 0.52);
model.selection('box1').set('ymin', 0.38);
model.selection('box1').set('ymax', 0.5);
model.selection('box1').set('zmin', 0.01);
model.selection('box1').set('zmax', 0.2);

model.physics('gop').selection.set([]);
model.physics('gop').prop('MaximumSecondary').setIndex('MaximumSecondary', 0, 0);
model.physics('gop').prop('IntensityComputation').setIndex('IntensityComputation', 'ComputeIntensity', 0);
model.physics('gop').prop('StoreRayStatusData').setIndex('StoreRayStatusData', 1, 0);
model.physics('gop').create('ill1', 'IlluminatedSurface', 2);
model.physics('gop').feature('ill1').selection.set([351 356 359]);
model.physics('gop').feature('ill1').set('InitialPosition', 'Density');
model.physics('gop').feature('ill1').setIndex('Nr', 50000, 0);
model.physics('gop').feature('ill1').set('IncidentRayDirectionVector', 'SolarRadiation');
model.physics('gop').feature('ill1').set('LocationDefinedBy', 'City');
model.physics('gop').feature('ill1').set('Date', {'01' '9' '2014'});
model.physics('gop').feature('ill1').set('LocalTime', [11 45 0]);
model.physics('gop').create('wall1', 'Wall', 2);
model.physics('gop').feature('wall1').selection.set([321 331 345]);
model.physics('gop').feature('wall1').create('bacc1', 'BoundaryAccumulator', 2);
model.physics('gop').feature('wall1').feature('bacc1').set('AccumulateOver', 'RaysInBoundaryElements');
model.physics('gop').feature('wall1').feature('bacc1').set('R', 'gop.logI');
model.physics('gop').feature('wall1').feature('bacc1').set('CustomDependentVariableUnit', '1');
model.physics('gop').feature('wall1').feature('bacc1').set('DependentVariableQuantity', 'none');
model.physics('gop').feature('wall1').feature('bacc1').setIndex('CustomDependentVariableUnit', 'm^-2', 0, 0);
model.physics('gop').create('wall2', 'Wall', 2);
model.physics('gop').feature('wall2').selection.named('box1');
model.physics('gop').feature('wall2').set('WallCondition', 'SpecularReflection');

model.mesh('mesh1').autoMeshSize(1);
model.mesh('mesh1').run;

model.study('std1').feature('rtrac').set('timestepspec', 'specifylength');
model.study('std1').feature('rtrac').set('llist', 'range(0,10,200)');

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
model.result('pg1').setIndex('looplevel', 21, 0);
model.result('pg1').label('Ray Trajectories (gop)');
model.result('pg1').create('rtrj1', 'RayTrajectories');
model.result('pg1').feature('rtrj1').set('linetype', 'line');
model.result('pg1').feature('rtrj1').set('extrasteps', 'none');
model.result('pg1').feature('rtrj1').create('col1', 'Color');
model.result('pg1').feature('rtrj1').feature('col1').set('expr', 'gop.I');
model.result('pg1').feature('rtrj1').create('filt1', 'RayTrajectoriesFilter');
model.result.dataset.create('grid1', 'Grid3D');
model.result.dataset('grid1').set('source', 'data');
model.result.dataset('grid1').set('data', 'dset1');
model.result.dataset('grid1').set('parmin1', 0.11538037905865195);
model.result.dataset('grid1').set('parmax1', 0.4615950947646629);
model.result.dataset('grid1').set('res1', 3);
model.result.dataset('grid1').set('parmin2', 0.11487941492843083);
model.result.dataset('grid1').set('parmax2', 0.47451839772521454);
model.result.dataset('grid1').set('res2', 3);
model.result.dataset('grid1').set('parmin3', 0.03657996);
model.result.dataset('grid1').set('parmax3', 0.14631999);
model.result.dataset('grid1').set('res3', 3);
model.result.dataset.create('cpt1', 'CutPoint3D');
model.result.dataset('cpt1').set('data', 'grid1');
model.result.dataset('cpt1').set('method', 'regulargrid');
model.result.dataset('cpt1').set('regulargridx', 3);
model.result.dataset('cpt1').set('regulargridy', 3);
model.result.dataset('cpt1').set('regulargridz', 3);
model.result('pg1').create('arpt1', 'ArrowPoint');
model.result('pg1').feature('arpt1').set('data', 'cpt1');
model.result('pg1').feature('arpt1').set('expr', {'gop.ill1.nsolx' 'gop.ill1.nsoly' 'gop.ill1.nsolz'});
model.result('pg1').run;
model.result('pg1').set('titletype', 'manual');
model.result('pg1').set('title', 'Reflected Rays and Ambient Solar Radiation');
model.result.dataset('grid1').set('parmin1', 0.4);
model.result.dataset('grid1').set('parmax1', 0.48);
model.result.dataset('grid1').set('parmin2', 0.4);
model.result.dataset('grid1').set('parmax2', 0.48);
model.result.dataset('grid1').set('parmin3', 0.05);
model.result.dataset('grid1').set('parmax3', 0.15);
model.result('pg1').run;
model.result('pg1').feature('rtrj1').feature('col1').set('expr', 'gop.logI');
model.result('pg1').feature('rtrj1').feature('col1').set('descr', 'Log of intensity');
model.result('pg1').run;
model.result('pg1').feature('rtrj1').feature('filt1').set('type', 'logical');
model.result('pg1').feature('rtrj1').feature('filt1').set('logicalexpr', 'gop.fs==2');
model.result('pg1').run;
model.result('pg1').create('surf1', 'Surface');
model.result('pg1').feature('surf1').set('coloring', 'uniform');
model.result('pg1').feature('surf1').set('color', 'gray');
model.result('pg1').run;
model.result.create('pg2', 'PlotGroup3D');
model.result('pg2').run;
model.result('pg2').label('Caustic Surface in Pool Area');
model.result('pg2').set('titletype', 'manual');
model.result('pg2').set('title', 'Caustic Surface in Pool Area');
model.result('pg2').create('surf1', 'Surface');
model.result('pg2').feature('surf1').set('expr', 'gop.wall1.bacc1.rpb');
model.result('pg2').feature('surf1').set('descr', 'Accumulated variable rpb');
model.result('pg2').feature('surf1').set('smooth', 'everywhere');
model.result('pg2').feature('surf1').set('resolution', 'norefine');
model.result('pg2').feature('surf1').set('colortable', 'ThermalDark');
model.result('pg2').run;
model.result('pg2').create('surf2', 'Surface');
model.result('pg2').feature('surf2').set('titletype', 'none');
model.result('pg2').feature('surf2').set('coloring', 'uniform');
model.result('pg2').feature('surf2').set('color', 'gray');
model.result('pg2').feature('surf2').create('sel1', 'Selection');
model.result('pg2').feature('surf2').feature('sel1').selection.named('box1');
model.result('pg2').run;

model.title(['Vdara' native2unicode(hex2dec({'00' 'ae'}), 'unicode') ' Caustic Surface']);

model.description(['When the Vdara' native2unicode(hex2dec({'00' 'ae'}), 'unicode') ' hotel first opened in Las Vegas, visitors relaxing by the pool would experience intense periods of heat at certain times of the day, at certain times of the year. This intense heat was caused by the reflection of solar radiation from the curved, reflective surface on the south-facing side of the hotel. This example shows how a caustic surface is generated in the pool area around the time and date the problems were first reported.']);

model.mesh.clearMeshes;

model.sol('sol1').clearSolutionData;

model.label('vdara_caustic_surface.mph');

model.modelNode.label('Components');

out = model;
