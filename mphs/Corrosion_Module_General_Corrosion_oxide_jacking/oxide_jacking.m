function out = model
%
% oxide_jacking.m
%
% Model exported on May 26 2025, 21:27 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/Corrosion_Module/General_Corrosion');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 2);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.physics.create('tcd', 'TertiaryCurrentDistributionNernstPlanck', 'geom1', {'c'});
model.physics('tcd').prop('SpeciesProperties').set('ChargeTransportModel', 'SupportingElectrolyte');
model.physics.create('solid', 'SolidMechanics', 'geom1');
model.physics('solid').model('comp1');

model.study.create('std1');
model.study('std1').create('time', 'Transient');
model.study('std1').feature('time').setSolveFor('/physics/tcd', true);
model.study('std1').feature('time').setSolveFor('/physics/solid', true);

% To import content from file, use:
% model.param.loadFile('FILENAME');
model.param.set('A_Fe', '0.41[V]', 'Tafel slope iron oxidation');
model.param.set('A_H2', '-0.15[V]', 'Tafel slope hydrogen evolution');
model.param.set('A_O2', '-0.18[V]', 'Tafel slope oxygen reduction');
model.param.set('C_O2_ref', '8.6[mol/m^3]', 'Oxygen reference concentration');
model.param.set('Eeq_Fe', '-0.76[V]', 'Iron oxidation equilibrium potential');
model.param.set('Eeq_H2', '-1.03[V]', 'Hydrogen evolution equilibrium potential');
model.param.set('Eeq_O2', '0.189[V]', 'Oxygen reduction equilibrium potential');
model.param.set('i0_Fe', '7.1e-5[A/m^2]', 'Iron oxidation exchange current density');
model.param.set('i0_H2', '1.1e-2[A/m^2]', 'Hydrogen evolution current density');
model.param.set('i0_O2', '7.7e-7[A/m^2]', 'Oxygen reduction exchange current density');
model.param.set('Eeq_Zn', '-0.68[V]', 'Zn equilibrium potential');
model.param.set('L', '3.175e-2[m]', 'Concrete section length');
model.param.set('R_rebar', '0.635e-2[m]', 'Reinforcing bar radius');
model.param.set('S', '2.54e-2[m]', 'Concrete thickness');
model.param.set('W', '6.35e-2[m]', 'Width of concrete section');
model.param.set('PS', '0.6', 'Pore saturation');
model.param.set('E_app', '-1[V]', 'Applied cell potential');
model.param.set('r_rebar', '1[cm]/2', 'Radius of rebar');
model.param.set('rho_oxide', '5.240[g/cm^3]', 'Density of iron oxide');
model.param.set('M_oxide', '159.688[g/mol]', 'Molar mass of iron oxide');
model.param.set('rho_Fe', '7.87[g/cm^3]', 'Density of iron');
model.param.set('M_Fe', '55.845[g/mol]', 'Molar mass of iron');
model.param.set('sigmap', '2e6[Pa]', 'Tensile strength of concrete');
model.param.set('Gf', '100[J/m^2]', 'Strain softening input for concrete');
model.param.set('lint', '2e-4[m]', 'Implicit gradient length scale for concrete');
model.param.set('hdmg', '6e-3[m]', 'Size of the damage dissipation zone');

model.geom('geom1').create('sq1', 'Square');
model.geom('geom1').feature('sq1').set('size', '10[cm]');
model.geom('geom1').feature('sq1').setIndex('layername', 'Layer 1', 0);
model.geom('geom1').feature('sq1').setIndex('layer', 0.05, 0);
model.geom('geom1').feature('sq1').set('layerleft', true);
model.geom('geom1').run('sq1');
model.geom('geom1').create('c1', 'Circle');
model.geom('geom1').feature('c1').set('r', 'r_rebar');
model.geom('geom1').feature('c1').set('pos', {'2.5[cm]' '6.5[cm]'});
model.geom('geom1').runPre('fin');
model.geom('geom1').run('fin');
model.geom('geom1').create('mcd1', 'MeshControlDomains');
model.geom('geom1').feature('mcd1').selection('input').set('fin', [1 3 4]);
model.geom('geom1').run('mcd1');

model.cpl.create('intop1', 'Integration', 'geom1');
model.cpl('intop1').set('axisym', true);
model.cpl('intop1').label('Rebar boundary integration');
model.cpl('intop1').selection.geom('geom1', 1);
model.cpl('intop1').selection.set([5 6 7 8]);

model.variable.create('var1');
model.variable('var1').model('comp1');

% To import content from file, use:
% model.variable('var1').loadFile('FILENAME');
model.variable('var1').set('e_init', 'intop1(tcd.sbtot)/(2*pi*r_rebar^2)', 'Initial mechanical strain from average corrosion layer thickness');

model.func.create('int1', 'Interpolation');
model.func('int1').model('comp1');
model.func('int1').set('funcname', 'sigma');
model.func('int1').set('table', {'0.2' '0.000175';  ...
'0.3' '0.000815';  ...
'0.4' '0.002';  ...
'0.5' '0.004878';  ...
'0.55' '0.005882';  ...
'0.6' '0.007042';  ...
'0.65' '0.008';  ...
'0.7' '0.009804';  ...
'0.75' '0.0125';  ...
'0.8' '0.015625'});
model.func('int1').setIndex('fununit', 'S/m', 0);
model.func.create('int2', 'Interpolation');
model.func('int2').model('comp1');
model.func('int2').set('funcname', 'D_O2');
model.func('int2').set('table', {'0.2' '152e-10';  ...
'0.3' '115e-10';  ...
'0.4' '83e-10';  ...
'0.5' '49e-10';  ...
'0.55' '39e-10';  ...
'0.6' '28e-10';  ...
'0.65' '20e-10';  ...
'0.7' '15e-10';  ...
'0.75' '10e-10';  ...
'0.8' '8.5e-10'});
model.func('int2').setIndex('fununit', 'm^2/s', 0);

model.material.create('mat1', 'Common', 'comp1');
model.material('mat1').propertyGroup.create('Enu', 'Young''s modulus and Poisson''s ratio');
model.material('mat1').label('Steel AISI 4340');
model.material('mat1').set('family', 'steel');
model.material('mat1').propertyGroup('def').set('relpermeability', {'1' '0' '0' '0' '1' '0' '0' '0' '1'});
model.material('mat1').propertyGroup('def').set('electricconductivity', {'4.032e6[S/m]' '0' '0' '0' '4.032e6[S/m]' '0' '0' '0' '4.032e6[S/m]'});
model.material('mat1').propertyGroup('def').set('thermalexpansioncoefficient', {'12.3e-6[1/K]' '0' '0' '0' '12.3e-6[1/K]' '0' '0' '0' '12.3e-6[1/K]'});
model.material('mat1').propertyGroup('def').set('heatcapacity', '475[J/(kg*K)]');
model.material('mat1').propertyGroup('def').set('relpermittivity', {'1' '0' '0' '0' '1' '0' '0' '0' '1'});
model.material('mat1').propertyGroup('def').set('density', '7850[kg/m^3]');
model.material('mat1').propertyGroup('def').set('thermalconductivity', {'44.5[W/(m*K)]' '0' '0' '0' '44.5[W/(m*K)]' '0' '0' '0' '44.5[W/(m*K)]'});
model.material('mat1').propertyGroup('Enu').set('E', '205[GPa]');
model.material('mat1').propertyGroup('Enu').set('nu', '0.28');
model.material('mat1').selection.set([2]);
model.material.create('mat2', 'Common', 'comp1');
model.material('mat2').propertyGroup.create('Enu', 'Young''s modulus and Poisson''s ratio');
model.material('mat2').label('Concrete');
model.material('mat2').set('family', 'concrete');
model.material('mat2').propertyGroup('def').set('thermalexpansioncoefficient', {'10e-6[1/K]' '0' '0' '0' '10e-6[1/K]' '0' '0' '0' '10e-6[1/K]'});
model.material('mat2').propertyGroup('def').set('density', '2300[kg/m^3]');
model.material('mat2').propertyGroup('def').set('thermalconductivity', {'1.8[W/(m*K)]' '0' '0' '0' '1.8[W/(m*K)]' '0' '0' '0' '1.8[W/(m*K)]'});
model.material('mat2').propertyGroup('def').set('heatcapacity', '880[J/(kg*K)]');
model.material('mat2').propertyGroup('Enu').set('E', '25[GPa]');
model.material('mat2').propertyGroup('Enu').set('nu', '0.20');
model.material('mat2').selection.set([1]);

model.physics('tcd').selection.set([1]);
model.physics('tcd').feature('ice1').set('D_c', {'D_O2(PS)' '0' '0' '0' 'D_O2(PS)' '0' '0' '0' 'D_O2(PS)'});
model.physics('tcd').feature('ice1').set('sigmal_mat', 'userdef');
model.physics('tcd').feature('ice1').set('sigmal', {'sigma(PS)' '0' '0' '0' 'sigma(PS)' '0' '0' '0' 'sigma(PS)'});
model.physics('tcd').create('conc1', 'Concentration', 1);
model.physics('tcd').feature('conc1').selection.set([1]);
model.physics('tcd').feature('conc1').setIndex('species', true, 0);
model.physics('tcd').feature('conc1').setIndex('c0', 'C_O2_ref', 0);
model.physics('tcd').create('es1', 'ElectrodeSurface', 1);
model.physics('tcd').feature('es1').selection.set([5 6 7 8]);
model.physics('tcd').feature('es1').setIndex('Species', 's1', 0, 0);
model.physics('tcd').feature('es1').setIndex('rhos', 8960, 0, 0);
model.physics('tcd').feature('es1').setIndex('Ms', 0.06355, 0, 0);
model.physics('tcd').feature('es1').setIndex('Species', 's1', 0, 0);
model.physics('tcd').feature('es1').setIndex('rhos', 8960, 0, 0);
model.physics('tcd').feature('es1').setIndex('Ms', 0.06355, 0, 0);
model.physics('tcd').feature('es1').setIndex('Species', 'oxide', 0, 0);
model.physics('tcd').feature('es1').setIndex('rhos', 'rho_oxide', 0, 0);
model.physics('tcd').feature('es1').setIndex('Ms', 'M_oxide', 0, 0);
model.physics('tcd').feature('es1').setIndex('Species', 's1', 1, 0);
model.physics('tcd').feature('es1').setIndex('rhos', 8960, 1, 0);
model.physics('tcd').feature('es1').setIndex('Ms', 0.06355, 1, 0);
model.physics('tcd').feature('es1').setIndex('rhos', 8960, 1, 0);
model.physics('tcd').feature('es1').setIndex('Ms', 0.06355, 1, 0);
model.physics('tcd').feature('es1').setIndex('Species', 's1', 1, 0);
model.physics('tcd').feature('es1').setIndex('rhos', 8960, 1, 0);
model.physics('tcd').feature('es1').setIndex('Ms', 0.06355, 1, 0);
model.physics('tcd').feature('es1').setIndex('Species', 'Fe', 1, 0);
model.physics('tcd').feature('es1').setIndex('rhos', 'rho_Fe', 1, 0);
model.physics('tcd').feature('es1').setIndex('Ms', 'M_Fe', 1, 0);
model.physics('tcd').feature('es1').feature('er1').label('Oxygen reduction');
model.physics('tcd').feature('es1').feature('er1').set('nm', 4);
model.physics('tcd').feature('es1').feature('er1').setIndex('Vi0', -1, 0);
model.physics('tcd').feature('es1').feature('er1').set('Eeq_mat', 'userdef');
model.physics('tcd').feature('es1').feature('er1').set('Eeq', 'Eeq_O2');
model.physics('tcd').feature('es1').feature('er1').set('ElectrodeKinetics', 'CathodicTafelEquation');
model.physics('tcd').feature('es1').feature('er1').set('i0', 'c/C_O2_ref*i0_O2');
model.physics('tcd').feature('es1').feature('er1').set('Ac', 'A_O2');
model.physics('tcd').feature('es1').create('er2', 'ElectrodeReaction', 1);
model.physics('tcd').feature('es1').feature('er2').label('Iron oxidation');
model.physics('tcd').feature('es1').feature('er2').set('nm', 4);
model.physics('tcd').feature('es1').feature('er2').setIndex('Vi0', 0.5, 0);
model.physics('tcd').feature('es1').feature('er2').setIndex('Vib', -1, 0, 0);
model.physics('tcd').feature('es1').feature('er2').setIndex('Vib', 2, 1, 0);
model.physics('tcd').feature('es1').feature('er2').set('Eeq_mat', 'userdef');
model.physics('tcd').feature('es1').feature('er2').set('Eeq', 'Eeq_Fe');
model.physics('tcd').feature('es1').feature('er2').set('ElectrodeKinetics', 'AnodicTafelEquation');
model.physics('tcd').feature('es1').feature('er2').set('i0', 'i0_Fe');
model.physics('tcd').feature('es1').feature('er2').set('Aa', 'A_Fe');
model.physics('tcd').feature('es1').create('er3', 'ElectrodeReaction', 1);
model.physics('tcd').feature('es1').feature('er3').label('Hydrogen evolution');
model.physics('tcd').feature('es1').feature('er3').set('Eeq_mat', 'userdef');
model.physics('tcd').feature('es1').feature('er3').set('Eeq', 'Eeq_H2');
model.physics('tcd').feature('es1').feature('er3').set('ElectrodeKinetics', 'CathodicTafelEquation');
model.physics('tcd').feature('es1').feature('er3').set('i0', 'i0_H2');
model.physics('tcd').feature('es1').feature('er3').set('Ac', 'A_H2');
model.physics('tcd').feature('init1').setIndex('initc', 'C_O2_ref', 0);
model.physics('solid').feature('lemm1').create('iss1', 'InitialStressandStrain', 2);
model.physics('solid').feature('lemm1').feature('iss1').set('eil', {'e_init' '0' '0' '0' 'e_init' '0' '0' '0' '0'});
model.physics('solid').create('lemm2', 'LinearElasticModel', 2);
model.physics('solid').feature('lemm2').selection.set([1]);
model.physics('solid').feature('lemm2').create('dmg1', 'Damage', 2);
model.physics('solid').feature('lemm2').feature('dmg1').set('sigmap_mat', 'userdef');
model.physics('solid').feature('lemm2').feature('dmg1').set('sigmap', 'sigmap');
model.physics('solid').feature('lemm2').feature('dmg1').set('Gf_mat', 'userdef');
model.physics('solid').feature('lemm2').feature('dmg1').set('Gf', 'Gf');
model.physics('solid').feature('lemm2').feature('dmg1').set('regType', 'impGradient');
model.physics('solid').feature('lemm2').feature('dmg1').set('lint', 'lint');
model.physics('solid').feature('lemm2').feature('dmg1').set('hdmg', 'hdmg');
model.physics('solid').create('roll1', 'Roller', 1);
model.physics('solid').feature('roll1').selection.set([1 2]);

model.mesh('mesh1').create('size1', 'Size');
model.mesh('mesh1').feature('size1').selection.geom('geom1', 2);
model.mesh('mesh1').feature('size1').selection.set([5]);
model.mesh('mesh1').feature('size1').set('hauto', 2);
model.mesh('mesh1').create('ftri1', 'FreeTri');
model.mesh('mesh1').run;

model.study('std1').feature('time').set('tunit', 'd');
model.study('std1').feature('time').set('tlist', 'range(0,25,1500)');

model.sol.create('sol1');
model.sol('sol1').study('std1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'time');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').feature('comp1_solid_eeqnl').set('scalemethod', 'manual');
model.sol('sol1').feature('v1').feature('comp1_phil').set('scalemethod', 'manual');
model.sol('sol1').feature('v1').feature('comp1_u').set('scalemethod', 'manual');
model.sol('sol1').feature('v1').feature('comp1_solid_eeqnl').set('scaleval', '1e-3');
model.sol('sol1').feature('v1').feature('comp1_phil').set('scaleval', '1');
model.sol('sol1').feature('v1').feature('comp1_u').set('scaleval', '1e-2*0.14142135623730953');
model.sol('sol1').feature('v1').set('control', 'time');
model.sol('sol1').create('t1', 'Time');
model.sol('sol1').feature('t1').set('tlist', 'range(0,25,1500)');
model.sol('sol1').feature('t1').set('plot', 'off');
model.sol('sol1').feature('t1').set('plotgroup', 'Default');
model.sol('sol1').feature('t1').set('plotfreq', 'tout');
model.sol('sol1').feature('t1').set('probesel', 'all');
model.sol('sol1').feature('t1').set('probes', {});
model.sol('sol1').feature('t1').set('probefreq', 'tsteps');
model.sol('sol1').feature('t1').set('rtol', 0.001);
model.sol('sol1').feature('t1').set('atolglobalvaluemethod', 'factor');
model.sol('sol1').feature('t1').set('eventout', true);
model.sol('sol1').feature('t1').set('reacf', true);
model.sol('sol1').feature('t1').set('storeudot', true);
model.sol('sol1').feature('t1').set('endtimeinterpolation', true);
model.sol('sol1').feature('t1').set('maxorder', 2);
model.sol('sol1').feature('t1').set('control', 'time');
model.sol('sol1').feature('t1').feature('aDef').set('cachepattern', true);
model.sol('sol1').feature('t1').create('seDef', 'Segregated');
model.sol('sol1').feature('t1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('t1').feature('fc1').set('dtech', 'auto');
model.sol('sol1').feature('t1').feature('fc1').set('damp', 1);
model.sol('sol1').feature('t1').feature('fc1').set('jtech', 'onevery');
model.sol('sol1').feature('t1').feature('fc1').set('ntermconst', 'tol');
model.sol('sol1').feature('t1').feature('fc1').set('maxiter', 4);
model.sol('sol1').feature('t1').feature('fc1').set('ntolfact', 1);
model.sol('sol1').feature('t1').create('d1', 'Direct');
model.sol('sol1').feature('t1').feature('d1').label('Direct (Merged)');
model.sol('sol1').feature('t1').create('i1', 'Iterative');
model.sol('sol1').feature('t1').feature('i1').set('maxlinit', 1000);
model.sol('sol1').feature('t1').feature('i1').set('nlinnormuse', 'on');
model.sol('sol1').feature('t1').feature('i1').label('Algebraic Multigrid (tcd)');
model.sol('sol1').feature('t1').feature('i1').create('mg1', 'Multigrid');
model.sol('sol1').feature('t1').feature('i1').feature('mg1').set('prefun', 'saamg');
model.sol('sol1').feature('t1').feature('i1').feature('mg1').set('maxcoarsedof', 50000);
model.sol('sol1').feature('t1').feature('i1').feature('mg1').set('saamgcompwise', true);
model.sol('sol1').feature('t1').feature('i1').feature('mg1').set('compactaggregation', true);
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('pr').create('sl1', 'SORLine');
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('po').create('sl1', 'SORLine');
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('cs').create('d1', 'Direct');
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('cs').feature('d1').set('linsolver', 'pardiso');
model.sol('sol1').feature('t1').create('i2', 'Iterative');
model.sol('sol1').feature('t1').feature('i2').set('maxlinit', 1000);
model.sol('sol1').feature('t1').feature('i2').set('nlinnormuse', 'on');
model.sol('sol1').feature('t1').feature('i2').label('Geometric Multigrid (tcd)');
model.sol('sol1').feature('t1').feature('i2').create('mg1', 'Multigrid');
model.sol('sol1').feature('t1').feature('i2').feature('mg1').feature('pr').create('sl1', 'SORLine');
model.sol('sol1').feature('t1').feature('i2').feature('mg1').feature('po').create('sl1', 'SORLine');
model.sol('sol1').feature('t1').feature('i2').feature('mg1').feature('cs').create('d1', 'Direct');
model.sol('sol1').feature('t1').feature('i2').feature('mg1').feature('cs').feature('d1').set('linsolver', 'pardiso');
model.sol('sol1').feature('t1').feature('fc1').set('linsolver', 'd1');
model.sol('sol1').feature('t1').feature('fc1').set('dtech', 'auto');
model.sol('sol1').feature('t1').feature('fc1').set('damp', 1);
model.sol('sol1').feature('t1').feature('fc1').set('jtech', 'onevery');
model.sol('sol1').feature('t1').feature('fc1').set('ntermconst', 'tol');
model.sol('sol1').feature('t1').feature('fc1').set('maxiter', 4);
model.sol('sol1').feature('t1').feature('fc1').set('ntolfact', 1);
model.sol('sol1').feature('t1').feature.remove('fcDef');
model.sol('sol1').feature('t1').feature.remove('seDef');
model.sol('sol1').attach('std1');
model.sol('sol1').feature('t1').set('tstepsbdf', 'strict');
model.sol('sol1').feature('t1').set('maxstepconstraintbdf', 'const');
model.sol('sol1').feature('t1').set('maxstepbdf', 10);
model.sol('sol1').feature('t1').feature('fc1').set('dtech', 'const');
model.sol('sol1').feature('t1').feature('fc1').set('maxiter', 12);
model.sol('sol1').runAll;

model.result.create('pg1', 'PlotGroup2D');
model.result('pg1').set('data', 'dset1');
model.result('pg1').setIndex('looplevel', 61, 0);
model.result('pg1').label('Electrolyte Potential (tcd)');
model.result('pg1').create('surf1', 'Surface');
model.result('pg1').feature('surf1').set('expr', {'phil'});
model.result('pg1').create('str1', 'Streamline');
model.result('pg1').feature('str1').set('expr', {'tcd.Ilx' 'tcd.Ily'});
model.result('pg1').feature('str1').set('posmethod', 'uniform');
model.result('pg1').feature('str1').set('recover', 'pprint');
model.result('pg1').feature('str1').set('pointtype', 'arrow');
model.result('pg1').feature('str1').set('arrowlength', 'logarithmic');
model.result('pg1').feature('str1').set('color', 'gray');
model.result.create('pg2', 'PlotGroup2D');
model.result('pg2').set('data', 'dset1');
model.result('pg2').setIndex('looplevel', 61, 0);
model.result('pg2').label('Electrolyte Current Density (tcd)');
model.result('pg2').create('str1', 'Streamline');
model.result('pg2').feature('str1').set('expr', {'tcd.Ilx' 'tcd.Ily'});
model.result('pg2').feature('str1').set('posmethod', 'uniform');
model.result('pg2').feature('str1').set('recover', 'pprint');
model.result('pg2').feature('str1').set('pointtype', 'arrow');
model.result('pg2').feature('str1').set('arrowlength', 'logarithmic');
model.result('pg2').feature('str1').set('color', 'gray');
model.result('pg2').feature('str1').create('col1', 'Color');
model.result('pg2').feature('str1').feature('col1').set('expr', 'root.comp1.tcd.IlMag');
model.result('pg2').create('line1', 'Line');
model.result('pg2').feature('line1').set('expr', {'abs(tcd.itot)'});
model.result('pg2').feature('line1').set('linetype', 'tube');
model.result('pg2').feature('line1').set('inherittubescale', false);
model.result('pg2').feature('line1').set('inheritplot', 'str1');
model.result.create('pg3', 'PlotGroup2D');
model.result('pg3').set('data', 'dset1');
model.result('pg3').setIndex('looplevel', 61, 0);
model.result('pg3').label('Electrode Potential vs. Adjacent Reference (tcd)');
model.result('pg3').create('str1', 'Streamline');
model.result('pg3').feature('str1').set('expr', {'tcd.Ilx' 'tcd.Ily'});
model.result('pg3').feature('str1').set('posmethod', 'uniform');
model.result('pg3').feature('str1').set('recover', 'pprint');
model.result('pg3').feature('str1').set('pointtype', 'arrow');
model.result('pg3').feature('str1').set('arrowlength', 'logarithmic');
model.result('pg3').feature('str1').set('color', 'gray');
model.result('pg3').create('line1', 'Line');
model.result('pg3').feature('line1').set('expr', {'tcd.Evsref'});
model.result('pg3').feature('line1').set('linetype', 'tube');
model.result('pg3').feature('line1').set('inherittubescale', false);
model.result.create('pg4', 'PlotGroup2D');
model.result('pg4').set('data', 'dset1');
model.result('pg4').setIndex('looplevel', 61, 0);
model.result('pg4').label('Total Electrode Thickness Change (tcd)');
model.result('pg4').create('line1', 'Line');
model.result('pg4').feature('line1').set('expr', {'tcd.sbtot'});
model.result('pg4').feature('line1').set('linetype', 'tube');
model.result('pg4').feature('line1').set('inherittubescale', false);
model.result('pg4').feature('line1').set('unit', [native2unicode(hex2dec({'00' 'b5'}), 'unicode') 'm']);
model.result.create('pg5', 'PlotGroup2D');
model.result('pg5').set('data', 'dset1');
model.result('pg5').setIndex('looplevel', 61, 0);
model.result('pg5').label('Concentration (tcd)');
model.result('pg5').set('titletype', 'custom');
model.result('pg5').set('prefixintitle', '');
model.result('pg5').set('expressionintitle', false);
model.result('pg5').set('typeintitle', true);
model.result('pg5').create('surf1', 'Surface');
model.result('pg5').feature('surf1').set('expr', {'c'});
model.result('pg5').create('str1', 'Streamline');
model.result('pg5').feature('str1').set('expr', {'tcd.tflux_cx' 'tcd.tflux_cy'});
model.result('pg5').feature('str1').set('posmethod', 'uniform');
model.result('pg5').feature('str1').set('recover', 'pprint');
model.result('pg5').feature('str1').set('pointtype', 'arrow');
model.result('pg5').feature('str1').set('arrowlength', 'logarithmic');
model.result('pg5').feature('str1').set('color', 'gray');
model.result.create('pg6', 'PlotGroup2D');
model.result('pg6').set('data', 'dset1');
model.result('pg6').setIndex('looplevel', 61, 0);
model.result('pg6').set('defaultPlotID', 'stress');
model.result('pg6').label('Stress (solid)');
model.result('pg6').set('frametype', 'spatial');
model.result('pg6').create('surf1', 'Surface');
model.result('pg6').feature('surf1').set('expr', {'solid.misesGp'});
model.result('pg6').feature('surf1').set('threshold', 'manual');
model.result('pg6').feature('surf1').set('thresholdvalue', 0.2);
model.result('pg6').feature('surf1').set('colortable', 'Rainbow');
model.result('pg6').feature('surf1').set('colortabletrans', 'none');
model.result('pg6').feature('surf1').set('colorscalemode', 'linear');
model.result('pg6').feature('surf1').set('resolution', 'normal');
model.result('pg6').feature('surf1').set('colortable', 'Prism');
model.result('pg6').feature('surf1').create('def', 'Deform');
model.result('pg6').feature('surf1').feature('def').set('expr', {'u' 'v'});
model.result('pg6').feature('surf1').feature('def').set('descr', 'Displacement field');
model.result('pg1').run;
model.result.create('pg7', 'PlotGroup1D');
model.result('pg7').run;
model.result('pg7').label('Corrosion Product Layer Thickness');
model.result('pg7').setIndex('looplevelinput', 'manual', 0);
model.result('pg7').setIndex('looplevel', [13 25 37 49 61], 0);
model.result('pg7').create('lngr1', 'LineGraph');
model.result('pg7').feature('lngr1').set('markerpos', 'datapoints');
model.result('pg7').feature('lngr1').set('linewidth', 'preference');
model.result('pg7').feature('lngr1').selection.set([5 6 7 8]);
model.result('pg7').feature('lngr1').set('expr', 'tcd.sb_oxide');
model.result('pg7').feature('lngr1').set('descr', 'Electrode thickness change, 1-component');
model.result('pg7').feature('lngr1').set('unit', [native2unicode(hex2dec({'00' 'b5'}), 'unicode') 'm']);
model.result('pg7').feature('lngr1').set('legend', true);
model.result('pg7').run;
model.result('pg6').run;
model.result('pg6').label('First Principal Stress Analysis');
model.result('pg6').run;
model.result('pg6').feature('surf1').set('expr', 'solid.gpeval(solid.sdp1)');
model.result('pg6').feature('surf1').set('colortable', 'Rainbow');
model.result('pg6').run;
model.result('pg6').feature('surf1').feature('def').active(false);
model.result.create('pg8', 'PlotGroup2D');
model.result('pg8').set('data', 'dset1');
model.result('pg8').setIndex('looplevel', 61, 0);
model.result('pg8').label('Damage (solid)');
model.result('pg8').set('defaultPlotID', 'damage');
model.result('pg8').create('surf1', 'Surface');
model.result('pg8').feature('surf1').set('expr', {'solid.dmgGp'});
model.result('pg8').feature('surf1').set('inheritplot', 'none');
model.result('pg8').feature('surf1').set('resolution', 'normal');
model.result('pg8').feature('surf1').set('colortabletype', 'discrete');
model.result('pg8').feature('surf1').set('bandcount', 11);
model.result('pg8').feature('surf1').set('colortable', 'RainbowLight');
model.result('pg8').feature('surf1').set('smooth', 'none');
model.result('pg8').feature('surf1').set('descractive', true);
model.result('pg8').feature('surf1').set('descr', 'Damage');
model.result('pg8').label('Damage (solid)');
model.result('pg8').run;
model.result('pg8').run;
model.result('pg8').feature('surf1').set('colortabletype', 'continuous');
model.result('pg8').run;
model.result.create('pg9', 'PlotGroup2D');
model.result('pg9').run;
model.result('pg9').label('Crack');
model.result('pg9').create('surf1', 'Surface');
model.result('pg9').feature('surf1').set('expr', 'solid.eeqnl');
model.result('pg9').feature('surf1').set('descr', 'Nonlocal equivalent strain');
model.result('pg9').run;

model.title('Oxide Jacking of Reinforced Concrete');

model.description('This example models oxide jacking of reinforced concrete. The corrosion process causes growth of an oxide layer on the rebar, which in turn causes internal stresses in the concrete. Charge and oxygen transport are modeled in the concrete domain, where the electrolyte conductivity and oxygen diffusivity depend on the moisture content. The rebar and concrete surroundings are modeled as linear elastic materials, with initial strains in each time-step based on the thickness of the oxide layer. A crack from the rebar to the outer surface of the concrete is seen after 750 days, compromising the concrete structure.');

model.mesh.clearMeshes;

model.sol('sol1').clearSolutionData;

model.label('oxide_jacking.mph');

model.modelNode.label('Components');

out = model;
