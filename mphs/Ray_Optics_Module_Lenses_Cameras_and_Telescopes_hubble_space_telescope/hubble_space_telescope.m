function out = model
%
% hubble_space_telescope.m
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

% To import content from file, use:
% model.param.loadFile('FILENAME');
model.param.set('nix', '0.0', 'Global optical axis, x-component');
model.param.set('niy', '0.0', 'Global optical axis, y-component');
model.param.set('niz', '-1.0', 'Global optical axis, z-component');
model.param.set('lam_vac', '550[nm]', 'Vacuum wavelength');
model.param.set('theta_x1', '0[arcmin]', 'Field angle 1, x-component');
model.param.set('theta_y1', '0[arcmin]', 'Field angle 1, y-component');
model.param.set('theta_x2', '5[arcmin]', 'Field angle 2, x-component');
model.param.set('theta_y2', '0[arcmin]', 'Field angle 2, y-component');
model.param.set('theta_x3', '10[arcmin]', 'Field angle 3, x-component');
model.param.set('theta_y3', '0[arcmin]', 'Field angle 3, y-component');
model.param.set('N_ring', '10', 'Number of hexapolar rings');
model.param.set('P_nom', '2400.0[mm]', 'Nominal entrance pupil diameter');
model.param.set('F_nom', '24.0', 'Nominal focal ratio');
model.param.set('f_nom', 'F_nom*P_nom', 'Nominal focal length');
model.param.set('R_prim', '-11040.0[mm]', 'Primary mirror radius of curvature');
model.param.set('k_prim', '-1.0022985', 'Primary mirror conic constant');
model.param.set('f_prim', 'R_prim/2', 'Primary mirror focal length');
model.param.set('d0_prim', '2450.0[mm]', 'Primary mirror full diameter');
model.param.set('d1_prim', '0', 'Primary mirror surface diameter');
model.param.set('dc_prim', '0', 'Primary mirror clear diameter');
model.param.set('dh_prim', '600.0[mm]', 'Primary mirror central hole diameter');
model.param.set('Tc_prim', '125.0[mm]', 'Primary mirror center thickness');
model.param.set('Z_prim', '0[mm]', 'Primary mirror z position (absolute)');
model.param.set('np_extra', '10', 'Primary mirror number of azimuthal extra points');
model.param.set('R_sec', '1358.000[mm]', 'Secondary mirror radius of curvature');
model.param.set('k_sec', '-1.49600', 'Secondary mirror conic constant');
model.param.set('d_sec', '395.0[mm]', 'Secondary mirror diameter');
model.param.set('Tc_sec', '75.0[mm]', 'Secondary mirror center thickness');
model.param.set('Z_sec', '-4906.071[mm]', 'Secondary mirror z position (relative to primary vertex)');
model.param.set('Z_bfl', '1500.000[mm]', 'Image surface back focal length (relative to primary vertex)');
model.param.set('Z_image', 'Z_sec-Z_bfl', 'Image surface z position (relative to secondary vertex)');
model.param.set('hw_image', '200.0[mm]', 'Image surface half width');
model.param.set('Z_exit', '-7003.51[mm]', 'Exit pupil z position (relative to image surface)');
model.param.set('Z_obs', '100.0[mm]', 'Obstruction offset (from secondary vertex)');
model.param.set('eta_obs', '0.33', 'Obstruction fraction');
model.param.set('d0_obs', 'eta_obs*P_nom', 'Obstruction diameter');
model.param.set('m', 'abs(f_nom/f_prim)', 'Transverse magnification of secondary');
model.param.set('beta', 'abs(Z_bfl/f_prim)', 'Ratio of back focal length to primary focal length');
model.param.set('Cp', '2*(1/R_sec-1/R_prim)', 'Petzval curvature');
model.param.set('max_prim', '50.0[mm]', 'Maximum element size, primary');
model.param.set('max_sec', 'max_prim*d_sec/dc_prim', 'Maximum element size, secondary');
model.param.set('vz', '1', 'Ray direction vector, z-component');
model.param.set('vx1', 'tan(theta_x1)', 'Ray direction vector, x-component');
model.param.set('vy1', 'tan(theta_y1)', 'Ray direction vector, y-component');
model.param.set('vx2', 'tan(theta_x2)', 'Ray direction vector, x-component');
model.param.set('vy2', 'tan(theta_y2)', 'Ray direction vector, y-component');
model.param.set('vx3', 'tan(theta_x3)', 'Ray direction vector, x-component');
model.param.set('vy3', 'tan(theta_y3)', 'Ray direction vector, y-component');
model.param.set('dz', '2*Z_obs-Z_sec', 'Ray launch z-coordinate');
model.param.set('dx1', 'dz*tan(theta_x1)', 'Ray launch, field 1, x-coordinate');
model.param.set('dy1', 'dz*tan(theta_y1)', 'Ray launch, field 1, y-coordinate');
model.param.set('dx2', 'dz*tan(theta_x2)', 'Ray launch, field 2, x-coordinate');
model.param.set('dy2', 'dz*tan(theta_y2)', 'Ray launch, field 2, y-coordinate');
model.param.set('dx3', 'dz*tan(theta_x3)', 'Ray launch, field 3, x-coordinate');
model.param.set('dy3', 'dz*tan(theta_y3)', 'Ray launch, field 3, y-coordinate');
model.param.set('theta_Airy', '1.22*lam_vac/P_nom', 'Airy disc angular radius');
model.param.set('r_Airy', 'f_nom*theta_Airy', 'Airy disc radius');

model.geom.load({'part1'}, 'Ray_Optics_Module/3D/Mirrors/conic_mirror_on_axis_3d.mph', {'part1'});
model.geom('geom1').create('pi1', 'PartInstance');
model.geom('geom1').feature('pi1').set('selkeepnoncontr', false);
model.geom('geom1').feature('pi1').set('part', 'part1');
model.geom('geom1').feature('pi1').label('Primary Mirror');
model.geom('geom1').feature('pi1').setEntry('inputexpr', 'R', 'R_prim');
model.geom('geom1').feature('pi1').setEntry('inputexpr', 'k', 'k_prim');
model.geom('geom1').feature('pi1').setEntry('inputexpr', 'Tc', 'Tc_prim');
model.geom('geom1').feature('pi1').setEntry('inputexpr', 'd0', 'd0_prim');
model.geom('geom1').feature('pi1').setEntry('inputexpr', 'd1', 0);
model.geom('geom1').feature('pi1').setEntry('inputexpr', 'd_clear', 0);
model.geom('geom1').feature('pi1').setEntry('inputexpr', 'd_hole', 'dh_prim');
model.geom('geom1').feature('pi1').setEntry('inputexpr', 'nix', 'nix');
model.geom('geom1').feature('pi1').setEntry('inputexpr', 'niy', 'niy');
model.geom('geom1').feature('pi1').setEntry('inputexpr', 'niz', 'niz');
model.geom('geom1').feature('pi1').setEntry('inputexpr', 'n_extra_a', 'np_extra');
model.geom('geom1').feature('pi1').set('displ', {'0' '0' 'Z_prim'});
model.geom('geom1').run('pi1');
model.geom('geom1').feature('pi1').setEntry('selkeepbnd', 'pi1_cylsel1', true);
model.geom('geom1').selection.create('csel1', 'CumulativeSelection');
model.geom('geom1').selection('csel1').label('Obstructions');
model.geom('geom1').feature('pi1').setEntry('selcontributetobnd', 'pi1_cylsel2', 'csel1');
model.geom('geom1').feature('pi1').setEntry('selcontributetobnd', 'pi1_cylsel2', 'csel1');
model.geom('geom1').feature('pi1').setEntry('selcontributetobnd', 'pi1_comsel2', 'csel1');
model.geom('geom1').create('pi2', 'PartInstance');
model.geom('geom1').feature('pi2').set('selkeepnoncontr', false);
model.geom('geom1').feature('pi2').set('part', 'part1');
model.geom('geom1').feature('pi2').label('Secondary Mirror');
model.geom('geom1').feature('pi2').setEntry('inputexpr', 'R', 'R_sec');
model.geom('geom1').feature('pi2').setEntry('inputexpr', 'k', 'k_sec');
model.geom('geom1').feature('pi2').setEntry('inputexpr', 'Tc', 'Tc_sec');
model.geom('geom1').feature('pi2').setEntry('inputexpr', 'd0', 'd_sec');
model.geom('geom1').feature('pi2').setEntry('inputexpr', 'd1', 0);
model.geom('geom1').feature('pi2').setEntry('inputexpr', 'd_clear', 0);
model.geom('geom1').feature('pi2').setEntry('inputexpr', 'd_hole', 0);
model.geom('geom1').feature('pi2').set('workplanesrc', 'pi1');
model.geom('geom1').feature('pi2').set('workplane', 'wp1');
model.geom('geom1').feature('pi2').set('displ', {'0' '0' 'Z_sec'});
model.geom('geom1').run('pi2');
model.geom('geom1').feature('pi2').setEntry('selkeepbnd', 'pi2_cylsel1', true);
model.geom('geom1').feature('pi2').setEntry('selcontributetobnd', 'pi2_cylsel2', 'csel1');
model.geom('geom1').feature('pi2').setEntry('selcontributetobnd', 'pi2_comsel2', 'csel1');
model.geom('geom1').create('ps1', 'ParametricSurface');
model.geom('geom1').feature('ps1').label('Image Surface');
model.geom('geom1').feature('ps1').set('parmin1', '-hw_image');
model.geom('geom1').feature('ps1').set('parmax1', 'hw_image');
model.geom('geom1').feature('ps1').set('parmin2', '-hw_image');
model.geom('geom1').feature('ps1').set('parmax2', 'hw_image');
model.geom('geom1').feature('ps1').set('coord', {'s1' 's2' 'Cp*(s1^2 + s2^2)/(1 + sqrt(1 - Cp^2*(s1^2 + s2^2)))*1[m]'});
model.geom('geom1').feature('ps1').set('pos', {'0' '0' 'Z_image'});
model.geom('geom1').feature('ps1').set('workplanesrc', 'pi2');
model.geom('geom1').feature('ps1').set('workplane', 'wp1');
model.geom('geom1').feature('ps1').set('selresult', true);
model.geom.load({'part2'}, 'Ray_Optics_Module/3D/Apertures_and_Obstructions/circular_planar_annulus.mph', {'part1'});
model.geom('geom1').run('ps1');
model.geom('geom1').create('pi3', 'PartInstance');
model.geom('geom1').feature('pi3').set('selkeepnoncontr', false);
model.geom('geom1').feature('pi3').set('part', 'part2');
model.geom('geom1').feature('pi3').label('Secondary Obstruction');
model.geom('geom1').feature('pi3').setEntry('inputexpr', 'd0', 'd0_obs');
model.geom('geom1').feature('pi3').setEntry('inputexpr', 'd1', 0);
model.geom('geom1').feature('pi3').set('workplanesrc', 'pi2');
model.geom('geom1').feature('pi3').set('workplane', 'wp1');
model.geom('geom1').feature('pi3').set('displ', {'0' '0' 'Z_obs'});
model.geom('geom1').feature('pi3').setEntry('selcontributetobnd', 'pi3_sel1', 'csel1');
model.geom('geom1').run('pi3');

model.view('view1').camera.set('projection', 'orthographic');

model.geom('geom1').run;

model.physics('gop').selection.set([]);
model.physics('gop').prop('MaximumSecondary').setIndex('MaximumSecondary', 0, 0);
model.physics('gop').create('mir1', 'Mirror', 2);
model.physics('gop').feature('mir1').label('Primary');
model.physics('gop').feature('mir1').selection.named('geom1_pi1_cylsel1');
model.physics('gop').create('mir2', 'Mirror', 2);
model.physics('gop').feature('mir2').label('Secondary');
model.physics('gop').feature('mir2').selection.named('geom1_pi2_cylsel1');
model.physics('gop').create('wall1', 'Wall', 2);
model.physics('gop').feature('wall1').label('Obstructions');
model.physics('gop').feature('wall1').selection.named('geom1_csel1_bnd');
model.physics('gop').feature('wall1').set('WallCondition', 'Disappear');
model.physics('gop').create('wall2', 'Wall', 2);
model.physics('gop').feature('wall2').label('Image');
model.physics('gop').feature('wall2').selection.named('geom1_ps1_bnd');
model.physics('gop').create('relg1', 'ReleaseGrid', -1);
model.physics('gop').feature('relg1').set('GridType', 'Hexapolar');
model.physics('gop').feature('relg1').set('qcc', {'-dx1' '-dy1' 'dz'});
model.physics('gop').feature('relg1').set('rcc', [0 0 1]);
model.physics('gop').feature('relg1').set('Rc', 'P_nom/2');
model.physics('gop').feature('relg1').setIndex('Ncr', 'N_ring', 0);
model.physics('gop').feature('relg1').set('L0', {'vx1' 'vy1' '-vz'});
model.physics('gop').feature.duplicate('relg2', 'relg1');
model.physics('gop').feature('relg2').set('qcc', {'-dx2' '-dy2' 'dz'});
model.physics('gop').feature('relg2').set('L0', {'vx2' 'vy2' '-vz'});
model.physics('gop').feature.duplicate('relg3', 'relg2');
model.physics('gop').feature('relg3').set('qcc', {'-dx3' '-dy3' 'dz'});
model.physics('gop').feature('relg3').set('L0', {'vx3' 'vy3' '-vz'});

model.mesh('mesh1').autoMeshSize(1);
model.mesh('mesh1').run;

model.study('std1').feature('rtrac').set('timestepspec', 'specifylength');
model.study('std1').feature('rtrac').set('llist', '0 17');

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
model.result('pg1').set('titletype', 'none');
model.result('pg1').set('showlegendsmaxmin', true);
model.result('pg1').set('showlegendsunit', true);
model.result('pg1').run;
model.result('pg1').feature('rtrj1').feature('col1').set('expr', 'at(''last'',gop.rrel)');
model.result('pg1').feature('rtrj1').feature('col1').set('unit', [native2unicode(hex2dec({'00' 'b5'}), 'unicode') 'm']);
model.result('pg1').run;
model.result('pg1').create('surf1', 'Surface');
model.result('pg1').feature('surf1').set('coloring', 'uniform');
model.result('pg1').feature('surf1').set('color', 'gray');
model.result('pg1').feature('surf1').create('sel1', 'Selection');
model.result('pg1').feature('surf1').feature('sel1').selection.named('geom1_csel1_bnd');
model.result('pg1').run;
model.result('pg1').create('surf2', 'Surface');
model.result('pg1').feature('surf2').set('coloring', 'uniform');
model.result('pg1').feature('surf2').set('color', 'custom');
model.result('pg1').feature('surf2').set('customcolor', [0.7411764860153198 0.7882353067398071 0.8470588326454163]);
model.result('pg1').feature('surf2').create('sel1', 'Selection');
model.result('pg1').feature('surf2').feature('sel1').selection.set([4 11]);
model.result('pg1').run;
model.result.create('pg2', 'PlotGroup2D');
model.result('pg2').run;
model.result('pg2').label('Spot Diagram');
model.result('pg2').set('showlegendsunit', true);
model.result('pg2').create('spot1', 'SpotDiagram');
model.result('pg2').feature('spot1').set('layout', 'rectangular');
model.result('pg2').feature('spot1').set('paddinghoriz', 0);
model.result('pg2').feature('spot1').set('circleactive', true);
model.result('pg2').feature('spot1').set('circleradiusexpr', 'r_Airy');
model.result('pg2').feature('spot1').create('col1', 'Color');
model.result('pg2').run;
model.result('pg2').feature('spot1').feature('col1').set('expr', 'at(0,gop.rrel)');
model.result('pg2').run;

model.title('Hubble Space Telescope');

model.description(['The Hubble Space Telescope (HST) is an example of a standard Cassegrain telescope. The ' native2unicode(hex2dec({'20' '18'}), 'unicode') 'Conic Mirror On Axis 3D' native2unicode(hex2dec({'20' '19'}), 'unicode') ' part from the Ray Optics Module Part Library is used to construct the HST Ritchey' native2unicode(hex2dec({'20' '13'}), 'unicode') 'Chr' native2unicode(hex2dec({'00' 'e9'}), 'unicode') 'tien geometry. Multiple release features are used to generate on- and off-axis ray and spot diagrams.']);

model.mesh.clearMeshes;

model.sol('sol1').clearSolutionData;

model.label('hubble_space_telescope.mph');

model.modelNode.label('Components');

out = model;
