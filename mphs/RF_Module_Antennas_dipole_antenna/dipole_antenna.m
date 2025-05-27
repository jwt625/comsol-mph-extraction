function out = model
%
% dipole_antenna.m
%
% Model exported on May 26 2025, 21:32 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/RF_Module/Antennas');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 3);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.physics.create('emw', 'ElectromagneticWaves', 'geom1');
model.physics('emw').model('comp1');

model.study.create('std1');
model.study('std1').create('freq', 'Frequency');
model.study('std1').feature('freq').set('solnum', 'auto');
model.study('std1').feature('freq').set('notsolnum', 'auto');
model.study('std1').feature('freq').set('outputmap', {});
model.study('std1').feature('freq').set('ngenAUX', '1');
model.study('std1').feature('freq').set('goalngenAUX', '1');
model.study('std1').feature('freq').set('ngenAUX', '1');
model.study('std1').feature('freq').set('goalngenAUX', '1');
model.study('std1').feature('freq').setSolveFor('/physics/emw', true);

model.param.set('lda0', '4[m]');
model.param.descr('lda0', 'Operating wavelength');
model.param.set('arm_length', 'lda0/4');
model.param.descr('arm_length', 'Dipole antenna arm length');
model.param.set('r_antenna', 'arm_length/20');
model.param.descr('r_antenna', 'Dipole antenna arm radius');
model.param.set('gap_size', 'arm_length/100');
model.param.descr('gap_size', 'Gap between arms');

model.geom('geom1').run;

model.study('std1').feature('freq').set('plist', 'c_const/lda0');

model.geom('geom1').create('sph1', 'Sphere');
model.geom('geom1').feature('sph1').set('r', '2.4*arm_length');
model.geom('geom1').feature('sph1').setIndex('layername', 'Layer 1', 0);
model.geom('geom1').feature('sph1').setIndex('layer', '0.5*arm_length', 0);
model.geom('geom1').run('sph1');

model.view('view1').set('renderwireframe', true);

model.geom('geom1').create('cyl1', 'Cylinder');
model.geom('geom1').feature('cyl1').set('r', 'r_antenna');
model.geom('geom1').feature('cyl1').set('h', '2*arm_length+gap_size');
model.geom('geom1').feature('cyl1').set('pos', {'0' '0' '-(arm_length+gap_size/2)'});
model.geom('geom1').feature('cyl1').setIndex('layername', 'Layer 1', 0);
model.geom('geom1').feature('cyl1').setIndex('layer', 'arm_length', 0);
model.geom('geom1').feature('cyl1').set('layerside', false);
model.geom('geom1').feature('cyl1').set('layerbottom', true);
model.geom('geom1').feature('cyl1').set('layertop', true);
model.geom('geom1').runPre('fin');

model.coordSystem.create('pml1', 'geom1', 'PML');

model.geom('geom1').run;

model.coordSystem('pml1').selection.set([1 2 3 4 9 10 11 12]);
model.coordSystem('pml1').set('ScalingType', 'Spherical');

model.view('view1').hideEntities.create('hide1');
model.view('view1').hideEntities('hide1').set([1 2]);
model.view('view1').hideEntities.create('hide2');
model.view('view1').hideEntities('hide2').geom('geom1', 2);
model.view('view1').hideEntities('hide2').set([9 10]);

model.physics('emw').create('imp1', 'DomainImpedance', 3);
model.physics('emw').feature('imp1').selection.set([6 8]);
model.physics('emw').create('lport1', 'LumpedPort', 2);
model.physics('emw').feature('lport1').selection.set([16 17 31 42]);
model.physics('emw').feature('lport1').set('PortType', 'UserDefined');

model.view('view1').set('showDirections', false);

model.physics('emw').feature('lport1').set('hPort', 'gap_size');
model.physics('emw').feature('lport1').set('wPort', '2*pi*r_antenna');
model.physics('emw').feature('lport1').set('ahPort', [0 0 1]);
model.physics('emw').create('ffd1', 'FarFieldDomain', 3);

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
model.material.create('mat2', 'Common', 'comp1');
model.material('mat2').propertyGroup.create('Enu', 'Young''s modulus and Poisson''s ratio');
model.material('mat2').propertyGroup.create('linzRes', 'Linearized resistivity');
model.material('mat2').label('Copper');
model.material('mat2').set('family', 'copper');
model.material('mat2').propertyGroup('def').set('relpermeability', {'1' '0' '0' '0' '1' '0' '0' '0' '1'});
model.material('mat2').propertyGroup('def').set('electricconductivity', {'5.998e7[S/m]' '0' '0' '0' '5.998e7[S/m]' '0' '0' '0' '5.998e7[S/m]'});
model.material('mat2').propertyGroup('def').set('thermalexpansioncoefficient', {'17e-6[1/K]' '0' '0' '0' '17e-6[1/K]' '0' '0' '0' '17e-6[1/K]'});
model.material('mat2').propertyGroup('def').set('heatcapacity', '385[J/(kg*K)]');
model.material('mat2').propertyGroup('def').set('relpermittivity', {'1' '0' '0' '0' '1' '0' '0' '0' '1'});
model.material('mat2').propertyGroup('def').set('density', '8960[kg/m^3]');
model.material('mat2').propertyGroup('def').set('thermalconductivity', {'400[W/(m*K)]' '0' '0' '0' '400[W/(m*K)]' '0' '0' '0' '400[W/(m*K)]'});
model.material('mat2').propertyGroup('Enu').set('E', '110[GPa]');
model.material('mat2').propertyGroup('Enu').set('nu', '0.35');
model.material('mat2').propertyGroup('linzRes').set('rho0', '1.72e-8[ohm*m]');
model.material('mat2').propertyGroup('linzRes').set('alpha', '0.0039[1/K]');
model.material('mat2').propertyGroup('linzRes').set('Tref', '298[K]');
model.material('mat2').propertyGroup('linzRes').addInput('temperature');
model.material('mat2').selection.set([6 8]);

model.mesh('mesh1').run;

model.sol.create('sol1');
model.sol('sol1').study('std1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'freq');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').set('control', 'freq');
model.sol('sol1').create('s1', 'Stationary');
model.sol('sol1').feature('s1').set('stol', 0.01);
model.sol('sol1').feature('s1').create('p1', 'Parametric');
model.sol('sol1').feature('s1').feature.remove('pDef');
model.sol('sol1').feature('s1').feature('p1').set('pname', {'freq'});
model.sol('sol1').feature('s1').feature('p1').set('plistarr', {'c_const/lda0'});
model.sol('sol1').feature('s1').feature('p1').set('punit', {'GHz'});
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
model.sol('sol1').feature('s1').feature('aDef').set('cachepattern', false);
model.sol('sol1').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('s1').create('i1', 'Iterative');
model.sol('sol1').feature('s1').feature('i1').set('linsolver', 'gmres');
model.sol('sol1').feature('s1').feature('i1').set('prefuntype', 'right');
model.sol('sol1').feature('s1').feature('i1').set('itrestart', '300');
model.sol('sol1').feature('s1').feature('i1').label('Suggested Iterative Solver (emw)');
model.sol('sol1').feature('s1').feature('i1').create('mg1', 'Multigrid');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').set('iter', '1');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('pr').create('sv1', 'SORVector');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('pr').feature('sv1').set('prefun', 'sorvec');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('pr').feature('sv1').set('iter', 2);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('pr').feature('sv1').set('relax', 1);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('pr').feature('sv1').set('sorvecdof', {'comp1_E'});
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('po').create('sv1', 'SORVector');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('po').feature('sv1').set('prefun', 'soruvec');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('po').feature('sv1').set('iter', 2);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('po').feature('sv1').set('relax', 1);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('po').feature('sv1').set('sorvecdof', {'comp1_E'});
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('cs').create('d1', 'Direct');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('cs').feature('d1').set('linsolver', 'pardiso');
model.sol('sol1').feature('s1').feature('fc1').set('linsolver', 'i1');
model.sol('sol1').feature('s1').feature.remove('fcDef');
model.sol('sol1').attach('std1');
model.sol('sol1').runAll;

model.result.create('pg1', 'PlotGroup3D');
model.result('pg1').label('Electric Field (emw)');
model.result('pg1').set('frametype', 'spatial');
model.result('pg1').set('showlegendsmaxmin', true);
model.result('pg1').set('data', 'dset1');
model.result('pg1').setIndex('looplevel', 1, 0);
model.result('pg1').set('defaultPlotID', 'ElectromagneticWaves/phys1/pdef1/pcond1/pg1');
model.result('pg1').feature.create('mslc1', 'Multislice');
model.result('pg1').feature('mslc1').label('Multislice');
model.result('pg1').feature('mslc1').set('smooth', 'internal');
model.result('pg1').feature('mslc1').set('data', 'parent');
model.result('pg1').feature('mslc1').feature.create('filt1', 'Filter');
model.result('pg1').feature('mslc1').feature('filt1').set('expr', '!isScalingSystemDomain');
model.result.numerical.create('gev1', 'EvalGlobal');
model.result.numerical('gev1').label('S-parameter (emw)');
model.result.numerical('gev1').set('data', 'dset1');
model.result.numerical('gev1').set('expr', {'emw.S11dB'});
model.result.table.create('tbl1', 'Table');
model.result.numerical('gev1').set('table', 'tbl1');
model.result.numerical('gev1').run;
model.result.numerical('gev1').setResult;
model.result.create('pg2', 'PolarGroup');
model.result('pg2').label('2D Far Field (emw)');
model.result('pg2').set('data', 'dset1');
model.result('pg2').create('rp1', 'RadiationPattern');
model.result('pg2').feature('rp1').set('legend', 'on');
model.result('pg2').feature('rp1').set('phidisc', '180');
model.result('pg2').feature('rp1').set('expr', {'emw.normEfar'});
model.result('pg2').feature('rp1').create('exp1', 'Export');
model.result.create('pg3', 'PlotGroup3D');
model.result('pg3').label('3D Far Field, Gain (emw)');
model.result('pg3').set('data', 'dset1');
model.result('pg3').set('view', 'new');
model.result('pg3').set('edges', 'off');
model.result('pg3').set('showlegendsmaxmin', true);
model.result('pg3').create('rp1', 'RadiationPattern');
model.result('pg3').feature('rp1').set('expr', {'emw.rGaindBEfar'});
model.result('pg3').feature('rp1').set('colorexpr', {'emw.normEfar'});
model.result('pg3').feature('rp1').set('useradiusascolor', true);
model.result('pg3').feature('rp1').set('directivityexpr', {'emw.normEfar^2'});
model.result('pg3').feature('rp1').set('thetadisc', '45');
model.result('pg3').feature('rp1').set('phidisc', '45');
model.result('pg3').feature('rp1').set('directivity', 'on');
model.result('pg3').feature('rp1').set('colortable', 'RainbowLight');
model.result('pg3').feature('rp1').create('exp1', 'Export');
model.result('pg3').feature('rp1').feature('exp1').setIndex('expr', 'comp1.emw.theta', 0);
model.result('pg3').feature('rp1').feature('exp1').setIndex('expr', 'comp1.emw.phi', 1);
model.result('pg2').feature('rp1').feature('exp1').setIndex('expr', 'comp1.emw.theta', 0);
model.result('pg2').feature('rp1').feature('exp1').setIndex('expr', 'comp1.emw.phi', 1);
model.result('pg1').run;
model.result('pg1').run;
model.result('pg1').run;
model.result('pg1').feature('mslc1').set('xnumber', '0');
model.result('pg1').feature('mslc1').set('znumber', '0');
model.result('pg1').feature('mslc1').set('rangecoloractive', true);
model.result('pg1').feature('mslc1').set('rangecolormax', 20);
model.result('pg1').feature('mslc1').set('colortable', 'JupiterAuroraBorealis');
model.result('pg1').run;
model.result('pg1').run;
model.result('pg1').create('arwv1', 'ArrowVolume');
model.result('pg1').feature('arwv1').set('xnumber', 21);
model.result('pg1').feature('arwv1').set('ynumber', 1);
model.result('pg1').feature('arwv1').set('znumber', 21);
model.result('pg1').feature('arwv1').set('arrowlength', 'logarithmic');
model.result('pg1').feature('arwv1').set('color', 'white');
model.result('pg1').run;
model.result('pg1').create('slc1', 'Slice');
model.result('pg1').feature('slc1').set('expr', '20*log10(emw.normH)');
model.result('pg1').feature('slc1').set('quickplane', 'xy');
model.result('pg1').feature('slc1').set('quickznumber', 1);
model.result('pg1').feature('slc1').set('colortable', 'Thermal');
model.result('pg1').feature('slc1').set('colortabletrans', 'reverse');
model.result('pg1').feature('slc1').create('tran1', 'Transparency');
model.result('pg1').run;
model.result('pg1').feature('slc1').feature('tran1').set('transparency', 0.25);
model.result('pg1').run;
model.result('pg1').selection.geom('geom1', 3);
model.result('pg1').selection.geom('geom1', 3);
model.result('pg1').selection.set([5]);
model.result('pg1').set('applyselectiontodatasetedges', true);
model.result('pg1').run;
model.result('pg2').run;
model.result('pg2').set('axislimits', true);
model.result('pg2').set('rmin', -20);
model.result('pg2').set('rmax', 0);
model.result('pg2').run;
model.result('pg2').feature('rp1').set('expr', 'emw.normdBEfar');
model.result('pg2').feature('rp1').set('legendmethod', 'manual');
model.result('pg2').feature('rp1').setIndex('legends', 'H-plane', 0);
model.result('pg2').run;
model.result('pg2').feature.duplicate('rp2', 'rp1');
model.result('pg2').run;
model.result('pg2').feature('rp2').set('normal', [0 1 0]);
model.result('pg2').feature('rp2').set('beamwidth', true);
model.result('pg2').feature('rp2').set('leveldown', 3);
model.result('pg2').feature('rp2').setIndex('legends', 'E-plane', 0);
model.result('pg2').run;
model.result('pg3').set('applyselectiontodatasetedges', false);
model.result('pg3').run;
model.result.numerical.create('gev2', 'EvalGlobal');
model.result.numerical('gev2').set('expr', {'emw.Zport_1'});
model.result.numerical('gev2').set('descr', {'Lumped port 1 impedance'});
model.result.numerical('gev2').set('unit', {['ohm' ]});
model.result.table.create('tbl2', 'Table');
model.result.table('tbl2').comments('Global Evaluation 2');
model.result.numerical('gev2').set('table', 'tbl2');
model.result.numerical('gev2').setResult;
model.result.create('pg4', 'PlotGroup3D');
model.result('pg4').run;
model.result('pg4').create('iso1', 'Isosurface');
model.result('pg4').feature('iso1').set('expr', '20*log10(emw.normE)');
model.result('pg4').feature('iso1').set('number', 15);
model.result('pg4').feature('iso1').set('colortable', 'HeatCamera');
model.result('pg4').feature('iso1').set('colortabletrans', 'reverse');
model.result('pg4').feature('iso1').create('filt1', 'Filter');
model.result('pg4').run;
model.result('pg4').feature('iso1').feature('filt1').set('expr', 'y>0');
model.result('pg4').run;
model.result('pg4').feature('iso1').create('sel1', 'Selection');
model.result('pg4').feature('iso1').feature('sel1').selection.set([5]);
model.result('pg4').run;
model.result('pg4').run;
model.result('pg4').set('edges', false);
model.result('pg4').run;

model.title('Dipole Antenna');

model.description('The dipole antenna is one of the most straightforward antenna configurations. It can be realized with two thin metallic rods that have a sinusoidal voltage difference applied between them. The length of the rods is chosen such that they are quarter wavelength elements at the operating frequency. Such an antenna has a well-known torus-like radiation pattern.');

model.mesh.clearMeshes;

model.sol('sol1').clearSolutionData;

model.label('dipole_antenna.mph');

model.modelNode.label('Components');

out = model;
