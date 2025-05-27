function out = model
%
% squeeze_film_disc.m
%
% Model exported on May 26 2025, 21:30 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/MEMS_Module/Sensors');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 2);
model.geom('geom1').model('comp1');
model.geom('geom1').axisymmetric(true);

model.mesh.create('mesh1', 'geom1');

model.physics.create('tff', 'ThinFilmFlowEdge', 'geom1');
model.physics('tff').model('comp1');

model.study.create('std1');
model.study('std1').create('freq', 'Frequency');
model.study('std1').feature('freq').setSolveFor('/physics/tff', true);

model.param.set('r0', '1[mm]');
model.param.descr('r0', 'Disc radius');
model.param.set('h0', '10[um]');
model.param.descr('h0', 'Gap height');
model.param.set('dh', 'dhND*h0');
model.param.descr('dh', 'Change in gap height');
model.param.set('dhND', '0.01');
model.param.descr('dhND', 'Fractional gap height change.');
model.param.set('mu0', '1e-5[Pa*s]');
model.param.descr('mu0', 'Gas viscosity');
model.param.set('f0', '1000[Hz]');
model.param.descr('f0', 'Vibration frequency');

model.geom('geom1').create('ls1', 'LineSegment');
model.geom('geom1').feature('ls1').set('specify1', 'coord');
model.geom('geom1').feature('ls1').set('specify2', 'coord');
model.geom('geom1').feature('ls1').set('coord2', {'r0' '0'});
model.geom('geom1').runPre('fin');

model.cpl.create('intop1', 'Integration', 'geom1');

model.geom('geom1').run;

model.cpl('intop1').set('axisym', true);
model.cpl('intop1').selection.geom('geom1', 1);
model.cpl('intop1').selection.set([1]);

model.variable.create('var1');
model.variable('var1').model('comp1');
model.variable('var1').set('Ftot', 'intop1(tff.fwallz)');
model.variable('var1').descr('Ftot', 'Total force on disc');
model.variable('var1').set('Ftotan', '-3*pi*mu0*vf*r0^4/(2*h0^3)');
model.variable('var1').descr('Ftotan', 'Analytic expression');
model.variable('var1').set('vf', '2*pi*f0*dh');
model.variable('var1').descr('vf', 'Disc velocity');
model.variable('var1').set('Ftotantime', '-6*pi^2*mu0*f0*r0^4*dh*cos(2*pi*f0*t)/(2*(h0+dh*sin(2*pi*f0*t))^3)');
model.variable('var1').descr('Ftotantime', 'Analytic expression');

model.func.create('an1', 'Analytic');
model.func('an1').model('comp1');
model.func('an1').set('funcname', 'Pan');
model.func('an1').set('expr', '-6*pi*mu0*f0*dh*(r0^2-rf^2)/h0^3');
model.func('an1').set('args', 'rf');
model.func('an1').setIndex('argunit', 'm', 0);
model.func('an1').set('fununit', 'Pa');

model.material.create('mat1', 'Common', 'comp1');
model.material('mat1').propertyGroup('def').set('dynamicviscosity', {'mu0'});

model.physics('tff').prop('EquationType').set('EquationType', 'ModifiedReynoldsEquation');
model.physics('tff').feature('ffp1').set('WallNormal', 'InverseOrientation');
model.physics('tff').feature('ffp1').set('hw1', 'h0');
model.physics('tff').feature('ffp1').set('uw_src', 'Off');
model.physics('tff').feature('ffp1').set('TangentialWallVelocity', 'userdef');
model.physics('tff').feature('ffp1').set('vw', {'0' '0' 'vf'});
model.physics('tff').feature.duplicate('ffp2', 'ffp1');
model.physics('tff').feature('ffp2').set('uw_src', 'userdef');
model.physics('tff').feature('ffp2').set('uw', {'0' '0' 'dh*sin(2*pi*f0*t)'});
model.physics('tff').feature('ffp2').set('TangentialWallVelocity', 'FromDeformation');

model.mesh('mesh1').autoMeshSize(2);
model.mesh('mesh1').run;

model.study('std1').feature('freq').set('plist', 1000);
model.study('std1').feature('freq').set('useadvanceddisable', true);
model.study('std1').feature('freq').set('disabledphysics', {'tff/ffp2'});

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
model.sol('sol1').feature('s1').feature('p1').set('plistarr', {'1000'});
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
model.sol('sol1').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('s1').feature('fc1').set('dtech', 'auto');
model.sol('sol1').feature('s1').feature('fc1').set('initstep', 0.01);
model.sol('sol1').feature('s1').feature('fc1').set('minstep', 1.0E-6);
model.sol('sol1').feature('s1').feature('fc1').set('maxiter', 50);
model.sol('sol1').feature('s1').create('d1', 'Direct');
model.sol('sol1').feature('s1').feature('d1').set('linsolver', 'pardiso');
model.sol('sol1').feature('s1').feature('d1').set('pivotperturb', 1.0E-13);
model.sol('sol1').feature('s1').feature('d1').label('Direct, pressure (tff)');
model.sol('sol1').feature('s1').feature('fc1').set('linsolver', 'd1');
model.sol('sol1').feature('s1').feature('fc1').set('dtech', 'auto');
model.sol('sol1').feature('s1').feature('fc1').set('initstep', 0.01);
model.sol('sol1').feature('s1').feature('fc1').set('minstep', 1.0E-6);
model.sol('sol1').feature('s1').feature('fc1').set('maxiter', 50);
model.sol('sol1').feature('s1').feature.remove('fcDef');
model.sol('sol1').attach('std1');
model.sol('sol1').runAll;

model.result.dataset.create('rev1', 'Revolve2D');
model.result.dataset('rev1').label('Revolution 2D');
model.result.dataset('rev1').set('data', 'dset1');
model.result.create('pg1', 'PlotGroup3D');
model.result('pg1').label('Fluid Pressure (tff)');
model.result('pg1').set('data', 'rev1');
model.result('pg1').setIndex('looplevel', 1, 0);
model.result('pg1').set('defaultPlotID', 'ThinFilmFlowEdge/phys1/pdef1/pcond3/pg1');
model.result('pg1').feature.create('surf1', 'Surface');
model.result('pg1').feature('surf1').set('showsolutionparams', 'on');
model.result('pg1').feature('surf1').set('smooth', 'internal');
model.result('pg1').feature('surf1').set('showsolutionparams', 'on');
model.result('pg1').feature('surf1').set('data', 'parent');
model.result('pg1').run;
model.result.create('pg2', 'PlotGroup1D');
model.result('pg2').run;
model.result('pg2').set('xlabelactive', true);
model.result('pg2').set('xlabel', 'Radial distance (m)');
model.result('pg2').set('ylabelactive', true);
model.result('pg2').set('ylabel', 'Pressure (Pa)');
model.result('pg2').set('legendpos', 'upperleft');
model.result('pg2').create('lngr1', 'LineGraph');
model.result('pg2').feature('lngr1').set('markerpos', 'datapoints');
model.result('pg2').feature('lngr1').set('linewidth', 'preference');
model.result('pg2').feature('lngr1').selection.set([1]);
model.result('pg2').feature('lngr1').set('legend', true);
model.result('pg2').feature('lngr1').set('legendmethod', 'manual');
model.result('pg2').feature('lngr1').setIndex('legends', 'COMSOL', 0);
model.result('pg2').run;
model.result('pg2').create('lngr2', 'LineGraph');
model.result('pg2').feature('lngr2').set('markerpos', 'datapoints');
model.result('pg2').feature('lngr2').set('linewidth', 'preference');
model.result('pg2').feature('lngr2').selection.set([1]);
model.result('pg2').feature('lngr2').set('expr', 'Pan(r)');
model.result('pg2').feature('lngr2').set('linestyle', 'none');
model.result('pg2').feature('lngr2').set('linemarker', 'cycle');
model.result('pg2').feature('lngr2').set('markerpos', 'interp');
model.result('pg2').feature('lngr2').set('legend', true);
model.result('pg2').feature('lngr2').set('legendmethod', 'manual');
model.result('pg2').feature('lngr2').setIndex('legends', 'Analytic Solution', 0);
model.result('pg2').run;
model.result('pg2').run;
model.result('pg2').label('Radial Pressure');
model.result.create('pg3', 'PlotGroup2D');
model.result('pg3').run;
model.result('pg3').create('arwl1', 'ArrowLine');
model.result('pg3').feature('arwl1').set('expr', {'tff.fwallr' 'tff.fwallz'});
model.result('pg3').feature('arwl1').set('descr', 'Fluid load on wall');
model.result('pg3').feature('arwl1').set('arrowcount', 30);
model.result('pg3').feature('arwl1').set('scaleactive', true);
model.result('pg3').feature('arwl1').set('scale', '2.2e-6');
model.result('pg3').run;
model.result('pg3').run;
model.result('pg3').create('line1', 'Line');
model.result('pg3').feature('line1').set('expr', 'tff.fwallz');
model.result('pg3').feature('line1').set('descr', 'Fluid load on wall, z-component');
model.result('pg3').feature('line1').set('colortabletrans', 'reverse');
model.result('pg3').run;
model.result('pg3').run;
model.result('pg3').label('Wall Load');
model.result.numerical.create('gev1', 'EvalGlobal');
model.result.numerical('gev1').setIndex('expr', 'abs(Ftot)', 0);
model.result.table.create('tbl1', 'Table');
model.result.table('tbl1').comments('Global Evaluation 1');
model.result.numerical('gev1').set('table', 'tbl1');
model.result.numerical('gev1').setResult;
model.result.numerical.create('gev2', 'EvalGlobal');
model.result.numerical('gev2').set('expr', {'Ftotan'});
model.result.numerical('gev2').set('descr', {'Analytic expression'});
model.result.numerical('gev2').set('unit', {'N'});
model.result.numerical('gev2').set('table', 'tbl1');
model.result.numerical('gev2').appendResult;

model.study.create('std2');
model.study('std2').create('time', 'Transient');
model.study('std2').feature('time').setSolveFor('/physics/tff', true);
model.study('std2').feature('time').set('tlist', 'range(0,1/(40*f0),5/f0)');
model.study('std2').feature('time').set('useparam', true);
model.study('std2').feature('time').setIndex('pname', 'r0', 0);
model.study('std2').feature('time').setIndex('plistarr', '', 0);
model.study('std2').feature('time').setIndex('punit', 'm', 0);
model.study('std2').feature('time').setIndex('pname', 'r0', 0);
model.study('std2').feature('time').setIndex('plistarr', '', 0);
model.study('std2').feature('time').setIndex('punit', 'm', 0);
model.study('std2').feature('time').setIndex('pname', 'dhND', 0);
model.study('std2').feature('time').setIndex('plistarr', '0.01 0.1 0.2 0.3', 0);

model.sol.create('sol2');
model.sol('sol2').study('std2');
model.sol('sol2').create('st1', 'StudyStep');
model.sol('sol2').feature('st1').set('study', 'std2');
model.sol('sol2').feature('st1').set('studystep', 'time');
model.sol('sol2').create('v1', 'Variables');
model.sol('sol2').feature('v1').set('control', 'time');
model.sol('sol2').create('t1', 'Time');
model.sol('sol2').feature('t1').set('tlist', 'range(0,1/(40*f0),5/f0)');
model.sol('sol2').feature('t1').set('plot', 'off');
model.sol('sol2').feature('t1').set('plotgroup', 'pg1');
model.sol('sol2').feature('t1').set('plotfreq', 'tout');
model.sol('sol2').feature('t1').set('probesel', 'all');
model.sol('sol2').feature('t1').set('probes', {});
model.sol('sol2').feature('t1').set('probefreq', 'tsteps');
model.sol('sol2').feature('t1').set('rtol', 0.005);
model.sol('sol2').feature('t1').set('atolglobalvaluemethod', 'factor');
model.sol('sol2').feature('t1').set('reacf', true);
model.sol('sol2').feature('t1').set('storeudot', true);
model.sol('sol2').feature('t1').set('endtimeinterpolation', true);
model.sol('sol2').feature('t1').set('maxorder', 2);
model.sol('sol2').feature('t1').set('stabcntrl', true);
model.sol('sol2').feature('t1').create('tp1', 'TimeParametric');
model.sol('sol2').feature('t1').feature.remove('tpDef');
model.sol('sol2').feature('t1').feature('tp1').set('control', 'time');
model.sol('sol2').feature('t1').set('control', 'time');
model.sol('sol2').feature('t1').feature('aDef').set('cachepattern', true);
model.sol('sol2').feature('t1').create('fc1', 'FullyCoupled');
model.sol('sol2').feature('t1').feature('fc1').set('jtech', 'once');
model.sol('sol2').feature('t1').feature('fc1').set('damp', 0.9);
model.sol('sol2').feature('t1').feature('fc1').set('maxiter', 8);
model.sol('sol2').feature('t1').feature('fc1').set('stabacc', 'aacc');
model.sol('sol2').feature('t1').feature('fc1').set('aaccdim', 5);
model.sol('sol2').feature('t1').feature('fc1').set('aaccmix', 0.9);
model.sol('sol2').feature('t1').feature('fc1').set('aaccdelay', 1);
model.sol('sol2').feature('t1').create('d1', 'Direct');
model.sol('sol2').feature('t1').feature('d1').set('linsolver', 'pardiso');
model.sol('sol2').feature('t1').feature('d1').set('pivotperturb', 1.0E-13);
model.sol('sol2').feature('t1').feature('d1').label('Direct, pressure (tff)');
model.sol('sol2').feature('t1').feature('fc1').set('linsolver', 'd1');
model.sol('sol2').feature('t1').feature('fc1').set('jtech', 'once');
model.sol('sol2').feature('t1').feature('fc1').set('damp', 0.9);
model.sol('sol2').feature('t1').feature('fc1').set('maxiter', 8);
model.sol('sol2').feature('t1').feature('fc1').set('stabacc', 'aacc');
model.sol('sol2').feature('t1').feature('fc1').set('aaccdim', 5);
model.sol('sol2').feature('t1').feature('fc1').set('aaccmix', 0.9);
model.sol('sol2').feature('t1').feature('fc1').set('aaccdelay', 1);
model.sol('sol2').feature('t1').feature.remove('fcDef');
model.sol('sol2').attach('std2');
model.sol('sol2').runAll;

model.result.dataset.create('rev2', 'Revolve2D');
model.result.dataset('rev2').label('Revolution 2D 1');
model.result.dataset('rev2').set('data', 'dset2');
model.result.create('pg4', 'PlotGroup3D');
model.result('pg4').label('Fluid Pressure (tff) 1');
model.result('pg4').set('data', 'rev2');
model.result('pg4').setIndex('looplevel', 201, 0);
model.result('pg4').setIndex('looplevel', 4, 1);
model.result('pg4').set('data', 'rev2');
model.result('pg4').setIndex('looplevel', 201, 0);
model.result('pg4').setIndex('looplevel', 4, 1);
model.result('pg4').set('defaultPlotID', 'ThinFilmFlowEdge/phys1/pdef1/pcond3/pg1');
model.result('pg4').feature.create('surf1', 'Surface');
model.result('pg4').feature('surf1').set('showsolutionparams', 'on');
model.result('pg4').feature('surf1').set('smooth', 'internal');
model.result('pg4').feature('surf1').set('showsolutionparams', 'on');
model.result('pg4').feature('surf1').set('data', 'parent');
model.result('pg4').run;
model.result.create('pg5', 'PlotGroup1D');
model.result('pg5').run;
model.result('pg5').set('data', 'dset2');
model.result('pg5').create('ptgr1', 'PointGraph');
model.result('pg5').feature('ptgr1').set('markerpos', 'datapoints');
model.result('pg5').feature('ptgr1').set('linewidth', 'preference');
model.result('pg5').feature('ptgr1').selection.set([1]);
model.result('pg5').feature('ptgr1').set('expr', 'tff.hw');
model.result('pg5').feature('ptgr1').set('descr', 'Height of wall above reference plane');
model.result('pg5').run;
model.result('pg5').feature('ptgr1').set('legend', true);
model.result('pg5').run;
model.result('pg5').set('axislimits', true);
model.result('pg5').set('ymin', 0);
model.result('pg5').set('legendpos', 'lowerright');
model.result('pg5').run;
model.result('pg5').label('Wall height vs. time');
model.result('pg5').run;
model.result.create('pg6', 'PlotGroup1D');
model.result('pg6').run;
model.result('pg6').set('data', 'dset2');
model.result('pg6').create('ptgr1', 'PointGraph');
model.result('pg6').feature('ptgr1').set('markerpos', 'datapoints');
model.result('pg6').feature('ptgr1').set('linewidth', 'preference');
model.result('pg6').feature('ptgr1').selection.set([1]);
model.result('pg6').run;
model.result('pg6').run;
model.result('pg6').label('Pressure vs. time');
model.result('pg6').run;
model.result.numerical.create('pev1', 'EvalPoint');
model.result.numerical('pev1').selection.set([1]);
model.result.numerical('pev1').setIndex('expr', 'abs(pfilm)', 0);
model.result.table.create('tbl2', 'Table');
model.result.table('tbl2').comments('Point Evaluation 1');
model.result.numerical('pev1').set('table', 'tbl2');
model.result.numerical('pev1').setResult;
model.result.numerical.create('pev2', 'EvalPoint');
model.result.numerical('pev2').set('data', 'dset2');
model.result.numerical('pev2').setIndex('looplevelinput', 'manual', 1);
model.result.numerical('pev2').setIndex('looplevel', [1], 1);
model.result.numerical('pev2').selection.set([1]);
model.result.numerical('pev2').set('dataseries', 'minimum');
model.result.table.create('tbl3', 'Table');
model.result.table('tbl3').comments('Point Evaluation 2');
model.result.numerical('pev2').set('table', 'tbl3');
model.result.create('pg7', 'PlotGroup1D');
model.result('pg7').run;
model.result('pg7').set('data', 'dset2');
model.result('pg7').create('glob1', 'Global');
model.result('pg7').feature('glob1').set('markerpos', 'datapoints');
model.result('pg7').feature('glob1').set('linewidth', 'preference');
model.result('pg7').feature('glob1').set('expr', {'Ftot'});
model.result('pg7').feature('glob1').set('descr', {'Total force on disc'});
model.result('pg7').feature('glob1').set('unit', {'N'});
model.result('pg7').run;
model.result('pg7').create('glob2', 'Global');
model.result('pg7').feature('glob2').set('markerpos', 'datapoints');
model.result('pg7').feature('glob2').set('linewidth', 'preference');
model.result('pg7').feature('glob2').set('expr', {'Ftotantime'});
model.result('pg7').feature('glob2').set('descr', {'Analytic expression'});
model.result('pg7').feature('glob2').set('unit', {'N'});
model.result('pg7').feature('glob2').set('linestyle', 'dashed');
model.result('pg7').run;
model.result('pg7').set('axislimits', true);
model.result('pg7').set('xmin', 0.003);
model.result('pg7').set('xmax', 0.005);
model.result('pg7').set('legendpos', 'lowerleft');
model.result('pg7').label('Total force on disc vs. time');
model.result('pg7').run;
model.result('pg1').run;

model.title('Squeeze-Film Gas Damping of a Vibrating Disc');

model.description('This benchmark computes the total force acting on a vibrating disc in the frequency and time domains and compares both results with expressions derived analytically. When the vibration amplitude is small enough that the system is linear the frequency- and time-domain results agree well with theory. Larger amplitude vibrations, which result in a nonlinear response that cannot be modeled in the frequency domain, are explored in the time domain, and compared against analytic solutions.');

model.mesh.clearMeshes;

model.sol('sol1').clearSolutionData;
model.sol('sol2').clearSolutionData;

model.label('squeeze_film_disc.mph');

model.modelNode.label('Components');

out = model;
