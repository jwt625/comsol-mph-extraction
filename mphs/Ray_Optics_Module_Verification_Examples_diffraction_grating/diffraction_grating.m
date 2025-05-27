function out = model
%
% diffraction_grating.m
%
% Model exported on May 26 2025, 21:32 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/Ray_Optics_Module/Verification_Examples');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 2);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.physics.create('ewfd', 'ElectromagneticWavesFrequencyDomain', 'geom1');
model.physics('ewfd').model('comp1');

model.study.create('std1');
model.study('std1').create('freq', 'Frequency');
model.study('std1').feature('freq').set('solnum', 'auto');
model.study('std1').feature('freq').set('notsolnum', 'auto');
model.study('std1').feature('freq').set('outputmap', {});
model.study('std1').feature('freq').set('ngenAUX', '1');
model.study('std1').feature('freq').set('goalngenAUX', '1');
model.study('std1').feature('freq').set('ngenAUX', '1');
model.study('std1').feature('freq').set('goalngenAUX', '1');
model.study('std1').feature('freq').setSolveFor('/physics/ewfd', true);

model.param.set('n_air', '1');
model.param.descr('n_air', 'Refractive index air');
model.param.set('n_sio2', '1.54874');
model.param.descr('n_sio2', 'Refractive index SiO2');
model.param.set('d', '340[nm]');
model.param.descr('d', 'Grating constant');
model.param.set('lam0', '441[nm]');
model.param.descr('lam0', 'Vacuum wavelength of incident light');
model.param.set('f0', 'c_const/lam0');
model.param.descr('f0', 'Frequency of incident light');
model.param.set('alpha', '0.0[deg]');
model.param.descr('alpha', 'Angle of incidence (input port)');

model.material.create('mat1', 'Common', '');
model.material('mat1').label('Air');
model.material('mat1').propertyGroup.create('RefractiveIndex', 'Refractive_index');
model.material('mat1').propertyGroup('RefractiveIndex').set('n', {'n_air'});
model.material('mat1').propertyGroup('RefractiveIndex').set('ki', {'0'});
model.material.create('mat2', 'Common', '');
model.material('mat2').label('SiO2');
model.material('mat2').propertyGroup.create('RefractiveIndex', 'Refractive_index');
model.material('mat2').propertyGroup('RefractiveIndex').set('n', {'n_sio2'});
model.material('mat2').propertyGroup('RefractiveIndex').set('ki', {'0'});

model.geom('geom1').create('r1', 'Rectangle');
model.geom('geom1').feature('r1').set('size', {'d' '6*d'});
model.geom('geom1').feature('r1').set('pos', {'0' '-3*d'});
model.geom('geom1').run('r1');
model.geom('geom1').create('r2', 'Rectangle');
model.geom('geom1').feature('r2').set('size', {'d' '3*d'});
model.geom('geom1').feature('r2').set('pos', {'0' '-3*d'});
model.geom('geom1').run('r2');
model.geom('geom1').create('r3', 'Rectangle');
model.geom('geom1').feature('r3').set('size', {'d/2' 'd/4'});
model.geom('geom1').feature('r3').set('pos', {'d/4' '0'});
model.geom('geom1').run('r3');
model.geom('geom1').create('uni1', 'Union');
model.geom('geom1').feature('uni1').selection('input').set({'r2' 'r3'});
model.geom('geom1').feature('uni1').set('intbnd', false);
model.geom('geom1').runPre('fin');
model.geom('geom1').run;

model.material.create('matlnk1', 'Link', 'comp1');
model.material('matlnk1').selection.set([2]);
model.material.create('matlnk2', 'Link', 'comp1');
model.material('matlnk2').selection.set([1]);
model.material('matlnk2').set('link', 'mat2');

model.study('std1').feature('freq').set('plist', 'f0');

model.physics('ewfd').prop('components').set('components', 'outofplane');
model.physics('ewfd').create('port1', 'Port', 1);
model.physics('ewfd').feature('port1').selection.set([5]);
model.physics('ewfd').feature('port1').set('PortType', 'Periodic');
model.physics('ewfd').feature('port1').set('Eampl', [0 0 1]);
model.physics('ewfd').feature('port1').set('alpha_inc', 'alpha');
model.physics('ewfd').feature('port1').set('IncludeInAutomaticDiffractionOrderCalculation', false);
model.physics('ewfd').feature('port1').set('n', {'n_air' '0' '0' '0' 'n_air' '0' '0' '0' 'n_air'});
model.physics('ewfd').feature('port1').create('dport1', 'DiffractionOrder', 1);
model.physics('ewfd').feature('port1').feature('dport1').set('components', 'outofplane');
model.physics('ewfd').feature('port1').feature('dport1').set('mOrder', -1);
model.physics('ewfd').feature('port1').create('dport2', 'DiffractionOrder', 1);
model.physics('ewfd').feature('port1').feature('dport2').set('components', 'outofplane');
model.physics('ewfd').feature('port1').feature('dport2').set('mOrder', 1);
model.physics('ewfd').create('port2', 'Port', 1);
model.physics('ewfd').feature('port2').selection.set([2]);
model.physics('ewfd').feature('port2').set('PortType', 'Periodic');
model.physics('ewfd').feature('port2').set('Eampl', [0 0 1]);
model.physics('ewfd').feature('port2').set('n', {'n_sio2' '0' '0' '0' 'n_sio2' '0' '0' '0' 'n_sio2'});
model.physics('ewfd').feature('port1').runCommand('addDiffractionOrders');
model.physics('ewfd').create('pc1', 'PeriodicCondition', 1);
model.physics('ewfd').feature('pc1').selection.set([1 3 10 11]);
model.physics('ewfd').feature('pc1').set('PeriodicType', 'Floquet');
model.physics('ewfd').feature('pc1').set('Floquet_source', 'FromPeriodicPort');

model.study('std1').create('param', 'Parametric');
model.study('std1').feature('param').setIndex('pname', 'n_air', 0);
model.study('std1').feature('param').setIndex('plistarr', '', 0);
model.study('std1').feature('param').setIndex('punit', '', 0);
model.study('std1').feature('param').setIndex('pname', 'n_air', 0);
model.study('std1').feature('param').setIndex('plistarr', '', 0);
model.study('std1').feature('param').setIndex('punit', '', 0);
model.study('std1').feature('param').setIndex('pname', 'alpha', 0);
model.study('std1').feature('param').setIndex('plistarr', 'range(0,1,90)', 0);
model.study('std1').feature('param').setIndex('punit', 'deg', 0);

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
model.sol('sol1').feature('s1').feature('p1').set('pname', {'alpha'});
model.sol('sol1').feature('s1').feature('p1').set('plistarr', {'range(0,1,90)'});
model.sol('sol1').feature('s1').feature('p1').set('punit', {'deg'});
model.sol('sol1').feature('s1').feature('p1').set('sweeptype', 'sparse');
model.sol('sol1').feature('s1').feature('p1').set('preusesol', 'no');
model.sol('sol1').feature('s1').feature('p1').set('pcontinuationmode', 'no');
model.sol('sol1').feature('s1').feature('p1').set('plot', 'off');
model.sol('sol1').feature('s1').feature('p1').set('plotgroup', 'Default');
model.sol('sol1').feature('s1').feature('p1').set('probesel', 'all');
model.sol('sol1').feature('s1').feature('p1').set('probes', {});
model.sol('sol1').feature('s1').feature('p1').set('control', 'param');
model.sol('sol1').feature('s1').set('control', 'freq');
model.sol('sol1').feature('s1').set('linpmethod', 'sol');
model.sol('sol1').feature('s1').set('linpsol', 'zero');
model.sol('sol1').feature('s1').set('control', 'freq');
model.sol('sol1').feature('s1').feature('aDef').set('complexfun', true);
model.sol('sol1').feature('s1').feature('aDef').set('cachepattern', true);
model.sol('sol1').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('s1').create('d1', 'Direct');
model.sol('sol1').feature('s1').feature('d1').set('linsolver', 'mumps');
model.sol('sol1').feature('s1').feature('d1').label('Suggested Direct Solver (ewfd)');
model.sol('sol1').feature('s1').feature('fc1').set('linsolver', 'd1');
model.sol('sol1').feature('s1').feature.remove('fcDef');
model.sol('sol1').attach('std1');
model.sol('sol1').runAll;

model.result.create('pg1', 'PlotGroup2D');
model.result('pg1').label('Electric Field (ewfd)');
model.result('pg1').set('frametype', 'spatial');
model.result('pg1').set('data', 'dset1');
model.result('pg1').setIndex('looplevel', 91, 0);
model.result('pg1').set('defaultPlotID', 'ElectromagneticWavesFrequencyDomain/phys1/pdef1/pcond2/pg1');
model.result('pg1').feature.create('surf1', 'Surface');
model.result('pg1').feature('surf1').set('smooth', 'internal');
model.result('pg1').feature('surf1').set('data', 'parent');
model.result.create('pg2', 'PlotGroup1D');
model.result('pg2').set('data', 'dset1');
model.result('pg2').create('glob1', 'Global');
model.result('pg2').feature('glob1').set('unit', {'' '' '' '' '' '' '' '' '' ''});
model.result('pg2').feature('glob1').set('expr', {'ewfd.Rorder_0' 'ewfd.Rorder_n1_op' 'ewfd.Rorder_p1_op' 'ewfd.Rtotal' 'ewfd.Torder_0' 'ewfd.Torder_n1_op' 'ewfd.Torder_p1_op' 'ewfd.Ttotal' 'ewfd.RTtotal' 'ewfd.Atotal'});
model.result('pg2').feature('glob1').set('descr', {'Reflectance, order 0' 'Reflectance, order -1, out-of-plane' 'Reflectance, order 1, out-of-plane' 'Total reflectance' 'Transmittance, order 0' 'Transmittance, order -1, out-of-plane' 'Transmittance, order 1, out-of-plane' 'Total transmittance' 'Total reflectance and transmittance' 'Absorptance'});
model.result('pg2').label('Reflectance, Transmittance, and Absorptance (ewfd)');
model.result('pg2').feature('glob1').set('titletype', 'none');
model.result('pg2').feature('glob1').set('xdata', 'expr');
model.result('pg2').set('ylabelactive', true);
model.result('pg2').set('ylabel', 'Reflectance, transmittance, and absorptance (1)');
model.result('pg2').feature('glob1').set('xdataexpr', 'alpha');
model.result('pg2').feature('glob1').set('xdataunit', 'deg');
model.result('pg2').feature('glob1').set('markerpos', 'datapoints');
model.result('pg2').feature('glob1').set('xdatasolnumtype', 'all');
model.result('pg1').run;
model.result('pg1').setIndex('looplevel', 46, 0);
model.result('pg1').run;
model.result.numerical.create('gev1', 'EvalGlobal');
model.result.numerical('gev1').setIndex('expr', 'ewfd.Rorder_0', 0);
model.result.numerical('gev1').setIndex('unit', 1, 0);
model.result.numerical('gev1').setIndex('descr', 'R0', 0);
model.result.numerical('gev1').setIndex('expr', 'ewfd.Torder_0', 1);
model.result.numerical('gev1').setIndex('unit', 1, 1);
model.result.numerical('gev1').setIndex('descr', 'T0', 1);
model.result.numerical('gev1').setIndex('expr', 'ewfd.Rorder_n1_op', 2);
model.result.numerical('gev1').setIndex('unit', 1, 2);
model.result.numerical('gev1').setIndex('descr', 'R-1', 2);
model.result.numerical('gev1').setIndex('expr', 'ewfd.Torder_n1_op', 3);
model.result.numerical('gev1').setIndex('unit', 1, 3);
model.result.numerical('gev1').setIndex('descr', 'T-1', 3);
model.result.numerical('gev1').setIndex('expr', 'ewfd.Rorder_p1_op', 4);
model.result.numerical('gev1').setIndex('unit', 1, 4);
model.result.numerical('gev1').setIndex('descr', 'R1', 4);
model.result.numerical('gev1').setIndex('expr', 'ewfd.Torder_p1_op', 5);
model.result.numerical('gev1').setIndex('unit', 1, 5);
model.result.numerical('gev1').setIndex('descr', 'T1', 5);
model.result.table.create('tbl1', 'Table');
model.result.table('tbl1').comments('Global Evaluation 1');
model.result.numerical('gev1').set('table', 'tbl1');
model.result.numerical('gev1').setResult;
model.result('pg2').run;
model.result('pg2').set('legendpos', 'middleleft');

model.modelNode.create('comp2', true);

model.geom.create('geom2', 2);
model.geom('geom2').model('comp2');

model.mesh.create('mesh2', 'geom2');

model.geom('geom2').create('r1', 'Rectangle');
model.geom('geom2').feature('r1').set('base', 'center');
model.geom('geom2').feature('r1').set('size', {'5[mm]' '1.35[mm]'});
model.geom('geom2').run('r1');
model.geom('geom2').create('r2', 'Rectangle');
model.geom('geom2').feature('r2').set('size', {'5[mm]' '1'});
model.geom('geom2').feature('r2').set('base', 'center');
model.geom('geom2').feature('r2').set('size', {'5[mm]' '0.675[mm]'});
model.geom('geom2').feature('r2').set('pos', {'0' '-0.675[mm]/2'});
model.geom('geom2').runPre('fin');

model.func.create('int1', 'Interpolation');
model.func('int1').model('comp2');
model.func('int1').set('source', 'resultTable');
model.func('int1').setIndex('funcs', 'R0', 0, 0);
model.func('int1').setIndex('funcs', 1, 0, 1);
model.func('int1').setIndex('funcs', 'T0', 1, 0);
model.func('int1').setIndex('funcs', 2, 1, 1);
model.func('int1').setIndex('funcs', 'Rm1', 2, 0);
model.func('int1').setIndex('funcs', 3, 2, 1);
model.func('int1').setIndex('funcs', 'Tm1', 3, 0);
model.func('int1').setIndex('funcs', 4, 3, 1);
model.func('int1').setIndex('funcs', 'R1', 4, 0);
model.func('int1').setIndex('funcs', 5, 4, 1);
model.func('int1').setIndex('funcs', 'T1', 5, 0);
model.func('int1').setIndex('funcs', 6, 5, 1);
model.func('int1').setIndex('argunit', 'deg', 0);
model.func('int1').setIndex('fununit', 1, 0);
model.func('int1').setIndex('fununit', 1, 1);
model.func('int1').setIndex('fununit', 1, 2);
model.func('int1').setIndex('fununit', 1, 3);
model.func('int1').setIndex('fununit', 1, 4);
model.func('int1').setIndex('fununit', 1, 5);

model.physics.create('gop', 'GeometricalOptics', 'geom2');
model.physics('gop').model('comp2');

model.study('std1').feature('freq').setSolveFor('/physics/gop', true);

model.geom('geom2').run;

model.material.create('matlnk3', 'Link', 'comp2');
model.material('matlnk3').selection.set([2]);
model.material.create('matlnk4', 'Link', 'comp2');
model.material('matlnk4').selection.set([1]);
model.material('matlnk4').set('link', 'mat2');

model.physics('gop').prop('IntensityComputation').setIndex('IntensityComputation', 'ComputeIntensityAndPower', 0);
model.physics('gop').prop('MaximumSecondary').setIndex('MaximumSecondary', 4505, 0);
model.physics('gop').feature('op1').set('RayPropertySpecification', 'SpecifyFrequency');
model.physics('gop').feature('op1').set('nu', 'f0');

model.variable.create('var1');
model.variable('var1').model('comp2');
model.variable('var1').set('alpha_ro', 'atan2(kx,-ky)');

model.physics('gop').create('grat1', 'Grating', 1);
model.physics('gop').feature('grat1').selection.set([4]);
model.physics('gop').feature('grat1').set('dg', 'd');
model.physics('gop').feature('grat1').set('StoreTotalTransmittedPower', true);
model.physics('gop').feature('grat1').set('StoreTotalReflectedPower', true);
model.physics('gop').feature('grat1').feature('dfo1').set('Rf', 'R0(alpha_ro)');
model.physics('gop').feature('grat1').feature('dfo1').set('Tr', 'T0(alpha_ro)');
model.physics('gop').feature('grat1').create('dfo2', 'DiffractionOrder', 1);
model.physics('gop').feature('grat1').feature('dfo2').set('mg', -1);
model.physics('gop').feature('grat1').feature('dfo2').set('Rf', 'Rm1(alpha_ro)');
model.physics('gop').feature('grat1').feature('dfo2').set('Tr', 'T1(alpha_ro)');
model.physics('gop').feature('grat1').create('dfo3', 'DiffractionOrder', 1);
model.physics('gop').feature('grat1').feature('dfo3').set('Rf', 'R1(alpha_ro)');
model.physics('gop').feature('grat1').feature('dfo3').set('Tr', 'Tm1(alpha_ro)');
model.physics('gop').create('relg1', 'ReleaseGrid', -1);
model.physics('gop').feature('relg1').setIndex('x0', '1e-6', 1);
model.physics('gop').feature('relg1').set('RayDirectionVector', 'Conical');
model.physics('gop').feature('relg1').setIndex('Nw', 901, 0);
model.physics('gop').feature('relg1').set('alphac', 'pi/4');
model.physics('gop').feature('relg1').set('cax', [1 -1.01 0]);
model.physics('gop').feature('relg1').set('Psrc', '901[W/m]');
model.physics('gop').feature('relg1').set('InitialPolarizationType', 'FullyPolarized');
model.physics('gop').feature('relg1').set('axy0', 0);
model.physics('gop').feature('relg1').set('az0', 1);

model.study.create('std2');
model.study('std2').create('rtrac', 'RayTracing');
model.study('std2').feature('rtrac').setSolveFor('/physics/ewfd', false);
model.study('std2').feature('rtrac').setSolveFor('/physics/gop', true);
model.study('std2').feature('rtrac').set('tunit', 'ps');
model.study('std2').feature('rtrac').set('tlist', '0 1');

model.sol.create('sol2');
model.sol('sol2').study('std2');
model.sol('sol2').create('st1', 'StudyStep');
model.sol('sol2').feature('st1').set('study', 'std2');
model.sol('sol2').feature('st1').set('studystep', 'rtrac');
model.sol('sol2').create('v1', 'Variables');
model.sol('sol2').feature('v1').set('control', 'rtrac');
model.sol('sol2').create('t1', 'Time');
model.sol('sol2').feature('t1').set('tlist', '0 1');
model.sol('sol2').feature('t1').set('plot', 'off');
model.sol('sol2').feature('t1').set('plotgroup', 'pg1');
model.sol('sol2').feature('t1').set('plotfreq', 'tout');
model.sol('sol2').feature('t1').set('probesel', 'all');
model.sol('sol2').feature('t1').set('probes', {});
model.sol('sol2').feature('t1').set('probefreq', 'tsteps');
model.sol('sol2').feature('t1').set('rtol', 1.0E-5);
model.sol('sol2').feature('t1').set('atolglobalvaluemethod', 'factor');
model.sol('sol2').feature('t1').set('reacf', false);
model.sol('sol2').feature('t1').set('storeudot', false);
model.sol('sol2').feature('t1').set('tstepsgenalpha', 'strict');
model.sol('sol2').feature('t1').set('endtimeinterpolation', true);
model.sol('sol2').feature('t1').set('timemethod', 'genalpha');
model.sol('sol2').feature('t1').set('estrat', 'exclude');
model.sol('sol2').feature('t1').set('control', 'rtrac');
model.sol('sol2').feature('t1').create('fc1', 'FullyCoupled');
model.sol('sol2').feature('t1').feature('fc1').set('ntolfact', 0.1);
model.sol('sol2').feature('t1').create('i1', 'Iterative');
model.sol('sol2').feature('t1').feature('i1').set('linsolver', 'gmres');
model.sol('sol2').feature('t1').feature('i1').create('ja1', 'Jacobi');
model.sol('sol2').feature('t1').feature('fc1').set('linsolver', 'i1');
model.sol('sol2').feature('t1').feature('fc1').set('ntolfact', 0.1);
model.sol('sol2').feature('t1').feature.remove('fcDef');
model.sol('sol2').attach('std2');
model.sol('sol2').runAll;

model.result.dataset.create('ray1', 'Ray');
model.result.dataset('ray1').set('solution', 'sol2');
model.result.dataset('ray1').set('posdof', {'comp2.qx' 'comp2.qy'});
model.result.dataset('ray1').set('geom', 'geom2');
model.result.dataset('ray1').set('rgeom', 'pgeom_gop');
model.result.dataset('ray1').set('rgeomspec', 'fromphysics');
model.result.dataset('ray1').set('physicsinterface', 'gop');
model.result.create('pg3', 'PlotGroup2D');
model.result('pg3').set('data', 'ray1');
model.result('pg3').setIndex('looplevel', 2, 0);
model.result('pg3').label('Ray Trajectories (gop)');
model.result('pg3').create('rtrj1', 'RayTrajectories');
model.result('pg3').feature('rtrj1').set('linetype', 'line');
model.result('pg3').feature('rtrj1').create('col1', 'Color');
model.result('pg3').feature('rtrj1').feature('col1').set('expr', 'gop.I');
model.result('pg3').feature('rtrj1').create('filt1', 'RayTrajectoriesFilter');
model.result('pg3').run;
model.result.create('pg4', 'PlotGroup1D');
model.result('pg4').run;
model.result('pg4').label('Transmittance and Reflectance (ewfd and gop)');
model.result('pg4').set('titletype', 'none');
model.result('pg4').set('xlabelactive', true);
model.result('pg4').set('xlabel', 'Angle of incidence (deg)');
model.result('pg4').set('ylabelactive', true);
model.result('pg4').set('ylabel', 'Transmittance and Reflectance');
model.result('pg4').set('legendpos', 'middleleft');
model.result('pg4').create('glob1', 'Global');
model.result('pg4').feature('glob1').set('markerpos', 'datapoints');
model.result('pg4').feature('glob1').set('linewidth', 'preference');
model.result('pg4').feature('glob1').setIndex('expr', 'abs(ewfd.S11)^2+abs(ewfd.S21)^2+abs(ewfd.S31)^2', 0);
model.result('pg4').feature('glob1').setIndex('unit', 1, 0);
model.result('pg4').feature('glob1').setIndex('descr', '', 0);
model.result('pg4').feature('glob1').setIndex('expr', 'abs(ewfd.S41)^2+abs(ewfd.S51)^2+abs(ewfd.S61)^2', 1);
model.result('pg4').feature('glob1').setIndex('unit', 1, 1);
model.result('pg4').feature('glob1').setIndex('descr', '', 1);
model.result('pg4').feature('glob1').set('xdata', 'expr');
model.result('pg4').feature('glob1').set('xdataexpr', 'alpha');
model.result('pg4').feature('glob1').set('xdataunit', [native2unicode(hex2dec({'00' 'b0'}), 'unicode') ]);
model.result('pg4').feature('glob1').set('legendmethod', 'manual');
model.result('pg4').feature('glob1').setIndex('legends', 'Reflected WO', 0);
model.result('pg4').feature('glob1').setIndex('legends', 'Transmitted WO', 1);
model.result('pg4').run;
model.result('pg4').create('rtp1', 'Ray1D');
model.result('pg4').feature('rtp1').set('markerpos', 'datapoints');
model.result('pg4').feature('rtp1').set('linewidth', 'preference');
model.result('pg4').feature('rtp1').set('data', 'ray1');
model.result('pg4').feature('rtp1').setIndex('looplevelinput', 'last', 0);
model.result('pg4').feature('rtp1').set('expr', 'gop.Qgr');
model.result('pg4').feature('rtp1').set('xdata', 'expr');
model.result('pg4').feature('rtp1').set('xdataexpr', 'at(0,alpha_ro)');
model.result('pg4').feature('rtp1').set('xdataunit', [native2unicode(hex2dec({'00' 'b0'}), 'unicode') ]);
model.result('pg4').feature('rtp1').set('linestyle', 'none');
model.result('pg4').feature('rtp1').set('linemarker', 'point');
model.result('pg4').feature('rtp1').set('markerpos', 'interp');
model.result('pg4').feature('rtp1').set('markers', 40);
model.result('pg4').feature('rtp1').set('legend', true);
model.result('pg4').feature('rtp1').set('legendmethod', 'manual');
model.result('pg4').feature('rtp1').setIndex('legends', 'Reflected RO', 0);
model.result('pg4').feature.duplicate('rtp2', 'rtp1');
model.result('pg4').run;
model.result('pg4').feature('rtp2').set('expr', 'gop.Qgt');
model.result('pg4').feature('rtp2').setIndex('legends', 'Transmitted RO', 0);
model.result('pg4').run;

model.title('Diffraction Grating');

model.description('This example uses the Wave Optics Module and the Ray Optics Module to model the propagation of rays through a diffraction grating at different angles of incidence. It uses the S-parameters computed by the Electromagnetic Waves, Frequency Domain interface on a unit cell of the grating to specify the reflectance and transmittance of each diffraction order in the Geometrical Optics interface, allowing ray propagation through the grating to be modeled over length scales much larger than the width of the unit cell.');

model.mesh.clearMeshes;

model.sol('sol1').clearSolutionData;
model.sol('sol2').clearSolutionData;

model.label('diffraction_grating.mph');

model.modelNode.label('Components');

out = model;
