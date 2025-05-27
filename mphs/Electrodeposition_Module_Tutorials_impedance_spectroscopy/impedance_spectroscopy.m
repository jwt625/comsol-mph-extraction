function out = model
%
% impedance_spectroscopy.m
%
% Model exported on May 26 2025, 21:28 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/Electrodeposition_Module/Tutorials');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 1);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.physics.create('tcd', 'TertiaryElectroanalysis', 'geom1', {'cRed' 'cOx'});

model.study.create('std1');
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
model.param.set('D', '2e-10[m^2/s]', 'Diffusion coefficient');
model.param.set('c_bulk', '1[mol/m^3]', 'Bulk concentration');
model.param.set('Cdl', '20[uF/cm^2]', 'Double layer interfacial capacitance');
model.param.set('k0', '0.001[cm/s]', 'Heterogeneous rate constant');
model.param.set('i0ref', 'k0*F_const*1[M]', 'Reference exchange current density');
model.param.set('freq_min', '1[Hz]', 'Minimum frequency');
model.param.set('freq_max', '1000[Hz]', 'Maximum frequency');
model.param.set('log_freq_min', 'log10(freq_min[1/Hz])', 'Log of min frequency');
model.param.set('log_freq_max', 'log10(freq_max[1/Hz])', 'Log of max frequency');
model.param.set('xdiff_max', 'sqrt(D/(2*pi*freq_min))', 'Mean diffusion layer thickness at minimum frequency');
model.param.set('xdiff_min', 'sqrt(D/(2*pi*freq_max))', 'Mean diffusion layer thickness at maximum frequency');
model.param.set('L_el', 'xdiff_max*10', 'Electrolyte length');
model.param.set('A_el', '1[mm^2]', 'Electrode area');
model.param.set('V_app', '5[mV]', 'Applied perturbation potential');

model.geom('geom1').create('i1', 'Interval');
model.geom('geom1').feature('i1').setIndex('coord', 'L_el', 1);
model.geom('geom1').runPre('fin');
model.geom('geom1').run;

model.physics('tcd').feature('ice1').set('D_cRed', {'D' '0' '0' '0' 'D' '0' '0' '0' 'D'});
model.physics('tcd').feature('ice1').set('D_cOx', {'D' '0' '0' '0' 'D' '0' '0' '0' 'D'});
model.physics('tcd').feature('init1').setIndex('initc', 'c_bulk', 0);
model.physics('tcd').feature('init1').setIndex('initc', 'c_bulk', 1);
model.physics('tcd').create('conc1', 'Concentration', 0);
model.physics('tcd').feature('conc1').selection.set([2]);
model.physics('tcd').feature('conc1').setIndex('species', true, 0);
model.physics('tcd').feature('conc1').setIndex('c0', 'c_bulk', 0);
model.physics('tcd').feature('conc1').setIndex('species', true, 1);
model.physics('tcd').feature('conc1').setIndex('c0', 'c_bulk', 1);
model.physics('tcd').create('es1', 'ElectrodeSurface', 0);
model.physics('tcd').feature('es1').selection.set([1]);
model.physics('tcd').feature('es1').set('deltaphisext', 'V_app');
model.physics('tcd').feature('es1').feature('er1').setIndex('Vi0', 1, 0);
model.physics('tcd').feature('es1').feature('er1').setIndex('Vi0', -1, 1);
model.physics('tcd').feature('es1').feature('er1').set('i0_ref', 'i0ref');
model.physics('tcd').feature('es1').create('dlc1', 'DoubleLayerCapacitance', 0);
model.physics('tcd').feature('es1').feature('dlc1').set('Cdl', 'Cdl');

model.mesh('mesh1').autoMeshSize(1);
model.mesh('mesh1').automatic(false);
model.mesh('mesh1').feature('size1').set('custom', true);
model.mesh('mesh1').feature('size1').set('hmaxactive', true);
model.mesh('mesh1').feature('size1').set('hmax', 'xdiff_min/25');

model.study('std1').create('param', 'Parametric');
model.study('std1').feature('param').setIndex('pname', 'D', 0);
model.study('std1').feature('param').setIndex('plistarr', '', 0);
model.study('std1').feature('param').setIndex('punit', 'm^2/s', 0);
model.study('std1').feature('param').setIndex('pname', 'D', 0);
model.study('std1').feature('param').setIndex('plistarr', '', 0);
model.study('std1').feature('param').setIndex('punit', 'm^2/s', 0);
model.study('std1').feature('param').setIndex('pname', 'k0', 0);
model.study('std1').feature('param').setIndex('plistarr', '10^range(-1,-1,-3)', 0);
model.study('std1').feature('param').setIndex('punit', 'cm/s', 0);
model.study('std1').feature('frlin').set('plist', '10^range(log_freq_min,0.05,log_freq_max)');

model.sol.create('sol1');
model.sol('sol1').study('std1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'frlin');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').set('control', 'frlin');
model.sol('sol1').create('s1', 'Stationary');
model.sol('sol1').feature('s1').set('stol', 1.0E-4);
model.sol('sol1').feature('s1').create('p1', 'Parametric');
model.sol('sol1').feature('s1').feature.remove('pDef');
model.sol('sol1').feature('s1').feature('p1').set('pname', {'freq'});
model.sol('sol1').feature('s1').feature('p1').set('plistarr', {'10^range(log_freq_min,0.05,log_freq_max)'});
model.sol('sol1').feature('s1').feature('p1').set('punit', {'Hz'});
model.sol('sol1').feature('s1').feature('p1').set('pcontinuationmode', 'no');
model.sol('sol1').feature('s1').feature('p1').set('preusesol', 'no');
model.sol('sol1').feature('s1').feature('p1').set('pdistrib', 'off');
model.sol('sol1').feature('s1').feature('p1').set('plot', 'off');
model.sol('sol1').feature('s1').feature('p1').set('plotgroup', 'Default');
model.sol('sol1').feature('s1').feature('p1').set('probesel', 'all');
model.sol('sol1').feature('s1').feature('p1').set('probes', {});
model.sol('sol1').feature('s1').feature('p1').set('control', 'frlin');
model.sol('sol1').feature('s1').set('nonlin', 'linper');
model.sol('sol1').feature('s1').set('storelinpoint', true);
model.sol('sol1').feature('s1').set('linpsolnum', 'all');
model.sol('sol1').feature('s1').set('control', 'frlin');
model.sol('sol1').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('s1').feature('fc1').set('dtech', 'auto');
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
model.sol('sol1').feature('s1').feature.remove('fcDef');
model.sol('sol1').attach('std1');

model.batch.create('p1', 'Parametric');
model.batch('p1').study('std1');
model.batch('p1').create('so1', 'Solutionseq');
model.batch('p1').feature('so1').set('seq', 'sol1');
model.batch('p1').feature('so1').set('store', 'on');
model.batch('p1').feature('so1').set('clear', 'on');
model.batch('p1').feature('so1').set('psol', 'none');
model.batch('p1').set('pname', {'k0'});
model.batch('p1').set('plistarr', {'10^range(-1,-1,-3)'});
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

model.result.create('pg1', 'PlotGroup1D');
model.result('pg1').set('data', 'dset2');
model.result('pg1').create('nyq1', 'Nyquist');
model.result('pg1').feature('nyq1').set('unit', {''});
model.result('pg1').feature('nyq1').set('expr', {'conj(tcd.Zvsgrnd_es1) '});
model.result('pg1').feature('nyq1').set('descr', {''});
model.result('pg1').label('Impedance with Respect to Ground, Nyquist (tcd)');
model.result('pg1').feature('nyq1').setIndex('descr', 'Impedance with Respect to Ground', 0);
model.result('pg1').feature('nyq1').set('differential', 'off');
model.result('pg1').feature('nyq1').set('autodescr', 'off');
model.result('pg1').set('preserveaspect', 'on');
model.result('pg1').set('xlabelactive', true);
model.result('pg1').set('xlabel', 'real(Z) (\Omega m<sup>2</sup>)');
model.result('pg1').set('ylabelactive', true);
model.result('pg1').set('ylabel', '-imag(Z) (\Omega m<sup>2</sup>)');
model.result.create('pg2', 'PlotGroup1D');
model.result('pg2').set('data', 'dset2');
model.result('pg2').create('glob1', 'Global');
model.result('pg2').feature('glob1').set('unit', {''});
model.result('pg2').feature('glob1').set('expr', {'real(conj(tcd.Zvsgrnd_es1)) '});
model.result('pg2').feature('glob1').set('descr', {''});
model.result('pg2').label('Impedance with Respect to Ground, Real Part (tcd)');
model.result('pg2').feature('glob1').setIndex('descr', 'Impedance with Respect to Ground, Real Part', 0);
model.result('pg2').feature('glob1').set('differential', 'off');
model.result('pg2').feature('glob1').set('xdata', 'expr');
model.result('pg2').feature('glob1').set('xdataexpr', 'freq');
model.result('pg2').feature('glob1').set('autodescr', 'off');
model.result('pg2').feature('glob1').set('xdatasolnumtype', 'level1');
model.result('pg2').set('xlog', 'on');
model.result('pg2').set('ylabelactive', true);
model.result('pg2').set('ylabel', 'real(Z) (\Omega m<sup>2</sup>)');
model.result.create('pg3', 'PlotGroup1D');
model.result('pg3').set('data', 'dset2');
model.result('pg3').create('glob1', 'Global');
model.result('pg3').feature('glob1').set('unit', {''});
model.result('pg3').feature('glob1').set('expr', {'imag(conj(tcd.Zvsgrnd_es1)) '});
model.result('pg3').feature('glob1').set('descr', {''});
model.result('pg3').label('Impedance with Respect to Ground, Imaginary Part (tcd)');
model.result('pg3').feature('glob1').setIndex('descr', 'Impedance with Respect to Ground, Imaginary Part', 0);
model.result('pg3').feature('glob1').set('differential', 'off');
model.result('pg3').feature('glob1').set('xdata', 'expr');
model.result('pg3').feature('glob1').set('xdataexpr', 'freq');
model.result('pg3').feature('glob1').set('autodescr', 'off');
model.result('pg3').feature('glob1').set('xdatasolnumtype', 'level1');
model.result('pg3').set('xlog', 'on');
model.result('pg3').set('ylabelactive', true);
model.result('pg3').set('ylabel', '-imag(Z) (\Omega m<sup>2</sup>)');
model.result.create('pg4', 'PlotGroup1D');
model.result('pg4').set('data', 'dset2');
model.result('pg4').set('titletype', 'manual');
model.result('pg4').set('title', 'Concentrations, All Species');
model.result('pg4').label('Concentrations, All Species (tcd)');
model.result('pg4').create('lngr1', 'LineGraph');
model.result('pg4').feature('lngr1').set('xdata', 'expr');
model.result('pg4').feature('lngr1').set('xdataexpr', 'x');
model.result('pg4').feature('lngr1').selection.geom('geom1', 1);
model.result('pg4').feature('lngr1').selection.set([1]);
model.result('pg4').feature('lngr1').set('expr', {'cRed'});
model.result('pg4').feature('lngr1').label('Species Red');
model.result('pg4').feature('lngr1').set('legend', true);
model.result('pg4').feature('lngr1').set('autosolution', false);
model.result('pg4').feature('lngr1').set('autoexpr', false);
model.result('pg4').feature('lngr1').set('autodescr', false);
model.result('pg4').feature('lngr1').set('legendprefix', 'Red ');
model.result('pg4').create('lngr2', 'LineGraph');
model.result('pg4').feature('lngr2').set('xdata', 'expr');
model.result('pg4').feature('lngr2').set('xdataexpr', 'x');
model.result('pg4').feature('lngr2').selection.geom('geom1', 1);
model.result('pg4').feature('lngr2').selection.set([1]);
model.result('pg4').feature('lngr2').set('expr', {'cOx'});
model.result('pg4').feature('lngr2').label('Species Ox');
model.result('pg4').feature('lngr2').set('legend', true);
model.result('pg4').feature('lngr2').set('autosolution', false);
model.result('pg4').feature('lngr2').set('autoexpr', false);
model.result('pg4').feature('lngr2').set('autodescr', false);
model.result('pg4').feature('lngr2').set('legendprefix', 'Ox ');
model.result.create('pg5', 'PlotGroup1D');
model.result('pg5').set('data', 'dset2');
model.result('pg5').label('Concentration, Red (tcd)');
model.result('pg5').set('titletype', 'custom');
model.result('pg5').set('prefixintitle', 'Species Red:');
model.result('pg5').set('expressionintitle', false);
model.result('pg5').set('typeintitle', false);
model.result('pg5').create('lngr1', 'LineGraph');
model.result('pg5').feature('lngr1').set('xdata', 'expr');
model.result('pg5').feature('lngr1').set('xdataexpr', 'x');
model.result('pg5').feature('lngr1').selection.geom('geom1', 1);
model.result('pg5').feature('lngr1').selection.set([1]);
model.result('pg5').feature('lngr1').set('expr', {'cRed'});
model.result.create('pg6', 'PlotGroup1D');
model.result('pg6').set('data', 'dset2');
model.result('pg6').label('Concentration, Ox (tcd)');
model.result('pg6').set('titletype', 'custom');
model.result('pg6').set('prefixintitle', 'Species Ox:');
model.result('pg6').set('expressionintitle', false);
model.result('pg6').set('typeintitle', false);
model.result('pg6').create('lngr1', 'LineGraph');
model.result('pg6').feature('lngr1').set('xdata', 'expr');
model.result('pg6').feature('lngr1').set('xdataexpr', 'x');
model.result('pg6').feature('lngr1').selection.geom('geom1', 1);
model.result('pg6').feature('lngr1').selection.set([1]);
model.result('pg6').feature('lngr1').set('expr', {'cOx'});
model.result('pg1').run;
model.result('pg1').set('legendpos', 'lowerright');
model.result('pg1').run;
model.result('pg2').run;
model.result.duplicate('pg7', 'pg2');
model.result('pg7').run;
model.result('pg7').label('Impedance with Respect to Ground, Absolute Value');
model.result('pg7').run;
model.result('pg7').feature('glob1').setIndex('expr', 'abs(conj(tcd.Zvsgrnd_es1))', 0);
model.result('pg7').feature('glob1').setIndex('descr', 'Impedance with Respect to Ground, Absolute Value', 0);
model.result('pg7').run;
model.result('pg7').run;
model.result.duplicate('pg8', 'pg7');
model.result('pg8').run;
model.result('pg8').label('Impedance with Respect to Ground, Phase Angle');
model.result('pg8').run;
model.result('pg8').feature('glob1').setIndex('expr', 'arg(tcd.Zvsgrnd_es1)', 0);
model.result('pg8').feature('glob1').setIndex('descr', 'Impedance with Respect to Ground, Phase Angle', 0);
model.result('pg8').run;
model.result('pg1').run;

model.title('Electrochemical Impedance Spectroscopy');

model.description('Electrochemical impedance spectroscopy (EIS) is a common technique in which a small oscillating perturbation is applied to an electrochemical system to interrogate kinetic and transport properties. This example models EIS for a range of electrode reaction rates. Nyquist and Bode plots illustrate the transition between the reaction proceeding under kinetic or transport control.');

model.mesh.clearMeshes;

model.sol('sol1').clearSolutionData;
model.sol('sol2').clearSolutionData;
model.sol('sol3').clearSolutionData;
model.sol('sol4').clearSolutionData;
model.sol('sol5').clearSolutionData;

model.label('impedance_spectroscopy.mph');

model.modelNode.label('Components');

out = model;
