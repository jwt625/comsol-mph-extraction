function out = model
%
% plastic_strain_mapping.m
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

model.material.create('mat1', 'Common', '');
model.material('mat1').propertyGroup('def').set('youngsmodulus', {'70e9'});
model.material('mat1').propertyGroup('def').set('poissonsratio', {'0.2'});
model.material('mat1').propertyGroup('def').set('density', {'7850'});
model.material('mat1').propertyGroup.create('ElastoplasticModel', 'Elastoplastic_material_model');
model.material('mat1').propertyGroup('ElastoplasticModel').set('sigmags', {'243e6'});
model.material('mat1').propertyGroup('ElastoplasticModel').set('Et', {'2.171e9'});

model.param.set('para', '0');
model.param.descr('para', 'Horizontal load parameter');

model.func.create('int1', 'Interpolation');
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

model.material.create('matlnk1', 'Link', 'comp1');

model.physics('solid').prop('Type2D').set('Type2D', 'PlaneStress');
model.physics('solid').prop('d').set('d', '10[mm]');
model.physics('solid').feature('lemm1').create('plsty1', 'Plasticity', 2);
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
model.result('pg1').feature('surf1').set('colortable', 'Rainbow');
model.result('pg1').feature('surf1').set('colortabletrans', 'none');
model.result('pg1').feature('surf1').set('colorscalemode', 'linear');
model.result('pg1').feature('surf1').set('resolution', 'normal');
model.result('pg1').feature('surf1').set('colortable', 'Prism');
model.result('pg1').feature('surf1').create('def', 'Deform');
model.result('pg1').feature('surf1').feature('def').set('expr', {'u' 'v'});
model.result('pg1').feature('surf1').feature('def').set('descr', 'Displacement field');
model.result('pg1').run;
model.result('pg1').run;
model.result('pg1').label('Stress, Triangular Mesh');
model.result('pg1').set('edges', false);
model.result('pg1').create('mesh1', 'Mesh');
model.result('pg1').feature('mesh1').set('colortable', 'TrafficFlow');
model.result('pg1').feature('mesh1').set('colortabletrans', 'nonlinear');
model.result('pg1').feature('mesh1').set('nonlinearcolortablerev', true);
model.result('pg1').feature('mesh1').set('elemcolor', 'none');
model.result('pg1').feature('mesh1').create('def1', 'Deform');
model.result('pg1').run;
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
model.result('pg2').label('Plastic Region, Triangular Mesh');
model.result('pg2').run;
model.result('pg2').feature('surf1').set('expr', 'solid.epeGp>0');
model.result('pg2').feature('surf1').set('descr', 'solid.epeGp>0');
model.result('pg2').run;
model.result('pg2').create('mesh1', 'Mesh');
model.result('pg2').feature('mesh1').set('colortable', 'TrafficFlow');
model.result('pg2').feature('mesh1').set('colortabletrans', 'nonlinear');
model.result('pg2').feature('mesh1').set('nonlinearcolortablerev', true);
model.result('pg2').feature('mesh1').set('elemcolor', 'none');

model.modelNode.create('comp2', true);

model.geom.create('geom2', 2);
model.geom('geom2').model('comp2');

model.mesh.create('mesh2', 'geom2');

model.geom('geom2').create('imp1', 'Import');
model.geom('geom2').feature('imp1').set('type', 'sequence');
model.geom('geom2').feature('imp1').set('sequence', 'geom1');
model.geom('geom2').feature('imp1').importData;
model.geom('geom2').run;

model.material.create('matlnk2', 'Link', 'comp2');

model.physics.create('solid2', 'SolidMechanics', 'geom2');
model.physics('solid2').model('comp2');

model.study('std1').feature('stat').setSolveFor('/physics/solid2', true);

model.physics('solid2').prop('Type2D').set('Type2D', 'PlaneStress');
model.physics('solid2').prop('d').set('d', '10[mm]');
model.physics('solid2').feature('lemm1').create('plsty1', 'Plasticity', 2);
model.physics('solid2').feature('lemm1').feature('plsty1').create('setv1', 'SetVariables', 2);

model.cpl.create('genext1', 'GeneralExtrusion', 'geom1');
model.cpl('genext1').set('dstmap', {'X' 'Y'});
model.cpl('genext1').set('srcframe', 'material');
model.cpl('genext1').selection.set([1]);

model.physics('solid2').feature('lemm1').feature('plsty1').feature('setv1').set('SettingCondition', 'para<0.8001');
model.physics('solid2').feature('lemm1').feature('plsty1').feature('setv1').set('epeSet', 'comp1.genext1(solid.epe)');
model.physics('solid2').feature('lemm1').feature('plsty1').feature('setv1').set('epSet', {'comp1.genext1(solid.epXX)' 'comp1.genext1(solid.epXY)' '0' 'comp1.genext1(solid.epXY)' 'comp1.genext1(solid.epYY)' '0' '0' '0' 'comp1.genext1(solid.epZZ)'});
model.physics('solid2').create('sym1', 'SymmetrySolid', 1);
model.physics('solid2').feature('sym1').selection.set([1 3]);
model.physics('solid2').create('bndl1', 'BoundaryLoad', 1);
model.physics('solid2').feature('bndl1').selection.set([4]);
model.physics('solid2').feature('bndl1').set('FperArea', {'loadfunc(para)' '0' '0'});

model.mesh('mesh2').create('fq1', 'FreeQuad');
model.mesh('mesh2').feature('size').set('hauto', 3);
model.mesh('mesh2').feature('fq1').create('size1', 'Size');
model.mesh('mesh2').feature('fq1').feature('size1').selection.geom('geom2', 1);
model.mesh('mesh2').feature('fq1').feature('size1').selection.set([5]);
model.mesh('mesh2').feature('fq1').feature('size1').set('hauto', 2);
model.mesh('mesh2').run;

model.study.create('std2');
model.study('std2').create('stat', 'Stationary');
model.study('std2').feature('stat').setSolveFor('/physics/solid', true);
model.study('std2').feature('stat').setSolveFor('/physics/solid2', true);
model.study('std2').feature('stat').setEntry('activate', 'solid', false);
model.study('std2').feature('stat').set('useinitsol', true);
model.study('std2').feature('stat').set('initstudy', 'std1');
model.study('std2').feature('stat').set('solnum', 10);
model.study('std2').feature('stat').set('usesol', true);
model.study('std2').feature('stat').set('notsolmethod', 'sol');
model.study('std2').feature('stat').set('notstudy', 'std1');
model.study('std2').feature('stat').set('notsolnum', 10);
model.study('std2').feature('stat').set('useparam', true);
model.study('std2').feature('stat').setIndex('pname', 'para', 0);
model.study('std2').feature('stat').setIndex('plistarr', '', 0);
model.study('std2').feature('stat').setIndex('punit', '', 0);
model.study('std2').feature('stat').setIndex('pname', 'para', 0);
model.study('std2').feature('stat').setIndex('plistarr', '', 0);
model.study('std2').feature('stat').setIndex('punit', '', 0);
model.study('std2').feature('stat').setIndex('plistarr', 'range(0.80,0.05,2.2)', 0);
model.study('std2').feature('stat').setIndex('punit', '', 0);

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

model.result.create('pg3', 'PlotGroup2D');
model.result('pg3').set('data', 'dset3');
model.result('pg3').setIndex('looplevel', 29, 0);
model.result('pg3').set('defaultPlotID', 'stress');
model.result('pg3').label('Stress (solid2)');
model.result('pg3').set('frametype', 'spatial');
model.result('pg3').create('surf1', 'Surface');
model.result('pg3').feature('surf1').set('expr', {'solid2.misesGp'});
model.result('pg3').feature('surf1').set('threshold', 'manual');
model.result('pg3').feature('surf1').set('thresholdvalue', 0.2);
model.result('pg3').feature('surf1').set('colortable', 'Rainbow');
model.result('pg3').feature('surf1').set('colortabletrans', 'none');
model.result('pg3').feature('surf1').set('colorscalemode', 'linear');
model.result('pg3').feature('surf1').set('resolution', 'normal');
model.result('pg3').feature('surf1').set('colortable', 'Prism');
model.result('pg3').feature('surf1').create('def', 'Deform');
model.result('pg3').feature('surf1').feature('def').set('expr', {'u2' 'v2'});
model.result('pg3').feature('surf1').feature('def').set('descr', 'Displacement field');
model.result('pg3').run;
model.result('pg3').label('Stress, Quadrilateral Mesh');
model.result('pg3').set('edges', false);
model.result('pg3').create('mesh1', 'Mesh');
model.result('pg3').feature('mesh1').set('colortable', 'TrafficFlow');
model.result('pg3').feature('mesh1').set('colortabletrans', 'nonlinear');
model.result('pg3').feature('mesh1').set('nonlinearcolortablerev', true);
model.result('pg3').feature('mesh1').set('elemcolor', 'none');
model.result('pg3').feature('mesh1').create('def1', 'Deform');
model.result('pg3').run;
model.result.create('pg4', 'PlotGroup2D');
model.result('pg4').set('data', 'dset3');
model.result('pg4').setIndex('looplevel', 29, 0);
model.result('pg4').label('Equivalent Plastic Strain (solid2)');
model.result('pg4').set('defaultPlotID', 'equivalentPlasticStrain');
model.result('pg4').create('surf1', 'Surface');
model.result('pg4').feature('surf1').set('expr', {'solid2.epeGp'});
model.result('pg4').feature('surf1').set('inheritplot', 'none');
model.result('pg4').feature('surf1').set('resolution', 'normal');
model.result('pg4').feature('surf1').set('colortabletype', 'discrete');
model.result('pg4').feature('surf1').set('bandcount', 11);
model.result('pg4').feature('surf1').set('colortable', 'AuroraAustralisDark');
model.result('pg4').feature('surf1').set('descractive', true);
model.result('pg4').feature('surf1').set('descr', 'Equivalent plastic strain');
model.result('pg4').label('Equivalent Plastic Strain (solid2)');
model.result('pg4').run;
model.result('pg4').label('Plastic Region, Quadrilateral Mesh');
model.result('pg4').run;
model.result('pg4').feature('surf1').set('expr', 'solid2.epeGp>0');
model.result('pg4').feature('surf1').set('descr', 'solid2.epeGp>0');
model.result('pg4').run;
model.result('pg4').create('mesh1', 'Mesh');
model.result('pg4').feature('mesh1').set('colortable', 'TrafficFlow');
model.result('pg4').feature('mesh1').set('colortabletrans', 'nonlinear');
model.result('pg4').feature('mesh1').set('nonlinearcolortablerev', true);
model.result('pg4').feature('mesh1').set('elemcolor', 'none');

model.title('Plastic Strain Mapping');

model.description('This example shows the analysis of a perforated plate loaded into the plastic regime. The purpose of the analysis is to demonstrate how plastic strains can be mapped between dissimilar meshes.');

model.label('plastic_strain_mapping.mph');

model.modelNode.label('Components');

out = model;
