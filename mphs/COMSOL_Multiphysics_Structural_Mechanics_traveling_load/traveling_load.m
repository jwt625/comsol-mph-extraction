function out = model
%
% traveling_load.m
%
% Model exported on May 26 2025, 21:27 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/COMSOL_Multiphysics/Structural_Mechanics');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 2);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.physics.create('solid', 'SolidMechanics', 'geom1');
model.physics('solid').model('comp1');

model.study.create('std1');
model.study('std1').create('time', 'Transient');
model.study('std1').feature('time').setSolveFor('/physics/solid', true);

% To import content from file, use:
% model.param.loadFile('FILENAME');
model.param.set('SpanWidth', '10[m]', 'Width of one span');
model.param.set('NumSpans', '8', 'Number of spans');
model.param.set('TotLength', 'SpanWidth*NumSpans', 'Total length of beam');
model.param.set('BeamHeight', '0.3[m]', 'Beam height');
model.param.set('LoadIntensity', '0.1[MPa]', 'Intensity of the pressure load');
model.param.set('PulseWidth', '2[m]', 'Width of load pulse');
model.param.set('PulseSpacing', '20[m]', 'Distance between load pulses');
model.param.set('LoadSpeed', '20[m/s]', 'Velocity of the load pulse');
model.param.set('Tstep1', '1/(50*f0)', 'Time step limit based on natural frequency');
model.param.set('Tstep2', 'PulseWidth/LoadSpeed/2', 'Time step limit based on load velocity');
model.param.set('Tstep', 'min(Tstep1,Tstep2)', 'Maximum time step');
model.param.set('Tend', 'TotLength/LoadSpeed', 'Time when first load pulse reaches beam end');
model.param.set('ElemPerSpan', 'max(ceil(SpanWidth/PulseWidth*2),20)', 'Number of elements along a span');
model.param.set('f0', 'sqrt(25e9[Pa]*BeamHeight^2/(12*2300[kg/m^3]*SpanWidth^4))*pi/2', 'Estimate of first natural frequency');
model.param.set('CriticalSpeed', 'f0*2*SpanWidth', 'Estimated critical speed');

model.geom('geom1').create('r1', 'Rectangle');
model.geom('geom1').feature('r1').set('size', {'SpanWidth' 'BeamHeight'});
model.geom('geom1').run('r1');
model.geom('geom1').create('pt1', 'Point');
model.geom('geom1').feature('pt1').setIndex('p', 'BeamHeight/2', 1);
model.geom('geom1').feature.duplicate('pt2', 'pt1');
model.geom('geom1').feature('pt2').setIndex('p', 'SpanWidth', 0);
model.geom('geom1').runPre('fin');
model.geom('geom1').create('uni1', 'Union');
model.geom('geom1').feature('uni1').selection('input').set({'pt1' 'pt2' 'r1'});
model.geom('geom1').run('uni1');
model.geom('geom1').create('arr1', 'Array');
model.geom('geom1').feature('arr1').selection('input').set({'uni1'});
model.geom('geom1').feature('arr1').set('fullsize', {'NumSpans' '1'});
model.geom('geom1').feature('arr1').set('displ', {'SpanWidth' '0'});
model.geom('geom1').runPre('fin');

model.selection.create('box1', 'Box');
model.selection('box1').model('comp1');

model.geom('geom1').run;

model.selection('box1').label('Box: Points on Centerline');
model.selection('box1').set('entitydim', 0);
model.selection('box1').set('ymin', 'BeamHeight/3');
model.selection('box1').set('ymax', '2*BeamHeight/3');
model.selection('box1').set('condition', 'inside');
model.selection.create('box2', 'Box');
model.selection('box2').model('comp1');
model.selection('box2').label('Box: Boundaries Above');
model.selection('box2').set('entitydim', 1);
model.selection('box2').set('ymin', '2*BeamHeight/2');
model.selection('box2').set('condition', 'inside');

model.material.create('mat1', 'Common', 'comp1');
model.material('mat1').propertyGroup.create('Enu', 'Young''s modulus and Poisson''s ratio');
model.material('mat1').label('Concrete');
model.material('mat1').set('family', 'concrete');
model.material('mat1').propertyGroup('def').set('thermalexpansioncoefficient', {'10e-6[1/K]' '0' '0' '0' '10e-6[1/K]' '0' '0' '0' '10e-6[1/K]'});
model.material('mat1').propertyGroup('def').set('density', '2300[kg/m^3]');
model.material('mat1').propertyGroup('def').set('thermalconductivity', {'1.8[W/(m*K)]' '0' '0' '0' '1.8[W/(m*K)]' '0' '0' '0' '1.8[W/(m*K)]'});
model.material('mat1').propertyGroup('def').set('heatcapacity', '880[J/(kg*K)]');
model.material('mat1').propertyGroup('Enu').set('E', '25[GPa]');
model.material('mat1').propertyGroup('Enu').set('nu', '0.20');

model.physics('solid').prop('Type2D').set('Type2D', 'PlaneStress');
model.physics('solid').feature('lemm1').create('dmp1', 'Damping', 2);
model.physics('solid').feature('lemm1').feature('dmp1').set('beta_dK', 0.002);
model.physics('solid').create('fix1', 'Fixed', 0);
model.physics('solid').feature('fix1').selection.named('box1');

model.func.create('rect1', 'Rectangle');
model.func('rect1').model('comp1');
model.func('rect1').set('lower', '-0.5*PulseWidth');
model.func('rect1').set('upper', '0.5*PulseWidth');
model.func('rect1').set('smooth', '0.1*PulseWidth');
model.func.create('an1', 'Analytic');
model.func('an1').model('comp1');
model.func('an1').set('funcname', 'Pulse');
model.func('an1').set('expr', 'rect1(x)');
model.func('an1').setIndex('argunit', 'm', 0);
model.func('an1').set('fununit', '1');
model.func('an1').set('periodic', true);
model.func('an1').set('periodicupper', 'PulseSpacing');

model.variable.create('var1');
model.variable('var1').model('comp1');
model.variable('var1').set('FirstLoadX', 'LoadSpeed*t+PulseWidth/2');
model.variable('var1').descr('FirstLoadX', 'Position of the first load pulse');
model.variable('var1').set('BehindFirstLoad', 'X<FirstLoadX');
model.variable('var1').descr('BehindFirstLoad', 'True if behind current position of the first load pulse');

model.physics('solid').create('bndl1', 'BoundaryLoad', 1);
model.physics('solid').feature('bndl1').selection.named('box2');
model.physics('solid').feature('bndl1').set('FperArea', {'0' 'if(BehindFirstLoad,-LoadIntensity*Pulse(X-LoadSpeed*t),0)' '0'});

model.mesh('mesh1').create('map1', 'Map');
model.mesh('mesh1').feature('map1').create('dis1', 'Distribution');
model.mesh('mesh1').feature('map1').feature('dis1').selection.set([1 3]);
model.mesh('mesh1').feature('map1').feature('dis1').set('numelem', 1);
model.mesh('mesh1').feature('map1').create('dis2', 'Distribution');
model.mesh('mesh1').feature('map1').feature('dis2').selection.named('box2');
model.mesh('mesh1').feature('map1').feature('dis2').set('numelem', 'ElemPerSpan');
model.mesh('mesh1').run;

model.study('std1').create('param', 'Parametric');
model.study('std1').feature('param').setIndex('pname', 'SpanWidth', 0);
model.study('std1').feature('param').setIndex('plistarr', '', 0);
model.study('std1').feature('param').setIndex('punit', 'm', 0);
model.study('std1').feature('param').setIndex('pname', 'SpanWidth', 0);
model.study('std1').feature('param').setIndex('plistarr', '', 0);
model.study('std1').feature('param').setIndex('punit', 'm', 0);
model.study('std1').feature('param').setIndex('pname', 'NumSpans', 1);
model.study('std1').feature('param').setIndex('plistarr', '', 1);
model.study('std1').feature('param').setIndex('punit', '', 1);
model.study('std1').feature('param').setIndex('pname', 'NumSpans', 1);
model.study('std1').feature('param').setIndex('plistarr', '', 1);
model.study('std1').feature('param').setIndex('punit', '', 1);
model.study('std1').feature('param').setIndex('pname', 'LoadSpeed', 0);
model.study('std1').feature('param').setIndex('plistarr', '20[m/s] CriticalSpeed CriticalSpeed CriticalSpeed', 0);
model.study('std1').feature('param').setIndex('pname', 'PulseSpacing', 1);
model.study('std1').feature('param').setIndex('plistarr', 'TotLength*2 TotLength*2 SpanWidth*2 SpanWidth', 1);
model.study('std1').feature('time').set('tlist', 'range(0,SpanWidth/LoadSpeed/20,Tend)');
model.study('std1').feature('time').set('usertol', true);
model.study('std1').feature('time').set('rtol', '0.0001');

model.sol.create('sol1');
model.sol('sol1').study('std1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'time');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').feature('comp1_u').set('scalemethod', 'manual');
model.sol('sol1').feature('v1').feature('comp1_solid_wZ').set('scalemethod', 'manual');
model.sol('sol1').feature('v1').feature('comp1_u').set('scaleval', '1e-2*80.00056249802248');
model.sol('sol1').feature('v1').feature('comp1_solid_wZ').set('scaleval', '1e-2');
model.sol('sol1').feature('v1').set('control', 'time');
model.sol('sol1').create('t1', 'Time');
model.sol('sol1').feature('t1').set('tlist', 'range(0,SpanWidth/LoadSpeed/20,Tend)');
model.sol('sol1').feature('t1').set('plot', 'off');
model.sol('sol1').feature('t1').set('plotgroup', 'Default');
model.sol('sol1').feature('t1').set('plotfreq', 'tout');
model.sol('sol1').feature('t1').set('probesel', 'all');
model.sol('sol1').feature('t1').set('probes', {});
model.sol('sol1').feature('t1').set('probefreq', 'tsteps');
model.sol('sol1').feature('t1').set('rtol', 0.001);
model.sol('sol1').feature('t1').set('atolglobalvaluemethod', 'factor');
model.sol('sol1').feature('t1').set('reacf', true);
model.sol('sol1').feature('t1').set('storeudot', true);
model.sol('sol1').feature('t1').set('endtimeinterpolation', true);
model.sol('sol1').feature('t1').set('timemethod', 'genalpha');
model.sol('sol1').feature('t1').set('control', 'time');
model.sol('sol1').feature('t1').feature('aDef').set('cachepattern', true);
model.sol('sol1').feature('t1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('t1').feature('fc1').set('linsolver', 'dDef');
model.sol('sol1').feature('t1').feature.remove('fcDef');
model.sol('sol1').attach('std1');

model.batch.create('p1', 'Parametric');
model.batch('p1').study('std1');
model.batch('p1').create('so1', 'Solutionseq');
model.batch('p1').feature('so1').set('seq', 'sol1');
model.batch('p1').feature('so1').set('store', 'on');
model.batch('p1').feature('so1').set('clear', 'on');
model.batch('p1').feature('so1').set('psol', 'none');
model.batch('p1').set('pname', {'LoadSpeed' 'PulseSpacing'});
model.batch('p1').set('plistarr', {'20[m/s] CriticalSpeed CriticalSpeed CriticalSpeed' 'TotLength*2 TotLength*2 SpanWidth*2 SpanWidth'});
model.batch('p1').set('sweeptype', 'sparse');
model.batch('p1').set('probesel', 'all');
model.batch('p1').set('probes', {});
model.batch('p1').set('plot', 'off');
model.batch('p1').set('err', 'on');
model.batch('p1').attach('std1');
model.batch('p1').set('control', 'param');

model.sol('sol1').feature('t1').set('maxstepconstraintgenalpha', 'const');
model.sol('sol1').feature('t1').set('maxstepgenalpha', 'Tstep');
model.sol('sol1').feature('v1').feature('comp1_u').set('scaleval', '1e-2');
model.sol.create('sol2');
model.sol('sol2').study('std1');
model.sol('sol2').label('Parametric Solutions 1');

model.batch('p1').feature('so1').set('psol', 'sol2');
model.batch('p1').run('compute');

model.result.create('pg1', 'PlotGroup2D');
model.result('pg1').set('data', 'dset2');
model.result('pg1').setIndex('looplevel', 161, 0);
model.result('pg1').setIndex('looplevel', 4, 1);
model.result('pg1').set('defaultPlotID', 'stress');
model.result('pg1').label('Stress (solid)');
model.result('pg1').set('frametype', 'spatial');
model.result('pg1').create('surf1', 'Surface');
model.result('pg1').feature('surf1').set('expr', {'solid.misesGp'});
model.result('pg1').feature('surf1').set('threshold', 'manual');
model.result('pg1').feature('surf1').set('thresholdvalue', 0.2);
model.result('pg1').feature('surf1').set('colortable', 'Rainbow');
model.result('pg1').feature('surf1').set('colortabletrans', 'none');
model.result('pg1').feature('surf1').set('colorscalemode', 'linear');
model.result('pg1').feature('surf1').set('resolution', 'normal');
model.result('pg1').feature('surf1').set('colortable', 'Prism');
model.result('pg1').feature('surf1').create('def', 'Deform');
model.result('pg1').feature('surf1').feature('def').set('expr', {'u' 'v'});
model.result('pg1').feature('surf1').feature('def').set('descr', 'Displacement field');
model.result('pg1').run;
model.result('pg1').label('Displacement');
model.result('pg1').run;
model.result('pg1').feature('surf1').set('expr', 'v');
model.result('pg1').feature('surf1').set('colortable', 'Wave');
model.result('pg1').feature('surf1').set('colorscalemode', 'linearsymmetric');
model.result('pg1').run;
model.result('pg1').feature('surf1').feature('def').set('scaleactive', true);
model.result('pg1').feature('surf1').feature('def').set('scale', 50);
model.result.create('pg2', 'PlotGroup2D');
model.result('pg2').set('data', 'dset2');
model.result('pg2').setIndex('looplevel', 161, 0);
model.result('pg2').setIndex('looplevel', 4, 1);
model.result('pg2').set('defaultPlotID', 'boundaryLoads');
model.result('pg2').label('Boundary Loads (solid)');
model.result('pg2').set('showlegends', true);
model.result('pg2').set('titletype', 'label');
model.result('pg2').set('frametype', 'spatial');
model.result('pg2').set('showlegendsunit', true);
model.result('pg2').create('surf1', 'Surface');
model.result('pg2').feature('surf1').set('expr', {'1'});
model.result('pg2').feature('surf1').label('Gray Surfaces');
model.result('pg2').feature('surf1').set('coloring', 'uniform');
model.result('pg2').feature('surf1').set('color', 'gray');
model.result('pg2').feature('surf1').set('inheritcolor', false);
model.result('pg2').feature('surf1').set('inheritrange', false);
model.result('pg2').feature('surf1').set('inheritheightscale', false);
model.result('pg2').feature('surf1').create('def', 'Deform');
model.result('pg2').feature('surf1').feature('def').set('expr', {'u' 'v'});
model.result('pg2').feature('surf1').feature('def').set('descr', 'Displacement field');
model.result('pg2').feature('surf1').feature('def').set('scaleactive', true);
model.result('pg2').feature('surf1').feature('def').set('scale', 0);
model.result('pg2').feature('surf1').create('sel1', 'Selection');
model.result('pg2').feature('surf1').feature('sel1').selection.geom('geom1', 2);
model.result('pg2').feature('surf1').feature('sel1').selection.set([1 2 3 4 5 6 7 8]);
model.result('pg2').create('arwl1', 'ArrowLine');
model.result('pg2').feature('arwl1').set('expr', {'solid.bndl1.F_Ax' 'solid.bndl1.F_Ay'});
model.result('pg2').feature('arwl1').set('placement', 'gausspoints');
model.result('pg2').feature('arwl1').set('arrowbase', 'tail');
model.result('pg2').feature('arwl1').label('Boundary Load 1');
model.result('pg2').feature('arwl1').set('inheritplot', 'none');
model.result('pg2').feature('arwl1').create('col', 'Color');
model.result('pg2').feature('arwl1').feature('col').set('colortable', 'Rainbow');
model.result('pg2').feature('arwl1').feature('col').set('colortabletrans', 'none');
model.result('pg2').feature('arwl1').feature('col').set('colorscalemode', 'linear');
model.result('pg2').feature('arwl1').feature('col').set('colordata', 'arrowlength');
model.result('pg2').feature('arwl1').feature('col').set('coloring', 'gradient');
model.result('pg2').feature('arwl1').feature('col').set('topcolor', 'red');
model.result('pg2').feature('arwl1').feature('col').set('bottomcolor', 'custom');
model.result('pg2').feature('arwl1').feature('col').set('custombottomcolor', [0.5882353186607361 0.5137255191802979 0.5176470875740051]);
model.result('pg2').feature('arwl1').set('color', 'red');
model.result('pg2').feature('arwl1').create('def', 'Deform');
model.result('pg2').feature('arwl1').feature('def').set('expr', {'u' 'v'});
model.result('pg2').feature('arwl1').feature('def').set('descr', 'Displacement field');
model.result('pg2').feature('arwl1').feature('def').set('scaleactive', true);
model.result('pg2').feature('arwl1').feature('def').set('scale', 0);
model.result('pg2').feature.move('surf1', 1);
model.result('pg2').label('Boundary Loads (solid)');
model.result('pg2').run;
model.result('pg2').run;
model.result('pg2').feature('arwl1').label('Load Arrows');
model.result('pg2').feature('arwl1').set('placement', 'uniform');
model.result('pg2').feature('arwl1').set('arrowcount', 1000);
model.result('pg2').feature('arwl1').set('arrowbase', 'head');
model.result('pg2').feature('arwl1').set('scaleactive', true);
model.result('pg2').feature('arwl1').set('scale', '1.5e-5');
model.result('pg2').run;
model.result('pg2').run;
model.result('pg2').feature('arwl1').feature.remove('col');
model.result('pg2').feature('arwl1').feature.remove('def');
model.result('pg2').run;
model.result('pg1').run;
model.result('pg1').feature.copy('arwl1', 'pg2/arwl1');
model.result('pg1').run;
model.result('pg2').run;
model.result.remove('pg2');
model.result('pg1').run;
model.result('pg1').create('arws1', 'ArrowSurface');
model.result('pg1').feature('arws1').label('Supports');
model.result('pg1').feature('arws1').set('expr', {'0' '1'});
model.result('pg1').feature('arws1').set('arrowxmethod', 'coord');
model.result('pg1').feature('arws1').set('xcoord', 'range(0,SpanWidth,TotLength)');
model.result('pg1').feature('arws1').set('arrowymethod', 'coord');
model.result('pg1').feature('arws1').set('ycoord', 0);
model.result('pg1').feature('arws1').set('arrowtype', 'cone');
model.result('pg1').feature('arws1').set('arrowbase', 'head');
model.result('pg1').feature('arws1').set('scaleactive', true);
model.result('pg1').feature('arws1').set('scale', 2);
model.result('pg1').feature('arws1').set('color', 'black');
model.result('pg1').run;
model.result('pg1').set('looplevel', [96 4]);
model.result('pg1').run;
model.result('pg1').set('looplevel', [96 3]);
model.result('pg1').run;
model.result.export.create('anim1', 'Animation');
model.result.export('anim1').set('target', 'player');
model.result.export('anim1').set('plotgroup', 'pg1');
model.result.export('anim1').run;
model.result.export('anim1').setIndex('singlelooplevel', 2, 1);
model.result.export('anim1').run;
model.result.export('anim1').setIndex('singlelooplevel', 3, 1);
model.result.export('anim1').run;
model.result.export('anim1').setIndex('singlelooplevel', 4, 1);
model.result.export('anim1').run;
model.result.dataset.create('cpt1', 'CutPoint2D');
model.result.dataset('cpt1').set('pointx', 'SpanWidth/2');
model.result.dataset('cpt1').set('pointy', 'BeamHeight/2');
model.result.dataset('cpt1').set('data', 'dset2');
model.result.create('pg2', 'PlotGroup1D');
model.result('pg2').run;
model.result('pg2').create('ptgr1', 'PointGraph');
model.result('pg2').feature('ptgr1').set('markerpos', 'datapoints');
model.result('pg2').feature('ptgr1').set('linewidth', 'preference');
model.result('pg2').feature('ptgr1').set('data', 'cpt1');
model.result('pg2').feature('ptgr1').set('expr', 'v');
model.result('pg2').run;
model.result('pg2').feature('ptgr1').set('xdata', 'expr');
model.result('pg2').feature('ptgr1').set('xdataexpr', 't*LoadSpeed');
model.result('pg2').feature('ptgr1').set('linewidth', 2);
model.result('pg2').feature('ptgr1').set('linemarker', 'cycle');
model.result('pg2').feature('ptgr1').set('markerpos', 'interp');
model.result('pg2').feature('ptgr1').set('legend', true);
model.result('pg2').run;
model.result('pg2').run;
model.result('pg2').set('legendpos', 'upperleft');
model.result('pg2').set('xlabelactive', true);
model.result('pg2').set('xlabel', 'Position of first load pulse [m]');
model.result('pg2').run;

model.title('Beam with a Traveling Load');

model.description(['This example shows how to model a load which varies in space and time. A series of load pulses travel along a beam which is supported at equal distances.' newline  newline 'For some combinations of the traveling speed of the load pulses and the spacing between them, it is possible to excite resonances in the beam. The effects of four different combinations of these parameters are investigated.']);

model.mesh.clearMeshes;

model.sol('sol1').clearSolutionData;
model.sol('sol2').clearSolutionData;
model.sol('sol3').clearSolutionData;
model.sol('sol4').clearSolutionData;
model.sol('sol5').clearSolutionData;
model.sol('sol6').clearSolutionData;

model.label('traveling_load.mph');

model.modelNode.label('Components');

out = model;
