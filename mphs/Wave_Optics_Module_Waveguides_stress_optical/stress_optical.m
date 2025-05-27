function out = model
%
% stress_optical.m
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

model.physics.create('solid', 'SolidMechanics', 'geom1');
model.physics('solid').model('comp1');
model.physics.create('ewfd', 'ElectromagneticWavesFrequencyDomain', 'geom1');
model.physics('ewfd').model('comp1');

model.study.create('std1');
model.study('std1').create('stat', 'Stationary');
model.study('std1').feature('stat').setSolveFor('/physics/solid', true);
model.study('std1').feature('stat').setSolveFor('/physics/ewfd', true);

% To import content from file, use:
% model.param.loadFile('FILENAME');
model.param.set('nSi', '3.5', 'Refractive index, silicon (Si)');
model.param.set('nSiO2', '1.445', 'Refractive index, silica (SiO2)');
model.param.set('deltan', '0.0075', 'Relative index difference');
model.param.set('nCore', 'nSiO2/sqrt(1-2*deltan)', 'Refractive index, core (doped SiO2)');
model.param.set('alphaSi', '2.5e-6[1/K]', 'Thermal expansion coefficient, silicon');
model.param.set('alphaSiO2', '0.35e-6[1/K]', 'Thermal expansion coefficient, silica');
model.param.set('ESi', '110[GPa]', 'Young''s modulus, silicon');
model.param.set('ESiO2', '78[GPa]', 'Young''s modulus, silica');
model.param.set('nuSi', '0.19', 'Poisson''s ratio, silicon');
model.param.set('nuSiO2', '0.17', 'Poisson''s ratio, silica');
model.param.set('rhoSi', '2330[kg/m^3]', 'Density, silicon');
model.param.set('rhoSiO2', '2203[kg/m^3]', 'Density, silica');
model.param.set('B1', '0.65e-12[m^2/N]', 'First stress optical coefficient');
model.param.set('B2', '4.2e-12[m^2/N]', 'Second stress optical coefficient');
model.param.set('T1', '20[degC]', 'Operating temperature');
model.param.set('T0', '1000[degC]', 'Reference temperature');
model.param.set('lambda0_ewfd', '1.55[um]', 'Free space wavelength');
model.param.set('d', '2[mm]', 'Out-of-plane extension');
model.param.rename('d', 'para');
model.param.set('para', '1');
model.param.descr('para', '1: stress-optical coupling, 0: no coupling');

model.geom('geom1').lengthUnit([native2unicode(hex2dec({'00' 'b5'}), 'unicode') 'm']);
model.geom('geom1').create('r1', 'Rectangle');
model.geom('geom1').feature('r1').set('size', [320 83]);
model.geom('geom1').feature('r1').set('pos', [-160 -100]);
model.geom('geom1').run('r1');
model.geom('geom1').create('r2', 'Rectangle');
model.geom('geom1').feature('r2').set('size', [320 14]);
model.geom('geom1').feature('r2').set('pos', [-160 -17]);
model.geom('geom1').run('r2');
model.geom('geom1').create('r3', 'Rectangle');
model.geom('geom1').feature('r3').set('size', [320 16]);
model.geom('geom1').feature('r3').set('pos', [-160 -3]);
model.geom('geom1').run('r3');
model.geom('geom1').create('r4', 'Rectangle');
model.geom('geom1').feature('r4').set('size', [6 6]);
model.geom('geom1').feature('r4').set('pos', [-3 -3]);
model.geom('geom1').run('r4');
model.geom('geom1').create('r5', 'Rectangle');
model.geom('geom1').feature('r5').set('size', [20 20]);
model.geom('geom1').feature('r5').set('pos', [-10 -10]);
model.geom('geom1').run('r5');
model.geom('geom1').run;

model.physics('solid').feature('lemm1').create('te1', 'ThermalExpansion', 2);
model.physics('solid').feature('lemm1').feature('te1').set('minput_temperature_src', 'userdef');
model.physics('solid').feature('lemm1').feature('te1').set('minput_temperature', 'T1');

model.common('cminpt').set('modified', {'strainreferencetemperature' 'T0'});

model.variable.create('var1');
model.variable('var1').model('comp1');
model.variable('var1').set('N', 'nCore');
model.variable('var1').descr('N', 'Refractive index for stress-free material');
model.variable('var1').selection.geom('geom1', 2);
model.variable('var1').selection.set([6]);
model.variable.create('var2');
model.variable('var2').model('comp1');
model.variable('var2').set('N', 'nSiO2', 'Refractive index for stress-free material');
model.variable('var2').descr('N', 'Refractive index for stress-free material');
model.variable('var2').selection.geom('geom1', 2);
model.variable('var2').selection.set([4 5]);
model.variable.create('var3');
model.variable('var3').model('comp1');
model.variable('var3').set('Nx', 'N-para*(B1*solid.sx+B2*(solid.sy+solid.sz))');
model.variable('var3').descr('Nx', 'Refractive index, x-component');
model.variable('var3').set('Ny', 'N-para*(B1*solid.sy+B2*(solid.sx+solid.sz))');
model.variable('var3').descr('Ny', 'Refractive index, y-component');
model.variable('var3').set('Nz', 'N-para*(B1*solid.sz+B2*(solid.sx+solid.sy))');
model.variable('var3').descr('Nz', 'Refractive index, z-component');
model.variable('var3').selection.geom('geom1', 2);
model.variable('var3').selection.set([4 5 6]);

model.physics('solid').create('rms1', 'RigidMotionSuppression', 2);
model.physics('solid').feature('rms1').selection.set([1]);
model.physics('ewfd').selection.set([4 5 6]);
model.physics('ewfd').feature('wee1').set('n_mat', 'userdef');
model.physics('ewfd').feature('wee1').set('n', {'Nx' '0' '0' '0' 'Ny' '0' '0' '0' 'Nz'});
model.physics('ewfd').feature('wee1').set('ki_mat', 'userdef');

model.material.create('mat1', 'Common', 'comp1');
model.material('mat1').label('Si');
model.material('mat1').selection.set([1]);
model.material('mat1').propertyGroup.create('Enu', 'Young''s_modulus_and_Poisson''s_ratio');
model.material('mat1').propertyGroup('Enu').set('E', {'ESi'});
model.material('mat1').propertyGroup('Enu').set('nu', {'nuSi'});
model.material('mat1').propertyGroup('def').set('density', {'rhoSi'});
model.material('mat1').propertyGroup('def').set('thermalexpansioncoefficient', {'alphaSi'});
model.material.create('mat2', 'Common', 'comp1');
model.material('mat2').label('SiO2');
model.material('mat2').selection.set([2 3 4 5 6]);
model.material('mat2').propertyGroup.create('Enu', 'Young''s_modulus_and_Poisson''s_ratio');
model.material('mat2').propertyGroup('Enu').set('E', {'ESiO2'});
model.material('mat2').propertyGroup('Enu').set('nu', {'nuSiO2'});
model.material('mat2').propertyGroup('def').set('density', {'rhoSiO2'});
model.material('mat2').propertyGroup('def').set('thermalexpansioncoefficient', {'alphaSiO2'});

model.mesh('mesh1').create('ftri1', 'FreeTri');
model.mesh('mesh1').feature('ftri1').create('size1', 'Size');
model.mesh('mesh1').feature('ftri1').feature('size1').selection.geom('geom1', 2);
model.mesh('mesh1').feature('ftri1').feature('size1').selection.set([4 5 6]);
model.mesh('mesh1').feature('ftri1').feature('size1').set('custom', true);
model.mesh('mesh1').feature('ftri1').feature('size1').set('hmaxactive', true);
model.mesh('mesh1').feature('ftri1').feature('size1').set('hmax', 0.2);
model.mesh('mesh1').feature('size').set('hauto', 2);
model.mesh('mesh1').run;

model.study('std1').create('mode', 'ModeAnalysis');
model.study('std1').feature('mode').set('transform', 'effective_mode_index');
model.study('std1').feature('mode').set('shift', '1.46');
model.study('std1').feature('mode').set('neigsactive', true);
model.study('std1').feature('mode').set('neigs', 4);
model.study('std1').feature('mode').set('modeFreq', 'c_const/lambda0_ewfd');
model.study('std1').feature('mode').setEntry('activate', 'solid', false);
model.study('std1').create('param', 'Parametric');
model.study('std1').feature('param').setIndex('pname', 'nSi', 0);
model.study('std1').feature('param').setIndex('plistarr', '', 0);
model.study('std1').feature('param').setIndex('punit', '', 0);
model.study('std1').feature('param').setIndex('pname', 'nSi', 0);
model.study('std1').feature('param').setIndex('plistarr', '', 0);
model.study('std1').feature('param').setIndex('punit', '', 0);
model.study('std1').feature('param').setIndex('pname', 'para', 0);
model.study('std1').feature('param').setIndex('plistarr', '0 1', 0);

model.sol.create('sol1');
model.sol('sol1').study('std1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'stat');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').set('control', 'stat');
model.sol('sol1').create('s1', 'Stationary');
model.sol('sol1').feature('s1').feature('aDef').set('cachepattern', true);
model.sol('sol1').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('s1').feature('fc1').set('termonres', 'auto');
model.sol('sol1').feature('s1').feature('fc1').set('reserrfact', 1000);
model.sol('sol1').feature('s1').feature('fc1').set('linsolver', 'dDef');
model.sol('sol1').feature('s1').feature('fc1').set('termonres', 'auto');
model.sol('sol1').feature('s1').feature('fc1').set('reserrfact', 1000);
model.sol('sol1').feature('s1').feature.remove('fcDef');
model.sol('sol1').create('su1', 'StoreSolution');
model.sol('sol1').create('st2', 'StudyStep');
model.sol('sol1').feature('st2').set('study', 'std1');
model.sol('sol1').feature('st2').set('studystep', 'mode');
model.sol('sol1').create('v2', 'Variables');
model.sol('sol1').feature('v2').set('initmethod', 'sol');
model.sol('sol1').feature('v2').set('initsol', 'sol1');
model.sol('sol1').feature('v2').set('notsolmethod', 'sol');
model.sol('sol1').feature('v2').set('notsol', 'sol1');
model.sol('sol1').feature('v2').set('control', 'mode');
model.sol('sol1').create('e1', 'Eigenvalue');
model.sol('sol1').feature('e1').set('neigs', 6);
model.sol('sol1').feature('e1').set('shift', '1');
model.sol('sol1').feature('e1').set('control', 'mode');
model.sol('sol1').feature('e1').set('linpmethod', 'sol');
model.sol('sol1').feature('e1').set('linpsol', 'sol1');
model.sol('sol1').feature('e1').set('linpsoluse', 'sol2');
model.sol('sol1').feature('e1').set('control', 'mode');
model.sol('sol1').feature('e1').feature('aDef').set('complexfun', true);
model.sol('sol1').feature('e1').feature('aDef').set('cachepattern', false);
model.sol('sol1').feature('e1').create('d1', 'Direct');
model.sol('sol1').feature('e1').feature('d1').set('linsolver', 'mumps');
model.sol('sol1').feature('e1').feature('d1').label('Suggested Direct Solver (ewfd)');
model.sol('sol1').feature('v2').set('notsolnum', 'auto');
model.sol('sol1').feature('v2').set('notsolvertype', 'solnum');
model.sol('sol1').feature('v2').set('solnum', 'auto');
model.sol('sol1').feature('v2').set('solvertype', 'solnum');
model.sol('sol1').attach('std1');

model.batch.create('p1', 'Parametric');
model.batch('p1').study('std1');
model.batch('p1').create('so1', 'Solutionseq');
model.batch('p1').feature('so1').set('seq', 'sol1');
model.batch('p1').feature('so1').set('store', 'on');
model.batch('p1').feature('so1').set('clear', 'on');
model.batch('p1').feature('so1').set('psol', 'none');
model.batch('p1').set('pname', {'para'});
model.batch('p1').set('plistarr', {'0 1'});
model.batch('p1').set('sweeptype', 'sparse');
model.batch('p1').set('probesel', 'all');
model.batch('p1').set('probes', {});
model.batch('p1').set('plot', 'off');
model.batch('p1').set('err', 'on');
model.batch('p1').attach('std1');
model.batch('p1').set('control', 'param');

model.sol.create('sol3');
model.sol('sol3').study('std1');
model.sol('sol3').label('Parametric Solutions 1');

model.batch('p1').feature('so1').set('psol', 'sol3');
model.batch('p1').run('compute');

model.result.create('pg1', 'PlotGroup2D');
model.result('pg1').set('data', 'dset3');
model.result('pg1').setIndex('looplevel', 1, 0);
model.result('pg1').setIndex('looplevel', 2, 1);
model.result('pg1').set('defaultPlotID', 'stress');
model.result('pg1').label('Stress (solid)');
model.result('pg1').set('frametype', 'spatial');
model.result('pg1').create('surf1', 'Surface');
model.result('pg1').feature('surf1').set('expr', {'solid.misesGp'});
model.result('pg1').feature('surf1').set('threshold', 'manual');
model.result('pg1').feature('surf1').set('thresholdvalue', 0.2);
model.result('pg1').feature('surf1').set('colortable', 'Rainbow');
model.result('pg1').feature('surf1').set('colortabletrans', 'none');
model.result('pg1').feature('surf1').set('colorscalemode', 'linear');
model.result('pg1').feature('surf1').set('resolution', 'normal');
model.result('pg1').feature('surf1').set('colortable', 'Prism');
model.result('pg1').feature('surf1').create('def', 'Deform');
model.result('pg1').feature('surf1').feature('def').set('expr', {'u' 'v'});
model.result('pg1').feature('surf1').feature('def').set('descr', 'Displacement field');
model.result.create('pg2', 'PlotGroup2D');
model.result('pg2').label('Electric Field (ewfd)');
model.result('pg2').set('data', 'dset3');
model.result('pg2').setIndex('looplevel', 1, 0);
model.result('pg2').setIndex('looplevel', 2, 1);
model.result('pg2').set('frametype', 'spatial');
model.result('pg2').set('data', 'dset3');
model.result('pg2').setIndex('looplevel', 1, 0);
model.result('pg2').setIndex('looplevel', 2, 1);
model.result('pg2').set('defaultPlotID', 'ElectromagneticWavesFrequencyDomain/phys1/pdef1/pcond2/pg1');
model.result('pg2').feature.create('surf1', 'Surface');
model.result('pg2').feature('surf1').set('expr', 'ewfd.normE');
model.result('pg2').feature('surf1').set('colortable', 'RainbowLight');
model.result('pg2').feature('surf1').set('smooth', 'internal');
model.result('pg2').feature('surf1').set('data', 'parent');
model.result('pg1').run;
model.result('pg1').set('data', 'dset2');
model.result('pg1').run;

model.view.create('view2', 2);
model.view('view2').set('locked', true);
model.view('view2').axis.set('xmin', -11);
model.view('view2').axis.set('xmax', 11);
model.view('view2').axis.set('ymin', -11);
model.view('view2').axis.set('ymax', 11);

model.result('pg2').run;
model.result('pg2').set('view', 'view2');
model.result('pg2').run;
model.result('pg2').feature('surf1').set('expr', 'ewfd.Poavz');
model.result('pg2').feature('surf1').set('descr', 'Power flow, time average, z-component');
model.result('pg2').run;
model.result('pg2').set('looplevel', [1 1]);
model.result('pg2').run;
model.result('pg2').set('looplevel', [2 1]);
model.result('pg2').run;
model.result('pg2').set('looplevel', [3 1]);
model.result('pg2').run;
model.result('pg2').set('looplevel', [4 1]);
model.result('pg2').run;
model.result('pg2').set('looplevel', [1 2]);
model.result('pg2').run;
model.result('pg2').set('looplevel', [2 2]);
model.result('pg2').run;
model.result('pg2').set('looplevel', [3 2]);
model.result('pg2').run;
model.result('pg2').set('looplevel', [4 2]);
model.result('pg2').run;
model.result.create('pg3', 'PlotGroup2D');
model.result('pg3').run;
model.result('pg3').set('data', 'dset2');
model.result('pg3').set('view', 'view2');
model.result('pg3').set('titletype', 'manual');
model.result('pg3').set('title', 'Surface: Nx-Ny');
model.result('pg3').create('surf1', 'Surface');
model.result('pg3').feature('surf1').set('expr', 'Nx-Ny');
model.result('pg3').run;
model.result.numerical.create('gev1', 'EvalGlobal');
model.result.numerical('gev1').set('data', 'dset3');
model.result.numerical('gev1').set('tablecols', 'inner');
model.result.numerical('gev1').set('expr', {'ewfd.neff'});
model.result.numerical('gev1').set('descr', {'Effective mode index'});
model.result.numerical('gev1').set('unit', {'1'});
model.result.table.create('tbl1', 'Table');
model.result.table('tbl1').comments('Global Evaluation 1');
model.result.numerical('gev1').set('table', 'tbl1');
model.result.numerical('gev1').setResult;
model.result.create('pg4', 'PlotGroup1D');
model.result('pg4').run;
model.result('pg4').create('tblp1', 'Table');
model.result('pg4').feature('tblp1').set('markerpos', 'datapoints');
model.result('pg4').feature('tblp1').set('linewidth', 'preference');
model.result('pg4').feature('tblp1').set('linestyle', 'dashed');
model.result('pg4').feature('tblp1').set('linemarker', 'circle');
model.result('pg4').feature('tblp1').set('markerpos', 'interp');
model.result('pg4').run;
model.result('pg4').set('titletype', 'manual');
model.result('pg4').set('title', 'Eigenvalue shift');
model.result('pg4').set('axislimits', true);
model.result('pg4').set('xmin', 0);
model.result('pg4').set('xmax', 1);
model.result('pg4').set('ymin', 1.443);
model.result('pg4').set('ymax', 1.453);
model.result('pg4').set('manualgrid', true);
model.result('pg4').set('yspacing', '1e-3');
model.result('pg4').run;
model.result('pg2').run;

model.title('Stress-Optical Effects in a Photonic Waveguide');

model.description('The stress-optical effect causes unwanted birefringence in a planar photonic waveguide. Plane strain analysis followed by an optical mode analysis show the resulting split of the fundamental modes.');

model.mesh.clearMeshes;

model.sol('sol1').clearSolutionData;
model.sol('sol2').clearSolutionData;
model.sol('sol3').clearSolutionData;
model.sol('sol4').clearSolutionData;
model.sol('sol5').clearSolutionData;

model.label('stress_optical.mph');

model.modelNode.label('Components');

out = model;
