function out = model
%
% falling_magnet.m
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

model.physics.create('mf', 'InductionCurrents', 'geom1');
model.physics('mf').model('comp1');
model.physics.create('ge', 'GlobalEquations', 'geom1');
model.physics('ge').model('comp1');
model.physics('ge').prop('EquationForm').set('form', 'Automatic');

model.study.create('std1');
model.study('std1').create('stat', 'Stationary');
model.study('std1').feature('stat').setSolveFor('/physics/mf', true);
model.study('std1').feature('stat').setSolveFor('/physics/ge', true);

model.param.set('mr', '5[mm]');
model.param.descr('mr', 'Magnet radius');
model.param.set('mh', '10[mm]');
model.param.descr('mh', 'Magnet height');
model.param.set('r_i', '6[mm]');
model.param.descr('r_i', 'Tube inner radius');
model.param.set('r_o', '8[mm]');
model.param.descr('r_o', 'Tube outer radius');
model.param.set('dm', '7.4[g/(cm)^3]');
model.param.descr('dm', 'Density of magnet');

model.geom('geom1').lengthUnit('mm');
model.geom('geom1').create('r1', 'Rectangle');
model.geom('geom1').feature('r1').set('size', {'mr' 'mh'});
model.geom('geom1').feature('r1').set('pos', {'0' '-mh/2'});
model.geom('geom1').run('r1');
model.geom('geom1').create('fil1', 'Fillet');
model.geom('geom1').feature('fil1').selection('pointinsketch').set('r1', [2 3]);
model.geom('geom1').feature('fil1').set('radius', 1);
model.geom('geom1').run('fil1');
model.geom('geom1').create('r2', 'Rectangle');
model.geom('geom1').feature('r2').set('size', {'r_o-r_i' '100'});
model.geom('geom1').feature('r2').set('pos', {'r_i' '-50'});
model.geom('geom1').run('r2');
model.geom('geom1').create('r3', 'Rectangle');
model.geom('geom1').feature('r3').set('size', {'r_o-r_i' '40'});
model.geom('geom1').feature('r3').set('pos', {'r_i' '-20'});
model.geom('geom1').run('r3');
model.geom('geom1').create('r4', 'Rectangle');
model.geom('geom1').feature('r4').set('size', [30 100]);
model.geom('geom1').feature('r4').set('pos', [0 -50]);
model.geom('geom1').feature('r4').set('layerright', true);
model.geom('geom1').feature('r4').set('layerbottom', false);
model.geom('geom1').feature('r4').setIndex('layer', 10, 0);
model.geom('geom1').run('r4');
model.geom('geom1').run('fin');

model.selection.create('sel1', 'Explicit');
model.selection('sel1').model('comp1');
model.selection('sel1').set([2]);
model.selection('sel1').label('Magnet');
model.selection.create('sel2', 'Explicit');
model.selection('sel2').model('comp1');
model.selection('sel2').set([3 4 5]);
model.selection('sel2').label('Copper Tube');

model.cpl.create('intop1', 'Integration', 'geom1');
model.cpl('intop1').set('axisym', true);
model.cpl('intop1').set('opname', 'intmag');
model.cpl('intop1').selection.named('sel1');
model.cpl('intop1').set('axisym', false);
model.cpl('intop1').label('Integration over Magnet');

model.variable.create('var1');
model.variable('var1').model('comp1');
model.variable('var1').set('m', 'intmag(2*pi*r*dm)');
model.variable('var1').descr('m', 'Mass of the magnet');
model.variable('var1').set('Fg', 'm*g_const');
model.variable('var1').descr('Fg', 'Gravitational force on the magnet');

model.cpl.create('intop2', 'Integration', 'geom1');
model.cpl('intop2').set('axisym', true);
model.cpl('intop2').set('opname', 'inttube');
model.cpl('intop2').selection.named('sel2');
model.cpl('intop2').set('axisym', false);
model.cpl('intop2').label('Integration over Tube');

model.variable.create('var2');
model.variable('var2').model('comp1');
model.variable('var2').set('Fz', 'inttube(-mf.FLtzz*2*pi*r)');
model.variable('var2').descr('Fz', 'Lorentz force in z direction');
model.variable('var2').set('a', '(Fg-Fz)/m');
model.variable('var2').descr('a', 'Magnet acceleration');

model.coordSystem.create('ie1', 'geom1', 'InfiniteElement');
model.coordSystem('ie1').selection.set([7]);
model.coordSystem('ie1').set('ScalingType', 'Cylindrical');

model.physics('ge').feature('ge1').setIndex('name', 'v', 0, 0);
model.physics('ge').feature('ge1').setIndex('equation', 'd(v,t)-(Fg-Fz)/m', 0, 0);
model.physics('ge').feature('ge1').setIndex('description', 'Magnet velocity', 0, 0);
model.physics('ge').feature('ge1').set('DependentVariableQuantity', 'velocity');
model.physics('ge').feature('ge1').set('SourceTermQuantity', 'acceleration');
model.physics('mf').create('als1', 'AmperesLawSolid', 2);
model.physics('mf').feature('als1').label(['Amp' native2unicode(hex2dec({'00' 'e8'}), 'unicode') 're''s Law - Magnet']);
model.physics('mf').feature('als1').selection.named('sel1');
model.physics('mf').feature('als1').set('ConstitutiveRelationBH', 'RemanentFluxDensity');
model.physics('mf').feature('als1').set('e_crel_BH_RemanentFluxDensity', [0 0 1]);
model.physics('mf').create('als2', 'AmperesLawSolid', 2);
model.physics('mf').feature('als2').label(['Amp' native2unicode(hex2dec({'00' 'e8'}), 'unicode') 're''s Law - Copper Tube']);
model.physics('mf').feature('als2').selection.named('sel2');
model.physics('mf').create('vlt1', 'Velocity', 2);
model.physics('mf').feature('vlt1').selection.named('sel2');
model.physics('mf').feature('vlt1').set('v', {'0' '0' 'v'});
model.physics('mf').create('pmc1', 'PerfectMagneticConductor', 1);
model.physics('mf').feature('pmc1').selection.set([2 7 10 15 17 20 22 23 24]);

model.material.create('mat1', 'Common', 'comp1');
model.material('mat1').propertyGroup.create('Enu', 'Young''s modulus and Poisson''s ratio');
model.material('mat1').propertyGroup.create('linzRes', 'Linearized resistivity');
model.material('mat1').label('Copper');
model.material('mat1').set('family', 'copper');
model.material('mat1').propertyGroup('def').set('relpermeability', {'1' '0' '0' '0' '1' '0' '0' '0' '1'});
model.material('mat1').propertyGroup('def').set('electricconductivity', {'5.998e7[S/m]' '0' '0' '0' '5.998e7[S/m]' '0' '0' '0' '5.998e7[S/m]'});
model.material('mat1').propertyGroup('def').set('heatcapacity', '385[J/(kg*K)]');
model.material('mat1').propertyGroup('def').set('relpermittivity', {'1' '0' '0' '0' '1' '0' '0' '0' '1'});
model.material('mat1').propertyGroup('def').set('emissivity', '0.5');
model.material('mat1').propertyGroup('def').set('density', '8940[kg/m^3]');
model.material('mat1').propertyGroup('def').set('thermalconductivity', {'400[W/(m*K)]' '0' '0' '0' '400[W/(m*K)]' '0' '0' '0' '400[W/(m*K)]'});
model.material('mat1').propertyGroup('Enu').set('E', '126e9[Pa]');
model.material('mat1').propertyGroup('Enu').set('nu', '0.34');
model.material('mat1').propertyGroup('linzRes').set('rho0', '1.667e-8[ohm*m]');
model.material('mat1').propertyGroup('linzRes').set('alpha', '3.862e-3[1/K]');
model.material('mat1').propertyGroup('linzRes').set('Tref', '293.15[K]');
model.material('mat1').propertyGroup('linzRes').addInput('temperature');
model.material.create('mat2', 'Common', 'comp1');
model.material('mat2').propertyGroup.create('RemanentFluxDensity', 'Remanent flux density');
model.material('mat2').label('N50 (Sintered NdFeB)');
model.material('mat2').set('family', 'chrome');
model.material('mat2').propertyGroup('def').set('electricconductivity', {'1/1.4[uohm*m]' '0' '0' '0' '1/1.4[uohm*m]' '0' '0' '0' '1/1.4[uohm*m]'});
model.material('mat2').propertyGroup('def').set('relpermittivity', {'1' '0' '0' '0' '1' '0' '0' '0' '1'});
model.material('mat2').propertyGroup('RemanentFluxDensity').set('murec', {'1.05' '0' '0' '0' '1.05' '0' '0' '0' '1.05'});
model.material('mat2').propertyGroup('RemanentFluxDensity').set('normBr', '1.41[T]');
model.material('mat1').selection.named('sel2');
model.material('mat2').selection.named('sel1');

model.mesh('mesh1').run;

model.study('std1').setGenPlots(false);
model.study('std1').feature('stat').setEntry('activate', 'ge', false);
model.study('std1').create('time', 'Transient');
model.study('std1').feature('time').set('tlist', 'range(0,0.001,0.05)');
model.study('std1').feature('time').set('usertol', true);
model.study('std1').feature('time').set('rtol', 0.001);

model.sol.create('sol1');
model.sol('sol1').study('std1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'stat');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').set('control', 'stat');
model.sol('sol1').create('s1', 'Stationary');
model.sol('sol1').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('s1').feature('fc1').set('linsolver', 'dDef');
model.sol('sol1').feature('s1').feature.remove('fcDef');
model.sol('sol1').create('su1', 'StoreSolution');
model.sol('sol1').create('st2', 'StudyStep');
model.sol('sol1').feature('st2').set('study', 'std1');
model.sol('sol1').feature('st2').set('studystep', 'time');
model.sol('sol1').create('v2', 'Variables');
model.sol('sol1').feature('v2').set('initmethod', 'sol');
model.sol('sol1').feature('v2').set('initsol', 'sol1');
model.sol('sol1').feature('v2').set('initsoluse', 'sol2');
model.sol('sol1').feature('v2').set('notsolmethod', 'sol');
model.sol('sol1').feature('v2').set('notsol', 'sol1');
model.sol('sol1').feature('v2').set('notsoluse', 'sol2');
model.sol('sol1').feature('v2').set('control', 'time');
model.sol('sol1').create('t1', 'Time');
model.sol('sol1').feature('t1').set('tlist', 'range(0,0.001,0.05)');
model.sol('sol1').feature('t1').set('plot', 'off');
model.sol('sol1').feature('t1').set('plotgroup', 'Default');
model.sol('sol1').feature('t1').set('plotfreq', 'tout');
model.sol('sol1').feature('t1').set('probesel', 'all');
model.sol('sol1').feature('t1').set('probes', {});
model.sol('sol1').feature('t1').set('probefreq', 'tsteps');
model.sol('sol1').feature('t1').set('tout', 'tstepsclosest');
model.sol('sol1').feature('t1').set('atolglobalvaluemethod', 'factor');
model.sol('sol1').feature('t1').set('reacf', true);
model.sol('sol1').feature('t1').set('storeudot', true);
model.sol('sol1').feature('t1').set('tstepsbdf', 'strict');
model.sol('sol1').feature('t1').set('endtimeinterpolation', true);
model.sol('sol1').feature('t1').set('estrat', 'exclude');
model.sol('sol1').feature('t1').set('control', 'time');
model.sol('sol1').feature('t1').feature('aDef').set('cachepattern', true);
model.sol('sol1').feature('t1').create('seDef', 'Segregated');
model.sol('sol1').feature('t1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('t1').feature('fc1').set('linsolver', 'dDef');
model.sol('sol1').feature('t1').feature.remove('fcDef');
model.sol('sol1').feature('t1').feature.remove('seDef');
model.sol('sol1').attach('std1');
model.sol('sol1').runAll;

model.result.create('pg1', 'PlotGroup2D');
model.result('pg1').run;
model.result('pg1').create('surf1', 'Surface');
model.result('pg1').run;
model.result.create('pg2', 'PlotGroup2D');
model.result('pg2').run;
model.result('pg2').create('surf1', 'Surface');
model.result('pg2').feature('surf1').set('expr', 'mf.normJ');
model.result('pg2').feature('surf1').set('descr', 'Current density norm');
model.result('pg2').run;
model.result.create('pg3', 'PlotGroup1D');
model.result('pg3').run;
model.result('pg3').create('glob1', 'Global');
model.result('pg3').feature('glob1').set('markerpos', 'datapoints');
model.result('pg3').feature('glob1').set('linewidth', 'preference');
model.result('pg3').feature('glob1').set('expr', {'Fz'});
model.result('pg3').feature('glob1').set('descr', {'Lorentz force in z direction'});
model.result('pg3').feature('glob1').set('unit', {'N'});
model.result('pg3').run;
model.result('pg3').feature('glob1').label('Lorentz Force, Fz');
model.result('pg3').run;
model.result.create('pg4', 'PlotGroup1D');
model.result('pg4').run;
model.result('pg4').create('glob1', 'Global');
model.result('pg4').feature('glob1').set('markerpos', 'datapoints');
model.result('pg4').feature('glob1').set('linewidth', 'preference');
model.result('pg4').feature('glob1').label('Terminal Velocity');
model.result('pg4').feature('glob1').setIndex('unit', 'cm/s', 0);
model.result('pg4').run;
model.result.create('pg5', 'PlotGroup1D');
model.result('pg5').run;
model.result('pg5').create('glob1', 'Global');
model.result('pg5').feature('glob1').set('markerpos', 'datapoints');
model.result('pg5').feature('glob1').set('linewidth', 'preference');
model.result('pg5').feature('glob1').set('expr', {'a'});
model.result('pg5').feature('glob1').set('descr', {'Magnet acceleration'});
model.result('pg5').feature('glob1').set('unit', {'m/s^2'});
model.result('pg5').feature('glob1').label('Magnet acceleration');
model.result('pg5').run;

model.title('Magnet Falling Through Copper Tube');

model.description('A cylindrical magnet falling through a copper tube induces eddy currents on the tube walls. The eddy currents, in turn, create a magnetic field that opposes the magnetic field of the magnet and induces a braking force that opposes the motion of the magnet. This opposing force increases with increasing velocity. Thus, there is a terminal velocity at which the magnetic braking force equals the force of gravity. The example computes the velocity of the magnet after it is dropped as it reaches its terminal velocity.');

model.mesh.clearMeshes;

model.sol('sol1').clearSolutionData;
model.sol('sol2').clearSolutionData;

model.label('falling_magnet.mph');

model.modelNode.label('Components');

out = model;
