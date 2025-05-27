function out = model
%
% nonideal_cstr.m
%
% Model exported on May 26 2025, 21:27 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/Chemical_Reaction_Engineering_Module/Tutorials');

model.modelNode.create('comp1', true);

model.physics.create('re', 'ReactionEng');
model.physics('re').model('comp1');

model.study.create('std1');
model.study('std1').create('time', 'Transient');
model.study('std1').feature('time').setSolveFor('/physics/re', true);

% To import content from file, use:
% model.param.loadFile('FILENAME');
model.param.set('tau', '2400[s]', 'Space time, real reactor');
model.param.set('c_T0', '1000[mol/m^3]', 'Inlet concentration, real reactor');
model.param.set('c_w', '55500[mol/m^3]', 'Concentration, solvent');
model.param.set('Mn_T', '0.0132[kg/mol]', 'Molar mass, tracer');
model.param.set('rho_w', '1000[kg/m^3]', 'Density, water');
model.param.set('Vtot', '1[m^3]', 'Total real reactor volume');
model.param.set('v1', '1[m^3/s]', 'Maximum volumetric flow rate between CSTRs');
model.param.set('v0', 'Vtot/tau', 'Volumetric feed inlet rate into the real reactor');
model.param.set('alpha', '0.5', 'Volume fraction well stirred: To be estimated');
model.param.set('beta', '0.1', 'Fluid exchange ratio: To be estimated');

model.physics('re').label('Reaction Engineering - CSTR 1');
model.physics('re').tag('re1');
model.physics('re1').prop('reactor').set('reactor', 'cstrmass');
model.physics('re1').prop('mixture').set('mixture', 'liquid');
model.physics('re1').prop('reactor').set('reactorparsource', 'UserDefined');
model.physics('re1').prop('reactor').set('v', '(1+beta)*v0');
model.physics('re1').create('spec1', 'SpeciesChem', -1);
model.physics('re1').feature('spec1').set('specName', 'T');
model.physics('re1').create('spec1', 'SpeciesChem', -1);
model.physics('re1').feature('spec1').set('specName', 'H2O');
model.physics('re1').feature('H2O').set('sType', 'solvent');
model.physics('re1').feature('T').set('M', 'Mn_T');
model.physics('re1').feature('H2O').set('rho', 'rho_w');
model.physics('re1').feature('inits1').set('Vr0', 'alpha*Vtot');
model.physics('re1').feature('inits1').setIndex('initialValue', 'c_w', 0, 0);
model.physics('re1').create('feed1', 'FeedStream', -1);
model.physics('re1').feature('feed1').set('vf', 'v0');
model.physics('re1').feature('feed1').setIndex('FeedSpeciesConcentration', 'c_w', 0, 0);
model.physics('re1').feature('feed1').setIndex('FeedSpeciesConcentration', 'c_T0', 1, 0);
model.physics('re1').create('feed2', 'FeedStream', -1);
model.physics('re1').feature('feed2').set('vf', 'v0*beta');
model.physics('re1').feature('feed2').setIndex('FeedSpeciesConcentration', 'c_w', 0, 0);
model.physics('re1').feature('feed2').setIndex('FeedSpeciesConcentration', 're2.c_T', 1, 0);
model.physics.copy('re2', 're1', 'comp1');
model.physics('re2').label('Reaction Engineering - CSTR 2');
model.physics('re2').prop('reactor').set('v', 'v0*beta');
model.physics('re2').feature('inits1').set('Vr0', '(1-alpha)*Vtot');
model.physics('re2').feature('inits1').setIndex('initialValue', 'c_w', 0, 0);
model.physics('re2').feature('feed1').set('vf', 'v0*beta');
model.physics('re2').feature('feed1').setIndex('FeedSpeciesConcentration', 're1.c_T', 1, 0);
model.physics('re2').feature.remove('feed2');

model.study('std1').label('Study 1: Initial Guess');
model.study('std1').feature('time').set('tlist', 24000);

model.sol.create('sol1');
model.sol('sol1').study('std1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'time');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').set('control', 'time');
model.sol('sol1').create('t1', 'Time');
model.sol('sol1').feature('t1').set('tlist', '24000');
model.sol('sol1').feature('t1').set('plot', 'off');
model.sol('sol1').feature('t1').set('plotgroup', 'Default');
model.sol('sol1').feature('t1').set('plotfreq', 'tout');
model.sol('sol1').feature('t1').set('probesel', 'all');
model.sol('sol1').feature('t1').set('probes', {});
model.sol('sol1').feature('t1').set('probefreq', 'tsteps');
model.sol('sol1').feature('t1').set('tout', 'tsteps');
model.sol('sol1').feature('t1').set('rtol', 1.0E-5);
model.sol('sol1').feature('t1').set('atolglobalvaluemethod', 'factor');
model.sol('sol1').feature('t1').set('reacf', true);
model.sol('sol1').feature('t1').set('storeudot', true);
model.sol('sol1').feature('t1').set('endtimeinterpolation', true);
model.sol('sol1').feature('t1').set('consistent', 'off');
model.sol('sol1').feature('t1').set('control', 'time');
model.sol('sol1').feature('t1').create('seDef', 'Segregated');
model.sol('sol1').feature('t1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('t1').feature('fc1').set('dtech', 'auto');
model.sol('sol1').feature('t1').feature('fc1').set('linsolver', 'dDef');
model.sol('sol1').feature('t1').feature('fc1').set('dtech', 'auto');
model.sol('sol1').feature('t1').feature.remove('fcDef');
model.sol('sol1').feature('t1').feature.remove('seDef');
model.sol('sol1').attach('std1');
model.sol('sol1').runAll;

model.result.create('pg1', 'PlotGroup1D');
model.result('pg1').set('data', 'dset1');
model.result('pg1').create('glob1', 'Global');
model.result('pg1').feature('glob1').set('expr', {'re1.c_T'});
model.result('pg1').feature('glob1').set('descr', {'Concentration'});
model.result('pg1').feature('glob1').set('unit', {''});
model.result('pg1').feature('glob1').set('expr', {'re1.c_T'});
model.result('pg1').feature('glob1').set('descr', {'Concentration'});
model.result('pg1').label('Concentration (re1)');
model.result('pg1').feature('glob1').set('xdatasolnumtype', 'level1');
model.result.create('pg2', 'PlotGroup1D');
model.result('pg2').set('data', 'dset1');
model.result('pg2').create('glob1', 'Global');
model.result('pg2').feature('glob1').set('expr', {'re2.c_T'});
model.result('pg2').feature('glob1').set('descr', {'Concentration'});
model.result('pg2').feature('glob1').set('unit', {''});
model.result('pg2').feature('glob1').set('expr', {'re2.c_T'});
model.result('pg2').feature('glob1').set('descr', {'Concentration'});
model.result('pg2').label('Concentration (re2)');
model.result('pg2').feature('glob1').set('xdatasolnumtype', 'level1');
model.result('pg1').run;
model.result('pg1').label('Concentration in Non-Ideal Reactor');
model.result('pg1').set('titletype', 'none');
model.result('pg1').set('xlabelactive', true);
model.result('pg1').set('ylabelactive', true);
model.result('pg1').set('ylabel', 'Tracer at reactor outlet (mol/m<sup>3</sup>)');
model.result('pg1').set('legendpos', 'middleright');
model.result('pg1').run;
model.result('pg1').feature('glob1').label('Simulation, Initial Guess');
model.result('pg1').feature('glob1').set('autoplotlabel', true);
model.result('pg1').feature('glob1').set('autosolution', false);
model.result('pg1').feature('glob1').set('autoexpr', false);
model.result('pg1').run;
model.result.table.create('tbl1', 'Table');
model.result.table('tbl1').label('Experimental Data');
model.result.table('tbl1').importData('nonideal_cstr_data.csv');
model.result('pg1').run;
model.result('pg1').create('tblp1', 'Table');
model.result('pg1').feature('tblp1').set('markerpos', 'datapoints');
model.result('pg1').feature('tblp1').set('linewidth', 'preference');
model.result('pg1').feature('tblp1').label('Experimental Data');
model.result('pg1').feature('tblp1').set('legend', true);
model.result('pg1').feature('tblp1').set('autoplotlabel', true);
model.result('pg1').feature('tblp1').set('autoheaders', false);
model.result('pg1').run;
model.result('pg1').feature('tblp1').set('linestyle', 'none');
model.result('pg1').feature('tblp1').set('linemarker', 'circle');
model.result('pg2').run;
model.result('pg2').label('Concentration in CSTRs');
model.result('pg2').set('titletype', 'none');
model.result('pg2').set('legendpos', 'middleright');
model.result('pg2').run;
model.result('pg2').feature('glob1').label('Ideal CSTR 2');
model.result('pg2').feature('glob1').set('autoplotlabel', true);
model.result('pg2').feature.duplicate('glob2', 'glob1');
model.result('pg2').run;
model.result('pg2').feature('glob2').label('Ideal CSTR 1');
model.result('pg2').feature('glob2').setIndex('expr', 're1.c_T', 0);
model.result('pg2').run;

model.common.create('glso1', 'GlobalLeastSquaresObjective', 'comp1');
model.common('glso1').set('source', 'resultTable');
model.common('glso1').setEntry('modelExpression', 'col2', 're1.c_T');
model.common('glso1').setEntry('variableName', 'col2', 'c_T');
model.common('glso1').setEntry('unit', 'col2', 'mol/m^3');

model.study.create('std2');
model.study('std2').create('time', 'Transient');
model.study('std2').feature('time').setSolveFor('/physics/re1', true);
model.study('std2').feature('time').setSolveFor('/physics/re2', true);
model.study('std2').feature('time').set('tlist', 24000);
model.study('std2').label('Study 2: Parameter Estimation');
model.study('std2').create('lsqo', 'LSQOptimization');
model.study('std2').feature('lsqo').setIndex('pname', 'tau', 0);
model.study('std2').feature('lsqo').setIndex('initval', '2400[s]', 0);
model.study('std2').feature('lsqo').setIndex('scale', 1, 0);
model.study('std2').feature('lsqo').setIndex('lbound', '', 0);
model.study('std2').feature('lsqo').setIndex('ubound', '', 0);
model.study('std2').feature('lsqo').setIndex('pname', 'tau', 0);
model.study('std2').feature('lsqo').setIndex('initval', '2400[s]', 0);
model.study('std2').feature('lsqo').setIndex('scale', 1, 0);
model.study('std2').feature('lsqo').setIndex('lbound', '', 0);
model.study('std2').feature('lsqo').setIndex('ubound', '', 0);
model.study('std2').feature('lsqo').setIndex('pname', 'c_T0', 1);
model.study('std2').feature('lsqo').setIndex('initval', '1000[mol/m^3]', 1);
model.study('std2').feature('lsqo').setIndex('scale', 1, 1);
model.study('std2').feature('lsqo').setIndex('lbound', '', 1);
model.study('std2').feature('lsqo').setIndex('ubound', '', 1);
model.study('std2').feature('lsqo').setIndex('pname', 'c_T0', 1);
model.study('std2').feature('lsqo').setIndex('initval', '1000[mol/m^3]', 1);
model.study('std2').feature('lsqo').setIndex('scale', 1, 1);
model.study('std2').feature('lsqo').setIndex('lbound', '', 1);
model.study('std2').feature('lsqo').setIndex('ubound', '', 1);
model.study('std2').feature('lsqo').setIndex('pname', 'alpha', 0);
model.study('std2').feature('lsqo').setIndex('scale', 0.5, 0);
model.study('std2').feature('lsqo').setIndex('lbound', 0, 0);
model.study('std2').feature('lsqo').setIndex('ubound', 1, 0);
model.study('std2').feature('lsqo').setIndex('pname', 'beta', 1);
model.study('std2').feature('lsqo').setIndex('scale', 0.1, 1);
model.study('std2').feature('lsqo').setIndex('lbound', 0, 1);
model.study('std2').feature('lsqo').setIndex('ubound', 1, 1);
model.study('std2').setGenPlots(false);

model.sol.create('sol2');
model.sol('sol2').study('std2');

model.study('std2').feature('lsqo').set('lsqmessage', {});

model.sol('sol2').create('st1', 'StudyStep');
model.sol('sol2').feature('st1').set('study', 'std2');
model.sol('sol2').feature('st1').set('studystep', 'time');
model.sol('sol2').create('v1', 'Variables');
model.sol('sol2').feature('v1').set('control', 'time');
model.sol('sol2').create('o1', 'Optimization');
model.sol('sol2').feature('o1').set('opttol', 0.001);
model.sol('sol2').feature('o1').set('gradorder', 'second');
model.sol('sol2').feature('o1').set('control', 'lsqo');
model.sol('sol2').feature('o1').create('t1', 'TimeAttrib');
model.sol('sol2').feature('o1').feature('t1').set('tout', 'tsteps');
model.sol('sol2').feature('o1').feature('t1').set('rtol', 1.0E-5);
model.sol('sol2').feature('o1').feature('t1').set('atolglobalvaluemethod', 'factor');
model.sol('sol2').feature('o1').feature('t1').set('reacf', true);
model.sol('sol2').feature('o1').feature('t1').set('storeudot', true);
model.sol('sol2').feature('o1').feature('t1').set('endtimeinterpolation', true);
model.sol('sol2').feature('o1').feature('t1').set('consistent', 'bweuler');
model.sol('sol2').feature('o1').feature('t1').set('control', 'time');
model.sol('sol2').feature('o1').feature('t1').set('tlistlsq', [600 1200 1800 2400 3600 6000 9000 18000 24000]);
model.sol('sol2').feature('o1').feature('t1').set('lsqtimesout', ['       600' newline '  1.20e+03' newline '  1.80e+03' newline '  2.40e+03' newline '  3.60e+03' newline '  6.00e+03' newline '  9.00e+03' newline '  1.80e+04' newline '  2.40e+04' newline ]);
model.sol('sol2').feature('o1').feature('t1').set('tout', 'tlist');
model.sol('sol2').feature('o1').feature('t1').create('seDef', 'Segregated');
model.sol('sol2').feature('o1').feature('t1').create('fc1', 'FullyCoupled');
model.sol('sol2').feature('o1').feature('t1').feature('fc1').set('dtech', 'auto');
model.sol('sol2').feature('o1').feature('t1').feature('fc1').set('linsolver', 'dDef');
model.sol('sol2').feature('o1').feature('t1').feature('fc1').set('dtech', 'auto');
model.sol('sol2').feature('o1').feature('t1').feature.remove('fcDef');
model.sol('sol2').feature('o1').feature('t1').feature.remove('seDef');
model.sol('sol2').attach('std2');
model.sol('sol2').runFromTo('st1', 'v1');

model.result('pg1').run;
model.result('pg1').create('glob2', 'Global');
model.result('pg1').feature('glob2').set('markerpos', 'datapoints');
model.result('pg1').feature('glob2').set('linewidth', 'preference');
model.result('pg1').feature('glob2').label('Simulation, Optimized');
model.result('pg1').feature('glob2').set('data', 'dset2');
model.result('pg1').feature('glob2').set('expr', {});
model.result('pg1').feature('glob2').set('descr', {});
model.result('pg1').feature('glob2').setIndex('expr', 're1.c_T', 0);
model.result('pg1').feature('glob2').set('autoplotlabel', true);
model.result('pg1').feature('glob2').set('autosolution', false);
model.result('pg1').feature('glob2').set('autoexpr', false);

model.study('std2').feature('lsqo').set('plot', true);

model.sol('sol2').study('std2');
model.sol('sol2').feature.remove('o1');
model.sol('sol2').feature.remove('v1');
model.sol('sol2').feature.remove('st1');

model.study('std2').feature('lsqo').set('lsqmessage', {});

model.sol('sol2').create('st1', 'StudyStep');
model.sol('sol2').feature('st1').set('study', 'std2');
model.sol('sol2').feature('st1').set('studystep', 'time');
model.sol('sol2').create('v1', 'Variables');
model.sol('sol2').feature('v1').set('control', 'time');
model.sol('sol2').create('o1', 'Optimization');
model.sol('sol2').feature('o1').set('opttol', 0.001);
model.sol('sol2').feature('o1').set('gradorder', 'second');
model.sol('sol2').feature('o1').set('control', 'lsqo');
model.sol('sol2').feature('o1').create('t1', 'TimeAttrib');
model.sol('sol2').feature('o1').feature('t1').set('tout', 'tsteps');
model.sol('sol2').feature('o1').feature('t1').set('rtol', 1.0E-5);
model.sol('sol2').feature('o1').feature('t1').set('atolglobalvaluemethod', 'factor');
model.sol('sol2').feature('o1').feature('t1').set('reacf', true);
model.sol('sol2').feature('o1').feature('t1').set('storeudot', true);
model.sol('sol2').feature('o1').feature('t1').set('endtimeinterpolation', true);
model.sol('sol2').feature('o1').feature('t1').set('consistent', 'bweuler');
model.sol('sol2').feature('o1').feature('t1').set('control', 'time');
model.sol('sol2').feature('o1').feature('t1').set('tlistlsq', [600 1200 1800 2400 3600 6000 9000 18000 24000]);
model.sol('sol2').feature('o1').feature('t1').set('lsqtimesout', ['       600' newline '  1.20e+03' newline '  1.80e+03' newline '  2.40e+03' newline '  3.60e+03' newline '  6.00e+03' newline '  9.00e+03' newline '  1.80e+04' newline '  2.40e+04' newline ]);
model.sol('sol2').feature('o1').feature('t1').set('tout', 'tlist');
model.sol('sol2').feature('o1').feature('t1').create('seDef', 'Segregated');
model.sol('sol2').feature('o1').feature('t1').create('fc1', 'FullyCoupled');
model.sol('sol2').feature('o1').feature('t1').feature('fc1').set('dtech', 'auto');
model.sol('sol2').feature('o1').feature('t1').feature('fc1').set('linsolver', 'dDef');
model.sol('sol2').feature('o1').feature('t1').feature('fc1').set('dtech', 'auto');
model.sol('sol2').feature('o1').feature('t1').feature.remove('fcDef');
model.sol('sol2').feature('o1').feature('t1').feature.remove('seDef');
model.sol('sol2').attach('std2');
model.sol('sol2').runAll;

model.study('std2').feature('lsqo').set('probewindow', '');

model.result('pg1').run;
model.result('pg1').run;
model.result('pg1').run;
model.result('pg1').feature('glob1').create('comp1', 'Comparison');
model.result('pg1').run;
model.result('pg1').feature('glob1').feature('comp1').set('metric', 'rms');
model.result('pg1').run;
model.result('pg1').run;
model.result('pg1').feature('glob2').create('comp1', 'Comparison');
model.result('pg1').run;
model.result('pg1').feature('glob2').feature('comp1').set('metric', 'rms');
model.result('pg1').run;

model.title('Parameter Estimation for Nonideal Reactor Models');

model.description('This example sets up the so-called Dead Zone Model, a nonideal reactor model. Two ideal CSTRs, one representing the well-mixed region and the other the less agitated region of the real reactor, are used for this. Two parameters relating the volume and exchange rate of the two regions are found by parameter estimation.');

model.label('nonideal_cstr.mph');

model.modelNode.label('Components');

out = model;
