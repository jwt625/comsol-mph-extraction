function out = model
%
% contacting_rings.m
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

model.param.set('r1', '160[mm]');
model.param.descr('r1', 'Outer ring radius');
model.param.set('r2', '111.5[mm]');
model.param.descr('r2', 'Inner ring radius');
model.param.set('t1', '4[mm]');
model.param.descr('t1', 'Outer ring thickness');
model.param.set('t2', '11.5[mm]');
model.param.descr('t2', 'Inner ring thickness');
model.param.set('y0', '111.5[mm]-156[mm]');
model.param.descr('y0', 'Inner ring center initial y-position');

model.geom('geom1').create('c1', 'Circle');
model.geom('geom1').feature('c1').set('type', 'curve');
model.geom('geom1').feature('c1').set('r', 'r1-t1');
model.geom('geom1').feature('c1').set('angle', 90);
model.geom('geom1').feature('c1').set('rot', -95);
model.geom('geom1').run('c1');
model.geom('geom1').create('c2', 'Circle');
model.geom('geom1').feature('c2').set('r', 'r2');
model.geom('geom1').feature('c2').set('angle', 90);
model.geom('geom1').feature('c2').set('pos', {'0' 'y0'});
model.geom('geom1').feature('c2').set('rot', -95);
model.geom('geom1').feature('c2').setIndex('layername', 'Layer 1', 0);
model.geom('geom1').feature('c2').setIndex('layer', 't2', 0);
model.geom('geom1').run('c2');
model.geom('geom1').create('del1', 'Delete');
model.geom('geom1').feature('del1').selection('input').init(2);
model.geom('geom1').feature('del1').selection('input').set('c2', 1);
model.geom('geom1').run('del1');
model.geom('geom1').create('del2', 'Delete');
model.geom('geom1').feature('del2').selection('input').set('c1', [2 3]);
model.geom('geom1').run('del2');
model.geom('geom1').feature('fin').set('action', 'assembly');
model.geom('geom1').run('fin');

model.variable.create('var1');
model.variable('var1').model('comp1');
model.variable('var1').selection.geom('geom1', 1);
model.variable('var1').selection.set([1]);
model.variable('var1').set('L', '(r1-t1)*(atan2(-y,-x)-pi/2)');
model.variable('var1').descr('L', 'Length of the outer ring');

model.pair.create('p1', 'Contact', 'geom1');
model.pair('p1').source.set([1]);
model.pair('p1').destination.set([4]);

model.material.create('mat1', 'Common', 'comp1');
model.material('mat1').propertyGroup.create('Enu', 'Young''s_modulus_and_Poisson''s_ratio');
model.material('mat1').propertyGroup('Enu').set('E', {'210[GPa]'});
model.material('mat1').propertyGroup('Enu').set('nu', {'0.3'});
model.material('mat1').propertyGroup('def').set('density', {'7850'});

model.physics('solid').feature('dcnt1').set('ContactMethodCtrl', 'AugmentedLagrange');
model.physics('solid').feature('dcnt1').set('penaltyCtrlAuglag', 'ManualTuning');
model.physics('solid').feature('dcnt1').set('pfm', '1/50');
model.physics('solid').feature('dcnt1').create('fric1', 'Friction', 1);
model.physics('solid').feature('dcnt1').feature('fric1').set('mu_fric', 1);
model.physics('solid').feature('dcnt1').feature('fric1').set('sliptotStore', true);
model.physics('solid').feature('dcnt1').create('stb1', 'ContactStabilization', 1);

model.param.set('phi', '0[rad]');
model.param.descr('phi', 'Inner ring rotation angle');

model.physics('solid').create('rig1', 'RigidConnector', 1);
model.physics('solid').feature('rig1').selection.set([5]);
model.physics('solid').feature('rig1').set('CenterOfRotationType', 'userDefined');
model.physics('solid').feature('rig1').set('xc', {'0' 'y0' '0'});
model.physics('solid').feature('rig1').set('RotationType', 'PrescribedRotationGroup');
model.physics('solid').feature('rig1').set('phi0', '-phi');
model.physics('solid').feature('rig1').create('rf1', 'RigidBodyForce', -1);
model.physics('solid').feature('rig1').feature('rf1').set('Ft', [0 -500 0]);

model.mesh('mesh1').create('map1', 'Map');
model.mesh('mesh1').feature('map1').create('dis1', 'Distribution');
model.mesh('mesh1').feature('map1').feature('dis1').selection.set([2]);
model.mesh('mesh1').feature('map1').feature('dis1').set('numelem', 3);
model.mesh('mesh1').feature('map1').create('dis2', 'Distribution');
model.mesh('mesh1').feature('map1').feature('dis2').selection.set([4]);
model.mesh('mesh1').feature('map1').feature('dis2').set('numelem', 60);
model.mesh('mesh1').create('edg1', 'Edge');
model.mesh('mesh1').feature('edg1').selection.set([1]);
model.mesh('mesh1').feature('edg1').create('dis1', 'Distribution');
model.mesh('mesh1').feature('edg1').feature('dis1').set('numelem', 100);
model.mesh('mesh1').run;

model.study('std1').feature('stat').set('plot', true);
model.study('std1').feature('stat').set('probefreq', 'psteps');
model.study('std1').feature('stat').set('useparam', true);
model.study('std1').feature('stat').setIndex('pname', 'r1', 0);
model.study('std1').feature('stat').setIndex('plistarr', '', 0);
model.study('std1').feature('stat').setIndex('punit', 'm', 0);
model.study('std1').feature('stat').setIndex('pname', 'r1', 0);
model.study('std1').feature('stat').setIndex('plistarr', '', 0);
model.study('std1').feature('stat').setIndex('punit', 'm', 0);
model.study('std1').feature('stat').setIndex('pname', 'phi', 0);
model.study('std1').feature('stat').setIndex('plistarr', 'range(0,pi/120,pi/6)', 0);

model.sol.create('sol1');
model.sol('sol1').study('std1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'stat');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').feature('comp1_solid_Tn_p1').set('scalemethod', 'manual');
model.sol('sol1').feature('v1').feature('comp1_solid_rig_disp').set('scalemethod', 'manual');
model.sol('sol1').feature('v1').feature('comp1_solid_Tt_p1').set('scalemethod', 'manual');
model.sol('sol1').feature('v1').feature('comp1_solid_rig_rot').set('scalemethod', 'manual');
model.sol('sol1').feature('v1').feature('comp1_u').set('scalemethod', 'manual');
model.sol('sol1').feature('v1').feature('comp1_solid_rig_disp').set('resscalemethod', 'parent');
model.sol('sol1').feature('v1').feature('comp1_solid_rig_rot').set('resscalemethod', 'parent');
model.sol('sol1').feature('v1').feature('comp1_solid_Tn_p1').set('scaleval', '100000000');
model.sol('sol1').feature('v1').feature('comp1_solid_rig_disp').set('scaleval', '0.0022087790624917853');
model.sol('sol1').feature('v1').feature('comp1_solid_Tt_p1').set('scaleval', '10000000');
model.sol('sol1').feature('v1').feature('comp1_solid_rig_rot').set('scaleval', '0.01');
model.sol('sol1').feature('v1').feature('comp1_u').set('scaleval', '1e-2*0.22087790624917852');
model.sol('sol1').feature('v1').set('control', 'stat');
model.sol('sol1').create('s1', 'Stationary');
model.sol('sol1').feature('s1').create('p1', 'Parametric');
model.sol('sol1').feature('s1').feature.remove('pDef');
model.sol('sol1').feature('s1').feature('p1').set('porder', 'constant');
model.sol('sol1').feature('s1').feature('p1').set('control', 'stat');
model.sol('sol1').feature('s1').set('control', 'stat');
model.sol('sol1').feature('s1').feature('aDef').set('cachepattern', true);
model.sol('sol1').feature('s1').create('se1', 'Segregated');
model.sol('sol1').feature('s1').feature('se1').feature.remove('ssDef');
model.sol('sol1').feature('s1').feature('se1').create('ss1', 'SegregatedStep');
model.sol('sol1').feature('s1').feature('se1').feature('ss1').set('segvar', {'comp1_u' 'comp1_solid_rig_disp' 'comp1_solid_rig_rot'});
model.sol('sol1').feature('s1').feature('se1').feature('ss1').set('subdtech', 'ddog');
model.sol('sol1').feature('s1').feature('se1').feature('ss1').set('subtermauto', 'itertol');
model.sol('sol1').feature('s1').feature('se1').feature('ss1').set('subiter', 7);
model.sol('sol1').feature('s1').feature('se1').feature('ss1').set('subntolfact', 1);
model.sol('sol1').feature('s1').feature('se1').feature('ss1').set('linsolver', 'dDef');
model.sol('sol1').feature('s1').feature('se1').feature('ss1').label('Solid Mechanics');
model.sol('sol1').feature('s1').feature('se1').create('ls1', 'LumpedStep');
model.sol('sol1').feature('s1').feature('se1').feature('ls1').set('segvar', {'comp1_solid_Tn_p1' 'comp1_solid_Tt_p1'});
model.sol('sol1').feature('s1').feature('se1').set('maxsegiter', 15);
model.sol('sol1').feature('s1').feature.remove('fcDef');
model.sol('sol1').attach('std1');
model.sol('sol1').feature('v1').feature('comp1_solid_Tn_p1').set('scaleval', '1e5');
model.sol('sol1').feature('v1').feature('comp1_solid_Tt_p1').set('scaleval', '1e5');
model.sol('sol1').feature('s1').feature('p1').set('paramtuning', true);
model.sol('sol1').feature('s1').feature('p1').set('pinitstep', 'pi/1000');
model.sol('sol1').feature('s1').feature('p1').set('pmaxstep', 'pi/1000');
model.sol('sol1').feature('s1').feature('p1').set('pminstep', 'pi/10000');
model.sol('sol1').feature('s1').feature('se1').feature('ss1').set('subiter', 15);

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
model.result('pg1').feature('surf1').feature('def').set('scaleactive', true);
model.result('pg1').feature('surf1').feature('def').set('scale', '1');
model.result('pg1').feature('surf1').feature('def').set('expr', {'u' 'v'});
model.result('pg1').feature('surf1').feature('def').set('descr', 'Displacement field');

model.sol('sol1').run('st1');

model.result.remove('pg1');

model.study('std1').feature('stat').set('plotgroup', 'Default');

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
model.result('pg1').feature('surf1').feature('def').set('scaleactive', true);
model.result('pg1').feature('surf1').feature('def').set('scale', '1');
model.result('pg1').feature('surf1').feature('def').set('expr', {'u' 'v'});
model.result('pg1').feature('surf1').feature('def').set('descr', 'Displacement field');
model.result('pg1').run;
model.result('pg1').create('pttraj1', 'PointTrajectories');
model.result('pg1').feature('pttraj1').set('expr', {'solid.u_rig1' '0'});
model.result('pg1').feature('pttraj1').setIndex('expr', 'y0+solid.v_rig1', 1);
model.result('pg1').feature('pttraj1').set('linecolor', 'red');
model.result('pg1').feature('pttraj1').set('pointtype', 'arrow');
model.result('pg1').feature('pttraj1').set('arrowexpr', {'cos(phi+5[deg])' '0'});
model.result('pg1').feature('pttraj1').setIndex('arrowexpr', 'sin(-phi-5[deg])', 1);
model.result('pg1').feature('pttraj1').set('arrowtype', 'cone');
model.result('pg1').feature('pttraj1').set('arrowbase', 'head');

model.sol('sol1').runAll;

model.result('pg1').run;
model.result.create('pg2', 'PlotGroup1D');
model.result('pg2').run;
model.result('pg2').set('legendpos', 'upperleft');
model.result('pg2').label('Rigid Body Displacement');
model.result('pg2').set('showlegends', false);
model.result('pg2').create('glob1', 'Global');
model.result('pg2').feature('glob1').set('markerpos', 'datapoints');
model.result('pg2').feature('glob1').set('linewidth', 'preference');
model.result('pg2').feature('glob1').set('expr', {'solid.rig1.v'});
model.result('pg2').feature('glob1').set('descr', {'Rigid body displacement, y-component'});
model.result('pg2').feature('glob1').set('unit', {'m'});
model.result('pg2').run;
model.result.create('pg3', 'PlotGroup1D');
model.result('pg3').run;
model.result('pg3').setIndex('looplevelinput', 'last', 0);
model.result('pg3').label('Contact Pressure, Outer Ring');
model.result('pg3').set('titletype', 'none');
model.result('pg3').set('ylabelactive', true);
model.result('pg3').set('ylabel', 'Contact pressure (N/m<sup>2</sup>)');
model.result('pg3').create('lngr1', 'LineGraph');
model.result('pg3').feature('lngr1').set('markerpos', 'datapoints');
model.result('pg3').feature('lngr1').set('linewidth', 'preference');
model.result('pg3').feature('lngr1').selection.set([1]);
model.result('pg3').feature('lngr1').set('expr', 'dst2src_p1(solid.Tn_p1)');
model.result('pg3').feature('lngr1').set('xdata', 'expr');
model.result('pg3').feature('lngr1').set('xdataexpr', 'L');
model.result('pg3').feature('lngr1').set('xdataunit', 'mm');
model.result('pg3').feature('lngr1').create('gmrk1', 'GraphMarker');
model.result('pg3').feature('lngr1').feature('gmrk1').set('linewidth', 'preference');
model.result('pg3').run;
model.result('pg3').feature('lngr1').feature('gmrk1').set('display', 'max');
model.result('pg3').feature('lngr1').feature('gmrk1').set('inclxcoord', true);
model.result('pg3').feature('lngr1').feature('gmrk1').set('inclycoord', false);
model.result('pg3').feature('lngr1').feature('gmrk1').set('includeunit', true);
model.result('pg3').run;
model.result.dataset.create('edg1', 'Edge2D');
model.result.dataset('edg1').selection.set([4]);
model.result.dataset.create('par1', 'Parametric1D');
model.result.create('pg4', 'PlotGroup2D');
model.result('pg4').run;
model.result('pg4').label('Accumulated Slip');
model.result('pg4').set('data', 'par1');
model.result('pg4').set('titletype', 'label');
model.result('pg4').create('surf1', 'Surface');
model.result('pg4').feature('surf1').set('expr', 'gpeval(4,solid.sliptot)');
model.result('pg4').feature('surf1').create('hght1', 'Height');
model.result('pg4').run;
model.result('pg4').run;
model.result('pg1').run;

model.title('Friction Between Contacting Rings');

model.description('This is a benchmark problem involving stick-slip friction of a ring rolling inside another ring. The displacement of the inner ring is computed and compared to the analytical result.');

model.label('contacting_rings.mph');

model.modelNode.label('Components');

out = model;
