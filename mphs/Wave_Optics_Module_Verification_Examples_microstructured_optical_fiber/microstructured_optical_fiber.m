function out = model
%
% microstructured_optical_fiber.m
%
% Model exported on May 26 2025, 21:34 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/Wave_Optics_Module/Verification_Examples');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 2);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.physics.create('ewfd', 'ElectromagneticWavesFrequencyDomain', 'geom1');
model.physics('ewfd').model('comp1');

model.study.create('std1');
model.study('std1').create('mode', 'ModeAnalysis');
model.study('std1').feature('mode').set('shiftactive', false);
model.study('std1').feature('mode').set('conrad', '1');
model.study('std1').feature('mode').set('conradynhm', '1');
model.study('std1').feature('mode').set('linpsolnum', 'auto');
model.study('std1').feature('mode').set('outputmap', {});
model.study('std1').feature('mode').set('ngenAUX', '1');
model.study('std1').feature('mode').set('goalngenAUX', '1');
model.study('std1').feature('mode').set('ngenAUX', '1');
model.study('std1').feature('mode').set('goalngenAUX', '1');
model.study('std1').feature('mode').setSolveFor('/physics/ewfd', true);

% To import content from file, use:
% model.param.loadFile('FILENAME');
model.param.set('d', '5[um]', 'Hole diameter');
model.param.set('Delta', '6.75[um]', 'Hole separation');
model.param.set('rb', '10[um]', 'Radius for calculation domain');
model.param.set('nbg', '1.45', 'Background refractive index');
model.param.set('nair', '1', 'Air refractive index');
model.param.set('wl', '1.45[um]', 'Wavelength');
model.param.set('neffMax', '1.4454', 'Maximum expected effective index,');
model.param.set('neffMin', '1.429', 'Minimum expected effective index,');
model.param.set('wlr', 'wl/sqrt(nbg^2-neffMax^2)', 'Wavelength in the radial direction');

model.geom('geom1').create('c1', 'Circle');
model.geom('geom1').feature('c1').set('r', 'rb+wlr');
model.geom('geom1').feature('c1').setIndex('layername', 'Layer 1', 0);
model.geom('geom1').feature('c1').setIndex('layer', 'wlr', 0);
model.geom('geom1').run('c1');
model.geom('geom1').create('c2', 'Circle');
model.geom('geom1').feature('c2').set('r', 'd/2');
model.geom('geom1').feature('c2').set('pos', {'0' '-Delta'});
model.geom('geom1').selection.create('csel1', 'CumulativeSelection');
model.geom('geom1').selection('csel1').label('Air Holes');
model.geom('geom1').feature('c2').set('contributeto', 'csel1');
model.geom('geom1').run('c2');
model.geom('geom1').create('rot1', 'Rotate');
model.geom('geom1').feature('rot1').selection('input').set({'c2'});
model.geom('geom1').feature('rot1').set('rot', 'range(0,60,300)');
model.geom('geom1').feature('rot1').set('contributeto', 'csel1');
model.geom('geom1').runPre('fin');

model.selection.create('adj1', 'Adjacent');
model.selection('adj1').model('comp1');

model.geom('geom1').run;

model.selection('adj1').label('Air Hole Boundaries');
model.selection('adj1').set('input', {'geom1_csel1_dom'});

model.material.create('mat1', 'Common', 'comp1');
model.material('mat1').label('Silica');
model.material('mat1').propertyGroup.create('RefractiveIndex', 'Refractive_index');
model.material('mat1').propertyGroup('RefractiveIndex').set('n', {'nbg'});
model.material('mat1').propertyGroup('RefractiveIndex').set('ki', {'0'});
model.material.create('mat2', 'Common', 'comp1');
model.material('mat2').label('Air');
model.material('mat2').selection.named('geom1_csel1_dom');
model.material('mat2').propertyGroup.create('RefractiveIndex', 'Refractive_index');
model.material('mat2').propertyGroup('RefractiveIndex').set('n', {'nair'});
model.material('mat2').propertyGroup('RefractiveIndex').set('ki', {'0'});

model.coordSystem.create('pml1', 'geom1', 'PML');
model.coordSystem('pml1').selection.set([1 2 3 4]);
model.coordSystem('pml1').set('ScalingType', 'Cylindrical');
model.coordSystem('pml1').set('wavelengthSourceType', 'userDefined');
model.coordSystem('pml1').set('typicalWavelength', 'wlr');

model.study('std1').feature('mode').set('modeFreq', 'c_const/wl');
model.study('std1').feature('mode').set('eigmethod', 'region');
model.study('std1').feature('mode').set('appnreigs', 10);
model.study('std1').feature('mode').set('eigsr', 'neffMin');
model.study('std1').feature('mode').set('eiglr', 'neffMax');
model.study('std1').feature('mode').set('eigsi', '-3e-5');

model.mesh('mesh1').autoMeshSize(1);
model.mesh('mesh1').run;

model.sol.create('sol1');
model.sol('sol1').study('std1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'mode');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').set('control', 'mode');
model.sol('sol1').create('e1', 'Eigenvalue');
model.sol('sol1').feature('e1').set('neigs', 6);
model.sol('sol1').feature('e1').set('shift', '1');
model.sol('sol1').feature('e1').set('control', 'mode');
model.sol('sol1').feature('e1').feature('aDef').set('complexfun', true);
model.sol('sol1').feature('e1').feature('aDef').set('cachepattern', false);
model.sol('sol1').feature('e1').create('d1', 'Direct');
model.sol('sol1').feature('e1').feature('d1').set('linsolver', 'mumps');
model.sol('sol1').feature('e1').feature('d1').label('Suggested Direct Solver (ewfd)');
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
model.result('pg1').set('showlegends', false);
model.result('pg1').run;

model.view('view1').set('showgrid', false);

model.result.numerical.create('gev1', 'EvalGlobal');
model.result.numerical('gev1').set('expr', {'ewfd.neff'});
model.result.numerical('gev1').set('descr', {'Effective mode index'});
model.result.numerical('gev1').set('unit', {'1'});
model.result.table.create('tbl1', 'Table');
model.result.table('tbl1').comments('Global Evaluation 1');
model.result.numerical('gev1').set('table', 'tbl1');
model.result.numerical('gev1').setResult;

model.physics('ewfd').selection.set([5 6 7 8 9 10 11]);
model.physics('ewfd').create('sctr1', 'Scattering', 1);
model.physics('ewfd').feature('sctr1').selection.all;
model.physics('ewfd').feature('sctr1').set('WaveType', 'CylindricalWave');
model.physics('ewfd').feature('sctr1').set('UseReducedWaveNumber', true);

model.sol('sol1').study('std1');
model.sol('sol1').feature.remove('e1');
model.sol('sol1').feature.remove('v1');
model.sol('sol1').feature.remove('st1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'mode');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').set('control', 'mode');
model.sol('sol1').create('e1', 'Eigenvalue');
model.sol('sol1').feature('e1').set('neigs', 6);
model.sol('sol1').feature('e1').set('shift', '1');
model.sol('sol1').feature('e1').set('eigref', '0.5*(neffMin-3.0E-5*i+neffMax)');
model.sol('sol1').feature('e1').set('control', 'mode');
model.sol('sol1').feature('e1').feature('aDef').set('complexfun', true);
model.sol('sol1').feature('e1').feature('aDef').set('cachepattern', false);
model.sol('sol1').feature('e1').create('d1', 'Direct');
model.sol('sol1').feature('e1').feature('d1').set('linsolver', 'mumps');
model.sol('sol1').feature('e1').feature('d1').label('Suggested Direct Solver (ewfd)');
model.sol('sol1').attach('std1');
model.sol('sol1').runAll;

model.result('pg1').run;
model.result.numerical('gev1').set('table', 'tbl1');
model.result.numerical('gev1').appendResult;
model.result('pg1').run;
model.result('pg1').feature('surf1').set('expr', 'sqrt(abs(ewfd.Ex)^2+abs(ewfd.Ey)^2)');
model.result('pg1').feature.duplicate('surf2', 'surf1');
model.result('pg1').run;
model.result('pg1').feature('surf2').set('expr', '10*abs(ewfd.Ez)');
model.result('pg1').feature('surf2').set('inheritplot', 'surf1');
model.result('pg1').feature('surf2').create('trn1', 'Translation');
model.result('pg1').run;
model.result('pg1').feature('surf2').feature('trn1').set('trans', {'0' '-2.1*rb'});
model.result('pg1').feature('surf2').feature('trn1').set('applytodatasetedges', false);
model.result('pg1').run;
model.result('pg1').feature.duplicate('surf3', 'surf1');
model.result('pg1').feature.duplicate('surf4', 'surf2');
model.result('pg1').run;
model.result('pg1').feature('surf3').set('expr', 'sqrt(abs(ewfd.Hx)^2+abs(ewfd.Hy)^2)');
model.result('pg1').feature('surf3').create('trn1', 'Translation');
model.result('pg1').run;
model.result('pg1').feature('surf3').feature('trn1').set('trans', {'2.1*rb' '0'});
model.result('pg1').feature('surf3').feature('trn1').set('applytodatasetedges', false);
model.result('pg1').run;
model.result('pg1').feature('surf4').set('expr', '10*abs(ewfd.Hz)');
model.result('pg1').feature('surf4').set('inheritplot', 'surf3');
model.result('pg1').run;
model.result('pg1').feature('surf4').feature('trn1').set('trans', {'2.1*rb' '-2.1*rb'});
model.result('pg1').run;
model.result('pg1').set('titletype', 'manual');
model.result('pg1').set('title', 'Tangential and longitudinal electric and magnetic fields');
model.result('pg1').create('arws1', 'ArrowSurface');
model.result('pg1').feature('arws1').set('color', 'white');
model.result('pg1').feature('arws1').create('trn1', 'Translation');
model.result('pg1').run;
model.result('pg1').feature('arws1').feature('trn1').set('trans', {'2.1*rb' '0'});
model.result('pg1').feature('arws1').feature('trn1').set('applytodatasetedges', false);
model.result('pg1').run;
model.result('pg1').feature.duplicate('arws2', 'arws1');
model.result('pg1').run;
model.result('pg1').feature('arws2').set('expr', {'ewfd.Ex' 'ewfd.Ey'});
model.result('pg1').feature('arws2').set('descr', 'Electric field');
model.result('pg1').run;
model.result('pg1').feature('arws2').feature.remove('trn1');
model.result('pg1').run;
model.result('pg1').run;
model.result('pg1').set('phasetype', 'manual');
model.result('pg1').set('phase', 45);
model.result('pg1').set('edges', false);
model.result('pg1').create('line1', 'Line');
model.result('pg1').feature('line1').set('coloring', 'uniform');
model.result('pg1').feature('line1').set('color', 'black');
model.result('pg1').feature('line1').create('sel1', 'Selection');
model.result('pg1').feature('line1').feature('sel1').selection.named('adj1');
model.result('pg1').run;
model.result('pg1').feature.duplicate('line2', 'line1');
model.result('pg1').run;
model.result('pg1').feature('line2').create('trn1', 'Translation');
model.result('pg1').run;
model.result('pg1').feature('line2').feature('trn1').set('trans', {'2.1*rb' '0'});
model.result('pg1').run;
model.result('pg1').feature.duplicate('line3', 'line1');
model.result('pg1').feature.duplicate('line4', 'line2');
model.result('pg1').run;
model.result('pg1').feature('line3').create('trn1', 'Translation');
model.result('pg1').run;
model.result('pg1').feature('line3').feature('trn1').set('trans', {'0' '-2.1*rb'});
model.result('pg1').run;
model.result('pg1').feature('line4').feature('trn1').set('trans', {'2.1*rb' '-2.1*rb'});
model.result('pg1').run;
model.result('pg1').create('ann1', 'Annotation');
model.result('pg1').feature('ann1').set('text', 'Electric fields');
model.result('pg1').feature('ann1').set('posyexpr', '1.2*rb');
model.result('pg1').feature('ann1').set('showpoint', false);
model.result('pg1').feature('ann1').set('anchorpoint', 'center');
model.result('pg1').feature.duplicate('ann2', 'ann1');
model.result('pg1').run;
model.result('pg1').feature('ann2').set('text', 'Magnetic fields');
model.result('pg1').feature('ann2').set('posxexpr', '2.1*rb');
model.result('pg1').run;
model.result('pg1').feature.duplicate('ann3', 'ann1');
model.result('pg1').run;
model.result('pg1').feature('ann3').set('text', 'Tangential');
model.result('pg1').feature('ann3').set('posxexpr', '-1.1*rb');
model.result('pg1').feature('ann3').set('posyexpr', 0);
model.result('pg1').feature('ann3').set('anchorpoint', 'middleright');
model.result('pg1').feature.duplicate('ann4', 'ann3');
model.result('pg1').run;
model.result('pg1').feature('ann4').set('text', 'Longitudinal');
model.result('pg1').feature('ann4').set('posyexpr', '-2.1*rb');
model.result('pg1').run;
model.result('pg1').set('paramindicator', 'Effective mode index=eval(ewfd.neff)');
model.result('pg1').stepLast(0);
model.result('pg1').run;
model.result('pg1').stepPrevious(0);
model.result('pg1').run;
model.result('pg1').stepPrevious(0);
model.result('pg1').run;
model.result('pg1').stepPrevious(0);
model.result('pg1').run;
model.result('pg1').stepPrevious(0);
model.result('pg1').run;
model.result('pg1').stepPrevious(0);
model.result('pg1').run;
model.result('pg1').stepPrevious(0);
model.result('pg1').run;
model.result('pg1').stepPrevious(0);
model.result('pg1').run;
model.result('pg1').stepPrevious(0);
model.result('pg1').run;
model.result('pg1').stepPrevious(0);
model.result('pg1').run;

model.title('Leaky Modes in a Microstructured Optical Fiber');

model.description(['This model use a mode analysis study to find the complex effective indices of a microstructured optical fiber (MOF), consisting of air holes in a silica host. As the effective index is smaller than the refractive index of the silica background material, the modes are leaky.' newline  newline 'The model demonstrates both the use of a perfectly matched layer (PML) and the use of the Scattering boundary condition to truncate the simulation domain.' newline  newline 'The real and imaginary parts of the effective index compare well to values from a published paper.']);

model.label('microstructured_optical_fiber.mph');

model.modelNode.label('Components');

out = model;
