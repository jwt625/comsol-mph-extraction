function out = model
%
% electrochemical_impedance_spectroscopy.m
%
% Model exported on May 26 2025, 21:27 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/Electrochemistry_Module/Applications');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 1);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.physics.create('tcd', 'TertiaryElectroanalysis', 'geom1', {'cRed' 'cOx'});

model.study.create('std1');
model.study('std1').create('stat', 'Stationary');
model.study('std1').feature('stat').set('solnum', 'auto');
model.study('std1').feature('stat').set('notsolnum', 'auto');
model.study('std1').feature('stat').set('outputmap', {});
model.study('std1').feature('stat').set('ngenAUX', '1');
model.study('std1').feature('stat').set('goalngenAUX', '1');
model.study('std1').feature('stat').set('ngenAUX', '1');
model.study('std1').feature('stat').set('goalngenAUX', '1');
model.study('std1').feature('stat').setSolveFor('/physics/tcd', true);
model.study('std1').create('frlin', 'Frequencylinearized');
model.study('std1').feature('frlin').set('solnum', 'auto');
model.study('std1').feature('frlin').set('notsolnum', 'auto');
model.study('std1').feature('frlin').set('outputmap', {});
model.study('std1').feature('frlin').set('ngenAUX', '1');
model.study('std1').feature('frlin').set('goalngenAUX', '1');
model.study('std1').feature('frlin').set('ngenAUX', '1');
model.study('std1').feature('frlin').set('goalngenAUX', '1');
model.study('std1').feature('frlin').setSolveFor('/physics/tcd', true);

% To import content from file, use:
% model.param.loadFile('FILENAME');
model.param.set('A_el', '1[mm^2]', 'Electrode area');
model.param.set('c_bulk_ox', '1.0[mol/m^3]', 'Bulk concentration');
model.param.set('c_bulk_red', '1.0[mol/m^3]', 'Bulk concentration');
model.param.set('c_ref', '1.0[mol/m^3]', 'Reference concentration');
model.param.set('Cdl', '20[uF/cm^2]', 'Double layer interfacial capacitance');
model.param.set('Dox', '5e-10[m^2/s]', 'Diffusion coefficient');
model.param.set('Dred', '5e-10[m^2/s]', 'Diffusion coefficient');
model.param.set('freq_max', '10000[Hz]', 'Maximum frequency');
model.param.set('freq_min', '1[Hz]', 'Minimum frequency');
model.param.set('i0', '5.0[A/m^2]', 'Exchange current density at reference concentrations');
model.param.set('k0', '0.001[cm/s]', 'Heterogeneous rate constant');
model.param.set('L_el', 'xdiff_max*10', 'Electrolyte length');
model.param.set('log_freq_max', 'log10(freq_max[1/Hz])', 'Log of max frequency');
model.param.set('log_freq_min', 'log10(freq_min[1/Hz])', 'Log of min frequency');
model.param.set('V_app', '5[mV]', 'Applied perturbation potential');
model.param.set('xdiff_max', 'sqrt(Dox/(pi*freq_min))', 'Mean diffusion layer thickness at minimum frequency');
model.param.set('xdiff_min', 'sqrt(Dox/(pi*freq_max))', 'Mean diffusion layer thickness at maximum frequency');

model.geom('geom1').create('i1', 'Interval');
model.geom('geom1').feature('i1').setIndex('coord', 'L_el', 1);
model.geom('geom1').run('i1');
model.geom('geom1').run;

model.physics('tcd').feature('ice1').set('D_cRed', {'Dred' '0' '0' '0' 'Dred' '0' '0' '0' 'Dred'});
model.physics('tcd').feature('ice1').set('D_cOx', {'Dox' '0' '0' '0' 'Dox' '0' '0' '0' 'Dox'});
model.physics('tcd').feature('init1').setIndex('initc', 'c_bulk_red', 0);
model.physics('tcd').feature('init1').setIndex('initc', 'c_bulk_ox', 1);
model.physics('tcd').create('conc1', 'Concentration', 0);
model.physics('tcd').feature('conc1').selection.set([2]);
model.physics('tcd').feature('conc1').setIndex('species', true, 0);
model.physics('tcd').feature('conc1').setIndex('c0', 'c_bulk_red', 0);
model.physics('tcd').feature('conc1').setIndex('species', true, 1);
model.physics('tcd').feature('conc1').setIndex('c0', 'c_bulk_ox', 1);
model.physics('tcd').create('es1', 'ElectrodeSurface', 0);
model.physics('tcd').feature('es1').selection.set([1]);
model.physics('tcd').feature('es1').set('BoundaryCondition', 'TotalCurrent');
model.physics('tcd').feature('es1').set('Itl', '0[A]');
model.physics('tcd').feature('es1').set('deltaItot', '5[mA]');
model.physics('tcd').feature('es1').feature('er1').set('i0_ref', 'i0');
model.physics('tcd').feature('es1').feature('er1').setIndex('Vi0', 1, 0);
model.physics('tcd').feature('es1').feature('er1').setIndex('Vi0', -1, 1);
model.physics('tcd').feature('es1').feature('er1').setIndex('cref', 'c_ref', 0, 0);
model.physics('tcd').feature('es1').feature('er1').setIndex('cref', 'c_ref', 1, 0);
model.physics('tcd').feature('es1').create('dlc1', 'DoubleLayerCapacitance', 0);
model.physics('tcd').feature('es1').feature('dlc1').set('Cdl', 'Cdl');

model.mesh('mesh1').automatic(false);
model.mesh('mesh1').feature('size').set('hauto', 1);
model.mesh('mesh1').feature('size1').set('custom', true);
model.mesh('mesh1').feature('size1').set('hmaxactive', true);
model.mesh('mesh1').feature('size1').set('hmax', 'xdiff_min/25');

model.study('std1').feature('frlin').set('plist', '10^range(log_freq_min,0.05,log_freq_max)');
model.study('std1').setGenPlots(false);

model.sol.create('sol1');
model.sol('sol1').study('std1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'stat');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').feature('comp1_tcd_es1_phisext').set('scalemethod', 'manual');
model.sol('sol1').feature('v1').feature('comp1_tcd_es1_phisext').set('scaleval', '1');
model.sol('sol1').feature('v1').set('control', 'stat');
model.sol('sol1').create('s1', 'Stationary');
model.sol('sol1').feature('s1').set('stol', 1.0E-4);
model.sol('sol1').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('s1').feature('fc1').set('dtech', 'auto');
model.sol('sol1').feature('s1').feature('fc1').set('maxiter', 50);
model.sol('sol1').feature('s1').feature('fc1').set('minstep', 1.0E-6);
model.sol('sol1').feature('s1').create('d1', 'Direct');
model.sol('sol1').feature('s1').feature('d1').set('linsolver', 'pardiso');
model.sol('sol1').feature('s1').feature('d1').label('Direct (tcd)');
model.sol('sol1').feature('s1').create('i1', 'Iterative');
model.sol('sol1').feature('s1').feature('i1').set('maxlinit', 1000);
model.sol('sol1').feature('s1').feature('i1').set('nlinnormuse', 'on');
model.sol('sol1').feature('s1').feature('i1').label('Algebraic Multigrid (tcd)');
model.sol('sol1').feature('s1').feature('i1').create('mg1', 'Multigrid');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').set('prefun', 'saamg');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').set('maxcoarsedof', 50000);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').set('saamgcompwise', true);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').set('compactaggregation', true);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('pr').create('sc1', 'SCGS');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('pr').feature('sc1').set('linesweeptype', 'ssor');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('pr').feature('sc1').set('iter', 1);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('pr').feature('sc1').set('scgsmethod', 'lines');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('po').create('sc1', 'SCGS');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('po').feature('sc1').set('linesweeptype', 'ssor');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('po').feature('sc1').set('iter', 1);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('po').feature('sc1').set('scgsmethod', 'lines');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('cs').create('d1', 'Direct');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('cs').feature('d1').set('linsolver', 'pardiso');
model.sol('sol1').feature('s1').create('i2', 'Iterative');
model.sol('sol1').feature('s1').feature('i2').set('maxlinit', 1000);
model.sol('sol1').feature('s1').feature('i2').set('nlinnormuse', 'on');
model.sol('sol1').feature('s1').feature('i2').label('Geometric Multigrid (tcd)');
model.sol('sol1').feature('s1').feature('i2').create('mg1', 'Multigrid');
model.sol('sol1').feature('s1').feature('i2').feature('mg1').feature('pr').create('sc1', 'SCGS');
model.sol('sol1').feature('s1').feature('i2').feature('mg1').feature('pr').feature('sc1').set('linesweeptype', 'ssor');
model.sol('sol1').feature('s1').feature('i2').feature('mg1').feature('pr').feature('sc1').set('iter', 1);
model.sol('sol1').feature('s1').feature('i2').feature('mg1').feature('pr').feature('sc1').set('scgsmethod', 'lines');
model.sol('sol1').feature('s1').feature('i2').feature('mg1').feature('po').create('sc1', 'SCGS');
model.sol('sol1').feature('s1').feature('i2').feature('mg1').feature('po').feature('sc1').set('linesweeptype', 'ssor');
model.sol('sol1').feature('s1').feature('i2').feature('mg1').feature('po').feature('sc1').set('iter', 1);
model.sol('sol1').feature('s1').feature('i2').feature('mg1').feature('po').feature('sc1').set('scgsmethod', 'lines');
model.sol('sol1').feature('s1').feature('i2').feature('mg1').feature('cs').create('d1', 'Direct');
model.sol('sol1').feature('s1').feature('i2').feature('mg1').feature('cs').feature('d1').set('linsolver', 'pardiso');
model.sol('sol1').feature('s1').feature('fc1').set('linsolver', 'd1');
model.sol('sol1').feature('s1').feature('fc1').set('dtech', 'auto');
model.sol('sol1').feature('s1').feature('fc1').set('maxiter', 50);
model.sol('sol1').feature('s1').feature('fc1').set('minstep', 1.0E-6);
model.sol('sol1').feature('s1').feature.remove('fcDef');
model.sol('sol1').create('su1', 'StoreSolution');
model.sol('sol1').create('st2', 'StudyStep');
model.sol('sol1').feature('st2').set('study', 'std1');
model.sol('sol1').feature('st2').set('studystep', 'frlin');
model.sol('sol1').create('v2', 'Variables');
model.sol('sol1').feature('v2').set('initmethod', 'sol');
model.sol('sol1').feature('v2').set('initsol', 'sol1');
model.sol('sol1').feature('v2').set('initsoluse', 'sol2');
model.sol('sol1').feature('v2').set('notsolmethod', 'sol');
model.sol('sol1').feature('v2').set('notsol', 'sol1');
model.sol('sol1').feature('v2').set('control', 'frlin');
model.sol('sol1').create('s2', 'Stationary');
model.sol('sol1').feature('s2').set('stol', 1.0E-4);
model.sol('sol1').feature('s2').create('p1', 'Parametric');
model.sol('sol1').feature('s2').feature.remove('pDef');
model.sol('sol1').feature('s2').feature('p1').set('pname', {'freq'});
model.sol('sol1').feature('s2').feature('p1').set('plistarr', {'10^range(log_freq_min,0.05,log_freq_max)'});
model.sol('sol1').feature('s2').feature('p1').set('punit', {'Hz'});
model.sol('sol1').feature('s2').feature('p1').set('pcontinuationmode', 'no');
model.sol('sol1').feature('s2').feature('p1').set('preusesol', 'no');
model.sol('sol1').feature('s2').feature('p1').set('pdistrib', 'off');
model.sol('sol1').feature('s2').feature('p1').set('plot', 'off');
model.sol('sol1').feature('s2').feature('p1').set('plotgroup', 'Default');
model.sol('sol1').feature('s2').feature('p1').set('probesel', 'all');
model.sol('sol1').feature('s2').feature('p1').set('probes', {});
model.sol('sol1').feature('s2').feature('p1').set('control', 'frlin');
model.sol('sol1').feature('s2').set('nonlin', 'linper');
model.sol('sol1').feature('s2').set('storelinpoint', true);
model.sol('sol1').feature('s2').set('linpsolnum', 'all');
model.sol('sol1').feature('s2').set('control', 'frlin');
model.sol('sol1').feature('s2').set('linpmethod', 'sol');
model.sol('sol1').feature('s2').set('linpsol', 'sol1');
model.sol('sol1').feature('s2').set('linpsoluse', 'sol2');
model.sol('sol1').feature('s2').set('control', 'frlin');
model.sol('sol1').feature('s2').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('s2').feature('fc1').set('dtech', 'auto');
model.sol('sol1').feature('s2').create('d1', 'Direct');
model.sol('sol1').feature('s2').feature('d1').set('linsolver', 'pardiso');
model.sol('sol1').feature('s2').feature('d1').label('Direct (tcd)');
model.sol('sol1').feature('s2').create('i1', 'Iterative');
model.sol('sol1').feature('s2').feature('i1').set('maxlinit', 1000);
model.sol('sol1').feature('s2').feature('i1').set('nlinnormuse', 'on');
model.sol('sol1').feature('s2').feature('i1').label('Algebraic Multigrid (tcd)');
model.sol('sol1').feature('s2').feature('i1').create('mg1', 'Multigrid');
model.sol('sol1').feature('s2').feature('i1').feature('mg1').set('prefun', 'saamg');
model.sol('sol1').feature('s2').feature('i1').feature('mg1').set('maxcoarsedof', 50000);
model.sol('sol1').feature('s2').feature('i1').feature('mg1').set('saamgcompwise', true);
model.sol('sol1').feature('s2').feature('i1').feature('mg1').set('compactaggregation', true);
model.sol('sol1').feature('s2').feature('i1').feature('mg1').feature('pr').create('sc1', 'SCGS');
model.sol('sol1').feature('s2').feature('i1').feature('mg1').feature('pr').feature('sc1').set('linesweeptype', 'ssor');
model.sol('sol1').feature('s2').feature('i1').feature('mg1').feature('pr').feature('sc1').set('iter', 1);
model.sol('sol1').feature('s2').feature('i1').feature('mg1').feature('pr').feature('sc1').set('scgsmethod', 'lines');
model.sol('sol1').feature('s2').feature('i1').feature('mg1').feature('po').create('sc1', 'SCGS');
model.sol('sol1').feature('s2').feature('i1').feature('mg1').feature('po').feature('sc1').set('linesweeptype', 'ssor');
model.sol('sol1').feature('s2').feature('i1').feature('mg1').feature('po').feature('sc1').set('iter', 1);
model.sol('sol1').feature('s2').feature('i1').feature('mg1').feature('po').feature('sc1').set('scgsmethod', 'lines');
model.sol('sol1').feature('s2').feature('i1').feature('mg1').feature('cs').create('d1', 'Direct');
model.sol('sol1').feature('s2').feature('i1').feature('mg1').feature('cs').feature('d1').set('linsolver', 'pardiso');
model.sol('sol1').feature('s2').create('i2', 'Iterative');
model.sol('sol1').feature('s2').feature('i2').set('maxlinit', 1000);
model.sol('sol1').feature('s2').feature('i2').set('nlinnormuse', 'on');
model.sol('sol1').feature('s2').feature('i2').label('Geometric Multigrid (tcd)');
model.sol('sol1').feature('s2').feature('i2').create('mg1', 'Multigrid');
model.sol('sol1').feature('s2').feature('i2').feature('mg1').feature('pr').create('sc1', 'SCGS');
model.sol('sol1').feature('s2').feature('i2').feature('mg1').feature('pr').feature('sc1').set('linesweeptype', 'ssor');
model.sol('sol1').feature('s2').feature('i2').feature('mg1').feature('pr').feature('sc1').set('iter', 1);
model.sol('sol1').feature('s2').feature('i2').feature('mg1').feature('pr').feature('sc1').set('scgsmethod', 'lines');
model.sol('sol1').feature('s2').feature('i2').feature('mg1').feature('po').create('sc1', 'SCGS');
model.sol('sol1').feature('s2').feature('i2').feature('mg1').feature('po').feature('sc1').set('linesweeptype', 'ssor');
model.sol('sol1').feature('s2').feature('i2').feature('mg1').feature('po').feature('sc1').set('iter', 1);
model.sol('sol1').feature('s2').feature('i2').feature('mg1').feature('po').feature('sc1').set('scgsmethod', 'lines');
model.sol('sol1').feature('s2').feature('i2').feature('mg1').feature('cs').create('d1', 'Direct');
model.sol('sol1').feature('s2').feature('i2').feature('mg1').feature('cs').feature('d1').set('linsolver', 'pardiso');
model.sol('sol1').feature('s2').feature('fc1').set('linsolver', 'd1');
model.sol('sol1').feature('s2').feature('fc1').set('dtech', 'auto');
model.sol('sol1').feature('s2').feature.remove('fcDef');
model.sol('sol1').feature('v2').set('notsolnum', 'auto');
model.sol('sol1').feature('v2').set('notsolvertype', 'solnum');
model.sol('sol1').attach('std1');
model.sol('sol1').runAll;

model.result.create('pg1', 'PlotGroup1D');
model.result('pg1').run;
model.result('pg1').label('Impedance with respect to ground');
model.result('pg1').set('xlabelactive', true);
model.result('pg1').set('ylabelactive', true);
model.result('pg1').set('xlabel', ['Real impedance (' 'ohm' '*m<sup>2</sup>)']);
model.result('pg1').set('ylabel', ['Imaginary impedance (' 'ohm' '*m<sup>2</sup>)']);
model.result('pg1').set('preserveaspect', true);
model.result('pg1').set('showlegends', false);
model.result('pg1').create('nyq1', 'Nyquist');
model.result('pg1').feature('nyq1').set('markerpos', 'datapoints');
model.result('pg1').feature('nyq1').set('linewidth', 'preference');
model.result('pg1').feature('nyq1').setIndex('expr', 'conj(tcd.Zvsgrnd_es1)', 0);
model.result('pg1').feature('nyq1').setIndex('descr', 'Impedance with respect to ground', 0);
model.result('pg1').run;
model.result.create('pg2', 'PlotGroup1D');
model.result('pg2').run;
model.result('pg2').label('Bode plot, absolute value of impedance');
model.result('pg2').set('xlabelactive', true);
model.result('pg2').set('xlabel', 'Frequency (Hz)');
model.result('pg2').set('ylabelactive', true);
model.result('pg2').set('ylabel', ['Impedance (' 'ohm' '*m<sup>2</sup>)']);
model.result('pg2').set('xlog', true);
model.result('pg2').set('ylog', true);
model.result('pg2').set('showlegends', false);
model.result('pg2').set('titletype', 'manual');
model.result('pg2').set('title', 'Bode plot: Impedance');
model.result('pg2').create('glob1', 'Global');
model.result('pg2').feature('glob1').set('markerpos', 'datapoints');
model.result('pg2').feature('glob1').set('linewidth', 'preference');
model.result('pg2').feature('glob1').setIndex('expr', 'abs(tcd.Zvsgrnd_es1)', 0);
model.result('pg2').feature('glob1').setIndex('descr', 'Absolute value of impedance', 0);
model.result('pg2').feature('glob1').set('xdata', 'expr');
model.result('pg2').feature('glob1').set('xdataexpr', 'freq');
model.result('pg2').run;
model.result('pg2').run;
model.result.duplicate('pg3', 'pg2');
model.result('pg3').run;
model.result('pg3').set('title', 'Phase angle');
model.result('pg3').label('Bode phase plot');
model.result('pg3').set('ylabel', 'Phase angle (rad)');
model.result('pg3').set('ylog', false);
model.result('pg3').run;
model.result('pg3').feature('glob1').setIndex('expr', 'arg(tcd.Zvsgrnd_es1)', 0);
model.result('pg3').feature('glob1').setIndex('descr', 'Phase angle', 0);
model.result('pg3').run;

model.title([]);

model.description('');

model.label('electrochemical_impedance_spectroscopy_embedded.mph');

model.result('pg3').run;

model.setExpectedComputationTime('7 seconds');

model.result.report.create('rpt1', 'Report');
model.result.report('rpt1').set('format', 'docx');
model.result.report('rpt1').set('filename', 'user:///impedancespec.docx');
model.result.report('rpt1').set('imagesize', 'large');
model.result.report('rpt1').feature.create('tp1', 'TitlePage');
model.result.report('rpt1').feature('tp1').label('Electrochemical Impedance Spectroscopy');
model.result.report('rpt1').feature('tp1').set('titleimage', 'none');
model.result.report('rpt1').feature('tp1').set('includeauthor', false);
model.result.report('rpt1').feature('tp1').set('includecompany', false);
model.result.report('rpt1').feature('tp1').set('includeversion', false);
model.result.report('rpt1').feature('tp1').set('summary', 'Electrochemical impedance spectroscopy (EIS) is a common technique in which a small oscillating perturbation is applied to an electrochemical system to interrogate kinetic and transport properties. This example models EIS for a range of electrode reaction rates. Nyquist and Bode plots illustrate the transition between the reaction proceeding under kinetic or transport control.');
model.result.report('rpt1').feature('tp1').set('includeacknowledgment', false);
model.result.report('rpt1').feature.create('toc1', 'TableOfContents');
model.result.report('rpt1').feature.create('sec1', 'Section');
model.result.report('rpt1').feature('sec1').label('Software Information');
model.result.report('rpt1').feature('sec1').feature.create('root1', 'Model');
model.result.report('rpt1').feature('sec1').feature('root1').label('About the Software');
model.result.report('rpt1').feature('sec1').feature('root1').set('includeunitsystem', true);
model.result.report('rpt1').feature('sec1').feature.create('std1', 'Study');
model.result.report('rpt1').feature('sec1').feature('std1').setIndex('children', false, 0, 1);
model.result.report('rpt1').feature('sec1').feature('std1').setIndex('children', false, 1, 1);
model.result.report('rpt1').feature.create('sec2', 'Section');
model.result.report('rpt1').feature('sec2').label('Model Parameters');
model.result.report('rpt1').feature('sec2').feature.create('param1', 'Parameter');
model.result.report('rpt1').feature('sec2').feature('param1').label('Parameters in the Embedded Model');
model.result.report('rpt1').feature.create('sec3', 'Section');
model.result.report('rpt1').feature('sec3').label('Results');
model.result.report('rpt1').feature('sec3').feature.create('pg1', 'PlotGroup');
model.result.report('rpt1').feature('sec3').feature('pg1').label('Nyquist plot');
model.result.report('rpt1').feature('sec3').feature.duplicate('pg2', 'pg1');
model.result.report('rpt1').feature('sec3').feature('pg2').set('noderef', 'pg2');
model.result.report('rpt1').feature('sec3').feature('pg2').label('Bode plot, absolute value of impedance');
model.result.report('rpt1').feature('sec3').feature.duplicate('pg3', 'pg2');
model.result.report('rpt1').feature('sec3').feature('pg3').label('Bode plot, phase angle');
model.result.report('rpt1').feature('sec3').feature('pg3').set('noderef', 'pg3');

model.title('Electrochemical Impedance Spectroscopy');

model.description(['The purpose of this app is to understand EIS, Nyquist, and Bode plots. The app lets you vary the bulk concentration, diffusion coefficient, exchange current density, double layer capacitance, and the maximum and minimum frequency.' newline  newline 'Electrochemical impedance spectroscopy (EIS) is a common technique in electroanalysis used to study the harmonic response of an electrochemical system. A small, sinusoidal variation is applied to the potential at the working electrode, and the resulting current is analyzed in the frequency domain.' newline  newline 'The real and imaginary components of the impedance give information about the kinetic and mass transport properties of the cell, as well as the surface properties through the double layer capacitance.']);

model.mesh.clearMeshes;

model.sol('sol1').clearSolutionData;
model.sol('sol2').clearSolutionData;

model.label('electrochemical_impedance_spectroscopy.mph');

model.modelNode.label('Components');

out = model;
