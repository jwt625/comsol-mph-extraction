function out = model
%
% magnetic_lens.m
%
% Model exported on May 26 2025, 21:24 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/ACDC_Module/Electromagnetics_and_Particle_Tracing');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 3);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.physics.create('mf', 'InductionCurrents', 'geom1');
model.physics('mf').model('comp1');

model.study.create('std1');
model.study('std1').create('stat', 'Stationary');
model.study('std1').feature('stat').setSolveFor('/physics/mf', true);

model.param.set('Ic', '0.32[A]');
model.param.descr('Ic', 'Coil current');
model.param.set('Nc', '1000');
model.param.descr('Nc', 'Number of turns in coil');

model.geom('geom1').insertFile('magnetic_lens_geom_sequence.mph', 'geom1');
model.geom('geom1').run;

model.material.create('mat1', 'Common', 'comp1');
model.material('mat1').propertyGroup.create('Enu', 'Young''s modulus and Poisson''s ratio');
model.material('mat1').propertyGroup.create('linzRes', 'Linearized resistivity');
model.material('mat1').label('Copper');
model.material('mat1').set('family', 'copper');
model.material('mat1').propertyGroup('def').set('relpermeability', {'1' '0' '0' '0' '1' '0' '0' '0' '1'});
model.material('mat1').propertyGroup('def').set('electricconductivity', {'5.998e7[S/m]' '0' '0' '0' '5.998e7[S/m]' '0' '0' '0' '5.998e7[S/m]'});
model.material('mat1').propertyGroup('def').set('thermalexpansioncoefficient', {'17e-6[1/K]' '0' '0' '0' '17e-6[1/K]' '0' '0' '0' '17e-6[1/K]'});
model.material('mat1').propertyGroup('def').set('heatcapacity', '385[J/(kg*K)]');
model.material('mat1').propertyGroup('def').set('relpermittivity', {'1' '0' '0' '0' '1' '0' '0' '0' '1'});
model.material('mat1').propertyGroup('def').set('density', '8960[kg/m^3]');
model.material('mat1').propertyGroup('def').set('thermalconductivity', {'400[W/(m*K)]' '0' '0' '0' '400[W/(m*K)]' '0' '0' '0' '400[W/(m*K)]'});
model.material('mat1').propertyGroup('Enu').set('E', '110[GPa]');
model.material('mat1').propertyGroup('Enu').set('nu', '0.35');
model.material('mat1').propertyGroup('linzRes').set('rho0', '1.72e-8[ohm*m]');
model.material('mat1').propertyGroup('linzRes').set('alpha', '0.0039[1/K]');
model.material('mat1').propertyGroup('linzRes').set('Tref', '298[K]');
model.material('mat1').propertyGroup('linzRes').addInput('temperature');
model.material.create('mat2', 'Common', 'comp1');
model.material('mat2').label('Perfect vacuum');
model.material('mat2').propertyGroup('def').set('density', '');
model.material('mat2').propertyGroup('def').set('relpermeability', '');
model.material('mat2').propertyGroup('def').set('relpermittivity', '');
model.material('mat2').propertyGroup('def').set('electricconductivity', '');
model.material('mat2').propertyGroup('def').set('density', '0');
model.material('mat2').propertyGroup('def').set('relpermeability', {'1' '0' '0' '0' '1' '0' '0' '0' '1'});
model.material('mat2').propertyGroup('def').set('relpermittivity', {'1' '0' '0' '0' '1' '0' '0' '0' '1'});
model.material('mat2').propertyGroup('def').set('electricconductivity', {'0' '0' '0' '0' '0' '0' '0' '0' '0'});
model.material('mat2').selection.set([1]);

model.physics('mf').create('coil1', 'Coil', 3);
model.physics('mf').feature('coil1').selection.set([4]);
model.physics('mf').feature('coil1').set('ConductorModel', 'Multi');
model.physics('mf').feature('coil1').set('CoilType', 'Circular');
model.physics('mf').feature('coil1').set('N', 'Nc');
model.physics('mf').feature('coil1').set('ICoil', 'Ic');
model.physics('mf').feature('coil1').feature('cre1').selection.set([22 23 57 82]);

model.mesh('mesh1').create('sca1', 'Scale');
model.mesh('mesh1').feature('sca1').selection.geom('geom1', 3);
model.mesh('mesh1').feature('sca1').selection.set([2 3 4 5]);
model.mesh('mesh1').feature('sca1').set('scale', 0.5);
model.mesh('mesh1').create('ftri1', 'FreeTri');
model.mesh('mesh1').feature('ftri1').selection.set([30]);
model.mesh('mesh1').feature('ftri1').create('size1', 'Size');
model.mesh('mesh1').feature('ftri1').feature('size1').set('hauto', 1);
model.mesh('mesh1').create('ftet1', 'FreeTet');
model.mesh('mesh1').run;

model.sol.create('sol1');
model.sol('sol1').study('std1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'stat');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').set('control', 'stat');
model.sol('sol1').create('s1', 'Stationary');
model.sol('sol1').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('s1').create('i1', 'Iterative');
model.sol('sol1').feature('s1').feature('i1').set('linsolver', 'fgmres');
model.sol('sol1').feature('s1').feature('i1').set('nlinnormuse', true);
model.sol('sol1').feature('s1').feature('i1').create('mg1', 'Multigrid');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('pr').create('so1', 'SOR');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('po').create('so1', 'SOR');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('cs').create('ams1', 'AMS');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('cs').feature('ams1').set('prefun', 'ams');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('cs').feature('ams1').set('sorvecdof', {'comp1_A'});
model.sol('sol1').feature('s1').feature('fc1').set('linsolver', 'i1');
model.sol('sol1').feature('s1').feature.remove('fcDef');
model.sol('sol1').attach('std1');
model.sol('sol1').runAll;

model.result.create('pg1', 'PlotGroup3D');
model.result('pg1').label('Magnetic Flux Density Norm (mf)');
model.result('pg1').set('frametype', 'spatial');
model.result('pg1').set('showlegendsmaxmin', true);
model.result('pg1').set('data', 'dset1');
model.result('pg1').set('defaultPlotID', 'InterfaceComponents/PlotDefaults/icom6/pdef1/pcond2/pcond1/pg1');
model.result('pg1').feature.create('mslc1', 'Multislice');
model.result('pg1').feature('mslc1').set('showsolutionparams', 'on');
model.result('pg1').feature('mslc1').set('solutionparams', 'parent');
model.result('pg1').feature('mslc1').set('multiplanexmethod', 'coord');
model.result('pg1').feature('mslc1').set('xcoord', 'mf.CPx');
model.result('pg1').feature('mslc1').set('multiplaneymethod', 'coord');
model.result('pg1').feature('mslc1').set('ycoord', 'mf.CPy');
model.result('pg1').feature('mslc1').set('multiplanezmethod', 'coord');
model.result('pg1').feature('mslc1').set('zcoord', 'mf.CPz');
model.result('pg1').feature('mslc1').set('colortable', 'Prism');
model.result('pg1').feature('mslc1').set('colortabletrans', 'nonlinear');
model.result('pg1').feature('mslc1').set('colorcalibration', -0.8);
model.result('pg1').feature('mslc1').set('showsolutionparams', 'on');
model.result('pg1').feature('mslc1').set('data', 'parent');
model.result('pg1').feature.create('strmsl1', 'StreamlineMultislice');
model.result('pg1').feature('strmsl1').set('showsolutionparams', 'on');
model.result('pg1').feature('strmsl1').set('solutionparams', 'parent');
model.result('pg1').feature('strmsl1').set('multiplanexmethod', 'coord');
model.result('pg1').feature('strmsl1').set('xcoord', 'mf.CPx');
model.result('pg1').feature('strmsl1').set('multiplaneymethod', 'coord');
model.result('pg1').feature('strmsl1').set('ycoord', 'mf.CPy');
model.result('pg1').feature('strmsl1').set('multiplanezmethod', 'coord');
model.result('pg1').feature('strmsl1').set('zcoord', 'mf.CPz');
model.result('pg1').feature('strmsl1').set('titletype', 'none');
model.result('pg1').feature('strmsl1').set('posmethod', 'uniform');
model.result('pg1').feature('strmsl1').set('udist', 0.02);
model.result('pg1').feature('strmsl1').set('maxlen', 0.4);
model.result('pg1').feature('strmsl1').set('maxtime', Inf);
model.result('pg1').feature('strmsl1').set('inheritcolor', false);
model.result('pg1').feature('strmsl1').set('showsolutionparams', 'on');
model.result('pg1').feature('strmsl1').set('maxtime', Inf);
model.result('pg1').feature('strmsl1').set('showsolutionparams', 'on');
model.result('pg1').feature('strmsl1').set('maxtime', Inf);
model.result('pg1').feature('strmsl1').set('showsolutionparams', 'on');
model.result('pg1').feature('strmsl1').set('maxtime', Inf);
model.result('pg1').feature('strmsl1').set('showsolutionparams', 'on');
model.result('pg1').feature('strmsl1').set('maxtime', Inf);
model.result('pg1').feature('strmsl1').set('data', 'parent');
model.result('pg1').feature('strmsl1').set('inheritplot', 'mslc1');
model.result('pg1').feature('strmsl1').feature.create('col1', 'Color');
model.result('pg1').feature('strmsl1').feature('col1').set('colortable', 'PrismDark');
model.result('pg1').feature('strmsl1').feature('col1').set('colorlegend', false);
model.result('pg1').feature('strmsl1').feature('col1').set('colortabletrans', 'nonlinear');
model.result('pg1').feature('strmsl1').feature('col1').set('colorcalibration', -0.8);
model.result('pg1').feature('strmsl1').feature.create('filt1', 'Filter');
model.result('pg1').feature('strmsl1').feature('filt1').set('expr', '!isScalingSystemDomain');
model.result('pg1').run;
model.result('pg1').run;
model.result('pg1').feature('mslc1').set('zcoord', 0);
model.result('pg1').run;
model.result('pg1').feature('strmsl1').set('zcoord', 0);
model.result('pg1').run;

model.physics.create('cpt', 'ChargedParticleTracing', 'geom1');
model.physics('cpt').model('comp1');

model.study('std1').feature('stat').setSolveFor('/physics/cpt', false);
model.study.create('std2');
model.study('std2').create('time', 'Transient');
model.study('std2').feature('time').setSolveFor('/physics/mf', false);
model.study('std2').feature('time').setSolveFor('/physics/cpt', true);

model.physics('cpt').selection.set([1]);
model.physics('cpt').feature('pp1').set('ParticleSpecies', 'Electron');
model.physics('cpt').create('mf1', 'MagneticForce', 3);
model.physics('cpt').feature('mf1').selection.all;
model.physics('cpt').feature('mf1').set('B_src', 'root.comp1.mf.Bx');
model.physics('cpt').create('pbeam1', 'ParticleBeam', 2);
model.physics('cpt').feature('pbeam1').selection.set([30]);
model.physics('cpt').feature('pbeam1').setIndex('N', 10000, 0);
model.physics('cpt').feature('pbeam1').set('e1rms', '0.1[um]');
model.physics('cpt').feature('pbeam1').set('El', '0.5[keV]');

model.study('std2').feature('time').set('usesol', true);
model.study('std2').feature('time').set('notsolmethod', 'sol');
model.study('std2').feature('time').set('notstudy', 'std1');
model.study('std2').feature('time').set('tlist', 'range(0,1.0204081632653062e-10,5.0e-9)');

model.sol.create('sol2');
model.sol('sol2').study('std2');
model.sol('sol2').create('st1', 'StudyStep');
model.sol('sol2').feature('st1').set('study', 'std2');
model.sol('sol2').feature('st1').set('studystep', 'time');
model.sol('sol2').create('v1', 'Variables');
model.sol('sol2').feature('v1').set('control', 'time');
model.sol('sol2').create('t1', 'Time');
model.sol('sol2').feature('t1').set('tlist', 'range(0,1.0204081632653062e-10,5.0e-9)');
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
model.sol('sol2').feature('t1').set('tstepsgenalpha', 'strict');
model.sol('sol2').feature('t1').set('endtimeinterpolation', true);
model.sol('sol2').feature('t1').set('timemethod', 'genalpha');
model.sol('sol2').feature('t1').set('estrat', 'exclude');
model.sol('sol2').feature('t1').set('rhoinf', 1);
model.sol('sol2').feature('t1').set('control', 'time');
model.sol('sol2').feature('t1').create('fc1', 'FullyCoupled');
model.sol('sol2').feature('t1').feature('fc1').set('ntolfact', 0.1);
model.sol('sol2').feature('t1').create('i1', 'Iterative');
model.sol('sol2').feature('t1').feature('i1').set('linsolver', 'gmres');
model.sol('sol2').feature('t1').feature('i1').create('ja1', 'Jacobi');
model.sol('sol2').feature('t1').feature('fc1').set('linsolver', 'i1');
model.sol('sol2').feature('t1').feature('fc1').set('ntolfact', 0.1);
model.sol('sol2').feature('t1').feature.remove('fcDef');
model.sol('sol2').attach('std2');
model.sol('sol2').runAll;

model.result.dataset.create('part1', 'Particle');
model.result.dataset('part1').set('solution', 'sol2');
model.result.dataset('part1').set('posdof', {'comp1.qx' 'comp1.qy' 'comp1.qz'});
model.result.dataset('part1').set('geom', 'geom1');
model.result.dataset('part1').set('pgeom', 'pgeom_cpt');
model.result.dataset('part1').set('pgeomspec', 'fromphysics');
model.result.dataset('part1').set('physicsinterface', 'cpt');
model.result.create('pg2', 'PlotGroup3D');
model.result('pg2').set('data', 'part1');
model.result('pg2').setIndex('looplevel', 50, 0);
model.result('pg2').label('Particle Trajectories (cpt)');
model.result('pg2').create('traj1', 'ParticleTrajectories');
model.result('pg2').feature('traj1').set('pointtype', 'point');
model.result('pg2').feature('traj1').set('linetype', 'none');
model.result('pg2').feature('traj1').create('col1', 'Color');
model.result('pg2').feature('traj1').feature('col1').set('expr', 'cpt.V');
model.result.create('pg3', 'PlotGroup3D');
model.result('pg3').set('data', 'part1');
model.result('pg3').setIndex('looplevel', 50, 0);
model.result('pg3').label('Average Beam Position (cpt)');
model.result('pg3').create('pttraj1', 'PointTrajectories');
model.result('pg3').feature('pttraj1').set('plotdata', 'global');
model.result('pg3').feature('pttraj1').set('globalexpr', {'cpt.qavx' 'cpt.qavy' 'cpt.qavz'});
model.result('pg3').feature('pttraj1').create('col1', 'Color');
model.result('pg3').feature('pttraj1').feature('col1').set('expr', 'cpt.e1hrms');
model.result('pg2').run;
model.result('pg2').run;
model.result('pg2').feature('traj1').set('linetype', 'line');
model.result('pg2').feature('traj1').set('pointtype', 'none');
model.result('pg2').run;
model.result('pg2').feature('traj1').feature('col1').set('expr', 'sqrt(cpt.Ftx^2+cpt.Fty^2+cpt.Ftz^2)');
model.result('pg2').feature('traj1').feature('col1').set('colortable', 'Plasma');
model.result('pg2').run;
model.result('pg3').run;
model.result('pg3').label('Average Beam Position and Hyperemittance');
model.result('pg3').run;
model.result('pg3').feature('pttraj1').set('linetype', 'tube');
model.result('pg3').feature('pttraj1').set('radiusexpr', 'cpt.e1hrms');
model.result('pg3').feature('pttraj1').set('tuberadiusscaleactive', true);
model.result('pg3').feature('pttraj1').set('tuberadiusscale', '4E10');
model.result('pg3').feature('pttraj1').set('interpolation', 'uniform');
model.result('pg3').run;
model.result.dataset.create('cpl1', 'CutPlane');
model.result.dataset('cpl1').set('quickplane', 'xy');
model.result.dataset('cpl1').set('quickz', -6);
model.result.dataset('cpl1').set('data', 'part1');
model.result.dataset.duplicate('cpl2', 'cpl1');
model.result.dataset('cpl2').set('quickz', 7);
model.result.dataset.duplicate('cpl3', 'cpl2');
model.result.dataset('cpl3').set('quickz', 34);
model.result.create('pg4', 'PlotGroup2D');
model.result('pg4').run;
model.result('pg4').label(['Poincar' native2unicode(hex2dec({'00' 'e9'}), 'unicode') ' Maps']);
model.result('pg4').set('titletype', 'manual');
model.result('pg4').set('title', ['Poincar' native2unicode(hex2dec({'00' 'e9'}), 'unicode') ' Map']);
model.result('pg4').create('poma1', 'PoincareMap');
model.result('pg4').feature('poma1').set('data', 'cpl3');
model.result('pg4').feature('poma1').set('color', 'black');
model.result('pg4').feature('poma1').set('solutionparams', 'parent');
model.result('pg4').feature.duplicate('poma2', 'poma1');
model.result('pg4').run;
model.result('pg4').feature('poma2').set('data', 'cpl1');
model.result('pg4').feature('poma2').set('color', 'red');
model.result('pg4').feature.duplicate('poma3', 'poma2');
model.result('pg4').run;
model.result('pg4').feature('poma3').set('data', 'cpl2');
model.result('pg4').feature('poma3').set('color', 'blue');
model.result('pg4').run;

model.title('Magnetic Lens');

model.description('This example uses the Charged Particle Tracing interface to compute the trajectories of electrons in a spatially varying magnetic field. The focusing effect of the magnetic field on the electron beam is analyzed further by computing the emittance along the beam trajectory.');

model.mesh.clearMeshes;

model.sol('sol1').clearSolutionData;
model.sol('sol2').clearSolutionData;

model.label('magnetic_lens.mph');

model.modelNode.label('Components');

out = model;
