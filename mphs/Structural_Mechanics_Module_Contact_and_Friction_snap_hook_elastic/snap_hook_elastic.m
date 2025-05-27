function out = model
%
% snap_hook_elastic.m
%
% Model exported on May 26 2025, 21:33 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/Structural_Mechanics_Module/Contact_and_Friction');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 3);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.physics.create('solid', 'SolidMechanics', 'geom1');
model.physics('solid').model('comp1');

model.study.create('std1');
model.study('std1').create('stat', 'Stationary');
model.study('std1').feature('stat').setSolveFor('/physics/solid', true);

model.view('view1').set('showgrid', false);

model.param.set('disp_max', '4.6[mm]');
model.param.descr('disp_max', 'Maximum hook displacement');
model.param.set('disp', '0[m]');
model.param.descr('disp', 'Prescribed hook displacement');

model.geom('geom1').create('imp1', 'Import');
model.geom('geom1').feature('imp1').set('filename', 'snap_hook_elastic.mphbin');
model.geom('geom1').feature('imp1').importData;
model.geom('geom1').create('rot1', 'Rotate');
model.geom('geom1').feature('rot1').selection('input').set({'imp1'});
model.geom('geom1').feature('rot1').set('rot', 90);
model.geom('geom1').feature('rot1').set('axistype', 'cartesian');
model.geom('geom1').feature('rot1').set('ax3', [1 0 0]);
model.geom('geom1').run('rot1');

model.selection.create('sel1', 'Explicit');
model.selection('sel1').model('comp1');

model.geom('geom1').run;

model.selection('sel1').label('Source Boundaries');
model.selection('sel1').geom(2);
model.selection('sel1').set('groupcontang', true);
model.selection('sel1').add([1 4 6 7 8]);
model.selection.create('sel2', 'Explicit');
model.selection('sel2').model('comp1');
model.selection('sel2').label('Destination Boundaries');
model.selection('sel2').geom(2);
model.selection('sel2').set([14 15 20 22 23]);

model.pair.create('p1', 'Contact', 'geom1');
model.pair('p1').source.named('sel1');
model.pair('p1').destination.named('sel2');

model.material.create('mat1', 'Common', 'comp1');
model.material('mat1').propertyGroup.create('Enu', 'Young''s_modulus_and_Poisson''s_ratio');
model.material('mat1').propertyGroup('Enu').set('E', {'10[GPa]'});
model.material('mat1').propertyGroup('Enu').set('nu', {'0.35'});
model.material('mat1').propertyGroup('def').set('density', {'1150[kg/m^3]'});

model.physics('solid').selection.set([2 3]);
model.physics('solid').feature('dcnt1').set('penaltyCtrlPenalty', 'ManualTuning');
model.physics('solid').feature('dcnt1').set('fp_penalty', '1/10');
model.physics('solid').create('disp1', 'Displacement2', 2);
model.physics('solid').feature('disp1').selection.set([30]);
model.physics('solid').feature('disp1').setIndex('Direction', 'prescribed', 0);
model.physics('solid').feature('disp1').setIndex('Direction', 'prescribed', 1);
model.physics('solid').feature('disp1').setIndex('Direction', 'prescribed', 2);
model.physics('solid').feature('disp1').setIndex('U0', '-disp', 0);
model.physics('solid').create('sym1', 'SymmetrySolid', 2);
model.physics('solid').feature('sym1').selection.set([13 19]);

model.mesh('mesh1').create('map1', 'Map');
model.mesh('mesh1').feature('map1').selection.named('sel2');
model.mesh('mesh1').feature('map1').create('dis1', 'Distribution');
model.mesh('mesh1').feature('map1').feature('dis1').selection.set([27 28 39 48]);
model.mesh('mesh1').feature('map1').feature('dis1').set('numelem', 10);
model.mesh('mesh1').feature('map1').create('dis2', 'Distribution');
model.mesh('mesh1').feature('map1').feature('dis2').selection.set([31 45]);
model.mesh('mesh1').feature('map1').feature('dis2').set('numelem', 4);
model.mesh('mesh1').run('map1');
model.mesh('mesh1').create('conv1', 'Convert');
model.mesh('mesh1').feature('conv1').selection.geom('geom1', 2);
model.mesh('mesh1').feature('conv1').selection.named('sel2');
model.mesh('mesh1').run('conv1');
model.mesh('mesh1').create('ftet1', 'FreeTet');
model.mesh('mesh1').feature('ftet1').selection.geom('geom1', 3);
model.mesh('mesh1').feature('ftet1').selection.set([2 3]);
model.mesh('mesh1').feature('ftet1').create('size1', 'Size');
model.mesh('mesh1').feature('ftet1').feature('size1').set('custom', true);
model.mesh('mesh1').feature('ftet1').feature('size1').set('hmaxactive', true);
model.mesh('mesh1').feature('ftet1').feature('size1').set('hmax', '4e-4');
model.mesh('mesh1').feature('ftet1').create('size2', 'Size');
model.mesh('mesh1').feature('ftet1').feature('size2').selection.geom('geom1', 2);
model.mesh('mesh1').feature('ftet1').feature('size2').selection.set([25]);
model.mesh('mesh1').feature('ftet1').feature('size2').set('custom', true);
model.mesh('mesh1').feature('ftet1').feature('size2').set('hmaxactive', true);
model.mesh('mesh1').feature('ftet1').feature('size2').set('hmax', '1e-4');
model.mesh('mesh1').run('ftet1');
model.mesh('mesh1').create('map2', 'Map');
model.mesh('mesh1').feature('map2').selection.named('sel1');
model.mesh('mesh1').feature('map2').create('size1', 'Size');
model.mesh('mesh1').feature('map2').feature('size1').set('hauto', 9);
model.mesh('mesh1').feature('map2').create('dis1', 'Distribution');
model.mesh('mesh1').feature('map2').feature('dis1').selection.set([5 13]);
model.mesh('mesh1').feature('map2').feature('dis1').set('numelem', 10);
model.mesh('mesh1').run;

model.cpl.create('intop1', 'Integration', 'geom1');
model.cpl('intop1').set('axisym', true);
model.cpl('intop1').selection.geom('geom1', 2);
model.cpl('intop1').selection.set([30]);
model.cpl('intop1').set('method', 'summation');

model.study('std1').feature('stat').set('useparam', true);
model.study('std1').feature('stat').setIndex('pname', 'disp_max', 0);
model.study('std1').feature('stat').setIndex('plistarr', '', 0);
model.study('std1').feature('stat').setIndex('punit', 'm', 0);
model.study('std1').feature('stat').setIndex('pname', 'disp_max', 0);
model.study('std1').feature('stat').setIndex('plistarr', '', 0);
model.study('std1').feature('stat').setIndex('punit', 'm', 0);
model.study('std1').feature('stat').setIndex('pname', 'disp', 0);
model.study('std1').feature('stat').setIndex('plistarr', 'range(0.2,1e-2,1)*disp_max', 0);
model.study('std1').feature('stat').set('plot', true);

model.sol.create('sol1');
model.sol('sol1').study('std1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'stat');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').feature('comp1_u').set('scalemethod', 'manual');
model.sol('sol1').feature('v1').feature('comp1_u').set('scaleval', '1e-2*0.011195646475304587');
model.sol('sol1').feature('v1').set('control', 'stat');
model.sol('sol1').create('s1', 'Stationary');
model.sol('sol1').feature('s1').create('p1', 'Parametric');
model.sol('sol1').feature('s1').feature.remove('pDef');
model.sol('sol1').feature('s1').feature('p1').set('porder', 'constant');
model.sol('sol1').feature('s1').feature('p1').set('control', 'stat');
model.sol('sol1').feature('s1').set('control', 'stat');
model.sol('sol1').feature('s1').feature('aDef').set('cachepattern', true);
model.sol('sol1').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('s1').feature('fc1').set('dtech', 'ddog');
model.sol('sol1').feature('s1').create('d1', 'Direct');
model.sol('sol1').feature('s1').feature('d1').set('linsolver', 'pardiso');
model.sol('sol1').feature('s1').feature('d1').set('pivotperturb', 1.0E-9);
model.sol('sol1').feature('s1').feature('d1').set('nliniterrefine', true);
model.sol('sol1').feature('s1').feature('d1').label('Suggested Direct Solver (solid)');
model.sol('sol1').feature('s1').create('i1', 'Iterative');
model.sol('sol1').feature('s1').feature('i1').set('linsolver', 'gmres');
model.sol('sol1').feature('s1').feature('i1').set('prefuntype', 'right');
model.sol('sol1').feature('s1').feature('i1').set('rhob', 40);
model.sol('sol1').feature('s1').feature('i1').set('nlinnormuse', true);
model.sol('sol1').feature('s1').feature('i1').label('Suggested Iterative Solver (solid)');
model.sol('sol1').feature('s1').feature('i1').create('mg1', 'Multigrid');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').set('prefun', 'gmg');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('pr').create('so1', 'SOR');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('pr').feature('so1').set('iter', 1);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('po').create('so1', 'SOR');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('po').feature('so1').set('iter', 1);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('cs').create('mg1', 'Multigrid');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('cs').feature('mg1').set('prefun', 'saamg');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('cs').feature('mg1').set('usesmooth', false);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('cs').feature('mg1').set('iter', 2);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('cs').feature('mg1').set('mglevels', 2);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('cs').feature('mg1').set('maxcoarsedof', 10000);
model.sol('sol1').feature('s1').feature('fc1').set('linsolver', 'd1');
model.sol('sol1').feature('s1').feature('fc1').set('dtech', 'ddog');
model.sol('sol1').feature('s1').feature.remove('fcDef');
model.sol('sol1').attach('std1');

model.result.create('pg1', 'PlotGroup3D');
model.result('pg1').set('data', 'dset1');
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
model.result('pg1').feature('vol1').feature('def').set('scaleactive', true);
model.result('pg1').feature('vol1').feature('def').set('scale', '1');
model.result('pg1').feature('vol1').feature('def').set('expr', {'u' 'v' 'w'});
model.result('pg1').feature('vol1').feature('def').set('descr', 'Displacement field');

model.sol('sol1').runAll;

model.result.remove('pg1');

model.study('std1').feature('stat').set('plotgroup', 'Default');

model.result.create('pg1', 'PlotGroup3D');
model.result('pg1').set('data', 'dset1');
model.result('pg1').setIndex('looplevel', 81, 0);
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
model.result('pg1').feature('vol1').feature('def').set('scaleactive', true);
model.result('pg1').feature('vol1').feature('def').set('scale', '1');
model.result('pg1').feature('vol1').feature('def').set('expr', {'u' 'v' 'w'});
model.result('pg1').feature('vol1').feature('def').set('descr', 'Displacement field');
model.result('pg1').run;
model.result('pg1').setIndex('looplevel', 64, 0);
model.result('pg1').run;
model.result('pg1').feature('vol1').set('unit', 'MPa');
model.result('pg1').run;
model.result('pg1').create('surf1', 'Surface');
model.result('pg1').feature('surf1').set('expr', '1');
model.result('pg1').feature('surf1').set('titletype', 'none');
model.result('pg1').feature('surf1').set('coloring', 'uniform');
model.result('pg1').feature('surf1').set('color', 'gray');
model.result('pg1').feature('surf1').create('sel1', 'Selection');
model.result('pg1').feature('surf1').feature('sel1').selection.named('sel1');
model.result('pg1').run;
model.result.create('pg2', 'PlotGroup3D');
model.result('pg2').set('data', 'dset1');
model.result('pg2').setIndex('looplevel', 81, 0);
model.result('pg2').set('defaultPlotID', 'contactForces');
model.result('pg2').label('Contact Forces (solid)');
model.result('pg2').set('showlegends', true);
model.result('pg2').set('titletype', 'label');
model.result('pg2').set('frametype', 'spatial');
model.result('pg2').set('showlegendsunit', true);
model.result('pg2').create('surf1', 'Surface');
model.result('pg2').feature('surf1').set('expr', {'1'});
model.result('pg2').feature('surf1').label('Gray Surfaces');
model.result('pg2').feature('surf1').set('coloring', 'uniform');
model.result('pg2').feature('surf1').set('color', 'gray');
model.result('pg2').feature('surf1').create('def', 'Deform');
model.result('pg2').feature('surf1').feature('def').set('expr', {'u' 'v' 'w'});
model.result('pg2').feature('surf1').feature('def').set('descr', 'Displacement field');
model.result('pg2').feature('surf1').feature('def').set('scaleactive', true);
model.result('pg2').feature('surf1').feature('def').set('scale', 1);
model.result('pg2').feature('surf1').create('sel1', 'Selection');
model.result('pg2').feature('surf1').feature('sel1').selection.geom('geom1', 2);
model.result('pg2').feature('surf1').feature('sel1').selection.set([9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32]);
model.result('pg2').feature('surf1').create('tran1', 'Transparency');
model.result('pg2').feature('surf1').feature('tran1').set('transparency', 0.8);
model.result('pg2').create('arws1', 'ArrowSurface');
model.result('pg2').feature('arws1').set('arrowbase', 'head');
model.result('pg2').feature('arws1').set('expr', {'solid.dcnt1.Tnx' 'solid.dcnt1.Tny' 'solid.dcnt1.Tnz'});
model.result('pg2').feature('arws1').set('placement', 'gausspoints');
model.result('pg2').feature('arws1').set('gporder', 4);
model.result('pg2').feature('arws1').label('Contact 1, Pressure');
model.result('pg2').feature('arws1').set('inheritplot', 'none');
model.result('pg2').feature('arws1').set('color', 'green');
model.result('pg2').feature('arws1').create('col', 'Color');
model.result('pg2').feature('arws1').feature('col').set('colortable', 'Rainbow');
model.result('pg2').feature('arws1').feature('col').set('colortabletrans', 'none');
model.result('pg2').feature('arws1').feature('col').set('colorscalemode', 'linear');
model.result('pg2').feature('arws1').feature('col').set('colordata', 'arrowlength');
model.result('pg2').feature('arws1').feature('col').set('coloring', 'gradient');
model.result('pg2').feature('arws1').feature('col').set('topcolor', 'green');
model.result('pg2').feature('arws1').feature('col').set('bottomcolor', 'custom');
model.result('pg2').feature('arws1').feature('col').set('custombottomcolor', [0.509804 0.54902 0.509804]);
model.result('pg2').feature('arws1').create('def', 'Deform');
model.result('pg2').feature('arws1').feature('def').set('expr', {'u' 'v' 'w'});
model.result('pg2').feature('arws1').feature('def').set('descr', 'Displacement field');
model.result('pg2').feature('arws1').feature('def').set('scaleactive', true);
model.result('pg2').feature('arws1').feature('def').set('scale', 1);
model.result('pg2').feature.move('surf1', 1);
model.result('pg2').label('Contact Forces (solid)');
model.result('pg2').run;
model.result('pg2').setIndex('looplevel', 64, 0);
model.result.create('pg3', 'PlotGroup1D');
model.result('pg3').run;
model.result('pg3').label('Minimum Gap Distance');
model.result('pg3').set('showlegends', false);
model.result('pg3').create('glob1', 'Global');
model.result('pg3').feature('glob1').set('markerpos', 'datapoints');
model.result('pg3').feature('glob1').set('linewidth', 'preference');
model.result('pg3').feature('glob1').setIndex('expr', 'solid.gapmin_p1*(solid.gapmin_p1<0)', 0);
model.result('pg3').feature('glob1').setIndex('unit', 'um', 0);
model.result('pg3').feature('glob1').setIndex('descr', 'Minimum gap distance', 0);
model.result('pg3').run;
model.result.create('pg4', 'PlotGroup1D');
model.result('pg4').run;
model.result('pg4').label('Reaction Force');
model.result('pg4').set('showlegends', false);
model.result('pg4').create('glob1', 'Global');
model.result('pg4').feature('glob1').set('markerpos', 'datapoints');
model.result('pg4').feature('glob1').set('linewidth', 'preference');
model.result('pg4').feature('glob1').setIndex('expr', '-2*intop1(solid.RFx)', 0);
model.result('pg4').feature('glob1').setIndex('unit', 'N', 0);
model.result('pg4').feature('glob1').setIndex('descr', 'Total force', 0);
model.result('pg4').run;
model.result('pg1').run;

model.title('Contact Analysis of an Elastic Snap Hook');

model.description('This example simulates the insertion of a snap hook in its groove. The hook is modeled using a linear elastic material model.');

model.mesh.clearMeshes;

model.sol('sol1').clearSolutionData;

model.label('snap_hook_elastic.mph');

model.modelNode.label('Components');

out = model;
