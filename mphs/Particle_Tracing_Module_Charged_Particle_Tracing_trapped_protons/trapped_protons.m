function out = model
%
% trapped_protons.m
%
% Model exported on May 26 2025, 21:31 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/Particle_Tracing_Module/Charged_Particle_Tracing');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 3);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.physics.create('cpt', 'ChargedParticleTracing', 'geom1');
model.physics('cpt').model('comp1');

model.study.create('std1');
model.study('std1').create('time', 'Transient');
model.study('std1').feature('time').setSolveFor('/physics/cpt', true);

model.param.set('Re', '6371.2[km]');
model.param.descr('Re', 'Radius of the Earth');
model.param.set('E0', '10[MeV]');
model.param.descr('E0', 'Initial particle energy');
model.param.set('alpha', '30[deg]');
model.param.descr('alpha', 'Equatorial pitch angle');

model.geom('geom1').lengthUnit('Mm');
model.geom('geom1').create('sph1', 'Sphere');
model.geom('geom1').feature('sph1').set('r', 'Re');
model.geom('geom1').run('sph1');
model.geom('geom1').create('sph2', 'Sphere');
model.geom('geom1').feature('sph2').set('r', '5*Re');
model.geom('geom1').run('sph2');
model.geom('geom1').create('dif1', 'Difference');
model.geom('geom1').feature('dif1').selection('input').set({'sph2'});

model.view('view1').set('transparency', true);

model.geom('geom1').feature('dif1').selection('input2').set({'sph1'});
model.geom('geom1').runPre('fin');

model.view('view1').set('transparency', false);
model.view('view1').hideObjects.create('hide1');
model.view('view1').hideObjects('hide1').init(2);
model.view('view1').hideObjects('hide1').set('dif1', [1 2 3 4 9 10 13 16]);

model.selection.create('ball1', 'Ball');
model.selection('ball1').model('comp1');

model.geom('geom1').run;

model.selection('ball1').set('entitydim', 2);
model.selection('ball1').set('r', 'Re');

model.physics('cpt').prop('Formulation').setIndex('Formulation', 'NewtonianFirstOrder', 0);
model.physics('cpt').prop('RelativisticCorrection').setIndex('RelativisticCorrection', 1, 0);
model.physics('cpt').feature('pp1').set('ParticleSpecies', 'Proton');
model.physics('cpt').create('mf1', 'MagneticForce', 3);
model.physics('cpt').feature('mf1').selection.all;
model.physics('cpt').feature('mf1').set('B_src', 'EarthsMagneticField');
model.physics('cpt').create('relg1', 'ReleaseGrid', -1);
model.physics('cpt').feature('relg1').setIndex('x0', '2*Re', 0);
model.physics('cpt').feature('relg1').set('InitialVelocity', 'KineticEnergyAndDirection');
model.physics('cpt').feature('relg1').set('Ep0', 'E0');
model.physics('cpt').feature('relg1').set('L0', {'0' 'sin(alpha)' 'cos(alpha)'});
model.physics('cpt').create('aux1', 'AuxiliaryField', -1);
model.physics('cpt').feature('aux1').set('fieldVariableName', 'Lm');
model.physics('cpt').create('aux2', 'AuxiliaryField', -1);
model.physics('cpt').feature('aux2').set('fieldVariableName', 'Ea');
model.physics('cpt').create('vre1', 'VelocityReinitialization', 3);
model.physics('cpt').feature('vre1').selection.all;
model.physics('cpt').feature('vre1').set('ev', '(cpt.vx*cpt.mf1.Berx+cpt.vy*cpt.mf1.Bery+cpt.vz*cpt.mf1.Berz)<0 && Lm==0');
model.physics('cpt').feature('vre1').set('EffectOnPrimaryParticle', 'NoneEffect');
model.physics('cpt').feature('vre1').set('caux_aux1', true);
model.physics('cpt').feature('vre1').set('daux_aux1', '(-acos(qz/sqrt(qx^2+qy^2+qz^2))+pi/2)*(180/pi)');
model.physics('cpt').feature.duplicate('relg2', 'relg1');
model.physics('cpt').feature('relg2').set('L0', {'0' 'sin(Ea)' 'cos(Ea)'});
model.physics('cpt').feature('relg2').set('DistributionFunction_aux2', 'ListOfValues');
model.physics('cpt').feature('relg2').setIndex('vals_aux2', 'range(10[deg],5[deg],80[deg])', 0);
model.physics('cpt').feature('relg2').set('OrderPart_aux2', true);

model.study('std1').feature('time').set('useadvanceddisable', true);
model.study('std1').feature('time').set('disabledphysics', {'cpt/aux1' 'cpt/aux2' 'cpt/vre1' 'cpt/relg2'});
model.study('std1').feature('time').set('tlist', 'range(0,0.005,3)');

model.sol.create('sol1');
model.sol('sol1').study('std1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'time');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').set('control', 'time');
model.sol('sol1').create('t1', 'Time');
model.sol('sol1').feature('t1').set('tlist', 'range(0,0.005,3)');
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
model.sol('sol1').feature('t1').set('rkmethod', 'dopri5');
model.sol('sol1').feature('t1').set('tstepsdopri5', 'strict');
model.sol('sol1').feature('t1').set('endtimeinterpolation', true);
model.sol('sol1').feature('t1').set('timemethod', 'rk');
model.sol('sol1').feature('t1').set('estrat', 'exclude');
model.sol('sol1').feature('t1').set('control', 'time');
model.sol('sol1').feature('t1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('t1').feature('fc1').set('ntolfact', 0.1);
model.sol('sol1').feature('t1').create('d1', 'Direct');
model.sol('sol1').feature('t1').feature('d1').set('linsolver', 'pardiso');
model.sol('sol1').feature('t1').feature('fc1').set('linsolver', 'd1');
model.sol('sol1').feature('t1').feature('fc1').set('ntolfact', 0.1);
model.sol('sol1').feature('t1').feature.remove('fcDef');
model.sol('sol1').attach('std1');
model.sol('sol1').runAll;

model.result.dataset.create('part1', 'Particle');
model.result.dataset('part1').set('solution', 'sol1');
model.result.dataset('part1').set('posdof', {'comp1.qx' 'comp1.qy' 'comp1.qz'});
model.result.dataset('part1').set('geom', 'geom1');
model.result.dataset('part1').set('pgeom', 'pgeom_cpt');
model.result.dataset('part1').set('pgeomspec', 'fromphysics');
model.result.dataset('part1').set('physicsinterface', 'cpt');
model.result.create('pg1', 'PlotGroup3D');
model.result('pg1').set('data', 'part1');
model.result('pg1').setIndex('looplevel', 601, 0);
model.result('pg1').label('Particle Trajectories (cpt)');
model.result('pg1').create('traj1', 'ParticleTrajectories');
model.result('pg1').feature('traj1').set('pointtype', 'point');
model.result('pg1').feature('traj1').set('linetype', 'none');
model.result('pg1').feature('traj1').create('col1', 'Color');
model.result('pg1').feature('traj1').feature('col1').set('expr', 'cpt.V');
model.result('pg1').run;
model.result('pg1').set('edges', false);
model.result('pg1').run;
model.result('pg1').feature('traj1').set('linetype', 'tube');
model.result('pg1').feature('traj1').set('tuberadiusscaleactive', true);
model.result('pg1').feature('traj1').set('tuberadiusscale', 0.01);
model.result('pg1').feature('traj1').set('interpolation', 'uniform');
model.result('pg1').feature('traj1').set('interpcount', 2000);
model.result('pg1').feature('traj1').set('pointtype', 'none');
model.result('pg1').run;
model.result('pg1').feature('traj1').feature('col1').set('expr', 'cpt.mf1.normB');
model.result('pg1').feature('traj1').feature('col1').set('descr', 'Magnetic flux density norm');
model.result('pg1').run;
model.result.dataset.create('cpl1', 'CutPlane');
model.result.dataset('cpl1').set('quickplane', 'xy');
model.result.dataset.duplicate('dset2', 'dset1');
model.result.dataset('dset2').selection.geom('geom1', 2);
model.result.dataset('dset2').selection.named('ball1');
model.result.create('pg2', 'PlotGroup3D');
model.result('pg2').run;
model.result('pg2').label('Magnetic Flux Density');
model.result('pg2').set('edges', false);
model.result('pg2').create('str1', 'Streamline');
model.result('pg2').feature('str1').set('expr', {'cpt.mf1.Berx' 'cpt.mf1.Bery' 'cpt.mf1.Berz'});
model.result('pg2').feature('str1').set('descr', 'Magnetic flux density, Earth (rotated)');
model.result('pg2').feature('str1').set('posmethod', 'start');
model.result('pg2').feature('str1').set('number', 50);
model.result('pg2').feature('str1').set('startdata', 'cpl1');
model.result('pg2').feature('str1').set('linetype', 'tube');
model.result('pg2').feature('str1').create('col1', 'Color');
model.result('pg2').run;
model.result('pg2').feature('str1').feature('col1').set('expr', 'cpt.mf1.normB');
model.result('pg2').feature('str1').feature('col1').set('descr', 'Magnetic flux density norm');
model.result('pg2').feature('str1').feature('col1').set('unit', 'nT');
model.result('pg2').run;
model.result('pg2').create('surf1', 'Surface');
model.result('pg2').feature('surf1').set('data', 'dset2');
model.result('pg2').feature('surf1').set('expr', 'cpt.mf1.normB');
model.result('pg2').feature('surf1').set('descr', 'Magnetic flux density norm');
model.result('pg2').feature('surf1').set('unit', 'nT');
model.result('pg2').feature('surf1').set('inheritplot', 'str1');
model.result('pg2').run;
model.result.create('pg3', 'PlotGroup1D');
model.result('pg3').run;
model.result('pg3').label('Energy Loss');
model.result('pg3').set('data', 'part1');
model.result('pg3').create('ptp1', 'Particle1D');
model.result('pg3').feature('ptp1').set('markerpos', 'datapoints');
model.result('pg3').feature('ptp1').set('linewidth', 'preference');
model.result('pg3').feature('ptp1').set('expr', '1-(cpt.Ep)/at(0,cpt.Ep)');
model.result('pg3').run;

model.study.create('std2');
model.study('std2').create('time', 'Transient');
model.study('std2').feature('time').setSolveFor('/physics/cpt', true);
model.study('std2').feature('time').set('useadvanceddisable', true);
model.study('std2').feature('time').set('disabledphysics', {'cpt/relg1'});
model.study('std2').feature('time').set('tlist', 'range(0,0.001,0.7)');

model.sol.create('sol2');
model.sol('sol2').study('std2');
model.sol('sol2').create('st1', 'StudyStep');
model.sol('sol2').feature('st1').set('study', 'std2');
model.sol('sol2').feature('st1').set('studystep', 'time');
model.sol('sol2').create('v1', 'Variables');
model.sol('sol2').feature('v1').set('control', 'time');
model.sol('sol2').create('t1', 'Time');
model.sol('sol2').feature('t1').set('tlist', 'range(0,0.001,0.7)');
model.sol('sol2').feature('t1').set('plot', 'off');
model.sol('sol2').feature('t1').set('plotgroup', 'pg1');
model.sol('sol2').feature('t1').set('plotfreq', 'tout');
model.sol('sol2').feature('t1').set('probesel', 'all');
model.sol('sol2').feature('t1').set('probes', {});
model.sol('sol2').feature('t1').set('probefreq', 'tsteps');
model.sol('sol2').feature('t1').set('rtol', 1.0E-5);
model.sol('sol2').feature('t1').set('atolglobalvaluemethod', 'factor');
model.sol('sol2').feature('t1').set('reacf', true);
model.sol('sol2').feature('t1').set('storeudot', true);
model.sol('sol2').feature('t1').set('rkmethod', 'dopri5');
model.sol('sol2').feature('t1').set('tstepsdopri5', 'strict');
model.sol('sol2').feature('t1').set('endtimeinterpolation', true);
model.sol('sol2').feature('t1').set('timemethod', 'rk');
model.sol('sol2').feature('t1').set('estrat', 'exclude');
model.sol('sol2').feature('t1').set('control', 'time');
model.sol('sol2').feature('t1').create('fc1', 'FullyCoupled');
model.sol('sol2').feature('t1').feature('fc1').set('ntolfact', 0.1);
model.sol('sol2').feature('t1').create('d1', 'Direct');
model.sol('sol2').feature('t1').feature('d1').set('linsolver', 'pardiso');
model.sol('sol2').feature('t1').feature('fc1').set('linsolver', 'd1');
model.sol('sol2').feature('t1').feature('fc1').set('ntolfact', 0.1);
model.sol('sol2').feature('t1').feature.remove('fcDef');
model.sol('sol2').attach('std2');
model.sol('sol2').runAll;

model.result.dataset.create('part2', 'Particle');
model.result.dataset('part2').set('solution', 'sol2');
model.result.dataset('part2').set('posdof', {'comp1.qx' 'comp1.qy' 'comp1.qz'});
model.result.dataset('part2').set('geom', 'geom1');
model.result.dataset('part2').set('pgeom', 'pgeom_cpt');
model.result.dataset('part2').set('pgeomspec', 'fromphysics');
model.result.dataset('part2').set('physicsinterface', 'cpt');
model.result.create('pg4', 'PlotGroup3D');
model.result('pg4').set('data', 'part2');
model.result('pg4').setIndex('looplevel', 701, 0);
model.result('pg4').label('Particle Trajectories (cpt) 1');
model.result('pg4').create('traj1', 'ParticleTrajectories');
model.result('pg4').feature('traj1').set('pointtype', 'point');
model.result('pg4').feature('traj1').set('linetype', 'none');
model.result('pg4').feature('traj1').create('col1', 'Color');
model.result('pg4').feature('traj1').feature('col1').set('expr', 'cpt.V');
model.result('pg4').run;
model.result('pg4').set('edges', false);
model.result('pg4').run;
model.result('pg4').feature('traj1').set('linetype', 'line');
model.result('pg4').feature('traj1').set('pointtype', 'none');
model.result('pg4').run;
model.result('pg4').feature('traj1').feature('col1').set('expr', 'Ea*180/pi');
model.result('pg4').run;
model.result('pg4').create('surf1', 'Surface');
model.result('pg4').feature('surf1').set('data', 'dset2');
model.result('pg4').feature('surf1').set('coloring', 'uniform');
model.result('pg4').feature('surf1').set('color', 'gray');
model.result('pg4').run;
model.result.create('pg5', 'PlotGroup1D');
model.result('pg5').run;
model.result('pg5').label('Mirror Point Latitude');
model.result('pg5').set('data', 'part2');
model.result('pg5').setIndex('looplevelinput', 'last', 0);
model.result('pg5').set('xlabelactive', true);
model.result('pg5').set('xlabel', 'Equatorial pitch angle (deg)');
model.result('pg5').set('ylabelactive', true);
model.result('pg5').set('ylabel', 'Mirror point latitude (deg)');
model.result('pg5').create('ptp1', 'Particle1D');
model.result('pg5').feature('ptp1').set('markerpos', 'datapoints');
model.result('pg5').feature('ptp1').set('linewidth', 'preference');
model.result('pg5').feature('ptp1').set('expr', 'Lm');
model.result('pg5').feature('ptp1').set('descr', 'Auxiliary dependent variable Lm');
model.result('pg5').feature('ptp1').set('xdata', 'expr');
model.result('pg5').feature('ptp1').set('xdataexpr', 'Ea*180/pi');
model.result('pg5').run;

model.title('Motion of Trapped Protons in Earth''s Magnetic Field');

model.description('This example computes the trajectory of relativistic protons in Earth''s magnetic field. The mirror point latitude of the trapped protons is computed as a function of the equatorial pitch angle at which the protons are released. This example utilizes the Magnetic Force feature, which includes a built-in option to use the International Geomagnetic Reference Field (IGRF) data.');

model.label('trapped_protons.mph');

model.modelNode.label('Components');

out = model;
