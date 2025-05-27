function out = model
%
% rowland_circle_spectrometer.m
%
% Model exported on May 26 2025, 21:32 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/Ray_Optics_Module/Tutorials');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 2);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.physics.create('gop', 'GeometricalOptics', 'geom1');
model.physics('gop').model('comp1');

model.study.create('std1');
model.study('std1').create('rtrac', 'RayTracing');
model.study('std1').feature('rtrac').setSolveFor('/physics/gop', true);

model.param.set('R', '1[m]');
model.param.descr('R', 'Rowland circle radius');
model.param.set('alpha', '5[deg]');
model.param.descr('alpha', 'Grating sector angle');
model.param.set('phi0', '30[deg]');
model.param.descr('phi0', 'Release angle (+CCW)');

model.geom('geom1').create('c1', 'Circle');
model.geom('geom1').feature('c1').set('type', 'curve');
model.geom('geom1').feature('c1').set('r', 'R');
model.geom('geom1').feature('c1').set('angle', '360-2*alpha');
model.geom('geom1').feature('c1').set('rot', '-90+alpha');
model.geom('geom1').run('c1');
model.geom('geom1').create('c2', 'Circle');
model.geom('geom1').feature('c2').set('type', 'curve');
model.geom('geom1').feature('c2').set('r', '2*R');
model.geom('geom1').feature('c2').set('angle', 'alpha');
model.geom('geom1').feature('c2').set('pos', {'0' 'R'});
model.geom('geom1').feature('c2').set('rot', '270-alpha/2');
model.geom('geom1').run('c2');
model.geom('geom1').feature.create('del1', 'Delete');
model.geom('geom1').feature('del1').selection('input').init;
model.geom('geom1').feature('del1').selection('input').init(1);
model.geom('geom1').feature('del1').selection('input').set('c1', [5 6]);
model.geom('geom1').feature('del1').selection('input').set('c2', [2 3]);
model.geom('geom1').runPre('fin');
model.geom('geom1').run;

model.physics('gop').prop('WavelengthDistribution').setIndex('WavelengthDistribution', 'PolychromaticWavelength', 0);
model.physics('gop').create('aux1', 'AuxiliaryField', -1);
model.physics('gop').feature('aux1').set('fieldVariableName', 'm');
model.physics('gop').create('relg1', 'ReleaseGrid', -1);
model.physics('gop').feature('relg1').setIndex('x0', '-R*sin(phi0)', 0);
model.physics('gop').feature('relg1').setIndex('x0', 'R*cos(phi0)', 1);
model.physics('gop').feature('relg1').set('RayDirectionVector', 'Conical');
model.physics('gop').feature('relg1').setIndex('Nw', 10, 0);
model.physics('gop').feature('relg1').set('cax', {'-x' '-(y+R)' '0'});
model.physics('gop').feature('relg1').set('alphac', '2[deg]');
model.physics('gop').feature('relg1').set('LDistributionFunction', 'Uniform');
model.physics('gop').feature('relg1').setIndex('lambda0Nval', 10, 0);
model.physics('gop').create('grat1', 'Grating', 1);
model.physics('gop').feature('grat1').selection.set([3]);
model.physics('gop').feature('grat1').set('RaysToRelease', 'Reflected');
model.physics('gop').feature('grat1').set('dg', '1.5[um]');
model.physics('gop').feature('grat1').set('InterpretationOfGratingConstant', 'ProjectedUnitCellWidth');
model.physics('gop').feature('grat1').feature.remove('dfo1');
model.physics('gop').feature('grat1').feature.create('dfo1', 'DiffractionOrder', 1);
model.physics('gop').feature('grat1').feature('dfo1').set('mg', -3);
model.physics('gop').feature('grat1').feature.create('dfo2', 'DiffractionOrder', 1);
model.physics('gop').feature('grat1').feature('dfo2').set('mg', -2);
model.physics('gop').feature('grat1').feature.create('dfo3', 'DiffractionOrder', 1);
model.physics('gop').feature('grat1').feature('dfo3').set('mg', -1);
model.physics('gop').feature('grat1').feature.create('dfo4', 'DiffractionOrder', 1);
model.physics('gop').feature('grat1').feature('dfo4').set('mg', 0);
model.physics('gop').feature('grat1').feature.create('dfo5', 'DiffractionOrder', 1);
model.physics('gop').feature('grat1').feature('dfo5').set('mg', 1);
model.physics('gop').feature('grat1').feature.create('dfo6', 'DiffractionOrder', 1);
model.physics('gop').feature('grat1').feature('dfo6').set('mg', 2);
model.physics('gop').feature('grat1').feature.create('dfo7', 'DiffractionOrder', 1);
model.physics('gop').feature('grat1').feature('dfo7').set('mg', 3);
model.physics('gop').feature('grat1').feature('dfo1').set('cauxrefl_aux1', true);
model.physics('gop').feature('grat1').feature('dfo1').set('aux0_aux1', -3);
model.physics('gop').feature('grat1').feature('dfo2').set('cauxrefl_aux1', true);
model.physics('gop').feature('grat1').feature('dfo2').set('aux0_aux1', -2);
model.physics('gop').feature('grat1').feature('dfo3').set('cauxrefl_aux1', true);
model.physics('gop').feature('grat1').feature('dfo3').set('aux0_aux1', -1);
model.physics('gop').feature('grat1').feature('dfo4').set('cauxrefl_aux1', true);
model.physics('gop').feature('grat1').feature('dfo5').set('cauxrefl_aux1', true);
model.physics('gop').feature('grat1').feature('dfo5').set('aux0_aux1', 1);
model.physics('gop').feature('grat1').feature('dfo6').set('cauxrefl_aux1', true);
model.physics('gop').feature('grat1').feature('dfo6').set('aux0_aux1', 2);
model.physics('gop').feature('grat1').feature('dfo7').set('cauxrefl_aux1', true);
model.physics('gop').feature('grat1').feature('dfo7').set('aux0_aux1', 3);
model.physics('gop').create('wall1', 'Wall', 1);
model.physics('gop').feature('wall1').selection.set([1 2 4 5]);

model.mesh('mesh1').autoMeshSize(1);
model.mesh('mesh1').run;

model.study('std1').feature('rtrac').set('timestepspec', 'specifylength');
model.study('std1').feature('rtrac').set('llist', '0 4*R');

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
model.result.dataset('ray1').set('posdof', {'comp1.qx' 'comp1.qy'});
model.result.dataset('ray1').set('geom', 'geom1');
model.result.dataset('ray1').set('rgeom', 'pgeom_gop');
model.result.dataset('ray1').set('rgeomspec', 'fromphysics');
model.result.dataset('ray1').set('physicsinterface', 'gop');
model.result.create('pg1', 'PlotGroup2D');
model.result('pg1').set('data', 'ray1');
model.result('pg1').setIndex('looplevel', 2, 0);
model.result('pg1').label('Ray Trajectories (gop)');
model.result('pg1').create('rtrj1', 'RayTrajectories');
model.result('pg1').feature('rtrj1').set('linetype', 'line');
model.result('pg1').feature('rtrj1').create('col1', 'Color');
model.result('pg1').feature('rtrj1').feature('col1').set('expr', 't');
model.result('pg1').feature('rtrj1').create('filt1', 'RayTrajectoriesFilter');
model.result('pg1').run;
model.result('pg1').label('Ray Trajectories, Diffraction Order');
model.result('pg1').set('titletype', 'label');
model.result('pg1').run;
model.result('pg1').feature('rtrj1').feature('col1').set('expr', 'm');
model.result('pg1').feature('rtrj1').feature('col1').set('descractive', true);
model.result('pg1').feature('rtrj1').feature('col1').set('descr', 'Diffraction order number');
model.result('pg1').feature('rtrj1').feature('col1').set('colortable', 'Traffic');
model.result('pg1').run;
model.result('pg1').run;
model.result.duplicate('pg2', 'pg1');
model.result('pg2').run;
model.result('pg2').label('Ray Trajectories, Vacuum Wavelength (nm)');
model.result('pg2').run;
model.result('pg2').feature('rtrj1').feature('col1').set('expr', 'gop.lambda0');
model.result('pg2').feature('rtrj1').feature('col1').set('unit', 'nm');
model.result('pg2').feature('rtrj1').feature('col1').set('colortable', 'Spectrum');
model.result('pg2').run;
model.result('pg2').feature('rtrj1').feature('filt1').set('type', 'logical');
model.result('pg2').feature('rtrj1').feature('filt1').set('logicalexpr', 'm!=0');
model.result('pg2').run;
model.result('pg2').create('rtrj2', 'RayTrajectories');
model.result('pg2').feature('rtrj2').set('linetype', 'tube');
model.result('pg2').feature('rtrj2').create('filt1', 'RayTrajectoriesFilter');
model.result('pg2').run;
model.result('pg2').feature('rtrj2').feature('filt1').set('type', 'logical');
model.result('pg2').feature('rtrj2').feature('filt1').set('logicalexpr', 'm==0');
model.result('pg2').run;
model.result.create('pg3', 'PlotGroup2D');
model.result('pg3').run;
model.result('pg3').label('2D Histogram');
model.result('pg3').set('data', 'ray1');
model.result('pg3').create('hist1', 'Histogram');
model.result('pg3').feature('hist1').set('xexpr', 'atan2(-x,y)');
model.result('pg3').feature('hist1').set('xunit', [native2unicode(hex2dec({'00' 'b0'}), 'unicode') ]);
model.result('pg3').feature('hist1').set('yexpr', 'm');
model.result('pg3').feature('hist1').set('ydescractive', true);
model.result('pg3').feature('hist1').set('ydescr', 'Diffraction order');
model.result('pg3').feature('hist1').set('ymethod', 'limits');
model.result('pg3').feature('hist1').set('ylimits', 'range(-3.5,1,3.5)');
model.result('pg3').feature('hist1').set('function', 'discrete');
model.result('pg3').feature('hist1').set('colortable', 'JupiterAuroraBorealis');
model.result('pg3').run;

model.title('Rowland Circle Spectrometer');

model.description('The Rowland circle is a circle of radius R that lies tangent to a concave curved diffraction grating of radius 2R. If the entrance slit of incoming light is positioned on this circle, then rays reflected by the grating will be focused at various points along the same circle based on wavelength and diffraction order. This tutorial model of a basic 2D Rowland circle spectrometer demonstrates how to define concave curved diffraction gratings, specify which diffraction orders to release, and track the diffraction orders of released rays using an auxiliary dependent variable.');

model.mesh.clearMeshes;

model.sol('sol1').clearSolutionData;

model.label('rowland_circle_spectrometer.mph');

model.modelNode.label('Components');

out = model;
