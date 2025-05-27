function out = model
%
% turbomolecular_pump_quasi_2d.m
%
% Model exported on May 26 2025, 21:31 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/Particle_Tracing_Module/Vacuum_Systems');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 3);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.physics.create('pt', 'MathParticle', 'geom1');
model.physics('pt').model('comp1');

model.study.create('std1');
model.study('std1').create('time', 'Transient');
model.study('std1').feature('time').setSolveFor('/physics/pt', true);

% To import content from file, use:
% model.param.loadFile('FILENAME');
model.param.set('S0', '1', 'Blade aspect ratio');
model.param.set('C', '1', 'Velocity factor');
model.param.set('alpha', '35[deg]', 'Blade pitch angle');
model.param.set('B', '5[cm]', 'Blade length');
model.param.set('S', 'B*S0', 'Blade spacing');
model.param.set('vb', 'Vmp_H2*C', 'Most probable molecule velocity');
model.param.set('T0', '300[K]', 'Temperature');
model.param.set('Mp_H2', '0.002[kg/mol]', 'Hydrogen molar mass');
model.param.set('mp_H2', 'Mp_H2/N_A_const', 'Hydrogen molecular mass');
model.param.set('Vmp_H2', 'sqrt(2*R_const*T0/Mp_H2)', 'Most probable speed');
model.param.set('Np', '3000', 'Number of particles released');

model.variable.create('var1');
model.variable('var1').model('comp1');

model.geom('geom1').run;

model.variable('var1').set('M12', 'pt.sum(if(bndenv(pt.pcnt1.Ob)==1,1,0))/Np');
model.variable('var1').descr('M12', 'Transmission probability');
model.variable('var1').set('m12', 'pt.sum(if(bndenv(pt.pcnt1.Ob)==1,noCollision,0))/Np');
model.variable('var1').descr('m12', 'Direct transmission probability');

model.geom('geom1').lengthUnit('cm');
model.geom('geom1').create('wp1', 'WorkPlane');
model.geom('geom1').feature('wp1').set('unite', true);
model.geom('geom1').feature('wp1').geom.create('pol1', 'Polygon');
model.geom('geom1').feature('wp1').geom.feature('pol1').set('source', 'table');
model.geom('geom1').feature('wp1').geom.feature('pol1').setIndex('table', 0, 0, 0);
model.geom('geom1').feature('wp1').geom.feature('pol1').setIndex('table', 0, 0, 1);
model.geom('geom1').feature('wp1').geom.feature('pol1').setIndex('table', 'B*sin(alpha)', 1, 0);
model.geom('geom1').feature('wp1').geom.feature('pol1').setIndex('table', 'B*cos(alpha)', 1, 1);
model.geom('geom1').feature('wp1').geom.feature('pol1').setIndex('table', 'B*sin(alpha)', 2, 0);
model.geom('geom1').feature('wp1').geom.feature('pol1').setIndex('table', 'S+B*cos(alpha)', 2, 1);
model.geom('geom1').feature('wp1').geom.feature('pol1').setIndex('table', 0, 3, 0);
model.geom('geom1').feature('wp1').geom.feature('pol1').setIndex('table', 'S', 3, 1);
model.geom('geom1').feature('wp1').geom.run('pol1');
model.geom('geom1').run('wp1');
model.geom('geom1').feature.create('ext1', 'Extrude');
model.geom('geom1').feature('ext1').set('workplane', 'wp1');
model.geom('geom1').feature('ext1').selection('input').set({'wp1'});
model.geom('geom1').runPre('fin');
model.geom('geom1').run;

model.physics('pt').feature('pp1').set('mp', 'mp_H2');
model.physics('pt').create('aux1', 'AuxiliaryField', -1);
model.physics('pt').feature('aux1').set('fieldVariableName', 'noCollision');
model.physics('pt').create('inl1', 'Inlet', 2);
model.physics('pt').feature('inl1').selection.set([1]);
model.physics('pt').feature('inl1').set('InitialPosition', 'RandomPosition');
model.physics('pt').feature('inl1').setIndex('N', 'Np', 0);
model.physics('pt').feature('inl1').set('InitialVelocity', 'Thermal');
model.physics('pt').feature('inl1').set('T', 'T0');
model.physics('pt').feature('inl1').set('aux0_aux1', 1);
model.physics('pt').feature('inl1').set('SubtractMovingFrameVelocity', true);
model.physics('pt').feature('inl1').set('BackgroundVelocity', 'UserDefined');
model.physics('pt').feature('inl1').set('vb', {'0' '-vb' '0'});
model.physics('pt').feature('wall1').label('Wall 1 (Symmetry Boundaries)');
model.physics('pt').feature('wall1').set('WallCondition', 'Bounce');
model.physics('pt').create('tre1', 'ThermalReEmission', 2);
model.physics('pt').feature('tre1').selection.set([2 5]);
model.physics('pt').feature('tre1').set('T', 'T0');
model.physics('pt').feature('tre1').label('Thermal Re-Emission 1 (Blade Surfaces)');
model.physics('pt').feature('tre1').set('caux_aux1', true);
model.physics('pt').create('out1', 'Outlet', 2);
model.physics('pt').feature('out1').selection.set([1 6]);
model.physics('pt').create('pcnt1', 'ParticleCounter', 2);
model.physics('pt').feature('pcnt1').selection.set([6]);

model.mesh('mesh1').autoMeshSize(9);
model.mesh('mesh1').run;

model.study('std1').label('Sweep Over Speeds');
model.study('std1').setGenPlots(false);
model.study('std1').create('param', 'Parametric');
model.study('std1').feature('param').setIndex('pname', 'S0', 0);
model.study('std1').feature('param').setIndex('plistarr', '', 0);
model.study('std1').feature('param').setIndex('punit', '', 0);
model.study('std1').feature('param').setIndex('pname', 'S0', 0);
model.study('std1').feature('param').setIndex('plistarr', '', 0);
model.study('std1').feature('param').setIndex('punit', '', 0);
model.study('std1').feature('param').setIndex('pname', 'C', 0);
model.study('std1').feature('param').setIndex('plistarr', 'range(-10,0.5,10)', 0);
model.study('std1').feature('time').set('tunit', 'ms');
model.study('std1').feature('time').set('tlist', '0 0.2');

model.sol.create('sol1');
model.sol('sol1').study('std1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'time');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').set('control', 'time');
model.sol('sol1').create('t1', 'Time');
model.sol('sol1').feature('t1').set('tlist', '0 0.2');
model.sol('sol1').feature('t1').set('plot', 'off');
model.sol('sol1').feature('t1').set('plotgroup', 'Default');
model.sol('sol1').feature('t1').set('plotfreq', 'tout');
model.sol('sol1').feature('t1').set('probesel', 'all');
model.sol('sol1').feature('t1').set('probes', {});
model.sol('sol1').feature('t1').set('probefreq', 'tsteps');
model.sol('sol1').feature('t1').set('rtol', 1.0E-5);
model.sol('sol1').feature('t1').set('atolglobalvaluemethod', 'factor');
model.sol('sol1').feature('t1').set('reacf', true);
model.sol('sol1').feature('t1').set('storeudot', true);
model.sol('sol1').feature('t1').set('tstepsgenalpha', 'strict');
model.sol('sol1').feature('t1').set('endtimeinterpolation', true);
model.sol('sol1').feature('t1').set('timemethod', 'genalpha');
model.sol('sol1').feature('t1').set('estrat', 'exclude');
model.sol('sol1').feature('t1').set('control', 'time');
model.sol('sol1').feature('t1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('t1').feature('fc1').set('ntolfact', 0.1);
model.sol('sol1').feature('t1').create('i1', 'Iterative');
model.sol('sol1').feature('t1').feature('i1').set('linsolver', 'gmres');
model.sol('sol1').feature('t1').feature('i1').create('ja1', 'Jacobi');
model.sol('sol1').feature('t1').feature('fc1').set('linsolver', 'i1');
model.sol('sol1').feature('t1').feature('fc1').set('ntolfact', 0.1);
model.sol('sol1').feature('t1').feature.remove('fcDef');
model.sol('sol1').attach('std1');

model.batch.create('p1', 'Parametric');
model.batch('p1').study('std1');
model.batch('p1').create('so1', 'Solutionseq');
model.batch('p1').feature('so1').set('seq', 'sol1');
model.batch('p1').feature('so1').set('store', 'on');
model.batch('p1').feature('so1').set('clear', 'on');
model.batch('p1').feature('so1').set('psol', 'none');
model.batch('p1').set('pname', {'C'});
model.batch('p1').set('plistarr', {'range(-10,0.5,10)'});
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

model.result.create('pg1', 'PlotGroup1D');
model.result('pg1').run;
model.result('pg1').label('Transmission Probability: Sweep Over Speeds');
model.result('pg1').set('data', 'dset2');
model.result('pg1').setIndex('looplevelinput', 'last', 0);
model.result('pg1').set('titletype', 'manual');
model.result('pg1').set('title', 'Transmission Probability vs. Speed');
model.result('pg1').set('ylabelactive', true);
model.result('pg1').set('ylabel', 'Transmission probability');
model.result('pg1').set('legendpos', 'upperleft');
model.result('pg1').create('glob1', 'Global');
model.result('pg1').feature('glob1').set('markerpos', 'datapoints');
model.result('pg1').feature('glob1').set('linewidth', 'preference');
model.result('pg1').feature('glob1').setIndex('expr', 'M12', 0);
model.result('pg1').feature('glob1').setIndex('expr', 'm12', 1);
model.result('pg1').feature('glob1').set('xdatasolnumtype', 'outer');
model.result('pg1').feature('glob1').set('legendmethod', 'manual');
model.result('pg1').feature('glob1').setIndex('legends', 'M12', 0);
model.result('pg1').feature('glob1').setIndex('legends', 'm12', 1);
model.result('pg1').run;

model.study.create('std2');
model.study('std2').create('time', 'Transient');
model.study('std2').feature('time').setSolveFor('/physics/pt', true);
model.study('std2').label('Sweep Over Angles');
model.study('std2').setGenPlots(false);
model.study('std2').create('param', 'Parametric');
model.study('std2').feature('param').setIndex('pname', 'S0', 0);
model.study('std2').feature('param').setIndex('plistarr', '', 0);
model.study('std2').feature('param').setIndex('punit', '', 0);
model.study('std2').feature('param').setIndex('pname', 'S0', 0);
model.study('std2').feature('param').setIndex('plistarr', '', 0);
model.study('std2').feature('param').setIndex('punit', '', 0);
model.study('std2').feature('param').setIndex('pname', 'alpha', 0);
model.study('std2').feature('param').setIndex('plistarr', 'range(5,5,55)', 0);
model.study('std2').feature('param').setIndex('punit', 'deg', 0);
model.study('std2').feature('time').set('tunit', 'ms');
model.study('std2').feature('time').set('tlist', '0 0.2');

model.sol.create('sol44');
model.sol('sol44').study('std2');
model.sol('sol44').create('st1', 'StudyStep');
model.sol('sol44').feature('st1').set('study', 'std2');
model.sol('sol44').feature('st1').set('studystep', 'time');
model.sol('sol44').create('v1', 'Variables');
model.sol('sol44').feature('v1').set('control', 'time');
model.sol('sol44').create('t1', 'Time');
model.sol('sol44').feature('t1').set('tlist', '0 0.2');
model.sol('sol44').feature('t1').set('plot', 'off');
model.sol('sol44').feature('t1').set('plotgroup', 'pg1');
model.sol('sol44').feature('t1').set('plotfreq', 'tout');
model.sol('sol44').feature('t1').set('probesel', 'all');
model.sol('sol44').feature('t1').set('probes', {});
model.sol('sol44').feature('t1').set('probefreq', 'tsteps');
model.sol('sol44').feature('t1').set('rtol', 1.0E-5);
model.sol('sol44').feature('t1').set('atolglobalvaluemethod', 'factor');
model.sol('sol44').feature('t1').set('reacf', true);
model.sol('sol44').feature('t1').set('storeudot', true);
model.sol('sol44').feature('t1').set('tstepsgenalpha', 'strict');
model.sol('sol44').feature('t1').set('endtimeinterpolation', true);
model.sol('sol44').feature('t1').set('timemethod', 'genalpha');
model.sol('sol44').feature('t1').set('estrat', 'exclude');
model.sol('sol44').feature('t1').set('control', 'time');
model.sol('sol44').feature('t1').create('fc1', 'FullyCoupled');
model.sol('sol44').feature('t1').feature('fc1').set('ntolfact', 0.1);
model.sol('sol44').feature('t1').create('i1', 'Iterative');
model.sol('sol44').feature('t1').feature('i1').set('linsolver', 'gmres');
model.sol('sol44').feature('t1').feature('i1').create('ja1', 'Jacobi');
model.sol('sol44').feature('t1').feature('fc1').set('linsolver', 'i1');
model.sol('sol44').feature('t1').feature('fc1').set('ntolfact', 0.1);
model.sol('sol44').feature('t1').feature.remove('fcDef');
model.sol('sol44').attach('std2');

model.batch.create('p2', 'Parametric');
model.batch('p2').study('std2');
model.batch('p2').create('so1', 'Solutionseq');
model.batch('p2').feature('so1').set('seq', 'sol44');
model.batch('p2').feature('so1').set('store', 'on');
model.batch('p2').feature('so1').set('clear', 'on');
model.batch('p2').feature('so1').set('psol', 'none');
model.batch('p2').set('pname', {'alpha'});
model.batch('p2').set('plistarr', {'range(5,5,55)'});
model.batch('p2').set('sweeptype', 'sparse');
model.batch('p2').set('probesel', 'all');
model.batch('p2').set('probes', {});
model.batch('p2').set('plot', 'off');
model.batch('p2').set('err', 'on');
model.batch('p2').attach('std2');
model.batch('p2').set('control', 'param');

model.sol.create('sol45');
model.sol('sol45').study('std2');
model.sol('sol45').label('Parametric Solutions 2');

model.batch('p2').feature('so1').set('psol', 'sol45');
model.batch('p2').run('compute');

model.result('pg1').run;
model.result.duplicate('pg2', 'pg1');
model.result('pg2').run;
model.result('pg2').label('Transmission Probability: Sweep Over Angles');
model.result('pg2').set('data', 'dset4');
model.result('pg2').set('title', 'Transmission Probability vs. Angle');
model.result('pg2').run;

model.study.create('std3');
model.study('std3').create('time', 'Transient');
model.study('std3').feature('time').setSolveFor('/physics/pt', true);

model.geom('geom1').run;

model.study('std3').label('Sweep Over Aspect Ratios');
model.study('std3').setGenPlots(false);
model.study('std3').create('param', 'Parametric');
model.study('std3').feature('param').setIndex('pname', 'S0', 0);
model.study('std3').feature('param').setIndex('plistarr', '', 0);
model.study('std3').feature('param').setIndex('punit', '', 0);
model.study('std3').feature('param').setIndex('pname', 'S0', 0);
model.study('std3').feature('param').setIndex('plistarr', '', 0);
model.study('std3').feature('param').setIndex('punit', '', 0);
model.study('std3').feature('param').setIndex('plistarr', 'range(0.5,0.1,1.5)', 0);
model.study('std3').feature('time').set('tunit', 'ms');
model.study('std3').feature('time').set('tlist', '0 0.2');

model.sol.create('sol57');
model.sol('sol57').study('std3');
model.sol('sol57').create('st1', 'StudyStep');
model.sol('sol57').feature('st1').set('study', 'std3');
model.sol('sol57').feature('st1').set('studystep', 'time');
model.sol('sol57').create('v1', 'Variables');
model.sol('sol57').feature('v1').set('control', 'time');
model.sol('sol57').create('t1', 'Time');
model.sol('sol57').feature('t1').set('tlist', '0 0.2');
model.sol('sol57').feature('t1').set('plot', 'off');
model.sol('sol57').feature('t1').set('plotgroup', 'pg1');
model.sol('sol57').feature('t1').set('plotfreq', 'tout');
model.sol('sol57').feature('t1').set('probesel', 'all');
model.sol('sol57').feature('t1').set('probes', {});
model.sol('sol57').feature('t1').set('probefreq', 'tsteps');
model.sol('sol57').feature('t1').set('rtol', 1.0E-5);
model.sol('sol57').feature('t1').set('atolglobalvaluemethod', 'factor');
model.sol('sol57').feature('t1').set('reacf', true);
model.sol('sol57').feature('t1').set('storeudot', true);
model.sol('sol57').feature('t1').set('tstepsgenalpha', 'strict');
model.sol('sol57').feature('t1').set('endtimeinterpolation', true);
model.sol('sol57').feature('t1').set('timemethod', 'genalpha');
model.sol('sol57').feature('t1').set('estrat', 'exclude');
model.sol('sol57').feature('t1').set('control', 'time');
model.sol('sol57').feature('t1').create('fc1', 'FullyCoupled');
model.sol('sol57').feature('t1').feature('fc1').set('ntolfact', 0.1);
model.sol('sol57').feature('t1').create('i1', 'Iterative');
model.sol('sol57').feature('t1').feature('i1').set('linsolver', 'gmres');
model.sol('sol57').feature('t1').feature('i1').create('ja1', 'Jacobi');
model.sol('sol57').feature('t1').feature('fc1').set('linsolver', 'i1');
model.sol('sol57').feature('t1').feature('fc1').set('ntolfact', 0.1);
model.sol('sol57').feature('t1').feature.remove('fcDef');
model.sol('sol57').attach('std3');

model.batch.create('p3', 'Parametric');
model.batch('p3').study('std3');
model.batch('p3').create('so1', 'Solutionseq');
model.batch('p3').feature('so1').set('seq', 'sol57');
model.batch('p3').feature('so1').set('store', 'on');
model.batch('p3').feature('so1').set('clear', 'on');
model.batch('p3').feature('so1').set('psol', 'none');
model.batch('p3').set('pname', {'S0'});
model.batch('p3').set('plistarr', {'range(0.5,0.1,1.5)'});
model.batch('p3').set('sweeptype', 'sparse');
model.batch('p3').set('probesel', 'all');
model.batch('p3').set('probes', {});
model.batch('p3').set('plot', 'off');
model.batch('p3').set('err', 'on');
model.batch('p3').attach('std3');
model.batch('p3').set('control', 'param');

model.sol.create('sol58');
model.sol('sol58').study('std3');
model.sol('sol58').label('Parametric Solutions 3');

model.batch('p3').feature('so1').set('psol', 'sol58');
model.batch('p3').run('compute');

model.result('pg1').run;
model.result.duplicate('pg3', 'pg1');
model.result('pg3').run;
model.result('pg3').label('Transmission Probability: Sweep Over Aspect Ratios');
model.result('pg3').set('data', 'dset6');
model.result('pg3').set('title', 'Transmission Probability vs. Aspect Ratio');
model.result('pg3').run;

model.title('Quasi-2D Turbomolecular Pump');

model.description(['The Monte Carlo simulation of rarefied gas flow in a turbomolecular pump can be greatly simplified if the mean radius of the blades is much greater than the spacing between them. Under these conditions, the rotating blades of the pump can be approximated as an infinite row of blades having only translational velocity.' newline 'This benchmark model shows the effect of blade velocity, angle, and spacing on the transmission probability of molecules across a single-stage turbomolecular pump in the free molecular flow regime. The results agree well with earlier publications using the same simplifying assumptions.']);

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
model.sol('sol21').clearSolutionData;
model.sol('sol22').clearSolutionData;
model.sol('sol23').clearSolutionData;
model.sol('sol24').clearSolutionData;
model.sol('sol25').clearSolutionData;
model.sol('sol26').clearSolutionData;
model.sol('sol27').clearSolutionData;
model.sol('sol28').clearSolutionData;
model.sol('sol29').clearSolutionData;
model.sol('sol30').clearSolutionData;
model.sol('sol31').clearSolutionData;
model.sol('sol32').clearSolutionData;
model.sol('sol33').clearSolutionData;
model.sol('sol34').clearSolutionData;
model.sol('sol35').clearSolutionData;
model.sol('sol36').clearSolutionData;
model.sol('sol37').clearSolutionData;
model.sol('sol38').clearSolutionData;
model.sol('sol39').clearSolutionData;
model.sol('sol40').clearSolutionData;
model.sol('sol41').clearSolutionData;
model.sol('sol42').clearSolutionData;
model.sol('sol43').clearSolutionData;
model.sol('sol44').clearSolutionData;
model.sol('sol45').clearSolutionData;
model.sol('sol46').clearSolutionData;
model.sol('sol47').clearSolutionData;
model.sol('sol48').clearSolutionData;
model.sol('sol49').clearSolutionData;
model.sol('sol50').clearSolutionData;
model.sol('sol51').clearSolutionData;
model.sol('sol52').clearSolutionData;
model.sol('sol53').clearSolutionData;
model.sol('sol54').clearSolutionData;
model.sol('sol55').clearSolutionData;
model.sol('sol56').clearSolutionData;
model.sol('sol57').clearSolutionData;
model.sol('sol58').clearSolutionData;
model.sol('sol59').clearSolutionData;
model.sol('sol60').clearSolutionData;
model.sol('sol61').clearSolutionData;
model.sol('sol62').clearSolutionData;
model.sol('sol63').clearSolutionData;
model.sol('sol64').clearSolutionData;
model.sol('sol65').clearSolutionData;
model.sol('sol66').clearSolutionData;
model.sol('sol67').clearSolutionData;
model.sol('sol68').clearSolutionData;
model.sol('sol69').clearSolutionData;

model.label('turbomolecular_pump_quasi_2d.mph');

model.modelNode.label('Components');

out = model;
