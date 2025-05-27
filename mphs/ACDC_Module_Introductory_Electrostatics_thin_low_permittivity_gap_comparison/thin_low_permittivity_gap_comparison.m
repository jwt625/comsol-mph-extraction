function out = model
%
% thin_low_permittivity_gap_comparison.m
%
% Model exported on May 26 2025, 21:25 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/ACDC_Module/Introductory_Electrostatics');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 2);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.physics.create('es', 'Electrostatics', 'geom1');
model.physics('es').model('comp1');

model.study.create('std1');
model.study('std1').create('stat', 'Stationary');
model.study('std1').feature('stat').setSolveFor('/physics/es', true);

model.geom('geom1').lengthUnit('cm');

model.param.set('er_a', '1');
model.param.descr('er_a', 'Relative permittivity, free space and gap');
model.param.set('er_b', '20');
model.param.descr('er_b', 'Relative permittivity, dielectric');
model.param.set('V0', '1[V]');
model.param.descr('V0', 'Applied voltage');

model.geom('geom1').create('r1', 'Rectangle');
model.geom('geom1').feature('r1').set('size', [8 10]);
model.geom('geom1').feature('r1').set('pos', [0.1 -5]);
model.geom('geom1').run('r1');
model.geom('geom1').create('r2', 'Rectangle');
model.geom('geom1').feature('r2').set('size', [3.5 1]);
model.geom('geom1').feature('r2').set('pos', [0.1 2]);
model.geom('geom1').run('r2');
model.geom('geom1').create('fil1', 'Fillet');
model.geom('geom1').feature('fil1').selection('pointinsketch').set('r2', [2 3]);
model.geom('geom1').feature('fil1').set('radius', 0.5);
model.geom('geom1').run('fil1');
model.geom('geom1').create('copy1', 'Copy');
model.geom('geom1').feature('copy1').selection('input').set({'fil1'});
model.geom('geom1').feature('copy1').set('disply', -5);
model.geom('geom1').run('copy1');
model.geom('geom1').create('r3', 'Rectangle');
model.geom('geom1').feature('r3').set('size', [3 4]);
model.geom('geom1').feature('r3').set('pos', [0.1 -2]);
model.geom('geom1').run('r3');
model.geom('geom1').create('mir1', 'Mirror');
model.geom('geom1').feature('mir1').selection('input').set({'copy1' 'fil1' 'r1' 'r3'});
model.geom('geom1').feature('mir1').set('keep', true);
model.geom('geom1').run('mir1');
model.geom('geom1').create('c1', 'Circle');
model.geom('geom1').feature('c1').set('r', 0.95);
model.geom('geom1').feature('c1').set('angle', 180);
model.geom('geom1').feature('c1').set('pos', [0.1 0]);
model.geom('geom1').feature('c1').set('rot', -90);
model.geom('geom1').run('c1');
model.geom('geom1').create('c2', 'Circle');
model.geom('geom1').feature('c2').set('angle', 180);
model.geom('geom1').feature('c2').set('pos', [-0.1 0]);
model.geom('geom1').feature('c2').set('rot', 90);
model.geom('geom1').feature('c2').setIndex('layer', '1[mm]', 0);
model.geom('geom1').runPre('fin');

model.selection.create('sel1', 'Explicit');
model.selection('sel1').model('comp1');

model.geom('geom1').run;

model.selection('sel1').set([3 7 10 11]);
model.selection('sel1').label('High dielectric');
model.selection.create('sel2', 'Explicit');
model.selection('sel2').model('comp1');
model.selection('sel2').geom(1);
model.selection('sel2').set([44 45]);
model.selection('sel2').label('Thin low permittivity gap');
model.selection.create('sel3', 'Explicit');
model.selection('sel3').model('comp1');
model.selection('sel3').set([1 3 5 6 7 8 10 11]);
model.selection('sel3').label('Model domain');

model.physics('es').selection.named('sel3');
model.physics('es').create('gnd1', 'Ground', 1);
model.physics('es').feature('gnd1').selection.set([23 25 46 47]);
model.physics('es').create('gnd2', 'Ground', 1);
model.physics('es').feature('gnd2').selection.set([4 6 36 37]);
model.physics('es').create('term1', 'Terminal', 1);
model.physics('es').feature('term1').selection.set([30 32 48 49]);
model.physics('es').feature('term1').set('TerminalType', 'Voltage');
model.physics('es').feature('term1').set('V0', 'V0');
model.physics('es').create('term2', 'Terminal', 1);
model.physics('es').feature('term2').selection.set([7 8 38 39]);
model.physics('es').feature('term2').set('TerminalType', 'Voltage');
model.physics('es').feature('term2').set('V0', 'V0');
model.physics('es').create('tcl1', 'ThinLowPermittivityGap', 1);
model.physics('es').feature('tcl1').selection.named('sel2');
model.physics('es').feature('tcl1').set('d', '1[mm]');

model.material.create('mat1', 'Common', 'comp1');
model.material('mat1').selection.named('sel3');
model.material('mat1').propertyGroup('def').set('relpermittivity', {'er_a'});
model.material.create('mat2', 'Common', 'comp1');
model.material('mat2').selection.named('sel1');
model.material('mat2').propertyGroup('def').set('relpermittivity', {'er_b'});
model.material.create('mat3', 'Common', 'comp1');
model.material('mat3').selection.geom('geom1', 1);
model.material('mat3').selection.named('sel2');
model.material('mat3').propertyGroup('def').set('relpermittivity', {'er_a'});

model.mesh('mesh1').run;

model.study('std1').setGenPlots(false);

model.sol.create('sol1');
model.sol('sol1').study('std1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'stat');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').set('control', 'stat');
model.sol('sol1').create('s1', 'Stationary');
model.sol('sol1').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('s1').feature('fc1').set('linsolver', 'dDef');
model.sol('sol1').feature('s1').feature.remove('fcDef');
model.sol('sol1').attach('std1');
model.sol('sol1').runAll;

model.result.dataset('dset1').selection.geom('geom1', 2);
model.result.dataset('dset1').selection.geom('geom1', 2);
model.result.dataset('dset1').selection.set([1 3 7 8 10 11]);
model.result.create('pg1', 'PlotGroup2D');
model.result('pg1').run;
model.result('pg1').label('Electric Field (es)');
model.result('pg1').create('surf1', 'Surface');
model.result('pg1').feature('surf1').set('expr', 'es.normE');
model.result('pg1').feature('surf1').set('descr', 'Electric field norm');
model.result('pg1').feature('surf1').set('colortable', 'GrayPrint');
model.result('pg1').feature('surf1').set('colorlegend', false);
model.result('pg1').feature('surf1').set('colortabletrans', 'reverse');
model.result('pg1').run;
model.result('pg1').create('con1', 'Contour');
model.result('pg1').feature('con1').set('number', 21);
model.result('pg1').feature('con1').create('col1', 'Color');
model.result('pg1').run;
model.result('pg1').feature('con1').feature('col1').set('expr', 'es.normE');
model.result('pg1').feature('con1').feature('col1').set('descr', 'Electric field norm');
model.result('pg1').feature('con1').feature('col1').set('colorlegend', false);
model.result('pg1').run;
model.result('pg1').create('str1', 'Streamline');
model.result('pg1').feature('str1').selection.set([7 30 38 39 48 49]);
model.result('pg1').feature('str1').set('selnumber', 30);
model.result('pg1').feature('str1').create('col1', 'Color');
model.result('pg1').run;
model.result('pg1').feature('str1').feature('col1').set('expr', 'es.normE');
model.result('pg1').feature('str1').feature('col1').set('descr', 'Electric field norm');
model.result.numerical.create('gev1', 'EvalGlobal');
model.result.numerical('gev1').setIndex('expr', 'es.Q0_1/V0', 0);
model.result.table.create('tbl1', 'Table');
model.result.table('tbl1').comments('Global Evaluation 1');
model.result.numerical('gev1').set('table', 'tbl1');
model.result.numerical('gev1').setResult;
model.result.numerical.create('gev2', 'EvalGlobal');
model.result.numerical('gev2').setIndex('expr', 'es.Q0_2/V0', 0);
model.result.numerical('gev2').set('table', 'tbl1');
model.result.numerical('gev2').appendResult;
model.result('pg1').run;

model.title('Thin Low Permittivity Gap Comparison');

model.description('The thin low-permittivity gap boundary condition, which is available for electrostatic field modeling, approximates a thin layer of material with low relative permittivity compared to its surroundings. This example compares the thin low-permittivity gap boundary condition to a full-fidelity model and discusses the range of applicability of this boundary condition.');

model.mesh.clearMeshes;

model.sol('sol1').clearSolutionData;

model.label('thin_low_permittivity_gap_comparison.mph');

model.modelNode.label('Components');

out = model;
