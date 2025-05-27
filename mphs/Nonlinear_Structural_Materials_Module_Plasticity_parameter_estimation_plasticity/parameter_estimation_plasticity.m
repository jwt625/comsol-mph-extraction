function out = model
%
% parameter_estimation_plasticity.m
%
% Model exported on May 26 2025, 21:31 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/Nonlinear_Structural_Materials_Module/Plasticity');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 3);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.physics.create('solid', 'SolidMechanics', 'geom1');
model.physics('solid').model('comp1');

model.study.create('std1');
model.study('std1').create('time', 'Transient');
model.study('std1').feature('time').setSolveFor('/physics/solid', true);

model.baseSystem('mpa');

model.result.table.create('tbl1', 'Table');
model.result.table('tbl1').label('Cyclic Shear Data');
model.result.table('tbl1').importData('parameter_estimation_plasticity_shear_data.txt');
model.result.create('pg1', 'PlotGroup1D');
model.result('pg1').set('data', 'none');
model.result('pg1').create('tblp1', 'Table');
model.result('pg1').feature('tblp1').set('source', 'table');
model.result('pg1').feature('tblp1').set('table', 'tbl1');
model.result('pg1').feature('tblp1').set('linewidth', 'preference');
model.result('pg1').feature('tblp1').set('markerpos', 'datapoints');
model.result('pg1').run;
model.result('pg1').feature('tblp1').set('xaxisdata', 2);
model.result('pg1').feature('tblp1').set('plotcolumninput', 'manual');
model.result('pg1').feature('tblp1').set('plotcolumns', [3]);
model.result('pg1').feature('tblp1').set('linemarker', 'point');
model.result('pg1').run;
model.result('pg1').label('Cyclic Shear Data');
model.result('pg1').set('titletype', 'label');
model.result('pg1').set('xlabelactive', true);
model.result('pg1').set('xlabel', 'Engineering shear strain (1)');
model.result('pg1').set('ylabelactive', true);
model.result('pg1').run;

model.func.create('int1', 'Interpolation');
model.func('int1').label('Shear Strain');
model.func('int1').set('source', 'resultTable');
model.func('int1').setIndex('funcs', 'shear_strain', 0, 0);
model.func('int1').setIndex('fununit', 1, 0);
model.func('int1').setIndex('argunit', 's', 0);

model.param.set('L', '1[mm]');
model.param.descr('L', 'Unit length');
model.param.set('rho0', '8000[kg/m^3]');
model.param.descr('rho0', 'Density');
model.param.set('E0', '200[GPa]');
model.param.descr('E0', 'Young''s modulus');
model.param.set('nu0', '0.3');
model.param.descr('nu0', 'Poisson''s ratio');
model.param.set('sig_y0', '350[MPa]');
model.param.descr('sig_y0', 'Initial yield stress');
model.param.set('sig_sat', '100[MPa]');
model.param.descr('sig_sat', 'Saturation stress');
model.param.set('beta', '5');
model.param.descr('beta', 'Saturation exponent');
model.param.set('C_k', '10[GPa]');
model.param.descr('C_k', 'Kinematic hardening modulus');
model.param.set('E_k', '1/(1/E0+1/C_k)');
model.param.descr('E_k', 'Kinematic tangent modulus');
model.param.set('gamma_k', '100');
model.param.descr('gamma_k', 'Kinematic hardening parameter');

model.geom('geom1').create('blk1', 'Block');
model.geom('geom1').feature('blk1').set('size', {'L' 'L' 'L'});
model.geom('geom1').run;

model.material.create('mat1', 'Common', 'comp1');
model.material('mat1').propertyGroup.create('Enu', 'Young''s_modulus_and_Poisson''s_ratio');
model.material('mat1').propertyGroup('Enu').set('E', {'E0'});
model.material('mat1').propertyGroup('Enu').set('nu', {'nu0'});
model.material('mat1').propertyGroup('def').set('density', {'rho0'});
model.material('mat1').propertyGroup.create('ElastoplasticModel', 'Elastoplastic_material_model');
model.material('mat1').propertyGroup('ElastoplasticModel').set('sigmags', {'sig_y0'});
model.material('mat1').propertyGroup('ElastoplasticModel').set('Ek', {'E_k'});
model.material('mat1').propertyGroup.create('Voce', '#Voce');
model.material('mat1').propertyGroup('Voce').set('sigma_voc', {'sig_sat'});
model.material('mat1').propertyGroup('Voce').set('beta_voc', {'beta'});
model.material('mat1').propertyGroup.create('ArmstrongFrederick', '#Armstrong-Frederick');
model.material('mat1').propertyGroup('ArmstrongFrederick').set('Ck', {'C_k'});
model.material('mat1').propertyGroup('ArmstrongFrederick').set('gammak', {'gamma_k'});

model.physics('solid').prop('StructuralTransientBehavior').set('StructuralTransientBehavior', 'Quasistatic');
model.physics('solid').prop('ShapeProperty').set('order_displacement', 1);
model.physics('solid').feature('lemm1').set('geometricNonlinearity', 'linear');
model.physics('solid').feature('lemm1').set('reducedIntegration', true);
model.physics('solid').feature('lemm1').create('plsty1', 'Plasticity', 3);
model.physics('solid').feature('lemm1').feature('plsty1').label('Linear Kinematic Hardening');
model.physics('solid').feature('lemm1').feature('plsty1').set('IsotropicHardeningModel', 'Voce');
model.physics('solid').feature('lemm1').feature('plsty1').set('KinematicHardeningModel', 'LinearKinematicHardening');
model.physics('solid').create('fix1', 'Fixed', 2);
model.physics('solid').feature('fix1').selection.set([3]);
model.physics('solid').create('roll1', 'Roller', 2);
model.physics('solid').feature('roll1').selection.set([2 5]);
model.physics('solid').create('disp1', 'Displacement2', 2);
model.physics('solid').feature('disp1').selection.set([4]);
model.physics('solid').feature('disp1').setIndex('Direction', 'prescribed', 0);
model.physics('solid').feature('disp1').setIndex('U0', 'shear_strain(t)*L', 0);
model.physics('solid').feature('disp1').setIndex('Direction', 'prescribed', 1);
model.physics('solid').feature('disp1').setIndex('Direction', 'prescribed', 2);

model.cpl.create('aveop1', 'Average', 'geom1');
model.cpl('aveop1').set('axisym', true);
model.cpl('aveop1').selection.set([1]);

model.variable.create('var1');
model.variable('var1').model('comp1');
model.variable('var1').set('tau', 'aveop1(solid.sxz)');
model.variable('var1').descr('tau', 'Shear stress');

model.mesh('mesh1').create('map1', 'Map');
model.mesh('mesh1').feature('map1').selection.set([1]);
model.mesh('mesh1').feature('map1').create('dis1', 'Distribution');
model.mesh('mesh1').feature('map1').feature('dis1').selection.all;
model.mesh('mesh1').feature('map1').feature('dis1').set('numelem', 1);
model.mesh('mesh1').create('swe1', 'Sweep');
model.mesh('mesh1').feature('swe1').create('dis1', 'Distribution');
model.mesh('mesh1').feature('swe1').feature('dis1').set('numelem', 1);
model.mesh('mesh1').run;

model.study('std1').setGenPlots(false);
model.study('std1').label('Forward Problem');
model.study('std1').feature('time').set('tlist', 'range(0,1,100)');

model.sol.create('sol1');
model.sol('sol1').study('std1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'time');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').feature('comp1_u').set('scalemethod', 'manual');
model.sol('sol1').feature('v1').feature('comp1_u').set('scaleval', '1e-2*1.7320508075688774');
model.sol('sol1').feature('v1').set('control', 'time');
model.sol('sol1').create('t1', 'Time');
model.sol('sol1').feature('t1').set('tlist', 'range(0,1,100)');
model.sol('sol1').feature('t1').set('plot', 'off');
model.sol('sol1').feature('t1').set('plotgroup', 'pg1');
model.sol('sol1').feature('t1').set('plotfreq', 'tout');
model.sol('sol1').feature('t1').set('probesel', 'all');
model.sol('sol1').feature('t1').set('probes', {});
model.sol('sol1').feature('t1').set('probefreq', 'tsteps');
model.sol('sol1').feature('t1').set('rtol', 0.001);
model.sol('sol1').feature('t1').set('atolglobalvaluemethod', 'factor');
model.sol('sol1').feature('t1').set('reacf', true);
model.sol('sol1').feature('t1').set('storeudot', true);
model.sol('sol1').feature('t1').set('endtimeinterpolation', true);
model.sol('sol1').feature('t1').set('control', 'time');
model.sol('sol1').feature('t1').feature('aDef').set('cachepattern', true);
model.sol('sol1').feature('t1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('t1').create('d1', 'Direct');
model.sol('sol1').feature('t1').feature('d1').set('linsolver', 'pardiso');
model.sol('sol1').feature('t1').feature('d1').set('pivotperturb', 1.0E-9);
model.sol('sol1').feature('t1').feature('d1').set('nliniterrefine', true);
model.sol('sol1').feature('t1').feature('d1').label('Suggested Direct Solver (solid)');
model.sol('sol1').feature('t1').create('i1', 'Iterative');
model.sol('sol1').feature('t1').feature('i1').set('linsolver', 'gmres');
model.sol('sol1').feature('t1').feature('i1').set('rhob', 40);
model.sol('sol1').feature('t1').feature('i1').set('nlinnormuse', true);
model.sol('sol1').feature('t1').feature('i1').label('Suggested Iterative Solver (GMRES with SA AMG) (solid)');
model.sol('sol1').feature('t1').feature('i1').create('mg1', 'Multigrid');
model.sol('sol1').feature('t1').feature('i1').feature('mg1').set('prefun', 'saamg');
model.sol('sol1').feature('t1').feature('i1').feature('mg1').set('usesmooth', false);
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('pr').create('so1', 'SOR');
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('pr').feature('so1').set('relax', 0.8);
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('po').create('so1', 'SOR');
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('po').feature('so1').set('relax', 0.8);
model.sol('sol1').feature('t1').feature('fc1').set('linsolver', 'd1');
model.sol('sol1').feature('t1').feature.remove('fcDef');
model.sol('sol1').attach('std1');
model.sol('sol1').feature('t1').set('tstepsbdf', 'strict');
model.sol('sol1').feature('t1').set('consistent', false);
model.sol('sol1').runAll;

model.result('pg1').run;
model.result.duplicate('pg2', 'pg1');
model.result('pg2').run;
model.result('pg2').label('Initial Model Prediction');
model.result('pg2').set('data', 'dset1');
model.result('pg2').set('legendpos', 'lowerright');
model.result('pg2').run;
model.result('pg2').feature('tblp1').set('legend', true);
model.result('pg2').feature('tblp1').set('legendmethod', 'manual');
model.result('pg2').feature('tblp1').setIndex('legends', 'Shear data', 0);
model.result('pg2').run;
model.result('pg2').create('glob1', 'Global');
model.result('pg2').feature('glob1').set('markerpos', 'datapoints');
model.result('pg2').feature('glob1').set('linewidth', 'preference');
model.result('pg2').feature('glob1').setIndex('expr', 'tau', 0);
model.result('pg2').feature('glob1').set('xdata', 'expr');
model.result('pg2').feature('glob1').set('xdataexpr', 'shear_strain(t)');
model.result('pg2').feature('glob1').set('autosolution', false);
model.result('pg2').run;

model.common.create('glso1', 'GlobalLeastSquaresObjective', 'comp1');
model.common('glso1').set('source', 'resultTable');
model.common('glso1').setEntry('columnType', 'col2', 'none');
model.common('glso1').setEntry('modelExpression', 'col3', 'comp1.tau');
model.common('glso1').setEntry('variableName', 'col3', 'shear_stress');
model.common('glso1').setEntry('unit', 'col3', 'MPa');

model.study.create('std2');
model.study('std2').create('time', 'Transient');
model.study('std2').feature('time').setSolveFor('/physics/solid', true);
model.study('std2').label('Parameter Estimation: Linear Kinematic Hardening');
model.study('std2').setGenPlots(false);
model.study('std2').create('lsqo', 'LSQOptimization');
model.study('std2').feature('lsqo').setIndex('pname', 'L', 0);
model.study('std2').feature('lsqo').setIndex('initval', '1[mm]', 0);
model.study('std2').feature('lsqo').setIndex('scale', 1, 0);
model.study('std2').feature('lsqo').setIndex('lbound', '', 0);
model.study('std2').feature('lsqo').setIndex('ubound', '', 0);
model.study('std2').feature('lsqo').setIndex('pname', 'L', 0);
model.study('std2').feature('lsqo').setIndex('initval', '1[mm]', 0);
model.study('std2').feature('lsqo').setIndex('scale', 1, 0);
model.study('std2').feature('lsqo').setIndex('lbound', '', 0);
model.study('std2').feature('lsqo').setIndex('ubound', '', 0);
model.study('std2').feature('lsqo').setIndex('pname', 'rho0', 1);
model.study('std2').feature('lsqo').setIndex('initval', '8000[kg/m^3]', 1);
model.study('std2').feature('lsqo').setIndex('scale', 1, 1);
model.study('std2').feature('lsqo').setIndex('lbound', '', 1);
model.study('std2').feature('lsqo').setIndex('ubound', '', 1);
model.study('std2').feature('lsqo').setIndex('pname', 'rho0', 1);
model.study('std2').feature('lsqo').setIndex('initval', '8000[kg/m^3]', 1);
model.study('std2').feature('lsqo').setIndex('scale', 1, 1);
model.study('std2').feature('lsqo').setIndex('lbound', '', 1);
model.study('std2').feature('lsqo').setIndex('ubound', '', 1);
model.study('std2').feature('lsqo').setIndex('pname', 'E0', 2);
model.study('std2').feature('lsqo').setIndex('initval', '200[GPa]', 2);
model.study('std2').feature('lsqo').setIndex('scale', 1, 2);
model.study('std2').feature('lsqo').setIndex('lbound', '', 2);
model.study('std2').feature('lsqo').setIndex('ubound', '', 2);
model.study('std2').feature('lsqo').setIndex('pname', 'E0', 2);
model.study('std2').feature('lsqo').setIndex('initval', '200[GPa]', 2);
model.study('std2').feature('lsqo').setIndex('scale', 1, 2);
model.study('std2').feature('lsqo').setIndex('lbound', '', 2);
model.study('std2').feature('lsqo').setIndex('ubound', '', 2);
model.study('std2').feature('lsqo').setIndex('pname', 'sig_sat', 0);
model.study('std2').feature('lsqo').setIndex('scale', '100[MPa]', 0);
model.study('std2').feature('lsqo').setIndex('pname', 'beta', 1);
model.study('std2').feature('lsqo').setIndex('scale', 5, 1);
model.study('std2').feature('lsqo').setIndex('pname', 'C_k', 2);
model.study('std2').feature('lsqo').setIndex('scale', '10[GPa]', 2);
model.study('std2').feature('lsqo').set('lsqdatamethod', 'lsq');

model.sol.create('sol2');
model.sol('sol2').study('std2');

model.study('std2').feature('lsqo').set('lsqmessage', {});

model.sol('sol2').create('st1', 'StudyStep');
model.sol('sol2').feature('st1').set('study', 'std2');
model.sol('sol2').feature('st1').set('studystep', 'time');
model.sol('sol2').create('v1', 'Variables');
model.sol('sol2').feature('v1').feature('comp1_u').set('scalemethod', 'manual');
model.sol('sol2').feature('v1').feature('comp1_u').set('scaleval', '1e-2*1.7320508075688774');
model.sol('sol2').feature('v1').set('control', 'time');
model.sol('sol2').create('o1', 'Optimization');
model.sol('sol2').feature('o1').set('gradientlm', 'numeric');
model.sol('sol2').feature('o1').set('diffint', 1.0E-6);
model.sol('sol2').feature('o1').set('control', 'lsqo');
model.sol('sol2').feature('o1').create('t1', 'TimeAttrib');
model.sol('sol2').feature('o1').feature('t1').set('rtol', 0.001);
model.sol('sol2').feature('o1').feature('t1').set('atolglobalvaluemethod', 'factor');
model.sol('sol2').feature('o1').feature('t1').set('reacf', true);
model.sol('sol2').feature('o1').feature('t1').set('storeudot', true);
model.sol('sol2').feature('o1').feature('t1').set('endtimeinterpolation', true);
model.sol('sol2').feature('o1').feature('t1').set('control', 'time');
model.sol('sol2').feature('o1').feature('t1').set('tlistlsq', [0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40 41 42 43 44 45 46 47 48 49 50 51 52 53 54 55 56 57 58 59 60 61 62 63 64 65 66 67 68 69 70 71 72 73 74 75 76 77 78 79 80 81 82 83 84 85 86 87 88 89 90 91 92 93 94 95 96 97 98 99 100]);
model.sol('sol2').feature('o1').feature('t1').set('lsqtimesout', ['      0.00' newline '      1.00' newline '      2.00' newline '      3.00' newline '      4.00' newline '      5.00' newline '      6.00' newline '      7.00' newline '      8.00' newline '      9.00' newline '      10.0' newline '      11.0' newline '      12.0' newline '      13.0' newline '      14.0' newline '      15.0' newline '      16.0' newline '      17.0' newline '      18.0' newline '      19.0' newline '      20.0' newline '      21.0' newline '      22.0' newline '      23.0' newline '      24.0' newline '      25.0' newline '      26.0' newline '      27.0' newline '      28.0' newline '      29.0' newline '      30.0' newline '      31.0' newline '      32.0' newline '      33.0' newline '      34.0' newline '      35.0' newline '      36.0' newline '      37.0' newline '      38.0' newline '      39.0' newline '      40.0' newline '      41.0' newline '      42.0' newline '      43.0' newline '      44.0' newline '      45.0' newline '      46.0' newline '      47.0' newline '      48.0' newline '      49.0' newline '      50.0' newline '      51.0' newline '      52.0' newline '      53.0' newline '      54.0' newline '      55.0' newline '      56.0' newline '      57.0' newline '      58.0' newline '      59.0' newline '      60.0' newline '      61.0' newline '      62.0' newline '      63.0' newline '      64.0' newline '      65.0' newline '      66.0' newline '      67.0' newline '      68.0' newline '      69.0' newline '      70.0' newline '      71.0' newline '      72.0' newline '      73.0' newline '      74.0' newline '      75.0' newline '      76.0' newline '      77.0' newline '      78.0' newline '      79.0' newline '      80.0' newline '      81.0' newline '      82.0' newline '      83.0' newline '      84.0' newline '      85.0' newline '      86.0' newline '      87.0' newline '      88.0' newline '      89.0' newline '      90.0' newline '      91.0' newline '      92.0' newline '      93.0' newline '      94.0' newline '      95.0' newline '      96.0' newline '      97.0' newline '      98.0' newline '      99.0' newline '       100' newline ]);
model.sol('sol2').feature('o1').feature('t1').set('tout', 'tlist');
model.sol('sol2').feature('o1').feature('t1').feature('aDef').set('cachepattern', true);
model.sol('sol2').feature('o1').feature('t1').create('fc1', 'FullyCoupled');
model.sol('sol2').feature('o1').feature('t1').create('d1', 'Direct');
model.sol('sol2').feature('o1').feature('t1').feature('d1').set('linsolver', 'pardiso');
model.sol('sol2').feature('o1').feature('t1').feature('d1').set('pivotperturb', 1.0E-9);
model.sol('sol2').feature('o1').feature('t1').feature('d1').set('nliniterrefine', true);
model.sol('sol2').feature('o1').feature('t1').feature('d1').label('Suggested Direct Solver (solid)');
model.sol('sol2').feature('o1').feature('t1').create('i1', 'Iterative');
model.sol('sol2').feature('o1').feature('t1').feature('i1').set('linsolver', 'gmres');
model.sol('sol2').feature('o1').feature('t1').feature('i1').set('rhob', 40);
model.sol('sol2').feature('o1').feature('t1').feature('i1').set('nlinnormuse', true);
model.sol('sol2').feature('o1').feature('t1').feature('i1').label('Suggested Iterative Solver (GMRES with SA AMG) (solid)');
model.sol('sol2').feature('o1').feature('t1').feature('i1').create('mg1', 'Multigrid');
model.sol('sol2').feature('o1').feature('t1').feature('i1').feature('mg1').set('prefun', 'saamg');
model.sol('sol2').feature('o1').feature('t1').feature('i1').feature('mg1').set('usesmooth', false);
model.sol('sol2').feature('o1').feature('t1').feature('i1').feature('mg1').feature('pr').create('so1', 'SOR');
model.sol('sol2').feature('o1').feature('t1').feature('i1').feature('mg1').feature('pr').feature('so1').set('relax', 0.8);
model.sol('sol2').feature('o1').feature('t1').feature('i1').feature('mg1').feature('po').create('so1', 'SOR');
model.sol('sol2').feature('o1').feature('t1').feature('i1').feature('mg1').feature('po').feature('so1').set('relax', 0.8);
model.sol('sol2').feature('o1').feature('t1').feature('fc1').set('linsolver', 'd1');
model.sol('sol2').feature('o1').feature('t1').feature.remove('fcDef');
model.sol('sol2').attach('std2');
model.sol('sol2').feature('o1').feature('t1').set('tstepsbdf', 'strict');
model.sol('sol2').feature('o1').feature('t1').set('consistent', false);

model.result('pg2').run;
model.result.duplicate('pg3', 'pg2');
model.result('pg3').run;
model.result('pg3').label('Parameter Estimation: Linear Kinematic Hardening');
model.result('pg3').set('data', 'dset2');

model.study('std2').feature('lsqo').set('plot', true);
model.study('std2').feature('lsqo').set('plotgroup', 'pg3');

model.sol('sol2').runAll;

model.result('pg3').run;

model.study('std2').feature('lsqo').set('probewindow', '');

model.physics('solid').feature('lemm1').feature.duplicate('plsty2', 'plsty1');
model.physics('solid').feature('lemm1').feature('plsty2').label('Armstrong-Frederick Kinematic Hardening');
model.physics('solid').feature('lemm1').feature('plsty2').set('KinematicHardeningModel', 'ArmstrongFrederick');

model.study.create('std3');
model.study('std3').create('time', 'Transient');
model.study('std3').feature('time').setSolveFor('/physics/solid', true);
model.study('std3').label('Parameter Estimation: Armstrong-Frederick Kinematic Hardening');
model.study('std3').setGenPlots(false);
model.study('std3').create('lsqo', 'LSQOptimization');
model.study('std3').feature('lsqo').setIndex('pname', 'L', 0);
model.study('std3').feature('lsqo').setIndex('initval', '1[mm]', 0);
model.study('std3').feature('lsqo').setIndex('scale', 1, 0);
model.study('std3').feature('lsqo').setIndex('lbound', '', 0);
model.study('std3').feature('lsqo').setIndex('ubound', '', 0);
model.study('std3').feature('lsqo').setIndex('pname', 'L', 0);
model.study('std3').feature('lsqo').setIndex('initval', '1[mm]', 0);
model.study('std3').feature('lsqo').setIndex('scale', 1, 0);
model.study('std3').feature('lsqo').setIndex('lbound', '', 0);
model.study('std3').feature('lsqo').setIndex('ubound', '', 0);
model.study('std3').feature('lsqo').setIndex('pname', 'rho0', 1);
model.study('std3').feature('lsqo').setIndex('initval', '8000[kg/m^3]', 1);
model.study('std3').feature('lsqo').setIndex('scale', 1, 1);
model.study('std3').feature('lsqo').setIndex('lbound', '', 1);
model.study('std3').feature('lsqo').setIndex('ubound', '', 1);
model.study('std3').feature('lsqo').setIndex('pname', 'rho0', 1);
model.study('std3').feature('lsqo').setIndex('initval', '8000[kg/m^3]', 1);
model.study('std3').feature('lsqo').setIndex('scale', 1, 1);
model.study('std3').feature('lsqo').setIndex('lbound', '', 1);
model.study('std3').feature('lsqo').setIndex('ubound', '', 1);
model.study('std3').feature('lsqo').setIndex('pname', 'E0', 2);
model.study('std3').feature('lsqo').setIndex('initval', '200[GPa]', 2);
model.study('std3').feature('lsqo').setIndex('scale', 1, 2);
model.study('std3').feature('lsqo').setIndex('lbound', '', 2);
model.study('std3').feature('lsqo').setIndex('ubound', '', 2);
model.study('std3').feature('lsqo').setIndex('pname', 'E0', 2);
model.study('std3').feature('lsqo').setIndex('initval', '200[GPa]', 2);
model.study('std3').feature('lsqo').setIndex('scale', 1, 2);
model.study('std3').feature('lsqo').setIndex('lbound', '', 2);
model.study('std3').feature('lsqo').setIndex('ubound', '', 2);
model.study('std3').feature('lsqo').setIndex('pname', 'nu0', 3);
model.study('std3').feature('lsqo').setIndex('initval', 0.3, 3);
model.study('std3').feature('lsqo').setIndex('scale', 1, 3);
model.study('std3').feature('lsqo').setIndex('lbound', '', 3);
model.study('std3').feature('lsqo').setIndex('ubound', '', 3);
model.study('std3').feature('lsqo').setIndex('pname', 'nu0', 3);
model.study('std3').feature('lsqo').setIndex('initval', 0.3, 3);
model.study('std3').feature('lsqo').setIndex('scale', 1, 3);
model.study('std3').feature('lsqo').setIndex('lbound', '', 3);
model.study('std3').feature('lsqo').setIndex('ubound', '', 3);
model.study('std3').feature('lsqo').setIndex('pname', 'sig_sat', 0);
model.study('std3').feature('lsqo').setIndex('scale', '100[MPa]', 0);
model.study('std3').feature('lsqo').setIndex('pname', 'beta', 1);
model.study('std3').feature('lsqo').setIndex('scale', 10, 1);
model.study('std3').feature('lsqo').setIndex('pname', 'C_k', 2);
model.study('std3').feature('lsqo').setIndex('scale', '10[GPa]', 2);
model.study('std3').feature('lsqo').setIndex('pname', 'gamma_k', 3);
model.study('std3').feature('lsqo').setIndex('scale', 100, 3);
model.study('std3').feature('lsqo').set('lsqdatamethod', 'lsq');

model.sol.create('sol3');
model.sol('sol3').study('std3');

model.study('std3').feature('lsqo').set('lsqmessage', {});

model.sol('sol3').create('st1', 'StudyStep');
model.sol('sol3').feature('st1').set('study', 'std3');
model.sol('sol3').feature('st1').set('studystep', 'time');
model.sol('sol3').create('v1', 'Variables');
model.sol('sol3').feature('v1').feature('comp1_u').set('scalemethod', 'manual');
model.sol('sol3').feature('v1').feature('comp1_u').set('scaleval', '1e-2*1.7320508075688774');
model.sol('sol3').feature('v1').set('control', 'time');
model.sol('sol3').create('o1', 'Optimization');
model.sol('sol3').feature('o1').set('gradientlm', 'numeric');
model.sol('sol3').feature('o1').set('diffint', 1.0E-6);
model.sol('sol3').feature('o1').set('control', 'lsqo');
model.sol('sol3').feature('o1').create('t1', 'TimeAttrib');
model.sol('sol3').feature('o1').feature('t1').set('rtol', 0.001);
model.sol('sol3').feature('o1').feature('t1').set('atolglobalvaluemethod', 'factor');
model.sol('sol3').feature('o1').feature('t1').set('reacf', true);
model.sol('sol3').feature('o1').feature('t1').set('storeudot', true);
model.sol('sol3').feature('o1').feature('t1').set('endtimeinterpolation', true);
model.sol('sol3').feature('o1').feature('t1').set('control', 'time');
model.sol('sol3').feature('o1').feature('t1').set('tlistlsq', [0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40 41 42 43 44 45 46 47 48 49 50 51 52 53 54 55 56 57 58 59 60 61 62 63 64 65 66 67 68 69 70 71 72 73 74 75 76 77 78 79 80 81 82 83 84 85 86 87 88 89 90 91 92 93 94 95 96 97 98 99 100]);
model.sol('sol3').feature('o1').feature('t1').set('lsqtimesout', ['      0.00' newline '      1.00' newline '      2.00' newline '      3.00' newline '      4.00' newline '      5.00' newline '      6.00' newline '      7.00' newline '      8.00' newline '      9.00' newline '      10.0' newline '      11.0' newline '      12.0' newline '      13.0' newline '      14.0' newline '      15.0' newline '      16.0' newline '      17.0' newline '      18.0' newline '      19.0' newline '      20.0' newline '      21.0' newline '      22.0' newline '      23.0' newline '      24.0' newline '      25.0' newline '      26.0' newline '      27.0' newline '      28.0' newline '      29.0' newline '      30.0' newline '      31.0' newline '      32.0' newline '      33.0' newline '      34.0' newline '      35.0' newline '      36.0' newline '      37.0' newline '      38.0' newline '      39.0' newline '      40.0' newline '      41.0' newline '      42.0' newline '      43.0' newline '      44.0' newline '      45.0' newline '      46.0' newline '      47.0' newline '      48.0' newline '      49.0' newline '      50.0' newline '      51.0' newline '      52.0' newline '      53.0' newline '      54.0' newline '      55.0' newline '      56.0' newline '      57.0' newline '      58.0' newline '      59.0' newline '      60.0' newline '      61.0' newline '      62.0' newline '      63.0' newline '      64.0' newline '      65.0' newline '      66.0' newline '      67.0' newline '      68.0' newline '      69.0' newline '      70.0' newline '      71.0' newline '      72.0' newline '      73.0' newline '      74.0' newline '      75.0' newline '      76.0' newline '      77.0' newline '      78.0' newline '      79.0' newline '      80.0' newline '      81.0' newline '      82.0' newline '      83.0' newline '      84.0' newline '      85.0' newline '      86.0' newline '      87.0' newline '      88.0' newline '      89.0' newline '      90.0' newline '      91.0' newline '      92.0' newline '      93.0' newline '      94.0' newline '      95.0' newline '      96.0' newline '      97.0' newline '      98.0' newline '      99.0' newline '       100' newline ]);
model.sol('sol3').feature('o1').feature('t1').set('tout', 'tlist');
model.sol('sol3').feature('o1').feature('t1').feature('aDef').set('cachepattern', true);
model.sol('sol3').feature('o1').feature('t1').create('fc1', 'FullyCoupled');
model.sol('sol3').feature('o1').feature('t1').create('d1', 'Direct');
model.sol('sol3').feature('o1').feature('t1').feature('d1').set('linsolver', 'pardiso');
model.sol('sol3').feature('o1').feature('t1').feature('d1').set('pivotperturb', 1.0E-9);
model.sol('sol3').feature('o1').feature('t1').feature('d1').set('nliniterrefine', true);
model.sol('sol3').feature('o1').feature('t1').feature('d1').label('Suggested Direct Solver (solid)');
model.sol('sol3').feature('o1').feature('t1').create('i1', 'Iterative');
model.sol('sol3').feature('o1').feature('t1').feature('i1').set('linsolver', 'gmres');
model.sol('sol3').feature('o1').feature('t1').feature('i1').set('rhob', 40);
model.sol('sol3').feature('o1').feature('t1').feature('i1').set('nlinnormuse', true);
model.sol('sol3').feature('o1').feature('t1').feature('i1').label('Suggested Iterative Solver (GMRES with SA AMG) (solid)');
model.sol('sol3').feature('o1').feature('t1').feature('i1').create('mg1', 'Multigrid');
model.sol('sol3').feature('o1').feature('t1').feature('i1').feature('mg1').set('prefun', 'saamg');
model.sol('sol3').feature('o1').feature('t1').feature('i1').feature('mg1').set('usesmooth', false);
model.sol('sol3').feature('o1').feature('t1').feature('i1').feature('mg1').feature('pr').create('so1', 'SOR');
model.sol('sol3').feature('o1').feature('t1').feature('i1').feature('mg1').feature('pr').feature('so1').set('relax', 0.8);
model.sol('sol3').feature('o1').feature('t1').feature('i1').feature('mg1').feature('po').create('so1', 'SOR');
model.sol('sol3').feature('o1').feature('t1').feature('i1').feature('mg1').feature('po').feature('so1').set('relax', 0.8);
model.sol('sol3').feature('o1').feature('t1').feature('fc1').set('linsolver', 'd1');
model.sol('sol3').feature('o1').feature('t1').feature.remove('fcDef');
model.sol('sol3').attach('std3');
model.sol('sol3').feature('o1').feature('t1').set('tstepsbdf', 'strict');
model.sol('sol3').feature('o1').feature('t1').set('consistent', false);

model.result('pg3').run;
model.result.duplicate('pg4', 'pg3');
model.result('pg4').run;
model.result('pg4').label('Parameter Estimation: Armstrong-Frederick Kinematic Hardening');
model.result('pg4').set('data', 'dset3');

model.study('std3').feature('lsqo').set('plot', true);
model.study('std3').feature('lsqo').set('plotgroup', 'pg4');

model.sol('sol3').runAll;

model.result('pg4').run;

model.study('std3').feature('lsqo').set('probewindow', '');

model.result.evaluationGroup.create('std2lsqoparam1', 'EvaluationGroup');
model.result.evaluationGroup('std2lsqoparam1').set('defaultPlotID', 'estimatedParameters');
model.result.evaluationGroup('std2lsqoparam1').label('Estimated Parameters (std2) 1');
model.result.evaluationGroup('std2lsqoparam1').set('data', 'dset2');
model.result.evaluationGroup('std2lsqoparam1').setIndex('looplevelinput', 'last', 0);
model.result.evaluationGroup('std2lsqoparam1').set('transpose', true);
model.result.evaluationGroup('std2lsqoparam1').set('includeparameters', false);
model.result.evaluationGroup('std2lsqoparam1').create('gev1', 'EvalGlobal');
model.result.evaluationGroup('std2lsqoparam1').feature('gev1').setIndex('expr', 'sig_sat', 0);
model.result.evaluationGroup('std2lsqoparam1').feature('gev1').setIndex('expr', 'beta', 1);
model.result.evaluationGroup('std2lsqoparam1').feature('gev1').setIndex('expr', 'C_k', 2);
model.result.evaluationGroup('std2lsqoparam1').run;
model.result.evaluationGroup('std2lsqoparam1').label('Estimated Parameters (std2) 1');
model.result.evaluationGroup('std2lsqoparam1').label('Estimated Parameters: Linear Kinematic Hardening');
model.result.evaluationGroup.create('std3lsqoparam1', 'EvaluationGroup');
model.result.evaluationGroup('std3lsqoparam1').set('defaultPlotID', 'estimatedParameters');
model.result.evaluationGroup('std3lsqoparam1').label('Estimated Parameters (std3) 1');
model.result.evaluationGroup('std3lsqoparam1').set('data', 'dset3');
model.result.evaluationGroup('std3lsqoparam1').setIndex('looplevelinput', 'last', 0);
model.result.evaluationGroup('std3lsqoparam1').set('transpose', true);
model.result.evaluationGroup('std3lsqoparam1').set('includeparameters', false);
model.result.evaluationGroup('std3lsqoparam1').create('gev1', 'EvalGlobal');
model.result.evaluationGroup('std3lsqoparam1').feature('gev1').setIndex('expr', 'sig_sat', 0);
model.result.evaluationGroup('std3lsqoparam1').feature('gev1').setIndex('expr', 'beta', 1);
model.result.evaluationGroup('std3lsqoparam1').feature('gev1').setIndex('expr', 'C_k', 2);
model.result.evaluationGroup('std3lsqoparam1').feature('gev1').setIndex('expr', 'gamma_k', 3);
model.result.evaluationGroup('std3lsqoparam1').run;
model.result.evaluationGroup('std3lsqoparam1').label('Estimated Parameters (std3) 1');
model.result.evaluationGroup('std3lsqoparam1').label('Estimated Parameters: Armstrong-Frederick Kinematic Hardening');

model.study('std1').feature('time').set('useadvanceddisable', true);
model.study('std1').feature('time').set('disabledphysics', {'solid/lemm1/plsty2'});
model.study('std2').feature('time').set('useadvanceddisable', true);
model.study('std2').feature('time').set('disabledphysics', {'solid/lemm1/plsty2'});

model.result('pg4').run;

model.title('Parameter Estimation of Elastoplastic Materials');

model.description('This tutorial model demonstrates how to estimate the material parameters of a combined hardening elastoplastic material model given cyclic shear data.');

model.label('parameter_estimation_plasticity.mph');

model.modelNode.label('Components');

out = model;
