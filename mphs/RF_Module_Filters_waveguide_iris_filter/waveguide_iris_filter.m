function out = model
%
% waveguide_iris_filter.m
%
% Model exported on May 26 2025, 21:32 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/RF_Module/Filters');

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

model.geom('geom1').run;

model.study('std1').feature('freq').set('plist', 'range(8.5[GHz],0.05[GHz],11.5[GHz])');

% To import content from file, use:
% model.param.loadFile('FILENAME');
model.param.set('w_wg', '2.286[cm]', 'Waveguide width');
model.param.set('h_wg', '1.016[cm]', 'Waveguide height');
model.param.set('d_iris', '0.3[cm]', 'Iris thickness');
model.param.set('l_iris1', '0.695[cm]', 'Iris length 1');
model.param.set('l_iris2', '0.53[cm]', 'Iris length 2');
model.param.set('spacing', '2.03[cm]', 'Iris spacing distance');

model.geom('geom1').lengthUnit('cm');
model.geom('geom1').create('blk1', 'Block');
model.geom('geom1').feature('blk1').label('WR-90');
model.geom('geom1').feature('blk1').set('size', {'12' 'w_wg' 'h_wg'});
model.geom('geom1').feature('blk1').set('base', 'center');
model.geom('geom1').runPre('fin');

model.view('view1').set('renderwireframe', true);

model.geom('geom1').create('blk2', 'Block');
model.geom('geom1').feature('blk2').label('Iris1');
model.geom('geom1').feature('blk2').set('size', {'d_iris' 'l_iris1' '1'});
model.geom('geom1').feature('blk2').setIndex('size', 'h_wg', 2);
model.geom('geom1').feature('blk2').set('base', 'center');
model.geom('geom1').feature('blk2').set('pos', {'spacing/2' '(w_wg-l_iris1)/2' '0'});
model.geom('geom1').run('blk2');
model.geom('geom1').create('blk3', 'Block');
model.geom('geom1').feature('blk3').label('Iris2');
model.geom('geom1').feature('blk3').set('size', {'d_iris' 'l_iris2' '1'});
model.geom('geom1').feature('blk3').setIndex('size', 'h_wg', 2);
model.geom('geom1').feature('blk3').set('base', 'center');
model.geom('geom1').feature('blk3').set('pos', {'spacing*1.42' '0' '0'});
model.geom('geom1').feature('blk3').setIndex('pos', '(w_wg-l_iris2)/2', 1);
model.geom('geom1').runPre('fin');
model.geom('geom1').create('mir1', 'Mirror');
model.geom('geom1').feature('mir1').selection('input').set({'blk2' 'blk3'});
model.geom('geom1').feature('mir1').set('keep', true);
model.geom('geom1').feature('mir1').set('axis', [1 0 0]);
model.geom('geom1').run('mir1');
model.geom('geom1').create('mir2', 'Mirror');
model.geom('geom1').feature('mir2').selection('input').set({'blk2' 'blk3' 'mir1'});
model.geom('geom1').feature('mir2').set('keep', true);
model.geom('geom1').feature('mir2').set('axis', [0 1 0]);
model.geom('geom1').run('mir2');
model.geom('geom1').create('dif1', 'Difference');
model.geom('geom1').feature('dif1').selection('input').set({'blk1'});
model.geom('geom1').feature('dif1').selection('input2').set({'blk2' 'blk3' 'mir1' 'mir2'});
model.geom('geom1').runPre('fin');
model.geom('geom1').run;

model.physics('emw').create('port1', 'Port', 2);
model.physics('emw').feature('port1').selection.set([1]);
model.physics('emw').feature('port1').set('PortType', 'Rectangular');
model.physics('emw').create('port2', 'Port', 2);
model.physics('emw').feature('port2').selection.set([38]);
model.physics('emw').feature('port2').set('PortType', 'Rectangular');

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
model.sol('sol1').feature('s1').feature('p1').set('plistarr', {'range(8.5[GHz],0.05[GHz],11.5[GHz])'});
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
model.sol('sol1').feature('s1').feature('aDef').set('cachepattern', true);
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
model.result('pg1').setIndex('looplevel', 61, 0);
model.result('pg1').set('defaultPlotID', 'ElectromagneticWaves/phys1/pdef1/pcond1/pg1');
model.result('pg1').feature.create('mslc1', 'Multislice');
model.result('pg1').feature('mslc1').label('Multislice');
model.result('pg1').feature('mslc1').set('smooth', 'internal');
model.result('pg1').feature('mslc1').set('data', 'parent');
model.result('pg1').feature('mslc1').feature.create('filt1', 'Filter');
model.result('pg1').feature('mslc1').feature('filt1').set('expr', '!isScalingSystemDomain');
model.result.create('pg2', 'PlotGroup1D');
model.result('pg2').set('data', 'dset1');
model.result('pg2').create('glob1', 'Global');
model.result('pg2').feature('glob1').set('unit', {'' ''});
model.result('pg2').feature('glob1').set('expr', {'emw.S11dB' 'emw.S21dB'});
model.result('pg2').feature('glob1').set('descr', {'S11' 'S21'});
model.result('pg2').label('S-parameter (emw)');
model.result('pg2').feature('glob1').set('titletype', 'none');
model.result('pg2').feature('glob1').set('xdata', 'expr');
model.result('pg2').set('ylabelactive', true);
model.result('pg2').set('ylabel', 'S-parameter (dB)');
model.result('pg2').feature('glob1').set('xdataexpr', 'freq');
model.result('pg2').feature('glob1').set('xdataunit', 'GHz');
model.result('pg2').feature('glob1').set('markerpos', 'datapoints');
model.result('pg2').feature('glob1').set('xdatasolnumtype', 'all');
model.result.create('pg3', 'SmithGroup');
model.result('pg3').set('data', 'dset1');
model.result('pg3').create('rgr1', 'ReflectionGraph');
model.result('pg3').feature('rgr1').set('unit', {''});
model.result('pg3').feature('rgr1').set('expr', {'emw.S11'});
model.result('pg3').feature('rgr1').set('descr', {'S11'});
model.result('pg3').label('Smith Plot (emw)');
model.result('pg3').feature('rgr1').set('titletype', 'manual');
model.result('pg3').feature('rgr1').set('title', 'Reflection Graph: S-parameter, Color: Frequency (GHz)');
model.result('pg3').feature('rgr1').set('linemarker', 'point');
model.result('pg3').feature('rgr1').set('markerpos', 'datapoints');
model.result('pg3').feature('rgr1').create('col1', 'Color');
model.result('pg3').feature('rgr1').feature('col1').set('expr', 'emw.freq/1e9');
model.result('pg3').feature('rgr1').feature('col1').set('colortable', 'Spectrum');
model.result('pg1').run;
model.result('pg1').setIndex('looplevel', 31, 0);
model.result('pg1').run;
model.result('pg2').run;
model.result('pg2').set('legendpos', 'lowerright');
model.result('pg2').run;
model.result('pg3').run;

model.study.create('std2');
model.study('std2').create('eig', 'Eigenfrequency');
model.study('std2').feature('eig').set('plotgroup', 'Default');
model.study('std2').feature('eig').set('eigwhich', 'lr');
model.study('std2').feature('eig').set('conrad', '1');
model.study('std2').feature('eig').set('conradynhm', '1');
model.study('std2').feature('eig').set('linpsolnum', 'auto');
model.study('std2').feature('eig').set('outputmap', {});
model.study('std2').feature('eig').set('ngenAUX', '1');
model.study('std2').feature('eig').set('goalngenAUX', '1');
model.study('std2').feature('eig').set('ngenAUX', '1');
model.study('std2').feature('eig').set('goalngenAUX', '1');
model.study('std2').feature('eig').setSolveFor('/physics/emw', true);
model.study('std2').create('frmod', 'Frequencymodal');
model.study('std2').feature('frmod').set('linpsolnum', 'auto');
model.study('std2').feature('frmod').set('solnum', 'auto');
model.study('std2').feature('frmod').set('notsolnum', 'auto');
model.study('std2').feature('frmod').set('outputmap', {});
model.study('std2').feature('frmod').setSolveFor('/physics/emw', true);
model.study('std2').feature('eig').set('shift', '9.5[GHz]');
model.study('std2').feature('eig').set('neigsactive', true);
model.study('std2').feature('eig').set('neigs', 3);
model.study('std2').feature('frmod').set('plist', 'range(8.5[GHz],0.01[GHz],11.5[GHz])');

model.selection.create('sel1', 'Explicit');
model.selection('sel1').model('comp1');
model.selection('sel1').geom(2);
model.selection('sel1').label('Port 1');
model.selection('sel1').set([1]);

model.physics('emw').feature('port1').selection.named('sel1');

model.selection.create('sel2', 'Explicit');
model.selection('sel2').model('comp1');
model.selection('sel2').geom(2);
model.selection('sel2').label('Port 2');
model.selection('sel2').set([38]);

model.physics('emw').feature('port2').selection.named('sel2');

model.study('std2').feature('frmod').setEntry('outputmap', 'emw', 'selection');
model.study('std2').feature('frmod').setEntry('outputselectionmap', 'emw', 'sel1;sel2');

model.sol.create('sol2');
model.sol('sol2').study('std2');
model.sol('sol2').create('st1', 'StudyStep');
model.sol('sol2').feature('st1').set('study', 'std2');
model.sol('sol2').feature('st1').set('studystep', 'eig');
model.sol('sol2').create('v1', 'Variables');
model.sol('sol2').feature('v1').set('control', 'eig');
model.sol('sol2').create('e1', 'Eigenvalue');
model.sol('sol2').feature('e1').set('eigref', '9.5[GHz]');
model.sol('sol2').feature('e1').set('control', 'eig');
model.sol('sol2').feature('e1').feature('aDef').set('complexfun', true);
model.sol('sol2').feature('e1').feature('aDef').set('cachepattern', false);
model.sol('sol2').feature('e1').create('d1', 'Direct');
model.sol('sol2').feature('e1').feature('d1').set('linsolver', 'pardiso');
model.sol('sol2').feature('e1').feature('d1').label('Suggested Direct Solver (emw)');
model.sol('sol2').feature('e1').create('i1', 'Iterative');
model.sol('sol2').feature('e1').feature('i1').set('linsolver', 'gmres');
model.sol('sol2').feature('e1').feature('i1').set('prefuntype', 'right');
model.sol('sol2').feature('e1').feature('i1').set('itrestart', '300');
model.sol('sol2').feature('e1').feature('i1').label('Suggested Iterative Solver (emw)');
model.sol('sol2').feature('e1').feature('i1').create('mg1', 'Multigrid');
model.sol('sol2').feature('e1').feature('i1').feature('mg1').set('iter', '1');
model.sol('sol2').feature('e1').feature('i1').feature('mg1').feature('pr').create('sv1', 'SORVector');
model.sol('sol2').feature('e1').feature('i1').feature('mg1').feature('pr').feature('sv1').set('prefun', 'sorvec');
model.sol('sol2').feature('e1').feature('i1').feature('mg1').feature('pr').feature('sv1').set('iter', 2);
model.sol('sol2').feature('e1').feature('i1').feature('mg1').feature('pr').feature('sv1').set('relax', 1);
model.sol('sol2').feature('e1').feature('i1').feature('mg1').feature('pr').feature('sv1').set('sorvecdof', {'comp1_E'});
model.sol('sol2').feature('e1').feature('i1').feature('mg1').feature('po').create('sv1', 'SORVector');
model.sol('sol2').feature('e1').feature('i1').feature('mg1').feature('po').feature('sv1').set('prefun', 'soruvec');
model.sol('sol2').feature('e1').feature('i1').feature('mg1').feature('po').feature('sv1').set('iter', 2);
model.sol('sol2').feature('e1').feature('i1').feature('mg1').feature('po').feature('sv1').set('relax', 1);
model.sol('sol2').feature('e1').feature('i1').feature('mg1').feature('po').feature('sv1').set('sorvecdof', {'comp1_E'});
model.sol('sol2').feature('e1').feature('i1').feature('mg1').feature('cs').create('d1', 'Direct');
model.sol('sol2').feature('e1').feature('i1').feature('mg1').feature('cs').feature('d1').set('linsolver', 'pardiso');
model.sol('sol2').feature('e1').feature('d1').active(true);
model.sol('sol2').create('su1', 'StoreSolution');
model.sol('sol2').create('st2', 'StudyStep');
model.sol('sol2').feature('st2').set('study', 'std2');
model.sol('sol2').feature('st2').set('studystep', 'frmod');
model.sol('sol2').create('v2', 'Variables');
model.sol('sol2').feature('v2').set('notsolmethod', 'sol');
model.sol('sol2').feature('v2').set('notsol', 'sol2');
model.sol('sol2').feature('v2').set('control', 'frmod');
model.sol('sol2').create('mo1', 'Modal');
model.sol('sol2').feature('mo1').set('analysistype', 'frequency');
model.sol('sol2').feature('mo1').set('plist', 'range(8.5[GHz],0.01[GHz],11.5[GHz])');
model.sol('sol2').feature('mo1').set('eigsol', 'sol2');
model.sol('sol2').feature('mo1').set('eigsoluse', 'su1');
model.sol('sol2').feature('mo1').set('control', 'frmod');
model.sol('sol2').feature('mo1').feature('aDef').set('complexfun', true);
model.sol('sol2').feature('mo1').feature('aDef').set('cachepattern', true);
model.sol('sol2').feature('v2').set('notsolnum', 'auto');
model.sol('sol2').feature('v2').set('notsolvertype', 'solnum');
model.sol('sol2').attach('std2');
model.sol('sol2').runAll;

model.result.create('pg4', 'PlotGroup3D');
model.result('pg4').label('Electric Field (emw) 1');
model.result('pg4').set('data', 'dset2');
model.result('pg4').setIndex('looplevel', 301, 0);
model.result('pg4').set('frametype', 'spatial');
model.result('pg4').set('showlegendsmaxmin', true);
model.result('pg4').set('data', 'dset2');
model.result('pg4').setIndex('looplevel', 301, 0);
model.result('pg4').set('defaultPlotID', 'ElectromagneticWaves/phys1/pdef1/pcond1/pg1');
model.result('pg4').feature.create('mslc1', 'Multislice');
model.result('pg4').feature('mslc1').label('Multislice');
model.result('pg4').feature('mslc1').set('smooth', 'internal');
model.result('pg4').feature('mslc1').set('data', 'parent');
model.result('pg4').feature('mslc1').feature.create('filt1', 'Filter');
model.result('pg4').feature('mslc1').feature('filt1').set('expr', '!isScalingSystemDomain');
model.result.create('pg5', 'PlotGroup1D');
model.result('pg5').set('data', 'dset2');
model.result('pg5').create('glob1', 'Global');
model.result('pg5').feature('glob1').set('unit', {'' ''});
model.result('pg5').feature('glob1').set('expr', {'emw.S11dB' 'emw.S21dB'});
model.result('pg5').feature('glob1').set('descr', {'S11' 'S21'});
model.result('pg5').label('S-parameter (emw) 1');
model.result('pg5').feature('glob1').set('titletype', 'none');
model.result('pg5').feature('glob1').set('xdata', 'expr');
model.result('pg5').set('ylabelactive', true);
model.result('pg5').set('ylabel', 'S-parameter (dB)');
model.result('pg5').feature('glob1').set('xdataexpr', 'freq');
model.result('pg5').feature('glob1').set('xdataunit', 'GHz');
model.result('pg5').feature('glob1').set('markerpos', 'datapoints');
model.result('pg5').feature('glob1').set('xdatasolnumtype', 'all');
model.result.create('pg6', 'SmithGroup');
model.result('pg6').set('data', 'dset2');
model.result('pg6').create('rgr1', 'ReflectionGraph');
model.result('pg6').feature('rgr1').set('unit', {''});
model.result('pg6').feature('rgr1').set('expr', {'emw.S11'});
model.result('pg6').feature('rgr1').set('descr', {'S11'});
model.result('pg6').label('Smith Plot (emw) 1');
model.result('pg6').feature('rgr1').set('titletype', 'manual');
model.result('pg6').feature('rgr1').set('title', 'Reflection Graph: S-parameter, Color: Frequency (GHz)');
model.result('pg6').feature('rgr1').set('linemarker', 'point');
model.result('pg6').feature('rgr1').set('markerpos', 'datapoints');
model.result('pg6').feature('rgr1').create('col1', 'Color');
model.result('pg6').feature('rgr1').feature('col1').set('expr', 'emw.freq/1e9');
model.result('pg6').feature('rgr1').feature('col1').set('colortable', 'Spectrum');
model.result('pg4').run;
model.result('pg4').run;
model.result('pg4').feature('mslc1').set('multiplanexmethod', 'coord');
model.result('pg4').feature('mslc1').set('xcoord', '-6 6');
model.result('pg4').feature('mslc1').set('ynumber', '0');
model.result('pg4').feature('mslc1').set('znumber', '0');
model.result('pg4').run;
model.result('pg4').run;
model.result('pg4').setIndex('looplevel', 151, 0);
model.result('pg4').run;
model.result('pg5').run;
model.result('pg5').set('legendpos', 'lowerright');
model.result('pg5').run;
model.result('pg5').feature('glob1').setIndex('descr', 'S11 Frequency Domain Modal', 0);
model.result('pg5').feature('glob1').setIndex('descr', 'S21 Frequency Domain Modal', 1);
model.result('pg5').run;
model.result('pg5').create('glob2', 'Global');
model.result('pg5').feature('glob2').set('markerpos', 'datapoints');
model.result('pg5').feature('glob2').set('linewidth', 'preference');
model.result('pg5').feature('glob2').set('data', 'dset1');
model.result('pg5').feature('glob2').set('expr', {'emw.S11dB'});
model.result('pg5').feature('glob2').set('descr', {'S11'});
model.result('pg5').feature('glob2').set('expr', {'emw.S11dB' 'emw.S21dB'});
model.result('pg5').feature('glob2').set('descr', {'S11' 'S21'});
model.result('pg5').feature('glob2').setIndex('descr', 'S11 Regular Sweep', 0);
model.result('pg5').feature('glob2').setIndex('descr', 'S21 Regular Sweep', 1);
model.result('pg5').feature('glob2').set('linestyle', 'dashed');
model.result('pg5').feature('glob2').set('linemarker', 'circle');
model.result('pg5').run;
model.result('pg5').run;
model.result('pg5').set('titletype', 'manual');
model.result('pg5').set('title', 'S-parameter Comparison between Frequency Domain Modal and Regular Discrete Sweep');
model.result('pg6').run;

model.study.create('std3');
model.study('std3').create('frawe', 'FrequencyAdaptive');
model.study('std3').feature('frawe').set('plotgroup', 'Default');
model.study('std3').feature('frawe').set('solnum', 'auto');
model.study('std3').feature('frawe').set('notsolnum', 'auto');
model.study('std3').feature('frawe').set('outputmap', {});
model.study('std3').feature('frawe').setSolveFor('/physics/emw', true);
model.study('std3').feature('frawe').set('plist', 'range(8.5[GHz],0.01[GHz],11.5[GHz])');
model.study('std3').feature('frawe').setEntry('outputmap', 'emw', 'selection');
model.study('std3').feature('frawe').setEntry('outputselectionmap', 'emw', 'sel1;sel2');

model.sol.create('sol4');

model.study('std3').feature('frawe').set('awefunc', {'abs(comp1.emw.S21)'});

model.sol('sol4').study('std3');
model.sol('sol4').create('st1', 'StudyStep');
model.sol('sol4').feature('st1').set('study', 'std3');
model.sol('sol4').feature('st1').set('studystep', 'frawe');
model.sol('sol4').create('v1', 'Variables');
model.sol('sol4').feature('v1').set('control', 'frawe');
model.sol('sol4').create('aw1', 'AWE');
model.sol('sol4').feature('aw1').set('pname', 'freq');
model.sol('sol4').feature('aw1').set('plist', 'range(8.5[GHz],0.01[GHz],11.5[GHz])');
model.sol('sol4').feature('aw1').set('awefunc', {'abs(comp1.emw.S21)'});
model.sol('sol4').feature('aw1').set('rtol', 0.01);
model.sol('sol4').feature('aw1').set('plot', 'off');
model.sol('sol4').feature('aw1').set('plotgroup', 'Default');
model.sol('sol4').feature('aw1').set('probesel', 'all');
model.sol('sol4').feature('aw1').set('probes', {});
model.sol('sol4').feature('aw1').feature('aDef').set('complexfun', true);
model.sol('sol4').feature('aw1').feature('aDef').set('cachepattern', true);
model.sol('sol4').feature('aw1').create('i1', 'Iterative');
model.sol('sol4').feature('aw1').feature('i1').set('linsolver', 'gmres');
model.sol('sol4').feature('aw1').feature('i1').set('prefuntype', 'right');
model.sol('sol4').feature('aw1').feature('i1').set('itrestart', '300');
model.sol('sol4').feature('aw1').feature('i1').label('Suggested Iterative Solver (emw)');
model.sol('sol4').feature('aw1').feature('i1').create('mg1', 'Multigrid');
model.sol('sol4').feature('aw1').feature('i1').feature('mg1').set('iter', '1');
model.sol('sol4').feature('aw1').feature('i1').feature('mg1').feature('pr').create('sv1', 'SORVector');
model.sol('sol4').feature('aw1').feature('i1').feature('mg1').feature('pr').feature('sv1').set('prefun', 'sorvec');
model.sol('sol4').feature('aw1').feature('i1').feature('mg1').feature('pr').feature('sv1').set('iter', 2);
model.sol('sol4').feature('aw1').feature('i1').feature('mg1').feature('pr').feature('sv1').set('relax', 1);
model.sol('sol4').feature('aw1').feature('i1').feature('mg1').feature('pr').feature('sv1').set('sorvecdof', {'comp1_E'});
model.sol('sol4').feature('aw1').feature('i1').feature('mg1').feature('po').create('sv1', 'SORVector');
model.sol('sol4').feature('aw1').feature('i1').feature('mg1').feature('po').feature('sv1').set('prefun', 'soruvec');
model.sol('sol4').feature('aw1').feature('i1').feature('mg1').feature('po').feature('sv1').set('iter', 2);
model.sol('sol4').feature('aw1').feature('i1').feature('mg1').feature('po').feature('sv1').set('relax', 1);
model.sol('sol4').feature('aw1').feature('i1').feature('mg1').feature('po').feature('sv1').set('sorvecdof', {'comp1_E'});
model.sol('sol4').feature('aw1').feature('i1').feature('mg1').feature('cs').create('d1', 'Direct');
model.sol('sol4').feature('aw1').feature('i1').feature('mg1').feature('cs').feature('d1').set('linsolver', 'pardiso');
model.sol('sol4').attach('std3');
model.sol('sol4').runAll;

model.result.create('pg7', 'PlotGroup3D');
model.result('pg7').label('Electric Field (emw) 2');
model.result('pg7').set('data', 'dset4');
model.result('pg7').setIndex('looplevel', 301, 0);
model.result('pg7').set('frametype', 'spatial');
model.result('pg7').set('showlegendsmaxmin', true);
model.result('pg7').set('data', 'dset4');
model.result('pg7').setIndex('looplevel', 301, 0);
model.result('pg7').set('defaultPlotID', 'ElectromagneticWaves/phys1/pdef1/pcond1/pg1');
model.result('pg7').feature.create('mslc1', 'Multislice');
model.result('pg7').feature('mslc1').label('Multislice');
model.result('pg7').feature('mslc1').set('smooth', 'internal');
model.result('pg7').feature('mslc1').set('data', 'parent');
model.result('pg7').feature('mslc1').feature.create('filt1', 'Filter');
model.result('pg7').feature('mslc1').feature('filt1').set('expr', '!isScalingSystemDomain');
model.result.create('pg8', 'PlotGroup1D');
model.result('pg8').set('data', 'dset4');
model.result('pg8').create('glob1', 'Global');
model.result('pg8').feature('glob1').set('unit', {'' ''});
model.result('pg8').feature('glob1').set('expr', {'emw.S11dB' 'emw.S21dB'});
model.result('pg8').feature('glob1').set('descr', {'S11' 'S21'});
model.result('pg8').label('S-parameter (emw) 2');
model.result('pg8').feature('glob1').set('titletype', 'none');
model.result('pg8').feature('glob1').set('xdata', 'expr');
model.result('pg8').set('ylabelactive', true);
model.result('pg8').set('ylabel', 'S-parameter (dB)');
model.result('pg8').feature('glob1').set('xdataexpr', 'freq');
model.result('pg8').feature('glob1').set('xdataunit', 'GHz');
model.result('pg8').feature('glob1').set('markerpos', 'datapoints');
model.result('pg8').feature('glob1').set('xdatasolnumtype', 'all');
model.result.create('pg9', 'SmithGroup');
model.result('pg9').set('data', 'dset4');
model.result('pg9').create('rgr1', 'ReflectionGraph');
model.result('pg9').feature('rgr1').set('unit', {''});
model.result('pg9').feature('rgr1').set('expr', {'emw.S11'});
model.result('pg9').feature('rgr1').set('descr', {'S11'});
model.result('pg9').label('Smith Plot (emw) 2');
model.result('pg9').feature('rgr1').set('titletype', 'manual');
model.result('pg9').feature('rgr1').set('title', 'Reflection Graph: S-parameter, Color: Frequency (GHz)');
model.result('pg9').feature('rgr1').set('linemarker', 'point');
model.result('pg9').feature('rgr1').set('markerpos', 'datapoints');
model.result('pg9').feature('rgr1').create('col1', 'Color');
model.result('pg9').feature('rgr1').feature('col1').set('expr', 'emw.freq/1e9');
model.result('pg9').feature('rgr1').feature('col1').set('colortable', 'Spectrum');
model.result('pg7').run;
model.result('pg7').setIndex('looplevel', 151, 0);
model.result('pg7').run;
model.result('pg7').feature.remove('mslc1');
model.result('pg7').run;
model.result('pg7').create('surf1', 'Surface');
model.result('pg7').feature('surf1').create('sel1', 'Selection');
model.result('pg7').feature('surf1').feature('sel1').selection.set([1 38]);
model.result('pg7').run;
model.result('pg8').run;
model.result('pg8').set('titletype', 'manual');
model.result('pg8').set('title', 'S-parameter Comparison between Adaptive Frequency Sweep and Regular Discrete Sweep');
model.result('pg8').set('legendpos', 'lowerright');
model.result('pg8').run;
model.result('pg8').feature('glob1').setIndex('descr', 'S11 Adaptive Frequency Sweep', 0);
model.result('pg8').feature('glob1').setIndex('descr', 'S21 Adaptive Frequency Sweep', 1);
model.result('pg8').feature.duplicate('glob2', 'glob1');
model.result('pg8').run;
model.result('pg8').feature('glob2').setIndex('descr', 'S11 Regular Sweep', 0);
model.result('pg8').feature('glob2').setIndex('descr', 'S21 Regular Sweep', 1);
model.result('pg8').feature('glob2').set('data', 'dset1');
model.result('pg8').feature('glob2').set('linestyle', 'dotted');
model.result('pg8').feature('glob2').set('linemarker', 'cycle');
model.result('pg8').run;
model.result('pg9').run;
model.result.create('pg10', 'PlotGroup1D');
model.result('pg10').run;
model.result('pg10').label('S-parameter with Graph Markers');
model.result('pg10').set('data', 'dset4');
model.result('pg10').create('glob1', 'Global');
model.result('pg10').feature('glob1').set('markerpos', 'datapoints');
model.result('pg10').feature('glob1').set('linewidth', 'preference');
model.result('pg10').feature('glob1').set('expr', {'emw.S11dB'});
model.result('pg10').feature('glob1').set('descr', {'S11'});
model.result('pg10').feature('glob1').setIndex('unit', 'dB', 0);
model.result('pg10').feature('glob1').create('gmrk1', 'GraphMarker');
model.result('pg10').feature('glob1').feature('gmrk1').set('linewidth', 'preference');
model.result('pg10').run;
model.result('pg10').feature('glob1').feature('gmrk1').set('display', 'min');
model.result('pg10').feature('glob1').feature('gmrk1').set('scope', 'local');
model.result('pg10').feature('glob1').feature('gmrk1').set('precision', 3);
model.result('pg10').feature('glob1').feature('gmrk1').set('inclxcoord', true);
model.result('pg10').feature('glob1').feature('gmrk1').set('includeunit', true);
model.result('pg10').feature('glob1').feature('gmrk1').set('anchorpoint', 'lowerleft');
model.result('pg10').run;
model.result('pg10').feature('glob1').create('filt1', 'GlobalFilter');
model.result('pg10').run;
model.result('pg10').feature('glob1').feature('filt1').set('expr', 'emw.freq>9.2[GHz] && emw.freq<10.8[GHz]');
model.result('pg10').run;
model.result('pg10').create('glob2', 'Global');
model.result('pg10').feature('glob2').set('markerpos', 'datapoints');
model.result('pg10').feature('glob2').set('linewidth', 'preference');
model.result('pg10').feature('glob2').set('expr', {'emw.S21dB'});
model.result('pg10').feature('glob2').set('descr', {'S21'});
model.result('pg10').feature('glob2').set('unit', {'1'});
model.result('pg10').feature('glob2').create('gmrk1', 'GraphMarker');
model.result('pg10').feature('glob2').feature('gmrk1').set('linewidth', 'preference');
model.result('pg10').run;
model.result('pg10').feature('glob2').feature('gmrk1').set('displaymode', 'widthmode');
model.result('pg10').feature('glob2').feature('gmrk1').set('precision', 3);
model.result('pg10').feature('glob2').feature('gmrk1').set('includeunit', true);
model.result('pg10').feature('glob2').feature('gmrk1').set('showframe', true);
model.result('pg10').run;
model.result('pg10').run;
model.result('pg10').feature('glob2').feature.copy('filt1', 'pg10/glob1/filt1');
model.result('pg10').run;

model.title('Waveguide Iris Bandpass Filter');

model.description('A conductive diaphragm, an iris, placed transverse to a waveguide aperture causes a discontinuity and generates shunt reactance. Bandpass frequency response can be achieved from cascaded cavity resonators combined with such reactive elements, which can be created by inserting a series of iris elements inside the waveguide. This example consists of a WR-90 X-band waveguide and symmetrical inductive diaphragms (irises). The calculated S-parameters show good bandpass response and out-of-band rejection.');

model.mesh.clearMeshes;

model.sol('sol1').clearSolutionData;
model.sol('sol2').clearSolutionData;
model.sol('sol3').clearSolutionData;
model.sol('sol4').clearSolutionData;

model.label('waveguide_iris_filter.mph');

model.modelNode.label('Components');

out = model;
