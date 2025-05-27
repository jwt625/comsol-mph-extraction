function out = model
%
% electrodynamic_levitation_device.m
%
% Model exported on May 26 2025, 21:25 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/ACDC_Module/Verifications');

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
model.study('std1').create('time', 'Transient');
model.study('std1').feature('time').setSolveFor('/physics/mf', true);
model.study('std1').feature('time').setSolveFor('/physics/ge', true);

% To import content from file, use:
% model.param.loadFile('FILENAME');
model.param.set('f0', '50[Hz]', 'Supply frequency');
model.param.set('Ni', '960', 'Number of turns in inner coil');
model.param.set('No', '576', 'Number of turns in outer coil');
model.param.set('sigma', '3.4e7[S/m]', 'Conductivity of aluminum');
model.param.set('I0', '20[A]', 'Coil current');
model.param.set('d_wire', '1.2[mm]', 'Coil wire diameter');
model.param.set('M_disc', '0.107[kg]', 'Mass of aluminum disc');
model.param.set('z0', '3.8[mm]', 'Initial position of aluminum disc');

model.geom('geom1').lengthUnit('mm');
model.geom('geom1').create('r1', 'Rectangle');
model.geom('geom1').feature('r1').label('Coil 1');
model.geom('geom1').feature('r1').set('size', [28 52]);
model.geom('geom1').feature('r1').set('base', 'center');
model.geom('geom1').feature('r1').set('pos', [41 -26]);
model.geom('geom1').run('r1');
model.geom('geom1').create('r2', 'Rectangle');
model.geom('geom1').feature('r2').label('Coil 2');
model.geom('geom1').feature('r2').set('size', [15 52]);
model.geom('geom1').feature('r2').set('base', 'center');
model.geom('geom1').feature('r2').set('pos', [87.5 -26]);
model.geom('geom1').run('r2');
model.geom('geom1').create('r3', 'Rectangle');
model.geom('geom1').feature('r3').set('size', {'120' '50-2.5'});
model.geom('geom1').feature('r3').set('pos', [0 2.5]);
model.geom('geom1').feature('r3').setIndex('layer', '(39-3)/2-2.5', 0);
model.geom('geom1').feature('r3').setIndex('layer', 3, 1);
model.geom('geom1').feature('r3').setIndex('layer', '40-(39+3)/2', 2);
model.geom('geom1').run('r3');
model.geom('geom1').create('r4', 'Rectangle');
model.geom('geom1').feature('r4').set('size', {'120' '50-2.5'});
model.geom('geom1').feature('r4').set('pos', [0 2.5]);
model.geom('geom1').feature('r4').setIndex('layer', 65, 0);
model.geom('geom1').feature('r4').setIndex('layer', 45, 1);
model.geom('geom1').feature('r4').set('layerbottom', false);
model.geom('geom1').feature('r4').set('layerleft', true);
model.geom('geom1').run('r4');
model.geom('geom1').create('r5', 'Rectangle');
model.geom('geom1').feature('r5').set('size', [120 72.5]);
model.geom('geom1').feature('r5').set('pos', [0 -70]);
model.geom('geom1').feature('r5').setIndex('layer', 10, 0);
model.geom('geom1').feature('r5').set('layerright', true);
model.geom('geom1').run('r5');

model.selection.create('sel1', 'Explicit');
model.selection('sel1').model('comp1');

model.geom('geom1').run;

model.selection('sel1').label('Infinite Element Domain');
model.selection('sel1').set([1 6 11 13 14 15 16 17 18]);

model.coordSystem.create('ie1', 'geom1', 'InfiniteElement');
model.coordSystem('ie1').selection.named('sel1');
model.coordSystem('ie1').set('ScalingType', 'Cylindrical');

model.physics('mf').create('als1', 'AmperesLawSolid', 2);
model.physics('mf').feature('als1').selection.set([4]);
model.physics('mf').create('coil1', 'Coil', 2);
model.physics('mf').feature('coil1').selection.set([7]);
model.physics('mf').feature('coil1').setIndex('materialType', 'solid', 0);
model.physics('mf').feature('coil1').set('ConductorModel', 'Multi');
model.physics('mf').feature('coil1').set('ICoil', 'I0*sin(2*pi*f0*t)');
model.physics('mf').feature('coil1').set('N', 'Ni');
model.physics('mf').feature('coil1').set('AreaFrom', 'Diameter');
model.physics('mf').feature('coil1').set('coilWindDiameter', 'd_wire');
model.physics('mf').create('coil2', 'Coil', 2);
model.physics('mf').feature('coil2').selection.set([12]);
model.physics('mf').feature('coil2').setIndex('materialType', 'solid', 0);
model.physics('mf').feature('coil2').set('ConductorModel', 'Multi');
model.physics('mf').feature('coil2').set('ICoil', '-I0*sin(2*pi*f0*t)');
model.physics('mf').feature('coil2').set('N', 'No');
model.physics('mf').feature('coil2').set('AreaFrom', 'Diameter');
model.physics('mf').feature('coil2').set('coilWindDiameter', 'd_wire');
model.physics('mf').create('fcal1', 'ForceCalculation', 2);
model.physics('mf').feature('fcal1').selection.set([4]);

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
model.material('mat1').selection.set([7 12]);
model.material.create('mat2', 'Common', 'comp1');
model.material('mat2').label('Aluminum');
model.material('mat2').selection.set([4]);
model.material('mat2').propertyGroup('def').set('relpermeability', {'1'});
model.material('mat2').propertyGroup('def').set('electricconductivity', {'sigma'});
model.material('mat2').propertyGroup('def').set('relpermittivity', {'1'});

model.variable.create('var1');
model.variable('var1').model('comp1');
model.variable('var1').set('F_g', 'M_disc*g_const');
model.variable('var1').descr('F_g', 'Gravitational force');

model.physics('ge').label('Plate Dynamics');
model.physics('ge').feature('ge1').set('DependentVariableQuantity', 'velocity');
model.physics('ge').feature('ge1').set('SourceTermQuantity', 'acceleration');
model.physics('ge').feature('ge1').setIndex('name', 'v', 0, 0);
model.physics('ge').feature('ge1').setIndex('equation', 'd(v,t)+(F_g-mf.Forcez_0)/M_disc', 0, 0);
model.physics('ge').feature('ge1').setIndex('description', 'Plate velocity', 0, 0);
model.physics('ge').create('ge2', 'GlobalEquations', -1);
model.physics('ge').feature('ge2').set('DependentVariableQuantity', 'displacement');
model.physics('ge').feature('ge2').set('SourceTermQuantity', 'velocity');
model.physics('ge').feature('ge2').setIndex('name', 'u', 0, 0);
model.physics('ge').feature('ge2').setIndex('equation', 'ut-v', 0, 0);
model.physics('ge').feature('ge2').setIndex('initialValueU', 'z0', 0, 0);
model.physics('ge').feature('ge2').setIndex('description', 'Plate position', 0, 0);

model.variable.create('var2');
model.variable('var2').model('comp1');
model.variable('var2').selection.geom('geom1', 2);
model.variable('var2').label('z-Parameterization, Top');
model.variable('var2').selection.set([5 10]);
model.variable('var2').set('s2', '(40[mm]-Z)/(40[mm]-21[mm])');
model.variable.create('var3');
model.variable('var3').model('comp1');
model.variable('var3').label('z-Parameterization, Center');
model.variable('var3').selection.geom('geom1', 2);
model.variable('var3').selection.set([4 9]);
model.variable('var3').set('s2', '1');
model.variable.create('var4');
model.variable('var4').model('comp1');
model.variable('var4').label('z-Parameterization, Bottom');
model.variable('var4').selection.geom('geom1', 2);
model.variable('var4').selection.set([3 8]);
model.variable('var4').set('s2', '(Z-2.5[mm])/(18[mm]-2.5[mm])');
model.variable.create('var5');
model.variable('var5').model('comp1');
model.variable('var5').label('r-Parameterization, Left');
model.variable('var5').selection.geom('geom1', 2);
model.variable('var5').selection.set([3 4 5]);
model.variable('var5').set('s1', '1');
model.variable.create('var6');
model.variable('var6').model('comp1');
model.variable('var6').label('r-Parameterization, Right');
model.variable('var6').selection.geom('geom1', 2);
model.variable('var6').selection.set([8 9 10]);
model.variable('var6').set('s1', '(110[mm]-R)/(110[mm]-65[mm])');

model.common.create('pres1', 'PrescribedDeformation', 'comp1');
model.common('pres1').selection.all;
model.common('pres1').selection.set([3 4 5 8 9 10]);
model.common('pres1').set('prescribedDeformation', {'0' '0' '(u-18[mm])*s1*s2'});

model.study('std1').feature('time').set('tlist', 'range(0,0.01,1.7)');
model.study('std1').feature('time').set('usertol', true);
model.study('std1').feature('time').set('rtol', 0.001);

model.probe.create('var1', 'GlobalVariable');
model.probe('var1').model('comp1');
model.probe('var1').set('expr', 'u');
model.probe('var1').set('descr', 'Plate position');
model.probe('var1').set('descractive', true);
model.probe('var1').set('descr', 'Plate displacement');
model.probe.create('var2', 'GlobalVariable');
model.probe('var2').model('comp1');
model.probe('var2').set('expr', 'mf.Forcez_0');
model.probe('var2').set('descractive', true);
model.probe('var2').set('table', 'new');
model.probe('var2').set('window', 'new');

model.sol.create('sol1');
model.sol('sol1').study('std1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'time');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').set('control', 'time');
model.sol('sol1').create('t1', 'Time');
model.sol('sol1').feature('t1').set('tlist', 'range(0,0.01,1.7)');
model.sol('sol1').feature('t1').set('plot', 'off');
model.sol('sol1').feature('t1').set('plotgroup', 'Default');
model.sol('sol1').feature('t1').set('plotfreq', 'tout');
model.sol('sol1').feature('t1').set('probesel', 'all');
model.sol('sol1').feature('t1').set('probes', {'var1' 'var2'});
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

model.result.dataset('dset1').set('frametype', 'material');
model.result.dataset('dset1').selection.geom('geom1', 2);
model.result.dataset('dset1').selection.geom('geom1', 2);
model.result.dataset('dset1').selection.set([3 4 5 8 9 10]);
model.result.create('pg1', 'PlotGroup2D');
model.result('pg1').run;
model.result('pg1').set('frametype', 'material');
model.result('pg1').create('mesh1', 'Mesh');
model.result('pg1').feature('mesh1').set('colortable', 'TrafficFlow');
model.result('pg1').feature('mesh1').set('colortabletrans', 'nonlinear');
model.result('pg1').feature('mesh1').set('nonlinearcolortablerev', true);
model.result('pg1').feature('mesh1').set('elemcolor', 'none');
model.result('pg1').feature('mesh1').set('wireframecolor', 'white');
model.result('pg1').run;
model.result('pg1').create('surf1', 'Surface');
model.result('pg1').feature('surf1').set('expr', 's1*s2');

model.probe('var1').genResult('none');
model.probe('var2').genResult('none');

model.sol('sol1').run('v1');

model.result('pg1').run;
model.result('pg1').run;
model.result.dataset('dset1').set('frametype', 'spatial');
model.result('pg1').run;
model.result('pg1').set('frametype', 'spatial');
model.result('pg1').run;
model.result('pg1').feature('surf1').set('expr', 'pres1.dz');

model.study('std1').feature('time').set('plot', true);

model.sol('sol1').study('std1');
model.sol('sol1').feature.remove('t1');
model.sol('sol1').feature.remove('v1');
model.sol('sol1').feature.remove('st1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'time');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').set('control', 'time');
model.sol('sol1').create('t1', 'Time');
model.sol('sol1').feature('t1').set('tlist', 'range(0,0.01,1.7)');
model.sol('sol1').feature('t1').set('plot', 'on');
model.sol('sol1').feature('t1').set('plotgroup', 'pg1');
model.sol('sol1').feature('t1').set('plotfreq', 'tout');
model.sol('sol1').feature('t1').set('probesel', 'all');
model.sol('sol1').feature('t1').set('probes', {'var1' 'var2'});
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

model.probe('var1').genResult('none');
model.probe('var2').genResult('none');

model.sol('sol1').runAll;

model.result('pg1').run;
model.result('pg1').setIndex('looplevel', 17, 0);
model.result('pg1').run;
model.result('pg3').set('window', 'window2');
model.result('pg3').set('windowtitle', 'Probe Plot 2');
model.result('pg3').run;
model.result('pg3').label('Electromagnetic Force, z-component');
model.result('pg3').set('titletype', 'manual');
model.result('pg3').set('title', 'Electromagnetic Force, z-component (N)');
model.result('pg3').set('ylabelactive', true);
model.result('pg3').set('ylabel', '');
model.result('pg3').set('window', 'window2');
model.result('pg3').set('windowtitle', 'Probe Plot 2');
model.result('pg3').run;
model.result.dataset.duplicate('dset3', 'dset1');
model.result.dataset('dset3').selection.geom('geom1', 2);
model.result.dataset('dset3').selection.set([2 3 4 5 7 8 9 10 12]);
model.result.create('pg4', 'PlotGroup2D');
model.result('pg4').run;
model.result('pg4').set('data', 'dset3');
model.result('pg4').create('surf1', 'Surface');
model.result('pg4').run;
model.result('pg4').create('con1', 'Contour');
model.result('pg4').feature('con1').set('expr', 'mf.Aphi');
model.result('pg4').feature('con1').set('descr', 'Magnetic vector potential, phi-component');
model.result('pg4').feature('con1').set('expr', 'mf.Aphi*r');
model.result('pg4').feature('con1').set('coloring', 'uniform');
model.result('pg4').feature('con1').set('color', 'white');
model.result('pg4').feature('con1').set('colorlegend', false);
model.result('pg4').run;
model.result('pg4').label('Magnetic Flux Density');
model.result('pg4').setIndex('looplevel', 2, 0);
model.result('pg4').set('titletype', 'manual');
model.result('pg4').set('title', 'Magnetic flux density norm (T) and streamlines at time=0.01 s');
model.result('pg4').set('paramindicator', '');
model.result('pg4').run;
model.result.table.create('tbl3', 'Table');
model.result.table('tbl3').label('Experimental Data');
model.result.table('tbl3').importData('electrodynamic_levitation_device_data.txt');
model.result('pg2').set('window', 'window1');
model.result('pg2').run;
model.result('pg2').label('Plate Dynamics Comparison');
model.result('pg2').set('titletype', 'manual');
model.result('pg2').set('title', 'Axial Plate Displacement (mm)');
model.result('pg2').set('xlabelactive', true);
model.result('pg2').set('window', 'window1');
model.result('pg2').run;
model.result('pg2').feature('tblp1').set('legendmethod', 'manual');
model.result('pg2').feature('tblp1').setIndex('legends', 'Computed', 0);
model.result('pg2').set('window', 'window1');
model.result('pg2').run;
model.result('pg2').create('tblp2', 'Table');
model.result('pg2').feature('tblp2').set('markerpos', 'datapoints');
model.result('pg2').feature('tblp2').set('linewidth', 'preference');
model.result('pg2').feature('tblp2').set('table', 'tbl3');
model.result('pg2').feature('tblp2').set('linemarker', 'cycle');
model.result('pg2').feature('tblp2').set('linestyle', 'none');
model.result('pg2').feature('tblp2').set('legend', true);
model.result('pg2').feature('tblp2').set('legendmethod', 'manual');
model.result('pg2').feature('tblp2').setIndex('legends', 'Experimental', 0);
model.result('pg2').set('window', 'window1');
model.result('pg2').run;
model.result.dataset.duplicate('dset4', 'dset3');
model.result.dataset('dset4').selection.geom('geom1', 2);
model.result.dataset('dset4').selection.set([4 7 12]);
model.result.dataset.create('rev1', 'Revolve2D');
model.result.dataset('rev1').set('data', 'dset4');
model.result.dataset('rev1').set('startangle', -90);
model.result.dataset('rev1').set('revangle', 240);
model.result.dataset('rev1').set('startangle', 0);
model.result.dataset('rev1').set('revangle', 360);
model.result.create('pg5', 'PlotGroup3D');
model.result('pg5').run;
model.result('pg5').create('vol1', 'Volume');
model.result('pg5').feature('vol1').set('expr', 'mf.Jphi');
model.result('pg5').feature('vol1').set('descr', 'Current density, phi-component');
model.result('pg5').run;
model.result('pg5').label('Current Density');
model.result('pg5').set('frametype', 'spatial');
model.result('pg5').run;
model.result.export.create('anim1', 'Animation');
model.result.export('anim1').set('target', 'player');
model.result.export('anim1').set('fontsize', '9');
model.result.export('anim1').set('colortheme', 'globaltheme');
model.result.export('anim1').set('customcolor', [1 1 1]);
model.result.export('anim1').set('background', 'color');
model.result.export('anim1').set('gltfincludelines', 'on');
model.result.export('anim1').set('title1d', 'on');
model.result.export('anim1').set('legend1d', 'on');
model.result.export('anim1').set('logo1d', 'on');
model.result.export('anim1').set('options1d', 'on');
model.result.export('anim1').set('title2d', 'on');
model.result.export('anim1').set('legend2d', 'on');
model.result.export('anim1').set('logo2d', 'on');
model.result.export('anim1').set('options2d', 'off');
model.result.export('anim1').set('title3d', 'on');
model.result.export('anim1').set('legend3d', 'on');
model.result.export('anim1').set('logo3d', 'on');
model.result.export('anim1').set('options3d', 'off');
model.result.export('anim1').set('axisorientation', 'on');
model.result.export('anim1').set('grid', 'on');
model.result.export('anim1').set('axes1d', 'on');
model.result.export('anim1').set('axes2d', 'on');
model.result.export('anim1').set('showgrid', 'on');
model.result.export('anim1').showFrame;
model.result.export('anim1').set('plotgroup', 'pg5');
model.result.export('anim1').set('looplevelinput', 'manual');
model.result.export('anim1').set('looplevel', [1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40 41 42 43 44 45 46 47 48 49 50 51 52 53 54 55 56 57 58 59 60 61 62 63 64 65 66 67 68 69 70 71 72 73 74 75 76 77 78 79 80 81 82 83 84 85 86 87 88 89 90 91 92 93 94 95 96 97 98 99 100 101 102 103 104 105 106 107 108 109 110 111 112 113 114 115 116 117 118 119 120 121]);
model.result.export('anim1').set('maxframes', 50);
model.result('pg5').run;

model.title('An Electrodynamic Levitation Device');

model.description('This model presents a solution to Testing Electromagnetic Analysis Methods (TEAM) workshop problem 28, "An Electrodynamic Levitation Device". It is a benchmark problem involving the dynamic coupling of electromagnetics and rigid body dynamics. An electrodynamic levitation force is produced by the induced eddy currents when a conductive disk is placed above two concentric coils carrying time-varying currents in opposite directions. The dynamics of the levitating disk is solved and compared with measured data from the literature.');

model.mesh.clearMeshes;

model.sol('sol1').clearSolutionData;

model.label('electrodynamic_levitation_device.mph');

model.modelNode.label('Components');

out = model;
