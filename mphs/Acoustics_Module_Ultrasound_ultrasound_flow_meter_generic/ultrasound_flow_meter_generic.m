function out = model
%
% ultrasound_flow_meter_generic.m
%
% Model exported on May 26 2025, 21:25 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/Acoustics_Module/Ultrasound');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 3);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.physics.create('spf', 'TurbulentFlowkomega', 'geom1');
model.physics('spf').model('comp1');

model.study.create('std1');
model.study('std1').create('stat', 'Stationary');
model.study('std1').feature('stat').setSolveFor('/physics/spf', true);

% To import content from file, use:
% model.param.loadFile('FILENAME');
model.param.set('Uin', '10[m/s]', 'Background mean flow average velocity at the inlet');
model.param.set('p0', '1[atm]', 'Background mean flow pressure');
model.param.set('rho0', '998[kg/m^3]', 'Background mean flow density');
model.param.set('c0', '1481[m/s]', 'Speed of sound');
model.param.set('f0', '2.5e6[Hz]', 'Carrier signal frequency');
model.param.set('omega0', '2*pi*f0', 'Carrier signal angular frequency');
model.param.set('T0', '1/f0', 'Carrier signal period');
model.param.set('lam0', 'c0/f0', 'Carrier signal wavelength');
model.param.set('D', '5[mm]', 'Main duct diameter');
model.param.set('L', '4*D', 'Main duct length');
model.param.set('alpha', '45[deg]', 'Transducer tube pitch angle');
model.param.set('D_transducer', '2[mm]', 'Transducer diameter');
model.param.set('L_transducer', 'D/cos(alpha)+3/2*D_transducer/cos(alpha)*tan(alpha)', 'Transducer duct length');
model.param.set('L2', 'D/sin(alpha)', 'Transducer duct length in main flow');
model.param.set('L1', '0.5*(L_transducer-L2)', 'Transducer duct length of side branches');
model.param.set('nLx', 'cos(alpha)', 'Unit vector in transducer duct direction (x-component)');
model.param.set('nLy', '0', 'Unit vector in transducer duct direction (y-component)');
model.param.set('nLz', 'sin(alpha)', 'Unit vector in transducer duct direction (z-component)');
model.param.set('A', '0.1[mm/s]', 'Velocity signal amplitude');
model.param.set('Nlam', 'L_transducer/lam0', 'Number of wavelengths across transducer duct');
model.param.set('DT_calc', '5.01E-8[s]', 'Calculated time difference (known flow)');
model.param.set('DT_simulated', '4.86E-8[s]', 'Simulated time difference (from 1D graph)');

model.geom('geom1').create('cyl1', 'Cylinder');
model.geom('geom1').feature('cyl1').set('r', 'D/2');
model.geom('geom1').feature('cyl1').set('h', 'L');
model.geom('geom1').feature('cyl1').set('axistype', 'x');
model.geom('geom1').feature('cyl1').setIndex('layername', 'Layer 1', 0);
model.geom('geom1').feature('cyl1').setIndex('layer', '0.5*D', 0);
model.geom('geom1').feature('cyl1').set('layerside', false);
model.geom('geom1').feature('cyl1').set('layerbottom', true);
model.geom('geom1').feature('cyl1').set('layertop', true);
model.geom('geom1').run('cyl1');
model.geom('geom1').create('cyl2', 'Cylinder');
model.geom('geom1').feature('cyl2').set('r', 'D_transducer/2');
model.geom('geom1').feature('cyl2').set('h', 'L_transducer');
model.geom('geom1').feature('cyl2').set('pos', {'L/2' '0' '-L_transducer/2'});
model.geom('geom1').run('cyl2');
model.geom('geom1').create('rot1', 'Rotate');
model.geom('geom1').feature('rot1').selection('input').set({'cyl2'});
model.geom('geom1').feature('rot1').set('rot', 'alpha');
model.geom('geom1').feature('rot1').set('pos', {'L/2' '0' '0'});
model.geom('geom1').feature('rot1').set('axistype', 'y');
model.geom('geom1').runPre('fin');
model.geom('geom1').create('uni1', 'Union');
model.geom('geom1').feature('uni1').selection('input').set({'cyl1' 'rot1'});
model.geom('geom1').runPre('fin');
model.geom('geom1').create('wp1', 'WorkPlane');
model.geom('geom1').feature('wp1').set('unite', true);
model.geom('geom1').feature('wp1').set('quickplane', 'zx');
model.geom('geom1').run('wp1');
model.geom('geom1').create('par1', 'Partition');
model.geom('geom1').feature('par1').selection('input').set({'uni1'});
model.geom('geom1').feature('par1').set('partitionwith', 'workplane');
model.geom('geom1').runPre('fin');
model.geom('geom1').create('del1', 'Delete');

model.view('view1').set('renderwireframe', true);

model.geom('geom1').feature('del1').selection('input').init(3);
model.geom('geom1').feature('del1').selection('input').set('par1', [1 3 5 7 9 11]);
model.geom('geom1').runPre('fin');
model.geom('geom1').run('fin');
model.geom('geom1').create('cmd1', 'CompositeDomains');
model.geom('geom1').feature('cmd1').selection('input').set('fin', [2 3 4 5]);
model.geom('geom1').run('cmd1');

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

model.selection.create('sel1', 'Explicit');
model.selection('sel1').model('comp1');
model.selection('sel1').geom(2);
model.selection('sel1').set([2 6 16]);
model.selection('sel1').label('Symmetry');
model.selection.create('sel2', 'Explicit');
model.selection('sel2').model('comp1');
model.selection('sel2').label('Flow Inlet');
model.selection('sel2').geom(2);
model.selection('sel2').set([1]);
model.selection.create('sel3', 'Explicit');
model.selection('sel3').model('comp1');
model.selection('sel3').label('Flow Outlet');
model.selection('sel3').geom(2);
model.selection('sel3').set([19]);
model.selection.create('sel4', 'Explicit');
model.selection('sel4').model('comp1');
model.selection('sel4').label('Source');
model.selection('sel4').geom(2);
model.selection('sel4').set([10]);
model.selection.create('sel5', 'Explicit');
model.selection('sel5').model('comp1');
model.selection('sel5').label('Receiver');
model.selection('sel5').geom(2);
model.selection('sel5').set([14]);
model.selection.create('sel6', 'Explicit');
model.selection('sel6').model('comp1');
model.selection('sel6').label('Walls');
model.selection('sel6').geom(2);
model.selection('sel6').set([3 4 7 8 9 11 12 13 17 18]);

model.physics('spf').create('inl1', 'InletBoundary', 2);
model.physics('spf').feature('inl1').selection.named('sel2');
model.physics('spf').feature('inl1').set('BoundaryCondition', 'FullyDevelopedFlow');
model.physics('spf').feature('inl1').set('Uavfdf', 'Uin');
model.physics('spf').create('out1', 'OutletBoundary', 2);
model.physics('spf').feature('out1').selection.named('sel3');
model.physics('spf').create('sym1', 'Symmetry', 2);
model.physics('spf').feature('sym1').selection.named('sel1');

model.mesh('mesh1').label('Mesh - CFD');
model.mesh('mesh1').automatic(false);
model.mesh('mesh1').feature('ftet1').selection.geom('geom1', 3);
model.mesh('mesh1').feature('ftet1').selection.set([2]);
model.mesh('mesh1').create('swe1', 'Sweep');
model.mesh('mesh1').feature.move('swe1', 4);
model.mesh('mesh1').feature('swe1').create('dis1', 'Distribution');
model.mesh('mesh1').feature('swe1').feature('dis1').set('numelem', 12);
model.mesh('mesh1').run;
model.mesh('mesh1').run;

model.study('std1').label('Study 1 - CFD');
model.study('std1').setGenPlots(false);

model.sol.create('sol1');

model.mesh('mesh1').stat.selection.geom(3);
model.mesh('mesh1').stat.selection.set([1 2 3]);
model.mesh('mesh1').stat.selection.geom(3);
model.mesh('mesh1').stat.selection.set([1 2 3]);

model.sol('sol1').study('std1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'stat');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').set('control', 'stat');
model.sol('sol1').create('s1', 'Stationary');
model.sol('sol1').feature('s1').feature('aDef').set('cachepattern', true);
model.sol('sol1').feature('s1').create('se1', 'Segregated');
model.sol('sol1').feature('s1').feature('se1').feature.remove('ssDef');
model.sol('sol1').feature('s1').feature('se1').create('ss1', 'SegregatedStep');
model.sol('sol1').feature('s1').feature('se1').feature('ss1').set('segvar', {'comp1_p' 'comp1_u' 'comp1_spf_inl1_Pinlfdf'});
model.sol('sol1').feature('s1').feature('se1').feature('ss1').set('subdamp', 0.5);
model.sol('sol1').feature('s1').create('i1', 'Iterative');
model.sol('sol1').feature('s1').feature('i1').set('linsolver', 'gmres');
model.sol('sol1').feature('s1').feature('i1').set('prefuntype', 'left');
model.sol('sol1').feature('s1').feature('i1').set('itrestart', 50);
model.sol('sol1').feature('s1').feature('i1').set('rhob', 20);
model.sol('sol1').feature('s1').feature('i1').set('maxlinit', 1000);
model.sol('sol1').feature('s1').feature('i1').set('nlinnormuse', 'on');
model.sol('sol1').feature('s1').feature('i1').label('AMG, fluid flow variables (spf)');
model.sol('sol1').feature('s1').feature('i1').create('mg1', 'Multigrid');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').set('prefun', 'saamg');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').set('mgcycle', 'v');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').set('maxcoarsedof', 80000);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').set('strconn', 0.02);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').set('nullspace', 'constant');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').set('usesmooth', false);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').set('saamgcompwise', true);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').set('loweramg', true);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').set('compactaggregation', false);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('pr').create('sc1', 'SCGS');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('pr').feature('sc1').set('linesweeptype', 'ssor');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('pr').feature('sc1').set('iter', 0);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('pr').feature('sc1').set('scgsrelax', 0.7);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('pr').feature('sc1').set('scgsmethod', 'lines');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('pr').feature('sc1').set('scgsvertexrelax', 0.7);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('pr').feature('sc1').set('relax', 0.5);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('pr').feature('sc1').set('vankavarsactive', 'on');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('pr').feature('sc1').set('vankavars', {'comp1_spf_inl1_Pinlfdf'});
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('pr').feature('sc1').set('scgssolv', 'stored');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('pr').feature('sc1').set('approxscgs', true);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('pr').feature('sc1').set('scgsdirectmaxsize', 1000);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('po').create('sc1', 'SCGS');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('po').feature('sc1').set('linesweeptype', 'ssor');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('po').feature('sc1').set('iter', 1);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('po').feature('sc1').set('scgsrelax', 0.7);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('po').feature('sc1').set('scgsmethod', 'lines');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('po').feature('sc1').set('scgsvertexrelax', 0.7);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('po').feature('sc1').set('relax', 0.5);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('po').feature('sc1').set('vankavarsactive', 'on');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('po').feature('sc1').set('vankavars', {'comp1_spf_inl1_Pinlfdf'});
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('po').feature('sc1').set('scgssolv', 'stored');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('po').feature('sc1').set('approxscgs', true);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('po').feature('sc1').set('scgsdirectmaxsize', 1000);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('cs').create('d1', 'Direct');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('cs').feature('d1').set('linsolver', 'pardiso');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('cs').feature('d1').set('pivotperturb', 1.0E-13);
model.sol('sol1').feature('s1').feature('se1').feature('ss1').set('linsolver', 'i1');
model.sol('sol1').feature('s1').feature('se1').feature('ss1').label('Velocity u, Pressure p');
model.sol('sol1').feature('s1').feature('se1').create('ss2', 'SegregatedStep');
model.sol('sol1').feature('s1').feature('se1').feature('ss2').set('segvar', {'comp1_k' 'comp1_om'});
model.sol('sol1').feature('s1').feature('se1').feature('ss2').set('subdamp', 0.45);
model.sol('sol1').feature('s1').feature('se1').feature('ss2').set('subiter', 3);
model.sol('sol1').feature('s1').feature('se1').feature('ss2').set('subtermconst', 'itertol');
model.sol('sol1').feature('s1').feature('se1').feature('ss2').set('subntolfact', 1);
model.sol('sol1').feature('s1').create('i2', 'Iterative');
model.sol('sol1').feature('s1').feature('i2').set('linsolver', 'gmres');
model.sol('sol1').feature('s1').feature('i2').set('prefuntype', 'left');
model.sol('sol1').feature('s1').feature('i2').set('itrestart', 50);
model.sol('sol1').feature('s1').feature('i2').set('rhob', 20);
model.sol('sol1').feature('s1').feature('i2').set('maxlinit', 1000);
model.sol('sol1').feature('s1').feature('i2').set('nlinnormuse', 'on');
model.sol('sol1').feature('s1').feature('i2').label('AMG, turbulence variables (spf)');
model.sol('sol1').feature('s1').feature('i2').create('mg1', 'Multigrid');
model.sol('sol1').feature('s1').feature('i2').feature('mg1').set('prefun', 'saamg');
model.sol('sol1').feature('s1').feature('i2').feature('mg1').set('mgcycle', 'v');
model.sol('sol1').feature('s1').feature('i2').feature('mg1').set('maxcoarsedof', 50000);
model.sol('sol1').feature('s1').feature('i2').feature('mg1').set('strconn', 0.01);
model.sol('sol1').feature('s1').feature('i2').feature('mg1').set('nullspace', 'constant');
model.sol('sol1').feature('s1').feature('i2').feature('mg1').set('usesmooth', false);
model.sol('sol1').feature('s1').feature('i2').feature('mg1').set('saamgcompwise', true);
model.sol('sol1').feature('s1').feature('i2').feature('mg1').set('loweramg', true);
model.sol('sol1').feature('s1').feature('i2').feature('mg1').set('compactaggregation', false);
model.sol('sol1').feature('s1').feature('i2').feature('mg1').feature('pr').create('sl1', 'SORLine');
model.sol('sol1').feature('s1').feature('i2').feature('mg1').feature('pr').feature('sl1').set('linesweeptype', 'ssor');
model.sol('sol1').feature('s1').feature('i2').feature('mg1').feature('pr').feature('sl1').set('iter', 0);
model.sol('sol1').feature('s1').feature('i2').feature('mg1').feature('pr').feature('sl1').set('linerelax', 0.7);
model.sol('sol1').feature('s1').feature('i2').feature('mg1').feature('pr').feature('sl1').set('linealgorithm', 'mesh');
model.sol('sol1').feature('s1').feature('i2').feature('mg1').feature('pr').feature('sl1').set('linemethod', 'uncoupled');
model.sol('sol1').feature('s1').feature('i2').feature('mg1').feature('pr').feature('sl1').set('seconditer', 1);
model.sol('sol1').feature('s1').feature('i2').feature('mg1').feature('pr').feature('sl1').set('relax', 0.5);
model.sol('sol1').feature('s1').feature('i2').feature('mg1').feature('po').create('sl1', 'SORLine');
model.sol('sol1').feature('s1').feature('i2').feature('mg1').feature('po').feature('sl1').set('linesweeptype', 'ssor');
model.sol('sol1').feature('s1').feature('i2').feature('mg1').feature('po').feature('sl1').set('iter', 1);
model.sol('sol1').feature('s1').feature('i2').feature('mg1').feature('po').feature('sl1').set('linerelax', 0.7);
model.sol('sol1').feature('s1').feature('i2').feature('mg1').feature('po').feature('sl1').set('linealgorithm', 'mesh');
model.sol('sol1').feature('s1').feature('i2').feature('mg1').feature('po').feature('sl1').set('linemethod', 'uncoupled');
model.sol('sol1').feature('s1').feature('i2').feature('mg1').feature('po').feature('sl1').set('seconditer', 1);
model.sol('sol1').feature('s1').feature('i2').feature('mg1').feature('po').feature('sl1').set('relax', 0.5);
model.sol('sol1').feature('s1').feature('i2').feature('mg1').feature('cs').create('d1', 'Direct');
model.sol('sol1').feature('s1').feature('i2').feature('mg1').feature('cs').feature('d1').set('linsolver', 'pardiso');
model.sol('sol1').feature('s1').feature('i2').feature('mg1').feature('cs').feature('d1').set('pivotperturb', 1.0E-13);
model.sol('sol1').feature('s1').feature('se1').feature('ss2').set('linsolver', 'i2');
model.sol('sol1').feature('s1').feature('se1').feature('ss2').label('Turbulence Variables');
model.sol('sol1').feature('s1').feature('se1').set('segstabacc', 'segcflcmp');
model.sol('sol1').feature('s1').feature('se1').set('subinitcfl', 2);
model.sol('sol1').feature('s1').feature('se1').set('submincfl', 10000);
model.sol('sol1').feature('s1').feature('se1').set('subkppid', 0.65);
model.sol('sol1').feature('s1').feature('se1').set('subkdpid', 0.05);
model.sol('sol1').feature('s1').feature('se1').set('subkipid', 0.05);
model.sol('sol1').feature('s1').feature('se1').set('subcfltol', 0.1);
model.sol('sol1').feature('s1').feature('se1').set('segcflaa', true);
model.sol('sol1').feature('s1').feature('se1').set('segcflaacfl', 9000);
model.sol('sol1').feature('s1').feature('se1').set('segcflaafact', 1);
model.sol('sol1').feature('s1').feature('se1').set('maxsegiter', 400);
model.sol('sol1').feature('s1').feature('se1').create('ll1', 'LowerLimit');
model.sol('sol1').feature('s1').feature('se1').feature('ll1').set('lowerlimit', 'comp1.k 0 comp1.om 0 ');
model.sol('sol1').feature('s1').create('d1', 'Direct');
model.sol('sol1').feature('s1').feature('d1').set('linsolver', 'pardiso');
model.sol('sol1').feature('s1').feature('d1').set('pivotperturb', 1.0E-13);
model.sol('sol1').feature('s1').feature('d1').label('Direct, fluid flow variables (spf)');
model.sol('sol1').feature('s1').create('d2', 'Direct');
model.sol('sol1').feature('s1').feature('d2').set('linsolver', 'pardiso');
model.sol('sol1').feature('s1').feature('d2').set('pivotperturb', 1.0E-13);
model.sol('sol1').feature('s1').feature('d2').label('Direct, turbulence variables (spf)');
model.sol('sol1').feature('s1').feature.remove('fcDef');
model.sol('sol1').attach('std1');
model.sol('sol1').runAll;

model.physics.create('cwe', 'ConvectedWaveEquation', 'geom1');
model.physics('cwe').model('comp1');

model.study('std1').feature('stat').setSolveFor('/physics/cwe', false);

model.physics('cwe').create('sym1', 'Symmetry', 2);
model.physics('cwe').feature('sym1').selection.named('sel1');
model.physics('cwe').create('imp1', 'AcousticImpedance', 2);
model.physics('cwe').feature('imp1').selection.set([1 19]);

model.func.create('an1', 'Analytic');
model.func('an1').set('funcname', 'vn');
model.func('an1').set('expr', 'A*sin(omega0*t)*exp(-(f0*(t-3*T0))^2)');
model.func('an1').set('args', 't');
model.func('an1').setIndex('argunit', 's', 0);
model.func('an1').set('fununit', 'm/s');

model.physics('cwe').create('nvel1', 'NormalVelocity', 2);
model.physics('cwe').feature('nvel1').selection.named('sel4');
model.physics('cwe').feature('nvel1').set('nvel', 'vn(t)');

model.cpl.create('aveop1', 'Average', 'geom1');
model.cpl('aveop1').set('axisym', true);
model.cpl('aveop1').selection.geom('geom1', 2);
model.cpl('aveop1').selection.named('sel5');

model.coordSystem.create('ab1', 'geom1', 'AbsorbingLayer');
model.coordSystem('ab1').selection.set([1 3]);

model.modelNode('comp1').sorder('quadratic');

model.func.create('int1', 'Interpolation');
model.func('int1').set('source', 'file');
model.func('int1').set('filename', 'ultrasound_flow_meter_generic_upstream_signal.txt');
model.func('int1').setIndex('funcs', 'p_upstream', 0, 0);
model.func('int1').set('interp', 'piecewisecubic');
model.func('int1').setIndex('argunit', 's', 0);
model.func('int1').setIndex('fununit', 'Pa', 0);

model.mesh.create('mesh2', 'geom1');
model.mesh('mesh2').label('Mesh - Acoustics');
model.mesh('mesh2').create('ftet1', 'FreeTet');
model.mesh('mesh2').feature('size').set('custom', true);
model.mesh('mesh2').feature('size').set('hmax', 'lam0/1.5');
model.mesh('mesh2').feature('size').set('hmin', 'lam0/2');
model.mesh('mesh2').feature('ftet1').set('optsmall', true);
model.mesh('mesh2').feature('ftet1').set('optlevel', 'high');
model.mesh('mesh2').run;

model.multiphysics.create('bffc1', 'BackgroundFluidFlowCoupling', 'geom1', 3);
model.multiphysics('bffc1').selection.all;
model.multiphysics('bffc1').set('delta_diff', '1e-4');

model.study.create('std2');
model.study('std2').create('mapp', 'Mapping');
model.study('std2').feature('mapp').set('solnum', 'auto');
model.study('std2').feature('mapp').set('notsolnum', 'auto');
model.study('std2').feature('mapp').set('outputmap', {});
model.study('std2').feature('mapp').setSolveFor('/physics/spf', false);
model.study('std2').feature('mapp').setSolveFor('/physics/cwe', false);
model.study('std2').feature('mapp').setSolveFor('/multiphysics/bffc1', true);
model.study('std2').feature('mapp').setSolveFor('/physics/spf', false);
model.study('std2').feature('mapp').setSolveFor('/physics/cwe', false);
model.study('std2').label('Study 2 - Mapping');
model.study('std2').setGenPlots(false);
model.study('std2').feature('mapp').set('notstudy', 'std1');

model.sol.create('sol2');

model.mesh('mesh2').stat.selection.geom(3);
model.mesh('mesh2').stat.selection.set([2]);

model.sol('sol2').study('std2');
model.sol('sol2').create('st1', 'StudyStep');
model.sol('sol2').feature('st1').set('study', 'std2');
model.sol('sol2').feature('st1').set('studystep', 'mapp');
model.sol('sol2').create('v1', 'Variables');
model.sol('sol2').feature('v1').set('control', 'mapp');
model.sol('sol2').create('s1', 'Stationary');
model.sol('sol2').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol2').feature('s1').feature('fc1').set('linsolver', 'dDef');
model.sol('sol2').feature('s1').feature.remove('fcDef');
model.sol('sol2').attach('std2');
model.sol('sol2').runAll;

model.study.create('std3');
model.study('std3').create('time', 'Transient');
model.study('std3').feature('time').setSolveFor('/physics/spf', false);
model.study('std3').feature('time').setSolveFor('/physics/cwe', true);
model.study('std3').feature('time').setSolveFor('/multiphysics/bffc1', false);
model.study('std3').label('Study - Acoustics');
model.study('std3').setGenPlots(false);
model.study('std3').feature('time').set('tlist', 'range(0,T0/12,30*T0)');
model.study('std3').feature('time').set('usesol', true);
model.study('std3').feature('time').set('notsolmethod', 'sol');
model.study('std3').feature('time').set('notstudy', 'std2');
model.study('std3').feature('time').setEntry('outputmap', 'spf', 'selection');
model.study('std3').feature('time').setEntry('outputselectionmap', 'spf', 'sel1;sel4;sel5');
model.study('std3').feature('time').setEntry('outputmap', 'cwe', 'selection');
model.study('std3').feature('time').setEntry('outputselectionmap', 'cwe', 'sel1;sel4;sel5');

model.sol.create('sol3');

model.mesh('mesh2').stat.selection.geom(3);
model.mesh('mesh2').stat.selection.set([2]);

model.sol('sol3').study('std3');
model.sol('sol3').create('st1', 'StudyStep');
model.sol('sol3').feature('st1').set('study', 'std3');
model.sol('sol3').feature('st1').set('studystep', 'time');
model.sol('sol3').create('v1', 'Variables');
model.sol('sol3').feature('v1').set('control', 'time');
model.sol('sol3').create('t1', 'Time');
model.sol('sol3').feature('t1').set('odesolvertype', 'explicit');
model.sol('sol3').feature('t1').set('timemethodexp', 'erk');
model.sol('sol3').feature('t1').set('tlist', 'range(0,T0/12,30*T0)');
model.sol('sol3').feature('t1').set('plot', 'off');
model.sol('sol3').feature('t1').set('plotgroup', 'Default');
model.sol('sol3').feature('t1').set('plotfreq', 'tout');
model.sol('sol3').feature('t1').set('probesel', 'all');
model.sol('sol3').feature('t1').set('probes', {});
model.sol('sol3').feature('t1').set('probefreq', 'tsteps');
model.sol('sol3').feature('t1').set('exprs', {'root.comp1.cwe.wtc' 'root.comp1.cwe.wtc'});
model.sol('sol3').feature('t1').set('tstepping', 'elemexprs');
model.sol('sol3').feature('t1').set('control', 'time');
model.sol('sol3').feature('t1').create('fc1', 'FullyCoupled');
model.sol('sol3').feature('t1').feature('fc1').set('linsolver', 'dDef');
model.sol('sol3').feature('t1').feature.remove('fcDef');
model.sol('sol3').attach('std3');
model.sol('sol3').runAll;

model.result.dataset('dset3').selection.geom('geom1', 2);
model.result.dataset('dset3').selection.geom('geom1', 2);
model.result.dataset('dset3').selection.set([6 10 14]);
model.result.dataset.create('cln1', 'CutLine3D');
model.result.dataset('cln1').set('data', 'dset3');
model.result.dataset('cln1').set('method', 'pointdir');
model.result.dataset('cln1').set('pdpoint', {'L/2' '0' '0'});
model.result.dataset('cln1').set('pddir', {'nLx' 'nLy' 'nLz'});
model.result.dataset('cln1').set('snapping', 'boundary');
model.result.create('pg1', 'PlotGroup3D');
model.result('pg1').run;
model.result('pg1').label('Background Flow Velocity');
model.result('pg1').set('showlegendsunit', true);
model.result('pg1').create('surf1', 'Surface');
model.result('pg1').run;
model.result.create('pg2', 'PlotGroup1D');
model.result('pg2').run;
model.result('pg2').label('Background Flow Velocity Profile');
model.result('pg2').create('lngr1', 'LineGraph');
model.result('pg2').feature('lngr1').set('markerpos', 'datapoints');
model.result('pg2').feature('lngr1').set('linewidth', 'preference');
model.result('pg2').feature('lngr1').selection.set([7]);
model.result('pg2').feature('lngr1').set('xdata', 'expr');
model.result('pg2').feature('lngr1').set('xdataexpr', 'z');
model.result('pg2').feature('lngr1').set('legend', true);
model.result('pg2').feature('lngr1').set('legendmethod', 'manual');
model.result('pg2').feature('lngr1').setIndex('legends', 'Mean flow profile, CFD', 0);
model.result('pg2').feature.duplicate('lngr2', 'lngr1');
model.result('pg2').run;
model.result('pg2').feature('lngr2').set('data', 'dset2');
model.result('pg2').feature('lngr2').set('expr', 'bffc1.u_mapx');
model.result('pg2').feature('lngr2').set('descr', 'Mapped velocity, x-component');
model.result('pg2').feature('lngr2').setIndex('legends', 'Mean flow profile, Mapped', 0);
model.result('pg2').run;
model.result.create('pg3', 'PlotGroup3D');
model.result('pg3').run;
model.result('pg3').label('Acoustic Pressure');
model.result('pg3').set('data', 'dset3');
model.result('pg3').set('showlegendsunit', true);
model.result('pg3').create('surf1', 'Surface');
model.result('pg3').feature('surf1').set('expr', 'p2');
model.result('pg3').feature('surf1').set('colortable', 'Wave');
model.result('pg3').feature('surf1').set('colorscalemode', 'linearsymmetric');
model.result('pg3').feature('surf1').set('resolution', 'custom');
model.result('pg3').feature('surf1').set('refine', 6);
model.result('pg3').run;
model.result('pg3').feature('surf1').create('def1', 'Deform');
model.result('pg3').run;
model.result('pg3').feature('surf1').feature('def1').set('expr', {'0' 'p2' '0'});
model.result('pg3').run;
model.result('pg3').run;
model.result('pg3').setIndex('looplevel', 61, 0);
model.result('pg3').run;
model.result('pg3').setIndex('looplevel', 91, 0);
model.result('pg3').run;
model.result('pg3').setIndex('looplevel', 121, 0);
model.result('pg3').run;
model.result('pg3').setIndex('looplevel', 151, 0);
model.result('pg3').run;
model.result.create('pg4', 'PlotGroup3D');
model.result('pg4').run;
model.result('pg4').label('Acoustic Velocity');
model.result('pg4').set('data', 'dset3');
model.result('pg4').setIndex('looplevel', 241, 0);
model.result('pg4').set('showlegendsunit', true);
model.result('pg4').create('surf1', 'Surface');
model.result('pg4').feature('surf1').set('expr', 'cwe.v_inst');
model.result('pg4').feature('surf1').set('descr', 'Acoustic velocity amplitude');
model.result('pg4').feature('surf1').set('colorscalemode', 'linearsymmetric');
model.result('pg4').feature('surf1').set('resolution', 'custom');
model.result('pg4').feature('surf1').set('refine', 6);
model.result('pg4').run;
model.result.create('pg5', 'PlotGroup3D');
model.result('pg5').run;
model.result('pg5').label('Acoustic Intensity');
model.result('pg5').set('data', 'dset3');
model.result('pg5').setIndex('looplevel', 241, 0);
model.result('pg5').set('showlegendsunit', true);
model.result('pg5').create('surf1', 'Surface');
model.result('pg5').feature('surf1').set('expr', 'cwe.Ii_mag');
model.result('pg5').feature('surf1').set('descr', 'Instantaneous intensity magnitude');
model.result('pg5').feature('surf1').set('colortable', 'ThermalDark');
model.result('pg5').feature('surf1').set('resolution', 'custom');
model.result('pg5').feature('surf1').set('refine', 6);
model.result('pg5').run;
model.result('pg5').create('arws1', 'ArrowSurface');
model.result('pg5').feature('arws1').set('expr', {'cwe.Iix' 'cwe.Iiy' 'cwe.Iiz'});
model.result('pg5').feature('arws1').set('descr', 'Instantaneous intensity');
model.result('pg5').feature('arws1').set('arrowlength', 'logarithmic');
model.result('pg5').feature('arws1').set('logrange', 400);
model.result('pg5').feature('arws1').set('arrowcount', 1000);
model.result('pg5').feature('arws1').set('color', 'white');
model.result('pg5').run;
model.result.create('pg6', 'PlotGroup1D');
model.result('pg6').run;
model.result('pg6').label('Pressure Along Transducer Axis');
model.result('pg6').set('data', 'cln1');
model.result('pg6').setIndex('looplevelinput', 'manual', 0);
model.result('pg6').setIndex('looplevel', [121], 0);
model.result('pg6').create('lngr1', 'LineGraph');
model.result('pg6').feature('lngr1').set('markerpos', 'datapoints');
model.result('pg6').feature('lngr1').set('linewidth', 'preference');
model.result('pg6').feature('lngr1').set('expr', 'p2');
model.result('pg6').feature('lngr1').set('resolution', 'extrafine');
model.result('pg6').run;
model.result.create('pg7', 'PlotGroup1D');
model.result('pg7').run;
model.result('pg7').label('Pressure Signal at Receivers');
model.result('pg7').set('data', 'dset3');
model.result('pg7').create('glob1', 'Global');
model.result('pg7').feature('glob1').set('markerpos', 'datapoints');
model.result('pg7').feature('glob1').set('linewidth', 'preference');
model.result('pg7').feature('glob1').setIndex('expr', 'aveop1(p2)', 0);
model.result('pg7').feature('glob1').setIndex('unit', 'Pa', 0);
model.result('pg7').feature('glob1').setIndex('descr', 'Pressure moving downstream', 0);
model.result('pg7').feature('glob1').setIndex('expr', 'p_upstream(t)', 1);
model.result('pg7').feature('glob1').setIndex('unit', 'Pa', 1);
model.result('pg7').feature('glob1').setIndex('descr', 'Pressure moving upstream (imported)', 1);
model.result('pg7').run;
model.result.numerical.create('int1', 'IntLine');
model.result.numerical('int1').set('intsurface', true);
model.result.numerical('int1').set('data', 'cln1');
model.result.numerical('int1').setIndex('looplevelinput', 'first', 0);
model.result.numerical('int1').setIndex('expr', '1/(cwe.c0-(nLx*cwe.u0x+nLy*cwe.u0y+nLz*cwe.u0z))-1/(cwe.c0+(nLx*cwe.u0x+nLy*cwe.u0y+nLz*cwe.u0z))', 0);
model.result.numerical('int1').setIndex('unit', '', 0);
model.result.numerical('int1').setIndex('descr', '', 0);
model.result.table.create('tbl1', 'Table');
model.result.table('tbl1').comments('Line Integration 1');
model.result.numerical('int1').set('table', 'tbl1');
model.result.numerical('int1').setResult;
model.result.numerical.create('gev1', 'EvalGlobal');
model.result.numerical('gev1').set('data', 'dset3');
model.result.numerical('gev1').setIndex('looplevelinput', 'first', 0);
model.result.numerical('gev1').setIndex('expr', 'L2/(DT_calc*cos(alpha))*(-1+sqrt(1+DT_calc^2*c0^2/L2^2))', 0);
model.result.numerical('gev1').setIndex('unit', '', 0);
model.result.numerical('gev1').setIndex('descr', '', 0);
model.result.numerical('gev1').setIndex('expr', 'L2/(DT_simulated*cos(alpha))*(-1+sqrt(1+DT_simulated^2*c0^2/L2^2))', 1);
model.result.numerical('gev1').setIndex('unit', '', 1);
model.result.numerical('gev1').setIndex('descr', '', 1);
model.result.table.create('tbl2', 'Table');
model.result.table('tbl2').comments('Global Evaluation 1');
model.result.numerical('gev1').set('table', 'tbl2');
model.result.numerical('gev1').setResult;
model.result('pg7').run;
model.result('pg7').set('axislimits', true);
model.result('pg7').set('xmin', '0.7e-5');
model.result('pg7').set('xmax', '1.1e-5');
model.result('pg7').run;

model.study('std1').feature('stat').set('useadvanceddisable', true);
model.study('std1').feature('stat').set('disabledcoordinatesystems', {'ab1'});

model.result('pg3').run;
model.result('pg3').create('line1', 'Line');
model.result('pg3').feature('line1').set('data', 'dset1');
model.result('pg3').feature('line1').set('expr', '1');
model.result('pg3').feature('line1').set('coloring', 'uniform');
model.result('pg3').feature('line1').set('color', 'black');
model.result('pg3').feature('line1').set('titletype', 'none');
model.result('pg3').create('surf2', 'Surface');
model.result('pg3').feature('surf2').set('data', 'dset1');
model.result('pg3').feature('surf2').set('expr', 'spf.delta_w');
model.result('pg3').feature('surf2').set('coloring', 'uniform');
model.result('pg3').feature('surf2').set('color', 'white');
model.result('pg3').feature('surf2').set('titletype', 'none');
model.result('pg3').run;
model.result('pg3').run;

model.title('Ultrasound Flowmeter with Generic Time-of-Flight Configuration');

model.description(['Knowing the velocity of a moving fluid is important in all cases where the fluid is used to transport material or energy. In the time-of-flight or transit-time method for determining flow velocity, an ultrasonic signal is transmitted across the main flow in a pipe to noninvasively determine its velocity. By transmitting the signal at an angle relative to the main flow, the ultrasound signal will travel faster than the speed of sound if it moves in the direction of the main flow, and slower than the speed of sound if it moves against it. The difference in travel times in the two directions increases linearly with the velocity of the main flow. Flowmeters of this type find many uses, particularly in industrial settings.' newline  newline 'In this tutorial model, learn how to simulate a generic wetted transient-time ultrasound flowmeter with COMSOL Multiphysics' native2unicode(hex2dec({'00' 'ae'}), 'unicode') ' simulation software. The model setup solves the transient problem of a signal traversing the flow downstream. First, we use the CFD Module to calculate the steady-state background flow in the flowmeter. The signal moving upstream is precalculated and imported as data. The difference in arrival times is used to estimate the velocity of the main flow. Next, we use the Convected Wave Equation, Time Explicit physics interface, found under the Ultrasound node in the Acoustics Module. This interface is tailored for transient high-frequency situations and is based on the discontinuous Galerkin method (DG-FEM).']);

model.mesh.clearMeshes;

model.sol('sol1').clearSolutionData;
model.sol('sol2').clearSolutionData;
model.sol('sol3').clearSolutionData;

model.label('ultrasound_flow_meter_generic.mph');

model.modelNode.label('Components');

out = model;
