function out = model
%
% evaporator.m
%
% Model exported on May 26 2025, 21:30 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/Molecular_Flow_Module/Industrial_Applications');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 3);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.physics.create('fmf', 'FreeMolecularFlow', 'geom1', {'G'});

model.study.create('std1');
model.study('std1').create('time', 'Transient');
model.study('std1').feature('time').setSolveFor('/physics/fmf', true);

model.geom('geom1').insertFile('evaporator_geom_sequence.mph', 'geom1');
model.geom('geom1').run('sel5');

model.view('view1').set('renderwireframe', true);

model.param.set('Tamb', '293.15[K]');
model.param.descr('Tamb', 'Ambient temperature');
model.param.set('Tevap', '2000[K]');
model.param.descr('Tevap', 'Evaporation temperature');
model.param.set('pvap', '50[Pa]');
model.param.descr('pvap', 'Vapor pressure of gold');
model.param.set('Mn0', '197[g/mol]');
model.param.descr('Mn0', 'Molecular weight of gold');
model.param.set('rho0', '19.3[g/cm^3]');
model.param.descr('rho0', 'Density of gold');

model.selection.create('ball1', 'Ball');
model.selection('ball1').model('comp1');
model.selection('ball1').label('Boat');
model.selection('ball1').set('entitydim', 2);
model.selection('ball1').set('r', 10);
model.selection.create('sel1', 'Explicit');
model.selection('sel1').model('comp1');
model.selection('sel1').label('All Boundaries');
model.selection('sel1').geom(2);
model.selection('sel1').all;
model.selection.create('box1', 'Box');
model.selection('box1').model('comp1');
model.selection('box1').label('Boat and Shields');
model.selection('box1').set('entitydim', 2);
model.selection('box1').set('xmin', -50);
model.selection('box1').set('xmax', 50);
model.selection('box1').set('ymin', -35);
model.selection('box1').set('ymax', 35);
model.selection('box1').set('zmin', -10);
model.selection('box1').set('zmax', 80);
model.selection.create('sel2', 'Explicit');
model.selection('sel2').model('comp1');
model.selection('sel2').label('Front Quadrant');
model.selection('sel2').geom(2);
model.selection('sel2').set([1 4]);
model.selection.create('sel3', 'Explicit');
model.selection('sel3').model('comp1');
model.selection('sel3').label('Sample Mount Back');
model.selection('sel3').geom(2);
model.selection('sel3').set([9 10 12 44 52]);
model.selection.create('dif1', 'Difference');
model.selection('dif1').model('comp1');
model.selection('dif1').label('Deposition Surfaces');
model.selection('dif1').set('entitydim', 2);
model.selection('dif1').set('add', {'sel1'});
model.selection('dif1').set('subtract', {'box1' 'sel2' 'sel3'});

model.physics('fmf').prop('IntegrationProperty').set('IntegrationResolution', 4096);
model.physics('fmf').prop('Compute').set('ComputeN', false);
model.physics('fmf').prop('Compute').set('ComputeP', false);
model.physics('fmf').feature('fmfp1').setIndex('Mn_G', 'Mn0', 0);
model.physics('fmf').feature('st1').set('T', 'Tamb');
model.physics('fmf').feature('wall1').set('BCType', 'Deposition');
model.physics('fmf').feature('wall1').setIndex('rho_film', 'rho0', 0);
model.physics('fmf').create('evap1', 'Evaporation', 2);
model.physics('fmf').feature('evap1').selection.set([41]);
model.physics('fmf').feature('evap1').setIndex('pvap', 'pvap', 0);
model.physics('fmf').create('st2', 'SurfaceTemperature', 2);
model.physics('fmf').feature('st2').selection.named('ball1');
model.physics('fmf').feature('st2').set('T', 'Tevap');

model.mesh('mesh1').create('size1', 'Size');
model.mesh('mesh1').feature('size1').selection.geom('geom1', 2);
model.mesh('mesh1').feature('size1').selection.named('ball1');
model.mesh('mesh1').feature('size1').set('hauto', 2);
model.mesh('mesh1').create('size2', 'Size');
model.mesh('mesh1').feature('size2').selection.geom('geom1', 2);
model.mesh('mesh1').feature('size2').selection.named('geom1_sel4');
model.mesh('mesh1').feature('size2').set('hauto', 2);
model.mesh('mesh1').create('size3', 'Size');
model.mesh('mesh1').feature('size3').selection.geom('geom1', 2);
model.mesh('mesh1').feature('size3').selection.named('geom1_sel5');
model.mesh('mesh1').feature('size3').set('hauto', 1);
model.mesh('mesh1').feature('size3').set('custom', true);
model.mesh('mesh1').feature('size3').set('hmaxactive', true);
model.mesh('mesh1').feature('size3').set('hmax', 3);
model.mesh('mesh1').create('ftri1', 'FreeTri');
model.mesh('mesh1').feature('ftri1').selection.remaining;
model.mesh('mesh1').run;

model.study('std1').feature('time').set('tlist', 'range(0,6,60)');

model.sol.create('sol1');
model.sol('sol1').study('std1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'time');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').feature('comp1_G').set('scalemethod', 'manual');
model.sol('sol1').feature('v1').feature('comp1_G').set('scaleval', 'N_A_const');
model.sol('sol1').feature('v1').set('control', 'time');
model.sol('sol1').create('t1', 'Time');
model.sol('sol1').feature('t1').set('tlist', 'range(0,6,60)');
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
model.sol('sol1').feature('t1').set('control', 'time');
model.sol('sol1').feature('t1').create('se1', 'Segregated');
model.sol('sol1').feature('t1').feature('se1').feature.remove('ssDef');
model.sol('sol1').feature('t1').feature('se1').create('ss1', 'SegregatedStep');
model.sol('sol1').feature('t1').feature('se1').feature('ss1').set('segvar', {'comp1_G'});
model.sol('sol1').feature('t1').create('i1', 'Iterative');
model.sol('sol1').feature('t1').feature('i1').set('linsolver', 'gmres');
model.sol('sol1').feature('t1').feature('i1').create('mg1', 'Multigrid');
model.sol('sol1').feature('t1').feature('i1').feature('mg1').set('prefun', 'gmg');
model.sol('sol1').feature('t1').feature('i1').feature('mg1').set('mcasegen', 'any');
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('pr').create('sl1', 'SORLine');
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('pr').feature('sl1').set('iter', 2);
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('pr').feature('sl1').set('linerelax', 0.2);
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('pr').feature('sl1').set('seconditer', 1);
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('pr').feature('sl1').set('relax', 0.4);
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('po').create('sl1', 'SORLine');
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('po').feature('sl1').set('iter', 2);
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('po').feature('sl1').set('linerelax', 0.2);
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('po').feature('sl1').set('seconditer', 2);
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('po').feature('sl1').set('relax', 0.4);
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('cs').create('d1', 'Direct');
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('cs').feature('d1').set('linsolver', 'pardiso');
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('cs').feature('d1').set('pivotperturb', 1.0E-13);
model.sol('sol1').feature('t1').feature('se1').feature('ss1').set('linsolver', 'i1');
model.sol('sol1').feature('t1').feature('se1').create('ss2', 'SegregatedStep');
model.sol('sol1').feature('t1').feature('se1').feature('ss2').set('segvar', {'comp1_fmf_n_ads_G'});
model.sol('sol1').feature('t1').feature('se1').feature('ss2').set('linsolver', 'i1');
model.sol('sol1').feature('t1').feature.remove('fcDef');
model.sol('sol1').attach('std1');
model.sol('sol1').runAll;

model.result.create('pg1', 'PlotGroup3D');
model.result('pg1').label('Incident Molecular Flux (fmf)');
model.result('pg1').set('data', 'dset1');
model.result('pg1').setIndex('looplevel', 11, 0);
model.result('pg1').set('defaultPlotID', 'FreeMolecularFlow/phys1/pdef1/pcond1/pg1');
model.result('pg1').feature.create('surf1', 'Surface');
model.result('pg1').feature('surf1').label('Surface');
model.result('pg1').feature('surf1').set('showsolutionparams', 'on');
model.result('pg1').feature('surf1').set('expr', 'fmf.Gtot');
model.result('pg1').feature('surf1').set('resolution', 'norefine');
model.result('pg1').feature('surf1').set('smooth', 'internal');
model.result('pg1').feature('surf1').set('showsolutionparams', 'on');
model.result('pg1').feature('surf1').set('data', 'parent');
model.result('pg1').run;
model.result.dataset('dset1').selection.geom('geom1', 2);
model.result.dataset('dset1').selection.named('dif1');
model.result('pg1').run;
model.result('pg1').run;
model.result.create('pg2', 'PlotGroup3D');
model.result('pg2').run;
model.result('pg2').label('Film Thickness');
model.result('pg2').create('surf1', 'Surface');
model.result('pg2').feature('surf1').set('expr', 'fmf.h_film_G');
model.result('pg2').feature('surf1').set('descr', 'Film thickness');
model.result('pg2').feature('surf1').set('unit', 'nm');
model.result('pg2').feature('surf1').set('colortable', 'Viridis');
model.result('pg2').feature('surf1').set('resolution', 'norefine');
model.result('pg2').run;
model.result.dataset.create('surf1', 'Surface');
model.result.dataset('surf1').selection.named('geom1_sel5');
model.result.dataset('surf1').set('param', 'xy');
model.result.create('pg3', 'PlotGroup2D');
model.result('pg3').run;
model.result('pg3').label('Film Thickness on Sample');
model.result('pg3').create('surf1', 'Surface');
model.result('pg3').feature('surf1').set('expr', 'fmf.h_film_G');
model.result('pg3').feature('surf1').set('descr', 'Film thickness');
model.result('pg3').feature('surf1').set('unit', 'nm');
model.result('pg3').feature('surf1').set('colortable', 'Viridis');
model.result('pg3').feature('surf1').set('resolution', 'norefine');
model.result('pg3').run;
model.result.create('pg4', 'PlotGroup1D');
model.result('pg4').run;
model.result('pg4').label('Film Thickness vs. Time');
model.result('pg4').set('xlabelactive', true);
model.result('pg4').set('xlabel', 'Time (s)');
model.result('pg4').create('ptgr1', 'PointGraph');
model.result('pg4').feature('ptgr1').set('markerpos', 'datapoints');
model.result('pg4').feature('ptgr1').set('linewidth', 'preference');
model.result('pg4').feature('ptgr1').selection.set([19]);
model.result('pg4').feature('ptgr1').set('expr', 'fmf.h_film_G');
model.result('pg4').feature('ptgr1').set('descr', 'Film thickness');
model.result('pg4').feature('ptgr1').set('unit', 'nm');
model.result('pg4').run;

model.title('Evaporator');

model.description(['This example shows how to compute the thickness of a thermally evaporated gold film. The thickness of the deposited film is computed both on the walls of the chamber and on the sample.' newline  newline 'This example requires at least 6' native2unicode(hex2dec({'00' 'a0'}), 'unicode') 'GB of RAM to run.']);

model.mesh.clearMeshes;

model.sol('sol1').clearSolutionData;

model.label('evaporator.mph');

model.modelNode.label('Components');

out = model;
