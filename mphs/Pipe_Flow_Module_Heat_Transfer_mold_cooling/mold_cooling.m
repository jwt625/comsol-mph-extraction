function out = model
%
% mold_cooling.m
%
% Model exported on May 26 2025, 21:31 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/Pipe_Flow_Module/Heat_Transfer');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 3);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.physics.create('nipfl', 'NonisothermalPipeFlow', 'geom1');
model.physics('nipfl').model('comp1');
model.physics.create('ht', 'HeatTransfer', 'geom1');
model.physics('ht').model('comp1');

model.study.create('std1');
model.study('std1').create('time', 'Transient');
model.study('std1').feature('time').setSolveFor('/physics/nipfl', true);
model.study('std1').feature('time').setSolveFor('/physics/ht', true);

model.param.set('T_init_mold', '473.15[K]');
model.param.descr('T_init_mold', 'Initial temperature, mold');
model.param.set('T_coolant', '288.15[K]');
model.param.descr('T_coolant', 'Steady-state inlet temperature, coolant');
model.param.set('Qw', '10[l/min]');
model.param.descr('Qw', 'Coolant flow rate');
model.param.set('e', '0.046[mm]');
model.param.descr('e', 'Surface roughness');

model.func.create('step1', 'Step');
model.func('step1').set('location', 2.5);
model.func('step1').set('from', 1);
model.func('step1').set('to', 0);
model.func('step1').set('smooth', 5);

model.variable.create('var1');
model.variable('var1').set('T_inlet', 'T_coolant+(T_init_mold-T_coolant)*step1(t[1/s])');
model.variable('var1').descr('T_inlet', 'Ramped inlet temperature, coolant');

model.geom('geom1').create('imp1', 'Import');
model.geom('geom1').feature('imp1').set('filename', 'mold_cooling_top.mphbin');
model.geom('geom1').feature('imp1').importData;
model.geom('geom1').selection.create('csel1', 'CumulativeSelection');
model.geom('geom1').selection('csel1').label('Wheel');
model.geom('geom1').feature('imp1').set('contributeto', 'csel1');
model.geom('geom1').insertFile('mold_cooling_geom_sequence.mph', 'geom1');
model.geom('geom1').run('fin');

model.view('view1').set('transparency', true);

model.geom('geom1').selection.create('csel2', 'CumulativeSelection');
model.geom('geom1').selection('csel2').label('Cooling channels');
model.geom('geom1').feature('wp1').set('contributeto', 'csel2');

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
model.material('mat1').selection.geom('geom1', 1);
model.material('mat1').selection.named('geom1_csel2_edg');
model.material.create('sw1', 'Switch', 'comp1');
model.material('sw1').selection.set([1]);
model.material('sw1').feature.create('mat1', 'Common');
model.material('sw1').feature('mat1').propertyGroup.create('Enu', 'Young''s modulus and Poisson''s ratio');
model.material('sw1').feature('mat1').propertyGroup.create('Murnaghan', 'Murnaghan');
model.material('sw1').feature('mat1').label('Aluminum');
model.material('sw1').feature('mat1').set('family', 'aluminum');
model.material('sw1').feature('mat1').propertyGroup('def').set('relpermeability', {'1' '0' '0' '0' '1' '0' '0' '0' '1'});
model.material('sw1').feature('mat1').propertyGroup('def').set('heatcapacity', '900[J/(kg*K)]');
model.material('sw1').feature('mat1').propertyGroup('def').set('thermalconductivity', {'238[W/(m*K)]' '0' '0' '0' '238[W/(m*K)]' '0' '0' '0' '238[W/(m*K)]'});
model.material('sw1').feature('mat1').propertyGroup('def').set('electricconductivity', {'3.774e7[S/m]' '0' '0' '0' '3.774e7[S/m]' '0' '0' '0' '3.774e7[S/m]'});
model.material('sw1').feature('mat1').propertyGroup('def').set('relpermittivity', {'1' '0' '0' '0' '1' '0' '0' '0' '1'});
model.material('sw1').feature('mat1').propertyGroup('def').set('thermalexpansioncoefficient', {'23e-6[1/K]' '0' '0' '0' '23e-6[1/K]' '0' '0' '0' '23e-6[1/K]'});
model.material('sw1').feature('mat1').propertyGroup('def').set('density', '2700[kg/m^3]');
model.material('sw1').feature('mat1').propertyGroup('Enu').set('E', '70[GPa]');
model.material('sw1').feature('mat1').propertyGroup('Enu').set('nu', '0.33');
model.material('sw1').feature('mat1').propertyGroup('Murnaghan').set('l', '-250[GPa]');
model.material('sw1').feature('mat1').propertyGroup('Murnaghan').set('m', '-330[GPa]');
model.material('sw1').feature('mat1').propertyGroup('Murnaghan').set('n', '-350[GPa]');
model.material('sw1').feature.create('mat2', 'Common');
model.material('sw1').feature('mat2').propertyGroup.create('Enu', 'Young''s modulus and Poisson''s ratio');
model.material('sw1').feature('mat2').label('Steel AISI 4340');
model.material('sw1').feature('mat2').set('family', 'steel');
model.material('sw1').feature('mat2').propertyGroup('def').set('relpermeability', {'1' '0' '0' '0' '1' '0' '0' '0' '1'});
model.material('sw1').feature('mat2').propertyGroup('def').set('electricconductivity', {'4.032e6[S/m]' '0' '0' '0' '4.032e6[S/m]' '0' '0' '0' '4.032e6[S/m]'});
model.material('sw1').feature('mat2').propertyGroup('def').set('thermalexpansioncoefficient', {'12.3e-6[1/K]' '0' '0' '0' '12.3e-6[1/K]' '0' '0' '0' '12.3e-6[1/K]'});
model.material('sw1').feature('mat2').propertyGroup('def').set('heatcapacity', '475[J/(kg*K)]');
model.material('sw1').feature('mat2').propertyGroup('def').set('relpermittivity', {'1' '0' '0' '0' '1' '0' '0' '0' '1'});
model.material('sw1').feature('mat2').propertyGroup('def').set('density', '7850[kg/m^3]');
model.material('sw1').feature('mat2').propertyGroup('def').set('thermalconductivity', {'44.5[W/(m*K)]' '0' '0' '0' '44.5[W/(m*K)]' '0' '0' '0' '44.5[W/(m*K)]'});
model.material('sw1').feature('mat2').propertyGroup('Enu').set('E', '205[GPa]');
model.material('sw1').feature('mat2').propertyGroup('Enu').set('nu', '0.28');
model.material.create('mat2', 'Common', 'comp1');
model.material('mat2').label('Polyurethane');
model.material('mat2').selection.named('geom1_csel1_dom');
model.material('mat2').propertyGroup('def').set('thermalconductivity', {'0.32'});
model.material('mat2').propertyGroup('def').set('density', {'1250'});
model.material('mat2').propertyGroup('def').set('heatcapacity', {'1540'});

model.physics('nipfl').selection.named('geom1_csel2_edg');
model.physics('nipfl').feature('pipe1').set('shape', 'Round');
model.physics('nipfl').feature('pipe1').set('innerd', '1[cm]');
model.physics('nipfl').feature('pipe1').set('roughness', 13);
model.physics('nipfl').feature('pipe1').set('e', 'e');
model.physics('nipfl').feature('init1').set('u', 0.1);
model.physics('nipfl').feature('init1').set('T', 'T_init_mold');
model.physics('nipfl').feature('temp1').set('Tin', 'T_inlet');
model.physics('nipfl').create('inl1', 'Inlet', 0);
model.physics('nipfl').feature('inl1').selection.set([3 4]);
model.physics('nipfl').feature('inl1').set('spec', 1);
model.physics('nipfl').feature('inl1').set('qv0', 'Qw');
model.physics('nipfl').create('hofl1', 'HeatOutflow', 0);
model.physics('nipfl').feature('hofl1').selection.set([269 270]);
model.physics('nipfl').create('wht1', 'WallHeatTransfer', 1);
model.physics('nipfl').feature('wht1').selection.named('geom1_csel2_edg');
model.physics('nipfl').feature('wht1').create('intfilm1', 'InternalFilmResistance', 1);
model.physics('ht').feature('init1').set('Tinit', 'T_init_mold');
model.physics('ht').create('hf1', 'HeatFluxBoundary', 2);
model.physics('ht').feature('hf1').selection.all;
model.physics('ht').feature('hf1').set('HeatFluxType', 'ConvectiveHeatFlux');
model.physics('ht').feature('hf1').set('h', 2);

model.multiphysics.create('pwhtc1', 'PipeWallHeatTransfer', 'geom1', 1);

model.mesh('mesh1').create('edg1', 'Edge');
model.mesh('mesh1').feature('edg1').selection.named('geom1_csel2_edg');
model.mesh('mesh1').feature('edg1').create('size1', 'Size');
model.mesh('mesh1').feature('edg1').feature('size1').set('hauto', 2);
model.mesh('mesh1').create('ftet1', 'FreeTet');
model.mesh('mesh1').feature('size').set('custom', true);
model.mesh('mesh1').feature('size').set('hmin', 0.003);
model.mesh('mesh1').feature('size').set('hcurve', 0.55);
model.mesh('mesh1').run;

model.study('std1').feature('time').set('tlist', 'range(0,2,28) range(30,30,600)');

model.probe.create('dom1', 'Domain');
model.probe('dom1').model('comp1');
model.probe('dom1').set('intsurface', true);
model.probe('dom1').set('intvolume', true);
model.probe('dom1').selection.named('geom1_csel1_dom');
model.probe('dom1').set('expr', 'T2');
model.probe('dom1').set('descr', 'Temperature');
model.probe('dom1').set('descractive', true);
model.probe('dom1').set('descr', 'Average wheel temperature');

model.study('std1').setGenPlots(false);
model.study('std1').create('param', 'Parametric');
model.study('std1').feature('param').set('sweeptype', 'filled');
model.study('std1').feature('param').setIndex('pname', 'T_init_mold', 0);
model.study('std1').feature('param').setIndex('plistarr', '', 0);
model.study('std1').feature('param').setIndex('punit', 'K', 0);
model.study('std1').feature('param').setIndex('pname', 'T_init_mold', 0);
model.study('std1').feature('param').setIndex('plistarr', '', 0);
model.study('std1').feature('param').setIndex('punit', 'K', 0);
model.study('std1').feature('param').setIndex('pname', 'T_coolant', 1);
model.study('std1').feature('param').setIndex('plistarr', '', 1);
model.study('std1').feature('param').setIndex('punit', 'K', 1);
model.study('std1').feature('param').setIndex('pname', 'T_coolant', 1);
model.study('std1').feature('param').setIndex('plistarr', '', 1);
model.study('std1').feature('param').setIndex('punit', 'K', 1);
model.study('std1').feature('param').setIndex('pname', 'Qw', 0);
model.study('std1').feature('param').setIndex('plistarr', '20 10', 0);
model.study('std1').feature('param').setIndex('punit', 'l/min', 0);
model.study('std1').feature('param').setIndex('pname', 'e', 1);
model.study('std1').feature('param').setIndex('plistarr', '0.46 0.046', 1);
model.study('std1').feature('param').setIndex('punit', 'mm', 1);
model.study('std1').feature('param').set('useaccumtable', true);
model.study('std1').feature('param').set('keepsol', 'last');
model.study('std1').create('matsw', 'MaterialSweep');
model.study('std1').feature('matsw').setIndex('pname', 'matsw.comp1.sw1', 0);
model.study('std1').feature('matsw').setIndex('pcase', 'all', 0);
model.study('std1').feature('matsw').setIndex('plistarr', 'range(1,1,2)', 0);
model.study('std1').feature('matsw').setIndex('pname', 'matsw.comp1.sw1', 0);
model.study('std1').feature('matsw').setIndex('pcase', 'all', 0);
model.study('std1').feature('matsw').setIndex('plistarr', 'range(1,1,2)', 0);

model.sol.create('sol1');
model.sol('sol1').study('std1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'time');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').set('control', 'time');
model.sol('sol1').create('t1', 'Time');
model.sol('sol1').feature('t1').set('tlist', 'range(0,2,28) range(30,30,600)');
model.sol('sol1').feature('t1').set('plot', 'off');
model.sol('sol1').feature('t1').set('plotgroup', 'Default');
model.sol('sol1').feature('t1').set('plotfreq', 'tout');
model.sol('sol1').feature('t1').set('probesel', 'all');
model.sol('sol1').feature('t1').set('probes', {'dom1'});
model.sol('sol1').feature('t1').set('probefreq', 'tsteps');
model.sol('sol1').feature('t1').set('atolglobalvaluemethod', 'factor');
model.sol('sol1').feature('t1').set('atolmethod', {'comp1_nipfl_wht1_intfilm1_Tout' 'global' 'comp1_p' 'global' 'comp1_T' 'global' 'comp1_T2' 'global' 'comp1_u' 'global'});
model.sol('sol1').feature('t1').set('atol', {'comp1_nipfl_wht1_intfilm1_Tout' '1e-3' 'comp1_p' '1e-3' 'comp1_T' '1e-3' 'comp1_T2' '1e-3' 'comp1_u' '1e-3'});
model.sol('sol1').feature('t1').set('atolvaluemethod', {'comp1_nipfl_wht1_intfilm1_Tout' 'factor' 'comp1_p' 'factor' 'comp1_T' 'factor' 'comp1_T2' 'factor' 'comp1_u' 'factor'});
model.sol('sol1').feature('t1').set('reacf', true);
model.sol('sol1').feature('t1').set('storeudot', true);
model.sol('sol1').feature('t1').set('endtimeinterpolation', true);
model.sol('sol1').feature('t1').set('estrat', 'exclude');
model.sol('sol1').feature('t1').set('maxorder', 2);
model.sol('sol1').feature('t1').set('control', 'time');
model.sol('sol1').feature('t1').create('seDef', 'Segregated');
model.sol('sol1').feature('t1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('t1').feature('fc1').set('stabacc', 'aacc');
model.sol('sol1').feature('t1').feature('fc1').set('aaccdim', 5);
model.sol('sol1').feature('t1').feature('fc1').set('aaccdelay', 0);
model.sol('sol1').feature('t1').feature('fc1').set('aaccmix', 0.9);
model.sol('sol1').feature('t1').feature('fc1').set('damp', 0.9);
model.sol('sol1').feature('t1').feature('fc1').set('jtech', 'once');
model.sol('sol1').feature('t1').feature('fc1').set('linsolver', 'dDef');
model.sol('sol1').feature('t1').feature('fc1').set('stabacc', 'aacc');
model.sol('sol1').feature('t1').feature('fc1').set('aaccdim', 5);
model.sol('sol1').feature('t1').feature('fc1').set('aaccdelay', 0);
model.sol('sol1').feature('t1').feature('fc1').set('aaccmix', 0.9);
model.sol('sol1').feature('t1').feature('fc1').set('damp', 0.9);
model.sol('sol1').feature('t1').feature('fc1').set('jtech', 'once');
model.sol('sol1').feature('t1').feature.remove('fcDef');
model.sol('sol1').feature('t1').feature.remove('seDef');
model.sol('sol1').attach('std1');

model.batch.create('p1', 'Parametric');
model.batch('p1').study('std1');

model.result.table.create('tbl1', 'Table');
model.result.table('tbl1').label('Accumulated Probe Table 1');

model.study('std1').feature('param').set('accumtable', 'tbl1');

model.batch('p1').create('so1', 'Solutionseq');
model.batch('p1').feature('so1').set('seq', 'sol1');
model.batch('p1').feature('so1').set('store', 'on');
model.batch('p1').feature('so1').set('clear', 'on');
model.batch('p1').feature('so1').set('psol', 'none');
model.batch('p1').set('pname', {'Qw' 'e'});
model.batch('p1').set('plistarr', {'20 10' '0.46 0.046'});
model.batch('p1').set('sweeptype', 'filled');
model.batch('p1').set('probesel', 'all');
model.batch('p1').set('probes', {'dom1'});
model.batch('p1').set('plot', 'off');
model.batch('p1').set('err', 'on');
model.batch('p1').attach('std1');
model.batch('p1').set('control', 'param');
model.batch.create('pm1', 'MaterialSweep');
model.batch('pm1').study('std1');
model.batch('pm1').create('jo1', 'Jobseq');
model.batch('pm1').feature('jo1').set('seq', 'p1');
model.batch('pm1').set('pname', {'matsw.comp1.sw1'});
model.batch('pm1').set('plistarr', {'range(1,1,2)'});
model.batch('pm1').set('sweeptype', 'filled');
model.batch('pm1').set('err', 'on');
model.batch('pm1').attach('std1');
model.batch('pm1').set('control', 'matsw');

model.sol('sol1').feature('t1').feature('fc1').set('damp', '1');
model.sol('sol1').feature('t1').feature('fc1').set('jtech', 'minimal');
model.sol.create('sol2');
model.sol('sol2').study('std1');
model.sol('sol2').label('Parametric Solutions 1');

model.batch('p1').feature('so1').set('psol', 'sol2');

model.probe('dom1').genResult('none');

model.batch('pm1').run('compute');

model.result.create('pg2', 'PlotGroup3D');
model.result('pg2').label('Temperature (ht)');
model.result('pg2').set('data', 'dset1');
model.result('pg2').setIndex('looplevel', 35, 0);
model.result('pg2').set('defaultPlotID', 'ht/HT_PhysicsInterfaces/icom8/pdef1/pcond3/pcond3/pg1');
model.result('pg2').feature.create('vol1', 'Volume');
model.result('pg2').feature('vol1').set('solutionparams', 'parent');
model.result('pg2').feature('vol1').set('expr', 'T2');
model.result('pg2').feature('vol1').set('colortable', 'HeatCameraLight');
model.result('pg2').feature('vol1').set('smooth', 'internal');
model.result('pg2').feature('vol1').set('showsolutionparams', 'on');
model.result('pg2').feature('vol1').set('data', 'parent');
model.result('pg2').label('Temperature (ht)');
model.result('pg2').run;
model.result('pg2').label('Wheel and Cooling Channels Temperature');
model.result('pg2').set('data', 'dset2');
model.result('pg2').setIndex('looplevel', 19, 0);
model.result('pg2').run;
model.result('pg2').feature('vol1').create('sel1', 'Selection');
model.result('pg2').feature('vol1').feature('sel1').selection.named('geom1_csel1_dom');
model.result('pg2').run;

model.view('view1').set('transparency', false);

model.result('pg2').run;
model.result('pg2').run;
model.result('pg2').create('line1', 'Line');
model.result('pg2').feature('line1').set('linetype', 'tube');
model.result('pg2').feature('line1').set('radiusexpr', '0.5*nipfl.dh');
model.result('pg2').feature('line1').set('tubeendcaps', false);
model.result('pg2').feature('line1').set('colorscalemode', 'logarithmic');
model.result('pg2').feature('line1').set('inheritplot', 'vol1');
model.result('pg2').feature('line1').set('inheritrange', false);
model.result('pg2').run;
model.result('pg2').feature('line1').set('tuberadiusscaleactive', true);
model.result('pg2').feature('line1').set('tuberadiusscale', 1);
model.result('pg2').run;
model.result.create('pg3', 'PlotGroup3D');
model.result('pg3').label('Temperature (ht)');
model.result('pg3').set('data', 'dset2');
model.result('pg3').setIndex('looplevel', 35, 0);
model.result('pg3').setIndex('looplevel', 1, 1);
model.result('pg3').setIndex('looplevel', 1, 2);
model.result('pg3').set('defaultPlotID', 'ht/HT_PhysicsInterfaces/icom8/pdef1/pcond3/pcond3/pg1');
model.result('pg3').feature.create('vol1', 'Volume');
model.result('pg3').feature('vol1').set('solutionparams', 'parent');
model.result('pg3').feature('vol1').set('expr', 'T2');
model.result('pg3').feature('vol1').set('colortable', 'HeatCameraLight');
model.result('pg3').feature('vol1').set('smooth', 'internal');
model.result('pg3').feature('vol1').set('showsolutionparams', 'on');
model.result('pg3').feature('vol1').set('data', 'parent');
model.result('pg3').label('Temperature (ht)');
model.result('pg3').run;
model.result('pg3').label('Mold Temperature');
model.result('pg3').setIndex('looplevel', 19, 0);
model.result('pg3').run;
model.result('pg3').set('titletype', 'manual');
model.result('pg3').set('title', 'Temperature (K)');
model.result('pg3').run;
model.result.create('pg4', 'PlotGroup3D');
model.result('pg4').label('Temperature (pwhtc1)');
model.result('pg4').set('data', 'dset2');
model.result('pg4').setIndex('looplevel', 35, 0);
model.result('pg4').setIndex('looplevel', 1, 1);
model.result('pg4').setIndex('looplevel', 1, 2);
model.result('pg4').set('defaultPlotID', 'PipeCouplingFeatures/edgcpl1/pdef1/pcond2/pg1');
model.result('pg4').feature.create('line1', 'Line');
model.result('pg4').feature('line1').set('linetype', 'tube');
model.result('pg4').feature('line1').set('radiusexpr', 'pwhtc1.radiusExt');
model.result('pg4').feature('line1').set('tuberadiusscaleactive', true);
model.result('pg4').feature('line1').set('colortable', 'HeatCameraLight');
model.result('pg4').feature('line1').set('smooth', 'internal');
model.result('pg4').feature('line1').set('showsolutionparams', 'on');
model.result('pg4').feature('line1').set('data', 'parent');
model.result('pg4').feature.create('slc1', 'Slice');
model.result('pg4').feature('slc1').set('expr', 'T2');
model.result('pg4').feature('slc1').set('smooth', 'internal');
model.result('pg4').feature('slc1').set('showsolutionparams', 'on');
model.result('pg4').feature('slc1').set('data', 'parent');
model.result('pg4').feature('slc1').set('inheritplot', 'line1');
model.result('pg4').label('Temperature (pwhtc1)');
model.result('pg4').run;
model.result('pg4').set('titletype', 'manual');
model.result('pg4').set('title', 'Temperature (K)');
model.result('pg4').create('surf1', 'Surface');
model.result('pg4').feature('surf1').set('expr', '1');
model.result('pg4').feature('surf1').set('coloring', 'uniform');
model.result('pg4').feature('surf1').set('color', 'gray');
model.result('pg4').feature('surf1').create('sel1', 'Selection');
model.result('pg4').feature('surf1').feature('sel1').selection.named('geom1_csel1_bnd');
model.result('pg4').run;
model.result('pg4').run;
model.result('pg4').create('surf2', 'Surface');
model.result('pg4').feature('surf2').set('expr', 'T2');
model.result('pg4').feature('surf2').set('inheritplot', 'slc1');
model.result('pg4').feature('surf2').create('sel1', 'Selection');
model.result('pg4').feature('surf2').feature('sel1').selection.set([3 5]);
model.result('pg4').run;
model.result.table('tbl1').set('format', 'filled');
model.result.table.duplicate('tbl3', 'tbl1');
model.result.table('tbl3').set('param', 2);
model.result.table.duplicate('tbl4', 'tbl1');
model.result.table('tbl4').set('param', 3);
model.result.table.duplicate('tbl5', 'tbl1');
model.result.table('tbl5').set('param', 4);
model.result('pg1').set('window', 'window2');
model.result('pg1').set('windowtitle', 'Probe Plot 2');
model.result('pg1').run;
model.result('pg1').feature('tblp1').set('table', 'tbl1');
model.result('pg1').feature('tblp1').set('plotcolumninput', 'all');
model.result('pg1').feature('tblp1').set('legendmethod', 'manual');
model.result('pg1').feature('tblp1').setIndex('legends', 'Aluminum, Qw=20, e=0.46', 0);
model.result('pg1').feature('tblp1').setIndex('legends', 'Aluminum, Qw=20, e=0.046', 1);
model.result('pg1').set('window', 'window2');
model.result('pg1').set('windowtitle', 'Probe Plot 2');
model.result('pg1').run;
model.result('pg1').feature.duplicate('tblp2', 'tblp1');
model.result('pg1').set('window', 'window2');
model.result('pg1').set('windowtitle', 'Probe Plot 2');
model.result('pg1').run;
model.result('pg1').feature('tblp2').set('table', 'tbl3');
model.result('pg1').feature('tblp2').setIndex('legends', 'Aluminum, Qw=10, e=0.46', 0);
model.result('pg1').feature('tblp2').setIndex('legends', 'Aluminum, Qw=10, e=0.046', 1);
model.result('pg1').set('window', 'window2');
model.result('pg1').set('windowtitle', 'Probe Plot 2');
model.result('pg1').run;
model.result('pg1').feature.duplicate('tblp3', 'tblp1');
model.result('pg1').set('window', 'window2');
model.result('pg1').set('windowtitle', 'Probe Plot 2');
model.result('pg1').run;
model.result('pg1').feature('tblp3').set('table', 'tbl4');
model.result('pg1').feature('tblp3').setIndex('legends', 'Steel, Qw=20, e=0.46', 0);
model.result('pg1').feature('tblp3').setIndex('legends', 'Steel, Qw=20, e=0.046', 1);
model.result('pg1').feature.duplicate('tblp4', 'tblp3');
model.result('pg1').set('window', 'window2');
model.result('pg1').set('windowtitle', 'Probe Plot 2');
model.result('pg1').run;
model.result('pg1').feature('tblp4').set('table', 'tbl5');
model.result('pg1').feature('tblp4').setIndex('legends', 'Steel, Qw=10, e=0.46', 0);
model.result('pg1').feature('tblp4').setIndex('legends', 'Steel, Qw=10, e=0.046', 1);
model.result('pg1').set('window', 'window2');
model.result('pg1').set('windowtitle', 'Probe Plot 2');
model.result('pg1').run;
model.result('pg1').label('Average wheel temperature');
model.result('pg4').run;

model.title('Cooling of an Injection Mold');

model.description(['Carefully controlled injection mold cooling is very important to attain a desired cooling history of plastic molds, since the structural integrity of the material depends on the cooling history.' newline  newline 'This example demonstrates how the Pipe Flow Module can be used to model the cooling of an injection-molded polyurethane part for a car steering wheel.']);

model.mesh.clearMeshes;

model.sol('sol1').clearSolutionData;
model.sol('sol2').clearSolutionData;
model.sol('sol3').clearSolutionData;

model.label('mold_cooling.mph');

model.modelNode.label('Components');

out = model;
