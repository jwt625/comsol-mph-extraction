function out = model
%
% solar_dish_receiver.m
%
% Model exported on May 26 2025, 21:32 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/Ray_Optics_Module/Solar_Radiation');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 3);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.physics.create('gop', 'GeometricalOptics', 'geom1');
model.physics('gop').model('comp1');

model.study.create('std1');
model.study('std1').create('rtrac', 'RayTracing');
model.study('std1').feature('rtrac').setSolveFor('/physics/gop', true);

model.param.set('f', '3[m]');
model.param.descr('f', 'Focal length');
model.param.set('phi', '45[deg]');
model.param.descr('phi', 'Rim angle');
model.param.set('d', '4*f*(csc(phi)-cot(phi))');
model.param.descr('d', 'Dish diameter');
model.param.set('A', 'pi*d^2/4');
model.param.descr('A', 'Dish projected surface area');
model.param.set('psim', '4.65[mrad]');
model.param.descr('psim', 'Maximum solar disc angle');
model.param.set('sig', '1.75[mrad]');
model.param.descr('sig', 'Surface slope error');
model.param.set('I0', '1[kW/m^2]');
model.param.descr('I0', 'Solar irradiance');

model.geom('geom1').create('cyl1', 'Cylinder');
model.geom('geom1').feature('cyl1').set('r', '30[mm]');
model.geom('geom1').feature('cyl1').set('h', '100[mm]');
model.geom('geom1').runPre('fin');
model.geom.load({'part1'}, 'Ray_Optics_Module/3D/Mirrors/paraboloidal_reflector_shell_3d.mph', {'part2'});
model.geom('geom1').create('pi1', 'PartInstance');
model.geom('geom1').feature('pi1').set('selkeepnoncontr', false);
model.geom('geom1').feature('pi1').set('part', 'part1');
model.geom('geom1').feature('pi1').setEntry('inputexpr', 'phi', 'phi');
model.geom('geom1').feature('pi1').setEntry('inputexpr', 'd2', 0);
model.geom('geom1').feature('pi1').setEntry('inputexpr', 'F', '3[m]');
model.geom('geom1').feature('pi1').setEntry('inputexpr', 'nix', 0);
model.geom('geom1').feature('pi1').setEntry('inputexpr', 'niz', -1);
model.geom('geom1').feature('pi1').set('displ', {'0' '0' '-f'});
model.geom('geom1').feature('pi1').setEntry('selkeepbnd', 'pi1_unisel1', true);

model.cpl.create('intop1', 'Integration', 'geom1');

model.geom('geom1').run;

model.cpl('intop1').set('axisym', true);
model.cpl('intop1').selection.geom('geom1', 2);
model.cpl('intop1').selection.named('geom1_pi1_unisel1');

model.func.create('int1', 'Interpolation');
model.func('int1').model('comp1');
model.func('int1').set('source', 'file');
model.func('int1').set('filename', 'solar_dish_receiver_reference.txt');
model.func('int1').importData;
model.func('int1').setIndex('argunit', 'mm', 0);
model.func('int1').setIndex('fununit', 'W/mm^2', 0);

model.selection.create('sel1', 'Explicit');
model.selection('sel1').model('comp1');
model.selection('sel1').label('Focal Plane');
model.selection('sel1').geom(2);
model.selection('sel1').set([5]);

model.variable.create('var1');
model.variable('var1').model('comp1');

% To import content from file, use:
% model.variable('var1').loadFile('FILENAME');
model.variable('var1').set('r', 'sqrt(x^2+y^2)', 'Radial coordinate in the xy-plane');
model.variable('var1').set('theta', 'atan2(y,x)', 'Azimuthal angle in the xy-plane');
model.variable('var1').set('dx', 'x-dest(x)', 'Displacement from destination to source, x-coordinate');
model.variable('var1').set('dy', 'y-dest(y)', 'Displacement from destination to source, y-coordinate');
model.variable('var1').set('dz', 'z-dest(z)', 'Displacement from destination to source, z-coordinate');
model.variable('var1').set('dxn', 'sqrt(dx^2+dy^2+dz^2)', 'Distance from destination to source');
model.variable('var1').set('dxcn', 'sqrt(x^2+y^2+z^2)', 'Distance from receiver center to source');
model.variable('var1').set('delta', 'acos((dx*x+dy*y+dz*z)/(dxn*dxcn))', 'Solar angle of incoming rays');
model.variable('var1').set('fd', '1000[W/m^2]/(pi*sin(4.65[mrad])^2)*(delta<4.65[mrad])', 'Radiant intensity');
model.variable('var1').set('theta1', 'acos((dx*nx+dy*ny+dz*nz)/dxn)', 'Angle between reflected ray and normal, dish');
model.variable('var1').set('theta2', 'acos((dx*dest(nx)+dy*dest(ny)+dz*dest(nz))/dxn)', 'Angle between reflected ray and normal, target');
model.variable('var1').set('cr', 'intop1(fd*cos(theta1)*cos(theta2)/dxn^2)/1[kW/m^2]', 'Idealized concentration ratio, Jeter');

model.cpl.create('genproj1', 'GeneralProjection', 'geom1');
model.cpl('genproj1').selection.geom('geom1', 2);
model.cpl('genproj1').selection.named('sel1');
model.cpl('genproj1').set('srcmap', {'r' 'theta' 'z'});
model.cpl('genproj1').set('dstmap', {'r' 'y'});

model.physics('gop').selection.set([]);
model.physics('gop').prop('IntensityComputation').setIndex('IntensityComputation', 'ComputePower', 0);
model.physics('gop').prop('MaximumSecondary').setIndex('MaximumSecondary', 0, 0);
model.physics('gop').create('ill1', 'IlluminatedSurface', 2);
model.physics('gop').feature('ill1').label('Ideal Illuminated Surface');
model.physics('gop').feature('ill1').selection.named('geom1_pi1_unisel1');
model.physics('gop').feature('ill1').set('InitialPosition', 'Density');
model.physics('gop').feature('ill1').setIndex('Nr', 100000, 0);
model.physics('gop').feature('ill1').set('Li', [0 0 -1]);
model.physics('gop').feature('ill1').set('FiniteSource', 'SampleFromDistribution');
model.physics('gop').feature('ill1').set('Psrc', 'A*I0');
model.physics('gop').feature('ill1').set('psim', 'psim');
model.physics('gop').create('ill2', 'IlluminatedSurface', 2);
model.physics('gop').feature('ill2').label('Real Illuminated Surface');
model.physics('gop').feature('ill2').selection.named('geom1_pi1_unisel1');
model.physics('gop').feature('ill2').set('InitialPosition', 'Density');
model.physics('gop').feature('ill2').setIndex('Nr', 100000, 0);
model.physics('gop').feature('ill2').set('Li', [0 0 -1]);
model.physics('gop').feature('ill2').set('alpha', 0.1);
model.physics('gop').feature('ill2').set('FiniteSource', 'SampleFromDistribution');
model.physics('gop').feature('ill2').set('psim', 'psim');
model.physics('gop').feature('ill2').set('LimbDarkeningModel', 'EmpiricalPowerLaw');
model.physics('gop').feature('ill2').set('IncludeSurfaceRoughness', true);
model.physics('gop').feature('ill2').set('sigmaphi', 'sig');
model.physics('gop').feature('ill2').set('Psrc', 'A*I0');
model.physics('gop').feature('ill2').set('InitialPolarizationType', 'UnPolarized');
model.physics('gop').create('wall1', 'Wall', 2);
model.physics('gop').feature('wall1').label('Focal Plane');
model.physics('gop').feature('wall1').selection.named('sel1');
model.physics('gop').feature('wall1').create('bsrc1', 'DepositedRayPowerBoundary', 2);

model.mesh('mesh1').autoMeshSize(1);
model.mesh('mesh1').automatic(false);
model.mesh('mesh1').feature('ftri1').create('size1', 'Size');
model.mesh('mesh1').feature('ftri1').feature('size1').selection.set([5]);
model.mesh('mesh1').feature('ftri1').feature('size1').set('custom', true);
model.mesh('mesh1').feature('ftri1').feature('size1').set('hmaxactive', true);
model.mesh('mesh1').feature('ftri1').feature('size1').set('hmax', '5E-4');
model.mesh('mesh1').feature('ftri1').feature('size1').set('hminactive', true);
model.mesh('mesh1').feature('ftri1').feature('size1').set('hmin', '2E-4');
model.mesh('mesh1').run;

model.study('std1').feature('rtrac').set('timestepspec', 'specifylength');
model.study('std1').feature('rtrac').set('llist', '0 4');
model.study('std1').feature('rtrac').set('useadvanceddisable', true);
model.study('std1').feature('rtrac').set('disabledphysics', {'gop/ill2'});

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
model.sol('sol1').feature('t1').set('tstepsgenalpha', 'manual');
model.sol('sol1').feature('t1').set('timestepgenalpha', '4[m]/c_const');
model.sol('sol1').runAll;

model.result.dataset.create('ray1', 'Ray');
model.result.dataset('ray1').set('solution', 'sol1');
model.result.dataset('ray1').set('posdof', {'comp1.qx' 'comp1.qy' 'comp1.qz'});
model.result.dataset('ray1').set('geom', 'geom1');
model.result.dataset('ray1').set('rgeom', 'pgeom_gop');
model.result.dataset('ray1').set('rgeomspec', 'fromphysics');
model.result.dataset('ray1').set('physicsinterface', 'gop');
model.result.create('pg1', 'PlotGroup3D');
model.result('pg1').set('data', 'ray1');
model.result('pg1').setIndex('looplevel', 2, 0);
model.result('pg1').label('Ray Trajectories (gop)');
model.result('pg1').create('rtrj1', 'RayTrajectories');
model.result('pg1').feature('rtrj1').set('linetype', 'line');
model.result('pg1').feature('rtrj1').set('extrasteps', 'none');
model.result('pg1').feature('rtrj1').create('col1', 'Color');
model.result('pg1').feature('rtrj1').feature('col1').set('expr', 't');
model.result('pg1').feature('rtrj1').create('filt1', 'RayTrajectoriesFilter');
model.result('pg1').run;
model.result('pg1').label('Ray Trajectories, Ideal Reflector');
model.result('pg1').set('titletype', 'manual');
model.result('pg1').set('title', 'Ray Trajectories, Ideal Reflector');
model.result('pg1').run;
model.result('pg1').feature('rtrj1').feature('col1').set('expr', 'gop.Q');
model.result('pg1').feature('rtrj1').feature('col1').set('descr', 'Ray power');
model.result('pg1').run;
model.result('pg1').run;
model.result.dataset.create('surf1', 'Surface');
model.result.dataset('surf1').set('param', 'xy');
model.result.dataset('surf1').selection.named('sel1');
model.result.create('pg2', 'PlotGroup2D');
model.result('pg2').run;
model.result('pg2').label('Deposited Power, Ideal Reflector');
model.result('pg2').set('titletype', 'manual');
model.result('pg2').set('title', 'Deposited Power, Ideal Reflector');
model.result('pg2').set('data', 'surf1');
model.result('pg2').set('showlegendsunit', true);
model.result('pg2').create('surf1', 'Surface');
model.result('pg2').feature('surf1').set('expr', 'gop.wall1.bsrc1.Qp');
model.result('pg2').feature('surf1').set('descr', 'Boundary heat source');
model.result('pg2').feature('surf1').set('unit', 'W/mm^2');
model.result('pg2').feature('surf1').set('colortable', 'GrayBody');
model.result('pg2').feature('surf1').set('resolution', 'norefine');
model.result('pg2').run;
model.result.dataset.create('cln1', 'CutLine3D');
model.result.dataset('cln1').setIndex('genpoints', '1E-4', 0, 0);
model.result.dataset('cln1').setIndex('genpoints', '0.03-1E-4', 1, 0);
model.result.dataset('cln1').set('snapping', 'boundary');
model.result.create('pg3', 'PlotGroup1D');
model.result('pg3').run;
model.result('pg3').label('Concentration Ratios, Ideal Reflector');
model.result('pg3').set('titletype', 'manual');
model.result('pg3').set('title', 'Concentration Ratios, Ideal Reflector');
model.result('pg3').set('data', 'cln1');
model.result('pg3').setIndex('looplevelinput', 'last', 0);
model.result('pg3').create('lngr1', 'LineGraph');
model.result('pg3').feature('lngr1').set('markerpos', 'datapoints');
model.result('pg3').feature('lngr1').set('linewidth', 'preference');
model.result('pg3').feature('lngr1').set('expr', 'genproj1(gop.wall1.bsrc1.Qp)/genproj1(I0)');
model.result('pg3').feature('lngr1').set('resolution', 'norefine');
model.result('pg3').feature('lngr1').set('xdata', 'expr');
model.result('pg3').feature('lngr1').set('xdataexpr', 'r');
model.result('pg3').feature('lngr1').set('legend', true);
model.result('pg3').feature('lngr1').set('legendmethod', 'manual');
model.result('pg3').feature('lngr1').setIndex('legends', 'Ray Tracing', 0);
model.result('pg3').run;
model.result('pg3').feature.duplicate('lngr2', 'lngr1');
model.result('pg3').run;
model.result('pg3').feature('lngr2').set('expr', 'cr');
model.result('pg3').feature('lngr2').set('titletype', 'none');
model.result('pg3').feature('lngr2').setIndex('legends', 'Jeter', 0);
model.result('pg3').run;

model.study.create('std2');
model.study('std2').create('rtrac', 'RayTracing');
model.study('std2').feature('rtrac').setSolveFor('/physics/gop', true);
model.study('std2').feature('rtrac').set('timestepspec', 'specifylength');
model.study('std2').feature('rtrac').set('llist', '0 4');
model.study('std2').feature('rtrac').set('useadvanceddisable', true);
model.study('std2').feature('rtrac').set('disabledphysics', {'gop/ill1'});

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
model.sol('sol2').feature('t1').set('tstepsgenalpha', 'manual');
model.sol('sol2').feature('t1').set('timestepgenalpha', '4[m]/c_const');
model.sol('sol2').runAll;

model.result.dataset.create('ray2', 'Ray');
model.result.dataset('ray2').set('solution', 'sol2');
model.result.dataset('ray2').set('posdof', {'comp1.qx' 'comp1.qy' 'comp1.qz'});
model.result.dataset('ray2').set('geom', 'geom1');
model.result.dataset('ray2').set('rgeom', 'pgeom_gop');
model.result.dataset('ray2').set('rgeomspec', 'fromphysics');
model.result.dataset('ray2').set('physicsinterface', 'gop');
model.result.create('pg4', 'PlotGroup3D');
model.result('pg4').set('data', 'ray2');
model.result('pg4').setIndex('looplevel', 2, 0);
model.result('pg4').label('Ray Trajectories (gop)');
model.result('pg4').create('rtrj1', 'RayTrajectories');
model.result('pg4').feature('rtrj1').set('linetype', 'line');
model.result('pg4').feature('rtrj1').set('extrasteps', 'none');
model.result('pg4').feature('rtrj1').create('col1', 'Color');
model.result('pg4').feature('rtrj1').feature('col1').set('expr', 't');
model.result('pg4').feature('rtrj1').create('filt1', 'RayTrajectoriesFilter');
model.result('pg4').run;
model.result('pg4').label('Ray Trajectories, Real Reflector');
model.result('pg4').set('titletype', 'manual');
model.result('pg4').set('title', 'Ray Trajectories, Real Reflector');
model.result('pg4').run;
model.result('pg4').feature('rtrj1').feature('col1').set('expr', 'gop.Q');
model.result('pg4').run;
model.result('pg4').run;
model.result.dataset.duplicate('surf2', 'surf1');
model.result.dataset('surf2').set('data', 'dset2');
model.result.dataset.duplicate('cln2', 'cln1');
model.result.dataset('cln2').set('data', 'dset2');
model.result('pg2').run;
model.result.duplicate('pg5', 'pg2');
model.result('pg5').run;
model.result('pg5').label('Deposited Power, Real Reflector');
model.result('pg5').set('title', 'Deposited Power, Real Reflector');
model.result('pg5').set('data', 'surf2');
model.result('pg5').run;
model.result('pg3').run;
model.result.duplicate('pg6', 'pg3');
model.result('pg6').run;
model.result('pg6').label('Concentration Ratios, Real Reflector');
model.result('pg6').set('title', 'Concentration Ratios, Real Reflector');
model.result('pg6').set('data', 'cln2');
model.result('pg6').run;
model.result('pg6').feature('lngr1').setIndex('legends', 'Ray Tracing', 0);
model.result('pg6').run;
model.result('pg6').feature('lngr2').set('expr', 'int1(r)/I0');
model.result('pg6').feature('lngr2').setIndex('legends', 'Shuai', 0);
model.result('pg6').run;
model.result('pg2').run;
model.result.duplicate('pg7', 'pg2');
model.result('pg7').run;
model.result('pg7').label('Deposited Power, Real and Ideal Reflectors');
model.result('pg7').set('title', 'Deposited Power, Real and Ideal Reflectors');
model.result('pg5').run;
model.result('pg7').run;
model.result('pg7').feature.copy('surf2', 'pg5/surf1');
model.result('pg7').run;
model.result('pg7').feature('surf2').set('data', 'surf2');
model.result('pg7').feature('surf2').set('inheritplot', 'surf1');
model.result('pg7').feature('surf2').create('trn1', 'Translation');
model.result('pg7').run;
model.result('pg7').feature('surf2').feature('trn1').set('trans', {'0.07[m]' '0'});
model.result('pg7').run;
model.result('pg7').run;
model.result('pg7').create('ann1', 'Annotation');
model.result('pg7').feature('ann1').set('text', 'Ideal Reflector');
model.result('pg7').feature('ann1').set('posxexpr', -0.015);
model.result('pg7').feature('ann1').set('posyexpr', 0.038);
model.result('pg7').feature('ann1').set('showpoint', false);
model.result('pg7').feature('ann1').set('showframe', true);
model.result('pg7').run;
model.result('pg7').create('ann2', 'Annotation');
model.result('pg7').feature('ann2').set('text', 'Real Reflector');
model.result('pg7').feature('ann2').set('posxexpr', 0.055);
model.result('pg7').feature('ann2').set('posyexpr', 0.038);
model.result('pg7').feature('ann2').set('showpoint', false);
model.result('pg7').feature('ann2').set('showframe', true);
model.result('pg7').run;

model.title('Solar Dish Receiver');

model.description('A paraboloidal dish can concentrate solar energy onto a target (receiver), resulting in very high local heat fluxes. This can be used to generate steam, which can be used to power a generator, or hydrogen, which can be used directly as a fuel source. In this example, the heat flux arriving on the receiver as a function of radial position is computed and compared with published values. Corrections due to the finite size of the sun, limb darkening, and surface roughness on the surface of the dish are considered.');

model.mesh.clearMeshes;

model.sol('sol1').clearSolutionData;
model.sol('sol2').clearSolutionData;

model.label('solar_dish_receiver.mph');

model.modelNode.label('Components');

out = model;
