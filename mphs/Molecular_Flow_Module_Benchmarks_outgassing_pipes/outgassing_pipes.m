function out = model
%
% outgassing_pipes.m
%
% Model exported on May 26 2025, 21:30 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/Molecular_Flow_Module/Benchmarks');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 3);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.physics.create('fmf', 'FreeMolecularFlow', 'geom1', {'G'});

model.study.create('std1');
model.study('std1').create('stat', 'Stationary');
model.study('std1').feature('stat').setSolveFor('/physics/fmf', true);

model.param.set('T0', '293.15[K]');
model.param.descr('T0', 'Temperature');
model.param.set('Mn0', '0.028[kg/mol]');
model.param.descr('Mn0', 'Molar mass');
model.param.set('ps', '30[l/s]');
model.param.descr('ps', 'Pump speed');

model.geom('geom1').lengthUnit('cm');
model.geom('geom1').create('cyl1', 'Cylinder');
model.geom('geom1').feature('cyl1').set('r', 2);
model.geom('geom1').feature('cyl1').set('h', 400);
model.geom('geom1').feature('cyl1').set('axistype', 'x');
model.geom('geom1').run('cyl1');
model.geom('geom1').create('cyl2', 'Cylinder');
model.geom('geom1').feature('cyl2').set('r', 5);
model.geom('geom1').feature('cyl2').set('h', 100);
model.geom('geom1').feature('cyl2').set('pos', [400 0 0]);
model.geom('geom1').feature('cyl2').set('axistype', 'x');
model.geom('geom1').run('cyl2');
model.geom('geom1').create('cyl3', 'Cylinder');
model.geom('geom1').feature('cyl3').set('r', 2);
model.geom('geom1').feature('cyl3').set('h', 2);
model.geom('geom1').feature('cyl3').set('pos', [100 0 -2]);
model.geom('geom1').run('cyl3');
model.geom('geom1').create('cyl4', 'Cylinder');
model.geom('geom1').feature('cyl4').set('r', 2);
model.geom('geom1').feature('cyl4').set('h', 100);
model.geom('geom1').feature('cyl4').set('pos', [300 0 -100]);
model.geom('geom1').run('cyl4');
model.geom('geom1').create('cyl5', 'Cylinder');
model.geom('geom1').feature('cyl5').set('r', 2);
model.geom('geom1').feature('cyl5').set('h', 4);
model.geom('geom1').feature('cyl5').set('pos', [98 0 0]);
model.geom('geom1').feature('cyl5').set('axistype', 'x');
model.geom('geom1').run('cyl5');
model.geom('geom1').feature.duplicate('cyl6', 'cyl5');
model.geom('geom1').feature('cyl6').set('pos', [298 0 0]);
model.geom('geom1').run('cyl6');
model.geom('geom1').create('cyl7', 'Cylinder');
model.geom('geom1').feature('cyl7').set('r', 2);
model.geom('geom1').feature('cyl7').set('h', 2);
model.geom('geom1').feature('cyl7').set('pos', [300 0 -2]);
model.geom('geom1').run('cyl7');
model.geom('geom1').create('uni1', 'Union');
model.geom('geom1').feature('uni1').set('intbnd', false);
model.geom('geom1').feature('uni1').selection('input').set({'cyl1' 'cyl2' 'cyl3' 'cyl4' 'cyl5' 'cyl6' 'cyl7'});
model.geom('geom1').run('uni1');

model.func.create('int1', 'Interpolation');
model.func('int1').model('comp1');
model.func('int1').set('table', {'0' '7.01409E-10';  ...
'10.0446' '7.01409E-10';  ...
'22.3214' '6.90021E-10';  ...
'32.9241' '6.75125E-10';  ...
'45.7589' '6.49825E-10';  ...
'59.1518' '6.22069E-10';  ...
'70.8705' '5.79473E-10';  ...
'82.5893' '5.36856E-10';  ...
'92.6339' '5.00095E-10';  ...
'100.446' '4.58287E-10';  ...
'107.143' '5.33935E-10';  ...
'114.397' '6.28895E-10';  ...
'122.768' '7.09106E-10';  ...
'132.813' '8.2166E-10';  ...
'141.183' '9.164E-10';  ...
'152.344' '1.03893E-09';  ...
'160.156' '1.13371E-09';  ...
'172.991' '1.23713E-09';  ...
'185.268' '1.37227E-09';  ...
'198.661' '1.48931E-09';  ...
'212.054' '1.57283E-09';  ...
'225.446' '1.69769E-09';  ...
'242.188' '1.79289E-09';  ...
'257.813' '1.88314E-09';  ...
'276.228' '1.97792E-09';  ...
'293.527' '2.01056E-09';  ...
'303.013' '2.05493E-09';  ...
'330.357' '2.54222E-09';  ...
'357.143' '2.85086E-09';  ...
'383.371' '3.24974E-09';  ...
'399.554' '3.50771E-09';  ...
'421.317' '3.50771E-09';  ...
'445.313' '3.5462E-09';  ...
'481.027' '3.5462E-09';  ...
'497.768' '3.5656E-09'});
model.func.create('int2', 'Interpolation');
model.func('int2').model('comp1');
model.func('int2').set('table', {'1.61464' '6.71497E-10';  ...
'8.61141' '6.96253E-10';  ...
'28.5253' '7.0641E-10';  ...
'31.7546' '7.32453E-10';  ...
'40.9042' '6.76377E-10';  ...
'48.4392' '6.76377E-10';  ...
'49.5156' '6.9123E-10';  ...
'58.6652' '6.76377E-10';  ...
'67.8149' '6.76377E-10';  ...
'74.8116' '6.20087E-10';  ...
'83.423' '6.11172E-10';  ...
'84.4995' '5.89441E-10';  ...
'96.3401' '4.95414E-10';  ...
'103.337' '4.95414E-10';  ...
'111.948' '6.24594E-10';  ...
'120.022' '6.81292E-10';  ...
'132.939' '9.50577E-10';  ...
'139.935' '1E-09';  ...
'153.391' '1.17269E-09';  ...
'159.311' '1.17269E-09';  ...
'170.614' '1.31673E-09';  ...
'179.225' '1.2978E-09';  ...
'191.604' '1.55533E-09';  ...
'198.601' '1.57802E-09';  ...
'218.515' '1.90491E-09';  ...
'228.202' '1.90491E-09';  ...
'234.661' '1.98949E-09';  ...
'239.505' '2.01851E-09';  ...
'241.658' '2.13889E-09';  ...
'249.193' '2.12346E-09';  ...
'256.189' '2.21775E-09';  ...
'264.801' '2.21775E-09';  ...
'266.954' '2.13889E-09';  ...
'270.721' '2.20175E-09';  ...
'274.489' '2.21775E-09';  ...
'276.103' '2.17009E-09';  ...
'283.638' '2.28292E-09';  ...
'293.864' '2.29951E-09';  ...
'299.785' '2.40161E-09';  ...
'303.552' '2.40161E-09';  ...
'315.931' '2.73594E-09';  ...
'334.769' '3.16228E-09';  ...
'355.221' '3.52509E-09';  ...
'370.829' '3.76246E-09';  ...
'379.44' '4.104E-09';  ...
'388.59' '4.16387E-09';  ...
'405.813' '4.44425E-09';  ...
'496.233' '4.47655E-09'});

model.geom('geom1').run;

model.physics('fmf').feature('fmfp1').setIndex('Mn_G', 'Mn0', 0);
model.physics('fmf').feature('st1').set('T', 'T0');
model.physics('fmf').feature('wall1').set('BCType', 'OutgassingWall');
model.physics('fmf').feature('wall1').set('BoundaryCondition', 'ThermalDesorptionRate');
model.physics('fmf').create('pmp1', 'VacuumPump', 2);
model.physics('fmf').feature('pmp1').selection.set([10 12]);
model.physics('fmf').feature('pmp1').set('SpecifyPump', 'PumpSpeed');
model.physics('fmf').feature('pmp1').setIndex('pspeed', 'ps', 0);
model.physics('fmf').feature.duplicate('pmp2', 'pmp1');
model.physics('fmf').feature('pmp2').selection.set([26]);

model.mesh('mesh1').create('edg1', 'Edge');
model.mesh('mesh1').feature('edg1').selection.set([9 10 12 13 15 18 22 26 29 30 32 34 37 38 43 44 46 48 54 60 63 64 67 69 72 73 75 76 77 79 80 81]);
model.mesh('mesh1').feature('size').set('hauto', 2);
model.mesh('mesh1').create('map1', 'Map');
model.mesh('mesh1').feature('map1').selection.set([2 3 4 5 18 19 20 21 24 25 31 34 37 38 39 40 42 43 44 45]);
model.mesh('mesh1').feature('map1').create('dis1', 'Distribution');
model.mesh('mesh1').feature('map1').feature('dis1').selection.set([3 51 65 74]);
model.mesh('mesh1').feature('map1').feature('dis1').set('numelem', 80);
model.mesh('mesh1').feature('map1').create('dis2', 'Distribution');
model.mesh('mesh1').feature('map1').feature('dis2').selection.set([31]);
model.mesh('mesh1').feature('map1').feature('dis2').set('numelem', 160);
model.mesh('mesh1').run('map1');
model.mesh('mesh1').create('ftri1', 'FreeTri');
model.mesh('mesh1').feature('ftri1').selection.remaining;
model.mesh('mesh1').run;

model.sol.create('sol1');
model.sol('sol1').study('std1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'stat');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').set('control', 'stat');
model.sol('sol1').create('s1', 'Stationary');
model.sol('sol1').feature('s1').set('stol', 0.001);
model.sol('sol1').feature('s1').create('se1', 'Segregated');
model.sol('sol1').feature('s1').feature('se1').feature.remove('ssDef');
model.sol('sol1').feature('s1').feature('se1').create('ss1', 'SegregatedStep');
model.sol('sol1').feature('s1').feature('se1').feature('ss1').set('segvar', {'comp1_G'});
model.sol('sol1').feature('s1').create('i1', 'Iterative');
model.sol('sol1').feature('s1').feature('i1').set('linsolver', 'gmres');
model.sol('sol1').feature('s1').feature('i1').create('mg1', 'Multigrid');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').set('prefun', 'gmg');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').set('mcasegen', 'any');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('pr').create('sl1', 'SORLine');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('pr').feature('sl1').set('iter', 2);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('pr').feature('sl1').set('linerelax', 0.2);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('pr').feature('sl1').set('seconditer', 1);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('pr').feature('sl1').set('relax', 0.4);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('po').create('sl1', 'SORLine');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('po').feature('sl1').set('iter', 2);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('po').feature('sl1').set('linerelax', 0.2);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('po').feature('sl1').set('seconditer', 2);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('po').feature('sl1').set('relax', 0.4);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('cs').create('d1', 'Direct');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('cs').feature('d1').set('linsolver', 'pardiso');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('cs').feature('d1').set('pivotperturb', 1.0E-13);
model.sol('sol1').feature('s1').feature('se1').feature('ss1').set('linsolver', 'i1');
model.sol('sol1').feature('s1').feature('se1').create('ss2', 'SegregatedStep');
model.sol('sol1').feature('s1').feature('se1').feature('ss2').set('segvar', {'comp1_fmf_p_G'});
model.sol('sol1').feature('s1').feature('se1').feature('ss2').set('linsolver', 'i1');
model.sol('sol1').feature('s1').feature('se1').create('ss3', 'SegregatedStep');
model.sol('sol1').feature('s1').feature('se1').feature('ss3').set('segvar', {'comp1_fmf_N_G'});
model.sol('sol1').feature('s1').feature('se1').feature('ss3').set('linsolver', 'i1');
model.sol('sol1').feature('s1').feature.remove('fcDef');
model.sol('sol1').attach('std1');
model.sol('sol1').runAll;

model.result.create('pg1', 'PlotGroup3D');
model.result('pg1').label('Incident Molecular Flux (fmf)');
model.result('pg1').set('data', 'dset1');
model.result('pg1').set('defaultPlotID', 'FreeMolecularFlow/phys1/pdef1/pcond1/pg1');
model.result('pg1').feature.create('surf1', 'Surface');
model.result('pg1').feature('surf1').label('Surface');
model.result('pg1').feature('surf1').set('showsolutionparams', 'on');
model.result('pg1').feature('surf1').set('expr', 'fmf.Gtot');
model.result('pg1').feature('surf1').set('resolution', 'norefine');
model.result('pg1').feature('surf1').set('smooth', 'internal');
model.result('pg1').feature('surf1').set('showsolutionparams', 'on');
model.result('pg1').feature('surf1').set('data', 'parent');
model.result.create('pg2', 'PlotGroup3D');
model.result('pg2').label('Total Number Density (fmf)');
model.result('pg2').set('data', 'dset1');
model.result('pg2').set('defaultPlotID', 'FreeMolecularFlow/phys1/pdef1/pcond1/pcond1/pg1');
model.result('pg2').feature.create('surf1', 'Surface');
model.result('pg2').feature('surf1').label('Surface');
model.result('pg2').feature('surf1').set('showsolutionparams', 'on');
model.result('pg2').feature('surf1').set('expr', 'fmf.ntot');
model.result('pg2').feature('surf1').set('resolution', 'norefine');
model.result('pg2').feature('surf1').set('smooth', 'internal');
model.result('pg2').feature('surf1').set('showsolutionparams', 'on');
model.result('pg2').feature('surf1').set('data', 'parent');
model.result.create('pg3', 'PlotGroup3D');
model.result('pg3').label('Total Pressure (fmf)');
model.result('pg3').set('data', 'dset1');
model.result('pg3').set('defaultPlotID', 'FreeMolecularFlow/phys1/pdef1/pcond1/pcond2/pg1');
model.result('pg3').feature.create('surf1', 'Surface');
model.result('pg3').feature('surf1').label('Surface');
model.result('pg3').feature('surf1').set('showsolutionparams', 'on');
model.result('pg3').feature('surf1').set('expr', 'fmf.ptot');
model.result('pg3').feature('surf1').set('resolution', 'norefine');
model.result('pg3').feature('surf1').set('smooth', 'internal');
model.result('pg3').feature('surf1').set('showsolutionparams', 'on');
model.result('pg3').feature('surf1').set('data', 'parent');
model.result('pg1').run;
model.result('pg2').run;
model.result('pg3').run;
model.result.create('pg4', 'PlotGroup1D');
model.result('pg4').run;
model.result('pg4').set('titletype', 'none');
model.result('pg4').set('xlabelactive', true);
model.result('pg4').set('xlabel', 'Position (cm)');
model.result('pg4').set('ylabelactive', true);
model.result('pg4').set('ylabel', 'Pressure (torr)');
model.result('pg4').create('lngr1', 'LineGraph');
model.result('pg4').feature('lngr1').set('markerpos', 'datapoints');
model.result('pg4').feature('lngr1').set('linewidth', 'preference');
model.result('pg4').feature('lngr1').set('expr', 'fmf.ptot');
model.result('pg4').feature('lngr1').set('xdata', 'expr');
model.result('pg4').feature('lngr1').set('xdataexpr', 'x');
model.result('pg4').feature('lngr1').set('unit', 'Torr');
model.result('pg4').feature('lngr1').selection.set([7 19 33 35 49 70 82]);
model.result('pg4').feature('lngr1').set('legend', true);
model.result('pg4').feature('lngr1').set('legendmethod', 'manual');
model.result('pg4').feature('lngr1').setIndex('legends', 'COMSOL 3D Angular Coefficient', 0);
model.result('pg4').feature.duplicate('lngr2', 'lngr1');
model.result('pg4').run;
model.result('pg4').feature('lngr2').set('expr', 'int1(x/1[cm])');
model.result('pg4').feature('lngr2').setIndex('legends', 'Howell 1D Conductance Model', 0);
model.result('pg4').feature.duplicate('lngr3', 'lngr2');
model.result('pg4').run;
model.result('pg4').feature('lngr3').set('expr', 'int2(x/1[cm])');
model.result('pg4').feature('lngr3').setIndex('legends', 'Kersevan 3D Monte Carlo', 0);
model.result('pg4').run;
model.result('pg4').label('Pressure Profile');
model.result('pg4').set('legendpos', 'lowerright');
model.result('pg4').set('axislimits', true);
model.result('pg4').set('ymin', '1e-10');
model.result('pg4').set('ymax', '1e-8');
model.result('pg4').set('ylog', true);
model.result('pg4').run;

model.title('Outgassing Pipes');

model.description('This benchmark computes the pressure in a system of outgassing pipes with a high aspect ratio. The results are compared with a 1D simulation and a Monte-Carlo simulation of the same system from the literature.');

model.mesh.clearMeshes;

model.sol('sol1').clearSolutionData;

model.label('outgassing_pipes.mph');

model.modelNode.label('Components');

out = model;
