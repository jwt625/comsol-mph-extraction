function out = model
%
% monopile.m
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
model.study('std1').create('time', 'Transient');
model.study('std1').feature('time').setSolveFor('/physics/cp', true);

% To import content from file, use:
% model.param.loadFile('FILENAME');
model.param.set('Eeq_AlZn', '-1.05[V]', 'Anode equilibrium potential');
model.param.set('T', '283.15[K]', 'Temperature');
model.param.set('Eeq_Fe', '-0.44[V]+R_const*T/(2*F_const)*log(1e-9)', 'Steel oxidation equilibrium potential');
model.param.set('i0_Fe', '1e-3[A/m^2]', 'Exchange current density, steel');
model.param.set('i0_Fe_coated', 'i0_Fe/50', 'Exchange current density, coated steel');
model.param.set('A_Fe', '100[mV]', 'Tafel slope, steel oxidation');
model.param.set('ilim_O2', '-0.1[A/m^2]', 'Limiting current density, oxygen reduction');
model.param.set('ilim_O2_mud', 'ilim_O2/5', 'Limiting current density, oxygen reduction in mud');
model.param.set('A_O2', '-100[mV]', 'Tafel slope, oxygen reduction');
model.param.set('R0', '0.15[m]', 'Anode initial radius');
model.param.set('Rf', '0.05[m]', 'Anode final radius');
model.param.set('AnodeCap', '1e5[A*h/m]', 'Anode capacity');
model.param.set('R_Tp', '1e-2[ohm]', 'Resistance between TP and MP');
model.param.set('sigma_mud', '1.3[S/m]', ' "Mud conductivity"');

model.geom('geom1').insertFile('monopile_geom_sequence.mph', 'geom1');
model.geom('geom1').run('fin');

model.view('view1').set('renderwireframe', true);

model.material.create('mat1', 'Common', 'comp1');
model.material('mat1').propertyGroup.create('ElectrolyteConductivity', 'Electrolyte conductivity');
model.material('mat1').propertyGroup('ElectrolyteConductivity').func.create('int1', 'Interpolation');
model.material('mat1').label('Seawater');
model.material('mat1').propertyGroup('ElectrolyteConductivity').func('int1').set('source', 'file');
model.material('mat1').propertyGroup('ElectrolyteConductivity').func('int1').set('importedname', 'seawater conductivity.txt');
model.material('mat1').propertyGroup('ElectrolyteConductivity').func('int1').set('importeddim', '2D');
model.material('mat1').propertyGroup('ElectrolyteConductivity').func('int1').set('fununit', {''});
model.material('mat1').propertyGroup('ElectrolyteConductivity').func('int1').set('argunit', {'' ''});
model.material('mat1').propertyGroup('ElectrolyteConductivity').func('int1').set('sourcetype', 'model');
model.material('mat1').propertyGroup('ElectrolyteConductivity').func('int1').set('nargs', '2');
model.material('mat1').propertyGroup('ElectrolyteConductivity').func('int1').set('struct', 'spreadsheet');
model.material('mat1').propertyGroup('ElectrolyteConductivity').set('sigmal', {'sigma0*int1(S,(T-0[degC])[1/K])' '0' '0' '0' 'sigma0*int1(S,(T-0[degC])[1/K])' '0' '0' '0' 'sigma0*int1(S,(T-0[degC])[1/K])'});
model.material('mat1').propertyGroup('ElectrolyteConductivity').set('INFO_PREFIX:sigmal', ['Fofonoff, N. P., and R. C. Millard, Jr., Algorithms for computation of' newline 'fundamental properties of seawater, UNESCO, Tech. Pap. Mar.' newline 'Sci., 44, 53 pp., Paris, 1984.' newline  newline 'Physical Properties of Seawater -' newline 'A New Salinity Scale and Equation of State for Seawater, Fofonoff, J. Geophysical Research, Vol. 90, No. C2, 3332-3342, 1985' newline ]);
model.material('mat1').propertyGroup('ElectrolyteConductivity').set('S', '35');
model.material('mat1').propertyGroup('ElectrolyteConductivity').descr('S', 'Practical Salinity (PSS 78)');
model.material('mat1').propertyGroup('ElectrolyteConductivity').set('sigma0', '4.29[S/m]');
model.material('mat1').propertyGroup('ElectrolyteConductivity').descr('sigma0', 'Conductivity at T=15[degC] and S=35');
model.material('mat1').propertyGroup('ElectrolyteConductivity').addInput('temperature');
model.material('mat1').selection.set([2]);
model.material.create('mat2', 'Common', 'comp1');
model.material('mat2').label('Mud');
model.material('mat2').selection.set([1]);
model.material('mat2').propertyGroup.create('ElectrolyteConductivity', 'Electrolyte_conductivity');
model.material('mat2').propertyGroup('ElectrolyteConductivity').set('sigmal', {'sigma_mud'});

model.common('cminpt').set('modified', {'temperature' 'T'});

model.selection.create('cyl1', 'Cylinder');
model.selection('cyl1').model('comp1');
model.selection('cyl1').label('Top');
model.selection('cyl1').set('entitydim', 2);
model.selection('cyl1').set('r', 10);
model.selection('cyl1').set('top', 0.1);
model.selection('cyl1').set('bottom', -20.1);
model.selection('cyl1').set('condition', 'inside');
model.selection.duplicate('cyl2', 'cyl1');
model.selection('cyl2').label('Middle');
model.selection('cyl2').set('top', 0);
model.selection('cyl2').set('bottom', -40);
model.selection('cyl2').set('pos', [0 0 -15]);
model.selection.duplicate('cyl3', 'cyl2');
model.selection('cyl3').label('Bottom');
model.selection('cyl3').set('bottom', -60);
model.selection('cyl3').set('pos', [0 0 -30]);
model.selection.create('uni1', 'Union');
model.selection('uni1').model('comp1');
model.selection('uni1').set('entitydim', 2);
model.selection('uni1').label('Middle and Bottom');
model.selection('uni1').set('input', {'cyl2' 'cyl3'});

model.physics('cp').selection.set([1 2]);
model.physics('cp').create('protms1', 'ProtectedMetalSurface', 2);
model.physics('cp').feature('protms1').label('Protected Metal Surface - Coated Steel');
model.physics('cp').feature('protms1').selection.named('cyl1');
model.physics('cp').feature('protms1').set('iO2', 'ilim_O2');
model.physics('cp').create('es1', 'ElectrodeSurface', 2);
model.physics('cp').feature('es1').label('Electrode Surface - Uncoated Steel');
model.physics('cp').feature('es1').selection.named('uni1');
model.physics('cp').feature('es1').feature('er1').label('Electrode Reaction 1 - Steel Oxidation');
model.physics('cp').feature('es1').feature('er1').set('Eeq', 'Eeq_Fe');
model.physics('cp').feature('es1').feature('er1').set('ElectrodeKinetics', 'AnodicTafelEquation');
model.physics('cp').feature('es1').feature('er1').set('i0', 'i0_Fe');
model.physics('cp').feature('es1').feature('er1').set('Aa', 'A_Fe');
model.physics('cp').feature('es1').create('er2', 'ElectrodeReaction', 2);
model.physics('cp').feature('es1').feature('er2').label('Electrode Reaction 2 - Oxygen Reduction (Sea)');
model.physics('cp').feature('es1').feature('er2').selection.set([]);
model.physics('cp').feature('es1').feature('er2').selection.named('cyl2');
model.physics('cp').feature('es1').feature('er2').set('ilocmat_mat', 'userdef');
model.physics('cp').feature('es1').feature('er2').set('ilocmat', 'ilim_O2');
model.physics('cp').feature('es1').feature.duplicate('er3', 'er2');
model.physics('cp').feature('es1').feature('er3').label('Electrode Reaction 3 - Oxygen Reduction (Mud)');
model.physics('cp').feature('es1').feature('er3').selection.named('cyl3');
model.physics('cp').feature('es1').feature('er3').set('ilocmat', 'ilim_O2_mud');
model.physics('cp').create('sacredge1', 'SacrificialEdgeAnode', 1);
model.physics('cp').feature('sacredge1').selection.named('geom1_unisel1');
model.physics('cp').feature('sacredge1').set('Q0', 'AnodeCap');
model.physics('cp').feature('sacredge1').set('r0', 'R0');
model.physics('cp').feature('sacredge1').set('rend', 'Rf');
model.physics('cp').feature('sacredge1').feature('er1').set('Eeq', 'Eeq_AlZn');
model.physics('cp').create('sym1', 'Symmetry', 2);
model.physics('cp').feature('sym1').selection.set([2 4 266]);
model.physics('cp').feature('init1').set('phil', '-Eeq_AlZn');

model.mesh('mesh1').automatic(false);
model.mesh('mesh1').feature('size').set('custom', true);
model.mesh('mesh1').feature('size').set('hmin', 0.05);
model.mesh('mesh1').feature('size').set('hcurve', 0.4);
model.mesh('mesh1').feature('ftet1').create('size1', 'Size');
model.mesh('mesh1').feature('ftet1').feature('size1').selection.geom('geom1', 1);
model.mesh('mesh1').feature('ftet1').feature('size1').selection.named('geom1_unisel1');
model.mesh('mesh1').feature('ftet1').feature('size1').set('hauto', 1);
model.mesh('mesh1').feature('ftet1').feature('size1').set('custom', true);
model.mesh('mesh1').feature('ftet1').feature('size1').set('hmaxactive', true);
model.mesh('mesh1').feature('ftet1').feature('size1').set('hmax', 0.1);
model.mesh('mesh1').run;

model.study('std1').feature('time').set('tunit', 'a');
model.study('std1').feature('time').set('tlist', 'range(0,1,12)');
model.study('std1').setGenPlots(false);

model.sol.create('sol1');
model.sol('sol1').study('std1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'time');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').feature('comp1_phil').set('scalemethod', 'manual');
model.sol('sol1').feature('v1').feature('comp1_phil').set('scaleval', '1');
model.sol('sol1').feature('v1').set('control', 'time');
model.sol('sol1').create('t1', 'Time');
model.sol('sol1').feature('t1').set('tlist', 'range(0,1,12)');
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
model.sol('sol1').feature('t1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('t1').feature('fc1').set('dtech', 'auto');
model.sol('sol1').feature('t1').create('d1', 'Direct');
model.sol('sol1').feature('t1').feature('d1').set('linsolver', 'pardiso');
model.sol('sol1').feature('t1').feature('d1').label('Direct (cp)');
model.sol('sol1').feature('t1').create('i1', 'Iterative');
model.sol('sol1').feature('t1').feature('i1').set('maxlinit', 1000);
model.sol('sol1').feature('t1').feature('i1').set('nlinnormuse', 'on');
model.sol('sol1').feature('t1').feature('i1').label('Algebraic Multigrid (cp)');
model.sol('sol1').feature('t1').feature('i1').create('mg1', 'Multigrid');
model.sol('sol1').feature('t1').feature('i1').feature('mg1').set('prefun', 'saamg');
model.sol('sol1').feature('t1').feature('i1').feature('mg1').set('maxcoarsedof', 50000);
model.sol('sol1').feature('t1').feature('i1').feature('mg1').set('saamgcompwise', true);
model.sol('sol1').feature('t1').feature('i1').feature('mg1').set('compactaggregation', true);
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('pr').create('sl1', 'SORLine');
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('po').create('sl1', 'SORLine');
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('cs').create('d1', 'Direct');
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('cs').feature('d1').set('linsolver', 'pardiso');
model.sol('sol1').feature('t1').create('i2', 'Iterative');
model.sol('sol1').feature('t1').feature('i2').set('maxlinit', 1000);
model.sol('sol1').feature('t1').feature('i2').set('nlinnormuse', 'on');
model.sol('sol1').feature('t1').feature('i2').label('Geometric Multigrid (cp)');
model.sol('sol1').feature('t1').feature('i2').create('mg1', 'Multigrid');
model.sol('sol1').feature('t1').feature('i2').feature('mg1').feature('pr').create('sl1', 'SORLine');
model.sol('sol1').feature('t1').feature('i2').feature('mg1').feature('po').create('sl1', 'SORLine');
model.sol('sol1').feature('t1').feature('i2').feature('mg1').feature('cs').create('d1', 'Direct');
model.sol('sol1').feature('t1').feature('i2').feature('mg1').feature('cs').feature('d1').set('linsolver', 'pardiso');
model.sol('sol1').feature('t1').feature('fc1').set('linsolver', 'd1');
model.sol('sol1').feature('t1').feature('fc1').set('dtech', 'auto');
model.sol('sol1').feature('t1').feature.remove('fcDef');
model.sol('sol1').attach('std1');
model.sol('sol1').runAll;

model.result.dataset.create('mir1', 'Mirror3D');
model.result.dataset('mir1').set('quickplane', 'zx');
model.result.dataset.create('dset2', 'Solution');
model.result.dataset('dset2').selection.geom('geom1', 2);
model.result.dataset('dset2').selection.named('cyl1');
model.result.create('pg1', 'PlotGroup3D');
model.result('pg1').run;
model.result('pg1').label('Steel Electrode Potential');
model.result('pg1').set('data', 'mir1');
model.result('pg1').set('edges', false);
model.result('pg1').create('surf1', 'Surface');
model.result('pg1').feature('surf1').set('expr', 'cp.Evsref');
model.result('pg1').feature('surf1').set('descr', 'Electrode potential vs. adjacent reference');
model.result('pg1').run;
model.result('pg1').run;
model.result('pg1').create('line1', 'Line');
model.result('pg1').feature('line1').set('expr', '1');
model.result('pg1').feature('line1').set('titletype', 'none');
model.result('pg1').feature('line1').set('linetype', 'tube');
model.result('pg1').feature('line1').set('radiusexpr', 'cp.redge');
model.result('pg1').feature('line1').set('tuberadiusscaleactive', true);
model.result('pg1').feature('line1').set('coloring', 'uniform');
model.result('pg1').feature('line1').set('color', 'gray');
model.result('pg1').run;
model.result('pg1').setIndex('looplevel', 1, 0);
model.result('pg1').run;
model.result('pg1').setIndex('looplevel', 13, 0);
model.result('pg1').run;
model.result.duplicate('pg2', 'pg1');
model.result('pg2').run;
model.result('pg1').run;
model.result('pg1').feature('line1').active(false);
model.result('pg1').run;
model.result('pg1').feature('surf1').set('data', 'dset2');
model.result('pg1').run;
model.result('pg1').feature('surf1').set('expr', 'cp.eta_er1');
model.result('pg1').feature('surf1').set('descr', 'Overpotential');
model.result('pg1').feature('surf1').set('expr', 'cp.Evsref');
model.result('pg1').feature('surf1').set('descr', 'Electrode potential vs. adjacent reference');
model.result('pg1').feature('surf1').set('data', 'parent');
model.result('pg1').run;
model.result('pg1').feature('line1').active(true);
model.result('pg1').run;
model.result('pg2').run;
model.result('pg2').label('Iron Dissolution Current Density');
model.result('pg2').run;
model.result('pg2').feature('surf1').set('expr', 'cp.iloc_er1');
model.result('pg2').feature('surf1').set('descr', 'Local current density');
model.result('pg2').run;
model.result('pg2').run;
model.result('pg2').setIndex('looplevel', 1, 0);
model.result('pg2').run;
model.result('pg2').setIndex('looplevel', 13, 0);
model.result('pg2').run;

model.physics('cp').feature('es1').set('BoundaryCondition', 'ExternalShort');
model.physics('cp').feature('es1').set('R', 'R_Tp');

model.sol('sol1').study('std1');
model.sol('sol1').feature.remove('t1');
model.sol('sol1').feature.remove('v1');
model.sol('sol1').feature.remove('st1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'time');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').feature('comp1_phil').set('scalemethod', 'manual');
model.sol('sol1').feature('v1').feature('comp1_cp_es1_phisext').set('scalemethod', 'manual');
model.sol('sol1').feature('v1').feature('comp1_phil').set('scaleval', '1');
model.sol('sol1').feature('v1').feature('comp1_cp_es1_phisext').set('scaleval', '1');
model.sol('sol1').feature('v1').set('control', 'time');
model.sol('sol1').create('t1', 'Time');
model.sol('sol1').feature('t1').set('tlist', 'range(0,1,12)');
model.sol('sol1').feature('t1').set('plot', 'off');
model.sol('sol1').feature('t1').set('plotgroup', 'pg1');
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
model.sol('sol1').feature('t1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('t1').feature('fc1').set('dtech', 'auto');
model.sol('sol1').feature('t1').create('d1', 'Direct');
model.sol('sol1').feature('t1').feature('d1').set('linsolver', 'pardiso');
model.sol('sol1').feature('t1').feature('d1').label('Direct (cp)');
model.sol('sol1').feature('t1').create('i1', 'Iterative');
model.sol('sol1').feature('t1').feature('i1').set('maxlinit', 1000);
model.sol('sol1').feature('t1').feature('i1').set('nlinnormuse', 'on');
model.sol('sol1').feature('t1').feature('i1').label('Algebraic Multigrid (cp)');
model.sol('sol1').feature('t1').feature('i1').create('mg1', 'Multigrid');
model.sol('sol1').feature('t1').feature('i1').feature('mg1').set('prefun', 'saamg');
model.sol('sol1').feature('t1').feature('i1').feature('mg1').set('maxcoarsedof', 50000);
model.sol('sol1').feature('t1').feature('i1').feature('mg1').set('saamgcompwise', true);
model.sol('sol1').feature('t1').feature('i1').feature('mg1').set('compactaggregation', true);
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('pr').create('sl1', 'SORLine');
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('po').create('sl1', 'SORLine');
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('cs').create('d1', 'Direct');
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('cs').feature('d1').set('linsolver', 'pardiso');
model.sol('sol1').feature('t1').create('i2', 'Iterative');
model.sol('sol1').feature('t1').feature('i2').set('maxlinit', 1000);
model.sol('sol1').feature('t1').feature('i2').set('nlinnormuse', 'on');
model.sol('sol1').feature('t1').feature('i2').label('Geometric Multigrid (cp)');
model.sol('sol1').feature('t1').feature('i2').create('mg1', 'Multigrid');
model.sol('sol1').feature('t1').feature('i2').feature('mg1').feature('pr').create('sl1', 'SORLine');
model.sol('sol1').feature('t1').feature('i2').feature('mg1').feature('po').create('sl1', 'SORLine');
model.sol('sol1').feature('t1').feature('i2').feature('mg1').feature('cs').create('d1', 'Direct');
model.sol('sol1').feature('t1').feature('i2').feature('mg1').feature('cs').feature('d1').set('linsolver', 'pardiso');
model.sol('sol1').feature('t1').feature('fc1').set('linsolver', 'd1');
model.sol('sol1').feature('t1').feature('fc1').set('dtech', 'auto');
model.sol('sol1').feature('t1').feature.remove('fcDef');
model.sol('sol1').attach('std1');
model.sol('sol1').runAll;

model.result('pg1').run;
model.result('pg2').run;
model.result('pg2').run;
model.result('pg1').run;
model.result('pg1').feature('line1').active(false);
model.result('pg1').run;
model.result('pg1').feature('surf1').set('data', 'dset2');
model.result('pg1').run;
model.result('pg1').feature('surf1').set('data', 'parent');
model.result('pg1').run;
model.result('pg1').feature('line1').active(true);
model.result('pg1').run;

model.title('Monopile with Dissolving Sacrificial Anodes');

model.description(['A monopile foundation is a large-diameter structural element that can be used to support, for instance, an off-shore windmill.' newline  newline 'This application exemplifies how the cathodic protection of a monopile decreases over time as the sacrificial anodes dissolve.' newline  newline 'The example includes secondary current distribution electrode kinetics on the protected steel structure, defining simultaneous metal dissolution and oxygen reduction (mixed potential). By including a lumped resistance in the model between the upper structure and the lower monopile foundation, it is seen that the corrosion protection of the monopile is worsened.']);

model.mesh.clearMeshes;

model.sol('sol1').clearSolutionData;

model.label('monopile.mph');

model.modelNode.label('Components');

out = model;
