function out = model
%
% glucose_sensor.m
%
% Model exported on May 26 2025, 21:27 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/Electrochemistry_Module/Electroanalysis');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 2);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.physics.create('tcd', 'TertiaryElectroanalysis', 'geom1', {'c_glucose' 'c_ferro' 'c_ferri'});

model.study.create('std1');
model.study('std1').create('stat', 'Stationary');
model.study('std1').feature('stat').setSolveFor('/physics/tcd', true);

model.geom('geom1').lengthUnit([native2unicode(hex2dec({'00' 'b5'}), 'unicode') 'm']);
model.geom('geom1').create('r1', 'Rectangle');
model.geom('geom1').feature('r1').set('size', [100 1000]);
model.geom('geom1').run('r1');
model.geom('geom1').create('pt1', 'Point');
model.geom('geom1').feature('pt1').setIndex('p', 12.5, 0);
model.geom('geom1').run('pt1');
model.geom('geom1').create('arr1', 'Array');
model.geom('geom1').feature('arr1').selection('input').set({'pt1'});
model.geom('geom1').feature('arr1').set('fullsize', [4 1]);
model.geom('geom1').feature('arr1').set('displ', [25 0]);
model.geom('geom1').run('arr1');

% To import content from file, use:
% model.param.loadFile('FILENAME');
model.param.set('c_glucose_ext', '5[umol/L]', 'External glucose concentration');
model.param.set('c_ferro_ext', '1[umol/L]', 'Ferrocyanide concentration');
model.param.set('c_ferri_ext', '50[mmol/L]', 'Ferricyanide concentration');
model.param.set('V_max', '1.5e-5[mol/L/s]', 'Maximum rate of reaction');
model.param.set('Km', '0.5[mmol/L]', 'Michaelis-Menten constant');
model.param.set('i0ref', '9.6485e7[A/m^2]', 'Reference exchange current density');

model.cpl.create('aveop1', 'Average', 'geom1');

model.geom('geom1').run;

model.cpl('aveop1').set('axisym', true);
model.cpl('aveop1').selection.geom('geom1', 1);
model.cpl('aveop1').selection.set([5]);

model.variable.create('var1');
model.variable('var1').model('comp1');
model.variable('var1').set('R_MM', 'V_max*c_glucose/(Km+c_glucose)');
model.variable('var1').descr('R_MM', 'Reaction rate of glucose');
model.variable('var1').set('i_avg', 'aveop1(tcd.itot)');
model.variable('var1').descr('i_avg', 'Average current density');

model.physics('tcd').create('es1', 'ElectrodeSurface', 1);
model.physics('tcd').feature('es1').selection.set([5]);
model.physics('tcd').feature('es1').set('phisext0', 0.4);
model.physics('tcd').feature('es1').feature('er1').setIndex('Vi0', 1, 1);
model.physics('tcd').feature('es1').feature('er1').setIndex('Vi0', -1, 2);
model.physics('tcd').feature('es1').feature('er1').set('i0_ref', 'i0ref');
model.physics('tcd').create('es2', 'ElectrodeSurface', 1);
model.physics('tcd').feature('es2').selection.set([2 7]);
model.physics('tcd').feature('es2').set('BoundaryCondition', 'CounterElectrode');
model.physics('tcd').feature('es2').set('phisext0init', 0.1);
model.physics('tcd').feature('es2').feature('er1').setIndex('Vi0', 1, 1);
model.physics('tcd').feature('es2').feature('er1').setIndex('Vi0', -1, 2);
model.physics('tcd').feature('es2').feature('er1').set('i0_ref', 'i0ref');
model.physics('tcd').create('conc1', 'Concentration', 1);
model.physics('tcd').feature('conc1').selection.set([3]);
model.physics('tcd').feature('conc1').setIndex('species', true, 0);
model.physics('tcd').feature('conc1').setIndex('c0', 'c_glucose_ext', 0);
model.physics('tcd').feature('conc1').setIndex('species', true, 1);
model.physics('tcd').feature('conc1').setIndex('c0', 'c_ferro_ext', 1);
model.physics('tcd').feature('conc1').setIndex('species', true, 2);
model.physics('tcd').feature('conc1').setIndex('c0', 'c_ferri_ext', 2);
model.physics('tcd').create('reac1', 'Reactions', 2);
model.physics('tcd').feature('reac1').selection.set([1]);
model.physics('tcd').feature('reac1').setIndex('R_c_glucose', '-R_MM', 0);
model.physics('tcd').feature('reac1').setIndex('R_c_ferro', 'R_MM', 0);
model.physics('tcd').feature('reac1').setIndex('R_c_ferri', '-R_MM', 0);
model.physics('tcd').feature('init1').setIndex('initc', 'c_glucose_ext', 0);
model.physics('tcd').feature('init1').setIndex('initc', 'c_ferro_ext', 1);
model.physics('tcd').feature('init1').setIndex('initc', 'c_ferri_ext', 2);

model.mesh('mesh1').automatic(false);
model.mesh('mesh1').feature('size').set('hauto', 2);
model.mesh('mesh1').feature('ftri1').create('size1', 'Size');
model.mesh('mesh1').feature('ftri1').feature('size1').selection.geom('geom1', 1);
model.mesh('mesh1').feature('ftri1').feature('size1').selection.set([2 4 5 6 7]);
model.mesh('mesh1').feature('ftri1').feature('size1').set('hauto', 1);
model.mesh('mesh1').feature('ftri1').feature('size1').set('custom', true);
model.mesh('mesh1').feature('ftri1').feature('size1').set('hmaxactive', true);
model.mesh('mesh1').feature('ftri1').feature('size1').set('hmax', 1);
model.mesh('mesh1').run;

model.study('std1').feature('stat').set('useparam', true);
model.study('std1').feature('stat').setIndex('pname', 'c_glucose_ext', 0);
model.study('std1').feature('stat').setIndex('plistarr', '', 0);
model.study('std1').feature('stat').setIndex('punit', 'mol/m^3', 0);
model.study('std1').feature('stat').setIndex('pname', 'c_glucose_ext', 0);
model.study('std1').feature('stat').setIndex('plistarr', '', 0);
model.study('std1').feature('stat').setIndex('punit', 'mol/m^3', 0);
model.study('std1').feature('stat').setIndex('plistarr', 'range(50,50,1000)', 0);
model.study('std1').feature('stat').setIndex('punit', 'umol/L', 0);

model.sol.create('sol1');
model.sol('sol1').study('std1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'stat');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').feature('comp1_tcd_phisCE').set('scalemethod', 'manual');
model.sol('sol1').feature('v1').feature('comp1_tcd_phisCE').set('scaleval', '1');
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
model.sol('sol1').feature('s1').feature('d1').label('Direct (tcd)');
model.sol('sol1').feature('s1').create('i1', 'Iterative');
model.sol('sol1').feature('s1').feature('i1').set('maxlinit', 1000);
model.sol('sol1').feature('s1').feature('i1').set('nlinnormuse', 'on');
model.sol('sol1').feature('s1').feature('i1').label('Algebraic Multigrid (tcd)');
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
model.sol('sol1').feature('s1').feature('i2').label('Geometric Multigrid (tcd)');
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
model.result('pg1').setIndex('looplevel', 20, 0);
model.result('pg1').label('Concentration, glucose (tcd)');
model.result('pg1').set('titletype', 'custom');
model.result('pg1').set('prefixintitle', 'Species glucose:');
model.result('pg1').set('expressionintitle', false);
model.result('pg1').set('typeintitle', true);
model.result('pg1').create('surf1', 'Surface');
model.result('pg1').feature('surf1').set('expr', {'c_glucose'});
model.result('pg1').create('str1', 'Streamline');
model.result('pg1').feature('str1').set('expr', {'tcd.tflux_c_glucosex' 'tcd.tflux_c_glucosey'});
model.result('pg1').feature('str1').set('posmethod', 'uniform');
model.result('pg1').feature('str1').set('recover', 'pprint');
model.result('pg1').feature('str1').set('pointtype', 'arrow');
model.result('pg1').feature('str1').set('arrowlength', 'logarithmic');
model.result('pg1').feature('str1').set('color', 'gray');
model.result.create('pg2', 'PlotGroup2D');
model.result('pg2').set('data', 'dset1');
model.result('pg2').setIndex('looplevel', 20, 0);
model.result('pg2').label('Concentration, ferro (tcd)');
model.result('pg2').set('titletype', 'custom');
model.result('pg2').set('prefixintitle', 'Species ferro:');
model.result('pg2').set('expressionintitle', false);
model.result('pg2').set('typeintitle', true);
model.result('pg2').create('surf1', 'Surface');
model.result('pg2').feature('surf1').set('expr', {'c_ferro'});
model.result('pg2').create('str1', 'Streamline');
model.result('pg2').feature('str1').set('expr', {'tcd.tflux_c_ferrox' 'tcd.tflux_c_ferroy'});
model.result('pg2').feature('str1').set('posmethod', 'uniform');
model.result('pg2').feature('str1').set('recover', 'pprint');
model.result('pg2').feature('str1').set('pointtype', 'arrow');
model.result('pg2').feature('str1').set('arrowlength', 'logarithmic');
model.result('pg2').feature('str1').set('color', 'gray');
model.result.create('pg3', 'PlotGroup2D');
model.result('pg3').set('data', 'dset1');
model.result('pg3').setIndex('looplevel', 20, 0);
model.result('pg3').label('Concentration, ferri (tcd)');
model.result('pg3').set('titletype', 'custom');
model.result('pg3').set('prefixintitle', 'Species ferri:');
model.result('pg3').set('expressionintitle', false);
model.result('pg3').set('typeintitle', true);
model.result('pg3').create('surf1', 'Surface');
model.result('pg3').feature('surf1').set('expr', {'c_ferri'});
model.result('pg3').create('str1', 'Streamline');
model.result('pg3').feature('str1').set('expr', {'tcd.tflux_c_ferrix' 'tcd.tflux_c_ferriy'});
model.result('pg3').feature('str1').set('posmethod', 'uniform');
model.result('pg3').feature('str1').set('recover', 'pprint');
model.result('pg3').feature('str1').set('pointtype', 'arrow');
model.result('pg3').feature('str1').set('arrowlength', 'logarithmic');
model.result('pg3').feature('str1').set('color', 'gray');
model.result('pg1').run;
model.result('pg2').run;
model.result('pg2').run;
model.result('pg2').feature('str1').active(false);
model.result('pg2').run;
model.result('pg2').set('solutionintitle', false);
model.result('pg2').set('typeintitle', false);
model.result('pg2').run;
model.result.create('pg4', 'PlotGroup1D');
model.result('pg4').run;
model.result('pg4').label('Average Current Density');
model.result('pg4').create('glob1', 'Global');
model.result('pg4').feature('glob1').set('markerpos', 'datapoints');
model.result('pg4').feature('glob1').set('linewidth', 'preference');
model.result('pg4').feature('glob1').setIndex('expr', 'i_avg', 0);
model.result('pg4').feature('glob1').set('legend', false);
model.result('pg4').run;

model.title('Glucose Sensor');

model.description(['Electrochemical glucose sensors use amperometric methods to measure the concentration of glucose in a sample. This example models the diffusion of glucose and ferri/ferrocyanide redox mediators in a unit cell of electrolyte above an interdigitated electrode. The sensor gives a linear response over a suitable range of concentrations. The Electroanalysis interface is used to couple the chemical species transport to the electrolysis at the working and counter electrodes, and the glucose is oxidized by the glucose oxidase enzyme in solution according to Michaelis' native2unicode(hex2dec({'20' '13'}), 'unicode') 'Menten kinetics.']);

model.mesh.clearMeshes;

model.sol('sol1').clearSolutionData;

model.label('glucose_sensor.mph');

model.modelNode.label('Components');

out = model;
