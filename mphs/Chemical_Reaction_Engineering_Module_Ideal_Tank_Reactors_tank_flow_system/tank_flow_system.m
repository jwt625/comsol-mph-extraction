function out = model
%
% tank_flow_system.m
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
model.param.set('Mn_S', '0.018[kg/mol]', 'Molar mass solvent');
model.param.set('Mn_A', '0.032[kg/mol]', 'Molar mass A');
model.param.set('Mn_B', '0.032[kg/mol]', 'Molar mass B');
model.param.set('density_S', '1000[kg/m^3]', 'Density solvent');
model.param.set('cinit_S', 'density_S/Mn_S', 'Initial concentration of solvent in tanks');
model.param.set('kf_reaction', '(1/600)[1/s]', 'Rate constant forward reaction');
model.param.set('Vr_init_tank1', '1[m^3]', 'Initial reactor volume. tank 1');
model.param.set('Vr_init_tank2', '1.5[m^3]', 'Initial reactor volume. tank 2');
model.param.set('v_inlet', '1[m^3/min]', 'Volumetric feed rate into tank 1');
model.param.set('cinlet_A1', '1000[mol/m^3]', 'Inlet concentration species A, tank 1');
model.param.set('v_fresh2', '0.5[m^3/min]', 'Fresh volumetric feed rate into tank 2');
model.param.set('cfresh2_A', '1000[mol/m^3]', 'Fresh inlet feed concentration species A to tank 2');
model.param.set('cinlet_S', 'cinit_S', 'Inlet concentration solvent');
model.param.set('v_outlet1', '0.9[m^3/min]', 'Volumetric outlet rate from tank 1');
model.param.set('v_outlet2', '1[m^3/min]', 'Volumetric outlet rate from tank 2');

model.physics('re').prop('reactor').set('reactor', 'cstrmass');
model.physics('re').prop('mixture').set('mixture', 'liquid');
model.physics('re').create('rch1', 'ReactionChem', -1);
model.physics('re').feature('rch1').set('formula', 'A=>B');
model.physics('re').feature('rch1').set('kf', 'kf_reaction');
model.physics('re').feature('A').set('M', 'Mn_A');
model.physics('re').feature('B').set('M', 'Mn_B');
model.physics('re').create('spec1', 'SpeciesChem', -1);
model.physics('re').feature('spec1').set('specName', 'S');
model.physics('re').feature('S').set('sType', 'solvent');
model.physics('re').feature('S').set('M', 'Mn_S');
model.physics('re').feature('S').set('rho', 'density_S');
model.physics('re').prop('reactor').set('reactorparsource', 'UserDefined');
model.physics('re').prop('SimpropMass').set('Species', {'A' 'B' 'S'});
model.physics('re').prop('SimpropMass').set('SpeciesInputType', {'Variable' 'Variable' 'Solvent'});
model.physics('re').prop('SimpropMass').set('Notes', {'re.R_A' 're.R_B' 'solvent'});
model.physics('re').prop('reactor').set('vp', 're.Vr*(re.R_A*re.M_A+re.R_B*re.M_B+re.R_S*re.M_S)/max(re.rho_S,eps)');
model.physics('re').prop('reactor').set('v', 'v_outlet1');
model.physics('re').feature('inits1').set('Vr0', 'Vr_init_tank1');
model.physics('re').feature('inits1').setIndex('initialValue', 'cinit_S', 2, 0);
model.physics('re').create('feed1', 'FeedStream', -1);
model.physics('re').feature('feed1').set('vf', 'v_inlet');
model.physics('re').feature('feed1').setIndex('FeedSpeciesConcentration', 'cinlet_A1', 0, 0);
model.physics('re').feature('feed1').setIndex('FeedSpeciesConcentration', 'cinlet_S', 2, 0);
model.physics.copy('re2', 're', 'comp1');
model.physics('re2').prop('reactor').set('v', 'v_outlet2');
model.physics('re2').feature('inits1').set('Vr0', 'Vr_init_tank2');
model.physics('re2').feature('feed1').label('Feed Inlet 1 - from Tank 1');
model.physics('re2').feature('feed1').set('vf', 'v_outlet1');
model.physics('re2').feature('feed1').setIndex('FeedSpeciesConcentration', 're.c_A', 0, 0);
model.physics('re2').feature('feed1').setIndex('FeedSpeciesConcentration', 're.c_B', 1, 0);
model.physics('re2').feature('feed1').setIndex('FeedSpeciesConcentration', 're.c_S', 2, 0);
model.physics('re2').create('feed2', 'FeedStream', -1);
model.physics('re2').feature('feed2').label('Feed Inlet 2 - Fresh');
model.physics('re2').feature('feed2').set('vf', 'v_fresh2');
model.physics('re2').feature('feed2').setIndex('FeedSpeciesConcentration', 'cfresh2_A', 0, 0);
model.physics('re2').feature('feed2').setIndex('FeedSpeciesConcentration', 'cinlet_S', 2, 0);

model.study('std1').feature('time').set('tunit', 'min');
model.study('std1').feature('time').set('tlist', 'range(0,0.1,120)');

model.sol.create('sol1');
model.sol('sol1').study('std1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'time');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').set('control', 'time');
model.sol('sol1').create('t1', 'Time');
model.sol('sol1').feature('t1').set('tlist', 'range(0,0.1,120)');
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
model.sol('sol1').feature('t1').create('st1', 'StopCondition');
model.sol('sol1').feature('t1').feature('st1').setIndex('stopcondarr', '', 0);
model.sol('sol1').feature('t1').feature('st1').setIndex('stopcondterminateon', 'true', 0);
model.sol('sol1').feature('t1').feature('st1').setIndex('stopcondActive', true, 0);
model.sol('sol1').feature('t1').feature('st1').setIndex('stopconddesc', 'Stop expression 1', 0);
model.sol('sol1').feature('t1').feature('st1').setIndex('stopcondarr', '', 0);
model.sol('sol1').feature('t1').feature('st1').setIndex('stopcondterminateon', 'true', 0);
model.sol('sol1').feature('t1').feature('st1').setIndex('stopcondActive', true, 0);
model.sol('sol1').feature('t1').feature('st1').setIndex('stopconddesc', 'Stop expression 1', 0);
model.sol('sol1').feature('t1').feature('st1').setIndex('stopcondarr', 'comp1.re.Vr<=Vr_init_tank1*0.01', 0);
model.sol('sol1').feature('t1').feature('st1').setIndex('stopcondarr', '', 1);
model.sol('sol1').feature('t1').feature('st1').setIndex('stopcondterminateon', 'true', 1);
model.sol('sol1').feature('t1').feature('st1').setIndex('stopcondActive', true, 1);
model.sol('sol1').feature('t1').feature('st1').setIndex('stopconddesc', 'Stop expression 2', 1);
model.sol('sol1').feature('t1').feature('st1').setIndex('stopcondarr', '', 1);
model.sol('sol1').feature('t1').feature('st1').setIndex('stopcondterminateon', 'true', 1);
model.sol('sol1').feature('t1').feature('st1').setIndex('stopcondActive', true, 1);
model.sol('sol1').feature('t1').feature('st1').setIndex('stopconddesc', 'Stop expression 2', 1);
model.sol('sol1').feature('t1').feature('st1').setIndex('stopcondarr', 'comp1.re2.Vr<=Vr_init_tank2*0.01', 1);
model.sol('sol1').feature('t1').feature('st1').set('storestopcondsol', 'stepbefore_stepafter');
model.sol('sol1').feature('t1').feature('st1').set('stopcondwarn', false);
model.sol('sol1').runAll;

model.result.create('pg1', 'PlotGroup1D');
model.result('pg1').set('data', 'dset1');
model.result('pg1').create('glob1', 'Global');
model.result('pg1').feature('glob1').set('expr', {'re.c_A' 're.c_B'});
model.result('pg1').feature('glob1').set('descr', {'Concentration' 'Concentration'});
model.result('pg1').feature('glob1').set('unit', {'' ''});
model.result('pg1').feature('glob1').set('expr', {'re.c_A' 're.c_B'});
model.result('pg1').feature('glob1').set('descr', {'Concentration' 'Concentration'});
model.result('pg1').label('Concentration (re)');
model.result('pg1').feature('glob1').set('xdatasolnumtype', 'level1');
model.result.create('pg2', 'PlotGroup1D');
model.result('pg2').set('data', 'dset1');
model.result('pg2').create('glob1', 'Global');
model.result('pg2').feature('glob1').set('expr', {'re2.c_A' 're2.c_B'});
model.result('pg2').feature('glob1').set('descr', {'Concentration' 'Concentration'});
model.result('pg2').feature('glob1').set('unit', {'' ''});
model.result('pg2').feature('glob1').set('expr', {'re2.c_A' 're2.c_B'});
model.result('pg2').feature('glob1').set('descr', {'Concentration' 'Concentration'});
model.result('pg2').label('Concentration (re2)');
model.result('pg2').feature('glob1').set('xdatasolnumtype', 'level1');
model.result('pg1').run;
model.result('pg1').label('Concentrations in Tanks');
model.result('pg1').set('titletype', 'none');
model.result('pg1').set('legendlayout', 'outside');
model.result('pg1').run;
model.result('pg1').feature('glob1').label('Tank 1');
model.result('pg1').feature('glob1').set('linewidth', 2);
model.result('pg1').feature('glob1').set('legendmethod', 'manual');
model.result('pg1').feature('glob1').setIndex('legends', 'A in tank 1', 0);
model.result('pg1').feature('glob1').setIndex('legends', 'B in tank 1', 1);
model.result('pg1').feature.duplicate('glob2', 'glob1');
model.result('pg1').run;
model.result('pg1').feature('glob2').label('Tank 2');
model.result('pg1').feature('glob2').set('expr', {'re2.c_A'});
model.result('pg1').feature('glob2').set('descr', {'Concentration'});
model.result('pg1').feature('glob2').set('unit', {'mol/m^3'});
model.result('pg1').feature('glob2').set('expr', {'re2.c_A' 're2.c_B'});
model.result('pg1').feature('glob2').set('descr', {'Concentration' 'Concentration'});
model.result('pg1').feature('glob2').setIndex('legends', 'A in tank 2', 0);
model.result('pg1').feature('glob2').setIndex('legends', 'B in tank 2', 1);
model.result('pg1').run;
model.result('pg2').run;
model.result('pg2').label('Volume in Tanks');
model.result('pg2').set('titletype', 'none');
model.result('pg2').set('legendpos', 'upperleft');
model.result('pg2').run;
model.result('pg2').feature('glob1').label('Tank 1');
model.result('pg2').feature('glob1').set('expr', {'re.Vr'});
model.result('pg2').feature('glob1').set('descr', {'Reactor volume'});
model.result('pg2').feature('glob1').set('unit', {'m^3'});
model.result('pg2').feature('glob1').set('linewidth', 2);
model.result('pg2').feature('glob1').set('autoplotlabel', true);
model.result('pg2').feature('glob1').set('autosolution', false);
model.result('pg2').feature('glob1').set('autoexpr', false);
model.result('pg2').feature.duplicate('glob2', 'glob1');
model.result('pg2').run;
model.result('pg2').feature('glob2').label('Tank 2');
model.result('pg2').run;

model.title('Ideal Stirred Tank Reactor System');

model.description('In chemical and biochemical industry reactors having well-mixed conditions and liquid level control are common. This example shows how to use the Reaction Engineering interface to model a system of ideal tank reactors in series, with controlled feed inlet and product outlet streams. The volume change in each reactor is monitored as well.');

model.label('tank_flow_system.mph');

model.modelNode.label('Components');

out = model;
