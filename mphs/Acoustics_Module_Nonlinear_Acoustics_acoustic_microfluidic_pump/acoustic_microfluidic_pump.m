function out = model
%
% acoustic_microfluidic_pump.m
%
% Model exported on May 26 2025, 21:25 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/Acoustics_Module/Nonlinear_Acoustics');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 2);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.physics.create('acpr', 'PressureAcoustics', 'geom1');
model.physics('acpr').model('comp1');
model.physics.create('ta', 'ThermoacousticsSinglePhysics', 'geom1');
model.physics('ta').model('comp1');
model.physics.create('spf', 'LaminarFlow', 'geom1');
model.physics('spf').model('comp1');

model.study.create('std1');
model.study('std1').create('freq', 'Frequency');
model.study('std1').feature('freq').setSolveFor('/physics/acpr', true);
model.study('std1').feature('freq').setSolveFor('/physics/ta', true);
model.study('std1').feature('freq').setSolveFor('/physics/spf', true);

model.geom('geom1').insertFile('acoustic_microfluidic_pump_geom_sequence.mph', 'geom1');
model.geom('geom1').run('fin');

model.param.label('Parameters - Geometry');
model.param.create('par2');
model.param('par2').label('Parameters - Model');

% To import content from file, use:
% model.param('par2').loadFile('FILENAME');
model.param('par2').set('act_d0', '1[nm]', 'Actuation displacement');
model.param('par2').set('f0', '2[MHz]', 'Actuation frequency');
model.param('par2').set('act_v0', '2*pi*f0*act_d0', 'Actuation velocity');

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

model.physics('acpr').selection.set([1]);
model.physics('acpr').feature('fpam1').set('FluidModel', 'Viscothermal');
model.physics('acpr').create('tvb1', 'ThermoviscousBoundaryLayerImpedance', 1);
model.physics('acpr').feature('tvb1').selection.all;
model.physics('acpr').feature('tvb1').set('FluidMaterial', 'mat1');
model.physics('acpr').create('tvb2', 'ThermoviscousBoundaryLayerImpedance', 1);
model.physics('acpr').feature('tvb2').label('Thermoviscous Boundary Layer Impedance - Actuation');
model.physics('acpr').feature('tvb2').selection.set([1 4 111 112]);
model.physics('acpr').feature('tvb2').set('FluidMaterial', 'mat1');
model.physics('acpr').feature('tvb2').set('MechanicalCondition', 'Velocity');
model.physics('acpr').feature('tvb2').set('vel', {'act_v0' '0' '0'});
model.physics('ta').selection.set([2 3 4 5 6 7 8 9 10 11 12 13 14]);
model.physics('ta').prop('ShapeProperty').set('shapeorder_p', '2s');
model.physics('ta').prop('ShapeProperty').set('shapeorder_u', '3s');
model.physics('ta').prop('ShapeProperty').set('shapeorder_T', '3s');

model.multiphysics.create('atb1', 'AcousticThermoacousticBoundary', 'geom1', 1);
model.multiphysics('atb1').selection.all;
model.multiphysics.create('asdc1', 'AcousticStreamingDomainCoupling', 'geom1', 2);
model.multiphysics('asdc1').set('Source_physics', 'ta');
model.multiphysics('asdc1').selection.all;

model.physics('spf').create('prpc1', 'PressurePointConstraint', 0);
model.physics('spf').feature('prpc1').selection.set([20]);

model.mesh('mesh1').create('ftri1', 'FreeTri');
model.mesh('mesh1').feature('ftri1').create('size1', 'Size');
model.mesh('mesh1').feature('ftri1').feature('size1').selection.geom('geom1', 2);
model.mesh('mesh1').feature('ftri1').feature('size1').selection.all;
model.mesh('mesh1').feature('ftri1').feature('size1').selection.set([2 3 4 5 6 7 8 9 10 11 12 13 14]);
model.mesh('mesh1').feature('ftri1').feature('size1').set('hauto', 1);
model.mesh('mesh1').feature('size').set('table', 'cfd');
model.mesh('mesh1').feature('size').set('hauto', 2);
model.mesh('mesh1').feature('ftri1').create('dis1', 'Distribution');
model.mesh('mesh1').feature('ftri1').feature('dis1').selection.set([120 124 128 132 136 140 144 148 152 156 160 164 168]);
model.mesh('mesh1').feature('ftri1').feature('dis1').set('numelem', 6);
model.mesh('mesh1').create('bl1', 'BndLayer');
model.mesh('mesh1').feature('bl1').create('blp', 'BndLayerProp');
model.mesh('mesh1').feature('bl1').feature('blp').selection.all;
model.mesh('mesh1').feature('bl1').feature('blp').selection.set([1 2 3 4 5 6 8 10 11 12 14 17 18 19 20 22 25 26 27 28 30 33 34 35 36 38 41 42 43 44 46 49 50 51 52 54 57 58 59 60 62 65 66 67 68 70 73 74 75 76 78 81 82 83 84 86 89 90 91 92 94 97 98 99 100 102 105 106 107 108 110 111 112 113 114 115 116 117 118 119 120 121 122 123 124 125 126 127 128 129 130 131 132 133 134 135 136 137 138 139 140 141 142 143 144 145 146 147 148 149 150 151 152 153 154 155 156 157 158 159 160 161 162 163 164 165 166 167 168 169 170 171 172]);
model.mesh('mesh1').feature('bl1').feature('blp').set('blnlayers', 6);
model.mesh('mesh1').feature('bl1').feature('blp').set('inittype', 'blhmin');
model.mesh('mesh1').feature('bl1').feature('blp').set('blhmin', '0.2E-6');
model.mesh('mesh1').run;

model.study('std1').setGenPlots(false);
model.study('std1').create('stat', 'Stationary');
model.study('std1').feature('freq').set('plist', 'f0');
model.study('std1').feature('stat').setEntry('activateCoupling', 'atb1', false);

model.sol.create('sol1');

model.mesh('mesh1').stat.selection.geom(2);
model.mesh('mesh1').stat.selection.set([1 2 3 4 5 6 7 8 9 10 11 12 13 14]);
model.mesh('mesh1').stat.selection.geom(2);
model.mesh('mesh1').stat.selection.set([1 2 3 4 5 6 7 8 9 10 11 12 13 14]);

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
model.sol('sol1').feature('s1').create('seDef', 'Segregated');
model.sol('sol1').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('s1').create('d1', 'Direct');
model.sol('sol1').feature('s1').feature('d1').set('linsolver', 'pardiso');
model.sol('sol1').feature('s1').feature('d1').set('pivotperturb', 1.0E-13);
model.sol('sol1').feature('s1').feature('fc1').set('linsolver', 'd1');
model.sol('sol1').feature('s1').feature.remove('fcDef');
model.sol('sol1').feature('s1').feature.remove('seDef');
model.sol('sol1').create('su1', 'StoreSolution');
model.sol('sol1').create('st2', 'StudyStep');
model.sol('sol1').feature('st2').set('study', 'std1');
model.sol('sol1').feature('st2').set('studystep', 'stat');
model.sol('sol1').create('v2', 'Variables');
model.sol('sol1').feature('v2').set('initmethod', 'sol');
model.sol('sol1').feature('v2').set('initsol', 'sol1');
model.sol('sol1').feature('v2').set('notsolmethod', 'sol');
model.sol('sol1').feature('v2').set('notsol', 'sol1');
model.sol('sol1').feature('v2').set('control', 'stat');
model.sol('sol1').create('s2', 'Stationary');
model.sol('sol1').feature('s2').feature('aDef').set('cachepattern', true);
model.sol('sol1').feature('s2').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('s2').feature('fc1').set('dtech', 'auto');
model.sol('sol1').feature('s2').feature('fc1').set('initstep', 0.01);
model.sol('sol1').feature('s2').feature('fc1').set('minstep', 1.0E-4);
model.sol('sol1').feature('s2').feature('fc1').set('maxiter', 100);
model.sol('sol1').feature('s2').create('d1', 'Direct');
model.sol('sol1').feature('s2').feature('d1').set('linsolver', 'pardiso');
model.sol('sol1').feature('s2').feature('d1').set('pivotperturb', 1.0E-13);
model.sol('sol1').feature('s2').feature('d1').label('Direct, fluid flow variables (spf)');
model.sol('sol1').feature('s2').create('i1', 'Iterative');
model.sol('sol1').feature('s2').feature('i1').set('linsolver', 'gmres');
model.sol('sol1').feature('s2').feature('i1').set('prefuntype', 'left');
model.sol('sol1').feature('s2').feature('i1').set('itrestart', 50);
model.sol('sol1').feature('s2').feature('i1').set('rhob', 20);
model.sol('sol1').feature('s2').feature('i1').set('maxlinit', 1000);
model.sol('sol1').feature('s2').feature('i1').set('nlinnormuse', 'on');
model.sol('sol1').feature('s2').feature('i1').label('AMG, fluid flow variables (spf)');
model.sol('sol1').feature('s2').feature('i1').create('mg1', 'Multigrid');
model.sol('sol1').feature('s2').feature('i1').feature('mg1').set('prefun', 'saamg');
model.sol('sol1').feature('s2').feature('i1').feature('mg1').set('mgcycle', 'v');
model.sol('sol1').feature('s2').feature('i1').feature('mg1').set('maxcoarsedof', 80000);
model.sol('sol1').feature('s2').feature('i1').feature('mg1').set('strconn', 0.02);
model.sol('sol1').feature('s2').feature('i1').feature('mg1').set('nullspace', 'constant');
model.sol('sol1').feature('s2').feature('i1').feature('mg1').set('usesmooth', false);
model.sol('sol1').feature('s2').feature('i1').feature('mg1').set('saamgcompwise', true);
model.sol('sol1').feature('s2').feature('i1').feature('mg1').set('loweramg', true);
model.sol('sol1').feature('s2').feature('i1').feature('mg1').set('compactaggregation', false);
model.sol('sol1').feature('s2').feature('i1').feature('mg1').feature('pr').create('sc1', 'SCGS');
model.sol('sol1').feature('s2').feature('i1').feature('mg1').feature('pr').feature('sc1').set('linesweeptype', 'ssor');
model.sol('sol1').feature('s2').feature('i1').feature('mg1').feature('pr').feature('sc1').set('iter', 0);
model.sol('sol1').feature('s2').feature('i1').feature('mg1').feature('pr').feature('sc1').set('scgsrelax', 0.7);
model.sol('sol1').feature('s2').feature('i1').feature('mg1').feature('pr').feature('sc1').set('scgsmethod', 'lines');
model.sol('sol1').feature('s2').feature('i1').feature('mg1').feature('pr').feature('sc1').set('scgsvertexrelax', 0.7);
model.sol('sol1').feature('s2').feature('i1').feature('mg1').feature('pr').feature('sc1').set('relax', 0.5);
model.sol('sol1').feature('s2').feature('i1').feature('mg1').feature('pr').feature('sc1').set('scgssolv', 'stored');
model.sol('sol1').feature('s2').feature('i1').feature('mg1').feature('pr').feature('sc1').set('approxscgs', true);
model.sol('sol1').feature('s2').feature('i1').feature('mg1').feature('pr').feature('sc1').set('scgsdirectmaxsize', 1000);
model.sol('sol1').feature('s2').feature('i1').feature('mg1').feature('po').create('sc1', 'SCGS');
model.sol('sol1').feature('s2').feature('i1').feature('mg1').feature('po').feature('sc1').set('linesweeptype', 'ssor');
model.sol('sol1').feature('s2').feature('i1').feature('mg1').feature('po').feature('sc1').set('iter', 1);
model.sol('sol1').feature('s2').feature('i1').feature('mg1').feature('po').feature('sc1').set('scgsrelax', 0.7);
model.sol('sol1').feature('s2').feature('i1').feature('mg1').feature('po').feature('sc1').set('scgsmethod', 'lines');
model.sol('sol1').feature('s2').feature('i1').feature('mg1').feature('po').feature('sc1').set('scgsvertexrelax', 0.7);
model.sol('sol1').feature('s2').feature('i1').feature('mg1').feature('po').feature('sc1').set('relax', 0.5);
model.sol('sol1').feature('s2').feature('i1').feature('mg1').feature('po').feature('sc1').set('scgssolv', 'stored');
model.sol('sol1').feature('s2').feature('i1').feature('mg1').feature('po').feature('sc1').set('approxscgs', true);
model.sol('sol1').feature('s2').feature('i1').feature('mg1').feature('po').feature('sc1').set('scgsdirectmaxsize', 1000);
model.sol('sol1').feature('s2').feature('i1').feature('mg1').feature('cs').create('d1', 'Direct');
model.sol('sol1').feature('s2').feature('i1').feature('mg1').feature('cs').feature('d1').set('linsolver', 'pardiso');
model.sol('sol1').feature('s2').feature('i1').feature('mg1').feature('cs').feature('d1').set('pivotperturb', 1.0E-13);
model.sol('sol1').feature('s2').feature('fc1').set('linsolver', 'd1');
model.sol('sol1').feature('s2').feature('fc1').set('dtech', 'auto');
model.sol('sol1').feature('s2').feature('fc1').set('initstep', 0.01);
model.sol('sol1').feature('s2').feature('fc1').set('minstep', 1.0E-4);
model.sol('sol1').feature('s2').feature('fc1').set('maxiter', 100);
model.sol('sol1').feature('s2').feature.remove('fcDef');
model.sol('sol1').feature('v2').set('notsolnum', 'auto');
model.sol('sol1').feature('v2').set('notsolvertype', 'solnum');
model.sol('sol1').feature('v2').set('solnum', 'auto');
model.sol('sol1').feature('v2').set('solvertype', 'solnum');
model.sol('sol1').attach('std1');
model.sol('sol1').runAll;

model.result.create('pg1', 'PlotGroup2D');
model.result('pg1').label('Acoustic Pressure (atb1)');
model.result('pg1').set('frametype', 'spatial');
model.result('pg1').set('showlegendsunit', true);
model.result('pg1').set('data', 'dset1');
model.result('pg1').set('defaultPlotID', 'acousticPressure');
model.result('pg1').feature.create('surf1', 'Surface');
model.result('pg1').feature('surf1').set('expr', 'atb1.p_t');
model.result('pg1').feature('surf1').set('smooth', 'internal');
model.result('pg1').feature('surf1').set('showsolutionparams', 'on');
model.result('pg1').feature('surf1').set('data', 'parent');
model.result('pg1').label('Acoustic Pressure (atb1)');
model.result('pg1').run;
model.result('pg1').run;
model.result.create('pg2', 'PlotGroup2D');
model.result('pg2').run;
model.result('pg2').label('Acoustic Body Force');
model.result('pg2').selection.geom('geom1', 2);
model.result('pg2').selection.geom('geom1', 2);
model.result('pg2').selection.set([2]);
model.result('pg2').set('edges', false);
model.result('pg2').set('showlegendsunit', true);
model.result('pg2').create('surf1', 'Surface');
model.result('pg2').feature('surf1').set('expr', 'sqrt(spf.F_acox^2+spf.F_acoy^2)');
model.result('pg2').run;
model.result.create('pg3', 'PlotGroup2D');
model.result('pg3').label('Velocity (spf)');
model.result('pg3').set('frametype', 'spatial');
model.result('pg3').set('data', 'dset1');
model.result('pg3').set('defaultPlotID', 'ResultDefaults_SinglePhaseFlow/icom1/pdef1/pcond1/pg1');
model.result('pg3').feature.create('surf1', 'Surface');
model.result('pg3').feature('surf1').label('Surface');
model.result('pg3').feature('surf1').set('expr', 'spf.U');
model.result('pg3').feature('surf1').set('colortable', 'Rainbow');
model.result('pg3').feature('surf1').set('colorscalemode', 'linear');
model.result('pg3').feature('surf1').set('smooth', 'internal');
model.result('pg3').feature('surf1').set('showsolutionparams', 'on');
model.result('pg3').feature('surf1').set('data', 'parent');
model.result('pg3').label('Velocity (spf)');
model.result('pg3').run;
model.result('pg3').set('showlegendsunit', true);
model.result('pg3').run;
model.result('pg3').feature('surf1').set('unit', 'mm/s');
model.result('pg3').run;
model.result('pg3').create('str1', 'Streamline');
model.result('pg3').feature('str1').set('expr', {'u2' 'v2'});
model.result('pg3').feature('str1').set('posmethod', 'uniform');
model.result('pg3').feature('str1').set('udist', 0.02);
model.result('pg3').feature('str1').set('pointtype', 'arrow');
model.result('pg3').feature('str1').set('udist', 0.01);
model.result('pg3').run;
model.result('pg3').run;
model.result.duplicate('pg4', 'pg3');
model.result('pg4').run;
model.result('pg4').label('Velocity (spf) - Logarithmic');
model.result('pg4').set('showlegendsmaxmin', true);
model.result('pg4').run;
model.result('pg4').feature('surf1').set('colorscalemode', 'logarithmic');
model.result('pg4').feature('surf1').set('rangecoloractive', true);
model.result('pg4').feature('surf1').set('rangecolormin', '1e-2');
model.result('pg4').run;
model.result('pg4').run;

model.title('Acoustic Microfluidic Pump');

model.description(['This tutorial uses a 2D model of an acoustically driven microfluidic pump. The acoustic microfluidic pump is driven by acoustic streaming originating from sharp edges in the microfluidic channel. It drives a flow around a closed microfluidic channel loop.' newline  newline 'The acoustic field is modeled with Pressure Acoustic, Frequency Domain and Thermoviscous Acoustics, Frequency Domain coupled by the Acoustic' native2unicode(hex2dec({'20' '13'}), 'unicode') 'Thermoviscous Acoustic Boundary multiphysics coupling. The Acoustic Streaming, Domain Coupling multiphysics feature is used to compute the forces generated by the acoustic field and apply them to the Laminar Flow interface.']);

model.mesh.clearMeshes;

model.sol('sol1').clearSolutionData;
model.sol('sol2').clearSolutionData;

model.label('acoustic_microfluidic_pump.mph');

model.modelNode.label('Components');

out = model;
