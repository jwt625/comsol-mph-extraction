function out = model
%
% hyperelastic_seal.m
%
% Model exported on May 26 2025, 21:31 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/Nonlinear_Structural_Materials_Module/Hyperelasticity');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 2);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.physics.create('solid', 'SolidMechanics', 'geom1');
model.physics('solid').model('comp1');

model.study.create('std1');
model.study('std1').create('stat', 'Stationary');
model.study('std1').feature('stat').setSolveFor('/physics/solid', true);

model.geom('geom1').lengthUnit('mm');
model.geom('geom1').create('r1', 'Rectangle');
model.geom('geom1').feature('r1').set('type', 'curve');
model.geom('geom1').feature('r1').set('size', [18 12]);
model.geom('geom1').feature('r1').set('pos', [-6 0]);
model.geom('geom1').run('r1');
model.geom('geom1').create('fil1', 'Fillet');
model.geom('geom1').feature('fil1').selection('pointinsketch').set('r1', [1 4]);
model.geom('geom1').feature('fil1').set('radius', 6);
model.geom('geom1').run('fil1');
model.geom('geom1').create('fil2', 'Fillet');
model.geom('geom1').feature('fil2').selection('pointinsketch').set('fil1', [4 5]);
model.geom('geom1').feature('fil2').set('radius', 4);
model.geom('geom1').run('fil2');
model.geom('geom1').create('thi1', 'Thicken2D');
model.geom('geom1').feature('thi1').selection('input').set({'fil2'});
model.geom('geom1').feature('thi1').set('offset', 'asymmetric');
model.geom('geom1').feature('thi1').set('upthick', 1.5);
model.geom('geom1').run('thi1');
model.geom('geom1').create('c1', 'Circle');
model.geom('geom1').feature('c1').label('Indenter');
model.geom('geom1').feature('c1').set('r', 12);
model.geom('geom1').feature('c1').set('angle', 90);
model.geom('geom1').feature('c1').set('pos', [4 24]);
model.geom('geom1').feature('c1').set('rot', -135);
model.geom('geom1').feature('c1').set('selresult', true);
model.geom('geom1').feature('c1').set('selresultshow', 'bnd');
model.geom('geom1').run('c1');
model.geom('geom1').create('r2', 'Rectangle');
model.geom('geom1').feature('r2').set('size', [20 1]);
model.geom('geom1').feature('r2').set('pos', [-7 -1]);
model.geom('geom1').feature('r2').set('selresult', true);
model.geom('geom1').feature('r2').set('selresultshow', 'bnd');
model.geom('geom1').selection.create('csel1', 'CumulativeSelection');
model.geom('geom1').selection('csel1').label('Rigid base');
model.geom('geom1').feature('r2').set('contributeto', 'csel1');
model.geom('geom1').run('r2');
model.geom('geom1').create('r3', 'Rectangle');
model.geom('geom1').feature('r3').set('size', [1 12]);
model.geom('geom1').feature('r3').set('pos', [13 0]);
model.geom('geom1').feature('r3').set('contributeto', 'csel1');
model.geom('geom1').run('r3');
model.geom('geom1').create('ccur1', 'ConvertToCurve');
model.geom('geom1').feature('ccur1').selection('input').set({'c1' 'r2' 'r3'});
model.geom('geom1').run('ccur1');
model.geom('geom1').create('del1', 'Delete');
model.geom('geom1').feature('del1').selection('input').set('ccur1', [1 2 4 5 6 8 9 10]);
model.geom('geom1').feature('fin').set('action', 'assembly');
model.geom('geom1').feature('fin').set('createpairs', false);
model.geom('geom1').run('fin');
model.geom('geom1').create('sel1', 'ExplicitSelection');
model.geom('geom1').feature('sel1').label('Inner Seal Boundary');
model.geom('geom1').feature('sel1').selection('selection').init(1);
model.geom('geom1').feature('sel1').set('groupcontang', true);
model.geom('geom1').feature('sel1').selection('selection').add('fin', [5 6 8 12 13 15 16]);
model.geom('geom1').run('sel1');
model.geom('geom1').create('sel2', 'ExplicitSelection');
model.geom('geom1').feature('sel2').label('Outer Seal Boundary');
model.geom('geom1').feature('sel2').selection('selection').init(1);
model.geom('geom1').feature('sel2').set('groupcontang', true);
model.geom('geom1').feature('sel2').selection('selection').add('fin', [4 7 9 10 11 14 17]);
model.geom('geom1').run('sel2');
model.geom('geom1').create('sel3', 'ExplicitSelection');
model.geom('geom1').feature('sel3').label('Glued Seal Boundary');
model.geom('geom1').feature('sel3').selection('selection').init(1);
model.geom('geom1').feature('sel3').selection('selection').set('fin', 4);
model.geom('geom1').nodeGroup.create('grp1');
model.geom('geom1').nodeGroup('grp1').placeAfter([]);
model.geom('geom1').nodeGroup('grp1').add('r1');
model.geom('geom1').nodeGroup('grp1').add('fil1');
model.geom('geom1').nodeGroup('grp1').add('fil2');
model.geom('geom1').nodeGroup('grp1').add('thi1');
model.geom('geom1').nodeGroup('grp1').label('Seal');

model.param.set('para', '0');
model.param.descr('para', 'Vertical displacement parameter');
model.param.set('d', '50[mm]');
model.param.descr('d', 'Out-of-plane thickness');

model.pair.create('p1', 'Contact', 'geom1');

model.geom('geom1').run;

model.pair('p1').pairName('upper');
model.pair('p1').source.named('geom1_c1_bnd');
model.pair('p1').destination.named('geom1_sel2');
model.pair.create('p2', 'Contact', 'geom1');
model.pair('p2').pairName('lower');
model.pair('p2').source.named('geom1_csel1_bnd');
model.pair('p2').destination.named('geom1_sel2');

model.common.create('pres1', 'PrescribedDeformation', 'comp1');
model.common('pres1').selection.all;
model.common('pres1').selection.geom('geom1', 1);
model.common('pres1').selection.named('geom1_c1_bnd');
model.common('pres1').set('prescribedDeformation', {'0' '-para*1[mm]' '0'});

model.physics('solid').prop('d').set('d', 'd');
model.physics('solid').create('hmm1', 'HyperelasticModel', 2);
model.physics('solid').feature('hmm1').selection.all;
model.physics('solid').feature('hmm1').set('MaterialModel', 'MooneyRivlin');
model.physics('solid').feature('hmm1').set('kappa', '1e4[MPa]');
model.physics('solid').feature('dcnt1').create('fric1', 'Friction', 1);
model.physics('solid').feature('dcnt1').feature('fric1').set('mu_fric', 0.3);
model.physics('solid').feature('dcnt1').create('adh1', 'Adhesion', 1);
model.physics('solid').feature('dcnt1').feature('adh1').set('ActivationCriterion', 'UserDefined');
model.physics('solid').feature('dcnt1').feature('adh1').set('activation', 'dom==4');
model.physics('solid').feature('dcnt1').feature('adh1').set('StiffnessInput', 'UserDefined');
model.physics('solid').feature('dcnt1').feature('adh1').set('kPerArea', {'1e10[N/m^3]' '2e10[N/m^3]' '0'});
model.physics('solid').create('enc1', 'EnclosedCavity', 1);
model.physics('solid').feature('enc1').selection.named('geom1_sel1');

model.group.create('lg1', 'LoadGroup');

model.physics('solid').feature('enc1').feature('fl1').set('loadGroup', 'lg1');

model.material.create('mat1', 'Common', 'comp1');
model.material('mat1').propertyGroup.create('MooneyRivlin', 'Mooney-Rivlin[Material_parameters]');
model.material('mat1').propertyGroup('MooneyRivlin').set('C10', {'0.37[MPa]'});
model.material('mat1').propertyGroup('MooneyRivlin').set('C01', {'0.11[MPa]'});
model.material('mat1').propertyGroup('def').set('density', {'1100[kg/m^3]'});

model.mesh('mesh1').create('edg1', 'Edge');
model.mesh('mesh1').feature('edg1').selection.set([1 2 3]);
model.mesh('mesh1').feature('edg1').create('dis1', 'Distribution');
model.mesh('mesh1').feature('edg1').feature('dis1').set('numelem', 1);
model.mesh('mesh1').feature('edg1').feature('dis1').selection.named('geom1_csel1_bnd');
model.mesh('mesh1').feature('edg1').create('dis2', 'Distribution');
model.mesh('mesh1').feature('edg1').feature('dis2').set('numelem', 50);
model.mesh('mesh1').feature('edg1').feature('dis2').selection.named('geom1_c1_bnd');
model.mesh('mesh1').create('fq1', 'FreeQuad');
model.mesh('mesh1').feature('fq1').create('size1', 'Size');
model.mesh('mesh1').feature('fq1').feature('size1').selection.geom('geom1', 1);
model.mesh('mesh1').feature('fq1').feature('size1').selection.named('geom1_sel1');
model.mesh('mesh1').feature('fq1').feature('size1').set('custom', true);
model.mesh('mesh1').feature('fq1').feature('size1').set('hmaxactive', true);
model.mesh('mesh1').feature('fq1').feature('size1').set('hmax', 0.2);
model.mesh('mesh1').feature('fq1').feature.duplicate('size2', 'size1');
model.mesh('mesh1').feature('fq1').feature('size2').selection.named('geom1_sel2');
model.mesh('mesh1').run;

model.study('std1').feature('stat').set('useparam', true);
model.study('std1').feature('stat').setIndex('pname', 'para', 0);
model.study('std1').feature('stat').setIndex('plistarr', '', 0);
model.study('std1').feature('stat').setIndex('punit', '', 0);
model.study('std1').feature('stat').setIndex('pname', 'para', 0);
model.study('std1').feature('stat').setIndex('plistarr', '', 0);
model.study('std1').feature('stat').setIndex('punit', '', 0);
model.study('std1').feature('stat').setIndex('pname', 'para', 0);
model.study('std1').feature('stat').setIndex('plistarr', '1e-3 range(0.1,0.1,4)', 0);
model.study('std1').feature('stat').set('useloadcase', true);
model.study('std1').feature('stat').setIndex('loadcase', 'Load case 1', 0);
model.study('std1').feature('stat').setIndex('loadgroup', false, 0, 0);
model.study('std1').feature('stat').setIndex('loadgroupweight', '1.0', 0, 0);
model.study('std1').feature('stat').setIndex('loadcase', 'Load case 1', 0);
model.study('std1').feature('stat').setIndex('loadgroup', false, 0, 0);
model.study('std1').feature('stat').setIndex('loadgroupweight', '1.0', 0, 0);
model.study('std1').feature('stat').setIndex('loadcase', 'Load case 2', 1);
model.study('std1').feature('stat').setIndex('loadgroup', false, 1, 0);
model.study('std1').feature('stat').setIndex('loadgroupweight', '1.0', 1, 0);
model.study('std1').feature('stat').setIndex('loadcase', 'Load case 2', 1);
model.study('std1').feature('stat').setIndex('loadgroup', false, 1, 0);
model.study('std1').feature('stat').setIndex('loadgroupweight', '1.0', 1, 0);
model.study('std1').feature('stat').setIndex('loadcase', 'Without pressure', 0);
model.study('std1').feature('stat').setIndex('loadcase', 'With pressure', 1);
model.study('std1').feature('stat').setIndex('loadgroup', true, 1, 0);

model.sol.create('sol1');
model.sol('sol1').study('std1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'stat');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').feature('comp1_solid_enc1_fl1_lm').set('scalemethod', 'manual');
model.sol('sol1').feature('v1').feature('comp1_solid_hmm1_pw').set('scalemethod', 'manual');
model.sol('sol1').feature('v1').feature('comp1_u').set('scalemethod', 'manual');
model.sol('sol1').feature('v1').feature('comp1_solid_enc1_fl1_lm').set('resscalemethod', 'parent');
model.sol('sol1').feature('v1').feature('comp1_solid_enc1_fl1_lm').set('scaleval', '0.001');
model.sol('sol1').feature('v1').feature('comp1_solid_hmm1_pw').set('scaleval', '100000000');
model.sol('sol1').feature('v1').feature('comp1_u').set('scaleval', '1e-2*0.02531218074438765');
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
model.sol('sol1').runFromTo('st1', 'v1');

model.result.create('pg1', 'PlotGroup2D');
model.result('pg1').set('data', 'dset1');
model.result('pg1').setIndex('looplevel', 1, 0);
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
model.result.create('pg2', 'PlotGroup2D');
model.result('pg2').set('data', 'dset1');
model.result('pg2').setIndex('looplevel', 1, 0);
model.result('pg2').label('Moving Mesh');
model.result('pg2').create('mesh1', 'Mesh');
model.result('pg2').feature('mesh1').set('meshdomain', 'surface');
model.result('pg2').feature('mesh1').set('colortable', 'TrafficFlow');
model.result('pg2').feature('mesh1').set('colortabletrans', 'nonlinear');
model.result('pg2').feature('mesh1').set('nonlinearcolortablerev', true);
model.result('pg2').feature('mesh1').create('sel1', 'MeshSelection');
model.result('pg2').feature('mesh1').feature('sel1').selection.set([1]);
model.result('pg2').feature('mesh1').set('qualmeasure', 'custom');
model.result('pg2').feature('mesh1').set('qualexpr', 'comp1.spatial.relVol');
model.result('pg2').feature('mesh1').set('colorrangeunitinterval', false);
model.result('pg1').run;

model.sol('sol1').feature('v1').feature('comp1_u').set('scaleval', '1e-3');
model.sol('sol1').feature('v1').feature('comp1_solid_hmm1_pw').set('scaleval', '1e5');
model.sol('sol1').feature('s1').feature('dDef').set('linsolver', 'pardiso');

model.study('std1').feature('stat').set('plot', true);

model.sol('sol1').runAll;

model.result('pg1').run;
model.result('pg1').stepFirst(1);
model.result('pg1').run;
model.result('pg1').stepLast(1);
model.result('pg1').run;
model.result.create('pg3', 'PlotGroup2D');
model.result('pg3').set('data', 'dset1');
model.result('pg3').setIndex('looplevel', 41, 0);
model.result('pg3').setIndex('looplevel', 2, 1);
model.result('pg3').set('defaultPlotID', 'contactForces');
model.result('pg3').label('Contact Forces (solid)');
model.result('pg3').set('showlegends', true);
model.result('pg3').set('titletype', 'label');
model.result('pg3').set('frametype', 'spatial');
model.result('pg3').set('showlegendsunit', true);
model.result('pg3').create('surf1', 'Surface');
model.result('pg3').feature('surf1').set('expr', {'1'});
model.result('pg3').feature('surf1').label('Gray Surfaces');
model.result('pg3').feature('surf1').set('coloring', 'uniform');
model.result('pg3').feature('surf1').set('color', 'gray');
model.result('pg3').feature('surf1').create('sel1', 'Selection');
model.result('pg3').feature('surf1').feature('sel1').selection.geom('geom1', 2);
model.result('pg3').feature('surf1').feature('sel1').selection.set([1]);
model.result('pg3').create('arwl1', 'ArrowLine');
model.result('pg3').feature('arwl1').set('arrowbase', 'head');
model.result('pg3').feature('arwl1').set('expr', {'solid.dcnt1.Tnx' 'solid.dcnt1.Tny'});
model.result('pg3').feature('arwl1').set('placement', 'gausspoints');
model.result('pg3').feature('arwl1').set('gporder', 4);
model.result('pg3').feature('arwl1').label('Contact 1, Pressure');
model.result('pg3').feature('arwl1').set('inheritplot', 'none');
model.result('pg3').feature('arwl1').set('color', 'green');
model.result('pg3').feature('arwl1').create('col', 'Color');
model.result('pg3').feature('arwl1').feature('col').set('colortable', 'Rainbow');
model.result('pg3').feature('arwl1').feature('col').set('colortabletrans', 'none');
model.result('pg3').feature('arwl1').feature('col').set('colorscalemode', 'linear');
model.result('pg3').feature('arwl1').feature('col').set('colordata', 'arrowlength');
model.result('pg3').feature('arwl1').feature('col').set('coloring', 'gradient');
model.result('pg3').feature('arwl1').feature('col').set('topcolor', 'green');
model.result('pg3').feature('arwl1').feature('col').set('bottomcolor', 'custom');
model.result('pg3').feature('arwl1').feature('col').set('custombottomcolor', [0.509804 0.54902 0.509804]);
model.result('pg3').feature.move('surf1', 1);
model.result('pg3').set('legendpos', 'rightdouble');
model.result('pg3').create('arwl2', 'ArrowLine');
model.result('pg3').feature('arwl2').set('arrowbase', 'tail');
model.result('pg3').feature('arwl2').set('expr', {'solid.dcnt1.Ttx' 'solid.dcnt1.Tty'});
model.result('pg3').feature('arwl2').set('placement', 'gausspoints');
model.result('pg3').feature('arwl2').set('gporder', 4);
model.result('pg3').feature('arwl2').label('Contact 1, Friction Force');
model.result('pg3').feature('arwl2').set('inheritplot', 'none');
model.result('pg3').feature('arwl2').set('color', 'magenta');
model.result('pg3').feature('arwl2').create('col', 'Color');
model.result('pg3').feature('arwl2').feature('col').set('colortable', 'Rainbow');
model.result('pg3').feature('arwl2').feature('col').set('colortabletrans', 'none');
model.result('pg3').feature('arwl2').feature('col').set('colorscalemode', 'linear');
model.result('pg3').feature('arwl2').feature('col').set('colordata', 'arrowlength');
model.result('pg3').feature('arwl2').feature('col').set('coloring', 'gradient');
model.result('pg3').feature('arwl2').feature('col').set('topcolor', 'magenta');
model.result('pg3').feature('arwl2').feature('col').set('bottomcolor', 'custom');
model.result('pg3').feature('arwl2').feature('col').set('custombottomcolor', [0.54902 0.509804 0.54902]);
model.result('pg3').feature.move('surf1', 2);
model.result('pg3').label('Contact Forces (solid)');
model.result('pg3').run;
model.result.create('pg4', 'PlotGroup1D');
model.result('pg4').run;
model.result('pg4').label('Contact Pressure');
model.result('pg4').setIndex('looplevelinput', 'first', 1);
model.result('pg4').setIndex('looplevelinput', 'manualindices', 0);
model.result('pg4').setIndex('looplevelindices', 'range(10,5,40)', 0);
model.result('pg4').set('titletype', 'manual');
model.result('pg4').set('title', 'Contact pressure profile');
model.result('pg4').create('lngr1', 'LineGraph');
model.result('pg4').feature('lngr1').set('markerpos', 'datapoints');
model.result('pg4').feature('lngr1').set('linewidth', 'preference');
model.result('pg4').feature('lngr1').selection.set([7 11 17]);
model.result('pg4').feature('lngr1').set('expr', 'solid.Tn');
model.result('pg4').feature('lngr1').set('descr', 'Contact pressure');
model.result('pg4').feature('lngr1').set('unit', 'kPa');
model.result('pg4').feature('lngr1').set('legend', true);
model.result('pg4').feature('lngr1').set('autosolution', false);
model.result('pg4').feature('lngr1').set('legendprefix', 'eval(para)');
model.result('pg4').feature('lngr1').set('linewidth', 2);
model.result('pg4').run;
model.result('pg4').run;
model.result('pg4').setIndex('looplevelinput', 'last', 1);
model.result('pg4').run;
model.result.create('pg5', 'PlotGroup1D');
model.result('pg5').run;
model.result('pg5').label('Compressive Force vs. Indentation');
model.result('pg5').set('titletype', 'label');
model.result('pg5').create('glob1', 'Global');
model.result('pg5').feature('glob1').set('markerpos', 'datapoints');
model.result('pg5').feature('glob1').set('linewidth', 'preference');
model.result('pg5').feature('glob1').setIndex('expr', '-solid.dcnt1.T_toty_upper/d', 0);
model.result('pg5').feature('glob1').setIndex('unit', 'N/m', 0);
model.result('pg5').feature('glob1').set('linewidth', 2);
model.result('pg5').run;
model.result('pg5').set('xlabelactive', true);
model.result('pg5').set('ylabelactive', true);
model.result('pg5').set('xlabel', 'Indentation (mm)');
model.result('pg5').set('ylabel', 'Force (N/mm)');
model.result('pg5').set('legendpos', 'upperleft');
model.result('pg1').run;
model.result('pg1').create('arwl1', 'ArrowLine');
model.result('pg1').feature('arwl1').set('expr', {'solid.enc1.F_Ax' 'v'});
model.result('pg1').feature('arwl1').setIndex('expr', 'solid.enc1.F_Ay', 1);
model.result('pg1').feature('arwl1').set('titletype', 'none');
model.result('pg1').feature('arwl1').set('arrowcount', 300);
model.result('pg1').feature('arwl1').set('arrowbase', 'head');
model.result('pg1').feature('arwl1').set('inheritplot', 'surf1');
model.result('pg1').feature('arwl1').set('inheritcolor', false);
model.result('pg1').feature('arwl1').set('inheritrange', false);
model.result('pg1').run;
model.result('pg1').run;

model.title('Hyperelastic Seal');

model.description('A seal is modeled using a hyperelastic material model with large deformations. The model compares the stiffness with and without internal pressure.');

model.mesh.clearMeshes;

model.sol('sol1').clearSolutionData;

model.label('hyperelastic_seal.mph');

model.modelNode.label('Components');

out = model;
