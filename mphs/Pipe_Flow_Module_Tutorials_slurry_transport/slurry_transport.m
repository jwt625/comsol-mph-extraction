function out = model
%
% slurry_transport.m
%
% Model exported on May 26 2025, 21:31 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/Pipe_Flow_Module/Tutorials');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 2);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.physics.create('pfl', 'FlowInPipes', 'geom1');
model.physics('pfl').model('comp1');

model.study.create('std1');
model.study('std1').create('stat', 'Stationary');
model.study('std1').feature('stat').setSolveFor('/physics/pfl', true);

model.param.set('Qv0', '3.4[m^3/min]');
model.param.descr('Qv0', 'Volumetric flow rate');
model.param.set('d1', '150[mm ]');
model.param.descr('d1', 'Pipe diameter, pipe 1');
model.param.set('d2', '100[mm]');
model.param.descr('d2', 'Pipe diameter, pipe 2');
model.param.set('d3', '75[mm]');
model.param.descr('d3', 'Pipe diameter, pipe 3');
model.param.set('d4', '175[mm]');
model.param.descr('d4', 'Pipe diameter, pipe 4');

model.geom('geom1').create('pol1', 'Polygon');
model.geom('geom1').feature('pol1').set('source', 'table');
model.geom('geom1').feature('pol1').set('type', 'open');
model.geom('geom1').feature('pol1').set('source', 'vectors');
model.geom('geom1').feature('pol1').set('x', '0 80');
model.geom('geom1').feature('pol1').set('y', '0 0');
model.geom('geom1').selection.create('csel1', 'CumulativeSelection');
model.geom('geom1').selection('csel1').label('Pipe 1');
model.geom('geom1').feature('pol1').set('contributeto', 'csel1');
model.geom('geom1').runPre('fin');
model.geom('geom1').create('pol2', 'Polygon');
model.geom('geom1').feature('pol2').set('source', 'table');
model.geom('geom1').feature('pol2').set('type', 'open');
model.geom('geom1').feature('pol2').set('source', 'vectors');
model.geom('geom1').feature('pol2').set('x', '80 80 90 90 120 120 130 130');
model.geom('geom1').feature('pol2').set('y', '0 0 20 20 20 20 0 0');
model.geom('geom1').selection.create('csel2', 'CumulativeSelection');
model.geom('geom1').selection('csel2').label('Pipe 2');
model.geom('geom1').feature('pol2').set('contributeto', 'csel2');
model.geom('geom1').runPre('fin');
model.geom('geom1').create('pol3', 'Polygon');
model.geom('geom1').feature('pol3').set('source', 'table');
model.geom('geom1').feature('pol3').set('type', 'open');
model.geom('geom1').feature('pol3').set('source', 'vectors');
model.geom('geom1').feature('pol3').set('x', '80 80 80 130 130 130');
model.geom('geom1').feature('pol3').set('y', '0 -20 -20 -20 -20 0');
model.geom('geom1').selection.create('csel3', 'CumulativeSelection');
model.geom('geom1').selection('csel3').label('Pipe 3');
model.geom('geom1').feature('pol3').set('contributeto', 'csel3');
model.geom('geom1').runPre('fin');
model.geom('geom1').create('pol4', 'Polygon');
model.geom('geom1').feature('pol4').set('source', 'table');
model.geom('geom1').feature('pol4').set('type', 'open');
model.geom('geom1').feature('pol4').set('source', 'vectors');
model.geom('geom1').feature('pol4').set('x', '130 180');
model.geom('geom1').feature('pol4').set('y', '0  0');
model.geom('geom1').selection.create('csel4', 'CumulativeSelection');
model.geom('geom1').selection('csel4').label('Pipe 4');
model.geom('geom1').feature('pol4').set('contributeto', 'csel4');
model.geom('geom1').runPre('fin');

model.variable.create('var1');
model.variable('var1').model('comp1');

model.geom('geom1').run;

model.variable('var1').selection.geom('geom1', 1);
model.variable('var1').selection.named('geom1_csel1_bnd');
model.variable('var1').set('d', 'd1');
model.variable('var1').descr('d', 'Pipe diameter');
model.variable.duplicate('var2', 'var1');
model.variable('var2').selection.named('geom1_csel2_bnd');
model.variable('var2').set('d', 'd2');
model.variable.duplicate('var3', 'var2');
model.variable('var3').selection.named('geom1_csel3_bnd');
model.variable('var3').set('d', 'd3');
model.variable.duplicate('var4', 'var3');
model.variable('var4').selection.named('geom1_csel4_bnd');
model.variable('var4').set('d', 'd4');

model.physics('pfl').prop('FluidType').set('fluidmodel', 'powerlaw');
model.physics('pfl').feature('fp1').set('m', 1.4);
model.physics('pfl').feature('fp1').set('n', 0.4);
model.physics('pfl').feature('pipe1').set('shape', 'Round');
model.physics('pfl').feature('pipe1').set('innerd', 'd');
model.physics('pfl').create('inl1', 'Inlet', 0);
model.physics('pfl').feature('inl1').selection.set([1]);
model.physics('pfl').feature('inl1').set('spec', 1);
model.physics('pfl').feature('inl1').set('qv0', 'Qv0');

model.sol.create('sol1');
model.sol('sol1').study('std1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'stat');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').set('control', 'stat');
model.sol('sol1').create('s1', 'Stationary');
model.sol('sol1').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('s1').feature('fc1').set('dtech', 'auto');
model.sol('sol1').feature('s1').feature('fc1').set('initstep', 0.1);
model.sol('sol1').feature('s1').feature('fc1').set('minstep', 1.0E-6);
model.sol('sol1').feature('s1').feature('fc1').set('maxiter', 35);
model.sol('sol1').feature('s1').feature('fc1').set('linsolver', 'dDef');
model.sol('sol1').feature('s1').feature('fc1').set('dtech', 'auto');
model.sol('sol1').feature('s1').feature('fc1').set('initstep', 0.1);
model.sol('sol1').feature('s1').feature('fc1').set('minstep', 1.0E-6);
model.sol('sol1').feature('s1').feature('fc1').set('maxiter', 35);
model.sol('sol1').feature('s1').feature.remove('fcDef');
model.sol('sol1').attach('std1');
model.sol('sol1').runAll;

model.result.create('pg1', 'PlotGroup2D');
model.result('pg1').label('Pressure (pfl)');
model.result('pg1').set('data', 'dset1');
model.result('pg1').set('defaultPlotID', 'pipeflow_FlowInPipes/phys1/pdef1/pcond1/pg2');
model.result('pg1').feature.create('line1', 'Line');
model.result('pg1').feature('line1').set('linetype', 'tube');
model.result('pg1').feature('line1').set('radiusexpr', '0.5*pfl.dh');
model.result('pg1').feature('line1').set('smooth', 'internal');
model.result('pg1').feature('line1').set('data', 'parent');
model.result.create('pg2', 'PlotGroup2D');
model.result('pg2').label('Velocity (pfl)');
model.result('pg2').set('data', 'dset1');
model.result('pg2').set('defaultPlotID', 'pipeflow_FlowInPipes/phys1/pdef1/pcond1/pg3');
model.result('pg2').feature.create('arwl1', 'ArrowLine');
model.result('pg2').feature('arwl1').set('arrowcount', 15);
model.result('pg2').feature('arwl1').set('arrowlength', 'normalized');
model.result('pg2').feature('arwl1').set('data', 'parent');
model.result('pg2').feature('arwl1').feature.create('col1', 'Color');
model.result('pg2').feature('arwl1').feature('col1').set('showcolordata', 'off');
model.result('pg2').feature('arwl1').feature('col1').set('expr', 'pfl.U');
model.result('pg1').run;
model.result('pg1').run;
model.result('pg1').feature('line1').create('hght1', 'Height');
model.result('pg1').run;
model.result('pg1').feature('line1').feature('hght1').set('heightdata', 'expr');
model.result('pg1').feature('line1').feature('hght1').set('expr', 'pfl.ptot');
model.result('pg1').feature('line1').feature('hght1').set('descr', 'Total pressure');
model.result('pg1').run;
model.result('pg1').create('arwl1', 'ArrowLine');
model.result('pg1').feature('arwl1').set('titletype', 'none');
model.result('pg1').feature('arwl1').set('arrowlength', 'normalized');
model.result('pg1').feature('arwl1').set('arrowbase', 'center');
model.result('pg1').feature('arwl1').set('scaleactive', true);
model.result('pg1').feature('arwl1').set('scale', 3.5);
model.result('pg1').feature('arwl1').set('arrowcount', 14);
model.result('pg1').feature('arwl1').set('color', 'blue');
model.result('pg1').run;
model.result('pg2').run;
model.result('pg2').create('line1', 'Line');
model.result('pg2').feature('line1').set('expr', 'pfl.ReMR');
model.result('pg2').feature('line1').set('descr', 'Power law Reynolds number');
model.result('pg2').feature('line1').set('linetype', 'tube');
model.result('pg2').feature('line1').create('hght1', 'Height');
model.result('pg2').run;
model.result('pg2').run;
model.result('pg2').run;
model.result('pg2').feature('arwl1').feature('col1').set('colorlegend', false);
model.result('pg2').run;
model.result('pg2').set('edges', false);
model.result('pg2').run;
model.result('pg2').set('showlegendsmaxmin', true);
model.result('pg2').set('showlegendsunit', true);
model.result('pg2').run;
model.result('pg2').feature('line1').set('smooth', 'internal');
model.result('pg2').run;
model.result.numerical.create('pev1', 'EvalPoint');
model.result.numerical('pev1').selection.set([2 4]);
model.result.numerical('pev1').setIndex('expr', 'pfl.Qv', 0);
model.result.numerical('pev1').setIndex('unit', 'm^3/min', 0);
model.result.numerical('pev1').setIndex('descr', 'Volumetric flow rate magnitude', 0);
model.result.table.create('tbl1', 'Table');
model.result.table('tbl1').comments('Point Evaluation 1');
model.result.numerical('pev1').set('table', 'tbl1');
model.result.numerical('pev1').setResult;

model.title('Slurry Transport');

model.description('This example models a coal slurry being transported in a pipe system where the pipe diameter changes in different sections. The slurry behaves as a non-Newtonian fluid described by the power-law model. The results provide the flow rate in different sections of the piping and the total pressure drop across the system.');

model.mesh.clearMeshes;

model.sol('sol1').clearSolutionData;

model.label('slurry_transport.mph');

model.modelNode.label('Components');

out = model;
