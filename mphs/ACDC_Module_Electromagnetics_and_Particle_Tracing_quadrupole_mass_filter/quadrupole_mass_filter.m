function out = model
%
% quadrupole_mass_filter.m
%
% Model exported on May 26 2025, 21:25 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/ACDC_Module/Electromagnetics_and_Particle_Tracing');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 2);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.physics.create('es', 'Electrostatics', 'geom1');
model.physics('es').model('comp1');
model.physics.create('ec', 'ConductiveMedia', 'geom1');
model.physics('ec').model('comp1');
model.physics.create('cpt', 'ChargedParticleTracing', 'geom1');
model.physics('cpt').model('comp1');

% To import content from file, use:
% model.param.loadFile('FILENAME');
model.param.set('re', '2.78[mm]', 'Electrode radius');
model.param.set('r0', 're/1.147', 'Inscribed radius');
model.param.set('rsrc', '1[mm]', 'Source radius');
model.param.set('rcase', '4*r0', 'Case radius');
model.param.set('a', 'q*eta', 'Mathieu coefficient');
model.param.set('q', '0.7', 'Mathieu coefficient');
model.param.set('eta', '0.2/0.7', 'Slope for the ratio a/q');
model.param.set('f', '4[MHz]', 'Frequency');
model.param.set('omega', '2*pi*f', 'Angular frequency');
model.param.set('mi', '40[amu]', 'Argon ion mass');
model.param.set('Vac', 'q*mi*omega^2*r0^2/(4*e_const)', 'AC applied voltage magnitude');
model.param.set('Udc', 'a*mi*omega^2*r0^2/(8*e_const)', 'DC applied voltage magnitude');

model.geom('geom1').create('c1', 'Circle');
model.geom('geom1').feature('c1').set('r', 'rcase');
model.geom('geom1').run('c1');
model.geom('geom1').create('c2', 'Circle');
model.geom('geom1').feature('c2').set('r', 're');
model.geom('geom1').feature('c2').set('pos', {'re+r0' '0'});
model.geom('geom1').run('c2');
model.geom('geom1').create('c3', 'Circle');
model.geom('geom1').feature('c3').set('r', 're');
model.geom('geom1').feature('c3').set('pos', {'0' 're+r0'});
model.geom('geom1').run('c3');
model.geom('geom1').create('c4', 'Circle');
model.geom('geom1').feature('c4').set('r', 're');
model.geom('geom1').feature('c4').set('pos', {'-(re+r0)' '0'});
model.geom('geom1').run('c4');
model.geom('geom1').create('c5', 'Circle');
model.geom('geom1').feature('c5').set('r', 're');
model.geom('geom1').feature('c5').set('pos', {'0' '-(re+r0)'});
model.geom('geom1').run('c5');
model.geom('geom1').create('c6', 'Circle');
model.geom('geom1').feature('c6').set('r', 'rsrc');
model.geom('geom1').run('c6');
model.geom('geom1').create('dif1', 'Difference');
model.geom('geom1').feature('dif1').selection('input').set({'c1'});
model.geom('geom1').feature('dif1').selection('input2').set({'c2' 'c3' 'c4' 'c5'});
model.geom('geom1').runPre('fin');
model.geom('geom1').run;

model.material.create('mat1', 'Common', 'comp1');
model.material('mat1').label('Perfect vacuum');
model.material('mat1').propertyGroup('def').set('density', '');
model.material('mat1').propertyGroup('def').set('relpermeability', '');
model.material('mat1').propertyGroup('def').set('relpermittivity', '');
model.material('mat1').propertyGroup('def').set('electricconductivity', '');
model.material('mat1').propertyGroup('def').set('density', '0');
model.material('mat1').propertyGroup('def').set('relpermeability', {'1' '0' '0' '0' '1' '0' '0' '0' '1'});
model.material('mat1').propertyGroup('def').set('relpermittivity', {'1' '0' '0' '0' '1' '0' '0' '0' '1'});
model.material('mat1').propertyGroup('def').set('electricconductivity', {'0' '0' '0' '0' '0' '0' '0' '0' '0'});

model.selection.create('sel1', 'Explicit');
model.selection('sel1').model('comp1');
model.selection('sel1').label('Positive');
model.selection('sel1').geom(1);
model.selection('sel1').set([7 8 9 10 14 15 18 19]);
model.selection.create('sel2', 'Explicit');
model.selection('sel2').model('comp1');
model.selection('sel2').label('Negative');
model.selection('sel2').geom(1);
model.selection('sel2').set([3 4 5 6 21 22 23 24]);

model.physics('es').prop('EquationForm').setIndex('form', 'Stationary', 0);
model.physics('es').field('electricpotential').field('U');
model.physics('es').create('pot1', 'ElectricPotential', 1);
model.physics('es').feature('pot1').selection.named('sel1');
model.physics('es').feature('pot1').set('V0', 'Udc');
model.physics('es').create('pot2', 'ElectricPotential', 1);
model.physics('es').feature('pot2').selection.named('sel2');
model.physics('es').feature('pot2').set('V0', '-Udc');
model.physics('ec').field('electricpotential').field('V');
model.physics('ec').create('pot1', 'ElectricPotential', 1);
model.physics('ec').feature('pot1').selection.named('sel1');
model.physics('ec').feature('pot1').set('V0', 'Vac');
model.physics('ec').create('pot2', 'ElectricPotential', 1);
model.physics('ec').feature('pot2').selection.named('sel2');
model.physics('ec').feature('pot2').set('V0', '-Vac');
model.physics('cpt').feature('pp1').set('Z', 1);
model.physics('cpt').feature('pp1').set('mp', 'mi');
model.physics('cpt').prop('MaximumSecondary').setIndex('MaximumSecondary', 0, 0);
model.physics('cpt').create('rel1', 'Release', 2);
model.physics('cpt').feature('rel1').selection.set([2]);
model.physics('cpt').feature('rel1').setIndex('rt', 'range(0,2.5e-8,2.5e-7)', 0);
model.physics('cpt').create('ef1', 'ElectricForce', 2);
model.physics('cpt').feature('ef1').selection.all;
model.physics('cpt').feature('ef1').set('E_src', 'root.comp1.es.Ex');
model.physics('cpt').feature('ef1').set('UsePPR', true);
model.physics('cpt').create('ef2', 'ElectricForce', 2);
model.physics('cpt').feature('ef2').selection.all;
model.physics('cpt').feature('ef2').set('E_src', 'root.comp1.ec.Ex');
model.physics('cpt').feature('ef2').set('TimeDependenceOfField', 'TimeHarmonic');
model.physics('cpt').feature('ef2').set('UsePPR', true);

model.mesh('mesh1').autoMeshSize(2);
model.mesh('mesh1').run;

model.study.create('std1');
model.study('std1').create('param', 'Parametric');
model.study('std1').feature('param').setIndex('pname', 're', 0);
model.study('std1').feature('param').setIndex('plistarr', '', 0);
model.study('std1').feature('param').setIndex('punit', 'm', 0);
model.study('std1').feature('param').setIndex('pname', 're', 0);
model.study('std1').feature('param').setIndex('plistarr', '', 0);
model.study('std1').feature('param').setIndex('punit', 'm', 0);
model.study('std1').feature('param').setIndex('pname', 'q', 0);
model.study('std1').feature('param').setIndex('plistarr', '0.1 0.5 range(0.6,0.2/10,0.8) 1', 0);
model.study('std1').create('freq', 'Frequency');
model.study('std1').feature('freq').set('plist', '4E6');
model.study('std1').create('time', 'Transient');
model.study('std1').feature('time').set('tlist', 'range(0,2.5e-7,4.0e-5)');
model.study('std1').feature('time').setEntry('activate', 'es', false);
model.study('std1').feature('time').setEntry('activate', 'ec', false);
model.study('std1').feature('time').set('usesol', true);
model.study('std1').feature('time').set('notsolmethod', 'sol');
model.study('std1').feature('time').set('notstudy', 'std1');

model.sol.create('sol1');
model.sol('sol1').study('std1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'freq');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').set('control', 'freq');
model.sol('sol1').create('s1', 'Stationary');
model.sol('sol1').feature('s1').create('p1', 'Parametric');
model.sol('sol1').feature('s1').feature.remove('pDef');
model.sol('sol1').feature('s1').feature('p1').set('pname', {'freq'});
model.sol('sol1').feature('s1').feature('p1').set('plistarr', {'4E6'});
model.sol('sol1').feature('s1').feature('p1').set('punit', {'Hz'});
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
model.sol('sol1').feature('s1').create('seDef', 'Segregated');
model.sol('sol1').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('s1').feature('fc1').set('linsolver', 'dDef');
model.sol('sol1').feature('s1').feature.remove('fcDef');
model.sol('sol1').feature('s1').feature.remove('seDef');
model.sol('sol1').create('su1', 'StoreSolution');
model.sol('sol1').create('st2', 'StudyStep');
model.sol('sol1').feature('st2').set('study', 'std1');
model.sol('sol1').feature('st2').set('studystep', 'time');
model.sol('sol1').create('v2', 'Variables');
model.sol('sol1').feature('v2').set('initmethod', 'sol');
model.sol('sol1').feature('v2').set('initsol', 'sol1');
model.sol('sol1').feature('v2').set('initsoluse', 'sol2');
model.sol('sol1').feature('v2').set('notsolmethod', 'sol');
model.sol('sol1').feature('v2').set('notsol', 'sol1');
model.sol('sol1').feature('v2').set('notsoluse', 'sol2');
model.sol('sol1').feature('v2').set('control', 'time');
model.sol('sol1').create('t1', 'Time');
model.sol('sol1').feature('t1').set('tlist', 'range(0,2.5e-7,4.0e-5)');
model.sol('sol1').feature('t1').set('plot', 'off');
model.sol('sol1').feature('t1').set('plotgroup', 'Default');
model.sol('sol1').feature('t1').set('plotfreq', 'tout');
model.sol('sol1').feature('t1').set('probesel', 'all');
model.sol('sol1').feature('t1').set('probes', {});
model.sol('sol1').feature('t1').set('probefreq', 'tsteps');
model.sol('sol1').feature('t1').set('rtol', 1.0E-5);
model.sol('sol1').feature('t1').set('atolglobalvaluemethod', 'factor');
model.sol('sol1').feature('t1').set('reacf', true);
model.sol('sol1').feature('t1').set('storeudot', true);
model.sol('sol1').feature('t1').set('tstepsgenalpha', 'strict');
model.sol('sol1').feature('t1').set('endtimeinterpolation', true);
model.sol('sol1').feature('t1').set('timemethod', 'genalpha');
model.sol('sol1').feature('t1').set('estrat', 'exclude');
model.sol('sol1').feature('t1').set('control', 'time');
model.sol('sol1').feature('t1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('t1').feature('fc1').set('ntolfact', 0.1);
model.sol('sol1').feature('t1').create('i1', 'Iterative');
model.sol('sol1').feature('t1').feature('i1').set('linsolver', 'gmres');
model.sol('sol1').feature('t1').feature('i1').create('ja1', 'Jacobi');
model.sol('sol1').feature('t1').feature('fc1').set('linsolver', 'i1');
model.sol('sol1').feature('t1').feature('fc1').set('ntolfact', 0.1);
model.sol('sol1').feature('t1').feature.remove('fcDef');
model.sol('sol1').feature('v2').set('notsolnum', 'auto');
model.sol('sol1').feature('v2').set('notsolvertype', 'solnum');
model.sol('sol1').attach('std1');

model.batch.create('p1', 'Parametric');
model.batch('p1').study('std1');
model.batch('p1').create('so1', 'Solutionseq');
model.batch('p1').feature('so1').set('seq', 'sol1');
model.batch('p1').feature('so1').set('store', 'on');
model.batch('p1').feature('so1').set('clear', 'on');
model.batch('p1').feature('so1').set('psol', 'none');
model.batch('p1').set('pname', {'q'});
model.batch('p1').set('plistarr', {'0.1 0.5 range(0.6,0.2/10,0.8) 1'});
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
model.result('pg1').label('Electric Potential (es)');
model.result('pg1').set('data', 'dset3');
model.result('pg1').setIndex('looplevel', 161, 0);
model.result('pg1').setIndex('looplevel', 14, 1);
model.result('pg1').set('frametype', 'spatial');
model.result('pg1').set('showlegendsmaxmin', true);
model.result('pg1').set('data', 'dset3');
model.result('pg1').setIndex('looplevel', 161, 0);
model.result('pg1').setIndex('looplevel', 14, 1);
model.result('pg1').set('defaultPlotID', 'InterfaceComponents/PlotDefaults/icom2/pdef1/pcond2/pcond2/pg1');
model.result('pg1').feature.create('surf1', 'Surface');
model.result('pg1').feature('surf1').set('showsolutionparams', 'on');
model.result('pg1').feature('surf1').set('solutionparams', 'parent');
model.result('pg1').feature('surf1').set('colortable', 'Dipole');
model.result('pg1').feature('surf1').set('showsolutionparams', 'on');
model.result('pg1').feature('surf1').set('data', 'parent');
model.result('pg1').feature.create('str1', 'Streamline');
model.result('pg1').feature('str1').set('showsolutionparams', 'on');
model.result('pg1').feature('str1').set('solutionparams', 'parent');
model.result('pg1').feature('str1').set('titletype', 'none');
model.result('pg1').feature('str1').set('posmethod', 'uniform');
model.result('pg1').feature('str1').set('udist', 0.02);
model.result('pg1').feature('str1').set('maxlen', 0.4);
model.result('pg1').feature('str1').set('maxtime', Inf);
model.result('pg1').feature('str1').set('inheritcolor', false);
model.result('pg1').feature('str1').set('showsolutionparams', 'on');
model.result('pg1').feature('str1').set('maxtime', Inf);
model.result('pg1').feature('str1').set('showsolutionparams', 'on');
model.result('pg1').feature('str1').set('maxtime', Inf);
model.result('pg1').feature('str1').set('showsolutionparams', 'on');
model.result('pg1').feature('str1').set('maxtime', Inf);
model.result('pg1').feature('str1').set('showsolutionparams', 'on');
model.result('pg1').feature('str1').set('maxtime', Inf);
model.result('pg1').feature('str1').set('data', 'parent');
model.result('pg1').feature('str1').selection.geom('geom1', 1);
model.result('pg1').feature('str1').selection.set([1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24]);
model.result('pg1').feature('str1').set('inheritplot', 'surf1');
model.result('pg1').feature('str1').feature.create('col1', 'Color');
model.result('pg1').feature('str1').feature('col1').set('colortable', 'DipoleDark');
model.result('pg1').feature('str1').feature('col1').set('colorlegend', false);
model.result('pg1').feature('str1').feature.create('filt1', 'Filter');
model.result('pg1').feature('str1').feature('filt1').set('expr', '!isScalingSystemDomain');
model.result.create('pg2', 'PlotGroup2D');
model.result('pg2').label('Electric Field Norm (es)');
model.result('pg2').set('data', 'dset3');
model.result('pg2').setIndex('looplevel', 161, 0);
model.result('pg2').setIndex('looplevel', 14, 1);
model.result('pg2').set('frametype', 'spatial');
model.result('pg2').set('showlegendsmaxmin', true);
model.result('pg2').set('data', 'dset3');
model.result('pg2').setIndex('looplevel', 161, 0);
model.result('pg2').setIndex('looplevel', 14, 1);
model.result('pg2').set('defaultPlotID', 'InterfaceComponents/PlotDefaults/icom3/pdef1/pcond2/pcond2/pg1');
model.result('pg2').feature.create('surf1', 'Surface');
model.result('pg2').feature('surf1').set('showsolutionparams', 'on');
model.result('pg2').feature('surf1').set('solutionparams', 'parent');
model.result('pg2').feature('surf1').set('expr', 'es.normE');
model.result('pg2').feature('surf1').set('colortable', 'Prism');
model.result('pg2').feature('surf1').set('colortabletrans', 'nonlinear');
model.result('pg2').feature('surf1').set('colorcalibration', -0.8);
model.result('pg2').feature('surf1').set('showsolutionparams', 'on');
model.result('pg2').feature('surf1').set('data', 'parent');
model.result('pg2').feature.create('str1', 'Streamline');
model.result('pg2').feature('str1').set('showsolutionparams', 'on');
model.result('pg2').feature('str1').set('solutionparams', 'parent');
model.result('pg2').feature('str1').set('titletype', 'none');
model.result('pg2').feature('str1').set('posmethod', 'uniform');
model.result('pg2').feature('str1').set('udist', 0.02);
model.result('pg2').feature('str1').set('maxlen', 0.4);
model.result('pg2').feature('str1').set('maxtime', Inf);
model.result('pg2').feature('str1').set('inheritcolor', false);
model.result('pg2').feature('str1').set('showsolutionparams', 'on');
model.result('pg2').feature('str1').set('maxtime', Inf);
model.result('pg2').feature('str1').set('showsolutionparams', 'on');
model.result('pg2').feature('str1').set('maxtime', Inf);
model.result('pg2').feature('str1').set('showsolutionparams', 'on');
model.result('pg2').feature('str1').set('maxtime', Inf);
model.result('pg2').feature('str1').set('showsolutionparams', 'on');
model.result('pg2').feature('str1').set('maxtime', Inf);
model.result('pg2').feature('str1').set('data', 'parent');
model.result('pg2').feature('str1').selection.geom('geom1', 1);
model.result('pg2').feature('str1').selection.set([1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24]);
model.result('pg2').feature('str1').set('inheritplot', 'surf1');
model.result('pg2').feature('str1').feature.create('col1', 'Color');
model.result('pg2').feature('str1').feature('col1').set('expr', 'es.normE');
model.result('pg2').feature('str1').feature('col1').set('colortable', 'PrismDark');
model.result('pg2').feature('str1').feature('col1').set('colorlegend', false);
model.result('pg2').feature('str1').feature('col1').set('colortabletrans', 'nonlinear');
model.result('pg2').feature('str1').feature('col1').set('colorcalibration', -0.8);
model.result('pg2').feature('str1').feature.create('filt1', 'Filter');
model.result('pg2').feature('str1').feature('filt1').set('expr', '!isScalingSystemDomain');
model.result.create('pg3', 'PlotGroup2D');
model.result('pg3').label('Electric Potential (ec)');
model.result('pg3').set('data', 'dset3');
model.result('pg3').setIndex('looplevel', 161, 0);
model.result('pg3').setIndex('looplevel', 14, 1);
model.result('pg3').set('frametype', 'spatial');
model.result('pg3').set('showlegendsmaxmin', true);
model.result('pg3').set('data', 'dset3');
model.result('pg3').setIndex('looplevel', 161, 0);
model.result('pg3').setIndex('looplevel', 14, 1);
model.result('pg3').set('defaultPlotID', 'InterfaceComponents/PlotDefaults/icom2/pdef1/pcond2/pcond2/pg1');
model.result('pg3').feature.create('surf1', 'Surface');
model.result('pg3').feature('surf1').set('showsolutionparams', 'on');
model.result('pg3').feature('surf1').set('solutionparams', 'parent');
model.result('pg3').feature('surf1').set('expr', 'V');
model.result('pg3').feature('surf1').set('colortable', 'Dipole');
model.result('pg3').feature('surf1').set('showsolutionparams', 'on');
model.result('pg3').feature('surf1').set('data', 'parent');
model.result('pg3').feature.create('str1', 'Streamline');
model.result('pg3').feature('str1').set('showsolutionparams', 'on');
model.result('pg3').feature('str1').set('solutionparams', 'parent');
model.result('pg3').feature('str1').set('expr', {'ec.Ex' 'ec.Ey'});
model.result('pg3').feature('str1').set('titletype', 'none');
model.result('pg3').feature('str1').set('posmethod', 'uniform');
model.result('pg3').feature('str1').set('udist', 0.02);
model.result('pg3').feature('str1').set('maxlen', 0.4);
model.result('pg3').feature('str1').set('maxtime', Inf);
model.result('pg3').feature('str1').set('inheritcolor', false);
model.result('pg3').feature('str1').set('showsolutionparams', 'on');
model.result('pg3').feature('str1').set('maxtime', Inf);
model.result('pg3').feature('str1').set('showsolutionparams', 'on');
model.result('pg3').feature('str1').set('maxtime', Inf);
model.result('pg3').feature('str1').set('showsolutionparams', 'on');
model.result('pg3').feature('str1').set('maxtime', Inf);
model.result('pg3').feature('str1').set('showsolutionparams', 'on');
model.result('pg3').feature('str1').set('maxtime', Inf);
model.result('pg3').feature('str1').set('data', 'parent');
model.result('pg3').feature('str1').selection.geom('geom1', 1);
model.result('pg3').feature('str1').selection.set([1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24]);
model.result('pg3').feature('str1').set('inheritplot', 'surf1');
model.result('pg3').feature('str1').feature.create('col1', 'Color');
model.result('pg3').feature('str1').feature('col1').set('expr', 'V');
model.result('pg3').feature('str1').feature('col1').set('colortable', 'DipoleDark');
model.result('pg3').feature('str1').feature('col1').set('colorlegend', false);
model.result('pg3').feature('str1').feature.create('filt1', 'Filter');
model.result('pg3').feature('str1').feature('filt1').set('expr', '!isScalingSystemDomain');
model.result.create('pg4', 'PlotGroup2D');
model.result('pg4').label('Electric Field Norm (ec)');
model.result('pg4').set('data', 'dset3');
model.result('pg4').setIndex('looplevel', 161, 0);
model.result('pg4').setIndex('looplevel', 14, 1);
model.result('pg4').set('frametype', 'spatial');
model.result('pg4').set('showlegendsmaxmin', true);
model.result('pg4').set('data', 'dset3');
model.result('pg4').setIndex('looplevel', 161, 0);
model.result('pg4').setIndex('looplevel', 14, 1);
model.result('pg4').set('defaultPlotID', 'InterfaceComponents/PlotDefaults/icom3/pdef1/pcond2/pcond2/pg1');
model.result('pg4').feature.create('surf1', 'Surface');
model.result('pg4').feature('surf1').set('showsolutionparams', 'on');
model.result('pg4').feature('surf1').set('solutionparams', 'parent');
model.result('pg4').feature('surf1').set('expr', 'ec.normE');
model.result('pg4').feature('surf1').set('colortable', 'Prism');
model.result('pg4').feature('surf1').set('colortabletrans', 'nonlinear');
model.result('pg4').feature('surf1').set('colorcalibration', -0.8);
model.result('pg4').feature('surf1').set('showsolutionparams', 'on');
model.result('pg4').feature('surf1').set('data', 'parent');
model.result('pg4').feature.create('str1', 'Streamline');
model.result('pg4').feature('str1').set('showsolutionparams', 'on');
model.result('pg4').feature('str1').set('solutionparams', 'parent');
model.result('pg4').feature('str1').set('expr', {'ec.Ex' 'ec.Ey'});
model.result('pg4').feature('str1').set('titletype', 'none');
model.result('pg4').feature('str1').set('posmethod', 'uniform');
model.result('pg4').feature('str1').set('udist', 0.02);
model.result('pg4').feature('str1').set('maxlen', 0.4);
model.result('pg4').feature('str1').set('maxtime', Inf);
model.result('pg4').feature('str1').set('inheritcolor', false);
model.result('pg4').feature('str1').set('showsolutionparams', 'on');
model.result('pg4').feature('str1').set('maxtime', Inf);
model.result('pg4').feature('str1').set('showsolutionparams', 'on');
model.result('pg4').feature('str1').set('maxtime', Inf);
model.result('pg4').feature('str1').set('showsolutionparams', 'on');
model.result('pg4').feature('str1').set('maxtime', Inf);
model.result('pg4').feature('str1').set('showsolutionparams', 'on');
model.result('pg4').feature('str1').set('maxtime', Inf);
model.result('pg4').feature('str1').set('data', 'parent');
model.result('pg4').feature('str1').selection.geom('geom1', 1);
model.result('pg4').feature('str1').selection.set([1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24]);
model.result('pg4').feature('str1').set('inheritplot', 'surf1');
model.result('pg4').feature('str1').feature.create('col1', 'Color');
model.result('pg4').feature('str1').feature('col1').set('expr', 'ec.normE');
model.result('pg4').feature('str1').feature('col1').set('colortable', 'PrismDark');
model.result('pg4').feature('str1').feature('col1').set('colorlegend', false);
model.result('pg4').feature('str1').feature('col1').set('colortabletrans', 'nonlinear');
model.result('pg4').feature('str1').feature('col1').set('colorcalibration', -0.8);
model.result('pg4').feature('str1').feature.create('filt1', 'Filter');
model.result('pg4').feature('str1').feature('filt1').set('expr', '!isScalingSystemDomain');
model.result.dataset.create('part1', 'Particle');
model.result.dataset('part1').set('solution', 'sol3');
model.result.dataset('part1').set('posdof', {'comp1.qx' 'comp1.qy'});
model.result.dataset('part1').set('geom', 'geom1');
model.result.dataset('part1').set('pgeom', 'pgeom_cpt');
model.result.dataset('part1').set('pgeomspec', 'fromphysics');
model.result.dataset('part1').set('physicsinterface', 'cpt');
model.result.create('pg5', 'PlotGroup2D');
model.result('pg5').set('data', 'part1');
model.result('pg5').setIndex('looplevel', 161, 0);
model.result('pg5').setIndex('looplevel', 14, 1);
model.result('pg5').label('Particle Trajectories (cpt)');
model.result('pg5').create('traj1', 'ParticleTrajectories');
model.result('pg5').feature('traj1').set('pointtype', 'point');
model.result('pg5').feature('traj1').set('linetype', 'none');
model.result('pg5').feature('traj1').create('col1', 'Color');
model.result('pg5').feature('traj1').feature('col1').set('expr', 'cpt.V');
model.result('pg1').run;
model.result('pg5').run;
model.result('pg5').setIndex('looplevel', 1, 1);
model.result('pg5').run;
model.result('pg5').setIndex('looplevel', 3, 1);
model.result('pg5').run;
model.result('pg5').setIndex('looplevel', 8, 1);
model.result('pg5').run;
model.result('pg5').setIndex('looplevel', 14, 1);
model.result('pg5').run;
model.result.dataset.duplicate('part2', 'part1');
model.result.dataset('part2').selection.geom('geom1', 1);
model.result.dataset('part2').selection.all;
model.result.dataset('part2').selection.set([1 2 3 4 5 6 7 8 9 10 13 14 15 18 19 20 21 22 23 24]);
model.result.create('pg6', 'PlotGroup1D');
model.result('pg6').run;
model.result('pg6').label('Transmission Probability');
model.result('pg6').set('data', 'part2');
model.result('pg6').setIndex('looplevelinput', 'last', 0);
model.result('pg6').create('glob1', 'Global');
model.result('pg6').feature('glob1').set('markerpos', 'datapoints');
model.result('pg6').feature('glob1').set('linewidth', 'preference');
model.result('pg6').feature('glob1').setIndex('expr', '1-cpt.alpha', 0);
model.result('pg6').feature('glob1').setIndex('descr', 'Transmission probability', 0);
model.result('pg6').feature('glob1').set('xdatasolnumtype', 'outer');
model.result('pg6').feature('glob1').set('legend', false);
model.result('pg6').run;
model.result('pg5').run;

model.title('Quadrupole Mass Filter');

model.description(['This example describes the operating principle of a quadrupole ion trap, the key component of a quadrupole mass spectrometer. There are both AC and DC components of the electric field.' newline  newline 'This example requires the Particle Tracing Module.']);

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

model.label('quadrupole_mass_filter.mph');

model.modelNode.label('Components');

out = model;
