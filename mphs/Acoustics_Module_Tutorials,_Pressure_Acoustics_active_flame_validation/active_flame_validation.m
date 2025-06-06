function out = model
%
% active_flame_validation.m
%
% Model exported on May 26 2025, 21:25 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/Acoustics_Module/Tutorials,_Pressure_Acoustics');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 2);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.physics.create('acpr', 'PressureAcoustics', 'geom1');
model.physics('acpr').model('comp1');

model.study.create('std1');
model.study('std1').create('eig', 'Eigenfrequency');
model.study('std1').feature('eig').set('chkeigregion', true);
model.study('std1').feature('eig').set('conrad', '1');
model.study('std1').feature('eig').set('conradynhm', '1');
model.study('std1').feature('eig').set('storefact', false);
model.study('std1').feature('eig').set('linpsolnum', 'auto');
model.study('std1').feature('eig').set('solnum', 'auto');
model.study('std1').feature('eig').set('notsolnum', 'auto');
model.study('std1').feature('eig').set('outputmap', {});
model.study('std1').feature('eig').set('ngenAUX', '1');
model.study('std1').feature('eig').set('goalngenAUX', '1');
model.study('std1').feature('eig').set('ngenAUX', '1');
model.study('std1').feature('eig').set('goalngenAUX', '1');
model.study('std1').feature('eig').setSolveFor('/physics/acpr', true);

% To import content from file, use:
% model.param.loadFile('FILENAME');
model.param.set('Q_s', '1[W/m^3]', 'Steady heat release');
model.param.set('u_s', '1[m/s]', 'Steady fluid flow');
model.param.set('tau_u', '1e-4[s]', 'Time lag');
model.param.set('n', '5', 'Scale parameter');
model.param.set('delta_f', '0.001[m]', 'Width of flame region');
model.param.set('P_s', '1[atm]', 'Steady pressure');
model.param.set('L', '0.5[m]', 'Length');
model.param.set('c1', '347.19[m/s]', 'Sound speed, cold area');
model.param.set('Gamma', '0.5', 'Gamma factor');
model.param.set('freq_lin', '200[Hz]', 'Linearization frequency for the solver');
model.param.set('omega10', '4*c1/L*acos(sqrt(1/4*(Gamma-1)/(Gamma+1)+3/4))', 'First mode, inactive flame');
model.param.set('omega1Res', '4*c1/L*acos(sqrt(1/4*(Gamma*(1+n*exp(-i*tau_u*omega10))-1)/(Gamma*(1+n*exp(-i*tau_u*omega10))+1)+3/4))', 'First mode, active flame 1st iteration');
model.param.set('omega1Res2', '4*c1/L*acos(sqrt(1/4*(Gamma*(1+n*exp(-i*tau_u*omega1Res))-1)/(Gamma*(1+n*exp(-i*tau_u*omega1Res))+1)+3/4))', 'First mode, active flame 2nd iteration');
model.param.set('omega1Res3', '4*c1/L*acos(sqrt(1/4*(Gamma*(1+n*exp(-i*tau_u*omega1Res2))-1)/(Gamma*(1+n*exp(-i*tau_u*omega1Res2))+1)+3/4))', 'First mode, active flame 3rd iteration');
model.param.set('omega30', '4*c1/L*acos(-sqrt(1/4*(Gamma-1)/(Gamma+1)+3/4))', 'Third mode, inactive flame');
model.param.set('omega3Res', '4*c1/L*acos(-sqrt(1/4*(Gamma*(1+n*exp(-i*tau_u*omega30))-1)/(Gamma*(1+n*exp(-i*tau_u*omega30))+1)+3/4))', 'Third mode, active flame 1st iteration');
model.param.set('omega3Res2', '4*c1/L*acos(-sqrt(1/4*(Gamma*(1+n*exp(-i*tau_u*omega3Res))-1)/(Gamma*(1+n*exp(-i*tau_u*omega3Res))+1)+3/4))', 'Third mode, active flame 2nd iteration');
model.param.set('omega3Res3', '4*c1/L*acos(-sqrt(1/4*(Gamma*(1+n*exp(-i*tau_u*omega3Res2))-1)/(Gamma*(1+n*exp(-i*tau_u*omega3Res2))+1)+3/4))', 'Third mode, active flame 3rd iteration');
model.param.set('omega40', '4*c1/L*(-acos(-sqrt(1/4*(Gamma-1)/(Gamma+1)+3/4))+2*pi)', 'Fourth mode, inactive flame');
model.param.set('omega4Res', '4*c1/L*(-acos(-sqrt(1/4*(Gamma*(1+n*exp(-i*tau_u*omega40))-1)/(Gamma*(1+n*exp(-i*tau_u*omega40))+1)+3/4))+2*pi)', 'Fourth mode, active flame 1st iteration');
model.param.set('omega4Res2', '4*c1/L*(-acos(-sqrt(1/4*(Gamma*(1+n*exp(-i*tau_u*omega4Res))-1)/(Gamma*(1+n*exp(-i*tau_u*omega4Res))+1)+3/4))+2*pi)', 'Fourth mode, active flame 2nd iteration');
model.param.set('omega4Res3', '4*c1/L*(-acos(-sqrt(1/4*(Gamma*(1+n*exp(-i*tau_u*omega4Res2))-1)/(Gamma*(1+n*exp(-i*tau_u*omega4Res2))+1)+3/4))+2*pi)', 'Fourth mode, active flame 3rd iteration');

model.geom('geom1').create('r1', 'Rectangle');
model.geom('geom1').feature('r1').set('size', {'L' 'L/10'});
model.geom('geom1').feature('r1').setIndex('layer', 'L/2', 0);
model.geom('geom1').feature('r1').setIndex('layer', 'delta_f', 1);
model.geom('geom1').feature('r1').set('layerleft', true);
model.geom('geom1').feature('r1').set('layerbottom', false);
model.geom('geom1').runPre('fin');
model.geom('geom1').run;

model.material.create('mat1', 'Common', 'comp1');
model.material('mat1').propertyGroup('def').func.create('eta', 'Piecewise');
model.material('mat1').propertyGroup('def').func.create('Cp', 'Piecewise');
model.material('mat1').propertyGroup('def').func.create('rho', 'Analytic');
model.material('mat1').propertyGroup('def').func.create('k', 'Piecewise');
model.material('mat1').propertyGroup('def').func.create('cs', 'Analytic');
model.material('mat1').propertyGroup('def').func.create('an1', 'Analytic');
model.material('mat1').propertyGroup('def').func.create('an2', 'Analytic');
model.material('mat1').propertyGroup.create('RefractiveIndex', 'Refractive index');
model.material('mat1').propertyGroup.create('NonlinearModel', 'Nonlinear model');
model.material('mat1').propertyGroup.create('idealGas', 'Ideal gas');
model.material('mat1').propertyGroup('idealGas').func.create('Cp', 'Piecewise');
model.material('mat1').label('Air');
model.material('mat1').set('family', 'air');
model.material('mat1').propertyGroup('def').func('eta').set('arg', 'T');
model.material('mat1').propertyGroup('def').func('eta').set('pieces', {'200.0' '1600.0' '-8.38278E-7+8.35717342E-8*T^1-7.69429583E-11*T^2+4.6437266E-14*T^3-1.06585607E-17*T^4'});
model.material('mat1').propertyGroup('def').func('eta').set('argunit', 'K');
model.material('mat1').propertyGroup('def').func('eta').set('fununit', 'Pa*s');
model.material('mat1').propertyGroup('def').func('Cp').set('arg', 'T');
model.material('mat1').propertyGroup('def').func('Cp').set('pieces', {'200.0' '1600.0' '1047.63657-0.372589265*T^1+9.45304214E-4*T^2-6.02409443E-7*T^3+1.2858961E-10*T^4'});
model.material('mat1').propertyGroup('def').func('Cp').set('argunit', 'K');
model.material('mat1').propertyGroup('def').func('Cp').set('fununit', 'J/(kg*K)');
model.material('mat1').propertyGroup('def').func('rho').set('expr', 'pA*0.02897/R_const[K*mol/J]/T');
model.material('mat1').propertyGroup('def').func('rho').set('args', {'pA' 'T'});
model.material('mat1').propertyGroup('def').func('rho').set('fununit', 'kg/m^3');
model.material('mat1').propertyGroup('def').func('rho').set('argunit', {'Pa' 'K'});
model.material('mat1').propertyGroup('def').func('rho').set('plotaxis', {'off' 'on'});
model.material('mat1').propertyGroup('def').func('rho').set('plotfixedvalue', {'101325' '273.15'});
model.material('mat1').propertyGroup('def').func('rho').set('plotargs', {'pA' '101325' '101325'; 'T' '273.15' '293.15'});
model.material('mat1').propertyGroup('def').func('k').set('arg', 'T');
model.material('mat1').propertyGroup('def').func('k').set('pieces', {'200.0' '1600.0' '-0.00227583562+1.15480022E-4*T^1-7.90252856E-8*T^2+4.11702505E-11*T^3-7.43864331E-15*T^4'});
model.material('mat1').propertyGroup('def').func('k').set('argunit', 'K');
model.material('mat1').propertyGroup('def').func('k').set('fununit', 'W/(m*K)');
model.material('mat1').propertyGroup('def').func('cs').set('expr', 'sqrt(1.4*R_const[K*mol/J]/0.02897*T)');
model.material('mat1').propertyGroup('def').func('cs').set('args', {'T'});
model.material('mat1').propertyGroup('def').func('cs').set('fununit', 'm/s');
model.material('mat1').propertyGroup('def').func('cs').set('argunit', {'K'});
model.material('mat1').propertyGroup('def').func('cs').set('plotfixedvalue', {'273.15'});
model.material('mat1').propertyGroup('def').func('cs').set('plotargs', {'T' '273.15' '373.15'});
model.material('mat1').propertyGroup('def').func('an1').set('funcname', 'alpha_p');
model.material('mat1').propertyGroup('def').func('an1').set('expr', '-1/rho(pA,T)*d(rho(pA,T),T)');
model.material('mat1').propertyGroup('def').func('an1').set('args', {'pA' 'T'});
model.material('mat1').propertyGroup('def').func('an1').set('fununit', '1/K');
model.material('mat1').propertyGroup('def').func('an1').set('argunit', {'Pa' 'K'});
model.material('mat1').propertyGroup('def').func('an1').set('plotaxis', {'off' 'on'});
model.material('mat1').propertyGroup('def').func('an1').set('plotfixedvalue', {'101325' '273.15'});
model.material('mat1').propertyGroup('def').func('an1').set('plotargs', {'pA' '101325' '101325'; 'T' '273.15' '373.15'});
model.material('mat1').propertyGroup('def').func('an2').set('funcname', 'muB');
model.material('mat1').propertyGroup('def').func('an2').set('expr', '0.6*eta(T)');
model.material('mat1').propertyGroup('def').func('an2').set('args', {'T'});
model.material('mat1').propertyGroup('def').func('an2').set('fununit', 'Pa*s');
model.material('mat1').propertyGroup('def').func('an2').set('argunit', {'K'});
model.material('mat1').propertyGroup('def').func('an2').set('plotfixedvalue', {'200'});
model.material('mat1').propertyGroup('def').func('an2').set('plotargs', {'T' '200' '1600'});
model.material('mat1').propertyGroup('def').set('thermalexpansioncoefficient', '');
model.material('mat1').propertyGroup('def').set('molarmass', '');
model.material('mat1').propertyGroup('def').set('bulkviscosity', '');
model.material('mat1').propertyGroup('def').set('thermalexpansioncoefficient', {'alpha_p(pA,T)' '0' '0' '0' 'alpha_p(pA,T)' '0' '0' '0' 'alpha_p(pA,T)'});
model.material('mat1').propertyGroup('def').set('molarmass', '0.02897[kg/mol]');
model.material('mat1').propertyGroup('def').set('bulkviscosity', 'muB(T)');
model.material('mat1').propertyGroup('def').set('relpermeability', {'1' '0' '0' '0' '1' '0' '0' '0' '1'});
model.material('mat1').propertyGroup('def').set('relpermittivity', {'1' '0' '0' '0' '1' '0' '0' '0' '1'});
model.material('mat1').propertyGroup('def').set('dynamicviscosity', 'eta(T)');
model.material('mat1').propertyGroup('def').set('ratioofspecificheat', '1.4');
model.material('mat1').propertyGroup('def').set('electricconductivity', {'0[S/m]' '0' '0' '0' '0[S/m]' '0' '0' '0' '0[S/m]'});
model.material('mat1').propertyGroup('def').set('heatcapacity', 'Cp(T)');
model.material('mat1').propertyGroup('def').set('density', 'rho(pA,T)');
model.material('mat1').propertyGroup('def').set('thermalconductivity', {'k(T)' '0' '0' '0' 'k(T)' '0' '0' '0' 'k(T)'});
model.material('mat1').propertyGroup('def').set('soundspeed', 'cs(T)');
model.material('mat1').propertyGroup('def').addInput('temperature');
model.material('mat1').propertyGroup('def').addInput('pressure');
model.material('mat1').propertyGroup('RefractiveIndex').set('n', {'1' '0' '0' '0' '1' '0' '0' '0' '1'});
model.material('mat1').propertyGroup('NonlinearModel').set('BA', 'def.gamma-1');
model.material('mat1').propertyGroup('idealGas').func('Cp').label('Piecewise 2');
model.material('mat1').propertyGroup('idealGas').func('Cp').set('arg', 'T');
model.material('mat1').propertyGroup('idealGas').func('Cp').set('pieces', {'200.0' '1600.0' '1047.63657-0.372589265*T^1+9.45304214E-4*T^2-6.02409443E-7*T^3+1.2858961E-10*T^4'});
model.material('mat1').propertyGroup('idealGas').func('Cp').set('argunit', 'K');
model.material('mat1').propertyGroup('idealGas').func('Cp').set('fununit', 'J/(kg*K)');
model.material('mat1').propertyGroup('idealGas').set('Rs', 'R_const/Mn');
model.material('mat1').propertyGroup('idealGas').set('heatcapacity', 'Cp(T)');
model.material('mat1').propertyGroup('idealGas').set('ratioofspecificheat', '1.4');
model.material('mat1').propertyGroup('idealGas').set('molarmass', '0.02897');
model.material('mat1').propertyGroup('idealGas').addInput('temperature');
model.material('mat1').propertyGroup('idealGas').addInput('pressure');
model.material('mat1').materialType('nonSolid');

model.variable.create('var1');
model.variable('var1').model('comp1');
model.variable('var1').selection.geom('geom1', 2);
model.variable('var1').selection.set([1]);
model.variable('var1').set('T_s', '300[K]');
model.variable('var1').set('n_u', 'n/delta_f*u_s/Q_s*(acpr.rho*acpr.flm1.Cp)/acpr.flm1.alpha_p');
model.variable.create('var2');
model.variable('var2').model('comp1');
model.variable('var2').selection.geom('geom1', 2);
model.variable('var2').selection.set([2 3]);
model.variable('var2').set('T_s', '1200[K]');
model.variable('var2').set('n_u', 'n/delta_f*u_s/Q_s*(acpr.rho*acpr.flm1.Cp)/acpr.flm1.alpha_p');

model.physics('acpr').feature('fpam1').set('minput_temperature', 'T_s');
model.physics('acpr').feature('fpam1').set('minput_pressure', 'P_s');
model.physics('acpr').create('pr1', 'Pressure', 1);
model.physics('acpr').feature('pr1').selection.set([10]);
model.physics('acpr').create('flm1', 'FlameModel', 2);
model.physics('acpr').feature('flm1').selection.set([2]);
model.physics('acpr').feature('flm1').set('n_u', 'n_u');
model.physics('acpr').feature('flm1').set('tau_u', 'tau_u');
model.physics('acpr').feature('flm1').set('Q_s', 'Q_s');
model.physics('acpr').feature('flm1').set('U_s', 'u_s');
model.physics('acpr').feature('flm1').set('acoRef', 'refBoundary');
model.physics('acpr').feature('flm1').selection('selReferenceBoundary').set([4]);
model.physics('acpr').feature('flm1').set('revertNormalVector', true);

model.mesh('mesh1').contribute('physics/acpr', false);
model.mesh('mesh1').autoMeshSize(2);
model.mesh('mesh1').run;

model.study('std1').feature('eig').set('neigsactive', true);
model.study('std1').feature('eig').set('neigs', 1);
model.study('std1').feature('eig').set('eigwhich', 'lr');
model.study('std1').feature('eig').set('shift', 'freq_lin-100[Hz]');

model.sol.create('sol1');
model.sol('sol1').study('std1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'eig');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').set('control', 'eig');
model.sol('sol1').create('e1', 'Eigenvalue');
model.sol('sol1').feature('e1').set('neigs', 6);
model.sol('sol1').feature('e1').set('shift', '0');
model.sol('sol1').feature('e1').set('rtol', 1.0E-6);
model.sol('sol1').feature('e1').set('transform', 'none');
model.sol('sol1').feature('e1').set('eigref', '100');
model.sol('sol1').feature('e1').set('eigvfunscale', 'average');
model.sol('sol1').feature('e1').set('control', 'eig');
model.sol('sol1').feature('e1').feature('aDef').set('complexfun', true);
model.sol('sol1').feature('e1').feature('aDef').set('cachepattern', true);
model.sol('sol1').feature('e1').feature('aDef').set('matherr', true);
model.sol('sol1').feature('e1').feature('aDef').set('blocksizeactive', false);
model.sol('sol1').feature('e1').feature('aDef').set('nullfun', 'auto');
model.sol('sol1').attach('std1');
model.sol('sol1').feature('e1').set('eigref', 'freq_lin');

model.study('std1').create('param', 'Parametric');
model.study('std1').feature('param').setIndex('pname', 'Q_s', 0);
model.study('std1').feature('param').setIndex('plistarr', '', 0);
model.study('std1').feature('param').setIndex('punit', 'W/m^3', 0);
model.study('std1').feature('param').setIndex('pname', 'Q_s', 0);
model.study('std1').feature('param').setIndex('plistarr', '', 0);
model.study('std1').feature('param').setIndex('punit', 'W/m^3', 0);
model.study('std1').feature('param').setIndex('pname', 'freq_lin', 0);
model.study('std1').feature('param').setIndex('plistarr', 'range(200,450,1550)', 0);
model.study('std1').create('param2', 'Parametric');
model.study('std1').feature('param2').setIndex('pname', 'Q_s', 0);
model.study('std1').feature('param2').setIndex('plistarr', '', 0);
model.study('std1').feature('param2').setIndex('punit', 'W/m^3', 0);
model.study('std1').feature('param2').setIndex('pname', 'Q_s', 0);
model.study('std1').feature('param2').setIndex('plistarr', '', 0);
model.study('std1').feature('param2').setIndex('punit', 'W/m^3', 0);
model.study('std1').feature('param2').setIndex('pname', 'n', 0);
model.study('std1').feature('param2').setIndex('plistarr', '{0,5}', 0);

model.batch.create('p1', 'Parametric');
model.batch('p1').study('std1');
model.batch('p1').create('so1', 'Solutionseq');
model.batch('p1').feature('so1').set('seq', 'sol1');
model.batch('p1').feature('so1').set('store', 'on');
model.batch('p1').feature('so1').set('clear', 'on');
model.batch('p1').feature('so1').set('psol', 'none');
model.batch('p1').set('pname', {'freq_lin'});
model.batch('p1').set('plistarr', {'range(200,450,1550)'});
model.batch('p1').set('sweeptype', 'sparse');
model.batch('p1').set('probesel', 'all');
model.batch('p1').set('probes', {});
model.batch('p1').set('plot', 'off');
model.batch('p1').set('err', 'on');
model.batch('p1').attach('std1');
model.batch('p1').set('control', 'param');
model.batch.create('p2', 'Parametric');
model.batch('p2').study('std1');
model.batch('p2').create('jo1', 'Jobseq');
model.batch('p2').feature('jo1').set('seq', 'p1');
model.batch('p2').set('pname', {'n'});
model.batch('p2').set('plistarr', {'{0,5}'});
model.batch('p2').set('sweeptype', 'sparse');
model.batch('p2').set('err', 'on');
model.batch('p2').attach('std1');
model.batch('p2').set('control', 'param2');

model.sol.create('sol2');
model.sol('sol2').study('std1');
model.sol('sol2').label('Parametric Solutions 1');

model.batch('p1').feature('so1').set('psol', 'sol2');
model.batch('p2').run('compute');

model.result.create('pg1', 'PlotGroup2D');
model.result('pg1').set('data', 'dset2');
model.result('pg1').setIndex('looplevel', 1, 0);
model.result('pg1').setIndex('looplevel', 4, 1);
model.result('pg1').setIndex('looplevel', 2, 2);
model.result('pg1').create('surf1', 'Surface');
model.result('pg1').feature('surf1').set('expr', {'acpr.p_t'});
model.result('pg1').feature('surf1').set('colortable', 'Wave');
model.result('pg1').feature('surf1').set('colorscalemode', 'linearsymmetric');
model.result('pg1').set('showlegendsunit', true);
model.result('pg1').feature('surf1').set('colortable', 'WaveLight');
model.result('pg1').create('con1', 'Contour');
model.result('pg1').feature('con1').set('expr', {'acpr.p_t'});
model.result('pg1').feature('con1').set('colortable', 'Wave');
model.result('pg1').feature('con1').set('colorscalemode', 'linearsymmetric');
model.result('pg1').feature('con1').set('colorlegend', false);
model.result('pg1').label('Acoustic Pressure (acpr)');
model.result.create('pg2', 'PlotGroup2D');
model.result('pg2').set('data', 'dset2');
model.result('pg2').setIndex('looplevel', 1, 0);
model.result('pg2').setIndex('looplevel', 4, 1);
model.result('pg2').setIndex('looplevel', 2, 2);
model.result('pg2').create('surf1', 'Surface');
model.result('pg2').feature('surf1').set('expr', {'acpr.Lp_t'});
model.result('pg2').feature('surf1').set('colortable', 'Rainbow');
model.result('pg2').feature('surf1').set('colorscalemode', 'linear');
model.result('pg2').set('showlegendsunit', true);
model.result('pg2').label('Sound Pressure Level (acpr)');
model.result.evaluationGroup.create('std1EvgFrq', 'EvaluationGroup');
model.result.evaluationGroup('std1EvgFrq').set('defaultPlotID', 'eigenfrequenciesTable_acpr');
model.result.evaluationGroup('std1EvgFrq').set('data', 'dset2');
model.result.evaluationGroup('std1EvgFrq').label('Eigenfrequencies (Study 1)');
model.result.evaluationGroup('std1EvgFrq').create('gev1', 'EvalGlobal');
model.result.evaluationGroup('std1EvgFrq').feature('gev1').setIndex('expr', '2*pi*freq', 0);
model.result.evaluationGroup('std1EvgFrq').feature('gev1').setIndex('unit', 'rad/s', 0);
model.result.evaluationGroup('std1EvgFrq').feature('gev1').setIndex('descr', 'Angular frequency', 0);
model.result.evaluationGroup('std1EvgFrq').feature('gev1').setIndex('expr', 'imag(freq)/abs(freq)', 1);
model.result.evaluationGroup('std1EvgFrq').feature('gev1').setIndex('unit', '1', 1);
model.result.evaluationGroup('std1EvgFrq').feature('gev1').setIndex('descr', 'Damping ratio', 1);
model.result.evaluationGroup('std1EvgFrq').feature('gev1').setIndex('expr', 'abs(freq)/imag(freq)/2', 2);
model.result.evaluationGroup('std1EvgFrq').feature('gev1').setIndex('unit', '1', 2);
model.result.evaluationGroup('std1EvgFrq').feature('gev1').setIndex('descr', 'Quality factor', 2);
model.result.evaluationGroup('std1EvgFrq').run;
model.result('pg1').run;
model.result.create('pg3', 'PlotGroup1D');
model.result('pg3').run;
model.result('pg3').label('Numerical and analytical eigenfrequencies');
model.result('pg3').set('titletype', 'label');
model.result('pg3').set('data', 'dset2');
model.result('pg3').setIndex('looplevelinput', 'first', 1);
model.result('pg3').setIndex('looplevelinput', 'first', 0);
model.result('pg3').set('xlabelactive', true);
model.result('pg3').set('ylabelactive', true);
model.result('pg3').set('xlabel', 'Frequency [Hz]');
model.result('pg3').set('ylabel', 'Imag(freq) [Hz]');
model.result('pg3').set('showlegends', false);
model.result('pg3').create('tblp1', 'Table');
model.result('pg3').feature('tblp1').set('markerpos', 'datapoints');
model.result('pg3').feature('tblp1').set('linewidth', 'preference');
model.result('pg3').feature('tblp1').set('source', 'evaluationgroup');
model.result('pg3').feature('tblp1').set('xaxisdata', 3);
model.result('pg3').feature('tblp1').set('plotcolumninput', 'manual');
model.result('pg3').feature('tblp1').set('plotcolumns', [3]);
model.result('pg3').feature('tblp1').set('imagplot', true);
model.result('pg3').feature('tblp1').set('linestyle', 'none');
model.result('pg3').feature('tblp1').set('linemarker', 'circle');
model.result('pg3').create('glob1', 'Global');
model.result('pg3').feature('glob1').set('markerpos', 'datapoints');
model.result('pg3').feature('glob1').set('linewidth', 'preference');
model.result('pg3').feature('glob1').setIndex('expr', 'imag(omega1Res3)/(2*pi)', 0);
model.result('pg3').feature('glob1').set('xdata', 'expr');
model.result('pg3').feature('glob1').set('xdataexpr', 'real(omega1Res3)/(2*pi)');
model.result('pg3').feature('glob1').set('linemarker', 'plus');
model.result('pg3').feature('glob1').set('linestyle', 'none');
model.result('pg3').feature('glob1').set('linecolor', 'cyclereset');
model.result('pg3').feature.duplicate('glob2', 'glob1');
model.result('pg3').run;
model.result('pg3').feature('glob2').setIndex('expr', 0, 0);
model.result('pg3').feature('glob2').set('xdataexpr', 'c1/L');
model.result('pg3').feature.duplicate('glob3', 'glob2');
model.result('pg3').run;
model.result('pg3').feature('glob3').setIndex('expr', 'imag(omega3Res3)/(2*pi)', 0);
model.result('pg3').feature('glob3').set('xdataexpr', 'real(omega3Res3)/(2*pi)');
model.result('pg3').feature.duplicate('glob4', 'glob3');
model.result('pg3').run;
model.result('pg3').feature('glob4').setIndex('expr', 'imag(omega4Res3)/(2*pi)', 0);
model.result('pg3').feature('glob4').set('xdataexpr', 'real(omega4Res3)/(2*pi)');
model.result('pg3').run;
model.result.numerical.create('av1', 'AvSurface');
model.result.numerical('av1').set('intvolume', true);
model.result.numerical('av1').set('data', 'dset2');
model.result.numerical('av1').selection.set([2]);
model.result.numerical('av1').setIndex('expr', 'freq', 0);
model.result.numerical('av1').setIndex('expr', 'realdot(p,acpr.flm1.Q_heat)', 1);
model.result.numerical('av1').label('Rayleigh Criterion');
model.result.table.create('tbl1', 'Table');
model.result.table('tbl1').comments('Rayleigh Criterion');
model.result.numerical('av1').set('table', 'tbl1');
model.result.numerical('av1').setResult;
model.result.create('pg4', 'PlotGroup2D');
model.result('pg4').run;
model.result('pg4').set('titletype', 'label');
model.result('pg4').set('plotarrayenable', true);
model.result('pg4').set('arrayaxis', 'y');
model.result('pg4').label('Acoustic modes');
model.result('pg4').set('showlegends', false);
model.result('pg4').create('surf1', 'Surface');
model.result('pg4').feature('surf1').set('arraydim', '1');
model.result('pg4').feature('surf1').set('data', 'dset2');
model.result('pg4').feature('surf1').set('looplevel', [1 1 2]);
model.result('pg4').feature.duplicate('surf2', 'surf1');
model.result('pg4').feature('surf2').set('arraydim', '1');
model.result('pg4').run;
model.result('pg4').feature('surf2').set('looplevel', [1 2 2]);
model.result('pg4').feature.duplicate('surf3', 'surf2');
model.result('pg4').feature('surf3').set('arraydim', '1');
model.result('pg4').run;
model.result('pg4').feature('surf3').set('looplevel', [1 3 2]);
model.result('pg4').feature.duplicate('surf4', 'surf3');
model.result('pg4').feature('surf4').set('arraydim', '1');
model.result('pg4').run;
model.result('pg4').feature('surf4').set('looplevel', [1 4 2]);
model.result('pg4').run;

model.title('Active Flame Validation');

model.description('This tutorial demonstrates how to model the interaction between an acoustic field and the heat release from a flame, using the Flame Model domain feature. Modeling this interaction is important in order to understand and predict unstable acoustic modes in gas turbines and jet engines. The unstable modes are known as combustion instabilities. The model consists of a simple 2D geometry of a pipe and a compact flame region. The simple geometry allows us to validate the simulation results against an analytical solution.');

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

model.label('active_flame_validation.mph');

model.modelNode.label('Components');

out = model;
