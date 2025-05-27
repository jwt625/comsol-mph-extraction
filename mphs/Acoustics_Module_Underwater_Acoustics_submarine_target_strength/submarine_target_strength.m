function out = model
%
% submarine_target_strength.m
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

model.physics.create('pabe', 'PressureAcousticsBoundaryElements', 'geom1');
model.physics('pabe').model('comp1');

model.study.create('std1');
model.study('std1').create('freq', 'Frequency');
model.study('std1').feature('freq').setSolveFor('/physics/pabe', true);

model.geom('geom1').geomRep('cadps');
model.geom('geom1').create('imp1', 'Import');
model.geom('geom1').feature('imp1').set('type', 'native');
model.geom('geom1').feature('imp1').set('filename', 'submarine_target_strength.mphbin');
model.geom('geom1').feature('imp1').importData;

model.param.label('Model Parameters');

% To import content from file, use:
% model.param.loadFile('FILENAME');
model.param.set('c0', '1480[m/s]', 'Speed of sound in water');
model.param.set('f_max', '1.5[kHz]', 'Maximum frequency');
model.param.set('depth', '100[m]', 'Depth');
model.param.set('phi', '330[deg]', 'Angle of the incoming plane wave');
model.param.set('lam0', 'c0/f_max', 'Minimum wavelength');
model.param.set('d_source', '1000[m]', 'Distance from the source');
model.param.set('p_ref', '1[Pa]', 'Reference pressure');
model.param.set('alpha_n', '0.05', 'Normal incidence absorption coefficient');

model.cpl.create('aveop1', 'Average', 'geom1');

model.geom('geom1').run;

model.cpl('aveop1').set('axisym', true);
model.cpl('aveop1').selection.geom('geom1', 2);
model.cpl('aveop1').selection.all;

model.variable.create('var1');
model.variable('var1').model('comp1');
model.variable('var1').set('TS', '20*log10((abs(pabe.p_s)/p_in)*d_source/1[m])');
model.variable('var1').descr('TS', 'Target strength');
model.variable('var1').set('p_in', 'aveop1(abs(pabe.p_b))');
model.variable('var1').descr('p_in', 'Incoming pressure');

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

model.physics('pabe').selection.set([]);
model.physics('pabe').selection.allVoids;
model.physics('pabe').prop('ReferencePressure').set('ReferenceType', 'ReferencePressureWater');
model.physics('pabe').prop('Stabilization').set('StabilizedFormulation', true);
model.physics('pabe').feature('bpam1').set('FluidModel', 'OceanAttenuation');
model.physics('pabe').feature('bpam1').set('minput_depth', 'depth');
model.physics('pabe').create('bpf1', 'BackgroundPressureField', 3);
model.physics('pabe').feature('bpf1').set('PressureFieldType', 'SphericalWave');
model.physics('pabe').feature('bpf1').set('PressureAmplitudeSpherical', 'p_ref');
model.physics('pabe').feature('bpf1').set('SourcePointSpherical', {'-d_source*cos(phi)' '-d_source*sin(phi)' '0'});
model.physics('pabe').create('imp1', 'Impedance', 2);
model.physics('pabe').feature('imp1').selection.all;
model.physics('pabe').feature('imp1').set('ImpedanceModel', 'AbsorptionCoefficient');
model.physics('pabe').feature('imp1').set('alpha_n', 'alpha_n');

model.mesh('mesh1').create('map1', 'Map');
model.mesh('mesh1').feature('map1').selection.set([19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 41 42 43 44 49 50 51 52 55 56 59 60 61 64 65 66 91 92 93 94 95 96 97 98]);
model.mesh('mesh1').feature('map1').create('dis1', 'Distribution');
model.mesh('mesh1').feature('map1').feature('dis1').selection.set([67 70 73 74 75 76 102 103]);
model.mesh('mesh1').feature('map1').feature('dis1').set('type', 'predefined');
model.mesh('mesh1').feature('map1').feature('dis1').set('elemcount', 20);
model.mesh('mesh1').feature('map1').feature('dis1').set('elemratio', 4);
model.mesh('mesh1').feature('map1').feature('dis1').set('reverse', true);
model.mesh('mesh1').feature('map1').create('dis2', 'Distribution');
model.mesh('mesh1').feature('map1').feature('dis2').selection.set([105 107]);
model.mesh('mesh1').feature('map1').feature('dis2').set('type', 'predefined');
model.mesh('mesh1').feature('map1').feature('dis2').set('elemcount', 65);
model.mesh('mesh1').feature('map1').feature('dis2').set('elemratio', 3);
model.mesh('mesh1').feature('map1').create('dis3', 'Distribution');
model.mesh('mesh1').feature('map1').feature('dis3').selection.set([194 195 197 198 200 201 203 204 205 206 207 209 210 211 213 214]);
model.mesh('mesh1').feature('map1').feature('dis3').set('type', 'predefined');
model.mesh('mesh1').feature('map1').feature('dis3').set('elemcount', 20);
model.mesh('mesh1').feature('map1').feature('dis3').set('elemratio', 4);
model.mesh('mesh1').feature('map1').create('dis4', 'Distribution');
model.mesh('mesh1').feature('map1').feature('dis4').selection.set([81 83]);
model.mesh('mesh1').feature('map1').feature('dis4').set('numelem', 2);
model.mesh('mesh1').feature('size').set('custom', true);
model.mesh('mesh1').feature('size').set('hmax', 'lam0/4');
model.mesh('mesh1').feature('size').set('hmin', '50[mm]');
model.mesh('mesh1').create('ftri1', 'FreeTri');
model.mesh('mesh1').feature('ftri1').selection.remaining;
model.mesh('mesh1').feature('ftri1').set('method', 'af');
model.mesh('mesh1').run;

model.study('std1').feature('freq').set('plist', 'f_max');
model.study('std1').setGenPlots(false);

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
model.sol('sol1').feature('s1').feature('p1').set('plistarr', {'f_max'});
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
model.sol('sol1').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('s1').create('i1', 'Iterative');
model.sol('sol1').feature('s1').feature('i1').set('linsolver', 'gmres');
model.sol('sol1').feature('s1').feature('i1').label('Suggested Iterative Solver (GMRES with Direct Precon.) (pabe)');
model.sol('sol1').feature('s1').feature('i1').create('dp1', 'DirectPreconditioner');
model.sol('sol1').feature('s1').feature('i1').feature('dp1').set('mumpsblr', true);
model.sol('sol1').feature('s1').feature('i1').feature('dp1').set('mumpsblrtol', 1.0E-6);
model.sol('sol1').feature('s1').feature('fc1').set('linsolver', 'i1');
model.sol('sol1').feature('s1').feature.remove('fcDef');
model.sol('sol1').attach('std1');
model.sol('sol1').runAll;

model.result.setOnlyPlotWhenRequested(true);
model.result.dataset.create('grid1', 'Grid3D');
model.result.dataset('grid1').set('source', 'data');
model.result.dataset('grid1').set('parmin1', -20);
model.result.dataset('grid1').set('parmax1', 80);
model.result.dataset('grid1').set('parmin2', -25);
model.result.dataset('grid1').set('parmax2', 25);
model.result.dataset('grid1').set('parmin3', -0.1);
model.result.dataset('grid1').set('parmax3', 0.1);
model.result.dataset('grid1').set('res1', 500);
model.result.dataset('grid1').set('res2', 250);
model.result.dataset('grid1').set('res3', 3);
model.result.dataset.create('cpl1', 'CutPlane');
model.result.dataset('cpl1').set('quickplane', 'xy');
model.result.dataset.create('cpl2', 'CutPlane');
model.result.dataset('cpl2').set('data', 'grid1');
model.result.dataset('cpl2').set('quickplane', 'xy');
model.result.dataset.create('pc1', 'ParCurve3D');
model.result.dataset('pc1').set('parmax1', '2*pi');
model.result.dataset('pc1').set('exprx', '-d_source*cos(s)');
model.result.dataset('pc1').set('expry', '-d_source*sin(s)');
model.result.dataset('pc1').set('global', true);
model.result.dataset('pc1').set('res1', 10000);
model.result.create('pg1', 'PlotGroup3D');
model.result('pg1').label('Total Pressure, Boundaries');
model.result('pg1').set('showlegendsunit', true);
model.result('pg1').create('surf1', 'Surface');
model.result('pg1').feature('surf1').set('expr', 'pabe.p_t_bnd');
model.result('pg1').feature('surf1').set('colortable', 'Wave');
model.result('pg1').feature('surf1').set('colorscalemode', 'linearsymmetric');
model.result('pg1').feature('surf1').set('resolution', 'extrafine');

model.view('view1').set('showgrid', false);

model.result('pg1').run;
model.result.duplicate('pg2', 'pg1');
model.result('pg2').label('Radiation Pattern at 100 m');
model.result('pg2').set('view', 'new');
model.result('pg2').set('titletype', 'label');
model.result('pg2').feature('surf1').set('expr', '0');

model.view('view2').set('showgrid', false);

model.result('pg2').feature('surf1').set('titletype', 'none');
model.result('pg2').feature('surf1').create('mtrl1', 'MaterialAppearance');
model.result('pg2').feature('surf1').feature('mtrl1').set('appearance', 'custom');
model.result('pg2').feature('surf1').feature('mtrl1').set('family', 'carbonforged');
model.result('pg2').run;
model.result('pg2').create('rp1', 'RadiationPattern');
model.result('pg2').feature('rp1').set('expr', '100[m]+pabe.Lp_s[m]');
model.result('pg2').feature('rp1').set('descractive', true);
model.result('pg2').feature('rp1').set('descr', 'Scattered sound pressure level at 100[m]');
model.result('pg2').feature('rp1').set('useradiusascolor', false);
model.result('pg2').feature('rp1').set('colorexpr', 'pabe.Lp_s');
model.result('pg2').feature('rp1').set('rangecoloractive', true);
model.result('pg2').feature('rp1').set('rangecolormax', 55);
model.result('pg2').feature('rp1').set('thetadisc', 120);
model.result('pg2').feature('rp1').set('phidisc', 1440);
model.result('pg2').feature('rp1').set('anglerestr', 'manual');
model.result('pg2').feature('rp1').set('thetamin', 75);
model.result('pg2').feature('rp1').set('thetarange', 30);
model.result('pg2').feature('rp1').set('sphere', 'manual');
model.result('pg2').feature('rp1').set('center', {'28[m]' '0' '0'});
model.result('pg2').feature('rp1').set('radius', '100[m]');
model.result('pg2').run;
model.result('pg2').create('arws1', 'ArrowSurface');
model.result('pg2').feature('arws1').set('expr', {'cos(phi)' 'sin(phi)' ''});
model.result('pg2').feature('arws1').setIndex('expr', 0, 2);
model.result('pg2').feature('arws1').set('titletype', 'none');
model.result('pg2').feature('arws1').set('placement', 'uniformani');
model.result('pg2').feature('arws1').set('arrowcount', 1);
model.result('pg2').feature('arws1').set('weight', [0.1 1 1]);
model.result('pg2').feature('arws1').set('arrowbase', 'head');
model.result('pg2').feature('arws1').set('scaleactive', true);
model.result('pg2').feature('arws1').set('scale', 50);
model.result('pg2').feature('arws1').create('sel1', 'Selection');
model.result('pg2').feature('arws1').feature('sel1').selection.set([36]);
model.result('pg2').run;
model.result.create('pg3', 'PlotGroup2D');
model.result('pg3').label('Scattered Pressure at z = 0');
model.result('pg3').set('showlegendsunit', true);
model.result('pg3').create('surf1', 'Surface');
model.result('pg3').feature('surf1').set('data', 'cpl2');
model.result('pg3').feature('surf1').set('expr', 'pabe.p_s');
model.result('pg3').feature('surf1').set('colortable', 'Wave');
model.result('pg3').feature('surf1').set('colorscalemode', 'linearsymmetric');
model.result('pg3').run;
model.result.duplicate('pg4', 'pg3');
model.result('pg4').label('Scattered Sound Pressure Level at z = 0');
model.result('pg4').feature('surf1').set('expr', 'pabe.Lp_s');
model.result('pg4').feature('surf1').set('colortable', 'Rainbow');
model.result('pg4').feature('surf1').set('colorscalemode', 'linear');
model.result('pg4').run;
model.result.create('pg5', 'PolarGroup');
model.result('pg5').label('Radiation Pattern - Scattered Sound Pressure Level');
model.result('pg5').set('zeroangle', 'left');
model.result('pg5').create('rp1', 'RadiationPattern');
model.result('pg5').feature('rp1').set('markerpos', 'datapoints');
model.result('pg5').feature('rp1').set('linewidth', 'preference');
model.result('pg5').feature('rp1').set('expr', 'pabe.Lp_s');
model.result('pg5').feature('rp1').set('phidisc', 5000);
model.result('pg5').feature('rp1').set('radius', 'd_source');
model.result('pg5').feature('rp1').set('refdir', [-1 0 0]);
model.result('pg5').run;
model.result.create('pg6', 'PlotGroup1D');
model.result('pg6').label('Bistatic Target Strength');
model.result('pg6').set('data', 'pc1');
model.result('pg6').create('lngr1', 'LineGraph');
model.result('pg6').feature('lngr1').set('markerpos', 'datapoints');
model.result('pg6').feature('lngr1').set('linewidth', 'preference');
model.result('pg6').feature('lngr1').set('expr', 'TS');
model.result('pg6').feature('lngr1').set('xdata', 'expr');
model.result('pg6').feature('lngr1').set('xdataexpr', 's[rad]');
model.result('pg6').feature('lngr1').set('xdataunit', [native2unicode(hex2dec({'00' 'b0'}), 'unicode') ]);
model.result('pg6').feature('lngr1').set('xdatadescractive', true);
model.result('pg6').feature('lngr1').set('xdatadescr', 'Receiver angle');
model.result('pg6').run;

model.title('Submarine Target Strength');

model.description(['The primary defense of a submarine lies in its capacity to remain hidden during operation. As radio waves are strongly absorbed by sea water, sound navigation ranging, or SONAR, is one of the main methods used for the detection of submarines. SONAR systems are also used for underwater exploration as well as in the fishing industry.' newline  newline 'Designers analyze the way acoustic waves are reflected in order to minimize the equivalent reflecting area of the submarine. The target strength, or TS, is a measure of the area of a sonar target. This tutorial presents a simplified method to analyze the TS of the BeTTSi benchmark submarine (Benchmark Target Echo Strength Simulation).' newline  newline 'This model is acoustically large and takes advantage of the stabilized formulation in the Pressure Acoustic, Boundary Elements interface (BEM). Enabling the stabilized formulation ensures convergence for large models (high frequency or large domains) at the cost of some additional degrees of freedom.']);

model.mesh.clearMeshes;

model.sol('sol1').clearSolutionData;

model.label('submarine_target_strength.mph');

model.modelNode.label('Components');

out = model;
