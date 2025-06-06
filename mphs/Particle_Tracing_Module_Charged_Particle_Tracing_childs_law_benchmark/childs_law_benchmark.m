function out = model
%
% childs_law_benchmark.m
%
% Model exported on May 26 2025, 21:31 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/Particle_Tracing_Module/Charged_Particle_Tracing');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 2);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.physics.create('es', 'Electrostatics', 'geom1');
model.physics('es').model('comp1');
model.physics.create('cpt', 'ChargedParticleTracing', 'geom1');
model.physics('cpt').model('comp1');
model.physics('cpt').prop('ParticleReleaseSpecification').set('ParticleReleaseSpecification', 'SpecifyCurrent');
model.physics('cpt').prop('RelativisticCorrection').set('RelativisticCorrection', '0');
model.physics('cpt').create('ef1', 'ElectricForce');
model.physics('cpt').feature('ef1').selection.all;
model.physics('cpt').feature('ef1').set('SpecifyForceUsing', {'ElectricField'});

model.multiphysics.create('epfi1', 'ElectricParticleFieldInteraction', 'geom1', 2);
model.multiphysics('epfi1').set('ChargeDensitySource_physics', 'cpt');
model.multiphysics('epfi1').set('ChargeDensityDestination_physics', 'es');

model.study.create('std1');
model.study('std1').create('bcpt', 'BidirectionallyCoupledParticleTracing');
model.study('std1').feature('bcpt').setSolveFor('/physics/es', true);
model.study('std1').feature('bcpt').setSolveFor('/physics/cpt', true);
model.study('std1').feature('bcpt').setSolveFor('/multiphysics/epfi1', true);

model.param.set('V0', '1000[V]');
model.param.descr('V0', 'Potential difference across gap');
model.param.set('d', '1[cm]');
model.param.descr('d', 'Length of the modeling domain');
model.param.set('dbuf', '0.01[cm]');
model.param.descr('dbuf', 'Length of the buffer region');
model.param.set('H', '2[cm]');
model.param.descr('H', 'Height of the modeling domain');
model.param.set('Depth', '1[m]');
model.param.descr('Depth', 'Depth into the modeling domain');
model.param.set('Jan', '(4*epsilon0_const/9)*sqrt(2*V0*e_const/me_const)*V0/d^2');
model.param.descr('Jan', 'Analytic current density');
model.param.set('Ian', 'Jan*H*Depth');
model.param.descr('Ian', 'Analytic total current');

model.geom('geom1').create('r1', 'Rectangle');
model.geom('geom1').feature('r1').set('size', {'d' 'H'});

model.variable.create('var1');
model.variable('var1').model('comp1');

model.geom('geom1').run;

model.variable('var1').set('Van', 'V0*((x+dbuf)/(d+dbuf))^(4/3)');
model.variable('var1').descr('Van', 'Analytic potential distribution');
model.variable('var1').set('rel_err', '(V-Van)/Van');
model.variable('var1').descr('rel_err', 'Error in potential distribution');

model.material.create('mat1', 'Common', 'comp1');
model.material('mat1').label('Perfect vacuum');
model.material('mat1').propertyGroup('def').set('density', '');
model.material('mat1').propertyGroup('def').set('relpermeability', '');
model.material('mat1').propertyGroup('def').set('relpermittivity', '');
model.material('mat1').propertyGroup('def').set('electricconductivity', '');
model.material('mat1').propertyGroup('def').set('density', '0');
model.material('mat1').propertyGroup('def').set('relpermeability', {'1' '0' '0' '0' '1' '0' '0' '0' '1'});
model.material('mat1').propertyGroup('def').set('relpermittivity', {'1' '0' '0' '0' '1' '0' '0' '0' '1'});
model.material('mat1').propertyGroup('def').set('electricconductivity', {'0' '0' '0' '0' '0' '0' '0' '0' '0'});

model.physics('cpt').feature('pp1').set('ParticleSpecies', 'Electron');
model.physics('cpt').feature('ef1').set('E_src', 'root.comp1.es.Ex');
model.physics('es').create('pot1', 'ElectricPotential', 1);
model.physics('es').feature('pot1').selection.set([4]);
model.physics('es').feature('pot1').set('V0', 'V0');

model.multiphysics.create('scle1', 'SpaceChargeLimitedEmission', 'geom1', 1);
model.multiphysics('scle1').selection.set([1]);
model.multiphysics('scle1').set('os', 'dbuf');
model.multiphysics('epfi1').set('UseCumulativeSpaceChargeDensity', true);
model.multiphysics('epfi1').set('beta', 15);

model.mesh('mesh1').create('ftri1', 'FreeTri');
model.mesh('mesh1').feature('size').set('hauto', 3);
model.mesh('mesh1').create('bl1', 'BndLayer');
model.mesh('mesh1').feature('bl1').create('blp', 'BndLayerProp');
model.mesh('mesh1').feature('bl1').selection.geom(2);
model.mesh('mesh1').feature('bl1').selection.set([]);
model.mesh('mesh1').feature('bl1').selection.allGeom;
model.mesh('mesh1').feature('bl1').set('smoothtransition', false);
model.mesh('mesh1').feature('bl1').feature('blp').selection.set([1]);
model.mesh('mesh1').feature('bl1').feature('blp').set('blnlayers', 4);
model.mesh('mesh1').run;

model.study('std1').feature('bcpt').set('tunit', 'ns');
model.study('std1').feature('bcpt').set('tlist', 'range(0,0.1,3)');
model.study('std1').feature('bcpt').set('method', 'convergence_of_global_variable');
model.study('std1').feature('bcpt').set('expr', 'scle1.rc');
model.study('std1').feature('bcpt').set('maxiter', 35);

model.sol.create('sol1');
model.sol('sol1').study('std1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'bcpt');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').set('control', 'bcpt');
model.sol('sol1').create('for1', 'For');
model.sol('sol1').feature('for1').set('control', 'bcpt');
model.sol('sol1').feature('for1').set('iter', '5');
model.sol('sol1').create('st2', 'StudyStep');
model.sol('sol1').feature('st2').set('studystep', 'bcpt');
model.sol('sol1').create('v2', 'Variables');
model.sol('sol1').feature('v2').set('control', 'user');
model.sol('sol1').feature('v2').set('notsolmethod', 'sol');
model.sol('sol1').feature('v2').set('notsol', 'sol1');
model.sol('sol1').feature('v2').set('initmethod', 'sol');
model.sol('sol1').feature('v2').set('initsol', 'sol1');
model.sol('sol1').feature('v2').feature('comp1_cpt_frel').set('solvefor', 'off');
model.sol('sol1').feature('v2').feature('comp1_epfi1_rhos_accum').set('solvefor', 'off');
model.sol('sol1').feature('v2').feature('comp1_epfi1_rhoscum_accum').set('solvefor', 'off');
model.sol('sol1').feature('v2').feature('comp1_qcpt').set('solvefor', 'off');
model.sol('sol1').feature('v2').feature('comp1_scle1_V0').set('solvefor', 'on');
model.sol('sol1').feature('v2').feature('comp1_V').set('solvefor', 'on');
model.sol('sol1').create('s1', 'Stationary');
model.sol('sol1').feature('s1').create('seDef', 'Segregated');
model.sol('sol1').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('s1').feature('fc1').set('linsolver', 'dDef');
model.sol('sol1').feature('s1').feature.remove('fcDef');
model.sol('sol1').feature('s1').feature.remove('seDef');
model.sol('sol1').create('v3', 'Variables');
model.sol('sol1').feature('v3').set('control', 'user');
model.sol('sol1').feature('v3').set('notsolmethod', 'sol');
model.sol('sol1').feature('v3').set('notsol', 'sol1');
model.sol('sol1').feature('v3').set('initsol', 'sol1');
model.sol('sol1').feature('v3').feature('comp1_cpt_frel').set('solvefor', 'off');
model.sol('sol1').feature('v3').feature('comp1_epfi1_rhos_accum').set('solvefor', 'off');
model.sol('sol1').feature('v3').feature('comp1_epfi1_rhoscum_accum').set('solvefor', 'on');
model.sol('sol1').feature('v3').feature('comp1_qcpt').set('solvefor', 'off');
model.sol('sol1').feature('v3').feature('comp1_scle1_V0').set('solvefor', 'off');
model.sol('sol1').feature('v3').feature('comp1_V').set('solvefor', 'off');
model.sol('sol1').create('st3', 'StudyStep');
model.sol('sol1').feature('st3').set('studystep', 'bcpt');
model.sol('sol1').create('v4', 'Variables');
model.sol('sol1').feature('v4').set('control', 'user');
model.sol('sol1').feature('v4').set('notsolmethod', 'sol');
model.sol('sol1').feature('v4').set('notsol', 'sol1');
model.sol('sol1').feature('v4').feature('comp1_cpt_frel').set('solvefor', 'on');
model.sol('sol1').feature('v4').feature('comp1_epfi1_rhos_accum').set('solvefor', 'on');
model.sol('sol1').feature('v4').feature('comp1_epfi1_rhoscum_accum').set('solvefor', 'off');
model.sol('sol1').feature('v4').feature('comp1_qcpt').set('solvefor', 'on');
model.sol('sol1').feature('v4').feature('comp1_scle1_V0').set('solvefor', 'off');
model.sol('sol1').feature('v4').feature('comp1_V').set('solvefor', 'off');
model.sol('sol1').create('t1', 'Time');
model.sol('sol1').feature('t1').set('tlist', 'range(0,0.1,3)');
model.sol('sol1').feature('t1').set('plot', 'off');
model.sol('sol1').feature('t1').set('plotgroup', 'Default');
model.sol('sol1').feature('t1').set('plotfreq', 'tout');
model.sol('sol1').feature('t1').set('probesel', 'all');
model.sol('sol1').feature('t1').set('probes', {});
model.sol('sol1').feature('t1').set('probefreq', 'tsteps');
model.sol('sol1').feature('t1').set('rtol', 1.0E-5);
model.sol('sol1').feature('t1').set('atolglobalvaluemethod', 'factor');
model.sol('sol1').feature('t1').set('reacf', true);
model.sol('sol1').feature('t1').set('storeudot', true);
model.sol('sol1').feature('t1').set('tstepsgenalpha', 'strict');
model.sol('sol1').feature('t1').set('endtimeinterpolation', true);
model.sol('sol1').feature('t1').set('timemethod', 'genalpha');
model.sol('sol1').feature('t1').set('estrat', 'exclude');
model.sol('sol1').feature('t1').set('control', 'bcpt');
model.sol('sol1').feature('t1').create('seDef', 'Segregated');
model.sol('sol1').feature('t1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('t1').feature('fc1').set('ntolfact', 0.1);
model.sol('sol1').feature('t1').create('d1', 'Direct');
model.sol('sol1').feature('t1').feature('d1').label('Direct (Merged)');
model.sol('sol1').feature('t1').feature('fc1').set('linsolver', 'd1');
model.sol('sol1').feature('t1').feature('fc1').set('ntolfact', 0.1);
model.sol('sol1').feature('t1').feature.remove('fcDef');
model.sol('sol1').feature('t1').feature.remove('seDef');
model.sol('sol1').create('endfor1', 'EndFor');
model.sol('sol1').feature('v4').set('notsolnum', 'auto');
model.sol('sol1').feature('v4').set('notsolvertype', 'solnum');
model.sol('sol1').feature('v3').set('notsolnum', 'auto');
model.sol('sol1').feature('v3').set('notsolvertype', 'solnum');
model.sol('sol1').feature('v3').set('solnum', 'auto');
model.sol('sol1').feature('v3').set('solvertype', 'solnum');
model.sol('sol1').feature('v2').set('notsolnum', 'auto');
model.sol('sol1').feature('v2').set('notsolvertype', 'solnum');
model.sol('sol1').feature('v2').set('solnum', 'auto');
model.sol('sol1').feature('v2').set('solvertype', 'solnum');
model.sol('sol1').attach('std1');
model.sol('sol1').runAll;

model.result.create('pg1', 'PlotGroup2D');
model.result('pg1').label('Electric Potential (es)');
model.result('pg1').set('frametype', 'spatial');
model.result('pg1').set('showlegendsmaxmin', true);
model.result('pg1').set('data', 'dset1');
model.result('pg1').setIndex('looplevel', 31, 0);
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
model.result('pg1').feature('str1').selection.set([1 2 3 4]);
model.result('pg1').feature('str1').set('inheritplot', 'surf1');
model.result('pg1').feature('str1').feature.create('col1', 'Color');
model.result('pg1').feature('str1').feature('col1').set('colortable', 'DipoleDark');
model.result('pg1').feature('str1').feature('col1').set('colorlegend', false);
model.result('pg1').feature('str1').feature.create('filt1', 'Filter');
model.result('pg1').feature('str1').feature('filt1').set('expr', '!isScalingSystemDomain');
model.result.create('pg2', 'PlotGroup2D');
model.result('pg2').label('Electric Field Norm (es)');
model.result('pg2').set('frametype', 'spatial');
model.result('pg2').set('showlegendsmaxmin', true);
model.result('pg2').set('data', 'dset1');
model.result('pg2').setIndex('looplevel', 31, 0);
model.result('pg2').set('defaultPlotID', 'InterfaceComponents/PlotDefaults/icom3/pdef1/pcond2/pcond2/pg1');
model.result('pg2').feature.create('surf1', 'Surface');
model.result('pg2').feature('surf1').set('showsolutionparams', 'on');
model.result('pg2').feature('surf1').set('solutionparams', 'parent');
model.result('pg2').feature('surf1').set('expr', 'es.normE');
model.result('pg2').feature('surf1').set('colortable', 'Prism');
model.result('pg2').feature('surf1').set('colortabletrans', 'nonlinear');
model.result('pg2').feature('surf1').set('colorcalibration', -0.8);
model.result('pg2').feature('surf1').set('showsolutionparams', 'on');
model.result('pg2').feature('surf1').set('data', 'parent');
model.result('pg2').feature.create('str1', 'Streamline');
model.result('pg2').feature('str1').set('showsolutionparams', 'on');
model.result('pg2').feature('str1').set('solutionparams', 'parent');
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
model.result('pg2').feature('str1').selection.set([1 2 3 4]);
model.result('pg2').feature('str1').set('inheritplot', 'surf1');
model.result('pg2').feature('str1').feature.create('col1', 'Color');
model.result('pg2').feature('str1').feature('col1').set('expr', 'es.normE');
model.result('pg2').feature('str1').feature('col1').set('colortable', 'PrismDark');
model.result('pg2').feature('str1').feature('col1').set('colorlegend', false);
model.result('pg2').feature('str1').feature('col1').set('colortabletrans', 'nonlinear');
model.result('pg2').feature('str1').feature('col1').set('colorcalibration', -0.8);
model.result('pg2').feature('str1').feature.create('filt1', 'Filter');
model.result('pg2').feature('str1').feature('filt1').set('expr', '!isScalingSystemDomain');
model.result.dataset.create('part1', 'Particle');
model.result.dataset('part1').set('solution', 'sol1');
model.result.dataset('part1').set('posdof', {'comp1.qx' 'comp1.qy'});
model.result.dataset('part1').set('geom', 'geom1');
model.result.dataset('part1').set('pgeom', 'pgeom_cpt');
model.result.dataset('part1').set('pgeomspec', 'fromphysics');
model.result.dataset('part1').set('physicsinterface', 'cpt');
model.result.create('pg3', 'PlotGroup2D');
model.result('pg3').set('data', 'part1');
model.result('pg3').setIndex('looplevel', 31, 0);
model.result('pg3').label('Particle Trajectories (cpt)');
model.result('pg3').create('traj1', 'ParticleTrajectories');
model.result('pg3').feature('traj1').set('pointtype', 'point');
model.result('pg3').feature('traj1').set('linetype', 'none');
model.result('pg3').feature('traj1').create('col1', 'Color');
model.result('pg3').feature('traj1').feature('col1').set('expr', 'cpt.V');
model.result('pg1').run;
model.result.dataset.create('cln1', 'CutLine2D');
model.result.dataset('cln1').setIndex('genpoints', '1[cm]', 0, 1);
model.result.dataset('cln1').setIndex('genpoints', '1[cm]', 1, 0);
model.result.dataset('cln1').setIndex('genpoints', '1[cm]', 1, 1);
model.result.create('pg4', 'PlotGroup1D');
model.result('pg4').run;
model.result('pg4').label('Comparison With Child''s Law');
model.result('pg4').set('data', 'cln1');
model.result('pg4').setIndex('looplevelinput', 'last', 0);
model.result('pg4').set('legendpos', 'upperleft');
model.result('pg4').create('lngr1', 'LineGraph');
model.result('pg4').feature('lngr1').set('markerpos', 'datapoints');
model.result('pg4').feature('lngr1').set('linewidth', 'preference');
model.result('pg4').feature('lngr1').set('legend', true);
model.result('pg4').feature('lngr1').set('legendmethod', 'manual');
model.result('pg4').feature('lngr1').setIndex('legends', 'Computed potential', 0);
model.result('pg4').run;
model.result('pg4').create('lngr2', 'LineGraph');
model.result('pg4').feature('lngr2').set('markerpos', 'datapoints');
model.result('pg4').feature('lngr2').set('linewidth', 'preference');
model.result('pg4').feature('lngr2').set('expr', 'Van');
model.result('pg4').feature('lngr2').set('linestyle', 'none');
model.result('pg4').feature('lngr2').set('linemarker', 'point');
model.result('pg4').feature('lngr2').set('markerpos', 'interp');
model.result('pg4').feature('lngr2').set('markers', 20);
model.result('pg4').feature('lngr2').set('legend', true);
model.result('pg4').feature('lngr2').set('legendmethod', 'manual');
model.result('pg4').feature('lngr2').setIndex('legends', 'Analytical Solution', 0);
model.result('pg4').run;
model.result.create('pg5', 'PlotGroup1D');
model.result('pg5').run;
model.result('pg5').label('Relative Error');
model.result('pg5').set('data', 'cln1');
model.result('pg5').setIndex('looplevelinput', 'last', 0);
model.result('pg5').create('lngr1', 'LineGraph');
model.result('pg5').feature('lngr1').set('markerpos', 'datapoints');
model.result('pg5').feature('lngr1').set('linewidth', 'preference');
model.result('pg5').feature('lngr1').set('expr', 'rel_err');
model.result('pg5').run;
model.result.numerical.create('gev1', 'EvalGlobal');
model.result.numerical('gev1').setIndex('looplevelinput', 'last', 0);
model.result.numerical('gev1').set('expr', {'Ian'});
model.result.numerical('gev1').set('descr', {'Analytic total current'});
model.result.numerical('gev1').set('unit', {'A'});
model.result.table.create('tbl1', 'Table');
model.result.table('tbl1').comments('Global Evaluation 1');
model.result.numerical('gev1').set('table', 'tbl1');
model.result.numerical('gev1').setResult;
model.result.numerical.create('gev2', 'EvalGlobal');
model.result.numerical('gev2').setIndex('looplevelinput', 'last', 0);
model.result.numerical('gev2').set('expr', {'scle1.rc'});
model.result.numerical('gev2').set('descr', {'Release current magnitude'});
model.result.numerical('gev2').set('unit', {'A'});
model.result.numerical('gev2').set('table', 'tbl1');
model.result.numerical('gev2').appendResult;

model.title('Child''s Law Benchmark');

model.description('This example simulates the space charge limited emission of electrons from a planar surface. The electric potential distribution is compared to the analytic solution based on Child''s Law, as is the total emission current from the emission surface.');

model.label('childs_law_benchmark.mph');

model.modelNode.label('Components');

out = model;
