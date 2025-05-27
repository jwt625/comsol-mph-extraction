function out = model
%
% microdisk_voltammetry.m
%
% Model exported on May 26 2025, 21:28 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/Electrochemistry_Module/Electroanalysis');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 2);
model.geom('geom1').model('comp1');
model.geom('geom1').axisymmetric(true);

model.mesh.create('mesh1', 'geom1');

model.physics.create('tcd', 'TertiaryElectroanalysis', 'geom1', {'cRed' 'cOx'});

model.study.create('std1');
model.study('std1').create('stat', 'Stationary');
model.study('std1').feature('stat').setSolveFor('/physics/tcd', true);

% To import content from file, use:
% model.param.loadFile('FILENAME');
model.param.set('E_appl', '0[V]', 'Applied potential');
model.param.set('Ef', '0[V]', 'Formal potential');
model.param.set('c_bulk', '1[mmol/L]', 'Reactant concentration');
model.param.set('re', '10[um]', 'Electrode radius');
model.param.set('r_max', '25*re', 'Size of simulation space');
model.param.set('D1', '1e-9[m^2/s]', 'Reactant diffusion coefficient');
model.param.set('D2', '1e-9[m^2/s]', 'Product diffusion coefficient');
model.param.set('i0ref', '1000[mol/(m^2*s)]*F_const', 'Reference exchange current density');
model.param.set('E_start', '-0.4[V]', 'Start potential');
model.param.set('E_vertex', '0.4[V]', 'Vertex potential');
model.param.set('E_step', '10[mV]', 'Potential step (output)');

model.geom('geom1').create('c1', 'Circle');
model.geom('geom1').feature('c1').set('r', 'r_max');
model.geom('geom1').feature('c1').set('angle', 90);
model.geom('geom1').run('c1');
model.geom('geom1').create('pt1', 'Point');
model.geom('geom1').feature('pt1').setIndex('p', 're', 0);
model.geom('geom1').feature.duplicate('c2', 'c1');
model.geom('geom1').feature('c2').set('r', 'r_max*1.2');
model.geom('geom1').run('fin');

model.coordSystem.create('ie1', 'geom1', 'InfiniteElement');
model.coordSystem('ie1').selection.set([2]);

model.physics('tcd').feature('ice1').set('D_cRed', {'D1' '0' '0' '0' 'D1' '0' '0' '0' 'D1'});
model.physics('tcd').feature('ice1').set('D_cOx', {'D2' '0' '0' '0' 'D2' '0' '0' '0' 'D2'});
model.physics('tcd').create('es1', 'ElectrodeSurface', 1);
model.physics('tcd').feature('es1').set('BoundaryCondition', 'ElectrodePotential');
model.physics('tcd').feature('es1').set('Evsref0', 'E_appl');
model.physics('tcd').feature('es1').selection.set([2]);
model.physics('tcd').feature('es1').feature('er1').setIndex('Vi0', 1, 0);
model.physics('tcd').feature('es1').feature('er1').setIndex('Vi0', -1, 1);
model.physics('tcd').feature('es1').feature('er1').set('Eeq_ref', 'Ef');
model.physics('tcd').feature('es1').feature('er1').set('i0_ref', 'i0ref');
model.physics('tcd').create('conc1', 'Concentration', 1);
model.physics('tcd').feature('conc1').selection.set([7]);
model.physics('tcd').feature('conc1').setIndex('species', true, 0);
model.physics('tcd').feature('conc1').setIndex('c0', 'c_bulk', 0);
model.physics('tcd').feature('conc1').setIndex('species', true, 1);
model.physics('tcd').feature('init1').setIndex('initc', 'c_bulk', 0);

model.mesh('mesh1').automatic(false);
model.mesh('mesh1').feature('size').set('hauto', 3);
model.mesh('mesh1').feature('size').set('hgrad', 1.1);
model.mesh('mesh1').feature('ftri1').selection.geom('geom1', 2);
model.mesh('mesh1').feature('ftri1').selection.set([1]);
model.mesh('mesh1').feature('ftri1').create('size1', 'Size');
model.mesh('mesh1').feature('ftri1').feature('size1').selection.geom('geom1', 0);
model.mesh('mesh1').feature('ftri1').feature('size1').selection.set([4]);
model.mesh('mesh1').feature('ftri1').feature('size1').set('custom', true);
model.mesh('mesh1').feature('ftri1').feature('size1').set('hmaxactive', true);
model.mesh('mesh1').feature('ftri1').feature('size1').set('hmax', 're/100');
model.mesh('mesh1').create('map1', 'Map');
model.mesh('mesh1').feature('map1').selection.geom('geom1', 2);
model.mesh('mesh1').feature('map1').selection.set([2]);
model.mesh('mesh1').run;

model.study('std1').create('param', 'Parametric');
model.study('std1').feature('param').setIndex('pname', 'E_appl', 0);
model.study('std1').feature('param').setIndex('plistarr', '', 0);
model.study('std1').feature('param').setIndex('punit', 'V', 0);
model.study('std1').feature('param').setIndex('pname', 'E_appl', 0);
model.study('std1').feature('param').setIndex('plistarr', '', 0);
model.study('std1').feature('param').setIndex('punit', 'V', 0);
model.study('std1').feature('param').setIndex('plistarr', 'range(E_start,E_step,E_vertex)', 0);

model.sol.create('sol1');
model.sol('sol1').study('std1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'stat');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').set('control', 'stat');
model.sol('sol1').create('s1', 'Stationary');
model.sol('sol1').feature('s1').set('stol', 1.0E-4);
model.sol('sol1').feature('s1').create('p1', 'Parametric');
model.sol('sol1').feature('s1').feature('p1').set('pname', {'E_appl'});
model.sol('sol1').feature('s1').feature('p1').set('plistarr', {'range(E_start,E_step,E_vertex)'});
model.sol('sol1').feature('s1').feature('p1').set('punit', {'V'});
model.sol('sol1').feature('s1').feature('p1').set('sweeptype', 'sparse');
model.sol('sol1').feature('s1').feature('p1').set('preusesol', 'no');
model.sol('sol1').feature('s1').feature('p1').set('pcontinuationmode', 'no');
model.sol('sol1').feature('s1').feature('p1').set('porder', 'constant');
model.sol('sol1').feature('s1').feature('p1').set('plot', 'off');
model.sol('sol1').feature('s1').feature('p1').set('plotgroup', 'Default');
model.sol('sol1').feature('s1').feature('p1').set('probesel', 'all');
model.sol('sol1').feature('s1').feature('p1').set('probes', {});
model.sol('sol1').feature('s1').feature('p1').set('control', 'param');
model.sol('sol1').feature('s1').set('control', 'stat');
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
model.sol('sol1').attach('std1');
model.sol('sol1').runAll;

model.result.create('pg1', 'PlotGroup2D');
model.result('pg1').set('data', 'dset1');
model.result('pg1').setIndex('looplevel', 81, 0);
model.result('pg1').label('Concentration, Red (tcd)');
model.result('pg1').set('titletype', 'custom');
model.result('pg1').set('prefixintitle', 'Species Red:');
model.result('pg1').set('expressionintitle', false);
model.result('pg1').set('typeintitle', true);
model.result('pg1').create('surf1', 'Surface');
model.result('pg1').feature('surf1').set('expr', {'cRed'});
model.result('pg1').create('str1', 'Streamline');
model.result('pg1').feature('str1').set('expr', {'tcd.tflux_cRedr' 'tcd.tflux_cRedz'});
model.result('pg1').feature('str1').set('posmethod', 'uniform');
model.result('pg1').feature('str1').set('recover', 'pprint');
model.result('pg1').feature('str1').set('pointtype', 'arrow');
model.result('pg1').feature('str1').set('arrowlength', 'logarithmic');
model.result('pg1').feature('str1').set('color', 'gray');
model.result.dataset.create('rev1', 'Revolve2D');
model.result.dataset('rev1').set('data', 'dset1');
model.result.dataset('rev1').set('revangle', 225);
model.result.dataset('rev1').set('startangle', -90);
model.result.dataset('rev1').set('hasspacevars', false);
model.result.create('pg2', 'PlotGroup3D');
model.result('pg2').set('data', 'rev1');
model.result('pg2').setIndex('looplevel', 81, 0);
model.result('pg2').label('Concentration, Red, 3D (tcd)');
model.result('pg2').create('surf1', 'Surface');
model.result('pg2').feature('surf1').set('expr', {'cRed'});
model.result('pg2').set('titletype', 'custom');
model.result('pg2').set('typeintitle', false);
model.result('pg2').set('prefixintitle', 'Species Red:');
model.result('pg2').set('expressionintitle', false);
model.result.create('pg3', 'PlotGroup2D');
model.result('pg3').set('data', 'dset1');
model.result('pg3').setIndex('looplevel', 81, 0);
model.result('pg3').label('Concentration, Ox (tcd)');
model.result('pg3').set('titletype', 'custom');
model.result('pg3').set('prefixintitle', 'Species Ox:');
model.result('pg3').set('expressionintitle', false);
model.result('pg3').set('typeintitle', true);
model.result('pg3').create('surf1', 'Surface');
model.result('pg3').feature('surf1').set('expr', {'cOx'});
model.result('pg3').create('str1', 'Streamline');
model.result('pg3').feature('str1').set('expr', {'tcd.tflux_cOxr' 'tcd.tflux_cOxz'});
model.result('pg3').feature('str1').set('posmethod', 'uniform');
model.result('pg3').feature('str1').set('recover', 'pprint');
model.result('pg3').feature('str1').set('pointtype', 'arrow');
model.result('pg3').feature('str1').set('arrowlength', 'logarithmic');
model.result('pg3').feature('str1').set('color', 'gray');
model.result.create('pg4', 'PlotGroup3D');
model.result('pg4').set('data', 'rev1');
model.result('pg4').setIndex('looplevel', 81, 0);
model.result('pg4').label('Concentration, Ox, 3D (tcd)');
model.result('pg4').create('surf1', 'Surface');
model.result('pg4').feature('surf1').set('expr', {'cOx'});
model.result('pg4').set('titletype', 'custom');
model.result('pg4').set('typeintitle', false);
model.result('pg4').set('prefixintitle', 'Species Ox:');
model.result('pg4').set('expressionintitle', false);
model.result('pg1').run;

model.view('view1').axis.set('xmin', '-1e-6');
model.view('view1').axis.set('xmax', '10e-5');
model.view('view1').axis.set('ymin', '-0.5e-6');
model.view('view1').axis.set('ymax', '10e-5');

model.result('pg1').run;
model.result('pg1').set('xlabelactive', true);
model.result('pg1').set('xlabel', 'r');
model.result('pg1').set('ylabelactive', true);
model.result('pg1').set('ylabel', 'z');
model.result('pg1').set('showlegendsunit', true);
model.result('pg1').run;
model.result('pg1').feature('surf1').active(false);
model.result('pg1').run;
model.result('pg1').create('con1', 'Contour');
model.result('pg1').feature('con1').set('expr', 'cRed');
model.result('pg1').feature('con1').set('contourtype', 'tubes');
model.result('pg1').feature('con1').set('tuberadiusscaleactive', true);
model.result('pg1').feature('con1').set('tuberadiusscale', 1.2E-7);
model.result('pg1').feature('con1').set('colortable', 'RainbowLight');
model.result('pg1').run;
model.result('pg1').feature('str1').set('posmethod', 'selection');
model.result('pg1').feature('str1').set('selnumber', 5);
model.result('pg1').feature('str1').selection.set([2]);
model.result('pg1').feature('str1').set('arrowlength', 'normalized');
model.result('pg1').feature('str1').set('arrowcountactive', true);
model.result('pg1').feature('str1').set('arrowcount', 100);
model.result('pg1').run;
model.result('pg1').create('line1', 'Line');
model.result('pg1').feature('line1').set('expr', '1');
model.result('pg1').feature('line1').set('titletype', 'none');
model.result('pg1').feature('line1').set('linetype', 'tube');
model.result('pg1').feature('line1').set('tuberadiusscaleactive', true);
model.result('pg1').feature('line1').set('tuberadiusscale', '0.4E-6');
model.result('pg1').feature('line1').set('coloring', 'uniform');
model.result('pg1').feature('line1').set('color', 'gray');
model.result('pg1').feature('line1').create('sel1', 'Selection');
model.result('pg1').feature('line1').feature('sel1').selection.set([2]);
model.result('pg1').run;
model.result('pg1').create('ann1', 'Annotation');
model.result('pg1').feature('ann1').set('text', 'Electrode surface');
model.result('pg1').feature('ann1').set('posyexpr', '-1.5e-6');
model.result('pg1').feature('ann1').set('showpoint', false);
model.result('pg1').run;
model.result('pg2').run;
model.result.create('pg5', 'PlotGroup1D');
model.result('pg5').run;
model.result('pg5').label('Total current');
model.result('pg5').set('showlegends', false);
model.result('pg5').set('titletype', 'none');
model.result('pg5').create('glob1', 'Global');
model.result('pg5').feature('glob1').set('markerpos', 'datapoints');
model.result('pg5').feature('glob1').set('linewidth', 'preference');
model.result('pg5').feature('glob1').set('expr', {'tcd.Itot_es1'});
model.result('pg5').feature('glob1').set('descr', {'Total current'});
model.result('pg5').feature('glob1').set('unit', {'A'});
model.result('pg5').run;

model.title('Voltammetry at a Microdisk Electrode');

model.description(['Microelectrodes are popular in electroanalysis because they provide high current densities with a small quantity of active electrode material. The short diffusion time scales to a microelectrode mean that the steady-state result is accurate and therefore a Stationary study can be used.' newline  newline 'This example simulates voltammetry at a microelectrode of 10' native2unicode(hex2dec({'00' 'a0'}), 'unicode') 'um radius.']);

model.mesh.clearMeshes;

model.sol('sol1').clearSolutionData;

model.label('microdisk_voltammetry.mph');

model.modelNode.label('Components');

out = model;
