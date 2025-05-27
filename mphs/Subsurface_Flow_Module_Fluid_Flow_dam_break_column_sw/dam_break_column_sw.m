function out = model
%
% dam_break_column_sw.m
%
% Model exported on May 26 2025, 21:34 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/Subsurface_Flow_Module/Fluid_Flow');

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
model.geom('geom1').feature('r1').set('size', [0.61 1.6]);
model.geom('geom1').feature('r1').setIndex('layer', 0.4, 0);
model.geom('geom1').run('r1');
model.geom('geom1').create('sq1', 'Square');
model.geom('geom1').feature('sq1').set('size', 0.12);
model.geom('geom1').feature('sq1').set('pos', [0.24 0.9]);
model.geom('geom1').run('sq1');
model.geom('geom1').create('dif1', 'Difference');
model.geom('geom1').feature('dif1').selection('input').set({'r1'});
model.geom('geom1').feature('dif1').selection('input2').set({'sq1'});
model.geom('geom1').runPre('fin');
model.geom('geom1').run;

model.physics('swe').feature('init1').set('h_init', 0.01);
model.physics('swe').create('init2', 'init', 2);
model.physics('swe').feature('init2').selection.set([1]);
model.physics('swe').feature('init2').set('h_init', 0.3);

model.probe.create('bnd1', 'Boundary');
model.probe('bnd1').model('comp1');
model.probe('bnd1').set('intsurface', true);
model.probe('bnd1').set('probename', 'Fp');
model.probe('bnd1').set('type', 'integral');
model.probe('bnd1').selection.set([7 8]);
model.probe('bnd1').set('expr', 'swe.Fpy');
model.probe('bnd1').set('descractive', true);
model.probe('bnd1').set('descr', 'Pressure force on the column');

model.mesh('mesh1').autoMeshSize(3);
model.mesh('mesh1').run;

model.study('std1').feature('time').set('tlist', 'range(0,0.01,3)');

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
model.sol('sol1').feature('t1').set('tlist', 'range(0,0.01,3)');
model.sol('sol1').feature('t1').set('plot', 'off');
model.sol('sol1').feature('t1').set('plotgroup', 'Default');
model.sol('sol1').feature('t1').set('plotfreq', 'tout');
model.sol('sol1').feature('t1').set('probesel', 'all');
model.sol('sol1').feature('t1').set('probes', {'bnd1'});
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

model.probe('bnd1').genResult('none');

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
model.sol('sol1').feature('t1').set('tlist', 'range(0,0.01,3)');
model.sol('sol1').feature('t1').set('plot', 'off');
model.sol('sol1').feature('t1').set('plotgroup', 'pg2');
model.sol('sol1').feature('t1').set('plotfreq', 'tout');
model.sol('sol1').feature('t1').set('probesel', 'all');
model.sol('sol1').feature('t1').set('probes', {'bnd1'});
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

model.probe('bnd1').genResult('none');

model.sol('sol1').runAll;

model.result('pg2').run;
model.result('pg2').setIndex('looplevel', 23, 0);
model.result('pg2').run;
model.result('pg2').setIndex('looplevel', 39, 0);
model.result('pg2').run;
model.result('pg2').setIndex('looplevel', 77, 0);
model.result('pg2').run;
model.result('pg2').setIndex('looplevel', 145, 0);
model.result('pg2').run;
model.result('pg2').setIndex('looplevel', 179, 0);
model.result('pg2').run;
model.result('pg2').setIndex('looplevel', 231, 0);
model.result('pg2').run;
model.result('pg1').set('window', 'window1');
model.result('pg1').run;
model.result('pg2').run;
model.result('pg2').setIndex('looplevel', 39, 0);
model.result('pg2').run;

model.title('Dam Breaking on a Column, Shallow Water Equations');

model.description(['This transient model solves the shallow water equations to model the impact of a water wave on a column. A body of water with a height of 0.3' native2unicode(hex2dec({'00' 'a0'}), 'unicode') 'meters is initially contained behind a gate. At the start of the simulation, the gate is suddenly released and the body of water forms a wave moving toward the structure. After impacting on the structure, the water continues until it is reflected at the wall of the tank and impinges a second time on the column. The pressure force on the column is calculated and can be compared with experimental results.']);

model.mesh.clearMeshes;

model.sol('sol1').clearSolutionData;
model.sol('sol2').clearSolutionData;

model.label('dam_break_column_sw.mph');

model.modelNode.label('Components');

out = model;
