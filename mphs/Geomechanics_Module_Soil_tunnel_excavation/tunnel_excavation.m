function out = model
%
% tunnel_excavation.m
%
% Model exported on May 26 2025, 21:28 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/Geomechanics_Module/Soil');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 2);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.physics.create('solid', 'SolidMechanics', 'geom1');
model.physics('solid').model('comp1');

model.study.create('std1');
model.study('std1').create('stat', 'Stationary');
model.study('std1').feature('stat').setSolveFor('/physics/solid', true);

model.geom('geom1').create('r1', 'Rectangle');
model.geom('geom1').feature('r1').set('size', [90 45]);
model.geom('geom1').feature('r1').set('pos', [0 -45]);
model.geom('geom1').run('r1');
model.geom('geom1').create('c1', 'Circle');
model.geom('geom1').feature('c1').set('r', 5);
model.geom('geom1').feature('c1').set('angle', 180);
model.geom('geom1').feature('c1').set('pos', [0 -20]);
model.geom('geom1').feature('c1').set('rot', 270);
model.geom('geom1').run('c1');
model.geom('geom1').run('fin');

model.physics('solid').feature('lemm1').set('MixedFormulation', 'pFormulation');
model.physics('solid').create('sym1', 'SymmetrySolid', 1);
model.physics('solid').feature('sym1').selection.set([1 3 4 5]);
model.physics('solid').create('fix1', 'Fixed', 1);
model.physics('solid').feature('fix1').selection.set([2]);
model.physics('solid').create('roll1', 'Roller', 1);
model.physics('solid').feature('roll1').selection.set([7]);
model.physics('solid').create('gacc1', 'GravityAcceleration', -1);
model.physics('solid').feature('lemm1').create('soil1', 'SoilModel', 2);
model.physics('solid').feature('lemm1').feature('soil1').set('MatchtoMC', true);
model.physics('solid').feature('lemm1').create('iss1', 'InitialStressandStrain', 2);
model.physics('solid').feature('lemm1').feature('iss1').set('Sil', {'withsol(''sol1'', solid.sx)' 'withsol(''sol1'', solid.sxy)' 'withsol(''sol1'', solid.sxz)' 'withsol(''sol1'', solid.sxy)' 'withsol(''sol1'', solid.sy)' 'withsol(''sol1'', solid.syz)' 'withsol(''sol1'', solid.sxz)' 'withsol(''sol1'', solid.syz)' 'withsol(''sol1'', solid.sz)'});
model.physics('solid').feature('lemm1').create('act1', 'Activation', 2);
model.physics('solid').feature('lemm1').feature('act1').selection.set([2]);
model.physics('solid').feature('lemm1').feature('act1').set('actfac', '1e-9');

model.material.create('mat1', 'Common', 'comp1');
model.material('mat1').propertyGroup.create('Enu', 'Young''s_modulus_and_Poisson''s_ratio');
model.material('mat1').propertyGroup('Enu').set('E', {'12[MPa]'});
model.material('mat1').propertyGroup('Enu').set('nu', {'0.495'});
model.material('mat1').propertyGroup('def').set('density', {'2000'});
model.material('mat1').propertyGroup.create('MohrCoulomb', 'Mohr_Coulomb_criterion');
model.material('mat1').propertyGroup('MohrCoulomb').set('cohesion', {'130[kPa]'});
model.material('mat1').propertyGroup('MohrCoulomb').set('internalphi', {'30[deg]'});

model.mesh('mesh1').create('ftri1', 'FreeTri');
model.mesh('mesh1').feature('size').set('hauto', 3);
model.mesh('mesh1').feature('ftri1').create('dis1', 'Distribution');
model.mesh('mesh1').feature('ftri1').feature('dis1').selection.set([8 9]);
model.mesh('mesh1').feature('ftri1').feature('dis1').set('numelem', 12);
model.mesh('mesh1').run;

model.study('std1').label('Study: Before Excavation');
model.study('std1').feature('stat').set('useadvanceddisable', true);
model.study('std1').feature('stat').set('disabledphysics', {'solid/lemm1/soil1' 'solid/lemm1/iss1' 'solid/lemm1/act1'});
model.study.create('std2');
model.study('std2').create('stat', 'Stationary');
model.study('std2').feature('stat').setSolveFor('/physics/solid', true);
model.study('std2').label('Study: After Excavation');

model.sol.create('sol1');
model.sol('sol1').study('std1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'stat');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').set('control', 'stat');
model.sol('sol1').create('s1', 'Stationary');
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

model.sol.create('sol2');
model.sol('sol2').study('std2');
model.sol('sol2').create('st1', 'StudyStep');
model.sol('sol2').feature('st1').set('study', 'std2');
model.sol('sol2').feature('st1').set('studystep', 'stat');
model.sol('sol2').create('v1', 'Variables');
model.sol('sol2').feature('v1').set('control', 'stat');
model.sol('sol2').create('s1', 'Stationary');
model.sol('sol2').feature('s1').feature('aDef').set('cachepattern', true);
model.sol('sol2').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol2').feature('s1').feature('fc1').set('termonres', 'auto');
model.sol('sol2').feature('s1').feature('fc1').set('reserrfact', 1000);
model.sol('sol2').feature('s1').feature('fc1').set('linsolver', 'dDef');
model.sol('sol2').feature('s1').feature('fc1').set('termonres', 'auto');
model.sol('sol2').feature('s1').feature('fc1').set('reserrfact', 1000);
model.sol('sol2').feature('s1').feature.remove('fcDef');
model.sol('sol2').attach('std2');
model.sol('sol2').runAll;

model.result.create('pg2', 'PlotGroup2D');
model.result('pg2').set('data', 'dset2');
model.result('pg2').set('defaultPlotID', 'stress');
model.result('pg2').label('Stress (solid) 1');
model.result('pg2').set('frametype', 'spatial');
model.result('pg2').create('surf1', 'Surface');
model.result('pg2').feature('surf1').set('expr', {'solid.misesGp'});
model.result('pg2').feature('surf1').set('threshold', 'manual');
model.result('pg2').feature('surf1').set('thresholdvalue', 0.2);
model.result('pg2').feature('surf1').set('colortable', 'Rainbow');
model.result('pg2').feature('surf1').set('colortabletrans', 'none');
model.result('pg2').feature('surf1').set('colorscalemode', 'linear');
model.result('pg2').feature('surf1').set('resolution', 'normal');
model.result('pg2').feature('surf1').set('colortable', 'Prism');
model.result('pg2').feature('surf1').create('def', 'Deform');
model.result('pg2').feature('surf1').feature('def').set('expr', {'u' 'v'});
model.result('pg2').feature('surf1').feature('def').set('descr', 'Displacement field');
model.result('pg2').feature('surf1').create('filt1', 'Filter');
model.result('pg2').feature('surf1').feature('filt1').set('expr', 'solid.isactive');
model.result('pg2').run;
model.result('pg1').run;
model.result('pg1').label('Stress: Before Excavation');
model.result('pg1').run;
model.result('pg1').run;
model.result('pg1').feature('surf1').feature('def').set('scaleactive', true);
model.result('pg1').feature('surf1').feature('def').set('scale', 1);
model.result('pg1').run;
model.result('pg2').run;
model.result('pg2').label('Stress: After Excavation');
model.result('pg2').run;
model.result('pg2').feature('surf1').feature('def').set('scaleactive', true);
model.result('pg2').feature('surf1').feature('def').set('scale', 1);
model.result('pg2').run;
model.result('pg2').feature('surf1').feature('filt1').set('nodespec', 'all');
model.result('pg2').run;
model.result.create('pg3', 'PlotGroup2D');
model.result('pg3').set('data', 'dset2');
model.result('pg3').label('Equivalent Plastic Strain (solid)');
model.result('pg3').set('defaultPlotID', 'equivalentPlasticStrain');
model.result('pg3').create('surf1', 'Surface');
model.result('pg3').feature('surf1').set('expr', {'solid.epeGp'});
model.result('pg3').feature('surf1').create('filt1', 'Filter');
model.result('pg3').feature('surf1').feature('filt1').set('expr', 'solid.isactive');
model.result('pg3').feature('surf1').set('inheritplot', 'none');
model.result('pg3').feature('surf1').set('resolution', 'normal');
model.result('pg3').feature('surf1').set('colortabletype', 'discrete');
model.result('pg3').feature('surf1').set('bandcount', 11);
model.result('pg3').feature('surf1').set('colortable', 'AuroraAustralisDark');
model.result('pg3').feature('surf1').set('descractive', true);
model.result('pg3').feature('surf1').set('descr', 'Equivalent plastic strain');
model.result('pg3').label('Equivalent Plastic Strain (solid)');
model.result('pg3').run;
model.result('pg3').label('Plastic Region: After Excavation');
model.result('pg3').run;
model.result('pg3').feature('surf1').set('expr', 'solid.epeGp>0');
model.result('pg3').feature('surf1').set('descractive', false);
model.result('pg3').feature('surf1').set('bandcount', 2);
model.result('pg3').feature('surf1').create('def1', 'Deform');
model.result('pg3').run;
model.result('pg3').feature('surf1').feature('def1').set('scaleactive', true);
model.result('pg3').feature('surf1').feature('def1').set('scale', 1);
model.result('pg3').run;
model.result('pg3').run;
model.result('pg3').selection.geom('geom1', 2);
model.result('pg3').selection.geom('geom1', 2);
model.result('pg3').selection.set([1]);
model.result('pg3').run;
model.result.create('pg4', 'PlotGroup1D');
model.result('pg4').run;
model.result('pg4').label('Horizontal Displacement: After Excavation');
model.result('pg4').set('data', 'dset2');
model.result('pg4').set('titletype', 'manual');
model.result('pg4').set('title', 'Horizontal displacement at surface');
model.result('pg4').set('xlabelactive', true);
model.result('pg4').set('xlabel', 'Distance from tunnel axis (m)');
model.result('pg4').set('ylabelactive', true);
model.result('pg4').set('ylabel', 'Horizontal displacement (mm)');
model.result('pg4').create('lngr1', 'LineGraph');
model.result('pg4').feature('lngr1').set('markerpos', 'datapoints');
model.result('pg4').feature('lngr1').set('linewidth', 'preference');
model.result('pg4').feature('lngr1').selection.set([6]);
model.result('pg4').feature('lngr1').set('expr', 'u');
model.result('pg4').feature('lngr1').set('unit', 'mm');
model.result('pg4').run;
model.result('pg4').run;
model.result.duplicate('pg5', 'pg4');
model.result('pg5').run;
model.result('pg5').label('Vertical Displacement: After Excavation');
model.result('pg5').set('title', 'Surface settlement');
model.result('pg5').set('ylabel', 'Vertical displacement (mm)');
model.result('pg5').run;
model.result('pg5').feature('lngr1').set('expr', 'v');
model.result('pg5').run;
model.result('pg1').run;

model.title('Tunnel Excavation');

model.description(['A common verification problem for geotechnical problems is tunnel excavation modeling. This example uses two studies. The first one computes the stress state of the soil before the tunnel excavation. In the second study a portion of soil is removed and the elasto-plastic behavior of the soil is computed with initial stresses taken from the first study. The soil is modeled as an elastic-perfectly plastic material using the Drucker' native2unicode(hex2dec({'20' '13'}), 'unicode') 'Prager yield condition.']);

model.label('tunnel_excavation.mph');

model.modelNode.label('Components');

out = model;
