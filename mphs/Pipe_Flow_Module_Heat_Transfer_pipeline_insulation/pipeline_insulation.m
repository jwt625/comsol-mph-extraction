function out = model
%
% pipeline_insulation.m
%
% Model exported on May 26 2025, 21:31 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/Pipe_Flow_Module/Heat_Transfer');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 3);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.physics.create('nipfl', 'NonisothermalPipeFlow', 'geom1');
model.physics('nipfl').model('comp1');

model.study.create('std1');
model.study('std1').create('stat', 'Stationary');
model.study('std1').feature('stat').setSolveFor('/physics/nipfl', true);

model.geom('geom1').create('pol1', 'Polygon');
model.geom('geom1').feature('pol1').set('source', 'table');
model.geom('geom1').feature('pol1').setIndex('table', 0, 0, 0);
model.geom('geom1').feature('pol1').setIndex('table', 0, 0, 1);
model.geom('geom1').feature('pol1').setIndex('table', 0, 0, 2);
model.geom('geom1').feature('pol1').setIndex('table', 0, 1, 0);
model.geom('geom1').feature('pol1').setIndex('table', 0, 1, 1);
model.geom('geom1').feature('pol1').setIndex('table', 0, 1, 2);
model.geom('geom1').feature('pol1').setIndex('table', '150e3', 2, 0);
model.geom('geom1').feature('pol1').setIndex('table', 0, 2, 1);
model.geom('geom1').feature('pol1').setIndex('table', 0, 2, 2);
model.geom('geom1').run('pol1');

% To import content from file, use:
% model.param.loadFile('FILENAME');
model.param.set('rho_oil', '870[kg/m^3]', 'Oil density');
model.param.set('mu_oil', '1e-2[Pa*s]', 'Oil viscosity');
model.param.set('Cp_oil', '2000[J/kg/K]', 'Oil heat capacity');
model.param.set('k_oil', '0.1[W/m/K]', 'Oil thermal conductivity');
model.param.set('gamma_oil', '1', 'Ratio of specific heats');
model.param.set('v_air', '5[m/s]', 'Air velocity outside pipe');
model.param.set('T_in', '25[degC]', 'Inlet temperature');
model.param.set('T_ext', '-10[degC]', 'External temperature');
model.param.set('d_wall', '2[cm]', 'Thickness of pipe wall');
model.param.set('k_wall', '45[W/m/K]', 'Thermal conductivity of pipe wall');
model.param.set('d_ins', '3[cm]', 'Thickness of insulation layer');
model.param.set('k_ins', '0.025[W/m/K]', 'Thermal conductivity of insulation');
model.param.set('oil_rate', '2500[m^3/h]', 'Oil volumetric flow rate');

model.geom('geom1').run;

model.material.create('mat1', 'Common', 'comp1');
model.material('mat1').label('Crude oil');
model.material('mat1').propertyGroup('def').set('density', {'rho_oil'});
model.material('mat1').propertyGroup('def').set('dynamicviscosity', {'mu_oil'});
model.material('mat1').propertyGroup('def').set('heatcapacity', {'Cp_oil'});
model.material('mat1').propertyGroup('def').set('ratioofspecificheat', {'gamma_oil'});
model.material('mat1').propertyGroup('def').set('thermalconductivity', {'k_oil'});
model.material.create('mat2', 'Common', 'comp1');
model.material('mat2').propertyGroup('def').func.create('eta', 'Piecewise');
model.material('mat2').propertyGroup('def').func.create('Cp', 'Piecewise');
model.material('mat2').propertyGroup('def').func.create('rho', 'Analytic');
model.material('mat2').propertyGroup('def').func.create('k', 'Piecewise');
model.material('mat2').propertyGroup('def').func.create('cs', 'Analytic');
model.material('mat2').propertyGroup('def').func.create('an1', 'Analytic');
model.material('mat2').propertyGroup('def').func.create('an2', 'Analytic');
model.material('mat2').propertyGroup.create('RefractiveIndex', 'Refractive index');
model.material('mat2').propertyGroup.create('NonlinearModel', 'Nonlinear model');
model.material('mat2').propertyGroup.create('idealGas', 'Ideal gas');
model.material('mat2').propertyGroup('idealGas').func.create('Cp', 'Piecewise');
model.material('mat2').label('Air');
model.material('mat2').set('family', 'air');
model.material('mat2').propertyGroup('def').func('eta').set('arg', 'T');
model.material('mat2').propertyGroup('def').func('eta').set('pieces', {'200.0' '1600.0' '-8.38278E-7+8.35717342E-8*T^1-7.69429583E-11*T^2+4.6437266E-14*T^3-1.06585607E-17*T^4'});
model.material('mat2').propertyGroup('def').func('eta').set('argunit', 'K');
model.material('mat2').propertyGroup('def').func('eta').set('fununit', 'Pa*s');
model.material('mat2').propertyGroup('def').func('Cp').set('arg', 'T');
model.material('mat2').propertyGroup('def').func('Cp').set('pieces', {'200.0' '1600.0' '1047.63657-0.372589265*T^1+9.45304214E-4*T^2-6.02409443E-7*T^3+1.2858961E-10*T^4'});
model.material('mat2').propertyGroup('def').func('Cp').set('argunit', 'K');
model.material('mat2').propertyGroup('def').func('Cp').set('fununit', 'J/(kg*K)');
model.material('mat2').propertyGroup('def').func('rho').set('expr', 'pA*0.02897/R_const[K*mol/J]/T');
model.material('mat2').propertyGroup('def').func('rho').set('args', {'pA' 'T'});
model.material('mat2').propertyGroup('def').func('rho').set('fununit', 'kg/m^3');
model.material('mat2').propertyGroup('def').func('rho').set('argunit', {'Pa' 'K'});
model.material('mat2').propertyGroup('def').func('rho').set('plotaxis', {'off' 'on'});
model.material('mat2').propertyGroup('def').func('rho').set('plotfixedvalue', {'101325' '273.15'});
model.material('mat2').propertyGroup('def').func('rho').set('plotargs', {'pA' '101325' '101325'; 'T' '273.15' '293.15'});
model.material('mat2').propertyGroup('def').func('k').set('arg', 'T');
model.material('mat2').propertyGroup('def').func('k').set('pieces', {'200.0' '1600.0' '-0.00227583562+1.15480022E-4*T^1-7.90252856E-8*T^2+4.11702505E-11*T^3-7.43864331E-15*T^4'});
model.material('mat2').propertyGroup('def').func('k').set('argunit', 'K');
model.material('mat2').propertyGroup('def').func('k').set('fununit', 'W/(m*K)');
model.material('mat2').propertyGroup('def').func('cs').set('expr', 'sqrt(1.4*R_const[K*mol/J]/0.02897*T)');
model.material('mat2').propertyGroup('def').func('cs').set('args', {'T'});
model.material('mat2').propertyGroup('def').func('cs').set('fununit', 'm/s');
model.material('mat2').propertyGroup('def').func('cs').set('argunit', {'K'});
model.material('mat2').propertyGroup('def').func('cs').set('plotfixedvalue', {'273.15'});
model.material('mat2').propertyGroup('def').func('cs').set('plotargs', {'T' '273.15' '373.15'});
model.material('mat2').propertyGroup('def').func('an1').set('funcname', 'alpha_p');
model.material('mat2').propertyGroup('def').func('an1').set('expr', '-1/rho(pA,T)*d(rho(pA,T),T)');
model.material('mat2').propertyGroup('def').func('an1').set('args', {'pA' 'T'});
model.material('mat2').propertyGroup('def').func('an1').set('fununit', '1/K');
model.material('mat2').propertyGroup('def').func('an1').set('argunit', {'Pa' 'K'});
model.material('mat2').propertyGroup('def').func('an1').set('plotaxis', {'off' 'on'});
model.material('mat2').propertyGroup('def').func('an1').set('plotfixedvalue', {'101325' '273.15'});
model.material('mat2').propertyGroup('def').func('an1').set('plotargs', {'pA' '101325' '101325'; 'T' '273.15' '373.15'});
model.material('mat2').propertyGroup('def').func('an2').set('funcname', 'muB');
model.material('mat2').propertyGroup('def').func('an2').set('expr', '0.6*eta(T)');
model.material('mat2').propertyGroup('def').func('an2').set('args', {'T'});
model.material('mat2').propertyGroup('def').func('an2').set('fununit', 'Pa*s');
model.material('mat2').propertyGroup('def').func('an2').set('argunit', {'K'});
model.material('mat2').propertyGroup('def').func('an2').set('plotfixedvalue', {'200'});
model.material('mat2').propertyGroup('def').func('an2').set('plotargs', {'T' '200' '1600'});
model.material('mat2').propertyGroup('def').set('thermalexpansioncoefficient', '');
model.material('mat2').propertyGroup('def').set('molarmass', '');
model.material('mat2').propertyGroup('def').set('bulkviscosity', '');
model.material('mat2').propertyGroup('def').set('thermalexpansioncoefficient', {'alpha_p(pA,T)' '0' '0' '0' 'alpha_p(pA,T)' '0' '0' '0' 'alpha_p(pA,T)'});
model.material('mat2').propertyGroup('def').set('molarmass', '0.02897[kg/mol]');
model.material('mat2').propertyGroup('def').set('bulkviscosity', 'muB(T)');
model.material('mat2').propertyGroup('def').set('relpermeability', {'1' '0' '0' '0' '1' '0' '0' '0' '1'});
model.material('mat2').propertyGroup('def').set('relpermittivity', {'1' '0' '0' '0' '1' '0' '0' '0' '1'});
model.material('mat2').propertyGroup('def').set('dynamicviscosity', 'eta(T)');
model.material('mat2').propertyGroup('def').set('ratioofspecificheat', '1.4');
model.material('mat2').propertyGroup('def').set('electricconductivity', {'0[S/m]' '0' '0' '0' '0[S/m]' '0' '0' '0' '0[S/m]'});
model.material('mat2').propertyGroup('def').set('heatcapacity', 'Cp(T)');
model.material('mat2').propertyGroup('def').set('density', 'rho(pA,T)');
model.material('mat2').propertyGroup('def').set('thermalconductivity', {'k(T)' '0' '0' '0' 'k(T)' '0' '0' '0' 'k(T)'});
model.material('mat2').propertyGroup('def').set('soundspeed', 'cs(T)');
model.material('mat2').propertyGroup('def').addInput('temperature');
model.material('mat2').propertyGroup('def').addInput('pressure');
model.material('mat2').propertyGroup('RefractiveIndex').set('n', {'1' '0' '0' '0' '1' '0' '0' '0' '1'});
model.material('mat2').propertyGroup('NonlinearModel').set('BA', 'def.gamma-1');
model.material('mat2').propertyGroup('idealGas').func('Cp').label('Piecewise 2');
model.material('mat2').propertyGroup('idealGas').func('Cp').set('arg', 'T');
model.material('mat2').propertyGroup('idealGas').func('Cp').set('pieces', {'200.0' '1600.0' '1047.63657-0.372589265*T^1+9.45304214E-4*T^2-6.02409443E-7*T^3+1.2858961E-10*T^4'});
model.material('mat2').propertyGroup('idealGas').func('Cp').set('argunit', 'K');
model.material('mat2').propertyGroup('idealGas').func('Cp').set('fununit', 'J/(kg*K)');
model.material('mat2').propertyGroup('idealGas').set('Rs', 'R_const/Mn');
model.material('mat2').propertyGroup('idealGas').set('heatcapacity', 'Cp(T)');
model.material('mat2').propertyGroup('idealGas').set('ratioofspecificheat', '1.4');
model.material('mat2').propertyGroup('idealGas').set('molarmass', '0.02897');
model.material('mat2').propertyGroup('idealGas').addInput('temperature');
model.material('mat2').propertyGroup('idealGas').addInput('pressure');
model.material('mat2').materialType('nonSolid');

model.physics('nipfl').feature('pipe1').set('shape', 'Round');
model.physics('nipfl').feature('pipe1').set('innerd', '70[cm]');
model.physics('nipfl').feature('pipe1').set('frictionmodel', 3);
model.physics('nipfl').feature('pipe1').set('roughness', 3);
model.physics('nipfl').feature('temp1').set('Tin', 'T_in');
model.physics('nipfl').create('hofl1', 'HeatOutflow', 0);
model.physics('nipfl').feature('hofl1').selection.set([2]);
model.physics('nipfl').create('inl1', 'Inlet', 0);
model.physics('nipfl').feature('inl1').selection.set([1]);
model.physics('nipfl').feature('inl1').set('spec', 1);
model.physics('nipfl').feature('inl1').set('qv0', 'oil_rate');
model.physics('nipfl').create('wht1', 'WallHeatTransfer', 1);
model.physics('nipfl').feature('wht1').selection.set([1]);
model.physics('nipfl').feature('wht1').set('Text', 'T_ext');
model.physics('nipfl').feature('wht1').create('intfilm1', 'InternalFilmResistance', 1);
model.physics('nipfl').feature('wht1').create('wall1', 'WallLayer', 1);
model.physics('nipfl').feature('wht1').feature('wall1').label('Steel pipe wall');
model.physics('nipfl').feature('wht1').feature('wall1').set('kChoice', 'UserDefined');
model.physics('nipfl').feature('wht1').feature('wall1').set('k', 'k_wall');
model.physics('nipfl').feature('wht1').feature('wall1').set('deltawChoice', 'UserDefined');
model.physics('nipfl').feature('wht1').feature('wall1').set('item.deltaw', 'd_wall');
model.physics('nipfl').feature('wht1').create('wall2', 'WallLayer', 1);
model.physics('nipfl').feature('wht1').feature('wall2').label('Insulation layer');
model.physics('nipfl').feature('wht1').feature('wall2').set('kChoice', 'UserDefined');
model.physics('nipfl').feature('wht1').feature('wall2').set('k', 'k_ins');
model.physics('nipfl').feature('wht1').feature('wall2').set('deltawChoice', 'UserDefined');
model.physics('nipfl').feature('wht1').feature('wall2').set('item.deltaw', 'd_ins');
model.physics('nipfl').feature('wht1').create('extfilm1', 'ExternalFilmResistance', 1);
model.physics('nipfl').feature('wht1').feature('extfilm1').set('externalMaterial', 'mat2');
model.physics('nipfl').feature('wht1').feature('extfilm1').set('u', 'v_air');

model.mesh('mesh1').autoMeshSize(2);
model.mesh('mesh1').run;

model.study('std1').feature('stat').set('useadvanceddisable', true);
model.study('std1').feature('stat').set('disabledphysics', {'nipfl/wht1/wall2'});
model.study('std1').setGenPlots(false);
model.study('std1').label('No insulation');

model.sol.create('sol1');
model.sol('sol1').study('std1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'stat');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').set('control', 'stat');
model.sol('sol1').create('s1', 'Stationary');
model.sol('sol1').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('s1').create('d1', 'Direct');
model.sol('sol1').feature('s1').feature('d1').set('linsolver', 'mumps');
model.sol('sol1').feature('s1').feature('d1').set('mumpsalloc', 1.5);
model.sol('sol1').feature('s1').feature('d1').set('ooc', 'auto');
model.sol('sol1').feature('s1').feature('d1').set('errorchk', 'auto');
model.sol('sol1').feature('s1').feature('d1').set('rhob', 1);
model.sol('sol1').feature('s1').feature('fc1').set('linsolver', 'd1');
model.sol('sol1').feature('s1').feature.remove('fcDef');
model.sol('sol1').attach('std1');
model.sol('sol1').runAll;

model.result.create('pg1', 'PlotGroup1D');
model.result('pg1').run;
model.result('pg1').create('lngr1', 'LineGraph');
model.result('pg1').feature('lngr1').set('markerpos', 'datapoints');
model.result('pg1').feature('lngr1').set('linewidth', 'preference');
model.result('pg1').feature('lngr1').selection.all;
model.result('pg1').feature('lngr1').set('expr', 'T');
model.result('pg1').feature('lngr1').set('descr', 'Temperature');
model.result('pg1').feature('lngr1').set('unit', 'degC');
model.result('pg1').feature('lngr1').set('legend', true);
model.result('pg1').feature('lngr1').set('legendmethod', 'manual');
model.result('pg1').feature('lngr1').setIndex('legends', 'No insulation', 0);
model.result('pg1').run;

model.study.create('std2');
model.study('std2').create('stat', 'Stationary');
model.study('std2').feature('stat').setSolveFor('/physics/nipfl', true);
model.study('std2').feature('stat').set('useadvanceddisable', true);
model.study('std2').feature('stat').set('disabledphysics', {'nipfl/wht1'});
model.study('std2').setGenPlots(false);
model.study('std2').label('Perfect insulation');

model.sol.create('sol2');
model.sol('sol2').study('std2');
model.sol('sol2').create('st1', 'StudyStep');
model.sol('sol2').feature('st1').set('study', 'std2');
model.sol('sol2').feature('st1').set('studystep', 'stat');
model.sol('sol2').create('v1', 'Variables');
model.sol('sol2').feature('v1').set('control', 'stat');
model.sol('sol2').create('s1', 'Stationary');
model.sol('sol2').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol2').feature('s1').create('d1', 'Direct');
model.sol('sol2').feature('s1').feature('d1').set('linsolver', 'mumps');
model.sol('sol2').feature('s1').feature('d1').set('mumpsalloc', 1.5);
model.sol('sol2').feature('s1').feature('d1').set('ooc', 'auto');
model.sol('sol2').feature('s1').feature('d1').set('errorchk', 'auto');
model.sol('sol2').feature('s1').feature('d1').set('rhob', 1);
model.sol('sol2').feature('s1').feature('fc1').set('linsolver', 'd1');
model.sol('sol2').feature('s1').feature.remove('fcDef');
model.sol('sol2').attach('std2');
model.sol('sol2').runAll;

model.result('pg1').run;
model.result('pg1').feature.duplicate('lngr2', 'lngr1');
model.result('pg1').run;
model.result('pg1').feature('lngr2').set('data', 'dset2');
model.result('pg1').feature('lngr2').setIndex('legends', 'Perfect insulation', 0);
model.result('pg1').run;
model.result('pg1').run;
model.result('pg1').set('titletype', 'none');
model.result('pg1').set('legendpos', 'lowerleft');
model.result('pg1').run;

model.cpl.create('intop1', 'Integration', 'geom1');
model.cpl('intop1').set('axisym', true);
model.cpl('intop1').selection.geom('geom1', 0);
model.cpl('intop1').selection.set([2]);

model.variable.create('var1');
model.variable('var1').model('comp1');
model.variable('var1').set('T_diff', 'intop1((T_in-T)^2)');

model.study.create('std3');
model.study('std3').create('stat', 'Stationary');
model.study('std3').feature('stat').setSolveFor('/physics/nipfl', true);
model.study('std3').create('opt', 'Optimization');
model.study('std3').feature('opt').setIndex('optobj', 'comp1.T_diff', 0);
model.study('std3').feature('opt').setIndex('descr', '', 0);
model.study('std3').feature('opt').setIndex('pname', 'rho_oil', 0);
model.study('std3').feature('opt').setIndex('initval', '870[kg/m^3]', 0);
model.study('std3').feature('opt').setIndex('scale', 1, 0);
model.study('std3').feature('opt').setIndex('lbound', '', 0);
model.study('std3').feature('opt').setIndex('ubound', '', 0);
model.study('std3').feature('opt').setIndex('pname', 'rho_oil', 0);
model.study('std3').feature('opt').setIndex('initval', '870[kg/m^3]', 0);
model.study('std3').feature('opt').setIndex('scale', 1, 0);
model.study('std3').feature('opt').setIndex('lbound', '', 0);
model.study('std3').feature('opt').setIndex('ubound', '', 0);
model.study('std3').feature('opt').setIndex('pname', 'd_ins', 0);
model.study('std3').feature('opt').setIndex('initval', '3[cm]', 0);
model.study('std3').setGenPlots(false);
model.study('std3').label('Insulation thickness optimization');

model.sol.create('sol3');
model.sol('sol3').study('std3');
model.sol('sol3').create('st1', 'StudyStep');
model.sol('sol3').feature('st1').set('study', 'std3');
model.sol('sol3').feature('st1').set('studystep', 'stat');
model.sol('sol3').create('v1', 'Variables');
model.sol('sol3').feature('v1').set('control', 'stat');
model.sol('sol3').create('s1', 'Stationary');
model.sol('sol3').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol3').feature('s1').create('d1', 'Direct');
model.sol('sol3').feature('s1').feature('d1').set('linsolver', 'mumps');
model.sol('sol3').feature('s1').feature('d1').set('mumpsalloc', 1.5);
model.sol('sol3').feature('s1').feature('d1').set('ooc', 'auto');
model.sol('sol3').feature('s1').feature('d1').set('errorchk', 'auto');
model.sol('sol3').feature('s1').feature('d1').set('rhob', 1);
model.sol('sol3').feature('s1').feature('fc1').set('linsolver', 'd1');
model.sol('sol3').feature('s1').feature.remove('fcDef');
model.sol('sol3').attach('std3');

model.batch.create('o1', 'Optimization');
model.batch('o1').study('std3');
model.batch('p1').study('std3');
model.batch('o1').attach('std3');
model.batch('p1').create('so1', 'Solutionseq');
model.batch('p1').feature('so1').set('seq', 'sol3');
model.batch('p1').feature('so1').set('store', 'on');
model.batch('p1').feature('so1').set('clear', 'on');
model.batch('p1').feature('so1').set('psol', 'none');
model.batch('p1').attach('std3');
model.batch('p1').set('optimization', 'o1');
model.batch('p1').set('err', 'on');
model.batch('p1').set('control', 'opt');
model.batch('o1').set('parametricjobs', {'p1'});

model.sol.create('sol4');
model.sol('sol4').study('std3');
model.sol('sol4').label('Parametric Solutions 1');

model.batch('p1').feature('so1').set('psol', 'sol4');
model.batch('o1').run('compute');

model.study('std3').feature('opt').set('probewindow', '');

model.result('pg1').run;
model.result('pg1').feature.duplicate('lngr3', 'lngr2');
model.result('pg1').run;
model.result('pg1').feature('lngr3').set('data', 'dset3');
model.result('pg1').feature('lngr3').setIndex('legends', 'Optimized insulation thickness', 0);
model.result('pg1').run;

model.title('Insulation of a Pipeline Section');

model.description('As crude oil flows through a pipeline, heat is dissipated due to viscous heating (internal friction). With a carefully optimized insulation of the pipeline, heat can be used to avoid the need of preheating of the oil, despite the fact that it needs to be transported in a cold environment over long distances. This example uses the Pipe Flow Module to simulate oil transportation in a pipeline. With the addition of an Optimization study, the ideal thickness of the pipeline insulation can be found such that the temperature is constant along the pipeline.');

model.label('pipeline_insulation.mph');

model.modelNode.label('Components');

out = model;
