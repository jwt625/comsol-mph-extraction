function out = model
%
% chlorine_scrubber.m
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
model.param.set('Temp', '273.14[K]', 'Temperature in scrubber');
model.param.set('cCl_0', '1e-11[mol/m^3]', 'Initial concentration Cl');
model.param.set('cCl2_0', '1e-2[mol/m^3]', 'Initial concentration Cl2');
model.param.set('cClO_0', '1e-11[mol/m^3]', 'Initial concentration ClO');
model.param.set('cH_0', '1e-6[mol/m^3]', 'Initial concentration H');
model.param.set('cH2O_0', '55500[mol/m^3]', 'Initial concentration H2O');
model.param.set('cHClO_0', '1e-11[mol/m^3]', 'Initial concentration HClO');
model.param.set('cOH_0', '1e-2[mol/m^3]', 'Initial concentration OH');
model.param.set('kfreac_1', '1.565e6[m^3/(s*mol)]', 'Forward reaction constant reaction 1');
model.param.set('krreac_1', '3.485e-5[m^3/(s*mol)]', 'Reversible reaction constant reaction 1');
model.param.set('Kequi_2', '1e8*cH2O_0[m^3/mol]', 'Equilibrium constant reaction 2');
model.param.set('Kequi_3', '2.79e3*cH2O_0[m^3/mol]', 'Equilibrium constant reaction 3');
model.param.set('kfreac_4', '1.648e1[m^3/(s*mol)]/cH2O_0[m^3/mol]', 'Forward reaction constant reaction 4');
model.param.set('krreac_4', '3.7e-10[m^9/(s*mol^3)]', 'Reversible reaction constant reaction 4');

model.physics('re').prop('energybalance').set('T', 'Temp');
model.physics('re').prop('mixture').set('mixture', 'liquid');
model.physics('re').create('rch1', 'ReactionChem', -1);
model.physics('re').feature('rch1').set('formula', 'Cl2 + OH- <=> HClO + Cl-');
model.physics('re').feature('rch1').set('kf', 'kfreac_1');
model.physics('re').feature('rch1').set('kr', 'krreac_1');
model.physics('re').create('rch2', 'ReactionChem', -1);
model.physics('re').feature('rch2').set('formula', 'OH- + H+ = H2O');
model.physics('re').feature('rch2').set('Keq0', 'Kequi_2');
model.physics('re').feature('H2O').set('sType', 'solvent');
model.physics('re').create('rch3', 'ReactionChem', -1);
model.physics('re').feature('rch3').set('formula', 'HClO + OH- = ClO- + H2O');
model.physics('re').feature('rch3').set('Keq0', 'Kequi_3');
model.physics('re').create('rch4', 'ReactionChem', -1);
model.physics('re').feature('rch4').set('formula', 'Cl2 + H2O <=> ClO- + Cl- + 2 H+');
model.physics('re').feature('rch4').set('kf', 'kfreac_4');
model.physics('re').feature('rch4').set('kr', 'krreac_4');
model.physics('re').feature('inits1').setIndex('initialValue', 'cCl_0', 0, 0);
model.physics('re').feature('inits1').setIndex('initialValue', 'cCl2_0', 1, 0);
model.physics('re').feature('inits1').setIndex('initialValue', 'cClO_0', 2, 0);
model.physics('re').feature('inits1').setIndex('initialValue', 'cH_0', 3, 0);
model.physics('re').feature('inits1').setIndex('initialValue', 'cH2O_0', 4, 0);
model.physics('re').feature('inits1').setIndex('initialValue', 'cHClO_0', 5, 0);
model.physics('re').feature('inits1').setIndex('initialValue', 'cOH_0', 6, 0);

model.sol.create('sol1');
model.sol('sol1').study('std1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'time');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').set('control', 'time');
model.sol('sol1').create('t1', 'Time');
model.sol('sol1').feature('t1').set('tlist', 'range(0,0.1,1)');
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
model.sol('sol1').feature('t1').set('consistent', 'bweuler');
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
model.result('pg1').feature('glob1').set('expr', {'re.c_Cl2' 're.c_Cl_1m' 're.c_H_1p' 're.c_ClO_1m' 're.c_OH_1m' 're.c_HClO'});
model.result('pg1').feature('glob1').set('descr', {'Concentration' 'Concentration' 'Concentration' 'Concentration' 'Concentration' 'Concentration'});
model.result('pg1').feature('glob1').set('unit', {'' '' '' '' '' ''});
model.result('pg1').feature('glob1').set('expr', {'re.c_Cl2' 're.c_Cl_1m' 're.c_H_1p' 're.c_ClO_1m' 're.c_OH_1m' 're.c_HClO'});
model.result('pg1').feature('glob1').set('descr', {'Concentration' 'Concentration' 'Concentration' 'Concentration' 'Concentration' 'Concentration'});
model.result('pg1').label('Concentration (re)');
model.result('pg1').feature('glob1').set('xdatasolnumtype', 'level1');
model.result('pg1').run;
model.result('pg1').set('titletype', 'none');
model.result('pg1').set('xlog', true);
model.result('pg1').set('ylog', true);
model.result('pg1').set('legendlayout', 'outside');
model.result('pg1').run;
model.result('pg1').feature('glob1').set('expr', {'re.c_Cl2'});
model.result('pg1').feature('glob1').set('descr', {'Concentration'});
model.result('pg1').feature('glob1').set('unit', {'mol/m^3'});
model.result('pg1').feature('glob1').set('expr', {'re.c_Cl2' 're.c_OH_1m'});
model.result('pg1').feature('glob1').set('descr', {'Concentration' 'Concentration'});
model.result('pg1').feature('glob1').set('expr', {'re.c_Cl2' 're.c_OH_1m' 're.c_H_1p'});
model.result('pg1').feature('glob1').set('descr', {'Concentration' 'Concentration' 'Concentration'});
model.result('pg1').feature('glob1').set('linewidth', 2);
model.result('pg1').feature('glob1').set('legendmethod', 'manual');
model.result('pg1').feature('glob1').setIndex('legends', 'Cl<sub>2</sub>', 0);
model.result('pg1').feature('glob1').setIndex('legends', 'OH<sup>-</sup>', 1);
model.result('pg1').feature('glob1').setIndex('legends', 'H<sup>+</sup>', 2);
model.result('pg1').run;
model.result('pg1').run;

model.title('Neutralization of Chlorine in a Scrubber');

model.description('The kinetics of the neutralization of chlorine gas in a water solution within a scrubber is analyzed in this model. The modeled process includes four equilibrium reactions and assumes that the fluid volume in the scrubber is both constant and perfectly mixed.');

model.label('chlorine_scrubber.mph');

model.modelNode.label('Components');

out = model;
