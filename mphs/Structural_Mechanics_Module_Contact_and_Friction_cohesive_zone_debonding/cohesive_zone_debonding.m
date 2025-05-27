function out = model
%
% cohesive_zone_debonding.m
%
% Model exported on May 26 2025, 21:33 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/Structural_Mechanics_Module/Contact_and_Friction');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 3);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.physics.create('solid', 'SolidMechanics', 'geom1');
model.physics('solid').model('comp1');

model.study.create('std1');
model.study('std1').create('stat', 'Stationary');
model.study('std1').feature('stat').setSolveFor('/physics/solid', true);

% To import content from file, use:
% model.param.loadFile('FILENAME');
model.param.set('lb', '102[mm]', 'Length');
model.param.set('wb', '25.4[mm]', 'Width');
model.param.set('hb', '2*1.56[mm]', 'Thickness');
model.param.set('cl', '34.1[mm]', 'Initial crack length');
model.param.set('pn', '1e6[N/mm^3]', 'Penalty stiffness');
model.param.set('sigmat', '80[MPa]', 'Normal tensile strength');
model.param.set('sigmas', '100[MPa]', 'Shear strength');
model.param.set('Gct', '0.969[kJ/m^2]', 'Critical energy release rate, tension');
model.param.set('Gcs', '1.719[kJ/m^2]', 'Critical energy release rate, shear');
model.param.set('alpha', '2.284', 'Exponent of the Benzeggagh and Kenane (B-K) criterion');
model.param.set('disp', '0', 'Displacement parameter');
model.param.set('mm', '0.5', 'Mode mixity ratio');
model.param.set('ll', 'lb/2*(0.5*sqrt(3*(1-mm)/mm)+1)/(3-0.5*sqrt(3*(1-mm)/mm))', 'Lever length');
model.param.set('lr', '8*((6*mm+sqrt(3*mm*(1-mm)))/(3+9*mm+8*sqrt(3*mm*(1-mm))))', 'Load ratio middle/cracked edge');

model.geom('geom1').lengthUnit('mm');
model.geom('geom1').create('blk1', 'Block');
model.geom('geom1').feature('blk1').set('size', {'lb' 'wb/2' 'hb/2'});
model.geom('geom1').run('blk1');
model.geom('geom1').create('blk2', 'Block');
model.geom('geom1').feature('blk2').set('size', {'lb/2-cl' 'wb/2' '1'});
model.geom('geom1').feature('blk2').setIndex('size', 'hb/2', 2);
model.geom('geom1').feature('blk2').set('pos', {'cl' '0' '0'});
model.geom('geom1').run('blk2');
model.geom('geom1').create('uni1', 'Union');
model.geom('geom1').feature('uni1').selection('input').set({'blk1' 'blk2'});
model.geom('geom1').run('uni1');
model.geom('geom1').create('copy1', 'Copy');
model.geom('geom1').feature('copy1').selection('input').set({'uni1'});
model.geom('geom1').feature('copy1').set('displz', 'hb/2');
model.geom('geom1').feature('fin').set('action', 'assembly');
model.geom('geom1').feature('fin').set('pairtype', 'contact');
model.geom('geom1').run('fin');

model.variable.create('var1');
model.variable('var1').model('comp1');
model.variable('var1').label('Load Point Variables');

% To import content from file, use:
% model.variable('var1').loadFile('FILENAME');
model.variable('var1').set('u_Ie', 'intop1(w)', 'Displacement at edge');
model.variable('var1').set('w_c', 'intop2(w)', 'Displacement at center');
model.variable('var1').set('u_lp', '(3*ll-lb/2)/4/(lb/2)*u_Ie+((ll+lb/2)/(lb/2))*(-w_c+u_Ie/4)', 'Load point displacement');
model.variable('var1').set('F_lp', 'force*lb/2/ll', 'Load point force');

model.cpl.create('intop1', 'Integration', 'geom1');
model.cpl('intop1').set('axisym', true);
model.cpl('intop1').label('Integration Edge');
model.cpl('intop1').selection.geom('geom1', 0);
model.cpl('intop1').selection.set([17]);
model.cpl('intop1').set('frame', 'material');
model.cpl.create('intop2', 'Integration', 'geom1');
model.cpl('intop2').set('axisym', true);
model.cpl('intop2').label('Integration Center');
model.cpl('intop2').selection.geom('geom1', 0);
model.cpl('intop2').selection.set([26]);
model.cpl('intop2').set('frame', 'material');

model.pair('ap1').manualSelection(true);
model.pair('ap1').source.set([9 14]);
model.pair('ap1').destination.set([24 29]);
model.pair('ap1').mapping('initial');
model.pair('ap1').searchTol('1e-2');

model.material.create('mat1', 'Common', 'comp1');
model.material('mat1').label('AS4/PEEK');
model.material('mat1').propertyGroup.create('Orthotropic', 'Orthotropic');
model.material('mat1').propertyGroup('Orthotropic').set('Evector', {'122.7e9' '10.1e9' '10.1e9'});
model.material('mat1').propertyGroup('Orthotropic').set('nuvector', {'0.25' '0.45' '0.25'});
model.material('mat1').propertyGroup('Orthotropic').set('Gvector', {'5.5e9' '3.7e9' '5.5e9'});
model.material('mat1').propertyGroup('def').set('density', {'1570'});

model.physics('solid').feature('lemm1').set('SolidModel', 'Orthotropic');
model.physics('solid').feature('dcnt1').set('penaltyCtrlPenalty', 'userDefined');
model.physics('solid').feature('dcnt1').set('pn_penalty', 'pn');
model.physics('solid').feature('dcnt1').create('adh1', 'Adhesion', 2);
model.physics('solid').feature('dcnt1').feature('adh1').set('ActivationCriterion', 'Always');
model.physics('solid').feature('dcnt1').feature('adh1').set('ntau', 1);
model.physics('solid').feature('dcnt1').create('dch1', 'Decohesion', 2);
model.physics('solid').feature('dcnt1').feature('dch1').set('sigmat', 'sigmat');
model.physics('solid').feature('dcnt1').feature('dch1').set('sigmas', 'sigmas');
model.physics('solid').feature('dcnt1').feature('dch1').set('Gct', 'Gct');
model.physics('solid').feature('dcnt1').feature('dch1').set('Gcs', 'Gcs');
model.physics('solid').feature('dcnt1').feature('dch1').set('FailureCriterion', 'BK');
model.physics('solid').feature('dcnt1').feature('dch1').set('alpha', 'alpha');
model.physics('solid').create('sym1', 'SymmetrySolid', 2);
model.physics('solid').feature('sym1').selection.set([2 7 12 18 23 28]);
model.physics('solid').create('el1', 'EdgeLoad', 1);
model.physics('solid').feature('el1').label('Load on Cracked Edge (Fe)');
model.physics('solid').feature('el1').selection.set([32]);
model.physics('solid').feature('el1').set('LoadType', 'TotalForce');
model.physics('solid').feature('el1').set('Ftot', {'0' '0' 'force'});
model.physics('solid').create('el2', 'EdgeLoad', 1);
model.physics('solid').feature('el2').label('Load on Middle Edge (Fm)');
model.physics('solid').feature('el2').selection.set([48]);
model.physics('solid').feature('el2').set('LoadType', 'TotalForce');
model.physics('solid').feature('el2').set('Ftot', {'0' '0' '-lr*force'});
model.physics('solid').create('disp1', 'Displacement1', 1);
model.physics('solid').feature('disp1').selection.set([2 26]);
model.physics('solid').feature('disp1').setIndex('Direction', 'prescribed', 2);
model.physics('solid').create('disp2', 'Displacement0', 0);
model.physics('solid').feature('disp2').selection.set([1]);
model.physics('solid').feature('disp2').setIndex('Direction', 'prescribed', 0);
model.physics('solid').create('ge1', 'GlobalEquations', -1);
model.physics('solid').feature('ge1').setIndex('name', 'force', 0, 0);
model.physics('solid').feature('ge1').setIndex('equation', 'disp-u_Ie', 0, 0);
model.physics('solid').feature('ge1').set('DependentVariableQuantity', 'force');
model.physics('solid').feature('ge1').set('SourceTermQuantity', 'length');

model.mesh('mesh1').create('map1', 'Map');
model.mesh('mesh1').feature('map1').selection.set([4 9 14 19 24 29]);
model.mesh('mesh1').feature('map1').create('dis1', 'Distribution');
model.mesh('mesh1').feature('map1').feature('dis1').selection.set([4 30]);
model.mesh('mesh1').feature('map1').feature('dis1').set('numelem', 3);
model.mesh('mesh1').feature('map1').create('dis2', 'Distribution');
model.mesh('mesh1').feature('map1').feature('dis2').selection.set([5 31]);
model.mesh('mesh1').feature('map1').feature('dis2').set('numelem', 10);
model.mesh('mesh1').feature('map1').create('dis3', 'Distribution');
model.mesh('mesh1').feature('map1').feature('dis3').selection.set([13 39]);
model.mesh('mesh1').feature('map1').feature('dis3').set('numelem', 50);
model.mesh('mesh1').feature('map1').create('dis4', 'Distribution');
model.mesh('mesh1').feature('map1').feature('dis4').set('type', 'predefined');
model.mesh('mesh1').feature('map1').feature('dis4').selection.set([21 24 47 51]);
model.mesh('mesh1').feature('map1').feature('dis4').set('elemcount', 20);
model.mesh('mesh1').feature('map1').feature('dis4').set('elemratio', 5);
model.mesh('mesh1').create('swe1', 'Sweep');
model.mesh('mesh1').feature('swe1').create('dis1', 'Distribution');
model.mesh('mesh1').feature('swe1').feature('dis1').set('numelem', 2);
model.mesh('mesh1').run;

model.study('std1').feature('stat').set('useparam', true);
model.study('std1').feature('stat').setIndex('pname', 'lb', 0);
model.study('std1').feature('stat').setIndex('plistarr', '', 0);
model.study('std1').feature('stat').setIndex('punit', 'm', 0);
model.study('std1').feature('stat').setIndex('pname', 'lb', 0);
model.study('std1').feature('stat').setIndex('plistarr', '', 0);
model.study('std1').feature('stat').setIndex('punit', 'm', 0);
model.study('std1').feature('stat').setIndex('pname', 'disp', 0);
model.study('std1').feature('stat').setIndex('plistarr', 'range(0,2e-4,8e-3)', 0);
model.study('std1').feature('stat').set('plot', true);

model.sol.create('sol1');
model.sol('sol1').study('std1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'stat');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').feature('comp1_u').set('scalemethod', 'manual');
model.sol('sol1').feature('v1').feature('comp1_u').set('scaleval', '1e-2*0.102834937642807');
model.sol('sol1').feature('v1').set('control', 'stat');
model.sol('sol1').create('s1', 'Stationary');
model.sol('sol1').feature('s1').create('p1', 'Parametric');
model.sol('sol1').feature('s1').feature.remove('pDef');
model.sol('sol1').feature('s1').feature('p1').set('porder', 'constant');
model.sol('sol1').feature('s1').feature('p1').set('control', 'stat');
model.sol('sol1').feature('s1').set('control', 'stat');
model.sol('sol1').feature('s1').feature('aDef').set('cachepattern', true);
model.sol('sol1').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('s1').feature('fc1').set('dtech', 'auto');
model.sol('sol1').feature('s1').create('d1', 'Direct');
model.sol('sol1').feature('s1').feature('d1').set('linsolver', 'pardiso');
model.sol('sol1').feature('s1').feature('d1').set('pivotperturb', 1.0E-9);
model.sol('sol1').feature('s1').feature('d1').set('nliniterrefine', true);
model.sol('sol1').feature('s1').feature('d1').label('Suggested Direct Solver (solid)');
model.sol('sol1').feature('s1').create('i1', 'Iterative');
model.sol('sol1').feature('s1').feature('i1').set('linsolver', 'gmres');
model.sol('sol1').feature('s1').feature('i1').set('prefuntype', 'right');
model.sol('sol1').feature('s1').feature('i1').set('rhob', 40);
model.sol('sol1').feature('s1').feature('i1').set('nlinnormuse', true);
model.sol('sol1').feature('s1').feature('i1').label('Suggested Iterative Solver (solid)');
model.sol('sol1').feature('s1').feature('i1').create('mg1', 'Multigrid');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').set('prefun', 'gmg');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('pr').create('so1', 'SOR');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('pr').feature('so1').set('iter', 1);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('po').create('so1', 'SOR');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('po').feature('so1').set('iter', 1);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('cs').create('mg1', 'Multigrid');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('cs').feature('mg1').set('prefun', 'saamg');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('cs').feature('mg1').set('usesmooth', false);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('cs').feature('mg1').set('iter', 2);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('cs').feature('mg1').set('mglevels', 2);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('cs').feature('mg1').set('maxcoarsedof', 10000);
model.sol('sol1').feature('s1').feature('fc1').set('linsolver', 'd1');
model.sol('sol1').feature('s1').feature('fc1').set('dtech', 'auto');
model.sol('sol1').feature('s1').feature.remove('fcDef');
model.sol('sol1').attach('std1');
model.sol('sol1').feature('s1').set('stol', '1e-4');
model.sol('sol1').feature('v1').feature('comp1_ODE1').set('scalemethod', 'manual');
model.sol('sol1').feature('v1').feature('comp1_ODE1').set('scaleval', 200);
model.sol('sol1').feature('s1').feature('p1').set('paramtuning', true);
model.sol('sol1').feature('s1').feature('p1').set('pminstep', '1e-6');
model.sol('sol1').feature('s1').feature('p1').set('porder', 'linear');
model.sol('sol1').feature('s1').feature('fc1').set('dtech', 'const');

model.result.create('pg1', 'PlotGroup3D');
model.result('pg1').set('data', 'dset1');
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
model.result('pg1').feature('vol1').feature('def').set('scaleactive', true);
model.result('pg1').feature('vol1').feature('def').set('scale', '1');
model.result('pg1').feature('vol1').feature('def').set('expr', {'u' 'v' 'w'});
model.result('pg1').feature('vol1').feature('def').set('descr', 'Displacement field');

model.sol('sol1').runFromTo('st1', 'v1');

model.result.remove('pg1');

model.study('std1').feature('stat').set('plotgroup', 'Default');

model.result.create('pg1', 'PlotGroup3D');
model.result('pg1').set('data', 'dset1');
model.result('pg1').setIndex('looplevel', 1, 0);
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
model.result('pg1').feature('vol1').feature('def').set('scaleactive', true);
model.result('pg1').feature('vol1').feature('def').set('scale', '1');
model.result('pg1').feature('vol1').feature('def').set('expr', {'u' 'v' 'w'});
model.result('pg1').feature('vol1').feature('def').set('descr', 'Displacement field');
model.result('pg1').run;
model.result.dataset('dset1').set('frametype', 'spatial');
model.result('pg1').run;
model.result('pg1').feature('vol1').feature('def').set('scale', 0);

model.sol('sol1').runAll;

model.result('pg1').run;
model.result('pg1').run;
model.result('pg1').feature('vol1').set('unit', 'GPa');
model.result('pg1').run;
model.result.dataset.duplicate('dset2', 'dset1');
model.result.dataset('dset2').set('frametype', 'material');
model.result.create('pg2', 'PlotGroup3D');
model.result('pg2').run;
model.result('pg2').label('Interface Health');
model.result('pg2').set('data', 'dset2');
model.result('pg2').create('surf1', 'Surface');
model.result('pg2').feature('surf1').set('expr', 'solid.bdmg');
model.result('pg2').feature('surf1').set('descr', 'Damage');
model.result('pg2').feature('surf1').set('colortable', 'Traffic');
model.result('pg2').run;
model.result.create('pg3', 'PlotGroup1D');
model.result('pg3').run;
model.result('pg3').label('Load Displacement Curve');
model.result('pg3').set('titletype', 'manual');
model.result('pg3').set('title', 'Load displacement curve');
model.result('pg3').create('glob1', 'Global');
model.result('pg3').feature('glob1').set('markerpos', 'datapoints');
model.result('pg3').feature('glob1').set('linewidth', 'preference');
model.result('pg3').feature('glob1').setIndex('expr', '2*F_lp', 0);
model.result('pg3').feature('glob1').setIndex('unit', 'N', 0);
model.result('pg3').feature('glob1').setIndex('descr', 'Load', 0);
model.result('pg3').feature('glob1').set('xdata', 'expr');
model.result('pg3').feature('glob1').set('xdataexpr', 'u_lp');
model.result('pg3').feature('glob1').set('legend', false);
model.result('pg3').run;
model.result('pg3').run;
model.result.numerical.create('gev1', 'EvalGlobal');
model.result.numerical('gev1').setIndex('expr', '2*F_lp', 0);
model.result.numerical('gev1').setIndex('unit', 'N', 0);
model.result.numerical('gev1').setIndex('descr', 'Load', 0);
model.result.numerical('gev1').set('dataseries', 'maximum');
model.result.table.create('tbl1', 'Table');
model.result.table('tbl1').comments('Global Evaluation 1');
model.result.numerical('gev1').set('table', 'tbl1');
model.result.numerical('gev1').setResult;

model.title('Mixed-Mode Debonding of a Laminated Composite');

model.description('Interfacial failure by delamination or debonding can be simulated with a Cohesive Zone Model (CZM). This example shows the implementation of a CZM with a bilinear traction-separation law. It is used to predict the mixed-mode softening onset and delamination propagation in a composite material.');

model.mesh.clearMeshes;

model.sol('sol1').clearSolutionData;

model.label('cohesive_zone_debonding.mph');

model.modelNode.label('Components');

out = model;
