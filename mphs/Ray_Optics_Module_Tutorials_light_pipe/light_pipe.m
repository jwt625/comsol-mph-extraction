function out = model
%
% light_pipe.m
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

model.physics.create('gop', 'GeometricalOptics', 'geom1');
model.physics('gop').model('comp1');

model.study.create('std1');
model.study('std1').create('rtrac', 'RayTracing');
model.study('std1').feature('rtrac').setSolveFor('/physics/gop', true);

model.geom('geom1').insertFile('light_pipe_geom_sequence.mph', 'geom1');
model.geom('geom1').run('fin');

model.material.create('mat1', 'Common', 'comp1');
model.material('mat1').propertyGroup.create('DispersionModelSellmeierStandard', 'Sellmeier');
model.material('mat1').propertyGroup.create('RefractiveIndex', 'Refractive index');
model.material('mat1').label('(C5H8O2)n (Poly(methyl methacrylate), PMMA) (Sultanova et al. 2009: n 0.437-1.052 um)');
model.material('mat1').propertyGroup('DispersionModelSellmeierStandard').set('ODsma', {'1.1819' '0' '0' '0.011313' '0' '0'});
model.material('mat1').propertyGroup('DispersionModelSellmeierStandard').set('Trefsma', '22[degC]');
model.material('mat1').propertyGroup('DispersionModelSellmeierStandard').set('Prefsma', '0');
model.material('mat1').propertyGroup('DispersionModelSellmeierStandard').addInput('frequency');
model.material('mat1').propertyGroup('RefractiveIndex').addInput('frequency');

model.physics('gop').prop('IntensityComputation').setIndex('IntensityComputation', 'ComputeIntensityAndPower', 0);
model.physics('gop').prop('MaximumSecondary').setIndex('MaximumSecondary', 1000, 0);
model.physics('gop').create('relg1', 'ReleaseGrid', -1);
model.physics('gop').feature('relg1').set('RayDirectionVector', 'Conical');
model.physics('gop').feature('relg1').setIndex('Nw', 2000, 0);
model.physics('gop').feature('relg1').set('cax', [0 0 1]);
model.physics('gop').feature('relg1').set('alphac', 'pi/12');
model.physics('gop').create('wall1', 'Wall', 2);
model.physics('gop').feature('wall1').selection.set([22]);
model.physics('gop').feature('wall1').create('bsrc1', 'DepositedRayPowerBoundary', 2);

model.mesh('mesh1').autoMeshSize(3);
model.mesh('mesh1').automatic(false);
model.mesh('mesh1').create('size1', 'Size');
model.mesh('mesh1').feature.move('size1', 1);
model.mesh('mesh1').feature('size1').selection.geom('geom1', 2);
model.mesh('mesh1').feature('size1').selection.set([22]);
model.mesh('mesh1').feature('size1').set('custom', true);
model.mesh('mesh1').feature('size1').set('hminactive', true);
model.mesh('mesh1').feature('size1').set('hmin', 0.1);
model.mesh('mesh1').feature('size1').set('hcurveactive', true);
model.mesh('mesh1').feature('size1').set('hcurve', 0.1);

model.study('std1').create('param', 'Parametric');
model.study('std1').feature('param').setIndex('pname', 'rpipe', 0);
model.study('std1').feature('param').setIndex('plistarr', '', 0);
model.study('std1').feature('param').setIndex('punit', 'm', 0);
model.study('std1').feature('param').setIndex('pname', 'rpipe', 0);
model.study('std1').feature('param').setIndex('plistarr', '', 0);
model.study('std1').feature('param').setIndex('punit', 'm', 0);
model.study('std1').feature('param').setIndex('pname', 'rb2', 0);
model.study('std1').feature('param').setIndex('punit', 'mm', 0);
model.study('std1').feature('param').setIndex('plistarr', 'range(5,2.5,20)', 0);
model.study('std1').feature('rtrac').set('timestepspec', 'specifylength');
model.study('std1').feature('rtrac').set('lunit', 'mm');
model.study('std1').feature('rtrac').set('llist', 'range(0,15,150)');
model.study('std1').feature('rtrac').set('charvel', 'c_const/1.5');

model.sol.create('sol1');
model.sol('sol1').study('std1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'rtrac');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').set('control', 'rtrac');
model.sol('sol1').create('t1', 'Time');
model.sol('sol1').feature('t1').set('tlist', 'range(0,0.01,1)');
model.sol('sol1').feature('t1').set('plot', 'off');
model.sol('sol1').feature('t1').set('plotgroup', 'Default');
model.sol('sol1').feature('t1').set('plotfreq', 'tout');
model.sol('sol1').feature('t1').set('probesel', 'all');
model.sol('sol1').feature('t1').set('probes', {});
model.sol('sol1').feature('t1').set('probefreq', 'tsteps');
model.sol('sol1').feature('t1').set('rtol', 1.0E-5);
model.sol('sol1').feature('t1').set('atolglobalvaluemethod', 'factor');
model.sol('sol1').feature('t1').set('reacf', false);
model.sol('sol1').feature('t1').set('storeudot', false);
model.sol('sol1').feature('t1').set('tstepsgenalpha', 'strict');
model.sol('sol1').feature('t1').set('endtimeinterpolation', true);
model.sol('sol1').feature('t1').set('timemethod', 'genalpha');
model.sol('sol1').feature('t1').set('estrat', 'exclude');
model.sol('sol1').feature('t1').set('control', 'rtrac');
model.sol('sol1').feature('t1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('t1').feature('fc1').set('ntolfact', 0.1);
model.sol('sol1').feature('t1').create('i1', 'Iterative');
model.sol('sol1').feature('t1').feature('i1').set('linsolver', 'gmres');
model.sol('sol1').feature('t1').feature('i1').create('ja1', 'Jacobi');
model.sol('sol1').feature('t1').feature('fc1').set('linsolver', 'i1');
model.sol('sol1').feature('t1').feature('fc1').set('ntolfact', 0.1);
model.sol('sol1').feature('t1').feature.remove('fcDef');
model.sol('sol1').attach('std1');

model.batch.create('p1', 'Parametric');
model.batch('p1').study('std1');
model.batch('p1').create('so1', 'Solutionseq');
model.batch('p1').feature('so1').set('seq', 'sol1');
model.batch('p1').feature('so1').set('store', 'on');
model.batch('p1').feature('so1').set('clear', 'on');
model.batch('p1').feature('so1').set('psol', 'none');
model.batch('p1').set('pname', {'rb2'});
model.batch('p1').set('plistarr', {'range(5,2.5,20)'});
model.batch('p1').set('sweeptype', 'sparse');
model.batch('p1').set('probesel', 'all');
model.batch('p1').set('probes', {});
model.batch('p1').set('plot', 'off');
model.batch('p1').set('err', 'on');
model.batch('p1').attach('std1');
model.batch('p1').set('control', 'param');

model.sol.create('sol2');
model.sol('sol2').study('std1');
model.sol('sol2').label('Parametric Solutions 1');

model.batch('p1').feature('so1').set('psol', 'sol2');
model.batch('p1').run('compute');

model.result.dataset.create('ray1', 'Ray');
model.result.dataset('ray1').set('solution', 'sol2');
model.result.dataset('ray1').set('posdof', {'comp1.qx' 'comp1.qy' 'comp1.qz'});
model.result.dataset('ray1').set('geom', 'geom1');
model.result.dataset('ray1').set('rgeom', 'pgeom_gop');
model.result.dataset('ray1').set('rgeomspec', 'fromphysics');
model.result.dataset('ray1').set('physicsinterface', 'gop');
model.result.create('pg1', 'PlotGroup3D');
model.result('pg1').set('data', 'ray1');
model.result('pg1').setIndex('looplevel', 11, 0);
model.result('pg1').setIndex('looplevel', 7, 1);
model.result('pg1').label('Ray Trajectories (gop)');
model.result('pg1').create('rtrj1', 'RayTrajectories');
model.result('pg1').feature('rtrj1').set('linetype', 'line');
model.result('pg1').feature('rtrj1').create('col1', 'Color');
model.result('pg1').feature('rtrj1').feature('col1').set('expr', 'gop.I');
model.result('pg1').feature('rtrj1').create('filt1', 'RayTrajectoriesFilter');
model.result('pg1').run;
model.result('pg1').run;
model.result('pg1').run;
model.result('pg1').feature('rtrj1').feature('col1').set('expr', 'gop.Q/1[W]*2000');
model.result('pg1').run;
model.result('pg1').run;
model.result('pg1').setIndex('looplevel', 1, 1);
model.result('pg1').run;
model.result.create('pg2', 'PlotGroup1D');
model.result('pg2').run;
model.result('pg2').label('Transmittance');
model.result('pg2').set('data', 'dset2');
model.result('pg2').setIndex('looplevelinput', 'last', 0);
model.result('pg2').set('xlabelactive', true);
model.result('pg2').set('xlabel', 'Radius of curvature, bend 2');
model.result('pg2').create('glob1', 'Global');
model.result('pg2').feature('glob1').set('markerpos', 'datapoints');
model.result('pg2').feature('glob1').set('linewidth', 'preference');
model.result('pg2').feature('glob1').setIndex('expr', 'gop.wall1.bsrc1.Qp_int/(1[W])', 0);
model.result('pg2').feature('glob1').setIndex('unit', 1, 0);
model.result('pg2').feature('glob1').setIndex('descr', 'Transmittance', 0);
model.result('pg2').feature('glob1').set('xdatasolnumtype', 'outer');
model.result('pg2').feature('glob1').set('legend', false);
model.result('pg2').run;

model.title('Transparent Light Pipe');

model.description('Light pipes are structures that can be used to transport light between different locations. In general, they can be divided into two major groups: tubes lined with a reflective coating and transparent solids that contain light via total internal reflection. In this example, light is transported through a bent light pipe by total internal reflection. The effect of the pipe shape on the transmittance is investigated.');

model.mesh.clearMeshes;

model.sol('sol1').clearSolutionData;
model.sol('sol2').clearSolutionData;
model.sol('sol3').clearSolutionData;
model.sol('sol4').clearSolutionData;
model.sol('sol5').clearSolutionData;
model.sol('sol6').clearSolutionData;
model.sol('sol7').clearSolutionData;
model.sol('sol8').clearSolutionData;
model.sol('sol9').clearSolutionData;

model.label('light_pipe.mph');

model.modelNode.label('Components');

out = model;
