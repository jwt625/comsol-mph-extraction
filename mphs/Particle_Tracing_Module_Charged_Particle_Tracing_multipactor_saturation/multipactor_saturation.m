function out = model
%
% multipactor_saturation.m
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

model.physics.create('es', 'Electrostatics', 'geom1');
model.physics('es').model('comp1');
model.physics.create('cpt', 'ChargedParticleTracing', 'geom1');
model.physics('cpt').model('comp1');
model.physics('cpt').prop('ParticleReleaseSpecification').set('ParticleReleaseSpecification', 'SpecifyCurrent');
model.physics('cpt').prop('RelativisticCorrection').set('RelativisticCorrection', '0');
model.physics('cpt').create('ef1', 'ElectricForce');
model.physics('cpt').feature('ef1').selection.all;
model.physics('cpt').feature('ef1').set('SpecifyForceUsing', {'ElectricField'});

model.multiphysics.create('epfi1', 'ElectricParticleFieldInteraction', 'geom1', 3);
model.multiphysics('epfi1').set('ChargeDensitySource_physics', 'cpt');
model.multiphysics('epfi1').set('ChargeDensityDestination_physics', 'es');

model.study.create('std1');
model.study('std1').create('time', 'Transient');
model.study('std1').feature('time').setSolveFor('/physics/es', true);
model.study('std1').feature('time').setSolveFor('/physics/cpt', true);
model.study('std1').feature('time').setSolveFor('/multiphysics/epfi1', true);

% To import content from file, use:
% model.param.loadFile('FILENAME');
model.param.set('L', '0.1[cm]', 'Edge length');
model.param.set('D', '0.16[cm]', 'Gap thickness');
model.param.set('f0', '2.5[GHz]', 'Excitation frequency');
model.param.set('V0', '1078[V]', 'RF voltage');
model.param.set('B0', '360[G]', 'Magnetic flux density norm');
model.param.set('T0', '300[K]', 'Surface temperature');
model.param.set('n', '5E4', 'Charge multiplication factor');

model.variable.create('var1');

% To import content from file, use:
% model.variable('var1').loadFile('FILENAME');
model.variable('var1').set('tau', 'f0*t', 'Number of RF cycles');
model.variable('var1').set('relLeft', 'mod(tau,1)<0.5', 'Allow release from left');
model.variable('var1').set('relRight', 'mod(tau,1)>0.5', 'Allow release from right');

model.func.create('pw1', 'Piecewise');
model.func('pw1').setIndex('pieces', 0, 0, 0);
model.func('pw1').setIndex('pieces', 300, 0, 1);
model.func('pw1').setIndex('pieces', '2.8*((x/300)*exp(1-x/300))^0.6', 0, 2);
model.func('pw1').setIndex('pieces', 300, 1, 0);
model.func('pw1').setIndex('pieces', 5000, 1, 1);
model.func('pw1').setIndex('pieces', '2.8*((x/300)*exp(1-x/300))^0.2', 1, 2);
model.func('pw1').set('argunit', 'eV');
model.func('pw1').set('fununit', '1');

model.geom('geom1').lengthUnit('mm');
model.geom('geom1').create('blk1', 'Block');
model.geom('geom1').feature('blk1').set('size', {'D' 'L' 'L'});
model.geom('geom1').runPre('fin');

model.variable.create('var2');
model.variable('var2').model('comp1');

model.geom('geom1').run;

% To import content from file, use:
% model.variable('var2').loadFile('FILENAME');
model.variable('var2').set('SEY_int', 'floor(pw1(cpt.Ep))', 'SEY integer');
model.variable('var2').set('SEY_frac', 'mod(pw1(cpt.Ep),1)', 'SEY remainder');
model.variable('var2').set('SEY_int_left', 'if(relLeft,SEY_int,0)', 'SEY integer left');
model.variable('var2').set('SEY_frac_left', 'if(relLeft,SEY_frac,0)', 'SEY remainder left');
model.variable('var2').set('SEY_int_right', 'if(relRight,SEY_int,0)', 'SEY integer right');
model.variable('var2').set('SEY_frac_right', 'if(relRight,SEY_frac,0)', 'SEY remainder right');
model.variable('var2').set('impacts_left', 'cpt.wall2.bacc1.rpb_ave', 'Impacts per unit area, left');
model.variable('var2').set('impacts_right', 'cpt.wall3.bacc1.rpb_ave', 'Impacts per unit area, right');
model.variable('var2').set('impacts_all', 'impacts_left+impacts_right', 'Impacts per unit area, total');
model.variable('var2').set('impacts_change', 'impacts_all-at(t-0.5/f0,impacts_all)', 'Electron impacts per half-cycle');

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

model.physics('es').create('gnd1', 'Ground', 2);
model.physics('es').feature('gnd1').selection.set([1]);
model.physics('es').create('pot1', 'ElectricPotential', 2);
model.physics('es').feature('pot1').selection.set([6]);
model.physics('es').feature('pot1').set('V0', 'V0*sin(2*pi*f0*t)');
model.physics('cpt').prop('ParticleReleaseSpecification').setIndex('ParticleReleaseSpecification', 'SpecifyReleaseTimes', 0);
model.physics('cpt').prop('MaximumSecondary').setIndex('MaximumSecondary', 1000, 0);
model.physics('cpt').prop('ReuseParticleDegreesOfFreedom').setIndex('ReuseParticleDegreesOfFreedom', 'AllDisappearedParticles', 0);
model.physics('cpt').feature('ef1').set('E_src', 'root.comp1.es.Ex');
model.physics('cpt').create('mf1', 'MagneticForce', 3);
model.physics('cpt').feature('mf1').selection.set([1]);
model.physics('cpt').feature('mf1').set('B', {'0' '0' 'B0'});
model.physics('cpt').create('relg1', 'ReleaseGrid', -1);
model.physics('cpt').feature('relg1').setIndex('x0', 'range(0.01,0.02,0.99)*D', 0);
model.physics('cpt').feature('relg1').setIndex('x0', 'L/2', 1);
model.physics('cpt').feature('relg1').setIndex('x0', 'L/2', 2);
model.physics('cpt').create('wall2', 'Wall', 2);
model.physics('cpt').feature('wall2').selection.set([1]);
model.physics('cpt').feature('wall2').set('WallCondition', 'Disappear');
model.physics('cpt').feature('wall2').create('sem1', 'SecondaryEmission', 2);
model.physics('cpt').feature('wall2').feature('sem1').set('Ns', 'SEY_int_left');
model.physics('cpt').feature('wall2').feature('sem1').set('InitialVelocity', 'Thermal');
model.physics('cpt').feature('wall2').feature('sem1').set('T', 'T0');
model.physics('cpt').feature('wall2').feature.duplicate('sem2', 'sem1');
model.physics('cpt').feature('wall2').feature('sem2').set('SecondaryEmissionCondition', 'Probability');
model.physics('cpt').feature('wall2').feature('sem2').set('gamma', 'SEY_frac_left');
model.physics('cpt').feature('wall2').feature('sem2').set('Ns', 1);
model.physics('cpt').feature('wall2').create('bacc1', 'BoundaryAccumulator', 2);
model.physics('cpt').feature('wall2').feature('bacc1').set('DependentVariableQuantity', 'surfacechargedensity');
model.physics('cpt').feature('wall2').feature('bacc1').set('R', 'e_const*n');
model.physics('cpt').feature.duplicate('wall3', 'wall2');
model.physics('cpt').feature('wall3').selection.set([6]);
model.physics('cpt').feature('wall3').feature('sem1').set('Ns', 'SEY_int_right');
model.physics('cpt').feature('wall3').feature('sem2').set('gamma', 'SEY_frac_right');
model.physics('cpt').create('pc1', 'PeriodicCondition', 2);
model.physics('cpt').feature('pc1').selection.set([3 4]);
model.physics('cpt').create('pc2', 'PeriodicCondition', 2);
model.physics('cpt').feature('pc2').selection.set([2 5]);

model.multiphysics('epfi1').set('n', 'n');

model.mesh('mesh1').create('map1', 'Map');
model.mesh('mesh1').feature('map1').selection.set([1]);
model.mesh('mesh1').feature('map1').create('dis1', 'Distribution');
model.mesh('mesh1').feature('map1').feature('dis1').selection.set([1 2 4 6]);
model.mesh('mesh1').feature('map1').feature('dis1').set('numelem', 1);
model.mesh('mesh1').create('swe1', 'Sweep');
model.mesh('mesh1').feature('swe1').create('dis1', 'Distribution');
model.mesh('mesh1').feature('swe1').feature('dis1').set('numelem', 100);
model.mesh('mesh1').run;

model.study('std1').feature('time').set('tlist', 'range(0,1/(100*f0),20/f0)');

model.sol.create('sol1');
model.sol('sol1').study('std1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'time');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').set('control', 'time');
model.sol('sol1').create('t1', 'Time');
model.sol('sol1').feature('t1').set('tlist', 'range(0,1/(100*f0),20/f0)');
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
model.sol('sol1').feature('t1').set('rhoinf', 0.75);
model.sol('sol1').feature('t1').set('control', 'time');
model.sol('sol1').feature('t1').create('se1', 'Segregated');
model.sol('sol1').feature('t1').feature('se1').feature.remove('ssDef');
model.sol('sol1').feature('t1').feature('se1').create('ss1', 'SegregatedStep');
model.sol('sol1').feature('t1').feature('se1').feature('ss1').set('segvar', {'comp1_qcpt'});
model.sol('sol1').feature('t1').create('i1', 'Iterative');
model.sol('sol1').feature('t1').feature('i1').set('linsolver', 'gmres');
model.sol('sol1').feature('t1').feature('i1').create('ja1', 'Jacobi');
model.sol('sol1').feature('t1').feature('se1').feature('ss1').set('linsolver', 'i1');
model.sol('sol1').feature('t1').feature('se1').feature('ss1').label('Charged Particle Tracing');
model.sol('sol1').feature('t1').feature('se1').create('ss2', 'SegregatedStep');
model.sol('sol1').feature('t1').feature('se1').feature('ss2').set('segvar', {'comp1_V'});
model.sol('sol1').feature('t1').create('i2', 'Iterative');
model.sol('sol1').feature('t1').feature('i2').set('linsolver', 'cg');
model.sol('sol1').feature('t1').feature('i2').create('mg1', 'Multigrid');
model.sol('sol1').feature('t1').feature('i2').feature('mg1').set('prefun', 'amg');
model.sol('sol1').feature('t1').feature('i2').feature('mg1').set('coarseningmethod', 'classic');
model.sol('sol1').feature('t1').feature('se1').feature('ss2').set('linsolver', 'i2');
model.sol('sol1').feature('t1').feature('se1').feature('ss2').label('Electrostatics');
model.sol('sol1').feature('t1').feature.remove('fcDef');
model.sol('sol1').attach('std1');
model.sol('sol1').feature('t1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('t1').feature('fc1').set('linsolver', 'dDef');
model.sol('sol1').runAll;

model.result.create('pg1', 'PlotGroup3D');
model.result('pg1').label('Electric Potential (es)');
model.result('pg1').set('frametype', 'spatial');
model.result('pg1').set('showlegendsmaxmin', true);
model.result('pg1').set('data', 'dset1');
model.result('pg1').setIndex('looplevel', 2001, 0);
model.result('pg1').set('defaultPlotID', 'InterfaceComponents/PlotDefaults/icom2/pdef1/pcond2/pcond1/pcond1/pg1');
model.result('pg1').feature.create('mslc1', 'Multislice');
model.result('pg1').feature('mslc1').set('showsolutionparams', 'on');
model.result('pg1').feature('mslc1').set('solutionparams', 'parent');
model.result('pg1').feature('mslc1').set('multiplanexmethod', 'coord');
model.result('pg1').feature('mslc1').set('xcoord', 'es.CPx');
model.result('pg1').feature('mslc1').set('multiplaneymethod', 'coord');
model.result('pg1').feature('mslc1').set('ycoord', 'es.CPy');
model.result('pg1').feature('mslc1').set('multiplanezmethod', 'coord');
model.result('pg1').feature('mslc1').set('zcoord', 'es.CPz');
model.result('pg1').feature('mslc1').set('colortable', 'Dipole');
model.result('pg1').feature('mslc1').set('showsolutionparams', 'on');
model.result('pg1').feature('mslc1').set('data', 'parent');
model.result('pg1').feature.create('strmsl1', 'StreamlineMultislice');
model.result('pg1').feature('strmsl1').set('showsolutionparams', 'on');
model.result('pg1').feature('strmsl1').set('solutionparams', 'parent');
model.result('pg1').feature('strmsl1').set('multiplanexmethod', 'coord');
model.result('pg1').feature('strmsl1').set('xcoord', 'es.CPx');
model.result('pg1').feature('strmsl1').set('multiplaneymethod', 'coord');
model.result('pg1').feature('strmsl1').set('ycoord', 'es.CPy');
model.result('pg1').feature('strmsl1').set('multiplanezmethod', 'coord');
model.result('pg1').feature('strmsl1').set('zcoord', 'es.CPz');
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
model.result('pg1').feature('strmsl1').feature('col1').set('colortable', 'DipoleDark');
model.result('pg1').feature('strmsl1').feature('col1').set('colorlegend', false);
model.result('pg1').feature('strmsl1').feature.create('filt1', 'Filter');
model.result('pg1').feature('strmsl1').feature('filt1').set('expr', '!isScalingSystemDomain');
model.result.create('pg2', 'PlotGroup3D');
model.result('pg2').label('Electric Field Norm (es)');
model.result('pg2').set('frametype', 'spatial');
model.result('pg2').set('showlegendsmaxmin', true);
model.result('pg2').set('data', 'dset1');
model.result('pg2').setIndex('looplevel', 2001, 0);
model.result('pg2').set('defaultPlotID', 'InterfaceComponents/PlotDefaults/icom3/pdef1/pcond2/pcond1/pg1');
model.result('pg2').feature.create('mslc1', 'Multislice');
model.result('pg2').feature('mslc1').set('showsolutionparams', 'on');
model.result('pg2').feature('mslc1').set('solutionparams', 'parent');
model.result('pg2').feature('mslc1').set('expr', 'es.normE');
model.result('pg2').feature('mslc1').set('multiplanexmethod', 'coord');
model.result('pg2').feature('mslc1').set('xcoord', 'es.CPx');
model.result('pg2').feature('mslc1').set('multiplaneymethod', 'coord');
model.result('pg2').feature('mslc1').set('ycoord', 'es.CPy');
model.result('pg2').feature('mslc1').set('multiplanezmethod', 'coord');
model.result('pg2').feature('mslc1').set('zcoord', 'es.CPz');
model.result('pg2').feature('mslc1').set('colortable', 'Prism');
model.result('pg2').feature('mslc1').set('colortabletrans', 'nonlinear');
model.result('pg2').feature('mslc1').set('colorcalibration', -0.8);
model.result('pg2').feature('mslc1').set('showsolutionparams', 'on');
model.result('pg2').feature('mslc1').set('data', 'parent');
model.result('pg2').feature.create('strmsl1', 'StreamlineMultislice');
model.result('pg2').feature('strmsl1').set('showsolutionparams', 'on');
model.result('pg2').feature('strmsl1').set('solutionparams', 'parent');
model.result('pg2').feature('strmsl1').set('multiplanexmethod', 'coord');
model.result('pg2').feature('strmsl1').set('xcoord', 'es.CPx');
model.result('pg2').feature('strmsl1').set('multiplaneymethod', 'coord');
model.result('pg2').feature('strmsl1').set('ycoord', 'es.CPy');
model.result('pg2').feature('strmsl1').set('multiplanezmethod', 'coord');
model.result('pg2').feature('strmsl1').set('zcoord', 'es.CPz');
model.result('pg2').feature('strmsl1').set('titletype', 'none');
model.result('pg2').feature('strmsl1').set('posmethod', 'uniform');
model.result('pg2').feature('strmsl1').set('udist', 0.02);
model.result('pg2').feature('strmsl1').set('maxlen', 0.4);
model.result('pg2').feature('strmsl1').set('maxtime', Inf);
model.result('pg2').feature('strmsl1').set('inheritcolor', false);
model.result('pg2').feature('strmsl1').set('showsolutionparams', 'on');
model.result('pg2').feature('strmsl1').set('maxtime', Inf);
model.result('pg2').feature('strmsl1').set('showsolutionparams', 'on');
model.result('pg2').feature('strmsl1').set('maxtime', Inf);
model.result('pg2').feature('strmsl1').set('showsolutionparams', 'on');
model.result('pg2').feature('strmsl1').set('maxtime', Inf);
model.result('pg2').feature('strmsl1').set('showsolutionparams', 'on');
model.result('pg2').feature('strmsl1').set('maxtime', Inf);
model.result('pg2').feature('strmsl1').set('data', 'parent');
model.result('pg2').feature('strmsl1').set('inheritplot', 'mslc1');
model.result('pg2').feature('strmsl1').feature.create('col1', 'Color');
model.result('pg2').feature('strmsl1').feature('col1').set('expr', 'es.normE');
model.result('pg2').feature('strmsl1').feature('col1').set('colortable', 'PrismDark');
model.result('pg2').feature('strmsl1').feature('col1').set('colorlegend', false);
model.result('pg2').feature('strmsl1').feature('col1').set('colortabletrans', 'nonlinear');
model.result('pg2').feature('strmsl1').feature('col1').set('colorcalibration', -0.8);
model.result('pg2').feature('strmsl1').feature.create('filt1', 'Filter');
model.result('pg2').feature('strmsl1').feature('filt1').set('expr', '!isScalingSystemDomain');
model.result.dataset.create('part1', 'Particle');
model.result.dataset('part1').set('solution', 'sol1');
model.result.dataset('part1').set('posdof', {'comp1.qx' 'comp1.qy' 'comp1.qz'});
model.result.dataset('part1').set('geom', 'geom1');
model.result.dataset('part1').set('pgeom', 'pgeom_cpt');
model.result.dataset('part1').set('pgeomspec', 'fromphysics');
model.result.dataset('part1').set('physicsinterface', 'cpt');
model.result.create('pg3', 'PlotGroup3D');
model.result('pg3').set('data', 'part1');
model.result('pg3').setIndex('looplevel', 2001, 0);
model.result('pg3').label('Particle Trajectories (cpt)');
model.result('pg3').create('traj1', 'ParticleTrajectories');
model.result('pg3').feature('traj1').set('pointtype', 'point');
model.result('pg3').feature('traj1').set('linetype', 'none');
model.result('pg3').feature('traj1').create('col1', 'Color');
model.result('pg3').feature('traj1').feature('col1').set('expr', 'cpt.V');
model.result.create('pg4', 'PlotGroup3D');
model.result('pg4').set('data', 'part1');
model.result('pg4').setIndex('looplevel', 2001, 0);
model.result('pg4').label('Accumulated Variable (cpt)');
model.result('pg4').create('surf1', 'Surface');
model.result('pg4').feature('surf1').set('expr', 'cpt.wall2.bacc1.rpb');
model.result('pg4').feature('surf1').set('resolution', 'norefine');
model.result('pg1').run;
model.result.create('pg5', 'PlotGroup1D');
model.result('pg5').run;
model.result('pg5').create('glob1', 'Global');
model.result('pg5').feature('glob1').set('markerpos', 'datapoints');
model.result('pg5').feature('glob1').set('linewidth', 'preference');
model.result('pg5').feature('glob1').set('expr', {'impacts_change'});
model.result('pg5').feature('glob1').set('descr', {'Electron impacts per half-cycle'});
model.result('pg5').feature('glob1').set('unit', {'C/m^2'});
model.result('pg5').feature('glob1').setIndex('unit', 'nC/cm^2', 0);
model.result('pg5').feature('glob1').set('xdata', 'expr');
model.result('pg5').feature('glob1').set('xdataexpr', 'tau');
model.result('pg5').feature('glob1').set('xdatadescr', 'Number of RF cycles');
model.result('pg5').run;
model.result.dataset.create('cpl1', 'CutPlane');
model.result.dataset('cpl1').set('quickplane', 'xy');
model.result.dataset('cpl1').set('quickz', 'L/2');
model.result.create('pg6', 'PlotGroup2D');
model.result('pg6').run;
model.result('pg6').set('data', 'cpl1');
model.result('pg6').create('surf1', 'Surface');
model.result('pg6').feature('surf1').set('expr', 'epfi1.rhos');
model.result('pg6').feature('surf1').set('descr', 'Space charge density');
model.result('pg6').feature('surf1').set('colortable', 'GrayScale');
model.result('pg6').run;
model.result.export.create('anim1', 'Animation');
model.result.export('anim1').set('target', 'player');
model.result.export('anim1').set('plotgroup', 'pg6');
model.result.export('anim1').run;
model.result.export('anim1').set('maxframes', 200);
model.result.export('anim1').run;

model.title('Multipactor Saturation');

model.description('Multipaction can occur when electrons are accelerated by a high frequency RF field in a cavity at near-vacuum conditions. Near certain resonant frequencies based on the size of the cavity, electrons can trigger a cascade of secondary electron emission by impacting the cavity walls at high speed. Eventually the number of electrons in the cavity reaches a state of dynamic equilibrium as the mutual electrostatic repulsion causes the band of electrons to broaden, so that the average secondary electron yield over all wall impacts approaches unity. The ensuing steady-state behavior is known as multipactor saturation.');

model.mesh.clearMeshes;

model.sol('sol1').clearSolutionData;

model.label('multipactor_saturation.mph');

model.modelNode.label('Components');

out = model;
