function out = model
%
% surface_mount_resistor.m
%
% Model exported on May 26 2025, 21:28 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/Fatigue_Module/Energy_Based');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 2);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.physics.create('solid', 'SolidMechanics', 'geom1');
model.physics('solid').model('comp1');

model.study.create('std1');
model.study('std1').create('time', 'Transient');
model.study('std1').feature('time').setSolveFor('/physics/solid', true);

model.geom('geom1').insertFile('surface_mount_resistor_geom_sequence.mph', 'geom1');
model.geom('geom1').run('ige1');

model.func.create('int1', 'Interpolation');
model.func('int1').set('source', 'file');
model.func('int1').set('filename', 'surface_mount_resistor_thermal_load_cycle.txt');
model.func('int1').importData;
model.func('int1').set('funcname', 'thermLC');
model.func('int1').setIndex('argunit', 'min', 0);
model.func('int1').setIndex('fununit', 'degC', 0);

model.physics('solid').prop('d').set('d', '1.55 [mm]');
model.physics('solid').prop('StructuralTransientBehavior').set('StructuralTransientBehavior', 'Quasistatic');
model.physics('solid').feature('lemm1').set('CalculateDissipatedEnergy', true);
model.physics('solid').feature('lemm1').create('te1', 'ThermalExpansion', 2);
model.physics('solid').feature('lemm1').feature('te1').set('minput_temperature_src', 'userdef');
model.physics('solid').feature('lemm1').feature('te1').set('minput_temperature', 'thermLC(t)');
model.physics('solid').feature('lemm1').create('cmm1', 'Creep2', 2);
model.physics('solid').feature('lemm1').feature('cmm1').selection.named('geom1_csel2_dom');
model.physics('solid').feature('lemm1').feature('cmm1').set('minput_temperature_src', 'userdef');
model.physics('solid').feature('lemm1').feature('cmm1').set('minput_temperature', 'thermLC(t)');
model.physics('solid').feature('lemm1').feature('cmm1').set('materialModel', 'Garofalo');
model.physics('solid').feature('lemm1').feature('cmm1').set('thermalEffects', 'Arrhenius');
model.physics('solid').feature('lemm1').feature('cmm1').set('Q', 53200);
model.physics('solid').feature('lemm1').feature('cmm1').set('timeMethod', 'forwardEuler');
model.physics('solid').create('sym1', 'SymmetrySolid', 1);
model.physics('solid').feature('sym1').selection.set([19 20]);
model.physics('solid').create('roll1', 'Roller', 1);
model.physics('solid').feature('roll1').selection.set([2]);

model.material.create('mat1', 'Common', 'comp1');
model.material('mat1').label('PCB');
model.material('mat1').selection.named('geom1_r1_dom');
model.material('mat1').propertyGroup.create('Enu', 'Young''s_modulus_and_Poisson''s_ratio');
model.material('mat1').propertyGroup('Enu').set('E', {'22[GPa]'});
model.material('mat1').propertyGroup('Enu').set('nu', {'0.4'});
model.material('mat1').propertyGroup('def').set('density', {'0'});
model.material('mat1').propertyGroup('def').set('thermalexpansioncoefficient', {'21e-6'});
model.material.create('mat2', 'Common', 'comp1');
model.material('mat2').label('Copper');
model.material('mat2').selection.named('geom1_r3_dom');
model.material('mat2').propertyGroup.create('Enu', 'Young''s_modulus_and_Poisson''s_ratio');
model.material('mat2').propertyGroup('Enu').set('E', {'141[GPa]'});
model.material('mat2').propertyGroup('Enu').set('nu', {'0.35'});
model.material('mat2').propertyGroup('def').set('density', {'0'});
model.material('mat2').propertyGroup('def').set('thermalexpansioncoefficient', {'16.6e-6'});
model.material.create('mat3', 'Common', 'comp1');
model.material('mat3').label('Solder');
model.material('mat3').selection.named('geom1_csel2_dom');
model.material('mat3').propertyGroup.create('Enu', 'Young''s_modulus_and_Poisson''s_ratio');
model.material('mat3').propertyGroup('Enu').set('E', {'50[GPa]'});
model.material('mat3').propertyGroup('Enu').set('nu', {'0.4'});
model.material('mat3').propertyGroup('def').set('density', {'0'});
model.material('mat3').propertyGroup('def').set('thermalexpansioncoefficient', {'21e-6'});
model.material('mat3').propertyGroup.create('Garofalo', 'Garofalo');
model.material('mat3').propertyGroup('Garofalo').set('A_gar', {'262000'});
model.material('mat3').propertyGroup('Garofalo').set('sigRef_gar', {'39.1[MPa]'});
model.material('mat3').propertyGroup('Garofalo').set('n_gar', {'6.19'});
model.material.create('mat4', 'Common', 'comp1');
model.material('mat4').label('NiCr');
model.material('mat4').selection.named('geom1_csel1_dom');
model.material('mat4').propertyGroup.create('Enu', 'Young''s_modulus_and_Poisson''s_ratio');
model.material('mat4').propertyGroup('Enu').set('E', {'170[GPa]'});
model.material('mat4').propertyGroup('Enu').set('nu', {'0.31'});
model.material('mat4').propertyGroup('def').set('density', {'0'});
model.material('mat4').propertyGroup('def').set('thermalexpansioncoefficient', {'13e-6'});
model.material.create('mat5', 'Common', 'comp1');
model.material('mat5').label('Alumina');
model.material('mat5').selection.named('geom1_r2_dom');
model.material('mat5').propertyGroup.create('Enu', 'Young''s_modulus_and_Poisson''s_ratio');
model.material('mat5').propertyGroup('Enu').set('E', {'300[GPa]'});
model.material('mat5').propertyGroup('Enu').set('nu', {'0.22'});
model.material('mat5').propertyGroup('def').set('density', {'0'});
model.material('mat5').propertyGroup('def').set('thermalexpansioncoefficient', {'8e-6'});

model.mesh('mesh1').autoMeshSize(3);
model.mesh('mesh1').create('ftri1', 'FreeTri');
model.mesh('mesh1').feature('ftri1').create('dis1', 'Distribution');
model.mesh('mesh1').feature('ftri1').feature('dis1').selection.set([8]);
model.mesh('mesh1').feature('ftri1').feature('dis1').set('type', 'predefined');
model.mesh('mesh1').feature('ftri1').feature('dis1').set('elemcount', 50);
model.mesh('mesh1').feature('ftri1').feature('dis1').set('elemratio', 0.1);
model.mesh('mesh1').run;

model.study('std1').feature('time').set('tlist', 'range(0,10,60*60)');
model.study('std1').feature('time').set('usertol', true);
model.study('std1').feature('time').set('rtol', '1e-4');
model.study('std1').label('Time History');

model.sol.create('sol1');
model.sol('sol1').study('std1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'time');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').feature('comp1_u').set('scalemethod', 'manual');
model.sol('sol1').feature('v1').feature('comp1_u').set('scaleval', '1e-2*0.0034330198076911824');
model.sol('sol1').feature('v1').set('control', 'time');
model.sol('sol1').create('t1', 'Time');
model.sol('sol1').feature('t1').set('tlist', 'range(0,10,60*60)');
model.sol('sol1').feature('t1').set('plot', 'off');
model.sol('sol1').feature('t1').set('plotgroup', 'Default');
model.sol('sol1').feature('t1').set('plotfreq', 'tout');
model.sol('sol1').feature('t1').set('probesel', 'all');
model.sol('sol1').feature('t1').set('probes', {});
model.sol('sol1').feature('t1').set('probefreq', 'tsteps');
model.sol('sol1').feature('t1').set('rtol', 0.001);
model.sol('sol1').feature('t1').set('atolglobalvaluemethod', 'factor');
model.sol('sol1').feature('t1').set('reacf', true);
model.sol('sol1').feature('t1').set('storeudot', true);
model.sol('sol1').feature('t1').set('endtimeinterpolation', true);
model.sol('sol1').feature('t1').set('maxstepconstraintbdf', 'expr');
model.sol('sol1').feature('t1').set('maxstepexpressionbdf', 'comp1.solid.lemm1.cmm1.tmax');
model.sol('sol1').feature('t1').set('control', 'time');
model.sol('sol1').feature('t1').feature('aDef').set('cachepattern', true);
model.sol('sol1').feature('t1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('t1').feature('fc1').set('dtech', 'auto');
model.sol('sol1').feature('t1').feature('fc1').set('minstep', 0.5);
model.sol('sol1').feature('t1').feature('fc1').set('useminsteprecovery', 'on');
model.sol('sol1').feature('t1').feature('fc1').set('ntermauto', 'tol');
model.sol('sol1').feature('t1').feature('fc1').set('maxiter', 4);
model.sol('sol1').feature('t1').feature('fc1').set('ntolfact', 1);
model.sol('sol1').feature('t1').feature('fc1').set('linsolver', 'dDef');
model.sol('sol1').feature('t1').feature('fc1').set('dtech', 'auto');
model.sol('sol1').feature('t1').feature('fc1').set('minstep', 0.5);
model.sol('sol1').feature('t1').feature('fc1').set('useminsteprecovery', 'on');
model.sol('sol1').feature('t1').feature('fc1').set('ntermauto', 'tol');
model.sol('sol1').feature('t1').feature('fc1').set('maxiter', 4);
model.sol('sol1').feature('t1').feature('fc1').set('ntolfact', 1);
model.sol('sol1').feature('t1').feature.remove('fcDef');
model.sol('sol1').attach('std1');
model.sol('sol1').feature('t1').set('tstepsbdf', 'strict');
model.sol('sol1').runAll;

model.result.create('pg1', 'PlotGroup2D');
model.result('pg1').set('data', 'dset1');
model.result('pg1').setIndex('looplevel', 361, 0);
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
model.result('pg1').run;
model.result('pg1').run;
model.result('pg1').feature('surf1').set('unit', 'MPa');
model.result('pg1').run;
model.result('pg1').feature('surf1').feature('def').set('scaleactive', true);
model.result('pg1').feature('surf1').feature('def').set('scale', 20);
model.result.create('pg2', 'PlotGroup2D');
model.result('pg2').set('data', 'dset1');
model.result('pg2').setIndex('looplevel', 361, 0);
model.result('pg2').label('Equivalent Creep Strain (solid)');
model.result('pg2').set('defaultPlotID', 'equivalentCreepStrain');
model.result('pg2').create('surf1', 'Surface');
model.result('pg2').feature('surf1').set('expr', {'solid.eceGp'});
model.result('pg2').feature('surf1').set('inheritplot', 'none');
model.result('pg2').feature('surf1').set('resolution', 'normal');
model.result('pg2').feature('surf1').set('colortabletype', 'discrete');
model.result('pg2').feature('surf1').set('bandcount', 11);
model.result('pg2').feature('surf1').set('colortable', 'AuroraAustralisDark');
model.result('pg2').feature('surf1').set('descractive', true);
model.result('pg2').feature('surf1').set('descr', 'Equivalent creep strain');
model.result('pg2').label('Equivalent Creep Strain (solid)');
model.result('pg2').run;
model.result('pg2').run;
model.result.create('pg3', 'PlotGroup1D');
model.result('pg3').run;
model.result('pg3').label('Creep Strain');
model.result('pg3').create('ptgr1', 'PointGraph');
model.result('pg3').feature('ptgr1').set('markerpos', 'datapoints');
model.result('pg3').feature('ptgr1').set('linewidth', 'preference');
model.result('pg3').feature('ptgr1').selection.named('geom1_pt1_pnt');
model.result('pg3').feature('ptgr1').set('expr', 'solid.eceGp');
model.result('pg3').feature('ptgr1').set('descr', 'Equivalent creep strain');
model.result('pg3').feature('ptgr1').set('legend', true);
model.result('pg3').feature('ptgr1').set('legendmethod', 'manual');
model.result('pg3').feature('ptgr1').setIndex('legends', 'Effective', 0);
model.result('pg3').feature.duplicate('ptgr2', 'ptgr1');
model.result('pg3').run;
model.result('pg3').feature('ptgr2').set('expr', 'solid.eclGp12');
model.result('pg3').feature('ptgr2').set('descr', 'Creep strain tensor, local coordinate system, 12-component');
model.result('pg3').feature('ptgr2').setIndex('legends', 'Shear', 0);
model.result('pg3').run;
model.result('pg3').set('legendpos', 'upperleft');
model.result('pg3').run;
model.result.create('pg4', 'PlotGroup1D');
model.result('pg4').run;
model.result('pg4').label('Shear Hysteresis');
model.result('pg4').create('ptgr1', 'PointGraph');
model.result('pg4').feature('ptgr1').set('markerpos', 'datapoints');
model.result('pg4').feature('ptgr1').set('linewidth', 'preference');
model.result('pg4').feature('ptgr1').selection.named('geom1_pt1_pnt');
model.result('pg4').feature('ptgr1').set('expr', 'solid.sGpxy');
model.result('pg4').feature('ptgr1').set('descr', 'Stress tensor, xy-component');
model.result('pg4').feature('ptgr1').set('unit', 'MPa');
model.result('pg4').feature('ptgr1').set('xdata', 'expr');
model.result('pg4').feature('ptgr1').set('xdataexpr', 'solid.eclGp12');
model.result('pg4').feature('ptgr1').set('xdatadescr', 'Creep strain tensor, local coordinate system, 12-component');
model.result('pg4').run;

model.physics.create('ftg', 'Fatigue', 'geom1');
model.physics('ftg').model('comp1');

model.study('std1').feature('time').setSolveFor('/physics/ftg', false);

model.physics('ftg').label('Fatigue, Coffin-Manson');
model.physics('ftg').create('elif1', 'StrainLifeModel', 2);
model.physics('ftg').feature('elif1').selection.named('geom1_csel2_dom');
model.physics('ftg').feature('elif1').set('fatigueInputPhysics', 'solid');
model.physics('ftg').feature('elif1').set('ftgElifCrit', 'CoffinManson');
model.physics('ftg').feature('elif1').set('strainTypeCM', 'Creep');
model.physics.create('ftg2', 'Fatigue', 'geom1');
model.physics('ftg2').model('comp1');

model.study('std1').feature('time').setSolveFor('/physics/ftg2', false);

model.physics('ftg2').label('Fatigue, Morrow');
model.physics('ftg2').create('ener1', 'EnergyBasedModel', 2);
model.physics('ftg2').feature('ener1').selection.named('geom1_csel2_dom');
model.physics('ftg2').feature('ener1').set('fatigueInputPhysics', 'solid');
model.physics('ftg2').feature('ener1').set('ftgEnerType', 'Creep');

model.material('mat3').propertyGroup.create('fatigueEnergyMorrow', 'Morrow[Fatigue]');
model.material('mat3').propertyGroup.create('fatigueStrainCoffinManson', 'Coffin-Manson[Fatigue]');
model.material('mat3').propertyGroup('fatigueEnergyMorrow').set('Wf_Morrow', {'55e6[J/m^3]'});
model.material('mat3').propertyGroup('fatigueEnergyMorrow').set('m_Morrow', {'-0.69'});
model.material('mat3').propertyGroup('fatigueStrainCoffinManson').set('epsilonf_CM', {'0.218'});
model.material('mat3').propertyGroup('fatigueStrainCoffinManson').set('c_CM', {'-0.51'});

model.study.create('std2');
model.study('std2').create('ftge', 'Fatigue');
model.study('std2').feature('ftge').set('solnum', 'auto');
model.study('std2').feature('ftge').set('usesol', 'off');
model.study('std2').feature('ftge').setSolveFor('/physics/solid', false);
model.study('std2').feature('ftge').setSolveFor('/physics/ftg', true);
model.study('std2').feature('ftge').setSolveFor('/physics/ftg2', true);
model.study('std2').label('Fatigue');
model.study('std2').feature('ftge').set('usesol', true);
model.study('std2').feature('ftge').set('notsolmethod', 'sol');
model.study('std2').feature('ftge').set('notstudy', 'std1');
model.study('std2').feature('ftge').set('notsolnum', 'from_list');
model.study('std2').feature('ftge').set('notlistsolnum', [301 302 303 304 305 306 307 308 309 310 311 312 313 314 315 316 317 318 319 320 321 322 323 324 325 326 327 328 329 330 331 332 333 334 335 336 337 338 339 340 341 342 343 344 345 346 347 348 349 350 351 352 353 354 355 356 357 358 359 360 361]);

model.sol.create('sol2');
model.sol('sol2').study('std2');
model.sol('sol2').create('st1', 'StudyStep');
model.sol('sol2').feature('st1').set('study', 'std2');
model.sol('sol2').feature('st1').set('studystep', 'ftge');
model.sol('sol2').create('v1', 'Variables');
model.sol('sol2').feature('v1').set('control', 'ftge');
model.sol('sol2').create('s1', 'Stationary');
model.sol('sol2').attach('std2');
model.sol('sol2').runAll;

model.result.create('pg5', 'PlotGroup2D');
model.result('pg5').set('data', 'dset2');
model.result('pg5').create('surf1', 'Surface');
model.result('pg5').feature('surf1').set('expr', {'ftg.ctf'});
model.result('pg5').feature('surf1').set('colortable', 'Rainbow');
model.result('pg5').feature('surf1').set('colortabletrans', 'none');
model.result('pg5').feature('surf1').set('colorscalemode', 'logarithmic');
model.result('pg5').feature('surf1').set('colortablerev', true);
model.result('pg5').feature('surf1').set('colortable', 'Traffic');
model.result('pg5').label('Cycles to Failure (ftg)');
model.result('pg5').feature('surf1').create('mrkr1', 'Marker');
model.result('pg5').feature('surf1').feature('mrkr1').set('precision', 3);
model.result('pg5').feature('surf1').feature('mrkr1').set('display', 'min');
model.result.create('pg6', 'PlotGroup2D');
model.result('pg6').set('data', 'dset2');
model.result('pg6').create('surf1', 'Surface');
model.result('pg6').feature('surf1').set('expr', {'ftg2.ctf'});
model.result('pg6').feature('surf1').set('colortable', 'Rainbow');
model.result('pg6').feature('surf1').set('colortabletrans', 'none');
model.result('pg6').feature('surf1').set('colorscalemode', 'logarithmic');
model.result('pg6').feature('surf1').set('colortablerev', true);
model.result('pg6').feature('surf1').set('colortable', 'Traffic');
model.result('pg6').label('Cycles to Failure (ftg2)');
model.result('pg6').feature('surf1').create('mrkr1', 'Marker');
model.result('pg6').feature('surf1').feature('mrkr1').set('precision', 3);
model.result('pg6').feature('surf1').feature('mrkr1').set('display', 'min');
model.result('pg5').run;
model.result('pg5').label('Cycles to Failure, Coffin-Manson');
model.result('pg5').run;
model.result('pg5').feature('surf1').feature('mrkr1').set('anchorpoint', 'lowerright');
model.result('pg6').run;
model.result('pg6').label('Cycles to Failure, Morrow');
model.result('pg6').run;
model.result('pg6').feature('surf1').feature('mrkr1').set('anchorpoint', 'lowerright');
model.result('pg6').feature('surf1').feature('mrkr1').active(false);
model.result('pg6').feature('surf1').feature('mrkr1').active(true);
model.result('pg6').run;

model.title('Thermal Fatigue of a Surface Mount Resistor');

model.description('A surface mount resistor is subjected to thermal cycling. The solder joint, connecting the resistor to the printed circuit board, is the weakest link in the assembly. In order to assure structural integrity of the assembly a fatigue analysis based on the creep strain and the dissipated energy is performed.');

model.mesh.clearMeshes;

model.sol('sol1').clearSolutionData;
model.sol('sol2').clearSolutionData;

model.label('surface_mount_resistor.mph');

model.modelNode.label('Components');

out = model;
