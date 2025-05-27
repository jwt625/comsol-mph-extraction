function out = model
%
% focusing_lens.m
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
model.study('std1').create('wave', 'Wavelength');
model.study('std1').feature('wave').set('solnum', 'auto');
model.study('std1').feature('wave').set('notsolnum', 'auto');
model.study('std1').feature('wave').set('outputmap', {});
model.study('std1').feature('wave').set('ngenAUX', '1');
model.study('std1').feature('wave').set('goalngenAUX', '1');
model.study('std1').feature('wave').set('ngenAUX', '1');
model.study('std1').feature('wave').set('goalngenAUX', '1');
model.study('std1').feature('wave').setSolveFor('/physics/ewfd', true);

% To import content from file, use:
% model.param.loadFile('FILENAME');
model.param.set('wl', '1[um]', 'Wavelength');
model.param.set('k', '2*pi/wl', 'Wave number');
model.param.set('w', '50[um]', 'Beam half size');
model.param.set('n_lens', '1.5', 'Refractive index of lens');
model.param.set('W_lens', '15[um]', 'Lens thickness');
model.param.set('H', '200[um]', 'Domain height');
model.param.set('R', '500[um]', 'Lens radius of curvature');
model.param.set('W_air', '1100[um]', 'Air domain size');
model.param.set('f', '0.94[mm]', 'Focus position');
model.param.set('n_AR', 'sqrt(n_lens)', 'Refractive index of AR coating');
model.param.set('d_AR', 'wl/4/n_AR', 'Thickness of AR coating');

model.geom('geom1').lengthUnit('mm');
model.geom('geom1').create('r1', 'Rectangle');
model.geom('geom1').feature('r1').set('size', {'W_lens' 'H'});
model.geom('geom1').feature('r1').set('pos', {'0' '-H/2'});
model.geom('geom1').run('r1');
model.geom('geom1').create('c1', 'Circle');
model.geom('geom1').feature('c1').set('r', 'R');
model.geom('geom1').feature('c1').set('pos', {'R+1[um]' '0'});
model.geom('geom1').run('c1');
model.geom('geom1').create('par1', 'Partition');
model.geom('geom1').feature('par1').selection('input').set({'r1'});
model.geom('geom1').feature('par1').selection('tool').set({'c1'});
model.geom('geom1').run('par1');
model.geom('geom1').create('r2', 'Rectangle');
model.geom('geom1').feature('r2').set('size', {'W_air' 'H'});
model.geom('geom1').feature('r2').set('pos', {'W_lens' '-H/2'});
model.geom('geom1').feature('r2').setIndex('layername', 'Layer 1', 0);
model.geom('geom1').feature('r2').setIndex('layer', 'wl', 0);
model.geom('geom1').feature('r2').set('layerright', true);
model.geom('geom1').feature('r2').set('layertop', true);
model.geom('geom1').runPre('fin');

model.selection.create('sel1', 'Explicit');
model.selection('sel1').model('comp1');

model.geom('geom1').run;

model.selection('sel1').label('Air');
model.selection('sel1').set([1 3 4 5 6 7 8]);
model.selection.create('sel2', 'Explicit');
model.selection('sel2').model('comp1');
model.selection('sel2').label('Lens');
model.selection('sel2').set([2]);
model.selection.create('sel3', 'Explicit');
model.selection('sel3').model('comp1');
model.selection('sel3').label('Near Field');
model.selection('sel3').geom(1);
model.selection('sel3').set([6 8 10]);
model.selection.create('adj1', 'Adjacent');
model.selection('adj1').model('comp1');
model.selection('adj1').label('Boundaries Adjacent to Air');
model.selection('adj1').set('input', {'sel1'});
model.selection.create('adj2', 'Adjacent');
model.selection('adj2').model('comp1');
model.selection('adj2').label('Boundaries Adjacent to the Lens');
model.selection('adj2').set('input', {'sel2'});
model.selection.create('int1', 'Intersection');
model.selection('int1').model('comp1');
model.selection('int1').label('Boundaries Adjacent to Both Air and the Lens');
model.selection('int1').set('entitydim', 1);
model.selection('int1').set('input', {'adj1' 'adj2'});
model.selection.create('sel4', 'Explicit');
model.selection('sel4').model('comp1');
model.selection('sel4').label('PMLs');
model.selection('sel4').set([3 5 6 7 8]);
model.selection.create('sel5', 'Explicit');
model.selection('sel5').model('comp1');
model.selection('sel5').label('Input Boundary');
model.selection('sel5').geom(1);
model.selection('sel5').set([1]);

model.variable.create('var1');
model.variable('var1').model('comp1');
model.variable('var1').set('n', '1');
model.variable('var1').descr('n', 'Air');
model.variable('var1').selection.geom('geom1', 2);
model.variable('var1').selection.named('sel1');
model.variable.create('var2');
model.variable('var2').model('comp1');
model.variable('var2').set('n', 'n_lens', 'Air');
model.variable('var2').descr('n', 'Lens');
model.variable('var2').selection.geom('geom1', 2);
model.variable('var2').selection.named('sel2');

model.cpl.create('intop1', 'Integration', 'geom1');
model.cpl('intop1').set('axisym', true);
model.cpl('intop1').selection.geom('geom1', 1);
model.cpl('intop1').selection.named('sel3');

model.material.create('mat1', 'Common', 'comp1');
model.material('mat1').label('Air');
model.material('mat1').selection.named('sel1');
model.material('mat1').propertyGroup.create('RefractiveIndex', 'Refractive_index');
model.material('mat1').propertyGroup('RefractiveIndex').set('n', {'1'});
model.material('mat1').propertyGroup('RefractiveIndex').set('ki', {'0'});
model.material.create('mat2', 'Common', 'comp1');
model.material('mat2').label('Glass');
model.material('mat2').selection.named('sel2');
model.material('mat2').propertyGroup.create('RefractiveIndex', 'Refractive_index');
model.material('mat2').propertyGroup('RefractiveIndex').set('n', {'n_lens'});
model.material('mat2').propertyGroup('RefractiveIndex').set('ki', {'0'});

model.physics('ewfd').selection.set([1 2]);
model.physics('ewfd').prop('components').set('components', 'outofplane');
model.physics('ewfd').create('sctr1', 'Scattering', 1);
model.physics('ewfd').feature('sctr1').selection.named('sel5');
model.physics('ewfd').feature('sctr1').set('IncidentField', 'EField');
model.physics('ewfd').feature('sctr1').set('E0i', {'0' '0' '1[V/m]*(abs(y)<w)'});
model.physics('ewfd').create('sctr2', 'Scattering', 1);
model.physics('ewfd').feature('sctr2').selection.named('sel3');
model.physics('ewfd').create('trans1', 'TransitionBoundaryCondition', 1);
model.physics('ewfd').feature('trans1').selection.named('adj2');
model.physics('ewfd').feature('trans1').set('d', 'd_AR');

model.material.create('mat3', 'Common', 'comp1');
model.material('mat3').label('AR Coating');
model.material('mat3').selection.geom('geom1', 1);
model.material('mat3').selection.named('adj2');
model.material('mat3').propertyGroup.create('RefractiveIndex', 'Refractive_index');
model.material('mat3').propertyGroup('RefractiveIndex').set('n', {'n_AR'});
model.material('mat3').propertyGroup('RefractiveIndex').set('ki', {'0'});

model.study('std1').feature('wave').set('plist', 'wl');

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
model.sol('sol1').feature('s1').feature('p1').set('plistarr', {'wl'});
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

model.view.create('view2', 'geom1');
model.view('view2').model('comp1');
model.view('view2').axis.set('viewscaletype', 'manual');
model.view('view2').axis.set('xscale', 2);

model.result('pg1').run;
model.result('pg1').set('view', 'view2');
model.result('pg1').run;
model.result('pg1').feature('surf1').set('expr', 'ewfd.Ez');
model.result('pg1').feature('surf1').set('colortable', 'WaveLight');
model.result.create('pg2', 'PlotGroup1D');
model.result('pg2').run;
model.result('pg2').label('Near Field');
model.result('pg2').create('lngr1', 'LineGraph');
model.result('pg2').feature('lngr1').set('markerpos', 'datapoints');
model.result('pg2').feature('lngr1').set('linewidth', 'preference');
model.result('pg2').feature('lngr1').selection.named('sel3');
model.result('pg2').feature('lngr1').set('expr', 'ewfd.Ez');
model.result('pg2').feature('lngr1').set('xdata', 'expr');
model.result('pg2').feature('lngr1').set('xdataexpr', 'y');
model.result('pg2').run;
model.result('pg2').run;
model.result('pg2').set('titletype', 'none');
model.result.dataset.create('grid1', 'Grid1D');
model.result.dataset('grid1').set('source', 'data');
model.result.dataset('grid1').set('par1', 'u');
model.result.dataset('grid1').set('parmin1', '-H/2');
model.result.dataset('grid1').set('parmax1', 'H/2');
model.result.create('pg3', 'PlotGroup1D');
model.result('pg3').run;
model.result('pg3').label('Focal Plane');
model.result('pg3').set('titletype', 'none');
model.result('pg3').set('ylabelactive', true);
model.result('pg3').set('ylabel', 'Electric field norm (V/m)');
model.result('pg3').create('lngr1', 'LineGraph');
model.result('pg3').feature('lngr1').set('markerpos', 'datapoints');
model.result('pg3').feature('lngr1').set('linewidth', 'preference');
model.result('pg3').feature('lngr1').set('data', 'grid1');
model.result('pg3').feature('lngr1').set('expr', '3/2.5*sqrt(1/wl/f*intop1(ewfd.Ez*exp(-i*k*y^2/(2*f))*exp(i*2*pi*dest(u)*y/(wl*f)))*conj(intop1(ewfd.Ez*exp(-i*k*y^2/(2*f))*exp(i*2*pi*dest(u)*y/(wl*f)))))');
model.result('pg3').feature('lngr1').set('legend', true);
model.result('pg3').feature('lngr1').set('legendmethod', 'manual');
model.result('pg3').feature('lngr1').setIndex('legends', 'FD+Fresnel formula', 0);
model.result('pg3').run;

model.physics.create('ewbe', 'ElectromagneticWavesBeamEnvelopes', 'geom1');
model.physics('ewbe').model('comp1');

model.study('std1').feature('wave').setSolveFor('/physics/ewbe', true);

model.coordSystem.create('pml1', 'geom1', 'PML');
model.coordSystem('pml1').selection.named('sel4');

model.physics('ewbe').prop('components').set('components', 'outofplane');
model.physics('ewbe').prop('WaveVector').set('dirCount', 'UniDirectionality');
model.physics('ewbe').prop('WaveVector').set('k1', {'k*n' '0' '0'});
model.physics('ewbe').create('mbc1', 'MatchedBoundaryCondition', 1);
model.physics('ewbe').feature('mbc1').selection.named('sel5');
model.physics('ewbe').feature('mbc1').set('IncidentField', 'EField');
model.physics('ewbe').feature('mbc1').set('E0i', {'0' '0' '1[V/m]*(abs(y)<w)'});
model.physics('ewbe').create('trans1', 'TransitionBoundaryCondition', 1);
model.physics('ewbe').feature('trans1').selection.named('adj2');
model.physics('ewbe').feature('trans1').set('PropagationDirection', 'FromWaveVector');
model.physics('ewbe').feature('trans1').set('d', 'd_AR');

model.coordSystem('pml1').set('wavelengthSource', 'ewbe');

model.mesh('mesh1').contribute('physics/ewbe', false);
model.mesh.create('mesh2', 'geom1');
model.mesh('mesh2').create('map1', 'Map');
model.mesh('mesh2').feature('map1').selection.geom('geom1', 2);
model.mesh('mesh2').feature('map1').selection.named('sel4');
model.mesh('mesh2').feature('map1').create('dis1', 'Distribution');
model.mesh('mesh2').feature('map1').feature('dis1').selection.set([19 20 22]);
model.mesh('mesh2').feature('map1').feature('dis1').set('numelem', 10);
model.mesh('mesh2').feature('size').set('custom', true);
model.mesh('mesh2').feature('size').set('hmax', 'wl');
model.mesh('mesh2').create('ftri1', 'FreeTri');

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
model.study('std2').feature('wave').setSolveFor('/physics/ewfd', false);
model.study('std2').feature('wave').setSolveFor('/physics/ewbe', true);
model.study('std2').feature('wave').set('plist', 'wl');

model.sol.create('sol2');
model.sol('sol2').study('std2');
model.sol('sol2').create('st1', 'StudyStep');
model.sol('sol2').feature('st1').set('study', 'std2');
model.sol('sol2').feature('st1').set('studystep', 'wave');
model.sol('sol2').create('v1', 'Variables');
model.sol('sol2').feature('v1').set('control', 'wave');
model.sol('sol2').create('s1', 'Stationary');
model.sol('sol2').feature('s1').create('p1', 'Parametric');
model.sol('sol2').feature('s1').feature.remove('pDef');
model.sol('sol2').feature('s1').feature('p1').set('pname', {'lambda0'});
model.sol('sol2').feature('s1').feature('p1').set('plistarr', {'wl'});
model.sol('sol2').feature('s1').feature('p1').set('punit', {[native2unicode(hex2dec({'00' 'b5'}), 'unicode') 'm']});
model.sol('sol2').feature('s1').feature('p1').set('pcontinuationmode', 'no');
model.sol('sol2').feature('s1').feature('p1').set('preusesol', 'no');
model.sol('sol2').feature('s1').feature('p1').set('pdistrib', 'off');
model.sol('sol2').feature('s1').feature('p1').set('plot', 'off');
model.sol('sol2').feature('s1').feature('p1').set('plotgroup', 'Default');
model.sol('sol2').feature('s1').feature('p1').set('probesel', 'all');
model.sol('sol2').feature('s1').feature('p1').set('probes', {});
model.sol('sol2').feature('s1').feature('p1').set('control', 'wave');
model.sol('sol2').feature('s1').set('control', 'wave');
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

model.result.create('pg4', 'PlotGroup2D');
model.result('pg4').label('Electric Field (ewbe)');
model.result('pg4').set('data', 'dset2');
model.result('pg4').setIndex('looplevel', 1, 0);
model.result('pg4').set('data', 'dset2');
model.result('pg4').setIndex('looplevel', 1, 0);
model.result('pg4').set('defaultPlotID', 'ElectromagneticWavesBeamEnvelopes/phys1/pdef1/pcond2/pg1');
model.result('pg4').feature.create('surf1', 'Surface');
model.result('pg4').feature('surf1').label('Electric Field');
model.result('pg4').feature('surf1').set('expr', 'ewbe.normE');
model.result('pg4').feature('surf1').set('smooth', 'internal');
model.result('pg4').feature('surf1').set('data', 'parent');
model.result('pg4').run;

model.view.create('view3', 'geom1');
model.view('view3').model('comp1');
model.view('view3').axis.set('viewscaletype', 'manual');
model.view('view3').axis.set('yscale', 2);

model.result('pg4').run;
model.result('pg4').set('view', 'view3');
model.result.dataset.create('cln1', 'CutLine2D');
model.result.dataset('cln1').set('data', 'dset2');
model.result.dataset('cln1').setIndex('genpoints', 'f', 0, 0);
model.result.dataset('cln1').setIndex('genpoints', '-H', 0, 1);
model.result.dataset('cln1').setIndex('genpoints', 'f', 1, 0);
model.result.dataset('cln1').setIndex('genpoints', 'H', 1, 1);
model.result('pg3').run;
model.result('pg3').create('lngr2', 'LineGraph');
model.result('pg3').feature('lngr2').set('markerpos', 'datapoints');
model.result('pg3').feature('lngr2').set('linewidth', 'preference');
model.result('pg3').feature('lngr2').set('data', 'cln1');
model.result('pg3').feature('lngr2').set('expr', 'ewbe.normE');
model.result('pg3').feature('lngr2').set('legend', true);
model.result('pg3').feature('lngr2').set('legendmethod', 'manual');
model.result('pg3').feature('lngr2').setIndex('legends', 'Beam Envelopes', 0);
model.result('pg3').run;
model.result.dataset.create('cln2', 'CutLine2D');
model.result.dataset('cln2').set('data', 'dset2');
model.result.dataset('cln2').setIndex('genpoints', 'W_lens+W_air-wl', 1, 0);
model.result.create('pg5', 'PlotGroup1D');
model.result('pg5').run;
model.result('pg5').label('Propagation Direction');
model.result('pg5').set('data', 'cln2');
model.result('pg5').set('xlabelactive', true);
model.result('pg5').set('xlabel', 'Propagation length (mm)');
model.result('pg5').create('lngr1', 'LineGraph');
model.result('pg5').feature('lngr1').set('markerpos', 'datapoints');
model.result('pg5').feature('lngr1').set('linewidth', 'preference');
model.result('pg5').feature('lngr1').set('expr', 'ewbe.normE');
model.result('pg5').run;

model.study('std1').feature('wave').setEntry('activate', 'ewbe', false);

model.result('pg4').run;

model.title('Focusing Lens');

model.description(['Optical lenses of millimeter size cannot easily be analyzed with the Electromagnetic Waves, Frequency Domain interface on standard workstations due to the large number of finite element mesh elements required.' newline  newline 'This model explains how the Electromagnetic Waves, Beam Envelopes interface can be used to analyze a plano-convex lens with a 1-mm focal length. The results are compared with the Fresnel diffraction formula. The two results agree very well.']);

model.mesh.clearMeshes;

model.sol('sol1').clearSolutionData;
model.sol('sol2').clearSolutionData;

model.label('focusing_lens.mph');

model.modelNode.label('Components');

out = model;
