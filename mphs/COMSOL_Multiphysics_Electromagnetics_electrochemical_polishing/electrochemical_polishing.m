function out = model
%
% electrochemical_polishing.m
%
% Model exported on May 26 2025, 21:26 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/COMSOL_Multiphysics/Electromagnetics');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 2);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.physics.create('ec', 'ConductiveMedia', 'geom1');
model.physics('ec').model('comp1');

model.study.create('std1');
model.study('std1').create('time', 'Transient');
model.study('std1').feature('time').setSolveFor('/physics/ec', true);

model.param.set('K', '1e-11[m^3/(A*s)]');
model.param.descr('K', 'Coefficient of proportionality');

model.geom('geom1').lengthUnit('mm');
model.geom('geom1').create('r1', 'Rectangle');
model.geom('geom1').feature('r1').set('size', [2.8 0.4]);
model.geom('geom1').feature('r1').set('pos', [-1.4 0]);
model.geom('geom1').run('r1');
model.geom('geom1').create('c1', 'Circle');
model.geom('geom1').feature('c1').set('r', 0.3);
model.geom('geom1').feature('c1').set('pos', [0 0.6]);
model.geom('geom1').run('c1');
model.geom('geom1').create('dif1', 'Difference');
model.geom('geom1').feature('dif1').selection('input').set({'r1'});
model.geom('geom1').feature('dif1').selection('input2').set({'c1'});
model.geom('geom1').run('dif1');

model.variable.create('var1');
model.variable('var1').model('comp1');

model.geom('geom1').run;

model.variable('var1').set('dx', 'x-Xg');
model.variable('var1').descr('dx', 'x-displacement');
model.variable('var1').set('dy', 'y-Yg');
model.variable('var1').descr('dy', 'y-displacement');

model.physics('ec').prop('EquationForm').setIndex('form', 'Stationary', 0);
model.physics('ec').feature('cucn1').set('sigma_mat', 'userdef');
model.physics('ec').feature('cucn1').set('sigma', [10 0 0 0 10 0 0 0 10]);
model.physics('ec').create('pot1', 'ElectricPotential', 1);
model.physics('ec').feature('pot1').selection.set([3 4 6 7]);
model.physics('ec').feature('pot1').set('V0', 30);
model.physics('ec').create('gnd1', 'Ground', 1);
model.physics('ec').feature('gnd1').selection.set([2]);

model.common.create('free1', 'DeformingDomainDeformedGeometry', 'comp1');
model.common('free1').selection.all;
model.common('free1').set('smoothingType', 'laplace');
model.common.create('pnmv1', 'PrescribedNormalMeshVelocityDeformedGeometry', 'comp1');
model.common('pnmv1').selection.set([3 4 6 7]);
model.common('pnmv1').set('prescribedNormalVelocity', '-K*(-ec.nJ)');
model.common.create('pnmd1', 'PrescribedNormalMeshDisplacementDeformedGeometry', 'comp1');
model.common('pnmd1').selection.set([1 2 5]);

model.mesh('mesh1').autoMeshSize(3);
model.mesh('mesh1').run;

model.study('std1').feature('time').set('tlist', 'range(0,10)');

model.sol.create('sol1');

model.mesh('mesh1').stat.selection.geom(2);
model.mesh('mesh1').stat.selection.set([1]);

model.sol('sol1').study('std1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'time');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').feature('comp1_material_disp').set('scalemethod', 'manual');
model.sol('sol1').feature('v1').feature('comp1_material_disp').set('scaleval', '6.469912673290111E-5');
model.sol('sol1').feature('v1').set('control', 'time');
model.sol('sol1').create('t1', 'Time');
model.sol('sol1').feature('t1').set('tlist', 'range(0,10)');
model.sol('sol1').feature('t1').set('plot', 'off');
model.sol('sol1').feature('t1').set('plotgroup', 'Default');
model.sol('sol1').feature('t1').set('plotfreq', 'tout');
model.sol('sol1').feature('t1').set('probesel', 'all');
model.sol('sol1').feature('t1').set('probes', {});
model.sol('sol1').feature('t1').set('probefreq', 'tsteps');
model.sol('sol1').feature('t1').set('atolglobalvaluemethod', 'factor');
model.sol('sol1').feature('t1').set('endtimeinterpolation', true);
model.sol('sol1').feature('t1').set('control', 'time');
model.sol('sol1').feature('t1').create('seDef', 'Segregated');
model.sol('sol1').feature('t1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('t1').feature('fc1').set('linsolver', 'dDef');
model.sol('sol1').feature('t1').feature.remove('fcDef');
model.sol('sol1').feature('t1').feature.remove('seDef');
model.sol('sol1').attach('std1');
model.sol('sol1').runAll;

model.result.create('pg1', 'PlotGroup2D');
model.result('pg1').label('Electric Potential (ec)');
model.result('pg1').set('frametype', 'spatial');
model.result('pg1').set('showlegendsmaxmin', true);
model.result('pg1').set('data', 'dset1');
model.result('pg1').setIndex('looplevel', 11, 0);
model.result('pg1').set('defaultPlotID', 'InterfaceComponents/PlotDefaults/icom2/pdef1/pcond2/pcond2/pg1');
model.result('pg1').feature.create('surf1', 'Surface');
model.result('pg1').feature('surf1').set('showsolutionparams', 'on');
model.result('pg1').feature('surf1').set('solutionparams', 'parent');
model.result('pg1').feature('surf1').set('colortable', 'Dipole');
model.result('pg1').feature('surf1').set('showsolutionparams', 'on');
model.result('pg1').feature('surf1').set('data', 'parent');
model.result('pg1').feature.create('str1', 'Streamline');
model.result('pg1').feature('str1').set('showsolutionparams', 'on');
model.result('pg1').feature('str1').set('solutionparams', 'parent');
model.result('pg1').feature('str1').set('expr', {'ec.Ex' 'ec.Ey'});
model.result('pg1').feature('str1').set('titletype', 'none');
model.result('pg1').feature('str1').set('posmethod', 'uniform');
model.result('pg1').feature('str1').set('udist', 0.02);
model.result('pg1').feature('str1').set('maxlen', 0.4);
model.result('pg1').feature('str1').set('maxtime', Inf);
model.result('pg1').feature('str1').set('inheritcolor', false);
model.result('pg1').feature('str1').set('showsolutionparams', 'on');
model.result('pg1').feature('str1').set('maxtime', Inf);
model.result('pg1').feature('str1').set('showsolutionparams', 'on');
model.result('pg1').feature('str1').set('maxtime', Inf);
model.result('pg1').feature('str1').set('showsolutionparams', 'on');
model.result('pg1').feature('str1').set('maxtime', Inf);
model.result('pg1').feature('str1').set('showsolutionparams', 'on');
model.result('pg1').feature('str1').set('maxtime', Inf);
model.result('pg1').feature('str1').set('data', 'parent');
model.result('pg1').feature('str1').selection.geom('geom1', 1);
model.result('pg1').feature('str1').selection.set([1 2 3 4 5 6 7]);
model.result('pg1').feature('str1').set('inheritplot', 'surf1');
model.result('pg1').feature('str1').feature.create('col1', 'Color');
model.result('pg1').feature('str1').feature('col1').set('colortable', 'DipoleDark');
model.result('pg1').feature('str1').feature('col1').set('colorlegend', false);
model.result('pg1').feature('str1').feature.create('filt1', 'Filter');
model.result('pg1').feature('str1').feature('filt1').set('expr', '!isScalingSystemDomain');
model.result.create('pg2', 'PlotGroup2D');
model.result('pg2').label('Electric Field Norm (ec)');
model.result('pg2').set('frametype', 'spatial');
model.result('pg2').set('showlegendsmaxmin', true);
model.result('pg2').set('data', 'dset1');
model.result('pg2').setIndex('looplevel', 11, 0);
model.result('pg2').set('defaultPlotID', 'InterfaceComponents/PlotDefaults/icom3/pdef1/pcond2/pcond2/pg1');
model.result('pg2').feature.create('surf1', 'Surface');
model.result('pg2').feature('surf1').set('showsolutionparams', 'on');
model.result('pg2').feature('surf1').set('solutionparams', 'parent');
model.result('pg2').feature('surf1').set('expr', 'ec.normE');
model.result('pg2').feature('surf1').set('colortable', 'Prism');
model.result('pg2').feature('surf1').set('colortabletrans', 'nonlinear');
model.result('pg2').feature('surf1').set('colorcalibration', -0.8);
model.result('pg2').feature('surf1').set('showsolutionparams', 'on');
model.result('pg2').feature('surf1').set('data', 'parent');
model.result('pg2').feature.create('str1', 'Streamline');
model.result('pg2').feature('str1').set('showsolutionparams', 'on');
model.result('pg2').feature('str1').set('solutionparams', 'parent');
model.result('pg2').feature('str1').set('expr', {'ec.Ex' 'ec.Ey'});
model.result('pg2').feature('str1').set('titletype', 'none');
model.result('pg2').feature('str1').set('posmethod', 'uniform');
model.result('pg2').feature('str1').set('udist', 0.02);
model.result('pg2').feature('str1').set('maxlen', 0.4);
model.result('pg2').feature('str1').set('maxtime', Inf);
model.result('pg2').feature('str1').set('inheritcolor', false);
model.result('pg2').feature('str1').set('showsolutionparams', 'on');
model.result('pg2').feature('str1').set('maxtime', Inf);
model.result('pg2').feature('str1').set('showsolutionparams', 'on');
model.result('pg2').feature('str1').set('maxtime', Inf);
model.result('pg2').feature('str1').set('showsolutionparams', 'on');
model.result('pg2').feature('str1').set('maxtime', Inf);
model.result('pg2').feature('str1').set('showsolutionparams', 'on');
model.result('pg2').feature('str1').set('maxtime', Inf);
model.result('pg2').feature('str1').set('data', 'parent');
model.result('pg2').feature('str1').selection.geom('geom1', 1);
model.result('pg2').feature('str1').selection.set([1 2 3 4 5 6 7]);
model.result('pg2').feature('str1').set('inheritplot', 'surf1');
model.result('pg2').feature('str1').feature.create('col1', 'Color');
model.result('pg2').feature('str1').feature('col1').set('expr', 'ec.normE');
model.result('pg2').feature('str1').feature('col1').set('colortable', 'PrismDark');
model.result('pg2').feature('str1').feature('col1').set('colorlegend', false);
model.result('pg2').feature('str1').feature('col1').set('colortabletrans', 'nonlinear');
model.result('pg2').feature('str1').feature('col1').set('colorcalibration', -0.8);
model.result('pg2').feature('str1').feature.create('filt1', 'Filter');
model.result('pg2').feature('str1').feature('filt1').set('expr', '!isScalingSystemDomain');
model.result.create('pg3', 'PlotGroup2D');
model.result('pg3').set('data', 'dset1');
model.result('pg3').setIndex('looplevel', 11, 0);
model.result('pg3').label('Deformed Geometry');
model.result('pg3').create('mesh1', 'Mesh');
model.result('pg3').feature('mesh1').set('meshdomain', 'surface');
model.result('pg3').feature('mesh1').set('colortable', 'TrafficFlow');
model.result('pg3').feature('mesh1').set('colortabletrans', 'nonlinear');
model.result('pg3').feature('mesh1').set('nonlinearcolortablerev', true);
model.result('pg3').feature('mesh1').create('sel1', 'MeshSelection');
model.result('pg3').feature('mesh1').feature('sel1').selection.set([1]);
model.result('pg3').feature('mesh1').set('qualmeasure', 'custom');
model.result('pg3').feature('mesh1').set('qualexpr', 'comp1.material.relVol');
model.result('pg3').feature('mesh1').set('colorrangeunitinterval', false);
model.result('pg1').run;
model.result('pg2').run;
model.result.create('pg4', 'PlotGroup2D');
model.result('pg4').run;
model.result('pg4').label('Current Density Norm');
model.result('pg4').create('surf1', 'Surface');
model.result('pg4').feature('surf1').set('expr', 'ec.normJ');
model.result('pg4').feature('surf1').set('descr', 'Current density norm');
model.result('pg4').run;
model.result('pg4').create('mmp1', 'MaxMinPoint');
model.result('pg4').feature('mmp1').set('expr', 'ec.normJ');
model.result('pg4').run;
model.result.create('pg5', 'PlotGroup2D');
model.result('pg5').run;
model.result('pg5').label('Depletion, y Direction');
model.result('pg5').create('surf1', 'Surface');
model.result('pg5').feature('surf1').set('expr', 'dy');
model.result('pg5').feature('surf1').set('descr', 'y-displacement');
model.result('pg5').run;
model.result('pg5').create('mmp1', 'MaxMinPoint');
model.result('pg5').feature('mmp1').set('expr', 'dy');
model.result('pg5').feature('mmp1').set('display', 'max');
model.result('pg5').run;

model.title('Electrochemical Polishing');

model.description('This example illustrates the principle of electrochemical polishing. Two electrodes and an intermediate electrolyte domain make up the simplified 2D model geometry. The positive electrode has a protrusion, which represents a surface defect. The example examines how this protrusion and the surrounding electrode material are depleted over a period of time. A Deformed Geometry interface accounts for the changes in the electrode surface''s geometry.');

model.label('electrochemical_polishing.mph');

model.modelNode.label('Components');

out = model;
