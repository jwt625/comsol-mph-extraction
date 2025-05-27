function out = model
%
% heat_exchanger_iso.m
%
% Model exported on May 26 2025, 21:29 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/Heat_Transfer_Module/Heat_Exchangers');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 3);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.physics.create('ht', 'HeatTransferInSolidsAndFluids', 'geom1');
model.physics('ht').model('comp1');

model.study.create('std1');
model.study('std1').create('stat', 'Stationary');
model.study('std1').feature('stat').setSolveFor('/physics/ht', true);

model.param.set('R', '50[um]');
model.param.descr('R', 'Channel radius');
model.param.set('v_max', '50[mm/s]');
model.param.descr('v_max', 'Maximum velocity');
model.param.set('T_hot', '330[K]');
model.param.descr('T_hot', 'Temperature, hot channel');
model.param.set('T_cold', '300[K]');
model.param.descr('T_cold', 'Temperature, cold channel');

model.geom('geom1').lengthUnit([native2unicode(hex2dec({'00' 'b5'}), 'unicode') 'm']);
model.geom('geom1').create('blk1', 'Block');
model.geom('geom1').feature('blk1').set('size', [100 400 300]);
model.geom('geom1').run('fin');
model.geom('geom1').run('blk1');
model.geom('geom1').create('cyl1', 'Cylinder');
model.geom('geom1').feature('cyl1').set('r', 'R');
model.geom('geom1').feature('cyl1').set('h', 400);
model.geom('geom1').feature('cyl1').set('pos', {'0' '0' '2*R'});
model.geom('geom1').feature('cyl1').set('axistype', 'y');
model.geom('geom1').run('fin');
model.geom('geom1').run('cyl1');
model.geom('geom1').create('copy1', 'Copy');
model.geom('geom1').feature('copy1').selection('input').set({'cyl1'});
model.geom('geom1').feature('copy1').set('displx', '2*R');
model.geom('geom1').feature('copy1').set('displz', '2*R');
model.geom('geom1').run('fin');
model.geom('geom1').run('copy1');
model.geom('geom1').create('co1', 'Compose');
model.geom('geom1').feature('co1').selection('input').set({'blk1' 'copy1' 'cyl1'});
model.geom('geom1').feature('co1').set('formula', 'blk1*(cyl1+copy1)+blk1');
model.geom('geom1').run('fin');

model.selection.create('sel1', 'Explicit');
model.selection('sel1').model('comp1');
model.selection('sel1').label('Solid');
model.selection('sel1').set([1]);
model.selection.create('sel2', 'Explicit');
model.selection('sel2').model('comp1');
model.selection('sel2').label('Hot Channel');
model.selection('sel2').set([2]);
model.selection.create('sel3', 'Explicit');
model.selection('sel3').model('comp1');
model.selection('sel3').label('Cold Channel');
model.selection('sel3').set([3]);
model.selection.create('uni1', 'Union');
model.selection('uni1').model('comp1');
model.selection('uni1').label('Channels');
model.selection('uni1').set('input', {'sel2' 'sel3'});
model.selection.create('adj1', 'Adjacent');
model.selection('adj1').model('comp1');
model.selection('adj1').label('Channel Walls');
model.selection('adj1').set('input', {'sel1' 'uni1'});
model.selection('adj1').set('exterior', false);
model.selection('adj1').set('interior', true);

model.variable.create('var1');
model.variable('var1').model('comp1');
model.variable('var1').selection.geom('geom1', 3);
model.variable('var1').selection.named('sel2');
model.variable('var1').set('r', 'sqrt(x^2+(z-1e-4)^2)');
model.variable('var1').descr('r', 'Radius, hot channel');
model.variable.create('var2');
model.variable('var2').model('comp1');
model.variable('var2').selection.geom('geom1', 3);
model.variable('var2').selection.set([3]);
model.variable('var2').selection.named('sel3');
model.variable('var2').set('r', 'sqrt((x-1e-4)^2+(z-2e-4)^2)', 'Radius, hot channel');
model.variable('var2').descr('r', 'Radius, cold channel');

model.material.create('mat1', 'Common', 'comp1');
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
model.material.create('mat2', 'Common', 'comp1');
model.material('mat2').propertyGroup('def').func.create('eta', 'Piecewise');
model.material('mat2').propertyGroup('def').func.create('Cp', 'Piecewise');
model.material('mat2').propertyGroup('def').func.create('rho', 'Piecewise');
model.material('mat2').propertyGroup('def').func.create('k', 'Piecewise');
model.material('mat2').propertyGroup('def').func.create('cs', 'Interpolation');
model.material('mat2').propertyGroup('def').func.create('an1', 'Analytic');
model.material('mat2').propertyGroup('def').func.create('an2', 'Analytic');
model.material('mat2').propertyGroup('def').func.create('an3', 'Analytic');
model.material('mat2').label('Water, liquid');
model.material('mat2').set('family', 'water');
model.material('mat2').propertyGroup('def').func('eta').set('arg', 'T');
model.material('mat2').propertyGroup('def').func('eta').set('pieces', {'273.15' '413.15' '1.3799566804-0.021224019151*T^1+1.3604562827E-4*T^2-4.6454090319E-7*T^3+8.9042735735E-10*T^4-9.0790692686E-13*T^5+3.8457331488E-16*T^6'; '413.15' '553.75' '0.00401235783-2.10746715E-5*T^1+3.85772275E-8*T^2-2.39730284E-11*T^3'});
model.material('mat2').propertyGroup('def').func('eta').set('argunit', 'K');
model.material('mat2').propertyGroup('def').func('eta').set('fununit', 'Pa*s');
model.material('mat2').propertyGroup('def').func('Cp').set('arg', 'T');
model.material('mat2').propertyGroup('def').func('Cp').set('pieces', {'273.15' '553.75' '12010.1471-80.4072879*T^1+0.309866854*T^2-5.38186884E-4*T^3+3.62536437E-7*T^4'});
model.material('mat2').propertyGroup('def').func('Cp').set('argunit', 'K');
model.material('mat2').propertyGroup('def').func('Cp').set('fununit', 'J/(kg*K)');
model.material('mat2').propertyGroup('def').func('rho').set('arg', 'T');
model.material('mat2').propertyGroup('def').func('rho').set('smooth', 'contd1');
model.material('mat2').propertyGroup('def').func('rho').set('pieces', {'273.15' '293.15' '0.000063092789034*T^3-0.060367639882855*T^2+18.9229382407066*T-950.704055329848'; '293.15' '373.15' '0.000010335053319*T^3-0.013395065634452*T^2+4.969288832655160*T+432.257114008512'});
model.material('mat2').propertyGroup('def').func('rho').set('argunit', 'K');
model.material('mat2').propertyGroup('def').func('rho').set('fununit', 'kg/m^3');
model.material('mat2').propertyGroup('def').func('k').set('arg', 'T');
model.material('mat2').propertyGroup('def').func('k').set('pieces', {'273.15' '553.75' '-0.869083936+0.00894880345*T^1-1.58366345E-5*T^2+7.97543259E-9*T^3'});
model.material('mat2').propertyGroup('def').func('k').set('argunit', 'K');
model.material('mat2').propertyGroup('def').func('k').set('fununit', 'W/(m*K)');
model.material('mat2').propertyGroup('def').func('cs').set('table', {'273' '1403';  ...
'278' '1427';  ...
'283' '1447';  ...
'293' '1481';  ...
'303' '1507';  ...
'313' '1526';  ...
'323' '1541';  ...
'333' '1552';  ...
'343' '1555';  ...
'353' '1555';  ...
'363' '1550';  ...
'373' '1543'});
model.material('mat2').propertyGroup('def').func('cs').set('interp', 'piecewisecubic');
model.material('mat2').propertyGroup('def').func('cs').set('fununit', {'m/s'});
model.material('mat2').propertyGroup('def').func('cs').set('argunit', {'K'});
model.material('mat2').propertyGroup('def').func('an1').set('funcname', 'alpha_p');
model.material('mat2').propertyGroup('def').func('an1').set('expr', '-1/rho(T)*d(rho(T),T)');
model.material('mat2').propertyGroup('def').func('an1').set('args', {'T'});
model.material('mat2').propertyGroup('def').func('an1').set('fununit', '1/K');
model.material('mat2').propertyGroup('def').func('an1').set('argunit', {'K'});
model.material('mat2').propertyGroup('def').func('an1').set('plotfixedvalue', {'273.15'});
model.material('mat2').propertyGroup('def').func('an1').set('plotargs', {'T' '273.15' '373.15'});
model.material('mat2').propertyGroup('def').func('an2').set('funcname', 'gamma_w');
model.material('mat2').propertyGroup('def').func('an2').set('expr', '1+(T/Cp(T))*(alpha_p(T)*cs(T))^2');
model.material('mat2').propertyGroup('def').func('an2').set('args', {'T'});
model.material('mat2').propertyGroup('def').func('an2').set('fununit', '1');
model.material('mat2').propertyGroup('def').func('an2').set('argunit', {'K'});
model.material('mat2').propertyGroup('def').func('an2').set('plotfixedvalue', {'273.15'});
model.material('mat2').propertyGroup('def').func('an2').set('plotargs', {'T' '273.15' '373.15'});
model.material('mat2').propertyGroup('def').func('an3').set('funcname', 'muB');
model.material('mat2').propertyGroup('def').func('an3').set('expr', '2.79*eta(T)');
model.material('mat2').propertyGroup('def').func('an3').set('args', {'T'});
model.material('mat2').propertyGroup('def').func('an3').set('fununit', 'Pa*s');
model.material('mat2').propertyGroup('def').func('an3').set('argunit', {'K'});
model.material('mat2').propertyGroup('def').func('an3').set('plotfixedvalue', {'273.15'});
model.material('mat2').propertyGroup('def').func('an3').set('plotargs', {'T' '273.15' '553.75'});
model.material('mat2').propertyGroup('def').set('thermalexpansioncoefficient', '');
model.material('mat2').propertyGroup('def').set('bulkviscosity', '');
model.material('mat2').propertyGroup('def').set('thermalexpansioncoefficient', {'alpha_p(T)' '0' '0' '0' 'alpha_p(T)' '0' '0' '0' 'alpha_p(T)'});
model.material('mat2').propertyGroup('def').set('bulkviscosity', 'muB(T)');
model.material('mat2').propertyGroup('def').set('dynamicviscosity', 'eta(T)');
model.material('mat2').propertyGroup('def').set('ratioofspecificheat', 'gamma_w(T)');
model.material('mat2').propertyGroup('def').set('electricconductivity', {'5.5e-6[S/m]' '0' '0' '0' '5.5e-6[S/m]' '0' '0' '0' '5.5e-6[S/m]'});
model.material('mat2').propertyGroup('def').set('heatcapacity', 'Cp(T)');
model.material('mat2').propertyGroup('def').set('density', 'rho(T)');
model.material('mat2').propertyGroup('def').set('thermalconductivity', {'k(T)' '0' '0' '0' 'k(T)' '0' '0' '0' 'k(T)'});
model.material('mat2').propertyGroup('def').set('soundspeed', 'cs(T)');
model.material('mat2').propertyGroup('def').addInput('temperature');
model.material('mat1').selection.named('sel1');
model.material('mat2').selection.named('uni1');

model.physics('ht').feature('fluid1').selection.named('sel2');
model.physics('ht').feature('fluid1').set('u', {'0' 'v_max*(1-(r/R)^2)' '0'});
model.physics('ht').feature('fluid1').set('fluidType', 'gasLiquid');
model.physics('ht').feature('fluid1').set('gamma_not_IG_mat', 'userdef');
model.physics('ht').create('fluid2', 'FluidHeatTransferModel', 3);
model.physics('ht').feature('fluid2').selection.named('sel3');
model.physics('ht').feature('fluid2').set('u', {'0' '-v_max*(1-(r/R)^2)' '0'});
model.physics('ht').feature('fluid2').set('fluidType', 'gasLiquid');
model.physics('ht').feature('fluid2').set('gamma_not_IG_mat', 'userdef');
model.physics('ht').create('ifl1', 'Inflow', 2);
model.physics('ht').feature('ifl1').selection.set([5]);
model.physics('ht').feature('ifl1').set('Tustr', 'T_hot');
model.physics('ht').create('ifl2', 'Inflow', 2);
model.physics('ht').feature('ifl2').selection.set([15]);
model.physics('ht').feature('ifl2').set('Tustr', 'T_cold');
model.physics('ht').create('ofl1', 'ConvectiveOutflow', 2);
model.physics('ht').feature('ofl1').selection.set([11 14]);

model.mesh('mesh1').create('ftri1', 'FreeTri');
model.mesh('mesh1').feature('ftri1').selection.named('adj1');
model.mesh('mesh1').feature('ftri1').create('size1', 'Size');
model.mesh('mesh1').feature('ftri1').feature('size1').set('custom', true);
model.mesh('mesh1').feature('ftri1').feature('size1').set('hmaxactive', true);
model.mesh('mesh1').feature('ftri1').feature('size1').set('hmax', '10[um]');
model.mesh('mesh1').create('ftet1', 'FreeTet');
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
model.result.create('pg2', 'PlotGroup3D');
model.result('pg2').label('Isothermal Contours (ht)');
model.result('pg2').set('data', 'dset1');
model.result('pg2').set('defaultPlotID', 'ht/HT_PhysicsInterfaces/icom8/pdef1/pcond3/pcond3/pg3');
model.result('pg2').feature.create('iso1', 'Isosurface');
model.result('pg2').feature('iso1').set('solutionparams', 'parent');
model.result('pg2').feature('iso1').set('number', 10);
model.result('pg2').feature('iso1').set('colortable', 'HeatCameraLight');
model.result('pg2').feature('iso1').set('smooth', 'internal');
model.result('pg2').feature('iso1').set('showsolutionparams', 'on');
model.result('pg2').feature('iso1').set('data', 'parent');
model.result('pg2').label('Isothermal Contours (ht)');
model.result('pg2').run;
model.result('pg2').label('Temperature Isosurfaces and Conductive Heat Flux Streamlines');
model.result('pg2').run;
model.result('pg2').feature('iso1').set('levelmethod', 'levels');
model.result('pg2').feature('iso1').set('levels', 'range(301,2,329)');
model.result('pg2').run;
model.result('pg2').create('str1', 'Streamline');
model.result('pg2').feature('str1').set('posmethod', 'start');
model.result('pg2').feature('str1').set('linetype', 'tube');
model.result('pg2').feature('str1').set('tuberadiusscaleactive', true);
model.result('pg2').feature('str1').set('pointtype', 'arrow');
model.result('pg2').run;
model.result('pg2').run;

model.title('Isothermal MEMS Heat Exchanger');

model.description('This example illustrates the modeling of convective and conductive heat transfer in a unit cell of a MEMS heat exchanger, commonly found in lab-on-chip devices. The example uses the Heat Transfer interface, applying an analytical velocity profile to describe the laminar flow of water through the tubes.');

model.mesh.clearMeshes;

model.sol('sol1').clearSolutionData;

model.label('heat_exchanger_iso.mph');

model.modelNode.label('Components');

out = model;
