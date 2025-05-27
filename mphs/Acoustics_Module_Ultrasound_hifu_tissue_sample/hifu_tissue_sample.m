function out = model
%
% hifu_tissue_sample.m
%
% Model exported on May 26 2025, 21:25 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/Acoustics_Module/Ultrasound');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 2);
model.geom('geom1').model('comp1');
model.geom('geom1').axisymmetric(true);

model.mesh.create('mesh1', 'geom1');

model.physics.create('nate', 'NonlinearPressureAcousticsTimeExplicit', 'geom1');
model.physics('nate').model('comp1');

model.study.create('std1');
model.study('std1').create('time', 'Transient');
model.study('std1').feature('time').setSolveFor('/physics/nate', true);

% To import content from file, use:
% model.param.loadFile('FILENAME');
model.param.set('P0', '0.25[MPa]', 'Source pressure amplitude');
model.param.set('f0', '1[MHz]', 'Source frequency');
model.param.set('omega0', '2*pi*f0', 'Source angular frequency');
model.param.set('T0', '1/f0', 'Source period');
model.param.set('alpha_water', '0.025[1/m]', 'Absorption coefficient of water at 1 MHz');
model.param.set('alpha_tissue', '8.55[1/m]', 'Absorption coefficient of tissue phantom at 1 MHz');
model.param.set('c_water', '1484[m/s]', 'Speed of sound in water');
model.param.set('c_tissue', '1568[m/s]', 'Speed of sound in tissue phantom');
model.param.set('rho_water', '1000[kg/m^3]', 'Density of water');
model.param.set('rho_tissue', '1044[kg/m^3]', 'Density of tissue phantom');
model.param.set('BA_water', '5.2', 'Parameter of nonlinearity of water');
model.param.set('BA_tissue', '7.4', 'Parameter of nonlinearity of water');
model.param.set('delta_water', '2*alpha_water*c_water^3/omega0^2', 'Sound diffusivity of water');
model.param.set('delta_tissue', '2*alpha_tissue*c_tissue^3/omega0^2', 'Sound diffusivity of tissue phantom');
model.param.set('F', '60[mm]', 'Focal length');
model.param.set('r_source', '62.64[mm]', 'Lens radius');
model.param.set('w_source', '35[mm]', 'Lens aperture');
model.param.set('z_tissue', '24.6[mm]', 'Starting position of tissue phantom');
model.param.set('h_model', '95.1[mm]', 'Total height of the model');
model.param.set('r_model', '43.6[mm]', 'Total radius of the model');
model.param.set('th_abs', '5[mm]', 'Thickness of the absorbing layer');

model.func.create('rect1', 'Rectangle');
model.func('rect1').set('lower', 0);
model.func('rect1').set('upper', '5*T0');
model.func('rect1').set('smoothactive', false);
model.func.create('an1', 'Analytic');
model.func('an1').label('Pulse');
model.func('an1').set('funcname', 'pulse');
model.func('an1').set('expr', 'sin(omega0*t)*(1 - cos(omega0*t/5))*rect1(t)');
model.func('an1').set('args', 't');
model.func('an1').setIndex('argunit', 's', 0);
model.func('an1').set('fununit', '1');
model.func('an1').setIndex('plotargs', '9*T0', 0, 2);
model.func('an1').createPlot('pg1');

model.result('pg1').run;
model.result('pg1').label('Tone Burst Pulse');
model.result('pg1').run;
model.result('pg1').feature('plot1').set('display', 'fourier');
model.result('pg1').feature('plot1').set('fouriershow', 'spectrum');
model.result('pg1').feature('plot1').set('scale', 'multiplyperiod');
model.result('pg1').feature('plot1').set('freqrangeactive', true);
model.result('pg1').feature('plot1').set('freqmax', '3*f0');
model.result('pg1').run;

model.geom('geom1').lengthUnit('mm');
model.geom('geom1').create('c1', 'Circle');
model.geom('geom1').feature('c1').set('r', 'r_source');
model.geom('geom1').feature('c1').set('pos', {'0' 'r_source'});
model.geom('geom1').run('c1');
model.geom('geom1').create('r1', 'Rectangle');
model.geom('geom1').feature('r1').set('size', {'w_source' 'r_source-sqrt(r_source^2-w_source^2)'});
model.geom('geom1').run('r1');
model.geom('geom1').create('int1', 'Intersection');
model.geom('geom1').feature('int1').selection('input').set({'c1' 'r1'});
model.geom('geom1').run('int1');
model.geom('geom1').create('r2', 'Rectangle');
model.geom('geom1').feature('r2').set('size', {'r_model+th_abs' '1'});
model.geom('geom1').feature('r2').setIndex('size', 'h_model+th_abs-z_tissue', 1);
model.geom('geom1').feature('r2').set('pos', {'0' 'z_tissue'});
model.geom('geom1').feature('r2').setIndex('layername', 'Layer 1', 0);
model.geom('geom1').feature('r2').setIndex('layer', 'th_abs', 0);
model.geom('geom1').feature('r2').set('layerright', true);
model.geom('geom1').feature('r2').set('layerbottom', false);
model.geom('geom1').feature('r2').set('layertop', true);
model.geom('geom1').run('r2');
model.geom('geom1').create('r3', 'Rectangle');
model.geom('geom1').feature('r3').set('size', {'r_model+th_abs' '1'});
model.geom('geom1').feature('r3').setIndex('size', 'z_tissue-(r_source-sqrt(r_source^2-w_source^2))', 1);
model.geom('geom1').feature('r3').set('pos', {'0' 'r_source-sqrt(r_source^2-w_source^2)'});
model.geom('geom1').feature('r3').setIndex('layername', 'Layer 1', 0);
model.geom('geom1').feature('r3').setIndex('layer', 'th_abs', 0);
model.geom('geom1').feature('r3').set('layerright', true);
model.geom('geom1').feature('r3').set('layerbottom', false);
model.geom('geom1').run('r3');
model.geom('geom1').run('fin');
model.geom('geom1').create('ige1', 'IgnoreEdges');
model.geom('geom1').feature('ige1').selection('input').set('fin', 3);
model.geom('geom1').run('ige1');

model.probe.create('pdom1', 'DomainPoint');
model.probe('pdom1').model('comp1');
model.probe('pdom1').setIndex('coords2', 'z_tissue', 1);
model.probe('pdom1').feature('ppb1').set('expr', 'nate.p_t/P0');
model.probe.create('pdom2', 'DomainPoint');
model.probe('pdom2').model('comp1');
model.probe('pdom2').setIndex('coords2', 'F', 1);
model.probe('pdom2').feature('ppb2').set('expr', 'nate.p_t/P0');

model.coordSystem.create('ab1', 'geom1', 'AbsorbingLayer');
model.coordSystem('ab1').selection.set([3 4 5 6]);
model.coordSystem('ab1').set('ScalingType', 'Cylindrical');

model.physics('nate').feature('natem1').set('FluidModel', 'GeneralDissipation');
model.physics('nate').create('md1', 'MaterialDiscontinuity', 1);
model.physics('nate').feature('md1').selection.set([3 11]);
model.physics('nate').create('pr1', 'Pressure', 1);
model.physics('nate').feature('pr1').selection.set([18]);
model.physics('nate').feature('pr1').set('p0', 'P0*pulse(t)');
model.physics('nate').create('imp1', 'Impedance', 1);
model.physics('nate').feature('imp1').selection.set([6 14 15 16 17]);
model.physics('nate').feature('natem1').create('mmp1', 'MinMaxPressure', 1);
model.physics('nate').feature('natem1').feature('mmp1').selection.set([2]);

model.material.create('mat1', 'Common', 'comp1');
model.material('mat1').label('Water');
model.material('mat1').selection.set([1 4]);
model.material('mat1').propertyGroup('def').set('density', {'rho_water'});
model.material('mat1').propertyGroup('def').set('soundspeed', {'c_water'});
model.material('mat1').propertyGroup.create('AttenuationDissipationModel', 'Attenuation_and_dissipation_model');
model.material('mat1').propertyGroup('AttenuationDissipationModel').set('delta_diff', {'delta_water'});
model.material('mat1').propertyGroup.create('NonlinearModel', 'Nonlinear_model');
model.material('mat1').propertyGroup('NonlinearModel').set('BA', {'BA_water'});
model.material.create('mat2', 'Common', 'comp1');
model.material('mat2').label('Tissue');
model.material('mat2').selection.set([2 3 5 6]);
model.material('mat2').propertyGroup('def').set('density', {'rho_tissue'});
model.material('mat2').propertyGroup('def').set('soundspeed', {'c_tissue'});
model.material('mat2').propertyGroup.create('AttenuationDissipationModel', 'Attenuation_and_dissipation_model');
model.material('mat2').propertyGroup('AttenuationDissipationModel').set('delta_diff', {'delta_tissue'});
model.material('mat2').propertyGroup.create('NonlinearModel', 'Nonlinear_model');
model.material('mat2').propertyGroup('NonlinearModel').set('BA', {'BA_tissue'});

model.mesh('mesh1').create('ftri1', 'FreeTri');
model.mesh('mesh1').feature('ftri1').create('size1', 'Size');
model.mesh('mesh1').feature('ftri1').feature('size1').selection.geom('geom1', 2);
model.mesh('mesh1').feature('ftri1').feature('size1').selection.set([1 4]);
model.mesh('mesh1').feature('ftri1').feature('size1').set('custom', true);
model.mesh('mesh1').feature('ftri1').feature('size1').set('hmaxactive', true);
model.mesh('mesh1').feature('ftri1').feature('size1').set('hmax', 'c_water/f0/1.5');
model.mesh('mesh1').feature('ftri1').create('size2', 'Size');
model.mesh('mesh1').feature('ftri1').feature('size2').selection.geom('geom1', 2);
model.mesh('mesh1').feature('ftri1').feature('size2').selection.set([2 3 5 6]);
model.mesh('mesh1').feature('ftri1').feature('size2').set('custom', true);
model.mesh('mesh1').feature('ftri1').feature('size2').set('hmaxactive', true);
model.mesh('mesh1').feature('ftri1').feature('size2').set('hmax', 'c_tissue/f0/1.5');
model.mesh('mesh1').run;

model.study('std1').feature('time').set('tlist', 'range(0, T0, 55*T0)');
model.study('std1').feature('time').set('timeadaption', 'adaption');
model.study('std1').feature('time').set('rmethod', 'modify');

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
model.sol('sol1').feature('t1').set('tlist', 'range(0, T0, 55*T0)');
model.sol('sol1').feature('t1').set('plot', 'off');
model.sol('sol1').feature('t1').set('plotgroup', 'pg1');
model.sol('sol1').feature('t1').set('plotfreq', 'tout');
model.sol('sol1').feature('t1').set('probesel', 'all');
model.sol('sol1').feature('t1').set('probes', {'pdom1' 'pdom2'});
model.sol('sol1').feature('t1').set('probefreq', 'tsteps');
model.sol('sol1').feature('t1').set('exprs', {'root.comp1.nate.wtc' 'root.comp1.nate.wtc'});
model.sol('sol1').feature('t1').set('tstepping', 'elemexprs');
model.sol('sol1').feature('t1').set('control', 'time');
model.sol('sol1').feature('t1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('t1').feature('fc1').set('linsolver', 'dDef');
model.sol('sol1').feature('t1').feature.remove('fcDef');
model.sol('sol1').attach('std1');
model.sol('sol1').feature('t1').set('timemethodexp', 'ab3loc');
model.sol('sol1').feature('t1').set('updtlvl', 'factor');
model.sol('sol1').feature('t1').feature('taDef').set('allowcoarsening', false);
model.sol('sol1').feature('t1').feature('taDef').setIndex('eefunctime', 'sqrt(comp1.pr^2+comp1.pz^2)', 0);
model.sol.create('sol2');
model.sol('sol2').label('Refined Mesh Solution 1');
model.sol('sol2').study('std1');
model.sol('sol2').setClusterStorage('all');
model.sol('sol1').feature('t1').feature('taDef').set('tadapsol', 'sol2');

model.probe('pdom1').genResult('none');
model.probe('pdom2').genResult('none');

model.sol('sol1').runAll;

model.result.create('pg3', 'PlotGroup2D');
model.result('pg3').label('Acoustic Pressure (nate)');
model.result('pg3').set('data', 'dset2');
model.result('pg3').setIndex('looplevel', 70, 0);
model.result('pg3').set('dataisaxisym', 'off');
model.result('pg3').set('showlegendsunit', true);
model.result('pg3').set('data', 'dset2');
model.result('pg3').setIndex('looplevel', 70, 0);
model.result('pg3').set('defaultPlotID', 'pressureacoustics/NonlinearPressureAcousticsTimeExplicit/phys1/pdef1/pcond3/pg4');
model.result('pg3').feature.create('surf1', 'Surface');
model.result('pg3').feature('surf1').label('Surface');
model.result('pg3').feature('surf1').set('colortable', 'Wave');
model.result('pg3').feature('surf1').set('colorscalemode', 'linearsymmetric');
model.result('pg3').feature('surf1').set('resolution', 'custom');
model.result('pg3').feature('surf1').set('refine', 6);
model.result('pg3').feature('surf1').set('smooth', 'internal');
model.result('pg3').feature('surf1').set('data', 'parent');
model.result.create('pg4', 'PlotGroup2D');
model.result('pg4').label('In-Plane Acoustic Velocity (nate)');
model.result('pg4').set('data', 'dset2');
model.result('pg4').setIndex('looplevel', 70, 0);
model.result('pg4').set('dataisaxisym', 'off');
model.result('pg4').set('showlegendsunit', true);
model.result('pg4').set('data', 'dset2');
model.result('pg4').setIndex('looplevel', 70, 0);
model.result('pg4').set('defaultPlotID', 'pressureacoustics/NonlinearPressureAcousticsTimeExplicit/phys1/pdef1/pcond3/pg5');
model.result('pg4').feature.create('surf1', 'Surface');
model.result('pg4').feature('surf1').label('Surface');
model.result('pg4').feature('surf1').set('expr', 'nate.v_inst');
model.result('pg4').feature('surf1').set('resolution', 'custom');
model.result('pg4').feature('surf1').set('refine', 6);
model.result('pg4').feature('surf1').set('smooth', 'internal');
model.result('pg4').feature('surf1').set('data', 'parent');
model.result('pg4').feature.create('arws1', 'ArrowSurface');
model.result('pg4').feature('arws1').label('Arrow Surface');
model.result('pg4').feature('arws1').set('color', 'white');
model.result('pg4').feature('arws1').set('data', 'parent');
model.result('pg3').run;
model.result('pg2').set('window', 'window1');
model.result('pg2').run;
model.result('pg2').label('Relative Pressure Probes');
model.result('pg2').set('titletype', 'label');
model.result('pg2').set('legendpos', 'upperleft');
model.result('pg2').set('window', 'window1');
model.result('pg2').run;
model.result('pg2').set('window', 'window1');
model.result('pg2').run;
model.result('pg2').set('window', 'window1');
model.result('pg2').run;
model.result.duplicate('pg5', 'pg2');
model.result('pg5').set('window', 'window1');
model.result('pg5').run;
model.result('pg5').label('Relative Pressure Probes, Frequency Spectrum');
model.result('pg5').set('legendpos', 'upperright');
model.result('pg5').set('window', 'window1');
model.result('pg5').run;
model.result('pg5').feature('tblp1').set('transform', 'fourier');
model.result('pg5').feature('tblp1').set('fouriershow', 'spectrum');
model.result('pg5').feature('tblp1').set('scale', 'multiplyperiod');
model.result('pg5').feature('tblp1').set('freqrangeactive', true);
model.result('pg5').feature('tblp1').set('freqmax', '5*f0');
model.result('pg5').set('window', 'window1');
model.result('pg5').run;
model.result.create('pg6', 'PlotGroup1D');
model.result('pg6').run;
model.result('pg6').label('On-Axis Relative Pressure');
model.result('pg6').set('data', 'dset2');
model.result('pg6').setIndex('looplevelinput', 'manual', 0);
model.result('pg6').setIndex('looplevel', [53], 0);
model.result('pg6').set('titletype', 'label');
model.result('pg6').create('lngr1', 'LineGraph');
model.result('pg6').feature('lngr1').set('markerpos', 'datapoints');
model.result('pg6').feature('lngr1').set('linewidth', 'preference');
model.result('pg6').feature('lngr1').selection.set([1 2]);
model.result('pg6').feature('lngr1').set('expr', 'nate.p_t/P0');
model.result('pg6').feature('lngr1').set('xdata', 'expr');
model.result('pg6').feature('lngr1').set('xdataexpr', 'z/F');
model.result('pg6').run;
model.result.create('pg7', 'PlotGroup1D');
model.result('pg7').run;
model.result('pg7').label('Normalized Positive and Negative Pressure');
model.result('pg7').set('data', 'dset2');
model.result('pg7').setIndex('looplevelinput', 'last', 0);
model.result('pg7').create('lngr1', 'LineGraph');
model.result('pg7').feature('lngr1').set('markerpos', 'datapoints');
model.result('pg7').feature('lngr1').set('linewidth', 'preference');
model.result('pg7').feature('lngr1').selection.set([2]);
model.result('pg7').feature('lngr1').set('expr', 'nate.p_max');
model.result('pg7').feature('lngr1').set('descr', 'Maximum acoustic pressure');
model.result('pg7').feature('lngr1').set('expr', 'nate.p_max/at1(0, F, nate.p_max)');
model.result('pg7').feature('lngr1').set('xdata', 'expr');
model.result('pg7').feature('lngr1').set('xdataexpr', 'z/F');
model.result('pg7').feature('lngr1').set('legend', true);
model.result('pg7').feature('lngr1').set('legendmethod', 'manual');
model.result('pg7').feature('lngr1').setIndex('legends', 'p<sup>+</sup>/p<sub>max</sub>', 0);
model.result('pg7').feature('lngr1').set('resolution', 'norefine');
model.result('pg7').feature.duplicate('lngr2', 'lngr1');
model.result('pg7').run;
model.result('pg7').feature('lngr2').set('expr', 'nate.p_min');
model.result('pg7').feature('lngr2').set('descr', 'Minimum acoustic pressure');
model.result('pg7').feature('lngr2').set('expr', '-nate.p_min/at1(0, F, nate.p_max)');
model.result('pg7').feature('lngr2').setIndex('legends', '-p<sup>-</sup>/p<sub>max</sub>', 0);
model.result('pg7').run;
model.result.create('pg8', 'PlotGroup2D');
model.result('pg8').run;
model.result('pg8').set('data', 'dset2');
model.result('pg8').stepLast(0);
model.result('pg8').run;
model.result('pg8').label('Cell Wave Time Scale');
model.result('pg8').create('surf1', 'Surface');
model.result('pg8').feature('surf1').set('expr', 'nate.wtc');
model.result('pg8').feature('surf1').set('descr', 'Cell wave time scale');
model.result('pg8').feature('surf1').set('resolution', 'norefine');
model.result('pg8').feature('surf1').set('smooth', 'none');
model.result('pg8').run;
model.result('pg8').run;
model.result('pg8').set('looplevel', [14]);
model.result('pg8').run;
model.result('pg8').set('looplevel', [27]);
model.result('pg8').run;
model.result('pg8').set('looplevel', [40]);
model.result('pg8').run;
model.result('pg8').set('looplevel', [53]);
model.result('pg8').run;
model.result('pg8').stepLast(0);
model.result('pg8').run;
model.result('pg3').run;
model.result('pg3').set('looplevel', [14]);
model.result('pg3').run;
model.result('pg3').set('looplevel', [27]);
model.result('pg3').run;
model.result('pg3').set('looplevel', [40]);
model.result('pg3').run;
model.result('pg3').set('looplevel', [53]);
model.result('pg3').run;
model.result('pg3').stepLast(0);
model.result('pg3').run;

model.title('High-Intensity Focused Ultrasound (HIFU) Propagation Through a Tissue Phantom');

model.description(['This tutorial studies the propagation of high intensity focused ultrasound (HIFU) though a tissue phantom. HIFU is used in many different biomedical applications such as thermal ablation of tumors, transcranial HIFU surgery, shock wave lithotripsy, etc. A HIFU transducer typically contains a focusing lens that makes the emitted ultrasonic signal reach the highest intensity within a focal zone. When the emitted signal has a sufficiently high amplitude, nonlinear effects become significant, which results in the generation of the higher-order harmonics during the propagation of the signal.' newline  newline 'The nonlinear propagation of a HIFU signal is modeled using the Nonlinear Pressure Acoustics, Time Explicit physics interface. In this example, the signal amplitude at the source location is enough for the generation of higher-order harmonics, but not high enough for the formation of shocks. The emitted signal is a tone burst pulse that occupies only a limited part of the computational domain on its way. Adaptive Mesh Refinement is used for automatic remeshing following the signal propagation. The mesh is fine enough to resolve the higher-order harmonics where it is required.']);

model.mesh.clearMeshes;

model.sol('sol1').clearSolutionData;
model.sol('sol2').clearSolutionData;

model.label('hifu_tissue_sample.mph');

model.modelNode.label('Components');

out = model;
