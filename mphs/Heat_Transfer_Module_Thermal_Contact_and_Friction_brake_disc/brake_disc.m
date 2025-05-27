function out = model
%
% brake_disc.m
%
% Model exported on May 26 2025, 21:29 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/Heat_Transfer_Module/Thermal_Contact_and_Friction');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 3);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.physics.create('ht', 'HeatTransfer', 'geom1');
model.physics('ht').model('comp1');

model.study.create('std1');
model.study('std1').create('time', 'Transient');
model.study('std1').feature('time').setSolveFor('/physics/ht', true);

% To import content from file, use:
% model.param.loadFile('FILENAME');
model.param.set('mu', '0.3', 'Friction coefficient');
model.param.set('v0', '25[m/s]', 'Initial vehicle speed');
model.param.set('a0', '-10[m/s^2]', 'Initial vehicle acceleration');
model.param.set('r_wheel', '0.25[m]', 'Wheel radius');
model.param.set('m_car', '1800[kg]', 'Vehicle mass');
model.param.set('t_brake_start', '2[s]', 'Braking time (start)');
model.param.set('t_brake_end', '4[s]', 'Braking time (end)');
model.param.set('T_air', '300[K]', '     Temperature, air');

model.geom('geom1').create('cyl1', 'Cylinder');
model.geom('geom1').feature('cyl1').set('r', 0.14);
model.geom('geom1').feature('cyl1').set('h', 0.013);
model.geom('geom1').run('fin');
model.geom('geom1').run('cyl1');
model.geom('geom1').create('cyl2', 'Cylinder');
model.geom('geom1').feature('cyl2').set('r', 0.08);
model.geom('geom1').feature('cyl2').set('h', 0.01);
model.geom('geom1').feature('cyl2').set('pos', [0 0 0.013]);
model.geom('geom1').run('fin');
model.geom('geom1').run('cyl2');
model.geom('geom1').create('wp1', 'WorkPlane');
model.geom('geom1').feature('wp1').set('unite', true);
model.geom('geom1').feature('wp1').set('quickz', 0.013);
model.geom('geom1').feature('wp1').geom.create('cb1', 'CubicBezier');
model.geom('geom1').feature('wp1').geom.feature('cb1').setIndex('p', 0.135, 1, 0);
model.geom('geom1').feature('wp1').geom.feature('cb1').setIndex('p', 0.02, 0, 1);
model.geom('geom1').feature('wp1').geom.feature('cb1').setIndex('p', 0.135, 1, 1);
model.geom('geom1').feature('wp1').geom.feature('cb1').setIndex('p', 0.05, 0, 2);
model.geom('geom1').feature('wp1').geom.feature('cb1').setIndex('p', 0.13, 1, 2);
model.geom('geom1').feature('wp1').geom.feature('cb1').setIndex('p', 0.04, 0, 3);
model.geom('geom1').feature('wp1').geom.feature('cb1').setIndex('p', 0.105, 1, 3);
model.geom('geom1').feature('wp1').geom.feature('cb1').setIndex('w', 2.5, 2);
model.geom('geom1').feature('wp1').geom.run('cb1');
model.geom('geom1').feature('wp1').geom.create('cb2', 'CubicBezier');
model.geom('geom1').feature('wp1').geom.feature('cb2').setIndex('p', 0.04, 0, 0);
model.geom('geom1').feature('wp1').geom.feature('cb2').setIndex('p', 0.105, 1, 0);
model.geom('geom1').feature('wp1').geom.feature('cb2').setIndex('p', 0.03, 0, 1);
model.geom('geom1').feature('wp1').geom.feature('cb2').setIndex('p', 0.08, 1, 1);
model.geom('geom1').feature('wp1').geom.feature('cb2').setIndex('p', 0.035, 0, 2);
model.geom('geom1').feature('wp1').geom.feature('cb2').setIndex('p', 0.09, 1, 2);
model.geom('geom1').feature('wp1').geom.feature('cb2').setIndex('p', 0.09, 1, 3);
model.geom('geom1').feature('wp1').geom.run('cb2');
model.geom('geom1').feature('wp1').geom.create('cb3', 'CubicBezier');
model.geom('geom1').feature('wp1').geom.feature('cb3').setIndex('p', 0.09, 1, 0);
model.geom('geom1').feature('wp1').geom.feature('cb3').setIndex('p', -0.035, 0, 1);
model.geom('geom1').feature('wp1').geom.feature('cb3').setIndex('p', 0.09, 1, 1);
model.geom('geom1').feature('wp1').geom.feature('cb3').setIndex('p', -0.03, 0, 2);
model.geom('geom1').feature('wp1').geom.feature('cb3').setIndex('p', 0.08, 1, 2);
model.geom('geom1').feature('wp1').geom.feature('cb3').setIndex('p', -0.04, 0, 3);
model.geom('geom1').feature('wp1').geom.feature('cb3').setIndex('p', 0.105, 1, 3);
model.geom('geom1').feature('wp1').geom.run('cb3');
model.geom('geom1').feature('wp1').geom.create('cb4', 'CubicBezier');
model.geom('geom1').feature('wp1').geom.feature('cb4').setIndex('p', -0.04, 0, 0);
model.geom('geom1').feature('wp1').geom.feature('cb4').setIndex('p', -0.05, 0, 1);
model.geom('geom1').feature('wp1').geom.feature('cb4').setIndex('p', 0.105, 1, 0);
model.geom('geom1').feature('wp1').geom.feature('cb4').setIndex('p', 0.13, 1, 1);
model.geom('geom1').feature('wp1').geom.feature('cb4').setIndex('p', -0.02, 0, 2);
model.geom('geom1').feature('wp1').geom.feature('cb4').setIndex('p', 0.135, 1, 2);
model.geom('geom1').feature('wp1').geom.feature('cb4').setIndex('p', 0.135, 1, 3);
model.geom('geom1').feature('wp1').geom.feature('cb4').setIndex('w', 2.5, 1);
model.geom('geom1').feature('wp1').geom.run('cb4');
model.geom('geom1').feature('wp1').geom.create('csol1', 'ConvertToSolid');
model.geom('geom1').feature('wp1').geom.feature('csol1').selection('input').set({'cb1' 'cb2' 'cb3' 'cb4'});
model.geom('geom1').feature('wp1').geom.run('csol1');
model.geom('geom1').run('wp1');
model.geom('geom1').feature.create('ext1', 'Extrude');
model.geom('geom1').feature('ext1').set('workplane', 'wp1');
model.geom('geom1').feature('ext1').selection('input').set({'wp1'});
model.geom('geom1').feature('ext1').setIndex('distance', 0.0065, 0);
model.geom('geom1').run('fin');

model.selection.create('sel1', 'Explicit');
model.selection('sel1').model('comp1');
model.selection('sel1').label('Disc Faces');
model.selection('sel1').geom(2);
model.selection('sel1').set([1 2 4 5 6 8 13 14 15 18]);
model.selection.create('sel2', 'Explicit');
model.selection('sel2').model('comp1');
model.selection('sel2').label('Pad Faces');
model.selection('sel2').geom(2);
model.selection('sel2').set([9 10 12 16 17]);
model.selection.create('sel3', 'Explicit');
model.selection('sel3').model('comp1');
model.selection('sel3').label('Contact Faces');
model.selection('sel3').geom(2);

model.view('view1').set('renderwireframe', true);

model.selection('sel3').set([11]);

model.view('view1').set('renderwireframe', false);

model.selection.create('sel4', 'Explicit');
model.selection('sel4').model('comp1');
model.selection('sel4').label('External Surfaces');
model.selection('sel4').all;
model.selection('sel4').geom('geom1', 3, 2, {'exterior'});
model.selection('sel4').all;

model.cpl.create('intop1', 'Integration', 'geom1');
model.cpl('intop1').set('axisym', true);
model.cpl('intop1').selection.geom('geom1', 2);
model.cpl('intop1').selection.named('sel3');
model.cpl.create('intop2', 'Integration', 'geom1');
model.cpl('intop2').set('axisym', true);
model.cpl('intop2').selection.geom('geom1', 2);
model.cpl('intop2').selection.named('sel4');

model.func.create('pw1', 'Piecewise');
model.func('pw1').model('comp1');
model.func('pw1').set('funcname', 'v');
model.func('pw1').set('arg', 't');
model.func('pw1').set('smooth', 'contd2');
model.func('pw1').set('zonelengthtype', 'absolute');
model.func('pw1').set('smoothzone', 0.2);
model.func('pw1').setIndex('pieces', 0, 0, 0);
model.func('pw1').setIndex('pieces', 't_brake_start[1/s]', 0, 1);
model.func('pw1').setIndex('pieces', 'v0[s/m]', 0, 2);
model.func('pw1').setIndex('pieces', 't_brake_start[1/s]', 1, 0);
model.func('pw1').setIndex('pieces', 't_brake_end[1/s]', 1, 1);
model.func('pw1').setIndex('pieces', 'v0[s/m]+a0*(t[s]-t_brake_start)[s/m]', 1, 2);
model.func('pw1').setIndex('pieces', 't_brake_end[1/s]', 2, 0);
model.func('pw1').setIndex('pieces', 12, 2, 1);
model.func('pw1').setIndex('pieces', 'v0[s/m]+a0*(t_brake_end-t_brake_start)[s/m]', 2, 2);
model.func('pw1').set('argunit', 's');
model.func('pw1').set('fununit', 'm/s');
model.func.create('an1', 'Analytic');
model.func('an1').model('comp1');
model.func('an1').set('funcname', 'a');
model.func('an1').set('expr', 'd(v(t),t)');
model.func('an1').set('args', 't');
model.func('an1').setIndex('argunit', 's', 0);
model.func('an1').set('fununit', 'm/s^2');
model.func('an1').setIndex('plotargs', 10, 0, 2);

model.material.create('mat1', 'Common', 'comp1');
model.material('mat1').label('Disc');
model.material('mat1').propertyGroup('def').set('thermalconductivity', {'82'});
model.material('mat1').propertyGroup('def').set('density', {'7870'});
model.material('mat1').propertyGroup('def').set('heatcapacity', {'449'});
model.material.create('mat2', 'Common', 'comp1');
model.material('mat2').label('Pad');
model.material('mat2').selection.set([3]);
model.material('mat2').propertyGroup('def').set('thermalconductivity', {'8.7'});
model.material('mat2').propertyGroup('def').set('density', {'2000'});
model.material('mat2').propertyGroup('def').set('heatcapacity', {'935'});

model.physics('ht').create('solidtrm1', 'SolidWithTranslationalMotion', 3);
model.physics('ht').feature('solidtrm1').selection.all;
model.physics('ht').feature('solidtrm1').feature('trm1').selection.set([1 2]);
model.physics('ht').feature('solidtrm1').feature('trm1').set('u', {'-y*v(t)/r_wheel' 'x*v(t)/r_wheel' '0'});
model.physics('ht').create('hf1', 'HeatFluxBoundary', 2);
model.physics('ht').feature('hf1').selection.all;
model.physics('ht').feature('hf1').set('HeatFluxType', 'ConvectiveHeatFlux');
model.physics('ht').feature('hf1').set('HeatTransferCoefficientType', 'ExtForcedConvection');
model.physics('ht').feature('hf1').set('Lpl', 0.14);
model.physics('ht').feature('hf1').set('U', 'v(t)');
model.physics('ht').feature('hf1').set('Text', 'T_air');
model.physics('ht').create('tc1', 'ThermalContact', 2);
model.physics('ht').feature('tc1').selection.set([11]);
model.physics('ht').feature('tc1').set('Tn', 'ht.tc1.Qb/(mu*v(t))');
model.physics('ht').feature('tc1').set('Hmic', '800[MPa]');
model.physics('ht').feature('tc1').set('heatSourceType', 'HeatRate');
model.physics('ht').feature('tc1').set('Pb', '-m_car*v(t)*a(t)/8');
model.physics('ht').feature('init1').set('Tinit', 'T_air');
model.physics('ht').create('sar1', 'SurfaceToAmbientRadiation', 2);
model.physics('ht').feature('sar1').selection.named('sel1');
model.physics('ht').feature('sar1').set('epsilon_rad_mat', 'userdef');
model.physics('ht').feature('sar1').set('epsilon_rad', 0.28);
model.physics('ht').feature('sar1').set('Tamb', 'T_air');
model.physics('ht').create('sar2', 'SurfaceToAmbientRadiation', 2);
model.physics('ht').feature('sar2').selection.named('sel2');
model.physics('ht').feature('sar2').set('epsilon_rad_mat', 'userdef');
model.physics('ht').feature('sar2').set('epsilon_rad', 0.8);
model.physics('ht').feature('sar2').set('Tamb', 'T_air');
model.physics('ht').create('sym1', 'Symmetry', 2);
model.physics('ht').feature('sym1').selection.set([3]);
model.physics('ht').create('ge1', 'GlobalEquations', -1);
model.physics('ht').feature('ge1').set('DependentVariableQuantity', 'energy');
model.physics('ht').feature('ge1').set('SourceTermQuantity', 'power');
model.physics('ht').feature('ge1').setIndex('name', 'W_prod', 0, 0);
model.physics('ht').feature('ge1').setIndex('equation', 'W_prodt-intop1(ht.tc1.Qb)', 0, 0);
model.physics('ht').feature('ge1').setIndex('initialValueU', 0, 0, 0);
model.physics('ht').feature('ge1').setIndex('initialValueUt', 0, 0, 0);
model.physics('ht').feature('ge1').setIndex('description', 'Produced heat', 0, 0);
model.physics('ht').feature('ge1').setIndex('name', 'W_diss', 1, 0);
model.physics('ht').feature('ge1').setIndex('equation', '', 1, 0);
model.physics('ht').feature('ge1').setIndex('initialValueU', 0, 1, 0);
model.physics('ht').feature('ge1').setIndex('initialValueUt', 0, 1, 0);
model.physics('ht').feature('ge1').setIndex('description', '', 1, 0);
model.physics('ht').feature('ge1').setIndex('equation', 'W_disst+(intop2(ht.q0+ht.rflux))', 1, 0);
model.physics('ht').feature('ge1').setIndex('initialValueU', 0, 1, 0);
model.physics('ht').feature('ge1').setIndex('initialValueUt', 0, 1, 0);
model.physics('ht').feature('ge1').setIndex('description', 'Dissipated heat', 1, 0);

model.mesh('mesh1').create('ftri1', 'FreeTri');

model.view('view1').set('transparency', true);

model.mesh('mesh1').feature('ftri1').selection.set([4 7 11]);

model.view('view1').set('transparency', false);

model.mesh('mesh1').feature('size').set('hauto', 2);
model.mesh('mesh1').create('swe1', 'Sweep');
model.mesh('mesh1').feature('swe1').create('dis1', 'Distribution');
model.mesh('mesh1').feature('swe1').feature('dis1').set('numelem', 2);
model.mesh('mesh1').run;

model.study('std1').feature('time').set('tlist', 'range(0,0.5,1.5) range(1.55,0.05,3) range(3.2,0.2,5) range(6,1,12)');
model.study('std1').feature('time').set('usertol', true);
model.study('std1').feature('time').set('rtol', 0.005);

model.sol.create('sol1');
model.sol('sol1').study('std1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'time');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').set('control', 'time');
model.sol('sol1').create('t1', 'Time');
model.sol('sol1').feature('t1').set('tlist', 'range(0,0.5,1.5) range(1.55,0.05,3) range(3.2,0.2,5) range(6,1,12)');
model.sol('sol1').feature('t1').set('plot', 'off');
model.sol('sol1').feature('t1').set('plotgroup', 'Default');
model.sol('sol1').feature('t1').set('plotfreq', 'tout');
model.sol('sol1').feature('t1').set('probesel', 'all');
model.sol('sol1').feature('t1').set('probes', {});
model.sol('sol1').feature('t1').set('probefreq', 'tsteps');
model.sol('sol1').feature('t1').set('atolglobalvaluemethod', 'factor');
model.sol('sol1').feature('t1').set('atolmethod', {'comp1_T' 'global' 'comp1_ODE1' 'global'});
model.sol('sol1').feature('t1').set('atol', {'comp1_T' '1e-3' 'comp1_ODE1' '1e-3'});
model.sol('sol1').feature('t1').set('atolvaluemethod', {'comp1_T' 'factor' 'comp1_ODE1' 'factor'});
model.sol('sol1').feature('t1').set('reacf', true);
model.sol('sol1').feature('t1').set('storeudot', true);
model.sol('sol1').feature('t1').set('endtimeinterpolation', true);
model.sol('sol1').feature('t1').set('estrat', 'exclude');
model.sol('sol1').feature('t1').set('maxorder', 2);
model.sol('sol1').feature('t1').set('control', 'time');
model.sol('sol1').feature('t1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('t1').feature('fc1').set('jtech', 'once');
model.sol('sol1').feature('t1').feature('fc1').set('damp', 0.9);
model.sol('sol1').feature('t1').feature('fc1').set('stabacc', 'aacc');
model.sol('sol1').feature('t1').feature('fc1').set('aaccdim', 5);
model.sol('sol1').feature('t1').feature('fc1').set('aaccmix', 0.9);
model.sol('sol1').feature('t1').feature('fc1').set('aaccdelay', 1);
model.sol('sol1').feature('t1').create('d1', 'Direct');
model.sol('sol1').feature('t1').feature('d1').set('linsolver', 'pardiso');
model.sol('sol1').feature('t1').feature('d1').set('pivotperturb', 1.0E-13);
model.sol('sol1').feature('t1').feature('d1').label('Direct, heat transfer variables (ht)');
model.sol('sol1').feature('t1').create('i1', 'Iterative');
model.sol('sol1').feature('t1').feature('i1').set('linsolver', 'gmres');
model.sol('sol1').feature('t1').feature('i1').set('prefuntype', 'left');
model.sol('sol1').feature('t1').feature('i1').set('itrestart', 50);
model.sol('sol1').feature('t1').feature('i1').set('rhob', 400);
model.sol('sol1').feature('t1').feature('i1').set('maxlinit', 10000);
model.sol('sol1').feature('t1').feature('i1').set('nlinnormuse', 'on');
model.sol('sol1').feature('t1').feature('i1').label('AMG, heat transfer variables (ht)');
model.sol('sol1').feature('t1').feature('i1').create('mg1', 'Multigrid');
model.sol('sol1').feature('t1').feature('i1').feature('mg1').set('prefun', 'saamg');
model.sol('sol1').feature('t1').feature('i1').feature('mg1').set('mgcycle', 'v');
model.sol('sol1').feature('t1').feature('i1').feature('mg1').set('maxcoarsedof', 50000);
model.sol('sol1').feature('t1').feature('i1').feature('mg1').set('strconn', 0.01);
model.sol('sol1').feature('t1').feature('i1').feature('mg1').set('nullspace', 'constant');
model.sol('sol1').feature('t1').feature('i1').feature('mg1').set('usesmooth', false);
model.sol('sol1').feature('t1').feature('i1').feature('mg1').set('saamgcompwise', true);
model.sol('sol1').feature('t1').feature('i1').feature('mg1').set('loweramg', true);
model.sol('sol1').feature('t1').feature('i1').feature('mg1').set('compactaggregation', false);
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('pr').create('so1', 'SOR');
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('pr').feature('so1').set('iter', 2);
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('pr').feature('so1').set('relax', 0.9);
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('po').create('so1', 'SOR');
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('po').feature('so1').set('iter', 2);
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('po').feature('so1').set('relax', 0.9);
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('cs').create('d1', 'Direct');
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('cs').feature('d1').set('linsolver', 'pardiso');
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('cs').feature('d1').set('pivotperturb', 1.0E-13);
model.sol('sol1').feature('t1').feature('fc1').set('linsolver', 'd1');
model.sol('sol1').feature('t1').feature('fc1').set('jtech', 'once');
model.sol('sol1').feature('t1').feature('fc1').set('damp', 0.9);
model.sol('sol1').feature('t1').feature('fc1').set('stabacc', 'aacc');
model.sol('sol1').feature('t1').feature('fc1').set('aaccdim', 5);
model.sol('sol1').feature('t1').feature('fc1').set('aaccmix', 0.9);
model.sol('sol1').feature('t1').feature('fc1').set('aaccdelay', 1);
model.sol('sol1').feature('t1').feature.remove('fcDef');
model.sol('sol1').attach('std1');
model.sol('sol1').feature('t1').set('tstepsbdf', 'intermediate');
model.sol('sol1').runAll;

model.result.create('pg1', 'PlotGroup3D');
model.result('pg1').label('Temperature (ht)');
model.result('pg1').set('data', 'dset1');
model.result('pg1').setIndex('looplevel', 51, 0);
model.result('pg1').set('defaultPlotID', 'ht/HT_PhysicsInterfaces/icom8/pdef1/pcond3/pcond3/pg1');
model.result('pg1').feature.create('vol1', 'Volume');
model.result('pg1').feature('vol1').set('showsolutionparams', 'on');
model.result('pg1').feature('vol1').set('solutionparams', 'parent');
model.result('pg1').feature('vol1').set('colortable', 'HeatCameraLight');
model.result('pg1').feature('vol1').set('smooth', 'internal');
model.result('pg1').feature('vol1').set('showsolutionparams', 'on');
model.result('pg1').feature('vol1').set('data', 'parent');
model.result('pg1').run;
model.result('pg1').run;
model.result('pg1').setIndex('looplevel', 38, 0);
model.result('pg1').run;
model.result.create('pg2', 'PlotGroup1D');
model.result('pg2').run;
model.result('pg2').label('Dissipated and Produced Heats');
model.result('pg2').set('titletype', 'none');
model.result('pg2').set('xlabelactive', true);
model.result('pg2').set('xlabel', 'Time (s)');
model.result('pg2').set('legendpos', 'lowerright');
model.result('pg2').create('ptgr1', 'PointGraph');
model.result('pg2').feature('ptgr1').set('markerpos', 'datapoints');
model.result('pg2').feature('ptgr1').set('linewidth', 'preference');
model.result('pg2').feature('ptgr1').selection.set([1]);
model.result('pg2').feature('ptgr1').set('expr', 'log10(W_prod+1)');
model.result('pg2').feature('ptgr1').set('linecolor', 'blue');
model.result('pg2').feature('ptgr1').set('legend', true);
model.result('pg2').feature('ptgr1').set('legendmethod', 'manual');
model.result('pg2').feature('ptgr1').setIndex('legends', 'log10(W_prod+1), produced heat', 0);
model.result('pg2').feature.duplicate('ptgr2', 'ptgr1');
model.result('pg2').run;
model.result('pg2').feature('ptgr2').set('expr', 'log10(W_diss+1)');
model.result('pg2').feature('ptgr2').set('linestyle', 'dashed');
model.result('pg2').feature('ptgr2').setIndex('legends', 'log10(W_diss+1), dissipated heat', 0);
model.result('pg2').run;
model.result.dataset.create('cln1', 'CutLine3D');
model.result.dataset('cln1').setIndex('genpoints', 0.0129, 0, 2);
model.result.dataset('cln1').setIndex('genpoints', -0.047, 1, 0);
model.result.dataset('cln1').setIndex('genpoints', 0.1316, 1, 1);
model.result.dataset('cln1').setIndex('genpoints', 0.0129, 1, 2);
model.result.dataset.create('par1', 'Parametric1D');
model.result.dataset('par1').setIndex('looplevelinput', 'manual', 0);
model.result.dataset('par1').setIndex('looplevel', [4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40 41 42 43 44], 0);
model.result.create('pg3', 'PlotGroup2D');
model.result('pg3').run;
model.result('pg3').label('Temperature Profile vs. Time');
model.result('pg3').create('surf1', 'Surface');
model.result('pg3').feature('surf1').set('colortable', 'HeatCameraLight');
model.result('pg3').feature('surf1').create('hght1', 'Height');
model.result('pg3').run;
model.result('pg3').run;
model.result.create('pg4', 'PlotGroup3D');
model.result('pg4').label('Contact Temperature (ht)');
model.result('pg4').set('data', 'dset1');
model.result('pg4').setIndex('looplevel', 51, 0);
model.result('pg4').set('defaultPlotID', 'ht/HT_PhysicsInterfaces/icom8/pdef1/pcond3/pcond4/pg1');
model.result('pg4').feature.create('slit1', 'SurfaceSlit');
model.result('pg4').feature('slit1').set('solutionparams', 'parent');
model.result('pg4').feature('slit1').set('updescractive', true);
model.result('pg4').feature('slit1').set('upexpr', 'ht.Tu');
model.result('pg4').feature('slit1').set('updescr', 'Upside temperature');
model.result('pg4').feature('slit1').set('downdescractive', true);
model.result('pg4').feature('slit1').set('downexpr', 'ht.Td');
model.result('pg4').feature('slit1').set('downdescr', 'Downside temperature');
model.result('pg4').feature('slit1').set('colortable', 'HeatCameraLight');
model.result('pg4').feature('slit1').set('smooth', 'internal');
model.result('pg4').feature('slit1').set('showsolutionparams', 'on');
model.result('pg4').feature('slit1').set('data', 'parent');
model.result('pg4').feature('slit1').feature.create('sel1', 'Selection');
model.result('pg4').feature('slit1').feature('sel1').selection.geom('geom1', 2);
model.result('pg4').feature('slit1').feature('sel1').selection.set([11]);
model.result('pg4').label('Contact Temperature (ht)');
model.result('pg4').run;
model.result('pg4').setIndex('looplevel', 38, 0);
model.result('pg1').run;

model.title('Heat Generation in a Disc Brake');

model.description('This example is a transient analysis of the temperature field in an automotive brake disc during and after a panic brake maneuver.');

model.mesh.clearMeshes;

model.sol('sol1').clearSolutionData;

model.label('brake_disc.mph');

model.modelNode.label('Components');

out = model;
