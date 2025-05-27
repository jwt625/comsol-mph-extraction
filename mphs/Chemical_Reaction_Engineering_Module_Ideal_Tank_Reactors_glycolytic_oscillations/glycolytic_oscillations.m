function out = model
%
% glycolytic_oscillations.m
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

model.physics('re').prop('mixture').set('mixture', 'liquid');

% To import content from file, use:
% model.param.loadFile('FILENAME');
model.param.set('J0', '50[mM/min]');
model.param.set('k1', '550[1/(mM*min)]');
model.param.set('Ki', '1[mM]');
model.param.set('k2', '9.8[1/min]');
model.param.set('kGAPDHp', '328.8[1/(mM*min)]');
model.param.set('kGAPDHm', '57823.1[1/(mM*min)]');
model.param.set('kPGKp', '76411.1[1/(mM*min)]');
model.param.set('kPGKm', '23.7[1/(mM*min)]');
model.param.set('k4', '80[1/(mM*min)]');
model.param.set('k5', '9.7[1/min]');
model.param.set('k6', '2000[1/(mM*min)]');
model.param.set('k7', '28[1/min]');
model.param.set('k8', '85.7[1/(mM*min)]');
model.param.set('kappa', '375[1/min]');
model.param.set('phi', '0.1');
model.param.set('A', '4[mM]');
model.param.set('N', '1[mM]');
model.param.set('n', '4');
model.param.set('k9', '80[1/min]');
model.param.set('A30', '1.65[mM]');
model.param.set('N20', '0.5[mM]');

model.variable.create('var1');
model.variable('var1').model('comp1');

% To import content from file, use:
% model.variable('var1').loadFile('FILENAME');
model.variable('var1').set('f_A3', '(1+(re.c_A3/Ki)^n)^-1');
model.variable('var1').set('v3_denom', '(kGAPDHm*re.c_N2+kPGKp*(A-re.c_A3))');
model.variable('var1').set('k3fwd', 'kGAPDHp*kPGKp/v3_denom');
model.variable('var1').set('k3rev', 'kGAPDHm*kPGKm/v3_denom');

model.physics('re').create('rch1', 'ReactionChem', -1);
model.physics('re').feature('rch1').set('formula', 'S1+2A3=>S2+2A2');
model.physics('re').feature('rch1').set('ReactionExpression', 'UserDefined');
model.physics('re').feature('rch1').set('r', 'k1*re.c_S1*re.c_A3*f_A3');
model.physics('re').feature('rch1').set('bulkFwdOrder', 2);
model.physics('re').create('add1', 'AdditionalSourceFeature', -1);
model.physics('re').feature('add1').label('Additional Source - J0');
model.physics('re').feature('add1').setIndex('AddR', 'J0', 2, 0);
model.physics('re').create('rch2', 'ReactionChem', -1);
model.physics('re').feature('rch2').set('formula', 'S2=>2S3');
model.physics('re').feature('rch2').set('kf', 'k2');
model.physics('re').create('rch3', 'ReactionChem', -1);
model.physics('re').feature('rch3').set('formula', 'A2+N1+S3<=>A3+N2+S4');
model.physics('re').feature('rch3').set('kf', 'k3fwd');
model.physics('re').feature('rch3').set('kr', 'k3rev');
model.physics('re').create('rch4', 'ReactionChem', -1);
model.physics('re').feature('rch4').set('formula', 'S4+A2=>S5+A3');
model.physics('re').feature('rch4').set('kf', 'k4');
model.physics('re').create('rch5', 'ReactionChem', -1);
model.physics('re').feature('rch5').set('formula', 'S5=>S6');
model.physics('re').feature('rch5').set('kf', 'k5');
model.physics('re').create('rch6', 'ReactionChem', -1);
model.physics('re').feature('rch6').set('formula', 'S6+N2=>N1');
model.physics('re').feature('rch6').set('kf', 'k6');
model.physics('re').create('rch7', 'ReactionChem', -1);
model.physics('re').feature('rch7').set('formula', 'A3=>A2');
model.physics('re').feature('rch7').set('kf', 'k7');
model.physics('re').create('rch8', 'ReactionChem', -1);
model.physics('re').feature('rch8').set('formula', 'S3+N2=>N1');
model.physics('re').feature('rch8').set('kf', 'k8');
model.physics('re').create('rch9', 'ReactionChem', -1);
model.physics('re').feature('rch9').set('formula', 'S6ex=>0S6ex');
model.physics('re').feature('rch9').set('kf', 'k9');
model.physics('re').create('rch10', 'ReactionChem', -1);
model.physics('re').feature('rch10').set('formula', 'S6<=>0.1S6ex');
model.physics('re').feature('rch10').label('J: S6<=>0.1S6ex');
model.physics('re').feature('rch10').set('r', 'kappa*(re.c_S6-re.c_S6ex)');
model.physics('re').feature('rch10').set('bulkFwdOrder', 1);
model.physics('re').feature('inits1').setIndex('initialValue', 'A-A30', 0, 0);
model.physics('re').feature('inits1').setIndex('initialValue', 'A30', 1, 0);
model.physics('re').feature('inits1').setIndex('initialValue', 'N-N20', 2, 0);
model.physics('re').feature('inits1').setIndex('initialValue', 'N20', 3, 0);
model.physics('re').feature('inits1').setIndex('initialValue', 1.09, 4, 0);
model.physics('re').feature('inits1').setIndex('initialValue', 5.1, 5, 0);
model.physics('re').feature('inits1').setIndex('initialValue', 0.55, 6, 0);
model.physics('re').feature('inits1').setIndex('initialValue', 0.66, 7, 0);
model.physics('re').feature('inits1').setIndex('initialValue', 8.31, 8, 0);
model.physics('re').feature('inits1').setIndex('initialValue', 0.08, 9, 0);
model.physics('re').feature('inits1').setIndex('initialValue', 0.02, 10, 0);

model.study('std1').feature('time').set('tlist', 'range(0,0.01,5)');
model.study('std1').feature('time').set('tunit', 'min');

model.sol.create('sol1');
model.sol('sol1').study('std1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'time');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').set('control', 'time');
model.sol('sol1').create('t1', 'Time');
model.sol('sol1').feature('t1').set('tlist', 'range(0,0.01,5)');
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
model.result('pg1').feature('glob1').set('expr', {'re.c_S1' 're.c_A3' 're.c_S2' 're.c_A2' 're.c_S3' 're.c_N1' 're.c_N2' 're.c_S4' 're.c_S5' 're.c_S6'  ...
're.c_S6ex'});
model.result('pg1').feature('glob1').set('descr', {'Concentration' 'Concentration' 'Concentration' 'Concentration' 'Concentration' 'Concentration' 'Concentration' 'Concentration' 'Concentration' 'Concentration'  ...
'Concentration'});
model.result('pg1').feature('glob1').set('unit', {'' '' '' '' '' '' '' '' '' ''  ...
''});
model.result('pg1').feature('glob1').set('expr', {'re.c_S1' 're.c_A3' 're.c_S2' 're.c_A2' 're.c_S3' 're.c_N1' 're.c_N2' 're.c_S4' 're.c_S5' 're.c_S6'  ...
're.c_S6ex'});
model.result('pg1').feature('glob1').set('descr', {'Concentration' 'Concentration' 'Concentration' 'Concentration' 'Concentration' 'Concentration' 'Concentration' 'Concentration' 'Concentration' 'Concentration'  ...
'Concentration'});
model.result('pg1').label('Concentration (re)');
model.result('pg1').feature('glob1').set('xdatasolnumtype', 'level1');
model.result('pg1').run;

model.sol('sol1').study('std1');
model.sol('sol1').feature.remove('t1');
model.sol('sol1').feature.remove('v1');
model.sol('sol1').feature.remove('st1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'time');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').set('control', 'time');
model.sol('sol1').create('t1', 'Time');
model.sol('sol1').feature('t1').set('tlist', 'range(0,0.01,5)');
model.sol('sol1').feature('t1').set('plot', 'off');
model.sol('sol1').feature('t1').set('plotgroup', 'pg1');
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

model.result('pg1').run;
model.result('pg1').set('titletype', 'none');
model.result('pg1').set('legendlayout', 'outside');
model.result('pg1').run;
model.result('pg1').feature('glob1').set('linestyle', 'cycle');
model.result('pg1').run;
model.result.duplicate('pg2', 'pg1');
model.result('pg2').run;
model.result('pg2').label('Concentration (re) ATP and NADH vs Time');
model.result('pg2').set('titletype', 'manual');
model.result('pg2').set('title', 'Concentrations of ATP and NADH (mol/m<sup>3</sup>)');
model.result('pg2').set('twoyaxes', true);
model.result('pg2').set('axislimits', true);
model.result('pg2').set('xmin', 0.01);
model.result('pg2').set('xmax', 0.5);
model.result('pg2').set('ymin', 0);
model.result('pg2').set('ymax', 4);
model.result('pg2').set('yminsec', 0);
model.result('pg2').set('showgrid', false);
model.result('pg2').run;
model.result('pg2').feature('glob1').set('expr', {});
model.result('pg2').feature('glob1').set('descr', {});
model.result('pg2').feature('glob1').setIndex('expr', 're.c_A3', 0);
model.result('pg2').feature('glob1').setIndex('unit', 'mol/m^3', 0);
model.result('pg2').feature('glob1').setIndex('descr', 'Concentration', 0);
model.result('pg2').feature.duplicate('glob2', 'glob1');
model.result('pg2').run;
model.result('pg2').feature('glob2').set('plotonsecyaxis', true);
model.result('pg2').feature('glob2').setIndex('expr', 're.c_N2', 0);
model.result('pg2').feature('glob2').setIndex('unit', 'mol/m^3', 0);
model.result('pg2').feature('glob2').setIndex('descr', 'Concentration', 0);
model.result('pg2').feature('glob2').set('legendmethod', 'manual');
model.result('pg2').feature('glob2').setIndex('legends', 're.c_N2 (NADH)', 0);
model.result('pg2').run;
model.result('pg2').feature('glob1').set('linewidth', 3);
model.result('pg2').feature('glob1').set('legendmethod', 'manual');
model.result('pg2').feature('glob1').setIndex('legends', 're.c_A3 (ATP)', 0);
model.result('pg2').run;
model.result('pg1').run;
model.result.duplicate('pg3', 'pg1');
model.result('pg3').run;
model.result('pg3').label('Mass Conservation A and N');
model.result('pg3').run;
model.result('pg3').feature('glob1').set('expr', {});
model.result('pg3').feature('glob1').set('descr', {});
model.result('pg3').feature('glob1').setIndex('expr', 're.c_N1+re.c_N2-N', 0);
model.result('pg3').feature('glob1').setIndex('unit', 'mol/m^3', 0);
model.result('pg3').feature('glob1').setIndex('descr', '', 0);
model.result('pg3').feature('glob1').setIndex('expr', 're.c_A2+re.c_A3-A', 1);
model.result('pg3').feature('glob1').setIndex('unit', 'mol/m^3', 1);
model.result('pg3').feature('glob1').setIndex('descr', '', 1);
model.result('pg3').run;

model.title('Oscillations in Metabolic Reaction Networks');

model.description('Under certain conditions, reaction rates involved in the glycolysis may exhibit a limit cycle, where the concentrations vary periodically in a manner not usually seen in chemical kinetics. Here, a lumped kinetic model from the literature is used to study how the rate of consumption of glucose varies along with the coenzyme NADH and the energy carrier ATP. The time evolution of the swings in concentration is studied in a homogeneous system, and transport processes across the cell membrane is treated in an implicit manner.');

model.label('glycolytic_oscillations.mph');

model.modelNode.label('Components');

out = model;
