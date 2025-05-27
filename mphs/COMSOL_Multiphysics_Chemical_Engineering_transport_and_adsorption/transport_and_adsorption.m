function out = model
%
% transport_and_adsorption.m
%
% Model exported on May 26 2025, 21:26 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/COMSOL_Multiphysics/Chemical_Engineering');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 2);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.physics.create('tds', 'DilutedSpecies', 'geom1', {'c'});
model.physics.create('gb', 'GeneralFormBoundaryPDE', 'geom1', {'cs'});
model.physics('gb').prop('EquationForm').set('form', 'Automatic');

model.study.create('std1');
model.study('std1').create('time', 'Transient');
model.study('std1').feature('time').setSolveFor('/physics/tds', true);
model.study('std1').feature('time').setSolveFor('/physics/gb', true);

% To import content from file, use:
% model.param.loadFile('FILENAME');
model.param.set('c0', '1000[mol/m^3]', 'Initial concentration');
model.param.set('k_ads', '1e-6[m^3/(mol*s)]', 'Forward rate constant');
model.param.set('k_des', '1e-9[1/s]', 'Backward rate constant');
model.param.set('Gamma_s', '1000[mol/m^2]', 'Active site concentration');
model.param.set('Ds', '1e-11[m^2/s]', 'Surface diffusivity');
model.param.set('D', '1e-9[m^2/s]', 'Gas diffusivity');
model.param.set('v_max', '1[mm/s]', 'Maximum velocity');
model.param.set('delta', '0.1[mm]', 'Channel width');

model.geom('geom1').lengthUnit('mm');
model.geom('geom1').create('r1', 'Rectangle');
model.geom('geom1').feature('r1').set('size', [0.1 0.3]);
model.geom('geom1').feature('r1').set('pos', [0 -0.1]);
model.geom('geom1').runPre('fin');
model.geom('geom1').create('pt1', 'Point');
model.geom('geom1').feature('pt1').setIndex('p', 0.1, 0);
model.geom('geom1').runPre('fin');
model.geom('geom1').create('pt2', 'Point');
model.geom('geom1').feature('pt2').setIndex('p', 0.1, 0);
model.geom('geom1').feature('pt2').setIndex('p', 0.1, 1);
model.geom('geom1').runPre('fin');

model.variable.create('var1');
model.variable('var1').model('comp1');

model.geom('geom1').run;

model.variable('var1').selection.geom('geom1', 1);
model.variable('var1').selection.set([5]);
model.variable('var1').set('R', 'k_ads*c*(Gamma_s-cs)-k_des*cs');
model.variable('var1').descr('R', 'Surface reaction rate');
model.variable.create('var2');
model.variable('var2').model('comp1');
model.variable('var2').selection.geom('geom1', 2);
model.variable('var2').selection.set([1]);
model.variable('var2').set('v_lam', 'v_max*(1-((x-0.5*delta)/(0.5*delta))^2)');
model.variable('var2').descr('v_lam', 'Inlet velocity profile');

model.physics('tds').feature('cdm1').set('D_c', {'D' '0' '0' '0' 'D' '0' '0' '0' 'D'});
model.physics('tds').feature('cdm1').set('u', {'0' 'v_lam' '0'});
model.physics('tds').feature('init1').setIndex('initc', 'c0', 0);
model.physics('tds').create('conc1', 'Concentration', 1);
model.physics('tds').feature('conc1').selection.set([2]);
model.physics('tds').feature('conc1').setIndex('species', true, 0);
model.physics('tds').feature('conc1').setIndex('c0', 'c0', 0);
model.physics('tds').create('fl1', 'FluxBoundary', 1);
model.physics('tds').feature('fl1').selection.set([5]);
model.physics('tds').feature('fl1').setIndex('species', true, 0);
model.physics('tds').feature('fl1').setIndex('J0', '-R', 0);
model.physics('tds').create('out1', 'Outflow', 1);
model.physics('tds').feature('out1').selection.set([3]);
model.physics('tds').create('sym1', 'Symmetry', 1);
model.physics('tds').feature('sym1').selection.set([1 4 6]);
model.physics('gb').selection.set([5]);
model.physics('gb').prop('Units').set('CustomDependentVariableUnit', '1');
model.physics('gb').prop('Units').set('DependentVariableQuantity', 'none');
model.physics('gb').prop('Units').setIndex('CustomDependentVariableUnit', 'mol/m^2', 0, 0);
model.physics('gb').prop('Units').setIndex('CustomSourceTermUnit', 'mol/(m^2*s)', 0, 0);
model.physics('gb').feature('gfeq1').setIndex('Ga', {'-csTx*Ds' '-csTy'}, 0);
model.physics('gb').feature('gfeq1').setIndex('Ga', {'-csTx*Ds' '-csTy*Ds'}, 0);
model.physics('gb').feature('gfeq1').setIndex('f', 'R', 0);

model.mesh('mesh1').create('ftri1', 'FreeTri');
model.mesh('mesh1').feature('ftri1').create('size1', 'Size');
model.mesh('mesh1').feature('ftri1').feature('size1').selection.geom('geom1', 1);
model.mesh('mesh1').feature('ftri1').feature('size1').selection.set([5]);
model.mesh('mesh1').feature('ftri1').feature('size1').set('custom', true);
model.mesh('mesh1').feature('ftri1').feature('size1').set('hmaxactive', true);
model.mesh('mesh1').feature('ftri1').feature('size1').set('hmax', '1.5[um]');
model.mesh('mesh1').run;

model.study('std1').feature('time').set('tlist', 'range(0,0.05,2)');

model.sol.create('sol1');

model.mesh('mesh1').stat.selection.geom(2);
model.mesh('mesh1').stat.selection.set([1]);

model.sol('sol1').study('std1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'time');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').set('control', 'time');
model.sol('sol1').create('t1', 'Time');
model.sol('sol1').feature('t1').set('tlist', 'range(0,0.05,2)');
model.sol('sol1').feature('t1').set('plot', 'off');
model.sol('sol1').feature('t1').set('plotgroup', 'Default');
model.sol('sol1').feature('t1').set('plotfreq', 'tout');
model.sol('sol1').feature('t1').set('probesel', 'all');
model.sol('sol1').feature('t1').set('probes', {});
model.sol('sol1').feature('t1').set('probefreq', 'tsteps');
model.sol('sol1').feature('t1').set('rtol', 0.005);
model.sol('sol1').feature('t1').set('atolglobalvaluemethod', 'factor');
model.sol('sol1').feature('t1').set('reacf', true);
model.sol('sol1').feature('t1').set('storeudot', true);
model.sol('sol1').feature('t1').set('endtimeinterpolation', true);
model.sol('sol1').feature('t1').set('maxorder', 2);
model.sol('sol1').feature('t1').set('stabcntrl', true);
model.sol('sol1').feature('t1').set('control', 'time');
model.sol('sol1').feature('t1').feature('aDef').set('cachepattern', true);
model.sol('sol1').feature('t1').create('seDef', 'Segregated');
model.sol('sol1').feature('t1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('t1').feature('fc1').set('stabacc', 'aacc');
model.sol('sol1').feature('t1').feature('fc1').set('aaccdim', 5);
model.sol('sol1').feature('t1').feature('fc1').set('aaccdelay', 0);
model.sol('sol1').feature('t1').feature('fc1').set('aaccmix', 0.9);
model.sol('sol1').feature('t1').feature('fc1').set('maxiter', 8);
model.sol('sol1').feature('t1').feature('fc1').set('damp', 0.9);
model.sol('sol1').feature('t1').feature('fc1').set('jtech', 'once');
model.sol('sol1').feature('t1').create('d1', 'Direct');
model.sol('sol1').feature('t1').feature('d1').label('Direct (Merged)');
model.sol('sol1').feature('t1').create('i1', 'Iterative');
model.sol('sol1').feature('t1').feature('i1').set('linsolver', 'gmres');
model.sol('sol1').feature('t1').feature('i1').set('prefuntype', 'left');
model.sol('sol1').feature('t1').feature('i1').set('itrestart', 50);
model.sol('sol1').feature('t1').feature('i1').set('rhob', 400);
model.sol('sol1').feature('t1').feature('i1').set('maxlinit', 50);
model.sol('sol1').feature('t1').feature('i1').set('nlinnormuse', 'on');
model.sol('sol1').feature('t1').feature('i1').label('AMG, concentrations (tds)');
model.sol('sol1').feature('t1').feature('i1').create('mg1', 'Multigrid');
model.sol('sol1').feature('t1').feature('i1').feature('mg1').set('prefun', 'saamg');
model.sol('sol1').feature('t1').feature('i1').feature('mg1').set('mgcycle', 'v');
model.sol('sol1').feature('t1').feature('i1').feature('mg1').set('maxcoarsedof', 50000);
model.sol('sol1').feature('t1').feature('i1').feature('mg1').set('strconn', 0.01);
model.sol('sol1').feature('t1').feature('i1').feature('mg1').set('nullspace', 'constant');
model.sol('sol1').feature('t1').feature('i1').feature('mg1').set('usesmooth', false);
model.sol('sol1').feature('t1').feature('i1').feature('mg1').set('saamgcompwise', true);
model.sol('sol1').feature('t1').feature('i1').feature('mg1').set('loweramg', true);
model.sol('sol1').feature('t1').feature('i1').feature('mg1').set('compactaggregation', false);
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('pr').create('sl1', 'SORLine');
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('pr').feature('sl1').set('linesweeptype', 'ssor');
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('pr').feature('sl1').set('iter', 1);
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('pr').feature('sl1').set('linerelax', 0.7);
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('pr').feature('sl1').set('linealgorithm', 'mesh');
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('pr').feature('sl1').set('linemethod', 'coupled');
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('pr').feature('sl1').set('seconditer', 1);
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('pr').feature('sl1').set('relax', 0.5);
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('po').create('sl1', 'SORLine');
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('po').feature('sl1').set('linesweeptype', 'ssor');
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('po').feature('sl1').set('iter', 1);
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('po').feature('sl1').set('linerelax', 0.7);
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('po').feature('sl1').set('linealgorithm', 'mesh');
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('po').feature('sl1').set('linemethod', 'coupled');
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('po').feature('sl1').set('seconditer', 1);
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('po').feature('sl1').set('relax', 0.5);
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('cs').create('d1', 'Direct');
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('cs').feature('d1').set('linsolver', 'pardiso');
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('cs').feature('d1').set('pivotperturb', 1.0E-13);
model.sol('sol1').feature('t1').feature('fc1').set('linsolver', 'd1');
model.sol('sol1').feature('t1').feature('fc1').set('stabacc', 'aacc');
model.sol('sol1').feature('t1').feature('fc1').set('aaccdim', 5);
model.sol('sol1').feature('t1').feature('fc1').set('aaccdelay', 0);
model.sol('sol1').feature('t1').feature('fc1').set('aaccmix', 0.9);
model.sol('sol1').feature('t1').feature('fc1').set('maxiter', 8);
model.sol('sol1').feature('t1').feature('fc1').set('damp', 0.9);
model.sol('sol1').feature('t1').feature('fc1').set('jtech', 'once');
model.sol('sol1').feature('t1').feature.remove('fcDef');
model.sol('sol1').feature('t1').feature.remove('seDef');
model.sol('sol1').attach('std1');
model.sol('sol1').runAll;

model.result.create('pg1', 'PlotGroup2D');
model.result('pg1').set('data', 'dset1');
model.result('pg1').setIndex('looplevel', 41, 0);
model.result('pg1').label('Concentration (tds)');
model.result('pg1').set('titletype', 'custom');
model.result('pg1').set('prefixintitle', '');
model.result('pg1').set('expressionintitle', false);
model.result('pg1').set('typeintitle', true);
model.result('pg1').create('surf1', 'Surface');
model.result('pg1').feature('surf1').set('expr', {'c'});
model.result('pg1').create('str1', 'Streamline');
model.result('pg1').feature('str1').set('expr', {'tds.tflux_cx' 'tds.tflux_cy'});
model.result('pg1').feature('str1').set('posmethod', 'uniform');
model.result('pg1').feature('str1').set('recover', 'pprint');
model.result('pg1').feature('str1').set('pointtype', 'arrow');
model.result('pg1').feature('str1').set('arrowlength', 'logarithmic');
model.result('pg1').feature('str1').set('color', 'gray');
model.result.create('pg2', 'PlotGroup2D');
model.result('pg2').set('data', 'dset1');
model.result('pg2').setIndex('looplevel', 41, 0);
model.result('pg2').create('line1', 'Line');
model.result('pg2').label('General Form Boundary PDE');
model.result('pg2').feature('line1').set('expr', 'cs');
model.result('pg1').run;
model.result('pg1').label('Concentration Species in Reactor');
model.result('pg1').run;
model.result.create('pg3', 'PlotGroup1D');
model.result('pg3').run;
model.result('pg3').label('Concentration Reacting Species Along Active Surface');
model.result('pg3').setIndex('looplevelinput', 'manual', 0);
model.result('pg3').setIndex('looplevel', [41], 0);
model.result('pg3').create('lngr1', 'LineGraph');
model.result('pg3').feature('lngr1').set('markerpos', 'datapoints');
model.result('pg3').feature('lngr1').set('linewidth', 'preference');
model.result('pg3').feature('lngr1').selection.set([5]);
model.result('pg3').feature('lngr1').set('xdataexpr', 'y');
model.result('pg3').feature('lngr1').set('xdatadescr', 'y-coordinate');
model.result('pg3').run;
model.result('pg3').run;
model.result.duplicate('pg4', 'pg3');
model.result('pg4').run;
model.result('pg4').label('Concentration Adsorbed Species Along Active Surface');
model.result('pg4').setIndex('looplevel', [2 11 21 31 41], 0);
model.result('pg4').run;
model.result('pg4').feature('lngr1').set('expr', 'cs');
model.result('pg4').feature('lngr1').set('descr', 'Dependent variable cs');
model.result('pg4').run;
model.result('pg4').run;
model.result.duplicate('pg5', 'pg4');
model.result('pg5').run;
model.result('pg5').label('Surface Reaction Rate Along Active Surface');
model.result('pg5').run;
model.result('pg5').feature('lngr1').set('expr', 'R');
model.result('pg5').feature('lngr1').set('descr', 'Surface reaction rate');
model.result('pg5').run;
model.result('pg2').run;
model.result('pg2').label('Concentration Adsorbed Species at Active Surface');
model.result('pg2').run;
model.result('pg2').feature('line1').set('linetype', 'tube');
model.result('pg2').feature('line1').set('tuberadiusscaleactive', true);
model.result('pg2').feature('line1').set('tuberadiusscale', 0.005);
model.result('pg2').run;

model.title('Transport and Adsorption');

model.description('This example shows surface diffusion and surface reactions coupled to species transport to the reacting surface. In adsorption reactions it is necessary to model the surface concentrations of the active sites or surface complex as well as the bulk concentration in the gas phase. This device could be a catalyst, biochip, semiconductor component, or any process with surface-specific species.');

model.mesh.clearMeshes;

model.sol('sol1').clearSolutionData;

model.label('transport_and_adsorption.mph');

model.modelNode.label('Components');

out = model;
