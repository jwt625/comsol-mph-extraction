function out = model
%
% ion_implanter.m
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
model.study('std1').create('stat', 'Stationary');
model.study('std1').feature('stat').setSolveFor('/physics/fmf', true);

model.geom('geom1').insertFile('ion_implanter_geom_sequence.mph', 'geom1');
model.geom('geom1').run('comsel1');

model.param.set('pumpspeedcryo', '12000[l/s]');
model.param.descr('pumpspeedcryo', 'Pump speed for cryopumps');
model.param.set('pumpspeedturbo', '1500[l/s]');
model.param.descr('pumpspeedturbo', 'Pump speed for turbopump');

model.selection.create('sel1', 'Explicit');
model.selection('sel1').model('comp1');
model.selection('sel1').geom(1);
model.selection('sel1').set([6 33 103]);
model.selection('sel1').label('Beam line');

model.cpl.create('aveop1', 'Average', 'geom1');
model.cpl('aveop1').set('axisym', true);
model.cpl('aveop1').selection.geom('geom1', 1);

model.view('view1').set('renderwireframe', true);

model.cpl('aveop1').selection.named('sel1');

model.physics('fmf').feature('fmfp1').setIndex('Mn_G', '0.002[kg/mol]', 0);
model.physics('fmf').create('wall2', 'Wall', 2);
model.physics('fmf').feature('wall2').selection.set([42]);
model.physics('fmf').feature('wall2').set('BCType', 'OutgassingWall');
model.physics('fmf').feature('wall2').set('BoundaryCondition', 'NumberOfSCCM');
model.physics('fmf').feature('wall2').setIndex('sccmmfr', 30, 0);
model.physics('fmf').create('pmp1', 'VacuumPump', 2);
model.physics('fmf').feature('pmp1').set('SpecifyPump', 'PumpSpeed');
model.physics('fmf').feature('pmp1').selection.set([55]);
model.physics('fmf').feature('pmp1').setIndex('pspeed', 'pumpspeedturbo', 0);
model.physics('fmf').create('pmp2', 'VacuumPump', 2);
model.physics('fmf').feature('pmp2').set('SpecifyPump', 'PumpSpeed');
model.physics('fmf').feature('pmp2').selection.set([8]);
model.physics('fmf').feature('pmp2').setIndex('pspeed', 'pumpspeedcryo', 0);
model.physics('fmf').feature.duplicate('pmp3', 'pmp2');
model.physics('fmf').feature('pmp3').selection.set([25]);
model.physics('fmf').feature.duplicate('pmp4', 'pmp3');
model.physics('fmf').feature('pmp4').selection.set([70]);
model.physics('fmf').feature.duplicate('pmp5', 'pmp4');
model.physics('fmf').feature('pmp5').selection.set([33]);
model.physics('fmf').create('ndr1', 'NumberDensityReconEdge', 1);
model.physics('fmf').feature('ndr1').selection.named('sel1');

model.mesh('mesh1').create('edg1', 'Edge');
model.mesh('mesh1').feature('edg1').selection.named('sel1');
model.mesh('mesh1').feature('edg1').create('size1', 'Size');
model.mesh('mesh1').feature('edg1').feature('size1').set('custom', true);
model.mesh('mesh1').feature('edg1').feature('size1').set('hmaxactive', true);
model.mesh('mesh1').feature('edg1').feature('size1').set('hmax', 0.005);
model.mesh('mesh1').feature('size').set('hauto', 2);
model.mesh('mesh1').create('ftri1', 'FreeTri');
model.mesh('mesh1').feature('ftri1').selection.all;
model.mesh('mesh1').run;

model.study('std1').create('param', 'Parametric');
model.study('std1').feature('param').setIndex('pname', 'theta', 0);
model.study('std1').feature('param').setIndex('plistarr', '', 0);
model.study('std1').feature('param').setIndex('punit', 'rad', 0);
model.study('std1').feature('param').setIndex('pname', 'theta', 0);
model.study('std1').feature('param').setIndex('plistarr', '', 0);
model.study('std1').feature('param').setIndex('punit', 'rad', 0);
model.study('std1').feature('param').setIndex('punit', 'deg', 0);
model.study('std1').feature('param').setIndex('plistarr', 'range(0,20,60)', 0);

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
model.sol('sol1').feature('s1').create('i1', 'Iterative');
model.sol('sol1').feature('s1').feature('i1').set('linsolver', 'gmres');
model.sol('sol1').feature('s1').feature('i1').create('mg1', 'Multigrid');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').set('prefun', 'gmg');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').set('mcasegen', 'any');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('pr').create('sl1', 'SORLine');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('pr').feature('sl1').set('iter', 2);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('pr').feature('sl1').set('linerelax', 0.2);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('pr').feature('sl1').set('seconditer', 1);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('pr').feature('sl1').set('relax', 0.4);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('po').create('sl1', 'SORLine');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('po').feature('sl1').set('iter', 2);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('po').feature('sl1').set('linerelax', 0.2);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('po').feature('sl1').set('seconditer', 2);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('po').feature('sl1').set('relax', 0.4);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('cs').create('d1', 'Direct');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('cs').feature('d1').set('linsolver', 'pardiso');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('cs').feature('d1').set('pivotperturb', 1.0E-13);
model.sol('sol1').feature('s1').feature('se1').feature('ss1').set('linsolver', 'i1');
model.sol('sol1').feature('s1').feature('se1').create('ss2', 'SegregatedStep');
model.sol('sol1').feature('s1').feature('se1').feature('ss2').set('segvar', {'comp1_fmf_p_G'});
model.sol('sol1').feature('s1').feature('se1').feature('ss2').set('linsolver', 'i1');
model.sol('sol1').feature('s1').feature('se1').create('ss3', 'SegregatedStep');
model.sol('sol1').feature('s1').feature('se1').feature('ss3').set('segvar', {'comp1_fmf_N_G' 'comp1_fmf_ndr1_Nr_G'});
model.sol('sol1').feature('s1').feature('se1').feature('ss3').set('linsolver', 'i1');
model.sol('sol1').feature('s1').feature.remove('fcDef');
model.sol('sol1').attach('std1');

model.batch.create('p1', 'Parametric');
model.batch('p1').study('std1');
model.batch('p1').create('so1', 'Solutionseq');
model.batch('p1').feature('so1').set('seq', 'sol1');
model.batch('p1').feature('so1').set('store', 'on');
model.batch('p1').feature('so1').set('clear', 'on');
model.batch('p1').feature('so1').set('psol', 'none');
model.batch('p1').set('pname', {'theta'});
model.batch('p1').set('plistarr', {'range(0,20,60)'});
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

model.result.create('pg1', 'PlotGroup3D');
model.result('pg1').label('Incident Molecular Flux (fmf)');
model.result('pg1').set('data', 'dset2');
model.result('pg1').setIndex('looplevel', 4, 0);
model.result('pg1').set('data', 'dset2');
model.result('pg1').setIndex('looplevel', 4, 0);
model.result('pg1').set('defaultPlotID', 'FreeMolecularFlow/phys1/pdef1/pcond1/pg1');
model.result('pg1').feature.create('surf1', 'Surface');
model.result('pg1').feature('surf1').label('Surface');
model.result('pg1').feature('surf1').set('showsolutionparams', 'on');
model.result('pg1').feature('surf1').set('expr', 'fmf.Gtot');
model.result('pg1').feature('surf1').set('resolution', 'norefine');
model.result('pg1').feature('surf1').set('smooth', 'internal');
model.result('pg1').feature('surf1').set('showsolutionparams', 'on');
model.result('pg1').feature('surf1').set('data', 'parent');
model.result.create('pg2', 'PlotGroup3D');
model.result('pg2').label('Total Number Density (fmf)');
model.result('pg2').set('data', 'dset2');
model.result('pg2').setIndex('looplevel', 4, 0);
model.result('pg2').set('data', 'dset2');
model.result('pg2').setIndex('looplevel', 4, 0);
model.result('pg2').set('defaultPlotID', 'FreeMolecularFlow/phys1/pdef1/pcond1/pcond1/pg1');
model.result('pg2').feature.create('surf1', 'Surface');
model.result('pg2').feature('surf1').label('Surface');
model.result('pg2').feature('surf1').set('showsolutionparams', 'on');
model.result('pg2').feature('surf1').set('expr', 'fmf.ntot');
model.result('pg2').feature('surf1').set('resolution', 'norefine');
model.result('pg2').feature('surf1').set('smooth', 'internal');
model.result('pg2').feature('surf1').set('showsolutionparams', 'on');
model.result('pg2').feature('surf1').set('data', 'parent');
model.result.create('pg3', 'PlotGroup3D');
model.result('pg3').label('Total Pressure (fmf)');
model.result('pg3').set('data', 'dset2');
model.result('pg3').setIndex('looplevel', 4, 0);
model.result('pg3').set('data', 'dset2');
model.result('pg3').setIndex('looplevel', 4, 0);
model.result('pg3').set('defaultPlotID', 'FreeMolecularFlow/phys1/pdef1/pcond1/pcond2/pg1');
model.result('pg3').feature.create('surf1', 'Surface');
model.result('pg3').feature('surf1').label('Surface');
model.result('pg3').feature('surf1').set('showsolutionparams', 'on');
model.result('pg3').feature('surf1').set('expr', 'fmf.ptot');
model.result('pg3').feature('surf1').set('resolution', 'norefine');
model.result('pg3').feature('surf1').set('smooth', 'internal');
model.result('pg3').feature('surf1').set('showsolutionparams', 'on');
model.result('pg3').feature('surf1').set('data', 'parent');
model.result('pg1').run;
model.result.dataset.duplicate('dset3', 'dset2');
model.result.dataset('dset3').selection.geom('geom1', 2);
model.result.dataset('dset3').selection.named('geom1_comsel1');
model.result('pg1').run;
model.result('pg1').set('data', 'dset3');
model.result('pg2').run;
model.result('pg2').set('data', 'dset3');
model.result('pg3').run;
model.result('pg3').set('data', 'dset3');
model.result('pg2').run;
model.result('pg2').setIndex('looplevel', 1, 0);
model.result('pg2').run;
model.result('pg2').setIndex('looplevel', 3, 0);
model.result('pg2').run;
model.result('pg2').setIndex('looplevel', 4, 0);
model.result.create('pg4', 'PlotGroup1D');
model.result('pg4').run;
model.result('pg4').label('Number Density Along Beam Line');
model.result('pg4').set('data', 'dset2');
model.result('pg4').set('legendpos', 'lowerright');
model.result('pg4').create('lngr1', 'LineGraph');
model.result('pg4').feature('lngr1').set('markerpos', 'datapoints');
model.result('pg4').feature('lngr1').set('linewidth', 'preference');
model.result('pg4').feature('lngr1').selection.named('sel1');
model.result('pg4').feature('lngr1').set('expr', 'fmf.ntot');
model.result('pg4').feature('lngr1').set('descr', 'Total number density');
model.result('pg4').feature('lngr1').set('legend', true);
model.result('pg4').feature('lngr1').set('resolution', 'norefine');
model.result('pg4').run;
model.result.create('pg5', 'PlotGroup1D');
model.result('pg5').run;
model.result('pg5').label('Average Number Density vs. Wafer Angle');
model.result('pg5').set('data', 'dset2');
model.result('pg5').set('xlabelactive', true);
model.result('pg5').set('xlabel', 'Angle between beam and wafer (deg)');
model.result('pg5').set('ylabelactive', true);
model.result('pg5').set('ylabel', 'Average number density (1/m<sup>3</sup>)');
model.result('pg5').create('glob1', 'Global');
model.result('pg5').feature('glob1').set('markerpos', 'datapoints');
model.result('pg5').feature('glob1').set('linewidth', 'preference');
model.result('pg5').feature('glob1').setIndex('expr', 'aveop1(fmf.ntot)', 0);
model.result('pg5').feature('glob1').setIndex('unit', '1/(m^3)', 0);
model.result('pg5').feature('glob1').setIndex('descr', 'Mean number density', 0);
model.result('pg5').feature('glob1').set('xdata', 'expr');
model.result('pg5').feature('glob1').set('xdataexpr', 'theta');
model.result('pg5').run;

model.title('Molecular Flow in an Ion-Implant Vacuum System');

model.description('This example considers the design of an ion implantation system. A key design requirement for the system is that the number density of outgassed molecules is low along the path of the ion beam. In this example the number density is computed along part of the ion beam path as an out-gassing target wafer is rotated about its axis within the system.');

model.mesh.clearMeshes;

model.sol('sol1').clearSolutionData;
model.sol('sol2').clearSolutionData;
model.sol('sol3').clearSolutionData;
model.sol('sol4').clearSolutionData;
model.sol('sol5').clearSolutionData;
model.sol('sol6').clearSolutionData;

model.label('ion_implanter.mph');

model.modelNode.label('Components');

out = model;
