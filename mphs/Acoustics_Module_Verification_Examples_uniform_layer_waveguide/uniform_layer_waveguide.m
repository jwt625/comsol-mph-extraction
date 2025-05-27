function out = model
%
% uniform_layer_waveguide.m
%
% Model exported on May 26 2025, 21:25 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/Acoustics_Module/Verification_Examples');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 3);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.physics.create('ta', 'ThermoacousticsSinglePhysics', 'geom1');
model.physics('ta').model('comp1');

model.study.create('std1');
model.study('std1').create('freq', 'Frequency');
model.study('std1').feature('freq').setSolveFor('/physics/ta', true);

% To import content from file, use:
% model.param.loadFile('FILENAME');
model.param.set('f0', '500[Hz]', 'Frequency');
model.param.set('T0', '293[K]', 'Ambient temperature');
model.param.set('p0', '1[atm]', 'Atmospheric pressure');
model.param.set('H', '1[mm]', 'Waveguide height');
model.param.set('L', '5[mm]', 'Waveguide side lengths');
model.param.set('pin', '1[Pa]', 'Inlet pressure');
model.param.set('d_visc', '0.22[mm]*sqrt(100[Hz]/f0)', 'Viscous boundary layer thickness of air at 20 degrees C and 1 atm');

model.variable.create('var1');
model.variable('var1').model('comp1');

model.geom('geom1').run;

% To import content from file, use:
% model.variable('var1').loadFile('FILENAME');
model.variable('var1').set('Z0', 'ta.rho0*ta.c', 'Characteristic impedance');
model.variable('var1').set('k0', 'ta.omega/ta.c', 'Acoustic wave number');
model.variable('var1').set('kv', 'sqrt(-i*ta.omega*ta.rho0/ta.mu)', 'Viscous wave number');
model.variable('var1').set('kth', 'sqrt(-i*ta.omega*ta.rho0*ta.Cp/ta.kcond)', 'Thermal wave number');
model.variable('var1').set('Pv', '1-cos(kv*z)/cos(kv*H/2)', 'Scalar viscous field');
model.variable('var1').set('Pth', '1-cos(kth*z)/cos(kth*H/2)', 'Scalar thermal field');
model.variable('var1').set('Uana', '-Pv*(pin/L)/(i*k0*Z0)', 'Analytical x-velocity profile');
model.variable('var1').set('Tana', 'Pth*(pin/2)/(ta.rho0*ta.Cp)', 'Analytical temperature profile');

model.geom('geom1').create('blk1', 'Block');
model.geom('geom1').feature('blk1').set('size', {'L' 'L' 'H'});
model.geom('geom1').feature('blk1').set('pos', {'0' '0' '-H/2'});
model.geom('geom1').run('blk1');
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

model.physics('ta').feature('tam1').set('minput_temperature', 'T0');
model.physics('ta').feature('tam1').set('minput_pressure', 'p0');
model.physics('ta').create('sym1', 'Symmetry', 2);
model.physics('ta').feature('sym1').selection.set([2 5]);
model.physics('ta').create('pra1', 'PressureAdiabatic', 2);
model.physics('ta').feature('pra1').selection.set([1]);
model.physics('ta').feature('pra1').set('pbnd', 'pin');
model.physics('ta').create('pra2', 'PressureAdiabatic', 2);
model.physics('ta').feature('pra2').selection.set([6]);

model.mesh('mesh1').create('map1', 'Map');
model.mesh('mesh1').feature('map1').selection.set([1]);
model.mesh('mesh1').feature('map1').create('dis1', 'Distribution');
model.mesh('mesh1').feature('map1').feature('dis1').selection.set([4 6]);
model.mesh('mesh1').feature('map1').feature('dis1').set('numelem', 3);
model.mesh('mesh1').run('map1');
model.mesh('mesh1').create('swe1', 'Sweep');
model.mesh('mesh1').feature('swe1').create('dis1', 'Distribution');
model.mesh('mesh1').run('swe1');
model.mesh('mesh1').create('bl1', 'BndLayer');
model.mesh('mesh1').feature('bl1').create('blp', 'BndLayerProp');
model.mesh('mesh1').feature('bl1').selection.geom(3);
model.mesh('mesh1').feature('bl1').selection.set([]);
model.mesh('mesh1').feature('bl1').selection.allGeom;
model.mesh('mesh1').feature('bl1').feature('blp').selection.set([3 4]);
model.mesh('mesh1').feature('bl1').feature('blp').set('blnlayers', 5);
model.mesh('mesh1').feature('bl1').feature('blp').set('inittype', 'blhtot');
model.mesh('mesh1').feature('bl1').feature('blp').set('blhtot', 'pi*d_visc');
model.mesh('mesh1').run;

model.study('std1').feature('freq').set('plist', 'f0');

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
model.sol('sol1').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('s1').create('d1', 'Direct');
model.sol('sol1').feature('s1').feature('d1').set('linsolver', 'pardiso');
model.sol('sol1').feature('s1').feature('d1').set('pivotperturb', 1.0E-13);
model.sol('sol1').feature('s1').feature('d1').label('Suggested Direct Solver (ta)');
model.sol('sol1').feature('s1').create('i1', 'Iterative');
model.sol('sol1').feature('s1').feature('i1').label('Suggested Iterative Solver (GMRES with Direct Precon.) (ta)');
model.sol('sol1').feature('s1').feature('i1').create('dp1', 'DirectPreconditioner');
model.sol('sol1').feature('s1').feature('i1').feature('dp1').set('hybridization', 'multi');
model.sol('sol1').feature('s1').feature('i1').feature('dp1').set('hybridvar', {'comp1_u' 'comp1_p'});
model.sol('sol1').feature('s1').feature('i1').feature('dp1').set('linsolver', 'pardiso');
model.sol('sol1').feature('s1').feature('i1').feature('dp1').set('pivotperturb', '1.0E-13');
model.sol('sol1').feature('s1').feature('i1').create('dp2', 'DirectPreconditioner');
model.sol('sol1').feature('s1').feature('i1').feature('dp2').set('hybridization', 'multi');
model.sol('sol1').feature('s1').feature('i1').feature('dp2').set('hybridvar', {'comp1_T'});
model.sol('sol1').feature('s1').feature('i1').feature('dp2').set('linsolver', 'pardiso');
model.sol('sol1').feature('s1').feature('i1').feature('dp2').set('pivotperturb', '1.0E-13');
model.sol('sol1').feature('s1').create('i2', 'Iterative');
model.sol('sol1').feature('s1').feature('i2').label('Suggested Iterative Solver (GMRES with DD) (ta)');
model.sol('sol1').feature('s1').feature('i2').create('dd1', 'DomainDecomposition');
model.sol('sol1').feature('s1').feature('i2').feature('dd1').set('prefun', 'ddhyb');
model.sol('sol1').feature('s1').feature('i2').feature('dd1').set('domdofmax', 200000);
model.sol('sol1').feature('s1').feature('i2').feature('dd1').set('ddolhandling', 'ddrestricted');
model.sol('sol1').feature('s1').feature('i2').feature('dd1').set('userac', false);
model.sol('sol1').feature('s1').feature('i2').feature('dd1').set('usecoarse', 'aggregation');
model.sol('sol1').feature('s1').feature('i2').feature('dd1').feature('ds').create('dp1', 'DirectPreconditioner');
model.sol('sol1').feature('s1').feature('i2').feature('dd1').feature('ds').feature('dp1').set('hybridization', 'multi');
model.sol('sol1').feature('s1').feature('i2').feature('dd1').feature('ds').feature('dp1').set('hybridvar', {'comp1_u' 'comp1_p'});
model.sol('sol1').feature('s1').feature('i2').feature('dd1').feature('ds').feature('dp1').set('linsolver', 'pardiso');
model.sol('sol1').feature('s1').feature('i2').feature('dd1').feature('ds').feature('dp1').set('pivotperturb', '1.0E-13');
model.sol('sol1').feature('s1').feature('i2').feature('dd1').feature('ds').create('dp2', 'DirectPreconditioner');
model.sol('sol1').feature('s1').feature('i2').feature('dd1').feature('ds').feature('dp2').set('hybridization', 'multi');
model.sol('sol1').feature('s1').feature('i2').feature('dd1').feature('ds').feature('dp2').set('hybridvar', {'comp1_T'});
model.sol('sol1').feature('s1').feature('i2').feature('dd1').feature('ds').feature('dp2').set('linsolver', 'pardiso');
model.sol('sol1').feature('s1').feature('i2').feature('dd1').feature('ds').feature('dp2').set('pivotperturb', '1.0E-13');
model.sol('sol1').feature('s1').feature('i2').feature('dd1').feature('cs').create('d1', 'Direct');
model.sol('sol1').feature('s1').feature('i2').feature('dd1').feature('cs').feature('d1').set('linsolver', 'pardiso');
model.sol('sol1').feature('s1').feature('i2').feature('dd1').feature('cs').feature('d1').set('pivotperturb', 1.0E-13);
model.sol('sol1').feature('s1').feature('fc1').set('linsolver', 'd1');
model.sol('sol1').feature('s1').feature.remove('fcDef');
model.sol('sol1').attach('std1');
model.sol('sol1').runAll;

model.result.create('pg1', 'PlotGroup3D');
model.result('pg1').label('Acoustic Pressure (ta)');
model.result('pg1').set('showlegendsunit', true);
model.result('pg1').set('data', 'dset1');
model.result('pg1').setIndex('looplevel', 1, 0);
model.result('pg1').set('defaultPlotID', 'thermoacoustics/ThermoacousticsPhysicsInterfaceComponents/icom5/pdef1/pcond1/pg3');
model.result('pg1').feature.create('mslc1', 'Multislice');
model.result('pg1').feature('mslc1').label('Multislice');
model.result('pg1').feature('mslc1').set('showsolutionparams', 'on');
model.result('pg1').feature('mslc1').set('colortable', 'Wave');
model.result('pg1').feature('mslc1').set('colorscalemode', 'linearsymmetric');
model.result('pg1').feature('mslc1').set('smooth', 'internal');
model.result('pg1').feature('mslc1').set('showsolutionparams', 'on');
model.result('pg1').feature('mslc1').set('data', 'parent');
model.result.create('pg2', 'PlotGroup3D');
model.result('pg2').label('Acoustic Velocity (ta)');
model.result('pg2').set('showlegendsunit', true);
model.result('pg2').set('data', 'dset1');
model.result('pg2').setIndex('looplevel', 1, 0);
model.result('pg2').set('defaultPlotID', 'thermoacoustics/ThermoacousticsPhysicsInterfaceComponents/icom5/pdef1/pcond1/pg1');
model.result('pg2').feature.create('slc1', 'Slice');
model.result('pg2').feature('slc1').label('Slice');
model.result('pg2').feature('slc1').set('showsolutionparams', 'on');
model.result('pg2').feature('slc1').set('expr', 'ta.v_inst');
model.result('pg2').feature('slc1').set('smooth', 'internal');
model.result('pg2').feature('slc1').set('showsolutionparams', 'on');
model.result('pg2').feature('slc1').set('data', 'parent');
model.result.create('pg3', 'PlotGroup3D');
model.result('pg3').label('Temperature Variation (ta)');
model.result('pg3').set('showlegendsunit', true);
model.result('pg3').set('data', 'dset1');
model.result('pg3').setIndex('looplevel', 1, 0);
model.result('pg3').set('defaultPlotID', 'thermoacoustics/ThermoacousticsPhysicsInterfaceComponents/icom5/pdef1/pcond1/pg2');
model.result('pg3').feature.create('mslc1', 'Multislice');
model.result('pg3').feature('mslc1').label('Multislice');
model.result('pg3').feature('mslc1').set('showsolutionparams', 'on');
model.result('pg3').feature('mslc1').set('expr', 'ta.T_t');
model.result('pg3').feature('mslc1').set('colortable', 'ThermalWave');
model.result('pg3').feature('mslc1').set('colorscalemode', 'linearsymmetric');
model.result('pg3').feature('mslc1').set('smooth', 'internal');
model.result('pg3').feature('mslc1').set('showsolutionparams', 'on');
model.result('pg3').feature('mslc1').set('data', 'parent');
model.result('pg1').run;
model.result('pg2').run;
model.result.dataset.create('cln1', 'CutLine3D');
model.result.dataset('cln1').setIndex('genpoints', 'L/2', 0, 0);
model.result.dataset('cln1').setIndex('genpoints', 'L/2', 0, 1);
model.result.dataset('cln1').setIndex('genpoints', 'H/2', 0, 2);
model.result.dataset('cln1').setIndex('genpoints', 'L/2', 1, 0);
model.result.dataset('cln1').setIndex('genpoints', 'L/2', 1, 1);
model.result.dataset('cln1').setIndex('genpoints', '-H/2', 1, 2);
model.result.create('pg4', 'PlotGroup1D');
model.result('pg4').run;
model.result('pg4').label('Velocity Profile');
model.result('pg4').set('data', 'cln1');
model.result('pg4').create('lngr1', 'LineGraph');
model.result('pg4').feature('lngr1').set('markerpos', 'datapoints');
model.result('pg4').feature('lngr1').set('linewidth', 'preference');
model.result('pg4').feature('lngr1').set('expr', 'abs(u)');
model.result('pg4').feature('lngr1').set('legend', true);
model.result('pg4').feature('lngr1').set('legendmethod', 'manual');
model.result('pg4').feature('lngr1').setIndex('legends', 'computed', 0);
model.result('pg4').run;
model.result('pg4').create('lngr2', 'LineGraph');
model.result('pg4').feature('lngr2').set('markerpos', 'datapoints');
model.result('pg4').feature('lngr2').set('linewidth', 'preference');
model.result('pg4').feature('lngr2').set('expr', 'abs(Uana)');
model.result('pg4').feature('lngr2').set('linestyle', 'none');
model.result('pg4').feature('lngr2').set('linemarker', 'cycle');
model.result('pg4').feature('lngr2').set('markerpos', 'interp');
model.result('pg4').feature('lngr2').set('markers', 20);
model.result('pg4').feature('lngr2').set('legend', true);
model.result('pg4').feature('lngr2').set('legendmethod', 'manual');
model.result('pg4').feature('lngr2').setIndex('legends', 'analytical', 0);
model.result('pg4').run;
model.result('pg4').run;
model.result.duplicate('pg5', 'pg4');
model.result('pg5').run;
model.result('pg5').label('Temperature Profile');
model.result('pg5').run;
model.result('pg5').feature('lngr1').set('expr', 'abs(T)');
model.result('pg5').run;
model.result('pg5').feature('lngr2').set('expr', 'abs(Tana)');
model.result('pg5').run;

model.title('Uniform Layer Waveguide');

model.description('In this example the thermoviscous acoustic wave field in a shallow uniform waveguide is modeled and compared to an analytical solution. Because of the small waveguide height (1 mm) the thermal and viscous boundary layers are significant.');

model.mesh.clearMeshes;

model.sol('sol1').clearSolutionData;

model.label('uniform_layer_waveguide.mph');

model.modelNode.label('Components');

out = model;
