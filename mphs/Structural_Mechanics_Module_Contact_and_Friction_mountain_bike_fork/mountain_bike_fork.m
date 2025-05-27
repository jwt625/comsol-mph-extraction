function out = model
%
% mountain_bike_fork.m
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

model.geom('geom1').create('imp1', 'Import');
model.geom('geom1').feature('imp1').set('type', 'native');
model.geom('geom1').feature('imp1').set('filename', 'mountain_bike_fork.mphbin');
model.geom('geom1').feature('imp1').importData;
model.geom('geom1').feature('fin').set('action', 'assembly');
model.geom('geom1').feature('fin').set('frame', 'material');
model.geom('geom1').run('fin');

model.pair('ap2').manualSelection(true);
model.pair('ap2').type('Contact');
model.pair('ap2').mapping('initial');
model.pair('ap3').swap;

model.param.set('n', '0');
model.param.descr('n', 'Interference fit multiplier');
model.param.set('mu', '0.2');
model.param.descr('mu', 'Friction coefficient');

model.material.create('mat1', 'Common', 'comp1');
model.material('mat1').label('Steel');
model.material('mat1').propertyGroup.create('Enu', 'Young''s_modulus_and_Poisson''s_ratio');
model.material('mat1').propertyGroup('Enu').set('E', {'210e9'});
model.material('mat1').propertyGroup('Enu').set('nu', {'0.29'});
model.material('mat1').propertyGroup('def').set('density', {'7800'});

model.physics('solid').feature('dcnt1').set('destination_offset', '(0.04 [mm])*n');
model.physics('solid').feature('dcnt1').set('zeroInitGap', true);
model.physics('solid').feature('dcnt1').create('fric1', 'Friction', 2);
model.physics('solid').feature('dcnt1').feature('fric1').set('mu_fric', 'mu');
model.physics('solid').feature('dcnt1').create('stb1', 'ContactStabilization', 2);
model.physics('solid').create('fix1', 'Fixed', 2);
model.physics('solid').feature('fix1').selection.set([191]);
model.physics('solid').create('sym1', 'SymmetrySolid', 2);
model.physics('solid').feature('sym1').selection.set([1 10 13 18 163 168 171 176 179 183 185 187 189 196 198 200 202 204]);

model.mesh('mesh1').create('map1', 'Map');
model.mesh('mesh1').feature('map1').selection.set([166]);
model.mesh('mesh1').feature('map1').create('dis1', 'Distribution');
model.mesh('mesh1').feature('map1').feature('dis1').selection.set([367 370 375 378]);
model.mesh('mesh1').feature('map1').feature('dis1').set('numelem', 15);
model.mesh('mesh1').feature('map1').create('dis2', 'Distribution');
model.mesh('mesh1').feature('map1').feature('dis2').selection.set([366]);
model.mesh('mesh1').feature('map1').feature('dis2').set('type', 'predefined');
model.mesh('mesh1').feature('map1').feature('dis2').set('elemcount', 6);
model.mesh('mesh1').feature('map1').feature('dis2').set('elemratio', 2);
model.mesh('mesh1').feature('map1').feature('dis2').set('reverse', true);
model.mesh('mesh1').feature('map1').feature.duplicate('dis3', 'dis2');
model.mesh('mesh1').feature('map1').feature('dis3').selection.set([374]);
model.mesh('mesh1').create('swe1', 'Sweep');
model.mesh('mesh1').feature('swe1').selection.geom('geom1', 3);
model.mesh('mesh1').feature('swe1').selection.set([2]);
model.mesh('mesh1').feature('swe1').selection('sourceface').set([166]);
model.mesh('mesh1').feature('swe1').selection('targetface').set([165]);
model.mesh('mesh1').feature('swe1').create('dis1', 'Distribution');
model.mesh('mesh1').feature('swe1').feature('dis1').set('numelem', 10);
model.mesh('mesh1').create('map2', 'Map');
model.mesh('mesh1').feature('map2').selection.set([174]);
model.mesh('mesh1').feature('map2').create('dis1', 'Distribution');
model.mesh('mesh1').feature('map2').feature('dis1').selection.set([385 388 393 396]);
model.mesh('mesh1').feature('map2').feature('dis1').set('numelem', 20);
model.mesh('mesh1').feature('map2').create('dis2', 'Distribution');
model.mesh('mesh1').feature('map2').feature('dis2').selection.set([384]);
model.mesh('mesh1').feature('map2').feature('dis2').set('type', 'predefined');
model.mesh('mesh1').feature('map2').feature('dis2').set('elemcount', 6);
model.mesh('mesh1').feature('map2').feature('dis2').set('elemratio', 2);
model.mesh('mesh1').feature('map2').feature.duplicate('dis3', 'dis2');
model.mesh('mesh1').feature('map2').feature('dis3').selection.set([392]);
model.mesh('mesh1').feature('map2').feature('dis3').set('reverse', true);
model.mesh('mesh1').create('swe2', 'Sweep');
model.mesh('mesh1').feature('swe2').selection.geom('geom1', 3);
model.mesh('mesh1').feature('swe2').selection.set([3]);
model.mesh('mesh1').feature('swe2').create('dis1', 'Distribution');
model.mesh('mesh1').feature('swe2').feature('dis1').set('numelem', 15);
model.mesh('mesh1').create('ftet1', 'FreeTet');
model.mesh('mesh1').feature('ftet1').selection.geom('geom1', 3);
model.mesh('mesh1').feature('ftet1').selection.set([4]);
model.mesh('mesh1').feature('ftet1').create('size1', 'Size');
model.mesh('mesh1').feature('ftet1').feature('size1').set('hauto', 4);
model.mesh('mesh1').create('ftet2', 'FreeTet');
model.mesh('mesh1').feature('ftet2').selection.geom('geom1', 3);
model.mesh('mesh1').feature('ftet2').selection.set([1]);
model.mesh('mesh1').feature('ftet2').create('dis1', 'Distribution');
model.mesh('mesh1').feature('ftet2').feature('dis1').selection.set([27 28 31 33]);
model.mesh('mesh1').feature('ftet2').feature('dis1').set('numelem', 10);
model.mesh('mesh1').feature('ftet2').create('size1', 'Size');
model.mesh('mesh1').feature('ftet2').create('size2', 'Size');
model.mesh('mesh1').feature('ftet2').feature('size2').selection.geom('geom1', 2);
model.mesh('mesh1').feature('ftet2').feature('size2').selection.set([109 110]);
model.mesh('mesh1').feature('ftet2').feature('size2').set('hauto', 3);
model.mesh('mesh1').feature('ftet2').feature('size1').set('custom', true);
model.mesh('mesh1').feature('ftet2').feature('size1').set('hminactive', true);
model.mesh('mesh1').feature('ftet2').feature('size1').set('hmin', 0.011);
model.mesh('mesh1').run;

model.study('std1').feature('stat').set('useparam', true);
model.study('std1').feature('stat').setIndex('pname', 'n', 0);
model.study('std1').feature('stat').setIndex('plistarr', '', 0);
model.study('std1').feature('stat').setIndex('punit', '', 0);
model.study('std1').feature('stat').setIndex('pname', 'n', 0);
model.study('std1').feature('stat').setIndex('plistarr', '', 0);
model.study('std1').feature('stat').setIndex('punit', '', 0);
model.study('std1').feature('stat').setIndex('plistarr', '0.1, range(0.25, 0.25, 1.0)', 0);

model.sol.create('sol1');
model.sol('sol1').study('std1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'stat');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').feature('comp1_u').set('scalemethod', 'manual');
model.sol('sol1').feature('v1').feature('comp1_u').set('scaleval', '1e-2*0.6784150059545734');
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
model.sol('sol1').feature('s1').feature('fc1').set('dtech', 'auto');
model.sol('sol1').runAll;

model.result.create('pg1', 'PlotGroup3D');
model.result('pg1').set('data', 'dset1');
model.result('pg1').setIndex('looplevel', 5, 0);
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
model.result.dataset.create('mir1', 'Mirror3D');
model.result('pg1').run;
model.result('pg1').set('data', 'mir1');
model.result('pg1').run;
model.result('pg1').feature('vol1').set('unit', 'MPa');
model.result('pg1').run;

model.view('view2').camera.set('zoomanglefull', 2.6893131732940674);
model.view('view2').camera.setIndex('position', '-2.4827682971954344', 0);
model.view('view2').camera.setIndex('position', -2.1152172088623042, 1);
model.view('view2').camera.setIndex('position', 1.6560308933258054, 2);
model.view('view2').camera.setIndex('target', -7.152557373046874E-7, 0);
model.view('view2').camera.setIndex('target', '-0.017309904098510743', 1);
model.view('view2').camera.setIndex('target', -0.03700125217437743, 2);
model.view('view2').camera.setIndex('up', '0.28832176327705382', 0);
model.view('view2').camera.setIndex('up', '0.37112340331077575', 1);
model.view('view2').camera.setIndex('up', 0.8826876282691954, 2);
model.view('view2').camera.setIndex('rotationpoint', -3.725290298461913E-8, 0);
model.view('view2').camera.setIndex('rotationpoint', -0.01730947569012641, 1);
model.view('view2').camera.setIndex('rotationpoint', -0.03700000047683713, 2);
model.view('view2').camera.setIndex('viewoffset', '0.022066066041588782', 0);
model.view('view2').camera.setIndex('viewoffset', -0.5200638175010683, 1);
model.view('view2').set('locked', true);

model.result('pg1').run;
model.result.create('pg2', 'PlotGroup3D');
model.result('pg2').run;
model.result('pg2').label('Equivalent Stress, Isosurface');
model.result('pg2').set('data', 'mir1');
model.result('pg2').create('iso1', 'Isosurface');
model.result('pg2').feature('iso1').set('expr', 'solid.misesGp');
model.result('pg2').feature('iso1').set('descr', 'von Mises stress');
model.result('pg2').feature('iso1').set('unit', 'MPa');
model.result('pg2').feature('iso1').set('levelmethod', 'levels');
model.result('pg2').feature('iso1').set('levels', 'range(100,50,400)');
model.result.create('pg3', 'PlotGroup3D');
model.result('pg3').run;
model.result('pg3').label('First Principal Stress (yz-Plane)');
model.result('pg3').set('data', 'mir1');
model.result('pg3').create('slc1', 'Slice');
model.result('pg3').feature('slc1').set('expr', 'solid.sp1Gp');
model.result('pg3').feature('slc1').set('descr', 'First principal stress');
model.result('pg3').feature('slc1').set('unit', 'MPa');
model.result('pg3').feature('slc1').set('quickxmethod', 'coord');
model.result('pg3').feature('slc1').set('quickx', 'range(-0.03,0.01,0.03)');
model.result('pg3').run;
model.result('pg3').run;
model.result.duplicate('pg4', 'pg3');
model.result('pg4').run;
model.result('pg4').label('First Principal Stress (zx-Plane)');
model.result('pg4').run;
model.result('pg4').feature('slc1').set('quickx', 'range(-0.0215,0.01,0.0385)');
model.result('pg4').feature('slc1').set('quickplane', 'zx');
model.result('pg4').run;
model.result('pg4').feature('slc1').set('quickymethod', 'coord');
model.result('pg4').feature('slc1').set('quicky', 'range(-0.0215,0.01,0.0385)');
model.result('pg3').run;
model.result.duplicate('pg5', 'pg3');
model.result('pg5').run;
model.result('pg5').label('Third Principal Stress (yz-Plane)');
model.result('pg5').run;
model.result('pg5').feature('slc1').set('expr', 'solid.sp3Gp');
model.result('pg5').feature('slc1').set('descr', 'Third principal stress');
model.result('pg4').run;
model.result.duplicate('pg6', 'pg4');
model.result('pg6').run;
model.result('pg6').label('Third Principal Stress (zx-Plane)');
model.result('pg6').run;
model.result('pg6').feature('slc1').set('expr', 'solid.sp3Gp');
model.result('pg6').feature('slc1').set('descr', 'Third principal stress');
model.result.create('pg7', 'PlotGroup3D');
model.result('pg7').run;
model.result('pg7').label('Contact Pressure');
model.result('pg7').set('data', 'mir1');
model.result('pg7').create('surf1', 'Surface');
model.result('pg7').feature('surf1').set('expr', 'solid.Tn');
model.result('pg7').feature('surf1').set('descr', 'Contact pressure');
model.result('pg7').feature('surf1').set('unit', 'MPa');

model.view('view2').set('locked', false);

model.result.numerical.create('int1', 'IntSurface');
model.result.numerical('int1').set('intvolume', true);
model.result.numerical('int1').label('Transferable Loads');
model.result.numerical('int1').selection.set([172 178]);
model.result.numerical('int1').setIndex('looplevelinput', 'last', 0);
model.result.numerical('int1').setIndex('expr', '2*sqrt(x^2+(y-0.0085)^2)*mu*solid.Tn', 0);
model.result.numerical('int1').setIndex('unit', 'N*m', 0);
model.result.numerical('int1').setIndex('descr', 'Transferable torque', 0);
model.result.numerical('int1').setIndex('expr', '2*mu*solid.Tn', 1);
model.result.numerical('int1').setIndex('unit', 'N', 1);
model.result.numerical('int1').setIndex('descr', 'Transferable force', 1);
model.result.table.create('tbl1', 'Table');
model.result.table('tbl1').comments('Transferable Loads');
model.result.numerical('int1').set('table', 'tbl1');
model.result.numerical('int1').setResult;
model.result('pg1').run;
model.result('pg2').run;
model.result('pg3').run;
model.result('pg4').run;
model.result('pg5').run;
model.result('pg6').run;
model.result('pg7').run;
model.result('pg2').run;

model.title('Interference Fit Connection in a Mountain Bike Fork');

model.description(['Interference fit is a technique used to join or fit one part over or around another part. The internal part is cooled, so that it shrinks, and is then fitted. Once the part heats up again and expands, a contact pressure builds up at the interface between the two parts.' newline  newline 'This type of connection is simulated in a tutorial example of a mountain bike fork where the steering pipe is connected to the crown. The simulation investigates the contact pressure and stress distribution as well as the transferable force and torque.']);

model.mesh.clearMeshes;

model.sol('sol1').clearSolutionData;

model.label('mountain_bike_fork.mph');

model.modelNode.label('Components');

out = model;
