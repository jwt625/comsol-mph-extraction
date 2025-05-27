function out = model
%
% h_bend_waveguide_2d.m
%
% Model exported on May 26 2025, 21:32 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/RF_Module/Transmission_Lines_and_Waveguides');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 2);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.physics.create('emw', 'ElectromagneticWaves', 'geom1');
model.physics('emw').model('comp1');

model.study.create('std1');
model.study('std1').create('freq', 'Frequency');
model.study('std1').feature('freq').set('solnum', 'auto');
model.study('std1').feature('freq').set('notsolnum', 'auto');
model.study('std1').feature('freq').set('outputmap', {});
model.study('std1').feature('freq').set('ngenAUX', '1');
model.study('std1').feature('freq').set('goalngenAUX', '1');
model.study('std1').feature('freq').set('ngenAUX', '1');
model.study('std1').feature('freq').set('goalngenAUX', '1');
model.study('std1').feature('freq').setSolveFor('/physics/emw', true);

model.geom('geom1').run;

model.study('std1').feature('freq').set('plist', 'range(4[GHz],25[MHz],5.2[GHz])');

model.geom('geom1').create('c1', 'Circle');
model.geom('geom1').feature('c1').set('r', 0.08);
model.geom('geom1').run('c1');
model.geom('geom1').create('c2', 'Circle');
model.geom('geom1').feature('c2').set('r', 0.04);
model.geom('geom1').run('c2');
model.geom('geom1').create('sq1', 'Square');
model.geom('geom1').feature('sq1').set('size', 0.08);
model.geom('geom1').feature('sq1').set('pos', [0 -0.08]);
model.geom('geom1').run('sq1');
model.geom('geom1').create('co1', 'Compose');
model.geom('geom1').feature('co1').selection('input').set({'c1' 'c2' 'sq1'});
model.geom('geom1').feature('co1').set('formula', 'sq1*(c1-c2)');
model.geom('geom1').run('co1');
model.geom('geom1').create('r1', 'Rectangle');
model.geom('geom1').feature('r1').set('size', [0.04 0.1]);
model.geom('geom1').feature('r1').set('pos', [0.04 0]);
model.geom('geom1').run('r1');
model.geom('geom1').create('r2', 'Rectangle');
model.geom('geom1').feature('r2').set('size', [0.1 0.04]);
model.geom('geom1').feature('r2').set('pos', [-0.1 -0.08]);
model.geom('geom1').runPre('fin');
model.geom('geom1').run;

model.material.create('mat1', 'Common', 'comp1');
model.material('mat1').label('Air');
model.material('mat1').selection.set([1 3]);
model.material('mat1').propertyGroup.create('RefractiveIndex', 'Refractive_index');
model.material('mat1').propertyGroup('RefractiveIndex').set('n', {'1'});
model.material.create('mat2', 'Common', 'comp1');
model.material('mat2').label('Silica Glass');
model.material('mat2').selection.set([2]);
model.material('mat2').propertyGroup.create('RefractiveIndex', 'Refractive_index');
model.material('mat2').propertyGroup('RefractiveIndex').set('n', {'1.44'});

model.physics('emw').prop('components').set('components', 'outofplane');
model.physics('emw').feature('wee1').set('DisplacementFieldModel', 'RefractiveIndex');
model.physics('emw').create('port1', 'Port', 1);
model.physics('emw').feature('port1').selection.set([1]);
model.physics('emw').feature('port1').set('PortType', 'Rectangular');
model.physics('emw').create('port2', 'Port', 1);
model.physics('emw').feature('port2').selection.set([7]);
model.physics('emw').feature('port2').set('PortType', 'Rectangular');

model.mesh('mesh1').run;

model.sol.create('sol1');
model.sol('sol1').study('std1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'freq');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').set('control', 'freq');
model.sol('sol1').create('s1', 'Stationary');
model.sol('sol1').feature('s1').set('stol', 0.01);
model.sol('sol1').feature('s1').create('p1', 'Parametric');
model.sol('sol1').feature('s1').feature.remove('pDef');
model.sol('sol1').feature('s1').feature('p1').set('pname', {'freq'});
model.sol('sol1').feature('s1').feature('p1').set('plistarr', {'range(4[GHz],25[MHz],5.2[GHz])'});
model.sol('sol1').feature('s1').feature('p1').set('punit', {'GHz'});
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
model.sol('sol1').feature('s1').feature('d1').set('linsolver', 'pardiso');
model.sol('sol1').feature('s1').feature('d1').label('Suggested Direct Solver (emw)');
model.sol('sol1').feature('s1').feature('fc1').set('linsolver', 'd1');
model.sol('sol1').feature('s1').feature.remove('fcDef');
model.sol('sol1').attach('std1');
model.sol('sol1').runAll;

model.result.create('pg1', 'PlotGroup2D');
model.result('pg1').label('Electric Field (emw)');
model.result('pg1').set('frametype', 'spatial');
model.result('pg1').set('showlegendsmaxmin', true);
model.result('pg1').set('data', 'dset1');
model.result('pg1').setIndex('looplevel', 49, 0);
model.result('pg1').set('defaultPlotID', 'ElectromagneticWaves/phys1/pdef1/pcond2/pg1');
model.result('pg1').feature.create('surf1', 'Surface');
model.result('pg1').feature('surf1').label('Surface');
model.result('pg1').feature('surf1').set('smooth', 'internal');
model.result('pg1').feature('surf1').set('data', 'parent');
model.result.create('pg2', 'PlotGroup1D');
model.result('pg2').set('data', 'dset1');
model.result('pg2').create('glob1', 'Global');
model.result('pg2').feature('glob1').set('unit', {'' ''});
model.result('pg2').feature('glob1').set('expr', {'emw.S11dB' 'emw.S21dB'});
model.result('pg2').feature('glob1').set('descr', {'S11' 'S21'});
model.result('pg2').label('S-parameter (emw)');
model.result('pg2').feature('glob1').set('titletype', 'none');
model.result('pg2').feature('glob1').set('xdata', 'expr');
model.result('pg2').set('ylabelactive', true);
model.result('pg2').set('ylabel', 'S-parameter (dB)');
model.result('pg2').feature('glob1').set('xdataexpr', 'freq');
model.result('pg2').feature('glob1').set('xdataunit', 'GHz');
model.result('pg2').feature('glob1').set('markerpos', 'datapoints');
model.result('pg2').feature('glob1').set('xdatasolnumtype', 'all');
model.result.create('pg3', 'SmithGroup');
model.result('pg3').set('data', 'dset1');
model.result('pg3').create('rgr1', 'ReflectionGraph');
model.result('pg3').feature('rgr1').set('unit', {''});
model.result('pg3').feature('rgr1').set('expr', {'emw.S11'});
model.result('pg3').feature('rgr1').set('descr', {'S11'});
model.result('pg3').label('Smith Plot (emw)');
model.result('pg3').feature('rgr1').set('titletype', 'manual');
model.result('pg3').feature('rgr1').set('title', 'Reflection Graph: S-parameter, Color: Frequency (GHz)');
model.result('pg3').feature('rgr1').set('linemarker', 'point');
model.result('pg3').feature('rgr1').set('markerpos', 'datapoints');
model.result('pg3').feature('rgr1').create('col1', 'Color');
model.result('pg3').feature('rgr1').feature('col1').set('expr', 'emw.freq/1e9');
model.result('pg3').feature('rgr1').feature('col1').set('colortable', 'Spectrum');
model.result('pg1').run;
model.result('pg1').setIndex('looplevel', 10, 0);
model.result('pg1').run;
model.result('pg2').run;
model.result('pg2').feature('glob1').set('linemarker', 'cycle');
model.result('pg2').feature('glob1').set('markerpos', 'interp');
model.result('pg2').run;
model.result('pg3').run;

model.study.create('std2');
model.study('std2').create('fdss', 'FrequencyDomainSourceSweep');
model.study('std2').feature('fdss').set('plotgroup', 'Default');
model.study('std2').feature('fdss').set('solnum', 'auto');
model.study('std2').feature('fdss').set('notsolnum', 'auto');
model.study('std2').feature('fdss').set('outputmap', {});
model.study('std2').feature('fdss').set('ngenAUX', '1');
model.study('std2').feature('fdss').set('goalngenAUX', '1');
model.study('std2').feature('fdss').set('ngenAUX', '1');
model.study('std2').feature('fdss').set('goalngenAUX', '1');
model.study('std2').feature('fdss').setSolveFor('/physics/emw', true);
model.study('std2').feature('fdss').set('plist', '5.1[GHz]');

model.sol.create('sol2');
model.sol('sol2').study('std2');
model.sol('sol2').create('st1', 'StudyStep');
model.sol('sol2').feature('st1').set('study', 'std2');
model.sol('sol2').feature('st1').set('studystep', 'fdss');
model.sol('sol2').create('v1', 'Variables');
model.sol('sol2').feature('v1').set('control', 'fdss');
model.sol('sol2').create('s1', 'Stationary');
model.sol('sol2').feature('s1').set('stol', 0.01);
model.sol('sol2').feature('s1').create('p1', 'Parametric');
model.sol('sol2').feature('s1').feature.remove('pDef');
model.sol('sol2').feature('s1').feature('p1').set('pname', {'freq' 'PortName'});
model.sol('sol2').feature('s1').feature('p1').set('punit', {'GHz' ''});
model.sol('sol2').feature('s1').feature('p1').set('sweeptype', 'filled');
model.sol('sol2').feature('s1').feature('p1').set('plistarr', {'5.1[GHz]' '1 2 '});
model.sol('sol2').feature('s1').feature('p1').set('pcontinuationmode', 'no');
model.sol('sol2').feature('s1').feature('p1').set('pcontinuation', '');
model.sol('sol2').feature('s1').feature('p1').set('preusesol', 'no');
model.sol('sol2').feature('s1').feature('p1').set('plot', 'off');
model.sol('sol2').feature('s1').feature('p1').set('plotgroup', 'Default');
model.sol('sol2').feature('s1').feature('p1').set('probesel', 'all');
model.sol('sol2').feature('s1').feature('p1').set('probes', {});
model.sol('sol2').feature('s1').feature('p1').set('control', 'fdss');
model.sol('sol2').feature('s1').set('control', 'fdss');
model.sol('sol2').feature('s1').feature('aDef').set('complexfun', true);
model.sol('sol2').feature('s1').feature('aDef').set('cachepattern', true);
model.sol('sol2').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol2').feature('s1').create('d1', 'Direct');
model.sol('sol2').feature('s1').feature('d1').set('linsolver', 'pardiso');
model.sol('sol2').feature('s1').feature('d1').label('Suggested Direct Solver (emw)');
model.sol('sol2').feature('s1').feature('fc1').set('linsolver', 'd1');
model.sol('sol2').feature('s1').feature.remove('fcDef');
model.sol('sol2').attach('std2');
model.sol('sol2').runAll;

model.result.create('pg4', 'PlotGroup2D');
model.result('pg4').label('Electric Field (emw) 1');
model.result('pg4').set('data', 'dset2');
model.result('pg4').setIndex('looplevel', 2, 0);
model.result('pg4').setIndex('looplevel', 1, 1);
model.result('pg4').set('frametype', 'spatial');
model.result('pg4').set('showlegendsmaxmin', true);
model.result('pg4').set('data', 'dset2');
model.result('pg4').setIndex('looplevel', 2, 0);
model.result('pg4').setIndex('looplevel', 1, 1);
model.result('pg4').set('defaultPlotID', 'ElectromagneticWaves/phys1/pdef1/pcond2/pg1');
model.result('pg4').feature.create('surf1', 'Surface');
model.result('pg4').feature('surf1').label('Surface');
model.result('pg4').feature('surf1').set('smooth', 'internal');
model.result('pg4').feature('surf1').set('data', 'parent');
model.result.numerical.create('gmev1', 'EvalGlobalMatrix');
model.result.numerical('gmev1').label('S-parameter (emw)');
model.result.numerical('gmev1').set('data', 'dset2');
model.result.numerical('gmev1').set('expr', 'emw.SdB');
model.result.numerical('gmev1').set('dataseries', 'sum');
model.result.table.create('tbl1', 'Table');
model.result.numerical('gmev1').set('table', 'tbl1');
model.result.numerical('gmev1').run;
model.result.numerical('gmev1').setResult;
model.result('pg4').run;

model.title('H-Bend Waveguide 2D');

model.description('The transmission of a TE10 wave through a 90 degree bend in a waveguide is modeled in 2D.');

model.label('h_bend_waveguide_2d.mph');

model.modelNode.label('Components');

out = model;
