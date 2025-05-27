function out = model
%
% magnetic_signature_submarine.m
%
% Model exported on May 26 2025, 21:25 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/ACDC_Module/Introductory_Magnetostatics');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 3);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.physics.create('mfnc', 'MagnetostaticsNoCurrents', 'geom1');
model.physics('mfnc').model('comp1');

model.study.create('std1');
model.study('std1').create('stat', 'Stationary');
model.study('std1').feature('stat').setSolveFor('/physics/mfnc', true);

model.param.set('gB', '-5e-5[T]');
model.param.descr('gB', 'Geomagnetic field');

model.geom('geom1').insertFile('magnetic_signature_submarine_geom_sequence.mph', 'geom1');
model.geom('geom1').feature('uni1').set('selresult', true);
model.geom('geom1').feature('uni1').set('selresultshow', 'bnd');
model.geom('geom1').run('fin');

model.view('view1').set('renderwireframe', true);

model.material.create('mat1', 'Common', 'comp1');
model.material('mat1').label('Domain material');
model.material('mat1').propertyGroup('def').set('relpermeability', {'1'});
model.material.create('mat2', 'Common', 'comp1');
model.material('mat2').label('Hull metal');
model.material('mat2').selection.geom('geom1', 2);
model.material('mat2').selection.named('geom1_uni1_bnd');
model.material('mat2').propertyGroup('def').set('relpermeability', {'700'});

model.physics('mfnc').prop('BackgroundField').set('SolveFor', 'ReducedField');
model.physics('mfnc').prop('BackgroundField').set('Hb', {'0' '0' 'gB/mu0_const'});
model.physics('mfnc').create('exfd1', 'ExternalMagneticFluxDensity', 2);
model.physics('mfnc').feature('exfd1').selection.all;
model.physics('mfnc').create('zsp1', 'ZeroMagneticScalarPotential', 0);
model.physics('mfnc').feature('zsp1').selection.set([3]);
model.physics('mfnc').create('ms1', 'MagneticShielding', 2);
model.physics('mfnc').feature('ms1').selection.named('geom1_uni1_bnd');
model.physics('mfnc').feature('ms1').set('ds', 0.05);

model.view('view1').set('renderwireframe', false);
model.view('view1').hideObjects.create('hide1');
model.view('view1').hideObjects('hide1').init(2);
model.view('view1').hideObjects('hide1').set('fin', [1 2 4]);

model.mesh('mesh1').autoMeshSize(3);
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
model.sol('sol1').feature('s1').feature('i1').set('linsolver', 'gmres');
model.sol('sol1').feature('s1').feature('i1').set('nlinnormuse', true);
model.sol('sol1').feature('s1').feature('i1').set('prefuntype', 'right');
model.sol('sol1').feature('s1').feature('i1').create('mg1', 'Multigrid');
model.sol('sol1').feature('s1').feature('fc1').set('linsolver', 'i1');
model.sol('sol1').feature('s1').feature.remove('fcDef');
model.sol('sol1').attach('std1');
model.sol('sol1').runAll;

model.result.create('pg1', 'PlotGroup3D');
model.result('pg1').run;
model.result('pg1').set('edges', false);
model.result('pg1').create('slc1', 'Slice');
model.result('pg1').feature('slc1').set('expr', 'mfnc.normB');
model.result('pg1').feature('slc1').set('descr', 'Magnetic flux density norm');
model.result('pg1').feature('slc1').set('quickplane', 'xy');
model.result('pg1').feature('slc1').set('quickzmethod', 'coord');
model.result('pg1').feature('slc1').set('quickz', -15);
model.result('pg1').feature('slc1').create('filt1', 'Filter');
model.result('pg1').run;
model.result('pg1').feature('slc1').feature('filt1').set('expr', 'abs(x)<(tl*.8)&&abs(y)<(r*5)');
model.result('pg1').run;
model.result('pg1').create('iso1', 'Isosurface');
model.result('pg1').feature('iso1').create('filt1', 'Filter');
model.result('pg1').run;
model.result('pg1').feature('iso1').feature('filt1').set('expr', 'x>0');
model.result('pg1').run;
model.result('pg1').create('surf1', 'Surface');
model.result('pg1').feature('surf1').set('expr', '1');
model.result('pg1').feature('surf1').set('coloring', 'uniform');
model.result('pg1').feature('surf1').set('color', 'black');
model.result('pg1').feature('surf1').create('sel1', 'Selection');
model.result('pg1').feature('surf1').feature('sel1').selection.named('geom1_uni1_bnd');
model.result('pg1').run;
model.result('pg1').create('arws1', 'ArrowSurface');
model.result('pg1').feature('arws1').set('expr', {'mfnc.tBx' 'mfnc.tBy' 'mfnc.tBz'});
model.result('pg1').feature('arws1').set('descr', 'Tangential magnetic flux density');
model.result('pg1').feature('arws1').set('color', 'white');
model.result('pg1').run;

model.title('Magnetic Signature of a Submarine');

model.description('A submarine traveling on the surface or under water gives rise to detectable local disturbances in Earth''s magnetic field that can be used for detection. An important step in the design of a naval ship is therefore to predict its magnetic signature. This example demonstrates a powerful technique that circumvents the difficulties associated with volumetric meshing of thin sheets and allows for accurate computations of the magnetic signatures of ships, cars, and other vehicles.');

model.mesh.clearMeshes;

model.sol('sol1').clearSolutionData;

model.label('magnetic_signature_submarine.mph');

model.modelNode.label('Components');

out = model;
