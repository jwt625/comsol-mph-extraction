function out = model
%
% electrochemical_capacitor_side_reactions.m
%
% Model exported on May 26 2025, 21:26 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/Battery_Design_Module/Electrochemical_Capacitors');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 1);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.physics.create('tcd', 'TertiaryCurrentDistributionNernstPlanck', 'geom1', {'c1' 'c2'});
model.physics('tcd').prop('SpeciesProperties').set('ChargeTransportModel', 'WaterBased');

model.study.create('std1');
model.study('std1').create('time', 'Transient');
model.study('std1').feature('time').setSolveFor('/physics/tcd', true);

% To import content from file, use:
% model.param.loadFile('FILENAME');
model.param.set('L_sep', '25[um]', 'Length of separator');
model.param.set('L_elec', '50[um]', 'Length of electrode');
model.param.set('kappa_l', '0.08[S/cm]', 'Electrolyte conductivity');
model.param.set('sigma_s', '10[S/cm]', 'Electrical conductivity');
model.param.set('eps_el', '0.7', 'Porosity of electrodes');
model.param.set('eps_sep', '0.7', 'Porosity of separator');
model.param.set('c_bulk', '1[M]', 'Bulk concentration');
model.param.set('T', '25[degC]', 'Reference temperature');
model.param.set('aC', '20[uF/cm^2]', 'Area-specific capacitance');
model.param.set('D', 'kappa_l*(R_const*T)/F_const^2/c_bulk/2', 'Diffusion coefficient');
model.param.set('Av', '4.5e6[cm^2/cm^3]', 'Specific area');
model.param.set('Cdl', 'aC/Av', 'Area specific capacitance');
model.param.label('Parameters : Electrochemical Cell');
model.param.create('par2');
model.param('par2').label('Parameters : Load Profile');

% To import content from file, use:
% model.param('par2').loadFile('FILENAME');
model.param('par2').set('I_app', '100[A]', 'Applied current');
model.param('par2').set('V_max', '2[V]', 'Maximum voltage');
model.param('par2').set('V_min', '0.5[V]', 'Minimum voltage');
model.param('par2').set('t_rest', '3600[s]', 'Rest time');
model.param.create('par3');
model.param('par3').label('Parameters : Electrode Reactions');

% To import content from file, use:
% model.param('par3').loadFile('FILENAME');
model.param('par3').set('Eeq_ref_O2', '1.23[V]', 'Reference equilibrium potential for H2');
model.param('par3').set('Eeq_ref_H2', '0[V]', 'Reference equilibrium potential for O2');
model.param('par3').set('cH2_init', '1e-10[mol/m^3]', 'Initial pressure for H2');
model.param('par3').set('cO2_init', '1e-10[mol/m^3]', 'Initial pressure for O2');
model.param('par3').set('i0_ref_H2', '6.29e-5[mA/cm^2]', 'Exchange current density for H2 at reference conditions');
model.param('par3').set('i0_ref_O2', '1.24e-7[mA/cm^2]', 'Exchange current density for O2 at reference conditions');
model.param('par3').set('cO2_sol', '40[mg/L]/18[g/mol]', 'Solubility of Oxygen at 1 atm');
model.param('par3').set('cH2_sol', '1.6[mg/L]/2[g/mol]', 'Solubility of Hydrogen at 1 atm');
model.param('par3').set('D_O2', '1e-9[m^2/s]', 'Diffusivity of Oxygen in electrolyte');
model.param('par3').set('D_H2', '2e-9[m^2/s]', 'Diffusivity of Hydrogen in electrolyte');
model.param('par3').set('E_cell_init', 'Eeq_ref_O2-Eeq_ref_H2+R_const*T/(4*F_const)*log(cO2_init/cO2_sol*(cH2_init/cH2_sol)^2)', 'Initial cell potential');

model.geom('geom1').create('i1', 'Interval');
model.geom('geom1').run;
model.geom('geom1').feature('i1').set('specify', 'len');
model.geom('geom1').feature('i1').setIndex('len', 'L_elec', 0);
model.geom('geom1').feature('i1').setIndex('len', 'L_sep', 1);
model.geom('geom1').feature('i1').setIndex('len', 'L_elec', 2);
model.geom('geom1').run('fin');

model.physics('tcd').field('concentration').component({'c1' 'c2' 'c3' 'c4'});
model.physics('tcd').field('concentration').component(1, 'cCat');
model.physics('tcd').field('concentration').component(2, 'cAn');
model.physics('tcd').field('concentration').component(3, 'cO2');
model.physics('tcd').field('concentration').component(4, 'cH2');
model.physics('tcd').feature('sp1').setIndex('z', 1, 0);
model.physics('tcd').feature('sp1').setIndex('z', -1, 1);
model.physics('tcd').feature('ice1').set('D_cCat', {'D' '0' '0' '0' 'D' '0' '0' '0' 'D'});
model.physics('tcd').feature('ice1').set('D_cAn', {'D' '0' '0' '0' 'D' '0' '0' '0' 'D'});
model.physics('tcd').feature('ice1').set('D_cO2', {'D_O2' '0' '0' '0' 'D_O2' '0' '0' '0' 'D_O2'});
model.physics('tcd').feature('ice1').set('D_cH2', {'D_H2' '0' '0' '0' 'D_H2' '0' '0' '0' 'D_H2'});
model.physics('tcd').feature('init1').label('Initial Values - H2 side');
model.physics('tcd').feature('init1').setIndex('initc', 'c_bulk', 0);
model.physics('tcd').feature('init1').setIndex('initc', 'c_bulk', 1);
model.physics('tcd').feature('init1').setIndex('initc', 'cH2_init', 3);
model.physics('tcd').create('init2', 'init', 1);
model.physics('tcd').feature('init2').selection.set([3]);
model.physics('tcd').feature('init2').label('Initial Values - O2 side');
model.physics('tcd').feature('init2').setIndex('initc', 'c_bulk', 0);
model.physics('tcd').feature('init2').setIndex('initc', 'c_bulk', 1);
model.physics('tcd').feature('init2').setIndex('initc', 'cO2_init', 2);
model.physics('tcd').feature('init2').set('initphis', 'E_cell_init');
model.physics('tcd').create('init3', 'init', 1);
model.physics('tcd').feature('init3').label('Initial Values - Separator');
model.physics('tcd').feature('init3').selection.set([2]);
model.physics('tcd').feature('init3').setIndex('initc', 'c_bulk', 0);
model.physics('tcd').feature('init3').setIndex('initc', 'c_bulk', 1);
model.physics('tcd').feature('init3').setIndex('initc', 'cO2_init*(x-L_elec)/L_sep', 2);
model.physics('tcd').feature('init3').setIndex('initc', 'cH2_init*(L_elec+L_sep-x)/L_sep', 3);
model.physics('tcd').feature('init3').set('initphis', 'E_cell_init');
model.physics('tcd').create('pce1', 'PorousElectrode', 1);
model.physics('tcd').feature('pce1').label('Porous Electrode - H2 side');
model.physics('tcd').feature('pce1').selection.set([1]);
model.physics('tcd').feature('pce1').set('D_cCat', {'D' '0' '0' '0' 'D' '0' '0' '0' 'D'});
model.physics('tcd').feature('pce1').set('D_cAn', {'D' '0' '0' '0' 'D' '0' '0' '0' 'D'});
model.physics('tcd').feature('pce1').set('D_cO2', {'D_O2' '0' '0' '0' 'D_O2' '0' '0' '0' 'D_O2'});
model.physics('tcd').feature('pce1').set('D_cH2', {'D_H2' '0' '0' '0' 'D_H2' '0' '0' '0' 'D_H2'});
model.physics('tcd').feature('pce1').set('sigma_mat', 'userdef');
model.physics('tcd').feature('pce1').set('sigma', {'sigma_s' '0' '0' '0' 'sigma_s' '0' '0' '0' 'sigma_s'});
model.physics('tcd').feature('pce1').set('epss', '1-eps_el');
model.physics('tcd').feature('pce1').set('epsl', 'eps_el');
model.physics('tcd').feature('pce1').feature('per1').label('Porous Electrode Reaction - HER');
model.physics('tcd').feature('pce1').feature('per1').setIndex('Vi0', 1, 3);
model.physics('tcd').feature('pce1').feature('per1').set('nm', 2);
model.physics('tcd').feature('pce1').feature('per1').set('Eeq_ref', 'Eeq_ref_H2');
model.physics('tcd').feature('pce1').feature('per1').set('i0_ref', 'i0_ref_H2');
model.physics('tcd').feature('pce1').feature('per1').set('Av', 'Av');
model.physics('tcd').feature('pce1').create('pdl1', 'PorousMatrixDoubleLayerCapacitance', 1);
model.physics('tcd').feature('pce1').feature('pdl1').set('Cdl', 'aC');
model.physics('tcd').feature('pce1').feature('pdl1').set('av_dl', 'Av');
model.physics('tcd').feature('pce1').feature('pdl1').setIndex('Vi0', -0.5, 0);
model.physics('tcd').feature('pce1').feature('pdl1').setIndex('Vi0', 0.5, 1);
model.physics('tcd').feature.duplicate('pce2', 'pce1');
model.physics('tcd').feature('pce2').label('Porous Electrode - O2 side');
model.physics('tcd').feature('pce2').selection.set([3]);
model.physics('tcd').feature('pce2').feature('per1').label('Porous Electrode Reaction - OER');
model.physics('tcd').feature('pce2').feature('per1').set('nm', 4);
model.physics('tcd').feature('pce2').feature('per1').setIndex('Vi0', -1, 2);
model.physics('tcd').feature('pce2').feature('per1').setIndex('Vi0', 0, 3);
model.physics('tcd').feature('pce2').feature('per1').set('Eeq_ref', 'Eeq_ref_O2');
model.physics('tcd').feature('pce2').feature('per1').set('i0_ref', 'i0_ref_O2');
model.physics('tcd').create('bei1', 'InternalElectrodeSurface', 0);
model.physics('tcd').feature('bei1').label('Internal Electrode Surface -ORR');
model.physics('tcd').feature('bei1').selection.set([2]);
model.physics('tcd').feature('bei1').feature('er1').set('nm', 4);
model.physics('tcd').feature('bei1').feature('er1').setIndex('Vi0', -1, 2);
model.physics('tcd').feature('bei1').feature('er1').set('Eeq_mat', 'userdef');
model.physics('tcd').feature('bei1').feature('er1').set('ElectrodeKinetics', 'FastIrreversibleElectrodeReaction');
model.physics('tcd').feature('bei1').feature('er1').set('RateLimitingSpeciesConcentration', 3);
model.physics('tcd').feature.duplicate('bei2', 'bei1');
model.physics('tcd').feature('bei2').selection.set([3]);
model.physics('tcd').feature('bei2').label('Internal Electrode Surface -HOR');
model.physics('tcd').feature('bei2').feature('er1').set('nm', 2);
model.physics('tcd').feature('bei2').feature('er1').setIndex('Vi0', 0, 2);
model.physics('tcd').feature('bei2').feature('er1').setIndex('Vi0', 1, 3);
model.physics('tcd').feature('bei2').feature('er1').set('RateLimitingSpeciesConcentration', 4);
model.physics('tcd').create('egnd1', 'ElectricGround', 0);
model.physics('tcd').feature('egnd1').selection.set([1]);
model.physics('tcd').create('cdc1', 'ChargeDischargeCycling', 0);
model.physics('tcd').feature('cdc1').selection.set([4]);
model.physics('tcd').feature('cdc1').set('Idch', '-I_app');
model.physics('tcd').feature('cdc1').set('Vmin', 'V_min');
model.physics('tcd').feature('cdc1').set('Ich', 'I_app');
model.physics('tcd').feature('cdc1').set('Vmax', 'V_max');
model.physics('tcd').feature('cdc1').set('item.OCCH', true);
model.physics('tcd').feature('cdc1').set('trech', 't_rest');
model.physics('tcd').feature('cdc1').set('StartWith', 'Charge_first');
model.physics('tcd').feature('cdc1').set('phis0init', 'E_cell_init');

model.probe.create('dom1', 'Domain');
model.probe('dom1').model('comp1');
model.probe('dom1').set('intsurface', true);
model.probe('dom1').set('intvolume', true);
model.probe('dom1').set('probename', 'aH2');
model.probe('dom1').set('type', 'maximum');
model.probe('dom1').set('expr', 'comp1.cH2/cH2_sol');
model.probe('dom1').set('descractive', true);
model.probe('dom1').set('descr', 'aH2');
model.probe.duplicate('dom2', 'dom1');
model.probe('dom2').set('probename', 'aO2');
model.probe('dom2').set('expr', 'comp1.cO2/cO2_sol');
model.probe('dom2').set('descr', 'aO2');
model.probe.create('var1', 'GlobalVariable');
model.probe('var1').model('comp1');
model.probe('var1').set('expr', 'tcd.cdc1.phis0');
model.probe('var1').set('descr', 'Cell potential');
model.probe('var1').set('probename', 'E_cell');

model.cpl.create('maxop1', 'Maximum', 'geom1');
model.cpl('maxop1').selection.all;

model.common('cminpt').set('modified', {'temperature' 'T'});

model.mesh('mesh1').run;

model.study('std1').label('Study 1 : CC Charge with Rest Period');
model.study('std1').setGenPlots(false);
model.study('std1').feature('time').set('tlist', '0 5000');

model.sol.create('sol1');
model.sol('sol1').study('std1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'time');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').feature('comp1_phil').set('scalemethod', 'manual');
model.sol('sol1').feature('v1').feature('comp1_phis').set('scalemethod', 'manual');
model.sol('sol1').feature('v1').feature('comp1_tcd_cdc1_phis0').set('scalemethod', 'manual');
model.sol('sol1').feature('v1').feature('comp1_phil').set('scaleval', '1');
model.sol('sol1').feature('v1').feature('comp1_phis').set('scaleval', '1');
model.sol('sol1').feature('v1').feature('comp1_tcd_cdc1_phis0').set('scaleval', '1');
model.sol('sol1').feature('v1').set('control', 'time');
model.sol('sol1').create('t1', 'Time');
model.sol('sol1').feature('t1').set('tlist', '0 5000');
model.sol('sol1').feature('t1').set('plot', 'off');
model.sol('sol1').feature('t1').set('plotgroup', 'Default');
model.sol('sol1').feature('t1').set('plotfreq', 'tout');
model.sol('sol1').feature('t1').set('probesel', 'all');
model.sol('sol1').feature('t1').set('probes', {'dom1' 'dom2' 'var1'});
model.sol('sol1').feature('t1').set('probefreq', 'tsteps');
model.sol('sol1').feature('t1').set('rtol', 0.001);
model.sol('sol1').feature('t1').set('atolglobalvaluemethod', 'factor');
model.sol('sol1').feature('t1').set('eventout', true);
model.sol('sol1').feature('t1').set('reacf', true);
model.sol('sol1').feature('t1').set('storeudot', true);
model.sol('sol1').feature('t1').set('endtimeinterpolation', true);
model.sol('sol1').feature('t1').set('maxorder', 2);
model.sol('sol1').feature('t1').set('control', 'time');
model.sol('sol1').feature('t1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('t1').feature('fc1').set('dtech', 'auto');
model.sol('sol1').feature('t1').create('d1', 'Direct');
model.sol('sol1').feature('t1').feature('d1').set('linsolver', 'pardiso');
model.sol('sol1').feature('t1').feature('d1').label('Direct (tcd)');
model.sol('sol1').feature('t1').create('i1', 'Iterative');
model.sol('sol1').feature('t1').feature('i1').set('maxlinit', 1000);
model.sol('sol1').feature('t1').feature('i1').set('nlinnormuse', 'on');
model.sol('sol1').feature('t1').feature('i1').label('Algebraic Multigrid (tcd)');
model.sol('sol1').feature('t1').feature('i1').create('mg1', 'Multigrid');
model.sol('sol1').feature('t1').feature('i1').feature('mg1').set('prefun', 'saamg');
model.sol('sol1').feature('t1').feature('i1').feature('mg1').set('maxcoarsedof', 50000);
model.sol('sol1').feature('t1').feature('i1').feature('mg1').set('saamgcompwise', false);
model.sol('sol1').feature('t1').feature('i1').feature('mg1').set('compactaggregation', true);
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('pr').create('va1', 'Vanka');
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('pr').feature('va1').set('vankavars', {'comp1_tcd_bei1_er1_iloc_lm' 'comp1_tcd_bei2_er1_iloc_lm' 'comp1_tcd_phis_lm'});
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('po').create('va1', 'Vanka');
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('po').feature('va1').set('vankavars', {'comp1_tcd_bei1_er1_iloc_lm' 'comp1_tcd_bei2_er1_iloc_lm' 'comp1_tcd_phis_lm'});
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('cs').create('d1', 'Direct');
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('cs').feature('d1').set('linsolver', 'pardiso');
model.sol('sol1').feature('t1').create('i2', 'Iterative');
model.sol('sol1').feature('t1').feature('i2').set('maxlinit', 1000);
model.sol('sol1').feature('t1').feature('i2').set('nlinnormuse', 'on');
model.sol('sol1').feature('t1').feature('i2').label('Geometric Multigrid (tcd)');
model.sol('sol1').feature('t1').feature('i2').create('mg1', 'Multigrid');
model.sol('sol1').feature('t1').feature('i2').feature('mg1').feature('pr').create('va1', 'Vanka');
model.sol('sol1').feature('t1').feature('i2').feature('mg1').feature('pr').feature('va1').set('vankavars', {'comp1_tcd_bei1_er1_iloc_lm' 'comp1_tcd_bei2_er1_iloc_lm' 'comp1_tcd_phis_lm'});
model.sol('sol1').feature('t1').feature('i2').feature('mg1').feature('po').create('va1', 'Vanka');
model.sol('sol1').feature('t1').feature('i2').feature('mg1').feature('po').feature('va1').set('vankavars', {'comp1_tcd_bei1_er1_iloc_lm' 'comp1_tcd_bei2_er1_iloc_lm' 'comp1_tcd_phis_lm'});
model.sol('sol1').feature('t1').feature('i2').feature('mg1').feature('cs').create('d1', 'Direct');
model.sol('sol1').feature('t1').feature('i2').feature('mg1').feature('cs').feature('d1').set('linsolver', 'pardiso');
model.sol('sol1').feature('t1').feature('fc1').set('linsolver', 'd1');
model.sol('sol1').feature('t1').feature('fc1').set('dtech', 'auto');
model.sol('sol1').feature('t1').feature.remove('fcDef');
model.sol('sol1').attach('std1');

model.probe('dom1').genResult('none');
model.probe('dom2').genResult('none');
model.probe('var1').genResult('none');

model.sol('sol1').runAll;

model.result.create('pg2', 'PlotGroup1D');
model.result('pg2').run;
model.result('pg2').label('Current Voltage Profile');
model.result('pg2').set('titletype', 'label');
model.result('pg2').set('legendpos', 'lowerleft');
model.result('pg2').create('tblp1', 'Table');
model.result('pg2').feature('tblp1').set('markerpos', 'datapoints');
model.result('pg2').feature('tblp1').set('linewidth', 'preference');
model.result('pg2').feature('tblp1').label('Cell Potential');
model.result('pg2').feature('tblp1').set('plotcolumninput', 'manual');
model.result('pg2').feature('tblp1').set('plotcolumns', [4]);
model.result('pg2').feature('tblp1').set('legend', true);
model.result('pg2').run;
model.result('pg2').run;
model.result('pg2').create('glob1', 'Global');
model.result('pg2').feature('glob1').set('markerpos', 'datapoints');
model.result('pg2').feature('glob1').set('linewidth', 'preference');
model.result('pg2').feature('glob1').set('expr', {'tcd.cdc1.Icell'});
model.result('pg2').feature('glob1').set('descr', {'Cell current'});
model.result('pg2').feature('glob1').set('unit', {'A'});
model.result('pg2').feature('glob1').label('Cell Current');
model.result('pg2').run;
model.result('pg2').set('twoyaxes', true);
model.result('pg2').setIndex('plotonsecyaxis', true, 1, 1);
model.result('pg2').run;
model.result.create('pg3', 'PlotGroup1D');
model.result('pg3').run;
model.result('pg3').label('Maximum Activities');
model.result('pg3').set('titletype', 'label');
model.result('pg3').set('ylabelactive', true);
model.result('pg3').set('ylabel', 'Activity (1)');
model.result('pg3').create('glob1', 'Global');
model.result('pg3').feature('glob1').set('markerpos', 'datapoints');
model.result('pg3').feature('glob1').set('linewidth', 'preference');
model.result('pg3').feature('glob1').label('Activity of O2');
model.result('pg3').feature('glob1').setIndex('expr', 'maxop1(cO2/cO2_sol)', 0);
model.result('pg3').feature('glob1').setIndex('descr', 'Activity of O2', 0);
model.result('pg3').feature.duplicate('glob2', 'glob1');
model.result('pg3').run;
model.result('pg3').feature('glob2').label('Activity of H2');
model.result('pg3').feature('glob2').setIndex('expr', 'maxop1(cH2/cH2_sol)', 0);
model.result('pg3').feature('glob2').setIndex('descr', 'Activity of H2', 0);
model.result('pg3').run;
model.result.create('pg4', 'PlotGroup1D');
model.result('pg4').run;
model.result('pg4').label('Hydrogen and Oxygen Concentrations - End of Charge');
model.result('pg4').setIndex('looplevelinput', 'manual', 0);
model.result('pg4').setIndex('looplevel', [2], 0);
model.result('pg4').set('titletype', 'label');
model.result('pg4').set('xlabelactive', true);
model.result('pg4').set('xlabel', 'Dimensionless length (1)');
model.result('pg4').set('ylabelactive', true);
model.result('pg4').set('ylabel', 'Concentration (mol/m<sup>3</sup>)');
model.result('pg4').create('lngr1', 'LineGraph');
model.result('pg4').feature('lngr1').set('markerpos', 'datapoints');
model.result('pg4').feature('lngr1').set('linewidth', 'preference');
model.result('pg4').feature('lngr1').label('Oxygen Concentration');
model.result('pg4').feature('lngr1').selection.all;
model.result('pg4').feature('lngr1').set('expr', 'cO2');
model.result('pg4').feature('lngr1').set('descractive', true);
model.result('pg4').feature('lngr1').set('descr', 'O2');
model.result('pg4').run;
model.result('pg4').feature('lngr1').set('xdata', 'expr');
model.result('pg4').feature('lngr1').set('xdataexpr', 'x/(2*L_elec+L_sep)');
model.result('pg4').feature('lngr1').set('legend', true);
model.result('pg4').feature('lngr1').set('autosolution', false);
model.result('pg4').feature('lngr1').set('autodescr', true);
model.result('pg4').run;
model.result('pg4').feature.duplicate('lngr2', 'lngr1');
model.result('pg4').run;
model.result('pg4').feature('lngr2').label('Hydrogen Concentration');
model.result('pg4').feature('lngr2').set('expr', 'cH2');
model.result('pg4').feature('lngr2').set('descr', 'H2');
model.result('pg4').run;

model.title('Parasitic Reactions in an Electrochemical Capacitor');

model.description(['This model illustrates the effect of oxygen and hydrogen formation and recombination on the performance and self-discharge of an electrochemical capacitor with an aqueous electrolyte.' newline  newline 'A load cycle consisting of mixed constant current pulses and rest periods at open circuit is studied.']);

model.mesh.clearMeshes;

model.sol('sol1').clearSolutionData;

model.label('electrochemical_capacitor_side_reactions.mph');

model.modelNode.label('Components');

out = model;
