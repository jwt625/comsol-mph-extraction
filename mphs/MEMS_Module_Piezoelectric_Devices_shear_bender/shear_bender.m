function out = model
%
% shear_bender.m
%
% Model exported on May 26 2025, 21:30 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/MEMS_Module/Piezoelectric_Devices');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 3);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.physics.create('solid', 'SolidMechanics', 'geom1');
model.physics('solid').model('comp1');
model.physics('solid').create('pzm1', 'PiezoelectricMaterialModel');
model.physics('solid').feature('pzm1').selection.all;
model.physics.create('es', 'Electrostatics', 'geom1');
model.physics('es').model('comp1');
model.physics('es').create('ccnp1', 'ChargeConservationPiezo');
model.physics('es').feature('ccnp1').selection.all;

model.multiphysics.create('pze1', 'PiezoelectricEffect', 'geom1', 3);
model.multiphysics('pze1').set('Solid_physics', 'solid');
model.multiphysics('pze1').set('Electrostatics_physics', 'es');

model.study.create('std1');
model.study('std1').create('stat', 'Stationary');
model.study('std1').feature('stat').setSolveFor('/physics/solid', true);
model.study('std1').feature('stat').setSolveFor('/physics/es', true);
model.study('std1').feature('stat').setSolveFor('/multiphysics/pze1', true);

model.geom('geom1').lengthUnit('mm');
model.geom('geom1').create('blk1', 'Block');
model.geom('geom1').feature('blk1').set('size', [100 30 18]);
model.geom('geom1').run('blk1');
model.geom('geom1').create('blk2', 'Block');
model.geom('geom1').feature('blk2').set('size', [100 30 2]);
model.geom('geom1').feature('blk2').set('pos', [0 0 8]);
model.geom('geom1').feature('blk2').set('layerleft', true);
model.geom('geom1').feature('blk2').set('layerbottom', false);
model.geom('geom1').feature('blk2').setIndex('layer', 55, 0);
model.geom('geom1').feature('blk2').setIndex('layer', 10, 1);
model.geom('geom1').runPre('fin');

model.view('view1').set('transparency', false);

model.coordSystem.create('sys2', 'geom1', 'VectorBase');

model.geom('geom1').run;

model.coordSystem('sys2').setIndex('base', 0, 0, 0);
model.coordSystem('sys2').setIndex('base', -1, 0, 2);
model.coordSystem('sys2').setIndex('base', 1, 2, 0);
model.coordSystem('sys2').setIndex('base', 0, 2, 2);
model.coordSystem('sys2').set('orthonormal', true);

model.physics('es').selection.set([4]);
model.physics('solid').feature('pzm1').selection.set([4]);
model.physics('solid').feature('pzm1').set('coordinateSystem', 'sys2');

model.material.create('mat1', 'Common', 'comp1');
model.material('mat1').propertyGroup.create('Enu', 'Young''s modulus and Poisson''s ratio');
model.material('mat1').label('Al - Aluminum');
model.material('mat1').set('family', 'aluminum');
model.material('mat1').propertyGroup('def').set('electricconductivity', {'35.5e6[S/m]' '0' '0' '0' '35.5e6[S/m]' '0' '0' '0' '35.5e6[S/m]'});
model.material('mat1').propertyGroup('def').set('thermalexpansioncoefficient', {'23.1e-6[1/K]' '0' '0' '0' '23.1e-6[1/K]' '0' '0' '0' '23.1e-6[1/K]'});
model.material('mat1').propertyGroup('def').set('heatcapacity', '904[J/(kg*K)]');
model.material('mat1').propertyGroup('def').set('density', '2700[kg/m^3]');
model.material('mat1').propertyGroup('def').set('thermalconductivity', {'237[W/(m*K)]' '0' '0' '0' '237[W/(m*K)]' '0' '0' '0' '237[W/(m*K)]'});
model.material('mat1').propertyGroup('Enu').set('E', '70.0e9[Pa]');
model.material('mat1').propertyGroup('Enu').set('nu', '0.35');
model.material('mat1').selection.set([1 3]);
model.material.create('mat2', 'Common', 'comp1');
model.material('mat2').label('Foam');
model.material('mat2').selection.set([2 5]);
model.material('mat2').propertyGroup.create('Enu', 'Young''s_modulus_and_Poisson''s_ratio');
model.material('mat2').propertyGroup('Enu').set('E', {'35.3[MPa]'});
model.material('mat2').propertyGroup('Enu').set('nu', {'0.383'});
model.material('mat2').propertyGroup('def').set('density', {'32'});
model.material.create('mat3', 'Common', 'comp1');
model.material('mat3').propertyGroup.create('StrainCharge', 'Strain-charge form');
model.material('mat3').propertyGroup.create('StressCharge', 'Stress-charge form');
model.material('mat3').label('Lead Zirconate Titanate (PZT-5H)');
model.material('mat3').set('family', 'custom');
model.material('mat3').set('customspecular', [0.7843137254901961 1 1]);
model.material('mat3').set('customdiffuse', [0.7843137254901961 0.7843137254901961 0.7843137254901961]);
model.material('mat3').set('noise', true);
model.material('mat3').set('fresnel', 0.9);
model.material('mat3').set('roughness', 0.1);
model.material('mat3').set('metallic', 0);
model.material('mat3').set('pearl', 0);
model.material('mat3').set('diffusewrap', 0);
model.material('mat3').set('clearcoat', 0);
model.material('mat3').set('reflectance', 0);
model.material('mat3').propertyGroup('def').set('relpermittivity', {'1704.4' '0' '0' '0' '1704.4' '0' '0' '0' '1433.6'});
model.material('mat3').propertyGroup('def').set('density', '7500[kg/m^3]');
model.material('mat3').propertyGroup('StrainCharge').set('sE', {'1.65e-011[1/Pa]' '-4.78e-012[1/Pa]' '-8.45e-012[1/Pa]' '0[1/Pa]' '0[1/Pa]' '0[1/Pa]' '-4.78e-012[1/Pa]' '1.65e-011[1/Pa]' '-8.45e-012[1/Pa]' '0[1/Pa]'  ...
'0[1/Pa]' '0[1/Pa]' '-8.45e-012[1/Pa]' '-8.45e-012[1/Pa]' '2.07e-011[1/Pa]' '0[1/Pa]' '0[1/Pa]' '0[1/Pa]' '0[1/Pa]' '0[1/Pa]'  ...
'0[1/Pa]' '4.35e-011[1/Pa]' '0[1/Pa]' '0[1/Pa]' '0[1/Pa]' '0[1/Pa]' '0[1/Pa]' '0[1/Pa]' '4.35e-011[1/Pa]' '0[1/Pa]'  ...
'0[1/Pa]' '0[1/Pa]' '0[1/Pa]' '0[1/Pa]' '0[1/Pa]' '4.26e-011[1/Pa]'});
model.material('mat3').propertyGroup('StrainCharge').set('dET', {'0[C/N]' '0[C/N]' '-2.74e-010[C/N]' '0[C/N]' '0[C/N]' '-2.74e-010[C/N]' '0[C/N]' '0[C/N]' '5.93e-010[C/N]' '0[C/N]'  ...
'7.41e-010[C/N]' '0[C/N]' '7.41e-010[C/N]' '0[C/N]' '0[C/N]' '0[C/N]' '0[C/N]' '0[C/N]'});
model.material('mat3').propertyGroup('StrainCharge').set('epsilonrT', {'3130' '0' '0' '0' '3130' '0' '0' '0' '3400'});
model.material('mat3').propertyGroup('StressCharge').set('cE', {'1.27205e+011[Pa]' '8.02122e+010[Pa]' '8.46702e+010[Pa]' '0[Pa]' '0[Pa]' '0[Pa]' '8.02122e+010[Pa]' '1.27205e+011[Pa]' '8.46702e+010[Pa]' '0[Pa]'  ...
'0[Pa]' '0[Pa]' '8.46702e+010[Pa]' '8.46702e+010[Pa]' '1.17436e+011[Pa]' '0[Pa]' '0[Pa]' '0[Pa]' '0[Pa]' '0[Pa]'  ...
'0[Pa]' '2.29885e+010[Pa]' '0[Pa]' '0[Pa]' '0[Pa]' '0[Pa]' '0[Pa]' '0[Pa]' '2.29885e+010[Pa]' '0[Pa]'  ...
'0[Pa]' '0[Pa]' '0[Pa]' '0[Pa]' '0[Pa]' '2.34742e+010[Pa]'});
model.material('mat3').propertyGroup('StressCharge').set('eES', {'0[C/m^2]' '0[C/m^2]' '-6.62281[C/m^2]' '0[C/m^2]' '0[C/m^2]' '-6.62281[C/m^2]' '0[C/m^2]' '0[C/m^2]' '23.2403[C/m^2]' '0[C/m^2]'  ...
'17.0345[C/m^2]' '0[C/m^2]' '17.0345[C/m^2]' '0[C/m^2]' '0[C/m^2]' '0[C/m^2]' '0[C/m^2]' '0[C/m^2]'});
model.material('mat3').propertyGroup('StressCharge').set('epsilonrS', {'1704.4' '0' '0' '0' '1704.4' '0' '0' '0' '1433.6'});
model.material('mat3').selection.set([4]);

model.physics('solid').create('fix1', 'Fixed', 2);
model.physics('solid').feature('fix1').selection.set([1 4 7]);
model.physics('es').create('pot1', 'ElectricPotential', 2);
model.physics('es').feature('pot1').selection.set([16]);
model.physics('es').feature('pot1').set('V0', 20);
model.physics('es').create('gnd1', 'Ground', 2);
model.physics('es').feature('gnd1').selection.set([17]);

model.mesh('mesh1').create('swe1', 'Sweep');
model.mesh('mesh1').feature('swe1').selection('sourceface').set([9 17 22]);
model.mesh('mesh1').feature('swe1').create('dis1', 'Distribution');
model.mesh('mesh1').feature('swe1').feature('dis1').set('numelem', 2);
model.mesh('mesh1').run;

model.sol.create('sol1');
model.sol('sol1').study('std1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'stat');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').set('control', 'stat');
model.sol('sol1').create('s1', 'Stationary');
model.sol('sol1').feature('s1').feature('aDef').set('cachepattern', true);
model.sol('sol1').feature('s1').create('seDef', 'Segregated');
model.sol('sol1').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('s1').feature('fc1').set('termonres', 'auto');
model.sol('sol1').feature('s1').feature('fc1').set('reserrfact', 1000);
model.sol('sol1').feature('s1').create('d1', 'Direct');
model.sol('sol1').feature('s1').feature('d1').set('linsolver', 'pardiso');
model.sol('sol1').feature('s1').feature('d1').set('pivotperturb', 1.0E-9);
model.sol('sol1').feature('s1').feature('d1').label('Suggested Direct Solver (pze1) (Merged)');
model.sol('sol1').feature('s1').create('i1', 'Iterative');
model.sol('sol1').feature('s1').feature('i1').set('linsolver', 'gmres');
model.sol('sol1').feature('s1').feature('i1').set('rhob', 400);
model.sol('sol1').feature('s1').feature('i1').set('nlinnormuse', true);
model.sol('sol1').feature('s1').feature('i1').label('Suggested Iterative Solver (pze1)');
model.sol('sol1').feature('s1').feature('i1').create('mg1', 'Multigrid');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').set('prefun', 'gmg');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('pr').create('so1', 'SOR');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('pr').feature('so1').set('relax', 0.8);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('po').create('so1', 'SOR');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('po').feature('so1').set('relax', 0.8);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('cs').create('d1', 'Direct');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('cs').feature('d1').set('linsolver', 'pardiso');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('cs').feature('d1').set('pivotperturb', 1.0E-9);
model.sol('sol1').feature('s1').feature('fc1').set('linsolver', 'd1');
model.sol('sol1').feature('s1').feature('fc1').set('termonres', 'auto');
model.sol('sol1').feature('s1').feature('fc1').set('reserrfact', 1000);
model.sol('sol1').feature('s1').feature.remove('fcDef');
model.sol('sol1').feature('s1').feature.remove('seDef');
model.sol('sol1').attach('std1');
model.sol('sol1').runAll;

model.result.create('pg1', 'PlotGroup3D');
model.result('pg1').set('data', 'dset1');
model.result('pg1').set('defaultPlotID', 'stress');
model.result('pg1').label('Stress (solid)');
model.result('pg1').set('frametype', 'spatial');
model.result('pg1').create('vol1', 'Volume');
model.result('pg1').feature('vol1').set('expr', {'solid.misesGp'});
model.result('pg1').feature('vol1').set('threshold', 'manual');
model.result('pg1').feature('vol1').set('thresholdvalue', 0.2);
model.result('pg1').feature('vol1').set('colortable', 'Rainbow');
model.result('pg1').feature('vol1').set('colortabletrans', 'none');
model.result('pg1').feature('vol1').set('colorscalemode', 'linear');
model.result('pg1').feature('vol1').set('resolution', 'custom');
model.result('pg1').feature('vol1').set('refine', 2);
model.result('pg1').feature('vol1').set('colortable', 'Prism');
model.result('pg1').feature('vol1').create('def', 'Deform');
model.result('pg1').feature('vol1').feature('def').set('expr', {'u' 'v' 'w'});
model.result('pg1').feature('vol1').feature('def').set('descr', 'Displacement field');
model.result.create('pg2', 'PlotGroup3D');
model.result('pg2').label('Electric Potential (es)');
model.result('pg2').set('frametype', 'spatial');
model.result('pg2').set('showlegendsmaxmin', true);
model.result('pg2').set('data', 'dset1');
model.result('pg2').set('defaultPlotID', 'InterfaceComponents/PlotDefaults/icom2/pdef1/pcond2/pcond1/pcond1/pg1');
model.result('pg2').feature.create('mslc1', 'Multislice');
model.result('pg2').feature('mslc1').set('showsolutionparams', 'on');
model.result('pg2').feature('mslc1').set('solutionparams', 'parent');
model.result('pg2').feature('mslc1').set('expr', 'V');
model.result('pg2').feature('mslc1').set('multiplanexmethod', 'coord');
model.result('pg2').feature('mslc1').set('xcoord', 'es.CPx');
model.result('pg2').feature('mslc1').set('multiplaneymethod', 'coord');
model.result('pg2').feature('mslc1').set('ycoord', 'es.CPy');
model.result('pg2').feature('mslc1').set('multiplanezmethod', 'coord');
model.result('pg2').feature('mslc1').set('zcoord', 'es.CPz');
model.result('pg2').feature('mslc1').set('colortable', 'Dipole');
model.result('pg2').feature('mslc1').set('showsolutionparams', 'on');
model.result('pg2').feature('mslc1').set('data', 'parent');
model.result('pg2').feature.create('strmsl1', 'StreamlineMultislice');
model.result('pg2').feature('strmsl1').set('showsolutionparams', 'on');
model.result('pg2').feature('strmsl1').set('solutionparams', 'parent');
model.result('pg2').feature('strmsl1').set('expr', {'es.Ex' 'es.Ey' 'es.Ez'});
model.result('pg2').feature('strmsl1').set('multiplanexmethod', 'coord');
model.result('pg2').feature('strmsl1').set('xcoord', 'es.CPx');
model.result('pg2').feature('strmsl1').set('multiplaneymethod', 'coord');
model.result('pg2').feature('strmsl1').set('ycoord', 'es.CPy');
model.result('pg2').feature('strmsl1').set('multiplanezmethod', 'coord');
model.result('pg2').feature('strmsl1').set('zcoord', 'es.CPz');
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
model.result('pg2').feature('strmsl1').feature('col1').set('expr', 'V');
model.result('pg2').feature('strmsl1').feature('col1').set('colortable', 'DipoleDark');
model.result('pg2').feature('strmsl1').feature('col1').set('colorlegend', false);
model.result('pg2').feature('strmsl1').feature.create('filt1', 'Filter');
model.result('pg2').feature('strmsl1').feature('filt1').set('expr', '!isScalingSystemDomain');
model.result.create('pg3', 'PlotGroup3D');
model.result('pg3').label('Electric Field Norm (es)');
model.result('pg3').set('frametype', 'spatial');
model.result('pg3').set('showlegendsmaxmin', true);
model.result('pg3').set('data', 'dset1');
model.result('pg3').set('defaultPlotID', 'InterfaceComponents/PlotDefaults/icom3/pdef1/pcond2/pcond1/pg1');
model.result('pg3').feature.create('mslc1', 'Multislice');
model.result('pg3').feature('mslc1').set('showsolutionparams', 'on');
model.result('pg3').feature('mslc1').set('solutionparams', 'parent');
model.result('pg3').feature('mslc1').set('expr', 'es.normE');
model.result('pg3').feature('mslc1').set('multiplanexmethod', 'coord');
model.result('pg3').feature('mslc1').set('xcoord', 'es.CPx');
model.result('pg3').feature('mslc1').set('multiplaneymethod', 'coord');
model.result('pg3').feature('mslc1').set('ycoord', 'es.CPy');
model.result('pg3').feature('mslc1').set('multiplanezmethod', 'coord');
model.result('pg3').feature('mslc1').set('zcoord', 'es.CPz');
model.result('pg3').feature('mslc1').set('colortable', 'Prism');
model.result('pg3').feature('mslc1').set('colortabletrans', 'nonlinear');
model.result('pg3').feature('mslc1').set('colorcalibration', -0.8);
model.result('pg3').feature('mslc1').set('showsolutionparams', 'on');
model.result('pg3').feature('mslc1').set('data', 'parent');
model.result('pg3').feature.create('strmsl1', 'StreamlineMultislice');
model.result('pg3').feature('strmsl1').set('showsolutionparams', 'on');
model.result('pg3').feature('strmsl1').set('solutionparams', 'parent');
model.result('pg3').feature('strmsl1').set('expr', {'es.Ex' 'es.Ey' 'es.Ez'});
model.result('pg3').feature('strmsl1').set('multiplanexmethod', 'coord');
model.result('pg3').feature('strmsl1').set('xcoord', 'es.CPx');
model.result('pg3').feature('strmsl1').set('multiplaneymethod', 'coord');
model.result('pg3').feature('strmsl1').set('ycoord', 'es.CPy');
model.result('pg3').feature('strmsl1').set('multiplanezmethod', 'coord');
model.result('pg3').feature('strmsl1').set('zcoord', 'es.CPz');
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
model.result('pg3').feature('strmsl1').feature('col1').set('expr', 'es.normE');
model.result('pg3').feature('strmsl1').feature('col1').set('colortable', 'PrismDark');
model.result('pg3').feature('strmsl1').feature('col1').set('colorlegend', false);
model.result('pg3').feature('strmsl1').feature('col1').set('colortabletrans', 'nonlinear');
model.result('pg3').feature('strmsl1').feature('col1').set('colorcalibration', -0.8);
model.result('pg3').feature('strmsl1').feature.create('filt1', 'Filter');
model.result('pg3').feature('strmsl1').feature('filt1').set('expr', '!isScalingSystemDomain');
model.result('pg1').run;
model.result('pg1').label('Displacement (solid)');
model.result('pg1').run;
model.result('pg1').feature('vol1').set('expr', 'w');
model.result('pg1').feature('vol1').set('descr', 'Displacement field, Z-component');
model.result('pg1').feature('vol1').set('unit', 'nm');
model.result('pg1').run;
model.result('pg2').run;
model.result('pg2').run;
model.result('pg2').feature.remove('mslc1');
model.result('pg2').feature.remove('strmsl1');
model.result('pg2').run;
model.result('pg2').create('surf1', 'Surface');
model.result('pg2').feature('surf1').set('expr', 'V');
model.result('pg2').feature('surf1').set('descr', 'Electric potential');
model.result('pg2').run;
model.result.create('pg4', 'PlotGroup3D');
model.result('pg4').run;
model.result('pg4').label('PZT coordinate system');
model.result('pg4').create('sysv1', 'CoordSysVolume');
model.result('pg4').feature('sysv1').set('sys', 'sys2');
model.result('pg4').feature('sysv1').set('arrowxmethod', 'coord');
model.result('pg4').feature('sysv1').set('xcoord', 60);
model.result('pg4').feature('sysv1').set('ynumber', 1);
model.result('pg4').feature('sysv1').set('znumber', 1);
model.result('pg4').run;

model.title('Piezoelectric Shear-Actuated Beam');

model.description('This model performs a static analysis of a composite cantilever beam equipped with a piezoceramic actuator. An electric field is applied perpendicular to the poling direction, thereby introducing a transverse deflection of the beam.');

model.label('shear_bender.mph');

model.modelNode.label('Components');

out = model;
