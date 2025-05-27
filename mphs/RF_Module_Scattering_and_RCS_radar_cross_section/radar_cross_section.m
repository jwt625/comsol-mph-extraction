function out = model
%
% radar_cross_section.m
%
% Model exported on May 26 2025, 21:32 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/RF_Module/Scattering_and_RCS');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 2);
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

model.geom('geom1').run;

model.study('std1').feature('freq').set('plist', '100[MHz]');

model.param.set('phi', '0[deg]');
model.param.descr('phi', 'Angle of incidence, degrees');
model.param.set('r0', '12[m]');
model.param.descr('r0', 'Radius, air domain');

model.geom('geom1').create('c1', 'Circle');
model.geom('geom1').feature('c1').set('r', 'r0+3[m]');
model.geom('geom1').feature('c1').setIndex('layername', 'Layer 1', 0);
model.geom('geom1').feature('c1').setIndex('layer', '3[m]', 0);
model.geom('geom1').run('c1');
model.geom('geom1').create('ca1', 'CircularArc');
model.geom('geom1').feature('ca1').set('specify', 'endsangle1');
model.geom('geom1').feature('ca1').set('point1', [6 0]);
model.geom('geom1').feature('ca1').set('point2', [4 2]);
model.geom('geom1').run('ca1');
model.geom('geom1').create('ca2', 'CircularArc');
model.geom('geom1').feature('ca2').set('specify', 'endsangle1');
model.geom('geom1').feature('ca2').set('point1', [4 -2]);
model.geom('geom1').feature('ca2').set('point2', [6 0]);
model.geom('geom1').feature('ca2').set('angle1', 270);
model.geom('geom1').run('ca2');
model.geom('geom1').create('ls1', 'LineSegment');
model.geom('geom1').feature('ls1').set('specify1', 'coord');
model.geom('geom1').feature('ls1').set('specify2', 'coord');
model.geom('geom1').feature('ls1').set('coord1', [-4 -2]);
model.geom('geom1').feature('ls1').set('coord2', [4 -2]);
model.geom('geom1').run('ls1');
model.geom('geom1').create('ls2', 'LineSegment');
model.geom('geom1').feature('ls2').set('specify1', 'coord');
model.geom('geom1').feature('ls2').set('specify2', 'coord');
model.geom('geom1').feature('ls2').set('coord1', [-4 2]);
model.geom('geom1').feature('ls2').set('coord2', [4 2]);
model.geom('geom1').run('ls2');
model.geom('geom1').create('qb1', 'QuadraticBezier');
model.geom('geom1').feature('qb1').setIndex('p', -4, 0, 0);
model.geom('geom1').feature('qb1').setIndex('p', 2, 1, 0);
model.geom('geom1').feature('qb1').setIndex('p', -6, 0, 1);
model.geom('geom1').feature('qb1').setIndex('p', 2, 1, 1);
model.geom('geom1').feature('qb1').setIndex('p', -8, 0, 2);
model.geom('geom1').run('qb1');
model.geom('geom1').create('qb2', 'QuadraticBezier');
model.geom('geom1').feature('qb2').setIndex('p', -8, 0, 0);
model.geom('geom1').feature('qb2').setIndex('p', -6, 0, 1);
model.geom('geom1').feature('qb2').setIndex('p', -2, 1, 1);
model.geom('geom1').feature('qb2').setIndex('p', -4, 0, 2);
model.geom('geom1').feature('qb2').setIndex('p', -2, 1, 2);
model.geom('geom1').run('qb2');
model.geom('geom1').create('csol1', 'ConvertToSolid');
model.geom('geom1').feature('csol1').selection('input').set({'ca1' 'ca2' 'ls1' 'ls2' 'qb1' 'qb2'});

model.selection.create('sel1', 'Explicit');
model.selection('sel1').model('comp1');

model.geom('geom1').run;

model.selection('sel1').label('Boat Boundaries');
model.selection('sel1').set([4]);
model.selection('sel1').geom('geom1', 2, 1, {'exterior'});
model.selection('sel1').set([4]);

model.coordSystem.create('pml1', 'geom1', 'PML');
model.coordSystem('pml1').selection.set([1 2 5 6]);
model.coordSystem('pml1').set('ScalingType', 'Cylindrical');

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
model.material('mat2').propertyGroup.create('Murnaghan', 'Murnaghan');
model.material('mat2').label('Aluminum');
model.material('mat2').set('family', 'aluminum');
model.material('mat2').propertyGroup('def').set('relpermeability', {'1' '0' '0' '0' '1' '0' '0' '0' '1'});
model.material('mat2').propertyGroup('def').set('heatcapacity', '900[J/(kg*K)]');
model.material('mat2').propertyGroup('def').set('thermalconductivity', {'238[W/(m*K)]' '0' '0' '0' '238[W/(m*K)]' '0' '0' '0' '238[W/(m*K)]'});
model.material('mat2').propertyGroup('def').set('electricconductivity', {'3.774e7[S/m]' '0' '0' '0' '3.774e7[S/m]' '0' '0' '0' '3.774e7[S/m]'});
model.material('mat2').propertyGroup('def').set('relpermittivity', {'1' '0' '0' '0' '1' '0' '0' '0' '1'});
model.material('mat2').propertyGroup('def').set('thermalexpansioncoefficient', {'23e-6[1/K]' '0' '0' '0' '23e-6[1/K]' '0' '0' '0' '23e-6[1/K]'});
model.material('mat2').propertyGroup('def').set('density', '2700[kg/m^3]');
model.material('mat2').propertyGroup('Enu').set('E', '70[GPa]');
model.material('mat2').propertyGroup('Enu').set('nu', '0.33');
model.material('mat2').propertyGroup('Murnaghan').set('l', '-250[GPa]');
model.material('mat2').propertyGroup('Murnaghan').set('m', '-330[GPa]');
model.material('mat2').propertyGroup('Murnaghan').set('n', '-350[GPa]');
model.material('mat2').selection.geom('geom1', 1);
model.material('mat2').selection.named('sel1');

model.physics('emw').selection.set([1 2 3 5 6]);
model.physics('emw').prop('BackgroundField').set('SolveFor', 'scatteredField');
model.physics('emw').prop('BackgroundField').set('Eb', {'0' '0' '1[V/m]*exp(j*emw.k0*(x*cos(phi)+y*sin(phi)))'});
model.physics('emw').prop('components').set('components', 'outofplane');
model.physics('emw').create('imp1', 'Impedance', 1);
model.physics('emw').feature('imp1').selection.named('sel1');
model.physics('emw').create('ffd1', 'FarFieldDomain', 2);

model.mesh('mesh1').run;

model.study('std1').feature('freq').set('useparam', true);
model.study('std1').feature('freq').setIndex('pname_aux', 'phi', 0);
model.study('std1').feature('freq').setIndex('plistarr_aux', '', 0);
model.study('std1').feature('freq').setIndex('punit_aux', 'rad', 0);
model.study('std1').feature('freq').setIndex('pname_aux', 'phi', 0);
model.study('std1').feature('freq').setIndex('plistarr_aux', '', 0);
model.study('std1').feature('freq').setIndex('punit_aux', 'rad', 0);
model.study('std1').feature('freq').setIndex('plistarr_aux', 'range(0,1,360)', 0);
model.study('std1').feature('freq').setIndex('punit_aux', 'deg', 0);

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
model.sol('sol1').feature('s1').feature('p1').set('pname', {'freq' 'phi'});
model.sol('sol1').feature('s1').feature('p1').set('punit', {'GHz' 'deg'});
model.sol('sol1').feature('s1').feature('p1').set('sweeptype', 'filled');
model.sol('sol1').feature('s1').feature('p1').set('plistarr', {'100[MHz]' 'range(0,1,360)'});
model.sol('sol1').feature('s1').feature('p1').set('pcontinuationmode', 'no');
model.sol('sol1').feature('s1').feature('p1').set('pcontinuation', '');
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
model.sol('sol1').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('s1').create('d1', 'Direct');
model.sol('sol1').feature('s1').feature('d1').set('linsolver', 'pardiso');
model.sol('sol1').feature('s1').feature('d1').label('Suggested Direct Solver (emw)');
model.sol('sol1').feature('s1').feature('fc1').set('linsolver', 'd1');
model.sol('sol1').feature('s1').feature.remove('fcDef');
model.sol('sol1').attach('std1');
model.sol('sol1').runAll;

model.result.create('pg1', 'PlotGroup2D');
model.result('pg1').label('Electric Field (emw)');
model.result('pg1').set('frametype', 'spatial');
model.result('pg1').set('showlegendsmaxmin', true);
model.result('pg1').set('data', 'dset1');
model.result('pg1').setIndex('looplevel', 361, 0);
model.result('pg1').setIndex('looplevel', 1, 1);
model.result('pg1').set('defaultPlotID', 'ElectromagneticWaves/phys1/pdef1/pcond2/pg1');
model.result('pg1').feature.create('surf1', 'Surface');
model.result('pg1').feature('surf1').label('Surface');
model.result('pg1').feature('surf1').set('smooth', 'internal');
model.result('pg1').feature('surf1').set('data', 'parent');
model.result.create('pg2', 'PolarGroup');
model.result('pg2').label('2D Far Field (emw)');
model.result('pg2').set('data', 'dset1');
model.result('pg2').create('rp1', 'RadiationPattern');
model.result('pg2').feature('rp1').set('legend', 'on');
model.result('pg2').feature('rp1').set('phidisc', '180');
model.result('pg2').feature('rp1').set('expr', {'emw.normEfar'});
model.result('pg2').feature('rp1').create('exp1', 'Export');
model.result('pg2').feature('rp1').feature('exp1').setIndex('expr', 'comp1.emw.phi', 0);
model.result('pg1').run;
model.result('pg1').run;
model.result('pg1').feature('surf1').create('sel1', 'Selection');
model.result('pg1').feature('surf1').feature('sel1').selection.set([3]);
model.result('pg1').run;
model.result('pg1').run;
model.result('pg1').setIndex('looplevel', 31, 0);
model.result('pg1').run;
model.result('pg1').run;
model.result('pg1').feature('surf1').set('expr', 'emw.Ez');
model.result('pg1').feature('surf1').set('descr', 'Electric field, z-component');
model.result('pg1').run;
model.result('pg1').feature('surf1').set('expr', 'emw.relEz');
model.result('pg1').feature('surf1').set('descr', 'Relative electric field, z-component');
model.result('pg1').run;
model.result('pg1').feature('surf1').set('expr', 'abs(comp1.emw.relEz)');
model.result('pg1').run;
model.result('pg2').run;
model.result('pg2').setIndex('looplevelinput', 'manual', 0);
model.result('pg2').setIndex('looplevel', [31], 0);
model.result('pg2').run;
model.result('pg2').feature('rp1').set('phidisc', 360);
model.result('pg2').run;
model.result.create('pg3', 'PolarGroup');
model.result('pg3').run;
model.result('pg3').create('glob1', 'Global');
model.result('pg3').feature('glob1').set('markerpos', 'datapoints');
model.result('pg3').feature('glob1').set('linewidth', 'preference');
model.result('pg3').feature('glob1').setIndex('expr', '10*log10(at2(r0*cos(phi),r0*sin(phi),emw.bRCS2D))', 0);
model.result('pg3').feature('glob1').set('xdata', 'expr');
model.result('pg3').feature('glob1').set('xdataexpr', 'phi');
model.result('pg3').feature('glob1').set('titletype', 'manual');
model.result('pg3').feature('glob1').set('title', 'RCS per unit length in dB');
model.result('pg3').run;

model.title('Radar Cross Section');

model.description('This example of a boat detected by a radar demonstrates the use of a background field in an electromagnetic scattering problem. Results include the radar cross section and the far field as functions of the angle of incidence.');

model.mesh.clearMeshes;

model.sol('sol1').clearSolutionData;

model.label('radar_cross_section.mph');

model.modelNode.label('Components');

out = model;
