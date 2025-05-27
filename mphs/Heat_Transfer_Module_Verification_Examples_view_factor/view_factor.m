function out = model
%
% view_factor.m
%
% Model exported on May 26 2025, 21:29 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/Heat_Transfer_Module/Verification_Examples');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 3);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.physics.create('rad', 'SurfaceToSurfaceRadiation', 'geom1');
model.physics('rad').model('comp1');

model.study.create('std1');
model.study('std1').create('stat', 'Stationary');
model.study('std1').feature('stat').setSolveFor('/physics/rad', true);

model.param.set('r_int', '0.3[m]');
model.param.descr('r_int', 'Radius, interior sphere');
model.param.set('r_ext', '1[m]');
model.param.descr('r_ext', 'Radius, exterior sphere');
model.param.set('F_ext_ext', '1-(r_int/r_ext)^2');
model.param.descr('F_ext_ext', 'Analytical view factor from exterior sphere to exterior sphere');
model.param.set('F_ext_int', '(r_int/r_ext)^2');
model.param.descr('F_ext_int', 'Analytical view factor from exterior sphere to interior sphere');
model.param.set('F_int_int', '0');
model.param.descr('F_int_int', 'Analytical view factor from interior sphere to interior sphere');
model.param.set('F_int_ext', '1');
model.param.descr('F_int_ext', 'Analytical view factor from interior sphere to exterior sphere');

model.geom('geom1').create('sph1', 'Sphere');
model.geom('geom1').feature('sph1').set('type', 'surface');
model.geom('geom1').feature('sph1').set('r', 'r_int');
model.geom('geom1').selection.create('csel1', 'CumulativeSelection');
model.geom('geom1').selection('csel1').label('Inner sphere');
model.geom('geom1').feature('sph1').set('contributeto', 'csel1');
model.geom('geom1').run('sph1');
model.geom('geom1').create('sph2', 'Sphere');
model.geom('geom1').feature('sph2').set('type', 'surface');
model.geom('geom1').feature('sph2').set('r', 'r_ext');
model.geom('geom1').selection.create('csel2', 'CumulativeSelection');
model.geom('geom1').selection('csel2').label('Outer sphere');
model.geom('geom1').feature('sph2').set('contributeto', 'csel2');
model.geom('geom1').run('sph2');
model.geom('geom1').create('del1', 'Delete');
model.geom('geom1').feature('del1').selection('input').set('sph1', [1 2 3 4 5 6 7]);
model.geom('geom1').feature('del1').selection('input').set('sph2', [1 2 3 4 5 6 7]);
model.geom('geom1').runPre('fin');
model.geom('geom1').run;

model.material.create('mat1', 'Common', 'comp1');
model.material('mat1').label('Blackbody');
model.material('mat1').propertyGroup('def').set('emissivity', {'1'});

model.physics('rad').feature('dsurf1').set('radDirectionType', 'RadiationDirectionPlus');
model.physics('rad').create('dsurf2', 'DiffuseSurface', 2);
model.physics('rad').feature('dsurf2').selection.named('geom1_csel2_bnd');
model.physics('rad').feature('dsurf2').set('radDirectionType', 'RadiationDirectionMinus');
model.physics('rad').create('rsym1', 'SymmetryForSurfaceToSurfaceRadiation', -1);
model.physics('rad').feature('rsym1').set('typeOfSymmetry', 'ThreePerpendicularSymmetryPlanes');

model.variable.create('var1');
model.variable('var1').model('comp1');
model.variable('var1').label('Identifiers, Inner Sphere');
model.variable('var1').selection.geom('geom1', 2);
model.variable('var1').selection.named('geom1_csel1_bnd');
model.variable('var1').set('ext', '0');
model.variable('var1').descr('ext', 'Exterior surface indicator');
model.variable('var1').set('int', '1');
model.variable('var1').descr('int', 'Interior surface indicator');
model.variable.create('var2');
model.variable('var2').model('comp1');
model.variable('var2').label('Identifiers, Outer Sphere');
model.variable('var2').selection.geom('geom1', 2);
model.variable('var2').selection.named('geom1_csel2_bnd');
model.variable('var2').set('ext', '1', 'Exterior surface indicator');
model.variable('var2').descr('ext', 'Exterior surface indicator');
model.variable('var2').set('int', '0', 'Interior surface indicator');
model.variable('var2').descr('int', 'Interior surface indicator');

model.cpl.create('intop1', 'Integration', 'geom1');
model.cpl('intop1').set('axisym', true);
model.cpl('intop1').label('Integration, Inner Sphere');
model.cpl('intop1').set('opname', 'intop_int');
model.cpl('intop1').selection.geom('geom1', 2);
model.cpl('intop1').selection.named('geom1_csel1_bnd');
model.cpl.create('intop2', 'Integration', 'geom1');
model.cpl('intop2').set('axisym', true);
model.cpl('intop2').label('Integration, Outer Sphere');
model.cpl('intop2').set('opname', 'intop_ext');
model.cpl('intop2').selection.geom('geom1', 2);
model.cpl('intop2').selection.named('geom1_csel2_bnd');

model.mesh('mesh1').create('ftri1', 'FreeTri');
model.mesh('mesh1').feature('ftri1').selection.all;
model.mesh('mesh1').feature('ftri1').create('size1', 'Size');
model.mesh('mesh1').feature('ftri1').feature('size1').selection.named('geom1_csel1_bnd');
model.mesh('mesh1').feature('ftri1').feature('size1').set('custom', true);
model.mesh('mesh1').feature('ftri1').feature('size1').set('hmaxactive', true);
model.mesh('mesh1').feature('ftri1').feature('size1').set('hmax', 'r_int/5');
model.mesh('mesh1').feature('ftri1').create('size2', 'Size');
model.mesh('mesh1').feature('ftri1').feature('size2').selection.named('geom1_csel2_bnd');
model.mesh('mesh1').feature('ftri1').feature('size2').set('custom', true);
model.mesh('mesh1').feature('ftri1').feature('size2').set('hmaxactive', true);
model.mesh('mesh1').feature('ftri1').feature('size2').set('hmax', 'r_ext/5');
model.mesh('mesh1').run;

model.study('std1').setGenPlots(false);

model.sol.create('sol1');
model.sol('sol1').study('std1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'stat');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').feature('comp1_rad_dsurf2_Jd_band').set('scalemethod', 'init');
model.sol('sol1').feature('v1').feature('comp1_rad_dsurf2_Ju_band').set('scalemethod', 'init');
model.sol('sol1').feature('v1').feature('comp1_rad_dsurf1_Jd_band').set('scalemethod', 'init');
model.sol('sol1').feature('v1').feature('comp1_rad_dsurf1_Ju_band').set('scalemethod', 'init');
model.sol('sol1').feature('v1').set('control', 'stat');
model.sol('sol1').create('s1', 'Stationary');
model.sol('sol1').feature('s1').create('se1', 'Segregated');
model.sol('sol1').feature('s1').feature('se1').feature.remove('ssDef');
model.sol('sol1').feature('s1').feature('se1').create('ss1', 'SegregatedStep');
model.sol('sol1').feature('s1').feature('se1').feature('ss1').set('segvar', {'comp1_rad_dsurf1_Ju_band' 'comp1_rad_dsurf1_Jd_band' 'comp1_rad_dsurf2_Ju_band' 'comp1_rad_dsurf2_Jd_band'});
model.sol('sol1').feature('s1').feature('se1').feature('ss1').set('subdamp', 0.8);
model.sol('sol1').feature('s1').create('d1', 'Direct');
model.sol('sol1').feature('s1').feature('d1').set('linsolver', 'pardiso');
model.sol('sol1').feature('s1').feature('d1').set('pivotperturb', 1.0E-13);
model.sol('sol1').feature('s1').feature('d1').label('Direct, radiation variables');
model.sol('sol1').feature('s1').feature('se1').feature('ss1').set('linsolver', 'd1');
model.sol('sol1').feature('s1').feature('se1').feature('ss1').label('Radiosity');
model.sol('sol1').feature('s1').feature('se1').set('segstabacc', 'segaacc');
model.sol('sol1').feature('s1').feature('se1').set('segaaccdim', 10);
model.sol('sol1').feature('s1').feature('se1').set('ntolfact', 0.1);
model.sol('sol1').feature('s1').create('i1', 'Iterative');
model.sol('sol1').feature('s1').feature('i1').set('linsolver', 'gmres');
model.sol('sol1').feature('s1').feature('i1').set('prefuntype', 'left');
model.sol('sol1').feature('s1').feature('i1').set('rhob', 400);
model.sol('sol1').feature('s1').feature('i1').label('AMG, radiation variables');
model.sol('sol1').feature('s1').feature('i1').create('mg1', 'Multigrid');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').set('prefun', 'saamg');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').set('usesmooth', false);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').set('saamgcompwise', true);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('pr').create('so1', 'SOR');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('pr').feature('so1').set('iter', 2);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('pr').feature('so1').set('relax', 0.9);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('po').create('so1', 'SOR');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('po').feature('so1').set('iter', 2);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('po').feature('so1').set('relax', 0.9);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('cs').create('d1', 'Direct');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('cs').feature('d1').set('linsolver', 'pardiso');
model.sol('sol1').feature('s1').create('i2', 'Iterative');
model.sol('sol1').feature('s1').feature('i2').set('linsolver', 'gmres');
model.sol('sol1').feature('s1').feature('i2').set('prefuntype', 'left');
model.sol('sol1').feature('s1').feature('i2').set('rhob', 20);
model.sol('sol1').feature('s1').feature('i2').label('GMG, radiation variables');
model.sol('sol1').feature('s1').feature('i2').create('mg1', 'Multigrid');
model.sol('sol1').feature('s1').feature('i2').feature('mg1').set('prefun', 'gmg');
model.sol('sol1').feature('s1').feature('i2').feature('mg1').set('mcasegen', 'any');
model.sol('sol1').feature('s1').feature('i2').feature('mg1').feature('pr').create('so1', 'SOR');
model.sol('sol1').feature('s1').feature('i2').feature('mg1').feature('pr').feature('so1').set('iter', 2);
model.sol('sol1').feature('s1').feature('i2').feature('mg1').feature('po').create('so1', 'SOR');
model.sol('sol1').feature('s1').feature('i2').feature('mg1').feature('po').feature('so1').set('iter', 2);
model.sol('sol1').feature('s1').feature('i2').feature('mg1').feature('cs').create('d1', 'Direct');
model.sol('sol1').feature('s1').feature('i2').feature('mg1').feature('cs').feature('d1').set('linsolver', 'pardiso');
model.sol('sol1').feature('s1').feature.remove('fcDef');
model.sol('sol1').attach('std1');
model.sol('sol1').runFromTo('st1', 'v1');

model.result.numerical.create('gev1', 'EvalGlobal');
model.result.numerical('gev1').label('View Factors');
model.result.numerical('gev1').setIndex('expr', 'intop_int(rad.radopu(int,0))/intop_int(1)', 0);
model.result.numerical('gev1').setIndex('unit', 1, 0);
model.result.numerical('gev1').setIndex('descr', 'Interior to interior view factor', 0);
model.result.numerical('gev1').setIndex('expr', 'intop_ext(rad.radopd(int,0))/intop_int(1)', 1);
model.result.numerical('gev1').setIndex('unit', 1, 1);
model.result.numerical('gev1').setIndex('descr', 'Interior to exterior view factor', 1);
model.result.numerical('gev1').setIndex('expr', 'intop_ext(rad.radopd(0,ext))/intop_ext(1)', 2);
model.result.numerical('gev1').setIndex('unit', 1, 2);
model.result.numerical('gev1').setIndex('descr', 'Exterior to exterior view factor', 2);
model.result.numerical('gev1').setIndex('expr', 'intop_int(rad.radopu(0,ext))/intop_ext(1)', 3);
model.result.numerical('gev1').setIndex('unit', 1, 3);
model.result.numerical('gev1').setIndex('descr', 'Exterior to interior view factor', 3);
model.result.numerical.create('gev2', 'EvalGlobal');
model.result.numerical('gev2').label('Absolute Error, View Factors');
model.result.numerical('gev2').setIndex('expr', 'abs(intop_int(rad.radopu(int,0))/intop_int(1)-F_int_int)', 0);
model.result.numerical('gev2').setIndex('unit', 1, 0);
model.result.numerical('gev2').setIndex('descr', 'Absolute error, interior to interior view factor', 0);
model.result.numerical('gev2').setIndex('expr', 'abs(intop_ext(rad.radopd(int,0))/intop_int(1)-F_int_ext)', 1);
model.result.numerical('gev2').setIndex('unit', 1, 1);
model.result.numerical('gev2').setIndex('descr', 'Absolute error, interior to exterior view factor', 1);
model.result.numerical('gev2').setIndex('expr', 'abs(intop_ext(rad.radopd(0,ext))/intop_ext(1)-F_ext_ext)', 2);
model.result.numerical('gev2').setIndex('unit', 1, 2);
model.result.numerical('gev2').setIndex('descr', 'Absolute error, exterior to exterior view factor', 2);
model.result.numerical('gev2').setIndex('expr', 'abs(intop_int(rad.radopu(0,ext))/intop_ext(1)-F_ext_int)', 3);
model.result.numerical('gev2').setIndex('unit', 1, 3);
model.result.numerical('gev2').setIndex('descr', 'Absolute error, exterior to interior view factor', 3);
model.result.table.create('tbl1', 'Table');
model.result.table('tbl1').comments('View Factors');
model.result.numerical('gev1').set('table', 'tbl1');
model.result.numerical('gev1').setResult;
model.result.table.create('tbl2', 'Table');
model.result.table('tbl2').comments('Absolute Error, View Factors');
model.result.numerical('gev2').set('table', 'tbl2');
model.result.numerical('gev2').setResult;

model.geom('geom1').feature('del1').active(false);
model.geom('geom1').runPre('fin');

model.view.create('view2', 'geom1');
model.view('view2').model('comp1');
model.view('view2').hideObjects.create('hide1');
model.view('view2').hideObjects('hide1').init(2);
model.view('view2').hideObjects('hide1').set('sph2', 2);

model.geom('geom1').run;

model.physics('rad').feature('rsym1').active(false);

model.sol('sol1').study('std1');
model.sol('sol1').feature.remove('s1');
model.sol('sol1').feature.remove('v1');
model.sol('sol1').feature.remove('st1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'stat');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').feature('comp1_rad_dsurf2_Jd_band').set('scalemethod', 'init');
model.sol('sol1').feature('v1').feature('comp1_rad_dsurf2_Ju_band').set('scalemethod', 'init');
model.sol('sol1').feature('v1').feature('comp1_rad_dsurf1_Jd_band').set('scalemethod', 'init');
model.sol('sol1').feature('v1').feature('comp1_rad_dsurf1_Ju_band').set('scalemethod', 'init');
model.sol('sol1').feature('v1').set('control', 'stat');
model.sol('sol1').create('s1', 'Stationary');
model.sol('sol1').feature('s1').create('se1', 'Segregated');
model.sol('sol1').feature('s1').feature('se1').feature.remove('ssDef');
model.sol('sol1').feature('s1').feature('se1').create('ss1', 'SegregatedStep');
model.sol('sol1').feature('s1').feature('se1').feature('ss1').set('segvar', {'comp1_rad_dsurf1_Ju_band' 'comp1_rad_dsurf1_Jd_band' 'comp1_rad_dsurf2_Ju_band' 'comp1_rad_dsurf2_Jd_band'});
model.sol('sol1').feature('s1').feature('se1').feature('ss1').set('subdamp', 0.8);
model.sol('sol1').feature('s1').create('d1', 'Direct');
model.sol('sol1').feature('s1').feature('d1').set('linsolver', 'pardiso');
model.sol('sol1').feature('s1').feature('d1').set('pivotperturb', 1.0E-13);
model.sol('sol1').feature('s1').feature('d1').label('Direct, radiation variables');
model.sol('sol1').feature('s1').feature('se1').feature('ss1').set('linsolver', 'd1');
model.sol('sol1').feature('s1').feature('se1').feature('ss1').label('Radiosity');
model.sol('sol1').feature('s1').feature('se1').set('segstabacc', 'segaacc');
model.sol('sol1').feature('s1').feature('se1').set('segaaccdim', 10);
model.sol('sol1').feature('s1').feature('se1').set('ntolfact', 0.1);
model.sol('sol1').feature('s1').create('i1', 'Iterative');
model.sol('sol1').feature('s1').feature('i1').set('linsolver', 'gmres');
model.sol('sol1').feature('s1').feature('i1').set('prefuntype', 'left');
model.sol('sol1').feature('s1').feature('i1').set('rhob', 400);
model.sol('sol1').feature('s1').feature('i1').label('AMG, radiation variables');
model.sol('sol1').feature('s1').feature('i1').create('mg1', 'Multigrid');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').set('prefun', 'saamg');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').set('usesmooth', false);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').set('saamgcompwise', true);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('pr').create('so1', 'SOR');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('pr').feature('so1').set('iter', 2);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('pr').feature('so1').set('relax', 0.9);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('po').create('so1', 'SOR');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('po').feature('so1').set('iter', 2);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('po').feature('so1').set('relax', 0.9);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('cs').create('d1', 'Direct');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('cs').feature('d1').set('linsolver', 'pardiso');
model.sol('sol1').feature('s1').create('i2', 'Iterative');
model.sol('sol1').feature('s1').feature('i2').set('linsolver', 'gmres');
model.sol('sol1').feature('s1').feature('i2').set('prefuntype', 'left');
model.sol('sol1').feature('s1').feature('i2').set('rhob', 20);
model.sol('sol1').feature('s1').feature('i2').label('GMG, radiation variables');
model.sol('sol1').feature('s1').feature('i2').create('mg1', 'Multigrid');
model.sol('sol1').feature('s1').feature('i2').feature('mg1').set('prefun', 'gmg');
model.sol('sol1').feature('s1').feature('i2').feature('mg1').set('mcasegen', 'any');
model.sol('sol1').feature('s1').feature('i2').feature('mg1').feature('pr').create('so1', 'SOR');
model.sol('sol1').feature('s1').feature('i2').feature('mg1').feature('pr').feature('so1').set('iter', 2);
model.sol('sol1').feature('s1').feature('i2').feature('mg1').feature('po').create('so1', 'SOR');
model.sol('sol1').feature('s1').feature('i2').feature('mg1').feature('po').feature('so1').set('iter', 2);
model.sol('sol1').feature('s1').feature('i2').feature('mg1').feature('cs').create('d1', 'Direct');
model.sol('sol1').feature('s1').feature('i2').feature('mg1').feature('cs').feature('d1').set('linsolver', 'pardiso');
model.sol('sol1').feature('s1').feature.remove('fcDef');
model.sol('sol1').attach('std1');
model.sol('sol1').runFromTo('st1', 'v1');

model.result.numerical('gev1').set('table', 'tbl1');
model.result.numerical('gev1').appendResult;
model.result.numerical('gev2').set('table', 'tbl2');
model.result.numerical('gev2').appendResult;

model.title('View Factor Computation');

model.description('This benchmark demonstrates how to compute geometrical view factors for two concentric spheres that irradiate each other. It compares simulation results to exact analytical values.');

model.label('view_factor.mph');

model.modelNode.label('Components');

out = model;
