function out = model
%
% dielectric_slab_waveguide.m
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

model.param.set('lda0', '1550[nm]');
model.param.descr('lda0', 'Wavelength');
model.param.set('n_core', '1.5');
model.param.descr('n_core', 'Refractive index, core');
model.param.set('n_cladding', '1');
model.param.descr('n_cladding', 'Refractive index, cladding');
model.param.set('h_core', '1[um]');
model.param.descr('h_core', 'Thickness, core');
model.param.set('h_cladding', '7[um]');
model.param.descr('h_cladding', 'Thickness, cladding');
model.param.set('w_slab', '5[um]');
model.param.descr('w_slab', 'Slab width');
model.param.set('k_core', '2*pi[rad]*n_core/lda0');
model.param.descr('k_core', 'Wave number, core');
model.param.set('k_cladding', '2*pi[rad]*n_cladding/lda0');
model.param.descr('k_cladding', 'Wave number, cladding');
model.param.set('f0', 'c_const/lda0');
model.param.descr('f0', 'Frequency');

model.geom('geom1').lengthUnit([native2unicode(hex2dec({'00' 'b5'}), 'unicode') 'm']);
model.geom('geom1').create('r1', 'Rectangle');
model.geom('geom1').feature('r1').set('size', {'w_slab' 'h_core'});
model.geom('geom1').feature('r1').set('base', 'center');
model.geom('geom1').run('r1');
model.geom('geom1').create('r2', 'Rectangle');
model.geom('geom1').feature('r2').set('size', {'w_slab' 'h_cladding'});
model.geom('geom1').feature('r2').set('base', 'center');
model.geom('geom1').runPre('fin');
model.geom('geom1').run;

model.physics('ewfd').prop('components').set('components', 'outofplane');
model.physics('ewfd').create('port1', 'Port', 1);
model.physics('ewfd').feature('port1').selection.set([1 3 5]);
model.physics('ewfd').feature('port1').set('PortType', 'Numeric');
model.physics('ewfd').create('port2', 'Port', 1);
model.physics('ewfd').feature('port2').selection.set([8 9 10]);
model.physics('ewfd').feature('port2').set('PortType', 'Numeric');

model.material.create('mat1', 'Common', 'comp1');
model.material('mat1').label('Cladding');
model.material('mat1').propertyGroup.create('RefractiveIndex', 'Refractive_index');
model.material('mat1').propertyGroup('RefractiveIndex').set('n', {'n_cladding'});
model.material.create('mat2', 'Common', 'comp1');
model.material('mat2').label('Core');
model.material('mat2').selection.set([2]);
model.material('mat2').propertyGroup.create('RefractiveIndex', 'Refractive_index');
model.material('mat2').propertyGroup('RefractiveIndex').set('n', {'n_core'});

model.study('std1').create('bma', 'BoundaryModeAnalysis');
model.study('std1').feature('bma').set('shift', 'n_core');
model.study('std1').feature('bma').set('modeFreq', 'f0');
model.study('std1').create('bma2', 'BoundaryModeAnalysis');
model.study('std1').feature('bma2').set('shift', 'n_core');
model.study('std1').feature('bma2').set('PortName', '2');
model.study('std1').feature('bma2').set('modeFreq', 'f0');
model.study('std1').create('freq', 'Frequency');
model.study('std1').feature('freq').set('plist', 'f0');

model.sol.create('sol1');
model.sol('sol1').study('std1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'bma');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').set('control', 'bma');
model.sol('sol1').create('e1', 'Eigenvalue');
model.sol('sol1').feature('e1').set('neigs', 1);
model.sol('sol1').feature('e1').set('shift', '1');
model.sol('sol1').feature('e1').set('eigref', 'n_core');
model.sol('sol1').feature('e1').set('control', 'bma');
model.sol('sol1').feature('e1').feature('aDef').set('complexfun', true);
model.sol('sol1').feature('e1').feature('aDef').set('cachepattern', false);
model.sol('sol1').feature('e1').create('d1', 'Direct');
model.sol('sol1').feature('e1').feature('d1').set('linsolver', 'mumps');
model.sol('sol1').feature('e1').feature('d1').label('Suggested Direct Solver (ewfd)');
model.sol('sol1').create('su1', 'StoreSolution');
model.sol('sol1').create('st2', 'StudyStep');
model.sol('sol1').feature('st2').set('study', 'std1');
model.sol('sol1').feature('st2').set('studystep', 'bma2');
model.sol('sol1').create('v2', 'Variables');
model.sol('sol1').feature('v2').set('initmethod', 'sol');
model.sol('sol1').feature('v2').set('initsol', 'sol1');
model.sol('sol1').feature('v2').set('notsolmethod', 'sol');
model.sol('sol1').feature('v2').set('notsol', 'sol1');
model.sol('sol1').feature('v2').set('control', 'bma2');
model.sol('sol1').create('e2', 'Eigenvalue');
model.sol('sol1').feature('e2').set('neigs', 1);
model.sol('sol1').feature('e2').set('shift', '1');
model.sol('sol1').feature('e2').set('eigref', 'n_core');
model.sol('sol1').feature('e2').set('control', 'bma2');
model.sol('sol1').feature('e2').set('linpmethod', 'sol');
model.sol('sol1').feature('e2').set('linpsol', 'sol1');
model.sol('sol1').feature('e2').set('control', 'bma2');
model.sol('sol1').feature('e2').feature('aDef').set('complexfun', true);
model.sol('sol1').feature('e2').feature('aDef').set('cachepattern', false);
model.sol('sol1').feature('e2').create('d1', 'Direct');
model.sol('sol1').feature('e2').feature('d1').set('linsolver', 'mumps');
model.sol('sol1').feature('e2').feature('d1').label('Suggested Direct Solver (ewfd)');
model.sol('sol1').create('su2', 'StoreSolution');
model.sol('sol1').create('st3', 'StudyStep');
model.sol('sol1').feature('st3').set('study', 'std1');
model.sol('sol1').feature('st3').set('studystep', 'freq');
model.sol('sol1').create('v3', 'Variables');
model.sol('sol1').feature('v3').set('initmethod', 'sol');
model.sol('sol1').feature('v3').set('initsol', 'sol1');
model.sol('sol1').feature('v3').set('notsolmethod', 'sol');
model.sol('sol1').feature('v3').set('notsol', 'sol1');
model.sol('sol1').feature('v3').set('control', 'freq');
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
model.sol('sol1').feature('v3').set('notsolnum', 'auto');
model.sol('sol1').feature('v3').set('notsolvertype', 'solnum');
model.sol('sol1').feature('v3').set('solnum', 'auto');
model.sol('sol1').feature('v3').set('solvertype', 'solnum');
model.sol('sol1').feature('e2').set('linpsolnum', 'auto');
model.sol('sol1').feature('e2').set('linpsolvertype', 'solnum');
model.sol('sol1').feature('v2').set('notsolnum', 'auto');
model.sol('sol1').feature('v2').set('notsolvertype', 'solnum');
model.sol('sol1').feature('v2').set('solnum', 'auto');
model.sol('sol1').feature('v2').set('solvertype', 'solnum');
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
model.result.numerical.create('gev1', 'EvalGlobal');
model.result.numerical('gev1').label('Reflectance, Transmittance, and Absorptance (ewfd)');
model.result.numerical('gev1').set('data', 'dset1');
model.result.numerical('gev1').set('expr', {'ewfd.Rport_1' 'ewfd.Rtotal' 'ewfd.Tport_2' 'ewfd.Ttotal' 'ewfd.RTtotal' 'ewfd.Atotal'});
model.result.table.create('tbl1', 'Table');
model.result.numerical('gev1').set('table', 'tbl1');
model.result.numerical('gev1').run;
model.result.numerical('gev1').setResult;
model.result.create('pg2', 'PlotGroup2D');
model.result('pg2').label('Electric Mode Field, Port 1 (ewfd)');
model.result('pg2').set('showlegendsmaxmin', true);
model.result('pg2').set('data', 'dset1');
model.result('pg2').create('line1', 'Line');
model.result('pg2').feature('line1').set('expr', 'root.comp1.ewfd.normEbm_1');
model.result('pg2').feature('line1').set('colortable', 'RainbowLight');
model.result('pg2').feature('line1').set('linetype', 'tube');
model.result('pg2').feature('line1').create('hght1', 'Height');
model.result('pg2').create('ann1', 'Annotation');
model.result('pg2').feature('ann1').set('posxexpr', 'ewfd.aveport1(x)');
model.result('pg2').feature('ann1').set('posyexpr', 'ewfd.aveport1(y)');
model.result('pg2').feature('ann1').set('backgroundcolor', 'fromtheme');
model.result('pg2').feature('ann1').set('text', 'Effective mode index: eval(comp1.ewfd.neff_1)');
model.result.create('pg3', 'PlotGroup2D');
model.result('pg3').label('Electric Mode Field, Port 2 (ewfd)');
model.result('pg3').set('showlegendsmaxmin', true);
model.result('pg3').set('data', 'dset1');
model.result('pg3').create('line1', 'Line');
model.result('pg3').feature('line1').set('expr', 'root.comp1.ewfd.normEbm_2');
model.result('pg3').feature('line1').set('colortable', 'RainbowLight');
model.result('pg3').feature('line1').set('linetype', 'tube');
model.result('pg3').feature('line1').create('hght1', 'Height');
model.result('pg3').create('ann1', 'Annotation');
model.result('pg3').feature('ann1').set('posxexpr', 'ewfd.aveport2(x)');
model.result('pg3').feature('ann1').set('posyexpr', 'ewfd.aveport2(y)');
model.result('pg3').feature('ann1').set('backgroundcolor', 'fromtheme');
model.result('pg3').feature('ann1').set('text', 'Effective mode index: eval(comp1.ewfd.neff_2)');
model.result('pg1').run;
model.result('pg1').run;
model.result('pg1').feature('surf1').set('expr', 'ewfd.Ez');
model.result('pg1').feature('surf1').set('descr', 'Electric field, z-component');
model.result('pg1').feature('surf1').set('colortable', 'WaveLight');
model.result('pg1').run;
model.result('pg2').run;
model.result('pg3').run;

model.physics.create('ge', 'GlobalEquations', 'geom1');
model.physics('ge').model('comp1');

model.study('std1').feature('bma').setSolveFor('/physics/ge', false);
model.study('std1').feature('bma2').setSolveFor('/physics/ge', false);
model.study('std1').feature('freq').setSolveFor('/physics/ge', false);

model.physics('ge').prop('EquationForm').set('form', 'Automatic');

model.study.create('std2');
model.study('std2').create('stat', 'Stationary');
model.study('std2').feature('stat').setSolveFor('/physics/ewfd', false);
model.study('std2').feature('stat').setSolveFor('/physics/ge', true);

model.physics('ge').feature('ge1').setIndex('name', 'alpha', 0, 0);
model.physics('ge').feature('ge1').setIndex('equation', 'alpha-k_y*tan(k_y*h_core/2)', 0, 0);
model.physics('ge').feature('ge1').setIndex('initialValueU', 'k_core/2', 0, 0);
model.physics('ge').feature('ge1').setIndex('name', 'k_y', 1, 0);
model.physics('ge').feature('ge1').setIndex('equation', '', 1, 0);
model.physics('ge').feature('ge1').setIndex('initialValueU', 0, 1, 0);
model.physics('ge').feature('ge1').setIndex('initialValueUt', 0, 1, 0);
model.physics('ge').feature('ge1').setIndex('description', '', 1, 0);
model.physics('ge').feature('ge1').setIndex('equation', 'k_y^2-(k_core^2-k_cladding^2-alpha^2)', 1, 0);
model.physics('ge').feature('ge1').setIndex('initialValueU', 'k_core/2', 1, 0);

model.sol.create('sol4');
model.sol('sol4').study('std2');
model.sol('sol4').create('st1', 'StudyStep');
model.sol('sol4').feature('st1').set('study', 'std2');
model.sol('sol4').feature('st1').set('studystep', 'stat');
model.sol('sol4').create('v1', 'Variables');
model.sol('sol4').feature('v1').set('control', 'stat');
model.sol('sol4').create('s1', 'Stationary');
model.sol('sol4').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol4').feature('s1').feature('fc1').set('linsolver', 'dDef');
model.sol('sol4').feature('s1').feature.remove('fcDef');
model.sol('sol4').attach('std2');
model.sol('sol4').runAll;

model.result.numerical.create('gev2', 'EvalGlobal');
model.result.numerical('gev2').set('data', 'dset4');
model.result.numerical('gev2').set('expr', {'alpha' 'k_y'});
model.result.numerical('gev2').set('descr', {'State variable alpha' 'State variable k_y'});
model.result.numerical.create('gev3', 'EvalGlobal');
model.result.numerical('gev3').set('descr', {});
model.result.numerical('gev3').set('unit', {});
model.result.numerical('gev3').set('expr', {'ewfd.beta_1' 'ewfd.beta_2'});
model.result.numerical('gev3').setIndex('descr', 'Propagation constant, port 1', 0);
model.result.numerical('gev3').setIndex('descr', 'Propagation constant, port 2', 1);
model.result.table.create('tbl2', 'Table');
model.result.table('tbl2').comments('Global Evaluation 3');
model.result.numerical('gev3').set('table', 'tbl2');
model.result.numerical('gev3').setResult;
model.result.numerical.create('gev4', 'EvalGlobal');
model.result.numerical('gev4').set('data', 'dset4');
model.result.numerical('gev4').setIndex('expr', 'sqrt(k_core^2-k_y^2)', 0);
model.result.numerical('gev4').setIndex('descr', 'Propagation constant, computed', 0);
model.result.table.create('tbl3', 'Table');
model.result.table('tbl3').comments('Global Evaluation 4');
model.result.numerical('gev4').set('table', 'tbl3');
model.result.numerical('gev4').setResult;
model.result('pg1').run;

model.title('Dielectric Slab Waveguide');

model.description('A planar dielectric slab waveguide demonstrates the principles behind any kind of dielectric waveguide, for example ridge waveguides and step index fibers. This example solves for the electric and magnetic fields of a dielectric slab waveguide. The effective index is then computed and compared to the corresponding analytic result.');

model.label('dielectric_slab_waveguide.mph');

model.modelNode.label('Components');

out = model;
