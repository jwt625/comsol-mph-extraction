function out = model
%
% submarine_asymptotic_scattering.m
%
% Model exported on May 26 2025, 21:25 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/Acoustics_Module/Underwater_Acoustics');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 3);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.physics.create('paas', 'PressureAcousticsAsymptoticScattering', 'geom1');
model.physics('paas').model('comp1');
model.physics('paas').create('so1', 'ScatteringObject');
model.physics('paas').feature('so1').selection.all;
model.physics('paas').create('efc1', 'ExteriorFieldCalculation');
model.physics('paas').feature('efc1').selection.all;

model.study.create('std1');
model.study('std1').create('freq', 'Frequency');
model.study('std1').feature('freq').setSolveFor('/physics/paas', true);

% To import content from file, use:
% model.param.loadFile('FILENAME');
model.param.set('c0', '1480[m/s]', 'Speed of sound in water');
model.param.set('f0', '2[kHz]', 'Frequency');
model.param.set('depth', '100[m]', 'Depth');
model.param.set('phi', '30[deg]', 'Source location angle');
model.param.set('lam0', 'c0/f0', 'Wavelength');
model.param.set('d_source', '1000[m]', 'Distance from the source');
model.param.set('p_ref', '1[Pa]', 'Reference pressure');
model.param.set('k0', '2*pi/lam0', 'Wave number');
model.param.set('L', '62[m]', 'Submarine length');
model.param.set('kL', 'k0*L', 'Acoustic scale k*L');

model.func.create('int1', 'Interpolation');
model.func('int1').set('source', 'file');
model.func('int1').set('filename', 'submarine_asymptotic_scattering_alpha.txt');
model.func('int1').importData;
model.func('int1').set('funcname', 'alpha');
model.func('int1').set('interp', 'cubicspline');
model.func('int1').setIndex('fununit', 1, 0);
model.func('int1').setIndex('argunit', 'deg', 0);

model.geom('geom1').create('imp1', 'Import');
model.geom('geom1').feature('imp1').set('filename', 'submarine_asymptotic_scattering.mphbin');
model.geom('geom1').runPre('fin');
model.geom('geom1').run('fin');
model.geom('geom1').create('cmf1', 'CompositeFaces');
model.geom('geom1').feature('cmf1').selection('input').set('fin', [1 2 3 4 5 6 7 8 9 10 69 70 71 72 73 79 80 81 82 83]);
model.geom('geom1').run('cmf1');
model.geom('geom1').create('cmf2', 'CompositeFaces');
model.geom('geom1').feature('cmf2').selection('input').set('cmf1', [4 5 6 7 13 14 15 16 24 25 26 27 49 50 62 63 65 66 84 85 86 87]);
model.geom('geom1').run('cmf2');

model.variable.create('var1');
model.variable('var1').model('comp1');

% To import content from file, use:
% model.variable('var1').loadFile('FILENAME');
model.variable('var1').set('p_in', 'aveop1(abs(paas.p_b))', 'Incoming pressure');
model.variable('var1').set('TS', '20*log10((abs(paas.p_s)/p_in)*d_source/1[m])', 'Target strength');

model.cpl.create('aveop1', 'Average', 'geom1');
model.cpl('aveop1').set('axisym', true);
model.cpl('aveop1').selection.geom('geom1', 2);
model.cpl('aveop1').selection.all;

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
model.material('mat1').selection.set([]);
model.material('mat1').selection.allVoids;

model.physics('paas').prop('ReferencePressure').set('ReferenceType', 'ReferencePressureWater');
model.physics('paas').feature('epam1').set('FluidModel', 'OceanAttenuation');
model.physics('paas').feature('bpf1').set('PressureFieldType', 'SphericalWave');
model.physics('paas').feature('bpf1').set('PressureAmplitudeSpherical', 'p_ref');
model.physics('paas').feature('bpf1').set('SourcePointSpherical', {'-d_source*cos(phi)+L/2' '-d_source*sin(phi)' '0'});
model.physics('paas').feature('so1').feature('wall1').set('Type', 'AbsorptionCoefficient');
model.physics('paas').feature('so1').feature('wall1').set('alpha', 'alpha(paas.theta)');

model.mesh('mesh1').create('map1', 'Map');
model.mesh('mesh1').feature('size').set('custom', true);
model.mesh('mesh1').feature('size').set('hmax', 'lam0/4');
model.mesh('mesh1').feature('size').set('hmin', '50[mm]');
model.mesh('mesh1').feature('map1').selection.set([8 9 10 11 12 13 14 15 18 19 24 25 26 27 32 33 34 35 38 39 42 43 46 47 48 49 50 51 52 53 54 55 62 63 64 65 66 67 68 69]);
model.mesh('mesh1').run('map1');
model.mesh('mesh1').create('ftri1', 'FreeTri');
model.mesh('mesh1').feature('ftri1').selection.remaining;
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
model.sol('sol1').attach('std1');
model.sol('sol1').runAll;

model.result.create('pg1', 'PlotGroup3D');
model.result('pg1').set('data', 'dset1');
model.result('pg1').setIndex('looplevel', 1, 0);
model.result('pg1').set('edges', 'off');
model.result('pg1').set('view', 'new');
model.result('pg1').create('rp1', 'RadiationPattern');
model.result('pg1').feature('rp1').set('expr', {'paas.Lp_s'});
model.result('pg1').feature('rp1').set('thetadisc', 40);
model.result('pg1').feature('rp1').set('phidisc', 60);
model.result('pg1').feature('rp1').set('grid', 'fine');
model.result('pg1').feature('rp1').set('colortable', 'Rainbow');
model.result('pg1').feature('rp1').set('colorscalemode', 'linear');
model.result('pg1').set('showlegendsunit', true);
model.result('pg1').label('Exterior-Field Sound Pressure Level (paas)');
model.result.create('pg2', 'PlotGroup2D');
model.result('pg2').set('data', 'none');
model.result('pg2').create('rp1', 'RadiationPattern');
model.result('pg2').feature('rp1').set('data', 'dset1');
model.result('pg2').feature('rp1').set('expr', {'paas.p_s'});
model.result('pg2').feature('rp1').set('thetadisc', 40);
model.result('pg2').feature('rp1').set('phidisc', 60);
model.result('pg2').feature('rp1').set('colortable', 'Cividis');
model.result('pg2').set('showlegendsunit', true);
model.result('pg2').label('Exterior-Field Pressure (paas)');
model.result.create('pg3', 'PolarGroup');
model.result('pg3').set('data', 'dset1');
model.result('pg3').create('rp1', 'RadiationPattern');
model.result('pg3').feature('rp1').set('expr', {'paas.Lp_s'});
model.result('pg3').feature('rp1').set('legend', true);
model.result('pg3').feature('rp1').set('phidisc', 180);
model.result('pg3').label('Exterior-Field Sound Pressure Level xy-plane (paas)');
model.result('pg3').setIndex('looplevelinput', 'last', 0);
model.result.dataset.create('grid1', 'Grid3D');
model.result.dataset('grid1').set('source', 'data');
model.result.dataset('grid1').set('data', 'dset1');
model.result.dataset('grid1').set('par1', 'x');
model.result.dataset('grid1').set('parmin1', -62.00000000000002);
model.result.dataset('grid1').set('parmax1', 124.00000000000004);
model.result.dataset('grid1').set('par2', 'y');
model.result.dataset('grid1').set('parmin2', -10.500000000000014);
model.result.dataset('grid1').set('parmax2', 10.500000000000014);
model.result.dataset('grid1').set('par3', 'z');
model.result.dataset('grid1').set('parmin3', -14.500000000000014);
model.result.dataset('grid1').set('parmax3', 18.500000000000014);
model.result.create('pg4', 'PlotGroup3D');
model.result('pg4').set('data', 'grid1');
model.result('pg4').setIndex('looplevel', 1, 0);
model.result('pg4').create('mslc1', 'Multislice');
model.result('pg4').feature('mslc1').set('colortable', 'Wave');
model.result('pg4').feature('mslc1').set('colorscalemode', 'linearsymmetric');
model.result('pg4').feature('mslc1').set('expr', {'paas.p_t'});
model.result('pg4').label('Acoustic Pressure (paas)');
model.result('pg4').set('showlegendsunit', true);
model.result('pg4').create('line1', 'Line');
model.result('pg4').feature('line1').set('expr', {'1'});
model.result('pg4').feature('line1').set('data', 'dset1');
model.result('pg4').feature('line1').set('titletype', 'none');
model.result('pg4').feature('line1').set('coloring', 'uniform');
model.result('pg4').feature('line1').set('color', 'black');
model.result('pg4').feature('line1').set('solutionparams', 'parent');
model.result('pg4').create('surf1', 'Surface');
model.result('pg4').feature('surf1').set('expr', {'paas.p_t'});
model.result('pg4').feature('surf1').set('data', 'dset1');
model.result('pg4').feature('surf1').set('inheritplot', 'mslc1');
model.result('pg4').feature('surf1').set('solutionparams', 'parent');
model.result('pg1').run;
model.result.setOnlyPlotWhenRequested(true);
model.result('pg1').label('3D Scattered SPL Radiation Pattern at 100 m');
model.result('pg1').set('titletype', 'label');
model.result('pg1').feature('rp1').set('thetadisc', 90);
model.result('pg1').feature('rp1').set('phidisc', 180);
model.result('pg1').feature('rp1').set('sphere', 'manual');
model.result('pg1').feature('rp1').set('center', {'L/2' '0' '0'});
model.result('pg1').feature('rp1').set('radius', '100[m]');
model.result('pg1').feature('rp1').set('grid', 'finer');
model.result('pg1').feature('rp1').create('tran1', 'Transparency');
model.result('pg1').create('surf1', 'Surface');
model.result('pg1').feature('surf1').set('expr', '1');
model.result('pg1').feature('surf1').set('coloring', 'uniform');
model.result('pg1').feature('surf1').set('color', 'gray');
model.result('pg1').create('line1', 'Line');
model.result('pg1').feature('line1').set('data', 'dset1');
model.result('pg1').feature('line1').set('expr', '1');
model.result('pg1').feature('line1').set('coloring', 'uniform');
model.result('pg1').feature('line1').set('color', 'black');
model.result('pg1').run;
model.result('pg2').label('Exterior-Field Pressure at 100 m');
model.result('pg2').set('titletype', 'label');
model.result('pg2').feature('rp1').set('thetadisc', 90);
model.result('pg2').feature('rp1').set('phidisc', 180);
model.result('pg2').feature('rp1').set('sphere', 'manual');
model.result('pg2').feature('rp1').set('center', {'L/2' '0' '0'});
model.result('pg2').feature('rp1').set('radius', '100[m]');
model.result('pg2').run;
model.result('pg3').label('Scattered SPL in xy-plane (at source distance)');
model.result('pg3').set('titletype', 'label');
model.result('pg3').feature('rp1').set('phidisc', 1800);
model.result('pg3').feature('rp1').set('center3', {'L/2' '0' '0'});
model.result('pg3').feature('rp1').set('radius', 'd_source');
model.result('pg3').feature('rp1').set('refdir', [-1 0 0]);
model.result('pg3').run;
model.result.dataset('grid1').set('parmin1', -20);
model.result.dataset('grid1').set('parmax1', 80);
model.result.dataset('grid1').set('parmin2', -25);
model.result.dataset('grid1').set('parmax2', 25);
model.result.dataset('grid1').set('parmin3', -25);
model.result.dataset('grid1').set('parmax3', 25);
model.result.dataset('grid1').set('res1', 400);
model.result.dataset('grid1').set('res2', 200);
model.result.dataset('grid1').set('res3', 2);
model.result('pg4').feature('mslc1').set('xnumber', '0');
model.result('pg4').feature('mslc1').set('ynumber', '0');
model.result('pg4').run;
model.result.create('pg5', 'PlotGroup3D');
model.result('pg5').label('Visibility');
model.result('pg5').set('titletype', 'label');
model.result('pg5').create('surf1', 'Surface');
model.result('pg5').feature('surf1').set('expr', 'paas.bpf1.visibility');
model.result('pg5').feature('surf1').set('descr', 'Visibility');
model.result('pg5').run;
model.result.create('pg6', 'PlotGroup3D');
model.result('pg6').label('Angle of Incidence');
model.result('pg6').set('titletype', 'label');
model.result('pg6').create('surf1', 'Surface');
model.result('pg6').feature('surf1').set('expr', 'paas.bpf1.theta');
model.result('pg6').feature('surf1').set('descr', 'Incident angle');
model.result('pg6').feature('surf1').set('expr', 'if(paas.bpf1.visibility,paas.bpf1.theta,NaN)');
model.result('pg6').run;
model.result.create('pg7', 'PlotGroup3D');
model.result('pg7').label('Surface Normal Absorption');
model.result('pg7').set('titletype', 'label');
model.result('pg7').create('surf1', 'Surface');
model.result('pg7').feature('surf1').set('expr', 'if(paas.bpf1.visibility,alpha(paas.bpf1.theta),NaN)');
model.result('pg7').run;
model.result.dataset.create('pc1', 'ParCurve3D');
model.result.dataset('pc1').set('parmax1', '2*pi');
model.result.dataset('pc1').set('exprx', '-d_source*cos(s)+L/2');
model.result.dataset('pc1').set('expry', '-d_source*sin(s)');
model.result.dataset('pc1').set('global', true);
model.result.dataset.create('cpl1', 'CutPlane');
model.result.dataset('cpl1').set('data', 'grid1');
model.result.dataset('cpl1').set('quickplane', 'xy');
model.result.create('pg8', 'PlotGroup1D');
model.result('pg8').label('Ballistic Target Strength');
model.result('pg8').set('data', 'pc1');
model.result('pg8').set('titletype', 'label');
model.result('pg8').create('lngr1', 'LineGraph');
model.result('pg8').feature('lngr1').set('markerpos', 'datapoints');
model.result('pg8').feature('lngr1').set('linewidth', 'preference');
model.result('pg8').feature('lngr1').set('expr', 'TS');
model.result('pg8').feature('lngr1').set('xdata', 'expr');
model.result('pg8').feature('lngr1').set('xdataexpr', 's[rad]');
model.result('pg8').feature('lngr1').set('xdatadescractive', true);
model.result('pg8').feature('lngr1').set('xdatadescr', 'Receiver angle');
model.result('pg8').run;
model.result.create('pg9', 'PlotGroup3D');
model.result('pg9').label('Scattered SPL');
model.result('pg9').set('data', 'cpl1');
model.result('pg9').set('titletype', 'label');
model.result('pg9').set('showlegendsunit', true);
model.result('pg9').create('surf1', 'Surface');
model.result('pg9').feature('surf1').set('expr', 'paas.Lp_s');
model.result('pg9').create('surf2', 'Surface');
model.result('pg9').feature('surf2').set('data', 'dset1');
model.result('pg9').feature('surf2').set('expr', '1');
model.result('pg9').feature('surf2').create('mtrl1', 'MaterialAppearance');
model.result('pg9').feature('surf2').feature('mtrl1').set('appearance', 'custom');
model.result('pg9').feature('surf2').feature('mtrl1').set('family', 'steel');
model.result('pg9').create('line1', 'Line');
model.result('pg9').feature('line1').set('data', 'dset1');
model.result('pg9').feature('line1').set('expr', '1');
model.result('pg9').feature('line1').set('coloring', 'uniform');
model.result('pg9').feature('line1').set('color', 'black');
model.result('pg9').create('arpt1', 'ArrowPoint');
model.result('pg9').feature('arpt1').set('data', 'dset1');
model.result('pg9').feature('arpt1').set('expr', {'10*cos(phi)' '' ''});
model.result('pg9').feature('arpt1').setIndex('expr', '10*sin(phi)', 1);
model.result('pg9').feature('arpt1').setIndex('expr', 0, 2);
model.result('pg9').feature('arpt1').set('arrowbase', 'head');
model.result('pg9').feature('arpt1').set('scaleactive', true);
model.result('pg9').feature('arpt1').create('sel1', 'Selection');
model.result('pg9').feature('arpt1').feature('sel1').selection.set([44]);
model.result('pg9').run;

model.title('Submarine High-Frequency Asymptotic Scattering');

model.description(['The primary defense of a submarine lies in its capacity to remain hidden during operation. As radio waves are strongly absorbed by sea water, sound navigation ranging, or SONAR, is one of the main methods used for the detection of submarines. SONAR systems are also used for underwater exploration as well as in the fishing industry.' newline  newline 'Designers analyze the way acoustic waves are reflected in order to minimize the equivalent reflecting area of the submarine. This tutorial studies the scattering off the BeTTSi benchmark submarine (Benchmark Target Echo Strength Simulation).' newline  newline 'This model uses the high-frequency approximation of the Pressure Acoustics, Asymptotic Scattering interface. The analysis is fast and a good approximation at high frequencies when the wavelength is much smaller than the scattering object.']);

model.mesh.clearMeshes;

model.sol('sol1').clearSolutionData;

model.label('submarine_asymptotic_scattering.mph');

model.modelNode.label('Components');

out = model;
