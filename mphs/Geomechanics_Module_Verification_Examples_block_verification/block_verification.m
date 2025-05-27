function out = model
%
% block_verification.m
%
% Model exported on May 26 2025, 21:28 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/Geomechanics_Module/Verification_Examples');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 3);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.physics.create('solid', 'SolidMechanics', 'geom1');
model.physics('solid').model('comp1');

model.study.create('std1');
model.study('std1').create('stat', 'Stationary');
model.study('std1').feature('stat').setSolveFor('/physics/solid', true);

model.param.set('Disp', '0[mm]');
model.param.descr('Disp', 'Displacement parameter');
model.param.set('X_stress', '-3e5[Pa]');
model.param.descr('X_stress', 'In situ stress, xx-component');
model.param.set('Y_stress', '-2e5[Pa]');
model.param.descr('Y_stress', 'In situ stress, yy-component');
model.param.set('Z_stress', '-1e5[Pa]');
model.param.descr('Z_stress', 'In situ stress, zz-component');

model.geom('geom1').create('blk1', 'Block');
model.geom('geom1').runPre('fin');

model.cpl.create('intop1', 'Integration', 'geom1');

model.geom('geom1').run;

model.cpl('intop1').set('axisym', true);
model.cpl('intop1').selection.geom('geom1', 2);
model.cpl('intop1').selection.set([4]);

model.variable.create('var1');
model.variable('var1').model('comp1');
model.variable('var1').set('Forcez', 'intop1(solid.sz)/intop1(1)-Z_stress');
model.variable('var1').descr('Forcez', 'Axial force');
model.variable('var1').set('szz_th', '(2*solid.cohesion*cos(solid.internalphi)-Y_stress*(1+sin(solid.internalphi)))/(sin(solid.internalphi)-1)');
model.variable('var1').descr('szz_th', 'Theoretical yield stress');

model.physics('solid').feature('lemm1').create('soil1', 'SoilModel', 3);
model.physics('solid').feature('lemm1').feature('soil1').set('YieldCriterion', 'MohrCoulomb');
model.physics('solid').feature('lemm1').create('exs1', 'ExternalStress', 3);
model.physics('solid').feature('lemm1').feature('exs1').set('StressInputType', 'InSituStress');
model.physics('solid').feature('lemm1').feature('exs1').set('sins', {'X_stress' '0' '0' '0' 'Y_stress' '0' '0' '0' 'Z_stress'});
model.physics('solid').create('roll1', 'Roller', 2);
model.physics('solid').feature('roll1').selection.set([1 2 3]);
model.physics('solid').create('disp1', 'Displacement2', 2);
model.physics('solid').feature('disp1').selection.set([4]);
model.physics('solid').feature('disp1').setIndex('Direction', 'prescribed', 2);
model.physics('solid').feature('disp1').setIndex('U0', '-Disp', 2);

model.material.create('mat1', 'Common', 'comp1');
model.material('mat1').propertyGroup.create('Enu', 'Young''s_modulus_and_Poisson''s_ratio');
model.material('mat1').propertyGroup('Enu').set('E', {'207e6'});
model.material('mat1').propertyGroup('Enu').set('nu', {'0.3'});
model.material('mat1').propertyGroup('def').set('density', {'2000'});
model.material('mat1').propertyGroup.create('MohrCoulomb', 'Mohr_Coulomb_criterion');
model.material('mat1').propertyGroup('MohrCoulomb').set('cohesion', {'70e3'});
model.material('mat1').propertyGroup('MohrCoulomb').set('internalphi', {'30[deg]'});

model.mesh('mesh1').create('map1', 'Map');
model.mesh('mesh1').feature('map1').selection.set([4]);
model.mesh('mesh1').create('swe1', 'Sweep');
model.mesh('mesh1').feature('size').set('hauto', 8);
model.mesh('mesh1').run;

model.study('std1').feature('stat').set('useparam', true);
model.study('std1').feature('stat').setIndex('pname', 'Disp', 0);
model.study('std1').feature('stat').setIndex('plistarr', '', 0);
model.study('std1').feature('stat').setIndex('punit', 'm', 0);
model.study('std1').feature('stat').setIndex('pname', 'Disp', 0);
model.study('std1').feature('stat').setIndex('plistarr', '', 0);
model.study('std1').feature('stat').setIndex('punit', 'm', 0);
model.study('std1').feature('stat').setIndex('plistarr', '8*range(0,0.05,1)', 0);
model.study('std1').feature('stat').setIndex('punit', 'mm', 0);

model.sol.create('sol1');
model.sol('sol1').study('std1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'stat');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').feature('comp1_u').set('scalemethod', 'manual');
model.sol('sol1').feature('v1').feature('comp1_u').set('scaleval', '1e-2*1.7320508075688772');
model.sol('sol1').feature('v1').set('control', 'stat');
model.sol('sol1').create('s1', 'Stationary');
model.sol('sol1').feature('s1').create('p1', 'Parametric');
model.sol('sol1').feature('s1').feature.remove('pDef');
model.sol('sol1').feature('s1').feature('p1').set('control', 'stat');
model.sol('sol1').feature('s1').set('control', 'stat');
model.sol('sol1').feature('s1').feature('aDef').set('cachepattern', true);
model.sol('sol1').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('s1').feature('fc1').set('termonres', 'auto');
model.sol('sol1').feature('s1').feature('fc1').set('reserrfact', 1000);
model.sol('sol1').feature('s1').create('d1', 'Direct');
model.sol('sol1').feature('s1').feature('d1').set('linsolver', 'pardiso');
model.sol('sol1').feature('s1').feature('d1').set('pivotperturb', 1.0E-9);
model.sol('sol1').feature('s1').feature('d1').set('nliniterrefine', true);
model.sol('sol1').feature('s1').feature('d1').label('Suggested Direct Solver (solid)');
model.sol('sol1').feature('s1').create('i1', 'Iterative');
model.sol('sol1').feature('s1').feature('i1').set('linsolver', 'gmres');
model.sol('sol1').feature('s1').feature('i1').set('rhob', 40);
model.sol('sol1').feature('s1').feature('i1').set('nlinnormuse', true);
model.sol('sol1').feature('s1').feature('i1').label('Suggested Iterative Solver (solid)');
model.sol('sol1').feature('s1').feature('i1').create('mg1', 'Multigrid');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').set('prefun', 'gmg');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('pr').create('so1', 'SOR');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('pr').feature('so1').set('relax', 0.8);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('po').create('so1', 'SOR');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('po').feature('so1').set('relax', 0.8);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('cs').create('d1', 'Direct');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('cs').feature('d1').set('linsolver', 'pardiso');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('cs').feature('d1').set('pivotperturb', 1.0E-9);
model.sol('sol1').feature('s1').feature('fc1').set('linsolver', 'd1');
model.sol('sol1').feature('s1').feature('fc1').set('termonres', 'auto');
model.sol('sol1').feature('s1').feature('fc1').set('reserrfact', 1000);
model.sol('sol1').feature('s1').feature.remove('fcDef');
model.sol('sol1').attach('std1');
model.sol('sol1').runAll;

model.result.create('pg1', 'PlotGroup3D');
model.result('pg1').set('data', 'dset1');
model.result('pg1').setIndex('looplevel', 21, 0);
model.result('pg1').set('defaultPlotID', 'stress');
model.result('pg1').label('Stress (solid)');
model.result('pg1').set('frametype', 'spatial');
model.result('pg1').create('vol1', 'Volume');
model.result('pg1').feature('vol1').set('expr', {'solid.misesGp'});
model.result('pg1').feature('vol1').set('threshold', 'manual');
model.result('pg1').feature('vol1').set('thresholdvalue', 0.2);
model.result('pg1').feature('vol1').set('colortable', 'Rainbow');
model.result('pg1').feature('vol1').set('colortabletrans', 'none');
model.result('pg1').feature('vol1').set('colorscalemode', 'linear');
model.result('pg1').feature('vol1').set('resolution', 'custom');
model.result('pg1').feature('vol1').set('refine', 2);
model.result('pg1').feature('vol1').set('colortable', 'Prism');
model.result('pg1').feature('vol1').create('def', 'Deform');
model.result('pg1').feature('vol1').feature('def').set('expr', {'u' 'v' 'w'});
model.result('pg1').feature('vol1').feature('def').set('descr', 'Displacement field');
model.result('pg1').run;
model.result('pg1').run;
model.result('pg1').feature('vol1').set('unit', 'kPa');
model.result('pg1').run;
model.result('pg1').run;
model.result('pg1').set('titletype', 'custom');
model.result('pg1').set('solutionintitle', false);
model.result('pg1').set('legendpos', 'bottom');
model.result('pg1').set('plotarrayenable', true);
model.result('pg1').set('relpadding', 1);
model.result('pg1').feature('vol1').set('arraydim', '1');
model.result('pg1').run;
model.result('pg1').feature('vol1').set('data', 'dset1');
model.result('pg1').feature('vol1').setIndex('looplevel', 1, 0);
model.result('pg1').feature('vol1').set('manualindexing', true);
model.result('pg1').run;
model.result('pg1').feature('vol1').feature.remove('def');
model.result('pg1').feature('vol1').set('arraydim', '1');
model.result('pg1').run;
model.result('pg1').feature.duplicate('vol2', 'vol1');
model.result('pg1').feature('vol2').set('arraydim', '1');
model.result('pg1').run;
model.result('pg1').feature('vol2').setIndex('looplevel', 6, 0);
model.result('pg1').feature('vol2').set('titletype', 'none');
model.result('pg1').feature('vol2').set('inheritplot', 'vol1');
model.result('pg1').feature('vol2').set('arrayindex', 1);
model.result('pg1').feature.duplicate('vol3', 'vol2');
model.result('pg1').feature('vol3').set('arraydim', '1');
model.result('pg1').run;
model.result('pg1').feature('vol3').setIndex('looplevel', 16, 0);
model.result('pg1').feature('vol3').set('arrayindex', 2);
model.result('pg1').feature.duplicate('vol4', 'vol3');
model.result('pg1').feature('vol4').set('arraydim', '1');
model.result('pg1').run;
model.result('pg1').feature('vol4').setIndex('looplevel', 21, 0);
model.result('pg1').feature('vol4').set('arrayindex', 3);
model.result('pg1').run;
model.result('pg1').run;
model.result('pg1').create('arws1', 'ArrowSurface');
model.result('pg1').feature('arws1').set('arraydim', '1');
model.result('pg1').feature('arws1').set('data', 'dset1');
model.result('pg1').feature('arws1').setIndex('looplevel', 1, 0);
model.result('pg1').feature('arws1').set('expr', {'0' '0' 'Forcez'});
model.result('pg1').feature('arws1').set('titletype', 'none');
model.result('pg1').feature('arws1').set('arrowcount', 40);
model.result('pg1').feature('arws1').set('arrowbase', 'head');
model.result('pg1').feature('arws1').set('color', 'custom');
model.result('pg1').feature('arws1').set('customcolor', [0.501960813999176 0.250980406999588 0]);
model.result('pg1').feature('arws1').set('manualindexing', true);
model.result('pg1').feature('arws1').create('sel1', 'Selection');
model.result('pg1').feature('arws1').feature('sel1').selection.set([4]);
model.result('pg1').feature('arws1').set('arraydim', '1');
model.result('pg1').run;
model.result('pg1').feature.duplicate('arws2', 'arws1');
model.result('pg1').feature('arws2').set('arraydim', '1');
model.result('pg1').run;
model.result('pg1').feature('arws2').setIndex('looplevel', 6, 0);
model.result('pg1').feature('arws2').set('arrayindex', 1);
model.result('pg1').feature('arws2').set('scaleactive', true);
model.result('pg1').feature('arws2').set('scale', '4E-7');
model.result('pg1').feature('arws2').set('inheritplot', 'arws1');
model.result('pg1').feature('arws2').set('inheritarrowscale', false);
model.result('pg1').feature.duplicate('arws3', 'arws2');
model.result('pg1').feature('arws3').set('arraydim', '1');
model.result('pg1').run;
model.result('pg1').feature('arws3').setIndex('looplevel', 16, 0);
model.result('pg1').feature('arws3').set('arrayindex', 2);
model.result('pg1').feature('arws3').set('inheritplot', 'arws2');
model.result('pg1').feature.duplicate('arws4', 'arws3');
model.result('pg1').feature('arws4').set('arraydim', '1');
model.result('pg1').run;
model.result('pg1').feature('arws4').setIndex('looplevel', 21, 0);
model.result('pg1').feature('arws4').set('arrayindex', 3);
model.result('pg1').run;
model.result('pg1').run;
model.result('pg1').create('tlan1', 'TableAnnotation');
model.result('pg1').feature('tlan1').set('arraydim', '1');
model.result('pg1').feature('tlan1').set('source', 'localtable');
model.result('pg1').feature('tlan1').setIndex('localtablematrix', 0.5, 0, 0);
model.result('pg1').feature('tlan1').setIndex('localtablematrix', -0.1, 0, 1);
model.result('pg1').feature('tlan1').setIndex('localtablematrix', 0, 0, 2);
model.result('pg1').feature('tlan1').setIndex('localtablematrix', '$\delta$=0[mm]', 0, 3);
model.result('pg1').feature('tlan1').setIndex('localtablematrix', 2.5, 1, 0);
model.result('pg1').feature('tlan1').setIndex('localtablematrix', -0.1, 1, 1);
model.result('pg1').feature('tlan1').setIndex('localtablematrix', 0, 1, 2);
model.result('pg1').feature('tlan1').setIndex('localtablematrix', '$\delta$=2[mm]', 1, 3);
model.result('pg1').feature('tlan1').setIndex('localtablematrix', 4.5, 2, 0);
model.result('pg1').feature('tlan1').setIndex('localtablematrix', -0.1, 2, 1);
model.result('pg1').feature('tlan1').setIndex('localtablematrix', 0, 2, 2);
model.result('pg1').feature('tlan1').setIndex('localtablematrix', '$\delta$=6[mm]', 2, 3);
model.result('pg1').feature('tlan1').setIndex('localtablematrix', 6.5, 3, 0);
model.result('pg1').feature('tlan1').setIndex('localtablematrix', -0.1, 3, 1);
model.result('pg1').feature('tlan1').setIndex('localtablematrix', 0, 3, 2);
model.result('pg1').feature('tlan1').setIndex('localtablematrix', '$\delta$=8[mm]', 3, 3);
model.result('pg1').feature('tlan1').set('latexmarkup', true);
model.result('pg1').feature('tlan1').set('showpoint', false);
model.result('pg1').run;

model.view('view1').set('showgrid', false);

model.result('pg1').set('view', 'new');
model.result('pg1').run;
model.result.create('pg2', 'PlotGroup1D');
model.result('pg2').run;
model.result('pg2').label('Stress vs. Displacement');
model.result('pg2').set('titletype', 'label');
model.result('pg2').set('xlabelactive', true);
model.result('pg2').set('xlabel', 'Vertical displacement (mm)');
model.result('pg2').set('ylabelactive', true);
model.result('pg2').set('ylabel', 'Stress (kPa)');
model.result('pg2').create('ptgr1', 'PointGraph');
model.result('pg2').feature('ptgr1').set('markerpos', 'datapoints');
model.result('pg2').feature('ptgr1').set('linewidth', 'preference');
model.result('pg2').feature('ptgr1').selection.set([1]);
model.result('pg2').feature('ptgr1').set('expr', 'solid.sGpxx');
model.result('pg2').feature('ptgr1').set('descr', 'Stress tensor, xx-component');
model.result('pg2').feature('ptgr1').set('unit', 'kPa');
model.result('pg2').feature('ptgr1').set('xdata', 'expr');
model.result('pg2').feature('ptgr1').set('xdataexpr', 'Disp');
model.result('pg2').feature('ptgr1').set('xdataunit', 'mm');
model.result('pg2').feature('ptgr1').set('legend', true);
model.result('pg2').feature('ptgr1').set('legendmethod', 'manual');
model.result('pg2').feature('ptgr1').setIndex('legends', '\sigma<sub>xx</sub>', 0);
model.result('pg2').run;
model.result('pg2').feature.duplicate('ptgr2', 'ptgr1');
model.result('pg2').run;
model.result('pg2').feature('ptgr2').set('expr', 'solid.sGpyy');
model.result('pg2').feature('ptgr2').set('descr', 'Stress tensor, yy-component');
model.result('pg2').run;
model.result('pg2').feature('ptgr2').setIndex('legends', '\sigma<sub>yy</sub>', 0);
model.result('pg2').run;
model.result('pg2').feature.duplicate('ptgr3', 'ptgr1');
model.result('pg2').run;
model.result('pg2').feature('ptgr3').set('expr', 'solid.sGpzz');
model.result('pg2').feature('ptgr3').set('descr', 'Stress tensor, zz-component');
model.result('pg2').run;
model.result('pg2').feature('ptgr3').setIndex('legends', '\sigma<sub>zz</sub>', 0);
model.result('pg2').run;
model.result('pg2').feature.duplicate('ptgr4', 'ptgr1');
model.result('pg2').run;
model.result('pg2').feature('ptgr4').set('expr', 'szz_th');
model.result('pg2').feature('ptgr4').set('linestyle', 'dashed');
model.result('pg2').feature('ptgr4').set('linecolor', 'magenta');
model.result('pg2').feature('ptgr4').setIndex('legends', 'Theoretical yield stress', 0);
model.result('pg2').run;
model.result('pg2').run;
model.result.create('pg3', 'PlotGroup3D');
model.result('pg3').run;
model.result('pg3').label('In Situ Stress');
model.result('pg3').set('titletype', 'manual');
model.result('pg3').set('title', 'In situ stress (kPa)');
model.result('pg3').set('paramindicator', '');
model.result('pg3').create('vol1', 'Volume');
model.result('pg3').feature('vol1').set('expr', '1');
model.result('pg3').feature('vol1').set('coloring', 'uniform');
model.result('pg3').feature('vol1').set('color', 'gray');
model.result('pg3').feature('vol1').create('tran1', 'Transparency');
model.result('pg3').run;
model.result('pg3').feature('vol1').feature('tran1').set('transparency', 0.7);
model.result('pg3').run;
model.result('pg3').create('arws1', 'ArrowSurface');
model.result('pg3').feature('arws1').set('expr', {'solid.SinsXX*solid.nX+solid.SinsXY*solid.nY+solid.SinsXZ*solid.nZ' 'v' 'w'});
model.result('pg3').feature('arws1').setIndex('expr', 'solid.SinsXY*solid.nX+solid.SinsYY*solid.nY+solid.SinsYZ*solid.nZ', 1);
model.result('pg3').feature('arws1').setIndex('expr', 'solid.SinsXZ*solid.nX+solid.SinsXZ*solid.nY+solid.SinsZZ*solid.nZ', 2);
model.result('pg3').feature('arws1').set('arrowbase', 'head');
model.result('pg3').feature('arws1').create('col1', 'Color');
model.result('pg3').run;
model.result('pg3').feature('arws1').feature('col1').set('colordata', 'arrowlength');
model.result('pg3').feature('arws1').feature('col1').set('unit', 'kPa');
model.result('pg3').feature('arws1').feature('col1').set('coloring', 'gradient');
model.result('pg3').feature('arws1').feature('col1').set('topcolor', 'red');
model.result('pg3').run;
model.result('pg2').run;

model.title('Block Verification');

model.description(['This verification example is a uniaxial compression on a prestressed block. Due to simple prestresses and the uniaxial compression, it is possible to determine the yield stress of the material analytically. The block is modeled as an elastic-perfectly plastic material with Mohr' native2unicode(hex2dec({'20' '13'}), 'unicode') 'Coulomb yield criterion.']);

model.label('block_verification.mph');

model.modelNode.label('Components');

out = model;
