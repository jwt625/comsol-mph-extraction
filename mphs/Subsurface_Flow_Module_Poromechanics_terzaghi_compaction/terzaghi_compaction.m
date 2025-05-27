function out = model
%
% terzaghi_compaction.m
%
% Model exported on May 26 2025, 21:34 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/Subsurface_Flow_Module/Poromechanics');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 2);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.physics.create('dl', 'PorousMediaFlowDarcy', 'geom1');
model.physics('dl').model('comp1');

model.study.create('std1');
model.study('std1').create('time', 'Transient');
model.study('std1').feature('time').setSolveFor('/physics/dl', true);

model.geom('geom1').create('r1', 'Rectangle');
model.geom('geom1').feature('r1').set('size', [5200 440]);
model.geom('geom1').feature('r1').set('pos', [0 -440]);
model.geom('geom1').feature('r1').set('layertop', true);
model.geom('geom1').feature('r1').set('layerbottom', false);
model.geom('geom1').feature('r1').setIndex('layer', 20, 0);
model.geom('geom1').feature('r1').setIndex('layer', 20, 1);
model.geom('geom1').run('r1');
model.geom('geom1').create('r2', 'Rectangle');
model.geom('geom1').feature('r2').set('size', [1200 320]);
model.geom('geom1').feature('r2').set('pos', [4000 -440]);
model.geom('geom1').run('r2');
model.geom('geom1').create('dif1', 'Difference');
model.geom('geom1').feature('dif1').selection('input').set({'r1'});
model.geom('geom1').feature('dif1').selection('input2').set({'r2'});
model.geom('geom1').run('fin');

model.view('view1').axis.set('viewscaletype', 'automatic');

model.variable.create('var1');
model.variable('var1').model('comp1');
model.variable('var1').selection.geom('geom1', 2);
model.variable('var1').selection.set([1 3]);
model.variable('var1').set('S_sk', '1e-5[m^-1]');
model.variable('var1').descr('S_sk', 'Skeletal specific storage');
model.variable('var1').set('K_s', '25[m/day]');
model.variable('var1').descr('K_s', 'Saturated hydraulic conductivity');
model.variable.create('var2');
model.variable('var2').model('comp1');
model.variable('var2').selection.geom('geom1', 2);
model.variable('var2').selection.set([2]);
model.variable('var2').set('S_sk', '1e-4[m^-1]', 'Skeletal specific storage');
model.variable('var2').set('K_s', '0.01[m/day]', 'Saturated hydraulic conductivity');

model.material.create('mat1', 'Common', '');
model.material('mat1').label('Fluid');
model.material.create('pmat1', 'PorousMedia', 'comp1');
model.material('pmat1').selection.set([1 3]);
model.material('pmat1').set('porosity', '0.25');
model.material('pmat1').feature.create('fluid1', 'Fluid', 'comp1');
model.material.duplicate('pmat2', 'pmat1');
model.material('pmat2').selection.set([2]);
model.material('pmat2').set('porosity', '0.025');

model.physics('dl').prop('GravityEffects').set('IncludeGravity', true);
model.physics('dl').feature('gr1').set('GravityType', 'Elevation');
model.physics('dl').feature('porous1').set('storageModelType', 'userdef');
model.physics('dl').feature('porous1').set('Sp', 'S_sk/dl.rho/g_const');
model.physics('dl').feature('porous1').feature('fluid1').set('fluidType', 'compressibleLinearized');
model.physics('dl').feature('porous1').feature('pm1').set('permeabilityModelType', 'conductivity');
model.physics('dl').feature('porous1').feature('pm1').set('K', {'K_s' '0' '0' '0' 'K_s' '0' '0' '0' 'K_s'});

model.material('mat1').propertyGroup('def').set('density', {'1000'});
model.material('mat1').propertyGroup('def').set('compressibility', {'4e-10'});

model.physics('dl').create('hh1', 'HydraulicHead', 1);
model.physics('dl').feature('hh1').selection.set([1]);
model.physics('dl').feature('hh1').set('H0', '-6[m/year]*t');
model.physics('dl').create('hh2', 'HydraulicHead', 1);
model.physics('dl').feature('hh2').selection.set([5 7 12]);

model.cpl.create('genproj1', 'GeneralProjection', 'geom1');
model.cpl('genproj1').selection.all;

model.variable.create('var3');
model.variable('var3').model('comp1');
model.variable('var3').set('b', 'genproj1(-dl.H*(y<=dest(y))*S_sk)');
model.variable('var3').descr('b', 'Compaction');

model.mesh('mesh1').create('ftri1', 'FreeTri');
model.mesh('mesh1').feature('ftri1').set('yscale', 10);
model.mesh('mesh1').feature('size').set('hauto', 3);
model.mesh('mesh1').run;

model.study('std1').feature('time').set('tunit', 'a');
model.study('std1').feature('time').set('tlist', 'range(0,1,10)');

model.sol.create('sol1');

model.mesh('mesh1').stat.selection.geom(2);
model.mesh('mesh1').stat.selection.set([1 2 3]);

model.sol('sol1').study('std1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'time');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').set('control', 'time');
model.sol('sol1').create('t1', 'Time');
model.sol('sol1').feature('t1').set('tlist', 'range(0,1,10)');
model.sol('sol1').feature('t1').set('plot', 'off');
model.sol('sol1').feature('t1').set('plotgroup', 'Default');
model.sol('sol1').feature('t1').set('plotfreq', 'tout');
model.sol('sol1').feature('t1').set('probesel', 'all');
model.sol('sol1').feature('t1').set('probes', {});
model.sol('sol1').feature('t1').set('probefreq', 'tsteps');
model.sol('sol1').feature('t1').set('rtol', 0.005);
model.sol('sol1').feature('t1').set('atolglobalvaluemethod', 'factor');
model.sol('sol1').feature('t1').set('reacf', true);
model.sol('sol1').feature('t1').set('storeudot', true);
model.sol('sol1').feature('t1').set('endtimeinterpolation', true);
model.sol('sol1').feature('t1').set('maxorder', 2);
model.sol('sol1').feature('t1').set('stabcntrl', true);
model.sol('sol1').feature('t1').set('control', 'time');
model.sol('sol1').feature('t1').feature('aDef').set('cachepattern', true);
model.sol('sol1').feature('t1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('t1').feature('fc1').set('jtech', 'once');
model.sol('sol1').feature('t1').feature('fc1').set('maxiter', 8);
model.sol('sol1').feature('t1').feature('fc1').set('stabacc', 'aacc');
model.sol('sol1').feature('t1').feature('fc1').set('aaccdim', 5);
model.sol('sol1').feature('t1').feature('fc1').set('aaccmix', 0.9);
model.sol('sol1').feature('t1').feature('fc1').set('aaccdelay', 1);
model.sol('sol1').feature('t1').create('d1', 'Direct');
model.sol('sol1').feature('t1').feature('d1').set('linsolver', 'pardiso');
model.sol('sol1').feature('t1').feature('d1').set('pivotperturb', 1.0E-13);
model.sol('sol1').feature('t1').feature('d1').label('Direct, pressure (dl)');
model.sol('sol1').feature('t1').create('i1', 'Iterative');
model.sol('sol1').feature('t1').feature('i1').set('linsolver', 'gmres');
model.sol('sol1').feature('t1').feature('i1').set('prefuntype', 'left');
model.sol('sol1').feature('t1').feature('i1').set('itrestart', 50);
model.sol('sol1').feature('t1').feature('i1').set('rhob', 400);
model.sol('sol1').feature('t1').feature('i1').set('maxlinit', 50);
model.sol('sol1').feature('t1').feature('i1').set('nlinnormuse', 'on');
model.sol('sol1').feature('t1').feature('i1').label('AMG, pressure (dl)');
model.sol('sol1').feature('t1').feature('i1').create('mg1', 'Multigrid');
model.sol('sol1').feature('t1').feature('i1').feature('mg1').set('prefun', 'saamg');
model.sol('sol1').feature('t1').feature('i1').feature('mg1').set('mgcycle', 'v');
model.sol('sol1').feature('t1').feature('i1').feature('mg1').set('maxcoarsedof', 50000);
model.sol('sol1').feature('t1').feature('i1').feature('mg1').set('strconn', 0.01);
model.sol('sol1').feature('t1').feature('i1').feature('mg1').set('nullspace', 'constant');
model.sol('sol1').feature('t1').feature('i1').feature('mg1').set('usesmooth', false);
model.sol('sol1').feature('t1').feature('i1').feature('mg1').set('saamgcompwise', false);
model.sol('sol1').feature('t1').feature('i1').feature('mg1').set('loweramg', true);
model.sol('sol1').feature('t1').feature('i1').feature('mg1').set('compactaggregation', false);
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('pr').create('sl1', 'SORLine');
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('pr').feature('sl1').set('linesweeptype', 'ssor');
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('pr').feature('sl1').set('iter', 1);
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('pr').feature('sl1').set('linerelax', 0.7);
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('pr').feature('sl1').set('linealgorithm', 'mesh');
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('pr').feature('sl1').set('linemethod', 'coupled');
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('pr').feature('sl1').set('seconditer', 1);
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('pr').feature('sl1').set('relax', 0.5);
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('po').create('sl1', 'SORLine');
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('po').feature('sl1').set('linesweeptype', 'ssor');
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('po').feature('sl1').set('iter', 1);
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('po').feature('sl1').set('linerelax', 0.7);
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('po').feature('sl1').set('linealgorithm', 'mesh');
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('po').feature('sl1').set('linemethod', 'coupled');
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('po').feature('sl1').set('seconditer', 1);
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('po').feature('sl1').set('relax', 0.5);
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('cs').create('d1', 'Direct');
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('cs').feature('d1').set('linsolver', 'pardiso');
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('cs').feature('d1').set('pivotperturb', 1.0E-13);
model.sol('sol1').feature('t1').feature('fc1').set('linsolver', 'd1');
model.sol('sol1').feature('t1').feature('fc1').set('jtech', 'once');
model.sol('sol1').feature('t1').feature('fc1').set('maxiter', 8);
model.sol('sol1').feature('t1').feature('fc1').set('stabacc', 'aacc');
model.sol('sol1').feature('t1').feature('fc1').set('aaccdim', 5);
model.sol('sol1').feature('t1').feature('fc1').set('aaccmix', 0.9);
model.sol('sol1').feature('t1').feature('fc1').set('aaccdelay', 1);
model.sol('sol1').feature('t1').feature.remove('fcDef');
model.sol('sol1').attach('std1');
model.sol('sol1').runAll;

model.result.create('pg1', 'PlotGroup2D');
model.result('pg1').label('Pressure (dl)');
model.result('pg1').set('titletype', 'custom');
model.result('pg1').set('data', 'dset1');
model.result('pg1').setIndex('looplevel', 11, 0);
model.result('pg1').set('defaultPlotID', 'PhysicsInterfaces_PorousMediaFlow/icom6/pdef1/pcond2/pg1');
model.result('pg1').feature.create('surf1', 'Surface');
model.result('pg1').feature('surf1').label('Surface');
model.result('pg1').feature('surf1').set('showsolutionparams', 'on');
model.result('pg1').feature('surf1').set('smooth', 'internal');
model.result('pg1').feature('surf1').set('showsolutionparams', 'on');
model.result('pg1').feature('surf1').set('data', 'parent');
model.result('pg1').feature.create('str1', 'Streamline');
model.result('pg1').feature('str1').set('showsolutionparams', 'on');
model.result('pg1').feature('str1').set('posmethod', 'uniform');
model.result('pg1').feature('str1').set('pointtype', 'arrow');
model.result('pg1').feature('str1').set('arrowlength', 'logarithmic');
model.result('pg1').feature('str1').set('color', 'gray');
model.result('pg1').feature('str1').set('smooth', 'internal');
model.result('pg1').feature('str1').set('maxlen', Inf);
model.result('pg1').feature('str1').set('maxtime', Inf);
model.result('pg1').feature('str1').set('showsolutionparams', 'on');
model.result('pg1').feature('str1').set('maxlen', Inf);
model.result('pg1').feature('str1').set('maxtime', Inf);
model.result('pg1').feature('str1').set('showsolutionparams', 'on');
model.result('pg1').feature('str1').set('maxlen', Inf);
model.result('pg1').feature('str1').set('maxtime', Inf);
model.result('pg1').feature('str1').set('showsolutionparams', 'on');
model.result('pg1').feature('str1').set('maxlen', Inf);
model.result('pg1').feature('str1').set('maxtime', Inf);
model.result('pg1').feature('str1').set('showsolutionparams', 'on');
model.result('pg1').feature('str1').set('maxlen', Inf);
model.result('pg1').feature('str1').set('maxtime', Inf);
model.result('pg1').feature('str1').set('data', 'parent');
model.result('pg1').feature('str1').selection.geom('geom1', 1);
model.result('pg1').feature('str1').selection.set([1 2 3 4 5 6 7 8 9 10 11 12]);
model.result('pg1').run;
model.result('pg1').label('Hydraulic Head');
model.result('pg1').set('titletype', 'manual');
model.result('pg1').set('title', 'Time=10 years Surface: Hydraulic head (m) Streamline: Velocity field');
model.result('pg1').run;
model.result('pg1').feature('surf1').set('expr', 'dl.H');
model.result('pg1').feature('surf1').set('descr', 'Hydraulic head');
model.result('pg1').run;
model.result('pg1').feature('str1').set('posmethod', 'magnitude');
model.result('pg1').feature('str1').set('color', 'white');
model.result('pg1').run;
model.result.create('pg2', 'PlotGroup2D');
model.result('pg2').run;
model.result('pg2').label('Compaction');
model.result('pg2').create('con1', 'Contour');
model.result('pg2').feature('con1').set('expr', 'b');
model.result('pg2').feature('con1').set('descr', 'Compaction');
model.result('pg2').feature('con1').set('number', 15);
model.result('pg2').feature('con1').set('contourtype', 'filled');
model.result('pg2').feature('con1').set('colortable', 'Cividis');
model.result('pg2').run;

model.title('Terzaghi Compaction');

model.description('This example solves a conventional saturated fluid flow problem for change in hydraulic head and utilizes the results to assess the vertical compaction of sediments. The analysis is based on Terzaghi theory and the concept of effective stress. The solution is compared to published results. This example is modified in the Biot Poroelasticity model to analyze bidirectionally coupled fluid flow and solid deformation.');

model.label('terzaghi_compaction.mph');

model.modelNode.label('Components');

out = model;
