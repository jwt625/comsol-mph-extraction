function out = model
%
% two_arches.m
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

model.study.create('std1');
model.study('std1').create('stat', 'Stationary');
model.study('std1').feature('stat').setSolveFor('/physics/shell', true);

% To import content from file, use:
% model.param.loadFile('FILENAME');
model.param.set('Ri_upper', '80[mm]', 'Upper arch radius');
model.param.set('Ri_lower', '100[mm]', 'Lower arch radius');
model.param.set('d', '3[mm]', 'Arch thickness');
model.param.set('seg_upper', '80[deg]', 'Upper arch segment');
model.param.set('seg_lower', '100[deg]', 'Lower arch segment');
model.param.set('n_elem_upper', '30', 'Number of mesh elements, upper arch');
model.param.set('n_elem_lower', '75', 'Number of mesh elements, lower arch');
model.param.set('F_ref', '-1[N/mm]', 'Reference load value');
model.param.set('max_disp', '60[mm]', 'Maximum displacement');
model.param.set('para', '0', 'Load parameter');

model.geom('geom1').create('wp1', 'WorkPlane');
model.geom('geom1').feature('wp1').set('unite', true);
model.geom('geom1').feature('wp1').set('quickplane', 'xz');
model.geom('geom1').feature('wp1').geom.create('c1', 'Circle');
model.geom('geom1').feature('wp1').geom.feature('c1').set('type', 'curve');
model.geom('geom1').feature('wp1').geom.feature('c1').set('r', 'Ri_upper');
model.geom('geom1').feature('wp1').geom.feature('c1').set('angle', 'seg_upper');
model.geom('geom1').feature('wp1').geom.feature('c1').set('pos', {'0' 'Ri_upper'});
model.geom('geom1').feature('wp1').geom.feature('c1').set('rot', '-90-seg_upper/2');
model.geom('geom1').feature('wp1').geom.run('c1');
model.geom('geom1').feature('wp1').geom.create('c2', 'Circle');
model.geom('geom1').feature('wp1').geom.feature('c2').set('type', 'curve');
model.geom('geom1').feature('wp1').geom.feature('c2').set('r', 'Ri_lower');
model.geom('geom1').feature('wp1').geom.feature('c2').set('angle', 'seg_lower');
model.geom('geom1').feature('wp1').geom.feature('c2').set('pos', {'0' '-Ri_lower'});
model.geom('geom1').feature('wp1').geom.feature('c2').set('rot', '90-seg_lower/2');
model.geom('geom1').feature('wp1').geom.run('c2');
model.geom('geom1').feature('wp1').geom.create('del1', 'Delete');
model.geom('geom1').feature('wp1').geom.feature('del1').selection('input').set('c1', [2 3]);
model.geom('geom1').feature('wp1').geom.feature('del1').selection('input').set('c2', [3 4]);
model.geom('geom1').feature('wp1').geom.run('del1');
model.geom('geom1').feature('wp1').geom.create('pare1', 'PartitionEdges');
model.geom('geom1').feature('wp1').geom.feature('pare1').selection('edge').set('del1(1)', 1);
model.geom('geom1').feature('wp1').set('unite', false);
model.geom('geom1').run('wp1');
model.geom('geom1').feature.create('ext1', 'Extrude');
model.geom('geom1').feature('ext1').set('workplane', 'wp1');
model.geom('geom1').feature('ext1').selection('input').set({'wp1'});
model.geom('geom1').feature('ext1').setIndex('distance', 'd', 0);
model.geom('geom1').run('ext1');
model.geom('geom1').create('sel1', 'ExplicitSelection');
model.geom('geom1').feature('sel1').label('Upper Arch');
model.geom('geom1').feature('sel1').selection('selection').init;
model.geom('geom1').feature('sel1').selection('selection').set({'ext1(2)'});
model.geom('geom1').feature('sel1').set('color', '4');
model.geom('geom1').run('sel1');
model.geom('geom1').feature.duplicate('sel2', 'sel1');
model.geom('geom1').feature('sel2').label('Lower Arch');
model.geom('geom1').feature('sel2').selection('selection').set({'ext1(1)'});
model.geom('geom1').feature('sel2').set('color', '12');
model.geom('geom1').feature('fin').set('action', 'assembly');
model.geom('geom1').run('fin');

model.material.create('mat1', 'Common', 'comp1');
model.material('mat1').selection.named('geom1_sel2_bnd');
model.material('mat1').propertyGroup.create('Enu', 'Young''s_modulus_and_Poisson''s_ratio');
model.material('mat1').propertyGroup('Enu').set('E', {'40[GPa]'});
model.material('mat1').propertyGroup('Enu').set('nu', {'0.2'});
model.material('mat1').propertyGroup('def').set('density', {'1'});
model.material.create('mat2', 'Common', 'comp1');
model.material('mat2').selection.named('geom1_sel1_bnd');
model.material('mat2').propertyGroup.create('Enu', 'Young''s_modulus_and_Poisson''s_ratio');
model.material('mat2').propertyGroup('Enu').set('E', {'20[GPa]'});
model.material('mat2').propertyGroup('Enu').set('nu', {'0.3'});
model.material('mat2').propertyGroup('def').set('density', {'1'});

model.cpl.create('aveop1', 'Average', 'geom1');
model.cpl('aveop1').set('axisym', true);
model.cpl('aveop1').selection.geom('geom1', 0);
model.cpl('aveop1').selection.set([9]);
model.cpl.duplicate('aveop2', 'aveop1');
model.cpl('aveop2').selection.set([3]);
model.cpl.duplicate('aveop3', 'aveop2');
model.cpl('aveop3').selection.set([7 11]);

model.variable.create('var1');
model.variable('var1').model('comp1');
model.variable('var1').set('disp_upper', 'aveop1(-w)');
model.variable('var1').descr('disp_upper', 'Upper arch displacement');
model.variable('var1').set('disp_lower', 'aveop2(-w)');
model.variable('var1').descr('disp_lower', 'Lower arch displacement');
model.variable('var1').set('disp_load', 'aveop3(-w)');
model.variable('var1').descr('disp_load', 'Average load point displacement');

model.pair.create('p1', 'Contact', 'geom1');
model.pair('p1').source.named('geom1_sel1_bnd');
model.pair('p1').destination.named('geom1_sel2_bnd');

model.physics('shell').feature('to1').set('d', 'd');
model.physics('shell').feature('to1').set('OffsetDefinition', 'top');
model.physics('shell').create('sym1', 'SymmetrySolid1', 1);
model.physics('shell').feature('sym1').selection.set([2 3 5 6 9 10 12 13]);
model.physics('shell').create('disp1', 'Displacement1', 1);
model.physics('shell').feature('disp1').selection.set([8 14]);
model.physics('shell').feature('disp1').setIndex('Direction', 'prescribed', 0);
model.physics('shell').feature('disp1').setIndex('Direction', 'prescribed', 1);
model.physics('shell').create('disp2', 'Displacement1', 1);
model.physics('shell').feature('disp2').selection.set([1 7]);
model.physics('shell').feature('disp2').setIndex('Direction', 'prescribed', 0);
model.physics('shell').feature('disp2').setIndex('Direction', 'prescribed', 1);
model.physics('shell').feature('disp2').setIndex('Direction', 'prescribed', 2);
model.physics('shell').feature('disp2').set('RotationType', 'RotationGroup');
model.physics('shell').create('el1', 'EdgeLoad', 1);
model.physics('shell').feature('el1').selection.set([8 14]);
model.physics('shell').feature('el1').set('FeperLength', {'0' '0' 'load*F_ref'});
model.physics('shell').create('ge1', 'GlobalEquations', -1);
model.physics('shell').feature('ge1').setIndex('name', 'load', 0, 0);
model.physics('shell').feature('ge1').setIndex('equation', 'disp_upper-max_disp*para', 0, 0);
model.physics('shell').feature('ge1').setIndex('description', 'Load factor', 0, 0);
model.physics('shell').feature('ge1').set('SourceTermQuantity', 'displacement');
model.physics('shell').create('sym2', 'SymmetrySolid1', 1);
model.physics('shell').feature('sym2').selection.set([4 11]);

model.mesh('mesh1').create('map1', 'Map');
model.mesh('mesh1').feature('map1').selection.all;
model.mesh('mesh1').feature('map1').create('dis1', 'Distribution');
model.mesh('mesh1').feature('map1').feature('dis1').selection.set([2 5]);
model.mesh('mesh1').feature('map1').feature('dis1').set('numelem', 'n_elem_lower');
model.mesh('mesh1').feature('map1').create('dis2', 'Distribution');
model.mesh('mesh1').feature('map1').feature('dis2').selection.set([9 12]);
model.mesh('mesh1').feature('map1').feature('dis2').set('numelem', 'n_elem_upper');
model.mesh('mesh1').run;

model.study('std1').feature('stat').set('useparam', true);
model.study('std1').feature('stat').setIndex('pname', 'Ri_upper', 0);
model.study('std1').feature('stat').setIndex('plistarr', '', 0);
model.study('std1').feature('stat').setIndex('punit', 'm', 0);
model.study('std1').feature('stat').setIndex('pname', 'Ri_upper', 0);
model.study('std1').feature('stat').setIndex('plistarr', '', 0);
model.study('std1').feature('stat').setIndex('punit', 'm', 0);
model.study('std1').feature('stat').setIndex('pname', 'para', 0);
model.study('std1').feature('stat').setIndex('plistarr', 'range(0,0.02,1)', 0);
model.study('std1').feature('stat').setIndex('punit', '', 0);

model.sol.create('sol1');
model.sol('sol1').study('std1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'stat');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').feature('comp1_ar').set('scalemethod', 'manual');
model.sol('sol1').feature('v1').feature('comp1_u').set('scalemethod', 'manual');
model.sol('sol1').feature('v1').feature('comp1_ar').set('resscalemethod', 'parent');
model.sol('sol1').feature('v1').feature('comp1_ar').set('scaleval', '0.01');
model.sol('sol1').feature('v1').feature('comp1_u').set('scaleval', '1e-2*0.16262049362578448');
model.sol('sol1').feature('v1').set('control', 'stat');
model.sol('sol1').create('s1', 'Stationary');
model.sol('sol1').feature('s1').create('p1', 'Parametric');
model.sol('sol1').feature('s1').feature.remove('pDef');
model.sol('sol1').feature('s1').feature('p1').set('porder', 'constant');
model.sol('sol1').feature('s1').feature('p1').set('control', 'stat');
model.sol('sol1').feature('s1').set('control', 'stat');
model.sol('sol1').feature('s1').feature('aDef').set('cachepattern', true);
model.sol('sol1').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('s1').feature('fc1').set('dtech', 'auto');
model.sol('sol1').feature('s1').feature('fc1').set('linsolver', 'dDef');
model.sol('sol1').feature('s1').feature('fc1').set('dtech', 'auto');
model.sol('sol1').feature('s1').feature.remove('fcDef');
model.sol('sol1').attach('std1');
model.sol('sol1').feature('s1').set('stol', '0.0005');
model.sol('sol1').feature('s1').feature('p1').set('paramtuning', true);
model.sol('sol1').feature('s1').feature('p1').set('pminstep', '1e-6');
model.sol('sol1').feature('s1').feature('p1').create('st1', 'StopCondition');
model.sol('sol1').feature('s1').feature('p1').feature('st1').setIndex('stopcondarr', '', 0);
model.sol('sol1').feature('s1').feature('p1').feature('st1').setIndex('stopcondterminateon', 'true', 0);
model.sol('sol1').feature('s1').feature('p1').feature('st1').setIndex('stopcondActive', true, 0);
model.sol('sol1').feature('s1').feature('p1').feature('st1').setIndex('stopconddesc', 'Stop expression 1', 0);
model.sol('sol1').feature('s1').feature('p1').feature('st1').setIndex('stopcondarr', '', 0);
model.sol('sol1').feature('s1').feature('p1').feature('st1').setIndex('stopcondterminateon', 'true', 0);
model.sol('sol1').feature('s1').feature('p1').feature('st1').setIndex('stopcondActive', true, 0);
model.sol('sol1').feature('s1').feature('p1').feature('st1').setIndex('stopconddesc', 'Stop expression 1', 0);
model.sol('sol1').feature('s1').feature('p1').feature('st1').setIndex('stopcondarr', 'comp1.load/250', 0);
model.sol('sol1').feature('s1').feature('p1').feature('st1').set('storestopcondsol', 'stepbefore');
model.sol('sol1').feature('s1').feature('fc1').set('dtech', 'const');
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
model.result('pg1').setIndex('looplevel', 46, 0);
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
model.result('pg1').run;
model.result('pg1').run;

model.view('view1').set('showgrid', false);

model.result.create('pg2', 'PlotGroup3D');
model.result('pg2').set('data', 'dset1');
model.result('pg2').setIndex('looplevel', 46, 0);
model.result('pg2').set('defaultPlotID', 'contactForces');
model.result('pg2').label('Contact Forces (shell)');
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
model.result('pg2').feature('surf1').feature('sel1').selection.set([1 2 3 4]);
model.result('pg2').feature('surf1').create('tran1', 'Transparency');
model.result('pg2').feature('surf1').feature('tran1').set('transparency', 0.8);
model.result('pg2').create('arws1', 'ArrowSurface');
model.result('pg2').feature('arws1').set('arrowbase', 'head');
model.result('pg2').feature('arws1').set('expr', {'shell.dcnt1.Tnx' 'shell.dcnt1.Tny' 'shell.dcnt1.Tnz'});
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
model.result('pg2').label('Contact Forces (shell)');
model.result('pg2').run;
model.result('pg2').setIndex('looplevel', 31, 0);
model.result('pg2').run;
model.result('pg2').feature('arws1').set('scaleactive', true);
model.result('pg2').feature('arws1').set('scale', '2e-10');
model.result('pg2').run;
model.result.export.create('anim1', 'Animation');
model.result.export('anim1').set('target', 'player');
model.result.export('anim1').set('plotgroup', 'pg2');
model.result.export('anim1').run;
model.result.export('anim1').set('framesel', 'all');
model.result.export('anim1').run;
model.result.create('pg3', 'PlotGroup1D');
model.result('pg3').run;
model.result('pg3').label('Load vs. Deflection');
model.result('pg3').create('glob1', 'Global');
model.result('pg3').feature('glob1').set('markerpos', 'datapoints');
model.result('pg3').feature('glob1').set('linewidth', 'preference');
model.result('pg3').feature('glob1').setIndex('expr', 'disp_upper', 0);
model.result('pg3').feature('glob1').setIndex('unit', 'mm', 0);
model.result('pg3').feature('glob1').setIndex('expr', 'disp_lower', 1);
model.result('pg3').feature('glob1').setIndex('unit', 'mm', 1);
model.result('pg3').feature('glob1').setIndex('expr', 'disp_load', 2);
model.result('pg3').feature('glob1').setIndex('unit', 'mm', 2);
model.result('pg3').feature('glob1').set('xdata', 'expr');
model.result('pg3').feature('glob1').set('xdataexpr', 'load');
model.result('pg3').feature('glob1').set('linemarker', 'cycle');
model.result('pg3').feature('glob1').set('markerpos', 'interp');
model.result('pg3').run;
model.result('pg3').set('switchxy', true);
model.result('pg3').set('legendpos', 'upperleft');
model.result('pg3').set('xlabelactive', true);
model.result('pg3').set('xlabel', 'Deflection (mm)');
model.result('pg3').run;
model.result.create('pg4', 'PlotGroup1D');
model.result('pg4').run;
model.result('pg4').label('Deformation');
model.result('pg4').setIndex('looplevelinput', 'manualindices', 0);
model.result('pg4').setIndex('looplevelindices', 'range(1,10,41)', 0);
model.result('pg4').set('titletype', 'none');
model.result('pg4').create('lngr1', 'LineGraph');
model.result('pg4').feature('lngr1').set('markerpos', 'datapoints');
model.result('pg4').feature('lngr1').set('linewidth', 'preference');
model.result('pg4').feature('lngr1').selection.set([2 5]);
model.result('pg4').feature('lngr1').set('expr', 'z');
model.result('pg4').feature('lngr1').set('xdata', 'expr');
model.result('pg4').feature('lngr1').set('xdataexpr', 'x');
model.result('pg4').feature('lngr1').set('linewidth', 2);
model.result('pg4').feature.duplicate('lngr2', 'lngr1');
model.result('pg4').run;
model.result('pg4').feature('lngr2').selection.set([9 12]);
model.result('pg4').feature('lngr2').set('linestyle', 'dashed');
model.result('pg4').feature('lngr2').set('linecolor', 'cyclereset');
model.result('pg4').run;
model.result('pg4').feature('lngr1').set('legend', true);
model.result('pg4').feature('lngr1').set('legendprefix', 'para = ');
model.result('pg4').run;
model.result('pg1').run;

model.title('Instability of Two Contacting Arches');

model.description('This conceptual example shows how to calculate critical points in models with contact. The model consists of two contacting arches modeled with the Shell interface. The contact problem is solved using the penalty method. The upper arch is loaded with displacement controlled edge loads and is pressed toward the lower arch. During loading, a snap-through behavior of the lower arch is observed with several critical point related to sideways instability. In order to obtain a stable reference solution, the sideways movement of the mid edge of both arches is constrained.');

model.mesh.clearMeshes;

model.sol('sol1').clearSolutionData;

model.label('two_arches.mph');

model.modelNode.label('Components');

out = model;
