function out = model
%
% marangoni_effect.m
%
% Model exported on May 26 2025, 21:29 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/Heat_Transfer_Module/Tutorials,_Forced_and_Natural_Convection');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 2);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.physics.create('spf', 'LaminarFlow', 'geom1');
model.physics('spf').model('comp1');
model.physics('spf').prop('AdvancedSettingProperty').set('UsePseudoTime', '1');
model.physics('spf').prop('PhysicalModelProperty').set('Compressibility', 'WeaklyCompressible');
model.physics.create('ht', 'HeatTransferInFluids', 'geom1');
model.physics('ht').model('comp1');
model.physics('ht').prop('PhysicalModelProperty').set('dz', '1[m]');
model.physics('ht').prop('ShapeProperty').set('order_temperature', '1');

model.multiphysics.create('nitf1', 'NonIsothermalFlow', 'geom1', 2);
model.multiphysics('nitf1').set('Fluid_physics', 'spf');
model.multiphysics('nitf1').set('Heat_physics', 'ht');

model.study.create('std1');
model.study('std1').create('stat', 'Stationary');
model.study('std1').feature('stat').setSolveFor('/physics/spf', true);
model.study('std1').feature('stat').setSolveFor('/physics/ht', true);
model.study('std1').feature('stat').setSolveFor('/multiphysics/nitf1', true);

model.geom('geom1').create('r1', 'Rectangle');
model.geom('geom1').feature('r1').set('size', {'10[mm]' '5[mm]'});
model.geom('geom1').run('fin');

% To import content from file, use:
% model.param.loadFile('FILENAME');
model.param.set('T_right', '273.15[K]', 'Temperature on the right boundary');
model.param.set('DeltaT', '1e-3[K]', 'Excess temperature on the left boundary');
model.param.set('gamma', '-8e-5[N/(m*K)]', 'Temperature derivative of the surface tension');
model.param.set('rho1', '760[kg/m^3]', 'Fluid density');
model.param.set('mu1', '4.94e-4[Pa*s]', 'Dynamic viscosity');
model.param.set('k1', '0.1[W/(m*K)]', 'Thermal conductivity');
model.param.set('Cp1', '2090[J/(kg*K)]', 'Heat capacity');
model.param.set('alphap1', '1.3e-3[1/K]', 'Thermal expansion coefficient');
model.param.set('T_ref', 'T_right', '        Reference temperature for material properties');

model.variable.create('var1');
model.variable('var1').model('comp1');
model.variable('var1').set('deltaT', 'T-T_right');
model.variable('var1').descr('deltaT', 'Excess temperature in model domain');

model.material.create('mat1', 'Common', 'comp1');
model.material('mat1').label('Silicone Oil');
model.material('mat1').propertyGroup('def').set('dynamicviscosity', {'mu1'});
model.material('mat1').propertyGroup('def').set('thermalconductivity', {'k1'});
model.material('mat1').propertyGroup('def').set('heatcapacity', {'Cp1'});

model.physics('spf').prop('PhysicalModelProperty').set('IncludeGravity', true);
model.physics('spf').prop('PhysicalModelProperty').set('Compressibility', 'Incompressible');
model.physics('spf').create('wallbc2', 'WallBC', 1);
model.physics('spf').feature('wallbc2').selection.set([3]);
model.physics('spf').feature('wallbc2').set('BoundaryCondition', 'Slip');
model.physics('spf').create('prpc1', 'PressurePointConstraint', 0);
model.physics('spf').feature('prpc1').selection.set([1]);
model.physics('ht').prop('PhysicalModelProperty').set('Tref', 'T_ref');
model.physics('ht').feature('init1').set('Tinit', 'T_right');
model.physics('ht').create('temp1', 'TemperatureBoundary', 1);
model.physics('ht').feature('temp1').selection.set([4]);
model.physics('ht').feature('temp1').set('T0', 'T_right');
model.physics('ht').create('temp2', 'TemperatureBoundary', 1);
model.physics('ht').feature('temp2').selection.set([1]);
model.physics('ht').feature('temp2').set('T0', 'T_right+DeltaT');

model.multiphysics('nitf1').set('BoussinesqApproximation', true);
model.multiphysics('nitf1').set('SpecifyDensity', 'CustomLinearizedDensity');
model.multiphysics('nitf1').set('rhoref', 'rho1');
model.multiphysics('nitf1').set('alphap', 'alphap1');
model.multiphysics.create('mar1', 'Marangoni', 'geom1', 1);
model.multiphysics('mar1').selection.set([3]);
model.multiphysics('mar1').set('sigma', 'gamma*T');

model.mesh('mesh1').create('ftri1', 'FreeTri');
model.mesh('mesh1').feature('ftri1').create('size1', 'Size');
model.mesh('mesh1').feature('ftri1').feature('size1').selection.geom('geom1', 1);
model.mesh('mesh1').feature('ftri1').feature('size1').selection.set([3]);
model.mesh('mesh1').feature('ftri1').feature('size1').set('custom', true);
model.mesh('mesh1').feature('ftri1').feature('size1').set('hmaxactive', true);
model.mesh('mesh1').feature('ftri1').feature('size1').set('hmax', '1e-4');
model.mesh('mesh1').feature('ftri1').create('size2', 'Size');
model.mesh('mesh1').feature('ftri1').feature('size2').selection.geom('geom1', 0);
model.mesh('mesh1').feature('ftri1').feature('size2').selection.set([2 4]);
model.mesh('mesh1').feature('ftri1').feature('size2').set('custom', true);
model.mesh('mesh1').feature('ftri1').feature('size2').set('hmaxactive', true);
model.mesh('mesh1').feature('ftri1').feature('size2').set('hmax', '2e-5');
model.mesh('mesh1').feature('size').set('hauto', 2);
model.mesh('mesh1').feature('size').set('custom', true);
model.mesh('mesh1').feature('size').set('hgrad', 1.1);
model.mesh('mesh1').run;

model.study('std1').feature('stat').set('useparam', true);
model.study('std1').feature('stat').setIndex('pname', 'T_right', 0);
model.study('std1').feature('stat').setIndex('plistarr', '', 0);
model.study('std1').feature('stat').setIndex('punit', 'K', 0);
model.study('std1').feature('stat').setIndex('pname', 'T_right', 0);
model.study('std1').feature('stat').setIndex('plistarr', '', 0);
model.study('std1').feature('stat').setIndex('punit', 'K', 0);
model.study('std1').feature('stat').setIndex('pname', 'DeltaT', 0);
model.study('std1').feature('stat').setIndex('plistarr', '1e-3 5e-2 2', 0);

model.sol.create('sol1');

model.mesh('mesh1').stat.selection.geom(2);
model.mesh('mesh1').stat.selection.set([1]);

model.sol('sol1').study('std1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'stat');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').set('control', 'stat');
model.sol('sol1').create('s1', 'Stationary');
model.sol('sol1').feature('s1').create('p1', 'Parametric');
model.sol('sol1').feature('s1').feature.remove('pDef');
model.sol('sol1').feature('s1').feature('p1').set('control', 'stat');
model.sol('sol1').feature('s1').set('control', 'stat');
model.sol('sol1').feature('s1').feature('aDef').set('cachepattern', true);
model.sol('sol1').feature('s1').create('seDef', 'Segregated');
model.sol('sol1').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('s1').feature('fc1').set('dtech', 'const');
model.sol('sol1').feature('s1').feature('fc1').set('damp', 0.8);
model.sol('sol1').feature('s1').feature('fc1').set('stabacc', 'cflcmp');
model.sol('sol1').feature('s1').feature('fc1').set('initcfl', 5);
model.sol('sol1').feature('s1').feature('fc1').set('mincfl', 10000);
model.sol('sol1').feature('s1').feature('fc1').set('kppid', 0.65);
model.sol('sol1').feature('s1').feature('fc1').set('kdpid', 0.15);
model.sol('sol1').feature('s1').feature('fc1').set('kipid', 0.15);
model.sol('sol1').feature('s1').feature('fc1').set('cfltol', 0.1);
model.sol('sol1').feature('s1').feature('fc1').set('cflaa', true);
model.sol('sol1').feature('s1').feature('fc1').set('cflaacfl', 9000);
model.sol('sol1').feature('s1').feature('fc1').set('cflaafact', 1);
model.sol('sol1').feature('s1').feature('fc1').set('maxiter', 150);
model.sol('sol1').feature('s1').create('d1', 'Direct');
model.sol('sol1').feature('s1').feature('d1').set('linsolver', 'pardiso');
model.sol('sol1').feature('s1').feature('d1').set('pivotperturb', 1.0E-13);
model.sol('sol1').feature('s1').feature('d1').label('Direct, nonisothermal flow (nitf1) (Merged)');
model.sol('sol1').feature('s1').create('i1', 'Iterative');
model.sol('sol1').feature('s1').feature('i1').set('linsolver', 'gmres');
model.sol('sol1').feature('s1').feature('i1').set('prefuntype', 'left');
model.sol('sol1').feature('s1').feature('i1').set('itrestart', 50);
model.sol('sol1').feature('s1').feature('i1').set('rhob', 20);
model.sol('sol1').feature('s1').feature('i1').set('maxlinit', 1000);
model.sol('sol1').feature('s1').feature('i1').set('nlinnormuse', 'on');
model.sol('sol1').feature('s1').feature('i1').label('AMG, nonisothermal flow (nitf1)');
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
model.sol('sol1').feature('s1').feature('fc1').set('dtech', 'const');
model.sol('sol1').feature('s1').feature('fc1').set('damp', 0.8);
model.sol('sol1').feature('s1').feature('fc1').set('stabacc', 'cflcmp');
model.sol('sol1').feature('s1').feature('fc1').set('initcfl', 5);
model.sol('sol1').feature('s1').feature('fc1').set('mincfl', 10000);
model.sol('sol1').feature('s1').feature('fc1').set('kppid', 0.65);
model.sol('sol1').feature('s1').feature('fc1').set('kdpid', 0.15);
model.sol('sol1').feature('s1').feature('fc1').set('kipid', 0.15);
model.sol('sol1').feature('s1').feature('fc1').set('cfltol', 0.1);
model.sol('sol1').feature('s1').feature('fc1').set('cflaa', true);
model.sol('sol1').feature('s1').feature('fc1').set('cflaacfl', 9000);
model.sol('sol1').feature('s1').feature('fc1').set('cflaafact', 1);
model.sol('sol1').feature('s1').feature('fc1').set('maxiter', 150);
model.sol('sol1').feature('s1').feature.remove('fcDef');
model.sol('sol1').feature('s1').feature.remove('seDef');
model.sol('sol1').attach('std1');
model.sol('sol1').runAll;

model.result.dataset('dset1').set('geom', 'geom1');
model.result.create('pg1', 'PlotGroup2D');
model.result('pg1').label('Velocity (spf)');
model.result('pg1').set('frametype', 'spatial');
model.result('pg1').set('defaultPlotID', 'ResultDefaults_SinglePhaseFlow/icom1/pdef1/pcond1/pg1');
model.result('pg1').feature.create('surf1', 'Surface');
model.result('pg1').feature('surf1').label('Surface');
model.result('pg1').feature('surf1').set('showsolutionparams', 'on');
model.result('pg1').feature('surf1').set('smooth', 'internal');
model.result('pg1').feature('surf1').set('showsolutionparams', 'on');
model.result('pg1').feature('surf1').set('data', 'parent');
model.result.create('pg2', 'PlotGroup2D');
model.result('pg2').label('Pressure (spf)');
model.result('pg2').set('frametype', 'spatial');
model.result('pg2').set('defaultPlotID', 'ResultDefaults_SinglePhaseFlow/icom1/pdef1/pcond1/pg2');
model.result('pg2').feature.create('con1', 'Contour');
model.result('pg2').feature('con1').label('Contour');
model.result('pg2').feature('con1').set('showsolutionparams', 'on');
model.result('pg2').feature('con1').set('expr', 'p');
model.result('pg2').feature('con1').set('number', 40);
model.result('pg2').feature('con1').set('levelrounding', false);
model.result('pg2').feature('con1').set('smooth', 'internal');
model.result('pg2').feature('con1').set('showsolutionparams', 'on');
model.result('pg2').feature('con1').set('data', 'parent');
model.result.create('pg3', 'PlotGroup2D');
model.result('pg3').label('Temperature (ht)');
model.result('pg3').set('defaultPlotID', 'ht/HT_PhysicsInterfaces/icom8/pdef1/pcond2/pcond4/pg2');
model.result('pg3').feature.create('surf1', 'Surface');
model.result('pg3').feature('surf1').set('showsolutionparams', 'on');
model.result('pg3').feature('surf1').set('solutionparams', 'parent');
model.result('pg3').feature('surf1').set('expr', 'T');
model.result('pg3').feature('surf1').set('colortable', 'HeatCameraLight');
model.result('pg3').feature('surf1').set('showsolutionparams', 'on');
model.result('pg3').feature('surf1').set('data', 'parent');
model.result.create('pg4', 'PlotGroup2D');
model.result('pg4').label('Temperature and Fluid Flow (nitf1)');
model.result('pg4').set('showlegendsunit', true);
model.result('pg4').set('defaultPlotID', 'MultiphysicsNonIsothermalFlow/cfcom1/pdef1/pcond4/pcond4/pcond1/pg3');
model.result('pg4').feature.create('surf1', 'Surface');
model.result('pg4').feature('surf1').label('Fluid Temperature');
model.result('pg4').feature('surf1').set('showsolutionparams', 'on');
model.result('pg4').feature('surf1').set('solutionparams', 'parent');
model.result('pg4').feature('surf1').set('expr', 'nitf1.T');
model.result('pg4').feature('surf1').set('colortable', 'HeatCameraLight');
model.result('pg4').feature('surf1').set('smooth', 'internal');
model.result('pg4').feature('surf1').set('showsolutionparams', 'on');
model.result('pg4').feature('surf1').set('data', 'parent');
model.result('pg4').feature('surf1').feature.create('sel1', 'Selection');
model.result('pg4').feature('surf1').feature('sel1').selection.geom('geom1', 2);
model.result('pg4').feature('surf1').feature('sel1').selection.set([1]);
model.result('pg4').feature.create('arws1', 'ArrowSurface');
model.result('pg4').feature('arws1').label('Fluid Flow');
model.result('pg4').feature('arws1').set('showsolutionparams', 'on');
model.result('pg4').feature('arws1').set('solutionparams', 'parent');
model.result('pg4').feature('arws1').set('expr', {'nitf1.ux' 'nitf1.uy'});
model.result('pg4').feature('arws1').set('xnumber', 30);
model.result('pg4').feature('arws1').set('ynumber', 30);
model.result('pg4').feature('arws1').set('arrowtype', 'cone');
model.result('pg4').feature('arws1').set('arrowlength', 'logarithmic');
model.result('pg4').feature('arws1').set('showsolutionparams', 'on');
model.result('pg4').feature('arws1').set('data', 'parent');
model.result('pg4').feature('arws1').feature.create('col1', 'Color');
model.result('pg4').feature('arws1').feature('col1').set('showcolordata', 'off');
model.result('pg4').feature('arws1').feature.create('filt1', 'Filter');
model.result('pg4').feature('arws1').feature('filt1').set('expr', 'spf.U>nitf1.Uave');
model.result('pg1').run;
model.result.create('pg5', 'PlotGroup2D');
model.result('pg5').label('Isothermal Contours (ht)');
model.result('pg5').set('defaultPlotID', 'ht/HT_PhysicsInterfaces/icom8/pdef1/pcond2/pcond4/pg1');
model.result('pg5').feature.create('con1', 'Contour');
model.result('pg5').feature('con1').set('solutionparams', 'parent');
model.result('pg5').feature('con1').set('expr', 'T');
model.result('pg5').feature('con1').set('colortable', 'HeatCameraLight');
model.result('pg5').feature('con1').set('smooth', 'internal');
model.result('pg5').feature('con1').set('showsolutionparams', 'on');
model.result('pg5').feature('con1').set('data', 'parent');
model.result('pg5').label('Isothermal Contours (ht)');
model.result('pg5').run;
model.result('pg5').setIndex('looplevel', 1, 0);
model.result('pg5').run;
model.result('pg5').feature('con1').set('expr', 'deltaT');
model.result('pg5').feature('con1').set('descr', 'Excess temperature in model domain');
model.result('pg5').feature('con1').set('coloring', 'uniform');
model.result('pg5').feature('con1').set('color', 'black');
model.result('pg5').feature('con1').set('colorlegend', false);
model.result('pg5').run;
model.result('pg5').create('arws1', 'ArrowSurface');
model.result('pg5').feature('arws1').set('color', 'black');
model.result('pg5').run;
model.result('pg5').create('surf1', 'Surface');
model.result('pg5').feature('surf1').set('expr', 'deltaT');
model.result('pg5').feature('surf1').set('descr', 'Excess temperature in model domain');
model.result('pg5').feature('surf1').set('colortable', 'HeatCameraLight');
model.result('pg5').run;
model.result('pg5').run;
model.result('pg5').setIndex('looplevel', 2, 0);
model.result('pg5').run;
model.result('pg5').setIndex('looplevel', 3, 0);
model.result('pg5').run;
model.result.create('pg6', 'PlotGroup2D');
model.result('pg6').run;
model.result('pg6').label('Convection Cell');
model.result('pg6').create('surf1', 'Surface');
model.result('pg6').feature('surf1').set('expr', 'T');
model.result('pg6').feature('surf1').set('colortable', 'HeatCameraLight');
model.result('pg6').create('str1', 'Streamline');
model.result('pg6').feature('str1').set('descractive', true);
model.result('pg6').feature('str1').set('descr', 'Velocity field (m/s)');
model.result('pg6').feature('str1').set('posmethod', 'magnitude');
model.result('pg6').feature('str1').set('pointtype', 'arrow');
model.result('pg6').feature('str1').set('maxsteps', 20000);
model.result('pg6').feature('str1').create('col1', 'Color');
model.result('pg6').run;
model.result('pg6').run;
model.result('pg6').setIndex('looplevel', 1, 0);
model.result('pg6').run;
model.result('pg6').stepNext(0);
model.result('pg6').run;
model.result('pg6').stepNext(0);
model.result('pg6').run;

model.title('Marangoni Effect');

model.description('A model of the Marangoni convection in a cavity filled with silicon oil. The fluid accelerates when the temperature gradient is high. The conduction of heat is small compared to the convection.');

model.label('marangoni_effect.mph');

model.modelNode.label('Components');

out = model;
