function out = model
%
% step_thrust_bearing.m
%
% Model exported on May 26 2025, 21:33 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/Rotordynamics_Module/Tutorials');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 3);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.physics.create('hdb', 'HydrodynamicBearing', 'geom1');
model.physics('hdb').model('comp1');

model.study.create('std1');
model.study('std1').create('stat', 'Stationary');
model.study('std1').feature('stat').setSolveFor('/physics/hdb', true);

% To import content from file, use:
% model.param.loadFile('FILENAME');
model.param.set('N', '6', 'Number of pads');
model.param.set('Ro', '0.1[m]', 'Outer radius of pad');
model.param.set('Ri', '0.05[m]', 'Inner radius of pad');
model.param.set('gAng', '15[deg]', 'Groove angle (deg)');
model.param.set('padAng', '360[deg]/N-gAng', 'Pad angle (deg)');
model.param.set('secAng', 'gAng+padAng', 'Section angle (deg)');
model.param.set('angSpeed', '1000[rad/s]', 'Angular speed of shaft');
model.param.set('hg', '2e-4[m]', 'Groove depth');
model.param.set('h_film', '1.6e-4[m]', 'Film thickness');
model.param.set('rho_c', '866[kg/m^3]', 'Density of fluid');
model.param.set('mu_f', '0.072[Pa*s]', 'Dynamic viscosity of fluid');

model.geom('geom1').create('wp1', 'WorkPlane');
model.geom('geom1').feature('wp1').set('unite', true);
model.geom('geom1').feature('wp1').geom.create('c1', 'Circle');
model.geom('geom1').feature('wp1').geom.feature('c1').set('r', 'Ro');
model.geom('geom1').feature('wp1').geom.feature('c1').setIndex('layername', 'Layer 1', 0);
model.geom('geom1').feature('wp1').geom.feature('c1').setIndex('layer', 'Ro-Ri', 0);
model.geom('geom1').feature('wp1').geom.run('c1');
model.geom('geom1').feature('wp1').geom.create('del1', 'Delete');
model.geom('geom1').feature('wp1').geom.feature('del1').selection('input').init(2);
model.geom('geom1').feature('wp1').geom.feature('del1').selection('input').set('c1', 5);
model.geom('geom1').feature('wp1').geom.run('del1');
model.geom('geom1').run;

model.physics('hdb').prop('EquationType').set('EquationType', 'ReynoldsEquationWithCavitation');
model.physics('hdb').prop('EquationType').set('sftransition', '0.5[MPa]');

model.material.create('mat1', 'Common', 'comp1');
model.material('mat1').propertyGroup('def').set('dynamicviscosity', {'mu_f'});

model.physics('hdb').create('htb1', 'HydrodynamicThrustBearing', 2);
model.physics('hdb').feature('htb1').selection.all;
model.physics('hdb').feature('htb1').set('RefNormal', 'InverseOrientation');
model.physics('hdb').feature('htb1').set('BearingType', 'StepBearing');
model.physics('hdb').feature('htb1').set('gamma_p', 'padAng');
model.physics('hdb').feature('htb1').set('di', '2*Ri');
model.physics('hdb').feature('htb1').set('do', '2*Ro');
model.physics('hdb').feature('htb1').set('hs', 'hg');
model.physics('hdb').feature('htb1').set('h_film', 'h_film');
model.physics('hdb').feature('htb1').set('GrooveType', 'ConstantArc');
model.physics('hdb').feature('htb1').set('Ow', 'angSpeed');
model.physics('hdb').feature('htb1').set('rho_c', 'rho_c');
model.physics('hdb').feature('bax1').set('bearingAxis', 'zAxis');
model.physics('hdb').feature('bax1').set('e_aux', [1 0 0]);
model.physics('hdb').feature('bax1').set('ang_bearing', 'gAng');

model.mesh('mesh1').create('map1', 'Map');
model.mesh('mesh1').feature('map1').selection.all;
model.mesh('mesh1').feature('map1').create('dis1', 'Distribution');
model.mesh('mesh1').feature('map1').feature('dis1').selection.set([4 5 8 10]);
model.mesh('mesh1').feature('map1').feature('dis1').set('numelem', 90);
model.mesh('mesh1').feature('map1').create('dis2', 'Distribution');
model.mesh('mesh1').feature('map1').feature('dis2').selection.set([1 6 9 12]);
model.mesh('mesh1').feature('map1').feature('dis2').set('numelem', 20);
model.mesh('mesh1').run;

model.study('std1').feature('stat').set('useparam', true);
model.study('std1').feature('stat').setIndex('pname', 'N', 0);
model.study('std1').feature('stat').setIndex('plistarr', '', 0);
model.study('std1').feature('stat').setIndex('punit', '', 0);
model.study('std1').feature('stat').setIndex('pname', 'N', 0);
model.study('std1').feature('stat').setIndex('plistarr', '', 0);
model.study('std1').feature('stat').setIndex('punit', '', 0);
model.study('std1').feature('stat').setIndex('pname', 'h_film', 0);
model.study('std1').feature('stat').setIndex('plistarr', 'range(6e-5,2e-5,16e-5)', 0);
model.study('std1').feature('stat').setIndex('punit', 'm', 0);
model.study('std1').feature('stat').setIndex('pname', 'N', 1);
model.study('std1').feature('stat').setIndex('plistarr', '', 1);
model.study('std1').feature('stat').setIndex('punit', '', 1);
model.study('std1').feature('stat').setIndex('pname', 'N', 1);
model.study('std1').feature('stat').setIndex('plistarr', '', 1);
model.study('std1').feature('stat').setIndex('punit', '', 1);
model.study('std1').feature('stat').setIndex('pname', 'angSpeed', 1);
model.study('std1').feature('stat').setIndex('plistarr', 'range(500,100,1000)', 1);
model.study('std1').feature('stat').setIndex('punit', 'rad/s', 1);
model.study('std1').feature('stat').set('sweeptype', 'filled');

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
model.result('pg1').setIndex('looplevel', 6, 0);
model.result('pg1').setIndex('looplevel', 6, 1);
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
model.result.dataset.create('surf1', 'Surface');
model.result.dataset('surf1').selection.all;
model.result.create('pg2', 'PlotGroup2D');
model.result('pg2').run;
model.result('pg2').label('Pressure (Height)');
model.result('pg2').create('surf1', 'Surface');
model.result('pg2').feature('surf1').set('expr', 'hdb.p');
model.result('pg2').feature('surf1').set('colortable', 'Traffic');
model.result('pg2').feature('surf1').create('hght1', 'Height');
model.result('pg2').run;
model.result('pg2').feature('surf1').feature('hght1').set('scaleactive', true);
model.result('pg2').feature('surf1').feature('hght1').set('scale', '2e-8');
model.result('pg2').run;
model.result.create('pg3', 'PlotGroup3D');
model.result('pg3').run;
model.result('pg3').label('Mass Fraction');
model.result('pg3').create('con1', 'Contour');
model.result('pg3').feature('con1').set('expr', 'hdb.theta');
model.result('pg3').feature('con1').set('descr', 'Mass fraction');
model.result('pg3').feature('con1').set('contourtype', 'filled');
model.result('pg3').feature('con1').set('number', 5);
model.result('pg3').feature('con1').set('colortable', 'JupiterAuroraBorealis');
model.result('pg3').run;
model.result.create('pg4', 'PlotGroup2D');
model.result('pg4').run;
model.result('pg4').create('surf1', 'Surface');
model.result('pg4').feature('surf1').set('expr', 'hg-hdb.h');
model.result('pg4').feature('surf1').set('coloring', 'uniform');
model.result('pg4').feature('surf1').set('color', 'gray');
model.result('pg4').feature('surf1').create('hght1', 'Height');
model.result('pg4').run;
model.result('pg4').feature('surf1').feature('hght1').set('scaleactive', true);
model.result('pg4').feature('surf1').feature('hght1').set('scale', 100);
model.result('pg4').run;
model.result('pg4').label('Pad Profile');
model.result('pg4').set('edges', false);
model.result('pg4').run;
model.result.dataset.create('cln1', 'CutLine3D');
model.result.dataset('cln1').setIndex('genpoints', 0, 1, 0);
model.result.dataset('cln1').setIndex('genpoints', 'Ro', 1, 1);
model.result.dataset('cln1').label('Cut Line 3D: Radial Line');
model.result.create('pg5', 'PlotGroup1D');
model.result('pg5').run;
model.result('pg5').set('data', 'cln1');
model.result('pg5').setIndex('looplevelinput', 'last', 0);
model.result('pg5').label('Radial Distribution of Pressure (Film Thickness)');
model.result('pg5').set('titletype', 'label');
model.result('pg5').create('lngr1', 'LineGraph');
model.result('pg5').feature('lngr1').set('markerpos', 'datapoints');
model.result('pg5').feature('lngr1').set('linewidth', 'preference');
model.result('pg5').feature('lngr1').set('expr', 'hdb.p');
model.result('pg5').feature('lngr1').set('legend', true);
model.result('pg5').feature('lngr1').set('legendmethod', 'evaluated');
model.result('pg5').feature('lngr1').set('legendpattern', 'h = eval(h_film, um) \mu m');
model.result('pg5').run;
model.result('pg5').run;
model.result('pg5').set('legendpos', 'upperleft');
model.result.duplicate('pg6', 'pg5');
model.result('pg6').run;
model.result('pg6').setIndex('looplevelinput', 'last', 1);
model.result('pg6').setIndex('looplevelinput', 'all', 0);
model.result('pg6').label('Radial Distribution of Pressure (Angular Speed)');
model.result('pg6').run;
model.result('pg6').feature('lngr1').set('legendpattern', '\Omega = eval(angSpeed) rad/s');
model.result('pg6').run;
model.result.dataset.create('pc1', 'ParCurve3D');
model.result.dataset('pc1').set('parmax1', '2*pi/N');
model.result.dataset('pc1').set('exprx', '0.5*(Ro+Ri)*cos(s)');
model.result.dataset('pc1').set('expry', '0.5*(Ro+Ri)*sin(s)');
model.result.dataset('pc1').label('Parameterized Curve 3D: Circumferential Line');
model.result('pg5').run;
model.result.duplicate('pg7', 'pg5');
model.result.duplicate('pg8', 'pg6');
model.result('pg7').run;
model.result('pg7').label('Circumferential Distribution of Pressure (Film Thickness)');
model.result('pg7').set('data', 'pc1');
model.result('pg7').run;
model.result('pg8').run;
model.result('pg8').label('Circumferential Distribution of Pressure (Angular Speed)');
model.result('pg8').set('data', 'pc1');
model.result('pg8').run;
model.result.create('pg9', 'PlotGroup1D');
model.result('pg9').run;
model.result('pg9').label('Lift Force');
model.result('pg9').set('titletype', 'label');
model.result('pg9').create('glob1', 'Global');
model.result('pg9').feature('glob1').set('markerpos', 'datapoints');
model.result('pg9').feature('glob1').set('linewidth', 'preference');
model.result('pg9').feature('glob1').set('expr', {'hdb.htb1.Fcz'});
model.result('pg9').feature('glob1').set('descr', {'Fluid load on collar, z-component'});
model.result('pg9').feature('glob1').set('unit', {'N'});
model.result('pg9').feature('glob1').setIndex('expr', 'hdb.htb1.Fcz', 0);
model.result('pg9').feature('glob1').setIndex('unit', 'kN', 0);
model.result('pg9').feature('glob1').setIndex('descr', 'Fluid load on collar, z-component', 0);
model.result('pg9').feature('glob1').set('legendmethod', 'evaluated');
model.result('pg9').feature('glob1').set('legendpattern', 'h = eval(h_film, um) \mu m');
model.result('pg9').run;
model.result('pg9').run;
model.result('pg9').set('legendpos', 'upperleft');
model.result('pg9').set('xlabelactive', true);
model.result('pg9').set('xlabel', 'Angular speed of the shaft (rad/s)');
model.result('pg9').run;
model.result('pg2').run;

model.title('Step Thrust Bearing');

model.description(['In this tutorial model, a step thrust bearing is analyzed. A step thrust bearing consists of a stepped bearing surface on which the end of the shaft rotates. The entire assembly is submerged in a lubricant. A six step thrust bearing is considered in this example. The shaft collar is assumed to be spinning without any axial motion in the bearing. For a parametric study film thickness and spin speed of the collar are varied.' newline  newline 'The results include pressure distribution in the bearing, pressure variation in radial and circumferential directions of the pad, and load carrying capacity of the bearing.']);

model.label('step_thrust_bearing.mph');

model.modelNode.label('Components');

out = model;
