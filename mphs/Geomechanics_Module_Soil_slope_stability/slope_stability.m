function out = model
%
% slope_stability.m
%
% Model exported on May 26 2025, 21:28 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/Geomechanics_Module/Soil');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 2);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.physics.create('dl', 'PorousMediaFlowDarcy', 'geom1');
model.physics('dl').model('comp1');
model.physics.create('solid', 'SolidMechanics', 'geom1');
model.physics('solid').model('comp1');

model.study.create('std1');
model.study('std1').create('stat', 'Stationary');
model.study('std1').feature('stat').setSolveFor('/physics/dl', true);
model.study('std1').feature('stat').setSolveFor('/physics/solid', true);

% To import content from file, use:
% model.param.loadFile('FILENAME');
model.param.set('L1', '24[m]', 'Length of the dam (left)');
model.param.set('L2', '5[m]', 'Length of the dam (top)');
model.param.set('L3', '24[m]', 'Length of the dam (right)');
model.param.set('L4', '12[m]', 'Height of the dam');
model.param.set('Hw', '10[m]', 'Water level');
model.param.set('Hs', '4[m]', 'Possible seepage level');
model.param.set('E_soil', '100[MPa]', 'Young''s modulus');
model.param.set('nu_soil', '0.4', 'Poisson''s ratio');
model.param.set('rho_soil', '2000[kg/m^3]', 'Soil density');
model.param.set('rho_wat', '1000[kg/m^3]', 'Water density');
model.param.set('psi', '0.3[1]', 'Porosity');
model.param.set('c', '25[kPa]', 'Cohesion');
model.param.set('phi_sat', '30[deg]', 'Friction angle for saturated soil');
model.param.set('phi_un', '20[deg]', 'Friction angle for unsaturated soil');
model.param.set('FOS', '1[1]', 'Factor of safety');

model.func.create('int1', 'Interpolation');
model.func('int1').set('table', {'0' '5e-4';  ...
'-0.1' '5e-4';  ...
'-0.6' '3e-4';  ...
'-2' '6.5e-5';  ...
'-3' '6.1e-6';  ...
'-4' '1e-6';  ...
'-5' '2e-7';  ...
'-8' '7.5e-8';  ...
'-10' '7.5e-8'});
model.func('int1').set('funcname', 'cond');
model.func('int1').setIndex('argunit', 'm', 0);
model.func('int1').setIndex('fununit', 'm/s', 0);

model.geom('geom1').create('pol1', 'Polygon');
model.geom('geom1').feature('pol1').set('source', 'table');
model.geom('geom1').feature('pol1').setIndex('table', 0, 0, 0);
model.geom('geom1').feature('pol1').setIndex('table', 0, 0, 1);
model.geom('geom1').feature('pol1').setIndex('table', 'L1', 1, 0);
model.geom('geom1').feature('pol1').setIndex('table', 'L4', 1, 1);
model.geom('geom1').feature('pol1').setIndex('table', 'L1+L2', 2, 0);
model.geom('geom1').feature('pol1').setIndex('table', 'L4', 2, 1);
model.geom('geom1').feature('pol1').setIndex('table', 'L1+L2+L3', 3, 0);
model.geom('geom1').feature('pol1').setIndex('table', 0, 3, 1);
model.geom('geom1').feature('pol1').setIndex('table', 'L1+L2+L3*2', 4, 0);
model.geom('geom1').feature('pol1').setIndex('table', 0, 4, 1);
model.geom('geom1').feature('pol1').setIndex('table', 'L1+L2+L3*2', 5, 0);
model.geom('geom1').feature('pol1').setIndex('table', '-L4*2', 5, 1);
model.geom('geom1').feature('pol1').setIndex('table', '-L1', 6, 0);
model.geom('geom1').feature('pol1').setIndex('table', '-L4*2', 6, 1);
model.geom('geom1').feature('pol1').setIndex('table', '-L1', 7, 0);
model.geom('geom1').feature('pol1').setIndex('table', 0, 7, 1);
model.geom('geom1').run('pol1');
model.geom('geom1').create('fil1', 'Fillet');
model.geom('geom1').feature('fil1').selection('pointinsketch').set('pol1', 4);
model.geom('geom1').feature('fil1').set('radius', 5);
model.geom('geom1').runPre('fin');
model.geom('geom1').create('pt1', 'Point');
model.geom('geom1').feature('pt1').setIndex('p', 'Hw*L1/L4', 0);
model.geom('geom1').feature('pt1').setIndex('p', 'Hw', 1);
model.geom('geom1').feature.duplicate('pt2', 'pt1');
model.geom('geom1').feature('pt2').setIndex('p', 'L1+L2+L3-Hs*L1/L4', 0);
model.geom('geom1').feature('pt2').setIndex('p', 'Hs', 1);
model.geom('geom1').run('pt2');

model.variable.create('var1');
model.variable('var1').model('comp1');

model.geom('geom1').run;

model.variable('var1').set('Saturated', 'dl.Hp>=0');
model.variable('var1').descr('Saturated', 'Boolean variable for saturated region');
model.variable('var1').set('Unsaturated', 'dl.Hp<0');
model.variable('var1').descr('Unsaturated', 'Boolean variable for unsaturated region');
model.variable('var1').set('K', 'cond(dl.Hp)');
model.variable('var1').descr('K', 'Hydraulic conductivity');
model.variable('var1').set('C', 'c/FOS');
model.variable('var1').descr('C', 'Parameterized cohesion');
model.variable('var1').set('PHI', 'atan(tan(phi_un)/FOS)*Unsaturated+atan(tan(phi_sat)/FOS)*Saturated');
model.variable('var1').descr('PHI', 'Parameterized friction angle');

model.cpl.create('maxop1', 'Maximum', 'geom1');
model.cpl('maxop1').selection.set([1]);

model.material.create('mat1', 'Common', '');
model.material('mat1').label('Soil');
model.material.create('mat2', 'Common', '');
model.material('mat2').label('Water');
model.material.create('pmat1', 'PorousMedia', 'comp1');
model.material('pmat1').set('linkBase', 'mat1');
model.material('pmat1').feature.create('fluid1', 'Fluid', 'comp1');
model.material('pmat1').feature('fluid1').set('link', 'mat2');
model.material('pmat1').feature.create('solid1', 'Solid', 'comp1');
model.material('pmat1').feature('solid1').set('vfrac', '1-psi');

model.physics('dl').feature('porous1').feature('pm1').set('permeabilityModelType', 'conductivity');
model.physics('dl').feature('porous1').feature('pm1').set('K', {'K' '0' '0' '0' 'K' '0' '0' '0' 'K'});

model.material('mat1').propertyGroup('def').set('density', {'rho_soil'});
model.material('mat1').propertyGroup.create('Enu', 'Young''s_modulus_and_Poisson''s_ratio');
model.material('mat1').propertyGroup('Enu').set('E', {'E_soil'});
model.material('mat1').propertyGroup('Enu').set('nu', {'nu_soil'});
model.material('mat2').propertyGroup('def').set('density', {'rho_wat'});

model.physics('dl').create('ph1', 'PressureHead', 1);
model.physics('dl').feature('ph1').selection.set([1 3 4]);
model.physics('dl').feature('ph1').set('Hp0', 'Hw-y');
model.physics('dl').create('ph2', 'PressureHead', 1);
model.physics('dl').feature('ph2').selection.set([8 9 11]);
model.physics('dl').create('ph3', 'PressureHead', 1);
model.physics('dl').feature('ph3').selection.set([10]);
model.physics('dl').feature('ph3').set('Hp0', '-y');
model.physics('dl').prop('GravityEffects').set('IncludeGravity', true);
model.physics('dl').feature('gr1').set('GravityType', 'Elevation');

model.mesh('mesh1').automatic(false);
model.mesh('mesh1').feature('size').set('hauto', 4);
model.mesh('mesh1').create('se1', 'SizeExpression');
model.mesh('mesh1').feature.move('se1', 1);
model.mesh('mesh1').feature('se1').set('sizeexpr', 'if(Y>-L4&&X>L1/2&&X<(L1+L2+L3*1.5),0.75,10)');
model.mesh('mesh1').feature('se1').set('numcell', 50);
model.mesh('mesh1').run;

model.study('std1').label('Study 1: Darcy''s Law');
model.study('std1').setGenPlots(false);
model.study('std1').feature('stat').setEntry('activate', 'solid', false);

model.sol.create('sol1');

model.mesh('mesh1').stat.selection.geom(2);
model.mesh('mesh1').stat.selection.set([1]);

model.sol('sol1').study('std1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'stat');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').set('control', 'stat');
model.sol('sol1').create('s1', 'Stationary');
model.sol('sol1').feature('s1').feature('aDef').set('cachepattern', true);
model.sol('sol1').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('s1').feature('fc1').set('dtech', 'auto');
model.sol('sol1').feature('s1').feature('fc1').set('initstep', 0.01);
model.sol('sol1').feature('s1').feature('fc1').set('minstep', 1.0E-6);
model.sol('sol1').feature('s1').feature('fc1').set('maxiter', 50);
model.sol('sol1').feature('s1').create('d1', 'Direct');
model.sol('sol1').feature('s1').feature('d1').set('linsolver', 'pardiso');
model.sol('sol1').feature('s1').feature('d1').set('pivotperturb', 1.0E-13);
model.sol('sol1').feature('s1').feature('d1').label('Direct, pressure (dl)');
model.sol('sol1').feature('s1').create('i1', 'Iterative');
model.sol('sol1').feature('s1').feature('i1').set('linsolver', 'gmres');
model.sol('sol1').feature('s1').feature('i1').set('prefuntype', 'left');
model.sol('sol1').feature('s1').feature('i1').set('itrestart', 50);
model.sol('sol1').feature('s1').feature('i1').set('rhob', 400);
model.sol('sol1').feature('s1').feature('i1').set('maxlinit', 1000);
model.sol('sol1').feature('s1').feature('i1').set('nlinnormuse', 'on');
model.sol('sol1').feature('s1').feature('i1').label('AMG, pressure (dl)');
model.sol('sol1').feature('s1').feature('i1').create('mg1', 'Multigrid');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').set('prefun', 'saamg');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').set('mgcycle', 'v');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').set('maxcoarsedof', 50000);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').set('strconn', 0.01);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').set('nullspace', 'constant');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').set('usesmooth', false);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').set('saamgcompwise', false);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').set('loweramg', true);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').set('compactaggregation', false);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('pr').create('sl1', 'SORLine');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('pr').feature('sl1').set('linesweeptype', 'ssor');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('pr').feature('sl1').set('iter', 1);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('pr').feature('sl1').set('linerelax', 0.7);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('pr').feature('sl1').set('linealgorithm', 'mesh');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('pr').feature('sl1').set('linemethod', 'coupled');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('pr').feature('sl1').set('seconditer', 1);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('pr').feature('sl1').set('relax', 0.5);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('po').create('sl1', 'SORLine');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('po').feature('sl1').set('linesweeptype', 'ssor');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('po').feature('sl1').set('iter', 1);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('po').feature('sl1').set('linerelax', 0.7);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('po').feature('sl1').set('linealgorithm', 'mesh');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('po').feature('sl1').set('linemethod', 'coupled');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('po').feature('sl1').set('seconditer', 1);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('po').feature('sl1').set('relax', 0.5);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('cs').create('d1', 'Direct');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('cs').feature('d1').set('linsolver', 'pardiso');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('cs').feature('d1').set('pivotperturb', 1.0E-13);
model.sol('sol1').feature('s1').feature('fc1').set('linsolver', 'd1');
model.sol('sol1').feature('s1').feature('fc1').set('dtech', 'auto');
model.sol('sol1').feature('s1').feature('fc1').set('initstep', 0.01);
model.sol('sol1').feature('s1').feature('fc1').set('minstep', 1.0E-6);
model.sol('sol1').feature('s1').feature('fc1').set('maxiter', 50);
model.sol('sol1').feature('s1').feature.remove('fcDef');
model.sol('sol1').attach('std1');
model.sol('sol1').runAll;

model.result.create('pg1', 'PlotGroup2D');
model.result('pg1').run;
model.result('pg1').label('Pressure Head');
model.result('pg1').create('con1', 'Contour');
model.result('pg1').feature('con1').set('expr', 'dl.Hp');
model.result('pg1').feature('con1').set('descr', 'Pressure head');
model.result('pg1').feature('con1').set('levelmethod', 'levels');
model.result('pg1').feature('con1').set('levels', 'range(0,3,30)');
model.result('pg1').feature('con1').set('contourtype', 'tubes');
model.result('pg1').feature('con1').set('tuberadiusscaleactive', true);
model.result('pg1').feature('con1').set('tuberadiusscale', 0.1);
model.result('pg1').run;

model.physics('solid').create('bndl1', 'BoundaryLoad', 1);
model.physics('solid').feature('bndl1').selection.set([3 4]);
model.physics('solid').feature('bndl1').set('LoadType', 'FollowerPressure');
model.physics('solid').feature('bndl1').set('FollowerPressure', 'p');
model.physics('solid').create('fix1', 'Fixed', 1);
model.physics('solid').feature('fix1').selection.set([2]);
model.physics('solid').create('roll1', 'Roller', 1);
model.physics('solid').feature('roll1').selection.set([1 10]);
model.physics('solid').create('gacc1', 'GravityAcceleration', -1);
model.physics('solid').feature('lemm1').set('reducedIntegration', true);
model.physics('solid').feature('lemm1').create('exs1', 'ExternalStress', 2);
model.physics('solid').feature('lemm1').feature('exs1').set('StressInputType', 'PorePressure');
model.physics('solid').feature('lemm1').feature('exs1').set('pA', 'p*Saturated');
model.physics('solid').feature('lemm1').feature('exs1').set('alphaB_mat', 'userdef');
model.physics('solid').feature('lemm1').feature('exs1').set('alphaB', 1);
model.physics('solid').feature('lemm1').feature('exs1').set('pref', 0);

model.study.create('std2');
model.study('std2').create('stat', 'Stationary');
model.study('std2').feature('stat').setSolveFor('/physics/dl', true);
model.study('std2').feature('stat').setSolveFor('/physics/solid', true);
model.study('std2').label('Study 2: Solid Mechanics (In Situ Stress Initialization)');
model.study('std2').setGenPlots(false);

model.sol.create('sol2');

model.mesh('mesh1').stat.selection.geom(2);
model.mesh('mesh1').stat.selection.set([1]);

model.sol('sol2').study('std2');
model.sol('sol2').create('st1', 'StudyStep');
model.sol('sol2').feature('st1').set('study', 'std2');
model.sol('sol2').feature('st1').set('studystep', 'stat');
model.sol('sol2').create('v1', 'Variables');
model.sol('sol2').feature('v1').set('control', 'stat');
model.sol('sol2').create('s1', 'Stationary');
model.sol('sol2').feature('s1').feature('aDef').set('cachepattern', true);
model.sol('sol2').feature('s1').create('seDef', 'Segregated');
model.sol('sol2').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol2').feature('s1').feature('fc1').set('dtech', 'auto');
model.sol('sol2').feature('s1').feature('fc1').set('initstep', 0.01);
model.sol('sol2').feature('s1').feature('fc1').set('minstep', 1.0E-6);
model.sol('sol2').feature('s1').feature('fc1').set('maxiter', 50);
model.sol('sol2').feature('s1').create('d1', 'Direct');
model.sol('sol2').feature('s1').feature('d1').set('linsolver', 'mumps');
model.sol('sol2').feature('s1').feature('d1').set('pivotperturb', 1.0E-13);
model.sol('sol2').feature('s1').feature('d1').label('Direct, pressure (dl) (Merged)');
model.sol('sol2').feature('s1').create('i1', 'Iterative');
model.sol('sol2').feature('s1').feature('i1').set('linsolver', 'gmres');
model.sol('sol2').feature('s1').feature('i1').set('prefuntype', 'left');
model.sol('sol2').feature('s1').feature('i1').set('itrestart', 50);
model.sol('sol2').feature('s1').feature('i1').set('rhob', 400);
model.sol('sol2').feature('s1').feature('i1').set('maxlinit', 1000);
model.sol('sol2').feature('s1').feature('i1').set('nlinnormuse', 'on');
model.sol('sol2').feature('s1').feature('i1').label('AMG, pressure (dl)');
model.sol('sol2').feature('s1').feature('i1').create('mg1', 'Multigrid');
model.sol('sol2').feature('s1').feature('i1').feature('mg1').set('prefun', 'saamg');
model.sol('sol2').feature('s1').feature('i1').feature('mg1').set('mgcycle', 'v');
model.sol('sol2').feature('s1').feature('i1').feature('mg1').set('maxcoarsedof', 50000);
model.sol('sol2').feature('s1').feature('i1').feature('mg1').set('strconn', 0.01);
model.sol('sol2').feature('s1').feature('i1').feature('mg1').set('nullspace', 'constant');
model.sol('sol2').feature('s1').feature('i1').feature('mg1').set('usesmooth', false);
model.sol('sol2').feature('s1').feature('i1').feature('mg1').set('saamgcompwise', false);
model.sol('sol2').feature('s1').feature('i1').feature('mg1').set('loweramg', true);
model.sol('sol2').feature('s1').feature('i1').feature('mg1').set('compactaggregation', false);
model.sol('sol2').feature('s1').feature('i1').feature('mg1').feature('pr').create('sl1', 'SORLine');
model.sol('sol2').feature('s1').feature('i1').feature('mg1').feature('pr').feature('sl1').set('linesweeptype', 'ssor');
model.sol('sol2').feature('s1').feature('i1').feature('mg1').feature('pr').feature('sl1').set('iter', 1);
model.sol('sol2').feature('s1').feature('i1').feature('mg1').feature('pr').feature('sl1').set('linerelax', 0.7);
model.sol('sol2').feature('s1').feature('i1').feature('mg1').feature('pr').feature('sl1').set('linealgorithm', 'mesh');
model.sol('sol2').feature('s1').feature('i1').feature('mg1').feature('pr').feature('sl1').set('linemethod', 'coupled');
model.sol('sol2').feature('s1').feature('i1').feature('mg1').feature('pr').feature('sl1').set('seconditer', 1);
model.sol('sol2').feature('s1').feature('i1').feature('mg1').feature('pr').feature('sl1').set('relax', 0.5);
model.sol('sol2').feature('s1').feature('i1').feature('mg1').feature('po').create('sl1', 'SORLine');
model.sol('sol2').feature('s1').feature('i1').feature('mg1').feature('po').feature('sl1').set('linesweeptype', 'ssor');
model.sol('sol2').feature('s1').feature('i1').feature('mg1').feature('po').feature('sl1').set('iter', 1);
model.sol('sol2').feature('s1').feature('i1').feature('mg1').feature('po').feature('sl1').set('linerelax', 0.7);
model.sol('sol2').feature('s1').feature('i1').feature('mg1').feature('po').feature('sl1').set('linealgorithm', 'mesh');
model.sol('sol2').feature('s1').feature('i1').feature('mg1').feature('po').feature('sl1').set('linemethod', 'coupled');
model.sol('sol2').feature('s1').feature('i1').feature('mg1').feature('po').feature('sl1').set('seconditer', 1);
model.sol('sol2').feature('s1').feature('i1').feature('mg1').feature('po').feature('sl1').set('relax', 0.5);
model.sol('sol2').feature('s1').feature('i1').feature('mg1').feature('cs').create('d1', 'Direct');
model.sol('sol2').feature('s1').feature('i1').feature('mg1').feature('cs').feature('d1').set('linsolver', 'pardiso');
model.sol('sol2').feature('s1').feature('i1').feature('mg1').feature('cs').feature('d1').set('pivotperturb', 1.0E-13);
model.sol('sol2').feature('s1').feature('fc1').set('linsolver', 'd1');
model.sol('sol2').feature('s1').feature('fc1').set('dtech', 'auto');
model.sol('sol2').feature('s1').feature('fc1').set('initstep', 0.01);
model.sol('sol2').feature('s1').feature('fc1').set('minstep', 1.0E-6);
model.sol('sol2').feature('s1').feature('fc1').set('maxiter', 50);
model.sol('sol2').feature('s1').feature.remove('fcDef');
model.sol('sol2').feature('s1').feature.remove('seDef');
model.sol('sol2').attach('std2');
model.sol('sol2').runAll;

model.physics('solid').feature('lemm1').create('soil1', 'SoilModel', 2);
model.physics('solid').feature('lemm1').feature('soil1').set('YieldCriterion', 'MohrCoulomb');
model.physics('solid').feature('lemm1').feature('soil1').set('MohrCoulombFlowRule', 'AssociatedFlowRule');
model.physics('solid').feature('lemm1').feature('soil1').set('nonlocalPlasticModel', 'impGradient');
model.physics('solid').feature('lemm1').feature('soil1').set('lint', 0.1);
model.physics('solid').feature('lemm1').create('iss1', 'InitialStressandStrain', 2);
model.physics('solid').feature('lemm1').feature('iss1').set('Sil', {'withsol(''sol2'',solid.sx)' 'withsol(''sol2'',solid.sxy)' 'withsol(''sol2'',solid.sxz)' 'withsol(''sol2'',solid.sxy)' 'withsol(''sol2'',solid.sy)' 'withsol(''sol2'',solid.syz)' 'withsol(''sol2'',solid.sxz)' 'withsol(''sol2'',solid.syz)' 'withsol(''sol2'',solid.sz)'});

model.material('mat1').propertyGroup.create('MohrCoulomb', 'Mohr_Coulomb_criterion');
model.material('mat1').propertyGroup('MohrCoulomb').set('cohesion', {'comp1.C'});
model.material('mat1').propertyGroup('MohrCoulomb').set('internalphi', {'comp1.PHI'});

model.study('std2').feature('stat').set('useadvanceddisable', true);
model.study('std2').feature('stat').setSolveFor('/physics/dl', false);
model.study('std2').feature('stat').set('disabledphysics', {'solid/lemm1/soil1' 'solid/lemm1/iss1'});
model.study('std2').feature('stat').set('usesol', true);
model.study('std2').feature('stat').set('notsolmethod', 'sol');
model.study('std2').feature('stat').set('notstudy', 'std1');
model.study.create('std3');
model.study('std3').create('stat', 'Stationary');
model.study('std3').feature('stat').setSolveFor('/physics/dl', true);
model.study('std3').feature('stat').setSolveFor('/physics/solid', true);
model.study('std3').label('Study 3: Solid Mechanics (Factor of Safety)');
model.study('std3').setGenPlots(false);
model.study('std3').feature('stat').setEntry('activate', 'dl', false);
model.study('std3').feature('stat').set('usesol', true);
model.study('std3').feature('stat').set('notsolmethod', 'sol');
model.study('std3').feature('stat').set('notstudy', 'std1');
model.study('std3').feature('stat').set('useparam', true);
model.study('std3').feature('stat').setIndex('pname', 'L1', 0);
model.study('std3').feature('stat').setIndex('plistarr', '', 0);
model.study('std3').feature('stat').setIndex('punit', 'm', 0);
model.study('std3').feature('stat').setIndex('pname', 'L1', 0);
model.study('std3').feature('stat').setIndex('plistarr', '', 0);
model.study('std3').feature('stat').setIndex('punit', 'm', 0);
model.study('std3').feature('stat').setIndex('pname', 'FOS', 0);
model.study('std3').feature('stat').setIndex('plistarr', 'range(1,0.01,1.92)', 0);
model.study('std3').feature('stat').setIndex('punit', '', 0);

model.sol.create('sol3');
model.sol('sol3').study('std3');
model.sol('sol3').create('st1', 'StudyStep');
model.sol('sol3').feature('st1').set('study', 'std3');
model.sol('sol3').feature('st1').set('studystep', 'stat');
model.sol('sol3').create('v1', 'Variables');
model.sol('sol3').feature('v1').feature('comp1_solid_lemm1_soil1_epenl').set('scalemethod', 'manual');
model.sol('sol3').feature('v1').feature('comp1_solid_lemm1_soil1_epenl').set('resscalemethod', 'parent');
model.sol('sol3').feature('v1').feature('comp1_solid_lemm1_soil1_epenl').set('scaleval', '0.01');
model.sol('sol3').feature('v1').set('control', 'stat');
model.sol('sol3').create('s1', 'Stationary');
model.sol('sol3').feature('s1').create('p1', 'Parametric');
model.sol('sol3').feature('s1').feature.remove('pDef');
model.sol('sol3').feature('s1').feature('p1').set('control', 'stat');
model.sol('sol3').feature('s1').set('control', 'stat');
model.sol('sol3').feature('s1').feature('aDef').set('cachepattern', true);
model.sol('sol3').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol3').feature('s1').feature('fc1').set('termonres', 'auto');
model.sol('sol3').feature('s1').feature('fc1').set('reserrfact', 1000);
model.sol('sol3').feature('s1').feature('fc1').set('linsolver', 'dDef');
model.sol('sol3').feature('s1').feature('fc1').set('termonres', 'auto');
model.sol('sol3').feature('s1').feature('fc1').set('reserrfact', 1000);
model.sol('sol3').feature('s1').feature.remove('fcDef');
model.sol('sol3').attach('std3');
model.sol('sol3').runAll;

model.result.create('pg2', 'PlotGroup2D');
model.result('pg2').run;
model.result('pg2').label('Slip Surface');
model.result('pg2').set('data', 'dset3');
model.result('pg2').set('titletype', 'label');
model.result('pg2').create('con1', 'Contour');
model.result('pg2').feature('con1').set('expr', 'solid.disp');
model.result('pg2').feature('con1').set('descr', 'Displacement magnitude');
model.result('pg2').feature('con1').set('levelmethod', 'levels');
model.result('pg2').feature('con1').set('levels', '0 0.1 Inf');
model.result('pg2').feature('con1').set('contourtype', 'filled');
model.result('pg2').feature('con1').set('colortable', 'GrayPrint');
model.result('pg2').feature('con1').set('colortabletrans', 'reverse');
model.result('pg2').feature('con1').set('colorlegend', false);
model.result('pg2').run;
model.result('pg2').create('arws1', 'ArrowSurface');
model.result('pg2').feature('arws1').set('expr', {'u' 'v'});
model.result('pg2').feature('arws1').set('descr', 'Displacement field');
model.result('pg2').run;
model.result.create('pg3', 'PlotGroup2D');
model.result('pg3').run;
model.result('pg3').label('Equivalent Plastic Strain');
model.result('pg3').set('data', 'dset3');
model.result('pg3').create('surf1', 'Surface');
model.result('pg3').feature('surf1').set('expr', 'solid.epeGp');
model.result('pg3').feature('surf1').set('descr', 'Equivalent plastic strain');
model.result('pg3').run;
model.result.create('pg4', 'PlotGroup1D');
model.result('pg4').run;
model.result('pg4').label('Factor of Safety');
model.result('pg4').set('data', 'dset3');
model.result('pg4').create('glob1', 'Global');
model.result('pg4').feature('glob1').set('markerpos', 'datapoints');
model.result('pg4').feature('glob1').set('linewidth', 'preference');
model.result('pg4').feature('glob1').setIndex('expr', 'maxop1(solid.disp)', 0);
model.result('pg4').feature('glob1').setIndex('unit', 'mm', 0);
model.result('pg4').feature('glob1').setIndex('descr', 'Maximum displacement', 0);
model.result('pg4').feature('glob1').set('xdata', 'expr');
model.result('pg4').feature('glob1').set('xdataexpr', 'FOS');
model.result('pg4').feature('glob1').set('xdatadescr', 'Factor of safety');
model.result('pg4').feature('glob1').set('linemarker', 'circle');
model.result('pg4').feature('glob1').set('legend', false);
model.result('pg4').run;
model.result('pg4').set('legendpos', 'upperleft');
model.result('pg4').run;
model.result.dataset.create('extr1', 'Extrude2D');
model.result.dataset('extr1').set('data', 'dset3');
model.result.dataset('extr1').set('zmax', 'L1+L2+L3');
model.result.dataset('extr1').set('zvar', 'Z');
model.result.dataset('extr1').set('planemap', 'xz');
model.result.create('pg5', 'PlotGroup3D');
model.result('pg5').run;
model.result('pg5').label('Displacement');
model.result('pg5').create('surf1', 'Surface');
model.result('pg5').feature('surf1').set('expr', 'solid.disp');
model.result('pg5').feature('surf1').set('descr', 'Displacement magnitude');
model.result('pg5').feature('surf1').set('unit', 'mm');
model.result('pg5').run;
model.result('pg5').run;

model.title('Slope Stability in an Embankment Dam');

model.description(['This example shows how to run a slope stability analysis of an embankment dam including the pore pressure. The fluid transport in the porous soil is described by Darcy''s law, and the elastoplastic analysis is carried out with the Mohr' native2unicode(hex2dec({'20' '13'}), 'unicode') 'Coulomb model. The material properties are parameterized with respect to the factor of safety using the shear reduction technique.']);

model.mesh.clearMeshes;

model.sol('sol1').clearSolutionData;
model.sol('sol2').clearSolutionData;
model.sol('sol3').clearSolutionData;

model.label('slope_stability.mph');

model.modelNode.label('Components');

out = model;
