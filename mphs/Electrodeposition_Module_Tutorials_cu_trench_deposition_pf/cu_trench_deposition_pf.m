function out = model
%
% cu_trench_deposition_pf.m
%
% Model exported on May 26 2025, 21:28 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/Electrodeposition_Module/Tutorials');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 2);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.physics.create('tcd', 'TertiaryCurrentDistributionNernstPlanck', 'geom1', {'cCu' 'cSO4'});
model.physics.create('pf', 'PhaseField', 'geom1');
model.physics('pf').model('comp1');

model.study.create('std1');
model.study('std1').create('cdi', 'CurrentDistributionInitialization');
model.study('std1').feature('cdi').set('solnum', 'auto');
model.study('std1').feature('cdi').set('notsolnum', 'auto');
model.study('std1').feature('cdi').set('outputmap', {});
model.study('std1').feature('cdi').set('ngenAUX', '1');
model.study('std1').feature('cdi').set('goalngenAUX', '1');
model.study('std1').feature('cdi').set('ngenAUX', '1');
model.study('std1').feature('cdi').set('goalngenAUX', '1');
model.study('std1').feature('cdi').setSolveFor('/physics/tcd', true);
model.study('std1').feature('cdi').setSolveFor('/physics/pf', true);
model.study('std1').create('time', 'Transient');
model.study('std1').feature('time').set('initialtime', '0');
model.study('std1').feature('time').set('solnum', 'auto');
model.study('std1').feature('time').set('notsolnum', 'auto');
model.study('std1').feature('time').set('outputmap', {});
model.study('std1').feature('time').setSolveFor('/physics/tcd', true);
model.study('std1').feature('time').setSolveFor('/physics/pf', true);

model.geom('geom1').create('r1', 'Rectangle');
model.geom('geom1').feature('r1').set('size', {'1.6e-5' '3e-5'});
model.geom('geom1').feature('r1').set('pos', {'-0.8e-5' '1e-5'});
model.geom('geom1').run('r1');
model.geom('geom1').create('r2', 'Rectangle');
model.geom('geom1').feature('r2').set('size', {'0.4e-5' '1e-5'});
model.geom('geom1').feature('r2').set('pos', {'-0.2e-5' '0'});
model.geom('geom1').run('r2');
model.geom('geom1').create('uni1', 'Union');
model.geom('geom1').feature('uni1').set('intbnd', false);
model.geom('geom1').feature('uni1').selection('input').set({'r1' 'r2'});
model.geom('geom1').run('uni1');
model.geom('geom1').create('fil1', 'Fillet');
model.geom('geom1').feature('fil1').selection('point').set('uni1', [3 4 5 6]);
model.geom('geom1').feature('fil1').set('radius', '1e-6');
model.geom('geom1').run('fin');

% To import content from file, use:
% model.param.loadFile('FILENAME');
model.param.set('Cinit', '500[mol/(m^3)]', 'Initial concentration');
model.param.set('T0', '298[K]', 'System temperature');
model.param.set('i0', '150[A/m^2]', 'Exchange current density');
model.param.set('Eeq_rel', '0[V]', 'Relative equilibrium potential');
model.param.set('phis_anode', '0.135[V]', 'Anode potential');
model.param.set('phis_cathode', '-0.135[V]', 'Cathode potential');
model.param.set('alpha_c', '0.5[1]', 'Symmetry factor');
model.param.set('alpha_a', '1.5[1]', 'Symmetry factor');
model.param.set('z_net', '2[1]', 'Net species charge');
model.param.set('z_Cu', 'z_net[1]', 'Charge, species Cu');
model.param.set('z_SO4', '-z_net[1]', 'Charge, species SO4');
model.param.set('D_Cu', '2e-9[m^2/s]', 'Diffusivity, species Cu');
model.param.set('D_SO4', 'D_Cu', 'Diffusivity, species SO4');
model.param.set('MCu', '0.06355[kg/mol]', 'Molar mass of copper');
model.param.set('rhoCu', '8960[kg/m^3]', 'Density of copper');

model.variable.create('var1');
model.variable('var1').model('comp1');

% To import content from file, use:
% model.variable('var1').loadFile('FILENAME');
model.variable('var1').set('epsl', 'max(pf.Vf1,1e-2)', 'Electrolyte volume fraction');
model.variable('var1').set('Vn', '-tcd.iloc_per1*MCu/2/F_const/rhoCu', 'Deposition velocity');

model.physics('tcd').feature('sp1').setIndex('z', 'z_Cu', 0);
model.physics('tcd').feature('sp1').setIndex('z', 'z_SO4', 1);
model.physics('tcd').create('hcpce1', 'HighlyConductivePorousElectrode', 2);
model.physics('tcd').feature('hcpce1').selection.all;
model.physics('tcd').feature('hcpce1').set('D_cCu', {'D_Cu' '0' '0' '0' 'D_Cu' '0' '0' '0' 'D_Cu'});
model.physics('tcd').feature('hcpce1').set('D_cSO4', {'D_SO4' '0' '0' '0' 'D_SO4' '0' '0' '0' 'D_SO4'});
model.physics('tcd').feature('hcpce1').set('epsl', 'epsl');
model.physics('tcd').feature('hcpce1').set('DiffusionCorrModel', 'userdef');
model.physics('tcd').feature('hcpce1').set('fDl', 'epsl');
model.physics('tcd').feature('hcpce1').set('phisext0', 'phis_cathode');
model.physics('tcd').feature('hcpce1').feature('per1').set('nm', 2);
model.physics('tcd').feature('hcpce1').feature('per1').set('Eeq_mat', 'userdef');
model.physics('tcd').feature('hcpce1').feature('per1').set('Eeq', 'Eeq_rel');
model.physics('tcd').feature('hcpce1').feature('per1').set('ElectrodeKinetics', 'ConcentrationDependentKinetics');
model.physics('tcd').feature('hcpce1').feature('per1').set('i0', 'i0');
model.physics('tcd').feature('hcpce1').feature('per1').set('alphaa', 'alpha_a');
model.physics('tcd').feature('hcpce1').feature('per1').set('alphac', 'alpha_c');
model.physics('tcd').feature('hcpce1').feature('per1').set('CO', 'cCu/Cinit');
model.physics('tcd').feature('hcpce1').feature('per1').set('Av', 'pf.delta');
model.physics('tcd').create('es1', 'ElectrodeSurface', 1);
model.physics('tcd').feature('es1').selection.set([3]);
model.physics('tcd').feature('es1').set('phisext0', 'phis_anode');
model.physics('tcd').feature('es1').setIndex('Species', 's1', 0, 0);
model.physics('tcd').feature('es1').setIndex('rhos', 8960, 0, 0);
model.physics('tcd').feature('es1').setIndex('Ms', 0.06355, 0, 0);
model.physics('tcd').feature('es1').setIndex('Species', 's1', 0, 0);
model.physics('tcd').feature('es1').setIndex('rhos', 8960, 0, 0);
model.physics('tcd').feature('es1').setIndex('Ms', 0.06355, 0, 0);
model.physics('tcd').feature('es1').setIndex('Species', 'cdep_anode', 0, 0);
model.physics('tcd').feature('es1').feature('er1').set('nm', 2);
model.physics('tcd').feature('es1').feature('er1').set('i0_ref', 'i0');
model.physics('tcd').feature('es1').feature('er1').set('alphaa', 'alpha_a');
model.physics('tcd').feature('init1').setIndex('initc', 'Cinit', 1);
model.physics('pf').prop('ShapeProperty').set('order_phasefield', 2);
model.physics('pf').feature('pfm1').set('epsilon_pf', 'pf.hmax/16');
model.physics('pf').feature('pfm1').set('chiOption', 'velocity');
model.physics('pf').feature('pfm1').set('U', 'max(Vn,eps)');
model.physics('pf').feature('pfm1').set('u', {'-Vn*pf.intnormx' '-Vn*pf.intnormy' '0'});
model.physics('pf').create('inl1', 'InletBoundary', 1);
model.physics('pf').feature('inl1').selection.set([2 4 5 6 7 9 10 11 12]);
model.physics('pf').feature('inl1').set('pfcond', 'Fluid2pf');
model.physics('pf').create('out1', 'Outlet', 1);
model.physics('pf').feature('out1').selection.set([1 3 8]);

model.common('cminpt').set('modified', {'temperature' 'T0'});

model.mesh('mesh1').automatic(false);
model.mesh('mesh1').feature('size').set('hauto', 5);
model.mesh('mesh1').create('ref1', 'Refine');
model.mesh('mesh1').feature('ref1').set('boxcoord', true);
model.mesh('mesh1').feature('ref1').set('xmin', '-1E-5');
model.mesh('mesh1').feature('ref1').set('xmax', '1E-5');
model.mesh('mesh1').feature('ref1').set('ymin', '-8E-7');
model.mesh('mesh1').feature('ref1').set('ymax', '2E-5');
model.mesh('mesh1').run;

model.study('std1').feature('time').set('tlist', 'range(0,0.5,20)');

model.sol.create('sol1');

model.mesh('mesh1').stat.selection.geom(2);
model.mesh('mesh1').stat.selection.set([1]);

model.sol('sol1').study('std1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'cdi');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').feature('comp1_phil').set('scalemethod', 'manual');
model.sol('sol1').feature('v1').feature('comp1_phil').set('scaleval', '1');
model.sol('sol1').feature('v1').set('control', 'cdi');
model.sol('sol1').create('s1', 'Stationary');
model.sol('sol1').feature('s1').set('stol', 1.0E-4);
model.sol('sol1').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('s1').feature('fc1').set('dtech', 'auto');
model.sol('sol1').feature('s1').feature('fc1').set('maxiter', 50);
model.sol('sol1').feature('s1').feature('fc1').set('minstep', 1.0E-6);
model.sol('sol1').feature('s1').create('d1', 'Direct');
model.sol('sol1').feature('s1').feature('d1').set('linsolver', 'pardiso');
model.sol('sol1').feature('s1').feature('d1').label('Direct (tcd)');
model.sol('sol1').feature('s1').create('i1', 'Iterative');
model.sol('sol1').feature('s1').feature('i1').set('maxlinit', 1000);
model.sol('sol1').feature('s1').feature('i1').set('nlinnormuse', 'on');
model.sol('sol1').feature('s1').feature('i1').label('Algebraic Multigrid (tcd)');
model.sol('sol1').feature('s1').feature('i1').create('mg1', 'Multigrid');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').set('prefun', 'saamg');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').set('maxcoarsedof', 50000);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').set('saamgcompwise', true);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').set('compactaggregation', true);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('pr').create('sl1', 'SORLine');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('po').create('sl1', 'SORLine');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('cs').create('d1', 'Direct');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('cs').feature('d1').set('linsolver', 'pardiso');
model.sol('sol1').feature('s1').create('i2', 'Iterative');
model.sol('sol1').feature('s1').feature('i2').set('maxlinit', 1000);
model.sol('sol1').feature('s1').feature('i2').set('nlinnormuse', 'on');
model.sol('sol1').feature('s1').feature('i2').label('Geometric Multigrid (tcd)');
model.sol('sol1').feature('s1').feature('i2').create('mg1', 'Multigrid');
model.sol('sol1').feature('s1').feature('i2').feature('mg1').feature('pr').create('sl1', 'SORLine');
model.sol('sol1').feature('s1').feature('i2').feature('mg1').feature('po').create('sl1', 'SORLine');
model.sol('sol1').feature('s1').feature('i2').feature('mg1').feature('cs').create('d1', 'Direct');
model.sol('sol1').feature('s1').feature('i2').feature('mg1').feature('cs').feature('d1').set('linsolver', 'pardiso');
model.sol('sol1').feature('s1').feature('fc1').set('linsolver', 'd1');
model.sol('sol1').feature('s1').feature('fc1').set('dtech', 'auto');
model.sol('sol1').feature('s1').feature('fc1').set('maxiter', 50);
model.sol('sol1').feature('s1').feature('fc1').set('minstep', 1.0E-6);
model.sol('sol1').feature('s1').feature.remove('fcDef');
model.sol('sol1').create('su1', 'StoreSolution');
model.sol('sol1').create('st2', 'StudyStep');
model.sol('sol1').feature('st2').set('study', 'std1');
model.sol('sol1').feature('st2').set('studystep', 'time');
model.sol('sol1').create('v2', 'Variables');
model.sol('sol1').feature('v2').feature('comp1_phil').set('scalemethod', 'manual');
model.sol('sol1').feature('v2').feature('comp1_phipf').set('scalemethod', 'manual');
model.sol('sol1').feature('v2').feature('comp1_phil').set('scaleval', '1');
model.sol('sol1').feature('v2').feature('comp1_phipf').set('scaleval', '1');
model.sol('sol1').feature('v2').set('initmethod', 'sol');
model.sol('sol1').feature('v2').set('initsol', 'sol1');
model.sol('sol1').feature('v2').set('initsoluse', 'sol2');
model.sol('sol1').feature('v2').set('notsolmethod', 'sol');
model.sol('sol1').feature('v2').set('notsol', 'sol1');
model.sol('sol1').feature('v2').set('notsoluse', 'sol2');
model.sol('sol1').feature('v2').set('control', 'time');
model.sol('sol1').create('t1', 'Time');
model.sol('sol1').feature('t1').set('tlist', 'range(0,0.5,20)');
model.sol('sol1').feature('t1').set('plot', 'off');
model.sol('sol1').feature('t1').set('plotgroup', 'Default');
model.sol('sol1').feature('t1').set('plotfreq', 'tout');
model.sol('sol1').feature('t1').set('probesel', 'all');
model.sol('sol1').feature('t1').set('probes', {});
model.sol('sol1').feature('t1').set('probefreq', 'tsteps');
model.sol('sol1').feature('t1').set('rtol', 0.001);
model.sol('sol1').feature('t1').set('atolglobalvaluemethod', 'factor');
model.sol('sol1').feature('t1').set('eventout', true);
model.sol('sol1').feature('t1').set('reacf', true);
model.sol('sol1').feature('t1').set('storeudot', true);
model.sol('sol1').feature('t1').set('endtimeinterpolation', true);
model.sol('sol1').feature('t1').set('maxorder', 2);
model.sol('sol1').feature('t1').set('stabcntrl', true);
model.sol('sol1').feature('t1').set('control', 'time');
model.sol('sol1').feature('t1').feature('aDef').set('cachepattern', true);
model.sol('sol1').feature('t1').create('seDef', 'Segregated');
model.sol('sol1').feature('t1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('t1').feature('fc1').set('jtech', 'once');
model.sol('sol1').feature('t1').feature('fc1').set('damp', 0.9);
model.sol('sol1').feature('t1').feature('fc1').set('maxiter', 8);
model.sol('sol1').feature('t1').feature('fc1').set('stabacc', 'aacc');
model.sol('sol1').feature('t1').feature('fc1').set('aaccdim', 5);
model.sol('sol1').feature('t1').feature('fc1').set('aaccmix', 0.9);
model.sol('sol1').feature('t1').feature('fc1').set('aaccdelay', 0);
model.sol('sol1').feature('t1').feature('fc1').set('dtech', 'auto');
model.sol('sol1').feature('t1').create('d1', 'Direct');
model.sol('sol1').feature('t1').feature('d1').set('linsolver', 'pardiso');
model.sol('sol1').feature('t1').feature('d1').set('pivotperturb', 1.0E-13);
model.sol('sol1').feature('t1').feature('d1').label('Direct, phase field variables (pf) (Merged)');
model.sol('sol1').feature('t1').create('i1', 'Iterative');
model.sol('sol1').feature('t1').feature('i1').set('maxlinit', 1000);
model.sol('sol1').feature('t1').feature('i1').set('nlinnormuse', 'on');
model.sol('sol1').feature('t1').feature('i1').label('Algebraic Multigrid (tcd)');
model.sol('sol1').feature('t1').feature('i1').create('mg1', 'Multigrid');
model.sol('sol1').feature('t1').feature('i1').feature('mg1').set('prefun', 'saamg');
model.sol('sol1').feature('t1').feature('i1').feature('mg1').set('maxcoarsedof', 50000);
model.sol('sol1').feature('t1').feature('i1').feature('mg1').set('saamgcompwise', true);
model.sol('sol1').feature('t1').feature('i1').feature('mg1').set('compactaggregation', true);
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('pr').create('sl1', 'SORLine');
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('po').create('sl1', 'SORLine');
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('cs').create('d1', 'Direct');
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('cs').feature('d1').set('linsolver', 'pardiso');
model.sol('sol1').feature('t1').create('i2', 'Iterative');
model.sol('sol1').feature('t1').feature('i2').set('maxlinit', 1000);
model.sol('sol1').feature('t1').feature('i2').set('nlinnormuse', 'on');
model.sol('sol1').feature('t1').feature('i2').label('Geometric Multigrid (tcd)');
model.sol('sol1').feature('t1').feature('i2').create('mg1', 'Multigrid');
model.sol('sol1').feature('t1').feature('i2').feature('mg1').feature('pr').create('sl1', 'SORLine');
model.sol('sol1').feature('t1').feature('i2').feature('mg1').feature('po').create('sl1', 'SORLine');
model.sol('sol1').feature('t1').feature('i2').feature('mg1').feature('cs').create('d1', 'Direct');
model.sol('sol1').feature('t1').feature('i2').feature('mg1').feature('cs').feature('d1').set('linsolver', 'pardiso');
model.sol('sol1').feature('t1').create('i3', 'Iterative');
model.sol('sol1').feature('t1').feature('i3').set('linsolver', 'gmres');
model.sol('sol1').feature('t1').feature('i3').set('prefuntype', 'left');
model.sol('sol1').feature('t1').feature('i3').set('itrestart', 50);
model.sol('sol1').feature('t1').feature('i3').set('rhob', 20);
model.sol('sol1').feature('t1').feature('i3').set('maxlinit', 50);
model.sol('sol1').feature('t1').feature('i3').set('nlinnormuse', 'on');
model.sol('sol1').feature('t1').feature('i3').label('AMG, phase field variables (pf)');
model.sol('sol1').feature('t1').feature('i3').create('mg1', 'Multigrid');
model.sol('sol1').feature('t1').feature('i3').feature('mg1').set('prefun', 'saamg');
model.sol('sol1').feature('t1').feature('i3').feature('mg1').set('mgcycle', 'v');
model.sol('sol1').feature('t1').feature('i3').feature('mg1').set('maxcoarsedof', 50000);
model.sol('sol1').feature('t1').feature('i3').feature('mg1').set('strconn', 0.01);
model.sol('sol1').feature('t1').feature('i3').feature('mg1').set('nullspace', 'constant');
model.sol('sol1').feature('t1').feature('i3').feature('mg1').set('usesmooth', false);
model.sol('sol1').feature('t1').feature('i3').feature('mg1').set('saamgcompwise', false);
model.sol('sol1').feature('t1').feature('i3').feature('mg1').set('loweramg', true);
model.sol('sol1').feature('t1').feature('i3').feature('mg1').set('compactaggregation', false);
model.sol('sol1').feature('t1').feature('i3').feature('mg1').feature('pr').create('sc1', 'SCGS');
model.sol('sol1').feature('t1').feature('i3').feature('mg1').feature('pr').feature('sc1').set('linesweeptype', 'ssor');
model.sol('sol1').feature('t1').feature('i3').feature('mg1').feature('pr').feature('sc1').set('iter', 0);
model.sol('sol1').feature('t1').feature('i3').feature('mg1').feature('pr').feature('sc1').set('scgsrelax', 0.7);
model.sol('sol1').feature('t1').feature('i3').feature('mg1').feature('pr').feature('sc1').set('scgsmethod', 'lines');
model.sol('sol1').feature('t1').feature('i3').feature('mg1').feature('pr').feature('sc1').set('scgsvertexrelax', 0.7);
model.sol('sol1').feature('t1').feature('i3').feature('mg1').feature('pr').feature('sc1').set('relax', 0.5);
model.sol('sol1').feature('t1').feature('i3').feature('mg1').feature('pr').feature('sc1').set('scgssolv', 'stored');
model.sol('sol1').feature('t1').feature('i3').feature('mg1').feature('pr').feature('sc1').set('approxscgs', true);
model.sol('sol1').feature('t1').feature('i3').feature('mg1').feature('pr').feature('sc1').set('scgsdirectmaxsize', 1000);
model.sol('sol1').feature('t1').feature('i3').feature('mg1').feature('po').create('sc1', 'SCGS');
model.sol('sol1').feature('t1').feature('i3').feature('mg1').feature('po').feature('sc1').set('linesweeptype', 'ssor');
model.sol('sol1').feature('t1').feature('i3').feature('mg1').feature('po').feature('sc1').set('iter', 1);
model.sol('sol1').feature('t1').feature('i3').feature('mg1').feature('po').feature('sc1').set('scgsrelax', 0.7);
model.sol('sol1').feature('t1').feature('i3').feature('mg1').feature('po').feature('sc1').set('scgsmethod', 'lines');
model.sol('sol1').feature('t1').feature('i3').feature('mg1').feature('po').feature('sc1').set('scgsvertexrelax', 0.7);
model.sol('sol1').feature('t1').feature('i3').feature('mg1').feature('po').feature('sc1').set('relax', 0.5);
model.sol('sol1').feature('t1').feature('i3').feature('mg1').feature('po').feature('sc1').set('scgssolv', 'stored');
model.sol('sol1').feature('t1').feature('i3').feature('mg1').feature('po').feature('sc1').set('approxscgs', true);
model.sol('sol1').feature('t1').feature('i3').feature('mg1').feature('po').feature('sc1').set('scgsdirectmaxsize', 1000);
model.sol('sol1').feature('t1').feature('i3').feature('mg1').feature('cs').create('d1', 'Direct');
model.sol('sol1').feature('t1').feature('i3').feature('mg1').feature('cs').feature('d1').set('linsolver', 'pardiso');
model.sol('sol1').feature('t1').feature('i3').feature('mg1').feature('cs').feature('d1').set('pivotperturb', 1.0E-13);
model.sol('sol1').feature('t1').feature('fc1').set('linsolver', 'd1');
model.sol('sol1').feature('t1').feature('fc1').set('jtech', 'once');
model.sol('sol1').feature('t1').feature('fc1').set('damp', 0.9);
model.sol('sol1').feature('t1').feature('fc1').set('maxiter', 8);
model.sol('sol1').feature('t1').feature('fc1').set('stabacc', 'aacc');
model.sol('sol1').feature('t1').feature('fc1').set('aaccdim', 5);
model.sol('sol1').feature('t1').feature('fc1').set('aaccmix', 0.9);
model.sol('sol1').feature('t1').feature('fc1').set('aaccdelay', 0);
model.sol('sol1').feature('t1').feature('fc1').set('dtech', 'auto');
model.sol('sol1').feature('t1').feature.remove('fcDef');
model.sol('sol1').feature('t1').feature.remove('seDef');
model.sol('sol1').attach('std1');
model.sol('sol1').feature('v2').set('scalemethod', 'init');

model.study('std1').setGenPlots(false);

model.sol('sol1').runAll;

model.result.create('pg1', 'PlotGroup2D');
model.result('pg1').run;
model.result('pg1').label('E');
model.result('pg1').label('Electrolyte Potential (tcd)');
model.result('pg1').create('surf1', 'Surface');
model.result('pg1').feature('surf1').create('filt1', 'Filter');
model.result('pg1').run;
model.result('pg1').feature('surf1').feature('filt1').set('expr', 'phipf<0');
model.result('pg1').run;
model.result('pg1').feature.duplicate('surf2', 'surf1');
model.result('pg1').run;
model.result('pg1').feature('surf2').set('expr', 'phipf');
model.result('pg1').feature('surf2').set('colortable', 'GrayScale');
model.result('pg1').run;
model.result('pg1').feature('surf2').feature('filt1').set('expr', 'phipf>0');
model.result('pg1').run;
model.result('pg1').run;
model.result.duplicate('pg2', 'pg1');
model.result('pg2').run;
model.result('pg2').label('Concentration (tcd)');
model.result('pg2').run;
model.result('pg2').feature('surf1').set('expr', 'cCu');
model.result('pg2').feature('surf1').set('descr', 'Concentration');
model.result('pg2').run;
model.result('pg2').run;
model.result('pg2').setIndex('looplevel', 29, 0);
model.result('pg2').run;

model.title('Copper Deposition in a Trench Using the Phase Field Method');

model.description('This example illustrates use of the Phase Field interface to model electrodeposition of copper that takes place on a cathode surface. The model captures a cavity formation which occurs due to nonuniform deposition rate. Both concentration dependent electrode kinetics as well as ion transport by diffusion and migration are accounted for, and the model is therefore referred to as a tertiary current density distribution model. The electrode kinetics at the deposition boundary is defined as a domain term making use of the delta function from the Phase Field interface.');

model.mesh.clearMeshes;

model.sol('sol1').clearSolutionData;
model.sol('sol2').clearSolutionData;

model.label('cu_trench_deposition_pf.mph');

model.modelNode.label('Components');

out = model;
