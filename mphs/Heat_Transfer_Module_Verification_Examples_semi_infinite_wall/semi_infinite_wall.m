function out = model
%
% semi_infinite_wall.m
%
% Model exported on May 26 2025, 21:29 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/Heat_Transfer_Module/Verification_Examples');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 1);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.physics.create('ht', 'HeatTransferInBuildingMaterials', 'geom1');
model.physics('ht').model('comp1');
model.physics.create('mt', 'MoistureTransportInBuildingMaterials', 'geom1');
model.physics('mt').model('comp1');

model.multiphysics.create('ham1', 'HeatAndMoisture', 'geom1', 1);
model.multiphysics('ham1').set('Heat_physics', 'ht');
model.multiphysics('ham1').set('Moist_physics', 'mt');
model.multiphysics('ham1').selection.all;

model.study.create('std1');
model.study('std1').create('time', 'Transient');
model.study('std1').feature('time').setSolveFor('/physics/ht', true);
model.study('std1').feature('time').setSolveFor('/physics/mt', true);
model.study('std1').feature('time').setSolveFor('/multiphysics/ham1', true);

model.param.set('T_e', '30[degC]');
model.param.descr('T_e', 'Exterior temperature');
model.param.set('phi_e', '0.95');
model.param.descr('phi_e', 'Exterior relative humidity');
model.param.set('T_i', '20[degC]');
model.param.descr('T_i', 'Interior temperature');
model.param.set('phi_i', '0.5');
model.param.descr('phi_i', 'Interior relative humidity');

model.geom('geom1').create('i1', 'Interval');
model.geom('geom1').feature('i1').setIndex('coord', 20, 1);
model.geom('geom1').run;

model.material.create('mat1', 'Common', 'comp1');
model.material('mat1').label('Material - Norm 15026');
model.material('mat1').propertyGroup('def').addInput('relativehumidity');
model.material('mat1').propertyGroup('def').func.create('an1', 'Analytic');
model.material('mat1').propertyGroup('def').func('an1').label('Analytic: wc');
model.material('mat1').propertyGroup('def').func('an1').set('funcname', 'wc');
model.material('mat1').propertyGroup('def').func('an1').set('expr', '146/(1+(-8e-8*462*293.15*1000*log(phi))^1.6)^0.375');
model.material('mat1').propertyGroup('def').func('an1').set('args', 'phi');
model.material('mat1').propertyGroup('def').func.create('an2', 'Analytic');
model.material('mat1').propertyGroup('def').func('an2').label('Analytic: k');
model.material('mat1').propertyGroup('def').func('an2').set('funcname', 'k');
model.material('mat1').propertyGroup('def').func('an2').set('expr', '1.5+15.8e-3*w');
model.material('mat1').propertyGroup('def').func('an2').set('args', 'w');
model.material('mat1').propertyGroup('def').func('an2').setIndex('plotargs', 150, 0, 2);
model.material('mat1').propertyGroup('def').func.create('an3', 'Analytic');
model.material('mat1').propertyGroup('def').func('an3').label('Analytic: s');
model.material('mat1').propertyGroup('def').func('an3').set('funcname', 's');
model.material('mat1').propertyGroup('def').func('an3').set('expr', '0.125e8*((146/w)^(1/0.375)-1)^0.625');
model.material('mat1').propertyGroup('def').func('an3').set('args', 'w');
model.material('mat1').propertyGroup('def').func('an3').setIndex('plotargs', 150, 0, 2);
model.material('mat1').propertyGroup('def').func.create('an4', 'Analytic');
model.material('mat1').propertyGroup('def').func('an4').label('Analytic: K');
model.material('mat1').propertyGroup('def').func('an4').set('funcname', 'K');
model.material('mat1').propertyGroup('def').func('an4').set('expr', 'exp(-39.2619+0.0704*(w-146/2)-1.7420e-4*(w-146/2)^2-2.7953e-6*(w-146/2)^3-1.1566e-7*(w-146/2)^4+2.5969e-9*(w-146/2)^5)');
model.material('mat1').propertyGroup('def').func('an4').set('args', 'w');
model.material('mat1').propertyGroup('def').func('an4').setIndex('plotargs', 150, 0, 2);
model.material('mat1').propertyGroup('def').func.create('an5', 'Analytic');
model.material('mat1').propertyGroup('def').func('an5').label('Analytic: Dw');
model.material('mat1').propertyGroup('def').func('an5').set('funcname', 'Dw');
model.material('mat1').propertyGroup('def').func('an5').set('expr', '-d(s(w),w)*K(w)');
model.material('mat1').propertyGroup('def').func('an5').set('args', 'w');
model.material('mat1').propertyGroup('def').func('an5').setIndex('plotargs', 150, 0, 2);
model.material('mat1').propertyGroup('def').func.create('an6', 'Analytic');
model.material('mat1').propertyGroup('def').func('an6').label('Analytic: delta_p');
model.material('mat1').propertyGroup('def').func('an6').set('funcname', 'delta_p');
model.material('mat1').propertyGroup('def').func('an6').set('expr', '(0.01801528/R_const/293.15*26.1e-6/200*(1-w/146)/((1-0.497)*(1-w/146)^2+0.497))');
model.material('mat1').propertyGroup('def').func('an6').set('args', 'w');
model.material('mat1').propertyGroup('def').func('an6').setIndex('plotargs', 150, 0, 2);
model.material('mat1').propertyGroup('def').set('thermalconductivity', {'k(wc(phi))'});
model.material('mat1').propertyGroup('def').set('density', {'2145.88'});
model.material('mat1').propertyGroup('def').set('heatcapacity', {'850'});
model.material('mat1').propertyGroup('def').set('diffusion', {'Dw(wc(phi))'});
model.material('mat1').propertyGroup('def').set('watercontent', {'wc(phi)'});
model.material('mat1').propertyGroup('def').set('vaporpermeability', {'delta_p(wc(phi))'});

model.func.create('rm1', 'Ramp');
model.func('rm1').model('comp1');
model.func('rm1').set('location', 100);
model.func('rm1').set('slope', '1e-3');
model.func('rm1').set('cutoffactive', true);
model.func('rm1').set('smoothzonelocactive', true);
model.func('rm1').set('smoothzonecutoffactive', true);
model.func('rm1').set('smoothzoneloc', 100);
model.func('rm1').set('smoothzonecutoff', 100);

model.physics('ht').feature('init1').set('Tinit', 'T_i');
model.physics('ht').create('temp1', 'TemperatureBoundary', 0);
model.physics('ht').feature('temp1').selection.set([1]);
model.physics('ht').feature('temp1').set('T0', 'T_i+(T_e-T_i)*rm1(t[1/s])');
model.physics('ht').create('temp2', 'TemperatureBoundary', 0);
model.physics('ht').feature('temp2').selection.set([2]);
model.physics('ht').feature('temp2').set('T0', 'T_i');
model.physics('mt').feature('init1').set('phi_init', 'phi_i');
model.physics('mt').create('mc1', 'MoistureContent', 0);
model.physics('mt').feature('mc1').selection.set([1]);
model.physics('mt').feature('mc1').set('T0', 'T_i+(T_e-T_i)*rm1(t[1/s])');
model.physics('mt').feature('mc1').set('phi0', 'phi_i+(phi_e-phi_i)*rm1(t[1/s])');
model.physics('mt').create('mc2', 'MoistureContent', 0);
model.physics('mt').feature('mc2').selection.set([2]);
model.physics('mt').feature('mc2').set('T0', 'T_i');
model.physics('mt').feature('mc2').set('phi0', 'phi_i');

model.mesh('mesh1').create('edg1', 'Edge');
model.mesh('mesh1').feature('edg1').create('dis1', 'Distribution');
model.mesh('mesh1').feature('edg1').feature('dis1').set('type', 'predefined');
model.mesh('mesh1').feature('edg1').feature('dis1').set('elemcount', 1000);
model.mesh('mesh1').feature('edg1').feature('dis1').set('elemratio', 25);
model.mesh('mesh1').run;

model.study('std1').feature('time').set('tunit', 'd');
model.study('std1').feature('time').set('tlist', 'range(0,1,365)');
model.study('std1').feature('time').set('usertol', true);
model.study('std1').feature('time').set('rtol', '1e-3');

model.sol.create('sol1');
model.sol('sol1').study('std1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'time');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').feature('comp1_mt_phi').set('scalemethod', 'manual');
model.sol('sol1').feature('v1').set('control', 'time');
model.sol('sol1').create('t1', 'Time');
model.sol('sol1').feature('t1').set('tlist', 'range(0,1,365)');
model.sol('sol1').feature('t1').set('plot', 'off');
model.sol('sol1').feature('t1').set('plotgroup', 'Default');
model.sol('sol1').feature('t1').set('plotfreq', 'tout');
model.sol('sol1').feature('t1').set('probesel', 'all');
model.sol('sol1').feature('t1').set('probes', {});
model.sol('sol1').feature('t1').set('probefreq', 'tsteps');
model.sol('sol1').feature('t1').set('atolglobalvaluemethod', 'factor');
model.sol('sol1').feature('t1').set('atolmethod', {'comp1_mt_phi' 'global' 'comp1_T' 'global'});
model.sol('sol1').feature('t1').set('atol', {'comp1_mt_phi' '1e-3' 'comp1_T' '1e-3'});
model.sol('sol1').feature('t1').set('atolvaluemethod', {'comp1_mt_phi' 'factor' 'comp1_T' 'factor'});
model.sol('sol1').feature('t1').set('reacf', true);
model.sol('sol1').feature('t1').set('storeudot', true);
model.sol('sol1').feature('t1').set('endtimeinterpolation', true);
model.sol('sol1').feature('t1').set('maxorder', 2);
model.sol('sol1').feature('t1').set('control', 'time');
model.sol('sol1').feature('t1').feature('aDef').set('cachepattern', true);
model.sol('sol1').feature('t1').create('seDef', 'Segregated');
model.sol('sol1').feature('t1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('t1').feature('fc1').set('jtech', 'once');
model.sol('sol1').feature('t1').feature('fc1').set('damp', 0.7);
model.sol('sol1').feature('t1').feature('fc1').set('stabacc', 'aacc');
model.sol('sol1').feature('t1').feature('fc1').set('aaccdim', 5);
model.sol('sol1').feature('t1').feature('fc1').set('aaccmix', 0.9);
model.sol('sol1').feature('t1').feature('fc1').set('aaccdelay', 1);
model.sol('sol1').feature('t1').feature('fc1').set('dtech', 'const');
model.sol('sol1').feature('t1').feature('fc1').set('ntolfact', 0.01);
model.sol('sol1').feature('t1').create('d1', 'Direct');
model.sol('sol1').feature('t1').feature('d1').set('linsolver', 'pardiso');
model.sol('sol1').feature('t1').feature('d1').set('pivotperturb', 1.0E-13);
model.sol('sol1').feature('t1').feature('d1').label('Direct, heat and moisture variables (ham1) (Merged)');
model.sol('sol1').feature('t1').create('i1', 'Iterative');
model.sol('sol1').feature('t1').feature('i1').set('linsolver', 'gmres');
model.sol('sol1').feature('t1').feature('i1').set('prefuntype', 'left');
model.sol('sol1').feature('t1').feature('i1').set('itrestart', 50);
model.sol('sol1').feature('t1').feature('i1').set('rhob', 20);
model.sol('sol1').feature('t1').feature('i1').set('maxlinit', 10000);
model.sol('sol1').feature('t1').feature('i1').set('nlinnormuse', 'on');
model.sol('sol1').feature('t1').feature('i1').label('AMG, heat and moisture variables (ham1)');
model.sol('sol1').feature('t1').feature('i1').create('mg1', 'Multigrid');
model.sol('sol1').feature('t1').feature('i1').feature('mg1').set('prefun', 'saamg');
model.sol('sol1').feature('t1').feature('i1').feature('mg1').set('mgcycle', 'v');
model.sol('sol1').feature('t1').feature('i1').feature('mg1').set('maxcoarsedof', 50000);
model.sol('sol1').feature('t1').feature('i1').feature('mg1').set('strconn', 0.01);
model.sol('sol1').feature('t1').feature('i1').feature('mg1').set('nullspace', 'constant');
model.sol('sol1').feature('t1').feature('i1').feature('mg1').set('usesmooth', false);
model.sol('sol1').feature('t1').feature('i1').feature('mg1').set('saamgcompwise', true);
model.sol('sol1').feature('t1').feature('i1').feature('mg1').set('loweramg', true);
model.sol('sol1').feature('t1').feature('i1').feature('mg1').set('compactaggregation', false);
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('pr').create('so1', 'SOR');
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('pr').feature('so1').set('iter', 2);
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('pr').feature('so1').set('relax', 0.9);
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('po').create('so1', 'SOR');
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('po').feature('so1').set('iter', 2);
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('po').feature('so1').set('relax', 0.9);
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('cs').create('d1', 'Direct');
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('cs').feature('d1').set('linsolver', 'pardiso');
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('cs').feature('d1').set('pivotperturb', 1.0E-13);
model.sol('sol1').feature('t1').feature('fc1').set('linsolver', 'd1');
model.sol('sol1').feature('t1').feature('fc1').set('jtech', 'once');
model.sol('sol1').feature('t1').feature('fc1').set('damp', 0.7);
model.sol('sol1').feature('t1').feature('fc1').set('stabacc', 'aacc');
model.sol('sol1').feature('t1').feature('fc1').set('aaccdim', 5);
model.sol('sol1').feature('t1').feature('fc1').set('aaccmix', 0.9);
model.sol('sol1').feature('t1').feature('fc1').set('aaccdelay', 1);
model.sol('sol1').feature('t1').feature('fc1').set('dtech', 'const');
model.sol('sol1').feature('t1').feature('fc1').set('ntolfact', 0.01);
model.sol('sol1').feature('t1').feature.remove('fcDef');
model.sol('sol1').feature('t1').feature.remove('seDef');
model.sol('sol1').attach('std1');
model.sol('sol1').runAll;

model.result.create('pg1', 'PlotGroup1D');
model.result('pg1').label('Temperature (ht)');
model.result('pg1').set('showlooplevelinput', {'off' 'off' 'off'});
model.result('pg1').set('data', 'dset1');
model.result('pg1').set('defaultPlotID', 'ht/HT_PhysicsInterfaces/icom8/pdef1/pcond1/pg1');
model.result('pg1').feature.create('lngr1', 'LineGraph');
model.result('pg1').feature('lngr1').set('xdata', 'expr');
model.result('pg1').feature('lngr1').set('xdataexpr', 'x');
model.result('pg1').feature('lngr1').set('data', 'parent');
model.result('pg1').feature('lngr1').selection.geom('geom1', 1);
model.result('pg1').feature('lngr1').selection.set([1]);
model.result.create('pg2', 'PlotGroup1D');
model.result('pg2').label('Relative Humidity (mt)');
model.result('pg2').set('showlooplevelinput', {'off' 'off' 'off'});
model.result('pg2').set('data', 'dset1');
model.result('pg2').set('defaultPlotID', 'MoistureTransportFactory/icom5/pdef1/pcond4/pg2');
model.result('pg2').feature.create('lngr1', 'LineGraph');
model.result('pg2').feature('lngr1').set('showsolutionparams', 'on');
model.result('pg2').feature('lngr1').set('solutionparams', 'parent');
model.result('pg2').feature('lngr1').set('expr', 'mt.phi');
model.result('pg2').feature('lngr1').set('xdata', 'expr');
model.result('pg2').feature('lngr1').set('xdataexpr', 'x');
model.result('pg2').feature('lngr1').set('smooth', 'internal');
model.result('pg2').feature('lngr1').set('showsolutionparams', 'on');
model.result('pg2').feature('lngr1').set('data', 'parent');
model.result('pg2').feature('lngr1').selection.geom('geom1', 1);
model.result('pg2').feature('lngr1').selection.set([1]);
model.result('pg1').run;
model.result.table.create('tbl1', 'Table');
model.result.table('tbl1').importData('semi_infinite_wall_temperature.txt');
model.result.table.create('tbl2', 'Table');
model.result.table('tbl2').importData('semi_infinite_wall_moisture_storage_function.txt');
model.result('pg1').run;
model.result('pg1').set('axislimits', true);
model.result('pg1').set('xmin', 0);
model.result('pg1').set('xmax', 6);
model.result('pg1').set('ymin', 19);
model.result('pg1').set('ymax', 30);
model.result('pg1').setIndex('looplevelinput', 'manual', 0);
model.result('pg1').setIndex('looplevel', [8 31 366], 0);
model.result('pg1').run;
model.result('pg1').feature('lngr1').set('unit', 'degC');
model.result('pg1').feature('lngr1').set('legend', true);
model.result('pg1').run;
model.result('pg1').run;
model.result('pg1').create('tblp1', 'Table');
model.result('pg1').feature('tblp1').set('markerpos', 'datapoints');
model.result('pg1').feature('tblp1').set('linewidth', 'preference');
model.result('pg1').feature('tblp1').set('linestyle', 'none');
model.result('pg1').feature('tblp1').set('linecolor', 'fromtheme');
model.result('pg1').feature('tblp1').set('linemarker', 'asterisk');
model.result('pg1').run;
model.result('pg2').run;
model.result('pg2').label('Moisture storage function');
model.result('pg2').set('axislimits', true);
model.result('pg2').set('xmin', 0);
model.result('pg2').set('xmax', 0.11);
model.result('pg2').set('ymin', 25);
model.result('pg2').set('ymax', 130);
model.result('pg2').setIndex('looplevelinput', 'manual', 0);
model.result('pg2').setIndex('looplevel', [8 31 366], 0);
model.result('pg2').run;
model.result('pg2').feature('lngr1').selection.all;
model.result('pg2').feature('lngr1').set('expr', 'mt.wc');
model.result('pg2').feature('lngr1').set('legend', true);
model.result('pg2').run;
model.result('pg2').run;
model.result('pg2').create('tblp1', 'Table');
model.result('pg2').feature('tblp1').set('markerpos', 'datapoints');
model.result('pg2').feature('tblp1').set('linewidth', 'preference');
model.result('pg2').feature('tblp1').set('table', 'tbl2');
model.result('pg2').feature('tblp1').set('linestyle', 'none');
model.result('pg2').feature('tblp1').set('linecolor', 'fromtheme');
model.result('pg2').feature('tblp1').set('linemarker', 'asterisk');
model.result('pg2').run;

model.title('Heat and Moisture Transport in a Semi-Infinite Wall');

model.description('This tutorial shows how to simulate coupled heat and moisture transport in a building component. The 1D model is a benchmark test defined in Norm EN 15026 for the validation of a software for the assessment of moisture transfer by numerical simulation. You can verify that the numerical results obtained with COMSOL Multiphysics are within the validity ranges specified in the norm.');

model.mesh.clearMeshes;

model.sol('sol1').clearSolutionData;

model.label('semi_infinite_wall.mph');

model.modelNode.label('Components');

out = model;
