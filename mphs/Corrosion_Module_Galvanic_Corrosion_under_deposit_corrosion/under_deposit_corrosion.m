function out = model
%
% under_deposit_corrosion.m
%
% Model exported on May 26 2025, 21:27 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/Corrosion_Module/Galvanic_Corrosion');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 2);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.physics.create('cd', 'SecondaryCurrentDistribution', 'geom1');
model.physics('cd').model('comp1');

model.multiphysics.create('ndbdg1', 'NonDeformingBoundaryDeformedGeometry', 'geom1', 1);
model.multiphysics('ndbdg1').set('Echem_physics', 'cd');
model.multiphysics('ndbdg1').selection.all;
model.multiphysics.create('desdg1', 'DeformingElectrodeSurfaceDeformedGeometry', 'geom1', 1);
model.multiphysics('desdg1').set('Echem_physics', 'cd');
model.multiphysics('desdg1').selection.all;
model.multiphysics('desdg1').set('embs', '0');

model.common.create('free1', 'DeformingDomainDeformedGeometry', 'comp1');
model.common('free1').set('smoothingType', 'hyperelastic');
model.common('free1').selection.all;

model.study.create('std1');
model.study('std1').create('cdi', 'CurrentDistributionInitialization');
model.study('std1').feature('cdi').set('solnum', 'auto');
model.study('std1').feature('cdi').set('notsolnum', 'auto');
model.study('std1').feature('cdi').set('outputmap', {});
model.study('std1').feature('cdi').set('ngenAUX', '1');
model.study('std1').feature('cdi').set('goalngenAUX', '1');
model.study('std1').feature('cdi').set('ngenAUX', '1');
model.study('std1').feature('cdi').set('goalngenAUX', '1');
model.study('std1').feature('cdi').setSolveFor('/physics/cd', true);
model.study('std1').feature('cdi').setSolveFor('/multiphysics/ndbdg1', true);
model.study('std1').feature('cdi').setSolveFor('/multiphysics/desdg1', true);
model.study('std1').create('time', 'Transient');
model.study('std1').feature('time').set('initialtime', '0');
model.study('std1').feature('time').set('solnum', 'auto');
model.study('std1').feature('time').set('notsolnum', 'auto');
model.study('std1').feature('time').set('outputmap', {});
model.study('std1').feature('time').setSolveFor('/physics/cd', true);
model.study('std1').feature('time').setSolveFor('/multiphysics/ndbdg1', true);
model.study('std1').feature('time').setSolveFor('/multiphysics/desdg1', true);

model.geom('geom1').create('r1', 'Rectangle');
model.geom('geom1').feature('r1').set('size', [0.01 0.01]);
model.geom('geom1').feature('r1').set('pos', [-0.01 0]);
model.geom('geom1').run('r1');
model.geom('geom1').create('r2', 'Rectangle');
model.geom('geom1').feature('r2').set('size', {'0.01' '0.01+1e-4'});
model.geom('geom1').feature('r2').set('pos', {'0' '-1e-4'});
model.geom('geom1').run('r2');
model.geom('geom1').create('uni1', 'Union');
model.geom('geom1').feature('uni1').selection('input').set({'r1' 'r2'});
model.geom('geom1').feature('uni1').set('intbnd', false);
model.geom('geom1').run('fin');

% To import content from file, use:
% model.param.loadFile('FILENAME');
model.param.set('sigma', '2.5[S/m]', 'Electrolyte conductivity');
model.param.set('rho_Mg', '1820[kg/m^3]', 'Magnesium density');
model.param.set('M_Mg', '0.025[kg/mol]', 'Magnesium molecular weight');

model.material.create('mat1', 'Common', 'comp1');
model.material('mat1').propertyGroup.create('LocalCurrentDensity', 'Local current density');
model.material('mat1').propertyGroup('LocalCurrentDensity').func.create('int1', 'Interpolation');
model.material('mat1').propertyGroup.create('ElectrodePotential', 'Equilibrium potential');
model.material('mat1').label('Mild steel in 1.6 wt% NaCl');
model.material('mat1').propertyGroup('LocalCurrentDensity').func('int1').set('funcname', 'iloc_exp');
model.material('mat1').propertyGroup('LocalCurrentDensity').func('int1').set('table', {'-1.724995712' '-1294.81311';  ...
'-1.698596505' '-1221.153151';  ...
'-1.662264475' '-980.7098549';  ...
'-1.596238566' '-753.7166809';  ...
'-1.543398316' '-562.6316733';  ...
'-1.454159793' '-255.5659935';  ...
'-1.374861066' '-140.365249';  ...
'-1.305467272' '-80.5505944';  ...
'-1.239329798' '-38.79504171';  ...
'-1.173136541' '-14.79120785';  ...
'-1.120125456' '-5.398051399';  ...
'-1.060525028' '-2.02833023';  ...
'-0.991033613' '-0.773317276';  ...
'-0.941390414' '-0.377963209';  ...
'-0.891736755' '-0.176812853';  ...
'-0.805949793' '-0.152711324';  ...
'-0.789511301' '-0.190093365';  ...
'-0.740063341' '-0.210493637';  ...
'-0.690584004' '-0.204375322';  ...
'-0.660862235' '-0.174014568';  ...
'-0.644333096' '-0.148175442';  ...
'-0.614660136' '-0.154784845';  ...
'-0.594801462' '-0.115565489';  ...
'-0.584725695' '-0.054074545';  ...
'-0.584324756' '-0.010083353';  ...
'-0.580789522' '-0.003735135';  ...
'-0.580548958' '-0.001363558';  ...
'-0.568684656' '0.35574106';  ...
'-0.559103961' '1.324140938';  ...
'-0.552821424' '4.928818185';  ...
'-0.543167514' '13.50051829';  ...
'-0.533513605' '36.97924882';  ...
'-0.513954763' '96.94225444';  ...
'-0.448155472' '192.5056295';  ...
'-0.402141641' '376.7744582';  ...
'-0.366011823' '705.8575518';  ...
'-0.32981925' '1016.687802'});
model.material('mat1').propertyGroup('LocalCurrentDensity').func('int1').set('extrap', 'linear');
model.material('mat1').propertyGroup('LocalCurrentDensity').func('int1').set('fununit', {'A/m^2'});
model.material('mat1').propertyGroup('LocalCurrentDensity').func('int1').set('argunit', {'V'});
model.material('mat1').propertyGroup('LocalCurrentDensity').set('ilocmat', 'iloc_exp(E_vs_ref_exp)');
model.material('mat1').propertyGroup('LocalCurrentDensity').set('INFO_PREFIX:ilocmat', ['K. B. Deshpande, ' native2unicode(hex2dec({'20' '1c'}), 'unicode') 'Effect of aluminium spacer on galvanic corrosion between' newline 'magnesium and mild steel using numerical model and SVET experiments,' native2unicode(hex2dec({'20' '1d'}), 'unicode') ' Corrosion' newline 'Science, vol. 62, p. 184, 2012.']);
model.material('mat1').propertyGroup('LocalCurrentDensity').set('E_vs_SHE', 'V');
model.material('mat1').propertyGroup('LocalCurrentDensity').descr('E_vs_SHE', 'Electrode potential vs. SHE');
model.material('mat1').propertyGroup('LocalCurrentDensity').set('E_ref_exp_vs_SHE', '0.241 [V]');
model.material('mat1').propertyGroup('LocalCurrentDensity').descr('E_ref_exp_vs_SHE', 'Reference electrode potential in experiment vs. SHE');
model.material('mat1').propertyGroup('LocalCurrentDensity').set('E_vs_ref_exp', 'E_vs_SHE-E_ref_exp_vs_SHE');
model.material('mat1').propertyGroup('LocalCurrentDensity').descr('E_vs_ref_exp', 'Electrode potential vs. experimental SCE reference electrode');
model.material('mat1').propertyGroup('LocalCurrentDensity').addInput('electricpotential');
model.material('mat1').propertyGroup('ElectrodePotential').set('Eeq', 'Eeq_vs_SHE');
model.material('mat1').propertyGroup('ElectrodePotential').set('INFO_PREFIX:Eeq', ['K. B. Deshpande, ' native2unicode(hex2dec({'20' '1c'}), 'unicode') 'Effect of aluminium spacer on galvanic corrosion between' newline 'magnesium and mild steel using numerical model and SVET experiments,' native2unicode(hex2dec({'20' '1d'}), 'unicode') ' Corrosion' newline 'Science, vol. 62, p. 184, 2012.']);
model.material('mat1').propertyGroup('ElectrodePotential').set('dEeqdT', '0');
model.material('mat1').propertyGroup('ElectrodePotential').set('cEeqref', '0');
model.material('mat1').propertyGroup('ElectrodePotential').set('Eeq_vs_ref_exp', '-0.58 [V]');
model.material('mat1').propertyGroup('ElectrodePotential').descr('Eeq_vs_ref_exp', 'Equilibrium (open circuit) potential vs. SCE');
model.material('mat1').propertyGroup('ElectrodePotential').set('E_ref_exp_vs_SHE', '0.241 [V]');
model.material('mat1').propertyGroup('ElectrodePotential').descr('E_ref_exp_vs_SHE', 'Reference electrode potential in experiment vs. SHE');
model.material('mat1').propertyGroup('ElectrodePotential').set('Eeq_vs_SHE', 'Eeq_vs_ref_exp+E_ref_exp_vs_SHE');
model.material('mat1').propertyGroup('ElectrodePotential').descr('Eeq_vs_SHE', 'Equilibrium (open circuit) potential vs. SHE');
model.material('mat1').propertyGroup('ElectrodePotential').addInput('concentration');
model.material('mat1').selection.geom('geom1', 1);
model.material('mat1').selection.set([2 4]);
model.material.create('mat2', 'Common', 'comp1');
model.material('mat2').propertyGroup.create('LocalCurrentDensity', 'Local current density');
model.material('mat2').propertyGroup('LocalCurrentDensity').func.create('int1', 'Interpolation');
model.material('mat2').propertyGroup.create('ElectrodePotential', 'Equilibrium potential');
model.material('mat2').label('AE44 in 1.6 wt% NaCl');
model.material('mat2').propertyGroup('LocalCurrentDensity').func('int1').set('funcname', 'iloc_exp');
model.material('mat2').propertyGroup('LocalCurrentDensity').func('int1').set('table', {'-2.13672391' '-219.0812174';  ...
'-2.093791281' '-125.7315703';  ...
'-2.067371202' '-82.29708529';  ...
'-2.001321004' '-58.81938165';  ...
'-1.945178336' '-40.23311643';  ...
'-1.885733157' '-26.3395082';  ...
'-1.849405548' '-17.49533024';  ...
'-1.80317041' '-10.3387525';  ...
'-1.760237781' '-5.678841057';  ...
'-1.727212682' '-3.405033309';  ...
'-1.697490092' '-2.164569096';  ...
'-1.674372523' '-1.316913195';  ...
'-1.654557464' '-0.824959959';  ...
'-1.631439894' '-0.487438864';  ...
'-1.608322325' '-0.314414578';  ...
'-1.571994716' '-0.170187739';  ...
'-1.562087186' '-0.103533385';  ...
'-1.555482166' '-0.041218975';  ...
'-1.545574637' '-0.01570633';  ...
'-1.542272127' '0.040623892';  ...
'-1.542272127' '0.102042604';  ...
'-1.542272127' '0.271755509';  ...
'-1.542272127' '0.572780046';  ...
'-1.532364597' '1.155513296';  ...
'-1.525759577' '2.297229688';  ...
'-1.515852048' '4.702628735';  ...
'-1.509247028' '9.486791868';  ...
'-1.489431968' '14.92777544';  ...
'-1.476221929' '25.26969914';  ...
'-1.456406869' '40.34827744';  ...
'-1.403566711' '63.50158896';  ...
'-1.354029062' '85.09313601';  ...
'-1.301188904' '105.9904709';  ...
'-1.261558785' '120.9233936';  ...
'-1.202113606' '148.4397409';  ...
'-1.149273448' '198.9154478';  ...
'-1.099735799' '247.7606987';  ...
'-1.050198151' '286.8469856'});
model.material('mat2').propertyGroup('LocalCurrentDensity').func('int1').set('extrap', 'linear');
model.material('mat2').propertyGroup('LocalCurrentDensity').func('int1').set('fununit', {'A/m^2'});
model.material('mat2').propertyGroup('LocalCurrentDensity').func('int1').set('argunit', {'V'});
model.material('mat2').propertyGroup('LocalCurrentDensity').set('ilocmat', 'iloc_exp(E_vs_ref_exp)');
model.material('mat2').propertyGroup('LocalCurrentDensity').set('INFO_PREFIX:ilocmat', ['K. B. Deshpande, ' native2unicode(hex2dec({'20' '1c'}), 'unicode') 'Effect of aluminium spacer on galvanic corrosion between' newline 'magnesium and mild steel using numerical model and SVET experiments' native2unicode(hex2dec({'20' '1d'}), 'unicode') ', Corrosion' newline 'Science, vol. 62, p. 184, 2012.']);
model.material('mat2').propertyGroup('LocalCurrentDensity').set('E_vs_SHE', 'V');
model.material('mat2').propertyGroup('LocalCurrentDensity').descr('E_vs_SHE', 'Electrode potential vs. SHE');
model.material('mat2').propertyGroup('LocalCurrentDensity').set('E_ref_exp_vs_SHE', '0.241 [V]');
model.material('mat2').propertyGroup('LocalCurrentDensity').descr('E_ref_exp_vs_SHE', 'Reference electrode potential in experiment vs. SHE');
model.material('mat2').propertyGroup('LocalCurrentDensity').set('E_vs_ref_exp', 'E_vs_SHE-E_ref_exp_vs_SHE');
model.material('mat2').propertyGroup('LocalCurrentDensity').descr('E_vs_ref_exp', 'Electrode potential vs. experimental SCE reference electrode');
model.material('mat2').propertyGroup('LocalCurrentDensity').addInput('electricpotential');
model.material('mat2').propertyGroup('ElectrodePotential').set('Eeq', 'Eeq_vs_SHE');
model.material('mat2').propertyGroup('ElectrodePotential').set('INFO_PREFIX:Eeq', ['K. B. Deshpande, ' native2unicode(hex2dec({'20' '1c'}), 'unicode') 'Effect of aluminium spacer on galvanic corrosion between' newline 'magnesium and mild steel using numerical model and SVET experiments' native2unicode(hex2dec({'20' '1d'}), 'unicode') ', Corrosion' newline 'Science, vol. 62, p. 184, 2012.']);
model.material('mat2').propertyGroup('ElectrodePotential').set('dEeqdT', '0');
model.material('mat2').propertyGroup('ElectrodePotential').set('cEeqref', '0');
model.material('mat2').propertyGroup('ElectrodePotential').set('Eeq_vs_ref_exp', '-1.55 [V]');
model.material('mat2').propertyGroup('ElectrodePotential').descr('Eeq_vs_ref_exp', 'Equilibrium (open circuit) potential vs. SCE');
model.material('mat2').propertyGroup('ElectrodePotential').set('E_ref_exp_vs_SHE', '0.241 [V]');
model.material('mat2').propertyGroup('ElectrodePotential').descr('E_ref_exp_vs_SHE', 'Reference electrode potential in experiment vs. SHE');
model.material('mat2').propertyGroup('ElectrodePotential').set('Eeq_vs_SHE', 'Eeq_vs_ref_exp+E_ref_exp_vs_SHE');
model.material('mat2').propertyGroup('ElectrodePotential').descr('Eeq_vs_SHE', 'Equilibrium (open circuit) potential vs. SHE');
model.material('mat2').propertyGroup('ElectrodePotential').addInput('concentration');
model.material('mat2').selection.geom('geom1', 1);
model.material('mat2').selection.set([5]);

model.physics('cd').prop('PhysicsVsMaterialsReferenceElectrodePotential').set('PhysicsVsMaterialsReferenceElectrodePotential', 'SCE');
model.physics('cd').feature('ice1').set('sigmal_mat', 'userdef');
model.physics('cd').feature('ice1').set('sigmal', {'sigma' '0' '0' '0' 'sigma' '0' '0' '0' 'sigma'});
model.physics('cd').create('es1', 'ElectrodeSurface', 1);
model.physics('cd').feature('es1').selection.set([2 4]);
model.physics('cd').feature('es1').feature('er1').set('ilocmat_mat', 'from_mat');
model.physics('cd').create('es2', 'ElectrodeSurface', 1);
model.physics('cd').feature('es2').selection.set([5]);
model.physics('cd').feature('es2').setIndex('Species', 's1', 0, 0);
model.physics('cd').feature('es2').setIndex('rhos', 8960, 0, 0);
model.physics('cd').feature('es2').setIndex('Ms', 0.06355, 0, 0);
model.physics('cd').feature('es2').setIndex('Species', 's1', 0, 0);
model.physics('cd').feature('es2').setIndex('rhos', 8960, 0, 0);
model.physics('cd').feature('es2').setIndex('Ms', 0.06355, 0, 0);
model.physics('cd').feature('es2').setIndex('Species', 'Mg', 0, 0);
model.physics('cd').feature('es2').setIndex('rhos', 'rho_Mg', 0, 0);
model.physics('cd').feature('es2').setIndex('Ms', 'M_Mg', 0, 0);
model.physics('cd').feature('es2').feature('er1').set('nm', 2);
model.physics('cd').feature('es2').feature('er1').setIndex('Vib', 1, 0, 0);
model.physics('cd').feature('es2').feature('er1').set('ilocmat_mat', 'from_mat');

model.multiphysics('ndbdg1').set('BoundaryCondition', 'ZeroNormalDisplacement');
model.multiphysics('desdg1').selection.set([5]);

model.study('std1').feature('time').set('tlist', 'range(0, 12*3600, 3*24*3600)');
model.study('std1').feature('time').set('autoremesh', true);

model.sol.create('sol1');

model.mesh('mesh1').stat.selection.geom(2);
model.mesh('mesh1').stat.selection.set([1]);
model.mesh('mesh1').stat.selection.geom(2);
model.mesh('mesh1').stat.selection.set([1]);

model.sol('sol1').study('std1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'cdi');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').feature('comp1_phil').set('scalemethod', 'manual');
model.sol('sol1').feature('v1').feature('comp1_material_disp').set('scalemethod', 'manual');
model.sol('sol1').feature('v1').feature('comp1_phil').set('scaleval', '1');
model.sol('sol1').feature('v1').feature('comp1_material_disp').set('scaleval', '1.0512283291464324E-4');
model.sol('sol1').feature('v1').set('control', 'cdi');
model.sol('sol1').create('s1', 'Stationary');
model.sol('sol1').feature('s1').set('stol', 1.0E-4);
model.sol('sol1').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('s1').feature('fc1').set('dtech', 'auto');
model.sol('sol1').feature('s1').feature('fc1').set('maxiter', 50);
model.sol('sol1').feature('s1').feature('fc1').set('minstep', 1.0E-6);
model.sol('sol1').feature('s1').feature('fc1').set('linsolver', 'dDef');
model.sol('sol1').feature('s1').feature('fc1').set('dtech', 'auto');
model.sol('sol1').feature('s1').feature('fc1').set('maxiter', 50);
model.sol('sol1').feature('s1').feature('fc1').set('minstep', 1.0E-6);
model.sol('sol1').feature('s1').feature.remove('fcDef');
model.sol('sol1').create('su1', 'StoreSolution');
model.sol('sol1').create('st2', 'StudyStep');
model.sol('sol1').feature('st2').set('study', 'std1');
model.sol('sol1').feature('st2').set('studystep', 'time');
model.sol('sol1').create('v2', 'Variables');
model.sol('sol1').feature('v2').feature('comp1_phil').set('scalemethod', 'manual');
model.sol('sol1').feature('v2').feature('comp1_material_disp').set('scalemethod', 'manual');
model.sol('sol1').feature('v2').feature('comp1_phil').set('scaleval', '1');
model.sol('sol1').feature('v2').feature('comp1_material_disp').set('scaleval', '1.0512283291464324E-4');
model.sol('sol1').feature('v2').feature('comp1_material_lm_nv').set('out', 'off');
model.sol('sol1').feature('v2').set('initmethod', 'sol');
model.sol('sol1').feature('v2').set('initsol', 'sol1');
model.sol('sol1').feature('v2').set('initsoluse', 'sol2');
model.sol('sol1').feature('v2').set('notsolmethod', 'sol');
model.sol('sol1').feature('v2').set('notsol', 'sol1');
model.sol('sol1').feature('v2').set('notsoluse', 'sol2');
model.sol('sol1').feature('v2').set('control', 'time');
model.sol('sol1').create('t1', 'Time');
model.sol('sol1').feature('t1').set('tlist', 'range(0, 12*3600, 3*24*3600)');
model.sol('sol1').feature('t1').set('plot', 'off');
model.sol('sol1').feature('t1').set('plotgroup', 'Default');
model.sol('sol1').feature('t1').set('plotfreq', 'tout');
model.sol('sol1').feature('t1').set('probesel', 'all');
model.sol('sol1').feature('t1').set('probes', {});
model.sol('sol1').feature('t1').set('probefreq', 'tsteps');
model.sol('sol1').feature('t1').set('rtol', 0.001);
model.sol('sol1').feature('t1').set('atolglobalvaluemethod', 'factor');
model.sol('sol1').feature('t1').set('eventout', true);
model.sol('sol1').feature('t1').set('reacf', true);
model.sol('sol1').feature('t1').set('storeudot', true);
model.sol('sol1').feature('t1').set('endtimeinterpolation', true);
model.sol('sol1').feature('t1').set('maxorder', 2);
model.sol('sol1').feature('t1').set('control', 'time');
model.sol('sol1').feature('t1').feature('arDef').set('autoremeshgeom', 'geom1');
model.sol('sol1').feature('t1').feature('arDef').set('stopcondtype', 'quality');
model.sol('sol1').feature('t1').feature('arDef').set('stopexpr', 'comp1.material.minqual');
model.sol('sol1').feature('t1').feature('arDef').set('stopval', '0.2');
model.sol('sol1').feature('t1').feature('arDef').set('consistentremesh', 'bweuler');
model.sol('sol1').feature('t1').create('seDef', 'Segregated');
model.sol('sol1').feature('t1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('t1').feature('fc1').set('dtech', 'auto');
model.sol('sol1').feature('t1').create('d1', 'Direct');
model.sol('sol1').feature('t1').feature('d1').set('mumpsalloc', 1.4);
model.sol('sol1').feature('t1').feature('fc1').set('linsolver', 'd1');
model.sol('sol1').feature('t1').feature('fc1').set('dtech', 'auto');
model.sol('sol1').feature('t1').feature.remove('fcDef');
model.sol('sol1').feature('t1').feature.remove('seDef');
model.sol('sol1').attach('std1');
model.sol.create('sol3');
model.sol('sol3').label('Remeshed Solution 1');
model.sol('sol3').study('std1');
model.sol('sol1').feature('t1').feature('arDef').set('tadapsol', 'sol3');
model.sol('sol1').runAll;

model.result.create('pg1', 'PlotGroup2D');
model.result('pg1').set('data', 'dset3');
model.result('pg1').setIndex('looplevel', 13, 0);
model.result('pg1').label('Electrolyte Potential (cd)');
model.result('pg1').create('surf1', 'Surface');
model.result('pg1').feature('surf1').set('expr', {'phil'});
model.result('pg1').create('str1', 'Streamline');
model.result('pg1').feature('str1').set('expr', {'cd.Ilx' 'cd.Ily'});
model.result('pg1').feature('str1').set('posmethod', 'uniform');
model.result('pg1').feature('str1').set('recover', 'pprint');
model.result('pg1').feature('str1').set('pointtype', 'arrow');
model.result('pg1').feature('str1').set('arrowlength', 'logarithmic');
model.result('pg1').feature('str1').set('color', 'gray');
model.result.create('pg2', 'PlotGroup2D');
model.result('pg2').set('data', 'dset3');
model.result('pg2').setIndex('looplevel', 13, 0);
model.result('pg2').label('Electrolyte Current Density (cd)');
model.result('pg2').create('str1', 'Streamline');
model.result('pg2').feature('str1').set('expr', {'cd.Ilx' 'cd.Ily'});
model.result('pg2').feature('str1').set('posmethod', 'uniform');
model.result('pg2').feature('str1').set('recover', 'pprint');
model.result('pg2').feature('str1').set('pointtype', 'arrow');
model.result('pg2').feature('str1').set('arrowlength', 'logarithmic');
model.result('pg2').feature('str1').set('color', 'gray');
model.result('pg2').feature('str1').create('col1', 'Color');
model.result('pg2').feature('str1').feature('col1').set('expr', 'root.comp1.cd.IlMag');
model.result('pg2').create('line1', 'Line');
model.result('pg2').feature('line1').set('expr', {'abs(cd.itot)'});
model.result('pg2').feature('line1').set('linetype', 'tube');
model.result('pg2').feature('line1').set('inherittubescale', false);
model.result('pg2').feature('line1').set('inheritplot', 'str1');
model.result.create('pg3', 'PlotGroup2D');
model.result('pg3').set('data', 'dset3');
model.result('pg3').setIndex('looplevel', 13, 0);
model.result('pg3').label('Electrode Potential vs. Adjacent Reference (cd)');
model.result('pg3').create('str1', 'Streamline');
model.result('pg3').feature('str1').set('expr', {'cd.Ilx' 'cd.Ily'});
model.result('pg3').feature('str1').set('posmethod', 'uniform');
model.result('pg3').feature('str1').set('recover', 'pprint');
model.result('pg3').feature('str1').set('pointtype', 'arrow');
model.result('pg3').feature('str1').set('arrowlength', 'logarithmic');
model.result('pg3').feature('str1').set('color', 'gray');
model.result('pg3').create('line1', 'Line');
model.result('pg3').feature('line1').set('expr', {'cd.Evsref'});
model.result('pg3').feature('line1').set('linetype', 'tube');
model.result('pg3').feature('line1').set('inherittubescale', false);
model.result.create('pg4', 'PlotGroup2D');
model.result('pg4').set('data', 'dset3');
model.result('pg4').setIndex('looplevel', 13, 0);
model.result('pg4').label('Total Electrode Thickness Change (cd)');
model.result('pg4').create('line1', 'Line');
model.result('pg4').feature('line1').set('expr', {'cd.sbtot'});
model.result('pg4').feature('line1').set('linetype', 'tube');
model.result('pg4').feature('line1').set('inherittubescale', false);
model.result('pg4').feature('line1').set('unit', [native2unicode(hex2dec({'00' 'b5'}), 'unicode') 'm']);
model.result.create('pg5', 'PlotGroup2D');
model.result('pg5').set('data', 'dset3');
model.result('pg5').setIndex('looplevel', 13, 0);
model.result('pg5').label('Deformed Geometry');
model.result('pg5').create('mesh1', 'Mesh');
model.result('pg5').feature('mesh1').set('meshdomain', 'surface');
model.result('pg5').feature('mesh1').set('colortable', 'TrafficFlow');
model.result('pg5').feature('mesh1').set('colortabletrans', 'nonlinear');
model.result('pg5').feature('mesh1').set('nonlinearcolortablerev', true);
model.result('pg5').feature('mesh1').create('sel1', 'MeshSelection');
model.result('pg5').feature('mesh1').feature('sel1').selection.set([1]);
model.result('pg5').feature('mesh1').set('qualmeasure', 'custom');
model.result('pg5').feature('mesh1').set('qualexpr', 'comp1.material.relVol');
model.result('pg5').feature('mesh1').set('colorrangeunitinterval', false);
model.result('pg1').run;
model.result('pg1').set('edges', false);
model.result('pg1').create('line1', 'Line');
model.result('pg1').feature('line1').set('expr', '1');
model.result('pg1').feature('line1').set('coloring', 'uniform');
model.result('pg1').feature('line1').set('color', 'black');
model.result('pg1').run;
model.result('pg1').run;
model.result('pg1').set('looplevel', [1]);
model.result('pg1').run;
model.result.create('pg6', 'PlotGroup1D');
model.result('pg6').run;
model.result('pg6').create('lngr1', 'LineGraph');
model.result('pg6').feature('lngr1').set('markerpos', 'datapoints');
model.result('pg6').feature('lngr1').set('linewidth', 'preference');
model.result('pg6').feature('lngr1').set('data', 'dset3');
model.result('pg6').feature('lngr1').setIndex('looplevelinput', 'first', 0);
model.result('pg6').feature('lngr1').selection.set([2 4 5]);
model.result('pg6').feature('lngr1').set('expr', 'cd.iloc_er1');
model.result('pg6').feature('lngr1').set('descr', 'Local current density');
model.result('pg6').feature('lngr1').set('xdata', 'expr');
model.result('pg6').feature('lngr1').set('xdataexpr', 'x');
model.result('pg6').feature('lngr1').set('legend', true);
model.result('pg6').feature('lngr1').set('legendmethod', 'manual');
model.result('pg6').feature('lngr1').setIndex('legends', 't=0 h', 0);
model.result('pg6').feature.duplicate('lngr2', 'lngr1');
model.result('pg6').run;
model.result('pg6').feature('lngr2').setIndex('looplevelinput', 'last', 0);
model.result('pg6').feature('lngr2').set('titletype', 'none');
model.result('pg6').feature('lngr2').setIndex('legends', 't=72 h', 0);
model.result('pg6').run;

model.title('Galvanic Corrosion with Electrode Deformation');

model.description(['This example demonstrates how to model a galvanic couple in which the corrosion of the anode causes a geometry deformation.' newline  newline 'The parameter data used is for a Magnesium Alloy (AE44)/mild steel couple in brine solution (salt water).' newline  newline 'The model is in 2D.']);

model.label('galvanic_corrosion_with_deformation.mph');

model.result('pg6').run;

model.physics.create('tds', 'DilutedSpecies', 'geom1', {'cMg' 'cOH'});

model.study('std1').feature('cdi').setSolveFor('/physics/tds', true);
model.study('std1').feature('time').setSolveFor('/physics/tds', true);

model.physics('tds').selection.set([]);
model.physics.create('ls', 'LevelSet', 'geom1');
model.physics('ls').model('comp1');

model.study('std1').feature('cdi').setSolveFor('/physics/ls', true);
model.study('std1').feature('time').setSolveFor('/physics/ls', true);

model.physics('ls').selection.set([]);

% To import content from file, use:
% model.param.loadFile('FILENAME');
model.param.set('DMg', '7.05e-10[m^2/s]', 'Diffusion coefficient of Mg ions');
model.param.set('DOH', '5.27e-9[m^2/s]', 'Diffusion coefficient of OH ions');
model.param.set('cOH0', '1e-4[mol/m^3]', 'Initial concentration of OH ions');
model.param.set('cMg0', '0[mol/m^3]', 'Initial concentration of Mg ions');
model.param.set('ksp', '0.45[mol^3/m^9]', 'Solution product constant of Mg(OH)2');
model.param.set('k', '3.7e-7[m^7/mol^2/s]', 'Precipitation reaction rate constant of Mg(OH)2');
model.param.set('Tau', '1', 'Effective diffusivity factor');
model.param.set('sL', '1', 'Fluid saturation');
model.param.set('m', '1', 'Cementation exponent');
model.param.set('n', '2', 'Saturation coefficient');
model.param.set('M_MgOH2', '0.058[kg/mol]', 'Molecular weight of Mg(OH)2');
model.param.set('rho_MgOH2', '2450[kg/m^3]', 'Density of Mg(OH)2');
model.param.set('epsilon', '0.55', 'Porosity of corrosion product deposits');
model.param.set('N_Mac', 'Tau/epsilon', 'MacMullin number');
model.param.set('DMge', 'DMg*(1-epsilon)+DMg*epsilon/N_Mac', 'Effective diffusion coefficient of Mg ions');
model.param.set('DOHe', 'DOH*(1-epsilon)+DOH*epsilon/N_Mac', 'Effective diffusion coefficient of OH ions');
model.param.set('sigmae', 'sigma*sL^m*epsilon^n', 'Effective electrolyte conductivity');

model.func.create('step1', 'Step');
model.func('step1').model('comp1');
model.func('step1').set('smooth', 0.001);

model.variable.create('var1');
model.variable('var1').model('comp1');

% To import content from file, use:
% model.variable('var1').loadFile('FILENAME');
model.variable('var1').set('step_variable', '(max(cMg,eps)*max(cOH,eps)^2/ksp)-1', 'Step variable for precipitation reaction');
model.variable('var1').set('R_MgOH2', 'k*(max(cMg,eps)*(max(cOH,eps))^2-ksp)*step1(step_variable)', 'Precipitation reaction rate');
model.variable('var1').set('R_Mg', 'R_MgOH2', 'Reaction rate of Mg ions');
model.variable('var1').set('R_OH', '2*R_MgOH2', 'Reaction rate of OH ions');
model.variable('var1').set('vn_corprod', 'R_MgOH2*M_MgOH2/rho_MgOH2', 'Corrosion product velocity');
model.variable('var1').set('u_corprod', 'vn_corprod*ls.intnormx*step1(0.6-phils)', 'Corrosion product velocity, x-component');
model.variable('var1').set('v_corprod', 'max(vn_corprod*ls.intnormy+genext1(cd.vn*cd.ny),eps)*step1(0.6-phils)', 'Corrosion product velocity, y-component');

model.cpl.create('genext1', 'GeneralExtrusion', 'geom1');
model.cpl('genext1').selection.geom('geom1', 1);
model.cpl('genext1').selection.set([5]);
model.cpl('genext1').set('dstmap', {'x' ''});
model.cpl('genext1').set('srcframe', 'mesh');
model.cpl('genext1').set('usesrcmap', true);
model.cpl('genext1').set('srcmap', {'x' ''});
model.cpl('genext1').set('method', 'closest');

model.physics('tds').prop('TransportMechanism').set('Convection', false);
model.physics('tds').prop('TransportMechanism').set('Migration', true);
model.physics('tds').selection.set([1]);
model.physics('tds').feature('sp1').setIndex('z', 2, 0);
model.physics('tds').feature('sp1').setIndex('z', -1, 1);
model.physics('tds').feature('cdm1').set('D_cMg', {'DMg*ls.Vf2+DMge*ls.Vf1' '0' '0' '0' 'DMg*ls.Vf2+DMge*ls.Vf1' '0' '0' '0' 'DMg*ls.Vf2+DMge*ls.Vf1'});
model.physics('tds').feature('cdm1').set('D_cOH', {'DOH*ls.Vf2+DOHe*ls.Vf1' '0' '0' '0' 'DOH*ls.Vf2+DOHe*ls.Vf1' '0' '0' '0' 'DOH*ls.Vf2+DOHe*ls.Vf1'});
model.physics('tds').feature('cdm1').set('V', 'phil');
model.physics('tds').feature('init1').setIndex('initc', 'cOH0', 1);
model.physics('tds').create('reac1', 'Reactions', 2);
model.physics('tds').feature('reac1').selection.set([1]);
model.physics('tds').feature('reac1').setIndex('R_cMg', '-R_Mg*ls.delta', 0);
model.physics('tds').feature('reac1').setIndex('R_cOH', '-R_OH*ls.delta', 0);
model.physics('tds').create('conc1', 'Concentration', 1);
model.physics('tds').feature('conc1').selection.set([3 6]);
model.physics('tds').feature('conc1').setIndex('species', true, 1);
model.physics('tds').feature('conc1').setIndex('c0', 'cOH0', 1);
model.physics('tds').create('eeic1', 'ElectrodeElectrolyteInterfaceCoupling', 1);
model.physics('tds').feature('eeic1').selection.set([2 4]);
model.physics('tds').feature('eeic1').feature('rc1').set('iloc_src', 'root.comp1.cd.es1.er1.iloc');
model.physics('tds').feature('eeic1').feature('rc1').set('nm', 4);
model.physics('tds').feature('eeic1').feature('rc1').setIndex('Vib', 4, 1);
model.physics('tds').create('eeic2', 'ElectrodeElectrolyteInterfaceCoupling', 1);
model.physics('tds').feature('eeic2').selection.set([5]);
model.physics('tds').feature('eeic2').feature('rc1').set('iloc_src', 'root.comp1.cd.es2.er1.iloc');
model.physics('tds').feature('eeic2').feature('rc1').set('nm', 2);
model.physics('tds').feature('eeic2').feature('rc1').setIndex('Vib', -1, 0);
model.physics('ls').selection.set([1]);
model.physics('ls').feature('lsm1').set('gamma', 'max(vn_corprod,eps)');
model.physics('ls').feature('lsm1').set('epsilon_ls', 'ls.hmax/4');
model.physics('ls').feature('lsm1').set('u', {'u_corprod' 'v_corprod' '0'});
model.physics('ls').feature('init1').set('FluidInDomain', 'Fluid2phils');
model.physics('ls').create('inl1', 'InletBoundary', 1);
model.physics('ls').feature('inl1').selection.set([2 4 5]);
model.physics('ls').create('out1', 'Outlet', 1);
model.physics('ls').feature('out1').selection.set([1 3 6 7]);
model.physics('cd').feature('ice1').set('sigmal', {'sigma*ls.Vf2+sigmae*ls.Vf1' '0' '0' '0' 'sigma*ls.Vf2+sigmae*ls.Vf1' '0' '0' '0' 'sigma*ls.Vf2+sigmae*ls.Vf1'});

model.mesh('mesh1').automatic(false);
model.mesh('mesh1').feature('size').set('table', 'cfd');
model.mesh('mesh1').feature('size').set('hauto', 3);
model.mesh('mesh1').feature('size1').set('table', 'cfd');
model.mesh('mesh1').feature('ftri1').create('size1', 'Size');
model.mesh('mesh1').feature('ftri1').feature('size1').selection.geom('geom1', 1);
model.mesh('mesh1').feature('ftri1').feature('size1').selection.set([2 5]);
model.mesh('mesh1').feature('ftri1').feature('size1').set('table', 'cfd');
model.mesh('mesh1').feature('ftri1').feature('size1').set('hauto', 1);
model.mesh('mesh1').run;

model.study('std1').feature('cdi').setEntry('activate', 'frame:material1', false);

model.mesh('mesh1').stat.selection.geom(2);
model.mesh('mesh1').stat.selection.set([1]);
model.mesh('mesh1').stat.selection.geom(2);
model.mesh('mesh1').stat.selection.set([1]);
model.mesh('mesh1').stat.selection.geom(2);
model.mesh('mesh1').stat.selection.set([1]);
model.mesh('mesh1').stat.selection.geom(2);
model.mesh('mesh1').stat.selection.set([1]);

model.sol('sol1').study('std1');

model.geom('autodeform3').feature('frommesh3').set('outertype', 'none');
model.geom('autodeform3').feature('frommesh3').set('solvertype', 'solnum');
model.geom('autodeform3').feature('frommesh3').set('touchprop', true);
model.geom('autodeform2').feature('frommesh2').set('outertype', 'none');
model.geom('autodeform2').feature('frommesh2').set('solvertype', 'solnum');
model.geom('autodeform2').feature('frommesh2').set('touchprop', true);
model.geom('autodeform1').feature('frommesh1').set('outertype', 'none');
model.geom('autodeform1').feature('frommesh1').set('solvertype', 'solnum');
model.geom('autodeform1').feature('frommesh1').set('touchprop', true);

model.sol('sol2').copySolution('sol4');

model.study('std1').feature('time').set('notlistsolnum', 1);
model.study('std1').feature('time').set('notsolnum', 'auto');
model.study('std1').feature('time').set('listsolnum', 1);
model.study('std1').feature('time').set('solnum', 'auto');
model.study('std1').feature('time').set('notlistsolnum', 1);
model.study('std1').feature('time').set('notsolnum', 'auto');
model.study('std1').feature('time').set('listsolnum', 1);
model.study('std1').feature('time').set('solnum', 'auto');

model.result.dataset('dset2').set('solution', 'none');

model.sol('sol1').feature.remove('t1');
model.sol('sol1').feature.remove('v2');
model.sol('sol1').feature.remove('st2');
model.sol('sol1').feature.remove('su1');
model.sol('sol1').feature.remove('s1');
model.sol('sol1').feature.remove('v1');
model.sol('sol1').feature.remove('st1');
model.sol('sol4').copySolution('sol2');
model.sol.remove('sol4');
model.sol('sol2').label('Solution Store 1');

model.result.dataset.remove('dset5');

model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'cdi');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').feature('comp1_phil').set('scalemethod', 'manual');
model.sol('sol1').feature('v1').feature('comp1_material_disp').set('scalemethod', 'manual');
model.sol('sol1').feature('v1').feature('comp1_phil').set('scaleval', '1');
model.sol('sol1').feature('v1').feature('comp1_material_disp').set('scaleval', '6.366057649754673E-5');
model.sol('sol1').feature('v1').set('control', 'cdi');
model.sol('sol1').create('s1', 'Stationary');
model.sol('sol1').feature('s1').set('stol', 1.0E-4);
model.sol('sol1').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('s1').feature('fc1').set('dtech', 'auto');
model.sol('sol1').feature('s1').feature('fc1').set('maxiter', 50);
model.sol('sol1').feature('s1').feature('fc1').set('minstep', 1.0E-6);
model.sol('sol1').feature('s1').feature('fc1').set('linsolver', 'dDef');
model.sol('sol1').feature('s1').feature('fc1').set('dtech', 'auto');
model.sol('sol1').feature('s1').feature('fc1').set('maxiter', 50);
model.sol('sol1').feature('s1').feature('fc1').set('minstep', 1.0E-6);
model.sol('sol1').feature('s1').feature.remove('fcDef');
model.sol('sol1').create('su1', 'StoreSolution');
model.sol('sol1').feature('su1').set('sol', 'sol2');
model.sol('sol1').feature('su1').label('Solution Store 1');
model.sol('sol1').create('st2', 'StudyStep');
model.sol('sol1').feature('st2').set('study', 'std1');
model.sol('sol1').feature('st2').set('studystep', 'time');

model.study('std1').feature('time').set('notsoluse', 'sol2');
model.study('std1').feature('time').set('initsoluse', 'sol2');

model.sol('sol1').create('v2', 'Variables');
model.sol('sol1').feature('v2').feature('comp1_phil').set('scalemethod', 'manual');
model.sol('sol1').feature('v2').feature('comp1_material_disp').set('scalemethod', 'manual');
model.sol('sol1').feature('v2').feature('comp1_phils').set('scalemethod', 'manual');
model.sol('sol1').feature('v2').feature('comp1_phil').set('scaleval', '1');
model.sol('sol1').feature('v2').feature('comp1_material_disp').set('scaleval', '6.366057649754673E-5');
model.sol('sol1').feature('v2').feature('comp1_phils').set('scaleval', '1');
model.sol('sol1').feature('v2').feature('comp1_material_lm_nv').set('out', 'off');
model.sol('sol1').feature('v2').set('initmethod', 'sol');
model.sol('sol1').feature('v2').set('initsol', 'sol1');
model.sol('sol1').feature('v2').set('initsoluse', 'sol2');
model.sol('sol1').feature('v2').set('notsolmethod', 'sol');
model.sol('sol1').feature('v2').set('notsol', 'sol1');
model.sol('sol1').feature('v2').set('control', 'time');
model.sol('sol1').create('t1', 'Time');
model.sol('sol1').feature('t1').set('tlist', 'range(0, 12*3600, 3*24*3600)');
model.sol('sol1').feature('t1').set('plot', 'off');
model.sol('sol1').feature('t1').set('plotgroup', 'pg1');
model.sol('sol1').feature('t1').set('plotfreq', 'tout');
model.sol('sol1').feature('t1').set('probesel', 'all');
model.sol('sol1').feature('t1').set('probes', {});
model.sol('sol1').feature('t1').set('probefreq', 'tsteps');
model.sol('sol1').feature('t1').set('rtol', 0.001);
model.sol('sol1').feature('t1').set('atolglobalvaluemethod', 'factor');
model.sol('sol1').feature('t1').set('atolmethod', {'comp1_cd_es2_c' 'global' 'comp1_cMg' 'global' 'comp1_cOH' 'global' 'comp1_GI' 'global' 'comp1_material_disp' 'global'  ...
'comp1_material_lm_nv' 'global' 'comp1_phil' 'global' 'comp1_phils' 'scaled'});
model.sol('sol1').feature('t1').set('atolvaluemethod', {'comp1_cd_es2_c' 'factor' 'comp1_cMg' 'factor' 'comp1_cOH' 'factor' 'comp1_GI' 'factor' 'comp1_material_disp' 'factor'  ...
'comp1_material_lm_nv' 'factor' 'comp1_phil' 'factor' 'comp1_phils' 'factor'});
model.sol('sol1').feature('t1').set('atolfactor', {'comp1_cd_es2_c' '0.1' 'comp1_cMg' '0.1' 'comp1_cOH' '0.1' 'comp1_GI' '0.1' 'comp1_material_disp' '0.1'  ...
'comp1_material_lm_nv' '0.1' 'comp1_phil' '0.1' 'comp1_phils' '0.01'});
model.sol('sol1').feature('t1').set('eventout', true);
model.sol('sol1').feature('t1').set('reacf', true);
model.sol('sol1').feature('t1').set('storeudot', true);
model.sol('sol1').feature('t1').set('endtimeinterpolation', true);
model.sol('sol1').feature('t1').set('maxorder', 2);
model.sol('sol1').feature('t1').set('stabcntrl', true);
model.sol('sol1').feature('t1').set('control', 'time');
model.sol('sol1').feature('t1').feature('arDef').set('autoremeshgeom', 'geom1');
model.sol('sol1').feature('t1').feature('arDef').set('tadapsol', 'sol3');
model.sol('sol1').feature('t1').feature('arDef').set('tadapmesh', {'mesh2' 'mesh3' 'mesh4'});
model.sol('sol1').feature('t1').feature('arDef').set('stopcondtype', 'quality');
model.sol('sol1').feature('t1').feature('arDef').set('stopexpr', 'comp1.material.minqual');
model.sol('sol1').feature('t1').feature('arDef').set('stopval', '0.2');
model.sol('sol1').feature('t1').feature('arDef').set('consistentremesh', 'bweuler');
model.sol('sol1').feature('t1').feature('aDef').set('cachepattern', true);
model.sol('sol1').feature('t1').create('seDef', 'Segregated');
model.sol('sol1').feature('t1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('t1').feature('fc1').set('dtech', 'auto');
model.sol('sol1').feature('t1').feature('fc1').set('stabacc', 'aacc');
model.sol('sol1').feature('t1').feature('fc1').set('aaccdim', 5);
model.sol('sol1').feature('t1').feature('fc1').set('aaccdelay', 0);
model.sol('sol1').feature('t1').feature('fc1').set('aaccmix', 0.9);
model.sol('sol1').feature('t1').feature('fc1').set('maxiter', 8);
model.sol('sol1').feature('t1').feature('fc1').set('damp', 0.9);
model.sol('sol1').feature('t1').feature('fc1').set('jtech', 'once');
model.sol('sol1').feature('t1').create('d1', 'Direct');
model.sol('sol1').feature('t1').feature('d1').set('mumpsalloc', 1.2);
model.sol('sol1').feature('t1').feature('d1').set('linsolver', 'mumps');
model.sol('sol1').feature('t1').feature('d1').set('pivotperturb', 1.0E-13);
model.sol('sol1').feature('t1').create('i1', 'Iterative');
model.sol('sol1').feature('t1').feature('i1').set('linsolver', 'gmres');
model.sol('sol1').feature('t1').feature('i1').set('prefuntype', 'left');
model.sol('sol1').feature('t1').feature('i1').set('itrestart', 50);
model.sol('sol1').feature('t1').feature('i1').set('rhob', 400);
model.sol('sol1').feature('t1').feature('i1').set('maxlinit', 50);
model.sol('sol1').feature('t1').feature('i1').set('nlinnormuse', 'on');
model.sol('sol1').feature('t1').feature('i1').label('AMG, concentrations (tds)');
model.sol('sol1').feature('t1').feature('i1').create('mg1', 'Multigrid');
model.sol('sol1').feature('t1').feature('i1').feature('mg1').set('prefun', 'saamg');
model.sol('sol1').feature('t1').feature('i1').feature('mg1').set('mgcycle', 'v');
model.sol('sol1').feature('t1').feature('i1').feature('mg1').set('maxcoarsedof', 50000);
model.sol('sol1').feature('t1').feature('i1').feature('mg1').set('strconn', 0.01);
model.sol('sol1').feature('t1').feature('i1').feature('mg1').set('nullspace', 'constant');
model.sol('sol1').feature('t1').feature('i1').feature('mg1').set('usesmooth', false);
model.sol('sol1').feature('t1').feature('i1').feature('mg1').set('saamgcompwise', true);
model.sol('sol1').feature('t1').feature('i1').feature('mg1').set('loweramg', true);
model.sol('sol1').feature('t1').feature('i1').feature('mg1').set('compactaggregation', false);
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('pr').create('sl1', 'SORLine');
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('pr').feature('sl1').set('linesweeptype', 'ssor');
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('pr').feature('sl1').set('iter', 1);
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('pr').feature('sl1').set('linerelax', 0.7);
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('pr').feature('sl1').set('linealgorithm', 'mesh');
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('pr').feature('sl1').set('linemethod', 'coupled');
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('pr').feature('sl1').set('seconditer', 1);
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('pr').feature('sl1').set('relax', 0.5);
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('po').create('sl1', 'SORLine');
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('po').feature('sl1').set('linesweeptype', 'ssor');
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('po').feature('sl1').set('iter', 1);
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('po').feature('sl1').set('linerelax', 0.7);
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('po').feature('sl1').set('linealgorithm', 'mesh');
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('po').feature('sl1').set('linemethod', 'coupled');
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('po').feature('sl1').set('seconditer', 1);
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('po').feature('sl1').set('relax', 0.5);
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('cs').create('d1', 'Direct');
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('cs').feature('d1').set('linsolver', 'pardiso');
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('cs').feature('d1').set('pivotperturb', 1.0E-13);
model.sol('sol1').feature('t1').create('i2', 'Iterative');
model.sol('sol1').feature('t1').feature('i2').set('linsolver', 'gmres');
model.sol('sol1').feature('t1').feature('i2').set('prefuntype', 'left');
model.sol('sol1').feature('t1').feature('i2').set('itrestart', 50);
model.sol('sol1').feature('t1').feature('i2').set('rhob', 20);
model.sol('sol1').feature('t1').feature('i2').set('maxlinit', 50);
model.sol('sol1').feature('t1').feature('i2').set('nlinnormuse', 'on');
model.sol('sol1').feature('t1').feature('i2').label('AMG, level set variable (ls)');
model.sol('sol1').feature('t1').feature('i2').create('mg1', 'Multigrid');
model.sol('sol1').feature('t1').feature('i2').feature('mg1').set('prefun', 'saamg');
model.sol('sol1').feature('t1').feature('i2').feature('mg1').set('mgcycle', 'v');
model.sol('sol1').feature('t1').feature('i2').feature('mg1').set('maxcoarsedof', 50000);
model.sol('sol1').feature('t1').feature('i2').feature('mg1').set('strconn', 0.01);
model.sol('sol1').feature('t1').feature('i2').feature('mg1').set('nullspace', 'constant');
model.sol('sol1').feature('t1').feature('i2').feature('mg1').set('usesmooth', false);
model.sol('sol1').feature('t1').feature('i2').feature('mg1').set('saamgcompwise', true);
model.sol('sol1').feature('t1').feature('i2').feature('mg1').set('loweramg', true);
model.sol('sol1').feature('t1').feature('i2').feature('mg1').set('compactaggregation', false);
model.sol('sol1').feature('t1').feature('i2').feature('mg1').feature('pr').create('sl1', 'SORLine');
model.sol('sol1').feature('t1').feature('i2').feature('mg1').feature('pr').feature('sl1').set('linesweeptype', 'ssor');
model.sol('sol1').feature('t1').feature('i2').feature('mg1').feature('pr').feature('sl1').set('iter', 1);
model.sol('sol1').feature('t1').feature('i2').feature('mg1').feature('pr').feature('sl1').set('linerelax', 0.7);
model.sol('sol1').feature('t1').feature('i2').feature('mg1').feature('pr').feature('sl1').set('linealgorithm', 'mesh');
model.sol('sol1').feature('t1').feature('i2').feature('mg1').feature('pr').feature('sl1').set('linemethod', 'coupled');
model.sol('sol1').feature('t1').feature('i2').feature('mg1').feature('pr').feature('sl1').set('seconditer', 1);
model.sol('sol1').feature('t1').feature('i2').feature('mg1').feature('pr').feature('sl1').set('relax', 0.5);
model.sol('sol1').feature('t1').feature('i2').feature('mg1').feature('po').create('sl1', 'SORLine');
model.sol('sol1').feature('t1').feature('i2').feature('mg1').feature('po').feature('sl1').set('linesweeptype', 'ssor');
model.sol('sol1').feature('t1').feature('i2').feature('mg1').feature('po').feature('sl1').set('iter', 1);
model.sol('sol1').feature('t1').feature('i2').feature('mg1').feature('po').feature('sl1').set('linerelax', 0.7);
model.sol('sol1').feature('t1').feature('i2').feature('mg1').feature('po').feature('sl1').set('linealgorithm', 'mesh');
model.sol('sol1').feature('t1').feature('i2').feature('mg1').feature('po').feature('sl1').set('linemethod', 'coupled');
model.sol('sol1').feature('t1').feature('i2').feature('mg1').feature('po').feature('sl1').set('seconditer', 1);
model.sol('sol1').feature('t1').feature('i2').feature('mg1').feature('po').feature('sl1').set('relax', 0.5);
model.sol('sol1').feature('t1').feature('i2').feature('mg1').feature('cs').create('d1', 'Direct');
model.sol('sol1').feature('t1').feature('i2').feature('mg1').feature('cs').feature('d1').set('linsolver', 'pardiso');
model.sol('sol1').feature('t1').feature('i2').feature('mg1').feature('cs').feature('d1').set('pivotperturb', 1.0E-13);
model.sol('sol1').feature('t1').feature('fc1').set('linsolver', 'd1');
model.sol('sol1').feature('t1').feature('fc1').set('dtech', 'auto');
model.sol('sol1').feature('t1').feature('fc1').set('stabacc', 'aacc');
model.sol('sol1').feature('t1').feature('fc1').set('aaccdim', 5);
model.sol('sol1').feature('t1').feature('fc1').set('aaccdelay', 0);
model.sol('sol1').feature('t1').feature('fc1').set('aaccmix', 0.9);
model.sol('sol1').feature('t1').feature('fc1').set('maxiter', 8);
model.sol('sol1').feature('t1').feature('fc1').set('damp', 0.9);
model.sol('sol1').feature('t1').feature('fc1').set('jtech', 'once');
model.sol('sol1').feature('t1').feature.remove('fcDef');
model.sol('sol1').feature('t1').feature.remove('seDef');

model.result.dataset('dset2').set('solution', 'sol2');

model.geom('autodeform3').feature('frommesh3').set('outertype', 'none');
model.geom('autodeform3').feature('frommesh3').set('solvertype', 'solnum');
model.geom('autodeform3').feature('frommesh3').set('touchprop', false);
model.geom('autodeform2').feature('frommesh2').set('outertype', 'none');
model.geom('autodeform2').feature('frommesh2').set('solvertype', 'solnum');
model.geom('autodeform2').feature('frommesh2').set('touchprop', false);
model.geom('autodeform1').feature('frommesh1').set('outertype', 'none');
model.geom('autodeform1').feature('frommesh1').set('solvertype', 'solnum');
model.geom('autodeform1').feature('frommesh1').set('touchprop', false);

model.sol('sol1').attach('std1');
model.sol('sol1').runAll;

model.result('pg1').run;
model.result('pg1').run;
model.result('pg1').run;
model.result('pg1').feature('str1').set('udist', 0.035);
model.result('pg1').feature('str1').set('arrowlength', 'normalized');
model.result('pg1').run;
model.result('pg1').create('surf2', 'Surface');
model.result('pg1').feature('surf2').set('expr', '1');
model.result('pg1').feature('surf2').set('coloring', 'uniform');
model.result('pg1').feature('surf2').set('color', 'gray');
model.result('pg1').feature('surf2').create('filt1', 'Filter');
model.result('pg1').run;
model.result('pg1').feature('surf2').feature('filt1').set('expr', 'ls.Vf1>=0.5');
model.result('pg1').run;
model.result('pg1').run;
model.result('pg1').set('looplevel', [15]);
model.result('pg1').run;
model.result('pg6').run;
model.result('pg6').feature('lngr1').setIndex('looplevelinput', 'manual', 0);
model.result('pg6').feature('lngr1').setIndex('looplevel', [1], 0);
model.result('pg6').run;
model.result('pg6').label('Local Current Density Change');
model.result('pg6').run;
model.result.create('pg7', 'PlotGroup2D');
model.result('pg7').run;
model.result('pg7').label('Corrosion Product Interface');
model.result('pg7').set('data', 'dset3');
model.result('pg7').set('looplevel', [15]);
model.result('pg7').create('surf1', 'Surface');
model.result('pg7').feature('surf1').set('expr', 'ls.Vf1');
model.result('pg7').feature('surf1').set('descr', 'Volume fraction of fluid 1');
model.result('pg7').run;
model.result('pg7').run;
model.result('pg7').create('con1', 'Contour');
model.result('pg7').feature('con1').set('expr', 'ls.Vf1');
model.result('pg7').feature('con1').set('descr', 'Volume fraction of fluid 1');
model.result('pg7').feature('con1').set('levelmethod', 'levels');
model.result('pg7').feature('con1').set('levels', 0.5);
model.result('pg7').feature('con1').set('coloring', 'uniform');
model.result('pg7').feature('con1').set('color', 'black');
model.result('pg7').run;

model.title('Under-Deposit Corrosion');

model.description(['This example demonstrates how to model the effect of corrosion product on galvanic corrosion between a magnesium alloy (AE44) and mild steel in contact with brine solution (salt water).' newline  newline 'The deformed boundaries due to both deposition of corrosion product as well as dissolution of magnesium surface are modeled here using the level set and deformed geometry formulations, respectively.']);

model.mesh.clearMeshes;

model.sol('sol1').clearSolutionData;
model.sol('sol3').clearSolutionData;
model.sol('sol2').clearSolutionData;

model.label('under_deposit_corrosion.mph');

model.modelNode.label('Components');

out = model;
