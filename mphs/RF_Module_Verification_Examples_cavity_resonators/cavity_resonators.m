function out = model
%
% cavity_resonators.m
%
% Model exported on May 26 2025, 21:32 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/RF_Module/Verification_Examples');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 3);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.physics.create('emw', 'ElectromagneticWaves', 'geom1');
model.physics('emw').model('comp1');

model.study.create('std1');
model.study('std1').create('eig', 'Eigenfrequency');
model.study('std1').feature('eig').set('conrad', '1');
model.study('std1').feature('eig').set('conradynhm', '1');
model.study('std1').feature('eig').set('linpsolnum', 'auto');
model.study('std1').feature('eig').set('solnum', 'auto');
model.study('std1').feature('eig').set('notsolnum', 'auto');
model.study('std1').feature('eig').set('outputmap', {});
model.study('std1').feature('eig').set('ngenAUX', '1');
model.study('std1').feature('eig').set('goalngenAUX', '1');
model.study('std1').feature('eig').set('ngenAUX', '1');
model.study('std1').feature('eig').set('goalngenAUX', '1');
model.study('std1').feature('eig').setSolveFor('/physics/emw', true);

% To import content from file, use:
% model.param.loadFile('FILENAME');
model.param.set('eta', 'sqrt(mu0_const/epsilon0_const)', 'Characteristic impedance, free space');
model.param.set('sigma_wall', '5.7e7[S/m]', 'Conductivity, cavity wall');
model.param.set('d_f', '1', 'Discretization factor');
model.param.set('a_r', '0.9[in]', 'Width and depth of rectangular cavity');
model.param.set('b_r', '0.4[in]', 'Height of rectangular cavity');
model.param.set('h_max_r', 'a_r', 'Maximum element size for rectangular cavity');
model.param.set('f_TE101_analytic_r', 'sqrt(2)/(2*a_r*sqrt(mu0_const*epsilon0_const))', 'Resonant frequency, analytic TE101 for rectangular cavity');
model.param.set('Q_TE101_analytic_r', '1.1107*(eta/sqrt(2*pi*f_TE101_analytic_r*mu0_const/(2*sigma_wall)))*(1/(1+((a_r/2)/b_r)))', 'Q-factor, analytic, mode dependent for rectangular cavity');
model.param.set('a_c', '0.48[in]', 'Radius of cylindrical cavity');
model.param.set('height_c', '0.4[in]', 'Height of cylindrical cavity');
model.param.set('h_max_c', '2*a_c', 'Maximum element size for cylindrical cavity');
model.param.set('f_TM010_analytic_c', '(1/(2*pi*sqrt(mu0_const*epsilon0_const)))*(2.4049/a_c)', 'Resonant frequency, analytic TM010 for cylindrical cavity');
model.param.set('Q_TM010_analytic_c', '1.2025*(eta/sqrt(2*pi*f_TM010_analytic_c*mu0_const/(2*sigma_wall)))*(1/(1+(a_c/height_c)))', 'Q-factor, analytic, mode dependent for cylindrical cavity');
model.param.set('a_s', '1.35[cm]', 'Radius of spherical cavity');
model.param.set('h_max_s', '2*a_s', 'Maximum element size for spherical cavity');
model.param.set('f_TM011_analytic_s', '2.744/(2*pi*a_s*sqrt(epsilon0_const*mu0_const))', 'Resonant frequency, analytic TM011 for spherical cavity');
model.param.set('Q_TM011_analytic_s', '1.004*eta/sqrt(2*pi*f_TM011_analytic_s*mu0_const/(2*sigma_wall))', 'Q-factor, analytic, mode dependent for spherical cavity');

model.material.create('mat1', 'Common', '');
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
model.material.create('mat2', 'Common', '');
model.material('mat2').label('Lossy Wall');
model.material('mat2').propertyGroup('def').set('relpermittivity', '');
model.material('mat2').propertyGroup('def').set('relpermeability', '');
model.material('mat2').propertyGroup('def').set('electricconductivity', '');
model.material('mat2').propertyGroup('def').set('relpermittivity', {'1'});
model.material('mat2').propertyGroup('def').set('relpermeability', {'1'});
model.material('mat2').propertyGroup('def').set('electricconductivity', {'sigma_wall'});

model.geom('geom1').create('blk1', 'Block');
model.geom('geom1').feature('blk1').set('size', {'a_r' 'a_r' 'b_r'});
model.geom('geom1').runPre('fin');
model.geom('geom1').run;

model.physics('emw').create('imp1', 'Impedance', 2);
model.physics('emw').feature('imp1').selection.all;

model.material.create('matlnk1', 'Link', 'comp1');
model.material.create('matlnk2', 'Link', 'comp1');
model.material('matlnk2').selection.geom('geom1', 2);
model.material('matlnk2').selection.all;
model.material('matlnk2').set('link', 'mat2');

model.cpl.create('intop1', 'Integration', 'geom1');
model.cpl('intop1').set('axisym', true);
model.cpl('intop1').set('opname', 'int_v');
model.cpl('intop1').selection.all;
model.cpl.create('intop2', 'Integration', 'geom1');
model.cpl('intop2').set('axisym', true);
model.cpl('intop2').set('opname', 'int_s');
model.cpl('intop2').selection.geom('geom1', 2);
model.cpl('intop2').selection.all;

model.variable.create('var1');
model.variable('var1').model('comp1');

% To import content from file, use:
% model.variable('var1').loadFile('FILENAME');
model.variable('var1').set('W_t', 'int_v(emw.Wav)', 'Average energy stored');
model.variable('var1').set('P_d', 'int_s(emw.Qsh)', 'Dissipated power');
model.variable('var1').set('Q_definition', '2*pi*emw.freq*W_t/P_d', 'Q-factor, definition');
model.variable('var1').set('Q_computed', 'emw.Qfactor', 'Q-factor, computed from eigenvalue');
model.variable('var1').set('frequency', 'emw.freq', 'Frequency, simulated');

model.mesh('mesh1').create('ftet1', 'FreeTet');
model.mesh('mesh1').feature('size').set('custom', true);
model.mesh('mesh1').feature('size').set('hmax', 'h_max_r/d_f');
model.mesh('mesh1').feature('size').set('hgrad', 2);
model.mesh('mesh1').feature('size').set('hcurve', 1);
model.mesh('mesh1').feature('size').set('hnarrow', 0.1);
model.mesh('mesh1').run;

model.study('std1').feature('eig').set('neigsactive', true);
model.study('std1').feature('eig').set('neigs', 1);
model.study('std1').feature('eig').set('shift', '9[GHz]');
model.study('std1').create('param', 'Parametric');
model.study('std1').feature('param').setIndex('pname', 'eta', 0);
model.study('std1').feature('param').setIndex('plistarr', '', 0);
model.study('std1').feature('param').setIndex('punit', ['ohm' ], 0);
model.study('std1').feature('param').setIndex('pname', 'eta', 0);
model.study('std1').feature('param').setIndex('plistarr', '', 0);
model.study('std1').feature('param').setIndex('punit', ['ohm' ], 0);
model.study('std1').feature('param').setIndex('pname', 'd_f', 0);
model.study('std1').feature('param').setIndex('plistarr', '1 2 4 8', 0);

model.sol.create('sol1');
model.sol('sol1').study('std1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'eig');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').set('control', 'eig');
model.sol('sol1').create('e1', 'Eigenvalue');
model.sol('sol1').feature('e1').set('eigref', '9[GHz]');
model.sol('sol1').feature('e1').set('control', 'eig');
model.sol('sol1').feature('e1').feature('aDef').set('complexfun', true);
model.sol('sol1').feature('e1').feature('aDef').set('cachepattern', false);
model.sol('sol1').feature('e1').create('d1', 'Direct');
model.sol('sol1').feature('e1').feature('d1').set('linsolver', 'pardiso');
model.sol('sol1').feature('e1').feature('d1').label('Suggested Direct Solver (emw)');
model.sol('sol1').feature('e1').create('i1', 'Iterative');
model.sol('sol1').feature('e1').feature('i1').set('linsolver', 'gmres');
model.sol('sol1').feature('e1').feature('i1').set('prefuntype', 'right');
model.sol('sol1').feature('e1').feature('i1').set('itrestart', '300');
model.sol('sol1').feature('e1').feature('i1').label('Suggested Iterative Solver (emw)');
model.sol('sol1').feature('e1').feature('i1').create('mg1', 'Multigrid');
model.sol('sol1').feature('e1').feature('i1').feature('mg1').set('iter', '1');
model.sol('sol1').feature('e1').feature('i1').feature('mg1').feature('pr').create('sv1', 'SORVector');
model.sol('sol1').feature('e1').feature('i1').feature('mg1').feature('pr').feature('sv1').set('prefun', 'sorvec');
model.sol('sol1').feature('e1').feature('i1').feature('mg1').feature('pr').feature('sv1').set('iter', 2);
model.sol('sol1').feature('e1').feature('i1').feature('mg1').feature('pr').feature('sv1').set('relax', 1);
model.sol('sol1').feature('e1').feature('i1').feature('mg1').feature('pr').feature('sv1').set('sorvecdof', {'comp1_E'});
model.sol('sol1').feature('e1').feature('i1').feature('mg1').feature('po').create('sv1', 'SORVector');
model.sol('sol1').feature('e1').feature('i1').feature('mg1').feature('po').feature('sv1').set('prefun', 'soruvec');
model.sol('sol1').feature('e1').feature('i1').feature('mg1').feature('po').feature('sv1').set('iter', 2);
model.sol('sol1').feature('e1').feature('i1').feature('mg1').feature('po').feature('sv1').set('relax', 1);
model.sol('sol1').feature('e1').feature('i1').feature('mg1').feature('po').feature('sv1').set('sorvecdof', {'comp1_E'});
model.sol('sol1').feature('e1').feature('i1').feature('mg1').feature('cs').create('d1', 'Direct');
model.sol('sol1').feature('e1').feature('i1').feature('mg1').feature('cs').feature('d1').set('linsolver', 'pardiso');
model.sol('sol1').feature('e1').feature('d1').active(true);
model.sol('sol1').attach('std1');

model.batch.create('p1', 'Parametric');
model.batch('p1').study('std1');
model.batch('p1').create('so1', 'Solutionseq');
model.batch('p1').feature('so1').set('seq', 'sol1');
model.batch('p1').feature('so1').set('store', 'on');
model.batch('p1').feature('so1').set('clear', 'on');
model.batch('p1').feature('so1').set('psol', 'none');
model.batch('p1').set('pname', {'d_f'});
model.batch('p1').set('plistarr', {'1 2 4 8'});
model.batch('p1').set('sweeptype', 'sparse');
model.batch('p1').set('probesel', 'all');
model.batch('p1').set('probes', {});
model.batch('p1').set('plot', 'off');
model.batch('p1').set('err', 'on');
model.batch('p1').attach('std1');
model.batch('p1').set('control', 'param');

model.sol.create('sol2');
model.sol('sol2').study('std1');
model.sol('sol2').label('Parametric Solutions 1');

model.batch('p1').feature('so1').set('psol', 'sol2');
model.batch('p1').run('compute');

model.result.create('pg1', 'PlotGroup3D');
model.result('pg1').label('Electric Field (emw)');
model.result('pg1').set('data', 'dset2');
model.result('pg1').setIndex('looplevel', 1, 0);
model.result('pg1').setIndex('looplevel', 4, 1);
model.result('pg1').set('frametype', 'spatial');
model.result('pg1').set('showlegendsmaxmin', true);
model.result('pg1').set('data', 'dset2');
model.result('pg1').setIndex('looplevel', 1, 0);
model.result('pg1').setIndex('looplevel', 4, 1);
model.result('pg1').set('defaultPlotID', 'ElectromagneticWaves/phys1/pdef1/pcond1/pg1');
model.result('pg1').feature.create('mslc1', 'Multislice');
model.result('pg1').feature('mslc1').label('Multislice');
model.result('pg1').feature('mslc1').set('smooth', 'internal');
model.result('pg1').feature('mslc1').set('data', 'parent');
model.result('pg1').feature('mslc1').feature.create('filt1', 'Filter');
model.result('pg1').feature('mslc1').feature('filt1').set('expr', '!isScalingSystemDomain');
model.result.numerical.create('gev1', 'EvalGlobal');
model.result.numerical('gev1').label('Eigenfrequencies (emw)');
model.result.numerical('gev1').set('data', 'dset2');
model.result.numerical('gev1').set('expr', {'emw.freq' 'emw.Qfactor'});
model.result.numerical('gev1').set('unit', {'GHz' '1'});
model.result.table.create('tbl1', 'Table');
model.result.numerical('gev1').set('table', 'tbl1');
model.result.numerical('gev1').run;
model.result.numerical('gev1').setResult;
model.result('pg1').run;
model.result('pg1').create('arwv1', 'ArrowVolume');
model.result('pg1').feature('arwv1').set('expr', {'emw.Ex' 'emw.Ey' 'emw.Ez'});
model.result('pg1').feature('arwv1').set('descr', 'Electric field');
model.result('pg1').run;
model.result('pg1').run;
model.result('pg1').create('arwv2', 'ArrowVolume');
model.result('pg1').feature('arwv2').set('expr', {'emw.Hx' 'emw.Hy' 'emw.Hz'});
model.result('pg1').feature('arwv2').set('descr', 'Magnetic field');
model.result('pg1').feature('arwv2').set('znumber', 1);
model.result('pg1').feature('arwv2').set('color', 'white');
model.result('pg1').run;
model.result.create('pg2', 'PlotGroup3D');
model.result('pg2').run;
model.result('pg2').create('surf1', 'Surface');
model.result('pg2').feature('surf1').set('expr', 'emw.Qsh');
model.result('pg2').feature('surf1').set('descr', 'Surface losses');
model.result('pg2').feature('surf1').set('colortable', 'ThermalDark');
model.result('pg2').run;
model.result('pg2').label('Surface Losses (emw)');
model.result('pg2').create('arws1', 'ArrowSurface');
model.result('pg2').feature('arws1').set('expr', {'emw.Jsx' 'emw.Jsy' 'emw.Jsz'});
model.result('pg2').feature('arws1').set('descr', 'Surface current density');
model.result('pg2').feature('arws1').set('color', 'blue');
model.result('pg2').run;

model.modelNode.create('comp2', true);

model.geom.create('geom2', 3);
model.geom('geom2').model('comp2');

model.mesh.create('mesh2', 'geom2');

model.physics.create('emw2', 'ElectromagneticWaves', 'geom2');
model.physics('emw2').model('comp2');

model.study('std1').feature('eig').setSolveFor('/physics/emw2', true);

model.geom('geom2').run;

model.study.create('std2');

model.geom('geom2').create('cyl1', 'Cylinder');
model.geom('geom2').feature('cyl1').set('r', 'a_c');
model.geom('geom2').feature('cyl1').set('h', 'height_c');
model.geom('geom2').runPre('fin');
model.geom('geom2').run;

model.physics('emw2').create('imp1', 'Impedance', 2);
model.physics('emw2').feature('imp1').selection.all;

model.material.create('matlnk3', 'Link', 'comp2');
model.material.create('matlnk4', 'Link', 'comp2');
model.material('matlnk4').selection.geom('geom2', 2);
model.material('matlnk4').selection.all;
model.material('matlnk4').set('link', 'mat2');

model.cpl.create('intop3', 'Integration', 'geom2');
model.cpl('intop3').set('axisym', true);
model.cpl('intop3').set('opname', 'int_v');
model.cpl('intop3').selection.all;
model.cpl.create('intop4', 'Integration', 'geom2');
model.cpl('intop4').set('axisym', true);
model.cpl('intop4').set('opname', 'int_s');
model.cpl('intop4').selection.geom('geom2', 2);
model.cpl('intop4').selection.all;

model.variable.create('var2');
model.variable('var2').model('comp2');

% To import content from file, use:
% model.variable('var2').loadFile('FILENAME');
model.variable('var2').set('W_t', 'int_v(emw2.Wav)', 'Average energy stored');
model.variable('var2').set('P_d', 'int_s(emw2.Qsh)', 'Dissipated power');
model.variable('var2').set('Q_definition', '2*pi*emw2.freq*W_t/P_d', 'Q-factor, definition');
model.variable('var2').set('Q_computed', 'emw2.Qfactor', 'Q-factor, computed from eigenvalue');
model.variable('var2').set('frequency', 'emw2.freq', 'Frequency, simulated');

model.mesh('mesh2').create('ftet1', 'FreeTet');
model.mesh('mesh2').feature('size').set('custom', true);
model.mesh('mesh2').feature('size').set('hmax', 'h_max_c/d_f');
model.mesh('mesh2').feature('size').set('hgrad', 2);
model.mesh('mesh2').feature('size').set('hcurve', 1);
model.mesh('mesh2').feature('size').set('hnarrow', 0.1);
model.mesh('mesh2').run;

model.study('std2').feature.copy('param1', 'std1/param');
model.study('std2').feature.copy('eig1', 'std1/eig');
model.study('std2').feature('eig1').setEntry('activate', 'emw', false);
model.study('std2').feature('eig1').setEntry('activate', 'emw2', true);

model.sol.create('sol7');
model.sol('sol7').study('std2');
model.sol('sol7').create('st1', 'StudyStep');
model.sol('sol7').feature('st1').set('study', 'std2');
model.sol('sol7').feature('st1').set('studystep', 'eig1');
model.sol('sol7').create('v1', 'Variables');
model.sol('sol7').feature('v1').set('control', 'eig1');
model.sol('sol7').create('e1', 'Eigenvalue');
model.sol('sol7').feature('e1').set('eigref', '9[GHz]');
model.sol('sol7').feature('e1').set('control', 'eig1');
model.sol('sol7').feature('e1').feature('aDef').set('complexfun', true);
model.sol('sol7').feature('e1').feature('aDef').set('cachepattern', false);
model.sol('sol7').feature('e1').create('d1', 'Direct');
model.sol('sol7').feature('e1').feature('d1').set('linsolver', 'pardiso');
model.sol('sol7').feature('e1').feature('d1').label('Suggested Direct Solver (emw2)');
model.sol('sol7').feature('e1').create('i1', 'Iterative');
model.sol('sol7').feature('e1').feature('i1').set('linsolver', 'gmres');
model.sol('sol7').feature('e1').feature('i1').set('prefuntype', 'right');
model.sol('sol7').feature('e1').feature('i1').set('itrestart', '300');
model.sol('sol7').feature('e1').feature('i1').label('Suggested Iterative Solver (emw2)');
model.sol('sol7').feature('e1').feature('i1').create('mg1', 'Multigrid');
model.sol('sol7').feature('e1').feature('i1').feature('mg1').set('iter', '1');
model.sol('sol7').feature('e1').feature('i1').feature('mg1').feature('pr').create('sv1', 'SORVector');
model.sol('sol7').feature('e1').feature('i1').feature('mg1').feature('pr').feature('sv1').set('prefun', 'sorvec');
model.sol('sol7').feature('e1').feature('i1').feature('mg1').feature('pr').feature('sv1').set('iter', 2);
model.sol('sol7').feature('e1').feature('i1').feature('mg1').feature('pr').feature('sv1').set('relax', 1);
model.sol('sol7').feature('e1').feature('i1').feature('mg1').feature('pr').feature('sv1').set('sorvecdof', {'comp2_E2'});
model.sol('sol7').feature('e1').feature('i1').feature('mg1').feature('po').create('sv1', 'SORVector');
model.sol('sol7').feature('e1').feature('i1').feature('mg1').feature('po').feature('sv1').set('prefun', 'soruvec');
model.sol('sol7').feature('e1').feature('i1').feature('mg1').feature('po').feature('sv1').set('iter', 2);
model.sol('sol7').feature('e1').feature('i1').feature('mg1').feature('po').feature('sv1').set('relax', 1);
model.sol('sol7').feature('e1').feature('i1').feature('mg1').feature('po').feature('sv1').set('sorvecdof', {'comp2_E2'});
model.sol('sol7').feature('e1').feature('i1').feature('mg1').feature('cs').create('d1', 'Direct');
model.sol('sol7').feature('e1').feature('i1').feature('mg1').feature('cs').feature('d1').set('linsolver', 'pardiso');
model.sol('sol7').feature('e1').feature('d1').active(true);
model.sol('sol7').attach('std2');

model.batch.create('p2', 'Parametric');
model.batch('p2').study('std2');
model.batch('p2').create('so1', 'Solutionseq');
model.batch('p2').feature('so1').set('seq', 'sol7');
model.batch('p2').feature('so1').set('store', 'on');
model.batch('p2').feature('so1').set('clear', 'on');
model.batch('p2').feature('so1').set('psol', 'none');
model.batch('p2').set('pname', {'d_f'});
model.batch('p2').set('plistarr', {'1 2 4 8'});
model.batch('p2').set('sweeptype', 'sparse');
model.batch('p2').set('probesel', 'all');
model.batch('p2').set('probes', {});
model.batch('p2').set('plot', 'off');
model.batch('p2').set('err', 'on');
model.batch('p2').attach('std2');
model.batch('p2').set('control', 'param1');

model.sol.create('sol8');
model.sol('sol8').study('std2');
model.sol('sol8').label('Parametric Solutions 2');

model.batch('p2').feature('so1').set('psol', 'sol8');
model.batch('p2').run('compute');

model.result.create('pg3', 'PlotGroup3D');
model.result('pg3').label('Electric Field (emw2)');
model.result('pg3').set('data', 'dset6');
model.result('pg3').setIndex('looplevel', 1, 0);
model.result('pg3').setIndex('looplevel', 4, 1);
model.result('pg3').set('frametype', 'spatial');
model.result('pg3').set('showlegendsmaxmin', true);
model.result('pg3').set('data', 'dset6');
model.result('pg3').setIndex('looplevel', 1, 0);
model.result('pg3').setIndex('looplevel', 4, 1);
model.result('pg3').set('defaultPlotID', 'ElectromagneticWaves/phys1/pdef1/pcond1/pg1');
model.result('pg3').feature.create('mslc1', 'Multislice');
model.result('pg3').feature('mslc1').label('Multislice');
model.result('pg3').feature('mslc1').set('smooth', 'internal');
model.result('pg3').feature('mslc1').set('data', 'parent');
model.result('pg3').feature('mslc1').feature.create('filt1', 'Filter');
model.result('pg3').feature('mslc1').feature('filt1').set('expr', '!isScalingSystemDomain');
model.result.numerical.create('gev2', 'EvalGlobal');
model.result.numerical('gev2').label('Eigenfrequencies (emw2)');
model.result.numerical('gev2').set('data', 'dset6');
model.result.numerical('gev2').set('expr', {'emw2.freq' 'emw2.Qfactor'});
model.result.numerical('gev2').set('unit', {'GHz' '1'});
model.result.table.create('tbl2', 'Table');
model.result.numerical('gev2').set('table', 'tbl2');
model.result.numerical('gev2').run;
model.result.numerical('gev2').setResult;
model.result('pg3').run;
model.result('pg3').create('arwv1', 'ArrowVolume');
model.result('pg3').feature('arwv1').set('expr', {'emw2.Ex' 'emw2.Ey' 'emw2.Ez'});
model.result('pg3').feature('arwv1').set('descr', 'Electric field');
model.result('pg3').run;
model.result('pg3').run;
model.result('pg3').create('arwv2', 'ArrowVolume');
model.result('pg3').feature('arwv2').set('expr', {'emw2.Hx' 'emw2.Hy' 'emw2.Hz'});
model.result('pg3').feature('arwv2').set('descr', 'Magnetic field');
model.result('pg3').feature('arwv2').set('znumber', 1);
model.result('pg3').feature('arwv2').set('color', 'white');
model.result('pg3').run;
model.result.create('pg4', 'PlotGroup3D');
model.result('pg4').run;
model.result('pg4').set('data', 'dset6');
model.result('pg4').create('surf1', 'Surface');
model.result('pg4').feature('surf1').set('expr', 'emw2.Qsh');
model.result('pg4').feature('surf1').set('descr', 'Surface losses');
model.result('pg4').feature('surf1').set('colortable', 'ThermalDark');
model.result('pg4').run;
model.result('pg4').label('Surface Losses (emw2)');
model.result('pg4').create('arws1', 'ArrowSurface');
model.result('pg4').feature('arws1').set('expr', {'emw2.Jsx' 'emw2.Jsy' 'emw2.Jsz'});
model.result('pg4').feature('arws1').set('descr', 'Surface current density');
model.result('pg4').feature('arws1').set('color', 'blue');
model.result('pg4').run;

model.modelNode.create('comp3', true);

model.geom.create('geom3', 3);
model.geom('geom3').model('comp3');

model.mesh.create('mesh3', 'geom3');

model.physics.create('emw3', 'ElectromagneticWaves', 'geom3');
model.physics('emw3').model('comp3');

model.study('std1').feature('eig').setSolveFor('/physics/emw3', true);
model.study('std2').feature('eig1').setSolveFor('/physics/emw3', true);

model.geom('geom3').run;

model.study.create('std3');

model.geom('geom3').create('sph1', 'Sphere');
model.geom('geom3').feature('sph1').set('r', 'a_s');
model.geom('geom3').runPre('fin');
model.geom('geom3').run;

model.physics('emw3').create('imp1', 'Impedance', 2);
model.physics('emw3').feature('imp1').selection.all;

model.material.create('matlnk5', 'Link', 'comp3');
model.material.create('matlnk6', 'Link', 'comp3');
model.material('matlnk6').selection.geom('geom3', 2);
model.material('matlnk6').selection.all;
model.material('matlnk6').set('link', 'mat2');

model.cpl.create('intop5', 'Integration', 'geom3');
model.cpl('intop5').set('axisym', true);
model.cpl('intop5').set('opname', 'int_v');
model.cpl('intop5').selection.all;
model.cpl.create('intop6', 'Integration', 'geom3');
model.cpl('intop6').set('axisym', true);
model.cpl('intop6').set('opname', 'int_s');
model.cpl('intop6').selection.geom('geom3', 2);
model.cpl('intop6').selection.all;

model.variable.create('var3');
model.variable('var3').model('comp3');

% To import content from file, use:
% model.variable('var3').loadFile('FILENAME');
model.variable('var3').set('W_t', 'int_v(emw3.Wav)', 'Average energy stored');
model.variable('var3').set('P_d', 'int_s(emw3.Qsh)', 'Dissipated power');
model.variable('var3').set('Q_definition', '2*pi*emw3.freq*W_t/P_d', 'Q-factor, definition');
model.variable('var3').set('Q_computed', 'emw3.Qfactor', 'Q-factor, computed from eigenvalue');
model.variable('var3').set('frequency', 'emw3.freq', 'Frequency, simulated');

model.mesh('mesh3').create('ftet1', 'FreeTet');
model.mesh('mesh3').feature('size').set('custom', true);
model.mesh('mesh3').feature('size').set('hmax', 'h_max_s/d_f');
model.mesh('mesh3').feature('size').set('hgrad', 2);
model.mesh('mesh3').feature('size').set('hcurve', 1);
model.mesh('mesh3').feature('size').set('hnarrow', 0.1);
model.mesh('mesh3').run;

model.study('std3').feature.copy('param1', 'std2/param1');
model.study('std3').feature.copy('eig1', 'std2/eig1');
model.study('std3').feature('eig1').setEntry('activate', 'emw', false);
model.study('std3').feature('eig1').setEntry('activate', 'emw2', false);
model.study('std3').feature('eig1').setEntry('activate', 'emw3', true);

model.sol.create('sol13');
model.sol('sol13').study('std3');
model.sol('sol13').create('st1', 'StudyStep');
model.sol('sol13').feature('st1').set('study', 'std3');
model.sol('sol13').feature('st1').set('studystep', 'eig1');
model.sol('sol13').create('v1', 'Variables');
model.sol('sol13').feature('v1').set('control', 'eig1');
model.sol('sol13').create('e1', 'Eigenvalue');
model.sol('sol13').feature('e1').set('eigref', '9[GHz]');
model.sol('sol13').feature('e1').set('control', 'eig1');
model.sol('sol13').feature('e1').feature('aDef').set('complexfun', true);
model.sol('sol13').feature('e1').feature('aDef').set('cachepattern', false);
model.sol('sol13').feature('e1').create('d1', 'Direct');
model.sol('sol13').feature('e1').feature('d1').set('linsolver', 'pardiso');
model.sol('sol13').feature('e1').feature('d1').label('Suggested Direct Solver (emw3)');
model.sol('sol13').feature('e1').create('i1', 'Iterative');
model.sol('sol13').feature('e1').feature('i1').set('linsolver', 'gmres');
model.sol('sol13').feature('e1').feature('i1').set('prefuntype', 'right');
model.sol('sol13').feature('e1').feature('i1').set('itrestart', '300');
model.sol('sol13').feature('e1').feature('i1').label('Suggested Iterative Solver (emw3)');
model.sol('sol13').feature('e1').feature('i1').create('mg1', 'Multigrid');
model.sol('sol13').feature('e1').feature('i1').feature('mg1').set('iter', '1');
model.sol('sol13').feature('e1').feature('i1').feature('mg1').feature('pr').create('sv1', 'SORVector');
model.sol('sol13').feature('e1').feature('i1').feature('mg1').feature('pr').feature('sv1').set('prefun', 'sorvec');
model.sol('sol13').feature('e1').feature('i1').feature('mg1').feature('pr').feature('sv1').set('iter', 2);
model.sol('sol13').feature('e1').feature('i1').feature('mg1').feature('pr').feature('sv1').set('relax', 1);
model.sol('sol13').feature('e1').feature('i1').feature('mg1').feature('pr').feature('sv1').set('sorvecdof', {'comp3_E3'});
model.sol('sol13').feature('e1').feature('i1').feature('mg1').feature('po').create('sv1', 'SORVector');
model.sol('sol13').feature('e1').feature('i1').feature('mg1').feature('po').feature('sv1').set('prefun', 'soruvec');
model.sol('sol13').feature('e1').feature('i1').feature('mg1').feature('po').feature('sv1').set('iter', 2);
model.sol('sol13').feature('e1').feature('i1').feature('mg1').feature('po').feature('sv1').set('relax', 1);
model.sol('sol13').feature('e1').feature('i1').feature('mg1').feature('po').feature('sv1').set('sorvecdof', {'comp3_E3'});
model.sol('sol13').feature('e1').feature('i1').feature('mg1').feature('cs').create('d1', 'Direct');
model.sol('sol13').feature('e1').feature('i1').feature('mg1').feature('cs').feature('d1').set('linsolver', 'pardiso');
model.sol('sol13').feature('e1').feature('d1').active(true);
model.sol('sol13').attach('std3');

model.batch.create('p3', 'Parametric');
model.batch('p3').study('std3');
model.batch('p3').create('so1', 'Solutionseq');
model.batch('p3').feature('so1').set('seq', 'sol13');
model.batch('p3').feature('so1').set('store', 'on');
model.batch('p3').feature('so1').set('clear', 'on');
model.batch('p3').feature('so1').set('psol', 'none');
model.batch('p3').set('pname', {'d_f'});
model.batch('p3').set('plistarr', {'1 2 4 8'});
model.batch('p3').set('sweeptype', 'sparse');
model.batch('p3').set('probesel', 'all');
model.batch('p3').set('probes', {});
model.batch('p3').set('plot', 'off');
model.batch('p3').set('err', 'on');
model.batch('p3').attach('std3');
model.batch('p3').set('control', 'param1');

model.sol('sol13').study('std3');
model.sol('sol13').feature.remove('e1');
model.sol('sol13').feature.remove('v1');
model.sol('sol13').feature.remove('st1');
model.sol('sol13').create('st1', 'StudyStep');
model.sol('sol13').feature('st1').set('study', 'std3');
model.sol('sol13').feature('st1').set('studystep', 'eig1');
model.sol('sol13').create('v1', 'Variables');
model.sol('sol13').feature('v1').set('control', 'eig1');
model.sol('sol13').create('e1', 'Eigenvalue');
model.sol('sol13').feature('e1').set('eigref', '9[GHz]');
model.sol('sol13').feature('e1').set('control', 'eig1');
model.sol('sol13').feature('e1').feature('aDef').set('complexfun', true);
model.sol('sol13').feature('e1').feature('aDef').set('cachepattern', false);
model.sol('sol13').feature('e1').create('d1', 'Direct');
model.sol('sol13').feature('e1').feature('d1').set('linsolver', 'pardiso');
model.sol('sol13').feature('e1').feature('d1').label('Suggested Direct Solver (emw3)');
model.sol('sol13').feature('e1').create('i1', 'Iterative');
model.sol('sol13').feature('e1').feature('i1').set('linsolver', 'gmres');
model.sol('sol13').feature('e1').feature('i1').set('prefuntype', 'right');
model.sol('sol13').feature('e1').feature('i1').set('itrestart', '300');
model.sol('sol13').feature('e1').feature('i1').label('Suggested Iterative Solver (emw3)');
model.sol('sol13').feature('e1').feature('i1').create('mg1', 'Multigrid');
model.sol('sol13').feature('e1').feature('i1').feature('mg1').set('iter', '1');
model.sol('sol13').feature('e1').feature('i1').feature('mg1').feature('pr').create('sv1', 'SORVector');
model.sol('sol13').feature('e1').feature('i1').feature('mg1').feature('pr').feature('sv1').set('prefun', 'sorvec');
model.sol('sol13').feature('e1').feature('i1').feature('mg1').feature('pr').feature('sv1').set('iter', 2);
model.sol('sol13').feature('e1').feature('i1').feature('mg1').feature('pr').feature('sv1').set('relax', 1);
model.sol('sol13').feature('e1').feature('i1').feature('mg1').feature('pr').feature('sv1').set('sorvecdof', {'comp3_E3'});
model.sol('sol13').feature('e1').feature('i1').feature('mg1').feature('po').create('sv1', 'SORVector');
model.sol('sol13').feature('e1').feature('i1').feature('mg1').feature('po').feature('sv1').set('prefun', 'soruvec');
model.sol('sol13').feature('e1').feature('i1').feature('mg1').feature('po').feature('sv1').set('iter', 2);
model.sol('sol13').feature('e1').feature('i1').feature('mg1').feature('po').feature('sv1').set('relax', 1);
model.sol('sol13').feature('e1').feature('i1').feature('mg1').feature('po').feature('sv1').set('sorvecdof', {'comp3_E3'});
model.sol('sol13').feature('e1').feature('i1').feature('mg1').feature('cs').create('d1', 'Direct');
model.sol('sol13').feature('e1').feature('i1').feature('mg1').feature('cs').feature('d1').set('linsolver', 'pardiso');
model.sol('sol13').feature('e1').feature('d1').active(true);
model.sol('sol13').attach('std3');

model.batch('p3').feature.remove('so1');
model.batch('p3').create('so1', 'Solutionseq');
model.batch('p3').feature('so1').set('seq', 'sol13');
model.batch('p3').feature('so1').set('store', 'on');
model.batch('p3').feature('so1').set('clear', 'on');
model.batch('p3').feature('so1').set('psol', 'none');
model.batch('p3').set('pname', {'d_f'});
model.batch('p3').set('plistarr', {'1 2 4 8'});
model.batch('p3').set('sweeptype', 'sparse');
model.batch('p3').set('probesel', 'all');
model.batch('p3').set('probes', {});
model.batch('p3').set('plot', 'off');
model.batch('p3').set('err', 'on');
model.batch('p3').attach('std3');
model.batch('p3').set('control', 'param1');

model.sol.create('sol14');
model.sol('sol14').study('std3');
model.sol('sol14').label('Parametric Solutions 3');

model.batch('p3').feature('so1').set('psol', 'sol14');
model.batch('p3').run('compute');

model.result.create('pg5', 'PlotGroup3D');
model.result('pg5').label('Electric Field (emw3)');
model.result('pg5').set('data', 'dset12');
model.result('pg5').setIndex('looplevel', 1, 0);
model.result('pg5').setIndex('looplevel', 4, 1);
model.result('pg5').set('frametype', 'spatial');
model.result('pg5').set('showlegendsmaxmin', true);
model.result('pg5').set('data', 'dset12');
model.result('pg5').setIndex('looplevel', 1, 0);
model.result('pg5').setIndex('looplevel', 4, 1);
model.result('pg5').set('defaultPlotID', 'ElectromagneticWaves/phys1/pdef1/pcond1/pg1');
model.result('pg5').feature.create('mslc1', 'Multislice');
model.result('pg5').feature('mslc1').label('Multislice');
model.result('pg5').feature('mslc1').set('smooth', 'internal');
model.result('pg5').feature('mslc1').set('data', 'parent');
model.result('pg5').feature('mslc1').feature.create('filt1', 'Filter');
model.result('pg5').feature('mslc1').feature('filt1').set('expr', '!isScalingSystemDomain');
model.result.numerical.create('gev3', 'EvalGlobal');
model.result.numerical('gev3').label('Eigenfrequencies (emw3)');
model.result.numerical('gev3').set('data', 'dset12');
model.result.numerical('gev3').set('expr', {'emw3.freq' 'emw3.Qfactor'});
model.result.numerical('gev3').set('unit', {'GHz' '1'});
model.result.table.create('tbl3', 'Table');
model.result.numerical('gev3').set('table', 'tbl3');
model.result.numerical('gev3').run;
model.result.numerical('gev3').setResult;
model.result('pg5').run;
model.result('pg5').create('arwv1', 'ArrowVolume');
model.result('pg5').feature('arwv1').set('expr', {'emw3.Ex' 'emw3.Ey' 'emw3.Ez'});
model.result('pg5').feature('arwv1').set('descr', 'Electric field');
model.result('pg5').run;
model.result('pg5').create('arwv2', 'ArrowVolume');
model.result('pg5').feature('arwv2').set('expr', {'emw3.Hx' 'emw3.Hy' 'emw3.Hz'});
model.result('pg5').feature('arwv2').set('descr', 'Magnetic field');
model.result('pg5').feature('arwv2').set('znumber', 1);
model.result('pg5').feature('arwv2').set('color', 'white');
model.result('pg5').run;
model.result.create('pg6', 'PlotGroup3D');
model.result('pg6').run;
model.result('pg6').set('data', 'dset12');
model.result('pg6').create('surf1', 'Surface');
model.result('pg6').feature('surf1').set('expr', 'emw3.Qsh');
model.result('pg6').feature('surf1').set('descr', 'Surface losses');
model.result('pg6').feature('surf1').set('colortable', 'ThermalDark');
model.result('pg6').run;
model.result('pg6').label('Surface Losses (emw3)');
model.result('pg6').create('arws1', 'ArrowSurface');
model.result('pg6').feature('arws1').set('expr', {'emw3.Jsx' 'emw3.Jsy' 'emw3.Jsz'});
model.result('pg6').feature('arws1').set('descr', 'Surface current density');
model.result('pg6').feature('arws1').set('color', 'blue');
model.result('pg6').run;
model.result.numerical.create('gev4', 'EvalGlobal');
model.result.numerical('gev4').set('data', 'dset2');
model.result.numerical('gev4').setIndex('looplevelinput', 'first', 0);
model.result.numerical('gev4').set('tablecols', 'inner');
model.result.numerical('gev4').set('expr', {'Q_computed'});
model.result.numerical('gev4').set('descr', {'Q-factor, computed from eigenvalue'});
model.result.numerical('gev4').set('unit', {'1'});
model.result.table.create('tbl4', 'Table');
model.result.table('tbl4').comments('Global Evaluation 4');
model.result.numerical('gev4').set('table', 'tbl4');
model.result.numerical('gev4').setResult;
model.result.numerical('gev4').set('data', 'dset6');
model.result.numerical('gev4').set('table', 'tbl4');
model.result.numerical('gev4').appendResult;
model.result.numerical('gev4').set('data', 'dset12');
model.result.numerical('gev4').set('table', 'tbl4');
model.result.numerical('gev4').appendResult;
model.result.numerical.duplicate('gev5', 'gev4');
model.result.numerical('gev5').set('data', 'dset2');
model.result.numerical('gev5').set('expr', {'Q_definition'});
model.result.numerical('gev5').set('descr', {'Q-factor, definition'});
model.result.numerical('gev5').set('unit', {'1'});
model.result.table.create('tbl5', 'Table');
model.result.table('tbl5').comments('Global Evaluation 5');
model.result.numerical('gev5').set('table', 'tbl5');
model.result.numerical('gev5').setResult;
model.result.numerical('gev5').set('data', 'dset6');
model.result.numerical('gev5').set('table', 'tbl5');
model.result.numerical('gev5').appendResult;
model.result.numerical('gev5').set('data', 'dset12');
model.result.numerical('gev5').set('table', 'tbl5');
model.result.numerical('gev5').appendResult;
model.result.numerical.duplicate('gev6', 'gev4');
model.result.numerical('gev6').set('data', 'dset2');
model.result.numerical('gev6').set('expr', {'frequency'});
model.result.numerical('gev6').set('descr', {'Frequency, simulated'});
model.result.numerical('gev6').set('unit', {'Hz'});
model.result.table.create('tbl6', 'Table');
model.result.table('tbl6').comments('Global Evaluation 6');
model.result.numerical('gev6').set('table', 'tbl6');
model.result.numerical('gev6').setResult;
model.result.numerical('gev6').set('data', 'dset6');
model.result.numerical('gev6').set('table', 'tbl6');
model.result.numerical('gev6').appendResult;
model.result.numerical('gev6').set('data', 'dset12');
model.result.numerical('gev6').set('table', 'tbl6');
model.result.numerical('gev6').appendResult;

model.study('std1').feature('eig').setEntry('activate', 'emw2', false);
model.study('std1').feature('eig').setEntry('activate', 'emw3', false);
model.study('std2').feature('eig1').setEntry('activate', 'emw3', false);

model.title('Computing Q Factors and Resonant Frequencies of Cavity Resonators');

model.description('These models compute the resonant frequencies and Q-factors of rectangular, cylindrical, and spherical cavities. These geometries have known analytic solutions. Models and comparisons are presented. Mesh refinement studies are shown as well.');

model.mesh.clearMeshes;

model.sol('sol1').clearSolutionData;
model.sol('sol2').clearSolutionData;
model.sol('sol3').clearSolutionData;
model.sol('sol4').clearSolutionData;
model.sol('sol5').clearSolutionData;
model.sol('sol6').clearSolutionData;
model.sol('sol7').clearSolutionData;
model.sol('sol8').clearSolutionData;
model.sol('sol9').clearSolutionData;
model.sol('sol10').clearSolutionData;
model.sol('sol11').clearSolutionData;
model.sol('sol12').clearSolutionData;
model.sol('sol13').clearSolutionData;
model.sol('sol14').clearSolutionData;
model.sol('sol15').clearSolutionData;
model.sol('sol16').clearSolutionData;
model.sol('sol17').clearSolutionData;
model.sol('sol18').clearSolutionData;

model.label('cavity_resonators.mph');

model.modelNode.label('Components');

out = model;
