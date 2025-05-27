function out = model
%
% total_internal_reflection.m
%
% Model exported on May 26 2025, 21:34 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/Wave_Optics_Module/Waveguides');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 2);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.physics.create('ewbe', 'ElectromagneticWavesBeamEnvelopes', 'geom1');
model.physics('ewbe').model('comp1');

model.study.create('std1');
model.study('std1').create('wave', 'Wavelength');
model.study('std1').feature('wave').set('solnum', 'auto');
model.study('std1').feature('wave').set('notsolnum', 'auto');
model.study('std1').feature('wave').set('outputmap', {});
model.study('std1').feature('wave').set('ngenAUX', '1');
model.study('std1').feature('wave').set('goalngenAUX', '1');
model.study('std1').feature('wave').set('ngenAUX', '1');
model.study('std1').feature('wave').set('goalngenAUX', '1');
model.study('std1').feature('wave').setSolveFor('/physics/ewbe', true);

model.param.set('lda0', '1[um]');
model.param.descr('lda0', 'Wavelength');
model.param.set('k0', '2*pi/lda0');
model.param.descr('k0', 'Vacuum wave number');
model.param.set('n', '1.5');
model.param.descr('n', 'Refractive index in waveguide');
model.param.set('k', 'k0*n');
model.param.descr('k', 'Wave number in waveguide');
model.param.set('theta', '10[deg]');
model.param.descr('theta', 'Incidence angle');
model.param.set('k1x', 'k*cos(theta)');
model.param.descr('k1x', 'Wave vector, first wave, x-component');
model.param.set('k1y', 'k*sin(theta)');
model.param.descr('k1y', 'Wave vector, first wave, y-component');
model.param.set('d', '350[um]');
model.param.descr('d', 'Waveguide width');
model.param.set('L', '5*4*d/2/tan(theta)');
model.param.descr('L', 'Waveguide length');
model.param.set('w0', '75[um]');
model.param.descr('w0', 'Beam radius');

model.view('view1').axis.set('viewscaletype', 'manual');
model.view('view1').axis.set('yscale', 10);

model.geom('geom1').create('r1', 'Rectangle');
model.geom('geom1').lengthUnit([native2unicode(hex2dec({'00' 'b5'}), 'unicode') 'm']);
model.geom('geom1').feature('r1').set('size', {'L' 'd'});
model.geom('geom1').feature('r1').set('pos', {'0' '-d/2'});
model.geom('geom1').runPre('fin');
model.geom('geom1').run;

model.material.create('mat1', 'Common', 'comp1');
model.material('mat1').propertyGroup.create('RefractiveIndex', 'Refractive_index');
model.material('mat1').propertyGroup('RefractiveIndex').set('n', {'n'});
model.material('mat1').propertyGroup('RefractiveIndex').set('ki', {'0'});

model.physics('ewbe').prop('components').set('components', 'outofplane');
model.physics('ewbe').prop('WaveVector').set('k1', {'k1x' 'k1y' '0'});
model.physics('ewbe').prop('WaveVector').set('k2', {'ewbe.k1x' '-ewbe.k1y' '0'});
model.physics('ewbe').create('mbc1', 'MatchedBoundaryCondition', 1);
model.physics('ewbe').feature('mbc1').selection.set([1]);
model.physics('ewbe').feature('mbc1').set('IncidentField', 'GaussianBeam');
model.physics('ewbe').feature('mbc1').set('w0', 'w0');
model.physics('ewbe').feature('mbc1').set('Eg0', {'0' '0' '1[V/m]'});
model.physics('ewbe').feature('mbc1').set('NoScatteredField', true);
model.physics('ewbe').create('mbc2', 'MatchedBoundaryCondition', 1);
model.physics('ewbe').feature('mbc2').selection.set([4]);
model.physics('ewbe').feature('mbc2').set('InputWave', 'SecondWave');
model.physics('ewbe').create('imp1', 'Impedance', 1);
model.physics('ewbe').feature('imp1').selection.set([2 3]);
model.physics('ewbe').feature('imp1').set('PropagationDirection', 'FromWaveVector');
model.physics('ewbe').feature('imp1').set('n_mat', 'userdef');
model.physics('ewbe').feature('imp1').set('ki_mat', 'userdef');
model.physics('ewbe').prop('MeshControl').set('elemCountT', 100);
model.physics('ewbe').prop('MeshControl').set('elemCountL', 400);

model.study('std1').feature('wave').set('plist', 'lda0');

model.sol.create('sol1');
model.sol('sol1').study('std1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'wave');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').set('control', 'wave');
model.sol('sol1').create('s1', 'Stationary');
model.sol('sol1').feature('s1').create('p1', 'Parametric');
model.sol('sol1').feature('s1').feature.remove('pDef');
model.sol('sol1').feature('s1').feature('p1').set('pname', {'lambda0'});
model.sol('sol1').feature('s1').feature('p1').set('plistarr', {'lda0'});
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
model.sol('sol1').feature('s1').feature('aDef').set('cachepattern', false);
model.sol('sol1').feature('s1').feature('aDef').set('matherr', true);
model.sol('sol1').feature('s1').feature('aDef').set('blocksizeactive', false);
model.sol('sol1').feature('s1').feature('aDef').set('nullfun', 'auto');
model.sol('sol1').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('s1').feature('fc1').set('linsolver', 'dDef');
model.sol('sol1').feature('s1').feature.remove('fcDef');
model.sol('sol1').attach('std1');
model.sol('sol1').runAll;

model.result.create('pg1', 'PlotGroup2D');
model.result('pg1').label('Electric Field (ewbe)');
model.result('pg1').set('data', 'dset1');
model.result('pg1').setIndex('looplevel', 1, 0);
model.result('pg1').set('defaultPlotID', 'ElectromagneticWavesBeamEnvelopes/phys1/pdef1/pcond2/pg1');
model.result('pg1').feature.create('surf1', 'Surface');
model.result('pg1').feature('surf1').label('Electric Field');
model.result('pg1').feature('surf1').set('smooth', 'internal');
model.result('pg1').feature('surf1').set('data', 'parent');
model.result('pg1').run;
model.result('pg1').run;
model.result('pg1').feature('surf1').set('resolution', 'extrafine');
model.result('pg1').run;
model.result.create('pg2', 'PlotGroup2D');
model.result('pg2').run;
model.result('pg2').label('Electric Field, First Wave');
model.result('pg2').create('surf1', 'Surface');
model.result('pg2').feature('surf1').set('expr', 'ewbe.normE1');
model.result('pg2').run;
model.result.create('pg3', 'PlotGroup2D');
model.result('pg3').run;
model.result('pg3').label('Electric Field, Second Wave');
model.result('pg3').create('surf1', 'Surface');
model.result('pg3').feature('surf1').set('expr', 'ewbe.normE2');
model.result('pg3').run;
model.result('pg1').run;
model.result.duplicate('pg4', 'pg1');
model.result('pg4').run;
model.result('pg4').label('Electric Field, Perspective View');
model.result('pg4').run;
model.result('pg4').feature('surf1').set('recover', 'ppr');
model.result('pg4').feature('surf1').create('hght1', 'Height');
model.result('pg4').run;
model.result('pg4').feature('surf1').feature('hght1').set('isheightaxisshown', false);

model.view('view2').camera.set('viewscaletype', 'manual');
model.view('view2').camera.set('yscale', 20);
model.view('view2').camera.set('zscale', 0.1);

model.result('pg4').run;

model.title('Total Internal Reflection');

model.description(['This model demonstrates that the bidirectional formulation of the Electromagnetic Waves, Beam Envelopes interface can be used for simulating a beam being reflected in two main directions as it propagates along a waveguide.' newline  newline 'An almost collimated Gaussian beam is excited at the left boundary and exhibits total internal reflection (TIR) at the interface between the waveguide and the surrounding air. The beam exits the waveguide after propagating along the waveguide for 20' native2unicode(hex2dec({'00' 'a0'}), 'unicode') 'mm.' newline  newline 'This type of light guides is useful for virtual reality (VR) simulation.']);

model.mesh.clearMeshes;

model.sol('sol1').clearSolutionData;

model.label('total_internal_reflection.mph');

model.modelNode.label('Components');

out = model;
