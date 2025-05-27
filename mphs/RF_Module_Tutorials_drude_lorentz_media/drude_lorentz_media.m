function out = model
%
% drude_lorentz_media.m
%
% Model exported on May 26 2025, 21:32 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/RF_Module/Tutorials');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 2);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.physics.create('temw', 'TransientElectromagneticWaves', 'geom1');
model.physics('temw').model('comp1');

model.study.create('std1');
model.study('std1').create('time', 'Transient');
model.study('std1').feature('time').setSolveFor('/physics/temw', true);

model.param.set('lda0', '1[um]');
model.param.descr('lda0', 'Wavelength');
model.param.set('E0', '1[V/m]');
model.param.descr('E0', 'Electric field amplitude');
model.param.set('k0', '2*pi/lda0');
model.param.descr('k0', 'Wave number in vacuum');
model.param.set('t0', '25[fs]');
model.param.descr('t0', 'Time delay');
model.param.set('dt', '10[fs]');
model.param.descr('dt', 'Pulse duration');

model.variable.create('var1');
model.variable('var1').model('comp1');

model.geom('geom1').run;

model.variable('var1').set('omega0', '2*pi[rad]*c_const/lda0');
model.variable('var1').descr('omega0', 'Angular frequency');
model.variable('var1').set('E_bnd', 'E0*cos(omega0*t-k0*x)');
model.variable('var1').descr('E_bnd', 'Plane-wave factor for electric field');
model.variable('var1').set('E_pulse', 'exp(-(t-t0)^2/dt^2)');
model.variable('var1').descr('E_pulse', 'Temporal factor for electric field');
model.variable('var1').set('omega_p', '1.5*omega0');
model.variable('var1').descr('omega_p', 'Plasma frequency');
model.variable('var1').set('omega_1', '0.5*omega_p');
model.variable('var1').descr('omega_1', 'Resonance frequency');
model.variable('var1').set('gamma_1', '0.1*omega_1');
model.variable('var1').descr('gamma_1', 'Damping coefficient');

model.geom('geom1').create('r1', 'Rectangle');
model.geom('geom1').feature('r1').set('size', {'lda0' '6*lda0'});
model.geom('geom1').feature('r1').set('base', 'center');
model.geom('geom1').feature.duplicate('r2', 'r1');
model.geom('geom1').feature('r2').set('size', {'20*lda0' '6*lda0'});
model.geom('geom1').feature.duplicate('r3', 'r1');
model.geom('geom1').feature('r3').set('size', {'lda0' '0.5*lda0'});
model.geom('geom1').runPre('fin');

model.cpl.create('intop1', 'Integration', 'geom1');

model.geom('geom1').run;

model.cpl('intop1').set('axisym', true);
model.cpl('intop1').selection.geom('geom1', 0);
model.cpl('intop1').selection.set([2]);
model.cpl.create('intop2', 'Integration', 'geom1');
model.cpl('intop2').set('axisym', true);
model.cpl('intop2').selection.geom('geom1', 0);
model.cpl('intop2').selection.set([5]);
model.cpl.create('intop3', 'Integration', 'geom1');
model.cpl('intop3').set('axisym', true);
model.cpl('intop3').selection.geom('geom1', 0);
model.cpl('intop3').selection.set([9]);

model.physics('temw').prop('components').set('components', 'inplane');
model.physics('temw').feature('wee1').set('DisplacementFieldModel', 'DrudeLorentzDispersionModel');
model.physics('temw').feature('wee1').set('epsilonInf', [4 0 0 0 4 0 0 0 1]);
model.physics('temw').feature('wee1').set('omegap', 'omega_p');
model.physics('temw').feature('wee1').set('mur_mat', 'userdef');
model.physics('temw').feature('wee1').set('sigma_mat', 'userdef');
model.physics('temw').feature('wee1').create('dlp1', 'DrudeLorentzPolarization', 2);
model.physics('temw').feature('wee1').feature('dlp1').set('item.f', 1);
model.physics('temw').feature('wee1').feature('dlp1').set('item.omega0', 'omega_1');
model.physics('temw').feature('wee1').feature('dlp1').set('item.damp', 'gamma_1');
model.physics('temw').create('wee2', 'WaveEquationElectric', 2);
model.physics('temw').feature('wee2').selection.set([1 3 5]);
model.physics('temw').feature('wee2').set('epsilonr_mat', 'userdef');
model.physics('temw').feature('wee2').set('mur_mat', 'userdef');
model.physics('temw').feature('wee2').set('sigma_mat', 'userdef');
model.physics('temw').create('sctr1', 'Scattering', 1);
model.physics('temw').feature('sctr1').set('IncidentField', 'EField');
model.physics('temw').feature('sctr1').selection.set([1]);
model.physics('temw').feature('sctr1').set('E0i', {'0' 'E_pulse*E_bnd' '0'});
model.physics('temw').create('sctr2', 'Scattering', 1);
model.physics('temw').feature('sctr2').selection.set([16]);
model.physics('temw').create('pc1', 'PeriodicCondition', 1);
model.physics('temw').feature('pc1').selection.set([2 3 5 10 12 15]);

model.mesh('mesh1').create('edg1', 'Edge');
model.mesh('mesh1').feature('edg1').selection.set([3 10 15]);
model.mesh('mesh1').create('cpe1', 'CopyEdge');
model.mesh('mesh1').feature('cpe1').selection('source').geom(1);
model.mesh('mesh1').feature('cpe1').selection('destination').geom(1);
model.mesh('mesh1').feature('cpe1').selection('source').set([3 10 15]);
model.mesh('mesh1').feature('cpe1').selection('destination').set([2 5 12]);
model.mesh('mesh1').create('ftri1', 'FreeTri');
model.mesh('mesh1').feature('size').set('custom', true);
model.mesh('mesh1').feature('size').set('hmax', 'lda0/6');
model.mesh('mesh1').run;

model.study('std1').feature('time').set('tlist', 'range(0,10[fs],100[fs])');

model.sol.create('sol1');
model.sol('sol1').study('std1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'time');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').set('control', 'time');
model.sol('sol1').create('t1', 'Time');
model.sol('sol1').feature('t1').set('tlist', 'range(0,10[fs],100[fs])');
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
model.sol('sol1').feature('t1').set('endtimeinterpolation', true);
model.sol('sol1').feature('t1').set('timemethod', 'genalpha');
model.sol('sol1').feature('t1').set('control', 'time');
model.sol('sol1').feature('t1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('t1').create('d1', 'Direct');
model.sol('sol1').feature('t1').feature('d1').set('linsolver', 'pardiso');
model.sol('sol1').feature('t1').feature('d1').label('Suggested Direct Solver (temw)');
model.sol('sol1').feature('t1').feature('fc1').set('linsolver', 'd1');
model.sol('sol1').feature('t1').feature.remove('fcDef');
model.sol('sol1').attach('std1');
model.sol('sol1').feature('t1').set('tstepsgenalpha', 'manual');
model.sol('sol1').feature('t1').set('timestepgenalpha', '0.1[fs]');

model.probe.create('var1', 'GlobalVariable');
model.probe('var1').model('comp1');
model.probe('var1').set('expr', 'intop1(temw.Ey)');
model.probe.create('var2', 'GlobalVariable');
model.probe('var2').model('comp1');
model.probe('var2').set('expr', 'intop2(temw.Poscy)');
model.probe('var2').set('window', 'new');
model.probe.create('var3', 'GlobalVariable');
model.probe('var3').model('comp1');
model.probe('var3').set('expr', 'intop3(temw.Poscy)');
model.probe('var3').set('window', 'new');
model.probe('var1').genResult('none');
model.probe('var2').genResult('none');
model.probe('var3').genResult('none');

model.sol('sol1').runAll;

model.result.create('pg4', 'PlotGroup2D');
model.result('pg4').set('solvertype', 'none');
model.result('pg4').set('data', 'dset1');
model.result('pg4').setIndex('looplevel', 11, 0);
model.result('pg4').set('defaultPlotID', 'TransientElectromagneticWaves/phys1/pdef1/pcond2/pg1');
model.result('pg4').feature.create('surf1', 'Surface');
model.result('pg4').feature('surf1').set('showsolutionparams', 'on');
model.result('pg4').feature('surf1').set('solvertype', 'none');
model.result('pg4').feature('surf1').set('smooth', 'internal');
model.result('pg4').feature('surf1').set('showsolutionparams', 'on');
model.result('pg4').feature('surf1').set('solvertype', 'none');
model.result('pg4').feature('surf1').set('showsolutionparams', 'on');
model.result('pg4').feature('surf1').set('solvertype', 'none');
model.result('pg4').feature('surf1').set('showsolutionparams', 'on');
model.result('pg4').feature('surf1').set('solvertype', 'none');
model.result('pg4').feature('surf1').set('showsolutionparams', 'on');
model.result('pg4').feature('surf1').set('solvertype', 'none');
model.result('pg4').feature('surf1').set('data', 'parent');
model.result('pg4').run;
model.result('pg4').run;
model.result('pg4').feature('surf1').set('expr', 'temw.Poscy');
model.result('pg4').run;
model.result('pg1').set('window', 'window1');
model.result('pg1').run;
model.result('pg2').set('window', 'window2');
model.result('pg2').set('windowtitle', 'Probe Plot 2');
model.result('pg2').run;
model.result('pg3').set('window', 'window3');
model.result('pg3').set('windowtitle', 'Probe Plot 3');
model.result('pg3').run;
model.result.create('pg5', 'PlotGroup2D');
model.result('pg5').run;
model.result('pg5').create('surf1', 'Surface');
model.result('pg5').feature('surf1').set('expr', 'temw.Hz');
model.result('pg5').feature('surf1').set('colortable', 'Cyclic');
model.result('pg5').run;
model.result('pg5').create('con1', 'Contour');
model.result('pg5').feature('con1').set('expr', 'temw.Poscy');
model.result('pg5').run;

model.title(['Time-Domain Modeling of Dispersive Drude' native2unicode(hex2dec({'20' '13'}), 'unicode') 'Lorentz Media']);

model.description(['Plasmonic hole arrays can exhibit large transmission also for holes smaller than the wavelength. This has been attributed to the existence of surface plasmon polaritons, which can tunnel electromagnetic energy through the hole even if it is much smaller than the wavelength.' newline  newline 'This example is intended as a tutorial that shows how to model the full time-dependent wave equation in a dispersive medium, where the polarization can be expressed as a sum of Drude' native2unicode(hex2dec({'20' '13'}), 'unicode') 'Lorentz resonant terms. Each Drude' native2unicode(hex2dec({'20' '13'}), 'unicode') 'Lorentz polarization field is solved using an ordinary differential equation, driven by the electric field.' newline  newline 'The 2D geometry consists of a single dispersive slab of thickness 1' native2unicode(hex2dec({'00' 'b5'}), 'unicode') 'm with a slit of width 0.5' native2unicode(hex2dec({'00' 'b5'}), 'unicode') 'm in it. The wavelength used is 1' native2unicode(hex2dec({'00' 'b5'}), 'unicode') 'm. Periodic boundary conditions are applied, thus physically this is an array of slits. The incoming wave is a plane wave pulse with flat front and a Gaussian temporal shape.']);

model.mesh.clearMeshes;

model.sol('sol1').clearSolutionData;

model.label('drude_lorentz_media.mph');

model.modelNode.label('Components');

out = model;
