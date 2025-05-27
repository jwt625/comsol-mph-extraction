function out = model
%
% chlor_alkali.m
%
% Model exported on May 26 2025, 21:28 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/Electrochemistry_Module/Electrochemical_Engineering');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 2);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.physics.create('cd', 'SecondaryCurrentDistribution', 'geom1');
model.physics('cd').model('comp1');

model.study.create('std1');
model.study('std1').create('stat', 'Stationary');
model.study('std1').feature('stat').setSolveFor('/physics/cd', true);

% To import content from file, use:
% model.param.loadFile('FILENAME');
model.param.set('K_a', '50[S/m]', 'Conductivity, anolyte');
model.param.set('K_c', '100[S/m]', 'Conductivity, catholyte');
model.param.set('K_m', '3[S/m]', 'Conductivity, membrane');
model.param.set('T', '90[degC]', 'Temperature');
model.param.set('i0_c', '1[mA/m^2]', 'Exchange current density, cathode');
model.param.set('E_pol', '1.19[V]', 'Cell polarization voltage');

model.geom('geom1').insertFile('chlor_alkali_geom_sequence.mph', 'geom1');
model.geom('geom1').run('fin');

model.material.create('mat1', 'Common', 'comp1');
model.material('mat1').selection.set([3]);
model.material('mat1').propertyGroup.create('ElectrolyteConductivity', 'Electrolyte_conductivity');
model.material('mat1').propertyGroup('ElectrolyteConductivity').set('sigmal', {'K_c'});
model.material.create('mat2', 'Common', 'comp1');
model.material('mat2').selection.set([2]);
model.material('mat2').propertyGroup.create('ElectrolyteConductivity', 'Electrolyte_conductivity');
model.material('mat2').propertyGroup('ElectrolyteConductivity').set('sigmal', {'K_m'});
model.material.create('mat3', 'Common', 'comp1');
model.material('mat3').selection.set([1]);
model.material('mat3').propertyGroup.create('ElectrolyteConductivity', 'Electrolyte_conductivity');
model.material('mat3').propertyGroup('ElectrolyteConductivity').set('sigmal', {'K_a'});

model.physics('cd').create('es1', 'ElectrodeSurface', 1);
model.physics('cd').feature('es1').selection.set([10 11 12 22]);
model.physics('cd').feature('es1').set('phisext0', '-E_pol');
model.physics('cd').feature('es1').feature('er1').set('ElectrodeKinetics', 'ButlerVolmer');
model.physics('cd').feature('es1').feature('er1').set('i0', 'i0_c');
model.physics('cd').create('eip1', 'ElectrolytePotential', 1);
model.physics('cd').feature('eip1').selection.set([3 8 9 17]);

model.common('cminpt').set('modified', {'temperature' 'T'});

model.mesh('mesh1').create('ftri1', 'FreeTri');
model.mesh('mesh1').feature('ftri1').create('size1', 'Size');
model.mesh('mesh1').feature('ftri1').feature('size1').selection.geom('geom1', 1);
model.mesh('mesh1').feature('ftri1').feature('size1').selection.set([3 4 5 8 9 10 11 12 14 15 17 18 19 20 21 22]);
model.mesh('mesh1').feature('ftri1').feature('size1').set('hauto', 1);
model.mesh('mesh1').run;
model.mesh('mesh1').run;

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
model.sol('sol1').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('s1').feature('fc1').set('dtech', 'auto');
model.sol('sol1').feature('s1').feature('fc1').set('maxiter', 50);
model.sol('sol1').feature('s1').feature('fc1').set('minstep', 1.0E-6);
model.sol('sol1').feature('s1').create('d1', 'Direct');
model.sol('sol1').feature('s1').feature('d1').set('linsolver', 'pardiso');
model.sol('sol1').feature('s1').feature('d1').label('Direct (cd)');
model.sol('sol1').feature('s1').create('i1', 'Iterative');
model.sol('sol1').feature('s1').feature('i1').set('maxlinit', 1000);
model.sol('sol1').feature('s1').feature('i1').set('nlinnormuse', 'on');
model.sol('sol1').feature('s1').feature('i1').label('Algebraic Multigrid (cd)');
model.sol('sol1').feature('s1').feature('i1').create('mg1', 'Multigrid');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').set('prefun', 'saamg');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').set('maxcoarsedof', 50000);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').set('saamgcompwise', true);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').set('compactaggregation', true);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('pr').create('sc1', 'SCGS');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('pr').feature('sc1').set('linesweeptype', 'ssor');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('pr').feature('sc1').set('iter', 1);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('pr').feature('sc1').set('scgsmethod', 'lines');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('po').create('sc1', 'SCGS');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('po').feature('sc1').set('linesweeptype', 'ssor');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('po').feature('sc1').set('iter', 1);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('po').feature('sc1').set('scgsmethod', 'lines');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('cs').create('d1', 'Direct');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('cs').feature('d1').set('linsolver', 'pardiso');
model.sol('sol1').feature('s1').create('i2', 'Iterative');
model.sol('sol1').feature('s1').feature('i2').set('maxlinit', 1000);
model.sol('sol1').feature('s1').feature('i2').set('nlinnormuse', 'on');
model.sol('sol1').feature('s1').feature('i2').label('Geometric Multigrid (cd)');
model.sol('sol1').feature('s1').feature('i2').create('mg1', 'Multigrid');
model.sol('sol1').feature('s1').feature('i2').feature('mg1').feature('pr').create('sc1', 'SCGS');
model.sol('sol1').feature('s1').feature('i2').feature('mg1').feature('pr').feature('sc1').set('linesweeptype', 'ssor');
model.sol('sol1').feature('s1').feature('i2').feature('mg1').feature('pr').feature('sc1').set('iter', 1);
model.sol('sol1').feature('s1').feature('i2').feature('mg1').feature('pr').feature('sc1').set('scgsmethod', 'lines');
model.sol('sol1').feature('s1').feature('i2').feature('mg1').feature('po').create('sc1', 'SCGS');
model.sol('sol1').feature('s1').feature('i2').feature('mg1').feature('po').feature('sc1').set('linesweeptype', 'ssor');
model.sol('sol1').feature('s1').feature('i2').feature('mg1').feature('po').feature('sc1').set('iter', 1);
model.sol('sol1').feature('s1').feature('i2').feature('mg1').feature('po').feature('sc1').set('scgsmethod', 'lines');
model.sol('sol1').feature('s1').feature('i2').feature('mg1').feature('cs').create('d1', 'Direct');
model.sol('sol1').feature('s1').feature('i2').feature('mg1').feature('cs').feature('d1').set('linsolver', 'pardiso');
model.sol('sol1').feature('s1').feature('fc1').set('linsolver', 'd1');
model.sol('sol1').feature('s1').feature('fc1').set('dtech', 'auto');
model.sol('sol1').feature('s1').feature('fc1').set('maxiter', 50);
model.sol('sol1').feature('s1').feature('fc1').set('minstep', 1.0E-6);
model.sol('sol1').feature('s1').feature.remove('fcDef');
model.sol('sol1').attach('std1');
model.sol('sol1').runAll;

model.result.create('pg1', 'PlotGroup2D');
model.result('pg1').set('data', 'dset1');
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
model.result('pg2').set('data', 'dset1');
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
model.result('pg3').set('data', 'dset1');
model.result('pg3').label('Electrode Potential with Respect to Ground (cd)');
model.result('pg3').create('line1', 'Line');
model.result('pg3').feature('line1').set('expr', {'cd.phisext'});
model.result('pg3').feature('line1').set('linetype', 'tube');
model.result('pg3').feature('line1').set('inherittubescale', false);
model.result.create('pg4', 'PlotGroup2D');
model.result('pg4').set('data', 'dset1');
model.result('pg4').label('Electrode Potential vs. Adjacent Reference (cd)');
model.result('pg4').create('str1', 'Streamline');
model.result('pg4').feature('str1').set('expr', {'cd.Ilx' 'cd.Ily'});
model.result('pg4').feature('str1').set('posmethod', 'uniform');
model.result('pg4').feature('str1').set('recover', 'pprint');
model.result('pg4').feature('str1').set('pointtype', 'arrow');
model.result('pg4').feature('str1').set('arrowlength', 'logarithmic');
model.result('pg4').feature('str1').set('color', 'gray');
model.result('pg4').create('line1', 'Line');
model.result('pg4').feature('line1').set('expr', {'cd.Evsref'});
model.result('pg4').feature('line1').set('linetype', 'tube');
model.result('pg4').feature('line1').set('inherittubescale', false);
model.result('pg1').run;
model.result('pg2').run;
model.result('pg2').run;

model.title('Current Distribution in a Chlor-Alkali Membrane Cell');

model.description('This example describes the secondary current distribution in a realistic structure for the anodes and cathodes in a chlor-alkali membrane cell. The model geometry is a unit cell of an entire cell.');

model.mesh.clearMeshes;

model.sol('sol1').clearSolutionData;

model.label('chlor_alkali.mph');

model.modelNode.label('Components');

out = model;
