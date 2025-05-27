function out = model
%
% journal_bearing_cavitation.m
%
% Model exported on May 26 2025, 21:26 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/CFD_Module/Thin-Film_Flow');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 3);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.physics.create('tff', 'ThinFilmFlowShell', 'geom1');
model.physics('tff').model('comp1');

model.study.create('std1');
model.study('std1').create('stat', 'Stationary');
model.study('std1').feature('stat').setSolveFor('/physics/tff', true);

model.param.set('R', '0.03[m]');
model.param.descr('R', 'Journal radius');
model.param.set('H', '0.05[m]');
model.param.descr('H', 'Journal height');
model.param.set('c', '0.03[mm]');
model.param.descr('c', 'Clearance between the bearing and the journal');
model.param.set('omega', '1500/60*2*pi[rad/s]');
model.param.descr('omega', 'Journal angular velocity');

model.geom('geom1').create('cyl1', 'Cylinder');
model.geom('geom1').feature('cyl1').set('type', 'surface');
model.geom('geom1').feature('cyl1').set('r', 'R');
model.geom('geom1').feature('cyl1').set('h', 'H');
model.geom('geom1').runPre('fin');

model.variable.create('var1');
model.variable('var1').model('comp1');

model.geom('geom1').run;

model.variable('var1').set('angle', 'atan2(y,x)[rad]');
model.variable('var1').descr('angle', 'Angle along circumference');
model.variable('var1').set('th', 'c*(1+0.6*cos(angle))');
model.variable('var1').descr('th', 'Lubricant film thickness');
model.variable('var1').set('u_b', '-omega*R*sin(angle)');
model.variable('var1').descr('u_b', 'x-component of journal velocity');
model.variable('var1').set('v_b', 'omega*R*cos(angle)');
model.variable('var1').descr('v_b', 'y-component of journal velocity');

model.physics('tff').prop('EquationType').set('EquationType', 'ReynoldsEquationWithCavitation');
model.physics('tff').feature('ffp1').set('mure_mat', 'userdef');
model.physics('tff').feature('ffp1').set('mure', '0.01[Pa*s]');
model.physics('tff').feature('ffp1').set('hw1', 'th');
model.physics('tff').feature('ffp1').set('TangentialBaseVelocity', 'userdef');
model.physics('tff').feature('ffp1').set('vb', {'u_b' 'v_b' '0'});

model.mesh('mesh1').run;

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
model.sol('sol1').feature('s1').feature('fc1').set('dtech', 'auto');
model.sol('sol1').feature('s1').feature('fc1').set('initstep', 0.01);
model.sol('sol1').feature('s1').feature('fc1').set('minstep', 1.0E-6);
model.sol('sol1').feature('s1').feature('fc1').set('maxiter', 50);
model.sol('sol1').feature('s1').create('d1', 'Direct');
model.sol('sol1').feature('s1').feature('d1').set('linsolver', 'pardiso');
model.sol('sol1').feature('s1').feature('d1').set('pivotperturb', 1.0E-13);
model.sol('sol1').feature('s1').feature('d1').label('Direct, pressure (tff)');
model.sol('sol1').feature('s1').feature('fc1').set('linsolver', 'd1');
model.sol('sol1').feature('s1').feature('fc1').set('dtech', 'auto');
model.sol('sol1').feature('s1').feature('fc1').set('initstep', 0.01);
model.sol('sol1').feature('s1').feature('fc1').set('minstep', 1.0E-6);
model.sol('sol1').feature('s1').feature('fc1').set('maxiter', 50);
model.sol('sol1').feature('s1').feature.remove('fcDef');
model.sol('sol1').attach('std1');
model.sol('sol1').runAll;

model.result.create('pg1', 'PlotGroup3D');
model.result('pg1').label('Fluid Pressure (tff)');
model.result('pg1').set('data', 'dset1');
model.result('pg1').set('defaultPlotID', 'ThinFilmFlowShell/phys1/pdef1/pcond1/pg1');
model.result('pg1').feature.create('surf1', 'Surface');
model.result('pg1').feature('surf1').set('showsolutionparams', 'on');
model.result('pg1').feature('surf1').set('smooth', 'internal');
model.result('pg1').feature('surf1').set('showsolutionparams', 'on');
model.result('pg1').feature('surf1').set('data', 'parent');
model.result('pg1').run;
model.result('pg1').run;
model.result('pg1').feature('surf1').set('expr', 'tff.p');
model.result('pg1').feature('surf1').set('unit', 'MPa');
model.result('pg1').feature('surf1').set('colortable', 'Cividis');
model.result('pg1').run;
model.result('pg1').run;
model.result('pg1').create('con1', 'Contour');
model.result('pg1').feature('con1').set('expr', 'tff.p');
model.result('pg1').feature('con1').set('unit', 'MPa');
model.result('pg1').feature('con1').set('colortable', 'GrayScale');
model.result('pg1').feature('con1').set('colorlegend', false);
model.result('pg1').run;
model.result('pg1').set('titletype', 'manual');
model.result('pg1').set('title', 'Pressure (MPa)');
model.result('pg1').run;
model.result.create('pg2', 'PlotGroup3D');
model.result('pg2').run;
model.result('pg2').label('Mass Fraction');
model.result('pg2').create('surf1', 'Surface');
model.result('pg2').feature('surf1').set('expr', 'tff.theta');
model.result('pg2').feature('surf1').set('descr', 'Mass fraction');
model.result('pg2').run;

model.title('Journal Bearing with Cavitation');

model.description('This example predicts the onset and extent of gaseous cavitation in the lubrication layer of a journal bearing. Since cavitation can lead to premature failure, the onset of cavitation determines the load that can be applied to the bearing.');

model.mesh.clearMeshes;

model.sol('sol1').clearSolutionData;

model.label('journal_bearing_cavitation.mph');

model.modelNode.label('Components');

out = model;
