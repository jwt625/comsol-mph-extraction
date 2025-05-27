function out = model
%
% two_mirror_laser_cavity.m
%
% Model exported on May 26 2025, 21:32 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/Ray_Optics_Module/Laser_Cavities');

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
model.param.set('R', '1[m]', 'Radius of curvature');
model.param.set('L', '0.2[m]', 'Cavity length');
model.param.set('D', '25[mm]', 'Mirror diameter');
model.param.set('T0', '1[us]', 'Total computation time');
model.param.set('th', '1e-3[deg]', 'Initial ray angle');

model.func.create('rect1', 'Rectangle');
model.func('rect1').model('comp1');
model.func('rect1').set('lower', 0);
model.func('rect1').set('upper', '2*R');
model.func('rect1').set('smooth', 0.001);

model.geom.load({'part1'}, 'Ray_Optics_Module/3D/Mirrors/spherical_mirror_3d.mph', {'part1'});
model.geom('geom1').create('pi1', 'PartInstance');
model.geom('geom1').feature('pi1').set('selkeepnoncontr', false);
model.geom('geom1').feature('pi1').set('part', 'part1');
model.geom('geom1').feature('pi1').setEntry('inputexpr', 'R', '-R');
model.geom('geom1').feature('pi1').setEntry('inputexpr', 'Tc', '12[mm]');
model.geom('geom1').feature('pi1').setEntry('inputexpr', 'd0', 'D');
model.geom('geom1').feature('pi1').setEntry('inputexpr', 'd1', 0);
model.geom('geom1').feature('pi1').setEntry('inputexpr', 'd_clear', 0);
model.geom('geom1').feature('pi1').setEntry('inputexpr', 'd_hole', 0);
model.geom('geom1').feature('pi1').setEntry('inputexpr', 'nix', 0);
model.geom('geom1').feature('pi1').setEntry('inputexpr', 'niy', 0);
model.geom('geom1').feature('pi1').setEntry('inputexpr', 'niz', -1);
model.geom('geom1').feature('pi1').setEntry('inputexpr', 'n_extra_r', 0);
model.geom('geom1').feature('pi1').setEntry('inputexpr', 'n_extra_a', 0);
model.geom('geom1').selection.create('csel1', 'CumulativeSelection');
model.geom('geom1').selection('csel1').label('Mirrors');
model.geom('geom1').feature('pi1').setEntry('selcontributetobnd', 'pi1_cylsel1', 'csel1');
model.geom('geom1').feature.duplicate('pi2', 'pi1');
model.geom('geom1').feature('pi1').set('selcontributetoobj', {});
model.geom('geom1').feature('pi1').set('selkeepobj', {});
model.geom('geom1').feature('pi1').set('selcontributetopnt', {'none'});
model.geom('geom1').feature('pi1').set('selkeeppnt', {'off'});
model.geom('geom1').feature('pi1').set('selshowpnt', {'on'});
model.geom('geom1').feature('pi1').set('selcontributetoedg', {});
model.geom('geom1').feature('pi1').set('selkeepedg', {});
model.geom('geom1').feature('pi1').set('selshowedg', {});
model.geom('geom1').feature('pi1').set('selcontributetobnd', {'none' 'csel1' 'none' 'none' 'none'});
model.geom('geom1').feature('pi1').set('selkeepbnd', {'off' 'off' 'off' 'off' 'off'});
model.geom('geom1').feature('pi1').set('selshowbnd', {'on' 'on' 'on' 'on' 'on'});
model.geom('geom1').feature('pi1').set('selcontributetodom', {'none'});
model.geom('geom1').feature('pi1').set('selkeepdom', {'off'});
model.geom('geom1').feature('pi1').set('selshowdom', {'on'});
model.geom('geom1').feature('pi2').setEntry('inputexpr', 'niz', 1);
model.geom('geom1').feature('pi2').set('displ', {'0' '0' 'L'});
model.geom('geom1').feature('pi2').setEntry('selcontributetobnd', 'pi2_cylsel1', 'csel1');
model.geom('geom1').runPre('fin');
model.geom('geom1').run;

model.physics('gop').selection.set([]);
model.physics('gop').prop('MaximumSecondary').setIndex('MaximumSecondary', 0, 0);
model.physics('gop').create('mir1', 'Mirror', 2);
model.physics('gop').feature('mir1').selection.named('geom1_csel1_bnd');
model.physics('gop').create('relg1', 'ReleaseGrid', -1);
model.physics('gop').feature('relg1').set('L0', {'sin(th)' '0' 'cos(th)'});
model.physics('gop').create('rt1', 'RayTermination', -1);
model.physics('gop').feature('rt1').set('SpatialExtentsOfRayPropagation', 'BoundingBoxFromGeometry');

model.mesh('mesh1').autoMeshSize(3);
model.mesh('mesh1').automatic(false);
model.mesh('mesh1').feature('size').set('hmax', 'D/20');
model.mesh('mesh1').run;

model.study('std1').create('param', 'Parametric');
model.study('std1').feature('param').setIndex('pname', 'R', 0);
model.study('std1').feature('param').setIndex('plistarr', '', 0);
model.study('std1').feature('param').setIndex('punit', 'm', 0);
model.study('std1').feature('param').setIndex('pname', 'R', 0);
model.study('std1').feature('param').setIndex('plistarr', '', 0);
model.study('std1').feature('param').setIndex('punit', 'm', 0);
model.study('std1').feature('param').setIndex('pname', 'L', 0);
model.study('std1').feature('param').setIndex('plistarr', 'range(0.2,0.2,2.4)', 0);
model.study('std1').feature('rtrac').set('tlist', '0 T0');
model.study('std1').feature('rtrac').set('raystopcond', 'noactive');

model.sol.create('sol1');
model.sol('sol1').study('std1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'rtrac');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').set('control', 'rtrac');
model.sol('sol1').create('t1', 'Time');
model.sol('sol1').feature('t1').set('tlist', '0 T0');
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
model.batch('p1').set('pname', {'L'});
model.batch('p1').set('plistarr', {'range(0.2,0.2,2.4)'});
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
model.result('pg1').label('Ray Trajectories (gop)');
model.result('pg1').create('rtrj1', 'RayTrajectories');
model.result('pg1').feature('rtrj1').set('linetype', 'line');
model.result('pg1').feature('rtrj1').create('col1', 'Color');
model.result('pg1').feature('rtrj1').feature('col1').set('expr', 't');
model.result('pg1').feature('rtrj1').create('filt1', 'RayTrajectoriesFilter');
model.result('pg1').run;
model.result('pg1').set('outersolnum', 1);
model.result('pg1').set('titletype', 'manual');
model.result('pg1').set('title', 'Ray trajectory, L=0.2');
model.result('pg1').create('surf1', 'Surface');
model.result('pg1').feature('surf1').set('coloring', 'uniform');
model.result('pg1').feature('surf1').set('color', 'cyan');
model.result('pg1').run;
model.result('pg1').run;
model.result('pg1').feature('rtrj1').feature('col1').set('colorlegend', false);
model.result('pg1').run;

model.view('view1').camera.set('zoomanglefull', 10);
model.view('view1').camera.setIndex('position', -0.5, 0);
model.view('view1').camera.setIndex('position', 0.8, 1);
model.view('view1').camera.set('position', [-0.5 0.8 -0.6]);
model.view('view1').camera.set('target', [0 0 0.1]);
model.view('view1').camera.setIndex('up', 0.5, 0);
model.view('view1').camera.setIndex('up', 0.7, 1);
model.view('view1').camera.set('up', [0.5 0.7 0.4]);
model.view('view1').camera.set('rotationpoint', [0 0 0.1]);
model.view('view1').camera.setIndex('viewoffset', 0, 0);
model.view('view1').camera.set('viewoffset', [0 0]);
model.view('view1').set('showgrid', false);

model.result.create('pg2', 'PlotGroup1D');
model.result('pg2').run;
model.result('pg2').set('data', 'ray1');
model.result('pg2').set('innerinput', 'last');
model.result('pg2').set('ylabelactive', true);
model.result('pg2').set('ylabel', 'Stability');
model.result('pg2').set('titletype', 'manual');
model.result('pg2').set('title', 'Laser Cavity Stability Analysis');
model.result('pg2').set('legendpos', 'lowerleft');
model.result('pg2').create('glob1', 'Global');
model.result('pg2').feature('glob1').set('markerpos', 'datapoints');
model.result('pg2').feature('glob1').set('linewidth', 'preference');
model.result('pg2').feature('glob1').setIndex('expr', 't/T0', 0);
model.result('pg2').feature('glob1').setIndex('unit', 1, 0);
model.result('pg2').feature('glob1').setIndex('descr', 'Ray tracing', 0);
model.result('pg2').feature('glob1').set('xdatasolnumtype', 'all');
model.result('pg2').feature('glob1').set('xdata', 'expr');
model.result('pg2').feature('glob1').set('xdataexpr', 'L');
model.result('pg2').feature('glob1').set('linestyle', 'none');
model.result('pg2').feature('glob1').set('linecolor', 'blue');
model.result('pg2').feature('glob1').set('linemarker', 'diamond');
model.result('pg2').feature('glob1').set('legendmethod', 'manual');
model.result('pg2').feature('glob1').setIndex('legends', 'Ray tracing', 0);
model.result('pg2').run;
model.result('pg2').create('glob2', 'Global');
model.result('pg2').feature('glob2').set('markerpos', 'datapoints');
model.result('pg2').feature('glob2').set('linewidth', 'preference');
model.result('pg2').feature('glob2').setIndex('expr', 'rect1(L)', 0);
model.result('pg2').feature('glob2').setIndex('unit', 1, 0);
model.result('pg2').feature('glob2').setIndex('descr', 'ABCD theory', 0);
model.result('pg2').feature('glob2').set('xdatasolnumtype', 'all');
model.result('pg2').feature('glob2').set('xdata', 'expr');
model.result('pg2').feature('glob2').set('xdataexpr', 'L');
model.result('pg2').feature('glob2').set('linestyle', 'dashed');
model.result('pg2').feature('glob2').set('linecolor', 'red');
model.result('pg2').feature('glob2').set('legendmethod', 'manual');
model.result('pg2').feature('glob2').setIndex('legends', 'ABCD theory', 0);
model.result('pg2').run;

model.title('Two-Mirror Laser Cavity');

model.description('This is an example of a simple laser cavity consisting of two spherical mirrors. A ray, initially released at a small angle relative to the optical axis, is traced over a large number of reflections to determine whether it remains confined within the cavity. The study is repeated for several cavity sizes and the stability analysis is then compared to ABCD matrix theory.');

model.mesh.clearMeshes;

model.sol('sol1').clearSolutionData;
model.sol('sol2').clearSolutionData;
model.sol('sol3').clearSolutionData;
model.sol('sol4').clearSolutionData;
model.sol('sol5').clearSolutionData;
model.sol('sol6').clearSolutionData;
model.sol('sol7').clearSolutionData;
model.sol('sol8').clearSolutionData;
model.sol('sol9').clearSolutionData;
model.sol('sol10').clearSolutionData;
model.sol('sol11').clearSolutionData;
model.sol('sol12').clearSolutionData;
model.sol('sol13').clearSolutionData;
model.sol('sol14').clearSolutionData;

model.label('two_mirror_laser_cavity.mph');

model.modelNode.label('Components');

out = model;
