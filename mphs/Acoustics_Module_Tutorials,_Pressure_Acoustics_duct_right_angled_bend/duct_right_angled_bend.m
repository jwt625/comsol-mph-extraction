function out = model
%
% duct_right_angled_bend.m
%
% Model exported on May 26 2025, 21:25 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/Acoustics_Module/Tutorials,_Pressure_Acoustics');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 3);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.physics.create('acpr', 'PressureAcoustics', 'geom1');
model.physics('acpr').model('comp1');

model.study.create('std1');
model.study('std1').create('freq', 'Frequency');
model.study('std1').feature('freq').setSolveFor('/physics/acpr', true);

model.geom('geom1').insertFile('duct_right_angled_bend_geom_sequence.mph', 'geom1');
model.geom('geom1').run('fin');

model.param.set('f_max', '1300[Hz]');
model.param.descr('f_max', 'Maximum study frequency');
model.param.set('lambda_min', '343[m/s]/f_max');
model.param.descr('lambda_min', 'Minimum wavelength');

model.selection.create('sel1', 'Explicit');
model.selection('sel1').model('comp1');
model.selection('sel1').label('Inlet');
model.selection('sel1').geom(2);
model.selection('sel1').set([1]);
model.selection.create('sel2', 'Explicit');
model.selection('sel2').model('comp1');
model.selection('sel2').label('Outlet');
model.selection('sel2').geom(2);

model.view('view1').set('renderwireframe', true);

model.selection('sel2').set([12]);

model.view('view1').set('renderwireframe', false);

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

model.nodeGroup.create('grp1', 'Physics', 'acpr');
model.nodeGroup('grp1').label('Inlet Ports');

model.physics('acpr').create('port1', 'Port', 2);

model.nodeGroup('grp1').add('port1');

model.physics('acpr').feature('port1').selection.named('sel1');
model.physics('acpr').feature('port1').set('PortType', 'Rectangular');
model.physics('acpr').feature('port1').set('pamp', 1);
model.physics('acpr').create('port2', 'Port', 2);

model.nodeGroup('grp1').add('port2');

model.physics('acpr').feature('port2').selection.named('sel1');
model.physics('acpr').feature('port2').set('PortType', 'Rectangular');
model.physics('acpr').feature('port2').set('m_rect', 1);
model.physics('acpr').create('port3', 'Port', 2);

model.nodeGroup('grp1').add('port3');

model.physics('acpr').feature('port3').selection.named('sel1');
model.physics('acpr').feature('port3').set('PortType', 'Rectangular');
model.physics('acpr').feature('port3').set('n_rect', 1);
model.physics('acpr').create('port4', 'Port', 2);

model.nodeGroup('grp1').add('port4');

model.physics('acpr').feature('port4').selection.named('sel1');
model.physics('acpr').feature('port4').set('PortType', 'Rectangular');
model.physics('acpr').feature('port4').set('m_rect', 1);
model.physics('acpr').feature('port4').set('n_rect', 1);
model.physics('acpr').create('port5', 'Port', 2);

model.nodeGroup('grp1').add('port5');

model.physics('acpr').feature('port5').selection.named('sel1');
model.physics('acpr').feature('port5').set('PortType', 'Rectangular');
model.physics('acpr').feature('port5').set('m_rect', 2);

model.nodeGroup.create('grp2', 'Physics', 'acpr');
model.nodeGroup('grp2').label('Outlet Ports');

model.physics('acpr').create('port6', 'Port', 2);

model.nodeGroup('grp2').add('port6');

model.physics('acpr').feature('port6').selection.named('sel2');
model.physics('acpr').feature('port6').set('PortType', 'Rectangular');
model.physics('acpr').create('port7', 'Port', 2);

model.nodeGroup('grp2').add('port7');

model.physics('acpr').feature('port7').selection.named('sel2');
model.physics('acpr').feature('port7').set('PortType', 'Rectangular');
model.physics('acpr').feature('port7').set('m_rect', 1);
model.physics('acpr').create('port8', 'Port', 2);

model.nodeGroup('grp2').add('port8');

model.physics('acpr').feature('port8').selection.named('sel2');
model.physics('acpr').feature('port8').set('PortType', 'Rectangular');
model.physics('acpr').feature('port8').set('n_rect', 1);
model.physics('acpr').create('port9', 'Port', 2);

model.nodeGroup('grp2').add('port9');

model.physics('acpr').feature('port9').selection.named('sel2');
model.physics('acpr').feature('port9').set('PortType', 'Rectangular');
model.physics('acpr').feature('port9').set('m_rect', 1);
model.physics('acpr').feature('port9').set('n_rect', 1);
model.physics('acpr').create('port10', 'Port', 2);

model.nodeGroup('grp2').add('port10');

model.physics('acpr').feature('port10').selection.named('sel2');
model.physics('acpr').feature('port10').set('PortType', 'Rectangular');
model.physics('acpr').feature('port10').set('m_rect', 2);

model.mesh('mesh1').create('swe1', 'Sweep');
model.mesh('mesh1').feature('size').set('custom', true);
model.mesh('mesh1').feature('size').set('hmax', 'lambda_min/5');
model.mesh('mesh1').feature('swe1').selection('sourceface').set([4 9 10 11]);
model.mesh('mesh1').feature('swe1').selection('targetface').set([3]);
model.mesh('mesh1').feature('swe1').set('facemethod', 'tri');
model.mesh('mesh1').run;

model.study('std1').feature('freq').set('plist', '{50, 51.5, 53, 54.5, 56, 58, 60, 61.5, 63, 65, 67, 69, 71, 73, 75, 77.5, 80, 82.5, 85, 87.5, 90, 92.5, 95, 97.5, 100, 103, 106, 109, 112, 115, 118, 122, 125, 128, 132, 136, 140, 145, 150, 155, 160, 165, 170, 175, 180, 185, 190, 195, 200, 206, 212, 218, 224, 230, 236, 243, 250, 258, 265, 272, 280, 290, 300, 307, 315, 325, 335, 345, 355, 365, 375, 387, 400, 412, 425, 437, 450, 462, 475, 487, 500, 515, 530, 545, 560, 580, 600, 615, 630, 650, 670, 690, 710, 730, 750, 775, 800, 825, 850, 875, 900, 925, 950, 975, 1e3, 1.03e3, 1.06e3, 1.09e3, 1.12e3, 1.15e3, 1.18e3, 1.22e3, 1.25e3, 1.28e3}');

model.sol.create('sol1');
model.sol('sol1').study('std1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'freq');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').set('control', 'freq');
model.sol('sol1').create('s1', 'Stationary');
model.sol('sol1').feature('s1').set('stol', 0.001);
model.sol('sol1').feature('s1').create('p1', 'Parametric');
model.sol('sol1').feature('s1').feature.remove('pDef');
model.sol('sol1').feature('s1').feature('p1').set('pname', {'freq'});
model.sol('sol1').feature('s1').feature('p1').set('plistarr', {'{50, 51.5, 53, 54.5, 56, 58, 60, 61.5, 63, 65, 67, 69, 71, 73, 75, 77.5, 80, 82.5, 85, 87.5, 90, 92.5, 95, 97.5, 100, 103, 106, 109, 112, 115, 118, 122, 125, 128, 132, 136, 140, 145, 150, 155, 160, 165, 170, 175, 180, 185, 190, 195, 200, 206, 212, 218, 224, 230, 236, 243, 250, 258, 265, 272, 280, 290, 300, 307, 315, 325, 335, 345, 355, 365, 375, 387, 400, 412, 425, 437, 450, 462, 475, 487, 500, 515, 530, 545, 560, 580, 600, 615, 630, 650, 670, 690, 710, 730, 750, 775, 800, 825, 850, 875, 900, 925, 950, 975, 1e3, 1.03e3, 1.06e3, 1.09e3, 1.12e3, 1.15e3, 1.18e3, 1.22e3, 1.25e3, 1.28e3}'});
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
model.sol('sol1').feature('s1').feature('aDef').set('complexfun', true);
model.sol('sol1').feature('s1').feature('aDef').set('cachepattern', true);
model.sol('sol1').feature('s1').feature('aDef').set('matherr', true);
model.sol('sol1').feature('s1').feature('aDef').set('blocksizeactive', false);
model.sol('sol1').feature('s1').feature('aDef').set('nullfun', 'auto');
model.sol('sol1').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('s1').create('d1', 'Direct');
model.sol('sol1').feature('s1').feature('d1').set('linsolver', 'mumps');
model.sol('sol1').feature('s1').feature('d1').label('Suggested Direct Solver (acpr)');
model.sol('sol1').feature('s1').create('i1', 'Iterative');
model.sol('sol1').feature('s1').feature('i1').set('linsolver', 'gmres');
model.sol('sol1').feature('s1').feature('i1').label('Suggested Iterative Solver (GMRES with GMG) (acpr)');
model.sol('sol1').feature('s1').feature('i1').create('mg1', 'Multigrid');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').set('prefun', 'gmg');
model.sol('sol1').feature('s1').create('i2', 'Iterative');
model.sol('sol1').feature('s1').feature('i2').set('linsolver', 'fgmres');
model.sol('sol1').feature('s1').feature('i2').label('Suggested Iterative Solver (FGMRES with GMG) (acpr)');
model.sol('sol1').feature('s1').feature('i2').create('mg1', 'Multigrid');
model.sol('sol1').feature('s1').feature('i2').feature('mg1').set('prefun', 'gmg');
model.sol('sol1').feature('s1').create('i3', 'Iterative');
model.sol('sol1').feature('s1').feature('i3').set('linsolver', 'gmres');
model.sol('sol1').feature('s1').feature('i3').label('Suggested Iterative Solver (Shifted Laplace) (acpr)');
model.sol('sol1').feature('s1').feature('i3').create('mg1', 'Multigrid');
model.sol('sol1').feature('s1').feature('i3').feature('mg1').set('prefun', 'gmg');
model.sol('sol1').feature('s1').feature('i3').feature('mg1').set('iter', 1);
model.sol('sol1').feature('s1').feature('i3').feature('mg1').set('mcasegen', 'coarse');
model.sol('sol1').feature('s1').feature('i3').feature('mg1').set('scale', '3');
model.sol('sol1').feature('s1').feature('i3').feature('mg1').set('slaplacemain', false);
model.sol('sol1').feature('s1').feature('i3').feature('mg1').set('slaplacemg', true);
model.sol('sol1').feature('s1').feature('i3').feature('mg1').set('addweakcontribslaplacemain', {});
model.sol('sol1').feature('s1').feature('i3').feature('mg1').set('addweakcontribslaplacemg', {});
model.sol('sol1').feature('s1').feature('i3').feature('mg1').set('epsslaplacemain', {'acpr' '0.4'});
model.sol('sol1').feature('s1').feature('i3').feature('mg1').set('epsslaplacemg', {'acpr' '0.4'});
model.sol('sol1').feature('s1').create('i4', 'Iterative');
model.sol('sol1').feature('s1').feature('i4').set('linsolver', 'gmres');
model.sol('sol1').feature('s1').feature('i4').label('Suggested Iterative Solver (Domain Decomposition) (acpr)');
model.sol('sol1').feature('s1').feature('i4').create('dd1', 'DomainDecomposition');
model.sol('sol1').feature('s1').feature('i4').feature('dd1').set('prefun', 'ddhyb');
model.sol('sol1').feature('s1').feature('i4').feature('dd1').set('ddolhandling', 'ddrestricted');
model.sol('sol1').feature('s1').feature('i4').feature('dd1').set('dompernodemax', 1);
model.sol('sol1').feature('s1').feature('i4').feature('dd1').set('dompernodemaxactive', 'on');
model.sol('sol1').feature('s1').feature('i4').feature('dd1').set('userac', 'off');
model.sol('sol1').feature('s1').feature('i4').feature('dd1').set('usecoarse', false);
model.sol('sol1').feature('s1').feature('i4').feature('dd1').set('ddboundary', 'absorbing');
model.sol('sol1').feature('s1').feature('i4').feature('dd1').set('slaplacemain', true);
model.sol('sol1').feature('s1').feature('i4').feature('dd1').set('slaplacemg', 'on');
model.sol('sol1').feature('s1').feature('i4').feature('dd1').set('alphaabsorbing', {'acpr' '1'});
model.sol('sol1').feature('s1').feature('i4').feature('dd1').set('betaabsorbing', {'acpr' '0.1'});
model.sol('sol1').feature('s1').feature('i4').feature('dd1').set('sndorderabsorbing', {'acpr' 'on'});
model.sol('sol1').feature('s1').feature('i4').feature('dd1').set('epsslaplacemain', {'acpr' '0.4'});
model.sol('sol1').feature('s1').feature('i4').feature('dd1').set('epsslaplacemg', {'acpr' '0.4'});
model.sol('sol1').feature('s1').feature('i4').feature('dd1').set('iter', 1);
model.sol('sol1').feature('s1').feature('i4').feature('dd1').feature('ds').create('mg1', 'Multigrid');
model.sol('sol1').feature('s1').feature('i4').feature('dd1').feature('ds').feature('mg1').set('slaplacemg', 'on');
model.sol('sol1').feature('s1').feature('i4').feature('dd1').feature('ds').feature('mg1').set('epsslaplacemg', {'acpr' '0.4'});
model.sol('sol1').feature('s1').feature('i4').feature('dd1').feature('ds').feature('mg1').set('iter', 1);
model.sol('sol1').feature('s1').feature('fc1').set('linsolver', 'd1');
model.sol('sol1').feature('s1').feature.remove('fcDef');
model.sol('sol1').attach('std1');
model.sol('sol1').runAll;

model.result.create('pg1', 'PlotGroup3D');
model.result('pg1').set('data', 'dset1');
model.result('pg1').setIndex('looplevel', 114, 0);
model.result('pg1').create('surf1', 'Surface');
model.result('pg1').feature('surf1').set('expr', {'acpr.p_t'});
model.result('pg1').feature('surf1').set('colortable', 'Wave');
model.result('pg1').feature('surf1').set('colorscalemode', 'linearsymmetric');
model.result('pg1').set('showlegendsunit', true);
model.result('pg1').label('Acoustic Pressure (acpr)');
model.result.create('pg2', 'PlotGroup3D');
model.result('pg2').set('data', 'dset1');
model.result('pg2').setIndex('looplevel', 114, 0);
model.result('pg2').create('surf1', 'Surface');
model.result('pg2').feature('surf1').set('expr', {'acpr.Lp_t'});
model.result('pg2').feature('surf1').set('colortable', 'Rainbow');
model.result('pg2').feature('surf1').set('colorscalemode', 'linear');
model.result('pg2').set('showlegendsunit', true);
model.result('pg2').label('Sound Pressure Level (acpr)');
model.result.create('pg3', 'PlotGroup3D');
model.result('pg3').set('data', 'dset1');
model.result('pg3').setIndex('looplevel', 114, 0);
model.result('pg3').create('iso1', 'Isosurface');
model.result('pg3').feature('iso1').set('expr', {'acpr.p_t'});
model.result('pg3').feature('iso1').set('number', '10');
model.result('pg3').feature('iso1').set('colortable', 'Wave');
model.result('pg3').feature('iso1').set('colorscalemode', 'linearsymmetric');
model.result('pg3').set('showlegendsunit', true);
model.result('pg3').label('Acoustic Pressure, Isosurfaces (acpr)');
model.result('pg1').run;
model.result('pg1').run;
model.result('pg1').setIndex('looplevel', 73, 0);
model.result('pg2').run;
model.result('pg2').setIndex('looplevel', 73, 0);
model.result('pg3').run;
model.result('pg3').setIndex('looplevel', 73, 0);
model.result.create('pg4', 'PlotGroup1D');
model.result('pg4').run;
model.result('pg4').label('Scattering Coefficients');
model.result('pg4').set('titletype', 'label');
model.result('pg4').set('legendpos', 'upperleft');
model.result('pg4').create('glob1', 'Global');
model.result('pg4').feature('glob1').set('markerpos', 'datapoints');
model.result('pg4').feature('glob1').set('linewidth', 'preference');
model.result('pg4').feature('glob1').setIndex('expr', 'abs(acpr.S11)', 0);
model.result('pg4').feature('glob1').setIndex('unit', 1, 0);
model.result('pg4').feature('glob1').setIndex('descr', 'abs(S11)', 0);
model.result('pg4').feature('glob1').setIndex('expr', 'abs(acpr.S21)', 1);
model.result('pg4').feature('glob1').setIndex('unit', 1, 1);
model.result('pg4').feature('glob1').setIndex('descr', 'abs(S21)', 1);
model.result('pg4').feature('glob1').setIndex('expr', 'abs(acpr.S31)', 2);
model.result('pg4').feature('glob1').setIndex('unit', 1, 2);
model.result('pg4').feature('glob1').setIndex('descr', 'abs(S31)', 2);
model.result('pg4').feature('glob1').setIndex('expr', 'abs(acpr.S41)', 3);
model.result('pg4').feature('glob1').setIndex('unit', 1, 3);
model.result('pg4').feature('glob1').setIndex('descr', 'abs(S41)', 3);
model.result('pg4').feature('glob1').setIndex('expr', 'abs(acpr.S51)', 4);
model.result('pg4').feature('glob1').setIndex('unit', 1, 4);
model.result('pg4').feature('glob1').setIndex('descr', 'abs(S51)', 4);
model.result('pg4').feature('glob1').setIndex('expr', 'abs(acpr.S61)', 5);
model.result('pg4').feature('glob1').setIndex('unit', 1, 5);
model.result('pg4').feature('glob1').setIndex('descr', 'abs(S61)', 5);
model.result('pg4').feature('glob1').setIndex('expr', 'abs(acpr.S71)', 6);
model.result('pg4').feature('glob1').setIndex('unit', 1, 6);
model.result('pg4').feature('glob1').setIndex('descr', 'abs(S71)', 6);
model.result('pg4').feature('glob1').setIndex('expr', 'abs(acpr.S81)', 7);
model.result('pg4').feature('glob1').setIndex('unit', 1, 7);
model.result('pg4').feature('glob1').setIndex('descr', 'abs(S81)', 7);
model.result('pg4').feature('glob1').setIndex('expr', 'abs(acpr.S91)', 8);
model.result('pg4').feature('glob1').setIndex('unit', 1, 8);
model.result('pg4').feature('glob1').setIndex('descr', 'abs(S91)', 8);
model.result('pg4').feature('glob1').setIndex('expr', 'abs(acpr.S10_1)', 9);
model.result('pg4').feature('glob1').setIndex('unit', 1, 9);
model.result('pg4').feature('glob1').setIndex('descr', 'abs(S10_1)', 9);
model.result('pg4').run;
model.result.create('pg5', 'PlotGroup1D');
model.result('pg5').run;
model.result('pg5').label('Transmission Loss');
model.result('pg5').set('titletype', 'label');
model.result('pg5').set('ylabelactive', true);
model.result('pg5').set('ylabel', 'Transmission Loss (dB)');
model.result('pg5').set('legendpos', 'upperleft');
model.result('pg5').create('oct1', 'OctaveBand');
model.result('pg5').feature('oct1').set('quantity', 'bandpower');
model.result('pg5').feature('oct1').set('markerpos', 'datapoints');
model.result('pg5').feature('oct1').set('linewidth', 'preference');
model.result('pg5').feature('oct1').selection.geom('geom1');
model.result('pg5').feature('oct1').set('expr', 'acpr.port1.P_in/(acpr.port6.P_out+acpr.port7.P_out+acpr.port8.P_out+acpr.port9.P_out+acpr.port10.P_out)');
model.result('pg5').feature('oct1').set('exprtype', 'transfer');
model.result('pg5').feature('oct1').set('quantity', 'continuous');
model.result('pg5').feature('oct1').set('legend', true);
model.result('pg5').feature('oct1').set('legendmethod', 'manual');
model.result('pg5').feature('oct1').setIndex('legends', 'Transmission Loss - Continuous', 0);
model.result('pg5').run;
model.result('pg5').feature.duplicate('oct2', 'oct1');
model.result('pg5').run;
model.result('pg5').feature('oct2').set('quantity', 'bandaveragepsd');
model.result('pg5').feature('oct2').set('bandtype', 'octave3');
model.result('pg5').feature('oct2').set('type', 'outline');
model.result('pg5').feature('oct2').setIndex('legends', 'Transmission Loss - 1/3 Octave Bands', 0);
model.result('pg5').run;
model.result.dataset.create('surf1', 'Surface');
model.result.dataset('surf1').selection.set([1]);
model.result.create('pg6', 'PlotGroup2D');
model.result('pg6').run;
model.result('pg6').label('Normalized Mode Shapes');
model.result('pg6').set('titletype', 'label');
model.result('pg6').create('surf1', 'Surface');
model.result('pg6').feature('surf1').set('expr', 'acpr.port1.pn');
model.result('pg6').feature('surf1').set('descr', 'Normalized mode pressure');
model.result('pg6').run;
model.result('pg6').feature.duplicate('surf2', 'surf1');
model.result('pg6').run;
model.result('pg6').feature('surf2').set('expr', 'acpr.port2.pn');
model.result('pg6').feature('surf2').set('inheritplot', 'surf1');
model.result('pg6').feature('surf2').create('trn1', 'Translation');
model.result('pg6').run;
model.result('pg6').feature('surf2').feature('trn1').set('trans', {'1.1*W' '0'});
model.result('pg6').run;
model.result('pg6').run;
model.result('pg6').feature.duplicate('surf3', 'surf2');
model.result('pg6').run;
model.result('pg6').feature('surf3').set('expr', 'acpr.port3.pn');
model.result('pg6').run;
model.result('pg6').feature('surf3').feature('trn1').set('trans', {'0' '-1.1*H'});
model.result('pg6').run;
model.result('pg6').run;
model.result('pg6').feature.duplicate('surf4', 'surf3');
model.result('pg6').run;
model.result('pg6').feature('surf4').set('expr', 'acpr.port4.pn');
model.result('pg6').run;
model.result('pg6').feature('surf4').feature('trn1').set('trans', {'1.1*W' '-1.1*H'});
model.result('pg6').run;
model.result('pg6').run;
model.result('pg6').feature.duplicate('surf5', 'surf4');
model.result('pg6').run;
model.result('pg6').feature('surf5').set('expr', 'acpr.port5.pn');
model.result('pg6').run;
model.result('pg6').feature('surf5').feature('trn1').set('trans', {'2.2*W' '0'});
model.result('pg6').run;
model.result.evaluationGroup.create('eg1', 'EvaluationGroup');
model.result.evaluationGroup('eg1').label('Cutoff Frequencies');
model.result.evaluationGroup('eg1').setIndex('looplevelinput', 'first', 0);
model.result.evaluationGroup('eg1').create('gev1', 'EvalGlobal');
model.result.evaluationGroup('eg1').feature('gev1').set('expr', {'acpr.port1.fc'});
model.result.evaluationGroup('eg1').feature('gev1').set('descr', {'Mode cutoff frequency'});
model.result.evaluationGroup('eg1').feature('gev1').set('unit', {'Hz'});
model.result.evaluationGroup('eg1').feature('gev1').setIndex('descr', 'Mode (0,0) cutoff frequency', 0);
model.result.evaluationGroup('eg1').feature('gev1').setIndex('expr', 'acpr.port2.fc', 1);
model.result.evaluationGroup('eg1').feature('gev1').setIndex('unit', 'Hz', 1);
model.result.evaluationGroup('eg1').feature('gev1').setIndex('descr', 'Mode (1,0) cutoff frequency', 1);
model.result.evaluationGroup('eg1').feature('gev1').setIndex('expr', 'acpr.port3.fc', 2);
model.result.evaluationGroup('eg1').feature('gev1').setIndex('unit', 'Hz', 2);
model.result.evaluationGroup('eg1').feature('gev1').setIndex('descr', 'Mode (0,1) cutoff frequency', 2);
model.result.evaluationGroup('eg1').feature('gev1').setIndex('expr', 'acpr.port4.fc', 3);
model.result.evaluationGroup('eg1').feature('gev1').setIndex('unit', 'Hz', 3);
model.result.evaluationGroup('eg1').feature('gev1').setIndex('descr', 'Mode (1,1) cutoff frequency', 3);
model.result.evaluationGroup('eg1').feature('gev1').setIndex('expr', 'acpr.port5.fc', 4);
model.result.evaluationGroup('eg1').feature('gev1').setIndex('unit', 'Hz', 4);
model.result.evaluationGroup('eg1').feature('gev1').setIndex('descr', 'Mode (2,0) cutoff frequency', 4);
model.result.evaluationGroup('eg1').run;
model.result.create('pg7', 'PlotGroup1D');
model.result('pg7').run;
model.result('pg7').label('Normalized Port Outgoing Power');
model.result('pg7').set('titletype', 'label');
model.result('pg7').set('legendpos', 'middleleft');
model.result('pg7').create('glob1', 'Global');
model.result('pg7').feature('glob1').set('markerpos', 'datapoints');
model.result('pg7').feature('glob1').set('linewidth', 'preference');
model.result('pg7').feature('glob1').setIndex('expr', 'acpr.port1.P_out/acpr.port1.P_in', 0);
model.result('pg7').feature('glob1').setIndex('unit', 1, 0);
model.result('pg7').feature('glob1').setIndex('descr', 'Port 1', 0);
model.result('pg7').feature('glob1').setIndex('expr', 'acpr.port2.P_out/acpr.port1.P_in', 1);
model.result('pg7').feature('glob1').setIndex('unit', 1, 1);
model.result('pg7').feature('glob1').setIndex('descr', 'Port 2', 1);
model.result('pg7').feature('glob1').setIndex('expr', 'acpr.port3.P_out/acpr.port1.P_in', 2);
model.result('pg7').feature('glob1').setIndex('unit', 1, 2);
model.result('pg7').feature('glob1').setIndex('descr', 'Port 3', 2);
model.result('pg7').feature('glob1').setIndex('expr', 'acpr.port4.P_out/acpr.port1.P_in', 3);
model.result('pg7').feature('glob1').setIndex('unit', 1, 3);
model.result('pg7').feature('glob1').setIndex('descr', 'Port 4', 3);
model.result('pg7').feature('glob1').setIndex('expr', 'acpr.port5.P_out/acpr.port1.P_in', 4);
model.result('pg7').feature('glob1').setIndex('unit', 1, 4);
model.result('pg7').feature('glob1').setIndex('descr', 'Port 5', 4);
model.result('pg7').feature.duplicate('glob2', 'glob1');
model.result('pg7').run;
model.result('pg7').feature('glob2').setIndex('expr', 'acpr.port6.P_out/acpr.port1.P_in', 0);
model.result('pg7').feature('glob2').setIndex('unit', 1, 0);
model.result('pg7').feature('glob2').setIndex('descr', 'Port 6', 0);
model.result('pg7').feature('glob2').setIndex('expr', 'acpr.port7.P_out/acpr.port1.P_in', 1);
model.result('pg7').feature('glob2').setIndex('unit', 1, 1);
model.result('pg7').feature('glob2').setIndex('descr', 'Port 7', 1);
model.result('pg7').feature('glob2').setIndex('expr', 'acpr.port8.P_out/acpr.port1.P_in', 2);
model.result('pg7').feature('glob2').setIndex('unit', 1, 2);
model.result('pg7').feature('glob2').setIndex('descr', 'Port 8', 2);
model.result('pg7').feature('glob2').setIndex('expr', 'acpr.port9.P_out/acpr.port1.P_in', 3);
model.result('pg7').feature('glob2').setIndex('unit', 1, 3);
model.result('pg7').feature('glob2').setIndex('descr', 'Port 9', 3);
model.result('pg7').feature('glob2').setIndex('expr', 'acpr.port10.P_out/acpr.port1.P_in', 4);
model.result('pg7').feature('glob2').setIndex('unit', 1, 4);
model.result('pg7').feature('glob2').setIndex('descr', 'Port 10', 4);
model.result('pg7').feature('glob2').set('linestyle', 'dashed');
model.result('pg7').feature('glob2').set('linecolor', 'cyclereset');
model.result('pg7').run;
model.result('pg3').run;
model.result('pg3').setIndex('looplevel', 93, 0);
model.result('pg3').setIndex('looplevel', 101, 0);
model.result('pg3').setIndex('looplevel', 111, 0);
model.result('pg3').setIndex('looplevel', 93, 0);

model.title('Duct with Right-Angled Bend');

model.description('In this tutorial the acoustic behavior of a duct or waveguide with a right angled bend is analyzed. The model uses port boundary conditions at the inlet and outlet. The ports can capture and treat nonplane-propagating modes in waveguides, extending the analysis above the first cutoff frequency. The transmission loss and the scattering coefficients of the system are determined.');

model.mesh.clearMeshes;

model.sol('sol1').clearSolutionData;

model.label('duct_right_angled_bend.mph');

model.modelNode.label('Components');

out = model;
