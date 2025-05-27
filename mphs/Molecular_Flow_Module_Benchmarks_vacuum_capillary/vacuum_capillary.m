function out = model
%
% vacuum_capillary.m
%
% Model exported on May 26 2025, 21:30 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/Molecular_Flow_Module/Benchmarks');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 2);
model.geom('geom1').model('comp1');
model.geom('geom1').axisymmetric(true);

model.mesh.create('mesh1', 'geom1');

model.physics.create('fmf', 'FreeMolecularFlow', 'geom1', {'G'});

model.study.create('std1');
model.study('std1').create('stat', 'Stationary');
model.study('std1').feature('stat').setSolveFor('/physics/fmf', true);

model.param.set('Lc', '2[mm]');
model.param.descr('Lc', 'Capillary length');
model.param.set('Rc', '0.2[mm]');
model.param.descr('Rc', 'Capillary radius');
model.param.set('p0', '1e-3[mbar]');
model.param.descr('p0', 'Reservoir pressure');

model.geom('geom1').create('r1', 'Rectangle');
model.geom('geom1').feature('r1').set('size', {'Rc' 'Lc'});
model.geom('geom1').runPre('fin');
model.geom('geom1').run;

model.physics('fmf').create('tv1', 'TotalVacuum', 1);
model.physics('fmf').feature('tv1').selection.set([3]);
model.physics('fmf').create('res1', 'Reservoir', 1);
model.physics('fmf').feature('res1').selection.set([2]);
model.physics('fmf').feature('res1').setIndex('p0', 'p0', 0);

model.func.create('int1', 'Interpolation');
model.func('int1').model('comp1');
model.func('int1').setIndex('table', 2, 0, 0);
model.func('int1').setIndex('table', 0.5142, 0, 1);
model.func('int1').setIndex('table', 4, 1, 0);
model.func('int1').setIndex('table', 0.3566, 1, 1);
model.func('int1').setIndex('table', 6, 2, 0);
model.func('int1').setIndex('table', 0.2755, 2, 1);
model.func('int1').setIndex('table', 8, 3, 0);
model.func('int1').setIndex('table', 0.2253, 3, 1);
model.func('int1').setIndex('table', 10, 4, 0);
model.func('int1').setIndex('table', '0.1910', 4, 1);

model.cpl.create('intop1', 'Integration', 'geom1');
model.cpl('intop1').set('axisym', true);
model.cpl('intop1').selection.geom('geom1', 1);
model.cpl('intop1').selection.set([2]);
model.cpl('intop1').set('axisym', false);
model.cpl.create('intop2', 'Integration', 'geom1');
model.cpl('intop2').set('axisym', true);
model.cpl('intop2').selection.geom('geom1', 1);
model.cpl('intop2').selection.set([3]);
model.cpl('intop2').set('axisym', false);

model.mesh('mesh1').create('map1', 'Map');
model.mesh('mesh1').feature('map1').create('dis1', 'Distribution');
model.mesh('mesh1').feature('map1').feature('dis1').selection.set([2 3]);
model.mesh('mesh1').feature('map1').feature('dis1').set('numelem', 15);
model.mesh('mesh1').feature('map1').create('dis2', 'Distribution');
model.mesh('mesh1').feature('map1').feature('dis2').selection.set([1 4]);
model.mesh('mesh1').feature('map1').feature('dis2').set('numelem', 60);
model.mesh('mesh1').run;

model.study('std1').create('param', 'Parametric');
model.study('std1').feature('param').setIndex('pname', 'Lc', 0);
model.study('std1').feature('param').setIndex('plistarr', '', 0);
model.study('std1').feature('param').setIndex('punit', 'm', 0);
model.study('std1').feature('param').setIndex('pname', 'Lc', 0);
model.study('std1').feature('param').setIndex('plistarr', '', 0);
model.study('std1').feature('param').setIndex('punit', 'm', 0);
model.study('std1').feature('param').setIndex('pname', 'Lc', 0);
model.study('std1').feature('param').setIndex('plistarr', 'range(0.4[mm],0.4[mm],2[mm])', 0);

model.sol.create('sol1');
model.sol('sol1').study('std1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'stat');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').set('control', 'stat');
model.sol('sol1').create('s1', 'Stationary');
model.sol('sol1').feature('s1').set('stol', 0.001);
model.sol('sol1').feature('s1').create('se1', 'Segregated');
model.sol('sol1').feature('s1').feature('se1').feature.remove('ssDef');
model.sol('sol1').feature('s1').feature('se1').create('ss1', 'SegregatedStep');
model.sol('sol1').feature('s1').feature('se1').feature('ss1').set('segvar', {'comp1_G'});
model.sol('sol1').feature('s1').create('d1', 'Direct');
model.sol('sol1').feature('s1').feature('d1').set('linsolver', 'pardiso');
model.sol('sol1').feature('s1').feature('d1').set('pivotperturb', 1.0E-13);
model.sol('sol1').feature('s1').feature('se1').feature('ss1').set('linsolver', 'd1');
model.sol('sol1').feature('s1').feature('se1').create('ss2', 'SegregatedStep');
model.sol('sol1').feature('s1').feature('se1').feature('ss2').set('segvar', {'comp1_fmf_p_G'});
model.sol('sol1').feature('s1').feature('se1').feature('ss2').set('linsolver', 'd1');
model.sol('sol1').feature('s1').feature('se1').create('ss3', 'SegregatedStep');
model.sol('sol1').feature('s1').feature('se1').feature('ss3').set('segvar', {'comp1_fmf_N_G'});
model.sol('sol1').feature('s1').feature('se1').feature('ss3').set('linsolver', 'd1');
model.sol('sol1').feature('s1').create('i1', 'Iterative');
model.sol('sol1').feature('s1').feature('i1').set('linsolver', 'gmres');
model.sol('sol1').feature('s1').feature.remove('fcDef');
model.sol('sol1').attach('std1');

model.batch.create('p1', 'Parametric');
model.batch('p1').study('std1');
model.batch('p1').create('so1', 'Solutionseq');
model.batch('p1').feature('so1').set('seq', 'sol1');
model.batch('p1').feature('so1').set('store', 'on');
model.batch('p1').feature('so1').set('clear', 'on');
model.batch('p1').feature('so1').set('psol', 'none');
model.batch('p1').set('pname', {'Lc'});
model.batch('p1').set('plistarr', {'range(0.4[mm],0.4[mm],2[mm])'});
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

model.result.dataset.create('rev1', 'Revolve2D');
model.result.dataset('rev1').set('data', 'none');
model.result.dataset('rev1').set('startangle', 270);
model.result.dataset('rev1').set('revangle', 270);
model.result.dataset('rev1').set('data', 'dset2');
model.result.create('pg1', 'PlotGroup2D');
model.result('pg1').label('Incident Molecular Flux (fmf)');
model.result('pg1').set('data', 'dset2');
model.result('pg1').setIndex('looplevel', 5, 0);
model.result('pg1').set('dataisaxisym', 'off');
model.result('pg1').set('data', 'dset2');
model.result('pg1').setIndex('looplevel', 5, 0);
model.result('pg1').set('defaultPlotID', 'FreeMolecularFlow/phys1/pdef1/pcond3/pg2');
model.result('pg1').feature.create('line1', 'Line');
model.result('pg1').feature('line1').label('Line');
model.result('pg1').feature('line1').set('showsolutionparams', 'on');
model.result('pg1').feature('line1').set('expr', 'fmf.Gtot');
model.result('pg1').feature('line1').set('linetype', 'tube');
model.result('pg1').feature('line1').set('resolution', 'norefine');
model.result('pg1').feature('line1').set('smooth', 'internal');
model.result('pg1').feature('line1').set('showsolutionparams', 'on');
model.result('pg1').feature('line1').set('data', 'parent');
model.result.create('pg2', 'PlotGroup2D');
model.result('pg2').label('Total Number Density (fmf)');
model.result('pg2').set('data', 'dset2');
model.result('pg2').setIndex('looplevel', 5, 0);
model.result('pg2').set('dataisaxisym', 'off');
model.result('pg2').set('data', 'dset2');
model.result('pg2').setIndex('looplevel', 5, 0);
model.result('pg2').set('defaultPlotID', 'FreeMolecularFlow/phys1/pdef1/pcond3/pcond1/pg2');
model.result('pg2').feature.create('line1', 'Line');
model.result('pg2').feature('line1').label('Line');
model.result('pg2').feature('line1').set('showsolutionparams', 'on');
model.result('pg2').feature('line1').set('expr', 'fmf.ntot');
model.result('pg2').feature('line1').set('linetype', 'tube');
model.result('pg2').feature('line1').set('resolution', 'norefine');
model.result('pg2').feature('line1').set('smooth', 'internal');
model.result('pg2').feature('line1').set('showsolutionparams', 'on');
model.result('pg2').feature('line1').set('data', 'parent');
model.result.create('pg3', 'PlotGroup2D');
model.result('pg3').label('Total Pressure (fmf)');
model.result('pg3').set('data', 'dset2');
model.result('pg3').setIndex('looplevel', 5, 0);
model.result('pg3').set('dataisaxisym', 'off');
model.result('pg3').set('data', 'dset2');
model.result('pg3').setIndex('looplevel', 5, 0);
model.result('pg3').set('defaultPlotID', 'FreeMolecularFlow/phys1/pdef1/pcond3/pcond2/pg2');
model.result('pg3').feature.create('line1', 'Line');
model.result('pg3').feature('line1').label('Line');
model.result('pg3').feature('line1').set('showsolutionparams', 'on');
model.result('pg3').feature('line1').set('expr', 'fmf.ptot');
model.result('pg3').feature('line1').set('linetype', 'tube');
model.result('pg3').feature('line1').set('resolution', 'norefine');
model.result('pg3').feature('line1').set('smooth', 'internal');
model.result('pg3').feature('line1').set('showsolutionparams', 'on');
model.result('pg3').feature('line1').set('data', 'parent');
model.result('pg1').run;
model.result('pg1').setIndex('looplevel', 1, 0);
model.result('pg1').run;
model.result.create('pg4', 'PlotGroup1D');
model.result('pg4').run;
model.result('pg4').label('Total Pressure');
model.result('pg4').set('data', 'dset2');
model.result('pg4').setIndex('looplevelinput', 'first', 0);
model.result('pg4').create('lngr1', 'LineGraph');
model.result('pg4').feature('lngr1').set('markerpos', 'datapoints');
model.result('pg4').feature('lngr1').set('linewidth', 'preference');
model.result('pg4').feature('lngr1').selection.set([4]);
model.result('pg4').feature('lngr1').set('expr', 'fmf.ptot');
model.result('pg4').feature('lngr1').set('descr', 'Total pressure');
model.result('pg4').feature('lngr1').set('resolution', 'norefine');
model.result('pg4').feature('lngr1').set('xdata', 'expr');
model.result('pg4').feature('lngr1').set('xdataexpr', 'z');
model.result('pg4').run;
model.result.create('pg5', 'PlotGroup1D');
model.result('pg5').run;
model.result('pg5').set('data', 'dset2');
model.result('pg5').create('glob1', 'Global');
model.result('pg5').feature('glob1').set('markerpos', 'datapoints');
model.result('pg5').feature('glob1').set('linewidth', 'preference');
model.result('pg5').feature('glob1').setIndex('expr', 'intop2(2*pi*r*G)/intop1(2*pi*r*fmf.J_G)', 0);
model.result('pg5').feature('glob1').setIndex('unit', '', 0);
model.result('pg5').feature('glob1').setIndex('descr', 'Computed transmission probability', 0);
model.result('pg5').feature('glob1').set('xdata', 'expr');
model.result('pg5').feature('glob1').set('xdataexpr', 'Lc/Rc');
model.result('pg5').run;
model.result('pg5').label('Transmission Probability');
model.result('pg5').set('xlabelactive', true);
model.result('pg5').set('xlabel', 'Length/radius');
model.result('pg5').set('ylabelactive', true);
model.result('pg5').set('ylabel', 'Transmission probability');
model.result('pg5').create('glob2', 'Global');
model.result('pg5').feature('glob2').set('markerpos', 'datapoints');
model.result('pg5').feature('glob2').set('linewidth', 'preference');
model.result('pg5').feature('glob2').setIndex('expr', 'int1(Lc/Rc)', 0);
model.result('pg5').feature('glob2').setIndex('unit', '', 0);
model.result('pg5').feature('glob2').setIndex('descr', 'Result due to Cole', 0);
model.result('pg5').feature('glob2').set('xdata', 'expr');
model.result('pg5').feature('glob2').set('xdataexpr', 'Lc/Rc');
model.result('pg5').feature('glob2').set('linestyle', 'none');
model.result('pg5').feature('glob2').set('linemarker', 'square');
model.result('pg5').run;
model.result('pg5').run;

model.title('Molecular Flow Through a Microcapillary');

model.description('Molecular flow down a cylinder was one of the first problems in the field to be treated analytically. In this benchmark problem the transmission probability is computed for molecular flow down a capillary tube of variable length and the results are compared with the analytic solution.');

model.label('vacuum_capillary.mph');

model.modelNode.label('Components');

out = model;
