function out = model
%
% monai_runup.m
%
% Model exported on May 26 2025, 21:26 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/CFD_Module/Shallow_Water_Equations');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 2);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.physics.create('swe', 'ShallowWaterEquationsTimeExplicit', 'geom1');
model.physics('swe').model('comp1');

model.study.create('std1');
model.study('std1').create('stat', 'Stationary');
model.study('std1').feature('stat').set('solnum', 'auto');
model.study('std1').feature('stat').set('notsolnum', 'auto');
model.study('std1').feature('stat').set('errorexpr', {'1'});
model.study('std1').feature('stat').setSolveFor('/physics/swe', true);
model.study('std1').create('time', 'Transient');
model.study('std1').feature('time').set('initstudy', 'std1');
model.study('std1').feature('time').set('initialtime', '0');
model.study('std1').feature('time').set('useinitsol', 'on');
model.study('std1').feature('time').set('notsolnum', 'auto');
model.study('std1').feature('time').setSolveFor('/physics/swe', true);

model.geom('geom1').create('r1', 'Rectangle');
model.geom('geom1').feature('r1').set('size', [5.448 3.402]);

model.func.create('int1', 'Interpolation');
model.func('int1').model('comp1');
model.func('int1').label('Inverse of Bottom Topography');
model.func('int1').set('source', 'file');
model.func('int1').set('filename', 'monai_runup_bathymetry.txt');
model.func('int1').importData;
model.func('int1').set('defvars', true);
model.func('int1').setIndex('funcs', 'zB', 0, 0);
model.func('int1').setIndex('fununit', 'm', 0);
model.func.create('int2', 'Interpolation');
model.func('int2').model('comp1');
model.func('int2').label('Incoming Wave Profile');
model.func('int2').set('source', 'file');
model.func('int2').set('filename', 'monai_runup_input_wave.txt');
model.func('int2').importData;
model.func('int2').set('funcname', 'H_in');
model.func('int2').setIndex('argunit', 's', 0);
model.func('int2').setIndex('fununit', 'm', 0);

model.probe.create('pdom1', 'DomainPoint');
model.probe('pdom1').model('comp1');

model.geom('geom1').run;

model.probe('pdom1').setIndex('coords2', '4.52[m]', 0);
model.probe('pdom1').setIndex('coords2', '1.196[m]', 1);
model.probe('pdom1').label('Probe (x,y)=(4.52,1.196)');
model.probe('pdom1').feature('ppb1').set('expr', 'swe.H');
model.probe('pdom1').feature('ppb1').set('descr', 'Total height');
model.probe.duplicate('pdom2', 'pdom1');
model.probe('pdom2').label('Probe (x,y)=(4.52,1.696)');
model.probe('pdom2').setIndex('coords2', '1.696[m]', 1);
model.probe.duplicate('pdom3', 'pdom2');
model.probe('pdom3').label('Probe (x,y)=(4.52,2.196)');
model.probe('pdom3').setIndex('coords2', '2.196[m]', 1);

model.physics('swe').feature('dp1').set('hb', '-zB');
model.physics('swe').feature('init1').set('specifyDepth', 'specifyTotalHeight');
model.physics('swe').create('inl1', 'InletBoundary', 1);
model.physics('swe').feature('inl1').selection.set([1]);
model.physics('swe').feature('inl1').set('waterDepthSelect', 'totalHeight');
model.physics('swe').feature('inl1').set('H0', 'H_in(t)');
model.physics('swe').feature('inl1').set('velocitySelect', 'fromDomain');

model.mesh('mesh1').automatic(false);
model.mesh('mesh1').feature('size').set('custom', true);
model.mesh('mesh1').feature('size').set('hmax', 0.01);
model.mesh('mesh1').feature.remove('ftri1');
model.mesh('mesh1').create('map1', 'Map');
model.mesh('mesh1').run;

model.study('std1').feature('time').set('tlist', 'range(0,1,10) range(10.25,0.25,25)');

model.sol.create('sol1');
model.sol('sol1').study('std1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'stat');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').set('control', 'stat');
model.sol('sol1').create('s1', 'Stationary');
model.sol('sol1').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('s1').feature('fc1').set('linsolver', 'dDef');
model.sol('sol1').feature('s1').feature.remove('fcDef');
model.sol('sol1').create('su1', 'StoreSolution');
model.sol('sol1').create('st2', 'StudyStep');
model.sol('sol1').feature('st2').set('study', 'std1');
model.sol('sol1').feature('st2').set('studystep', 'time');
model.sol('sol1').create('v2', 'Variables');
model.sol('sol1').feature('v2').set('initmethod', 'sol');
model.sol('sol1').feature('v2').set('initsol', 'sol1');
model.sol('sol1').feature('v2').set('initsoluse', 'sol2');
model.sol('sol1').feature('v2').set('notsolmethod', 'sol');
model.sol('sol1').feature('v2').set('notsol', 'sol1');
model.sol('sol1').feature('v2').set('notsoluse', 'sol2');
model.sol('sol1').feature('v2').set('control', 'time');
model.sol('sol1').create('t1', 'Time');
model.sol('sol1').feature('t1').set('odesolvertype', 'explicit');
model.sol('sol1').feature('t1').set('timemethodexp', 'erk');
model.sol('sol1').feature('t1').set('tlist', 'range(0,1,10) range(10.25,0.25,25)');
model.sol('sol1').feature('t1').set('plot', 'off');
model.sol('sol1').feature('t1').set('plotgroup', 'Default');
model.sol('sol1').feature('t1').set('plotfreq', 'tout');
model.sol('sol1').feature('t1').set('probesel', 'all');
model.sol('sol1').feature('t1').set('probes', {'pdom1' 'pdom2' 'pdom3'});
model.sol('sol1').feature('t1').set('probefreq', 'tsteps');
model.sol('sol1').feature('t1').set('exprs', {'root.comp1.swe.wtc'});
model.sol('sol1').feature('t1').set('tstepping', 'elemexprs');
model.sol('sol1').feature('t1').set('erkorder', 3);
model.sol('sol1').feature('t1').set('rktimestep', 'comp1.swe.dt_CFL');
model.sol('sol1').feature('t1').set('updtstep', 'manual');
model.sol('sol1').feature('t1').set('ntimestepsupdate', 1);
model.sol('sol1').feature('t1').set('control', 'time');
model.sol('sol1').feature('t1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('t1').feature('fc1').set('linsolver', 'dDef');
model.sol('sol1').feature('t1').feature.remove('fcDef');
model.sol('sol1').feature('v2').set('solnum', 'auto');
model.sol('sol1').feature('v2').set('solvertype', 'solnum');
model.sol('sol1').attach('std1');

model.probe('pdom1').genResult('none');
model.probe('pdom2').genResult('none');
model.probe('pdom3').genResult('none');

model.sol('sol1').runFromTo('st1', 'v1');

model.result.create('pg2', 'PlotGroup2D');
model.result('pg2').label('Total Height (swe)');
model.result('pg2').set('edges', 'off');
model.result('pg2').set('data', 'dset1');
model.result('pg2').setIndex('looplevel', 1, 0);
model.result('pg2').set('defaultPlotID', 'shallowwaterequations/dg/ShallowWaterEqDG_ResultDefaults/icom1/pdef1/pcond2/pg1');
model.result('pg2').feature.create('surf1', 'Surface');
model.result('pg2').feature('surf1').label('Total Height');
model.result('pg2').feature('surf1').set('showsolutionparams', 'on');
model.result('pg2').feature('surf1').set('expr', 'swe.H');
model.result('pg2').feature('surf1').set('smooth', 'everywhere');
model.result('pg2').feature('surf1').set('showsolutionparams', 'on');
model.result('pg2').feature('surf1').set('data', 'parent');
model.result('pg2').feature('surf1').feature.create('hght1', 'Height');
model.result('pg2').feature('surf1').feature.create('mtrl1', 'MaterialAppearance');
model.result('pg2').feature('surf1').feature('mtrl1').set('appearance', 'custom');
model.result('pg2').feature('surf1').feature('mtrl1').set('family', 'water');
model.result('pg2').feature.create('surf2', 'Surface');
model.result('pg2').feature('surf2').label('Bottom Height');
model.result('pg2').feature('surf2').set('showsolutionparams', 'on');
model.result('pg2').feature('surf2').set('expr', 'swe.hb');
model.result('pg2').feature('surf2').set('coloring', 'uniform');
model.result('pg2').feature('surf2').set('color', 'gray');
model.result('pg2').feature('surf2').set('smooth', 'everywhere');
model.result('pg2').feature('surf2').set('inheritcolor', false);
model.result('pg2').feature('surf2').set('inheritrange', false);
model.result('pg2').feature('surf2').set('showsolutionparams', 'on');
model.result('pg2').feature('surf2').set('data', 'parent');
model.result('pg2').feature('surf2').set('inheritplot', 'surf1');
model.result('pg2').feature('surf2').feature.create('hght1', 'Height');
model.result('pg2').feature('surf2').feature.create('mtrl1', 'MaterialAppearance');
model.result('pg2').feature('surf2').feature('mtrl1').set('appearance', 'custom');
model.result('pg2').feature('surf2').feature('mtrl1').set('family', 'rock');
model.result.create('pg3', 'PlotGroup2D');
model.result('pg3').label('Velocity Magnitude (swe)');
model.result('pg3').set('frametype', 'spatial');
model.result('pg3').set('data', 'dset1');
model.result('pg3').setIndex('looplevel', 1, 0);
model.result('pg3').set('defaultPlotID', 'shallowwaterequations/dg/ShallowWaterEqDG_ResultDefaults/icom1/pdef1/pcond2/pg2');
model.result('pg3').feature.create('surf1', 'Surface');
model.result('pg3').feature('surf1').label('Velocity Magnitude');
model.result('pg3').feature('surf1').set('showsolutionparams', 'on');
model.result('pg3').feature('surf1').set('expr', 'swe.U');
model.result('pg3').feature('surf1').set('smooth', 'everywhere');
model.result('pg3').feature('surf1').set('showsolutionparams', 'on');
model.result('pg3').feature('surf1').set('data', 'parent');
model.result('pg2').run;
model.result('pg2').run;
model.result('pg2').feature('surf1').feature('hght1').set('scaleactive', true);
model.result('pg2').feature('surf1').feature('hght1').set('scale', 10);
model.result('pg2').feature('surf1').feature('hght1').set('isheightaxisshown', false);
model.result('pg2').run;
model.result('pg2').feature('surf1').create('filt1', 'Filter');
model.result('pg2').run;
model.result('pg2').feature('surf1').feature('filt1').set('expr', 'h>1e-4[m]');
model.result('pg2').feature('surf1').feature('filt1').set('nodespec', 'all');
model.result('pg2').run;
model.result('pg2').feature('surf2').feature('mtrl1').active(false);
model.result('pg2').feature('surf2').feature('mtrl1').active(true);
model.result('pg1').set('window', 'window2');
model.result('pg1').set('windowtitle', 'Probe Plot 2');
model.result('pg1').run;
model.result('pg1').set('legendpos', 'upperleft');

model.sol('sol1').study('std1');

model.study('std1').feature('time').set('solnum', 'auto');
model.study('std1').feature('time').set('solvertype', 'solnum');
model.study('std1').feature('time').set('solnumhide', 'off');
model.study('std1').feature('time').set('initstudyhide', 'off');
model.study('std1').feature('time').set('initsolhide', 'off');

model.sol('sol2').copySolution('sol3');

model.study('std1').feature('time').set('notlistsolnum', 1);
model.study('std1').feature('time').set('notsolnum', 'auto');
model.study('std1').feature('time').set('listsolnum', 1);
model.study('std1').feature('time').set('solnum', 'auto');

model.result.dataset('dset2').set('solution', 'none');

model.sol('sol1').feature.remove('t1');
model.sol('sol1').feature.remove('v2');
model.sol('sol1').feature.remove('st2');
model.sol('sol1').feature.remove('su1');
model.sol('sol1').feature.remove('s1');
model.sol('sol1').feature.remove('v1');
model.sol('sol1').feature.remove('st1');
model.sol('sol3').copySolution('sol2');
model.sol.remove('sol3');
model.sol('sol2').label('Solution Store 1');

model.result.dataset.remove('dset5');

model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'stat');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').set('control', 'stat');
model.sol('sol1').create('s1', 'Stationary');
model.sol('sol1').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('s1').feature('fc1').set('linsolver', 'dDef');
model.sol('sol1').feature('s1').feature.remove('fcDef');
model.sol('sol1').create('su1', 'StoreSolution');
model.sol('sol1').feature('su1').set('sol', 'sol2');
model.sol('sol1').feature('su1').label('Solution Store 1');
model.sol('sol1').create('st2', 'StudyStep');
model.sol('sol1').feature('st2').set('study', 'std1');
model.sol('sol1').feature('st2').set('studystep', 'time');

model.study('std1').feature('time').set('notsoluse', 'sol2');

model.sol('sol1').create('v2', 'Variables');
model.sol('sol1').feature('v2').set('initmethod', 'sol');
model.sol('sol1').feature('v2').set('initsol', 'sol1');
model.sol('sol1').feature('v2').set('initsoluse', 'sol2');
model.sol('sol1').feature('v2').set('notsolmethod', 'sol');
model.sol('sol1').feature('v2').set('notsol', 'sol1');
model.sol('sol1').feature('v2').set('control', 'time');
model.sol('sol1').create('t1', 'Time');
model.sol('sol1').feature('t1').set('odesolvertype', 'explicit');
model.sol('sol1').feature('t1').set('timemethodexp', 'erk');
model.sol('sol1').feature('t1').set('tlist', 'range(0,1,10) range(10.25,0.25,25)');
model.sol('sol1').feature('t1').set('plot', 'off');
model.sol('sol1').feature('t1').set('plotgroup', 'pg2');
model.sol('sol1').feature('t1').set('plotfreq', 'tout');
model.sol('sol1').feature('t1').set('probesel', 'all');
model.sol('sol1').feature('t1').set('probes', {'pdom1' 'pdom2' 'pdom3'});
model.sol('sol1').feature('t1').set('probefreq', 'tsteps');
model.sol('sol1').feature('t1').set('exprs', {'root.comp1.swe.wtc'});
model.sol('sol1').feature('t1').set('tstepping', 'elemexprs');
model.sol('sol1').feature('t1').set('erkorder', 3);
model.sol('sol1').feature('t1').set('rktimestep', 'comp1.swe.dt_CFL');
model.sol('sol1').feature('t1').set('updtstep', 'manual');
model.sol('sol1').feature('t1').set('ntimestepsupdate', 1);
model.sol('sol1').feature('t1').set('control', 'time');
model.sol('sol1').feature('t1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('t1').feature('fc1').set('linsolver', 'dDef');
model.sol('sol1').feature('t1').feature.remove('fcDef');

model.result.dataset('dset2').set('solution', 'sol2');

model.sol('sol1').feature('v2').set('solnum', 'auto');
model.sol('sol1').feature('v2').set('solvertype', 'solnum');

model.study('std1').feature('time').set('solnum', 'auto');
model.study('std1').feature('time').set('solvertype', 'solnum');
model.study('std1').feature('time').set('solnumhide', 'off');
model.study('std1').feature('time').set('initstudyhide', 'off');
model.study('std1').feature('time').set('initsolhide', 'off');

model.sol('sol1').attach('std1');

model.probe('pdom1').genResult('none');
model.probe('pdom2').genResult('none');
model.probe('pdom3').genResult('none');

model.sol('sol1').runAll;

model.result('pg2').run;
model.result('pg2').setIndex('looplevel', 19, 0);
model.result('pg2').run;
model.result('pg2').setIndex('looplevel', 31, 0);
model.result('pg2').run;
model.result('pg2').setIndex('looplevel', 39, 0);
model.result('pg2').run;
model.result('pg2').setIndex('looplevel', 47, 0);
model.result('pg2').run;
model.result('pg2').setIndex('looplevel', 59, 0);
model.result('pg2').run;
model.result('pg2').setIndex('looplevel', 71, 0);
model.result('pg2').run;
model.result('pg1').set('window', 'window2');
model.result('pg1').set('windowtitle', 'Probe Plot 2');
model.result('pg1').run;
model.result('pg2').run;

model.title('Tsunami Runup onto a Complex 3D Beach, Monai Valley');

model.description('This example is an established benchmark case that models a scaled laboratory experiment of the tsunami runup in the Monai Valley in Japan. The benchmark focuses on a region near the shoreline for which detailed experimental data is available. The tank is initially filled with still water, and a known incident wave is imposed at one of the boundaries. The wave makes the shoreline move back and forth, eventually covering the small island in the middle of the domain.');

model.mesh.clearMeshes;

model.sol('sol1').clearSolutionData;
model.sol('sol2').clearSolutionData;

model.label('monai_runup.mph');

model.modelNode.label('Components');

out = model;
