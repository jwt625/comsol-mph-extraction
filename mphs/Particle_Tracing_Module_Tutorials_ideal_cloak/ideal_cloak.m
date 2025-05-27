function out = model
%
% ideal_cloak.m
%
% Model exported on May 26 2025, 21:31 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/Particle_Tracing_Module/Tutorials');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 3);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.physics.create('pt', 'MathParticle', 'geom1');
model.physics('pt').model('comp1');

model.study.create('std1');
model.study('std1').create('time', 'Transient');
model.study('std1').feature('time').setSolveFor('/physics/pt', true);

model.param.set('L', '1[m]');
model.param.descr('L', 'Box length');
model.param.set('a', '0.2[m]');
model.param.descr('a', 'Inner radius');
model.param.set('b', '0.4[m]');
model.param.descr('b', 'Outer radius');
model.param.set('n_air', '1');
model.param.descr('n_air', 'Refractive index of air');
model.param.set('hmax', 'L*0.2');
model.param.descr('hmax', 'Maximum element size in volume');
model.param.set('hmax_cloak', 'b*0.05');
model.param.descr('hmax_cloak', 'Maximum element size in cloak');

model.geom('geom1').create('blk1', 'Block');
model.geom('geom1').feature('blk1').set('size', {'2*L' '2*L' '2*L'});
model.geom('geom1').feature('blk1').set('base', 'center');
model.geom('geom1').run('blk1');
model.geom('geom1').create('sph1', 'Sphere');
model.geom('geom1').feature('sph1').set('r', 'a');
model.geom('geom1').run('sph1');
model.geom('geom1').create('sph2', 'Sphere');
model.geom('geom1').feature('sph2').set('r', 'b');
model.geom('geom1').runPre('fin');

model.variable.create('var1');
model.variable('var1').model('comp1');

model.geom('geom1').run;

% To import content from file, use:
% model.variable('var1').loadFile('FILENAME');
model.variable('var1').set('r', 'sqrt(x^2+y^2+z^2+eps)', 'Radial coordinate');
model.variable('var1').set('rh', 'sqrt(x^2+y^2+eps)', 'Radial coordinate in xy-plane');
model.variable('var1').set('dr', '1e-2*b[1/m]', 'Refractive index smoothing function');
model.variable('var1').set('cos_theta', 'z/r');
model.variable('var1').set('sin_theta', 'rh/r');
model.variable('var1').set('pr', 'px*sin_theta*cos_phi+py*sin_theta*sin_phi+pz*cos_theta', 'Wave vector, r-component');
model.variable('var1').set('p_theta', 'px*cos_theta*cos_phi+py*cos_theta*sin_phi-pz*sin_theta', 'Wave vector, theta-component');
model.variable('var1').set('p_phi', '-px*sin_phi+py*cos_phi', 'Wave vector, phi-component');
model.variable('var1').set('n_r_cloak', 'b/(b-a)', 'Refractive index in cloak, r-component');
model.variable('var1').set('n_theta_cloak', 'b/(b-a)*(r-a)/r', 'Refractive index in cloak, theta-component');
model.variable('var1').set('n_phi_cloak', 'n_theta_cloak', 'Refractive index in cloak, phi-component');
model.variable('var1').set('cos_phi', 'x/rh');
model.variable('var1').set('sin_phi', 'y/rh');
model.variable('var1').set('n_r', 'n_air+(n_r_cloak-n_air)*flc2hs(b[1/m]-r[1/m],dr)', 'Refractive index, r-component');
model.variable('var1').set('n_theta', 'n_air+(n_theta_cloak-n_air)*flc2hs(b[1/m]-r[1/m],dr)', 'Refractive index, theta-component');
model.variable('var1').set('n_phi', 'n_air+(n_phi_cloak-n_air)*flc2hs(b[1/m]-r[1/m],dr)', 'Refractive index, phi-component');
model.variable('var1').set('H_photon', 'c_const*sqrt(pr^2/n_r^2+p_theta^2/n_theta^2+p_phi^2/n_phi^2+eps)', 'Dispersion relation');

model.physics('pt').prop('Formulation').setIndex('Formulation', 'Hamiltonian', 0);
model.physics('pt').feature('pp1').set('H', 'H_photon');
model.physics('pt').feature('pp1').set('mp', 1);
model.physics('pt').create('relg1', 'ReleaseGrid', -1);
model.physics('pt').feature('relg1').setIndex('x0', -1, 0);
model.physics('pt').feature('relg1').setIndex('x0', 'range(-0.38,0.01,-0.02) range(0.02,0.01,0.38)', 1);
model.physics('pt').feature('relg1').set('v0', [1 0 0]);

model.mesh('mesh1').create('ftet1', 'FreeTet');
model.mesh('mesh1').feature('ftet1').create('size1', 'Size');
model.mesh('mesh1').feature('ftet1').feature('size1').selection.geom('geom1', 3);
model.mesh('mesh1').feature('ftet1').feature('size1').selection.set([2]);
model.mesh('mesh1').feature('ftet1').feature('size1').set('custom', true);
model.mesh('mesh1').feature('ftet1').feature('size1').set('hmaxactive', true);
model.mesh('mesh1').feature('ftet1').feature('size1').set('hmax', 'hmax_cloak');
model.mesh('mesh1').feature('ftet1').feature('size1').set('hminactive', true);
model.mesh('mesh1').feature('ftet1').feature('size1').set('hmin', 'hmax_cloak/2');
model.mesh('mesh1').feature('size').set('custom', true);
model.mesh('mesh1').feature('size').set('hmax', 'hmax');
model.mesh('mesh1').feature('size').set('hmin', 'hmax/2');
model.mesh('mesh1').run;

model.study('std1').feature('time').set('tlist', 'range(0,(2[m]/c_const-0)/300,2[m]/c_const)');
model.study('std1').feature('time').set('usertol', true);
model.study('std1').feature('time').set('rtol', '1e-6');

model.sol.create('sol1');
model.sol('sol1').study('std1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'time');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').set('control', 'time');
model.sol('sol1').create('t1', 'Time');
model.sol('sol1').feature('t1').set('tlist', 'range(0,(2[m]/c_const-0)/300,2[m]/c_const)');
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
model.sol('sol1').feature('t1').set('control', 'time');
model.sol('sol1').feature('t1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('t1').feature('fc1').set('ntolfact', 0.1);
model.sol('sol1').feature('t1').feature('fc1').set('linsolver', 'dDef');
model.sol('sol1').feature('t1').feature('fc1').set('ntolfact', 0.1);
model.sol('sol1').feature('t1').feature.remove('fcDef');
model.sol('sol1').attach('std1');
model.sol('sol1').feature('t1').set('odesolvertype', 'explicit');
model.sol('sol1').feature('t1').set('rkmethod', 'dopri5');
model.sol('sol1').runAll;

model.result.dataset.create('part1', 'Particle');
model.result.dataset('part1').set('solution', 'sol1');
model.result.dataset('part1').set('posdof', {'comp1.qx' 'comp1.qy' 'comp1.qz'});
model.result.dataset('part1').set('geom', 'geom1');
model.result.dataset('part1').set('pgeom', 'pgeom_pt');
model.result.dataset('part1').set('pgeomspec', 'fromphysics');
model.result.dataset('part1').set('physicsinterface', 'pt');
model.result.create('pg1', 'PlotGroup3D');
model.result('pg1').set('data', 'part1');
model.result('pg1').setIndex('looplevel', 301, 0);
model.result('pg1').label('Particle Trajectories (pt)');
model.result('pg1').create('traj1', 'ParticleTrajectories');
model.result('pg1').feature('traj1').set('pointtype', 'point');
model.result('pg1').feature('traj1').set('linetype', 'none');
model.result('pg1').feature('traj1').create('col1', 'Color');
model.result('pg1').feature('traj1').feature('col1').set('expr', 'pt.V');
model.result('pg1').run;
model.result('pg1').set('edges', false);
model.result('pg1').set('titletype', 'none');
model.result('pg1').run;
model.result('pg1').feature('traj1').set('linetype', 'line');
model.result('pg1').feature('traj1').set('pointtype', 'none');
model.result('pg1').run;
model.result('pg1').feature('traj1').feature('col1').set('colorlegend', false);
model.result('pg1').run;
model.result('pg1').create('surf1', 'Surface');
model.result('pg1').feature('surf1').set('data', 'dset1');
model.result('pg1').feature('surf1').set('expr', 'cos_phi');
model.result('pg1').feature('surf1').set('colortable', 'WaveLight');
model.result('pg1').feature('surf1').set('colorlegend', false);
model.result('pg1').feature('surf1').create('sel1', 'Selection');

model.view('view1').set('renderwireframe', true);

model.result('pg1').feature('surf1').feature('sel1').selection.set([6 8 14 18]);
model.result('pg1').run;
model.result('pg1').create('surf2', 'Surface');
model.result('pg1').feature('surf2').set('data', 'dset1');
model.result('pg1').feature('surf2').set('coloring', 'uniform');
model.result('pg1').feature('surf2').set('color', 'gray');
model.result('pg1').feature('surf2').create('sel1', 'Selection');
model.result('pg1').feature('surf2').feature('sel1').selection.geom('geom1', 3);
model.result('pg1').feature('surf2').feature('sel1').selection.set([3]);
model.result('pg1').run;

model.view('view1').set('showgrid', false);

model.result('pg1').run;
model.result('pg1').run;
model.result.dataset.create('cpl1', 'CutPlane');
model.result.dataset('cpl1').set('data', 'part1');
model.result.dataset('cpl1').set('quickx', -0.99);
model.result.dataset.duplicate('cpl2', 'cpl1');
model.result.dataset('cpl2').set('quickx', 0.99);
model.result.create('pg2', 'PlotGroup2D');
model.result('pg2').run;
model.result('pg2').label('Ray Position Relative to Initial Position');
model.result('pg2').set('xlabelactive', true);
model.result('pg2').set('xlabel', 'y-position (m)');
model.result('pg2').set('ylabelactive', true);
model.result('pg2').set('ylabel', 'z-position (m)');
model.result('pg2').create('poma1', 'PoincareMap');
model.result('pg2').feature('poma1').set('data', 'cpl1');
model.result('pg2').run;
model.result('pg2').feature.duplicate('poma2', 'poma1');
model.result('pg2').run;
model.result('pg2').feature('poma2').set('data', 'cpl2');
model.result('pg2').feature('poma2').set('color', 'blue');
model.result('pg2').feature('poma2').set('sphereradiusscaleactive', true);
model.result('pg2').feature('poma2').set('sphereradiusscale', 0.7);
model.result('pg2').feature('poma2').set('titletype', 'none');
model.result('pg2').run;
model.result.create('pg3', 'PlotGroup1D');
model.result('pg3').run;
model.result('pg3').label('Change in Lateral Position');
model.result('pg3').set('data', 'part1');
model.result('pg3').setIndex('looplevelinput', 'last', 0);
model.result('pg3').set('xlabelactive', true);
model.result('pg3').set('xlabel', 'Initial position (mm)');
model.result('pg3').set('ylabelactive', true);
model.result('pg3').set('ylabel', 'Change in position (mm)');
model.result('pg3').create('ptp1', 'Particle1D');
model.result('pg3').feature('ptp1').set('markerpos', 'datapoints');
model.result('pg3').feature('ptp1').set('linewidth', 'preference');
model.result('pg3').feature('ptp1').set('expr', 'qy-at(0,qy)');
model.result('pg3').feature('ptp1').set('unit', 'mm');
model.result('pg3').feature('ptp1').set('titletype', 'none');
model.result('pg3').feature('ptp1').set('xdata', 'expr');
model.result('pg3').feature('ptp1').set('xdataexpr', 'at(0,qy)');
model.result('pg3').feature('ptp1').set('xdataunit', 'mm');
model.result('pg3').feature('ptp1').set('linemarker', 'point');
model.result('pg3').run;

model.title('Ideal Cloak');

model.description('In this example, an optical cloaking device is designed using an anisotropic medium to conceal an object from view without distorting electromagnetic waves from the point of view of the observer. The Hamiltonian formulation in the Mathematical Particle Tracing interface is used to trace the rays.');

model.mesh.clearMeshes;

model.sol('sol1').clearSolutionData;

model.label('ideal_cloak.mph');

model.modelNode.label('Components');

out = model;
