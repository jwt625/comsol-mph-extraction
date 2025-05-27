function out = model
%
% metal_air_surface_plasmon_polariton.m
%
% Model exported on May 26 2025, 21:34 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/Wave_Optics_Module/Waveguides');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 2);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.physics.create('ewfd', 'ElectromagneticWavesFrequencyDomain', 'geom1');
model.physics('ewfd').model('comp1');

model.study.create('std1');
model.study('std1').create('bma', 'BoundaryModeAnalysis');
model.study('std1').feature('bma').set('shiftactive', false);
model.study('std1').feature('bma').set('conrad', '1');
model.study('std1').feature('bma').set('conradynhm', '1');
model.study('std1').feature('bma').set('linpsolnum', 'auto');
model.study('std1').feature('bma').set('solnum', 'auto');
model.study('std1').feature('bma').set('notsolnum', 'auto');
model.study('std1').feature('bma').set('outputmap', {});
model.study('std1').feature('bma').set('ngenAUX', '1');
model.study('std1').feature('bma').set('goalngenAUX', '1');
model.study('std1').feature('bma').set('ngenAUX', '1');
model.study('std1').feature('bma').set('goalngenAUX', '1');
model.study('std1').feature('bma').setSolveFor('/physics/ewfd', true);
model.study('std1').create('freq', 'Frequency');
model.study('std1').feature('freq').set('solnum', 'auto');
model.study('std1').feature('freq').set('notsolnum', 'auto');
model.study('std1').feature('freq').set('outputmap', {});
model.study('std1').feature('freq').set('ngenAUX', '1');
model.study('std1').feature('freq').set('goalngenAUX', '1');
model.study('std1').feature('freq').set('ngenAUX', '1');
model.study('std1').feature('freq').set('goalngenAUX', '1');
model.study('std1').feature('freq').setSolveFor('/physics/ewfd', true);

model.param.set('L', '2[um]');
model.param.descr('L', 'Simulation domain length');
model.param.set('H', '3[um]');
model.param.descr('H', 'Simulation domain height');
model.param.set('lda0', '400[nm]');
model.param.descr('lda0', 'Wavelength');
model.param.set('f0', 'c_const/lda0');
model.param.descr('f0', 'Frequency');

model.geom('geom1').lengthUnit('nm');
model.geom('geom1').create('r1', 'Rectangle');
model.geom('geom1').feature('r1').set('size', {'L' 'H'});
model.geom('geom1').feature('r1').setIndex('layer', 'H/2', 0);
model.geom('geom1').runPre('fin');
model.geom('geom1').run;

model.material.create('mat1', 'Common', 'comp1');
model.material('mat1').propertyGroup.create('RefractiveIndex', 'Refractive index');
model.material('mat1').propertyGroup('RefractiveIndex').func.create('int1', 'Interpolation');
model.material('mat1').propertyGroup('RefractiveIndex').func.create('int2', 'Interpolation');
model.material('mat1').label('Ag (Silver) (Johnson and Christy 1972: n,k 0.188-1.94 um)');
model.material('mat1').propertyGroup('RefractiveIndex').func('int1').set('funcname', 'nr');
model.material('mat1').propertyGroup('RefractiveIndex').func('int1').set('table', {'0.1879' '1.07';  ...
'0.1916' '1.10';  ...
'0.1953' '1.12';  ...
'0.1993' '1.14';  ...
'0.2033' '1.15';  ...
'0.2073' '1.18';  ...
'0.2119' '1.20';  ...
'0.2164' '1.22';  ...
'0.2214' '1.25';  ...
'0.2262' '1.26';  ...
'0.2313' '1.28';  ...
'0.2371' '1.28';  ...
'0.2426' '1.30';  ...
'0.2490' '1.31';  ...
'0.2551' '1.33';  ...
'0.2616' '1.35';  ...
'0.2689' '1.38';  ...
'0.2761' '1.41';  ...
'0.2844' '1.41';  ...
'0.2924' '1.39';  ...
'0.3009' '1.34';  ...
'0.3107' '1.13';  ...
'0.3204' '0.81';  ...
'0.3315' '0.17';  ...
'0.3425' '0.14';  ...
'0.3542' '0.10';  ...
'0.3679' '0.07';  ...
'0.3815' '0.05';  ...
'0.3974' '0.05';  ...
'0.4133' '0.05';  ...
'0.4305' '0.04';  ...
'0.4509' '0.04';  ...
'0.4714' '0.05';  ...
'0.4959' '0.05';  ...
'0.5209' '0.05';  ...
'0.5486' '0.06';  ...
'0.5821' '0.05';  ...
'0.6168' '0.06';  ...
'0.6595' '0.05';  ...
'0.7045' '0.04';  ...
'0.7560' '0.03';  ...
'0.8211' '0.04';  ...
'0.8920' '0.04';  ...
'0.9840' '0.04';  ...
'1.0880' '0.04';  ...
'1.2160' '0.09';  ...
'1.3930' '0.13';  ...
'1.6100' '0.15';  ...
'1.9370' '0.24'});
model.material('mat1').propertyGroup('RefractiveIndex').func('int1').set('fununit', {'1'});
model.material('mat1').propertyGroup('RefractiveIndex').func('int1').set('argunit', {'um'});
model.material('mat1').propertyGroup('RefractiveIndex').func('int2').set('funcname', 'ni');
model.material('mat1').propertyGroup('RefractiveIndex').func('int2').set('table', {'0.1879' '1.212';  ...
'0.1916' '1.232';  ...
'0.1953' '1.255';  ...
'0.1993' '1.277';  ...
'0.2033' '1.296';  ...
'0.2073' '1.312';  ...
'0.2119' '1.325';  ...
'0.2164' '1.336';  ...
'0.2214' '1.342';  ...
'0.2262' '1.344';  ...
'0.2313' '1.357';  ...
'0.2371' '1.367';  ...
'0.2426' '1.378';  ...
'0.2490' '1.389';  ...
'0.2551' '1.393';  ...
'0.2616' '1.387';  ...
'0.2689' '1.372';  ...
'0.2761' '1.331';  ...
'0.2844' '1.264';  ...
'0.2924' '1.161';  ...
'0.3009' '0.964';  ...
'0.3107' '0.616';  ...
'0.3204' '0.392';  ...
'0.3315' '0.829';  ...
'0.3425' '1.142';  ...
'0.3542' '1.419';  ...
'0.3679' '1.657';  ...
'0.3815' '1.864';  ...
'0.3974' '2.070';  ...
'0.4133' '2.275';  ...
'0.4305' '2.462';  ...
'0.4509' '2.657';  ...
'0.4714' '2.869';  ...
'0.4959' '3.093';  ...
'0.5209' '3.324';  ...
'0.5486' '3.586';  ...
'0.5821' '3.858';  ...
'0.6168' '4.152';  ...
'0.6595' '4.483';  ...
'0.7045' '4.838';  ...
'0.7560' '5.242';  ...
'0.8211' '5.727';  ...
'0.8920' '6.312';  ...
'0.9840' '6.992';  ...
'1.0880' '7.795';  ...
'1.2160' '8.828';  ...
'1.3930' '10.10';  ...
'1.6100' '11.85';  ...
'1.9370' '14.08'});
model.material('mat1').propertyGroup('RefractiveIndex').func('int2').set('fununit', {'1'});
model.material('mat1').propertyGroup('RefractiveIndex').func('int2').set('argunit', {'um'});
model.material('mat1').propertyGroup('RefractiveIndex').set('n', {'nr(c_const/freq)' '0' '0' '0' 'nr(c_const/freq)' '0' '0' '0' 'nr(c_const/freq)'});
model.material('mat1').propertyGroup('RefractiveIndex').set('ki', {'ni(c_const/freq)' '0' '0' '0' 'ni(c_const/freq)' '0' '0' '0' 'ni(c_const/freq)'});
model.material('mat1').propertyGroup('RefractiveIndex').addInput('frequency');
model.material.create('mat2', 'Common', 'comp1');
model.material('mat2').label('Air');
model.material('mat2').selection.set([2]);
model.material('mat2').propertyGroup.create('RefractiveIndex', 'Refractive_index');
model.material('mat2').propertyGroup('RefractiveIndex').set('n', {'1'});

model.physics('ewfd').create('port1', 'Port', 1);
model.physics('ewfd').feature('port1').selection.set([1 3]);
model.physics('ewfd').feature('port1').set('PortType', 'Numeric');
model.physics('ewfd').create('port2', 'Port', 1);
model.physics('ewfd').feature('port2').selection.set([6 7]);
model.physics('ewfd').feature('port2').set('PortType', 'Numeric');

model.study('std1').feature('bma').set('modeFreq', 'f0');
model.study('std1').feature('bma').set('shiftactive', true);
model.study('std1').feature('bma').set('shift', '5');
model.study('std1').feature.duplicate('bma1', 'bma');
model.study('std1').feature.move('bma1', 1);
model.study('std1').feature('bma1').set('PortName', '2');
model.study('std1').feature('freq').set('plist', 'f0');
model.study('std1').create('param', 'Parametric');
model.study('std1').feature('param').setIndex('pname', 'L', 0);
model.study('std1').feature('param').setIndex('plistarr', '', 0);
model.study('std1').feature('param').setIndex('punit', 'm', 0);
model.study('std1').feature('param').setIndex('pname', 'L', 0);
model.study('std1').feature('param').setIndex('plistarr', '', 0);
model.study('std1').feature('param').setIndex('punit', 'm', 0);
model.study('std1').feature('param').setIndex('pname', 'lda0', 0);
model.study('std1').feature('param').setIndex('punit', 'nm', 0);
model.study('std1').feature('param').setIndex('plistarr', 'range(340,10,600)', 0);

model.func.create('an1', 'Analytic');
model.func('an1').model('comp1');
model.func('an1').set('funcname', 'epsilonr');
model.func('an1').set('expr', '(mat1.rfi.nr(x)-1i*mat1.rfi.ni(x))^2');
model.func('an1').set('complex', true);

model.mesh('mesh1').run;
model.mesh('mesh1').automatic(false);
model.mesh('mesh1').create('size2', 'Size');
model.mesh('mesh1').feature.move('size2', 2);
model.mesh('mesh1').feature('size2').selection.geom('geom1', 1);
model.mesh('mesh1').feature('size2').selection.set([4]);
model.mesh('mesh1').feature('size2').set('custom', true);
model.mesh('mesh1').feature('size2').set('hmaxactive', true);
model.mesh('mesh1').feature('size2').set('hmax', '(lda0/real(sqrt(epsilonr(lda0/1[m])/(1+epsilonr(lda0/1[m])))))/12');
model.mesh('mesh1').run;

model.sol.create('sol1');
model.sol('sol1').study('std1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'bma');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').set('control', 'bma');
model.sol('sol1').create('e1', 'Eigenvalue');
model.sol('sol1').feature('e1').set('neigs', 1);
model.sol('sol1').feature('e1').set('shift', '1');
model.sol('sol1').feature('e1').set('eigref', '5');
model.sol('sol1').feature('e1').set('computeandstorelefteig', 'off');
model.sol('sol1').feature('e1').set('control', 'bma');
model.sol('sol1').feature('e1').feature('aDef').set('complexfun', true);
model.sol('sol1').feature('e1').feature('aDef').set('cachepattern', true);
model.sol('sol1').feature('e1').create('d1', 'Direct');
model.sol('sol1').feature('e1').feature('d1').set('linsolver', 'mumps');
model.sol('sol1').feature('e1').feature('d1').label('Suggested Direct Solver (ewfd)');
model.sol('sol1').create('su1', 'StoreSolution');
model.sol('sol1').create('st2', 'StudyStep');
model.sol('sol1').feature('st2').set('study', 'std1');
model.sol('sol1').feature('st2').set('studystep', 'bma1');
model.sol('sol1').create('v2', 'Variables');
model.sol('sol1').feature('v2').set('initmethod', 'sol');
model.sol('sol1').feature('v2').set('initsol', 'sol1');
model.sol('sol1').feature('v2').set('notsolmethod', 'sol');
model.sol('sol1').feature('v2').set('notsol', 'sol1');
model.sol('sol1').feature('v2').set('control', 'bma1');
model.sol('sol1').create('e2', 'Eigenvalue');
model.sol('sol1').feature('e2').set('neigs', 1);
model.sol('sol1').feature('e2').set('shift', '1');
model.sol('sol1').feature('e2').set('eigref', '5');
model.sol('sol1').feature('e2').set('computeandstorelefteig', 'off');
model.sol('sol1').feature('e2').set('control', 'bma1');
model.sol('sol1').feature('e2').set('linpmethod', 'sol');
model.sol('sol1').feature('e2').set('linpsol', 'sol1');
model.sol('sol1').feature('e2').set('control', 'bma1');
model.sol('sol1').feature('e2').feature('aDef').set('complexfun', true);
model.sol('sol1').feature('e2').feature('aDef').set('cachepattern', true);
model.sol('sol1').feature('e2').create('d1', 'Direct');
model.sol('sol1').feature('e2').feature('d1').set('linsolver', 'mumps');
model.sol('sol1').feature('e2').feature('d1').label('Suggested Direct Solver (ewfd)');
model.sol('sol1').create('su2', 'StoreSolution');
model.sol('sol1').create('st3', 'StudyStep');
model.sol('sol1').feature('st3').set('study', 'std1');
model.sol('sol1').feature('st3').set('studystep', 'freq');
model.sol('sol1').create('v3', 'Variables');
model.sol('sol1').feature('v3').set('initmethod', 'sol');
model.sol('sol1').feature('v3').set('initsol', 'sol1');
model.sol('sol1').feature('v3').set('notsolmethod', 'sol');
model.sol('sol1').feature('v3').set('notsol', 'sol1');
model.sol('sol1').feature('v3').set('control', 'freq');
model.sol('sol1').create('s1', 'Stationary');
model.sol('sol1').feature('s1').set('stol', 0.01);
model.sol('sol1').feature('s1').create('p1', 'Parametric');
model.sol('sol1').feature('s1').feature.remove('pDef');
model.sol('sol1').feature('s1').feature('p1').set('pname', {'freq'});
model.sol('sol1').feature('s1').feature('p1').set('plistarr', {'f0'});
model.sol('sol1').feature('s1').feature('p1').set('punit', {'THz'});
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
model.sol('sol1').feature('s1').feature('d1').set('linsolver', 'mumps');
model.sol('sol1').feature('s1').feature('d1').label('Suggested Direct Solver (ewfd)');
model.sol('sol1').feature('s1').feature('fc1').set('linsolver', 'd1');
model.sol('sol1').feature('s1').feature.remove('fcDef');
model.sol('sol1').feature('v3').set('notsolnum', 'auto');
model.sol('sol1').feature('v3').set('notsolvertype', 'solnum');
model.sol('sol1').feature('v3').set('solnum', 'auto');
model.sol('sol1').feature('v3').set('solvertype', 'solnum');
model.sol('sol1').feature('e2').set('linpsolnum', 'auto');
model.sol('sol1').feature('e2').set('linpsolvertype', 'solnum');
model.sol('sol1').feature('v2').set('notsolnum', 'auto');
model.sol('sol1').feature('v2').set('notsolvertype', 'solnum');
model.sol('sol1').feature('v2').set('solnum', 'auto');
model.sol('sol1').feature('v2').set('solvertype', 'solnum');
model.sol('sol1').attach('std1');

model.batch.create('p1', 'Parametric');
model.batch('p1').study('std1');
model.batch('p1').create('so1', 'Solutionseq');
model.batch('p1').feature('so1').set('seq', 'sol1');
model.batch('p1').feature('so1').set('store', 'on');
model.batch('p1').feature('so1').set('clear', 'on');
model.batch('p1').feature('so1').set('psol', 'none');
model.batch('p1').set('pname', {'lda0'});
model.batch('p1').set('plistarr', {'range(340,10,600)'});
model.batch('p1').set('sweeptype', 'sparse');
model.batch('p1').set('probesel', 'all');
model.batch('p1').set('probes', {});
model.batch('p1').set('plot', 'off');
model.batch('p1').set('err', 'on');
model.batch('p1').attach('std1');
model.batch('p1').set('control', 'param');

model.sol.create('sol4');
model.sol('sol4').study('std1');
model.sol('sol4').label('Parametric Solutions 1');

model.batch('p1').feature('so1').set('psol', 'sol4');
model.batch('p1').run('compute');

model.result.create('pg1', 'PlotGroup2D');
model.result('pg1').label('Electric Field (ewfd)');
model.result('pg1').set('data', 'dset4');
model.result('pg1').setIndex('looplevel', 1, 0);
model.result('pg1').setIndex('looplevel', 27, 1);
model.result('pg1').set('frametype', 'spatial');
model.result('pg1').set('defaultPlotID', 'ElectromagneticWavesFrequencyDomain/phys1/pdef1/pcond2/pg1');
model.result('pg1').feature.create('surf1', 'Surface');
model.result('pg1').feature('surf1').set('smooth', 'internal');
model.result('pg1').feature('surf1').set('data', 'parent');
model.result.create('pg2', 'PlotGroup1D');
model.result('pg2').set('data', 'dset4');
model.result('pg2').create('glob1', 'Global');
model.result('pg2').feature('glob1').set('unit', {'' '' '' ''});
model.result('pg2').feature('glob1').set('expr', {'ewfd.Rport_1' 'ewfd.Tport_2' 'ewfd.RTtotal' 'ewfd.Atotal'});
model.result('pg2').feature('glob1').set('descr', {'Reflectance, port 1' 'Transmittance, port 2' 'Total reflectance and transmittance' 'Absorptance'});
model.result('pg2').label('Reflectance, Transmittance, and Absorptance (ewfd)');
model.result('pg2').feature('glob1').set('titletype', 'none');
model.result('pg2').feature('glob1').set('xdata', 'expr');
model.result('pg2').set('ylabelactive', true);
model.result('pg2').set('ylabel', 'Reflectance, transmittance, and absorptance (1)');
model.result('pg2').feature('glob1').set('xdataexpr', 'lda0');
model.result('pg2').feature('glob1').set('xdataunit', 'nm');
model.result('pg2').feature('glob1').set('markerpos', 'datapoints');
model.result('pg2').feature('glob1').set('xdatasolnumtype', 'all');
model.result.create('pg3', 'PlotGroup2D');
model.result('pg3').label('Electric Mode Field, Port 1 (ewfd)');
model.result('pg3').set('showlegendsmaxmin', true);
model.result('pg3').set('data', 'dset4');
model.result('pg3').create('line1', 'Line');
model.result('pg3').feature('line1').set('expr', 'root.comp1.ewfd.normEbm_1');
model.result('pg3').feature('line1').set('colortable', 'RainbowLight');
model.result('pg3').feature('line1').set('linetype', 'tube');
model.result('pg3').feature('line1').create('hght1', 'Height');
model.result.create('pg4', 'PlotGroup2D');
model.result('pg4').label('Electric Mode Field, Port 2 (ewfd)');
model.result('pg4').set('showlegendsmaxmin', true);
model.result('pg4').set('data', 'dset4');
model.result('pg4').create('line1', 'Line');
model.result('pg4').feature('line1').set('expr', 'root.comp1.ewfd.normEbm_2');
model.result('pg4').feature('line1').set('colortable', 'RainbowLight');
model.result('pg4').feature('line1').set('linetype', 'tube');
model.result('pg4').feature('line1').create('hght1', 'Height');
model.result('pg1').run;
model.result('pg1').set('looplevel', [1 4]);
model.result('pg1').run;
model.result('pg1').run;
model.result('pg1').feature('surf1').set('expr', 'ewfd.Ey');
model.result('pg1').feature('surf1').set('colortable', 'WaveLight');
model.result('pg1').feature('surf1').set('colorscalemode', 'linearsymmetric');
model.result('pg1').run;
model.result('pg1').create('arws1', 'ArrowSurface');
model.result('pg1').feature('arws1').set('expr', {'ewfd.Ex' 'ewfd.Ey'});
model.result('pg1').feature('arws1').set('descr', 'Electric field');
model.result('pg1').feature('arws1').set('xnumber', 50);
model.result('pg1').feature('arws1').set('ynumber', 50);
model.result('pg1').feature('arws1').set('color', 'black');
model.result('pg1').run;
model.result('pg1').feature('arws1').set('scaleactive', true);
model.result('pg1').feature('arws1').set('scale', '1e-3');
model.result('pg2').run;
model.result('pg2').label('Transmittance and Absorptance (ewfd)');
model.result('pg2').set('ylabel', 'Transmittance and absorptance (1)');
model.result('pg2').set('legendpos', 'middleright');
model.result('pg2').run;
model.result('pg2').feature('glob1').remove('unit', [0 2]);
model.result('pg2').feature('glob1').remove('descr', [0 2]);
model.result('pg2').feature('glob1').remove('expr', [0 2]);
model.result('pg2').run;
model.result('pg3').run;
model.result.create('pg5', 'PlotGroup1D');
model.result('pg5').run;
model.result('pg5').label('SPP Dispersion');
model.result('pg5').set('data', 'dset4');
model.result('pg5').set('titletype', 'manual');
model.result('pg5').set('title', 'SPP dispersion of bulk silver');
model.result('pg5').set('xlabelactive', true);
model.result('pg5').set('xlabel', 'Propagation constant (1/m)');
model.result('pg5').set('legendpos', 'lowerright');
model.result('pg5').create('glob1', 'Global');
model.result('pg5').feature('glob1').set('markerpos', 'datapoints');
model.result('pg5').feature('glob1').set('linewidth', 'preference');
model.result('pg5').feature('glob1').setIndex('expr', 'freq*h_const', 0);
model.result('pg5').feature('glob1').setIndex('unit', 'eV', 0);
model.result('pg5').feature('glob1').setIndex('descr', 'Energy', 0);
model.result('pg5').feature('glob1').set('xdatasolnumtype', 'all');
model.result('pg5').feature('glob1').set('xdata', 'expr');
model.result('pg5').feature('glob1').set('xdataexpr', 'ewfd.beta_1');
model.result('pg5').feature('glob1').set('linestyle', 'none');
model.result('pg5').feature('glob1').set('linewidth', 3);
model.result('pg5').feature('glob1').set('linemarker', 'circle');
model.result('pg5').feature('glob1').set('legendmethod', 'manual');
model.result('pg5').feature('glob1').setIndex('legends', 'Simulated SPP dispersion', 0);
model.result('pg5').feature.duplicate('glob2', 'glob1');
model.result('pg5').run;
model.result('pg5').feature('glob2').set('xdataexpr', 'ewfd.k0');
model.result('pg5').feature('glob2').set('linestyle', 'dashed');
model.result('pg5').feature('glob2').set('linecolor', 'black');
model.result('pg5').feature('glob2').set('linemarker', 'none');
model.result('pg5').feature('glob2').setIndex('legends', 'Light line', 0);
model.result('pg5').run;
model.result('pg5').feature('glob1').create('col1', 'Color');
model.result('pg5').run;
model.result('pg5').feature('glob1').feature('col1').set('expr', '-real(ewfd.beta_1)/imag(ewfd.beta_1)');
model.result('pg5').feature('glob1').feature('col1').set('colortable', 'Viridis');
model.result('pg5').feature('glob1').feature('col1').set('rangecoloractive', true);
model.result('pg5').feature('glob1').feature('col1').set('rangecolormin', 0);
model.result('pg5').feature('glob1').feature('col1').set('rangecolormax', 800);
model.result('pg5').run;
model.result('pg5').feature.duplicate('glob3', 'glob1');
model.result('pg5').run;
model.result('pg5').feature('glob3').set('xdataexpr', 'ewfd.omega/c_const*sqrt(epsilonr(lda0)/(epsilonr(lda0)+1))');
model.result('pg5').feature('glob3').set('linestyle', 'solid');
model.result('pg5').feature('glob3').set('linewidth', 4);
model.result('pg5').feature('glob3').set('linemarker', 'none');
model.result('pg5').feature('glob3').setIndex('legends', 'Analytic SPP dispersion', 0);
model.result('pg5').run;
model.result('pg5').feature('glob3').feature('col1').set('expr', 'real((ewfd.omega/c_const)*sqrt(epsilonr(lda0)/(epsilonr(lda0)+1)))/imag(-(ewfd.omega/c_const)*sqrt(epsilonr(lda0)/(epsilonr(lda0)+1)))');
model.result('pg5').feature('glob3').feature('col1').set('colorlegend', false);
model.result('pg5').run;

model.title(['Simulation of Metal' native2unicode(hex2dec({'20' '13'}), 'unicode') 'Air Surface Plasmon Polariton Propagation and Dispersion']);

model.description('Electromagnetic waves that are confined to propagate along a surface, such as surface plasmon polaritons (SPPs), are of great research interest due to their potential applications in nanoscale manipulation of light. This model demonstrates how to set up a simulation of the propagation and the frequency-wave vector dispersion relationship of SPPs, propagating along an interface between air and bulk silver.');

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
model.sol('sol19').clearSolutionData;
model.sol('sol20').clearSolutionData;
model.sol('sol21').clearSolutionData;
model.sol('sol22').clearSolutionData;
model.sol('sol23').clearSolutionData;
model.sol('sol24').clearSolutionData;
model.sol('sol25').clearSolutionData;
model.sol('sol26').clearSolutionData;
model.sol('sol27').clearSolutionData;
model.sol('sol28').clearSolutionData;
model.sol('sol29').clearSolutionData;
model.sol('sol30').clearSolutionData;
model.sol('sol31').clearSolutionData;

model.label('metal_air_surface_plasmon_polariton.mph');

model.modelNode.label('Components');

out = model;
