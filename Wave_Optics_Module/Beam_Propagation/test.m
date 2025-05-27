function out = model
%
% test.m
%
% Model exported on May 26 2025, 20:27 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/Wave_Optics_Module/Beam_Propagation');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 3);
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
model.param.set('w0', '10*lda0');
model.param.descr('w0', 'Spot radius');
model.param.set('zR', 'pi*w0^2/lda0');
model.param.descr('zR', 'Rayleigh range');
model.param.set('E0', '1[V/m]');
model.param.descr('E0', 'Electric field amplitude');

model.geom('geom1').create('cyl1', 'Cylinder');
model.geom('geom1').feature('cyl1').set('r', '3*w0');
model.geom('geom1').feature('cyl1').set('h', '3*lda0');
model.geom('geom1').feature('cyl1').set('axistype', 'x');
model.geom('geom1').runPre('fin');

model.view('view1').camera.set('viewscaletype', 'manual');
model.view('view1').camera.set('xscale', 50);

model.geom('geom1').run;

model.material.create('mat1', 'Common', 'comp1');
model.material('mat1').label('Air');
model.material('mat1').propertyGroup.create('RefractiveIndex', 'Refractive_index');
model.material('mat1').propertyGroup('RefractiveIndex').set('n', {'1'});
model.material('mat1').propertyGroup('RefractiveIndex').set('ki', {'0'});

model.func.create('an1', 'Analytic');
model.func('an1').model('comp1');
model.func('an1').label('Spot Radius');
model.func('an1').set('funcname', 'w');
model.func('an1').set('expr', 'w0*sqrt(1+(x/zR)^2)');
model.func('an1').setIndex('argunit', 'm', 0);
model.func('an1').set('fununit', 'm');

model.variable.create('var1');
model.variable('var1').model('comp1');
model.variable('var1').label('Beam Variables');
model.variable('var1').set('rho', 'sqrt(y^2+z^2)');
model.variable('var1').descr('rho', 'Transverse radial coordinate');
model.variable('var1').set('phi', 'atan2(y,z)');
model.variable('var1').descr('phi', 'Transverse azimuthal coordinate');
model.variable('var1').set('EG0', 'E0*rho*sqrt(2)/w(x)*exp(j*phi)*exp(j*atan(x/zR))');
model.variable('var1').descr('EG0', 'Gaussian beam amplitude');
model.variable.create('var2');
model.variable('var2').model('comp1');
model.variable('var2').label('Plot Variables');
model.variable('var2').set('argEy', 'arg(ewbe.Ey)');
model.variable('var2').descr('argEy', 'Complex argument of the y-component of the electric field');
model.variable('var2').set('argWindow', 'if(argEy<-pi/2,-2*pi,if(argEy>pi/2,2*pi,argEy))');
model.variable('var2').descr('argWindow', 'Complex argument in the range [-pi/2,pi/2]');

model.physics('ewbe').prop('WaveVector').set('dirCount', 'UniDirectionality');
model.physics('ewbe').prop('ShapeProperty').set('shapeorder', '2t2');
model.physics('ewbe').create('mbc1', 'MatchedBoundaryCondition', 2);
model.physics('ewbe').feature('mbc1').selection.set([1]);
model.physics('ewbe').feature('mbc1').set('IncidentField', 'GaussianBeam');
model.physics('ewbe').feature('mbc1').set('w0', 'w0');
model.physics('ewbe').feature('mbc1').set('Eg0', {'0' 'EG0' '0'});
model.physics('ewbe').create('mbc2', 'MatchedBoundaryCondition', 2);
model.physics('ewbe').feature('mbc2').selection.set([6]);

model.mesh('mesh1').run;

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

model.result.create('pg1', 'PlotGroup3D');
model.result('pg1').label('Electric Field (ewbe)');
model.result('pg1').set('data', 'dset1');
model.result('pg1').setIndex('looplevel', 1, 0);
model.result('pg1').set('defaultPlotID', 'ElectromagneticWavesBeamEnvelopes/phys1/pdef1/pcond1/pg1');
model.result('pg1').feature.create('mslc1', 'Multislice');
model.result('pg1').feature('mslc1').label('Electric Field');
model.result('pg1').feature('mslc1').set('showsolutionparams', 'on');
model.result('pg1').feature('mslc1').set('smooth', 'internal');
model.result('pg1').feature('mslc1').set('showsolutionparams', 'on');
model.result('pg1').feature('mslc1').set('data', 'parent');
model.result('pg1').run;
model.result('pg1').create('mslc2', 'Multislice');
model.result('pg1').feature('mslc2').set('expr', 'argEy');
model.result('pg1').feature('mslc2').set('xnumber', '5');
model.result('pg1').feature('mslc2').set('ynumber', '0');
model.result('pg1').feature('mslc2').set('znumber', '0');
model.result('pg1').run;
model.result('pg1').feature('mslc2').create('filt1', 'Filter');
model.result('pg1').run;
model.result('pg1').feature('mslc2').feature('filt1').set('expr', 'rho<2.5*w0');
model.result('pg1').run;
model.result('pg1').feature('mslc1').set('xnumber', '0');
model.result('pg1').run;
model.result('pg1').feature('mslc1').active(false);
model.result('pg1').run;
model.result('pg1').run;
model.result.create('pg2', 'PlotGroup3D');
model.result('pg2').run;
model.result('pg2').label('Phase Plot');
model.result('pg2').set('edgecolor', 'gray');
model.result('pg2').create('iso1', 'Isosurface');
model.result('pg2').feature('iso1').set('expr', 'argWindow');
model.result('pg2').feature('iso1').set('number', 1);
model.result('pg2').feature('iso1').set('resolution', 'finer');
model.result('pg2').feature('iso1').set('useder', false);
model.result('pg2').feature('iso1').create('filt1', 'Filter');
model.result('pg2').run;
model.result('pg2').feature('iso1').feature('filt1').set('expr', 'rho<2.5*w0&&abs(arg(ewbe.Ey))<pi/2');
model.result('pg2').run;
model.result('pg2').feature('iso1').create('col1', 'Color');
model.result('pg2').run;
model.result('pg2').feature('iso1').feature('col1').set('expr', 'ewbe.Ey');
model.result('pg2').feature('iso1').feature('col1').set('colortable', 'HeatCameraLight');
model.result('pg2').run;

model.view.create('view2', 3);
model.view('view2').camera.set('viewscaletype', 'automatic');

model.result('pg2').run;
model.result('pg2').set('view', 'view2');
model.result('pg2').run;
model.result('pg2').create('surf1', 'Surface');
model.result('pg2').feature('surf1').set('expr', 'ewbe.Ey');
model.result('pg2').feature('surf1').set('titletype', 'none');
model.result('pg2').feature('surf1').set('colortable', 'Cividis');
model.result('pg2').feature('surf1').set('colorlegend', false);
model.result('pg2').feature('surf1').create('sel1', 'Selection');
model.result('pg2').feature('surf1').feature('sel1').selection.set([2 4 5]);
model.result('pg2').run;
model.result('pg2').feature.duplicate('surf2', 'surf1');
model.result('pg2').run;
model.result('pg2').run;
model.result('pg2').feature('surf2').feature('sel1').selection.set([6]);
model.result('pg2').run;
model.result.export.create('anim1', 'Animation');
model.result.export('anim1').set('target', 'player');
model.result.export('anim1').set('plotgroup', 'pg2');
model.result.export('anim1').set('sweeptype', 'dde');
model.result.export('anim1').set('repeat', 'forever');

model.title('Orbital Angular Momentum Beam');

model.description(['This model simulates a Laguerre Gaussian beam with the Electromagnetic Waves, Beam Envelopes interface, using the unidirectional wave formulation. The input beam is a focusing Gaussian beam with a spiral phase distribution.' newline  newline 'This phase distribution produces a Gaussian donut beam. The phase rotates around the optical axis as the beam propagates. The resulting beam is called a vortex beam.']);

model.mesh.clearMeshes;

model.sol('sol1').clearSolutionData;

model.label('orbital_angular_momentum.mph');

model.modelNode.label('Components');

out = model;
