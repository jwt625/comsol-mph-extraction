function out = model
%
% transmission_line_butler.m
%
% Model exported on May 26 2025, 21:32 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/RF_Module/Couplers_and_Power_Dividers');

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
model.param.set('PortName', '1', 'Port name parameter for sweep');
model.param.set('f0', '30[GHz]', 'Frequency');
model.param.set('lda0', 'c_const/f0', 'Wavelength, free space');
model.param.set('L0', '250[nH/m]', 'Microstrip line inductance');
model.param.set('C0', '100[pF/m]', 'Microstrip line capacitance');
model.param.set('Z0', 'sqrt(L0/C0)', 'Characteristic impedance');
model.param.set('lda0_t', '1/(f0*sqrt(L0*C0))', 'Wavelength, transmission line');
model.param.set('ul', 'lda0_t/4', 'Unit length, quarter-wave');
model.param.set('Z1', 'Z0/sqrt(2)', 'Characteristic impedance for branch-lines');
model.param.set('z1', 'Z1/Z0', 'Normalized impedance for branch-lines');
model.param.set('array_d', '0.48*lda0', 'Distance between array elements');

model.geom.create('part1', 'Part', 2);
model.geom('part1').label('90 Degree Hybrid');
model.geom('part1').lengthUnit('mm');
model.geom('part1').create('ls1', 'LineSegment');
model.geom('part1').feature('ls1').set('specify1', 'coord');
model.geom('part1').feature('ls1').set('specify2', 'coord');
model.geom('part1').feature('ls1').set('coord2', {'ul*2' '0'});
model.geom('part1').run('ls1');
model.geom('part1').create('ls2', 'LineSegment');
model.geom('part1').feature('ls2').set('specify1', 'coord');
model.geom('part1').feature('ls2').set('specify2', 'coord');
model.geom('part1').feature('ls2').set('coord1', {'ul/2' '0'});
model.geom('part1').feature('ls2').set('coord2', {'ul/2' 'ul'});
model.geom('part1').run('ls2');
model.geom('part1').create('rot1', 'Rotate');
model.geom('part1').feature('rot1').selection('input').set({'ls1' 'ls2'});
model.geom('part1').feature('rot1').set('rot', '0 180');
model.geom('part1').feature('rot1').set('pos', {'ul' 'ul/2'});
model.geom('part1').run('rot1');
model.geom.create('part2', 'Part', 2);
model.geom('part2').label('45 Degree Delay');
model.geom('part2').lengthUnit('mm');
model.geom('part2').create('pol1', 'Polygon');
model.geom('part2').feature('pol1').set('source', 'table');
model.geom('part2').feature('pol1').set('type', 'open');
model.geom('part2').feature('pol1').set('source', 'vectors');
model.geom('part2').feature('pol1').set('x', '0 ul ul ul ul ul*2 ul*2 ul*2 ul*2 ul*3');
model.geom('part2').feature('pol1').set('y', '0 0 0 ul*0.75 ul*0.75 ul*0.75 ul*0.75 0 0 0');
model.geom('part2').run('pol1');
model.geom.create('part3', 'Part', 2);
model.geom('part3').label('Transition');
model.geom('part3').lengthUnit('mm');
model.geom('part3').create('pol1', 'Polygon');
model.geom('part3').feature('pol1').set('source', 'table');
model.geom('part3').feature('pol1').set('type', 'open');
model.geom('part3').feature('pol1').set('source', 'vectors');
model.geom('part3').feature('pol1').set('x', '0 ul ul ul ul ul*2 ul*2 ul*2 ul*2 ul*3');
model.geom('part3').feature('pol1').set('y', '0 0 0 ul/2 ul/2 ul/2 ul/2 0 0 0');
model.geom('part3').run('pol1');
model.geom.create('part4', 'Part', 2);
model.geom('part4').label('Crossover');
model.geom('part4').lengthUnit('mm');
model.geom('part4').create('ls1', 'LineSegment');
model.geom('part4').feature('ls1').set('specify1', 'coord');
model.geom('part4').feature('ls1').set('specify2', 'coord');
model.geom('part4').feature('ls1').set('coord2', {'ul*3' '0'});
model.geom('part4').run('ls1');
model.geom('part4').create('ls2', 'LineSegment');
model.geom('part4').feature('ls2').set('specify1', 'coord');
model.geom('part4').feature('ls2').set('specify2', 'coord');
model.geom('part4').feature('ls2').set('coord1', {'0' 'ul'});
model.geom('part4').feature('ls2').set('coord2', {'ul*3' 'ul'});
model.geom('part4').run('ls2');
model.geom('part4').create('ls3', 'LineSegment');
model.geom('part4').feature('ls3').set('specify1', 'coord');
model.geom('part4').feature('ls3').set('specify2', 'coord');
model.geom('part4').feature('ls3').set('coord1', {'ul/2' '0'});
model.geom('part4').feature('ls3').set('coord2', {'ul/2' 'ul'});
model.geom('part4').run('ls3');
model.geom('part4').create('arr1', 'Array');
model.geom('part4').feature('arr1').selection('input').set({'ls3'});
model.geom('part4').feature('arr1').set('fullsize', [3 1]);
model.geom('part4').feature('arr1').set('displ', {'ul' '0'});
model.geom('part4').run('arr1');
model.geom.create('part5', 'Part', 2);
model.geom('part5').label('Front-end, outer');
model.geom('part5').lengthUnit('mm');
model.geom('part5').create('pol1', 'Polygon');
model.geom('part5').feature('pol1').set('source', 'table');
model.geom('part5').feature('pol1').set('type', 'open');
model.geom('part5').feature('pol1').set('source', 'vectors');
model.geom('part5').feature('pol1').set('x', '0 0 0 -1.5*array_d+ul*6');
model.geom('part5').feature('pol1').set('y', '0 -1.5*(array_d-ul) -1.5*(array_d-ul) -1.5*(array_d-ul)');
model.geom('part5').run('pol1');
model.geom.create('part6', 'Part', 2);
model.geom('part6').label('Front-end, inner');
model.geom('part6').lengthUnit('mm');
model.geom('part6').create('pol1', 'Polygon');
model.geom('part6').feature('pol1').set('source', 'table');
model.geom('part6').feature('pol1').set('type', 'open');
model.geom('part6').feature('pol1').set('source', 'vectors');
model.geom('part6').feature('pol1').set('x', '0 ul*0.25 ul*0.25 ul*0.25 ul*0.25 ul*0.5 ul*0.5 ul*0.5 ul*0.5 ul*0.75 ul*0.75 ul*0.75 ul*0.75 -1.5*array_d+ul*6');
model.geom('part6').feature('pol1').set('y', '0 0 0 -(array_d-ul)/2 -(array_d-ul)/2 -(array_d-ul)/2 -(array_d-ul)/2 0 0 0 0 -(array_d-ul)/2 -(array_d-ul)/2 -(array_d-ul)/2');
model.geom('part6').run('pol1');
model.geom('geom1').lengthUnit('mm');
model.geom('geom1').create('pi1', 'PartInstance');
model.geom('geom1').feature('pi1').set('selkeepnoncontr', false);
model.geom('geom1').feature('pi1').set('part', 'part1');
model.geom('geom1').run('pi1');
model.geom('geom1').create('pi2', 'PartInstance');
model.geom('geom1').feature('pi2').set('selkeepnoncontr', false);
model.geom('geom1').feature('pi2').set('part', 'part1');
model.geom('geom1').feature('pi2').set('displ', {'ul*5' '0'});
model.geom('geom1').run('pi2');
model.geom('geom1').create('pi3', 'PartInstance');
model.geom('geom1').feature('pi3').set('selkeepnoncontr', false);
model.geom('geom1').feature('pi3').set('part', 'part2');
model.geom('geom1').feature('pi3').set('displ', {'ul*2' '0'});
model.geom('geom1').run('pi3');
model.geom('geom1').create('pi4', 'PartInstance');
model.geom('geom1').feature('pi4').set('selkeepnoncontr', false);
model.geom('geom1').feature('pi4').set('part', 'part3');
model.geom('geom1').feature('pi4').set('displ', {'ul*7' '0'});
model.geom('geom1').run('pi4');
model.geom('geom1').create('pi5', 'PartInstance');
model.geom('geom1').feature('pi5').set('selkeepnoncontr', false);
model.geom('geom1').feature('pi5').set('part', 'part5');
model.geom('geom1').feature('pi5').set('displ', {'ul*10' '0'});
model.geom('geom1').run('pi5');
model.geom('geom1').create('pi6', 'PartInstance');
model.geom('geom1').feature('pi6').set('selkeepnoncontr', false);
model.geom('geom1').feature('pi6').set('part', 'part6');
model.geom('geom1').feature('pi6').set('displ', {'ul*10' 'ul'});
model.geom('geom1').run('pi6');
model.geom('geom1').create('mir1', 'Mirror');
model.geom('geom1').feature('mir1').selection('input').set({'pi1' 'pi2' 'pi3' 'pi4' 'pi5' 'pi6'});
model.geom('geom1').feature('mir1').set('keep', true);
model.geom('geom1').feature('mir1').set('pos', {'0' 'ul*1.5'});
model.geom('geom1').feature('mir1').set('axis', [0 1]);
model.geom('geom1').run('mir1');
model.geom('geom1').create('pi7', 'PartInstance');
model.geom('geom1').feature('pi7').set('selkeepnoncontr', false);
model.geom('geom1').feature('pi7').set('part', 'part4');
model.geom('geom1').feature('pi7').set('displ', {'ul*2' 'ul'});
model.geom('geom1').run('pi7');
model.geom('geom1').create('pi8', 'PartInstance');
model.geom('geom1').feature('pi8').set('selkeepnoncontr', false);
model.geom('geom1').feature('pi8').set('part', 'part4');
model.geom('geom1').feature('pi8').set('displ', {'ul*7' 'ul'});
model.geom('geom1').runPre('fin');
model.geom('geom1').run;

model.physics('tl').feature('tle1').set('L', 'L0');
model.physics('tl').feature('tle1').set('C', 'C0');
model.physics('tl').create('tle2', 'TransmissionLineEquation', 1);
model.physics('tl').feature('tle2').selection.set([6 7 9 10 43 44 46 47]);
model.physics('tl').feature('tle2').set('L', 'L0*z1');
model.physics('tl').feature('tle2').set('C', 'C0/z1');
model.physics('tl').create('lport1', 'LumpedPort', 0);
model.physics('tl').feature('lport1').selection.set([4]);
model.physics('tl').create('lport2', 'LumpedPort', 0);
model.physics('tl').feature('lport2').selection.set([3]);
model.physics('tl').create('lport3', 'LumpedPort', 0);
model.physics('tl').feature('lport3').selection.set([2]);
model.physics('tl').create('lport4', 'LumpedPort', 0);
model.physics('tl').feature('lport4').selection.set([1]);
model.physics('tl').create('lport5', 'LumpedPort', 0);
model.physics('tl').feature('lport5').selection.set([82]);
model.physics('tl').create('lport6', 'LumpedPort', 0);
model.physics('tl').feature('lport6').selection.set([81]);
model.physics('tl').create('lport7', 'LumpedPort', 0);
model.physics('tl').feature('lport7').selection.set([80]);
model.physics('tl').create('lport8', 'LumpedPort', 0);
model.physics('tl').feature('lport8').selection.set([79]);
model.physics('tl').prop('PortSweepSettings').set('useSweep', true);

model.param('default').setShowInParamSel(true);

model.study('std1').create('param1', 'Parametric');
model.study('std1').feature('param1').set('pname', 'PortName');
model.study('std1').feature('param1').set('plistarr', '1 2 3 4 5 6 7 8');

model.mesh('mesh1').automatic(false);
model.mesh('mesh1').feature('size').set('custom', true);
model.mesh('mesh1').feature('size').set('hmax', 'ul/15');
model.mesh('mesh1').run;

model.study('std1').setGenPlots(false);
model.study('std1').feature('freq').set('plist', 'f0');
model.study('std1').feature('param1').setIndex('plistarr', '1 2 3 4', 0);

model.sol.create('sol1');
model.sol('sol1').study('std1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'freq');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').set('control', 'freq');
model.sol('sol1').create('s1', 'Stationary');
model.sol('sol1').feature('s1').create('p1', 'Parametric');
model.sol('sol1').feature('s1').feature('p1').set('pname', {'PortName'});
model.sol('sol1').feature('s1').feature('p1').set('plistarr', {'1 2 3 4'});
model.sol('sol1').feature('s1').feature('p1').set('punit', {''});
model.sol('sol1').feature('s1').feature('p1').set('sweeptype', 'sparse');
model.sol('sol1').feature('s1').feature('p1').set('preusesol', 'no');
model.sol('sol1').feature('s1').feature('p1').set('pcontinuationmode', 'no');
model.sol('sol1').feature('s1').feature('p1').set('plot', 'off');
model.sol('sol1').feature('s1').feature('p1').set('plotgroup', 'Default');
model.sol('sol1').feature('s1').feature('p1').set('probesel', 'all');
model.sol('sol1').feature('s1').feature('p1').set('probes', {});
model.sol('sol1').feature('s1').feature('p1').set('control', 'param1');
model.sol('sol1').feature('s1').set('control', 'freq');
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
model.result('pg1').run;
model.result('pg1').create('line1', 'Line');
model.result('pg1').feature('line1').set('expr', '20*log10(abs(V))');
model.result('pg1').run;
model.result('pg1').feature('line1').set('rangecoloractive', true);
model.result('pg1').feature('line1').set('rangecolormin', -10);
model.result('pg1').feature('line1').set('rangecolormax', 0);
model.result('pg1').feature('line1').set('linetype', 'tube');
model.result('pg1').run;
model.result.numerical.create('gev1', 'EvalGlobal');
model.result.numerical('gev1').setIndex('expr', 'arg(tl.Vport_5)', 0);
model.result.numerical('gev1').setIndex('unit', 'deg', 0);
model.result.numerical('gev1').setIndex('descr', 'Port 5 phase', 0);
model.result.numerical('gev1').setIndex('expr', 'arg(tl.Vport_6)', 1);
model.result.numerical('gev1').setIndex('unit', 'deg', 1);
model.result.numerical('gev1').setIndex('descr', 'Port 6 phase', 1);
model.result.numerical('gev1').setIndex('expr', 'arg(tl.Vport_7)', 2);
model.result.numerical('gev1').setIndex('unit', 'deg', 2);
model.result.numerical('gev1').setIndex('descr', 'Port 7 phase', 2);
model.result.numerical('gev1').setIndex('expr', 'arg(tl.Vport_8)', 3);
model.result.numerical('gev1').setIndex('unit', 'deg', 3);
model.result.numerical('gev1').setIndex('descr', 'Port 8 phase', 3);
model.result.table.create('tbl1', 'Table');
model.result.table('tbl1').comments('Global Evaluation 1');
model.result.numerical('gev1').set('table', 'tbl1');
model.result.numerical('gev1').setResult;

model.title('Fast Prototyping of a Butler Matrix Beamforming Network');

model.description(['A Butler matrix is a passive beamforming feed network. It is a cost-effective feed network for phased array antennas because the circuit can be fabricated in the form of microstrip lines and is a viable solution for performing beam scanning without deploying expensive active devices.' newline  newline 'This example shows how to design such a circuit using the Transmission Line interface. The results show the logarithmic voltage on the Butler matrix beamforming circuit at 30' native2unicode(hex2dec({'00' 'a0'}), 'unicode') 'GHz and the arithmetic phase progression at each output port.']);

model.mesh.clearMeshes;

model.sol('sol1').clearSolutionData;

model.label('transmission_line_butler.mph');

model.modelNode.label('Components');

out = model;
