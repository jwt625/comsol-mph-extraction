function out = model
%
% crevice_corrosion_fe.m
%
% Model exported on May 26 2025, 21:27 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/Corrosion_Module/Crevice_and_Pitting_Corrosion');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 1);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.physics.create('tcd', 'TertiaryCurrentDistributionNernstPlanck', 'geom1', {'cFe' 'cFeOH' 'cNa' 'cCH3COOH' 'cCH3COO' 'cCH3COOFe'});
model.physics('tcd').prop('SpeciesProperties').set('ChargeTransportModel', 'WaterBased');

model.study.create('std1');
model.study('std1').create('stat', 'Stationary');
model.study('std1').feature('stat').setSolveFor('/physics/tcd', true);

% To import content from file, use:
% model.param.loadFile('FILENAME');
model.param.set('mu_factor', '4', 'Viscosity factor');
model.param.set('DFe', '0.7e-7[dm^2/s]/mu_factor', 'Diffusion coefficient, Fe2+');
model.param.set('DFeOH', '1e-7[dm^2/s]/mu_factor', 'Diffusion coefficient, FeOH+');
model.param.set('DNa', '1.3e-7[dm^2/s]/mu_factor', 'Diffusion coefficient, Na+');
model.param.set('DCH3COOH', '1.1e-7[dm^2/s]/mu_factor', 'Diffusion coefficient, CH3COOH');
model.param.set('DCH3COO', '1.1e-7[dm^2/s]/mu_factor', 'Diffusion coefficient, CH3COO-');
model.param.set('DCH3COOFe', '1.1e-7[dm^2/s]/mu_factor', 'Diffusion coefficient, CH3COOFe+');
model.param.set('K1', '1.63e-7', 'Equilibrium constant, iron dissolution in water');
model.param.set('Kw', '1.0113e-14[mol^2/dm^6]', 'Equilibrium constant, water protonization');
model.param.set('K2', '1.75e-5', 'Equilibrium constant, acetic acid protonization');
model.param.set('K3', '25.1', 'Equilibrium constant, iron dissolution in acetic acid');
model.param.set('cCH3COO_mix', '0.5[mol/dm^3]', 'Mixture amount CH3COO-');
model.param.set('cCH3COOH_mix', '0.5[mol/dm^3]', 'Mixture amount CH3COOH');
model.param.set('L', '10[mm]', 'Crevice length');
model.param.set('w', '0.5[mm]', 'Crevice width');
model.param.set('T', '298.15[K]', 'Temperature');
model.param.set('pH0', '4.8', 'Initial pH');
model.param.set('cH0', '10^(-pH0)[mol/dm^3]', 'Initial concentration, H+');
model.param.set('cOH0', '(Kw/cH0)', 'Initial concentration, OH-');
model.param.set('delta_c0', '(K2*cCH3COOH_mix-cH0*cCH3COO_mix/1[mol/dm^3])/(cH0/1[mol/dm^3]+K2)', 'Change in mixture concentration due to equilibrium reactions');
model.param.set('cCH3COOH0', 'cCH3COOH_mix-delta_c0', 'Initial concentration, CH3COOH');
model.param.set('cCH3COO0', 'cCH3COO_mix+delta_c0', 'Initial concentration, CH3COO-');
model.param.set('cFe0', '1[mol/m^3]', 'Initial concentration, Fe2+');
model.param.set('cFeOH0', 'K1*cFe0/cH0*1[mol/dm^3]', 'Initial concentration, FeOH+');
model.param.set('cCH3COOFe0', 'K3*cCH3COO0*cFe0/1[mol/dm^3]', 'Initial concentration, CH3COOFe+');
model.param.set('cNa0', 'cOH0+cCH3COO0-(2*cFe0+cFeOH0+cH0+cCH3COOFe0)', 'Initial concentration, Na+ (from electroneutrality)');
model.param.set('phil_mouth', '0.16[V]', 'Measured electrolyte potential at crevice mouth vs. SHE');
model.param.set('V_pol', '0.84[V]', 'Polarization potential vs. SHE');

model.geom('geom1').create('i1', 'Interval');
model.geom('geom1').feature('i1').setIndex('coord', 'L', 1);
model.geom('geom1').runPre('fin');
model.geom('geom1').run;

model.material.create('mat1', 'Common', 'comp1');
model.material('mat1').propertyGroup.create('LocalCurrentDensity', 'Local current density');
model.material('mat1').propertyGroup('LocalCurrentDensity').func.create('int1', 'Interpolation');
model.material('mat1').propertyGroup.create('ElectrodePotential', 'Equilibrium potential');
model.material('mat1').label('Fe in acetic acid/sodium acetate (Anodic)');
model.material('mat1').propertyGroup('LocalCurrentDensity').func('int1').set('funcname', 'iloc_exp');
model.material('mat1').propertyGroup('LocalCurrentDensity').func('int1').set('table', {'-1' '0.1';  ...
'-0.452247191' '0.1';  ...
'-0.41011236' '1';  ...
'-0.33988764' '10';  ...
'-0.283707865' '30';  ...
'-0.199438202' '100';  ...
'0.011235955' '350';  ...
'0.193820225' '550';  ...
'0.306179775' '600';  ...
'0.404494382' '550';  ...
'0.502808989' '350';  ...
'0.629213483' '100';  ...
'0.699438202' '10';  ...
'0.769662921' '2';  ...
'0.867977528' '1';  ...
'1.387640449' '1'});
model.material('mat1').propertyGroup('LocalCurrentDensity').func('int1').set('extrap', 'linear');
model.material('mat1').propertyGroup('LocalCurrentDensity').func('int1').set('fununit', {'A/m^2'});
model.material('mat1').propertyGroup('LocalCurrentDensity').func('int1').set('argunit', {'V'});
model.material('mat1').propertyGroup('LocalCurrentDensity').set('ilocmat', 'iloc_exp(E_vs_ref_exp)');
model.material('mat1').propertyGroup('LocalCurrentDensity').set('INFO_PREFIX:ilocmat', 'J. C. Walton, "Mathematical modeling of mass transport and chemical reaction in crevice and pitting corrosion", Corrosion Science, vol. 30, p. 915, 1990.');
model.material('mat1').propertyGroup('LocalCurrentDensity').set('E_vs_SHE', 'V');
model.material('mat1').propertyGroup('LocalCurrentDensity').descr('E_vs_SHE', 'Electrode potential vs. SHE');
model.material('mat1').propertyGroup('LocalCurrentDensity').set('E_ref_exp_vs_SHE', '0 [V]');
model.material('mat1').propertyGroup('LocalCurrentDensity').descr('E_ref_exp_vs_SHE', 'Reference electrode potential in experiment vs. SHE');
model.material('mat1').propertyGroup('LocalCurrentDensity').set('E_vs_ref_exp', 'E_vs_SHE-E_ref_exp_vs_SHE');
model.material('mat1').propertyGroup('LocalCurrentDensity').descr('E_vs_ref_exp', 'Electrode potential vs. experimental SHE reference electrode');
model.material('mat1').propertyGroup('LocalCurrentDensity').addInput('electricpotential');
model.material('mat1').propertyGroup('ElectrodePotential').set('Eeq', 'Eeq_vs_SHE');
model.material('mat1').propertyGroup('ElectrodePotential').set('INFO_PREFIX:Eeq', 'J. C. Walton, "Mathematical modeling of mass transport and chemical reaction in crevice and pitting corrosion", Corrosion Science, vol. 30, p. 915, 1990.');
model.material('mat1').propertyGroup('ElectrodePotential').set('dEeqdT', '0');
model.material('mat1').propertyGroup('ElectrodePotential').set('cEeqref', '0');
model.material('mat1').propertyGroup('ElectrodePotential').set('Eeq_vs_ref_exp', '-1 [V]');
model.material('mat1').propertyGroup('ElectrodePotential').descr('Eeq_vs_ref_exp', 'Equilibrium (open circuit) potential vs. SHE');
model.material('mat1').propertyGroup('ElectrodePotential').set('E_ref_exp_vs_SHE', '0 [V]');
model.material('mat1').propertyGroup('ElectrodePotential').descr('E_ref_exp_vs_SHE', 'Reference electrode potential in experiment vs. SHE');
model.material('mat1').propertyGroup('ElectrodePotential').set('Eeq_vs_SHE', 'Eeq_vs_ref_exp+E_ref_exp_vs_SHE');
model.material('mat1').propertyGroup('ElectrodePotential').descr('Eeq_vs_SHE', 'Equilibrium (open circuit) potential vs. SHE');
model.material('mat1').propertyGroup('ElectrodePotential').addInput('concentration');

model.physics('tcd').feature('sp1').setIndex('z', 2, 0);
model.physics('tcd').feature('sp1').setIndex('z', 1, 1);
model.physics('tcd').feature('sp1').setIndex('z', 1, 2);
model.physics('tcd').feature('sp1').setIndex('z', -1, 4);
model.physics('tcd').feature('sp1').setIndex('z', 1, 5);
model.physics('tcd').create('hcpce1', 'HighlyConductivePorousElectrode', 1);
model.physics('tcd').feature('hcpce1').selection.all;
model.physics('tcd').feature('hcpce1').set('minput_temperature_src', 'userdef');
model.physics('tcd').feature('hcpce1').set('minput_temperature', 'T');
model.physics('tcd').feature('hcpce1').set('D_cFe', {'DFe' '0' '0' '0' 'DFe' '0' '0' '0' 'DFe'});
model.physics('tcd').feature('hcpce1').set('D_cFeOH', {'DFeOH' '0' '0' '0' 'DFeOH' '0' '0' '0' 'DFeOH'});
model.physics('tcd').feature('hcpce1').set('D_cNa', {'DNa' '0' '0' '0' 'DNa' '0' '0' '0' 'DNa'});
model.physics('tcd').feature('hcpce1').set('D_cCH3COOH', {'DCH3COOH' '0' '0' '0' 'DCH3COOH' '0' '0' '0' 'DCH3COOH'});
model.physics('tcd').feature('hcpce1').set('D_cCH3COO', {'DCH3COO' '0' '0' '0' 'DCH3COO' '0' '0' '0' 'DCH3COO'});
model.physics('tcd').feature('hcpce1').set('D_cCH3COOFe', {'DCH3COOFe' '0' '0' '0' 'DCH3COOFe' '0' '0' '0' 'DCH3COOFe'});
model.physics('tcd').feature('hcpce1').set('epsl', 1);
model.physics('tcd').feature('hcpce1').set('DiffusionCorrModel', 'NoCorr');
model.physics('tcd').feature('hcpce1').set('phisext0', 'V_pol');
model.physics('tcd').feature('hcpce1').feature('per1').set('nm', 2);
model.physics('tcd').feature('hcpce1').feature('per1').setIndex('Vi0', -1, 0);
model.physics('tcd').feature('hcpce1').feature('per1').set('ilocmat_mat', 'from_mat');
model.physics('tcd').feature('hcpce1').feature('per1').set('Av', '2/w');
model.physics('tcd').create('eqreac1', 'EquilibriumReaction', 1);
model.physics('tcd').feature('eqreac1').selection.all;
model.physics('tcd').feature('eqreac1').set('Keq0', 'K1');
model.physics('tcd').feature('eqreac1').setIndex('nu', -1, 0);
model.physics('tcd').feature('eqreac1').setIndex('nu', 1, 1);
model.physics('tcd').feature('eqreac1').set('nuH', 1);
model.physics('tcd').feature.duplicate('eqreac2', 'eqreac1');
model.physics('tcd').feature('eqreac2').set('Keq0', 'K2');
model.physics('tcd').feature('eqreac2').setIndex('nu', 0, 0);
model.physics('tcd').feature('eqreac2').setIndex('nu', 0, 1);
model.physics('tcd').feature('eqreac2').setIndex('nu', -1, 3);
model.physics('tcd').feature('eqreac2').setIndex('nu', 1, 4);
model.physics('tcd').feature.duplicate('eqreac3', 'eqreac2');
model.physics('tcd').feature('eqreac3').set('Keq0', 'K3');
model.physics('tcd').feature('eqreac3').setIndex('nu', -1, 0);
model.physics('tcd').feature('eqreac3').setIndex('nu', 0, 3);
model.physics('tcd').feature('eqreac3').setIndex('nu', -1, 4);
model.physics('tcd').feature('eqreac3').setIndex('nu', 1, 5);
model.physics('tcd').feature('eqreac3').set('nuH', 0);
model.physics('tcd').feature('init1').setIndex('initc', 'cFe0', 0);
model.physics('tcd').feature('init1').setIndex('initc', 'cFeOH0', 1);
model.physics('tcd').feature('init1').setIndex('initc', 'cNa0', 2);
model.physics('tcd').feature('init1').setIndex('initc', 'cCH3COOH0', 3);
model.physics('tcd').feature('init1').setIndex('initc', 'cCH3COO0', 4);
model.physics('tcd').feature('init1').setIndex('initc', 'cCH3COOFe0', 5);
model.physics('tcd').feature('init1').set('initphil', 'phil_mouth');
model.physics('tcd').create('conc1', 'Concentration', 0);
model.physics('tcd').feature('conc1').selection.set([1]);
model.physics('tcd').feature('conc1').setIndex('species', true, 0);
model.physics('tcd').feature('conc1').setIndex('c0', 'cFe0', 0);
model.physics('tcd').feature('conc1').setIndex('species', true, 2);
model.physics('tcd').feature('conc1').setIndex('c0', 'cNa0', 2);
model.physics('tcd').feature('conc1').setIndex('species', true, 3);
model.physics('tcd').feature('conc1').setIndex('c0', 'cCH3COOH0', 3);
model.physics('tcd').create('eip1', 'ElectrolytePotential', 0);
model.physics('tcd').feature('eip1').selection.set([1]);
model.physics('tcd').feature('eip1').set('philbnd', 'phil_mouth');

model.mesh('mesh1').automatic(false);
model.mesh('mesh1').feature('size').set('custom', true);
model.mesh('mesh1').feature('size').set('hmax', '1e-5');
model.mesh('mesh1').feature('size').set('hgrad', 1.1);
model.mesh('mesh1').feature('edg1').create('size1', 'Size');
model.mesh('mesh1').feature('edg1').feature('size1').selection.geom('geom1', 0);
model.mesh('mesh1').feature('edg1').feature('size1').selection.set([1]);
model.mesh('mesh1').feature('edg1').feature('size1').set('custom', true);
model.mesh('mesh1').feature('edg1').feature('size1').set('hmaxactive', true);
model.mesh('mesh1').feature('edg1').feature('size1').set('hmax', '1e-7');

model.study('std1').feature('stat').set('useparam', true);
model.study('std1').feature('stat').setIndex('pname', 'mu_factor', 0);
model.study('std1').feature('stat').setIndex('plistarr', '', 0);
model.study('std1').feature('stat').setIndex('punit', '', 0);
model.study('std1').feature('stat').setIndex('pname', 'mu_factor', 0);
model.study('std1').feature('stat').setIndex('plistarr', '', 0);
model.study('std1').feature('stat').setIndex('punit', '', 0);
model.study('std1').feature('stat').setIndex('pname', 'V_pol', 0);
model.study('std1').feature('stat').setIndex('plistarr', 'range(-0.6, 0.2, 0.8) 0.844', 0);
model.study('std1').setGenPlots(false);

model.sol.create('sol1');
model.sol('sol1').study('std1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'stat');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').feature('comp1_phil').set('scalemethod', 'manual');
model.sol('sol1').feature('v1').feature('comp1_tcd_eqreac3_Req').set('scalemethod', 'manual');
model.sol('sol1').feature('v1').feature('comp1_tcd_eqreac2_Req').set('scalemethod', 'manual');
model.sol('sol1').feature('v1').feature('comp1_tcd_eqreac1_Req').set('scalemethod', 'manual');
model.sol('sol1').feature('v1').feature('comp1_phil').set('scaleval', '1');
model.sol('sol1').feature('v1').feature('comp1_tcd_eqreac3_Req').set('scaleval', '1000');
model.sol('sol1').feature('v1').feature('comp1_tcd_eqreac2_Req').set('scaleval', '1000');
model.sol('sol1').feature('v1').feature('comp1_tcd_eqreac1_Req').set('scaleval', '1000');
model.sol('sol1').feature('v1').set('control', 'stat');
model.sol('sol1').create('s1', 'Stationary');
model.sol('sol1').feature('s1').set('stol', 1.0E-4);
model.sol('sol1').feature('s1').create('p1', 'Parametric');
model.sol('sol1').feature('s1').feature.remove('pDef');
model.sol('sol1').feature('s1').feature('p1').set('porder', 'constant');
model.sol('sol1').feature('s1').feature('p1').set('control', 'stat');
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
model.sol('sol1').feature('s1').feature('i1').feature('mg1').set('saamgcompwise', false);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').set('compactaggregation', true);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('pr').create('va1', 'Vanka');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('pr').feature('va1').set('vankavars', {'comp1_tcd_eqreac1_Req' 'comp1_tcd_eqreac2_Req' 'comp1_tcd_eqreac3_Req'});
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('po').create('va1', 'Vanka');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('po').feature('va1').set('vankavars', {'comp1_tcd_eqreac1_Req' 'comp1_tcd_eqreac2_Req' 'comp1_tcd_eqreac3_Req'});
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('cs').create('d1', 'Direct');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('cs').feature('d1').set('linsolver', 'pardiso');
model.sol('sol1').feature('s1').create('i2', 'Iterative');
model.sol('sol1').feature('s1').feature('i2').set('maxlinit', 1000);
model.sol('sol1').feature('s1').feature('i2').set('nlinnormuse', 'on');
model.sol('sol1').feature('s1').feature('i2').label('Geometric Multigrid (tcd)');
model.sol('sol1').feature('s1').feature('i2').create('mg1', 'Multigrid');
model.sol('sol1').feature('s1').feature('i2').feature('mg1').feature('pr').create('va1', 'Vanka');
model.sol('sol1').feature('s1').feature('i2').feature('mg1').feature('pr').feature('va1').set('vankavars', {'comp1_tcd_eqreac1_Req' 'comp1_tcd_eqreac2_Req' 'comp1_tcd_eqreac3_Req'});
model.sol('sol1').feature('s1').feature('i2').feature('mg1').feature('po').create('va1', 'Vanka');
model.sol('sol1').feature('s1').feature('i2').feature('mg1').feature('po').feature('va1').set('vankavars', {'comp1_tcd_eqreac1_Req' 'comp1_tcd_eqreac2_Req' 'comp1_tcd_eqreac3_Req'});
model.sol('sol1').feature('s1').feature('i2').feature('mg1').feature('cs').create('d1', 'Direct');
model.sol('sol1').feature('s1').feature('i2').feature('mg1').feature('cs').feature('d1').set('linsolver', 'pardiso');
model.sol('sol1').feature('s1').feature('fc1').set('linsolver', 'd1');
model.sol('sol1').feature('s1').feature('fc1').set('dtech', 'auto');
model.sol('sol1').feature('s1').feature('fc1').set('maxiter', 50);
model.sol('sol1').feature('s1').feature('fc1').set('minstep', 1.0E-6);
model.sol('sol1').feature('s1').feature.remove('fcDef');
model.sol('sol1').attach('std1');
model.sol('sol1').runAll;

model.result.create('pg1', 'PlotGroup1D');
model.result('pg1').run;
model.result('pg1').label('Concentrations');
model.result('pg1').setIndex('looplevelinput', 'last', 0);
model.result('pg1').set('titletype', 'manual');
model.result('pg1').set('title', 'Solution Composition at 0.844 V(SHE)');
model.result('pg1').set('xlabelactive', true);
model.result('pg1').set('xlabel', 'Position Inside Crevice (m)');
model.result('pg1').set('ylabelactive', true);
model.result('pg1').set('ylabel', 'Concentration (mol/m<sup>3</sup>)');
model.result('pg1').create('lngr1', 'LineGraph');
model.result('pg1').feature('lngr1').set('markerpos', 'datapoints');
model.result('pg1').feature('lngr1').set('linewidth', 'preference');
model.result('pg1').feature('lngr1').selection.all;
model.result('pg1').feature('lngr1').set('expr', 'cFe');
model.result('pg1').feature('lngr1').set('legend', true);
model.result('pg1').feature('lngr1').set('legendmethod', 'manual');
model.result('pg1').feature('lngr1').setIndex('legends', 'Fe<sup>2+</sup>', 0);
model.result('pg1').feature.duplicate('lngr2', 'lngr1');
model.result('pg1').run;
model.result('pg1').feature('lngr2').set('expr', 'tcd.cH');
model.result('pg1').feature('lngr2').setIndex('legends', 'H<sup>+</sup>', 0);
model.result('pg1').feature.duplicate('lngr3', 'lngr2');
model.result('pg1').run;
model.result('pg1').feature('lngr3').set('expr', 'tcd.cOH');
model.result('pg1').feature('lngr3').setIndex('legends', 'OH<sup>-</sup>', 0);
model.result('pg1').feature.duplicate('lngr4', 'lngr3');
model.result('pg1').run;
model.result('pg1').feature('lngr4').set('expr', 'cFeOH');
model.result('pg1').feature('lngr4').setIndex('legends', 'FeOH<sup>+</sup>', 0);
model.result('pg1').feature.duplicate('lngr5', 'lngr4');
model.result('pg1').run;
model.result('pg1').feature('lngr5').set('expr', 'cNa');
model.result('pg1').feature('lngr5').setIndex('legends', 'Na<sup>+</sup>', 0);
model.result('pg1').feature.duplicate('lngr6', 'lngr5');
model.result('pg1').run;
model.result('pg1').feature('lngr6').set('expr', 'cCH3COOH');
model.result('pg1').feature('lngr6').setIndex('legends', 'CH3COOH', 0);
model.result('pg1').feature.duplicate('lngr7', 'lngr6');
model.result('pg1').run;
model.result('pg1').feature('lngr7').set('expr', 'cCH3COO');
model.result('pg1').feature('lngr7').setIndex('legends', 'CH3COO<sup>-</sup>', 0);
model.result('pg1').feature.duplicate('lngr8', 'lngr7');
model.result('pg1').run;
model.result('pg1').feature('lngr8').set('expr', 'cCH3COOFe');
model.result('pg1').feature('lngr8').setIndex('legends', 'CH3COOFe<sup>+</sup>', 0);
model.result('pg1').feature('lngr8').set('linestyle', 'dashed');
model.result('pg1').run;
model.result('pg1').set('axislimits', true);
model.result('pg1').set('xmin', '0.99e-6');
model.result('pg1').set('xmax', 0.0101);
model.result('pg1').set('ymin', '1e-3');
model.result('pg1').set('ymax', '1e4');
model.result('pg1').set('xlog', true);
model.result('pg1').set('ylog', true);
model.result('pg1').set('legendpos', 'lowerright');
model.result('pg1').run;
model.result.create('pg2', 'PlotGroup1D');
model.result('pg2').run;
model.result('pg2').label('Electrode potential');
model.result('pg2').setIndex('looplevelinput', 'last', 0);
model.result('pg2').set('xlabelactive', true);
model.result('pg2').set('xlabel', 'Position Inside Crevice (m)');
model.result('pg2').set('ylabelactive', true);
model.result('pg2').set('ylabel', 'Potential (V)');
model.result('pg2').set('titletype', 'manual');
model.result('pg2').set('title', 'Electrode Potential vs. Reference Electrode in Electrolyte');
model.result('pg2').create('lngr1', 'LineGraph');
model.result('pg2').feature('lngr1').set('markerpos', 'datapoints');
model.result('pg2').feature('lngr1').set('linewidth', 'preference');
model.result('pg2').feature('lngr1').selection.set([1]);
model.result('pg2').feature('lngr1').set('expr', 'V_pol-phil');
model.result('pg2').run;
model.result.create('pg3', 'PlotGroup1D');
model.result('pg3').run;
model.result('pg3').label('Corrosion current density');
model.result('pg3').setIndex('looplevelinput', 'last', 0);
model.result('pg3').set('titletype', 'manual');
model.result('pg3').set('title', 'Iron Oxidation Current Density');
model.result('pg3').set('xlog', true);
model.result('pg3').set('ylog', true);
model.result('pg3').create('lngr1', 'LineGraph');
model.result('pg3').feature('lngr1').set('markerpos', 'datapoints');
model.result('pg3').feature('lngr1').set('linewidth', 'preference');
model.result('pg3').feature('lngr1').selection.set([1]);
model.result('pg3').feature('lngr1').set('expr', 'tcd.iloc_per1');
model.result('pg3').feature('lngr1').set('descr', 'Local current density');
model.result('pg3').feature('lngr1').set('xdata', 'expr');
model.result('pg3').feature('lngr1').set('xdataexpr', 'x');
model.result('pg3').feature('lngr1').set('xdatadescr', 'x-coordinate');
model.result('pg3').feature('lngr1').set('xdatadescractive', true);
model.result('pg3').feature('lngr1').set('xdatadescr', 'Position Inside Crevice');
model.result('pg3').run;

model.title('Crevice Corrosion of Iron in an Acetic Acid/Sodium Acetate Solution');

model.description('This example models crevice corrosion of iron in a buffer solution of pH 4.8, formed by equal amounts of acetic acid and sodium acetate. The model combines electrochemical dissolution of iron on the crevice walls together with heterogeneous equilibrium reactions in the electrolyte. The model is in 1D.');

model.mesh.clearMeshes;

model.sol('sol1').clearSolutionData;

model.label('crevice_corrosion_fe.mph');

model.modelNode.label('Components');

out = model;
