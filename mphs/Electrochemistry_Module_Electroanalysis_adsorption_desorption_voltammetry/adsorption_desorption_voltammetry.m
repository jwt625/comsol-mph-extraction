function out = model
%
% adsorption_desorption_voltammetry.m
%
% Model exported on May 26 2025, 21:27 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/Electrochemistry_Module/Electroanalysis');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 1);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.physics.create('tcd', 'TertiaryElectroanalysis', 'geom1', {'c_A'});

model.study.create('std1');
model.study('std1').create('cyclv', 'CyclicVoltammetry');
model.study('std1').feature('cyclv').set('initialtime', '0');
model.study('std1').feature('cyclv').set('solnum', 'auto');
model.study('std1').feature('cyclv').set('notsolnum', 'auto');
model.study('std1').feature('cyclv').set('outputmap', {});
model.study('std1').feature('cyclv').setSolveFor('/physics/tcd', true);

% To import content from file, use:
% model.param.loadFile('FILENAME');
model.param.set('sigma', '10', 'Dimensionless scan rate');
model.param.set('k_a1_prime', '0.1', 'Dimensionless adsorption rate constant');
model.param.set('K_prime', '1e-5', 'Dimensionless adsorption-desorption rate constant ratio');
model.param.set('k_0_prime', '0.02', 'Dimensionless electron transfer rate constant');
model.param.set('beta', '1e-3', 'Dimensionless saturation parameter');
model.param.set('theta_A_init_prime', '0', 'Initial surface coverage');
model.param.set('k_d1_prime', 'k_a1_prime/K_prime', 'Dimensionless desorption rate constant');
model.param.set('c_A_bulk', '1e-2[M]', 'Bulk concentration');
model.param.set('r_d', '1e-3[cm]', 'Electrode radius');
model.param.set('D_A', '1e-5[cm^2/s]', 'Diffusion coefficient');
model.param.set('ka1', 'k_a1_prime*D_A/r_d', 'Adsorption rate constant');
model.param.set('kd1', 'k_d1_prime*c_A_bulk*D_A/r_d', 'Desorption rate constant');
model.param.set('k0', 'D_A*k_0_prime/r_d^2', 'Electrochemical rate constant');
model.param.set('Gamma', 'c_A_bulk*r_d/beta', 'Monolayer saturation coverage');
model.param.set('nu', 'sigma*R_const*T*D_A/F_const/r_d^2', 'Scan rate');
model.param.set('theta_A_init', 'theta_A_eq*theta_A_init_prime', 'Initial surface coverage');
model.param.set('E_0', '0[V]', 'Formal potential');
model.param.set('K', 'ka1/kd1', 'Adsorption-desorption rate constant ratio');
model.param.set('theta_A_eq', 'K*c_A_bulk/(1+K*c_A_bulk)', 'Surface coverage at equilibrium');
model.param.set('T', '298.15[K]', 'Temperature');
model.param.set('E_start', '0.5[V]', 'Start potential');
model.param.set('E_vertex', '-0.5[V]', 'Vertex potential');
model.param.set('L', '6*sqrt(D_A*2*abs(E_start-E_vertex)/nu)', 'Interval length');
model.param.set('A_electrode', 'pi*r_d^2', 'Electrode area');

model.geom('geom1').create('i1', 'Interval');
model.geom('geom1').feature('i1').setIndex('coord', 'L', 1);
model.geom('geom1').runPre('fin');
model.geom('geom1').run;

model.physics('tcd').prop('Ac').set('Ac', 'A_electrode');
model.physics('tcd').feature('ice1').set('D_c_A', {'D_A' '0' '0' '0' 'D_A' '0' '0' '0' 'D_A'});
model.physics('tcd').feature('init1').setIndex('initc', 'c_A_bulk', 0);
model.physics('tcd').create('es1', 'ElectrodeSurface', 0);
model.physics('tcd').feature('es1').selection.set([1]);
model.physics('tcd').feature('es1').set('Gamma', 'Gamma');
model.physics('tcd').feature('es1').setIndex('AdsorbingDesorbingSpecies', 'ads1', 0, 0);
model.physics('tcd').feature('es1').setIndex('Sigma', 1, 0, 0);
model.physics('tcd').feature('es1').setIndex('AdsorbingDesorbingSpecies', 'ads1', 0, 0);
model.physics('tcd').feature('es1').setIndex('Sigma', 1, 0, 0);
model.physics('tcd').feature('es1').setIndex('AdsorbingDesorbingSpecies', 'A_ads', 0, 0);
model.physics('tcd').feature('es1').setIndex('AdsorbingDesorbingSpecies', 'ads1', 1, 0);
model.physics('tcd').feature('es1').setIndex('Sigma', 1, 1, 0);
model.physics('tcd').feature('es1').setIndex('Sigma', 1, 1, 0);
model.physics('tcd').feature('es1').setIndex('AdsorbingDesorbingSpecies', 'ads1', 1, 0);
model.physics('tcd').feature('es1').setIndex('Sigma', 1, 1, 0);
model.physics('tcd').feature('es1').setIndex('AdsorbingDesorbingSpecies', 'B_ads', 1, 0);
model.physics('tcd').feature('es1').set('BoundaryCondition', 'CyclicVoltammetry');
model.physics('tcd').feature('es1').set('sweeprate', 'nu');
model.physics('tcd').feature('es1').set('Evertex1', 'E_start');
model.physics('tcd').feature('es1').set('Evertex2', 'E_vertex');
model.physics('tcd').feature('es1').feature('er1').set('minput_temperature_src', 'userdef');
model.physics('tcd').feature('es1').feature('er1').set('minput_temperature', 'T');
model.physics('tcd').feature('es1').feature('er1').setIndex('Viad', -1, 0, 0);
model.physics('tcd').feature('es1').feature('er1').setIndex('Viad', 1, 1, 0);
model.physics('tcd').feature('es1').feature('er1').set('Eeq_mat', 'userdef');
model.physics('tcd').feature('es1').feature('er1').set('Eeq', 'E_0');
model.physics('tcd').feature('es1').feature('er1').set('ElectrodeKinetics', 'ConcentrationDependentKinetics');
model.physics('tcd').feature('es1').feature('er1').set('i0', 'k0*F_const*Gamma');
model.physics('tcd').feature('es1').feature('er1').set('CR', 'tcd.theta_es1_B_ads');
model.physics('tcd').feature('es1').feature('er1').set('CO', 'tcd.theta_es1_A_ads');

model.variable.create('var1');
model.variable('var1').model('comp1');
model.variable('var1').set('r_ads', 'ka1*tcd.thetafree_es1*c_A-kd1*tcd.theta_es1_A_ads');
model.variable('var1').descr('r_ads', 'Adsorption rate');

model.physics('tcd').feature('es1').create('nfr1', 'NonFaradaicReactions', 0);
model.physics('tcd').feature('es1').feature('nfr1').setIndex('species', true, 0);
model.physics('tcd').feature('es1').feature('nfr1').setIndex('J0', '-r_ads', 0);
model.physics('tcd').feature('es1').feature('nfr1').setIndex('Rad', 'r_ads', 0, 0);
model.physics('tcd').feature('es1').create('ivads1', 'InitialValuesForAdsorbingDesorbingSpecies', 0);
model.physics('tcd').feature('es1').feature('ivads1').setIndex('theta0', 'theta_A_init', 0, 0);

model.mesh('mesh1').automatic(false);
model.mesh('mesh1').feature('size').set('custom', true);
model.mesh('mesh1').feature('size').set('hmax', 'L/10');
model.mesh('mesh1').feature('size').set('hgrad', 1.1);
model.mesh('mesh1').feature('size1').set('custom', true);
model.mesh('mesh1').feature('size1').set('hmaxactive', true);
model.mesh('mesh1').feature('size1').set('hmax', 'L/10000');
model.mesh('mesh1').run;

model.study('std1').create('param', 'Parametric');
model.study('std1').feature('param').setIndex('pname', 'sigma', 0);
model.study('std1').feature('param').setIndex('plistarr', '', 0);
model.study('std1').feature('param').setIndex('punit', '', 0);
model.study('std1').feature('param').setIndex('pname', 'sigma', 0);
model.study('std1').feature('param').setIndex('plistarr', '', 0);
model.study('std1').feature('param').setIndex('punit', '', 0);
model.study('std1').feature('param').setIndex('pname', 'K_prime', 0);
model.study('std1').feature('param').setIndex('plistarr', '1e5 1e-5 1e5', 0);
model.study('std1').feature('param').setIndex('pname', 'sigma', 1);
model.study('std1').feature('param').setIndex('plistarr', '', 1);
model.study('std1').feature('param').setIndex('punit', '', 1);
model.study('std1').feature('param').setIndex('pname', 'sigma', 1);
model.study('std1').feature('param').setIndex('plistarr', '', 1);
model.study('std1').feature('param').setIndex('punit', '', 1);
model.study('std1').feature('param').setIndex('pname', 'k_0_prime', 1);
model.study('std1').feature('param').setIndex('plistarr', '1e2 1e2 1e-2', 1);

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
model.sol('sol1').feature('t1').set('initialstepbdf', '1e-3[V]/abs(nu)');
model.sol('sol1').feature('t1').set('maxstepconstraintbdf', 'const');
model.sol('sol1').feature('t1').set('maxstepbdf', 'min(1e100,abs((E_start-E_vertex)/nu))');
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
model.batch('p1').set('pname', {'K_prime' 'k_0_prime'});
model.batch('p1').set('plistarr', {'1e5 1e-5 1e5' '1e2 1e2 1e-2'});
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
model.result('pg4').label('Concentration (tcd)');
model.result('pg4').set('titletype', 'custom');
model.result('pg4').set('prefixintitle', '');
model.result('pg4').set('expressionintitle', false);
model.result('pg4').set('typeintitle', false);
model.result('pg4').create('lngr1', 'LineGraph');
model.result('pg4').feature('lngr1').set('xdata', 'expr');
model.result('pg4').feature('lngr1').set('xdataexpr', 'x');
model.result('pg4').feature('lngr1').selection.geom('geom1', 1);
model.result('pg4').feature('lngr1').selection.set([1]);
model.result('pg4').feature('lngr1').set('expr', {'c_A'});
model.result('pg1').run;
model.result('pg1').run;
model.result('pg1').feature('glob1').set('legendmethod', 'evaluated');
model.result('pg1').feature('glob1').set('legendpattern', 'K''=eval(K_prime), k<sub>0</sub>''=eval(k_0_prime)');
model.result('pg1').run;
model.result('pg1').set('legendpos', 'upperleft');
model.result('pg1').run;
model.result.create('pg5', 'PlotGroup1D');
model.result('pg5').run;
model.result('pg5').label('Surface Coverages and Concentration');
model.result('pg5').set('data', 'dset2');
model.result('pg5').setIndex('looplevelinput', 'manual', 1);
model.result('pg5').setIndex('looplevel', [1], 1);
model.result('pg5').create('ptgr1', 'PointGraph');
model.result('pg5').feature('ptgr1').set('markerpos', 'datapoints');
model.result('pg5').feature('ptgr1').set('linewidth', 'preference');
model.result('pg5').feature('ptgr1').selection.set([1]);
model.result('pg5').feature('ptgr1').set('expr', 'tcd.theta_es1_A_ads');
model.result('pg5').feature('ptgr1').set('descr', 'Surface coverage of adsorbing-desorbing species, 1-component');
model.result('pg5').feature('ptgr1').set('legend', true);
model.result('pg5').feature('ptgr1').set('legendmethod', 'manual');
model.result('pg5').feature('ptgr1').setIndex('legends', 'A<sub>ads</sub>', 0);
model.result('pg5').run;
model.result('pg5').feature.duplicate('ptgr2', 'ptgr1');
model.result('pg5').run;
model.result('pg5').feature('ptgr2').set('expr', 'tcd.theta_es1_B_ads');
model.result('pg5').feature('ptgr2').set('descr', 'Surface coverage of adsorbing-desorbing species, 2-component');
model.result('pg5').feature('ptgr2').setIndex('legends', 'B<sub>ads</sub>', 0);
model.result('pg5').run;
model.result('pg5').feature.duplicate('ptgr3', 'ptgr2');
model.result('pg5').run;
model.result('pg5').feature('ptgr3').set('expr', 'c_A');
model.result('pg5').feature('ptgr3').set('descr', 'Concentration');
model.result('pg5').feature('ptgr3').setIndex('legends', 'A', 0);
model.result('pg5').run;
model.result('pg5').set('titletype', 'manual');
model.result('pg5').set('title', 'K''=eval(K_prime), k<sub>0</sub>''=eval(k_0_prime)');
model.result('pg5').set('ylabelactive', true);
model.result('pg5').set('ylabel', 'Surface Coverage (1)');
model.result('pg5').set('twoyaxes', true);
model.result('pg5').setIndex('plotonsecyaxis', true, 2, 1);
model.result('pg5').set('legendpos', 'uppermiddle');
model.result('pg5').run;
model.result('pg5').setIndex('looplevel', [2], 1);
model.result('pg5').run;
model.result('pg5').setIndex('looplevel', [3], 1);
model.result('pg5').run;

model.title('Adsorption-Desorption Voltammetry');

model.description(['For an electrochemical reaction to occur, the reacting species usually needs to adsorb to the electrode surface before undergoing reduction or oxidation, after which the resulting product species desorbs back into the electrolyte.' newline  newline 'If the rate of adsorption or desorption is slow in comparison to the electrochemical charge transfer step, the adsorption-desorption phenomena may have to be accounted for in a model.' newline  newline 'This example investigates the impact of various kinetic parameters for adsorption, desorption and electron transfer when performing cyclic voltammetry on a planar electrode.']);

model.mesh.clearMeshes;

model.sol('sol1').clearSolutionData;
model.sol('sol2').clearSolutionData;
model.sol('sol3').clearSolutionData;
model.sol('sol4').clearSolutionData;
model.sol('sol5').clearSolutionData;

model.label('adsorption_desorption_voltammetry.mph');

model.modelNode.label('Components');

out = model;
