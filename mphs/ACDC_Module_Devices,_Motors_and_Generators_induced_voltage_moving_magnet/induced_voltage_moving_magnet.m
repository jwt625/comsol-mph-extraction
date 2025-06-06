function out = model
%
% induced_voltage_moving_magnet.m
%
% Model exported on May 26 2025, 21:24 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/ACDC_Module/Devices,_Motors_and_Generators');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 2);
model.geom('geom1').model('comp1');
model.geom('geom1').axisymmetric(true);

model.mesh.create('mesh1', 'geom1');

model.physics.create('mf', 'InductionCurrents', 'geom1');
model.physics('mf').model('comp1');

model.study.create('std1');
model.study('std1').create('stat', 'Stationary');
model.study('std1').feature('stat').setSolveFor('/physics/mf', true);

model.param.set('f0', '4[Hz]');
model.param.descr('f0', 'Frequency of an oscillating magnet');
model.param.set('T0', '1/f0');
model.param.descr('T0', 'Time period of an oscillating magnet');
model.param.set('t', '0[s]');
model.param.descr('t', 'Time');

model.geom('geom1').lengthUnit('cm');
model.geom('geom1').create('r1', 'Rectangle');
model.geom('geom1').feature('r1').set('size', [1 2]);
model.geom('geom1').feature('r1').set('pos', [0 -1]);
model.geom('geom1').run('r1');
model.geom('geom1').create('r2', 'Rectangle');
model.geom('geom1').feature('r2').set('size', [1 8]);
model.geom('geom1').feature('r2').set('pos', [1.1 -4]);
model.geom('geom1').run('r2');
model.geom('geom1').create('r3', 'Rectangle');
model.geom('geom1').feature('r3').set('size', [1 12]);
model.geom('geom1').feature('r3').set('pos', [0 -6]);
model.geom('geom1').run('r3');
model.geom('geom1').create('r4', 'Rectangle');
model.geom('geom1').feature('r4').set('size', [3 12]);
model.geom('geom1').feature('r4').set('pos', [1 -6]);
model.geom('geom1').run('r4');
model.geom('geom1').create('r5', 'Rectangle');
model.geom('geom1').feature('r5').set('pos', [0 6]);
model.geom('geom1').run('r5');
model.geom('geom1').create('r6', 'Rectangle');
model.geom('geom1').feature('r6').set('size', [4 1]);
model.geom('geom1').feature('r6').set('pos', [1 6]);
model.geom('geom1').run('r6');
model.geom('geom1').create('mir1', 'Mirror');
model.geom('geom1').feature('mir1').selection('input').set({'r5' 'r6'});
model.geom('geom1').feature('mir1').set('axis', [0 1]);
model.geom('geom1').feature('mir1').set('keep', true);
model.geom('geom1').run('mir1');
model.geom('geom1').create('r7', 'Rectangle');
model.geom('geom1').feature('r7').set('size', [1 14]);
model.geom('geom1').feature('r7').set('pos', [4 -7]);
model.geom('geom1').run('r7');
model.geom('geom1').create('uni1', 'Union');
model.geom('geom1').feature('uni1').selection('input').set({'r1' 'r3'});
model.geom('geom1').run('uni1');
model.geom('geom1').create('uni2', 'Union');
model.geom('geom1').feature('uni2').selection('input').set({'mir1' 'r2' 'r4' 'r5' 'r6' 'r7'});
model.geom('geom1').run('uni2');
model.geom('geom1').feature('fin').set('action', 'assembly');
model.geom('geom1').run('fin');

model.selection.create('sel1', 'Explicit');
model.selection('sel1').model('comp1');
model.selection('sel1').geom(1);
model.selection('sel1').set([30 31 33 36]);
model.selection('sel1').label('Magnet Boundaries');
model.selection.create('sel2', 'Explicit');
model.selection('sel2').model('comp1');
model.selection('sel2').geom(1);
model.selection('sel2').set([35 36 37]);
model.selection('sel2').label('Continuity Boundaries');

model.material.create('mat1', 'Common', 'comp1');
model.material('mat1').propertyGroup.create('Enu', 'Young''s modulus and Poisson''s ratio');
model.material('mat1').propertyGroup.create('linzRes', 'Linearized resistivity');
model.material('mat1').label('Copper');
model.material('mat1').set('family', 'copper');
model.material('mat1').propertyGroup('def').set('relpermeability', {'1' '0' '0' '0' '1' '0' '0' '0' '1'});
model.material('mat1').propertyGroup('def').set('electricconductivity', {'5.998e7[S/m]' '0' '0' '0' '5.998e7[S/m]' '0' '0' '0' '5.998e7[S/m]'});
model.material('mat1').propertyGroup('def').set('thermalexpansioncoefficient', {'17e-6[1/K]' '0' '0' '0' '17e-6[1/K]' '0' '0' '0' '17e-6[1/K]'});
model.material('mat1').propertyGroup('def').set('heatcapacity', '385[J/(kg*K)]');
model.material('mat1').propertyGroup('def').set('relpermittivity', {'1' '0' '0' '0' '1' '0' '0' '0' '1'});
model.material('mat1').propertyGroup('def').set('density', '8960[kg/m^3]');
model.material('mat1').propertyGroup('def').set('thermalconductivity', {'400[W/(m*K)]' '0' '0' '0' '400[W/(m*K)]' '0' '0' '0' '400[W/(m*K)]'});
model.material('mat1').propertyGroup('Enu').set('E', '110[GPa]');
model.material('mat1').propertyGroup('Enu').set('nu', '0.35');
model.material('mat1').propertyGroup('linzRes').set('rho0', '1.72e-8[ohm*m]');
model.material('mat1').propertyGroup('linzRes').set('alpha', '0.0039[1/K]');
model.material('mat1').propertyGroup('linzRes').set('Tref', '298[K]');
model.material('mat1').propertyGroup('linzRes').addInput('temperature');
model.material.create('mat2', 'Common', 'comp1');
model.material('mat2').propertyGroup.create('RemanentFluxDensity', 'Remanent flux density');
model.material('mat2').propertyGroup('RemanentFluxDensity').func.create('int1', 'Interpolation');
model.material('mat2').label('BMN-35');
model.material('mat2').set('family', 'chrome');
model.material('mat2').propertyGroup('def').set('thermalconductivity', {'9.0[W/(m*K)]' '0' '0' '0' '9.0[W/(m*K)]' '0' '0' '0' '9.0[W/(m*K)]'});
model.material('mat2').propertyGroup('def').set('density', '7.55[g/cm^3]');
model.material('mat2').propertyGroup('def').set('heatcapacity', '440[J/(kg*K)]');
model.material('mat2').propertyGroup('def').set('electricconductivity', {'1/1.50[uohm*m]' '0' '0' '0' '1/1.50[uohm*m]' '0' '0' '0' '1/1.50[uohm*m]'});
model.material('mat2').propertyGroup('def').set('relpermittivity', {'1' '0' '0' '0' '1' '0' '0' '0' '1'});
model.material('mat2').propertyGroup('RemanentFluxDensity').func('int1').set('funcname', 'Br');
model.material('mat2').propertyGroup('RemanentFluxDensity').func('int1').set('table', {'293.15' '1.220'; '353.15' '1.13'});
model.material('mat2').propertyGroup('RemanentFluxDensity').func('int1').set('extrap', 'linear');
model.material('mat2').propertyGroup('RemanentFluxDensity').func('int1').set('fununit', {'T'});
model.material('mat2').propertyGroup('RemanentFluxDensity').func('int1').set('argunit', {'K'});
model.material('mat2').propertyGroup('RemanentFluxDensity').set('murec', {'1.05' '0' '0' '0' '1.05' '0' '0' '0' '1.05'});
model.material('mat2').propertyGroup('RemanentFluxDensity').set('normBr', 'Br(T)');
model.material('mat2').propertyGroup('RemanentFluxDensity').addInput('temperature');
model.material('mat1').selection.set([6]);
model.material('mat2').selection.set([11]);

model.physics('mf').create('mag1', 'Magnet', 2);
model.physics('mf').feature('mag1').selection.set([11]);
model.physics('mf').feature('mag1').feature('north1').selection.set([33]);
model.physics('mf').feature('mag1').feature('south1').selection.set([31]);
model.physics('mf').create('coil1', 'Coil', 2);
model.physics('mf').feature('coil1').selection.set([6]);
model.physics('mf').feature('coil1').setIndex('materialType', 'solid', 0);
model.physics('mf').feature('coil1').set('ConductorModel', 'Multi');
model.physics('mf').feature('coil1').set('N', 800);
model.physics('mf').feature('coil1').set('coilWindArea', 'pi*(0.5[mm])^2');
model.physics('mf').feature('coil1').set('ICoil', 0);
model.physics('mf').create('cont1', 'Continuity', 1);
model.physics('mf').feature('mi1').set('constraintOptions', 'weakConstraints');
model.physics('mf').feature('cont1').set('pairs', {'ap1'});
model.physics('mf').feature('cont1').set('constraintOptions', 'weakConstraints');

model.common.create('pres1', 'PrescribedDeformation', 'comp1');
model.common('pres1').selection.all;
model.common('pres1').selection.set([11]);
model.common('pres1').set('prescribedDeformation', {'0' '0' '30[mm]*sin(2*pi*f0*t)'});
model.common.create('pres2', 'PrescribedDeformation', 'comp1');
model.common('pres2').selection.set([12]);
model.common('pres2').set('prescribedDeformation', {'0' '0' '30[mm]*sin(2*pi*f0*t)*(6[cm]-Z)/5[cm]'});
model.common.create('pres3', 'PrescribedDeformation', 'comp1');
model.common('pres3').selection.set([10]);
model.common('pres3').set('prescribedDeformation', {'0' '0' '30[mm]*sin(2*pi*f0*t)*(6[cm]+Z)/5[cm]'});

model.coordSystem.create('ie1', 'geom1', 'InfiniteElement');
model.coordSystem('ie1').set('ScalingType', 'Cylindrical');
model.coordSystem('ie1').selection.set([1 2 3 5 7 8 9]);

model.mesh('mesh1').autoMeshSize(4);
model.mesh('mesh1').create('size1', 'Size');
model.mesh('mesh1').feature('size1').selection.geom('geom1', 1);
model.mesh('mesh1').feature('size1').selection.set([28 29 31 32 33 34 35 36 37]);
model.mesh('mesh1').feature('size1').set('custom', true);
model.mesh('mesh1').feature('size1').set('hmaxactive', true);
model.mesh('mesh1').feature('size1').set('hmax', '4[mm]');
model.mesh('mesh1').create('size2', 'Size');
model.mesh('mesh1').feature('size2').selection.geom('geom1', 1);
model.mesh('mesh1').feature('size2').selection.set([9]);
model.mesh('mesh1').feature('size2').set('custom', true);
model.mesh('mesh1').feature('size2').set('hmaxactive', true);
model.mesh('mesh1').feature('size2').set('hmax', '1[mm]');
model.mesh('mesh1').create('edg1', 'Edge');
model.mesh('mesh1').feature('edg1').selection.set([28 31 32 33 34 35 37]);
model.mesh('mesh1').create('map1', 'Map');
model.mesh('mesh1').feature('map1').selection.geom('geom1', 2);
model.mesh('mesh1').feature('map1').selection.set([10 12]);
model.mesh('mesh1').create('ftri1', 'FreeTri');
model.mesh('mesh1').feature('ftri1').selection.geom('geom1', 2);
model.mesh('mesh1').feature('ftri1').selection.set([4 6 11]);
model.mesh('mesh1').create('cpe1', 'CopyEdge');
model.mesh('mesh1').feature('cpe1').selection('source').set([12 34]);
model.mesh('mesh1').feature('cpe1').selection('destination').set([6 13]);
model.mesh('mesh1').create('cpe2', 'CopyEdge');
model.mesh('mesh1').feature('cpe2').selection('source').geom(1);
model.mesh('mesh1').feature('cpe2').selection('destination').geom(1);
model.mesh('mesh1').feature('cpe2').selection('source').set([10 29]);
model.mesh('mesh1').feature('cpe2').selection('destination').set([2 8]);
model.mesh('mesh1').create('edg2', 'Edge');
model.mesh('mesh1').feature('edg2').selection.set([1 4 18 19 21 22 23 24 25 27]);
model.mesh('mesh1').feature('edg2').create('dis1', 'Distribution');
model.mesh('mesh1').create('cpe3', 'CopyEdge');
model.mesh('mesh1').feature('cpe3').selection('source').geom(1);
model.mesh('mesh1').feature('cpe3').selection('destination').geom(1);
model.mesh('mesh1').feature('cpe3').selection('source').set([1 4]);
model.mesh('mesh1').feature('cpe3').selection('destination').set([7 11]);
model.mesh('mesh1').create('map2', 'Map');
model.mesh('mesh1').run;

model.study('std1').create('time', 'Transient');
model.study('std1').feature('time').set('tlist', 'range(0,T0/100,T0)');

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
model.sol('sol1').feature('t1').set('tlist', 'range(0,T0/100,T0)');
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
model.sol('sol1').feature('t1').set('maxorder', 2);
model.sol('sol1').feature('t1').set('control', 'time');
model.sol('sol1').feature('t1').feature('aDef').set('cachepattern', true);
model.sol('sol1').feature('t1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('t1').feature('fc1').set('linsolver', 'dDef');
model.sol('sol1').feature('t1').feature.remove('fcDef');
model.sol('sol1').attach('std1');
model.sol('sol1').feature('s1').set('stol', '1e-4');
model.sol('sol1').feature('t1').feature('fc1').set('jtech', 'onevery');
model.sol('sol1').runAll;

model.result.create('pg1', 'PlotGroup2D');
model.result('pg1').label('Magnetic Flux Density Norm (mf)');
model.result('pg1').set('dataisaxisym', 'off');
model.result('pg1').set('frametype', 'spatial');
model.result('pg1').set('showlegendsmaxmin', true);
model.result('pg1').set('data', 'dset1');
model.result('pg1').setIndex('looplevel', 101, 0);
model.result('pg1').set('defaultPlotID', 'InterfaceComponents/PlotDefaults/icom6/pdef1/pcond2/pcond2/pg1');
model.result('pg1').feature.create('surf1', 'Surface');
model.result('pg1').feature('surf1').set('showsolutionparams', 'on');
model.result('pg1').feature('surf1').set('solutionparams', 'parent');
model.result('pg1').feature('surf1').set('colortable', 'Prism');
model.result('pg1').feature('surf1').set('colortabletrans', 'nonlinear');
model.result('pg1').feature('surf1').set('colorcalibration', -0.8);
model.result('pg1').feature('surf1').set('showsolutionparams', 'on');
model.result('pg1').feature('surf1').set('data', 'parent');
model.result('pg1').feature.create('str1', 'Streamline');
model.result('pg1').feature('str1').set('showsolutionparams', 'on');
model.result('pg1').feature('str1').set('solutionparams', 'parent');
model.result('pg1').feature('str1').set('titletype', 'none');
model.result('pg1').feature('str1').set('posmethod', 'uniform');
model.result('pg1').feature('str1').set('udist', 0.03);
model.result('pg1').feature('str1').set('maxlen', 0.4);
model.result('pg1').feature('str1').set('maxtime', Inf);
model.result('pg1').feature('str1').set('inheritcolor', false);
model.result('pg1').feature('str1').set('showsolutionparams', 'on');
model.result('pg1').feature('str1').set('maxtime', Inf);
model.result('pg1').feature('str1').set('showsolutionparams', 'on');
model.result('pg1').feature('str1').set('maxtime', Inf);
model.result('pg1').feature('str1').set('showsolutionparams', 'on');
model.result('pg1').feature('str1').set('maxtime', Inf);
model.result('pg1').feature('str1').set('showsolutionparams', 'on');
model.result('pg1').feature('str1').set('maxtime', Inf);
model.result('pg1').feature('str1').set('data', 'parent');
model.result('pg1').feature('str1').selection.geom('geom1', 1);
model.result('pg1').feature('str1').selection.set([1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37]);
model.result('pg1').feature('str1').set('inheritplot', 'surf1');
model.result('pg1').feature('str1').feature.create('col1', 'Color');
model.result('pg1').feature('str1').feature('col1').set('colortable', 'PrismDark');
model.result('pg1').feature('str1').feature('col1').set('colorlegend', false);
model.result('pg1').feature('str1').feature('col1').set('colortabletrans', 'nonlinear');
model.result('pg1').feature('str1').feature('col1').set('colorcalibration', -0.8);
model.result('pg1').feature('str1').feature.create('filt1', 'Filter');
model.result('pg1').feature('str1').feature('filt1').set('expr', '!isScalingSystemDomain');
model.result('pg1').feature.create('con1', 'Contour');
model.result('pg1').feature('con1').set('showsolutionparams', 'on');
model.result('pg1').feature('con1').set('solutionparams', 'parent');
model.result('pg1').feature('con1').set('expr', 'r*mf.Aphi');
model.result('pg1').feature('con1').set('titletype', 'none');
model.result('pg1').feature('con1').set('number', 10);
model.result('pg1').feature('con1').set('levelrounding', false);
model.result('pg1').feature('con1').set('coloring', 'uniform');
model.result('pg1').feature('con1').set('colorlegend', false);
model.result('pg1').feature('con1').set('color', 'custom');
model.result('pg1').feature('con1').set('customcolor', [0.3764705955982208 0.3764705955982208 0.3764705955982208]);
model.result('pg1').feature('con1').set('resolution', 'fine');
model.result('pg1').feature('con1').set('inheritcolor', false);
model.result('pg1').feature('con1').set('showsolutionparams', 'on');
model.result('pg1').feature('con1').set('data', 'parent');
model.result('pg1').feature('con1').set('inheritplot', 'surf1');
model.result('pg1').feature('con1').feature.create('filt1', 'Filter');
model.result('pg1').feature('con1').feature('filt1').set('expr', '!isScalingSystemDomain');
model.result.dataset.create('rev1', 'Revolve2D');
model.result.dataset('rev1').set('data', 'none');
model.result.dataset('rev1').set('startangle', -90);
model.result.dataset('rev1').set('revangle', 225);
model.result.dataset('rev1').set('data', 'dset1');
model.result.create('pg2', 'PlotGroup3D');
model.result('pg2').label('Magnetic Flux Density Norm, Revolved Geometry (mf)');
model.result('pg2').set('frametype', 'spatial');
model.result('pg2').set('showlegendsmaxmin', true);
model.result('pg2').set('data', 'rev1');
model.result('pg2').setIndex('looplevel', 101, 0);
model.result('pg2').set('defaultPlotID', 'InterfaceComponents/PlotDefaults/icom6/pdef1/pcond2/pcond3/pg1');
model.result('pg2').feature.create('vol1', 'Volume');
model.result('pg2').feature('vol1').set('showsolutionparams', 'on');
model.result('pg2').feature('vol1').set('solutionparams', 'parent');
model.result('pg2').feature('vol1').set('colortable', 'Prism');
model.result('pg2').feature('vol1').set('colortabletrans', 'nonlinear');
model.result('pg2').feature('vol1').set('colorcalibration', -0.8);
model.result('pg2').feature('vol1').set('showsolutionparams', 'on');
model.result('pg2').feature('vol1').set('data', 'parent');
model.result('pg2').feature.create('con1', 'Contour');
model.result('pg2').feature('con1').set('showsolutionparams', 'on');
model.result('pg2').feature('con1').set('solutionparams', 'parent');
model.result('pg2').feature('con1').set('expr', 'r*mf.Aphi');
model.result('pg2').feature('con1').set('titletype', 'none');
model.result('pg2').feature('con1').set('number', 10);
model.result('pg2').feature('con1').set('levelrounding', false);
model.result('pg2').feature('con1').set('coloring', 'uniform');
model.result('pg2').feature('con1').set('colorlegend', false);
model.result('pg2').feature('con1').set('color', 'custom');
model.result('pg2').feature('con1').set('customcolor', [0.3764705955982208 0.3764705955982208 0.3764705955982208]);
model.result('pg2').feature('con1').set('resolution', 'fine');
model.result('pg2').feature('con1').set('inheritcolor', false);
model.result('pg2').feature('con1').set('showsolutionparams', 'on');
model.result('pg2').feature('con1').set('data', 'parent');
model.result('pg2').feature('con1').set('inheritplot', 'vol1');
model.result('pg2').feature('con1').feature.create('filt1', 'Filter');
model.result('pg2').feature('con1').feature('filt1').set('expr', '!isScalingSystemDomain');
model.result('pg2').feature('con1').feature('filt1').set('shownodespec', 'on');
model.result.create('pg3', 'PlotGroup2D');
model.result('pg3').set('data', 'dset1');
model.result('pg3').setIndex('looplevel', 101, 0);
model.result('pg3').label('Moving Mesh');
model.result('pg3').create('mesh1', 'Mesh');
model.result('pg3').feature('mesh1').set('meshdomain', 'surface');
model.result('pg3').feature('mesh1').set('colortable', 'TrafficFlow');
model.result('pg3').feature('mesh1').set('colortabletrans', 'nonlinear');
model.result('pg3').feature('mesh1').set('nonlinearcolortablerev', true);
model.result('pg3').feature('mesh1').create('sel1', 'MeshSelection');
model.result('pg3').feature('mesh1').feature('sel1').selection.set([10 11 12]);
model.result('pg3').feature('mesh1').set('qualmeasure', 'custom');
model.result('pg3').feature('mesh1').set('qualexpr', 'comp1.spatial.relVol');
model.result('pg3').feature('mesh1').set('colorrangeunitinterval', false);
model.result('pg1').run;
model.result('pg1').setIndex('looplevel', 81, 0);
model.result('pg1').run;
model.result('pg1').feature('str1').active(false);
model.result('pg1').feature('con1').active(false);
model.result('pg1').run;
model.result('pg1').create('mesh1', 'Mesh');
model.result('pg1').feature('mesh1').set('colortable', 'TrafficFlow');
model.result('pg1').feature('mesh1').set('colortabletrans', 'nonlinear');
model.result('pg1').feature('mesh1').set('nonlinearcolortablerev', true);
model.result('pg1').feature('mesh1').set('elemcolor', 'none');
model.result('pg1').run;
model.result.create('pg4', 'PlotGroup1D');
model.result('pg4').run;
model.result('pg4').create('glob1', 'Global');
model.result('pg4').feature('glob1').set('markerpos', 'datapoints');
model.result('pg4').feature('glob1').set('linewidth', 'preference');
model.result('pg4').feature('glob1').set('expr', {'mf.VCoil_1'});
model.result('pg4').feature('glob1').set('descr', {'Coil voltage'});
model.result('pg4').feature('glob1').set('unit', {'V'});
model.result('pg4').run;
model.result('pg4').run;
model.result('pg4').label('Coil Induced Voltage');

model.title('Voltage Induced in a Coil by a Moving Magnet');

model.description('A magnet moving axially through the center of a coil will induce a voltage across the coil terminals. A practical application of this phenomenon is in shaker flashlights, where the flashlight is vigorously shaken back and forth, thereby causing a magnet to move through a multiturn coil, which provides charge to the battery. This example models the motion of a magnet through a coil and computes the induced voltages. The displacement of the magnet is significant, so the example uses a moving and sliding mesh.');

model.mesh.clearMeshes;

model.sol('sol1').clearSolutionData;
model.sol('sol2').clearSolutionData;

model.label('induced_voltage_moving_magnet.mph');

model.modelNode.label('Components');

out = model;
