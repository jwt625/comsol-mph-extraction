function out = model
%
% lemaitre_chaboche_viscoplastic_model.m
%
% Model exported on May 26 2025, 21:31 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/Nonlinear_Structural_Materials_Module/Viscoplasticity');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 2);
model.geom('geom1').model('comp1');
model.geom('geom1').axisymmetric(true);

model.mesh.create('mesh1', 'geom1');

model.physics.create('solid', 'SolidMechanics', 'geom1');
model.physics('solid').model('comp1');
model.physics.create('ev', 'Events', 'geom1');
model.physics('ev').model('comp1');

model.study.create('std1');
model.study('std1').create('time', 'Transient');
model.study('std1').feature('time').setSolveFor('/physics/solid', true);
model.study('std1').feature('time').setSolveFor('/physics/ev', true);

model.param.set('e0t', '1e-3[1/s]');
model.param.descr('e0t', 'Prescribed strain rate');
model.param.set('L0', '(35/2+14+10)[mm]');
model.param.descr('L0', 'Half length');
model.param.set('gamma0', '1200');
model.param.descr('gamma0', 'Initial kinematic hardening parameter');
model.param.set('gammas', '1540');
model.param.descr('gammas', 'Saturation kinematic hardening parameter');
model.param.set('beta', '1000');
model.param.descr('beta', 'Kinematic hardening parameter exponent');

model.func.create('step1', 'Step');
model.func('step1').set('location', '5[ms]');
model.func('step1').set('smooth', 0.01);

model.geom('geom1').lengthUnit('mm');
model.geom('geom1').create('r1', 'Rectangle');
model.geom('geom1').feature('r1').set('size', {'7/2' '35/2'});
model.geom('geom1').run('r1');
model.geom('geom1').create('r2', 'Rectangle');
model.geom('geom1').feature('r2').set('size', [5 10]);
model.geom('geom1').feature('r2').set('pos', [0 21.5]);
model.geom('geom1').run('r2');
model.geom('geom1').create('r3', 'Rectangle');
model.geom('geom1').feature('r3').set('size', [8 10]);
model.geom('geom1').feature('r3').set('pos', [0 31.5]);
model.geom('geom1').run('r3');
model.geom('geom1').create('ca1', 'CircularArc');
model.geom('geom1').feature('ca1').set('specify', 'endsangle1');
model.geom('geom1').feature('ca1').set('point1', [3.5 17.5]);
model.geom('geom1').feature('ca1').set('point2', [5 21.5]);
model.geom('geom1').feature('ca1').set('angle1', 180);
model.geom('geom1').feature('ca1').set('clockwise', true);
model.geom('geom1').run('ca1');
model.geom('geom1').create('pol1', 'Polygon');
model.geom('geom1').feature('pol1').set('source', 'table');
model.geom('geom1').feature('pol1').set('type', 'open');
model.geom('geom1').feature('pol1').set('source', 'vectors');
model.geom('geom1').feature('pol1').set('x', '5 0 0 3.5');
model.geom('geom1').feature('pol1').set('y', '21.5 21.5 17.5 17.5');
model.geom('geom1').run('pol1');
model.geom('geom1').create('csol1', 'ConvertToSolid');
model.geom('geom1').feature('csol1').selection('input').set({'ca1' 'pol1'});
model.geom('geom1').runPre('fin');

model.cpl.create('intop1', 'Integration', 'geom1');

model.geom('geom1').run;

model.cpl('intop1').set('axisym', true);
model.cpl('intop1').selection.geom('geom1', 0);
model.cpl('intop1').selection.set([6]);
model.cpl('intop1').set('axisym', false);

model.physics('ev').create('ds1', 'DiscreteStates', -1);
model.physics('ev').feature('ds1').setIndex('dim', 'LoadingType', 0, 0);
model.physics('ev').feature('ds1').setIndex('dimInit', 0, 0, 0);
model.physics('ev').feature('ds1').setIndex('dimInit', 1, 0, 0);
model.physics('ev').create('is1', 'IndicatorStates', -1);
model.physics('ev').feature('is1').label('Indicator States: Strain, Symmetric');
model.physics('ev').feature('is1').setIndex('indDim', 'Tension', 0, 0);
model.physics('ev').feature('is1').setIndex('g', 0, 0, 0);
model.physics('ev').feature('is1').setIndex('dimInit', 0, 0, 0);
model.physics('ev').feature('is1').setIndex('g', 'intop1(solid.el33)-0.004', 0, 0);
model.physics('ev').feature('is1').setIndex('dimInit', 0, 0, 0);
model.physics('ev').feature('is1').setIndex('dimDescr', '', 0, 0);
model.physics('ev').feature('is1').setIndex('indDim', 'Compression', 1, 0);
model.physics('ev').feature('is1').setIndex('g', 0, 1, 0);
model.physics('ev').feature('is1').setIndex('dimInit', 0, 1, 0);
model.physics('ev').feature('is1').setIndex('dimDescr', '', 1, 0);
model.physics('ev').feature('is1').setIndex('g', 'intop1(solid.el33)+0.004', 1, 0);
model.physics('ev').feature('is1').setIndex('dimInit', 0, 1, 0);
model.physics('ev').feature('is1').setIndex('dimDescr', '', 1, 0);
model.physics('ev').create('is2', 'IndicatorStates', -1);
model.physics('ev').feature('is2').label('Indicator States: Stress, Symmetric');
model.physics('ev').feature('is2').setIndex('indDim', 'Tension', 0, 0);
model.physics('ev').feature('is2').setIndex('g', 0, 0, 0);
model.physics('ev').feature('is2').setIndex('dimInit', 0, 0, 0);
model.physics('ev').feature('is2').setIndex('g', 'intop1(solid.sl33)-500[MPa]', 0, 0);
model.physics('ev').feature('is2').setIndex('dimInit', 0, 0, 0);
model.physics('ev').feature('is2').setIndex('dimDescr', '', 0, 0);
model.physics('ev').feature('is2').setIndex('indDim', 'Compression', 1, 0);
model.physics('ev').feature('is2').setIndex('g', 0, 1, 0);
model.physics('ev').feature('is2').setIndex('dimInit', 0, 1, 0);
model.physics('ev').feature('is2').setIndex('dimDescr', '', 1, 0);
model.physics('ev').feature('is2').setIndex('g', 'intop1(solid.sl33)+500[MPa]', 1, 0);
model.physics('ev').feature('is2').setIndex('dimInit', 0, 1, 0);
model.physics('ev').feature('is2').setIndex('dimDescr', '', 1, 0);
model.physics('ev').create('is3', 'IndicatorStates', -1);
model.physics('ev').feature('is3').label('Indicator States: Strain, Nonsymmetric');
model.physics('ev').feature('is3').setIndex('indDim', 'Tension', 0, 0);
model.physics('ev').feature('is3').setIndex('g', 0, 0, 0);
model.physics('ev').feature('is3').setIndex('dimInit', 0, 0, 0);
model.physics('ev').feature('is3').setIndex('g', 'intop1(solid.el33)-0.006', 0, 0);
model.physics('ev').feature('is3').setIndex('dimInit', 0, 0, 0);
model.physics('ev').feature('is3').setIndex('dimDescr', '', 0, 0);
model.physics('ev').feature('is3').setIndex('indDim', 'Compression', 1, 0);
model.physics('ev').feature('is3').setIndex('g', 0, 1, 0);
model.physics('ev').feature('is3').setIndex('dimInit', 0, 1, 0);
model.physics('ev').feature('is3').setIndex('dimDescr', '', 1, 0);
model.physics('ev').feature('is3').setIndex('g', 'intop1(solid.el33)+0.002', 1, 0);
model.physics('ev').feature('is3').setIndex('dimInit', 0, 1, 0);
model.physics('ev').feature('is3').setIndex('dimDescr', '', 1, 0);
model.physics('ev').create('is4', 'IndicatorStates', -1);
model.physics('ev').feature('is4').label('Indicator States: Stress, Nonsymmetric');
model.physics('ev').feature('is4').setIndex('indDim', 'Tension', 0, 0);
model.physics('ev').feature('is4').setIndex('g', 0, 0, 0);
model.physics('ev').feature('is4').setIndex('dimInit', 0, 0, 0);
model.physics('ev').feature('is4').setIndex('g', 'intop1(solid.sl33)-500[MPa]', 0, 0);
model.physics('ev').feature('is4').setIndex('dimInit', 0, 0, 0);
model.physics('ev').feature('is4').setIndex('dimDescr', '', 0, 0);
model.physics('ev').feature('is4').setIndex('indDim', 'Compression', 1, 0);
model.physics('ev').feature('is4').setIndex('g', 0, 1, 0);
model.physics('ev').feature('is4').setIndex('dimInit', 0, 1, 0);
model.physics('ev').feature('is4').setIndex('dimDescr', '', 1, 0);
model.physics('ev').feature('is4').setIndex('g', 'intop1(solid.sl33)+100[MPa]', 1, 0);
model.physics('ev').feature('is4').setIndex('dimInit', 0, 1, 0);
model.physics('ev').feature('is4').setIndex('dimDescr', '', 1, 0);
model.physics('ev').create('impl1', 'ImplicitEvent', -1);
model.physics('ev').feature('impl1').set('condition', 'Tension>0');
model.physics('ev').feature('impl1').setIndex('reInitName', 'LoadingType', 0, 0);
model.physics('ev').feature('impl1').setIndex('reInitValue', 0, 0, 0);
model.physics('ev').feature('impl1').setIndex('reInitValue', -1, 0, 0);
model.physics('ev').create('impl2', 'ImplicitEvent', -1);
model.physics('ev').feature('impl2').set('condition', 'Compression<0');
model.physics('ev').feature('impl2').setIndex('reInitName', 'LoadingType', 0, 0);
model.physics('ev').feature('impl2').setIndex('reInitValue', 0, 0, 0);
model.physics('ev').feature('impl2').setIndex('reInitValue', 1, 0, 0);
model.physics('solid').prop('StructuralTransientBehavior').set('StructuralTransientBehavior', 'Quasistatic');
model.physics('solid').create('symp1', 'SymmetryPlane', 1);
model.physics('solid').feature('symp1').selection.set([2]);
model.physics('solid').create('vel1', 'Velocity', 1);
model.physics('solid').feature('vel1').selection.set([9]);
model.physics('solid').feature('vel1').setIndex('Direction', true, 2);
model.physics('solid').feature('vel1').setIndex('v', 'e0t*L0*step1(t)*LoadingType', 2);
model.physics('solid').feature('lemm1').create('vpl1', 'Viscoplasticity', 2);
model.physics('solid').feature('lemm1').feature('vpl1').selection.set([1 2 3]);
model.physics('solid').feature('lemm1').feature('vpl1').set('ViscoplasticityModel', 'Chaboche');
model.physics('solid').feature('lemm1').feature('vpl1').set('IsotropicHardeningModel', 'Voce');
model.physics('solid').feature('lemm1').feature('vpl1').set('KinematicHardeningModel', 'ArmstrongFrederick');

model.material.create('mat1', 'Common', 'comp1');
model.material('mat1').propertyGroup.create('Enu', 'Young''s_modulus_and_Poisson''s_ratio');
model.material('mat1').propertyGroup('Enu').set('E', {'200[GPa]'});
model.material('mat1').propertyGroup('Enu').set('nu', {'0.3'});
model.material('mat1').propertyGroup('def').set('density', {'7500'});
model.material('mat1').propertyGroup.create('ChabocheViscoplasticity', 'Chaboche_viscoplasticity');
model.material('mat1').propertyGroup('ChabocheViscoplasticity').set('A_cha', {'1'});
model.material('mat1').propertyGroup('ChabocheViscoplasticity').set('sigRef_cha', {'490[MPa]'});
model.material('mat1').propertyGroup('ChabocheViscoplasticity').set('n_cha', {'9'});
model.material('mat1').propertyGroup.create('ElastoplasticModel', 'Elastoplastic_material_model');
model.material('mat1').propertyGroup('ElastoplasticModel').set('sigmags', {'60[MPa]'});
model.material('mat1').propertyGroup.create('Voce', '#Voce');
model.material('mat1').propertyGroup('Voce').set('sigma_voc', {'-35[MPa]'});
model.material('mat1').propertyGroup('Voce').set('beta_voc', {'200'});
model.material('mat1').propertyGroup.create('ArmstrongFrederick', '#Armstrong-Frederick');
model.material('mat1').propertyGroup('ArmstrongFrederick').set('Ck', {'362.5[GPa]'});
model.material('mat1').propertyGroup('ArmstrongFrederick').addInput('effectiveviscoplasticstrain');
model.material('mat1').propertyGroup('ArmstrongFrederick').set('gammak', {'gammas+(gamma0-gammas)*exp(-beta*evpe)'});

model.mesh('mesh1').create('map1', 'Map');
model.mesh('mesh1').feature('map1').create('dis1', 'Distribution');
model.mesh('mesh1').feature('map1').feature('dis1').selection.set([8]);
model.mesh('mesh1').feature('map1').feature('dis1').set('numelem', 4);
model.mesh('mesh1').feature('map1').create('dis2', 'Distribution');
model.mesh('mesh1').feature('map1').feature('dis2').selection.set([12]);
model.mesh('mesh1').feature('map1').feature('dis2').set('numelem', 2);
model.mesh('mesh1').feature('map1').create('dis3', 'Distribution');
model.mesh('mesh1').feature('map1').feature('dis3').selection.set([10]);
model.mesh('mesh1').feature('map1').feature('dis3').set('numelem', 16);
model.mesh('mesh1').feature('map1').feature('dis3').selection.set([1]);
model.mesh('mesh1').feature('map1').create('dis4', 'Distribution');
model.mesh('mesh1').feature('map1').feature('dis4').selection.set([3]);
model.mesh('mesh1').feature('map1').feature('dis4').set('numelem', 4);
model.mesh('mesh1').feature('map1').create('dis5', 'Distribution');
model.mesh('mesh1').feature('map1').feature('dis5').selection.set([5]);
model.mesh('mesh1').feature('map1').create('dis6', 'Distribution');
model.mesh('mesh1').feature('map1').feature('dis6').selection.set([7]);
model.mesh('mesh1').feature('map1').feature('dis6').set('numelem', 3);
model.mesh('mesh1').run;

model.study('std1').feature('time').set('tlist', '0 40');
model.study('std1').feature('time').set('useadvanceddisable', true);
model.study('std1').feature('time').set('disabledphysics', {'ev/is2' 'ev/is3' 'ev/is4'});

model.sol.create('sol1');
model.sol('sol1').study('std1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'time');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').feature('comp1_u').set('scalemethod', 'manual');
model.sol('sol1').feature('v1').feature('comp1_u').set('scaleval', '1e-2*0.042264050918008327');
model.sol('sol1').feature('v1').set('control', 'time');
model.sol('sol1').create('t1', 'Time');
model.sol('sol1').feature('t1').set('tlist', '0 40');
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
model.sol('sol1').feature('t1').set('control', 'time');
model.sol('sol1').feature('t1').feature('aDef').set('cachepattern', true);
model.sol('sol1').feature('t1').create('seDef', 'Segregated');
model.sol('sol1').feature('t1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('t1').feature('fc1').set('dtech', 'auto');
model.sol('sol1').feature('t1').feature('fc1').set('ntolfact', 1);
model.sol('sol1').feature('t1').feature('fc1').set('maxiter', 4);
model.sol('sol1').feature('t1').feature('fc1').set('ntermauto', 'tol');
model.sol('sol1').feature('t1').feature('fc1').set('minstep', 1.0E-4);
model.sol('sol1').feature('t1').feature('fc1').set('linsolver', 'dDef');
model.sol('sol1').feature('t1').feature('fc1').set('dtech', 'auto');
model.sol('sol1').feature('t1').feature('fc1').set('ntolfact', 1);
model.sol('sol1').feature('t1').feature('fc1').set('maxiter', 4);
model.sol('sol1').feature('t1').feature('fc1').set('ntermauto', 'tol');
model.sol('sol1').feature('t1').feature('fc1').set('minstep', 1.0E-4);
model.sol('sol1').feature('t1').feature.remove('fcDef');
model.sol('sol1').feature('t1').feature.remove('seDef');
model.sol('sol1').attach('std1');
model.sol('sol1').feature('t1').set('eventtol', 0.001);
model.sol('sol1').feature('t1').set('tout', 'tsteps');
model.sol('sol1').feature('t1').set('storeudot', false);

model.study('std1').label('Study 1, Prescribed Symmetric Strain');
model.study('std1').setGenPlots(false);

model.sol('sol1').runAll;

model.nodeGroup.create('grp1', 'Results');
model.nodeGroup('grp1').label('Prescribed Symmetric Strain');
model.nodeGroup('grp1').set('type', 'plotgroup');

model.result.create('pg1', 'PlotGroup1D');

model.nodeGroup('grp1').add('plotgroup', 'pg1');

model.result('pg1').run;
model.result('pg1').label('Stress vs. Strain 1');
model.result('pg1').set('xlabelactive', true);
model.result('pg1').set('xlabel', 'Axial strain (1)');
model.result('pg1').set('ylabelactive', true);
model.result('pg1').set('ylabel', 'Axial stress (MPa)');
model.result('pg1').set('titletype', 'manual');
model.result('pg1').set('title', 'Axial stress vs. axial strain');
model.result('pg1').create('ptgr1', 'PointGraph');
model.result('pg1').feature('ptgr1').set('markerpos', 'datapoints');
model.result('pg1').feature('ptgr1').set('linewidth', 'preference');
model.result('pg1').feature('ptgr1').selection.set([6]);
model.result('pg1').feature('ptgr1').set('expr', 'solid.slGp33');
model.result('pg1').feature('ptgr1').set('descr', 'Stress tensor, local coordinate system, 33-component');
model.result('pg1').feature('ptgr1').set('unit', 'MPa');
model.result('pg1').feature('ptgr1').set('xdata', 'expr');
model.result('pg1').feature('ptgr1').set('xdataexpr', 'solid.el33');
model.result('pg1').feature('ptgr1').set('xdatadescr', 'Strain tensor, local coordinate system, 33-component');
model.result('pg1').run;
model.result('pg1').run;
model.result('pg1').set('axislimits', true);
model.result('pg1').set('xmin', 0.0037);
model.result('pg1').set('xmax', 0.00405);
model.result('pg1').set('ymin', 475);
model.result('pg1').set('ymax', 505);
model.result('pg1').run;
model.result('pg1').set('axislimits', false);
model.result.create('pg2', 'PlotGroup1D');

model.nodeGroup('grp1').add('plotgroup', 'pg2');

model.result('pg2').run;
model.result('pg2').label('Stresses vs. Time 1');
model.result('pg2').set('titletype', 'manual');
model.result('pg2').set('title', 'Stresses vs. time');
model.result('pg2').create('ptgr1', 'PointGraph');
model.result('pg2').feature('ptgr1').set('markerpos', 'datapoints');
model.result('pg2').feature('ptgr1').set('linewidth', 'preference');
model.result('pg2').feature('ptgr1').selection.set([6]);
model.result('pg2').feature('ptgr1').set('expr', 'solid.slGp33');
model.result('pg2').feature('ptgr1').set('descr', 'Stress tensor, local coordinate system, 33-component');
model.result('pg2').feature('ptgr1').set('unit', 'MPa');
model.result('pg2').feature('ptgr1').set('titletype', 'none');
model.result('pg2').feature('ptgr1').set('legend', true);
model.result('pg2').feature('ptgr1').set('legendmethod', 'manual');
model.result('pg2').feature('ptgr1').setIndex('legends', 'Axial stress', 0);
model.result('pg2').feature.duplicate('ptgr2', 'ptgr1');
model.result('pg2').run;
model.result('pg2').feature('ptgr2').set('expr', 'max(0,solid.lemm1.vpl1.Fyield)');
model.result('pg2').feature('ptgr2').setIndex('legends', 'Viscous stress', 0);
model.result('pg2').feature.duplicate('ptgr3', 'ptgr2');
model.result('pg2').run;
model.result('pg2').feature('ptgr3').set('expr', 'solid.lemm1.vpl1.Sl_back33');
model.result('pg2').feature('ptgr3').setIndex('legends', 'Back stress', 0);
model.result('pg2').feature.duplicate('ptgr4', 'ptgr3');
model.result('pg2').run;
model.result('pg2').feature('ptgr4').set('expr', 'solid.lemm1.vpl1.sY');
model.result('pg2').feature('ptgr4').setIndex('legends', 'Yield strength', 0);
model.result('pg2').run;
model.result('pg2').set('ylabelactive', true);
model.result('pg2').set('ylabel', 'Stress (MPa)');
model.result('pg2').run;
model.result('pg2').set('axislimits', true);
model.result('pg2').set('xmin', 0);
model.result('pg2').set('xmax', 12);
model.result('pg2').run;
model.result('pg2').set('axislimits', false);
model.result.dataset.create('rev1', 'Revolve2D');
model.result.dataset.create('mir1', 'Mirror3D');
model.result.dataset('mir1').set('quickplane', 'xy');
model.result.create('pg3', 'PlotGroup3D');

model.nodeGroup('grp1').add('plotgroup', 'pg3');

model.result('pg3').run;
model.result('pg3').label('Equivalent Viscoplastic Strain 1');
model.result('pg3').set('data', 'mir1');
model.result('pg3').create('surf1', 'Surface');
model.result('pg3').feature('surf1').set('expr', 'solid.evpeGp');
model.result('pg3').feature('surf1').set('descr', 'Equivalent viscoplastic strain');
model.result('pg3').feature('surf1').set('colortable', 'AuroraAustralisDark');
model.result('pg3').feature('surf1').create('def1', 'Deform');
model.result('pg3').feature('surf1').feature('def1').set('revcoordsys', 'cylindrical');
model.result('pg3').run;
model.result('pg3').run;
model.result('pg3').create('surf2', 'Surface');
model.result('pg3').feature('surf2').set('expr', '0');
model.result('pg3').feature('surf2').set('titletype', 'none');
model.result('pg3').feature('surf2').set('inheritplot', 'surf1');
model.result('pg3').feature('surf2').create('def1', 'Deform');
model.result('pg3').feature('surf2').feature('def1').set('revcoordsys', 'cylindrical');
model.result('pg3').run;
model.result('pg3').run;
model.result('pg3').feature('surf2').create('filt1', 'Filter');
model.result('pg3').run;
model.result('pg3').feature('surf2').feature('filt1').set('expr', 'z>=31.5[mm]');
model.result('pg3').run;
model.result('pg3').run;

model.study.create('std2');
model.study('std2').create('time', 'Transient');
model.study('std2').feature('time').setSolveFor('/physics/solid', true);
model.study('std2').feature('time').setSolveFor('/physics/ev', true);
model.study('std2').feature('time').set('tlist', '0 40');
model.study('std2').feature('time').set('useadvanceddisable', true);
model.study('std2').feature('time').set('disabledphysics', {'ev/is1' 'ev/is3' 'ev/is4'});
model.study('std2').label('Study 2, Prescribed Symmetric Stress');
model.study('std2').setGenPlots(false);

model.sol.create('sol2');
model.sol('sol2').study('std2');
model.sol('sol2').create('st1', 'StudyStep');
model.sol('sol2').feature('st1').set('study', 'std2');
model.sol('sol2').feature('st1').set('studystep', 'time');
model.sol('sol2').create('v1', 'Variables');
model.sol('sol2').feature('v1').feature('comp1_u').set('scalemethod', 'manual');
model.sol('sol2').feature('v1').feature('comp1_u').set('scaleval', '1e-2*0.042264050918008327');
model.sol('sol2').feature('v1').set('control', 'time');
model.sol('sol2').create('t1', 'Time');
model.sol('sol2').feature('t1').set('tlist', '0 40');
model.sol('sol2').feature('t1').set('plot', 'off');
model.sol('sol2').feature('t1').set('plotgroup', 'pg1');
model.sol('sol2').feature('t1').set('plotfreq', 'tout');
model.sol('sol2').feature('t1').set('probesel', 'all');
model.sol('sol2').feature('t1').set('probes', {});
model.sol('sol2').feature('t1').set('probefreq', 'tsteps');
model.sol('sol2').feature('t1').set('rtol', 0.001);
model.sol('sol2').feature('t1').set('atolglobalvaluemethod', 'factor');
model.sol('sol2').feature('t1').set('reacf', true);
model.sol('sol2').feature('t1').set('storeudot', true);
model.sol('sol2').feature('t1').set('endtimeinterpolation', true);
model.sol('sol2').feature('t1').set('control', 'time');
model.sol('sol2').feature('t1').feature('aDef').set('cachepattern', true);
model.sol('sol2').feature('t1').create('seDef', 'Segregated');
model.sol('sol2').feature('t1').create('fc1', 'FullyCoupled');
model.sol('sol2').feature('t1').feature('fc1').set('dtech', 'auto');
model.sol('sol2').feature('t1').feature('fc1').set('ntolfact', 1);
model.sol('sol2').feature('t1').feature('fc1').set('maxiter', 4);
model.sol('sol2').feature('t1').feature('fc1').set('ntermauto', 'tol');
model.sol('sol2').feature('t1').feature('fc1').set('minstep', 1.0E-4);
model.sol('sol2').feature('t1').feature('fc1').set('linsolver', 'dDef');
model.sol('sol2').feature('t1').feature('fc1').set('dtech', 'auto');
model.sol('sol2').feature('t1').feature('fc1').set('ntolfact', 1);
model.sol('sol2').feature('t1').feature('fc1').set('maxiter', 4);
model.sol('sol2').feature('t1').feature('fc1').set('ntermauto', 'tol');
model.sol('sol2').feature('t1').feature('fc1').set('minstep', 1.0E-4);
model.sol('sol2').feature('t1').feature.remove('fcDef');
model.sol('sol2').feature('t1').feature.remove('seDef');
model.sol('sol2').attach('std2');
model.sol('sol2').feature('t1').set('eventtol', 0.001);
model.sol('sol2').feature('t1').set('tout', 'tsteps');
model.sol('sol2').feature('t1').set('storeudot', false);
model.sol('sol2').runAll;

model.result.dataset.create('rev2', 'Revolve2D');
model.result.dataset('rev2').set('data', 'dset2');
model.result.dataset.create('mir2', 'Mirror3D');
model.result.dataset('mir2').set('data', 'rev2');
model.result.dataset('mir2').set('quickplane', 'xy');

model.nodeGroup.duplicate('grp2', 'grp1');
model.nodeGroup('grp2').label('Prescribed Symmetric Stress');

model.result('pg4').run;
model.result('pg4').label('Stress vs. Strain 2');
model.result('pg4').set('data', 'dset2');
model.result('pg4').run;
model.result('pg4').set('axislimits', true);
model.result('pg4').set('xmin', 0.0036);
model.result('pg4').set('xmax', 0.0045);
model.result('pg4').set('ymin', 470);
model.result('pg4').set('ymax', 505);
model.result('pg4').run;
model.result('pg4').set('axislimits', false);
model.result('pg5').run;
model.result('pg5').label('Stresses vs. Time 2');
model.result('pg5').set('data', 'dset2');
model.result('pg6').run;
model.result('pg6').label('Equivalent Viscoplastic Strain 2');
model.result('pg6').set('data', 'mir2');
model.result('pg6').set('view', 'view3');
model.result('pg6').run;

model.study.create('std3');
model.study('std3').create('time', 'Transient');
model.study('std3').feature('time').setSolveFor('/physics/solid', true);
model.study('std3').feature('time').setSolveFor('/physics/ev', true);
model.study('std3').feature('time').set('tlist', '0 40');
model.study('std3').feature('time').set('useadvanceddisable', true);
model.study('std3').feature('time').set('disabledphysics', {'ev/is1' 'ev/is2' 'ev/is4'});

model.sol.create('sol3');
model.sol('sol3').study('std3');
model.sol('sol3').create('st1', 'StudyStep');
model.sol('sol3').feature('st1').set('study', 'std3');
model.sol('sol3').feature('st1').set('studystep', 'time');
model.sol('sol3').create('v1', 'Variables');
model.sol('sol3').feature('v1').feature('comp1_u').set('scalemethod', 'manual');
model.sol('sol3').feature('v1').feature('comp1_u').set('scaleval', '1e-2*0.042264050918008327');
model.sol('sol3').feature('v1').set('control', 'time');
model.sol('sol3').create('t1', 'Time');
model.sol('sol3').feature('t1').set('tlist', '0 40');
model.sol('sol3').feature('t1').set('plot', 'off');
model.sol('sol3').feature('t1').set('plotgroup', 'pg1');
model.sol('sol3').feature('t1').set('plotfreq', 'tout');
model.sol('sol3').feature('t1').set('probesel', 'all');
model.sol('sol3').feature('t1').set('probes', {});
model.sol('sol3').feature('t1').set('probefreq', 'tsteps');
model.sol('sol3').feature('t1').set('rtol', 0.001);
model.sol('sol3').feature('t1').set('atolglobalvaluemethod', 'factor');
model.sol('sol3').feature('t1').set('reacf', true);
model.sol('sol3').feature('t1').set('storeudot', true);
model.sol('sol3').feature('t1').set('endtimeinterpolation', true);
model.sol('sol3').feature('t1').set('control', 'time');
model.sol('sol3').feature('t1').feature('aDef').set('cachepattern', true);
model.sol('sol3').feature('t1').create('seDef', 'Segregated');
model.sol('sol3').feature('t1').create('fc1', 'FullyCoupled');
model.sol('sol3').feature('t1').feature('fc1').set('dtech', 'auto');
model.sol('sol3').feature('t1').feature('fc1').set('ntolfact', 1);
model.sol('sol3').feature('t1').feature('fc1').set('maxiter', 4);
model.sol('sol3').feature('t1').feature('fc1').set('ntermauto', 'tol');
model.sol('sol3').feature('t1').feature('fc1').set('minstep', 1.0E-4);
model.sol('sol3').feature('t1').feature('fc1').set('linsolver', 'dDef');
model.sol('sol3').feature('t1').feature('fc1').set('dtech', 'auto');
model.sol('sol3').feature('t1').feature('fc1').set('ntolfact', 1);
model.sol('sol3').feature('t1').feature('fc1').set('maxiter', 4);
model.sol('sol3').feature('t1').feature('fc1').set('ntermauto', 'tol');
model.sol('sol3').feature('t1').feature('fc1').set('minstep', 1.0E-4);
model.sol('sol3').feature('t1').feature.remove('fcDef');
model.sol('sol3').feature('t1').feature.remove('seDef');
model.sol('sol3').attach('std3');
model.sol('sol3').feature('t1').set('eventtol', 0.001);
model.sol('sol3').feature('t1').set('tout', 'tsteps');
model.sol('sol3').feature('t1').set('storeudot', false);

model.study('std3').label('Study 3, Prescribed Nonsymmetric Strain');
model.study('std3').setGenPlots(false);

model.sol('sol3').runAll;

model.result.dataset.create('rev3', 'Revolve2D');
model.result.dataset('rev3').set('data', 'dset3');
model.result.dataset.create('mir3', 'Mirror3D');
model.result.dataset('mir3').set('data', 'rev3');
model.result.dataset('mir3').set('quickplane', 'xy');

model.nodeGroup.duplicate('grp3', 'grp1');
model.nodeGroup('grp3').label('Prescribed Nonsymmetric Strain');

model.result('pg7').run;
model.result('pg7').label('Stress vs. Strain 3');
model.result('pg7').set('data', 'dset3');
model.result('pg7').run;
model.result('pg8').run;
model.result('pg8').label('Stresses vs. Time 3');
model.result('pg8').set('data', 'dset3');
model.result('pg9').run;
model.result('pg9').label('Equivalent Viscoplastic Strain 3');
model.result('pg9').set('data', 'mir3');
model.result('pg9').set('view', 'view3');
model.result('pg9').run;

model.study.create('std4');
model.study('std4').create('time', 'Transient');
model.study('std4').feature('time').setSolveFor('/physics/solid', true);
model.study('std4').feature('time').setSolveFor('/physics/ev', true);
model.study('std4').feature('time').set('tlist', '0 30');
model.study('std4').feature('time').set('useadvanceddisable', true);
model.study('std4').feature('time').set('disabledphysics', {'ev/is1' 'ev/is2' 'ev/is3'});

model.sol.create('sol4');
model.sol('sol4').study('std4');
model.sol('sol4').create('st1', 'StudyStep');
model.sol('sol4').feature('st1').set('study', 'std4');
model.sol('sol4').feature('st1').set('studystep', 'time');
model.sol('sol4').create('v1', 'Variables');
model.sol('sol4').feature('v1').feature('comp1_u').set('scalemethod', 'manual');
model.sol('sol4').feature('v1').feature('comp1_u').set('scaleval', '1e-2*0.042264050918008327');
model.sol('sol4').feature('v1').set('control', 'time');
model.sol('sol4').create('t1', 'Time');
model.sol('sol4').feature('t1').set('tlist', '0 30');
model.sol('sol4').feature('t1').set('plot', 'off');
model.sol('sol4').feature('t1').set('plotgroup', 'pg1');
model.sol('sol4').feature('t1').set('plotfreq', 'tout');
model.sol('sol4').feature('t1').set('probesel', 'all');
model.sol('sol4').feature('t1').set('probes', {});
model.sol('sol4').feature('t1').set('probefreq', 'tsteps');
model.sol('sol4').feature('t1').set('rtol', 0.001);
model.sol('sol4').feature('t1').set('atolglobalvaluemethod', 'factor');
model.sol('sol4').feature('t1').set('reacf', true);
model.sol('sol4').feature('t1').set('storeudot', true);
model.sol('sol4').feature('t1').set('endtimeinterpolation', true);
model.sol('sol4').feature('t1').set('control', 'time');
model.sol('sol4').feature('t1').feature('aDef').set('cachepattern', true);
model.sol('sol4').feature('t1').create('seDef', 'Segregated');
model.sol('sol4').feature('t1').create('fc1', 'FullyCoupled');
model.sol('sol4').feature('t1').feature('fc1').set('dtech', 'auto');
model.sol('sol4').feature('t1').feature('fc1').set('ntolfact', 1);
model.sol('sol4').feature('t1').feature('fc1').set('maxiter', 4);
model.sol('sol4').feature('t1').feature('fc1').set('ntermauto', 'tol');
model.sol('sol4').feature('t1').feature('fc1').set('minstep', 1.0E-4);
model.sol('sol4').feature('t1').feature('fc1').set('linsolver', 'dDef');
model.sol('sol4').feature('t1').feature('fc1').set('dtech', 'auto');
model.sol('sol4').feature('t1').feature('fc1').set('ntolfact', 1);
model.sol('sol4').feature('t1').feature('fc1').set('maxiter', 4);
model.sol('sol4').feature('t1').feature('fc1').set('ntermauto', 'tol');
model.sol('sol4').feature('t1').feature('fc1').set('minstep', 1.0E-4);
model.sol('sol4').feature('t1').feature.remove('fcDef');
model.sol('sol4').feature('t1').feature.remove('seDef');
model.sol('sol4').attach('std4');
model.sol('sol4').feature('t1').set('eventtol', 0.001);
model.sol('sol4').feature('t1').set('tout', 'tsteps');
model.sol('sol4').feature('t1').set('storeudot', false);

model.study('std4').label('Study 4, Prescribed Nonsymmetric Stress');
model.study('std4').setGenPlots(false);

model.sol('sol4').runAll;

model.result.dataset.create('rev4', 'Revolve2D');
model.result.dataset('rev4').set('data', 'dset4');
model.result.dataset.create('mir4', 'Mirror3D');
model.result.dataset('mir4').set('data', 'rev4');
model.result.dataset('mir4').set('quickplane', 'xy');

model.nodeGroup.duplicate('grp4', 'grp1');
model.nodeGroup('grp4').label('Prescribed Nonsymmetric Stress');

model.result('pg10').run;
model.result('pg10').label('Stress vs. Strain 4');
model.result('pg10').set('data', 'dset4');
model.result('pg10').run;
model.result('pg11').run;
model.result('pg11').label('Stresses vs. Time 4');
model.result('pg11').set('data', 'dset4');
model.result('pg12').run;
model.result('pg12').label('Equivalent Viscoplastic Strain 4');
model.result('pg12').set('data', 'mir4');
model.result('pg12').set('view', 'view3');
model.result('pg12').run;
model.result.export.create('anim1', 'Animation');
model.result.export('anim1').set('target', 'player');
model.result.export('anim1').set('fontsize', '9');
model.result.export('anim1').set('colortheme', 'globaltheme');
model.result.export('anim1').set('customcolor', [1 1 1]);
model.result.export('anim1').set('background', 'color');
model.result.export('anim1').set('gltfincludelines', 'on');
model.result.export('anim1').set('title1d', 'on');
model.result.export('anim1').set('legend1d', 'on');
model.result.export('anim1').set('logo1d', 'on');
model.result.export('anim1').set('options1d', 'on');
model.result.export('anim1').set('title2d', 'on');
model.result.export('anim1').set('legend2d', 'on');
model.result.export('anim1').set('logo2d', 'on');
model.result.export('anim1').set('options2d', 'off');
model.result.export('anim1').set('title3d', 'on');
model.result.export('anim1').set('legend3d', 'on');
model.result.export('anim1').set('logo3d', 'on');
model.result.export('anim1').set('options3d', 'off');
model.result.export('anim1').set('axisorientation', 'on');
model.result.export('anim1').set('grid', 'on');
model.result.export('anim1').set('axes1d', 'on');
model.result.export('anim1').set('axes2d', 'on');
model.result.export('anim1').set('showgrid', 'on');
model.result.export('anim1').showFrame;
model.result.export('anim1').label('Equivalent Viscoplastic Strain');
model.result.export('anim1').set('plotgroup', 'pg3');
model.result.export('anim1').set('maxframes', 50);
model.result.export('anim1').run;
model.result.create('pg13', 'PlotGroup3D');
model.result('pg13').run;
model.result('pg13').set('data', 'mir4');
model.result('pg13').set('titletype', 'none');
model.result('pg13').set('edges', false);
model.result('pg13').set('view', 'view3');
model.result('pg13').create('surf1', 'Surface');
model.result('pg13').feature('surf1').create('mtrl1', 'MaterialAppearance');
model.result('pg13').run;
model.result('pg13').feature('surf1').feature('mtrl1').set('appearance', 'custom');
model.result('pg13').feature('surf1').feature('mtrl1').set('family', 'steel');
model.result('pg13').run;
model.result('pg13').run;
model.result.remove('pg13');
model.result('pg3').run;

model.title(['Lemaitre' native2unicode(hex2dec({'20' '13'}), 'unicode') 'Chaboche Viscoplastic Model']);

model.description(['Most metals and alloys at high temperatures undergo viscoplastic deformation. In case of cyclic loading, a constitutive law with both isotropic and kinematic hardening is necessary to describe effects such as ratcheting, cyclic softening or hardening, and stress relaxation.' newline  newline 'This example demonstrates how to implement the Lemaitre' native2unicode(hex2dec({'20' '13'}), 'unicode') 'Chaboche viscoplastic constitutive law as a combination of isotropic hardening and a nonlinear kinematic hardening. This viscoplastic model is commonly used in areas such as additive manufacturing, laser welding, laser cutting, and thermal processing metals and alloys at high temperatures.']);

model.mesh.clearMeshes;

model.sol('sol1').clearSolutionData;
model.sol('sol2').clearSolutionData;
model.sol('sol3').clearSolutionData;
model.sol('sol4').clearSolutionData;

model.label('lemaitre_chaboche_viscoplastic_model.mph');

model.modelNode.label('Components');

out = model;
