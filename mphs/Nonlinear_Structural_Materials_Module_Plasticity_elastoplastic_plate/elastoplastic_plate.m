function out = model
%
% elastoplastic_plate.m
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

model.geom('geom1').lengthUnit('mm');
model.geom('geom1').create('r1', 'Rectangle');
model.geom('geom1').feature('r1').set('size', [18 10]);
model.geom('geom1').run('r1');
model.geom('geom1').create('c1', 'Circle');
model.geom('geom1').feature('c1').set('r', 5);
model.geom('geom1').run('c1');
model.geom('geom1').create('dif1', 'Difference');
model.geom('geom1').feature('dif1').selection('input').set({'r1'});
model.geom('geom1').feature('dif1').selection('input2').set({'c1'});
model.geom('geom1').run('dif1');

model.param.set('para', '0');
model.param.descr('para', 'Horizontal load parameter');

model.func.create('int1', 'Interpolation');
model.func('int1').model('comp1');
model.func('int1').set('funcname', 'loadfunc');
model.func('int1').setIndex('table', 0, 0, 0);
model.func('int1').setIndex('table', 0, 0, 1);
model.func('int1').setIndex('table', 1.1, 1, 0);
model.func('int1').setIndex('table', 133.65, 1, 1);
model.func('int1').setIndex('table', 2.2, 2, 0);
model.func('int1').setIndex('table', 0, 2, 1);
model.func('int1').setIndex('argunit', 1, 0);
model.func('int1').setIndex('fununit', 'MPa', 0);

model.geom('geom1').run;

model.physics('solid').prop('Type2D').set('Type2D', 'PlaneStress');
model.physics('solid').prop('d').set('d', '10[mm]');
model.physics('solid').feature('lemm1').create('plsty1', 'Plasticity', 2);
model.physics('solid').feature('lemm1').feature('plsty1').label('Linear Hardening');

model.material.create('mat1', 'Common', 'comp1');
model.material('mat1').propertyGroup.create('Enu', 'Young''s_modulus_and_Poisson''s_ratio');
model.material('mat1').propertyGroup('Enu').set('E', {'70e9'});
model.material('mat1').propertyGroup('Enu').set('nu', {'0.2'});
model.material('mat1').propertyGroup('def').set('density', {'7850'});
model.material('mat1').propertyGroup.create('ElastoplasticModel', 'Elastoplastic_material_model');
model.material('mat1').propertyGroup('ElastoplasticModel').set('sigmags', {'243e6'});
model.material('mat1').propertyGroup('ElastoplasticModel').set('Et', {'2.171e9'});

model.physics('solid').create('sym1', 'SymmetrySolid', 1);
model.physics('solid').feature('sym1').selection.set([1 3]);
model.physics('solid').create('bndl1', 'BoundaryLoad', 1);
model.physics('solid').feature('bndl1').selection.set([4]);
model.physics('solid').feature('bndl1').set('FperArea', {'loadfunc(para)' '0' '0'});

model.mesh('mesh1').create('ftri1', 'FreeTri');
model.mesh('mesh1').create('ref1', 'Refine');
model.mesh('mesh1').feature('ref1').set('boxcoord', true);
model.mesh('mesh1').feature('ref1').set('xmax', 8);
model.mesh('mesh1').feature('ref1').set('ymax', 10);
model.mesh('mesh1').run;

model.study('std1').feature('stat').set('useparam', true);
model.study('std1').feature('stat').setIndex('pname', 'para', 0);
model.study('std1').feature('stat').setIndex('plistarr', '', 0);
model.study('std1').feature('stat').setIndex('punit', '', 0);
model.study('std1').feature('stat').setIndex('pname', 'para', 0);
model.study('std1').feature('stat').setIndex('plistarr', '', 0);
model.study('std1').feature('stat').setIndex('punit', '', 0);
model.study('std1').feature('stat').setIndex('pname', 'para', 0);
model.study('std1').feature('stat').setIndex('plistarr', '0 range(0.40,0.05,2.2)', 0);
model.study('std1').label('Linear Hardening');
model.study('std1').setGenPlots(false);

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
model.sol('sol1').feature('s1').feature('p1').set('porder', 'constant');
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
model.sol('sol1').runAll;

model.result.create('pg1', 'PlotGroup2D');
model.result('pg1').set('data', 'dset1');
model.result('pg1').setIndex('looplevel', 38, 0);
model.result('pg1').set('defaultPlotID', 'stress');
model.result('pg1').label('Stress (solid)');
model.result('pg1').set('frametype', 'spatial');
model.result('pg1').create('surf1', 'Surface');
model.result('pg1').feature('surf1').set('expr', {'solid.misesGp'});
model.result('pg1').feature('surf1').set('threshold', 'manual');
model.result('pg1').feature('surf1').set('thresholdvalue', 0.2);
model.result('pg1').feature('surf1').set('colortable', 'Prism');
model.result('pg1').feature('surf1').set('colortabletrans', 'none');
model.result('pg1').feature('surf1').set('colorscalemode', 'linear');
model.result('pg1').feature('surf1').set('resolution', 'normal');
model.result('pg1').feature('surf1').create('def', 'Deform');
model.result('pg1').feature('surf1').feature('def').set('expr', {'u' 'v'});
model.result('pg1').feature('surf1').feature('def').set('descr', 'Displacement field');
model.result('pg1').label('Stress (solid)');
model.result('pg1').run;
model.result('pg1').label('Stress, Linear Hardening');
model.result.create('pg2', 'PlotGroup2D');
model.result('pg2').set('data', 'dset1');
model.result('pg2').setIndex('looplevel', 38, 0);
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
model.result('pg2').run;
model.result('pg2').label('Plastic Region, Linear Hardening');
model.result('pg2').run;
model.result('pg2').feature('surf1').set('expr', 'solid.epeGp>0');
model.result('pg2').run;
model.result('pg2').run;
model.result('pg2').setIndex('looplevel', 5, 0);
model.result('pg2').run;
model.result('pg2').setIndex('looplevel', 7, 0);
model.result('pg2').run;
model.result('pg2').setIndex('looplevel', 9, 0);
model.result('pg2').run;
model.result('pg2').setIndex('looplevel', 11, 0);
model.result('pg2').run;
model.result('pg2').setIndex('looplevel', 13, 0);
model.result('pg2').run;
model.result('pg2').setIndex('looplevel', 15, 0);
model.result('pg2').run;

model.func.create('int2', 'Interpolation');
model.func('int2').model('comp1');
model.func('int2').set('funcname', 'stress_strain_curve');
model.func('int2').setIndex('table', 0, 0, 0);
model.func('int2').setIndex('table', 0, 0, 1);
model.func('int2').setIndex('table', '243e6/70e9', 1, 0);
model.func('int2').setIndex('table', '243e6', 1, 1);
model.func('int2').setIndex('table', '243e6/70e9+50e6/2.171e9', 2, 0);
model.func('int2').setIndex('table', '243e6+50e6', 2, 1);
model.func('int2').setIndex('argunit', 1, 0);
model.func('int2').setIndex('fununit', 'Pa', 0);
model.func('int2').set('extrap', 'linear');

model.variable.create('var1');
model.variable('var1').model('comp1');
model.variable('var1').set('hardening', 'max(0,stress_strain_curve(solid.epe+solid.mises/solid.E)-solid.sigmags)');
model.variable('var1').descr('hardening', 'Hardening function');

model.physics('solid').feature('lemm1').create('plsty2', 'Plasticity', 2);
model.physics('solid').feature('lemm1').feature('plsty2').label('Interpolated Hardening and User Defined Plastic Flow');
model.physics('solid').feature('lemm1').feature('plsty2').set('YieldFunction', 'userDefined');
model.physics('solid').feature('lemm1').feature('plsty2').set('sigmagf', 'sqrt(3*solid.II2sEff)');
model.physics('solid').feature('lemm1').feature('plsty2').set('FlowPotential', 'userDefined');
model.physics('solid').feature('lemm1').feature('plsty2').set('Qplast', 'sqrt(3*solid.II2sEff+eps)');
model.physics('solid').feature('lemm1').feature('plsty2').set('IsotropicHardeningModel', 'HardeningFunction');

model.material('mat1').propertyGroup('ElastoplasticModel').set('sigmagh', {'hardening'});

model.study.create('std2');
model.study('std2').create('stat', 'Stationary');
model.study('std2').feature('stat').setSolveFor('/physics/solid', true);
model.study('std2').feature('stat').set('useparam', true);
model.study('std2').feature('stat').setIndex('pname', 'para', 0);
model.study('std2').feature('stat').setIndex('plistarr', '', 0);
model.study('std2').feature('stat').setIndex('punit', '', 0);
model.study('std2').feature('stat').setIndex('pname', 'para', 0);
model.study('std2').feature('stat').setIndex('plistarr', '', 0);
model.study('std2').feature('stat').setIndex('punit', '', 0);
model.study('std2').feature('stat').setIndex('pname', 'para', 0);
model.study('std2').feature('stat').setIndex('plistarr', '0 range(0.40,0.05,2.2)', 0);
model.study('std2').label('Interpolated Hardening and User Defined Plastic Flow');
model.study('std2').setGenPlots(false);

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
model.sol('sol2').feature('s1').feature('p1').set('porder', 'constant');
model.sol('sol2').feature('s1').feature('p1').set('control', 'stat');
model.sol('sol2').feature('s1').set('control', 'stat');
model.sol('sol2').feature('s1').feature('aDef').set('cachepattern', true);
model.sol('sol2').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol2').feature('s1').feature('fc1').set('termonres', 'auto');
model.sol('sol2').feature('s1').feature('fc1').set('reserrfact', 1000);
model.sol('sol2').feature('s1').feature('fc1').set('linsolver', 'dDef');
model.sol('sol2').feature('s1').feature('fc1').set('termonres', 'auto');
model.sol('sol2').feature('s1').feature('fc1').set('reserrfact', 1000);
model.sol('sol2').feature('s1').feature.remove('fcDef');
model.sol('sol2').attach('std2');
model.sol('sol2').runAll;

model.result('pg1').run;
model.result.duplicate('pg3', 'pg1');
model.result('pg3').run;
model.result('pg3').label('Stress, Interpolated Hardening and User Defined Plastic Flow');
model.result('pg3').set('data', 'dset2');
model.result('pg3').run;
model.result('pg2').run;
model.result.duplicate('pg4', 'pg2');
model.result('pg4').run;
model.result('pg4').label('Plastic Region, Interpolated Hardening and User Defined Plastic Flow');
model.result('pg4').set('data', 'dset2');
model.result('pg4').run;
model.result('pg4').run;
model.result('pg4').run;
model.result('pg4').run;

model.study('std1').feature('stat').set('useadvanceddisable', true);
model.study('std1').feature('stat').set('disabledphysics', {'solid/lemm1/plsty2'});

model.title('Elastoplastic Analysis of Holed Plate');

model.description(['This example shows the analysis of a perforated plate loaded into the plastic regime. Part of the example is a benchmark, but the unloading of the plate and residual stresses are also studied.' newline  newline 'In a second part of the example, it is shown how a hardening function based on a measured stress' native2unicode(hex2dec({'20' '13'}), 'unicode') 'strain curve can be used.']);

model.mesh.clearMeshes;

model.sol('sol1').clearSolutionData;
model.sol('sol2').clearSolutionData;

model.label('elastoplastic_plate.mph');

model.modelNode.label('Components');

out = model;
