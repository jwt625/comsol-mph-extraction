function out = model
%
% newtonian_telescope.m
%
% Model exported on May 26 2025, 21:32 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/Ray_Optics_Module/Lenses_Cameras_and_Telescopes');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 3);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.physics.create('gop', 'GeometricalOptics', 'geom1');
model.physics('gop').model('comp1');

model.study.create('std1');
model.study('std1').create('rtrac', 'RayTracing');
model.study('std1').feature('rtrac').setSolveFor('/physics/gop', true);

model.param.label('Parameters 1: Telescope Geometry');
model.param.create('par2');
model.param('par2').label('Parameters 2: Wavelengths and Fields');

% To import content from file, use:
% model.param('par2').loadFile('FILENAME');
model.param('par2').set('lam', '550[nm]', 'Central wavelength');
model.param('par2').set('N_hex', '15', 'Number of hexapolar radial rings');
model.param('par2').set('theta_x1', '0.0[arcmin]', 'Field angle (x)');
model.param('par2').set('theta_y1', '0.0[arcmin]', 'Field angle (y)');
model.param('par2').set('theta_x2', '7.5[arcmin]', 'Field angle (x)');
model.param('par2').set('theta_y2', '0.0[arcmin]', 'Field angle (y)');
model.param('par2').set('theta_x3', '15.0[arcmin]', 'Field angle (x)');
model.param('par2').set('theta_y3', '0.0[arcmin]', 'Field angle (y)');
model.param('par2').set('vx1', 'sin(theta_x1)', 'Ray direction vector, x-component');
model.param('par2').set('vy1', 'sin(theta_y1)', 'Ray direction vector, y-component');
model.param('par2').set('vz1', '-sqrt(1-vx1^2-vy1^2)', 'Ray direction vector, z-component');
model.param('par2').set('dx1', '-f*vx1', 'Object plane x-coordinate');
model.param('par2').set('dy1', '-f*vy1', 'Object plane y-coordinate');
model.param('par2').set('dz1', '-f*vz1', 'Object plane z-coordinate (relative to primary vertex)');
model.param('par2').set('vx2', 'sin(theta_x2)', 'Ray direction vector, x-component');
model.param('par2').set('vy2', 'sin(theta_y2)', 'Ray direction vector, y-component');
model.param('par2').set('vz2', '-sqrt(1-vx2^2-vy2^2)', 'Ray direction vector, z-component');
model.param('par2').set('dx2', '-f*vx2', 'Object plane x-coordinate');
model.param('par2').set('dy2', '-f*vy2', 'Object plane y-coordinate');
model.param('par2').set('dz2', '-f*vz2', 'Object plane z-coordinate (relative to primary vertex)');
model.param('par2').set('vx3', 'sin(theta_x3)', 'Ray direction vector, x-component');
model.param('par2').set('vy3', 'sin(theta_y3)', 'Ray direction vector, y-component');
model.param('par2').set('vz3', '-sqrt(1-vx3^2-vy3^2)', 'Ray direction vector, z-component');
model.param('par2').set('dx3', '-f*vx3', 'Object plane x-coordinate');
model.param('par2').set('dy3', '-f*vy3', 'Object plane y-coordinate');
model.param('par2').set('dz3', '-f*vz3', 'Object plane z-coordinate (relative to primary vertex)');
model.param('par2').set('theta_Airy', '1.22*lam/d_pupil', 'Airy disc angular radius');
model.param('par2').set('r_Airy', 'f*theta_Airy', 'Airy disc radius');

model.geom('geom1').label('Newtonian Telescope');
model.geom('geom1').lengthUnit('mm');
model.geom('geom1').insertFile('newtonian_telescope_geom_sequence.mph', 'geom1');
model.geom('geom1').runPre('fin');

model.view('view1').camera.set('projection', 'orthographic');

model.geom('geom1').run;

model.physics('gop').prop('MaximumSecondary').setIndex('MaximumSecondary', 0, 0);
model.physics('gop').prop('CountReflections').setIndex('CountReflections', 1, 0);
model.physics('gop').feature('mp1').set('n_mat', 'userdef');
model.physics('gop').feature('op1').set('lambda0', 'lam');
model.physics('gop').create('relg1', 'ReleaseGrid', -1);
model.physics('gop').feature('relg1').set('GridType', 'Hexapolar');
model.physics('gop').feature('relg1').set('qcc', {'dx1' 'dy1' 'dz1'});
model.physics('gop').feature('relg1').set('rcc', {'nix' 'niy' 'niz'});
model.physics('gop').feature('relg1').set('Rc', 'd_pupil/2');
model.physics('gop').feature('relg1').setIndex('Ncr', 'N_hex', 0);
model.physics('gop').feature('relg1').set('L0', {'vx1' 'vy1' 'vz1'});
model.physics('gop').feature.duplicate('relg2', 'relg1');
model.physics('gop').feature('relg2').set('qcc', {'dx2' 'dy2' 'dz2'});
model.physics('gop').feature('relg2').set('L0', {'vx2' 'vy2' 'vz2'});
model.physics('gop').feature.duplicate('relg3', 'relg2');
model.physics('gop').feature('relg3').set('qcc', {'dx3' 'dy3' 'dz3'});
model.physics('gop').feature('relg3').set('L0', {'vx3' 'vy3' 'vz3'});
model.physics('gop').create('mir1', 'Mirror', 2);
model.physics('gop').feature('mir1').label('Primary Mirror');
model.physics('gop').feature('mir1').selection.named('geom1_pi1_cylsel1');
model.physics('gop').create('wall1', 'Wall', 2);
model.physics('gop').feature('wall1').label('Secondary Mirror');
model.physics('gop').feature('wall1').selection.named('geom1_pi2_cylsel1');
model.physics('gop').feature('wall1').set('WallCondition', 'SpecularReflection');
model.physics('gop').feature('wall1').set('PrimaryRayCondition', 'Expression');
model.physics('gop').feature('wall1').set('e', 'gop.Nrefl>0');
model.physics('gop').feature('wall1').set('Otherwise', 'Pass');
model.physics('gop').create('wall2', 'Wall', 2);
model.physics('gop').feature('wall2').label('Primary Obstructions');
model.physics('gop').feature('wall2').set('WallCondition', 'Disappear');
model.physics('gop').feature('wall2').selection.named('geom1_csel1_bnd');
model.physics('gop').create('wall3', 'Wall', 2);
model.physics('gop').feature('wall3').label('Secondary Obstructions');
model.physics('gop').feature('wall3').set('WallCondition', 'Disappear');
model.physics('gop').feature('wall3').selection.named('geom1_csel2_bnd');
model.physics('gop').create('wall4', 'Wall', 2);
model.physics('gop').feature('wall4').label('Image Plane');
model.physics('gop').feature('wall4').selection.named('geom1_csel3_bnd');

model.mesh('mesh1').run;

model.study('std1').feature('rtrac').set('timestepspec', 'specifylength');
model.study('std1').feature('rtrac').set('lunit', 'mm');
model.study('std1').feature('rtrac').set('llist', '0 2.25*f');

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
model.result('pg1').feature('rtrj1').create('col1', 'Color');
model.result('pg1').feature('rtrj1').feature('col1').set('expr', 't');
model.result('pg1').feature('rtrj1').create('filt1', 'RayTrajectoriesFilter');
model.result('pg1').run;
model.result('pg1').label('Ray Diagram');
model.result('pg1').set('showlegendsunit', true);
model.result('pg1').run;
model.result('pg1').feature('rtrj1').feature('col1').set('expr', 'at(''last'',gop.rrel)');
model.result('pg1').feature('rtrj1').feature('col1').set('unit', [native2unicode(hex2dec({'00' 'b5'}), 'unicode') 'm']);
model.result('pg1').feature('rtrj1').feature('col1').set('colortable', 'ThermalWave');
model.result('pg1').run;
model.result('pg1').feature('rtrj1').feature('filt1').set('type', 'logical');
model.result('pg1').feature('rtrj1').feature('filt1').set('logicalexpr', 'gop.Nrefl>0');
model.result('pg1').run;
model.result('pg1').feature.duplicate('rtrj2', 'rtrj1');
model.result('pg1').run;
model.result('pg1').feature('rtrj2').set('inheritplot', 'rtrj1');
model.result('pg1').run;
model.result('pg1').feature('rtrj2').feature('filt1').set('logicalexpr', 'gop.Nrefl==0');
model.result('pg1').run;
model.result('pg1').feature('rtrj2').create('tran1', 'Transparency');
model.result('pg1').run;
model.result('pg1').feature('rtrj2').feature('tran1').set('transparency', 0.8);
model.result('pg1').run;
model.result('pg1').create('surf1', 'Surface');
model.result('pg1').feature('surf1').set('coloring', 'uniform');
model.result('pg1').feature('surf1').set('color', 'gray');
model.result('pg1').run;
model.result.create('pg2', 'PlotGroup2D');
model.result('pg2').run;
model.result('pg2').label('Spot Diagram');
model.result('pg2').set('showlegendsunit', true);
model.result('pg2').create('spot1', 'SpotDiagram');
model.result('pg2').feature('spot1').set('circleactive', true);
model.result('pg2').feature('spot1').set('circleradiusexpr', 'r_Airy');
model.result('pg2').feature('spot1').create('col1', 'Color');
model.result('pg2').run;
model.result('pg2').feature('spot1').feature('col1').set('expr', 'at(0,gop.rrel)');
model.result('pg2').feature('spot1').feature('col1').set('colortable', 'Prism');
model.result('pg2').run;

model.title('Newtonian Telescope');

model.description(['This tutorial model shows how to trace unpolarized light rays through a Newtonian telescope. The incoming light is reflected off a paraboloidal mirror onto a flat elliptically shaped secondary mirror which folds the optical path by 90' native2unicode(hex2dec({'00' 'a0'}), 'unicode') 'degrees toward a flat focal plane. The telescope geometry is parameterized in terms of the primary mirror focal length and diameter, and the distance of the focal plane from the optical axis.']);

model.mesh.clearMeshes;

model.sol('sol1').clearSolutionData;

model.label('newtonian_telescope.mph');

model.modelNode.label('Components');

out = model;
