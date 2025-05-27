function out = model
%
% electric_sensor.m
%
% Model exported on May 26 2025, 21:26 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/COMSOL_Multiphysics/Electromagnetics');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 3);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.physics.create('es', 'Electrostatics', 'geom1');
model.physics('es').model('comp1');

model.study.create('std1');
model.study('std1').create('stat', 'Stationary');
model.study('std1').feature('stat').setSolveFor('/physics/es', true);

model.geom('geom1').create('wp1', 'WorkPlane');
model.geom('geom1').feature('wp1').set('unite', true);
model.geom('geom1').feature('wp1').set('quickz', 0.1);
model.geom('geom1').feature('wp1').geom.create('r1', 'Rectangle');
model.geom('geom1').feature('wp1').geom.feature('r1').set('size', [0.5 2]);
model.geom('geom1').feature('wp1').geom.feature('r1').set('pos', [-1 0.5]);
model.geom('geom1').feature('wp1').geom.run('r1');
model.geom('geom1').feature('wp1').geom.create('r2', 'Rectangle');
model.geom('geom1').feature('wp1').geom.feature('r2').set('size', [1.5 0.25]);
model.geom('geom1').feature('wp1').geom.feature('r2').set('pos', [-1.5 1]);
model.geom('geom1').feature('wp1').geom.run('r2');
model.geom('geom1').feature('wp1').geom.create('r3', 'Rectangle');
model.geom('geom1').feature('wp1').geom.feature('r3').set('size', [1.5 0.25]);
model.geom('geom1').feature('wp1').geom.feature('r3').set('pos', [-1.5 1.75]);
model.geom('geom1').feature('wp1').geom.run('r3');
model.geom('geom1').feature('wp1').geom.create('uni1', 'Union');
model.geom('geom1').feature('wp1').geom.feature('uni1').selection('input').set({'r1' 'r2' 'r3'});
model.geom('geom1').feature('wp1').geom.feature('uni1').set('intbnd', false);
model.geom('geom1').feature('wp1').geom.run('uni1');
model.geom('geom1').feature('wp1').geom.create('e1', 'Ellipse');
model.geom('geom1').feature('wp1').geom.feature('e1').set('semiaxes', [0.5 1]);
model.geom('geom1').feature('wp1').geom.feature('e1').set('pos', [1.5 1.5]);
model.geom('geom1').feature('wp1').geom.run('e1');
model.geom('geom1').feature('wp1').geom.create('e2', 'Ellipse');
model.geom('geom1').feature('wp1').geom.feature('e2').set('semiaxes', [1 0.5]);
model.geom('geom1').feature('wp1').geom.feature('e2').set('pos', [1.5 1.5]);
model.geom('geom1').feature('wp1').geom.run('e2');
model.geom('geom1').feature('wp1').geom.create('co1', 'Compose');
model.geom('geom1').feature('wp1').geom.feature('co1').selection('input').set({'e1' 'e2'});
model.geom('geom1').feature('wp1').geom.feature('co1').set('intbnd', false);
model.geom('geom1').feature('wp1').geom.feature('co1').set('formula', 'e1+e2');
model.geom('geom1').feature('wp1').geom.run('co1');
model.geom('geom1').run('wp1');
model.geom('geom1').feature.create('ext1', 'Extrude');
model.geom('geom1').feature('ext1').set('workplane', 'wp1');
model.geom('geom1').feature('ext1').selection('input').set({'wp1'});
model.geom('geom1').feature('ext1').setIndex('distance', 0.8, 0);
model.geom('geom1').run('ext1');
model.geom('geom1').create('blk1', 'Block');
model.geom('geom1').feature('blk1').set('size', [5 3 1]);
model.geom('geom1').feature('blk1').set('pos', [-2 0 0]);
model.geom('geom1').runPre('fin');

model.view('view1').set('transparency', true);

model.geom('geom1').run;

model.physics('es').create('gnd1', 'Ground', 2);
model.physics('es').feature('gnd1').selection.set([3]);
model.physics('es').create('pot1', 'ElectricPotential', 2);
model.physics('es').feature('pot1').selection.set([4]);
model.physics('es').feature('pot1').set('V0', 1);

model.material.create('mat1', 'Common', 'comp1');
model.material('mat1').propertyGroup('def').set('relpermittivity', {'1'});
model.material.create('mat2', 'Common', 'comp1');
model.material('mat2').selection.set([2]);
model.material('mat2').propertyGroup('def').set('relpermittivity', {'2'});
model.material.create('mat3', 'Common', 'comp1');
model.material('mat3').selection.set([3]);
model.material('mat3').propertyGroup('def').set('relpermittivity', {'3'});

model.mesh('mesh1').autoMeshSize(4);
model.mesh('mesh1').run;

model.study('std1').setGenPlots(false);

model.sol.create('sol1');
model.sol('sol1').study('std1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'stat');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').set('control', 'stat');
model.sol('sol1').create('s1', 'Stationary');
model.sol('sol1').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('s1').create('i1', 'Iterative');
model.sol('sol1').feature('s1').feature('i1').set('linsolver', 'cg');
model.sol('sol1').feature('s1').feature('i1').create('mg1', 'Multigrid');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').set('prefun', 'amg');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').set('coarseningmethod', 'classic');
model.sol('sol1').feature('s1').feature('fc1').set('linsolver', 'i1');
model.sol('sol1').feature('s1').feature.remove('fcDef');
model.sol('sol1').attach('std1');
model.sol('sol1').runAll;

model.result.dataset('dset1').selection.geom('geom1', 2);
model.result.dataset('dset1').selection.geom('geom1', 2);
model.result.dataset('dset1').selection.all;
model.result.dataset('dset1').selection.geom('geom1', 2);
model.result.dataset('dset1').selection.set([3 4 5 38]);

model.view('view1').set('transparency', false);

model.result.create('pg1', 'PlotGroup3D');
model.result('pg1').run;
model.result('pg1').create('surf1', 'Surface');
model.result('pg1').feature('surf1').set('expr', 'es.nD');
model.result('pg1').feature('surf1').set('descr', 'Surface charge density');
model.result('pg1').feature('surf1').set('unit', 'pC/m^2');
model.result('pg1').feature('surf1').set('colortable', 'Cyclic');
model.result('pg1').run;
model.result('pg1').run;
model.result('pg1').create('str1', 'Streamline');
model.result('pg1').feature('str1').set('posmethod', 'magnitude');
model.result('pg1').feature('str1').set('linetype', 'tube');
model.result('pg1').feature('str1').create('col1', 'Color');
model.result('pg1').run;
model.result('pg1').feature('str1').feature('col1').set('expr', 'es.normE');
model.result('pg1').feature('str1').feature('col1').set('descr', 'Electric field norm');
model.result('pg1').feature('str1').feature('col1').set('titletype', 'auto');

model.title('Electric Sensor');

model.description('This example shows how to image the interior permittivity of a box by applying a potential difference on the boundaries of the box. The result is a surface charge density that depends on the permittivity of the medium inside the box.');

model.mesh.clearMeshes;

model.sol('sol1').clearSolutionData;

model.label('electric_sensor.mph');

model.modelNode.label('Components');

out = model;
