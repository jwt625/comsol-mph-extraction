function out = model
%
% cylinder_roller_contact.m
%
% Model exported on May 26 2025, 21:34 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/Structural_Mechanics_Module/Verification_Examples');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 2);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.physics.create('solid', 'SolidMechanics', 'geom1');
model.physics('solid').model('comp1');

model.study.create('std1');
model.study('std1').create('stat', 'Stationary');
model.study('std1').feature('stat').setSolveFor('/physics/solid', true);

% To import content from file, use:
% model.param.loadFile('FILENAME');
model.param.set('E1', '70[GPa]', 'Block Young''s modulus');
model.param.set('E2', '210[GPa]', 'Cylinder Young''s modulus');
model.param.set('nu0', '0.3', 'Poisson''s ratio');
model.param.set('Fn', '35[kN]', 'External load');
model.param.set('E_star', '2*E1*E2/((E1+E2)*(1-nu0^2))', 'Combined Young''s modulus');
model.param.set('R', '50[mm]', 'Combined radius');
model.param.set('d', '200[mm]', 'Block width');
model.param.set('th', '1[mm]', 'Thickness');
model.param.set('lc', '10[mm]', 'Estimated contact length');
model.param.set('a', 'sqrt(8*Fn*R/(pi*E_star*th))', 'Analytical contact length');
model.param.set('pmax', 'sqrt(Fn*E_star/(2*pi*R*th))', 'Maximum contact pressure');
model.param.set('dist', '1[mm]', 'Initial distance between parts');
model.param.set('k', '0', 'Spring coefficient');

model.variable.create('var1');
model.variable('var1').model('comp1');

model.geom('geom1').run;

model.variable('var1').set('p_analytical', 'pmax*sqrt(1-(x/a)^2)');
model.variable('var1').descr('p_analytical', 'Analytical contact pressure');

model.geom('geom1').lengthUnit('mm');
model.geom('geom1').create('c1', 'Circle');
model.geom('geom1').feature('c1').set('r', 'R');
model.geom('geom1').feature('c1').set('angle', 180);
model.geom('geom1').feature('c1').set('pos', {'0' 'R+dist'});
model.geom('geom1').feature('c1').set('rot', -90);
model.geom('geom1').run('c1');
model.geom('geom1').create('r1', 'Rectangle');
model.geom('geom1').feature('r1').set('size', {'d/2' 'd'});
model.geom('geom1').feature('r1').set('pos', {'0' '-d'});
model.geom('geom1').feature('r1').setIndex('layername', 'Layer 1', 0);
model.geom('geom1').feature('r1').setIndex('layer', 'd/2', 0);
model.geom('geom1').run('r1');
model.geom('geom1').create('sq1', 'Square');
model.geom('geom1').feature('sq1').set('size', 'R/2');
model.geom('geom1').feature('sq1').set('pos', {'0' '-R/2'});
model.geom('geom1').run('sq1');
model.geom('geom1').create('pt1', 'Point');
model.geom('geom1').feature('pt1').setIndex('p', 'dist', 1);
model.geom('geom1').run('pt1');
model.geom('geom1').create('rot1', 'Rotate');
model.geom('geom1').feature('rot1').selection('input').set({'pt1'});
model.geom('geom1').feature('rot1').set('rot', 10);
model.geom('geom1').feature('rot1').set('pos', {'0' 'R+dist'});
model.geom('geom1').run('rot1');
model.geom('geom1').create('csol1', 'ConvertToSolid');
model.geom('geom1').feature('csol1').selection('input').set({'c1' 'r1' 'rot1' 'sq1'});
model.geom('geom1').run('csol1');
model.geom('geom1').feature('fin').set('action', 'assembly');
model.geom('geom1').feature('fin').set('createpairs', false);
model.geom('geom1').run('fin');
model.geom('geom1').create('mcd1', 'MeshControlDomains');
model.geom('geom1').feature('mcd1').selection('input').set('fin', [1 2 3]);
model.geom('geom1').run('mcd1');

model.pair.create('p1', 'Contact', 'geom1');
model.pair('p1').source.set([3]);
model.pair('p1').destination.set([7]);

model.physics('solid').prop('d').set('d', 'th');
model.physics('solid').create('sym1', 'SymmetrySolid', 1);
model.physics('solid').feature('sym1').selection.set([1 4 5]);
model.physics('solid').create('fix1', 'Fixed', 1);
model.physics('solid').feature('fix1').selection.set([2]);
model.physics('solid').create('pl1', 'PointLoad', 0);
model.physics('solid').feature('pl1').selection.set([5]);
model.physics('solid').feature('pl1').set('Fp', {'0' '-Fn/2' '0'});
model.physics('solid').create('spf1', 'SpringFoundation0', 0);
model.physics('solid').feature('spf1').selection.set([5]);
model.physics('solid').feature('spf1').set('kSpring', {'k' '0' '0' '0' 'k' '0' '0' '0' 'k'});

model.material.create('mat1', 'Common', 'comp1');
model.material('mat1').propertyGroup.create('Enu', 'Young''s_modulus_and_Poisson''s_ratio');
model.material('mat1').propertyGroup('Enu').set('E', {'E1'});
model.material('mat1').propertyGroup('Enu').set('nu', {'nu0'});
model.material('mat1').propertyGroup('def').set('density', {'1'});
model.material.create('mat2', 'Common', 'comp1');
model.material('mat2').selection.set([2]);
model.material('mat2').propertyGroup.create('Enu', 'Young''s_modulus_and_Poisson''s_ratio');
model.material('mat2').propertyGroup('Enu').set('E', {'E2'});
model.material('mat2').propertyGroup('Enu').set('nu', {'nu0'});
model.material('mat2').propertyGroup('def').set('density', {'1'});

model.physics('solid').feature('lemm1').set('geometricNonlinearity', 'linear');

model.mesh('mesh1').create('ftri1', 'FreeTri');
model.mesh('mesh1').feature('ftri1').selection.geom('geom1', 2);
model.mesh('mesh1').feature('ftri1').selection.set([2]);
model.mesh('mesh1').feature('ftri1').create('size1', 'Size');
model.mesh('mesh1').feature('ftri1').feature('size1').selection.geom('geom1', 1);
model.mesh('mesh1').feature('ftri1').feature('size1').selection.set([7]);
model.mesh('mesh1').feature('ftri1').feature('size1').set('custom', true);
model.mesh('mesh1').feature('ftri1').feature('size1').set('hmaxactive', true);
model.mesh('mesh1').feature('ftri1').feature('size1').set('hmax', 0.6);
model.mesh('mesh1').run;
model.mesh('mesh1').create('map1', 'Map');
model.mesh('mesh1').feature('map1').set('smoothcontrol', false);
model.mesh('mesh1').feature('map1').create('dis1', 'Distribution');
model.mesh('mesh1').feature('map1').feature('dis1').selection.set([3 10 11]);
model.mesh('mesh1').feature('map1').feature('dis1').set('numelem', 20);
model.mesh('mesh1').feature('map1').create('dis2', 'Distribution');
model.mesh('mesh1').feature('map1').feature('dis2').selection.set([1]);
model.mesh('mesh1').feature('map1').feature('dis2').set('numelem', 10);
model.mesh('mesh1').run;

model.study('std1').feature('stat').set('useparam', true);
model.study('std1').feature('stat').setIndex('pname', 'E1', 0);
model.study('std1').feature('stat').setIndex('plistarr', '', 0);
model.study('std1').feature('stat').setIndex('punit', 'Pa', 0);
model.study('std1').feature('stat').setIndex('pname', 'E1', 0);
model.study('std1').feature('stat').setIndex('plistarr', '', 0);
model.study('std1').feature('stat').setIndex('punit', 'Pa', 0);
model.study('std1').feature('stat').setIndex('pname', 'k', 0);
model.study('std1').feature('stat').setIndex('plistarr', 'Fn/dist/5 0', 0);
model.study('std1').feature('stat').setIndex('punit', 'N/m', 0);
model.study('std1').label('Study 1: Penalty');

model.sol.create('sol1');
model.sol('sol1').study('std1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'stat');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').feature('comp1_u').set('scalemethod', 'manual');
model.sol('sol1').feature('v1').feature('comp1_u').set('scaleval', '1e-2*0.3171766069558094');
model.sol('sol1').feature('v1').set('control', 'stat');
model.sol('sol1').create('s1', 'Stationary');
model.sol('sol1').feature('s1').create('p1', 'Parametric');
model.sol('sol1').feature('s1').feature.remove('pDef');
model.sol('sol1').feature('s1').feature('p1').set('porder', 'constant');
model.sol('sol1').feature('s1').feature('p1').set('control', 'stat');
model.sol('sol1').feature('s1').set('control', 'stat');
model.sol('sol1').feature('s1').feature('aDef').set('cachepattern', true);
model.sol('sol1').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('s1').feature('fc1').set('dtech', 'ddog');
model.sol('sol1').feature('s1').feature('fc1').set('linsolver', 'dDef');
model.sol('sol1').feature('s1').feature('fc1').set('dtech', 'ddog');
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
model.result('pg1').feature('surf1').feature('def').set('scaleactive', true);
model.result('pg1').feature('surf1').feature('def').set('scale', '1');
model.result('pg1').feature('surf1').feature('def').set('expr', {'u' 'v'});
model.result('pg1').feature('surf1').feature('def').set('descr', 'Displacement field');
model.result('pg1').run;
model.result('pg1').run;
model.result('pg1').feature('surf1').set('unit', 'MPa');
model.result('pg1').run;
model.result('pg1').feature('surf1').set('rangecoloractive', true);
model.result('pg1').feature('surf1').set('rangecolormax', 2500);
model.result('pg1').run;

model.view('view1').axis.set('xmin', -20);
model.view('view1').axis.set('xmax', 60);
model.view('view1').axis.set('ymin', -40);
model.view('view1').axis.set('ymax', 40);

model.result.create('pg2', 'PlotGroup1D');
model.result('pg2').run;
model.result('pg2').label('Contact Pressure');
model.result('pg2').setIndex('looplevelinput', 'last', 0);
model.result('pg2').set('titletype', 'label');
model.result('pg2').create('lngr1', 'LineGraph');
model.result('pg2').feature('lngr1').set('markerpos', 'datapoints');
model.result('pg2').feature('lngr1').set('linewidth', 'preference');
model.result('pg2').feature('lngr1').selection.set([7]);
model.result('pg2').feature('lngr1').set('expr', 'p_analytical');
model.result('pg2').feature('lngr1').set('descr', 'Analytical contact pressure');
model.result('pg2').feature('lngr1').set('unit', 'MPa');
model.result('pg2').feature('lngr1').set('xdataexpr', 'x');
model.result('pg2').feature('lngr1').set('xdatadescr', 'x-coordinate');
model.result('pg2').feature('lngr1').set('linestyle', 'dashed');
model.result('pg2').feature('lngr1').set('linewidth', 2);
model.result('pg2').feature('lngr1').set('legend', true);
model.result('pg2').feature('lngr1').set('legendmethod', 'manual');
model.result('pg2').feature('lngr1').setIndex('legends', 'Analytical', 0);
model.result('pg2').run;
model.result('pg2').feature.duplicate('lngr2', 'lngr1');
model.result('pg2').run;
model.result('pg2').feature('lngr2').set('expr', 'gpeval(4,solid.Tn)');
model.result('pg2').feature('lngr2').set('linestyle', 'solid');
model.result('pg2').feature('lngr2').setIndex('legends', 'Computed (Penalty)', 0);
model.result('pg2').feature('lngr2').set('resolution', 'norefine');
model.result('pg2').run;
model.result('pg2').set('xlabelactive', true);
model.result('pg2').set('xlabel', 'Distance from center (mm)');
model.result('pg2').set('ylabelactive', true);
model.result('pg2').set('ylabel', 'Contact pressure (MPa)');
model.result('pg2').run;

model.physics('solid').create('cnt1', 'SolidContact', 1);
model.physics('solid').feature('cnt1').set('pairs', {'p1'});
model.physics('solid').feature('cnt1').set('ContactMethodCtrl', 'AugmentedLagrange');
model.physics('solid').feature.duplicate('cnt2', 'cnt1');
model.physics('solid').feature('cnt2').set('SolutionMethod', 'coupled');

model.study.create('std2');
model.study('std2').create('stat', 'Stationary');
model.study('std2').feature('stat').setSolveFor('/physics/solid', true);
model.study('std2').feature('stat').set('useadvanceddisable', true);
model.study('std2').feature('stat').set('disabledphysics', {'solid/cnt2'});
model.study('std2').feature('stat').set('useparam', true);
model.study('std2').feature('stat').setIndex('pname', 'E1', 0);
model.study('std2').feature('stat').setIndex('plistarr', '', 0);
model.study('std2').feature('stat').setIndex('punit', 'Pa', 0);
model.study('std2').feature('stat').setIndex('pname', 'E1', 0);
model.study('std2').feature('stat').setIndex('plistarr', '', 0);
model.study('std2').feature('stat').setIndex('punit', 'Pa', 0);
model.study('std2').feature('stat').setIndex('pname', 'k', 0);
model.study('std2').feature('stat').setIndex('plistarr', 'Fn/dist/5 0', 0);
model.study('std2').feature('stat').setIndex('punit', 'N/m', 0);
model.study('std2').setGenPlots(false);
model.study('std2').label('Study 2: Augmented Lagrangian, Segregated');

model.sol.create('sol2');
model.sol('sol2').study('std2');
model.sol('sol2').create('st1', 'StudyStep');
model.sol('sol2').feature('st1').set('study', 'std2');
model.sol('sol2').feature('st1').set('studystep', 'stat');
model.sol('sol2').create('v1', 'Variables');
model.sol('sol2').feature('v1').feature('comp1_solid_Tn_p1').set('scalemethod', 'manual');
model.sol('sol2').feature('v1').feature('comp1_u').set('scalemethod', 'manual');
model.sol('sol2').feature('v1').feature('comp1_solid_Tn_p1').set('scaleval', '100000000');
model.sol('sol2').feature('v1').feature('comp1_u').set('scaleval', '1e-2*0.3171766069558094');
model.sol('sol2').feature('v1').set('control', 'stat');
model.sol('sol2').create('s1', 'Stationary');
model.sol('sol2').feature('s1').create('p1', 'Parametric');
model.sol('sol2').feature('s1').feature.remove('pDef');
model.sol('sol2').feature('s1').feature('p1').set('porder', 'constant');
model.sol('sol2').feature('s1').feature('p1').set('control', 'stat');
model.sol('sol2').feature('s1').set('control', 'stat');
model.sol('sol2').feature('s1').feature('aDef').set('cachepattern', true);
model.sol('sol2').feature('s1').create('se1', 'Segregated');
model.sol('sol2').feature('s1').feature('se1').feature.remove('ssDef');
model.sol('sol2').feature('s1').feature('se1').create('ss1', 'SegregatedStep');
model.sol('sol2').feature('s1').feature('se1').feature('ss1').set('segvar', {'comp1_u'});
model.sol('sol2').feature('s1').feature('se1').feature('ss1').set('subdtech', 'ddog');
model.sol('sol2').feature('s1').feature('se1').feature('ss1').set('subtermauto', 'itertol');
model.sol('sol2').feature('s1').feature('se1').feature('ss1').set('subiter', 7);
model.sol('sol2').feature('s1').feature('se1').feature('ss1').set('subntolfact', 1);
model.sol('sol2').feature('s1').feature('se1').feature('ss1').set('linsolver', 'dDef');
model.sol('sol2').feature('s1').feature('se1').feature('ss1').label('Solid Mechanics');
model.sol('sol2').feature('s1').feature('se1').create('ls1', 'LumpedStep');
model.sol('sol2').feature('s1').feature('se1').feature('ls1').set('segvar', {'comp1_solid_Tn_p1'});
model.sol('sol2').feature('s1').feature('se1').set('maxsegiter', 15);
model.sol('sol2').feature('s1').feature.remove('fcDef');
model.sol('sol2').attach('std2');
model.sol('sol2').feature('v1').feature('comp1_solid_Tn_p1').set('scaleval', '1e9');
model.sol('sol2').runAll;

model.study.create('std3');
model.study('std3').create('stat', 'Stationary');
model.study('std3').feature('stat').setSolveFor('/physics/solid', true);
model.study('std3').feature('stat').set('useparam', true);
model.study('std3').feature('stat').setIndex('pname', 'E1', 0);
model.study('std3').feature('stat').setIndex('plistarr', '', 0);
model.study('std3').feature('stat').setIndex('punit', 'Pa', 0);
model.study('std3').feature('stat').setIndex('pname', 'E1', 0);
model.study('std3').feature('stat').setIndex('plistarr', '', 0);
model.study('std3').feature('stat').setIndex('punit', 'Pa', 0);
model.study('std3').feature('stat').setIndex('pname', 'k', 0);
model.study('std3').feature('stat').setIndex('plistarr', 'Fn/dist/5 0', 0);
model.study('std3').feature('stat').setIndex('punit', 'N/m', 0);
model.study('std3').setGenPlots(false);
model.study('std3').label('Study 3: Augmented Lagrangian, Coupled');

model.sol.create('sol3');
model.sol('sol3').study('std3');
model.sol('sol3').create('st1', 'StudyStep');
model.sol('sol3').feature('st1').set('study', 'std3');
model.sol('sol3').feature('st1').set('studystep', 'stat');
model.sol('sol3').create('v1', 'Variables');
model.sol('sol3').feature('v1').feature('comp1_solid_Tn_p1').set('scalemethod', 'manual');
model.sol('sol3').feature('v1').feature('comp1_u').set('scalemethod', 'manual');
model.sol('sol3').feature('v1').feature('comp1_solid_Tn_p1').set('scaleval', '100000000');
model.sol('sol3').feature('v1').feature('comp1_u').set('scaleval', '1e-2*0.3171766069558094');
model.sol('sol3').feature('v1').set('control', 'stat');
model.sol('sol3').create('s1', 'Stationary');
model.sol('sol3').feature('s1').create('p1', 'Parametric');
model.sol('sol3').feature('s1').feature.remove('pDef');
model.sol('sol3').feature('s1').feature('p1').set('porder', 'constant');
model.sol('sol3').feature('s1').feature('p1').set('control', 'stat');
model.sol('sol3').feature('s1').set('control', 'stat');
model.sol('sol3').feature('s1').feature('aDef').set('cachepattern', true);
model.sol('sol3').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol3').feature('s1').feature('fc1').set('dtech', 'ddog');
model.sol('sol3').feature('s1').feature('fc1').set('linsolver', 'dDef');
model.sol('sol3').feature('s1').feature('fc1').set('dtech', 'ddog');
model.sol('sol3').feature('s1').feature.remove('fcDef');
model.sol('sol3').attach('std3');
model.sol('sol3').feature('v1').feature('comp1_solid_Tn_p1').set('scaleval', '1e9');
model.sol('sol3').runAll;

model.result('pg2').run;
model.result('pg2').feature.duplicate('lngr3', 'lngr2');
model.result('pg2').run;
model.result('pg2').feature('lngr3').set('data', 'dset2');
model.result('pg2').feature('lngr3').setIndex('looplevelinput', 'last', 0);
model.result('pg2').feature('lngr3').setIndex('legends', 'Computed (Augmented Lagrangian, seg.)', 0);
model.result('pg2').feature.duplicate('lngr4', 'lngr3');
model.result('pg2').run;
model.result('pg2').feature('lngr4').set('data', 'dset3');
model.result('pg2').feature('lngr4').setIndex('legends', 'Computed (Augmented Lagrangian, cpl.)', 0);
model.result('pg2').run;

model.physics('solid').create('cnt3', 'SolidContact', 1);
model.physics('solid').feature('cnt3').set('pairs', {'p1'});
model.physics('solid').feature('cnt3').set('ContactMethodCtrl', 'Nitsche');

model.study.create('std4');
model.study('std4').create('stat', 'Stationary');
model.study('std4').feature('stat').setSolveFor('/physics/solid', true);
model.study('std4').feature('stat').set('useparam', true);
model.study('std4').feature('stat').setIndex('pname', 'E1', 0);
model.study('std4').feature('stat').setIndex('plistarr', '', 0);
model.study('std4').feature('stat').setIndex('punit', 'Pa', 0);
model.study('std4').feature('stat').setIndex('pname', 'E1', 0);
model.study('std4').feature('stat').setIndex('plistarr', '', 0);
model.study('std4').feature('stat').setIndex('punit', 'Pa', 0);
model.study('std4').feature('stat').setIndex('pname', 'k', 0);
model.study('std4').feature('stat').setIndex('plistarr', 'Fn/dist/5 0', 0);
model.study('std4').feature('stat').setIndex('punit', 'N/m', 0);
model.study('std4').setGenPlots(false);
model.study('std4').label('Study 4: Nitsche');

model.sol.create('sol4');
model.sol('sol4').study('std4');
model.sol('sol4').create('st1', 'StudyStep');
model.sol('sol4').feature('st1').set('study', 'std4');
model.sol('sol4').feature('st1').set('studystep', 'stat');
model.sol('sol4').create('v1', 'Variables');
model.sol('sol4').feature('v1').feature('comp1_u').set('scalemethod', 'manual');
model.sol('sol4').feature('v1').feature('comp1_u').set('scaleval', '1e-2*0.3171766069558094');
model.sol('sol4').feature('v1').set('control', 'stat');
model.sol('sol4').create('s1', 'Stationary');
model.sol('sol4').feature('s1').create('p1', 'Parametric');
model.sol('sol4').feature('s1').feature.remove('pDef');
model.sol('sol4').feature('s1').feature('p1').set('porder', 'constant');
model.sol('sol4').feature('s1').feature('p1').set('control', 'stat');
model.sol('sol4').feature('s1').set('control', 'stat');
model.sol('sol4').feature('s1').feature('aDef').set('cachepattern', true);
model.sol('sol4').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol4').feature('s1').feature('fc1').set('dtech', 'ddog');
model.sol('sol4').feature('s1').feature('fc1').set('linsolver', 'dDef');
model.sol('sol4').feature('s1').feature('fc1').set('dtech', 'ddog');
model.sol('sol4').feature('s1').feature.remove('fcDef');
model.sol('sol4').attach('std4');
model.sol('sol4').study('std4');
model.sol('sol4').feature.remove('s1');
model.sol('sol4').feature.remove('v1');
model.sol('sol4').feature.remove('st1');
model.sol('sol4').create('st1', 'StudyStep');
model.sol('sol4').feature('st1').set('study', 'std4');
model.sol('sol4').feature('st1').set('studystep', 'stat');
model.sol('sol4').create('v1', 'Variables');
model.sol('sol4').feature('v1').feature('comp1_u').set('scalemethod', 'manual');
model.sol('sol4').feature('v1').feature('comp1_u').set('scaleval', '1e-2*0.3171766069558094');
model.sol('sol4').feature('v1').set('control', 'stat');
model.sol('sol4').create('s1', 'Stationary');
model.sol('sol4').feature('s1').create('p1', 'Parametric');
model.sol('sol4').feature('s1').feature.remove('pDef');
model.sol('sol4').feature('s1').feature('p1').set('porder', 'constant');
model.sol('sol4').feature('s1').feature('p1').set('control', 'stat');
model.sol('sol4').feature('s1').set('control', 'stat');
model.sol('sol4').feature('s1').feature('aDef').set('cachepattern', true);
model.sol('sol4').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol4').feature('s1').feature('fc1').set('dtech', 'ddog');
model.sol('sol4').feature('s1').feature('fc1').set('linsolver', 'dDef');
model.sol('sol4').feature('s1').feature('fc1').set('dtech', 'ddog');
model.sol('sol4').feature('s1').feature.remove('fcDef');
model.sol('sol4').attach('std4');
model.sol('sol4').runAll;

model.result('pg2').run;
model.result('pg2').feature.duplicate('lngr5', 'lngr4');
model.result('pg2').run;
model.result('pg2').feature('lngr5').set('data', 'dset4');
model.result('pg2').feature('lngr5').set('expr', 'gpeval(8,solid.Tn)');
model.result('pg2').feature('lngr5').setIndex('legends', 'Computed (Nitsche)', 0);
model.result('pg2').run;

model.study('std1').feature('stat').set('useadvanceddisable', true);
model.study('std1').feature('stat').set('disabledphysics', {'solid/cnt1' 'solid/cnt2' 'solid/cnt3'});
model.study('std2').feature('stat').set('disabledphysics', {'solid/cnt2' 'solid/cnt3'});
model.study('std3').feature('stat').set('useadvanceddisable', true);
model.study('std3').feature('stat').set('disabledphysics', {'solid/cnt3'});

model.result.dataset.create('mir1', 'Mirror2D');
model.result.dataset('mir1').set('removesymelem', true);
model.result.dataset.create('extr1', 'Extrude2D');
model.result.dataset('extr1').set('data', 'mir1');
model.result.dataset('extr1').set('zmax', '200');
model.result.dataset('extr1').set('planemap', 'yz');
model.result.create('pg3', 'PlotGroup3D');
model.result('pg3').run;
model.result('pg3').set('titletype', 'none');
model.result('pg3').create('surf1', 'Surface');
model.result('pg3').feature('surf1').set('coloring', 'uniform');
model.result('pg3').feature('surf1').set('color', 'gray');
model.result('pg3').run;
model.result('pg3').run;
model.result.remove('pg3');
model.result.dataset.remove('mir1');
model.result('pg1').run;

model.title('Cylinder Roller Contact');

model.description('A steel cylinder is pressed into an aluminum block. The cylinder is subjected to a uniform load along its top. The contact pressure distribution and contact length computed using the penalty method, both augmented Lagrangian methods, and the Nitsche method are compared with the analytical solution.');

model.label('cylinder_roller_contact.mph');

model.modelNode.label('Components');

out = model;
