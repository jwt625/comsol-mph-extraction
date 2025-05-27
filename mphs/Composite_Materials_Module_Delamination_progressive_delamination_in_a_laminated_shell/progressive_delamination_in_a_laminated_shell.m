function out = model
%
% progressive_delamination_in_a_laminated_shell.m
%
% Model exported on May 26 2025, 21:27 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/Composite_Materials_Module/Delamination');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 3);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.physics.create('lshell', 'LayeredShell', 'geom1');
model.physics('lshell').model('comp1');

model.study.create('std1');
model.study('std1').create('stat', 'Stationary');
model.study('std1').feature('stat').setSolveFor('/physics/lshell', true);

% To import content from file, use:
% model.param.loadFile('FILENAME');
model.param.set('lb', '100[mm]', 'Length');
model.param.set('wb', '50[mm]', 'Width');
model.param.set('hb', '1.5[mm]', 'Layer thickness');
model.param.set('pn', '1e6[N/mm^3]', 'Penalty stiffness');
model.param.set('N_strength', '80[MPa]', 'Normal tensile strength');
model.param.set('S_strength', '100[MPa]', 'Shear strength');
model.param.set('GIc', '0.969[kJ/m^2]', 'Mode I critical energy release rate');
model.param.set('GIIc', '1.719[kJ/m^2]', 'Mode II critical energy release rate');
model.param.set('eta', '2.284', 'Exponent of Benzeggagh and Kenane (B-K) criterion');
model.param.set('Fmax', '28[kN]', 'Maximum applied force');
model.param.set('para', '0', 'Load parameter');

model.material.create('mat1', 'Common', '');
model.material('mat1').label('AS4/PEEK');
model.material.create('lmat1', 'LayeredMaterial', '');
model.material('lmat1').label('Layered Material: [0/45]');
model.material('lmat1').setIndex('rotation', 0, 0);
model.material('lmat1').setIndex('thickness', 'hb', 0);
model.material('lmat1').setIndex('meshPoints', 1, 0);
model.material('lmat1').setIndex('layername', 'Layer 2', 1);
model.material('lmat1').setIndex('link', 'mat1', 1);
model.material('lmat1').setIndex('rotation', 0, 1);
model.material('lmat1').setIndex('thickness', 'hb', 1);
model.material('lmat1').setIndex('meshPoints', 1, 1);
model.material('lmat1').setIndex('tag', 'lmat1_2', 1);
model.material('lmat1').setIndex('layername', 'Layer 2', 1);
model.material('lmat1').setIndex('link', 'mat1', 1);
model.material('lmat1').setIndex('rotation', 0, 1);
model.material('lmat1').setIndex('thickness', 'hb', 1);
model.material('lmat1').setIndex('meshPoints', 1, 1);
model.material('lmat1').setIndex('tag', 'lmat1_2', 1);
model.material('lmat1').setIndex('rotation', 45, 1);

model.variable.create('var1');
model.variable('var1').model('comp1');

model.geom('geom1').run;

model.variable('var1').set('F', 'Fmax*sin(pi*para)');
model.variable('var1').descr('F', 'Applied force');

model.coordSystem('sys1').set('frametype', 'material');
model.coordSystem('sys1').set('mastercoordsystcomp', '1');

model.geom('geom1').create('wp1', 'WorkPlane');
model.geom('geom1').feature('wp1').set('unite', true);
model.geom('geom1').feature('wp1').geom.create('r1', 'Rectangle');
model.geom('geom1').feature('wp1').geom.feature('r1').set('size', {'lb/2' 'wb'});
model.geom('geom1').feature('wp1').geom.run('r1');
model.geom('geom1').feature('wp1').geom.create('c1', 'Circle');
model.geom('geom1').feature('wp1').geom.feature('c1').set('r', 'lb/10');
model.geom('geom1').feature('wp1').geom.feature('c1').set('pos', {'lb/5' 'wb/2'});
model.geom('geom1').feature('wp1').geom.run('c1');
model.geom('geom1').feature('wp1').geom.create('r2', 'Rectangle');
model.geom('geom1').feature('wp1').geom.feature('r2').set('size', {'lb/5' 'wb'});
model.geom('geom1').feature('wp1').geom.run('r2');
model.geom('geom1').feature('wp1').geom.create('mir1', 'Mirror');
model.geom('geom1').feature('wp1').geom.feature('mir1').selection('input').set({'c1' 'r1' 'r2'});
model.geom('geom1').feature('wp1').geom.feature('mir1').set('keep', true);
model.geom('geom1').feature('wp1').geom.feature('mir1').set('pos', {'lb/2' '0'});
model.geom('geom1').feature('wp1').geom.run('mir1');
model.geom('geom1').run('fin');
model.geom('geom1').create('ige1', 'IgnoreEdges');
model.geom('geom1').feature('ige1').selection('input').set('fin', [8 20]);
model.geom('geom1').run('ige1');

model.view('view1').set('showgrid', false);

model.physics('lshell').feature('lemm1').set('TransverseIsotropic', true);

model.material.create('llmat1', 'LayeredMaterialLink', 'comp1');
model.material('mat1').propertyGroup.create('TransverseIsotropic', 'Transversely_isotropic');
model.material('mat1').propertyGroup('TransverseIsotropic').set('Evect', {'122.7e9' '10.1e9'});
model.material('mat1').propertyGroup('TransverseIsotropic').set('nuvect', {'0.25' '0.45'});
model.material('mat1').propertyGroup('TransverseIsotropic').set('Gvect1', {'5.5e9'});
model.material('mat1').propertyGroup('def').set('density', {'1570'});

model.physics('lshell').prop('LayerSelection').set('bndType', 'allShell');
model.physics('lshell').create('del1', 'Delamination', 2);
model.physics('lshell').feature('del1').selection.set([2 5]);
model.physics('lshell').feature('del1').set('InitialState', 'Delaminated');
model.physics('lshell').feature('del1').set('pn', 'pn');
model.physics('lshell').create('del2', 'Delamination', 2);
model.physics('lshell').feature('del2').selection.set([1 3 4 6]);
model.physics('lshell').feature('del2').set('StiffnessInput', 'UserDefined');
model.physics('lshell').feature('del2').set('kPerArea', {'pn' 'pn' 'pn'});
model.physics('lshell').feature('del2').set('sigmat', 'N_strength');
model.physics('lshell').feature('del2').set('sigmas', 'S_strength');
model.physics('lshell').feature('del2').set('Gct', 'GIc');
model.physics('lshell').feature('del2').set('Gcs', 'GIIc');
model.physics('lshell').feature('del2').set('FailureCriterion', 'BK');
model.physics('lshell').feature('del2').set('alpha', 'eta');
model.physics('lshell').feature('del2').set('PenaltyFactor', 'FromAdhesiveStiffness');
model.physics('lshell').create('fix1', 'Fixed', 1);
model.physics('lshell').feature('fix1').selection.set([1 23]);
model.physics('lshell').create('fl1', 'FaceLoad', 2);
model.physics('lshell').feature('fl1').selection.all;
model.physics('lshell').feature('fl1').set('applyTo', 'top');
model.physics('lshell').feature('fl1').set('LoadType', 'TotalForce');
model.physics('lshell').feature('fl1').set('Ftot', {'0' '0' '-F'});

model.mesh('mesh1').create('map1', 'Map');
model.mesh('mesh1').feature('map1').selection.all;
model.mesh('mesh1').feature('map1').create('dis1', 'Distribution');
model.mesh('mesh1').feature('map1').feature('dis1').selection.set([4 5 6 8 9 10 15 16 17 19 20 21]);
model.mesh('mesh1').feature('map1').feature('dis1').set('numelem', 25);
model.mesh('mesh1').run;

model.study('std1').feature('stat').set('geometricNonlinearity', true);
model.study('std1').feature('stat').set('useparam', true);
model.study('std1').feature('stat').setIndex('pname', 'lb', 0);
model.study('std1').feature('stat').setIndex('plistarr', '', 0);
model.study('std1').feature('stat').setIndex('punit', 'm', 0);
model.study('std1').feature('stat').setIndex('pname', 'lb', 0);
model.study('std1').feature('stat').setIndex('plistarr', '', 0);
model.study('std1').feature('stat').setIndex('punit', 'm', 0);
model.study('std1').feature('stat').setIndex('pname', 'para', 0);
model.study('std1').feature('stat').setIndex('plistarr', 'range(0,0.025,0.5) range(0.55,0.05,1)', 0);
model.study('std1').feature('stat').setIndex('punit', '', 0);

model.sol.create('sol1');
model.sol('sol1').study('std1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'stat');
model.sol('sol1').create('v1', 'Variables');
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
model.sol('sol1').feature('s1').feature('fc1').set('linsolver', 'dDef');
model.sol('sol1').feature('s1').feature('fc1').set('termonres', 'auto');
model.sol('sol1').feature('s1').feature('fc1').set('reserrfact', 1000);
model.sol('sol1').feature('s1').feature.remove('fcDef');
model.sol('sol1').attach('std1');
model.sol('sol1').feature('s1').feature('fc1').set('dtech', 'const');
model.sol('sol1').runAll;

model.result.dataset.create('dset1lshelllshl', 'LayeredMaterial');
model.result.dataset('dset1lshelllshl').set('data', 'dset1');
model.result.create('pg1', 'PlotGroup3D');
model.result('pg1').set('data', 'dset1lshelllshl');
model.result('pg1').setIndex('looplevel', 31, 0);
model.result('pg1').set('defaultPlotID', 'stress');
model.result('pg1').label('Stress (lshell)');
model.result('pg1').set('frametype', 'spatial');
model.result('pg1').set('showlegends', true);
model.result('pg1').create('surf1', 'Surface');
model.result('pg1').feature('surf1').set('expr', {'lshell.misesGp'});
model.result('pg1').feature('surf1').set('threshold', 'manual');
model.result('pg1').feature('surf1').set('thresholdvalue', 0.2);
model.result('pg1').feature('surf1').set('colortable', 'Rainbow');
model.result('pg1').feature('surf1').set('colortabletrans', 'none');
model.result('pg1').feature('surf1').set('colorscalemode', 'linear');
model.result('pg1').feature('surf1').set('colortable', 'Prism');
model.result('pg1').feature('surf1').create('def', 'Deform');
model.result('pg1').feature('surf1').feature('def').set('scaleactive', true);
model.result('pg1').feature('surf1').feature('def').set('scale', '1');
model.result('pg1').feature('surf1').feature('def').set('expr', {'u' 'v' 'w'});
model.result('pg1').feature('surf1').feature('def').set('descr', 'Displacement field (material and geometry frames)');
model.result('pg1').run;
model.result('pg1').setIndex('looplevel', 21, 0);
model.result('pg1').run;
model.result('pg1').feature('surf1').set('unit', 'MPa');
model.result('pg1').feature('surf1').set('rangecoloractive', true);
model.result('pg1').feature('surf1').set('rangecolormax', '2e3');
model.result('pg1').run;

model.view('view1').set('showgrid', true);

model.result.create('pg2', 'PlotGroup3D');
model.result('pg2').set('data', 'dset1');
model.result('pg2').setIndex('looplevel', 31, 0);
model.result('pg2').set('defaultPlotID', 'stressSlice');
model.result('pg2').label('Stress, Slice (lshell)');
model.result('pg2').set('showlegends', true);
model.result('pg2').set('frametype', 'spatial');
model.result('pg2').create('lss1', 'LayeredMaterialSlice');
model.result('pg2').feature('lss1').set('expr', {'lshell.misesGp'});
model.result('pg2').feature('lss1').set('threshold', 'manual');
model.result('pg2').feature('lss1').set('thresholdvalue', 0.2);
model.result('pg2').feature('lss1').set('colortable', 'Prism');
model.result('pg2').feature('lss1').set('colortabletrans', 'none');
model.result('pg2').feature('lss1').set('colorscalemode', 'linear');
model.result('pg2').feature('lss1').set('locdef', 'relative');
model.result('pg2').feature('lss1').set('localzrel', 'lshell.z');
model.result('pg2').feature('lss1').create('def', 'Deform');
model.result('pg2').feature('lss1').feature('def').set('scaleactive', true);
model.result('pg2').feature('lss1').feature('def').set('scale', '1');
model.result('pg2').feature('lss1').feature('def').set('expr', {'u' 'v' 'w'});
model.result('pg2').feature('lss1').feature('def').set('descr', 'Displacement field (material and geometry frames)');
model.result('pg2').label('Stress, Slice (lshell)');
model.result('pg2').run;
model.result('pg2').setIndex('looplevel', 21, 0);
model.result('pg2').set('edges', false);
model.result('pg2').run;
model.result('pg2').feature('lss1').set('locdef', 'layermidplanes');
model.result('pg2').feature('lss1').set('slicedisplacement', 'linear');
model.result('pg2').feature('lss1').set('orientationlinear', 'y');
model.result('pg2').feature('lss1').set('unit', 'MPa');
model.result('pg2').feature('lss1').set('rangecoloractive', true);
model.result('pg2').feature('lss1').set('rangecolormax', '1e3');
model.result('pg2').run;
model.result('pg2').set('view', 'new');
model.result('pg2').run;

model.view('view4').camera.setIndex('position', -0.3472034931182861, 0);
model.view('view4').camera.setIndex('position', -0.475843906402587, 1);
model.view('view4').camera.setIndex('position', 0.3949922621250152, 2);
model.view('view4').camera.setIndex('target', 0.05000001192092895, 0);
model.view('view4').camera.setIndex('target', 0.0537607073783874, 1);
model.view('view4').camera.setIndex('target', -0.00221124291419982, 2);
model.view('view4').camera.setIndex('up', 0.308697462081909, 0);
model.view('view4').camera.setIndex('up', 0.411596596240997, 1);
model.view('view4').camera.setIndex('up', 0.857492923736572, 2);
model.view('view4').camera.setIndex('rotationpoint', '0.0500000007450580', 0);
model.view('view4').camera.setIndex('rotationpoint', 0.0537607185542583, 1);
model.view('view4').camera.setIndex('rotationpoint', -0.00221124151721596, 2);
model.view('view4').camera.setIndex('viewoffset', '-0.0462192036211490', 0);
model.view('view4').camera.setIndex('viewoffset', '0.01211879123002290', 1);
model.view('view4').camera.set('zoomanglefull', 13.9859724044799);

model.result.create('pg3', 'PlotGroup3D');
model.result('pg3').run;
model.result('pg3').label('Interface Health, 100% Damaged');
model.result('pg3').setIndex('looplevel', 21, 0);
model.result('pg3').set('frametype', 'spatial');
model.result('pg3').set('titletype', 'label');
model.result('pg3').create('lss1', 'LayeredMaterialSlice');
model.result('pg3').feature('lss1').set('expr', 'lshell.idmg');
model.result('pg3').feature('lss1').set('locdef', 'interfaces');
model.result('pg3').feature('lss1').set('colortable', 'Traffic');
model.result('pg3').feature('lss1').create('def1', 'Deform');
model.result('pg3').run;
model.result('pg3').feature('lss1').feature('def1').set('scaleactive', true);
model.result('pg3').feature('lss1').feature('def1').set('scale', 1);
model.result('pg3').run;
model.result('pg3').run;
model.result.duplicate('pg4', 'pg3');
model.result('pg4').run;
model.result('pg4').label('Interface Health, 90% Damaged');
model.result('pg4').run;
model.result('pg4').feature('lss1').set('expr', 'lshell.idmg>=0.9');
model.result('pg4').run;
model.result('pg4').run;
model.result.create('pg5', 'PlotGroup3D');
model.result('pg5').run;
model.result('pg5').label('Adhesive Stress, t1 Direction');
model.result('pg5').setIndex('looplevel', 21, 0);
model.result('pg5').set('frametype', 'spatial');
model.result('pg5').create('lss1', 'LayeredMaterialSlice');
model.result('pg5').feature('lss1').set('expr', 'lshell.fst1');
model.result('pg5').feature('lss1').set('descr', 'Adhesive stress, t1-component');
model.result('pg5').feature('lss1').set('unit', 'MPa');
model.result('pg5').feature('lss1').set('locdef', 'interfaces');
model.result('pg5').feature('lss1').set('colortable', 'RainbowLight');
model.result('pg5').feature('lss1').set('colorscalemode', 'linearsymmetric');
model.result('pg5').feature('lss1').create('def1', 'Deform');
model.result('pg5').run;
model.result('pg5').feature('lss1').feature('def1').set('scaleactive', true);
model.result('pg5').feature('lss1').feature('def1').set('scale', 1);
model.result('pg5').run;
model.result('pg5').run;
model.result.dataset.create('lshl1', 'LayeredMaterial');
model.result.dataset('lshl1').label('Layered Material (Interfaces)');
model.result.dataset('lshl1').set('evaluatein', 'interfaces');
model.result.numerical.create('int1', 'IntSurface');
model.result.numerical('int1').set('intvolume', true);
model.result.numerical('int1').set('data', 'lshl1');
model.result.numerical('int1').selection.all;
model.result.numerical('int1').setIndex('expr', 'lshell.idmg/(lb*wb)', 0);
model.result.numerical('int1').setIndex('unit', '%', 0);
model.result.numerical('int1').setIndex('descr', 'Damage area', 0);
model.result.numerical('int1').setIndex('expr', '(lshell.idmg>=0.9)/(lb*wb)', 1);
model.result.numerical('int1').setIndex('unit', '%', 1);
model.result.numerical('int1').setIndex('descr', 'Damage area, 90% damaged', 1);
model.result.table.create('tbl1', 'Table');
model.result.table('tbl1').comments('Surface Integration 1');
model.result.numerical('int1').set('table', 'tbl1');
model.result.numerical('int1').setResult;
model.result.create('pg6', 'PlotGroup1D');
model.result('pg6').run;
model.result('pg6').label('Load vs. Damage');
model.result('pg6').set('titletype', 'label');
model.result('pg6').set('xlabelactive', true);
model.result('pg6').set('xlabel', 'para (1)');
model.result('pg6').set('ylabelactive', true);
model.result('pg6').set('ylabel', 'Total damage area (%)');
model.result('pg6').set('twoyaxes', true);
model.result('pg6').set('legendlayout', 'outside');
model.result('pg6').set('legendposoutside', 'bottom');
model.result('pg6').create('tblp1', 'Table');
model.result('pg6').feature('tblp1').set('markerpos', 'datapoints');
model.result('pg6').feature('tblp1').set('linewidth', 'preference');
model.result('pg6').feature('tblp1').set('legend', true);
model.result('pg6').run;
model.result('pg6').create('glob1', 'Global');
model.result('pg6').feature('glob1').set('markerpos', 'datapoints');
model.result('pg6').feature('glob1').set('linewidth', 'preference');
model.result('pg6').feature('glob1').set('data', 'dset1');
model.result('pg6').feature('glob1').set('plotonsecyaxis', true);
model.result('pg6').feature('glob1').setIndex('expr', 'F', 0);
model.result('pg6').feature('glob1').setIndex('unit', 'kN', 0);
model.result('pg6').feature('glob1').setIndex('descr', 'Applied force', 0);
model.result('pg6').run;
model.result('pg6').run;
model.result.export.create('anim1', 'Animation');
model.result.export('anim1').set('target', 'player');
model.result.export('anim1').set('fontsize', '9');
model.result.export('anim1').set('colortheme', 'globaltheme');
model.result.export('anim1').set('customcolor', [1 1 1]);
model.result.export('anim1').set('background', 'color');
model.result.export('anim1').set('gltfincludelines', 'on');
model.result.export('anim1').set('title1d', 'on');
model.result.export('anim1').set('legend1d', 'on');
model.result.export('anim1').set('logo1d', 'on');
model.result.export('anim1').set('options1d', 'on');
model.result.export('anim1').set('title2d', 'on');
model.result.export('anim1').set('legend2d', 'on');
model.result.export('anim1').set('logo2d', 'on');
model.result.export('anim1').set('options2d', 'off');
model.result.export('anim1').set('title3d', 'on');
model.result.export('anim1').set('legend3d', 'on');
model.result.export('anim1').set('logo3d', 'on');
model.result.export('anim1').set('options3d', 'off');
model.result.export('anim1').set('axisorientation', 'on');
model.result.export('anim1').set('grid', 'on');
model.result.export('anim1').set('axes1d', 'on');
model.result.export('anim1').set('axes2d', 'on');
model.result.export('anim1').set('showgrid', 'on');
model.result.export('anim1').showFrame;
model.result.export('anim1').label('Animation: Stress');
model.result.export('anim1').set('framesel', 'all');
model.result.export('anim1').set('frametime', 0.3);
model.result.export.duplicate('anim2', 'anim1');
model.result.export('anim2').showFrame;
model.result.export('anim2').label('Animation: Interface Health');
model.result.export('anim2').set('plotgroup', 'pg3');
model.result.export.duplicate('anim3', 'anim2');
model.result.export('anim3').showFrame;
model.result.export('anim3').label('Animation: Adhesive Stress');
model.result.export('anim3').set('plotgroup', 'pg5');
model.result('pg1').run;

model.title('Progressive Delamination in a Laminated Shell');

model.description(['Interfacial failure or delamination in a composite material is a common phenomenon. This can be simulated using Cohesive Zone Model (CZM).' newline  newline 'This example shows the implementation of a CZM with a bilinear traction-separation law in a layered shell. It is used to predict the mixed-mode softening onset and delamination propagation.']);

model.mesh.clearMeshes;

model.sol('sol1').clearSolutionData;

model.label('progressive_delamination_in_a_laminated_shell.mph');

model.modelNode.label('Components');

out = model;
