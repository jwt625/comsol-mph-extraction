function out = model
%
% circuit_fem_resistor.m
%
% Model exported on May 26 2025, 21:24 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/ACDC_Module/Electromagnetics_and_Circuits');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 3);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.physics.create('ec', 'ConductiveMedia', 'geom1');
model.physics('ec').model('comp1');
model.physics.create('cir', 'Circuit', 'geom1');
model.physics('cir').model('comp1');

model.study.create('std1');
model.study('std1').create('stat', 'Stationary');
model.study('std1').feature('stat').setSolveFor('/physics/ec', true);
model.study('std1').feature('stat').setSolveFor('/physics/cir', true);

model.param.set('sigma', '1e3[S/m]');
model.param.set('R1', ['1[' 'ohm' ']']);
model.param.set('R2', ['1[' 'ohm' ']']);
model.param.set('L', '5[mm]');
model.param.set('r', '1[mm]');

model.geom('geom1').lengthUnit('mm');
model.geom('geom1').create('cyl1', 'Cylinder');
model.geom('geom1').feature('cyl1').set('r', 'r');
model.geom('geom1').feature('cyl1').set('h', 'L');
model.geom('geom1').run;

model.material.create('mat1', 'Common', 'comp1');
model.material('mat1').propertyGroup('def').set('electricconductivity', {'sigma'});
model.material('mat1').propertyGroup('def').set('relpermittivity', {'1'});

model.physics('ec').create('term1', 'Terminal', 2);
model.physics('ec').feature('term1').selection.set([4]);
model.physics('ec').feature('term1').set('TerminalType', 'Circuit');
model.physics('ec').create('term2', 'Terminal', 2);
model.physics('ec').feature('term2').selection.set([3]);
model.physics('ec').feature('term2').set('TerminalType', 'Circuit');
model.physics('cir').create('R1', 'Resistor', -1);
model.physics('cir').feature('R1').setIndex('Connections', 0, 1, 0);
model.physics('cir').feature('R1').set('R', 'R1');
model.physics('cir').create('termI1', 'ModelTerminalIV', -1);
model.physics('cir').feature('termI1').set('V_src', 'root.comp1.ec.V0_1');
model.physics('cir').feature('termI1').set('Connections', 1);
model.physics('cir').create('termI2', 'ModelTerminalIV', -1);
model.physics('cir').feature('termI2').set('V_src', 'root.comp1.ec.V0_2');
model.physics('cir').create('R2', 'Resistor', -1);
model.physics('cir').feature('R2').setIndex('Connections', 2, 1, 0);
model.physics('cir').feature('R2').set('R', 'R2');
model.physics('cir').create('V1', 'VoltageSource', -1);
model.physics('cir').feature('V1').setIndex('Connections', 3, 0, 0);
model.physics('cir').feature('V1').setIndex('Connections', 0, 1, 0);

model.modelNode.create('comp2', true);

model.geom.create('geom2', 3);
model.geom('geom2').model('comp2');

model.mesh.create('mesh2', 'geom2');

model.geom('geom2').lengthUnit('mm');
model.geom('geom2').create('cyl1', 'Cylinder');
model.geom('geom2').feature('cyl1').set('r', 'r');
model.geom('geom2').feature('cyl1').set('h', 'L');

model.physics.create('ec2', 'ConductiveMedia', 'geom2');
model.physics('ec2').model('comp2');

model.study('std1').feature('stat').setSolveFor('/physics/ec2', true);

model.geom('geom2').run;

model.physics.create('cir2', 'Circuit', 'geom2');
model.physics('cir2').model('comp2');

model.study('std1').feature('stat').setSolveFor('/physics/cir2', true);

model.material.create('mat2', 'Common', 'comp2');
model.material('mat2').propertyGroup('def').set('electricconductivity', {'sigma'});
model.material('mat2').propertyGroup('def').set('relpermittivity', {'1'});

model.physics('ec2').create('term1', 'Terminal', 2);
model.physics('ec2').feature('term1').selection.set([4]);
model.physics('ec2').feature('term1').set('TerminalType', 'Circuit');
model.physics('ec2').create('gnd1', 'Ground', 2);
model.physics('ec2').feature('gnd1').selection.set([3]);
model.physics('cir2').create('R1', 'Resistor', -1);
model.physics('cir2').feature('R1').setIndex('Connections', 0, 1, 0);
model.physics('cir2').feature('R1').set('R', 'R1');
model.physics('cir2').create('IvsU1', 'ModelDeviceIV', -1);
model.physics('cir2').feature('IvsU1').setIndex('Connections', 1, 0, 0);
model.physics('cir2').feature('IvsU1').setIndex('Connections', 2, 1, 0);
model.physics('cir2').feature('IvsU1').set('V_src', 'root.comp2.ec2.V0_1');
model.physics('cir2').create('R2', 'Resistor', -1);
model.physics('cir2').feature('R2').setIndex('Connections', 2, 1, 0);
model.physics('cir2').feature('R2').set('R', 'R2');
model.physics('cir2').create('V1', 'VoltageSource', -1);
model.physics('cir2').feature('V1').setIndex('Connections', 3, 0, 0);
model.physics('cir2').feature('V1').setIndex('Connections', 0, 1, 0);

model.sol.create('sol1');
model.sol('sol1').study('std1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'stat');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').set('control', 'stat');
model.sol('sol1').create('s1', 'Stationary');
model.sol('sol1').feature('s1').create('iDef', 'Iterative');
model.sol('sol1').feature('s1').create('seDef', 'Segregated');
model.sol('sol1').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('s1').create('d1', 'Direct');
model.sol('sol1').feature('s1').feature('d1').label('Direct (Merged)');
model.sol('sol1').feature('s1').feature('fc1').set('linsolver', 'd1');
model.sol('sol1').feature('s1').feature.remove('fcDef');
model.sol('sol1').feature('s1').feature.remove('seDef');
model.sol('sol1').feature('s1').feature.remove('iDef');
model.sol('sol1').attach('std1');
model.sol('sol1').runAll;

model.result.create('pg1', 'PlotGroup3D');
model.result('pg1').label('Electric Potential (ec)');
model.result('pg1').set('frametype', 'spatial');
model.result('pg1').set('showlegendsmaxmin', true);
model.result('pg1').set('data', 'dset1');
model.result('pg1').set('defaultPlotID', 'InterfaceComponents/PlotDefaults/icom2/pdef1/pcond2/pcond1/pcond2/pg1');
model.result('pg1').feature.create('vol1', 'Volume');
model.result('pg1').feature('vol1').set('showsolutionparams', 'on');
model.result('pg1').feature('vol1').set('solutionparams', 'parent');
model.result('pg1').feature('vol1').set('colortable', 'Dipole');
model.result('pg1').feature('vol1').set('showsolutionparams', 'on');
model.result('pg1').feature('vol1').set('data', 'parent');
model.result.create('pg2', 'PlotGroup3D');
model.result('pg2').label('Electric Field Norm (ec)');
model.result('pg2').set('frametype', 'spatial');
model.result('pg2').set('showlegendsmaxmin', true);
model.result('pg2').set('data', 'dset1');
model.result('pg2').set('defaultPlotID', 'InterfaceComponents/PlotDefaults/icom3/pdef1/pcond2/pcond1/pg1');
model.result('pg2').feature.create('mslc1', 'Multislice');
model.result('pg2').feature('mslc1').set('showsolutionparams', 'on');
model.result('pg2').feature('mslc1').set('solutionparams', 'parent');
model.result('pg2').feature('mslc1').set('expr', 'ec.normE');
model.result('pg2').feature('mslc1').set('multiplanexmethod', 'coord');
model.result('pg2').feature('mslc1').set('xcoord', 'ec.CPx');
model.result('pg2').feature('mslc1').set('multiplaneymethod', 'coord');
model.result('pg2').feature('mslc1').set('ycoord', 'ec.CPy');
model.result('pg2').feature('mslc1').set('multiplanezmethod', 'coord');
model.result('pg2').feature('mslc1').set('zcoord', 'ec.CPz');
model.result('pg2').feature('mslc1').set('colortable', 'Prism');
model.result('pg2').feature('mslc1').set('colortabletrans', 'nonlinear');
model.result('pg2').feature('mslc1').set('colorcalibration', -0.8);
model.result('pg2').feature('mslc1').set('showsolutionparams', 'on');
model.result('pg2').feature('mslc1').set('data', 'parent');
model.result('pg2').feature.create('strmsl1', 'StreamlineMultislice');
model.result('pg2').feature('strmsl1').set('showsolutionparams', 'on');
model.result('pg2').feature('strmsl1').set('solutionparams', 'parent');
model.result('pg2').feature('strmsl1').set('expr', {'ec.Ex' 'ec.Ey' 'ec.Ez'});
model.result('pg2').feature('strmsl1').set('multiplanexmethod', 'coord');
model.result('pg2').feature('strmsl1').set('xcoord', 'ec.CPx');
model.result('pg2').feature('strmsl1').set('multiplaneymethod', 'coord');
model.result('pg2').feature('strmsl1').set('ycoord', 'ec.CPy');
model.result('pg2').feature('strmsl1').set('multiplanezmethod', 'coord');
model.result('pg2').feature('strmsl1').set('zcoord', 'ec.CPz');
model.result('pg2').feature('strmsl1').set('titletype', 'none');
model.result('pg2').feature('strmsl1').set('posmethod', 'uniform');
model.result('pg2').feature('strmsl1').set('udist', 0.02);
model.result('pg2').feature('strmsl1').set('maxlen', 0.4);
model.result('pg2').feature('strmsl1').set('maxtime', Inf);
model.result('pg2').feature('strmsl1').set('inheritcolor', false);
model.result('pg2').feature('strmsl1').set('showsolutionparams', 'on');
model.result('pg2').feature('strmsl1').set('maxtime', Inf);
model.result('pg2').feature('strmsl1').set('showsolutionparams', 'on');
model.result('pg2').feature('strmsl1').set('maxtime', Inf);
model.result('pg2').feature('strmsl1').set('showsolutionparams', 'on');
model.result('pg2').feature('strmsl1').set('maxtime', Inf);
model.result('pg2').feature('strmsl1').set('showsolutionparams', 'on');
model.result('pg2').feature('strmsl1').set('maxtime', Inf);
model.result('pg2').feature('strmsl1').set('data', 'parent');
model.result('pg2').feature('strmsl1').set('inheritplot', 'mslc1');
model.result('pg2').feature('strmsl1').feature.create('col1', 'Color');
model.result('pg2').feature('strmsl1').feature('col1').set('expr', 'ec.normE');
model.result('pg2').feature('strmsl1').feature('col1').set('colortable', 'PrismDark');
model.result('pg2').feature('strmsl1').feature('col1').set('colorlegend', false);
model.result('pg2').feature('strmsl1').feature('col1').set('colortabletrans', 'nonlinear');
model.result('pg2').feature('strmsl1').feature('col1').set('colorcalibration', -0.8);
model.result('pg2').feature('strmsl1').feature.create('filt1', 'Filter');
model.result('pg2').feature('strmsl1').feature('filt1').set('expr', '!isScalingSystemDomain');
model.result.create('pg3', 'PlotGroup3D');
model.result('pg3').label('Electric Potential (ec2)');
model.result('pg3').set('data', 'dset2');
model.result('pg3').set('frametype', 'spatial');
model.result('pg3').set('showlegendsmaxmin', true);
model.result('pg3').set('data', 'dset2');
model.result('pg3').set('defaultPlotID', 'InterfaceComponents/PlotDefaults/icom2/pdef1/pcond2/pcond1/pcond2/pg1');
model.result('pg3').feature.create('vol1', 'Volume');
model.result('pg3').feature('vol1').set('showsolutionparams', 'on');
model.result('pg3').feature('vol1').set('solutionparams', 'parent');
model.result('pg3').feature('vol1').set('colortable', 'Dipole');
model.result('pg3').feature('vol1').set('showsolutionparams', 'on');
model.result('pg3').feature('vol1').set('data', 'parent');
model.result.create('pg4', 'PlotGroup3D');
model.result('pg4').label('Electric Field Norm (ec2)');
model.result('pg4').set('data', 'dset2');
model.result('pg4').set('frametype', 'spatial');
model.result('pg4').set('showlegendsmaxmin', true);
model.result('pg4').set('data', 'dset2');
model.result('pg4').set('defaultPlotID', 'InterfaceComponents/PlotDefaults/icom3/pdef1/pcond2/pcond1/pg1');
model.result('pg4').feature.create('mslc1', 'Multislice');
model.result('pg4').feature('mslc1').set('showsolutionparams', 'on');
model.result('pg4').feature('mslc1').set('solutionparams', 'parent');
model.result('pg4').feature('mslc1').set('expr', 'ec2.normE');
model.result('pg4').feature('mslc1').set('multiplanexmethod', 'coord');
model.result('pg4').feature('mslc1').set('xcoord', 'ec2.CPx');
model.result('pg4').feature('mslc1').set('multiplaneymethod', 'coord');
model.result('pg4').feature('mslc1').set('ycoord', 'ec2.CPy');
model.result('pg4').feature('mslc1').set('multiplanezmethod', 'coord');
model.result('pg4').feature('mslc1').set('zcoord', 'ec2.CPz');
model.result('pg4').feature('mslc1').set('colortable', 'Prism');
model.result('pg4').feature('mslc1').set('colortabletrans', 'nonlinear');
model.result('pg4').feature('mslc1').set('colorcalibration', -0.8);
model.result('pg4').feature('mslc1').set('showsolutionparams', 'on');
model.result('pg4').feature('mslc1').set('data', 'parent');
model.result('pg4').feature.create('strmsl1', 'StreamlineMultislice');
model.result('pg4').feature('strmsl1').set('showsolutionparams', 'on');
model.result('pg4').feature('strmsl1').set('solutionparams', 'parent');
model.result('pg4').feature('strmsl1').set('expr', {'ec2.Ex' 'ec2.Ey' 'ec2.Ez'});
model.result('pg4').feature('strmsl1').set('multiplanexmethod', 'coord');
model.result('pg4').feature('strmsl1').set('xcoord', 'ec2.CPx');
model.result('pg4').feature('strmsl1').set('multiplaneymethod', 'coord');
model.result('pg4').feature('strmsl1').set('ycoord', 'ec2.CPy');
model.result('pg4').feature('strmsl1').set('multiplanezmethod', 'coord');
model.result('pg4').feature('strmsl1').set('zcoord', 'ec2.CPz');
model.result('pg4').feature('strmsl1').set('titletype', 'none');
model.result('pg4').feature('strmsl1').set('posmethod', 'uniform');
model.result('pg4').feature('strmsl1').set('udist', 0.02);
model.result('pg4').feature('strmsl1').set('maxlen', 0.4);
model.result('pg4').feature('strmsl1').set('maxtime', Inf);
model.result('pg4').feature('strmsl1').set('inheritcolor', false);
model.result('pg4').feature('strmsl1').set('showsolutionparams', 'on');
model.result('pg4').feature('strmsl1').set('maxtime', Inf);
model.result('pg4').feature('strmsl1').set('showsolutionparams', 'on');
model.result('pg4').feature('strmsl1').set('maxtime', Inf);
model.result('pg4').feature('strmsl1').set('showsolutionparams', 'on');
model.result('pg4').feature('strmsl1').set('maxtime', Inf);
model.result('pg4').feature('strmsl1').set('showsolutionparams', 'on');
model.result('pg4').feature('strmsl1').set('maxtime', Inf);
model.result('pg4').feature('strmsl1').set('data', 'parent');
model.result('pg4').feature('strmsl1').set('inheritplot', 'mslc1');
model.result('pg4').feature('strmsl1').feature.create('col1', 'Color');
model.result('pg4').feature('strmsl1').feature('col1').set('expr', 'ec2.normE');
model.result('pg4').feature('strmsl1').feature('col1').set('colortable', 'PrismDark');
model.result('pg4').feature('strmsl1').feature('col1').set('colorlegend', false);
model.result('pg4').feature('strmsl1').feature('col1').set('colortabletrans', 'nonlinear');
model.result('pg4').feature('strmsl1').feature('col1').set('colorcalibration', -0.8);
model.result('pg4').feature('strmsl1').feature.create('filt1', 'Filter');
model.result('pg4').feature('strmsl1').feature('filt1').set('expr', '!isScalingSystemDomain');
model.result('pg1').run;
model.result('pg1').create('arws1', 'ArrowSurface');
model.result('pg1').feature('arws1').set('color', 'black');
model.result('pg1').run;
model.result('pg1').run;
model.result('pg3').run;
model.result('pg3').create('arws1', 'ArrowSurface');
model.result('pg3').feature('arws1').set('color', 'black');
model.result('pg3').run;
model.result('pg3').run;
model.result.numerical.create('gev1', 'EvalGlobal');
model.result.numerical('gev1').setIndex('expr', 'cir.v_0', 0);
model.result.numerical('gev1').setIndex('expr', 'cir.v_1', 1);
model.result.numerical('gev1').setIndex('expr', 'cir.v_2', 2);
model.result.numerical('gev1').setIndex('expr', 'cir.v_3', 3);
model.result.numerical('gev1').setIndex('expr', 'comp2.cir2.v_0', 4);
model.result.numerical('gev1').setIndex('expr', 'comp2.cir2.v_1', 5);
model.result.numerical('gev1').setIndex('expr', 'comp2.cir2.v_2', 6);
model.result.numerical('gev1').setIndex('expr', 'comp2.cir2.v_3', 7);
model.result.table.create('tbl1', 'Table');
model.result.table('tbl1').comments('Global Evaluation 1');
model.result.numerical('gev1').set('table', 'tbl1');
model.result.numerical('gev1').setResult;
model.result.numerical.create('gev2', 'EvalGlobal');
model.result.numerical('gev2').setIndex('expr', '((cir.v_2-cir.v_1)/cir.R1_v)*R1', 0);
model.result.numerical('gev2').setIndex('expr', '((comp2.cir2.v_2-comp2.cir2.v_1)/comp2.cir2.R1_v)*R1', 1);
model.result.numerical('gev2').setIndex('expr', 'L/(pi*r^2*sigma)', 2);
model.result.table.create('tbl2', 'Table');
model.result.table('tbl2').comments('Global Evaluation 2');
model.result.numerical('gev2').set('table', 'tbl2');
model.result.numerical('gev2').setResult;
model.result('pg2').run;
model.result.remove('pg2');
model.result('pg3').run;
model.result('pg4').run;
model.result.remove('pg4');
model.result('pg1').run;

model.title('FEM Resistor in Circuit');

model.description('This introductory model illustrates two different ways to couple an electrical circuit model to a finite element simulation. In this case, the finite element part represents a cylindrical resistor in the circuit. The FEM model will be coupled to the circuit by either using two External I-Terminal features or by using an External I vs. U feature. Differences between the two approaches will then be highlighted.');

model.mesh.clearMeshes;

model.sol('sol1').clearSolutionData;

model.label('circuit_fem_resistor.mph');

model.modelNode.label('Components');

out = model;
