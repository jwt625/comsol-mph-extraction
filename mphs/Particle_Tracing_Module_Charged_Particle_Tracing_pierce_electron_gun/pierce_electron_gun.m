function out = model
%
% pierce_electron_gun.m
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

model.param.set('d', '5[cm]');
model.param.descr('d', 'Gap thickness');
model.param.set('db', '1[mm]');
model.param.descr('db', 'Virtual cathode height');
model.param.set('w1', '1[cm]');
model.param.descr('w1', 'Cathode width');
model.param.set('w2', '20[cm]');
model.param.descr('w2', 'Focusing electrode width');
model.param.set('alpha', '22.5[deg]');
model.param.descr('alpha', 'Focusing electrode angle');
model.param.set('V0', '1[kV]');
model.param.descr('V0', 'Anode potential');

model.geom('geom1').create('r1', 'Rectangle');
model.geom('geom1').feature('r1').set('size', {'w1' 'd-db'});
model.geom('geom1').feature('r1').set('pos', {'0' 'db'});
model.geom('geom1').run('r1');
model.geom('geom1').create('pc1', 'ParametricCurve');
model.geom('geom1').feature('pc1').set('parname', 'theta');
model.geom('geom1').feature('pc1').set('parmax', '62*pi/180');
model.geom('geom1').feature('pc1').set('coord', {'w1+d*sec(4*theta/3)^0.75*sin(theta)' ''});
model.geom('geom1').feature('pc1').setIndex('coord', 'd*sec(4*theta/3)^0.75*cos(theta)', 1);
model.geom('geom1').run('pc1');
model.geom('geom1').create('pol1', 'Polygon');
model.geom('geom1').feature('pol1').set('source', 'table');
model.geom('geom1').feature('pol1').set('type', 'open');
model.geom('geom1').feature('pol1').setIndex('table', 'w1', 0, 0);
model.geom('geom1').feature('pol1').setIndex('table', 'd', 0, 1);
model.geom('geom1').feature('pol1').setIndex('table', 'w1', 1, 0);
model.geom('geom1').feature('pol1').setIndex('table', 0, 1, 1);
model.geom('geom1').feature('pol1').setIndex('table', 'w2', 2, 0);
model.geom('geom1').feature('pol1').setIndex('table', 'w2*tan(alpha)', 2, 1);
model.geom('geom1').feature('pol1').setIndex('table', 'w2-d*tan(alpha)', 3, 0);
model.geom('geom1').feature('pol1').setIndex('table', 'w2*tan(alpha)+d', 3, 1);
model.geom('geom1').run('pol1');
model.geom('geom1').create('csol1', 'ConvertToSolid');
model.geom('geom1').feature('csol1').selection('input').set({'pc1' 'pol1'});
model.geom('geom1').runPre('fin');

model.cpl.create('intop1', 'Integration', 'geom1');

model.geom('geom1').run;

model.cpl('intop1').set('axisym', true);
model.cpl('intop1').selection.geom('geom1', 0);
model.cpl('intop1').selection.set([4]);

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

model.multiphysics.create('scle1', 'SpaceChargeLimitedEmission', 'geom1', 1);
model.multiphysics('scle1').selection.set([2]);
model.multiphysics('scle1').set('os', 'db');
model.multiphysics('epfi1').set('UseCumulativeSpaceChargeDensity', true);
model.multiphysics('epfi1').set('beta', 10);

model.physics('es').create('pot1', 'ElectricPotential', 1);
model.physics('es').feature('pot1').label('Anode');
model.physics('es').feature('pot1').selection.set([3 8]);
model.physics('es').feature('pot1').set('V0', 'V0');
model.physics('es').create('pot2', 'ElectricPotential', 1);
model.physics('es').feature('pot2').label('Focusing Electrode');
model.physics('es').feature('pot2').selection.set([5]);
model.physics('es').create('pot3', 'ElectricPotential', 1);
model.physics('es').feature('pot3').label('Adjacent to Virtual Cathode');
model.physics('es').feature('pot3').selection.set([4]);
model.physics('es').feature('pot3').set('V0', 'intop1(scle1.V0)*(y/db)^(4/3)');

model.mesh('mesh1').create('map1', 'Map');
model.mesh('mesh1').feature('map1').selection.geom('geom1', 2);
model.mesh('mesh1').feature('map1').selection.set([1]);
model.mesh('mesh1').feature('map1').create('dis1', 'Distribution');
model.mesh('mesh1').feature('map1').feature('dis1').selection.set([2 3]);
model.mesh('mesh1').feature('map1').feature('dis1').set('numelem', 20);
model.mesh('mesh1').feature('map1').create('dis2', 'Distribution');
model.mesh('mesh1').feature('map1').feature('dis2').selection.set([1 6]);
model.mesh('mesh1').feature('map1').feature('dis2').set('numelem', 100);
model.mesh('mesh1').create('ftri1', 'FreeTri');
model.mesh('mesh1').run;

model.study('std1').feature('bcpt').set('tunit', 'ns');
model.study('std1').feature('bcpt').set('tlist', 'range(0,1,10)');
model.study('std1').feature('bcpt').set('iter', 20);

model.sol.create('sol1');
model.sol('sol1').study('std1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'bcpt');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').set('control', 'bcpt');
model.sol('sol1').create('for1', 'For');
model.sol('sol1').feature('for1').set('control', 'bcpt');
model.sol('sol1').feature('for1').set('iter', '20');
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
model.sol('sol1').feature('t1').set('tlist', 'range(0,1,10)');
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
model.result('pg1').feature('str1').selection.set([1 2 3 4 5 6 7 8]);
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
model.result('pg2').setIndex('looplevel', 11, 0);
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
model.result('pg2').feature('str1').selection.set([1 2 3 4 5 6 7 8]);
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
model.result('pg3').setIndex('looplevel', 11, 0);
model.result('pg3').label('Particle Trajectories (cpt)');
model.result('pg3').create('traj1', 'ParticleTrajectories');
model.result('pg3').feature('traj1').set('pointtype', 'point');
model.result('pg3').feature('traj1').set('linetype', 'none');
model.result('pg3').feature('traj1').create('col1', 'Color');
model.result('pg3').feature('traj1').feature('col1').set('expr', 'cpt.V');
model.result('pg1').run;
model.result('pg1').run;
model.result('pg1').feature('surf1').set('colortable', 'Viridis');
model.result('pg1').run;
model.result('pg1').run;
model.result('pg1').feature('str1').feature('col1').set('colortable', 'GrayScale');
model.result('pg1').run;
model.result('pg3').run;
model.result('pg3').run;
model.result('pg3').feature('traj1').set('linetype', 'line');
model.result('pg3').run;
model.result.dataset.create('mir1', 'Mirror2D');
model.result.create('pg4', 'PlotGroup2D');
model.result('pg4').run;
model.result('pg4').label('Contours with Field Lines');
model.result('pg4').set('data', 'mir1');
model.result('pg4').set('edges', false);
model.result('pg4').create('con1', 'Contour');
model.result('pg4').feature('con1').set('contourtype', 'filled');
model.result('pg4').feature('con1').set('colortable', 'Traffic');
model.result('pg4').feature('con1').set('colortabletrans', 'reverse');
model.result('pg4').feature('con1').create('filt1', 'Filter');
model.result('pg4').run;
model.result('pg4').feature('con1').feature('filt1').set('expr', 'x<5[cm]');
model.result('pg4').run;
model.result('pg4').create('str1', 'Streamline');
model.result('pg4').feature('str1').set('startmethod', 'coord');
model.result('pg4').feature('str1').set('xcoord', 'range(-0.05,0.002,0.05)');
model.result('pg4').feature('str1').set('ycoord', 0.045);
model.result('pg4').feature('str1').create('filt1', 'Filter');
model.result('pg4').run;
model.result('pg4').feature('str1').feature('filt1').set('expr', 'x<5[cm]');
model.result('pg4').run;

model.title('Pierce Electron Gun');

model.description('An electron gun must be able to draw a sufficient current and accelerate the electrons to the desired speed. The first part of an electron gun geometry presents unique design challenges because the emitted electron speeds are usually lowest there, and therefore the space charge density is quite high. The Pierce electron gun design uses electrodes with a particular shape to counteract the Coulomb repulsion between electrons in the beam. As a result, the electrons in the beam propagate in straight lines. The emitted electrons at the cathode are assumed to be space charge limited; the initial thermal distribution of electron velocities is neglected.');

model.mesh.clearMeshes;

model.sol('sol1').clearSolutionData;

model.label('pierce_electron_gun.mph');

model.modelNode.label('Components');

out = model;
