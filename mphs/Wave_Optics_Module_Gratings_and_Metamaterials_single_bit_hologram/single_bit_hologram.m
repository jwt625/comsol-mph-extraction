function out = model
%
% single_bit_hologram.m
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
model.param.set('wl0', '1[um]', 'Wavelength');
model.param.set('k0', '2*pi/wl0', 'Wave number');
model.param.set('L', '30[um]', 'Air domain size');
model.param.set('H', '30[um]', 'Air domain height');
model.param.set('L_h', '30[um]', 'Hologram material size');
model.param.set('n1', '1.35', 'Hologram material index');
model.param.set('dn', '0.01', 'Modulation coefficient');
model.param.set('a', '10[um]', 'Hologram half length');
model.param.set('w_o', '10[um]', '1/e^2 intensity waist radius for object beam');
model.param.set('w_r', '10[um]', '1/e^2 intensity waist radius for reference beam');
model.param.set('threshold', '.4', 'Exposure threshold');

model.geom('geom1').lengthUnit([native2unicode(hex2dec({'00' 'b5'}), 'unicode') 'm']);
model.geom('geom1').create('r1', 'Rectangle');
model.geom('geom1').feature('r1').set('size', {'L' 'H'});
model.geom('geom1').feature('r1').set('base', 'center');
model.geom('geom1').runPre('fin');
model.geom('geom1').run;

model.material.create('mat1', 'Common', 'comp1');
model.material('mat1').propertyGroup.create('RefractiveIndex', 'Refractive_index');
model.material('mat1').propertyGroup('RefractiveIndex').set('n', {'n1'});
model.material('mat1').propertyGroup('RefractiveIndex').set('ki', {'0'});

model.cpl.create('maxop1', 'Maximum', 'geom1');
model.cpl('maxop1').selection.set([1]);

model.variable.create('var1');
model.variable('var1').model('comp1');
model.variable('var1').label('Refractive Index During Recording');
model.variable('var1').set('n', 'n1');
model.variable('var1').descr('n', 'Background refractive index');
model.variable.duplicate('var2', 'var1');
model.variable('var2').label('Modulated Refractive Index');
model.variable('var2').rename('n', 'n_mod');
model.variable('var2').set('n_mod', 'n1+dn*(((ewfd.normE/maxop1(ewfd.normE))^2>threshold)-0.5)');
model.variable('var2').descr('n_mod', 'Modulated refractive index');
model.variable.create('var3');
model.variable('var3').model('comp1');
model.variable('var3').label('Refractive Index During Retrieval');
model.variable('var3').set('n', 'withsol(''sol2'',n1+dn*(((ewfd.normE/maxop1(ewfd.normE))^2>threshold)-0.5))', 'Background refractive index');

model.material('mat1').propertyGroup('RefractiveIndex').set('n', {'n'});
model.material('mat1').propertyGroup('RefractiveIndex').set('ki', {'0'});

model.physics('ewfd').prop('components').set('components', 'outofplane');
model.physics('ewfd').create('sctr1', 'Scattering', 1);
model.physics('ewfd').feature('sctr1').label('Reference Scattering Boundary Condition');
model.physics('ewfd').feature('sctr1').selection.set([1]);
model.physics('ewfd').feature('sctr1').set('IncidentField', 'EField');
model.physics('ewfd').feature('sctr1').set('E0i', {'0' '0' 'exp(-(y/w_r)^6)'});
model.physics('ewfd').create('sctr2', 'Scattering', 1);
model.physics('ewfd').feature('sctr2').label('Object Scattering Boundary Condition');
model.physics('ewfd').feature('sctr2').selection.set([3]);
model.physics('ewfd').feature('sctr2').set('IncidentField', 'EField');
model.physics('ewfd').feature('sctr2').set('E0i', {'0' '0' 'exp(-x^6/w_o^6)'});
model.physics('ewfd').create('sctr3', 'Scattering', 1);
model.physics('ewfd').feature('sctr3').label('Recording Scattering Boundary Condition');
model.physics('ewfd').feature('sctr3').selection.set([2 4]);
model.physics('ewfd').feature.duplicate('sctr4', 'sctr3');
model.physics('ewfd').feature('sctr4').label('Retrieval Scattering Boundary Condition');
model.physics('ewfd').feature('sctr4').selection.set([2 3 4]);

model.mesh('mesh1').create('ftri1', 'FreeTri');
model.mesh('mesh1').feature('size').set('custom', true);
model.mesh('mesh1').feature('size').set('hmax', 'wl0/n1/10');

model.study('std1').feature('wave').label('Recording');
model.study('std1').feature('wave').set('plist', 'wl0');
model.study('std1').feature('wave').set('useadvanceddisable', true);
model.study('std1').feature('wave').set('disabledvariables', {'var3'});
model.study('std1').feature('wave').set('disabledphysics', {'ewfd/sctr4'});
model.study('std1').feature.duplicate('wave1', 'wave');
model.study('std1').feature('wave1').label('Retrieval');
model.study('std1').feature('wave1').set('disabledvariables', {'var1'});
model.study('std1').feature('wave1').set('disabledphysics', {'ewfd/sctr3'});

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
model.sol('sol1').feature('s1').feature('p1').set('plistarr', {'wl0'});
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
model.sol('sol1').create('st2', 'StudyStep');
model.sol('sol1').feature('st2').set('study', 'std1');
model.sol('sol1').feature('st2').set('studystep', 'wave1');
model.sol('sol1').create('v2', 'Variables');
model.sol('sol1').feature('v2').set('initmethod', 'sol');
model.sol('sol1').feature('v2').set('initsol', 'sol1');
model.sol('sol1').feature('v2').set('notsolmethod', 'sol');
model.sol('sol1').feature('v2').set('notsol', 'sol1');
model.sol('sol1').feature('v2').set('control', 'wave1');
model.sol('sol1').create('s2', 'Stationary');
model.sol('sol1').feature('s2').set('stol', 0.01);
model.sol('sol1').feature('s2').create('p1', 'Parametric');
model.sol('sol1').feature('s2').feature.remove('pDef');
model.sol('sol1').feature('s2').feature('p1').set('pname', {'lambda0'});
model.sol('sol1').feature('s2').feature('p1').set('plistarr', {'wl0'});
model.sol('sol1').feature('s2').feature('p1').set('punit', {[native2unicode(hex2dec({'00' 'b5'}), 'unicode') 'm']});
model.sol('sol1').feature('s2').feature('p1').set('pcontinuationmode', 'no');
model.sol('sol1').feature('s2').feature('p1').set('preusesol', 'no');
model.sol('sol1').feature('s2').feature('p1').set('pdistrib', 'off');
model.sol('sol1').feature('s2').feature('p1').set('plot', 'off');
model.sol('sol1').feature('s2').feature('p1').set('plotgroup', 'Default');
model.sol('sol1').feature('s2').feature('p1').set('probesel', 'all');
model.sol('sol1').feature('s2').feature('p1').set('probes', {});
model.sol('sol1').feature('s2').feature('p1').set('control', 'wave1');
model.sol('sol1').feature('s2').set('control', 'wave1');
model.sol('sol1').feature('s2').feature('aDef').set('complexfun', true);
model.sol('sol1').feature('s2').feature('aDef').set('cachepattern', false);
model.sol('sol1').feature('s2').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('s2').create('d1', 'Direct');
model.sol('sol1').feature('s2').feature('d1').set('linsolver', 'mumps');
model.sol('sol1').feature('s2').feature('d1').label('Suggested Direct Solver (ewfd)');
model.sol('sol1').feature('s2').feature('fc1').set('linsolver', 'd1');
model.sol('sol1').feature('s2').feature.remove('fcDef');
model.sol('sol1').feature('v2').set('notsolnum', 'auto');
model.sol('sol1').feature('v2').set('notsolvertype', 'solnum');
model.sol('sol1').feature('v2').set('solnum', 'auto');
model.sol('sol1').feature('v2').set('solvertype', 'solnum');
model.sol('sol1').attach('std1');
model.sol('sol1').create('su1', 'StoreSolution');
model.sol('sol1').feature.move('su1', 5);
model.sol('sol1').feature.move('su1', 4);
model.sol('sol1').feature.move('su1', 3);
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
model.result('pg1').set('data', 'dset2');
model.result('pg1').label('Recording');
model.result('pg1').run;
model.result('pg1').feature('surf1').set('expr', 'ewfd.Ez');
model.result('pg1').feature('surf1').set('colorlegend', false);
model.result('pg1').feature.duplicate('surf2', 'surf1');
model.result('pg1').run;
model.result('pg1').feature('surf2').set('expr', 'ewfd.normE^2');
model.result('pg1').feature('surf2').create('trn1', 'Translation');
model.result('pg1').run;
model.result('pg1').feature('surf2').feature('trn1').set('trans', [34 0]);
model.result('pg1').run;
model.result('pg1').set('titletype', 'manual');
model.result('pg1').set('title', 'Left: Electric field, z-component (V/m), right: Squared norm of the electric field (V<sup>2</sup>/m<sup>2</sup>)');
model.result('pg1').run;
model.result.duplicate('pg2', 'pg1');
model.result('pg2').run;
model.result('pg2').run;
model.result('pg2').feature.remove('surf2');
model.result('pg2').run;
model.result('pg2').run;
model.result('pg2').label('Modulated Refractive Index');
model.result('pg2').set('title', 'Modulated refractive index');
model.result('pg2').run;
model.result('pg2').feature('surf1').set('expr', 'n_mod');
model.result('pg2').feature('surf1').set('descr', 'Modulated refractive index');
model.result('pg2').feature('surf1').set('colorlegend', true);
model.result('pg2').run;
model.result('pg2').set('showlegendsmaxmin', true);
model.result('pg2').run;
model.result.dataset.create('cln1', 'CutLine2D');
model.result.dataset('cln1').set('data', 'dset2');
model.result.dataset('cln1').setIndex('genpoints', '-L/2', 0, 0);
model.result.dataset('cln1').setIndex('genpoints', '-H/2', 0, 1);
model.result.dataset('cln1').setIndex('genpoints', 'L/2', 1, 0);
model.result.dataset('cln1').setIndex('genpoints', 'H/2', 1, 1);
model.result.create('pg3', 'PlotGroup1D');
model.result('pg3').run;
model.result('pg3').label('Squared Norm of the Electric Field');
model.result('pg3').set('data', 'cln1');
model.result('pg3').create('lngr1', 'LineGraph');
model.result('pg3').feature('lngr1').set('markerpos', 'datapoints');
model.result('pg3').feature('lngr1').set('linewidth', 'preference');
model.result('pg3').feature('lngr1').set('expr', 'ewfd.normE^2');
model.result('pg3').feature('lngr1').set('legend', true);
model.result('pg3').feature('lngr1').set('legendmethod', 'manual');
model.result('pg3').feature('lngr1').setIndex('legends', 'ewfd.normE<sup>2</sup>', 0);
model.result('pg3').feature.duplicate('lngr2', 'lngr1');
model.result('pg3').run;
model.result('pg3').feature('lngr2').set('expr', 'threshold*maxop1(ewfd.normE^2)');
model.result('pg3').feature('lngr2').set('linecolor', 'red');
model.result('pg3').feature('lngr2').set('linewidth', 4);
model.result('pg3').feature('lngr2').setIndex('legends', 'threshold*maxop1(ewfd.normE<sup>2</sup>)', 0);
model.result('pg3').run;
model.result('pg3').set('titletype', 'manual');
model.result('pg3').set('title', 'Squared norm of electric field (V<sup>2</sup>/m<sup>2</sup>) and exposure threshold value');
model.result('pg3').set('ylabelactive', true);
model.result('pg3').set('ylabel', 'Squared norm of electric field (V<sup>2</sup>/m<sup>2</sup>)');
model.result('pg3').run;
model.result.create('pg4', 'PlotGroup1D');
model.result('pg4').run;
model.result('pg4').label('Modulated Refractive Index Line Plot');
model.result('pg4').set('data', 'cln1');
model.result('pg4').create('lngr1', 'LineGraph');
model.result('pg4').feature('lngr1').set('markerpos', 'datapoints');
model.result('pg4').feature('lngr1').set('linewidth', 'preference');
model.result('pg4').feature('lngr1').set('expr', 'n_mod');
model.result('pg4').feature('lngr1').set('descr', 'Modulated refractive index');
model.result('pg4').run;
model.result('pg4').set('axislimits', true);
model.result('pg4').set('ymin', 1);
model.result('pg4').set('ymax', 1.5);
model.result('pg4').run;
model.result('pg1').run;
model.result.duplicate('pg5', 'pg1');
model.result('pg5').run;
model.result('pg5').label('Retrieval (Reference Only)');
model.result('pg5').set('data', 'dset1');
model.result('pg5').set('title', 'Left: Electric field, z-component (V/m), right: Norm of the electric field (V/m)');
model.result('pg5').run;
model.result('pg5').feature('surf2').set('expr', 'ewfd.normE');
model.result('pg5').run;

model.title('Single-Bit Hologram');

model.description(['This model simulates a bit-by-bit holographic data storage including data recording and retrieval. In the bit-by-bit holographic data storage, the data is 1' native2unicode(hex2dec({'00' 'a0'}), 'unicode') 'bit. So the profiles of the object beam and the reference beam are identical in this model.' newline  newline 'In the recording process, the two beams intersect each other and make an interference fringe pattern, which is the hologram carrying the 1' native2unicode(hex2dec({'00' 'a0'}), 'unicode') 'bit data.' newline  newline 'During the retrieval process the object beam is turned off, and then the reference beam is diffracted by the hologram and creates the object beam.' newline  newline 'The model is implemented using the Electromagnetic Waves, Frequency Domain interface. A single study sequence handles both the recording and the retrieval steps, by modification of the physics tree for the two study steps.']);

model.mesh.clearMeshes;

model.sol('sol1').clearSolutionData;
model.sol('sol2').clearSolutionData;

model.label('single_bit_hologram.mph');

model.modelNode.label('Components');

out = model;
