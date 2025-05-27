function out = model
%
% optically_anisotropic_waveguide.m
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
model.param.set('lda0', '1.55[um]', 'Operating wavelength');
model.param.set('f0', 'c_const/lda0', 'Operating frequency');
model.param.set('height', '4000[nm]', 'Height of waveguide');
model.param.set('n_core_o', 'sqrt(epsr_o)', 'Core refractive index, ordinary');
model.param.set('n_core_eo', 'sqrt(epsr_eo)', 'Core refractive index, extraordinary');
model.param.set('eps_clad', '2.05', 'Cladding relative permittivity');
model.param.set('k0_1', '2*pi/lda0', 'Wavenumber in vacuum');
model.param.set('theta', '0[deg]', 'x-y plane rotation');
model.param.set('phi', '45[deg]', 'y-z plane rotation');
model.param.set('zeta', '90[deg]', 'x-z plane rotation');
model.param.set('epsr_eo', '2.19', 'Core relative permittivity, extraordinary');
model.param.set('epsr_o', '2.31', 'Core relative permittivity, ordinary');

model.geom('geom1').lengthUnit([native2unicode(hex2dec({'00' 'b5'}), 'unicode') 'm']);
model.geom('geom1').create('sq1', 'Square');
model.geom('geom1').feature('sq1').set('size', '20[um]');
model.geom('geom1').feature('sq1').set('base', 'center');
model.geom('geom1').run('sq1');
model.geom('geom1').create('r1', 'Rectangle');
model.geom('geom1').feature('r1').set('size', {'height' 'height'});
model.geom('geom1').feature('r1').set('base', 'center');
model.geom('geom1').runPre('fin');
model.geom('geom1').run;

model.physics('ewfd').feature('wee1').set('DisplacementFieldModel', 'RelativePermittivity');

model.material.create('mat1', 'Common', 'comp1');
model.material('mat1').label('Cladding');
model.material('mat1').propertyGroup('def').set('relpermittivity', {'eps_clad'});
model.material('mat1').propertyGroup('def').set('relpermeability', {'1'});
model.material('mat1').propertyGroup('def').set('electricconductivity', {'0'});
model.material.create('mat2', 'Common', 'comp1');
model.material('mat2').label('Core');
model.material('mat2').selection.set([2]);
model.material('mat2').propertyGroup('def').set('relpermittivity', {'epsr_eo' 'epsr_o' 'epsr_o'});
model.material('mat2').propertyGroup('def').set('relpermeability', {'1'});
model.material('mat2').propertyGroup('def').set('electricconductivity', {'0'});

model.mesh('mesh1').automatic(false);
model.mesh('mesh1').feature('size').set('custom', false);
model.mesh('mesh1').feature('size1').set('hmax', 'height/15');
model.mesh('mesh1').run;

model.study('std1').label('Study - Diagonal Transverse Anisotropy');
model.study('std1').create('param', 'Parametric');
model.study('std1').feature('param').setIndex('pname', 'lda0', 0);
model.study('std1').feature('param').setIndex('plistarr', '', 0);
model.study('std1').feature('param').setIndex('punit', 'm', 0);
model.study('std1').feature('param').setIndex('pname', 'lda0', 0);
model.study('std1').feature('param').setIndex('plistarr', '', 0);
model.study('std1').feature('param').setIndex('punit', 'm', 0);
model.study('std1').feature('param').setIndex('pname', 'height', 0);
model.study('std1').feature('param').setIndex('plistarr', 'range(500[nm],250[nm],4000[nm])', 0);
model.study('std1').feature('param').setIndex('punit', 'nm', 0);
model.study('std1').feature('mode').set('modeFreq', 'f0');
model.study('std1').feature('mode').set('neigsactive', true);
model.study('std1').feature('mode').set('neigs', 7);
model.study('std1').feature('mode').set('shiftactive', true);
model.study('std1').feature('mode').set('shift', 'n_core_o');

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

model.batch.create('p1', 'Parametric');
model.batch('p1').study('std1');
model.batch('p1').create('so1', 'Solutionseq');
model.batch('p1').feature('so1').set('seq', 'sol1');
model.batch('p1').feature('so1').set('store', 'on');
model.batch('p1').feature('so1').set('clear', 'on');
model.batch('p1').feature('so1').set('psol', 'none');
model.batch('p1').set('pname', {'height'});
model.batch('p1').set('plistarr', {'range(500[nm],250[nm],4000[nm])'});
model.batch('p1').set('sweeptype', 'sparse');
model.batch('p1').set('probesel', 'all');
model.batch('p1').set('probes', {});
model.batch('p1').set('plot', 'off');
model.batch('p1').set('err', 'on');
model.batch('p1').attach('std1');
model.batch('p1').set('control', 'param');

model.sol.create('sol2');
model.sol('sol2').study('std1');
model.sol('sol2').label('Parametric Solutions 1');

model.batch('p1').feature('so1').set('psol', 'sol2');
model.batch('p1').run('compute');

model.result.create('pg1', 'PlotGroup2D');
model.result('pg1').label('Electric Field (ewfd)');
model.result('pg1').set('data', 'dset2');
model.result('pg1').setIndex('looplevel', 1, 0);
model.result('pg1').setIndex('looplevel', 15, 1);
model.result('pg1').set('frametype', 'spatial');
model.result('pg1').set('data', 'dset2');
model.result('pg1').setIndex('looplevel', 1, 0);
model.result('pg1').setIndex('looplevel', 15, 1);
model.result('pg1').set('defaultPlotID', 'ElectromagneticWavesFrequencyDomain/phys1/pdef1/pcond2/pg1');
model.result('pg1').feature.create('surf1', 'Surface');
model.result('pg1').feature('surf1').set('smooth', 'internal');
model.result('pg1').feature('surf1').set('data', 'parent');
model.result('pg1').run;
model.result('pg1').label('Power and Electric Field - Diagonal Transverse Anisotropy');
model.result('pg1').set('looplevel', [7 15]);
model.result('pg1').run;
model.result('pg1').feature('surf1').set('expr', 'ewfd.Poavz');
model.result('pg1').feature('surf1').set('descr', 'Power flow, time average, z-component');
model.result('pg1').run;
model.result('pg1').create('arws1', 'ArrowSurface');
model.result('pg1').feature('arws1').set('expr', {'ewfd.Ex' 'ewfd.Ey'});
model.result('pg1').feature('arws1').set('descr', 'Electric field');
model.result('pg1').feature('arws1').set('xnumber', 30);
model.result('pg1').feature('arws1').set('ynumber', 30);
model.result('pg1').feature('arws1').set('color', 'black');
model.result('pg1').run;
model.result('pg1').create('con1', 'Contour');
model.result('pg1').feature('con1').set('expr', 'ewfd.Poavz');
model.result('pg1').feature('con1').set('descr', 'Power flow, time average, z-component');
model.result('pg1').feature('con1').set('coloring', 'uniform');
model.result('pg1').feature('con1').set('color', 'gray');
model.result('pg1').feature('con1').set('colorlegend', false);
model.result('pg1').run;
model.result('pg1').set('titletype', 'manual');
model.result('pg1').set('titlenumberformat', 'auto');
model.result('pg1').set('titleprecision', 5);
model.result('pg1').set('title', 'Height=eval(height,nm) nm Effective mode index=eval(ewfd.neff) Surface and Contour: Power Arrows: Electric field');
model.result('pg1').set('paramindicator', '');
model.result('pg1').run;
model.result.create('pg2', 'PlotGroup1D');
model.result('pg2').run;
model.result('pg2').label('Dispersion Curves - Diagonal Transverse Anisotropy');
model.result('pg2').set('data', 'dset2');
model.result('pg2').set('showlegends', false);
model.result('pg2').create('glob1', 'Global');
model.result('pg2').feature('glob1').set('markerpos', 'datapoints');
model.result('pg2').feature('glob1').set('linewidth', 'preference');
model.result('pg2').feature('glob1').setIndex('expr', 'ewfd.neff^2', 0);
model.result('pg2').feature('glob1').setIndex('unit', 1, 0);
model.result('pg2').feature('glob1').setIndex('descr', '', 0);
model.result('pg2').feature('glob1').set('xdatasolnumtype', 'outer');
model.result('pg2').feature('glob1').set('xdata', 'expr');
model.result('pg2').feature('glob1').set('xdataexpr', 'ewfd.k0*height');
model.result('pg2').feature('glob1').set('linestyle', 'none');
model.result('pg2').feature('glob1').set('linecolor', 'black');
model.result('pg2').feature('glob1').set('linemarker', 'point');
model.result('pg2').feature('glob1').set('markerpos', 'interp');
model.result('pg2').feature('glob1').set('markers', 100);
model.result('pg2').run;
model.result('pg2').run;
model.result('pg2').setIndex('looplevelinput', 'manualindices', 0);
model.result('pg2').setIndex('looplevelindices', '1 2 4 5 6 7', 0);
model.result('pg2').set('xlabelactive', true);
model.result('pg2').set('xlabel', 'k*thickness');
model.result('pg2').set('ylabelactive', true);
model.result('pg2').set('ylabel', '(Effective index)<sup>2</sub>');
model.result('pg2').set('axislimits', true);
model.result('pg2').set('xmin', 0);
model.result('pg2').set('xmax', 15);
model.result('pg2').set('ymin', 2.05);
model.result('pg2').set('ymax', 2.31);
model.result('pg2').create('ann1', 'Annotation');
model.result('pg2').feature('ann1').set('text', '\[E^{y}_{11}\]');
model.result('pg2').feature('ann1').set('posxexpr', 10);
model.result('pg2').feature('ann1').set('posyexpr', 2.225);
model.result('pg2').feature('ann1').set('latexmarkup', true);
model.result('pg2').feature('ann1').set('showpoint', false);
model.result('pg2').feature.duplicate('ann2', 'ann1');
model.result('pg2').run;
model.result('pg2').feature('ann2').set('text', '\[E^{x}_{11}\]');
model.result('pg2').feature('ann2').set('posyexpr', 2.125);
model.result('pg2').feature.duplicate('ann3', 'ann2');
model.result('pg2').run;
model.result('pg2').feature('ann3').set('text', '\[E^{y}_{21}\]');
model.result('pg2').feature('ann3').set('posxexpr', 13);
model.result('pg2').feature('ann3').set('posyexpr', 2.165);
model.result('pg2').feature.duplicate('ann4', 'ann3');
model.result('pg2').run;
model.result('pg2').feature('ann4').set('text', '\[E^{y}_{12}\]');
model.result('pg2').feature('ann4').set('posxexpr', 13.5);
model.result('pg2').feature('ann4').set('posyexpr', 2.15);
model.result('pg2').feature.duplicate('ann5', 'ann4');
model.result('pg2').run;
model.result('pg2').feature('ann5').set('text', '\[E^{x}_{21}\]');
model.result('pg2').feature('ann5').set('posxexpr', 14);
model.result('pg2').feature('ann5').set('posyexpr', 2.09);
model.result('pg2').feature.duplicate('ann6', 'ann5');
model.result('pg2').run;
model.result('pg2').feature('ann6').set('text', '\[E^{x}_{12}\]');
model.result('pg2').feature('ann6').set('posyexpr', 2.07);
model.result('pg2').run;
model.result('pg2').set('titletype', 'none');

model.coordSystem.create('sys2', 'geom1', 'Rotated');
model.coordSystem('sys2').set('method', 'general');
model.coordSystem('sys2').set('angle', {'0' 'phi' 'zeta'});

model.physics('ewfd').feature('wee1').set('coordinateSystem', 'sys2');

model.study.create('std2');
model.study('std2').create('mode', 'ModeAnalysis');
model.study('std2').feature('mode').set('plotgroup', 'Default');
model.study('std2').feature('mode').set('shiftactive', false);
model.study('std2').feature('mode').set('conrad', '1');
model.study('std2').feature('mode').set('conradynhm', '1');
model.study('std2').feature('mode').set('linpsolnum', 'auto');
model.study('std2').feature('mode').set('outputmap', {});
model.study('std2').feature('mode').set('ngenAUX', '1');
model.study('std2').feature('mode').set('goalngenAUX', '1');
model.study('std2').feature('mode').set('ngenAUX', '1');
model.study('std2').feature('mode').set('goalngenAUX', '1');
model.study('std2').feature('mode').setSolveFor('/physics/ewfd', true);
model.study('std2').label('Study - Off-Diagonal Longitudinal Anisotropy');
model.study('std2').feature.copy('param1', 'std1/param');
model.study('std2').feature('mode').set('modeFreq', 'f0');
model.study('std2').feature('mode').set('shiftactive', true);
model.study('std2').feature('mode').set('shift', 'n_core_o');

model.sol.create('sol18');
model.sol('sol18').study('std2');
model.sol('sol18').create('st1', 'StudyStep');
model.sol('sol18').feature('st1').set('study', 'std2');
model.sol('sol18').feature('st1').set('studystep', 'mode');
model.sol('sol18').create('v1', 'Variables');
model.sol('sol18').feature('v1').set('control', 'mode');
model.sol('sol18').create('e1', 'Eigenvalue');
model.sol('sol18').feature('e1').set('neigs', 6);
model.sol('sol18').feature('e1').set('shift', '1');
model.sol('sol18').feature('e1').set('control', 'mode');
model.sol('sol18').feature('e1').feature('aDef').set('complexfun', true);
model.sol('sol18').feature('e1').feature('aDef').set('cachepattern', false);
model.sol('sol18').feature('e1').create('d1', 'Direct');
model.sol('sol18').feature('e1').feature('d1').set('linsolver', 'mumps');
model.sol('sol18').feature('e1').feature('d1').label('Suggested Direct Solver (ewfd)');
model.sol('sol18').attach('std2');

model.batch.create('p2', 'Parametric');
model.batch('p2').study('std2');
model.batch('p2').create('so1', 'Solutionseq');
model.batch('p2').feature('so1').set('seq', 'sol18');
model.batch('p2').feature('so1').set('store', 'on');
model.batch('p2').feature('so1').set('clear', 'on');
model.batch('p2').feature('so1').set('psol', 'none');
model.batch('p2').set('pname', {'height'});
model.batch('p2').set('plistarr', {'range(500[nm],250[nm],4000[nm])'});
model.batch('p2').set('sweeptype', 'sparse');
model.batch('p2').set('probesel', 'all');
model.batch('p2').set('probes', {});
model.batch('p2').set('plot', 'off');
model.batch('p2').set('err', 'on');
model.batch('p2').attach('std2');
model.batch('p2').set('control', 'param1');

model.sol.create('sol19');
model.sol('sol19').study('std2');
model.sol('sol19').label('Parametric Solutions 2');

model.batch('p2').feature('so1').set('psol', 'sol19');
model.batch('p2').run('compute');

model.result.create('pg3', 'PlotGroup2D');
model.result('pg3').label('Electric Field (ewfd)');
model.result('pg3').set('data', 'dset4');
model.result('pg3').setIndex('looplevel', 1, 0);
model.result('pg3').setIndex('looplevel', 15, 1);
model.result('pg3').set('frametype', 'spatial');
model.result('pg3').set('data', 'dset4');
model.result('pg3').setIndex('looplevel', 1, 0);
model.result('pg3').setIndex('looplevel', 15, 1);
model.result('pg3').set('defaultPlotID', 'ElectromagneticWavesFrequencyDomain/phys1/pdef1/pcond2/pg1');
model.result('pg3').feature.create('surf1', 'Surface');
model.result('pg3').feature('surf1').set('smooth', 'internal');
model.result('pg3').feature('surf1').set('data', 'parent');
model.result('pg3').run;
model.result('pg3').label('Power and Electric Field - Off-Diagonal Longitudinal Anisotropy');
model.result('pg3').set('looplevel', [6 15]);
model.result('pg1').run;
model.result('pg3').run;
model.result('pg3').feature.copy('arws1', 'pg1/arws1');
model.result('pg3').feature.copy('con1', 'pg1/con1');
model.result('pg3').run;
model.result('pg3').run;
model.result('pg3').feature('surf1').set('expr', 'ewfd.Poavz');
model.result('pg3').feature('surf1').set('descr', 'Power flow, time average, z-component');
model.result('pg3').run;
model.result('pg3').set('titletype', 'manual');
model.result('pg3').set('titlenumberformat', 'auto');
model.result('pg3').set('titleprecision', 5);
model.result('pg3').set('title', 'Height=eval(height,nm) nm Effective mode index=eval(ewfd.neff) Surface and Contour: Power Arrows: Electric field');
model.result('pg3').set('paramindicator', '');
model.result('pg2').run;
model.result.duplicate('pg4', 'pg2');
model.result('pg4').run;
model.result('pg4').label('Dispersion Curves - Off-Diagonal Longitudinal Anisotropy');
model.result('pg4').set('data', 'dset4');
model.result('pg4').setIndex('looplevelinput', 'all', 0);
model.result('pg4').run;
model.result('pg4').feature('ann1').set('text', '\[E^{x}_{11}\]');
model.result('pg4').run;
model.result('pg4').feature('ann2').set('text', '\[E^{y}_{11}\]');
model.result('pg4').feature('ann2').set('posyexpr', 2.175);
model.result('pg4').run;
model.result('pg4').feature('ann3').set('text', '\[E^{x}_{12}\]');
model.result('pg4').feature('ann3').set('posxexpr', 12);
model.result('pg4').feature('ann3').set('posyexpr', 2.145);
model.result('pg4').run;
model.result('pg4').feature('ann4').set('text', '\[E^{x}_{21}\]');
model.result('pg4').feature('ann4').set('posxexpr', 12.5);
model.result('pg4').feature('ann4').set('posyexpr', 2.13);
model.result('pg4').run;
model.result('pg4').feature('ann5').set('text', '\[E^{y}_{21}\]');
model.result('pg4').feature('ann5').set('posxexpr', 12.5);
model.result('pg4').feature('ann5').set('posyexpr', 2.111);
model.result('pg4').run;
model.result('pg4').feature('ann6').set('text', '\[E^{y}_{12}\]');
model.result('pg4').feature('ann6').set('posxexpr', 13);
model.result('pg4').feature('ann6').set('posyexpr', 2.095);
model.result('pg4').run;
model.result('pg3').run;

model.title('Optically Anisotropic Waveguide');

model.description(['In this model, a modal analysis is performed while parametrically sweeping the length of a waveguide from 0.5 ' native2unicode(hex2dec({'00' 'b5'}), 'unicode') 'm to 4 ' native2unicode(hex2dec({'00' 'b5'}), 'unicode') 'm to derive the dispersion curve for the anisotropic core. Both transverse and longitudinal anisotropy are considered in two separate modeling steps.']);

model.mesh.clearMeshes;

model.sol('sol1').clearSolutionData;
model.sol('sol2').clearSolutionData;
model.sol('sol3').clearSolutionData;
model.sol('sol4').clearSolutionData;
model.sol('sol5').clearSolutionData;
model.sol('sol6').clearSolutionData;
model.sol('sol7').clearSolutionData;
model.sol('sol8').clearSolutionData;
model.sol('sol9').clearSolutionData;
model.sol('sol10').clearSolutionData;
model.sol('sol11').clearSolutionData;
model.sol('sol12').clearSolutionData;
model.sol('sol13').clearSolutionData;
model.sol('sol14').clearSolutionData;
model.sol('sol15').clearSolutionData;
model.sol('sol16').clearSolutionData;
model.sol('sol17').clearSolutionData;
model.sol('sol18').clearSolutionData;
model.sol('sol19').clearSolutionData;
model.sol('sol20').clearSolutionData;
model.sol('sol21').clearSolutionData;
model.sol('sol22').clearSolutionData;
model.sol('sol23').clearSolutionData;
model.sol('sol24').clearSolutionData;
model.sol('sol25').clearSolutionData;
model.sol('sol26').clearSolutionData;
model.sol('sol27').clearSolutionData;
model.sol('sol28').clearSolutionData;
model.sol('sol29').clearSolutionData;
model.sol('sol30').clearSolutionData;
model.sol('sol31').clearSolutionData;
model.sol('sol32').clearSolutionData;
model.sol('sol33').clearSolutionData;
model.sol('sol34').clearSolutionData;

model.label('optically_anisotropic_waveguide.mph');

model.modelNode.label('Components');

out = model;
