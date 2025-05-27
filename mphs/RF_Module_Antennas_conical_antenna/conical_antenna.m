function out = model
%
% conical_antenna.m
%
% Model exported on May 26 2025, 21:32 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/RF_Module/Antennas');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 2);
model.geom('geom1').model('comp1');
model.geom('geom1').axisymmetric(true);

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

model.geom('geom1').create('imp1', 'Import');
model.geom('geom1').feature('imp1').set('filename', 'conical_antenna.mphbin');
model.geom('geom1').feature('imp1').importData;

model.param.set('Z_tl', '50[ohm]');
model.param.descr('Z_tl', 'Characteristic transmission line impedance');

model.variable.create('var1');
model.variable('var1').model('comp1');

model.geom('geom1').run;

model.variable('var1').set('Za', 'Z_tl*(1+emw.S11)/(1-emw.S11)');
model.variable('var1').descr('Za', 'Antenna impedance');

model.selection.create('sel1', 'Explicit');
model.selection('sel1').model('comp1');
model.selection('sel1').label('Air');
model.selection('sel1').set([1]);
model.selection.create('sel2', 'Explicit');
model.selection('sel2').model('comp1');
model.selection('sel2').label('Dielectric');
model.selection('sel2').set([2]);
model.selection.create('sel3', 'Explicit');
model.selection('sel3').model('comp1');
model.selection('sel3').label('Outer Air Boundaries');
model.selection('sel3').geom(1);
model.selection('sel3').set([14 15]);

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
model.material('mat1').selection.named('sel1');
model.material.create('mat2', 'Common', 'comp1');
model.material('mat2').selection.named('sel2');
model.material('mat2').propertyGroup('def').set('relpermittivity', {'2.07'});
model.material('mat2').propertyGroup('def').set('relpermeability', {'1'});
model.material('mat2').propertyGroup('def').set('electricconductivity', {'0'});

model.physics('emw').prop('components').set('components', 'inplane');
model.physics('emw').create('port1', 'Port', 1);
model.physics('emw').feature('port1').selection.set([6]);
model.physics('emw').feature('port1').set('PortType', 'Coaxial');
model.physics('emw').create('sctr1', 'Scattering', 1);
model.physics('emw').feature('sctr1').selection.named('sel3');
model.physics('emw').create('ffd1', 'FarFieldDomain', 2);
model.physics('emw').feature('ffd1').selection.set([1]);
model.physics('emw').feature('ffd1').feature('ffc1').selection.named('sel3');

model.mesh('mesh1').run;

model.study('std1').feature('freq').set('plist', 'range(200[MHz],25[MHz],1.5[GHz])');

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
model.sol('sol1').feature('s1').feature('p1').set('plistarr', {'range(200[MHz],25[MHz],1.5[GHz])'});
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
model.sol('sol1').feature('s1').create('d1', 'Direct');
model.sol('sol1').feature('s1').feature('d1').set('linsolver', 'pardiso');
model.sol('sol1').feature('s1').feature('d1').label('Suggested Direct Solver (emw)');
model.sol('sol1').feature('s1').feature('fc1').set('linsolver', 'd1');
model.sol('sol1').feature('s1').feature.remove('fcDef');
model.sol('sol1').attach('std1');
model.sol('sol1').runAll;

model.result.create('pg1', 'PlotGroup2D');
model.result('pg1').label('Electric Field (emw)');
model.result('pg1').set('dataisaxisym', 'off');
model.result('pg1').set('frametype', 'spatial');
model.result('pg1').set('showlegendsmaxmin', true);
model.result('pg1').set('data', 'dset1');
model.result('pg1').setIndex('looplevel', 53, 0);
model.result('pg1').set('defaultPlotID', 'ElectromagneticWaves/phys1/pdef1/pcond2/pg1');
model.result('pg1').feature.create('surf1', 'Surface');
model.result('pg1').feature('surf1').label('Surface');
model.result('pg1').feature('surf1').set('smooth', 'internal');
model.result('pg1').feature('surf1').set('data', 'parent');
model.result.dataset.create('rev1', 'Revolve2D');
model.result.dataset('rev1').label('Revolution 2D');
model.result.dataset('rev1').set('data', 'none');
model.result.dataset('rev1').set('startangle', -90);
model.result.dataset('rev1').set('revangle', 225);
model.result.dataset('rev1').set('data', 'dset1');
model.result.create('pg2', 'PlotGroup1D');
model.result('pg2').set('data', 'dset1');
model.result('pg2').create('glob1', 'Global');
model.result('pg2').feature('glob1').set('unit', {''});
model.result('pg2').feature('glob1').set('expr', {'emw.S11dB'});
model.result('pg2').feature('glob1').set('descr', {'S11'});
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
model.result.create('pg4', 'PolarGroup');
model.result('pg4').label('2D Far Field (emw)');
model.result('pg4').set('data', 'dset1');
model.result('pg4').create('rp1', 'RadiationPattern');
model.result('pg4').feature('rp1').set('legend', 'on');
model.result('pg4').feature('rp1').set('phidisc', '180');
model.result('pg4').feature('rp1').set('expr', {'emw.normEfar'});
model.result('pg4').feature('rp1').create('exp1', 'Export');
model.result.create('pg5', 'PlotGroup3D');
model.result('pg5').label('3D Far Field, Gain (emw)');
model.result('pg5').set('data', 'none');
model.result('pg5').set('view', 'new');
model.result('pg5').set('edges', 'off');
model.result('pg5').set('showlegendsmaxmin', true);
model.result('pg5').create('rp1', 'RadiationPattern');
model.result('pg5').feature('rp1').set('data', 'dset1');
model.result('pg5').feature('rp1').set('expr', {'emw.rGaindBEfar'});
model.result('pg5').feature('rp1').set('colorexpr', {'emw.normEfar'});
model.result('pg5').feature('rp1').set('useradiusascolor', true);
model.result('pg5').feature('rp1').set('directivityexpr', {'emw.normEfar^2'});
model.result('pg5').feature('rp1').set('thetadisc', '180');
model.result('pg5').feature('rp1').set('phidisc', '45');
model.result('pg5').feature('rp1').set('directivity', 'on');
model.result('pg5').feature('rp1').set('colortable', 'RainbowLight');
model.result('pg5').feature('rp1').create('exp1', 'Export');
model.result('pg5').feature('rp1').feature('exp1').setIndex('expr', 'comp1.emw.theta', 0);
model.result('pg4').feature('rp1').feature('exp1').setIndex('expr', 'comp1.emw.theta', 0);
model.result('pg1').run;
model.result('pg1').run;
model.result('pg1').feature('surf1').set('expr', 'emw.Hphi');
model.result('pg1').feature('surf1').set('descr', 'Magnetic field, phi-component');
model.result('pg1').feature('surf1').set('rangecoloractive', true);
model.result('pg1').feature('surf1').set('rangecolormin', -0.5);
model.result('pg1').feature('surf1').set('rangecolormax', 0.5);
model.result('pg1').feature('surf1').set('colortable', 'Wave');
model.result('pg1').run;
model.result('pg3').run;
model.result('pg4').run;
model.result('pg4').run;
model.result('pg4').feature('rp1').set('phidisc', 100);
model.result('pg4').feature('rp1').set('refdir', [-1 0 0]);
model.result('pg4').run;
model.result.create('pg6', 'PlotGroup1D');
model.result('pg6').run;
model.result('pg6').create('glob1', 'Global');
model.result('pg6').feature('glob1').set('markerpos', 'datapoints');
model.result('pg6').feature('glob1').set('linewidth', 'preference');
model.result('pg6').feature('glob1').setIndex('expr', 'real(Za)', 0);
model.result('pg6').feature('glob1').setIndex('unit', ['ohm' ], 0);
model.result('pg6').feature('glob1').setIndex('descr', 'Resistance', 0);
model.result('pg6').feature('glob1').setIndex('expr', 'imag(Za)', 1);
model.result('pg6').feature('glob1').setIndex('unit', ['ohm' ], 1);
model.result('pg6').feature('glob1').setIndex('descr', 'Reactance', 1);
model.result('pg6').feature('glob1').set('linestyle', 'cycle');
model.result('pg6').run;
model.result.create('pg7', 'PolarGroup');
model.result('pg7').run;
model.result('pg7').setIndex('looplevelinput', 'manual', 0);
model.result('pg7').setIndex('looplevel', [1 25 53], 0);
model.result('pg7').create('lngr1', 'LineGraph');
model.result('pg7').feature('lngr1').set('markerpos', 'datapoints');
model.result('pg7').feature('lngr1').set('linewidth', 'preference');
model.result('pg7').feature('lngr1').selection.named('sel3');
model.result('pg7').feature('lngr1').set('expr', 'emw.nPoav');
model.result('pg7').feature('lngr1').set('descr', 'Power outflow, time average');
model.result('pg7').feature('lngr1').set('expr', '10*log10(emw.nPoav)');
model.result('pg7').feature('lngr1').set('descractive', true);
model.result('pg7').feature('lngr1').set('descr', 'Near-field radiation pattern');
model.result('pg7').feature('lngr1').set('xdata', 'expr');
model.result('pg7').feature('lngr1').set('xdataexpr', 'atan2(z,r)');
model.result('pg7').feature('lngr1').set('linestyle', 'cycle');
model.result('pg7').feature('lngr1').set('legend', true);
model.result('pg7').run;
model.result('pg7').run;
model.result.duplicate('pg8', 'pg7');
model.result('pg8').run;
model.result('pg8').run;
model.result('pg8').feature('lngr1').set('expr', 'emw.normdBEfar');
model.result('pg8').feature('lngr1').set('descr', 'Far-field radiation pattern');
model.result('pg8').run;

model.title('Conical Antenna');

model.description(['This example studies impedance and radiation pattern as functions of frequency for a monoconical antenna with a finite ground plane and a 50' native2unicode(hex2dec({'00' 'a0'}), 'unicode') 'ohm coaxial feed.']);

model.mesh.clearMeshes;

model.sol('sol1').clearSolutionData;

model.label('conical_antenna.mph');

model.modelNode.label('Components');

out = model;
