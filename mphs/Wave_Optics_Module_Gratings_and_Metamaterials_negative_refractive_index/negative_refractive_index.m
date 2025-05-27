function out = model
%
% negative_refractive_index.m
%
% Model exported on May 26 2025, 21:34 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/Wave_Optics_Module/Gratings_and_Metamaterials');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 2);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.physics.create('ewfd', 'ElectromagneticWavesFrequencyDomain', 'geom1');
model.physics('ewfd').model('comp1');

model.study.create('std1');
model.study('std1').create('freq', 'Frequency');
model.study('std1').feature('freq').set('solnum', 'auto');
model.study('std1').feature('freq').set('notsolnum', 'auto');
model.study('std1').feature('freq').set('outputmap', {});
model.study('std1').feature('freq').set('ngenAUX', '1');
model.study('std1').feature('freq').set('goalngenAUX', '1');
model.study('std1').feature('freq').set('ngenAUX', '1');
model.study('std1').feature('freq').set('goalngenAUX', '1');
model.study('std1').feature('freq').setSolveFor('/physics/ewfd', true);

% To import content from file, use:
% model.param.loadFile('FILENAME');
model.param.set('lda0', '1[m]', 'Wavelength, vacuum');
model.param.set('f0', 'c_const/lda0', 'Frequency');
model.param.set('e_a', '1', 'Relative permittivity, vacuum');
model.param.set('mu_a', '1', 'Relative permeability, vacuum');
model.param.set('e_b', '-1', 'Relative permittivity, metamaterial');
model.param.set('mu_b', '-1', 'Relative permeability, metamaterial');
model.param.set('n_a', 'sqrt(e_a*mu_a)', 'Refractive index, vacuum');
model.param.set('n_b', '-sqrt(e_b*mu_b)', 'Refractive index, metamaterial');
model.param.set('alpha', '30[deg]', 'Angle of incidence');

model.geom('geom1').create('r1', 'Rectangle');
model.geom('geom1').feature('r1').label('Two port model');
model.geom('geom1').feature('r1').set('size', [1 3]);
model.geom('geom1').feature('r1').setIndex('layername', 'Layer 1', 0);
model.geom('geom1').feature('r1').setIndex('layer', 1.5, 0);
model.geom('geom1').run('r1');
model.geom('geom1').create('r2', 'Rectangle');
model.geom('geom1').feature('r2').label('PML model');
model.geom('geom1').feature('r2').set('size', [1 4]);
model.geom('geom1').feature('r2').set('pos', [1.05 -1]);
model.geom('geom1').feature('r2').setIndex('layername', 'Layer 1', 0);
model.geom('geom1').feature('r2').setIndex('layer', 1, 0);
model.geom('geom1').feature('r2').setIndex('layername', 'Layer 2', 1);
model.geom('geom1').feature('r2').setIndex('layer', 1.5, 1);
model.geom('geom1').runPre('fin');
model.geom('geom1').run;

model.physics('ewfd').prop('components').set('components', 'outofplane');
model.physics('ewfd').feature('wee1').set('DisplacementFieldModel', 'RelativePermittivity');
model.physics('ewfd').create('port1', 'Port', 1);
model.physics('ewfd').feature('port1').selection.set([5]);
model.physics('ewfd').feature('port1').set('PortType', 'Periodic');
model.physics('ewfd').feature('port1').set('Eampl', [0 0 1]);
model.physics('ewfd').feature('port1').set('alpha_inc', 'alpha');
model.physics('ewfd').feature('port1').set('n', {'n_a' '0' '0' '0' 'n_a' '0' '0' '0' 'n_a'});
model.physics('ewfd').create('port2', 'Port', 1);
model.physics('ewfd').feature('port2').selection.set([2]);
model.physics('ewfd').feature('port2').set('PortType', 'Periodic');
model.physics('ewfd').feature('port2').set('Eampl', [0 0 1]);
model.physics('ewfd').feature('port2').set('n', {'n_b' '0' '0' '0' 'n_b' '0' '0' '0' 'n_b'});
model.physics('ewfd').create('pc1', 'PeriodicCondition', 1);
model.physics('ewfd').feature('pc1').selection.set([1 3 6 7]);
model.physics('ewfd').feature('pc1').set('PeriodicType', 'Floquet');
model.physics('ewfd').feature('pc1').set('Floquet_source', 'FromPeriodicPort');
model.physics('ewfd').create('port3', 'Port', 1);
model.physics('ewfd').feature('port3').selection.set([14]);
model.physics('ewfd').feature('port3').set('PortExcitation', 'on');
model.physics('ewfd').feature('port3').set('PortType', 'Periodic');
model.physics('ewfd').feature('port3').set('Eampl', [0 0 1]);
model.physics('ewfd').feature('port3').set('alpha_inc', 'alpha');
model.physics('ewfd').feature('port3').set('n', {'n_a' '0' '0' '0' 'n_a' '0' '0' '0' 'n_a'});
model.physics('ewfd').create('pc2', 'PeriodicCondition', 1);
model.physics('ewfd').feature('pc2').selection.set([8 10 12 15 16 17]);
model.physics('ewfd').feature('pc2').set('PeriodicType', 'Floquet');
model.physics('ewfd').feature('pc2').set('Floquet_source', 'FromPeriodicPort');

model.coordSystem.create('pml1', 'geom1', 'PML');
model.coordSystem('pml1').selection.set([3]);
model.coordSystem('pml1').set('PMLfactor', '-1');

model.physics('ewfd').create('trans1', 'TransitionBoundaryCondition', 1);
model.physics('ewfd').feature('trans1').selection.set([4 13]);
model.physics('ewfd').feature('trans1').set('DisplacementFieldModel', 'RelativePermittivity');
model.physics('ewfd').feature('trans1').set('murbnd_mat', 'userdef');
model.physics('ewfd').feature('trans1').set('murbnd', 'mu_a');
model.physics('ewfd').feature('trans1').set('epsilonr_mat', 'userdef');
model.physics('ewfd').feature('trans1').set('epsilonr', 'e_a');
model.physics('ewfd').feature('trans1').set('sigmabnd_mat', 'userdef');
model.physics('ewfd').feature('trans1').set('d', 'lda0/1000');

model.material.create('mat1', 'Common', 'comp1');
model.material('mat1').selection.set([2 5]);
model.material('mat1').propertyGroup('def').set('relpermittivity', {'e_a'});
model.material('mat1').propertyGroup('def').set('relpermeability', {'mu_a'});
model.material('mat1').propertyGroup('def').set('electricconductivity', {'0'});
model.material.create('mat2', 'Common', 'comp1');
model.material('mat2').selection.set([1 3 4]);
model.material('mat2').propertyGroup('def').set('relpermittivity', {'e_b'});
model.material('mat2').propertyGroup('def').set('relpermeability', {'mu_b'});
model.material('mat2').propertyGroup('def').set('electricconductivity', {'0'});

model.study('std1').feature('freq').set('plist', 'f0');

model.mesh('mesh1').run;

model.sol.create('sol1');
model.sol('sol1').study('std1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'freq');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').set('control', 'freq');
model.sol('sol1').create('s1', 'Stationary');
model.sol('sol1').feature('s1').set('stol', 0.01);
model.sol('sol1').feature('s1').create('p1', 'Parametric');
model.sol('sol1').feature('s1').feature.remove('pDef');
model.sol('sol1').feature('s1').feature('p1').set('pname', {'freq'});
model.sol('sol1').feature('s1').feature('p1').set('plistarr', {'f0'});
model.sol('sol1').feature('s1').feature('p1').set('punit', {'THz'});
model.sol('sol1').feature('s1').feature('p1').set('pcontinuationmode', 'no');
model.sol('sol1').feature('s1').feature('p1').set('preusesol', 'no');
model.sol('sol1').feature('s1').feature('p1').set('pdistrib', 'off');
model.sol('sol1').feature('s1').feature('p1').set('plot', 'off');
model.sol('sol1').feature('s1').feature('p1').set('plotgroup', 'Default');
model.sol('sol1').feature('s1').feature('p1').set('probesel', 'all');
model.sol('sol1').feature('s1').feature('p1').set('probes', {});
model.sol('sol1').feature('s1').feature('p1').set('control', 'freq');
model.sol('sol1').feature('s1').set('linpmethod', 'sol');
model.sol('sol1').feature('s1').set('linpsol', 'zero');
model.sol('sol1').feature('s1').set('control', 'freq');
model.sol('sol1').feature('s1').feature('aDef').set('complexfun', true);
model.sol('sol1').feature('s1').feature('aDef').set('cachepattern', false);
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
model.result('pg1').setIndex('looplevel', 1, 0);
model.result('pg1').set('defaultPlotID', 'ElectromagneticWavesFrequencyDomain/phys1/pdef1/pcond2/pg1');
model.result('pg1').feature.create('surf1', 'Surface');
model.result('pg1').feature('surf1').set('smooth', 'internal');
model.result('pg1').feature('surf1').set('data', 'parent');
model.result('pg1').run;
model.result.dataset('dset1').selection.geom('geom1', 2);
model.result.dataset('dset1').selection.geom('geom1', 2);
model.result.dataset('dset1').selection.set([1 2 4 5]);
model.result('pg1').run;
model.result('pg1').run;
model.result('pg1').feature('surf1').set('expr', 'Ez');
model.result('pg1').feature('surf1').set('colortable', 'WaveLight');
model.result('pg1').run;
model.result('pg1').create('con1', 'Contour');
model.result('pg1').feature('con1').set('expr', 'Ez');
model.result('pg1').feature('con1').set('number', 12);
model.result('pg1').feature('con1').set('colortable', 'GrayPrint');

model.title('Modeling a Negative Refractive Index');

model.description('By engineering a periodic structure with features comparable in scale to the wavelength, it is possible to obtain materials with negative permittivity and permeability. This example demonstrates how to model a domain of a metamaterial with negative permittivity and permeability in the bulk.');

model.mesh.clearMeshes;

model.sol('sol1').clearSolutionData;

model.label('negative_refractive_index.mph');

model.modelNode.label('Components');

out = model;
