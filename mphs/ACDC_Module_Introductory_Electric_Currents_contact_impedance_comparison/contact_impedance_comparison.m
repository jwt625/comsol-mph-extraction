function out = model
%
% contact_impedance_comparison.m
%
% Model exported on May 26 2025, 21:25 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/ACDC_Module/Introductory_Electric_Currents');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 2);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.physics.create('ec', 'ConductiveMedia', 'geom1');
model.physics('ec').model('comp1');

model.study.create('std1');
model.study('std1').create('stat', 'Stationary');
model.study('std1').feature('stat').setSolveFor('/physics/ec', true);

model.param.set('sigma_1', '1[S/m]');
model.param.descr('sigma_1', 'Conductivity, material 1');
model.param.set('sigma_2', '1[S/m]');
model.param.descr('sigma_2', 'Conductivity, material 2');

model.geom('geom1').create('sq1', 'Square');
model.geom('geom1').feature('sq1').set('pos', [0.05 0]);
model.geom('geom1').run('sq1');
model.geom('geom1').create('sq2', 'Square');
model.geom('geom1').feature('sq2').set('pos', [-1.05 0]);
model.geom('geom1').runPre('fin');
model.geom('geom1').create('c1', 'Circle');
model.geom('geom1').feature('c1').set('r', 0.245);
model.geom('geom1').feature('c1').set('pos', [0.55 0.5]);
model.geom('geom1').run('c1');
model.geom('geom1').create('c2', 'Circle');
model.geom('geom1').feature('c2').set('r', 0.25);
model.geom('geom1').feature('c2').set('pos', [-0.55 0.5]);
model.geom('geom1').feature('c2').setIndex('layer', 0.01, 0);
model.geom('geom1').run('fin');

model.selection.create('sel1', 'Explicit');
model.selection('sel1').model('comp1');
model.selection('sel1').set([2 3 4 5]);
model.selection('sel1').label('Full Fidelity');
model.selection.create('sel2', 'Explicit');
model.selection('sel2').model('comp1');
model.selection('sel2').geom(1);
model.selection('sel2').set([21 22 23 24]);
model.selection('sel2').label('Contact Impedance');
model.selection.create('com1', 'Complement');
model.selection('com1').model('comp1');
model.selection('com1').set('input', {'sel1'});
model.selection('com1').label('Bulk');

model.physics('ec').create('gnd1', 'Ground', 1);
model.physics('ec').feature('gnd1').selection.set([10]);
model.physics('ec').create('gnd2', 'Ground', 1);
model.physics('ec').feature('gnd2').selection.set([2]);
model.physics('ec').create('term1', 'Terminal', 1);
model.physics('ec').feature('term1').selection.set([11]);
model.physics('ec').feature('term1').set('TerminalType', 'Voltage');
model.physics('ec').create('term2', 'Terminal', 1);
model.physics('ec').feature('term2').selection.set([3]);
model.physics('ec').feature('term2').set('TerminalType', 'Voltage');
model.physics('ec').create('ci1', 'ContactImpedance', 1);
model.physics('ec').feature('ci1').selection.named('sel2');
model.physics('ec').feature('ci1').set('ds', '1[cm]');

model.material.create('mat1', 'Common', 'comp1');
model.material('mat1').selection.named('com1');
model.material('mat1').propertyGroup('def').set('electricconductivity', {'sigma_1'});
model.material('mat1').propertyGroup('def').set('relpermittivity', {'1'});
model.material.create('mat2', 'Common', 'comp1');
model.material('mat2').selection.named('sel1');
model.material('mat2').propertyGroup('def').set('electricconductivity', {'sigma_2'});
model.material('mat2').propertyGroup('def').set('relpermittivity', {'1'});
model.material.create('mat3', 'Common', 'comp1');
model.material('mat3').selection.geom('geom1', 1);
model.material('mat3').selection.named('sel2');
model.material('mat3').propertyGroup('def').set('electricconductivity', {'sigma_2'});
model.material('mat3').propertyGroup('def').set('relpermittivity', {'1'});

model.mesh('mesh1').run;

model.study('std1').create('param', 'Parametric');
model.study('std1').feature('param').setIndex('pname', 'sigma_1', 0);
model.study('std1').feature('param').setIndex('plistarr', '', 0);
model.study('std1').feature('param').setIndex('punit', 'S/m', 0);
model.study('std1').feature('param').setIndex('pname', 'sigma_1', 0);
model.study('std1').feature('param').setIndex('plistarr', '', 0);
model.study('std1').feature('param').setIndex('punit', 'S/m', 0);
model.study('std1').feature('param').setIndex('pname', 'sigma_2', 0);
model.study('std1').feature('param').setIndex('plistarr', '1 0.01 0.0001', 0);

model.sol.create('sol1');
model.sol('sol1').study('std1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'stat');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').set('control', 'stat');
model.sol('sol1').create('s1', 'Stationary');
model.sol('sol1').feature('s1').create('p1', 'Parametric');
model.sol('sol1').feature('s1').feature('p1').set('pname', {'sigma_2'});
model.sol('sol1').feature('s1').feature('p1').set('plistarr', {'1 0.01 0.0001'});
model.sol('sol1').feature('s1').feature('p1').set('punit', {'S/m'});
model.sol('sol1').feature('s1').feature('p1').set('sweeptype', 'sparse');
model.sol('sol1').feature('s1').feature('p1').set('preusesol', 'no');
model.sol('sol1').feature('s1').feature('p1').set('pcontinuationmode', 'no');
model.sol('sol1').feature('s1').feature('p1').set('plot', 'off');
model.sol('sol1').feature('s1').feature('p1').set('plotgroup', 'Default');
model.sol('sol1').feature('s1').feature('p1').set('probesel', 'all');
model.sol('sol1').feature('s1').feature('p1').set('probes', {});
model.sol('sol1').feature('s1').feature('p1').set('control', 'param');
model.sol('sol1').feature('s1').set('control', 'stat');
model.sol('sol1').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('s1').feature('fc1').set('linsolver', 'dDef');
model.sol('sol1').feature('s1').feature.remove('fcDef');
model.sol('sol1').attach('std1');
model.sol('sol1').runAll;

model.result.create('pg1', 'PlotGroup2D');
model.result('pg1').label('Electric Potential (ec)');
model.result('pg1').set('frametype', 'spatial');
model.result('pg1').set('showlegendsmaxmin', true);
model.result('pg1').set('data', 'dset1');
model.result('pg1').setIndex('looplevel', 3, 0);
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
model.result('pg1').feature('str1').selection.set([1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24]);
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
model.result('pg2').setIndex('looplevel', 3, 0);
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
model.result('pg2').feature('str1').selection.set([1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24]);
model.result('pg2').feature('str1').set('inheritplot', 'surf1');
model.result('pg2').feature('str1').feature.create('col1', 'Color');
model.result('pg2').feature('str1').feature('col1').set('expr', 'ec.normE');
model.result('pg2').feature('str1').feature('col1').set('colortable', 'PrismDark');
model.result('pg2').feature('str1').feature('col1').set('colorlegend', false);
model.result('pg2').feature('str1').feature('col1').set('colortabletrans', 'nonlinear');
model.result('pg2').feature('str1').feature('col1').set('colorcalibration', -0.8);
model.result('pg2').feature('str1').feature.create('filt1', 'Filter');
model.result('pg2').feature('str1').feature('filt1').set('expr', '!isScalingSystemDomain');
model.result('pg1').run;
model.result.dataset('dset1').selection.geom('geom1', 2);
model.result.dataset('dset1').selection.named('com1');
model.result.create('pg3', 'PlotGroup2D');
model.result('pg3').run;
model.result('pg3').label('Current Density (ec)');
model.result('pg3').create('surf1', 'Surface');
model.result('pg3').feature('surf1').set('expr', 'ec.normJ');
model.result('pg3').feature('surf1').set('descr', 'Current density norm');
model.result('pg3').feature('surf1').set('colortable', 'Prism');
model.result('pg3').run;
model.result('pg3').create('con1', 'Contour');
model.result('pg3').feature('con1').set('titletype', 'none');
model.result('pg3').feature('con1').set('inheritplot', 'surf1');
model.result('pg3').feature('con1').set('inheritcolor', false);
model.result('pg3').feature('con1').create('col1', 'Color');
model.result('pg3').run;
model.result('pg3').feature('con1').feature('col1').set('expr', 'ec.normJ');
model.result('pg3').feature('con1').feature('col1').set('descr', 'Current density norm');
model.result('pg3').feature('con1').feature('col1').set('colortable', 'PrismDark');
model.result('pg3').feature('con1').feature('col1').set('colorlegend', false);
model.result('pg3').run;
model.result('pg3').create('str1', 'Streamline');
model.result('pg3').feature('str1').selection.set([3 11]);
model.result('pg3').feature('str1').set('titletype', 'none');
model.result('pg3').feature('str1').set('inheritplot', 'surf1');
model.result('pg3').feature('str1').set('inheritcolor', false);
model.result('pg3').run;
model.result('pg3').run;
model.result('pg3').feature('str1').feature.copy('col1', 'pg3/con1/col1');
model.result('pg3').run;
model.result('pg3').run;
model.result('pg3').run;
model.result('pg3').setIndex('looplevel', 1, 0);
model.result('pg3').run;
model.result('pg3').setIndex('looplevel', 3, 0);
model.result('pg3').run;

model.title('Contact Impedance Comparison');

model.description('The contact impedance boundary condition approximates a thin layer of material that impedes the flow of current normal to the boundary but does not introduce any additional conduction path tangential to the boundary. This example compares the contact impedance boundary condition to a full-fidelity model and discusses the range of applicability of this boundary condition.');

model.label('contact_impedance_comparison.mph');

model.modelNode.label('Components');

out = model;
