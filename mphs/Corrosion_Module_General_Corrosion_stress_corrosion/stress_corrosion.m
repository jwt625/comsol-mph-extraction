function out = model
%
% stress_corrosion.m
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

model.physics.create('solid', 'SolidMechanics', 'geom1');
model.physics('solid').model('comp1');
model.physics.create('cd', 'SecondaryCurrentDistribution', 'geom1');
model.physics('cd').model('comp1');

model.study.create('std1');
model.study('std1').create('stat', 'Stationary');
model.study('std1').feature('stat').setSolveFor('/physics/solid', true);
model.study('std1').feature('stat').setSolveFor('/physics/cd', true);

model.geom('geom1').create('r1', 'Rectangle');
model.geom('geom1').feature('r1').set('size', {'2' '19.1[mm]'});
model.geom('geom1').run('r1');
model.geom('geom1').create('e1', 'Ellipse');
model.geom('geom1').feature('e1').set('semiaxes', {'100[mm]' '11.46[mm]'});
model.geom('geom1').feature('e1').set('pos', {'1' '19.1[mm]'});
model.geom('geom1').run('e1');
model.geom('geom1').create('dif1', 'Difference');
model.geom('geom1').feature('dif1').selection('input').set({'r1'});
model.geom('geom1').feature('dif1').selection('input2').set({'e1'});
model.geom('geom1').run('dif1');
model.geom('geom1').create('r2', 'Rectangle');
model.geom('geom1').feature('r2').set('size', [2 1]);
model.geom('geom1').runPre('fin');

% To import content from file, use:
% model.param.loadFile('FILENAME');
model.param.set('disp', '0.004[m]', 'Displacement');
model.param.set('Eeq0a', '-0.859[V]', 'Equilibrium potential for iron dissolution vs SCE in absence of stress');
model.param.set('Eeq0c', '-0.644[V]', 'Equilibrium potential for hydrogen evolution vs SCE in absence of stress');
model.param.set('i0a', '2.353e-3[A/m^2]', 'Exchange current density for iron dissolution');
model.param.set('ba', '118[mV]', 'Tafel slope for iron dissolution');
model.param.set('i0c', '1.457e-2[A/m^2]', 'Exchange current density for hydrogen evolution');
model.param.set('bc', '-207[mV]', 'Tafel slope for hydrogen evolution');
model.param.set('deltaPm', '806e6[Pa]/3', 'Excess pressure to elastic deformation');
model.param.set('Vm', '7.13e-6[m^3/mol]', 'Molar volume of steel');
model.param.set('zm', '2', 'Charge number');
model.param.set('T', '298.15[K]', 'Temperature');
model.param.set('nu', '0.45', 'Orientation dependent factor');
model.param.set('alpha', '1.67e11[1/cm^2]', 'Coefficient');
model.param.set('N0', '1e8[1/cm^2]', 'Initial dislocation density');
model.param.set('deltaEeqae', '-(deltaPm*Vm/(zm*F_const))', 'Change in equilibrium potential due elastic deformation');
model.param.set('sigmal', '0.096[S/m]', 'Electrolyte conductivity');
model.param.set('sigmas', '1e6[S/m]', 'Electrical conductivity');
model.param.set('rho_Fe', '7.87[g/cm^3]', 'Density of iron');
model.param.set('M_Fe', '55.845[g/mol]', 'Molar mass of iron');

model.variable.create('var1');
model.variable('var1').model('comp1');

model.geom('geom1').run;

% To import content from file, use:
% model.variable('var1').loadFile('FILENAME');
model.variable('var1').set('hardening', 'max(0,stress_strain_curve(solid.epe+solid.mises/solid.E)-solid.sigmags)', 'Hardening function');
model.variable('var1').set('deltaEeqap', '-T*R_const/(zm*F_const)*log((nu*alpha*solid.epe)/N0+1)', 'Change in anode equilibrium potential due plastic deformation');
model.variable('var1').set('Eeqa', 'Eeq0a+deltaEeqae+deltaEeqap', 'Anode equilibrium potential including elastic and plastic deformation terms');
model.variable('var1').set('ic', 'i0c*10^(-solid.mises*Vm/(6*F_const*bc))', 'Cathode exchange current density including stress factor');

model.func.create('int1', 'Interpolation');
model.func('int1').model('comp1');
model.func('int1').set('funcname', 'stress_strain_curve');
model.func('int1').set('table', {'0' '100';  ...
'0.003' '800';  ...
'0.004' '810';  ...
'0.01' '830';  ...
'0.02' '850';  ...
'0.03' '855';  ...
'0.04' '860';  ...
'0.05' '855';  ...
'0.06' '845';  ...
'0.07' '830';  ...
'0.08' '805';  ...
'0.09' '780';  ...
'0.1' '750';  ...
'0.12' '650';  ...
'0.14' '530'});
model.func('int1').set('interp', 'piecewisecubic');
model.func('int1').setIndex('argunit', 1, 0);
model.func('int1').setIndex('fununit', 'MPa', 0);

model.physics('solid').selection.set([1]);
model.physics('solid').feature('lemm1').create('plsty1', 'Plasticity', 2);
model.physics('solid').feature('lemm1').feature('plsty1').set('IsotropicHardeningModel', 'HardeningFunction');

model.material.create('mat1', 'Common', 'comp1');
model.material('mat1').propertyGroup.create('Enu', 'Young''s modulus and Poisson''s ratio');
model.material('mat1').propertyGroup.create('Murnaghan', 'Murnaghan');
model.material('mat1').label('High-strength alloy steel');
model.material('mat1').set('family', 'custom');
model.material('mat1').set('customspecular', [0.9803921568627451 0.9803921568627451 0.9803921568627451]);
model.material('mat1').set('customdiffuse', [0.9803921568627451 0.9803921568627451 0.9803921568627451]);
model.material('mat1').set('customambient', [0.5882352941176471 0.5882352941176471 0.5882352941176471]);
model.material('mat1').set('noise', true);
model.material('mat1').set('fresnel', 0.99);
model.material('mat1').set('roughness', 0.12);
model.material('mat1').set('metallic', 0);
model.material('mat1').set('pearl', 0);
model.material('mat1').set('diffusewrap', 0);
model.material('mat1').set('clearcoat', 0);
model.material('mat1').set('reflectance', 0);
model.material('mat1').propertyGroup('def').set('relpermeability', {'1' '0' '0' '0' '1' '0' '0' '0' '1'});
model.material('mat1').propertyGroup('def').set('heatcapacity', '475[J/(kg*K)]');
model.material('mat1').propertyGroup('def').set('thermalconductivity', {'44.5[W/(m*K)]' '0' '0' '0' '44.5[W/(m*K)]' '0' '0' '0' '44.5[W/(m*K)]'});
model.material('mat1').propertyGroup('def').set('electricconductivity', {'4.032e6[S/m]' '0' '0' '0' '4.032e6[S/m]' '0' '0' '0' '4.032e6[S/m]'});
model.material('mat1').propertyGroup('def').set('relpermittivity', {'1' '0' '0' '0' '1' '0' '0' '0' '1'});
model.material('mat1').propertyGroup('def').set('thermalexpansioncoefficient', {'12.3e-6[1/K]' '0' '0' '0' '12.3e-6[1/K]' '0' '0' '0' '12.3e-6[1/K]'});
model.material('mat1').propertyGroup('def').set('density', '7850[kg/m^3]');
model.material('mat1').propertyGroup('Enu').set('E', '200[GPa]');
model.material('mat1').propertyGroup('Enu').set('nu', '0.30');
model.material('mat1').propertyGroup('Murnaghan').set('l', '-300[GPa]');
model.material('mat1').propertyGroup('Murnaghan').set('m', '-620[GPa]');
model.material('mat1').propertyGroup('Murnaghan').set('n', '-720[GPa]');
model.material('mat1').selection.set([1]);
model.material('mat1').propertyGroup.create('ElastoplasticModel', 'Elastoplastic_material_model');
model.material('mat1').propertyGroup('ElastoplasticModel').set('sigmags', {'806[MPa]'});
model.material('mat1').propertyGroup('ElastoplasticModel').set('sigmagh', {'hardening'});
model.material('mat1').propertyGroup('Enu').set('E', {'207[GPa]'});
model.material('mat1').propertyGroup('Enu').set('nu', {'0.33'});

model.physics('solid').feature('init1').set('u', {'0.0001*X' '0' '0'});
model.physics('solid').create('fix1', 'Fixed', 1);
model.physics('solid').feature('fix1').selection.set([1]);
model.physics('solid').create('disp1', 'Displacement1', 1);
model.physics('solid').feature('disp1').selection.set([7]);
model.physics('solid').feature('disp1').setIndex('Direction', 'prescribed', 0);
model.physics('solid').feature('disp1').setIndex('U0', 'disp', 0);
model.physics('solid').create('disp2', 'Displacement1', 1);
model.physics('solid').feature('disp2').selection.set([1]);
model.physics('solid').feature('disp2').setIndex('Direction', 'prescribed', 0);
model.physics('solid').create('fix2', 'Fixed', 0);
model.physics('solid').feature('fix2').selection.set([1]);
model.physics('cd').feature('ice1').set('sigmal_mat', 'userdef');
model.physics('cd').feature('ice1').set('sigmal', {'sigmal' '0' '0' '0' 'sigmal' '0' '0' '0' 'sigmal'});
model.physics('cd').feature('init1').set('phil', '-(Eeq0a+Eeq0c)/2');
model.physics('cd').create('cc1', 'CurrentConductor', 2);
model.physics('cd').feature('cc1').selection.set([1]);
model.physics('cd').feature('cc1').set('sigma_mat', 'userdef');
model.physics('cd').feature('cc1').set('sigma', {'sigmas' '0' '0' '0' 'sigmas' '0' '0' '0' 'sigmas'});
model.physics('cd').create('bei1', 'InternalElectrodeSurface', 1);
model.physics('cd').feature('bei1').selection.set([4 6 9 10]);
model.physics('cd').feature('bei1').feature('er1').set('Eeq', 'Eeqa');
model.physics('cd').feature('bei1').feature('er1').set('ElectrodeKinetics', 'AnodicTafelEquation');
model.physics('cd').feature('bei1').feature('er1').set('i0', 'i0a');
model.physics('cd').feature('bei1').feature('er1').set('Aa', 'ba');
model.physics('cd').feature('bei1').create('er2', 'ElectrodeReaction', 1);
model.physics('cd').feature('bei1').feature('er2').set('Eeq', 'Eeq0c');
model.physics('cd').feature('bei1').feature('er2').set('ElectrodeKinetics', 'CathodicTafelEquation');
model.physics('cd').feature('bei1').feature('er2').set('i0', 'ic');
model.physics('cd').feature('bei1').feature('er2').set('Ac', 'bc');
model.physics('cd').create('egnd1', 'ElectricGround', 1);
model.physics('cd').feature('egnd1').selection.set([1]);

model.mesh('mesh1').create('ftri1', 'FreeTri');
model.mesh('mesh1').feature('ftri1').create('size1', 'Size');
model.mesh('mesh1').feature('ftri1').feature('size1').selection.geom('geom1', 2);
model.mesh('mesh1').feature('ftri1').feature('size1').selection.set([1]);
model.mesh('mesh1').feature('ftri1').feature('size1').set('custom', true);
model.mesh('mesh1').feature('ftri1').feature('size1').set('hmaxactive', true);
model.mesh('mesh1').feature('ftri1').feature('size1').set('hmax', 0.01);
model.mesh('mesh1').feature('ftri1').create('size2', 'Size');
model.mesh('mesh1').feature('ftri1').feature('size2').selection.geom('geom1', 1);
model.mesh('mesh1').feature('ftri1').feature('size2').selection.set([9 10]);
model.mesh('mesh1').feature('ftri1').feature('size2').set('custom', true);
model.mesh('mesh1').feature('ftri1').feature('size2').set('hmaxactive', true);
model.mesh('mesh1').feature('ftri1').feature('size2').set('hmax', 0.001);
model.mesh('mesh1').run;

model.study('std1').label('Study: Stationary Parametric');
model.study('std1').create('param', 'Parametric');
model.study('std1').feature('param').setIndex('pname', 'disp', 0);
model.study('std1').feature('param').setIndex('plistarr', '', 0);
model.study('std1').feature('param').setIndex('punit', 'm', 0);
model.study('std1').feature('param').setIndex('pname', 'disp', 0);
model.study('std1').feature('param').setIndex('plistarr', '', 0);
model.study('std1').feature('param').setIndex('punit', 'm', 0);
model.study('std1').feature('param').setIndex('plistarr', '0.001 0.002 0.003 0.004', 0);
model.study('std1').feature('param').setIndex('punit', 'm', 0);
model.study('std1').feature('stat').setEntry('activate', 'cd', false);
model.study('std1').create('stat2', 'Stationary');
model.study('std1').feature('stat2').setEntry('activate', 'solid', false);

model.sol.create('sol1');
model.sol('sol1').study('std1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'stat');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').set('control', 'stat');
model.sol('sol1').create('s1', 'Stationary');
model.sol('sol1').feature('s1').feature('aDef').set('cachepattern', true);
model.sol('sol1').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('s1').feature('fc1').set('termonres', 'auto');
model.sol('sol1').feature('s1').feature('fc1').set('reserrfact', 1000);
model.sol('sol1').feature('s1').feature('fc1').set('linsolver', 'dDef');
model.sol('sol1').feature('s1').feature('fc1').set('termonres', 'auto');
model.sol('sol1').feature('s1').feature('fc1').set('reserrfact', 1000);
model.sol('sol1').feature('s1').feature.remove('fcDef');
model.sol('sol1').create('su1', 'StoreSolution');
model.sol('sol1').create('st2', 'StudyStep');
model.sol('sol1').feature('st2').set('study', 'std1');
model.sol('sol1').feature('st2').set('studystep', 'stat2');
model.sol('sol1').create('v2', 'Variables');
model.sol('sol1').feature('v2').feature('comp1_phil').set('scalemethod', 'manual');
model.sol('sol1').feature('v2').feature('comp1_phis').set('scalemethod', 'manual');
model.sol('sol1').feature('v2').feature('comp1_phil').set('scaleval', '1');
model.sol('sol1').feature('v2').feature('comp1_phis').set('scaleval', '1');
model.sol('sol1').feature('v2').set('initmethod', 'sol');
model.sol('sol1').feature('v2').set('initsol', 'sol1');
model.sol('sol1').feature('v2').set('notsolmethod', 'sol');
model.sol('sol1').feature('v2').set('notsol', 'sol1');
model.sol('sol1').feature('v2').set('control', 'stat2');
model.sol('sol1').create('s2', 'Stationary');
model.sol('sol1').feature('s2').set('stol', 1.0E-4);
model.sol('sol1').feature('s2').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('s2').feature('fc1').set('dtech', 'auto');
model.sol('sol1').feature('s2').feature('fc1').set('maxiter', 50);
model.sol('sol1').feature('s2').feature('fc1').set('minstep', 1.0E-6);
model.sol('sol1').feature('s2').create('d1', 'Direct');
model.sol('sol1').feature('s2').feature('d1').set('linsolver', 'pardiso');
model.sol('sol1').feature('s2').feature('d1').label('Direct (cd)');
model.sol('sol1').feature('s2').create('i1', 'Iterative');
model.sol('sol1').feature('s2').feature('i1').set('maxlinit', 1000);
model.sol('sol1').feature('s2').feature('i1').set('nlinnormuse', 'on');
model.sol('sol1').feature('s2').feature('i1').label('Algebraic Multigrid (cd)');
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
model.sol('sol1').feature('s2').feature('i2').label('Geometric Multigrid (cd)');
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
model.sol('sol1').feature('s2').feature('fc1').set('maxiter', 50);
model.sol('sol1').feature('s2').feature('fc1').set('minstep', 1.0E-6);
model.sol('sol1').feature('s2').feature.remove('fcDef');
model.sol('sol1').feature('v2').set('notsolnum', 'auto');
model.sol('sol1').feature('v2').set('notsolvertype', 'solnum');
model.sol('sol1').feature('v2').set('solnum', 'auto');
model.sol('sol1').feature('v2').set('solvertype', 'solnum');
model.sol('sol1').attach('std1');

model.batch.create('p1', 'Parametric');
model.batch('p1').study('std1');
model.batch('p1').create('so1', 'Solutionseq');
model.batch('p1').feature('so1').set('seq', 'sol1');
model.batch('p1').feature('so1').set('store', 'on');
model.batch('p1').feature('so1').set('clear', 'on');
model.batch('p1').feature('so1').set('psol', 'none');
model.batch('p1').set('pname', {'disp'});
model.batch('p1').set('plistarr', {'0.001 0.002 0.003 0.004'});
model.batch('p1').set('sweeptype', 'sparse');
model.batch('p1').set('probesel', 'all');
model.batch('p1').set('probes', {});
model.batch('p1').set('plot', 'off');
model.batch('p1').set('err', 'on');
model.batch('p1').attach('std1');
model.batch('p1').set('control', 'param');

model.sol('sol1').feature('s2').set('stol', '0.00001');

model.study('std1').setGenPlots(false);

model.sol.create('sol3');
model.sol('sol3').study('std1');
model.sol('sol3').label('Parametric Solutions 1');

model.batch('p1').feature('so1').set('psol', 'sol3');
model.batch('p1').run('compute');

model.result.create('pg1', 'PlotGroup2D');
model.result('pg1').run;
model.result('pg1').label('Corrosion Potential and von Mises Stress');
model.result('pg1').set('data', 'dset3');
model.result('pg1').create('surf1', 'Surface');
model.result('pg1').feature('surf1').set('expr', 'solid.misesGp');
model.result('pg1').feature('surf1').set('descr', 'von Mises stress');
model.result('pg1').feature('surf1').set('unit', 'MPa');
model.result('pg1').run;
model.result('pg1').create('surf2', 'Surface');
model.result('pg1').feature('surf2').set('expr', '-phil');
model.result('pg1').feature('surf2').set('rangecoloractive', true);
model.result('pg1').feature('surf2').set('rangecolormin', -0.733);
model.result('pg1').feature('surf2').set('rangecolormax', -0.724);
model.result('pg1').feature('surf2').set('colortabletrans', 'reverse');
model.result('pg1').run;
model.result.create('pg2', 'PlotGroup1D');
model.result('pg2').run;
model.result('pg2').label('von Mises Stress, Parametric');
model.result('pg2').set('data', 'dset3');
model.result('pg2').set('xlabelactive', true);
model.result('pg2').set('xlabel', 'Defect length (mm)');
model.result('pg2').create('lngr1', 'LineGraph');
model.result('pg2').feature('lngr1').set('markerpos', 'datapoints');
model.result('pg2').feature('lngr1').set('linewidth', 'preference');
model.result('pg2').feature('lngr1').selection.set([9 10]);
model.result('pg2').feature('lngr1').set('expr', 'solid.misesGp');
model.result('pg2').feature('lngr1').set('descr', 'von Mises stress');
model.result('pg2').feature('lngr1').set('unit', 'MPa');
model.result('pg2').feature('lngr1').set('xdata', 'expr');
model.result('pg2').feature('lngr1').set('xdataexpr', 'x');
model.result('pg2').feature('lngr1').set('xdataunit', 'mm');
model.result('pg2').feature('lngr1').set('linemarker', 'cycle');
model.result('pg2').feature('lngr1').set('markerpos', 'interp');
model.result('pg2').feature('lngr1').set('legend', true);
model.result('pg2').feature('lngr1').set('legendmethod', 'evaluated');
model.result('pg2').feature('lngr1').set('legendpattern', 'eval(disp,mm) mm');
model.result('pg2').run;
model.result('pg2').run;
model.result.duplicate('pg3', 'pg2');
model.result('pg3').run;
model.result('pg3').label('Corrosion Potential, Parametric');
model.result('pg3').set('ylabelactive', true);
model.result('pg3').set('ylabel', 'Corrosion potential (V)');
model.result('pg3').run;
model.result('pg3').feature('lngr1').set('expr', 'cd.Evsref');
model.result('pg3').feature('lngr1').set('descr', 'Electrode potential vs. adjacent reference');
model.result('pg3').run;
model.result('pg3').run;
model.result.duplicate('pg4', 'pg3');
model.result('pg4').run;
model.result('pg4').label('Anodic Current Density, Parametric');
model.result('pg4').set('ylabel', 'Anodic current density (A/m<sup>2</sup>)');
model.result('pg4').run;
model.result('pg4').feature('lngr1').set('expr', 'cd.iloc_er1');
model.result('pg4').feature('lngr1').set('descr', 'Local current density');
model.result('pg4').run;
model.result('pg4').run;
model.result.duplicate('pg5', 'pg4');
model.result('pg5').run;
model.result('pg5').label('Cathodic Current Density, Parametric');
model.result('pg5').set('ylabel', 'Cathodic current density (A/m<sup>2</sup>)');
model.result('pg5').run;
model.result('pg5').feature('lngr1').set('expr', 'cd.iloc_er2');
model.result('pg5').feature('lngr1').set('descr', 'Local current density');
model.result('pg5').run;

model.common.create('free1', 'DeformingDomainDeformedGeometry', 'comp1');
model.common('free1').selection.all;
model.common('free1').set('smoothingType', 'hyperelastic');

model.physics('cd').feature('bei1').setIndex('Species', 's1', 0, 0);
model.physics('cd').feature('bei1').setIndex('rhos', 8960, 0, 0);
model.physics('cd').feature('bei1').setIndex('Ms', 0.06355, 0, 0);
model.physics('cd').feature('bei1').setIndex('Species', 's1', 0, 0);
model.physics('cd').feature('bei1').setIndex('rhos', 8960, 0, 0);
model.physics('cd').feature('bei1').setIndex('Ms', 0.06355, 0, 0);
model.physics('cd').feature('bei1').setIndex('rhos', 'rho_Fe', 0, 0);
model.physics('cd').feature('bei1').setIndex('Ms', 'M_Fe', 0, 0);
model.physics('cd').feature('bei1').feature('er1').setIndex('Vib', 1, 0, 0);

model.multiphysics.create('ndbdg1', 'NonDeformingBoundaryDeformedGeometry', 'geom1', 1);
model.multiphysics('ndbdg1').selection.all;
model.multiphysics('ndbdg1').set('BoundaryCondition', 'ZeroNormalDisplacement');
model.multiphysics.create('desdg1', 'DeformingElectrodeSurfaceDeformedGeometry', 'geom1', 1);
model.multiphysics('desdg1').selection.all;

model.study('std1').feature('stat').setEntry('activate', 'frame:material1', false);
model.study('std1').feature('stat').setEntry('activateCoupling', 'ndbdg1', false);
model.study('std1').feature('stat').setEntry('activateCoupling', 'desdg1', false);
model.study('std1').feature('stat2').setEntry('activate', 'frame:material1', false);
model.study('std1').feature('stat2').setEntry('activateCoupling', 'ndbdg1', false);
model.study('std1').feature('stat2').setEntry('activateCoupling', 'desdg1', false);
model.study.create('std2');
model.study('std2').create('time', 'Transient');
model.study('std2').feature('time').setSolveFor('/physics/solid', true);
model.study('std2').feature('time').setSolveFor('/physics/cd', true);
model.study('std2').feature('time').setSolveFor('/multiphysics/ndbdg1', true);
model.study('std2').feature('time').setSolveFor('/multiphysics/desdg1', true);
model.study('std2').feature('time').set('tunit', 'a');
model.study('std2').feature('time').set('tlist', 'range(0,1,20)');
model.study('std2').feature('time').set('useinitsol', true);
model.study('std2').feature('time').set('initmethod', 'sol');
model.study('std2').feature('time').set('initstudy', 'std1');
model.study('std2').feature('time').set('initsol', 'sol3');
model.study('std2').label('Study: Transient, Deformed Geometry');
model.study('std2').setGenPlots(false);

model.sol.create('sol8');

model.mesh('mesh1').stat.selection.geom(2);
model.mesh('mesh1').stat.selection.set([1 2]);

model.sol('sol8').study('std2');
model.sol('sol8').create('st1', 'StudyStep');
model.sol('sol8').feature('st1').set('study', 'std2');
model.sol('sol8').feature('st1').set('studystep', 'time');
model.sol('sol8').create('v1', 'Variables');
model.sol('sol8').feature('v1').feature('comp1_phil').set('scalemethod', 'manual');
model.sol('sol8').feature('v1').feature('comp1_material_disp').set('scalemethod', 'manual');
model.sol('sol8').feature('v1').feature('comp1_phis').set('scalemethod', 'manual');
model.sol('sol8').feature('v1').feature('comp1_u').set('scalemethod', 'manual');
model.sol('sol8').feature('v1').feature('comp1_phil').set('scaleval', '1');
model.sol('sol8').feature('v1').feature('comp1_material_disp').set('scaleval', '6.871189853293241E-4');
model.sol('sol8').feature('v1').feature('comp1_phis').set('scaleval', '1');
model.sol('sol8').feature('v1').feature('comp1_u').set('scaleval', '1e-2*2.23606797749979');
model.sol('sol8').feature('v1').feature('comp1_material_lm_nv').set('out', 'off');
model.sol('sol8').feature('v1').set('control', 'time');
model.sol('sol8').create('t1', 'Time');
model.sol('sol8').feature('t1').set('tlist', 'range(0,1,20)');
model.sol('sol8').feature('t1').set('plot', 'off');
model.sol('sol8').feature('t1').set('plotgroup', 'pg1');
model.sol('sol8').feature('t1').set('plotfreq', 'tout');
model.sol('sol8').feature('t1').set('probesel', 'all');
model.sol('sol8').feature('t1').set('probes', {});
model.sol('sol8').feature('t1').set('probefreq', 'tsteps');
model.sol('sol8').feature('t1').set('rtol', 0.001);
model.sol('sol8').feature('t1').set('atolglobalvaluemethod', 'factor');
model.sol('sol8').feature('t1').set('eventout', true);
model.sol('sol8').feature('t1').set('reacf', true);
model.sol('sol8').feature('t1').set('storeudot', true);
model.sol('sol8').feature('t1').set('endtimeinterpolation', true);
model.sol('sol8').feature('t1').set('maxorder', 2);
model.sol('sol8').feature('t1').set('control', 'time');
model.sol('sol8').feature('t1').feature('aDef').set('cachepattern', true);
model.sol('sol8').feature('t1').create('seDef', 'Segregated');
model.sol('sol8').feature('t1').create('fc1', 'FullyCoupled');
model.sol('sol8').feature('t1').feature('fc1').set('dtech', 'auto');
model.sol('sol8').feature('t1').create('d1', 'Direct');
model.sol('sol8').feature('t1').feature('d1').set('mumpsalloc', 1.2);
model.sol('sol8').feature('t1').feature('fc1').set('linsolver', 'd1');
model.sol('sol8').feature('t1').feature('fc1').set('dtech', 'auto');
model.sol('sol8').feature('t1').feature.remove('fcDef');
model.sol('sol8').feature('t1').feature.remove('seDef');
model.sol('sol8').attach('std2');
model.sol('sol8').feature('t1').feature('fc1').set('maxiter', 12);
model.sol('sol8').runAll;

model.result.create('pg6', 'PlotGroup1D');
model.result('pg6').run;
model.result('pg6').label('Corrosion Defect Profile');
model.result('pg6').set('data', 'dset4');
model.result('pg6').setIndex('looplevelinput', 'manual', 0);
model.result('pg6').setIndex('looplevel', [1 21], 0);
model.result('pg6').create('lngr1', 'LineGraph');
model.result('pg6').feature('lngr1').set('markerpos', 'datapoints');
model.result('pg6').feature('lngr1').set('linewidth', 'preference');
model.result('pg6').feature('lngr1').selection.set([9 10]);
model.result('pg6').feature('lngr1').set('expr', 'y');
model.result('pg6').feature('lngr1').set('xdata', 'expr');
model.result('pg6').feature('lngr1').set('xdataexpr', 'x');
model.result('pg6').feature('lngr1').set('legend', true);
model.result('pg6').run;
model.result('pg2').run;
model.result.duplicate('pg7', 'pg2');
model.result('pg7').run;
model.result('pg7').label('von Mises Stress, Deformed Geometry');
model.result('pg7').set('data', 'dset4');
model.result('pg7').setIndex('looplevelinput', 'manual', 0);
model.result('pg7').setIndex('looplevel', [1 21], 0);
model.result('pg7').run;
model.result('pg7').feature('lngr1').set('legendmethod', 'automatic');
model.result('pg7').run;
model.result('pg3').run;
model.result.duplicate('pg8', 'pg3');
model.result('pg8').run;
model.result('pg8').label('Corrosion Potential, Deformed Geometry');
model.result('pg8').set('data', 'dset4');
model.result('pg8').setIndex('looplevelinput', 'manual', 0);
model.result('pg8').setIndex('looplevel', [1 21], 0);
model.result('pg8').run;
model.result('pg8').feature('lngr1').set('legendmethod', 'automatic');
model.result('pg8').run;
model.result('pg4').run;
model.result.duplicate('pg9', 'pg4');
model.result('pg9').run;
model.result('pg9').label('Anodic Current Density, Deformed Geometry');
model.result('pg9').set('data', 'dset4');
model.result('pg9').setIndex('looplevelinput', 'manual', 0);
model.result('pg9').setIndex('looplevel', [1 21], 0);
model.result('pg9').run;
model.result('pg9').feature('lngr1').set('legendmethod', 'automatic');
model.result('pg9').run;
model.result('pg5').run;
model.result.duplicate('pg10', 'pg5');
model.result('pg10').run;
model.result('pg10').label('Cathodic Current Density, Deformed Geometry');
model.result('pg10').set('data', 'dset4');
model.result('pg10').setIndex('looplevelinput', 'manual', 0);
model.result('pg10').setIndex('looplevel', [1 21], 0);
model.result('pg10').run;
model.result('pg10').feature('lngr1').set('legendmethod', 'automatic');
model.result('pg10').run;

model.title('Stress Corrosion');

model.description('This example simulates the effect of elastic and plastic deformations on pipeline corrosion. The Solid Mechanics interface with small strain plasticity model is used for elasto-plastic stress simulation. The Secondary Current Distribution interface is used to model electrochemical reactions. It is seen that pipeline corrosion accelerates with increase in longitudinal strain in the plastic deformation region.');

model.mesh.clearMeshes;

model.sol('sol1').clearSolutionData;
model.sol('sol2').clearSolutionData;
model.sol('sol3').clearSolutionData;
model.sol('sol4').clearSolutionData;
model.sol('sol5').clearSolutionData;
model.sol('sol6').clearSolutionData;
model.sol('sol7').clearSolutionData;
model.sol('sol8').clearSolutionData;

model.label('stress_corrosion.mph');

model.modelNode.label('Components');

out = model;
