function out = model
%
% bh_curve_checker.m
%
% Model exported on May 26 2025, 21:24 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/ACDC_Module/Applications');

model.param.set('Hmax', '318310');
model.param.descr('Hmax', 'Maximum magnetic field (A/m) of the original B-H curve');
model.param.set('Hmax2', 'Hmax');
model.param.descr('Hmax2', 'Hmax after optimization, to be updated in the application');

model.func.create('int1', 'Interpolation');
model.func('int1').setIndex('table', 0, 0, 0);
model.func('int1').setIndex('table', 0, 0, 1);
model.func('int1').setIndex('table', 663.146, 1, 0);
model.func('int1').setIndex('table', 1, 1, 1);
model.func('int1').setIndex('table', 1067.5, 2, 0);
model.func('int1').setIndex('table', 1.1, 2, 1);
model.func('int1').setIndex('table', 1705.23, 3, 0);
model.func('int1').setIndex('table', 1.2, 3, 1);
model.func('int1').setIndex('table', 2463.11, 4, 0);
model.func('int1').setIndex('table', 1.3, 4, 1);
model.func('int1').setIndex('table', 3841.67, 5, 0);
model.func('int1').setIndex('table', 1.4, 5, 1);
model.func('int1').setIndex('table', 5425.74, 6, 0);
model.func('int1').setIndex('table', 1.5, 6, 1);
model.func('int1').setIndex('table', 7957.75, 7, 0);
model.func('int1').setIndex('table', 1.6, 7, 1);
model.func('int1').setIndex('table', 12298.3, 8, 0);
model.func('int1').setIndex('table', 1.7, 8, 1);
model.func('int1').setIndex('table', 20462.8, 9, 0);
model.func('int1').setIndex('table', 1.8, 9, 1);
model.func('int1').setIndex('table', 32169.6, 10, 0);
model.func('int1').setIndex('table', 1.9, 10, 1);
model.func('int1').setIndex('table', 61213.4, 11, 0);
model.func('int1').setIndex('table', '2.0', 11, 1);
model.func('int1').setIndex('table', 111408, 12, 0);
model.func('int1').setIndex('table', 2.1, 12, 1);
model.func('int1').setIndex('table', 175070, 13, 0);
model.func('int1').setIndex('table', 2.2, 13, 1);
model.func('int1').setIndex('table', 261469, 14, 0);
model.func('int1').setIndex('table', 2.3, 14, 1);
model.func('int1').setIndex('table', 318310, 15, 0);
model.func('int1').setIndex('table', 2.4, 15, 1);
model.func('int1').set('extrap', 'linear');
model.func.duplicate('int2', 'int1');
model.func('int2').setIndex('table', 2.38, 15, 1);
model.func('int2').set('defineinv', true);
model.func.create('int3', 'Interpolation');
model.func('int3').setIndex('table', 0, 0, 0);
model.func('int3').setIndex('table', 0, 0, 1);
model.func('int3').setIndex('table', 1, 1, 0);
model.func('int3').setIndex('table', 1, 1, 1);
model.func('int3').setIndex('table', 2, 2, 0);
model.func('int3').setIndex('table', 2, 2, 1);
model.func('int3').setIndex('table', 'Hmax', 3, 0);
model.func('int3').setIndex('table', 1, 3, 1);
model.func.duplicate('int4', 'int3');
model.func('int4').setIndex('table', 4, 2, 1);
model.func('int1').label('Original B-H curve');
model.func('int2').label('Optimized B-H curve');
model.func('int3').label('Differential Relative Permeability of the Original Curve');
model.func('int3').set('funcname', 'd_int1');
model.func('int4').label('Differential Relative Permeability of the Optimized Curve');
model.func('int4').set('funcname', 'd_int2');
model.func('int1').createPlot('pg1');

model.result('pg1').run;

model.func('int2').createPlot('pg2');

model.result('pg2').run;
model.result('pg1').run;
model.result('pg1').feature('plot1').set('extrapolation', 'right');
model.result('pg1').feature('plot1').set('upperbound', 'Hmax');
model.result('pg2').run;
model.result('pg2').feature('plot1').set('data', 'int2_ds1');
model.result('pg2').feature('plot1').set('extrapolation', 'right');
model.result('pg2').feature('plot1').set('upperbound', 'Hmax2');
model.result('pg1').feature.copy('plot2', 'pg2/plot1');
model.result('pg2').feature.remove('plot1');
model.result('pg2').run;
model.result.remove('pg2');
model.result('pg1').run;
model.result('pg1').label('B-H Curves');
model.result('pg1').run;
model.result('pg1').feature('plot1').set('data', 'int1_ds1');
model.result('pg1').feature('plot1').label('Original data');
model.result('pg1').feature('plot1').set('linecolor', 'custom');
model.result('pg1').feature('plot1').set('customlinecolor', [0.21176470816135406 0.5490196347236633 0.7960784435272217]);
model.result('pg1').feature('plot1').set('pointcolor', 'custom');
model.result('pg1').feature('plot1').set('custompointcolor', [0.21176470816135406 0.5490196347236633 0.7960784435272217]);
model.result('pg1').feature('plot1').set('extrapolationcolor', 'custom');
model.result('pg1').feature('plot1').set('customextrapolationcolor', [0.21176470816135406 0.5490196347236633 0.7960784435272217]);
model.result('pg1').run;
model.result('pg1').feature('plot2').label('Optimized Data');
model.result('pg1').feature('plot2').set('linecolor', 'red');
model.result('pg1').feature('plot2').set('pointcolor', 'red');

model.func('int3').createPlot('pg2');

model.result('pg2').run;

model.func('int4').createPlot('pg3');

model.result('pg3').run;
model.result('pg2').run;
model.result('pg2').label('Differential Relative Permeability');
model.result('pg2').run;
model.result('pg2').feature('plot1').label('Original Data');
model.result('pg2').feature('plot1').set('upperbound', 'Hmax');
model.result('pg2').feature('plot1').set('linecolor', 'custom');
model.result('pg2').feature('plot1').set('customlinecolor', [0.21176470816135406 0.5490196347236633 0.7960784435272217]);
model.result('pg2').feature('plot1').set('pointcolor', 'custom');
model.result('pg2').feature('plot1').set('custompointcolor', [0.21176470816135406 0.5490196347236633 0.7960784435272217]);
model.result('pg2').feature('plot1').set('extrapolationcolor', 'custom');
model.result('pg2').feature('plot1').set('customextrapolationcolor', [0.21176470816135406 0.5490196347236633 0.7960784435272217]);
model.result('pg3').run;
model.result('pg3').feature('plot1').label('Optimized Data');
model.result('pg3').feature('plot1').set('data', 'int4_ds1');
model.result('pg3').feature('plot1').set('upperbound', 'Hmax2');
model.result('pg3').feature('plot1').set('linecolor', 'red');
model.result('pg3').feature('plot1').set('pointcolor', 'red');
model.result('pg2').feature.copy('plot2', 'pg3/plot1');
model.result('pg3').feature.remove('plot1');
model.result('pg3').run;
model.result.remove('pg3');
model.result.dataset('int1_ds1').set('parmin1', 0);
model.result.dataset('int1_ds1').set('parmax1', 'Hmax*1.2');
model.result.dataset('int2_ds1').set('parmin1', 0);
model.result.dataset('int2_ds1').set('parmax1', 'Hmax2*1.2');
model.result.dataset('int3_ds1').set('parmin1', 0);
model.result.dataset('int3_ds1').set('parmax1', 'Hmax*1.2');
model.result.dataset('int4_ds1').set('parmin1', 0);
model.result.dataset('int4_ds1').set('parmax1', 'Hmax2*1.2');
model.result.dataset.duplicate('ptds5', 'ptds1');
model.result.dataset('ptds5').label('Interpolation for Smooth');
model.result.dataset('ptds5').set('pointx', '10^{range(log10(1),1/20,log10(Hmax))} Hmax');
model.result.dataset.duplicate('int1_ds2', 'int1_ds1');
model.result.dataset('int1_ds2').label('Grid 1D Used for Extrapolation');
model.result.dataset('int1_ds2').set('parmax1', 'Hmax2*1.2');
model.result.dataset.duplicate('ptds6', 'ptds5');
model.result.dataset('ptds6').label('Interpolation for Extrapolation');
model.result.dataset('ptds6').set('data', 'int1_ds2');
model.result.dataset('ptds6').set('pointx', '10^{range(log10(Hmax2/10),1/20,log10(Hmax2))}');
model.result.dataset.duplicate('ptds7', 'ptds5');
model.result.dataset('ptds7').label('Inverse Interpolation for Well-Defined BH Values');
model.result.dataset('ptds7').set('data', 'int2_ds1');
model.result.dataset('ptds7').set('pointx', '2.1 2.2 2.3 2.4');
model.result.numerical.create('pev1', 'EvalPoint');
model.result.numerical('pev1').set('data', 'ptds5');
model.result.numerical('pev1').setIndex('expr', 't', 0);
model.result.numerical('pev1').setIndex('unit', 's', 0);
model.result.numerical.create('pev2', 'EvalPoint');
model.result.numerical('pev2').set('data', 'ptds5');
model.result.numerical('pev2').setIndex('expr', 'int1(t)', 0);
model.result.numerical.create('pev3', 'EvalPoint');
model.result.numerical('pev3').set('data', 'ptds6');
model.result.numerical('pev3').setIndex('expr', 't', 0);
model.result.numerical('pev3').setIndex('unit', 's', 0);
model.result.numerical.create('pev4', 'EvalPoint');
model.result.numerical('pev4').set('data', 'ptds7');
model.result.numerical('pev4').setIndex('expr', 'int2_inv(t)', 0);
model.result.numerical('pev4').setIndex('descr', 'Inverse interpolation', 0);
model.result('pg1').run;
model.result('pg1').set('xlabelactive', true);
model.result('pg1').set('xlabel', 'Magnetic field <b>H</b>, A/m');
model.result('pg1').set('ylabel', 'Magnetic flux density <b>B</b>, T');
model.result('pg2').run;
model.result('pg2').set('xlabelactive', true);
model.result('pg2').set('xlabel', 'Magnetic field <b>H</b>, A/m');
model.result('pg2').set('ylabel', 'Differential relative permeability \partial <b>B</b>/\partial <b>H</b>/\mu<sub>0</sub>');
model.result('pg2').set('xlog', true);
model.result('pg2').set('ylog', true);
model.result('pg2').set('titletype', 'none');
model.result('pg1').run;
model.result('pg1').set('titletype', 'none');

model.title([]);

model.description('');

model.label('bh_curve_checker_embedded.mph');

model.result('pg1').run;

model.title('B-H Curve Checker');

model.description(['This app demonstrates the following:' newline  newline  native2unicode(hex2dec({'20' '22'}), 'unicode') ' Importing measured data from a text file' newline  native2unicode(hex2dec({'20' '22'}), 'unicode') ' Handling measured data using methods' newline  native2unicode(hex2dec({'20' '22'}), 'unicode') ' Exporting the results to a text file.' newline  newline 'The app can be used to verify and optimize B-H curves using experimental data. It also generates curve data in the over-fluxed region, where measurement are difficult to perform. It removes the unphysical ripples of the slope of the B-H curve that might cause numerical instability.' newline  newline 'The original B-H curve is evaluated from two aspects. Firstly, to verify that the extrapolation of the curve is reasonable from the physical point of view. Secondly, to check if the slope of the curve is smooth. The optimization algorithms are mainly based on the simultaneous exponential extrapolation method and the linear interpolation method, respectively.' newline  newline 'The app requires the original curve data defined in a text input file. Once the curve is imported, the application checks if optimization is required. By clicking the ''Optimize Curve'' button, the user can generate the optimized curve data, which can be exported to a text file.']);

model.mesh.clearMeshes;

model.label('bh_curve_checker.mph');

model.modelNode.label('Components');

out = model;
