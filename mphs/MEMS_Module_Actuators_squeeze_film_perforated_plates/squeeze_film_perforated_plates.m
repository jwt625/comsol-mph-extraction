function out = model
%
% squeeze_film_perforated_plates.m
%
% Model exported on May 26 2025, 21:30 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/MEMS_Module/Actuators');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 2);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.physics.create('tff', 'ThinFilmFlowDomain', 'geom1');
model.physics('tff').model('comp1');

model.study.create('std1');
model.study('std1').create('freq', 'Frequency');
model.study('std1').feature('freq').setSolveFor('/physics/tff', true);

model.geom('geom1').lengthUnit([native2unicode(hex2dec({'00' 'b5'}), 'unicode') 'm']);

% To import content from file, use:
% model.param.loadFile('FILENAME');
model.param.set('M_h', '36', 'num of holes along length');
model.param.set('N_h', '6', 'num of holes along width');
model.param.set('h0', '1.6[um]', 'Gap height');
model.param.set('l_h', '15[um]', 'length of hole (thickness of plate)');
model.param.set('l_pl', '370[um]', 'length of plate');
model.param.set('w_pl', '65[um]', 'width of plate');
model.param.set('s_h', '6[um]', 'Side of square hole');
model.param.set('s_1', 'w_pl/(N_h+1)-s_h', 'distance between holes');
model.param.set('s_2', 's_1+s_h/2', 'distance between hole and edge of plate');
model.param.set('s1p', 'l_pl/(M_h+1)-s_h');
model.param.set('s2p', 's1p+s_h/2');
model.param.set('pitch__', 's_h+s_1');
model.param.set('l_per', 'l_pl-2*(s2p-s1p)', 'length of perforated region');
model.param.set('w_per', 'w_pl-2*(s_2-s_1)', 'width of perforated region');
model.param.set('r0', 'sqrt(l_per*w_per/M_h/N_h/pi)', 'unit disc radius');
model.param.set('ri', 's_h/sqrt(pi)', 'equivalent radius of hole');
model.param.set('dhND', '0.05', 'Fractional gap height change');
model.param.set('dh', 'dhND*h0', 'Change in gap height');
model.param.set('mu0', '1.8e-5[Pa*s]', 'Gas viscosity');
model.param.set('f0', '10000[Hz]', 'Vibration frequency');
model.param.set('vf', '2*pi*f0*dh', 'velocity of wall');
model.param.set('pRef', '1[atm]');

model.geom('geom1').create('r1', 'Rectangle');
model.geom('geom1').feature('r1').set('size', {'l_pl' 'w_pl'});
model.geom('geom1').run('r1');
model.geom('geom1').create('r2', 'Rectangle');
model.geom('geom1').feature('r2').set('size', {'l_per' 'w_per'});
model.geom('geom1').feature('r2').set('pos', {'s2p-s1p' 's_2-s_1'});

model.material.create('mat1', 'Common', '');

model.geom('geom1').run;

model.material.create('matlnk1', 'Link', 'comp1');
model.material('mat1').propertyGroup('def').set('dynamicviscosity', {'mu0'});

model.physics('tff').label('Thin-Film Flow, Domain - no perforation');
model.physics('tff').prop('EquationType').set('EquationType', 'ModifiedReynoldsEquation');
model.physics('tff').prop('ReferencePressure').set('pref', 'pRef');
model.physics('tff').feature('ffp1').set('hw1', 'h0');
model.physics('tff').feature('ffp1').set('TangentialWallVelocity', 'userdef');
model.physics('tff').feature('ffp1').set('vw', {'0' '0' 'vf'});
model.physics.create('tff2', 'ThinFilmFlowDomain', 'geom1');
model.physics('tff2').model('comp1');

model.study('std1').feature('freq').setSolveFor('/physics/tff2', true);

model.physics('tff2').label('Thin-Film Flow, Domain - Bao model');
model.physics('tff2').prop('EquationType').set('EquationType', 'ModifiedReynoldsEquation');
model.physics('tff2').prop('ReferencePressure').set('pref', 'pRef');
model.physics('tff2').feature('ffp1').set('hw1', 'h0');
model.physics('tff2').feature('ffp1').set('TangentialWallVelocity', 'userdef');
model.physics('tff2').feature('ffp1').set('vw', {'0' '0' 'vf'});
model.physics('tff2').create('perf1', 'Perforations', 2);
model.physics('tff2').feature('perf1').selection.set([2]);
model.physics('tff2').feature('perf1').set('PerforationAdmittance', 'Bao_model');
model.physics('tff2').feature('perf1').set('s_h', 's_h');
model.physics('tff2').feature('perf1').set('l_h', 'l_h');
model.physics('tff2').feature('perf1').set('n_h', '1/(l_per*w_per/M_h/N_h)');

model.cpl.create('intop1', 'Integration', 'geom1');
model.cpl('intop1').set('axisym', true);
model.cpl('intop1').selection.all;

model.variable.create('var1');
model.variable('var1').model('comp1');
model.variable('var1').set('f_tot_no_perf', 'intop1(tff.fwallz)');
model.variable('var1').descr('f_tot_no_perf', 'Total force without perforation');
model.variable('var1').set('f_tot_Bao', 'intop1(tff2.fwallz)');
model.variable('var1').descr('f_tot_Bao', 'Total force with perforation; Bao''s model');

model.func.create('int1', 'Interpolation');
model.func('int1').model('comp1');
model.func('int1').label('Interpolation of experimental data');
model.func('int1').set('source', 'file');
model.func('int1').set('filename', 'squeeze_film_perforated_plates_exp_data.txt');
model.func('int1').importData;
model.func('int1').set('interp', 'neighbor');
model.func('int1').setIndex('argunit', 1, 0);
model.func('int1').setIndex('fununit', 'uN*s/m', 0);

model.modelNode.create('comp2', true);

model.geom.create('geom2', 2);
model.geom('geom2').model('comp2');

model.mesh.create('mesh2', 'geom2');

model.geom('geom2').lengthUnit([native2unicode(hex2dec({'00' 'b5'}), 'unicode') 'm']);
model.geom('geom2').create('r1', 'Rectangle');
model.geom('geom2').feature('r1').set('size', {'l_pl' 'w_pl'});
model.geom('geom2').run('r1');
model.geom('geom2').create('sq1', 'Square');
model.geom('geom2').feature('sq1').set('size', 's_h');
model.geom('geom2').feature('sq1').set('pos', {'s2p' 's_2'});
model.geom('geom2').run('sq1');
model.geom('geom2').create('arr1', 'Array');
model.geom('geom2').feature('arr1').selection('input').set({'sq1'});
model.geom('geom2').feature('arr1').set('fullsize', {'M_h' 'N_h'});
model.geom('geom2').feature('arr1').set('displ', {'s_h+s1p' 's_h+s_1'});
model.geom('geom2').feature('arr1').set('selresult', true);
model.geom('geom2').run('arr1');
model.geom('geom2').create('dif1', 'Difference');
model.geom('geom2').feature('dif1').selection('input').set({'r1'});
model.geom('geom2').feature('dif1').selection('input2').named('arr1');
model.geom('geom2').runPre('fin');
model.geom('geom2').run;

model.material.create('matlnk2', 'Link', 'comp2');

model.physics.create('tff3', 'ThinFilmFlowDomain', 'geom2');
model.physics('tff3').model('comp2');

model.study('std1').feature('freq').setSolveFor('/physics/tff3', true);

model.physics('tff3').label('Thin-Film Flow, Domain - P = 0 at perf');
model.physics('tff3').prop('EquationType').set('EquationType', 'ModifiedReynoldsEquation');
model.physics('tff3').prop('ReferencePressure').set('pref', 'pRef');
model.physics('tff3').feature('ffp1').set('hw1', 'h0');
model.physics('tff3').feature('ffp1').set('TangentialWallVelocity', 'userdef');
model.physics('tff3').feature('ffp1').set('vw', {'0' '0' 'vf'});

model.cpl.create('intop2', 'Integration', 'geom2');
model.cpl('intop2').set('axisym', true);
model.cpl('intop2').selection.all;

model.variable.create('var2');
model.variable('var2').model('comp2');
model.variable('var2').set('f_tot_p0', 'intop2(tff3.fwallz)');
model.variable('var2').descr('f_tot_p0', 'Total force with zero relative pressure at perforations');

model.study('std1').create('param', 'Parametric');
model.study('std1').feature('param').set('plistarr', {'3 3 3 3 3 3 3 3 3 3 3 3 1.6 1.6 1.6 1.6 1.6 1.6' '55 55 115 115 185 185 376 376 376 376 376 376 370 370 370 370 370 370' '55 55 115 115 185 185 99 99 99 99 158 277 65 65 65 65 120 240' '7.2 12.6 7.2 12.6 7.2 12.6 7.2 9.3 10.7 12.6 7.2 7.2 5 6 7 8 6 6' '2 2 5 5 8 8 18 18 18 18 18 18 36 36 36 36 36 36' '2 2 5 5 8 8 4 4 4 4 7 13 6 6 6 6 12 24' '71 79 41 46 22 28 20 21 21 22 17 14 200 200 210 220 170 140' '6.3 6.3 6.3 6.3 6.3 6.3 6.3 6.3 6.3 6.3 6.3 6.3 15 15 15 15 15 15'});
model.study('std1').feature('param').set('pname', {'h0' 'l_pl' 'w_pl' 's_h' 'M_h' 'N_h' 'f0' 'l_h'});
model.study('std1').feature('param').set('punit', {'um' 'um' 'um' 'um' '' '' 'kHz' 'um'});
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
model.sol('sol1').feature('s1').feature('aDef').set('cachepattern', true);
model.sol('sol1').feature('s1').create('seDef', 'Segregated');
model.sol('sol1').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('s1').feature('fc1').set('dtech', 'auto');
model.sol('sol1').feature('s1').feature('fc1').set('initstep', 0.01);
model.sol('sol1').feature('s1').feature('fc1').set('minstep', 1.0E-6);
model.sol('sol1').feature('s1').feature('fc1').set('maxiter', 50);
model.sol('sol1').feature('s1').create('d1', 'Direct');
model.sol('sol1').feature('s1').feature('d1').set('linsolver', 'pardiso');
model.sol('sol1').feature('s1').feature('d1').set('pivotperturb', 1.0E-13);
model.sol('sol1').feature('s1').feature('d1').label('Direct, pressure (tff) (Merged)');
model.sol('sol1').feature('s1').feature('fc1').set('linsolver', 'd1');
model.sol('sol1').feature('s1').feature('fc1').set('dtech', 'auto');
model.sol('sol1').feature('s1').feature('fc1').set('initstep', 0.01);
model.sol('sol1').feature('s1').feature('fc1').set('minstep', 1.0E-6);
model.sol('sol1').feature('s1').feature('fc1').set('maxiter', 50);
model.sol('sol1').feature('s1').feature.remove('fcDef');
model.sol('sol1').feature('s1').feature.remove('seDef');
model.sol('sol1').attach('std1');

model.batch.create('p1', 'Parametric');
model.batch('p1').study('std1');
model.batch('p1').create('so1', 'Solutionseq');
model.batch('p1').feature('so1').set('seq', 'sol1');
model.batch('p1').feature('so1').set('store', 'on');
model.batch('p1').feature('so1').set('clear', 'on');
model.batch('p1').feature('so1').set('psol', 'none');
model.batch('p1').set('pname', {'h0' 'l_pl' 'w_pl' 's_h' 'M_h' 'N_h' 'f0' 'l_h'});
model.batch('p1').set('plistarr', {'3 3 3 3 3 3 3 3 3 3 3 3 1.6 1.6 1.6 1.6 1.6 1.6' '55 55 115 115 185 185 376 376 376 376 376 376 370 370 370 370 370 370' '55 55 115 115 185 185 99 99 99 99 158 277 65 65 65 65 120 240' '7.2 12.6 7.2 12.6 7.2 12.6 7.2 9.3 10.7 12.6 7.2 7.2 5 6 7 8 6 6' '2 2 5 5 8 8 18 18 18 18 18 18 36 36 36 36 36 36' '2 2 5 5 8 8 4 4 4 4 7 13 6 6 6 6 12 24' '71 79 41 46 22 28 20 21 21 22 17 14 200 200 210 220 170 140' '6.3 6.3 6.3 6.3 6.3 6.3 6.3 6.3 6.3 6.3 6.3 6.3 15 15 15 15 15 15'});
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

model.result.create('pg1', 'PlotGroup2D');
model.result('pg1').label('Fluid Pressure (tff)');
model.result('pg1').set('data', 'dset3');
model.result('pg1').setIndex('looplevel', 1, 0);
model.result('pg1').setIndex('looplevel', 18, 1);
model.result('pg1').set('data', 'dset3');
model.result('pg1').setIndex('looplevel', 1, 0);
model.result('pg1').setIndex('looplevel', 18, 1);
model.result('pg1').set('defaultPlotID', 'ThinFilmFlowDomain/phys1/pdef1/pg1');
model.result('pg1').feature.create('surf1', 'Surface');
model.result('pg1').feature('surf1').set('showsolutionparams', 'on');
model.result('pg1').feature('surf1').set('smooth', 'internal');
model.result('pg1').feature('surf1').set('showsolutionparams', 'on');
model.result('pg1').feature('surf1').set('data', 'parent');
model.result.create('pg2', 'PlotGroup2D');
model.result('pg2').label('Fluid Pressure (tff2)');
model.result('pg2').set('data', 'dset3');
model.result('pg2').setIndex('looplevel', 1, 0);
model.result('pg2').setIndex('looplevel', 18, 1);
model.result('pg2').set('data', 'dset3');
model.result('pg2').setIndex('looplevel', 1, 0);
model.result('pg2').setIndex('looplevel', 18, 1);
model.result('pg2').set('defaultPlotID', 'ThinFilmFlowDomain/phys1/pdef1/pg1');
model.result('pg2').feature.create('surf1', 'Surface');
model.result('pg2').feature('surf1').set('showsolutionparams', 'on');
model.result('pg2').feature('surf1').set('expr', 'pfilm2');
model.result('pg2').feature('surf1').set('smooth', 'internal');
model.result('pg2').feature('surf1').set('showsolutionparams', 'on');
model.result('pg2').feature('surf1').set('data', 'parent');
model.result.create('pg3', 'PlotGroup2D');
model.result('pg3').label('Fluid Pressure (tff3)');
model.result('pg3').set('data', 'dset4');
model.result('pg3').setIndex('looplevel', 1, 0);
model.result('pg3').setIndex('looplevel', 18, 1);
model.result('pg3').set('data', 'dset4');
model.result('pg3').setIndex('looplevel', 1, 0);
model.result('pg3').setIndex('looplevel', 18, 1);
model.result('pg3').set('defaultPlotID', 'ThinFilmFlowDomain/phys1/pdef1/pg1');
model.result('pg3').feature.create('surf1', 'Surface');
model.result('pg3').feature('surf1').set('showsolutionparams', 'on');
model.result('pg3').feature('surf1').set('smooth', 'internal');
model.result('pg3').feature('surf1').set('showsolutionparams', 'on');
model.result('pg3').feature('surf1').set('data', 'parent');
model.result('pg1').run;
model.result('pg1').label('2D Plot Group 1 - no perf');
model.result('pg2').run;
model.result('pg2').label('2D Plot Group 2 - Bao model');
model.result('pg3').run;
model.result('pg3').label('2D Plot Group 3 - P=0 at perf');
model.result.create('pg4', 'PlotGroup1D');
model.result('pg4').run;
model.result('pg4').label('Damping coefficients');
model.result('pg4').set('data', 'dset3');
model.result('pg4').set('titletype', 'manual');
model.result('pg4').set('title', 'Damping coefficients(N*s/m): compare with experimental data');
model.result('pg4').set('ylabelactive', true);
model.result('pg4').set('ylabel', 'Damping coefficients');
model.result('pg4').set('ylog', true);
model.result('pg4').set('legendpos', 'upperleft');
model.result('pg4').create('glob1', 'Global');
model.result('pg4').feature('glob1').set('markerpos', 'datapoints');
model.result('pg4').feature('glob1').set('linewidth', 'preference');
model.result('pg4').feature('glob1').setIndex('expr', 'abs(f_tot_no_perf)/vf', 0);
model.result('pg4').feature('glob1').setIndex('descr', 'No perf', 0);
model.result('pg4').feature('glob1').setIndex('expr', 'abs(f_tot_Bao)/vf', 1);
model.result('pg4').feature('glob1').setIndex('descr', 'Bao model', 1);
model.result('pg4').feature('glob1').set('xdatasolnumtype', 'all');
model.result('pg4').feature('glob1').set('linestyle', 'cycle');
model.result('pg4').feature('glob1').set('linemarker', 'cycle');
model.result('pg4').feature.duplicate('glob2', 'glob1');
model.result('pg4').run;
model.result('pg4').feature('glob2').set('data', 'dset4');
model.result('pg4').feature('glob2').set('expr', {});
model.result('pg4').feature('glob2').set('descr', {});
model.result('pg4').feature('glob2').setIndex('expr', 'abs(f_tot_p0)/vf', 0);
model.result('pg4').feature('glob2').setIndex('descr', 'P=0 at perf', 0);

model.func('int1').createPlot('pg5');

model.result('pg5').run;
model.result('pg5').run;
model.result('pg5').feature('plot1').set('data', 'int1_ds1');
model.result('pg4').run;
model.result('pg4').feature.copy('plot1', 'pg5/plot1');
model.result('pg4').run;
model.result('pg4').feature('plot1').set('unit', 'N*s/m');
model.result('pg4').feature('plot1').set('display', 'points');
model.result('pg4').feature('plot1').set('linewidth', 6);
model.result('pg4').run;

model.title('Squeeze-Film Damping of Perforated Plates');

model.description('This benchmark model compares the damping coefficients of perforated plates from computation results versus experimental data. The simulation includes 18 different geometric configurations. It uses the Bao''s perforation model, which is built-in in the Thin Film Flow physics interface. Two limiting cases are also simulated: no perforation and zero relative pressure at the perforations.');

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

model.label('squeeze_film_perforated_plates.mph');

model.modelNode.label('Components');

out = model;
