function out = model
%
% laser_heating_wafer.m
%
% Model exported on May 26 2025, 21:27 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/COMSOL_Multiphysics/Heat_Transfer');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 3);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.physics.create('ht', 'HeatTransfer', 'geom1');
model.physics('ht').model('comp1');

model.study.create('std1');
model.study('std1').create('time', 'Transient');
model.study('std1').feature('time').setSolveFor('/physics/ht', true);

model.param.set('r_wafer', '1[in]');
model.param.descr('r_wafer', 'Wafer radius');
model.param.set('thickness', '275[um]');
model.param.descr('thickness', 'Wafer thickness');
model.param.set('v_rotation', '10[rpm]');
model.param.descr('v_rotation', 'Rotational speed');
model.param.set('period', '20[s]');
model.param.descr('period', 'Time for laser to move back and forth');
model.param.set('r_spot', '2[mm]');
model.param.descr('r_spot', 'Laser beam radius');
model.param.set('emissivity', '0.8');
model.param.descr('emissivity', 'Surface emissivity of wafer');
model.param.set('p_laser', '10[W]');
model.param.descr('p_laser', 'Laser power');

model.geom('geom1').create('cyl1', 'Cylinder');
model.geom('geom1').feature('cyl1').set('r', 'r_wafer');
model.geom('geom1').feature('cyl1').set('h', 'thickness');
model.geom('geom1').run('cyl1');
model.geom('geom1').create('blk1', 'Block');
model.geom('geom1').feature('blk1').set('size', {'2*r_wafer' '2*r_wafer' '1'});
model.geom('geom1').feature('blk1').setIndex('size', 'thickness', 2);
model.geom('geom1').feature('blk1').set('pos', {'-0.95*r_wafer' '0' '0'});
model.geom('geom1').feature('blk1').setIndex('pos', '-r_wafer', 1);
model.geom('geom1').run('blk1');
model.geom('geom1').create('int1', 'Intersection');
model.geom('geom1').feature('int1').selection('input').set({'blk1' 'cyl1'});
model.geom('geom1').runPre('fin');

model.variable.create('var1');
model.variable('var1').model('comp1');

model.geom('geom1').run;

model.variable('var1').set('x_focus', 'r_wafer*Triangle(t/period)');
model.variable('var1').descr('x_focus', 'x-location of laser focal point');
model.variable('var1').set('y_focus', '0[m]');
model.variable('var1').descr('y_focus', 'y_location of laser focal point');
model.variable('var1').set('r_focus', 'sqrt((x-x_focus)^2+(y-y_focus)^2)');
model.variable('var1').descr('r_focus', 'distance from focal point');
model.variable('var1').set('Flux', '((2*p_laser)/(pi*r_spot^2))*exp(-(2*r_focus^2)/r_spot^2)');
model.variable('var1').descr('Flux', 'laser heat flux, Gaussian profile');

model.func.create('wv1', 'Wave');
model.func('wv1').model('comp1');
model.func('wv1').set('funcname', 'Triangle');
model.func('wv1').set('type', 'triangle');
model.func('wv1').set('smoothactive', false);
model.func('wv1').set('period', 1);
model.func('wv1').set('phase', 'pi/2');

model.probe.create('dom1', 'Domain');
model.probe('dom1').model('comp1');
model.probe('dom1').set('intsurface', true);
model.probe('dom1').set('intvolume', true);
model.probe('dom1').label('Maximum');
model.probe('dom1').set('probename', 'T_max');
model.probe('dom1').set('type', 'maximum');
model.probe.create('dom2', 'Domain');
model.probe('dom2').model('comp1');
model.probe('dom2').set('intsurface', true);
model.probe('dom2').set('intvolume', true);
model.probe('dom2').label('Average');
model.probe('dom2').set('probename', 'T_average');
model.probe.create('dom3', 'Domain');
model.probe('dom3').model('comp1');
model.probe('dom3').set('intsurface', true);
model.probe('dom3').set('intvolume', true);
model.probe('dom3').label('Minimum');
model.probe('dom3').set('probename', 'T_min');
model.probe('dom3').set('type', 'minimum');
model.probe.create('var1', 'GlobalVariable');
model.probe('var1').model('comp1');
model.probe('var1').set('probename', 'T_diff');
model.probe('var1').set('expr', 'T_max-T_min');

model.common.create('rot1', 'RotatingDomain', 'comp1');
model.common('rot1').selection.all;
model.common('rot1').set('rotationType', 'rotationalVelocity');
model.common('rot1').set('rotationalVelocityExpression', 'constantRevolutionsPerTime');
model.common('rot1').set('revolutionsPerTime', 'v_rotation');

model.physics('ht').create('hf1', 'HeatFluxBoundary', 2);
model.physics('ht').feature('hf1').selection.set([4]);
model.physics('ht').feature('hf1').set('q0_input', 'emissivity*Flux');
model.physics('ht').create('sar1', 'SurfaceToAmbientRadiation', 2);
model.physics('ht').feature('sar1').selection.set([4]);
model.physics('ht').feature('sar1').set('epsilon_rad_mat', 'userdef');
model.physics('ht').feature('sar1').set('epsilon_rad', 'emissivity');

model.material.create('mat1', 'Common', 'comp1');
model.material('mat1').propertyGroup.create('Enu', 'Young''s modulus and Poisson''s ratio');
model.material('mat1').propertyGroup.create('RefractiveIndex', 'Refractive index');
model.material('mat1').label('Silicon');
model.material('mat1').set('family', 'custom');
model.material('mat1').set('customspecular', [0.7843137254901961 1 1]);
model.material('mat1').set('customdiffuse', [0.6666666666666666 0.6666666666666666 0.7058823529411765]);
model.material('mat1').set('customambient', [0.6666666666666666 0.6666666666666666 0.7058823529411765]);
model.material('mat1').set('noise', true);
model.material('mat1').set('fresnel', 0.7);
model.material('mat1').set('metallic', 0);
model.material('mat1').set('pearl', 0);
model.material('mat1').set('diffusewrap', 0);
model.material('mat1').set('clearcoat', 0);
model.material('mat1').set('reflectance', 0);
model.material('mat1').propertyGroup('def').set('relpermeability', {'1' '0' '0' '0' '1' '0' '0' '0' '1'});
model.material('mat1').propertyGroup('def').set('electricconductivity', {'1e-12[S/m]' '0' '0' '0' '1e-12[S/m]' '0' '0' '0' '1e-12[S/m]'});
model.material('mat1').propertyGroup('def').set('thermalexpansioncoefficient', {'2.6e-6[1/K]' '0' '0' '0' '2.6e-6[1/K]' '0' '0' '0' '2.6e-6[1/K]'});
model.material('mat1').propertyGroup('def').set('heatcapacity', '700[J/(kg*K)]');
model.material('mat1').propertyGroup('def').set('relpermittivity', {'11.7' '0' '0' '0' '11.7' '0' '0' '0' '11.7'});
model.material('mat1').propertyGroup('def').set('density', '2329[kg/m^3]');
model.material('mat1').propertyGroup('def').set('thermalconductivity', {'130[W/(m*K)]' '0' '0' '0' '130[W/(m*K)]' '0' '0' '0' '130[W/(m*K)]'});
model.material('mat1').propertyGroup('Enu').set('E', '170[GPa]');
model.material('mat1').propertyGroup('Enu').set('nu', '0.28');
model.material('mat1').propertyGroup('RefractiveIndex').set('n', {'3.48' '0' '0' '0' '3.48' '0' '0' '0' '3.48'});

model.mesh('mesh1').create('swe1', 'Sweep');
model.mesh('mesh1').feature('swe1').set('facemethod', 'tri');
model.mesh('mesh1').feature('swe1').create('dis1', 'Distribution');
model.mesh('mesh1').feature('swe1').feature('dis1').set('numelem', 1);
model.mesh('mesh1').feature('size').set('hauto', 4);
model.mesh('mesh1').run;

model.study('std1').feature('time').set('tlist', 'range(0,1,60)');
model.study('std1').feature('time').set('usertol', true);
model.study('std1').feature('time').set('rtol', '1e-3');

model.sol.create('sol1');
model.sol('sol1').study('std1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'time');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').set('control', 'time');
model.sol('sol1').create('t1', 'Time');
model.sol('sol1').feature('t1').set('tlist', 'range(0,1,60)');
model.sol('sol1').feature('t1').set('plot', 'off');
model.sol('sol1').feature('t1').set('plotgroup', 'Default');
model.sol('sol1').feature('t1').set('plotfreq', 'tout');
model.sol('sol1').feature('t1').set('probesel', 'all');
model.sol('sol1').feature('t1').set('probes', {'dom1' 'dom2' 'dom3' 'var1'});
model.sol('sol1').feature('t1').set('probefreq', 'tsteps');
model.sol('sol1').feature('t1').set('atolglobalvaluemethod', 'factor');
model.sol('sol1').feature('t1').set('atolmethod', {'comp1_T' 'global'});
model.sol('sol1').feature('t1').set('atol', {'comp1_T' '1e-3'});
model.sol('sol1').feature('t1').set('atolvaluemethod', {'comp1_T' 'factor'});
model.sol('sol1').feature('t1').set('reacf', true);
model.sol('sol1').feature('t1').set('storeudot', true);
model.sol('sol1').feature('t1').set('endtimeinterpolation', true);
model.sol('sol1').feature('t1').set('estrat', 'exclude');
model.sol('sol1').feature('t1').set('maxorder', 2);
model.sol('sol1').feature('t1').set('control', 'time');
model.sol('sol1').feature('t1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('t1').feature('fc1').set('jtech', 'onevery');
model.sol('sol1').feature('t1').create('d1', 'Direct');
model.sol('sol1').feature('t1').feature('d1').set('linsolver', 'pardiso');
model.sol('sol1').feature('t1').feature('d1').set('pivotperturb', 1.0E-13);
model.sol('sol1').feature('t1').feature('d1').label('Direct, heat transfer variables (ht)');
model.sol('sol1').feature('t1').create('i1', 'Iterative');
model.sol('sol1').feature('t1').feature('i1').set('linsolver', 'gmres');
model.sol('sol1').feature('t1').feature('i1').set('prefuntype', 'left');
model.sol('sol1').feature('t1').feature('i1').set('itrestart', 50);
model.sol('sol1').feature('t1').feature('i1').set('rhob', 20);
model.sol('sol1').feature('t1').feature('i1').set('maxlinit', 10000);
model.sol('sol1').feature('t1').feature('i1').set('nlinnormuse', 'on');
model.sol('sol1').feature('t1').feature('i1').label('AMG, heat transfer variables (ht)');
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
model.sol('sol1').feature('t1').feature('fc1').set('jtech', 'onevery');
model.sol('sol1').feature('t1').feature.remove('fcDef');
model.sol('sol1').attach('std1');

model.probe('dom1').genResult('none');
model.probe('dom2').genResult('none');
model.probe('dom3').genResult('none');
model.probe('var1').genResult('none');

model.sol('sol1').runAll;

model.result.create('pg2', 'PlotGroup3D');
model.result('pg2').label('Temperature (ht)');
model.result('pg2').set('data', 'dset1');
model.result('pg2').setIndex('looplevel', 61, 0);
model.result('pg2').set('defaultPlotID', 'ht/HT_PhysicsInterfaces/icom8/pdef1/pcond3/pcond3/pg1');
model.result('pg2').feature.create('vol1', 'Volume');
model.result('pg2').feature('vol1').set('showsolutionparams', 'on');
model.result('pg2').feature('vol1').set('solutionparams', 'parent');
model.result('pg2').feature('vol1').set('colortable', 'HeatCameraLight');
model.result('pg2').feature('vol1').set('smooth', 'internal');
model.result('pg2').feature('vol1').set('showsolutionparams', 'on');
model.result('pg2').feature('vol1').set('data', 'parent');
model.result('pg2').run;
model.result('pg1').set('window', 'window2');
model.result('pg1').set('windowtitle', 'Probe Plot 2');
model.result('pg1').run;
model.result('pg1').label('Probe Temperature in the Domain');
model.result('pg1').set('titletype', 'manual');
model.result('pg1').set('title', 'Temperature in the domain over time');
model.result('pg1').set('ylabelactive', true);
model.result('pg1').set('ylabel', 'Temperature (K)');
model.result('pg1').set('legendpos', 'upperleft');
model.result('pg1').set('window', 'window2');
model.result('pg1').set('windowtitle', 'Probe Plot 2');
model.result('pg1').run;
model.result('pg1').feature('tblp1').set('plotcolumns', [2 3 4]);
model.result('pg1').set('window', 'window2');
model.result('pg1').set('windowtitle', 'Probe Plot 2');
model.result('pg1').run;
model.result('pg2').run;
model.result('pg2').set('frametype', 'spatial');
model.result('pg2').run;
model.result.create('pg3', 'PlotGroup3D');
model.result('pg3').label('Isothermal Contours (ht)');
model.result('pg3').set('data', 'dset1');
model.result('pg3').setIndex('looplevel', 61, 0);
model.result('pg3').set('defaultPlotID', 'ht/HT_PhysicsInterfaces/icom8/pdef1/pcond3/pcond3/pg3');
model.result('pg3').feature.create('iso1', 'Isosurface');
model.result('pg3').feature('iso1').set('solutionparams', 'parent');
model.result('pg3').feature('iso1').set('number', 10);
model.result('pg3').feature('iso1').set('colortable', 'HeatCameraLight');
model.result('pg3').feature('iso1').set('smooth', 'internal');
model.result('pg3').feature('iso1').set('showsolutionparams', 'on');
model.result('pg3').feature('iso1').set('data', 'parent');
model.result('pg3').label('Isothermal Contours (ht)');
model.result('pg3').run;
model.result.create('pg4', 'PlotGroup1D');
model.result('pg4').run;
model.result('pg4').label('Maximum Temperature Difference in the Domain');
model.result('pg4').set('titletype', 'manual');
model.result('pg4').set('title', 'Maximum temperature difference in the domain over time');
model.result('pg4').create('tblp1', 'Table');
model.result('pg4').feature('tblp1').set('markerpos', 'datapoints');
model.result('pg4').feature('tblp1').set('linewidth', 'preference');
model.result('pg4').feature('tblp1').label('Probe Table Graph 1');
model.result('pg4').feature('tblp1').set('plotcolumninput', 'manual');
model.result('pg4').feature('tblp1').set('plotcolumns', [5]);
model.result('pg4').run;
model.result('pg2').run;

model.title('Laser Heating of a Silicon Wafer');

model.description('A silicon wafer is heated up by a laser that moves radially in and out over time, while the wafer itself rotates on its stage. Modeling the incident heat flux from the laser as a spatially distributed heat source on the surface, the transient thermal response of the wafer is obtained. The peak, average, and minimum temperatures during the heating process are computed, as well as the temperature variations across the wafer.');

model.mesh.clearMeshes;

model.sol('sol1').clearSolutionData;

model.label('laser_heating_wafer.mph');

model.modelNode.label('Components');

out = model;
