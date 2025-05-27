function out = model
%
% crooked_four_bar_mechanism.m
%
% Model exported on May 26 2025, 21:31 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/Multibody_Dynamics_Module/Verification_Examples');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 3);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.physics.create('mbd', 'MultibodyDynamics', 'geom1');
model.physics('mbd').model('comp1');

model.study.create('std1');
model.study('std1').create('time', 'Transient');
model.study('std1').feature('time').setSolveFor('/physics/mbd', true);

model.param.set('d', '5[mm]');
model.param.descr('d', 'Diameter of links');
model.param.set('l1', '0.12[m]');
model.param.descr('l1', 'Length of vertical link');
model.param.set('l2', '0.24[m]');
model.param.descr('l2', 'Length of horizontal link');
model.param.set('theta', '5[deg]');
model.param.descr('theta', 'Offset angle');

model.geom('geom1').create('cyl1', 'Cylinder');
model.geom('geom1').feature('cyl1').set('r', 'd/2');
model.geom('geom1').feature('cyl1').set('h', 'l1');
model.geom('geom1').feature.duplicate('cyl2', 'cyl1');
model.geom('geom1').feature('cyl2').set('pos', {'l2' '0' '0'});
model.geom('geom1').feature.duplicate('cyl3', 'cyl1');
model.geom('geom1').feature('cyl3').set('h', 'l2');
model.geom('geom1').feature('cyl3').set('pos', {'0' '0' 'l1'});
model.geom('geom1').feature('cyl3').set('axistype', 'x');
model.geom('geom1').feature('fin').set('action', 'assembly');
model.geom('geom1').run('fin');

model.material.create('mat1', 'Common', 'comp1');
model.material('mat1').propertyGroup.create('Enu', 'Young''s_modulus_and_Poisson''s_ratio');
model.material('mat1').propertyGroup('Enu').set('E', {'7e10'});
model.material('mat1').propertyGroup('Enu').set('nu', {'0.33'});
model.material('mat1').propertyGroup('def').set('density', {'3000'});

model.physics('mbd').prop('ShapeProperty').set('order_displacement', 2);
model.physics('mbd').create('att1', 'Attachment', 2);
model.physics('mbd').feature('att1').selection.set([3]);
model.physics('mbd').create('hgj1', 'HingeJoint', -1);
model.physics('mbd').feature('hgj1').set('Source', 'fixed');
model.physics('mbd').feature('hgj1').set('Destination', 'att1');
model.physics('mbd').feature('hgj1').set('AxisOfJointType', 'SelectFromCS');
model.physics('mbd').feature('hgj1').set('AxisToUse', 2);
model.physics('mbd').create('att2', 'Attachment', 2);
model.physics('mbd').feature('att2').selection.set([4]);
model.physics('mbd').create('att3', 'Attachment', 2);
model.physics('mbd').feature('att3').selection.set([7]);
model.physics('mbd').feature.duplicate('hgj2', 'hgj1');
model.physics('mbd').feature('hgj2').set('Source', 'att2');
model.physics('mbd').feature('hgj2').set('Destination', 'att3');
model.physics('mbd').create('att4', 'Attachment', 2);
model.physics('mbd').feature('att4').selection.set([12]);
model.physics('mbd').create('att5', 'Attachment', 2);
model.physics('mbd').feature('att5').selection.set([16]);
model.physics('mbd').feature.duplicate('hgj3', 'hgj2');
model.physics('mbd').feature('hgj3').set('Source', 'att4');
model.physics('mbd').feature('hgj3').set('Destination', 'att5');
model.physics('mbd').feature('hgj3').set('AxisOfJointType', 'SpecifyDirection');
model.physics('mbd').feature('hgj3').set('e', {'sin(theta)' 'cos(theta)' '0'});
model.physics('mbd').create('att6', 'Attachment', 2);
model.physics('mbd').feature('att6').selection.set([15]);
model.physics('mbd').feature.duplicate('hgj4', 'hgj1');
model.physics('mbd').feature('hgj4').set('Destination', 'att6');
model.physics('mbd').feature('hgj1').create('pm1', 'PrescribedMotion', -1);
model.physics('mbd').feature('hgj1').feature('pm1').set('PrescribedMotionThroughRotational', 'AngularVelocity');
model.physics('mbd').feature('hgj1').feature('pm1').set('omegap', -1);

model.nodeGroup.create('grp1', 'Physics', 'mbd');
model.nodeGroup('grp1').placeAfter('init1');
model.nodeGroup('grp1').add('att1');
model.nodeGroup('grp1').add('att2');
model.nodeGroup('grp1').add('att3');
model.nodeGroup('grp1').add('att4');
model.nodeGroup('grp1').add('att5');
model.nodeGroup('grp1').add('att6');
model.nodeGroup('grp1').label('Attachments');
model.nodeGroup.create('grp2', 'Physics', 'mbd');
model.nodeGroup('grp2').placeAfter('init1');
model.nodeGroup('grp2').add('hgj1');
model.nodeGroup('grp2').add('hgj2');
model.nodeGroup('grp2').add('hgj3');
model.nodeGroup('grp2').add('hgj4');
model.nodeGroup('grp2').label('Hinge Joints');

model.mesh('mesh1').create('ftri1', 'FreeTri');
model.mesh('mesh1').feature('ftri1').selection.set([3 7 16]);
model.mesh('mesh1').feature('size').set('hauto', 4);
model.mesh('mesh1').create('swe1', 'Sweep');
model.mesh('mesh1').feature('swe1').create('dis1', 'Distribution');
model.mesh('mesh1').feature('swe1').feature('dis1').selection.set([1 3]);
model.mesh('mesh1').feature('swe1').feature('dis1').set('numelem', 10);
model.mesh('mesh1').feature('swe1').create('dis2', 'Distribution');
model.mesh('mesh1').feature('swe1').feature('dis2').selection.set([2]);
model.mesh('mesh1').feature('swe1').feature('dis2').set('numelem', 20);
model.mesh('mesh1').run;

model.study('std1').feature('time').set('tlist', 'range(0,0.01,10)');

model.sol.create('sol1');
model.sol('sol1').study('std1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'time');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').feature('comp1_mbd_att_rot').set('scalemethod', 'manual');
model.sol('sol1').feature('v1').feature('comp1_mbd_jnt_rot').set('scalemethod', 'manual');
model.sol('sol1').feature('v1').feature('comp1_mbd_att_disp').set('scalemethod', 'manual');
model.sol('sol1').feature('v1').feature('comp1_u').set('scalemethod', 'manual');
model.sol('sol1').feature('v1').feature('comp1_mbd_att_rot').set('resscalemethod', 'parent');
model.sol('sol1').feature('v1').feature('comp1_mbd_jnt_rot').set('resscalemethod', 'parent');
model.sol('sol1').feature('v1').feature('comp1_mbd_att_disp').set('resscalemethod', 'parent');
model.sol('sol1').feature('v1').feature('comp1_mbd_att_rot').set('scaleval', '0.1');
model.sol('sol1').feature('v1').feature('comp1_mbd_jnt_rot').set('scaleval', '0.1');
model.sol('sol1').feature('v1').feature('comp1_mbd_att_disp').set('scaleval', '0.002739639574834617');
model.sol('sol1').feature('v1').feature('comp1_u').set('scaleval', '1e-2*0.2739639574834617');
model.sol('sol1').feature('v1').set('control', 'time');
model.sol('sol1').create('t1', 'Time');
model.sol('sol1').feature('t1').set('tlist', 'range(0,0.01,10)');
model.sol('sol1').feature('t1').set('plot', 'off');
model.sol('sol1').feature('t1').set('plotgroup', 'Default');
model.sol('sol1').feature('t1').set('plotfreq', 'tout');
model.sol('sol1').feature('t1').set('probesel', 'all');
model.sol('sol1').feature('t1').set('probes', {});
model.sol('sol1').feature('t1').set('probefreq', 'tsteps');
model.sol('sol1').feature('t1').set('rtol', 0.001);
model.sol('sol1').feature('t1').set('atolglobalvaluemethod', 'factor');
model.sol('sol1').feature('t1').set('atolglobalmethod', 'scaled');
model.sol('sol1').feature('t1').set('atolglobalfactor', 0.1);
model.sol('sol1').feature('t1').set('atolglobalvaluemethod', 'factor');
model.sol('sol1').feature('t1').set('eventtol', 0.01);
model.sol('sol1').feature('t1').set('reacf', true);
model.sol('sol1').feature('t1').set('storeudot', true);
model.sol('sol1').feature('t1').set('tstepsbdf', 'strict');
model.sol('sol1').feature('t1').set('endtimeinterpolation', true);
model.sol('sol1').feature('t1').set('maxorder', 2);
model.sol('sol1').feature('t1').set('minorder', 1);
model.sol('sol1').feature('t1').set('rescaleafterinitbw', false);
model.sol('sol1').feature('t1').set('bwinitstepfrac', '0.001');
model.sol('sol1').feature('t1').set('control', 'time');
model.sol('sol1').feature('t1').feature('aDef').set('cachepattern', true);
model.sol('sol1').feature('t1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('t1').feature('fc1').set('maxiter', 50);
model.sol('sol1').feature('t1').feature('fc1').set('jtech', 'onevery');
model.sol('sol1').feature('t1').feature('fc1').set('dtech', 'const');
model.sol('sol1').feature('t1').feature('fc1').set('damp', 1);
model.sol('sol1').feature('t1').feature('fc1').set('ntolfact', 1);
model.sol('sol1').feature('t1').feature('fc1').set('ntermconst', 'tol');
model.sol('sol1').feature('t1').feature('fc1').set('linsolver', 'dDef');
model.sol('sol1').feature('t1').feature('fc1').set('maxiter', 50);
model.sol('sol1').feature('t1').feature('fc1').set('jtech', 'onevery');
model.sol('sol1').feature('t1').feature('fc1').set('dtech', 'const');
model.sol('sol1').feature('t1').feature('fc1').set('damp', 1);
model.sol('sol1').feature('t1').feature('fc1').set('ntolfact', 1);
model.sol('sol1').feature('t1').feature('fc1').set('ntermconst', 'tol');
model.sol('sol1').feature('t1').feature.remove('fcDef');
model.sol('sol1').attach('std1');
model.sol('sol1').runAll;

model.result.create('pg1', 'PlotGroup3D');
model.result('pg1').label('Displacement (mbd)');
model.result('pg1').set('frametype', 'spatial');
model.result('pg1').set('data', 'dset1');
model.result('pg1').setIndex('looplevel', 1001, 0);
model.result('pg1').set('defaultPlotID', 'displacement');
model.result('pg1').feature.create('surf1', 'Surface');
model.result('pg1').feature('surf1').label('Surface');
model.result('pg1').feature('surf1').set('colortable', 'SpectrumLight');
model.result('pg1').feature('surf1').set('data', 'parent');
model.result('pg1').feature('surf1').feature.create('def1', 'Deform');
model.result('pg1').feature('surf1').feature('def1').label('Deformation');
model.result('pg1').feature('surf1').feature('def1').set('scaleactive', true);
model.result.create('pg2', 'PlotGroup3D');
model.result('pg2').label('Velocity (mbd)');
model.result('pg2').set('frametype', 'spatial');
model.result('pg2').set('data', 'dset1');
model.result('pg2').setIndex('looplevel', 1001, 0);
model.result('pg2').set('defaultPlotID', 'velocity');
model.result('pg2').feature.create('vol1', 'Volume');
model.result('pg2').feature('vol1').label('Volume');
model.result('pg2').feature('vol1').set('expr', 'mod(dom,10)');
model.result('pg2').feature('vol1').set('unit', '1');
model.result('pg2').feature('vol1').set('colortable', 'Cyclic');
model.result('pg2').feature('vol1').set('colorlegend', false);
model.result('pg2').feature('vol1').set('data', 'parent');
model.result('pg2').feature('vol1').feature.create('def1', 'Deform');
model.result('pg2').feature('vol1').feature('def1').label('Deformation');
model.result('pg2').feature('vol1').feature('def1').set('scaleactive', true);
model.result('pg2').feature.create('arwl1', 'ArrowLine');
model.result('pg2').feature('arwl1').label('Arrow Line');
model.result('pg2').feature('arwl1').set('expr', {'mbd.u_tX' 'mbd.u_tY' 'mbd.u_tZ'});
model.result('pg2').feature('arwl1').set('placement', 'elements');
model.result('pg2').feature('arwl1').set('data', 'parent');
model.result('pg2').feature('arwl1').feature.create('def1', 'Deform');
model.result('pg2').feature('arwl1').feature('def1').label('Deformation');
model.result('pg2').feature('arwl1').feature('def1').set('scaleactive', true);
model.result('pg1').run;
model.result('pg1').run;
model.result('pg1').feature('surf1').feature('def1').set('expr', {'u' '20*v' 'w'});
model.result('pg1').run;
model.result('pg1').create('pttraj1', 'PointTrajectories');
model.result('pg1').feature('pttraj1').set('expr', {'x' 'Y+20*v' 'z'});
model.result('pg1').feature('pttraj1').selection.set([11]);
model.result('pg1').feature('pttraj1').set('linetype', 'tube');
model.result('pg1').feature.duplicate('pttraj2', 'pttraj1');
model.result('pg1').run;
model.result('pg1').feature('pttraj2').selection.set([15]);
model.result('pg1').feature('pttraj2').set('linecolor', 'blue');
model.result('pg1').run;
model.result('pg1').run;
model.result.table.create('tbl1', 'Table');
model.result.table('tbl1').label('vB');
model.result.table('tbl1').importData('crooked_four_bar_mechanism_vB.txt');
model.result.table.create('tbl2', 'Table');
model.result.table('tbl2').label('vC');
model.result.table('tbl2').importData('crooked_four_bar_mechanism_vC.txt');
model.result.create('pg3', 'PlotGroup1D');
model.result('pg3').run;
model.result('pg3').label('y-Displacement: Point B');
model.result('pg3').create('ptgr1', 'PointGraph');
model.result('pg3').feature('ptgr1').set('markerpos', 'datapoints');
model.result('pg3').feature('ptgr1').set('linewidth', 'preference');
model.result('pg3').feature('ptgr1').selection.set([4]);
model.result('pg3').feature('ptgr1').set('expr', 'v');
model.result('pg3').feature('ptgr1').set('linewidth', 2);
model.result('pg3').feature('ptgr1').set('legend', true);
model.result('pg3').feature('ptgr1').set('legendmethod', 'manual');
model.result('pg3').feature('ptgr1').setIndex('legends', 'COMSOL', 0);
model.result('pg3').run;
model.result('pg3').create('tblp1', 'Table');
model.result('pg3').feature('tblp1').set('markerpos', 'datapoints');
model.result('pg3').feature('tblp1').set('linewidth', 'preference');
model.result('pg3').feature('tblp1').set('linemarker', 'asterisk');
model.result('pg3').feature('tblp1').set('linestyle', 'none');
model.result('pg3').feature('tblp1').set('legend', true);
model.result('pg3').feature('tblp1').set('legendmethod', 'manual');
model.result('pg3').feature('tblp1').setIndex('legends', 'Ref. 1', 0);
model.result('pg3').run;
model.result('pg3').set('legendpos', 'lowerright');
model.result('pg3').set('titletype', 'none');
model.result('pg3').set('xlabelactive', true);
model.result('pg3').set('xlabel', 'Time (s)');
model.result('pg3').set('ylabelactive', true);
model.result('pg3').set('ylabel', 'Out-of-plane displacement, point B (m)');
model.result('pg3').run;
model.result.duplicate('pg4', 'pg3');
model.result('pg4').run;
model.result('pg4').label('y-Displacement: Point C');
model.result('pg4').run;
model.result('pg4').feature('ptgr1').selection.set([13]);
model.result('pg4').run;
model.result('pg4').feature('tblp1').set('table', 'tbl2');
model.result('pg4').run;
model.result('pg4').set('ylabel', 'Out-of-plane displacement, point C (m)');
model.result('pg4').run;
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
model.result.export('anim1').set('maxframes', 100);
model.result('pg1').run;

model.title('Four-Bar Mechanism with Assembly Defect');

model.description('This is a benchmark problem for flexible multibody dynamics. Here a four-bar mechanism is studied, in which one of the joints has a defect. The links in the mechanism are flexible as the motion in the mechanism is possible only when the links are deformable. Four hinge joints are used to establish the connections between the links. The out-of-plane deformation at two different locations is compared with the result from the reference.');

model.mesh.clearMeshes;

model.sol('sol1').clearSolutionData;

model.label('crooked_four_bar_mechanism.mph');

model.modelNode.label('Components');

out = model;
