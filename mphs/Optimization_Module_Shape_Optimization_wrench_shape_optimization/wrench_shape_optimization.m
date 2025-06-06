function out = model
%
% wrench_shape_optimization.m
%
% Model exported on May 26 2025, 21:31 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/Optimization_Module/Shape_Optimization');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 3);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.physics.create('solid', 'SolidMechanics', 'geom1');
model.physics('solid').model('comp1');

model.study.create('std1');
model.study('std1').create('sho', 'ShapeOptimization');
model.study('std1').feature('sho').setSolveFor('/physics/solid', true);
model.study('std1').create('stat', 'Stationary');
model.study('std1').feature('stat').setSolveFor('/physics/solid', true);

model.common.create('fsd1', 'FreeShapeDomain', 'comp1');
model.common('fsd1').selection.all;

model.study('std1').feature('sho').setIndex('optobj', 'comp1.solid.Ws_tot', 0);
model.study('std1').feature('sho').set('objectivescaling', 'init');
model.study('std1').feature('sho').setIndex('constraintExpression', 'comp1.fsd1.relVolume', 0);
model.study('std1').feature('sho').setIndex('constraintUbound', '1', 0);

model.param.create('par2');
model.param('par2').label('Geometrical Parameters');
model.param('par2').set('xbolt', '-0.05766114111[m]');
model.param('par2').descr('xbolt', 'Bolt x position');
model.param('par2').set('ybolt', '0.002375[m]');
model.param('par2').descr('ybolt', 'Bolt y position');
model.param('par2').set('zbolt', '-0.00124108777[m]');
model.param('par2').descr('zbolt', 'Bolt z position');
model.param('par2').set('dbolt', '0.01283160973[m]');
model.param('par2').descr('dbolt', 'Bolt diameter');
model.param('par2').set('dhole', '0.01267099011[m]');
model.param('par2').descr('dhole', 'Hole diameter');
model.param('par2').set('xhole', '0.05803823603[m]');
model.param('par2').descr('xhole', 'Hole x position');
model.param('par2').set('yhole', '-3.745973518E-5[m]');
model.param('par2').descr('yhole', 'Hole y position');
model.param('par2').set('zhole', '-2.161723792E-4[m]');
model.param('par2').descr('zhole', 'Hole z position');
model.param('par2').set('xholeaxis', '0.001098722599[m]');
model.param('par2').descr('xholeaxis', 'Hole axis x-component');
model.param('par2').set('yholeaxis', '-0.006231165503[m]');
model.param('par2').descr('yholeaxis', 'Hole axis y-component');
model.param('par2').set('zholeaxis', '0[m]');
model.param('par2').descr('zholeaxis', 'Hole axis z-component');

model.geom('geom1').create('imp1', 'Import');
model.geom('geom1').feature('imp1').set('filename', 'wrench.mphbin');
model.geom('geom1').feature('imp1').importData;
model.geom('geom1').feature('imp1').set('selresult', true);
model.geom('geom1').create('cylsel1', 'CylinderSelection');
model.geom('geom1').feature('cylsel1').label('Nut Faces');
model.geom('geom1').feature('cylsel1').set('entitydim', 2);
model.geom('geom1').feature('cylsel1').set('r', 'dbolt*0.7');
model.geom('geom1').feature('cylsel1').set('axistype', 'y');
model.geom('geom1').feature('cylsel1').set('pos', {'xbolt' 'ybolt' 'zbolt'});
model.geom('geom1').feature('cylsel1').set('condition', 'inside');
model.geom('geom1').run('cylsel1');
model.geom('geom1').create('cylsel2', 'CylinderSelection');
model.geom('geom1').feature('cylsel2').label('Handle Hole Faces');
model.geom('geom1').feature('cylsel2').set('entitydim', 2);
model.geom('geom1').feature('cylsel2').set('r', 'dhole*0.6');
model.geom('geom1').feature('cylsel2').set('pos', {'xhole' 'yhole' 'zhole'});
model.geom('geom1').feature('cylsel2').set('axistype', 'cartesian');
model.geom('geom1').feature('cylsel2').set('ax3', {'xholeaxis' 'yholeaxis' '1'});
model.geom('geom1').feature('cylsel2').setIndex('ax3', 'zholeaxis', 2);
model.geom('geom1').feature('cylsel2').set('condition', 'inside');
model.geom('geom1').run('cylsel2');
model.geom('geom1').create('adjsel1', 'AdjacentSelection');
model.geom('geom1').feature('adjsel1').label('Interior Faces');
model.geom('geom1').feature('adjsel1').set('input', {'imp1'});
model.geom('geom1').run('adjsel1');
model.geom('geom1').create('comsel1', 'ComplementSelection');
model.geom('geom1').feature('comsel1').label('Optimized Faces');
model.geom('geom1').feature('comsel1').set('entitydim', 2);
model.geom('geom1').feature('comsel1').set('input', {'cylsel1' 'cylsel2'});
model.geom('geom1').run;

model.material.create('mat1', 'Common', 'comp1');
model.material('mat1').propertyGroup.create('Enu', 'Young''s modulus and Poisson''s ratio');
model.material('mat1').propertyGroup('Enu').func.create('int1', 'Interpolation');
model.material('mat1').propertyGroup('Enu').func.create('int2', 'Interpolation');
model.material('mat1').propertyGroup.create('Murnaghan', 'Murnaghan');
model.material('mat1').propertyGroup.create('ElastoplasticModel', 'Elastoplastic material model');
model.material('mat1').propertyGroup('ElastoplasticModel').func.create('int1', 'Interpolation');
model.material('mat1').propertyGroup.create('Ludwik', 'Ludwik');
model.material('mat1').propertyGroup('Ludwik').func.create('int1', 'Interpolation');
model.material('mat1').propertyGroup.create('JohnsonCook', 'Johnson-Cook');
model.material('mat1').propertyGroup.create('Swift', 'Swift');
model.material('mat1').propertyGroup.create('Voce', 'Voce');
model.material('mat1').propertyGroup('Voce').func.create('int1', 'Interpolation');
model.material('mat1').propertyGroup.create('HockettSherby', 'Hockett-Sherby');
model.material('mat1').propertyGroup('HockettSherby').func.create('int1', 'Interpolation');
model.material('mat1').propertyGroup.create('ArmstrongFrederick', 'Armstrong-Frederick');
model.material('mat1').propertyGroup('ArmstrongFrederick').func.create('int1', 'Interpolation');
model.material('mat1').propertyGroup.create('Norton', 'Norton');
model.material('mat1').propertyGroup.create('Garofalo', 'Garofalo (hyperbolic sine)');
model.material('mat1').propertyGroup.create('ChabocheViscoplasticity', 'Chaboche viscoplasticity');
model.material('mat1').label('Structural steel');
model.material('mat1').set('family', 'custom');
model.material('mat1').set('customspecular', [0.7843137254901961 0.7843137254901961 0.7843137254901961]);
model.material('mat1').set('customdiffuse', [0.6666666666666666 0.6666666666666666 0.6666666666666666]);
model.material('mat1').set('customambient', [0.6666666666666666 0.6666666666666666 0.6666666666666666]);
model.material('mat1').set('noise', true);
model.material('mat1').set('fresnel', 0.9);
model.material('mat1').set('roughness', 0.3);
model.material('mat1').set('metallic', 0);
model.material('mat1').set('pearl', 0);
model.material('mat1').set('diffusewrap', 0);
model.material('mat1').set('clearcoat', 0);
model.material('mat1').set('reflectance', 0);
model.material('mat1').propertyGroup('def').set('lossfactor', '0.02');
model.material('mat1').propertyGroup('def').set('relpermeability', {'1' '0' '0' '0' '1' '0' '0' '0' '1'});
model.material('mat1').propertyGroup('def').set('heatcapacity', '475[J/(kg*K)]');
model.material('mat1').propertyGroup('def').set('thermalconductivity', {'44.5[W/(m*K)]' '0' '0' '0' '44.5[W/(m*K)]' '0' '0' '0' '44.5[W/(m*K)]'});
model.material('mat1').propertyGroup('def').set('electricconductivity', {'4.032e6[S/m]' '0' '0' '0' '4.032e6[S/m]' '0' '0' '0' '4.032e6[S/m]'});
model.material('mat1').propertyGroup('def').set('relpermittivity', {'1' '0' '0' '0' '1' '0' '0' '0' '1'});
model.material('mat1').propertyGroup('def').set('thermalexpansioncoefficient', {'12.3e-6[1/K]' '0' '0' '0' '12.3e-6[1/K]' '0' '0' '0' '12.3e-6[1/K]'});
model.material('mat1').propertyGroup('def').set('density', '7850[kg/m^3]');
model.material('mat1').propertyGroup('Enu').func('int1').set('funcname', 'E');
model.material('mat1').propertyGroup('Enu').func('int1').set('table', {'293.15' '200e9'; '793.15' '166.6e9'});
model.material('mat1').propertyGroup('Enu').func('int1').set('extrap', 'linear');
model.material('mat1').propertyGroup('Enu').func('int1').set('fununit', {'Pa'});
model.material('mat1').propertyGroup('Enu').func('int1').set('argunit', {'K'});
model.material('mat1').propertyGroup('Enu').func('int2').set('funcname', 'nu');
model.material('mat1').propertyGroup('Enu').func('int2').set('table', {'293.15' '0.30'; '793.15' '0.315'});
model.material('mat1').propertyGroup('Enu').func('int2').set('extrap', 'linear');
model.material('mat1').propertyGroup('Enu').func('int2').set('fununit', {'1'});
model.material('mat1').propertyGroup('Enu').func('int2').set('argunit', {'K'});
model.material('mat1').propertyGroup('Enu').set('E', 'E(T)');
model.material('mat1').propertyGroup('Enu').set('nu', 'nu(T)');
model.material('mat1').propertyGroup('Enu').addInput('temperature');
model.material('mat1').propertyGroup('Murnaghan').set('l', '-3.0e11[Pa]');
model.material('mat1').propertyGroup('Murnaghan').set('m', '-6.2e11[Pa]');
model.material('mat1').propertyGroup('Murnaghan').set('n', '-7.2e11[Pa]');
model.material('mat1').propertyGroup('ElastoplasticModel').func('int1').set('funcname', 'a');
model.material('mat1').propertyGroup('ElastoplasticModel').func('int1').set('table', {'600' '1'; '1100' '0.1'; '1643' '0'});
model.material('mat1').propertyGroup('ElastoplasticModel').func('int1').set('fununit', {'1'});
model.material('mat1').propertyGroup('ElastoplasticModel').func('int1').set('argunit', {'K'});
model.material('mat1').propertyGroup('ElastoplasticModel').set('sigmags', '350[MPa]*a(T)');
model.material('mat1').propertyGroup('ElastoplasticModel').set('Et', '1.045[GPa]*a(T)');
model.material('mat1').propertyGroup('ElastoplasticModel').set('Ek', '1.045[GPa]*a(T)');
model.material('mat1').propertyGroup('ElastoplasticModel').set('sigmagh', '1.050[GPa]*epe*a(T)');
model.material('mat1').propertyGroup('ElastoplasticModel').addInput('temperature');
model.material('mat1').propertyGroup('ElastoplasticModel').addInput('effectiveplasticstrain');
model.material('mat1').propertyGroup('Ludwik').func('int1').set('funcname', 'a');
model.material('mat1').propertyGroup('Ludwik').func('int1').set('table', {'600' '1'; '1100' '0.1'; '1643' '0'});
model.material('mat1').propertyGroup('Ludwik').func('int1').set('fununit', {'1'});
model.material('mat1').propertyGroup('Ludwik').func('int1').set('argunit', {'K'});
model.material('mat1').propertyGroup('Ludwik').set('k_lud', '560[MPa]*a(T)');
model.material('mat1').propertyGroup('Ludwik').set('n_lud', '0.61');
model.material('mat1').propertyGroup('Ludwik').addInput('temperature');
model.material('mat1').propertyGroup('JohnsonCook').set('k_jcook', '560[MPa]');
model.material('mat1').propertyGroup('JohnsonCook').set('n_jcook', '0.61');
model.material('mat1').propertyGroup('JohnsonCook').set('C_jcook', '0.12');
model.material('mat1').propertyGroup('JohnsonCook').set('epet0_jcook', '1[1/s]');
model.material('mat1').propertyGroup('JohnsonCook').set('m_jcook', '0.6');
model.material('mat1').propertyGroup('Swift').set('e0_swi', '0.021');
model.material('mat1').propertyGroup('Swift').set('n_swi', '0.2');
model.material('mat1').propertyGroup('Voce').func('int1').set('funcname', 'a');
model.material('mat1').propertyGroup('Voce').func('int1').set('table', {'600' '1'; '1100' '0.1'; '1643' '0'});
model.material('mat1').propertyGroup('Voce').func('int1').set('fununit', {'1'});
model.material('mat1').propertyGroup('Voce').func('int1').set('argunit', {'K'});
model.material('mat1').propertyGroup('Voce').set('sigma_voc', '249[MPa]*a(T)');
model.material('mat1').propertyGroup('Voce').set('beta_voc', '9.3');
model.material('mat1').propertyGroup('Voce').addInput('temperature');
model.material('mat1').propertyGroup('HockettSherby').func('int1').set('funcname', 'a');
model.material('mat1').propertyGroup('HockettSherby').func('int1').set('table', {'600' '1'; '1100' '0.1'; '1643' '0'});
model.material('mat1').propertyGroup('HockettSherby').func('int1').set('fununit', {'1'});
model.material('mat1').propertyGroup('HockettSherby').func('int1').set('argunit', {'K'});
model.material('mat1').propertyGroup('HockettSherby').set('sigma_hoc', '684[MPa]*a(T)');
model.material('mat1').propertyGroup('HockettSherby').set('m_hoc', '3.9');
model.material('mat1').propertyGroup('HockettSherby').set('n_hoc', '0.85');
model.material('mat1').propertyGroup('HockettSherby').addInput('temperature');
model.material('mat1').propertyGroup('ArmstrongFrederick').func('int1').set('funcname', 'a');
model.material('mat1').propertyGroup('ArmstrongFrederick').func('int1').set('table', {'600' '1'; '1100' '0.1'; '1643' '0'});
model.material('mat1').propertyGroup('ArmstrongFrederick').func('int1').set('fununit', {'1'});
model.material('mat1').propertyGroup('ArmstrongFrederick').func('int1').set('argunit', {'K'});
model.material('mat1').propertyGroup('ArmstrongFrederick').set('Ck', '2.070[GPa]*a(T)');
model.material('mat1').propertyGroup('ArmstrongFrederick').set('gammak', '8.0');
model.material('mat1').propertyGroup('ArmstrongFrederick').addInput('temperature');
model.material('mat1').propertyGroup('Norton').set('A_nor', '1.2e-15[1/s]');
model.material('mat1').propertyGroup('Norton').set('sigRef_nor', '1[MPa]');
model.material('mat1').propertyGroup('Norton').set('n_nor', '4.5');
model.material('mat1').propertyGroup('Garofalo').set('A_gar', '1e-6[1/s]');
model.material('mat1').propertyGroup('Garofalo').set('sigRef_gar', '100[MPa]');
model.material('mat1').propertyGroup('Garofalo').set('n_gar', '4.6');
model.material('mat1').propertyGroup('ChabocheViscoplasticity').set('A_cha', '1');
model.material('mat1').propertyGroup('ChabocheViscoplasticity').set('sigRef_cha', '490[MPa]');
model.material('mat1').propertyGroup('ChabocheViscoplasticity').set('n_cha', '9');

model.physics('solid').create('fix1', 'Fixed', 2);
model.physics('solid').feature('fix1').selection.set([35]);
model.physics('solid').create('bndl1', 'BoundaryLoad', 2);
model.physics('solid').feature('bndl1').selection.set([111]);
model.physics('solid').feature('bndl1').set('LoadType', 'TotalForce');
model.physics('solid').feature('bndl1').set('Ftot', {'0' '0' '-F'});

model.param.set('F', '150[N]');
model.param.descr('F', 'Applied force');
model.param.set('maxD', '2[mm]');
model.param.descr('maxD', 'Maximum displacement');

model.mesh('mesh1').autoMeshSize(3);

model.common('fsd1').selection.set([1]);
model.common.create('fsb1', 'FreeShapeBoundary', 'comp1');
model.common('fsb1').selection.named('geom1_comsel1');
model.common('fsb1').set('maximumDisplacement', 'maxD');

model.study('std1').feature('sho').set('movelimit', 0.2);
model.study('std1').feature('sho').set('mmamaxiter', 20);
model.study('std1').feature('sho').set('keepsolgb', 'everynth');
model.study('std1').feature('sho').set('nskipsols', 21);
model.study('std1').label('Shape Optimization');

model.sol.create('sol1');

model.mesh('mesh1').stat.selection.geom(3);
model.mesh('mesh1').stat.selection.set([1]);

model.sol('sol1').study('std1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'stat');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').feature('comp1_fsb1_d').set('scalemethod', 'manual');
model.sol('sol1').feature('v1').feature('comp1_material_disp').set('scalemethod', 'manual');
model.sol('sol1').feature('v1').feature('comp1_fsb1_d').set('scaleval', 'maxD');
model.sol('sol1').feature('v1').feature('comp1_material_disp').set('scaleval', '1.4937580744055649E-4');
model.sol('sol1').feature('v1').set('control', 'stat');
model.sol('sol1').create('o1', 'Optimization');
model.sol('sol1').feature('o1').set('control', 'sho');
model.sol('sol1').feature('o1').create('s1', 'StationaryAttrib');
model.sol('sol1').feature('o1').feature('s1').set('control', 'stat');
model.sol('sol1').feature('o1').feature('s1').feature('aDef').set('cachepattern', true);
model.sol('sol1').feature('o1').feature('s1').create('se1', 'Segregated');
model.sol('sol1').feature('o1').feature('s1').feature('se1').feature.remove('ssDef');
model.sol('sol1').feature('o1').feature('s1').feature('se1').create('ss1', 'SegregatedStep');
model.sol('sol1').feature('o1').feature('s1').feature('se1').feature('ss1').set('segvar', {'comp1_fsb1_c' 'comp1_material_disp' 'comp1_fsb1_d'});
model.sol('sol1').feature('o1').feature('s1').create('i1', 'Iterative');
model.sol('sol1').feature('o1').feature('s1').feature('i1').set('linsolver', 'gmres');
model.sol('sol1').feature('o1').feature('s1').feature('i1').label('Suggested Iterative Solver (GMRES with AMG) (opt)');
model.sol('sol1').feature('o1').feature('s1').feature('i1').create('mg1', 'Multigrid');
model.sol('sol1').feature('o1').feature('s1').feature('i1').feature('mg1').set('prefun', 'amg');
model.sol('sol1').feature('o1').feature('s1').feature('se1').feature('ss1').set('linsolver', 'i1');
model.sol('sol1').feature('o1').feature('s1').feature('se1').feature('ss1').label('Optimization');
model.sol('sol1').feature('o1').feature('s1').feature('se1').create('ss2', 'SegregatedStep');
model.sol('sol1').feature('o1').feature('s1').feature('se1').feature('ss2').set('segvar', {'comp1_u' 'comp1_fsb1_c'});
model.sol('sol1').feature('o1').feature('s1').create('d1', 'Direct');
model.sol('sol1').feature('o1').feature('s1').feature('d1').set('linsolver', 'pardiso');
model.sol('sol1').feature('o1').feature('s1').feature('d1').set('pivotperturb', 1.0E-9);
model.sol('sol1').feature('o1').feature('s1').feature('d1').label('Suggested Direct Solver (solid)');
model.sol('sol1').feature('o1').feature('s1').feature('se1').feature('ss2').set('linsolver', 'd1');
model.sol('sol1').feature('o1').feature('s1').feature('se1').feature('ss2').label('Solid Mechanics');
model.sol('sol1').feature('o1').feature('s1').create('i2', 'Iterative');
model.sol('sol1').feature('o1').feature('s1').feature('i2').set('linsolver', 'gmres');
model.sol('sol1').feature('o1').feature('s1').feature('i2').set('rhob', 400);
model.sol('sol1').feature('o1').feature('s1').feature('i2').set('nlinnormuse', true);
model.sol('sol1').feature('o1').feature('s1').feature('i2').label('Suggested Iterative Solver (solid)');
model.sol('sol1').feature('o1').feature('s1').feature('i2').create('mg1', 'Multigrid');
model.sol('sol1').feature('o1').feature('s1').feature('i2').feature('mg1').set('prefun', 'gmg');
model.sol('sol1').feature('o1').feature('s1').feature('i2').feature('mg1').feature('pr').create('so1', 'SOR');
model.sol('sol1').feature('o1').feature('s1').feature('i2').feature('mg1').feature('pr').feature('so1').set('relax', 0.8);
model.sol('sol1').feature('o1').feature('s1').feature('i2').feature('mg1').feature('po').create('so1', 'SOR');
model.sol('sol1').feature('o1').feature('s1').feature('i2').feature('mg1').feature('po').feature('so1').set('relax', 0.8);
model.sol('sol1').feature('o1').feature('s1').feature('i2').feature('mg1').feature('cs').create('d1', 'Direct');
model.sol('sol1').feature('o1').feature('s1').feature('i2').feature('mg1').feature('cs').feature('d1').set('linsolver', 'pardiso');
model.sol('sol1').feature('o1').feature('s1').feature('i2').feature('mg1').feature('cs').feature('d1').set('pivotperturb', 1.0E-9);
model.sol('sol1').feature('o1').feature('s1').feature.remove('fcDef');
model.sol('sol1').attach('std1');
model.sol('sol1').runFromTo('st1', 'v1');

model.result.create('pg1', 'PlotGroup3D');
model.result('pg1').set('data', 'dset1');
model.result('pg1').set('defaultPlotID', 'stress');
model.result('pg1').label('Stress (solid)');
model.result('pg1').set('frametype', 'spatial');
model.result('pg1').create('vol1', 'Volume');
model.result('pg1').feature('vol1').set('expr', {'solid.misesGp'});
model.result('pg1').feature('vol1').set('threshold', 'manual');
model.result('pg1').feature('vol1').set('thresholdvalue', 0.2);
model.result('pg1').feature('vol1').set('colortable', 'Rainbow');
model.result('pg1').feature('vol1').set('colortabletrans', 'none');
model.result('pg1').feature('vol1').set('colorscalemode', 'linear');
model.result('pg1').feature('vol1').set('resolution', 'custom');
model.result('pg1').feature('vol1').set('refine', 2);
model.result('pg1').feature('vol1').set('colortable', 'Prism');
model.result('pg1').feature('vol1').create('def', 'Deform');
model.result('pg1').feature('vol1').feature('def').set('expr', {'u' 'v' 'w'});
model.result('pg1').feature('vol1').feature('def').set('descr', 'Displacement field');
model.result.create('pg2', 'PlotGroup3D');
model.result.dataset.duplicate('dset1g1', 'dset1');
model.result.dataset('dset1g1').label('Shape Optimization/Solution 1 (1) - Geometry');
model.result.dataset('dset1g1').set('frametype', 'geometry');
model.result('pg2').label('Shape Optimization');
model.result('pg2').set('data', 'dset1');
model.result('pg2').set('frametype', 'geometry');
model.result('pg2').set('edgecolor', 'gray');
model.result('pg2').set('titletype', 'none');
model.result('pg2').create('line1', 'Line');
model.result('pg2').feature('line1').set('expr', '1');
model.result('pg2').feature('line1').set('coloring', 'uniform');
model.result('pg2').feature('line1').set('color', 'fromtheme');
model.result('pg2').create('con1', 'Surface');
model.result('pg2').feature('con1').set('expr', 'fsd1.rel_disp');
model.result('pg2').feature('con1').set('colortabletype', 'discrete');
model.result('pg2').feature('con1').set('bandcount', 20);
model.result('pg2').feature('con1').set('rangecoloractive', true);
model.result('pg2').feature('con1').set('rangecolormin', 0);
model.result('pg2').feature('con1').set('rangecolormax', 1);
model.result('pg2').feature('con1').set('colortable', 'RainbowLight');
model.result('pg2').feature('con1').set('smooth', 'none');
model.result('pg2').create('arws1', 'ArrowSurface');
model.result('pg2').feature('arws1').set('data', 'dset1g1');
model.result('pg2').feature('arws1').set('expr', {'fsd1.dXg' 'fsd1.dYg' 'fsd1.dZg'});
model.result('pg2').feature('arws1').set('scaleactive', true);
model.result('pg2').feature('arws1').set('scale', '1');
model.result('pg2').feature('arws1').set('placement', 'uniform');
model.result('pg2').feature('arws1').set('arrowcount', 200);
model.result('pg2').feature('arws1').create('sel1', 'Selection');
model.result('pg2').feature('arws1').feature('sel1').selection.named('dsel_fsd1');
model.result('pg1').run;

model.study('std1').feature('sho').set('plot', true);
model.study('std1').feature('sho').set('plotgroup', 'pg2');

model.mesh('mesh1').stat.selection.geom(3);
model.mesh('mesh1').stat.selection.set([1]);

model.sol('sol1').study('std1');
model.sol('sol1').feature.remove('o1');
model.sol('sol1').feature.remove('v1');
model.sol('sol1').feature.remove('st1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'stat');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').feature('comp1_fsb1_d').set('scalemethod', 'manual');
model.sol('sol1').feature('v1').feature('comp1_material_disp').set('scalemethod', 'manual');
model.sol('sol1').feature('v1').feature('comp1_fsb1_d').set('scaleval', 'maxD');
model.sol('sol1').feature('v1').feature('comp1_material_disp').set('scaleval', '1.4937580744055649E-4');
model.sol('sol1').feature('v1').set('control', 'stat');
model.sol('sol1').create('o1', 'Optimization');
model.sol('sol1').feature('o1').set('control', 'sho');
model.sol('sol1').feature('o1').create('s1', 'StationaryAttrib');
model.sol('sol1').feature('o1').feature('s1').set('control', 'stat');
model.sol('sol1').feature('o1').feature('s1').feature('aDef').set('cachepattern', true);
model.sol('sol1').feature('o1').feature('s1').create('se1', 'Segregated');
model.sol('sol1').feature('o1').feature('s1').feature('se1').feature.remove('ssDef');
model.sol('sol1').feature('o1').feature('s1').feature('se1').create('ss1', 'SegregatedStep');
model.sol('sol1').feature('o1').feature('s1').feature('se1').feature('ss1').set('segvar', {'comp1_fsb1_c' 'comp1_material_disp' 'comp1_fsb1_d'});
model.sol('sol1').feature('o1').feature('s1').create('i1', 'Iterative');
model.sol('sol1').feature('o1').feature('s1').feature('i1').set('linsolver', 'gmres');
model.sol('sol1').feature('o1').feature('s1').feature('i1').label('Suggested Iterative Solver (GMRES with AMG) (opt)');
model.sol('sol1').feature('o1').feature('s1').feature('i1').create('mg1', 'Multigrid');
model.sol('sol1').feature('o1').feature('s1').feature('i1').feature('mg1').set('prefun', 'amg');
model.sol('sol1').feature('o1').feature('s1').feature('se1').feature('ss1').set('linsolver', 'i1');
model.sol('sol1').feature('o1').feature('s1').feature('se1').feature('ss1').label('Optimization');
model.sol('sol1').feature('o1').feature('s1').feature('se1').create('ss2', 'SegregatedStep');
model.sol('sol1').feature('o1').feature('s1').feature('se1').feature('ss2').set('segvar', {'comp1_u' 'comp1_fsb1_c'});
model.sol('sol1').feature('o1').feature('s1').create('d1', 'Direct');
model.sol('sol1').feature('o1').feature('s1').feature('d1').set('linsolver', 'pardiso');
model.sol('sol1').feature('o1').feature('s1').feature('d1').set('pivotperturb', 1.0E-9);
model.sol('sol1').feature('o1').feature('s1').feature('d1').label('Suggested Direct Solver (solid)');
model.sol('sol1').feature('o1').feature('s1').feature('se1').feature('ss2').set('linsolver', 'd1');
model.sol('sol1').feature('o1').feature('s1').feature('se1').feature('ss2').label('Solid Mechanics');
model.sol('sol1').feature('o1').feature('s1').create('i2', 'Iterative');
model.sol('sol1').feature('o1').feature('s1').feature('i2').set('linsolver', 'gmres');
model.sol('sol1').feature('o1').feature('s1').feature('i2').set('rhob', 400);
model.sol('sol1').feature('o1').feature('s1').feature('i2').set('nlinnormuse', true);
model.sol('sol1').feature('o1').feature('s1').feature('i2').label('Suggested Iterative Solver (solid)');
model.sol('sol1').feature('o1').feature('s1').feature('i2').create('mg1', 'Multigrid');
model.sol('sol1').feature('o1').feature('s1').feature('i2').feature('mg1').set('prefun', 'gmg');
model.sol('sol1').feature('o1').feature('s1').feature('i2').feature('mg1').feature('pr').create('so1', 'SOR');
model.sol('sol1').feature('o1').feature('s1').feature('i2').feature('mg1').feature('pr').feature('so1').set('relax', 0.8);
model.sol('sol1').feature('o1').feature('s1').feature('i2').feature('mg1').feature('po').create('so1', 'SOR');
model.sol('sol1').feature('o1').feature('s1').feature('i2').feature('mg1').feature('po').feature('so1').set('relax', 0.8);
model.sol('sol1').feature('o1').feature('s1').feature('i2').feature('mg1').feature('cs').create('d1', 'Direct');
model.sol('sol1').feature('o1').feature('s1').feature('i2').feature('mg1').feature('cs').feature('d1').set('linsolver', 'pardiso');
model.sol('sol1').feature('o1').feature('s1').feature('i2').feature('mg1').feature('cs').feature('d1').set('pivotperturb', 1.0E-9);
model.sol('sol1').feature('o1').feature('s1').feature.remove('fcDef');
model.sol('sol1').attach('std1');
model.sol('sol1').runAll;

model.result('pg1').run;

model.study('std1').feature('sho').set('probewindow', '');

model.result('pg2').run;
model.result('pg2').run;
model.result.export.create('mesh1', 'dset1', 'Mesh');
model.result.export('mesh1').set('type3D', 'stlbin');
model.result.export('mesh1').set('filename', 'wrench_shape_optimization.stl');
model.result.create('pg3', 'PlotGroup3D');
model.result('pg3').run;
model.result('pg3').set('titletype', 'label');
model.result('pg3').label('Volumetric');
model.result('pg3').create('vol1', 'Volume');
model.result('pg3').feature('vol1').label('Optimized Design');
model.result('pg3').feature('vol1').set('coloring', 'uniform');
model.result('pg3').feature.duplicate('vol2', 'vol1');
model.result('pg3').run;
model.result('pg3').feature('vol2').label('Initial Design');
model.result('pg3').feature('vol2').set('data', 'dset1');
model.result('pg3').feature('vol2').setIndex('looplevel', 1, 0);
model.result('pg3').feature('vol2').set('color', 'gray');
model.result('pg3').run;
model.result('pg3').create('line1', 'Line');
model.result('pg3').feature('line1').set('data', 'dset1');
model.result('pg3').feature('line1').setIndex('looplevel', 1, 0);
model.result('pg3').feature('line1').set('expr', '1');
model.result('pg3').feature('line1').set('coloring', 'uniform');
model.result('pg3').feature('line1').set('color', 'fromtheme');

model.view('view1').set('transparency', true);

model.result('pg3').run;
model.result('pg1').run;
model.result('pg1').label('Stress - Optimized Design');

model.title('Shape Optimization of a Wrench');

model.description('This model shows how to use the Free Shape Boundary feature to increase the stiffness of a wrench without increasing its mass.');

model.mesh.clearMeshes;

model.sol('sol1').clearSolutionData;

model.label('wrench_shape_optimization.mph');

model.modelNode.label('Components');

out = model;
