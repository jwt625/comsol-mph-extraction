function out = model
%
% compressed_elastoplastic_pipe.m
%
% Model exported on May 26 2025, 21:31 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/Nonlinear_Structural_Materials_Module/Plasticity');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 2);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.physics.create('solid', 'SolidMechanics', 'geom1');
model.physics('solid').model('comp1');

model.study.create('std1');
model.study('std1').create('stat', 'Stationary');
model.study('std1').feature('stat').setSolveFor('/physics/solid', true);

model.param.set('Ro', '200[mm]');
model.param.descr('Ro', 'Outer radius');
model.param.set('thic', '25[mm]');
model.param.descr('thic', 'Pipe wall thickness');
model.param.set('Sy', '250[MPa]');
model.param.descr('Sy', 'Yield stress');
model.param.set('hfact', '1');
model.param.descr('hfact', 'Hardening curve multiplier');
model.param.set('maxLoad', '6[MN]');
model.param.descr('maxLoad', 'The maximum load from the tool');
model.param.set('par', '0');
model.param.descr('par', 'Solution parameter');

model.geom('geom1').create('c1', 'Circle');
model.geom('geom1').feature('c1').label('Circle: Pipe');
model.geom('geom1').feature('c1').set('r', 'Ro');
model.geom('geom1').feature('c1').set('angle', 90);
model.geom('geom1').feature('c1').setIndex('layername', 'Layer 1', 0);
model.geom('geom1').feature('c1').setIndex('layer', 'thic', 0);
model.geom('geom1').run('c1');
model.geom('geom1').create('del1', 'Delete');
model.geom('geom1').feature('del1').selection('input').init(2);
model.geom('geom1').feature('del1').selection('input').set('c1', 1);
model.geom('geom1').run('del1');
model.geom('geom1').create('r1', 'Rectangle');
model.geom('geom1').feature('r1').label('Rectangle: Tool');
model.geom('geom1').feature('r1').set('size', {'0.05' 'Ro'});
model.geom('geom1').feature('r1').set('pos', {'Ro+0.0001' '0'});
model.geom('geom1').run('r1');
model.geom('geom1').create('fil1', 'Fillet');
model.geom('geom1').feature('fil1').selection('point').set('r1', 4);
model.geom('geom1').feature('fil1').set('radius', 'Ro/10');
model.geom('geom1').run('fil1');
model.geom('geom1').create('pol1', 'Polygon');
model.geom('geom1').feature('pol1').set('source', 'table');
model.geom('geom1').feature('pol1').label('Polygon: Symmetry Contact Plane');
model.geom('geom1').feature('pol1').set('type', 'open');
model.geom('geom1').feature('pol1').setIndex('table', 0, 0, 0);
model.geom('geom1').feature('pol1').setIndex('table', 0.15, 0, 1);
model.geom('geom1').feature('pol1').setIndex('table', 0, 1, 0);
model.geom('geom1').feature('pol1').setIndex('table', -0.01, 1, 1);
model.geom('geom1').run('pol1');
model.geom('geom1').feature('fin').set('action', 'assembly');
model.geom('geom1').run('fin');

model.pair.create('p1', 'Contact', 'geom1');
model.pair('p1').source.set([6 10]);
model.pair('p1').destination.set([5]);
model.pair.create('p2', 'Contact', 'geom1');
model.pair('p2').source.set([1]);
model.pair('p2').destination.set([4]);

model.physics('solid').feature('lemm1').create('plsty1', 'Plasticity', 2);
model.physics('solid').feature('lemm1').feature('plsty1').selection.set([1]);
model.physics('solid').feature('lemm1').feature('plsty1').set('IsotropicHardeningModel', 'HardeningFunction');

model.material.create('mat1', 'Common', 'comp1');
model.material('mat1').propertyGroup.create('Enu', 'Young''s_modulus_and_Poisson''s_ratio');
model.material('mat1').propertyGroup('Enu').set('E', {'195[GPa]'});
model.material('mat1').propertyGroup('Enu').set('nu', {'0.3'});
model.material('mat1').propertyGroup('def').set('density', {'8000'});
model.material('mat1').propertyGroup.create('ElastoplasticModel', 'Elastoplastic_material_model');
model.material('mat1').propertyGroup('ElastoplasticModel').set('sigmags', {'Sy'});
model.material('mat1').propertyGroup('ElastoplasticModel').addInput('effectiveplasticstrain');
model.material('mat1').propertyGroup('ElastoplasticModel').func.create('int1', 'Interpolation');
model.material('mat1').propertyGroup('ElastoplasticModel').func('int1').set('table', {'0.00000' '0';  ...
'0.00062' '25';  ...
'0.00140' '50';  ...
'0.00200' '66';  ...
'0.00439' '100';  ...
'0.00952' '125';  ...
'0.01950' '150';  ...
'0.03592' '175';  ...
'0.06028' '200';  ...
'0.09400' '225';  ...
'0.13845' '250';  ...
'0.19498' '275';  ...
'0.26487' '300';  ...
'0.34939' '325';  ...
'0.44978' '350';  ...
'0.52292' '366'});
model.material('mat1').propertyGroup('ElastoplasticModel').func('int1').set('funcname', 'hardFcn');
model.material('mat1').propertyGroup('ElastoplasticModel').func('int1').set('interp', 'piecewisecubic');
model.material('mat1').propertyGroup('ElastoplasticModel').func('int1').setIndex('argunit', 1, 0);
model.material('mat1').propertyGroup('ElastoplasticModel').func('int1').setIndex('fununit', 'MPa', 0);
model.material('mat1').propertyGroup('ElastoplasticModel').set('sigmagh', {'hardFcn(epe)*hfact'});

model.common.create('state1', 'StateVariables', '');
model.common('state1').setIndex('state', 'peakParam', 0);
model.common('state1').setIndex('initialValue', '', 0);
model.common('state1').setIndex('updateExpression', '', 0);
model.common('state1').setIndex('description', '', 0);
model.common('state1').setIndex('initialValue', 0, 0);
model.common('state1').setIndex('updateExpression', 'if(peakParam>0,peakParam,if(comp1.reacF>maxLoad,par,0))', 0);
model.common('state1').setIndex('description', 'Parameter value at max compression', 0);
model.common('state1').set('update', 'afterStep');

model.cpl.create('intop1', 'Integration', 'geom1');
model.cpl('intop1').set('axisym', true);
model.cpl('intop1').set('opname', 'ReacInt');
model.cpl('intop1').selection.set([2]);
model.cpl('intop1').set('method', 'summation');
model.cpl.create('intop2', 'Integration', 'geom1');
model.cpl('intop2').set('axisym', true);
model.cpl('intop2').set('opname', 'AreaInt');
model.cpl('intop2').selection.geom('geom1', 1);
model.cpl('intop2').selection.set([4]);

model.variable.create('var1');
model.variable('var1').model('comp1');
model.variable('var1').set('reacF', '-2*ReacInt(solid.RFx)');
model.variable('var1').descr('reacF', 'Applied force from tool');
model.variable('var1').set('area', 'AreaInt(-x*solid.nx)*4');
model.variable('var1').descr('area', 'Current cross section area for flow');
model.variable('var1').set('disp', 'if(peakParam,peakParam-(par-peakParam)/2,par)[mm]');
model.variable('var1').descr('disp', 'Compression function');

model.physics('solid').create('sym1', 'SymmetrySolid', 1);
model.physics('solid').feature('sym1').selection.set([2 3]);
model.physics('solid').create('disp1', 'Displacement2', 2);
model.physics('solid').feature('disp1').label('Prescribed Displacement: Compression');
model.physics('solid').feature('disp1').selection.set([2]);
model.physics('solid').feature('disp1').setIndex('Direction', 'prescribed', 0);
model.physics('solid').feature('disp1').setIndex('Direction', 'prescribed', 1);
model.physics('solid').feature('disp1').setIndex('U0', '-disp', 0);

model.mesh('mesh1').automatic(false);
model.mesh('mesh1').feature('ftri1').selection.geom('geom1', 2);
model.mesh('mesh1').feature('ftri1').selection.set([2]);
model.mesh('mesh1').feature('ftri1').create('dis1', 'Distribution');
model.mesh('mesh1').feature('ftri1').feature('dis1').selection.all;
model.mesh('mesh1').feature('ftri1').feature('dis1').set('numelem', 1);
model.mesh('mesh1').feature('ftri1').create('dis2', 'Distribution');
model.mesh('mesh1').feature('ftri1').feature('dis2').selection.set([10]);
model.mesh('mesh1').feature('ftri1').feature('dis2').set('numelem', 30);
model.mesh('mesh1').create('map1', 'Map');
model.mesh('mesh1').feature('map1').create('dis1', 'Distribution');
model.mesh('mesh1').feature('map1').feature('dis1').selection.set([4 5]);
model.mesh('mesh1').feature('map1').feature('dis1').set('numelem', 80);
model.mesh('mesh1').feature('map1').create('dis2', 'Distribution');
model.mesh('mesh1').feature('map1').feature('dis2').selection.set([2 3]);
model.mesh('mesh1').feature('map1').feature('dis2').set('type', 'predefined');
model.mesh('mesh1').feature('map1').feature('dis2').set('elemcount', 8);
model.mesh('mesh1').feature('map1').feature('dis2').set('elemratio', 2);
model.mesh('mesh1').feature('map1').feature('dis2').set('symmetric', true);
model.mesh('mesh1').create('edg1', 'Edge');
model.mesh('mesh1').feature('edg1').selection.set([1]);
model.mesh('mesh1').feature('edg1').create('dis1', 'Distribution');
model.mesh('mesh1').feature('edg1').feature('dis1').set('numelem', 1);
model.mesh('mesh1').run;

model.study('std1').feature('stat').set('useparam', true);
model.study('std1').feature('stat').setIndex('pname', 'Ro', 0);
model.study('std1').feature('stat').setIndex('plistarr', '', 0);
model.study('std1').feature('stat').setIndex('punit', 'm', 0);
model.study('std1').feature('stat').setIndex('pname', 'Ro', 0);
model.study('std1').feature('stat').setIndex('plistarr', '', 0);
model.study('std1').feature('stat').setIndex('punit', 'm', 0);
model.study('std1').feature('stat').setIndex('pname', 'par', 0);
model.study('std1').feature('stat').setIndex('plistarr', 'range(0,4,152) range(154,1,200)', 0);
model.study('std1').feature('stat').set('plot', true);

model.sol.create('sol1');
model.sol('sol1').study('std1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'stat');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').feature('comp1_u').set('scalemethod', 'manual');
model.sol('sol1').feature('v1').feature('comp1_u').set('scaleval', '1e-2*0.3265731311666653');
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
model.sol('sol1').feature('s1').feature('fc1').set('linsolver', 'dDef');
model.sol('sol1').feature('s1').feature('fc1').set('dtech', 'ddog');
model.sol('sol1').feature('s1').feature.remove('fcDef');
model.sol('sol1').attach('std1');

model.result.create('pg1', 'PlotGroup2D');
model.result('pg1').set('data', 'dset1');
model.result('pg1').set('defaultPlotID', 'stress');
model.result('pg1').label('Stress (solid)');
model.result('pg1').set('frametype', 'spatial');
model.result('pg1').create('surf1', 'Surface');
model.result('pg1').feature('surf1').set('expr', {'solid.misesGp'});
model.result('pg1').feature('surf1').set('threshold', 'manual');
model.result('pg1').feature('surf1').set('thresholdvalue', 0.2);
model.result('pg1').feature('surf1').set('colortable', 'Rainbow');
model.result('pg1').feature('surf1').set('colortabletrans', 'none');
model.result('pg1').feature('surf1').set('colorscalemode', 'linear');
model.result('pg1').feature('surf1').set('resolution', 'normal');
model.result('pg1').feature('surf1').set('colortable', 'Prism');
model.result('pg1').feature('surf1').create('def', 'Deform');
model.result('pg1').feature('surf1').feature('def').set('scaleactive', true);
model.result('pg1').feature('surf1').feature('def').set('scale', '1');
model.result('pg1').feature('surf1').feature('def').set('expr', {'u' 'v'});
model.result('pg1').feature('surf1').feature('def').set('descr', 'Displacement field');

model.sol('sol1').runFromTo('st1', 'v1');

model.result.remove('pg1');

model.study('std1').feature('stat').set('plotgroup', 'Default');

model.result.create('pg1', 'PlotGroup2D');
model.result('pg1').set('data', 'dset1');
model.result('pg1').setIndex('looplevel', 1, 0);
model.result('pg1').set('defaultPlotID', 'stress');
model.result('pg1').label('Stress (solid)');
model.result('pg1').set('frametype', 'spatial');
model.result('pg1').create('surf1', 'Surface');
model.result('pg1').feature('surf1').set('expr', {'solid.misesGp'});
model.result('pg1').feature('surf1').set('threshold', 'manual');
model.result('pg1').feature('surf1').set('thresholdvalue', 0.2);
model.result('pg1').feature('surf1').set('colortable', 'Rainbow');
model.result('pg1').feature('surf1').set('colortabletrans', 'none');
model.result('pg1').feature('surf1').set('colorscalemode', 'linear');
model.result('pg1').feature('surf1').set('resolution', 'normal');
model.result('pg1').feature('surf1').set('colortable', 'Prism');
model.result('pg1').feature('surf1').create('def', 'Deform');
model.result('pg1').feature('surf1').feature('def').set('scaleactive', true);
model.result('pg1').feature('surf1').feature('def').set('scale', '1');
model.result('pg1').feature('surf1').feature('def').set('expr', {'u' 'v'});
model.result('pg1').feature('surf1').feature('def').set('descr', 'Displacement field');
model.result('pg1').run;
model.result.create('pg2', 'PlotGroup2D');
model.result('pg2').set('data', 'dset1');
model.result('pg2').setIndex('looplevel', 1, 0);
model.result('pg2').label('Equivalent Plastic Strain (solid)');
model.result('pg2').set('defaultPlotID', 'equivalentPlasticStrain');
model.result('pg2').create('surf1', 'Surface');
model.result('pg2').feature('surf1').set('expr', {'solid.epeGp'});
model.result('pg2').feature('surf1').set('inheritplot', 'none');
model.result('pg2').feature('surf1').set('resolution', 'normal');
model.result('pg2').feature('surf1').set('colortabletype', 'discrete');
model.result('pg2').feature('surf1').set('bandcount', 11);
model.result('pg2').feature('surf1').set('colortable', 'AuroraAustralisDark');
model.result('pg2').feature('surf1').set('descractive', true);
model.result('pg2').feature('surf1').set('descr', 'Equivalent plastic strain');
model.result('pg2').label('Equivalent Plastic Strain (solid)');
model.result.create('pg3', 'PlotGroup2D');
model.result('pg3').set('data', 'dset1');
model.result('pg3').setIndex('looplevel', 1, 0);
model.result('pg3').set('defaultPlotID', 'contactForces');
model.result('pg3').label('Contact Forces (solid)');
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
model.result('pg3').feature('surf1').feature('def').set('expr', {'u' 'v'});
model.result('pg3').feature('surf1').feature('def').set('descr', 'Displacement field');
model.result('pg3').feature('surf1').feature('def').set('scaleactive', true);
model.result('pg3').feature('surf1').feature('def').set('scale', 1);
model.result('pg3').feature('surf1').create('sel1', 'Selection');
model.result('pg3').feature('surf1').feature('sel1').selection.geom('geom1', 2);
model.result('pg3').feature('surf1').feature('sel1').selection.set([1 2]);
model.result('pg3').create('arwl1', 'ArrowLine');
model.result('pg3').feature('arwl1').set('arrowbase', 'head');
model.result('pg3').feature('arwl1').set('expr', {'solid.dcnt1.Tnx' 'solid.dcnt1.Tny'});
model.result('pg3').feature('arwl1').set('placement', 'gausspoints');
model.result('pg3').feature('arwl1').set('gporder', 4);
model.result('pg3').feature('arwl1').label('Contact 1, Pressure');
model.result('pg3').feature('arwl1').set('inheritplot', 'none');
model.result('pg3').feature('arwl1').set('color', 'green');
model.result('pg3').feature('arwl1').create('col', 'Color');
model.result('pg3').feature('arwl1').feature('col').set('colortable', 'Rainbow');
model.result('pg3').feature('arwl1').feature('col').set('colortabletrans', 'none');
model.result('pg3').feature('arwl1').feature('col').set('colorscalemode', 'linear');
model.result('pg3').feature('arwl1').feature('col').set('colordata', 'arrowlength');
model.result('pg3').feature('arwl1').feature('col').set('coloring', 'gradient');
model.result('pg3').feature('arwl1').feature('col').set('topcolor', 'green');
model.result('pg3').feature('arwl1').feature('col').set('bottomcolor', 'custom');
model.result('pg3').feature('arwl1').feature('col').set('custombottomcolor', [0.509804 0.54902 0.509804]);
model.result('pg3').feature('arwl1').create('def', 'Deform');
model.result('pg3').feature('arwl1').feature('def').set('expr', {'u' 'v'});
model.result('pg3').feature('arwl1').feature('def').set('descr', 'Displacement field');
model.result('pg3').feature('arwl1').feature('def').set('scaleactive', true);
model.result('pg3').feature('arwl1').feature('def').set('scale', 1);
model.result('pg3').feature.move('surf1', 1);
model.result('pg3').label('Contact Forces (solid)');
model.result('pg3').run;

model.sol('sol1').feature('s1').feature('p1').set('porder', 'linear');
model.sol('sol1').feature('s1').feature('p1').set('paramtuning', true);
model.sol('sol1').feature('s1').feature('p1').set('pinitstep', 1);
model.sol('sol1').feature('s1').feature('p1').set('pmaxstep', 1);

model.result.dataset.create('mir1', 'Mirror2D');
model.result.dataset('mir1').set('removesymelem', true);
model.result.dataset.create('mir2', 'Mirror2D');
model.result.dataset('mir2').set('data', 'mir1');
model.result.dataset('mir2').setIndex('genpoints', 1, 1, 0);
model.result.dataset('mir2').setIndex('genpoints', 0, 1, 1);
model.result.dataset('mir2').set('removesymelem', true);
model.result('pg1').run;
model.result('pg1').set('data', 'mir2');
model.result('pg1').run;
model.result('pg1').feature('surf1').set('unit', 'MPa');

model.sol('sol1').runAll;

model.result('pg1').run;
model.result.evaluationGroup.create('eg1', 'EvaluationGroup');
model.result.evaluationGroup('eg1').label('Remaining Cross-Section Area');
model.result.evaluationGroup('eg1').setIndex('looplevelinput', 'last', 0);
model.result.evaluationGroup('eg1').create('gev1', 'EvalGlobal');
model.result.evaluationGroup('eg1').feature('gev1').setIndex('expr', 'area', 0);
model.result.evaluationGroup('eg1').feature('gev1').setIndex('unit', 'mm^2', 0);
model.result.evaluationGroup('eg1').feature('gev1').setIndex('descr', '', 0);
model.result.evaluationGroup('eg1').run;
model.result('pg1').run;
model.result('pg1').run;
model.result('pg1').setIndex('looplevel', 55, 0);
model.result('pg1').run;
model.result.export.create('anim1', 'Animation');
model.result.export('anim1').set('target', 'player');
model.result.export('anim1').set('plotgroup', 'pg1');
model.result.export('anim1').run;
model.result('pg2').run;
model.result('pg2').set('frametype', 'spatial');
model.result('pg2').run;
model.result('pg2').run;
model.result('pg2').feature('surf1').set('rangecoloractive', true);
model.result('pg2').feature('surf1').set('rangecolormax', 1.1);
model.result('pg2').feature('surf1').create('def1', 'Deform');
model.result('pg2').run;
model.result('pg2').feature('surf1').feature('def1').set('scaleactive', true);
model.result('pg2').feature('surf1').feature('def1').set('scale', 1);
model.result('pg2').run;
model.result('pg2').create('con1', 'Contour');
model.result('pg2').feature('con1').set('expr', 'solid.epeGp');
model.result('pg2').feature('con1').set('titletype', 'none');
model.result('pg2').feature('con1').set('number', 1);
model.result('pg2').feature('con1').set('levelmethod', 'levels');
model.result('pg2').feature('con1').set('levels', 0.52);
model.result('pg2').feature('con1').set('contourtype', 'tubes');
model.result('pg2').feature('con1').set('tuberadiusscaleactive', true);
model.result('pg2').feature('con1').set('radiusexpr', '5e-4');
model.result('pg2').feature('con1').set('coloring', 'uniform');
model.result('pg2').feature('con1').set('colorlegend', false);
model.result('pg2').feature('con1').set('inheritplot', 'surf1');
model.result('pg2').feature('con1').set('inheritcolor', false);
model.result('pg2').feature('con1').create('def1', 'Deform');
model.result('pg2').run;
model.result('pg2').run;
model.result.create('pg4', 'PlotGroup1D');
model.result('pg4').run;
model.result('pg4').label('Compression Force');
model.result('pg4').set('titletype', 'none');
model.result('pg4').set('ylabelactive', true);
model.result('pg4').set('ylabel', 'Force per unit length (MN/m)');
model.result('pg4').set('xlabelactive', true);
model.result('pg4').set('xlabel', 'Compression (mm)');
model.result('pg4').set('showlegends', false);
model.result('pg4').create('glob1', 'Global');
model.result('pg4').feature('glob1').set('markerpos', 'datapoints');
model.result('pg4').feature('glob1').set('linewidth', 'preference');
model.result('pg4').feature('glob1').set('expr', {'reacF'});
model.result('pg4').feature('glob1').set('descr', {'Applied force from tool'});
model.result('pg4').feature('glob1').set('unit', {'N'});
model.result('pg4').feature('glob1').setIndex('unit', 'MN', 0);
model.result('pg4').feature('glob1').setIndex('descr', 'Applied force from tool', 0);
model.result('pg4').feature('glob1').set('xdata', 'expr');
model.result('pg4').feature('glob1').set('xdataexpr', 'disp');
model.result('pg4').run;
model.result('pg4').run;
model.result.duplicate('pg5', 'pg4');
model.result('pg5').run;
model.result('pg5').label('Flow Area');
model.result('pg5').set('ylabel', 'Cross section area (mm<sup>2</sup>)');
model.result('pg5').run;
model.result('pg5').feature('glob1').setIndex('expr', 'area', 0);
model.result('pg5').feature('glob1').setIndex('unit', 'mm^2', 0);
model.result('pg5').feature('glob1').setIndex('descr', 'Current cross section area for flow', 0);
model.result('pg5').run;
model.result('pg2').run;
model.result.duplicate('pg6', 'pg2');
model.result('pg6').run;
model.result('pg6').run;
model.result('pg6').feature('surf1').create('filt1', 'Filter');
model.result('pg6').run;
model.result('pg6').feature('surf1').feature('filt1').set('expr', 'y>0.23');
model.result('pg6').run;
model.result('pg6').feature('con1').create('filt1', 'Filter');
model.result('pg6').run;
model.result('pg6').feature('con1').feature('filt1').set('expr', 'y>0.23');
model.result('pg6').run;
model.result('pg6').set('edges', false);
model.result('pg6').run;
model.result.remove('pg6');
model.result('pg1').run;

model.title('Compression of an Elastoplastic Pipe');

model.description('In order to seal a broken pipe, it is squeezed between two rigid indenters until it is almost flat. This operation results in very large plastic strains.');

model.mesh.clearMeshes;

model.sol('sol1').clearSolutionData;

model.label('compressed_elastoplastic_pipe.mph');

model.modelNode.label('Components');

out = model;
