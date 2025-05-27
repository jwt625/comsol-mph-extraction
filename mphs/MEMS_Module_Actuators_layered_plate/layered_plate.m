function out = model
%
% layered_plate.m
%
% Model exported on May 26 2025, 21:30 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/MEMS_Module/Actuators');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 2);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.physics.create('solid', 'SolidMechanics', 'geom1');
model.physics('solid').model('comp1');

model.study.create('std1');
model.study('std1').create('stat', 'Stationary');
model.study('std1').feature('stat').setSolveFor('/physics/solid', true);

model.param.set('Tdeposition', '800[degC]');
model.param.descr('Tdeposition', 'Coating deposition temperature');
model.param.set('Tepoxying', '150[degC]');
model.param.descr('Tepoxying', 'Temperature when the coating/substrate is epoxied to the carrier');
model.param.set('Troom', '20[degC]');
model.param.descr('Troom', 'Room temperature');
model.param.set('Temp', '1[K]');
model.param.descr('Temp', 'Temperature parameter');

model.geom('geom1').create('r1', 'Rectangle');
model.geom('geom1').feature('r1').set('size', [0.02 0.014]);
model.geom('geom1').feature('r1').setIndex('layername', 'Layer 1', 0);
model.geom('geom1').feature('r1').setIndex('layer', 0.002, 0);
model.geom('geom1').feature('r1').setIndex('layername', 'Layer 2', 1);
model.geom('geom1').feature('r1').setIndex('layer', 0.01, 1);
model.geom('geom1').runPre('fin');
model.geom('geom1').run;

model.physics('solid').feature('lemm1').create('te1', 'ThermalExpansion', 2);
model.physics('solid').feature('lemm1').feature('te1').set('minput_strainreferencetemperature_src', 'userdef');
model.physics('solid').feature('lemm1').feature('te1').set('minput_strainreferencetemperature', 'Tdeposition');
model.physics('solid').feature('lemm1').feature('te1').set('minput_temperature_src', 'userdef');
model.physics('solid').feature('lemm1').feature('te1').set('minput_temperature', 'Temp');
model.physics('solid').feature('lemm1').create('act1', 'Activation', 2);
model.physics('solid').feature('lemm1').feature('act1').selection.set([1]);
model.physics('solid').feature('lemm1').feature('act1').set('activation_expression', 'Temp<Tepoxying');
model.physics('solid').create('rms1', 'RigidMotionSuppression', 2);
model.physics('solid').feature('rms1').selection.set([2]);
model.physics('solid').create('wrp1', 'Warpage', 1);
model.physics('solid').feature('wrp1').selection.set([2]);

model.material.create('mat1', 'Common', 'comp1');
model.material('mat1').label('Carrier');
model.material('mat1').selection.set([1]);
model.material('mat1').propertyGroup.create('Enu', 'Young''s_modulus_and_Poisson''s_ratio');
model.material('mat1').propertyGroup('Enu').set('E', {'2.15e11'});
model.material('mat1').propertyGroup('Enu').set('nu', {'0.3'});
model.material('mat1').propertyGroup('def').set('density', {'1000'});
model.material('mat1').propertyGroup('def').set('thermalexpansioncoefficient', {'6e-6'});
model.material.create('mat2', 'Common', 'comp1');
model.material('mat2').label('Substrate');
model.material('mat2').selection.set([2]);
model.material('mat2').propertyGroup.create('Enu', 'Young''s_modulus_and_Poisson''s_ratio');
model.material('mat2').propertyGroup('Enu').set('E', {'1.3e11'});
model.material('mat2').propertyGroup('Enu').set('nu', {'0.28'});
model.material('mat2').propertyGroup('def').set('density', {'1000'});
model.material('mat2').propertyGroup('def').set('thermalexpansioncoefficient', {'3e-6'});
model.material.create('mat3', 'Common', 'comp1');
model.material('mat3').label('Coating');
model.material('mat3').selection.set([3]);
model.material('mat3').propertyGroup.create('Enu', 'Young''s_modulus_and_Poisson''s_ratio');
model.material('mat3').propertyGroup('Enu').set('E', {'7e10'});
model.material('mat3').propertyGroup('Enu').set('nu', {'0.17'});
model.material('mat3').propertyGroup('def').set('density', {'1000'});
model.material('mat3').propertyGroup('def').set('thermalexpansioncoefficient', {'5e-7'});

model.mesh('mesh1').create('map1', 'Map');
model.mesh('mesh1').feature('size').set('hauto', 2);
model.mesh('mesh1').run;

model.study('std1').feature('stat').set('useparam', true);
model.study('std1').feature('stat').setIndex('pname', 'Tdeposition', 0);
model.study('std1').feature('stat').setIndex('plistarr', '', 0);
model.study('std1').feature('stat').setIndex('punit', 'K', 0);
model.study('std1').feature('stat').setIndex('pname', 'Tdeposition', 0);
model.study('std1').feature('stat').setIndex('plistarr', '', 0);
model.study('std1').feature('stat').setIndex('punit', 'K', 0);
model.study('std1').feature('stat').setIndex('pname', 'Temp', 0);
model.study('std1').feature('stat').setIndex('plistarr', 'Tepoxying Troom', 0);
model.study('std1').feature('stat').setIndex('punit', 'K', 0);

model.sol.create('sol1');
model.sol('sol1').study('std1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'stat');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').set('control', 'stat');
model.sol('sol1').create('s1', 'Stationary');
model.sol('sol1').feature('s1').create('p1', 'Parametric');
model.sol('sol1').feature('s1').feature.remove('pDef');
model.sol('sol1').feature('s1').feature('p1').set('porder', 'constant');
model.sol('sol1').feature('s1').feature('p1').set('control', 'stat');
model.sol('sol1').feature('s1').set('control', 'stat');
model.sol('sol1').feature('s1').feature('aDef').set('cachepattern', true);
model.sol('sol1').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('s1').feature('fc1').set('termonres', 'auto');
model.sol('sol1').feature('s1').feature('fc1').set('reserrfact', 1000);
model.sol('sol1').feature('s1').feature('fc1').set('linsolver', 'dDef');
model.sol('sol1').feature('s1').feature('fc1').set('termonres', 'auto');
model.sol('sol1').feature('s1').feature('fc1').set('reserrfact', 1000);
model.sol('sol1').feature('s1').feature.remove('fcDef');
model.sol('sol1').attach('std1');
model.sol('sol1').runAll;

model.result.create('pg1', 'PlotGroup2D');
model.result('pg1').set('data', 'dset1');
model.result('pg1').setIndex('looplevel', 2, 0);
model.result('pg1').set('defaultPlotID', 'stress');
model.result('pg1').label('Stress (solid)');
model.result('pg1').set('frametype', 'spatial');
model.result('pg1').create('surf1', 'Surface');
model.result('pg1').feature('surf1').set('expr', {'solid.misesGp'});
model.result('pg1').feature('surf1').set('threshold', 'manual');
model.result('pg1').feature('surf1').set('thresholdvalue', 0.2);
model.result('pg1').feature('surf1').set('colortable', 'Rainbow');
model.result('pg1').feature('surf1').set('colortabletrans', 'none');
model.result('pg1').feature('surf1').set('colorscalemode', 'linear');
model.result('pg1').feature('surf1').set('resolution', 'normal');
model.result('pg1').feature('surf1').set('colortable', 'Prism');
model.result('pg1').feature('surf1').create('def', 'Deform');
model.result('pg1').feature('surf1').feature('def').set('expr', {'u' 'v'});
model.result('pg1').feature('surf1').feature('def').set('descr', 'Displacement field');
model.result('pg1').feature('surf1').create('filt1', 'Filter');
model.result('pg1').feature('surf1').feature('filt1').set('expr', 'solid.isactive');
model.result('pg1').run;
model.result('pg1').run;
model.result('pg1').feature('surf1').set('expr', 'solid.sGpx');
model.result('pg1').feature('surf1').set('unit', 'MPa');
model.result('pg1').feature('surf1').set('colortable', 'Rainbow');
model.result('pg1').run;
model.result('pg1').setIndex('looplevel', 1, 0);
model.result('pg1').run;
model.result('pg1').setIndex('looplevel', 2, 0);
model.result('pg1').run;
model.result.create('pg2', 'PlotGroup2D');
model.result('pg2').label('Warpage (wrp1)');
model.result('pg2').set('data', 'dset1');
model.result('pg2').setIndex('looplevel', 2, 0);
model.result('pg2').set('defaultPlotID', 'warpage|wrp1');
model.result('pg2').feature.create('line1', 'Line');
model.result('pg2').feature('line1').label('Warping Displacement');
model.result('pg2').feature('line1').set('expr', 'solid.wrp1.dispn_warp');
model.result('pg2').feature('line1').set('colortable', 'WaveLight');
model.result('pg2').feature('line1').set('colorscalemode', 'linearsymmetric');
model.result('pg2').feature('line1').set('smooth', 'internal');
model.result('pg2').feature('line1').set('showsolutionparams', 'on');
model.result('pg2').feature('line1').set('data', 'parent');
model.result('pg2').feature('line1').feature.create('def1', 'Deform');
model.result('pg2').feature('line1').feature('def1').set('expr', {'solid.wrp1.u' 'solid.wrp1.v'});
model.result('pg2').feature('line1').feature.create('mrkr1', 'Marker');
model.result('pg2').feature.create('line2', 'Line');
model.result('pg2').feature('line2').label('Average Displacement');
model.result('pg2').feature('line2').set('expr', 'solid.wrp1.disp_avg');
model.result('pg2').feature('line2').set('coloring', 'uniform');
model.result('pg2').feature('line2').set('color', 'gray');
model.result('pg2').feature('line2').set('smooth', 'internal');
model.result('pg2').feature('line2').set('inheritcolor', false);
model.result('pg2').feature('line2').set('inheritrange', false);
model.result('pg2').feature('line2').set('showsolutionparams', 'on');
model.result('pg2').feature('line2').set('data', 'parent');
model.result('pg2').feature('line2').set('inheritplot', 'line1');
model.result('pg2').feature('line2').feature.create('def1', 'Deform');
model.result('pg2').feature('line2').feature('def1').set('expr', {'solid.wrp1.u_avg' 'solid.wrp1.v_avg'});
model.result('pg2').label('Warpage (wrp1)');
model.result('pg2').run;
model.result('pg1').run;

model.title('Thermal Stresses in a Layered Plate');

model.description(['A plate consisting of two layers (a coating and a substrate layer) is stress and strain free at 800' native2unicode(hex2dec({'00' 'b0'}), 'unicode') 'C. The temperature of the plate is reduced to 150' native2unicode(hex2dec({'00' 'b0'}), 'unicode') 'C, which induces thermal stresses. A third layer, the carrier layer, is then activated in a stress-free state. The temperature is finally reduced to 20' native2unicode(hex2dec({'00' 'b0'}), 'unicode') 'C.']);

model.mesh.clearMeshes;

model.sol('sol1').clearSolutionData;

model.label('layered_plate.mph');

model.modelNode.label('Components');

out = model;
