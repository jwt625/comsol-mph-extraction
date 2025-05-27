function out = model
%
% cstr_startup.m
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
model.param.set('Vr_tank', '1.89[m^3]', 'Tank volume');
model.param.set('v_feed', '3.47e-3[m^3/s]', 'Volumetric feed rate');
model.param.set('Ea_reaction', '75358[J/mol]', 'Forward reaction activation energy');
model.param.set('Af_reaction', '4.71e9[1/s]', 'Forward reaction frequency factor');
model.param.set('rho_C3H6O', '830[kg/m^3]', 'Density, propylene oxide');
model.param.set('rho_H2O', '1000[kg/m^3]', 'Density, water');
model.param.set('rho_C3H8O2', '1036[kg/m^3]', 'Density, propylene glycol');
model.param.set('rho_CH3OH', '792[kg/m^3]', 'Density, methanol');
model.param.set('cp_C3H6O', '146.5[J/(mol*K)]', 'Heat capacity, propylene oxide');
model.param.set('cp_H2O', '75.4[J/(mol*K)]', 'Heat capacity, water');
model.param.set('cp_C3H8O2', '192.6[J/(mol*K)]', 'Heat capacity, propylene glycol');
model.param.set('cp_CH3OH', '81.6[J/(mol*K)]', 'Heat capacity, methanol');
model.param.set('cp_exch', '75.4[J/mol/K]', 'Heat capacity, heat exchanger medium');
model.param.set('href_C3H6O', '-153.5[kJ/mol]', 'Enthalpy of formation, propylene oxide');
model.param.set('href_H2O', '-286.1[kJ/mol]', 'Enthalpy of formation, water');
model.param.set('href_C3H8O2', '-525.6[kJ/mol]', 'Enthalpy of formation, propylene glycol');
model.param.set('href_CH3OH', '-238.6[kJ/mol]', 'Enthalpy of formation, methanol');
model.param.set('Tref', '293[K]', 'Reference temperature');
model.param.set('Tfeed', '297[K]', 'Feed stream temperature');
model.param.set('Tinit', '340.0[K]', 'Initial reactor temperature');
model.param.set('Texch', '289[K]', 'Temperature of heat exchanger medium');
model.param.set('Fexch', '126[mol/s]', 'Heat exchanger molar flow rate');
model.param.set('UA', '8441[J/(s*K)]', 'Heat exchange parameter');
model.param.set('cinit_C3H6O', '1400.0[mol/m^3]', 'Initial concentration, propylene oxide');
model.param.set('cinit_H2O', '55273[mol/m^3]', 'Initial concentration, water');
model.param.set('cfeed_C3H6O', '2903[mol/m^3]', 'Feed concentration, propylene oxide');
model.param.set('cfeed_H2O', '36291[mol/m^3]', 'Feed concentration, water');
model.param.set('cfeed_CH3OH', '3629[mol/m^3]', 'Feed concentration, methanol');

model.variable.create('var1');
model.variable('var1').model('comp1');

% To import content from file, use:
% model.variable('var1').loadFile('FILENAME');
model.variable('var1').set('h_C3H6O', 'cp_C3H6O*(re.T-Tref)+href_C3H6O', 'Enthalpy, propylene oxide');
model.variable('var1').set('h_H2O', 'cp_H2O*(re.T-Tref)+href_H2O', 'Enthalpy, water');
model.variable('var1').set('h_C3H8O2', 'cp_C3H8O2*(re.T-Tref)+href_C3H8O2', 'Enthalpy, propylene glycol');
model.variable('var1').set('h_CH3OH', 'cp_CH3OH*(re.T-Tref)+href_CH3OH', 'Enthalpy, methanol');
model.variable('var1').set('hf_C3H6O', 'cp_C3H6O*(Tfeed-Tref)+href_C3H6O', 'Feed enthalpy, propylene oxide');
model.variable('var1').set('hf_H2O', 'cp_H2O*(Tfeed-Tref)+href_H2O', 'Feed enthalpy, water');
model.variable('var1').set('hf_CH3OH', 'cp_CH3OH*(Tfeed-Tref)+href_CH3OH', 'Feed enthalpy, methanol');
model.variable('var1').set('Q_xch', 'Fexch*cp_exch*(Texch-re.T)*(1-exp(-UA/(Fexch*cp_exch)))', 'Heat exchange');

model.physics('re').prop('reactor').set('reactor', 'cstrvol');
model.physics('re').prop('energybalance').set('energybalance', 'include');
model.physics('re').prop('energybalance').set('Qext', 'Q_xch');
model.physics('re').prop('mixture').set('mixture', 'liquid');
model.physics('re').prop('reactor').set('Vr', 'Vr_tank');
model.physics('re').create('rch1', 'ReactionChem', -1);
model.physics('re').feature('rch1').set('formula', 'C3H6O+H2O=>C3H8O2');
model.physics('re').feature('rch1').set('ReactionExpression', 'UserDefined');
model.physics('re').feature('rch1').set('r', 're.kf_1*re.c_C3H6O');
model.physics('re').feature('rch1').set('bulkFwdOrder', 1);
model.physics('re').feature('rch1').set('useArrhenius', true);
model.physics('re').feature('rch1').set('Af', 'Af_reaction');
model.physics('re').feature('rch1').set('Ef', 'Ea_reaction');
model.physics('re').create('spec1', 'SpeciesChem', -1);
model.physics('re').feature('spec1').set('specName', 'CH3OH');
model.physics('re').feature('C3H6O').set('rho', 'rho_C3H6O');
model.physics('re').feature('H2O').set('rho', 'rho_H2O');
model.physics('re').feature('C3H8O2').set('rho', 'rho_C3H8O2');
model.physics('re').feature('CH3OH').set('rho', 'rho_CH3OH');
model.physics('re').create('feed1', 'FeedStream', -1);
model.physics('re').feature('feed1').set('vf', 'v_feed');
model.physics('re').feature('feed1').set('Tf', 'Tfeed');
model.physics('re').feature('feed1').setIndex('FeedSpeciesConcentration', 'cfeed_C3H6O', 0, 0);
model.physics('re').feature('feed1').setIndex('FeedSpeciesEnthalpy', 'hf_C3H6O', 0, 0);
model.physics('re').feature('feed1').setIndex('enthalpyType', 0, 0, 0);
model.physics('re').feature('feed1').setIndex('enthalpyType', 0, 1, 0);
model.physics('re').feature('feed1').setIndex('FeedSpeciesConcentration', 'cfeed_CH3OH', 2, 0);
model.physics('re').feature('feed1').setIndex('FeedSpeciesEnthalpy', 'hf_CH3OH', 2, 0);
model.physics('re').feature('feed1').setIndex('enthalpyType', 0, 2, 0);
model.physics('re').feature('feed1').setIndex('FeedSpeciesConcentration', 'cfeed_H2O', 3, 0);
model.physics('re').feature('feed1').setIndex('FeedSpeciesEnthalpy', 'hf_H2O', 3, 0);
model.physics('re').feature('feed1').setIndex('enthalpyType', 0, 3, 0);
model.physics('re').feature('inits1').set('T0', 'Tinit');
model.physics('re').feature('inits1').setIndex('initialValue', 'cinit_C3H6O', 0, 0);
model.physics('re').feature('inits1').setIndex('initialValue', 'cinit_H2O', 3, 0);
model.physics('re').feature('C3H6O').set('speciesEnthalpy', 'UserDefined');
model.physics('re').feature('C3H6O').set('Cp', 'cp_C3H6O');
model.physics('re').feature('C3H6O').set('h', 'h_C3H6O');
model.physics('re').feature('H2O').set('speciesEnthalpy', 'UserDefined');
model.physics('re').feature('H2O').set('Cp', 'cp_H2O');
model.physics('re').feature('H2O').set('h', 'h_H2O');
model.physics('re').feature('C3H8O2').set('speciesEnthalpy', 'UserDefined');
model.physics('re').feature('C3H8O2').set('Cp', 'cp_C3H8O2');
model.physics('re').feature('C3H8O2').set('h', 'h_C3H8O2');
model.physics('re').feature('CH3OH').set('speciesEnthalpy', 'UserDefined');
model.physics('re').feature('CH3OH').set('Cp', 'cp_CH3OH');
model.physics('re').feature('CH3OH').set('h', 'h_CH3OH');

model.study('std1').feature('time').set('tunit', 'h');
model.study('std1').feature('time').set('tlist', 4);

model.sol.create('sol1');
model.sol('sol1').study('std1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'time');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').set('control', 'time');
model.sol('sol1').create('t1', 'Time');
model.sol('sol1').feature('t1').set('tlist', '4');
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
model.result('pg1').feature('glob1').set('expr', {'re.c_C3H6O' 're.c_H2O' 're.c_C3H8O2' 're.c_CH3OH'});
model.result('pg1').feature('glob1').set('descr', {'Concentration' 'Concentration' 'Concentration' 'Concentration'});
model.result('pg1').feature('glob1').set('unit', {'' '' '' ''});
model.result('pg1').feature('glob1').set('expr', {'re.c_C3H6O' 're.c_H2O' 're.c_C3H8O2' 're.c_CH3OH'});
model.result('pg1').feature('glob1').set('descr', {'Concentration' 'Concentration' 'Concentration' 'Concentration'});
model.result('pg1').label('Concentration (re)');
model.result('pg1').feature('glob1').set('xdatasolnumtype', 'level1');
model.result.create('pg2', 'PlotGroup1D');
model.result('pg2').set('data', 'dset1');
model.result('pg2').create('glob1', 'Global');
model.result('pg2').feature('glob1').set('expr', {'re.c_C3H6O' 're.c_H2O' 're.c_C3H8O2' 're.c_CH3OH'});
model.result('pg2').feature('glob1').set('descr', {'Concentration' 'Concentration' 'Concentration' 'Concentration'});
model.result('pg2').feature('glob1').set('unit', {''});
model.result('pg2').feature('glob1').set('expr', {'re.T'});
model.result('pg2').feature('glob1').set('descr', {'Temperature'});
model.result('pg2').label('Temperature (re)');
model.result('pg2').feature('glob1').set('xdatasolnumtype', 'level1');
model.result('pg1').run;
model.result('pg1').set('titletype', 'none');
model.result('pg1').set('ylabelactive', true);
model.result('pg1').set('ylabel', 'Concentration propylene oxide (mol/m<sup>3</sup>)');
model.result('pg1').run;
model.result('pg1').feature('glob1').set('expr', {'re.c_C3H6O'});
model.result('pg1').feature('glob1').set('descr', {'Concentration'});
model.result('pg1').feature('glob1').set('unit', {'mol/m^3'});
model.result('pg1').feature('glob1').set('linewidth', 2);
model.result('pg1').feature('glob1').set('legend', false);
model.result('pg1').run;
model.result('pg2').run;
model.result('pg2').set('titletype', 'none');
model.result('pg2').run;
model.result('pg2').feature('glob1').set('linewidth', 2);
model.result('pg2').feature('glob1').set('legend', false);

model.study('std1').create('param', 'Parametric');
model.study('std1').feature('param').setIndex('pname', 'Vr_tank', 0);
model.study('std1').feature('param').setIndex('plistarr', '', 0);
model.study('std1').feature('param').setIndex('punit', 'm^3', 0);
model.study('std1').feature('param').setIndex('pname', 'Vr_tank', 0);
model.study('std1').feature('param').setIndex('plistarr', '', 0);
model.study('std1').feature('param').setIndex('punit', 'm^3', 0);
model.study('std1').feature('param').setIndex('pname', 'Tinit', 0);
model.study('std1').feature('param').setIndex('plistarr', '297[K] 340[K] 340[K]', 0);
model.study('std1').feature('param').setIndex('pname', 'Vr_tank', 1);
model.study('std1').feature('param').setIndex('plistarr', '', 1);
model.study('std1').feature('param').setIndex('punit', 'm^3', 1);
model.study('std1').feature('param').setIndex('pname', 'Vr_tank', 1);
model.study('std1').feature('param').setIndex('plistarr', '', 1);
model.study('std1').feature('param').setIndex('punit', 'm^3', 1);
model.study('std1').feature('param').setIndex('pname', 'cinit_C3H6O', 1);
model.study('std1').feature('param').setIndex('plistarr', '0 0 1400[mol/m^3]', 1);

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
model.sol('sol1').feature('t1').set('tlist', '4');
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

model.batch.create('p1', 'Parametric');
model.batch('p1').study('std1');
model.batch('p1').create('so1', 'Solutionseq');
model.batch('p1').feature('so1').set('seq', 'sol1');
model.batch('p1').feature('so1').set('store', 'on');
model.batch('p1').feature('so1').set('clear', 'on');
model.batch('p1').feature('so1').set('psol', 'none');
model.batch('p1').set('pname', {'Tinit' 'cinit_C3H6O'});
model.batch('p1').set('plistarr', {'297[K] 340[K] 340[K]' '0 0 1400[mol/m^3]'});
model.batch('p1').set('sweeptype', 'sparse');
model.batch('p1').set('probesel', 'all');
model.batch('p1').set('probes', {});
model.batch('p1').set('plot', 'off');
model.batch('p1').set('err', 'on');
model.batch('p1').attach('std1');
model.batch('p1').set('control', 'param');

model.sol.create('sol2');
model.sol('sol2').study('std1');
model.sol('sol2').label('Parametric Solutions 1');

model.batch('p1').feature('so1').set('psol', 'sol2');
model.batch('p1').run('compute');

model.result.create('pg3', 'PlotGroup1D');
model.result('pg3').set('data', 'dset2');
model.result('pg3').create('glob1', 'Global');
model.result('pg3').feature('glob1').set('expr', {'re.c_C3H6O' 're.c_H2O' 're.c_C3H8O2' 're.c_CH3OH'});
model.result('pg3').feature('glob1').set('descr', {'Concentration' 'Concentration' 'Concentration' 'Concentration'});
model.result('pg3').feature('glob1').set('unit', {'' '' '' ''});
model.result('pg3').feature('glob1').set('expr', {'re.c_C3H6O' 're.c_H2O' 're.c_C3H8O2' 're.c_CH3OH'});
model.result('pg3').feature('glob1').set('descr', {'Concentration' 'Concentration' 'Concentration' 'Concentration'});
model.result('pg3').label('Concentration (re) 1');
model.result('pg3').feature('glob1').set('xdatasolnumtype', 'level1');
model.result.create('pg4', 'PlotGroup1D');
model.result('pg4').set('data', 'dset2');
model.result('pg4').create('glob1', 'Global');
model.result('pg4').feature('glob1').set('expr', {'re.c_C3H6O' 're.c_H2O' 're.c_C3H8O2' 're.c_CH3OH'});
model.result('pg4').feature('glob1').set('descr', {'Concentration' 'Concentration' 'Concentration' 'Concentration'});
model.result('pg4').feature('glob1').set('unit', {''});
model.result('pg4').feature('glob1').set('expr', {'re.T'});
model.result('pg4').feature('glob1').set('descr', {'Temperature'});
model.result('pg4').label('Temperature (re) 1');
model.result('pg4').feature('glob1').set('xdatasolnumtype', 'level1');
model.result('pg3').run;
model.result('pg3').label('Concentration vs. Temperature (re)');
model.result('pg3').set('titletype', 'none');
model.result('pg3').run;
model.result('pg3').feature('glob1').set('expr', {'re.c_C3H6O'});
model.result('pg3').feature('glob1').set('descr', {'Concentration'});
model.result('pg3').feature('glob1').set('unit', {'mol/m^3'});
model.result('pg3').feature('glob1').set('xdataexpr', 're.T');
model.result('pg3').feature('glob1').set('xdatadescr', 'Temperature');
model.result('pg3').feature('glob1').set('linewidth', 2);
model.result('pg3').feature('glob1').set('autoexpr', false);
model.result('pg3').run;
model.result('pg4').run;
model.result('pg4').label('Temperature vs. Time (re)');
model.result('pg4').set('titletype', 'none');
model.result('pg4').run;
model.result('pg4').feature('glob1').set('linewidth', 2);
model.result('pg4').feature('glob1').set('autoexpr', false);
model.result('pg4').run;

model.title('Startup of a Continuous Stirred Tank Reactor');

model.description('The startup phase of a continuous stirred tank reactor (CSTR) used to produce propylene glycol is simulated. Results show how certain initial conditions lead to violation of the reactor safety limits.');

model.label('cstr_startup.mph');

model.modelNode.label('Components');

out = model;
