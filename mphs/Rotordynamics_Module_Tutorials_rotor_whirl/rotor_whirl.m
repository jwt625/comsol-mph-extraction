function out = model
%
% rotor_whirl.m
%
% Model exported on May 26 2025, 21:33 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/Rotordynamics_Module/Tutorials');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 3);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.physics.create('rotbm', 'BeamRotor', 'geom1');
model.physics('rotbm').model('comp1');
model.physics.create('hdb', 'HydrodynamicBearing', 'geom1');
model.physics('hdb').model('comp1');

model.multiphysics.create('brbc1', 'BeamRotorBearingCoupling', 'geom1', 2);
model.multiphysics('brbc1').set('BeamRotor_physics', 'rotbm');
model.multiphysics('brbc1').set('Bearing_physics', 'hdb');
model.multiphysics('brbc1').selection.all;

model.study.create('std1');
model.study('std1').create('time', 'Transient');
model.study('std1').feature('time').setSolveFor('/physics/rotbm', true);
model.study('std1').feature('time').setSolveFor('/physics/hdb', true);
model.study('std1').feature('time').setSolveFor('/multiphysics/brbc1', true);

model.param.set('L', '1.3[m]');
model.param.descr('L', 'Length of the rotor');
model.param.set('D', '0.1[m]');
model.param.descr('D', 'Diameter of the rotor');
model.param.set('E0', '2.05E11[Pa]');
model.param.descr('E0', 'Young''s modulus');
model.param.set('rho0', '7800 [kg/m^3]');
model.param.descr('rho0', 'Density');
model.param.set('nu0', '0.3');
model.param.descr('nu0', 'Poisson''s ratio');
model.param.set('Lj', '0.025[m]');
model.param.descr('Lj', 'Length of the bearing');
model.param.set('C', '5e-5[m]');
model.param.descr('C', 'Clearance');
model.param.set('mu0', '0.072[Pa*s]');
model.param.descr('mu0', 'Viscosity');
model.param.set('Ow', '9000[rpm]');
model.param.descr('Ow', 'Angular speed');

model.geom('geom1').create('pol1', 'Polygon');
model.geom('geom1').feature('pol1').set('source', 'vectors');
model.geom('geom1').feature('pol1').set('x', '0 L');
model.geom('geom1').feature('pol1').set('y', 0);
model.geom('geom1').feature('pol1').set('z', 0);
model.geom('geom1').run('pol1');
model.geom('geom1').create('cyl1', 'Cylinder');
model.geom('geom1').feature('cyl1').set('type', 'surface');
model.geom('geom1').feature('cyl1').set('r', 'D/2');
model.geom('geom1').feature('cyl1').set('h', 'Lj');
model.geom('geom1').feature('cyl1').set('axistype', 'x');
model.geom('geom1').feature.duplicate('cyl2', 'cyl1');
model.geom('geom1').feature('cyl2').set('pos', {'L-Lj' '0' '0'});
model.geom('geom1').runPre('fin');
model.geom('geom1').run;

model.material.create('mat1', 'Common', 'comp1');
model.material('mat1').selection.geom('geom1', 1);
model.material('mat1').selection.all;
model.material('mat1').propertyGroup('def').set('density', '');
model.material('mat1').propertyGroup('def').set('poissonsratio', '');
model.material('mat1').propertyGroup('def').set('youngsmodulus', '');
model.material('mat1').propertyGroup('def').set('density', {'rho0'});
model.material('mat1').propertyGroup('def').set('poissonsratio', {'nu0'});
model.material('mat1').propertyGroup('def').set('youngsmodulus', {'E0'});

model.physics('rotbm').selection.set([6]);
model.physics('rotbm').prop('RotorProperties').set('rpt', 'Ow');
model.physics('rotbm').feature('rcs1').set('do_circ', 'D');
model.physics('rotbm').create('gr1', 'Gravity', 1);
model.physics('hdb').prop('EquationType').set('EquationType', 'ReynoldsEquationWithCavitation');
model.physics('hdb').feature('hjb1').set('C_plain', 'C');
model.physics('hdb').feature('hjb1').set('BearingCenterType', 'fromGeom');
model.physics('hdb').feature('hjb1').set('mure_mat', 'userdef');
model.physics('hdb').feature('hjb1').set('mure', 'mu0');

model.mesh('mesh1').create('edg1', 'Edge');
model.mesh('mesh1').feature('edg1').label('Beam Rotor');
model.mesh('mesh1').feature('edg1').selection.set([6]);
model.mesh('mesh1').feature('edg1').create('dis1', 'Distribution');
model.mesh('mesh1').feature('edg1').feature('dis1').set('numelem', 150);
model.mesh('mesh1').create('map1', 'Map');
model.mesh('mesh1').feature('map1').label('Bearing');
model.mesh('mesh1').feature('map1').selection.set([1 2 3 4 5 6 7 8]);
model.mesh('mesh1').feature('map1').create('dis1', 'Distribution');
model.mesh('mesh1').feature('map1').feature('dis1').selection.set([1 2 4 7 14 15 17 19]);
model.mesh('mesh1').feature('map1').feature('dis1').set('numelem', 20);
model.mesh('mesh1').feature('map1').create('dis2', 'Distribution');
model.mesh('mesh1').feature('map1').feature('dis2').selection.set([8 20]);
model.mesh('mesh1').feature('map1').feature('dis2').set('numelem', 3);
model.mesh('mesh1').run;

model.study('std1').feature('time').set('tlist', 'range(0,5e-4,0.2)');

model.sol.create('sol1');
model.sol('sol1').study('std1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'time');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').feature('comp1_pfilm').set('scalemethod', 'manual');
model.sol('sol1').feature('v1').feature('comp1_rotbm_phi').set('scalemethod', 'manual');
model.sol('sol1').feature('v1').feature('comp1_u').set('scalemethod', 'manual');
model.sol('sol1').feature('v1').feature('comp1_pfilm').set('resscalemethod', 'parent');
model.sol('sol1').feature('v1').feature('comp1_pfilm').set('scaleval', '1000000');
model.sol('sol1').feature('v1').feature('comp1_rotbm_phi').set('scaleval', '1e-2');
model.sol('sol1').feature('v1').feature('comp1_u').set('scaleval', '1e-2*1.3076696830622023');
model.sol('sol1').feature('v1').set('control', 'time');
model.sol('sol1').create('t1', 'Time');
model.sol('sol1').feature('t1').set('tlist', 'range(0,5e-4,0.2)');
model.sol('sol1').feature('t1').set('plot', 'off');
model.sol('sol1').feature('t1').set('plotgroup', 'Default');
model.sol('sol1').feature('t1').set('plotfreq', 'tout');
model.sol('sol1').feature('t1').set('probesel', 'all');
model.sol('sol1').feature('t1').set('probes', {});
model.sol('sol1').feature('t1').set('probefreq', 'tsteps');
model.sol('sol1').feature('t1').set('rtol', 0.001);
model.sol('sol1').feature('t1').set('atolglobalvaluemethod', 'factor');
model.sol('sol1').feature('t1').set('reacf', true);
model.sol('sol1').feature('t1').set('storeudot', true);
model.sol('sol1').feature('t1').set('tstepsgenalpha', 'intermediate');
model.sol('sol1').feature('t1').set('endtimeinterpolation', true);
model.sol('sol1').feature('t1').set('timemethod', 'genalpha');
model.sol('sol1').feature('t1').set('rhoinf', 0.75);
model.sol('sol1').feature('t1').set('rescaleafterinitbw', false);
model.sol('sol1').feature('t1').set('bwinitstepfrac', '0.001');
model.sol('sol1').feature('t1').set('control', 'time');
model.sol('sol1').feature('t1').create('seDef', 'Segregated');
model.sol('sol1').feature('t1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('t1').feature('fc1').set('jtech', 'once');
model.sol('sol1').feature('t1').feature('fc1').set('linsolver', 'dDef');
model.sol('sol1').feature('t1').feature('fc1').set('jtech', 'once');
model.sol('sol1').feature('t1').feature.remove('fcDef');
model.sol('sol1').feature('t1').feature.remove('seDef');
model.sol('sol1').attach('std1');
model.sol('sol1').feature('v1').feature('comp1_pfilm').set('scaleval', '1.0e5');
model.sol('sol1').feature('t1').feature('fc1').set('jtech', 'minimal');
model.sol('sol1').runAll;

model.result.create('pg1', 'PlotGroup3D');
model.result('pg1').set('data', 'dset1');
model.result('pg1').setIndex('looplevel', 401, 0);
model.result('pg1').set('defaultPlotID', 'stress');
model.result('pg1').create('line1', 'Line');
model.result('pg1').feature('line1').set('expr', {'rotbm.mises'});
model.result('pg1').feature('line1').set('threshold', 'manual');
model.result('pg1').feature('line1').set('thresholdvalue', 0.2);
model.result('pg1').feature('line1').set('colortable', 'Rainbow');
model.result('pg1').feature('line1').set('colortabletrans', 'none');
model.result('pg1').feature('line1').set('colorscalemode', 'linear');
model.result('pg1').label('Stress (rotbm)');
model.result('pg1').feature('line1').set('colortable', 'Rainbow');
model.result('pg1').feature('line1').set('linetype', 'tube');
model.result('pg1').feature('line1').set('radiusexpr', 'rotbm.re');
model.result('pg1').feature('line1').set('tuberadiusscaleactive', true);
model.result('pg1').feature('line1').set('tuberadiusscale', 1);
model.result('pg1').feature('line1').set('tubeendcaps', false);
model.result('pg1').feature('line1').create('def', 'Deform');
model.result('pg1').feature('line1').feature('def').set('expr', {'u' 'v' 'w'});
model.result('pg1').feature('line1').feature('def').set('descr', 'Displacement field');
model.result.create('pg2', 'PlotGroup3D');
model.result('pg2').label('Fluid Pressure (hdb)');
model.result('pg2').set('data', 'dset1');
model.result('pg2').setIndex('looplevel', 401, 0);
model.result('pg2').set('defaultPlotID', 'fluidPressure');
model.result('pg2').feature.create('surf1', 'Surface');
model.result('pg2').feature('surf1').set('expr', 'pfilm');
model.result('pg2').feature('surf1').set('colortable', 'RainbowLight');
model.result('pg2').feature('surf1').set('smooth', 'internal');
model.result('pg2').feature('surf1').set('data', 'parent');
model.result('pg2').feature.create('con1', 'Contour');
model.result('pg2').feature('con1').set('expr', 'pfilm');
model.result('pg2').feature('con1').set('levelrounding', false);
model.result('pg2').feature('con1').set('colorlegend', false);
model.result('pg2').feature('con1').set('smooth', 'internal');
model.result('pg2').feature('con1').set('inherittubescale', false);
model.result('pg2').feature('con1').set('data', 'parent');
model.result('pg2').feature('con1').set('inheritplot', 'surf1');
model.result('pg1').run;
model.result('pg1').set('titletype', 'manual');
model.result('pg1').set('title', 'von Mises stress (N/m<sup>2</sup>)');
model.result.dataset.duplicate('dset2', 'dset1');
model.result.dataset('dset2').selection.geom('geom1', 2);
model.result.dataset('dset2').selection.geom('geom1', 2);
model.result.dataset('dset2').selection.set([1 2 3 4]);
model.result('pg2').run;
model.result('pg2').set('data', 'dset2');
model.result('pg2').set('titletype', 'manual');
model.result('pg2').set('title', 'Pressure (Pa)');
model.result('pg2').set('view', 'new');
model.result('pg2').run;
model.result.create('pg3', 'PlotGroup1D');
model.result('pg3').run;
model.result('pg3').label('Orbit');
model.result('pg3').create('ptgr1', 'PointGraph');
model.result('pg3').feature('ptgr1').set('markerpos', 'datapoints');
model.result('pg3').feature('ptgr1').set('linewidth', 'preference');
model.result('pg3').feature('ptgr1').selection.set([3]);
model.result('pg3').feature('ptgr1').set('expr', 'w/C');
model.result('pg3').feature('ptgr1').set('xdata', 'expr');
model.result('pg3').feature('ptgr1').set('xdataexpr', 'v/C');
model.result('pg3').feature('ptgr1').set('linecolor', 'magenta');
model.result('pg3').run;
model.result('pg3').set('titletype', 'manual');
model.result('pg3').set('title', 'Orbit of the journal at the left bearing');
model.result('pg3').set('preserveaspect', true);
model.result('pg3').run;
model.result.create('pg4', 'PlotGroup1D');
model.result('pg4').run;
model.result('pg4').label('Acceleration vs. Time');
model.result('pg4').create('ptgr1', 'PointGraph');
model.result('pg4').feature('ptgr1').set('markerpos', 'datapoints');
model.result('pg4').feature('ptgr1').set('linewidth', 'preference');
model.result('pg4').feature('ptgr1').label('y Acceleration');
model.result('pg4').feature('ptgr1').selection.set([3]);
model.result('pg4').feature('ptgr1').set('expr', 'vtt');
model.result('pg4').feature('ptgr1').set('titletype', 'manual');
model.result('pg4').feature('ptgr1').set('linewidth', 3);
model.result('pg4').feature('ptgr1').set('legend', true);
model.result('pg4').feature('ptgr1').set('autopoint', false);
model.result('pg4').feature('ptgr1').set('autosolution', false);
model.result('pg4').feature('ptgr1').set('autoplotlabel', true);
model.result('pg4').feature.duplicate('ptgr2', 'ptgr1');
model.result('pg4').run;
model.result('pg4').feature('ptgr2').label('z Acceleration');
model.result('pg4').feature('ptgr2').set('expr', 'wtt');
model.result('pg4').run;
model.result('pg4').set('ylabelactive', true);
model.result('pg4').set('ylabel', 'Acceleration (m/s<sup>2</sup>)');
model.result('pg4').set('legendpos', 'upperleft');
model.result('pg4').run;
model.result.duplicate('pg5', 'pg4');
model.result('pg5').run;
model.result('pg5').label('Acceleration Spectrum');
model.result('pg5').set('xlabelactive', true);
model.result('pg5').set('xlabel', 'Frequency (Hz)');
model.result('pg5').set('legendpos', 'upperright');
model.result('pg5').run;
model.result('pg5').feature('ptgr1').set('xdata', 'fourier');
model.result('pg5').feature('ptgr1').set('fouriershow', 'spectrum');
model.result('pg5').feature('ptgr1').set('scale', 'dividenfreq');
model.result('pg5').run;
model.result('pg5').feature('ptgr2').set('xdata', 'fourier');
model.result('pg5').feature('ptgr2').set('fouriershow', 'spectrum');
model.result('pg5').feature('ptgr2').set('scale', 'dividenfreq');
model.result('pg5').run;
model.result('pg3').run;

model.title('Whirling of Uniform Shaft Under Gravity');

model.description(['The Whirling of a Uniform Shaft tutorial model shows you how to perform a transient analysis of a uniform shaft under gravity. The shaft is supported by two hydrodynamic bearings at its ends. The gyroscopic effect causes the rotor to whirl about its initial axis, and the rotor eventually reaches a steady orbit.' newline  newline 'Results include the stress profile on the rotor with the maximum bending stress, the bearing fluid pressure, and the orbit of the journal. In the last result, the journal spirals outward to eventually reach a steady orbit.' newline  newline 'Also analyzed in this example is the frequency spectrum of the journal acceleration, which confirms that the half-frequency whirl is the dominant mode of whirling.']);

model.mesh.clearMeshes;

model.sol('sol1').clearSolutionData;

model.label('rotor_whirl.mph');

model.modelNode.label('Components');

out = model;
