function out = model
%
% beam_splitter.m
%
% Model exported on May 26 2025, 21:34 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/Wave_Optics_Module/Optical_Scattering');

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

model.param.set('lda0', '700[nm]');
model.param.descr('lda0', 'Vacuum wavelength');
model.param.set('lda', 'lda0/1.5');
model.param.descr('lda', 'Material wavelength');
model.param.set('f0', 'c_const/lda0');
model.param.descr('f0', 'Frequency');
model.param.set('eps_Ag', '-16.5-1.06*i');
model.param.descr('eps_Ag', 'Relative dielectric constant, Silver');
model.param.set('w0', '5*lda0');
model.param.descr('w0', 'Spot radius');

model.geom('geom1').lengthUnit([native2unicode(hex2dec({'00' 'b5'}), 'unicode') 'm']);
model.geom('geom1').create('pol1', 'Polygon');
model.geom('geom1').feature('pol1').set('source', 'table');
model.geom('geom1').feature('pol1').setIndex('table', -10, 0, 0);
model.geom('geom1').feature('pol1').setIndex('table', -10, 0, 1);
model.geom('geom1').feature('pol1').setIndex('table', -10, 1, 0);
model.geom('geom1').feature('pol1').setIndex('table', 10, 1, 1);
model.geom('geom1').feature('pol1').setIndex('table', 10, 2, 0);
model.geom('geom1').feature('pol1').setIndex('table', 10, 2, 1);
model.geom('geom1').run('pol1');
model.geom('geom1').create('rot1', 'Rotate');
model.geom('geom1').feature('rot1').selection('input').set({'pol1'});
model.geom('geom1').feature('rot1').set('keep', true);
model.geom('geom1').feature('rot1').set('rot', 180);
model.geom('geom1').runPre('fin');
model.geom('geom1').run;

model.physics('ewfd').prop('components').set('components', 'outofplane');
model.physics('ewfd').create('sctr1', 'Scattering', 1);
model.physics('ewfd').feature('sctr1').selection.set([1]);
model.physics('ewfd').feature('sctr1').set('IncidentField', 'GaussianBeam');
model.physics('ewfd').feature('sctr1').set('w0', 'w0');
model.physics('ewfd').feature('sctr1').set('Eg0', {'0' '0' '1[V/m]'});
model.physics('ewfd').create('sctr2', 'Scattering', 1);
model.physics('ewfd').feature('sctr2').selection.set([2 4 5]);
model.physics('ewfd').create('trans1', 'TransitionBoundaryCondition', 1);
model.physics('ewfd').feature('trans1').selection.set([3]);
model.physics('ewfd').feature('trans1').set('DisplacementFieldModel', 'RelativePermittivity');
model.physics('ewfd').feature('trans1').set('epsilonr_mat', 'userdef');
model.physics('ewfd').feature('trans1').set('epsilonr', 'eps_Ag');
model.physics('ewfd').feature('trans1').set('murbnd_mat', 'userdef');
model.physics('ewfd').feature('trans1').set('sigmabnd_mat', 'userdef');
model.physics('ewfd').feature('trans1').set('d', '13[nm]');

model.material.create('mat1', 'Common', 'comp1');
model.material('mat1').propertyGroup.create('RefractiveIndex', 'Refractive index');
model.material('mat1').label('Glass (quartz)');
model.material('mat1').set('family', 'custom');
model.material('mat1').set('customambient', [1 1 1]);
model.material('mat1').set('noise', true);
model.material('mat1').set('fresnel', 0.99);
model.material('mat1').set('roughness', 0.02);
model.material('mat1').set('metallic', 0);
model.material('mat1').set('pearl', 0);
model.material('mat1').set('diffusewrap', 0);
model.material('mat1').set('clearcoat', 0);
model.material('mat1').set('reflectance', 0);
model.material('mat1').propertyGroup('def').set('relpermeability', {'1' '0' '0' '0' '1' '0' '0' '0' '1'});
model.material('mat1').propertyGroup('def').set('electricconductivity', {'1e-14[S/m]' '0' '0' '0' '1e-14[S/m]' '0' '0' '0' '1e-14[S/m]'});
model.material('mat1').propertyGroup('def').set('relpermittivity', {'4.2' '0' '0' '0' '4.2' '0' '0' '0' '4.2'});
model.material('mat1').propertyGroup('def').set('density', '2210[kg/m^3]');
model.material('mat1').propertyGroup('def').set('thermalconductivity', {'1.4[W/(m*K)]' '0' '0' '0' '1.4[W/(m*K)]' '0' '0' '0' '1.4[W/(m*K)]'});
model.material('mat1').propertyGroup('def').set('heatcapacity', '730[J/(kg*K)]');
model.material('mat1').propertyGroup('RefractiveIndex').set('n', {'1.5' '0' '0' '0' '1.5' '0' '0' '0' '1.5'});

model.study('std1').feature('freq').set('plist', 'f0');

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
model.result.create('pg2', 'PlotGroup1D');
model.result('pg2').run;
model.result('pg2').create('lngr1', 'LineGraph');
model.result('pg2').feature('lngr1').set('markerpos', 'datapoints');
model.result('pg2').feature('lngr1').set('linewidth', 'preference');
model.result('pg2').feature('lngr1').selection.set([1]);
model.result('pg2').feature('lngr1').set('expr', '-ewfd.nPoav');
model.result('pg2').feature('lngr1').set('xdata', 'expr');
model.result('pg2').feature('lngr1').set('xdataexpr', 'y');
model.result('pg2').run;
model.result('pg2').create('lngr2', 'LineGraph');
model.result('pg2').feature('lngr2').set('markerpos', 'datapoints');
model.result('pg2').feature('lngr2').set('linewidth', 'preference');
model.result('pg2').feature('lngr2').selection.set([5]);
model.result('pg2').feature('lngr2').set('expr', 'ewfd.nPoav');
model.result('pg2').feature('lngr2').set('xdata', 'expr');
model.result('pg2').feature('lngr2').set('xdataexpr', 'y');
model.result('pg2').run;
model.result('pg2').create('lngr3', 'LineGraph');
model.result('pg2').feature('lngr3').set('markerpos', 'datapoints');
model.result('pg2').feature('lngr3').set('linewidth', 'preference');
model.result('pg2').feature('lngr3').selection.set([4]);
model.result('pg2').feature('lngr3').set('expr', 'ewfd.nPoav');
model.result('pg2').feature('lngr3').set('xdata', 'expr');
model.result('pg2').feature('lngr3').set('xdataexpr', 'x');
model.result('pg2').run;
model.result('pg2').create('lngr4', 'LineGraph');
model.result('pg2').feature('lngr4').set('markerpos', 'datapoints');
model.result('pg2').feature('lngr4').set('linewidth', 'preference');
model.result('pg2').feature('lngr4').selection.set([3]);
model.result('pg2').feature('lngr4').set('expr', 'ewfd.Qsrh');
model.result('pg2').feature('lngr4').set('xdata', 'expr');
model.result('pg2').feature('lngr4').set('xdataexpr', 'x');
model.result('pg2').run;

model.physics.create('ewbe', 'ElectromagneticWavesBeamEnvelopes', 'geom1');
model.physics('ewbe').model('comp1');

model.study('std1').feature('freq').setSolveFor('/physics/ewbe', true);

model.physics('ewbe').prop('components').set('components', 'outofplane');
model.physics('ewbe').prop('WaveVector').set('k1', {'ewbe.k' '0' '0'});
model.physics('ewbe').prop('WaveVector').set('k2', {'0' 'ewbe.k1x' '0'});
model.physics('ewbe').create('sctr1', 'Scattering', 1);
model.physics('ewbe').feature('sctr1').selection.set([1]);
model.physics('ewbe').feature('sctr1').set('IncidentField', 'GaussianBeam');
model.physics('ewbe').feature('sctr1').set('w0', 'w0');
model.physics('ewbe').feature('sctr1').set('Eg0', {'0' '0' '1[V/m]'});
model.physics('ewbe').create('sctr2', 'Scattering', 1);
model.physics('ewbe').feature('sctr2').selection.set([4]);
model.physics('ewbe').create('sctr3', 'Scattering', 1);
model.physics('ewbe').feature('sctr3').selection.set([2 5]);
model.physics('ewbe').feature('sctr3').set('inputWave', 'SecondWave');
model.physics('ewbe').create('trans1', 'TransitionBoundaryCondition', 1);
model.physics('ewbe').feature('trans1').selection.set([3]);
model.physics('ewbe').feature('trans1').set('DisplacementFieldModel', 'RelativePermittivity');
model.physics('ewbe').feature('trans1').set('epsilonr_mat', 'userdef');
model.physics('ewbe').feature('trans1').set('epsilonr', 'eps_Ag');
model.physics('ewbe').feature('trans1').set('murbnd_mat', 'userdef');
model.physics('ewbe').feature('trans1').set('sigmabnd_mat', 'userdef');
model.physics('ewbe').feature('trans1').set('d', '13[nm]');

model.mesh('mesh1').contribute('physics/ewbe', false);
model.mesh.create('mesh2', 'geom1');
model.mesh('mesh2').contribute('physics/ewfd', false);
model.mesh('mesh2').contribute('physics/ewbe', true);

model.physics('ewbe').prop('MeshControl').set('MeshType', 'Triangular');
model.physics('ewbe').prop('MeshControl').set('hMax', '2*lda0');

model.mesh('mesh2').run;

model.study.create('std2');
model.study('std2').create('freq', 'Frequency');
model.study('std2').feature('freq').set('plotgroup', 'Default');
model.study('std2').feature('freq').set('solnum', 'auto');
model.study('std2').feature('freq').set('notsolnum', 'auto');
model.study('std2').feature('freq').set('outputmap', {});
model.study('std2').feature('freq').set('ngenAUX', '1');
model.study('std2').feature('freq').set('goalngenAUX', '1');
model.study('std2').feature('freq').set('ngenAUX', '1');
model.study('std2').feature('freq').set('goalngenAUX', '1');
model.study('std2').feature('freq').setSolveFor('/physics/ewfd', false);
model.study('std2').feature('freq').setSolveFor('/physics/ewbe', true);
model.study('std2').feature('freq').set('plist', 'f0');

model.sol.create('sol2');
model.sol('sol2').study('std2');
model.sol('sol2').create('st1', 'StudyStep');
model.sol('sol2').feature('st1').set('study', 'std2');
model.sol('sol2').feature('st1').set('studystep', 'freq');
model.sol('sol2').create('v1', 'Variables');
model.sol('sol2').feature('v1').set('control', 'freq');
model.sol('sol2').create('s1', 'Stationary');
model.sol('sol2').feature('s1').create('p1', 'Parametric');
model.sol('sol2').feature('s1').feature.remove('pDef');
model.sol('sol2').feature('s1').feature('p1').set('pname', {'freq'});
model.sol('sol2').feature('s1').feature('p1').set('plistarr', {'f0'});
model.sol('sol2').feature('s1').feature('p1').set('punit', {'THz'});
model.sol('sol2').feature('s1').feature('p1').set('pcontinuationmode', 'no');
model.sol('sol2').feature('s1').feature('p1').set('preusesol', 'no');
model.sol('sol2').feature('s1').feature('p1').set('pdistrib', 'off');
model.sol('sol2').feature('s1').feature('p1').set('plot', 'off');
model.sol('sol2').feature('s1').feature('p1').set('plotgroup', 'Default');
model.sol('sol2').feature('s1').feature('p1').set('probesel', 'all');
model.sol('sol2').feature('s1').feature('p1').set('probes', {});
model.sol('sol2').feature('s1').feature('p1').set('control', 'freq');
model.sol('sol2').feature('s1').set('linpmethod', 'sol');
model.sol('sol2').feature('s1').set('linpsol', 'zero');
model.sol('sol2').feature('s1').set('control', 'freq');
model.sol('sol2').feature('s1').feature('aDef').set('complexfun', true);
model.sol('sol2').feature('s1').feature('aDef').set('cachepattern', false);
model.sol('sol2').feature('s1').feature('aDef').set('matherr', true);
model.sol('sol2').feature('s1').feature('aDef').set('blocksizeactive', false);
model.sol('sol2').feature('s1').feature('aDef').set('nullfun', 'auto');
model.sol('sol2').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol2').feature('s1').feature('fc1').set('linsolver', 'dDef');
model.sol('sol2').feature('s1').feature.remove('fcDef');
model.sol('sol2').attach('std2');
model.sol('sol2').runAll;

model.result.create('pg3', 'PlotGroup2D');
model.result('pg3').label('Electric Field (ewbe)');
model.result('pg3').set('data', 'dset2');
model.result('pg3').setIndex('looplevel', 1, 0);
model.result('pg3').set('data', 'dset2');
model.result('pg3').setIndex('looplevel', 1, 0);
model.result('pg3').set('defaultPlotID', 'ElectromagneticWavesBeamEnvelopes/phys1/pdef1/pcond2/pg1');
model.result('pg3').feature.create('surf1', 'Surface');
model.result('pg3').feature('surf1').label('Electric Field');
model.result('pg3').feature('surf1').set('expr', 'ewbe.normE');
model.result('pg3').feature('surf1').set('smooth', 'internal');
model.result('pg3').feature('surf1').set('data', 'parent');
model.result('pg3').run;
model.result('pg3').run;
model.result('pg3').feature('surf1').set('resolution', 'extrafine');
model.result('pg3').run;

model.mesh('mesh1').contribute('physics/ewbe', false);

model.study('std1').feature('freq').setEntry('activate', 'ewbe', false);

model.result('pg3').run;

model.title('Beam Splitter');

model.description('A beam splitter is used for splitting a beam of light in two. One way of making a splitter is to deposit a thin layer of metal between two glass prisms. The beam is slightly attenuated within the layer and then split into two paths. This example models the thin metal layer using a transition boundary condition, which reduces the memory requirements. Losses in the metal layer are also computed.');

model.mesh.clearMeshes;

model.sol('sol1').clearSolutionData;
model.sol('sol2').clearSolutionData;

model.label('beam_splitter.mph');

model.modelNode.label('Components');

out = model;
