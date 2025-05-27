function out = model
%
% ray_optics_modeling_fresnel_lens.m
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

model.geom('geom1').lengthUnit('cm');
model.geom('geom1').geomRep('cadps');

model.param.set('f0', '5.5[cm]');
model.param.descr('f0', 'Effective focal length');
model.param.set('n', '1.5');
model.param.descr('n', 'Refractive index');
model.param.set('d', '5[cm]');
model.param.descr('d', 'Lens diameter');
model.param.set('t_fl', '0.2[cm]');
model.param.descr('t_fl', 'Designed Fresnel lens thickness');
model.param.set('z_image', '4.7[cm]');
model.param.descr('z_image', 'Image position for the Fresnel lens in z direction');
model.param.set('dx', '10[cm]');
model.param.descr('dx', 'Shift of the plano-convex lens position in x direction');
model.param.set('dz', '-0.7[cm]');
model.param.descr('dz', 'Shift of the plano-convex lens position in z direction');

model.view('view1').camera.set('zoomanglefull', 5.3);
model.view('view1').camera.set('position', [-155 -72 -39]);
model.view('view1').camera.set('target', [4.9 0.3 -10.6]);
model.view('view1').camera.set('up', [0.4 -0.9 0.1]);
model.view('view1').camera.set('rotationpoint', [0.22 -1.66 -3.2]);
model.view('view1').camera.set('viewoffset', [0.58 -0.1]);

model.geom.load({'part1'}, 'Ray_Optics_Module/3D/Spherical_Lenses/spherical_plano_convex_lens_3d.mph', {'part4'});
model.geom('geom1').create('pi1', 'PartInstance');
model.geom('geom1').feature('pi1').set('selkeepnoncontr', false);
model.geom('geom1').feature('pi1').set('part', 'part1');
model.geom('geom1').feature('pi1').setEntry('inputexpr', 'f', 'f0');
model.geom('geom1').feature('pi1').setEntry('inputexpr', 'nref', 'n');
model.geom('geom1').feature('pi1').setEntry('inputexpr', 'Te', '0.1[mm]');
model.geom('geom1').feature('pi1').setEntry('inputexpr', 'd', 'd');
model.geom('geom1').run('pi1');
model.geom('geom1').create('wp1', 'WorkPlane');
model.geom('geom1').feature('wp1').set('unite', true);
model.geom('geom1').feature('wp1').set('quickz', 't_fl');
model.geom('geom1').feature.duplicate('wp2', 'wp1');
model.geom('geom1').feature('wp2').set('quickz', '2*t_fl');
model.geom('geom1').feature.duplicate('wp3', 'wp2');
model.geom('geom1').feature('wp3').set('quickz', '3*t_fl');
model.geom('geom1').feature.duplicate('wp4', 'wp3');
model.geom('geom1').feature('wp4').set('quickz', '4*t_fl');
model.geom('geom1').feature.duplicate('wp5', 'wp4');
model.geom('geom1').feature('wp5').set('quickz', '5*t_fl');
model.geom('geom1').feature.duplicate('wp6', 'wp5');
model.geom('geom1').feature('wp6').set('quickz', '6*t_fl');
model.geom('geom1').feature.duplicate('wp7', 'wp6');
model.geom('geom1').feature('wp7').set('quickz', '7*t_fl');
model.geom('geom1').run('wp7');
model.geom('geom1').create('par1', 'Partition');
model.geom('geom1').feature('par1').selection('input').set({'pi1'});
model.geom('geom1').feature('par1').set('partitionwith', 'workplane');
model.geom('geom1').feature('par1').set('workplane', 'wp1');
model.geom('geom1').run('par1');
model.geom('geom1').create('par2', 'Partition');
model.geom('geom1').feature('par2').selection('input').set({'par1'});
model.geom('geom1').feature('par2').set('partitionwith', 'workplane');
model.geom('geom1').feature('par2').set('workplane', 'wp2');
model.geom('geom1').run('par2');
model.geom('geom1').create('par3', 'Partition');
model.geom('geom1').feature('par3').selection('input').set({'par2'});
model.geom('geom1').feature('par3').set('partitionwith', 'workplane');
model.geom('geom1').feature('par3').set('workplane', 'wp3');
model.geom('geom1').run('par3');
model.geom('geom1').create('par4', 'Partition');
model.geom('geom1').feature('par4').selection('input').set({'par3'});
model.geom('geom1').feature('par4').set('partitionwith', 'workplane');
model.geom('geom1').feature('par4').set('workplane', 'wp4');
model.geom('geom1').run('par4');
model.geom('geom1').create('par5', 'Partition');
model.geom('geom1').feature('par5').selection('input').set({'par4'});
model.geom('geom1').feature('par5').set('partitionwith', 'workplane');
model.geom('geom1').feature('par5').set('workplane', 'wp5');
model.geom('geom1').run('par5');
model.geom('geom1').create('par6', 'Partition');
model.geom('geom1').feature('par6').selection('input').set({'par5'});
model.geom('geom1').feature('par6').set('partitionwith', 'workplane');
model.geom('geom1').feature('par6').set('workplane', 'wp6');
model.geom('geom1').run('par6');
model.geom('geom1').create('par7', 'Partition');
model.geom('geom1').feature('par7').selection('input').set({'par6'});
model.geom('geom1').feature('par7').set('partitionwith', 'workplane');
model.geom('geom1').run('par7');
model.geom('geom1').feature.create('ext1', 'Extrude');

model.view('view1').set('renderwireframe', true);

model.geom('geom1').feature('ext1').set('extrudefrom', 'faces');
model.geom('geom1').feature('ext1').selection('inputface').set('par7', 5);
model.geom('geom1').feature('ext1').setIndex('distance', 't_fl', 0);
model.geom('geom1').run('ext1');
model.geom('geom1').feature.create('ext2', 'Extrude');
model.geom('geom1').feature('ext2').set('extrudefrom', 'faces');
model.geom('geom1').feature('ext2').selection('inputface').set('ext1', 10);
model.geom('geom1').feature('ext2').setIndex('distance', 't_fl', 0);
model.geom('geom1').run('ext2');
model.geom('geom1').feature.create('ext3', 'Extrude');
model.geom('geom1').feature('ext3').set('extrudefrom', 'faces');
model.geom('geom1').feature('ext3').selection('inputface').set('ext2', 15);
model.geom('geom1').feature('ext3').setIndex('distance', 't_fl', 0);
model.geom('geom1').run('ext3');
model.geom('geom1').feature.create('ext4', 'Extrude');
model.geom('geom1').feature('ext4').set('extrudefrom', 'faces');
model.geom('geom1').feature('ext4').selection('inputface').set('ext3', 20);
model.geom('geom1').feature('ext4').setIndex('distance', 't_fl', 0);
model.geom('geom1').run('ext4');
model.geom('geom1').feature.create('ext5', 'Extrude');
model.geom('geom1').feature('ext5').set('extrudefrom', 'faces');
model.geom('geom1').feature('ext5').selection('inputface').set('ext4', 25);
model.geom('geom1').feature('ext5').setIndex('distance', 't_fl', 0);
model.geom('geom1').run('ext5');
model.geom('geom1').feature.create('ext6', 'Extrude');
model.geom('geom1').feature('ext6').set('extrudefrom', 'faces');
model.geom('geom1').feature('ext6').selection('inputface').set('ext5', 30);
model.geom('geom1').feature('ext6').setIndex('distance', 't_fl', 0);
model.geom('geom1').run('ext6');
model.geom('geom1').feature.create('ext7', 'Extrude');
model.geom('geom1').feature('ext7').set('extrudefrom', 'faces');
model.geom('geom1').feature('ext7').selection('inputface').set('ext6', 36);
model.geom('geom1').feature('ext7').setIndex('distance', 't_fl', 0);
model.geom('geom1').run('ext7');
model.geom('geom1').create('del1', 'Delete');
model.geom('geom1').feature('del1').selection('input').init(3);
model.geom('geom1').feature('del1').selection('input').set('ext7', [1 2 4 6 8 10 12 14]);
model.geom('geom1').run('del1');
model.geom('geom1').create('spl1', 'Split');
model.geom('geom1').feature('spl1').selection('input').set({'del1'});
model.geom('geom1').run('spl1');
model.geom('geom1').create('mov1', 'Move');
model.geom('geom1').feature('mov1').selection('input').set({'spl1(6)'});
model.geom('geom1').feature('mov1').set('displz', '-t_fl');
model.geom('geom1').run('mov1');
model.geom('geom1').create('mov2', 'Move');
model.geom('geom1').feature('mov2').selection('input').set({'spl1(4)'});
model.geom('geom1').feature('mov2').set('displz', '-2*t_fl');
model.geom('geom1').run('mov2');
model.geom('geom1').create('mov3', 'Move');
model.geom('geom1').feature('mov3').selection('input').set({'spl1(3)'});
model.geom('geom1').feature('mov3').set('displz', '-3*t_fl');
model.geom('geom1').run('mov3');
model.geom('geom1').create('mov4', 'Move');
model.geom('geom1').feature('mov4').selection('input').set({'spl1(2)'});
model.geom('geom1').feature('mov4').set('displz', '-4*t_fl');
model.geom('geom1').run('mov4');
model.geom('geom1').create('mov5', 'Move');
model.geom('geom1').feature('mov5').selection('input').set({'spl1(1)'});
model.geom('geom1').feature('mov5').set('displz', '-5*t_fl');
model.geom('geom1').run('mov5');
model.geom('geom1').create('mov6', 'Move');
model.geom('geom1').feature('mov6').selection('input').set({'spl1(7)'});
model.geom('geom1').feature('mov6').set('displz', '-6*t_fl');
model.geom('geom1').run('mov6');

model.view('view1').set('renderwireframe', false);

model.geom('geom1').create('pt1', 'Point');
model.geom('geom1').feature('pt1').setIndex('p', 'z_image', 2);
model.geom('geom1').feature.duplicate('pt2', 'pt1');
model.geom('geom1').feature('pt2').setIndex('p', 'dx', 0);
model.geom('geom1').run('pt2');
model.geom('geom1').feature.duplicate('pi2', 'pi1');
model.geom('geom1').feature('pi1').set('selcontributetoobj', {});
model.geom('geom1').feature('pi1').set('selkeepobj', {});
model.geom('geom1').feature('pi1').set('selcontributetopnt', {'none'});
model.geom('geom1').feature('pi1').set('selkeeppnt', {'off'});
model.geom('geom1').feature('pi1').set('selshowpnt', {'on'});
model.geom('geom1').feature('pi1').set('selcontributetoedg', {});
model.geom('geom1').feature('pi1').set('selkeepedg', {});
model.geom('geom1').feature('pi1').set('selshowedg', {});
model.geom('geom1').feature('pi1').set('selcontributetobnd', {'none' 'none' 'none' 'none'});
model.geom('geom1').feature('pi1').set('selkeepbnd', {'off' 'off' 'off' 'off'});
model.geom('geom1').feature('pi1').set('selshowbnd', {'on' 'on' 'on' 'on'});
model.geom('geom1').feature('pi1').set('selcontributetodom', {'none'});
model.geom('geom1').feature('pi1').set('selkeepdom', {'off'});
model.geom('geom1').feature('pi1').set('selshowdom', {'on'});
model.geom('geom1').feature('pi2').set('displ', {'dx' '0' 'dz'});
model.geom('geom1').runPre('fin');
model.geom('geom1').run;

model.material.create('mat1', 'Common', 'comp1');
model.material('mat1').propertyGroup.create('RefractiveIndex', 'Refractive_index');
model.material('mat1').propertyGroup('RefractiveIndex').set('n', {'n'});

model.physics('gop').feature('matd1').set('ReleaseReflectedRays', 'Never');
model.physics('gop').create('rpt1', 'ReleaseFromPoint', 0);
model.physics('gop').feature('rpt1').selection.set([14 32]);
model.physics('gop').feature('rpt1').set('RayDirectionVector', 'Conical');
model.physics('gop').feature('rpt1').setIndex('Nw', 1000, 0);
model.physics('gop').feature('rpt1').set('cax', [0 0 -1]);
model.physics('gop').feature('rpt1').set('alphac', 'pi/8');

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
model.result('pg1').setIndex('looplevel', 101, 0);
model.result('pg1').label('Ray Trajectories (gop)');
model.result('pg1').create('rtrj1', 'RayTrajectories');
model.result('pg1').feature('rtrj1').set('linetype', 'line');
model.result('pg1').feature('rtrj1').create('col1', 'Color');
model.result('pg1').feature('rtrj1').feature('col1').set('expr', 't');
model.result('pg1').feature('rtrj1').create('filt1', 'RayTrajectoriesFilter');
model.result('pg1').run;
model.result('pg1').run;
model.result('pg1').feature('rtrj1').feature('col1').set('colorlegend', false);
model.result('pg1').feature('rtrj1').feature('col1').set('colortable', 'Viridis');
model.result('pg1').create('surf1', 'Surface');
model.result('pg1').feature('surf1').create('mtrl1', 'MaterialAppearance');
model.result('pg1').run;
model.result('pg1').run;
model.result('pg1').feature('surf1').create('tran1', 'Transparency');
model.result('pg1').run;
model.result('pg1').feature('surf1').feature('tran1').set('transparency', 0.2);
model.result.create('pg2', 'PlotGroup2D');
model.result('pg2').run;
model.result('pg2').label('Spot Diagram');
model.result('pg2').create('spot1', 'SpotDiagram');
model.result('pg2').run;

model.title('Ray Tracing Simulation of a Fresnel Lens');

model.description('This model demonstrates how a Fresnel lens can be constructed from a regular plano-convex lens when short focal length is required. The Fresnel lens thus constructed is much lighter and less expensive than the plano-convex lens. The collimation of rays from both the lenses are compared.');

model.mesh.clearMeshes;

model.sol('sol1').clearSolutionData;

model.label('ray_optics_modeling_fresnel_lens.mph');

model.modelNode.label('Components');

out = model;
