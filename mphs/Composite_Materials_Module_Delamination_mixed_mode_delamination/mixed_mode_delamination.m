function out = model
%
% mixed_mode_delamination.m
%
% Model exported on May 26 2025, 21:27 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/Composite_Materials_Module/Delamination');

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
model.sol('sol1').runFromTo('st1', 'v1');

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
model.result('pg3').feature('glob1').setIndex('descr', 'Load', 0);
model.result('pg3').feature('glob1').set('xdata', 'expr');
model.result('pg3').feature('glob1').set('xdataexpr', 'u_lp');
model.result('pg3').feature('glob1').set('legend', false);
model.result('pg3').run;
model.result('pg3').run;
model.result.numerical.create('gev1', 'EvalGlobal');
model.result.numerical('gev1').setIndex('expr', '2*F_lp', 0);
model.result.numerical('gev1').setIndex('descr', 'Load', 0);
model.result.numerical('gev1').set('dataseries', 'maximum');
model.result.table.create('tbl1', 'Table');
model.result.table('tbl1').comments('Global Evaluation 1');
model.result.numerical('gev1').set('table', 'tbl1');
model.result.numerical('gev1').setResult;

model.title('Mixed-Mode Debonding of a Laminated Composite');

model.description('Interfacial failure by delamination or debonding can be simulated with a Cohesive Zone Model (CZM). This example shows the implementation of a CZM with a bilinear traction-separation law. It is used to predict the mixed-mode softening onset and delamination propagation in a composite material.');

model.label('cohesive_zone_debonding.mph');

model.modelNode('comp1').label('Component [Solid Mechanics]');

model.study('std1').label('Study [Solid Mechanics]');

model.result('pg1').run;

model.nodeGroup.create('grp1', 'Results');
model.nodeGroup('grp1').set('type', 'plotgroup');
model.nodeGroup('grp1').add('plotgroup', 'pg1');
model.nodeGroup('grp1').add('plotgroup', 'pg2');
model.nodeGroup('grp1').label('Solid Mechanics Plots');

model.modelNode.create('comp2', true);

model.geom.create('geom2', 3);
model.geom('geom2').model('comp2');

model.mesh.create('mesh2', 'geom2');

model.modelNode('comp2').label('Component [Layered Shell]');

model.geom('geom2').create('wp1', 'WorkPlane');
model.geom('geom2').feature('wp1').set('unite', true);
model.geom('geom2').feature('wp1').geom.create('r1', 'Rectangle');
model.geom('geom2').feature('wp1').geom.feature('r1').set('size', {'lb' 'wb/2'});
model.geom('geom2').feature('wp1').geom.run('r1');
model.geom('geom2').feature('wp1').geom.create('r2', 'Rectangle');
model.geom('geom2').feature('wp1').geom.feature('r2').set('size', {'lb/2-cl' 'wb/2'});
model.geom('geom2').feature('wp1').geom.feature('r2').set('pos', {'cl' '0'});
model.geom('geom2').feature('wp1').geom.run('r2');
model.geom('geom2').feature('wp1').geom.create('uni1', 'Union');
model.geom('geom2').feature('wp1').geom.feature('uni1').selection('input').set({'r1' 'r2'});
model.geom('geom2').run('fin');

model.cpl.create('intop3', 'Integration', 'geom2');
model.cpl('intop3').set('axisym', true);
model.cpl('intop3').label('Integration Edge');
model.cpl('intop3').selection.geom('geom2', 0);
model.cpl('intop3').selection.set([1]);
model.cpl('intop3').set('frame', 'material');
model.cpl.duplicate('intop4', 'intop3');
model.cpl('intop4').label('Integration Center');
model.cpl('intop4').selection.set([5]);

model.variable.create('var2');
model.variable('var2').model('comp2');
model.variable('var2').label('Load Point Variables');
model.variable('var2').set('u_IeL', 'intop3(lshell.atxd1(hb,w2))');
model.variable('var2').descr('u_IeL', 'Displacement at edge [Layered Shell]');
model.variable('var2').set('w_cL', 'intop4(lshell.atxd1(hb,w2))');
model.variable('var2').descr('w_cL', 'Displacement at center [Layered Shell]');
model.variable('var2').set('u_lpL', '(3*ll-lb/2)/4/(lb/2)*u_IeL+((ll+lb/2)/(lb/2))*(-w_cL+u_IeL/4)');
model.variable('var2').descr('u_lpL', 'Load point displacement [Layered Shell]');
model.variable('var2').set('F_lpL', 'forceL*lb/2/ll');
model.variable('var2').descr('F_lpL', 'Load point force [Layered Shell]');

model.material.copy('mat2', 'mat1', '');
model.material.create('lmat1', 'LayeredMaterial', '');
model.material('lmat1').setIndex('thickness', 'hb/2', 0);
model.material('lmat1').setIndex('layername', 'Layer 2', 1);
model.material('lmat1').setIndex('link', 'mat2', 1);
model.material('lmat1').setIndex('rotation', '0.0', 1);
model.material('lmat1').setIndex('thickness', 'hb/2', 1);
model.material('lmat1').setIndex('meshPoints', 2, 1);
model.material('lmat1').setIndex('tag', 'lmat1_2', 1);
model.material('lmat1').setIndex('layername', 'Layer 2', 1);
model.material('lmat1').setIndex('link', 'mat2', 1);
model.material('lmat1').setIndex('rotation', '0.0', 1);
model.material('lmat1').setIndex('thickness', 'hb/2', 1);
model.material('lmat1').setIndex('meshPoints', 2, 1);
model.material('lmat1').setIndex('tag', 'lmat1_2', 1);
model.material.create('llmat1', 'LayeredMaterialLink', 'comp2');

model.coordSystem('sys2').set('mastercoordsystcomp', '1');
model.coordSystem('sys2').set('frametype', 'material');

model.physics.create('lshell', 'LayeredShell', 'geom2');
model.physics('lshell').model('comp2');

model.study('std1').feature('stat').setSolveFor('/physics/lshell', true);

model.physics('lshell').prop('LayerSelection').set('bndType', 'allShell');
model.physics('lshell').create('del1', 'Delamination', 2);
model.physics('lshell').feature('del1').selection.set([1]);
model.physics('lshell').feature('del1').set('InitialState', 'Delaminated');
model.physics('lshell').feature('del1').set('pn', 'pn');
model.physics('lshell').create('del2', 'Delamination', 2);
model.physics('lshell').feature('del2').selection.set([2 3]);
model.physics('lshell').feature('del2').set('StiffnessInput', 'UserDefined');
model.physics('lshell').feature('del2').set('kPerArea', {'pn' 'pn' 'pn'});
model.physics('lshell').feature('del2').set('sigmat', 'sigmat');
model.physics('lshell').feature('del2').set('sigmas', 'sigmas');
model.physics('lshell').feature('del2').set('Gct', 'Gct');
model.physics('lshell').feature('del2').set('Gcs', 'Gcs');
model.physics('lshell').feature('del2').set('FailureCriterion', 'BK');
model.physics('lshell').feature('del2').set('alpha', 'alpha');
model.physics('lshell').feature('del2').set('PenaltyFactor', 'FromAdhesiveStiffness');
model.physics('lshell').create('sym1', 'Symmetry', 1);
model.physics('lshell').feature('sym1').selection.set([2 5 8]);
model.physics('lshell').create('el1', 'EdgeLoad', 1);
model.physics('lshell').feature('el1').label('Load on Cracked Edge (Fe)');
model.physics('lshell').feature('el1').set('LoadType', 'TotalForce');
model.physics('lshell').feature('el1').selection.set([1]);
model.physics('lshell').feature('el1').set('Ftot', {'0' '0' 'forceL'});
model.physics('lshell').feature.duplicate('el2', 'el1');
model.physics('lshell').feature('el2').label('Load on Middle Edge (Fm)');
model.physics('lshell').feature('el2').selection.set([7]);
model.physics('lshell').feature('el2').set('Ftot', {'0' '0' '-lr*forceL'});
model.physics('lshell').create('dispi1', 'DisplacementIntEP', 1);
model.physics('lshell').feature('dispi1').selection.set([1 10]);
model.physics('lshell').feature('dispi1').set('applyTo', 'bottom');
model.physics('lshell').feature('dispi1').setIndex('Direction', 'prescribed', 2);
model.physics('lshell').create('dispi2', 'DisplacementIntEP', 0);
model.physics('lshell').feature('dispi2').selection.set([1]);
model.physics('lshell').feature('dispi2').set('applyTo', 'bottom');
model.physics('lshell').feature('dispi2').setIndex('Direction', 'prescribed', 0);
model.physics('lshell').create('ge1', 'GlobalEquations', -1);
model.physics('lshell').feature('ge1').setIndex('name', 'forceL', 0, 0);
model.physics('lshell').feature('ge1').setIndex('equation', 'disp-u_IeL', 0, 0);
model.physics('lshell').feature('ge1').set('CustomDependentVariableUnit', '1');
model.physics('lshell').feature('ge1').set('DependentVariableQuantity', 'force');
model.physics('lshell').feature('ge1').set('SourceTermQuantity', 'length');

model.mesh('mesh2').create('map1', 'Map');
model.mesh('mesh2').feature('map1').selection.all;
model.mesh('mesh2').feature('map1').create('dis1', 'Distribution');
model.mesh('mesh2').feature('map1').feature('dis1').selection.set([1 4 7 10]);
model.mesh('mesh2').feature('map1').feature('dis1').set('numelem', 3);
model.mesh('mesh2').feature('map1').create('dis2', 'Distribution');
model.mesh('mesh2').feature('map1').feature('dis2').selection.set([2]);
model.mesh('mesh2').feature('map1').feature('dis2').set('numelem', 10);
model.mesh('mesh2').feature('map1').create('dis3', 'Distribution');
model.mesh('mesh2').feature('map1').feature('dis3').selection.set([5]);
model.mesh('mesh2').feature('map1').feature('dis3').set('numelem', 50);
model.mesh('mesh2').feature('map1').create('dis4', 'Distribution');
model.mesh('mesh2').feature('map1').feature('dis4').selection.set([8 9]);
model.mesh('mesh2').feature('map1').feature('dis4').set('type', 'predefined');
model.mesh('mesh2').feature('map1').feature('dis4').set('elemcount', 20);
model.mesh('mesh2').feature('map1').feature('dis4').set('elemratio', 5);
model.mesh('mesh2').run;

model.study('std1').feature('stat').setEntry('activate', 'lshell', false);
model.study.create('std2');
model.study('std2').create('stat', 'Stationary');
model.study('std2').feature('stat').setSolveFor('/physics/solid', true);
model.study('std2').feature('stat').setSolveFor('/physics/lshell', true);
model.study('std2').label('Study [Layered Shell]');
model.study('std2').feature('stat').setEntry('activate', 'solid', false);
model.study('std2').feature('stat').set('useparam', true);
model.study('std2').feature('stat').setIndex('pname', 'lb', 0);
model.study('std2').feature('stat').setIndex('plistarr', '', 0);
model.study('std2').feature('stat').setIndex('punit', 'm', 0);
model.study('std2').feature('stat').setIndex('pname', 'lb', 0);
model.study('std2').feature('stat').setIndex('plistarr', '', 0);
model.study('std2').feature('stat').setIndex('punit', 'm', 0);
model.study('std2').feature('stat').setIndex('pname', 'disp', 0);
model.study('std2').feature('stat').setIndex('plistarr', 'range(0,2e-4,8e-3)', 0);
model.study('std2').feature('stat').setIndex('punit', '', 0);

model.sol.create('sol2');
model.sol('sol2').study('std2');
model.sol('sol2').create('st1', 'StudyStep');
model.sol('sol2').feature('st1').set('study', 'std2');
model.sol('sol2').feature('st1').set('studystep', 'stat');
model.sol('sol2').create('v1', 'Variables');
model.sol('sol2').feature('v1').set('control', 'stat');
model.sol('sol2').create('s1', 'Stationary');
model.sol('sol2').feature('s1').create('p1', 'Parametric');
model.sol('sol2').feature('s1').feature.remove('pDef');
model.sol('sol2').feature('s1').feature('p1').set('control', 'stat');
model.sol('sol2').feature('s1').set('control', 'stat');
model.sol('sol2').feature('s1').feature('aDef').set('cachepattern', true);
model.sol('sol2').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol2').feature('s1').feature('fc1').set('termonres', 'auto');
model.sol('sol2').feature('s1').feature('fc1').set('reserrfact', 1000);
model.sol('sol2').feature('s1').feature('fc1').set('linsolver', 'dDef');
model.sol('sol2').feature('s1').feature('fc1').set('termonres', 'auto');
model.sol('sol2').feature('s1').feature('fc1').set('reserrfact', 1000);
model.sol('sol2').feature('s1').feature.remove('fcDef');
model.sol('sol2').attach('std2');
model.sol('sol2').feature('s1').set('stol', '1e-4');
model.sol('sol2').feature('v1').feature('comp2_u2').set('scalemethod', 'manual');
model.sol('sol2').feature('v1').feature('comp2_u2').set('scaleval', '1e-3');
model.sol('sol2').feature('v1').feature('comp2_ODE1').set('scalemethod', 'manual');
model.sol('sol2').feature('v1').feature('comp2_ODE1').set('scaleval', 200);
model.sol('sol2').feature('s1').feature('p1').set('paramtuning', true);
model.sol('sol2').feature('s1').feature('p1').set('pminstep', '1e-6');
model.sol('sol2').feature('s1').feature('p1').set('porder', 'linear');
model.sol('sol2').feature('s1').feature('fc1').set('dtech', 'const');
model.sol('sol2').runAll;

model.result.dataset.create('dset4lshelllshl', 'LayeredMaterial');
model.result.dataset('dset4lshelllshl').set('data', 'dset4');
model.result.create('pg4', 'PlotGroup3D');
model.result('pg4').set('data', 'dset4lshelllshl');
model.result('pg4').setIndex('looplevel', 41, 0);
model.result('pg4').set('defaultPlotID', 'stress');
model.result('pg4').label('Stress (lshell)');
model.result('pg4').set('frametype', 'spatial');
model.result('pg4').set('showlegends', true);
model.result('pg4').create('surf1', 'Surface');
model.result('pg4').feature('surf1').set('expr', {'lshell.misesGp'});
model.result('pg4').feature('surf1').set('threshold', 'manual');
model.result('pg4').feature('surf1').set('thresholdvalue', 0.2);
model.result('pg4').feature('surf1').set('colortable', 'Rainbow');
model.result('pg4').feature('surf1').set('colortabletrans', 'none');
model.result('pg4').feature('surf1').set('colorscalemode', 'linear');
model.result('pg4').feature('surf1').set('colortable', 'Prism');
model.result('pg4').feature('surf1').create('def', 'Deform');
model.result('pg4').feature('surf1').feature('def').set('scaleactive', true);
model.result('pg4').feature('surf1').feature('def').set('scale', '1');
model.result('pg4').feature('surf1').feature('def').set('expr', {'u2' 'v2' 'w2'});
model.result('pg4').feature('surf1').feature('def').set('descr', 'Displacement field (material and geometry frames)');
model.result('pg4').run;
model.result('pg4').run;
model.result('pg4').feature('surf1').set('unit', 'MPa');
model.result.create('pg5', 'PlotGroup3D');
model.result('pg5').run;
model.result('pg5').label('Interface Health (lshell)');
model.result('pg5').set('data', 'dset4');
model.result('pg5').set('frametype', 'spatial');
model.result('pg5').create('lss1', 'LayeredMaterialSlice');
model.result('pg5').feature('lss1').set('expr', 'lshell.idmg');
model.result('pg5').feature('lss1').set('locdef', 'interfaces');
model.result('pg5').feature('lss1').set('colortable', 'Traffic');
model.result('pg5').run;
model.result('pg4').run;

model.nodeGroup.create('grp2', 'Results');
model.nodeGroup('grp2').set('type', 'plotgroup');
model.nodeGroup('grp2').placeAfter('plotgroup', 'pg3');
model.nodeGroup('grp2').add('plotgroup', 'pg4');
model.nodeGroup('grp2').add('plotgroup', 'pg5');
model.nodeGroup('grp2').label('Layered Shell Plots');
model.nodeGroup('grp2').placeAfter([]);

model.result('pg3').run;
model.result('pg3').set('xlabelactive', true);
model.result('pg3').set('xlabel', 'Point Displacement (m)');
model.result('pg3').set('ylabelactive', true);
model.result('pg3').set('ylabel', 'Point Load (N)');
model.result('pg3').run;
model.result('pg3').feature('glob1').set('titletype', 'manual');
model.result('pg3').feature('glob1').set('title', 'Load Displacement Curve');
model.result('pg3').feature('glob1').set('xdataunit', 'm');
model.result('pg3').feature('glob1').set('legend', true);
model.result('pg3').feature('glob1').set('legendmethod', 'manual');
model.result('pg3').feature('glob1').setIndex('legends', 'Solid Mechanics', 0);
model.result('pg3').feature.duplicate('glob2', 'glob1');
model.result('pg3').run;
model.result('pg3').feature('glob2').set('data', 'dset4');
model.result('pg3').feature('glob2').setIndex('expr', '2*comp2.F_lpL', 0);
model.result('pg3').feature('glob2').setIndex('unit', '', 0);
model.result('pg3').feature('glob2').setIndex('descr', 'Load', 0);
model.result('pg3').feature('glob2').set('xdataexpr', 'comp2.u_lpL');
model.result('pg3').feature('glob2').set('titletype', 'none');
model.result('pg3').feature('glob2').setIndex('legends', 'Layered Shell', 0);
model.result('pg3').run;
model.result.numerical.duplicate('gev2', 'gev1');
model.result.numerical('gev2').set('data', 'dset4');
model.result.numerical('gev2').setIndex('expr', '2*comp2.F_lpL', 0);
model.result.numerical('gev2').setIndex('unit', '', 0);
model.result.numerical('gev2').setIndex('descr', 'Load', 0);
model.result.numerical('gev2').set('table', 'tbl1');
model.result.numerical('gev2').appendResult;
model.result.export.create('anim1', 'Animation');
model.result.export('anim1').set('target', 'player');
model.result.export('anim1').set('fontsize', '9');
model.result.export('anim1').set('colortheme', 'globaltheme');
model.result.export('anim1').set('customcolor', [1 1 1]);
model.result.export('anim1').set('background', 'color');
model.result.export('anim1').set('gltfincludelines', 'on');
model.result.export('anim1').set('title1d', 'on');
model.result.export('anim1').set('legend1d', 'on');
model.result.export('anim1').set('logo1d', 'on');
model.result.export('anim1').set('options1d', 'on');
model.result.export('anim1').set('title2d', 'on');
model.result.export('anim1').set('legend2d', 'on');
model.result.export('anim1').set('logo2d', 'on');
model.result.export('anim1').set('options2d', 'off');
model.result.export('anim1').set('title3d', 'on');
model.result.export('anim1').set('legend3d', 'on');
model.result.export('anim1').set('logo3d', 'on');
model.result.export('anim1').set('options3d', 'off');
model.result.export('anim1').set('axisorientation', 'on');
model.result.export('anim1').set('grid', 'on');
model.result.export('anim1').set('axes1d', 'on');
model.result.export('anim1').set('axes2d', 'on');
model.result.export('anim1').set('showgrid', 'on');
model.result.export('anim1').showFrame;
model.result.export('anim1').label('Animation: Stress [Layered Shell]');
model.result.export('anim1').set('plotgroup', 'pg4');
model.result.export('anim1').set('frametime', 0.3);
model.result.export('anim1').showFrame;
model.result.export('anim1').run;

model.title('Mixed-Mode Delamination of a Composite Laminate');

model.description(['Interfacial failure or delamination in a composite material can be simulated with a Cohesive Zone Model (CZM). This example shows the implementation of a CZM with a bilinear traction-separation law in a layered shell. It is used to predict the mixed-mode softening onset and delamination propagation.' newline  newline 'A corresponding model created in the Solid Mechanics interface is used for comparison.']);

model.mesh.clearMeshes;

model.sol('sol1').clearSolutionData;
model.sol('sol2').clearSolutionData;

model.label('mixed_mode_delamination.mph');

model.modelNode.label('Components');

out = model;
