function out = model
%
% ibuprofen_synthesis.m
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
model.param.set('cB_0', '0.1[mol/m^3]', 'Initial concentration B');
model.param.set('cCO_0', '1.1[mol/m^3]', 'Initial concentration CO');
model.param.set('cClion_0', '0.2[mol/m^3]', 'Initial concentration Cl-');
model.param.set('cHion_0', '0.2[mol/m^3]', 'Initial concentration H+');
model.param.set('cH2O_0', '3[mol/m^3]', 'Initial concentration H2O');
model.param.set('cpd1_0', '1.21e-2[mol/m^3]', 'Initial concentration pdl');
model.param.set('croh_0', '1.23[mol/m^3]', 'Initial concentration roh');
model.param.set('kreac_1', '7.45e-3[m^3/(s*mol)]', 'Reaction constant reaction 1');
model.param.set('kreac_2', '1.25e-2[m^6/(s*mol^2)]', 'Reaction constant reaction 2');
model.param.set('kreac_3', '1.60e-3[m^3/(s*mol)]', 'Reaction constant reaction 3');
model.param.set('kreac_4', '1.5e-1[m^6/(s*mol^2)]', 'Reaction constant reaction 4');
model.param.set('kreac_5', '1.59[m^3/(s*mol)]', 'Reaction constant reaction 5');
model.param.set('kreac_6', '2.14e-1[m^3/(s*mol)]', 'Reaction constant reaction 6');
model.param.set('kreac_7', '9.52e-1[m^3/(s*mol)]', 'Reaction constant reaction 7');
model.param.set('kfreac_8', '5e-1[m^6/(s*mol^2)]', 'Forward reaction constant reaction 8');
model.param.set('krreac_8', '1e-2[m^6/(s*mol^2)]', 'Reversible reaction constant reaction 8');

model.physics('re').prop('mixture').set('mixture', 'liquid');
model.physics('re').create('rch1', 'ReactionChem', -1);
model.physics('re').feature('rch1').set('formula', 'roh+H+=>ren+H2O+H+');
model.physics('re').feature('rch1').set('kf', 'kreac_1');
model.physics('re').create('rch2', 'ReactionChem', -1);
model.physics('re').feature('rch2').set('formula', 'ren+H++Cl-=>rhcl');
model.physics('re').feature('rch2').set('kf', 'kreac_2');
model.physics('re').create('rch3', 'ReactionChem', -1);
model.physics('re').feature('rch3').set('formula', 'rhcl+B=>ren+H++Cl-+B');
model.physics('re').feature('rch3').set('kf', 'kreac_3');
model.physics('re').create('rch4', 'ReactionChem', -1);
model.physics('re').feature('rch4').set('formula', 'pd1+CO+H2O=>pd2+Cl-+2H++CO2');
model.physics('re').feature('rch4').set('kf', 'kreac_4');
model.physics('re').create('rch5', 'ReactionChem', -1);
model.physics('re').feature('rch5').set('formula', 'pd2+rhcl=>pd3');
model.physics('re').feature('rch5').set('kf', 'kreac_5');
model.physics('re').create('rch6', 'ReactionChem', -1);
model.physics('re').feature('rch6').set('formula', 'pd3+CO=>pd4+Cl-');
model.physics('re').feature('rch6').set('kf', 'kreac_6');
model.physics('re').create('rch7', 'ReactionChem', -1);
model.physics('re').feature('rch7').set('formula', 'pd4+H2O=>pd2+H++ibu');
model.physics('re').feature('rch7').set('kf', 'kreac_7');
model.physics('re').create('rch8', 'ReactionChem', -1);
model.physics('re').feature('rch8').set('formula', 'ibu+roh+H+<=>ester+H2O+H+');
model.physics('re').feature('rch8').set('kf', 'kfreac_8');
model.physics('re').feature('rch8').set('kr', 'krreac_8');
model.physics('re').feature('inits1').setIndex('initialValue', 'cB_0', 0, 0);
model.physics('re').feature('inits1').setIndex('initialValue', 'cCO_0', 1, 0);
model.physics('re').feature('inits1').setIndex('initialValue', 'cClion_0', 3, 0);
model.physics('re').feature('inits1').setIndex('initialValue', 'cHion_0', 4, 0);
model.physics('re').feature('inits1').setIndex('initialValue', 'cH2O_0', 5, 0);
model.physics('re').feature('inits1').setIndex('initialValue', 'cpd1_0', 8, 0);
model.physics('re').feature('inits1').setIndex('initialValue', 'croh_0', 14, 0);

model.study('std1').label('Case 1');
model.study('std1').feature('time').set('tunit', 'h');
model.study('std1').feature('time').set('tlist', 'range(0,0.1,3)');
model.study('std1').feature('time').set('useadvanceddisable', true);
model.study('std1').feature('time').set('disabledphysics', {'re/rch8' 're/ester'});

model.sol.create('sol1');
model.sol('sol1').study('std1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'time');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').set('control', 'time');
model.sol('sol1').create('t1', 'Time');
model.sol('sol1').feature('t1').set('tlist', 'range(0,0.1,3)');
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
model.result('pg1').feature('glob1').set('expr', {'re.c_roh' 're.c_H_1p' 're.c_ren' 're.c_H2O' 're.c_Cl_1m' 're.c_rhcl' 're.c_B' 're.c_pd1' 're.c_CO' 're.c_pd2'  ...
're.c_CO2' 're.c_pd3' 're.c_pd4' 're.c_ibu'});
model.result('pg1').feature('glob1').set('descr', {'Concentration' 'Concentration' 'Concentration' 'Concentration' 'Concentration' 'Concentration' 'Concentration' 'Concentration' 'Concentration' 'Concentration'  ...
'Concentration' 'Concentration' 'Concentration' 'Concentration'});
model.result('pg1').feature('glob1').set('unit', {'' '' '' '' '' '' '' '' '' ''  ...
'' '' '' ''});
model.result('pg1').feature('glob1').set('expr', {'re.c_roh' 're.c_H_1p' 're.c_ren' 're.c_H2O' 're.c_Cl_1m' 're.c_rhcl' 're.c_B' 're.c_pd1' 're.c_CO' 're.c_pd2'  ...
're.c_CO2' 're.c_pd3' 're.c_pd4' 're.c_ibu'});
model.result('pg1').feature('glob1').set('descr', {'Concentration' 'Concentration' 'Concentration' 'Concentration' 'Concentration' 'Concentration' 'Concentration' 'Concentration' 'Concentration' 'Concentration'  ...
'Concentration' 'Concentration' 'Concentration' 'Concentration'});
model.result('pg1').label('Concentration (re)');
model.result('pg1').feature('glob1').set('xdatasolnumtype', 'level1');
model.result('pg1').run;
model.result('pg1').label('Case 1 - Concentrations');
model.result('pg1').set('titletype', 'none');
model.result('pg1').set('legendlayout', 'outside');
model.result('pg1').run;
model.result('pg1').feature('glob1').set('linewidth', 2);
model.result('pg1').feature('glob1').set('linemarker', 'cyclereset');
model.result('pg1').feature('glob1').set('markers', 5);
model.result('pg1').feature('glob1').set('legendmethod', 'manual');
model.result('pg1').feature('glob1').setIndex('legends', 'roh', 0);
model.result('pg1').feature('glob1').setIndex('legends', 'H<sup>+</sup>', 1);
model.result('pg1').feature('glob1').setIndex('legends', 'ren', 2);
model.result('pg1').feature('glob1').setIndex('legends', 'H<sub>2</sub>O', 3);
model.result('pg1').feature('glob1').setIndex('legends', 'Cl<sup>-</sup>', 4);
model.result('pg1').feature('glob1').setIndex('legends', 'rhcl', 5);
model.result('pg1').feature('glob1').setIndex('legends', 'B', 6);
model.result('pg1').feature('glob1').setIndex('legends', 'pd1', 7);
model.result('pg1').feature('glob1').setIndex('legends', 'CO', 8);
model.result('pg1').feature('glob1').setIndex('legends', 'pd2', 9);
model.result('pg1').feature('glob1').setIndex('legends', 'CO<sub>2</sub>', 10);
model.result('pg1').feature('glob1').setIndex('legends', 'pd3', 11);
model.result('pg1').feature('glob1').setIndex('legends', 'pd4', 12);
model.result('pg1').feature('glob1').setIndex('legends', 'ibu', 13);
model.result('pg1').run;
model.result.create('pg2', 'PlotGroup1D');
model.result('pg2').run;
model.result('pg2').label('Case 1 - Concentrations, Product and Intermediates');
model.result('pg2').set('titletype', 'none');
model.result('pg2').set('twoyaxes', true);
model.result('pg2').set('legendpos', 'middleright');
model.result('pg2').create('glob1', 'Global');
model.result('pg2').feature('glob1').set('markerpos', 'datapoints');
model.result('pg2').feature('glob1').set('linewidth', 'preference');
model.result('pg2').feature('glob1').set('expr', {});
model.result('pg2').feature('glob1').set('descr', {});
model.result('pg2').feature('glob1').setIndex('expr', 're.c_roh', 0);
model.result('pg2').feature('glob1').setIndex('expr', 're.c_ren', 1);
model.result('pg2').feature('glob1').setIndex('expr', 're.c_rhcl', 2);
model.result('pg2').feature('glob1').setIndex('expr', 're.c_ibu', 3);
model.result('pg2').feature('glob1').set('linewidth', 2);
model.result('pg2').feature('glob1').set('legendmethod', 'manual');
model.result('pg2').feature('glob1').setIndex('legends', 'roh', 0);
model.result('pg2').feature('glob1').setIndex('legends', 'ren', 1);
model.result('pg2').feature('glob1').setIndex('legends', 'rhcl', 2);
model.result('pg2').feature('glob1').setIndex('legends', 'ibu', 3);
model.result('pg2').create('glob2', 'Global');
model.result('pg2').feature('glob2').set('markerpos', 'datapoints');
model.result('pg2').feature('glob2').set('linewidth', 'preference');
model.result('pg2').feature('glob2').set('expr', {});
model.result('pg2').feature('glob2').set('descr', {});
model.result('pg2').feature('glob2').setIndex('expr', 're.c_pd3', 0);
model.result('pg2').feature('glob2').setIndex('expr', 're.c_pd4', 1);
model.result('pg2').feature('glob2').set('linewidth', 2);
model.result('pg2').feature('glob2').set('legendmethod', 'manual');
model.result('pg2').feature('glob2').setIndex('legends', 'pd3', 0);
model.result('pg2').feature('glob2').setIndex('legends', 'pd4', 1);
model.result('pg2').run;
model.result('pg2').setIndex('plotonsecyaxis', true, 1, 1);
model.result('pg2').run;

model.study.create('std2');
model.study('std2').create('time', 'Transient');
model.study('std2').feature('time').setSolveFor('/physics/re', true);
model.study('std2').label('Case 2');
model.study('std2').feature('time').set('tunit', 'h');
model.study('std2').feature('time').set('tlist', 'range(0,0.1,6)');

model.sol.create('sol2');
model.sol('sol2').study('std2');
model.sol('sol2').create('st1', 'StudyStep');
model.sol('sol2').feature('st1').set('study', 'std2');
model.sol('sol2').feature('st1').set('studystep', 'time');
model.sol('sol2').create('v1', 'Variables');
model.sol('sol2').feature('v1').set('control', 'time');
model.sol('sol2').create('t1', 'Time');
model.sol('sol2').feature('t1').set('tlist', 'range(0,0.1,6)');
model.sol('sol2').feature('t1').set('plot', 'off');
model.sol('sol2').feature('t1').set('plotgroup', 'pg1');
model.sol('sol2').feature('t1').set('plotfreq', 'tout');
model.sol('sol2').feature('t1').set('probesel', 'all');
model.sol('sol2').feature('t1').set('probes', {});
model.sol('sol2').feature('t1').set('probefreq', 'tsteps');
model.sol('sol2').feature('t1').set('tout', 'tsteps');
model.sol('sol2').feature('t1').set('rtol', 1.0E-5);
model.sol('sol2').feature('t1').set('atolglobalvaluemethod', 'factor');
model.sol('sol2').feature('t1').set('reacf', true);
model.sol('sol2').feature('t1').set('storeudot', true);
model.sol('sol2').feature('t1').set('endtimeinterpolation', true);
model.sol('sol2').feature('t1').set('consistent', 'off');
model.sol('sol2').feature('t1').set('control', 'time');
model.sol('sol2').feature('t1').create('fc1', 'FullyCoupled');
model.sol('sol2').feature('t1').feature('fc1').set('dtech', 'auto');
model.sol('sol2').feature('t1').feature('fc1').set('linsolver', 'dDef');
model.sol('sol2').feature('t1').feature('fc1').set('dtech', 'auto');
model.sol('sol2').feature('t1').feature.remove('fcDef');
model.sol('sol2').attach('std2');
model.sol('sol2').runAll;

model.result.create('pg3', 'PlotGroup1D');
model.result('pg3').set('data', 'dset2');
model.result('pg3').create('glob1', 'Global');
model.result('pg3').feature('glob1').set('expr', {'re.c_roh' 're.c_H_1p' 're.c_ren' 're.c_H2O' 're.c_Cl_1m' 're.c_rhcl' 're.c_B' 're.c_pd1' 're.c_CO' 're.c_pd2'  ...
're.c_CO2' 're.c_pd3' 're.c_pd4' 're.c_ibu' 're.c_ester'});
model.result('pg3').feature('glob1').set('descr', {'Concentration' 'Concentration' 'Concentration' 'Concentration' 'Concentration' 'Concentration' 'Concentration' 'Concentration' 'Concentration' 'Concentration'  ...
'Concentration' 'Concentration' 'Concentration' 'Concentration' 'Concentration'});
model.result('pg3').feature('glob1').set('unit', {'' '' '' '' '' '' '' '' '' ''  ...
'' '' '' '' ''});
model.result('pg3').feature('glob1').set('expr', {'re.c_roh' 're.c_H_1p' 're.c_ren' 're.c_H2O' 're.c_Cl_1m' 're.c_rhcl' 're.c_B' 're.c_pd1' 're.c_CO' 're.c_pd2'  ...
're.c_CO2' 're.c_pd3' 're.c_pd4' 're.c_ibu' 're.c_ester'});
model.result('pg3').feature('glob1').set('descr', {'Concentration' 'Concentration' 'Concentration' 'Concentration' 'Concentration' 'Concentration' 'Concentration' 'Concentration' 'Concentration' 'Concentration'  ...
'Concentration' 'Concentration' 'Concentration' 'Concentration' 'Concentration'});
model.result('pg3').label('Concentration (re)');
model.result('pg3').feature('glob1').set('xdatasolnumtype', 'level1');
model.result('pg3').run;
model.result('pg3').label('Case 2 - Concentrations');
model.result('pg3').set('titletype', 'none');
model.result('pg3').set('legendlayout', 'outside');
model.result('pg3').run;
model.result('pg3').feature('glob1').set('linewidth', 2);
model.result('pg3').feature('glob1').set('linemarker', 'cyclereset');
model.result('pg3').feature('glob1').set('markers', 5);
model.result('pg3').feature('glob1').set('legendmethod', 'manual');
model.result('pg3').feature('glob1').setIndex('legends', 'roh', 0);
model.result('pg3').feature('glob1').setIndex('legends', 'H<sup>+</sup>', 1);
model.result('pg3').feature('glob1').setIndex('legends', 'ren', 2);
model.result('pg3').feature('glob1').setIndex('legends', 'H<sub>2</sub>O', 3);
model.result('pg3').feature('glob1').setIndex('legends', 'Cl<sup>-</sup>', 4);
model.result('pg3').feature('glob1').setIndex('legends', 'rhcl', 5);
model.result('pg3').feature('glob1').setIndex('legends', 'B', 6);
model.result('pg3').feature('glob1').setIndex('legends', 'pd1', 7);
model.result('pg3').feature('glob1').setIndex('legends', 'CO', 8);
model.result('pg3').feature('glob1').setIndex('legends', 'pd2', 9);
model.result('pg3').feature('glob1').setIndex('legends', 'CO<sub>2</sub>', 10);
model.result('pg3').feature('glob1').setIndex('legends', 'pd3', 11);
model.result('pg3').feature('glob1').setIndex('legends', 'pd4', 12);
model.result('pg3').feature('glob1').setIndex('legends', 'ibu', 13);
model.result('pg3').feature('glob1').setIndex('legends', 'ester', 14);
model.result('pg3').run;
model.result('pg2').run;
model.result.duplicate('pg4', 'pg2');
model.result('pg4').run;
model.result('pg4').label('Case 2 - Concentrations, Product and Intermediates');
model.result('pg4').set('data', 'dset2');
model.result('pg4').run;
model.result('pg4').feature('glob1').setIndex('expr', 're.c_ester', 4);
model.result('pg4').feature('glob1').setIndex('legends', 'ester', 4);
model.result('pg4').run;
model.result('pg2').run;

model.title('Ibuprofen Synthesis');

model.description('Ibuprofen is an important anti-inflammatory drug, synthesized by palladium catalysis. This example illustrates the kinetic analysis of the complex reaction mechanism in a perfectly stirred batch reactor.');

model.label('ibuprofen_synthesis.mph');

model.modelNode.label('Components');

out = model;
