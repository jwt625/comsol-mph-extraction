function out = model
%
% cu_electroless_deposition.m
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

model.physics.create('tcd', 'TertiaryElectroanalysis', 'geom1', {'cCuOH2L2' 'cHCHO' 'cOH' 'cL'});

model.study.create('std1');
model.study('std1').create('time', 'Transient');
model.study('std1').feature('time').setSolveFor('/physics/tcd', true);

% To import content from file, use:
% model.param.loadFile('FILENAME');
model.param.set('i0_Cu', '3.4e-5 [A/cm^2]', 'Exchange current density for copper reduction reaction');
model.param.set('i0_HCHO', '1.4e-4 [A/cm^2]', 'Exchange current density for formaldehyde oxidation reaction');
model.param.set('Eeq0_Cu', '-0.47[V]', 'Reference equilibrium potential for copper reduction reaction');
model.param.set('Eeq0_HCHO', '-1.0 [V]', 'Reference equilibrium potential for formaldehyde oxidation reaction');
model.param.set('Aa_HCHO', '-(Eeq0_HCHO+0.65[V])/(log10(1.9e-3[A/cm^2]/i0_HCHO))', 'Tafel slope for formaldehyde oxidation reaction');
model.param.set('Ac_Cu', '-(Eeq0_Cu+0.65[V])/(log10(1.9e-3[A/cm^2]/i0_Cu))', 'Tafel slope for copper reduction reaction');
model.param.set('alphac_Cu', '-log(10)*R_const*T/F_const/Ac_Cu', 'Cathodic transfer coefficient');
model.param.set('DCuOH2L2', '0.7e-9[m^2/s]', 'Diffusion coefficient of CuOH2L2');
model.param.set('DHCHO', '1.2e-9[m^2/s]', 'Diffusion coefficient of HCHO');
model.param.set('DOH', '5.273e-9[m^2/s]', 'Diffusion coefficient of OH');
model.param.set('DL', '0.794e-9[m^2/s]', 'Diffusion coefficient of L');
model.param.set('cCuOH2L20', '0.1[M]', 'Concentration of CuOH2L2');
model.param.set('cHCHO0', '0.05[M]', 'Concentration of HCHO');
model.param.set('cOH0', '10^-(14-12.5)[M]', 'Concentration of OH');
model.param.set('cL0', '0.075[M]', 'Concentration of L');
model.param.set('MW_Cu', '0.06355[kg/mol]', 'Molecular mass of copper');
model.param.set('rho_Cu', '8960[kg/m^3]', 'Density of copper');
model.param.set('T', '25[degC]', 'Temperature');

model.geom('geom1').create('i1', 'Interval');
model.geom('geom1').feature('i1').setIndex('coord', '2 [mm]', 1);
model.geom('geom1').runPre('fin');
model.geom('geom1').run;

model.physics('tcd').feature('ice1').set('D_cCuOH2L2', {'DCuOH2L2' '0' '0' '0' 'DCuOH2L2' '0' '0' '0' 'DCuOH2L2'});
model.physics('tcd').feature('ice1').set('D_cHCHO', {'DHCHO' '0' '0' '0' 'DHCHO' '0' '0' '0' 'DHCHO'});
model.physics('tcd').feature('ice1').set('D_cOH', {'DOH' '0' '0' '0' 'DOH' '0' '0' '0' 'DOH'});
model.physics('tcd').feature('ice1').set('D_cL', {'DL' '0' '0' '0' 'DL' '0' '0' '0' 'DL'});
model.physics('tcd').feature('init1').setIndex('initc', 'cCuOH2L20', 0);
model.physics('tcd').feature('init1').setIndex('initc', 'cHCHO0', 1);
model.physics('tcd').feature('init1').setIndex('initc', 'cOH0', 2);
model.physics('tcd').feature('init1').setIndex('initc', 'cL0', 3);
model.physics('tcd').create('conc1', 'Concentration', 0);
model.physics('tcd').feature('conc1').selection.set([2]);
model.physics('tcd').feature('conc1').setIndex('species', true, 0);
model.physics('tcd').feature('conc1').setIndex('c0', 'cCuOH2L20', 0);
model.physics('tcd').feature('conc1').setIndex('species', true, 1);
model.physics('tcd').feature('conc1').setIndex('c0', 'cHCHO0', 1);
model.physics('tcd').feature('conc1').setIndex('species', true, 2);
model.physics('tcd').feature('conc1').setIndex('c0', 'cOH0', 2);
model.physics('tcd').feature('conc1').setIndex('species', true, 3);
model.physics('tcd').feature('conc1').setIndex('c0', 'cL0', 3);
model.physics('tcd').create('es1', 'ElectrodeSurface', 0);
model.physics('tcd').feature('es1').selection.set([1]);
model.physics('tcd').feature('es1').setIndex('Species', 's1', 0, 0);
model.physics('tcd').feature('es1').setIndex('rhos', 8960, 0, 0);
model.physics('tcd').feature('es1').setIndex('Ms', 0.06355, 0, 0);
model.physics('tcd').feature('es1').setIndex('Species', 's1', 0, 0);
model.physics('tcd').feature('es1').setIndex('rhos', 8960, 0, 0);
model.physics('tcd').feature('es1').setIndex('Ms', 0.06355, 0, 0);
model.physics('tcd').feature('es1').setIndex('Species', 'Cu', 0, 0);
model.physics('tcd').feature('es1').setIndex('rhos', 'rho_Cu', 0, 0);
model.physics('tcd').feature('es1').setIndex('Ms', 'MW_Cu', 0, 0);
model.physics('tcd').feature('es1').set('BoundaryCondition', 'TotalCurrent');
model.physics('tcd').feature('es1').set('Itl', 0);
model.physics('tcd').feature('es1').set('phisext0init', '-0.65[V]');
model.physics('tcd').feature('es1').feature('er1').setIndex('Vi0', '-1/2', 0);
model.physics('tcd').feature('es1').feature('er1').setIndex('Vi0', 1, 2);
model.physics('tcd').feature('es1').feature('er1').setIndex('Vi0', 1, 3);
model.physics('tcd').feature('es1').feature('er1').setIndex('Vib', '1/2', 0, 0);
model.physics('tcd').feature('es1').feature('er1').set('Eeq_ref', 'Eeq0_Cu');
model.physics('tcd').feature('es1').feature('er1').setIndex('cref', 'cCuOH2L20', 0, 0);
model.physics('tcd').feature('es1').feature('er1').setIndex('cref', 'cOH0', 2, 0);
model.physics('tcd').feature('es1').feature('er1').setIndex('cref', 'cL0', 3, 0);
model.physics('tcd').feature('es1').feature('er1').set('i0_ref', 'i0_Cu');
model.physics('tcd').feature('es1').feature('er1').set('alphaa', '1-alphac_Cu');
model.physics('tcd').feature('es1').create('er2', 'ElectrodeReaction', 0);
model.physics('tcd').feature('es1').feature('er2').setIndex('Vi0', 1, 1);
model.physics('tcd').feature('es1').feature('er2').setIndex('Vi0', 2, 2);
model.physics('tcd').feature('es1').feature('er2').set('Eeq_mat', 'userdef');
model.physics('tcd').feature('es1').feature('er2').set('Eeq', 'Eeq0_HCHO');
model.physics('tcd').feature('es1').feature('er2').set('ElectrodeKinetics', 'AnodicTafelEquation');
model.physics('tcd').feature('es1').feature('er2').set('i0', 'i0_HCHO*(cOH/cOH0)^2*(cHCHO/cHCHO0)');
model.physics('tcd').feature('es1').feature('er2').set('Aa', 'Aa_HCHO');

model.common('cminpt').set('modified', {'temperature' 'T'});

model.mesh('mesh1').autoMeshSize(1);
model.mesh('mesh1').create('size1', 'Size');
model.mesh('mesh1').feature('size1').selection.geom('geom1', 0);
model.mesh('mesh1').feature('size1').selection.set([1]);
model.mesh('mesh1').feature('size1').set('custom', true);
model.mesh('mesh1').feature('size1').set('hmaxactive', true);
model.mesh('mesh1').feature('size1').set('hmax', '2E-7');
model.mesh('mesh1').create('edg1', 'Edge');
model.mesh('mesh1').run;

model.study('std1').setGenPlots(false);
model.study('std1').feature('time').set('tlist', 'range(0,10,3600)');
model.study('std1').feature('time').set('usertol', true);
model.study('std1').feature('time').set('rtol', '1e-5');

model.sol.create('sol1');
model.sol('sol1').study('std1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'time');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').feature('comp1_tcd_es1_phisext').set('scalemethod', 'manual');
model.sol('sol1').feature('v1').feature('comp1_tcd_es1_phisext').set('scaleval', '1');
model.sol('sol1').feature('v1').set('control', 'time');
model.sol('sol1').create('t1', 'Time');
model.sol('sol1').feature('t1').set('tlist', 'range(0,10,3600)');
model.sol('sol1').feature('t1').set('plot', 'off');
model.sol('sol1').feature('t1').set('plotgroup', 'Default');
model.sol('sol1').feature('t1').set('plotfreq', 'tout');
model.sol('sol1').feature('t1').set('probesel', 'all');
model.sol('sol1').feature('t1').set('probes', {});
model.sol('sol1').feature('t1').set('probefreq', 'tsteps');
model.sol('sol1').feature('t1').set('tout', 'tsteps');
model.sol('sol1').feature('t1').set('rtol', 0.001);
model.sol('sol1').feature('t1').set('atolglobalvaluemethod', 'factor');
model.sol('sol1').feature('t1').set('eventout', true);
model.sol('sol1').feature('t1').set('reacf', true);
model.sol('sol1').feature('t1').set('storeudot', true);
model.sol('sol1').feature('t1').set('endtimeinterpolation', true);
model.sol('sol1').feature('t1').set('maxorder', 2);
model.sol('sol1').feature('t1').set('control', 'time');
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
model.sol('sol1').runAll;

model.result.create('pg1', 'PlotGroup1D');
model.result('pg1').run;
model.result('pg1').label('Mixed Potential');
model.result('pg1').create('ptgr1', 'PointGraph');
model.result('pg1').feature('ptgr1').set('markerpos', 'datapoints');
model.result('pg1').feature('ptgr1').set('linewidth', 'preference');
model.result('pg1').feature('ptgr1').selection.set([1]);
model.result('pg1').feature('ptgr1').set('expr', 'tcd.phisext');
model.result('pg1').feature('ptgr1').set('descractive', true);
model.result('pg1').feature('ptgr1').set('descr', 'Mixed potential');
model.result('pg1').feature('ptgr1').set('titletype', 'manual');
model.result('pg1').feature('ptgr1').set('title', 'Point Graph: Mixed potential');
model.result('pg1').run;
model.result('pg1').run;
model.result.duplicate('pg2', 'pg1');
model.result('pg2').run;
model.result('pg2').label('Deposition Current Density');
model.result('pg2').run;
model.result('pg2').feature('ptgr1').set('expr', 'abs(tcd.iloc_er1)');
model.result('pg2').feature('ptgr1').set('descr', 'Deposition current density');
model.result('pg2').feature('ptgr1').set('title', 'Point Graph: Deposition current density');
model.result('pg2').run;
model.result('pg1').run;
model.result.duplicate('pg3', 'pg1');
model.result('pg3').run;
model.result('pg3').label('Deposition Thickness');
model.result('pg3').run;
model.result('pg3').feature('ptgr1').set('expr', 'tcd.sbtot');
model.result('pg3').feature('ptgr1').set('unit', [native2unicode(hex2dec({'00' 'b5'}), 'unicode') 'm']);
model.result('pg3').feature('ptgr1').set('descr', 'Deposition thickness');
model.result('pg3').feature('ptgr1').set('title', 'Point Graph: Deposition thickness');
model.result('pg3').run;
model.result('pg1').run;
model.result.duplicate('pg4', 'pg1');
model.result('pg4').run;
model.result('pg4').label('Normalized Concentration');
model.result('pg4').set('ylabelactive', true);
model.result('pg4').set('ylabel', 'Normalized concentration');
model.result('pg4').set('ylog', true);
model.result('pg4').run;
model.result('pg4').feature('ptgr1').set('expr', 'cCuOH2L2/cCuOH2L20');
model.result('pg4').feature('ptgr1').set('legend', true);
model.result('pg4').feature('ptgr1').set('legendmethod', 'manual');
model.result('pg4').feature('ptgr1').setIndex('legends', 'Cu(OH)<sub>2</sub>L<sub>2</sub>', 0);
model.result('pg4').feature('ptgr1').set('title', 'Point Graph: Normalized concentration');
model.result('pg4').feature.duplicate('ptgr2', 'ptgr1');
model.result('pg4').run;
model.result('pg4').feature('ptgr2').set('expr', 'cHCHO/cHCHO0');
model.result('pg4').feature('ptgr2').setIndex('legends', 'HCHO', 0);
model.result('pg4').feature('ptgr2').set('titletype', 'none');
model.result('pg4').feature.duplicate('ptgr3', 'ptgr2');
model.result('pg4').run;
model.result('pg4').feature('ptgr3').set('expr', 'cL/cL0');
model.result('pg4').feature('ptgr3').setIndex('legends', 'L', 0);
model.result('pg4').run;
model.result('pg4').run;
model.result('pg4').set('legendpos', 'lowerleft');

model.title('Copper Electroless Deposition');

model.description(['This example demonstrates how to model transient electroless deposition of copper using mixed potential theory. The model accounts for mass transport by diffusion and electrochemical reactions at the electrode surface. The equilibrium potentials of partial electrochemical reactions are concentration dependent and the mixed potential is evaluated by setting the total current to 0.' newline  newline 'The change in current density, deposition thickness, concentration of ionic species during the electroless deposition is computed against time in this example.']);

model.mesh.clearMeshes;

model.sol('sol1').clearSolutionData;

model.label('cu_electroless_deposition.mph');

model.modelNode.label('Components');

out = model;
