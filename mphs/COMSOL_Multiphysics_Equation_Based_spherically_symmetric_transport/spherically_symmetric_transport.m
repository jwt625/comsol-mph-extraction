function out = model
%
% spherically_symmetric_transport.m
%
% Model exported on May 26 2025, 21:26 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/COMSOL_Multiphysics/Equation_Based');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 1);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.physics.create('g', 'GeneralFormPDE', 'geom1', {'T'});
model.physics('g').prop('EquationForm').set('form', 'Automatic');

model.study.create('std1');
model.study('std1').create('time', 'Transient');
model.study('std1').feature('time').setSolveFor('/physics/g', true);

model.baseSystem('none');

model.param.set('rho', '2000');
model.param.descr('rho', 'Density (kg/m^3)');
model.param.set('cp', '300');
model.param.descr('cp', 'Heat capacity (J/(kg*K))');
model.param.set('k', '0.5');
model.param.descr('k', 'Thermal conductivity (W/(m*K))');
model.param.set('Rp', '0.005');
model.param.descr('Rp', 'Pellet radius (m)');
model.param.set('Qs', '0');
model.param.descr('Qs', 'Heat source (W/m^3)');
model.param.set('hs', '1000');
model.param.descr('hs', 'Heat transfer coefficient (W/(m^2*K))');
model.param.set('Text', '368');
model.param.descr('Text', 'External temperature (K)');
model.param.set('Tinit', '298');
model.param.descr('Tinit', 'Initial value (K)');

model.geom('geom1').create('i1', 'Interval');
model.geom('geom1').runPre('fin');
model.geom('geom1').run;

model.physics('g').feature('gfeq1').setIndex('Ga', '-k*x^2/Rp^2*Tx', 0);
model.physics('g').feature('gfeq1').setIndex('f', 'x^2*Qs', 0);
model.physics('g').feature('gfeq1').setIndex('da', 'x^2*rho*cp', 0);
model.physics('g').feature('init1').set('T', 'Tinit');
model.physics('g').create('flux1', 'FluxBoundary', 0);
model.physics('g').feature('flux1').selection.set([1]);
model.physics('g').create('flux2', 'FluxBoundary', 0);
model.physics('g').feature('flux2').selection.set([2]);
model.physics('g').feature('flux2').setIndex('g', 'x^2/Rp*hs*(Text-T)', 0);

model.mesh('mesh1').create('sca1', 'Scale');
model.mesh('mesh1').feature('sca1').set('scale', 0.4);
model.mesh('mesh1').create('edg1', 'Edge');
model.mesh('mesh1').run;

model.study('std1').feature('time').set('tlist', 'range(0,0.25,10)');

model.sol.create('sol1');
model.sol('sol1').study('std1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'time');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').set('control', 'time');
model.sol('sol1').create('t1', 'Time');
model.sol('sol1').feature('t1').set('tlist', 'range(0,0.25,10)');
model.sol('sol1').feature('t1').set('plot', 'off');
model.sol('sol1').feature('t1').set('plotgroup', 'Default');
model.sol('sol1').feature('t1').set('plotfreq', 'tout');
model.sol('sol1').feature('t1').set('probesel', 'all');
model.sol('sol1').feature('t1').set('probes', {});
model.sol('sol1').feature('t1').set('probefreq', 'tsteps');
model.sol('sol1').feature('t1').set('atolglobalvaluemethod', 'factor');
model.sol('sol1').feature('t1').set('endtimeinterpolation', true);
model.sol('sol1').feature('t1').set('control', 'time');
model.sol('sol1').feature('t1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('t1').feature('fc1').set('linsolver', 'dDef');
model.sol('sol1').feature('t1').feature.remove('fcDef');
model.sol('sol1').attach('std1');
model.sol('sol1').runAll;

model.result.create('pg1', 'PlotGroup1D');
model.result('pg1').set('data', 'dset1');
model.result('pg1').create('lngr1', 'LineGraph');
model.result('pg1').feature('lngr1').set('xdata', 'expr');
model.result('pg1').feature('lngr1').set('xdataexpr', 'x');
model.result('pg1').feature('lngr1').selection.geom('geom1', 1);
model.result('pg1').feature('lngr1').selection.set([1]);
model.result('pg1').feature('lngr1').set('expr', 'T');
model.result('pg1').label('General Form PDE');
model.result('pg1').run;
model.result('pg1').run;
model.result('pg1').set('titletype', 'manual');
model.result('pg1').set('title', 'Temperature');
model.result('pg1').set('xlabelactive', true);
model.result('pg1').set('xlabel', 'Dimensionless radius');
model.result('pg1').set('ylabelactive', true);
model.result('pg1').set('ylabel', 'T (K)');
model.result('pg1').run;
model.result.create('pg2', 'PlotGroup1D');
model.result('pg2').run;
model.result('pg2').create('ptgr1', 'PointGraph');
model.result('pg2').feature('ptgr1').set('markerpos', 'datapoints');
model.result('pg2').feature('ptgr1').set('linewidth', 'preference');
model.result('pg2').feature('ptgr1').selection.set([1]);
model.result('pg2').run;
model.result('pg2').set('xlabelactive', true);
model.result('pg2').set('xlabel', 't (s)');
model.result('pg2').set('ylabelactive', true);
model.result('pg2').set('ylabel', 'T (K)');
model.result('pg2').run;

model.param.set('Rp', '0.005', 'Pellet radius (m)');
model.param.set('Rp', '0.0025');
model.param.descr('Rp', 'Pellet radius (m)');

model.sol('sol1').study('std1');
model.sol('sol1').feature.remove('t1');
model.sol('sol1').feature.remove('v1');
model.sol('sol1').feature.remove('st1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'time');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').set('control', 'time');
model.sol('sol1').create('t1', 'Time');
model.sol('sol1').feature('t1').set('tlist', 'range(0,0.25,10)');
model.sol('sol1').feature('t1').set('plot', 'off');
model.sol('sol1').feature('t1').set('plotgroup', 'pg1');
model.sol('sol1').feature('t1').set('plotfreq', 'tout');
model.sol('sol1').feature('t1').set('probesel', 'all');
model.sol('sol1').feature('t1').set('probes', {});
model.sol('sol1').feature('t1').set('probefreq', 'tsteps');
model.sol('sol1').feature('t1').set('atolglobalvaluemethod', 'factor');
model.sol('sol1').feature('t1').set('endtimeinterpolation', true);
model.sol('sol1').feature('t1').set('control', 'time');
model.sol('sol1').feature('t1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('t1').feature('fc1').set('linsolver', 'dDef');
model.sol('sol1').feature('t1').feature.remove('fcDef');
model.sol('sol1').attach('std1');
model.sol('sol1').runAll;

model.result('pg1').run;
model.result('pg2').run;
model.result('pg2').run;

model.title('Spherically Symmetric Transport');

model.description('This example of the transient heating of a magnetite ore pellet shows a general approach to modeling spherically symmetric transport using a 1D geometry.');

model.mesh.clearMeshes;

model.sol('sol1').clearSolutionData;

model.label('spherically_symmetric_transport.mph');

model.modelNode.label('Components');

out = model;
