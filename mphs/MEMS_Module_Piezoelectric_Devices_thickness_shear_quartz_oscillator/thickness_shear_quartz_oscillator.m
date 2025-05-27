function out = model
%
% thickness_shear_quartz_oscillator.m
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

model.param.set('Cs', '1[pF]');
model.param.descr('Cs', 'Series capacitance');
model.param.set('R0', '835[um]');
model.param.descr('R0', 'Oscillator radius');
model.param.set('H0', '334[um]');
model.param.descr('H0', 'Oscillator thickness');

model.geom('geom1').run;

model.mesh('mesh1').create('imp1', 'Import');
model.mesh('mesh1').feature('imp1').set('filename', 'thickness_shear_quartz_oscillator_mesh.mphbin');
model.mesh('mesh1').feature('imp1').importData;

model.cpl.create('intop1', 'Integration', 'geom1');

model.mesh('mesh1').run;

model.cpl('intop1').set('axisym', true);
model.cpl('intop1').selection.geom('geom1', 0);
model.cpl('intop1').selection.set([8]);

model.selection.create('sel1', 'Explicit');
model.selection('sel1').model('comp1');
model.selection('sel1').label('All surfaces');
model.selection('sel1').geom(2);
model.selection('sel1').all;

model.coordSystem.create('sys2', 'geom1', 'Rotated');
model.coordSystem('sys2').set('angle', {'0' '125.25[deg]' '0'});

model.material.create('mat1', 'Common', 'comp1');
model.material('mat1').propertyGroup.create('StrainCharge', 'Strain-charge form');
model.material('mat1').propertyGroup.create('StressCharge', 'Stress-charge form');
model.material('mat1').label('Quartz LH (1978 IEEE)');
model.material('mat1').set('family', 'custom');
model.material('mat1').set('customambient', [1 1 1]);
model.material('mat1').set('noise', true);
model.material('mat1').set('fresnel', 0.99);
model.material('mat1').set('roughness', 0.02);
model.material('mat1').set('metallic', 0);
model.material('mat1').set('pearl', 0);
model.material('mat1').set('diffusewrap', 0);
model.material('mat1').set('clearcoat', 0);
model.material('mat1').set('reflectance', 0);
model.material('mat1').propertyGroup('def').set('relpermittivity', {'4.428' '0' '0' '0' '4.428' '0' '0' '0' '4.634'});
model.material('mat1').propertyGroup('def').set('density', '2651[kg/m^3]');
model.material('mat1').propertyGroup('StrainCharge').set('sE', {'1.277e-011[1/Pa]' '-1.79e-012[1/Pa]' '-1.22e-012[1/Pa]' '-4.5e-012[1/Pa]' '0[1/Pa]' '0[1/Pa]' '-1.79e-012[1/Pa]' '1.277e-011[1/Pa]' '-1.22e-012[1/Pa]' '4.5e-012[1/Pa]'  ...
'0[1/Pa]' '0[1/Pa]' '-1.22e-012[1/Pa]' '-1.22e-012[1/Pa]' '9.6e-012[1/Pa]' '0[1/Pa]' '0[1/Pa]' '0[1/Pa]' '-4.5e-012[1/Pa]' '4.5e-012[1/Pa]'  ...
'0[1/Pa]' '2.00e-011[1/Pa]' '0[1/Pa]' '0[1/Pa]' '0[1/Pa]' '0[1/Pa]' '0[1/Pa]' '0[1/Pa]' '2.00e-011[1/Pa]' '-9e-012[1/Pa]'  ...
'0[1/Pa]' '0[1/Pa]' '0[1/Pa]' '0[1/Pa]' '-9e-012[1/Pa]' '2.912e-011[1/Pa]'});
model.material('mat1').propertyGroup('StrainCharge').set('dET', {'-2.307e-012[C/N]' '0[C/N]' '0[C/N]' '2.307e-012[C/N]' '0[C/N]' '0[C/N]' '0[C/N]' '0[C/N]' '0[C/N]' '7.25e-013[C/N]'  ...
'0[C/N]' '0[C/N]' '0[C/N]' '-7.25e-013[C/N]' '0[C/N]' '0[C/N]' '4.6e-012[C/N]' '0[C/N]'});
model.material('mat1').propertyGroup('StrainCharge').set('epsilonrT', {'4.514' '0' '0' '0' '4.514' '0' '0' '0' '4.634'});
model.material('mat1').propertyGroup('StressCharge').set('cE', {'8.67362e+010[Pa]' '6.98527e+009[Pa]' '1.19104e+010[Pa]' '1.79081e+010[Pa]' '0[Pa]' '0[Pa]' '6.98527e+009[Pa]' '8.67362e+010[Pa]' '1.19104e+010[Pa]' '-1.79081e+010[Pa]'  ...
'0[Pa]' '0[Pa]' '1.19104e+010[Pa]' '1.19104e+010[Pa]' '1.07194e+011[Pa]' '0[Pa]' '0[Pa]' '0[Pa]' '1.79081e+010[Pa]' '-1.79081e+010[Pa]'  ...
'0[Pa]' '5.79428e+010[Pa]' '0[Pa]' '0[Pa]' '0[Pa]' '0[Pa]' '0[Pa]' '0[Pa]' '5.79492e+010[Pa]' '1.79224e+010[Pa]'  ...
'0[Pa]' '0[Pa]' '0[Pa]' '0[Pa]' '1.79224e+010[Pa]' '3.99073e+010[Pa]'});
model.material('mat1').propertyGroup('StressCharge').set('eES', {'-0.1710[C/m^2]' '0[C/m^2]' '0[C/m^2]' '0.1710[C/m^2]' '0[C/m^2]' '0[C/m^2]' '0[C/m^2]' '0[C/m^2]' '0[C/m^2]' '-0.0406[C/m^2]'  ...
'0[C/m^2]' '0[C/m^2]' '0[C/m^2]' '0.0406[C/m^2]' '0[C/m^2]' '0[C/m^2]' '0.1710[C/m^2]' '0[C/m^2]'});
model.material('mat1').propertyGroup('StressCharge').set('epsilonrS', {'4.428' '0' '0' '0' '4.428' '0' '0' '0' '4.634'});

model.physics('solid').feature('pzm1').set('coordinateSystem', 'sys2');
model.physics('solid').feature('pzm1').create('mdmp1', 'MechanicalDamping', 3);
model.physics('solid').feature('pzm1').feature('mdmp1').set('DampingType', 'IsotropicLossFactor');
model.physics('solid').feature('pzm1').feature('mdmp1').set('eta_s_mat', 'userdef');
model.physics('solid').feature('pzm1').feature('mdmp1').set('eta_s', '1e-3');
model.physics('es').create('term1', 'Terminal', 2);
model.physics('es').feature('term1').selection.set([4]);
model.physics('es').feature('term1').set('TerminalType', 'Circuit');
model.physics('es').create('term2', 'Terminal', 2);
model.physics('es').feature('term2').set('TerminalName', '1');
model.physics('es').feature('term2').selection.set([4]);
model.physics('es').feature('term2').set('TerminalType', 'Voltage');
model.physics('es').feature('term2').set('V0', 10);
model.physics('es').create('gnd1', 'Ground', 2);
model.physics('es').feature('gnd1').selection.set([3]);
model.physics.create('cir', 'Circuit', 'geom1');
model.physics('cir').model('comp1');
model.physics('cir').create('V1', 'VoltageSource', -1);
model.physics('cir').feature('V1').setIndex('Connections', 2, 0, 0);
model.physics('cir').feature('V1').setIndex('Connections', 0, 1, 0);
model.physics('cir').feature('V1').set('sourceType', 'AC');
model.physics('cir').feature('V1').set('value', 10);
model.physics('cir').create('C1', 'Capacitor', -1);
model.physics('cir').feature('C1').setIndex('Connections', 2, 0, 0);
model.physics('cir').feature('C1').setIndex('Connections', 1, 1, 0);
model.physics('cir').feature('C1').set('C', 'Cs');
model.physics('cir').create('termI1', 'ModelTerminalIV', -1);
model.physics('cir').feature('termI1').set('Connections', 1);
model.physics('cir').feature('termI1').set('V_src', 'root.comp1.es.V0_1');

model.study.create('std1');
model.study('std1').create('frawe', 'FrequencyAdaptive');
model.study('std1').feature('frawe').set('plist', 'range(5.095[MHz],0.2[kHz],5.13[MHz])');
model.study('std1').feature('frawe').set('awefunctype', 'usercontrolled');
model.study('std1').feature('frawe').setIndex('awefunc', 'comp1.intop1(abs(comp1.u)/1e-9)', 0);
model.study('std1').feature('frawe').setEntry('activate', 'cir', false);

model.sol.create('sol1');
model.sol('sol1').study('std1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'frawe');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').set('control', 'frawe');
model.sol('sol1').create('aw1', 'AWE');
model.sol('sol1').feature('aw1').set('pname', 'freq');
model.sol('sol1').feature('aw1').set('plist', 'range(5.095[MHz],0.2[kHz],5.13[MHz])');
model.sol('sol1').feature('aw1').set('awefunc', {'comp1.intop1(abs(comp1.u)/1e-9)'});
model.sol('sol1').feature('aw1').set('rtol', 0.01);
model.sol('sol1').feature('aw1').set('plot', 'off');
model.sol('sol1').feature('aw1').set('plotgroup', 'Default');
model.sol('sol1').feature('aw1').set('probesel', 'all');
model.sol('sol1').feature('aw1').set('probes', {});
model.sol('sol1').feature('aw1').feature('aDef').set('cachepattern', true);
model.sol('sol1').attach('std1');
model.sol('sol1').runAll;

model.result.create('pg1', 'PlotGroup3D');
model.result('pg1').set('data', 'dset1');
model.result('pg1').setIndex('looplevel', 176, 0);
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
model.result('pg2').setIndex('looplevel', 176, 0);
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
model.result('pg3').setIndex('looplevel', 176, 0);
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
model.result('pg1').run;
model.result('pg1').label('Displacement');
model.result('pg1').setIndex('looplevel', 86, 0);
model.result('pg1').run;
model.result('pg1').feature('vol1').set('expr', 'solid.disp');
model.result('pg1').feature('vol1').set('descr', 'Displacement magnitude');
model.result('pg1').feature('vol1').set('unit', 'nm');
model.result('pg1').run;
model.result('pg2').run;
model.result('pg2').setIndex('looplevel', 86, 0);
model.result('pg2').run;
model.result('pg2').feature('mslc1').set('multiplanexmethod', 'number');
model.result('pg2').feature('mslc1').set('xnumber', '5');
model.result('pg2').feature('mslc1').set('multiplaneymethod', 'number');
model.result('pg2').feature('mslc1').set('ynumber', '0');
model.result('pg2').feature('mslc1').set('multiplanezmethod', 'number');
model.result('pg2').feature('mslc1').set('znumber', '0');
model.result('pg2').run;
model.result('pg2').feature('strmsl1').set('multiplanexmethod', 'number');
model.result('pg2').feature('strmsl1').set('xnumber', '5');
model.result('pg2').feature('strmsl1').set('multiplaneymethod', 'number');
model.result('pg2').feature('strmsl1').set('ynumber', '0');
model.result('pg2').feature('strmsl1').set('multiplanezmethod', 'number');
model.result('pg2').feature('strmsl1').set('znumber', '0');
model.result('pg2').run;
model.result.create('pg4', 'PlotGroup1D');
model.result('pg4').run;
model.result('pg4').label('Mechanical Response');
model.result('pg4').create('ptgr1', 'PointGraph');
model.result('pg4').feature('ptgr1').set('markerpos', 'datapoints');
model.result('pg4').feature('ptgr1').set('linewidth', 'preference');
model.result('pg4').feature('ptgr1').selection.set([8]);
model.result('pg4').feature('ptgr1').set('expr', 'abs(u)');
model.result('pg4').feature('ptgr1').set('unit', 'nm');
model.result('pg4').feature('ptgr1').set('xdataparamunit', 'MHz');
model.result('pg4').run;

model.study.create('std2');
model.study('std2').create('frawe', 'FrequencyAdaptive');
model.study('std2').feature('frawe').set('plist', 'range(5.095[MHz],0.2[kHz],5.13[MHz])');
model.study('std2').feature('frawe').set('awefunctype', 'usercontrolled');
model.study('std2').feature('frawe').setIndex('awefunc', 'comp1.intop1(abs(comp1.u)/1e-9)', 0);
model.study('std2').feature('frawe').set('useadvanceddisable', true);
model.study('std2').feature('frawe').set('disabledphysics', {'es/term2'});
model.study('std2').feature('frawe').setEntry('outputmap', 'solid', 'selection');
model.study('std2').feature('frawe').setEntry('outputselectionmap', 'solid', 'sel1');
model.study('std2').feature('frawe').setEntry('outputmap', 'es', 'selection');
model.study('std2').feature('frawe').setEntry('outputselectionmap', 'es', 'sel1');
model.study('std2').create('param', 'Parametric');
model.study('std2').feature('param').setIndex('pname', 'Cs', 0);
model.study('std2').feature('param').setIndex('plistarr', '', 0);
model.study('std2').feature('param').setIndex('punit', 'F', 0);
model.study('std2').feature('param').setIndex('pname', 'Cs', 0);
model.study('std2').feature('param').setIndex('plistarr', '', 0);
model.study('std2').feature('param').setIndex('punit', 'F', 0);
model.study('std2').feature('param').setIndex('plistarr', '0.1 0.4 1', 0);
model.study('std2').feature('param').setIndex('punit', 'pF', 0);
model.study('std2').setGenPlots(false);

model.sol.create('sol2');
model.sol('sol2').study('std2');
model.sol('sol2').create('st1', 'StudyStep');
model.sol('sol2').feature('st1').set('study', 'std2');
model.sol('sol2').feature('st1').set('studystep', 'frawe');
model.sol('sol2').create('v1', 'Variables');
model.sol('sol2').feature('v1').set('control', 'frawe');
model.sol('sol2').create('aw1', 'AWE');
model.sol('sol2').feature('aw1').set('pname', 'freq');
model.sol('sol2').feature('aw1').set('plist', 'range(5.095[MHz],0.2[kHz],5.13[MHz])');
model.sol('sol2').feature('aw1').set('awefunc', {'comp1.intop1(abs(comp1.u)/1e-9)'});
model.sol('sol2').feature('aw1').set('rtol', 0.01);
model.sol('sol2').feature('aw1').set('plot', 'off');
model.sol('sol2').feature('aw1').set('plotgroup', 'pg1');
model.sol('sol2').feature('aw1').set('probesel', 'all');
model.sol('sol2').feature('aw1').set('probes', {});
model.sol('sol2').feature('aw1').feature('aDef').set('cachepattern', true);
model.sol('sol2').attach('std2');

model.batch.create('p1', 'Parametric');
model.batch('p1').study('std2');
model.batch('p1').create('so1', 'Solutionseq');
model.batch('p1').feature('so1').set('seq', 'sol2');
model.batch('p1').feature('so1').set('store', 'on');
model.batch('p1').feature('so1').set('clear', 'on');
model.batch('p1').feature('so1').set('psol', 'none');
model.batch('p1').set('pname', {'Cs'});
model.batch('p1').set('plistarr', {'0.1 0.4 1'});
model.batch('p1').set('sweeptype', 'sparse');
model.batch('p1').set('probesel', 'all');
model.batch('p1').set('probes', {});
model.batch('p1').set('plot', 'off');
model.batch('p1').set('err', 'on');
model.batch('p1').attach('std2');
model.batch('p1').set('control', 'param');

model.sol.create('sol3');
model.sol('sol3').study('std2');
model.sol('sol3').label('Parametric Solutions 1');

model.batch('p1').feature('so1').set('psol', 'sol3');
model.batch('p1').run('compute');

model.result('pg4').run;
model.result.duplicate('pg5', 'pg4');
model.result('pg5').run;
model.result('pg5').label('Mechanical response, Parametric');
model.result('pg5').set('data', 'dset3');
model.result('pg5').set('legendpos', 'upperleft');
model.result('pg5').run;
model.result('pg5').feature('ptgr1').set('legend', true);
model.result('pg5').run;

model.title('Thickness Shear Mode Quartz Oscillator');

model.description('A quartz oscillator, operated in the thickness shear mode, is simulated. The example shows how to set up the coordinate system correctly for AT cut quartz and to model the response of a device driven at resonance. The resonant frequency of the oscillator is altered by the changing the capacitance of a shunt capacitor.');

model.sol('sol1').clearSolutionData;
model.sol('sol2').clearSolutionData;
model.sol('sol3').clearSolutionData;
model.sol('sol4').clearSolutionData;
model.sol('sol5').clearSolutionData;
model.sol('sol6').clearSolutionData;

model.label('thickness_shear_quartz_oscillator.mph');

model.modelNode.label('Components');

out = model;
