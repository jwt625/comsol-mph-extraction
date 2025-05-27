function out = model
%
% quadrupole_lens.m
%
% Model exported on May 26 2025, 21:25 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/ACDC_Module/Electromagnetics_and_Particle_Tracing');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 3);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.physics.create('mfnc', 'MagnetostaticsNoCurrents', 'geom1');
model.physics('mfnc').model('comp1');

model.study.create('std1');
model.study('std1').create('stat', 'Stationary');
model.study('std1').feature('stat').setSolveFor('/physics/mfnc', true);

model.geom('geom1').create('imp1', 'Import');
model.geom('geom1').feature('imp1').set('filename', 'quadrupole_lens.mphbin');
model.geom('geom1').feature('imp1').importData;

% To import content from file, use:
% model.param.loadFile('FILENAME');
model.param.set('M', '11', 'Ion mass number');
model.param.set('Zi', '5', 'Ion charge number');
model.param.set('vz', '0.01*3e8[m/s]', 'Ion velocity');
model.param.set('mp', '1.672e-27[kg]', 'Proton mass');
model.param.set('Ze', '1.602e-19[C]', 'Proton charge');
model.param.set('m', 'M*mp', 'Ion mass');
model.param.set('q', 'Zi*Ze', 'Ion charge');
model.param.set('Br', '8[mT]', 'Quadrupole remanent flux density');

model.geom('geom1').run;

model.material.create('mat1', 'Common', 'comp1');
model.material('mat1').label('Iron');
model.material('mat1').selection.set([1 2 3]);
model.material('mat1').propertyGroup('def').set('relpermeability', {'4000'});
model.material.create('mat2', 'Common', 'comp1');
model.material('mat2').label('Air');
model.material('mat2').selection.set([4 11 12 13]);
model.material('mat2').propertyGroup('def').set('relpermeability', {'1'});
model.material.create('mat3', 'Common', 'comp1');
model.material('mat3').label('Magnets');
model.material('mat3').selection.set([5 6 7 8 9 10 14 15 16 17 18 19]);
model.material('mat3').propertyGroup.create('RemanentFluxDensity', 'Remanent_flux_density');
model.material('mat3').propertyGroup('RemanentFluxDensity').set('murec', {'1.05'});
model.material('mat3').propertyGroup('RemanentFluxDensity').set('normBr', {'Br'});

model.view('view1').set('renderwireframe', true);

model.physics('mfnc').create('mag1', 'Magnet', 3);
model.physics('mfnc').feature('mag1').selection.set([5 6 7 8 9 10 14 15 16 17 18 19]);
model.physics('mfnc').feature('mag1').set('PatternType', 'CircularPattern');
model.physics('mfnc').feature('mag1').set('PeriodicType', 'Alternating');
model.physics('mfnc').feature('mag1').feature('north1').selection.set([18 56 58]);
model.physics('mfnc').feature('mag1').feature('south1').selection.set([15 21 57]);
model.physics('mfnc').create('zsp1', 'ZeroMagneticScalarPotential', 0);
model.physics('mfnc').feature('zsp1').selection.set([1]);

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
model.result('pg1').label('Magnetic Field');
model.result('pg1').create('slc1', 'Slice');
model.result('pg1').feature('slc1').set('quickxnumber', 1);
model.result('pg1').feature('slc1').set('expr', 'mfnc.Hx');
model.result('pg1').feature('slc1').set('descr', 'Magnetic field, x-component');
model.result('pg1').run;
model.result('pg1').run;
model.result('pg1').create('arwv1', 'ArrowVolume');
model.result('pg1').feature('arwv1').set('expr', {'mfnc.Hx' 'mfnc.Hy' 'mfnc.Hz'});
model.result('pg1').feature('arwv1').set('descr', 'Magnetic field');
model.result('pg1').feature('arwv1').set('xnumber', 4);
model.result('pg1').feature('arwv1').set('ynumber', 4);
model.result('pg1').feature('arwv1').set('znumber', 20);
model.result('pg1').feature('arwv1').set('color', 'black');
model.result('pg1').run;
model.result.create('pg2', 'PlotGroup3D');
model.result('pg2').run;
model.result('pg2').label('Ion Tracing');
model.result('pg2').create('ptr1', 'ParticleMass');
model.result('pg2').feature('ptr1').setIndex('const', 'q', 0, 1);
model.result('pg2').feature('ptr1').set('mass', 'm');
model.result('pg2').feature('ptr1').set('velstartz', 'vz');
model.result('pg2').feature('ptr1').set('xcoord', '0.03*cos(range(0,0.05*pi,2*pi))');
model.result('pg2').feature('ptr1').set('ycoord', '0.03*sin(range(0,0.05*pi,2*pi))');
model.result('pg2').feature('ptr1').set('zcoord', 0.01);
model.result('pg2').feature('ptr1').set('linetype', 'tube');
model.result('pg2').feature('ptr1').set('tuberadiusscaleactive', true);
model.result('pg2').feature('ptr1').set('radiusexpr', '0.001');
model.result('pg2').feature('ptr1').set('rtol', '1e-6');
model.result('pg2').run;
model.result('pg2').feature('ptr1').create('col1', 'Color');
model.result('pg2').run;
model.result('pg2').feature('ptr1').feature('col1').set('expr', 'q*vz*mfnc.normB');
model.result('pg2').run;

model.view('view1').label('Default View');
model.view.create('view2', 'geom1');
model.view('view2').model('comp1');
model.view('view2').label('Scaled View');
model.view('view2').camera.set('viewscaletype', 'automatic');

model.result('pg2').run;
model.result('pg2').set('view', 'view2');
model.result('pg2').run;
model.result('pg1').run;
model.result('pg1').set('view', 'view1');
model.result('pg1').run;
model.result('pg2').run;

model.view('view2').camera.setIndex('viewoffset', 0, 0);

model.result('pg2').run;

model.view('view2').camera.setIndex('position', -23, 0);
model.view('view2').camera.setIndex('position', -31, 1);
model.view('view2').camera.setIndex('viewoffset', 0, 1);
model.view('view2').camera.set('zoomanglefull', 12);

model.result('pg2').run;

model.title('Quadrupole Lens');

model.description('An accelerated beam of B5+ ions is traced as it passes through a focusing system of three magnetic quadrupoles.');

model.mesh.clearMeshes;

model.sol('sol1').clearSolutionData;

model.label('quadrupole_lens.mph');

model.modelNode.label('Components');

out = model;
