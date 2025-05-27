function out = model
%
% corner_cube_retroreflector.m
%
% Model exported on May 26 2025, 21:32 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/Ray_Optics_Module/Verification_Examples');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 3);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.physics.create('gop', 'GeometricalOptics', 'geom1');
model.physics('gop').model('comp1');

model.study.create('std1');
model.study('std1').create('rtrac', 'RayTracing');
model.study('std1').feature('rtrac').setSolveFor('/physics/gop', true);

model.geom('geom1').lengthUnit('mm');
model.geom.load({'part1'}, 'Ray_Optics_Module/3D/Retroreflectors/corner_cube_retroreflector_3d.mph', {'part1'});
model.geom('geom1').create('pi1', 'PartInstance');
model.geom('geom1').feature('pi1').set('selkeepnoncontr', false);
model.geom('geom1').feature('pi1').set('part', 'part1');
model.geom('geom1').feature('pi1').setEntry('inputexpr', 'niy', 1);
model.geom('geom1').feature('pi1').setEntry('inputexpr', 'niz', 1);
model.geom('geom1').run;

model.physics('gop').prop('MaximumSecondary').setIndex('MaximumSecondary', 0, 0);
model.physics('gop').feature('mp1').set('n_mat', 'userdef');
model.physics('gop').feature('mp1').set('n', [1.5 0 0 0 1.5 0 0 0 1.5]);
model.physics('gop').create('mir1', 'Mirror', 2);
model.physics('gop').feature('mir1').selection.set([5 6 7]);
model.physics('gop').create('wall1', 'Wall', 2);
model.physics('gop').feature('wall1').selection.set([2]);
model.physics('gop').create('relg1', 'ReleaseGrid', -1);
model.physics('gop').feature('relg1').setIndex('x0', '-22/sqrt(3)', 0);
model.physics('gop').feature('relg1').setIndex('x0', '-22/sqrt(3)-5', 1);
model.physics('gop').feature('relg1').setIndex('x0', '-22/sqrt(3)+5', 2);
model.physics('gop').feature('relg1').set('RayDirectionVector', 'Conical');
model.physics('gop').feature('relg1').setIndex('Nw', 1000, 0);
model.physics('gop').feature('relg1').set('cax', [1 1.3 1]);
model.physics('gop').feature('relg1').set('alphac', 'pi/18');

model.study('std1').feature('rtrac').set('timestepspec', 'specifylength');
model.study('std1').feature('rtrac').set('lunit', 'mm');
model.study('std1').feature('rtrac').set('llist', 'range(0,0.2,70)');

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
model.result('pg1').setIndex('looplevel', 351, 0);
model.result('pg1').label('Ray Trajectories (gop)');
model.result('pg1').create('rtrj1', 'RayTrajectories');
model.result('pg1').feature('rtrj1').set('linetype', 'line');
model.result('pg1').feature('rtrj1').create('col1', 'Color');
model.result('pg1').feature('rtrj1').feature('col1').set('expr', 't');
model.result('pg1').feature('rtrj1').create('filt1', 'RayTrajectoriesFilter');
model.result('pg1').run;
model.result('pg1').run;
model.result('pg1').feature('rtrj1').feature('col1').set('expr', 'gop.pidx');
model.result('pg1').run;
model.result.create('pg2', 'PlotGroup1D');
model.result('pg2').run;
model.result('pg2').label('Acute Angle of Incidence');
model.result('pg2').set('data', 'ray1');
model.result('pg2').setIndex('looplevelinput', 'last', 0);
model.result('pg2').create('rtp1', 'Ray1D');
model.result('pg2').feature('rtp1').set('markerpos', 'datapoints');
model.result('pg2').feature('rtp1').set('linewidth', 'preference');
model.result('pg2').feature('rtp1').set('expr', 'gop.phii');
model.result('pg2').feature('rtp1').set('xdata', 'expr');
model.result('pg2').feature('rtp1').set('xdataexpr', 'at(0,gop.phii)');
model.result('pg2').run;
model.result('pg2').set('titletype', 'none');
model.result('pg2').run;

model.title('Corner Cube Retroreflector');

model.description('A corner cube retroreflector can be used to reflect rays in a direction exactly antiparallel to their initial direction, regardless of the angle of incidence. This tutorial shows how to simulate the reflection of a bundle of rays at a corner cube retroreflector using the Geometrical Optics interface.');

model.mesh.clearMeshes;

model.sol('sol1').clearSolutionData;

model.label('corner_cube_retroreflector.mph');

model.modelNode.label('Components');

out = model;
