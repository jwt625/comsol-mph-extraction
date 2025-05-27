function out = model
%
% inplane_and_space_truss.m
%
% Model exported on May 26 2025, 21:34 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/Structural_Mechanics_Module/Verification_Examples');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 2);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.physics.create('truss', 'Truss', 'geom1');
model.physics('truss').model('comp1');

model.study.create('std1');
model.study('std1').create('stat', 'Stationary');
model.study('std1').feature('stat').setSolveFor('/physics/truss', true);

model.geom('geom1').create('sq1', 'Square');
model.geom('geom1').feature('sq1').set('size', 2);
model.geom('geom1').feature('sq1').set('rot', 45);
model.geom('geom1').feature('sq1').set('type', 'curve');
model.geom('geom1').runPre('fin');
model.geom('geom1').create('ls1', 'LineSegment');
model.geom('geom1').feature('ls1').set('specify1', 'coord');
model.geom('geom1').feature('ls1').set('specify2', 'coord');
model.geom('geom1').feature('ls1').set('coord2', {'0' 'sqrt(8)'});
model.geom('geom1').runPre('fin');
model.geom('geom1').run;

model.physics('truss').feature('csd1').set('SectionType', 'CircularSection');
model.physics('truss').feature('csd1').set('do_circ', 0.05);
model.physics('truss').create('pin1', 'Pinned', 0);
model.physics('truss').feature('pin1').selection.set([1 4]);
model.physics('truss').create('pl1', 'PointLoad', 0);
model.physics('truss').feature('pl1').selection.set([2]);
model.physics('truss').feature('pl1').set('Fp', {'0' '-50e3' '0'});

model.material.create('mat1', 'Common', '');
model.material('mat1').propertyGroup('def').set('density', '');
model.material('mat1').propertyGroup.create('Enu', 'Young''s_modulus_and_Poisson''s_ratio');
model.material('mat1').propertyGroup('def').set('density', {'2900'});
model.material('mat1').propertyGroup('Enu').set('E', {'70e9'});
model.material('mat1').propertyGroup('Enu').set('nu', {'0.3'});
model.material.create('matlnk1', 'Link', 'comp1');

model.sol.create('sol1');
model.sol('sol1').study('std1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'stat');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').set('control', 'stat');
model.sol('sol1').create('s1', 'Stationary');
model.sol('sol1').feature('s1').feature('aDef').set('cachepattern', true);
model.sol('sol1').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('s1').feature('fc1').set('linsolver', 'dDef');
model.sol('sol1').feature('s1').feature.remove('fcDef');
model.sol('sol1').attach('std1');
model.sol('sol1').runAll;

model.result.create('pg1', 'PlotGroup2D');
model.result('pg1').set('data', 'dset1');
model.result('pg1').set('defaultPlotID', 'stress');
model.result('pg1').set('frametype', 'spatial');
model.result('pg1').create('line1', 'Line');
model.result('pg1').feature('line1').set('expr', {'truss.misesGp'});
model.result('pg1').feature('line1').set('threshold', 'manual');
model.result('pg1').feature('line1').set('thresholdvalue', 0.2);
model.result('pg1').feature('line1').set('colortable', 'Rainbow');
model.result('pg1').feature('line1').set('colortabletrans', 'none');
model.result('pg1').feature('line1').set('colorscalemode', 'linear');
model.result('pg1').label('Stress (truss)');
model.result('pg1').feature('line1').set('colortable', 'Rainbow');
model.result('pg1').feature('line1').set('linetype', 'tube');
model.result('pg1').feature('line1').set('radiusexpr', 'truss.re');
model.result('pg1').feature('line1').set('resolution', 'extrafine');
model.result('pg1').feature('line1').set('smooth', 'internal');
model.result('pg1').feature('line1').set('tuberadiusscaleactive', true);
model.result('pg1').feature('line1').set('tuberadiusscale', 1);
model.result('pg1').feature('line1').set('tubeendcaps', false);
model.result('pg1').feature('line1').create('def', 'Deform');
model.result('pg1').feature('line1').feature('def').set('expr', {'u' 'v'});
model.result('pg1').feature('line1').feature('def').set('descr', 'Displacement field');
model.result('pg1').run;
model.result.create('pg2', 'PlotGroup2D');
model.result('pg2').set('data', 'dset1');
model.result('pg2').set('defaultPlotID', 'axialForce');
model.result('pg2').set('frametype', 'spatial');
model.result('pg2').create('line1', 'Line');
model.result('pg2').feature('line1').set('expr', {'truss.Nxl'});
model.result('pg2').feature('line1').set('threshold', 'manual');
model.result('pg2').feature('line1').set('thresholdvalue', 0.2);
model.result('pg2').feature('line1').set('colortable', 'Wave');
model.result('pg2').feature('line1').set('colortabletrans', 'none');
model.result('pg2').feature('line1').set('colorscalemode', 'linearsymmetric');
model.result('pg2').feature('line1').set('linetype', 'tube');
model.result('pg2').feature('line1').set('radiusexpr', 'truss.re');
model.result('pg2').feature('line1').set('resolution', 'extrafine');
model.result('pg2').feature('line1').set('smooth', 'internal');
model.result('pg2').feature('line1').set('tuberadiusscaleactive', true);
model.result('pg2').feature('line1').set('tuberadiusscale', 1);
model.result('pg2').feature('line1').set('tubeendcaps', false);
model.result('pg2').feature('line1').create('def', 'Deform');
model.result('pg2').feature('line1').feature('def').set('expr', {'u' 'v'});
model.result('pg2').feature('line1').feature('def').set('descr', 'Displacement field');
model.result('pg2').label('Force (truss)');
model.result('pg2').label('Force (truss)');
model.result('pg2').run;
model.result('pg2').run;
model.result('pg2').set('showlegendsmaxmin', true);
model.result('pg2').run;
model.result('pg2').feature('line1').set('unit', 'kN');
model.result.evaluationGroup.create('eg1', 'EvaluationGroup');
model.result.evaluationGroup('eg1').label('Displacement of Vertices (2D)');
model.result.evaluationGroup('eg1').create('pev1', 'EvalPoint');
model.result.evaluationGroup('eg1').feature('pev1').selection.set([2 3]);
model.result.evaluationGroup('eg1').feature('pev1').setIndex('expr', 'v', 0);
model.result.evaluationGroup('eg1').feature('pev1').setIndex('unit', 'm', 0);
model.result.evaluationGroup('eg1').feature('pev1').setIndex('descr', 'Displacement field, Y component', 0);
model.result.evaluationGroup('eg1').run;

model.cpl.create('aveop1', 'Average', 'geom1');
model.cpl('aveop1').set('axisym', true);
model.cpl('aveop1').set('opname', 'aveop_ac');
model.cpl('aveop1').selection.geom('geom1', 1);
model.cpl('aveop1').selection.set([5]);
model.cpl.create('aveop2', 'Average', 'geom1');
model.cpl('aveop2').set('axisym', true);
model.cpl('aveop2').set('opname', 'aveop_ad');
model.cpl('aveop2').selection.geom('geom1', 1);
model.cpl('aveop2').selection.set([4]);
model.cpl.create('aveop3', 'Average', 'geom1');
model.cpl('aveop3').set('axisym', true);
model.cpl('aveop3').set('opname', 'aveop_cd');
model.cpl('aveop3').selection.geom('geom1', 1);
model.cpl('aveop3').selection.set([3]);

model.variable.create('var1');
model.variable('var1').model('comp1');
model.variable('var1').set('F_ac', 'aveop_ac(truss.Nxl)');
model.variable('var1').descr('F_ac', 'Axial force, member ac');
model.variable('var1').set('F_ad', 'aveop_ad(truss.Nxl)');
model.variable('var1').descr('F_ad', 'Axial force, member ad');
model.variable('var1').set('F_cd', 'aveop_cd(truss.Nxl)');
model.variable('var1').descr('F_cd', 'Axial force, member cd');

model.sol('sol1').updateSolution;

model.result('pg1').run;
model.result.evaluationGroup.create('eg2', 'EvaluationGroup');
model.result.evaluationGroup('eg2').label('Axial Force in Members (2D)');
model.result.evaluationGroup('eg2').create('gev1', 'EvalGlobal');
model.result.evaluationGroup('eg2').feature('gev1').setIndex('expr', 'F_ac', 0);
model.result.evaluationGroup('eg2').feature('gev1').setIndex('unit', 'N', 0);
model.result.evaluationGroup('eg2').feature('gev1').setIndex('descr', 'Axial force, member ac', 0);
model.result.evaluationGroup('eg2').feature('gev1').setIndex('expr', 'F_ad', 1);
model.result.evaluationGroup('eg2').feature('gev1').setIndex('unit', 'N', 1);
model.result.evaluationGroup('eg2').feature('gev1').setIndex('descr', 'Axial force, member ad', 1);
model.result.evaluationGroup('eg2').feature('gev1').setIndex('expr', 'F_cd', 2);
model.result.evaluationGroup('eg2').feature('gev1').setIndex('unit', 'N', 2);
model.result.evaluationGroup('eg2').feature('gev1').setIndex('descr', 'Axial force, member cd', 2);
model.result.evaluationGroup('eg2').run;

model.modelNode.create('comp2', true);

model.geom.create('geom2', 3);
model.geom('geom2').model('comp2');

model.mesh.create('mesh2', 'geom2');

model.physics.create('truss2', 'Truss', 'geom2');
model.physics('truss2').model('comp2');

model.study('std1').feature('stat').setSolveFor('/physics/truss2', false);

model.geom('geom2').run;

model.study.create('std2');
model.study('std2').create('stat', 'Stationary');
model.study('std2').feature('stat').setSolveFor('/physics/truss', false);
model.study('std2').feature('stat').setSolveFor('/physics/truss2', true);

model.geom('geom2').create('wp1', 'WorkPlane');
model.geom('geom2').feature('wp1').set('unite', true);
model.geom('geom2').feature('wp1').geom.create('sq1', 'Square');
model.geom('geom2').feature('wp1').geom.feature('sq1').set('size', 2);
model.geom('geom2').feature('wp1').geom.feature('sq1').set('rot', 45);
model.geom('geom2').feature('wp1').geom.feature('sq1').set('type', 'curve');
model.geom('geom2').feature('wp1').geom.run('sq1');
model.geom('geom2').run('wp1');
model.geom('geom2').create('rot1', 'Rotate');
model.geom('geom2').feature('rot1').set('keep', true);
model.geom('geom2').feature('rot1').selection('input').set({'wp1'});
model.geom('geom2').feature('rot1').set('axistype', 'cartesian');
model.geom('geom2').feature('rot1').set('ax3', [0 1 0]);
model.geom('geom2').feature('rot1').set('rot', 90);
model.geom('geom2').runPre('fin');
model.geom('geom2').create('ls1', 'LineSegment');
model.geom('geom2').feature('ls1').set('specify1', 'coord');
model.geom('geom2').feature('ls1').set('specify2', 'coord');
model.geom('geom2').feature('ls1').set('coord2', {'0' 'sqrt(8)' '0'});
model.geom('geom2').runPre('fin');

model.cpl.create('aveop4', 'Average', 'geom2');

model.geom('geom2').run;

model.cpl('aveop4').set('axisym', true);
model.cpl('aveop4').set('opname', 'aveop_ac');
model.cpl('aveop4').selection.geom('geom2', 1);
model.cpl('aveop4').selection.set([8]);
model.cpl.create('aveop5', 'Average', 'geom2');
model.cpl('aveop5').set('axisym', true);
model.cpl('aveop5').set('opname', 'aveop_ad');
model.cpl('aveop5').selection.geom('geom2', 1);
model.cpl('aveop5').selection.set([4]);
model.cpl.create('aveop6', 'Average', 'geom2');
model.cpl('aveop6').set('axisym', true);
model.cpl('aveop6').set('opname', 'aveop_cd');
model.cpl('aveop6').selection.geom('geom2', 1);
model.cpl('aveop6').selection.set([5]);

model.variable.create('var2');
model.variable('var2').model('comp2');
model.variable('var2').set('F_ac', 'aveop_ac(truss2.Nxl)', 'Axial force, member ac');
model.variable('var2').descr('F_ac', 'Axial force, member ac');
model.variable('var2').set('F_ad', 'aveop_ad(truss2.Nxl)', 'Axial force, member ad');
model.variable('var2').descr('F_ad', 'Axial force, member ad');
model.variable('var2').set('F_cd', 'aveop_cd(truss2.Nxl)', 'Axial force, member cd');
model.variable('var2').descr('F_cd', 'Axial force, member cd');

model.physics('truss2').feature('csd1').set('area', 'pi/4*0.05^2');
model.physics('truss2').create('csd2', 'CrossSectionTruss', 1);
model.physics('truss2').feature('csd2').selection.set([5]);
model.physics('truss2').feature('csd2').set('area', '2*pi/4*0.05^2');
model.physics('truss2').create('pin1', 'Pinned', 0);
model.physics('truss2').feature('pin1').selection.set([1 3 4 6]);
model.physics('truss2').create('pl1', 'PointLoad', 0);
model.physics('truss2').feature('pl1').selection.set([2]);
model.physics('truss2').feature('pl1').set('Fp', {'0' '-100e3' '0'});

model.material.create('matlnk2', 'Link', 'comp2');

model.sol.create('sol2');
model.sol('sol2').study('std2');
model.sol('sol2').create('st1', 'StudyStep');
model.sol('sol2').feature('st1').set('study', 'std2');
model.sol('sol2').feature('st1').set('studystep', 'stat');
model.sol('sol2').create('v1', 'Variables');
model.sol('sol2').feature('v1').set('control', 'stat');
model.sol('sol2').create('s1', 'Stationary');
model.sol('sol2').feature('s1').feature('aDef').set('cachepattern', true);
model.sol('sol2').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol2').feature('s1').feature('fc1').set('linsolver', 'dDef');
model.sol('sol2').feature('s1').feature.remove('fcDef');
model.sol('sol2').attach('std2');
model.sol('sol2').runAll;

model.result.create('pg3', 'PlotGroup3D');
model.result('pg3').set('data', 'dset3');
model.result('pg3').set('defaultPlotID', 'stress');
model.result('pg3').set('frametype', 'spatial');
model.result('pg3').create('line1', 'Line');
model.result('pg3').feature('line1').set('expr', {'truss2.misesGp'});
model.result('pg3').feature('line1').set('threshold', 'manual');
model.result('pg3').feature('line1').set('thresholdvalue', 0.2);
model.result('pg3').feature('line1').set('colortable', 'Rainbow');
model.result('pg3').feature('line1').set('colortabletrans', 'none');
model.result('pg3').feature('line1').set('colorscalemode', 'linear');
model.result('pg3').label('Stress (truss2)');
model.result('pg3').feature('line1').set('colortable', 'Rainbow');
model.result('pg3').feature('line1').set('linetype', 'tube');
model.result('pg3').feature('line1').set('radiusexpr', 'truss2.re');
model.result('pg3').feature('line1').set('resolution', 'extrafine');
model.result('pg3').feature('line1').set('smooth', 'internal');
model.result('pg3').feature('line1').set('tuberadiusscaleactive', true);
model.result('pg3').feature('line1').set('tuberadiusscale', 1);
model.result('pg3').feature('line1').set('tubeendcaps', false);
model.result('pg3').feature('line1').create('def', 'Deform');
model.result('pg3').feature('line1').feature('def').set('expr', {'u2' 'v2' 'w2'});
model.result('pg3').feature('line1').feature('def').set('descr', 'Displacement field');
model.result('pg3').run;
model.result.create('pg4', 'PlotGroup3D');
model.result('pg4').set('data', 'dset3');
model.result('pg4').set('defaultPlotID', 'axialForce');
model.result('pg4').set('frametype', 'spatial');
model.result('pg4').create('line1', 'Line');
model.result('pg4').feature('line1').set('expr', {'truss2.Nxl'});
model.result('pg4').feature('line1').set('threshold', 'manual');
model.result('pg4').feature('line1').set('thresholdvalue', 0.2);
model.result('pg4').feature('line1').set('colortable', 'Wave');
model.result('pg4').feature('line1').set('colortabletrans', 'none');
model.result('pg4').feature('line1').set('colorscalemode', 'linearsymmetric');
model.result('pg4').feature('line1').set('linetype', 'tube');
model.result('pg4').feature('line1').set('radiusexpr', 'truss2.re');
model.result('pg4').feature('line1').set('resolution', 'extrafine');
model.result('pg4').feature('line1').set('smooth', 'internal');
model.result('pg4').feature('line1').set('tuberadiusscaleactive', true);
model.result('pg4').feature('line1').set('tuberadiusscale', 1);
model.result('pg4').feature('line1').set('tubeendcaps', false);
model.result('pg4').feature('line1').create('def', 'Deform');
model.result('pg4').feature('line1').feature('def').set('expr', {'u2' 'v2' 'w2'});
model.result('pg4').feature('line1').feature('def').set('descr', 'Displacement field');
model.result('pg4').label('Force (truss2)');
model.result('pg4').label('Force (truss2)');
model.result('pg4').run;

model.view('view2').camera.setIndex('position', -13.687, 0);
model.view('view2').camera.setIndex('position', -16.98, 1);
model.view('view2').camera.setIndex('position', 13.687, 2);
model.view('view2').camera.set('zoomanglefull', 8.6796);
model.view('view2').camera.setIndex('target', -13.173, 0);
model.view('view2').camera.set('target', [-13.173 -16.292 0]);
model.view('view2').camera.setIndex('target', 13.173, 2);
model.view('view2').camera.setIndex('up', 0.3081, 0);
model.view('view2').camera.setIndex('up', 0.4108, 1);
model.view('view2').camera.setIndex('up', 0.8581, 2);
model.view('view2').camera.set('rotationpoint', [0 1.2727 0]);
model.view('view2').camera.setIndex('viewoffset', 0.01639, 0);
model.view('view2').camera.set('viewoffset', [0.01639 -0.04243]);

model.result('pg4').run;
model.result('pg4').set('showlegendsmaxmin', true);
model.result('pg4').run;
model.result('pg4').feature('line1').set('unit', 'kN');
model.result.evaluationGroup.duplicate('eg3', 'eg1');
model.result.evaluationGroup('eg3').label('Displacement of Vertices (3D)');
model.result.evaluationGroup('eg3').set('data', 'dset3');
model.result.evaluationGroup('eg3').feature('pev1').selection.set([2 5]);
model.result.evaluationGroup('eg3').feature('pev1').setIndex('expr', 'v2', 0);
model.result.evaluationGroup('eg3').feature('pev1').setIndex('unit', 'm', 0);
model.result.evaluationGroup('eg3').feature('pev1').setIndex('descr', 'Displacement field, Y component', 0);
model.result.evaluationGroup('eg3').run;
model.result.evaluationGroup.duplicate('eg4', 'eg2');
model.result.evaluationGroup('eg4').label('Axial Force in Members (3D)');
model.result.evaluationGroup('eg4').set('data', 'dset3');
model.result.evaluationGroup('eg4').feature('gev1').setIndex('expr', 'F_cd/2', 2);
model.result.evaluationGroup('eg4').run;
model.result('pg2').run;

model.title('In-Plane and Space Truss');

model.description('Linear static analysis of a simple 2D truss. The pin-jointed truss is modeled using the Truss interface. The solution is compared with analytical results.');

model.label('inplane_and_space_truss.mph');

model.modelNode.label('Components');

out = model;
