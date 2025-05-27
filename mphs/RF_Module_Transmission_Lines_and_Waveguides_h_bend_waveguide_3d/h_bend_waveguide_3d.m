function out = model
%
% h_bend_waveguide_3d.m
%
% Model exported on May 26 2025, 21:32 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/RF_Module/Transmission_Lines_and_Waveguides');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 3);
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

model.param.set('l_wg', '10[cm]');
model.param.descr('l_wg', 'Waveguide length');
model.param.set('w_wg', '4[cm]');
model.param.descr('w_wg', 'Waveguide width');
model.param.set('h_wg', '2[cm]');
model.param.descr('h_wg', 'Waveguide height');

model.geom('geom1').create('wp1', 'WorkPlane');
model.geom('geom1').feature('wp1').set('unite', true);
model.geom('geom1').feature('wp1').geom.create('c1', 'Circle');
model.geom('geom1').feature('wp1').geom.feature('c1').set('r', 'w_wg');
model.geom('geom1').feature('wp1').geom.run('c1');
model.geom('geom1').feature('wp1').geom.create('c2', 'Circle');
model.geom('geom1').feature('wp1').geom.feature('c2').set('r', '2*w_wg');
model.geom('geom1').feature('wp1').geom.feature('c2').set('angle', 90);
model.geom('geom1').feature('wp1').geom.feature('c2').set('rot', -90);
model.geom('geom1').feature('wp1').geom.run('c2');
model.geom('geom1').feature('wp1').geom.create('dif1', 'Difference');
model.geom('geom1').feature('wp1').geom.feature('dif1').selection('input').set({'c2'});
model.geom('geom1').feature('wp1').geom.feature('dif1').selection('input2').set({'c1'});
model.geom('geom1').feature('wp1').geom.run('dif1');
model.geom('geom1').feature('wp1').geom.create('r1', 'Rectangle');
model.geom('geom1').feature('wp1').geom.feature('r1').set('size', {'w_wg' 'l_wg'});
model.geom('geom1').feature('wp1').geom.feature('r1').set('pos', {'w_wg' '0'});
model.geom('geom1').feature('wp1').geom.run('r1');
model.geom('geom1').feature('wp1').geom.create('r2', 'Rectangle');
model.geom('geom1').feature('wp1').geom.feature('r2').set('size', {'l_wg' 'w_wg'});
model.geom('geom1').feature('wp1').geom.feature('r2').set('pos', {'-l_wg' '-2*w_wg'});
model.geom('geom1').feature('wp1').geom.run('r2');
model.geom('geom1').run('wp1');
model.geom('geom1').feature.create('ext1', 'Extrude');
model.geom('geom1').feature('ext1').set('workplane', 'wp1');
model.geom('geom1').feature('ext1').selection('input').set({'wp1'});
model.geom('geom1').feature('ext1').setIndex('distance', 'h_wg', 0);
model.geom('geom1').runPre('fin');
model.geom('geom1').run;

model.physics('emw').feature('wee1').set('DisplacementFieldModel', 'RefractiveIndex');
model.physics('emw').create('port1', 'Port', 2);
model.physics('emw').feature('port1').selection.set([1]);
model.physics('emw').feature('port1').set('PortType', 'Rectangular');
model.physics('emw').create('port2', 'Port', 2);
model.physics('emw').feature('port2').selection.set([15]);
model.physics('emw').feature('port2').set('PortType', 'Rectangular');

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
model.sol('sol1').feature('s1').create('i1', 'Iterative');
model.sol('sol1').feature('s1').feature('i1').set('linsolver', 'gmres');
model.sol('sol1').feature('s1').feature('i1').set('prefuntype', 'right');
model.sol('sol1').feature('s1').feature('i1').set('itrestart', '300');
model.sol('sol1').feature('s1').feature('i1').label('Suggested Iterative Solver (emw)');
model.sol('sol1').feature('s1').feature('i1').create('mg1', 'Multigrid');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').set('iter', '1');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('pr').create('sv1', 'SORVector');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('pr').feature('sv1').set('prefun', 'sorvec');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('pr').feature('sv1').set('iter', 2);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('pr').feature('sv1').set('relax', 1);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('pr').feature('sv1').set('sorvecdof', {'comp1_E'});
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('po').create('sv1', 'SORVector');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('po').feature('sv1').set('prefun', 'soruvec');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('po').feature('sv1').set('iter', 2);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('po').feature('sv1').set('relax', 1);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('po').feature('sv1').set('sorvecdof', {'comp1_E'});
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('cs').create('d1', 'Direct');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('cs').feature('d1').set('linsolver', 'pardiso');
model.sol('sol1').feature('s1').feature('fc1').set('linsolver', 'i1');
model.sol('sol1').feature('s1').feature.remove('fcDef');
model.sol('sol1').attach('std1');
model.sol('sol1').runAll;

model.result.create('pg1', 'PlotGroup3D');
model.result('pg1').label('Electric Field (emw)');
model.result('pg1').set('frametype', 'spatial');
model.result('pg1').set('showlegendsmaxmin', true);
model.result('pg1').set('data', 'dset1');
model.result('pg1').setIndex('looplevel', 49, 0);
model.result('pg1').set('defaultPlotID', 'ElectromagneticWaves/phys1/pdef1/pcond1/pg1');
model.result('pg1').feature.create('mslc1', 'Multislice');
model.result('pg1').feature('mslc1').label('Multislice');
model.result('pg1').feature('mslc1').set('smooth', 'internal');
model.result('pg1').feature('mslc1').set('data', 'parent');
model.result('pg1').feature('mslc1').feature.create('filt1', 'Filter');
model.result('pg1').feature('mslc1').feature('filt1').set('expr', '!isScalingSystemDomain');
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
model.result('pg2').run;
model.result('pg2').feature('glob1').set('linemarker', 'cycle');
model.result('pg2').feature('glob1').set('markerpos', 'interp');
model.result('pg2').run;
model.result('pg3').run;
model.result('pg1').run;
model.result('pg1').setIndex('looplevel', 45, 0);
model.result('pg1').run;
model.result('pg1').run;
model.result('pg1').feature.remove('mslc1');
model.result('pg1').run;
model.result('pg1').create('slc1', 'Slice');
model.result('pg1').feature('slc1').set('expr', 'emw.Ez');
model.result('pg1').feature('slc1').set('descr', 'Electric field, z-component');
model.result('pg1').feature('slc1').set('quickplane', 'xy');
model.result('pg1').feature('slc1').set('quickzmethod', 'coord');
model.result('pg1').feature('slc1').set('colortable', 'Wave');
model.result('pg1').run;
model.result('pg1').feature('slc1').set('colorscalemode', 'linearsymmetric');
model.result('pg1').feature('slc1').create('def1', 'Deform');
model.result('pg1').run;
model.result('pg1').feature('slc1').feature('def1').set('expr', {'emw.Ex' 'emw.Ey' 'emw.Ez'});
model.result('pg1').feature('slc1').feature('def1').set('descr', 'Electric field');
model.result('pg1').run;

model.physics('emw').prop('PortSweepSettings').set('useSweep', true);

model.param('default').setShowInParamSel(true);
model.param.set('PortName', '1');

model.study('std1').create('param1', 'Parametric');
model.study('std1').feature('param1').set('pname', 'PortName');
model.study('std1').feature('param1').set('plistarr', '1 2');

model.physics('emw').prop('PortSweepSettings').set('ExportTouchstone', true);

model.sol('sol1').study('std1');
model.sol('sol1').feature.remove('s1');
model.sol('sol1').feature.remove('v1');
model.sol('sol1').feature.remove('st1');
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
model.sol('sol1').feature('s1').feature('p1').set('plotgroup', 'pg1');
model.sol('sol1').feature('s1').feature('p1').set('probesel', 'all');
model.sol('sol1').feature('s1').feature('p1').set('probes', {});
model.sol('sol1').feature('s1').feature('p1').set('control', 'freq');
model.sol('sol1').feature('s1').set('linpmethod', 'sol');
model.sol('sol1').feature('s1').set('linpsol', 'zero');
model.sol('sol1').feature('s1').set('control', 'freq');
model.sol('sol1').feature('s1').feature('aDef').set('complexfun', true);
model.sol('sol1').feature('s1').feature('aDef').set('cachepattern', true);
model.sol('sol1').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('s1').create('i1', 'Iterative');
model.sol('sol1').feature('s1').feature('i1').set('linsolver', 'gmres');
model.sol('sol1').feature('s1').feature('i1').set('prefuntype', 'right');
model.sol('sol1').feature('s1').feature('i1').set('itrestart', '300');
model.sol('sol1').feature('s1').feature('i1').label('Suggested Iterative Solver (emw)');
model.sol('sol1').feature('s1').feature('i1').create('mg1', 'Multigrid');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').set('iter', '1');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('pr').create('sv1', 'SORVector');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('pr').feature('sv1').set('prefun', 'sorvec');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('pr').feature('sv1').set('iter', 2);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('pr').feature('sv1').set('relax', 1);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('pr').feature('sv1').set('sorvecdof', {'comp1_E'});
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('po').create('sv1', 'SORVector');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('po').feature('sv1').set('prefun', 'soruvec');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('po').feature('sv1').set('iter', 2);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('po').feature('sv1').set('relax', 1);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('po').feature('sv1').set('sorvecdof', {'comp1_E'});
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('cs').create('d1', 'Direct');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('cs').feature('d1').set('linsolver', 'pardiso');
model.sol('sol1').feature('s1').feature('fc1').set('linsolver', 'i1');
model.sol('sol1').feature('s1').feature.remove('fcDef');
model.sol('sol1').attach('std1');

model.batch.create('p1', 'Parametric');
model.batch('p1').study('std1');
model.batch('p1').create('so1', 'Solutionseq');
model.batch('p1').feature('so1').set('seq', 'sol1');
model.batch('p1').feature('so1').set('store', 'on');
model.batch('p1').feature('so1').set('clear', 'on');
model.batch('p1').feature('so1').set('psol', 'none');
model.batch('p1').set('pname', {'PortName'});
model.batch('p1').set('plistarr', {'1 2'});
model.batch('p1').set('sweeptype', 'sparse');
model.batch('p1').set('probesel', 'all');
model.batch('p1').set('probes', {});
model.batch('p1').set('plot', 'off');
model.batch('p1').set('err', 'on');
model.batch('p1').attach('std1');
model.batch('p1').set('control', 'param1');

model.sol.create('sol2');
model.sol('sol2').study('std1');
model.sol('sol2').label('Parametric Solutions 1');

model.batch('p1').feature('so1').set('psol', 'sol2');
model.batch('p1').run('compute');

model.result.create('pg4', 'PlotGroup3D');
model.result('pg4').label('Electric Field (emw) 1');
model.result('pg4').set('data', 'dset2');
model.result('pg4').setIndex('looplevel', 49, 0);
model.result('pg4').setIndex('looplevel', 2, 1);
model.result('pg4').set('frametype', 'spatial');
model.result('pg4').set('showlegendsmaxmin', true);
model.result('pg4').set('data', 'dset2');
model.result('pg4').setIndex('looplevel', 49, 0);
model.result('pg4').setIndex('looplevel', 2, 1);
model.result('pg4').set('defaultPlotID', 'ElectromagneticWaves/phys1/pdef1/pcond1/pg1');
model.result('pg4').feature.create('mslc1', 'Multislice');
model.result('pg4').feature('mslc1').label('Multislice');
model.result('pg4').feature('mslc1').set('smooth', 'internal');
model.result('pg4').feature('mslc1').set('data', 'parent');
model.result('pg4').feature('mslc1').feature.create('filt1', 'Filter');
model.result('pg4').feature('mslc1').feature('filt1').set('expr', '!isScalingSystemDomain');
model.result.create('pg5', 'PlotGroup1D');
model.result('pg5').set('data', 'dset2');
model.result('pg5').create('glob1', 'Global');
model.result('pg5').feature('glob1').set('unit', {'' '' '' ''});
model.result('pg5').feature('glob1').set('expr', {'emw.S11dB' 'emw.S12dB' 'emw.S21dB' 'emw.S22dB'});
model.result('pg5').feature('glob1').set('descr', {'S11' 'S12' 'S21' 'S22'});
model.result('pg5').label('S-parameter (emw) 1');
model.result('pg5').feature('glob1').set('titletype', 'none');
model.result('pg5').feature('glob1').set('xdata', 'expr');
model.result('pg5').set('ylabelactive', true);
model.result('pg5').set('ylabel', 'S-parameter (dB)');
model.result('pg5').feature('glob1').set('xdataexpr', 'freq');
model.result('pg5').feature('glob1').set('xdataunit', 'GHz');
model.result('pg5').feature('glob1').set('markerpos', 'datapoints');
model.result('pg5').feature('glob1').set('xdatasolnumtype', 'all');
model.result('pg5').feature('glob1').active(true);
model.result.create('pg6', 'SmithGroup');
model.result('pg6').set('data', 'dset2');
model.result('pg6').create('rgr1', 'ReflectionGraph');
model.result('pg6').feature('rgr1').set('unit', {'' ''});
model.result('pg6').feature('rgr1').set('expr', {'emw.S11' 'emw.S22'});
model.result('pg6').feature('rgr1').set('descr', {'S11' 'S22'});
model.result('pg6').label('Smith Plot (emw) 1');
model.result('pg6').feature('rgr1').set('titletype', 'manual');
model.result('pg6').feature('rgr1').set('title', 'Reflection Graph: S-parameter, Color: Frequency (GHz)');
model.result('pg6').feature('rgr1').set('linemarker', 'point');
model.result('pg6').feature('rgr1').set('markerpos', 'datapoints');
model.result('pg6').feature('rgr1').create('col1', 'Color');
model.result('pg6').feature('rgr1').feature('col1').set('expr', 'emw.freq/1e9');
model.result('pg6').feature('rgr1').feature('col1').set('colortable', 'Spectrum');
model.result('pg4').run;
model.result('pg2').run;
model.result('pg2').feature('glob1').set('data', 'dset2');
model.result('pg2').feature('glob1').set('expr', {'emw.S11dB' 'emw.S21dB' 'emw.S12dB'});
model.result('pg2').feature('glob1').set('descr', {'S11' 'S21' 'S12'});
model.result('pg2').feature('glob1').set('expr', {'emw.S11dB' 'emw.S21dB' 'emw.S12dB' 'emw.S22dB'});
model.result('pg2').feature('glob1').set('descr', {'S11' 'S21' 'S12' 'S22'});
model.result('pg2').run;
model.result('pg3').run;
model.result('pg3').set('data', 'dset2');
model.result('pg3').setIndex('looplevelinput', 'last', 1);
model.result('pg3').run;
model.result('pg3').feature('rgr1').set('expr', {'emw.S22'});
model.result('pg3').feature('rgr1').set('descr', {'S22'});
model.result('pg3').feature('rgr1').set('unit', {'1'});
model.result('pg3').run;
model.result('pg6').run;
model.result('pg6').run;
model.result('pg6').feature('rgr1').set('linemarker', 'cycle');
model.result('pg6').feature('rgr1').set('markerpos', 'interp');

model.title('H-Bend Waveguide 3D');

model.description('The transmission of a TE10 wave through a 90 degree bend in a waveguide is modeled in 3D.');

model.mesh.clearMeshes;

model.sol('sol1').clearSolutionData;
model.sol('sol2').clearSolutionData;
model.sol('sol3').clearSolutionData;
model.sol('sol4').clearSolutionData;

model.label('h_bend_waveguide_3d.mph');

model.modelNode.label('Components');

out = model;
