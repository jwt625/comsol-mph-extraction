function out = model
%
% pore_scale_flow_3d.m
%
% Model exported on May 26 2025, 21:34 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/Subsurface_Flow_Module/Fluid_Flow');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 3);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.physics.create('spf', 'CreepingFlow', 'geom1');
model.physics('spf').model('comp1');

model.study.create('std1');
model.study('std1').create('stat', 'Stationary');
model.study('std1').feature('stat').setSolveFor('/physics/spf', true);

model.geom('geom1').lengthUnit('cm');
model.geom('geom1').run;

model.mesh('mesh1').create('imp1', 'Import');
model.mesh('mesh1').feature('imp1').set('filename', 'pore_scale_flow_3d.stl');
model.mesh('mesh1').feature('imp1').set('createdom', true);
model.mesh('mesh1').feature('imp1').set('facepartition', 'detectfaces');
model.mesh('mesh1').feature('imp1').set('stltoltype', 'absolute');
model.mesh('mesh1').feature('imp1').set('stltolabs', '1e-5');
model.mesh('mesh1').feature('imp1').set('facemaxangle', 62);
model.mesh('mesh1').feature('imp1').importData;

model.view('view1').set('rendermesh', true);

model.mesh('mesh1').create('join1', 'JoinEntities');
model.mesh('mesh1').feature('join1').selection.geom('geom1', 2);
model.mesh('mesh1').feature('join1').selection.set([14 15 16 17 18 19 20]);
model.mesh('mesh1').run('join1');
model.mesh('mesh1').create('ftri1', 'FreeTri');
model.mesh('mesh1').feature('ftri1').set('narrowreg', true);
model.mesh('mesh1').feature('ftri1').selection.all;
model.mesh('mesh1').feature('ftri1').feature('size').set('table', 'cfd');
model.mesh('mesh1').feature('ftri1').feature('size').set('hauto', 4);
model.mesh('mesh1').feature('ftri1').create('size1', 'Size');
model.mesh('mesh1').feature('ftri1').feature('size1').selection.set([14 36 37]);
model.mesh('mesh1').feature('ftri1').feature('size1').set('custom', true);
model.mesh('mesh1').feature('ftri1').feature('size1').set('hmaxactive', true);
model.mesh('mesh1').feature('ftri1').feature('size1').set('hmax', '0.04[cm]');
model.mesh('mesh1').run('ftri1');
model.mesh('mesh1').create('ftet1', 'FreeTet');
model.mesh('mesh1').feature('ftet1').feature('size').set('table', 'cfd');
model.mesh('mesh1').feature('ftet1').feature('size').set('hauto', 4);
model.mesh('mesh1').run('ftet1');
model.mesh('mesh1').create('bl1', 'BndLayer');
model.mesh('mesh1').feature('bl1').create('blp', 'BndLayerProp');
model.mesh('mesh1').feature('bl1').feature('blp').selection.set([14 36 37]);
model.mesh('mesh1').feature('bl1').feature('blp').set('blnlayers', 1);
model.mesh('mesh1').feature('bl1').feature('blp').set('blhminfact', 10);
model.mesh('mesh1').run('bl1');

model.result.dataset.create('mesh1', 'Mesh');
model.result.dataset('mesh1').set('mesh', 'mesh1');
model.result.create('pg1', 'PlotGroup3D');
model.result('pg1').label('Mesh Plot 1');
model.result('pg1').set('data', 'mesh1');
model.result('pg1').set('inherithide', true);
model.result('pg1').set('showlegendsmaxmin', true);
model.result('pg1').create('mesh1', 'Mesh');
model.result('pg1').feature('mesh1').set('colortable', 'TrafficFlow');
model.result('pg1').feature('mesh1').set('colortabletrans', 'nonlinear');
model.result('pg1').feature('mesh1').set('nonlinearcolortablerev', true);
model.result('pg1').feature('mesh1').set('meshdomain', 'volume');
model.result('pg1').run;

model.param.set('rho_f', '1000[kg/m^3]');
model.param.descr('rho_f', 'Fluid density');
model.param.set('mu_f', '1e-3[Pa*s]');
model.param.descr('mu_f', 'Fluid viscosity');
model.param.set('u_in', '1e-4[m/s]');
model.param.descr('u_in', 'Inlet velocity');
model.param.set('width', '2[cm]');
model.param.descr('width', 'REV width');
model.param.set('length', '6[cm]');
model.param.descr('length', 'REV length');
model.param.set('V_tot', 'width^2*length');
model.param.descr('V_tot', 'Total REV volume');

model.mesh('mesh1').run;

model.material.create('mat1', 'Common', 'comp1');
model.material('mat1').label('Water');
model.material('mat1').propertyGroup('def').set('density', {'rho_f'});
model.material('mat1').propertyGroup('def').set('dynamicviscosity', {'mu_f'});

model.physics('spf').prop('ShapeProperty').set('order_fluid', 1);
model.physics('spf').create('inl1', 'InletBoundary', 2);
model.physics('spf').feature('inl1').selection.set([2]);
model.physics('spf').feature('inl1').set('U0in', 'u_in');

model.selection.create('sel1', 'Explicit');
model.selection('sel1').model('comp1');
model.selection('sel1').geom(2);
model.selection('sel1').label('Inlet');
model.selection('sel1').set([2]);

model.physics('spf').feature('inl1').selection.named('sel1');
model.physics('spf').create('out1', 'OutletBoundary', 2);
model.physics('spf').feature('out1').selection.set([16 21]);
model.physics('spf').feature('out1').set('NormalFlow', true);

model.selection.create('sel2', 'Explicit');
model.selection('sel2').model('comp1');
model.selection('sel2').geom(2);
model.selection('sel2').label('Outlet');
model.selection('sel2').set([16 21]);

model.physics('spf').feature('out1').selection.named('sel2');

model.selection.create('sel3', 'Explicit');
model.selection('sel3').model('comp1');
model.selection('sel3').label('Wall');
model.selection('sel3').geom(2);
model.selection('sel3').set([4 10 30]);
model.selection.create('sel4', 'Explicit');
model.selection('sel4').model('comp1');
model.selection('sel4').geom(2);
model.selection('sel4').all;
model.selection('sel4').label('All boundaries');
model.selection.create('dif1', 'Difference');
model.selection('dif1').model('comp1');
model.selection('dif1').label('Symmetry');
model.selection('dif1').set('entitydim', 2);
model.selection('dif1').set('add', {'sel4'});
model.selection('dif1').set('subtract', {'sel1' 'sel2' 'sel3'});

model.physics('spf').create('sym1', 'Symmetry', 2);
model.physics('spf').feature('sym1').selection.named('dif1');

model.study('std1').setGenPlots(false);

model.sol.create('sol1');

model.mesh('mesh1').stat.selection.geom(3);
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
model.sol('sol1').feature('s1').feature('fc1').set('minstep', 1.0E-4);
model.sol('sol1').feature('s1').feature('fc1').set('maxiter', 100);
model.sol('sol1').feature('s1').create('i1', 'Iterative');
model.sol('sol1').feature('s1').feature('i1').set('linsolver', 'gmres');
model.sol('sol1').feature('s1').feature('i1').set('prefuntype', 'left');
model.sol('sol1').feature('s1').feature('i1').set('itrestart', 50);
model.sol('sol1').feature('s1').feature('i1').set('rhob', 20);
model.sol('sol1').feature('s1').feature('i1').set('maxlinit', 1000);
model.sol('sol1').feature('s1').feature('i1').set('nlinnormuse', 'on');
model.sol('sol1').feature('s1').feature('i1').label('AMG, fluid flow variables (spf)');
model.sol('sol1').feature('s1').feature('i1').create('mg1', 'Multigrid');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').set('prefun', 'saamg');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').set('mgcycle', 'v');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').set('maxcoarsedof', 80000);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').set('strconn', 0.02);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').set('nullspace', 'constant');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').set('usesmooth', false);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').set('saamgcompwise', true);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').set('loweramg', true);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').set('compactaggregation', false);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('pr').create('sc1', 'SCGS');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('pr').feature('sc1').set('linesweeptype', 'ssor');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('pr').feature('sc1').set('iter', 0);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('pr').feature('sc1').set('scgsrelax', 0.7);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('pr').feature('sc1').set('scgsmethod', 'lines');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('pr').feature('sc1').set('scgsvertexrelax', 0.7);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('pr').feature('sc1').set('relax', 0.5);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('pr').feature('sc1').set('scgssolv', 'stored');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('pr').feature('sc1').set('approxscgs', true);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('pr').feature('sc1').set('scgsdirectmaxsize', 1000);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('po').create('sc1', 'SCGS');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('po').feature('sc1').set('linesweeptype', 'ssor');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('po').feature('sc1').set('iter', 1);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('po').feature('sc1').set('scgsrelax', 0.7);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('po').feature('sc1').set('scgsmethod', 'lines');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('po').feature('sc1').set('scgsvertexrelax', 0.7);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('po').feature('sc1').set('relax', 0.5);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('po').feature('sc1').set('scgssolv', 'stored');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('po').feature('sc1').set('approxscgs', true);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('po').feature('sc1').set('scgsdirectmaxsize', 1000);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('cs').create('d1', 'Direct');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('cs').feature('d1').set('linsolver', 'pardiso');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('cs').feature('d1').set('pivotperturb', 1.0E-13);
model.sol('sol1').feature('s1').create('d1', 'Direct');
model.sol('sol1').feature('s1').feature('d1').set('linsolver', 'pardiso');
model.sol('sol1').feature('s1').feature('d1').set('pivotperturb', 1.0E-13);
model.sol('sol1').feature('s1').feature('d1').label('Direct, fluid flow variables (spf)');
model.sol('sol1').feature('s1').feature('fc1').set('linsolver', 'i1');
model.sol('sol1').feature('s1').feature('fc1').set('dtech', 'auto');
model.sol('sol1').feature('s1').feature('fc1').set('initstep', 0.01);
model.sol('sol1').feature('s1').feature('fc1').set('minstep', 1.0E-4);
model.sol('sol1').feature('s1').feature('fc1').set('maxiter', 100);
model.sol('sol1').feature('s1').feature.remove('fcDef');
model.sol('sol1').attach('std1');
model.sol('sol1').runAll;

model.result.dataset.create('surf1', 'Surface');
model.result.dataset('surf1').selection.named('sel3');
model.result.create('pg2', 'PlotGroup3D');
model.result('pg2').run;
model.result('pg2').label('Velocity');
model.result('pg2').set('edges', false);
model.result('pg2').create('surf1', 'Surface');
model.result('pg2').feature('surf1').set('data', 'surf1');
model.result('pg2').feature('surf1').set('expr', '1');
model.result('pg2').feature('surf1').set('coloring', 'uniform');
model.result('pg2').feature('surf1').set('color', 'gray');
model.result('pg2').run;
model.result('pg2').create('line1', 'Line');
model.result('pg2').feature('line1').set('data', 'surf1');
model.result('pg2').feature('line1').set('coloring', 'uniform');
model.result('pg2').feature('line1').set('color', 'black');
model.result('pg2').run;
model.result('pg2').feature('line1').set('color', 'custom');
model.result('pg2').feature('line1').set('customcolor', [0.4117647111415863 0.4117647111415863 0.4117647111415863]);
model.result('pg2').run;
model.result('pg2').create('str1', 'Streamline');
model.result('pg2').feature('str1').selection.named('sel1');
model.result('pg2').feature('str1').set('selnumber', 40);
model.result('pg2').feature('str1').set('linetype', 'tube');
model.result('pg2').feature('str1').set('tuberadiusscaleactive', true);
model.result('pg2').feature('str1').set('tuberadiusscale', 0.0075);
model.result('pg2').feature('str1').create('col1', 'Color');
model.result('pg2').run;
model.result('pg2').feature('str1').feature('col1').set('colortable', 'AuroraBorealis');

model.cpl.create('intop1', 'Integration', 'geom1');
model.cpl('intop1').set('axisym', true);
model.cpl('intop1').selection.all;
model.cpl.create('aveop1', 'Average', 'geom1');
model.cpl('aveop1').set('axisym', true);
model.cpl('aveop1').label('Average Inlet');
model.cpl('aveop1').selection.geom('geom1', 2);
model.cpl('aveop1').selection.named('sel1');
model.cpl.create('aveop2', 'Average', 'geom1');
model.cpl('aveop2').set('axisym', true);
model.cpl('aveop2').label('Average Outlet');
model.cpl('aveop2').selection.geom('geom1', 2);
model.cpl('aveop2').selection.named('sel2');

model.variable.create('var1');
model.variable('var1').model('comp1');
model.variable('var1').set('por', 'intop1(1)/V_tot');
model.variable('var1').descr('por', 'Porosity');
model.variable('var1').set('dPdL', '-(aveop2(p)-aveop1(p))/length');
model.variable('var1').descr('dPdL', 'Pressure drop');
model.variable('var1').set('u_out', 'spf.out1.massFlowRate/rho_f/width^2');
model.variable('var1').descr('u_out', 'Superficial outlet velocity');
model.variable('var1').set('kappa', 'u_out*mu_f/dPdL');
model.variable('var1').descr('kappa', 'Permeability');

model.sol('sol1').updateSolution;

model.result('pg2').run;
model.result.numerical.create('gev1', 'EvalGlobal');
model.result.numerical('gev1').set('expr', {'por'});
model.result.numerical('gev1').set('descr', {'Porosity'});
model.result.numerical('gev1').set('expr', {'por' 'kappa'});
model.result.numerical('gev1').set('descr', {'Porosity' 'Permeability'});
model.result.table.create('tbl1', 'Table');
model.result.table('tbl1').comments('Global Evaluation 1');
model.result.numerical('gev1').set('table', 'tbl1');
model.result.numerical('gev1').setResult;
model.result('pg2').run;
model.result('pg2').feature('str1').set('pointtype', 'interactivearrow');
model.result('pg2').feature('str1').set('localtimeshifts', 2000);
model.result.export.create('anim1', 'Animation');
model.result.export('anim1').set('target', 'player');
model.result.export('anim1').set('plotgroup', 'pg2');
model.result.export('anim1').set('sweeptype', 'streamline');
model.result.export('anim1').set('maxframes', 50);
model.result.export('anim1').run;
model.result('pg2').run;

model.title('Analyzing Porous Structures on the Microscopic Scale');

model.description('Modeling flow through realistic porous structures is difficult due to the complexity of the structure itself. Resolving the flow field in detail is not feasible in real-life applications. Therefore, macroscopic approaches are used, which utilize averaged quantities of the porous structure, such as porosity and permeability. This example imports an STL file of a porous structure and analyzes the flow field at the pore scale in detail.');

model.sol('sol1').clearSolutionData;

model.label('pore_scale_flow_3d.mph');

model.modelNode.label('Components');

out = model;
