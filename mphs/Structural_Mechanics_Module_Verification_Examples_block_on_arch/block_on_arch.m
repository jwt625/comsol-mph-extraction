function out = model
%
% block_on_arch.m
%
% Model exported on May 26 2025, 21:34 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/Structural_Mechanics_Module/Verification_Examples');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 3);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.physics.create('shell', 'Shell', 'geom1');
model.physics('shell').model('comp1');
model.physics.create('solid', 'SolidMechanics', 'geom1');
model.physics('solid').model('comp1');
model.physics('solid').field('displacement').field('u');

model.study.create('std1');
model.study('std1').create('stat', 'Stationary');
model.study('std1').feature('stat').setSolveFor('/physics/shell', true);
model.study('std1').feature('stat').setSolveFor('/physics/solid', true);

% To import content from file, use:
% model.param.loadFile('FILENAME');
model.param.set('R_arch', '1200[mm]', 'Arch radius');
model.param.set('d', '30[mm]', 'Arch thickness');
model.param.set('seg_arch', '40[deg]', 'Arch segment');
model.param.set('R_block', '350[mm]', 'Block radius');
model.param.set('height_block', '50[mm]', 'Block height');
model.param.set('seg_block', '40[deg]', 'Block segment');
model.param.set('n_elem_arch', '50', 'Number of mesh elements, arch');
model.param.set('n_elem_block', '10', 'Number of mesh elements, block');
model.param.set('F_ref', '-1[N/mm^2]', 'Reference load value');
model.param.set('max_disp', '120[mm]', 'Maximum displacement');
model.param.set('para', '0', 'Load parameter');

model.geom('geom1').create('wp1', 'WorkPlane');
model.geom('geom1').feature('wp1').set('unite', true);
model.geom('geom1').feature('wp1').set('quickplane', 'xz');
model.geom('geom1').feature('wp1').geom.create('c1', 'Circle');
model.geom('geom1').feature('wp1').geom.feature('c1').set('type', 'curve');
model.geom('geom1').feature('wp1').geom.feature('c1').set('r', 'R_arch');
model.geom('geom1').feature('wp1').geom.feature('c1').set('angle', 'seg_arch');
model.geom('geom1').feature('wp1').geom.feature('c1').set('pos', {'0' '-R_arch'});
model.geom('geom1').feature('wp1').geom.feature('c1').set('rot', '90-seg_arch/2');
model.geom('geom1').feature('wp1').geom.run('c1');
model.geom('geom1').feature('wp1').geom.create('del1', 'Delete');
model.geom('geom1').feature('wp1').geom.feature('del1').selection('input').set('c1', [2 3]);
model.geom('geom1').feature('wp1').geom.run('del1');
model.geom('geom1').feature('wp1').geom.create('pare1', 'PartitionEdges');
model.geom('geom1').feature('wp1').geom.feature('pare1').selection('edge').set('del1', 1);
model.geom('geom1').feature('wp1').geom.run('pare1');
model.geom('geom1').feature('wp1').geom.create('c2', 'Circle');
model.geom('geom1').feature('wp1').geom.feature('c2').set('r', 'R_block');
model.geom('geom1').feature('wp1').geom.feature('c2').set('angle', 'seg_block');
model.geom('geom1').feature('wp1').geom.feature('c2').set('pos', {'0' 'R_block'});
model.geom('geom1').feature('wp1').geom.feature('c2').set('rot', '-90-seg_block/2');
model.geom('geom1').feature('wp1').geom.run('c2');
model.geom('geom1').feature('wp1').geom.create('r1', 'Rectangle');
model.geom('geom1').feature('wp1').geom.feature('r1').set('size', {'R_block' 'height_block'});
model.geom('geom1').feature('wp1').geom.feature('r1').set('pos', {'-R_block/2' '0'});
model.geom('geom1').feature('wp1').geom.run('r1');
model.geom('geom1').feature('wp1').geom.create('int1', 'Intersection');
model.geom('geom1').feature('wp1').geom.feature('int1').selection('input').set({'c2' 'r1'});
model.geom('geom1').feature('wp1').set('unite', false);
model.geom('geom1').run('wp1');
model.geom('geom1').feature.create('ext1', 'Extrude');
model.geom('geom1').feature('ext1').set('workplane', 'wp1');
model.geom('geom1').feature('ext1').selection('input').set({'wp1'});
model.geom('geom1').feature('ext1').setIndex('distance', 'd', 0);
model.geom('geom1').run('ext1');
model.geom('geom1').create('sel1', 'ExplicitSelection');
model.geom('geom1').feature('sel1').label('Arch');
model.geom('geom1').feature('sel1').selection('selection').init;
model.geom('geom1').feature('sel1').selection('selection').set({'ext1(1)'});
model.geom('geom1').feature('sel1').set('color', '4');
model.geom('geom1').run('sel1');
model.geom('geom1').feature.duplicate('sel2', 'sel1');
model.geom('geom1').feature('sel2').label('Block');
model.geom('geom1').feature('sel2').selection('selection').set({'ext1(2)'});
model.geom('geom1').feature('sel2').set('color', '12');
model.geom('geom1').feature('fin').set('action', 'assembly');
model.geom('geom1').run('fin');

model.material.create('mat1', 'Common', 'comp1');
model.material('mat1').propertyGroup.create('Enu', 'Young''s_modulus_and_Poisson''s_ratio');
model.material('mat1').propertyGroup('Enu').set('E', {'10[GPa]'});
model.material('mat1').propertyGroup('Enu').set('nu', {'0.2'});
model.material('mat1').propertyGroup('def').set('density', {'1'});
model.material.create('mat2', 'Common', 'comp1');
model.material('mat2').selection.geom('geom1', 2);
model.material('mat2').selection.named('geom1_sel1_bnd');
model.material('mat2').propertyGroup.create('Enu', 'Young''s_modulus_and_Poisson''s_ratio');
model.material('mat2').propertyGroup('Enu').set('E', {'70[GPa]'});
model.material('mat2').propertyGroup('Enu').set('nu', {'0.3'});
model.material('mat2').propertyGroup('def').set('density', {'1'});

model.cpl.create('aveop1', 'Average', 'geom1');
model.cpl('aveop1').set('axisym', true);
model.cpl('aveop1').selection.geom('geom1', 0);
model.cpl('aveop1').selection.set([11]);
model.cpl.duplicate('aveop2', 'aveop1');
model.cpl('aveop2').selection.set([3]);

model.variable.create('var1');
model.variable('var1').model('comp1');
model.variable('var1').set('disp_block', 'aveop1(-w)');
model.variable('var1').descr('disp_block', 'Block displacement');
model.variable('var1').set('disp_arch', 'aveop2(-w)');
model.variable('var1').descr('disp_arch', 'Arch displacement');

model.pair.create('p1', 'Contact', 'geom1');
model.pair('p1').source.set([4 8]);
model.pair('p1').destination.named('geom1_sel1_bnd');

model.physics('shell').selection.named('geom1_sel1_bnd');
model.physics('shell').feature('to1').set('d', 'd');
model.physics('shell').feature('to1').set('OffsetDefinition', 'top');
model.physics('shell').create('disp1', 'Displacement1', 1);
model.physics('shell').feature('disp1').selection.set([1 7]);
model.physics('shell').feature('disp1').setIndex('Direction', 'prescribed', 0);
model.physics('shell').feature('disp1').setIndex('Direction', 'prescribed', 2);
model.physics('shell').feature('disp1').set('RotationType', 'RotationGroup');
model.physics('shell').create('sym1', 'SymmetrySolid1', 1);
model.physics('shell').feature('sym1').selection.set([2 3 5 6]);
model.physics('shell').feature('dcnt1').set('ContactMethodCtrl', 'AugmentedLagrange');
model.physics('solid').create('disp1', 'Displacement1', 1);
model.physics('solid').feature('disp1').selection.set([13 19]);
model.physics('solid').feature('disp1').setIndex('Direction', 'prescribed', 0);
model.physics('solid').create('sym1', 'SymmetrySolid', 2);
model.physics('solid').feature('sym1').selection.set([5 6]);
model.physics('solid').create('bndl1', 'BoundaryLoad', 2);
model.physics('solid').feature('bndl1').selection.set([7]);
model.physics('solid').feature('bndl1').set('FperArea', {'0' '0' 'load*F_ref'});
model.physics('solid').create('ge1', 'GlobalEquations', -1);
model.physics('solid').feature('ge1').setIndex('name', 'load', 0, 0);
model.physics('solid').feature('ge1').setIndex('equation', 'disp_block-para*max_disp', 0, 0);
model.physics('solid').feature('ge1').set('SourceTermQuantity', 'displacement');

model.mesh('mesh1').create('map1', 'Map');
model.mesh('mesh1').feature('map1').selection.named('geom1_sel1_bnd');
model.mesh('mesh1').feature('map1').create('dis1', 'Distribution');
model.mesh('mesh1').feature('map1').feature('dis1').selection.set([2 5]);
model.mesh('mesh1').feature('map1').feature('dis1').set('numelem', 'n_elem_arch');
model.mesh('mesh1').create('map2', 'Map');
model.mesh('mesh1').feature('map2').selection.set([5]);
model.mesh('mesh1').feature('map2').create('dis1', 'Distribution');
model.mesh('mesh1').feature('map2').feature('dis1').selection.set([10 17]);
model.mesh('mesh1').feature('map2').feature('dis1').set('numelem', 'n_elem_block');
model.mesh('mesh1').feature('map2').create('dis2', 'Distribution');
model.mesh('mesh1').feature('map2').feature('dis2').selection.set([9 20]);
model.mesh('mesh1').create('swe1', 'Sweep');
model.mesh('mesh1').run;

model.study('std1').feature('stat').set('useparam', true);
model.study('std1').feature('stat').setIndex('pname', 'R_arch', 0);
model.study('std1').feature('stat').setIndex('plistarr', '', 0);
model.study('std1').feature('stat').setIndex('punit', 'm', 0);
model.study('std1').feature('stat').setIndex('pname', 'R_arch', 0);
model.study('std1').feature('stat').setIndex('plistarr', '', 0);
model.study('std1').feature('stat').setIndex('punit', 'm', 0);
model.study('std1').feature('stat').setIndex('pname', 'para', 0);
model.study('std1').feature('stat').setIndex('plistarr', 'range(0,0.05,1)', 0);
model.study('std1').feature('stat').setIndex('punit', '', 0);

model.sol.create('sol1');
model.sol('sol1').study('std1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'stat');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').feature('comp1_ar').set('scalemethod', 'manual');
model.sol('sol1').feature('v1').feature('comp1_shell_Tn_p1').set('scalemethod', 'manual');
model.sol('sol1').feature('v1').feature('comp1_u').set('scalemethod', 'manual');
model.sol('sol1').feature('v1').feature('comp1_ar').set('resscalemethod', 'parent');
model.sol('sol1').feature('v1').feature('comp1_ar').set('scaleval', '0.01');
model.sol('sol1').feature('v1').feature('comp1_shell_Tn_p1').set('scaleval', '100000000');
model.sol('sol1').feature('v1').feature('comp1_u').set('scaleval', '1e-2*0.830461402176695');
model.sol('sol1').feature('v1').set('control', 'stat');
model.sol('sol1').create('s1', 'Stationary');
model.sol('sol1').feature('s1').create('p1', 'Parametric');
model.sol('sol1').feature('s1').feature.remove('pDef');
model.sol('sol1').feature('s1').feature('p1').set('porder', 'constant');
model.sol('sol1').feature('s1').feature('p1').set('control', 'stat');
model.sol('sol1').feature('s1').set('control', 'stat');
model.sol('sol1').feature('s1').feature('aDef').set('cachepattern', true);
model.sol('sol1').feature('s1').create('se1', 'Segregated');
model.sol('sol1').feature('s1').feature('se1').feature.remove('ssDef');
model.sol('sol1').feature('s1').feature('se1').create('ss1', 'SegregatedStep');
model.sol('sol1').feature('s1').feature('se1').feature('ss1').set('segvar', {'comp1_u' 'comp1_ar'});
model.sol('sol1').feature('s1').feature('se1').feature('ss1').set('subdtech', 'auto');
model.sol('sol1').feature('s1').feature('se1').feature('ss1').set('subminstep', 0.5);
model.sol('sol1').feature('s1').feature('se1').feature('ss1').set('usesubminsteprecovery', 'on');
model.sol('sol1').feature('s1').feature('se1').feature('ss1').set('subtermauto', 'itertol');
model.sol('sol1').feature('s1').feature('se1').feature('ss1').set('subiter', 7);
model.sol('sol1').feature('s1').feature('se1').feature('ss1').set('subntolfact', 1);
model.sol('sol1').feature('s1').feature('se1').feature('ss1').set('linsolver', 'dDef');
model.sol('sol1').feature('s1').feature('se1').feature('ss1').label('Shell');
model.sol('sol1').feature('s1').feature('se1').create('ss2', 'SegregatedStep');
model.sol('sol1').feature('s1').feature('se1').feature('ss2').set('segvar', {'comp1_u' 'comp1_ODE1'});
model.sol('sol1').feature('s1').feature('se1').feature('ss2').set('subdtech', 'ddog');
model.sol('sol1').feature('s1').feature('se1').feature('ss2').set('subtermauto', 'itertol');
model.sol('sol1').feature('s1').feature('se1').feature('ss2').set('subiter', 7);
model.sol('sol1').feature('s1').feature('se1').feature('ss2').set('subntolfact', 1);
model.sol('sol1').feature('s1').create('d1', 'Direct');
model.sol('sol1').feature('s1').feature('d1').set('linsolver', 'pardiso');
model.sol('sol1').feature('s1').feature('d1').set('pivotperturb', 1.0E-9);
model.sol('sol1').feature('s1').feature('d1').set('nliniterrefine', true);
model.sol('sol1').feature('s1').feature('d1').label('Suggested Direct Solver (solid)');
model.sol('sol1').feature('s1').feature('se1').feature('ss2').set('linsolver', 'd1');
model.sol('sol1').feature('s1').feature('se1').feature('ss2').label('Solid Mechanics');
model.sol('sol1').feature('s1').feature('se1').create('ls1', 'LumpedStep');
model.sol('sol1').feature('s1').feature('se1').feature('ls1').set('segvar', {'comp1_shell_Tn_p1'});
model.sol('sol1').feature('s1').feature('se1').set('maxsegiter', 100);
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
model.sol('sol1').feature('s1').feature.remove('fcDef');
model.sol('sol1').attach('std1');
model.sol('sol1').feature('s1').set('stol', '0.0005');
model.sol('sol1').feature('v1').feature('comp1_ODE1').set('scalemethod', 'manual');
model.sol('sol1').feature('s1').feature('se1').feature('ss1').set('segvar', {'comp1_u' 'comp1_ar' 'comp1_ODE1'});
model.sol('sol1').feature('s1').feature('se1').feature.remove('ss2');
model.sol('sol1').runAll;

model.result.dataset.create('dset1shellshl', 'Shell');
model.result.dataset('dset1shellshl').set('data', 'dset1');
model.result.dataset('dset1shellshl').setIndex('topconst', '1', 3, 1);
model.result.dataset('dset1shellshl').setIndex('bottomconst', '-1', 3, 1);
model.result.dataset('dset1shellshl').setIndex('orientationexpr', 'shell.nlX', 0);
model.result.dataset('dset1shellshl').setIndex('displacementexpr', 'arx', 0);
model.result.dataset('dset1shellshl').setIndex('orientationexpr', 'shell.nlY', 1);
model.result.dataset('dset1shellshl').setIndex('displacementexpr', 'ary', 1);
model.result.dataset('dset1shellshl').setIndex('orientationexpr', 'shell.nlZ', 2);
model.result.dataset('dset1shellshl').setIndex('displacementexpr', 'arz', 2);
model.result.dataset('dset1shellshl').set('distanceexpr', 'shell.z_pos');
model.result.dataset('dset1shellshl').set('seplevels', false);
model.result.dataset('dset1shellshl').set('resolution', 2);
model.result.dataset('dset1shellshl').set('areascalefactor', 'shell.ASF');
model.result.dataset('dset1shellshl').set('linescalefactor', 'shell.LSF');
model.result.create('pg1', 'PlotGroup3D');
model.result('pg1').set('data', 'dset1shellshl');
model.result('pg1').setIndex('looplevel', 21, 0);
model.result('pg1').set('defaultPlotID', 'stress');
model.result('pg1').label('Stress (shell)');
model.result('pg1').set('showlegends', true);
model.result('pg1').set('frametype', 'spatial');
model.result('pg1').create('surf1', 'Surface');
model.result('pg1').feature('surf1').set('expr', {'shell.misesGp'});
model.result('pg1').feature('surf1').set('threshold', 'manual');
model.result('pg1').feature('surf1').set('thresholdvalue', 0.2);
model.result('pg1').feature('surf1').set('colortable', 'Rainbow');
model.result('pg1').feature('surf1').set('colortabletrans', 'none');
model.result('pg1').feature('surf1').set('colorscalemode', 'linear');
model.result('pg1').feature('surf1').set('descr', 'von Mises stress');
model.result('pg1').feature('surf1').set('colortable', 'Prism');
model.result('pg1').feature('surf1').create('def', 'Deform');
model.result('pg1').feature('surf1').feature('def').set('expr', {'shell.u' 'shell.v' 'shell.w'});
model.result('pg1').feature('surf1').feature('def').set('scaleactive', true);
model.result('pg1').feature('surf1').feature('def').set('scale', '1');
model.result.create('pg2', 'PlotGroup3D');
model.result('pg2').set('data', 'dset1');
model.result('pg2').setIndex('looplevel', 21, 0);
model.result('pg2').set('defaultPlotID', 'stress');
model.result('pg2').label('Stress (solid)');
model.result('pg2').set('frametype', 'spatial');
model.result('pg2').create('vol1', 'Volume');
model.result('pg2').feature('vol1').set('expr', {'solid.misesGp'});
model.result('pg2').feature('vol1').set('threshold', 'manual');
model.result('pg2').feature('vol1').set('thresholdvalue', 0.2);
model.result('pg2').feature('vol1').set('colortable', 'Rainbow');
model.result('pg2').feature('vol1').set('colortabletrans', 'none');
model.result('pg2').feature('vol1').set('colorscalemode', 'linear');
model.result('pg2').feature('vol1').set('resolution', 'custom');
model.result('pg2').feature('vol1').set('refine', 2);
model.result('pg2').feature('vol1').set('colortable', 'Prism');
model.result('pg2').feature('vol1').create('def', 'Deform');
model.result('pg2').feature('vol1').feature('def').set('scaleactive', true);
model.result('pg2').feature('vol1').feature('def').set('scale', '1');
model.result('pg2').feature('vol1').feature('def').set('expr', {'u' 'v' 'w'});
model.result('pg2').feature('vol1').feature('def').set('descr', 'Displacement field');
model.result('pg1').run;
model.result('pg1').create('vol1', 'Volume');
model.result('pg1').feature('vol1').set('data', 'dset1');
model.result('pg1').feature('vol1').set('solutionparams', 'parent');
model.result('pg1').feature('vol1').set('expr', 'solid.misesGp');
model.result('pg1').feature('vol1').set('inheritplot', 'surf1');
model.result('pg1').feature('vol1').create('def1', 'Deform');
model.result('pg1').run;
model.result('pg1').run;

model.view('view1').set('showgrid', false);

model.result.create('pg3', 'PlotGroup3D');
model.result('pg3').set('data', 'dset1');
model.result('pg3').setIndex('looplevel', 21, 0);
model.result('pg3').set('defaultPlotID', 'contactForces');
model.result('pg3').label('Contact Forces (shell)');
model.result('pg3').set('showlegends', true);
model.result('pg3').set('titletype', 'label');
model.result('pg3').set('frametype', 'spatial');
model.result('pg3').set('showlegendsunit', true);
model.result('pg3').create('surf1', 'Surface');
model.result('pg3').feature('surf1').set('expr', {'1'});
model.result('pg3').feature('surf1').label('Gray Surfaces');
model.result('pg3').feature('surf1').set('coloring', 'uniform');
model.result('pg3').feature('surf1').set('color', 'gray');
model.result('pg3').feature('surf1').create('def', 'Deform');
model.result('pg3').feature('surf1').feature('def').set('expr', {'u' 'v' 'w'});
model.result('pg3').feature('surf1').feature('def').set('descr', 'Displacement field');
model.result('pg3').feature('surf1').feature('def').set('scaleactive', true);
model.result('pg3').feature('surf1').feature('def').set('scale', 1);
model.result('pg3').feature('surf1').create('sel1', 'Selection');
model.result('pg3').feature('surf1').feature('sel1').selection.geom('geom1', 2);
model.result('pg3').feature('surf1').feature('sel1').selection.set([1 2]);
model.result('pg3').feature('surf1').create('tran1', 'Transparency');
model.result('pg3').feature('surf1').feature('tran1').set('transparency', 0.8);
model.result('pg3').create('arws1', 'ArrowSurface');
model.result('pg3').feature('arws1').set('arrowbase', 'head');
model.result('pg3').feature('arws1').set('expr', {'shell.dcnt1.Tnx' 'shell.dcnt1.Tny' 'shell.dcnt1.Tnz'});
model.result('pg3').feature('arws1').set('placement', 'gausspoints');
model.result('pg3').feature('arws1').set('gporder', 4);
model.result('pg3').feature('arws1').label('Contact 1, Pressure');
model.result('pg3').feature('arws1').set('inheritplot', 'none');
model.result('pg3').feature('arws1').set('color', 'green');
model.result('pg3').feature('arws1').create('col', 'Color');
model.result('pg3').feature('arws1').feature('col').set('colortable', 'Rainbow');
model.result('pg3').feature('arws1').feature('col').set('colortabletrans', 'none');
model.result('pg3').feature('arws1').feature('col').set('colorscalemode', 'linear');
model.result('pg3').feature('arws1').feature('col').set('colordata', 'arrowlength');
model.result('pg3').feature('arws1').feature('col').set('coloring', 'gradient');
model.result('pg3').feature('arws1').feature('col').set('topcolor', 'green');
model.result('pg3').feature('arws1').feature('col').set('bottomcolor', 'custom');
model.result('pg3').feature('arws1').feature('col').set('custombottomcolor', [0.509804 0.54902 0.509804]);
model.result('pg3').feature('arws1').create('def', 'Deform');
model.result('pg3').feature('arws1').feature('def').set('expr', {'u' 'v' 'w'});
model.result('pg3').feature('arws1').feature('def').set('descr', 'Displacement field');
model.result('pg3').feature('arws1').feature('def').set('scaleactive', true);
model.result('pg3').feature('arws1').feature('def').set('scale', 1);
model.result('pg3').feature.move('surf1', 1);
model.result('pg3').label('Contact Forces (shell)');
model.result('pg3').run;
model.result('pg3').setIndex('looplevel', 9, 0);
model.result('pg3').run;
model.result('pg3').feature('arws1').set('scaleactive', true);
model.result('pg3').feature('arws1').set('scale', '5e-10');
model.result('pg3').feature('surf1').feature('sel1').selection.named('geom1_sel1_bnd');
model.result('pg3').run;
model.result.export.create('anim1', 'Animation');
model.result.export('anim1').set('target', 'player');
model.result.export('anim1').set('plotgroup', 'pg3');
model.result.export('anim1').run;
model.result.export('anim1').set('framesel', 'all');
model.result.export('anim1').run;
model.result.create('pg4', 'PlotGroup1D');
model.result('pg4').run;
model.result('pg4').label('Load vs. Deflection');
model.result('pg4').create('glob1', 'Global');
model.result('pg4').feature('glob1').set('markerpos', 'datapoints');
model.result('pg4').feature('glob1').set('linewidth', 'preference');
model.result('pg4').feature('glob1').setIndex('expr', 'disp_block', 0);
model.result('pg4').feature('glob1').setIndex('unit', 'mm', 0);
model.result('pg4').feature('glob1').setIndex('expr', 'disp_arch', 1);
model.result('pg4').feature('glob1').setIndex('unit', 'mm', 1);
model.result('pg4').feature('glob1').set('xdata', 'expr');
model.result('pg4').feature('glob1').set('xdataexpr', 'load');
model.result('pg4').feature('glob1').set('linemarker', 'cycle');
model.result('pg4').feature('glob1').set('markerpos', 'interp');
model.result('pg4').run;
model.result('pg4').set('switchxy', true);
model.result('pg4').set('legendpos', 'upperleft');
model.result('pg4').set('xlabelactive', true);
model.result('pg4').set('xlabel', 'Deflection (mm)');
model.result('pg4').run;
model.result.create('pg5', 'PlotGroup1D');
model.result('pg5').run;
model.result('pg5').label('Deformation');
model.result('pg5').setIndex('looplevelinput', 'manualindices', 0);
model.result('pg5').setIndex('looplevelindices', 'range(1,4,21)', 0);
model.result('pg5').set('titletype', 'none');
model.result('pg5').create('lngr1', 'LineGraph');
model.result('pg5').feature('lngr1').set('markerpos', 'datapoints');
model.result('pg5').feature('lngr1').set('linewidth', 'preference');
model.result('pg5').feature('lngr1').selection.set([2 5]);
model.result('pg5').feature('lngr1').set('expr', 'z');
model.result('pg5').feature('lngr1').set('xdata', 'expr');
model.result('pg5').feature('lngr1').set('xdataexpr', 'x');
model.result('pg5').feature('lngr1').set('linewidth', 2);
model.result('pg5').feature.duplicate('lngr2', 'lngr1');
model.result('pg5').run;
model.result('pg5').feature('lngr2').selection.set([9 10 14 17 20]);
model.result('pg5').feature('lngr2').set('linestyle', 'dashed');
model.result('pg5').feature('lngr2').set('linecolor', 'cyclereset');
model.result('pg5').run;
model.result('pg5').feature('lngr1').set('legend', true);
model.result('pg5').feature('lngr1').set('legendprefix', 'para = ');
model.result('pg5').run;
model.result('pg1').run;

model.title('Block Pressing on Arch');

model.description('This conceptual example shows how to calculate critical points in models with contact. The model consists of a block modeled with the Solid Mechanics interface pressing on an arch modeled with the Shell interface. The contact problem is solved using the augmented Lagrangian method. The block is loaded with a displacement controlled boundary load and is incrementally pressed toward the arch. During loading, there is a snap-through behavior of the arch, but the solution remains stable.');

model.mesh.clearMeshes;

model.sol('sol1').clearSolutionData;

model.label('block_on_arch.mph');

model.modelNode.label('Components');

out = model;
