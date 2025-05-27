function out = model
%
% second_harmonic_generation.m
%
% Model exported on May 26 2025, 21:34 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/Wave_Optics_Module/Nonlinear_Optics');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 2);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.physics.create('ewt', 'ElectromagneticWavesTransient', 'geom1');
model.physics('ewt').model('comp1');

model.study.create('std1');
model.study('std1').create('time', 'Transient');
model.study('std1').feature('time').setSolveFor('/physics/ewt', true);

model.geom('geom1').lengthUnit([native2unicode(hex2dec({'00' 'b5'}), 'unicode') 'm']);

model.param.set('w0', '2[um]');
model.param.descr('w0', 'Minimum spot radius of laser beam');
model.param.set('lda0', '1.06[um]');
model.param.descr('lda0', 'Wavelength of input laser beam');
model.param.set('E0', '30[kV/m]');
model.param.descr('E0', 'Peak electric field');
model.param.set('x0', 'pi*w0^2/lda0');
model.param.descr('x0', 'Rayleigh range');
model.param.set('k0', '2*pi/lda0');
model.param.descr('k0', 'Propagation constant');
model.param.set('omega0', 'k0*c_const');
model.param.descr('omega0', 'Angular frequency');
model.param.set('t0', '25[fs]');
model.param.descr('t0', 'Pulse time delay');
model.param.set('dt', '10[fs]');
model.param.descr('dt', 'Pulse width');
model.param.set('d33', '1e-17[F/V]');
model.param.descr('d33', 'Matrix element for second harmonic generation');
model.param.set('lda2', 'lda0/2');
model.param.descr('lda2', 'Wavelength for second harmonic');
model.param.set('hmax', 'lda2/6');
model.param.descr('hmax', 'Maximum mesh element size');
model.param.set('CFL', '0.15');
model.param.descr('CFL', 'CFL number');
model.param.set('tstep', 'CFL*hmax/c_const');
model.param.descr('tstep', 'Time step');

model.func.create('an1', 'Analytic');
model.func('an1').set('funcname', 'w');
model.func('an1').set('expr', 'w0*sqrt(1+(x/x0)^2)');
model.func('an1').setIndex('argunit', 'm', 0);
model.func('an1').set('fununit', 'm');
model.func.create('an2', 'Analytic');
model.func('an2').set('funcname', 'eta');
model.func('an2').set('expr', 'atan2(x,x0)/2');
model.func('an2').setIndex('argunit', 'm', 0);
model.func('an2').set('fununit', 'rad');
model.func.create('an3', 'Analytic');
model.func('an3').set('funcname', 'R');
model.func('an3').set('expr', 'x*(1+(x0/x)^2)');
model.func('an3').setIndex('argunit', 'm', 0);
model.func('an3').set('fununit', 'm');

model.geom('geom1').create('r1', 'Rectangle');
model.geom('geom1').feature('r1').set('size', [20 6]);
model.geom('geom1').feature('r1').set('pos', [-10 -6]);
model.geom('geom1').runPre('fin');
model.geom('geom1').run;

model.material.create('mat1', 'Common', 'comp1');
model.material('mat1').propertyGroup('def').func.create('eta', 'Piecewise');
model.material('mat1').propertyGroup('def').func.create('Cp', 'Piecewise');
model.material('mat1').propertyGroup('def').func.create('rho', 'Analytic');
model.material('mat1').propertyGroup('def').func.create('k', 'Piecewise');
model.material('mat1').propertyGroup('def').func.create('cs', 'Analytic');
model.material('mat1').propertyGroup('def').func.create('an1', 'Analytic');
model.material('mat1').propertyGroup('def').func.create('an2', 'Analytic');
model.material('mat1').propertyGroup.create('RefractiveIndex', 'Refractive index');
model.material('mat1').propertyGroup.create('NonlinearModel', 'Nonlinear model');
model.material('mat1').propertyGroup.create('idealGas', 'Ideal gas');
model.material('mat1').propertyGroup('idealGas').func.create('Cp', 'Piecewise');
model.material('mat1').label('Air');
model.material('mat1').set('family', 'air');
model.material('mat1').propertyGroup('def').func('eta').set('arg', 'T');
model.material('mat1').propertyGroup('def').func('eta').set('pieces', {'200.0' '1600.0' '-8.38278E-7+8.35717342E-8*T^1-7.69429583E-11*T^2+4.6437266E-14*T^3-1.06585607E-17*T^4'});
model.material('mat1').propertyGroup('def').func('eta').set('argunit', 'K');
model.material('mat1').propertyGroup('def').func('eta').set('fununit', 'Pa*s');
model.material('mat1').propertyGroup('def').func('Cp').set('arg', 'T');
model.material('mat1').propertyGroup('def').func('Cp').set('pieces', {'200.0' '1600.0' '1047.63657-0.372589265*T^1+9.45304214E-4*T^2-6.02409443E-7*T^3+1.2858961E-10*T^4'});
model.material('mat1').propertyGroup('def').func('Cp').set('argunit', 'K');
model.material('mat1').propertyGroup('def').func('Cp').set('fununit', 'J/(kg*K)');
model.material('mat1').propertyGroup('def').func('rho').set('expr', 'pA*0.02897/R_const[K*mol/J]/T');
model.material('mat1').propertyGroup('def').func('rho').set('args', {'pA' 'T'});
model.material('mat1').propertyGroup('def').func('rho').set('fununit', 'kg/m^3');
model.material('mat1').propertyGroup('def').func('rho').set('argunit', {'Pa' 'K'});
model.material('mat1').propertyGroup('def').func('rho').set('plotaxis', {'off' 'on'});
model.material('mat1').propertyGroup('def').func('rho').set('plotfixedvalue', {'101325' '273.15'});
model.material('mat1').propertyGroup('def').func('rho').set('plotargs', {'pA' '101325' '101325'; 'T' '273.15' '293.15'});
model.material('mat1').propertyGroup('def').func('k').set('arg', 'T');
model.material('mat1').propertyGroup('def').func('k').set('pieces', {'200.0' '1600.0' '-0.00227583562+1.15480022E-4*T^1-7.90252856E-8*T^2+4.11702505E-11*T^3-7.43864331E-15*T^4'});
model.material('mat1').propertyGroup('def').func('k').set('argunit', 'K');
model.material('mat1').propertyGroup('def').func('k').set('fununit', 'W/(m*K)');
model.material('mat1').propertyGroup('def').func('cs').set('expr', 'sqrt(1.4*R_const[K*mol/J]/0.02897*T)');
model.material('mat1').propertyGroup('def').func('cs').set('args', {'T'});
model.material('mat1').propertyGroup('def').func('cs').set('fununit', 'm/s');
model.material('mat1').propertyGroup('def').func('cs').set('argunit', {'K'});
model.material('mat1').propertyGroup('def').func('cs').set('plotfixedvalue', {'273.15'});
model.material('mat1').propertyGroup('def').func('cs').set('plotargs', {'T' '273.15' '373.15'});
model.material('mat1').propertyGroup('def').func('an1').set('funcname', 'alpha_p');
model.material('mat1').propertyGroup('def').func('an1').set('expr', '-1/rho(pA,T)*d(rho(pA,T),T)');
model.material('mat1').propertyGroup('def').func('an1').set('args', {'pA' 'T'});
model.material('mat1').propertyGroup('def').func('an1').set('fununit', '1/K');
model.material('mat1').propertyGroup('def').func('an1').set('argunit', {'Pa' 'K'});
model.material('mat1').propertyGroup('def').func('an1').set('plotaxis', {'off' 'on'});
model.material('mat1').propertyGroup('def').func('an1').set('plotfixedvalue', {'101325' '273.15'});
model.material('mat1').propertyGroup('def').func('an1').set('plotargs', {'pA' '101325' '101325'; 'T' '273.15' '373.15'});
model.material('mat1').propertyGroup('def').func('an2').set('funcname', 'muB');
model.material('mat1').propertyGroup('def').func('an2').set('expr', '0.6*eta(T)');
model.material('mat1').propertyGroup('def').func('an2').set('args', {'T'});
model.material('mat1').propertyGroup('def').func('an2').set('fununit', 'Pa*s');
model.material('mat1').propertyGroup('def').func('an2').set('argunit', {'K'});
model.material('mat1').propertyGroup('def').func('an2').set('plotfixedvalue', {'200'});
model.material('mat1').propertyGroup('def').func('an2').set('plotargs', {'T' '200' '1600'});
model.material('mat1').propertyGroup('def').set('thermalexpansioncoefficient', '');
model.material('mat1').propertyGroup('def').set('molarmass', '');
model.material('mat1').propertyGroup('def').set('bulkviscosity', '');
model.material('mat1').propertyGroup('def').set('thermalexpansioncoefficient', {'alpha_p(pA,T)' '0' '0' '0' 'alpha_p(pA,T)' '0' '0' '0' 'alpha_p(pA,T)'});
model.material('mat1').propertyGroup('def').set('molarmass', '0.02897[kg/mol]');
model.material('mat1').propertyGroup('def').set('bulkviscosity', 'muB(T)');
model.material('mat1').propertyGroup('def').set('relpermeability', {'1' '0' '0' '0' '1' '0' '0' '0' '1'});
model.material('mat1').propertyGroup('def').set('relpermittivity', {'1' '0' '0' '0' '1' '0' '0' '0' '1'});
model.material('mat1').propertyGroup('def').set('dynamicviscosity', 'eta(T)');
model.material('mat1').propertyGroup('def').set('ratioofspecificheat', '1.4');
model.material('mat1').propertyGroup('def').set('electricconductivity', {'0[S/m]' '0' '0' '0' '0[S/m]' '0' '0' '0' '0[S/m]'});
model.material('mat1').propertyGroup('def').set('heatcapacity', 'Cp(T)');
model.material('mat1').propertyGroup('def').set('density', 'rho(pA,T)');
model.material('mat1').propertyGroup('def').set('thermalconductivity', {'k(T)' '0' '0' '0' 'k(T)' '0' '0' '0' 'k(T)'});
model.material('mat1').propertyGroup('def').set('soundspeed', 'cs(T)');
model.material('mat1').propertyGroup('def').addInput('temperature');
model.material('mat1').propertyGroup('def').addInput('pressure');
model.material('mat1').propertyGroup('RefractiveIndex').set('n', {'1' '0' '0' '0' '1' '0' '0' '0' '1'});
model.material('mat1').propertyGroup('NonlinearModel').set('BA', 'def.gamma-1');
model.material('mat1').propertyGroup('idealGas').func('Cp').label('Piecewise 2');
model.material('mat1').propertyGroup('idealGas').func('Cp').set('arg', 'T');
model.material('mat1').propertyGroup('idealGas').func('Cp').set('pieces', {'200.0' '1600.0' '1047.63657-0.372589265*T^1+9.45304214E-4*T^2-6.02409443E-7*T^3+1.2858961E-10*T^4'});
model.material('mat1').propertyGroup('idealGas').func('Cp').set('argunit', 'K');
model.material('mat1').propertyGroup('idealGas').func('Cp').set('fununit', 'J/(kg*K)');
model.material('mat1').propertyGroup('idealGas').set('Rs', 'R_const/Mn');
model.material('mat1').propertyGroup('idealGas').set('heatcapacity', 'Cp(T)');
model.material('mat1').propertyGroup('idealGas').set('ratioofspecificheat', '1.4');
model.material('mat1').propertyGroup('idealGas').set('molarmass', '0.02897');
model.material('mat1').propertyGroup('idealGas').addInput('temperature');
model.material('mat1').propertyGroup('idealGas').addInput('pressure');
model.material('mat1').materialType('nonSolid');

model.physics('ewt').prop('components').set('components', 'outofplane');
model.physics('ewt').create('pmc1', 'PerfectMagneticConductor', 1);
model.physics('ewt').feature('pmc1').selection.set([3]);
model.physics('ewt').create('sctr1', 'Scattering', 1);
model.physics('ewt').feature('sctr1').selection.set([1]);
model.physics('ewt').feature('sctr1').set('IncidentField', 'EField');
model.physics('ewt').feature('sctr1').set('E0i', {'0' '0' 'E0*sqrt(w0/w(x))*exp(-y^2/w(x)^2)*cos(omega0*t-k0*x+eta(x)-k0*y^2/(2*R(x)))*exp(-(t-t0)^2/dt^2)'});
model.physics('ewt').create('sctr2', 'Scattering', 1);
model.physics('ewt').feature('sctr2').selection.set([4]);
model.physics('ewt').feature('wee1').set('DisplacementFieldModel', 'RemanentDisplacement');
model.physics('ewt').feature('wee1').set('Dr', {'0' '0' 'd33*ewt.Ez^2'});

model.mesh('mesh1').create('map1', 'Map');
model.mesh('mesh1').feature('map1').create('dis1', 'Distribution');
model.mesh('mesh1').feature('map1').feature('dis1').selection.set([1 4]);
model.mesh('mesh1').feature('map1').feature('dis1').set('type', 'explicit');
model.mesh('mesh1').feature('map1').feature('dis1').set('explicit', 'sin(range(0,0.025*pi,0.5*pi))');
model.mesh('mesh1').feature('size').set('custom', true);
model.mesh('mesh1').feature('size').set('hmax', 'hmax');
model.mesh('mesh1').run;

model.probe.create('pdom1', 'DomainPoint');
model.probe('pdom1').model('comp1');
model.probe('pdom1').setIndex('coords2', 10, 0);
model.probe('pdom1').feature('ppb1').set('probename', 'Eout');
model.probe('pdom1').feature('ppb1').set('expr', 'ewt.Ez');
model.probe('pdom1').feature('ppb1').set('descr', 'Electric field, z-component');

model.study('std1').feature('time').set('tlist', '0 61[fs] 90[fs] 120[fs]');
model.study('std1').feature('time').set('plot', true);

model.sol.create('sol1');
model.sol('sol1').study('std1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'time');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').set('control', 'time');
model.sol('sol1').create('t1', 'Time');
model.sol('sol1').feature('t1').set('tlist', '0 61[fs] 90[fs] 120[fs]');
model.sol('sol1').feature('t1').set('plot', 'on');
model.sol('sol1').feature('t1').set('plotgroup', 'Default');
model.sol('sol1').feature('t1').set('plotfreq', 'tout');
model.sol('sol1').feature('t1').set('probesel', 'all');
model.sol('sol1').feature('t1').set('probes', {'pdom1'});
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
model.sol('sol1').feature('t1').feature('d1').label('Suggested Direct Solver (ewt)');
model.sol('sol1').feature('t1').feature('fc1').set('linsolver', 'd1');
model.sol('sol1').feature('t1').feature.remove('fcDef');
model.sol('sol1').attach('std1');
model.sol('sol1').feature('t1').set('tstepsgenalpha', 'manual');
model.sol('sol1').feature('t1').set('timestepgenalpha', 'tstep');
model.sol('sol1').feature('t1').feature('fc1').set('useheuristicfact', true);

model.probe('pdom1').genResult('none');

model.result.create('pg2', 'PlotGroup2D');
model.result('pg2').set('data', 'dset1');
model.result('pg2').set('defaultPlotID', 'TransientElectromagneticWaves/phys1/pdef1/pcond2/pg1');
model.result('pg2').feature.create('surf1', 'Surface');
model.result('pg2').feature('surf1').set('showsolutionparams', 'on');
model.result('pg2').feature('surf1').set('smooth', 'internal');
model.result('pg2').feature('surf1').set('showsolutionparams', 'on');
model.result('pg2').feature('surf1').set('data', 'parent');

model.sol('sol1').runAll;

model.result.remove('pg2');

model.study('std1').feature('time').set('plotgroup', 'Default');

model.result.create('pg2', 'PlotGroup2D');
model.result('pg2').set('solvertype', 'none');
model.result('pg2').set('data', 'dset1');
model.result('pg2').setIndex('looplevel', 4, 0);
model.result('pg2').set('defaultPlotID', 'TransientElectromagneticWaves/phys1/pdef1/pcond2/pg1');
model.result('pg2').feature.create('surf1', 'Surface');
model.result('pg2').feature('surf1').set('showsolutionparams', 'on');
model.result('pg2').feature('surf1').set('solvertype', 'none');
model.result('pg2').feature('surf1').set('smooth', 'internal');
model.result('pg2').feature('surf1').set('showsolutionparams', 'on');
model.result('pg2').feature('surf1').set('solvertype', 'none');
model.result('pg2').feature('surf1').set('showsolutionparams', 'on');
model.result('pg2').feature('surf1').set('solvertype', 'none');
model.result('pg2').feature('surf1').set('showsolutionparams', 'on');
model.result('pg2').feature('surf1').set('solvertype', 'none');
model.result('pg2').feature('surf1').set('showsolutionparams', 'on');
model.result('pg2').feature('surf1').set('solvertype', 'none');
model.result('pg2').feature('surf1').set('data', 'parent');
model.result('pg2').run;
model.result('pg2').run;
model.result('pg2').feature('surf1').set('expr', 'ewt.Ez');
model.result('pg2').feature('surf1').set('descr', 'Electric field, z-component');
model.result('pg2').feature('surf1').create('hght1', 'Height');
model.result('pg2').run;
model.result('pg2').run;
model.result('pg2').setIndex('looplevel', 2, 0);
model.result('pg2').run;
model.result('pg2').setIndex('looplevel', 3, 0);
model.result('pg2').run;
model.result('pg1').set('window', 'window1');
model.result('pg1').run;
model.result('pg1').feature('tblp1').set('transform', 'fourier');
model.result('pg1').feature('tblp1').set('fouriershow', 'spectrum');
model.result('pg1').feature('tblp1').set('freqrangeactive', true);
model.result('pg1').set('window', 'window1');
model.result('pg1').run;
model.result('pg1').set('window', 'window1');
model.result('pg1').run;
model.result('pg1').set('window', 'graphics');
model.result('pg1').run;
model.result('pg2').run;

model.title('Second Harmonic Generation of a Gaussian Beam');

model.description('Laser systems are an important application area in modern electronics. With nonlinear materials it is possible to generate harmonics that are multiples of the frequency of the laser light. This example shows how a second harmonic generation can be set up as a transient wave simulation, using nonlinear material properties. A Nd:YAG (lambda=1.06 microns) laser beam is focused on a nonlinear crystal, so that the waist of the beam is inside the crystal.');

model.mesh.clearMeshes;

model.sol('sol1').clearSolutionData;

model.label('second_harmonic_generation.mph');

model.modelNode.label('Components');

out = model;
