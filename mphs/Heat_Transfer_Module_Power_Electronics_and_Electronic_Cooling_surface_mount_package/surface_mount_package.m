function out = model
%
% surface_mount_package.m
%
% Model exported on May 26 2025, 21:29 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/Heat_Transfer_Module/Power_Electronics_and_Electronic_Cooling');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 3);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.physics.create('ht', 'HeatTransfer', 'geom1');
model.physics('ht').model('comp1');

model.study.create('std1');
model.study('std1').create('stat', 'Stationary');
model.study('std1').feature('stat').setSolveFor('/physics/ht', true);

model.geom('geom1').insertFile('surface_mount_package_geom_sequence.mph', 'geom1');
model.geom('geom1').run('sel2');

model.view('view1').set('transparency', false);

model.material.create('mat1', 'Common', 'comp1');
model.material('mat1').propertyGroup.create('Enu', 'Young''s modulus and Poisson''s ratio');
model.material('mat1').propertyGroup.create('Murnaghan', 'Murnaghan');
model.material('mat1').label('Aluminum');
model.material('mat1').set('family', 'aluminum');
model.material('mat1').propertyGroup('def').set('relpermeability', {'1' '0' '0' '0' '1' '0' '0' '0' '1'});
model.material('mat1').propertyGroup('def').set('heatcapacity', '900[J/(kg*K)]');
model.material('mat1').propertyGroup('def').set('thermalconductivity', {'238[W/(m*K)]' '0' '0' '0' '238[W/(m*K)]' '0' '0' '0' '238[W/(m*K)]'});
model.material('mat1').propertyGroup('def').set('electricconductivity', {'3.774e7[S/m]' '0' '0' '0' '3.774e7[S/m]' '0' '0' '0' '3.774e7[S/m]'});
model.material('mat1').propertyGroup('def').set('relpermittivity', {'1' '0' '0' '0' '1' '0' '0' '0' '1'});
model.material('mat1').propertyGroup('def').set('thermalexpansioncoefficient', {'23e-6[1/K]' '0' '0' '0' '23e-6[1/K]' '0' '0' '0' '23e-6[1/K]'});
model.material('mat1').propertyGroup('def').set('density', '2700[kg/m^3]');
model.material('mat1').propertyGroup('Enu').set('E', '70[GPa]');
model.material('mat1').propertyGroup('Enu').set('nu', '0.33');
model.material('mat1').propertyGroup('Murnaghan').set('l', '-250[GPa]');
model.material('mat1').propertyGroup('Murnaghan').set('m', '-330[GPa]');
model.material('mat1').propertyGroup('Murnaghan').set('n', '-350[GPa]');
model.material.create('mat2', 'Common', 'comp1');
model.material('mat2').propertyGroup.create('Enu', 'Young''s modulus and Poisson''s ratio');
model.material('mat2').label('FR4 (Circuit Board)');
model.material('mat2').set('family', 'pcbgreen');
model.material('mat2').propertyGroup('def').set('relpermeability', {'1' '0' '0' '0' '1' '0' '0' '0' '1'});
model.material('mat2').propertyGroup('def').set('electricconductivity', {'0.004[S/m]' '0' '0' '0' '0.004[S/m]' '0' '0' '0' '0.004[S/m]'});
model.material('mat2').propertyGroup('def').set('relpermittivity', {'4.5' '0' '0' '0' '4.5' '0' '0' '0' '4.5'});
model.material('mat2').propertyGroup('def').set('thermalexpansioncoefficient', {'18e-6[1/K]' '0' '0' '0' '18e-6[1/K]' '0' '0' '0' '18e-6[1/K]'});
model.material('mat2').propertyGroup('def').set('heatcapacity', '1369[J/(kg*K)]');
model.material('mat2').propertyGroup('def').set('density', '1900[kg/m^3]');
model.material('mat2').propertyGroup('def').set('thermalconductivity', {'0.3[W/(m*K)]' '0' '0' '0' '0.3[W/(m*K)]' '0' '0' '0' '0.3[W/(m*K)]'});
model.material('mat2').propertyGroup('Enu').set('E', '22[GPa]');
model.material('mat2').propertyGroup('Enu').set('nu', '0.15');
model.material('mat1').selection.named('geom1_csel1_dom');
model.material('mat2').selection.named('geom1_blk1_dom');
model.material.create('mat3', 'Common', 'comp1');
model.material('mat3').label('Plastic');
model.material('mat3').selection.named('geom1_uni1_dom');
model.material('mat3').propertyGroup('def').set('density', '');
model.material('mat3').propertyGroup('def').set('heatcapacity', '');
model.material('mat3').propertyGroup('def').set('thermalconductivity', '');
model.material('mat3').propertyGroup('def').set('density', {'2700'});
model.material('mat3').propertyGroup('def').set('heatcapacity', {'900'});
model.material('mat3').propertyGroup('def').set('thermalconductivity', {'0.2'});
model.material.create('mat4', 'Common', 'comp1');
model.material('mat4').propertyGroup.create('Enu', 'Young''s modulus and Poisson''s ratio');
model.material('mat4').propertyGroup.create('RefractiveIndex', 'Refractive index');
model.material('mat4').label('Silicon');
model.material('mat4').set('family', 'custom');
model.material('mat4').set('customspecular', [0.7843137254901961 1 1]);
model.material('mat4').set('customdiffuse', [0.6666666666666666 0.6666666666666666 0.7058823529411765]);
model.material('mat4').set('customambient', [0.6666666666666666 0.6666666666666666 0.7058823529411765]);
model.material('mat4').set('noise', true);
model.material('mat4').set('fresnel', 0.7);
model.material('mat4').set('metallic', 0);
model.material('mat4').set('pearl', 0);
model.material('mat4').set('diffusewrap', 0);
model.material('mat4').set('clearcoat', 0);
model.material('mat4').set('reflectance', 0);
model.material('mat4').propertyGroup('def').set('relpermeability', {'1' '0' '0' '0' '1' '0' '0' '0' '1'});
model.material('mat4').propertyGroup('def').set('electricconductivity', {'1e-12[S/m]' '0' '0' '0' '1e-12[S/m]' '0' '0' '0' '1e-12[S/m]'});
model.material('mat4').propertyGroup('def').set('thermalexpansioncoefficient', {'2.6e-6[1/K]' '0' '0' '0' '2.6e-6[1/K]' '0' '0' '0' '2.6e-6[1/K]'});
model.material('mat4').propertyGroup('def').set('heatcapacity', '700[J/(kg*K)]');
model.material('mat4').propertyGroup('def').set('relpermittivity', {'11.7' '0' '0' '0' '11.7' '0' '0' '0' '11.7'});
model.material('mat4').propertyGroup('def').set('density', '2329[kg/m^3]');
model.material('mat4').propertyGroup('def').set('thermalconductivity', {'130[W/(m*K)]' '0' '0' '0' '130[W/(m*K)]' '0' '0' '0' '130[W/(m*K)]'});
model.material('mat4').propertyGroup('Enu').set('E', '170[GPa]');
model.material('mat4').propertyGroup('Enu').set('nu', '0.28');
model.material('mat4').propertyGroup('RefractiveIndex').set('n', {'3.48' '0' '0' '0' '3.48' '0' '0' '0' '3.48'});
model.material.create('mat5', 'Common', 'comp1');
model.material('mat5').propertyGroup.create('Enu', 'Young''s modulus and Poisson''s ratio');
model.material('mat5').propertyGroup.create('linzRes', 'Linearized resistivity');
model.material('mat5').label('Copper');
model.material('mat5').set('family', 'copper');
model.material('mat5').propertyGroup('def').set('relpermeability', {'1' '0' '0' '0' '1' '0' '0' '0' '1'});
model.material('mat5').propertyGroup('def').set('electricconductivity', {'5.998e7[S/m]' '0' '0' '0' '5.998e7[S/m]' '0' '0' '0' '5.998e7[S/m]'});
model.material('mat5').propertyGroup('def').set('thermalexpansioncoefficient', {'17e-6[1/K]' '0' '0' '0' '17e-6[1/K]' '0' '0' '0' '17e-6[1/K]'});
model.material('mat5').propertyGroup('def').set('heatcapacity', '385[J/(kg*K)]');
model.material('mat5').propertyGroup('def').set('relpermittivity', {'1' '0' '0' '0' '1' '0' '0' '0' '1'});
model.material('mat5').propertyGroup('def').set('density', '8960[kg/m^3]');
model.material('mat5').propertyGroup('def').set('thermalconductivity', {'400[W/(m*K)]' '0' '0' '0' '400[W/(m*K)]' '0' '0' '0' '400[W/(m*K)]'});
model.material('mat5').propertyGroup('Enu').set('E', '110[GPa]');
model.material('mat5').propertyGroup('Enu').set('nu', '0.35');
model.material('mat5').propertyGroup('linzRes').set('rho0', '1.72e-8[ohm*m]');
model.material('mat5').propertyGroup('linzRes').set('alpha', '0.0039[1/K]');
model.material('mat5').propertyGroup('linzRes').set('Tref', '298[K]');
model.material('mat5').propertyGroup('linzRes').addInput('temperature');
model.material('mat4').selection.named('geom1_blk4_dom');
model.material('mat5').selection.geom('geom1', 2);
model.material('mat5').selection.named('geom1_sel2');

model.physics('ht').create('hs1', 'HeatSource', 3);
model.physics('ht').feature('hs1').selection.set([11]);
model.physics('ht').feature('hs1').set('Q0', '2e8');
model.physics('ht').create('hf1', 'HeatFluxBoundary', 2);
model.physics('ht').feature('hf1').selection.named('geom1_adjsel1');
model.physics('ht').feature('hf1').set('HeatFluxType', 'ConvectiveHeatFlux');
model.physics('ht').feature('hf1').set('h', 50);
model.physics('ht').feature('hf1').set('Text', '30[degC]');
model.physics('ht').create('temp1', 'TemperatureBoundary', 2);
model.physics('ht').feature('temp1').selection.set([4]);
model.physics('ht').feature('temp1').set('T0', '50[degC]');
model.physics('ht').create('sls1', 'SolidLayeredShell', 2);
model.physics('ht').feature('sls1').selection.set([7]);
model.physics('ht').feature('sls1').set('lth_mat', 'userdef');
model.physics('ht').feature('sls1').set('UserDefThicknessLayerType', 'Conductive');
model.physics('ht').create('sls2', 'SolidLayeredShell', 2);
model.physics('ht').feature('sls2').selection.named('geom1_wp2_bnd');
model.physics('ht').feature('sls2').set('lth_mat', 'userdef');
model.physics('ht').feature('sls2').set('lth', '5e-6[m]');
model.physics('ht').feature('sls2').set('UserDefThicknessLayerType', 'Conductive');

model.mesh('mesh1').create('size1', 'Size');
model.mesh('mesh1').feature('size1').selection.geom('geom1', 2);
model.mesh('mesh1').feature('size1').selection.set([4 7]);
model.mesh('mesh1').feature('size1').set('hauto', 2);
model.mesh('mesh1').create('ftet1', 'FreeTet');
model.mesh('mesh1').feature('size').set('hauto', 4);
model.mesh('mesh1').run;

model.sol.create('sol1');
model.sol('sol1').study('std1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'stat');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').set('control', 'stat');
model.sol('sol1').create('s1', 'Stationary');
model.sol('sol1').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('s1').feature('fc1').set('dtech', 'auto');
model.sol('sol1').feature('s1').feature('fc1').set('initstep', 0.01);
model.sol('sol1').feature('s1').feature('fc1').set('minstep', 1.0E-6);
model.sol('sol1').feature('s1').feature('fc1').set('maxiter', 50);
model.sol('sol1').feature('s1').feature('fc1').set('termonres', 'off');
model.sol('sol1').feature('s1').create('d1', 'Direct');
model.sol('sol1').feature('s1').feature('d1').set('linsolver', 'pardiso');
model.sol('sol1').feature('s1').feature('d1').set('pivotperturb', 1.0E-13);
model.sol('sol1').feature('s1').feature('d1').label('Direct, heat transfer variables (ht)');
model.sol('sol1').feature('s1').create('i1', 'Iterative');
model.sol('sol1').feature('s1').feature('i1').set('linsolver', 'gmres');
model.sol('sol1').feature('s1').feature('i1').set('prefuntype', 'left');
model.sol('sol1').feature('s1').feature('i1').set('itrestart', 50);
model.sol('sol1').feature('s1').feature('i1').set('rhob', 400);
model.sol('sol1').feature('s1').feature('i1').set('maxlinit', 10000);
model.sol('sol1').feature('s1').feature('i1').set('nlinnormuse', 'on');
model.sol('sol1').feature('s1').feature('i1').label('AMG, heat transfer variables (ht)');
model.sol('sol1').feature('s1').feature('i1').create('mg1', 'Multigrid');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').set('prefun', 'saamg');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').set('mgcycle', 'v');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').set('maxcoarsedof', 50000);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').set('strconn', 0.01);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').set('nullspace', 'constant');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').set('usesmooth', false);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').set('saamgcompwise', true);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').set('loweramg', true);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').set('compactaggregation', false);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('pr').create('so1', 'SOR');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('pr').feature('so1').set('iter', 2);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('pr').feature('so1').set('relax', 0.9);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('po').create('so1', 'SOR');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('po').feature('so1').set('iter', 2);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('po').feature('so1').set('relax', 0.9);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('cs').create('d1', 'Direct');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('cs').feature('d1').set('linsolver', 'pardiso');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('cs').feature('d1').set('pivotperturb', 1.0E-13);
model.sol('sol1').feature('s1').feature('fc1').set('linsolver', 'd1');
model.sol('sol1').feature('s1').feature('fc1').set('dtech', 'auto');
model.sol('sol1').feature('s1').feature('fc1').set('initstep', 0.01);
model.sol('sol1').feature('s1').feature('fc1').set('minstep', 1.0E-6);
model.sol('sol1').feature('s1').feature('fc1').set('maxiter', 50);
model.sol('sol1').feature('s1').feature('fc1').set('termonres', 'off');
model.sol('sol1').feature('s1').feature.remove('fcDef');
model.sol('sol1').attach('std1');
model.sol('sol1').runAll;

model.result.create('pg1', 'PlotGroup3D');
model.result('pg1').label('Temperature (ht)');
model.result('pg1').set('data', 'dset1');
model.result('pg1').set('defaultPlotID', 'ht/HT_PhysicsInterfaces/icom8/pdef1/pcond3/pcond2/pcond2/pg1');
model.result('pg1').selection.geom('geom1', 3);
model.result('pg1').selection.set([1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19]);
model.result('pg1').feature.create('vol1', 'Volume');
model.result('pg1').feature('vol1').label('Domain');
model.result('pg1').feature('vol1').set('showsolutionparams', 'on');
model.result('pg1').feature('vol1').set('solutionparams', 'parent');
model.result('pg1').feature('vol1').set('colortable', 'HeatCameraLight');
model.result('pg1').feature('vol1').set('smooth', 'internal');
model.result('pg1').feature('vol1').set('showsolutionparams', 'on');
model.result('pg1').feature('vol1').set('data', 'parent');
model.result('pg1').feature.create('slit1', 'SurfaceSlit');
model.result('pg1').feature('slit1').label('Nonlayered Shell');
model.result('pg1').feature('slit1').set('showsolutionparams', 'on');
model.result('pg1').feature('slit1').set('solutionparams', 'parent');
model.result('pg1').feature('slit1').set('upexpr', 'ht.Tu');
model.result('pg1').feature('slit1').set('downexpr', 'ht.Td');
model.result('pg1').feature('slit1').set('titletype', 'none');
model.result('pg1').feature('slit1').set('smooth', 'internal');
model.result('pg1').feature('slit1').set('showsolutionparams', 'on');
model.result('pg1').feature('slit1').set('data', 'parent');
model.result('pg1').feature('slit1').feature.create('sel1', 'Selection');
model.result('pg1').feature('slit1').feature('sel1').selection.geom('geom1', 2);
model.result('pg1').feature('slit1').feature('sel1').selection.set([7 37]);
model.result('pg1').feature('slit1').set('inheritplot', 'vol1');
model.result('pg1').run;
model.result('pg1').run;
model.result('pg1').feature('vol1').set('unit', 'degC');
model.result('pg1').run;
model.result('pg1').feature('slit1').set('upunit', 'degC');
model.result('pg1').feature('slit1').set('downunit', 'degC');
model.result('pg1').run;

model.view('view1').set('transparency', false);

model.result.create('pg2', 'PlotGroup3D');
model.result('pg2').label('Temperature, Multislice (ht)');
model.result('pg2').set('data', 'dset1');
model.result('pg2').set('defaultPlotID', 'ht/HT_PhysicsInterfaces/icom8/pdef1/pcond3/pcond2/pcond2/pg2');
model.result('pg2').feature.create('mslc1', 'Multislice');
model.result('pg2').feature('mslc1').set('solutionparams', 'parent');
model.result('pg2').feature('mslc1').set('colortable', 'HeatCameraLight');
model.result('pg2').feature('mslc1').set('smooth', 'internal');
model.result('pg2').feature('mslc1').set('showsolutionparams', 'on');
model.result('pg2').feature('mslc1').set('data', 'parent');
model.result('pg2').label('Temperature, Multislice (ht)');
model.result('pg2').run;
model.result('pg2').run;
model.result('pg2').feature('mslc1').set('xnumber', '3');
model.result('pg2').feature('mslc1').set('znumber', '2');
model.result('pg2').run;
model.result('pg2').run;
model.result.create('pg3', 'PlotGroup3D');
model.result('pg3').run;
model.result('pg3').label('Temperature, Chip Surface');
model.result('pg3').set('edges', false);
model.result('pg3').create('surf1', 'Surface');
model.result('pg3').feature('surf1').set('unit', 'degC');
model.result('pg3').feature('surf1').set('colortable', 'HeatCameraLight');
model.result('pg3').feature('surf1').create('sel1', 'Selection');
model.result('pg3').feature('surf1').feature('sel1').selection.set([195]);
model.result('pg3').run;
model.result('pg1').run;

model.title('Heat Transfer in a Surface-Mount Package for a Silicon Chip');

model.description('This example investigates the stationary temperature distribution in an integrated circuit mounted close to a hot component. The example uses the Heat Transfer interface and its Thin Layer feature.');

model.mesh.clearMeshes;

model.sol('sol1').clearSolutionData;

model.label('surface_mount_package.mph');

model.modelNode.label('Components');

out = model;
