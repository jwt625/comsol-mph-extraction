function out = model
%
% uniaxial_loading_of_shape_memory_alloy.m
%
% Model exported on May 26 2025, 21:31 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/Nonlinear_Structural_Materials_Module/Shape_Memory_Alloys');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 2);
model.geom('geom1').model('comp1');
model.geom('geom1').axisymmetric(true);

model.mesh.create('mesh1', 'geom1');

model.physics.create('solid', 'SolidMechanics', 'geom1');
model.physics('solid').model('comp1');

model.study.create('std1');
model.study('std1').create('stat', 'Stationary');
model.study('std1').feature('stat').setSolveFor('/physics/solid', true);

model.param.set('T', '298[K]');
model.param.descr('T', 'Applied temperature');
model.param.set('para', '0');
model.param.descr('para', 'Continuation parameter');

model.geom('geom1').lengthUnit('cm');
model.geom('geom1').create('r1', 'Rectangle');
model.geom('geom1').feature('r1').set('size', [6 20]);
model.geom('geom1').run;

model.physics('solid').create('sma1', 'ShapeMemoryAlloy', 2);
model.physics('solid').feature('sma1').selection.all;
model.physics('solid').feature('sma1').set('minput_temperature_src', 'userdef');
model.physics('solid').feature('sma1').set('minput_temperature', 'T');
model.physics('solid').create('roll1', 'Roller', 1);
model.physics('solid').feature('roll1').selection.set([2]);

model.func.create('int1', 'Interpolation');
model.func('int1').model('comp1');
model.func('int1').setIndex('table', 0, 0, 0);
model.func('int1').setIndex('table', 0, 0, 1);
model.func('int1').setIndex('table', 1, 1, 0);
model.func('int1').setIndex('table', 1, 1, 1);
model.func('int1').setIndex('table', 2, 2, 0);
model.func('int1').setIndex('table', 0, 2, 1);

model.physics('solid').create('bndl1', 'BoundaryLoad', 1);
model.physics('solid').feature('bndl1').selection.set([3]);
model.physics('solid').feature('bndl1').set('FperArea', {'0' '0' '850[MPa]*int1(para)'});

model.material.create('mat1', 'Common', 'comp1');
model.material('mat1').propertyGroup.create('LagoudasModel', 'Lagoudas_model');
model.material('mat1').propertyGroup('LagoudasModel').set('T0', {'318'});
model.material('mat1').propertyGroup('def').set('poissonsratio', {'0.33'});
model.material('mat1').propertyGroup.create('ShapeMemoryAlloyAustenite', 'Austenite_phase');
model.material('mat1').propertyGroup('ShapeMemoryAlloyAustenite').set('E_A', {'55[GPa]'});
model.material('mat1').propertyGroup('ShapeMemoryAlloyAustenite').set('Cp_A', {'400'});
model.material('mat1').propertyGroup.create('ShapeMemoryAlloyMartensite', 'Martensite_phase');
model.material('mat1').propertyGroup('ShapeMemoryAlloyMartensite').set('E_M', {'46[GPa]'});
model.material('mat1').propertyGroup('ShapeMemoryAlloyMartensite').set('Cp_M', {'400'});
model.material('mat1').propertyGroup('LagoudasModel').set('TMs', {'245'});
model.material('mat1').propertyGroup('LagoudasModel').set('TMf', {'230'});
model.material('mat1').propertyGroup('LagoudasModel').set('CM', {'7.4e6'});
model.material('mat1').propertyGroup('LagoudasModel').set('TAs', {'270'});
model.material('mat1').propertyGroup('LagoudasModel').set('TAf', {'280'});
model.material('mat1').propertyGroup('LagoudasModel').set('CA', {'7.4e6'});
model.material('mat1').propertyGroup('LagoudasModel').set('etrmaxLagoudas', {'0.056'});
model.material('mat1').propertyGroup('LagoudasModel').set('sigmaStar', {'0'});
model.material('mat1').propertyGroup('def').set('density', {'6500'});

model.mesh('mesh1').create('map1', 'Map');
model.mesh('mesh1').feature('size').set('hauto', 7);
model.mesh('mesh1').run;

model.study('std1').label('Study: Pseudoelasticity, Single Loading Cycle');
model.study('std1').create('param', 'Parametric');
model.study('std1').feature('param').setIndex('pname', 'T', 0);
model.study('std1').feature('param').setIndex('plistarr', '', 0);
model.study('std1').feature('param').setIndex('punit', 'K', 0);
model.study('std1').feature('param').setIndex('pname', 'T', 0);
model.study('std1').feature('param').setIndex('plistarr', '', 0);
model.study('std1').feature('param').setIndex('punit', 'K', 0);
model.study('std1').feature('param').setIndex('plistarr', '328 308 276 260', 0);
model.study('std1').feature('param').setIndex('punit', 'K', 0);
model.study('std1').feature('stat').set('useparam', true);
model.study('std1').feature('stat').setIndex('pname', 'T', 0);
model.study('std1').feature('stat').setIndex('plistarr', '', 0);
model.study('std1').feature('stat').setIndex('punit', 'K', 0);
model.study('std1').feature('stat').setIndex('pname', 'T', 0);
model.study('std1').feature('stat').setIndex('plistarr', '', 0);
model.study('std1').feature('stat').setIndex('punit', 'K', 0);
model.study('std1').feature('stat').setIndex('pname', 'para', 0);
model.study('std1').feature('stat').setIndex('plistarr', 'range(0,0.01,2)', 0);

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

model.batch.create('p1', 'Parametric');
model.batch('p1').study('std1');
model.batch('p1').create('so1', 'Solutionseq');
model.batch('p1').feature('so1').set('seq', 'sol1');
model.batch('p1').feature('so1').set('store', 'on');
model.batch('p1').feature('so1').set('clear', 'on');
model.batch('p1').feature('so1').set('psol', 'none');
model.batch('p1').set('pname', {'T'});
model.batch('p1').set('plistarr', {'328 308 276 260'});
model.batch('p1').set('sweeptype', 'sparse');
model.batch('p1').set('probesel', 'all');
model.batch('p1').set('probes', {});
model.batch('p1').set('plot', 'off');
model.batch('p1').set('err', 'on');
model.batch('p1').attach('std1');
model.batch('p1').set('control', 'param');

model.sol('sol1').feature('s1').feature('p1').set('paramtuning', true);

model.study('std1').setGenPlots(false);

model.sol.create('sol2');
model.sol('sol2').study('std1');
model.sol('sol2').label('Parametric Solutions 1');

model.batch('p1').feature('so1').set('psol', 'sol2');
model.batch('p1').run('compute');

model.result.create('pg1', 'PlotGroup1D');
model.result('pg1').run;
model.result('pg1').label('Stress vs. Strain (Pseudoelasticity, Single Loading Cycle)');
model.result('pg1').set('data', 'dset2');
model.result('pg1').create('ptgr1', 'PointGraph');
model.result('pg1').feature('ptgr1').set('markerpos', 'datapoints');
model.result('pg1').feature('ptgr1').set('linewidth', 'preference');
model.result('pg1').feature('ptgr1').selection.set([4]);
model.result('pg1').feature('ptgr1').set('expr', 'solid.sGpzz');
model.result('pg1').feature('ptgr1').set('descr', 'Stress tensor, zz-component');
model.result('pg1').feature('ptgr1').set('unit', 'MPa');
model.result('pg1').feature('ptgr1').set('xdataexpr', 'solid.eZZ');
model.result('pg1').feature('ptgr1').set('xdatadescr', 'Strain tensor, ZZ-component');
model.result('pg1').feature('ptgr1').set('autopoint', false);
model.result('pg1').feature('ptgr1').set('legend', true);
model.result('pg1').run;
model.result('pg1').set('xlabelactive', true);
model.result('pg1').set('ylabelactive', true);
model.result('pg1').set('xlabel', 'Axial strain');
model.result('pg1').set('ylabel', 'Axial stress (MPa)');
model.result('pg1').set('legendpos', 'upperleft');
model.result('pg1').run;
model.result.create('pg2', 'PlotGroup1D');
model.result('pg2').run;
model.result('pg2').label('Martensite Volume Fraction (Pseudoelasticity, Single Loading Cycle)');
model.result('pg2').set('data', 'dset2');
model.result('pg2').create('ptgr1', 'PointGraph');
model.result('pg2').feature('ptgr1').set('markerpos', 'datapoints');
model.result('pg2').feature('ptgr1').set('linewidth', 'preference');
model.result('pg2').feature('ptgr1').selection.set([4]);
model.result('pg2').feature('ptgr1').set('expr', 'solid.xiGp_M');
model.result('pg2').feature('ptgr1').set('descr', 'Martensite volume fraction');
model.result('pg2').feature('ptgr1').set('legend', true);
model.result('pg2').feature('ptgr1').set('autopoint', false);
model.result('pg2').run;
model.result('pg2').set('legendpos', 'upperleft');
model.result('pg2').run;

model.func.create('int2', 'Interpolation');
model.func('int2').model('comp1');
model.func('int2').setIndex('table', 0, 0, 0);
model.func('int2').setIndex('table', 0, 0, 1);
model.func('int2').setIndex('table', 1, 1, 0);
model.func('int2').setIndex('table', 1, 1, 1);
model.func('int2').setIndex('table', 2, 2, 0);
model.func('int2').setIndex('table', 0.4, 2, 1);
model.func('int2').setIndex('table', 3, 3, 0);
model.func('int2').setIndex('table', 0.8, 3, 1);
model.func('int2').setIndex('table', 4, 4, 0);
model.func('int2').setIndex('table', 0, 4, 1);

model.physics('solid').create('disp1', 'Displacement1', 1);
model.physics('solid').feature('disp1').selection.set([3]);
model.physics('solid').feature('disp1').setIndex('Direction', 'prescribed', 2);
model.physics('solid').feature('disp1').setIndex('U0', '20[cm]*0.07*int2(para)', 2);

model.study.create('std2');
model.study('std2').create('stat', 'Stationary');
model.study('std2').feature('stat').setSolveFor('/physics/solid', true);
model.study('std2').label('Study: Pseudoelasticity, Multiple Loading Cycles');
model.study('std2').feature('stat').set('useparam', true);
model.study('std2').feature('stat').setIndex('pname', 'T', 0);
model.study('std2').feature('stat').setIndex('plistarr', '', 0);
model.study('std2').feature('stat').setIndex('punit', 'K', 0);
model.study('std2').feature('stat').setIndex('pname', 'T', 0);
model.study('std2').feature('stat').setIndex('plistarr', '', 0);
model.study('std2').feature('stat').setIndex('punit', 'K', 0);
model.study('std2').feature('stat').setIndex('pname', 'para', 0);
model.study('std2').feature('stat').setIndex('plistarr', 'range(0,0.02,4)', 0);
model.study('std2').feature('stat').set('useadvanceddisable', true);
model.study('std2').feature('stat').set('disabledphysics', {'solid/bndl1'});
model.study('std2').setGenPlots(false);

model.sol.create('sol7');
model.sol('sol7').study('std2');
model.sol('sol7').create('st1', 'StudyStep');
model.sol('sol7').feature('st1').set('study', 'std2');
model.sol('sol7').feature('st1').set('studystep', 'stat');
model.sol('sol7').create('v1', 'Variables');
model.sol('sol7').feature('v1').set('control', 'stat');
model.sol('sol7').create('s1', 'Stationary');
model.sol('sol7').feature('s1').create('p1', 'Parametric');
model.sol('sol7').feature('s1').feature.remove('pDef');
model.sol('sol7').feature('s1').feature('p1').set('control', 'stat');
model.sol('sol7').feature('s1').set('control', 'stat');
model.sol('sol7').feature('s1').feature('aDef').set('cachepattern', true);
model.sol('sol7').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol7').feature('s1').feature('fc1').set('termonres', 'auto');
model.sol('sol7').feature('s1').feature('fc1').set('reserrfact', 1000);
model.sol('sol7').feature('s1').feature('fc1').set('linsolver', 'dDef');
model.sol('sol7').feature('s1').feature('fc1').set('termonres', 'auto');
model.sol('sol7').feature('s1').feature('fc1').set('reserrfact', 1000);
model.sol('sol7').feature('s1').feature.remove('fcDef');
model.sol('sol7').attach('std2');
model.sol('sol7').runAll;

model.result('pg1').run;
model.result.duplicate('pg3', 'pg1');
model.result('pg3').run;
model.result('pg3').label('Stress vs. Strain (Pseudoelasticity, Multiple Loading Cycles)');
model.result('pg3').set('data', 'dset3');
model.result('pg3').set('showlegends', false);
model.result('pg3').run;
model.result('pg2').run;
model.result.duplicate('pg4', 'pg2');
model.result('pg4').run;
model.result('pg4').label('Martensite Volume Fraction (Pseudoelasticity, Multiple Loading Cycles)');
model.result('pg4').set('data', 'dset3');
model.result('pg4').set('showlegends', false);
model.result('pg4').run;

model.func.create('int3', 'Interpolation');
model.func('int3').model('comp1');
model.func('int3').set('funcname', 'temperature');
model.func('int3').setIndex('table', 2, 0, 0);
model.func('int3').setIndex('table', 260, 0, 1);
model.func('int3').setIndex('table', 3, 1, 0);
model.func('int3').setIndex('table', 300, 1, 1);
model.func('int3').setIndex('fununit', 'K', 0);
model.func('int3').setIndex('argunit', 1, 0);

model.physics('solid').feature.duplicate('sma2', 'sma1');
model.physics('solid').feature('sma2').set('minput_temperature', 'temperature(para)');
model.physics('solid').create('bndl2', 'BoundaryLoad', 1);
model.physics('solid').feature('bndl2').selection.set([3]);
model.physics('solid').feature('bndl2').set('FperArea', {'0' '0' '300[MPa]*int1(para)'});

model.study.create('std3');
model.study('std3').create('stat', 'Stationary');
model.study('std3').feature('stat').setSolveFor('/physics/solid', true);
model.study('std3').label('Study: Shape Memory Effect');
model.study('std3').feature('stat').set('useparam', true);
model.study('std3').feature('stat').setIndex('pname', 'T', 0);
model.study('std3').feature('stat').setIndex('plistarr', '', 0);
model.study('std3').feature('stat').setIndex('punit', 'K', 0);
model.study('std3').feature('stat').setIndex('pname', 'T', 0);
model.study('std3').feature('stat').setIndex('plistarr', '', 0);
model.study('std3').feature('stat').setIndex('punit', 'K', 0);
model.study('std3').feature('stat').setIndex('pname', 'para', 0);
model.study('std3').feature('stat').setIndex('plistarr', 'range(0,0.02,2) range(2.05,0.05,3)', 0);
model.study('std3').feature('stat').set('useadvanceddisable', true);
model.study('std3').feature('stat').set('disabledphysics', {'solid/bndl1' 'solid/disp1'});
model.study('std3').setGenPlots(false);

model.sol.create('sol8');
model.sol('sol8').study('std3');
model.sol('sol8').create('st1', 'StudyStep');
model.sol('sol8').feature('st1').set('study', 'std3');
model.sol('sol8').feature('st1').set('studystep', 'stat');
model.sol('sol8').create('v1', 'Variables');
model.sol('sol8').feature('v1').set('control', 'stat');
model.sol('sol8').create('s1', 'Stationary');
model.sol('sol8').feature('s1').create('p1', 'Parametric');
model.sol('sol8').feature('s1').feature.remove('pDef');
model.sol('sol8').feature('s1').feature('p1').set('control', 'stat');
model.sol('sol8').feature('s1').set('control', 'stat');
model.sol('sol8').feature('s1').feature('aDef').set('cachepattern', true);
model.sol('sol8').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol8').feature('s1').feature('fc1').set('termonres', 'auto');
model.sol('sol8').feature('s1').feature('fc1').set('reserrfact', 1000);
model.sol('sol8').feature('s1').feature('fc1').set('linsolver', 'dDef');
model.sol('sol8').feature('s1').feature('fc1').set('termonres', 'auto');
model.sol('sol8').feature('s1').feature('fc1').set('reserrfact', 1000);
model.sol('sol8').feature('s1').feature.remove('fcDef');
model.sol('sol8').attach('std3');
model.sol('sol8').runAll;

model.result('pg3').run;
model.result.duplicate('pg5', 'pg3');
model.result('pg5').run;
model.result('pg5').label('Stress vs. Strain (Shape Memory Effect)');
model.result('pg5').set('data', 'dset4');
model.result('pg5').run;

model.study('std1').feature('stat').set('useadvanceddisable', true);
model.study('std1').feature('stat').set('disabledphysics', {'solid/disp1' 'solid/sma2' 'solid/bndl2'});
model.study('std2').feature('stat').set('disabledphysics', {'solid/bndl1' 'solid/sma2' 'solid/bndl2'});

model.result('pg5').run;

model.title('Uniaxial Loading of a Shape Memory Alloy');

model.description(['Three studies are performed to show the properties of a NiTi alloy block subjected to uniaxial tension' native2unicode(hex2dec({'20' '13'}), 'unicode') 'compression loading.' newline  newline 'The first parametric study displays the pseudoelasticity effect at different temperatures. In the second study a partial loading' native2unicode(hex2dec({'20' '13'}), 'unicode') 'unloading cycle is added. Finally, a third study shows the shape memory effect in a low-temperature loading cycle followed by a temperature increase.']);

model.mesh.clearMeshes;

model.sol('sol1').clearSolutionData;
model.sol('sol2').clearSolutionData;
model.sol('sol3').clearSolutionData;
model.sol('sol4').clearSolutionData;
model.sol('sol5').clearSolutionData;
model.sol('sol6').clearSolutionData;
model.sol('sol7').clearSolutionData;
model.sol('sol8').clearSolutionData;

model.label('uniaxial_loading_of_shape_memory_alloy.mph');

model.modelNode.label('Components');

out = model;
