function out = model
%
% axial_magnetic_bearing.m
%
% Model exported on May 26 2025, 21:24 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/ACDC_Module/Devices,_Transducers_and_Actuators');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 2);
model.geom('geom1').model('comp1');
model.geom('geom1').axisymmetric(true);

model.mesh.create('mesh1', 'geom1');

model.physics.create('mfnc', 'MagnetostaticsNoCurrents', 'geom1');
model.physics('mfnc').model('comp1');

model.study.create('std1');
model.study('std1').create('stat', 'Stationary');
model.study('std1').feature('stat').setSolveFor('/physics/mfnc', true);

model.param.set('R1', '10[mm]');
model.param.descr('R1', 'Inner radius of inner magnet');
model.param.set('R2', '20[mm]');
model.param.descr('R2', 'Outer radius of inner magnet');
model.param.set('R3', '22[mm]');
model.param.descr('R3', 'Inner radius of outer magnet');
model.param.set('R4', '32[mm]');
model.param.descr('R4', 'Outer radius of outer magnet');
model.param.set('h0', '10[mm]');
model.param.descr('h0', 'Magnet height');
model.param.set('Br', '1[T]');
model.param.descr('Br', 'Remanent flux density of magnet');
model.param.set('dZ', '0[mm]');
model.param.descr('dZ', 'Axial displacement');

model.geom('geom1').lengthUnit('mm');
model.geom('geom1').create('r1', 'Rectangle');
model.geom('geom1').feature('r1').set('size', {'R2-R1' 'h0*3'});
model.geom('geom1').feature('r1').set('pos', {'R1' '-h0/2-h0+dZ'});
model.geom('geom1').run('r1');
model.geom('geom1').feature('r1').setIndex('layer', 'h0', 0);
model.geom('geom1').feature('r1').set('layertop', true);
model.geom('geom1').run('r1');
model.geom('geom1').feature.duplicate('r2', 'r1');
model.geom('geom1').feature('r2').set('size', {'R4-R3' 'h0*3'});
model.geom('geom1').feature('r2').setIndex('pos', 'R3', 0);
model.geom('geom1').feature('r2').set('pos', {'R3' '-h0/2-h0'});
model.geom('geom1').run('r2');
model.geom('geom1').create('r3', 'Rectangle');
model.geom('geom1').feature('r3').set('size', [70 160]);
model.geom('geom1').feature('r3').set('pos', [0 -80]);
model.geom('geom1').feature('r3').setIndex('layer', 5, 0);
model.geom('geom1').feature('r3').set('layerright', true);
model.geom('geom1').feature('r3').set('layertop', true);
model.geom('geom1').run('r3');
model.geom('geom1').create('fil1', 'Fillet');
model.geom('geom1').feature('fil1').selection('pointinsketch').set('r1', [1 4 5 8]);
model.geom('geom1').feature('fil1').selection('pointinsketch').set('r2', [1 4 5 8]);
model.geom('geom1').feature('fil1').set('radius', 2);
model.geom('geom1').runPre('fin');

model.coordSystem.create('ie1', 'geom1', 'InfiniteElement');

model.geom('geom1').run;

model.coordSystem('ie1').selection.set([1 3 10 11 12]);
model.coordSystem('ie1').set('ScalingType', 'Cylindrical');

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
model.material.create('mat2', 'Common', 'comp1');
model.material('mat2').propertyGroup.create('RemanentFluxDensity', 'Remanent flux density');
model.material('mat2').label('N50 (Sintered NdFeB)');
model.material('mat2').set('family', 'chrome');
model.material('mat2').propertyGroup('def').set('electricconductivity', {'1/1.4[uohm*m]' '0' '0' '0' '1/1.4[uohm*m]' '0' '0' '0' '1/1.4[uohm*m]'});
model.material('mat2').propertyGroup('def').set('relpermittivity', {'1' '0' '0' '0' '1' '0' '0' '0' '1'});
model.material('mat2').propertyGroup('RemanentFluxDensity').set('murec', {'1.05' '0' '0' '0' '1.05' '0' '0' '0' '1.05'});
model.material('mat2').propertyGroup('RemanentFluxDensity').set('normBr', '1.41[T]');
model.material('mat2').selection.set([4 5 6 7 8 9]);
model.material('mat2').propertyGroup('RemanentFluxDensity').set('murec', {'1'});
model.material('mat2').propertyGroup('RemanentFluxDensity').set('normBr', {'Br'});
model.material('mat2').label('Generic Magnet');

model.physics('mfnc').create('mfc2', 'MagneticFluxConservation', 2);
model.physics('mfnc').feature('mfc2').selection.set([6 9]);
model.physics('mfnc').feature('mfc2').set('ConstitutiveRelationBH', 'RemanentFluxDensity');
model.physics('mfnc').feature('mfc2').set('e_crel_BH_RemanentFluxDensity', [0 0 -1]);
model.physics('mfnc').create('mfc3', 'MagneticFluxConservation', 2);
model.physics('mfnc').feature('mfc3').selection.set([4 7]);
model.physics('mfnc').feature('mfc3').set('ConstitutiveRelationBH', 'RemanentFluxDensity');
model.physics('mfnc').feature('mfc3').set('e_crel_BH_RemanentFluxDensity', [0 0 1]);
model.physics('mfnc').create('mfc4', 'MagneticFluxConservation', 2);
model.physics('mfnc').feature('mfc4').selection.set([5]);
model.physics('mfnc').feature('mfc4').set('ConstitutiveRelationBH', 'RemanentFluxDensity');
model.physics('mfnc').create('mfc5', 'MagneticFluxConservation', 2);
model.physics('mfnc').feature('mfc5').selection.set([8]);
model.physics('mfnc').feature('mfc5').set('ConstitutiveRelationBH', 'RemanentFluxDensity');
model.physics('mfnc').feature('mfc5').set('e_crel_BH_RemanentFluxDensity', [-1 0 0]);
model.physics('mfnc').create('fcal1', 'ForceCalculation', 2);
model.physics('mfnc').feature('fcal1').selection.set([4 5 6]);
model.physics('mfnc').create('zsp1', 'ZeroMagneticScalarPotential', 0);
model.physics('mfnc').feature('zsp1').selection.set([30]);
model.physics.create('sens', 'Sensitivity', 'geom1');
model.physics('sens').model('comp1');

model.study('std1').feature('stat').setSolveFor('/physics/sens', true);

model.physics('sens').create('gcvar1', 'GlobalControlVariables', -1);
model.physics('sens').feature('gcvar1').setIndex('variableList', 'dZ', 0, 0);
model.physics('sens').create('gobj1', 'GlobalObjective', -1);
model.physics('sens').feature('gobj1').set('objectiveExpression', 'mfnc.Forcez_0');

model.common.create('free1', 'DeformingDomain', 'comp1');
model.common('free1').selection.all;
model.common('free1').selection.set([2]);
model.common('free1').set('smoothingType', 'laplace');
model.common.create('pres1', 'PrescribedDeformation', 'comp1');
model.common('pres1').selection.set([4 5 6]);
model.common('pres1').set('prescribedDeformation', {'0' '0' 'dZ'});
model.common.create('disp1', 'PrescribedMeshDisplacement', 'comp1');
model.common('disp1').selection.set([3 4 6 18 19 21 23 24 25 26 27 30 42 43 44 45]);

model.mesh('mesh1').run;

model.study('std1').create('param', 'Parametric');
model.study('std1').feature('param').setIndex('pname', 'R1', 0);
model.study('std1').feature('param').setIndex('plistarr', '', 0);
model.study('std1').feature('param').setIndex('punit', 'm', 0);
model.study('std1').feature('param').setIndex('pname', 'R1', 0);
model.study('std1').feature('param').setIndex('plistarr', '', 0);
model.study('std1').feature('param').setIndex('punit', 'm', 0);
model.study('std1').feature('param').setIndex('pname', 'dZ', 0);
model.study('std1').feature('param').setIndex('punit', 'mm', 0);
model.study('std1').feature('param').setIndex('plistarr', 'range(-40,2,40)', 0);
model.study('std1').setGenPlots(false);

model.sol.create('sol1');

model.mesh('mesh1').stat.selection.geom(2);
model.mesh('mesh1').stat.selection.set([2]);

model.sol('sol1').study('std1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'stat');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').feature('comp1_spatial_disp').set('scalemethod', 'manual');
model.sol('sol1').feature('v1').feature('comp1_spatial_disp').set('scaleval', '4.400159088033068E-4');
model.sol('sol1').feature('v1').set('control', 'stat');
model.sol('sol1').create('s1', 'Stationary');
model.sol('sol1').feature('s1').create('seDef', 'Segregated');
model.sol('sol1').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('s1').feature('fc1').set('linsolver', 'dDef');
model.sol('sol1').feature('s1').feature.remove('fcDef');
model.sol('sol1').feature('s1').feature.remove('seDef');
model.sol('sol1').attach('std1');

model.batch.create('p1', 'Parametric');
model.batch('p1').study('std1');
model.batch('p1').create('so1', 'Solutionseq');
model.batch('p1').feature('so1').set('seq', 'sol1');
model.batch('p1').feature('so1').set('store', 'on');
model.batch('p1').feature('so1').set('clear', 'on');
model.batch('p1').feature('so1').set('psol', 'none');
model.batch('p1').set('pname', {'dZ'});
model.batch('p1').set('plistarr', {'range(-40,2,40)'});
model.batch('p1').set('sweeptype', 'sparse');
model.batch('p1').set('probesel', 'all');
model.batch('p1').set('probes', {});
model.batch('p1').set('plot', 'off');
model.batch('p1').set('err', 'on');
model.batch('p1').attach('std1');
model.batch('p1').set('control', 'param');

model.sol('sol1').feature('s1').create('sn1', 'Sensitivity');
model.sol.create('sol2');
model.sol('sol2').study('std1');
model.sol('sol2').label('Parametric Solutions 1');

model.batch('p1').feature('so1').set('psol', 'sol2');
model.batch('p1').run('compute');

model.result.dataset.duplicate('dset3', 'dset2');
model.result.dataset('dset3').set('solution', 'sol27');
model.result.dataset('dset3').selection.geom('geom1', 2);
model.result.dataset('dset3').selection.geom('geom1', 2);
model.result.dataset('dset3').selection.set([4 5 6 7 8 9]);
model.result.dataset.create('rev1', 'Revolve2D');
model.result.dataset('rev1').set('data', 'dset3');
model.result.dataset('rev1').set('startangle', -100);
model.result.dataset('rev1').set('revangle', 280);
model.result.create('pg1', 'PlotGroup2D');
model.result('pg1').run;
model.result('pg1').create('surf1', 'Surface');
model.result('pg1').feature('surf1').set('expr', 'mfnc.normB');
model.result('pg1').feature('surf1').set('descr', 'Magnetic flux density norm');
model.result('pg1').run;
model.result('pg1').run;
model.result('pg1').create('str1', 'Streamline');
model.result('pg1').feature('str1').set('posmethod', 'uniform');
model.result('pg1').feature('str1').set('udist', 0.02);
model.result('pg1').feature('str1').set('color', 'gray');
model.result('pg1').run;
model.result.create('pg2', 'PlotGroup1D');
model.result('pg2').run;
model.result('pg2').create('glob1', 'Global');
model.result('pg2').feature('glob1').set('markerpos', 'datapoints');
model.result('pg2').feature('glob1').set('linewidth', 'preference');
model.result('pg2').feature('glob1').set('data', 'dset2');
model.result('pg2').feature('glob1').set('expr', {});
model.result('pg2').feature('glob1').set('descr', {});
model.result('pg2').feature('glob1').set('expr', {'sens.gobj1'});
model.result('pg2').feature('glob1').set('descr', {'Objective value'});
model.result('pg2').feature('glob1').set('unit', {'N'});
model.result('pg2').run;
model.result.create('pg3', 'PlotGroup1D');
model.result('pg3').run;
model.result('pg3').create('glob1', 'Global');
model.result('pg3').feature('glob1').set('markerpos', 'datapoints');
model.result('pg3').feature('glob1').set('linewidth', 'preference');
model.result('pg3').feature('glob1').set('data', 'dset2');
model.result('pg3').feature('glob1').set('expr', {});
model.result('pg3').feature('glob1').set('descr', {});
model.result('pg3').feature('glob1').setIndex('expr', 'fsens(dZ)', 0);
model.result('pg3').feature('glob1').setIndex('unit', 'N/m', 0);
model.result('pg3').feature('glob1').setIndex('descr', 'Sensitivity of Fz w.r.t. dZ', 0);
model.result('pg3').run;
model.result.create('pg4', 'PlotGroup3D');
model.result('pg4').run;
model.result('pg4').create('vol1', 'Volume');
model.result('pg4').feature('vol1').set('expr', 'mfnc.normB');
model.result('pg4').feature('vol1').set('descr', 'Magnetic flux density norm');
model.result('pg4').run;

model.title('Axial Magnetic Bearing Using Permanent Magnets');

model.description('Permanent magnet bearings are used in turbo machinery, pumps, motors, generators, and flywheel energy storage systems, to mention a few application areas; contactless operation, low maintenance, and the ability to operate without lubrication are some key benefits compared to conventional mechanical bearings. This example illustrates how to calculate design parameters like magnetic forces and stiffness for an axial permanent magnet bearing.');

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

model.label('axial_magnetic_bearing.mph');

model.modelNode.label('Components');

out = model;
