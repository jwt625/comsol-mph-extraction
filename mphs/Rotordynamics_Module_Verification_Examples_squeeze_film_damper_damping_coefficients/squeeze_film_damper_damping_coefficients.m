function out = model
%
% squeeze_film_damper_damping_coefficients.m
%
% Model exported on May 26 2025, 21:33 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/Rotordynamics_Module/Verification_Examples');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 3);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.physics.create('hdb', 'HydrodynamicBearing', 'geom1');
model.physics('hdb').model('comp1');

model.study.create('std1');
model.study('std1').create('stat', 'Stationary');
model.study('std1').feature('stat').setSolveFor('/physics/hdb', true);

model.param.set('fr', '100[rpm]');
model.param.descr('fr', 'Whirl speed');
model.param.set('Rj', '0.1[m]');
model.param.descr('Rj', 'Journal radius');
model.param.set('H', '0.01[m]');
model.param.descr('H', 'Journal length');
model.param.set('C', '1e-3[m]');
model.param.descr('C', 'Clearance');
model.param.set('e', '0');
model.param.descr('e', 'Eccentricity');
model.param.set('phi', '10[deg]');
model.param.descr('phi', 'Attitude angle');
model.param.set('mu0', '0.02[Pa*s]');
model.param.descr('mu0', 'Oil viscosity');
model.param.set('rho0', '864[kg/m^3]');
model.param.descr('rho0', 'Oil density');

model.geom('geom1').create('cyl1', 'Cylinder');
model.geom('geom1').feature('cyl1').set('r', 'Rj');
model.geom('geom1').feature('cyl1').set('h', 'H');
model.geom('geom1').feature('cyl1').set('axistype', 'x');
model.geom('geom1').feature('cyl1').set('type', 'surface');
model.geom('geom1').run('cyl1');

model.variable.create('var1');
model.variable('var1').model('comp1');

model.geom('geom1').run;

model.variable('var1').set('c0', 'mu0*Rj*(H/C)^3');
model.variable('var1').descr('c0', 'Damping scaling');
model.variable('var1').set('c_rr', 'pi*(1+2*e^2)/(2*(1-e^2)^2.5)');
model.variable('var1').descr('c_rr', 'Damping coefficient, rr component');
model.variable('var1').set('c_rt', '2*e/(1-e^2)^2');
model.variable('var1').descr('c_rt', 'Damping coefficient, rt component');
model.variable('var1').set('c_tr', 'c_rt');
model.variable('var1').descr('c_tr', 'Damping coefficient, tr component');
model.variable('var1').set('c_tt', 'pi/(2*(1-e^2)^1.5)');
model.variable('var1').descr('c_tt', 'Damping coefficient, tt component');
model.variable('var1').set('c_22', 'c_rr*(sin(phi))^2+c_rt*sin(2*phi)+c_tt*(cos(phi))^2');
model.variable('var1').descr('c_22', 'Damping coefficient, 22 component');
model.variable('var1').set('c_23', '(-c_rr+c_tt)*sin(phi)*cos(phi)-c_rt*cos(2*phi)');
model.variable('var1').descr('c_23', 'Damping coefficient, 23 component');
model.variable('var1').set('c_32', 'c_23');
model.variable('var1').descr('c_32', 'Damping coefficient, 32 component');
model.variable('var1').set('c_33', 'c_rr*(cos(phi))^2-c_rt*sin(2*phi)+c_tt*(sin(phi))^2');
model.variable('var1').descr('c_33', 'Damping coefficient, 33 component');

model.physics('hdb').prop('DynamicCoefficients').set('calculateDynamicCoefficients', true);
model.physics('hdb').create('sfd1', 'SqueezeFilmDamper', 2);
model.physics('hdb').feature('sfd1').selection.all;
model.physics('hdb').feature('sfd1').set('C', 'C');
model.physics('hdb').feature('sfd1').set('BearingCenterType', 'fromGeom');
model.physics('hdb').feature('sfd1').set('Specify', 'Eccentricity');
model.physics('hdb').feature('sfd1').set('ec', 'C*e');
model.physics('hdb').feature('sfd1').set('phiy', '270[deg]+phi');
model.physics('hdb').feature('sfd1').set('Ow', '2*pi[rad]*fr');
model.physics('hdb').feature('sfd1').set('mure_mat', 'userdef');
model.physics('hdb').feature('sfd1').set('mure', 'mu0');
model.physics('hdb').feature('sfd1').set('rho_mat', 'userdef');
model.physics('hdb').feature('sfd1').set('rho', 'rho0');

model.mesh('mesh1').create('map1', 'Map');
model.mesh('mesh1').feature('map1').selection.all;
model.mesh('mesh1').feature('map1').create('dis1', 'Distribution');
model.mesh('mesh1').feature('map1').feature('dis1').selection.set([1 2 4 6]);
model.mesh('mesh1').feature('map1').feature('dis1').set('numelem', 50);
model.mesh('mesh1').feature('map1').create('dis2', 'Distribution');
model.mesh('mesh1').feature('map1').feature('dis2').selection.set([3]);
model.mesh('mesh1').run;

model.study('std1').feature('stat').set('useparam', true);
model.study('std1').feature('stat').setIndex('pname', 'fr', 0);
model.study('std1').feature('stat').setIndex('plistarr', '', 0);
model.study('std1').feature('stat').setIndex('punit', '1/s', 0);
model.study('std1').feature('stat').setIndex('pname', 'fr', 0);
model.study('std1').feature('stat').setIndex('plistarr', '', 0);
model.study('std1').feature('stat').setIndex('punit', '1/s', 0);
model.study('std1').feature('stat').setIndex('pname', 'e', 0);
model.study('std1').feature('stat').setIndex('plistarr', 'range(0.02,0.02,0.96)', 0);
model.study('std1').feature('stat').setIndex('punit', '', 0);

model.sol.create('sol1');
model.sol('sol1').study('std1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'stat');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').feature('comp1_pfilm').set('scalemethod', 'manual');
model.sol('sol1').feature('v1').feature('comp1_pfilm').set('resscalemethod', 'parent');
model.sol('sol1').feature('v1').feature('comp1_pfilm').set('scaleval', '1000000');
model.sol('sol1').feature('v1').set('control', 'stat');
model.sol('sol1').create('s1', 'Stationary');
model.sol('sol1').feature('s1').create('p1', 'Parametric');
model.sol('sol1').feature('s1').feature.remove('pDef');
model.sol('sol1').feature('s1').feature('p1').set('control', 'stat');
model.sol('sol1').feature('s1').set('control', 'stat');
model.sol('sol1').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('s1').feature('fc1').set('linsolver', 'dDef');
model.sol('sol1').feature('s1').feature.remove('fcDef');
model.sol('sol1').attach('std1');
model.sol('sol1').runAll;

model.result.create('pg1', 'PlotGroup3D');
model.result('pg1').label('Fluid Pressure (hdb)');
model.result('pg1').set('data', 'dset1');
model.result('pg1').setIndex('looplevel', 48, 0);
model.result('pg1').set('defaultPlotID', 'fluidPressure');
model.result('pg1').feature.create('surf1', 'Surface');
model.result('pg1').feature('surf1').set('colortable', 'RainbowLight');
model.result('pg1').feature('surf1').set('smooth', 'internal');
model.result('pg1').feature('surf1').set('data', 'parent');
model.result('pg1').feature.create('con1', 'Contour');
model.result('pg1').feature('con1').set('levelrounding', false);
model.result('pg1').feature('con1').set('colorlegend', false);
model.result('pg1').feature('con1').set('smooth', 'internal');
model.result('pg1').feature('con1').set('inherittubescale', false);
model.result('pg1').feature('con1').set('data', 'parent');
model.result('pg1').feature('con1').set('inheritplot', 'surf1');
model.result('pg1').run;
model.result('pg1').run;
model.result.create('pg2', 'PlotGroup1D');
model.result('pg2').run;
model.result('pg2').label('Damping coefficients (Dimensionless)');
model.result('pg2').create('glob1', 'Global');
model.result('pg2').feature('glob1').set('markerpos', 'datapoints');
model.result('pg2').feature('glob1').set('linewidth', 'preference');
model.result('pg2').feature('glob1').set('expr', {'hdb.sfd1.c22'});
model.result('pg2').feature('glob1').set('descr', {'Bearing damping coefficient, local yy-component'});
model.result('pg2').feature('glob1').set('unit', {'N*s/m'});
model.result('pg2').feature('glob1').setIndex('expr', 'hdb.sfd1.c22/c0', 0);
model.result('pg2').feature('glob1').setIndex('unit', 1, 0);
model.result('pg2').feature('glob1').setIndex('descr', 'c<sub>22</sub>, COMSOL', 0);
model.result('pg2').feature('glob1').setIndex('expr', '-hdb.sfd1.c23/c0', 1);
model.result('pg2').feature('glob1').setIndex('unit', 1, 1);
model.result('pg2').feature('glob1').setIndex('descr', '-c<sub>23</sub>, COMSOL', 1);
model.result('pg2').feature('glob1').setIndex('expr', '-hdb.sfd1.c32/c0', 2);
model.result('pg2').feature('glob1').setIndex('unit', 1, 2);
model.result('pg2').feature('glob1').setIndex('descr', '-c<sub>32</sub>, COMSOL', 2);
model.result('pg2').feature('glob1').setIndex('expr', 'hdb.sfd1.c33/c0', 3);
model.result('pg2').feature('glob1').setIndex('unit', 1, 3);
model.result('pg2').feature('glob1').setIndex('descr', 'c<sub>33</sub>, COMSOL', 3);
model.result('pg2').feature('glob1').set('linewidth', 2);
model.result('pg2').run;
model.result('pg2').create('glob2', 'Global');
model.result('pg2').feature('glob2').set('markerpos', 'datapoints');
model.result('pg2').feature('glob2').set('linewidth', 'preference');
model.result('pg2').feature('glob2').setIndex('expr', 'c_22', 0);
model.result('pg2').feature('glob2').setIndex('unit', '', 0);
model.result('pg2').feature('glob2').setIndex('descr', 'c<sub>22</sub>, Analytical', 0);
model.result('pg2').feature('glob2').setIndex('expr', '-c_23', 1);
model.result('pg2').feature('glob2').setIndex('unit', '', 1);
model.result('pg2').feature('glob2').setIndex('descr', '-c<sub>23</sub>, Analytical', 1);
model.result('pg2').feature('glob2').setIndex('expr', '-c_32', 2);
model.result('pg2').feature('glob2').setIndex('unit', '', 2);
model.result('pg2').feature('glob2').setIndex('descr', '-c<sub>32</sub>, Analytical', 2);
model.result('pg2').feature('glob2').setIndex('expr', 'c_33', 3);
model.result('pg2').feature('glob2').setIndex('unit', '', 3);
model.result('pg2').feature('glob2').setIndex('descr', 'c<sub>33</sub>, Analytical', 3);
model.result('pg2').feature('glob2').set('linestyle', 'none');
model.result('pg2').feature('glob2').set('linemarker', 'cycle');
model.result('pg2').run;
model.result('pg2').set('xlabelactive', true);
model.result('pg2').set('xlabel', 'Relative eccentricity (e)');
model.result('pg2').set('ylabelactive', true);
model.result('pg2').set('ylabel', 'Dimensionless damping coefficients');
model.result('pg2').set('titletype', 'none');
model.result('pg2').set('legendpos', 'upperleft');
model.result('pg2').set('ylog', true);
model.result('pg2').run;

model.title('Damping Coefficients of a Squeeze Film Damper');

model.description('Squeeze film dampers are components that provide additional damping to rotating machines. To simplify the modeling of a rotor assembly, squeeze film dampers are modeled in terms of their damping coefficients, which are functions of the journal location in the damper. This model computes the damping coefficients for a short squeeze film damper and compares with the corresponding analytical values.');

model.mesh.clearMeshes;

model.sol('sol1').clearSolutionData;

model.label('squeeze_film_damper_damping_coefficients.mph');

model.modelNode.label('Components');

out = model;
