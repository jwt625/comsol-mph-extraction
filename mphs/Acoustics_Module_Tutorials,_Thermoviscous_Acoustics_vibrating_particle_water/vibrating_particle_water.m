function out = model
%
% vibrating_particle_water.m
%
% Model exported on May 26 2025, 21:25 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/Acoustics_Module/Tutorials,_Thermoviscous_Acoustics');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 2);
model.geom('geom1').model('comp1');
model.geom('geom1').axisymmetric(true);

model.mesh.create('mesh1', 'geom1');

model.physics.create('ta', 'ThermoacousticsSinglePhysics', 'geom1');
model.physics('ta').model('comp1');

model.study.create('std1');
model.study('std1').create('freq', 'Frequency');
model.study('std1').feature('freq').setSolveFor('/physics/ta', true);

% To import content from file, use:
% model.param.loadFile('FILENAME');
model.param.set('a_s', '1[mm]', 'Source radius');
model.param.set('a_ta', '90[mm]', 'Thermoviscous acoustics domain radius');
model.param.set('a_tot', '100[mm]', 'Total radius');
model.param.set('f0', '50[kHz]', 'Study frequency');
model.param.set('omega0', '2*pi*f0', 'Study angular frequency');
model.param.set('dvisc', '55[um]*sqrt(100[Hz]/f0)', 'Viscous boundary layer thickness at f0');
model.param.set('c0', '1484[m/s]', 'Speed of sound');
model.param.set('rho0', '1000[kg/m^3]', 'Density');
model.param.set('lam0', 'c0/f0', 'Wavelength at f0');
model.param.set('k0', '2*pi/lam0', 'Wave number at f0');
model.param.set('U0', '1[mm/s]', 'Velocity amplitude in z-direction');

model.geom('geom1').create('c1', 'Circle');
model.geom('geom1').feature('c1').set('r', 'a_s');
model.geom('geom1').run('c1');
model.geom('geom1').feature.duplicate('c2', 'c1');
model.geom('geom1').feature('c2').set('r', 'a_tot');
model.geom('geom1').feature('c2').setIndex('layername', 'Layer 1', 0);
model.geom('geom1').feature('c2').setIndex('layer', 'a_tot - a_ta', 0);
model.geom('geom1').run('c2');
model.geom('geom1').create('dif1', 'Difference');
model.geom('geom1').feature('dif1').selection('input').set({'c2'});
model.geom('geom1').feature('dif1').selection('input2').set({'c1'});
model.geom('geom1').runPre('fin');

model.variable.create('var1');
model.variable('var1').model('comp1');

model.geom('geom1').run;

model.variable('var1').set('b', 'a_s*k0');
model.variable('var1').descr('b', 'Help variable');
model.variable('var1').set('R0', 'sqrt(r^2 + z^2)');
model.variable('var1').descr('R0', 'Radial distance from the origin');
model.variable('var1').set('phi_an', 'U0*a_s^3/R0^3*z*exp(i*k0*(R0 - a_s))*(i*k0*R0 - 1)/(2 - b^2 -2*i*b)');
model.variable('var1').descr('phi_an', 'Velocity potential (asymptotic)');
model.variable('var1').set('p_an', 'i*omega0*rho0*phi_an');
model.variable('var1').descr('p_an', 'Acoustic pressure (asymptotic)');

model.coordSystem.create('pml1', 'geom1', 'PML');
model.coordSystem('pml1').selection.set([1 3]);
model.coordSystem('pml1').set('stretchingType', 'rational');

model.material.create('mat1', 'Common', 'comp1');
model.material('mat1').propertyGroup('def').func.create('eta', 'Piecewise');
model.material('mat1').propertyGroup('def').func.create('Cp', 'Piecewise');
model.material('mat1').propertyGroup('def').func.create('rho', 'Piecewise');
model.material('mat1').propertyGroup('def').func.create('k', 'Piecewise');
model.material('mat1').propertyGroup('def').func.create('cs', 'Interpolation');
model.material('mat1').propertyGroup('def').func.create('an1', 'Analytic');
model.material('mat1').propertyGroup('def').func.create('an2', 'Analytic');
model.material('mat1').propertyGroup('def').func.create('an3', 'Analytic');
model.material('mat1').label('Water, liquid');
model.material('mat1').set('family', 'water');
model.material('mat1').propertyGroup('def').func('eta').set('arg', 'T');
model.material('mat1').propertyGroup('def').func('eta').set('pieces', {'273.15' '413.15' '1.3799566804-0.021224019151*T^1+1.3604562827E-4*T^2-4.6454090319E-7*T^3+8.9042735735E-10*T^4-9.0790692686E-13*T^5+3.8457331488E-16*T^6'; '413.15' '553.75' '0.00401235783-2.10746715E-5*T^1+3.85772275E-8*T^2-2.39730284E-11*T^3'});
model.material('mat1').propertyGroup('def').func('eta').set('argunit', 'K');
model.material('mat1').propertyGroup('def').func('eta').set('fununit', 'Pa*s');
model.material('mat1').propertyGroup('def').func('Cp').set('arg', 'T');
model.material('mat1').propertyGroup('def').func('Cp').set('pieces', {'273.15' '553.75' '12010.1471-80.4072879*T^1+0.309866854*T^2-5.38186884E-4*T^3+3.62536437E-7*T^4'});
model.material('mat1').propertyGroup('def').func('Cp').set('argunit', 'K');
model.material('mat1').propertyGroup('def').func('Cp').set('fununit', 'J/(kg*K)');
model.material('mat1').propertyGroup('def').func('rho').set('arg', 'T');
model.material('mat1').propertyGroup('def').func('rho').set('smooth', 'contd1');
model.material('mat1').propertyGroup('def').func('rho').set('pieces', {'273.15' '293.15' '0.000063092789034*T^3-0.060367639882855*T^2+18.9229382407066*T-950.704055329848'; '293.15' '373.15' '0.000010335053319*T^3-0.013395065634452*T^2+4.969288832655160*T+432.257114008512'});
model.material('mat1').propertyGroup('def').func('rho').set('argunit', 'K');
model.material('mat1').propertyGroup('def').func('rho').set('fununit', 'kg/m^3');
model.material('mat1').propertyGroup('def').func('k').set('arg', 'T');
model.material('mat1').propertyGroup('def').func('k').set('pieces', {'273.15' '553.75' '-0.869083936+0.00894880345*T^1-1.58366345E-5*T^2+7.97543259E-9*T^3'});
model.material('mat1').propertyGroup('def').func('k').set('argunit', 'K');
model.material('mat1').propertyGroup('def').func('k').set('fununit', 'W/(m*K)');
model.material('mat1').propertyGroup('def').func('cs').set('table', {'273' '1403';  ...
'278' '1427';  ...
'283' '1447';  ...
'293' '1481';  ...
'303' '1507';  ...
'313' '1526';  ...
'323' '1541';  ...
'333' '1552';  ...
'343' '1555';  ...
'353' '1555';  ...
'363' '1550';  ...
'373' '1543'});
model.material('mat1').propertyGroup('def').func('cs').set('interp', 'piecewisecubic');
model.material('mat1').propertyGroup('def').func('cs').set('fununit', {'m/s'});
model.material('mat1').propertyGroup('def').func('cs').set('argunit', {'K'});
model.material('mat1').propertyGroup('def').func('an1').set('funcname', 'alpha_p');
model.material('mat1').propertyGroup('def').func('an1').set('expr', '-1/rho(T)*d(rho(T),T)');
model.material('mat1').propertyGroup('def').func('an1').set('args', {'T'});
model.material('mat1').propertyGroup('def').func('an1').set('fununit', '1/K');
model.material('mat1').propertyGroup('def').func('an1').set('argunit', {'K'});
model.material('mat1').propertyGroup('def').func('an1').set('plotfixedvalue', {'273.15'});
model.material('mat1').propertyGroup('def').func('an1').set('plotargs', {'T' '273.15' '373.15'});
model.material('mat1').propertyGroup('def').func('an2').set('funcname', 'gamma_w');
model.material('mat1').propertyGroup('def').func('an2').set('expr', '1+(T/Cp(T))*(alpha_p(T)*cs(T))^2');
model.material('mat1').propertyGroup('def').func('an2').set('args', {'T'});
model.material('mat1').propertyGroup('def').func('an2').set('fununit', '1');
model.material('mat1').propertyGroup('def').func('an2').set('argunit', {'K'});
model.material('mat1').propertyGroup('def').func('an2').set('plotfixedvalue', {'273.15'});
model.material('mat1').propertyGroup('def').func('an2').set('plotargs', {'T' '273.15' '373.15'});
model.material('mat1').propertyGroup('def').func('an3').set('funcname', 'muB');
model.material('mat1').propertyGroup('def').func('an3').set('expr', '2.79*eta(T)');
model.material('mat1').propertyGroup('def').func('an3').set('args', {'T'});
model.material('mat1').propertyGroup('def').func('an3').set('fununit', 'Pa*s');
model.material('mat1').propertyGroup('def').func('an3').set('argunit', {'K'});
model.material('mat1').propertyGroup('def').func('an3').set('plotfixedvalue', {'273.15'});
model.material('mat1').propertyGroup('def').func('an3').set('plotargs', {'T' '273.15' '553.75'});
model.material('mat1').propertyGroup('def').set('thermalexpansioncoefficient', '');
model.material('mat1').propertyGroup('def').set('bulkviscosity', '');
model.material('mat1').propertyGroup('def').set('thermalexpansioncoefficient', {'alpha_p(T)' '0' '0' '0' 'alpha_p(T)' '0' '0' '0' 'alpha_p(T)'});
model.material('mat1').propertyGroup('def').set('bulkviscosity', 'muB(T)');
model.material('mat1').propertyGroup('def').set('dynamicviscosity', 'eta(T)');
model.material('mat1').propertyGroup('def').set('ratioofspecificheat', 'gamma_w(T)');
model.material('mat1').propertyGroup('def').set('electricconductivity', {'5.5e-6[S/m]' '0' '0' '0' '5.5e-6[S/m]' '0' '0' '0' '5.5e-6[S/m]'});
model.material('mat1').propertyGroup('def').set('heatcapacity', 'Cp(T)');
model.material('mat1').propertyGroup('def').set('density', 'rho(T)');
model.material('mat1').propertyGroup('def').set('thermalconductivity', {'k(T)' '0' '0' '0' 'k(T)' '0' '0' '0' 'k(T)'});
model.material('mat1').propertyGroup('def').set('soundspeed', 'cs(T)');
model.material('mat1').propertyGroup('def').addInput('temperature');

model.physics('ta').prop('ReferencePressure').set('ReferenceType', 'ReferencePressureWater');
model.physics('ta').prop('EquationSettings').set('AdiabaticFormulation', true);
model.physics('ta').create('velt1', 'VelocityThermoacoustic', 1);
model.physics('ta').feature('velt1').selection.set([8 9]);
model.physics('ta').feature('velt1').setIndex('Direction', true, 0);
model.physics('ta').feature('velt1').setIndex('Direction', true, 2);
model.physics('ta').feature('velt1').setIndex('u0', 'U0', 2);
model.physics.create('acpr', 'PressureAcoustics', 'geom1');
model.physics('acpr').model('comp1');

model.study('std1').feature('freq').setSolveFor('/physics/acpr', true);

model.physics('acpr').prop('ReferencePressure').set('ReferenceType', 'ReferencePressureWater');
model.physics('acpr').feature('fpam1').set('FluidModel', 'Viscous');
model.physics('acpr').create('tvb1', 'ThermoviscousBoundaryLayerImpedance', 1);
model.physics('acpr').feature('tvb1').selection.set([8 9]);
model.physics('acpr').feature('tvb1').set('MechanicalCondition', 'Velocity');
model.physics('acpr').feature('tvb1').set('vel', {'0' '0' 'U0'});
model.physics('acpr').feature('tvb1').set('ThermalCondition', 'Adiabatic');
model.physics('acpr').feature('tvb1').set('FluidMaterial', 'mat1');

model.study('std1').feature('freq').set('plist', 'f0');

model.mesh('mesh1').contribute('physics/acpr', false);

model.physics('ta').prop('MeshControl').set('ElementsPerWavelength', 'UserDefined');
model.physics('ta').prop('MeshControl').set('nperlambda', 12);

model.mesh('mesh1').automatic(false);
model.mesh('mesh1').feature('size1').set('hcurveactive', true);
model.mesh('mesh1').feature('size1').set('hcurve', 0.03);
model.mesh('mesh1').feature('bl1').feature('blp1').set('blnlayers', 8);
model.mesh('mesh1').feature('bl1').feature('blp1').set('inittype', 'blhtot');
model.mesh('mesh1').feature('bl1').feature('blp1').set('blhtot', '2*pi*dvisc');
model.mesh('mesh1').run;

model.study('std1').setGenPlots(false);

model.sol.create('sol1');
model.sol('sol1').study('std1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'freq');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').set('control', 'freq');
model.sol('sol1').create('s1', 'Stationary');
model.sol('sol1').feature('s1').set('stol', 0.001);
model.sol('sol1').feature('s1').create('p1', 'Parametric');
model.sol('sol1').feature('s1').feature.remove('pDef');
model.sol('sol1').feature('s1').feature('p1').set('pname', {'freq'});
model.sol('sol1').feature('s1').feature('p1').set('plistarr', {'f0'});
model.sol('sol1').feature('s1').feature('p1').set('punit', {'Hz'});
model.sol('sol1').feature('s1').feature('p1').set('pcontinuationmode', 'no');
model.sol('sol1').feature('s1').feature('p1').set('preusesol', 'no');
model.sol('sol1').feature('s1').feature('p1').set('pdistrib', 'off');
model.sol('sol1').feature('s1').feature('p1').set('plot', 'off');
model.sol('sol1').feature('s1').feature('p1').set('plotgroup', 'Default');
model.sol('sol1').feature('s1').feature('p1').set('probesel', 'all');
model.sol('sol1').feature('s1').feature('p1').set('probes', {});
model.sol('sol1').feature('s1').feature('p1').set('control', 'freq');
model.sol('sol1').feature('s1').set('linpmethod', 'sol');
model.sol('sol1').feature('s1').set('linpsol', 'zero');
model.sol('sol1').feature('s1').set('control', 'freq');
model.sol('sol1').feature('s1').feature('aDef').set('complexfun', true);
model.sol('sol1').feature('s1').feature('aDef').set('cachepattern', true);
model.sol('sol1').feature('s1').feature('aDef').set('matherr', true);
model.sol('sol1').feature('s1').feature('aDef').set('blocksizeactive', false);
model.sol('sol1').feature('s1').feature('aDef').set('nullfun', 'auto');
model.sol('sol1').feature('s1').create('seDef', 'Segregated');
model.sol('sol1').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('s1').create('d1', 'Direct');
model.sol('sol1').feature('s1').feature('d1').label('Direct (Merged)');
model.sol('sol1').feature('s1').feature('fc1').set('linsolver', 'd1');
model.sol('sol1').feature('s1').feature.remove('fcDef');
model.sol('sol1').feature('s1').feature.remove('seDef');
model.sol('sol1').attach('std1');
model.sol('sol1').runAll;

model.result.create('pg1', 'PlotGroup2D');
model.result('pg1').label('Acoustic Pressure (ta)');
model.result('pg1').set('dataisaxisym', 'off');
model.result('pg1').set('showlegendsunit', true);
model.result('pg1').set('data', 'dset1');
model.result('pg1').setIndex('looplevel', 1, 0);
model.result('pg1').set('defaultPlotID', 'thermoacoustics/ThermoacousticsPhysicsInterfaceComponents/icom5/pdef1/pcond2/pg2');
model.result('pg1').feature.create('surf1', 'Surface');
model.result('pg1').feature('surf1').label('Surface');
model.result('pg1').feature('surf1').set('colortable', 'Wave');
model.result('pg1').feature('surf1').set('colorscalemode', 'linearsymmetric');
model.result('pg1').feature('surf1').set('smooth', 'internal');
model.result('pg1').feature('surf1').set('showsolutionparams', 'on');
model.result('pg1').feature('surf1').set('data', 'parent');
model.result('pg1').label('Acoustic Pressure (ta)');
model.result('pg1').run;
model.result('pg1').selection.geom('geom1', 2);
model.result('pg1').selection.geom('geom1', 2);
model.result('pg1').selection.set([2]);
model.result('pg1').set('titletype', 'label');
model.result('pg1').run;
model.result.create('pg2', 'PlotGroup2D');
model.result('pg2').run;
model.result('pg2').label('Instantaneous Local Velocity (dB)');
model.result('pg2').selection.geom('geom1', 2);
model.result('pg2').selection.geom('geom1', 2);
model.result('pg2').selection.set([2]);
model.result('pg2').set('titletype', 'label');
model.result('pg2').set('showlegendsunit', true);
model.result('pg2').create('surf1', 'Surface');
model.result('pg2').feature('surf1').set('expr', '10*log10(abs(ta.v_inst/U0))[dB]');
model.result('pg2').run;
model.result.dataset.create('cln1', 'CutLine2D');
model.result.dataset('cln1').setIndex('genpoints', 'a_s/sqrt(2)', 0, 0);
model.result.dataset('cln1').setIndex('genpoints', 'a_s/sqrt(2)', 0, 1);
model.result.dataset('cln1').setIndex('genpoints', '0.5*a_ta/sqrt(2)', 1, 0);
model.result.dataset('cln1').setIndex('genpoints', '0.5*a_ta/sqrt(2)', 1, 1);
model.result.dataset.create('cln2', 'CutLine2D');
model.result.dataset('cln2').setIndex('genpoints', 'a_s/sqrt(2)', 0, 0);
model.result.dataset('cln2').setIndex('genpoints', 'a_s/sqrt(2)', 0, 1);
model.result.dataset('cln2').setIndex('genpoints', '(a_s+20*dvisc)/sqrt(2)', 1, 0);
model.result.dataset('cln2').setIndex('genpoints', '(a_s+20*dvisc)/sqrt(2)', 1, 1);
model.result.create('pg3', 'PlotGroup1D');
model.result('pg3').run;
model.result('pg3').label('Acoustic Pressure vs. Distance');
model.result('pg3').set('data', 'cln1');
model.result('pg3').set('titletype', 'label');
model.result('pg3').set('xlabelactive', true);
model.result('pg3').set('xlabel', '|r| (mm)');
model.result('pg3').set('ylabelactive', true);
model.result('pg3').set('ylabel', 'Acoustic Pressure (Pa)');
model.result('pg3').create('lngr1', 'LineGraph');
model.result('pg3').feature('lngr1').set('markerpos', 'datapoints');
model.result('pg3').feature('lngr1').set('linewidth', 'preference');
model.result('pg3').feature('lngr1').set('xdata', 'expr');
model.result('pg3').feature('lngr1').set('xdataexpr', 'R0');
model.result('pg3').feature('lngr1').set('xdataunit', 'mm');
model.result('pg3').feature('lngr1').set('legend', true);
model.result('pg3').feature('lngr1').set('legendmethod', 'manual');
model.result('pg3').feature('lngr1').setIndex('legends', 'Thermoviscous Acoustics', 0);
model.result('pg3').feature.duplicate('lngr2', 'lngr1');
model.result('pg3').run;
model.result('pg3').feature('lngr2').set('expr', 'p_an');
model.result('pg3').feature('lngr2').setIndex('legends', 'Analytical (asymptotic/adiabatic)', 0);
model.result('pg3').feature.duplicate('lngr3', 'lngr2');
model.result('pg3').run;
model.result('pg3').feature('lngr3').set('expr', 'acpr.p_t');
model.result('pg3').feature('lngr3').setIndex('legends', 'Pressure Acoustics with BLI', 0);
model.result('pg3').run;
model.result.create('pg4', 'PlotGroup1D');
model.result('pg4').run;
model.result('pg4').label('Axial Velocity vs. Distance');
model.result('pg4').set('data', 'cln2');
model.result('pg4').set('titletype', 'label');
model.result('pg4').set('xlabelactive', true);
model.result('pg4').set('xlabel', '|r - a<sub>s</sub>| / \delta<sub>v</sub> (1)');
model.result('pg4').set('ylabelactive', true);
model.result('pg4').set('ylabel', 'Axial velocity: w (m/s)');
model.result('pg4').set('legendpos', 'middleright');
model.result('pg4').create('lngr1', 'LineGraph');
model.result('pg4').feature('lngr1').set('markerpos', 'datapoints');
model.result('pg4').feature('lngr1').set('linewidth', 'preference');
model.result('pg4').feature('lngr1').set('expr', 'w');
model.result('pg4').feature('lngr1').set('xdata', 'expr');
model.result('pg4').feature('lngr1').set('xdataexpr', '(R0-a_s)/dvisc');
model.result('pg4').feature('lngr1').set('legend', true);
model.result('pg4').feature('lngr1').set('legendmethod', 'manual');
model.result('pg4').feature('lngr1').setIndex('legends', 'Thermoviscous Acoustics', 0);
model.result('pg4').feature.duplicate('lngr2', 'lngr1');
model.result('pg4').run;
model.result('pg4').feature('lngr2').set('expr', 'U0');
model.result('pg4').feature('lngr2').setIndex('legends', 'Prescribed Axial Velocity: U<sub>0</sub>', 0);
model.result('pg4').feature.duplicate('lngr3', 'lngr2');
model.result('pg4').run;
model.result('pg4').feature('lngr3').set('expr', 'acpr.vz');
model.result('pg4').feature('lngr3').setIndex('legends', 'Pressure Acoustics with BLI', 0);
model.result('pg4').run;
model.result('pg1').run;

model.title('Vibrating Particle in Water');

model.description('This tutorial treats a small vibrating hemispherical particle in water. The vibrations induce acoustic waves in the fluid. The example demonstrates how to set up a thermoviscous acoustics model that solves for the acoustic (compressible) waves in the fluid. The model is also set up using the Thermoviscous Boundary Layer Impedance condition available in pressure acoustics. The numerical solutions are validated by comparison with each other and with an analytical asymptotic model.');

model.mesh.clearMeshes;

model.sol('sol1').clearSolutionData;

model.label('vibrating_particle_water.mph');

model.modelNode.label('Components');

out = model;
