function out = model
%
% low_permeable_lens.m
%
% Model exported on May 26 2025, 21:32 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/Porous_Media_Flow_Module/Fluid_Flow');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 2);
model.geom('geom1').model('comp1');
model.geom('geom1').axisymmetric(true);

model.mesh.create('mesh1', 'geom1');

model.physics.create('phtr', 'PhaseTransportPorousMedia', 'geom1', {'s1' 's2'});
model.physics.create('dl', 'PorousMediaFlowDarcy', 'geom1');
model.physics('dl').model('comp1');

model.multiphysics.create('mfpm1', 'MultiphaseFlowInPorousMedia', 'geom1', 2);
model.multiphysics('mfpm1').set('multiphaseflow_physics', 'phtr');
model.multiphysics('mfpm1').set('darcyc_physics', 'dl');
model.multiphysics('mfpm1').selection.all;

model.study.create('std1');
model.study('std1').create('time', 'Transient');
model.study('std1').feature('time').setSolveFor('/physics/phtr', true);
model.study('std1').feature('time').setSolveFor('/physics/dl', true);
model.study('std1').feature('time').setSolveFor('/multiphysics/mfpm1', true);

model.geom('geom1').create('r1', 'Rectangle');
model.geom('geom1').feature('r1').set('size', [0.5 0.65]);
model.geom('geom1').run('r1');
model.geom('geom1').create('r2', 'Rectangle');
model.geom('geom1').feature('r2').set('size', [0.32 0.12]);
model.geom('geom1').feature('r2').set('pos', [0 0.35]);
model.geom('geom1').run('r2');
model.geom('geom1').create('pt1', 'Point');
model.geom('geom1').feature('pt1').setIndex('p', 0.07, 0);
model.geom('geom1').feature('pt1').setIndex('p', 0.65, 1);
model.geom('geom1').runPre('fin');
model.geom('geom1').run('fin');

model.view('view1').set('showlabels', false);

model.physics('phtr').prop('GravityEffects').set('IncludeGravity', true);
model.physics('phtr').feature('pptp1').set('capillarypressuremodel', 'BrooksCorey');
model.physics('phtr').feature('pptp1').set('pec', 1163.5);
model.physics('phtr').feature('pptp1').set('rhoint_s1_mat', 'userdef');
model.physics('phtr').feature('pptp1').set('mu_s1_mat', 'userdef');
model.physics('phtr').feature('pptp1').set('sr_s1', 0.12);
model.physics('phtr').feature('pptp1').set('rhoint_s2_mat', 'userdef');
model.physics('phtr').feature('pptp1').set('rhoint_s2', '1460[kg/m^3]');
model.physics('phtr').feature('pptp1').set('mu_s2_mat', 'userdef');
model.physics('phtr').feature('pptp1').set('mu_s2', '0.0009[Pa*s]');
model.physics('phtr').create('pptp2', 'PhaseAndPorousMediaTransportProperties', 2);
model.physics('phtr').feature('pptp2').selection.set([1]);
model.physics('phtr').feature('pptp2').set('capillarypressuremodel', 'BrooksCorey');
model.physics('phtr').feature('pptp2').set('pec', 755);
model.physics('phtr').feature('pptp2').set('lambdap', 2.7);
model.physics('phtr').feature('pptp2').set('rhoint_s1_mat', 'userdef');
model.physics('phtr').feature('pptp2').set('mu_s1_mat', 'userdef');
model.physics('phtr').feature('pptp2').set('sr_s1', 0.1);
model.physics('phtr').feature('pptp2').set('rhoint_s2_mat', 'userdef');
model.physics('phtr').feature('pptp2').set('rhoint_s2', '1460[kg/m^3]');
model.physics('phtr').feature('pptp2').set('mu_s2_mat', 'userdef');
model.physics('phtr').feature('pptp2').set('mu_s2', '0.0009[Pa*s]');
model.physics('phtr').create('mf1', 'MassFlux', 1);
model.physics('phtr').feature('mf1').selection.set([7]);
model.physics('phtr').feature('mf1').setIndex('phases', true, 1);
model.physics('phtr').feature('mf1').setIndex('q0', 0.25, 1);
model.physics('phtr').create('sa1', 'VolumeFraction', 1);
model.physics('phtr').feature('sa1').selection.set([2 10]);
model.physics('phtr').feature('sa1').setIndex('phases', true, 1);
model.physics('phtr').feature('sa1').set('constraintOptions', 'weakConstraints');
model.physics('phtr').create('pmd1', 'PorousMediumDiscontinuity', 1);
model.physics('phtr').feature('pmd1').selection.set([4 6 9]);
model.physics('dl').prop('GravityEffects').set('IncludeGravity', true);
model.physics('dl').feature('gr1').set('useRref', true);
model.physics('dl').feature('gr1').set('rref', {'r' '0' '0.65'});
model.physics('dl').feature('porous1').feature('pm1').set('epsilon_mat', 'userdef');
model.physics('dl').feature('porous1').feature('pm1').set('epsilon', 0.39);
model.physics('dl').feature('porous1').feature('pm1').set('kappa_mat', 'userdef');
model.physics('dl').feature('porous1').feature('pm1').set('kappa', {'3.32e-11[m^2]' '0' '0' '0' '3.32e-11[m^2]' '0' '0' '0' '3.32e-11[m^2]'});
model.physics('dl').create('porous2', 'PorousMedium', 2);
model.physics('dl').feature('porous2').selection.set([1]);
model.physics('dl').feature('porous2').feature('pm1').set('epsilon_mat', 'userdef');
model.physics('dl').feature('porous2').feature('pm1').set('epsilon', 0.4);
model.physics('dl').feature('porous2').feature('pm1').set('kappa_mat', 'userdef');
model.physics('dl').feature('porous2').feature('pm1').set('kappa', {'6.64e-11[m^2]' '0' '0' '0' '6.64e-11[m^2]' '0' '0' '0' '6.64e-11[m^2]'});
model.physics('dl').feature('init1').set('InitType', 'H');
model.physics('dl').create('inl1', 'Inlet', 1);
model.physics('dl').feature('inl1').selection.set([7]);
model.physics('dl').feature('inl1').set('BoundaryCondition', 'MassFlow');
model.physics('dl').feature('inl1').set('MassFlowType', 'PointWiseMassFlux');
model.physics('dl').feature('inl1').set('N0', 0.25);
model.physics('dl').create('pr1', 'Pressure', 1);
model.physics('dl').feature('pr1').selection.set([10]);
model.physics('dl').feature('pr1').set('p0', '(0.65-z)*g_const*1000[kg/m^3]');
model.physics('dl').create('mf1', 'MassFlux', 1);
model.physics('dl').feature('mf1').selection.set([2]);
model.physics('dl').feature('mf1').set('N0', 's2_lm');

model.mesh('mesh1').create('ftri1', 'FreeTri');
model.mesh('mesh1').feature('size').set('custom', true);
model.mesh('mesh1').feature('size').set('hmax', 0.01);

model.study('std1').feature('time').set('tlist', 'range(0,60,6000)');

model.sol.create('sol1');

model.mesh('mesh1').stat.selection.geom(2);
model.mesh('mesh1').stat.selection.set([1 2]);
model.mesh('mesh1').stat.selection.geom(2);
model.mesh('mesh1').stat.selection.set([1 2]);

model.sol('sol1').study('std1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'time');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').feature('comp1_s2').set('scalemethod', 'manual');
model.sol('sol1').feature('v1').feature('comp1_s2').set('scaleval', '1');
model.sol('sol1').feature('v1').set('control', 'time');
model.sol('sol1').create('t1', 'Time');
model.sol('sol1').feature('t1').set('tlist', 'range(0,60,6000)');
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
model.sol('sol1').feature('t1').feature('fc1').set('aaccdelay', 1);
model.sol('sol1').feature('t1').create('d1', 'Direct');
model.sol('sol1').feature('t1').feature('d1').set('linsolver', 'pardiso');
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
model.sol('sol1').feature('t1').feature('i1').feature('mg1').set('compactaggregation', true);
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('pr').create('va1', 'Vanka');
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('pr').feature('va1').set('linesweeptype', 'ssor');
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('pr').feature('va1').set('iter', 1);
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('pr').feature('va1').set('seconditer', 1);
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('pr').feature('va1').set('relax', 0.5);
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('pr').feature('va1').set('vankavars', {'comp1_s2_lm'});
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('po').create('va1', 'Vanka');
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('po').feature('va1').set('linesweeptype', 'ssor');
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('po').feature('va1').set('iter', 1);
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('po').feature('va1').set('seconditer', 2);
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('po').feature('va1').set('relax', 0.5);
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('po').feature('va1').set('vankavars', {'comp1_s2_lm'});
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
model.sol('sol1').feature('t1').feature('fc1').set('aaccdelay', 1);
model.sol('sol1').feature('t1').feature.remove('fcDef');
model.sol('sol1').feature('t1').feature.remove('seDef');
model.sol('sol1').attach('std1');
model.sol('sol1').feature('v1').set('scalemethod', 'init');
model.sol('sol1').runAll;

model.result.create('pg1', 'PlotGroup2D');
model.result('pg1').label('Volume Fraction (phtr)');
model.result('pg1').set('dataisaxisym', 'off');
model.result('pg1').set('data', 'dset1');
model.result('pg1').setIndex('looplevel', 101, 0);
model.result('pg1').set('defaultPlotID', 'ResultDefaults_Phtr/icom2/pdef1/pcond2/pg1');
model.result('pg1').feature.create('surf1', 'Surface');
model.result('pg1').feature('surf1').label('Surface');
model.result('pg1').feature('surf1').set('showsolutionparams', 'on');
model.result('pg1').feature('surf1').set('smooth', 'internal');
model.result('pg1').feature('surf1').set('showsolutionparams', 'on');
model.result('pg1').feature('surf1').set('data', 'parent');
model.result.dataset.create('rev1', 'Revolve2D');
model.result.dataset('rev1').label('Revolution 2D');
model.result.dataset('rev1').set('data', 'none');
model.result.dataset('rev1').set('startangle', -90);
model.result.dataset('rev1').set('revangle', 225);
model.result.dataset('rev1').set('data', 'dset1');
model.result.create('pg2', 'PlotGroup3D');
model.result('pg2').label('Volume Fraction (phtr) 1');
model.result('pg2').set('data', 'rev1');
model.result('pg2').setIndex('looplevel', 101, 0);
model.result('pg2').set('defaultPlotID', 'ResultDefaults_Phtr/icom2/pdef1/pcond2/pcond1/pg1');
model.result('pg2').feature.create('surf1', 'Surface');
model.result('pg2').feature('surf1').label('Surface');
model.result('pg2').feature('surf1').set('showsolutionparams', 'on');
model.result('pg2').feature('surf1').set('smooth', 'internal');
model.result('pg2').feature('surf1').set('showsolutionparams', 'on');
model.result('pg2').feature('surf1').set('data', 'parent');
model.result.dataset('rev1').set('data', 'dset1');
model.result.create('pg3', 'PlotGroup2D');
model.result('pg3').label('Pressure (dl)');
model.result('pg3').set('titletype', 'custom');
model.result('pg3').set('dataisaxisym', 'off');
model.result('pg3').set('data', 'dset1');
model.result('pg3').setIndex('looplevel', 101, 0);
model.result('pg3').set('defaultPlotID', 'PhysicsInterfaces_PorousMediaFlow/icom6/pdef1/pcond4/pg1');
model.result('pg3').feature.create('surf1', 'Surface');
model.result('pg3').feature('surf1').label('Surface');
model.result('pg3').feature('surf1').set('showsolutionparams', 'on');
model.result('pg3').feature('surf1').set('expr', 'p');
model.result('pg3').feature('surf1').set('smooth', 'internal');
model.result('pg3').feature('surf1').set('showsolutionparams', 'on');
model.result('pg3').feature('surf1').set('data', 'parent');
model.result('pg3').feature.create('str1', 'Streamline');
model.result('pg3').feature('str1').set('showsolutionparams', 'on');
model.result('pg3').feature('str1').set('posmethod', 'uniform');
model.result('pg3').feature('str1').set('pointtype', 'arrow');
model.result('pg3').feature('str1').set('arrowlength', 'logarithmic');
model.result('pg3').feature('str1').set('color', 'gray');
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
model.result('pg3').feature('str1').selection.geom('geom1', 1);
model.result('pg3').feature('str1').selection.set([1 2 3 4 5 6 7 8 9 10]);
model.result.create('pg4', 'PlotGroup3D');
model.result('pg4').label('Pressure, 3D (dl)');
model.result('pg4').set('data', 'rev1');
model.result('pg4').setIndex('looplevel', 101, 0);
model.result('pg4').set('defaultPlotID', 'PhysicsInterfaces_PorousMediaFlow/icom6/pdef1/pcond4/pg2');
model.result('pg4').feature.create('surf1', 'Surface');
model.result('pg4').feature('surf1').label('Surface');
model.result('pg4').feature('surf1').set('showsolutionparams', 'on');
model.result('pg4').feature('surf1').set('expr', 'p');
model.result('pg4').feature('surf1').set('smooth', 'internal');
model.result('pg4').feature('surf1').set('showsolutionparams', 'on');
model.result('pg4').feature('surf1').set('data', 'parent');
model.result('pg1').run;
model.result.create('pg5', 'PlotGroup3D');
model.result('pg5').run;
model.result('pg5').setIndex('looplevel', 61, 0);
model.result('pg5').set('edges', false);
model.result('pg5').label('Volume Fraction of Phase 2');

model.view('view2').set('showgrid', false);

model.result('pg5').create('iso1', 'Isosurface');
model.result('pg5').feature('iso1').set('expr', 's2');
model.result('pg5').feature('iso1').set('colortable', 'JupiterAuroraBorealis');
model.result('pg5').run;
model.result('pg5').create('surf1', 'Surface');
model.result('pg5').feature('surf1').set('expr', '1');
model.result('pg5').feature('surf1').set('coloring', 'uniform');
model.result('pg5').feature('surf1').set('color', 'gray');
model.result('pg5').feature('surf1').create('sel1', 'Selection');
model.result('pg5').feature('surf1').feature('sel1').selection.set([2]);
model.result('pg5').feature('surf1').feature('sel1').set('evalstartcap', false);
model.result('pg5').feature('surf1').feature('sel1').set('evalendcap', false);
model.result('pg5').run;
model.result('pg5').feature('surf1').feature('sel1').selection.set([1]);
model.result('pg5').run;
model.result('pg5').run;
model.result('pg5').create('surf2', 'Surface');
model.result('pg5').feature('surf2').set('expr', '1');
model.result('pg5').feature('surf2').set('coloring', 'uniform');
model.result('pg5').feature('surf2').set('titletype', 'none');
model.result('pg5').feature('surf2').create('sel1', 'Selection');
model.result('pg5').feature('surf2').feature('sel1').selection.set([2]);
model.result('pg5').feature('surf2').feature('sel1').set('evalstartcap', false);
model.result('pg5').feature('surf2').feature('sel1').set('evalendcap', false);
model.result('pg5').run;
model.result('pg5').run;
model.result('pg5').setIndex('looplevel', 13, 0);
model.result('pg5').run;
model.result('pg5').setIndex('looplevel', 61, 0);
model.result('pg5').run;
model.result.create('pg6', 'PlotGroup2D');
model.result('pg6').run;
model.result('pg6').create('con1', 'ContourSeries');
model.result('pg6').feature('con1').set('level', '0.75');
model.result('pg6').feature('con1').setIndex('looplevelinput', 'manualindices', 0);
model.result('pg6').feature('con1').setIndex('looplevelindices', 'range(1,10,101)', 0);
model.result('pg6').feature('con1').create('col1', 'Color');
model.result('pg6').run;
model.result('pg6').feature('con1').feature('col1').set('expr', 't');
model.result('pg6').feature('con1').feature('col1').set('colortabletype', 'discrete');
model.result('pg6').run;
model.result('pg6').run;
model.result('pg6').label('Volume fraction, contour series');
model.result.create('pg7', 'PlotGroup3D');
model.result('pg7').run;
model.result('pg7').label('Volume fraction, isosurface series');
model.result('pg7').create('iso1', 'IsosurfaceSeries');
model.result('pg7').feature('iso1').set('expr', 's2');
model.result('pg7').feature('iso1').set('level', '0.2');
model.result('pg7').feature('iso1').setIndex('looplevelinput', 'manualindices', 0);
model.result('pg7').feature('iso1').setIndex('looplevelindices', 'range(1,20,101)', 0);
model.result('pg7').feature('iso1').create('col1', 'Color');
model.result('pg7').run;
model.result('pg7').feature('iso1').feature('col1').set('expr', 't');
model.result('pg7').feature('iso1').feature('col1').set('unit', 'min');
model.result('pg7').feature('iso1').feature('col1').set('colortabletype', 'discrete');
model.result('pg7').feature('iso1').feature('col1').set('colortable', 'Cividis');
model.result('pg7').feature('iso1').feature('col1').set('bandcount', 4);
model.result('pg7').run;

model.title('Two-Phase Flow over a Low Permeable Lens');

model.description('This example concerns two-phase flow in a porous medium which contains a low permeable lens. The heavier phase infiltrates the porous medium from above, and the low permeable lens is infiltrated only when a critical saturation at the outside of the lens is reached. As the saturation of the heavier phase is discontinuous at the boundary of the lens, this requires the use of the Porous Medium Discontinuity boundary condition.');

model.mesh.clearMeshes;

model.sol('sol1').clearSolutionData;

model.label('low_permeable_lens.mph');

model.modelNode.label('Components');

out = model;
