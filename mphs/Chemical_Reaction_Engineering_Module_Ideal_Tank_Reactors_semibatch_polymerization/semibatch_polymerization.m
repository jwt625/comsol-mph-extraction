function out = model
%
% semibatch_polymerization.m
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
model.param.set('Vr_init', '10[m^3]', 'Initial reactor volume');
model.param.set('cinlet_M', 'density_M/Mm_M', 'Inlet concentration species M');
model.param.set('cinlet_P', '0[mol/m^3]', 'Inlet concentration species P');
model.param.set('cinlet_H2O', '11000[mol/m^3]', 'Inlet concentration water');
model.param.set('cinit_H2O', 'density_H2O/Mm_H2O', 'Initial concentration water in reactor');
model.param.set('Mm_M', '0.1[kg/mol]', 'Molar mass species M');
model.param.set('Mm_P', '0.1[kg/mol]', 'Molar mass species P');
model.param.set('Mm_H2O', '0.018[kg/mol]', 'Molar mass water');
model.param.set('density_M', '800[kg/m^3]', 'Density species M');
model.param.set('density_P', '1100[kg/m^3]', 'Density species P');
model.param.set('density_H2O', '1000[kg/m^3]', 'Density water');
model.param.set('kf_reaction', '(1/600)[1/s]', 'Rate constant forward reaction');
model.param.set('vfmax', '1[m^3/min]', 'Maximum volumetric feed rate');
model.param.set('t_cond', '11.2[min]', 'Time for shift in feed');
model.param.set('fill', '0', 'Control parameter for filling');

model.func.create('step1', 'Step');
model.func('step1').set('location', 't_cond');

model.physics('re').prop('reactor').set('reactor', 'semibatch');
model.physics('re').prop('mixture').set('mixture', 'liquid');
model.physics('re').create('rch1', 'ReactionChem', -1);
model.physics('re').feature('rch1').set('formula', 'M=>P');
model.physics('re').feature('rch1').set('kf', 'kf_reaction');
model.physics('re').feature('M').set('M', 'Mm_M');
model.physics('re').feature('M').set('rho', 'density_M');
model.physics('re').feature('P').set('M', 'Mm_P');
model.physics('re').feature('P').set('rho', 'density_P');
model.physics('re').create('spec1', 'SpeciesChem', -1);
model.physics('re').feature('spec1').set('specName', 'H2O');
model.physics('re').feature('H2O').set('M', 'Mm_H2O');
model.physics('re').feature('H2O').set('rho', 'density_H2O');

model.variable.create('var1');
model.variable('var1').model('comp1');

% To import content from file, use:
% model.variable('var1').loadFile('FILENAME');
model.variable('var1').set('vf_cond1', 'vfmax*(1-step1(t/1[s]))', 'Volumetric feed rate operating condition 1');
model.variable('var1').set('vf_condc', '-re.vp*step1(t/1[s])', 'Volumetric feed rate compensating for the volumetric production in operating condition 2');
model.variable('var1').set('vfs', 'vf_cond1+fill*vf_condc', 'Volumetric feed rate');
model.variable('var1').set('m_mon', 're.c_M*re.M_M*re.Vr', 'Monomer mass');

model.physics('re').create('feed1', 'FeedStream', -1);
model.physics('re').feature('feed1').set('vf', 'vfs');
model.physics('re').feature('feed1').setIndex('FeedSpeciesConcentration', 'cinlet_H2O', 0, 0);
model.physics('re').feature('feed1').setIndex('FeedSpeciesConcentration', 'cinlet_M', 1, 0);
model.physics('re').feature('inits1').set('Vr0', 'Vr_init');
model.physics('re').feature('inits1').setIndex('initialValue', 'cinit_H2O', 0, 0);

model.study('std1').feature('time').set('tlist', 'range(0,0.1,3000)');

model.sol.create('sol1');
model.sol('sol1').study('std1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'time');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').set('control', 'time');
model.sol('sol1').create('t1', 'Time');
model.sol('sol1').feature('t1').set('tlist', 'range(0,0.1,3000)');
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
model.result('pg1').feature('glob1').set('expr', {'re.c_M' 're.c_P' 're.c_H2O'});
model.result('pg1').feature('glob1').set('descr', {'Concentration' 'Concentration' 'Concentration'});
model.result('pg1').feature('glob1').set('unit', {'' '' ''});
model.result('pg1').feature('glob1').set('expr', {'re.c_M' 're.c_P' 're.c_H2O'});
model.result('pg1').feature('glob1').set('descr', {'Concentration' 'Concentration' 'Concentration'});
model.result('pg1').label('Concentration (re)');
model.result('pg1').feature('glob1').set('xdatasolnumtype', 'level1');
model.result('pg1').run;
model.result('pg1').run;
model.result('pg1').feature('glob1').set('xdata', 'expr');
model.result('pg1').feature('glob1').set('xdataexpr', 't');
model.result('pg1').feature('glob1').set('xdataunit', 'min');
model.result('pg1').run;

model.study('std1').create('param', 'Parametric');
model.study('std1').feature('param').setIndex('pname', 'Vr_init', 0);
model.study('std1').feature('param').setIndex('plistarr', '', 0);
model.study('std1').feature('param').setIndex('punit', 'm^3', 0);
model.study('std1').feature('param').setIndex('pname', 'Vr_init', 0);
model.study('std1').feature('param').setIndex('plistarr', '', 0);
model.study('std1').feature('param').setIndex('punit', 'm^3', 0);
model.study('std1').feature('param').setIndex('pname', 'fill', 0);
model.study('std1').feature('param').setIndex('plistarr', '0 1', 0);

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
model.sol('sol1').feature('t1').set('tlist', 'range(0,0.1,3000)');
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
model.batch('p1').set('pname', {'fill'});
model.batch('p1').set('plistarr', {'0 1'});
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

model.result.create('pg2', 'PlotGroup1D');
model.result('pg2').set('data', 'dset2');
model.result('pg2').create('glob1', 'Global');
model.result('pg2').feature('glob1').set('expr', {'re.c_M' 're.c_P' 're.c_H2O'});
model.result('pg2').feature('glob1').set('descr', {'Concentration' 'Concentration' 'Concentration'});
model.result('pg2').feature('glob1').set('unit', {'' '' ''});
model.result('pg2').feature('glob1').set('expr', {'re.c_M' 're.c_P' 're.c_H2O'});
model.result('pg2').feature('glob1').set('descr', {'Concentration' 'Concentration' 'Concentration'});
model.result('pg2').label('Concentration (re) 1');
model.result('pg2').feature('glob1').set('xdatasolnumtype', 'level1');
model.result('pg2').run;
model.result('pg2').label('Volumetric feed rate');
model.result('pg2').run;
model.result('pg2').feature('glob1').set('expr', {'re.sumvf'});
model.result('pg2').feature('glob1').set('descr', {'Sum of volume flows'});
model.result('pg2').feature('glob1').set('unit', {'m^3/s'});
model.result('pg2').feature('glob1').set('titletype', 'manual');
model.result('pg2').feature('glob1').set('title', 'Global: Volumetric feed rate (m<sup>3</sup>/s)');
model.result('pg2').feature('glob1').set('xdata', 'expr');
model.result('pg2').feature('glob1').set('xdataexpr', 't');
model.result('pg2').feature('glob1').set('xdataunit', 'min');
model.result('pg2').feature('glob1').set('linestyle', 'cycle');
model.result('pg2').feature('glob1').set('linecolor', 'blue');
model.result('pg2').feature('glob1').set('linewidth', 2);
model.result('pg2').feature('glob1').set('legendmethod', 'manual');
model.result('pg2').feature('glob1').setIndex('legends', 'Operating condition 1', 0);
model.result('pg2').feature('glob1').setIndex('legends', 'Operating condition 2', 1);
model.result('pg2').run;
model.result.create('pg3', 'PlotGroup1D');
model.result('pg3').run;
model.result('pg3').label('Reactor volume');
model.result('pg3').set('data', 'dset2');
model.result('pg3').set('legendpos', 'lowerright');
model.result('pg3').create('glob1', 'Global');
model.result('pg3').feature('glob1').set('markerpos', 'datapoints');
model.result('pg3').feature('glob1').set('linewidth', 'preference');
model.result('pg3').feature('glob1').set('expr', {'re.Vr'});
model.result('pg3').feature('glob1').set('descr', {'Reactor volume'});
model.result('pg3').feature('glob1').set('unit', {'m^3'});
model.result('pg3').feature('glob1').set('xdata', 'expr');
model.result('pg3').feature('glob1').set('xdataexpr', 't');
model.result('pg3').feature('glob1').set('xdataunit', 'min');
model.result('pg3').feature('glob1').set('linestyle', 'cycle');
model.result('pg3').feature('glob1').set('linecolor', 'blue');
model.result('pg3').feature('glob1').set('linewidth', 2);
model.result('pg3').feature('glob1').set('legendmethod', 'manual');
model.result('pg3').feature('glob1').setIndex('legends', 'Operating condition 1', 0);
model.result('pg3').feature('glob1').setIndex('legends', 'Operating condition 2', 1);
model.result('pg3').run;
model.result.create('pg4', 'PlotGroup1D');
model.result('pg4').run;
model.result('pg4').label('Monomer mass');
model.result('pg4').set('data', 'dset2');
model.result('pg4').create('glob1', 'Global');
model.result('pg4').feature('glob1').set('markerpos', 'datapoints');
model.result('pg4').feature('glob1').set('linewidth', 'preference');
model.result('pg4').feature('glob1').set('expr', {'m_mon'});
model.result('pg4').feature('glob1').set('descr', {'Monomer mass'});
model.result('pg4').feature('glob1').set('unit', {'kg'});
model.result('pg4').feature('glob1').set('xdata', 'expr');
model.result('pg4').feature('glob1').set('xdataexpr', 't');
model.result('pg4').feature('glob1').set('xdataunit', 'min');
model.result('pg4').feature('glob1').set('linestyle', 'cycle');
model.result('pg4').feature('glob1').set('linecolor', 'blue');
model.result('pg4').feature('glob1').set('linewidth', 2);
model.result('pg4').feature('glob1').set('legendmethod', 'manual');
model.result('pg4').feature('glob1').setIndex('legends', 'Operating condition 1', 0);
model.result('pg4').feature('glob1').setIndex('legends', 'Operating condition 2', 1);
model.result('pg4').run;

model.title('Semibatch Polymerization');

model.description('The predefined semibatch reactor type is used to model a solution polymerization reaction. The volume of the reacting mixture decreases as polymer is formed. Simulations show that taking this effect into account can increase polymer production drastically.');

model.label('semibatch_polymerization.mph');

model.modelNode.label('Components');

out = model;
