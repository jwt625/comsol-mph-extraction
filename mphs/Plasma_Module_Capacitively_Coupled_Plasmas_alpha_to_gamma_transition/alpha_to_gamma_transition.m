function out = model
%
% alpha_to_gamma_transition.m
%
% Model exported on May 26 2025, 21:31 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/Plasma_Module/Capacitively_Coupled_Plasmas');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 1);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.physics.create('ptp', 'ColdPlasmaTimePeriodic', 'geom1');
model.physics('ptp').model('comp1');

model.study.create('std1');
model.study('std1').create('tper', 'TimePeriodic');
model.study('std1').feature('tper').set('solnum', 'auto');
model.study('std1').feature('tper').set('notsolnum', 'auto');
model.study('std1').feature('tper').set('outputmap', {});
model.study('std1').feature('tper').set('ngenAUX', '1');
model.study('std1').feature('tper').set('ngen', '2');
model.study('std1').feature('tper').set('goalngenAUX', '1');
model.study('std1').feature('tper').set('ngenAUX', '1');
model.study('std1').feature('tper').set('ngen', '2');
model.study('std1').feature('tper').set('goalngenAUX', '1');
model.study('std1').feature('tper').setSolveFor('/physics/ptp', true);

model.geom('geom1').lengthUnit('mm');
model.geom('geom1').create('i1', 'Interval');
model.geom('geom1').feature('i1').setIndex('coord', 2, 1);

model.param.set('f0', '13.56[MHz]');
model.param.set('Prf', '1[W]');

model.cpl.create('aveop1', 'Average', 'geom1');

model.geom('geom1').run;

model.cpl('aveop1').set('axisym', true);
model.cpl('aveop1').selection.all;

model.physics('ptp').prop('CrossSectionArea').set('A', '80[cm^2]');
model.physics('ptp').prop('ExtraDimensionSettings').set('Period_xd', '1/f0');
model.physics('ptp').prop('ExtraDimensionSettings').set('Nelemptp', 30);
model.physics('ptp').feature('pes1').set('T', '300[K]');
model.physics('ptp').feature('init1').set('neinit', '1E15[1/m^3]');
model.physics('ptp').feature('init1').set('ebarinit', '2[V]');
model.physics('ptp').create('xsec1', 'CrossSectionImport', -1);
model.physics('ptp').feature('xsec1').set('Filepath', 'Ar_xsecs.txt');
model.physics('ptp').feature('xsec1').runCommand('importData');
model.physics('ptp').create('eir6', 'ElectronImpactReaction', 1);
model.physics('ptp').feature('eir6').set('formula', 'e+Ar2+=>Ars+Ar');
model.physics('ptp').feature('eir6').set('type', 'Excitation');
model.physics('ptp').feature('eir6').set('de', '-2.5[V]');
model.physics('ptp').feature('eir6').set('kf', '7e-13[m^3/s]*N_A_const*(300/(ptp.Te*11600))^0.5');
model.physics('ptp').create('rxn1', 'Reaction', 1);
model.physics('ptp').feature('rxn1').set('formula', 'Ars+Ars=>e+Ar+Ar+');
model.physics('ptp').feature('rxn1').set('kf', '1.2e-15[m^3/s]*N_A_const');
model.physics('ptp').create('rxn2', 'Reaction', 1);
model.physics('ptp').feature('rxn2').set('formula', 'Ars=>Ar');
model.physics('ptp').feature('rxn2').set('kf', '5e5');
model.physics('ptp').create('rxn3', 'Reaction', 1);
model.physics('ptp').feature('rxn3').set('formula', 'Ar+Ar+Ar+=>Ar2++Ar');
model.physics('ptp').feature('rxn3').set('kf', '2.5e-43[m^6/s]*N_A_const^2');
model.physics('ptp').feature('Ar').set('FromMassConstraint', true);
model.physics('ptp').feature('Ar').set('PresetSpeciesData', 'Ar');
model.physics('ptp').feature('Ars').set('PresetSpeciesData', 'Ar');
model.physics('ptp').feature('Ar_1p').set('PresetSpeciesData', 'Ar');
model.physics('ptp').feature('Ar_1p').set('MobilityDiffusivitySpecification', 'SpecifyMobilityComputeDiffusivity');
model.physics('ptp').feature('Ar_1p').set('IonTemperatureSpecification', 'LocalFieldApproximation');
model.physics('ptp').feature('Ar_1p').set('MobilitySpecification', 'ArIoninAr');
model.physics('ptp').feature('Ar2_1p').set('InitIon', true);
model.physics('ptp').feature('Ar2_1p').set('M', '0.08[kg/mol]');
model.physics('ptp').feature('Ar2_1p').set('MobilityDiffusivitySpecification', 'SpecifyMobilityComputeDiffusivity');
model.physics('ptp').feature('Ar2_1p').set('IonTemperatureSpecification', 'LocalFieldApproximation');
model.physics('ptp').feature('Ar2_1p').set('MobilitySpecification', 'ArIoninAr');
model.physics('ptp').create('sr1', 'SurfaceReaction', 0);
model.physics('ptp').feature('sr1').set('formula', 'Ar+=>Ar');
model.physics('ptp').feature('sr1').selection.all;
model.physics('ptp').feature('sr1').set('gammaf', 0);
model.physics('ptp').feature('sr1').set('gammai', 0.1);
model.physics('ptp').feature.duplicate('sr2', 'sr1');
model.physics('ptp').feature('sr2').set('formula', 'Ar2+=>2Ar');
model.physics('ptp').feature.duplicate('sr3', 'sr2');
model.physics('ptp').feature('sr3').set('formula', 'Ars=>Ar');
model.physics('ptp').feature('sr3').set('gammai', 0);
model.physics('ptp').feature('sr3').set('ebari', 0);
model.physics('ptp').feature('sr3').set('gammaf', 1);
model.physics('ptp').create('wall1', 'WallDriftDiffusion', 0);
model.physics('ptp').feature('wall1').selection.all;
model.physics('ptp').create('gnd1', 'Ground', 0);
model.physics('ptp').feature('gnd1').selection.set([2]);
model.physics('ptp').create('mct1', 'MetalContact', 0);
model.physics('ptp').feature('mct1').selection.set([1]);
model.physics('ptp').feature('mct1').set('Source', 'RF');
model.physics('ptp').feature('mct1').set('Prf', 'Prf');
model.physics('ptp').feature('mct1').set('fp', 'f0');

model.mesh('mesh1').create('edg1', 'Edge');
model.mesh('mesh1').feature('edg1').create('dis1', 'Distribution');
model.mesh('mesh1').feature('edg1').feature('dis1').set('type', 'predefined');
model.mesh('mesh1').feature('edg1').feature('dis1').set('elemcount', 150);
model.mesh('mesh1').feature('edg1').feature('dis1').set('elemratio', 10);
model.mesh('mesh1').feature('edg1').feature('dis1').set('symmetric', true);
model.mesh('mesh1').run;

model.study('std1').setGenPlots(false);
model.study('std1').setGenConv(false);
model.study('std1').feature('tper').set('useparam', true);
model.study('std1').feature('tper').setIndex('pname', 'f0', 0);
model.study('std1').feature('tper').setIndex('plistarr', '', 0);
model.study('std1').feature('tper').setIndex('punit', 'Hz', 0);
model.study('std1').feature('tper').setIndex('pname', 'f0', 0);
model.study('std1').feature('tper').setIndex('plistarr', '', 0);
model.study('std1').feature('tper').setIndex('punit', 'Hz', 0);
model.study('std1').feature('tper').setIndex('pname', 'Prf', 0);
model.study('std1').feature('tper').setIndex('plistarr', '10^{range(1.6989700043360187,0.04775533481992659,2.845098040014257)}', 0);

model.sol.create('sol1');
model.sol('sol1').study('std1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'tper');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').feature('comp1_Ne_per').set('scalemethod', 'manual');
model.sol('sol1').feature('v1').feature('comp1_V_per').set('scalemethod', 'manual');
model.sol('sol1').feature('v1').feature('comp1_ptp_Ars_W_per').set('scalemethod', 'manual');
model.sol('sol1').feature('v1').feature('comp1_ptp_Ar2_1p_W_per').set('scalemethod', 'manual');
model.sol('sol1').feature('v1').feature('comp1_ptp_mct1_Jdep_per').set('scalemethod', 'manual');
model.sol('sol1').feature('v1').feature('comp1_En_per').set('scalemethod', 'manual');
model.sol('sol1').feature('v1').feature('comp1_ptp_mct1_Va_per').set('scalemethod', 'manual');
model.sol('sol1').feature('v1').feature('comp1_ptp_Ar_1p_W_per').set('scalemethod', 'manual');
model.sol('sol1').feature('v1').feature('comp1_Ne_per').set('scaleval', '35');
model.sol('sol1').feature('v1').feature('comp1_V_per').set('scaleval', '500');
model.sol('sol1').feature('v1').feature('comp1_ptp_Ars_W_per').set('scaleval', '10');
model.sol('sol1').feature('v1').feature('comp1_ptp_Ar2_1p_W_per').set('scaleval', '10');
model.sol('sol1').feature('v1').feature('comp1_ptp_mct1_Jdep_per').set('scaleval', '10');
model.sol('sol1').feature('v1').feature('comp1_En_per').set('scaleval', '35');
model.sol('sol1').feature('v1').feature('comp1_ptp_mct1_Va_per').set('scaleval', '500');
model.sol('sol1').feature('v1').feature('comp1_ptp_Ar_1p_W_per').set('scaleval', '10');
model.sol('sol1').feature('v1').set('control', 'tper');
model.sol('sol1').create('s1', 'Stationary');
model.sol('sol1').feature('s1').set('stol', 0.001);
model.sol('sol1').feature('s1').create('p1', 'Parametric');
model.sol('sol1').feature('s1').feature.remove('pDef');
model.sol('sol1').feature('s1').feature('p1').set('control', 'tper');
model.sol('sol1').feature('s1').set('control', 'tper');
model.sol('sol1').feature('s1').feature('aDef').set('matherr', false);
model.sol('sol1').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('s1').feature('fc1').set('initstep', 1.0E-4);
model.sol('sol1').feature('s1').feature('fc1').set('minstep', 1.0E-6);
model.sol('sol1').feature('s1').feature('fc1').set('rstep', 5);
model.sol('sol1').feature('s1').feature('fc1').set('rstepabs', 0.05);
model.sol('sol1').feature('s1').feature('fc1').set('minsteprecovery', 0.01);
model.sol('sol1').feature('s1').feature('fc1').set('updweightsauto', 'wthresh');
model.sol('sol1').feature('s1').feature('fc1').set('updweightsdamp', 'current');
model.sol('sol1').feature('s1').feature('fc1').set('updweightsdampval', 0.1);
model.sol('sol1').feature('s1').feature('fc1').set('maxiter', 200);
model.sol('sol1').feature('s1').feature('fc1').set('ntolfact', 1);
model.sol('sol1').feature('s1').feature('fc1').set('termonres', false);
model.sol('sol1').feature('s1').create('d1', 'Direct');
model.sol('sol1').feature('s1').feature('d1').set('linsolver', 'pardiso');
model.sol('sol1').feature('s1').feature('d1').set('errorchk', 'off');
model.sol('sol1').feature('s1').feature('d1').label('Suggested Direct Solver (ptp)');
model.sol('sol1').feature('s1').create('i1', 'Iterative');
model.sol('sol1').feature('s1').feature('i1').set('linsolver', 'gmres');
model.sol('sol1').feature('s1').feature('i1').set('nlinnormlevel', 0.01);
model.sol('sol1').feature('s1').feature('i1').set('nlinnormuse', true);
model.sol('sol1').feature('s1').feature('i1').set('errorchk', false);
model.sol('sol1').feature('s1').feature('i1').label('Suggested Iterative Solver (ptp)');
model.sol('sol1').feature('s1').feature('i1').create('dd1', 'DomainDecomposition');
model.sol('sol1').feature('s1').feature('i1').feature('dd1').set('domdofmax', 150000);
model.sol('sol1').feature('s1').feature('i1').feature('dd1').set('ndom', 4);
model.sol('sol1').feature('s1').feature('i1').feature('dd1').set('usecoarse', false);
model.sol('sol1').feature('s1').feature('i1').feature('dd1').set('meshoverlap', false);
model.sol('sol1').feature('s1').feature('i1').feature('dd1').feature('ds').create('d1', 'Direct');
model.sol('sol1').feature('s1').feature('i1').feature('dd1').feature('ds').feature('d1').set('linsolver', 'pardiso');
model.sol('sol1').feature('s1').feature('i1').feature('dd1').feature('ds').feature('d1').set('errorchk', false);
model.sol('sol1').feature('s1').feature('fc1').set('linsolver', 'd1');
model.sol('sol1').feature('s1').feature('fc1').set('initstep', 1.0E-4);
model.sol('sol1').feature('s1').feature('fc1').set('minstep', 1.0E-6);
model.sol('sol1').feature('s1').feature('fc1').set('rstep', 5);
model.sol('sol1').feature('s1').feature('fc1').set('rstepabs', 0.05);
model.sol('sol1').feature('s1').feature('fc1').set('minsteprecovery', 0.01);
model.sol('sol1').feature('s1').feature('fc1').set('updweightsauto', 'wthresh');
model.sol('sol1').feature('s1').feature('fc1').set('updweightsdamp', 'current');
model.sol('sol1').feature('s1').feature('fc1').set('updweightsdampval', 0.1);
model.sol('sol1').feature('s1').feature('fc1').set('maxiter', 200);
model.sol('sol1').feature('s1').feature('fc1').set('ntolfact', 1);
model.sol('sol1').feature('s1').feature('fc1').set('termonres', false);
model.sol('sol1').feature('s1').feature.remove('fcDef');
model.sol('sol1').attach('std1');
model.sol('sol1').runFromTo('st1', 'v1');

model.result.create('pg1', 'PlotGroup1D');
model.result('pg1').run;
model.result('pg1').label('Power and ne vs. applied voltage');
model.result('pg1').create('glob1', 'Global');
model.result('pg1').feature('glob1').set('markerpos', 'datapoints');
model.result('pg1').feature('glob1').set('linewidth', 'preference');
model.result('pg1').feature('glob1').setIndex('expr', 'ptp.mct1.PowerT', 0);
model.result('pg1').feature('glob1').setIndex('unit', 'W', 0);
model.result('pg1').feature('glob1').setIndex('descr', 'Power terminal', 0);
model.result('pg1').feature('glob1').set('xdata', 'expr');
model.result('pg1').feature('glob1').set('xdataexpr', 'ptp.mct1.Va_per');
model.result('pg1').feature.duplicate('glob2', 'glob1');
model.result('pg1').run;
model.result('pg1').feature('glob2').setIndex('expr', 'aveop1(ptp.neav)', 0);
model.result('pg1').feature('glob2').setIndex('unit', '1/m^3', 0);
model.result('pg1').feature('glob2').setIndex('descr', 'Average ne', 0);
model.result('pg1').run;
model.result('pg1').set('titletype', 'none');
model.result('pg1').set('twoyaxes', true);
model.result('pg1').setIndex('plotonsecyaxis', true, 1, 1);
model.result('pg1').set('legendpos', 'upperleft');

model.sol('sol1').feature('s1').feature('fc1').set('plot', true);
model.sol('sol1').runAll;

model.result('pg1').run;

model.study.create('std2');
model.study('std2').create('tptd', 'TimePeriodicToTimeDependent');
model.study('std2').feature('tptd').set('plotgroup', 'Default');
model.study('std2').feature('tptd').set('initialtime', '0');
model.study('std2').feature('tptd').set('solnum', 'auto');
model.study('std2').feature('tptd').set('notsolnum', 'auto');
model.study('std2').feature('tptd').set('outputmap', {});
model.study('std2').feature('tptd').setSolveFor('/physics/ptp', true);
model.study.create('std3');
model.study('std3').create('tptd', 'TimePeriodicToTimeDependent');
model.study('std3').feature('tptd').set('plotgroup', 'Default');
model.study('std3').feature('tptd').set('initialtime', '0');
model.study('std3').feature('tptd').set('solnum', 'auto');
model.study('std3').feature('tptd').set('notsolnum', 'auto');
model.study('std3').feature('tptd').set('outputmap', {});
model.study('std3').feature('tptd').setSolveFor('/physics/ptp', true);
model.study('std2').setGenPlots(false);
model.study('std2').setGenConv(false);
model.study('std2').feature('tptd').set('tlist', 'range(0,(1/f0)/101,1/f0)');
model.study('std2').feature('tptd').set('usesol', true);
model.study('std2').feature('tptd').set('notsolmethod', 'sol');
model.study('std2').feature('tptd').set('notstudy', 'std1');
model.study('std2').feature('tptd').set('notsolnum', 'from_list');
model.study('std2').feature('tptd').set('notlistsolnum', [8]);

model.sol.create('sol2');
model.sol('sol2').study('std2');
model.sol('sol2').create('st1', 'StudyStep');
model.sol('sol2').feature('st1').set('study', 'std2');
model.sol('sol2').feature('st1').set('studystep', 'tptd');
model.sol('sol2').create('v1', 'Variables');
model.sol('sol2').feature('v1').set('control', 'tptd');
model.sol('sol2').create('t1', 'Time');
model.sol('sol2').feature('t1').set('tlist', 'range(0,(1/f0)/101,1/f0)');
model.sol('sol2').feature('t1').set('plot', 'off');
model.sol('sol2').feature('t1').set('plotgroup', 'Default');
model.sol('sol2').feature('t1').set('plotfreq', 'tout');
model.sol('sol2').feature('t1').set('probesel', 'all');
model.sol('sol2').feature('t1').set('probes', {});
model.sol('sol2').feature('t1').set('probefreq', 'tsteps');
model.sol('sol2').feature('t1').set('atolglobalvaluemethod', 'factor');
model.sol('sol2').feature('t1').set('reacf', true);
model.sol('sol2').feature('t1').set('storeudot', true);
model.sol('sol2').feature('t1').set('tstepsbdf', 'intermediate');
model.sol('sol2').feature('t1').set('endtimeinterpolation', true);
model.sol('sol2').feature('t1').set('control', 'tptd');
model.sol('sol2').feature('t1').create('fc1', 'FullyCoupled');
model.sol('sol2').feature('t1').feature('fc1').set('linsolver', 'dDef');
model.sol('sol2').feature('t1').feature.remove('fcDef');
model.sol('sol2').attach('std2');
model.sol('sol2').runAll;

model.study('std3').setGenPlots(false);
model.study('std3').setGenConv(false);
model.study('std3').feature('tptd').set('tlist', 'range(0,(1/f0)/101,1/f0)');
model.study('std3').feature('tptd').set('usesol', true);
model.study('std3').feature('tptd').set('notsolmethod', 'sol');
model.study('std3').feature('tptd').set('notstudy', 'std1');
model.study('std3').feature('tptd').set('notsolnum', 'from_list');
model.study('std3').feature('tptd').set('notlistsolnum', [24]);

model.sol.create('sol3');
model.sol('sol3').study('std3');
model.sol('sol3').create('st1', 'StudyStep');
model.sol('sol3').feature('st1').set('study', 'std3');
model.sol('sol3').feature('st1').set('studystep', 'tptd');
model.sol('sol3').create('v1', 'Variables');
model.sol('sol3').feature('v1').set('control', 'tptd');
model.sol('sol3').create('t1', 'Time');
model.sol('sol3').feature('t1').set('tlist', 'range(0,(1/f0)/101,1/f0)');
model.sol('sol3').feature('t1').set('plot', 'off');
model.sol('sol3').feature('t1').set('plotgroup', 'pg1');
model.sol('sol3').feature('t1').set('plotfreq', 'tout');
model.sol('sol3').feature('t1').set('probesel', 'all');
model.sol('sol3').feature('t1').set('probes', {});
model.sol('sol3').feature('t1').set('probefreq', 'tsteps');
model.sol('sol3').feature('t1').set('atolglobalvaluemethod', 'factor');
model.sol('sol3').feature('t1').set('reacf', true);
model.sol('sol3').feature('t1').set('storeudot', true);
model.sol('sol3').feature('t1').set('tstepsbdf', 'intermediate');
model.sol('sol3').feature('t1').set('endtimeinterpolation', true);
model.sol('sol3').feature('t1').set('control', 'tptd');
model.sol('sol3').feature('t1').create('fc1', 'FullyCoupled');
model.sol('sol3').feature('t1').feature('fc1').set('linsolver', 'dDef');
model.sol('sol3').feature('t1').feature.remove('fcDef');
model.sol('sol3').attach('std3');
model.sol('sol3').runAll;

model.result.dataset.create('par1', 'Parametric1D');
model.result.dataset('par1').set('data', 'dset2');
model.result.dataset('par1').set('levelscale', 'f0');
model.result.dataset.duplicate('par2', 'par1');
model.result.dataset('par2').set('data', 'dset3');
model.result.create('pg2', 'PlotGroup2D');
model.result('pg2').run;
model.result('pg2').label('Electron density, alpha regime');
model.result('pg2').set('ylabelactive', true);
model.result('pg2').set('ylabel', 'Period fraction');
model.result('pg2').create('surf1', 'Surface');
model.result('pg2').feature('surf1').set('expr', 'ptp.ne');
model.result('pg2').run;
model.result('pg2').run;
model.result.duplicate('pg3', 'pg2');
model.result('pg3').run;
model.result('pg3').label('Electron temperature, alpha regime');
model.result('pg3').run;
model.result('pg3').feature('surf1').set('expr', 'ptp.Te');
model.result('pg3').run;
model.result('pg3').run;
model.result.duplicate('pg4', 'pg3');
model.result('pg4').run;
model.result('pg4').label('Power absorbed by electrons, alpha regime');
model.result('pg4').run;
model.result('pg4').feature('surf1').set('expr', 'ptp.Pcap');
model.result('pg4').run;
model.result('pg4').create('con1', 'Contour');
model.result('pg4').feature('con1').set('expr', '(ptp.n_wAr_1p+ptp.n_wAr2_1p-ptp.ne)*e_const');
model.result('pg4').feature('con1').set('levelmethod', 'levels');
model.result('pg4').feature('con1').set('levels', '1e-2');
model.result('pg4').feature('con1').set('contourtype', 'tubes');
model.result('pg4').feature('con1').set('coloring', 'uniform');
model.result('pg4').feature('con1').set('color', 'white');
model.result('pg4').feature('con1').set('colorlegend', false);
model.result('pg4').run;
model.result('pg4').run;
model.result.duplicate('pg5', 'pg4');
model.result('pg5').run;
model.result('pg5').label('Power absorbed by electrons, gamma regime');
model.result('pg5').set('data', 'par2');
model.result('pg5').run;
model.result('pg4').run;
model.result.duplicate('pg6', 'pg4');
model.result('pg6').run;
model.result('pg6').label('Electron source, alpha regime');
model.result('pg6').run;
model.result('pg6').feature('surf1').set('expr', 'ptp.Re');
model.result('pg6').run;
model.result('pg6').run;
model.result.duplicate('pg7', 'pg6');
model.result('pg7').run;
model.result('pg7').label('Electron source, gamma regime');
model.result('pg7').set('data', 'par2');
model.result('pg7').run;

model.title('Alpha to Gamma Transition');

model.description('Capacitively coupled RF discharges can operate in two distinct regimes depending on the discharge power. In the low power regime, known as the alpha regime, the electric field oscillation is responsible to heat and create electrons. In the high power regime, known as gamma regime, the discharge is sustained primarily by electron avalanche within the sheaths initiated by secondary electrons emitted by ion bombarding the electrodes. This model investigates the alpha and gamma regimes and the transition between them in a capacitively coupled RF discharge at atmospheric pressure using the Plasma, Time Periodic interface.');

model.mesh.clearMeshes;

model.sol('sol1').clearSolutionData;
model.sol('sol2').clearSolutionData;
model.sol('sol3').clearSolutionData;

model.label('alpha_to_gamma_transition.mph');

model.modelNode.label('Components');

out = model;
