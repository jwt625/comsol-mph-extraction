function out = model
%
% water_adsorption_desorption.m
%
% Model exported on May 26 2025, 21:30 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/Molecular_Flow_Module/Industrial_Applications');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 2);
model.geom('geom1').model('comp1');
model.geom('geom1').axisymmetric(true);

model.mesh.create('mesh1', 'geom1');

model.physics.create('fmf', 'FreeMolecularFlow', 'geom1', {'H2O'});

model.study.create('std1');
model.study('std1').create('time', 'Transient');
model.study('std1').feature('time').setSolveFor('/physics/fmf', true);

model.param.set('nsites', '1e-4[mol/m^2]');
model.param.descr('nsites', 'Density of adsorption sites');
model.param.set('tau', '200[s]');
model.param.descr('tau', 'Time constant for desorption');
model.param.set('sc', '0.1');
model.param.descr('sc', 'Sticking coefficient');

model.geom('geom1').create('c1', 'Circle');
model.geom('geom1').feature('c1').set('r', '16[in]');
model.geom('geom1').feature('c1').set('angle', 180);
model.geom('geom1').feature('c1').set('rot', 270);
model.geom('geom1').run('c1');
model.geom('geom1').create('r1', 'Rectangle');
model.geom('geom1').feature('r1').set('size', {'14[in]' '22[in]'});
model.geom('geom1').feature('r1').set('pos', {'0' '-46[in]'});
model.geom('geom1').run('r1');
model.geom('geom1').create('r2', 'Rectangle');
model.geom('geom1').feature('r2').set('size', {'7.5[in]' '70[in]'});
model.geom('geom1').feature('r2').set('pos', {'0' '-50[in]'});
model.geom('geom1').run('r2');
model.geom('geom1').create('pt1', 'Point');
model.geom('geom1').feature('pt1').setIndex('p', '7.5[in]', 0);
model.geom('geom1').feature('pt1').setIndex('p', '-20[in]', 1);
model.geom('geom1').run('pt1');
model.geom('geom1').create('uni1', 'Union');
model.geom('geom1').feature('uni1').selection('input').set({'c1' 'r1' 'r2'});
model.geom('geom1').feature('uni1').set('intbnd', false);
model.geom('geom1').run('uni1');
model.geom('geom1').create('r3', 'Rectangle');
model.geom('geom1').feature('r3').set('size', {'1.5[in]' '50[in]'});
model.geom('geom1').feature('r3').set('pos', {'0' '-50[in]'});
model.geom('geom1').run('r3');
model.geom('geom1').create('co1', 'Compose');
model.geom('geom1').feature('co1').selection('input').set({'r3' 'uni1'});
model.geom('geom1').feature('co1').set('formula', 'uni1-r3');
model.geom('geom1').run('co1');
model.geom('geom1').run;

model.physics('fmf').feature('fmfp1').setIndex('Mn_H2O', '0.018[kg/mol]', 0);
model.physics('fmf').feature('wall1').set('BCType', 'AdsorptionDesorption');
model.physics('fmf').feature('wall1').setIndex('S', 'sc*(1-fmf.n_ads_H2O/nsites)', 0);
model.physics('fmf').feature('wall1').setIndex('D', 'fmf.n_ads_H2O/tau', 0);
model.physics('fmf').feature('wall1').setIndex('n_ads_0', 0, 0);
model.physics('fmf').feature.duplicate('wall2', 'wall1');
model.physics('fmf').feature('wall2').selection.set([2 5 6 7 8 9 10 13]);
model.physics('fmf').feature('wall2').setIndex('n_ads_0', 'nsites', 0);
model.physics('fmf').create('pmp1', 'VacuumPump', 1);
model.physics('fmf').feature('pmp1').selection.set([4]);
model.physics('fmf').feature('pmp1').set('SpecifyPump', 'PumpSpeed');

model.mesh('mesh1').create('edg1', 'Edge');
model.mesh('mesh1').feature('edg1').selection.all;
model.mesh('mesh1').feature('size').set('hauto', 2);
model.mesh('mesh1').run;

model.study('std1').feature('time').set('tlist', 'range(0,100,1000) range(2000,1000,10000) 1e4*10^{range(0,0.1,1)}');
model.study('std1').feature('time').set('usertol', true);
model.study('std1').feature('time').set('rtol', '0.0001');

model.sol.create('sol1');
model.sol('sol1').study('std1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'time');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').feature('comp1_fmf_N_H2O').set('scalemethod', 'manual');
model.sol('sol1').feature('v1').feature('comp1_H2O').set('scalemethod', 'manual');
model.sol('sol1').feature('v1').feature('comp1_fmf_N_H2O').set('scaleval', 'N_A_const');
model.sol('sol1').feature('v1').feature('comp1_H2O').set('scaleval', 'N_A_const');
model.sol('sol1').feature('v1').set('control', 'time');
model.sol('sol1').create('t1', 'Time');
model.sol('sol1').feature('t1').set('tlist', 'range(0,100,1000) range(2000,1000,10000) 1e4*10^{range(0,0.1,1)}');
model.sol('sol1').feature('t1').set('plot', 'off');
model.sol('sol1').feature('t1').set('plotgroup', 'Default');
model.sol('sol1').feature('t1').set('plotfreq', 'tout');
model.sol('sol1').feature('t1').set('probesel', 'all');
model.sol('sol1').feature('t1').set('probes', {});
model.sol('sol1').feature('t1').set('probefreq', 'tsteps');
model.sol('sol1').feature('t1').set('rtol', 0.005);
model.sol('sol1').feature('t1').set('atolglobalvaluemethod', 'factor');
model.sol('sol1').feature('t1').set('reacf', true);
model.sol('sol1').feature('t1').set('storeudot', true);
model.sol('sol1').feature('t1').set('endtimeinterpolation', true);
model.sol('sol1').feature('t1').set('maxorder', 2);
model.sol('sol1').feature('t1').set('control', 'time');
model.sol('sol1').feature('t1').create('se1', 'Segregated');
model.sol('sol1').feature('t1').feature('se1').feature.remove('ssDef');
model.sol('sol1').feature('t1').feature('se1').create('ss1', 'SegregatedStep');
model.sol('sol1').feature('t1').feature('se1').feature('ss1').set('segvar', {'comp1_H2O'});
model.sol('sol1').feature('t1').create('d1', 'Direct');
model.sol('sol1').feature('t1').feature('d1').set('linsolver', 'pardiso');
model.sol('sol1').feature('t1').feature('d1').set('pivotperturb', 1.0E-13);
model.sol('sol1').feature('t1').feature('se1').feature('ss1').set('linsolver', 'd1');
model.sol('sol1').feature('t1').feature('se1').create('ss2', 'SegregatedStep');
model.sol('sol1').feature('t1').feature('se1').feature('ss2').set('segvar', {'comp1_fmf_p_H2O'});
model.sol('sol1').feature('t1').feature('se1').feature('ss2').set('linsolver', 'd1');
model.sol('sol1').feature('t1').feature('se1').create('ss3', 'SegregatedStep');
model.sol('sol1').feature('t1').feature('se1').feature('ss3').set('segvar', {'comp1_fmf_N_H2O'});
model.sol('sol1').feature('t1').feature('se1').feature('ss3').set('linsolver', 'd1');
model.sol('sol1').feature('t1').feature('se1').create('ss4', 'SegregatedStep');
model.sol('sol1').feature('t1').feature('se1').feature('ss4').set('segvar', {'comp1_fmf_n_ads_H2O'});
model.sol('sol1').feature('t1').feature('se1').feature('ss4').set('linsolver', 'd1');
model.sol('sol1').feature('t1').create('i1', 'Iterative');
model.sol('sol1').feature('t1').feature('i1').set('linsolver', 'gmres');
model.sol('sol1').feature('t1').feature.remove('fcDef');
model.sol('sol1').attach('std1');
model.sol('sol1').feature('t1').set('atolglobalvaluemethod', 'manual');
model.sol('sol1').feature('t1').set('atolglobal', '0.00001');
model.sol('sol1').runAll;

model.result.dataset.create('rev1', 'Revolve2D');
model.result.dataset('rev1').set('data', 'none');
model.result.dataset('rev1').set('startangle', 270);
model.result.dataset('rev1').set('revangle', 270);
model.result.dataset('rev1').set('data', 'dset1');
model.result.create('pg1', 'PlotGroup2D');
model.result('pg1').label('Incident Molecular Flux (fmf)');
model.result('pg1').set('dataisaxisym', 'off');
model.result('pg1').set('data', 'dset1');
model.result('pg1').setIndex('looplevel', 31, 0);
model.result('pg1').set('defaultPlotID', 'FreeMolecularFlow/phys1/pdef1/pcond3/pg2');
model.result('pg1').feature.create('line1', 'Line');
model.result('pg1').feature('line1').label('Line');
model.result('pg1').feature('line1').set('showsolutionparams', 'on');
model.result('pg1').feature('line1').set('expr', 'fmf.Gtot');
model.result('pg1').feature('line1').set('linetype', 'tube');
model.result('pg1').feature('line1').set('resolution', 'norefine');
model.result('pg1').feature('line1').set('smooth', 'internal');
model.result('pg1').feature('line1').set('showsolutionparams', 'on');
model.result('pg1').feature('line1').set('data', 'parent');
model.result.create('pg2', 'PlotGroup2D');
model.result('pg2').label('Total Number Density (fmf)');
model.result('pg2').set('dataisaxisym', 'off');
model.result('pg2').set('data', 'dset1');
model.result('pg2').setIndex('looplevel', 31, 0);
model.result('pg2').set('defaultPlotID', 'FreeMolecularFlow/phys1/pdef1/pcond3/pcond1/pg2');
model.result('pg2').feature.create('line1', 'Line');
model.result('pg2').feature('line1').label('Line');
model.result('pg2').feature('line1').set('showsolutionparams', 'on');
model.result('pg2').feature('line1').set('expr', 'fmf.ntot');
model.result('pg2').feature('line1').set('linetype', 'tube');
model.result('pg2').feature('line1').set('resolution', 'norefine');
model.result('pg2').feature('line1').set('smooth', 'internal');
model.result('pg2').feature('line1').set('showsolutionparams', 'on');
model.result('pg2').feature('line1').set('data', 'parent');
model.result.create('pg3', 'PlotGroup2D');
model.result('pg3').label('Total Pressure (fmf)');
model.result('pg3').set('dataisaxisym', 'off');
model.result('pg3').set('data', 'dset1');
model.result('pg3').setIndex('looplevel', 31, 0);
model.result('pg3').set('defaultPlotID', 'FreeMolecularFlow/phys1/pdef1/pcond3/pcond2/pg2');
model.result('pg3').feature.create('line1', 'Line');
model.result('pg3').feature('line1').label('Line');
model.result('pg3').feature('line1').set('showsolutionparams', 'on');
model.result('pg3').feature('line1').set('expr', 'fmf.ptot');
model.result('pg3').feature('line1').set('linetype', 'tube');
model.result('pg3').feature('line1').set('resolution', 'norefine');
model.result('pg3').feature('line1').set('smooth', 'internal');
model.result('pg3').feature('line1').set('showsolutionparams', 'on');
model.result('pg3').feature('line1').set('data', 'parent');
model.result('pg1').run;
model.result.create('pg4', 'PlotGroup3D');
model.result('pg4').run;
model.result('pg4').label('Adsorbed Molecules');
model.result('pg4').create('surf1', 'Surface');
model.result('pg4').feature('surf1').set('expr', 'fmf.N_ads_H2O');
model.result('pg4').feature('surf1').set('descr', 'Adsorbed molecules per unit area');
model.result('pg4').feature('surf1').set('colortable', 'Plasma');
model.result('pg4').run;
model.result('pg4').run;
model.result('pg4').setIndex('looplevel', 13, 0);
model.result('pg4').run;
model.result('pg4').setIndex('looplevel', 8, 0);
model.result('pg4').run;
model.result('pg4').setIndex('looplevel', 1, 0);
model.result('pg4').run;
model.result.create('pg5', 'PlotGroup1D');
model.result('pg5').run;
model.result('pg5').label('Pressure vs. Time');
model.result('pg5').set('axislimits', true);
model.result('pg5').set('xmin', 0.02);
model.result('pg5').set('xmax', 40);
model.result('pg5').set('ymin', '4e-9');
model.result('pg5').set('ymax', '1.8e-6');
model.result('pg5').set('xlog', true);
model.result('pg5').set('ylog', true);
model.result('pg5').create('ptgr1', 'PointGraph');
model.result('pg5').feature('ptgr1').set('markerpos', 'datapoints');
model.result('pg5').feature('ptgr1').set('linewidth', 'preference');
model.result('pg5').feature('ptgr1').selection.set([13 15]);
model.result('pg5').feature('ptgr1').set('expr', 'fmf.ptot');
model.result('pg5').feature('ptgr1').set('unit', 'torr');
model.result('pg5').feature('ptgr1').set('xdata', 'expr');
model.result('pg5').feature('ptgr1').set('xdataexpr', 't');
model.result('pg5').feature('ptgr1').set('xdataunit', 'h');
model.result('pg5').feature('ptgr1').set('legend', true);
model.result('pg5').feature('ptgr1').set('legendmethod', 'manual');
model.result('pg5').feature('ptgr1').setIndex('legends', 'Load Lock', 0);
model.result('pg5').feature('ptgr1').setIndex('legends', 'Chamber', 1);
model.result('pg5').run;
model.result('pg5').run;
model.result.duplicate('pg6', 'pg5');
model.result('pg6').run;
model.result('pg6').label('Adsorbed Molecules vs. Time');
model.result('pg6').set('ymin', '5e17');
model.result('pg6').set('ymax', 1.1E20);
model.result('pg6').run;
model.result('pg6').feature('ptgr1').set('expr', 'fmf.N_ads_H2O');
model.result('pg6').feature('ptgr1').set('descr', 'Adsorbed molecules per unit area');
model.result('pg6').run;

model.title('Adsorption and Desorption of Water in a Load Lock Vacuum System');

model.description('This example shows how to model the time-dependent adsorption and desorption of water in a vacuum system at low pressures. The water is introduced into the system when a gate valve to a load lock is opened and the subsequent migration and pumping of the water is modeled.');

model.label('water_adsorption_desorption.mph');

model.modelNode.label('Components');

out = model;
