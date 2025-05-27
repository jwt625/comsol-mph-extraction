function out = model
%
% exhaust_manifold_create_fluid_domain.m
%
% Model exported on May 26 2025, 21:26 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/CAD_Import_Module/Tutorial_Examples');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 3);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.geom('geom1').geomRep('cadps');
model.geom('geom1').create('imp1', 'Import');
model.geom('geom1').feature('imp1').set('filename', 'exhaust_manifold.x_b');
model.geom('geom1').feature('imp1').importData;
model.geom('geom1').defeaturing('ReplaceFaces').selection('input').set('imp1(1)', [25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40 41 44 45 46 47 48 49 50 51 52 53 54 55 56 57 58 59 60 61 62 63 64 67 68 69 70 71 72 73 74 75 76 77 78 79 80 81 82 83 84 85 88 89 90 91 94 95]);
model.geom('geom1').defeaturing('ReplaceFaces').delete('rfa1');
model.geom('geom1').create('sel1', 'ExplicitSelection');
model.geom('geom1').feature('sel1').selection('selection').init(1);
model.geom('geom1').feature('sel1').set('groupcontang', true);
model.geom('geom1').feature('sel1').selection('selection').add('rfa1', [32 33]);
model.geom('geom1').feature('sel1').selection('selection').add('imp1(3)', [42 43 44 65 66 87 88 100 220 221 222 252 253 298 299 345 600 601 602 636 637 673 674 684 770 771 772 789 790 807 808 818]);
model.geom('geom1').run('sel1');
model.geom('geom1').create('uni1', 'Union');
model.geom('geom1').feature('uni1').selection('input').set({'imp1(2)' 'imp1(3)' 'rfa1'});
model.geom('geom1').run('uni1');
model.geom('geom1').measure.selection.set({'uni1'});
model.geom('geom1').run('imp1');
model.geom('geom1').defeaturing('DetectInterferences').find;
model.geom('geom1').defeaturing('DetectInterferences').localState(true);
model.geom('geom1').defeaturing('DetectInterferences').set('showingraphics', 'all');
model.geom('geom1').defeaturing('DetectInterferences').set('abstol', '0.7[mm]');
model.geom('geom1').defeaturing('DetectInterferences').find;
model.geom('geom1').defeaturing('DetectInterferences').localState(true);
model.geom('geom1').defeaturing('DetectInterferences').localState(false);

model.view('view1').hideObjects.create('hide1');
model.view('view1').hideObjects('hide1').init;
model.view('view1').hideObjects('hide1').add({'imp1(3)'});

model.geom('geom1').create('wp1', 'WorkPlane');
model.geom('geom1').feature('wp1').set('unite', true);
model.geom('geom1').feature('wp1').set('planetype', 'faceparallel');
model.geom('geom1').feature('wp1').selection('face').set('imp1(2)', 4);
model.geom('geom1').feature('wp1').label('gasket coordinate system');
model.geom('geom1').run('wp1');

model.view('view1').set('hidestatus', 'showonlyhidden');
model.view('view1').set('renderwireframe', true);

model.geom('geom1').create('wp2', 'WorkPlane');
model.geom('geom1').feature('wp2').set('unite', true);
model.geom('geom1').feature('wp2').set('planetype', 'faceparallel');
model.geom('geom1').feature('wp2').selection('face').set('imp1(3)', 83);
model.geom('geom1').feature('wp2').set('reverse', true);
model.geom('geom1').feature('wp2').label('manifold coordinate system');

model.view('view1').set('renderwireframe', false);
model.view('view1').set('hidestatus', 'hide');
model.view('view1').hideObjects.clear;

model.geom('geom1').run('wp2');
model.geom('geom1').create('rt1', 'RigidTransform');
model.geom('geom1').feature('rt1').selection('input').set({'imp1(2)'});
model.geom('geom1').feature('rt1').set('workplaneobj', 'wp1');
model.geom('geom1').feature('rt1').set('workplane', 'wp2');
model.geom('geom1').run('rt1');
model.geom('geom1').run('uni1');
model.geom('geom1').create('cap1', 'CapFaces');
model.geom('geom1').feature('cap1').selection('input').named('sel1');
model.geom('geom1').run('cap1');
model.geom('geom1').runPre('uni1');
model.geom('geom1').defeaturing('Fillets').set('entsize', 0.003);
model.geom('geom1').defeaturing('Fillets').find;
model.geom('geom1').defeaturing('Fillets').deleteAll('dfi1');
model.geom('geom1').defeaturing('Holes').set('entsize', '10[mm]');
model.geom('geom1').defeaturing('Holes').find;
model.geom('geom1').defeaturing('Holes').deleteAll('dho1');
model.geom('geom1').run('fin');
model.geom('geom1').create('rmd1', 'RemoveDetails');
model.geom('geom1').run('rmd1');
model.geom('geom1').feature('rmd1').set('automatic', true);

model.mesh('mesh1').autoMeshSize(4);
model.mesh('mesh1').run;

model.title('Creating a Fluid Domain Inside a Solid Structure');

model.description('This tutorial shows how to create a domain for the fluid volume inside an imported CAD assembly. You will also learn how to detect and resolve gaps and overlaps between the objects, and how to use the defeaturing tools for deleting fillets and through holes.');

model.mesh.clearMeshes;

model.label('exhaust_manifold_create_fluid_domain.mph');

model.modelNode.label('Components');

out = model;
