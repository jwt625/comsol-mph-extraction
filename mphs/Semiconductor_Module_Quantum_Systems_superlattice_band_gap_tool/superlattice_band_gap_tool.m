function out = model
%
% superlattice_band_gap_tool.m
%
% Model exported on May 26 2025, 21:33 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/Semiconductor_Module/Quantum_Systems');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 1);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.physics.create('schr', 'SchrodingerEquation', 'geom1', {'psi'});

model.study.create('std1');
model.study('std1').create('eigv', 'Eigenvalue');
model.study('std1').feature('eigv').set('neigs', '3');
model.study('std1').feature('eigv').set('eigunit', '');
model.study('std1').feature('eigv').set('shift', '0.1');
model.study('std1').feature('eigv').set('conrad', '1');
model.study('std1').feature('eigv').set('conradynhm', '1');
model.study('std1').feature('eigv').set('conlbdy', '0');
model.study('std1').feature('eigv').set('conubdy', '1');
model.study('std1').feature('eigv').set('linpsolnum', 'auto');
model.study('std1').feature('eigv').set('solnum', 'auto');
model.study('std1').feature('eigv').set('notsolnum', 'auto');
model.study('std1').feature('eigv').set('outputmap', {});
model.study('std1').feature('eigv').set('ngenAUX', '1');
model.study('std1').feature('eigv').set('goalngenAUX', '1');
model.study('std1').feature('eigv').set('ngenAUX', '1');
model.study('std1').feature('eigv').set('goalngenAUX', '1');
model.study('std1').feature('eigv').setSolveFor('/physics/schr', true);

model.geom('geom1').lengthUnit('nm');

% To import content from file, use:
% model.param.loadFile('FILENAME');
model.param.set('lw', '5[nm]', 'Width of well');
model.param.set('lb', '5[nm]', 'Width of barrier');
model.param.set('mew', '0.063', 'Electron effective mass of well material');
model.param.set('meb', '0.71', 'Electron effective mass of barrier material');
model.param.set('mhw', '0.51', 'Hole effective mass of well material');
model.param.set('mhb', '0.76', 'Hole effective mass of barrier material');
model.param.set('Egw', '1.424[V]', 'Band gap of well');
model.param.set('Egb', '2.168[V]', 'Band gap of barrier');
model.param.set('CBO', '0.283[V]', 'Conduction band offset');
model.param.set('VBO', 'Egb-Egw-CBO', 'Valence band offset');
model.param.set('hmax', '0.1[nm]', 'Max mesh element size');

model.geom('geom1').create('i1', 'Interval');
model.geom('geom1').feature('i1').set('specify', 'len');
model.geom('geom1').feature('i1').set('left', '-lw/2-lb/2');
model.geom('geom1').feature('i1').setIndex('len', 'lb/2', 0);
model.geom('geom1').feature('i1').setIndex('len', 'lw', 1);
model.geom('geom1').feature('i1').setIndex('len', 'lb/2', 2);
model.geom('geom1').runPre('fin');
model.geom('geom1').run;

model.physics('schr').label(['Schr' native2unicode(hex2dec({'00' 'f6'}), 'unicode') 'dinger Equation e-']);
model.physics('schr').tag('schre');
model.physics('schre').field('dimensionless').component(1, 'psie');
model.physics('schre').feature('meff1').set('meffe_psie', {'meb*me_const' '0' '0' '0' 'meb*me_const' '0' '0' '0' 'meb*me_const'});
model.physics('schre').feature('ve1').set('Ve_src', 'userdef');
model.physics('schre').feature('ve1').set('Ve', 'Egb*e_const');
model.physics('schre').create('meff2', 'EffectiveMass', 1);
model.physics('schre').feature('meff2').selection.set([2]);
model.physics('schre').feature('meff2').set('meffe_psie', {'mew*me_const' '0' '0' '0' 'mew*me_const' '0' '0' '0' 'mew*me_const'});
model.physics('schre').create('ve2', 'ElectronPotentialEnergy', 1);
model.physics('schre').feature('ve2').selection.set([2]);
model.physics('schre').feature('ve2').set('Ve_src', 'userdef');
model.physics('schre').feature('ve2').set('Ve', '-CBO*e_const');
model.physics('schre').create('pc1', 'PeriodicCondition', 0);
model.physics('schre').feature('pc1').selection.all;
model.physics.create('schr', 'SchrodingerEquation', 'geom1', {'psi'});

model.study('std1').feature('eigv').setSolveFor('/physics/schr', true);

model.physics('schr').label(['Schr' native2unicode(hex2dec({'00' 'f6'}), 'unicode') 'dinger Equation hole']);
model.physics('schr').tag('schrh');
model.physics('schrh').prop('ModelProperties').set('ParticleType', 'Holes');
model.physics('schrh').field('dimensionless').component(1, 'psih');
model.physics('schrh').feature('meff1').set('meffh_psih', {'mhb*me_const' '0' '0' '0' 'mhb*me_const' '0' '0' '0' 'mhb*me_const'});
model.physics('schrh').feature('ve1').set('Vh_src', 'userdef');
model.physics('schrh').feature('ve1').set('Vh', 0);
model.physics('schrh').create('meff2', 'EffectiveMass', 1);
model.physics('schrh').feature('meff2').selection.set([2]);
model.physics('schrh').feature('meff2').set('meffh_psih', {'mhw*me_const' '0' '0' '0' 'mhw*me_const' '0' '0' '0' 'mhw*me_const'});
model.physics('schrh').create('ve2', 'ElectronPotentialEnergy', 1);
model.physics('schrh').feature('ve2').selection.set([2]);
model.physics('schrh').feature('ve2').set('Vh_src', 'userdef');
model.physics('schrh').feature('ve2').set('Vh', 'VBO*e_const');
model.physics('schrh').create('pc1', 'PeriodicCondition', 0);
model.physics('schrh').feature('pc1').selection.all;

model.mesh('mesh1').create('edg1', 'Edge');
model.mesh('mesh1').feature('size').set('custom', true);
model.mesh('mesh1').feature('size').set('hmax', 'hmax');
model.mesh('mesh1').run;

model.study('std1').feature('eigv').set('neigs', 1);
model.study('std1').feature('eigv').set('shift', '(Egb-CBO)[1/V]');
model.study('std1').feature('eigv').setEntry('activate', 'schrh', false);
model.study('std1').setGenPlots(false);

model.sol.create('sol1');
model.sol('sol1').study('std1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'eigv');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').set('control', 'eigv');
model.sol('sol1').create('e1', 'Eigenvalue');
model.sol('sol1').feature('e1').set('neigs', 6);
model.sol('sol1').feature('e1').set('shift', '0');
model.sol('sol1').feature('e1').set('rtol', 1.0E-10);
model.sol('sol1').feature('e1').set('transform', 'none');
model.sol('sol1').feature('e1').set('eigref', '0.1');
model.sol('sol1').feature('e1').set('eigvfunscale', 'average');
model.sol('sol1').feature('e1').set('control', 'eigv');
model.sol('sol1').attach('std1');
model.sol('sol1').runAll;

model.study.create('std2');
model.study('std2').create('eigv', 'Eigenvalue');
model.study('std2').feature('eigv').set('neigs', '3');
model.study('std2').feature('eigv').set('eigunit', '');
model.study('std2').feature('eigv').set('shift', '0.1');
model.study('std2').feature('eigv').set('conrad', '1');
model.study('std2').feature('eigv').set('conradynhm', '1');
model.study('std2').feature('eigv').set('conlbdy', '0');
model.study('std2').feature('eigv').set('conubdy', '1');
model.study('std2').feature('eigv').set('linpsolnum', 'auto');
model.study('std2').feature('eigv').set('solnum', 'auto');
model.study('std2').feature('eigv').set('notsolnum', 'auto');
model.study('std2').feature('eigv').set('outputmap', {});
model.study('std2').feature('eigv').set('ngenAUX', '1');
model.study('std2').feature('eigv').set('goalngenAUX', '1');
model.study('std2').feature('eigv').set('ngenAUX', '1');
model.study('std2').feature('eigv').set('goalngenAUX', '1');
model.study('std2').feature('eigv').setSolveFor('/physics/schre', false);
model.study('std2').feature('eigv').setSolveFor('/physics/schrh', true);
model.study('std2').feature('eigv').set('neigs', 1);
model.study('std2').feature('eigv').set('shift', '-VBO[1/V]');
model.study('std2').setGenPlots(false);

model.sol.create('sol2');
model.sol('sol2').study('std2');
model.sol('sol2').create('st1', 'StudyStep');
model.sol('sol2').feature('st1').set('study', 'std2');
model.sol('sol2').feature('st1').set('studystep', 'eigv');
model.sol('sol2').create('v1', 'Variables');
model.sol('sol2').feature('v1').set('control', 'eigv');
model.sol('sol2').create('e1', 'Eigenvalue');
model.sol('sol2').feature('e1').set('neigs', 6);
model.sol('sol2').feature('e1').set('shift', '0');
model.sol('sol2').feature('e1').set('rtol', 1.0E-10);
model.sol('sol2').feature('e1').set('transform', 'none');
model.sol('sol2').feature('e1').set('eigref', '0.1');
model.sol('sol2').feature('e1').set('eigvfunscale', 'average');
model.sol('sol2').feature('e1').set('control', 'eigv');
model.sol('sol2').attach('std2');
model.sol('sol2').runAll;

model.result.dataset.create('join1', 'Join');
model.result.dataset('join1').set('data', 'dset1');
model.result.dataset('join1').set('solutions', 'one');
model.result.dataset('join1').set('data2', 'dset2');
model.result.dataset('join1').set('solutions2', 'one');
model.result.dataset('join1').set('method', 'explicit');
model.result.dataset.create('arr1', 'Array1D');
model.result.dataset('arr1').set('data', 'join1');
model.result.dataset('arr1').set('fullsize', [3]);
model.result.dataset('arr1').set('hasvars', true);
model.result.numerical.create('gev1', 'EvalGlobal');
model.result.numerical('gev1').set('data', 'join1');
model.result.numerical('gev1').setIndex('expr', 'data1(schre.Ei)/e_const-(Egb-CBO)', 0);
model.result.numerical('gev1').setIndex('descr', 'Conduction band edge shift', 0);
model.result.table.create('tbl1', 'Table');
model.result.table('tbl1').comments('Global Evaluation 1');
model.result.numerical('gev1').set('table', 'tbl1');
model.result.numerical('gev1').setResult;
model.result.numerical.create('gev2', 'EvalGlobal');
model.result.numerical('gev2').set('data', 'join1');
model.result.numerical('gev2').setIndex('expr', 'data2(schrh.Ei)/e_const+VBO', 0);
model.result.numerical('gev2').setIndex('descr', 'Valence band edge shift', 0);
model.result.table.create('tbl2', 'Table');
model.result.table('tbl2').comments('Global Evaluation 2');
model.result.numerical('gev2').set('table', 'tbl2');
model.result.numerical('gev2').setResult;
model.result.numerical.create('gev3', 'EvalGlobal');
model.result.numerical('gev3').set('data', 'join1');
model.result.numerical('gev3').setIndex('expr', '(data1(schre.Ei)+data2(schrh.Ei))/e_const', 0);
model.result.numerical('gev3').setIndex('descr', 'Effective band gap', 0);
model.result.table.create('tbl3', 'Table');
model.result.table('tbl3').comments('Global Evaluation 3');
model.result.numerical('gev3').set('table', 'tbl3');
model.result.numerical('gev3').setResult;
model.result.create('pg1', 'PlotGroup1D');
model.result('pg1').run;
model.result('pg1').set('data', 'arr1');
model.result('pg1').set('titletype', 'none');
model.result('pg1').set('xlabelactive', true);
model.result('pg1').set('xlabel', 'x (nm)');
model.result('pg1').set('ylabelactive', true);
model.result('pg1').set('ylabel', 'Energy (eV)');
model.result('pg1').set('legendpos', 'center');
model.result('pg1').create('lngr1', 'LineGraph');
model.result('pg1').feature('lngr1').set('markerpos', 'datapoints');
model.result('pg1').feature('lngr1').set('linewidth', 'preference');
model.result('pg1').feature('lngr1').label('Ve');
model.result('pg1').feature('lngr1').set('expr', 'data1(schre.V)/e_const');
model.result('pg1').feature('lngr1').set('descractive', true);
model.result('pg1').feature('lngr1').set('descr', 'Conduction band edge');
model.result('pg1').feature('lngr1').set('xdata', 'expr');
model.result('pg1').feature('lngr1').set('xdataexpr', 'arr1x');
model.result('pg1').feature('lngr1').set('linecolor', 'black');
model.result('pg1').feature('lngr1').set('linewidth', 2);
model.result('pg1').feature('lngr1').set('smooth', 'everywhere');
model.result('pg1').feature('lngr1').set('resolution', 'extrafine');
model.result('pg1').feature('lngr1').set('legend', true);
model.result('pg1').feature('lngr1').set('legendmethod', 'manual');
model.result('pg1').feature('lngr1').setIndex('legends', 'Conduction band edge', 0);
model.result('pg1').feature.duplicate('lngr2', 'lngr1');
model.result('pg1').run;
model.result('pg1').feature('lngr2').label('Vh');
model.result('pg1').feature('lngr2').set('expr', 'data2(-schrh.V)/e_const');
model.result('pg1').feature('lngr2').set('descr', 'Valence band edge');
model.result('pg1').feature('lngr2').set('linecolor', 'gray');
model.result('pg1').feature('lngr2').setIndex('legends', 'Valence band edge', 0);
model.result('pg1').feature.duplicate('lngr3', 'lngr2');
model.result('pg1').run;
model.result('pg1').feature('lngr3').label('psie');
model.result('pg1').feature('lngr3').set('expr', 'data1(schre.Psi*Egw/4/schre.plot_fac+schre.Ei/e_const)');
model.result('pg1').feature('lngr3').set('descr', 'e- wave function');
model.result('pg1').feature('lngr3').set('linecolor', 'cycle');
model.result('pg1').feature('lngr3').setIndex('legends', 'Electron wave function (real part)', 0);
model.result('pg1').feature.duplicate('lngr4', 'lngr3');
model.result('pg1').run;
model.result('pg1').feature('lngr4').label('psih');
model.result('pg1').feature('lngr4').set('expr', 'data2(-schrh.Psi*Egw/4/schrh.plot_fac-schrh.Ei/e_const)');
model.result('pg1').feature('lngr4').set('descr', 'hole wave function');
model.result('pg1').feature('lngr4').setIndex('legends', 'Hole wave function (real part)', 0);
model.result('pg1').run;
model.result('pg1').feature.duplicate('lngr5', 'lngr3');
model.result('pg1').run;
model.result('pg1').feature('lngr5').label('Im(psie)');
model.result('pg1').feature('lngr5').set('expr', 'data1(imag(schre.Psi)*Egw/4/schre.plot_fac+schre.Ei/e_const)');
model.result('pg1').feature('lngr5').set('linestyle', 'dashed');
model.result('pg1').feature('lngr5').set('linecolor', 'blue');
model.result('pg1').feature('lngr5').setIndex('legends', 'Electron wave function (imag part)', 0);
model.result('pg1').run;
model.result('pg1').feature.duplicate('lngr6', 'lngr4');
model.result('pg1').run;
model.result('pg1').feature('lngr6').label('Im(psih)');
model.result('pg1').feature('lngr6').set('expr', 'data2(-imag(schrh.Psi)*Egw/4/schrh.plot_fac-schrh.Ei/e_const)');
model.result('pg1').feature('lngr6').set('linestyle', 'dashed');
model.result('pg1').feature('lngr6').set('linecolor', 'green');
model.result('pg1').feature('lngr6').setIndex('legends', 'Hole wave function (imag part)', 0);
model.result('pg1').run;

model.title('Superlattice Band Gap Tool');

model.description(['The Superlattice Band Gap Tool model helps the design of periodic structures made of two alternating semiconductor materials (superlattices). The model uses the effective mass Schr' native2unicode(hex2dec({'00' 'f6'}), 'unicode') 'dinger equation to estimate the electron and hole ground state energy levels in a given superlattice structure. Device engineers can use the model to quickly compute the effective band gap for a given periodic structure and iterate the design parameters until they reach a desired band gap value.' newline  newline 'You can find out more about the model in this blog post: "Computing the Band Gap in Superlattices with the Schr' native2unicode(hex2dec({'00' 'f6'}), 'unicode') 'dinger Equation"']);

model.mesh.clearMeshes;

model.sol('sol1').clearSolutionData;
model.sol('sol2').clearSolutionData;

model.label('superlattice_band_gap_tool.mph');

model.modelNode.label('Components');

out = model;
