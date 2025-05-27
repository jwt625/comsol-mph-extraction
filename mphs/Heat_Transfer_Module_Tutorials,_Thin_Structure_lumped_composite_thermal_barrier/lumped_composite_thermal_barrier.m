function out = model
%
% lumped_composite_thermal_barrier.m
%
% Model exported on May 26 2025, 21:29 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/Heat_Transfer_Module/Tutorials,_Thin_Structure');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 3);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.physics.create('ht', 'HeatTransfer', 'geom1');
model.physics('ht').model('comp1');

model.study.create('std1');
model.study('std1').create('stat', 'Stationary');
model.study('std1').feature('stat').setSolveFor('/physics/ht', true);

model.param.set('d_ceram1', '50[um]');
model.param.descr('d_ceram1', 'Thickness of layer 1');
model.param.set('d_ceram2', '75[um]');
model.param.descr('d_ceram2', 'Thickness of layer 2');
model.param.set('k_ceram1', '1[W/(m*K)]');
model.param.descr('k_ceram1', 'Thermal conductivity of layer 1');
model.param.set('k_ceram2', '0.5[W/(m*K)]');
model.param.descr('k_ceram2', 'Thermal conductivity of layer 2');
model.param.set('T_hot', '1220[degC]');
model.param.descr('T_hot', 'Hot temperature');

model.geom('geom1').lengthUnit('cm');
model.geom('geom1').create('cyl1', 'Cylinder');
model.geom('geom1').feature('cyl1').set('r', 2);
model.geom('geom1').feature('cyl1').set('h', 4);
model.geom('geom1').run('fin');
model.geom('geom1').run('cyl1');
model.geom('geom1').create('cyl2', 'Cylinder');
model.geom('geom1').feature('cyl2').set('r', 2);
model.geom('geom1').feature('cyl2').set('h', 'd_ceram1');
model.geom('geom1').feature('cyl2').set('pos', {'0' '0' '2-(d_ceram1+d_ceram2)/2'});
model.geom('geom1').run('fin');
model.geom('geom1').run('cyl2');
model.geom('geom1').create('cyl3', 'Cylinder');
model.geom('geom1').feature('cyl3').set('r', 2);
model.geom('geom1').feature('cyl3').set('h', 'd_ceram2');
model.geom('geom1').feature('cyl3').set('pos', {'0' '0' '2-(d_ceram1+d_ceram2)/2+d_ceram1'});
model.geom('geom1').run('fin');
model.geom('geom1').run('cyl3');
model.geom('geom1').create('pol1', 'Polygon');
model.geom('geom1').feature('pol1').set('source', 'table');
model.geom('geom1').feature('pol1').setIndex('table', 0, 0, 0);
model.geom('geom1').feature('pol1').setIndex('table', -2, 0, 1);
model.geom('geom1').feature('pol1').setIndex('table', 4, 0, 2);
model.geom('geom1').feature('pol1').setIndex('table', 0, 1, 0);
model.geom('geom1').feature('pol1').setIndex('table', 2, 1, 1);
model.geom('geom1').feature('pol1').setIndex('table', 4, 1, 2);
model.geom('geom1').run('fin');

model.material.create('matlnk1', 'Link', 'comp1');
model.material.create('mat1', 'Common', '');
model.material('mat1').propertyGroup.create('Enu', 'Young''s modulus and Poisson''s ratio');
model.material('mat1').label('Steel AISI 4340');
model.material('mat1').set('family', 'steel');
model.material('mat1').propertyGroup('def').set('relpermeability', {'1' '0' '0' '0' '1' '0' '0' '0' '1'});
model.material('mat1').propertyGroup('def').set('electricconductivity', {'4.032e6[S/m]' '0' '0' '0' '4.032e6[S/m]' '0' '0' '0' '4.032e6[S/m]'});
model.material('mat1').propertyGroup('def').set('thermalexpansioncoefficient', {'12.3e-6[1/K]' '0' '0' '0' '12.3e-6[1/K]' '0' '0' '0' '12.3e-6[1/K]'});
model.material('mat1').propertyGroup('def').set('heatcapacity', '475[J/(kg*K)]');
model.material('mat1').propertyGroup('def').set('relpermittivity', {'1' '0' '0' '0' '1' '0' '0' '0' '1'});
model.material('mat1').propertyGroup('def').set('density', '7850[kg/m^3]');
model.material('mat1').propertyGroup('def').set('thermalconductivity', {'44.5[W/(m*K)]' '0' '0' '0' '44.5[W/(m*K)]' '0' '0' '0' '44.5[W/(m*K)]'});
model.material('mat1').propertyGroup('Enu').set('E', '205[GPa]');
model.material('mat1').propertyGroup('Enu').set('nu', '0.28');
model.material('matlnk1').set('link', 'mat1');
model.material.create('matlnk2', 'Link', 'comp1');
model.material('matlnk2').selection.set([2]);
model.material.create('mat2', 'Common', '');
model.material('matlnk2').set('link', 'mat2');
model.material('mat2').label('Ceramic 1');
model.material('mat2').propertyGroup('def').set('thermalconductivity', {'k_ceram1'});
model.material('mat2').propertyGroup('def').set('density', {'6000'});
model.material('mat2').propertyGroup('def').set('heatcapacity', {'320'});
model.material.create('matlnk3', 'Link', 'comp1');
model.material('matlnk3').selection.set([3]);
model.material.create('mat3', 'Common', '');
model.material('matlnk3').set('link', 'mat3');
model.material('mat3').label('Ceramic 2');
model.material('mat3').propertyGroup('def').set('thermalconductivity', {'k_ceram2'});
model.material('mat3').propertyGroup('def').set('density', {'5800'});
model.material('mat3').propertyGroup('def').set('heatcapacity', {'280'});

model.physics('ht').create('temp1', 'TemperatureBoundary', 2);
model.physics('ht').feature('temp1').selection.set([3]);
model.physics('ht').create('temp2', 'TemperatureBoundary', 2);
model.physics('ht').feature('temp2').selection.set([13]);
model.physics('ht').feature('temp2').set('T0', 'T_hot');

model.mesh('mesh1').create('ftri1', 'FreeTri');
model.mesh('mesh1').feature('ftri1').selection.set([13 18]);
model.mesh('mesh1').run('ftri1');
model.mesh('mesh1').create('swe1', 'Sweep');
model.mesh('mesh1').feature('swe1').create('dis1', 'Distribution');
model.mesh('mesh1').feature('swe1').feature('dis1').selection.set([2 3]);
model.mesh('mesh1').feature('swe1').feature('dis1').set('numelem', 2);
model.mesh('mesh1').run;

model.study('std1').label('Study 1: 3D approach');

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
model.sol('sol1').feature('s1').feature('i1').set('rhob', 20);
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
model.result('pg1').set('defaultPlotID', 'ht/HT_PhysicsInterfaces/icom8/pdef1/pcond3/pcond3/pg1');
model.result('pg1').feature.create('vol1', 'Volume');
model.result('pg1').feature('vol1').set('showsolutionparams', 'on');
model.result('pg1').feature('vol1').set('solutionparams', 'parent');
model.result('pg1').feature('vol1').set('colortable', 'HeatCameraLight');
model.result('pg1').feature('vol1').set('smooth', 'internal');
model.result('pg1').feature('vol1').set('showsolutionparams', 'on');
model.result('pg1').feature('vol1').set('data', 'parent');
model.result('pg1').run;
model.result('pg1').label('Temperature, 3D approach');
model.result('pg1').run;
model.result('pg1').feature('vol1').set('unit', 'degC');
model.result('pg1').run;

model.modelNode.create('comp2', true);

model.geom.create('geom2', 3);
model.geom('geom2').model('comp2');

model.mesh.create('mesh2', 'geom2');

model.physics.create('ht2', 'HeatTransfer', 'geom2');
model.physics('ht2').model('comp2');

model.study('std1').feature('stat').setSolveFor('/physics/ht2', false);

model.geom('geom2').run;

model.physics.create('lts', 'LumpedThermalSystem', 'geom2');
model.physics('lts').model('comp2');

model.study('std1').feature('stat').setSolveFor('/physics/lts', false);
model.study.create('std2');
model.study('std2').create('stat', 'Stationary');
model.study('std2').feature('stat').setSolveFor('/physics/ht', false);
model.study('std2').feature('stat').setSolveFor('/physics/ht2', true);
model.study('std2').feature('stat').setSolveFor('/physics/lts', true);

model.geom('geom2').lengthUnit('cm');
model.geom('geom2').create('cyl1', 'Cylinder');
model.geom('geom2').feature('cyl1').set('r', 2);
model.geom('geom2').feature('cyl1').set('h', '2-(d_ceram1+d_ceram2)/2');
model.geom('geom2').run('cyl1');
model.geom('geom2').create('cyl2', 'Cylinder');
model.geom('geom2').feature('cyl2').set('r', 2);
model.geom('geom2').feature('cyl2').set('h', '2-(d_ceram1+d_ceram2)/2');
model.geom('geom2').feature('cyl2').set('pos', {'0' '0' '2+(d_ceram1+d_ceram2)/2'});
model.geom('geom2').run('fin');
model.geom('geom2').run('cyl2');
model.geom('geom2').create('pol1', 'Polygon');
model.geom('geom2').feature('pol1').set('source', 'table');
model.geom('geom2').feature('pol1').setIndex('table', 0, 0, 0);
model.geom('geom2').feature('pol1').setIndex('table', -2, 0, 1);
model.geom('geom2').feature('pol1').setIndex('table', 4, 0, 2);
model.geom('geom2').feature('pol1').setIndex('table', 0, 1, 0);
model.geom('geom2').feature('pol1').setIndex('table', 2, 1, 1);
model.geom('geom2').feature('pol1').setIndex('table', 4, 1, 2);
model.geom('geom2').run('fin');

model.view('view2').set('transparency', false);

model.material.create('matlnk4', 'Link', 'comp2');

model.physics('lts').create('R1', 'ConductiveThermalResistor', -1);
model.physics('lts').feature('R1').label('Ceramic 1');
model.physics('lts').feature('R1').set('resistorType', 'GeometricProperties');
model.physics('lts').feature('R1').set('matlist', 'mat2');
model.physics('lts').feature('R1').set('A', 'pi*(2[cm])^2');
model.physics('lts').feature('R1').set('L', 'd_ceram1');
model.physics('lts').feature.duplicate('R2', 'R1');
model.physics('lts').feature('R2').label('Ceramic 2');
model.physics('lts').feature('R2').set('matlist', 'mat3');
model.physics('lts').feature('R2').set('L', 'd_ceram2');
model.physics('lts').feature('R2').setIndex('Connections', 1, 0, 0);
model.physics('lts').feature('R2').setIndex('Connections', 2, 1, 0);
model.physics('lts').create('term1', 'ExternalTerminal', -1);
model.physics('lts').feature('term1').set('Connections', 0);
model.physics('lts').create('term2', 'ExternalTerminal', -1);
model.physics('lts').feature('term2').set('Connections', 2);
model.physics('ht2').create('thermc1', 'ThermalConnection', -1);
model.physics('ht2').feature('thermc1').selection('selectionConnector1').set([4]);
model.physics('ht2').feature('thermc1').selection('selectionConnector2').set([7]);
model.physics('ht2').feature('thermc1').set('connectionType', 'LumpedThermalSystem');
model.physics('ht2').feature('thermc1').set('P_connect2_src', 'root.comp2.lts.term2.P_connect_connector_2');
model.physics('ht2').create('temp1', 'TemperatureBoundary', 2);
model.physics('ht2').feature('temp1').selection.set([3]);
model.physics('ht2').create('temp2', 'TemperatureBoundary', 2);
model.physics('ht2').feature('temp2').selection.set([8]);
model.physics('ht2').feature('temp2').set('T0', 'T_hot');

model.mesh('mesh2').create('ftri1', 'FreeTri');
model.mesh('mesh2').feature('ftri1').selection.set([8 11]);
model.mesh('mesh2').run('ftri1');
model.mesh('mesh2').create('swe1', 'Sweep');
model.mesh('mesh2').run;

model.study('std2').label('Study 2: Lumped Thermal System approach');

model.sol.create('sol2');
model.sol('sol2').study('std2');
model.sol('sol2').create('st1', 'StudyStep');
model.sol('sol2').feature('st1').set('study', 'std2');
model.sol('sol2').feature('st1').set('studystep', 'stat');
model.sol('sol2').create('v1', 'Variables');
model.sol('sol2').feature('v1').set('control', 'stat');
model.sol('sol2').create('s1', 'Stationary');
model.sol('sol2').feature('s1').create('seDef', 'Segregated');
model.sol('sol2').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol2').feature('s1').feature('fc1').set('dtech', 'const');
model.sol('sol2').feature('s1').feature('fc1').set('initstep', 0.01);
model.sol('sol2').feature('s1').feature('fc1').set('minstep', 1.0E-6);
model.sol('sol2').feature('s1').feature('fc1').set('maxiter', 50);
model.sol('sol2').feature('s1').feature('fc1').set('termonres', 'off');
model.sol('sol2').feature('s1').feature('fc1').set('damp', 1);
model.sol('sol2').feature('s1').feature('fc1').set('jtech', 'onevery');
model.sol('sol2').feature('s1').create('d1', 'Direct');
model.sol('sol2').feature('s1').feature('d1').set('linsolver', 'pardiso');
model.sol('sol2').feature('s1').feature('d1').set('pivotperturb', 1.0E-13);
model.sol('sol2').feature('s1').feature('d1').label('Direct, heat transfer variables () (Merged)');
model.sol('sol2').feature('s1').create('i1', 'Iterative');
model.sol('sol2').feature('s1').feature('i1').set('linsolver', 'gmres');
model.sol('sol2').feature('s1').feature('i1').set('prefuntype', 'left');
model.sol('sol2').feature('s1').feature('i1').set('itrestart', 50);
model.sol('sol2').feature('s1').feature('i1').set('rhob', 20);
model.sol('sol2').feature('s1').feature('i1').set('maxlinit', 10000);
model.sol('sol2').feature('s1').feature('i1').set('nlinnormuse', 'on');
model.sol('sol2').feature('s1').feature('i1').label('AMG, heat transfer variables ()');
model.sol('sol2').feature('s1').feature('i1').create('mg1', 'Multigrid');
model.sol('sol2').feature('s1').feature('i1').feature('mg1').set('prefun', 'saamg');
model.sol('sol2').feature('s1').feature('i1').feature('mg1').set('mgcycle', 'v');
model.sol('sol2').feature('s1').feature('i1').feature('mg1').set('maxcoarsedof', 50000);
model.sol('sol2').feature('s1').feature('i1').feature('mg1').set('strconn', 0.01);
model.sol('sol2').feature('s1').feature('i1').feature('mg1').set('nullspace', 'constant');
model.sol('sol2').feature('s1').feature('i1').feature('mg1').set('usesmooth', false);
model.sol('sol2').feature('s1').feature('i1').feature('mg1').set('saamgcompwise', true);
model.sol('sol2').feature('s1').feature('i1').feature('mg1').set('loweramg', true);
model.sol('sol2').feature('s1').feature('i1').feature('mg1').set('compactaggregation', false);
model.sol('sol2').feature('s1').feature('i1').feature('mg1').set('hybridization', 'multi');
model.sol('sol2').feature('s1').feature('i1').feature('mg1').set('hybridvar', {'comp2_T2' 'comp2_T2' 'comp2_T2' 'comp2_T2' 'comp2_ht2_thermc1_T_ode1' 'comp2_ht2_thermc1_T_ode2'});
model.sol('sol2').feature('s1').feature('i1').feature('mg1').feature('cs').create('d1', 'Direct');
model.sol('sol2').feature('s1').feature('i1').feature('mg1').feature('cs').feature('d1').set('linsolver', 'pardiso');
model.sol('sol2').feature('s1').feature('i1').feature('mg1').feature('cs').feature('d1').set('pivotperturb', 1.0E-13);
model.sol('sol2').feature('s1').feature('i1').create('dp1', 'DirectPreconditioner');
model.sol('sol2').feature('s1').feature('i1').feature('dp1').set('linsolver', 'pardiso');
model.sol('sol2').feature('s1').feature('i1').feature('dp1').set('pivotperturb', 1.0E-13);
model.sol('sol2').feature('s1').feature('i1').feature('dp1').set('hybridization', 'multi');
model.sol('sol2').feature('s1').feature('i1').feature('dp1').set('hybridvar', {'comp2_other' 'comp2_heatRates'});
model.sol('sol2').feature('s1').feature('fc1').set('linsolver', 'd1');
model.sol('sol2').feature('s1').feature('fc1').set('dtech', 'const');
model.sol('sol2').feature('s1').feature('fc1').set('initstep', 0.01);
model.sol('sol2').feature('s1').feature('fc1').set('minstep', 1.0E-6);
model.sol('sol2').feature('s1').feature('fc1').set('maxiter', 50);
model.sol('sol2').feature('s1').feature('fc1').set('termonres', 'off');
model.sol('sol2').feature('s1').feature('fc1').set('damp', 1);
model.sol('sol2').feature('s1').feature('fc1').set('jtech', 'onevery');
model.sol('sol2').feature('s1').feature.remove('fcDef');
model.sol('sol2').feature('s1').feature.remove('seDef');
model.sol('sol2').attach('std2');
model.sol('sol2').runAll;

model.result.create('pg2', 'PlotGroup3D');
model.result('pg2').label('Temperature (ht2)');
model.result('pg2').set('data', 'dset3');
model.result('pg2').set('defaultPlotID', 'ht/HT_PhysicsInterfaces/icom8/pdef1/pcond3/pcond3/pg1');
model.result('pg2').feature.create('vol1', 'Volume');
model.result('pg2').feature('vol1').set('showsolutionparams', 'on');
model.result('pg2').feature('vol1').set('solutionparams', 'parent');
model.result('pg2').feature('vol1').set('colortable', 'HeatCameraLight');
model.result('pg2').feature('vol1').set('smooth', 'internal');
model.result('pg2').feature('vol1').set('showsolutionparams', 'on');
model.result('pg2').feature('vol1').set('data', 'parent');
model.result.evaluationGroup.create('eg1', 'EvaluationGroup');
model.result.evaluationGroup('eg1').label('Temperature (lts)');
model.result.evaluationGroup('eg1').set('data', 'dset3');
model.result.evaluationGroup('eg1').set('transpose', true);
model.result.evaluationGroup('eg1').set('data', 'dset3');
model.result.evaluationGroup('eg1').set('defaultPlotID', 'Temperature_eg');
model.result.evaluationGroup.create('eg2', 'EvaluationGroup');
model.result.evaluationGroup('eg2').label('Heat Rate (lts)');
model.result.evaluationGroup('eg2').set('data', 'dset3');
model.result.evaluationGroup('eg2').set('transpose', true);
model.result.evaluationGroup('eg2').set('data', 'dset3');
model.result.evaluationGroup('eg2').set('defaultPlotID', 'Power_eg');
model.result.evaluationGroup('eg1').set('data', 'dset3');
model.result.evaluationGroup('eg1').set('defaultPlotID', 'Temperature_eg');
model.result.evaluationGroup('eg1').feature.create('gev1', 'EvalGlobal');
model.result.evaluationGroup('eg1').feature('gev1').set('showsolutionparams', 'on');
model.result.evaluationGroup('eg1').feature('gev1').set('solutionparams', 'parent');
model.result.evaluationGroup('eg1').feature('gev1').set('expr', {'lts.R1_p1_T'});
model.result.evaluationGroup('eg1').feature('gev1').set('showsolutionparams', 'on');
model.result.evaluationGroup('eg1').feature('gev1').set('data', 'parent');
model.result.evaluationGroup('eg1').set('data', 'dset3');
model.result.evaluationGroup('eg1').set('defaultPlotID', 'Temperature_eg');
model.result.evaluationGroup('eg1').feature('gev1').set('expr', {});
model.result.evaluationGroup('eg1').feature('gev1').set('descr', {});
model.result.evaluationGroup('eg1').feature('gev1').set('expr', {'lts.R1_p2_T'});
model.result.evaluationGroup('eg1').feature('gev1').set('descr', {'Temperature p1 (R1)' 'Temperature p2 (R1)'});
model.result.evaluationGroup('eg1').feature('gev1').set('expr', {'lts.R1_p1_T' 'lts.R1_p2_T'});
model.result.evaluationGroup('eg1').feature('gev1').set('data', 'parent');
model.result.evaluationGroup('eg2').set('data', 'dset3');
model.result.evaluationGroup('eg2').set('defaultPlotID', 'Power_eg');
model.result.evaluationGroup('eg2').feature.create('gev1', 'EvalGlobal');
model.result.evaluationGroup('eg2').feature('gev1').set('showsolutionparams', 'on');
model.result.evaluationGroup('eg2').feature('gev1').set('solutionparams', 'parent');
model.result.evaluationGroup('eg2').feature('gev1').set('expr', {'lts.R1_P'});
model.result.evaluationGroup('eg2').feature('gev1').set('showsolutionparams', 'on');
model.result.evaluationGroup('eg2').feature('gev1').set('data', 'parent');
model.result.evaluationGroup('eg1').set('data', 'dset3');
model.result.evaluationGroup('eg1').set('defaultPlotID', 'Temperature_eg');
model.result.evaluationGroup('eg1').feature('gev1').set('expr', {});
model.result.evaluationGroup('eg1').feature('gev1').set('descr', {});
model.result.evaluationGroup('eg1').feature('gev1').set('expr', {'lts.R2_p1_T'});
model.result.evaluationGroup('eg1').feature('gev1').set('descr', {'Temperature p1 (R1)' 'Temperature p2 (R1)' 'Temperature p1 (R2)'});
model.result.evaluationGroup('eg1').feature('gev1').set('expr', {'lts.R1_p1_T' 'lts.R1_p2_T' 'lts.R2_p1_T'});
model.result.evaluationGroup('eg1').feature('gev1').set('data', 'parent');
model.result.evaluationGroup('eg1').set('data', 'dset3');
model.result.evaluationGroup('eg1').set('defaultPlotID', 'Temperature_eg');
model.result.evaluationGroup('eg1').feature('gev1').set('expr', {});
model.result.evaluationGroup('eg1').feature('gev1').set('descr', {});
model.result.evaluationGroup('eg1').feature('gev1').set('expr', {'lts.R2_p2_T'});
model.result.evaluationGroup('eg1').feature('gev1').set('descr', {'Temperature p1 (R1)' 'Temperature p2 (R1)' 'Temperature p1 (R2)' 'Temperature p2 (R2)'});
model.result.evaluationGroup('eg1').feature('gev1').set('expr', {'lts.R1_p1_T' 'lts.R1_p2_T' 'lts.R2_p1_T' 'lts.R2_p2_T'});
model.result.evaluationGroup('eg1').feature('gev1').set('data', 'parent');
model.result.evaluationGroup('eg2').set('data', 'dset3');
model.result.evaluationGroup('eg2').set('defaultPlotID', 'Power_eg');
model.result.evaluationGroup('eg2').feature('gev1').set('expr', {});
model.result.evaluationGroup('eg2').feature('gev1').set('descr', {});
model.result.evaluationGroup('eg2').feature('gev1').set('expr', {'lts.R2_P'});
model.result.evaluationGroup('eg2').feature('gev1').set('descr', {'Heat rate (R1)' 'Heat rate (R2)'});
model.result.evaluationGroup('eg2').feature('gev1').set('expr', {'lts.R1_P' 'lts.R2_P'});
model.result.evaluationGroup('eg2').feature('gev1').set('data', 'parent');
model.result('pg2').run;
model.result('pg2').label('Temperature, Lumped Thermal System approach');
model.result('pg2').run;
model.result('pg2').feature('vol1').set('unit', 'degC');

model.modelNode.create('comp3', true);

model.geom.create('geom3', 3);
model.geom('geom3').model('comp3');

model.mesh.create('mesh3', 'geom3');

model.physics.create('ht3', 'HeatTransfer', 'geom3');
model.physics('ht3').model('comp3');

model.study('std1').feature('stat').setSolveFor('/physics/ht3', false);
model.study('std2').feature('stat').setSolveFor('/physics/ht3', false);

model.geom('geom3').run;

model.study.create('std3');
model.study('std3').create('stat', 'Stationary');
model.study('std3').feature('stat').setSolveFor('/physics/ht', false);
model.study('std3').feature('stat').setSolveFor('/physics/ht2', false);
model.study('std3').feature('stat').setSolveFor('/physics/lts', false);
model.study('std3').feature('stat').setSolveFor('/physics/ht3', true);

model.geom('geom3').lengthUnit('cm');
model.geom('geom3').create('cyl1', 'Cylinder');
model.geom('geom3').feature('cyl1').set('r', 2);
model.geom('geom3').feature('cyl1').set('h', '2-(d_ceram1+d_ceram2)/2');
model.geom('geom3').run('cyl1');
model.geom('geom3').create('cyl2', 'Cylinder');
model.geom('geom3').feature('cyl2').set('r', 2);
model.geom('geom3').feature('cyl2').set('h', '2-(d_ceram1+d_ceram2)/2');
model.geom('geom3').feature('cyl2').set('pos', {'0' '0' '2+(d_ceram1+d_ceram2)/2'});
model.geom('geom3').run('fin');
model.geom('geom3').run('cyl2');
model.geom('geom3').create('pol1', 'Polygon');
model.geom('geom3').feature('pol1').set('source', 'table');
model.geom('geom3').feature('pol1').setIndex('table', 0, 0, 0);
model.geom('geom3').feature('pol1').setIndex('table', -2, 0, 1);
model.geom('geom3').feature('pol1').setIndex('table', 4, 0, 2);
model.geom('geom3').feature('pol1').setIndex('table', 0, 1, 0);
model.geom('geom3').feature('pol1').setIndex('table', 2, 1, 1);
model.geom('geom3').feature('pol1').setIndex('table', 4, 1, 2);
model.geom('geom3').run('fin');

model.material.create('matlnk5', 'Link', 'comp3');

model.physics('ht3').create('thermc1', 'ThermalConnection', -1);
model.physics('ht3').feature('thermc1').selection('selectionConnector1').set([4]);
model.physics('ht3').feature('thermc1').selection('selectionConnector2').set([7]);
model.physics('ht3').feature('thermc1').set('R', '(d_ceram1/k_ceram1+d_ceram2/k_ceram2)/(pi*(2[cm])^2)');
model.physics('ht3').create('temp1', 'TemperatureBoundary', 2);
model.physics('ht3').feature('temp1').selection.set([3]);
model.physics('ht3').create('temp2', 'TemperatureBoundary', 2);
model.physics('ht3').feature('temp2').selection.set([8]);
model.physics('ht3').feature('temp2').set('T0', 'T_hot');

model.mesh('mesh3').create('ftri1', 'FreeTri');
model.mesh('mesh3').feature('ftri1').selection.set([8 11]);
model.mesh('mesh3').run('ftri1');
model.mesh('mesh3').create('swe1', 'Sweep');
model.mesh('mesh3').run;

model.study('std3').label('Study 3: Resistor Thermal Connection approach');

model.sol.create('sol3');
model.sol('sol3').study('std3');
model.sol('sol3').create('st1', 'StudyStep');
model.sol('sol3').feature('st1').set('study', 'std3');
model.sol('sol3').feature('st1').set('studystep', 'stat');
model.sol('sol3').create('v1', 'Variables');
model.sol('sol3').feature('v1').set('control', 'stat');
model.sol('sol3').create('s1', 'Stationary');
model.sol('sol3').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol3').feature('s1').feature('fc1').set('dtech', 'auto');
model.sol('sol3').feature('s1').feature('fc1').set('initstep', 0.01);
model.sol('sol3').feature('s1').feature('fc1').set('minstep', 1.0E-6);
model.sol('sol3').feature('s1').feature('fc1').set('maxiter', 50);
model.sol('sol3').feature('s1').feature('fc1').set('termonres', 'off');
model.sol('sol3').feature('s1').create('d1', 'Direct');
model.sol('sol3').feature('s1').feature('d1').set('linsolver', 'pardiso');
model.sol('sol3').feature('s1').feature('d1').set('pivotperturb', 1.0E-13);
model.sol('sol3').feature('s1').feature('d1').label('Direct, heat transfer variables (ht3)');
model.sol('sol3').feature('s1').create('i1', 'Iterative');
model.sol('sol3').feature('s1').feature('i1').set('linsolver', 'gmres');
model.sol('sol3').feature('s1').feature('i1').set('prefuntype', 'left');
model.sol('sol3').feature('s1').feature('i1').set('itrestart', 50);
model.sol('sol3').feature('s1').feature('i1').set('rhob', 20);
model.sol('sol3').feature('s1').feature('i1').set('maxlinit', 10000);
model.sol('sol3').feature('s1').feature('i1').set('nlinnormuse', 'on');
model.sol('sol3').feature('s1').feature('i1').label('AMG, heat transfer variables (ht3)');
model.sol('sol3').feature('s1').feature('i1').create('mg1', 'Multigrid');
model.sol('sol3').feature('s1').feature('i1').feature('mg1').set('prefun', 'saamg');
model.sol('sol3').feature('s1').feature('i1').feature('mg1').set('mgcycle', 'v');
model.sol('sol3').feature('s1').feature('i1').feature('mg1').set('maxcoarsedof', 50000);
model.sol('sol3').feature('s1').feature('i1').feature('mg1').set('strconn', 0.01);
model.sol('sol3').feature('s1').feature('i1').feature('mg1').set('nullspace', 'constant');
model.sol('sol3').feature('s1').feature('i1').feature('mg1').set('usesmooth', false);
model.sol('sol3').feature('s1').feature('i1').feature('mg1').set('saamgcompwise', true);
model.sol('sol3').feature('s1').feature('i1').feature('mg1').set('loweramg', true);
model.sol('sol3').feature('s1').feature('i1').feature('mg1').set('compactaggregation', false);
model.sol('sol3').feature('s1').feature('i1').feature('mg1').feature('pr').create('so1', 'SOR');
model.sol('sol3').feature('s1').feature('i1').feature('mg1').feature('pr').feature('so1').set('iter', 2);
model.sol('sol3').feature('s1').feature('i1').feature('mg1').feature('pr').feature('so1').set('relax', 0.9);
model.sol('sol3').feature('s1').feature('i1').feature('mg1').feature('po').create('so1', 'SOR');
model.sol('sol3').feature('s1').feature('i1').feature('mg1').feature('po').feature('so1').set('iter', 2);
model.sol('sol3').feature('s1').feature('i1').feature('mg1').feature('po').feature('so1').set('relax', 0.9);
model.sol('sol3').feature('s1').feature('i1').feature('mg1').feature('cs').create('d1', 'Direct');
model.sol('sol3').feature('s1').feature('i1').feature('mg1').feature('cs').feature('d1').set('linsolver', 'pardiso');
model.sol('sol3').feature('s1').feature('i1').feature('mg1').feature('cs').feature('d1').set('pivotperturb', 1.0E-13);
model.sol('sol3').feature('s1').feature('fc1').set('linsolver', 'd1');
model.sol('sol3').feature('s1').feature('fc1').set('dtech', 'auto');
model.sol('sol3').feature('s1').feature('fc1').set('initstep', 0.01);
model.sol('sol3').feature('s1').feature('fc1').set('minstep', 1.0E-6);
model.sol('sol3').feature('s1').feature('fc1').set('maxiter', 50);
model.sol('sol3').feature('s1').feature('fc1').set('termonres', 'off');
model.sol('sol3').feature('s1').feature.remove('fcDef');
model.sol('sol3').attach('std3');
model.sol('sol3').runAll;

model.result.create('pg3', 'PlotGroup3D');
model.result('pg3').label('Temperature (ht3)');
model.result('pg3').set('data', 'dset6');
model.result('pg3').set('defaultPlotID', 'ht/HT_PhysicsInterfaces/icom8/pdef1/pcond3/pcond3/pg1');
model.result('pg3').feature.create('vol1', 'Volume');
model.result('pg3').feature('vol1').set('showsolutionparams', 'on');
model.result('pg3').feature('vol1').set('solutionparams', 'parent');
model.result('pg3').feature('vol1').set('colortable', 'HeatCameraLight');
model.result('pg3').feature('vol1').set('smooth', 'internal');
model.result('pg3').feature('vol1').set('showsolutionparams', 'on');
model.result('pg3').feature('vol1').set('data', 'parent');
model.result('pg3').run;
model.result('pg3').label('Temperature, Resistor Thermal Connection approach');
model.result('pg3').run;
model.result('pg3').feature('vol1').set('unit', 'degC');
model.result.create('pg4', 'PlotGroup1D');
model.result('pg4').run;
model.result('pg4').label('Temperature Profiles');
model.result('pg4').set('xlabelactive', true);
model.result('pg4').set('xlabel', 'Height (cm)');
model.result('pg4').set('titletype', 'manual');
model.result('pg4').set('title', 'Temperature Profile');
model.result('pg4').set('legendpos', 'upperleft');
model.result('pg4').set('legendmaxwidthinside', 0.6);
model.result('pg4').create('lngr1', 'LineGraph');
model.result('pg4').feature('lngr1').set('markerpos', 'datapoints');
model.result('pg4').feature('lngr1').set('linewidth', 'preference');
model.result('pg4').feature('lngr1').selection.set([15 17 19 21]);
model.result('pg4').feature('lngr1').set('data', 'dset1');
model.result('pg4').feature('lngr1').set('unit', 'degC');
model.result('pg4').feature('lngr1').set('xdata', 'expr');
model.result('pg4').feature('lngr1').set('xdataexpr', 'z');
model.result('pg4').feature('lngr1').set('linewidth', 2);
model.result('pg4').feature('lngr1').set('legend', true);
model.result('pg4').feature('lngr1').set('legendmethod', 'manual');
model.result('pg4').feature('lngr1').setIndex('legends', 'Temperature, 3D approach', 0);
model.result('pg4').run;
model.result('pg4').create('lngr2', 'LineGraph');
model.result('pg4').feature('lngr2').set('markerpos', 'datapoints');
model.result('pg4').feature('lngr2').set('linewidth', 'preference');
model.result('pg4').feature('lngr2').set('data', 'dset3');
model.result('pg4').feature('lngr2').selection.set([11 14]);
model.result('pg4').feature('lngr2').set('expr', 'T2');
model.result('pg4').feature('lngr2').set('unit', 'degC');
model.result('pg4').feature('lngr2').set('xdata', 'expr');
model.result('pg4').feature('lngr2').set('xdataexpr', 'z');
model.result('pg4').feature('lngr2').set('linestyle', 'none');
model.result('pg4').feature('lngr2').set('linecolor', 'magenta');
model.result('pg4').feature('lngr2').set('linemarker', 'asterisk');
model.result('pg4').feature('lngr2').set('markerpos', 'interp');
model.result('pg4').feature('lngr2').set('markers', 30);
model.result('pg4').feature('lngr2').set('legend', true);
model.result('pg4').feature('lngr2').set('legendmethod', 'manual');
model.result('pg4').feature('lngr2').setIndex('legends', 'Temperature, Lumped Thermal System', 0);
model.result('pg4').run;
model.result('pg4').create('lngr3', 'LineGraph');
model.result('pg4').feature('lngr3').set('markerpos', 'datapoints');
model.result('pg4').feature('lngr3').set('linewidth', 'preference');
model.result('pg4').feature('lngr3').set('data', 'dset6');
model.result('pg4').feature('lngr3').selection.set([11 14]);
model.result('pg4').feature('lngr3').set('expr', 'T3');
model.result('pg4').feature('lngr3').set('unit', 'degC');
model.result('pg4').feature('lngr3').set('xdata', 'expr');
model.result('pg4').feature('lngr3').set('xdataexpr', 'z');
model.result('pg4').feature('lngr3').set('linestyle', 'none');
model.result('pg4').feature('lngr3').set('linemarker', 'circle');
model.result('pg4').feature('lngr3').set('linecolor', 'green');
model.result('pg4').feature('lngr3').set('markerpos', 'interp');
model.result('pg4').feature('lngr3').set('markers', 30);
model.result('pg4').feature('lngr3').set('legend', true);
model.result('pg4').feature('lngr3').set('legendmethod', 'manual');
model.result('pg4').feature('lngr3').setIndex('legends', 'Temperature, Resistor Thermal Connection', 0);
model.result('pg4').run;

model.modelNode('comp1').label('Component 1: 3D approach');
model.modelNode('comp2').label('Component 2: Lumped Thermal System approach');
model.modelNode('comp3').label('Component 3: Resistor Thermal Connection approach');

model.result('pg1').run;

model.title('Lumped Composite Thermal Barrier');

model.description(['This example is a variant of the Composite Thermal Barrier tutorial and shows how to set up multiple sandwiched thin layers with different thermal conductivities in two different ways.' newline 'First, the composite is modeled as a 3D object. ' newline 'In the second approach the Lumped Thermal System physics interface is used to avoid resolving the thin domains by use of a thermal circuit modeling. ' newline 'Finally, the equivalent lumped system is simulated with a single resistor carrying the equivalent thermal resistance of the thin layers by the use of the Thermal Connection feature only.']);

model.mesh.clearMeshes;

model.sol('sol1').clearSolutionData;
model.sol('sol2').clearSolutionData;
model.sol('sol3').clearSolutionData;

model.label('lumped_composite_thermal_barrier.mph');

model.modelNode.label('Components');

out = model;
