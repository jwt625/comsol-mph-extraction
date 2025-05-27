function out = model
%
% euler_bump_3d.m
%
% Model exported on May 26 2025, 21:26 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/CFD_Module/High_Mach_Number_Flow');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 3);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.physics.create('hmnf', 'HighMachNumberFlow', 'geom1');
model.physics('hmnf').model('comp1');

model.study.create('std1');
model.study('std1').create('stat', 'Stationary');
model.study('std1').feature('stat').setSolveFor('/physics/hmnf', true);

model.param.set('Min', '1.4');
model.param.descr('Min', 'Mach number, inlet');
model.param.set('pin', '1[atm]');
model.param.descr('pin', 'Static pressure, inlet');
model.param.set('Tin', '273.15[K]');
model.param.descr('Tin', 'Static temperature, inlet');
model.param.set('Rs', '287[J/kg/K]');
model.param.descr('Rs', 'Specific gas constant');
model.param.set('gamma', '1.4');
model.param.descr('gamma', 'Ratio of specific heats');
model.param.set('uin', 'Min*sqrt(gamma*Rs*Tin)');
model.param.descr('uin', 'Velocity, inlet');
model.param.set('alpha', '30[deg]');
model.param.descr('alpha', 'Angle of the obstacle');

model.geom('geom1').create('blk1', 'Block');
model.geom('geom1').feature('blk1').set('size', [5 0.5 2]);
model.geom('geom1').feature('blk1').set('pos', [-1 0 0]);
model.geom('geom1').run('blk1');
model.geom('geom1').create('wp1', 'WorkPlane');
model.geom('geom1').feature('wp1').set('unite', true);
model.geom('geom1').feature('wp1').set('quickplane', 'xz');
model.geom('geom1').feature('wp1').geom.create('c1', 'Circle');
model.geom('geom1').feature('wp1').geom.feature('c1').set('r', '(0.5^2/0.042+0.042)/2');
model.geom('geom1').feature('wp1').geom.feature('c1').set('pos', {'0.5' '0.042-(0.5^2/0.042+0.042)/2'});
model.geom('geom1').feature('wp1').geom.run('c1');
model.geom('geom1').run('wp1');
model.geom('geom1').feature.create('ext1', 'Extrude');
model.geom('geom1').feature('ext1').setIndex('distance', -0.5, 0);
model.geom('geom1').feature('ext1').setIndex('displ', '0.5*tan(alpha)', 0, 0);
model.geom('geom1').run('ext1');
model.geom('geom1').create('dif1', 'Difference');
model.geom('geom1').feature('dif1').selection('input').set({'blk1'});
model.geom('geom1').feature('dif1').selection('input2').set({'ext1'});
model.geom('geom1').runPre('fin');

model.view.create('view3', 'geom1');
model.view('view3').model('comp1');
model.view('view3').camera.set('zoomanglefull', 14.035942077636719);
model.view('view3').camera.setIndex('position', -12.909934997558594, 0);
model.view('view3').camera.setIndex('position', -19.874221801757812, 1);
model.view('view3').camera.setIndex('position', 14.913039207458496, 2);
model.view('view3').camera.setIndex('up', 0.2947807312011719, 0);
model.view('view3').camera.setIndex('up', 0.39155158400535583, 1);
model.view('view3').camera.setIndex('up', 0.8716602325439453, 2);
model.view('view3').camera.set('rotationpoint', [1.5 -0.5 1]);
model.view('view3').camera.setIndex('viewoffset', -0.03618030622601509, 0);
model.view('view3').camera.setIndex('viewoffset', -0.008528904989361763, 1);
model.view('view3').light('lgt1').set('intensity', 0.6);
model.view('view3').light('lgt2').set('intensity', 0.5);
model.view('view3').light('lgt3').set('intensity', 0.3);
model.view.create('view4', 'geom1');
model.view('view4').model('comp1');
model.view('view4').camera.set('zoomanglefull', 13.152371406555176);
model.view('view4').camera.setIndex('position', -0.10036933422088623, 0);
model.view('view4').camera.setIndex('position', -26.422821044921875, 1);
model.view('view4').camera.setIndex('position', 10.602215766906738, 2);
model.view('view4').camera.setIndex('up', 0.0030473002698272467, 0);
model.view('view4').camera.setIndex('up', 0.3385559618473053, 1);
model.view('view4').camera.setIndex('up', 0.9409412741661072, 2);
model.view('view4').camera.setIndex('viewoffset', -0.056343305855989456, 0);
model.view('view4').camera.setIndex('viewoffset', -0.024263063445687294, 1);
model.view('view3').set('transparency', false);

model.geom('geom1').run;

model.physics('hmnf').prop('AdvancedSettingProperty').set('UsePseudoTime', false);
model.physics('hmnf').feature('fluid1').set('k_mat', 'userdef');
model.physics('hmnf').feature('fluid1').set('k', {'1e-8' '0' '0' '0' '1e-8' '0' '0' '0' '1e-8'});
model.physics('hmnf').feature('fluid1').set('Rs_mat', 'userdef');
model.physics('hmnf').feature('fluid1').set('Rs', 'Rs');
model.physics('hmnf').feature('fluid1').set('CpOrGammaOption', 'gamma');
model.physics('hmnf').feature('fluid1').set('gamma_mat', 'userdef');
model.physics('hmnf').feature('fluid1').set('gamma', 'gamma');
model.physics('hmnf').feature('fluid1').set('mu_mat', 'userdef');
model.physics('hmnf').feature('fluid1').set('mu', '1e-8');
model.physics('hmnf').feature('wallbc1').set('BoundaryCondition', 'Slip');
model.physics('hmnf').feature('init1').set('u_init', {'uin' '0' '0'});
model.physics('hmnf').feature('init1').set('p_init', 'pin');
model.physics('hmnf').feature('init1').set('Tinit', 'Tin');
model.physics('hmnf').create('sym1', 'Symmetry', 2);
model.physics('hmnf').feature('sym1').selection.set([2 5]);

model.view('view3').set('renderwireframe', true);
model.view('view3').set('transparency', true);

model.physics('hmnf').create('hminl1', 'HighMachNumberFlowInlet', 2);
model.physics('hmnf').feature('hminl1').selection.set([1]);
model.physics('hmnf').feature('hminl1').set('FlowCondition', 'Supersonic');
model.physics('hmnf').feature('hminl1').set('p0stat', 'pin');
model.physics('hmnf').feature('hminl1').set('T0stat', 'Tin');
model.physics('hmnf').feature('hminl1').set('Ma0', 'Min');
model.physics('hmnf').create('hmout1', 'HighMachNumberFlowOutlet', 2);
model.physics('hmnf').feature('hmout1').selection.set([9]);

model.view('view3').set('renderwireframe', false);
model.view('view3').set('transparency', false);

model.physics('hmnf').feature('hmout1').set('FlowCondition', 'Supersonic');

model.mesh('mesh1').run;

model.study('std1').feature('stat').set('errestandadap', 'adaption');
model.study('std1').feature('stat').set('meshadaptmethod', 'modify');
model.study('std1').feature('stat').set('userngen', true);
model.study('std1').feature('stat').set('ngen', 2);

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
model.sol('sol1').feature('s1').create('d1', 'Direct');
model.sol('sol1').feature('s1').feature('d1').set('linsolver', 'pardiso');
model.sol('sol1').feature('s1').feature('d1').set('pivotperturb', 1.0E-13);
model.sol('sol1').feature('s1').feature('d1').label('Direct, fluid flow variables (hmnf)');
model.sol('sol1').feature('s1').create('i1', 'Iterative');
model.sol('sol1').feature('s1').feature('i1').set('linsolver', 'gmres');
model.sol('sol1').feature('s1').feature('i1').set('prefuntype', 'left');
model.sol('sol1').feature('s1').feature('i1').set('itrestart', 50);
model.sol('sol1').feature('s1').feature('i1').set('rhob', 20);
model.sol('sol1').feature('s1').feature('i1').set('maxlinit', 1000);
model.sol('sol1').feature('s1').feature('i1').set('nlinnormuse', 'on');
model.sol('sol1').feature('s1').feature('i1').label('AMG, fluid flow variables (hmnf)');
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
model.sol('sol1').feature('s1').feature('fc1').set('linsolver', 'd1');
model.sol('sol1').feature('s1').feature('fc1').set('dtech', 'auto');
model.sol('sol1').feature('s1').feature('fc1').set('initstep', 0.01);
model.sol('sol1').feature('s1').feature('fc1').set('minstep', 1.0E-4);
model.sol('sol1').feature('s1').feature('fc1').set('maxiter', 100);
model.sol('sol1').feature('s1').feature.remove('fcDef');
model.sol('sol1').attach('std1');
model.sol('sol1').feature('s1').feature('fc1').set('linsolver', 'i1');
model.sol('sol1').runAll;

model.result.dataset('dset2').set('geom', 'geom1');
model.result.create('pg1', 'PlotGroup3D');
model.result('pg1').label('Velocity (hmnf)');
model.result('pg1').set('data', 'dset2');
model.result('pg1').setIndex('looplevel', 3, 0);
model.result('pg1').set('frametype', 'spatial');
model.result('pg1').set('data', 'dset2');
model.result('pg1').setIndex('looplevel', 3, 0);
model.result('pg1').set('defaultPlotID', 'ResultDefaults_SinglePhaseFlow/icom1/pdef1/pcond2/pg1');
model.result('pg1').feature.create('slc1', 'Slice');
model.result('pg1').feature('slc1').label('Slice');
model.result('pg1').feature('slc1').set('showsolutionparams', 'on');
model.result('pg1').feature('slc1').set('smooth', 'internal');
model.result('pg1').feature('slc1').set('showsolutionparams', 'on');
model.result('pg1').feature('slc1').set('data', 'parent');
model.result.dataset.create('surf1', 'Surface');
model.result.dataset('surf1').label('Exterior Walls');
model.result.dataset('surf1').set('data', 'dset2');
model.result.dataset('surf1').selection.geom('geom1', 2);
model.result.dataset('surf1').selection.set([3 4 6 7 8]);
model.result.create('pg2', 'PlotGroup3D');
model.result('pg2').label('Pressure (hmnf)');
model.result('pg2').set('data', 'surf1');
model.result('pg2').setIndex('looplevel', 3, 0);
model.result('pg2').set('frametype', 'spatial');
model.result('pg2').set('data', 'surf1');
model.result('pg2').setIndex('looplevel', 3, 0);
model.result('pg2').set('defaultPlotID', 'ResultDefaults_SinglePhaseFlow/icom1/pdef1/pcond2/pcond2/pcond1/pg4');
model.result('pg2').feature.create('surf1', 'Surface');
model.result('pg2').feature('surf1').label('Surface');
model.result('pg2').feature('surf1').set('showsolutionparams', 'on');
model.result('pg2').feature('surf1').set('expr', 'p');
model.result('pg2').feature('surf1').set('colortable', 'Dipole');
model.result('pg2').feature('surf1').set('smooth', 'internal');
model.result('pg2').feature('surf1').set('showsolutionparams', 'on');
model.result('pg2').feature('surf1').set('data', 'parent');
model.result('pg2').feature('surf1').feature.create('tran1', 'Transparency');
model.result.create('pg3', 'PlotGroup3D');
model.result('pg3').label('Temperature (hmnf)');
model.result('pg3').set('data', 'dset2');
model.result('pg3').setIndex('looplevel', 3, 0);
model.result('pg3').set('data', 'dset2');
model.result('pg3').setIndex('looplevel', 3, 0);
model.result('pg3').set('defaultPlotID', 'ht/HT_PhysicsInterfaces/icom8/pdef1/pcond3/pcond3/pg1');
model.result('pg3').feature.create('vol1', 'Volume');
model.result('pg3').feature('vol1').set('showsolutionparams', 'on');
model.result('pg3').feature('vol1').set('solutionparams', 'parent');
model.result('pg3').feature('vol1').set('expr', 'T');
model.result('pg3').feature('vol1').set('colortable', 'HeatCameraLight');
model.result('pg3').feature('vol1').set('smooth', 'internal');
model.result('pg3').feature('vol1').set('showsolutionparams', 'on');
model.result('pg3').feature('vol1').set('data', 'parent');
model.result.create('pg4', 'PlotGroup3D');
model.result('pg4').label('Mach Number (hmnf)');
model.result('pg4').set('data', 'dset2');
model.result('pg4').setIndex('looplevel', 3, 0);
model.result('pg4').set('data', 'dset2');
model.result('pg4').setIndex('looplevel', 3, 0);
model.result('pg4').set('defaultPlotID', 'MultiphysicsHighMachNumberFlow/icom1/pdef1/pcond2/pg1');
model.result('pg4').feature.create('slc1', 'Slice');
model.result('pg4').feature('slc1').label('Slice');
model.result('pg4').feature('slc1').set('expr', 'hmnf.Ma');
model.result('pg4').feature('slc1').set('smooth', 'internal');
model.result('pg4').feature('slc1').set('data', 'parent');
model.result('pg1').run;
model.result('pg2').run;
model.result('pg2').set('data', 'dset2');
model.result('pg2').set('edges', false);
model.result('pg2').run;
model.result('pg2').feature('surf1').set('coloring', 'uniform');
model.result('pg2').feature('surf1').set('color', 'gray');
model.result('pg2').run;
model.result('pg2').feature('surf1').feature('tran1').active(false);
model.result('pg2').run;
model.result('pg2').feature('surf1').create('sel1', 'Selection');
model.result('pg2').feature('surf1').feature('sel1').selection.set([3 5 6 7 8]);
model.result('pg2').run;
model.result('pg2').create('con1', 'Contour');
model.result('pg2').feature('con1').set('expr', 'p');
model.result('pg2').feature('con1').set('number', 40);
model.result('pg2').run;
model.result('pg4').run;
model.result('pg4').run;
model.result('pg4').feature.remove('slc1');
model.result('pg4').run;
model.result('pg4').create('surf1', 'Surface');
model.result('pg4').feature('surf1').set('expr', 'hmnf.Ma');
model.result('pg4').run;
model.result('pg2').run;

model.title('3D Supersonic Flow in a Channel with a Bump');

model.description(['A 3D supersonic flow enters a channel at Mach' native2unicode(hex2dec({'00' 'a0'}), 'unicode') '1.4. The flow hits an obstacle at the bottom of the channel, and shock waves are created. The shock waves propagate through the fluid and diffract at the channel walls. The flow is assumed to be compressible and inviscid.' newline  newline 'The model makes use of the adaptive mesh refinement feature in COMSOL Multiphysics. This example is based on a 2D case that has been widely used in earlier studies of inviscid compressible flow.']);

model.mesh.clearMeshes;

model.sol('sol1').clearSolutionData;
model.sol('sol2').clearSolutionData;
model.sol('sol3').clearSolutionData;
model.sol('sol4').clearSolutionData;
model.sol('sol5').clearSolutionData;

model.label('euler_bump_3d.mph');

model.modelNode.label('Components');

out = model;
