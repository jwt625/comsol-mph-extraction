function out = model
%
% positive_and_negative_corona_discharges.m
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

% To import content from file, use:
% model.param.loadFile('FILENAME');
model.param.set('rin', '0.01[cm]', 'Electrode radius');
model.param.set('muiN', '6e21[1/(V*s*m)]', 'Reduced ion mobility');
model.param.set('rnp', '2e-6[cm^3/s]', 'Ion-ion recombination');
model.param.set('rei', '5e-8[cm^3/s]', 'Electron-ion recombination');
model.param.set('P0', '760[torr]', 'Gas pressure');
model.param.set('T0', '600[K]', 'Gas temperature');
model.param.set('ni0', '1e16[m^-3]', 'Initial ion number density');
model.param.set('ne0', '1e10[m^-3]', 'Initial electron number density');
model.param.set('V0', 'cp*30[kV]', 'Applied voltage');
model.param.set('cp', '+1', 'Corona polarity');

model.variable.create('var1');
model.variable('var1').model('comp1');

model.geom('geom1').run;

model.variable('var1').set('mueN', '3.74e24[1/(V*s*m)]*(plas.Erd*1e21[1/(V*m^2)])^-0.22');
model.variable('var1').descr('mueN', 'Reduced electron mobility');
model.variable('var1').set('Vapp', 'V0*ramp');
model.variable('var1').descr('Vapp', 'Applied Voltage with ramp function');
model.variable('var1').set('ramp', 'tanh(1e5*t[1/s])');
model.variable('var1').descr('ramp', 'Ramp function');

model.geom('geom1').lengthUnit('cm');
model.geom('geom1').create('i1', 'Interval');
model.geom('geom1').feature('i1').setIndex('coord', 'rin', 0);
model.geom('geom1').feature('i1').setIndex('coord', 10, 1);
model.geom('geom1').runPre('fin');
model.geom('geom1').run;

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
model.physics('plas').feature('eir3').set('kf', '1.4e-41*(0.026/plas.Te)*exp(100/T0-0.061/plas.Te)*N_A_const^2*0.1');
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
model.physics('plas').feature('sr1').set('gammai', 0.05);
model.physics('plas').feature('sr1').set('ebari', 4);
model.physics('plas').feature('sr1').selection.set([1]);
model.physics('plas').feature.duplicate('sr2', 'sr1');
model.physics('plas').feature('sr2').set('gammai', 0);
model.physics('plas').feature('sr2').set('ebari', 0);
model.physics('plas').feature('sr2').selection.set([2]);
model.physics('plas').feature.duplicate('sr3', 'sr2');
model.physics('plas').feature('sr3').set('formula', 'n=>A');
model.physics('plas').feature('sr3').selection.set([]);
model.physics('plas').feature('sr3').selection.all;
model.physics('plas').feature('pes1').set('T', 'T0');
model.physics('plas').feature('pes1').set('pA', 'P0');
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
model.physics('plas').feature('mct1').set('V0', 'Vapp');
model.physics('plas').feature('mct1').selection.set([1]);
model.physics('plas').create('wall1', 'WallDriftDiffusion', 0);
model.physics('plas').feature('wall1').selection.all;

model.mesh('mesh1').create('edg1', 'Edge');
model.mesh('mesh1').feature('edg1').create('dis1', 'Distribution');
model.mesh('mesh1').feature('edg1').feature('dis1').set('type', 'predefined');
model.mesh('mesh1').feature('edg1').feature('dis1').set('elemcount', 500);
model.mesh('mesh1').feature('edg1').feature('dis1').set('elemratio', 800);
model.mesh('mesh1').feature('edg1').feature('dis1').set('growthrate', 'exponential');
model.mesh('mesh1').feature('edg1').feature('dis1').set('symmetric', true);
model.mesh('mesh1').run;

model.study('std1').label('Positive Corona');
model.study('std1').setGenPlots(false);
model.study('std1').feature('time').set('tlist', '0 10^{range(-8,8/49,0)}');

model.sol.create('sol1');
model.sol('sol1').study('std1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'time');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').set('control', 'time');
model.sol('sol1').create('t1', 'Time');
model.sol('sol1').feature('t1').set('tlist', '0 10^{range(-8,8/49,0)}');
model.sol('sol1').feature('t1').set('plot', 'off');
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
model.sol('sol1').runAll;

model.result.create('pg1', 'PlotGroup1D');
model.result('pg1').run;
model.result('pg1').label('Electron and Ion Number Density - Positive Corona');
model.result('pg1').setIndex('looplevelinput', 'last', 0);
model.result('pg1').set('titletype', 'label');
model.result('pg1').set('xlabelactive', true);
model.result('pg1').set('xlabel', 'r-coordinate (cm)');
model.result('pg1').set('ylabelactive', true);
model.result('pg1').set('ylabel', 'Number density (1/m<sup>3</sup>)');
model.result('pg1').set('ylog', true);
model.result('pg1').set('xlog', true);
model.result('pg1').set('axislimits', true);
model.result('pg1').set('xmin', 0.009);
model.result('pg1').set('xmax', 11);
model.result('pg1').set('ymin', '1e7');
model.result('pg1').set('ymax', '1e18');
model.result('pg1').create('lngr1', 'LineGraph');
model.result('pg1').feature('lngr1').set('markerpos', 'datapoints');
model.result('pg1').feature('lngr1').set('linewidth', 'preference');
model.result('pg1').feature('lngr1').label('Electrons');
model.result('pg1').feature('lngr1').selection.all;
model.result('pg1').feature('lngr1').set('xdata', 'expr');
model.result('pg1').feature('lngr1').set('xdataexpr', 'r');
model.result('pg1').feature('lngr1').set('legend', true);
model.result('pg1').feature('lngr1').set('autosolution', false);
model.result('pg1').feature('lngr1').set('autoplotlabel', true);
model.result('pg1').run;
model.result('pg1').feature.duplicate('lngr2', 'lngr1');
model.result('pg1').run;
model.result('pg1').feature('lngr2').label('Positive Ions');
model.result('pg1').feature('lngr2').set('expr', 'plas.n_wp');
model.result('pg1').feature.duplicate('lngr3', 'lngr2');
model.result('pg1').run;
model.result('pg1').feature('lngr3').label('Negative Ions');
model.result('pg1').feature('lngr3').set('expr', 'plas.n_wn');
model.result('pg1').run;
model.result.create('pg2', 'PlotGroup1D');
model.result('pg2').run;
model.result('pg2').label('Electric Potential');
model.result('pg2').set('titletype', 'label');
model.result('pg2').setIndex('looplevelinput', 'last', 0);
model.result('pg2').set('xlabelactive', true);
model.result('pg2').set('xlabel', 'r-coordinate (cm)');
model.result('pg2').set('ylabelactive', true);
model.result('pg2').set('ylabel', 'Potential (kV)');
model.result('pg2').create('lngr1', 'LineGraph');
model.result('pg2').feature('lngr1').set('markerpos', 'datapoints');
model.result('pg2').feature('lngr1').set('linewidth', 'preference');
model.result('pg2').feature('lngr1').label('Positive Corona');
model.result('pg2').feature('lngr1').selection.all;
model.result('pg2').feature('lngr1').set('expr', 'V');
model.result('pg2').feature('lngr1').set('unit', 'kV');
model.result('pg2').feature('lngr1').set('xdata', 'expr');
model.result('pg2').feature('lngr1').set('xdataexpr', 'r');
model.result('pg2').feature('lngr1').set('legend', true);
model.result('pg2').feature('lngr1').set('autosolution', false);
model.result('pg2').feature('lngr1').set('autoplotlabel', true);
model.result('pg2').run;
model.result.create('pg3', 'PlotGroup1D');
model.result('pg3').run;
model.result('pg3').label('Space Charge Density');
model.result('pg3').setIndex('looplevelinput', 'last', 0);
model.result('pg3').set('titletype', 'label');
model.result('pg3').set('xlabelactive', true);
model.result('pg3').set('xlabel', 'r-coordinate (cm)');
model.result('pg3').set('ylabelactive', true);
model.result('pg3').set('ylabel', 'Space charge density (mC/m<sup>3</sup>)');
model.result('pg3').create('lngr1', 'LineGraph');
model.result('pg3').feature('lngr1').set('markerpos', 'datapoints');
model.result('pg3').feature('lngr1').set('linewidth', 'preference');
model.result('pg3').feature('lngr1').label('Positive Corona');
model.result('pg3').feature('lngr1').selection.all;
model.result('pg3').feature('lngr1').set('expr', 'plas.scharge');
model.result('pg3').feature('lngr1').set('unit', 'mC/m^3');
model.result('pg3').feature('lngr1').set('xdata', 'expr');
model.result('pg3').feature('lngr1').set('xdataexpr', 'r');
model.result('pg3').feature('lngr1').set('legend', true);
model.result('pg3').feature('lngr1').set('autosolution', false);
model.result('pg3').feature('lngr1').set('autoplotlabel', true);
model.result('pg3').run;
model.result.create('pg4', 'PlotGroup1D');
model.result('pg4').run;
model.result('pg4').label('Rate Expression');
model.result('pg4').set('titletype', 'label');
model.result('pg4').set('xlabelactive', true);
model.result('pg4').set('xlabel', 'r-coordinate (cm)');
model.result('pg4').set('ylabelactive', true);
model.result('pg4').set('ylabel', 'Rate expression (mol/(m<sup>3</sup>*s))');
model.result('pg4').set('xlog', true);
model.result('pg4').set('ylog', true);
model.result('pg4').set('axislimits', true);
model.result('pg4').set('xmin', 0.009);
model.result('pg4').set('xmax', 11);
model.result('pg4').set('ymin', '1e-11');
model.result('pg4').set('ymax', 10);
model.result('pg4').create('lngr1', 'LineGraph');
model.result('pg4').feature('lngr1').set('markerpos', 'datapoints');
model.result('pg4').feature('lngr1').set('linewidth', 'preference');
model.result('pg4').feature('lngr1').label('Positive Corona');
model.result('pg4').feature('lngr1').set('data', 'dset1');
model.result('pg4').feature('lngr1').setIndex('looplevelinput', 'last', 0);
model.result('pg4').feature('lngr1').selection.all;
model.result('pg4').feature('lngr1').set('expr', 'plas.R_wp');
model.result('pg4').feature('lngr1').set('xdata', 'expr');
model.result('pg4').feature('lngr1').set('xdataexpr', 'r');
model.result('pg4').feature('lngr1').set('legend', true);
model.result('pg4').feature('lngr1').set('autosolution', false);
model.result('pg4').feature('lngr1').set('autoplotlabel', true);
model.result('pg4').run;

model.param.set('cp', '-1');

model.study.create('std2');
model.study('std2').create('time', 'Transient');
model.study('std2').feature('time').setSolveFor('/physics/plas', true);
model.study('std2').feature('time').set('tlist', '0 10^{range(-8,8/49,0)}');
model.study('std2').setGenPlots(false);
model.study('std2').label('Negative Corona');

model.sol.create('sol2');
model.sol('sol2').study('std2');
model.sol('sol2').create('st1', 'StudyStep');
model.sol('sol2').feature('st1').set('study', 'std2');
model.sol('sol2').feature('st1').set('studystep', 'time');
model.sol('sol2').create('v1', 'Variables');
model.sol('sol2').feature('v1').set('control', 'time');
model.sol('sol2').create('t1', 'Time');
model.sol('sol2').feature('t1').set('tlist', '0 10^{range(-8,8/49,0)}');
model.sol('sol2').feature('t1').set('plot', 'off');
model.sol('sol2').feature('t1').set('plotgroup', 'pg1');
model.sol('sol2').feature('t1').set('plotfreq', 'tout');
model.sol('sol2').feature('t1').set('probesel', 'all');
model.sol('sol2').feature('t1').set('probes', {});
model.sol('sol2').feature('t1').set('probefreq', 'tsteps');
model.sol('sol2').feature('t1').set('rtol', 0.001);
model.sol('sol2').feature('t1').set('atolglobalvaluemethod', 'manual');
model.sol('sol2').feature('t1').set('atolglobalmethod', 'unscaled');
model.sol('sol2').feature('t1').set('atolglobal', 0.001);
model.sol('sol2').feature('t1').set('atolglobalvaluemethod', 'manual');
model.sol('sol2').feature('t1').set('reacf', true);
model.sol('sol2').feature('t1').set('storeudot', true);
model.sol('sol2').feature('t1').set('endtimeinterpolation', true);
model.sol('sol2').feature('t1').set('estrat', 'exclude');
model.sol('sol2').feature('t1').set('maxorder', 2);
model.sol('sol2').feature('t1').set('initialstepbdfactive', true);
model.sol('sol2').feature('t1').set('initialstepbdf', '(1.0E-13)[s]');
model.sol('sol2').feature('t1').set('control', 'time');
model.sol('sol2').feature('t1').feature('aDef').set('matherr', false);
model.sol('sol2').feature('t1').create('fc1', 'FullyCoupled');
model.sol('sol2').feature('t1').feature('fc1').set('jtech', 'once');
model.sol('sol2').feature('t1').create('d1', 'Direct');
model.sol('sol2').feature('t1').feature('d1').set('linsolver', 'pardiso');
model.sol('sol2').feature('t1').feature('fc1').set('linsolver', 'd1');
model.sol('sol2').feature('t1').feature('fc1').set('jtech', 'once');
model.sol('sol2').feature('t1').feature.remove('fcDef');
model.sol('sol2').attach('std2');
model.sol('sol2').runAll;

model.result('pg1').run;
model.result.duplicate('pg5', 'pg1');
model.result('pg5').run;
model.result.move('pg5', 3);
model.result.move('pg5', 2);
model.result.move('pg5', 1);
model.result('pg5').label('Electron and Ion Number Density - Negative Corona');
model.result('pg5').set('data', 'dset2');
model.result('pg5').run;
model.result('pg2').run;
model.result('pg2').run;
model.result('pg2').feature.duplicate('lngr2', 'lngr1');
model.result('pg2').run;
model.result('pg2').feature('lngr2').label('Negative Corona');
model.result('pg2').feature('lngr2').set('data', 'dset2');
model.result('pg2').feature('lngr2').setIndex('looplevelinput', 'last', 0);
model.result('pg2').feature('lngr2').set('expr', '-V');
model.result('pg2').run;
model.result('pg3').run;
model.result('pg3').run;
model.result('pg3').feature.duplicate('lngr2', 'lngr1');
model.result('pg3').run;
model.result('pg3').feature('lngr2').label('Negative Corona');
model.result('pg3').feature('lngr2').set('data', 'dset2');
model.result('pg3').feature('lngr2').setIndex('looplevelinput', 'last', 0);
model.result('pg3').run;
model.result('pg4').run;
model.result('pg4').feature.duplicate('lngr2', 'lngr1');
model.result('pg4').run;
model.result('pg4').feature('lngr2').label('Negative Corona');
model.result('pg4').feature('lngr2').set('data', 'dset2');
model.result('pg4').feature('lngr2').set('expr', 'plas.R_wn');
model.result('pg4').run;
model.result.numerical.create('pev1', 'EvalPoint');
model.result.numerical('pev1').setIndex('looplevelinput', 'last', 0);
model.result.numerical('pev1').selection.set([1]);
model.result.numerical('pev1').setIndex('expr', 'plas.Er', 0);
model.result.numerical('pev1').setIndex('unit', 'V/m', 0);
model.result.numerical('pev1').setIndex('descr', 'Electric field, r component', 0);
model.result.table.create('tbl1', 'Table');
model.result.table('tbl1').comments('Point Evaluation 1');
model.result.numerical('pev1').set('table', 'tbl1');
model.result.numerical('pev1').setResult;
model.result.numerical.duplicate('pev2', 'pev1');
model.result.numerical('pev2').set('data', 'dset2');
model.result.numerical('pev2').set('table', 'tbl1');
model.result.numerical('pev2').appendResult;

model.physics.create('es', 'Electrostatics', 'geom1');
model.physics('es').model('comp1');

model.study('std1').feature('time').setSolveFor('/physics/es', false);
model.study('std2').feature('time').setSolveFor('/physics/es', false);

model.physics('es').prop('ShapeProperty').set('order_electricpotential', '3');
model.physics.create('ct', 'ChargeTransport', 'geom1');
model.physics('ct').model('comp1');

model.study('std1').feature('time').setSolveFor('/physics/ct', false);
model.study('std2').feature('time').setSolveFor('/physics/ct', false);

model.multiphysics.create('scdc1', 'SpaceChargeDensityCoupling', 'geom1', 1);

model.study('std1').feature('time').setSolveFor('/multiphysics/scdc1', false);
model.study('std2').feature('time').setSolveFor('/multiphysics/scdc1', false);

model.multiphysics('scdc1').set('SpaceChargeDensitySource_physics', 'ct');
model.multiphysics('scdc1').set('SpaceChargeDensityDestination_physics', 'es');
model.multiphysics('scdc1').selection.all;
model.multiphysics.create('pc1', 'PotentialCoupling', 'geom1', 1);

model.study('std1').feature('time').setSolveFor('/multiphysics/pc1', false);
model.study('std2').feature('time').setSolveFor('/multiphysics/pc1', false);

model.multiphysics('pc1').set('PotentialSource_physics', 'es');
model.multiphysics('pc1').set('PotentialDestination_physics', 'ct');
model.multiphysics('pc1').selection.all;

model.physics('es').feature('ccn1').set('epsilonr_mat', 'userdef');
model.physics('es').create('gnd1', 'Ground', 0);
model.physics('es').feature('gnd1').selection.set([2]);
model.physics('ct').feature('tp1').set('T', 'T0');
model.physics('ct').feature('tp1').set('pA', 'P0');
model.physics('ct').feature('tp1').set('muiN', 'muiN');
model.physics('ct').feature('tp1').set('zq', 'cp');
model.physics('ct').feature('init1').set('rhoq', 'cp*1.0E-4[C/m^3]');

model.multiphysics.create('el1', 'Electrode', 'geom1', 0);
model.multiphysics('el1').selection.set([1]);
model.multiphysics('el1').set('V0', 'V0');
model.multiphysics('el1').set('Ec', 'cp*3e6[V/m]');
model.multiphysics('el1').set('rc', 'rin');

model.mesh.duplicate('mesh2', 'mesh1');
model.mesh('mesh2').feature('edg1').feature('dis1').set('elemcount', 300);
model.mesh('mesh2').feature('edg1').feature('dis1').set('elemratio', 100);
model.mesh('mesh2').run;

model.study.create('std3');
model.study('std3').create('stat', 'Stationary');
model.study('std3').feature('stat').setSolveFor('/physics/plas', false);
model.study('std3').feature('stat').setSolveFor('/physics/es', true);
model.study('std3').feature('stat').setSolveFor('/physics/ct', true);
model.study('std3').feature('stat').setSolveFor('/multiphysics/scdc1', true);
model.study('std3').feature('stat').setSolveFor('/multiphysics/pc1', true);
model.study('std3').feature('stat').setSolveFor('/multiphysics/el1', true);
model.study('std3').label('Positive Corona Simplified');
model.study('std3').setGenPlots(false);
model.study('std3').setGenConv(false);

model.param.set('cp', '+1');

model.sol.create('sol3');
model.sol('sol3').study('std3');
model.sol('sol3').create('st1', 'StudyStep');
model.sol('sol3').feature('st1').set('study', 'std3');
model.sol('sol3').feature('st1').set('studystep', 'stat');
model.sol('sol3').create('v1', 'Variables');
model.sol('sol3').feature('v1').set('control', 'stat');
model.sol('sol3').create('s1', 'Stationary');
model.sol('sol3').feature('s1').set('stol', 0.001);
model.sol('sol3').feature('s1').feature('aDef').set('complexfun', false);
model.sol('sol3').feature('s1').feature('aDef').set('cachepattern', false);
model.sol('sol3').feature('s1').feature('aDef').set('matherr', true);
model.sol('sol3').feature('s1').feature('aDef').set('blocksizeactive', false);
model.sol('sol3').feature('s1').create('seDef', 'Segregated');
model.sol('sol3').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol3').feature('s1').feature('fc1').set('rstep', 10);
model.sol('sol3').feature('s1').feature('fc1').set('useminsteprecovery', 'auto');
model.sol('sol3').feature('s1').feature('fc1').set('maxiter', 50);
model.sol('sol3').feature('s1').feature('fc1').set('minstep', 1.0E-4);
model.sol('sol3').feature('s1').feature('fc1').set('dtech', 'auto');
model.sol('sol3').feature('s1').feature('fc1').set('ntolfact', 1);
model.sol('sol3').feature('s1').feature('fc1').set('ntermauto', 'tol');
model.sol('sol3').feature('s1').feature('fc1').set('initstep', 1);
model.sol('sol3').feature('s1').feature('fc1').set('minsteprecovery', 0.75);
model.sol('sol3').feature('s1').create('d1', 'Direct');
model.sol('sol3').feature('s1').feature('d1').set('linsolver', 'mumps');
model.sol('sol3').feature('s1').feature('d1').set('ooc', 'auto');
model.sol('sol3').feature('s1').feature('d1').set('errorchk', 'auto');
model.sol('sol3').feature('s1').feature('d1').set('rhob', 1);
model.sol('sol3').feature('s1').feature('fc1').set('linsolver', 'd1');
model.sol('sol3').feature('s1').feature('fc1').set('rstep', 10);
model.sol('sol3').feature('s1').feature('fc1').set('useminsteprecovery', 'auto');
model.sol('sol3').feature('s1').feature('fc1').set('maxiter', 50);
model.sol('sol3').feature('s1').feature('fc1').set('minstep', 1.0E-4);
model.sol('sol3').feature('s1').feature('fc1').set('dtech', 'auto');
model.sol('sol3').feature('s1').feature('fc1').set('ntolfact', 1);
model.sol('sol3').feature('s1').feature('fc1').set('ntermauto', 'tol');
model.sol('sol3').feature('s1').feature('fc1').set('initstep', 1);
model.sol('sol3').feature('s1').feature('fc1').set('minsteprecovery', 0.75);
model.sol('sol3').feature('s1').feature.remove('fcDef');
model.sol('sol3').feature('s1').feature.remove('seDef');
model.sol('sol3').attach('std3');
model.sol('sol3').runAll;

model.result('pg2').run;
model.result('pg2').run;
model.result('pg2').feature.duplicate('lngr3', 'lngr1');
model.result('pg2').run;
model.result('pg2').feature('lngr3').label('Positive Corona Simplified');
model.result('pg2').feature('lngr3').set('data', 'dset3');
model.result('pg2').feature('lngr3').set('expr', 'V2');
model.result('pg2').run;
model.result('pg3').run;
model.result('pg3').run;
model.result('pg3').feature.duplicate('lngr3', 'lngr1');
model.result('pg3').run;
model.result('pg3').feature('lngr3').label('Positive Corona Simplified');
model.result('pg3').feature('lngr3').set('data', 'dset3');
model.result('pg3').feature('lngr3').set('expr', 'rhoq');
model.result('pg3').run;

model.param.set('cp', '-1');

model.physics('ct').create('st1', 'Source', 1);
model.physics('ct').feature('st1').selection.all;
model.physics('ct').feature('st1').set('SpecifySourceUsing', 'reactionRate');
model.physics('ct').feature('st1').set('R', '-plas.R_wn');

model.multiphysics('el1').set('ElectrodeElectricField', 'userdef');
model.multiphysics('el1').set('E0', '-5.9536E6');

model.study.create('std4');
model.study('std4').create('stat', 'Stationary');
model.study('std4').feature('stat').setSolveFor('/physics/plas', false);
model.study('std4').feature('stat').setSolveFor('/physics/es', true);
model.study('std4').feature('stat').setSolveFor('/physics/ct', true);
model.study('std4').feature('stat').setSolveFor('/multiphysics/scdc1', true);
model.study('std4').feature('stat').setSolveFor('/multiphysics/pc1', true);
model.study('std4').feature('stat').setSolveFor('/multiphysics/el1', true);
model.study('std4').feature('stat').set('usesol', true);
model.study('std4').feature('stat').set('notsolmethod', 'sol');
model.study('std4').feature('stat').set('notstudy', 'std2');
model.study('std4').label('Negative Corona Simplified');
model.study('std4').setGenPlots(false);
model.study('std4').setGenConv(false);

model.sol.create('sol4');
model.sol('sol4').study('std4');
model.sol('sol4').create('st1', 'StudyStep');
model.sol('sol4').feature('st1').set('study', 'std4');
model.sol('sol4').feature('st1').set('studystep', 'stat');
model.sol('sol4').create('v1', 'Variables');
model.sol('sol4').feature('v1').set('control', 'stat');
model.sol('sol4').create('s1', 'Stationary');
model.sol('sol4').feature('s1').set('stol', 0.001);
model.sol('sol4').feature('s1').feature('aDef').set('complexfun', false);
model.sol('sol4').feature('s1').feature('aDef').set('cachepattern', false);
model.sol('sol4').feature('s1').feature('aDef').set('matherr', true);
model.sol('sol4').feature('s1').feature('aDef').set('blocksizeactive', false);
model.sol('sol4').feature('s1').create('seDef', 'Segregated');
model.sol('sol4').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol4').feature('s1').feature('fc1').set('rstep', 10);
model.sol('sol4').feature('s1').feature('fc1').set('useminsteprecovery', 'auto');
model.sol('sol4').feature('s1').feature('fc1').set('maxiter', 50);
model.sol('sol4').feature('s1').feature('fc1').set('minstep', 1.0E-4);
model.sol('sol4').feature('s1').feature('fc1').set('dtech', 'auto');
model.sol('sol4').feature('s1').feature('fc1').set('ntolfact', 1);
model.sol('sol4').feature('s1').feature('fc1').set('ntermauto', 'tol');
model.sol('sol4').feature('s1').feature('fc1').set('initstep', 1);
model.sol('sol4').feature('s1').feature('fc1').set('minsteprecovery', 0.75);
model.sol('sol4').feature('s1').create('d1', 'Direct');
model.sol('sol4').feature('s1').feature('d1').set('linsolver', 'mumps');
model.sol('sol4').feature('s1').feature('d1').set('ooc', 'auto');
model.sol('sol4').feature('s1').feature('d1').set('errorchk', 'auto');
model.sol('sol4').feature('s1').feature('d1').set('rhob', 1);
model.sol('sol4').feature('s1').feature('fc1').set('linsolver', 'd1');
model.sol('sol4').feature('s1').feature('fc1').set('rstep', 10);
model.sol('sol4').feature('s1').feature('fc1').set('useminsteprecovery', 'auto');
model.sol('sol4').feature('s1').feature('fc1').set('maxiter', 50);
model.sol('sol4').feature('s1').feature('fc1').set('minstep', 1.0E-4);
model.sol('sol4').feature('s1').feature('fc1').set('dtech', 'auto');
model.sol('sol4').feature('s1').feature('fc1').set('ntolfact', 1);
model.sol('sol4').feature('s1').feature('fc1').set('ntermauto', 'tol');
model.sol('sol4').feature('s1').feature('fc1').set('initstep', 1);
model.sol('sol4').feature('s1').feature('fc1').set('minsteprecovery', 0.75);
model.sol('sol4').feature('s1').feature.remove('fcDef');
model.sol('sol4').feature('s1').feature.remove('seDef');
model.sol('sol4').attach('std4');
model.sol('sol4').runAll;

model.result('pg2').run;
model.result('pg2').run;
model.result('pg2').feature.duplicate('lngr4', 'lngr3');
model.result('pg2').run;
model.result('pg2').feature('lngr4').label('Negative Corona Simplified');
model.result('pg2').feature('lngr4').set('data', 'dset4');
model.result('pg2').feature('lngr4').set('expr', '-V2');
model.result('pg2').run;
model.result('pg3').run;
model.result('pg3').run;
model.result('pg3').feature.duplicate('lngr4', 'lngr3');
model.result('pg3').run;
model.result('pg3').feature('lngr4').label('Negative Corona Simplified');
model.result('pg3').feature('lngr4').set('data', 'dset4');
model.result('pg3').run;
model.result.numerical.duplicate('pev3', 'pev2');
model.result.numerical('pev3').set('data', 'dset3');
model.result.numerical('pev3').setIndex('expr', 'ct.Er', 0);
model.result.numerical('pev3').setIndex('unit', 'V/m', 0);
model.result.numerical('pev3').setIndex('descr', 'Electric field, r component', 0);
model.result.table.create('tbl2', 'Table');
model.result.table('tbl2').comments('Point Evaluation 3');
model.result.numerical('pev3').set('table', 'tbl2');
model.result.numerical('pev3').setResult;
model.result('pg1').run;
model.result('pg5').run;
model.result('pg2').run;
model.result('pg3').run;
model.result('pg4').run;

model.title('Positive and Negative Corona Discharges');

model.description(['This tutorial presents a study of positive and negative corona discharges in dry air at atmospheric pressure. The discharges are sustained within two electrodes in a coaxial configuration by a high voltage DC source applied to the inner electrode. Two different types of models are used: a full self-consistent plasma model and a simplified model. The plasma model solves the electron and ion continuity and momentum equations in the drift-diffusion approximation, self-consistently coupled with Poisson' native2unicode(hex2dec({'20' '19'}), 'unicode') 's equation. The local field approximation is used, which means that transport and source coefficients are assumed to be well parameterized through the reduced electric field. The simplified model uses a simplified charge transport model coupled with electrostatics to provide an approximate method of computing the charge density and the electrostatic field in corona discharges. The space charge density and the electric potential obtained with the simplified model are in good agreement with the simulation results obtained with the self-consistent plasma model.']);

model.mesh.clearMeshes;

model.sol('sol1').clearSolutionData;
model.sol('sol2').clearSolutionData;
model.sol('sol3').clearSolutionData;
model.sol('sol4').clearSolutionData;

model.label('positive_and_negative_corona_discharges.mph');

model.modelNode.label('Components');

out = model;
