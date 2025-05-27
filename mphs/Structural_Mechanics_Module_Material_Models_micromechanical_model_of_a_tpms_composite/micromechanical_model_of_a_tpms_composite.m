function out = model
%
% micromechanical_model_of_a_tpms_composite.m
%
% Model exported on May 26 2025, 21:33 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/Structural_Mechanics_Module/Material_Models');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 3);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.physics.create('solid', 'SolidMechanics', 'geom1');
model.physics('solid').model('comp1');

% To import content from file, use:
% model.param.loadFile('FILENAME');
model.param.set('th', '4[mm]', 'Wall thickness');
model.param.set('L', '100[mm]', 'Unit cell length');
model.param.set('E_m', '10[GPa]', 'Young''s modulus, matrix');
model.param.set('E_f', '20*E_m', 'Young''s modulus, TPMS');
model.param.set('nu_m', '0.3', 'Poisson''s ratio, matrix');
model.param.set('nu_f', '0.3', 'Poisson''s ratio, TPMS');
model.param.set('G_m', 'E_m/(2*(1+nu_m))', 'Shear modulus, matrix');
model.param.set('alpha_m', '44E-6[1/K]', 'Coefficient of thermal expansion, matrix');
model.param.set('alpha_f', '0.8E-6[1/K]', 'Coefficient of thermal expansion, TPMS');
model.param.set('rho_m', '3000[kg/m^3]', 'Density, matrix');
model.param.set('rho_f', '7000[kg/m^3]', 'Density, TPMS');

model.geom.load({'part1'}, 'COMSOL_Multiphysics/Unit_Cells_and_RVEs/Miscellaneous/gyroid.mph', {'part1'});
model.geom('geom1').create('pi1', 'PartInstance');
model.geom('geom1').feature('pi1').set('selkeepnoncontr', false);
model.geom('geom1').feature('pi1').set('part', 'part1');
model.geom('geom1').feature('pi1').setEntry('inputexpr', 'lm', 'L');
model.geom('geom1').feature('pi1').setEntry('inputexpr', 'th', 'th');
model.geom('geom1').run('fin');
model.geom('geom1').create('rmd1', 'RemoveDetails');
model.geom('geom1').feature('rmd1').set('contangletol', 10);
model.geom('geom1').run('rmd1');
model.geom('geom1').run('rmd1');

model.view('view1').set('showgrid', false);
model.view('view1').set('transparency', false);

model.cpl.create('intop1', 'Integration', 'geom1');
model.cpl('intop1').set('axisym', true);
model.cpl('intop1').selection.named('geom1_pi1_gyroid_dom');

model.variable.create('var1');
model.variable('var1').model('comp1');
model.variable('var1').set('v_f', 'intop1(1)/L^3');
model.variable('var1').descr('v_f', 'Volume fraction of tpms');
model.variable('var1').set('E_h', '1/solid.cp1.Dinv11');
model.variable('var1').descr('E_h', 'Homogenized Young''s modulus');
model.variable('var1').set('nu_h', '-E_h*solid.cp1.Dinv12');
model.variable('var1').descr('nu_h', 'Homogenized Poisson''s ratio');
model.variable('var1').set('G_h', '1/solid.cp1.Dinv55');
model.variable('var1').descr('G_h', 'Homogenized shear modulus');
model.variable('var1').set('alpha_h', 'solid.cp2.alphaXX');
model.variable('var1').descr('alpha_h', 'Homogenized coefficient of thermal expansion');

model.physics('solid').feature('lemm1').create('te1', 'ThermalExpansion', 3);
model.physics('solid').feature('lemm1').feature('te1').set('minput_temperature_src', 'userdef');
model.physics('solid').feature('lemm1').feature('te1').set('minput_temperature', '294.15[K]');
model.physics('solid').create('cp1', 'CellPeriodicity', 3);
model.physics('solid').feature('cp1').label('Cell Periodicity for Elastic Properties');
model.physics('solid').feature('cp1').set('BoundaryExpansion', 'PrescribedStrain');
model.physics('solid').feature('cp1').set('EffectivePropertiese', 'ElasticityMatrixStandard');
model.physics('solid').feature('cp1').create('bp1', 'BoundaryPair', 2);
model.physics('solid').feature('cp1').feature('bp1').selection.named('geom1_pi1_pair1');
model.physics('solid').feature('cp1').feature('bp1').set('manualDestinationSelection', true);
model.physics('solid').feature('cp1').feature('bp1').selection('destinationDomains').named('geom1_pi1_pair1dst');
model.physics('solid').feature('cp1').feature.duplicate('bp2', 'bp1');
model.physics('solid').feature('cp1').feature('bp2').selection.named('geom1_pi1_pair2');
model.physics('solid').feature('cp1').feature('bp2').selection('destinationDomains').named('geom1_pi1_pair2dst');
model.physics('solid').feature('cp1').feature.duplicate('bp3', 'bp2');
model.physics('solid').feature('cp1').feature('bp3').selection.named('geom1_pi1_pair3');
model.physics('solid').feature('cp1').feature('bp3').selection('destinationDomains').named('geom1_pi1_pair3dst');
model.physics('solid').feature('cp1').set('parametricStudy', 'yes');
model.physics('solid').feature('cp1').set('parametricSweep', 'filled');
model.physics('solid').feature('cp1').setIndex('parameterName', 'para', 1, 0);
model.physics('solid').feature('cp1').setIndex('parameterRange', 'range(0,0.1,1)', 1, 0);
model.physics('solid').feature('cp1').setIndex('parameterUnit', 1, 1, 0);
model.physics('solid').feature('cp1').setIndex('parameterRange', 'range(0,0.1,1)', 1, 0);
model.physics('solid').feature('cp1').setIndex('parameterUnit', 1, 1, 0);
model.physics('solid').feature('cp1').setIndex('parameterName', 'para', 1, 0);
model.physics('solid').feature('cp1').setIndex('parameterRange', 'range(0,0.1,1)', 1, 0);
model.physics('solid').feature('cp1').setIndex('parameterUnit', 1, 1, 0);
model.physics('solid').feature('cp1').setIndex('parameterName', 'th', 0, 0);
model.physics('solid').feature('cp1').setIndex('parameterRange', 'range(4,2,12)', 0, 0);
model.physics('solid').feature('cp1').setIndex('parameterUnit', 'mm', 0, 0);
model.physics('solid').feature('cp1').setIndex('parameterName', 'nu_f', 1, 0);
model.physics('solid').feature('cp1').setIndex('parameterRange', '0.3 -0.3 -0.5 -0.75', 1, 0);
model.physics('solid').feature('cp1').setIndex('parameterUnit', 1, 1, 0);
model.physics('solid').feature('cp1').runCommand('createLoadGroupsandStudy');
model.physics('solid').feature.duplicate('cp2', 'cp1');
model.physics('solid').feature('cp2').label('Cell Periodicity for Thermal Properties');
model.physics('solid').feature('cp2').set('BoundaryExpansion', 'FreeExpansion');
model.physics('solid').feature('cp2').set('EffectiveProperties', 'ThermalExpansion');

model.material.create('mat1', 'Common', 'comp1');
model.material('mat1').label('Material 1: Matrix');
model.material('mat1').selection.named('geom1_pi1_matrix');
model.material('mat1').propertyGroup.create('Enu', 'Young''s_modulus_and_Poisson''s_ratio');
model.material('mat1').propertyGroup('Enu').set('E', {'E_m'});
model.material('mat1').propertyGroup('Enu').set('nu', {'nu_m'});
model.material('mat1').propertyGroup('def').set('density', {'rho_m'});
model.material('mat1').propertyGroup('def').set('thermalexpansioncoefficient', {'alpha_m'});
model.material.create('mat2', 'Common', 'comp1');
model.material('mat2').label('Material 2: TPMS');
model.material('mat2').selection.named('geom1_pi1_gyroid_dom');
model.material('mat2').propertyGroup.create('Enu', 'Young''s_modulus_and_Poisson''s_ratio');
model.material('mat2').propertyGroup('Enu').set('E', {'E_f'});
model.material('mat2').propertyGroup('Enu').set('nu', {'nu_f'});
model.material('mat2').propertyGroup('def').set('density', {'rho_f'});
model.material('mat2').propertyGroup('def').set('thermalexpansioncoefficient', {'alpha_f'});

model.mesh('mesh1').autoMeshSize(4);
model.mesh('mesh1').run;

model.study('solidcp1std').label('Cell Periodicity Study for Elastic Properties');
model.study('solidcp1std').feature('solidcp1stat').set('useadvanceddisable', true);
model.study('solidcp1std').feature('solidcp1stat').set('disabledphysics', {'solid/lemm1/te1' 'solid/cp2'});

model.sol('solidcp1sol').feature('s1').feature('i1').active(true);

model.batch('solidcp1p').run('compute');

model.result.create('pg1', 'PlotGroup3D');
model.result('pg1').set('data', 'dset2');
model.result('pg1').setIndex('looplevel', 6, 0);
model.result('pg1').setIndex('looplevel', 4, 1);
model.result('pg1').setIndex('looplevel', 5, 2);
model.result('pg1').set('defaultPlotID', 'stress');
model.result('pg1').label('Stress (solid)');
model.result('pg1').set('frametype', 'spatial');
model.result('pg1').create('vol1', 'Volume');
model.result('pg1').feature('vol1').set('expr', {'solid.misesGp'});
model.result('pg1').feature('vol1').set('threshold', 'manual');
model.result('pg1').feature('vol1').set('thresholdvalue', 0.2);
model.result('pg1').feature('vol1').set('colortable', 'Rainbow');
model.result('pg1').feature('vol1').set('colortabletrans', 'none');
model.result('pg1').feature('vol1').set('colorscalemode', 'linear');
model.result('pg1').feature('vol1').set('resolution', 'custom');
model.result('pg1').feature('vol1').set('refine', 2);
model.result('pg1').feature('vol1').set('colortable', 'Prism');
model.result('pg1').feature('vol1').create('def', 'Deform');
model.result('pg1').feature('vol1').feature('def').set('expr', {'u' 'v' 'w'});
model.result('pg1').feature('vol1').feature('def').set('descr', 'Displacement field');
model.result.evaluationGroup.create('solidcp1stdEg', 'EvaluationGroup');
model.result.evaluationGroup('solidcp1stdEg').set('defaultPlotID', 'homogenizedMaterialTablecp1');
model.result.evaluationGroup('solidcp1stdEg').set('data', 'dset2');
model.result.evaluationGroup('solidcp1stdEg').set('includeparameters', 'off');
model.result.evaluationGroup('solidcp1stdEg').setIndex('looplevelinput', 'last', 0);
model.result.evaluationGroup('solidcp1stdEg').setIndex('looplevelinput', 'last', 1);
model.result.evaluationGroup('solidcp1stdEg').setIndex('looplevelinput', 'last', 2);
model.result.evaluationGroup('solidcp1stdEg').label('Material Properties (Cell Periodicity Study for Elastic Properties)');
model.result.evaluationGroup('solidcp1stdEg').create('gmevcp1', 'EvalGlobalMatrix');
model.result.evaluationGroup('solidcp1stdEg').feature('gmevcp1').set('expr', 'root.comp1.solid.cp1.D');
model.result.evaluationGroup('solidcp1stdEg').feature('gmevcp1').set('descr', 'Elasticity matrix');
model.result.evaluationGroup('solidcp1stdEg').run;
model.result('pg1').run;

model.study.create('std1');
model.study('std1').create('stat', 'Stationary');
model.study('std1').feature('stat').setSolveFor('/physics/solid', true);

model.geom('geom1').run;

model.study('std1').label('Cell Periodicity Study for Thermal Properties');
model.study('std1').create('param', 'Parametric');
model.study('std1').feature('param').set('sweeptype', 'filled');
model.study('std1').feature('param').setIndex('pname', 'th', 0);
model.study('std1').feature('param').setIndex('plistarr', '', 0);
model.study('std1').feature('param').setIndex('punit', 'm', 0);
model.study('std1').feature('param').setIndex('pname', 'th', 0);
model.study('std1').feature('param').setIndex('plistarr', '', 0);
model.study('std1').feature('param').setIndex('punit', 'm', 0);
model.study('std1').feature('param').setIndex('plistarr', 'range(4,2,12)', 0);
model.study('std1').feature('param').setIndex('punit', 'mm', 0);
model.study('std1').feature('param').setIndex('pname', 'L', 1);
model.study('std1').feature('param').setIndex('plistarr', '', 1);
model.study('std1').feature('param').setIndex('punit', 'm', 1);
model.study('std1').feature('param').setIndex('pname', 'L', 1);
model.study('std1').feature('param').setIndex('plistarr', '', 1);
model.study('std1').feature('param').setIndex('punit', 'm', 1);
model.study('std1').feature('param').setIndex('pname', 'nu_f', 1);
model.study('std1').feature('param').setIndex('plistarr', '0.3 -0.3 -0.5 -0.75', 1);
model.study('std1').feature('param').setIndex('punit', 1, 1);
model.study('std1').feature('stat').set('useadvanceddisable', true);
model.study('std1').feature('stat').set('disabledphysics', {'solid/cp1'});

model.sol.create('sol21');
model.sol('sol21').study('std1');
model.sol('sol21').create('st1', 'StudyStep');
model.sol('sol21').feature('st1').set('study', 'std1');
model.sol('sol21').feature('st1').set('studystep', 'stat');
model.sol('sol21').create('v1', 'Variables');
model.sol('sol21').feature('v1').set('control', 'stat');
model.sol('sol21').create('s1', 'Stationary');
model.sol('sol21').feature('s1').feature('aDef').set('cachepattern', true);
model.sol('sol21').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol21').feature('s1').feature('fc1').set('termonres', 'auto');
model.sol('sol21').feature('s1').feature('fc1').set('reserrfact', 1000);
model.sol('sol21').feature('s1').create('d1', 'Direct');
model.sol('sol21').feature('s1').feature('d1').set('linsolver', 'mumps');
model.sol('sol21').feature('s1').feature('d1').label('Suggested Direct Solver (solid)');
model.sol('sol21').feature('s1').create('i1', 'Iterative');
model.sol('sol21').feature('s1').feature('i1').set('linsolver', 'fgmres');
model.sol('sol21').feature('s1').feature('i1').set('rhob', 400);
model.sol('sol21').feature('s1').feature('i1').set('nlinnormuse', true);
model.sol('sol21').feature('s1').feature('i1').label('Suggested Iterative Solver (solid)');
model.sol('sol21').feature('s1').feature('i1').create('mg1', 'Multigrid');
model.sol('sol21').feature('s1').feature('i1').feature('mg1').set('prefun', 'gmg');
model.sol('sol21').feature('s1').feature('i1').feature('mg1').feature('pr').create('so1', 'SOR');
model.sol('sol21').feature('s1').feature('i1').feature('mg1').feature('pr').feature('so1').set('relax', 0.8);
model.sol('sol21').feature('s1').feature('i1').feature('mg1').feature('po').create('so1', 'SOR');
model.sol('sol21').feature('s1').feature('i1').feature('mg1').feature('po').feature('so1').set('relax', 0.8);
model.sol('sol21').feature('s1').feature('i1').feature('mg1').feature('cs').create('d1', 'Direct');
model.sol('sol21').feature('s1').feature('i1').feature('mg1').feature('cs').feature('d1').set('linsolver', 'pardiso');
model.sol('sol21').feature('s1').feature('i1').feature('mg1').feature('cs').feature('d1').set('pivotperturb', 1.0E-9);
model.sol('sol21').feature('s1').feature('fc1').set('linsolver', 'd1');
model.sol('sol21').feature('s1').feature('fc1').set('termonres', 'auto');
model.sol('sol21').feature('s1').feature('fc1').set('reserrfact', 1000);
model.sol('sol21').feature('s1').feature.remove('fcDef');
model.sol('sol21').attach('std1');

model.batch.create('p1', 'Parametric');
model.batch('p1').study('std1');
model.batch('p1').create('so1', 'Solutionseq');
model.batch('p1').feature('so1').set('seq', 'sol21');
model.batch('p1').feature('so1').set('store', 'on');
model.batch('p1').feature('so1').set('clear', 'on');
model.batch('p1').feature('so1').set('psol', 'none');
model.batch('p1').set('pname', {'th' 'nu_f'});
model.batch('p1').set('plistarr', {'range(4,2,12)' '0.3 -0.3 -0.5 -0.75'});
model.batch('p1').set('sweeptype', 'filled');
model.batch('p1').set('probesel', 'all');
model.batch('p1').set('probes', {});
model.batch('p1').set('plot', 'off');
model.batch('p1').set('err', 'on');
model.batch('p1').attach('std1');
model.batch('p1').set('control', 'param');

model.sol.create('sol22');
model.sol('sol22').study('std1');
model.sol('sol22').label('Parametric Solutions 1');

model.batch('p1').feature('so1').set('psol', 'sol22');
model.batch('p1').run('compute');

model.result.create('pg2', 'PlotGroup3D');
model.result('pg2').set('data', 'dset4');
model.result('pg2').setIndex('looplevel', 4, 0);
model.result('pg2').setIndex('looplevel', 5, 1);
model.result('pg2').set('defaultPlotID', 'stress');
model.result('pg2').label('Stress (solid) 1');
model.result('pg2').set('frametype', 'spatial');
model.result('pg2').create('vol1', 'Volume');
model.result('pg2').feature('vol1').set('expr', {'solid.misesGp'});
model.result('pg2').feature('vol1').set('threshold', 'manual');
model.result('pg2').feature('vol1').set('thresholdvalue', 0.2);
model.result('pg2').feature('vol1').set('colortable', 'Rainbow');
model.result('pg2').feature('vol1').set('colortabletrans', 'none');
model.result('pg2').feature('vol1').set('colorscalemode', 'linear');
model.result('pg2').feature('vol1').set('resolution', 'custom');
model.result('pg2').feature('vol1').set('refine', 2);
model.result('pg2').feature('vol1').set('colortable', 'Prism');
model.result('pg2').feature('vol1').create('def', 'Deform');
model.result('pg2').feature('vol1').feature('def').set('expr', {'u' 'v' 'w'});
model.result('pg2').feature('vol1').feature('def').set('descr', 'Displacement field');
model.result.evaluationGroup.create('std1Eg', 'EvaluationGroup');
model.result.evaluationGroup('std1Eg').set('defaultPlotID', 'homogenizedMaterialTablecp2');
model.result.evaluationGroup('std1Eg').set('data', 'dset4');
model.result.evaluationGroup('std1Eg').set('includeparameters', 'off');
model.result.evaluationGroup('std1Eg').setIndex('looplevelinput', 'last', 0);
model.result.evaluationGroup('std1Eg').setIndex('looplevelinput', 'last', 1);
model.result.evaluationGroup('std1Eg').label('Material Properties (Cell Periodicity Study for Thermal Properties)');
model.result.evaluationGroup('std1Eg').create('gmevcp2', 'EvalGlobalMatrix');
model.result.evaluationGroup('std1Eg').feature('gmevcp2').set('expr', 'root.comp1.solid.cp2.alpha');
model.result.evaluationGroup('std1Eg').feature('gmevcp2').set('descr', 'Coefficient of thermal expansion');
model.result.evaluationGroup('std1Eg').run;
model.result('pg2').run;
model.result('pg1').run;
model.result('pg1').setIndex('looplevel', 1, 2);
model.result('pg1').setIndex('looplevel', 1, 0);
model.result('pg1').setIndex('looplevel', 1, 1);
model.result('pg1').run;
model.result('pg2').run;
model.result('pg2').setIndex('looplevel', 1, 1);
model.result('pg2').setIndex('looplevel', 1, 0);
model.result('pg2').run;
model.result.create('pg3', 'PlotGroup1D');
model.result('pg3').run;
model.result('pg3').label('Homogenized Young''s Modulus vs. TPMS Volume Fraction');
model.result('pg3').set('data', 'dset2');
model.result('pg3').setIndex('looplevelinput', 'first', 0);
model.result('pg3').set('titletype', 'label');
model.result('pg3').set('xlabelactive', true);
model.result('pg3').set('xlabel', 'v<sub>f</sub>');
model.result('pg3').set('ylabelactive', true);
model.result('pg3').set('ylabel', 'E<sub>h</sub>/E<sub>m</sub>');
model.result('pg3').set('legendpos', 'upperleft');
model.result('pg3').create('glob1', 'Global');
model.result('pg3').feature('glob1').set('markerpos', 'datapoints');
model.result('pg3').feature('glob1').set('linewidth', 'preference');
model.result('pg3').feature('glob1').setIndex('expr', 'E_h/E_m', 0);
model.result('pg3').feature('glob1').setIndex('unit', 1, 0);
model.result('pg3').feature('glob1').setIndex('descr', '', 0);
model.result('pg3').feature('glob1').set('xdatasolnumtype', 'level3');
model.result('pg3').feature('glob1').set('xdata', 'expr');
model.result('pg3').feature('glob1').set('xdataexpr', 'v_f');
model.result('pg3').feature('glob1').set('linemarker', 'cycle');
model.result('pg3').feature('glob1').set('markerpos', 'interp');
model.result('pg3').feature('glob1').set('legendmethod', 'manual');
model.result('pg3').feature('glob1').setIndex('legends', '\nu<sub>f</sub>= 0.3', 0);
model.result('pg3').feature('glob1').setIndex('legends', '\nu<sub>f</sub>= -0.3', 1);
model.result('pg3').feature('glob1').setIndex('legends', '\nu<sub>f</sub>= -0.5', 2);
model.result('pg3').feature('glob1').setIndex('legends', '\nu<sub>f</sub>= -0.75', 3);
model.result('pg3').run;
model.result('pg3').run;
model.result.duplicate('pg4', 'pg3');
model.result('pg4').run;
model.result('pg4').label('Homogenized Poisson''s Ratio vs. TPMS Volume Fraction');
model.result('pg4').set('ylabel', '\nu<sub>h</sub>');
model.result('pg4').set('legendpos', 'lowerleft');
model.result('pg4').run;
model.result('pg4').feature('glob1').setIndex('expr', 'nu_h', 0);
model.result('pg4').feature('glob1').setIndex('unit', 1, 0);
model.result('pg4').feature('glob1').setIndex('descr', '', 0);
model.result('pg4').run;
model.result('pg3').run;
model.result.duplicate('pg5', 'pg3');
model.result('pg5').run;
model.result('pg5').label('Homogenized Shear Modulus vs. TPMS Volume Fraction');
model.result('pg5').set('ylabel', 'G<sub>h</sub>/G<sub>m</sub>');
model.result('pg5').run;
model.result('pg5').feature('glob1').setIndex('expr', 'G_h/G_m', 0);
model.result('pg5').feature('glob1').setIndex('unit', 1, 0);
model.result('pg5').feature('glob1').setIndex('descr', '', 0);
model.result('pg5').run;
model.result('pg3').run;
model.result.duplicate('pg6', 'pg3');
model.result('pg6').run;
model.result('pg6').label('Homogenized Coefficient of Thermal Expansion vs. TPMS Volume Fraction');
model.result('pg6').set('data', 'none');
model.result('pg6').set('ylabel', '\alpha<sub>h</sub>/\alpha<sub>m</sub>');
model.result('pg6').set('legendpos', 'upperright');
model.result('pg6').run;
model.result('pg6').feature('glob1').setIndex('expr', 'alpha_h/alpha_m', 0);
model.result('pg6').run;
model.result('pg6').set('data', 'dset4');
model.result('pg6').run;
model.result('pg6').feature('glob1').set('xdatasolnumtype', 'level2');
model.result('pg6').run;
model.result('pg2').run;

model.title('Micromechanical Model of a Triply-Periodic-Minimal-Surface-Based Composite');

model.description(['In this example, the homogenized elastic and thermal properties of a composite material based on a triply periodic minimal surface (TPMS) are computed.' newline  newline 'A gyroid TPMS-based unit cell is subjected to periodic boundary conditions to get the homogenized material properties. The effects of a negative Poisson''s ratio and different volume fractions on the homogenized properties are analyzed.']);

model.mesh.clearMeshes;

model.sol('solidcp1sol').clearSolutionData;
model.sol('solidcp1solp').clearSolutionData;
model.sol('sol1').clearSolutionData;
model.sol('sol2').clearSolutionData;
model.sol('sol3').clearSolutionData;
model.sol('sol4').clearSolutionData;
model.sol('sol5').clearSolutionData;
model.sol('sol6').clearSolutionData;
model.sol('sol7').clearSolutionData;
model.sol('sol8').clearSolutionData;
model.sol('sol9').clearSolutionData;
model.sol('sol10').clearSolutionData;
model.sol('sol11').clearSolutionData;
model.sol('sol12').clearSolutionData;
model.sol('sol13').clearSolutionData;
model.sol('sol14').clearSolutionData;
model.sol('sol15').clearSolutionData;
model.sol('sol16').clearSolutionData;
model.sol('sol17').clearSolutionData;
model.sol('sol18').clearSolutionData;
model.sol('sol19').clearSolutionData;
model.sol('sol20').clearSolutionData;
model.sol('sol21').clearSolutionData;
model.sol('sol22').clearSolutionData;
model.sol('sol23').clearSolutionData;
model.sol('sol24').clearSolutionData;
model.sol('sol25').clearSolutionData;
model.sol('sol26').clearSolutionData;
model.sol('sol27').clearSolutionData;
model.sol('sol28').clearSolutionData;
model.sol('sol29').clearSolutionData;
model.sol('sol30').clearSolutionData;
model.sol('sol31').clearSolutionData;
model.sol('sol32').clearSolutionData;
model.sol('sol33').clearSolutionData;
model.sol('sol34').clearSolutionData;
model.sol('sol35').clearSolutionData;
model.sol('sol36').clearSolutionData;
model.sol('sol37').clearSolutionData;
model.sol('sol38').clearSolutionData;
model.sol('sol39').clearSolutionData;
model.sol('sol40').clearSolutionData;
model.sol('sol41').clearSolutionData;
model.sol('sol42').clearSolutionData;

model.label('micromechanical_model_of_a_tpms_composite.mph');

model.modelNode.label('Components');

out = model;
