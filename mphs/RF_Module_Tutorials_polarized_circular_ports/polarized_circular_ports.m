function out = model
%
% polarized_circular_ports.m
%
% Model exported on May 26 2025, 21:32 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/RF_Module/Tutorials');

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

model.param.set('frq', 'c_const/0.03[m]');
model.param.descr('frq', 'Operating frequency');

model.geom('geom1').run;

model.study('std1').feature('freq').set('plist', 'range(0.9*frq,(1.5*frq-(0.9*frq))/10,1.5*frq)');

model.geom('geom1').create('cyl1', 'Cylinder');
model.geom('geom1').feature('cyl1').set('r', 0.01);
model.geom('geom1').feature('cyl1').set('h', 0.1);
model.geom('geom1').run('cyl1');

model.view('view1').set('renderwireframe', true);

model.geom('geom1').create('wp1', 'WorkPlane');
model.geom('geom1').feature('wp1').set('unite', true);
model.geom('geom1').feature('wp1').set('quickz', 0.1);
model.geom('geom1').feature('wp1').geom.create('ls1', 'LineSegment');
model.geom('geom1').feature('wp1').geom.feature('ls1').set('specify1', 'coord');
model.geom('geom1').feature('wp1').geom.feature('ls1').set('specify2', 'coord');
model.geom('geom1').feature('wp1').geom.feature('ls1').set('coord1', [0 0.01]);
model.geom('geom1').feature('wp1').geom.feature('ls1').set('coord2', [0 -0.01]);
model.geom('geom1').feature('wp1').geom.run('ls1');
model.geom('geom1').feature('wp1').geom.create('rot1', 'Rotate');
model.geom('geom1').feature('wp1').geom.feature('rot1').selection('input').set({'ls1'});
model.geom('geom1').feature('wp1').geom.feature('rot1').set('rot', '45 135');
model.geom('geom1').feature('wp1').geom.run('rot1');
model.geom('geom1').run('fin');
model.geom('geom1').create('ige1', 'IgnoreEdges');
model.geom('geom1').feature('ige1').selection('input').set('fin', [7 8 13 14]);
model.geom('geom1').feature('ige1').set('ignorevtx', false);
model.geom('geom1').run('ige1');

model.material.create('mat1', 'Common', 'comp1');
model.material('mat1').propertyGroup('def').set('relpermittivity', {'1'});
model.material('mat1').propertyGroup('def').set('relpermeability', {'1'});
model.material('mat1').propertyGroup('def').set('electricconductivity', {'0'});

model.physics('emw').create('port1', 'Port', 2);
model.physics('emw').feature('port1').selection.set([3]);
model.physics('emw').feature('port1').set('PortType', 'Circular');
model.physics('emw').feature('port1').create('cportv1', 'CircularPortReferenceAxis', 0);
model.physics('emw').feature('port1').feature('cportv1').selection.set([5 8]);
model.physics('emw').create('port2', 'Port', 2);
model.physics('emw').feature('port2').selection.set([3]);
model.physics('emw').feature('port2').set('PortType', 'Circular');
model.physics('emw').feature('port2').create('cportv1', 'CircularPortReferenceAxis', 0);
model.physics('emw').feature('port2').feature('cportv1').selection.set([1 12]);
model.physics('emw').create('port3', 'Port', 2);
model.physics('emw').feature('port3').selection.set([4]);
model.physics('emw').feature('port3').set('PortType', 'Circular');
model.physics('emw').feature('port3').create('cportv1', 'CircularPortReferenceAxis', 0);
model.physics('emw').feature('port3').feature('cportv1').selection.set([4 10]);
model.physics('emw').create('port4', 'Port', 2);
model.physics('emw').feature('port4').selection.set([4]);
model.physics('emw').feature('port4').set('PortType', 'Circular');
model.physics('emw').feature('port4').create('cportv1', 'CircularPortReferenceAxis', 0);
model.physics('emw').feature('port4').feature('cportv1').selection.set([3 11]);

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
model.sol('sol1').feature('s1').feature('p1').set('plistarr', {'range(0.9*frq,(1.5*frq-(0.9*frq))/10,1.5*frq)'});
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
model.result('pg1').setIndex('looplevel', 11, 0);
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
model.result('pg2').feature('glob1').set('unit', {'' '' '' ''});
model.result('pg2').feature('glob1').set('expr', {'emw.S11dB' 'emw.S21dB' 'emw.S31dB' 'emw.S41dB'});
model.result('pg2').feature('glob1').set('descr', {'S11' 'S21' 'S31' 'S41'});
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
model.result('pg3').run;
model.result.create('pg4', 'PlotGroup3D');
model.result('pg4').run;
model.result('pg4').label('Port 1');
model.result('pg4').create('surf1', 'Surface');
model.result('pg4').feature('surf1').set('expr', 'emw.normtEmode_1');
model.result('pg4').feature('surf1').set('descr', 'Port tangential electric mode field norm');
model.result('pg4').run;
model.result('pg4').create('arws1', 'ArrowSurface');
model.result('pg4').feature('arws1').set('expr', {'emw.tEmodex_1' 'emw.tEmodey_1' 'emw.tEmodez_1'});
model.result('pg4').feature('arws1').set('descr', 'Port tangential electric mode field');
model.result('pg4').feature('arws1').set('arrowcount', 1000);
model.result('pg4').feature('arws1').set('color', 'black');
model.result('pg4').run;
model.result('pg4').run;
model.result('pg4').run;
model.result.duplicate('pg5', 'pg4');
model.result('pg5').run;
model.result('pg5').label('Port 2');
model.result('pg5').run;
model.result('pg5').feature('surf1').set('expr', 'emw.normtEmode_2');
model.result('pg5').run;
model.result('pg5').feature('arws1').setIndex('expr', 'emw.tEmodex_2', 0);
model.result('pg5').feature('arws1').setIndex('expr', 'emw.tEmodey_2', 1);
model.result('pg5').feature('arws1').setIndex('expr', 'emw.tEmodez_2', 2);
model.result('pg5').run;
model.result('pg5').run;
model.result.duplicate('pg6', 'pg5');
model.result('pg6').run;
model.result('pg6').label('Port 3');
model.result('pg6').run;
model.result('pg6').feature('surf1').set('expr', 'emw.normtEmode_3');
model.result('pg6').run;
model.result('pg6').feature('arws1').setIndex('expr', 'emw.tEmodex_3', 0);
model.result('pg6').feature('arws1').setIndex('expr', 'emw.tEmodey_3', 1);
model.result('pg6').feature('arws1').setIndex('expr', 'emw.tEmodez_3', 2);
model.result('pg6').run;
model.result('pg6').run;
model.result.duplicate('pg7', 'pg6');
model.result('pg7').run;
model.result('pg7').label('Port 4');
model.result('pg7').run;
model.result('pg7').feature('surf1').set('expr', 'emw.normtEmode_4');
model.result('pg7').run;
model.result('pg7').feature('arws1').setIndex('expr', 'emw.tEmodex_4', 0);
model.result('pg7').feature('arws1').setIndex('expr', 'emw.tEmodey_4', 1);
model.result('pg7').feature('arws1').setIndex('expr', 'emw.tEmodez_4', 2);
model.result('pg7').run;
model.result.numerical.create('gev1', 'EvalGlobal');
model.result.numerical('gev1').setIndex('looplevelinput', 'last', 0);
model.result.numerical('gev1').set('expr', {'emw.S31dB'});
model.result.numerical('gev1').set('descr', {'S31'});
model.result.numerical('gev1').set('unit', {'1'});
model.result.table.create('tbl1', 'Table');
model.result.table('tbl1').comments('Global Evaluation 1');
model.result.numerical('gev1').set('table', 'tbl1');
model.result.numerical('gev1').setResult;
model.result.numerical.create('gev2', 'EvalGlobal');
model.result.numerical('gev2').setIndex('looplevelinput', 'last', 0);
model.result.numerical('gev2').set('expr', {'emw.S41dB'});
model.result.numerical('gev2').set('descr', {'S41'});
model.result.numerical('gev2').set('unit', {'1'});
model.result.table.create('tbl2', 'Table');
model.result.table('tbl2').comments('Global Evaluation 2');
model.result.numerical('gev2').set('table', 'tbl2');
model.result.numerical('gev2').setResult;

model.title('Polarized Circular Ports');

model.description('This example of a circular waveguide demonstrates how to excite and terminate ports with degenerate port modes. In particular it shows how to model and excite the TE11 mode of circular waveguides in 3D.');

model.mesh.clearMeshes;

model.sol('sol1').clearSolutionData;

model.label('polarized_circular_ports.mph');

model.modelNode.label('Components');

out = model;
