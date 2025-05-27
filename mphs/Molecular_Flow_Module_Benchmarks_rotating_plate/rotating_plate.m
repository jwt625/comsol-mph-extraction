function out = model
%
% rotating_plate.m
%
% Model exported on May 26 2025, 21:30 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/Molecular_Flow_Module/Benchmarks');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 2);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.physics.create('fmf', 'FreeMolecularFlow', 'geom1', {'G'});

model.study.create('std1');
model.study('std1').create('stat', 'Stationary');
model.study('std1').feature('stat').setSolveFor('/physics/fmf', true);

model.param.set('theta', '90[deg]');
model.param.descr('theta', 'Angle of plate to horizontal');

model.geom('geom1').create('r1', 'Rectangle');
model.geom('geom1').feature('r1').set('size', [1.1 0.1]);
model.geom('geom1').feature('r1').set('pos', [0 -0.05]);
model.geom('geom1').run('r1');
model.geom('geom1').create('pt1', 'Point');
model.geom('geom1').feature('pt1').setIndex('p', -0.025, 1);
model.geom('geom1').run('pt1');
model.geom('geom1').create('pt2', 'Point');
model.geom('geom1').feature('pt2').setIndex('p', 0.025, 1);
model.geom('geom1').run('pt2');
model.geom('geom1').create('r2', 'Rectangle');
model.geom('geom1').feature('r2').set('size', [0.05 0.0025]);
model.geom('geom1').feature('r2').set('pos', [1 0]);
model.geom('geom1').feature('r2').set('base', 'center');
model.geom('geom1').feature('r2').set('rot', 'theta');
model.geom('geom1').run('r2');
model.geom('geom1').create('dif1', 'Difference');
model.geom('geom1').feature('dif1').selection('input').set({'r1'});
model.geom('geom1').feature('dif1').selection('input2').set({'r2'});
model.geom('geom1').runPre('fin');

model.func.create('int1', 'Interpolation');
model.func('int1').label('Rad_G');
model.func('int1').set('source', 'file');
model.func('int1').set('filename', 'RadiationAnalogyG.txt');
model.func('int1').importData;
model.func('int1').set('funcname', 'Rad_G');
model.func.create('int2', 'Interpolation');
model.func('int2').label('Rad_p');
model.func('int2').set('source', 'file');
model.func('int2').set('filename', 'RadiationAnalogyP.txt');
model.func('int2').importData;
model.func('int2').set('funcname', 'Rad_p');
model.func.create('int3', 'Interpolation');
model.func('int3').label('Rad_n');
model.func('int3').set('source', 'file');
model.func('int3').set('filename', 'RadiationAnalogyN.txt');
model.func('int3').importData;
model.func('int3').set('funcname', 'Rad_n');

model.cpl.create('aveop1', 'Average', 'geom1');

model.geom('geom1').run;

model.cpl('aveop1').set('axisym', true);
model.cpl('aveop1').selection.geom('geom1', 1);
model.cpl('aveop1').selection.set([6]);

model.physics('fmf').prop('IntegrationProperty').set('IntegrationResolution', 4096);
model.physics('fmf').create('tv1', 'TotalVacuum', 1);
model.physics('fmf').feature('tv1').selection.set([1 2 4 5 10]);
model.physics('fmf').create('res1', 'Reservoir', 1);
model.physics('fmf').feature('res1').selection.set([3]);
model.physics('fmf').feature('res1').setIndex('p0', '1e-5[mbar]', 0);

model.mesh('mesh1').create('sca1', 'Scale');
model.mesh('mesh1').feature('sca1').selection.geom('geom1', 1);
model.mesh('mesh1').feature('sca1').set('scale', 0.1);
model.mesh('mesh1').feature('sca1').selection.set([3 6 9]);
model.mesh('mesh1').feature('size').set('hauto', 1);
model.mesh('mesh1').create('ftri1', 'FreeTri');
model.mesh('mesh1').run;

model.study('std1').create('param', 'Parametric');
model.study('std1').feature('param').setIndex('pname', 'theta', 0);
model.study('std1').feature('param').setIndex('plistarr', '', 0);
model.study('std1').feature('param').setIndex('punit', 'rad', 0);
model.study('std1').feature('param').setIndex('pname', 'theta', 0);
model.study('std1').feature('param').setIndex('plistarr', '', 0);
model.study('std1').feature('param').setIndex('punit', 'rad', 0);
model.study('std1').feature('param').setIndex('pname', 'theta', 0);
model.study('std1').feature('param').setIndex('plistarr', '5 range(10,10,90)', 0);
model.study('std1').feature('param').setIndex('punit', 'deg', 0);

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
model.batch('p1').set('pname', {'theta'});
model.batch('p1').set('plistarr', {'5 range(10,10,90)'});
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

model.result.create('pg1', 'PlotGroup2D');
model.result('pg1').label('Incident Molecular Flux (fmf)');
model.result('pg1').set('data', 'dset2');
model.result('pg1').setIndex('looplevel', 10, 0);
model.result('pg1').set('data', 'dset2');
model.result('pg1').setIndex('looplevel', 10, 0);
model.result('pg1').set('defaultPlotID', 'FreeMolecularFlow/phys1/pdef1/pcond2/pg2');
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
model.result('pg2').setIndex('looplevel', 10, 0);
model.result('pg2').set('data', 'dset2');
model.result('pg2').setIndex('looplevel', 10, 0);
model.result('pg2').set('defaultPlotID', 'FreeMolecularFlow/phys1/pdef1/pcond2/pcond1/pg1');
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
model.result('pg3').setIndex('looplevel', 10, 0);
model.result('pg3').set('data', 'dset2');
model.result('pg3').setIndex('looplevel', 10, 0);
model.result('pg3').set('defaultPlotID', 'FreeMolecularFlow/phys1/pdef1/pcond2/pcond2/pg1');
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
model.result.create('pg4', 'PlotGroup1D');
model.result('pg4').run;
model.result('pg4').create('lngr1', 'LineGraph');
model.result('pg4').feature('lngr1').set('markerpos', 'datapoints');
model.result('pg4').feature('lngr1').set('linewidth', 'preference');
model.result('pg4').feature('lngr1').selection.set([6]);
model.result('pg4').feature('lngr1').set('legend', true);
model.result('pg4').run;
model.result('pg4').label('G Uniformity');
model.result('pg4').set('data', 'dset2');
model.result('pg4').set('legendpos', 'lowerright');
model.result('pg4').run;
model.result.create('pg5', 'PlotGroup1D');
model.result('pg5').run;
model.result('pg5').set('data', 'dset2');
model.result('pg5').set('legendpos', 'lowerright');
model.result('pg5').create('glob1', 'Global');
model.result('pg5').feature('glob1').set('markerpos', 'datapoints');
model.result('pg5').feature('glob1').set('linewidth', 'preference');
model.result('pg5').feature('glob1').setIndex('expr', 'aveop1(G)', 0);
model.result('pg5').feature('glob1').setIndex('unit', '1/(m^2*s)', 0);
model.result('pg5').feature('glob1').setIndex('descr', 'Incoming Flux (Molecular Flow)', 0);
model.result('pg5').feature('glob1').setIndex('expr', 'Rad_G(theta*180/pi)', 1);
model.result('pg5').feature('glob1').setIndex('unit', '', 1);
model.result('pg5').feature('glob1').setIndex('descr', 'Incoming Flux (Radiation)', 1);
model.result('pg5').run;
model.result('pg5').run;
model.result('pg5').label('G');
model.result('pg5').run;
model.result.duplicate('pg6', 'pg5');
model.result('pg6').run;
model.result('pg6').label('Number Density Plate');
model.result('pg6').run;
model.result('pg6').feature('glob1').setIndex('expr', 'aveop1(fmf.nin_G)', 0);
model.result('pg6').feature('glob1').setIndex('unit', '1/m^3', 0);
model.result('pg6').feature('glob1').setIndex('descr', 'Incoming n (Molecular Flow)', 0);
model.result('pg6').feature('glob1').setIndex('expr', 'aveop1(fmf.nout_G)', 1);
model.result('pg6').feature('glob1').setIndex('unit', '1/m^3', 1);
model.result('pg6').feature('glob1').setIndex('descr', 'Outgoing n (Molecular Flow)', 1);
model.result('pg6').feature('glob1').setIndex('expr', 'aveop1(fmf.n_G)', 2);
model.result('pg6').feature('glob1').setIndex('unit', '1/m^3', 2);
model.result('pg6').feature('glob1').setIndex('descr', 'Total n (Molecular Flow)', 2);
model.result('pg6').feature('glob1').setIndex('expr', 'Rad_n(theta*180/pi)', 3);
model.result('pg6').feature('glob1').setIndex('unit', '', 3);
model.result('pg6').feature('glob1').setIndex('descr', 'Total n (Radiation)', 3);
model.result('pg6').run;
model.result('pg6').run;
model.result.duplicate('pg7', 'pg6');
model.result('pg7').run;
model.result('pg7').label('Pressure Plate');
model.result('pg7').run;
model.result('pg7').feature('glob1').setIndex('expr', 'aveop1(fmf.pin_G)', 0);
model.result('pg7').feature('glob1').setIndex('unit', 'Pa', 0);
model.result('pg7').feature('glob1').setIndex('descr', 'Incoming Pressure (Molecular Flow)', 0);
model.result('pg7').feature('glob1').setIndex('expr', 'aveop1(fmf.pout_G)', 1);
model.result('pg7').feature('glob1').setIndex('unit', 'Pa', 1);
model.result('pg7').feature('glob1').setIndex('descr', 'Outgoing Pressure (Molecular Flow)', 1);
model.result('pg7').feature('glob1').setIndex('expr', 'aveop1(fmf.p_G)', 2);
model.result('pg7').feature('glob1').setIndex('unit', 'Pa', 2);
model.result('pg7').feature('glob1').setIndex('descr', 'Total Pressure (Molecular Flow)', 2);
model.result('pg7').feature('glob1').setIndex('expr', 'Rad_p(theta*180/pi)', 3);
model.result('pg7').feature('glob1').setIndex('unit', '', 3);
model.result('pg7').feature('glob1').setIndex('descr', 'Total Pressure (Radiation)', 3);
model.result('pg7').run;
model.result('pg7').run;

model.title('Rotating Plate in a Unidirectional Molecular Flow');

model.description('This example computes the particle flux, number density and pressure on the surface of a plate that rotates in a highly directional molecular flow. The results obtained are compared with those from other, approximate, techniques for computing molecular flows.');

model.mesh.clearMeshes;

model.sol('sol1').clearSolutionData;
model.sol('sol2').clearSolutionData;
model.sol('sol3').clearSolutionData;
model.sol('sol4').clearSolutionData;
model.sol('sol5').clearSolutionData;
model.sol('sol6').clearSolutionData;
model.sol('sol7').clearSolutionData;
model.sol('sol8').clearSolutionData;
model.sol('sol9').clearSolutionData;
model.sol('sol10').clearSolutionData;
model.sol('sol11').clearSolutionData;
model.sol('sol12').clearSolutionData;

model.label('rotating_plate.mph');

model.modelNode.label('Components');

out = model;
