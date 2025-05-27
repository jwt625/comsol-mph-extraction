function out = model
%
% viscoelastic_damper_transient.m
%
% Model exported on May 26 2025, 21:33 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/Structural_Mechanics_Module/Dynamics_and_Vibration');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 3);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.physics.create('solid', 'SolidMechanics', 'geom1');
model.physics('solid').model('comp1');

model.study.create('std1');
model.study('std1').create('time', 'Transient');
model.study('std1').feature('time').setSolveFor('/physics/solid', true);

model.view('view1').set('showgrid', false);

model.geom('geom1').insertFile('viscoelastic_damper_geom_sequence.mph', 'geom1');
model.geom('geom1').run;

model.physics('solid').create('lemm2', 'LinearElasticModel', 3);
model.physics('solid').feature('lemm2').set('IsotropicOption', 'KG');
model.physics('solid').feature('lemm2').set('MixedFormulation', 'pFormulation');
model.physics('solid').feature('lemm2').set('reducedIntegration', true);
model.physics('solid').feature('lemm2').selection.set([2 5]);
model.physics('solid').feature('lemm2').create('vis1', 'Viscoelasticity', 3);
model.physics('solid').feature('lemm2').feature('vis1').label('Viscoelasticity (No Pruning)');
model.physics('solid').feature('lemm2').feature('vis1').set('Gvm', []);
model.physics('solid').feature('lemm2').feature('vis1').set('tauvm', []);
model.physics('solid').feature('lemm2').feature('vis1').set('Gvm', {'13.3[MPa]' '286[MPa]' '291[MPa]' '212[MPa]' '112[MPa]' '61.6[MPa]' '29.8[MPa]' '16.1[MPa]' '7.83[MPa]' '4.15[MPa]'  ...
'2.03[MPa]' '1.11[MPa]' '0.491[MPa]' '0.326[MPa]' '0.0825[MPa]' '0.126[MPa]' '0.0373[MPa]' '0.0118[MPa]'});
model.physics('solid').feature('lemm2').feature('vis1').set('tauvm', {'1e-7' '1e-6' '3.16e-6' '1e-5' '3.16e-5' '1e-4' '3.16e-4' '1e-3' '3.16e-3' '1e-2'  ...
'3.16e-2' '1e-1' '3.16e-1' '1' '3.16' '10' '100' '1000'});
model.physics('solid').feature('lemm2').feature.duplicate('vis2', 'vis1');
model.physics('solid').feature('lemm2').feature('vis2').label('Viscoelasticity (With Pruning)');
model.physics('solid').feature('lemm2').feature('vis2').set('pruneBranches', true);
model.physics('solid').feature('lemm2').feature('vis2').set('f_lower', 0.3);
model.physics('solid').feature('lemm2').feature('vis2').set('f_upper', 30);

model.material.create('mat1', 'Common', 'comp1');
model.material('mat1').propertyGroup.create('Enu', 'Young''s modulus and Poisson''s ratio');
model.material('mat1').label('Steel AISI 4340');
model.material('mat1').set('family', 'steel');
model.material('mat1').propertyGroup('def').set('relpermeability', {'1' '0' '0' '0' '1' '0' '0' '0' '1'});
model.material('mat1').propertyGroup('def').set('electricconductivity', {'4.032e6[S/m]' '0' '0' '0' '4.032e6[S/m]' '0' '0' '0' '4.032e6[S/m]'});
model.material('mat1').propertyGroup('def').set('thermalexpansioncoefficient', {'12.3e-6[1/K]' '0' '0' '0' '12.3e-6[1/K]' '0' '0' '0' '12.3e-6[1/K]'});
model.material('mat1').propertyGroup('def').set('heatcapacity', '475[J/(kg*K)]');
model.material('mat1').propertyGroup('def').set('relpermittivity', {'1' '0' '0' '0' '1' '0' '0' '0' '1'});
model.material('mat1').propertyGroup('def').set('density', '7850[kg/m^3]');
model.material('mat1').propertyGroup('def').set('thermalconductivity', {'44.5[W/(m*K)]' '0' '0' '0' '44.5[W/(m*K)]' '0' '0' '0' '44.5[W/(m*K)]'});
model.material('mat1').propertyGroup('Enu').set('E', '205[GPa]');
model.material('mat1').propertyGroup('Enu').set('nu', '0.28');
model.material.create('mat2', 'Common', 'comp1');
model.material('mat2').label('Viscoelastic');
model.material('mat2').selection.set([2 5]);
model.material('mat2').propertyGroup.create('KG', 'Bulk_modulus_and_shear_modulus');
model.material('mat2').propertyGroup('KG').set('K', {'4e8'});
model.material('mat2').propertyGroup('KG').set('G', {'5.86e4'});
model.material('mat2').propertyGroup('def').set('density', {'1060'});

model.view('view1').set('showmaterial', true);

model.func.create('rm1', 'Ramp');
model.func('rm1').model('comp1');
model.func('rm1').set('location', '0.02[s]');
model.func('rm1').set('slope', 10);
model.func('rm1').set('smoothzonelocactive', true);
model.func('rm1').set('smoothzoneloc', 0.01);
model.func('rm1').set('cutoffactive', true);
model.func('rm1').set('smoothzonecutoffactive', true);
model.func('rm1').set('smoothzonecutoff', 0.01);

model.physics('solid').create('fix1', 'Fixed', 2);
model.physics('solid').feature('fix1').selection.named('geom1_sel3');
model.physics('solid').create('disp1', 'Displacement2', 2);
model.physics('solid').feature('disp1').selection.named('geom1_sel2');
model.physics('solid').feature('disp1').setIndex('Direction', 'prescribed', 0);
model.physics('solid').feature('disp1').setIndex('Direction', 'prescribed', 1);
model.physics('solid').create('bndl1', 'BoundaryLoad', 2);
model.physics('solid').feature('bndl1').selection.named('geom1_sel2');
model.physics('solid').feature('bndl1').set('FperArea', {'0' '0' '8.5[MPa]*sin(pi/2+2*pi*t*3[Hz])*rm1(t)'});
model.physics('solid').create('disp2', 'Displacement2', 2);
model.physics('solid').feature('disp2').selection.named('geom1_sel1');
model.physics('solid').feature('disp2').setIndex('Direction', 'prescribed', 1);
model.physics('solid').create('bndl2', 'BoundaryLoad', 2);
model.physics('solid').feature('bndl2').selection.named('geom1_sel1');
model.physics('solid').feature('bndl2').set('FperArea', {'0.5[MPa]*sin(2*pi*t*3[Hz])*rm1(t)' '0' '8.5[MPa]*sin(2*pi*t*3[Hz])*rm1(t)'});

model.cpl.create('intop1', 'Integration', 'geom1');
model.cpl('intop1').set('axisym', true);
model.cpl('intop1').set('frame', 'material');
model.cpl('intop1').selection.geom('geom1', 2);
model.cpl('intop1').selection.named('geom1_sel1');

model.variable.create('var1');
model.variable('var1').model('comp1');
model.variable('var1').set('Fz1', 'intop1(solid.FperAreaz)');
model.variable('var1').descr('Fz1', 'Total force, Z component');

model.mesh('mesh1').create('fq1', 'FreeQuad');
model.mesh('mesh1').feature('fq1').selection.set([30]);
model.mesh('mesh1').feature('fq1').create('size1', 'Size');
model.mesh('mesh1').feature('fq1').feature('size1').set('hauto', 3);
model.mesh('mesh1').feature('fq1').create('dis1', 'Distribution');
model.mesh('mesh1').feature('fq1').feature('dis1').selection.set([65]);
model.mesh('mesh1').create('swe1', 'Sweep');
model.mesh('mesh1').feature('swe1').selection.geom('geom1', 3);
model.mesh('mesh1').feature('swe1').selection.set([7]);
model.mesh('mesh1').feature('swe1').create('dis1', 'Distribution');
model.mesh('mesh1').feature('swe1').feature('dis1').set('numelem', 2);
model.mesh('mesh1').create('fq2', 'FreeQuad');
model.mesh('mesh1').feature('fq2').selection.set([2 61]);
model.mesh('mesh1').feature('fq2').create('size1', 'Size');
model.mesh('mesh1').feature('fq2').feature('size1').set('hauto', 4);
model.mesh('mesh1').create('swe2', 'Sweep');
model.mesh('mesh1').feature('swe2').selection.geom('geom1', 3);
model.mesh('mesh1').feature('swe2').selection.set([1 2 4]);
model.mesh('mesh1').feature('swe2').create('dis1', 'Distribution');
model.mesh('mesh1').feature('swe2').feature('dis1').set('numelem', 2);
model.mesh('mesh1').create('cpd1', 'CopyDomain');
model.mesh('mesh1').feature('cpd1').selection('source').geom(3);
model.mesh('mesh1').feature('cpd1').selection('destination').geom(3);
model.mesh('mesh1').feature('cpd1').selection('source').set([1 2 7]);
model.mesh('mesh1').feature('cpd1').selection('destination').set([5 6 8]);
model.mesh('mesh1').create('fq3', 'FreeQuad');
model.mesh('mesh1').feature('fq3').selection.set([10]);
model.mesh('mesh1').create('swe3', 'Sweep');
model.mesh('mesh1').run;

model.study('std1').label('Study 1: No Pruning');
model.study('std1').feature('time').set('tlist', 'range(0, 0.01, 3)');
model.study('std1').feature('time').set('useadvanceddisable', true);
model.study('std1').feature('time').set('disabledphysics', {'solid/lemm2/vis2'});

model.sol.create('sol1');
model.sol('sol1').study('std1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'time');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').feature('comp1_solid_lemm2_pw').set('scalemethod', 'manual');
model.sol('sol1').feature('v1').feature('comp1_u').set('scalemethod', 'manual');
model.sol('sol1').feature('v1').feature('comp1_solid_lemm2_pw').set('scaleval', '100000000');
model.sol('sol1').feature('v1').feature('comp1_u').set('scaleval', '1e-2*0.370446514358011');
model.sol('sol1').feature('v1').set('control', 'time');
model.sol('sol1').create('t1', 'Time');
model.sol('sol1').feature('t1').set('tlist', 'range(0, 0.01, 3)');
model.sol('sol1').feature('t1').set('plot', 'off');
model.sol('sol1').feature('t1').set('plotgroup', 'Default');
model.sol('sol1').feature('t1').set('plotfreq', 'tout');
model.sol('sol1').feature('t1').set('probesel', 'all');
model.sol('sol1').feature('t1').set('probes', {});
model.sol('sol1').feature('t1').set('probefreq', 'tsteps');
model.sol('sol1').feature('t1').set('rtol', 0.001);
model.sol('sol1').feature('t1').set('atolglobalvaluemethod', 'factor');
model.sol('sol1').feature('t1').set('reacf', true);
model.sol('sol1').feature('t1').set('storeudot', true);
model.sol('sol1').feature('t1').set('endtimeinterpolation', true);
model.sol('sol1').feature('t1').set('timemethod', 'genalpha');
model.sol('sol1').feature('t1').set('control', 'time');
model.sol('sol1').feature('t1').feature('aDef').set('cachepattern', true);
model.sol('sol1').feature('t1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('t1').create('d1', 'Direct');
model.sol('sol1').feature('t1').feature('d1').set('linsolver', 'pardiso');
model.sol('sol1').feature('t1').feature('d1').set('pivotperturb', 1.0E-9);
model.sol('sol1').feature('t1').feature('d1').label('Suggested Direct Solver (solid)');
model.sol('sol1').feature('t1').create('i1', 'Iterative');
model.sol('sol1').feature('t1').feature('i1').set('linsolver', 'gmres');
model.sol('sol1').feature('t1').feature('i1').set('rhob', 400);
model.sol('sol1').feature('t1').feature('i1').set('nlinnormuse', true);
model.sol('sol1').feature('t1').feature('i1').label('Suggested Iterative Solver (solid)');
model.sol('sol1').feature('t1').feature('i1').create('mg1', 'Multigrid');
model.sol('sol1').feature('t1').feature('i1').feature('mg1').set('prefun', 'gmg');
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('pr').create('so1', 'SOR');
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('pr').feature('so1').set('relax', 0.8);
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('po').create('so1', 'SOR');
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('po').feature('so1').set('relax', 0.8);
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('cs').create('d1', 'Direct');
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('cs').feature('d1').set('linsolver', 'pardiso');
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('cs').feature('d1').set('pivotperturb', 1.0E-9);
model.sol('sol1').feature('t1').feature('fc1').set('linsolver', 'd1');
model.sol('sol1').feature('t1').feature.remove('fcDef');
model.sol('sol1').attach('std1');
model.sol('sol1').feature('v1').feature('comp1_solid_lemm2_pw').set('scaleval', '1e6');
model.sol('sol1').feature('t1').set('estrat', 'exclude');

model.result.create('pg1', 'PlotGroup3D');
model.result('pg1').run;
model.result('pg1').label('Displacement (No Pruning)');
model.result('pg1').create('surf1', 'Surface');
model.result('pg1').feature('surf1').set('expr', 'w');
model.result('pg1').feature('surf1').set('descr', 'Displacement field, Z-component');
model.result('pg1').feature('surf1').set('colortable', 'SpectrumLight');
model.result('pg1').feature('surf1').create('def1', 'Deform');
model.result('pg1').run;

model.study('std1').feature('time').set('plot', true);

model.sol('sol1').runAll;

model.result('pg1').run;
model.result.table.create('tbl1', 'Table');
model.result.table('tbl1').importData('viscoelastic_damper_frequency_solution.txt');
model.result.create('pg2', 'PlotGroup1D');
model.result('pg2').run;
model.result('pg2').label('Hysteresis Loops');
model.result('pg2').set('titletype', 'none');
model.result('pg2').set('xlabelactive', true);
model.result('pg2').set('xlabel', 'Fz1 [kN]');
model.result('pg2').set('ylabelactive', true);
model.result('pg2').set('ylabel', 'w [mm]');
model.result('pg2').create('tblp1', 'Table');
model.result('pg2').feature('tblp1').set('markerpos', 'datapoints');
model.result('pg2').feature('tblp1').set('linewidth', 'preference');
model.result('pg2').feature('tblp1').set('linestyle', 'dashed');
model.result('pg2').feature('tblp1').set('linewidth', 2);
model.result('pg2').feature('tblp1').set('legend', true);
model.result('pg2').feature('tblp1').set('legendmethod', 'manual');
model.result('pg2').feature('tblp1').setIndex('legends', 'Frequency-domain solution', 0);
model.result('pg2').run;
model.result('pg2').create('ptgr1', 'PointGraph');
model.result('pg2').feature('ptgr1').set('markerpos', 'datapoints');
model.result('pg2').feature('ptgr1').set('linewidth', 'preference');
model.result('pg2').feature('ptgr1').selection.set([25]);
model.result('pg2').feature('ptgr1').set('xdata', 'expr');
model.result('pg2').feature('ptgr1').set('xdataexpr', 'w');
model.result('pg2').feature('ptgr1').set('xdatadescr', 'Displacement field, Z-component');
model.result('pg2').feature('ptgr1').set('expr', 'Fz1');
model.result('pg2').feature('ptgr1').set('unit', 'kN');
model.result('pg2').feature('ptgr1').set('legend', true);
model.result('pg2').feature('ptgr1').set('legendmethod', 'manual');
model.result('pg2').feature('ptgr1').setIndex('legends', 'Time-domain solution (no pruning)', 0);
model.result('pg2').run;
model.result('pg2').set('legendpos', 'upperleft');
model.result('pg2').run;

model.study.create('std2');
model.study('std2').create('time', 'Transient');
model.study('std2').feature('time').setSolveFor('/physics/solid', true);
model.study('std2').label('Study 2: With Pruning');
model.study('std2').setGenPlots(false);
model.study('std2').feature('time').set('tlist', 'range(0, 0.01, 3)');
model.study('std2').feature('time').set('useadvanceddisable', true);
model.study('std2').feature('time').set('disabledphysics', {'solid/lemm2/vis1'});

model.sol.create('sol2');
model.sol('sol2').study('std2');
model.sol('sol2').create('st1', 'StudyStep');
model.sol('sol2').feature('st1').set('study', 'std2');
model.sol('sol2').feature('st1').set('studystep', 'time');
model.sol('sol2').create('v1', 'Variables');
model.sol('sol2').feature('v1').feature('comp1_solid_lemm2_pw').set('scalemethod', 'manual');
model.sol('sol2').feature('v1').feature('comp1_u').set('scalemethod', 'manual');
model.sol('sol2').feature('v1').feature('comp1_solid_lemm2_pw').set('scaleval', '100000000');
model.sol('sol2').feature('v1').feature('comp1_u').set('scaleval', '1e-2*0.370446514358011');
model.sol('sol2').feature('v1').set('control', 'time');
model.sol('sol2').create('t1', 'Time');
model.sol('sol2').feature('t1').set('tlist', 'range(0, 0.01, 3)');
model.sol('sol2').feature('t1').set('plot', 'off');
model.sol('sol2').feature('t1').set('plotgroup', 'pg1');
model.sol('sol2').feature('t1').set('plotfreq', 'tout');
model.sol('sol2').feature('t1').set('probesel', 'all');
model.sol('sol2').feature('t1').set('probes', {});
model.sol('sol2').feature('t1').set('probefreq', 'tsteps');
model.sol('sol2').feature('t1').set('rtol', 0.001);
model.sol('sol2').feature('t1').set('atolglobalvaluemethod', 'factor');
model.sol('sol2').feature('t1').set('reacf', true);
model.sol('sol2').feature('t1').set('storeudot', true);
model.sol('sol2').feature('t1').set('endtimeinterpolation', true);
model.sol('sol2').feature('t1').set('timemethod', 'genalpha');
model.sol('sol2').feature('t1').set('control', 'time');
model.sol('sol2').feature('t1').feature('aDef').set('cachepattern', true);
model.sol('sol2').feature('t1').create('fc1', 'FullyCoupled');
model.sol('sol2').feature('t1').create('d1', 'Direct');
model.sol('sol2').feature('t1').feature('d1').set('linsolver', 'pardiso');
model.sol('sol2').feature('t1').feature('d1').set('pivotperturb', 1.0E-9);
model.sol('sol2').feature('t1').feature('d1').label('Suggested Direct Solver (solid)');
model.sol('sol2').feature('t1').create('i1', 'Iterative');
model.sol('sol2').feature('t1').feature('i1').set('linsolver', 'gmres');
model.sol('sol2').feature('t1').feature('i1').set('rhob', 400);
model.sol('sol2').feature('t1').feature('i1').set('nlinnormuse', true);
model.sol('sol2').feature('t1').feature('i1').label('Suggested Iterative Solver (solid)');
model.sol('sol2').feature('t1').feature('i1').create('mg1', 'Multigrid');
model.sol('sol2').feature('t1').feature('i1').feature('mg1').set('prefun', 'gmg');
model.sol('sol2').feature('t1').feature('i1').feature('mg1').feature('pr').create('so1', 'SOR');
model.sol('sol2').feature('t1').feature('i1').feature('mg1').feature('pr').feature('so1').set('relax', 0.8);
model.sol('sol2').feature('t1').feature('i1').feature('mg1').feature('po').create('so1', 'SOR');
model.sol('sol2').feature('t1').feature('i1').feature('mg1').feature('po').feature('so1').set('relax', 0.8);
model.sol('sol2').feature('t1').feature('i1').feature('mg1').feature('cs').create('d1', 'Direct');
model.sol('sol2').feature('t1').feature('i1').feature('mg1').feature('cs').feature('d1').set('linsolver', 'pardiso');
model.sol('sol2').feature('t1').feature('i1').feature('mg1').feature('cs').feature('d1').set('pivotperturb', 1.0E-9);
model.sol('sol2').feature('t1').feature('fc1').set('linsolver', 'd1');
model.sol('sol2').feature('t1').feature.remove('fcDef');
model.sol('sol2').attach('std2');
model.sol('sol2').feature('v1').feature('comp1_solid_lemm2_pw').set('scaleval', '1e6');
model.sol('sol2').feature('t1').set('estrat', 'exclude');
model.sol('sol2').runAll;

model.result('pg2').run;
model.result('pg2').feature.duplicate('ptgr2', 'ptgr1');
model.result('pg2').run;
model.result('pg2').feature('ptgr2').set('data', 'dset2');
model.result('pg2').feature('ptgr2').setIndex('legends', 'Time-domain solution (with pruning)', 0);
model.result('pg2').run;

model.title(['Viscoelastic Structural Damper ' native2unicode(hex2dec({'20' '14'}), 'unicode') ' Transient Analysis']);

model.description('This example performs a transient analysis of a viscoelastic damper. The damper is intended for reduction of wind-induced and seismic vibrations in buildings and other tall structures.');

model.mesh.clearMeshes;

model.sol('sol1').clearSolutionData;
model.sol('sol2').clearSolutionData;

model.label('viscoelastic_damper_transient.mph');

model.modelNode.label('Components');

out = model;
