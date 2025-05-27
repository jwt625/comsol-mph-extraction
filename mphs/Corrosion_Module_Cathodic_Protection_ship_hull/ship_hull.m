function out = model
%
% ship_hull.m
%
% Model exported on May 26 2025, 21:27 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/Corrosion_Module/Cathodic_Protection');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 3);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.physics.create('cp', 'CathodicProtection', 'geom1');
model.physics('cp').model('comp1');

model.study.create('std1');
model.study('std1').create('stat', 'Stationary');
model.study('std1').feature('stat').setSolveFor('/physics/cp', true);

model.geom('geom1').create('imp1', 'Import');
model.geom('geom1').feature('imp1').set('filename', 'ship_hull_geometry.mphbin');
model.geom('geom1').feature('imp1').importData;
model.geom('geom1').run('fin');
model.geom('geom1').create('mcf1', 'MeshControlFaces');
model.geom('geom1').feature('mcf1').selection('input').set('fin', [8 9 10 11 14]);
model.geom('geom1').run('mcf1');

model.view('view1').set('transparency', true);
model.view.create('view2', 'geom1');
model.view('view2').model('comp1');
model.view('view2').camera.setIndex('position', -200, 0);
model.view('view2').camera.setIndex('position', -250, 1);
model.view('view2').camera.set('position', [-200 -250 20]);
model.view('view2').camera.set('target', [-5 20 -5]);
model.view('view2').camera.setIndex('up', 0, 0);
model.view('view2').camera.setIndex('up', 0, 1);
model.view('view2').camera.set('up', [0 0 1]);
model.view('view2').camera.setIndex('viewoffset', -0.65, 0);
model.view('view2').camera.set('viewoffset', [-0.65 -0.26325]);
model.view('view2').camera.set('zoomanglefull', 0.3);

% To import content from file, use:
% model.param.loadFile('FILENAME');
model.param.set('E_control', '-0.85[V]', 'Ship hull potential vs. Ag/AgCl, imposed by ICCP system');
model.param.set('sigma', '4[S/m]', 'Sea water conductivity');
model.param.set('ilim', '5[A/m^2]', 'Limiting current density at cathodes');

model.selection.create('sel1', 'Explicit');
model.selection('sel1').model('comp1');
model.selection('sel1').geom(2);
model.selection('sel1').set([20 21 22]);
model.selection('sel1').label('Propeller base');
model.selection.create('sel2', 'Explicit');
model.selection('sel2').model('comp1');
model.selection('sel2').geom(2);
model.selection('sel2').set([14 16 17 40 41]);
model.selection('sel2').label('Propeller blades');
model.selection.create('sel3', 'Explicit');
model.selection('sel3').model('comp1');
model.selection('sel3').geom(2);
model.selection('sel3').set([29 39]);
model.selection('sel3').label('Shaft');
model.selection.create('sel4', 'Explicit');
model.selection('sel4').model('comp1');
model.selection('sel4').geom(2);
model.selection('sel4').set([19]);
model.selection('sel4').label('Anode');
model.selection.create('sel5', 'Explicit');
model.selection('sel5').model('comp1');
model.selection('sel5').geom(2);
model.selection('sel5').set([18]);
model.selection('sel5').label('Reference electrode');
model.selection.create('sel6', 'Explicit');
model.selection('sel6').model('comp1');
model.selection('sel6').geom(2);
model.selection('sel6').set([6 7 8 9 10 11 12 13 15 20 21 22 23 24 25 26 27 28 30 31 32 33 34 35 36 37 38 42 43 44 45 46 47]);
model.selection('sel6').label('Hull surface');
model.selection.create('uni1', 'Union');
model.selection('uni1').model('comp1');
model.selection('uni1').set('entitydim', 2);
model.selection('uni1').set('input', {'sel2' 'sel3' 'sel4' 'sel5' 'sel6'});
model.selection('uni1').label('Ship surface');
model.selection.create('uni2', 'Union');
model.selection('uni2').model('comp1');
model.selection('uni2').set('entitydim', 2);
model.selection('uni2').set('input', {'sel1' 'sel2' 'sel3'});
model.selection('uni2').label('Propeller and Shaft');
model.selection.create('uni3', 'Union');
model.selection('uni3').model('comp1');
model.selection('uni3').set('entitydim', 2);
model.selection('uni3').set('input', {'sel1' 'sel2'});
model.selection('uni3').label('Propeller');

model.material.create('mat1', 'Common', 'comp1');
model.material('mat1').propertyGroup.create('LocalCurrentDensity', 'Local current density');
model.material('mat1').propertyGroup('LocalCurrentDensity').func.create('int1', 'Interpolation');
model.material('mat1').propertyGroup.create('ElectrodePotential', 'Equilibrium potential');
model.material('mat1').label('Alloy 625 in seawater at 30 C');
model.material('mat1').propertyGroup('LocalCurrentDensity').func('int1').set('funcname', 'iloc_exp');
model.material('mat1').propertyGroup('LocalCurrentDensity').func('int1').set('table', {'-1.011527576' '-0.645737289';  ...
'-0.947975783' '-0.352765442';  ...
'-0.896778481' '-0.213603782';  ...
'-0.85086506' '-0.127686579';  ...
'-0.806721138' '-0.07933071';  ...
'-0.752016834' '-0.05256182';  ...
'-0.67620161' '-0.041697665';  ...
'-0.598616888' '-0.031826824';  ...
'-0.533359585' '-0.023373034';  ...
'-0.476893166' '-0.015486174';  ...
'-0.425700785' '-0.009621443';  ...
'-0.383309133' '-0.005677929';  ...
'-0.349735437' '-0.003482567';  ...
'-0.319683508' '-0.002108737';  ...
'-0.287839933' '-0.001094224';  ...
'-0.266598578' '-0.000662566';  ...
'-0.245384294' '-0.000462173';  ...
'-0.227679472' '-0.000298442';  ...
'-0.204680924' '-0.00018542';  ...
'-0.190492949' '-0.0001152';  ...
'-0.178015406' '-5.46299E-05';  ...
'-0.16396525' '6.9755E-05';  ...
'-0.160519775' '0.00010528';  ...
'-0.160586223' '0.000148999';  ...
'-0.139531908' '0.000239822';  ...
'-0.121972289' '0.000330791';  ...
'-0.106179706' '0.000468157';  ...
'-0.081579012' '0.000671144';  ...
'-0.053473777' '0.001066431';  ...
'-0.023599045' '0.001630386';  ...
'0.01331184' '0.002658159';  ...
'0.048492605' '0.00366645'});
model.material('mat1').propertyGroup('LocalCurrentDensity').func('int1').set('extrap', 'linear');
model.material('mat1').propertyGroup('LocalCurrentDensity').func('int1').set('fununit', {'mA/cm^2'});
model.material('mat1').propertyGroup('LocalCurrentDensity').func('int1').set('argunit', {'V'});
model.material('mat1').propertyGroup('LocalCurrentDensity').set('ilocmat', 'iloc_exp(E_vs_ref_exp)');
model.material('mat1').propertyGroup('LocalCurrentDensity').set('INFO_PREFIX:ilocmat', ['H. P. Hack, ' native2unicode(hex2dec({'20' '1c'}), 'unicode') 'Atlas of polarization diagrams for naval materials in seawater' native2unicode(hex2dec({'20' '1d'}), 'unicode') ', Naval Surface Warfare Centre Technical Report, CARDIVNSWC-TR-61-94/44, 1995.']);
model.material('mat1').propertyGroup('LocalCurrentDensity').set('E_vs_SHE', 'V');
model.material('mat1').propertyGroup('LocalCurrentDensity').descr('E_vs_SHE', 'Electrode potential vs. SHE');
model.material('mat1').propertyGroup('LocalCurrentDensity').set('E_ref_exp_vs_SHE', '0.197 [V]');
model.material('mat1').propertyGroup('LocalCurrentDensity').descr('E_ref_exp_vs_SHE', 'Reference electrode potential in experiment vs. SHE');
model.material('mat1').propertyGroup('LocalCurrentDensity').set('E_vs_ref_exp', 'E_vs_SHE-E_ref_exp_vs_SHE');
model.material('mat1').propertyGroup('LocalCurrentDensity').descr('E_vs_ref_exp', 'Electrode potential vs. experimental Ag/AgCl reference electrode');
model.material('mat1').propertyGroup('LocalCurrentDensity').addInput('electricpotential');
model.material('mat1').propertyGroup('ElectrodePotential').set('Eeq', 'Eeq_vs_SHE');
model.material('mat1').propertyGroup('ElectrodePotential').set('INFO_PREFIX:Eeq', ['H. P. Hack, ' native2unicode(hex2dec({'20' '1c'}), 'unicode') 'Atlas of polarization diagrams for naval materials in seawater' native2unicode(hex2dec({'20' '1d'}), 'unicode') ', Naval Surface Warfare Centre Technical Report, CARDIVNSWC-TR-61-94/44, 1995.']);
model.material('mat1').propertyGroup('ElectrodePotential').set('dEeqdT', '0');
model.material('mat1').propertyGroup('ElectrodePotential').set('cEeqref', '0');
model.material('mat1').propertyGroup('ElectrodePotential').set('Eeq_vs_ref_exp', '-0.2 [V]');
model.material('mat1').propertyGroup('ElectrodePotential').descr('Eeq_vs_ref_exp', 'Equilibrium (open circuit) potential vs. Ag/AgCl');
model.material('mat1').propertyGroup('ElectrodePotential').set('E_ref_exp_vs_SHE', '0.197 [V]');
model.material('mat1').propertyGroup('ElectrodePotential').descr('E_ref_exp_vs_SHE', 'Reference electrode potential in experiment vs. SHE');
model.material('mat1').propertyGroup('ElectrodePotential').set('Eeq_vs_SHE', 'Eeq_vs_ref_exp+E_ref_exp_vs_SHE');
model.material('mat1').propertyGroup('ElectrodePotential').descr('Eeq_vs_SHE', 'Equilibrium (open circuit) potential vs. SHE');
model.material('mat1').propertyGroup('ElectrodePotential').addInput('concentration');
model.material('mat1').selection.geom('geom1', 2);
model.material('mat1').selection.named('sel3');
model.material.create('mat2', 'Common', 'comp1');
model.material('mat2').propertyGroup.create('LocalCurrentDensity', 'Local current density');
model.material('mat2').propertyGroup('LocalCurrentDensity').func.create('int1', 'Interpolation');
model.material('mat2').propertyGroup.create('ElectrodePotential', 'Equilibrium potential');
model.material('mat2').label('NAB in seawater at 30 C');
model.material('mat2').propertyGroup('LocalCurrentDensity').func('int1').set('funcname', 'iloc_exp');
model.material('mat2').propertyGroup('LocalCurrentDensity').func('int1').set('table', {'-1.004778059' '-1.56030719';  ...
'-0.87763365' '-1.523362505';  ...
'-0.828863572' '-1.486064149';  ...
'-0.766152624' '-1.378344134';  ...
'-0.726086977' '-1.310880463';  ...
'-0.682526543' '-1.15562649';  ...
'-0.637212974' '-0.944306285';  ...
'-0.590138614' '-0.679941078';  ...
'-0.544794423' '-0.453789793';  ...
'-0.5011804' '-0.280713444';  ...
'-0.455813241' '-0.160958048';  ...
'-0.420901735' '-0.095851259';  ...
'-0.389467791' '-0.054952001';  ...
'-0.363266458' '-0.033137768';  ...
'-0.344006852' '-0.016951286';  ...
'-0.331736819' '-0.01009216';  ...
'-0.324682172' '-0.005639871';  ...
'-0.321120399' '-0.003357459';  ...
'-0.314077236' '-0.002024244';  ...
'-0.307007278' '-0.001022332';  ...
'-0.303811059' '0.006819967';  ...
'-0.298687541' '0.013335661';  ...
'-0.29006158' '0.022978294';  ...
'-0.277950401' '0.039096913';  ...
'-0.258882185' '0.070871486';  ...
'-0.239812055' '0.126854567';  ...
'-0.220738097' '0.221386781';  ...
'-0.198194232' '0.422157674';  ...
'-0.173878094' '0.657496912';  ...
'-0.153041431' '0.998407432';  ...
'-0.133954076' '1.594747407';  ...
'-0.107902027' '2.579897189';  ...
'-0.083574405' '3.724383972';  ...
'-0.052284004' '5.514769822';  ...
'-0.010555175' '8.810796279';  ...
'0.041635047' '13.04919726'});
model.material('mat2').propertyGroup('LocalCurrentDensity').func('int1').set('extrap', 'linear');
model.material('mat2').propertyGroup('LocalCurrentDensity').func('int1').set('fununit', {'mA/cm^2'});
model.material('mat2').propertyGroup('LocalCurrentDensity').func('int1').set('argunit', {'V'});
model.material('mat2').propertyGroup('LocalCurrentDensity').set('ilocmat', 'iloc_exp(E_vs_ref_exp)');
model.material('mat2').propertyGroup('LocalCurrentDensity').set('INFO_PREFIX:ilocmat', ['H. P. Hack, ' native2unicode(hex2dec({'20' '1c'}), 'unicode') 'Atlas of polarization diagrams for naval materials in seawater' native2unicode(hex2dec({'20' '1d'}), 'unicode') ', Naval Surface Warfare Centre Technical Report, CARDIVNSWC-TR-61-94/44, 1995.']);
model.material('mat2').propertyGroup('LocalCurrentDensity').set('E_vs_SHE', 'V');
model.material('mat2').propertyGroup('LocalCurrentDensity').descr('E_vs_SHE', 'Electrode potential vs. SHE');
model.material('mat2').propertyGroup('LocalCurrentDensity').set('E_ref_exp_vs_SHE', '0.197 [V]');
model.material('mat2').propertyGroup('LocalCurrentDensity').descr('E_ref_exp_vs_SHE', 'Reference electrode potential in experiment vs. SHE');
model.material('mat2').propertyGroup('LocalCurrentDensity').set('E_vs_ref_exp', 'E_vs_SHE-E_ref_exp_vs_SHE');
model.material('mat2').propertyGroup('LocalCurrentDensity').descr('E_vs_ref_exp', 'Electrode potential vs. experimental Ag/AgCl reference electrode');
model.material('mat2').propertyGroup('LocalCurrentDensity').addInput('electricpotential');
model.material('mat2').propertyGroup('ElectrodePotential').set('Eeq', 'Eeq_vs_SHE');
model.material('mat2').propertyGroup('ElectrodePotential').set('INFO_PREFIX:Eeq', ['H. P. Hack, ' native2unicode(hex2dec({'20' '1c'}), 'unicode') 'Atlas of polarization diagrams for naval materials in seawater' native2unicode(hex2dec({'20' '1d'}), 'unicode') ', Naval Surface Warfare Centre Technical Report, CARDIVNSWC-TR-61-94/44, 1995.']);
model.material('mat2').propertyGroup('ElectrodePotential').set('dEeqdT', '0');
model.material('mat2').propertyGroup('ElectrodePotential').set('cEeqref', '0');
model.material('mat2').propertyGroup('ElectrodePotential').set('Eeq_vs_ref_exp', '-0.28 [V]');
model.material('mat2').propertyGroup('ElectrodePotential').descr('Eeq_vs_ref_exp', 'Equilibrium (open circuit) potential vs. Ag/AgCl');
model.material('mat2').propertyGroup('ElectrodePotential').set('E_ref_exp_vs_SHE', '0.197 [V]');
model.material('mat2').propertyGroup('ElectrodePotential').descr('E_ref_exp_vs_SHE', 'Reference electrode potential in experiment vs. SHE');
model.material('mat2').propertyGroup('ElectrodePotential').set('Eeq_vs_SHE', 'Eeq_vs_ref_exp+E_ref_exp_vs_SHE');
model.material('mat2').propertyGroup('ElectrodePotential').descr('Eeq_vs_SHE', 'Equilibrium (open circuit) potential vs. SHE');
model.material('mat2').propertyGroup('ElectrodePotential').addInput('concentration');
model.material('mat2').selection.geom('geom1', 2);
model.material('mat2').selection.named('uni3');

model.physics('cp').feature('ice1').set('sigmal_mat', 'userdef');
model.physics('cp').feature('ice1').set('sigmal', {'sigma' '0' '0' '0' 'sigma' '0' '0' '0' 'sigma'});
model.physics('cp').create('refel1', 'ReferenceElectrodePoint', 0);
model.physics('cp').feature('refel1').selection.set([35]);
model.physics('cp').create('imprcs1', 'ImpressedCurrentSurface', 2);
model.physics('cp').feature('imprcs1').selection.named('sel4');
model.physics('cp').feature('imprcs1').set('Eimpr', 'E_control');
model.physics('cp').feature('imprcs1').set('phisref_src', 'root.comp1.cp.phisref_refel1');
model.physics('cp').create('es1', 'ElectrodeSurface', 2);
model.physics('cp').feature('es1').selection.named('sel3');
model.physics('cp').feature('es1').feature('er1').set('ilocmat_mat', 'from_mat');
model.physics('cp').feature('es1').feature('er1').set('LimitingCurrentDensity', true);
model.physics('cp').feature('es1').feature('er1').set('ilim', 'ilim');
model.physics('cp').create('passms1', 'PassiveMetalSurface', 2);
model.physics('cp').feature('passms1').selection.named('sel6');
model.physics('cp').create('tpassms1', 'ThinPassiveMetalSurface', 2);
model.physics('cp').feature('tpassms1').selection.named('sel2');
model.physics('cp').create('infice1', 'InfiniteElectrolyte', 2);
model.physics('cp').feature('infice1').selection.set([1 2 3 5]);
model.physics('cp').feature('infice1').set('sigmalInf', 'sigma');
model.physics('cp').feature('infice1').set('SymmetryYZPlane', true);
model.physics('cp').feature('infice1').set('SymmetryXYPlane', true);
model.physics('cp').feature('init1').set('phil', 0.5);

model.mesh('mesh1').create('ftet1', 'FreeTet');
model.mesh('mesh1').feature('ftet1').selection.geom('geom1', 3);
model.mesh('mesh1').feature('ftet1').selection.set([2]);
model.mesh('mesh1').feature('ftet1').create('size1', 'Size');
model.mesh('mesh1').feature('ftet1').feature('size1').set('hauto', 2);
model.mesh('mesh1').feature('ftet1').feature('size1').set('custom', true);
model.mesh('mesh1').feature('ftet1').feature('size1').set('hmaxactive', true);
model.mesh('mesh1').feature('ftet1').feature('size1').set('hmax', 1.5);
model.mesh('mesh1').feature('ftet1').feature('size1').set('hminactive', true);
model.mesh('mesh1').feature('ftet1').feature('size1').set('hmin', 0.01);
model.mesh('mesh1').feature('ftet1').create('size2', 'Size');
model.mesh('mesh1').feature('ftet1').feature('size2').selection.geom('geom1', 2);
model.mesh('mesh1').feature('ftet1').feature('size2').selection.named('uni2');
model.mesh('mesh1').feature('ftet1').feature('size2').set('hauto', 4);
model.mesh('mesh1').feature('ftet1').create('size3', 'Size');
model.mesh('mesh1').feature('ftet1').feature('size3').selection.geom('geom1', 2);
model.mesh('mesh1').feature('ftet1').feature('size3').selection.named('sel1');
model.mesh('mesh1').feature('ftet1').feature('size3').set('hauto', 2);
model.mesh('mesh1').run('ftet1');
model.mesh('mesh1').create('ftet2', 'FreeTet');
model.mesh('mesh1').feature('ftet2').create('size1', 'Size');
model.mesh('mesh1').run('ftet2');

model.view('view2').set('transparency', false);

model.study('std1').label('Study : Coated Propeller');

model.sol.create('sol1');
model.sol('sol1').study('std1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'stat');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').feature('comp1_phil').set('scalemethod', 'manual');
model.sol('sol1').feature('v1').feature('comp1_cp_imprcs1_philimpr').set('scalemethod', 'manual');
model.sol('sol1').feature('v1').feature('comp1_cp_philinf_infice1').set('scalemethod', 'manual');
model.sol('sol1').feature('v1').feature('comp1_phil').set('scaleval', '1');
model.sol('sol1').feature('v1').feature('comp1_cp_imprcs1_philimpr').set('scaleval', '1');
model.sol('sol1').feature('v1').feature('comp1_cp_philinf_infice1').set('scaleval', '1');
model.sol('sol1').feature('v1').set('control', 'stat');
model.sol('sol1').create('s1', 'Stationary');
model.sol('sol1').feature('s1').set('stol', 1.0E-4);
model.sol('sol1').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('s1').feature('fc1').set('dtech', 'auto');
model.sol('sol1').feature('s1').feature('fc1').set('maxiter', 50);
model.sol('sol1').feature('s1').feature('fc1').set('minstep', 1.0E-6);
model.sol('sol1').feature('s1').create('d1', 'Direct');
model.sol('sol1').feature('s1').feature('d1').set('linsolver', 'pardiso');
model.sol('sol1').feature('s1').feature('d1').label('Direct (cp)');
model.sol('sol1').feature('s1').create('i1', 'Iterative');
model.sol('sol1').feature('s1').feature('i1').set('maxlinit', 1000);
model.sol('sol1').feature('s1').feature('i1').set('nlinnormuse', 'on');
model.sol('sol1').feature('s1').feature('i1').label('Algebraic Multigrid (cp)');
model.sol('sol1').feature('s1').feature('i1').create('mg1', 'Multigrid');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').set('prefun', 'saamg');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').set('maxcoarsedof', 50000);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').set('saamgcompwise', false);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').set('compactaggregation', true);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('pr').create('va1', 'Vanka');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('pr').feature('va1').set('vankavars', {'comp1_cp_philinf_infice1'});
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('po').create('va1', 'Vanka');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('po').feature('va1').set('vankavars', {'comp1_cp_philinf_infice1'});
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('cs').create('d1', 'Direct');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('cs').feature('d1').set('linsolver', 'pardiso');
model.sol('sol1').feature('s1').create('i2', 'Iterative');
model.sol('sol1').feature('s1').feature('i2').set('maxlinit', 1000);
model.sol('sol1').feature('s1').feature('i2').set('nlinnormuse', 'on');
model.sol('sol1').feature('s1').feature('i2').label('Geometric Multigrid (cp)');
model.sol('sol1').feature('s1').feature('i2').create('mg1', 'Multigrid');
model.sol('sol1').feature('s1').feature('i2').feature('mg1').feature('pr').create('va1', 'Vanka');
model.sol('sol1').feature('s1').feature('i2').feature('mg1').feature('pr').feature('va1').set('vankavars', {'comp1_cp_philinf_infice1'});
model.sol('sol1').feature('s1').feature('i2').feature('mg1').feature('po').create('va1', 'Vanka');
model.sol('sol1').feature('s1').feature('i2').feature('mg1').feature('po').feature('va1').set('vankavars', {'comp1_cp_philinf_infice1'});
model.sol('sol1').feature('s1').feature('i2').feature('mg1').feature('cs').create('d1', 'Direct');
model.sol('sol1').feature('s1').feature('i2').feature('mg1').feature('cs').feature('d1').set('linsolver', 'pardiso');
model.sol('sol1').feature('s1').feature('fc1').set('linsolver', 'd1');
model.sol('sol1').feature('s1').feature('fc1').set('dtech', 'auto');
model.sol('sol1').feature('s1').feature('fc1').set('maxiter', 50);
model.sol('sol1').feature('s1').feature('fc1').set('minstep', 1.0E-6);
model.sol('sol1').feature('s1').feature.remove('fcDef');
model.sol('sol1').attach('std1');
model.sol('sol1').runAll;

model.result.create('pg1', 'PlotGroup3D');
model.result('pg1').set('data', 'dset1');
model.result('pg1').label('Electrolyte Potential (cp)');
model.result('pg1').create('mslc1', 'Multislice');
model.result('pg1').feature('mslc1').set('expr', {'phil'});
model.result('pg1').create('str1', 'Streamline');
model.result('pg1').feature('str1').set('expr', {'cp.Ilx' 'cp.Ily' 'cp.Ilz'});
model.result('pg1').feature('str1').set('posmethod', 'start');
model.result('pg1').feature('str1').set('pointtype', 'arrow');
model.result('pg1').feature('str1').set('arrowlength', 'logarithmic');
model.result('pg1').feature('str1').set('color', 'gray');
model.result.create('pg2', 'PlotGroup3D');
model.result('pg2').set('data', 'dset1');
model.result('pg2').label('Electrolyte Current Density (cp)');
model.result('pg2').create('str1', 'Streamline');
model.result('pg2').feature('str1').set('expr', {'cp.Ilx' 'cp.Ily' 'cp.Ilz'});
model.result('pg2').feature('str1').set('posmethod', 'start');
model.result('pg2').feature('str1').set('pointtype', 'arrow');
model.result('pg2').feature('str1').set('arrowlength', 'logarithmic');
model.result('pg2').feature('str1').set('color', 'gray');
model.result('pg2').feature('str1').create('col1', 'Color');
model.result('pg2').feature('str1').feature('col1').set('expr', 'root.comp1.cp.IlMag');
model.result('pg2').create('surf1', 'Surface');
model.result('pg2').feature('surf1').set('expr', {'abs(cp.itot)'});
model.result('pg2').feature('surf1').set('inheritplot', 'str1');
model.result.create('pg3', 'PlotGroup3D');
model.result('pg3').set('data', 'dset1');
model.result('pg3').label('Electrode Potential vs. Adjacent Reference (cp)');
model.result('pg3').create('str1', 'Streamline');
model.result('pg3').feature('str1').set('expr', {'cp.Ilx' 'cp.Ily' 'cp.Ilz'});
model.result('pg3').feature('str1').set('posmethod', 'start');
model.result('pg3').feature('str1').set('pointtype', 'arrow');
model.result('pg3').feature('str1').set('arrowlength', 'logarithmic');
model.result('pg3').feature('str1').set('color', 'gray');
model.result('pg3').create('surf1', 'Surface');
model.result('pg3').feature('surf1').set('expr', {'cp.Evsref'});
model.result('pg3').create('slit1', 'SurfaceSlit');
model.result('pg3').feature('slit1').set('upexpr', 'root.comp1.cp.Evsrefu');
model.result('pg3').feature('slit1').set('downexpr', 'root.comp1.cp.Evsrefd');
model.result('pg3').feature('slit1').set('inheritplot', 'surf1');
model.result('pg1').run;
model.result('pg3').run;
model.result('pg3').set('edges', false);
model.result('pg3').set('legendpos', 'left');
model.result('pg3').run;

model.view('view2').camera.set('zoomanglefull', 1.5);
model.view('view2').camera.setIndex('position', -200, 0);
model.view('view2').camera.setIndex('position', -200, 1);
model.view('view2').camera.set('position', [-200 -200 25]);
model.view('view2').camera.set('target', [-5 15 -5]);
model.view('view2').camera.setIndex('up', 0.07, 0);
model.view('view2').camera.setIndex('up', 0.08, 1);
model.view('view2').camera.set('up', [0.07 0.08 1]);
model.view('view2').camera.set('rotationpoint', [-5 15 -5]);
model.view('view2').camera.setIndex('viewoffset', -1.3, 0);
model.view('view2').camera.set('viewoffset', [-1.3 -0.6]);
model.view('view2').set('locked', true);

model.result('pg2').run;
model.result('pg2').run;
model.result('pg2').feature('surf1').create('sel1', 'Selection');
model.result('pg2').feature('surf1').feature('sel1').selection.named('sel3');
model.result('pg2').run;
model.result('pg2').run;

model.physics('cp').create('es2', 'ElectrodeSurface', 2);
model.physics('cp').feature('es2').selection.named('sel1');
model.physics('cp').feature('es2').feature('er1').set('ilocmat_mat', 'from_mat');
model.physics('cp').feature('es2').feature('er1').set('LimitingCurrentDensity', true);
model.physics('cp').feature('es2').feature('er1').set('ilim', 'ilim');
model.physics('cp').create('tes1', 'ThinElectrodeSurface', 2);
model.physics('cp').feature('tes1').selection.named('sel2');
model.physics('cp').feature('tes1').feature('er1').set('ilocmat_mat', 'from_mat');
model.physics('cp').feature('tes1').feature('er1').set('LimitingCurrentDensity', true);
model.physics('cp').feature('tes1').feature('er1').set('ilim', 'ilim');

model.study('std1').feature('stat').set('useadvanceddisable', true);
model.study('std1').feature('stat').set('disabledphysics', {'cp/es2' 'cp/tes1'});
model.study.create('std2');
model.study('std2').create('stat', 'Stationary');
model.study('std2').feature('stat').setSolveFor('/physics/cp', true);
model.study('std2').label('Study : Uncoated Propeller');

model.sol.create('sol2');
model.sol('sol2').study('std2');
model.sol('sol2').create('st1', 'StudyStep');
model.sol('sol2').feature('st1').set('study', 'std2');
model.sol('sol2').feature('st1').set('studystep', 'stat');
model.sol('sol2').create('v1', 'Variables');
model.sol('sol2').feature('v1').feature('comp1_phil').set('scalemethod', 'manual');
model.sol('sol2').feature('v1').feature('comp1_cp_imprcs1_philimpr').set('scalemethod', 'manual');
model.sol('sol2').feature('v1').feature('comp1_cp_philinf_infice1').set('scalemethod', 'manual');
model.sol('sol2').feature('v1').feature('comp1_phil').set('scaleval', '1');
model.sol('sol2').feature('v1').feature('comp1_cp_imprcs1_philimpr').set('scaleval', '1');
model.sol('sol2').feature('v1').feature('comp1_cp_philinf_infice1').set('scaleval', '1');
model.sol('sol2').feature('v1').set('control', 'stat');
model.sol('sol2').create('s1', 'Stationary');
model.sol('sol2').feature('s1').set('stol', 1.0E-4);
model.sol('sol2').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol2').feature('s1').feature('fc1').set('dtech', 'auto');
model.sol('sol2').feature('s1').feature('fc1').set('maxiter', 50);
model.sol('sol2').feature('s1').feature('fc1').set('minstep', 1.0E-6);
model.sol('sol2').feature('s1').create('d1', 'Direct');
model.sol('sol2').feature('s1').feature('d1').set('linsolver', 'pardiso');
model.sol('sol2').feature('s1').feature('d1').label('Direct (cp)');
model.sol('sol2').feature('s1').create('i1', 'Iterative');
model.sol('sol2').feature('s1').feature('i1').set('maxlinit', 1000);
model.sol('sol2').feature('s1').feature('i1').set('nlinnormuse', 'on');
model.sol('sol2').feature('s1').feature('i1').label('Algebraic Multigrid (cp)');
model.sol('sol2').feature('s1').feature('i1').create('mg1', 'Multigrid');
model.sol('sol2').feature('s1').feature('i1').feature('mg1').set('prefun', 'saamg');
model.sol('sol2').feature('s1').feature('i1').feature('mg1').set('maxcoarsedof', 50000);
model.sol('sol2').feature('s1').feature('i1').feature('mg1').set('saamgcompwise', false);
model.sol('sol2').feature('s1').feature('i1').feature('mg1').set('compactaggregation', true);
model.sol('sol2').feature('s1').feature('i1').feature('mg1').feature('pr').create('va1', 'Vanka');
model.sol('sol2').feature('s1').feature('i1').feature('mg1').feature('pr').feature('va1').set('vankavars', {'comp1_cp_philinf_infice1'});
model.sol('sol2').feature('s1').feature('i1').feature('mg1').feature('po').create('va1', 'Vanka');
model.sol('sol2').feature('s1').feature('i1').feature('mg1').feature('po').feature('va1').set('vankavars', {'comp1_cp_philinf_infice1'});
model.sol('sol2').feature('s1').feature('i1').feature('mg1').feature('cs').create('d1', 'Direct');
model.sol('sol2').feature('s1').feature('i1').feature('mg1').feature('cs').feature('d1').set('linsolver', 'pardiso');
model.sol('sol2').feature('s1').create('i2', 'Iterative');
model.sol('sol2').feature('s1').feature('i2').set('maxlinit', 1000);
model.sol('sol2').feature('s1').feature('i2').set('nlinnormuse', 'on');
model.sol('sol2').feature('s1').feature('i2').label('Geometric Multigrid (cp)');
model.sol('sol2').feature('s1').feature('i2').create('mg1', 'Multigrid');
model.sol('sol2').feature('s1').feature('i2').feature('mg1').feature('pr').create('va1', 'Vanka');
model.sol('sol2').feature('s1').feature('i2').feature('mg1').feature('pr').feature('va1').set('vankavars', {'comp1_cp_philinf_infice1'});
model.sol('sol2').feature('s1').feature('i2').feature('mg1').feature('po').create('va1', 'Vanka');
model.sol('sol2').feature('s1').feature('i2').feature('mg1').feature('po').feature('va1').set('vankavars', {'comp1_cp_philinf_infice1'});
model.sol('sol2').feature('s1').feature('i2').feature('mg1').feature('cs').create('d1', 'Direct');
model.sol('sol2').feature('s1').feature('i2').feature('mg1').feature('cs').feature('d1').set('linsolver', 'pardiso');
model.sol('sol2').feature('s1').feature('fc1').set('linsolver', 'd1');
model.sol('sol2').feature('s1').feature('fc1').set('dtech', 'auto');
model.sol('sol2').feature('s1').feature('fc1').set('maxiter', 50);
model.sol('sol2').feature('s1').feature('fc1').set('minstep', 1.0E-6);
model.sol('sol2').feature('s1').feature.remove('fcDef');
model.sol('sol2').attach('std2');
model.sol('sol2').runAll;

model.result.create('pg4', 'PlotGroup3D');
model.result('pg4').set('data', 'dset2');
model.result('pg4').label('Electrolyte Potential (cp) 1');
model.result('pg4').create('mslc1', 'Multislice');
model.result('pg4').feature('mslc1').set('expr', {'phil'});
model.result('pg4').create('str1', 'Streamline');
model.result('pg4').feature('str1').set('expr', {'cp.Ilx' 'cp.Ily' 'cp.Ilz'});
model.result('pg4').feature('str1').set('posmethod', 'start');
model.result('pg4').feature('str1').set('pointtype', 'arrow');
model.result('pg4').feature('str1').set('arrowlength', 'logarithmic');
model.result('pg4').feature('str1').set('color', 'gray');
model.result.create('pg5', 'PlotGroup3D');
model.result('pg5').set('data', 'dset2');
model.result('pg5').label('Electrolyte Current Density (cp) 1');
model.result('pg5').create('str1', 'Streamline');
model.result('pg5').feature('str1').set('expr', {'cp.Ilx' 'cp.Ily' 'cp.Ilz'});
model.result('pg5').feature('str1').set('posmethod', 'start');
model.result('pg5').feature('str1').set('pointtype', 'arrow');
model.result('pg5').feature('str1').set('arrowlength', 'logarithmic');
model.result('pg5').feature('str1').set('color', 'gray');
model.result('pg5').feature('str1').create('col1', 'Color');
model.result('pg5').feature('str1').feature('col1').set('expr', 'root.comp1.cp.IlMag');
model.result('pg5').create('surf1', 'Surface');
model.result('pg5').feature('surf1').set('expr', {'abs(cp.itot)'});
model.result('pg5').feature('surf1').set('inheritplot', 'str1');
model.result('pg5').create('slit1', 'SurfaceSlit');
model.result('pg5').feature('slit1').set('upexpr', 'abs(root.comp1.cp.itotu)');
model.result('pg5').feature('slit1').set('downexpr', 'abs(root.comp1.cp.itotd)');
model.result('pg5').feature('slit1').set('inheritplot', 'str1');
model.result.create('pg6', 'PlotGroup3D');
model.result('pg6').set('data', 'dset2');
model.result('pg6').label('Electrode Potential vs. Adjacent Reference (cp) 1');
model.result('pg6').create('str1', 'Streamline');
model.result('pg6').feature('str1').set('expr', {'cp.Ilx' 'cp.Ily' 'cp.Ilz'});
model.result('pg6').feature('str1').set('posmethod', 'start');
model.result('pg6').feature('str1').set('pointtype', 'arrow');
model.result('pg6').feature('str1').set('arrowlength', 'logarithmic');
model.result('pg6').feature('str1').set('color', 'gray');
model.result('pg6').create('surf1', 'Surface');
model.result('pg6').feature('surf1').set('expr', {'cp.Evsref'});
model.result('pg6').create('slit1', 'SurfaceSlit');
model.result('pg6').feature('slit1').set('upexpr', 'root.comp1.cp.Evsrefu');
model.result('pg6').feature('slit1').set('downexpr', 'root.comp1.cp.Evsrefd');
model.result('pg6').feature('slit1').set('inheritplot', 'surf1');
model.result('pg4').run;
model.result('pg5').run;
model.result('pg5').run;
model.result('pg5').feature('str1').set('arrowscaleactive', true);
model.result('pg5').feature('str1').set('arrowscale', 0.5);
model.result('pg5').run;
model.result('pg5').feature('surf1').create('sel1', 'Selection');
model.result('pg5').feature('surf1').feature('sel1').selection.named('uni2');
model.result('pg5').run;
model.result('pg6').run;
model.result('pg6').set('edges', false);
model.result('pg6').set('legendpos', 'left');
model.result('pg6').run;
model.result.create('pg7', 'PlotGroup1D');
model.result('pg7').run;
model.result('pg7').label('Potential Along Keel');
model.result('pg7').set('data', 'none');
model.result('pg7').create('lngr1', 'LineGraph');
model.result('pg7').feature('lngr1').set('markerpos', 'datapoints');
model.result('pg7').feature('lngr1').set('linewidth', 'preference');
model.result('pg7').feature('lngr1').set('data', 'dset1');
model.result('pg7').feature('lngr1').selection.set([118 119]);
model.result('pg7').feature('lngr1').set('expr', 'cp.Evsref');
model.result('pg7').feature('lngr1').set('descr', 'Electrode potential vs. adjacent reference');
model.result('pg7').feature('lngr1').set('xdata', 'expr');
model.result('pg7').feature('lngr1').set('xdataexpr', 'y');
model.result('pg7').feature('lngr1').set('legend', true);
model.result('pg7').feature('lngr1').set('legendmethod', 'manual');
model.result('pg7').feature('lngr1').setIndex('legends', 'Coated propeller', 0);
model.result('pg7').feature.duplicate('lngr2', 'lngr1');
model.result('pg7').run;
model.result('pg7').feature('lngr2').set('data', 'dset2');
model.result('pg7').feature('lngr2').setIndex('legends', 'Uncoated propeller', 0);
model.result('pg7').run;
model.result('pg7').set('titletype', 'label');
model.result('pg7').run;
model.result.numerical.create('gev1', 'EvalGlobal');
model.result.numerical('gev1').set('expr', {'cp.Itot_imprcs1'});
model.result.numerical('gev1').set('descr', {'Total impressed current'});
model.result.numerical('gev1').set('unit', {'A'});
model.result.table.create('tbl1', 'Table');
model.result.table('tbl1').comments('Global Evaluation 1');
model.result.numerical('gev1').set('table', 'tbl1');
model.result.numerical('gev1').setResult;
model.result.numerical.duplicate('gev2', 'gev1');
model.result.numerical('gev2').set('data', 'dset2');
model.result.numerical('gev2').set('table', 'tbl1');
model.result.numerical('gev2').appendResult;
model.result.dataset.create('dset3', 'Solution');
model.result.dataset('dset3').selection.geom('geom1', 2);
model.result.dataset('dset3').selection.named('uni1');
model.result.dataset.create('dset4', 'Solution');
model.result.dataset('dset4').selection.geom('geom1', 2);
model.result.dataset('dset4').selection.named('sel3');
model.result.dataset.create('dset5', 'Solution');
model.result.dataset('dset5').selection.geom('geom1', 2);
model.result.dataset('dset5').selection.geom('geom1', 2);
model.result.dataset('dset5').selection.set([19 20 21 22 24 25 39 40]);
model.result.dataset.create('dset6', 'Solution');
model.result.dataset('dset6').selection.geom('geom1', 2);
model.result.dataset('dset6').selection.named('sel4');
model.result.dataset.create('dset7', 'Solution');
model.result.dataset('dset7').selection.geom('geom1', 2);
model.result.dataset('dset7').selection.named('sel5');
model.result.create('pg8', 'PlotGroup3D');
model.result('pg8').run;
model.result('pg8').set('data', 'dset3');
model.result('pg8').set('edges', false);
model.result('pg8').set('titletype', 'none');
model.result('pg8').create('surf1', 'Surface');
model.result('pg8').feature('surf1').set('titletype', 'none');
model.result('pg8').feature('surf1').set('expr', '1');
model.result('pg8').feature('surf1').set('coloring', 'uniform');
model.result('pg8').feature('surf1').set('color', 'custom');
model.result('pg8').feature('surf1').set('customcolor', [0.501960813999176 0.501960813999176 0.501960813999176]);
model.result('pg8').feature.duplicate('surf2', 'surf1');
model.result('pg8').run;
model.result('pg8').feature('surf2').set('data', 'dset4');
model.result('pg8').feature('surf2').set('customcolor', [0 0 0]);
model.result('pg8').feature.duplicate('surf3', 'surf2');
model.result('pg8').run;
model.result('pg8').feature('surf3').set('data', 'dset5');
model.result('pg8').feature('surf3').set('customcolor', [0.7529411911964417 0.7529411911964417 0.7529411911964417]);
model.result('pg8').run;
model.result('pg8').create('line1', 'Line');
model.result('pg8').feature('line1').set('titletype', 'none');
model.result('pg8').feature('line1').set('data', 'dset6');
model.result('pg8').feature('line1').set('coloring', 'uniform');
model.result('pg8').feature('line1').set('color', 'black');
model.result('pg8').feature('line1').set('expr', '1');
model.result('pg8').run;
model.result('pg8').run;
model.result('pg8').create('line2', 'Line');
model.result('pg8').feature('line2').set('titletype', 'none');
model.result('pg8').feature('line2').set('data', 'dset7');
model.result('pg8').feature('line2').set('coloring', 'uniform');
model.result('pg8').feature('line2').set('color', 'black');
model.result('pg8').feature('line2').set('expr', '1');
model.result('pg8').run;

model.view('view2').set('transparency', false);

model.result.dataset.remove('dset3');
model.result.dataset.remove('dset4');
model.result.dataset.remove('dset5');
model.result.dataset.remove('dset6');
model.result.dataset.remove('dset7');
model.result('pg1').run;

model.title('Corrosion Protection of a Ship Hull');

model.description('This example models a secondary current distribution around a ship hull using an impressed current cathodic protection (ICCP) system for protection of the shaft and propeller.');

model.mesh.clearMeshes;

model.sol('sol1').clearSolutionData;
model.sol('sol2').clearSolutionData;

model.label('ship_hull.mph');

model.modelNode.label('Components');

out = model;
