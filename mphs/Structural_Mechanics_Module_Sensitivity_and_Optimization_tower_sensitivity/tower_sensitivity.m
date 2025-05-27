function out = model
%
% tower_sensitivity.m
%
% Model exported on May 26 2025, 21:33 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/Structural_Mechanics_Module/Sensitivity_and_Optimization');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 3);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.physics.create('truss', 'Truss', 'geom1');
model.physics('truss').model('comp1');

model.study.create('std1');
model.study('std1').create('stat', 'Stationary');
model.study('std1').feature('stat').setSolveFor('/physics/truss', true);

model.geom('geom1').insertFile('tower_sensitivity_geom_sequence.mph', 'geom1');
model.geom('geom1').run('fin');

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

model.coordSystem.create('sys2', 'geom1', 'Cylindrical');
model.coordSystem('sys2').setIndex('origin', 'Lx/2', 0);
model.coordSystem('sys2').setIndex('origin', 'Ly/2', 1);

model.common.create('cvf1', 'ControlVariableField', 'comp1');
model.common('cvf1').set('name', 'Abar');
model.common('cvf1').selection.geom('geom1', 1);
model.common('cvf1').selection.all;
model.common('cvf1').set('shapeFunctionType', 'shdisc');
model.common('cvf1').set('order', '0');
model.common('cvf1').set('initialValue', '1');
model.common('cvf1').set('useBounds', false);

model.param.set('d1', '1[cm]');
model.param.descr('d1', 'Vertical bar diameter');
model.param.set('d2', '5[mm]');
model.param.descr('d2', 'Diagonal and horizontal bar diameter');

model.physics('truss').selection.named('geom1_boxsel5');
model.physics('truss').feature('csd1').set('area', 'pi/4*d1^2*Abar');
model.physics('truss').create('csd2', 'CrossSectionTruss', 1);
model.physics('truss').feature('csd2').selection.named('geom1_unisel1');
model.physics('truss').feature('csd2').set('area', 'pi/4*d2^2*Abar');
model.physics('truss').create('pin1', 'Pinned', 0);
model.physics('truss').feature('pin1').selection.named('geom1_boxsel1');
model.physics('truss').create('pl1', 'PointLoad', 0);
model.physics('truss').feature('pl1').selection.named('geom1_boxsel2');
model.physics('truss').feature('pl1').set('Fp', {'1[kN]' '0' '0'});

model.group.create('lg1', 'LoadGroup');

model.physics('truss').feature('pl1').set('loadGroup', 'lg1');
model.physics('truss').create('pl2', 'PointLoad', 0);
model.physics('truss').feature('pl2').selection.named('geom1_boxsel2');
model.physics('truss').feature('pl2').set('coordinateSystem', 'sys2');
model.physics('truss').feature('pl2').set('Fp', {'0' '1[kN]' '0'});

model.group.create('lg2', 'LoadGroup');

model.physics('truss').feature('pl2').set('loadGroup', 'lg2');
model.physics('truss').create('avgr1', 'AverageRotation', -1);
model.physics('truss').feature('avgr1').selection('PointSelection').named('geom1_boxsel2');

model.group('lg1').label('Load Group: Bending');
model.group('lg1').paramName('lgB');
model.group('lg2').label('Load Group: Torsion');
model.group('lg2').paramName('lgT');

model.study('std1').label('Tilt Sensitivity');
model.study('std1').setGenPlots(false);
model.study('std1').create('sens', 'Sensitivity');
model.study('std1').feature('sens').setIndex('optobj', 'comp1.truss.avgr1.thY', 0);
model.study('std1').feature('sens').setIndex('descr', 'Tilt angle', 0);
model.study('std1').feature('stat').set('useloadcase', true);
model.study('std1').feature('stat').setIndex('loadcase', 'Load case 1', 0);
model.study('std1').feature('stat').setIndex('loadgroup', false, 0, 0);
model.study('std1').feature('stat').setIndex('loadgroupweight', '1.0', 0, 0);
model.study('std1').feature('stat').setIndex('loadgroup', false, 0, 1);
model.study('std1').feature('stat').setIndex('loadgroupweight', '1.0', 0, 1);
model.study('std1').feature('stat').setIndex('loadcase', 'Load case 1', 0);
model.study('std1').feature('stat').setIndex('loadgroup', false, 0, 0);
model.study('std1').feature('stat').setIndex('loadgroupweight', '1.0', 0, 0);
model.study('std1').feature('stat').setIndex('loadgroup', false, 0, 1);
model.study('std1').feature('stat').setIndex('loadgroupweight', '1.0', 0, 1);
model.study('std1').feature('stat').setIndex('loadcase', 'Load case 2', 1);
model.study('std1').feature('stat').setIndex('loadgroup', false, 1, 0);
model.study('std1').feature('stat').setIndex('loadgroupweight', '1.0', 1, 0);
model.study('std1').feature('stat').setIndex('loadgroup', false, 1, 1);
model.study('std1').feature('stat').setIndex('loadgroupweight', '1.0', 1, 1);
model.study('std1').feature('stat').setIndex('loadcase', 'Load case 2', 1);
model.study('std1').feature('stat').setIndex('loadgroup', false, 1, 0);
model.study('std1').feature('stat').setIndex('loadgroupweight', '1.0', 1, 0);
model.study('std1').feature('stat').setIndex('loadgroup', false, 1, 1);
model.study('std1').feature('stat').setIndex('loadgroupweight', '1.0', 1, 1);
model.study('std1').feature('stat').setIndex('loadcase', 'Bending', 0);
model.study('std1').feature('stat').setIndex('loadgroup', true, 0, 0);
model.study('std1').feature('stat').setIndex('loadcase', 'Torsion', 1);
model.study('std1').feature('stat').setIndex('loadgroup', true, 1, 1);

model.sol.create('sol1');
model.sol('sol1').study('std1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'stat');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').set('control', 'stat');
model.sol('sol1').create('s1', 'Stationary');
model.sol('sol1').feature('s1').create('p1', 'Parametric');
model.sol('sol1').feature('s1').feature.remove('pDef');
model.sol('sol1').feature('s1').feature('p1').set('control', 'stat');
model.sol('sol1').feature('s1').set('control', 'stat');
model.sol('sol1').feature('s1').create('sn1', 'Sensitivity');
model.sol('sol1').feature('s1').feature('sn1').set('control', 'sens');
model.sol('sol1').feature('s1').feature('aDef').set('cachepattern', true);
model.sol('sol1').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('s1').feature('fc1').set('linsolver', 'dDef');
model.sol('sol1').feature('s1').feature.remove('fcDef');
model.sol('sol1').attach('std1');
model.sol('sol1').runAll;

model.result.numerical.create('gev1', 'EvalGlobal');
model.result.numerical('gev1').setIndex('expr', 'truss.avgr1.thY', 0);
model.result.numerical('gev1').setIndex('unit', 'deg', 0);
model.result.numerical('gev1').setIndex('descr', 'Tilt angle', 0);
model.result.numerical('gev1').setIndex('expr', 'truss.avgr1.thZ', 1);
model.result.numerical('gev1').setIndex('unit', 'deg', 1);
model.result.numerical('gev1').setIndex('descr', 'Yaw angle', 1);
model.result.table.create('tbl1', 'Table');
model.result.table('tbl1').comments('Global Evaluation 1');
model.result.numerical('gev1').set('table', 'tbl1');
model.result.numerical('gev1').setResult;
model.result.create('pg1', 'PlotGroup3D');
model.result('pg1').run;
model.result('pg1').label('Tilt Sensitivity');
model.result('pg1').set('titletype', 'none');
model.result('pg1').set('edges', false);
model.result('pg1').create('line1', 'Line');
model.result('pg1').feature('line1').set('expr', 'fsens(Abar)');
model.result('pg1').feature('line1').set('linetype', 'tube');
model.result('pg1').feature('line1').set('colorscalemode', 'linearsymmetric');
model.result('pg1').feature('line1').set('smooth', 'internal');
model.result('pg1').feature('line1').create('def1', 'Deform');
model.result('pg1').run;
model.result('pg1').run;
model.result('pg1').feature.duplicate('line2', 'line1');
model.result('pg1').run;
model.result('pg1').feature('line2').set('data', 'dset1');
model.result('pg1').feature('line2').setIndex('looplevel', 1, 0);
model.result('pg1').feature('line2').set('colortable', 'Cividis');
model.result('pg1').feature('line2').create('trn1', 'Translation');
model.result('pg1').run;
model.result('pg1').feature('line2').feature('trn1').set('trans', [-4 0 0]);
model.result('pg1').run;
model.result('pg1').create('arpt1', 'ArrowPoint');
model.result('pg1').feature('arpt1').set('expr', {'truss.F_Px' 'truss.F_Py' 'truss.F_Pz'});
model.result('pg1').feature('arpt1').set('descr', 'Load');
model.result('pg1').feature('arpt1').create('def1', 'Deform');
model.result('pg1').run;
model.result('pg1').run;
model.result('pg1').feature('arpt1').set('inheritplot', 'line1');
model.result('pg1').feature('arpt1').set('inheritarrowscale', false);
model.result('pg1').feature('arpt1').set('inheritcolor', false);
model.result('pg1').feature('arpt1').set('inheritrange', false);
model.result('pg1').feature.duplicate('arpt2', 'arpt1');
model.result('pg1').run;
model.result('pg1').feature('arpt2').set('data', 'dset1');
model.result('pg1').feature('arpt2').setIndex('looplevel', 1, 0);
model.result('pg1').feature('arpt2').set('inheritplot', 'line2');
model.result('pg1').feature('arpt2').create('trn1', 'Translation');
model.result('pg1').run;
model.result('pg1').feature('arpt2').feature('trn1').set('trans', [-4 0 0]);
model.result('pg1').run;
model.result('pg1').set('legendpos', 'alternating');

model.view('view1').set('showaxisorientation', false);

model.result('pg1').run;

model.study.create('std2');
model.study('std2').create('stat', 'Stationary');
model.study('std2').feature('stat').setSolveFor('/physics/truss', true);
model.study('std2').feature('stat').set('useloadcase', true);
model.study('std2').feature('stat').setIndex('loadcase', 'Load case 1', 0);
model.study('std2').feature('stat').setIndex('loadgroup', false, 0, 0);
model.study('std2').feature('stat').setIndex('loadgroupweight', '1.0', 0, 0);
model.study('std2').feature('stat').setIndex('loadgroup', false, 0, 1);
model.study('std2').feature('stat').setIndex('loadgroupweight', '1.0', 0, 1);
model.study('std2').feature('stat').setIndex('loadcase', 'Load case 1', 0);
model.study('std2').feature('stat').setIndex('loadgroup', false, 0, 0);
model.study('std2').feature('stat').setIndex('loadgroupweight', '1.0', 0, 0);
model.study('std2').feature('stat').setIndex('loadgroup', false, 0, 1);
model.study('std2').feature('stat').setIndex('loadgroupweight', '1.0', 0, 1);
model.study('std2').feature('stat').setIndex('loadcase', 'Load case 2', 1);
model.study('std2').feature('stat').setIndex('loadgroup', false, 1, 0);
model.study('std2').feature('stat').setIndex('loadgroupweight', '1.0', 1, 0);
model.study('std2').feature('stat').setIndex('loadgroup', false, 1, 1);
model.study('std2').feature('stat').setIndex('loadgroupweight', '1.0', 1, 1);
model.study('std2').feature('stat').setIndex('loadcase', 'Load case 2', 1);
model.study('std2').feature('stat').setIndex('loadgroup', false, 1, 0);
model.study('std2').feature('stat').setIndex('loadgroupweight', '1.0', 1, 0);
model.study('std2').feature('stat').setIndex('loadgroup', false, 1, 1);
model.study('std2').feature('stat').setIndex('loadgroupweight', '1.0', 1, 1);
model.study('std2').feature('stat').setIndex('loadcase', 'Bending', 0);
model.study('std2').feature('stat').setIndex('loadgroup', true, 0, 0);
model.study('std2').feature('stat').setIndex('loadcase', 'Torsion', 1);
model.study('std2').feature('stat').setIndex('loadgroup', true, 1, 1);
model.study('std2').label('Yaw Sensitivity');
model.study('std2').setGenPlots(false);
model.study('std2').create('sens', 'Sensitivity');
model.study('std2').feature('sens').setIndex('optobj', 'comp1.truss.avgr1.thZ', 0);
model.study('std2').feature('sens').setIndex('descr', 'Yaw angle', 0);

model.sol.create('sol2');
model.sol('sol2').study('std2');
model.sol('sol2').create('st1', 'StudyStep');
model.sol('sol2').feature('st1').set('study', 'std2');
model.sol('sol2').feature('st1').set('studystep', 'stat');
model.sol('sol2').create('v1', 'Variables');
model.sol('sol2').feature('v1').set('control', 'stat');
model.sol('sol2').create('s1', 'Stationary');
model.sol('sol2').feature('s1').create('p1', 'Parametric');
model.sol('sol2').feature('s1').feature.remove('pDef');
model.sol('sol2').feature('s1').feature('p1').set('control', 'stat');
model.sol('sol2').feature('s1').set('control', 'stat');
model.sol('sol2').feature('s1').create('sn1', 'Sensitivity');
model.sol('sol2').feature('s1').feature('sn1').set('control', 'sens');
model.sol('sol2').feature('s1').feature('aDef').set('cachepattern', true);
model.sol('sol2').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol2').feature('s1').feature('fc1').set('linsolver', 'dDef');
model.sol('sol2').feature('s1').feature.remove('fcDef');
model.sol('sol2').attach('std2');
model.sol('sol2').runAll;

model.result('pg1').run;
model.result.duplicate('pg2', 'pg1');
model.result('pg2').run;
model.result('pg2').set('data', 'dset2');
model.result('pg2').label('Yaw Sensitivity');
model.result('pg2').run;
model.result('pg2').feature('arpt2').set('data', 'dset2');
model.result('pg2').run;
model.result('pg2').feature('line2').set('data', 'dset2');
model.result('pg2').run;
model.result('pg2').run;

model.title('Sensitivity Analysis of a Truss Tower');

model.description('Sensitivity analysis is an efficient way of computing the gradient of an objective function with respect to many control variables. This example uses the pitch and yaw in the top of a truss tower as objective functions. The sensitivity of these angles with respect to changes in the diameters of the individual bars are computed.');

model.mesh.clearMeshes;

model.sol('sol1').clearSolutionData;
model.sol('sol2').clearSolutionData;

model.label('tower_sensitivity.mph');

model.modelNode.label('Components');

out = model;
