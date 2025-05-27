function out = model
%
% photonic_crystal_filter_optimization.m
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

model.label('photonic_crystal.mph');

model.result('pg2').run;

model.probe.create('bnd1', 'Boundary');
model.probe('bnd1').model('comp1');
model.probe('bnd1').set('intsurface', true);
model.probe('bnd1').label('Objective Function');
model.probe('bnd1').set('probename', 'obj');
model.probe('bnd1').set('type', 'integral');
model.probe('bnd1').selection.set([45]);
model.probe('bnd1').set('expr', 'ewfd.nPoav');
model.probe('bnd1').set('descr', 'Power outflow, time average');

model.study('std1').feature('wave').set('probesel', 'none');
model.study('std1').label('Initial Design');

model.sol('sol1').study('std1');
model.sol('sol1').feature.remove('s1');
model.sol('sol1').feature.remove('v1');
model.sol('sol1').feature.remove('st1');
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
model.sol('sol1').feature('s1').feature('p1').set('plotgroup', 'pg1');
model.sol('sol1').feature('s1').feature('p1').set('probesel', 'none');
model.sol('sol1').feature('s1').feature('p1').set('probes', {'bnd1'});
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

model.result('pg1').run;
model.result.evaluationGroup.create('eg1', 'EvaluationGroup');
model.result.evaluationGroup('eg1').label('Transmission');
model.result.evaluationGroup('eg1').create('gev1', 'EvalGlobal');
model.result.evaluationGroup('eg1').feature('gev1').set('expr', {'obj'});
model.result.evaluationGroup('eg1').feature('gev1').set('descr', {'Objective Function'});
model.result.evaluationGroup('eg1').run;

model.geom('geom1').create('boxsel1', 'BoxSelection');
model.geom('geom1').feature('boxsel1').label('Domains to Move');
model.geom('geom1').feature('boxsel1').set('xmin', '0.2e-6');
model.geom('geom1').feature('boxsel1').set('xmax', '3.2e-6');
model.geom('geom1').feature('boxsel1').set('ymin', '0.2e-6');
model.geom('geom1').feature('boxsel1').set('ymax', '3.2e-6');
model.geom('geom1').feature('boxsel1').set('condition', 'inside');
model.geom('geom1').run('boxsel1');
model.geom('geom1').create('adjsel1', 'AdjacentSelection');
model.geom('geom1').feature('adjsel1').label('Deforming Domains');
model.geom('geom1').feature('adjsel1').set('outputdim', 2);
model.geom('geom1').feature('adjsel1').set('input', {'boxsel1'});

model.common.create('fsd1', 'FreeShapeDomain', 'comp1');
model.common('fsd1').selection.all;

model.geom('geom1').run;

model.common('fsd1').selection.named('geom1_adjsel1');
model.common.create('tsf1', 'Transformation', 'comp1');
model.common('tsf1').selection.named('geom1_boxsel1');
model.common('tsf1').set('moveType', 'Distance');
model.common('tsf1').set('maximumDisplacement', '0.1[um]');
model.common('tsf1').set('scalingType', 'No_scaling');

model.study.create('std2');
model.study('std2').create('wave', 'Wavelength');
model.study('std2').feature('wave').set('plotgroup', 'Default');
model.study('std2').feature('wave').set('solnum', 'auto');
model.study('std2').feature('wave').set('notsolnum', 'auto');
model.study('std2').feature('wave').set('outputmap', {});
model.study('std2').feature('wave').set('ngenAUX', '1');
model.study('std2').feature('wave').set('goalngenAUX', '1');
model.study('std2').feature('wave').set('ngenAUX', '1');
model.study('std2').feature('wave').set('goalngenAUX', '1');
model.study('std2').feature('wave').setSolveFor('/physics/ewfd', true);
model.study('std1').feature('wave').setEntry('activate', 'frame:material1', false);
model.study('std2').create('sho', 'ShapeOptimization');
model.study('std2').feature('sho').set('mmamaxiter', 20);
model.study('std2').feature('sho').set('movelimit', 0.2);
model.study('std2').feature('sho').setIndex('optobj', 'if(lambda0<1.15[um],-1,1)*log(comp1.obj[m/W])', 0);
model.study('std2').feature('sho').setIndex('descr', '', 0);
model.study('std2').feature('sho').set('objectivescaling', 'init');
model.study('std2').feature('sho').set('probesel', 'none');
model.study('std2').label('Shape Optimization');

model.sol.create('sol2');

model.mesh('mesh1').stat.selection.geom(2);
model.mesh('mesh1').stat.selection.set([2]);

model.sol('sol2').study('std2');
model.sol('sol2').create('st1', 'StudyStep');
model.sol('sol2').feature('st1').set('study', 'std2');
model.sol('sol2').feature('st1').set('studystep', 'wave');
model.sol('sol2').create('v1', 'Variables');
model.sol('sol2').feature('v1').feature('comp1_material_disp').set('scalemethod', 'manual');
model.sol('sol2').feature('v1').feature('comp1_material_disp').set('scaleval', '1.6895218258430397E-8');
model.sol('sol2').feature('v1').set('control', 'wave');
model.sol('sol2').create('o1', 'Optimization');
model.sol('sol2').feature('o1').set('control', 'sho');
model.sol('sol2').feature('o1').create('s1', 'StationaryAttrib');
model.sol('sol2').feature('o1').feature('s1').set('stol', 0.001);
model.sol('sol2').feature('o1').feature('s1').create('p1', 'Parametric');
model.sol('sol2').feature('o1').feature('s1').feature.remove('pDef');
model.sol('sol2').feature('o1').feature('s1').feature('p1').set('pname', {'lambda0'});
model.sol('sol2').feature('o1').feature('s1').feature('p1').set('plistarr', {'1[um]'});
model.sol('sol2').feature('o1').feature('s1').feature('p1').set('punit', {[native2unicode(hex2dec({'00' 'b5'}), 'unicode') 'm']});
model.sol('sol2').feature('o1').feature('s1').feature('p1').set('pcontinuationmode', 'no');
model.sol('sol2').feature('o1').feature('s1').feature('p1').set('preusesol', 'no');
model.sol('sol2').feature('o1').feature('s1').feature('p1').set('pdistrib', 'off');
model.sol('sol2').feature('o1').feature('s1').feature('p1').set('control', 'wave');
model.sol('sol2').feature('o1').feature('s1').set('control', 'wave');
model.sol('sol2').feature('o1').feature('s1').feature('aDef').set('complexfun', true);
model.sol('sol2').feature('o1').feature('s1').feature('aDef').set('cachepattern', false);
model.sol('sol2').feature('o1').feature('s1').create('seDef', 'Segregated');
model.sol('sol2').feature('o1').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol2').feature('o1').feature('s1').create('d1', 'Direct');
model.sol('sol2').feature('o1').feature('s1').feature('d1').set('linsolver', 'mumps');
model.sol('sol2').feature('o1').feature('s1').feature('d1').label('Suggested Direct Solver (ewfd) (Merged)');
model.sol('sol2').feature('o1').feature('s1').feature('fc1').set('linsolver', 'd1');
model.sol('sol2').feature('o1').feature('s1').feature.remove('fcDef');
model.sol('sol2').feature('o1').feature('s1').feature.remove('seDef');
model.sol('sol2').attach('std2');
model.sol('sol2').runFromTo('st1', 'v1');

model.result.create('pg3', 'PlotGroup2D');
model.result('pg3').label('Electric Field (ewfd) 1');
model.result('pg3').set('data', 'dset2');
model.result('pg3').set('frametype', 'spatial');
model.result('pg3').set('data', 'dset2');
model.result('pg3').set('defaultPlotID', 'ElectromagneticWavesFrequencyDomain/phys1/pdef1/pcond2/pg1');
model.result('pg3').feature.create('surf1', 'Surface');
model.result('pg3').feature('surf1').set('smooth', 'internal');
model.result('pg3').feature('surf1').set('data', 'parent');
model.result.create('pg4', 'PlotGroup2D');
model.result.dataset.duplicate('dset2g1', 'dset2');
model.result.dataset('dset2g1').label('Shape Optimization/Solution 2 (2) - Geometry');
model.result.dataset('dset2g1').set('frametype', 'geometry');
model.result('pg4').label('Shape Optimization');
model.result('pg4').set('data', 'dset2');
model.result('pg4').set('frametype', 'geometry');
model.result('pg4').set('edgecolor', 'gray');
model.result('pg4').set('titletype', 'none');
model.result('pg4').create('line1', 'Line');
model.result('pg4').feature('line1').set('expr', '1');
model.result('pg4').feature('line1').set('coloring', 'uniform');
model.result('pg4').feature('line1').set('color', 'fromtheme');
model.result('pg4').create('arwp1', 'ArrowPoint');
model.result('pg4').feature('arwp1').label('Translation (Transformation 1)');
model.result('pg4').feature('arwp1').set('expr', {'tsf1.moveXg' 'tsf1.moveYg'});
model.result('pg4').feature('arwp1').set('arrowbase', 'head');
model.result('pg4').feature('arwp1').set('scaleactive', true);
model.result('pg4').feature('arwp1').set('scale', '1');
model.result('pg4').feature('arwp1').create('def1', 'Deform');
model.result('pg4').feature('arwp1').feature('def1').set('expr', {'-tsf1.scaleXg-tsf1.rotateXg' '-tsf1.scaleYg-tsf1.rotateYg'});
model.result('pg4').feature('arwp1').feature('def1').set('scaleactive', true);
model.result('pg4').feature('arwp1').feature('def1').set('scale', '1');
model.result('pg4').feature('arwp1').create('col1', 'Color');
model.result('pg4').feature('arwp1').feature('col1').set('expr', 'tsf1.rel_move');
model.result('pg4').feature('arwp1').feature('col1').set('rangecoloractive', 'on');
model.result('pg4').feature('arwp1').feature('col1').set('rangecolormin', 0);
model.result('pg4').feature('arwp1').feature('col1').set('rangecolormax', 1);
model.result('pg4').create('arwp2', 'ArrowPoint');
model.result('pg4').feature('arwp2').label('Scaling (Transformation 1)');
model.result('pg4').feature('arwp2').set('expr', {'tsf1.scaleXg' 'tsf1.scaleYg'});
model.result('pg4').feature('arwp2').set('arrowbase', 'head');
model.result('pg4').feature('arwp2').set('scaleactive', true);
model.result('pg4').feature('arwp2').set('scale', '1');
model.result('pg4').feature('arwp2').set('inheritplot', 'arwp1');
model.result('pg4').feature('arwp2').create('def1', 'Deform');
model.result('pg4').feature('arwp2').feature('def1').set('expr', {'-tsf1.rotateXg' '-tsf1.rotateYg'});
model.result('pg4').feature('arwp2').feature('def1').set('scaleactive', true);
model.result('pg4').feature('arwp2').feature('def1').set('scale', '1');
model.result('pg4').feature('arwp2').create('col1', 'Color');
model.result('pg4').feature('arwp2').feature('col1').set('expr', 'tsf1.rel_scale');
model.result('pg4').feature('arwp2').feature('col1').set('rangecoloractive', 'on');
model.result('pg4').feature('arwp2').feature('col1').set('rangecolormin', 0);
model.result('pg4').feature('arwp2').feature('col1').set('rangecolormax', 1);
model.result('pg4').create('arwp3', 'ArrowPoint');
model.result('pg4').feature('arwp3').label('Rotation (Transformation 1)');
model.result('pg4').feature('arwp3').set('expr', {'tsf1.rotateXg' 'tsf1.rotateYg'});
model.result('pg4').feature('arwp3').set('arrowbase', 'head');
model.result('pg4').feature('arwp3').set('scaleactive', true);
model.result('pg4').feature('arwp3').set('scale', '1');
model.result('pg4').feature('arwp3').set('inheritplot', 'arwp1');
model.result('pg4').feature('arwp3').create('col1', 'Color');
model.result('pg4').feature('arwp3').feature('col1').set('expr', 'tsf1.rel_rotate');
model.result('pg4').feature('arwp3').feature('col1').set('rangecoloractive', 'on');
model.result('pg4').feature('arwp3').feature('col1').set('rangecolormin', 0);
model.result('pg4').feature('arwp3').feature('col1').set('rangecolormax', 1);
model.result('pg3').run;

model.study('std2').feature('sho').set('plot', true);
model.study('std2').feature('sho').set('plotgroup', 'pg4');

model.sol('sol2').feature('o1').set('nojacmethod', false);
model.sol('sol2').feature('o1').feature('s1').create('se1', 'Segregated');
model.sol('sol2').feature('o1').feature('s1').feature('se1').set('segterm', 'iter');
model.sol('sol2').feature('o1').feature('s1').feature('se1').create('ss1', 'SegregatedStep');
model.sol('sol2').feature('o1').feature('s1').feature('se1').feature('ss1').label('Electric Fields');
model.sol('sol2').feature('o1').feature('s1').feature('se1').feature('ss1').set('segvar', {'comp1_E' 'comp1_tsf1_move'});
model.sol('sol2').feature('o1').feature('s1').feature('se1').feature('ssDef').set('segvar', {'comp1_material_disp' 'comp1_tsf1_move'});
model.sol('sol2').feature('o1').feature('s1').feature('se1').feature('ssDef').label('Optimization');

model.study('std2').feature('wave').set('plist', '1[um] 1.3[um]');

model.sol('sol2').runAll;

model.result('pg3').run;

model.study('std2').feature('sho').set('probewindow', '');

model.result('pg3').run;
model.result('pg3').run;
model.result('pg3').feature('surf1').set('expr', 'ewfd.Ez');
model.result('pg3').feature('surf1').set('descr', 'Electric field, z-component');
model.result('pg3').feature('surf1').set('colortable', 'WaveLight');
model.result('pg3').run;
model.result('pg3').feature('surf1').stepPrevious(0);
model.result('pg3').run;
model.result.evaluationGroup('eg1').feature.duplicate('gev2', 'gev1');
model.result.evaluationGroup('eg1').feature('gev2').set('data', 'dset2');
model.result.evaluationGroup('eg1').run;
model.result.create('pg5', 'PlotGroup2D');
model.result('pg5').run;
model.result('pg5').label('Thumbnail');
model.result('pg5').set('edges', false);
model.result('pg5').create('line1', 'Line');
model.result('pg5').feature('line1').set('linetype', 'tube');
model.result('pg5').feature('line1').set('radiusexpr', '3e-9');
model.result('pg5').feature('line1').set('tuberadiusscaleactive', true);
model.result('pg5').feature('line1').set('coloring', 'uniform');
model.result('pg5').feature('line1').set('color', 'gray');
model.result('pg5').feature('line1').create('filt1', 'Filter');
model.result('pg5').run;
model.result('pg5').feature('line1').feature('filt1').set('expr', '(5e-7<Xg)*(Yg<28e-7)*(7e-7<Yg)');
model.result('pg5').run;
model.result('pg5').feature.duplicate('line2', 'line1');
model.result('pg5').run;
model.result('pg5').feature('line2').set('data', 'dset2');
model.result('pg5').feature('line2').set('color', 'black');
model.result('pg5').run;
model.result('pg5').create('arwl1', 'ArrowLine');
model.result('pg5').feature('arwl1').set('data', 'dset2');
model.result('pg5').feature('arwl1').set('expr', {'material.dX' 'ewfd.Hy'});
model.result('pg5').feature('arwl1').setIndex('expr', 'material.dY', 1);
model.result('pg5').feature('arwl1').set('arrowcount', '1e3');
model.result('pg5').feature('arwl1').set('arrowbase', 'head');
model.result('pg5').feature('arwl1').set('scaleactive', true);
model.result('pg5').run;
model.result('pg5').run;
model.result('pg5').feature('arwl1').feature.copy('filt1', 'pg5/line1/filt1');
model.result('pg5').run;
model.result('pg5').run;
model.result('pg5').feature('arwl1').create('col1', 'Color');
model.result('pg5').run;
model.result('pg5').feature('arwl1').feature('col1').set('expr', 'sqrt(material.dX^2+material.dY^2)');
model.result('pg5').feature('arwl1').feature('col1').set('colorlegend', false);
model.result('pg5').run;

model.title('Optimization of a Photonic Crystal for Signal Filtering');

model.description('This model builds on the photonic crystal model, where a photonic crystal structure is studied. This structure has a band gap, so only waves within a specific frequency range will propagate through the outlined guide geometry. This model changes the position of the pillars in order to maximize the ratio of the transmission at the desired frequency to the transmission at the undesired frequency.');

model.mesh.clearMeshes;

model.sol('sol1').clearSolutionData;
model.sol('sol2').clearSolutionData;

model.label('photonic_crystal_filter_optimization.mph');

model.modelNode.label('Components');

out = model;
