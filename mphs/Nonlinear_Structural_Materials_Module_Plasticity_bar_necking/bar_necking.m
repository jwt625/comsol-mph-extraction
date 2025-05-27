function out = model
%
% bar_necking.m
%
% Model exported on May 26 2025, 21:31 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/Nonlinear_Structural_Materials_Module/Plasticity');

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

model.param.set('sigma0', '450[MPa]');
model.param.descr('sigma0', 'Initial yield stress');
model.param.set('sigmaSF', '715[MPa]');
model.param.descr('sigmaSF', 'Saturation flow stress');
model.param.set('H', '129.24[MPa]');
model.param.descr('H', 'Linear hardening coefficient');
model.param.set('zeta', '16.93');
model.param.descr('zeta', 'Saturation exponent');
model.param.set('delta', '0[m]');
model.param.descr('delta', 'Top displacement');
model.param.set('H0', '53.334[mm]');
model.param.descr('H0', 'Bar length');
model.param.set('R0', '6.413[mm]');
model.param.descr('R0', 'Bar radius');

model.geom('geom1').lengthUnit('mm');
model.geom('geom1').create('r1', 'Rectangle');
model.geom('geom1').feature('r1').set('size', {'R0' 'H0/2'});
model.geom('geom1').runPre('fin');
model.geom('geom1').run;

model.physics('solid').create('disp1', 'Displacement1', 1);
model.physics('solid').feature('disp1').label('Prescribed Displacement, Bottom');
model.physics('solid').feature('disp1').selection.set([2]);
model.physics('solid').feature('disp1').setIndex('Direction', 'prescribed', 2);
model.physics('solid').create('disp2', 'Displacement1', 1);
model.physics('solid').feature('disp2').label('Prescribed Displacement, Top');
model.physics('solid').feature('disp2').selection.set([3]);
model.physics('solid').feature('disp2').setIndex('Direction', 'prescribed', 0);
model.physics('solid').feature('disp2').setIndex('Direction', 'prescribed', 2);
model.physics('solid').feature('disp2').setIndex('U0', 'delta', 2);
model.physics('solid').feature('lemm1').set('geometricNonlinearity', 'totalLagrangian');
model.physics('solid').feature('lemm1').set('strainDecomposition', 'multiplicative');
model.physics('solid').feature('lemm1').set('reducedIntegration', true);
model.physics('solid').feature('lemm1').create('plsty1', 'Plasticity', 2);
model.physics('solid').feature('lemm1').feature('plsty1').set('IsotropicHardeningModel', 'HardeningFunction');
model.physics('solid').feature('lemm1').feature('plsty1').set('nonlocalPlasticModel', 'impGradient');
model.physics('solid').feature('lemm1').feature('plsty1').set('lint', '0.15[mm]');

model.material.create('mat1', 'Common', 'comp1');
model.material('mat1').propertyGroup.create('Enu', 'Young''s_modulus_and_Poisson''s_ratio');
model.material('mat1').propertyGroup('Enu').set('E', {'206.9[GPa]'});
model.material('mat1').propertyGroup('Enu').set('nu', {'0.29'});
model.material('mat1').propertyGroup('def').set('density', {'7850'});
model.material('mat1').propertyGroup.create('ElastoplasticModel', 'Elastoplastic_material_model');
model.material('mat1').propertyGroup('ElastoplasticModel').set('sigmags', {'sigma0'});
model.material('mat1').propertyGroup('ElastoplasticModel').func.create('an1', 'Analytic');
model.material('mat1').propertyGroup('ElastoplasticModel').func('an1').set('funcname', 'sig_h');
model.material('mat1').propertyGroup('ElastoplasticModel').func('an1').set('args', 'epe');
model.material('mat1').propertyGroup('ElastoplasticModel').func('an1').set('expr', 'H*epe+(sigmaSF-sigma0)*(1-exp(-zeta*epe))');
model.material('mat1').propertyGroup('ElastoplasticModel').func('an1').setIndex('argunit', 1, 0);
model.material('mat1').propertyGroup('ElastoplasticModel').func('an1').set('fununit', 'Pa');
model.material('mat1').propertyGroup('ElastoplasticModel').func('an1').setIndex('plotargs', 0, 0, 1);
model.material('mat1').propertyGroup('ElastoplasticModel').func('an1').setIndex('plotargs', 1, 0, 2);
model.material('mat1').propertyGroup('ElastoplasticModel').addInput('effectiveplasticstrain');
model.material('mat1').propertyGroup('ElastoplasticModel').set('sigmagh', {'sig_h(epe)'});

model.mesh('mesh1').create('map1', 'Map');
model.mesh('mesh1').feature('map1').create('dis1', 'Distribution');
model.mesh('mesh1').feature('map1').feature('dis1').selection.set([1]);
model.mesh('mesh1').feature('map1').feature('dis1').set('type', 'predefined');
model.mesh('mesh1').feature('map1').feature('dis1').set('elemcount', 50);
model.mesh('mesh1').feature('map1').feature('dis1').set('elemratio', 5);
model.mesh('mesh1').feature('map1').feature('dis1').selection.set([1 4]);
model.mesh('mesh1').feature('map1').create('dis2', 'Distribution');
model.mesh('mesh1').feature('map1').feature('dis2').selection.set([2]);
model.mesh('mesh1').feature('map1').feature('dis2').set('numelem', 20);
model.mesh('mesh1').run;

model.sol.create('sol1');
model.sol('sol1').study('std1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'stat');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').feature('comp1_solid_lemm1_plsty1_epenl').set('scalemethod', 'manual');
model.sol('sol1').feature('v1').feature('comp1_solid_lemm1_plsty1_epenl').set('resscalemethod', 'parent');
model.sol('sol1').feature('v1').feature('comp1_solid_lemm1_plsty1_epenl').set('scaleval', '1');
model.sol('sol1').feature('v1').set('control', 'stat');
model.sol('sol1').create('s1', 'Stationary');
model.sol('sol1').feature('s1').feature('aDef').set('cachepattern', true);
model.sol('sol1').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('s1').feature('fc1').set('termonres', 'auto');
model.sol('sol1').feature('s1').feature('fc1').set('reserrfact', 1000);
model.sol('sol1').feature('s1').feature('fc1').set('linsolver', 'dDef');
model.sol('sol1').feature('s1').feature('fc1').set('termonres', 'auto');
model.sol('sol1').feature('s1').feature('fc1').set('reserrfact', 1000);
model.sol('sol1').feature('s1').feature.remove('fcDef');
model.sol('sol1').attach('std1');
model.sol('sol1').feature('s1').feature('fc1').set('dtech', 'ddog');

model.study('std1').feature('stat').set('useparam', true);
model.study('std1').feature('stat').setIndex('pname', 'sigma0', 0);
model.study('std1').feature('stat').setIndex('plistarr', '', 0);
model.study('std1').feature('stat').setIndex('punit', 'Pa', 0);
model.study('std1').feature('stat').setIndex('pname', 'sigma0', 0);
model.study('std1').feature('stat').setIndex('plistarr', '', 0);
model.study('std1').feature('stat').setIndex('punit', 'Pa', 0);
model.study('std1').feature('stat').setIndex('pname', 'delta', 0);
model.study('std1').feature('stat').setIndex('plistarr', 'range(0, 0.25, 10)', 0);
model.study('std1').feature('stat').setIndex('punit', 'mm', 0);

model.sol('sol1').runAll;

model.result.create('pg1', 'PlotGroup2D');
model.result('pg1').set('data', 'dset1');
model.result('pg1').setIndex('looplevel', 41, 0);
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
model.result('pg1').feature('surf1').feature('def').set('expr', {'u' 'w'});
model.result('pg1').feature('surf1').feature('def').set('descr', 'Displacement field');
model.result.dataset.create('dset1solidrev', 'Revolve2D');
model.result.dataset('dset1solidrev').set('data', 'dset1');
model.result.dataset('dset1solidrev').set('revangle', 225);
model.result.dataset('dset1solidrev').set('startangle', -90);
model.result.dataset('dset1solidrev').set('hasspacevars', true);
model.result.create('pg2', 'PlotGroup3D');
model.result('pg2').set('data', 'dset1solidrev');
model.result('pg2').setIndex('looplevel', 41, 0);
model.result('pg2').set('defaultPlotID', 'stress3D');
model.result('pg2').label('Stress, 3D (solid)');
model.result('pg2').set('frametype', 'spatial');
model.result('pg2').create('surf1', 'Surface');
model.result('pg2').feature('surf1').set('expr', {'solid.misesGp'});
model.result('pg2').feature('surf1').set('threshold', 'manual');
model.result('pg2').feature('surf1').set('thresholdvalue', 0.2);
model.result('pg2').feature('surf1').set('colortable', 'Rainbow');
model.result('pg2').feature('surf1').set('colortabletrans', 'none');
model.result('pg2').feature('surf1').set('colorscalemode', 'linear');
model.result('pg2').feature('surf1').set('colortable', 'Prism');
model.result('pg2').feature('surf1').create('def', 'Deform');
model.result.dataset('dset1solidrev').set('hasspacevars', true);
model.result('pg2').feature('surf1').feature('def').set('revcoordsys', 'cylindrical');
model.result('pg2').feature('surf1').feature('def').set('expr', {'u' 'v' 'w'});
model.result('pg2').feature('surf1').feature('def').set('descr', 'Displacement field');
model.result('pg2').feature('surf1').feature('def').set('descractive', true);
model.result('pg2').feature('surf1').feature('def').set('scaleactive', true);
model.result('pg2').feature('surf1').feature('def').set('scale', '1');
model.result('pg1').run;
model.result('pg1').run;
model.result('pg1').feature('surf1').set('unit', 'MPa');
model.result('pg1').run;
model.result.create('pg3', 'PlotGroup2D');
model.result('pg3').set('data', 'dset1');
model.result('pg3').setIndex('looplevel', 41, 0);
model.result('pg3').label('Equivalent Plastic Strain (solid)');
model.result('pg3').set('defaultPlotID', 'equivalentPlasticStrain');
model.result('pg3').create('surf1', 'Surface');
model.result('pg3').feature('surf1').set('expr', {'solid.epeGp'});
model.result('pg3').feature('surf1').set('inheritplot', 'none');
model.result('pg3').feature('surf1').set('resolution', 'normal');
model.result('pg3').feature('surf1').set('colortabletype', 'discrete');
model.result('pg3').feature('surf1').set('bandcount', 11);
model.result('pg3').feature('surf1').set('colortable', 'AuroraAustralisDark');
model.result('pg3').feature('surf1').set('descractive', true);
model.result('pg3').feature('surf1').set('descr', 'Equivalent plastic strain');
model.result('pg3').label('Equivalent Plastic Strain (solid)');
model.result('pg3').run;
model.result('pg3').run;
model.result.create('pg4', 'PlotGroup1D');
model.result('pg4').run;
model.result('pg4').label('Neck Radius');
model.result('pg4').create('ptgr1', 'PointGraph');
model.result('pg4').feature('ptgr1').set('markerpos', 'datapoints');
model.result('pg4').feature('ptgr1').set('linewidth', 'preference');
model.result('pg4').feature('ptgr1').selection.set([3]);
model.result('pg4').feature('ptgr1').set('expr', 'u+R0');
model.result('pg4').feature('ptgr1').set('xdata', 'expr');
model.result('pg4').feature('ptgr1').set('xdataexpr', 'delta');
model.result('pg4').run;
model.result('pg4').feature('ptgr1').set('descractive', true);
model.result('pg4').feature('ptgr1').set('descr', 'Neck radius');
model.result('pg4').feature('ptgr1').set('titletype', 'none');
model.result('pg4').run;
model.result.numerical.create('int1', 'IntLine');
model.result.numerical('int1').set('intsurface', true);
model.result.numerical('int1').selection.set([3]);
model.result.numerical('int1').set('expr', {'solid.RFz'});
model.result.numerical('int1').set('descr', {'Reaction force, z-component'});
model.result.numerical('int1').set('unit', {'N'});
model.result.numerical('int1').setIndex('unit', 'kN', 0);
model.result.numerical('int1').set('intsurface', false);
model.result.table.create('tbl1', 'Table');
model.result.table('tbl1').comments('Line Integration 1');
model.result.numerical('int1').set('table', 'tbl1');
model.result.numerical('int1').setResult;
model.result.create('pg5', 'PlotGroup1D');
model.result('pg5').set('data', 'none');
model.result('pg5').create('tblp1', 'Table');
model.result('pg5').feature('tblp1').set('source', 'table');
model.result('pg5').feature('tblp1').set('table', 'tbl1');
model.result('pg5').feature('tblp1').set('linewidth', 'preference');
model.result('pg5').feature('tblp1').set('markerpos', 'datapoints');
model.result('pg5').run;
model.result('pg5').run;
model.result('pg5').label('Reaction Force');
model.result('pg5').set('xlabelactive', true);
model.result('pg5').set('xlabel', 'Top displacement (mm)');
model.result.numerical.create('max1', 'MaxSurface');
model.result.numerical('max1').setIndex('looplevelinput', 'last', 0);
model.result.numerical('max1').selection.all;
model.result.numerical('max1').set('expr', {'solid.epeGp'});
model.result.numerical('max1').set('descr', {'Equivalent plastic strain'});
model.result.numerical('max1').set('unit', {'1'});
model.result.table.create('tbl2', 'Table');
model.result.table('tbl2').comments('Surface Maximum 1');
model.result.numerical('max1').set('table', 'tbl2');
model.result.numerical('max1').setResult;
model.result.dataset.create('mir1', 'Mirror3D');
model.result.dataset('mir1').set('quickplane', 'xy');
model.result('pg2').run;
model.result('pg2').set('data', 'mir1');
model.result('pg2').setIndex('looplevel', 33, 0);
model.result('pg2').set('edges', false);
model.result('pg2').run;

model.title('Necking of an Elastoplastic Metal Bar');

model.description('A circular metal bar of elastoplastic material with nonlinear isotropic hardening is subjected to uniaxial tension. The phenomenon of necking is captured and its growth is simulated. This example is a classical benchmark for large strain plasticity.');

model.mesh.clearMeshes;

model.sol('sol1').clearSolutionData;

model.label('bar_necking.mph');

model.modelNode.label('Components');

out = model;
