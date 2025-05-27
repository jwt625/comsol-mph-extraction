function out = model
%
% dna_degradation.m
%
% Model exported on May 26 2025, 21:27 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/Chemical_Reaction_Engineering_Module/Ideal_Tank_Reactors');

model.modelNode.create('comp1', true);

model.physics.create('re', 'ReactionEng');
model.physics('re').model('comp1');

model.study.create('std1');
model.study('std1').create('time', 'Transient');
model.study('std1').feature('time').setSolveFor('/physics/re', true);

% To import content from file, use:
% model.param.loadFile('FILENAME');
model.param.set('k1', '1e-3[1/s]', 'Forward rate constant');
model.param.set('k2', '1e-3[1/s]', 'Forward rate constant');
model.param.set('k3', '1e-3[1/s]', 'Forward rate constant');
model.param.set('c_SC_init', '10[ng/ul]/M_pDNA', 'Initial concentration');
model.param.set('M_pDNA', '1.95e6[g/mol]', 'Molecular weight');
model.param.set('c_H2O_init', '1000[kg/m^3]/18[g/mol]', 'Initial concentration');

model.physics('re').prop('mixture').set('mixture', 'liquid');
model.physics('re').create('rch1', 'ReactionChem', -1);
model.physics('re').feature('rch1').set('formula', 'SC=>OC');
model.physics('re').feature('rch1').set('kf', 'k1');
model.physics('re').feature('SC').set('enableChemicalFormulaCheckbox', false);
model.physics('re').feature('OC').set('enableChemicalFormulaCheckbox', false);
model.physics('re').create('rch2', 'ReactionChem', -1);
model.physics('re').feature('rch2').set('formula', 'OC=>L');
model.physics('re').feature('rch2').set('kf', 'k2');
model.physics('re').create('rch3', 'ReactionChem', -1);
model.physics('re').feature('rch3').set('formula', 'L=>F');
model.physics('re').feature('rch3').set('kf', 'k3');
model.physics('re').feature('F').set('enableChemicalFormulaCheckbox', false);
model.physics('re').create('spec1', 'SpeciesChem', -1);
model.physics('re').feature('spec1').set('specName', 'H2O');
model.physics('re').feature('H2O').set('sType', 'solvent');
model.physics('re').feature('inits1').setIndex('initialValue', 'c_H2O_init', 1, 0);
model.physics('re').feature('inits1').setIndex('initialValue', 'c_SC_init', 4, 0);

model.common.create('glso1', 'GlobalLeastSquaresObjective', 'comp1');
model.common('glso1').set('filename', 'dna_degradation_experiment1.csv');
model.common('glso1').setEntry('modelExpression', 'col2', 're.c_SC*M_pDNA');
model.common('glso1').setEntry('variableName', 'col2', 'SC');
model.common('glso1').setEntry('unit', 'col2', 'ng/ul');
model.common('glso1').setEntry('modelExpression', 'col3', 're.c_OC*M_pDNA');
model.common('glso1').setEntry('variableName', 'col3', 'OC');
model.common('glso1').setEntry('unit', 'col3', 'ng/ul');
model.common('glso1').setEntry('modelExpression', 'col4', 're.c_L*M_pDNA');
model.common('glso1').setEntry('variableName', 'col4', 'L');
model.common('glso1').setEntry('unit', 'col4', 'ng/ul');

model.study('std1').feature('time').set('tlist', '0 3600');

model.sol.create('sol1');
model.sol('sol1').study('std1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'time');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').set('control', 'time');
model.sol('sol1').create('t1', 'Time');
model.sol('sol1').feature('t1').set('tlist', '0 3600');
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
model.sol('sol1').feature('t1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('t1').feature('fc1').set('dtech', 'auto');
model.sol('sol1').feature('t1').feature('fc1').set('linsolver', 'dDef');
model.sol('sol1').feature('t1').feature('fc1').set('dtech', 'auto');
model.sol('sol1').feature('t1').feature.remove('fcDef');
model.sol('sol1').attach('std1');
model.sol('sol1').runAll;

model.result.create('pg1', 'PlotGroup1D');
model.result('pg1').set('data', 'dset1');
model.result('pg1').create('glob1', 'Global');
model.result('pg1').feature('glob1').set('expr', {'re.c_SC' 're.c_OC' 're.c_L' 're.c_F'});
model.result('pg1').feature('glob1').set('descr', {'Concentration' 'Concentration' 'Concentration' 'Concentration'});
model.result('pg1').feature('glob1').set('unit', {'' '' '' ''});
model.result('pg1').feature('glob1').set('expr', {'re.c_SC' 're.c_OC' 're.c_L' 're.c_F'});
model.result('pg1').feature('glob1').set('descr', {'Concentration' 'Concentration' 'Concentration' 'Concentration'});
model.result('pg1').label('Concentration (re)');
model.result('pg1').feature('glob1').set('xdatasolnumtype', 'level1');
model.result('pg1').run;

model.study('std1').create('lsqo', 'LSQOptimization');
model.study('std1').feature('lsqo').setIndex('pname', 'k1', 0);
model.study('std1').feature('lsqo').setIndex('initval', '1e-3[1/s]', 0);
model.study('std1').feature('lsqo').setIndex('scale', 1, 0);
model.study('std1').feature('lsqo').setIndex('lbound', '', 0);
model.study('std1').feature('lsqo').setIndex('ubound', '', 0);
model.study('std1').feature('lsqo').setIndex('pname', 'k1', 0);
model.study('std1').feature('lsqo').setIndex('initval', '1e-3[1/s]', 0);
model.study('std1').feature('lsqo').setIndex('scale', 1, 0);
model.study('std1').feature('lsqo').setIndex('lbound', '', 0);
model.study('std1').feature('lsqo').setIndex('ubound', '', 0);
model.study('std1').feature('lsqo').setIndex('pname', 'k2', 1);
model.study('std1').feature('lsqo').setIndex('initval', '1e-3[1/s]', 1);
model.study('std1').feature('lsqo').setIndex('scale', 1, 1);
model.study('std1').feature('lsqo').setIndex('lbound', '', 1);
model.study('std1').feature('lsqo').setIndex('ubound', '', 1);
model.study('std1').feature('lsqo').setIndex('pname', 'k2', 1);
model.study('std1').feature('lsqo').setIndex('initval', '1e-3[1/s]', 1);
model.study('std1').feature('lsqo').setIndex('scale', 1, 1);
model.study('std1').feature('lsqo').setIndex('lbound', '', 1);
model.study('std1').feature('lsqo').setIndex('ubound', '', 1);
model.study('std1').feature('lsqo').setIndex('pname', 'k3', 2);
model.study('std1').feature('lsqo').setIndex('initval', '1e-3[1/s]', 2);
model.study('std1').feature('lsqo').setIndex('scale', 1, 2);
model.study('std1').feature('lsqo').setIndex('lbound', '', 2);
model.study('std1').feature('lsqo').setIndex('ubound', '', 2);
model.study('std1').feature('lsqo').setIndex('pname', 'k3', 2);
model.study('std1').feature('lsqo').setIndex('initval', '1e-3[1/s]', 2);
model.study('std1').feature('lsqo').setIndex('scale', 1, 2);
model.study('std1').feature('lsqo').setIndex('lbound', '', 2);
model.study('std1').feature('lsqo').setIndex('ubound', '', 2);
model.study('std1').feature('lsqo').setIndex('pname', 'c_SC_init', 3);
model.study('std1').feature('lsqo').setIndex('initval', '10[ng/ul]/M_pDNA', 3);
model.study('std1').feature('lsqo').setIndex('scale', 1, 3);
model.study('std1').feature('lsqo').setIndex('lbound', '', 3);
model.study('std1').feature('lsqo').setIndex('ubound', '', 3);
model.study('std1').feature('lsqo').setIndex('pname', 'c_SC_init', 3);
model.study('std1').feature('lsqo').setIndex('initval', '10[ng/ul]/M_pDNA', 3);
model.study('std1').feature('lsqo').setIndex('scale', 1, 3);
model.study('std1').feature('lsqo').setIndex('lbound', '', 3);
model.study('std1').feature('lsqo').setIndex('ubound', '', 3);
model.study('std1').feature('lsqo').setIndex('scale', '1e-3', 0);
model.study('std1').feature('lsqo').setIndex('lbound', 0, 0);
model.study('std1').feature('lsqo').setIndex('scale', '1e-3', 1);
model.study('std1').feature('lsqo').setIndex('lbound', 0, 1);
model.study('std1').feature('lsqo').setIndex('scale', '1e-3', 2);
model.study('std1').feature('lsqo').setIndex('lbound', 0, 2);
model.study('std1').feature('lsqo').setIndex('scale', '10[ng/ul]/M_pDNA', 3);
model.study('std1').feature('lsqo').setIndex('lbound', 0, 3);
model.study('std1').feature('lsqo').set('opttolinner', '0.0001');

model.result('pg1').run;
model.result('pg1').set('titletype', 'none');
model.result('pg1').set('xlabelactive', true);
model.result('pg1').set('ylabelactive', true);
model.result('pg1').set('ylabel', 'Concentration (kg/m<sup>3</sup>)');
model.result('pg1').run;
model.result('pg1').feature('glob1').label('Simulation Data');
model.result('pg1').feature('glob1').setIndex('expr', 're.c_SC*M_pDNA', 0);
model.result('pg1').feature('glob1').setIndex('descr', 'SC', 0);
model.result('pg1').feature('glob1').setIndex('expr', 're.c_OC*M_pDNA', 1);
model.result('pg1').feature('glob1').setIndex('descr', 'OC', 1);
model.result('pg1').feature('glob1').setIndex('expr', 're.c_L*M_pDNA', 2);
model.result('pg1').feature('glob1').setIndex('descr', 'L', 2);
model.result('pg1').feature('glob1').setIndex('expr', '', 3);
model.result('pg1').feature('glob1').set('linestyle', 'cycle');
model.result('pg1').feature('glob1').set('linewidth', 2);
model.result('pg1').feature('glob1').set('linecolor', 'blue');
model.result('pg1').feature('glob1').set('autodescr', true);
model.result('pg1').feature('glob1').set('autosolution', false);
model.result('pg1').feature('glob1').set('autoexpr', false);
model.result('pg1').feature('glob1').set('legendprefix', 'Simulation ');
model.result.table.create('tbl1', 'Table');
model.result.table('tbl1').importData('dna_degradation_experiment1.csv');
model.result('pg1').run;
model.result('pg1').create('tblp1', 'Table');
model.result('pg1').feature('tblp1').set('markerpos', 'datapoints');
model.result('pg1').feature('tblp1').set('linewidth', 'preference');
model.result('pg1').feature('tblp1').label('Experimental Data');
model.result('pg1').feature('tblp1').set('preprocy', 'linear');
model.result('pg1').feature('tblp1').set('scalingy', '1/1000');
model.result('pg1').feature('tblp1').set('linestyle', 'none');
model.result('pg1').feature('tblp1').set('linemarker', 'cycle');
model.result('pg1').feature('tblp1').set('legend', true);
model.result('pg1').feature('tblp1').set('legendmethod', 'manual');
model.result('pg1').feature('tblp1').setIndex('legends', 'Experiment SC', 0);
model.result('pg1').feature('tblp1').setIndex('legends', 'Experiment OC', 1);
model.result('pg1').feature('tblp1').setIndex('legends', 'Experiment L', 2);

model.study('std1').feature('lsqo').set('plot', true);

model.sol('sol1').study('std1');
model.sol('sol1').feature.remove('t1');
model.sol('sol1').feature.remove('v1');
model.sol('sol1').feature.remove('st1');

model.study('std1').feature('lsqo').set('lsqmessage', {});

model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'time');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').set('control', 'time');
model.sol('sol1').create('o1', 'Optimization');
model.sol('sol1').feature('o1').set('opttol', 0.001);
model.sol('sol1').feature('o1').set('gradorder', 'second');
model.sol('sol1').feature('o1').set('control', 'lsqo');
model.sol('sol1').feature('o1').create('t1', 'TimeAttrib');
model.sol('sol1').feature('o1').feature('t1').set('tout', 'tsteps');
model.sol('sol1').feature('o1').feature('t1').set('rtol', 1.0E-5);
model.sol('sol1').feature('o1').feature('t1').set('atolglobalvaluemethod', 'factor');
model.sol('sol1').feature('o1').feature('t1').set('reacf', true);
model.sol('sol1').feature('o1').feature('t1').set('storeudot', true);
model.sol('sol1').feature('o1').feature('t1').set('endtimeinterpolation', true);
model.sol('sol1').feature('o1').feature('t1').set('consistent', 'bweuler');
model.sol('sol1').feature('o1').feature('t1').set('control', 'time');
model.sol('sol1').feature('o1').feature('t1').set('tlistlsq', [5 60 120 180 300 420 600 900 1200 1800 2400 3000 3600]);
model.sol('sol1').feature('o1').feature('t1').set('lsqtimesout', ['      5.00' newline '      60.0' newline '       120' newline '       180' newline '       300' newline '       420' newline '       600' newline '       900' newline '  1.20e+03' newline '  1.80e+03' newline '  2.40e+03' newline '  3.00e+03' newline '  3.60e+03' newline ]);
model.sol('sol1').feature('o1').feature('t1').set('tout', 'tlist');
model.sol('sol1').feature('o1').feature('t1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('o1').feature('t1').feature('fc1').set('dtech', 'auto');
model.sol('sol1').feature('o1').feature('t1').feature('fc1').set('linsolver', 'dDef');
model.sol('sol1').feature('o1').feature('t1').feature('fc1').set('dtech', 'auto');
model.sol('sol1').feature('o1').feature('t1').feature.remove('fcDef');
model.sol('sol1').attach('std1');
model.sol('sol1').runAll;

model.result('pg1').run;

model.study('std1').feature('lsqo').set('probewindow', '');

model.result('pg1').run;
model.result('pg1').run;

model.title('Degradation of DNA in Plasma');

model.description('The delivery of plasmid DNA to target sites is a major challenge in the field of gene therapy. This example uses parameter estimation to find the rate constants of three consecutive reactions involved in a typical DNA degradation process.');

model.label('dna_degradation.mph');

model.modelNode.label('Components');

out = model;
