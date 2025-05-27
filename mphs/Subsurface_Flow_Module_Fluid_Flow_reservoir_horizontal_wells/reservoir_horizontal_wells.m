function out = model
%
% reservoir_horizontal_wells.m
%
% Model exported on May 26 2025, 21:34 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/Subsurface_Flow_Module/Fluid_Flow');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 3);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.physics.create('phtr', 'PhaseTransportPorousMedia', 'geom1', {'sw' 'sn'});
model.physics.create('dl', 'PorousMediaFlowDarcy', 'geom1');
model.physics('dl').model('comp1');

model.multiphysics.create('mfpm1', 'MultiphaseFlowInPorousMedia', 'geom1', 3);
model.multiphysics('mfpm1').set('multiphaseflow_physics', 'phtr');
model.multiphysics('mfpm1').set('darcyc_physics', 'dl');
model.multiphysics('mfpm1').selection.all;

model.study.create('std1');
model.study('std1').create('time', 'Transient');
model.study('std1').feature('time').setSolveFor('/physics/phtr', true);
model.study('std1').feature('time').setSolveFor('/physics/dl', true);
model.study('std1').feature('time').setSolveFor('/multiphysics/mfpm1', true);

model.geom('geom1').lengthUnit('ft');
model.geom('geom1').create('blk1', 'Block');
model.geom('geom1').feature('blk1').set('size', [2700 2700 160]);
model.geom('geom1').feature('blk1').set('layerbottom', false);
model.geom('geom1').feature('blk1').set('layertop', true);
model.geom('geom1').feature('blk1').setIndex('layer', 20, 0);
model.geom('geom1').feature('blk1').setIndex('layer', 20, 1);
model.geom('geom1').feature('blk1').setIndex('layer', 20, 2);
model.geom('geom1').feature('blk1').setIndex('layer', 20, 3);
model.geom('geom1').feature('blk1').setIndex('layer', 30, 4);

model.view('view1').set('renderwireframe', true);

model.geom('geom1').run('blk1');
model.geom('geom1').create('ls1', 'LineSegment');
model.geom('geom1').feature('ls1').set('specify1', 'coord');
model.geom('geom1').feature('ls1').set('coord1', [1350 0 25]);
model.geom('geom1').feature('ls1').set('specify2', 'coord');
model.geom('geom1').feature('ls1').set('coord2', [1350 2700 25]);
model.geom('geom1').run('ls1');
model.geom('geom1').create('ls2', 'LineSegment');
model.geom('geom1').feature('ls2').set('specify1', 'coord');
model.geom('geom1').feature('ls2').set('coord1', [1350 300 150]);
model.geom('geom1').feature('ls2').set('specify2', 'coord');
model.geom('geom1').feature('ls2').set('coord2', [1350 1200 150]);
model.geom('geom1').run('ls2');
model.geom('geom1').create('pt1', 'Point');
model.geom('geom1').feature('pt1').setIndex('p', 1300, 0);
model.geom('geom1').feature('pt1').setIndex('p', 150, 2);
model.geom('geom1').run('pt1');
model.geom('geom1').run('fin');
model.geom('geom1').create('mcv1', 'MeshControlVertices');
model.geom('geom1').feature('mcv1').selection('input').set('fin', 15);
model.geom('geom1').run('mcv1');

% To import content from file, use:
% model.param.loadFile('FILENAME');
model.param.set('rhow', '0.9814[g/cm^3]', 'Density water');
model.param.set('rhoo', '0.8975[g/cm^3]', 'Density oil');
model.param.set('muw', '0.96[cP]', 'Viscosity water');
model.param.set('muo', '0.954[cP]', 'Viscosity oil');
model.param.set('STB', '0.159[m^3]', 'Stock tank barrel');
model.param.set('massflow', '3000*STB/1[d]*rhow', 'Pump rate');

model.func.create('int1', 'Interpolation');
model.func('int1').set('table', {'0.22' '0';  ...
'0.3' '0.07';  ...
'0.4' '0.15';  ...
'0.5' '0.24';  ...
'0.6' '0.33';  ...
'0.8' '0.65';  ...
'0.9' '0.83';  ...
'1' '1'});
model.func('int1').set('funcname', 'krw');
model.func('int1').set('interp', 'piecewisecubic');
model.func.create('int2', 'Interpolation');
model.func('int2').set('table', {'0.22' '1';  ...
'0.3' '0.4';  ...
'0.4' '0.125';  ...
'0.5' '0.0649';  ...
'0.6' '0.0048';  ...
'0.8' '0';  ...
'0.9' '0';  ...
'1' '0'});
model.func('int2').set('funcname', 'krn');
model.func('int2').set('interp', 'piecewisecubic');
model.func.create('int3', 'Interpolation');
model.func('int3').set('table', {'0.22' '6.3';  ...
'0.3' '3.6';  ...
'0.4' '2.7';  ...
'0.5' '2.25';  ...
'0.6' '1.8';  ...
'0.8' '0.9';  ...
'0.9' '0.45';  ...
'1' '0'});
model.func('int3').set('funcname', 'pc');
model.func('int3').set('interp', 'piecewisecubic');

model.physics('phtr').prop('GravityEffects').set('IncludeGravity', true);
model.physics('phtr').feature('pptp1').setIndex('pc', 'pc(sw)[psi]', 1);
model.physics('phtr').feature('pptp1').set('rhoint_sw_mat', 'userdef');
model.physics('phtr').feature('pptp1').set('rhoint_sw', 'rhow');
model.physics('phtr').feature('pptp1').set('mu_sw_mat', 'userdef');
model.physics('phtr').feature('pptp1').set('mu_sw', 'muw');
model.physics('phtr').feature('pptp1').set('kappar_sw', 'krw(sw)');
model.physics('phtr').feature('pptp1').set('rhoint_sn_mat', 'userdef');
model.physics('phtr').feature('pptp1').set('rhoint_sn', 'rhoo');
model.physics('phtr').feature('pptp1').set('mu_sn_mat', 'userdef');
model.physics('phtr').feature('pptp1').set('mu_sn', 'muo');
model.physics('phtr').feature('pptp1').set('kappar_sn', 'krn(sw)');
model.physics('phtr').create('init2', 'InitialValues', 3);
model.physics('phtr').feature('init2').selection.set([6]);
model.physics('phtr').feature('init2').setIndex('s0', 0.711, 1);
model.physics('phtr').create('init3', 'InitialValues', 3);
model.physics('phtr').feature('init3').selection.set([5]);
model.physics('phtr').feature('init3').setIndex('s0', 0.652, 1);
model.physics('phtr').create('init4', 'InitialValues', 3);
model.physics('phtr').feature('init4').selection.set([4]);
model.physics('phtr').feature('init4').setIndex('s0', 0.527, 1);
model.physics('phtr').create('init5', 'InitialValues', 3);
model.physics('phtr').feature('init5').selection.set([3]);
model.physics('phtr').feature('init5').setIndex('s0', 0.351, 1);
model.physics('phtr').create('init6', 'InitialValues', 3);
model.physics('phtr').feature('init6').selection.set([2]);
model.physics('phtr').feature('init6').setIndex('s0', 0.131, 1);
model.physics('dl').prop('ShapeProperty').set('order_pressure', 1);
model.physics('dl').feature('porous1').feature('pm1').set('epsilon_mat', 'userdef');
model.physics('dl').feature('porous1').feature('pm1').set('epsilon', 0.2);
model.physics('dl').feature('porous1').feature('pm1').set('kappa_mat', 'userdef');
model.physics('dl').feature('porous1').feature('pm1').set('kappa', {'300[mD]' '0' '0' '0' '300[mD]' '0' '0' '0' '30[mD]'});
model.physics('dl').feature('init1').set('p', '3700[psi]');

model.multiphysics.create('wellmpe1', 'Welle', 'geom1', 1);
model.multiphysics('wellmpe1').selection.set([34]);
model.multiphysics('wellmpe1').set('wellInputType', 'Pressure');
model.multiphysics('wellmpe1').set('p0', '3700[psi]');
model.multiphysics.create('wellmpe2', 'Welle', 'geom1', 1);
model.multiphysics('wellmpe2').selection.set([35]);
model.multiphysics('wellmpe2').set('injectionProduction', 'Production');
model.multiphysics('wellmpe2').set('M0', 'massflow');
model.multiphysics('wellmpe2').set('wellInputType_sn', 'VolumeFraction');
model.multiphysics('wellmpe2').set('s0_sn', 0.2);

model.mesh('mesh1').create('ftri1', 'FreeTri');
model.mesh('mesh1').feature('ftri1').set('zscale', 10);
model.mesh('mesh1').feature('ftri1').selection.set([2 5 8 11 14 17]);
model.mesh('mesh1').feature('ftri1').create('size1', 'Size');
model.mesh('mesh1').feature('ftri1').feature('size1').selection.geom('geom1', 0);
model.mesh('mesh1').feature('ftri1').feature('size1').selection.set([33]);
model.mesh('mesh1').feature('ftri1').feature('size1').set('custom', true);
model.mesh('mesh1').feature('ftri1').feature('size1').set('hmaxactive', true);
model.mesh('mesh1').feature('ftri1').feature('size1').set('hmax', 6);
model.mesh('mesh1').feature('ftri1').feature('size1').set('hminactive', true);
model.mesh('mesh1').feature('ftri1').feature('size1').set('hmin', 0.1);
model.mesh('mesh1').feature('ftri1').feature('size1').set('hgradactive', true);
model.mesh('mesh1').feature('ftri1').feature('size1').set('hgrad', 1.1);
model.mesh('mesh1').feature('size').set('hauto', 3);
model.mesh('mesh1').create('swe1', 'Sweep');
model.mesh('mesh1').run;

model.study('std1').feature('time').set('tunit', 'd');
model.study('std1').feature('time').set('tlist', 'range(0,50,1500)');

model.sol.create('sol1');

model.mesh('mesh1').stat.selection.geom(3);
model.mesh('mesh1').stat.selection.set([1 2 3 4 5 6]);
model.mesh('mesh1').stat.selection.geom(3);
model.mesh('mesh1').stat.selection.set([1 2 3 4 5 6]);

model.sol('sol1').study('std1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'time');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').feature('comp1_sn').set('scalemethod', 'manual');
model.sol('sol1').feature('v1').feature('comp1_sn').set('scaleval', '1');
model.sol('sol1').feature('v1').set('control', 'time');
model.sol('sol1').create('t1', 'Time');
model.sol('sol1').feature('t1').set('tlist', 'range(0,50,1500)');
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
model.sol('sol1').feature('t1').create('seDef', 'Segregated');
model.sol('sol1').feature('t1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('t1').feature('fc1').set('jtech', 'onevery');
model.sol('sol1').feature('t1').feature('fc1').set('damp', 0.8);
model.sol('sol1').feature('t1').feature('fc1').set('maxiter', 10);
model.sol('sol1').feature('t1').feature('fc1').set('stabacc', 'aacc');
model.sol('sol1').feature('t1').feature('fc1').set('aaccdim', 5);
model.sol('sol1').feature('t1').feature('fc1').set('aaccmix', 0.9);
model.sol('sol1').feature('t1').feature('fc1').set('aaccdelay', 0);
model.sol('sol1').feature('t1').create('d1', 'Direct');
model.sol('sol1').feature('t1').feature('d1').set('linsolver', 'mumps');
model.sol('sol1').feature('t1').feature('d1').set('pivotperturb', 1.0E-13);
model.sol('sol1').feature('t1').feature('d1').label('Direct, multiphase flow in porous media (mfpm1) (Merged)');
model.sol('sol1').feature('t1').create('i1', 'Iterative');
model.sol('sol1').feature('t1').feature('i1').set('linsolver', 'gmres');
model.sol('sol1').feature('t1').feature('i1').set('prefuntype', 'left');
model.sol('sol1').feature('t1').feature('i1').set('itrestart', 50);
model.sol('sol1').feature('t1').feature('i1').set('rhob', 400);
model.sol('sol1').feature('t1').feature('i1').set('maxlinit', 50);
model.sol('sol1').feature('t1').feature('i1').set('nlinnormuse', 'on');
model.sol('sol1').feature('t1').feature('i1').label('AMG, multiphase flow in porous media (mfpm1)');
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
model.sol('sol1').feature('t1').feature('fc1').set('jtech', 'onevery');
model.sol('sol1').feature('t1').feature('fc1').set('damp', 0.8);
model.sol('sol1').feature('t1').feature('fc1').set('maxiter', 10);
model.sol('sol1').feature('t1').feature('fc1').set('stabacc', 'aacc');
model.sol('sol1').feature('t1').feature('fc1').set('aaccdim', 5);
model.sol('sol1').feature('t1').feature('fc1').set('aaccmix', 0.9);
model.sol('sol1').feature('t1').feature('fc1').set('aaccdelay', 0);
model.sol('sol1').feature('t1').feature.remove('fcDef');
model.sol('sol1').feature('t1').feature.remove('seDef');
model.sol('sol1').attach('std1');
model.sol('sol1').feature('v1').set('scalemethod', 'init');
model.sol('sol1').feature('t1').set('tstepsbdf', 'strict');
model.sol('sol1').runAll;

model.result.create('pg1', 'PlotGroup3D');
model.result('pg1').label('Volume Fraction (phtr)');
model.result('pg1').set('data', 'dset1');
model.result('pg1').setIndex('looplevel', 31, 0);
model.result('pg1').set('defaultPlotID', 'ResultDefaults_Phtr/icom2/pdef1/pcond1/pg1');
model.result('pg1').feature.create('slc1', 'Slice');
model.result('pg1').feature('slc1').label('Slice');
model.result('pg1').feature('slc1').set('showsolutionparams', 'on');
model.result('pg1').feature('slc1').set('smooth', 'internal');
model.result('pg1').feature('slc1').set('showsolutionparams', 'on');
model.result('pg1').feature('slc1').set('data', 'parent');
model.result.create('pg2', 'PlotGroup3D');
model.result('pg2').label('Volume Fraction (phtr) 1');
model.result('pg2').set('data', 'dset1');
model.result('pg2').setIndex('looplevel', 31, 0);
model.result('pg2').set('defaultPlotID', 'ResultDefaults_Phtr/icom2/pdef1/pcond1/pg2');
model.result('pg2').feature.create('surf1', 'Surface');
model.result('pg2').feature('surf1').label('Surface');
model.result('pg2').feature('surf1').set('showsolutionparams', 'on');
model.result('pg2').feature('surf1').set('smooth', 'internal');
model.result('pg2').feature('surf1').set('showsolutionparams', 'on');
model.result('pg2').feature('surf1').set('data', 'parent');
model.result.create('pg3', 'PlotGroup3D');
model.result('pg3').label('Velocity (dl)');
model.result('pg3').set('titletype', 'custom');
model.result('pg3').set('data', 'dset1');
model.result('pg3').setIndex('looplevel', 31, 0);
model.result('pg3').set('defaultPlotID', 'PhysicsInterfaces_PorousMediaFlow/icom6/pdef1/pcond1/pg1');
model.result('pg3').feature.create('str1', 'Streamline');
model.result('pg3').feature('str1').set('showsolutionparams', 'on');
model.result('pg3').feature('str1').set('posmethod', 'start');
model.result('pg3').feature('str1').set('pointtype', 'arrow');
model.result('pg3').feature('str1').set('arrowlength', 'logarithmic');
model.result('pg3').feature('str1').set('smooth', 'internal');
model.result('pg3').feature('str1').set('maxlen', Inf);
model.result('pg3').feature('str1').set('maxtime', Inf);
model.result('pg3').feature('str1').set('showsolutionparams', 'on');
model.result('pg3').feature('str1').set('maxlen', Inf);
model.result('pg3').feature('str1').set('maxtime', Inf);
model.result('pg3').feature('str1').set('showsolutionparams', 'on');
model.result('pg3').feature('str1').set('maxlen', Inf);
model.result('pg3').feature('str1').set('maxtime', Inf);
model.result('pg3').feature('str1').set('showsolutionparams', 'on');
model.result('pg3').feature('str1').set('maxlen', Inf);
model.result('pg3').feature('str1').set('maxtime', Inf);
model.result('pg3').feature('str1').set('showsolutionparams', 'on');
model.result('pg3').feature('str1').set('maxlen', Inf);
model.result('pg3').feature('str1').set('maxtime', Inf);
model.result('pg3').feature('str1').set('data', 'parent');
model.result('pg3').feature('str1').selection.geom('geom1', 2);
model.result('pg3').feature('str1').selection.set([1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31]);
model.result('pg3').feature('str1').feature.create('col1', 'Color');
model.result('pg3').feature('str1').feature('col1').set('expr', 'dl.U');
model.result.create('pg4', 'PlotGroup3D');
model.result('pg4').label('Pressure (dl)');
model.result('pg4').set('data', 'dset1');
model.result('pg4').setIndex('looplevel', 31, 0);
model.result('pg4').set('defaultPlotID', 'PhysicsInterfaces_PorousMediaFlow/icom6/pdef1/pcond1/pg2');
model.result('pg4').feature.create('surf1', 'Surface');
model.result('pg4').feature('surf1').label('Surface');
model.result('pg4').feature('surf1').set('showsolutionparams', 'on');
model.result('pg4').feature('surf1').set('expr', 'p');
model.result('pg4').feature('surf1').set('smooth', 'internal');
model.result('pg4').feature('surf1').set('showsolutionparams', 'on');
model.result('pg4').feature('surf1').set('data', 'parent');
model.result('pg1').run;
model.result('pg1').run;
model.result('pg1').feature('slc1').active(false);
model.result('pg1').run;
model.result('pg1').create('mslc1', 'Multislice');
model.result('pg1').feature('mslc1').set('expr', 'sn');
model.result('pg1').feature('mslc1').set('xnumber', '5');
model.result('pg1').feature('mslc1').set('ynumber', '5');
model.result('pg1').feature('mslc1').set('znumber', '0');
model.result('pg1').run;

model.view.create('view2', 3);
model.view('view2').camera.set('viewscaletype', 'manual');
model.view('view2').camera.set('zscale', 5);

model.result('pg1').run;
model.result('pg1').set('view', 'view2');
model.result('pg1').run;
model.result.create('pg5', 'PlotGroup1D');
model.result('pg5').run;
model.result('pg5').setIndex('looplevelinput', 'interp', 0);
model.result('pg5').setIndex('interp', 'range(100,50,1500)', 0);
model.result('pg5').create('ptgr1', 'PointGraph');
model.result('pg5').feature('ptgr1').set('markerpos', 'datapoints');
model.result('pg5').feature('ptgr1').set('linewidth', 'preference');
model.result('pg5').feature('ptgr1').selection.set([17]);
model.result('pg5').feature('ptgr1').set('expr', 'wellmpe2.M0_sn/rhoo/STB');
model.result('pg5').feature('ptgr1').set('unit', '1/d');
model.result('pg5').feature('ptgr1').set('descractive', true);
model.result('pg5').feature('ptgr1').set('descr', 'Oil rate (STB/day)');
model.result('pg5').feature('ptgr1').set('legend', true);
model.result('pg5').feature('ptgr1').set('legendmethod', 'manual');
model.result('pg5').feature('ptgr1').setIndex('legends', 'Oil rate (STB/day)', 0);
model.result('pg5').run;
model.result('pg5').create('ptgr2', 'PointGraph');
model.result('pg5').feature('ptgr2').set('markerpos', 'datapoints');
model.result('pg5').feature('ptgr2').set('linewidth', 'preference');
model.result('pg5').feature('ptgr2').selection.set([17]);
model.result('pg5').feature('ptgr2').set('expr', '(massflow-wellmpe2.M0_sn)/rhow/(wellmpe2.M0_sn/rhoo)');
model.result('pg5').feature('ptgr2').set('descractive', true);
model.result('pg5').feature('ptgr2').set('descr', 'Water-oil ratio');
model.result('pg5').feature('ptgr2').set('legend', true);
model.result('pg5').feature('ptgr2').set('legendmethod', 'manual');
model.result('pg5').feature('ptgr2').setIndex('legends', 'Water-oil ratio', 0);
model.result('pg5').run;
model.result('pg5').label('Oil Rate and Water-Oil Ratio');
model.result('pg5').set('twoyaxes', true);
model.result('pg5').setIndex('plotonsecyaxis', true, 1, 1);
model.result('pg5').set('ylabelactive', true);
model.result('pg5').set('ylabel', 'Oil rate (STB/day)');
model.result('pg5').run;

model.title('Reservoir with Horizontal Wells');

model.description('This example models a thin oil reservoir with two horizontal wells. The reservoir contains two phases, water and oil. The oil is recovered by injecting water through the bottom well. The model is used to compute the oil production rate and the water-oil production ratio over time.');

model.mesh.clearMeshes;

model.sol('sol1').clearSolutionData;

model.label('reservoir_horizontal_wells.mph');

model.modelNode.label('Components');

out = model;
