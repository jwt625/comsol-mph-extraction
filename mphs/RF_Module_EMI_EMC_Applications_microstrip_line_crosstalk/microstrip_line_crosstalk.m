function out = model
%
% microstrip_line_crosstalk.m
%
% Model exported on May 26 2025, 21:32 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/RF_Module/EMI_EMC_Applications');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 3);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.physics.create('temw', 'TransientElectromagneticWaves', 'geom1');
model.physics('temw').model('comp1');

model.study.create('std1');
model.study('std1').create('time', 'Transient');
model.study('std1').feature('time').setSolveFor('/physics/temw', true);

% To import content from file, use:
% model.param.loadFile('FILENAME');
model.param.set('f0', '600[MHz]', 'Frequency');
model.param.set('er_sub', '3.38', 'Substrate permittivity');
model.param.set('er_eff', '(er_sub+1)/2+(er_sub-1)/2/sqrt(1+12*tsub/lwidth)', 'Effective substrate permittivity');
model.param.set('vph', 'c_const/sqrt(er_eff)', 'Phase velocity');
model.param.set('Tb', '1/f0/2', 'One bit width');
model.param.set('drate', '1/Tb', 'Data rate');
model.param.set('delay', 'blength/vph', 'Travel time');
model.param.set('sim_time_max', 'delay+Tb', 'Maximum simulation time');
model.param.set('pulse_w', 'vph*Tb', 'Pulse width in substrate');
model.param.set('blength', '6[inch]', 'Substrate length');
model.param.set('bwidth', '1[inch]', 'Substrate width');
model.param.set('lwidth', '1.13[mm]', 'Line width');
model.param.set('spacing', '1.8[mm]', 'Distance between two lines');
model.param.set('tsub', '20[mil]', 'Substrate thickness');
model.param.set('fmax', '5[GHz]', 'Maximum pulse frequency component');
model.param.set('lmin', 'vph/fmax', 'Wave length in substrate');
model.param.set('hm', 'lmin/5', 'Maximum mesh size');
model.param.set('sim_time_step', '0.2 * hm/vph', 'Simulation time step');

model.geom('geom1').lengthUnit('in');
model.geom('geom1').create('blk1', 'Block');
model.geom('geom1').feature('blk1').set('size', {'blength+0.5' '1' '1'});
model.geom('geom1').feature('blk1').setIndex('size', 'bwidth', 1);
model.geom('geom1').feature('blk1').setIndex('size', 'tsub*15', 2);
model.geom('geom1').feature('blk1').set('pos', {'-0.25' '-bwidth/2' '0'});
model.geom('geom1').feature('blk1').set('layerleft', true);
model.geom('geom1').feature('blk1').set('layerright', true);
model.geom('geom1').feature('blk1').set('layerbottom', false);
model.geom('geom1').feature('blk1').setIndex('layername', 'Layer 1', 0);
model.geom('geom1').feature('blk1').setIndex('layer', 0.25, 0);

model.view('view1').set('renderwireframe', true);

model.geom('geom1').run('blk1');
model.geom('geom1').create('blk2', 'Block');
model.geom('geom1').feature('blk2').set('size', {'blength' 'bwidth' '1'});
model.geom('geom1').feature('blk2').setIndex('size', 'tsub', 2);
model.geom('geom1').feature('blk2').set('pos', {'0' '-bwidth/2' '0'});
model.geom('geom1').run('blk2');
model.geom('geom1').create('blk3', 'Block');
model.geom('geom1').feature('blk3').set('size', {'blength' 'lwidth' '1'});
model.geom('geom1').feature('blk3').setIndex('size', 'tsub', 2);
model.geom('geom1').feature('blk3').set('pos', {'0' '-spacing/2-lwidth' '0'});
model.geom('geom1').run('blk3');
model.geom('geom1').create('mir1', 'Mirror');
model.geom('geom1').feature('mir1').selection('input').set({'blk3'});
model.geom('geom1').feature('mir1').set('keep', true);
model.geom('geom1').feature('mir1').set('axis', [0 1 0]);
model.geom('geom1').runPre('fin');

model.func.create('rect1', 'Rectangle');
model.func('rect1').set('lower', 0);
model.func('rect1').set('upper', 'Tb-Tb/4');
model.func('rect1').set('smooth', 'Tb/4');
model.func.create('an1', 'Analytic');
model.func('an1').set('expr', 'rect1((t-Tb/8)/1[s])');
model.func('an1').set('args', 't');
model.func('an1').setIndex('argunit', 's', 0);
model.func('an1').set('fununit', 'V');
model.func('an1').setIndex('plotargs', '2*Tb', 0, 2);

model.geom('geom1').run;

model.material.create('mat1', 'Common', 'comp1');
model.material('mat1').propertyGroup('def').set('relpermittivity', {'1'});
model.material('mat1').propertyGroup('def').set('relpermeability', {'1'});
model.material('mat1').propertyGroup('def').set('electricconductivity', {'0'});
model.material.create('mat2', 'Common', 'comp1');
model.material('mat2').selection.set([2 4 5 6 7]);
model.material('mat2').propertyGroup('def').set('relpermittivity', {'er_sub'});
model.material('mat2').propertyGroup('def').set('relpermeability', {'1'});
model.material('mat2').propertyGroup('def').set('electricconductivity', {'0'});

model.physics('temw').create('pec2', 'PerfectElectricConductor', 2);
model.physics('temw').feature('pec2').selection.set([16 24]);
model.physics('temw').create('sctr1', 'Scattering', 2);
model.physics('temw').feature('sctr1').selection.set([1 2 4 5 7 10 12 29 30 32 35 40 41]);
model.physics('temw').create('lport1', 'LumpedPort', 2);
model.physics('temw').feature('lport1').selection.set([21]);
model.physics('temw').feature('lport1').set('V0', 'an1(t)');
model.physics('temw').create('lport2', 'LumpedPort', 2);
model.physics('temw').feature('lport2').selection.set([38]);
model.physics('temw').create('lport3', 'LumpedPort', 2);
model.physics('temw').feature('lport3').selection.set([13]);
model.physics('temw').create('lport4', 'LumpedPort', 2);
model.physics('temw').feature('lport4').selection.set([36]);
model.physics('temw').prop('MeshControl').set('PhysicsControlledMeshMaximumElementSize', 'hm');

model.mesh('mesh1').automatic(false);

model.view('view1').camera.set('zoomanglefull', 2);
model.view('view1').camera.setIndex('position', -17.8, 0);
model.view('view1').camera.setIndex('position', -23.7, 1);
model.view('view1').camera.set('position', [-17.8 -23.7 17.9]);
model.view('view1').camera.setIndex('target', 0.15, 1);
model.view('view1').camera.set('target', [3 0.15 0.15]);
model.view('view1').camera.setIndex('up', 0.309, 0);
model.view('view1').camera.setIndex('up', 0.42, 1);
model.view('view1').camera.set('up', [0.309 0.42 0.86]);
model.view('view1').camera.setIndex('rotationpoint', 0, 0);
model.view('view1').camera.set('rotationpoint', [0 0 0.15]);
model.view('view1').camera.setIndex('viewoffset', 1.955, 0);
model.view('view1').camera.set('viewoffset', [1.955 1.125]);

model.mesh('mesh1').create('edg1', 'Edge');
model.mesh('mesh1').feature('edg1').selection.set([18 20 23 25 28 30]);
model.mesh('mesh1').feature('edg1').create('dis1', 'Distribution');
model.mesh('mesh1').feature('edg1').feature('dis1').selection.set([18 20 28 30]);
model.mesh('mesh1').feature('edg1').feature('dis1').set('type', 'predefined');
model.mesh('mesh1').feature('edg1').feature('dis1').set('elemcount', 3);
model.mesh('mesh1').feature('edg1').feature('dis1').set('elemratio', 4);
model.mesh('mesh1').feature('edg1').feature('dis1').set('symmetric', true);
model.mesh('mesh1').feature('edg1').create('dis2', 'Distribution');
model.mesh('mesh1').feature('edg1').feature('dis2').selection.set([23 25]);
model.mesh('mesh1').feature('edg1').feature('dis2').set('type', 'predefined');
model.mesh('mesh1').feature('edg1').feature('dis2').set('elemcount', 4);
model.mesh('mesh1').feature('edg1').feature('dis2').set('elemratio', 4);
model.mesh('mesh1').feature('edg1').feature('dis2').set('symmetric', true);
model.mesh('mesh1').create('map1', 'Map');
model.mesh('mesh1').feature('map1').selection.set([13 17 21]);
model.mesh('mesh1').feature('map1').create('dis1', 'Distribution');
model.mesh('mesh1').feature('map1').feature('dis1').selection.set([17 32]);
model.mesh('mesh1').feature('map1').feature('dis1').set('numelem', 2);
model.mesh('mesh1').create('ftri1', 'FreeTri');
model.mesh('mesh1').feature('ftri1').selection.set([6 9 25]);
model.mesh('mesh1').create('swe1', 'Sweep');
model.mesh('mesh1').feature('swe1').selection.geom('geom1', 3);
model.mesh('mesh1').feature('swe1').selection.set([2 3 4 5 6 7]);
model.mesh('mesh1').create('swe2', 'Sweep');
model.mesh('mesh1').feature.remove('ftet1');
model.mesh('mesh1').run;

model.view('view1').hideEntities.create('hide1');
model.view('view1').hideEntities('hide1').geom(2);
model.view('view1').hideEntities('hide1').add([12]);
model.view('view1').hideEntities('hide1').add([10]);
model.view('view1').hideEntities('hide1').add([4]);
model.view('view1').hideEntities('hide1').add([1]);
model.view('view1').hideEntities('hide1').add([2]);

model.study('std1').feature('time').set('tlist', 'range(0,sim_time_step,sim_time_max)');

model.sol.create('sol1');
model.sol('sol1').study('std1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'time');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').set('control', 'time');
model.sol('sol1').create('t1', 'Time');
model.sol('sol1').feature('t1').set('tlist', 'range(0,sim_time_step,sim_time_max)');
model.sol('sol1').feature('t1').set('plot', 'off');
model.sol('sol1').feature('t1').set('plotgroup', 'Default');
model.sol('sol1').feature('t1').set('plotfreq', 'tout');
model.sol('sol1').feature('t1').set('probesel', 'all');
model.sol('sol1').feature('t1').set('probes', {});
model.sol('sol1').feature('t1').set('probefreq', 'tsteps');
model.sol('sol1').feature('t1').set('rtol', 0.001);
model.sol('sol1').feature('t1').set('atolglobalvaluemethod', 'factor');
model.sol('sol1').feature('t1').set('reacf', true);
model.sol('sol1').feature('t1').set('storeudot', true);
model.sol('sol1').feature('t1').set('endtimeinterpolation', true);
model.sol('sol1').feature('t1').set('timemethod', 'genalpha');
model.sol('sol1').feature('t1').set('control', 'time');
model.sol('sol1').feature('t1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('t1').create('d1', 'Direct');
model.sol('sol1').feature('t1').feature('d1').set('linsolver', 'pardiso');
model.sol('sol1').feature('t1').feature('d1').label('Suggested Direct Solver (temw)');
model.sol('sol1').feature('t1').feature('fc1').set('linsolver', 'd1');
model.sol('sol1').feature('t1').feature.remove('fcDef');
model.sol('sol1').attach('std1');
model.sol('sol1').feature('t1').set('tstepsgenalpha', 'manual');
model.sol('sol1').feature('t1').set('timestepgenalpha', 'sim_time_step');
model.sol('sol1').feature('t1').feature('dDef').set('linsolver', 'pardiso');

model.study('std1').create('param', 'Parametric');
model.study('std1').feature('param').setIndex('pname', 'f0', 0);
model.study('std1').feature('param').setIndex('plistarr', '', 0);
model.study('std1').feature('param').setIndex('punit', 'Hz', 0);
model.study('std1').feature('param').setIndex('pname', 'f0', 0);
model.study('std1').feature('param').setIndex('plistarr', '', 0);
model.study('std1').feature('param').setIndex('punit', 'Hz', 0);
model.study('std1').feature('param').setIndex('plistarr', '300[MHz] 600[MHz]', 0);

model.batch.create('p1', 'Parametric');
model.batch('p1').study('std1');
model.batch('p1').create('so1', 'Solutionseq');
model.batch('p1').feature('so1').set('seq', 'sol1');
model.batch('p1').feature('so1').set('store', 'on');
model.batch('p1').feature('so1').set('clear', 'on');
model.batch('p1').feature('so1').set('psol', 'none');
model.batch('p1').set('pname', {'f0'});
model.batch('p1').set('plistarr', {'300[MHz] 600[MHz]'});
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

model.result.create('pg1', 'PlotGroup3D');
model.result('pg1').set('data', 'dset2');
model.result('pg1').setIndex('looplevel', 208, 0);
model.result('pg1').setIndex('looplevel', 2, 1);
model.result('pg1').set('outertype', 'none');
model.result('pg1').set('solvertype', 'none');
model.result('pg1').set('data', 'dset2');
model.result('pg1').setIndex('looplevel', 208, 0);
model.result('pg1').setIndex('looplevel', 2, 1);
model.result('pg1').set('defaultPlotID', 'TransientElectromagneticWaves/phys1/pdef1/pcond1/pg1');
model.result('pg1').feature.create('mslc1', 'Multislice');
model.result('pg1').feature('mslc1').set('showsolutionparams', 'on');
model.result('pg1').feature('mslc1').set('outertype', 'none');
model.result('pg1').feature('mslc1').set('solvertype', 'none');
model.result('pg1').feature('mslc1').set('smooth', 'internal');
model.result('pg1').feature('mslc1').set('showsolutionparams', 'on');
model.result('pg1').feature('mslc1').set('outertype', 'none');
model.result('pg1').feature('mslc1').set('solvertype', 'none');
model.result('pg1').feature('mslc1').set('showsolutionparams', 'on');
model.result('pg1').feature('mslc1').set('outertype', 'none');
model.result('pg1').feature('mslc1').set('solvertype', 'none');
model.result('pg1').feature('mslc1').set('showsolutionparams', 'on');
model.result('pg1').feature('mslc1').set('outertype', 'none');
model.result('pg1').feature('mslc1').set('solvertype', 'none');
model.result('pg1').feature('mslc1').set('showsolutionparams', 'on');
model.result('pg1').feature('mslc1').set('outertype', 'none');
model.result('pg1').feature('mslc1').set('solvertype', 'none');
model.result('pg1').feature('mslc1').set('data', 'parent');
model.result('pg1').run;
model.result('pg1').set('looplevel', [76 2]);
model.result('pg1').run;
model.result('pg1').feature('mslc1').set('xnumber', '0');
model.result('pg1').feature('mslc1').set('ynumber', '0');
model.result('pg1').feature('mslc1').set('multiplanezmethod', 'coord');
model.result('pg1').feature('mslc1').set('zcoord', 0);
model.result('pg1').run;
model.result.create('pg2', 'PlotGroup1D');
model.result('pg2').run;
model.result('pg2').set('data', 'dset2');
model.result('pg2').set('titletype', 'manual');
model.result('pg2').set('title', 'Time domain response at the input port');
model.result('pg2').create('glob1', 'Global');
model.result('pg2').feature('glob1').set('markerpos', 'datapoints');
model.result('pg2').feature('glob1').set('linewidth', 'preference');
model.result('pg2').feature('glob1').setIndex('expr', 'temw.Vport_1', 0);
model.result('pg2').feature('glob1').setIndex('unit', 'V', 0);
model.result('pg2').feature('glob1').setIndex('descr', 'Lumped port 1 voltage', 0);
model.result('pg2').feature('glob1').setIndex('expr', 'an1(t)', 1);
model.result('pg2').feature('glob1').setIndex('unit', '', 1);
model.result('pg2').feature('glob1').setIndex('descr', 'Input pulse', 1);
model.result('pg2').feature('glob1').set('linemarker', 'cycle');
model.result('pg2').feature('glob1').set('markerpos', 'interp');
model.result('pg2').run;
model.result('pg2').run;
model.result.duplicate('pg3', 'pg2');
model.result('pg3').run;
model.result('pg3').set('title', 'Time domain response at the through port');
model.result('pg3').set('legendpos', 'middleleft');
model.result('pg3').run;
model.result('pg3').feature('glob1').setIndex('expr', 'temw.Vport_2', 0);
model.result('pg3').feature('glob1').setIndex('unit', 'V', 0);
model.result('pg3').feature('glob1').setIndex('descr', 'Lumped port 2 voltage', 0);
model.result('pg3').feature('glob1').setIndex('expr', 'an1(t-delay)', 1);
model.result('pg3').feature('glob1').setIndex('unit', 'V', 1);
model.result('pg3').feature('glob1').setIndex('descr', 'Delayed input pulse', 1);
model.result('pg3').run;
model.result.create('pg4', 'PlotGroup1D');
model.result('pg4').run;
model.result('pg4').set('data', 'dset2');
model.result('pg4').set('titletype', 'manual');
model.result('pg4').set('title', 'Time domain response at the coupled ports');
model.result('pg4').set('legendpos', 'upperleft');
model.result('pg4').create('glob1', 'Global');
model.result('pg4').feature('glob1').set('markerpos', 'datapoints');
model.result('pg4').feature('glob1').set('linewidth', 'preference');
model.result('pg4').feature('glob1').setIndex('expr', 'temw.Vport_3', 0);
model.result('pg4').feature('glob1').setIndex('unit', 'V', 0);
model.result('pg4').feature('glob1').setIndex('descr', 'Lumped port 3 voltage', 0);
model.result('pg4').feature('glob1').setIndex('expr', 'temw.Vport_4', 1);
model.result('pg4').feature('glob1').setIndex('unit', 'V', 1);
model.result('pg4').feature('glob1').setIndex('descr', 'Lumped port 4 voltage', 1);
model.result('pg4').feature('glob1').set('linemarker', 'cycle');
model.result('pg4').feature('glob1').set('markerpos', 'interp');
model.result('pg4').run;
model.result.create('pg5', 'PlotGroup1D');
model.result('pg5').run;
model.result('pg5').set('data', 'dset2');
model.result('pg5').set('titletype', 'manual');
model.result('pg5').set('title', 'Frequency domain response of the input pulse');
model.result('pg5').create('glob1', 'Global');
model.result('pg5').feature('glob1').set('markerpos', 'datapoints');
model.result('pg5').feature('glob1').set('linewidth', 'preference');
model.result('pg5').feature('glob1').setIndex('expr', 'an1(t)', 0);
model.result('pg5').feature('glob1').setIndex('unit', 'V', 0);
model.result('pg5').feature('glob1').setIndex('descr', 'Input pulse spectrum', 0);
model.result('pg5').feature('glob1').set('xdata', 'fourier');
model.result('pg5').feature('glob1').set('fouriershow', 'spectrum');
model.result('pg5').feature('glob1').set('freqrangeactive', true);
model.result('pg5').feature('glob1').set('freqmax', '10[GHz]');
model.result('pg5').feature('glob1').set('linemarker', 'cycle');
model.result('pg5').feature('glob1').set('markerpos', 'interp');
model.result('pg5').run;
model.result('pg5').set('ylog', true);
model.result.create('pg6', 'PlotGroup1D');
model.result('pg6').run;
model.result('pg6').set('data', 'dset2');
model.result('pg6').create('glob1', 'Global');
model.result('pg6').feature('glob1').set('markerpos', 'datapoints');
model.result('pg6').feature('glob1').set('linewidth', 'preference');
model.result('pg6').feature('glob1').set('expr', {'temw.Zport_1'});
model.result('pg6').feature('glob1').set('descr', {'Lumped port 1 impedance'});
model.result('pg6').feature('glob1').set('linemarker', 'cycle');
model.result('pg6').feature('glob1').set('markerpos', 'interp');
model.result('pg6').run;

model.title('Signal Integrity and TDR Analysis of Adjacent Microstrip Lines');

model.description('Signal integrity (SI) analysis gives an overview of the quality of an electrical signal transmitted through electrical circuits such as high-speed interconnects, cables, and printed circuit boards. The quality of the received signal can be distorted by noise from outside the circuit, and can be degraded by impedance mismatch, insertion loss, and crosstalk; in practice, EMC/EMI analyses are run to estimate the susceptibility of a device or a network to undesired coupling. In this example model, we examine the crosstalk effect between two adjacent microstrip lines on a microwave substrate. The simulated results provide the time-domain reflectometry (TDR) response at the coupled ports and show increased distortion of a signal at higher data rates.');

model.mesh.clearMeshes;

model.sol('sol1').clearSolutionData;
model.sol('sol2').clearSolutionData;
model.sol('sol3').clearSolutionData;
model.sol('sol4').clearSolutionData;

model.label('microstrip_line_crosstalk.mph');

model.modelNode.label('Components');

out = model;
