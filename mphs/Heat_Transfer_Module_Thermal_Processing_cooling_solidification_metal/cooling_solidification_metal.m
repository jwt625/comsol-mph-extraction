function out = model
%
% cooling_solidification_metal.m
%
% Model exported on May 26 2025, 21:29 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/Heat_Transfer_Module/Thermal_Processing');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 2);
model.geom('geom1').model('comp1');
model.geom('geom1').axisymmetric(true);

model.mesh.create('mesh1', 'geom1');

model.physics.create('ht', 'HeatTransferInFluids', 'geom1');
model.physics('ht').model('comp1');

model.study.create('std1');
model.study('std1').create('stat', 'Stationary');
model.study('std1').feature('stat').setSolveFor('/physics/ht', true);

% To import content from file, use:
% model.param.loadFile('FILENAME');
model.param.set('T_m', '1356[K]', 'Melting temperature');
model.param.set('dT', '50[K]', 'Temperature transition zone half width');
model.param.set('dH', '205[kJ/kg]', 'Latent heat of solidification');
model.param.set('Cp_S', '380[J/(kg*K)]', 'Heat capacity at constant pressure, solid phase');
model.param.set('Cp_L', '530[J/(kg*K)]', 'Heat capacity at constant pressure, liquid phase');
model.param.set('T0', '300[K]', 'Ambient temperature');
model.param.set('T_in', '1473[K]', 'Melt inlet temperature');
model.param.set('v_cast', '2.5[mm/s]', 'Casting speed');
model.param.set('h_mold', '800[W/(m^2*K)]', 'Heat transfer coefficient, mold');
model.param.set('h_spray', '200[W/(m^2*K)]', 'Heat transfer coefficient, spray cooled region');
model.param.set('eps_s', '0.8', '            Surface emissivity');

model.geom('geom1').create('r1', 'Rectangle');
model.geom('geom1').feature('r1').set('size', [0.1 0.6]);
model.geom('geom1').run('r1');
model.geom('geom1').create('r2', 'Rectangle');
model.geom('geom1').feature('r2').set('size', [0.1 0.2]);
model.geom('geom1').feature('r2').set('pos', [0 0.6]);
model.geom('geom1').runPre('fin');
model.geom('geom1').run;

model.material.create('mat1', 'Common', 'comp1');
model.material('mat1').label('Solid Metal Alloy');
model.material('mat1').propertyGroup('def').set('thermalconductivity', {'300'});
model.material('mat1').propertyGroup('def').set('density', {'8500'});
model.material('mat1').propertyGroup('def').set('heatcapacity', {'Cp_S'});
model.material.create('mat2', 'Common', 'comp1');
model.material('mat2').label('Liquid Metal Alloy');
model.material('mat2').selection.set([1 2]);
model.material('mat2').propertyGroup('def').set('thermalconductivity', {'150'});
model.material('mat2').propertyGroup('def').set('density', {'8500'});
model.material('mat2').propertyGroup('def').set('heatcapacity', {'Cp_L'});

model.physics('ht').feature('init1').set('Tinit', 'T_in');
model.physics('ht').feature('fluid1').set('u', {'0' '0' '-v_cast'});
model.physics('ht').feature('fluid1').create('phc1', 'PhaseChangeMaterial', 2);
model.physics('ht').feature('fluid1').feature('phc1').set('T_pc12', 'T_m');
model.physics('ht').feature('fluid1').feature('phc1').set('dT_pc12', 'dT');
model.physics('ht').feature('fluid1').feature('phc1').set('L_pc12', 'dH');
model.physics('ht').feature('fluid1').feature('phc1').set('MaterialPhase1', 'mat1');
model.physics('ht').feature('fluid1').feature('phc1').set('MaterialPhase2', 'mat2');
model.physics('ht').create('ifl1', 'Inflow', 1);
model.physics('ht').feature('ifl1').selection.set([5]);
model.physics('ht').feature('ifl1').set('Tustr', 'T_in');
model.physics('ht').create('hf1', 'HeatFluxBoundary', 1);
model.physics('ht').feature('hf1').selection.set([7]);
model.physics('ht').feature('hf1').set('HeatFluxType', 'ConvectiveHeatFlux');
model.physics('ht').feature('hf1').set('h', 'h_mold');
model.physics('ht').feature('hf1').set('Text', 'T0');
model.physics('ht').create('hf2', 'HeatFluxBoundary', 1);
model.physics('ht').feature('hf2').selection.set([6]);
model.physics('ht').feature('hf2').set('HeatFluxType', 'ConvectiveHeatFlux');
model.physics('ht').feature('hf2').set('h', 'h_spray');
model.physics('ht').feature('hf2').set('Text', 'T0');
model.physics('ht').create('sar1', 'SurfaceToAmbientRadiation', 1);
model.physics('ht').feature('sar1').selection.set([6]);
model.physics('ht').feature('sar1').set('epsilon_rad_mat', 'userdef');
model.physics('ht').feature('sar1').set('epsilon_rad', 'eps_s');
model.physics('ht').feature('sar1').set('Tamb', 'T0');
model.physics('ht').create('ofl1', 'ConvectiveOutflow', 1);
model.physics('ht').feature('ofl1').selection.set([2]);

model.mesh('mesh1').autoMeshSize(1);

model.study('std1').setGenPlots(false);
model.study('std1').feature('stat').set('useparam', true);
model.study('std1').feature('stat').setIndex('pname', 'T_m', 0);
model.study('std1').feature('stat').setIndex('plistarr', '', 0);
model.study('std1').feature('stat').setIndex('punit', 'K', 0);
model.study('std1').feature('stat').setIndex('pname', 'T_m', 0);
model.study('std1').feature('stat').setIndex('plistarr', '', 0);
model.study('std1').feature('stat').setIndex('punit', 'K', 0);
model.study('std1').feature('stat').setIndex('pname', 'dT', 0);
model.study('std1').feature('stat').setIndex('plistarr', '300 200 150 100 75', 0);
model.study('std1').feature('stat').setIndex('punit', 'K', 0);
model.study('std1').feature('stat').set('errestandadap', 'adaption');
model.study('std1').feature('stat').set('meshadaptmethod', 'rebuild');

model.sol.create('sol1');
model.sol('sol1').study('std1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'stat');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').set('control', 'stat');
model.sol('sol1').create('s1', 'Stationary');
model.sol('sol1').feature('s1').create('p1', 'Parametric');
model.sol('sol1').feature('s1').feature.remove('pDef');
model.sol('sol1').feature('s1').feature('p1').set('control', 'stat');
model.sol('sol1').feature('s1').set('control', 'stat');
model.sol('sol1').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('s1').feature('fc1').set('dtech', 'auto');
model.sol('sol1').feature('s1').feature('fc1').set('initstep', 0.01);
model.sol('sol1').feature('s1').feature('fc1').set('minstep', 1.0E-6);
model.sol('sol1').feature('s1').feature('fc1').set('maxiter', 50);
model.sol('sol1').feature('s1').feature('fc1').set('termonres', 'off');
model.sol('sol1').feature('s1').create('d1', 'Direct');
model.sol('sol1').feature('s1').feature('d1').set('linsolver', 'pardiso');
model.sol('sol1').feature('s1').feature('d1').set('pivotperturb', 1.0E-13);
model.sol('sol1').feature('s1').feature('d1').label('Direct, heat transfer variables (ht)');
model.sol('sol1').feature('s1').create('i1', 'Iterative');
model.sol('sol1').feature('s1').feature('i1').set('linsolver', 'gmres');
model.sol('sol1').feature('s1').feature('i1').set('prefuntype', 'left');
model.sol('sol1').feature('s1').feature('i1').set('itrestart', 50);
model.sol('sol1').feature('s1').feature('i1').set('rhob', 20);
model.sol('sol1').feature('s1').feature('i1').set('maxlinit', 10000);
model.sol('sol1').feature('s1').feature('i1').set('nlinnormuse', 'on');
model.sol('sol1').feature('s1').feature('i1').label('AMG, heat transfer variables (ht)');
model.sol('sol1').feature('s1').feature('i1').create('mg1', 'Multigrid');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').set('prefun', 'saamg');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').set('mgcycle', 'v');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').set('maxcoarsedof', 50000);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').set('strconn', 0.01);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').set('nullspace', 'constant');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').set('usesmooth', false);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').set('saamgcompwise', true);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').set('loweramg', true);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').set('compactaggregation', false);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('pr').create('so1', 'SOR');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('pr').feature('so1').set('iter', 2);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('pr').feature('so1').set('relax', 0.9);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('po').create('so1', 'SOR');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('po').feature('so1').set('iter', 2);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('po').feature('so1').set('relax', 0.9);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('cs').create('d1', 'Direct');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('cs').feature('d1').set('linsolver', 'pardiso');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('cs').feature('d1').set('pivotperturb', 1.0E-13);
model.sol('sol1').feature('s1').feature('fc1').set('linsolver', 'd1');
model.sol('sol1').feature('s1').feature('fc1').set('dtech', 'auto');
model.sol('sol1').feature('s1').feature('fc1').set('initstep', 0.01);
model.sol('sol1').feature('s1').feature('fc1').set('minstep', 1.0E-6);
model.sol('sol1').feature('s1').feature('fc1').set('maxiter', 50);
model.sol('sol1').feature('s1').feature('fc1').set('termonres', 'off');
model.sol('sol1').feature('s1').feature.remove('fcDef');
model.sol('sol1').attach('std1');
model.sol('sol1').runAll;

model.result.create('pg1', 'PlotGroup2D');
model.result('pg1').run;
model.result('pg1').label('Solid and Liquid Phases (Adaptive Mesh)');
model.result('pg1').create('surf1', 'Surface');
model.result('pg1').feature('surf1').set('expr', 'ht.theta1');
model.result('pg1').feature('surf1').set('descr', 'Phase indicator, phase 1');
model.result('pg1').run;

model.study.create('std2');
model.study('std2').create('stat', 'Stationary');
model.study('std2').feature('stat').setSolveFor('/physics/ht', true);
model.study('std2').setGenPlots(false);
model.study('std2').feature('stat').set('useinitsol', true);
model.study('std2').feature('stat').set('initmethod', 'sol');
model.study('std2').feature('stat').set('initstudy', 'std1');
model.study('std2').feature('stat').set('initsol', 'sol2');
model.study('std2').feature('stat').set('initsoluse', 'sol5');
model.study('std2').feature('stat').set('solnum', 5);
model.study('std2').feature('stat').set('useparam', true);
model.study('std2').feature('stat').setIndex('pname', 'T_m', 0);
model.study('std2').feature('stat').setIndex('plistarr', '', 0);
model.study('std2').feature('stat').setIndex('punit', 'K', 0);
model.study('std2').feature('stat').setIndex('pname', 'T_m', 0);
model.study('std2').feature('stat').setIndex('plistarr', '', 0);
model.study('std2').feature('stat').setIndex('punit', 'K', 0);
model.study('std2').feature('stat').setIndex('pname', 'dT', 0);
model.study('std2').feature('stat').setIndex('plistarr', '50 25', 0);
model.study('std2').feature('stat').setIndex('punit', 'K', 0);

model.sol.create('sol6');
model.sol('sol6').study('std2');
model.sol('sol6').create('st1', 'StudyStep');
model.sol('sol6').feature('st1').set('study', 'std2');
model.sol('sol6').feature('st1').set('studystep', 'stat');
model.sol('sol6').create('v1', 'Variables');
model.sol('sol6').feature('v1').set('control', 'stat');
model.sol('sol6').create('s1', 'Stationary');
model.sol('sol6').feature('s1').create('p1', 'Parametric');
model.sol('sol6').feature('s1').feature.remove('pDef');
model.sol('sol6').feature('s1').feature('p1').set('control', 'stat');
model.sol('sol6').feature('s1').set('control', 'stat');
model.sol('sol6').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol6').feature('s1').feature('fc1').set('dtech', 'auto');
model.sol('sol6').feature('s1').feature('fc1').set('initstep', 0.01);
model.sol('sol6').feature('s1').feature('fc1').set('minstep', 1.0E-6);
model.sol('sol6').feature('s1').feature('fc1').set('maxiter', 50);
model.sol('sol6').feature('s1').feature('fc1').set('termonres', 'off');
model.sol('sol6').feature('s1').create('d1', 'Direct');
model.sol('sol6').feature('s1').feature('d1').set('linsolver', 'pardiso');
model.sol('sol6').feature('s1').feature('d1').set('pivotperturb', 1.0E-13);
model.sol('sol6').feature('s1').feature('d1').label('Direct, heat transfer variables (ht)');
model.sol('sol6').feature('s1').create('i1', 'Iterative');
model.sol('sol6').feature('s1').feature('i1').set('linsolver', 'gmres');
model.sol('sol6').feature('s1').feature('i1').set('prefuntype', 'left');
model.sol('sol6').feature('s1').feature('i1').set('itrestart', 50);
model.sol('sol6').feature('s1').feature('i1').set('rhob', 20);
model.sol('sol6').feature('s1').feature('i1').set('maxlinit', 10000);
model.sol('sol6').feature('s1').feature('i1').set('nlinnormuse', 'on');
model.sol('sol6').feature('s1').feature('i1').label('AMG, heat transfer variables (ht)');
model.sol('sol6').feature('s1').feature('i1').create('mg1', 'Multigrid');
model.sol('sol6').feature('s1').feature('i1').feature('mg1').set('prefun', 'saamg');
model.sol('sol6').feature('s1').feature('i1').feature('mg1').set('mgcycle', 'v');
model.sol('sol6').feature('s1').feature('i1').feature('mg1').set('maxcoarsedof', 50000);
model.sol('sol6').feature('s1').feature('i1').feature('mg1').set('strconn', 0.01);
model.sol('sol6').feature('s1').feature('i1').feature('mg1').set('nullspace', 'constant');
model.sol('sol6').feature('s1').feature('i1').feature('mg1').set('usesmooth', false);
model.sol('sol6').feature('s1').feature('i1').feature('mg1').set('saamgcompwise', true);
model.sol('sol6').feature('s1').feature('i1').feature('mg1').set('loweramg', true);
model.sol('sol6').feature('s1').feature('i1').feature('mg1').set('compactaggregation', false);
model.sol('sol6').feature('s1').feature('i1').feature('mg1').feature('pr').create('so1', 'SOR');
model.sol('sol6').feature('s1').feature('i1').feature('mg1').feature('pr').feature('so1').set('iter', 2);
model.sol('sol6').feature('s1').feature('i1').feature('mg1').feature('pr').feature('so1').set('relax', 0.9);
model.sol('sol6').feature('s1').feature('i1').feature('mg1').feature('po').create('so1', 'SOR');
model.sol('sol6').feature('s1').feature('i1').feature('mg1').feature('po').feature('so1').set('iter', 2);
model.sol('sol6').feature('s1').feature('i1').feature('mg1').feature('po').feature('so1').set('relax', 0.9);
model.sol('sol6').feature('s1').feature('i1').feature('mg1').feature('cs').create('d1', 'Direct');
model.sol('sol6').feature('s1').feature('i1').feature('mg1').feature('cs').feature('d1').set('linsolver', 'pardiso');
model.sol('sol6').feature('s1').feature('i1').feature('mg1').feature('cs').feature('d1').set('pivotperturb', 1.0E-13);
model.sol('sol6').feature('s1').feature('fc1').set('linsolver', 'd1');
model.sol('sol6').feature('s1').feature('fc1').set('dtech', 'auto');
model.sol('sol6').feature('s1').feature('fc1').set('initstep', 0.01);
model.sol('sol6').feature('s1').feature('fc1').set('minstep', 1.0E-6);
model.sol('sol6').feature('s1').feature('fc1').set('maxiter', 50);
model.sol('sol6').feature('s1').feature('fc1').set('termonres', 'off');
model.sol('sol6').feature('s1').feature.remove('fcDef');
model.sol('sol6').attach('std2');
model.sol('sol6').feature('s1').set('stol', '1e-5');
model.sol('sol6').runAll;

model.result.create('pg2', 'PlotGroup2D');
model.result('pg2').run;
model.result('pg2').label('Solid and Liquid Phases');
model.result('pg2').set('data', 'dset3');
model.result('pg2').create('surf1', 'Surface');
model.result('pg2').feature('surf1').set('expr', 'ht.theta1');
model.result('pg2').feature('surf1').set('descr', 'Phase indicator, phase 1');
model.result('pg2').run;
model.result.create('pg3', 'PlotGroup1D');
model.result('pg3').run;
model.result('pg3').label('Phase Indicator at Symmetry Axis');
model.result('pg3').create('lngr1', 'LineGraph');
model.result('pg3').feature('lngr1').set('markerpos', 'datapoints');
model.result('pg3').feature('lngr1').set('linewidth', 'preference');
model.result('pg3').feature('lngr1').selection.set([1 3]);
model.result('pg3').feature('lngr1').set('expr', 'ht.theta1');
model.result('pg3').feature('lngr1').set('descr', 'Phase indicator, phase 1');
model.result('pg3').feature('lngr1').set('xdata', 'expr');
model.result('pg3').feature('lngr1').set('xdataexpr', 'z');
model.result('pg3').feature('lngr1').set('legend', true);
model.result('pg3').feature.duplicate('lngr2', 'lngr1');
model.result('pg3').run;
model.result('pg3').feature('lngr2').set('data', 'dset3');
model.result('pg3').feature('lngr2').set('titletype', 'none');
model.result('pg3').run;
model.result('pg3').run;
model.result.duplicate('pg4', 'pg3');
model.result('pg4').run;
model.result('pg4').label('Phase Indicator through Radius');
model.result('pg4').run;
model.result('pg4').feature('lngr1').selection.set([4]);
model.result('pg4').feature('lngr1').set('xdataexpr', 'r');
model.result('pg4').run;
model.result('pg4').run;
model.result('pg4').feature('lngr2').selection.set([4]);
model.result('pg4').feature('lngr2').set('xdataexpr', 'r');
model.result('pg4').run;
model.result('pg4').set('legendpos', 'upperleft');
model.result('pg4').run;

model.title('Cooling and Solidification of Metal');

model.description('This is a model of a continuous casting process wherein liquid metal solidifies as it passes through a cooled mold. Phase change is modeled with the apparent heat capacity formulation, using mesh adaptation and the continuation method to facilitate solving the highly nonlinear stationary problem. The goal is to find the shape of the solidification front.');

model.mesh.clearMeshes;

model.sol('sol1').clearSolutionData;
model.sol('sol2').clearSolutionData;
model.sol('sol3').clearSolutionData;
model.sol('sol4').clearSolutionData;
model.sol('sol5').clearSolutionData;
model.sol('sol6').clearSolutionData;

model.label('cooling_solidification_metal.mph');

model.modelNode.label('Components');

out = model;
