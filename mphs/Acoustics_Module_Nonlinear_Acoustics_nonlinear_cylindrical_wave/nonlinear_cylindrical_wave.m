function out = model
%
% nonlinear_cylindrical_wave.m
%
% Model exported on May 26 2025, 21:25 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/Acoustics_Module/Nonlinear_Acoustics');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 2);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.physics.create('nate', 'NonlinearPressureAcousticsTimeExplicit', 'geom1');
model.physics('nate').model('comp1');

model.study.create('std1');
model.study('std1').create('time', 'Transient');
model.study('std1').feature('time').setSolveFor('/physics/nate', true);

% To import content from file, use:
% model.param.loadFile('FILENAME');
model.param.set('P0', '0.1', 'Source pressure amplitude');
model.param.set('beta', '1', 'Coefficient of nonlinearity');
model.param.set('N', '5', 'Number of harmonics to resolve');
model.param.set('r0', '1', 'Inner radius');
model.param.set('r_sh', 'r0*(1 + 1/(4*pi*beta*P0*r0))^2', 'Shock formation radius');
model.param.set('a', '0.7', 'Relative distance to shock');
model.param.set('tau', '0', 'Retarded time');

model.baseSystem('none');

model.geom('geom1').create('c1', 'Circle');
model.geom('geom1').feature('c1').set('r', 'r0');
model.geom('geom1').feature('c1').set('angle', 45);
model.geom('geom1').run('c1');
model.geom('geom1').feature.duplicate('c2', 'c1');
model.geom('geom1').feature('c2').set('r', '5*r0');
model.geom('geom1').run('c2');
model.geom('geom1').create('dif1', 'Difference');
model.geom('geom1').feature('dif1').selection('input').set({'c2'});
model.geom('geom1').feature('dif1').selection('input2').set({'c1'});
model.geom('geom1').runPre('fin');
model.geom('geom1').run;

model.physics('nate').prop('Limiter').set('Limiter', 'WENO');
model.physics('nate').prop('ShapeProperty').set('shapeorder', 1);
model.physics('nate').feature('natem1').set('c_mat', 'userdef');
model.physics('nate').feature('natem1').set('c', 1);
model.physics('nate').feature('natem1').set('rho_mat', 'userdef');
model.physics('nate').feature('natem1').set('rho', 1);
model.physics('nate').feature('natem1').set('CoefficientOfNonlinearity', 'UserDefined');
model.physics('nate').feature('natem1').set('beta', 'beta');
model.physics('nate').create('pr1', 'Pressure', 1);
model.physics('nate').feature('pr1').selection.set([3]);
model.physics('nate').feature('pr1').set('p0', 'P0*sin(2*pi*t)');
model.physics('nate').create('imp1', 'Impedance', 1);
model.physics('nate').feature('imp1').selection.set([4]);
model.physics('nate').feature('imp1').set('PressureVelocityRelation', 'SecondOrder');

model.mesh('mesh1').create('ftri1', 'FreeTri');
model.mesh('mesh1').feature('size').set('custom', true);
model.mesh('mesh1').feature('size').set('hmax', '1/10/N');
model.mesh('mesh1').run;

model.study('std1').label('Study 1 - Numerical');

model.sol.create('sol1');
model.sol('sol1').study('std1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'time');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').set('control', 'time');
model.sol('sol1').create('t1', 'Time');
model.sol('sol1').feature('t1').set('odesolvertype', 'explicit');
model.sol('sol1').feature('t1').set('timemethodexp', 'erk');
model.sol('sol1').feature('t1').set('tlist', 'range(0,0.1,1)');
model.sol('sol1').feature('t1').set('plot', 'off');
model.sol('sol1').feature('t1').set('plotgroup', 'Default');
model.sol('sol1').feature('t1').set('plotfreq', 'tout');
model.sol('sol1').feature('t1').set('probesel', 'all');
model.sol('sol1').feature('t1').set('probes', {});
model.sol('sol1').feature('t1').set('probefreq', 'tsteps');
model.sol('sol1').feature('t1').set('exprs', {'root.comp1.nate.wtc'});
model.sol('sol1').feature('t1').set('tstepping', 'elemexprs');
model.sol('sol1').feature('t1').set('control', 'time');
model.sol('sol1').feature('t1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('t1').feature('fc1').set('linsolver', 'dDef');
model.sol('sol1').feature('t1').feature.remove('fcDef');
model.sol('sol1').attach('std1');
model.sol('sol1').feature('t1').set('erkorder', 3);
model.sol('sol1').feature('t1').set('updtstep', 'manual');

model.study('std1').feature('time').set('tlist', 'range(0, 1/50, 5)');

model.sol('sol1').runAll;

model.result.create('pg1', 'PlotGroup2D');
model.result('pg1').label('Acoustic Pressure (nate)');
model.result('pg1').set('showlegendsunit', true);
model.result('pg1').set('data', 'dset1');
model.result('pg1').setIndex('looplevel', 251, 0);
model.result('pg1').set('defaultPlotID', 'pressureacoustics/NonlinearPressureAcousticsTimeExplicit/phys1/pdef1/pcond2/pg1');
model.result('pg1').feature.create('surf1', 'Surface');
model.result('pg1').feature('surf1').label('Surface');
model.result('pg1').feature('surf1').set('colortable', 'Wave');
model.result('pg1').feature('surf1').set('colorscalemode', 'linearsymmetric');
model.result('pg1').feature('surf1').set('resolution', 'custom');
model.result('pg1').feature('surf1').set('refine', 6);
model.result('pg1').feature('surf1').set('smooth', 'internal');
model.result('pg1').feature('surf1').set('data', 'parent');
model.result.create('pg2', 'PlotGroup2D');
model.result('pg2').label('Acoustic Velocity (nate)');
model.result('pg2').set('showlegendsunit', true);
model.result('pg2').set('data', 'dset1');
model.result('pg2').setIndex('looplevel', 251, 0);
model.result('pg2').set('defaultPlotID', 'pressureacoustics/NonlinearPressureAcousticsTimeExplicit/phys1/pdef1/pcond2/pg2');
model.result('pg2').feature.create('surf1', 'Surface');
model.result('pg2').feature('surf1').label('Surface');
model.result('pg2').feature('surf1').set('expr', 'nate.v_inst');
model.result('pg2').feature('surf1').set('resolution', 'custom');
model.result('pg2').feature('surf1').set('refine', 6);
model.result('pg2').feature('surf1').set('smooth', 'internal');
model.result('pg2').feature('surf1').set('data', 'parent');
model.result('pg2').feature.create('arws1', 'ArrowSurface');
model.result('pg2').feature('arws1').label('Arrow Surface');
model.result('pg2').feature('arws1').set('color', 'white');
model.result('pg2').feature('arws1').set('data', 'parent');
model.result('pg1').run;
model.result.create('pg3', 'PlotGroup1D');
model.result('pg3').run;
model.result('pg3').set('titletype', 'manual');
model.result('pg3').set('title', 'Acoustic pressure along radial line');
model.result('pg3').setIndex('looplevelinput', 'last', 0);
model.result('pg3').label('Acoustic Pressure, Line');
model.result('pg3').create('lngr1', 'LineGraph');
model.result('pg3').feature('lngr1').set('markerpos', 'datapoints');
model.result('pg3').feature('lngr1').set('linewidth', 'preference');
model.result('pg3').feature('lngr1').selection.set([2]);
model.result('pg3').feature('lngr1').set('xdata', 'expr');
model.result('pg3').feature('lngr1').set('xdataexpr', 'x');
model.result('pg3').feature('lngr1').set('linewidth', 2);
model.result('pg3').feature.duplicate('lngr2', 'lngr1');
model.result('pg3').run;
model.result('pg3').feature('lngr2').set('xdataexpr', 'r_sh');
model.result('pg3').run;
model.result('pg3').feature('lngr2').set('legend', true);
model.result('pg3').feature('lngr2').set('legendmethod', 'manual');
model.result('pg3').feature('lngr2').setIndex('legends', 'Shock formation distance', 0);
model.result('pg3').run;
model.result('pg3').run;
model.result('pg3').run;
model.result.create('pg4', 'PlotGroup1D');
model.result('pg4').run;
model.result('pg4').label('Acoustic Pressure, Frequency Spectrum');
model.result('pg4').setIndex('looplevelinput', 'interp', 0);
model.result('pg4').setIndex('interp', 'range(4, 1/50, 5)', 0);
model.result('pg4').set('titletype', 'manual');
model.result('pg4').set('title', 'Acoustic pressure, frequency spectrum');
model.result('pg4').create('ptgr1', 'PointGraph');
model.result('pg4').feature('ptgr1').set('markerpos', 'datapoints');
model.result('pg4').feature('ptgr1').set('linewidth', 'preference');
model.result('pg4').feature('ptgr1').selection.set([2]);
model.result('pg4').feature('ptgr1').set('xdata', 'fourier');
model.result('pg4').feature('ptgr1').set('fouriershow', 'spectrum');
model.result('pg4').feature('ptgr1').set('scale', 'multiplyperiod');
model.result('pg4').feature('ptgr1').set('freqrangeactive', true);
model.result('pg4').feature('ptgr1').set('freqmax', 'N');
model.result('pg4').feature('ptgr1').set('linestyle', 'none');
model.result('pg4').feature('ptgr1').set('linemarker', 'point');
model.result('pg4').feature('ptgr1').set('legend', true);
model.result('pg4').feature('ptgr1').set('legendmethod', 'manual');
model.result('pg4').feature('ptgr1').setIndex('legends', 'Inner boundary', 0);
model.result('pg4').feature.duplicate('ptgr2', 'ptgr1');
model.result('pg4').run;
model.result('pg4').feature('ptgr2').selection.set([4]);
model.result('pg4').feature('ptgr2').set('linemarker', 'asterisk');
model.result('pg4').feature('ptgr2').set('markerpos', 'interp');
model.result('pg4').feature('ptgr2').setIndex('legends', 'Outer boundary', 0);
model.result('pg4').run;

model.physics.create('ge', 'GlobalEquations', 'geom1');
model.physics('ge').model('comp1');

model.study('std1').feature('time').setSolveFor('/physics/ge', false);

model.physics('ge').prop('EquationForm').set('form', 'Automatic');
model.physics('ge').feature('ge1').setIndex('name', 'pa', 0, 0);
model.physics('ge').feature('ge1').setIndex('equation', 'pa - P0*sqrt(r0/(a*r_sh))*sin(2*pi*(tau + 2*(sqrt(a*r_sh*r0) - r0)*beta*pa))', 0, 0);
model.physics('ge').feature('ge1').setIndex('description', 'Analytical solution', 0, 0);

model.study.create('std2');
model.study('std2').create('stat', 'Stationary');
model.study('std2').feature('stat').setSolveFor('/physics/nate', false);
model.study('std2').feature('stat').setSolveFor('/physics/ge', true);
model.study('std2').label('Study 2 - Analytical');
model.study('std2').setGenPlots(false);
model.study('std2').create('param', 'Parametric');
model.study('std2').feature('param').setIndex('pname', 'P0', 0);
model.study('std2').feature('param').setIndex('plistarr', '', 0);
model.study('std2').feature('param').setIndex('punit', '', 0);
model.study('std2').feature('param').setIndex('pname', 'P0', 0);
model.study('std2').feature('param').setIndex('plistarr', '', 0);
model.study('std2').feature('param').setIndex('punit', '', 0);
model.study('std2').feature('param').setIndex('pname', 'tau', 0);
model.study('std2').feature('param').setIndex('plistarr', 'range(0, 1/50, 5)', 0);
model.study('std2').feature('param').setIndex('punit', '', 0);

model.sol.create('sol2');
model.sol('sol2').study('std2');
model.sol('sol2').create('st1', 'StudyStep');
model.sol('sol2').feature('st1').set('study', 'std2');
model.sol('sol2').feature('st1').set('studystep', 'stat');
model.sol('sol2').create('v1', 'Variables');
model.sol('sol2').feature('v1').set('control', 'stat');
model.sol('sol2').create('s1', 'Stationary');
model.sol('sol2').feature('s1').create('p1', 'Parametric');
model.sol('sol2').feature('s1').feature('p1').set('pname', {'tau'});
model.sol('sol2').feature('s1').feature('p1').set('plistarr', {'range(0, 1/50, 5)'});
model.sol('sol2').feature('s1').feature('p1').set('punit', {''});
model.sol('sol2').feature('s1').feature('p1').set('sweeptype', 'sparse');
model.sol('sol2').feature('s1').feature('p1').set('preusesol', 'no');
model.sol('sol2').feature('s1').feature('p1').set('pcontinuationmode', 'no');
model.sol('sol2').feature('s1').feature('p1').set('plot', 'off');
model.sol('sol2').feature('s1').feature('p1').set('plotgroup', 'pg1');
model.sol('sol2').feature('s1').feature('p1').set('probesel', 'all');
model.sol('sol2').feature('s1').feature('p1').set('probes', {});
model.sol('sol2').feature('s1').feature('p1').set('control', 'param');
model.sol('sol2').feature('s1').set('control', 'stat');
model.sol('sol2').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol2').feature('s1').feature('fc1').set('linsolver', 'dDef');
model.sol('sol2').feature('s1').feature.remove('fcDef');
model.sol('sol2').attach('std2');
model.sol('sol2').runAll;

model.result.dataset.create('cpt1', 'CutPoint2D');
model.result.dataset('cpt1').set('pointx', 'a*r_sh');
model.result.dataset('cpt1').set('pointy', 0);
model.result.create('pg5', 'PlotGroup1D');
model.result('pg5').run;
model.result('pg5').label('Acoustic Pressure, Point');
model.result('pg5').set('titletype', 'manual');
model.result('pg5').set('title', 'Acoustic pressure at point');
model.result('pg5').set('data', 'none');
model.result('pg5').create('ptgr1', 'PointGraph');
model.result('pg5').feature('ptgr1').set('markerpos', 'datapoints');
model.result('pg5').feature('ptgr1').set('linewidth', 'preference');
model.result('pg5').feature('ptgr1').set('data', 'cpt1');
model.result('pg5').feature('ptgr1').set('linewidth', 2);
model.result('pg5').feature('ptgr1').set('legend', true);
model.result('pg5').feature('ptgr1').set('legendmethod', 'manual');
model.result('pg5').feature('ptgr1').setIndex('legends', 'Numerical solution', 0);
model.result('pg5').run;
model.result('pg5').create('glob1', 'Global');
model.result('pg5').feature('glob1').set('markerpos', 'datapoints');
model.result('pg5').feature('glob1').set('linewidth', 'preference');
model.result('pg5').feature('glob1').set('data', 'dset2');
model.result('pg5').feature('glob1').set('xdata', 'expr');
model.result('pg5').feature('glob1').set('xdataexpr', 'tau + (a*r_sh - r0)');
model.result('pg5').feature('glob1').set('linewidth', 2);
model.result('pg5').run;
model.result('pg1').run;
model.result('pg1').setIndex('looplevel', 51, 0);
model.result('pg1').run;
model.result('pg1').setIndex('looplevel', 101, 0);
model.result('pg1').run;
model.result('pg1').setIndex('looplevel', 151, 0);
model.result('pg1').run;
model.result('pg1').setIndex('looplevel', 201, 0);
model.result('pg1').run;
model.result('pg1').stepLast(0);
model.result('pg1').run;

model.title(['Nonlinear Propagation of a Cylindrical Wave ' native2unicode(hex2dec({'20' '14'}), 'unicode') ' Verification Model']);

model.description(['This model example shows how to model nonlinear propagation of a cylindrical wave using the Nonlinear Pressure Acoustics, Time Explicit physics interface available in Acoustics Module of COMSOL Multiphysics. The interface implements the system of nonlinear acoustic equations in the form of a hyperbolic conservation law using the time-explicit discontinuous Galerkin finite element method.' newline  newline 'This example analyzes the wave propagation in a lossless media over distances larger that the shock formation distance. Thus the tutorial puts a special emphasis on the techniques necessary for treating solution discontinuities, such as limiters, discretization, and solver settings. The numerical solution is compared to the analytical solution valid at the distances before the shock formation.']);

model.mesh.clearMeshes;

model.sol('sol1').clearSolutionData;
model.sol('sol2').clearSolutionData;

model.label('nonlinear_cylindrical_wave.mph');

model.modelNode.label('Components');

out = model;
