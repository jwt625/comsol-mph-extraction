function out = model
%
% thermoelectric_leg.m
%
% Model exported on May 26 2025, 21:29 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/Heat_Transfer_Module/Verification_Examples');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 3);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.physics.create('ht', 'HeatTransfer', 'geom1');
model.physics('ht').model('comp1');
model.physics.create('ec', 'ConductiveMedia', 'geom1');
model.physics('ec').model('comp1');

model.multiphysics.create('tee1', 'ThermoelectricEffect', 'geom1', 3);
model.multiphysics('tee1').set('Heat_physics', 'ht');
model.multiphysics('tee1').set('EMCurrentDensity_physics', 'ec');
model.multiphysics('tee1').selection.all;
model.multiphysics.create('emh1', 'ElectromagneticHeating', 'geom1', 3);
model.multiphysics('emh1').set('EMHeat_physics', 'ec');
model.multiphysics('emh1').set('Heat_physics', 'ht');
model.multiphysics('emh1').selection.all;

model.study.create('std1');
model.study('std1').create('stat', 'Stationary');
model.study('std1').feature('stat').setSolveFor('/physics/ht', true);
model.study('std1').feature('stat').setSolveFor('/physics/ec', true);
model.study('std1').feature('stat').setSolveFor('/multiphysics/tee1', true);
model.study('std1').feature('stat').setSolveFor('/multiphysics/emh1', true);

model.geom('geom1').lengthUnit('mm');
model.geom('geom1').create('blk1', 'Block');
model.geom('geom1').feature('blk1').set('size', [1 1 6]);
model.geom('geom1').feature('blk1').setIndex('layername', 'Layer 1', 0);
model.geom('geom1').feature('blk1').setIndex('layer', 0.1, 0);
model.geom('geom1').feature('blk1').set('layertop', true);
model.geom('geom1').runPre('fin');

model.param.set('T0', '0[degC]');
model.param.descr('T0', 'Temperature reference');
model.param.set('J0', '0.7[A]/(1[mm])^2');
model.param.descr('J0', 'Inward current density');

model.geom('geom1').run;

model.material.create('mat1', 'Common', 'comp1');
model.material('mat1').label('Bismuth Telluride - Bi2Te3');
model.material('mat1').propertyGroup('def').set('thermalconductivity', {'1.6[W/(m*K)]'});
model.material('mat1').propertyGroup('def').set('density', {'7740[kg/m^3]'});
model.material('mat1').propertyGroup('def').set('heatcapacity', {'154.4[J/(kg*K)]'});
model.material('mat1').propertyGroup('def').set('electricconductivity', {'1.1e5[S/m]'});
model.material('mat1').propertyGroup('def').set('relpermittivity', {'1'});
model.material('mat1').propertyGroup('def').set('seebeckcoefficient', {'2e-4[V/K]'});
model.material.create('mat2', 'Common', 'comp1');
model.material('mat2').propertyGroup.create('Enu', 'Young''s modulus and Poisson''s ratio');
model.material('mat2').propertyGroup.create('linzRes', 'Linearized resistivity');
model.material('mat2').label('Copper');
model.material('mat2').set('family', 'copper');
model.material('mat2').propertyGroup('def').set('relpermeability', {'1' '0' '0' '0' '1' '0' '0' '0' '1'});
model.material('mat2').propertyGroup('def').set('electricconductivity', {'5.998e7[S/m]' '0' '0' '0' '5.998e7[S/m]' '0' '0' '0' '5.998e7[S/m]'});
model.material('mat2').propertyGroup('def').set('thermalexpansioncoefficient', {'17e-6[1/K]' '0' '0' '0' '17e-6[1/K]' '0' '0' '0' '17e-6[1/K]'});
model.material('mat2').propertyGroup('def').set('heatcapacity', '385[J/(kg*K)]');
model.material('mat2').propertyGroup('def').set('relpermittivity', {'1' '0' '0' '0' '1' '0' '0' '0' '1'});
model.material('mat2').propertyGroup('def').set('density', '8960[kg/m^3]');
model.material('mat2').propertyGroup('def').set('thermalconductivity', {'400[W/(m*K)]' '0' '0' '0' '400[W/(m*K)]' '0' '0' '0' '400[W/(m*K)]'});
model.material('mat2').propertyGroup('Enu').set('E', '110[GPa]');
model.material('mat2').propertyGroup('Enu').set('nu', '0.35');
model.material('mat2').propertyGroup('linzRes').set('rho0', '1.72e-8[ohm*m]');
model.material('mat2').propertyGroup('linzRes').set('alpha', '0.0039[1/K]');
model.material('mat2').propertyGroup('linzRes').set('Tref', '298[K]');
model.material('mat2').propertyGroup('linzRes').addInput('temperature');
model.material('mat2').selection.set([1 3]);
model.material('mat2').propertyGroup('def').set('seebeckcoefficient', {'6.5e-6[V/K]'});

model.physics('ht').create('temp1', 'TemperatureBoundary', 2);

model.view('view1').set('renderwireframe', true);

model.physics('ht').feature('temp1').selection.set([3]);
model.physics('ht').feature('temp1').set('T0', 'T0');
model.physics('ec').create('gnd1', 'Ground', 2);
model.physics('ec').feature('gnd1').selection.set([3]);
model.physics('ec').create('ncd1', 'NormalCurrentDensity', 2);
model.physics('ec').feature('ncd1').selection.set([10]);
model.physics('ec').feature('ncd1').set('nJ', 'J0');

model.mesh('mesh1').create('swe1', 'Sweep');
model.mesh('mesh1').feature('swe1').selection('sourceface').set([10]);
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
model.sol('sol1').feature('s1').feature('se1').feature('ss1').set('segvar', {'comp1_V'});
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
model.result('pg1').label('Temperature (ht)');
model.result('pg1').set('data', 'dset1');
model.result('pg1').set('defaultPlotID', 'ht/HT_PhysicsInterfaces/icom8/pdef1/pcond3/pcond3/pg1');
model.result('pg1').feature.create('vol1', 'Volume');
model.result('pg1').feature('vol1').set('showsolutionparams', 'on');
model.result('pg1').feature('vol1').set('solutionparams', 'parent');
model.result('pg1').feature('vol1').set('colortable', 'HeatCameraLight');
model.result('pg1').feature('vol1').set('smooth', 'internal');
model.result('pg1').feature('vol1').set('showsolutionparams', 'on');
model.result('pg1').feature('vol1').set('data', 'parent');
model.result.create('pg2', 'PlotGroup3D');
model.result('pg2').label('Electric Potential (ec)');
model.result('pg2').set('frametype', 'spatial');
model.result('pg2').set('showlegendsmaxmin', true);
model.result('pg2').set('data', 'dset1');
model.result('pg2').set('defaultPlotID', 'InterfaceComponents/PlotDefaults/icom2/pdef1/pcond2/pcond1/pcond2/pg1');
model.result('pg2').feature.create('vol1', 'Volume');
model.result('pg2').feature('vol1').set('showsolutionparams', 'on');
model.result('pg2').feature('vol1').set('solutionparams', 'parent');
model.result('pg2').feature('vol1').set('expr', 'V');
model.result('pg2').feature('vol1').set('colortable', 'Dipole');
model.result('pg2').feature('vol1').set('showsolutionparams', 'on');
model.result('pg2').feature('vol1').set('data', 'parent');
model.result.create('pg3', 'PlotGroup3D');
model.result('pg3').label('Electric Field Norm (ec)');
model.result('pg3').set('frametype', 'spatial');
model.result('pg3').set('showlegendsmaxmin', true);
model.result('pg3').set('data', 'dset1');
model.result('pg3').set('defaultPlotID', 'InterfaceComponents/PlotDefaults/icom3/pdef1/pcond2/pcond1/pg1');
model.result('pg3').feature.create('mslc1', 'Multislice');
model.result('pg3').feature('mslc1').set('showsolutionparams', 'on');
model.result('pg3').feature('mslc1').set('solutionparams', 'parent');
model.result('pg3').feature('mslc1').set('expr', 'ec.normE');
model.result('pg3').feature('mslc1').set('multiplanexmethod', 'coord');
model.result('pg3').feature('mslc1').set('xcoord', 'ec.CPx');
model.result('pg3').feature('mslc1').set('multiplaneymethod', 'coord');
model.result('pg3').feature('mslc1').set('ycoord', 'ec.CPy');
model.result('pg3').feature('mslc1').set('multiplanezmethod', 'coord');
model.result('pg3').feature('mslc1').set('zcoord', 'ec.CPz');
model.result('pg3').feature('mslc1').set('colortable', 'Prism');
model.result('pg3').feature('mslc1').set('colortabletrans', 'nonlinear');
model.result('pg3').feature('mslc1').set('colorcalibration', -0.8);
model.result('pg3').feature('mslc1').set('showsolutionparams', 'on');
model.result('pg3').feature('mslc1').set('data', 'parent');
model.result('pg3').feature.create('strmsl1', 'StreamlineMultislice');
model.result('pg3').feature('strmsl1').set('showsolutionparams', 'on');
model.result('pg3').feature('strmsl1').set('solutionparams', 'parent');
model.result('pg3').feature('strmsl1').set('expr', {'ec.Ex' 'ec.Ey' 'ec.Ez'});
model.result('pg3').feature('strmsl1').set('multiplanexmethod', 'coord');
model.result('pg3').feature('strmsl1').set('xcoord', 'ec.CPx');
model.result('pg3').feature('strmsl1').set('multiplaneymethod', 'coord');
model.result('pg3').feature('strmsl1').set('ycoord', 'ec.CPy');
model.result('pg3').feature('strmsl1').set('multiplanezmethod', 'coord');
model.result('pg3').feature('strmsl1').set('zcoord', 'ec.CPz');
model.result('pg3').feature('strmsl1').set('titletype', 'none');
model.result('pg3').feature('strmsl1').set('posmethod', 'uniform');
model.result('pg3').feature('strmsl1').set('udist', 0.02);
model.result('pg3').feature('strmsl1').set('maxlen', 0.4);
model.result('pg3').feature('strmsl1').set('maxtime', Inf);
model.result('pg3').feature('strmsl1').set('inheritcolor', false);
model.result('pg3').feature('strmsl1').set('showsolutionparams', 'on');
model.result('pg3').feature('strmsl1').set('maxtime', Inf);
model.result('pg3').feature('strmsl1').set('showsolutionparams', 'on');
model.result('pg3').feature('strmsl1').set('maxtime', Inf);
model.result('pg3').feature('strmsl1').set('showsolutionparams', 'on');
model.result('pg3').feature('strmsl1').set('maxtime', Inf);
model.result('pg3').feature('strmsl1').set('showsolutionparams', 'on');
model.result('pg3').feature('strmsl1').set('maxtime', Inf);
model.result('pg3').feature('strmsl1').set('data', 'parent');
model.result('pg3').feature('strmsl1').set('inheritplot', 'mslc1');
model.result('pg3').feature('strmsl1').feature.create('col1', 'Color');
model.result('pg3').feature('strmsl1').feature('col1').set('expr', 'ec.normE');
model.result('pg3').feature('strmsl1').feature('col1').set('colortable', 'PrismDark');
model.result('pg3').feature('strmsl1').feature('col1').set('colorlegend', false);
model.result('pg3').feature('strmsl1').feature('col1').set('colortabletrans', 'nonlinear');
model.result('pg3').feature('strmsl1').feature('col1').set('colorcalibration', -0.8);
model.result('pg3').feature('strmsl1').feature.create('filt1', 'Filter');
model.result('pg3').feature('strmsl1').feature('filt1').set('expr', '!isScalingSystemDomain');
model.result('pg1').run;
model.result('pg1').run;
model.result('pg1').feature('vol1').set('unit', 'degC');
model.result('pg1').run;
model.result('pg2').run;
model.result.create('pg4', 'PlotGroup3D');
model.result('pg4').label('Isothermal Contours (ht)');
model.result('pg4').set('data', 'dset1');
model.result('pg4').set('defaultPlotID', 'ht/HT_PhysicsInterfaces/icom8/pdef1/pcond3/pcond3/pg3');
model.result('pg4').feature.create('iso1', 'Isosurface');
model.result('pg4').feature('iso1').set('solutionparams', 'parent');
model.result('pg4').feature('iso1').set('number', 10);
model.result('pg4').feature('iso1').set('colortable', 'HeatCameraLight');
model.result('pg4').feature('iso1').set('smooth', 'internal');
model.result('pg4').feature('iso1').set('showsolutionparams', 'on');
model.result('pg4').feature('iso1').set('data', 'parent');
model.result('pg4').label('Isothermal Contours (ht)');
model.result('pg4').run;
model.result('pg4').run;
model.result('pg4').feature('iso1').set('unit', 'degC');
model.result('pg4').run;
model.result('pg4').create('arwv1', 'ArrowVolume');
model.result('pg4').feature('arwv1').set('xnumber', 2);
model.result('pg4').feature('arwv1').set('ynumber', 2);
model.result('pg4').feature('arwv1').set('arrowlength', 'logarithmic');
model.result('pg4').run;
model.result('pg2').run;

model.title('Thermoelectric Leg');

model.description('This example solves the heat transfer and electric field in a thermoelectric leg. The Peltier effect is used for cooling purposes in this device.');

model.label('thermoelectric_leg.mph');

model.modelNode.label('Components');

out = model;
