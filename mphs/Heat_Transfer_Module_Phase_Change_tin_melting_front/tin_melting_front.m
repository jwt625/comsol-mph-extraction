function out = model
%
% tin_melting_front.m
%
% Model exported on May 26 2025, 21:29 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/Heat_Transfer_Module/Phase_Change');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 2);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.physics.create('ht', 'HeatTransferInSolidsAndFluids', 'geom1');
model.physics('ht').model('comp1');
model.physics('ht').prop('PhysicalModelProperty').set('dz', '1[m]');
model.physics('ht').prop('ShapeProperty').set('order_temperature', '1');
model.physics.create('spf', 'LaminarFlow', 'geom1');
model.physics('spf').model('comp1');
model.physics('spf').prop('AdvancedSettingProperty').set('UsePseudoTime', '1');
model.physics('spf').prop('PhysicalModelProperty').set('Compressibility', 'WeaklyCompressible');

model.multiphysics.create('nitf1', 'NonIsothermalFlow', 'geom1', 2);
model.multiphysics('nitf1').set('Fluid_physics', 'spf');
model.multiphysics('nitf1').set('Heat_physics', 'ht');

model.study.create('std1');
model.study('std1').create('time', 'Transient');
model.study('std1').feature('time').setSolveFor('/physics/ht', true);
model.study('std1').feature('time').setSolveFor('/physics/spf', true);
model.study('std1').feature('time').setSolveFor('/multiphysics/nitf1', true);

model.param.set('k_Sn', '60[W/(m*K)]');
model.param.descr('k_Sn', 'Thermal conductivity');
model.param.set('Cp_Sn', '200[J/(kg*K)]');
model.param.descr('Cp_Sn', 'Specific heat capacity');
model.param.set('alpha_Sn', '2.67e-4[1/K]');
model.param.descr('alpha_Sn', 'Coefficient of thermal expansion');
model.param.set('mu_Sn', '6e-3[Pa*s]');
model.param.descr('mu_Sn', 'Kinematic viscosity');
model.param.set('rho_Sn', '7500[kg/m^3]');
model.param.descr('rho_Sn', 'Density');
model.param.set('DelH', '60[kJ/kg]');
model.param.descr('DelH', 'Latent heat of fusion');
model.param.set('Tf', '505[K]');
model.param.descr('Tf', 'Melting point');
model.param.set('Th', '508[K]');
model.param.descr('Th', 'Hot wall temperature');
model.param.set('Tc', '503[K]');
model.param.descr('Tc', 'Cold wall temperature');

model.geom('geom1').create('sq1', 'Square');
model.geom('geom1').feature('sq1').set('size', 0.1);
model.geom('geom1').feature('sq1').setIndex('layername', 'Layer 1', 0);
model.geom('geom1').feature('sq1').setIndex('layer', 0.06, 0);
model.geom('geom1').feature('sq1').set('layerleft', true);
model.geom('geom1').feature('sq1').set('layerbottom', false);
model.geom('geom1').run('fin');

model.material.create('mat1', 'Common', 'comp1');
model.material('mat1').label('Tin (Solid)');
model.material('mat1').selection.set([2]);

model.physics('spf').selection.set([1]);
model.physics('ht').prop('PhysicalModelProperty').set('Tref', 'Tf');
model.physics('ht').feature('fluid1').selection.set([1]);

model.material('mat1').propertyGroup('def').set('thermalconductivity', {'k_Sn'});
model.material('mat1').propertyGroup('def').set('density', {'rho_Sn'});
model.material('mat1').propertyGroup('def').set('heatcapacity', {'Cp_Sn'});
model.material.duplicate('mat2', 'mat1');
model.material('mat2').label('Tin (Liquid)');
model.material('mat2').selection.set([1]);
model.material('mat2').propertyGroup('def').set('dynamicviscosity', {'mu_Sn'});

model.physics('ht').feature('init1').set('Tinit', 'Th-Xg/0.1[m]*(Th-Tc)');
model.physics('spf').prop('PhysicalModelProperty').set('Compressibility', 'Incompressible');
model.physics('spf').prop('PhysicalModelProperty').set('IncludeGravity', true);
model.physics('spf').prop('PhysicalModelProperty').set('UseReducedPressure', true);
model.physics('ht').create('temp1', 'TemperatureBoundary', 1);
model.physics('ht').feature('temp1').selection.set([1]);
model.physics('ht').feature('temp1').set('T0', 'Th');
model.physics('ht').create('temp2', 'TemperatureBoundary', 1);
model.physics('ht').feature('temp2').selection.set([7]);
model.physics('ht').feature('temp2').set('T0', 'Tc');
model.physics('ht').create('pci1', 'PhaseChangeInterface', 1);
model.physics('ht').feature('pci1').selection.set([4]);
model.physics('ht').feature('pci1').set('Tpc', 'Tf');
model.physics('ht').feature('pci1').set('L', 'DelH');
model.physics('ht').feature('pci1').set('SolidSideType', 'Downside');
model.physics('spf').create('prpc1', 'PressurePointConstraint', 0);
model.physics('spf').feature('prpc1').selection.set([1]);

model.multiphysics('nitf1').set('BoussinesqApproximation', true);
model.multiphysics('nitf1').set('SpecifyDensity', 'CustomLinearizedDensity');
model.multiphysics('nitf1').set('rhoref_mat', 'from_mat');
model.multiphysics('nitf1').set('alphap', 'alpha_Sn');

model.common.create('free1', 'DeformingDomainDeformedGeometry', 'comp1');
model.common('free1').selection.all;
model.common('free1').set('smoothingType', 'laplace');
model.common.create('pnmd1', 'PrescribedNormalMeshDisplacementDeformedGeometry', 'comp1');
model.common('pnmd1').selection.set([1 2 3 5 6 7]);

model.mesh('mesh1').autoMeshSize(4);
model.mesh('mesh1').run;

model.study('std1').feature('time').set('tlist', 'range(0,100,10000)');
model.study('std1').feature('time').set('usertol', true);
model.study('std1').feature('time').set('rtol', '1e-4');

model.sol.create('sol1');

model.mesh('mesh1').stat.selection.geom(2);
model.mesh('mesh1').stat.selection.set([1]);
model.mesh('mesh1').stat.selection.geom(2);
model.mesh('mesh1').stat.selection.set([1 2]);

model.sol('sol1').study('std1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'time');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').feature('comp1_material_disp').set('scalemethod', 'manual');
model.sol('sol1').feature('v1').feature('comp1_material_disp').set('scaleval', '0.0021924924173187007');
model.sol('sol1').feature('v1').set('control', 'time');
model.sol('sol1').create('t1', 'Time');
model.sol('sol1').feature('t1').set('tlist', 'range(0,100,10000)');
model.sol('sol1').feature('t1').set('plot', 'off');
model.sol('sol1').feature('t1').set('plotgroup', 'Default');
model.sol('sol1').feature('t1').set('plotfreq', 'tout');
model.sol('sol1').feature('t1').set('probesel', 'all');
model.sol('sol1').feature('t1').set('probes', {});
model.sol('sol1').feature('t1').set('probefreq', 'tsteps');
model.sol('sol1').feature('t1').set('rtol', 1.0E-4);
model.sol('sol1').feature('t1').set('atolglobalmethod', 'scaled');
model.sol('sol1').feature('t1').set('atolglobalfactor', 0.05);
model.sol('sol1').feature('t1').set('atolglobalvaluemethod', 'factor');
model.sol('sol1').feature('t1').set('atolmethod', {'comp1_ht_T_lm' 'global' 'comp1_material_disp' 'global' 'comp1_material_lm_nv' 'global' 'comp1_nitf1_Uave' 'global' 'comp1_p' 'scaled'  ...
'comp1_T' 'global' 'comp1_u' 'global'});
model.sol('sol1').feature('t1').set('atol', {'comp1_ht_T_lm' '1e-3' 'comp1_material_disp' '1e-3' 'comp1_material_lm_nv' '1e-3' 'comp1_nitf1_Uave' '1e-3' 'comp1_p' '1e-3'  ...
'comp1_T' '1e-3' 'comp1_u' '1e-3'});
model.sol('sol1').feature('t1').set('atolvaluemethod', {'comp1_ht_T_lm' 'factor' 'comp1_material_disp' 'factor' 'comp1_material_lm_nv' 'factor' 'comp1_nitf1_Uave' 'factor' 'comp1_p' 'factor'  ...
'comp1_T' 'factor' 'comp1_u' 'factor'});
model.sol('sol1').feature('t1').set('atolfactor', {'comp1_ht_T_lm' '0.1' 'comp1_material_disp' '0.1' 'comp1_material_lm_nv' '0.1' 'comp1_nitf1_Uave' '0.1' 'comp1_p' '1'  ...
'comp1_T' '0.1' 'comp1_u' '0.1'});
model.sol('sol1').feature('t1').set('reacf', true);
model.sol('sol1').feature('t1').set('storeudot', true);
model.sol('sol1').feature('t1').set('endtimeinterpolation', true);
model.sol('sol1').feature('t1').set('estrat', 'exclude');
model.sol('sol1').feature('t1').set('rhoinf', 0.5);
model.sol('sol1').feature('t1').set('predictor', 'constant');
model.sol('sol1').feature('t1').set('maxorder', 2);
model.sol('sol1').feature('t1').set('stabcntrl', true);
model.sol('sol1').feature('t1').set('bwinitstepfrac', '0.01');
model.sol('sol1').feature('t1').set('control', 'time');
model.sol('sol1').feature('t1').feature('aDef').set('cachepattern', true);
model.sol('sol1').feature('t1').create('seDef', 'Segregated');
model.sol('sol1').feature('t1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('t1').feature('fc1').set('stabacc', 'aacc');
model.sol('sol1').feature('t1').feature('fc1').set('aaccdim', 5);
model.sol('sol1').feature('t1').feature('fc1').set('aaccdelay', 0);
model.sol('sol1').feature('t1').feature('fc1').set('aaccmix', 0.9);
model.sol('sol1').feature('t1').feature('fc1').set('ntolfact', 0.5);
model.sol('sol1').feature('t1').feature('fc1').set('maxiter', 8);
model.sol('sol1').feature('t1').feature('fc1').set('damp', 0.9);
model.sol('sol1').feature('t1').feature('fc1').set('jtech', 'once');
model.sol('sol1').feature('t1').create('d1', 'Direct');
model.sol('sol1').feature('t1').feature('d1').label('Direct (Merged)');
model.sol('sol1').feature('t1').create('i1', 'Iterative');
model.sol('sol1').feature('t1').feature('i1').set('linsolver', 'gmres');
model.sol('sol1').feature('t1').feature('i1').set('prefuntype', 'left');
model.sol('sol1').feature('t1').feature('i1').set('itrestart', 50);
model.sol('sol1').feature('t1').feature('i1').set('rhob', 20);
model.sol('sol1').feature('t1').feature('i1').set('maxlinit', 100);
model.sol('sol1').feature('t1').feature('i1').set('nlinnormuse', 'on');
model.sol('sol1').feature('t1').feature('i1').label('AMG, nonisothermal flow (nitf1)');
model.sol('sol1').feature('t1').feature('i1').create('mg1', 'Multigrid');
model.sol('sol1').feature('t1').feature('i1').feature('mg1').set('prefun', 'saamg');
model.sol('sol1').feature('t1').feature('i1').feature('mg1').set('mgcycle', 'v');
model.sol('sol1').feature('t1').feature('i1').feature('mg1').set('maxcoarsedof', 80000);
model.sol('sol1').feature('t1').feature('i1').feature('mg1').set('strconn', 0.02);
model.sol('sol1').feature('t1').feature('i1').feature('mg1').set('nullspace', 'constant');
model.sol('sol1').feature('t1').feature('i1').feature('mg1').set('usesmooth', false);
model.sol('sol1').feature('t1').feature('i1').feature('mg1').set('saamgcompwise', true);
model.sol('sol1').feature('t1').feature('i1').feature('mg1').set('loweramg', true);
model.sol('sol1').feature('t1').feature('i1').feature('mg1').set('compactaggregation', false);
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('pr').create('sc1', 'SCGS');
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('pr').feature('sc1').set('linesweeptype', 'ssor');
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('pr').feature('sc1').set('iter', 0);
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('pr').feature('sc1').set('scgsrelax', 0.7);
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('pr').feature('sc1').set('scgsmethod', 'lines');
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('pr').feature('sc1').set('scgsvertexrelax', 0.7);
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('pr').feature('sc1').set('relax', 0.5);
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('pr').feature('sc1').set('scgssolv', 'stored');
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('pr').feature('sc1').set('approxscgs', true);
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('pr').feature('sc1').set('scgsdirectmaxsize', 1000);
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('pr').feature('sc1').set('vankavarsactive', 'on');
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('pr').feature('sc1').set('vankavars', {'comp1_ht_T_lm'});
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('po').create('sc1', 'SCGS');
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('po').feature('sc1').set('linesweeptype', 'ssor');
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('po').feature('sc1').set('iter', 1);
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('po').feature('sc1').set('scgsrelax', 0.7);
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('po').feature('sc1').set('scgsmethod', 'lines');
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('po').feature('sc1').set('scgsvertexrelax', 0.7);
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('po').feature('sc1').set('relax', 0.5);
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('po').feature('sc1').set('scgssolv', 'stored');
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('po').feature('sc1').set('approxscgs', true);
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('po').feature('sc1').set('scgsdirectmaxsize', 1000);
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('po').feature('sc1').set('vankavarsactive', 'on');
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('po').feature('sc1').set('vankavars', {'comp1_ht_T_lm'});
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('cs').create('d1', 'Direct');
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('cs').feature('d1').set('linsolver', 'pardiso');
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('cs').feature('d1').set('pivotperturb', 1.0E-13);
model.sol('sol1').feature('t1').feature('fc1').set('linsolver', 'd1');
model.sol('sol1').feature('t1').feature('fc1').set('stabacc', 'aacc');
model.sol('sol1').feature('t1').feature('fc1').set('aaccdim', 5);
model.sol('sol1').feature('t1').feature('fc1').set('aaccdelay', 0);
model.sol('sol1').feature('t1').feature('fc1').set('aaccmix', 0.9);
model.sol('sol1').feature('t1').feature('fc1').set('ntolfact', 0.5);
model.sol('sol1').feature('t1').feature('fc1').set('maxiter', 8);
model.sol('sol1').feature('t1').feature('fc1').set('damp', 0.9);
model.sol('sol1').feature('t1').feature('fc1').set('jtech', 'once');
model.sol('sol1').feature('t1').feature.remove('fcDef');
model.sol('sol1').feature('t1').feature.remove('seDef');
model.sol('sol1').attach('std1');
model.sol('sol1').feature('v1').feature('comp1_material_disp').set('scalemethod', 'parent');
model.sol('sol1').runAll;

model.result.create('pg1', 'PlotGroup2D');
model.result('pg1').label('Temperature (ht)');
model.result('pg1').set('data', 'dset1');
model.result('pg1').setIndex('looplevel', 101, 0);
model.result('pg1').set('defaultPlotID', 'ht/HT_PhysicsInterfaces/icom8/pdef1/pcond2/pcond4/pg2');
model.result('pg1').feature.create('surf1', 'Surface');
model.result('pg1').feature('surf1').set('showsolutionparams', 'on');
model.result('pg1').feature('surf1').set('solutionparams', 'parent');
model.result('pg1').feature('surf1').set('colortable', 'HeatCameraLight');
model.result('pg1').feature('surf1').set('showsolutionparams', 'on');
model.result('pg1').feature('surf1').set('data', 'parent');
model.result.dataset('dset1').set('geom', 'geom1');
model.result.create('pg2', 'PlotGroup2D');
model.result('pg2').label('Velocity (spf)');
model.result('pg2').set('frametype', 'spatial');
model.result('pg2').set('data', 'dset1');
model.result('pg2').setIndex('looplevel', 101, 0);
model.result('pg2').set('defaultPlotID', 'ResultDefaults_SinglePhaseFlow/icom1/pdef1/pcond1/pg1');
model.result('pg2').feature.create('surf1', 'Surface');
model.result('pg2').feature('surf1').label('Surface');
model.result('pg2').feature('surf1').set('showsolutionparams', 'on');
model.result('pg2').feature('surf1').set('expr', 'spf.U');
model.result('pg2').feature('surf1').set('smooth', 'internal');
model.result('pg2').feature('surf1').set('showsolutionparams', 'on');
model.result('pg2').feature('surf1').set('data', 'parent');
model.result.create('pg3', 'PlotGroup2D');
model.result('pg3').label('Pressure (spf)');
model.result('pg3').set('frametype', 'spatial');
model.result('pg3').set('data', 'dset1');
model.result('pg3').setIndex('looplevel', 101, 0);
model.result('pg3').set('defaultPlotID', 'ResultDefaults_SinglePhaseFlow/icom1/pdef1/pcond1/pg2');
model.result('pg3').feature.create('con1', 'Contour');
model.result('pg3').feature('con1').label('Contour');
model.result('pg3').feature('con1').set('showsolutionparams', 'on');
model.result('pg3').feature('con1').set('expr', 'p');
model.result('pg3').feature('con1').set('number', 40);
model.result('pg3').feature('con1').set('levelrounding', false);
model.result('pg3').feature('con1').set('smooth', 'internal');
model.result('pg3').feature('con1').set('showsolutionparams', 'on');
model.result('pg3').feature('con1').set('data', 'parent');
model.result.create('pg4', 'PlotGroup2D');
model.result('pg4').label('Temperature and Fluid Flow (nitf1)');
model.result('pg4').set('showlegendsunit', true);
model.result('pg4').set('data', 'dset1');
model.result('pg4').setIndex('looplevel', 101, 0);
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
model.result('pg4').feature.create('surf2', 'Surface');
model.result('pg4').feature('surf2').label('Solid Temperature');
model.result('pg4').feature('surf2').set('showsolutionparams', 'on');
model.result('pg4').feature('surf2').set('solutionparams', 'parent');
model.result('pg4').feature('surf2').set('expr', 'nitf1.T');
model.result('pg4').feature('surf2').set('smooth', 'internal');
model.result('pg4').feature('surf2').set('showsolutionparams', 'on');
model.result('pg4').feature('surf2').set('data', 'parent');
model.result('pg4').feature('surf2').feature.create('sel1', 'Selection');
model.result('pg4').feature('surf2').feature('sel1').selection.geom('geom1', 2);
model.result('pg4').feature('surf2').feature('sel1').selection.set([2]);
model.result('pg4').feature('surf2').set('inheritplot', 'surf1');
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
model.result('pg4').feature('arws1').feature('col1').set('expr', 'spf.U');
model.result('pg4').feature('arws1').feature.create('filt1', 'Filter');
model.result('pg4').feature('arws1').feature('filt1').set('expr', 'spf.U>nitf1.Uave');
model.result.create('pg5', 'PlotGroup2D');
model.result('pg5').set('data', 'dset1');
model.result('pg5').setIndex('looplevel', 101, 0);
model.result('pg5').label('Deformed Geometry');
model.result('pg5').create('mesh1', 'Mesh');
model.result('pg5').feature('mesh1').set('meshdomain', 'surface');
model.result('pg5').feature('mesh1').set('colortable', 'TrafficFlow');
model.result('pg5').feature('mesh1').set('colortabletrans', 'nonlinear');
model.result('pg5').feature('mesh1').set('nonlinearcolortablerev', true);
model.result('pg5').feature('mesh1').create('sel1', 'MeshSelection');
model.result('pg5').feature('mesh1').feature('sel1').selection.set([1 2]);
model.result('pg5').feature('mesh1').set('qualmeasure', 'custom');
model.result('pg5').feature('mesh1').set('qualexpr', 'comp1.material.relVol');
model.result('pg5').feature('mesh1').set('colorrangeunitinterval', false);
model.result('pg1').run;
model.result('pg1').setIndex('looplevel', 1, 0);
model.result('pg1').run;
model.result('pg1').setIndex('looplevel', 101, 0);
model.result('pg4').run;
model.result('pg4').run;
model.result('pg4').feature('arws1').set('xnumber', 15);
model.result('pg4').feature('arws1').set('ynumber', 15);
model.result('pg4').run;
model.result('pg4').feature('arws1').feature('filt1').set('expr', 'spf.U>0.1*nitf1.Uave');
model.result('pg4').run;
model.result('pg2').run;
model.result('pg2').create('arws1', 'ArrowSurface');
model.result('pg2').feature('arws1').set('expr', {'u' 'v'});
model.result('pg2').feature('arws1').set('descr', 'Velocity field (spatial and material frames)');
model.result('pg2').feature('arws1').set('arrowtype', 'cone');
model.result('pg2').feature('arws1').set('color', 'black');
model.result('pg2').run;
model.result('pg5').run;
model.result('pg2').run;

model.title('Tin Melting Front');

model.description('This example demonstrates how to model phase transition by a moving boundary interface according to the Stefan problem. It is adapted from a benchmark study. A square cavity containing both solid and liquid tin is subjected to a temperature difference between left and right boundaries. Fluid and solid parts are solved in separate domains sharing a moving melting front. The position of this boundary through time is calculated according to the Stefan energy balance condition. In the melt, motion generated by natural convection is expected due to the temperature gradient. This motion, in turn, influences the front displacement.');

model.mesh.clearMeshes;

model.sol('sol1').clearSolutionData;

model.label('tin_melting_front.mph');

model.modelNode.label('Components');

out = model;
