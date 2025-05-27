function out = model
%
% mast_diagonal_mounting_sensitivity.m
%
% Model exported on May 26 2025, 21:27 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/COMSOL_Multiphysics/Structural_Mechanics');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 3);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.physics.create('solid', 'SolidMechanics', 'geom1');
model.physics('solid').model('comp1');

model.study.create('std1');
model.study('std1').create('stat', 'Stationary');
model.study('std1').feature('stat').setSolveFor('/physics/solid', true);

model.geom('geom1').insertFile('mast_diagonal_mounting_geom_sequence.mph', 'geom1');
model.geom('geom1').run('fin');

model.view('view1').set('renderwireframe', true);

model.param.set('F', '30[kN]');
model.param.descr('F', 'Applied force');

model.cpl.create('aveop1', 'Average', 'geom1');
model.cpl('aveop1').set('axisym', true);
model.cpl('aveop1').label('Mount, mid level');
model.cpl('aveop1').selection.geom('geom1', 0);
model.cpl('aveop1').selection.set([9 13 18 22 55 59 64 68]);

model.selection.create('sel1', 'Explicit');
model.selection('sel1').model('comp1');
model.selection('sel1').geom(0);
model.selection('sel1').label('Mount, mid level');
model.selection('sel1').set([9 13 18 22 55 59 64 68]);

model.cpl('aveop1').selection.named('sel1');

model.variable.create('var1');
model.variable('var1').model('comp1');
model.variable('var1').set('p', '-(3/2)*F/(2*Axy_mh)*(1-(Y/r_mh)^2)');
model.variable('var1').descr('p', 'Mount hole stress');
model.variable('var1').set('fy_mh', 'p*nY');
model.variable('var1').descr('fy_mh', 'Mount hole force, y-component');
model.variable('var1').set('fz_mh', 'p*nZ');
model.variable('var1').descr('fz_mh', 'Mount hole force, z-component');
model.variable('var1').set('d_mh', 'aveop1(w)');
model.variable('var1').descr('d_mh', 'Mount hole displacement');
model.variable('var1').set('L_t', 'h_t+t_p+o_mh');
model.variable('var1').descr('L_t', 'Equivalent tube length');
model.variable('var1').set('Axy_mh', '2*r_mh*t_m');
model.variable('var1').descr('Axy_mh', 'Mount hole xy projected area');
model.variable('var1').set('A_t', 'pi*(r_t^2-(r_t-t_t)^2)');
model.variable('var1').descr('A_t', 'Tube cross section area');
model.variable('var1').set('S', 'F/d_mh');
model.variable('var1').descr('S', 'Stiffness of the assembly');
model.variable('var1').set('S_i', '200e9[Pa]*A_t/L_t');
model.variable('var1').descr('S_i', 'Ideal stiffness');
model.variable('var1').set('S_R', 'S/S_i');
model.variable('var1').descr('S_R', 'Stiffness ratio');

model.material.create('mat1', 'Common', 'comp1');
model.material('mat1').propertyGroup.create('Enu', 'Young''s modulus and Poisson''s ratio');
model.material('mat1').propertyGroup('Enu').func.create('an1', 'Analytic');
model.material('mat1').propertyGroup('Enu').func.create('an2', 'Analytic');
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
model.material('mat1').propertyGroup('Enu').func('an1').set('funcname', 'E');
model.material('mat1').propertyGroup('Enu').func('an1').set('expr', '200[GPa]*(1 - 3.34e-4[1/K]*(T - 293.15[K]))');
model.material('mat1').propertyGroup('Enu').func('an1').set('args', {'T'});
model.material('mat1').propertyGroup('Enu').func('an1').set('fununit', 'Pa');
model.material('mat1').propertyGroup('Enu').func('an1').set('argunit', {'K'});
model.material('mat1').propertyGroup('Enu').func('an1').set('plotargs', {'T' '0' '1500'});
model.material('mat1').propertyGroup('Enu').func('an2').set('funcname', 'nu');
model.material('mat1').propertyGroup('Enu').func('an2').set('expr', '0.3*(1 + 1e-4[1/K]*(T - 293.15[K]))');
model.material('mat1').propertyGroup('Enu').func('an2').set('args', {'T'});
model.material('mat1').propertyGroup('Enu').func('an2').set('fununit', '1');
model.material('mat1').propertyGroup('Enu').func('an2').set('argunit', {'K'});
model.material('mat1').propertyGroup('Enu').func('an2').set('plotargs', {'T' '0' '1500'});
model.material('mat1').propertyGroup('Enu').set('E', 'E(T)');
model.material('mat1').propertyGroup('Enu').set('nu', 'nu(T)');
model.material('mat1').propertyGroup('Enu').addInput('temperature');
model.material('mat1').propertyGroup('Murnaghan').set('l', '-3.0e11[Pa]');
model.material('mat1').propertyGroup('Murnaghan').set('m', '-6.2e11[Pa]');
model.material('mat1').propertyGroup('Murnaghan').set('n', '-7.2e11[Pa]');
model.material('mat1').propertyGroup('ElastoplasticModel').func('int1').set('funcname', 'a');
model.material('mat1').propertyGroup('ElastoplasticModel').func('int1').set('table', {'600[K]' '1'; '1100[K]' '0.1'; '1643[K]' '0'});
model.material('mat1').propertyGroup('ElastoplasticModel').func('int1').set('fununit', {'1'});
model.material('mat1').propertyGroup('ElastoplasticModel').func('int1').set('argunit', {'K'});
model.material('mat1').propertyGroup('ElastoplasticModel').set('sigmags', '350[MPa]*a(T)');
model.material('mat1').propertyGroup('ElastoplasticModel').set('Et', '1.045[GPa]*a(T)');
model.material('mat1').propertyGroup('ElastoplasticModel').set('Ek', '1.045[GPa]*a(T)');
model.material('mat1').propertyGroup('ElastoplasticModel').set('sigmagh', '1.050[GPa]*epe*a(T)');
model.material('mat1').propertyGroup('ElastoplasticModel').addInput('temperature');
model.material('mat1').propertyGroup('ElastoplasticModel').addInput('effectiveplasticstrain');
model.material('mat1').propertyGroup('Ludwik').func('int1').set('funcname', 'a');
model.material('mat1').propertyGroup('Ludwik').func('int1').set('table', {'600[K]' '1'; '1100[K]' '0.1'; '1643[K]' '0'});
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
model.material('mat1').propertyGroup('Voce').func('int1').set('table', {'600[K]' '1'; '1100[K]' '0.1'; '1643[K]' '0'});
model.material('mat1').propertyGroup('Voce').func('int1').set('fununit', {'1'});
model.material('mat1').propertyGroup('Voce').func('int1').set('argunit', {'K'});
model.material('mat1').propertyGroup('Voce').set('sigma_voc', '249[MPa]*a(T)');
model.material('mat1').propertyGroup('Voce').set('beta_voc', '9.3');
model.material('mat1').propertyGroup('Voce').addInput('temperature');
model.material('mat1').propertyGroup('HockettSherby').func('int1').set('funcname', 'a');
model.material('mat1').propertyGroup('HockettSherby').func('int1').set('table', {'600[K]' '1'; '1100[K]' '0.1'; '1643[K]' '0'});
model.material('mat1').propertyGroup('HockettSherby').func('int1').set('fununit', {'1'});
model.material('mat1').propertyGroup('HockettSherby').func('int1').set('argunit', {'K'});
model.material('mat1').propertyGroup('HockettSherby').set('sigma_hoc', '684[MPa]*a(T)');
model.material('mat1').propertyGroup('HockettSherby').set('m_hoc', '3.9');
model.material('mat1').propertyGroup('HockettSherby').set('n_hoc', '0.85');
model.material('mat1').propertyGroup('HockettSherby').addInput('temperature');
model.material('mat1').propertyGroup('ArmstrongFrederick').func('int1').set('funcname', 'a');
model.material('mat1').propertyGroup('ArmstrongFrederick').func('int1').set('table', {'600[K]' '1'; '1100[K]' '0.1'; '1643[K]' '0'});
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
model.material('mat1').set('family', 'custom');
model.material('mat1').set('lighting', 'cooktorrance');
model.material('mat1').set('fresnel', 0.9);
model.material('mat1').set('roughness', 0.3);
model.material('mat1').set('anisotropy', 0);
model.material('mat1').set('flipanisotropy', false);
model.material('mat1').set('metallic', 0);
model.material('mat1').set('pearl', 0);
model.material('mat1').set('diffusewrap', 0);
model.material('mat1').set('clearcoat', 0);
model.material('mat1').set('reflectance', 0);
model.material('mat1').set('ambient', 'custom');
model.material('mat1').set('customambient', [0.6666666666666666 0.6666666666666666 0.6666666666666666]);
model.material('mat1').set('diffuse', 'custom');
model.material('mat1').set('customdiffuse', [0.6666666666666666 0.6666666666666666 0.6666666666666666]);
model.material('mat1').set('specular', 'custom');
model.material('mat1').set('customspecular', [0.7843137254901961 0.7843137254901961 0.7843137254901961]);
model.material('mat1').set('noisecolor', 'custom');
model.material('mat1').set('customnoisecolor', [0 0 0]);
model.material('mat1').set('noisescale', 0);
model.material('mat1').set('noise', 'off');
model.material('mat1').set('noisefreq', 1);
model.material('mat1').set('normalnoisebrush', '0');
model.material('mat1').set('normalnoisetype', '0');
model.material('mat1').set('alpha', 1);
model.material('mat1').set('anisotropyaxis', [0 0 1]);

model.physics('solid').create('fix1', 'Fixed', 2);
model.physics('solid').feature('fix1').selection.set([8 9 33 42]);
model.physics('solid').create('bndl1', 'BoundaryLoad', 2);
model.physics('solid').feature('bndl1').selection.set([20 22 51 53]);
model.physics('solid').feature('bndl1').set('FperArea', {'0' 'fy_mh' 'fz_mh'});

model.mesh('mesh1').create('ftet1', 'FreeTet');
model.mesh('mesh1').feature('ftet1').selection.geom('geom1', 3);
model.mesh('mesh1').feature('ftet1').selection.set([4 7]);
model.mesh('mesh1').feature('ftet1').create('size1', 'Size');
model.mesh('mesh1').feature('ftet1').feature('size1').set('hauto', 4);
model.mesh('mesh1').run('ftet1');
model.mesh('mesh1').create('ftet2', 'FreeTet');
model.mesh('mesh1').feature('ftet2').selection.geom('geom1', 3);
model.mesh('mesh1').feature('ftet2').selection.set([1]);
model.mesh('mesh1').feature('ftet2').create('size1', 'Size');
model.mesh('mesh1').feature('ftet2').feature('size1').set('hauto', 3);
model.mesh('mesh1').run('ftet2');
model.mesh('mesh1').create('swe1', 'Sweep');
model.mesh('mesh1').feature('swe1').selection('sourceface').set([4]);
model.mesh('mesh1').feature('swe1').selection('targetface').set([3]);
model.mesh('mesh1').feature('swe1').create('size1', 'Size');
model.mesh('mesh1').feature('swe1').feature('size1').set('hauto', 4);
model.mesh('mesh1').run('swe1');

model.view('view1').set('renderwireframe', false);

model.sol.create('sol1');
model.sol('sol1').study('std1');

model.study('std1').feature('stat').set('notlistsolnum', 1);
model.study('std1').feature('stat').set('notsolnum', 'auto');
model.study('std1').feature('stat').set('listsolnum', 1);
model.study('std1').feature('stat').set('solnum', 'auto');

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
model.sol('sol1').feature('s1').create('d1', 'Direct');
model.sol('sol1').feature('s1').feature('d1').set('linsolver', 'pardiso');
model.sol('sol1').feature('s1').feature('d1').set('pivotperturb', 1.0E-9);
model.sol('sol1').feature('s1').feature('d1').label('Suggested Direct Solver (solid)');
model.sol('sol1').feature('s1').create('i1', 'Iterative');
model.sol('sol1').feature('s1').feature('i1').set('linsolver', 'gmres');
model.sol('sol1').feature('s1').feature('i1').set('rhob', 400);
model.sol('sol1').feature('s1').feature('i1').set('nlinnormuse', true);
model.sol('sol1').feature('s1').feature('i1').label('Suggested Iterative Solver (solid)');
model.sol('sol1').feature('s1').feature('i1').create('mg1', 'Multigrid');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').set('prefun', 'gmg');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('pr').create('so1', 'SOR');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('pr').feature('so1').set('relax', 0.8);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('po').create('so1', 'SOR');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('po').feature('so1').set('relax', 0.8);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('cs').create('d1', 'Direct');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('cs').feature('d1').set('linsolver', 'pardiso');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('cs').feature('d1').set('pivotperturb', 1.0E-9);
model.sol('sol1').feature('s1').feature('fc1').set('linsolver', 'd1');
model.sol('sol1').feature('s1').feature('fc1').set('termonres', 'auto');
model.sol('sol1').feature('s1').feature('fc1').set('reserrfact', 1000);
model.sol('sol1').feature('s1').feature.remove('fcDef');
model.sol('sol1').attach('std1');

model.result.create('pg1', 'PlotGroup3D');
model.result('pg1').set('data', 'dset1');
model.result('pg1').set('defaultPlotID', 'stress');
model.result('pg1').label('Stress (solid)');
model.result('pg1').set('frametype', 'spatial');
model.result('pg1').create('vol1', 'Volume');
model.result('pg1').feature('vol1').set('expr', {'solid.mises'});
model.result('pg1').feature('vol1').set('threshold', 'manual');
model.result('pg1').feature('vol1').set('thresholdvalue', 0.2);
model.result('pg1').feature('vol1').set('resolution', 'custom');
model.result('pg1').feature('vol1').set('refine', 2);
model.result('pg1').feature('vol1').set('colortable', 'Prism');
model.result('pg1').feature('vol1').create('def', 'Deform');
model.result('pg1').feature('vol1').feature('def').set('expr', {'u' 'v' 'w'});
model.result('pg1').feature('vol1').feature('def').set('descr', 'Displacement field');

model.sol('sol1').runAll;

model.result('pg1').run;
model.result('pg1').label('Displacement');
model.result('pg1').run;
model.result('pg1').feature('vol1').set('expr', 'w');
model.result('pg1').feature('vol1').set('descr', 'Displacement field, Z-component');
model.result('pg1').feature('vol1').set('unit', [native2unicode(hex2dec({'00' 'b5'}), 'unicode') 'm']);
model.result('pg1').run;
model.result.numerical.create('gev1', 'EvalGlobal');
model.result.numerical('gev1').set('expr', {'S_R'});
model.result.numerical('gev1').set('descr', {'Stiffness ratio'});
model.result.numerical('gev1').set('unit', {'1'});
model.result.table.create('tbl1', 'Table');
model.result.table('tbl1').comments('Global Evaluation 1');
model.result.numerical('gev1').set('table', 'tbl1');
model.result.numerical('gev1').setResult;

model.study('std1').create('param', 'Parametric');
model.study('std1').feature('param').setIndex('pname', 'h_t', 0);
model.study('std1').feature('param').setIndex('plistarr', '', 0);
model.study('std1').feature('param').setIndex('punit', 'm', 0);
model.study('std1').feature('param').setIndex('pname', 'h_t', 0);
model.study('std1').feature('param').setIndex('plistarr', '', 0);
model.study('std1').feature('param').setIndex('punit', 'm', 0);
model.study('std1').feature('param').setIndex('pname', 't_p', 0);
model.study('std1').feature('param').setIndex('plistarr', '10[mm] 12[mm]', 0);
model.study('std1').feature('param').setIndex('pname', 'h_t', 1);
model.study('std1').feature('param').setIndex('plistarr', '', 1);
model.study('std1').feature('param').setIndex('punit', 'm', 1);
model.study('std1').feature('param').setIndex('pname', 'h_t', 1);
model.study('std1').feature('param').setIndex('plistarr', '', 1);
model.study('std1').feature('param').setIndex('punit', 'm', 1);
model.study('std1').feature('param').setIndex('pname', 't_m', 1);
model.study('std1').feature('param').setIndex('plistarr', '10[mm] 15[mm]', 1);
model.study('std1').feature('param').set('plot', true);

model.sol('sol1').study('std1');

model.study('std1').feature('stat').set('notlistsolnum', 1);
model.study('std1').feature('stat').set('notsolnum', 'auto');
model.study('std1').feature('stat').set('listsolnum', 1);
model.study('std1').feature('stat').set('solnum', 'auto');

model.sol('sol1').feature.remove('s1');
model.sol('sol1').feature.remove('v1');
model.sol('sol1').feature.remove('st1');
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
model.sol('sol1').feature('s1').create('d1', 'Direct');
model.sol('sol1').feature('s1').feature('d1').set('linsolver', 'pardiso');
model.sol('sol1').feature('s1').feature('d1').set('pivotperturb', 1.0E-9);
model.sol('sol1').feature('s1').feature('d1').label('Suggested Direct Solver (solid)');
model.sol('sol1').feature('s1').create('i1', 'Iterative');
model.sol('sol1').feature('s1').feature('i1').set('linsolver', 'gmres');
model.sol('sol1').feature('s1').feature('i1').set('rhob', 400);
model.sol('sol1').feature('s1').feature('i1').set('nlinnormuse', true);
model.sol('sol1').feature('s1').feature('i1').label('Suggested Iterative Solver (solid)');
model.sol('sol1').feature('s1').feature('i1').create('mg1', 'Multigrid');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').set('prefun', 'gmg');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('pr').create('so1', 'SOR');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('pr').feature('so1').set('relax', 0.8);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('po').create('so1', 'SOR');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('po').feature('so1').set('relax', 0.8);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('cs').create('d1', 'Direct');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('cs').feature('d1').set('linsolver', 'pardiso');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('cs').feature('d1').set('pivotperturb', 1.0E-9);
model.sol('sol1').feature('s1').feature('fc1').set('linsolver', 'd1');
model.sol('sol1').feature('s1').feature('fc1').set('termonres', 'auto');
model.sol('sol1').feature('s1').feature('fc1').set('reserrfact', 1000);
model.sol('sol1').feature('s1').feature.remove('fcDef');
model.sol('sol1').attach('std1');

model.batch.create('p1', 'Parametric');
model.batch('p1').study('std1');
model.batch('p1').create('so1', 'Solutionseq');
model.batch('p1').feature('so1').set('seq', 'sol1');
model.batch('p1').feature('so1').set('store', 'on');
model.batch('p1').feature('so1').set('clear', 'on');
model.batch('p1').feature('so1').set('psol', 'none');
model.batch('p1').set('pname', {'t_p' 't_m'});
model.batch('p1').set('plistarr', {'10[mm] 12[mm]' '10[mm] 15[mm]'});
model.batch('p1').set('sweeptype', 'sparse');
model.batch('p1').set('probesel', 'all');
model.batch('p1').set('probes', {});
model.batch('p1').set('plot', 'on');
model.batch('p1').set('plotgroup', 'pg1');
model.batch('p1').set('err', 'on');
model.batch('p1').attach('std1');
model.batch('p1').set('control', 'param');

model.sol.create('sol2');
model.sol('sol2').study('std1');
model.sol('sol2').label('Parametric Solutions 1');

model.batch('p1').feature('so1').set('psol', 'sol2');

model.result.create('pg2', 'PlotGroup3D');
model.result('pg2').set('data', 'dset2');
model.result('pg2').set('defaultPlotID', 'stress');
model.result('pg2').label('Stress (solid)');
model.result('pg2').set('frametype', 'spatial');
model.result('pg2').create('vol1', 'Volume');
model.result('pg2').feature('vol1').set('expr', {'solid.mises'});
model.result('pg2').feature('vol1').set('threshold', 'manual');
model.result('pg2').feature('vol1').set('thresholdvalue', 0.2);
model.result('pg2').feature('vol1').set('resolution', 'custom');
model.result('pg2').feature('vol1').set('refine', 2);
model.result('pg2').feature('vol1').set('colortable', 'Prism');
model.result('pg2').feature('vol1').create('def', 'Deform');
model.result('pg2').feature('vol1').feature('def').set('expr', {'u' 'v' 'w'});
model.result('pg2').feature('vol1').feature('def').set('descr', 'Displacement field');

model.batch('p1').run('compute');

model.result('pg2').run;
model.result('pg1').run;
model.result('pg1').set('data', 'dset2');
model.result('pg1').run;
model.result.numerical.create('gev2', 'EvalGlobal');
model.result.numerical('gev2').set('data', 'dset2');
model.result.numerical('gev2').set('expr', {'S_R'});
model.result.numerical('gev2').set('descr', {'Stiffness ratio'});
model.result.numerical('gev2').set('unit', {'1'});
model.result.table.create('tbl2', 'Table');
model.result.table('tbl2').comments('Global Evaluation 2');
model.result.numerical('gev2').set('table', 'tbl2');
model.result.numerical('gev2').setResult;
model.result('pg1').run;

model.title('Stiffness Analysis of a Communication Mast''s Diagonal Mounting');

model.description('This example analyzes the stiffness of a communication mast''s mounting and compares the results to an ideal case. The example demonstrates how to use parameterized geometries in parametric sweeps.');

model.label('mast_diagonal_mounting.mph');

model.result('pg1').run;

model.physics.create('dg', 'DeformedGeometry', 'geom1');
model.physics('dg').model('comp1');

model.study('std1').feature('stat').setSolveFor('/physics/dg', false);

model.geom('geom1').run;

model.study.create('std2');
model.study('std2').create('stat', 'Stationary');
model.study('std2').feature('stat').setSolveFor('/physics/solid', true);
model.study('std2').feature('stat').setSolveFor('/physics/dg', true);

model.param.set('t_p', '10[mm]', 'Plate thickness');
model.param.set('t_p', '12[mm]');
model.param.descr('t_p', 'Plate thickness');
model.param.set('t_m', '10[mm]', 'Mount thickness');
model.param.set('t_m', '15[mm]');
model.param.descr('t_m', 'Mount thickness');
model.param.set('dm_p', '0');
model.param.descr('dm_p', 'Added mass, plate');
model.param.set('dm_m', '0');
model.param.descr('dm_m', 'Added mass, mount');

model.selection.create('uni1', 'Union');
model.selection('uni1').model('comp1');

model.geom('geom1').run;

model.selection('uni1').set('input', {'geom1_sel1' 'geom1_sel2'});
model.selection('uni1').label('Deformed mesh domains');

model.view('view1').set('renderwireframe', true);

model.cpl.create('intop1', 'Integration', 'geom1');
model.cpl('intop1').set('axisym', true);
model.cpl('intop1').set('opname', 'dA_mt');
model.cpl('intop1').selection.geom('geom1', 2);
model.cpl('intop1').selection.set([15 56]);

model.selection.create('sel2', 'Explicit');
model.selection('sel2').model('comp1');
model.selection('sel2').geom(2);
model.selection('sel2').label('Outer mount faces');
model.selection('sel2').set([15 56]);

model.cpl('intop1').selection.named('sel2');
model.cpl('intop1').label('Outer mount faces');
model.cpl.create('intop2', 'Integration', 'geom1');
model.cpl('intop2').set('axisym', true);
model.cpl('intop2').set('opname', 'dA_pl');
model.cpl('intop2').selection.geom('geom1', 2);
model.cpl('intop2').selection.set([4]);

model.selection.create('sel3', 'Explicit');
model.selection('sel3').model('comp1');
model.selection('sel3').geom(2);
model.selection('sel3').label('Plate surface');
model.selection('sel3').set([4]);

model.cpl('intop2').selection.named('sel3');
model.cpl('intop2').label('Plate surface');

model.view('view1').set('renderwireframe', false);

model.variable.create('var2');
model.variable('var2').model('comp1');
model.variable('var2').set('mA_pl', 'dA_pl(solid.rho)');
model.variable('var2').descr('mA_pl', 'Mass per unit thickness, plate');
model.variable('var2').set('mA_mt', 'dA_mt(solid.rho)');
model.variable('var2').descr('mA_mt', 'Mass per unit thickness, mount');
model.variable('var2').set('dt_p', 'dm_p[kg]/mA_pl');
model.variable('var2').descr('dt_p', 'Displacement, plate end face');
model.variable('var2').set('dt_m', 'dm_m[kg]/mA_mt');
model.variable('var2').descr('dt_m', 'Displacement, outer mount faces');
model.variable('var2').label('Sensitivity Variables');
model.variable('var1').set('Axy_mh', '2*r_mh*(t_m+dt_m)');

model.physics('dg').create('free1', 'FreeDeformation', 3);
model.physics('dg').feature('free1').selection.named('uni1');

model.coordSystem('sys1').set('frametype', 'geometry');

model.physics('dg').feature('disp1').setIndex('coordinateSystem', 'sys1', 0);
model.physics('dg').feature('disp1').setIndex('useDx', 0, 0);
model.physics('dg').feature('disp1').setIndex('useDx', 0, 1);
model.physics('dg').create('disp2', 'PrescribedMeshDisplacement', 2);
model.physics('dg').feature('disp2').selection.named('sel2');
model.physics('dg').feature('disp2').setIndex('coordinateSystem', 'sys1', 0);
model.physics('dg').feature('disp2').setIndex('useDx', 0, 0);
model.physics('dg').feature('disp2').setIndex('useDx', 0, 1);
model.physics('dg').feature('disp2').setIndex('dx', 'dt_m', 2);
model.physics('dg').create('disp3', 'PrescribedMeshDisplacement', 2);
model.physics('dg').feature('disp3').selection.named('sel3');
model.physics('dg').feature('disp3').setIndex('coordinateSystem', 'sys1', 0);
model.physics('dg').feature('disp3').setIndex('useDx', 0, 0);
model.physics('dg').feature('disp3').setIndex('useDx', 0, 1);
model.physics('dg').feature('disp3').setIndex('dx', 'dt_p', 2);

model.study('std2').create('sens', 'Sensitivity');
model.study('std2').feature('sens').set('gradientMethod', 'forward');
model.study('std2').feature('sens').set('optobj', {'comp1.S_R'});
model.study('std2').feature('sens').set('descr', {'Stiffness ratio'});
model.study('std2').feature('sens').setIndex('pname', 'h_t', 0);
model.study('std2').feature('sens').setIndex('initval', '200[mm]', 0);
model.study('std2').feature('sens').setIndex('scale', 1, 0);
model.study('std2').feature('sens').setIndex('valuetype', 'real', 0);
model.study('std2').feature('sens').setIndex('pname', 'h_t', 0);
model.study('std2').feature('sens').setIndex('initval', '200[mm]', 0);
model.study('std2').feature('sens').setIndex('scale', 1, 0);
model.study('std2').feature('sens').setIndex('valuetype', 'real', 0);
model.study('std2').feature('sens').setIndex('pname', 'r_t', 1);
model.study('std2').feature('sens').setIndex('initval', '50[mm]', 1);
model.study('std2').feature('sens').setIndex('scale', 1, 1);
model.study('std2').feature('sens').setIndex('valuetype', 'real', 1);
model.study('std2').feature('sens').setIndex('pname', 'r_t', 1);
model.study('std2').feature('sens').setIndex('initval', '50[mm]', 1);
model.study('std2').feature('sens').setIndex('scale', 1, 1);
model.study('std2').feature('sens').setIndex('valuetype', 'real', 1);
model.study('std2').feature('sens').setIndex('pname', 'dm_p', 0);
model.study('std2').feature('sens').setIndex('initval', 0, 0);
model.study('std2').feature('sens').setIndex('pname', 'dm_m', 1);
model.study('std2').feature('sens').setIndex('initval', 0, 1);

model.sol.create('sol5');

model.mesh('mesh1').stat.selection.geom(3);
model.mesh('mesh1').stat.selection.set([1 4 7]);

model.sol('sol5').study('std2');
model.sol('sol5').create('st1', 'StudyStep');
model.sol('sol5').feature('st1').set('study', 'std2');
model.sol('sol5').feature('st1').set('studystep', 'stat');
model.sol('sol5').create('v1', 'Variables');
model.sol('sol5').feature('v1').feature('comp1_material_disp').set('scalemethod', 'manual');
model.sol('sol5').feature('v1').feature('comp1_material_disp').set('scaleval', '0.0012444347208801847');
model.sol('sol5').feature('v1').set('control', 'stat');
model.sol('sol5').create('s1', 'Stationary');
model.sol('sol5').feature('s1').create('sn1', 'Sensitivity');
model.sol('sol5').feature('s1').feature('sn1').set('control', 'sens');
model.sol('sol5').feature('s1').feature('aDef').set('cachepattern', true);
model.sol('sol5').feature('s1').create('se1', 'Segregated');
model.sol('sol5').feature('s1').feature('se1').feature.remove('ssDef');
model.sol('sol5').feature('s1').feature('se1').create('ss1', 'SegregatedStep');
model.sol('sol5').feature('s1').feature('se1').feature('ss1').set('segvar', {'comp1_material_disp' 'conpar3' 'conpar4'});
model.sol('sol5').feature('s1').feature('se1').feature('ss1').set('linsolver', 'dDef');
model.sol('sol5').feature('s1').feature('se1').feature('ss1').label('Material Frame Variables');
model.sol('sol5').feature('s1').feature('se1').create('ss2', 'SegregatedStep');
model.sol('sol5').feature('s1').feature('se1').feature('ss2').set('segvar', {'comp1_u' 'conpar3' 'conpar4'});
model.sol('sol5').feature('s1').create('d1', 'Direct');
model.sol('sol5').feature('s1').feature('d1').set('linsolver', 'pardiso');
model.sol('sol5').feature('s1').feature('d1').set('pivotperturb', 1.0E-9);
model.sol('sol5').feature('s1').feature('d1').label('Suggested Direct Solver (solid)');
model.sol('sol5').feature('s1').feature('se1').feature('ss2').set('linsolver', 'd1');
model.sol('sol5').feature('s1').feature('se1').feature('ss2').label('Solid Mechanics');
model.sol('sol5').feature('s1').create('i1', 'Iterative');
model.sol('sol5').feature('s1').feature('i1').set('linsolver', 'gmres');
model.sol('sol5').feature('s1').feature('i1').set('rhob', 400);
model.sol('sol5').feature('s1').feature('i1').set('nlinnormuse', true);
model.sol('sol5').feature('s1').feature('i1').label('Suggested Iterative Solver (solid)');
model.sol('sol5').feature('s1').feature('i1').create('mg1', 'Multigrid');
model.sol('sol5').feature('s1').feature('i1').feature('mg1').set('prefun', 'gmg');
model.sol('sol5').feature('s1').feature('i1').feature('mg1').feature('pr').create('so1', 'SOR');
model.sol('sol5').feature('s1').feature('i1').feature('mg1').feature('pr').feature('so1').set('relax', 0.8);
model.sol('sol5').feature('s1').feature('i1').feature('mg1').feature('po').create('so1', 'SOR');
model.sol('sol5').feature('s1').feature('i1').feature('mg1').feature('po').feature('so1').set('relax', 0.8);
model.sol('sol5').feature('s1').feature('i1').feature('mg1').feature('cs').create('d1', 'Direct');
model.sol('sol5').feature('s1').feature('i1').feature('mg1').feature('cs').feature('d1').set('linsolver', 'pardiso');
model.sol('sol5').feature('s1').feature('i1').feature('mg1').feature('cs').feature('d1').set('pivotperturb', 1.0E-9);
model.sol('sol5').feature('s1').feature.remove('fcDef');
model.sol('sol5').attach('std2');
model.sol('sol5').runAll;

model.result.create('pg3', 'PlotGroup3D');
model.result('pg3').set('data', 'dset3');
model.result('pg3').set('defaultPlotID', 'stress');
model.result('pg3').label('Stress (solid) 1');
model.result('pg3').set('frametype', 'spatial');
model.result('pg3').create('vol1', 'Volume');
model.result('pg3').feature('vol1').set('expr', {'solid.misesGp'});
model.result('pg3').feature('vol1').set('threshold', 'manual');
model.result('pg3').feature('vol1').set('thresholdvalue', 0.2);
model.result('pg3').feature('vol1').set('colortable', 'Rainbow');
model.result('pg3').feature('vol1').set('colortabletrans', 'none');
model.result('pg3').feature('vol1').set('colorscalemode', 'linear');
model.result('pg3').feature('vol1').set('resolution', 'custom');
model.result('pg3').feature('vol1').set('refine', 2);
model.result('pg3').feature('vol1').set('colortable', 'Prism');
model.result('pg3').feature('vol1').create('def', 'Deform');
model.result('pg3').feature('vol1').feature('def').set('expr', {'u' 'v' 'w'});
model.result('pg3').feature('vol1').feature('def').set('descr', 'Displacement field');
model.result('pg3').run;
model.result.numerical.create('gev3', 'EvalGlobal');
model.result.numerical('gev3').set('data', 'dset3');
model.result.numerical('gev3').setIndex('expr', 'fsens(dm_m)', 0);
model.result.table.create('tbl3', 'Table');
model.result.table('tbl3').comments('Global Evaluation 3');
model.result.numerical('gev3').set('table', 'tbl3');
model.result.numerical('gev3').setResult;
model.result.numerical.duplicate('gev4', 'gev3');
model.result.numerical('gev4').setIndex('expr', 'fsens(dm_p)', 0);
model.result.numerical('gev4').set('table', 'tbl3');
model.result.numerical('gev4').appendResult;
model.result.create('pg4', 'PlotGroup3D');
model.result('pg4').run;
model.result('pg4').label('Sensitivity');
model.result('pg4').set('data', 'dset3');
model.result('pg4').create('surf1', 'Surface');
model.result('pg4').feature('surf1').set('expr', 'sens(w,dm_p)');
model.result('pg4').feature('surf1').set('colortable', 'ThermalDark');
model.result('pg4').run;
model.result('pg4').feature('surf1').create('def1', 'Deform');
model.result('pg4').run;
model.result('pg4').feature('surf1').feature('def1').set('expr', {'u+1[mm]*mA_pl*sens(u,dm_p)' 'v' 'w'});
model.result('pg4').feature('surf1').feature('def1').setIndex('expr', 'v+1[mm]*mA_pl*sens(v,dm_p)', 1);
model.result('pg4').feature('surf1').feature('def1').setIndex('expr', 'w+1[mm]*mA_pl*sens(w,dm_p)', 2);
model.result('pg4').run;
model.result('pg4').run;
model.result('pg4').set('titletype', 'manual');
model.result('pg4').set('title', 'Surface: Sensitivity of w to added plate mass');
model.result('pg4').run;

model.title('Sensitivity Analysis of a Communication Mast Detail');

model.description('Sensitivity analysis is used to predict what effect changing some geometrical parameters of a communication mast part has on its overall stiffness. For this purpose, an original structural model is enhanced with a Deformed Geometry interface and a Sensitivity Analysis interface.');

model.mesh.clearMeshes;

model.sol('sol1').clearSolutionData;
model.sol('sol2').clearSolutionData;
model.sol('sol3').clearSolutionData;
model.sol('sol4').clearSolutionData;
model.sol('sol5').clearSolutionData;

model.label('mast_diagonal_mounting_sensitivity.mph');

model.modelNode.label('Components');

out = model;
