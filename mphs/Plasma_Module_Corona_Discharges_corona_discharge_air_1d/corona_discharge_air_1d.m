function out = model
%
% corona_discharge_air_1d.m
%
% Model exported on May 26 2025, 21:31 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/Plasma_Module/Corona_Discharges');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 1);
model.geom('geom1').model('comp1');
model.geom('geom1').axisymmetric(true);

model.mesh.create('mesh1', 'geom1');

model.physics.create('plas', 'ColdPlasma', 'geom1');
model.physics('plas').model('comp1');

model.study.create('std1');
model.study('std1').create('time', 'Transient');
model.study('std1').feature('time').setSolveFor('/physics/plas', true);

model.geom('geom1').lengthUnit('cm');
model.geom('geom1').create('i1', 'Interval');
model.geom('geom1').feature('i1').setIndex('coord', 10, 0);
model.geom('geom1').feature('i1').setIndex('coord', 0.01, 1);
model.geom('geom1').runPre('fin');

model.variable.create('var1');
model.variable('var1').model('comp1');

model.geom('geom1').run;

model.variable('var1').set('mueN', '3.74e24*(plas.Erd*1e21)^-0.22[1/(V*m*s)]');
model.variable('var1').descr('mueN', 'Reduced electron mobility');
model.variable('var1').set('muiN', '6e21[1/(V*s*m)]');
model.variable('var1').descr('muiN', 'Reduced ion mobility');
model.variable('var1').set('rnp', '2e-6[cm^3/s]');
model.variable('var1').descr('rnp', 'ion-ion recombination');
model.variable('var1').set('rei', '5e-8[cm^3/s]');
model.variable('var1').descr('rei', 'electron-ion recombination');
model.variable('var1').set('Vapp', '-V0*ramp');
model.variable('var1').descr('Vapp', 'Applied Voltage');
model.variable('var1').set('ramp', 'tanh(1e5*t)');
model.variable('var1').set('p0', '760[torr]');
model.variable('var1').descr('p0', 'Gas pressure');
model.variable('var1').set('t0', '600[K]');
model.variable('var1').descr('t0', 'Gas temperature');
model.variable('var1').set('ni0', '1e17[m^-3]');
model.variable('var1').descr('ni0', 'Initial ion number density');
model.variable('var1').set('ne0', '1e10[m^-3]');
model.variable('var1').descr('ne0', 'Initial electron number density');

model.param.set('V0', '45[kV]');

model.physics('plas').prop('VerticalHeight').set('dz', '1[m]');
model.physics('plas').prop('ElectronProperties').set('ReducedProps', true);
model.physics('plas').prop('ElectronProperties').set('MeanElectronEnergyModel', 'LocalFieldApproximationE');
model.physics('plas').prop('ShapeProperty').set('Formulation', 'FVMConst');
model.physics('plas').create('eir1', 'ElectronImpactReaction', 1);
model.physics('plas').feature('eir1').set('formula', 'A+e=>p+2e');
model.physics('plas').feature('eir1').set('type', 'Ionization');
model.physics('plas').feature('eir1').set('de', 15);
model.physics('plas').feature('eir1').set('SpecifyReactionUsing', 'UseLookupTable');
model.physics('plas').feature('eir1').set('RateConstantForm', 'UseTownsend');
model.physics('plas').feature('eir1').set('xtownratedata', {'0' '1.035' '1.049' '1.061' '1.074' '1.088' '1.105' '1.127' '1.160' '1.212'  ...
'1.296' '1.422' '1.605' '1.851' '2.155' '2.518' '2.924' '3.359' '3.804' '4.252'  ...
'4.703' '5.167' '5.629' '6.106' '6.595' '7.139' '7.717' '8.347' '9.043' '9.804'  ...
'10.65' '11.59' '12.64' '13.80' '15.11' '16.57'});
model.physics('plas').feature('eir1').set('ytownratedata', {'0' '0.000' '0.7818E-32' '0.2129E-30' '0.2556E-29' '0.2353E-28' '0.1758E-27' '0.1040E-26' '0.5210E-26' '0.2197E-25'  ...
'0.8170E-25' '0.2653E-24' '0.7771E-24' '0.2057E-23' '0.4991E-23' '0.1116E-22' '0.2320E-22' '0.4511E-22' '0.8270E-22' '0.1440E-21'  ...
'0.2387E-21' '0.3801E-21' '0.5831E-21' '0.8652E-21' '0.1246E-20' '0.1747E-20' '0.2390E-20' '0.3193E-20' '0.4177E-20' '0.5356E-20'  ...
'0.6741E-20' '0.8337E-20' '0.1015E-19' '0.1217E-19' '0.1439E-19' '0.1679E-19'});
model.physics('plas').create('eir2', 'ElectronImpactReaction', 1);
model.physics('plas').feature('eir2').set('formula', 'A+e=>n');
model.physics('plas').feature('eir2').set('type', 'Attachment');
model.physics('plas').feature('eir2').set('SpecifyReactionUsing', 'UseLookupTable');
model.physics('plas').feature('eir2').set('RateConstantForm', 'UseTownsend');
model.physics('plas').feature('eir2').set('xtownratedata', {'0' '0.4026E-01' '0.4571E-01' '0.5210E-01' '0.5954E-01' '0.6805E-01' '0.7750E-01' '0.8764E-01' '0.9806E-01' '0.1084'  ...
'0.1184' '0.1281' '0.1374' '0.1465' '0.1556' '0.1647' '0.1742' '0.1842' '0.1946' '0.2057'  ...
'0.2178' '0.2310' '0.2458' '0.2628' '0.2826' '0.3062' '0.3343' '0.3675' '0.4068' '0.4514'  ...
'0.5005' '0.5525' '0.6054' '0.6576' '0.7075' '0.7540' '0.7969' '0.8352' '0.8693' '0.8996'  ...
'0.9264' '0.9497' '0.9706' '0.9894' '1.006' '1.022' '1.035' '1.049' '1.061' '1.074'  ...
'1.088' '1.105' '1.127' '1.160' '1.212' '1.296' '1.422' '1.605' '1.851' '2.155'  ...
'2.518' '2.924' '3.359' '3.804' '4.252' '4.703' '5.167' '5.629' '6.106' '6.595'  ...
'7.139' '7.717' '8.347' '9.043' '9.804' '10.65' '11.59' '12.64' '13.80' '15.11'  ...
'16.57'});
model.physics('plas').feature('eir2').set('ytownratedata', {'0' '0.1273E-39' '0.1621E-39' '0.1964E-39' '0.2269E-39' '0.2507E-39' '0.2660E-39' '0.2722E-39' '0.2700E-39' '0.2611E-39'  ...
'0.2473E-39' '0.2303E-39' '0.2119E-39' '0.1930E-39' '0.1746E-39' '0.1571E-39' '0.1407E-39' '0.1256E-39' '0.1118E-39' '0.9925E-40'  ...
'0.8797E-40' '0.7782E-40' '0.6871E-40' '0.6055E-40' '0.5326E-40' '0.4675E-40' '0.4094E-40' '0.3578E-40' '0.3117E-40' '0.2709E-40'  ...
'0.2348E-40' '0.2032E-40' '0.1756E-40' '0.1518E-40' '0.1313E-40' '0.1138E-40' '0.9890E-41' '0.8624E-41' '0.7548E-41' '0.6631E-41'  ...
'0.5847E-41' '0.5174E-41' '0.4591E-41' '0.1439E-30' '0.2774E-29' '0.2915E-28' '0.2091E-27' '0.1256E-26' '0.6007E-26' '0.2325E-25'  ...
'0.7685E-25' '0.2237E-24' '0.5625E-24' '0.1275E-23' '0.2575E-23' '0.4780E-23' '0.8015E-23' '0.1242E-22' '0.1772E-22' '0.2351E-22'  ...
'0.2917E-22' '0.3414E-22' '0.3795E-22' '0.4045E-22' '0.4166E-22' '0.4164E-22' '0.4071E-22' '0.3907E-22' '0.3694E-22' '0.3450E-22'  ...
'0.3193E-22' '0.2932E-22' '0.2675E-22' '0.2428E-22' '0.2195E-22' '0.1978E-22' '0.1779E-22' '0.1597E-22' '0.1433E-22' '0.1286E-22'  ...
'0.1155E-22'});
model.physics('plas').create('eir3', 'ElectronImpactReaction', 1);
model.physics('plas').feature('eir3').set('formula', 'A + A + e => n + A');
model.physics('plas').feature('eir3').set('type', 'Attachment');
model.physics('plas').feature('eir3').set('kf', '1.4e-41*(0.026/plas.Te)*exp(100/t0-0.061/plas.Te)*N_A_const^2*0.1');
model.physics('plas').create('rxn1', 'Reaction', 1);
model.physics('plas').feature('rxn1').set('formula', 'e+p=>A');
model.physics('plas').feature('rxn1').set('kf', 'rei*N_A_const');
model.physics('plas').create('rxn2', 'Reaction', 1);
model.physics('plas').feature('rxn2').set('formula', 'n+p=>A+A');
model.physics('plas').feature('rxn2').set('kf', 'rnp*N_A_const');
model.physics('plas').feature('A').set('FromMassConstraint', true);
model.physics('plas').feature('A').set('PresetSpeciesData', 'N2');
model.physics('plas').feature('p').set('sType', 'ion');
model.physics('plas').feature('p').set('PresetSpeciesData', 'N2');
model.physics('plas').feature('p').set('z', 1);
model.physics('plas').feature('p').set('n0', 'ni0');
model.physics('plas').feature('p').set('MobilityDiffusivitySpecification', 'SpecifyMobilityComputeDiffusivity');
model.physics('plas').feature('p').set('um', 'muiN/plas.Nn');
model.physics('plas').feature('n').set('sType', 'ion');
model.physics('plas').feature('n').set('PresetSpeciesData', 'N2');
model.physics('plas').feature('n').set('z', -1);
model.physics('plas').feature('n').set('n0', 'ni0');
model.physics('plas').feature('n').set('MobilityDiffusivitySpecification', 'SpecifyMobilityComputeDiffusivity');
model.physics('plas').feature('n').set('um', 'muiN/plas.Nn');
model.physics('plas').create('sr1', 'SurfaceReaction', 0);
model.physics('plas').feature('sr1').set('formula', 'p=>A');
model.physics('plas').feature('sr1').selection.set([1]);
model.physics('plas').feature('sr1').set('gammai', 0.05);
model.physics('plas').feature('sr1').set('ebari', 4);
model.physics('plas').create('sr2', 'SurfaceReaction', 0);
model.physics('plas').feature('sr2').set('formula', 'p=>A');
model.physics('plas').feature('sr2').selection.set([2]);
model.physics('plas').create('sr3', 'SurfaceReaction', 0);
model.physics('plas').feature('sr3').set('formula', 'n=>A');
model.physics('plas').feature('sr3').selection.all;
model.physics('plas').feature('pes1').set('T', 't0');
model.physics('plas').feature('pes1').set('pA', 'p0');
model.physics('plas').feature('pes1').set('muN', {'mueN' '0' '0' '0' 'mueN' '0' '0' '0' 'mueN'});
model.physics('plas').feature('pes1').set('SpecifyMeanElectronEnergy', 'MeanEnergyTable');
model.physics('plas').feature('pes1').set('enrgXdata', {'0' '0.1000' '0.1116' '0.1246' '0.1391' '0.1553' '0.1734' '0.1936' '0.2162' '0.2413'  ...
'0.2694' '0.3008' '0.3358' '0.3749' '0.4185' '0.4672' '0.5216' '0.5824' '0.6502' '0.7258'  ...
'0.8103' '0.9047' '1.010' '1.128' '1.259' '1.405' '1.569' '1.752' '1.956' '2.183'  ...
'2.437' '2.721' '3.038' '3.391' '3.786' '4.227' '4.719' '5.269' '5.882' '6.567'  ...
'7.331' '8.184' '9.137' '10.20' '11.39' '12.71' '14.19' '15.85' '17.69' '19.75'  ...
'22.05' '24.62' '27.48' '30.68' '34.25' '38.24' '42.69' '47.66' '53.21' '59.41'  ...
'66.32' '74.04' '82.66' '92.29' '103.0' '115.0' '128.4' '143.4' '160.0' '178.7'  ...
'199.5' '222.7' '248.6' '277.6' '309.9' '346.0' '386.2' '431.2' '481.4' '537.4'  ...
'600.0' '627.3' '704.9' '792.0' '890.0' '1000.'});
model.physics('plas').feature('pes1').set('enrgYdata', {'0' '0.4026E-01' '0.4538E-01' '0.5134E-01' '0.5823E-01' '0.6607E-01' '0.7480E-01' '0.8421E-01' '0.9400E-01' '0.1038'  ...
'0.1135' '0.1228' '0.1317' '0.1404' '0.1490' '0.1576' '0.1663' '0.1753' '0.1848' '0.1946'  ...
'0.2051' '0.2164' '0.2287' '0.2424' '0.2579' '0.2757' '0.2966' '0.3212' '0.3504' '0.3844'  ...
'0.4236' '0.4675' '0.5149' '0.5644' '0.6144' '0.6635' '0.7103' '0.7542' '0.7947' '0.8312'  ...
'0.8640' '0.8933' '0.9194' '0.9423' '0.9629' '0.9811' '0.9980' '1.013' '1.027' '1.040'  ...
'1.052' '1.064' '1.076' '1.090' '1.106' '1.127' '1.158' '1.206' '1.280' '1.390'  ...
'1.550' '1.763' '2.029' '2.353' '2.719' '3.117' '3.534' '3.956' '4.380' '4.817'  ...
'5.246' '5.684' '6.136' '6.598' '7.112' '7.655' '8.242' '8.889' '9.593' '10.36'  ...
'11.22' '11.59' '12.64' '13.80' '15.11' '16.57'});
model.physics('plas').feature('init1').set('neinit', 'ne0');
model.physics('plas').create('gnd1', 'Ground', 0);
model.physics('plas').feature('gnd1').selection.set([2]);
model.physics('plas').create('mct1', 'MetalContact', 0);
model.physics('plas').feature('mct1').selection.set([1]);
model.physics('plas').feature('mct1').set('V0', 'Vapp');
model.physics('plas').create('wall1', 'WallDriftDiffusion', 0);
model.physics('plas').feature('wall1').selection.all;

model.mesh('mesh1').create('edg1', 'Edge');
model.mesh('mesh1').feature('edg1').create('dis1', 'Distribution');
model.mesh('mesh1').feature('edg1').feature('dis1').set('type', 'predefined');
model.mesh('mesh1').feature('edg1').feature('dis1').set('elemcount', 200);
model.mesh('mesh1').feature('edg1').feature('dis1').set('elemratio', 100);
model.mesh('mesh1').feature('edg1').feature('dis1').set('growthrate', 'exponential');
model.mesh('mesh1').feature('edg1').feature('dis1').set('symmetric', true);
model.mesh('mesh1').run;

model.study('std1').feature('time').set('tlist', '0 10^{range(-8,8/49,0)}');
model.study('std1').feature('time').set('plot', true);

model.sol.create('sol1');
model.sol('sol1').study('std1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'time');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').set('control', 'time');
model.sol('sol1').create('t1', 'Time');
model.sol('sol1').feature('t1').set('tlist', '0 10^{range(-8,8/49,0)}');
model.sol('sol1').feature('t1').set('plot', 'on');
model.sol('sol1').feature('t1').set('plotgroup', 'Default');
model.sol('sol1').feature('t1').set('plotfreq', 'tout');
model.sol('sol1').feature('t1').set('probesel', 'all');
model.sol('sol1').feature('t1').set('probes', {});
model.sol('sol1').feature('t1').set('probefreq', 'tsteps');
model.sol('sol1').feature('t1').set('rtol', 0.001);
model.sol('sol1').feature('t1').set('atolglobalvaluemethod', 'manual');
model.sol('sol1').feature('t1').set('atolglobalmethod', 'unscaled');
model.sol('sol1').feature('t1').set('atolglobal', 0.001);
model.sol('sol1').feature('t1').set('atolglobalvaluemethod', 'manual');
model.sol('sol1').feature('t1').set('reacf', true);
model.sol('sol1').feature('t1').set('storeudot', true);
model.sol('sol1').feature('t1').set('endtimeinterpolation', true);
model.sol('sol1').feature('t1').set('estrat', 'exclude');
model.sol('sol1').feature('t1').set('maxorder', 2);
model.sol('sol1').feature('t1').set('initialstepbdfactive', true);
model.sol('sol1').feature('t1').set('initialstepbdf', '(1.0E-13)[s]');
model.sol('sol1').feature('t1').set('control', 'time');
model.sol('sol1').feature('t1').feature('aDef').set('matherr', false);
model.sol('sol1').feature('t1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('t1').feature('fc1').set('jtech', 'once');
model.sol('sol1').feature('t1').create('d1', 'Direct');
model.sol('sol1').feature('t1').feature('d1').set('linsolver', 'pardiso');
model.sol('sol1').feature('t1').feature('fc1').set('linsolver', 'd1');
model.sol('sol1').feature('t1').feature('fc1').set('jtech', 'once');
model.sol('sol1').feature('t1').feature.remove('fcDef');
model.sol('sol1').attach('std1');
model.sol('sol1').feature('t1').feature('fc1').set('jtech', 'minimal');

model.result.create('pg1', 'PlotGroup1D');
model.result('pg1').set('data', 'dset1');
model.result('pg1').create('lngr1', 'LineGraph');
model.result('pg1').feature('lngr1').set('xdata', 'expr');
model.result('pg1').feature('lngr1').set('xdataexpr', 'r');
model.result('pg1').feature('lngr1').selection.geom('geom1', 1);
model.result('pg1').feature('lngr1').selection.set([1]);
model.result('pg1').feature('lngr1').set('expr', {'plas.ne'});

model.sol('sol1').runFromTo('st1', 'v1');

model.result.remove('pg1');

model.study('std1').feature('time').set('plotgroup', 'Default');

model.result.create('pg1', 'PlotGroup1D');
model.result('pg1').set('data', 'dset1');
model.result('pg1').create('lngr1', 'LineGraph');
model.result('pg1').feature('lngr1').set('xdata', 'expr');
model.result('pg1').feature('lngr1').set('xdataexpr', 'r');
model.result('pg1').feature('lngr1').selection.geom('geom1', 1);
model.result('pg1').feature('lngr1').selection.set([1]);
model.result('pg1').feature('lngr1').set('expr', {'plas.ne'});
model.result.create('pg2', 'PlotGroup1D');
model.result('pg2').set('data', 'dset1');
model.result('pg2').create('lngr1', 'LineGraph');
model.result('pg2').feature('lngr1').set('xdata', 'expr');
model.result('pg2').feature('lngr1').set('xdataexpr', 'r');
model.result('pg2').feature('lngr1').selection.geom('geom1', 1);
model.result('pg2').feature('lngr1').selection.set([1]);
model.result('pg2').feature('lngr1').set('expr', {'plas.Te'});
model.result.create('pg3', 'PlotGroup1D');
model.result('pg3').set('data', 'dset1');
model.result('pg3').create('lngr1', 'LineGraph');
model.result('pg3').feature('lngr1').set('xdata', 'expr');
model.result('pg3').feature('lngr1').set('xdataexpr', 'r');
model.result('pg3').feature('lngr1').selection.geom('geom1', 1);
model.result('pg3').feature('lngr1').selection.set([1]);
model.result('pg3').feature('lngr1').set('expr', {'V'});
model.result('pg1').label('Electron Density (plas)');
model.result('pg2').label('Electron Temperature (plas)');
model.result('pg3').label('Electric Potential (plas)');
model.result('pg1').run;
model.result('pg1').label('Electron and Ion Number Density');
model.result('pg1').set('titletype', 'label');
model.result('pg1').setIndex('looplevelinput', 'last', 0);
model.result('pg1').set('xlabelactive', true);
model.result('pg1').set('ylabelactive', true);
model.result('pg1').set('ylabel', 'Number density (1/m<sup>3</sup>)');
model.result('pg1').set('axislimits', true);
model.result('pg1').set('xmin', 0.009);
model.result('pg1').set('xmax', 11);
model.result('pg1').set('ymin', '1e9');
model.result('pg1').set('ymax', '1e17');
model.result('pg1').set('xlog', true);
model.result('pg1').set('ylog', true);
model.result('pg1').run;
model.result('pg1').feature('lngr1').label('Electrons');
model.result('pg1').feature('lngr1').set('legend', true);
model.result('pg1').feature('lngr1').set('autosolution', false);
model.result('pg1').feature('lngr1').set('autoplotlabel', true);
model.result('pg1').feature('lngr1').set('resolution', 'norefine');
model.result('pg1').feature.duplicate('lngr2', 'lngr1');
model.result('pg1').run;
model.result('pg1').feature('lngr2').label('Positive ions');
model.result('pg1').feature('lngr2').set('expr', 'plas.n_wp');
model.result('pg1').feature.duplicate('lngr3', 'lngr2');
model.result('pg1').run;
model.result('pg1').feature('lngr3').label('Negative ions');
model.result('pg1').feature('lngr3').set('expr', 'plas.n_wn');
model.result('pg2').run;
model.result('pg2').setIndex('looplevelinput', 'last', 0);
model.result('pg2').set('titletype', 'label');
model.result('pg2').set('xlog', true);
model.result('pg3').run;
model.result('pg3').setIndex('looplevelinput', 'last', 0);
model.result('pg3').set('titletype', 'label');

model.sol('sol1').runAll;

model.result('pg1').run;
model.result('pg2').run;
model.result('pg3').run;
model.result.duplicate('pg4', 'pg3');
model.result('pg4').run;
model.result('pg4').label('Reduced Electric Field');
model.result('pg4').set('xlog', true);
model.result('pg4').run;
model.result('pg4').feature('lngr1').set('expr', 'plas.Erd');
model.result('pg4').feature('lngr1').set('unit', 'Td');
model.result('pg4').run;
model.result.dataset.create('rev1', 'Revolve1D');
model.result.create('pg5', 'PlotGroup2D');
model.result('pg5').run;
model.result('pg5').label('Log of Electron Density');
model.result('pg5').set('titletype', 'label');
model.result('pg5').create('surf1', 'Surface');
model.result('pg5').feature('surf1').set('expr', 'log10(plas.ne)');
model.result('pg5').run;
model.result('pg5').run;
model.result.duplicate('pg6', 'pg5');
model.result('pg6').run;
model.result('pg6').label('Log of Negative Ion Density');
model.result('pg6').run;
model.result('pg6').feature('surf1').set('expr', 'log10(plas.n_wn)');
model.result('pg6').run;
model.result('pg6').run;
model.result.duplicate('pg7', 'pg6');
model.result('pg7').run;
model.result('pg7').label('Log of Positive Ion Density');
model.result('pg7').run;
model.result('pg7').feature('surf1').set('expr', 'log10(plas.n_wp)');
model.result('pg7').run;
model.result('pg7').run;

model.study('std1').setGenPlots(false);
model.study('std1').setGenConv(false);
model.study('std1').create('param', 'Parametric');
model.study('std1').feature('param').setIndex('pname', 'V0', 0);
model.study('std1').feature('param').setIndex('plistarr', '', 0);
model.study('std1').feature('param').setIndex('punit', 'V', 0);
model.study('std1').feature('param').setIndex('pname', 'V0', 0);
model.study('std1').feature('param').setIndex('plistarr', '', 0);
model.study('std1').feature('param').setIndex('punit', 'V', 0);
model.study('std1').feature('param').setIndex('plistarr', '20 25 30 35 40 45 50', 0);
model.study('std1').feature('param').setIndex('punit', 'kV', 0);
model.study('std1').feature('time').set('plot', false);

model.batch.create('p1', 'Parametric');
model.batch('p1').study('std1');
model.batch('p1').create('so1', 'Solutionseq');
model.batch('p1').feature('so1').set('seq', 'sol1');
model.batch('p1').feature('so1').set('store', 'on');
model.batch('p1').feature('so1').set('clear', 'on');
model.batch('p1').feature('so1').set('psol', 'none');
model.batch('p1').set('pname', {'V0'});
model.batch('p1').set('plistarr', {'20 25 30 35 40 45 50'});
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

model.result('pg1').run;
model.result.create('pg8', 'PlotGroup1D');
model.result('pg8').run;
model.result('pg8').set('data', 'dset2');
model.result('pg8').setIndex('looplevelinput', 'last', 0);
model.result('pg8').label('Current Vs. Voltage');
model.result('pg8').set('titletype', 'none');
model.result('pg8').create('ptgr1', 'PointGraph');
model.result('pg8').feature('ptgr1').set('markerpos', 'datapoints');
model.result('pg8').feature('ptgr1').set('linewidth', 'preference');
model.result('pg8').feature('ptgr1').selection.set([2]);
model.result('pg8').feature('ptgr1').set('expr', 'plas.nJt');
model.result('pg8').feature('ptgr1').set('descr', 'Total ion current density on wall');
model.result('pg8').feature('ptgr1').set('expr', 'abs(plas.nJt)');
model.result('pg8').feature('ptgr1').set('unit', 'mA/m^2');
model.result('pg8').feature('ptgr1').set('descractive', true);
model.result('pg8').feature('ptgr1').set('xdatasolnumtype', 'level2');
model.result('pg8').feature('ptgr1').set('xdata', 'expr');
model.result('pg8').feature('ptgr1').set('xdataexpr', 'V0');
model.result('pg8').feature('ptgr1').set('xdataunit', 'kV');
model.result('pg8').feature('ptgr1').set('xdatadescractive', true);
model.result('pg8').feature('ptgr1').set('xdatadescr', 'Applied Voltage');
model.result('pg8').run;
model.result('pg8').set('ylabelactive', true);
model.result('pg8').set('ylabel', 'Total Ion Current Density (mA/m<sup>2</sup>)');
model.result('pg8').run;

model.title('Atmospheric Pressure Corona Discharge in Air');

model.description(['This tutorial model presents a study of a coaxial DC corona discharge in dry air at atmospheric pressure. The dimensions and operation conditions are similar to ones found in electrostatic precipitators with wire-to-plate configurations. The inner wire electrode has a 100-mm radius and the gap between electrodes is 10' native2unicode(hex2dec({'00' 'a0'}), 'unicode') 'cm.' newline  newline 'The model solves the electron and ion continuity and momentum equations in the drift-diffusion approximation, self-consistently coupled with Poisson' native2unicode(hex2dec({'20' '19'}), 'unicode') 's equation. The local field approximation is used, which means that transport and source coefficients are assumed to be well parameterized through the reduced electric field.' newline  newline 'The simulations presented are for steady-state regimes, with a sustained discharge and 10''s of kV applied to the inner electrode while the exterior electrode is grounded. Emphasis is placed on the charged particles'' creation and transport and how that translates into the current-voltage characteristic of the discharge.']);

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

model.label('corona_discharge_air_1d.mph');

model.modelNode.label('Components');

out = model;
