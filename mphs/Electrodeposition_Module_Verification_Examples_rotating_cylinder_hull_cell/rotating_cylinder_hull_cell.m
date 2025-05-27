function out = model
%
% rotating_cylinder_hull_cell.m
%
% Model exported on May 26 2025, 21:28 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/Electrodeposition_Module/Verification_Examples');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 2);
model.geom('geom1').model('comp1');
model.geom('geom1').axisymmetric(true);

model.mesh.create('mesh1', 'geom1');

model.physics.create('cd', 'PrimaryCurrentDistribution', 'geom1');
model.physics('cd').model('comp1');

model.study.create('std1');
model.study('std1').create('stat', 'Stationary');
model.study('std1').feature('stat').setSolveFor('/physics/cd', true);

% To import content from file, use:
% model.param.loadFile('FILENAME');
model.param.set('sigma', '0.35[S/cm]', 'Electrolyte conductivity');
model.param.set('i_app', '-100[A/m^2]', 'Applied current density');
model.param.set('H', '8[cm]', 'Length of working electrode');
model.param.set('i0', '5.37e-5[A/cm^2]', 'Exchange current density');
model.param.set('Ac', '-0.0525*2.301[V]', 'Tafel slope');
model.param.set('cb', '5e-5[mol/cm^3]', 'Bulk concentration of cupric ions');
model.param.set('D', '4.2e-6[cm^2/s]', 'Diffusion coefficient of cupric ions');

model.geom('geom1').create('pol1', 'Polygon');
model.geom('geom1').feature('pol1').set('source', 'table');
model.geom('geom1').feature('pol1').set('table', {'0' '-7.5e-2';  ...
'5.5e-2' '-7.5e-2';  ...
'5.5e-2' '12.5e-2';  ...
'2.5e-2' '12.5e-2';  ...
'2.5e-2' '0';  ...
'2.6e-2' '0';  ...
'2.7e-2' '0';  ...
'2.7e-2' '-2.5e-2';  ...
'2.6e-2' '-2.5e-2';  ...
'2.2e-2' '-2.5e-2';  ...
'2.2e-2' '12.5e-2';  ...
'1.15e-2' '12.5e-2';  ...
'1.15e-2' 'H';  ...
'0.3e-2' 'H';  ...
'0.3e-2' '0';  ...
'1.15e-2' '0';  ...
'1.15e-2' '-2.5e-2';  ...
'0' '-2.5e-2';  ...
'0' '-7.5e-2'});
model.geom('geom1').run('pol1');
model.geom('geom1').create('r1', 'Rectangle');
model.geom('geom1').feature('r1').set('size', {'30e-6' 'H'});
model.geom('geom1').feature('r1').set('pos', [0.003 0]);
model.geom('geom1').feature('r1').label('Boundary Layer');
model.geom('geom1').feature('r1').set('selresult', true);
model.geom('geom1').run('r1');

model.variable.create('var1');
model.variable('var1').model('comp1');

model.geom('geom1').run;

% To import content from file, use:
% model.variable('var1').loadFile('FILENAME');
model.variable('var1').set('i_analytical', '(0.535-0.458*z/H)/sqrt(0.0233+(z/H)^2)+8.52e-005*exp(7.17*z/H)[1]', 'Normalized analytical current density expression');

model.selection.create('sel1', 'Explicit');
model.selection('sel1').model('comp1');
model.selection('sel1').geom(1);
model.selection('sel1').set([4]);
model.selection('sel1').label('Working Electrode');
model.selection.create('sel2', 'Explicit');
model.selection('sel2').model('comp1');
model.selection('sel2').geom(1);
model.selection('sel2').set([18 19 20]);
model.selection('sel2').label('Counter Electrode');

model.physics('cd').feature('ice1').set('sigmal_mat', 'userdef');
model.physics('cd').feature('ice1').set('sigmal', {'sigma' '0' '0' '0' 'sigma' '0' '0' '0' 'sigma'});
model.physics('cd').create('eip1', 'ElectrolytePotential', 1);
model.physics('cd').feature('eip1').selection.named('sel2');
model.physics('cd').create('es1', 'ElectrodeSurface', 1);
model.physics('cd').feature('es1').selection.named('sel1');
model.physics('cd').feature('es1').set('BoundaryCondition', 'AverageCurrentDensity');
model.physics('cd').feature('es1').set('Ial', 'i_app');

model.mesh('mesh1').create('map1', 'Map');
model.mesh('mesh1').feature('map1').selection.geom('geom1', 2);
model.mesh('mesh1').feature('map1').selection.named('geom1_r1_dom');
model.mesh('mesh1').feature('map1').create('dis1', 'Distribution');
model.mesh('mesh1').feature('map1').feature('dis1').selection.set([5 6]);
model.mesh('mesh1').feature('map1').create('dis2', 'Distribution');
model.mesh('mesh1').feature('map1').feature('dis2').selection.set([4 7]);
model.mesh('mesh1').feature('map1').feature('dis2').set('type', 'predefined');
model.mesh('mesh1').feature('map1').feature('dis2').set('elemcount', 200);
model.mesh('mesh1').feature('map1').feature('dis2').set('elemratio', 10);
model.mesh('mesh1').create('ftri1', 'FreeTri');
model.mesh('mesh1').run;

model.sol.create('sol1');
model.sol('sol1').study('std1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'stat');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').feature('comp1_phil').set('scalemethod', 'manual');
model.sol('sol1').feature('v1').feature('comp1_cd_es1_phisext').set('scalemethod', 'manual');
model.sol('sol1').feature('v1').feature('comp1_phil').set('scaleval', '1');
model.sol('sol1').feature('v1').feature('comp1_cd_es1_phisext').set('scaleval', '1');
model.sol('sol1').feature('v1').set('control', 'stat');
model.sol('sol1').create('s1', 'Stationary');
model.sol('sol1').feature('s1').set('stol', 1.0E-4);
model.sol('sol1').feature('s1').create('fc1', 'FullyCoupled');
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
model.sol('sol1').feature('s1').feature('i1').feature('mg1').set('saamgcompwise', false);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').set('compactaggregation', true);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('pr').create('sc1', 'SCGS');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('pr').feature('sc1').set('vankavars', {'comp1_phil_lm'});
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('pr').feature('sc1').set('vankavarsactive', 'on');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('pr').feature('sc1').set('linesweeptype', 'ssor');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('pr').feature('sc1').set('iter', 1);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('pr').feature('sc1').set('scgsmethod', 'lines');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('po').create('sc1', 'SCGS');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('po').feature('sc1').set('vankavars', {'comp1_phil_lm'});
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('po').feature('sc1').set('vankavarsactive', 'on');
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
model.sol('sol1').feature('s1').feature('i2').feature('mg1').feature('pr').feature('sc1').set('vankavars', {'comp1_phil_lm'});
model.sol('sol1').feature('s1').feature('i2').feature('mg1').feature('pr').feature('sc1').set('vankavarsactive', 'on');
model.sol('sol1').feature('s1').feature('i2').feature('mg1').feature('pr').feature('sc1').set('linesweeptype', 'ssor');
model.sol('sol1').feature('s1').feature('i2').feature('mg1').feature('pr').feature('sc1').set('iter', 1);
model.sol('sol1').feature('s1').feature('i2').feature('mg1').feature('pr').feature('sc1').set('scgsmethod', 'lines');
model.sol('sol1').feature('s1').feature('i2').feature('mg1').feature('po').create('sc1', 'SCGS');
model.sol('sol1').feature('s1').feature('i2').feature('mg1').feature('po').feature('sc1').set('vankavars', {'comp1_phil_lm'});
model.sol('sol1').feature('s1').feature('i2').feature('mg1').feature('po').feature('sc1').set('vankavarsactive', 'on');
model.sol('sol1').feature('s1').feature('i2').feature('mg1').feature('po').feature('sc1').set('linesweeptype', 'ssor');
model.sol('sol1').feature('s1').feature('i2').feature('mg1').feature('po').feature('sc1').set('iter', 1);
model.sol('sol1').feature('s1').feature('i2').feature('mg1').feature('po').feature('sc1').set('scgsmethod', 'lines');
model.sol('sol1').feature('s1').feature('i2').feature('mg1').feature('cs').create('d1', 'Direct');
model.sol('sol1').feature('s1').feature('i2').feature('mg1').feature('cs').feature('d1').set('linsolver', 'pardiso');
model.sol('sol1').feature('s1').feature('fc1').set('linsolver', 'd1');
model.sol('sol1').feature('s1').feature('fc1').set('maxiter', 50);
model.sol('sol1').feature('s1').feature('fc1').set('minstep', 1.0E-6);
model.sol('sol1').feature('s1').feature.remove('fcDef');
model.sol('sol1').attach('std1');
model.sol('sol1').runAll;

model.result.dataset.create('rev1', 'Revolve2D');
model.result.dataset('rev1').set('data', 'dset1');
model.result.dataset('rev1').set('revangle', 225);
model.result.dataset('rev1').set('startangle', -90);
model.result.dataset('rev1').set('hasspacevars', true);
model.result.create('pg1', 'PlotGroup2D');
model.result('pg1').set('data', 'dset1');
model.result('pg1').label('Electrolyte Potential (cd)');
model.result('pg1').create('surf1', 'Surface');
model.result('pg1').feature('surf1').set('expr', {'phil'});
model.result('pg1').create('str1', 'Streamline');
model.result('pg1').feature('str1').set('expr', {'cd.Ilr' 'cd.Ilz'});
model.result('pg1').feature('str1').set('posmethod', 'uniform');
model.result('pg1').feature('str1').set('recover', 'pprint');
model.result('pg1').feature('str1').set('pointtype', 'arrow');
model.result('pg1').feature('str1').set('arrowlength', 'logarithmic');
model.result('pg1').feature('str1').set('color', 'gray');
model.result.create('pg2', 'PlotGroup3D');
model.result('pg2').set('data', 'rev1');
model.result('pg2').label('Electrolyte Potential, 3D (cd)');
model.result('pg2').create('mslc1', 'Multislice');
model.result('pg2').feature('mslc1').set('expr', {'phil'});
model.result('pg2').create('str1', 'Streamline');
model.result('pg2').feature('str1').set('revcoordsys', 'cylindrical');
model.result('pg2').feature('str1').set('expr', {'cd.Ilr' 'cd.Ilphi' 'cd.Ilz'});
model.result('pg2').feature('str1').set('pointtype', 'arrow');
model.result('pg2').feature('str1').set('arrowlength', 'logarithmic');
model.result('pg2').feature('str1').set('color', 'gray');
model.result.create('pg3', 'PlotGroup2D');
model.result('pg3').set('data', 'dset1');
model.result('pg3').label('Electrolyte Current Density (cd)');
model.result('pg3').create('str1', 'Streamline');
model.result('pg3').feature('str1').set('expr', {'cd.Ilr' 'cd.Ilz'});
model.result('pg3').feature('str1').set('posmethod', 'uniform');
model.result('pg3').feature('str1').set('recover', 'pprint');
model.result('pg3').feature('str1').set('pointtype', 'arrow');
model.result('pg3').feature('str1').set('arrowlength', 'logarithmic');
model.result('pg3').feature('str1').set('color', 'gray');
model.result('pg3').feature('str1').create('col1', 'Color');
model.result('pg3').feature('str1').feature('col1').set('expr', 'root.comp1.cd.IlMag');
model.result.create('pg4', 'PlotGroup3D');
model.result('pg4').set('data', 'rev1');
model.result('pg4').label('Electrolyte Current Density, 3D (cd)');
model.result('pg4').create('str1', 'Streamline');
model.result('pg4').feature('str1').set('revcoordsys', 'cylindrical');
model.result('pg4').feature('str1').set('expr', {'cd.Ilr' 'cd.Ilphi' 'cd.Ilz'});
model.result('pg4').feature('str1').set('pointtype', 'arrow');
model.result('pg4').feature('str1').set('arrowlength', 'logarithmic');
model.result('pg4').feature('str1').set('color', 'gray');
model.result('pg4').feature('str1').create('col1', 'Color');
model.result('pg4').feature('str1').feature('col1').set('expr', 'root.comp1.cd.IlMag');
model.result('pg3').create('line1', 'Line');
model.result('pg3').feature('line1').set('expr', {'abs(cd.itot)'});
model.result('pg3').feature('line1').set('linetype', 'tube');
model.result('pg3').feature('line1').set('inherittubescale', false);
model.result('pg3').feature('line1').set('inheritplot', 'str1');
model.result('pg4').create('surf1', 'Surface');
model.result('pg4').feature('surf1').set('expr', {'abs(cd.itot)'});
model.result('pg4').feature('surf1').set('inheritplot', 'str1');
model.result.create('pg5', 'PlotGroup2D');
model.result('pg5').set('data', 'dset1');
model.result('pg5').label('Electrode Potential with Respect to Ground (cd)');
model.result.create('pg6', 'PlotGroup3D');
model.result('pg6').set('data', 'rev1');
model.result('pg6').label('Electrode Potential with Respect to Ground, 3D (cd)');
model.result('pg5').create('line1', 'Line');
model.result('pg5').feature('line1').set('expr', {'cd.phisext'});
model.result('pg5').feature('line1').set('linetype', 'tube');
model.result('pg5').feature('line1').set('inherittubescale', false);
model.result('pg6').create('surf1', 'Surface');
model.result('pg6').feature('surf1').set('expr', {'cd.phisext'});
model.result.create('pg7', 'PlotGroup2D');
model.result('pg7').set('data', 'dset1');
model.result('pg7').label('Electrode Potential vs. Adjacent Reference (cd)');
model.result.create('pg8', 'PlotGroup3D');
model.result('pg8').set('data', 'rev1');
model.result('pg8').label('Electrode Potential vs. Adjacent Reference, 3D (cd)');
model.result('pg7').create('str1', 'Streamline');
model.result('pg7').feature('str1').set('expr', {'cd.Ilr' 'cd.Ilz'});
model.result('pg7').feature('str1').set('posmethod', 'uniform');
model.result('pg7').feature('str1').set('recover', 'pprint');
model.result('pg7').feature('str1').set('pointtype', 'arrow');
model.result('pg7').feature('str1').set('arrowlength', 'logarithmic');
model.result('pg7').feature('str1').set('color', 'gray');
model.result('pg8').create('str1', 'Streamline');
model.result('pg8').feature('str1').set('revcoordsys', 'cylindrical');
model.result('pg8').feature('str1').set('expr', {'cd.Ilr' 'cd.Ilphi' 'cd.Ilz'});
model.result('pg8').feature('str1').set('pointtype', 'arrow');
model.result('pg8').feature('str1').set('arrowlength', 'logarithmic');
model.result('pg8').feature('str1').set('color', 'gray');
model.result('pg7').create('line1', 'Line');
model.result('pg7').feature('line1').set('expr', {'cd.Evsref'});
model.result('pg7').feature('line1').set('linetype', 'tube');
model.result('pg7').feature('line1').set('inherittubescale', false);
model.result('pg8').create('surf1', 'Surface');
model.result('pg8').feature('surf1').set('expr', {'cd.Evsref'});
model.result('pg1').run;

model.sol('sol1').copySolution('sol2');
model.sol('sol2').label('Primary');

model.result.create('pg9', 'PlotGroup1D');
model.result('pg9').run;
model.result('pg9').set('data', 'dset2');
model.result('pg9').create('lngr1', 'LineGraph');
model.result('pg9').feature('lngr1').set('markerpos', 'datapoints');
model.result('pg9').feature('lngr1').set('linewidth', 'preference');
model.result('pg9').feature('lngr1').selection.named('sel1');
model.result('pg9').feature('lngr1').set('expr', 'cd.iloc_er1/i_app');
model.result('pg9').feature('lngr1').set('descractive', true);
model.result('pg9').feature('lngr1').set('descr', 'Normalized current density');
model.result('pg9').feature('lngr1').set('xdata', 'expr');
model.result('pg9').feature('lngr1').set('xdataexpr', 'z');
model.result('pg9').feature('lngr1').set('xdatadescractive', true);
model.result('pg9').feature('lngr1').set('xdatadescr', 'Distance along the working electrode');
model.result('pg9').feature('lngr1').set('legend', true);
model.result('pg9').feature('lngr1').set('legendmethod', 'manual');
model.result('pg9').feature('lngr1').setIndex('legends', 'Numerical', 0);
model.result('pg9').run;
model.result('pg9').feature.duplicate('lngr2', 'lngr1');
model.result('pg9').run;
model.result('pg9').feature('lngr2').set('expr', 'i_analytical');
model.result('pg9').feature('lngr2').set('titletype', 'none');
model.result('pg9').feature('lngr2').setIndex('legends', 'Analytical', 0);
model.result('pg9').run;
model.result('pg9').run;
model.result('pg9').label('Normalized Current Density, Primary');

model.physics('cd').prop('CurrentDistributionType').set('CurrentDistributionType', 'Secondary');
model.physics('cd').feature('es1').feature('er1').set('ElectrodeKinetics', 'CathodicTafelEquation');
model.physics('cd').feature('es1').feature('er1').set('i0', 'i0');
model.physics('cd').feature('es1').feature('er1').set('Ac', 'Ac');

model.study('std1').feature('stat').set('useparam', true);
model.study('std1').feature('stat').setIndex('pname', 'sigma', 0);
model.study('std1').feature('stat').setIndex('plistarr', '', 0);
model.study('std1').feature('stat').setIndex('punit', 'S/m', 0);
model.study('std1').feature('stat').setIndex('pname', 'sigma', 0);
model.study('std1').feature('stat').setIndex('plistarr', '', 0);
model.study('std1').feature('stat').setIndex('punit', 'S/m', 0);
model.study('std1').feature('stat').setIndex('pname', 'i_app', 0);
model.study('std1').feature('stat').setIndex('plistarr', '-5, -10, -20, -40, -60, -80, -100, -140, -180', 0);

model.sol('sol1').study('std1');
model.sol('sol1').feature.remove('s1');
model.sol('sol1').feature.remove('v1');
model.sol('sol1').feature.remove('st1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'stat');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').feature('comp1_phil').set('scalemethod', 'manual');
model.sol('sol1').feature('v1').feature('comp1_cd_es1_phisext').set('scalemethod', 'manual');
model.sol('sol1').feature('v1').feature('comp1_phil').set('scaleval', '1');
model.sol('sol1').feature('v1').feature('comp1_cd_es1_phisext').set('scaleval', '1');
model.sol('sol1').feature('v1').set('control', 'stat');
model.sol('sol1').create('s1', 'Stationary');
model.sol('sol1').feature('s1').set('stol', 1.0E-4);
model.sol('sol1').feature('s1').create('p1', 'Parametric');
model.sol('sol1').feature('s1').feature.remove('pDef');
model.sol('sol1').feature('s1').feature('p1').set('porder', 'constant');
model.sol('sol1').feature('s1').feature('p1').set('control', 'stat');
model.sol('sol1').feature('s1').set('control', 'stat');
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

model.result('pg1').run;

model.sol('sol1').copySolution('sol3');
model.sol('sol3').label('Secondary');

model.result.create('pg10', 'PlotGroup1D');
model.result('pg10').run;
model.result('pg10').set('data', 'dset3');
model.result('pg10').create('lngr1', 'LineGraph');
model.result('pg10').feature('lngr1').set('markerpos', 'datapoints');
model.result('pg10').feature('lngr1').set('linewidth', 'preference');
model.result('pg10').feature('lngr1').selection.named('sel1');
model.result('pg10').feature('lngr1').set('expr', 'cd.eta_er1');
model.result('pg10').feature('lngr1').set('descr', 'Overpotential');
model.result('pg10').feature('lngr1').set('descractive', true);
model.result('pg10').feature('lngr1').set('xdata', 'expr');
model.result('pg10').feature('lngr1').set('xdataexpr', 'z');
model.result('pg10').feature('lngr1').set('xdatadescractive', true);
model.result('pg10').feature('lngr1').set('xdatadescr', 'Distance along the working electrode');
model.result('pg10').feature('lngr1').set('legend', true);
model.result('pg10').run;
model.result('pg10').run;
model.result('pg10').label('Overpotential, Secondary');
model.result.duplicate('pg11', 'pg10');
model.result('pg11').run;
model.result('pg11').run;
model.result('pg11').feature('lngr1').set('expr', 'cd.iloc_er1/i_app');
model.result('pg11').feature('lngr1').set('descr', 'Normalized current density');
model.result('pg11').run;
model.result('pg11').run;
model.result('pg11').label('Normalized Current Density, Secondary');

model.physics.create('tds', 'DilutedSpecies', 'geom1', {'c'});

model.study('std1').feature('stat').setSolveFor('/physics/tds', true);

model.physics('tds').selection.named('geom1_r1_dom');
model.physics('tds').prop('TransportMechanism').set('Convection', false);
model.physics('tds').feature('cdm1').set('D_c', {'D' '0' '0' '0' 'D' '0' '0' '0' 'D'});
model.physics('tds').feature('init1').setIndex('initc', 'cb', 0);
model.physics('tds').create('conc1', 'Concentration', 1);
model.physics('tds').feature('conc1').selection.set([7]);
model.physics('tds').feature('conc1').setIndex('species', true, 0);
model.physics('tds').feature('conc1').setIndex('c0', 'cb', 0);
model.physics('tds').create('eeic1', 'ElectrodeElectrolyteInterfaceCoupling', 1);
model.physics('tds').feature('eeic1').selection.named('sel1');
model.physics('tds').feature('eeic1').feature('rc1').set('iloc_src', 'root.comp1.cd.es1.er1.iloc');
model.physics('tds').feature('eeic1').feature('rc1').set('nm', 2);
model.physics('tds').feature('eeic1').feature('rc1').setIndex('Vib', -1, 0);
model.physics('cd').feature('es1').feature('er1').set('i0', 'i0*(c/cb)');

model.study('std1').feature('stat').setIndex('plistarr', '-1, -5, -10, -20, -40, -60, -80, -100, -130', 0);

model.mesh('mesh1').stat.selection.geom(2);
model.mesh('mesh1').stat.selection.set([2]);

model.sol('sol1').study('std1');
model.sol('sol1').feature.remove('s1');
model.sol('sol1').feature.remove('v1');
model.sol('sol1').feature.remove('st1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'stat');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').feature('comp1_phil').set('scalemethod', 'manual');
model.sol('sol1').feature('v1').feature('comp1_cd_es1_phisext').set('scalemethod', 'manual');
model.sol('sol1').feature('v1').feature('comp1_phil').set('scaleval', '1');
model.sol('sol1').feature('v1').feature('comp1_cd_es1_phisext').set('scaleval', '1');
model.sol('sol1').feature('v1').set('control', 'stat');
model.sol('sol1').create('s1', 'Stationary');
model.sol('sol1').feature('s1').set('stol', 1.0E-4);
model.sol('sol1').feature('s1').create('p1', 'Parametric');
model.sol('sol1').feature('s1').feature.remove('pDef');
model.sol('sol1').feature('s1').feature('p1').set('porder', 'constant');
model.sol('sol1').feature('s1').feature('p1').set('control', 'stat');
model.sol('sol1').feature('s1').set('control', 'stat');
model.sol('sol1').feature('s1').feature('aDef').set('cachepattern', true);
model.sol('sol1').feature('s1').create('seDef', 'Segregated');
model.sol('sol1').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('s1').feature('fc1').set('dtech', 'auto');
model.sol('sol1').feature('s1').feature('fc1').set('maxiter', 50);
model.sol('sol1').feature('s1').feature('fc1').set('minstep', 1.0E-6);
model.sol('sol1').feature('s1').feature('fc1').set('initstep', 0.01);
model.sol('sol1').feature('s1').create('d1', 'Direct');
model.sol('sol1').feature('s1').feature('d1').set('linsolver', 'pardiso');
model.sol('sol1').feature('s1').feature('d1').set('pivotperturb', 1.0E-13);
model.sol('sol1').feature('s1').feature('d1').label('Direct (cd) (Merged)');
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
model.sol('sol1').feature('s1').create('i3', 'Iterative');
model.sol('sol1').feature('s1').feature('i3').set('linsolver', 'gmres');
model.sol('sol1').feature('s1').feature('i3').set('prefuntype', 'left');
model.sol('sol1').feature('s1').feature('i3').set('itrestart', 50);
model.sol('sol1').feature('s1').feature('i3').set('rhob', 400);
model.sol('sol1').feature('s1').feature('i3').set('maxlinit', 1000);
model.sol('sol1').feature('s1').feature('i3').set('nlinnormuse', 'on');
model.sol('sol1').feature('s1').feature('i3').label('AMG, concentrations (tds)');
model.sol('sol1').feature('s1').feature('i3').create('mg1', 'Multigrid');
model.sol('sol1').feature('s1').feature('i3').feature('mg1').set('prefun', 'saamg');
model.sol('sol1').feature('s1').feature('i3').feature('mg1').set('mgcycle', 'v');
model.sol('sol1').feature('s1').feature('i3').feature('mg1').set('maxcoarsedof', 50000);
model.sol('sol1').feature('s1').feature('i3').feature('mg1').set('strconn', 0.01);
model.sol('sol1').feature('s1').feature('i3').feature('mg1').set('nullspace', 'constant');
model.sol('sol1').feature('s1').feature('i3').feature('mg1').set('usesmooth', false);
model.sol('sol1').feature('s1').feature('i3').feature('mg1').set('saamgcompwise', true);
model.sol('sol1').feature('s1').feature('i3').feature('mg1').set('loweramg', true);
model.sol('sol1').feature('s1').feature('i3').feature('mg1').set('compactaggregation', false);
model.sol('sol1').feature('s1').feature('i3').feature('mg1').feature('pr').create('sl1', 'SORLine');
model.sol('sol1').feature('s1').feature('i3').feature('mg1').feature('pr').feature('sl1').set('linesweeptype', 'ssor');
model.sol('sol1').feature('s1').feature('i3').feature('mg1').feature('pr').feature('sl1').set('iter', 1);
model.sol('sol1').feature('s1').feature('i3').feature('mg1').feature('pr').feature('sl1').set('linerelax', 0.7);
model.sol('sol1').feature('s1').feature('i3').feature('mg1').feature('pr').feature('sl1').set('linealgorithm', 'mesh');
model.sol('sol1').feature('s1').feature('i3').feature('mg1').feature('pr').feature('sl1').set('linemethod', 'coupled');
model.sol('sol1').feature('s1').feature('i3').feature('mg1').feature('pr').feature('sl1').set('seconditer', 1);
model.sol('sol1').feature('s1').feature('i3').feature('mg1').feature('pr').feature('sl1').set('relax', 0.5);
model.sol('sol1').feature('s1').feature('i3').feature('mg1').feature('po').create('sl1', 'SORLine');
model.sol('sol1').feature('s1').feature('i3').feature('mg1').feature('po').feature('sl1').set('linesweeptype', 'ssor');
model.sol('sol1').feature('s1').feature('i3').feature('mg1').feature('po').feature('sl1').set('iter', 1);
model.sol('sol1').feature('s1').feature('i3').feature('mg1').feature('po').feature('sl1').set('linerelax', 0.7);
model.sol('sol1').feature('s1').feature('i3').feature('mg1').feature('po').feature('sl1').set('linealgorithm', 'mesh');
model.sol('sol1').feature('s1').feature('i3').feature('mg1').feature('po').feature('sl1').set('linemethod', 'coupled');
model.sol('sol1').feature('s1').feature('i3').feature('mg1').feature('po').feature('sl1').set('seconditer', 1);
model.sol('sol1').feature('s1').feature('i3').feature('mg1').feature('po').feature('sl1').set('relax', 0.5);
model.sol('sol1').feature('s1').feature('i3').feature('mg1').feature('cs').create('d1', 'Direct');
model.sol('sol1').feature('s1').feature('i3').feature('mg1').feature('cs').feature('d1').set('linsolver', 'pardiso');
model.sol('sol1').feature('s1').feature('i3').feature('mg1').feature('cs').feature('d1').set('pivotperturb', 1.0E-13);
model.sol('sol1').feature('s1').feature('fc1').set('linsolver', 'd1');
model.sol('sol1').feature('s1').feature('fc1').set('dtech', 'auto');
model.sol('sol1').feature('s1').feature('fc1').set('maxiter', 50);
model.sol('sol1').feature('s1').feature('fc1').set('minstep', 1.0E-6);
model.sol('sol1').feature('s1').feature('fc1').set('initstep', 0.01);
model.sol('sol1').feature('s1').feature.remove('fcDef');
model.sol('sol1').feature('s1').feature.remove('seDef');
model.sol('sol1').attach('std1');
model.sol('sol1').runAll;

model.result('pg1').run;
model.result.create('pg12', 'PlotGroup1D');
model.result('pg12').run;
model.result('pg12').create('lngr1', 'LineGraph');
model.result('pg12').feature('lngr1').set('markerpos', 'datapoints');
model.result('pg12').feature('lngr1').set('linewidth', 'preference');
model.result('pg12').feature('lngr1').selection.named('sel1');
model.result('pg12').feature('lngr1').set('expr', 'cd.eta_er1');
model.result('pg12').feature('lngr1').set('descr', 'Overpotential');
model.result('pg12').feature('lngr1').set('descractive', true);
model.result('pg12').feature('lngr1').set('xdata', 'expr');
model.result('pg12').feature('lngr1').set('xdataexpr', 'z');
model.result('pg12').feature('lngr1').set('xdatadescractive', true);
model.result('pg12').feature('lngr1').set('xdatadescr', 'Distance along the working electrode');
model.result('pg12').feature('lngr1').set('legend', true);
model.result('pg12').run;
model.result('pg12').run;
model.result('pg12').label('Overpotential, Tertiary');
model.result.duplicate('pg13', 'pg12');
model.result('pg13').run;
model.result('pg13').run;
model.result('pg13').feature('lngr1').set('expr', 'cd.iloc_er1');
model.result('pg13').feature('lngr1').set('descr', 'Local current density');
model.result('pg13').run;
model.result('pg13').run;
model.result('pg13').label('Local Current Density, Tertiary');
model.result.duplicate('pg14', 'pg13');
model.result('pg14').run;
model.result('pg14').run;
model.result('pg14').feature('lngr1').set('expr', 'c/cb');
model.result('pg14').feature('lngr1').set('descr', 'Normalized concentration');
model.result('pg14').run;
model.result('pg14').run;
model.result('pg14').label('Normalized Concentration, Tertiary');
model.result.create('pg15', 'PlotGroup1D');
model.result('pg15').run;
model.result('pg15').set('data', 'none');
model.result('pg15').create('lngr1', 'LineGraph');
model.result('pg15').feature('lngr1').set('markerpos', 'datapoints');
model.result('pg15').feature('lngr1').set('linewidth', 'preference');
model.result('pg15').feature('lngr1').set('data', 'dset2');
model.result('pg15').feature('lngr1').selection.named('sel1');
model.result('pg15').feature('lngr1').set('expr', 'cd.iloc_er1/i_app');
model.result('pg15').feature('lngr1').set('descractive', true);
model.result('pg15').feature('lngr1').set('descr', 'Normalized current density');
model.result('pg15').feature('lngr1').set('xdata', 'expr');
model.result('pg15').feature('lngr1').set('xdataexpr', 'z');
model.result('pg15').feature('lngr1').set('xdatadescractive', true);
model.result('pg15').feature('lngr1').set('xdatadescr', 'Distance along the working electrode');
model.result('pg15').feature('lngr1').set('legend', true);
model.result('pg15').feature('lngr1').set('legendmethod', 'manual');
model.result('pg15').feature('lngr1').setIndex('legends', 'Primary', 0);
model.result('pg15').run;
model.result('pg15').feature.duplicate('lngr2', 'lngr1');
model.result('pg15').run;
model.result('pg15').feature('lngr2').set('data', 'dset3');
model.result('pg15').feature('lngr2').setIndex('looplevelinput', 'manual', 0);
model.result('pg15').feature('lngr2').setIndex('looplevel', [7], 0);
model.result('pg15').feature('lngr2').set('titletype', 'none');
model.result('pg15').feature('lngr2').setIndex('legends', 'Secondary', 0);
model.result('pg15').run;
model.result('pg15').feature.duplicate('lngr3', 'lngr2');
model.result('pg15').run;
model.result('pg15').feature('lngr3').set('data', 'dset1');
model.result('pg15').feature('lngr3').setIndex('looplevel', [8], 0);
model.result('pg15').feature('lngr3').setIndex('legends', 'Tertiary', 0);
model.result('pg15').run;
model.result('pg15').run;
model.result('pg15').label('Current Density Comparison');
model.result('pg2').run;

model.title('Rotating Cylinder Hull Cell');

model.description('This 2D axisymmetric example models and compares primary, secondary, and tertiary current distributions in a rotating cylinder Hull cell.');

model.label('rotating_cylinder_hull_cell.mph');

model.modelNode.label('Components');

out = model;
