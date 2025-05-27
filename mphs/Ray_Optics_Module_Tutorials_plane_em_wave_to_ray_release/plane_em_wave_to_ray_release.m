function out = model
%
% plane_em_wave_to_ray_release.m
%
% Model exported on May 26 2025, 21:32 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/Ray_Optics_Module/Tutorials');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 3);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.physics.create('ewfd', 'ElectromagneticWavesFrequencyDomain', 'geom1');
model.physics('ewfd').model('comp1');

model.study.create('std1');
model.study('std1').create('wave', 'Wavelength');
model.study('std1').feature('wave').set('solnum', 'auto');
model.study('std1').feature('wave').set('notsolnum', 'auto');
model.study('std1').feature('wave').set('outputmap', {});
model.study('std1').feature('wave').set('ngenAUX', '1');
model.study('std1').feature('wave').set('goalngenAUX', '1');
model.study('std1').feature('wave').set('ngenAUX', '1');
model.study('std1').feature('wave').set('goalngenAUX', '1');
model.study('std1').feature('wave').setSolveFor('/physics/ewfd', true);

model.param.set('W', '1[um]');
model.param.descr('W', 'Waveguide width');
model.param.set('L', '5[um]');
model.param.descr('L', 'Waveguide length');
model.param.set('lam0', '1[um]');
model.param.descr('lam0', 'Wavelength');

model.geom('geom1').lengthUnit([native2unicode(hex2dec({'00' 'b5'}), 'unicode') 'm']);
model.geom('geom1').create('blk1', 'Block');
model.geom('geom1').feature('blk1').set('size', {'W' 'W' 'L'});
model.geom('geom1').runPre('fin');
model.geom('geom1').run;

model.physics('ewfd').create('port1', 'Port', 2);
model.physics('ewfd').feature('port1').selection.set([3]);
model.physics('ewfd').feature('port1').set('E0', [1 0 0]);
model.physics('ewfd').feature('port1').set('Pin', '1e-9[W]');
model.physics('ewfd').feature('port1').set('beta', 'ewfd.k0');
model.physics('ewfd').create('sctr1', 'Scattering', 2);
model.physics('ewfd').feature('sctr1').selection.set([4]);
model.physics('ewfd').create('pmc1', 'PerfectMagneticConductor', 2);
model.physics('ewfd').feature('pmc1').selection.set([2 5]);

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

model.study('std1').feature('wave').set('plist', 'lam0');

model.sol.create('sol1');
model.sol('sol1').study('std1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'wave');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').set('control', 'wave');
model.sol('sol1').create('s1', 'Stationary');
model.sol('sol1').feature('s1').set('stol', 0.001);
model.sol('sol1').feature('s1').create('p1', 'Parametric');
model.sol('sol1').feature('s1').feature.remove('pDef');
model.sol('sol1').feature('s1').feature('p1').set('pname', {'lambda0'});
model.sol('sol1').feature('s1').feature('p1').set('plistarr', {'lam0'});
model.sol('sol1').feature('s1').feature('p1').set('punit', {[native2unicode(hex2dec({'00' 'b5'}), 'unicode') 'm']});
model.sol('sol1').feature('s1').feature('p1').set('pcontinuationmode', 'no');
model.sol('sol1').feature('s1').feature('p1').set('preusesol', 'no');
model.sol('sol1').feature('s1').feature('p1').set('pdistrib', 'off');
model.sol('sol1').feature('s1').feature('p1').set('plot', 'off');
model.sol('sol1').feature('s1').feature('p1').set('plotgroup', 'Default');
model.sol('sol1').feature('s1').feature('p1').set('probesel', 'all');
model.sol('sol1').feature('s1').feature('p1').set('probes', {});
model.sol('sol1').feature('s1').feature('p1').set('control', 'wave');
model.sol('sol1').feature('s1').set('control', 'wave');
model.sol('sol1').feature('s1').feature('aDef').set('complexfun', true);
model.sol('sol1').feature('s1').feature('aDef').set('cachepattern', false);
model.sol('sol1').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('s1').create('i1', 'Iterative');
model.sol('sol1').feature('s1').feature('i1').set('linsolver', 'bicgstab');
model.sol('sol1').feature('s1').feature('i1').set('prefuntype', 'left');
model.sol('sol1').feature('s1').feature('i1').label('Suggested Iterative Solver (ewfd)');
model.sol('sol1').feature('s1').feature('i1').create('mg1', 'Multigrid');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('pr').create('sv1', 'SORVector');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('pr').feature('sv1').set('prefun', 'sorvec');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('pr').feature('sv1').set('iter', 2);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('pr').feature('sv1').set('relax', 1);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('pr').feature('sv1').set('sorvecdof', {'comp1_E'});
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('po').create('sv1', 'SORVector');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('po').feature('sv1').set('prefun', 'soruvec');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('po').feature('sv1').set('iter', 2);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('po').feature('sv1').set('relax', 1);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('po').feature('sv1').set('sorvecdof', {'comp1_E'});
model.sol('sol1').feature('s1').create('i2', 'Iterative');
model.sol('sol1').feature('s1').feature('i2').set('linsolver', 'fgmres');
model.sol('sol1').feature('s1').feature('i2').label('Suggested Iterative Solver (ewfd) 2');
model.sol('sol1').feature('s1').feature('i2').create('mg1', 'Multigrid');
model.sol('sol1').feature('s1').feature('i2').feature('mg1').feature('pr').create('sv1', 'SORVector');
model.sol('sol1').feature('s1').feature('i2').feature('mg1').feature('pr').feature('sv1').set('prefun', 'sorvec');
model.sol('sol1').feature('s1').feature('i2').feature('mg1').feature('pr').feature('sv1').set('iter', 2);
model.sol('sol1').feature('s1').feature('i2').feature('mg1').feature('pr').feature('sv1').set('relax', 1);
model.sol('sol1').feature('s1').feature('i2').feature('mg1').feature('pr').feature('sv1').set('sorvecdof', {'comp1_E'});
model.sol('sol1').feature('s1').feature('i2').feature('mg1').feature('po').create('sv1', 'SORVector');
model.sol('sol1').feature('s1').feature('i2').feature('mg1').feature('po').feature('sv1').set('prefun', 'soruvec');
model.sol('sol1').feature('s1').feature('i2').feature('mg1').feature('po').feature('sv1').set('iter', 2);
model.sol('sol1').feature('s1').feature('i2').feature('mg1').feature('po').feature('sv1').set('relax', 1);
model.sol('sol1').feature('s1').feature('i2').feature('mg1').feature('po').feature('sv1').set('sorvecdof', {'comp1_E'});
model.sol('sol1').feature('s1').feature('fc1').set('linsolver', 'i1');
model.sol('sol1').feature('s1').feature.remove('fcDef');
model.sol('sol1').attach('std1');
model.sol('sol1').runAll;

model.result.create('pg1', 'PlotGroup3D');
model.result('pg1').label('Electric Field (ewfd)');
model.result('pg1').set('frametype', 'spatial');
model.result('pg1').set('data', 'dset1');
model.result('pg1').setIndex('looplevel', 1, 0);
model.result('pg1').set('defaultPlotID', 'ElectromagneticWavesFrequencyDomain/phys1/pdef1/pcond1/pg1');
model.result('pg1').feature.create('mslc1', 'Multislice');
model.result('pg1').feature('mslc1').set('smooth', 'internal');
model.result('pg1').feature('mslc1').set('data', 'parent');
model.result.numerical.create('gev1', 'EvalGlobal');
model.result.numerical('gev1').label('Reflectance (ewfd)');
model.result.numerical('gev1').set('data', 'dset1');
model.result.numerical('gev1').set('expr', {'ewfd.Rport_1' 'ewfd.Rtotal'});
model.result.table.create('tbl1', 'Table');
model.result.numerical('gev1').set('table', 'tbl1');
model.result.numerical('gev1').run;
model.result.numerical('gev1').setResult;
model.result('pg1').run;
model.result('pg1').run;
model.result('pg1').feature('mslc1').set('expr', 'ewfd.Ex');
model.result('pg1').feature('mslc1').set('descr', 'Electric field, x-component');
model.result('pg1').run;

model.physics.create('gop', 'GeometricalOptics', 'geom1');
model.physics('gop').model('comp1');

model.study('std1').feature('wave').setSolveFor('/physics/gop', false);
model.study.create('std2');
model.study('std2').create('rtrac', 'RayTracing');
model.study('std2').feature('rtrac').setSolveFor('/physics/ewfd', false);
model.study('std2').feature('rtrac').setSolveFor('/physics/gop', true);

model.physics('gop').prop('MaximumSecondary').setIndex('MaximumSecondary', 0, 0);
model.physics('gop').prop('IntensityComputation').setIndex('IntensityComputation', 'ComputeIntensityAndPower', 0);
model.physics('gop').prop('ComputePhase').setIndex('ComputePhase', 1, 0);
model.physics('gop').create('rele1', 'ReleaseFromElectricField', 2);
model.physics('gop').feature('rele1').selection.set([4]);
model.physics('gop').feature('rele1').setIndex('Nr', 9, 0);
model.physics('gop').feature('rele1').set('E_src', 'root.comp1.ewfd.Ex');
model.physics('gop').feature('rele1').set('UseFrequencyCoupledPhysics', true);

model.study('std2').feature('rtrac').set('timestepspec', 'specifylength');
model.study('std2').feature('rtrac').set('lunit', [native2unicode(hex2dec({'00' 'b5'}), 'unicode') 'm']);
model.study('std2').feature('rtrac').set('llist', 'range(0,0.1,5)');
model.study('std2').feature('rtrac').set('usesol', true);
model.study('std2').feature('rtrac').set('notsolmethod', 'sol');
model.study('std2').feature('rtrac').set('notstudy', 'std1');

model.sol.create('sol2');
model.sol('sol2').study('std2');
model.sol('sol2').create('st1', 'StudyStep');
model.sol('sol2').feature('st1').set('study', 'std2');
model.sol('sol2').feature('st1').set('studystep', 'rtrac');
model.sol('sol2').create('v1', 'Variables');
model.sol('sol2').feature('v1').set('control', 'rtrac');
model.sol('sol2').create('t1', 'Time');
model.sol('sol2').feature('t1').set('tlist', 'range(0,0.01,1)');
model.sol('sol2').feature('t1').set('plot', 'off');
model.sol('sol2').feature('t1').set('plotgroup', 'pg1');
model.sol('sol2').feature('t1').set('plotfreq', 'tout');
model.sol('sol2').feature('t1').set('probesel', 'all');
model.sol('sol2').feature('t1').set('probes', {});
model.sol('sol2').feature('t1').set('probefreq', 'tsteps');
model.sol('sol2').feature('t1').set('rtol', 1.0E-5);
model.sol('sol2').feature('t1').set('atolglobalvaluemethod', 'factor');
model.sol('sol2').feature('t1').set('reacf', false);
model.sol('sol2').feature('t1').set('storeudot', false);
model.sol('sol2').feature('t1').set('tstepsgenalpha', 'strict');
model.sol('sol2').feature('t1').set('endtimeinterpolation', true);
model.sol('sol2').feature('t1').set('timemethod', 'genalpha');
model.sol('sol2').feature('t1').set('estrat', 'exclude');
model.sol('sol2').feature('t1').set('control', 'rtrac');
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

model.result.dataset.create('ray1', 'Ray');
model.result.dataset('ray1').set('solution', 'sol2');
model.result.dataset('ray1').set('posdof', {'comp1.qx' 'comp1.qy' 'comp1.qz'});
model.result.dataset('ray1').set('geom', 'geom1');
model.result.dataset('ray1').set('rgeom', 'pgeom_gop');
model.result.dataset('ray1').set('rgeomspec', 'fromphysics');
model.result.dataset('ray1').set('physicsinterface', 'gop');
model.result.create('pg2', 'PlotGroup3D');
model.result('pg2').set('data', 'ray1');
model.result('pg2').setIndex('looplevel', 51, 0);
model.result('pg2').label('Ray Trajectories (gop)');
model.result('pg2').create('rtrj1', 'RayTrajectories');
model.result('pg2').feature('rtrj1').set('linetype', 'line');
model.result('pg2').feature('rtrj1').create('col1', 'Color');
model.result('pg2').feature('rtrj1').feature('col1').set('expr', 'gop.I');
model.result('pg2').feature('rtrj1').create('filt1', 'RayTrajectoriesFilter');
model.result('pg2').run;
model.result('pg2').set('legendpos', 'bottom');
model.result('pg2').run;
model.result('pg2').feature('rtrj1').set('linetype', 'tube');
model.result('pg2').feature('rtrj1').set('pointtype', 'arrow');
model.result('pg2').feature('rtrj1').set('arrowtype', 'arrowhead');
model.result('pg2').feature('rtrj1').create('def1', 'Deform');
model.result('pg2').run;
model.result('pg2').feature('rtrj1').feature('def1').set('expr', {'gop.Ex' 'gop.Ey' 'gop.Ez'});
model.result('pg2').feature('rtrj1').feature('def1').set('descr', 'Electric field');
model.result('pg2').feature('rtrj1').feature('def1').set('scaleactive', true);
model.result('pg2').feature('rtrj1').feature('def1').set('scale', '5E-5');
model.result('pg2').run;
model.result('pg2').feature('rtrj1').feature('col1').set('expr', 'gop.Ex');
model.result('pg2').feature('rtrj1').feature('col1').set('descr', 'Electric field, x-component');
model.result('pg2').feature('rtrj1').feature('col1').set('colortable', 'WaveLight');
model.result('pg2').run;
model.result('pg2').create('slc1', 'Slice');
model.result('pg2').feature('slc1').set('data', 'dset1');
model.result('pg2').feature('slc1').set('expr', 'ewfd.Ex');
model.result('pg2').feature('slc1').set('descr', 'Electric field, x-component');
model.result('pg2').feature('slc1').set('quickplane', 'zx');
model.result('pg2').feature('slc1').set('quickynumber', 3);
model.result('pg2').feature('slc1').set('inheritplot', 'rtrj1');
model.result('pg2').run;
model.result.create('pg3', 'PlotGroup1D');
model.result('pg3').run;
model.result('pg3').set('xlabelactive', true);
model.result('pg3').set('xlabel', 'z-coordinate (\mu m)');
model.result('pg3').set('ylabelactive', true);
model.result('pg3').set('ylabel', 'E<sub>x</sub> (V/m)');
model.result('pg3').create('lngr1', 'LineGraph');
model.result('pg3').feature('lngr1').set('markerpos', 'datapoints');
model.result('pg3').feature('lngr1').set('linewidth', 'preference');
model.result('pg3').feature('lngr1').selection.set([6]);
model.result('pg3').feature('lngr1').set('expr', 'ewfd.Ex');
model.result('pg3').feature('lngr1').set('descr', 'Electric field, x-component');
model.result('pg3').feature('lngr1').set('xdata', 'expr');
model.result('pg3').feature('lngr1').set('xdataexpr', 'z');
model.result('pg3').run;
model.result('pg3').create('glob1', 'Global');
model.result('pg3').feature('glob1').set('markerpos', 'datapoints');
model.result('pg3').feature('glob1').set('linewidth', 'preference');
model.result('pg3').feature('glob1').set('data', 'ray1');
model.result('pg3').feature('glob1').setIndex('expr', 'gop.ave(gop.Ex)', 0);
model.result('pg3').feature('glob1').setIndex('unit', 'V/m', 0);
model.result('pg3').feature('glob1').setIndex('descr', 'Average over rays (gop)', 0);
model.result('pg3').feature('glob1').set('xdata', 'expr');
model.result('pg3').feature('glob1').set('xdataexpr', 'gop.gopaveop1(qz)');
model.result('pg3').feature('glob1').set('legend', false);
model.result('pg3').run;
model.result.numerical.create('gev2', 'EvalGlobal');
model.result.numerical('gev2').set('data', 'ray1');
model.result.numerical('gev2').setIndex('looplevelinput', 'last', 0);
model.result.numerical('gev2').setIndex('expr', 'gop.sum(gop.Q)', 0);
model.result.numerical('gev2').setIndex('unit', 'W', 0);
model.result.numerical('gev2').setIndex('descr', 'Sum over rays (gop)', 0);
model.result.table.create('tbl2', 'Table');
model.result.table('tbl2').comments('Global Evaluation 2');
model.result.numerical('gev2').set('table', 'tbl2');
model.result.numerical('gev2').setResult;

model.title('Ray Release Based on a Plane Electromagnetic Wave');

model.description('This tutorial shows how to set up a ray release based on the incident electric field at a boundary. First the Electromagnetic Waves, Frequency Domain interface is used to solve for the electric field of a plane wave. Then rays are released with initial intensity and polarization matching that of the electric field at the releasing boundary.');

model.mesh.clearMeshes;

model.sol('sol1').clearSolutionData;
model.sol('sol2').clearSolutionData;

model.label('plane_em_wave_to_ray_release.mph');

model.modelNode.label('Components');

out = model;
