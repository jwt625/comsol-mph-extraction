function out = model
%
% bevel_gear_pair.m
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

% To import content from file, use:
% model.param.loadFile('FILENAME');
model.param.set('n1', '50', 'Number of teeth, gear-1');
model.param.set('dp1', '100[mm]', 'Pitch diameter, gear-1');
model.param.set('gamma1', '78.7[deg]', 'Cone angle, gear-1');
model.param.set('n2', '10', 'Number of teeth, gear-2');
model.param.set('dp2', '20[mm]', 'Pitch diameter, gear-2');
model.param.set('gamma2', '11.3[deg]', 'Cone angle, gear-2');
model.param.set('alpha', '20[deg]', 'Pressure angle');
model.param.set('xcx1', '0[mm]', 'Gear-1 center, x coord');
model.param.set('xcy1', '0[mm]', 'Gear-1 center, y coord');
model.param.set('xcz1', '0[mm]', 'Gear-1 center, z coord');
model.param.set('ex1', '0', 'Gear-1 axis, x comp');
model.param.set('ey1', '-1', 'Gear-1 axis, y comp');
model.param.set('ez1', '0', 'Gear-1 axis, z comp');
model.param.set('xcx2', '0[mm]', 'Gear-2 center, x coord');
model.param.set('xcy2', '-10[mm]', 'Gear-2 center, y coord');
model.param.set('xcz2', '50[mm]', 'Gear-2 center, z coord');
model.param.set('ex2', '0', 'Gear-2 axis, x comp');
model.param.set('ey2', '0', 'Gear-2 axis, y comp');
model.param.set('ez2', '-1', 'Gear-2 axis, z comp');
model.param.set('M_b', '10[N*m]', 'Torque between bar and gear-2');
model.param.set('th_b', '1[rad]', 'Bar rotation');

model.geom.load({'part1'}, 'Multibody_Dynamics_Module/3D/External_Gears/bevel_gear.mph', {'part1'});
model.geom('geom1').create('pi1', 'PartInstance');
model.geom('geom1').feature('pi1').set('selkeepnoncontr', false);
model.geom('geom1').feature('pi1').set('part', 'part1');
model.geom('geom1').run('fin');
model.geom('geom1').feature('pi1').setEntry('inputexpr', 'n', 'n1');
model.geom('geom1').feature('pi1').setEntry('inputexpr', 'dp', 'dp1');
model.geom('geom1').feature('pi1').setEntry('inputexpr', 'alpha', 'alpha');
model.geom('geom1').feature('pi1').setEntry('inputexpr', 'gamma', 'gamma1');
model.geom('geom1').feature('pi1').setEntry('inputexpr', 'adr', 0.75);
model.geom('geom1').feature('pi1').setEntry('inputexpr', 'tfr', 0);
model.geom('geom1').feature('pi1').setEntry('inputexpr', 'rfr', 0);
model.geom('geom1').feature('pi1').setEntry('inputexpr', 'dhr', 0.6);
model.geom('geom1').feature('pi1').setEntry('inputexpr', 'wgr', 0.03);
model.geom('geom1').feature('pi1').setEntry('inputexpr', 'lsr', 0);
model.geom('geom1').feature('pi1').setEntry('inputexpr', 'xc', 'xcx1');
model.geom('geom1').feature('pi1').setEntry('inputexpr', 'yc', 'xcy1');
model.geom('geom1').feature('pi1').setEntry('inputexpr', 'zc', 'xcz1');
model.geom('geom1').feature('pi1').setEntry('inputexpr', 'egx', 'ex1');
model.geom('geom1').feature('pi1').setEntry('inputexpr', 'egy', 'ey1');
model.geom('geom1').feature('pi1').setEntry('inputexpr', 'egz', 'ez1');
model.geom('geom1').run('pi1');
model.geom('geom1').create('pi2', 'PartInstance');
model.geom('geom1').feature('pi2').set('selkeepnoncontr', false);
model.geom('geom1').feature('pi2').set('part', 'part1');
model.geom('geom1').feature('pi2').setEntry('inputexpr', 'n', 'n2');
model.geom('geom1').feature('pi2').setEntry('inputexpr', 'dp', 'dp2');
model.geom('geom1').feature('pi2').setEntry('inputexpr', 'alpha', 'alpha');
model.geom('geom1').feature('pi2').setEntry('inputexpr', 'gamma', 'gamma2');
model.geom('geom1').feature('pi2').setEntry('inputexpr', 'adr', 0.3);
model.geom('geom1').feature('pi2').setEntry('inputexpr', 'htr', 3);
model.geom('geom1').feature('pi2').setEntry('inputexpr', 'tfr', 0);
model.geom('geom1').feature('pi2').setEntry('inputexpr', 'rfr', 0);
model.geom('geom1').feature('pi2').setEntry('inputexpr', 'wgr', 0.4);
model.geom('geom1').feature('pi2').setEntry('inputexpr', 'wbr', 0.1);
model.geom('geom1').feature('pi2').setEntry('inputexpr', 'wcr', 0);
model.geom('geom1').feature('pi2').setEntry('inputexpr', 'lsr', 0);
model.geom('geom1').feature('pi2').setEntry('inputexpr', 'xc', 'xcx2');
model.geom('geom1').feature('pi2').setEntry('inputexpr', 'yc', 'xcy2');
model.geom('geom1').feature('pi2').setEntry('inputexpr', 'zc', 'xcz2');
model.geom('geom1').feature('pi2').setEntry('inputexpr', 'egx', 'ex2');
model.geom('geom1').feature('pi2').setEntry('inputexpr', 'egy', 'ey2');
model.geom('geom1').feature('pi2').setEntry('inputexpr', 'egz', 'ez2');
model.geom('geom1').feature('pi2').setEntry('inputexpr', 'th', '360/(2*n2)[deg]');
model.geom('geom1').run('pi2');
model.geom('geom1').create('cyl1', 'Cylinder');
model.geom('geom1').feature('cyl1').set('r', 'dp2/8');
model.geom('geom1').feature('cyl1').set('h', 'dp1/2');
model.geom('geom1').feature('cyl1').set('pos', {'xcx2' 'xcy2' 'xcz2'});
model.geom('geom1').feature('cyl1').set('axistype', 'cartesian');
model.geom('geom1').feature('cyl1').set('ax3', [0 0 -1]);
model.geom('geom1').feature('fin').set('action', 'assembly');
model.geom('geom1').feature('fin').set('createpairs', false);
model.geom('geom1').run('fin');

model.physics('mbd').prop('AutoModeling').runCommand('createGears');
model.physics('mbd').feature('bvg1').set('rho_mat', 'userdef');
model.physics('mbd').feature('bvg1').create('fix1', 'FixedConstraint', -1);
model.physics('mbd').feature('bvg1').feature('fix1').set('WeakConstraints', true);
model.physics('mbd').feature('bvg2').set('rho_mat', 'userdef');
model.physics('mbd').create('grp1', 'GearPair', -1);
model.physics('mbd').feature('grp1').set('Wheel', 'bvg1');
model.physics('mbd').feature('grp1').set('Pinion', 'bvg2');
model.physics('mbd').feature('grp1').set('ContactForceComputation', 'WeakConstraints');
model.physics('mbd').create('rd1', 'RigidDomain', 3);
model.physics('mbd').feature('rd1').selection.set([5]);
model.physics('mbd').feature('rd1').label('Rigid Material: Bar');
model.physics('mbd').feature('rd1').set('rho_mat', 'userdef');
model.physics('mbd').create('hgj1', 'HingeJoint', -1);
model.physics('mbd').feature('hgj1').set('Source', 'rd1');
model.physics('mbd').feature('hgj1').set('Destination', 'bvg2');
model.physics('mbd').feature('hgj1').set('CenterOfJointType', 'CentroidOfSelectedEntities');
model.physics('mbd').feature('hgj1').set('EntityLevel', 'Point');
model.physics('mbd').feature('hgj1').feature('cjp1').selection.set([648 650]);
model.physics('mbd').feature('hgj1').set('e', [0 0 1]);
model.physics('mbd').feature('hgj1').create('afm1', 'AppliedForceAndMoment', -1);
model.physics('mbd').feature('hgj1').feature('afm1').set('AppliedOnSelectedAttachment', 'Joint');
model.physics('mbd').feature('hgj1').feature('afm1').set('Ms', 'M_b');
model.physics('mbd').create('hgj2', 'HingeJoint', -1);
model.physics('mbd').feature('hgj2').set('Source', 'fixed');
model.physics('mbd').feature('hgj2').set('Destination', 'rd1');
model.physics('mbd').feature('hgj2').set('EntityLevel', 'Point');
model.physics('mbd').feature('hgj2').feature('cjp1').selection.set([647 649]);
model.physics('mbd').feature('hgj2').set('e', [0 1 0]);
model.physics('mbd').feature('hgj2').create('pm1', 'PrescribedMotion', -1);
model.physics('mbd').feature('hgj2').feature('pm1').set('thp', '-th_b*t[1/s]');

model.mesh('mesh1').autoMeshSize(4);

model.study('std1').feature('time').set('tlist', 'range(0,0.05,1)');

model.sol.create('sol1');
model.sol('sol1').study('std1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'time');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').feature('comp1_mbd_rd_disp').set('scalemethod', 'manual');
model.sol('sol1').feature('v1').feature('comp1_mbd_gr_fc').set('scalemethod', 'manual');
model.sol('sol1').feature('v1').feature('comp1_mbd_bvg1_RM').set('scalemethod', 'manual');
model.sol('sol1').feature('v1').feature('comp1_mbd_gr_rot').set('scalemethod', 'manual');
model.sol('sol1').feature('v1').feature('comp1_mbd_gr_disp').set('scalemethod', 'manual');
model.sol('sol1').feature('v1').feature('comp1_mbd_jnt_rot').set('scalemethod', 'manual');
model.sol('sol1').feature('v1').feature('comp1_mbd_rd_rot').set('scalemethod', 'manual');
model.sol('sol1').feature('v1').feature('comp1_mbd_bvg1_RF').set('scalemethod', 'manual');
model.sol('sol1').feature('v1').feature('comp1_mbd_gr_mc').set('scalemethod', 'manual');
model.sol('sol1').feature('v1').feature('comp1_u').set('scalemethod', 'manual');
model.sol('sol1').feature('v1').feature('comp1_mbd_rd_disp').set('resscalemethod', 'parent');
model.sol('sol1').feature('v1').feature('comp1_mbd_gr_fc').set('resscalemethod', 'parent');
model.sol('sol1').feature('v1').feature('comp1_mbd_gr_rot').set('resscalemethod', 'parent');
model.sol('sol1').feature('v1').feature('comp1_mbd_gr_disp').set('resscalemethod', 'parent');
model.sol('sol1').feature('v1').feature('comp1_mbd_jnt_rot').set('resscalemethod', 'parent');
model.sol('sol1').feature('v1').feature('comp1_mbd_rd_rot').set('resscalemethod', 'parent');
model.sol('sol1').feature('v1').feature('comp1_mbd_gr_mc').set('resscalemethod', 'parent');
model.sol('sol1').feature('v1').feature('comp1_mbd_rd_disp').set('scaleval', '0.0014515458837441098');
model.sol('sol1').feature('v1').feature('comp1_mbd_gr_fc').set('scaleval', '21069.854526144685');
model.sol('sol1').feature('v1').feature('comp1_mbd_bvg1_RM').set('scaleval', '1e8*(0.1*0.14515458837441098)^3');
model.sol('sol1').feature('v1').feature('comp1_mbd_gr_rot').set('scaleval', '0.1');
model.sol('sol1').feature('v1').feature('comp1_mbd_gr_disp').set('scaleval', '0.0014515458837441098');
model.sol('sol1').feature('v1').feature('comp1_mbd_jnt_rot').set('scaleval', '0.1');
model.sol('sol1').feature('v1').feature('comp1_mbd_rd_rot').set('scaleval', '0.1');
model.sol('sol1').feature('v1').feature('comp1_mbd_bvg1_RF').set('scaleval', '1e8*(0.1*0.14515458837441098)^2');
model.sol('sol1').feature('v1').feature('comp1_mbd_gr_mc').set('scaleval', '305.83860608512515');
model.sol('sol1').feature('v1').feature('comp1_u').set('scaleval', '1e-2*0.14515458837441098');
model.sol('sol1').feature('v1').set('control', 'time');
model.sol('sol1').create('t1', 'Time');
model.sol('sol1').feature('t1').set('tlist', 'range(0,0.05,1)');
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
model.result('pg1').setIndex('looplevel', 21, 0);
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
model.result('pg2').setIndex('looplevel', 21, 0);
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
model.result.numerical.create('gev1', 'EvalGlobal');
model.result.numerical('gev1').setIndex('looplevelinput', 'last', 0);
model.result.numerical('gev1').set('expr', {'mbd.grp1.Fc'});
model.result.numerical('gev1').set('descr', {'Force at contact point'});
model.result.numerical('gev1').set('unit', {'N'});
model.result.table.create('tbl1', 'Table');
model.result.table('tbl1').comments('Global Evaluation 1');
model.result.numerical('gev1').set('table', 'tbl1');
model.result.numerical('gev1').setResult;
model.result.numerical.create('gev2', 'EvalGlobal');
model.result.numerical('gev2').setIndex('looplevelinput', 'last', 0);
model.result.numerical('gev2').set('expr', {'mbd.bvg1.RFx'});
model.result.numerical('gev2').set('descr', {'Reaction force, x-component'});
model.result.numerical('gev2').set('unit', {'N'});
model.result.numerical('gev2').set('expr', {'mbd.bvg1.RFx' 'mbd.bvg1.RFy'});
model.result.numerical('gev2').set('descr', {'Reaction force, x-component' 'Reaction force, y-component'});
model.result.numerical('gev2').set('expr', {'mbd.bvg1.RFx' 'mbd.bvg1.RFy' 'mbd.bvg1.RFz'});
model.result.numerical('gev2').set('descr', {'Reaction force, x-component' 'Reaction force, y-component' 'Reaction force, z-component'});
model.result.table.create('tbl2', 'Table');
model.result.table('tbl2').comments('Global Evaluation 2');
model.result.numerical('gev2').set('table', 'tbl2');
model.result.numerical('gev2').setResult;
model.result.numerical.create('gev3', 'EvalGlobal');
model.result.numerical('gev3').setIndex('looplevelinput', 'last', 0);
model.result.numerical('gev3').set('expr', {'mbd.bvg1.RMx'});
model.result.numerical('gev3').set('descr', {'Reaction moment, x-component'});
model.result.numerical('gev3').set('unit', {'N*m'});
model.result.numerical('gev3').set('expr', {'mbd.bvg1.RMx' 'mbd.bvg1.RMy'});
model.result.numerical('gev3').set('descr', {'Reaction moment, x-component' 'Reaction moment, y-component'});
model.result.numerical('gev3').set('expr', {'mbd.bvg1.RMx' 'mbd.bvg1.RMy' 'mbd.bvg1.RMz'});
model.result.numerical('gev3').set('descr', {'Reaction moment, x-component' 'Reaction moment, y-component' 'Reaction moment, z-component'});
model.result.table.create('tbl3', 'Table');
model.result.table('tbl3').comments('Global Evaluation 3');
model.result.numerical('gev3').set('table', 'tbl3');
model.result.numerical('gev3').setResult;
model.result.create('pg3', 'PlotGroup1D');
model.result('pg3').run;
model.result('pg3').label('Reaction forces');
model.result('pg3').create('glob1', 'Global');
model.result('pg3').feature('glob1').set('markerpos', 'datapoints');
model.result('pg3').feature('glob1').set('linewidth', 'preference');
model.result('pg3').feature('glob1').set('expr', {'mbd.bvg1.RFx'});
model.result('pg3').feature('glob1').set('descr', {'Reaction force, x-component'});
model.result('pg3').feature('glob1').set('unit', {'N'});
model.result('pg3').feature('glob1').set('expr', {'mbd.bvg1.RFx' 'mbd.bvg1.RFy'});
model.result('pg3').feature('glob1').set('descr', {'Reaction force, x-component' 'Reaction force, y-component'});
model.result('pg3').feature('glob1').set('expr', {'mbd.bvg1.RFx' 'mbd.bvg1.RFy' 'mbd.bvg1.RFz'});
model.result('pg3').feature('glob1').set('descr', {'Reaction force, x-component' 'Reaction force, y-component' 'Reaction force, z-component'});
model.result('pg3').feature('glob1').set('linewidth', 2);
model.result('pg3').run;
model.result('pg3').set('titletype', 'none');
model.result('pg3').set('ylabelactive', true);
model.result('pg3').set('ylabel', 'Reaction force (N)');
model.result('pg3').set('legendpos', 'lowerright');
model.result('pg3').run;
model.result.create('pg4', 'PlotGroup1D');
model.result('pg4').run;
model.result('pg4').label('Reaction moments');
model.result('pg4').create('glob1', 'Global');
model.result('pg4').feature('glob1').set('markerpos', 'datapoints');
model.result('pg4').feature('glob1').set('linewidth', 'preference');
model.result('pg4').feature('glob1').set('expr', {'mbd.bvg1.RMx'});
model.result('pg4').feature('glob1').set('descr', {'Reaction moment, x-component'});
model.result('pg4').feature('glob1').set('unit', {'N*m'});
model.result('pg4').feature('glob1').set('expr', {'mbd.bvg1.RMx' 'mbd.bvg1.RMy'});
model.result('pg4').feature('glob1').set('descr', {'Reaction moment, x-component' 'Reaction moment, y-component'});
model.result('pg4').feature('glob1').set('expr', {'mbd.bvg1.RMx' 'mbd.bvg1.RMy' 'mbd.bvg1.RMz'});
model.result('pg4').feature('glob1').set('descr', {'Reaction moment, x-component' 'Reaction moment, y-component' 'Reaction moment, z-component'});
model.result('pg4').feature('glob1').set('linewidth', 2);
model.result('pg4').run;
model.result('pg4').set('titletype', 'none');
model.result('pg4').set('ylabelactive', true);
model.result('pg4').set('ylabel', 'Reaction moment (N-m)');
model.result('pg4').run;
model.result('pg2').run;
model.result('pg2').label('Gears');
model.result('pg2').run;
model.result('pg2').feature.remove('arwl1');
model.result('pg2').run;
model.result('pg2').feature('vol1').set('colortable', 'AuroraAustralis');
model.result('pg2').run;
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
model.result.export('anim1').set('plotgroup', 'pg2');
model.result('pg2').run;

model.title('Forces and Moments on Bevel Gears');

model.description('This example illustrates the modeling of a straight conical bevel gear pair. The gears are modeled as rigid and connected through a gear pair. A transient study is performed to compute the forces and moments experienced by the fixed gear. The results obtained are compared with the results from the reference.');

model.mesh.clearMeshes;

model.sol('sol1').clearSolutionData;

model.label('bevel_gear_pair.mph');

model.modelNode.label('Components');

out = model;
