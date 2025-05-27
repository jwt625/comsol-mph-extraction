function out = model
%
% gold_recycling.m
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

model.physics('re').label('Liquid phase');
model.physics('re').prop('reactor').set('Vr', 'V_liquid');
model.physics('re').prop('energybalance').set('T', 'T');
model.physics('re').prop('mixture').set('mixture', 'liquid');

% To import content from file, use:
% model.param.loadFile('FILENAME');
model.param.set('loading_Au', '150[mg/dm^3]', 'Gold mass to liquid volume ratio');
model.param.set('V_reactor', '1[dm^3]', 'Volume of reactor');
model.param.set('V_liquid', '0.98*V_reactor', 'Volume of liquid');
model.param.set('m0_Au', 'loading_Au*V_liquid', 'Initial mass gold');
model.param.set('rho_Au', '19.3[g/cm^3]', 'Density of gold');
model.param.set('V0_Au', 'm0_Au/rho_Au', 'Initial bulk volume gold');
model.param.set('V0_gas', 'V_reactor-V_liquid-V0_Au', 'Initial volume of gas phase');
model.param.set('k_Au', '8.6e-6[mol/m^2/s]', 'Limiting rate, G. Senanayake 2005');
model.param.set('K_ads', '5.3e-3[m^12/mol^4]', 'Adsorption coefficient, Wadsworth 2000');
model.param.set('H_O2', '1.3[mol/m^3/bar]', 'Henry''s Law Constant for O2(g) in water');
model.param.set('T', '298.15[K]', 'Temperature');
model.param.set('p0_O2g', '0.2[bar]', 'Initial partial pressure of oxygen');
model.param.set('p0_N2g', '0.8[bar]', 'Initial partial pressure of nitrogen');
model.param.set('gas_c0_O2g', 'p0_O2g/R_const/T', 'Resulting initial concentration of oxygen in gas phase');
model.param.set('Mw_Au', '196.966[g/mol]', 'molar mass of gold');
model.param.set('liquid_c0_Au', 'm0_Au/Mw_Au/V_liquid', 'Virtual concentration of gold atoms (s) as if dissolved in liquid phase');
model.param.set('spherical_d0', '150[nm]', 'Initial diameter of spherical gold particles');
model.param.set('spherical_S0_V0', '6/spherical_d0', 'Initial surface to volume ratio of spherical particles');
model.param.set('spherical_S0', 'spherical_S0_V0*V0_Au', 'Initial total surface area gold');
model.param.set('cyanide_c0', '3[mol/m^3]', 'Initial concentration aqueous CN- ions');

model.variable.create('var1');
model.variable('var1').model('comp1');

% To import content from file, use:
% model.variable('var1').loadFile('FILENAME');
model.variable('var1').set('c_prod', 'K_ads*re.c_O2_aq*re.c_CN_1m^3', 'Common subexpression (factored for brevity)');
model.variable('var1').set('Rs_Au', 'k_Au*c_prod/(1+c_prod)', 'Surface rate of dissolution, Eq. 32 in Senanayake 2005');
model.variable('var1').set('flakes_R_Au', 'Rs_Au*spherical_S0/V_liquid*step1(re.c_Au_solid/liquid_c0_Au*1e9)', 'Volumetric rate of dissolution, modulated by remaining surface area');
model.variable('var1').set('V_Au', '(liquid_c0_Au - re.c_AuCNCN_1m)*V_liquid*Mw_Au/rho_Au', 'Volume of solid phase');
model.variable('var1').set('V_gas', 'V_reactor-V_liquid-V_Au', 'Volume of gas phase');

model.physics('re').create('rch1', 'ReactionChem', -1);
model.physics('re').feature('rch1').set('formula', '4 Au(s) + 8 CN- + O2(aq) + 2 H2O => 4 AuCNCN- + 4 OH-');
model.physics('re').feature('rch1').set('ReactionExpression', 'UserDefined');
model.physics('re').feature('rch1').set('r', 'flakes_R_Au/4');
model.physics('re').feature('rch1').set('bulkFwdOrder', 4);
model.physics('re').feature('rch1').set('kf', 0);
model.physics('re').feature('inits1').setIndex('initialValue', 'liquid_c0_Au', 0, 0);
model.physics('re').feature('inits1').setIndex('initialValue', '0[mol/dm^3]', 1, 0);
model.physics('re').feature('inits1').setIndex('initialValue', 'cyanide_c0', 2, 0);
model.physics('re').feature('inits1').setIndex('initialValue', '55[mol/dm^3]', 3, 0);
model.physics('re').feature('inits1').setIndex('initialValue', 'p0_O2g * H_O2', 4, 0);
model.physics('re').feature('inits1').setIndex('initialValue', '4e-4[mol/dm^3]', 5, 0);

model.modelNode('comp1').label('Dissolution of gold flakes');

model.physics.create('re2', 'ReactionEng');
model.physics('re2').model('comp1');

model.study('std1').feature('time').setSolveFor('/physics/re2', true);

model.physics('re2').label('Gas Phase');
model.physics('re2').prop('reactor').set('reactor', 'batch');
model.physics('re2').prop('reactor').set('Vr', 'V_gas');
model.physics('re2').prop('energybalance').set('T', 'T');
model.physics('re2').create('spec1', 'SpeciesChem', -1);
model.physics('re2').feature('spec1').set('specName', 'O2(g)');
model.physics('re2').create('spec1', 'SpeciesChem', -1);
model.physics('re2').feature('spec1').set('specName', 'N2(g)');
model.physics('re2').create('gconstr1', 'GlobalConstraint', -1);
model.physics('re2').feature('gconstr1').label('Henry''s Law for Dioxygen');
model.physics('re2').feature('gconstr1').set('constraintExpression', 're.c_O2_aq - H_O2*R_const*T*re2.c_O2_gas');
model.physics('re2').create('gconstr2', 'GlobalConstraint', -1);
model.physics('re2').feature('gconstr2').label('Mass Conservation of Oxygen');
model.physics('re2').feature('gconstr2').set('constraintExpression', 'V0_gas*(2*re2.c_O2_gas - 2*re2.c0_O2_gas) + V_liquid*(2*re.c_O2_aq + re.c_H2O + re.c_OH_1m - 2*re.c0_O2_aq - re.c0_H2O - re.c0_OH_1m)');
model.physics('re2').feature('inits1').setIndex('initialValue', 'p0_N2g/R_const/T', 0, 0);
model.physics('re2').feature('inits1').setIndex('initialValue', 'gas_c0_O2g', 1, 0);

model.func.create('step1', 'Step');
model.func('step1').set('from', -1);

model.modelNode.copy('comp2', 'comp1');
model.modelNode('comp2').label('Dissolution of spherical gold');

model.variable('var2').clear;

% To import content from file, use:
% model.variable('var2').loadFile('FILENAME');
model.variable('var2').set('c2_prod', 'K_ads*re3.c_O2_aq*re3.c_CN_1m^3', 'Common subexpression (factored for brevity)');
model.variable('var2').set('Rs2_Au', 'k_Au*c2_prod/(1+c2_prod)', 'Surface rate of dissolution, Eq. 32 in Senanayake 2005');
model.variable('var2').set('spherical_S', 'max(re3.c_Au_solid/liquid_c0_Au, 1e-100)^(2/3)*spherical_S0', 'Transient total surface area of gold spheres');
model.variable('var2').set('spherical_R_Au', 'Rs2_Au*spherical_S/V_liquid', 'Volumetric rate of dissolution, modulated by remaining surface area');
model.variable('var2').set('V_Au', '(liquid_c0_Au - re3.c_AuCNCN_1m)*V_liquid*Mw_Au/rho_Au', 'Volume of solid phase');
model.variable('var2').set('V_gas', 'V_reactor-V_liquid-V_Au', 'Volume of gas phase');

model.physics('re3').feature('rch1').set('r', 'spherical_R_Au/4');
model.physics('re4').feature('gconstr1').set('constraintExpression', 're3.c_O2_aq - H_O2*R_const*T*re4.c_O2_gas');
model.physics('re4').feature('gconstr2').set('constraintExpression', 'V0_gas*(2*re4.c_O2_gas - 2*re4.c0_O2_gas) + V_liquid*(2*re3.c_O2_aq + re3.c_H2O + re3.c_OH_1m - 2*re3.c0_O2_aq - re3.c0_H2O - re3.c0_OH_1m)');

model.study('std1').setGenPlots(false);
model.study('std1').feature('time').set('tunit', 'min');
model.study('std1').feature('time').set('tlist', 'range(0,1,600)');

model.sol.create('sol1');
model.sol('sol1').study('std1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'time');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').set('control', 'time');
model.sol('sol1').create('t1', 'Time');
model.sol('sol1').feature('t1').set('tlist', 'range(0,1,600)');
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
model.result('pg1').run;
model.result('pg1').label('Aqueous Gold Dissolution of Flakes and Spheres');
model.result('pg1').create('glob1', 'Global');
model.result('pg1').feature('glob1').set('markerpos', 'datapoints');
model.result('pg1').feature('glob1').set('linewidth', 'preference');
model.result('pg1').feature('glob1').label('Liquid (flakes)');
model.result('pg1').feature('glob1').set('expr', {});
model.result('pg1').feature('glob1').set('descr', {});
model.result('pg1').feature('glob1').set('expr', {'comp1.re.c_Au_solid' 'comp1.re.c_CN_1m' 'comp1.re.c_AuCNCN_1m' 'comp1.re.c_OH_1m' 'comp1.re.c_O2_aq'});
model.result('pg1').feature('glob1').set('descr', {'flakes: <I>n</I><sub>Au(s)</sub>/<I>V</I><sub>aq</sub>' 'flakes: [CN<sup>-</sup>]' 'flakes: [Au(CN)<sup>-</sup><sub>2</sub>]' 'flakes: [OH<sup>-</sup>]' 'flakes: [O<sub>2</sub>(aq)]'});
model.result('pg1').feature('glob1').set('autodescr', true);
model.result('pg1').feature('glob1').set('autoexpr', false);
model.result('pg1').run;
model.result('pg1').create('glob2', 'Global');
model.result('pg1').feature('glob2').set('markerpos', 'datapoints');
model.result('pg1').feature('glob2').set('linewidth', 'preference');
model.result('pg1').feature('glob2').label('Liquid (spheres)');
model.result('pg1').feature('glob2').set('expr', {});
model.result('pg1').feature('glob2').set('descr', {});
model.result('pg1').feature('glob2').set('expr', {'comp2.re3.c_Au_solid' 'comp2.re3.c_CN_1m' 'comp2.re3.c_AuCNCN_1m' 'comp2.re3.c_OH_1m' 'comp2.re3.c_O2_aq'});
model.result('pg1').feature('glob2').set('descr', {'spheres: <I>n</I><sub>Au(s)</sub>/<I>V</I><sub>aq</sub>' 'spheres: [CN<sup>-</sup>]' 'spheres: [Au(CN)<sup>-</sup><sub>2</sub>]' 'spheres: [OH<sup>-</sup>]' 'spheres: [O<sub>2</sub>(aq)]'});
model.result('pg1').feature('glob2').set('linestyle', 'dashed');
model.result('pg1').feature('glob2').set('linecolor', 'cyclereset');
model.result('pg1').feature('glob2').set('autodescr', true);
model.result('pg1').feature('glob2').set('autoexpr', false);
model.result('pg1').run;
model.result('pg1').create('glob3', 'Global');
model.result('pg1').feature('glob3').set('markerpos', 'datapoints');
model.result('pg1').feature('glob3').set('linewidth', 'preference');
model.result('pg1').feature('glob3').label('Gas');
model.result('pg1').feature('glob3').set('expr', {});
model.result('pg1').feature('glob3').set('descr', {});
model.result('pg1').feature('glob3').set('expr', {'R_const*T*(comp1.re2.c_O2_gas)' 'R_const*T*(comp2.re4.c_O2_gas)'});
model.result('pg1').feature('glob3').set('descr', {'flakes: <I>p</I><sub>O<sub>2</sub></sub>' 'spheres: <I>p</I><sub>O<sub>2</sub></sub>'});
model.result('pg1').feature('glob3').set('linestyle', 'cycle');
model.result('pg1').feature('glob3').set('linecolor', 'black');
model.result('pg1').feature('glob3').set('autodescr', true);
model.result('pg1').feature('glob3').set('autoexpr', false);
model.result('pg1').run;
model.result('pg1').set('titletype', 'none');
model.result('pg1').set('twoyaxes', true);
model.result('pg1').setIndex('plotonsecyaxis', true, 2, 1);
model.result('pg1').set('xlabelactive', true);
model.result('pg1').set('ylabelactive', true);
model.result('pg1').set('ylabel', 'Concentration (mM)');
model.result('pg1').set('yseclabelactive', true);
model.result('pg1').set('yseclabel', 'Partial Pressure (Pa)');
model.result('pg1').set('axislimits', true);
model.result('pg1').set('ymin', 0);
model.result('pg1').set('yminsec', 0);
model.result('pg1').set('xmax', 600);
model.result('pg1').set('legendlayout', 'outside');
model.result('pg1').run;

model.title('Gold Recycling Through Oxidative Dissolution');

model.description('The model studies the oxidative dissolution of this noble metal in an air saturated cyanide solution. The system encompasses three phases: a gaseous phase (air), an aqueous phase, and a solid gold phase. The system is assumed to be homogeneous on a macroscopic scale, for example fine particulate matter dispersed in water, which is continuously agitated by a stream of air bubbles.');

model.label('gold_recycling.mph');

model.modelNode.label('Components');

out = model;
