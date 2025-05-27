function out = model
%
% resistor_modulated_pipeline_cathodic_protection.m
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

model.physics.create('cdpipe', 'CurrentDistributionPipe', 'geom1');
model.physics('cdpipe').model('comp1');

model.study.create('std1');
model.study('std1').create('stat', 'Stationary');
model.study('std1').feature('stat').setSolveFor('/physics/cdpipe', true);

model.geom('geom1').insertFile('resistor_modulated_pipeline_cathodic_protection_geom_sequence.mph', 'geom1');
model.geom('geom1').run('fin');

% To import content from file, use:
% model.param.loadFile('FILENAME');
model.param.set('r_pipe', '0.5[m]', 'Pipe radius');
model.param.set('r_pipe_smaller', '0.2[m]', 'Smaller pipe radius');
model.param.set('sigma_l', '3[S/m]', 'Electrolyte conductivity');
model.param.set('Eeq_Zn', '-1.03[V]', 'Anode equilibrium potential vs. SCE');
model.param.set('R_cp', '100[ohm]', 'Coupling resistance');

model.material.create('mat1', 'Common', 'comp1');
model.material('mat1').propertyGroup.create('LocalCurrentDensity', 'Local current density');
model.material('mat1').propertyGroup('LocalCurrentDensity').func.create('int1', 'Interpolation');
model.material('mat1').propertyGroup.create('ElectrodePotential', 'Equilibrium potential');
model.material('mat1').label('UNS S31254 (stainless steel) in chlorinated seawater solution (Cathodic)');
model.material('mat1').propertyGroup('LocalCurrentDensity').func('int1').set('funcname', 'iloc_exp');
model.material('mat1').propertyGroup('LocalCurrentDensity').func('int1').set('table', {'0.8' '0';  ...
'0.65' '-0.01';  ...
'0.6' '-0.03';  ...
'0.575' '-0.1';  ...
'0.1' '-0.3';  ...
'-0.05' '-1';  ...
'-0.2' '-3';  ...
'-0.3' '-10';  ...
'-0.5' '-30';  ...
'-0.6' '-100';  ...
'-0.8' '-300'});
model.material('mat1').propertyGroup('LocalCurrentDensity').func('int1').set('extrap', 'linear');
model.material('mat1').propertyGroup('LocalCurrentDensity').func('int1').set('fununit', {'mA/m^2'});
model.material('mat1').propertyGroup('LocalCurrentDensity').func('int1').set('argunit', {'V'});
model.material('mat1').propertyGroup('LocalCurrentDensity').set('ilocmat', 'iloc_exp(E_vs_ref_exp)');
model.material('mat1').propertyGroup('LocalCurrentDensity').set('INFO_PREFIX:ilocmat', ['G. E. Nustad, T. Solem, R. Johnsen, H. Osvoll, P. O. Gartland, M. Brameld, and G. Clapp, ' native2unicode(hex2dec({'20' '1c'}), 'unicode') 'Resistor controlled cathodic protection for stainless steels in chlorinated seawater: A review after 8 years in service,' native2unicode(hex2dec({'20' '1d'}), 'unicode') ' NACE Corrosion, Paper number 03082, 2003.']);
model.material('mat1').propertyGroup('LocalCurrentDensity').set('E_vs_SHE', 'V');
model.material('mat1').propertyGroup('LocalCurrentDensity').descr('E_vs_SHE', 'Electrode potential vs. SHE');
model.material('mat1').propertyGroup('LocalCurrentDensity').set('E_ref_exp_vs_SHE', '0.241 [V]');
model.material('mat1').propertyGroup('LocalCurrentDensity').descr('E_ref_exp_vs_SHE', 'Reference electrode potential in experiment vs. SHE');
model.material('mat1').propertyGroup('LocalCurrentDensity').set('E_vs_ref_exp', 'E_vs_SHE-E_ref_exp_vs_SHE');
model.material('mat1').propertyGroup('LocalCurrentDensity').descr('E_vs_ref_exp', 'Electrode potential vs. experimental SCE reference electrode');
model.material('mat1').propertyGroup('LocalCurrentDensity').addInput('electricpotential');
model.material('mat1').propertyGroup('ElectrodePotential').set('Eeq', 'Eeq_vs_SHE');
model.material('mat1').propertyGroup('ElectrodePotential').set('INFO_PREFIX:Eeq', ['G. E. Nustad, T. Solem, R. Johnsen, H. Osvoll, P. O. Gartland, M. Brameld, and G. Clapp, ' native2unicode(hex2dec({'20' '1c'}), 'unicode') 'Resistor controlled cathodic protection for stainless steels in chlorinated seawater: A review after 8 years in service,' native2unicode(hex2dec({'20' '1d'}), 'unicode') ' NACE Corrosion, Paper number 03082, 2003.']);
model.material('mat1').propertyGroup('ElectrodePotential').set('dEeqdT', '0');
model.material('mat1').propertyGroup('ElectrodePotential').set('cEeqref', '0');
model.material('mat1').propertyGroup('ElectrodePotential').set('Eeq_vs_ref_exp', '0.8 [V]');
model.material('mat1').propertyGroup('ElectrodePotential').descr('Eeq_vs_ref_exp', 'Equilibrium (open circuit) potential vs. SCE');
model.material('mat1').propertyGroup('ElectrodePotential').set('E_ref_exp_vs_SHE', '0.241 [V]');
model.material('mat1').propertyGroup('ElectrodePotential').descr('E_ref_exp_vs_SHE', 'Reference electrode potential in experiment vs. SHE');
model.material('mat1').propertyGroup('ElectrodePotential').set('Eeq_vs_SHE', 'Eeq_vs_ref_exp+E_ref_exp_vs_SHE');
model.material('mat1').propertyGroup('ElectrodePotential').descr('Eeq_vs_SHE', 'Equilibrium (open circuit) potential vs. SHE');
model.material('mat1').propertyGroup('ElectrodePotential').addInput('concentration');

model.physics('cdpipe').selection.named('geom1_unisel1');
model.physics('cdpipe').prop('PhysicsVsMaterialsReferenceElectrodePotential').set('PhysicsVsMaterialsReferenceElectrodePotential', 'SCE');
model.physics('cdpipe').feature('ice1').set('redge', 'r_pipe');
model.physics('cdpipe').feature('ice1').set('sigmal_mat', 'userdef');
model.physics('cdpipe').feature('ice1').set('sigmal', {'sigma_l' '0' '0' '0' 'sigma_l' '0' '0' '0' 'sigma_l'});
model.physics('cdpipe').create('ice2', 'Electrolyte', 1);
model.physics('cdpipe').feature('ice2').selection.named('geom1_pi3_csel1_edg');
model.physics('cdpipe').feature('ice2').set('redge', 'r_pipe_smaller');
model.physics('cdpipe').feature('ice2').set('sigmal_mat', 'userdef');
model.physics('cdpipe').feature('ice2').set('sigmal', {'sigma_l' '0' '0' '0' 'sigma_l' '0' '0' '0' 'sigma_l'});
model.physics('cdpipe').create('pes1', 'PipeElectrodeSurface', 1);
model.physics('cdpipe').feature('pes1').selection.named('geom1_unisel1');
model.physics('cdpipe').feature('pes1').feature('er1').set('ilocmat_mat', 'from_mat');
model.physics('cdpipe').create('ppsa1', 'PipePointSacrificialAnode', 0);
model.physics('cdpipe').feature('ppsa1').selection.named('geom1_sel1');
model.physics('cdpipe').feature('ppsa1').set('Eeq', 'Eeq_Zn');
model.physics('cdpipe').feature('ppsa1').set('R', 'R_cp');

model.mesh('mesh1').autoMeshSize(1);
model.mesh('mesh1').automatic(false);
model.mesh('mesh1').feature('edg1').selection.all;
model.mesh('mesh1').feature('edg1').create('size1', 'Size');
model.mesh('mesh1').feature('edg1').feature('size1').set('custom', true);
model.mesh('mesh1').feature('edg1').feature('size1').set('hmaxactive', true);
model.mesh('mesh1').feature('edg1').feature('size1').set('hmax', 0.5);
model.mesh('mesh1').run;

model.study('std1').create('param', 'Parametric');
model.study('std1').feature('param').setIndex('pname', 'r_pipe', 0);
model.study('std1').feature('param').setIndex('plistarr', '', 0);
model.study('std1').feature('param').setIndex('punit', 'm', 0);
model.study('std1').feature('param').setIndex('pname', 'r_pipe', 0);
model.study('std1').feature('param').setIndex('plistarr', '', 0);
model.study('std1').feature('param').setIndex('punit', 'm', 0);
model.study('std1').feature('param').setIndex('pname', 'R_cp', 0);
model.study('std1').feature('param').setIndex('plistarr', '0.5 1 2', 0);
model.study('std1').feature('param').setIndex('punit', ['ohm' ], 0);

model.sol.create('sol1');
model.sol('sol1').study('std1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'stat');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').feature('comp1_phil').set('scalemethod', 'manual');
model.sol('sol1').feature('v1').feature('comp1_phil').set('scaleval', '1');
model.sol('sol1').feature('v1').set('control', 'stat');
model.sol('sol1').create('s1', 'Stationary');
model.sol('sol1').feature('s1').set('stol', 1.0E-4);
model.sol('sol1').feature('s1').create('p1', 'Parametric');
model.sol('sol1').feature('s1').feature('p1').set('pname', {'R_cp'});
model.sol('sol1').feature('s1').feature('p1').set('plistarr', {'0.5 1 2'});
model.sol('sol1').feature('s1').feature('p1').set('punit', {['ohm' ]});
model.sol('sol1').feature('s1').feature('p1').set('sweeptype', 'sparse');
model.sol('sol1').feature('s1').feature('p1').set('preusesol', 'no');
model.sol('sol1').feature('s1').feature('p1').set('pcontinuationmode', 'no');
model.sol('sol1').feature('s1').feature('p1').set('porder', 'constant');
model.sol('sol1').feature('s1').feature('p1').set('plot', 'off');
model.sol('sol1').feature('s1').feature('p1').set('plotgroup', 'Default');
model.sol('sol1').feature('s1').feature('p1').set('probesel', 'all');
model.sol('sol1').feature('s1').feature('p1').set('probes', {});
model.sol('sol1').feature('s1').feature('p1').set('control', 'param');
model.sol('sol1').feature('s1').set('control', 'stat');
model.sol('sol1').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('s1').feature('fc1').set('dtech', 'auto');
model.sol('sol1').feature('s1').feature('fc1').set('maxiter', 50);
model.sol('sol1').feature('s1').feature('fc1').set('minstep', 1.0E-6);
model.sol('sol1').feature('s1').create('d1', 'Direct');
model.sol('sol1').feature('s1').feature('d1').set('linsolver', 'pardiso');
model.sol('sol1').feature('s1').feature('d1').label('Direct (cdpipe)');
model.sol('sol1').feature('s1').create('i1', 'Iterative');
model.sol('sol1').feature('s1').feature('i1').set('maxlinit', 1000);
model.sol('sol1').feature('s1').feature('i1').set('nlinnormuse', 'on');
model.sol('sol1').feature('s1').feature('i1').label('Algebraic Multigrid (cdpipe)');
model.sol('sol1').feature('s1').feature('i1').create('mg1', 'Multigrid');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').set('prefun', 'saamg');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').set('maxcoarsedof', 50000);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').set('saamgcompwise', true);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').set('compactaggregation', true);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('pr').create('sl1', 'SORLine');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('po').create('sl1', 'SORLine');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('cs').create('d1', 'Direct');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('cs').feature('d1').set('linsolver', 'pardiso');
model.sol('sol1').feature('s1').create('i2', 'Iterative');
model.sol('sol1').feature('s1').feature('i2').set('maxlinit', 1000);
model.sol('sol1').feature('s1').feature('i2').set('nlinnormuse', 'on');
model.sol('sol1').feature('s1').feature('i2').label('Geometric Multigrid (cdpipe)');
model.sol('sol1').feature('s1').feature('i2').create('mg1', 'Multigrid');
model.sol('sol1').feature('s1').feature('i2').feature('mg1').feature('pr').create('sl1', 'SORLine');
model.sol('sol1').feature('s1').feature('i2').feature('mg1').feature('po').create('sl1', 'SORLine');
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
model.result('pg1').setIndex('looplevel', 3, 0);
model.result('pg1').create('line1', 'Line');
model.result('pg1').feature('line1').set('expr', {'phil'});
model.result('pg1').feature('line1').set('linetype', 'tube');
model.result('pg1').feature('line1').set('tuberadiusscaleactive', 'on');
model.result('pg1').feature('line1').set('tuberadiusscale', '1');
model.result('pg1').feature('line1').set('radiusexpr', 'root.comp1.cdpipe.redge');
model.result('pg1').label('Electrolyte Potential (cdpipe)');
model.result.create('pg2', 'PlotGroup3D');
model.result('pg2').set('data', 'dset1');
model.result('pg2').setIndex('looplevel', 3, 0);
model.result('pg2').create('line1', 'Line');
model.result('pg2').feature('line1').set('expr', {'cdpipe.tIlMag'});
model.result('pg2').create('arwl1', 'ArrowLine');
model.result('pg2').feature('arwl1').set('expr', {'cdpipe.tIlx' 'cdpipe.tIly' 'cdpipe.tIlz'});
model.result('pg2').feature('arwl1').set('arrowbase', 'center');
model.result('pg2').feature('arwl1').set('arrowtype', 'cone');
model.result('pg2').feature('arwl1').set('arrowcount', 50);
model.result('pg2').feature('arwl1').set('color', 'black');
model.result('pg2').feature('arwl1').set('arrowlength', 'logarithmic');
model.result('pg2').feature('arwl1').create('col', 'Color');
model.result('pg2').feature('arwl1').feature('col').set('expr', 'cdpipe.tIlMag');
model.result('pg2').feature('arwl1').set('inheritplot', 'line1');
model.result('pg2').label('Tangential Electrolyte Current Density (cdpipe)');
model.result.create('pg3', 'PlotGroup3D');
model.result('pg3').set('data', 'dset1');
model.result('pg3').setIndex('looplevel', 3, 0);
model.result('pg3').create('line1', 'Line');
model.result('pg3').feature('line1').set('expr', {'cdpipe.itot'});
model.result('pg3').feature('line1').set('linetype', 'tube');
model.result('pg3').feature('line1').set('tuberadiusscaleactive', 'on');
model.result('pg3').feature('line1').set('tuberadiusscale', '1');
model.result('pg3').feature('line1').set('radiusexpr', 'root.comp1.cdpipe.redge');
model.result('pg3').label('Total Interface Current Density (cdpipe)');
model.result.create('pg4', 'PlotGroup3D');
model.result('pg4').set('data', 'dset1');
model.result('pg4').setIndex('looplevel', 3, 0);
model.result('pg4').create('line1', 'Line');
model.result('pg4').feature('line1').set('expr', {'cdpipe.Evsref'});
model.result('pg4').feature('line1').set('linetype', 'tube');
model.result('pg4').feature('line1').set('tuberadiusscaleactive', 'on');
model.result('pg4').feature('line1').set('tuberadiusscale', '1');
model.result('pg4').feature('line1').set('radiusexpr', 'root.comp1.cdpipe.redge');
model.result('pg4').label('Electrode Potential vs. Adjacent Reference (cdpipe)');
model.result('pg1').run;
model.result('pg4').run;
model.result('pg4').set('showlegendsmaxmin', true);
model.result('pg4').set('legendactive', true);
model.result('pg4').set('legendprecision', 4);
model.result('pg4').run;
model.result('pg4').setIndex('looplevel', 1, 0);
model.result('pg4').run;
model.result('pg3').run;
model.result('pg3').setIndex('looplevel', 1, 0);
model.result('pg3').run;
model.result('pg4').run;
model.result.duplicate('pg5', 'pg4');
model.result('pg5').run;
model.result('pg5').label('Pipe Regions not Fulfilling Protection Criterion');
model.result('pg5').run;
model.result('pg5').feature('line1').set('expr', '1');
model.result('pg5').feature('line1').set('coloring', 'uniform');
model.result('pg5').feature('line1').create('filt1', 'Filter');
model.result('pg5').run;
model.result('pg5').feature('line1').feature('filt1').set('expr', 'cdpipe.Evsref>-0.1');
model.result('pg5').run;
model.result('pg5').run;
model.result('pg5').setIndex('looplevel', 2, 0);
model.result('pg5').run;
model.result('pg5').setIndex('looplevel', 3, 0);
model.result('pg5').run;

model.title('Resistor-Modulated Pipeline Cathodic Protection');

model.description(['Highly alloyed stainless steel used in chlorinated seawater systems may be prone to corrosion under certain operating conditions. Conventional cathodic protection technique is less suitable for stainless steel due to unacceptable anode consumption rate and propensity to hydrogen embrittlement at highly negative potentials.' newline  newline 'In the present model, an alternative corrosion protection technique based on resistor modulated cathodic protection is demonstrated using the Current Distribution, Pipe interface.' newline  newline 'The impact of different resistance values on the resulting level of corrosion protection offered is investigated.']);

model.mesh.clearMeshes;

model.sol('sol1').clearSolutionData;

model.label('resistor_modulated_pipeline_cathodic_protection.mph');

model.modelNode.label('Components');

out = model;
