function out = model
%
% compact_camera_module.m
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

model.param.label('Parameters 1: Lens Prescription');
model.param.create('par2');
model.param('par2').label('Parameters 2: General');

% To import content from file, use:
% model.param('par2').loadFile('FILENAME');
model.param('par2').set('lambda', '587.56[nm]', 'Vacuum wavelength');
model.param('par2').set('nref1', '1.544', 'Lens 1, and 4 refractive index (at 587.56[nm])');
model.param('par2').set('nref2', '1.632', 'Lens 2, 3 and 5 refractive index (at 587.56[nm])');
model.param('par2').set('nref3', '1.516', 'IR filter refractive index (at 587.56[nm])');
model.param('par2').set('D_pupil', '2.50[mm]', 'Entrance pupil diameter');
model.param('par2').set('N_ring', '25', 'Number of hexapolar rings');
model.param('par2').set('theta1', '0[deg]', 'Field angle 1');
model.param('par2').set('theta2', '5[deg]', 'Field angle 2');
model.param('par2').set('theta3', '10[deg]', 'Field angle 3');
model.param('par2').set('theta4', '15[deg]', 'Field angle 4');
model.param('par2').set('dz', '-0.5[mm]', 'Ray release z-coordinate');

model.geom('geom1').label('Compact Camera Module');
model.geom('geom1').lengthUnit('mm');
model.geom('geom1').insertFile('compact_camera_module_geom_sequence.mph', 'geom1');
model.geom('geom1').run('fin');

model.view('view1').camera.set('projection', 'orthographic');
model.view('view1').set('renderwireframe', false);

model.material.create('mat1', 'Common', 'comp1');
model.material('mat1').selection.set([3 4]);
model.material('mat1').propertyGroup.create('RefractiveIndex', 'Refractive_index');
model.material('mat1').propertyGroup('RefractiveIndex').set('n', {'nref1'});
model.material.create('mat2', 'Common', 'comp1');
model.material('mat2').selection.set([2 5 6]);
model.material('mat2').propertyGroup.create('RefractiveIndex', 'Refractive_index');
model.material('mat2').propertyGroup('RefractiveIndex').set('n', {'nref2'});
model.material.create('mat3', 'Common', 'comp1');
model.material('mat3').selection.set([1]);
model.material('mat3').propertyGroup.create('RefractiveIndex', 'Refractive_index');
model.material('mat3').propertyGroup('RefractiveIndex').set('n', {'nref3'});

model.physics('gop').prop('MaximumSecondary').setIndex('MaximumSecondary', 0, 0);
model.physics('gop').prop('ExteriorUnmeshedProperties').setIndex('DispersionModel', 'AirEdlen1953', 0);
model.physics('gop').feature('matd1').set('ReleaseReflectedRays', 'Never');
model.physics('gop').feature('op1').set('lambda0', 'lambda');
model.physics('gop').create('wall1', 'Wall', 2);
model.physics('gop').feature('wall1').label('Obstructions');
model.physics('gop').feature('wall1').selection.named('geom1_csel2_bnd');
model.physics('gop').feature('wall1').set('WallCondition', 'Disappear');
model.physics('gop').create('wall2', 'Wall', 2);
model.physics('gop').feature('wall2').label('Image Surface');
model.physics('gop').feature('wall2').selection.named('geom1_pi8_sel1');
model.physics('gop').create('relg1', 'ReleaseGrid', -1);
model.physics('gop').feature('relg1').set('GridType', 'Hexapolar');
model.physics('gop').feature('relg1').set('qcc', {'0' 'dz*tan(theta1)' 'dz'});
model.physics('gop').feature('relg1').set('rcc', [0 0 1]);
model.physics('gop').feature('relg1').set('Rc', 'D_pupil/2');
model.physics('gop').feature('relg1').setIndex('Ncr', 'N_ring', 0);
model.physics('gop').feature('relg1').set('L0', {'0' 'tan(theta1)' '1'});
model.physics('gop').feature.duplicate('relg2', 'relg1');
model.physics('gop').feature('relg2').set('qcc', {'0' 'dz*tan(theta2)' 'dz'});
model.physics('gop').feature('relg2').set('L0', {'0' 'tan(theta2)' '1'});
model.physics('gop').feature.duplicate('relg3', 'relg2');
model.physics('gop').feature('relg3').set('qcc', {'0' 'dz*tan(theta3)' 'dz'});
model.physics('gop').feature('relg3').set('L0', {'0' 'tan(theta3)' '1'});
model.physics('gop').feature.duplicate('relg4', 'relg3');
model.physics('gop').feature('relg4').set('qcc', {'0' 'dz*tan(theta4)' 'dz'});
model.physics('gop').feature('relg4').set('L0', {'0' 'tan(theta4)' '1'});

model.mesh('mesh1').create('ftri1', 'FreeTri');
model.mesh('mesh1').feature('ftri1').selection.named('geom1_csel1_bnd');
model.mesh('mesh1').feature('ftri1').create('size1', 'Size');
model.mesh('mesh1').feature('ftri1').feature('size1').set('hauto', 1);
model.mesh('mesh1').create('ftet1', 'FreeTet');
model.mesh('mesh1').run;

model.study('std1').feature('rtrac').set('timestepspec', 'specifylength');
model.study('std1').feature('rtrac').set('lunit', 'mm');
model.study('std1').feature('rtrac').set('llist', '0 10');

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
model.result('pg1').label('Ray Diagram 1');
model.result('pg1').run;
model.result('pg1').run;
model.result('pg1').feature('rtrj1').feature('col1').set('expr', 'gop.prf');
model.result('pg1').run;
model.result('pg1').feature('rtrj1').feature('filt1').set('type', 'logical');
model.result('pg1').feature('rtrj1').feature('filt1').set('logicalexpr', 'at(0,abs(x))<0.01[mm]');
model.result('pg1').run;
model.result('pg1').create('slc1', 'Slice');
model.result('pg1').feature('slc1').set('expr', 'abs(y)');
model.result('pg1').feature('slc1').set('quickxnumber', 1);
model.result('pg1').feature('slc1').set('coloring', 'gradient');
model.result('pg1').feature('slc1').set('topcolor', 'black');
model.result('pg1').feature('slc1').set('bottomcolor', 'white');
model.result('pg1').feature('slc1').set('colorlegend', false);
model.result('pg1').run;
model.result('pg1').run;
model.result.duplicate('pg2', 'pg1');
model.result('pg2').run;
model.result('pg2').label('Ray Diagram 2');
model.result('pg2').set('view', 'new');
model.result('pg2').set('showlegendsunit', true);
model.result('pg2').run;
model.result('pg2').feature('rtrj1').feature('col1').set('expr', 'at(''last'',gop.rrel)');
model.result('pg2').feature('rtrj1').feature('col1').set('unit', [native2unicode(hex2dec({'00' 'b5'}), 'unicode') 'm']);
model.result('pg2').run;
model.result('pg2').feature('rtrj1').feature('filt1').set('type', 'all');
model.result('pg2').run;
model.result('pg2').feature('slc1').active(false);
model.result('pg2').run;
model.result('pg2').create('surf1', 'Surface');
model.result('pg2').feature('surf1').create('sel1', 'Selection');
model.result('pg2').feature('surf1').feature('sel1').selection.named('geom1_csel3_bnd');
model.result('pg2').run;
model.result('pg2').feature('surf1').set('expr', 'gop.nref_local');
model.result('pg2').feature('surf1').set('coloring', 'gradient');
model.result('pg2').feature('surf1').set('topcolor', 'custom');
model.result('pg2').feature('surf1').set('customtopcolor', [0.21176470816135406 0.5490196347236633 0.7960784435272217]);
model.result('pg2').feature('surf1').set('bottomcolor', 'custom');
model.result('pg2').feature('surf1').set('custombottomcolor', [0.8784313797950745 1 1]);
model.result('pg2').feature('surf1').set('colorlegend', false);
model.result('pg2').feature('surf1').create('tran1', 'Transparency');
model.result('pg2').run;
model.result('pg2').run;
model.result.create('pg3', 'PlotGroup2D');
model.result('pg3').run;
model.result('pg3').label('Spot Diagram');
model.result('pg3').set('showlegendsunit', true);
model.result('pg3').create('spot1', 'SpotDiagram');
model.result('pg3').feature('spot1').create('col1', 'Color');
model.result('pg3').run;
model.result('pg3').feature('spot1').feature('col1').set('expr', 'at(0,gop.rrel)');
model.result('pg3').run;

model.title('Compact Camera Module');

model.description('Compact camera modules are widely used in electronic devices such as mobile phones and tablet computers. In order to reduce both the size and number of elements required the optical design will typically incorporate several highly aspheric surfaces. This model demonstrates a five element design using the ''Aspheric Even Lens 3D'' part from the Ray Optics Module Part Library.');

model.mesh.clearMeshes;

model.sol('sol1').clearSolutionData;

model.label('compact_camera_module.mph');

model.modelNode.label('Components');

out = model;
