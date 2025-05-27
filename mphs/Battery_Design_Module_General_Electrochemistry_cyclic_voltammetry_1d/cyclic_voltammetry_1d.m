function out = model
%
% cyclic_voltammetry_1d.m
%
% Model exported on May 26 2025, 21:26 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/Battery_Design_Module/General_Electrochemistry');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 1);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.physics.create('tcd', 'TertiaryElectroanalysis', 'geom1', {'cA' 'cB'});

model.study.create('std1');
model.study('std1').create('cyclv', 'CyclicVoltammetry');
model.study('std1').feature('cyclv').set('initialtime', '0');
model.study('std1').feature('cyclv').set('solnum', 'auto');
model.study('std1').feature('cyclv').set('notsolnum', 'auto');
model.study('std1').feature('cyclv').set('outputmap', {});
model.study('std1').feature('cyclv').setSolveFor('/physics/tcd', true);

% To import content from file, use:
% model.param.loadFile('FILENAME');
model.param.set('v', '1[V/s]', 'Voltammetric scan rate');
model.param.set('c_bulk', '1[mmol/L]', 'Reactant bulk concentration');
model.param.set('DA', '1e-9[m^2/s]', 'Reactant diffusion coefficient');
model.param.set('DB', '1e-9[m^2/s]', 'Product diffusion coefficient');
model.param.set('K0', '1e10', 'Reaction rate (dimensionless)');
model.param.set('re', '10[mm]', 'Electrode radius');
model.param.set('i0ref', '9.6485e10[A/m^2]', 'Reference exchange current density');
model.param.set('Cdl', '0.2[F/m^2]', 'Double layer capacitance');
model.param.set('T', '298.15[K]', 'Temperature');
model.param.set('E_vertex1', '-0.4[V]', 'Start potential');
model.param.set('E_vertex2', '0.4[V]', 'Switching potential');
model.param.set('L', '6*sqrt(DA*2*abs(E_vertex1-E_vertex2)/v)', 'Outer bound on diffusion layer');
model.param.set('cB0', 'c_bulk/(1+exp(-E_vertex1*F_const/(R_const*T)))', 'Initial product concentration at electrode');

model.geom('geom1').create('i1', 'Interval');
model.geom('geom1').feature('i1').setIndex('coord', 'L', 1);
model.geom('geom1').run('fin');

model.physics('tcd').feature('ice1').set('D_cA', {'DA' '0' '0' '0' 'DA' '0' '0' '0' 'DA'});
model.physics('tcd').feature('ice1').set('D_cB', {'DB' '0' '0' '0' 'DB' '0' '0' '0' 'DB'});
model.physics('tcd').create('conc1', 'Concentration', 0);
model.physics('tcd').feature('conc1').selection.set([2]);
model.physics('tcd').feature('conc1').setIndex('species', true, 0);
model.physics('tcd').feature('conc1').setIndex('c0', 'c_bulk', 0);
model.physics('tcd').feature('conc1').setIndex('species', true, 1);
model.physics('tcd').create('es1', 'ElectrodeSurface', 0);
model.physics('tcd').feature('es1').selection.set([1]);
model.physics('tcd').feature('es1').set('BoundaryCondition', 'CyclicVoltammetry');
model.physics('tcd').feature('es1').set('sweeprate', 'v');
model.physics('tcd').feature('es1').set('Evertex1', 'E_vertex1');
model.physics('tcd').feature('es1').set('Evertex2', 'E_vertex2');
model.physics('tcd').feature('es1').feature('er1').setIndex('Vi0', 1, 0);
model.physics('tcd').feature('es1').feature('er1').setIndex('Vi0', -1, 1);
model.physics('tcd').feature('es1').feature('er1').set('i0_ref', 'i0ref');
model.physics('tcd').feature('es1').create('dlc1', 'DoubleLayerCapacitance', 0);
model.physics('tcd').feature('es1').feature('dlc1').set('Cdl', 'Cdl');
model.physics('tcd').feature('init1').setIndex('initc', 'c_bulk-cB0*(1-x/L)', 0);
model.physics('tcd').feature('init1').setIndex('initc', 'cB0*(1-x/L)', 1);

model.common('cminpt').set('modified', {'temperature' 'T'});

model.study('std1').create('param', 'Parametric');
model.study('std1').feature('param').setIndex('pname', 'v', 0);
model.study('std1').feature('param').setIndex('plistarr', '', 0);
model.study('std1').feature('param').setIndex('punit', 'V/s', 0);
model.study('std1').feature('param').setIndex('pname', 'v', 0);
model.study('std1').feature('param').setIndex('plistarr', '', 0);
model.study('std1').feature('param').setIndex('punit', 'V/s', 0);
model.study('std1').feature('param').setIndex('plistarr', '10^range(-3,1,0)', 0);

model.sol.create('sol1');
model.sol('sol1').study('std1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'cyclv');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').set('control', 'cyclv');
model.sol('sol1').create('t1', 'Time');
model.sol('sol1').feature('t1').set('tlist', '0 1e4');
model.sol('sol1').feature('t1').set('plot', 'off');
model.sol('sol1').feature('t1').set('plotgroup', 'Default');
model.sol('sol1').feature('t1').set('plotfreq', 'tout');
model.sol('sol1').feature('t1').set('probesel', 'all');
model.sol('sol1').feature('t1').set('probes', {});
model.sol('sol1').feature('t1').set('probefreq', 'tsteps');
model.sol('sol1').feature('t1').set('tout', 'tsteps');
model.sol('sol1').feature('t1').set('rtol', 0.001);
model.sol('sol1').feature('t1').set('atolglobalvaluemethod', 'factor');
model.sol('sol1').feature('t1').create('st1', 'StopCondition');
model.sol('sol1').feature('t1').feature('st1').set('stopcondarr', {'comp1.tcd.stopcond'});
model.sol('sol1').feature('t1').feature('st1').set('stopcondterminateon', {'true'});
model.sol('sol1').feature('t1').feature('st1').set('stopcondActive', {'on'});
model.sol('sol1').feature('t1').feature('st1').set('stopconddesc', {'tcd (Cyclic voltammetry)'});
model.sol('sol1').feature('t1').feature('st1').set('storestopcondsol', 'no');
model.sol('sol1').feature('t1').feature('st1').set('stopcondwarn', 'off');
model.sol('sol1').feature('t1').set('eventout', true);
model.sol('sol1').feature('t1').set('reacf', true);
model.sol('sol1').feature('t1').set('storeudot', true);
model.sol('sol1').feature('t1').set('endtimeinterpolation', true);
model.sol('sol1').feature('t1').set('maxorder', 2);
model.sol('sol1').feature('t1').set('initialstepbdfactive', true);
model.sol('sol1').feature('t1').set('initialstepbdf', '1e-3[V]/abs(v)');
model.sol('sol1').feature('t1').set('maxstepconstraintbdf', 'const');
model.sol('sol1').feature('t1').set('maxstepbdf', 'min(1e100,abs((E_vertex1-E_vertex2)/v))');
model.sol('sol1').feature('t1').set('bwinitstepfrac', '1.0E-5');
model.sol('sol1').feature('t1').set('control', 'cyclv');
model.sol('sol1').feature('t1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('t1').feature('fc1').set('dtech', 'const');
model.sol('sol1').feature('t1').feature('fc1').set('jtech', 'once');
model.sol('sol1').feature('t1').feature('fc1').set('damp', 1);
model.sol('sol1').feature('t1').feature('fc1').set('stabacc', 'aacc');
model.sol('sol1').feature('t1').feature('fc1').set('aaccdim', 5);
model.sol('sol1').feature('t1').feature('fc1').set('aaccmix', 0.9);
model.sol('sol1').feature('t1').feature('fc1').set('aaccdelay', 1);
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
model.sol('sol1').feature('t1').feature('i1').feature('mg1').set('saamgcompwise', true);
model.sol('sol1').feature('t1').feature('i1').feature('mg1').set('compactaggregation', true);
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('pr').create('sc1', 'SCGS');
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('pr').feature('sc1').set('linesweeptype', 'ssor');
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('pr').feature('sc1').set('iter', 1);
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('pr').feature('sc1').set('scgsmethod', 'lines');
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('po').create('sc1', 'SCGS');
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('po').feature('sc1').set('linesweeptype', 'ssor');
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('po').feature('sc1').set('iter', 1);
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('po').feature('sc1').set('scgsmethod', 'lines');
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('cs').create('d1', 'Direct');
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('cs').feature('d1').set('linsolver', 'pardiso');
model.sol('sol1').feature('t1').create('i2', 'Iterative');
model.sol('sol1').feature('t1').feature('i2').set('maxlinit', 1000);
model.sol('sol1').feature('t1').feature('i2').set('nlinnormuse', 'on');
model.sol('sol1').feature('t1').feature('i2').label('Geometric Multigrid (tcd)');
model.sol('sol1').feature('t1').feature('i2').create('mg1', 'Multigrid');
model.sol('sol1').feature('t1').feature('i2').feature('mg1').feature('pr').create('sc1', 'SCGS');
model.sol('sol1').feature('t1').feature('i2').feature('mg1').feature('pr').feature('sc1').set('linesweeptype', 'ssor');
model.sol('sol1').feature('t1').feature('i2').feature('mg1').feature('pr').feature('sc1').set('iter', 1);
model.sol('sol1').feature('t1').feature('i2').feature('mg1').feature('pr').feature('sc1').set('scgsmethod', 'lines');
model.sol('sol1').feature('t1').feature('i2').feature('mg1').feature('po').create('sc1', 'SCGS');
model.sol('sol1').feature('t1').feature('i2').feature('mg1').feature('po').feature('sc1').set('linesweeptype', 'ssor');
model.sol('sol1').feature('t1').feature('i2').feature('mg1').feature('po').feature('sc1').set('iter', 1);
model.sol('sol1').feature('t1').feature('i2').feature('mg1').feature('po').feature('sc1').set('scgsmethod', 'lines');
model.sol('sol1').feature('t1').feature('i2').feature('mg1').feature('cs').create('d1', 'Direct');
model.sol('sol1').feature('t1').feature('i2').feature('mg1').feature('cs').feature('d1').set('linsolver', 'pardiso');
model.sol('sol1').feature('t1').feature('fc1').set('linsolver', 'd1');
model.sol('sol1').feature('t1').feature('fc1').set('dtech', 'const');
model.sol('sol1').feature('t1').feature('fc1').set('jtech', 'once');
model.sol('sol1').feature('t1').feature('fc1').set('damp', 1);
model.sol('sol1').feature('t1').feature('fc1').set('stabacc', 'aacc');
model.sol('sol1').feature('t1').feature('fc1').set('aaccdim', 5);
model.sol('sol1').feature('t1').feature('fc1').set('aaccmix', 0.9);
model.sol('sol1').feature('t1').feature('fc1').set('aaccdelay', 1);
model.sol('sol1').feature('t1').feature.remove('fcDef');
model.sol('sol1').attach('std1');

model.batch.create('p1', 'Parametric');
model.batch('p1').study('std1');
model.batch('p1').create('so1', 'Solutionseq');
model.batch('p1').feature('so1').set('seq', 'sol1');
model.batch('p1').feature('so1').set('store', 'on');
model.batch('p1').feature('so1').set('clear', 'on');
model.batch('p1').feature('so1').set('psol', 'none');
model.batch('p1').set('pname', {'v'});
model.batch('p1').set('plistarr', {'10^range(-3,1,0)'});
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
model.result('pg1').create('glob1', 'Global');
model.result('pg1').feature('glob1').set('unit', {''});
model.result('pg1').feature('glob1').set('expr', {'tcd.Itot_es1 '});
model.result('pg1').feature('glob1').set('descr', {''});
model.result('pg1').label('Cyclic Voltammograms (tcd)');
model.result('pg1').feature('glob1').set('titletype', 'none');
model.result('pg1').feature('glob1').set('xdata', 'expr');
model.result('pg1').feature('glob1').set('xdataexpr', 'root.comp1.tcd.phis_es1 ');
model.result('pg1').feature('glob1').set('xdatadescr', 'Electric Potential');
model.result('pg1').feature('glob1').setIndex('descr', 'Total Current', 0);
model.result('pg1').feature('glob1').set('xdatasolnumtype', 'level1');
model.result.create('pg2', 'PlotGroup1D');
model.result('pg2').set('data', 'dset2');
model.result('pg2').create('glob1', 'Global');
model.result('pg2').feature('glob1').set('unit', {''});
model.result('pg2').feature('glob1').set('expr', {'tcd.phis_es1 '});
model.result('pg2').feature('glob1').set('descr', {''});
model.result('pg2').label('Electrode Potential (tcd)');
model.result('pg2').feature('glob1').setIndex('descr', 'Electric Potential', 0);
model.result('pg2').feature('glob1').set('xdatasolnumtype', 'level1');
model.result.create('pg3', 'PlotGroup1D');
model.result('pg3').set('data', 'dset2');
model.result('pg3').create('glob1', 'Global');
model.result('pg3').feature('glob1').set('unit', {''});
model.result('pg3').feature('glob1').set('expr', {'tcd.itotavg_es1 '});
model.result('pg3').feature('glob1').set('descr', {''});
model.result('pg3').label('Average Current Density (tcd)');
model.result('pg3').feature('glob1').setIndex('descr', 'Current Density', 0);
model.result('pg3').feature('glob1').set('xdatasolnumtype', 'level1');
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
model.result('pg4').feature('lngr1').set('expr', {'cA'});
model.result('pg4').feature('lngr1').label('Species A');
model.result('pg4').feature('lngr1').set('legend', true);
model.result('pg4').feature('lngr1').set('autosolution', false);
model.result('pg4').feature('lngr1').set('autoexpr', false);
model.result('pg4').feature('lngr1').set('autodescr', false);
model.result('pg4').feature('lngr1').set('legendprefix', 'A ');
model.result('pg4').create('lngr2', 'LineGraph');
model.result('pg4').feature('lngr2').set('xdata', 'expr');
model.result('pg4').feature('lngr2').set('xdataexpr', 'x');
model.result('pg4').feature('lngr2').selection.geom('geom1', 1);
model.result('pg4').feature('lngr2').selection.set([1]);
model.result('pg4').feature('lngr2').set('expr', {'cB'});
model.result('pg4').feature('lngr2').label('Species B');
model.result('pg4').feature('lngr2').set('legend', true);
model.result('pg4').feature('lngr2').set('autosolution', false);
model.result('pg4').feature('lngr2').set('autoexpr', false);
model.result('pg4').feature('lngr2').set('autodescr', false);
model.result('pg4').feature('lngr2').set('legendprefix', 'B ');
model.result.create('pg5', 'PlotGroup1D');
model.result('pg5').set('data', 'dset2');
model.result('pg5').label('Concentration, A (tcd)');
model.result('pg5').set('titletype', 'custom');
model.result('pg5').set('prefixintitle', 'Species A:');
model.result('pg5').set('expressionintitle', false);
model.result('pg5').set('typeintitle', false);
model.result('pg5').create('lngr1', 'LineGraph');
model.result('pg5').feature('lngr1').set('xdata', 'expr');
model.result('pg5').feature('lngr1').set('xdataexpr', 'x');
model.result('pg5').feature('lngr1').selection.geom('geom1', 1);
model.result('pg5').feature('lngr1').selection.set([1]);
model.result('pg5').feature('lngr1').set('expr', {'cA'});
model.result.create('pg6', 'PlotGroup1D');
model.result('pg6').set('data', 'dset2');
model.result('pg6').label('Concentration, B (tcd)');
model.result('pg6').set('titletype', 'custom');
model.result('pg6').set('prefixintitle', 'Species B:');
model.result('pg6').set('expressionintitle', false);
model.result('pg6').set('typeintitle', false);
model.result('pg6').create('lngr1', 'LineGraph');
model.result('pg6').feature('lngr1').set('xdata', 'expr');
model.result('pg6').feature('lngr1').set('xdataexpr', 'x');
model.result('pg6').feature('lngr1').selection.geom('geom1', 1);
model.result('pg6').feature('lngr1').selection.set([1]);
model.result('pg6').feature('lngr1').set('expr', {'cB'});
model.result('pg1').run;
model.result('pg1').set('legendpos', 'upperleft');
model.result('pg1').run;
model.result('pg1').feature('glob1').set('autodescr', false);
model.result('pg1').run;
model.result('pg2').run;
model.result('pg2').setIndex('looplevelinput', 'first', 1);
model.result('pg2').set('titletype', 'none');
model.result('pg2').run;
model.result('pg2').feature('glob1').set('autodescr', false);
model.result('pg2').run;

model.title('Cyclic Voltammetry at a Macroelectrode in 1D');

model.description('The example models cyclic voltammetry at an electrode of mm dimensions. In this common analytical electrochemistry technique, the potential at a working electrode is swept up and down and the current is recorded. The current-voltage waveform (the voltammogram) gives information about the reactivity and mass transport properties of the analyte.');

model.mesh.clearMeshes;

model.sol('sol1').clearSolutionData;
model.sol('sol2').clearSolutionData;
model.sol('sol3').clearSolutionData;
model.sol('sol4').clearSolutionData;
model.sol('sol5').clearSolutionData;
model.sol('sol6').clearSolutionData;

model.label('cyclic_voltammetry_1d.mph');

model.modelNode.label('Components');

out = model;
