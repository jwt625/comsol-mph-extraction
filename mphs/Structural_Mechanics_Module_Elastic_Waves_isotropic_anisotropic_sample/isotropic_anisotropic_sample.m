function out = model
%
% isotropic_anisotropic_sample.m
%
% Model exported on May 26 2025, 21:33 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/Structural_Mechanics_Module/Elastic_Waves');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 2);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.physics.create('elte', 'ElasticWavesTimeExplicit', 'geom1');
model.physics('elte').model('comp1');

model.study.create('std1');
model.study('std1').create('time', 'Transient');
model.study('std1').feature('time').setSolveFor('/physics/elte', true);

% To import content from file, use:
% model.param.loadFile('FILENAME');
model.param.set('L', '18[cm]', 'Length of half sample');
model.param.set('f0', '170[kHz]', 'Source center frequency');
model.param.set('t0', '6[us]', 'Source time shift');
model.param.set('x0', '-2[cm]', 'Source location x-coordinate');
model.param.set('y0', '0[cm]', 'Source location y-coordinate');
model.param.set('dS', '2e-7[1/m^2]', 'Source extent');
model.param.set('cs_an', '2150[m/s]', 'Shear wave speed (anisotropic material)');
model.param.set('cs_iso', '2350[m/s]', 'Shear wave speed (isotropic material)');

model.func.create('an1', 'Analytic');
model.func('an1').set('funcname', 'G_space');
model.func('an1').set('expr', '1/(pi*dS)*exp(-((x - x0)^2 + (y - y0)^2)/dS)');
model.func('an1').set('args', 'x, y');
model.func('an1').setIndex('argunit', 'm', 0);
model.func('an1').set('fununit', '1');
model.func('an1').setIndex('plotargs', -0.04, 0, 1);
model.func('an1').setIndex('plotargs', 0, 0, 2);
model.func('an1').setIndex('plotargs', -0.02, 1, 1);
model.func('an1').setIndex('plotargs', 0.02, 1, 2);
model.func.create('an2', 'Analytic');
model.func('an2').set('funcname', 'G_time');
model.func('an2').set('expr', '(1 - 2*pi^2*f0^2*(t - t0)^2)*exp(-pi^2*f0^2*(t - t0)^2)');
model.func('an2').set('args', 't');
model.func('an2').setIndex('argunit', 's', 0);
model.func('an2').set('fununit', 'N');
model.func('an2').setIndex('plotargs', '5*t0', 0, 2);
model.func('an2').createPlot('pg1');

model.result('pg1').run;
model.result('pg1').label('Impulse Frequency Content');
model.result('pg1').set('title', 'FFT of G_time (Pa)');
model.result('pg1').set('ylabelactive', true);
model.result('pg1').set('ylabel', 'FFT of the signal (Pa)');
model.result('pg1').run;
model.result('pg1').feature('plot1').set('display', 'fourier');
model.result('pg1').feature('plot1').set('fouriershow', 'spectrum');
model.result('pg1').feature('plot1').set('scale', 'multiplyperiod');
model.result('pg1').run;
model.result('pg1').feature('plot1').set('freqrangeactive', true);
model.result('pg1').feature('plot1').set('freqmax', 1000000);
model.result('pg1').run;

model.geom('geom1').create('sq1', 'Square');
model.geom('geom1').feature('sq1').set('size', '2*L');
model.geom('geom1').feature('sq1').set('base', 'center');
model.geom('geom1').feature('sq1').set('layerleft', true);
model.geom('geom1').feature('sq1').setIndex('layername', 'Layer 1', 0);
model.geom('geom1').feature('sq1').setIndex('layer', 'L/6', 0);
model.geom('geom1').feature('sq1').set('layerright', true);
model.geom('geom1').feature('sq1').set('layertop', true);
model.geom('geom1').run('sq1');
model.geom('geom1').create('ls1', 'LineSegment');
model.geom('geom1').feature('ls1').set('specify1', 'coord');
model.geom('geom1').feature('ls1').set('coord1', {'0' '-L'});
model.geom('geom1').feature('ls1').set('specify2', 'coord');
model.geom('geom1').feature('ls1').set('coord2', {'0' 'L'});
model.geom('geom1').run('ls1');
model.geom('geom1').create('pt1', 'Point');
model.geom('geom1').feature('pt1').setIndex('p', '-10.5[cm] -3.5[cm] -1[cm] 10.5[cm]', 0);
model.geom('geom1').feature('pt1').setIndex('p', '-8[cm] -8[cm] -8[cm] -8[cm]', 1);
model.geom('geom1').runPre('fin');

model.selection.create('sel1', 'Explicit');
model.selection('sel1').model('comp1');

model.geom('geom1').run;

model.selection('sel1').geom(0);
model.selection('sel1').set([9 10 11 16]);
model.selection('sel1').label('Probe Points');

model.coordSystem.create('ab1', 'geom1', 'AbsorbingLayer');
model.coordSystem('ab1').selection.set([1 2 3 4 6 7 9 10 11 12]);

model.physics('elte').feature('eltem1').set('SolidModel', 'Anisotropic');

model.material.create('mat1', 'Common', 'comp1');
model.material('mat1').label('Material Isotropic');
model.material('mat1').selection.set([7 8 9 10 11 12]);
model.material('mat1').propertyGroup.create('AnisotropicVoGrp', 'Anisotropic_Voigt_notation');
model.material('mat1').propertyGroup('AnisotropicVoGrp').set('DVo', {'16.5e10' '8.58e10' '16.5e10' '8.58e10' '8.58e10' '16.5e10' '0' '0' '0' '3.96e10'  ...
'0' '0' '0' '0' '3.96e10' '0' '0' '0' '0' '0'  ...
'3.96e10'});
model.material('mat1').propertyGroup('def').set('density', {'7100'});
model.material.create('mat2', 'Common', 'comp1');
model.material('mat2').label('Material Anisotropic');
model.material('mat2').selection.set([1 2 3 4 5 6]);
model.material('mat2').propertyGroup.create('AnisotropicVoGrp', 'Anisotropic_Voigt_notation');
model.material('mat2').propertyGroup('AnisotropicVoGrp').set('DVo', {'16.5e10' '5.0e10' '6.2e10' '5.0e10' '5.0e10' '6.2e10' '0' '0' '0' '3.96e10'  ...
'0' '0' '0' '0' '3.96e10' '0' '0' '0' '0' '0'  ...
'3.96e10'});
model.material('mat2').propertyGroup('def').set('density', {'7100'});

model.physics('elte').feature('eltem1').create('cdisp1', 'ComputeDisplacement', 0);
model.physics('elte').feature('eltem1').feature('cdisp1').selection.named('sel1');
model.physics('elte').create('bl1', 'BodyLoad', 2);
model.physics('elte').feature('bl1').selection.set([5 8]);
model.physics('elte').feature('bl1').set('LoadType', 'TotalForce');
model.physics('elte').feature('bl1').set('Ftot', {'0' 'G_space(x,y)*G_time(t)' '0'});
model.physics('elte').create('lrb1', 'LowReflectingBoundary', 1);
model.physics('elte').feature('lrb1').selection.set([1 2 3 5 7 9 14 16 21 23 28 29 30 31]);
model.physics('elte').create('mde1', 'MaterialDiscontinuityElem', 1);
model.physics('elte').feature('mde1').selection.set([15 17 19]);

model.probe.create('point1', 'Point');
model.probe('point1').model('comp1');
model.probe('point1').selection.set([9]);
model.probe('point1').set('expr', 'elte.uy');
model.probe('point1').set('descr', 'Displacement, y-component');
model.probe('point1').set('descractive', true);
model.probe('point1').set('descr', 'y-displacement at (-10.5 cm, -8 cm)');
model.probe.duplicate('point2', 'point1');
model.probe('point2').selection.set([10]);
model.probe('point2').set('descr', 'y-displacement at (-3.5 cm, -8 cm)');
model.probe.duplicate('point3', 'point2');
model.probe('point3').selection.set([11]);
model.probe('point3').set('descr', 'y-displacement at (-1 cm, -8 cm)');
model.probe.duplicate('point4', 'point3');
model.probe('point4').selection.set([16]);
model.probe('point4').set('descr', 'y-displacement at (10.5 cm, -8 cm)');

model.nodeGroup.create('grp1', 'Definitions', 'comp1');
model.nodeGroup('grp1').set('type', 'probe');
model.nodeGroup('grp1').add('probe', 'point1');
model.nodeGroup('grp1').add('probe', 'point2');
model.nodeGroup('grp1').add('probe', 'point3');
model.nodeGroup('grp1').add('probe', 'point4');

model.mesh('mesh1').create('map1', 'Map');
model.mesh('mesh1').feature('size').set('custom', true);
model.mesh('mesh1').feature('size').set('hmax', 'cs_an/(2*f0)/1.5');
model.mesh('mesh1').run;

model.study('std1').label('Study 1 - ELTE (store full solution)');
model.study('std1').feature('time').set('tunit', [native2unicode(hex2dec({'00' 'b5'}), 'unicode') 's']);
model.study('std1').feature('time').set('tlist', 'range(0, 30[us], 90[us])');

model.sol.create('sol1');
model.sol('sol1').study('std1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'time');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').set('control', 'time');
model.sol('sol1').create('t1', 'Time');
model.sol('sol1').feature('t1').set('odesolvertype', 'explicit');
model.sol('sol1').feature('t1').set('timemethodexp', 'erk');
model.sol('sol1').feature('t1').set('tlist', 'range(0, 30[us], 90[us])');
model.sol('sol1').feature('t1').set('plot', 'off');
model.sol('sol1').feature('t1').set('plotgroup', 'pg1');
model.sol('sol1').feature('t1').set('plotfreq', 'tout');
model.sol('sol1').feature('t1').set('probesel', 'all');
model.sol('sol1').feature('t1').set('probes', {'point1' 'point2' 'point3' 'point4'});
model.sol('sol1').feature('t1').set('probefreq', 'tsteps');
model.sol('sol1').feature('t1').set('exprs', {'root.comp1.elte.wtc' 'root.comp1.elte.wtc'});
model.sol('sol1').feature('t1').set('tstepping', 'elemexprs');
model.sol('sol1').feature('t1').set('control', 'time');
model.sol('sol1').feature('t1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('t1').feature('fc1').set('linsolver', 'dDef');
model.sol('sol1').feature('t1').feature.remove('fcDef');
model.sol('sol1').attach('std1');

model.probe('point1').genResult('none');
model.probe('point2').genResult('none');
model.probe('point3').genResult('none');
model.probe('point4').genResult('none');

model.sol('sol1').runAll;

model.result.create('pg3', 'PlotGroup2D');
model.result('pg3').label('Velocity Magnitude (elte)');
model.result('pg3').set('showlegendsunit', true);
model.result('pg3').set('data', 'dset1');
model.result('pg3').setIndex('looplevel', 4, 0);
model.result('pg3').set('defaultPlotID', 'ElasticWavesTimeExplicit/phys1/pdef1/pcond2/pg1');
model.result('pg3').feature.create('surf1', 'Surface');
model.result('pg3').feature('surf1').set('resolution', 'custom');
model.result('pg3').feature('surf1').set('refine', 6);
model.result('pg3').feature('surf1').set('smooth', 'internal');
model.result('pg3').feature('surf1').set('data', 'parent');
model.result.create('pg4', 'PlotGroup2D');
model.result('pg4').label('Pressure (elte)');
model.result('pg4').set('showlegendsunit', true);
model.result('pg4').set('data', 'dset1');
model.result('pg4').setIndex('looplevel', 4, 0);
model.result('pg4').set('defaultPlotID', 'ElasticWavesTimeExplicit/phys1/pdef1/pcond2/pg2');
model.result('pg4').feature.create('surf1', 'Surface');
model.result('pg4').feature('surf1').set('expr', 'elte.p');
model.result('pg4').feature('surf1').set('colortable', 'Wave');
model.result('pg4').feature('surf1').set('colorscalemode', 'linearsymmetric');
model.result('pg4').feature('surf1').set('resolution', 'custom');
model.result('pg4').feature('surf1').set('refine', 6);
model.result('pg4').feature('surf1').set('smooth', 'internal');
model.result('pg4').feature('surf1').set('data', 'parent');
model.result('pg3').run;
model.result.dataset('dset1').selection.geom('geom1', 2);
model.result.dataset('dset1').selection.geom('geom1', 2);
model.result.dataset('dset1').selection.set([5 8]);
model.result('pg3').run;
model.result('pg3').setIndex('looplevel', 2, 0);
model.result('pg3').run;
model.result('pg3').feature('surf1').set('colortable', 'GrayScale');
model.result('pg3').feature('surf1').set('colortabletrans', 'reverse');
model.result('pg3').feature('surf1').set('rangecoloractive', true);
model.result('pg3').feature('surf1').set('rangecolormin', 0);
model.result('pg3').feature('surf1').set('rangecolormax', '1e-5');
model.result('pg3').run;
model.result('pg3').run;
model.result('pg3').setIndex('looplevel', 3, 0);
model.result('pg3').run;
model.result('pg3').setIndex('looplevel', 4, 0);
model.result('pg3').run;
model.result('pg3').setIndex('looplevel', 2, 0);
model.result('pg4').run;
model.result('pg4').setIndex('looplevel', 2, 0);
model.result('pg4').run;
model.result('pg2').set('window', 'window2');
model.result('pg2').set('windowtitle', 'Probe Plot 2');
model.result('pg2').run;
model.result('pg2').label('Displacement in (x,y) = (-10.5 cm, -8 cm)');
model.result('pg2').set('titletype', 'label');
model.result('pg2').set('showlegends', false);
model.result('pg2').set('window', 'window2');
model.result('pg2').set('windowtitle', 'Probe Plot 2');
model.result('pg2').run;
model.result('pg2').feature('tblp1').set('plotcolumns', [2]);
model.result('pg2').set('window', 'window2');
model.result('pg2').set('windowtitle', 'Probe Plot 2');
model.result('pg2').run;
model.result('pg2').set('window', 'window2');
model.result('pg2').set('windowtitle', 'Probe Plot 2');
model.result('pg2').run;
model.result.duplicate('pg5', 'pg2');
model.result('pg5').set('window', 'window2');
model.result('pg5').set('windowtitle', 'Probe Plot 2');
model.result('pg5').run;
model.result('pg5').label('Displacement in (x,y) = (-3.5 cm, -8 cm)');
model.result('pg5').set('window', 'window2');
model.result('pg5').set('windowtitle', 'Probe Plot 2');
model.result('pg5').run;
model.result('pg5').feature('tblp1').set('plotcolumns', [3]);
model.result('pg5').set('window', 'window2');
model.result('pg5').set('windowtitle', 'Probe Plot 2');
model.result('pg5').run;
model.result('pg5').set('window', 'window2');
model.result('pg5').set('windowtitle', 'Probe Plot 2');
model.result('pg5').run;
model.result.duplicate('pg6', 'pg5');
model.result('pg6').set('window', 'window2');
model.result('pg6').set('windowtitle', 'Probe Plot 2');
model.result('pg6').run;
model.result('pg6').label('Displacement in (x,y) = (-1 cm, -8 cm)');
model.result('pg6').set('window', 'window2');
model.result('pg6').set('windowtitle', 'Probe Plot 2');
model.result('pg6').run;
model.result('pg6').feature('tblp1').set('plotcolumns', [4]);
model.result('pg6').set('window', 'window2');
model.result('pg6').set('windowtitle', 'Probe Plot 2');
model.result('pg6').run;
model.result('pg6').set('window', 'window2');
model.result('pg6').set('windowtitle', 'Probe Plot 2');
model.result('pg6').run;
model.result.duplicate('pg7', 'pg6');
model.result('pg7').set('window', 'window2');
model.result('pg7').set('windowtitle', 'Probe Plot 2');
model.result('pg7').run;
model.result('pg7').label('Displacement in (x,y) = (10.5 cm, -8 cm)');
model.result('pg7').set('window', 'window2');
model.result('pg7').set('windowtitle', 'Probe Plot 2');
model.result('pg7').run;
model.result('pg7').feature('tblp1').set('plotcolumns', [5]);
model.result('pg7').set('window', 'window2');
model.result('pg7').set('windowtitle', 'Probe Plot 2');
model.result('pg7').run;
model.result.create('pg8', 'PlotGroup2D');
model.result('pg8').run;
model.result('pg8').label('Apparent Shear Wave Speed');
model.result('pg8').setIndex('looplevel', 2, 0);
model.result('pg8').set('showlegendsunit', true);
model.result('pg8').create('surf1', 'Surface');
model.result('pg8').feature('surf1').set('expr', 'elte.cs');
model.result('pg8').run;
model.result('pg8').run;
model.result.duplicate('pg9', 'pg8');
model.result('pg9').run;
model.result('pg9').label('Apparent Pressure Wave Speed');
model.result('pg9').run;
model.result('pg9').feature('surf1').set('expr', 'elte.cp');
model.result('pg9').run;
model.result('pg3').run;

model.title('Isotropic-Anisotropic Sample: Elastic Wave Propagation');

model.description('In this 2D tutorial, a test sample consists on one side of an isotropic material and on the other side of a heterogeneous anisotropic material (a transverse anisotropic zinc crystal). Elastic waves in the sample are excited by a point-like force. The model is solved with the Elastic Waves, Time Explicit physics interface.');

model.mesh.clearMeshes;

model.sol('sol1').clearSolutionData;

model.label('isotropic_anisotropic_sample.mph');

model.modelNode.label('Components');

out = model;
