function out = model
%
% photonic_crystal.m
%
% Model exported on May 26 2025, 21:34 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/Wave_Optics_Module/Couplers_Filters_and_Mirrors');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 2);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.physics.create('ewfd', 'ElectromagneticWavesFrequencyDomain', 'geom1');
model.physics('ewfd').model('comp1');

model.study.create('std1');
model.study('std1').create('wave', 'Wavelength');
model.study('std1').feature('wave').set('solnum', 'auto');
model.study('std1').feature('wave').set('notsolnum', 'auto');
model.study('std1').feature('wave').set('outputmap', {});
model.study('std1').feature('wave').set('ngenAUX', '1');
model.study('std1').feature('wave').set('goalngenAUX', '1');
model.study('std1').feature('wave').set('ngenAUX', '1');
model.study('std1').feature('wave').set('goalngenAUX', '1');
model.study('std1').feature('wave').setSolveFor('/physics/ewfd', true);

model.geom('geom1').create('imp1', 'Import');
model.geom('geom1').feature('imp1').set('filename', 'photonic_crystal.mphbin');
model.geom('geom1').feature('imp1').importData;
model.geom('geom1').run;

model.material.create('mat1', 'Common', 'comp1');
model.material('mat1').propertyGroup.create('RefractiveIndex', 'Refractive index');
model.material('mat1').propertyGroup('RefractiveIndex').func.create('an1', 'Analytic');
model.material('mat1').label('GaAs (Gallium arsenide) (Skauli et al. 2003: n 0.97-17 um)');
model.material('mat1').propertyGroup('RefractiveIndex').func('an1').set('expr', 'sqrt((5.372514)+(5.466742)*x^2/(x^2-(0.19636481728249))+(0.02429960)*x^2/(x^2-(0.76500440081209))+(1.957522)*x^2/(x^2-(1362.8353555600002)))');
model.material('mat1').propertyGroup('RefractiveIndex').func('an1').set('fununit', '1');
model.material('mat1').propertyGroup('RefractiveIndex').func('an1').set('argunit', {'um'});
model.material('mat1').propertyGroup('RefractiveIndex').set('n', {'an1(c_const/freq)' '0' '0' '0' 'an1(c_const/freq)' '0' '0' '0' 'an1(c_const/freq)'});
model.material('mat1').propertyGroup('RefractiveIndex').addInput('frequency');
model.material('mat1').selection.set([1 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40 41 42 43 44 45 46 47 48 49 50 51 52 53 54 55 56 57 58 59 60 61 62 63 64 65 66 67 68 69 70 71 72 73 74 75 76 77 78 79 80 81 82 83 84 85 86]);
model.material.create('mat2', 'Common', 'comp1');
model.material('mat2').label('Air');
model.material('mat2').selection.set([2]);
model.material('mat2').propertyGroup.create('RefractiveIndex', 'Refractive_index');
model.material('mat2').propertyGroup('RefractiveIndex').set('n', {'1'});

model.physics('ewfd').prop('components').set('components', 'outofplane');
model.physics('ewfd').create('sctr1', 'Scattering', 1);
model.physics('ewfd').feature('sctr1').selection.all;
model.physics('ewfd').create('sctr2', 'Scattering', 1);
model.physics('ewfd').feature('sctr2').selection.set([5]);
model.physics('ewfd').feature('sctr2').set('IncidentField', 'EField');
model.physics('ewfd').feature('sctr2').set('E0i', [0 0 1]);

model.study('std1').feature('wave').set('plist', '1[um] 1.3[um]');

model.sol.create('sol1');
model.sol('sol1').study('std1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'wave');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').set('control', 'wave');
model.sol('sol1').create('s1', 'Stationary');
model.sol('sol1').feature('s1').set('stol', 0.01);
model.sol('sol1').feature('s1').create('p1', 'Parametric');
model.sol('sol1').feature('s1').feature.remove('pDef');
model.sol('sol1').feature('s1').feature('p1').set('pname', {'lambda0'});
model.sol('sol1').feature('s1').feature('p1').set('plistarr', {'1[um] 1.3[um]'});
model.sol('sol1').feature('s1').feature('p1').set('punit', {[native2unicode(hex2dec({'00' 'b5'}), 'unicode') 'm']});
model.sol('sol1').feature('s1').feature('p1').set('pcontinuationmode', 'no');
model.sol('sol1').feature('s1').feature('p1').set('preusesol', 'no');
model.sol('sol1').feature('s1').feature('p1').set('pdistrib', 'off');
model.sol('sol1').feature('s1').feature('p1').set('plot', 'off');
model.sol('sol1').feature('s1').feature('p1').set('plotgroup', 'Default');
model.sol('sol1').feature('s1').feature('p1').set('probesel', 'all');
model.sol('sol1').feature('s1').feature('p1').set('probes', {});
model.sol('sol1').feature('s1').feature('p1').set('control', 'wave');
model.sol('sol1').feature('s1').set('control', 'wave');
model.sol('sol1').feature('s1').feature('aDef').set('complexfun', true);
model.sol('sol1').feature('s1').feature('aDef').set('cachepattern', true);
model.sol('sol1').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('s1').create('d1', 'Direct');
model.sol('sol1').feature('s1').feature('d1').set('linsolver', 'mumps');
model.sol('sol1').feature('s1').feature('d1').label('Suggested Direct Solver (ewfd)');
model.sol('sol1').feature('s1').feature('fc1').set('linsolver', 'd1');
model.sol('sol1').feature('s1').feature.remove('fcDef');
model.sol('sol1').attach('std1');
model.sol('sol1').runAll;

model.result.create('pg1', 'PlotGroup2D');
model.result('pg1').label('Electric Field (ewfd)');
model.result('pg1').set('frametype', 'spatial');
model.result('pg1').set('data', 'dset1');
model.result('pg1').setIndex('looplevel', 2, 0);
model.result('pg1').set('defaultPlotID', 'ElectromagneticWavesFrequencyDomain/phys1/pdef1/pcond2/pg1');
model.result('pg1').feature.create('surf1', 'Surface');
model.result('pg1').feature('surf1').set('smooth', 'internal');
model.result('pg1').feature('surf1').set('data', 'parent');
model.result('pg1').run;
model.result('pg1').setIndex('looplevel', 1, 0);
model.result('pg1').run;
model.result('pg1').run;
model.result('pg1').feature('surf1').set('expr', 'ewfd.Ez');
model.result('pg1').feature('surf1').set('descr', 'Electric field, z-component');
model.result('pg1').feature('surf1').set('colortable', 'WaveLight');
model.result('pg1').feature('surf1').set('colorscalemode', 'linearsymmetric');
model.result('pg1').run;
model.result.dataset.create('cln1', 'CutLine2D');
model.result.dataset('cln1').setIndex('genpoints', '0.75e-6', 0, 1);
model.result.dataset('cln1').setIndex('genpoints', '2.5e-6', 1, 0);
model.result.dataset('cln1').setIndex('genpoints', '0.75e-6', 1, 1);
model.result.create('pg2', 'PlotGroup1D');
model.result('pg2').run;
model.result('pg2').set('data', 'cln1');
model.result('pg2').create('lngr1', 'LineGraph');
model.result('pg2').feature('lngr1').set('markerpos', 'datapoints');
model.result('pg2').feature('lngr1').set('linewidth', 'preference');
model.result('pg2').run;

model.modelNode.create('comp2', true);

model.geom.create('geom2', 3);
model.geom('geom2').model('comp2');

model.mesh.create('mesh2', 'geom2');

model.geom('geom2').create('wp1', 'WorkPlane');
model.geom('geom2').feature('wp1').set('unite', true);
model.geom('geom2').feature('wp1').geom.create('imp1', 'Import');
model.geom('geom2').feature('wp1').geom.feature('imp1').set('filename', 'photonic_crystal.mphbin');
model.geom('geom2').feature('wp1').geom.feature('imp1').importData;
model.geom('geom2').run('wp1');
model.geom('geom2').feature.create('ext1', 'Extrude');
model.geom('geom2').feature('ext1').set('extrudefrom', 'faces');
model.geom('geom2').feature('ext1').setIndex('distance', '.0005[mm]', 0);
model.geom('geom2').feature('ext1').selection('inputface').set('wp1', [1 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40 41 42 43 44 45 46 47 48 49 50 51 52 53 54 55 56 57 58 59 60 61 62 63 64 65 66 67 68 69 70 71 72 73 74 75 76 77 78 79 80 81 82 83 84 85 86]);
model.geom('geom2').run('ext1');
model.geom('geom2').create('del1', 'Delete');
model.geom('geom2').feature('del1').selection('input').set('ext1', 6);
model.geom('geom2').run('del1');

model.study.create('std2');

model.sol.create('sol2');
model.sol('sol2').study('std2');
model.sol('sol2').create('st1', 'StudyStep');
model.sol('sol2').feature('st1').set('study', 'std2');
model.sol('sol2').create('v1', 'Variables');
model.sol('sol2').attach('std2');
model.sol('sol2').runAll;

model.result.dataset('dset2').set('comp', 'comp2');
model.result.create('pg3', 'PlotGroup3D');
model.result('pg3').run;
model.result('pg3').set('data', 'none');
model.result('pg3').create('surf1', 'Surface');
model.result('pg3').feature('surf1').set('data', 'dset2');
model.result('pg3').feature('surf1').set('expr', '1');
model.result('pg3').feature('surf1').set('coloring', 'uniform');
model.result('pg3').feature('surf1').set('color', 'gray');
model.result('pg3').feature('surf1').create('trn1', 'Translation');
model.result('pg3').run;
model.result('pg3').feature('surf1').feature('trn1').set('trans', {'0' '0' '-.2[um]'});
model.result('pg3').run;
model.result('pg3').create('surf2', 'Surface');
model.result('pg3').feature('surf2').set('data', 'dset1');
model.result('pg3').feature('surf2').setIndex('looplevel', 1, 0);
model.result('pg3').feature('surf2').set('expr', 'ewfd.normE');
model.result('pg3').feature('surf2').set('colortable', 'Wave');
model.result('pg3').feature('surf2').create('def1', 'Deform');
model.result('pg3').run;
model.result('pg3').feature('surf2').feature('def1').set('expr', {'ewfd.Ex' 'ewfd.Ey' ''});
model.result('pg3').feature('surf2').feature('def1').setIndex('expr', 'ewfd.Ez', 2);
model.result('pg3').feature('surf2').feature('def1').set('scaleactive', true);
model.result('pg3').feature('surf2').feature('def1').set('scale', '5e-7');
model.result('pg3').run;
model.result('pg3').create('line1', 'Line');
model.result('pg3').feature('line1').set('data', 'dset2');
model.result('pg3').feature('line1').set('expr', '1');
model.result('pg3').feature('line1').set('coloring', 'uniform');
model.result('pg3').feature('line1').set('color', 'black');
model.result('pg3').run;
model.result('pg3').feature('line1').create('trn1', 'Translation');
model.result('pg3').run;
model.result('pg3').feature('line1').feature('trn1').set('trans', {'0' '0' '-.2[um]'});
model.result('pg3').run;

model.view('view4').set('showgrid', false);

model.result('pg3').set('showlegends', false);

model.view('view4').set('showaxisorientation', false);

model.result('pg3').run;
model.result('pg3').set('titletype', 'none');
model.result.remove('pg3');

model.study.remove('std2');

model.view.remove('view4');

model.modelNode.remove('comp2');

model.result('pg2').run;

model.title('Photonic Crystal');

model.description('A photonic waveguide is created by removing some pillars in a photonic crystal structure. Depending on the distance between the pillars a photonic band gap is obtained. Within the photonic band gap, only waves within a specific frequency range will propagate through the outlined guide geometry.');

model.mesh.clearMeshes;

model.sol('sol1').clearSolutionData;

model.label('photonic_crystal.mph');

model.modelNode.label('Components');

out = model;
