function out = model
%
% blasting_rock.m
%
% Model exported on May 26 2025, 21:33 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/Structural_Mechanics_Module/Elastic_Waves');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 3);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.physics.create('solid', 'SolidMechanics', 'geom1');
model.physics('solid').model('comp1');

model.study.create('std1');
model.study('std1').create('time', 'Transient');
model.study('std1').feature('time').setSolveFor('/physics/solid', true);

model.view('view1').set('showgrid', false);

model.param.set('H', '240[mm]');
model.param.descr('H', 'Depth');
model.param.set('L', 'H');
model.param.descr('L', 'Width');
model.param.set('L1', 'L/24');
model.param.descr('L1', 'Load extension');
model.param.set('Q', '1[g]');
model.param.descr('Q', 'Amount of explosive');
model.param.set('P0', '140e6[N]*(Q/1[kg])^(2/3)');
model.param.descr('P0', 'Load magnitude');
model.param.set('t0', '0.81e-3[s]*(Q/1[kg])^(1/3)');
model.param.descr('t0', 'Loading duration');
model.param.set('gamma', '1.86');
model.param.descr('gamma', 'Decay rate');
model.param.set('u0', '50[um]');
model.param.descr('u0', 'Displacement scale');

model.func.create('pw1', 'Piecewise');
model.func('pw1').model('comp1');
model.func('pw1').set('funcname', 'Pb');
model.func('pw1').set('arg', 't');
model.func('pw1').setIndex('pieces', 0, 0, 0);
model.func('pw1').setIndex('pieces', 't0', 0, 1);
model.func('pw1').setIndex('pieces', 'P0*exp(-gamma*t/t0)*sin(4*pi/(1+t0/t))', 0, 2);
model.func('pw1').set('argunit', 's');
model.func('pw1').set('fununit', 'N');

model.geom('geom1').create('blk1', 'Block');
model.geom('geom1').feature('blk1').set('size', {'L' 'L' 'H'});
model.geom('geom1').run('blk1');
model.geom('geom1').run('fin');

model.physics('solid').feature('lemm1').set('E_mat', 'userdef');
model.physics('solid').feature('lemm1').set('E', '50[GPa]');
model.physics('solid').feature('lemm1').set('nu_mat', 'userdef');
model.physics('solid').feature('lemm1').set('nu', '2/7');
model.physics('solid').feature('lemm1').set('rho_mat', 'userdef');
model.physics('solid').feature('lemm1').set('rho', 2700);
model.physics('solid').create('sym1', 'SymmetrySolid', 2);
model.physics('solid').feature('sym1').selection.set([1 2]);
model.physics('solid').create('bndl1', 'BoundaryLoad', 2);
model.physics('solid').feature('bndl1').selection.set([3]);
model.physics('solid').feature('bndl1').set('FperArea', {'0' '0' '0.25*Pb(t)/L1^2*(X<=L1)*(Y<=L1)'});
model.physics('solid').create('lrb1', 'LowReflectingBoundary', 2);
model.physics('solid').feature('lrb1').selection.set([5 6]);
model.physics('solid').prop('ShapeProperty').set('order_displacement', 1);

model.mesh('mesh1').create('map1', 'Map');
model.mesh('mesh1').feature('map1').selection.set([3]);
model.mesh('mesh1').feature('map1').create('dis1', 'Distribution');
model.mesh('mesh1').feature('map1').feature('dis1').selection.set([2 3 7 10]);
model.mesh('mesh1').feature('map1').feature('dis1').set('numelem', 'floor(L/L1)');
model.mesh('mesh1').run('map1');
model.mesh('mesh1').create('swe1', 'Sweep');
model.mesh('mesh1').feature('swe1').create('dis1', 'Distribution');
model.mesh('mesh1').feature('swe1').feature('dis1').set('numelem', 'floor(L/L1)');
model.mesh('mesh1').run;

model.study('std1').feature('time').set('tlist', 'range(0,2e-6,1.5e-4)');

model.sol.create('sol1');
model.sol('sol1').study('std1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'time');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').feature('comp1_u').set('scalemethod', 'manual');
model.sol('sol1').feature('v1').feature('comp1_u').set('scaleval', '1e-2*0.41569219381653055');
model.sol('sol1').feature('v1').set('control', 'time');
model.sol('sol1').create('t1', 'Time');
model.sol('sol1').feature('t1').set('tlist', 'range(0,2e-6,1.5e-4)');
model.sol('sol1').feature('t1').set('plot', 'off');
model.sol('sol1').feature('t1').set('plotgroup', 'Default');
model.sol('sol1').feature('t1').set('plotfreq', 'tout');
model.sol('sol1').feature('t1').set('probesel', 'all');
model.sol('sol1').feature('t1').set('probes', {});
model.sol('sol1').feature('t1').set('probefreq', 'tsteps');
model.sol('sol1').feature('t1').set('rtol', 0.001);
model.sol('sol1').feature('t1').set('atolglobalvaluemethod', 'factor');
model.sol('sol1').feature('t1').set('reacf', true);
model.sol('sol1').feature('t1').set('storeudot', true);
model.sol('sol1').feature('t1').set('endtimeinterpolation', true);
model.sol('sol1').feature('t1').set('timemethod', 'genalpha');
model.sol('sol1').feature('t1').set('control', 'time');
model.sol('sol1').feature('t1').feature('aDef').set('cachepattern', true);
model.sol('sol1').feature('t1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('t1').create('d1', 'Direct');
model.sol('sol1').feature('t1').feature('d1').set('linsolver', 'pardiso');
model.sol('sol1').feature('t1').feature('d1').set('pivotperturb', 1.0E-9);
model.sol('sol1').feature('t1').feature('d1').label('Suggested Direct Solver (solid)');
model.sol('sol1').feature('t1').create('i1', 'Iterative');
model.sol('sol1').feature('t1').feature('i1').set('linsolver', 'gmres');
model.sol('sol1').feature('t1').feature('i1').set('rhob', 400);
model.sol('sol1').feature('t1').feature('i1').set('nlinnormuse', true);
model.sol('sol1').feature('t1').feature('i1').label('Suggested Iterative Solver (GMRES with SA AMG) (solid)');
model.sol('sol1').feature('t1').feature('i1').create('mg1', 'Multigrid');
model.sol('sol1').feature('t1').feature('i1').feature('mg1').set('prefun', 'saamg');
model.sol('sol1').feature('t1').feature('i1').feature('mg1').set('usesmooth', false);
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('pr').create('so1', 'SOR');
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('pr').feature('so1').set('relax', 0.8);
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('po').create('so1', 'SOR');
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('po').feature('so1').set('relax', 0.8);
model.sol('sol1').feature('t1').feature('fc1').set('linsolver', 'd1');
model.sol('sol1').feature('t1').feature.remove('fcDef');
model.sol('sol1').attach('std1');
model.sol('sol1').feature('v1').feature('comp1_u').set('scaleval', 'u0');
model.sol('sol1').feature('t1').set('rhoinf', 0.5);

model.result.create('pg1', 'PlotGroup1D');
model.result('pg1').run;
model.result('pg1').label('Displacement');
model.result('pg1').set('titletype', 'none');
model.result('pg1').create('ptgr1', 'PointGraph');
model.result('pg1').feature('ptgr1').set('markerpos', 'datapoints');
model.result('pg1').feature('ptgr1').set('linewidth', 'preference');
model.result('pg1').feature('ptgr1').selection.set([2]);
model.result('pg1').feature('ptgr1').set('expr', 'w');
model.result('pg1').feature('ptgr1').set('unit', 'um');

model.study('std1').feature('time').set('plot', true);

model.sol('sol1').runAll;

model.result('pg1').run;
model.result.create('pg2', 'PlotGroup3D');
model.result('pg2').run;
model.result('pg2').create('vol1', 'Volume');
model.result('pg2').feature('vol1').set('expr', 'solid.sz');
model.result('pg2').feature('vol1').create('def1', 'Deform');
model.result('pg2').run;
model.result('pg2').run;
model.result('pg2').setIndex('looplevel', 26, 0);

model.view('view1').set('transparency', true);

model.result('pg2').run;
model.result('pg2').create('iso1', 'Isosurface');
model.result('pg2').feature('iso1').set('expr', 'w');
model.result('pg2').feature('iso1').create('def1', 'Deform');
model.result('pg2').run;
model.result('pg2').run;

model.study.create('std2');
model.study('std2').create('time', 'Transient');
model.study('std2').feature('time').setSolveFor('/physics/solid', true);
model.study('std2').feature('time').set('tlist', 'range(0,2e-6,1.5e-4)');
model.study('std2').feature('time').set('plot', true);
model.study('std2').feature('time').set('useadvanceddisable', true);
model.study('std2').feature('time').set('disabledphysics', {'solid/lrb1'});
model.study('std2').setGenPlots(false);

model.sol.create('sol2');
model.sol('sol2').study('std2');
model.sol('sol2').create('st1', 'StudyStep');
model.sol('sol2').feature('st1').set('study', 'std2');
model.sol('sol2').feature('st1').set('studystep', 'time');
model.sol('sol2').create('v1', 'Variables');
model.sol('sol2').feature('v1').feature('comp1_u').set('scalemethod', 'manual');
model.sol('sol2').feature('v1').feature('comp1_u').set('scaleval', '1e-2*0.41569219381653055');
model.sol('sol2').feature('v1').set('control', 'time');
model.sol('sol2').create('t1', 'Time');
model.sol('sol2').feature('t1').set('tlist', 'range(0,2e-6,1.5e-4)');
model.sol('sol2').feature('t1').set('plot', 'on');
model.sol('sol2').feature('t1').set('plotgroup', 'pg1');
model.sol('sol2').feature('t1').set('plotfreq', 'tout');
model.sol('sol2').feature('t1').set('probesel', 'all');
model.sol('sol2').feature('t1').set('probes', {});
model.sol('sol2').feature('t1').set('probefreq', 'tsteps');
model.sol('sol2').feature('t1').set('rtol', 0.001);
model.sol('sol2').feature('t1').set('atolglobalvaluemethod', 'factor');
model.sol('sol2').feature('t1').set('reacf', true);
model.sol('sol2').feature('t1').set('storeudot', true);
model.sol('sol2').feature('t1').set('endtimeinterpolation', true);
model.sol('sol2').feature('t1').set('timemethod', 'genalpha');
model.sol('sol2').feature('t1').set('control', 'time');
model.sol('sol2').feature('t1').feature('aDef').set('cachepattern', true);
model.sol('sol2').feature('t1').create('fc1', 'FullyCoupled');
model.sol('sol2').feature('t1').create('d1', 'Direct');
model.sol('sol2').feature('t1').feature('d1').set('linsolver', 'pardiso');
model.sol('sol2').feature('t1').feature('d1').set('pivotperturb', 1.0E-9);
model.sol('sol2').feature('t1').feature('d1').label('Suggested Direct Solver (solid)');
model.sol('sol2').feature('t1').create('i1', 'Iterative');
model.sol('sol2').feature('t1').feature('i1').set('linsolver', 'gmres');
model.sol('sol2').feature('t1').feature('i1').set('rhob', 400);
model.sol('sol2').feature('t1').feature('i1').set('nlinnormuse', true);
model.sol('sol2').feature('t1').feature('i1').label('Suggested Iterative Solver (GMRES with SA AMG) (solid)');
model.sol('sol2').feature('t1').feature('i1').create('mg1', 'Multigrid');
model.sol('sol2').feature('t1').feature('i1').feature('mg1').set('prefun', 'saamg');
model.sol('sol2').feature('t1').feature('i1').feature('mg1').set('usesmooth', false);
model.sol('sol2').feature('t1').feature('i1').feature('mg1').feature('pr').create('so1', 'SOR');
model.sol('sol2').feature('t1').feature('i1').feature('mg1').feature('pr').feature('so1').set('relax', 0.8);
model.sol('sol2').feature('t1').feature('i1').feature('mg1').feature('po').create('so1', 'SOR');
model.sol('sol2').feature('t1').feature('i1').feature('mg1').feature('po').feature('so1').set('relax', 0.8);
model.sol('sol2').feature('t1').feature('fc1').set('linsolver', 'd1');
model.sol('sol2').feature('t1').feature.remove('fcDef');
model.sol('sol2').attach('std2');
model.sol('sol2').feature('v1').feature('comp1_u').set('scaleval', 'u0');
model.sol('sol2').feature('t1').set('rhoinf', 0.5);

model.result('pg1').run;
model.result('pg1').feature.duplicate('ptgr2', 'ptgr1');
model.result('pg1').run;
model.result('pg1').feature('ptgr2').set('data', 'dset2');
model.result('pg1').feature('ptgr2').set('linestyle', 'dotted');

model.sol('sol2').runAll;

model.result('pg1').run;
model.result('pg1').create('ptgr3', 'PointGraph');
model.result('pg1').feature('ptgr3').set('markerpos', 'datapoints');
model.result('pg1').feature('ptgr3').set('linewidth', 'preference');
model.result('pg1').feature('ptgr3').set('expr', '(t/t0-1)*40');
model.result('pg1').feature('ptgr3').set('xdata', 'expr');
model.result('pg1').feature('ptgr3').set('xdataexpr', 'L/solid.cp');
model.result('pg1').feature('ptgr3').selection.set([2]);
model.result('pg1').feature('ptgr3').set('linestyle', 'dashed');
model.result('pg1').feature('ptgr3').set('linecolor', 'red');
model.result('pg1').feature.duplicate('ptgr4', 'ptgr3');
model.result('pg1').run;
model.result('pg1').feature('ptgr4').set('xdataexpr', 'L*sqrt(5)/solid.cp');
model.result('pg1').run;
model.result('pg1').set('xlabelactive', true);
model.result('pg1').set('xlabel', 'Time (s)');
model.result('pg1').set('ylabelactive', true);
model.result('pg1').set('ylabel', 'Vertical displacement (um)');
model.result('pg1').run;
model.result.dataset.create('mir1', 'Mirror3D');
model.result.dataset.create('mir2', 'Mirror3D');
model.result.dataset('mir2').set('data', 'mir1');
model.result.dataset('mir2').set('quickplane', 'xz');
model.result.dataset.create('cpl1', 'CutPlane');
model.result.dataset('cpl1').set('data', 'mir2');
model.result.dataset('cpl1').set('quickplane', 'xy');
model.result.dataset('cpl1').set('quickz', 'H');
model.result.dataset.create('sfft1', 'SpatialFFT');
model.result.dataset('sfft1').set('data', 'cpl1');
model.result.dataset('sfft1').set('gridres', 'manual');
model.result.dataset('sfft1').set('sampresx', 20);
model.result.dataset('sfft1').set('sampresy', 20);
model.result.dataset('sfft1').set('layout', 'padding');
model.result.dataset('sfft1').set('padx', 40);
model.result.dataset('sfft1').set('pady', 40);
model.result.dataset.duplicate('mir3', 'mir1');
model.result.dataset.duplicate('mir4', 'mir2');
model.result.dataset.duplicate('cpl2', 'cpl1');
model.result.dataset.duplicate('sfft2', 'sfft1');
model.result.dataset('mir3').set('data', 'dset2');
model.result.dataset('mir4').set('data', 'mir3');
model.result.dataset('cpl2').set('data', 'mir4');
model.result.dataset('sfft2').set('data', 'cpl2');
model.result.create('pg3', 'PlotGroup2D');
model.result('pg3').run;
model.result('pg3').set('data', 'sfft1');
model.result('pg3').setIndex('looplevel', 36, 0);
model.result('pg3').set('edges', false);
model.result('pg3').set('plotarrayenable', true);
model.result('pg3').create('surf1', 'Surface');
model.result('pg3').feature('surf1').set('arraydim', '1');
model.result('pg3').feature('surf1').set('expr', 'abs(fft(w))');
model.result('pg3').feature('surf1').set('colortable', 'SpectrumLight');
model.result('pg3').feature('surf1').set('colortabletrans', 'reverse');
model.result('pg3').feature('surf1').create('hght1', 'Height');
model.result('pg3').run;
model.result('pg3').feature('surf1').set('arraydim', '1');
model.result('pg3').run;
model.result('pg3').feature.duplicate('surf2', 'surf1');
model.result('pg3').feature('surf2').set('arraydim', '1');
model.result('pg3').run;
model.result('pg3').feature('surf2').set('data', 'sfft2');
model.result('pg3').feature('surf2').setIndex('looplevel', 36, 0);
model.result('pg3').feature('surf2').set('titletype', 'none');
model.result('pg3').feature('surf2').set('inheritplot', 'surf1');
model.result('pg3').run;
model.result('pg3').run;
model.result.duplicate('pg4', 'pg3');
model.result('pg4').run;
model.result('pg4').setIndex('looplevel', 61, 0);
model.result('pg4').feature('surf2').set('arraydim', '1');
model.result('pg4').run;
model.result('pg4').feature('surf2').setIndex('looplevel', 61, 0);
model.result('pg4').run;

model.title('Wave Propagation in Rock Under Blast Loads');

model.description('This example presents transient analysis of the wave propagation in rock mass caused by a short duration load on the surface. Such loads are typical during tunnel constructions and other excavations using blasting. The example shows the use of the Low-reflecting boundary conditions to truncate the computational domain to a reasonable size. The results are in very good agreement with a published study.');

model.mesh.clearMeshes;

model.sol('sol1').clearSolutionData;
model.sol('sol2').clearSolutionData;

model.label('blasting_rock.mph');

model.modelNode.label('Components');

out = model;
