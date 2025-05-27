function out = model
%
% benzoic_acid_crystallization.m
%
% Model exported on May 26 2025, 21:27 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/Chemical_Reaction_Engineering_Module/Mixing_and_Separation');

model.modelNode.create('comp1', true);

model.physics.create('ge', 'GlobalEquations');
model.physics('ge').model('comp1');
model.physics('ge').prop('EquationForm').set('form', 'Automatic');

model.study.create('std1');
model.study('std1').create('stat', 'Stationary');
model.study('std1').feature('stat').setSolveFor('/physics/ge', true);

% To import content from file, use:
% model.param.loadFile('FILENAME');
model.param.set('T', '30[degC]', 'MSMPR operating temperature');
model.param.set('C0', '228[g/kg]', 'Feed solute concentration');
model.param.set('tau', '45 [min]', 'Residence time');
model.param.set('k_v', '0.1', 'Crystal volumetric shape factor');
model.param.set('rho_c', '1.32[g/cm^3]', 'Crystal density');
model.param.set('k_b', '9.16e12[(1/(m^3*s))/((g/cm^3)*(g/g))]', 'Nucleation rate coefficient');
model.param.set('E_g', '40.05[kJ/mol]', 'Activation energy for crystal growth');
model.param.set('k_g0', '1.06e7[(um/s)/(g/g)]', 'Pre-exponential factor for growth rate');
model.param.set('g', '0.44', 'Exponent for driving force of crystal growth');
model.param.set('j_const', '1.78', 'Exponent for suspension density effect on nucleation rate');
model.param.set('b', '1.2', 'Exponent for driving force for nucleation');
model.param.set('L_max', '2500[um]', 'Maximum size included in CSD');
model.param.set('L_int', '1[m]', 'Formal integration constant');
model.param('default').paramCase.create('case1');
model.param('default').paramCase('case1').label('Experiment Giving Largest Crystals');
model.param('default').paramCase.create('case2');
model.param('default').paramCase('case2').label('Experiment Giving Smallest Crystals');
model.param('default').paramCase('case2').set('T', '0[degC]');
model.param('default').paramCase('case2').set('tau', '20 [min]');

model.func.create('an1', 'Analytic');
model.func('an1').label('Saturation Mass Fraction');
model.func('an1').set('funcname', 'C_star');
model.func('an1').set('expr', '2.03e-5*T^4 + 2.97e-4*T^3 + 4.70e-2*T^2 + 1.43*T + 24.71');
model.func('an1').set('args', 'T');
model.func('an1').set('fununit', 'g/kg');
model.func('an1').setIndex('argunit', 'degC', 0);
model.func('an1').setIndex('plotargs', '-15[degC]', 0, 1);
model.func('an1').setIndex('plotargs', '40[degC]', 0, 2);
model.func('an1').createPlot('pg1');

model.result('pg1').run;
model.result('pg1').label('Saturation Mass Fraction');
model.result('pg1').set('title', 'Saturation Mass Fraction');
model.result('pg1').set('ylabelactive', true);
model.result('pg1').set('ylabel', 'C<sup>*</sup>(T) (g/kg)');
model.result('pg1').run;

model.variable.create('var1');
model.variable('var1').model('comp1');

% To import content from file, use:
% model.variable('var1').loadFile('FILENAME');
model.variable('var1').set('M_T_MB', 'C0-C', 'MSMPR crystal weight fraction, from mass balance');
model.variable('var1').set('M_T_MR', '6 * k_v * rho_c * n0 * (G * tau)^4', 'MSMPR crystal weight fraction, from moment relation');
model.variable('var1').set('n0', 'B0/G', 'Nuclei population density');
model.variable('var1').set('B0', 'k_b * M_T_MB^j_const * DeltaC^b', 'Nucleation rate at steady-state');
model.variable('var1').set('DeltaC', 'C - C_star(T)', 'Driving force for crystallization');
model.variable('var1').set('G', 'k_g * DeltaC^g', 'Crystal growth rate at steady-state');
model.variable('var1').set('k_g', 'k_g0*exp(-E_g/(R_const*T))', 'Crystal growth rate coefficient');

model.physics('ge').feature('ge1').setIndex('name', 'C', 0, 0);
model.physics('ge').feature('ge1').setIndex('equation', 'M_T_MB-M_T_MR', 0, 0);
model.physics('ge').feature('ge1').setIndex('initialValueU', 'C_star(T)+1[g/kg]', 0, 0);
model.physics('ge').feature('ge1').setIndex('description', 'Benzoic acid mass fraction', 0, 0);
model.physics('ge').feature('ge1').set('CustomDependentVariableUnit', '1');
model.physics('ge').feature('ge1').set('DependentVariableQuantity', 'none');
model.physics('ge').feature('ge1').setIndex('CustomDependentVariableUnit', 'g/kg', 0, 0);
model.physics('ge').feature('ge1').set('CustomSourceTermUnit', '1');
model.physics('ge').feature('ge1').set('SourceTermQuantity', 'none');
model.physics('ge').feature('ge1').setIndex('CustomSourceTermUnit', 'g/kg', 0, 0);

model.study('std1').label('Study 1: Extreme Cases');
model.study('std1').create('param', 'Parametric');
model.study('std1').feature('param').set('sweeptype', 'switch');
model.study('std1').feature('param').setIndex('switchname', 'default', 0);
model.study('std1').feature('param').setIndex('switchcase', 'all', 0);
model.study('std1').feature('param').setIndex('switchlistarr', 'range(1,1,2)', 0);
model.study('std1').feature('param').setIndex('switchname', 'default', 0);
model.study('std1').feature('param').setIndex('switchcase', 'all', 0);
model.study('std1').feature('param').setIndex('switchlistarr', 'range(1,1,2)', 0);

model.sol.create('sol1');
model.sol('sol1').study('std1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'stat');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').set('control', 'stat');
model.sol('sol1').create('s1', 'Stationary');
model.sol('sol1').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('s1').feature('fc1').set('linsolver', 'dDef');
model.sol('sol1').feature('s1').feature.remove('fcDef');
model.sol('sol1').attach('std1');

model.batch.create('p1', 'Parametric');
model.batch('p1').study('std1');
model.batch('p1').create('so1', 'Solutionseq');
model.batch('p1').feature('so1').set('seq', 'sol1');
model.batch('p1').feature('so1').set('store', 'on');
model.batch('p1').feature('so1').set('clear', 'on');
model.batch('p1').feature('so1').set('psol', 'none');
model.batch('p1').set('pname', {});
model.batch('p1').set('plistarr', {});
model.batch('p1').set('sweeptype', 'switch');
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

model.result.numerical.create('gev1', 'EvalGlobal');
model.result.numerical('gev1').set('data', 'dset2');
model.result.numerical('gev1').set('expr', {'C'});
model.result.numerical('gev1').set('descr', {'Benzoic acid mass fraction'});
model.result.dataset.create('grid1', 'Grid1D');
model.result.dataset('grid1').set('source', 'data');
model.result.dataset('grid1').label('Grid 1D: Extreme Cases');
model.result.dataset('grid1').set('par1', 'L');
model.result.dataset('grid1').set('data', 'dset2');
model.result.dataset('grid1').set('parmax1', 'L_max');
model.result.create('pg2', 'PlotGroup1D');
model.result('pg2').run;
model.result('pg2').label('CSD for Extreme Cases');
model.result('pg2').set('data', 'grid1');
model.result('pg2').set('titletype', 'manual');
model.result('pg2').set('title', 'Volume-based Mean Crystal Size Distribution');
model.result('pg2').set('ylabelactive', true);
model.result('pg2').set('ylabel', 'Crystal Size Distribution (%)');
model.result('pg2').set('xlog', true);
model.result('pg2').set('legendpos', 'upperleft');
model.result('pg2').create('lngr1', 'LineGraph');
model.result('pg2').feature('lngr1').set('markerpos', 'datapoints');
model.result('pg2').feature('lngr1').set('linewidth', 'preference');
model.result('pg2').feature('lngr1').set('expr', '(n0 * exp(- L / (G*tau))*L^4)/ integrate((n0 * exp(- L / (G*tau)))*L^3, L, 0, L_max)');
model.result('pg2').feature('lngr1').set('unit', '%');
model.result('pg2').feature('lngr1').set('xdata', 'expr');
model.result('pg2').feature('lngr1').set('xdataexpr', 'L');
model.result('pg2').feature('lngr1').set('xdataunit', [native2unicode(hex2dec({'00' 'b5'}), 'unicode') 'm']);
model.result('pg2').feature('lngr1').set('xdatadescractive', true);
model.result('pg2').feature('lngr1').set('xdatadescr', 'Crystal size');
model.result('pg2').feature('lngr1').set('legend', true);
model.result('pg2').feature('lngr1').set('legendmethod', 'manual');
model.result('pg2').feature('lngr1').setIndex('legends', 'T =20\deg C, \tau = 45 min', 0);
model.result('pg2').feature('lngr1').setIndex('legends', 'T = 0\deg C, \tau = 15 min', 1);
model.result('pg2').run;
model.result('pg2').feature('lngr1').create('gmrk1', 'GraphMarker');
model.result('pg2').feature('lngr1').feature('gmrk1').set('linewidth', 'preference');
model.result('pg2').run;
model.result('pg2').feature('lngr1').feature('gmrk1').set('precision', 3);
model.result('pg2').feature('lngr1').feature('gmrk1').set('inclxcoord', true);
model.result('pg2').feature('lngr1').feature('gmrk1').set('inclycoord', false);
model.result('pg2').feature('lngr1').feature('gmrk1').set('anchorpoint', 'lowermiddle');
model.result('pg2').run;
model.result('pg2').run;
model.result('pg2').set('axislimits', true);
model.result('pg2').set('xmin', 10);
model.result('pg2').set('ymax', 90);
model.result('pg2').run;

model.study.create('std2');
model.study('std2').create('stat', 'Stationary');
model.study('std2').feature('stat').setSolveFor('/physics/ge', true);
model.study('std2').label('Study 2: Temperature Sweep');
model.study('std2').feature('stat').set('useparam', true);
model.study('std2').feature('stat').setIndex('pname', 'T', 0);
model.study('std2').feature('stat').setIndex('plistarr', '', 0);
model.study('std2').feature('stat').setIndex('punit', 'K', 0);
model.study('std2').feature('stat').setIndex('pname', 'T', 0);
model.study('std2').feature('stat').setIndex('plistarr', '', 0);
model.study('std2').feature('stat').setIndex('punit', 'K', 0);
model.study('std2').feature('stat').setIndex('plistarr', 'range(0,1,30)', 0);
model.study('std2').feature('stat').setIndex('punit', 'degC', 0);

model.sol.create('sol5');
model.sol('sol5').study('std2');
model.sol('sol5').create('st1', 'StudyStep');
model.sol('sol5').feature('st1').set('study', 'std2');
model.sol('sol5').feature('st1').set('studystep', 'stat');
model.sol('sol5').create('v1', 'Variables');
model.sol('sol5').feature('v1').set('control', 'stat');
model.sol('sol5').create('s1', 'Stationary');
model.sol('sol5').feature('s1').create('p1', 'Parametric');
model.sol('sol5').feature('s1').feature.remove('pDef');
model.sol('sol5').feature('s1').feature('p1').set('control', 'stat');
model.sol('sol5').feature('s1').set('control', 'stat');
model.sol('sol5').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol5').feature('s1').feature('fc1').set('linsolver', 'dDef');
model.sol('sol5').feature('s1').feature.remove('fcDef');
model.sol('sol5').attach('std2');
model.sol('sol5').feature('s1').set('stol', '0.0001');
model.sol('sol5').runAll;

model.result.numerical.create('gev2', 'EvalGlobal');
model.result.numerical('gev2').set('data', 'dset3');
model.result.numerical('gev2').set('expr', {'C'});
model.result.numerical('gev2').set('descr', {'Benzoic acid mass fraction'});
model.result.dataset.duplicate('grid2', 'grid1');
model.result.dataset('grid2').label('Grid 1D: Temperature Sweep');
model.result.dataset('grid2').set('data', 'dset3');
model.result('pg2').run;
model.result.duplicate('pg3', 'pg2');
model.result('pg3').run;
model.result('pg3').label('CSD for Temperature Sweep');
model.result('pg3').set('data', 'grid2');
model.result('pg3').setIndex('looplevelinput', 'manual', 0);
model.result('pg3').setIndex('looplevel', [1 16 31], 0);
model.result('pg3').run;
model.result('pg3').feature('lngr1').set('legendmethod', 'automatic');
model.result('pg3').run;
model.result('pg3').run;

model.study.create('std3');
model.study('std3').create('stat', 'Stationary');
model.study('std3').feature('stat').setSolveFor('/physics/ge', true);
model.study('std3').label('Study 3: Residence Time Sweep');
model.study('std3').feature('stat').set('useparam', true);
model.study('std3').feature('stat').setIndex('pname', 'T', 0);
model.study('std3').feature('stat').setIndex('plistarr', '', 0);
model.study('std3').feature('stat').setIndex('punit', 'K', 0);
model.study('std3').feature('stat').setIndex('pname', 'T', 0);
model.study('std3').feature('stat').setIndex('plistarr', '', 0);
model.study('std3').feature('stat').setIndex('punit', 'K', 0);
model.study('std3').feature('stat').setIndex('pname', 'tau', 0);
model.study('std3').feature('stat').setIndex('plistarr', 'range(15,1,45)', 0);
model.study('std3').feature('stat').setIndex('punit', 'min', 0);

model.sol.create('sol6');
model.sol('sol6').study('std3');
model.sol('sol6').create('st1', 'StudyStep');
model.sol('sol6').feature('st1').set('study', 'std3');
model.sol('sol6').feature('st1').set('studystep', 'stat');
model.sol('sol6').create('v1', 'Variables');
model.sol('sol6').feature('v1').set('control', 'stat');
model.sol('sol6').create('s1', 'Stationary');
model.sol('sol6').feature('s1').create('p1', 'Parametric');
model.sol('sol6').feature('s1').feature.remove('pDef');
model.sol('sol6').feature('s1').feature('p1').set('control', 'stat');
model.sol('sol6').feature('s1').set('control', 'stat');
model.sol('sol6').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol6').feature('s1').feature('fc1').set('linsolver', 'dDef');
model.sol('sol6').feature('s1').feature.remove('fcDef');
model.sol('sol6').attach('std3');
model.sol('sol6').runAll;

model.result.numerical.create('gev3', 'EvalGlobal');
model.result.numerical('gev3').set('data', 'dset4');
model.result.numerical('gev3').set('expr', {'C'});
model.result.numerical('gev3').set('descr', {'Benzoic acid mass fraction'});
model.result.dataset.duplicate('grid3', 'grid2');
model.result.dataset('grid3').label('Grid 1D: Residence Time Sweep');
model.result.dataset('grid3').set('data', 'dset4');
model.result('pg3').run;
model.result.duplicate('pg4', 'pg3');
model.result('pg4').run;
model.result('pg4').label('CSD for Residence Time Sweep');
model.result('pg4').set('data', 'grid3');
model.result('pg4').run;
model.result('pg4').feature('lngr1').feature('gmrk1').set('orientation', 'vertical');
model.result('pg4').feature('lngr1').feature('gmrk1').set('anchorpoint', 'middleleft');
model.result('pg4').run;
model.result.create('pg5', 'PlotGroup1D');
model.result('pg5').run;
model.result('pg5').label('Mean Particle Size for Different Operating Temperatures');
model.result('pg5').set('data', 'dset3');
model.result('pg5').set('legendpos', 'upperleft');
model.result('pg5').create('glob1', 'Global');
model.result('pg5').feature('glob1').set('markerpos', 'datapoints');
model.result('pg5').feature('glob1').set('linewidth', 'preference');
model.result('pg5').feature('glob1').setIndex('expr', 'integrate(n0 * exp(- L_int / (G*tau))*L_int^4, L_int, 0, L_max) / integrate((n0 * exp(- L_int / (G*tau)))*L_int^3, L_int, 0, L_max)', 0);
model.result('pg5').feature('glob1').setIndex('unit', 'um', 0);
model.result('pg5').feature('glob1').setIndex('descr', 'Mean Particle Size', 0);
model.result('pg5').feature('glob1').set('xdata', 'expr');
model.result('pg5').feature('glob1').set('xdataexpr', 'T');
model.result('pg5').feature('glob1').set('xdataunit', 'degC');
model.result('pg5').run;
model.result('pg5').run;
model.result.duplicate('pg6', 'pg5');
model.result('pg6').run;
model.result('pg6').label('Mean Particle Size for Different Residence Times');
model.result('pg6').set('data', 'dset4');
model.result('pg6').run;
model.result('pg6').feature('glob1').set('xdataexpr', 'tau');
model.result('pg6').feature('glob1').set('xdataunit', 'min');
model.result('pg6').run;

model.title('Crystallization of Benzoic Acid in a Mixed Suspension, Mixed Product Removal Crystallizer');

model.description('Crystallization is a key separation process in e.g. pharmaceuticals production. It is the process by which a chemical species is separated from solution by forming a crystal. To achieve the required product properties, control over the crystal particle size distribution is necessary. This 0D model implements a population balance equation to determine the crystal size distribution and mean particle size for benzoic acid crystallizing in a mixed-suspension, mixed-product-removal crystallizer.');

model.mesh.clearMeshes;

model.sol('sol1').clearSolutionData;
model.sol('sol2').clearSolutionData;
model.sol('sol3').clearSolutionData;
model.sol('sol4').clearSolutionData;
model.sol('sol5').clearSolutionData;
model.sol('sol6').clearSolutionData;

model.label('benzoic_acid_crystallization.mph');

model.modelNode.label('Components');

out = model;
