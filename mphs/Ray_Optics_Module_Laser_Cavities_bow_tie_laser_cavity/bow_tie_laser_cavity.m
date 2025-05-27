function out = model
%
% bow_tie_laser_cavity.m
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
model.param.set('L1', '0.1[m]', 'Flat mirror half distance');
model.param.set('L2', '0.05[m]', 'Spherical mirror half distance');
model.param.set('th', '10[deg]', 'Flat mirror tilt angle');
model.param.set('dth', '0.1[deg]', 'Initial ray angle from flat mirror normal');
model.param.set('T0', '1[us]', 'Total computation time');
model.param.set('dt', 'T0/200', 'Time increment');
model.param.set('D_FM', '12.5[mm]', 'Flat mirror diameter');
model.param.set('L_FM', '10[mm]', 'Flat mirror thickness');
model.param.set('X_FM', '-L1*tan(th)', 'Flat mirror X position');
model.param.set('Y_FM', '0[m]', 'Flat mirror Y position');
model.param.set('Z_FM', '-L1', 'Flat mirror Z position');
model.param.set('RX_FM', '0[deg]', 'Flat mirror X rotation');
model.param.set('RY_FM', 'th', 'Flat mirror Y rotation');
model.param.set('RZ_FM', '0[deg]', 'Flat mirror Z rotation');
model.param.set('D_SM', '12.5[mm]', 'Spherical mirror diameter');
model.param.set('L_SM', '10[mm]', 'Spherical mirror thickness');
model.param.set('R_SM', '0.5[m]', 'Spherical mirror radius of curvature');
model.param.set('X_SM', 'L2*tan(th)', 'Spherical mirror X position');
model.param.set('Y_SM', '0[m]', 'Spherical mirror Y position');
model.param.set('Z_SM', 'L2', 'Spherical mirror Z position');
model.param.set('RX_SM', '0[deg]', 'Spherical mirror X rotation');
model.param.set('RY_SM', 'th/2', 'Spherical mirror Y rotation');
model.param.set('RZ_SM', '0[deg]', 'Spherical mirror Z rotation');
model.param.set('wl', '0.78[um]', 'Wavelength');

model.func.create('an1', 'Analytic');
model.func('an1').model('comp1');
model.func('an1').set('expr', '0.04*(51200*x^4-40960*x^3+8832*x^2-256*x-23)');
model.func('an1').setIndex('plotargs', 0.6, 0, 2);
model.func.create('rect1', 'Rectangle');
model.func('rect1').model('comp1');
model.func('rect1').set('lower', 0);
model.func('rect1').set('upper', 0.15);
model.func('rect1').set('smooth', 0.001);
model.func.duplicate('rect2', 'rect1');
model.func('rect2').set('lower', 0.25);
model.func('rect2').set('upper', 0.455);
model.func.create('an2', 'Analytic');
model.func('an2').model('comp1');
model.func('an2').set('expr', 'rect1(x)+rect2(x)');
model.func('an2').setIndex('plotargs', 0.6, 0, 2);

model.geom('geom1').create('cyl1', 'Cylinder');
model.geom('geom1').feature('cyl1').set('r', 'D_FM/2');
model.geom('geom1').feature('cyl1').set('h', 'L_FM');
model.geom('geom1').feature('cyl1').set('pos', {'X_FM' 'Y_FM' 'Z_FM'});
model.geom('geom1').feature('cyl1').set('axistype', 'spherical');
model.geom('geom1').feature('cyl1').set('ax2', {'180+th' '0'});
model.geom('geom1').run('cyl1');
model.geom.load({'part1'}, 'Ray_Optics_Module/3D/Mirrors/spherical_mirror_3d.mph', {'part1'});
model.geom('geom1').create('pi1', 'PartInstance');
model.geom('geom1').feature('pi1').set('selkeepnoncontr', false);
model.geom('geom1').feature('pi1').set('part', 'part1');
model.geom('geom1').feature('pi1').setEntry('inputexpr', 'R', '-R_SM');
model.geom('geom1').feature('pi1').setEntry('inputexpr', 'Tc', '10[mm]');
model.geom('geom1').feature('pi1').setEntry('inputexpr', 'd0', 'D_SM');
model.geom('geom1').feature('pi1').setEntry('inputexpr', 'd1', 'D_SM');
model.geom('geom1').feature('pi1').setEntry('inputexpr', 'd_clear', 'D_SM');
model.geom('geom1').feature('pi1').setEntry('inputexpr', 'd_hole', 0);
model.geom('geom1').feature('pi1').setEntry('inputexpr', 'nix', 'sin(RY_SM)');
model.geom('geom1').feature('pi1').setEntry('inputexpr', 'niy', 0);
model.geom('geom1').feature('pi1').setEntry('inputexpr', 'niz', 'cos(RY_SM)');
model.geom('geom1').feature('pi1').setEntry('inputexpr', 'n_extra_r', 0);
model.geom('geom1').feature('pi1').setEntry('inputexpr', 'n_extra_a', 0);
model.geom('geom1').feature('pi1').set('displ', {'X_SM' 'Y_SM' 'Z_SM'});
model.geom('geom1').runPre('fin');
model.geom('geom1').create('mir1', 'Mirror');
model.geom('geom1').feature('mir1').selection('input').set({'cyl1' 'pi1'});
model.geom('geom1').feature('mir1').set('keep', true);
model.geom('geom1').runPre('fin');
model.geom('geom1').run;

model.physics('gop').selection.set([]);
model.physics('gop').prop('MaximumSecondary').setIndex('MaximumSecondary', 0, 0);
model.physics('gop').feature('op1').set('lambda0', 'wl');
model.physics('gop').create('mir1', 'Mirror', 2);
model.physics('gop').feature('mir1').selection.set([7 8 15 18]);
model.physics('gop').create('relg1', 'ReleaseGrid', -1);
model.physics('gop').feature('relg1').setIndex('x0', 'X_FM', 0);
model.physics('gop').feature('relg1').setIndex('x0', 'Y_FM', 1);
model.physics('gop').feature('relg1').setIndex('x0', 'Z_FM', 2);
model.physics('gop').feature('relg1').set('L0', {'sin(th+dth)' '0' 'cos(th+dth)'});
model.physics('gop').create('rt1', 'RayTermination', -1);
model.physics('gop').feature('rt1').set('SpatialExtentsOfRayPropagation', 'BoundingBoxFromGeometry');

model.mesh('mesh1').autoMeshSize(3);
model.mesh('mesh1').automatic(false);
model.mesh('mesh1').feature('size').set('hmax', 'D_SM/20');
model.mesh('mesh1').feature('size').set('hmin', 'D_SM/40');
model.mesh('mesh1').run;

model.study('std1').feature('rtrac').set('tlist', 'range(0,dt,T0)');
model.study('std1').feature('rtrac').set('raystopcond', 'noactive');
model.study('std1').create('param', 'Parametric');
model.study('std1').feature('param').setIndex('pname', 'L1', 0);
model.study('std1').feature('param').setIndex('plistarr', '', 0);
model.study('std1').feature('param').setIndex('punit', 'm', 0);
model.study('std1').feature('param').setIndex('pname', 'L1', 0);
model.study('std1').feature('param').setIndex('plistarr', '', 0);
model.study('std1').feature('param').setIndex('punit', 'm', 0);
model.study('std1').feature('param').setIndex('pname', 'L2', 0);
model.study('std1').feature('param').setIndex('plistarr', 'range(0.02,0.02,0.14) range(0.142,0.002,0.152) range(0.16,0.02,0.24) range(0.242,0.002,0.252) range(0.26,0.02,0.44) range(0.442,0.002,0.452) range(0.46,0.02,0.6)', 0);
model.study('std1').feature('param').setIndex('punit', 'm', 0);

model.sol.create('sol1');
model.sol('sol1').study('std1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'rtrac');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').set('control', 'rtrac');
model.sol('sol1').create('t1', 'Time');
model.sol('sol1').feature('t1').set('tlist', 'range(0,dt,T0)');
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
model.batch('p1').set('pname', {'L2'});
model.batch('p1').set('plistarr', {'range(0.02,0.02,0.14) range(0.142,0.002,0.152) range(0.16,0.02,0.24) range(0.242,0.002,0.252) range(0.26,0.02,0.44) range(0.442,0.002,0.452) range(0.46,0.02,0.6)'});
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
model.result('pg1').set('outersolnum', 6);
model.result('pg1').set('solnum', 201);
model.result('pg1').create('surf1', 'Surface');
model.result('pg1').feature('surf1').set('coloring', 'uniform');
model.result('pg1').feature('surf1').set('color', 'cyan');
model.result('pg1').run;
model.result('pg1').run;

model.view('view1').camera.set('zoomanglefull', 7.884194374084473);
model.view('view1').camera.setIndex('position', 0.6317691802978516, 0);
model.view('view1').camera.setIndex('position', 0.582710862159729, 1);
model.view('view1').camera.setIndex('position', -0.821289598941803, 2);
model.view('view1').camera.set('target', [-0.01598536968231201 0 0]);
model.view('view1').camera.setIndex('target', -0.004269421100616455, 1);
model.view('view1').camera.setIndex('target', -0.011865317821502686, 2);
model.view('view1').camera.setIndex('up', 0.9601849913597107, 0);
model.view('view1').camera.setIndex('up', -0.1444069743156433, 1);
model.view('view1').camera.setIndex('up', 0.02426607348024845, 2);
model.view('view1').camera.set('rotationpoint', [-0.0048 0 0]);
model.view('view1').camera.set('viewoffset', [-0.05542455613613129 0]);
model.view('view1').camera.setIndex('viewoffset', -0.14737728238105774, 1);
model.view('view1').set('showgrid', false);

model.result.create('pg2', 'PlotGroup1D');
model.result('pg2').run;
model.result('pg2').set('data', 'ray1');
model.result('pg2').set('innerinput', 'last');
model.result('pg2').set('ylabelactive', true);
model.result('pg2').set('ylabel', 'Stability');
model.result('pg2').set('titletype', 'manual');
model.result('pg2').set('title', 'Laser Cavity Stability Analysis');
model.result('pg2').set('legendpos', 'middleleft');
model.result('pg2').create('glob1', 'Global');
model.result('pg2').feature('glob1').set('markerpos', 'datapoints');
model.result('pg2').feature('glob1').set('linewidth', 'preference');
model.result('pg2').feature('glob1').setIndex('expr', 't/T0', 0);
model.result('pg2').feature('glob1').setIndex('unit', 1, 0);
model.result('pg2').feature('glob1').setIndex('descr', 'Ray tracing', 0);
model.result('pg2').feature('glob1').set('xdatasolnumtype', 'all');
model.result('pg2').feature('glob1').set('xdata', 'expr');
model.result('pg2').feature('glob1').set('xdataexpr', 'L2');
model.result('pg2').feature('glob1').set('linestyle', 'none');
model.result('pg2').feature('glob1').set('linecolor', 'blue');
model.result('pg2').feature('glob1').set('linemarker', 'diamond');
model.result('pg2').feature('glob1').set('legendmethod', 'manual');
model.result('pg2').feature('glob1').setIndex('legends', 'Ray tracing', 0);
model.result('pg2').run;
model.result('pg2').create('glob2', 'Global');
model.result('pg2').feature('glob2').set('markerpos', 'datapoints');
model.result('pg2').feature('glob2').set('linewidth', 'preference');
model.result('pg2').feature('glob2').setIndex('expr', 'an2(L2)', 0);
model.result('pg2').feature('glob2').setIndex('unit', 1, 0);
model.result('pg2').feature('glob2').setIndex('descr', 'ABCD theory', 0);
model.result('pg2').feature('glob2').set('xdatasolnumtype', 'all');
model.result('pg2').feature('glob2').set('xdata', 'expr');
model.result('pg2').feature('glob2').set('xdataexpr', 'L2');
model.result('pg2').feature('glob2').set('linestyle', 'dashed');
model.result('pg2').feature('glob2').set('linecolor', 'red');
model.result('pg2').feature('glob2').set('legendmethod', 'manual');
model.result('pg2').feature('glob2').setIndex('legends', 'ABCD theory', 0);
model.result('pg2').run;

model.title('Bow-Tie Laser Cavity');

model.description('This is an example of a laser cavity consisting of two spherical mirrors and two flat mirrors in a symmetric bow-tie configuration. A ray, initially released at a small angle relative to the optical axis, is traced over a large number of reflections to determine whether it remains confined within the cavity. The study is repeated for several cavity sizes and the stability analysis is then compared to ABCD matrix theory.');

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
model.sol('sol15').clearSolutionData;
model.sol('sol16').clearSolutionData;
model.sol('sol17').clearSolutionData;
model.sol('sol18').clearSolutionData;
model.sol('sol19').clearSolutionData;
model.sol('sol20').clearSolutionData;
model.sol('sol21').clearSolutionData;
model.sol('sol22').clearSolutionData;
model.sol('sol23').clearSolutionData;
model.sol('sol24').clearSolutionData;
model.sol('sol25').clearSolutionData;
model.sol('sol26').clearSolutionData;
model.sol('sol27').clearSolutionData;
model.sol('sol28').clearSolutionData;
model.sol('sol29').clearSolutionData;
model.sol('sol30').clearSolutionData;
model.sol('sol31').clearSolutionData;
model.sol('sol32').clearSolutionData;
model.sol('sol33').clearSolutionData;
model.sol('sol34').clearSolutionData;
model.sol('sol35').clearSolutionData;
model.sol('sol36').clearSolutionData;
model.sol('sol37').clearSolutionData;
model.sol('sol38').clearSolutionData;
model.sol('sol39').clearSolutionData;
model.sol('sol40').clearSolutionData;
model.sol('sol41').clearSolutionData;
model.sol('sol42').clearSolutionData;
model.sol('sol43').clearSolutionData;
model.sol('sol44').clearSolutionData;
model.sol('sol45').clearSolutionData;
model.sol('sol46').clearSolutionData;
model.sol('sol47').clearSolutionData;
model.sol('sol48').clearSolutionData;
model.sol('sol49').clearSolutionData;
model.sol('sol50').clearSolutionData;

model.label('bow_tie_laser_cavity.mph');

model.modelNode.label('Components');

out = model;
