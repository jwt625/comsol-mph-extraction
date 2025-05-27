function out = model
%
% rim_submodel.m
%
% Model exported on May 26 2025, 21:34 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/Structural_Mechanics_Module/Tutorials');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 3);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.physics.create('solid', 'SolidMechanics', 'geom1');
model.physics('solid').model('comp1');

model.study.create('std1');
model.study('std1').create('stat', 'Stationary');
model.study('std1').feature('stat').setSolveFor('/physics/solid', true);

model.param.set('pInflation', '2[bar]');
model.param.descr('pInflation', 'Inflation pressure');
model.param.set('tireLoad', '1120[kg]*g_const');
model.param.descr('tireLoad', 'Load on wheel');
model.param.set('spokeNo', '0');
model.param.descr('spokeNo', 'Spoke selection');
model.param.set('spokeAngle', 'spokeNo*2*pi[rad]/5');
model.param.descr('spokeAngle', 'Rotation angle to selected spoke');
model.param.set('phiLoad', '0[deg]');
model.param.descr('phiLoad', 'Peak load angle');
model.param.set('numLpos', '4');
model.param.descr('numLpos', 'Number of load positions in first sector');
model.param.set('angleStep', '360[deg]/(5*numLpos)');
model.param.descr('angleStep', 'Step in peak load angle [deg]');
model.param.set('angleLast', 'angleStep*(numLpos-1)');
model.param.descr('angleLast', 'Last peak load angle [deg]');

model.geom('geom1').insertFile('wheel_rim_geom_sequence.mph', 'geom1');
model.geom('geom1').run('cmd1');

model.selection.create('sel1', 'Explicit');
model.selection('sel1').model('comp1');
model.selection('sel1').label('TireAttachment');
model.selection('sel1').geom(2);
model.selection('sel1').set([2 3 4 6]);
model.selection.create('sel2', 'Explicit');
model.selection('sel2').model('comp1');
model.selection('sel2').label('PressureSurface');
model.selection('sel2').geom(2);
model.selection('sel2').set([2 3 4 5 6]);
model.selection.create('sel3', 'Explicit');
model.selection('sel3').model('comp1');
model.selection('sel3').label('FixedToHub');
model.selection('sel3').geom(2);
model.selection('sel3').set([8 9 10 11 12]);

model.material.create('mat1', 'Common', 'comp1');
model.material('mat1').propertyGroup.create('Enu', 'Young''s modulus and Poisson''s ratio');
model.material('mat1').propertyGroup.create('Murnaghan', 'Murnaghan');
model.material('mat1').label('Aluminum');
model.material('mat1').set('family', 'aluminum');
model.material('mat1').propertyGroup('def').set('relpermeability', {'1' '0' '0' '0' '1' '0' '0' '0' '1'});
model.material('mat1').propertyGroup('def').set('heatcapacity', '900[J/(kg*K)]');
model.material('mat1').propertyGroup('def').set('thermalconductivity', {'238[W/(m*K)]' '0' '0' '0' '238[W/(m*K)]' '0' '0' '0' '238[W/(m*K)]'});
model.material('mat1').propertyGroup('def').set('electricconductivity', {'3.774e7[S/m]' '0' '0' '0' '3.774e7[S/m]' '0' '0' '0' '3.774e7[S/m]'});
model.material('mat1').propertyGroup('def').set('relpermittivity', {'1' '0' '0' '0' '1' '0' '0' '0' '1'});
model.material('mat1').propertyGroup('def').set('thermalexpansioncoefficient', {'23e-6[1/K]' '0' '0' '0' '23e-6[1/K]' '0' '0' '0' '23e-6[1/K]'});
model.material('mat1').propertyGroup('def').set('density', '2700[kg/m^3]');
model.material('mat1').propertyGroup('Enu').set('E', '70[GPa]');
model.material('mat1').propertyGroup('Enu').set('nu', '0.33');
model.material('mat1').propertyGroup('Murnaghan').set('l', '-250[GPa]');
model.material('mat1').propertyGroup('Murnaghan').set('m', '-330[GPa]');
model.material('mat1').propertyGroup('Murnaghan').set('n', '-350[GPa]');

model.physics('solid').create('fix1', 'Fixed', 2);
model.physics('solid').feature('fix1').selection.named('sel3');
model.physics('solid').create('bndl1', 'BoundaryLoad', 2);
model.physics('solid').feature('bndl1').selection.named('sel2');
model.physics('solid').feature('bndl1').set('LoadType', 'FollowerPressure');
model.physics('solid').feature('bndl1').set('FollowerPressure', 'pInflation');

model.func.create('an1', 'Analytic');
model.func('an1').model('comp1');
model.func('an1').set('expr', '(abs(atan2(x,y)-phi)<pi/6)*cos(3*(atan2(x,y)-phi))');
model.func('an1').set('args', 'x, y, phi');
model.func('an1').setIndex('argunit', 'm', 0);
model.func('an1').setIndex('argunit', 'm', 1);
model.func('an1').setIndex('argunit', 'rad', 2);
model.func('an1').set('fununit', 'Pa');
model.func('an1').set('funcname', 'loadDistr');

model.coordSystem.create('sys2', 'geom1', 'Cylindrical');

model.physics('solid').create('bndl2', 'BoundaryLoad', 2);
model.physics('solid').feature('bndl2').set('coordinateSystem', 'sys2');
model.physics('solid').feature('bndl2').selection.named('sel1');
model.physics('solid').feature('bndl2').set('FperArea', {'-loadAmpl*loadDistr(X,Y,phiLoad)' '0' '0.2*loadAmpl*loadDistr(X,Y,phiLoad)*(2*(Z>0)-1)'});

model.cpl.create('intop1', 'Integration', 'geom1');
model.cpl('intop1').set('axisym', true);
model.cpl('intop1').selection.geom('geom1', 2);
model.cpl('intop1').selection.named('sel1');

model.variable.create('var1');
model.variable('var1').model('comp1');
model.variable('var1').set('loadAmpl', 'tireLoad/intop1(loadDistr(X,Y,0)*cos(atan2(X,Y)))');
model.variable('var1').descr('loadAmpl', 'Load amplitude');

model.mesh('mesh1').automatic(false);
model.mesh('mesh1').feature('size').set('custom', true);
model.mesh('mesh1').feature('size').set('hmin', 0.006);
model.mesh('mesh1').run;

model.study('std1').feature('stat').set('useparam', true);
model.study('std1').feature('stat').setIndex('pname', 'pInflation', 0);
model.study('std1').feature('stat').setIndex('plistarr', '', 0);
model.study('std1').feature('stat').setIndex('punit', 'Pa', 0);
model.study('std1').feature('stat').setIndex('pname', 'pInflation', 0);
model.study('std1').feature('stat').setIndex('plistarr', '', 0);
model.study('std1').feature('stat').setIndex('punit', 'Pa', 0);
model.study('std1').feature('stat').setIndex('pname', 'phiLoad', 0);
model.study('std1').feature('stat').setIndex('plistarr', 'range(0,angleStep,angleLast)', 0);
model.study('std1').feature('stat').setIndex('punit', 'deg', 0);

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
model.sol('sol1').feature('s1').create('d1', 'Direct');
model.sol('sol1').feature('s1').feature('d1').set('linsolver', 'pardiso');
model.sol('sol1').feature('s1').feature('d1').set('pivotperturb', 1.0E-9);
model.sol('sol1').feature('s1').feature('d1').label('Suggested Direct Solver (solid)');
model.sol('sol1').feature('s1').create('i1', 'Iterative');
model.sol('sol1').feature('s1').feature('i1').set('linsolver', 'gmres');
model.sol('sol1').feature('s1').feature('i1').set('rhob', 400);
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
model.sol('sol1').feature('s1').feature('i1').active(true);
model.sol('sol1').runAll;

model.result.create('pg1', 'PlotGroup3D');
model.result('pg1').set('data', 'dset1');
model.result('pg1').setIndex('looplevel', 4, 0);
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
model.result('pg1').setIndex('looplevel', 1, 0);
model.result('pg1').run;
model.result('pg1').feature('vol1').set('unit', 'MPa');
model.result('pg1').feature('vol1').set('rangecoloractive', true);
model.result('pg1').feature('vol1').set('rangecolormax', 90);

model.view.create('view2', 'geom1');
model.view('view2').model('comp1');
model.view('view2').camera.setIndex('position', -0.00452, 0);
model.view('view2').camera.setIndex('position', 0.278495, 1);
model.view('view2').camera.setIndex('position', -4.05429, 2);
model.view('view2').camera.set('zoomanglefull', 7.90538);
model.view('view2').camera.setIndex('target', -2.6226E-4, 1);
model.view('view2').camera.setIndex('target', -0.005954, 2);
model.view('view2').camera.setIndex('up', '0.01210', 0);
model.view('view2').camera.setIndex('up', 0.99756, 1);
model.view('view2').camera.setIndex('up', 0.06866, 2);
model.view('view2').camera.setIndex('viewoffset', 0.03048, 0);
model.view('view2').camera.set('viewoffset', [0.03048 -0.41224]);
model.view('view2').camera.set('zoomanglefull', 7);
model.view('view2').set('locked', true);

model.result('pg1').run;
model.result('pg1').set('view', 'view2');
model.result('pg1').run;
model.result.create('pg2', 'PlotGroup3D');
model.result('pg2').set('data', 'dset1');
model.result('pg2').setIndex('looplevel', 4, 0);
model.result('pg2').set('defaultPlotID', 'boundaryLoads');
model.result('pg2').label('Boundary Loads (solid)');
model.result('pg2').set('showlegends', true);
model.result('pg2').set('titletype', 'label');
model.result('pg2').set('frametype', 'spatial');
model.result('pg2').set('showlegendsunit', true);
model.result('pg2').create('surf1', 'Surface');
model.result('pg2').feature('surf1').set('expr', {'1'});
model.result('pg2').feature('surf1').label('Gray Surfaces');
model.result('pg2').feature('surf1').set('coloring', 'uniform');
model.result('pg2').feature('surf1').set('color', 'gray');
model.result('pg2').feature('surf1').set('inheritcolor', false);
model.result('pg2').feature('surf1').set('inheritrange', false);
model.result('pg2').feature('surf1').set('inherittransparency', false);
model.result('pg2').feature('surf1').create('def', 'Deform');
model.result('pg2').feature('surf1').feature('def').set('expr', {'u' 'v' 'w'});
model.result('pg2').feature('surf1').feature('def').set('descr', 'Displacement field');
model.result('pg2').feature('surf1').feature('def').set('scaleactive', true);
model.result('pg2').feature('surf1').feature('def').set('scale', 0);
model.result('pg2').feature('surf1').create('sel1', 'Selection');
model.result('pg2').feature('surf1').feature('sel1').selection.geom('geom1', 2);
model.result('pg2').feature('surf1').feature('sel1').selection.set([1 2 3 4 5 6 7 8 9 10 11 12]);
model.result('pg2').feature('surf1').create('tran1', 'Transparency');
model.result('pg2').feature('surf1').feature('tran1').set('transparency', 0.8);
model.result('pg2').create('arws1', 'ArrowSurface');
model.result('pg2').feature('arws1').set('expr', {'solid.bndl1.F_Ax' 'solid.bndl1.F_Ay' 'solid.bndl1.F_Az'});
model.result('pg2').feature('arws1').set('placement', 'gausspoints');
model.result('pg2').feature('arws1').set('arrowbase', 'head');
model.result('pg2').feature('arws1').label('Boundary Load 1');
model.result('pg2').feature('arws1').set('inheritplot', 'none');
model.result('pg2').feature('arws1').create('col', 'Color');
model.result('pg2').feature('arws1').feature('col').set('colortable', 'Rainbow');
model.result('pg2').feature('arws1').feature('col').set('colortabletrans', 'none');
model.result('pg2').feature('arws1').feature('col').set('colorscalemode', 'linear');
model.result('pg2').feature('arws1').feature('col').set('colordata', 'arrowlength');
model.result('pg2').feature('arws1').feature('col').set('coloring', 'gradient');
model.result('pg2').feature('arws1').feature('col').set('topcolor', 'red');
model.result('pg2').feature('arws1').feature('col').set('bottomcolor', 'custom');
model.result('pg2').feature('arws1').feature('col').set('custombottomcolor', [0.5882353186607361 0.5137255191802979 0.5176470875740051]);
model.result('pg2').feature('arws1').set('color', 'red');
model.result('pg2').feature('arws1').create('def', 'Deform');
model.result('pg2').feature('arws1').feature('def').set('expr', {'u' 'v' 'w'});
model.result('pg2').feature('arws1').feature('def').set('descr', 'Displacement field');
model.result('pg2').feature('arws1').feature('def').set('scaleactive', true);
model.result('pg2').feature('arws1').feature('def').set('scale', 0);
model.result('pg2').feature.move('surf1', 1);
model.result('pg2').create('arws2', 'ArrowSurface');
model.result('pg2').feature('arws2').set('expr', {'solid.bndl2.F_Ax' 'solid.bndl2.F_Ay' 'solid.bndl2.F_Az'});
model.result('pg2').feature('arws2').set('placement', 'gausspoints');
model.result('pg2').feature('arws2').set('arrowbase', 'tail');
model.result('pg2').feature('arws2').label('Boundary Load 2');
model.result('pg2').feature('arws2').set('inheritplot', 'arws1');
model.result('pg2').feature('arws2').create('col', 'Color');
model.result('pg2').feature('arws2').feature('col').set('colortable', 'Rainbow');
model.result('pg2').feature('arws2').feature('col').set('colortabletrans', 'none');
model.result('pg2').feature('arws2').feature('col').set('colorscalemode', 'linear');
model.result('pg2').feature('arws2').feature('col').set('colordata', 'arrowlength');
model.result('pg2').feature('arws2').feature('col').set('coloring', 'gradient');
model.result('pg2').feature('arws2').feature('col').set('topcolor', 'red');
model.result('pg2').feature('arws2').feature('col').set('bottomcolor', 'custom');
model.result('pg2').feature('arws2').feature('col').set('custombottomcolor', [0.5882353186607361 0.5137255191802979 0.5176470875740051]);
model.result('pg2').feature('arws2').set('color', 'red');
model.result('pg2').feature('arws2').create('def', 'Deform');
model.result('pg2').feature('arws2').feature('def').set('expr', {'u' 'v' 'w'});
model.result('pg2').feature('arws2').feature('def').set('descr', 'Displacement field');
model.result('pg2').feature('arws2').feature('def').set('scaleactive', true);
model.result('pg2').feature('arws2').feature('def').set('scale', 0);
model.result('pg2').feature.move('surf1', 2);
model.result('pg2').label('Boundary Loads (solid)');
model.result('pg2').run;
model.result('pg2').run;
model.result('pg2').feature('arws1').set('scaleactive', true);
model.result('pg2').feature('arws1').set('scale', '4E-8');
model.result('pg2').run;

model.modelNode.create('comp2', true);

model.geom.create('geom2', 3);
model.geom('geom2').model('comp2');

model.mesh.create('mesh2', 'geom2');

model.geom('geom2').insertFile('wheel_rim_geom_sequence.mph', 'geom1');
model.geom('geom2').run('cmd1');
model.geom('geom2').feature('rot1').active(false);
model.geom('geom2').run('cmd1');
model.geom('geom2').run('rot1');
model.geom('geom2').create('blk1', 'Block');
model.geom('geom2').feature('blk1').set('size', {'6e-2' '7e-2' '6e-2'});
model.geom('geom2').feature('blk1').set('pos', {'0' '6.5e-2' '6e-2'});
model.geom('geom2').run('blk1');
model.geom('geom2').create('int1', 'Intersection');
model.geom('geom2').feature('int1').selection('input').set({'blk1' 'imp1'});
model.geom('geom2').run('cmd1');

model.material.create('mat2', 'Common', 'comp2');
model.material('mat2').propertyGroup.create('Enu', 'Young''s modulus and Poisson''s ratio');
model.material('mat2').propertyGroup.create('Murnaghan', 'Murnaghan');
model.material('mat2').label('Aluminum');
model.material('mat2').set('family', 'aluminum');
model.material('mat2').propertyGroup('def').set('relpermeability', {'1' '0' '0' '0' '1' '0' '0' '0' '1'});
model.material('mat2').propertyGroup('def').set('heatcapacity', '900[J/(kg*K)]');
model.material('mat2').propertyGroup('def').set('thermalconductivity', {'238[W/(m*K)]' '0' '0' '0' '238[W/(m*K)]' '0' '0' '0' '238[W/(m*K)]'});
model.material('mat2').propertyGroup('def').set('electricconductivity', {'3.774e7[S/m]' '0' '0' '0' '3.774e7[S/m]' '0' '0' '0' '3.774e7[S/m]'});
model.material('mat2').propertyGroup('def').set('relpermittivity', {'1' '0' '0' '0' '1' '0' '0' '0' '1'});
model.material('mat2').propertyGroup('def').set('thermalexpansioncoefficient', {'23e-6[1/K]' '0' '0' '0' '23e-6[1/K]' '0' '0' '0' '23e-6[1/K]'});
model.material('mat2').propertyGroup('def').set('density', '2700[kg/m^3]');
model.material('mat2').propertyGroup('Enu').set('E', '70[GPa]');
model.material('mat2').propertyGroup('Enu').set('nu', '0.33');
model.material('mat2').propertyGroup('Murnaghan').set('l', '-250[GPa]');
model.material('mat2').propertyGroup('Murnaghan').set('m', '-330[GPa]');
model.material('mat2').propertyGroup('Murnaghan').set('n', '-350[GPa]');

model.cpl.create('genext1', 'GeneralExtrusion', 'geom1');
model.cpl('genext1').set('opname', 'from_global');
model.cpl('genext1').selection.all;
model.cpl('genext1').set('srcframe', 'material');
model.cpl('genext1').set('dstmap', {'X*cos(spokeAngle)-Y*sin(spokeAngle)' 'y' 'z'});
model.cpl('genext1').setIndex('dstmap', 'Y*cos(spokeAngle)+X*sin(spokeAngle)', 1);
model.cpl('genext1').setIndex('dstmap', 'Z', 2);
model.cpl('genext1').set('exttol', 0.5);

model.physics.create('solid2', 'SolidMechanics', 'geom2');
model.physics('solid2').model('comp2');

model.study('std1').feature('stat').setSolveFor('/physics/solid2', true);

model.physics('solid2').create('fix1', 'Fixed', 2);
model.physics('solid2').feature('fix1').selection.set([3]);
model.physics('solid2').create('disp1', 'Displacement2', 2);
model.physics('solid2').feature('disp1').selection.set([1 6 7 8]);
model.physics('solid2').feature('disp1').setIndex('Direction', 'prescribed', 0);
model.physics('solid2').feature('disp1').setIndex('U0', 'comp1.from_global(comp1.u*cos(spokeAngle)+comp1.v*sin(spokeAngle))', 0);
model.physics('solid2').feature('disp1').setIndex('Direction', 'prescribed', 1);
model.physics('solid2').feature('disp1').setIndex('U0', 'comp1.from_global(comp1.v*cos(spokeAngle)-comp1.u*sin(spokeAngle))', 1);
model.physics('solid2').feature('disp1').setIndex('Direction', 'prescribed', 2);
model.physics('solid2').feature('disp1').setIndex('U0', 'comp1.from_global(comp1.w)', 2);

model.mesh('mesh2').autoMeshSize(3);
model.mesh('mesh2').automatic(false);
model.mesh('mesh2').feature('ftet1').create('size1', 'Size');
model.mesh('mesh2').feature('ftet1').feature('size1').selection.geom('geom2', 2);
model.mesh('mesh2').feature('ftet1').feature('size1').selection.set([5]);
model.mesh('mesh2').feature('ftet1').feature('size1').set('hauto', 1);
model.mesh('mesh2').run;

model.study.create('std2');
model.study('std2').create('stat', 'Stationary');
model.study('std2').feature('stat').setSolveFor('/physics/solid', false);
model.study('std2').feature('stat').setSolveFor('/physics/solid2', true);
model.study('std2').feature('stat').set('usesol', true);
model.study('std2').feature('stat').set('notsolmethod', 'sol');
model.study('std2').feature('stat').set('notstudy', 'std1');
model.study('std2').feature('stat').set('notsolnum', 'all');
model.study('std2').feature('stat').set('useparam', true);
model.study('std2').feature('stat').set('sweeptype', 'filled');
model.study('std2').feature('stat').setIndex('pname', 'pInflation', 0);
model.study('std2').feature('stat').setIndex('plistarr', '', 0);
model.study('std2').feature('stat').setIndex('punit', 'Pa', 0);
model.study('std2').feature('stat').setIndex('pname', 'pInflation', 0);
model.study('std2').feature('stat').setIndex('plistarr', '', 0);
model.study('std2').feature('stat').setIndex('punit', 'Pa', 0);
model.study('std2').feature('stat').setIndex('pname', 'spokeNo', 0);
model.study('std2').feature('stat').setIndex('pname', 'pInflation', 1);
model.study('std2').feature('stat').setIndex('plistarr', '', 1);
model.study('std2').feature('stat').setIndex('punit', 'Pa', 1);
model.study('std2').feature('stat').setIndex('pname', 'pInflation', 1);
model.study('std2').feature('stat').setIndex('plistarr', '', 1);
model.study('std2').feature('stat').setIndex('punit', 'Pa', 1);
model.study('std2').feature('stat').setIndex('plistarr', 'range(0,1,4)', 0);
model.study('std2').feature('stat').setIndex('pname', 'phiLoad', 1);
model.study('std2').feature('stat').setIndex('plistarr', 'range(0,angleStep,angleLast)', 1);
model.study('std2').feature('stat').setIndex('punit', 'deg', 1);
model.study('std2').feature('stat').setEntry('outputmap', 'solid', 'none');
model.study('std2').feature('stat').setEntry('outputmap', 'solid2', 'physics');

model.sol.create('sol2');
model.sol('sol2').study('std2');
model.sol('sol2').create('st1', 'StudyStep');
model.sol('sol2').feature('st1').set('study', 'std2');
model.sol('sol2').feature('st1').set('studystep', 'stat');
model.sol('sol2').create('v1', 'Variables');
model.sol('sol2').feature('v1').set('control', 'stat');
model.sol('sol2').create('s1', 'Stationary');
model.sol('sol2').feature('s1').create('p1', 'Parametric');
model.sol('sol2').feature('s1').feature.remove('pDef');
model.sol('sol2').feature('s1').feature('p1').set('control', 'stat');
model.sol('sol2').feature('s1').set('control', 'stat');
model.sol('sol2').feature('s1').feature('aDef').set('cachepattern', true);
model.sol('sol2').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol2').feature('s1').feature('fc1').set('termonres', 'auto');
model.sol('sol2').feature('s1').feature('fc1').set('reserrfact', 1000);
model.sol('sol2').feature('s1').create('d1', 'Direct');
model.sol('sol2').feature('s1').feature('d1').set('linsolver', 'pardiso');
model.sol('sol2').feature('s1').feature('d1').set('pivotperturb', 1.0E-9);
model.sol('sol2').feature('s1').feature('d1').label('Suggested Direct Solver (solid2)');
model.sol('sol2').feature('s1').create('i1', 'Iterative');
model.sol('sol2').feature('s1').feature('i1').set('linsolver', 'gmres');
model.sol('sol2').feature('s1').feature('i1').set('rhob', 400);
model.sol('sol2').feature('s1').feature('i1').set('nlinnormuse', true);
model.sol('sol2').feature('s1').feature('i1').label('Suggested Iterative Solver (solid2)');
model.sol('sol2').feature('s1').feature('i1').create('mg1', 'Multigrid');
model.sol('sol2').feature('s1').feature('i1').feature('mg1').set('prefun', 'gmg');
model.sol('sol2').feature('s1').feature('i1').feature('mg1').feature('pr').create('so1', 'SOR');
model.sol('sol2').feature('s1').feature('i1').feature('mg1').feature('pr').feature('so1').set('relax', 0.8);
model.sol('sol2').feature('s1').feature('i1').feature('mg1').feature('po').create('so1', 'SOR');
model.sol('sol2').feature('s1').feature('i1').feature('mg1').feature('po').feature('so1').set('relax', 0.8);
model.sol('sol2').feature('s1').feature('i1').feature('mg1').feature('cs').create('d1', 'Direct');
model.sol('sol2').feature('s1').feature('i1').feature('mg1').feature('cs').feature('d1').set('linsolver', 'pardiso');
model.sol('sol2').feature('s1').feature('i1').feature('mg1').feature('cs').feature('d1').set('pivotperturb', 1.0E-9);
model.sol('sol2').feature('s1').feature('fc1').set('linsolver', 'd1');
model.sol('sol2').feature('s1').feature('fc1').set('termonres', 'auto');
model.sol('sol2').feature('s1').feature('fc1').set('reserrfact', 1000);
model.sol('sol2').feature('s1').feature.remove('fcDef');
model.sol('sol2').attach('std2');
model.sol('sol2').feature('s1').feature('i1').active(true);
model.sol('sol2').feature('s1').feature('i1').feature('mg1').set('geomuse', {'geom2'});
model.sol('sol1').feature('s1').feature('i1').feature('mg1').set('geomuse', {'geom1'});
model.sol('sol2').runAll;

model.result.create('pg3', 'PlotGroup3D');
model.result('pg3').set('data', 'dset3');
model.result('pg3').setIndex('looplevel', 4, 0);
model.result('pg3').setIndex('looplevel', 5, 1);
model.result('pg3').set('defaultPlotID', 'stress');
model.result('pg3').label('Stress (solid2)');
model.result('pg3').set('frametype', 'spatial');
model.result('pg3').create('vol1', 'Volume');
model.result('pg3').feature('vol1').set('expr', {'solid2.misesGp'});
model.result('pg3').feature('vol1').set('threshold', 'manual');
model.result('pg3').feature('vol1').set('thresholdvalue', 0.2);
model.result('pg3').feature('vol1').set('colortable', 'Rainbow');
model.result('pg3').feature('vol1').set('colortabletrans', 'none');
model.result('pg3').feature('vol1').set('colorscalemode', 'linear');
model.result('pg3').feature('vol1').set('resolution', 'custom');
model.result('pg3').feature('vol1').set('refine', 2);
model.result('pg3').feature('vol1').set('colortable', 'Prism');
model.result('pg3').feature('vol1').create('def', 'Deform');
model.result('pg3').feature('vol1').feature('def').set('expr', {'u2' 'v2' 'w2'});
model.result('pg3').feature('vol1').feature('def').set('descr', 'Displacement field');
model.result('pg3').run;
model.result('pg3').run;
model.result('pg3').feature('vol1').set('unit', 'MPa');
model.result('pg3').feature('vol1').set('rangecoloractive', true);
model.result('pg3').feature('vol1').set('rangecolormax', 90);
model.result('pg3').feature('vol1').create('mrkr1', 'Marker');
model.result('pg3').run;
model.result('pg3').feature('vol1').feature('mrkr1').set('display', 'max');
model.result('pg3').feature('vol1').feature('mrkr1').set('precision', 3);
model.result('pg3').run;
model.result('pg3').setIndex('looplevel', 1, 1);
model.result('pg3').setIndex('looplevel', 2, 0);
model.result('pg3').create('pris1', 'PrincipalSurface');
model.result('pg3').feature('pris1').create('def1', 'Deform');
model.result('pg3').run;
model.result('pg3').run;
model.result('pg3').feature('pris1').set('inheritplot', 'vol1');
model.result('pg3').feature('pris1').set('inheritarrowscale', false);
model.result('pg3').feature('pris1').set('inheritcolor', false);
model.result('pg3').feature('pris1').set('inheritrange', false);
model.result('pg3').run;
model.result('pg3').label('Stress in Submodel');

model.view.create('view4', 'geom2');
model.view('view4').model('comp2');
model.view('view4').set('showgrid', false);
model.view('view4').camera.setIndex('position', -0.28705, 0);
model.view('view4').camera.setIndex('position', 0.39808, 1);
model.view('view4').camera.setIndex('position', -0.19568, 2);
model.view('view4').camera.set('zoomanglefull', 11.88656);
model.view('view4').camera.setIndex('target', 0.3206, 0);
model.view('view4').camera.setIndex('target', -0.17321, 1);
model.view('view4').camera.setIndex('target', 0.35603, 2);
model.view('view4').camera.setIndex('up', 0.4032, 0);
model.view('view4').camera.setIndex('up', 0.8204, 1);
model.view('view4').camera.setIndex('up', 0.40543, 2);
model.view('view4').camera.setIndex('viewoffset', -0.00907, 0);
model.view('view4').camera.set('viewoffset', [-0.00907 0.03017]);
model.view('view4').set('locked', true);

model.result('pg3').run;
model.result('pg3').set('view', 'view4');
model.result('pg3').run;
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
model.result.export('anim1').set('plotgroup', 'pg3');
model.result.export('anim1').set('solnumtype', 'inner');
model.result.export('anim1').set('solnum', [1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20]);
model.result.export('anim1').set('framesel', 'all');
model.result.export('anim1').run;

model.study('std1').feature('stat').setEntry('activate', 'solid2', false);

model.result('pg3').run;

model.title('Submodel in a Wheel Rim');

model.description('This tutorial uses the submodeling technique to accurately resolve the stress concentrations in a wheel rim. First a global model is solved to obtain the displacements, which are then used as boundary conditions in a local model of the region where the stress concentrations occur.');

model.mesh.clearMeshes;

model.sol('sol1').clearSolutionData;
model.sol('sol2').clearSolutionData;

model.label('rim_submodel.mph');

model.modelNode.label('Components');

out = model;
