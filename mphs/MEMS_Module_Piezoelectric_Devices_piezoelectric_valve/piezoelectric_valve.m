function out = model
%
% piezoelectric_valve.m
%
% Model exported on May 26 2025, 21:30 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/MEMS_Module/Piezoelectric_Devices');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 2);
model.geom('geom1').model('comp1');
model.geom('geom1').axisymmetric(true);

model.mesh.create('mesh1', 'geom1');

model.physics.create('solid', 'SolidMechanics', 'geom1');
model.physics('solid').model('comp1');
model.physics('solid').create('pzm1', 'PiezoelectricMaterialModel');
model.physics('solid').feature('pzm1').selection.all;
model.physics.create('es', 'Electrostatics', 'geom1');
model.physics('es').model('comp1');
model.physics('es').create('ccnp1', 'ChargeConservationPiezo');
model.physics('es').feature('ccnp1').selection.all;

model.multiphysics.create('pze1', 'PiezoelectricEffect', 'geom1', 2);
model.multiphysics('pze1').set('Solid_physics', 'solid');
model.multiphysics('pze1').set('Electrostatics_physics', 'es');

model.study.create('std1');
model.study('std1').create('stat', 'Stationary');
model.study('std1').feature('stat').setSolveFor('/physics/solid', true);
model.study('std1').feature('stat').setSolveFor('/physics/es', true);
model.study('std1').feature('stat').setSolveFor('/multiphysics/pze1', true);

model.geom('geom1').insertFile('piezoelectric_valve_geom_sequence.mph', 'geom1');
model.geom('geom1').run('fin');

model.param.set('V0', '50[V]');
model.param.descr('V0', 'Applied voltage');

model.selection.create('sel1', 'Explicit');
model.selection('sel1').model('comp1');
model.selection('sel1').set([5 7 9 10 12 14 18 20 22 23 25 27 32 34 36 37 39 41 47 49 51 52 54 56]);
model.selection('sel1').label('+ Polarized');
model.selection.create('sel2', 'Explicit');
model.selection('sel2').model('comp1');
model.selection('sel2').label('- Polarized');
model.selection('sel2').set([4 6 8 11 13 15 17 19 21 24 26 28 31 33 35 38 40 42 46 48 50 53 55 57]);
model.selection.create('uni1', 'Union');
model.selection('uni1').model('comp1');
model.selection('uni1').label('Piezoelectric');
model.selection('uni1').set('input', {'sel1' 'sel2'});
model.selection.create('sel3', 'Explicit');
model.selection('sel3').model('comp1');
model.selection('sel3').geom(1);
model.selection('sel3').label('Ground');
model.selection('sel3').set([10 14 18 22 26 30 33 36 40 44 48 52 56 59 76 80 84 88 92 96 99 109 113 117 121 125 129 133]);
model.selection.create('sel4', 'Explicit');
model.selection('sel4').model('comp1');
model.selection('sel4').label('Voltage');
model.selection('sel4').geom(1);
model.selection('sel4').set([12 16 20 24 28 32 38 42 46 50 54 58 78 82 86 90 94 98 111 115 119 123 127 131]);
model.selection.create('sel5', 'Explicit');
model.selection('sel5').model('comp1');
model.selection('sel5').label('Mapped Mesh Steel');
model.selection('sel5').set([1 2 29 43 44]);
model.selection.create('uni2', 'Union');
model.selection('uni2').model('comp1');
model.selection('uni2').set('input', {'uni1' 'sel5'});
model.selection('uni2').label('Mapped Mesh');

model.pair.create('p1', 'Contact', 'geom1');
model.pair('p1').source.set([8 62 71 72 150 151 152 153]);
model.pair('p1').destination.set([61 66]);

model.coordSystem('comp1_xz_sys').label('+Z Polarized');
model.coordSystem.duplicate('comp1_xz_sys1', 'comp1_xz_sys');
model.coordSystem('comp1_xz_sys1').set('base', {'1' '0' '0'; '0' '1' '0'; '0' '0' '-1'});
model.coordSystem('comp1_xz_sys1').label('-Z Polarized');

model.physics('solid').create('pzm2', 'PiezoelectricMaterialModel', 2);
model.physics('solid').feature('pzm2').set('coordinateSystem', 'comp1_xz_sys1');
model.physics('solid').feature('pzm2').selection.named('sel2');
model.physics('solid').feature('pzm1').selection.named('sel1');
model.physics('solid').create('hmm1', 'HyperelasticModel', 2);
model.physics('solid').feature('hmm1').selection.set([16]);
model.physics('solid').feature('hmm1').set('MaterialModel', 'MooneyRivlin');
model.physics('solid').feature('hmm1').set('kappa', '1e4[MPa]');
model.physics('solid').create('fix1', 'Fixed', 2);
model.physics('solid').feature('fix1').selection.set([1 2 29 43 44]);
model.physics('solid').create('cnt1', 'SolidContact', 1);
model.physics('solid').feature('cnt1').set('pairs', {'p1'});
model.physics('solid').feature('cnt1').set('ContactMethodCtrl', 'AugmentedLagrange');
model.physics('es').selection.named('uni1');
model.physics('es').create('term1', 'Terminal', 1);
model.physics('es').feature('term1').selection.named('sel4');
model.physics('es').feature('term1').set('TerminalType', 'Voltage');
model.physics('es').feature('term1').set('V0', 'V0');
model.physics('es').create('gnd1', 'Ground', 1);
model.physics('es').feature('gnd1').selection.named('sel3');

model.material.create('mat1', 'Common', 'comp1');
model.material('mat1').propertyGroup.create('StrainCharge', 'Strain-charge form');
model.material('mat1').propertyGroup.create('StressCharge', 'Stress-charge form');
model.material('mat1').label('Lead Zirconate Titanate (PZT-5H)');
model.material('mat1').set('family', 'custom');
model.material('mat1').set('customspecular', [0.7843137254901961 1 1]);
model.material('mat1').set('customdiffuse', [0.7843137254901961 0.7843137254901961 0.7843137254901961]);
model.material('mat1').set('noise', true);
model.material('mat1').set('fresnel', 0.9);
model.material('mat1').set('roughness', 0.1);
model.material('mat1').set('metallic', 0);
model.material('mat1').set('pearl', 0);
model.material('mat1').set('diffusewrap', 0);
model.material('mat1').set('clearcoat', 0);
model.material('mat1').set('reflectance', 0);
model.material('mat1').propertyGroup('def').set('relpermittivity', {'1704.4' '0' '0' '0' '1704.4' '0' '0' '0' '1433.6'});
model.material('mat1').propertyGroup('def').set('density', '7500[kg/m^3]');
model.material('mat1').propertyGroup('StrainCharge').set('sE', {'1.65e-011[1/Pa]' '-4.78e-012[1/Pa]' '-8.45e-012[1/Pa]' '0[1/Pa]' '0[1/Pa]' '0[1/Pa]' '-4.78e-012[1/Pa]' '1.65e-011[1/Pa]' '-8.45e-012[1/Pa]' '0[1/Pa]'  ...
'0[1/Pa]' '0[1/Pa]' '-8.45e-012[1/Pa]' '-8.45e-012[1/Pa]' '2.07e-011[1/Pa]' '0[1/Pa]' '0[1/Pa]' '0[1/Pa]' '0[1/Pa]' '0[1/Pa]'  ...
'0[1/Pa]' '4.35e-011[1/Pa]' '0[1/Pa]' '0[1/Pa]' '0[1/Pa]' '0[1/Pa]' '0[1/Pa]' '0[1/Pa]' '4.35e-011[1/Pa]' '0[1/Pa]'  ...
'0[1/Pa]' '0[1/Pa]' '0[1/Pa]' '0[1/Pa]' '0[1/Pa]' '4.26e-011[1/Pa]'});
model.material('mat1').propertyGroup('StrainCharge').set('dET', {'0[C/N]' '0[C/N]' '-2.74e-010[C/N]' '0[C/N]' '0[C/N]' '-2.74e-010[C/N]' '0[C/N]' '0[C/N]' '5.93e-010[C/N]' '0[C/N]'  ...
'7.41e-010[C/N]' '0[C/N]' '7.41e-010[C/N]' '0[C/N]' '0[C/N]' '0[C/N]' '0[C/N]' '0[C/N]'});
model.material('mat1').propertyGroup('StrainCharge').set('epsilonrT', {'3130' '0' '0' '0' '3130' '0' '0' '0' '3400'});
model.material('mat1').propertyGroup('StressCharge').set('cE', {'1.27205e+011[Pa]' '8.02122e+010[Pa]' '8.46702e+010[Pa]' '0[Pa]' '0[Pa]' '0[Pa]' '8.02122e+010[Pa]' '1.27205e+011[Pa]' '8.46702e+010[Pa]' '0[Pa]'  ...
'0[Pa]' '0[Pa]' '8.46702e+010[Pa]' '8.46702e+010[Pa]' '1.17436e+011[Pa]' '0[Pa]' '0[Pa]' '0[Pa]' '0[Pa]' '0[Pa]'  ...
'0[Pa]' '2.29885e+010[Pa]' '0[Pa]' '0[Pa]' '0[Pa]' '0[Pa]' '0[Pa]' '0[Pa]' '2.29885e+010[Pa]' '0[Pa]'  ...
'0[Pa]' '0[Pa]' '0[Pa]' '0[Pa]' '0[Pa]' '2.34742e+010[Pa]'});
model.material('mat1').propertyGroup('StressCharge').set('eES', {'0[C/m^2]' '0[C/m^2]' '-6.62281[C/m^2]' '0[C/m^2]' '0[C/m^2]' '-6.62281[C/m^2]' '0[C/m^2]' '0[C/m^2]' '23.2403[C/m^2]' '0[C/m^2]'  ...
'17.0345[C/m^2]' '0[C/m^2]' '17.0345[C/m^2]' '0[C/m^2]' '0[C/m^2]' '0[C/m^2]' '0[C/m^2]' '0[C/m^2]'});
model.material('mat1').propertyGroup('StressCharge').set('epsilonrS', {'1704.4' '0' '0' '0' '1704.4' '0' '0' '0' '1433.6'});
model.material.create('mat2', 'Common', 'comp1');
model.material('mat2').propertyGroup.create('Enu', 'Young''s modulus and Poisson''s ratio');
model.material('mat2').label('Steel AISI 4340');
model.material('mat2').set('family', 'steel');
model.material('mat2').propertyGroup('def').set('relpermeability', {'1' '0' '0' '0' '1' '0' '0' '0' '1'});
model.material('mat2').propertyGroup('def').set('electricconductivity', {'4.032e6[S/m]' '0' '0' '0' '4.032e6[S/m]' '0' '0' '0' '4.032e6[S/m]'});
model.material('mat2').propertyGroup('def').set('thermalexpansioncoefficient', {'12.3e-6[1/K]' '0' '0' '0' '12.3e-6[1/K]' '0' '0' '0' '12.3e-6[1/K]'});
model.material('mat2').propertyGroup('def').set('heatcapacity', '475[J/(kg*K)]');
model.material('mat2').propertyGroup('def').set('relpermittivity', {'1' '0' '0' '0' '1' '0' '0' '0' '1'});
model.material('mat2').propertyGroup('def').set('density', '7850[kg/m^3]');
model.material('mat2').propertyGroup('def').set('thermalconductivity', {'44.5[W/(m*K)]' '0' '0' '0' '44.5[W/(m*K)]' '0' '0' '0' '44.5[W/(m*K)]'});
model.material('mat2').propertyGroup('Enu').set('E', '205[GPa]');
model.material('mat2').propertyGroup('Enu').set('nu', '0.28');
model.material('mat1').selection.named('uni1');
model.material('mat2').selection.set([1 2 3 29 30 43 44 45]);
model.material.create('mat3', 'Common', 'comp1');
model.material('mat3').label('Seal');
model.material('mat3').selection.set([16]);
model.material('mat3').propertyGroup.create('MooneyRivlin', 'Mooney-Rivlin[Material_parameters]');
model.material('mat3').propertyGroup('MooneyRivlin').set('C10', {'0.37[MPa]'});
model.material('mat3').propertyGroup('MooneyRivlin').set('C01', {'0.11[MPa]'});
model.material('mat3').propertyGroup('def').set('density', {'1800[kg/m^3]'});

model.mesh('mesh1').create('edg1', 'Edge');
model.mesh('mesh1').feature('edg1').selection.set([61 62 66 71 150 151 152 153]);
model.mesh('mesh1').feature('edg1').create('size1', 'Size');
model.mesh('mesh1').feature('edg1').feature('size1').selection.set([61 66]);
model.mesh('mesh1').feature('edg1').feature('size1').set('hauto', 1);
model.mesh('mesh1').feature('edg1').feature('size1').set('custom', true);
model.mesh('mesh1').feature('edg1').feature('size1').set('hmaxactive', true);
model.mesh('mesh1').feature('edg1').feature('size1').set('hmax', 'w0/100');
model.mesh('mesh1').feature('edg1').create('size2', 'Size');
model.mesh('mesh1').feature('edg1').feature('size2').selection.set([62 71 150 151 152 153]);
model.mesh('mesh1').feature('edg1').feature('size2').set('hauto', 1);
model.mesh('mesh1').feature('edg1').feature('size2').set('custom', true);
model.mesh('mesh1').feature('edg1').feature('size2').set('hmaxactive', true);
model.mesh('mesh1').feature('edg1').feature('size2').set('hmax', 'w0/50');
model.mesh('mesh1').feature('size').set('hauto', 1);
model.mesh('mesh1').feature('size').set('custom', true);
model.mesh('mesh1').feature('size').set('hmax', 'w0');
model.mesh('mesh1').create('map1', 'Map');
model.mesh('mesh1').feature('map1').selection.geom('geom1', 2);
model.mesh('mesh1').feature('map1').selection.named('uni2');
model.mesh('mesh1').feature('map1').create('dis1', 'Distribution');
model.mesh('mesh1').feature('map1').feature('dis1').selection.set([75 77 79 81 83 85 87 89 91 93 95 97]);
model.mesh('mesh1').feature('map1').feature('dis1').set('numelem', 2);
model.mesh('mesh1').feature('map1').create('dis2', 'Distribution');
model.mesh('mesh1').feature('map1').feature('dis2').selection.set([36 109]);
model.mesh('mesh1').feature('map1').feature('dis2').set('numelem', 40);
model.mesh('mesh1').feature('map1').create('dis3', 'Distribution');
model.mesh('mesh1').feature('map1').feature('dis3').set('numelem', 1);
model.mesh('mesh1').feature('map1').feature('dis3').selection.set([2 63 67 101]);
model.mesh('mesh1').create('ftri1', 'FreeTri');
model.mesh('mesh1').run;

model.study('std1').feature('stat').set('useparam', true);
model.study('std1').feature('stat').setIndex('pname', 't0', 0);
model.study('std1').feature('stat').setIndex('plistarr', '', 0);
model.study('std1').feature('stat').setIndex('punit', 'm', 0);
model.study('std1').feature('stat').setIndex('pname', 't0', 0);
model.study('std1').feature('stat').setIndex('plistarr', '', 0);
model.study('std1').feature('stat').setIndex('punit', 'm', 0);
model.study('std1').feature('stat').setIndex('pname', 'V0', 0);
model.study('std1').feature('stat').setIndex('plistarr', 'range(0,5,60)', 0);

model.sol.create('sol1');
model.sol('sol1').study('std1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'stat');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').feature('comp1_solid_Tn_p1').set('scalemethod', 'manual');
model.sol('sol1').feature('v1').feature('comp1_solid_hmm1_pw').set('scalemethod', 'manual');
model.sol('sol1').feature('v1').feature('comp1_u').set('scalemethod', 'manual');
model.sol('sol1').feature('v1').feature('comp1_solid_Tn_p1').set('scaleval', '100000000');
model.sol('sol1').feature('v1').feature('comp1_solid_hmm1_pw').set('scaleval', '100000000');
model.sol('sol1').feature('v1').feature('comp1_u').set('scaleval', '1e-2*0.029048054254975496');
model.sol('sol1').feature('v1').set('control', 'stat');
model.sol('sol1').create('s1', 'Stationary');
model.sol('sol1').feature('s1').create('p1', 'Parametric');
model.sol('sol1').feature('s1').feature.remove('pDef');
model.sol('sol1').feature('s1').feature('p1').set('porder', 'constant');
model.sol('sol1').feature('s1').feature('p1').set('control', 'stat');
model.sol('sol1').feature('s1').set('control', 'stat');
model.sol('sol1').feature('s1').feature('aDef').set('cachepattern', true);
model.sol('sol1').feature('s1').create('seDef', 'Segregated');
model.sol('sol1').feature('s1').create('se1', 'Segregated');
model.sol('sol1').feature('s1').feature('se1').feature.remove('ssDef');
model.sol('sol1').feature('s1').feature('se1').create('ss1', 'SegregatedStep');
model.sol('sol1').feature('s1').feature('se1').feature('ss1').set('segvar', {'comp1_u' 'comp1_solid_hmm1_pw' 'comp1_V'});
model.sol('sol1').feature('s1').feature('se1').feature('ss1').set('subdtech', 'ddog');
model.sol('sol1').feature('s1').feature('se1').feature('ss1').set('subtermauto', 'itertol');
model.sol('sol1').feature('s1').feature('se1').feature('ss1').set('subiter', 7);
model.sol('sol1').feature('s1').feature('se1').feature('ss1').set('subntolfact', 1);
model.sol('sol1').feature('s1').feature('se1').feature('ss1').set('linsolver', 'dDef');
model.sol('sol1').feature('s1').feature('se1').feature('ss1').label('Merged Variables');
model.sol('sol1').feature('s1').feature('se1').create('ls1', 'LumpedStep');
model.sol('sol1').feature('s1').feature('se1').feature('ls1').set('segvar', {'comp1_solid_Tn_p1'});
model.sol('sol1').feature('s1').feature('se1').set('maxsegiter', 15);
model.sol('sol1').feature('s1').feature.remove('fcDef');
model.sol('sol1').feature('s1').feature.remove('seDef');
model.sol('sol1').attach('std1');
model.sol('sol1').feature('v1').feature('comp1_solid_hmm1_pw').set('scaleval', '1e6');
model.sol('sol1').feature('v1').feature('comp1_solid_Tn_p1').set('scaleval', '1e6');
model.sol('sol1').feature('s1').feature('se1').feature('ss1').set('subdtech', 'auto');
model.sol('sol1').runAll;

model.result.create('pg1', 'PlotGroup2D');
model.result('pg1').set('data', 'dset1');
model.result('pg1').setIndex('looplevel', 13, 0);
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
model.result.dataset.create('dset1solidrev', 'Revolve2D');
model.result.dataset('dset1solidrev').set('data', 'dset1');
model.result.dataset('dset1solidrev').set('revangle', 225);
model.result.dataset('dset1solidrev').set('startangle', -90);
model.result.dataset('dset1solidrev').set('hasspacevars', true);
model.result.create('pg2', 'PlotGroup3D');
model.result('pg2').set('data', 'dset1solidrev');
model.result('pg2').setIndex('looplevel', 13, 0);
model.result('pg2').set('defaultPlotID', 'stress3D');
model.result('pg2').label('Stress, 3D (solid)');
model.result('pg2').set('frametype', 'spatial');
model.result('pg2').create('surf1', 'Surface');
model.result('pg2').feature('surf1').set('expr', {'solid.misesGp'});
model.result('pg2').feature('surf1').set('threshold', 'manual');
model.result('pg2').feature('surf1').set('thresholdvalue', 0.2);
model.result('pg2').feature('surf1').set('colortable', 'Rainbow');
model.result('pg2').feature('surf1').set('colortabletrans', 'none');
model.result('pg2').feature('surf1').set('colorscalemode', 'linear');
model.result('pg2').feature('surf1').set('colortable', 'Prism');
model.result.create('pg3', 'PlotGroup2D');
model.result('pg3').label('Electric Potential (es)');
model.result('pg3').set('dataisaxisym', 'off');
model.result('pg3').set('frametype', 'spatial');
model.result('pg3').set('showlegendsmaxmin', true);
model.result('pg3').set('data', 'dset1');
model.result('pg3').setIndex('looplevel', 13, 0);
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
model.result('pg3').feature('str1').set('expr', {'es.Er' 'es.Ez'});
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
model.result('pg3').feature('str1').selection.set([9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 35 36 37 38 39 40 41 42 43 44 45 46 47 48 49 50 51 52 53 54 55 56 57 58 59 75 76 77 78 79 80 81 82 83 84 85 86 87 88 89 90 91 92 93 94 95 96 97 98 99 108 109 110 111 112 113 114 115 116 117 118 119 120 121 122 123 124 125 126 127 128 129 130 131 133 135 136 137 138 139 140 141 142 143 144 145 146]);
model.result('pg3').feature('str1').set('inheritplot', 'surf1');
model.result('pg3').feature('str1').feature.create('col1', 'Color');
model.result('pg3').feature('str1').feature('col1').set('expr', 'V');
model.result('pg3').feature('str1').feature('col1').set('colortable', 'DipoleDark');
model.result('pg3').feature('str1').feature('col1').set('colorlegend', false);
model.result('pg3').feature('str1').feature.create('filt1', 'Filter');
model.result('pg3').feature('str1').feature('filt1').set('expr', '!isScalingSystemDomain');
model.result.dataset.create('rev1', 'Revolve2D');
model.result.dataset('rev1').set('data', 'none');
model.result.dataset('rev1').set('startangle', -90);
model.result.dataset('rev1').set('revangle', 225);
model.result.dataset('rev1').set('data', 'dset1');
model.result.create('pg4', 'PlotGroup3D');
model.result('pg4').label('Electric Potential, Revolved Geometry (es)');
model.result('pg4').set('data', 'rev1');
model.result('pg4').setIndex('looplevel', 13, 0);
model.result('pg4').set('frametype', 'spatial');
model.result('pg4').set('showlegendsmaxmin', true);
model.result('pg4').set('data', 'rev1');
model.result('pg4').setIndex('looplevel', 13, 0);
model.result('pg4').set('defaultPlotID', 'InterfaceComponents/PlotDefaults/icom2/pdef1/pcond2/pcond3/pcond1/pg1');
model.result('pg4').feature.create('vol1', 'Volume');
model.result('pg4').feature('vol1').set('showsolutionparams', 'on');
model.result('pg4').feature('vol1').set('solutionparams', 'parent');
model.result('pg4').feature('vol1').set('expr', 'V');
model.result('pg4').feature('vol1').set('colortable', 'Dipole');
model.result('pg4').feature('vol1').set('showsolutionparams', 'on');
model.result('pg4').feature('vol1').set('data', 'parent');
model.result.create('pg5', 'PlotGroup2D');
model.result('pg5').label('Electric Field Norm (es)');
model.result('pg5').set('dataisaxisym', 'off');
model.result('pg5').set('frametype', 'spatial');
model.result('pg5').set('showlegendsmaxmin', true);
model.result('pg5').set('data', 'dset1');
model.result('pg5').setIndex('looplevel', 13, 0);
model.result('pg5').set('defaultPlotID', 'InterfaceComponents/PlotDefaults/icom3/pdef1/pcond2/pcond2/pg1');
model.result('pg5').feature.create('surf1', 'Surface');
model.result('pg5').feature('surf1').set('showsolutionparams', 'on');
model.result('pg5').feature('surf1').set('solutionparams', 'parent');
model.result('pg5').feature('surf1').set('expr', 'es.normE');
model.result('pg5').feature('surf1').set('colortable', 'Prism');
model.result('pg5').feature('surf1').set('colortabletrans', 'nonlinear');
model.result('pg5').feature('surf1').set('colorcalibration', -0.8);
model.result('pg5').feature('surf1').set('showsolutionparams', 'on');
model.result('pg5').feature('surf1').set('data', 'parent');
model.result('pg5').feature.create('str1', 'Streamline');
model.result('pg5').feature('str1').set('showsolutionparams', 'on');
model.result('pg5').feature('str1').set('solutionparams', 'parent');
model.result('pg5').feature('str1').set('expr', {'es.Er' 'es.Ez'});
model.result('pg5').feature('str1').set('titletype', 'none');
model.result('pg5').feature('str1').set('posmethod', 'uniform');
model.result('pg5').feature('str1').set('udist', 0.02);
model.result('pg5').feature('str1').set('maxlen', 0.4);
model.result('pg5').feature('str1').set('maxtime', Inf);
model.result('pg5').feature('str1').set('inheritcolor', false);
model.result('pg5').feature('str1').set('showsolutionparams', 'on');
model.result('pg5').feature('str1').set('maxtime', Inf);
model.result('pg5').feature('str1').set('showsolutionparams', 'on');
model.result('pg5').feature('str1').set('maxtime', Inf);
model.result('pg5').feature('str1').set('showsolutionparams', 'on');
model.result('pg5').feature('str1').set('maxtime', Inf);
model.result('pg5').feature('str1').set('showsolutionparams', 'on');
model.result('pg5').feature('str1').set('maxtime', Inf);
model.result('pg5').feature('str1').set('data', 'parent');
model.result('pg5').feature('str1').selection.geom('geom1', 1);
model.result('pg5').feature('str1').selection.set([9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 35 36 37 38 39 40 41 42 43 44 45 46 47 48 49 50 51 52 53 54 55 56 57 58 59 75 76 77 78 79 80 81 82 83 84 85 86 87 88 89 90 91 92 93 94 95 96 97 98 99 108 109 110 111 112 113 114 115 116 117 118 119 120 121 122 123 124 125 126 127 128 129 130 131 133 135 136 137 138 139 140 141 142 143 144 145 146]);
model.result('pg5').feature('str1').set('inheritplot', 'surf1');
model.result('pg5').feature('str1').feature.create('col1', 'Color');
model.result('pg5').feature('str1').feature('col1').set('expr', 'es.normE');
model.result('pg5').feature('str1').feature('col1').set('colortable', 'PrismDark');
model.result('pg5').feature('str1').feature('col1').set('colorlegend', false);
model.result('pg5').feature('str1').feature('col1').set('colortabletrans', 'nonlinear');
model.result('pg5').feature('str1').feature('col1').set('colorcalibration', -0.8);
model.result('pg5').feature('str1').feature.create('filt1', 'Filter');
model.result('pg5').feature('str1').feature('filt1').set('expr', '!isScalingSystemDomain');
model.result('pg1').run;
model.result.create('pg6', 'PlotGroup2D');
model.result('pg6').run;
model.result('pg6').label('Strain (ZZ component)');
model.result('pg6').set('frametype', 'spatial');
model.result('pg6').create('surf1', 'Surface');
model.result('pg6').feature('surf1').set('expr', 'solid.eZZ');
model.result('pg6').feature('surf1').set('descr', 'Strain tensor, ZZ-component');
model.result('pg6').feature('surf1').set('colortabletrans', 'reverse');
model.result('pg6').run;
model.result('pg6').run;

model.view.create('view2', 2);
model.view('view2').axis.set('xmin', 0.00399);
model.view('view2').axis.set('xmax', 0.00505);
model.view('view2').axis.set('ymin', -8.525E-5);
model.view('view2').axis.set('ymax', 8.125E-4);
model.view('view2').axis.set('viewscaletype', 'manual');

model.result('pg2').run;
model.result('pg6').run;
model.result.duplicate('pg7', 'pg6');
model.result('pg7').run;
model.result('pg7').label('Electric Field (Z component)');
model.result('pg7').run;
model.result('pg7').feature('surf1').set('expr', 'es.EZ');
model.result('pg7').feature('surf1').set('descr', 'Electric field, Z-component');
model.result('pg7').run;
model.result.create('pg8', 'PlotGroup1D');
model.result('pg8').run;
model.result('pg8').label('Contact Pressure');
model.result('pg8').setIndex('looplevelinput', 'last', 0);
model.result('pg8').create('lngr1', 'LineGraph');
model.result('pg8').feature('lngr1').set('markerpos', 'datapoints');
model.result('pg8').feature('lngr1').set('linewidth', 'preference');
model.result('pg8').feature('lngr1').selection.set([60 61 65 66 73]);
model.result('pg8').feature('lngr1').set('expr', 'solid.Tn');
model.result('pg8').feature('lngr1').set('descr', 'Contact pressure');
model.result('pg8').run;

model.title('Piezoelectric Valve');

model.description(['Piezoelectric valves are frequently employed in medical and laboratory applications due to their fast response times and quiet operation. Their energy efficient operation also dissipates little heat, which is often important for these applications.' newline  newline 'This model shows how to model a piezoelectric valve in COMSOL. The valve is actuated by a stacked piezoelectric actuator. A hyper-elastic seal is compressed against a valve opening by the actuator and the contact is modeled.' newline  newline 'This model requires the Nonlinear Structural Materials Module']);

model.mesh.clearMeshes;

model.sol('sol1').clearSolutionData;

model.label('piezoelectric_valve.mph');

model.modelNode.label('Components');

out = model;
