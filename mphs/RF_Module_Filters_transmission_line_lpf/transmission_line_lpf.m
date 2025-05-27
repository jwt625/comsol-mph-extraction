function out = model
%
% transmission_line_lpf.m
%
% Model exported on May 26 2025, 21:32 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/RF_Module/Filters');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 2);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.physics.create('tl', 'TransmissionLine', 'geom1');
model.physics('tl').model('comp1');

model.study.create('std1');
model.study('std1').create('freq', 'Frequency');
model.study('std1').feature('freq').set('solnum', 'auto');
model.study('std1').feature('freq').set('notsolnum', 'auto');
model.study('std1').feature('freq').set('outputmap', {});
model.study('std1').feature('freq').set('ngenAUX', '1');
model.study('std1').feature('freq').set('goalngenAUX', '1');
model.study('std1').feature('freq').set('ngenAUX', '1');
model.study('std1').feature('freq').set('goalngenAUX', '1');
model.study('std1').feature('freq').setSolveFor('/physics/tl', true);

% To import content from file, use:
% model.param.loadFile('FILENAME');
model.param.set('f0', '4[GHz]', 'Frequency');
model.param.set('lda0', 'c_const/f0', 'Wavelength, free space');
model.param.set('L0', '250[nH/m]', 'Microstrip line inductance');
model.param.set('C0', '100[pF/m]', 'Microstrip line capacitance');
model.param.set('Z0', 'sqrt(L0/C0)', 'Characteristic impedance');
model.param.set('lda0_t', '1/(f0*sqrt(L0*C0))', 'Wavelength, transmission line');
model.param.set('ul', 'lda0_t/8', 'Unit length');
model.param.set('z0', 'Z0/50[ohm]', 'Normalized impedance');
model.param.set('g1', '1.5963', 'Element value1, 0.5dB equal-ripple');
model.param.set('g2', '1.0967', 'Element value2, 0.5dB equal-ripple');
model.param.set('n_sq', '1+1/g1', 'n^2 parameter in Kuroda''s identity');
model.param.set('z1_1', 'g1*n_sq', 'Normalized transition impedance');
model.param.set('z1_2', 'z0*n_sq', 'Open circuit shunt stub1 normalized impedance');
model.param.set('z2', '1/g2', 'Open circuit shunt stub2 normalized impedance');

model.geom('geom1').lengthUnit('mm');
model.geom('geom1').create('ls1', 'LineSegment');
model.geom('geom1').feature('ls1').set('specify1', 'coord');
model.geom('geom1').feature('ls1').set('specify2', 'coord');
model.geom('geom1').feature('ls1').set('coord1', {'-ul-0.5' '0'});
model.geom('geom1').feature('ls1').set('coord2', {'ul+0.5' '0'});
model.geom('geom1').run('ls1');
model.geom('geom1').create('ls2', 'LineSegment');
model.geom('geom1').feature('ls2').set('specify1', 'coord');
model.geom('geom1').feature('ls2').set('specify2', 'coord');
model.geom('geom1').feature('ls2').set('coord1', {'-ul' '0'});
model.geom('geom1').feature('ls2').set('coord2', {'-ul' 'ul'});
model.geom('geom1').run('ls2');
model.geom('geom1').create('ls3', 'LineSegment');
model.geom('geom1').feature('ls3').set('specify1', 'coord');
model.geom('geom1').feature('ls3').set('specify2', 'coord');
model.geom('geom1').feature('ls3').set('coord2', {'0' 'ul'});
model.geom('geom1').run('ls3');
model.geom('geom1').create('ls4', 'LineSegment');
model.geom('geom1').feature('ls4').set('specify1', 'coord');
model.geom('geom1').feature('ls4').set('specify2', 'coord');
model.geom('geom1').feature('ls4').set('coord1', {'ul' '0'});
model.geom('geom1').feature('ls4').set('coord2', {'ul' 'ul'});
model.geom('geom1').run('fin');

model.physics('tl').create('lport1', 'LumpedPort', 0);
model.physics('tl').feature('lport1').selection.set([1]);
model.physics('tl').feature('lport1').set('PortExcitation', 'on');
model.physics('tl').create('lport2', 'LumpedPort', 0);
model.physics('tl').feature('lport2').selection.set([8]);
model.physics('tl').feature('tle1').set('L', 'L0');
model.physics('tl').feature('tle1').set('C', 'C0');
model.physics('tl').create('tle2', 'TransmissionLineEquation', 1);
model.physics('tl').feature('tle2').selection.set([3 5]);
model.physics('tl').feature('tle2').set('L', 'L0*z1_1');
model.physics('tl').feature('tle2').set('C', 'C0/z1_1');
model.physics('tl').create('tle3', 'TransmissionLineEquation', 1);
model.physics('tl').feature('tle3').selection.set([2 6]);
model.physics('tl').feature('tle3').set('L', 'L0*z1_2');
model.physics('tl').feature('tle3').set('C', 'C0/z1_2');
model.physics('tl').create('tle4', 'TransmissionLineEquation', 1);
model.physics('tl').feature('tle4').selection.set([4]);
model.physics('tl').feature('tle4').set('L', 'L0*z2');
model.physics('tl').feature('tle4').set('C', 'C0/z2');

model.study('std1').feature('freq').set('plist', 'range(1[GHz],0.1[GHz],20[GHz])');

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
model.sol('sol1').feature('s1').feature('p1').set('plistarr', {'range(1[GHz],0.1[GHz],20[GHz])'});
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
model.sol('sol1').feature('s1').feature('aDef').set('cachepattern', false);
model.sol('sol1').feature('s1').feature('aDef').set('matherr', true);
model.sol('sol1').feature('s1').feature('aDef').set('blocksizeactive', false);
model.sol('sol1').feature('s1').feature('aDef').set('nullfun', 'auto');
model.sol('sol1').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('s1').feature('fc1').set('linsolver', 'dDef');
model.sol('sol1').feature('s1').feature.remove('fcDef');
model.sol('sol1').attach('std1');
model.sol('sol1').runAll;

model.result.create('pg1', 'PlotGroup2D');
model.result('pg1').set('showlegendsmaxmin', true);
model.result('pg1').set('data', 'dset1');
model.result('pg1').setIndex('looplevel', 191, 0);
model.result('pg1').set('defaultPlotID', 'TransmissionLine/phys1/pdef1/pcond2/pg1');
model.result('pg1').feature.create('line1', 'Line');
model.result('pg1').feature('line1').label('Line Graph');
model.result('pg1').feature('line1').set('linetype', 'tube');
model.result('pg1').feature('line1').set('smooth', 'internal');
model.result('pg1').feature('line1').set('data', 'parent');
model.result.create('pg2', 'PlotGroup1D');
model.result('pg2').set('data', 'dset1');
model.result('pg2').create('glob1', 'Global');
model.result('pg2').feature('glob1').set('unit', {'' ''});
model.result('pg2').feature('glob1').set('expr', {'tl.S11dB' 'tl.S21dB'});
model.result('pg2').feature('glob1').set('descr', {'S11' 'S21'});
model.result('pg2').label('S-parameter (tl)');
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
model.result('pg3').feature('rgr1').set('expr', {'tl.S11'});
model.result('pg3').feature('rgr1').set('descr', {'S11'});
model.result('pg3').label('Smith Plot (tl)');
model.result('pg3').feature('rgr1').set('titletype', 'manual');
model.result('pg3').feature('rgr1').set('title', 'Reflection Graph: S-parameter, Color: Frequency (GHz)');
model.result('pg3').feature('rgr1').set('linemarker', 'point');
model.result('pg3').feature('rgr1').set('markerpos', 'datapoints');
model.result('pg3').feature('rgr1').create('col1', 'Color');
model.result('pg3').feature('rgr1').feature('col1').set('expr', 'tl.freq/1e9');
model.result('pg3').feature('rgr1').feature('col1').set('colortable', 'Spectrum');
model.result('pg1').run;
model.result('pg1').run;
model.result('pg1').run;
model.result('pg1').run;
model.result('pg1').setIndex('looplevel', 26, 0);
model.result('pg1').run;
model.result('pg2').run;
model.result('pg2').set('titletype', 'manual');
model.result('pg2').set('title', '0.5 dB Equal-Ripple Low-Pass Filter, Cutoff at 4GHz');
model.result('pg2').set('axislimits', true);
model.result('pg2').set('ymin', -50);
model.result('pg2').set('legendpos', 'lowerright');

model.title('Fast Modeling of a Transmission Line Low-Pass Filter');

model.description(['One way to design a filter is to use the element values of well-known filter prototypes, such as maximally flat or equal-ripple low-pass filters. It is easier to fabricate a distributed element filter on a microwave substrate than a lumped element filter, since it is cumbersome to find off-the-shelf capacitors and inductors that are exactly matched to the frequency-scaled element values of the filter prototype.' newline  newline 'This tutorial model demonstrates the design process of a distributed element filter using Richard' native2unicode(hex2dec({'20' '19'}), 'unicode') 's transformation, Kuroda' native2unicode(hex2dec({'20' '19'}), 'unicode') 's identity, and the Transmission Line interface. This approach is very fast compared with solving Maxwell' native2unicode(hex2dec({'20' '19'}), 'unicode') 's equations in 3D. The model simulates a three-element 0.5-dB equal-ripple low-pass filter that has a cutoff frequency at 4' native2unicode(hex2dec({'00' 'a0'}), 'unicode') 'GHz. The resulting S-parameter plot shows a low-pass frequency response that is also periodically observed at a higher frequency range.']);

model.mesh.clearMeshes;

model.sol('sol1').clearSolutionData;

model.label('transmission_line_lpf.mph');

model.modelNode.label('Components');

out = model;
