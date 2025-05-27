function out = model
%
% busbar_terminal.m
%
% Model exported on May 26 2025, 21:25 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/ACDC_Module/Introductory_Electric_Currents');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 3);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.physics.create('ec', 'ConductiveMedia', 'geom1');
model.physics('ec').model('comp1');
model.physics.create('ht', 'HeatTransfer', 'geom1');
model.physics('ht').model('comp1');

model.multiphysics.create('emh1', 'ElectromagneticHeating', 'geom1', 3);
model.multiphysics('emh1').set('EMHeat_physics', 'ec');
model.multiphysics('emh1').set('Heat_physics', 'ht');
model.multiphysics('emh1').selection.all;

model.study.create('std1');
model.study('std1').create('stat', 'Stationary');
model.study('std1').feature('stat').setSolveFor('/physics/ec', true);
model.study('std1').feature('stat').setSolveFor('/physics/ht', true);
model.study('std1').feature('stat').setSolveFor('/multiphysics/emh1', true);

model.geom('geom1').insertFile('busbar_terminal_geom_sequence.mph', 'geom1');
model.geom('geom1').run('fin');

model.param.set('mh', '3[mm]');
model.param.descr('mh', 'Maximum element size');
model.param.set('htc', '5[W/m^2/K]');
model.param.descr('htc', 'Heat transfer coefficient');
model.param.set('I', '160[A]');
model.param.descr('I', 'Terminal current');

model.material.create('mat1', 'Common', 'comp1');
model.material('mat1').propertyGroup.create('Enu', 'Young''s modulus and Poisson''s ratio');
model.material('mat1').propertyGroup.create('linzRes', 'Linearized resistivity');
model.material('mat1').label('Copper');
model.material('mat1').set('family', 'copper');
model.material('mat1').propertyGroup('def').set('relpermeability', {'1' '0' '0' '0' '1' '0' '0' '0' '1'});
model.material('mat1').propertyGroup('def').set('electricconductivity', {'5.998e7[S/m]' '0' '0' '0' '5.998e7[S/m]' '0' '0' '0' '5.998e7[S/m]'});
model.material('mat1').propertyGroup('def').set('thermalexpansioncoefficient', {'17e-6[1/K]' '0' '0' '0' '17e-6[1/K]' '0' '0' '0' '17e-6[1/K]'});
model.material('mat1').propertyGroup('def').set('heatcapacity', '385[J/(kg*K)]');
model.material('mat1').propertyGroup('def').set('relpermittivity', {'1' '0' '0' '0' '1' '0' '0' '0' '1'});
model.material('mat1').propertyGroup('def').set('density', '8960[kg/m^3]');
model.material('mat1').propertyGroup('def').set('thermalconductivity', {'400[W/(m*K)]' '0' '0' '0' '400[W/(m*K)]' '0' '0' '0' '400[W/(m*K)]'});
model.material('mat1').propertyGroup('Enu').set('E', '110[GPa]');
model.material('mat1').propertyGroup('Enu').set('nu', '0.35');
model.material('mat1').propertyGroup('linzRes').set('rho0', '1.72e-8[ohm*m]');
model.material('mat1').propertyGroup('linzRes').set('alpha', '0.0039[1/K]');
model.material('mat1').propertyGroup('linzRes').set('Tref', '298[K]');
model.material('mat1').propertyGroup('linzRes').addInput('temperature');
model.material.create('mat2', 'Common', 'comp1');
model.material('mat2').propertyGroup.create('Enu', 'Young''s modulus and Poisson''s ratio');
model.material('mat2').label('Titanium beta-21S');
model.material('mat2').set('family', 'titanium');
model.material('mat2').propertyGroup('def').set('relpermeability', {'1' '0' '0' '0' '1' '0' '0' '0' '1'});
model.material('mat2').propertyGroup('def').set('electricconductivity', {'7.407e5[S/m]' '0' '0' '0' '7.407e5[S/m]' '0' '0' '0' '7.407e5[S/m]'});
model.material('mat2').propertyGroup('def').set('thermalexpansioncoefficient', {'7.06e-6[1/K]' '0' '0' '0' '7.06e-6[1/K]' '0' '0' '0' '7.06e-6[1/K]'});
model.material('mat2').propertyGroup('def').set('heatcapacity', '710[J/(kg*K)]');
model.material('mat2').propertyGroup('def').set('relpermittivity', {'1' '0' '0' '0' '1' '0' '0' '0' '1'});
model.material('mat2').propertyGroup('def').set('density', '4940[kg/m^3]');
model.material('mat2').propertyGroup('def').set('thermalconductivity', {'7.5[W/(m*K)]' '0' '0' '0' '7.5[W/(m*K)]' '0' '0' '0' '7.5[W/(m*K)]'});
model.material('mat2').propertyGroup('Enu').set('E', '105[GPa]');
model.material('mat2').propertyGroup('Enu').set('nu', '0.33');
model.material('mat2').selection.set([2 3 4 5 6 7]);

model.selection.create('sel1', 'Explicit');
model.selection('sel1').model('comp1');
model.selection('sel1').geom(3);
model.selection('sel1').label('Ti bolts');
model.selection('sel1').set([2 3 4 5 6 7]);

model.material('mat2').selection.named('sel1');

model.physics('ht').create('hf1', 'HeatFluxBoundary', 2);
model.physics('ht').feature('hf1').selection.all;
model.physics('ht').feature('hf1').selection.set([1 2 3 4 5 6 7 9 10 11 12 13 14 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40 41 42]);
model.physics('ht').feature('hf1').set('HeatFluxType', 'ConvectiveHeatFlux');
model.physics('ht').feature('hf1').set('h', 'htc');
model.physics('ec').create('term1', 'Terminal', 2);
model.physics('ec').feature('term1').selection.set([43]);
model.physics('ec').feature('term1').set('I0', 'I');
model.physics('ec').create('term2', 'Terminal', 2);
model.physics('ec').feature('term2').selection.set([8 15]);
model.physics('ec').feature('term2').set('TerminalType', 'Voltage');
model.physics('ec').feature('term2').set('V0', 0);

model.mesh('mesh1').create('ftet1', 'FreeTet');
model.mesh('mesh1').feature('size').set('custom', true);
model.mesh('mesh1').feature('size').set('hmax', 'mh');
model.mesh('mesh1').feature('size').set('hmin', 'mh-mh/3');
model.mesh('mesh1').feature('size').set('hcurve', 0.2);
model.mesh('mesh1').run;

model.sol.create('sol1');
model.sol('sol1').study('std1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'stat');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').set('control', 'stat');
model.sol('sol1').create('s1', 'Stationary');
model.sol('sol1').feature('s1').create('se1', 'Segregated');
model.sol('sol1').feature('s1').feature('se1').feature.remove('ssDef');
model.sol('sol1').feature('s1').feature('se1').create('ss1', 'SegregatedStep');
model.sol('sol1').feature('s1').feature('se1').feature('ss1').set('segvar', {'comp1_V' 'comp1_ec_term1_V0_ode'});
model.sol('sol1').feature('s1').create('i1', 'Iterative');
model.sol('sol1').feature('s1').feature('i1').set('linsolver', 'cg');
model.sol('sol1').feature('s1').feature('i1').create('mg1', 'Multigrid');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').set('prefun', 'amg');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').set('coarseningmethod', 'classic');
model.sol('sol1').feature('s1').feature('se1').feature('ss1').set('linsolver', 'i1');
model.sol('sol1').feature('s1').feature('se1').feature('ss1').label('Electric Currents');
model.sol('sol1').feature('s1').feature('se1').create('ss2', 'SegregatedStep');
model.sol('sol1').feature('s1').feature('se1').feature('ss2').set('segvar', {'comp1_T'});
model.sol('sol1').feature('s1').feature('se1').feature('ss2').set('subdamp', 0.8);
model.sol('sol1').feature('s1').create('d1', 'Direct');
model.sol('sol1').feature('s1').feature('d1').set('linsolver', 'pardiso');
model.sol('sol1').feature('s1').feature('d1').set('pivotperturb', 1.0E-13);
model.sol('sol1').feature('s1').feature('d1').label('Direct, heat transfer variables (ht)');
model.sol('sol1').feature('s1').feature('se1').feature('ss2').set('linsolver', 'd1');
model.sol('sol1').feature('s1').feature('se1').feature('ss2').label('Temperature');
model.sol('sol1').feature('s1').feature('se1').create('ll1', 'LowerLimit');
model.sol('sol1').feature('s1').feature('se1').feature('ll1').set('lowerlimit', 'comp1.T 0 ');
model.sol('sol1').feature('s1').create('i2', 'Iterative');
model.sol('sol1').feature('s1').feature('i2').set('linsolver', 'gmres');
model.sol('sol1').feature('s1').feature('i2').set('prefuntype', 'left');
model.sol('sol1').feature('s1').feature('i2').set('itrestart', 50);
model.sol('sol1').feature('s1').feature('i2').set('rhob', 20);
model.sol('sol1').feature('s1').feature('i2').set('maxlinit', 10000);
model.sol('sol1').feature('s1').feature('i2').set('nlinnormuse', 'on');
model.sol('sol1').feature('s1').feature('i2').label('AMG, heat transfer variables (ht)');
model.sol('sol1').feature('s1').feature('i2').create('mg1', 'Multigrid');
model.sol('sol1').feature('s1').feature('i2').feature('mg1').set('prefun', 'saamg');
model.sol('sol1').feature('s1').feature('i2').feature('mg1').set('mgcycle', 'v');
model.sol('sol1').feature('s1').feature('i2').feature('mg1').set('maxcoarsedof', 50000);
model.sol('sol1').feature('s1').feature('i2').feature('mg1').set('strconn', 0.01);
model.sol('sol1').feature('s1').feature('i2').feature('mg1').set('nullspace', 'constant');
model.sol('sol1').feature('s1').feature('i2').feature('mg1').set('usesmooth', false);
model.sol('sol1').feature('s1').feature('i2').feature('mg1').set('saamgcompwise', true);
model.sol('sol1').feature('s1').feature('i2').feature('mg1').set('loweramg', true);
model.sol('sol1').feature('s1').feature('i2').feature('mg1').set('compactaggregation', false);
model.sol('sol1').feature('s1').feature('i2').feature('mg1').feature('pr').create('so1', 'SOR');
model.sol('sol1').feature('s1').feature('i2').feature('mg1').feature('pr').feature('so1').set('iter', 2);
model.sol('sol1').feature('s1').feature('i2').feature('mg1').feature('pr').feature('so1').set('relax', 0.9);
model.sol('sol1').feature('s1').feature('i2').feature('mg1').feature('po').create('so1', 'SOR');
model.sol('sol1').feature('s1').feature('i2').feature('mg1').feature('po').feature('so1').set('iter', 2);
model.sol('sol1').feature('s1').feature('i2').feature('mg1').feature('po').feature('so1').set('relax', 0.9);
model.sol('sol1').feature('s1').feature('i2').feature('mg1').feature('cs').create('d1', 'Direct');
model.sol('sol1').feature('s1').feature('i2').feature('mg1').feature('cs').feature('d1').set('linsolver', 'pardiso');
model.sol('sol1').feature('s1').feature('i2').feature('mg1').feature('cs').feature('d1').set('pivotperturb', 1.0E-13);
model.sol('sol1').feature('s1').feature.remove('fcDef');
model.sol('sol1').attach('std1');
model.sol('sol1').runAll;

model.result.create('pg1', 'PlotGroup3D');
model.result('pg1').label('Electric Potential (ec)');
model.result('pg1').set('frametype', 'spatial');
model.result('pg1').set('showlegendsmaxmin', true);
model.result('pg1').set('data', 'dset1');
model.result('pg1').set('defaultPlotID', 'InterfaceComponents/PlotDefaults/icom2/pdef1/pcond2/pcond1/pcond2/pg1');
model.result('pg1').feature.create('vol1', 'Volume');
model.result('pg1').feature('vol1').set('showsolutionparams', 'on');
model.result('pg1').feature('vol1').set('solutionparams', 'parent');
model.result('pg1').feature('vol1').set('colortable', 'Dipole');
model.result('pg1').feature('vol1').set('showsolutionparams', 'on');
model.result('pg1').feature('vol1').set('data', 'parent');
model.result.create('pg2', 'PlotGroup3D');
model.result('pg2').label('Electric Field Norm (ec)');
model.result('pg2').set('frametype', 'spatial');
model.result('pg2').set('showlegendsmaxmin', true);
model.result('pg2').set('data', 'dset1');
model.result('pg2').set('defaultPlotID', 'InterfaceComponents/PlotDefaults/icom3/pdef1/pcond2/pcond1/pg1');
model.result('pg2').feature.create('mslc1', 'Multislice');
model.result('pg2').feature('mslc1').set('showsolutionparams', 'on');
model.result('pg2').feature('mslc1').set('solutionparams', 'parent');
model.result('pg2').feature('mslc1').set('expr', 'ec.normE');
model.result('pg2').feature('mslc1').set('multiplanexmethod', 'coord');
model.result('pg2').feature('mslc1').set('xcoord', 'ec.CPx');
model.result('pg2').feature('mslc1').set('multiplaneymethod', 'coord');
model.result('pg2').feature('mslc1').set('ycoord', 'ec.CPy');
model.result('pg2').feature('mslc1').set('multiplanezmethod', 'coord');
model.result('pg2').feature('mslc1').set('zcoord', 'ec.CPz');
model.result('pg2').feature('mslc1').set('colortable', 'Prism');
model.result('pg2').feature('mslc1').set('colortabletrans', 'nonlinear');
model.result('pg2').feature('mslc1').set('colorcalibration', -0.8);
model.result('pg2').feature('mslc1').set('showsolutionparams', 'on');
model.result('pg2').feature('mslc1').set('data', 'parent');
model.result('pg2').feature.create('strmsl1', 'StreamlineMultislice');
model.result('pg2').feature('strmsl1').set('showsolutionparams', 'on');
model.result('pg2').feature('strmsl1').set('solutionparams', 'parent');
model.result('pg2').feature('strmsl1').set('expr', {'ec.Ex' 'ec.Ey' 'ec.Ez'});
model.result('pg2').feature('strmsl1').set('multiplanexmethod', 'coord');
model.result('pg2').feature('strmsl1').set('xcoord', 'ec.CPx');
model.result('pg2').feature('strmsl1').set('multiplaneymethod', 'coord');
model.result('pg2').feature('strmsl1').set('ycoord', 'ec.CPy');
model.result('pg2').feature('strmsl1').set('multiplanezmethod', 'coord');
model.result('pg2').feature('strmsl1').set('zcoord', 'ec.CPz');
model.result('pg2').feature('strmsl1').set('titletype', 'none');
model.result('pg2').feature('strmsl1').set('posmethod', 'uniform');
model.result('pg2').feature('strmsl1').set('udist', 0.02);
model.result('pg2').feature('strmsl1').set('maxlen', 0.4);
model.result('pg2').feature('strmsl1').set('maxtime', Inf);
model.result('pg2').feature('strmsl1').set('inheritcolor', false);
model.result('pg2').feature('strmsl1').set('showsolutionparams', 'on');
model.result('pg2').feature('strmsl1').set('maxtime', Inf);
model.result('pg2').feature('strmsl1').set('showsolutionparams', 'on');
model.result('pg2').feature('strmsl1').set('maxtime', Inf);
model.result('pg2').feature('strmsl1').set('showsolutionparams', 'on');
model.result('pg2').feature('strmsl1').set('maxtime', Inf);
model.result('pg2').feature('strmsl1').set('showsolutionparams', 'on');
model.result('pg2').feature('strmsl1').set('maxtime', Inf);
model.result('pg2').feature('strmsl1').set('data', 'parent');
model.result('pg2').feature('strmsl1').set('inheritplot', 'mslc1');
model.result('pg2').feature('strmsl1').feature.create('col1', 'Color');
model.result('pg2').feature('strmsl1').feature('col1').set('expr', 'ec.normE');
model.result('pg2').feature('strmsl1').feature('col1').set('colortable', 'PrismDark');
model.result('pg2').feature('strmsl1').feature('col1').set('colorlegend', false);
model.result('pg2').feature('strmsl1').feature('col1').set('colortabletrans', 'nonlinear');
model.result('pg2').feature('strmsl1').feature('col1').set('colorcalibration', -0.8);
model.result('pg2').feature('strmsl1').feature.create('filt1', 'Filter');
model.result('pg2').feature('strmsl1').feature('filt1').set('expr', '!isScalingSystemDomain');
model.result.create('pg3', 'PlotGroup3D');
model.result('pg3').label('Temperature (ht)');
model.result('pg3').set('data', 'dset1');
model.result('pg3').set('defaultPlotID', 'ht/HT_PhysicsInterfaces/icom8/pdef1/pcond3/pcond3/pg1');
model.result('pg3').feature.create('vol1', 'Volume');
model.result('pg3').feature('vol1').set('showsolutionparams', 'on');
model.result('pg3').feature('vol1').set('solutionparams', 'parent');
model.result('pg3').feature('vol1').set('expr', 'T');
model.result('pg3').feature('vol1').set('colortable', 'HeatCameraLight');
model.result('pg3').feature('vol1').set('smooth', 'internal');
model.result('pg3').feature('vol1').set('showsolutionparams', 'on');
model.result('pg3').feature('vol1').set('data', 'parent');
model.result('pg1').run;
model.result('pg3').run;
model.result('pg3').run;
model.result('pg3').feature('vol1').set('rangecoloractive', true);
model.result('pg3').feature('vol1').set('rangecolormax', 324);
model.result('pg3').run;
model.result.create('pg4', 'PlotGroup3D');
model.result('pg4').run;
model.result('pg4').label('Current Density');
model.result('pg4').create('surf1', 'Surface');
model.result('pg4').feature('surf1').set('expr', 'ec.normJ');
model.result('pg4').feature('surf1').set('descr', 'Current density norm');
model.result('pg4').feature('surf1').set('rangecoloractive', true);
model.result('pg4').feature('surf1').set('rangecolormax', '1e6');
model.result('pg4').run;
model.result('pg3').run;
model.result('pg3').create('mmv1', 'MaxMinVolume');
model.result('pg3').feature('mmv1').set('expr', 'T');
model.result('pg3').feature('mmv1').set('descr', 'Temperature');
model.result('pg3').run;
model.result.numerical.create('max1', 'MaxVolume');
model.result.numerical('max1').selection.all;
model.result.table.create('tbl1', 'Table');
model.result.table('tbl1').comments('Volume Maximum 1');
model.result.numerical('max1').set('table', 'tbl1');
model.result.numerical('max1').setResult;
model.result('pg3').run;

model.title('Electrical Heating in a Busbar with Terminals');

model.description('This example demonstrates the usage of current terminal to compute the resistive heating of a busbar.');

model.label('busbar_terminal.mph');

model.modelNode.label('Components');

out = model;
