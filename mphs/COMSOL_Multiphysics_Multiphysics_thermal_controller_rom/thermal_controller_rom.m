function out = model
%
% thermal_controller_rom.m
%
% Model exported on May 26 2025, 21:27 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/COMSOL_Multiphysics/Multiphysics');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 2);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.geom('geom1').create('r1', 'Rectangle');
model.geom('geom1').feature('r1').set('size', [0.3 0.2]);
model.geom('geom1').run('r1');
model.geom('geom1').create('sq1', 'Square');
model.geom('geom1').feature('sq1').set('size', 0.04);
model.geom('geom1').feature('sq1').set('pos', [0.1 0.1]);
model.geom('geom1').feature('sq1').set('base', 'center');
model.geom('geom1').run('sq1');
model.geom('geom1').create('pt1', 'Point');
model.geom('geom1').feature('pt1').setIndex('p', '0.05,0.2', 0);
model.geom('geom1').feature('pt1').setIndex('p', '0.1,0.1', 1);
model.geom('geom1').run('fin');

model.physics.create('hteq', 'HeatEquation', 'geom1');
model.physics('hteq').model('comp1');
model.physics('hteq').prop('EquationForm').set('form', 'Automatic');
model.physics('hteq').field('dimensionless').field('T');

model.param.set('Tset', '293.15[K]');
model.param.descr('Tset', 'Setpoint temperature');
model.param.set('kiso', '4.92e3[W/(m*K)]');
model.param.descr('kiso', 'Thermal conductivity');
model.param.set('rho', '7.82e3[kg/m^3]');
model.param.descr('rho', 'Density');
model.param.set('Cp', '449[J/(kg*K)]');
model.param.descr('Cp', 'Heat capacity');

model.common.create('grmi1', 'GlobalReducedModelInputs', '');
model.common('grmi1').setIndex('name', 'Tout', 0);
model.common('grmi1').setIndex('expression', '(293.15[K]-5[K])+(10[K]*sin(2*pi*t/120[s]))', 0);
model.common('grmi1').setIndex('name', 'HeatState', 1);
model.common('grmi1').setIndex('expression', 1, 1);

model.physics('hteq').feature('hteq1').setIndex('c', {'kiso' '0' '0' 'kiso'}, 0);
model.physics('hteq').feature('hteq1').setIndex('f', 0, 0);
model.physics('hteq').feature('hteq1').setIndex('da', 'rho*Cp', 0);
model.physics('hteq').feature('init1').set('T', '293.15[K]');
model.physics('hteq').create('src1', 'SourceTerm', 2);
model.physics('hteq').feature('src1').selection.set([2]);
model.physics('hteq').feature('src1').setIndex('f', '7.5e7[W/(m^3)]*HeatState', 0);
model.physics('hteq').create('flux1', 'FluxBoundary', 1);
model.physics('hteq').feature('flux1').selection.set([1]);
model.physics('hteq').feature('flux1').setIndex('g', '(54/1e-3)[W/(m^2*K)]*(Tout-T)', 0);

model.probe.create('pdom1', 'DomainPoint');
model.probe('pdom1').model('comp1');
model.probe('pdom1').setIndex('coords2', 0.05, 0);
model.probe('pdom1').setIndex('coords2', 0.1, 1);
model.probe('pdom1').label('Thermostat position 1');
model.probe.duplicate('pdom2', 'pdom1');
model.probe('pdom2').label('Thermostat position 2');
model.probe('pdom2').setIndex('coords2', 0.2, 0);
model.probe('pdom1').feature('ppb1').label('Temperature 1');
model.probe('pdom2').feature('ppb2').label('Temperature 2');

model.modelNode.create('comp2', true);

model.variable.create('var1');
model.variable('var1').model('comp2');
model.variable('var1').set('Tmeasured', 'comp1.ppb1');

model.physics.create('ev', 'Events');
model.physics('ev').model('comp2');
model.physics('ev').create('is1', 'IndicatorStates', -1);
model.physics('ev').feature('is1').setIndex('indDim', 'lowtemp', 0, 0);
model.physics('ev').feature('is1').setIndex('g', 0, 0, 0);
model.physics('ev').feature('is1').setIndex('dimInit', 0, 0, 0);
model.physics('ev').feature('is1').setIndex('g', '(Tset-1)-Tmeasured', 0, 0);
model.physics('ev').feature('is1').setIndex('dimInit', -1, 0, 0);
model.physics('ev').feature('is1').setIndex('indDim', 'hightemp', 1, 0);
model.physics('ev').feature('is1').setIndex('g', 0, 1, 0);
model.physics('ev').feature('is1').setIndex('dimInit', 0, 1, 0);
model.physics('ev').feature('is1').setIndex('dimDescr', '', 1, 0);
model.physics('ev').feature('is1').setIndex('g', 'Tmeasured-(Tset+1)', 1, 0);
model.physics('ev').feature('is1').setIndex('dimInit', 1, 1, 0);
model.physics('ev').create('ds1', 'DiscreteStates', -1);
model.physics('ev').feature('ds1').setIndex('dim', 'relay', 0, 0);
model.physics('ev').feature('ds1').setIndex('dimInit', 0, 0, 0);
model.physics('ev').feature('ds1').setIndex('dimInit', 'if(Tset > 293.15,1,0)', 0, 0);
model.physics('ev').create('impl1', 'ImplicitEvent', -1);
model.physics('ev').feature('impl1').set('condition', 'lowtemp > 0');
model.physics('ev').feature('impl1').set('useConsistentInit', false);
model.physics('ev').feature('impl1').setIndex('reInitName', 'relay', 0, 0);
model.physics('ev').feature('impl1').setIndex('reInitValue', 0, 0, 0);
model.physics('ev').feature('impl1').setIndex('reInitValue', 1, 0, 0);
model.physics('ev').create('impl2', 'ImplicitEvent', -1);
model.physics('ev').feature('impl2').set('condition', 'hightemp > 0');
model.physics('ev').feature('impl2').set('useConsistentInit', false);
model.physics('ev').feature('impl2').setIndex('reInitName', 'relay', 0, 0);
model.physics('ev').feature('impl2').setIndex('reInitValue', 0, 0, 0);

model.common('grmi1').setIndex('expression', 'comp2.relay', 1);

model.study.create('std1');
model.study('std1').create('time', 'Transient');
model.study('std1').feature('time').setSolveFor('/physics/hteq', true);
model.study('std1').feature('time').setSolveFor('/physics/ev', true);
model.study('std1').feature('time').set('tunit', 'min');
model.study('std1').feature('time').set('tlist', 'range(0,0.1,5)');

model.sol.create('sol1');
model.sol('sol1').study('std1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'time');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').set('control', 'time');
model.sol('sol1').create('t1', 'Time');
model.sol('sol1').feature('t1').set('tlist', 'range(0,0.1,5)');
model.sol('sol1').feature('t1').set('plot', 'off');
model.sol('sol1').feature('t1').set('plotgroup', 'Default');
model.sol('sol1').feature('t1').set('plotfreq', 'tout');
model.sol('sol1').feature('t1').set('probesel', 'all');
model.sol('sol1').feature('t1').set('probes', {'pdom1' 'pdom2'});
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
model.sol('sol1').feature('t1').set('tstepsbdf', 'manual');
model.sol('sol1').feature('t1').set('timestepbdf', '0.1');

model.probe('pdom1').genResult('none');
model.probe('pdom2').genResult('none');

model.sol('sol1').runAll;

model.result.create('pg2', 'PlotGroup2D');
model.result('pg2').set('data', 'dset1');
model.result('pg2').setIndex('looplevel', 51, 0);
model.result('pg2').create('surf1', 'Surface');
model.result('pg2').label('Heat Equation');
model.result('pg2').feature('surf1').set('expr', 'T');
model.result('pg2').run;
model.result.table.duplicate('tbl2', 'tbl1');
model.result.table('tbl2').label('Full model outputs Tset = 20 degrees C, position 1');

model.study.create('std2');
model.study('std2').setGenPlots(false);
model.study('std2').setGenConv(false);
model.study('std2').create('eigv', 'Eigenvalue');
model.study('std2').feature('eigv').set('neigsactive', true);

model.sol.create('sol2');
model.sol('sol2').study('std2');
model.sol('sol2').create('st1', 'StudyStep');
model.sol('sol2').feature('st1').set('study', 'std2');
model.sol('sol2').feature('st1').set('studystep', 'eigv');
model.sol('sol2').create('v1', 'Variables');
model.sol('sol2').feature('v1').set('control', 'eigv');
model.sol('sol2').create('e1', 'Eigenvalue');
model.sol('sol2').feature('e1').set('control', 'eigv');
model.sol('sol2').attach('std2');

model.probe('pdom1').genResult('none');
model.probe('pdom2').genResult('none');

model.sol('sol2').runAll;

model.study.create('std3');
model.study('std3').setGenPlots(false);
model.study('std3').setGenConv(false);
model.study('std3').create('mr', 'ModelReduction');
model.study('std3').feature('mr').set('trainingStudy', 'std2');
model.study('std3').feature('mr').set('unreducedModelStudy', 'std1');
model.study('std3').feature('mr').set('unreducedModelStep', 'time');
model.study('std3').feature('mr').setIndex('qoiname', 'T1', 0);
model.study('std3').feature('mr').setIndex('qoiexpr', 'comp1.ppb1', 0);
model.study('std3').feature('mr').setIndex('qoidescr', 'Temperature at 1', 0);
model.study('std3').feature('mr').setIndex('qoiname', 'T2', 1);
model.study('std3').feature('mr').setIndex('qoiexpr', 'comp1.ppb2', 1);
model.study('std3').feature('mr').setIndex('qoidescr', 'Temperature at 2', 1);
model.study('std3').feature('mr').setEntry('trainingExpression', 'Tout', 293.15);
model.study('std3').feature('mr').setEntry('trainingExpression', 'HeatState', 1);
model.study('std3').feature('mr').set('romReconstruct', false);
model.study('std1').feature('time').setEntry('activate', 'ev', false);

model.sol.create('sol3');
model.sol('sol3').study('std3');
model.sol('sol3').create('st1', 'StudyStep');
model.sol('sol3').feature('st1').set('study', 'std3');
model.sol('sol3').feature('st1').set('studystep', 'mr');
model.sol('sol3').create('v1', 'Variables');
model.sol('sol3').feature('v1').set('control', 'mr');
model.sol('sol3').create('mor1', 'ModalReduction');
model.sol('sol3').feature('mor1').set('analysistype', 'transient');
model.sol('sol3').feature('mor1').set('control', 'mr');
model.sol('sol3').feature('v1').set('resscalemethod', 'manual');
model.sol('sol3').create('st2', 'StudyStep');
model.sol('sol3').feature('st2').set('study', 'std3');
model.sol('sol3').feature('st2').set('studystep', 'mr');
model.sol('sol3').feature('st2').set('useForModelReduction', false);
model.sol('sol3').feature('mor1').set('control', 'mr');
model.sol('sol3').attach('std3');
model.sol('sol3').runAll;

model.variable('var1').set('Tmeasured', 'rom1.T1');

model.probe.create('var1', 'GlobalVariable');
model.probe('var1').model('comp1');
model.probe('var1').set('expr', 'rom1.T1');
model.probe.create('var2', 'GlobalVariable');
model.probe('var2').model('comp1');
model.probe('var2').set('expr', 'rom1.T2');

model.study.create('std4');
model.study('std4').create('time', 'Transient');
model.study('std4').feature('time').setSolveFor('/physics/hteq', true);
model.study('std4').feature('time').setSolveFor('/physics/ev', true);
model.study('std4').feature('time').setEntry('activate', 'hteq', false);
model.study('std4').feature('time').set('tunit', 'min');
model.study('std4').feature('time').set('tlist', 'range(0,0.1,5)');
model.study('std4').feature('time').set('probesel', 'manual');
model.study('std4').feature('time').set('probes', {'var1' 'var2'});
model.study('std4').setGenPlots(false);
model.study('std4').setGenConv(false);

model.sol.create('sol4');
model.sol('sol4').study('std4');
model.sol('sol4').create('st1', 'StudyStep');
model.sol('sol4').feature('st1').set('study', 'std4');
model.sol('sol4').feature('st1').set('studystep', 'time');
model.sol('sol4').create('v1', 'Variables');
model.sol('sol4').feature('v1').set('control', 'time');
model.sol('sol4').create('t1', 'Time');
model.sol('sol4').feature('t1').set('tlist', 'range(0,0.1,5)');
model.sol('sol4').feature('t1').set('plot', 'off');
model.sol('sol4').feature('t1').set('plotgroup', 'pg1');
model.sol('sol4').feature('t1').set('plotfreq', 'tout');
model.sol('sol4').feature('t1').set('probesel', 'manual');
model.sol('sol4').feature('t1').set('probes', {'var1' 'var2'});
model.sol('sol4').feature('t1').set('probefreq', 'tsteps');
model.sol('sol4').feature('t1').set('atolglobalvaluemethod', 'factor');
model.sol('sol4').feature('t1').set('endtimeinterpolation', true);
model.sol('sol4').feature('t1').set('control', 'time');
model.sol('sol4').feature('t1').create('fc1', 'FullyCoupled');
model.sol('sol4').feature('t1').feature('fc1').set('linsolver', 'dDef');
model.sol('sol4').feature('t1').feature.remove('fcDef');
model.sol('sol4').attach('std4');
model.sol('sol4').feature('t1').set('tstepsbdf', 'manual');
model.sol('sol4').feature('t1').set('timestepbdf', '0.1');

model.probe('var1').genResult('none');
model.probe('var2').genResult('none');

model.sol('sol4').runAll;

model.result.table.duplicate('tbl3', 'tbl1');
model.result.table('tbl3').label('Reduced Model outputs, 6 modes Tset = 20 degrees C, position 1');
model.result('pg1').set('window', 'window1');
model.result('pg1').run;
model.result.duplicate('pg3', 'pg1');
model.result('pg3').set('window', 'window1');
model.result('pg3').run;
model.result('pg3').label('Full and Reduced Model outputs, 6 modes Tset = 20 degrees C, position 1');
model.result('pg3').set('titletype', 'manual');
model.result('pg3').set('title', 'Full and Reduced Model outputs, 6 modes Tset = 20 degrees C, position 1');
model.result('pg3').set('window', 'window1');
model.result('pg3').run;
model.result('pg3').feature('tblp1').label('Full model output table graph');
model.result('pg3').feature('tblp1').set('table', 'tbl2');
model.result('pg3').feature.duplicate('tblp2', 'tblp1');
model.result('pg3').set('window', 'window1');
model.result('pg3').run;
model.result('pg3').feature('tblp2').label('Reduced model output table graph');
model.result('pg3').feature('tblp2').set('table', 'tbl3');
model.result('pg3').set('window', 'window1');
model.result('pg3').run;
model.result('pg3').set('window', 'window1');
model.result('pg3').run;

model.study('std2').feature('eigv').set('neigs', 30);

model.sol('sol2').study('std2');
model.sol('sol2').feature.remove('e1');
model.sol('sol2').feature.remove('v1');
model.sol('sol2').feature.remove('st1');
model.sol('sol2').create('st1', 'StudyStep');
model.sol('sol2').feature('st1').set('study', 'std2');
model.sol('sol2').feature('st1').set('studystep', 'eigv');
model.sol('sol2').create('v1', 'Variables');
model.sol('sol2').feature('v1').set('control', 'eigv');
model.sol('sol2').create('e1', 'Eigenvalue');
model.sol('sol2').feature('e1').set('control', 'eigv');
model.sol('sol3').feature('mor1').set('linearity', 'off');
model.sol('sol3').feature('mor1').set('eigsoluse', 'current');
model.sol('sol3').feature('mor1').set('analysistype', 'transient');
model.sol('sol2').attach('std2');

model.probe('pdom1').genResult('none');
model.probe('pdom2').genResult('none');
model.probe('var1').genResult('none');
model.probe('var2').genResult('none');

model.sol('sol2').runAll;
model.sol('sol3').study('std3');
model.sol('sol3').feature.remove('st2');
model.sol('sol3').feature.remove('mor1');
model.sol('sol3').feature.remove('v1');
model.sol('sol3').feature.remove('st1');
model.sol('sol3').create('st1', 'StudyStep');
model.sol('sol3').feature('st1').set('study', 'std3');
model.sol('sol3').feature('st1').set('studystep', 'mr');
model.sol('sol3').create('v1', 'Variables');
model.sol('sol3').feature('v1').set('control', 'mr');
model.sol('sol3').create('mor1', 'ModalReduction');
model.sol('sol3').feature('mor1').set('analysistype', 'transient');
model.sol('sol3').feature('mor1').set('control', 'mr');
model.sol('sol3').feature('v1').set('resscalemethod', 'manual');
model.sol('sol3').create('st2', 'StudyStep');
model.sol('sol3').feature('st2').set('study', 'std3');
model.sol('sol3').feature('st2').set('studystep', 'mr');
model.sol('sol3').feature('st2').set('useForModelReduction', false);
model.sol('sol3').feature('mor1').set('control', 'mr');
model.sol('sol3').attach('std3');
model.sol('sol3').runAll;

model.probe('var1').genResult('none');
model.probe('var2').genResult('none');

model.sol('sol4').runAll;

model.result.table.duplicate('tbl4', 'tbl1');
model.result.table('tbl4').label('Reduced Model outputs, 30 modes Tset = 20 degrees C, position 1');
model.result('pg1').set('window', 'window1');
model.result('pg1').run;
model.result.duplicate('pg4', 'pg1');
model.result('pg4').set('window', 'window1');
model.result('pg4').run;
model.result('pg4').label('Full and Reduced Model outputs, 30 modes Tset = 20 degrees C, position 1');
model.result('pg4').set('titletype', 'manual');
model.result('pg4').set('title', 'Full and Reduced Model outputs, 30 modes Tset = 20 degrees C, position 1');
model.result('pg4').set('window', 'window1');
model.result('pg4').run;
model.result('pg4').feature('tblp1').label('Full model output table graph');
model.result('pg4').feature('tblp1').set('table', 'tbl2');
model.result('pg4').feature.duplicate('tblp2', 'tblp1');
model.result('pg4').set('window', 'window1');
model.result('pg4').run;
model.result('pg4').feature('tblp2').label('Reduced model output table graph');
model.result('pg4').feature('tblp2').set('table', 'tbl4');
model.result('pg4').set('window', 'window1');
model.result('pg4').run;
model.result('pg4').set('window', 'window1');
model.result('pg4').run;

model.param.set('Tset', '300[K]');

model.probe('var1').genResult('none');
model.probe('var2').genResult('none');

model.sol('sol4').runAll;

model.result.table.duplicate('tbl5', 'tbl1');
model.result.table('tbl5').label('Reduced Model outputs, 30 modes Tset = 300 K, position 1');
model.result('pg1').set('window', 'window1');
model.result('pg1').run;
model.result.duplicate('pg5', 'pg1');
model.result('pg5').set('window', 'window1');
model.result('pg5').run;
model.result('pg5').label('Reduced Model outputs, 30 modes Tset = 300 K, position 1');
model.result('pg5').set('titletype', 'manual');
model.result('pg5').set('title', 'Reduced Model outputs, 30 modes Tset = 300 K, position 1');
model.result('pg5').set('window', 'window1');
model.result('pg5').run;
model.result('pg5').feature('tblp1').set('table', 'tbl5');

model.variable('var1').set('Tmeasured', 'rom1.T2');

model.probe('var1').genResult('none');
model.probe('var2').genResult('none');

model.sol('sol4').runAll;

model.result.table.duplicate('tbl6', 'tbl1');
model.result.table('tbl6').label('Reduced Model outputs, 30 modes Tset = 300 K, position 2');
model.result('pg1').set('window', 'window1');
model.result('pg1').run;
model.result.duplicate('pg6', 'pg1');
model.result('pg6').set('window', 'window1');
model.result('pg6').run;
model.result('pg6').label('Reduced Model outputs, 30 modes Tset = 300 K, position 2');
model.result('pg6').set('titletype', 'manual');
model.result('pg6').set('title', 'Reduced Model outputs, 30 modes Tset = 300 K, position 2');
model.result('pg6').set('window', 'window1');
model.result('pg6').run;
model.result('pg6').feature('tblp1').set('table', 'tbl6');

model.variable('var1').set('Tmeasured', 'comp1.ppb2');

model.study('std1').feature('time').setEntry('activate', 'ev', true);
model.study('std1').feature('time').set('probesel', 'manual');
model.study('std1').feature('time').set('probes', {'pdom1' 'pdom2'});

model.probe('pdom1').genResult('none');
model.probe('pdom2').genResult('none');

model.sol('sol1').runAll;

model.result('pg2').run;
model.result.table.duplicate('tbl7', 'tbl1');
model.result.table('tbl7').label('Full Model outputs, Tset = 300 K, position 2');
model.result('pg1').set('window', 'window1');
model.result('pg1').run;
model.result.duplicate('pg7', 'pg1');
model.result('pg7').set('window', 'window1');
model.result('pg7').run;
model.result('pg7').label('Full and Reduced Model outputs, 30 modes Tset = 300 K, position 2');
model.result('pg7').set('titletype', 'manual');
model.result('pg7').set('title', 'Full and Reduced Model outputs, 30 modes Tset = 300 K, position 2');
model.result('pg7').set('window', 'window1');
model.result('pg7').run;
model.result('pg7').feature('tblp1').label('Full model output table graph');
model.result('pg7').feature('tblp1').set('table', 'tbl7');
model.result('pg7').feature.duplicate('tblp2', 'tblp1');
model.result('pg7').set('window', 'window1');
model.result('pg7').run;
model.result('pg7').feature('tblp2').label('Reduced model output table graph');
model.result('pg7').feature('tblp2').set('table', 'tbl6');
model.result('pg7').set('window', 'window1');
model.result('pg7').run;

model.title('Thermal Controller, Reduced-Order Model');

model.description('Large FEM simulations can be costly, and if repeated simulations are needed it can be beneficial to use reduced-order models (ROMs). ROMs are typically valid only in the vicinity of their design conditions and have lower accuracy, but the simulation time is significantly shorter. The objective for model reduction is to provide a sufficiently accurate representation of the input-output dynamics of the unreduced model in a given parameter range with a minimal total computational cost, including the cost of creating the reduced model. The dynamical system consists of a metal block that exchanges heat with the exterior. Inside is a heater and a thermostat switch. The system works in a very simple manner: The thermostat turns the heater on and off when its temperature is too low or too high. In this tutorial model, it is illustrated how to create a reduced-order model using the Model Reduction study and how the resulting Reduced Model can be used to investigate different control strategies for thermal control. To illustrate the accuracy of the reduced model a comparison with the output from the FEM model is also included.');

model.label('thermal_controller_rom.mph');

model.modelNode.label('Components');

out = model;
